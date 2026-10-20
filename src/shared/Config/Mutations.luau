--!strict
-- Mutations fixées au tirage, non modifiables. `perMillion` = chance sur 1 000 000 ;
-- la ligne « normal » reçoit le reste, chaque liste fait donc exactement 1 000 000.

local Helpers = require(script.Parent.Helpers)

export type Size = {
	id: string,
	displayName: string,
	perMillion: number,
	coinsMultiplier: number,
	modelScale: number,
}

export type Skin = {
	id: string,
	displayName: string,
	perMillion: number,
	coinsMultiplier: number,
	color: string?, -- teinte du corps du modèle 3D (« rainbow » : dégradé arc-en-ciel)
}

-- stylua: ignore
local Sizes: { Size } = {
	{ id = "baby", displayName = "Bébé", perMillion = 100_000, coinsMultiplier = 0.8, modelScale = 0.7 }, -- 10 %
	{ id = "normal", displayName = "Normal", perMillion = 0, coinsMultiplier = 1, modelScale = 1 }, -- reste = 85 %
	{ id = "giant", displayName = "Géant", perMillion = 45_000, coinsMultiplier = 2, modelScale = 1.5 }, -- 4,5 %
	{ id = "colossal", displayName = "Colossal", perMillion = 5_000, coinsMultiplier = 5, modelScale = 2 }, -- 0,5 %
}

-- stylua: ignore
local Skins: { Skin } = {
	{ id = "normal", displayName = "Normale", perMillion = 0, coinsMultiplier = 1 }, -- reste = 90 %
	{ id = "amber", displayName = "Ambre", perMillion = 60_000, coinsMultiplier = 1.5, color = "#E89B2E" }, -- 6 %
	{ id = "jade", displayName = "Jade", perMillion = 25_000, coinsMultiplier = 2.5, color = "#3DAE7C" }, -- 2,5 %
	{ id = "obsidian", displayName = "Obsidienne", perMillion = 10_000, coinsMultiplier = 4, color = "#2A2233" }, -- 1 %
	{ id = "fossil_gold", displayName = "Or fossile", perMillion = 4_500, coinsMultiplier = 8, color = "#D9B23C" }, -- 0,45 %
	{ id = "rainbow", displayName = "Arc-en-ciel", perMillion = 500, coinsMultiplier = 20 }, -- 0,05 %
}

return table.freeze({
	defaultId = "normal", -- taille et peau sans mutation
	Sizes = Helpers.withRemainder(Sizes, "normal"),
	Skins = Helpers.withRemainder(Skins, "normal"),
})
