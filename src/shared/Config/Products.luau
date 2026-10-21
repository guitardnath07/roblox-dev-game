--!strict
-- Produits développeur (Robux) et potions. Jamais de Fossiles à vendre, jamais de « Jackpot » payant.
-- `productId` = 0 : à remplir après création sur Roblox.
-- shortcut: montants et durées proposés (CLAUDE.md ne liste que les familles de produits).

export type PotionStat = "luck" | "coins" | "rollSpeed"

export type Potion = {
	id: string,
	displayName: string,
	stat: PotionStat,
	multiplier: number,
	durationSeconds: number,
}

export type ProductKind = "amber" | "bones" | "potion" | "dino"

export type Product = {
	id: string,
	displayName: string,
	productId: number,
	kind: ProductKind,
	amount: number, -- Ambre / Os reçus, ou nombre de potions
	potionId: string?, -- seulement si kind == "potion"
	dinoId: string?, -- seulement si kind == "dino" : un exemplaire (sans mutation) d'un dino exclusif
}

-- stylua: ignore
local Potions: { Potion } = {
	{ id = "luck_potion", displayName = "Potion de Chance", stat = "luck", multiplier = 2, durationSeconds = 15 * 60 },
	{ id = "super_luck_potion", displayName = "Super Potion de Chance", stat = "luck", multiplier = 3, durationSeconds = 15 * 60 },
	{ id = "coins_potion", displayName = "Potion de Fossiles", stat = "coins", multiplier = 2, durationSeconds = 15 * 60 },
	{ id = "speed_potion", displayName = "Potion de Vitesse", stat = "rollSpeed", multiplier = 1.5, durationSeconds = 15 * 60 },
}

-- stylua: ignore
local Products: { Product } = {
	{ id = "amber_small", displayName = "Poignée d'Ambre", productId = 0, kind = "amber", amount = 100 },
	{ id = "amber_medium", displayName = "Bocal d'Ambre", productId = 0, kind = "amber", amount = 600 },
	{ id = "amber_large", displayName = "Coffre d'Ambre", productId = 0, kind = "amber", amount = 2_000 },
	{ id = "fossils_small", displayName = "Sachet d'Os", productId = 0, kind = "bones", amount = 100 },
	{ id = "fossils_medium", displayName = "Caisse d'Os", productId = 0, kind = "bones", amount = 600 },
	{ id = "fossils_large", displayName = "Musée d'Os", productId = 0, kind = "bones", amount = 2_000 },
	{ id = "luck_potion_x3", displayName = "3 Potions de Chance", productId = 0, kind = "potion", amount = 3, potionId = "luck_potion" },
	{ id = "super_luck_potion_x3", displayName = "3 Super Potions de Chance", productId = 0, kind = "potion", amount = 3, potionId = "super_luck_potion" },
	{ id = "coins_potion_x3", displayName = "3 Potions de Fossiles", productId = 0, kind = "potion", amount = 3, potionId = "coins_potion" },
	{ id = "peluchorex", displayName = "Peluchorex (Exclusif)", productId = 0, kind = "dino", amount = 1, dinoId = "peluchorex" },
}

for _, potion in Potions do
	table.freeze(potion)
end
for _, product in Products do
	table.freeze(product)
end

return table.freeze({
	potions = table.freeze(Potions),
	products = table.freeze(Products),
})
