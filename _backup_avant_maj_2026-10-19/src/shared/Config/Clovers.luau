--!strict
-- Trèfles : bonus de chance sur UN lancer, tiré indépendamment du dino.
-- `perMillion` = chance sur 1 000 000 ; « none » (x1) reçoit le reste (937 520), total exact 1 000 000.

local Helpers = require(script.Parent.Helpers)

export type Clover = {
	id: string,
	multiplier: number,
	perMillion: number,
}

-- stylua: ignore
local Clovers: { Clover } = {
	{ id = "none", multiplier = 1, perMillion = 0 }, -- reste
	{ id = "x2", multiplier = 2, perMillion = 50_000 }, -- 5 %
	{ id = "x4", multiplier = 4, perMillion = 10_000 }, -- 1 %
	{ id = "x8", multiplier = 8, perMillion = 2_000 }, -- 0,2 %
	{ id = "x16", multiplier = 16, perMillion = 400 }, -- 0,04 %
	{ id = "x32", multiplier = 32, perMillion = 80 }, -- 0,008 %
}

return Helpers.withRemainder(Clovers, "none")
