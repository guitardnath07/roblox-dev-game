--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local JestGlobals = require(ReplicatedStorage.DevPackages.JestGlobals)
local describe, expect, it = JestGlobals.describe, JestGlobals.expect, JestGlobals.it

local Shared = ReplicatedStorage.Shared
local Config = Shared.Config
local Clovers = require(Config.Clovers)
local Dice = require(Config.Dice)
local Dinos = require(Config.Dinos)
local Grades = require(Config.Grades)
local Imprints = require(Config.Imprints)
local Instincts = require(Config.Instincts)
local Mutations = require(Config.Mutations)
local Rarities = require(Config.Rarities)
local Relics = require(Config.Relics)
local Upgrades = require(Config.Upgrades)
local Bonuses = require(Shared.Bonuses)
local Odds = require(Shared.Odds)
local Products = require(Config.Products)
local Quests = require(Config.Quests)

local function sumPerMillion(list: { any }): number
	local total = 0
	for _, entry in list do
		expect(entry.perMillion % 1).toBe(0) -- entiers uniquement
		expect(entry.perMillion >= 0).toBe(true)
		total += entry.perMillion
	end
	return total
end

local function expectUniqueIds(list: { any })
	local seen = {}
	for _, entry in list do
		expect(seen[entry.id]).toBeNil()
		seen[entry.id] = true
		-- snake_case ASCII : minuscules, chiffres, « _ ».
		expect(string.match(entry.id, "^[a-z][a-z0-9_]*$")).never.toBeNil()
	end
end

describe("exactDistribution", function()
	for _, luck in { 1, 50, 250_000 } do
		it(`somme = 1 pour luck = {luck}`, function()
			local total = 0
			for _, p in Odds.exactDistribution(luck) do
				total += p
			end
			expect(total).toBeCloseTo(1, 9)
		end)
	end

	it("un dino plus rare n'est jamais plus probable qu'un plus commun à luck = 1", function()
		local dist = Odds.exactDistribution(1)
		for i = 2, Odds.rollableCount do
			expect(dist[Dinos[i].id] <= dist[Dinos[i - 1].id]).toBe(true)
		end
	end)
end)

describe("pickPerMillion", function()
	it("renvoie toujours une ligne de la table", function()
		local rng = Random.new(42)
		for _ = 1, 1_000 do
			local clover = Odds.pickPerMillion(Clovers, rng)
			expect(clover.multiplier >= 1).toBe(true)
		end
	end)
end)

describe("tables de config", function()
	it("les dinos sont triés par oneIn croissant avec des id uniques et une rareté valide", function()
		expectUniqueIds(Dinos)
		expect(Odds.rollableCount).toBe(28)
		for i, dino in Dinos do
			expect(Rarities[dino.rarity]).never.toBeNil()
			-- les exclusifs viennent après toutes les espèces tirables (Odds ne parcourt que les rollableCount premiers)
			expect(dino.exclusive == true).toBe(i > Odds.rollableCount)
			expect(dino.exclusive == true).toBe(dino.rarity == "exclusive")
			if i > 1 and i <= Odds.rollableCount then
				expect(dino.oneIn > Dinos[i - 1].oneIn).toBe(true)
				expect(Rarities[dino.rarity].order >= Rarities[Dinos[i - 1].rarity].order).toBe(true)
			end
		end
	end)

	it("les dés ont des id uniques, une chance et un prix croissants", function()
		expectUniqueIds(Dice)
		expect(Dice[1].price).toBe(0)
		-- Les dés offerts par l'arbre (treeOnly) ne sont pas vendus : prix 0, hors de la suite des prix.
		local shop = {}
		for i, die in Dice do
			if i > 1 then
				expect(die.luck > Dice[i - 1].luck).toBe(true)
			end
			if die.treeOnly then
				expect(die.price).toBe(0)
			else
				table.insert(shop, die)
			end
		end
		expect(#shop).toBe(14)
		for i = 2, #shop do
			expect(shop[i].price > shop[i - 1].price).toBe(true)
		end
	end)

	it("les autres tables ont des id uniques", function()
		expectUniqueIds(Mutations.Sizes)
		expectUniqueIds(Mutations.Skins)
		expectUniqueIds(Instincts)
		expectUniqueIds(Grades)
		expectUniqueIds(Imprints.list)
		expectUniqueIds(Clovers)
		expectUniqueIds(Upgrades.list)
		expectUniqueIds(Relics.list)
	end)

	it("chaque table de chances fait exactement 1 000 000", function()
		expect(sumPerMillion(Mutations.Sizes)).toBe(1_000_000)
		expect(sumPerMillion(Mutations.Skins)).toBe(1_000_000)
		expect(sumPerMillion(Instincts)).toBe(1_000_000)
		expect(sumPerMillion(Grades)).toBe(1_000_000)
		expect(sumPerMillion(Imprints.list)).toBe(1_000_000)
		expect(sumPerMillion(Clovers)).toBe(1_000_000)
	end)

	it("garde les valeurs de CLAUDE.md pour les restes", function()
		expect(Grades[1].id).toBe("d")
		expect(Grades[1].perMillion).toBe(449_700) -- 44,97 %
		expect(Instincts[1].id).toBe("none")
		expect(Instincts[1].perMillion).toBe(27_490) -- 2,749 %
	end)

	it("l'arbre d'améliorations : prérequis existants et cases hexagonales libres et adjacentes", function()
		local byId = {}
		local cells = {}
		for _, node in Upgrades.list do
			byId[node.id] = node
			local key = `{node.q},{node.r}`
			expect(cells[key]).toBeNil()
			cells[key] = true
		end
		local function adjacent(aq: number, ar: number, bq: number, br: number): boolean
			local dq, dr = bq - aq, br - ar
			return math.max(math.abs(dq), math.abs(dr), math.abs(dq + dr)) == 1
		end
		for _, node in Upgrades.list do
			if node.prerequisite then
				local parent = byId[node.prerequisite]
				expect(parent).never.toBeNil()
				expect(adjacent(parent.q, parent.r, node.q, node.r)).toBe(true)
			else
				expect(adjacent(0, 0, node.q, node.r)).toBe(true)
			end
		end
	end)
end)

describe("Comptoir de vente", function()
	it("chaque relique a un prix, croissant avec le palier", function()
		for _, relic in Relics.list do
			expect(Bonuses.relicSellPrice(relic.id) > 0).toBe(true)
		end
		expect(Bonuses.relicSellPrice("inconnue")).toBe(0)
		expect(Bonuses.relicSellPrice("fern_crown") < Bonuses.relicSellPrice("bone_helmet")).toBe(true)
	end)

	it("une potion se revend moins cher qu'elle ne s'achète en Tickets (pas de boucle infinie)", function()
		for _, potion in Products.potions do
			expect(potion.sellTickets >= 1).toBe(true)
			for _, item in Quests.shop do
				if item.potionId == potion.id then
					expect(potion.sellTickets < item.priceTickets).toBe(true)
				end
			end
		end
	end)
end)

describe("formatPercent", function()
	it("garde au moins 4 chiffres après le premier chiffre non nul", function()
		expect(Odds.formatPercent(0.5)).toBe("50 %")
		expect(Odds.formatPercent(0.000123456)).toBe("0,012346 %")
		expect(Odds.formatPercent(1 / 3)).toBe("33,333 %")
		expect(Odds.formatPercent(0)).toBe("0 %")
	end)
end)

describe("formatBig", function()
	it("abrège avec les suffixes français jusqu'à 1e33", function()
		expect(Odds.formatBig(999)).toBe("999")
		expect(Odds.formatBig(1_234)).toBe("1,2 K")
		expect(Odds.formatBig(3e6)).toBe("3 M")
		expect(Odds.formatBig(2e9)).toBe("2 Md")
		expect(Odds.formatBig(8e13)).toBe("80 T")
		expect(Odds.formatBig(4.5e15)).toBe("4,5 Qa")
		expect(Odds.formatBig(1e18)).toBe("1 Qi")
		expect(Odds.formatBig(2.55e33)).toBe("2,5 Dc")
	end)
end)
