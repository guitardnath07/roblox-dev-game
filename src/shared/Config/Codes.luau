--!strict
-- Codes promo (un par mise à jour + paliers de likes / joueurs simultanés). Saisie insensible à la casse.
-- `active = false` : code prévu mais pas encore ouvert. shortcut: récompenses proposées.

export type Rewards = {
	amber: number,
	bones: number,
	goldenRolls: number,
	potions: { [string]: number }, -- id de potion (Products.potions) -> quantité
}

export type Code = {
	code: string,
	active: boolean,
	rewards: Rewards,
}

local Codes: { Code } = {
	{
		code = "LANCEMENT",
		active = true,
		rewards = { amber = 50, bones = 20, goldenRolls = 5, potions = { luck_potion = 1 } },
	},
	{
		code = "DINO1K", -- palier 1 000 likes
		active = false,
		rewards = { amber = 100, bones = 50, goldenRolls = 10, potions = { luck_potion = 2 } },
	},
}

for _, entry in Codes do
	table.freeze(entry.rewards.potions)
	table.freeze(entry.rewards)
	table.freeze(entry)
end

return table.freeze(Codes)
