--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local JestGlobals = require(ReplicatedStorage.DevPackages.JestGlobals)
local describe, expect, it = JestGlobals.describe, JestGlobals.expect, JestGlobals.it

local TradeLogic = require(ServerScriptService.Server.Data.TradeLogic)

local function dino(id: string): any
	return {
		dinoId = id,
		size = "normal",
		skin = "normal",
		instinct = "none",
		obtainedAt = 0,
		locked = false,
	}
end

local function profile(dinos: { [string]: any }, amber: number): any
	return { Dinos = dinos, PlotSlots = {}, Amber = amber, Fossils = 0, TradeLog = {} }
end

local function never()
	return false
end

local function countDinos(data: any): number
	local n = 0
	for _ in data.Dinos do
		n += 1
	end
	return n
end

describe("échanges", function()
	it("échange normal : les uuid changent de main, rien n'est créé ni perdu", function()
		local a = profile({ ua = dino("galetosaure") }, 50)
		local b = profile({ ub1 = dino("omegarex"), ub2 = dino("flaquodon") }, 0)
		local offerA = TradeLogic.sanitize(a, { uuids = { "ua" }, amber = 20, fossils = 0 }, never)
		local offerB = TradeLogic.sanitize(b, { uuids = { "ub1" }, amber = 0, fossils = 0 }, never)
		assert(offerA and offerB, "les deux offres doivent être valides")
		TradeLogic.applyRaw(a, b, TradeLogic.plan(a, b, offerA, offerB, 1, 2, 0))

		expect(a.Dinos.ub1.dinoId).toBe("omegarex")
		expect(a.Dinos.ua).toBeNil()
		expect(b.Dinos.ua.dinoId).toBe("galetosaure")
		expect(countDinos(a) + countDinos(b)).toBe(3)
		expect(a.Amber + b.Amber).toBe(50)
		expect(b.Amber).toBe(20)
		expect(#a.TradeLog).toBe(1)
		expect(#b.TradeLog).toBe(1)
	end)

	it("un dino vendu entre-temps rend l'offre invalide", function()
		local a = profile({ ua = dino("galetosaure") }, 0)
		local offer = TradeLogic.sanitize(a, { uuids = { "ua" }, amber = 0, fossils = 0 }, never)
		assert(offer, "l'offre doit être valide avant la vente")
		a.Dinos.ua = nil -- vendu
		expect(TradeLogic.stillValid(a, offer)).toBe(false)
	end)

	it("refuse les dinos posés, verrouillés, en double, inconnus, et plus de 8 dinos", function()
		local dinos = {}
		for i = 1, 9 do
			dinos[`u{i}`] = dino("galetosaure")
		end
		local a = profile(dinos, 0)
		a.PlotSlots["1"] = "u1"
		a.Dinos.u2.locked = true
		expect((TradeLogic.sanitize(a, { uuids = { "u1" }, amber = 0, fossils = 0 }, never))).toBeNil()
		expect((TradeLogic.sanitize(a, { uuids = { "u2" }, amber = 0, fossils = 0 }, never))).toBeNil()
		expect((TradeLogic.sanitize(a, { uuids = { "u3", "u3" }, amber = 0, fossils = 0 }, never))).toBeNil()
		expect((TradeLogic.sanitize(a, { uuids = { "inconnu" }, amber = 0, fossils = 0 }, never))).toBeNil()
		local nine = { "u3", "u4", "u5", "u6", "u7", "u8", "u9", "u3", "u4" }
		expect((TradeLogic.sanitize(a, { uuids = nine, amber = 0, fossils = 0 }, never))).toBeNil()
	end)

	it("refuse les montants faux : négatif, NaN, à virgule, supérieur au solde", function()
		local a = profile({}, 10)
		for _, amount in { -1, 0 / 0, 1.5, 11 } do
			expect((TradeLogic.sanitize(a, { uuids = {}, amber = amount, fossils = 0 }, never))).toBeNil()
		end
	end)

	it("un dino gelé par un autre échange ne peut pas être proposé", function()
		local a = profile({ ua = dino("galetosaure") }, 0)
		local frozen = function(uuid: string)
			return uuid == "ua"
		end
		expect((TradeLogic.sanitize(a, { uuids = { "ua" }, amber = 0, fossils = 0 }, frozen))).toBeNil()
	end)
end)
