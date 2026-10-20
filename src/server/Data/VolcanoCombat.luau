--!strict
-- Combat automatique du Volcan, pur et déterministe (testable) : un tick toutes les 0,5 s.
-- À chaque tick, chaque dino vivant frappe l'ennemi ; puis l'ennemi frappe le premier dino vivant.
-- Pas de physique. Les dégâts sont des dégâts par seconde, appliqués par tranche de tick.

local TICK_SECONDS = 0.5
local MAX_TICKS = 2 * 60 * 3 -- 3 minutes : au-delà, l'étage est perdu (évite un combat sans fin)

export type Fighter = { uuid: string, damage: number, health: number, maxHealth: number }

export type Hit = { attacker: string, target: string, amount: number, killed: boolean }

export type Tick = { hits: { Hit } }

export type Outcome = { won: boolean, ticks: { Tick }, survivors: number }

local VolcanoCombat = {}

VolcanoCombat.TICK_SECONDS = TICK_SECONDS

local ENEMY = "enemy"

function VolcanoCombat.simulate(team: { Fighter }, enemyHealth: number, enemyDamage: number): Outcome
	local fighters: { Fighter } = {}
	for _, fighter in team do
		table.insert(fighters, table.clone(fighter))
	end
	local enemyLeft = enemyHealth
	local ticks: { Tick } = {}

	local function firstAlive(): Fighter?
		for _, fighter in fighters do
			if fighter.health > 0 then
				return fighter
			end
		end
		return nil
	end

	for _ = 1, MAX_TICKS do
		local hits: { Hit } = {}
		for _, fighter in fighters do
			if fighter.health > 0 and enemyLeft > 0 then
				local amount = fighter.damage * TICK_SECONDS
				enemyLeft -= amount
				table.insert(
					hits,
					{ attacker = fighter.uuid, target = ENEMY, amount = amount, killed = enemyLeft <= 0 }
				)
			end
		end
		if enemyLeft > 0 then
			local target = firstAlive()
			if target then
				local amount = enemyDamage * TICK_SECONDS
				target.health -= amount
				table.insert(
					hits,
					{ attacker = ENEMY, target = target.uuid, amount = amount, killed = target.health <= 0 }
				)
			end
		end
		table.insert(ticks, { hits = hits })

		if enemyLeft <= 0 then
			local survivors = 0
			for _, fighter in fighters do
				if fighter.health > 0 then
					survivors += 1
				end
			end
			return { won = true, ticks = ticks, survivors = survivors }
		end
		if not firstAlive() then
			return { won = false, ticks = ticks, survivors = 0 }
		end
	end
	return { won = false, ticks = ticks, survivors = 0 }
end

return VolcanoCombat
