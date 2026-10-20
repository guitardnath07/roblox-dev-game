--!strict
-- Outils de test : n'agit QUE dans Roblox Studio (RunService:IsStudio() est faux sur les serveurs publiés).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local DataService = require(script.Parent.DataService)

local GRANTABLE = { Coins = true, Amber = true, Fossils = true, GoldenRolls = true, Tickets = true, Rebirths = true }

local DevService = {}

function DevService:Init()
	Remotes.DevGrant.OnServerEvent:Connect(function(player: Player, key: any, amount: any)
		if not RunService:IsStudio() then
			return
		end
		if type(key) == "string" and GRANTABLE[key] and type(amount) == "number" and amount == amount then
			DataService:Increment(player, key, amount)
		end
	end)
end

return DevService
