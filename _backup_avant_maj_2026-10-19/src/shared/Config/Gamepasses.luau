--!strict
-- Game Passes (Robux). Les Pièces ne se vendent jamais. `gamePassId` = 0 : à remplir après création sur Roblox.
-- Multiplicateurs : 1 = aucun effet ; bonus = ajout (0.10 = +10 %).

export type Gamepass = {
	id: string,
	displayName: string,
	gamePassId: number,
	luckMultiplier: number,
	coinsMultiplier: number,
	rollSpeedMultiplier: number,
	luckBonus: number,
	extraRolls: number, -- lancers supplémentaires par clic
	extraGradeRerolls: number, -- relances de Grade supplémentaires par clic
	extraInstinctRerolls: number,
	chatTag: boolean,
}

type Fields = {
	luckMultiplier: number?,
	coinsMultiplier: number?,
	rollSpeedMultiplier: number?,
	luckBonus: number?,
	extraRolls: number?,
	extraGradeRerolls: number?,
	extraInstinctRerolls: number?,
	chatTag: boolean?,
}

local function pass(id: string, displayName: string, fields: Fields): Gamepass
	return table.freeze({
		id = id,
		displayName = displayName,
		gamePassId = 0,
		luckMultiplier = fields.luckMultiplier or 1,
		coinsMultiplier = fields.coinsMultiplier or 1,
		rollSpeedMultiplier = fields.rollSpeedMultiplier or 1,
		luckBonus = fields.luckBonus or 0,
		extraRolls = fields.extraRolls or 0,
		extraGradeRerolls = fields.extraGradeRerolls or 0,
		extraInstinctRerolls = fields.extraInstinctRerolls or 0,
		chatTag = fields.chatTag or false,
	})
end

local Gamepasses: { Gamepass } = {
	pass("luck", "Chance", { luckMultiplier = 2 }),
	pass("ultra_luck", "Ultra Chance", { luckMultiplier = 3 }),
	pass("more_coins", "Plus de Pièces", { coinsMultiplier = 2 }),
	pass("vip", "VIP", { coinsMultiplier = 1.5, luckBonus = 0.10, chatTag = true }),
	pass("roll_speed", "Vitesse de lancer", { rollSpeedMultiplier = 2 }),
	pass("double_roll", "Double Lancer", { extraRolls = 1 }),
	pass("more_grades", "Plus de Grades", { extraGradeRerolls = 5 }),
	pass("more_instincts", "Plus d'Instincts", { extraInstinctRerolls = 5 }),
}

return table.freeze(Gamepasses)
