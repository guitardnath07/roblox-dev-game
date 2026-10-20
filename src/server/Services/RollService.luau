--!strict
-- Tirage de dés (cœur du jeu). Le client n'envoie que l'intention « lancer » ; le serveur vérifie le profil,
-- le sac et le délai, tire trèfle -> dino -> taille -> peau, enregistre l'exemplaire et renvoie le résultat.
-- Auto-lancer : c'est le client qui renvoie RequestRoll en boucle ; le même délai s'applique ici.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Clovers = require(Shared.Config.Clovers)
local Economy = require(Shared.Config.Economy)
local Helpers = require(Shared.Config.Helpers)
local Mutations = require(Shared.Config.Mutations)
local Odds = require(Shared.Odds)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local AnnounceService = require(script.Parent.AnnounceService)
local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)
local LuckService = require(script.Parent.LuckService)
local QuestService = require(script.Parent.QuestService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local GOLDEN_ROLL_INTERVAL = 0.25 -- les Lancers Dorés ignorent le délai, mais pas l'anti-spam réseau

local rng = Random.new() -- seul générateur des tirages, jamais exposé au client
local rollLimiter = RateLimit.new()
local goldenLimiter = RateLimit.new()

local RollService = {}

-- Peau tirée avec l'effet de l'événement Éclipse : chances des peaux non normales multipliées,
-- la peau normale garde le reste (total toujours 1 000 000).
local function pickSkin(multiplier: number): Mutations.Skin
	if multiplier == 1 then
		return Odds.pickPerMillion(Mutations.Skins, rng)
	end
	local boosted = {}
	local others = 0
	for _, skin in Mutations.Skins do
		if skin.id ~= Mutations.defaultId then
			local weight = math.floor(skin.perMillion * multiplier)
			others += weight
			table.insert(boosted, { skin = skin, perMillion = weight })
		end
	end
	for _, skin in Mutations.Skins do
		if skin.id == Mutations.defaultId then
			table.insert(boosted, { skin = skin, perMillion = math.max(0, Helpers.PER_MILLION - others) })
		end
	end
	return Odds.pickPerMillion(boosted, rng).skin
end

-- Un tirage complet, appelé une fois le joueur autorisé à lancer. Renvoie nil si le sac est plein.
local function rollOnce(player: Player, data: Types.ProfileData): Types.RollResult?
	if InventoryService:IsFull(data) then
		return nil
	end

	local ctx = LuckService:GetContext(player)
	local baseLuck = Bonuses.luck(data, ctx)
	local clover = Odds.pickPerMillion(Clovers, rng)
	local luck = baseLuck * clover.multiplier

	local dino = Odds.rollDino(luck, rng)
	local size = Odds.pickPerMillion(Mutations.Sizes, rng)
	local event = Bonuses.event(ctx)
	local skin = pickSkin(
		(if event then event.skinMutationMultiplier else 1) * Bonuses.upgradeStat(data.Upgrades, "skinMutationMultiplier")
	)

	local uuid, isNew = InventoryService:AddDino(player, dino.id, size.id, skin.id)
	if not uuid then
		return nil
	end

	DataService:Increment(player, "TotalRolls", 1)
	QuestService:Progress(player, "rolls", 1)
	QuestService:Progress(player, "roll_rarity", 1, dino.rarity)
	if dino.oneIn > data.BestPull.OneIn then
		DataService:Update(player, { "BestPull" }, function()
			return { DinoId = dino.id, OneIn = dino.oneIn }
		end)
	end

	if dino.oneIn >= Economy.globalAnnounceOneIn then
		local mutation = if size.id ~= Mutations.defaultId then ` {size.displayName}` else ""
		AnnounceService:Publish(
			`{player.DisplayName} a obtenu un {dino.displayName}{mutation} (1 sur {Odds.formatBig(dino.oneIn)}) !`,
			dino.rarity
		)
	end

	return {
		uuid = uuid,
		dinoId = dino.id,
		size = size.id,
		skin = skin.id,
		clover = clover.multiplier,
		oneInDisplayed = Odds.displayOneIn(dino.oneIn, luck),
		isNewInIndex = isNew,
	}
end

local function rollAndSend(player: Player, data: Types.ProfileData, count: number)
	for _ = 1, count do
		local result = rollOnce(player, data)
		if not result then
			Remotes.Notify:FireClient(player, "Ton sac est plein ! Vends ou agrandis ton sac.", "error")
			return
		end
		Remotes.RollResult:FireClient(player, result)
	end
end

local function onRequestRoll(player: Player)
	local data = DataService:GetLoaded(player)
	if not data then
		return
	end
	-- Appel trop rapide : ignoré sans réponse (anti-spam, compteur par joueur).
	if not rollLimiter:allow(player, LuckService:GetRollCooldown(player)) then
		return
	end
	rollAndSend(player, data, Bonuses.rollsPerClick(LuckService:GetContext(player)))
end

local function onUseGoldenRoll(player: Player)
	local data = DataService:GetLoaded(player)
	if not data or data.GoldenRolls < 1 or not goldenLimiter:allow(player, GOLDEN_ROLL_INTERVAL) then
		return
	end
	if InventoryService:IsFull(data) then
		Remotes.Notify:FireClient(player, "Ton sac est plein ! Vends ou agrandis ton sac.", "error")
		return
	end
	DataService:Increment(player, "GoldenRolls", -1)
	rollAndSend(player, data, 1)
end

function RollService:Init()
	Remotes.RequestRoll.OnServerEvent:Connect(onRequestRoll)
	Remotes.UseGoldenRoll.OnServerEvent:Connect(onUseGoldenRoll)
	Players.PlayerRemoving:Connect(function(player)
		rollLimiter:forget(player)
		goldenLimiter:forget(player)
	end)
end

return RollService
