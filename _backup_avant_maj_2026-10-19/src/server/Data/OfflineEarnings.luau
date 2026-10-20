--!strict
-- Gains pendant l'absence : temps écoulé (plafonné) × revenu par seconde au moment du départ.

-- Renvoie (pièces gagnées, secondes prises en compte). 0 si première connexion ou horloge incohérente.
local function compute(lastOnline: number, now: number, incomePerSecond: number, capSeconds: number): (number, number)
	if lastOnline <= 0 or now <= lastOnline or incomePerSecond <= 0 then
		return 0, 0
	end
	local seconds = math.min(now - lastOnline, capSeconds)
	return math.floor(seconds * incomePerSecond), seconds
end

return {
	compute = compute,
}
