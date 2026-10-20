--!strict
-- Achats en Pièces : arbre d'améliorations, dés ; rebirth ; vitesse de marche (Vitesse de marche I-III).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Dice = require(Shared.Config.Dice)
local Economy = require(Shared.Config.Economy)
local Odds = require(Shared.Odds)
local Rebirth = require(Shared.Config.Rebirth)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)
local Upgrades = require(Shared.Config.Upgrades)

local DataService = require(script.Parent.DataService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local ACTION_INTERVAL = 0.3

local limiter = RateLimit.new()

local ProgressionService = {}

local function byId<T>(list: { T }, id: any): T?
	if type(id) ~= "string" or #id > 64 then
		return nil
	end
	for _, entry in list do
		if (entry :: any).id == id then
			return entry
		end
	end
	return nil
end

local function applyWalkSpeed(player: Player)
	local data = DataService:GetLoaded(player)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if data and humanoid then
		humanoid.WalkSpeed = Economy.baseWalkSpeed + Bonuses.upgradeStat(data.Upgrades, "walkSpeedBonus")
	end
end

local function spend(player: Player, data: Types.ProfileData, cost: number): boolean
	if data.Coins < cost then
		Remotes.Notify:FireClient(player, `Il te manque {Odds.formatBig(cost - data.Coins)} Pièces.`, "error")
		return false
	end
	DataService:Increment(player, "Coins", -cost)
	return true
end

function ProgressionService:BuyUpgrade(player: Player, upgradeId: any)
	local data = DataService:GetLoaded(player)
	local node = byId(Upgrades.list, upgradeId)
	if not data or not node or data.Upgrades[node.id] then
		return
	end
	if node.prerequisite and not data.Upgrades[node.prerequisite] then
		Remotes.Notify:FireClient(player, "Achète d'abord l'amélioration précédente.", "error")
		return
	end
	if spend(player, data, node.cost) then
		DataService:Update(player, { "Upgrades", node.id }, function()
			return true
		end)
		if node.stat == "walkSpeedBonus" then
			applyWalkSpeed(player)
		end
	end
end

function ProgressionService:BuyDice(player: Player, diceId: any)
	local data = DataService:GetLoaded(player)
	local die = byId(Dice, diceId)
	if not data or not die then
		return
	end
	if not data.OwnedDice[die.id] then
		if not spend(player, data, die.price) then
			return
		end
		DataService:Update(player, { "OwnedDice", die.id }, function()
			return true
		end)
	end
	DataService:Update(player, { "EquippedDice" }, function()
		return die.id
	end)
end

function ProgressionService:EquipDice(player: Player, diceId: any)
	local data = DataService:GetLoaded(player)
	local die = byId(Dice, diceId)
	if data and die and data.OwnedDice[die.id] then
		DataService:Update(player, { "EquippedDice" }, function()
			return die.id
		end)
	end
end

-- Rebirth : Pièces à 0, tout le reste est gardé ; +1 rebirth (multiplicateurs et socles suivent la config).
function ProgressionService:Rebirth(player: Player)
	local data = DataService:GetLoaded(player)
	if not data then
		return
	end
	local cost = Rebirth.cost(data.Rebirths + 1)
	if data.Coins < cost then
		Remotes.Notify:FireClient(player, `Il te faut {Odds.formatBig(cost)} Pièces pour renaître.`, "error")
		return
	end
	DataService:Update(player, { "Coins" }, function()
		return 0
	end)
	DataService:Increment(player, "Rebirths", 1)
	DataService:SaveNow(player)
	Remotes.Notify:FireClient(
		player,
		`Rebirth {data.Rebirths} ! Pièces et chance x{Rebirth.coinsMultiplier(data.Rebirths)}`,
		"info"
	)
end

local function guarded(handler: (Player, ...any) -> ())
	return function(player: Player, ...)
		if limiter:allow(player, ACTION_INTERVAL) then
			handler(player, ...)
		end
	end
end

function ProgressionService:Init()
	Remotes.BuyUpgrade.OnServerEvent:Connect(guarded(function(player, id)
		self:BuyUpgrade(player, id)
	end))
	Remotes.BuyDice.OnServerEvent:Connect(guarded(function(player, id)
		self:BuyDice(player, id)
	end))
	Remotes.EquipDice.OnServerEvent:Connect(guarded(function(player, id)
		self:EquipDice(player, id)
	end))
	Remotes.Rebirth.OnServerEvent:Connect(guarded(function(player)
		self:Rebirth(player)
	end))
	Remotes.SetSetting.OnServerEvent:Connect(function(player, key, value)
		local data = DataService:GetLoaded(player)
		-- Seulement des clés de réglage existantes et des booléens.
		if data and type(key) == "string" and type(data.Settings[key]) == "boolean" and type(value) == "boolean" then
			DataService:Update(player, { "Settings", key }, function()
				return value
			end)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		limiter:forget(player)
	end)
end

function ProgressionService:Start()
	DataService:OnLoaded(function(player)
		applyWalkSpeed(player)
		player.CharacterAdded:Connect(function()
			task.defer(applyWalkSpeed, player)
		end)
	end)
end

return ProgressionService
