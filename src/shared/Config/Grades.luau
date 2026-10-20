--!strict
-- Grade : relancé avec de l'Ambre, agit sur le revenu uniquement.
-- `perMillion` = chance sur 1 000 000 ; « d » reçoit le reste (449 700 = 44,97 %), total exact 1 000 000.

local Helpers = require(script.Parent.Helpers)

export type Grade = {
	id: string,
	displayName: string,
	perMillion: number,
	coinsMultiplier: number,
}

-- stylua: ignore
local Grades: { Grade } = {
	{ id = "d", displayName = "D", perMillion = 0, coinsMultiplier = 1.1 }, -- reste
	{ id = "c", displayName = "C", perMillion = 280_000, coinsMultiplier = 1.2 },
	{ id = "b", displayName = "B", perMillion = 150_000, coinsMultiplier = 1.6 },
	{ id = "a", displayName = "A", perMillion = 80_000, coinsMultiplier = 3 },
	{ id = "a_plus", displayName = "A+", perMillion = 30_000, coinsMultiplier = 4.5 },
	{ id = "s", displayName = "S", perMillion = 9_000, coinsMultiplier = 7 },
	{ id = "s_plus", displayName = "S+", perMillion = 1_000, coinsMultiplier = 10 },
	{ id = "z", displayName = "Z", perMillion = 230, coinsMultiplier = 15 },
	{ id = "z_plus", displayName = "Z+", perMillion = 70, coinsMultiplier = 25 },
}

return Helpers.withRemainder(Grades, "d")
