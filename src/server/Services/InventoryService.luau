--!strict
-- Sac à dos : ajout des dinos tirés, vente, verrouillage. Gel des dinos proposés en échange.
-- Comptoir de vente (Workspace.Hub.Stations.SellCounter) : prompt « OpensScreen = Sell » ; on y vend aussi
-- les Reliques (Fossiles) et les potions de réserve (Tickets d'Expédition).
-- Toute entrée client est validée ici (type, longueur, appartenance, état du dino).

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Dinos = require(Shared.Config.Dinos)
local Instincts = require(Shared.Config.Instincts)
local Products = require(Shared.Config.Products)
local Rarities = require(Shared.Config.Rarities)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local CurrencyService = require(script.Parent.CurrencyService)
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
		instinct = Instincts[1].id, -- « aucun » : l'Instinct se relance avec des Os
		grade = nil,
		imprint = nil,
		obtainedAt = os.time(),
		locked = false,
	}
	DataService:Update(player, { "Dinos", uuid }, function()
		return instance
	end)

	local base = dinoById[dinoId]
	local isNew = not data.Index.Found[dinoId] and not (base and base.exclusive)
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
		CurrencyService:Add(player, total, "sell")
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
		Remotes.Notify:FireClient(player, `Vendu pour {earned} Fossiles`, "info")
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
		if base and not base.exclusive and Rarities[base.rarity].order <= maxRarityOrder then -- un exclusif payé ne part jamais en lot
			table.insert(list, uuid)
		end
	end
	local earned = InventoryService:Sell(player, list)
	Remotes.Notify:FireClient(player, `Vendu pour {earned} Fossiles`, "info")
end

-- Vend les reliques valides (possédées, non équipées), ignore les autres. Renvoie le total gagné.
function InventoryService:SellRelics(player: Player, uuids: { any }): number
	local data = DataService:GetLoaded(player)
	if not data then
		return 0
	end
	local equipped: Types.Set = {}
	for _, uuid in data.EquippedRelics do
		equipped[uuid] = true
	end
	local total = 0
	for _, uuid in uuids do
		local owned = type(uuid) == "string" and not equipped[uuid] and data.Relics[uuid]
		if owned then
			total += Bonuses.relicSellPrice(owned.relicId)
			DataService:Update(player, { "Relics", uuid }, function()
				return nil
			end)
		end
	end
	if total > 0 then
		CurrencyService:Add(player, total, "sell_relic")
	end
	return total
end

-- Vend des potions de réserve ({ [potionId] = nombre }) contre des Tickets. Renvoie les Tickets gagnés.
function InventoryService:SellPotions(player: Player, counts: { [any]: any }): number
	local data = DataService:GetLoaded(player)
	if not data then
		return 0
	end
	local tickets = 0
	for _, potion in Products.potions do
		local count = counts[potion.id]
		if type(count) == "number" and count == math.floor(count) and count >= 1 then
			local sold = math.min(count, data.Potions[potion.id] or 0)
			if sold >= 1 then
				DataService:Update(player, { "Potions", potion.id }, function(old: number)
					return old - sold
				end)
				tickets += sold * potion.sellTickets
			end
		end
	end
	if tickets > 0 then
		DataService:Increment(player, "Tickets", tickets)
	end
	return tickets
end

local function onSellRelics(player: Player, uuids: any)
	if not sellLimiter:allow(player, SELL_INTERVAL) then
		return
	end
	if type(uuids) ~= "table" or #uuids == 0 or #uuids > MAX_SELL_BATCH then
		return
	end
	local list = table.move(uuids, 1, #uuids, 1, {})
	local earned = InventoryService:SellRelics(player, list)
	if earned > 0 then
		Remotes.Notify:FireClient(player, `Vendu pour {earned} Fossiles`, "info")
	end
end

local function onSellPotions(player: Player, counts: any)
	if not sellLimiter:allow(player, SELL_INTERVAL) or type(counts) ~= "table" then
		return
	end
	local tickets = InventoryService:SellPotions(player, counts)
	if tickets > 0 then
		Remotes.Notify:FireClient(player, `Vendu pour {tickets} Tickets d'Expédition`, "info")
	end
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
	Remotes.SellRelics.OnServerEvent:Connect(onSellRelics)
	Remotes.SellPotions.OnServerEvent:Connect(onSellPotions)
	Remotes.ToggleLock.OnServerEvent:Connect(onToggleLock)
	Players.PlayerRemoving:Connect(function(player)
		frozen[player] = nil
		sellLimiter:forget(player)
		lockLimiter:forget(player)
	end)
end

-- Le comptoir est un décor construit dans Studio : on lui ajoute le prompt qui ouvre l'écran de vente.
function InventoryService:Start()
	local hub = Workspace:WaitForChild("Hub", 30)
	local stations = hub and hub:WaitForChild("Stations", 10)
	local counter = stations and stations:WaitForChild("SellCounter", 10)
	local stall = counter and (counter:FindFirstChild("Stall") or counter:FindFirstChildWhichIsA("BasePart", true))
	if not stall or not stall:IsA("BasePart") then
		warn("[InventoryService] Workspace.Hub.Stations.SellCounter introuvable : pas de Comptoir de vente")
		return
	end
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Vendre"
	prompt.ObjectText = "Comptoir de vente"
	prompt.HoldDuration = 0.2
	prompt.MaxActivationDistance = 14
	prompt.RequiresLineOfSight = false
	prompt:SetAttribute("OpensScreen", "Sell")
	prompt.Parent = stall
end

return InventoryService
