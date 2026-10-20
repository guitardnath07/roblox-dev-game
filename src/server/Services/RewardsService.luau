--!strict
-- Récompenses gratuites : codes promo, récompense quotidienne (série 7 jours UTC), temps de jeu dans la session,
-- coffre de groupe, paliers de la Paléo-Encyclopédie. Chaque remote renvoie { ok, message }.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Codes = require(Shared.Config.Codes)
local Economy = require(Shared.Config.Economy)
local Remotes = require(Shared.Net.Remotes)
local Rewards = require(Shared.Config.Rewards)

local DataService = require(script.Parent.DataService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local CODE_INTERVAL = 2
local CLAIM_INTERVAL = 0.5
local DAY = 24 * 3600

type Response = { ok: boolean, message: string }
type AnyReward = {
	amber: number?,
	bones: number?,
	goldenRolls: number?,
	tickets: number?,
	potions: { [string]: number }?,
}

local codeLimiter = RateLimit.new()
local claimLimiter = RateLimit.new()
local sessionStart: { [Player]: number } = {}

local RewardsService = {}

local function utcDay(time: number): number
	return math.floor(time / DAY)
end

-- Ajoute une récompense au profil. Utilisé aussi par les quêtes et la boutique de quêtes.
function RewardsService:Grant(player: Player, reward: AnyReward)
	if (reward.amber or 0) > 0 then
		DataService:Increment(player, "Amber", reward.amber :: number)
	end
	if (reward.bones or 0) > 0 then
		DataService:Increment(player, "Bones", reward.bones :: number)
	end
	if (reward.goldenRolls or 0) > 0 then
		DataService:Increment(player, "GoldenRolls", reward.goldenRolls :: number)
	end
	if (reward.tickets or 0) > 0 then
		DataService:Increment(player, "Tickets", reward.tickets :: number)
	end
	for potionId, count in reward.potions or {} do
		DataService:Update(player, { "Potions", potionId }, function(old: number?)
			return (old or 0) + count
		end)
	end
end

local function redeemCode(player: Player, text: any): Response
	if not codeLimiter:allow(player, CODE_INTERVAL) then
		return { ok = false, message = "Attends un peu avant de réessayer." }
	end
	local data = DataService:GetLoaded(player)
	if not data or type(text) ~= "string" or #text > 32 then
		return { ok = false, message = "Code invalide." }
	end
	local key = string.upper((text:gsub("%s", "")))
	for _, entry in Codes do
		if entry.code == key then
			if not entry.active then
				return { ok = false, message = "Ce code n'est pas encore actif." }
			end
			if data.RedeemedCodes[key] then
				return { ok = false, message = "Tu as déjà utilisé ce code." }
			end
			DataService:Update(player, { "RedeemedCodes", key }, function()
				return true
			end)
			RewardsService:Grant(player, entry.rewards)
			return { ok = true, message = `Code {key} utilisé !` }
		end
	end
	return { ok = false, message = "Code inconnu." }
end

local function claimDaily(player: Player): Response
	local data = DataService:GetLoaded(player)
	if not data then
		return { ok = false, message = "Profil pas encore chargé." }
	end
	local today = utcDay(os.time())
	if data.Daily.LastClaim == today then
		return { ok = false, message = "Reviens demain pour la suite de ta série !" }
	end
	-- Série cassée si le dernier jour réclamé n'est pas hier ; après le jour 7, on recommence au jour 1.
	local continues = data.Daily.LastClaim == today - 1 and data.Daily.Streak < #Rewards.daily
	local streak = if continues then data.Daily.Streak + 1 else 1
	DataService:Update(player, { "Daily" }, function()
		return { Streak = streak, LastClaim = today }
	end)
	RewardsService:Grant(player, Rewards.daily[streak])
	return { ok = true, message = `Jour {streak} réclamé !` }
end

local function claimGroupChest(player: Player): Response
	local data = DataService:GetLoaded(player)
	if not data or Rewards.groupId == 0 then
		return { ok = false, message = "Le coffre de groupe n'est pas encore ouvert." }
	end
	local wait = data.GroupChestLastClaim + Rewards.groupChestCooldownSeconds - os.time()
	if wait > 0 then
		return { ok = false, message = `Reviens dans {math.ceil(wait / 3600)} h.` }
	end
	local ok, inGroup = pcall(player.IsInGroup, player, Rewards.groupId)
	if not ok then
		return { ok = false, message = "Impossible de vérifier le groupe, réessaie." }
	end
	if not inGroup then
		return { ok = false, message = "Rejoins le groupe Roblox du jeu pour ouvrir ce coffre." }
	end
	DataService:Update(player, { "GroupChestLastClaim" }, function()
		return os.time()
	end)
	RewardsService:Grant(player, Rewards.groupChest)
	return { ok = true, message = "Coffre de groupe ouvert !" }
end

local function claimIndexMilestone(player: Player, found: any): Response
	local data = DataService:GetLoaded(player)
	if not data or type(found) ~= "number" then
		return { ok = false, message = "Palier invalide." }
	end
	for _, milestone in Economy.IndexMilestones do
		if milestone.found == found then
			local key = tostring(found)
			if data.Index.ClaimedMilestones[key] then
				return { ok = false, message = "Déjà réclamé." }
			end
			local count = 0
			for _ in data.Index.Found do
				count += 1
			end
			if count < found then
				return { ok = false, message = `Trouve encore {found - count} dinos.` }
			end
			DataService:Update(player, { "Index", "ClaimedMilestones", key }, function()
				return true
			end)
			RewardsService:Grant(player, { amber = milestone.amber, bones = milestone.bones })
			return { ok = true, message = `Palier {found} réclamé !` }
		end
	end
	return { ok = false, message = "Palier invalide." }
end

local function guarded(handler: (Player, ...any) -> Response)
	return function(player: Player, ...): Response
		if not claimLimiter:allow(player, CLAIM_INTERVAL) then
			return { ok = false, message = "Doucement !" }
		end
		return handler(player, ...)
	end
end

-- Récompenses de temps de jeu : vérifiées chaque minute pour chaque joueur, une fois par palier et par session.
local function playtimeLoop()
	local given: { [Player]: { [number]: boolean } } = {}
	while true do
		task.wait(60)
		for player, start in sessionStart do
			local minutes = (os.clock() - start) / 60
			given[player] = given[player] or {}
			for _, step in Rewards.playtime do
				if minutes >= step.minutes and not given[player][step.minutes] and DataService:GetLoaded(player) then
					given[player][step.minutes] = true
					RewardsService:Grant(player, step.reward)
					Remotes.PlaytimeReward:FireClient(player, step.minutes)
				end
			end
		end
		for player in given do
			if not sessionStart[player] then
				given[player] = nil
			end
		end
	end
end

function RewardsService:Init()
	Remotes.RedeemCode.OnServerInvoke = redeemCode
	Remotes.ClaimDaily.OnServerInvoke = guarded(claimDaily)
	Remotes.ClaimGroupChest.OnServerInvoke = guarded(claimGroupChest)
	Remotes.ClaimIndexMilestone.OnServerInvoke = guarded(claimIndexMilestone)
	Players.PlayerRemoving:Connect(function(player)
		sessionStart[player] = nil
		codeLimiter:forget(player)
		claimLimiter:forget(player)
	end)
end

function RewardsService:Start()
	DataService:OnLoaded(function(player)
		sessionStart[player] = os.clock()
	end)
	playtimeLoop()
end

return RewardsService
