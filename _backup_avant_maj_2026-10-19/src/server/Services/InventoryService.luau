--!strict
-- Sac à dos : ajout des dinos tirés, vente, verrouillage. Gel des dinos proposés en échange.
-- Toute entrée client est validée ici (type, longueur, appartenance, état du dino).

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Dinos = require(Shared.Config.Dinos)
local Instincts = require(Shared.Config.Instincts)
local Rarities = require(Shared.Config.Rarities)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataService = require(script.Parent.DataService)
local QuestService = require(script.Parent.QuestService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local MAX_SELL_BATCH = 200 -- au-delà du plus grand sac, une liste plus longue est forcément fausse
local SELL_INTERVAL = 0.5
local LOCK_INTERVAL = 0.2

local dinoById: { [string]: Dinos.Dino } = {}
for _, dino in Dinos do
	dinoById[dino.id] = dino
end

local frozen: { [Player]: Types.Set } = {} -- uuids gelés (proposés dans un échange en cours)
local sellLimiter = RateLimit.new()
local lockLimiter = RateLimit.new()

local InventoryService = {}

function InventoryService:Count(data: Types.ProfileData): number
	local count = 0
	for _ in data.Dinos do
		count += 1
	end
	return count
end

function InventoryService:IsFull(data: Types.ProfileData): boolean
	return self:Count(data) >= Bonuses.backpackSize(data)
end

function InventoryService:IsPlaced(data: Types.ProfileData, uuid: string): boolean
	for _, placed in data.PlotSlots do
		if placed == uuid then
			return true
		end
	end
	return false
end

-- Gel pendant un échange : ni vente, ni pose, ni relance.
function InventoryService:SetFrozen(player: Player, uuid: string, isFrozen: boolean)
	local set = frozen[player] or {}
	set[uuid] = if isFrozen then true else nil
	frozen[player] = set
end

function InventoryService:IsFrozen(player: Player, uuid: string): boolean
	local set = frozen[player]
	return set ~= nil and set[uuid] == true
end

-- Ajoute un nouvel exemplaire au profil (UUID serveur) et met à jour l'Index. Renvoie (uuid, nouveau dans l'Index).
function InventoryService:AddDino(player: Player, dinoId: string, size: string, skin: string): (string?, boolean)
	local data = DataService:GetLoaded(player)
	if not data then
		return nil, false
	end
	local uuid = HttpService:GenerateGUID(false)
	local instance: Types.DinoInstance = {
		dinoId = dinoId,
		size = size,
		skin = skin,
		instinct = Instincts[1].id, -- « aucun » : l'Instinct se relance avec des Fossiles
		grade = nil,
		imprint = nil,
		obtainedAt = os.time(),
		locked = false,
	}
	DataService:Update(player, { "Dinos", uuid }, function()
		return instance
	end)

	local isNew = not data.Index.Found[dinoId]
	if isNew then
		DataService:Update(player, { "Index", "Found", dinoId }, function()
			return true
		end)
	end
	return uuid, isNew
end

-- Vérifie qu'un uuid reçu du client désigne un dino vendable de ce joueur.
local function canSell(player: Player, data: Types.ProfileData, uuid: any): boolean
	if type(uuid) ~= "string" or #uuid > 64 then
		return false
	end
	local dino = data.Dinos[uuid]
	return dino ~= nil
		and not dino.locked
		and not InventoryService:IsPlaced(data, uuid)
		and not InventoryService:IsFrozen(player, uuid)
end

-- Vend les uuids valides, ignore les autres. Renvoie le total gagné.
function InventoryService:Sell(player: Player, uuids: { string }): number
	local data = DataService:GetLoaded(player)
	if not data then
		return 0
	end
	local total = 0
	local seen: Types.Set = {}
	for _, uuid in uuids do
		if not seen[uuid] and canSell(player, data, uuid) then
			seen[uuid] = true
			total += Bonuses.sellPrice(data, data.Dinos[uuid].dinoId)
			DataService:Update(player, { "Dinos", uuid }, function()
				return nil
			end)
		end
	end
	if total > 0 then
		DataService:Increment(player, "Coins", total)
		local count = 0
		for _ in seen do
			count += 1
		end
		QuestService:Progress(player, "sell", count)
	end
	return total
end

local function onSellDinos(player: Player, uuids: any)
	if not sellLimiter:allow(player, SELL_INTERVAL) then
		return
	end
	if type(uuids) ~= "table" or #uuids == 0 or #uuids > MAX_SELL_BATCH then
		return
	end
	local list: { string } = {}
	for i = 1, #uuids do
		table.insert(list, uuids[i])
	end
	local earned = InventoryService:Sell(player, list)
	if earned > 0 then
		Remotes.Notify:FireClient(player, `Vendu pour {earned} Pièces`, "info")
	end
end

local function onSellAllUnplaced(player: Player, maxRarityOrder: any)
	if not sellLimiter:allow(player, SELL_INTERVAL) then
		return
	end
	if type(maxRarityOrder) ~= "number" or maxRarityOrder ~= maxRarityOrder then -- refuse NaN
		return
	end
	local data = DataService:GetLoaded(player)
	if not data then
		return
	end
	local list: { string } = {}
	for uuid, dino in data.Dinos do
		local base = dinoById[dino.dinoId]
		if base and Rarities[base.rarity].order <= maxRarityOrder then
			table.insert(list, uuid)
		end
	end
	local earned = InventoryService:Sell(player, list)
	Remotes.Notify:FireClient(player, `Vendu pour {earned} Pièces`, "info")
end

local function onToggleLock(player: Player, uuid: any)
	if not lockLimiter:allow(player, LOCK_INTERVAL) or type(uuid) ~= "string" or #uuid > 64 then
		return
	end
	local data = DataService:GetLoaded(player)
	if not data or not data.Dinos[uuid] then
		return
	end
	DataService:Update(player, { "Dinos", uuid, "locked" }, function(old: boolean)
		return not old
	end)
end

function InventoryService:Init()
	Remotes.SellDinos.OnServerEvent:Connect(onSellDinos)
	Remotes.SellAllUnplaced.OnServerEvent:Connect(onSellAllUnplaced)
	Remotes.ToggleLock.OnServerEvent:Connect(onToggleLock)
	Players.PlayerRemoving:Connect(function(player)
		frozen[player] = nil
		sellLimiter:forget(player)
		lockLimiter:forget(player)
	end)
end

return InventoryService
