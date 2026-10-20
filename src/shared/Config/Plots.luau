--!strict
-- Parcelle : socles où l'on pose les dinos. 6 au départ, +2 par rebirth, 30 max.
-- Niveaux de socle : coût Lvl N -> N+1 = baseLevelCost x 1,6^(N-1) ; +10 % de revenu par niveau au-dessus de 1.

local Plots = {
	plotsPerServer = 9,
	startingPedestals = 6,
	pedestalsPerRebirth = 2,
	maxPedestals = 30,

	-- shortcut: baseLevelCost et maxLevel proposés (CLAUDE.md ne donne que x1,6 et +10 %).
	baseLevelCost = 250, -- coût Lvl 1 -> 2
	levelCostMultiplier = 1.6,
	coinsBonusPerLevel = 0.10,
	maxLevel = 50,
	buyAmounts = table.freeze({ 1, 5 }), -- boutons x1 / x5
}

-- Nombre de socles après `rebirths` rebirths.
function Plots.pedestalCount(rebirths: number): number
	return math.min(Plots.maxPedestals, Plots.startingPedestals + Plots.pedestalsPerRebirth * rebirths)
end

-- Coût pour passer du niveau `level` au niveau `level + 1`.
function Plots.levelCost(level: number): number
	return math.floor(Plots.baseLevelCost * Plots.levelCostMultiplier ^ (level - 1))
end

-- Multiplicateur de revenu d'un socle au niveau `level` (Lvl 1 = x1).
function Plots.levelMultiplier(level: number): number
	return 1 + Plots.coinsBonusPerLevel * (level - 1)
end

return table.freeze(Plots)
