--!strict
-- Empreintes : débloquées au rebirth 5, bonus passif quand le dino est posé.
-- `perMillion` = chance sur 1 000 000 ; « velocity_1 » reçoit le reste, total exact 1 000 000.
-- shortcut: PROPOSITION à valider (CLAUDE.md « À trancher ») : obtention par tirage payé en Pièces
-- (`rollCostCoins`), chances de Flair / Trésor / Vélocité et effet chiffré de Vélocité inventés ici ;
-- seul Paléontologue (90 = 0,009 %) vient de CLAUDE.md. Voir docs/equilibrage.md.

local Helpers = require(script.Parent.Helpers)

export type Imprint = {
	id: string,
	displayName: string,
	perMillion: number,
	luckBonus: number, -- +X % de chance (0.10 = +10 %)
	coinsBonus: number, -- +X % de Pièces
	rollSpeedBonus: number, -- +X % de vitesse de lancer
}

local function imprint(
	id: string,
	displayName: string,
	perMillion: number,
	luckBonus: number,
	coinsBonus: number,
	rollSpeedBonus: number
): Imprint
	return {
		id = id,
		displayName = displayName,
		perMillion = perMillion,
		luckBonus = luckBonus,
		coinsBonus = coinsBonus,
		rollSpeedBonus = rollSpeedBonus,
	}
end

-- stylua: ignore
local Imprints: { Imprint } = {
	imprint("flair_1", "Flair I", 300_000, 0.10, 0, 0), -- 30 %
	imprint("flair_2", "Flair II", 30_000, 0.25, 0, 0), -- 3 %
	imprint("flair_3", "Flair III", 3_000, 0.50, 0, 0), -- 0,3 %
	imprint("treasure_1", "Trésor I", 300_000, 0, 0.10, 0), -- 30 %
	imprint("treasure_2", "Trésor II", 30_000, 0, 0.25, 0), -- 3 %
	imprint("treasure_3", "Trésor III", 3_000, 0, 0.50, 0), -- 0,3 %
	imprint("velocity_1", "Vélocité I", 0, 0, 0, 0.10), -- reste = 30,091 %
	imprint("velocity_2", "Vélocité II", 30_000, 0, 0, 0.20), -- 3 %
	imprint("velocity_3", "Vélocité III", 3_000, 0, 0, 0.35), -- 0,3 %
	imprint("paleontologist", "Paléontologue", 90, 0.15, 0.75, 0), -- 0,009 % (CLAUDE.md)
}

return table.freeze({
	unlockRebirth = 5,
	rollCostCoins = 1e9, -- shortcut: proposition, 1 Md par tirage d'Empreinte
	list = Helpers.withRemainder(Imprints, "velocity_1"),
})
