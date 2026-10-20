--!strict
-- Récompenses gratuites : connexion quotidienne (série de 7 jours, UTC), temps de jeu dans la session,
-- coffre de groupe (toutes les 24 h si le joueur est dans le groupe Roblox).
-- shortcut: montants proposés (CLAUDE.md ne donne que les mécaniques), à valider avec le game-designer.

export type Reward = {
	amber: number,
	bones: number,
	goldenRolls: number,
	tickets: number,
	potions: { [string]: number }, -- Products.potions id -> quantité
}

local function reward(
	amber: number,
	bones: number,
	goldenRolls: number,
	tickets: number,
	potions: { [string]: number }?
): Reward
	return table.freeze({
		amber = amber,
		bones = bones,
		goldenRolls = goldenRolls,
		tickets = tickets,
		potions = table.freeze(potions or {}),
	})
end

return table.freeze({
	-- Jour 1 à 7 de la série ; rater un jour (UTC) remet la série au jour 1. Le jour 7 est le gros lot.
	daily = table.freeze({
		reward(10, 0, 1, 0),
		reward(0, 10, 1, 0),
		reward(20, 0, 2, 1),
		reward(0, 20, 2, 1),
		reward(30, 30, 3, 2),
		reward(40, 40, 3, 2, { luck_potion = 1 }),
		reward(100, 100, 10, 5, { super_luck_potion = 1 }),
	}),

	-- Temps de jeu dans la session (minutes) -> récompense, une fois par session.
	playtime = table.freeze({
		table.freeze({ minutes = 5, reward = reward(5, 5, 1, 0) }),
		table.freeze({ minutes = 15, reward = reward(10, 10, 1, 1) }),
		table.freeze({ minutes = 30, reward = reward(20, 20, 2, 1) }),
		table.freeze({ minutes = 60, reward = reward(40, 40, 3, 2, { luck_potion = 1 }) }),
	}),

	-- 0 = pas encore de groupe Roblox : le coffre de groupe est désactivé.
	groupId = 0,
	groupChestCooldownSeconds = 24 * 3600,
	groupChest = reward(25, 25, 2, 1),
})
