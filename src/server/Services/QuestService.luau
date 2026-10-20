--!strict
-- Quêtes : 3 quotidiennes et 3 hebdomadaires tirées dans les pools de Config/Quests, réinitialisées à minuit UTC
-- (lundi pour l'hebdo). Le tirage dépend du jour et du joueur : il reste le même s'il se reconnecte.
-- Les autres services signalent l'avancement avec QuestService:Progress(player, kind, amount, rarityId?).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Quests = require(Shared.Config.Quests)
local Rarities = require(Shared.Config.Rarities)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataService = require(script.Parent.DataService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)
local RewardsService = require(script.Parent.RewardsService)

local DAY = 24 * 3600
local WEEK_OFFSET = 3 * DAY -- le 1er janvier 1970 était un jeudi : décalage pour couper la semaine le lundi
local CLAIM_INTERVAL = 0.3

type Response = { ok: boolean, message: string }

local limiter = RateLimit.new()

local QuestService = {}

local function dayNumber(now: number): number
	return math.floor(now / DAY)
end

local function weekNumber(now: number): number
	return math.floor((now + WEEK_OFFSET) / (7 * DAY))
end

-- `count` quêtes différentes du pool, choisies avec une graine (période, joueur).
local function draw(pool: { Quests.Quest }, count: number, seed: number): { Types.QuestProgress }
	local rng = Random.new(seed)
	local indices = {}
	for i = 1, #pool do
		table.insert(indices, i)
	end
	local result: { Types.QuestProgress } = {}
	for _ = 1, math.min(count, #pool) do
		local index = table.remove(indices, rng:NextInteger(1, #indices)) :: number
		table.insert(result, { id = pool[index].id, progress = 0, claimed = false })
	end
	return result
end

local function questDef(pool: { Quests.Quest }, id: string): Quests.Quest?
	for _, quest in pool do
		if quest.id == id then
			return quest
		end
	end
	return nil
end

-- Remplace les quêtes périmées par celles du jour / de la semaine.
local function refresh(player: Player)
	local data = DataService:GetLoaded(player)
	if not data then
		return
	end
	local now = os.time()
	local day, week = dayNumber(now), weekNumber(now)
	if data.Quests.dailyPeriod ~= day then
		DataService:Update(player, { "Quests", "daily" }, function()
			return draw(Quests.daily, Quests.dailyCount, day * 1_000_003 + player.UserId)
		end)
		DataService:Update(player, { "Quests", "dailyPeriod" }, function()
			return day
		end)
	end
	if data.Quests.weeklyPeriod ~= week then
		DataService:Update(player, { "Quests", "weekly" }, function()
			return draw(Quests.weekly, Quests.weeklyCount, week * 1_000_033 + player.UserId)
		end)
		DataService:Update(player, { "Quests", "weeklyPeriod" }, function()
			return week
		end)
	end
end

local function matches(quest: Quests.Quest, kind: Quests.QuestKind, rarityId: string?): boolean
	if quest.kind ~= kind then
		return false
	end
	if kind == "roll_rarity" then
		local wanted = quest.rarity and (Rarities :: any)[quest.rarity]
		local got = rarityId and (Rarities :: any)[rarityId]
		return wanted ~= nil and got ~= nil and got.order >= wanted.order
	end
	return true
end

-- Avance toutes les quêtes du joueur qui correspondent à `kind`.
function QuestService:Progress(player: Player, kind: Quests.QuestKind, amount: number, rarityId: string?)
	local data = DataService:GetLoaded(player)
	if not data then
		return
	end
	refresh(player)
	for _, scope in { "daily", "weekly" } do
		local pool = if scope == "daily" then Quests.daily else Quests.weekly
		local list: { Types.QuestProgress } = (data.Quests :: any)[scope]
		local changed = false
		local updated: { Types.QuestProgress } = {}
		for _, entry in list do
			local quest = questDef(pool, entry.id)
			if quest and not entry.claimed and entry.progress < quest.target and matches(quest, kind, rarityId) then
				changed = true
				table.insert(updated, {
					id = entry.id,
					progress = math.min(quest.target, entry.progress + amount),
					claimed = false,
				})
			else
				table.insert(updated, entry)
			end
		end
		-- Les listes sont réécrites en entier : un chemin de DataService ne contient que des clés texte.
		if changed then
			DataService:Update(player, { "Quests", scope }, function()
				return updated
			end)
		end
	end
end

local function claimQuest(player: Player, scope: any, index: any): Response
	local data = DataService:GetLoaded(player)
	if not data or (scope ~= "daily" and scope ~= "weekly") or type(index) ~= "number" then
		return { ok = false, message = "Quête invalide." }
	end
	refresh(player)
	local entry = (data.Quests :: any)[scope][index]
	local quest = entry and questDef(if scope == "daily" then Quests.daily else Quests.weekly, entry.id)
	if not entry or not quest then
		return { ok = false, message = "Quête invalide." }
	end
	if entry.claimed then
		return { ok = false, message = "Déjà réclamée." }
	end
	if entry.progress < quest.target then
		return { ok = false, message = "Quête pas encore terminée." }
	end
	DataService:Update(player, { "Quests", scope }, function(old: { Types.QuestProgress })
		local list = table.clone(old)
		list[index] = { id = entry.id, progress = entry.progress, claimed = true }
		return list
	end)
	RewardsService:Grant(player, { tickets = quest.tickets })
	return { ok = true, message = `+{quest.tickets} Tickets d'Expédition` }
end

local function buyQuestItem(player: Player, itemId: any): Response
	local data = DataService:GetLoaded(player)
	if not data or type(itemId) ~= "string" then
		return { ok = false, message = "Objet invalide." }
	end
	for _, item in Quests.shop do
		if item.id == itemId then
			if data.Tickets < item.priceTickets then
				return { ok = false, message = `Il te faut {item.priceTickets} Tickets.` }
			end
			DataService:Increment(player, "Tickets", -item.priceTickets)
			RewardsService:Grant(player, {
				amber = item.amber,
				bones = item.bones,
				goldenRolls = item.goldenRolls,
				potions = if item.potionId then { [item.potionId] = 1 } else nil,
			})
			return { ok = true, message = `{item.displayName} acheté !` }
		end
	end
	return { ok = false, message = "Objet invalide." }
end

local function guarded(handler: (Player, ...any) -> Response)
	return function(player: Player, ...): Response
		if not limiter:allow(player, CLAIM_INTERVAL) then
			return { ok = false, message = "Doucement !" }
		end
		return handler(player, ...)
	end
end

function QuestService:Init()
	Remotes.ClaimQuest.OnServerInvoke = guarded(claimQuest)
	Remotes.BuyQuestItem.OnServerInvoke = guarded(buyQuestItem)
	Players.PlayerRemoving:Connect(function(player)
		limiter:forget(player)
	end)
end

function QuestService:Start()
	DataService:OnLoaded(refresh)
	-- Minutes jouées + passage de minuit pour les joueurs connectés.
	while true do
		task.wait(60)
		for _, player in Players:GetPlayers() do
			QuestService:Progress(player, "play_minutes", 1)
		end
	end
end

return QuestService
