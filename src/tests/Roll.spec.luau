--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local JestGlobals = require(ReplicatedStorage.DevPackages.JestGlobals)
local describe, expect, it = JestGlobals.describe, JestGlobals.expect, JestGlobals.it

local Odds = require(ReplicatedStorage.Shared.Odds)
local RateLimit = require(ServerScriptService.Server.Data.RateLimit)

describe("fréquences des tirages", function()
	for _, luck in { 1, 1000 } do
		it(`1 000 000 de tirages à luck = {luck} restent à ±5 % de exactDistribution`, function()
			local rng = Random.new(12345)
			local counts: { [string]: number } = {}
			local n = 1_000_000
			for _ = 1, n do
				local id = Odds.rollDino(luck, rng).id
				counts[id] = (counts[id] or 0) + 1
			end
			for id, p in Odds.exactDistribution(luck) do
				if p > 0.001 then
					local observed = (counts[id] or 0) / n
					expect(math.abs(observed - p) / p < 0.05).toBe(true)
				end
			end
		end)
	end
end)

describe("anti-spam des lancers", function()
	it("100 appels en 1 seconde avec un délai de 1 s ne donnent qu'un seul lancer", function()
		local limiter = RateLimit.new()
		local allowed = 0
		for i = 0, 99 do
			if limiter:allow("joueur", 1, 1000 + i * 0.0099) then
				allowed += 1
			end
		end
		expect(allowed).toBe(1)
	end)

	it("le spam ne repousse pas la fenêtre : un appel après le délai passe", function()
		local limiter = RateLimit.new()
		expect(limiter:allow("joueur", 1, 0)).toBe(true)
		expect(limiter:allow("joueur", 1, 0.5)).toBe(false)
		expect(limiter:allow("joueur", 1, 1.0)).toBe(true)
	end)
end)
