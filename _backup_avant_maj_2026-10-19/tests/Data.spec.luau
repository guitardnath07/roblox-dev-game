--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local JestGlobals = require(ReplicatedStorage.DevPackages.JestGlobals)
local describe, expect, it = JestGlobals.describe, JestGlobals.expect, JestGlobals.it

local Data = ServerScriptService.Server.Data
local Migrations = require(Data.Migrations)
local OfflineEarnings = require(Data.OfflineEarnings)

describe("Migrations", function()
	it("v0 -> v1 : un profil sans DataVersion passe en version 1", function()
		local data: { [string]: any } = { Coins = 42 }
		Migrations.run(data, 1)
		expect(data.DataVersion).toBe(1)
		expect(data.Coins).toBe(42)
	end)

	it("un profil déjà à jour n'est pas modifié", function()
		local data: { [string]: any } = { DataVersion = 1, Coins = 7 }
		Migrations.run(data, 1)
		expect(data.DataVersion).toBe(1)
		expect(data.Coins).toBe(7)
	end)
end)

describe("OfflineEarnings", function()
	local CAP = 8 * 3600

	it("paie le temps réellement écoulé sous le plafond", function()
		local coins, seconds = OfflineEarnings.compute(1000, 1000 + 600, 10, CAP)
		expect(seconds).toBe(600)
		expect(coins).toBe(6000)
	end)

	it("plafonne à 8 h", function()
		local coins, seconds = OfflineEarnings.compute(1000, 1000 + 24 * 3600, 10, CAP)
		expect(seconds).toBe(CAP)
		expect(coins).toBe(CAP * 10)
	end)

	it("rien à la première connexion ni si l'horloge recule", function()
		expect((OfflineEarnings.compute(0, 5000, 10, CAP))).toBe(0)
		expect((OfflineEarnings.compute(5000, 4000, 10, CAP))).toBe(0)
	end)
end)
