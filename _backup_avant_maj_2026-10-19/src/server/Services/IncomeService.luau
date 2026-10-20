--!strict
-- Revenus des dinos posés : un tick serveur par seconde ajoute le revenu total au profil.
-- Le revenu par seconde est aussi gardé dans le profil pour les gains hors ligne.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bonuses = require(ReplicatedStorage.Shared.Bonuses)

local DataService = require(script.Parent.DataService)
local LuckService = require(script.Parent.LuckService)

local TICK_SECONDS = 1

local IncomeService = {}

-- Revenu final par seconde d'un dino posé. La SEULE formule utilisée partout (tick, affichage).
function IncomeService:GetDinoIncome(player: Player, uuid: string, slot: string): number
	local data = DataService:GetLoaded(player)
	if not data then
		return 0
	end
	return Bonuses.dinoIncome(data, LuckService:GetContext(player), uuid, slot)
end

function IncomeService:GetTotalIncome(player: Player): number
	local data = DataService:GetLoaded(player)
	if not data then
		return 0
	end
	return Bonuses.totalIncome(data, LuckService:GetContext(player))
end

local function tick()
	for _, player in game:GetService("Players"):GetPlayers() do
		local data = DataService:GetLoaded(player)
		if data then
			local income = IncomeService:GetTotalIncome(player)
			if income > 0 then
				DataService:Increment(player, "Coins", income * TICK_SECONDS)
			end
			if income ~= data.LastIncomePerSecond then
				DataService:Update(player, { "LastIncomePerSecond" }, function()
					return income
				end)
			end
		end
	end
end

function IncomeService:Start()
	while true do
		task.wait(TICK_SECONDS)
		tick()
	end
end

return IncomeService
