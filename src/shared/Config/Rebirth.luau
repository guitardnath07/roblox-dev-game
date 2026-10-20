--!strict
-- Rebirth : remet les Fossiles à 0, garde dinos / dés / améliorations / niveaux de socles,
-- donne +0,5 au multiplicateur Fossiles ET chance, et +2 socles (voir Plots).
-- Coûts : 500 K, 5 M, 500 M, puis x10 à chaque rebirth (5 Md, 50 Md, …).

local firstCosts = table.freeze({ 500_000, 5e6, 500e6 })
local COST_MULTIPLIER_AFTER = 10

local Rebirth = {
	firstCosts = firstCosts,
	costMultiplierAfter = COST_MULTIPLIER_AFTER,
	coinsMultiplierPerRebirth = 0.5, -- multiplicateur = 1 + 0,5 x rebirths
	luckMultiplierPerRebirth = 0.5,
	-- Interprétation de CLAUDE.md (« garde dinos/dés/améliorations ») : les niveaux de socles sont gardés aussi.
	keepsPedestalLevels = true,
}

-- Coût du rebirth numéro `index` (1 = premier rebirth).
function Rebirth.cost(index: number): number
	if index <= #firstCosts then
		return firstCosts[index]
	end
	return firstCosts[#firstCosts] * COST_MULTIPLIER_AFTER ^ (index - #firstCosts)
end

-- Multiplicateurs Fossiles et chance après `rebirths` rebirths.
function Rebirth.coinsMultiplier(rebirths: number): number
	return 1 + Rebirth.coinsMultiplierPerRebirth * rebirths
end

function Rebirth.luckMultiplier(rebirths: number): number
	return 1 + Rebirth.luckMultiplierPerRebirth * rebirths
end

return table.freeze(Rebirth)
