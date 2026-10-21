--!strict
-- Raretés, du plus commun (order 1) au plus rare (order 8), puis « Exclusif » (order 9) : jamais tiré au dé,
-- obtenu seulement par achat (voir Config/Products, kind « dino »).
-- `effect` = effet visuel côté client : "shimmer" (reflet animé) ou "rainbow" (arc-en-ciel animé).
-- `revealSoundId` = son de révélation ; 0 = à remplir quand les sons seront uploadés.

export type RarityId =
	"common"
	| "uncommon"
	| "rare"
	| "epic"
	| "legendary"
	| "mythic"
	| "primordial"
	| "secret"
	| "exclusive"

export type Effect = "none" | "shimmer" | "rainbow"

export type Rarity = {
	id: RarityId,
	displayName: string,
	order: number,
	color: Color3,
	effect: Effect,
	revealSoundId: number,
}

local function rarity(id: RarityId, displayName: string, order: number, hex: string, effect: Effect): Rarity
	return table.freeze({
		id = id,
		displayName = displayName,
		order = order,
		color = Color3.fromHex(hex),
		effect = effect,
		revealSoundId = 0,
	})
end

local Rarities: { [RarityId]: Rarity } = {
	common = rarity("common", "Commun", 1, "#9AA0A6", "none"),
	uncommon = rarity("uncommon", "Peu commun", 2, "#4CAF50", "none"),
	rare = rarity("rare", "Rare", 3, "#2196F3", "none"),
	epic = rarity("epic", "Épique", 4, "#9C27B0", "none"),
	legendary = rarity("legendary", "Légendaire", 5, "#FF9800", "none"),
	mythic = rarity("mythic", "Mythique", 6, "#E53935", "none"),
	primordial = rarity("primordial", "Primordial", 7, "#1DE9B6", "shimmer"), -- turquoise animé
	secret = rarity("secret", "Secret", 8, "#FFFFFF", "rainbow"), -- couleur de base, l'arc-en-ciel est animé
	exclusive = rarity("exclusive", "Exclusif", 9, "#FF4FA3", "shimmer"), -- rose animé
}

return table.freeze(Rarities)
