--!strict
-- Outils de test : n'agit QUE dans Roblox Studio (RunService:IsStudio() est faux sur les serveurs publiés).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local CurrencyService = require(script.Parent.CurrencyService)
local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)

local GRANTABLE = { Fossils = true, Amber = true, Bones = true, GoldenRolls = true, Tickets = true, Rebirths = true }
local MAX_DINO_GRANT = 30

local DevService = {}

function DevService:Init()
	Remotes.DevGrant.OnServerEvent:Connect(function(player: Player, key: any, amount: any)
		if not RunService:IsStudio() then
			return
		end
		if key == "Fossils" then
			CurrencyService:Add(player, amount, "dev")
		elseif type(key) == "string" and GRANTABLE[key] and type(amount) == "number" and amount == amount then
			DataService:Increment(player, key, amount)
		end
	end)
	-- Ajoute `count` exemplaires d'un dino (sans mutation), dans la limite de la place du sac.
	Remotes.DevGrantDino.OnServerEvent:Connect(function(player: Player, dinoId: any, count: any)
		if not RunService:IsStudio() or type(dinoId) ~= "string" or type(count) ~= "number" then
			return
		end
		for _ = 1, math.clamp(math.floor(count), 0, MAX_DINO_GRANT) do
			if not InventoryService:AddDino(player, dinoId, "normal", "normal") then
				break
			end
		end
	end)
end

return DevService
