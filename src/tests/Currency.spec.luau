--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local JestGlobals = require(ReplicatedStorage.DevPackages.JestGlobals)
local describe, expect, it = JestGlobals.describe, JestGlobals.expect, JestGlobals.it

local Bonuses = require(ReplicatedStorage.Shared.Bonuses)
local Dinos = require(ReplicatedStorage.Shared.Config.Dinos)
local CurrencyService = require(ServerScriptService.Server.Services.CurrencyService)

describe("CurrencyService", function()
	it("refuse les montants négatifs, NaN et infinis", function()
		expect(CurrencyService.isValidAmount(10)).toBe(true)
		expect(CurrencyService.isValidAmount(0)).toBe(true)
		expect(CurrencyService.isValidAmount(-1)).toBe(false)
		expect(CurrencyService.isValidAmount(0 / 0)).toBe(false)
		expect(CurrencyService.isValidAmount(math.huge)).toBe(false)
		expect(CurrencyService.isValidAmount("10")).toBe(false)
	end)

	it("Spend refuse si le solde ne suffit pas", function()
		expect(CurrencyService.afterSpend(100, 30)).toBe(70)
		expect(CurrencyService.afterSpend(100, 100)).toBe(0)
		expect(CurrencyService.afterSpend(100, 101)).toBeNil()
		expect(CurrencyService.afterSpend(100, -5)).toBeNil()
	end)
end)

describe("Revenu d'un dino", function()
	it("base × taille × peau (Géant x2, peau Ambre x1,5)", function()
		local dino = Dinos[1]
		local instance: any = { dinoId = dino.id, size = "giant", skin = "amber", instinct = "none" }
		expect(Bonuses.instanceIncome(instance)).toBe(dino.baseIncome * 2 * 1.5)
	end)

	it("un dino inconnu ne rapporte rien", function()
		local instance: any = { dinoId = "inconnu", size = "normal", skin = "normal", instinct = "none" }
		expect(Bonuses.instanceIncome(instance)).toBe(0)
	end)
end)
