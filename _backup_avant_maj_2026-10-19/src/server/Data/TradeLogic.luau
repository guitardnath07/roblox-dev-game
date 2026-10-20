--!strict
-- Logique pure des échanges : validation d'une offre et plan de transfert.
-- Aucun objet n'est jamais créé : les uuid passent d'un profil à l'autre, les monnaies aussi.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Shared.Types)

local MAX_DINOS = 8
local MAX_CURRENCY = 1e12
local LOG_KEEP = 20

export type Offer = { uuids: { string }, amber: number, fossils: number }

-- Une écriture à faire dans le profil de `side` ("a" ou "b").
export type Write = { side: "a" | "b", path: { string }, value: any }

local TradeLogic = {}

TradeLogic.MAX_DINOS = MAX_DINOS

function TradeLogic.emptyOffer(): Offer
	return { uuids = {}, amber = 0, fossils = 0 }
end

local function isPlaced(data: Types.ProfileData, uuid: string): boolean
	for _, placed in data.PlotSlots do
		if placed == uuid then
			return true
		end
	end
	return false
end

local function validAmount(value: any): boolean
	return type(value) == "number" and value == value and value >= 0 and value <= MAX_CURRENCY and value % 1 == 0
end

-- Nettoie une offre venue du client. Renvoie (offre, nil) ou (nil, raison).
-- `isFrozenElsewhere(uuid)` : vrai si le dino est gelé par un AUTRE échange.
function TradeLogic.sanitize(
	data: Types.ProfileData,
	raw: any,
	isFrozenElsewhere: (uuid: string) -> boolean
): (Offer?, string?)
	if type(raw) ~= "table" or type(raw.uuids) ~= "table" then
		return nil, "Offre invalide."
	end
	if not validAmount(raw.amber) or not validAmount(raw.fossils) then
		return nil, "Montant invalide."
	end
	if raw.amber > data.Amber or raw.fossils > data.Fossils then
		return nil, "Tu n'as pas assez de monnaie."
	end
	local uuids: { string } = {}
	local seen: { [string]: boolean } = {}
	for i = 1, #raw.uuids do
		local uuid = raw.uuids[i]
		if type(uuid) ~= "string" or #uuid > 64 or seen[uuid] then
			return nil, "Dino invalide."
		end
		seen[uuid] = true
		local dino = data.Dinos[uuid]
		if not dino or dino.locked or isPlaced(data, uuid) or isFrozenElsewhere(uuid) then
			return nil, "Ce dino ne peut pas être échangé (posé, verrouillé ou déjà proposé)."
		end
		table.insert(uuids, uuid)
	end
	if #uuids > MAX_DINOS or #raw.uuids > MAX_DINOS then
		return nil, `{MAX_DINOS} dinos au maximum.`
	end
	return { uuids = uuids, amber = raw.amber, fossils = raw.fossils }, nil
end

-- Revérifie juste avant l'exécution que chaque partie possède encore ce qu'elle offre.
function TradeLogic.stillValid(data: Types.ProfileData, offer: Offer): boolean
	if offer.amber > data.Amber or offer.fossils > data.Fossils then
		return false
	end
	for _, uuid in offer.uuids do
		local dino = data.Dinos[uuid]
		if not dino or dino.locked or isPlaced(data, uuid) then
			return false
		end
	end
	return true
end

local function summary(offer: Offer, data: Types.ProfileData): { dinos: { string }, amber: number, fossils: number }
	local dinos = {}
	for _, uuid in offer.uuids do
		table.insert(dinos, data.Dinos[uuid].dinoId)
	end
	return { dinos = dinos, amber = offer.amber, fossils = offer.fossils }
end

local function appendLog(log: { any }, entry: any): { any }
	local list = table.clone(log)
	table.insert(list, entry)
	while #list > LOG_KEEP do
		table.remove(list, 1)
	end
	return list
end

-- Plan de transfert complet. À appliquer d'un bloc, sans yield, APRÈS stillValid sur les deux offres.
function TradeLogic.plan(
	dataA: Types.ProfileData,
	dataB: Types.ProfileData,
	offerA: Offer,
	offerB: Offer,
	userIdA: number,
	userIdB: number,
	now: number
): { Write }
	local writes: { Write } = {}
	local function move(fromSide: "a" | "b", toSide: "a" | "b", from: Types.ProfileData, offer: Offer)
		for _, uuid in offer.uuids do
			table.insert(writes, { side = fromSide, path = { "Dinos", uuid }, value = nil })
			table.insert(writes, { side = toSide, path = { "Dinos", uuid }, value = table.clone(from.Dinos[uuid]) })
		end
	end
	move("a", "b", dataA, offerA)
	move("b", "a", dataB, offerB)

	table.insert(writes, { side = "a", path = { "Amber" }, value = dataA.Amber - offerA.amber + offerB.amber })
	table.insert(writes, { side = "b", path = { "Amber" }, value = dataB.Amber - offerB.amber + offerA.amber })
	table.insert(writes, { side = "a", path = { "Fossils" }, value = dataA.Fossils - offerA.fossils + offerB.fossils })
	table.insert(writes, { side = "b", path = { "Fossils" }, value = dataB.Fossils - offerB.fossils + offerA.fossils })

	local gaveA, gaveB = summary(offerA, dataA), summary(offerB, dataB)
	table.insert(writes, {
		side = "a",
		path = { "TradeLog" },
		value = appendLog(dataA.TradeLog, { with = userIdB, gave = gaveA, got = gaveB, at = now }),
	})
	table.insert(writes, {
		side = "b",
		path = { "TradeLog" },
		value = appendLog(dataB.TradeLog, { with = userIdA, gave = gaveB, got = gaveA, at = now }),
	})
	return writes
end

-- Applique un plan sur des tables brutes (tests). Le service, lui, passe par DataService:Update.
function TradeLogic.applyRaw(dataA: any, dataB: any, writes: { Write })
	for _, write in writes do
		local parent = if write.side == "a" then dataA else dataB
		for i = 1, #write.path - 1 do
			parent = parent[write.path[i]]
		end
		parent[write.path[#write.path]] = write.value
	end
end

return TradeLogic
