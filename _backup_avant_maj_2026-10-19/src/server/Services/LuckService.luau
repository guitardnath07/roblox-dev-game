--!strict
-- Chance totale d'un joueur, toujours calculée côté serveur, et son détail pour l'interface.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Remotes = require(Shared.Net.Remotes)

local DataService = require(script.Parent.DataService)
local FriendService = require(script.Parent.FriendService)
local GamepassService = require(script.Parent.GamepassService)
local PolicyService = require(script.Parent.PolicyService)
local Gamepasses = require(Shared.Config.Gamepasses)

-- Passes possédés qui comptent pour ce joueur : un joueur restreint (objets aléatoires payants interdits)
-- ne profite pas des passes qui modifient la chance, même achetés ailleurs (site web, autre pays).
local function effectivePasses(player: Player): { [string]: boolean }
	local owned = GamepassService:GetOwned(player)
	if not PolicyService:IsPaidRandomRestricted(player) then
		return owned
	end
	local allowed = {}
	for _, pass in Gamepasses do
		if owned[pass.id] and pass.luckMultiplier == 1 and pass.luckBonus == 0 then
			allowed[pass.id] = true
		end
	end
	return allowed
end

local LuckService = {}

-- Contexte serveur du calcul des bonus. L'événement en cours est l'attribut « ServerEvent » du Workspace
-- (écrit par l'EventService, lisible aussi par les clients).
function LuckService:GetContext(player: Player): Bonuses.Context
	local eventId = Workspace:GetAttribute("ServerEvent")
	return {
		ownedPasses = effectivePasses(player),
		eventId = if type(eventId) == "string" and eventId ~= "" then eventId else nil,
		now = os.time(),
		friendCount = FriendService:Count(player),
	}
end

-- Chance totale (sans trèfle) et détail. 1 si le profil n'est pas chargé.
function LuckService:GetTotalLuck(player: Player): (number, { Bonuses.Factor })
	local data = DataService:GetLoaded(player)
	if not data then
		return 1, {}
	end
	return Bonuses.luck(data, self:GetContext(player))
end

function LuckService:GetRollCooldown(player: Player): number
	local data = DataService:GetLoaded(player)
	if not data then
		return math.huge
	end
	return Bonuses.rollCooldown(data, self:GetContext(player))
end

function LuckService:Init()
	Remotes.GetLuckBreakdown.OnServerInvoke = function(player: Player)
		local total, factors = self:GetTotalLuck(player)
		local data = DataService:GetLoaded(player)
		return {
			total = total,
			factors = factors,
			cooldown = self:GetRollCooldown(player),
			-- Le client ne connaît ni les passes ni les amis présents : le revenu réel vient d'ici.
			incomePerSecond = if data then Bonuses.totalIncome(data, self:GetContext(player)) else 0,
		}
	end
end

return LuckService
