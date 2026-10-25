--!strict
-- Reliques : équipement du joueur (Tête, Torse, Dos, Taille, Bras), gagnées au Volcan des Défis.
-- Interprétation de CLAUDE.md (« 0,5 % dès l'étage 25, 0,25 % dès 60, 0,02 % dès 90 ») : 3 tiers de reliques ;
-- chaque étage gagné tente chaque tier débloqué, indépendamment (`dropPerMillion` sur 1 000 000).
-- shortcut: noms et effets des reliques proposés.

local Helpers = require(script.Parent.Helpers)

export type SlotId = "head" | "torso" | "back" | "waist" | "arms"

export type Slot = { id: SlotId, displayName: string }

export type Tier = {
	tier: number,
	fromFloor: number,
	dropPerMillion: number,
	sellFossils: number, -- prix au Comptoir de vente
}

export type RelicStat = "luckBonus" | "coinsBonus" | "damageBonus" | "healthBonus" | "rollSpeedBonus"

export type Relic = {
	id: string,
	displayName: string,
	slot: SlotId,
	tier: number,
	stat: RelicStat,
	value: number, -- bonus additif (0.05 = +5 %)
}

-- stylua: ignore
local Slots: { Slot } = {
	{ id = "head", displayName = "Tête" },
	{ id = "torso", displayName = "Torse" },
	{ id = "back", displayName = "Dos" },
	{ id = "waist", displayName = "Taille" },
	{ id = "arms", displayName = "Bras" },
}

-- stylua: ignore
local Tiers: { Tier } = {
	-- shortcut: prix de vente proposés, à ajuster après les tests.
	{ tier = 1, fromFloor = 25, dropPerMillion = 5_000, sellFossils = 50_000 }, -- 0,5 %
	{ tier = 2, fromFloor = 60, dropPerMillion = 2_500, sellFossils = 5e6 }, -- 0,25 %
	{ tier = 3, fromFloor = 90, dropPerMillion = 200, sellFossils = 500e6 }, -- 0,02 %
}

-- stylua: ignore
local Relics: { Relic } = {
	{ id = "fern_crown", displayName = "Couronne de Fougère", slot = "head", tier = 1, stat = "luckBonus", value = 0.05 },
	{ id = "bone_helmet", displayName = "Casque d'Os", slot = "head", tier = 2, stat = "luckBonus", value = 0.15 },
	{ id = "comet_diadem", displayName = "Diadème de Comète", slot = "head", tier = 3, stat = "luckBonus", value = 0.40 },
	{ id = "leaf_vest", displayName = "Gilet de Feuilles", slot = "torso", tier = 1, stat = "healthBonus", value = 0.10 },
	{ id = "scale_armor", displayName = "Armure d'Écailles", slot = "torso", tier = 2, stat = "healthBonus", value = 0.30 },
	{ id = "magma_plate", displayName = "Plastron de Magma", slot = "torso", tier = 3, stat = "healthBonus", value = 0.80 },
	{ id = "explorer_bag", displayName = "Sac d'Explorateur", slot = "back", tier = 1, stat = "coinsBonus", value = 0.05 },
	{ id = "amber_backpack", displayName = "Hotte d'Ambre", slot = "back", tier = 2, stat = "coinsBonus", value = 0.15 },
	{ id = "nebula_wings", displayName = "Ailes de Nébuleuse", slot = "back", tier = 3, stat = "coinsBonus", value = 0.40 },
	{ id = "vine_belt", displayName = "Ceinture de Lianes", slot = "waist", tier = 1, stat = "rollSpeedBonus", value = 0.03 },
	{ id = "fossil_belt", displayName = "Ceinture Fossile", slot = "waist", tier = 2, stat = "rollSpeedBonus", value = 0.08 },
	{ id = "chrono_belt", displayName = "Ceinture Chrono", slot = "waist", tier = 3, stat = "rollSpeedBonus", value = 0.20 },
	{ id = "claw_gloves", displayName = "Gants à Griffes", slot = "arms", tier = 1, stat = "damageBonus", value = 0.10 },
	{ id = "lava_bracers", displayName = "Brassards de Lave", slot = "arms", tier = 2, stat = "damageBonus", value = 0.30 },
	{ id = "titan_gauntlets", displayName = "Gantelets du Titan", slot = "arms", tier = 3, stat = "damageBonus", value = 0.80 },
}

return table.freeze({
	slots = Helpers.freezeList(Slots),
	tiers = Helpers.freezeList(Tiers),
	list = Helpers.freezeList(Relics),
})
