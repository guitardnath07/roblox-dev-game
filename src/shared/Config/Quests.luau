--!strict
-- Quêtes quotidiennes et hebdomadaires -> Tickets d'Expédition, dépensés dans la boutique de quêtes.
-- Chaque jour (resp. semaine) on tire `dailyCount` (resp. `weeklyCount`) quêtes dans le pool.
-- `{n}` dans displayName est remplacé par `target`. shortcut: objectifs, récompenses et prix proposés.

local Helpers = require(script.Parent.Helpers)

export type QuestKind =
	"rolls" -- lancer N fois
	| "roll_rarity" -- obtenir N dinos de rareté `rarity` ou mieux
	| "sell" -- vendre N dinos
	| "volcano_floors" -- gagner N étages du Volcan
	| "play_minutes" -- jouer N minutes
	| "upgrade_pedestal" -- monter N niveaux de socles
	| "reroll_grade" -- relancer N Grades
	| "reroll_instinct" -- relancer N Instincts

export type Quest = {
	id: string,
	displayName: string,
	kind: QuestKind,
	target: number,
	rarity: string?, -- Rarities id, seulement pour roll_rarity
	tickets: number,
}

export type ShopItem = {
	id: string,
	displayName: string,
	priceTickets: number,
	amber: number,
	bones: number,
	goldenRolls: number,
	potionId: string?, -- Products.potions id
}

-- stylua: ignore
local Daily: { Quest } = {
	{ id = "daily_rolls_300", displayName = "Lancer {n} fois", kind = "rolls", target = 300, tickets = 3 },
	{ id = "daily_rolls_1000", displayName = "Lancer {n} fois", kind = "rolls", target = 1_000, tickets = 6 },
	{ id = "daily_rare_10", displayName = "Obtenir {n} dinos Rares ou mieux", kind = "roll_rarity", target = 10, rarity = "rare", tickets = 4 },
	{ id = "daily_epic_3", displayName = "Obtenir {n} dinos Épiques ou mieux", kind = "roll_rarity", target = 3, rarity = "epic", tickets = 5 },
	{ id = "daily_sell_50", displayName = "Vendre {n} dinos", kind = "sell", target = 50, tickets = 3 },
	{ id = "daily_volcano_3", displayName = "Gagner {n} étages du Volcan", kind = "volcano_floors", target = 3, tickets = 4 },
	{ id = "daily_play_20", displayName = "Jouer {n} minutes", kind = "play_minutes", target = 20, tickets = 3 },
	{ id = "daily_pedestal_5", displayName = "Monter {n} niveaux de socles", kind = "upgrade_pedestal", target = 5, tickets = 3 },
}

-- stylua: ignore
local Weekly: { Quest } = {
	{ id = "weekly_rolls_10000", displayName = "Lancer {n} fois", kind = "rolls", target = 10_000, tickets = 25 },
	{ id = "weekly_legendary_3", displayName = "Obtenir {n} dinos Légendaires ou mieux", kind = "roll_rarity", target = 3, rarity = "legendary", tickets = 30 },
	{ id = "weekly_volcano_20", displayName = "Gagner {n} étages du Volcan", kind = "volcano_floors", target = 20, tickets = 30 },
	{ id = "weekly_grade_20", displayName = "Relancer {n} Grades", kind = "reroll_grade", target = 20, tickets = 20 },
	{ id = "weekly_instinct_20", displayName = "Relancer {n} Instincts", kind = "reroll_instinct", target = 20, tickets = 20 },
	{ id = "weekly_play_300", displayName = "Jouer {n} minutes", kind = "play_minutes", target = 300, tickets = 25 },
}

-- stylua: ignore
local Shop: { ShopItem } = {
	{ id = "shop_luck_potion", displayName = "Potion de Chance", priceTickets = 10, amber = 0, bones = 0, goldenRolls = 0, potionId = "luck_potion" },
	{ id = "shop_coins_potion", displayName = "Potion de Fossiles", priceTickets = 10, amber = 0, bones = 0, goldenRolls = 0, potionId = "coins_potion" },
	{ id = "shop_speed_potion", displayName = "Potion de Vitesse", priceTickets = 8, amber = 0, bones = 0, goldenRolls = 0, potionId = "speed_potion" },
	{ id = "shop_amber_30", displayName = "30 Ambre", priceTickets = 6, amber = 30, bones = 0, goldenRolls = 0 },
	{ id = "shop_fossils_30", displayName = "30 Os", priceTickets = 6, amber = 0, bones = 30, goldenRolls = 0 },
	{ id = "shop_golden_roll", displayName = "Lancer Doré", priceTickets = 5, amber = 0, bones = 0, goldenRolls = 1 },
}

return table.freeze({
	dailyCount = 3,
	weeklyCount = 3,
	daily = Helpers.freezeList(Daily),
	weekly = Helpers.freezeList(Weekly),
	shop = Helpers.freezeList(Shop),
})
