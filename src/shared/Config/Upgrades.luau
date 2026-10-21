--!strict
-- Arbre d'améliorations (façon Slime RNG) : un centre, des branches en étoile, une couleur vive par catégorie.
-- Acheté avec des Fossiles. Chaque branche agit sur UNE stat ; `value` = valeur TOTALE de la stat quand ce nœud est
-- le plus haut acheté de sa branche (ex. Chance III = x1,5 au total). Sac : `value` = nombre de places.
-- Nœuds spéciaux : stat « autoRoll » (débloque l'Auto-Lancer), « equipBest » (débloque « Équiper les meilleurs » du sac) et « diceUnlock » (`unlocksDie` = dé offert, Config/Dice).
-- `prerequisite` = nœud à posséder avant ; nil = relié au centre (q = 0, r = 0, sans nœud).
-- Position en coordonnées hexagonales axiales (q, r). `id` ne change jamais (sauvegardé dans le profil).
-- Prix calés sur la progression simulée (VERIFICATION.md) : dé 5 ≈ 17 min, dé 7 ≈ 1 h, dé 9 ≈ 3 h 20, dé 10 ≈ 6 h.
-- Les premières cases de chaque branche tombent dans les 10 premières minutes ; les dernières demandent des heures
-- et plusieurs rebirths (les dés spéciaux arrivent au même moment que les dés de boutique de puissance voisine).

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
	| "skinMutationMultiplier"
	| "offlineRate"
	| "autoRoll"
	| "equipBest"
	| "diceUnlock"

export type Branch =
	"coins"
	| "luck"
	| "roll_speed"
	| "backpack"
	| "sell"
	| "walk_speed"
	| "damage"
	| "health"
	| "mutation"
	| "offline"
	| "auto"
	| "dice"

export type Upgrade = {
	id: string,
	displayName: string,
	branch: Branch,
	cost: number, -- en Fossiles
	stat: Stat,
	value: number,
	prerequisite: string?,
	q: number,
	r: number,
	unlocksDie: string?, -- stat « diceUnlock » : id du dé offert
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
	r: number,
	unlocksDie: string?
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
		unlocksDie = unlocksDie,
	})
end

-- stylua: ignore
local Upgrades: { Upgrade } = {
	-- 🐚 Revenu (jaune) : vers l'est.
	node("coins_1", "Revenu I", "coins", 1_000, "coinsMultiplier", 1.1, nil, 1, 0),
	node("coins_2", "Revenu II", "coins", 15_000, "coinsMultiplier", 1.25, "coins_1", 2, 0),
	node("coins_3", "Revenu III", "coins", 250_000, "coinsMultiplier", 1.5, "coins_2", 3, 0),
	node("coins_4", "Revenu IV", "coins", 5e6, "coinsMultiplier", 2, "coins_3", 4, 0),
	node("coins_5", "Revenu V", "coins", 150e6, "coinsMultiplier", 3, "coins_4", 5, 0),
	node("coins_6", "Revenu VI", "coins", 5e9, "coinsMultiplier", 4, "coins_5", 6, 0),
	node("coins_7", "Revenu VII", "coins", 200e9, "coinsMultiplier", 6, "coins_6", 7, 0),

	-- 🍀 Chance (vert) : vers l'ouest. La branche la plus longue : c'est le cœur d'un jeu RNG.
	node("luck_1", "Chance I", "luck", 2_000, "luckMultiplier", 1.1, nil, -1, 0),
	node("luck_2", "Chance II", "luck", 30_000, "luckMultiplier", 1.25, "luck_1", -2, 0),
	node("luck_3", "Chance III", "luck", 500_000, "luckMultiplier", 1.5, "luck_2", -3, 0),
	node("luck_4", "Chance IV", "luck", 10e6, "luckMultiplier", 2, "luck_3", -4, 0),
	node("luck_5", "Chance V", "luck", 300e6, "luckMultiplier", 3, "luck_4", -5, 0),
	node("luck_6", "Chance VI", "luck", 10e9, "luckMultiplier", 4, "luck_5", -6, 0),
	node("luck_7", "Chance VII", "luck", 300e9, "luckMultiplier", 6, "luck_6", -7, 0),
	node("luck_8", "Chance VIII", "luck", 10e12, "luckMultiplier", 10, "luck_7", -8, 0),

	-- 🤖 Auto-Lancer (rose) : juste à côté de Chance I. ~8 min de jeu : le premier vrai objectif.
	node("auto_roll", "Auto-Lancer", "auto", 10_000, "autoRoll", 1, "luck_1", -1, -1),
	-- shortcut: prix proposé (dans les 5 premières minutes), à ajuster après les tests.
	node("equip_best", "Équiper les meilleurs", "auto", 3_000, "equipBest", 1, "backpack_1", 1, -2),

	-- ⚡ Vitesse de lancer (cyan) : greffée sur Chance II, vers le nord.
	node("roll_speed_1", "Vitesse I", "roll_speed", 20_000, "rollSpeedMultiplier", 1.15, "luck_2", -2, -1),
	node("roll_speed_2", "Vitesse II", "roll_speed", 500_000, "rollSpeedMultiplier", 1.3, "roll_speed_1", -2, -2),
	node("roll_speed_3", "Vitesse III", "roll_speed", 20e6, "rollSpeedMultiplier", 1.5, "roll_speed_2", -2, -3),
	node("roll_speed_4", "Vitesse IV", "roll_speed", 2e9, "rollSpeedMultiplier", 1.75, "roll_speed_3", -2, -4),
	node("roll_speed_5", "Vitesse V", "roll_speed", 200e9, "rollSpeedMultiplier", 2, "roll_speed_4", -2, -5),

	-- 🎲 Dés spéciaux (or / diamant / arc-en-ciel) : greffés sur Chance III, vers le sud-ouest.
	-- Chance du dé entre celle des dés de boutique voisins, prix comparable au même moment de la partie.
	node("dice_golden", "Dé en Or", "dice", 150_000, "diceUnlock", 1, "luck_3", -3, 1, "golden"),
	node("dice_diamond", "Dé de Diamant", "dice", 50e6, "diceUnlock", 1, "dice_golden", -4, 2, "diamond"),
	node("dice_rainbow", "Dé Arc-en-ciel", "dice", 3e9, "diceUnlock", 1, "dice_diamond", -5, 3, "rainbow"),

	-- 🎒 Sac (orange) : vers le nord-est. Places : 30 (Economy.startingBackpackSize) -> 50 -> 80 -> 120 -> 200 -> 300.
	node("backpack_1", "Sac I", "backpack", 2_500, "backpackSize", 50, nil, 0, -1),
	node("backpack_2", "Sac II", "backpack", 40_000, "backpackSize", 80, "backpack_1", 0, -2),
	node("backpack_3", "Sac III", "backpack", 1e6, "backpackSize", 120, "backpack_2", 0, -3),
	node("backpack_4", "Sac IV", "backpack", 50e6, "backpackSize", 200, "backpack_3", 0, -4),
	node("backpack_5", "Sac V", "backpack", 5e9, "backpackSize", 300, "backpack_4", 0, -5),

	-- 🏷️ Vente (bleu) : vers le sud-ouest. Multiplie l'argent gagné en vendant des dinos.
	node("sell_1", "Vente I", "sell", 5_000, "sellMultiplier", 1.25, nil, 0, 1),
	node("sell_2", "Vente II", "sell", 200_000, "sellMultiplier", 1.5, "sell_1", 0, 2),
	node("sell_3", "Vente III", "sell", 20e6, "sellMultiplier", 2, "sell_2", 0, 3),
	node("sell_4", "Vente IV", "sell", 2e9, "sellMultiplier", 3, "sell_3", 0, 4),

	-- 👟 Vitesse de marche (menthe) : greffée sur Vente I. +2 / +4 / +6 WalkSpeed au total.
	node("walk_speed_1", "Marche I", "walk_speed", 1_000, "walkSpeedBonus", 2, "sell_1", -1, 2),
	node("walk_speed_2", "Marche II", "walk_speed", 25_000, "walkSpeedBonus", 4, "walk_speed_1", -2, 3),
	node("walk_speed_3", "Marche III", "walk_speed", 500_000, "walkSpeedBonus", 6, "walk_speed_2", -3, 4),

	-- ⚔️ Dégâts (violet) : vers le nord-est en diagonale. Pour le Volcan des Défis.
	node("damage_1", "Dégâts I", "damage", 50_000, "damageMultiplier", 1.2, nil, 1, -1),
	node("damage_2", "Dégâts II", "damage", 1e6, "damageMultiplier", 1.5, "damage_1", 2, -2),
	node("damage_3", "Dégâts III", "damage", 50e6, "damageMultiplier", 2, "damage_2", 3, -3),
	node("damage_4", "Dégâts IV", "damage", 2e9, "damageMultiplier", 3, "damage_3", 4, -4),
	node("damage_5", "Dégâts V", "damage", 100e9, "damageMultiplier", 5, "damage_4", 5, -5),

	-- ❤️ Santé (rouge) : vers le sud-ouest en diagonale. Pour le Volcan des Défis.
	node("health_1", "Santé I", "health", 50_000, "healthMultiplier", 1.2, nil, -1, 1),
	node("health_2", "Santé II", "health", 1e6, "healthMultiplier", 1.5, "health_1", -2, 2),
	node("health_3", "Santé III", "health", 50e6, "healthMultiplier", 2, "health_2", -3, 3),
	node("health_4", "Santé IV", "health", 2e9, "healthMultiplier", 3, "health_3", -4, 4),
	node("health_5", "Santé V", "health", 100e9, "healthMultiplier", 5, "health_4", -5, 5),

	-- ✨ Mutations (magenta) : greffées sur Revenu III. Chances des peaux spéciales (Ambre, Jade… Arc-en-ciel).
	node("mutation_1", "Mutations I", "mutation", 100_000, "skinMutationMultiplier", 1.25, "coins_3", 4, -1),
	node("mutation_2", "Mutations II", "mutation", 25e6, "skinMutationMultiplier", 1.5, "mutation_1", 5, -2),
	node("mutation_3", "Mutations III", "mutation", 5e9, "skinMutationMultiplier", 2, "mutation_2", 6, -3),

	-- 🌙 Gains hors ligne (indigo) : greffés sur Revenu II. Part du revenu gagnée pendant l'absence (50 % de base).
	node("offline_1", "Hors ligne I", "offline", 50_000, "offlineRate", 0.6, "coins_2", 2, 1),
	node("offline_2", "Hors ligne II", "offline", 5e6, "offlineRate", 0.75, "offline_1", 2, 2),
	node("offline_3", "Hors ligne III", "offline", 500e6, "offlineRate", 1, "offline_2", 2, 3),
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
	skinMutationMultiplier = 1,
	offlineRate = Economy.offlineRate,
	autoRoll = 0, -- 1 = débloqué
	equipBest = 0, -- 1 = débloqué
	diceUnlock = 0,
}

return table.freeze({
	list = table.freeze(Upgrades),
	baseValues = table.freeze(baseValues),
})
