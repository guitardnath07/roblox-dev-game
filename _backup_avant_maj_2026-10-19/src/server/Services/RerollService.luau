--!strict
-- Relances : Instinct (Fossiles), Grade (Ambre), Empreinte (Pièces, dès le rebirth 5).
-- Le nouveau résultat remplace l'ancien. Les mutations (taille, peau) ne se relancent jamais.
-- Auto-relance : le client donne un seuil ; le SERVEUR boucle jusqu'au seuil, à court de monnaie,
-- ou après Economy.maxAutoRerolls relances.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Economy = require(Shared.Config.Economy)
local Gamepasses = require(Shared.Config.Gamepasses)
local Grades = require(Shared.Config.Grades)
local Imprints = require(Shared.Config.Imprints)
local Instincts = require(Shared.Config.Instincts)
local Odds = require(Shared.Odds)
local Rebirth = require(Shared.Config.Rebirth)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataService = require(script.Parent.DataService)
local GamepassService = require(script.Parent.GamepassService)
local InventoryService = require(script.Parent.InventoryService)
local QuestService = require(script.Parent.QuestService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local ACTION_INTERVAL = 0.3

local rng = Random.new()
local limiter = RateLimit.new()

local RerollService = {}

type Kind = {
	list: { any }, -- table de chances (perMillion)
	field: "instinct" | "grade",
	currency: "Fossils" | "Amber",
	cost: number,
	passField: "extraInstinctRerolls" | "extraGradeRerolls",
	currencyName: string,
}

local INSTINCT: Kind = {
	list = Instincts,
	field = "instinct",
	currency = "Fossils",
	cost = Economy.instinctRerollCostFossils,
	passField = "extraInstinctRerolls",
	currencyName = "Fossiles",
}

local GRADE: Kind = {
	list = Grades,
	field = "grade",
	currency = "Amber",
	cost = Economy.gradeRerollCostAmber,
	passField = "extraGradeRerolls",
	currencyName = "Ambre",
}

-- « Force » d'un résultat pour comparer au seuil d'auto-relance.
-- Grade : son multiplicateur de Pièces. Instinct : son plus grand multiplicateur (Pièces, PV ou Dégâts).
local function power(kind: Kind, id: string?): number
	for _, entry in kind.list do
		if entry.id == id then
			if kind.field == "grade" then
				return entry.coinsMultiplier
			end
			return math.max(entry.coinsMultiplier, entry.healthMultiplier, entry.damageMultiplier)
		end
	end
	return 0
end

-- Relances par clic : 1, ou le nombre donné par le pass (« Plus de Grades / d'Instincts »).
local function perClick(player: Player, kind: Kind): number
	local best = 1
	for _, pass in Gamepasses do
		if GamepassService:Owns(player, pass.id) then
			best = math.max(best, pass[kind.passField])
		end
	end
	return best
end

local function validDino(player: Player, data: Types.ProfileData, uuid: any): boolean
	return type(uuid) == "string"
		and #uuid <= 64
		and data.Dinos[uuid] ~= nil
		and not InventoryService:IsFrozen(player, uuid)
end

-- count = nombre de relances de ce clic ; stopAtId = seuil d'auto-relance (nil = pas d'auto).
local function reroll(player: Player, kind: Kind, uuid: any, count: any, stopAtId: any): Types.RerollResponse
	local data = DataService:GetLoaded(player)
	if not data or not validDino(player, data, uuid) then
		return { ok = false, reason = "Dino introuvable." }
	end

	local isAuto = type(stopAtId) == "string" and power(kind, stopAtId) > 0
	local maxCount = if isAuto
		then Economy.maxAutoRerolls
		elseif type(count) == "number" and count == count then math.clamp(
			math.floor(count),
			1,
			perClick(player, kind)
		)
		else 1
	local target = if isAuto then power(kind, stopAtId) else math.huge

	local results: { string } = {}
	local balance = data[kind.currency]
	while #results < maxCount and balance >= kind.cost do
		balance -= kind.cost
		local id = Odds.pickPerMillion(kind.list, rng).id
		table.insert(results, id)
		if power(kind, id) >= target then
			break
		end
	end

	if #results == 0 then
		return { ok = false, reason = `Pas assez de {kind.currencyName}.` }
	end
	DataService:Increment(player, kind.currency, -kind.cost * #results)
	DataService:Update(player, { "Dinos", uuid, kind.field }, function()
		return results[#results]
	end)
	QuestService:Progress(player, if kind.field == "grade" then "reroll_grade" else "reroll_instinct", #results)
	return { ok = true, results = results }
end

local function rerollImprint(player: Player, uuid: any): Types.RerollResponse
	local data = DataService:GetLoaded(player)
	if not data or not validDino(player, data, uuid) then
		return { ok = false, reason = "Dino introuvable." }
	end
	if data.Rebirths < Imprints.unlockRebirth then
		return { ok = false, reason = `Les Empreintes se débloquent au rebirth {Imprints.unlockRebirth}.` }
	end
	local cost = math.floor(Rebirth.cost(data.Rebirths + 1) * Economy.imprintRerollCostRatio)
	if data.Coins < cost then
		return { ok = false, reason = `Il te faut {Odds.formatBig(cost)} Pièces.` }
	end
	DataService:Increment(player, "Coins", -cost)
	local id = Odds.pickPerMillion(Imprints.list, rng).id
	DataService:Update(player, { "Dinos", uuid, "imprint" }, function()
		return id
	end)
	return { ok = true, results = { id } }
end

local function guarded(handler: (Player, ...any) -> Types.RerollResponse)
	return function(player: Player, ...): Types.RerollResponse
		if not limiter:allow(player, ACTION_INTERVAL) then
			return { ok = false, reason = "Doucement !" }
		end
		return handler(player, ...)
	end
end

function RerollService:Init()
	Remotes.RerollInstinct.OnServerInvoke = guarded(function(player, uuid, count, stopAtId)
		return reroll(player, INSTINCT, uuid, count, stopAtId)
	end)
	Remotes.RerollGrade.OnServerInvoke = guarded(function(player, uuid, count, stopAtId)
		return reroll(player, GRADE, uuid, count, stopAtId)
	end)
	Remotes.RerollImprint.OnServerInvoke = guarded(function(player, uuid)
		return rerollImprint(player, uuid)
	end)
	Players.PlayerRemoving:Connect(function(player)
		limiter:forget(player)
	end)
end

return RerollService
