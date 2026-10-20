--!strict
-- Événements serveur : un toutes les 30 min, dure 5 min. Multiplicateurs : 1 = aucun effet.

export type ServerEvent = {
	id: string,
	displayName: string,
	luckMultiplier: number,
	skinMutationMultiplier: number, -- multiplie les chances des peaux non normales
	coinsMultiplier: number,
}

-- stylua: ignore
local List: { ServerEvent } = {
	{ id = "meteor_shower", displayName = "Pluie de Météores", luckMultiplier = 2, skinMutationMultiplier = 1, coinsMultiplier = 1 },
	{ id = "eclipse", displayName = "Éclipse", luckMultiplier = 1, skinMutationMultiplier = 3, coinsMultiplier = 1 },
	{ id = "eruption", displayName = "Éruption", luckMultiplier = 1, skinMutationMultiplier = 1, coinsMultiplier = 2 },
}

for _, event in List do
	table.freeze(event)
end

return table.freeze({
	intervalSeconds = 30 * 60,
	durationSeconds = 5 * 60,
	list = table.freeze(List),
})
