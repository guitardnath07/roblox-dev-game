--!strict
-- Instinct : relancé avec des Fossiles, 1 par dino, le nouveau remplace l'ancien.
-- `perMillion` = chance sur 1 000 000 ; « none » reçoit le reste (27 490 = 2,749 %), total exact 1 000 000.
-- Multiplicateurs : 1 = aucun effet sur cette stat.

local Helpers = require(script.Parent.Helpers)

export type Instinct = {
	id: string,
	displayName: string,
	perMillion: number,
	coinsMultiplier: number,
	healthMultiplier: number,
	damageMultiplier: number,
}

local function instinct(
	id: string,
	displayName: string,
	perMillion: number,
	coins: number,
	health: number,
	damage: number
): Instinct
	return {
		id = id,
		displayName = displayName,
		perMillion = perMillion,
		coinsMultiplier = coins,
		healthMultiplier = health,
		damageMultiplier = damage,
	}
end

-- stylua: ignore
local Instincts: { Instinct } = {
	instinct("none", "Aucun", 0, 1, 1, 1), -- reste
	instinct("voracious_1", "Vorace I", 250_000, 1.2, 1, 1),
	instinct("voracious_2", "Vorace II", 60_000, 1.5, 1, 1),
	instinct("voracious_3", "Vorace III", 12_000, 2, 1, 1),
	instinct("sturdy_1", "Robuste I", 250_000, 1, 1.2, 1),
	instinct("sturdy_2", "Robuste II", 60_000, 1, 1.5, 1),
	instinct("sturdy_3", "Robuste III", 12_000, 1, 2, 1),
	instinct("fierce_1", "Féroce I", 250_000, 1, 1, 1.2),
	instinct("fierce_2", "Féroce II", 60_000, 1, 1, 1.5),
	instinct("fierce_3", "Féroce III", 12_000, 1, 1, 2),
	instinct("alpha", "Alpha", 5_000, 3, 3, 3),
	instinct("pack_leader", "Chef de Meute", 1_200, 5, 5, 5),
	instinct("ancient_king", "Roi Ancien", 250, 8, 8, 8),
	instinct("primordial", "Primordial", 60, 15, 15, 15),
}

-- Instincts[1] ("none") = instinct d'un dino tout juste tiré.
return Helpers.withRemainder(Instincts, "none")
