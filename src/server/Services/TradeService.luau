--!strict
-- Échanges entre deux joueurs du même serveur.
-- Flux : demande -> acceptation -> offres (8 dinos max + Ambre/Os) -> « Prêt » des deux -> 5 s ->
-- « Confirmer » des deux -> exécution en UNE étape sans yield, puis sauvegarde immédiate des deux profils.
-- Toute modification d'offre remet « Prêt » et « Confirmer » à zéro. Les dinos proposés sont gelés.
-- Conditions : 1 000 lancers chacun et IsPaidItemTradingAllowed pour les deux (PolicyService).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Economy = require(Shared.Config.Economy)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)
local PolicyService = require(script.Parent.PolicyService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)
local TradeLogic = require(script.Parent.Parent.Data.TradeLogic)

local REQUEST_INTERVAL = 10
local REQUEST_TIMEOUT = 30
local COUNTDOWN_SECONDS = 5
local ACTION_INTERVAL = 0.2

type Trade = {
	a: Player,
	b: Player,
	offers: { [Player]: TradeLogic.Offer },
	ready: { [Player]: boolean },
	confirmed: { [Player]: boolean },
	phase: "offer" | "countdown" | "confirm",
	countdownEndsAt: number?,
	version: number, -- augmente à chaque changement : un compte à rebours périmé ne fait rien
	done: boolean,
}

local trades: { [Player]: Trade } = {}
local pending: { [Player]: { [Player]: number } } = {} -- cible -> demandeur -> heure de la demande
local requestLimiter = RateLimit.new()
local actionLimiter = RateLimit.new()

local TradeService = {}

local function other(trade: Trade, player: Player): Player
	return if trade.a == player then trade.b else trade.a
end

-- Raison du refus, ou nil si ce joueur peut échanger.
local function cannotTrade(player: Player): string?
	local data = DataService:GetLoaded(player)
	if not data then
		return "Profil pas encore chargé."
	end
	if not PolicyService:CanTradePaidItems(player) then
		return "L'échange n'est pas disponible pour ce compte."
	end
	if data.TotalRolls < Economy.Social.tradeUnlockRolls then
		return `L'échange se débloque après {Economy.Social.tradeUnlockRolls} lancers.`
	end
	return nil
end

local function side(trade: Trade, player: Player): Types.TradeSide
	local data = DataService:GetLoaded(player)
	local offer = trade.offers[player]
	local dinos: { [string]: Types.DinoInstance } = {}
	for _, uuid in offer.uuids do
		if data and data.Dinos[uuid] then
			dinos[uuid] = data.Dinos[uuid]
		end
	end
	return {
		userId = player.UserId,
		name = player.DisplayName,
		dinos = dinos,
		amber = offer.amber,
		bones = offer.bones,
		ready = trade.ready[player] == true,
		confirmed = trade.confirmed[player] == true,
	}
end

local function broadcast(trade: Trade)
	for _, player in { trade.a, trade.b } do
		local state: Types.TradeState = {
			phase = trade.phase,
			countdownEndsAt = trade.countdownEndsAt,
			you = side(trade, player),
			them = side(trade, other(trade, player)),
		}
		Remotes.TradeState:FireClient(player, state)
	end
end

local function unfreeze(trade: Trade)
	for player, offer in trade.offers do
		for _, uuid in offer.uuids do
			InventoryService:SetFrozen(player, uuid, false)
		end
	end
end

local function finish(trade: Trade, reason: string)
	if trade.done then
		return
	end
	trade.done = true
	unfreeze(trade)
	for _, player in { trade.a, trade.b } do
		if trades[player] == trade then
			trades[player] = nil
		end
		if player.Parent == Players then
			Remotes.TradeState:FireClient(player, nil, reason)
		end
	end
end

local function resetAgreement(trade: Trade)
	trade.ready = {}
	trade.confirmed = {}
	trade.phase = "offer"
	trade.countdownEndsAt = nil
	trade.version += 1
end

-- Exécution : tout est revérifié, puis appliqué sans aucun yield, puis sauvegardé.
local function execute(trade: Trade)
	local a, b = trade.a, trade.b
	local dataA, dataB = DataService:GetLoaded(a), DataService:GetLoaded(b)
	local offerA, offerB = trade.offers[a], trade.offers[b]
	if
		not dataA
		or not dataB
		or cannotTrade(a)
		or cannotTrade(b)
		or not TradeLogic.stillValid(dataA, offerA)
		or not TradeLogic.stillValid(dataB, offerB)
	then
		finish(trade, "Échange annulé : une offre n'est plus valable.")
		return
	end

	trade.done = true -- plus aucune action ne peut toucher cet échange
	unfreeze(trade)
	local writes = TradeLogic.plan(dataA, dataB, offerA, offerB, a.UserId, b.UserId, os.time())
	for _, write in writes do
		DataService:Update(if write.side == "a" then a else b, write.path, function()
			return write.value
		end)
	end
	trades[a], trades[b] = nil, nil

	DataService:SaveNow(a)
	DataService:SaveNow(b)
	for _, player in { a, b } do
		Remotes.TradeState:FireClient(player, nil, "Échange réussi !")
	end
end

local function startCountdown(trade: Trade)
	trade.phase = "countdown"
	trade.countdownEndsAt = Workspace:GetServerTimeNow() + COUNTDOWN_SECONDS
	trade.version += 1
	local version = trade.version
	broadcast(trade)
	task.delay(COUNTDOWN_SECONDS, function()
		if not trade.done and trade.version == version then
			trade.phase = "confirm"
			broadcast(trade)
		end
	end)
end

local function onRequest(player: Player, targetUserId: any)
	if type(targetUserId) ~= "number" or not requestLimiter:allow(player, REQUEST_INTERVAL) then
		return
	end
	local target = Players:GetPlayerByUserId(targetUserId)
	if not target or target == player or trades[player] or trades[target] then
		return
	end
	local reason = cannotTrade(player)
		or (if cannotTrade(target) then `{target.DisplayName} ne peut pas échanger.` else nil)
	if reason then
		Remotes.Notify:FireClient(player, reason, "error")
		return
	end
	pending[target] = pending[target] or {}
	pending[target][player] = os.clock()
	Remotes.TradeInvite:FireClient(target, player.UserId, player.DisplayName)
	task.delay(REQUEST_TIMEOUT, function()
		local list = pending[target]
		if list and list[player] and os.clock() - list[player] >= REQUEST_TIMEOUT then
			list[player] = nil -- refus automatique
		end
	end)
end

local function onRespond(player: Player, fromUserId: any, accept: any)
	if type(fromUserId) ~= "number" then
		return
	end
	local from = Players:GetPlayerByUserId(fromUserId)
	local list = pending[player]
	if not from or not list or not list[from] then
		return
	end
	list[from] = nil
	if accept ~= true then
		Remotes.Notify:FireClient(from, `{player.DisplayName} a refusé l'échange.`, "info")
		return
	end
	if trades[player] or trades[from] or cannotTrade(player) or cannotTrade(from) then
		return
	end
	local trade: Trade = {
		a = from,
		b = player,
		offers = { [from] = TradeLogic.emptyOffer(), [player] = TradeLogic.emptyOffer() },
		ready = {},
		confirmed = {},
		phase = "offer",
		version = 0,
		done = false,
	}
	trades[from], trades[player] = trade, trade
	broadcast(trade)
end

local function onSetOffer(player: Player, raw: any)
	local trade = trades[player]
	local data = DataService:GetLoaded(player)
	if not trade or trade.done or not data then
		return
	end
	local offer, reason = TradeLogic.sanitize(data, raw, function(uuid)
		-- Gelé par un autre échange : impossible, un joueur n'a qu'un échange ; sert de garde-fou.
		return InventoryService:IsFrozen(player, uuid) and not table.find(trade.offers[player].uuids, uuid)
	end)
	if not offer then
		Remotes.Notify:FireClient(player, reason or "Offre invalide.", "error")
		return
	end
	for _, uuid in trade.offers[player].uuids do
		InventoryService:SetFrozen(player, uuid, false)
	end
	for _, uuid in offer.uuids do
		InventoryService:SetFrozen(player, uuid, true)
	end
	trade.offers[player] = offer
	resetAgreement(trade)
	broadcast(trade)
end

local function onSetReady(player: Player, ready: any)
	local trade = trades[player]
	if not trade or trade.done or trade.phase ~= "offer" or type(ready) ~= "boolean" then
		return
	end
	trade.ready[player] = ready
	if trade.ready[trade.a] and trade.ready[trade.b] then
		startCountdown(trade)
	else
		broadcast(trade)
	end
end

local function onConfirm(player: Player)
	local trade = trades[player]
	if not trade or trade.done or trade.phase ~= "confirm" or trade.confirmed[player] then
		return -- une double confirmation est ignorée
	end
	trade.confirmed[player] = true
	if trade.confirmed[trade.a] and trade.confirmed[trade.b] then
		execute(trade)
	else
		broadcast(trade)
	end
end

local function guarded(handler: (Player, ...any) -> ())
	return function(player: Player, ...)
		if actionLimiter:allow(player, ACTION_INTERVAL) then
			handler(player, ...)
		end
	end
end

function TradeService:Init()
	Remotes.TradeRequest.OnServerEvent:Connect(onRequest)
	Remotes.TradeRespond.OnServerEvent:Connect(guarded(onRespond))
	Remotes.TradeSetOffer.OnServerEvent:Connect(guarded(onSetOffer))
	Remotes.TradeSetReady.OnServerEvent:Connect(guarded(onSetReady))
	-- Confirmer et Annuler ne passent pas par le limiteur : ils sont idempotents et doivent toujours arriver.
	Remotes.TradeConfirm.OnServerEvent:Connect(onConfirm)
	Remotes.TradeCancel.OnServerEvent:Connect(function(player)
		local trade = trades[player]
		if trade then
			finish(trade, `{player.DisplayName} a annulé l'échange.`)
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		local trade = trades[player]
		if trade then
			finish(trade, `{player.DisplayName} est parti : échange annulé.`)
		end
		pending[player] = nil
		for _, list in pending do
			list[player] = nil
		end
		requestLimiter:forget(player)
		actionLimiter:forget(player)
	end)
end

return TradeService
