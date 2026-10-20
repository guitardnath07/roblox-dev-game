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
		local data: { [string]: any } = { Fossils = 42 }
		Migrations.run(data, 1)
		expect(data.DataVersion).toBe(1)
		expect(data.Fossils).toBe(42)
	end)

	it("v1 -> v2 : les Pièces deviennent les Fossiles, les anciens Fossiles deviennent les Os", function()
		local data: { [string]: any } = { DataVersion = 1, Coins = 500, Fossils = 12, Bones = 0 }
		Migrations.run(data, 2)
		expect(data.DataVersion).toBe(2)
		expect(data.Fossils).toBe(500)
		expect(data.Bones).toBe(12)
		expect(data.Coins).toBeNil()
	end)

	it("un profil déjà à jour n'est pas modifié", function()
		local data: { [string]: any } = { DataVersion = 1, Fossils = 7 }
		Migrations.run(data, 1)
		expect(data.DataVersion).toBe(1)
		expect(data.Fossils).toBe(7)
	end)
end)

describe("OfflineEarnings", function()
	local CAP = 8 * 3600

	it("paie le temps réellement écoulé sous le plafond", function()
		local coins, seconds = OfflineEarnings.compute(1000, 1000 + 600, 10, CAP, 0.5)
		expect(seconds).toBe(600)
		expect(coins).toBe(3000)
	end)

	it("plafonne à 8 h, payées à 50 %", function()
		local coins, seconds = OfflineEarnings.compute(1000, 1000 + 24 * 3600, 10, CAP, 0.5)
		expect(seconds).toBe(CAP)
		expect(coins).toBe(CAP * 10 * 0.5)
	end)

	it("rien à la première connexion ni si l'horloge recule", function()
		expect((OfflineEarnings.compute(0, 5000, 10, CAP, 0.5))).toBe(0)
		expect((OfflineEarnings.compute(5000, 4000, 10, CAP, 0.5))).toBe(0)
	end)
end)
