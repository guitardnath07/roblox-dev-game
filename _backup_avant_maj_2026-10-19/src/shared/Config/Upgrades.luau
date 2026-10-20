--!strict
-- Arbre d'améliorations hexagonal, acheté avec des Pièces.
-- Chaque branche agit sur UNE stat ; `value` = valeur TOTALE de la stat quand ce nœud est le plus haut acheté
-- de sa branche (ex. Pièces III = x1,5 au total, pas x1,5 de plus). Sac : `value` = nombre de places.
-- `prerequisite` = nœud à posséder avant ; nil = relié au centre de l'arbre (case q = 0, r = 0, sans nœud).
-- Position en coordonnées hexagonales axiales (q, r). `id` ne change jamais.
-- shortcut: coûts et valeurs (hors Sac et Vitesse de marche, donnés par CLAUDE.md) proposés, voir docs/equilibrage.md.

local Economy = require(script.Parent.Economy)

export type Stat =
	"coinsMultiplier"
	| "luckMultiplier"
	| "rollSpeedMultiplier"
	| "backpackSize"
	| "sellMultiplier"
	| "walkSpeedBonus"
	| "damageMultiplier"
	| "healthMultiplier"

export type Branch = "coins" | "luck" | "roll_speed" | "backpack" | "sell" | "walk_speed" | "damage" | "health"

export type Upgrade = {
	id: string,
	displayName: string,
	branch: Branch,
	cost: number, -- en Pièces
	stat: Stat,
	value: number,
	prerequisite: string?,
	q: number,
	r: number,
}

local function node(
	id: string,
	displayName: string,
	branch: Branch,
	cost: number,
	stat: Stat,
	value: number,
	prerequisite: string?,
	q: number,
	r: number
): Upgrade
	return table.freeze({
		id = id,
		displayName = displayName,
		branch = branch,
		cost = cost,
		stat = stat,
		value = value,
		prerequisite = prerequisite,
		q = q,
		r = r,
	})
end

-- stylua: ignore
local Upgrades: { Upgrade } = {
	-- Pièces : vers l'est (q+).
	node("coins_1", "Pièces I", "coins", 1_000, "coinsMultiplier", 1.1, nil, 1, 0),
	node("coins_2", "Pièces II", "coins", 15_000, "coinsMultiplier", 1.25, "coins_1", 2, 0),
	node("coins_3", "Pièces III", "coins", 250_000, "coinsMultiplier", 1.5, "coins_2", 3, 0),
	node("coins_4", "Pièces IV", "coins", 5e6, "coinsMultiplier", 2, "coins_3", 4, 0),
	node("coins_5", "Pièces V", "coins", 150e6, "coinsMultiplier", 3, "coins_4", 5, 0),
	node("coins_6", "Pièces VI", "coins", 5e9, "coinsMultiplier", 4, "coins_5", 6, 0),
	-- Chance : vers l'ouest (q-).
	node("luck_1", "Chance I", "luck", 2_000, "luckMultiplier", 1.1, nil, -1, 0),
	node("luck_2", "Chance II", "luck", 30_000, "luckMultiplier", 1.25, "luck_1", -2, 0),
	node("luck_3", "Chance III", "luck", 500_000, "luckMultiplier", 1.5, "luck_2", -3, 0),
	node("luck_4", "Chance IV", "luck", 10e6, "luckMultiplier", 2, "luck_3", -4, 0),
	node("luck_5", "Chance V", "luck", 300e6, "luckMultiplier", 3, "luck_4", -5, 0),
	node("luck_6", "Chance VI", "luck", 10e9, "luckMultiplier", 4, "luck_5", -6, 0),
	-- Vitesse de lancer : greffée sur Chance II.
	node("roll_speed_1", "Vitesse de lancer I", "roll_speed", 20_000, "rollSpeedMultiplier", 1.25, "luck_2", -2, -1),
	node("roll_speed_2", "Vitesse de lancer II", "roll_speed", 2e6, "rollSpeedMultiplier", 1.5, "roll_speed_1", -2, -2),
	-- Sac : vers le nord-est (r-). Places : 30 (Economy.startingBackpackSize) -> 50 -> 80 -> 120 -> 200.
	node("backpack_1", "Sac I", "backpack", 2_500, "backpackSize", 50, nil, 0, -1),
	node("backpack_2", "Sac II", "backpack", 40_000, "backpackSize", 80, "backpack_1", 0, -2),
	node("backpack_3", "Sac III", "backpack", 1e6, "backpackSize", 120, "backpack_2", 0, -3),
	node("backpack_4", "Sac IV", "backpack", 50e6, "backpackSize", 200, "backpack_3", 0, -4),
	-- Vente : vers le sud-ouest (r+).
	node("sell_1", "Vente I", "sell", 5_000, "sellMultiplier", 1.25, nil, 0, 1),
	node("sell_2", "Vente II", "sell", 200_000, "sellMultiplier", 1.5, "sell_1", 0, 2),
	node("sell_3", "Vente III", "sell", 20e6, "sellMultiplier", 2, "sell_2", 0, 3),
	-- Vitesse de marche : greffée sur Vente I. +2 / +4 / +6 WalkSpeed au total.
	node("walk_speed_1", "Vitesse de marche I", "walk_speed", 1_000, "walkSpeedBonus", 2, "sell_1", 1, 1),
	node("walk_speed_2", "Vitesse de marche II", "walk_speed", 25_000, "walkSpeedBonus", 4, "walk_speed_1", 2, 1),
	node("walk_speed_3", "Vitesse de marche III", "walk_speed", 500_000, "walkSpeedBonus", 6, "walk_speed_2", 3, 1),
	-- Dégâts : vers le nord (q+, r-).
	node("damage_1", "Dégâts I", "damage", 50_000, "damageMultiplier", 1.2, nil, 1, -1),
	node("damage_2", "Dégâts II", "damage", 1e6, "damageMultiplier", 1.5, "damage_1", 2, -2),
	node("damage_3", "Dégâts III", "damage", 50e6, "damageMultiplier", 2, "damage_2", 3, -3),
	node("damage_4", "Dégâts IV", "damage", 2e9, "damageMultiplier", 3, "damage_3", 4, -4),
	node("damage_5", "Dégâts V", "damage", 100e9, "damageMultiplier", 5, "damage_4", 5, -5),
	-- PV : vers le sud (q-, r+).
	node("health_1", "PV I", "health", 50_000, "healthMultiplier", 1.2, nil, -1, 1),
	node("health_2", "PV II", "health", 1e6, "healthMultiplier", 1.5, "health_1", -2, 2),
	node("health_3", "PV III", "health", 50e6, "healthMultiplier", 2, "health_2", -3, 3),
	node("health_4", "PV IV", "health", 2e9, "healthMultiplier", 3, "health_3", -4, 4),
	node("health_5", "PV V", "health", 100e9, "healthMultiplier", 5, "health_4", -5, 5),
}

-- Valeur d'une stat quand aucun nœud de sa branche n'est acheté.
local baseValues: { [Stat]: number } = {
	coinsMultiplier = 1,
	luckMultiplier = 1,
	rollSpeedMultiplier = 1,
	backpackSize = Economy.startingBackpackSize,
	sellMultiplier = 1,
	walkSpeedBonus = 0,
	damageMultiplier = 1,
	healthMultiplier = 1,
}

return table.freeze({
	list = table.freeze(Upgrades),
	baseValues = table.freeze(baseValues),
})
