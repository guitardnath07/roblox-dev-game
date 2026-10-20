--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local JestGlobals = require(ReplicatedStorage.DevPackages.JestGlobals)
local describe, expect, it = JestGlobals.describe, JestGlobals.expect, JestGlobals.it

local Products = require(ReplicatedStorage.Shared.Config.Products)
local Purchases = require(ServerScriptService.Server.Data.Purchases)

describe("reçus d'achat", function()
	it("un PurchaseId déjà traité est reconnu (aucun double octroi)", function()
		local list = Purchases.remember({}, "achat-1")
		expect(Purchases.isProcessed(list, "achat-1")).toBe(true)
		expect(Purchases.isProcessed(list, "achat-2")).toBe(false)
	end)

	it("ne garde que les 100 derniers PurchaseId", function()
		local list: { string } = {}
		for i = 1, 150 do
			list = Purchases.remember(list, `achat-{i}`)
		end
		expect(#list).toBe(Purchases.KEEP_LAST)
		expect(Purchases.isProcessed(list, "achat-150")).toBe(true)
		expect(Purchases.isProcessed(list, "achat-50")).toBe(false)
	end)

	it("un ProductId 0 (non configuré) ne correspond à aucun produit", function()
		expect(Purchases.productFor(0)).toBeNil()
	end)

	it("Ambre, Os et potions de chance sont des objets aléatoires payants ; pas la potion de Fossiles", function()
		for _, product in Products.products do
			local expected = product.kind ~= "potion" or product.potionId ~= "coins_potion"
			expect(Purchases.isPaidRandom(product)).toBe(expected)
		end
	end)
end)
