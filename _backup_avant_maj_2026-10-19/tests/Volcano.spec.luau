--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local JestGlobals = require(ReplicatedStorage.DevPackages.JestGlobals)
local describe, expect, it = JestGlobals.describe, JestGlobals.expect, JestGlobals.it

local Volcano = require(ReplicatedStorage.Shared.Config.Volcano)
local VolcanoCombat = require(ServerScriptService.Server.Data.VolcanoCombat)

local function team(count: number, damage: number, health: number)
	local list = {}
	for i = 1, count do
		table.insert(list, { uuid = `d{i}`, damage = damage, health = health, maxHealth = health })
	end
	return list
end

describe("combat du Volcan", function()
	it("une équipe forte bat l'étage 1", function()
		local floor = Volcano.floors[1]
		local outcome = VolcanoCombat.simulate(team(5, 100, 1000), floor.enemyHealth, floor.enemyDamage)
		expect(outcome.won).toBe(true)
		expect(outcome.survivors).toBe(5)
	end)

	it("une équipe faible perd contre le boss de l'étage 100", function()
		local floor = Volcano.floors[100]
		local outcome = VolcanoCombat.simulate(team(5, 10, 60), floor.enemyHealth, floor.enemyDamage)
		expect(outcome.won).toBe(false)
	end)

	it("l'ennemi frappe toujours le premier dino vivant", function()
		local outcome = VolcanoCombat.simulate(team(2, 1, 10), 1_000_000, 100)
		local firstTarget = nil
		for _, tick in outcome.ticks do
			for _, hit in tick.hits do
				if hit.attacker == "enemy" then
					firstTarget = firstTarget or hit.target
				end
			end
		end
		expect(firstTarget).toBe("d1")
	end)

	it("le combat ne dure jamais plus de 3 minutes", function()
		local outcome = VolcanoCombat.simulate(team(1, 0, 1e12), 1e12, 0)
		expect(outcome.won).toBe(false)
		expect(#outcome.ticks * VolcanoCombat.TICK_SECONDS <= 180).toBe(true)
	end)
end)
