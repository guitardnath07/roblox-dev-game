--!strict
-- Volcan des Défis (seul combat) : 100 étages, équipe de 5 dinos, combat automatique, boss tous les 10 étages.
-- L'ennemi de l'étage f a : PV = enemyBaseHealth x growth^(f-1), dégâts/s = enemyBaseDamage x growth^(f-1),
-- multipliés par bossHealthMultiplier / bossDamageMultiplier sur les étages boss.
-- Récompense de 1re victoire : Ambre et Fossiles croissants, potion sur les boss ; rejouer donne `repeatRewardRatio`.
-- Reliques : voir Relics.luau. shortcut: courbe et récompenses proposées, à recaler avec un simulateur de combat.

export type Floor = {
	floor: number,
	isBoss: boolean,
	enemyHealth: number,
	enemyDamage: number, -- dégâts par seconde
	amber: number,
	fossils: number,
	potionId: string?, -- Products.potions id, seulement sur les boss
}

local FLOORS = 100
local BOSS_EVERY = 10
local ENEMY_BASE_HEALTH = 300
local ENEMY_BASE_DAMAGE = 15
local GROWTH = 1.11
local BOSS_HEALTH_MULTIPLIER = 4
local BOSS_DAMAGE_MULTIPLIER = 1.5

local floors: { Floor } = {}
for f = 1, FLOORS do
	local isBoss = f % BOSS_EVERY == 0
	local scale = GROWTH ^ (f - 1)
	local health = ENEMY_BASE_HEALTH * scale * (if isBoss then BOSS_HEALTH_MULTIPLIER else 1)
	local damage = ENEMY_BASE_DAMAGE * scale * (if isBoss then BOSS_DAMAGE_MULTIPLIER else 1)
	local amber = 5 + f
	local fossils = 2 + math.floor(f / 2)
	table.insert(
		floors,
		table.freeze({
			floor = f,
			isBoss = isBoss,
			enemyHealth = math.floor(health),
			enemyDamage = math.floor(damage),
			amber = if isBoss then amber * 5 else amber,
			fossils = if isBoss then fossils * 5 else fossils,
			potionId = if isBoss then (if f >= 50 then "super_luck_potion" else "luck_potion") else nil,
		})
	)
end

return table.freeze({
	floorCount = FLOORS,
	teamSize = 5,
	bossEvery = BOSS_EVERY,
	growth = GROWTH,
	repeatRewardRatio = 0.2,
	floors = table.freeze(floors),
})
