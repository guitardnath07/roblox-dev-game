--!strict
-- Calculs de chances purs (aucun effet de bord), partagés serveur/client.
-- Le serveur s'en sert pour tirer, le client pour afficher l'écran des chances.

local Dinos = require(script.Parent.Config.Dinos)
local Helpers = require(script.Parent.Config.Helpers)

local Odds = {}

-- Chance qu'un test réussisse pour un dino « 1 sur oneIn » avec la chance totale `luck`.
function Odds.effectiveChance(oneIn: number, luck: number): number
	return math.min(1, luck / oneIn)
end

-- « 1 sur X » affiché après un tirage.
function Odds.displayOneIn(oneIn: number, luck: number): number
	return math.max(1, math.floor(oneIn / luck + 0.5))
end

-- Probabilité exacte de chaque dino, par id (somme = 1) : P_i = p_i x Π(1 - p_j) sur les dinos plus rares.
-- On teste du plus rare au plus commun ; le plus commun reçoit tout le reste puisqu'il est le repli.
function Odds.exactDistribution(luck: number): { [string]: number }
	local result: { [string]: number } = {}
	local noneYet = 1 -- probabilité qu'aucun dino plus rare ne soit sorti
	for i = #Dinos, 2, -1 do
		local dino = Dinos[i]
		local p = Odds.effectiveChance(dino.oneIn, luck)
		result[dino.id] = p * noneYet
		noneYet *= 1 - p
	end
	result[Dinos[1].id] = noneYet
	return result
end

-- Tire un dino. `rng` = le Random serveur.
function Odds.rollDino(luck: number, rng: Random): Dinos.Dino
	for i = #Dinos, 2, -1 do
		local dino = Dinos[i]
		if rng:NextNumber() < Odds.effectiveChance(dino.oneIn, luck) then
			return dino
		end
	end
	return Dinos[1]
end

-- Tirage pondéré dans une table dont chaque ligne a `perMillion` (entier), total exact 1 000 000
-- (garanti par Helpers.withRemainder). Ne renvoie jamais nil.
-- Luau ne sait pas exprimer la contrainte « T a un champ perMillion », d'où le cast.
function Odds.pickPerMillion<T>(list: { T }, rng: Random): T
	local roll = rng:NextInteger(1, Helpers.PER_MILLION)
	local cumulative = 0
	for _, entry in list do
		cumulative += (entry :: any).perMillion
		if roll <= cumulative then
			return entry
		end
	end
	error(`table de chances incomplète : {cumulative} / {Helpers.PER_MILLION}`)
end

-- Pourcentage avec au moins 4 chiffres après le premier chiffre non nul (règle Roblox), virgule décimale.
-- Ex. 0.5 -> « 50 % », 0.000123456 -> « 0,012346 % ».
function Odds.formatPercent(p: number): string
	local percent = p * 100
	if percent <= 0 then
		return "0 %"
	end
	local firstDigit = math.floor(math.log10(percent))
	local decimals = math.max(0, 4 - firstDigit)
	local text = string.format("%." .. decimals .. "f", percent)
	if decimals > 0 then
		text = text:gsub("0+$", ""):gsub("%.$", "")
	end
	return (text:gsub("%.", ",")) .. " %"
end

-- K mille, M million, Md milliard, T billion (1e12), Qa 1e15, Qi 1e18, Sx 1e21, Sp 1e24, Oc 1e27, No 1e30, Dc 1e33.
local SUFFIXES = { "K", "M", "Md", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }

-- Grand nombre lisible : 1 234 -> « 1,2 K », 3,4e6 -> « 3,4 M » … jusqu'à 1e33 (Dc), tronqué à 1 décimale.
function Odds.formatBig(n: number): string
	if n < 1000 then
		return tostring(math.floor(n))
	end
	local tier = math.min(#SUFFIXES, math.floor(math.log10(n) / 3))
	local scaled = math.floor(n / 10 ^ (tier * 3) * 10) / 10
	local text = string.format("%.1f", scaled):gsub("%.0$", ""):gsub("%.", ",")
	return text .. " " .. SUFFIXES[tier]
end

return Odds
