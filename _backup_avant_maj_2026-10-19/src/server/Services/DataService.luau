--!strict
-- Données joueur : session ProfileStore (verrou de session), migrations, réplication vers le client,
-- leaderstats et gains hors ligne. Toute écriture passe par DataService:Update pour être répliquée.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileStore = require(ServerScriptService.ServerPackages.ProfileStore)

local Shared = ReplicatedStorage.Shared
local Economy = require(Shared.Config.Economy)
local Odds = require(Shared.Odds)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local Data = script.Parent.Parent.Data
local Migrations = require(Data.Migrations)
local OfflineEarnings = require(Data.OfflineEarnings)
local Template = require(Data.Template)

local STORE_NAME = "PlayerData_v1"

local store = ProfileStore.New(STORE_NAME, Template.template)
local profiles: { [Player]: any } = {} -- Player -> Profile<ProfileData>
local loadedCallbacks: { (player: Player, data: Types.ProfileData) -> () } = {}
local updateCallbacks: { (player: Player, path: { string }) -> () } = {}

local DataService = {}

local function updateLeaderstats(player: Player, data: Types.ProfileData)
	local stats = player:FindFirstChild("leaderstats")
	if not stats then
		return
	end
	local coins = stats:FindFirstChild("Pièces") :: StringValue?
	local rebirths = stats:FindFirstChild("Rebirths") :: IntValue?
	if coins then
		coins.Value = Odds.formatBig(data.Coins)
	end
	if rebirths then
		rebirths.Value = data.Rebirths
	end
end

local function createLeaderstats(player: Player)
	local stats = Instance.new("Folder")
	stats.Name = "leaderstats"
	local coins = Instance.new("StringValue")
	coins.Name = "Pièces"
	coins.Parent = stats
	local rebirths = Instance.new("IntValue")
	rebirths.Name = "Rebirths"
	rebirths.Parent = stats
	stats.Parent = player
end

local function onPlayerAdded(player: Player)
	local profile = store:StartSessionAsync(`Player_{player.UserId}`, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile == nil then
		-- Échec DataStore ou session impossible à prendre : on ne laisse jamais jouer sans profil.
		player:Kick("Impossible de charger tes données. Reconnecte-toi dans un instant.")
		return
	end

	profile:AddUserId(player.UserId) -- RGPD
	profile:Reconcile()
	Migrations.run(profile.Data, Template.CURRENT_VERSION)

	profile.OnSessionEnd:Connect(function()
		profiles[player] = nil
		player:Kick("Ta partie a été ouverte sur un autre serveur. Reconnecte-toi.")
	end)

	if player.Parent ~= Players then
		profile:EndSession()
		return
	end

	local data = profile.Data :: Types.ProfileData

	-- Heure de départ enregistrée à chaque sauvegarde, pour les gains hors ligne.
	profile.OnSave:Connect(function()
		data.LastOnline = os.time()
	end)

	local earned, seconds =
		OfflineEarnings.compute(data.LastOnline, os.time(), data.LastIncomePerSecond, Economy.offlineCapSeconds)
	data.Coins += earned

	profiles[player] = profile
	createLeaderstats(player)
	updateLeaderstats(player, data)

	Remotes.DataSync:FireClient(player, { kind = "full", data = data } :: Types.DataSyncMessage)
	if earned > 0 then
		Remotes.OfflineEarnings:FireClient(player, earned, seconds)
	end

	for _, callback in loadedCallbacks do
		task.spawn(callback, player, data)
	end
end

-- Attend que le profil soit chargé. Renvoie nil si le joueur part avant.
-- Lecture seule par convention : toute modification passe par Update.
function DataService:Get(player: Player): Types.ProfileData?
	while player.Parent == Players and profiles[player] == nil do
		task.wait()
	end
	local profile = profiles[player]
	return if profile then profile.Data else nil
end

-- Profil déjà chargé, sans attendre (nil sinon). Pour le code qui ne doit pas yield (ticks, remotes).
function DataService:GetLoaded(player: Player): Types.ProfileData?
	local profile = profiles[player]
	return if profile then profile.Data else nil
end

-- Modifie la valeur au chemin `path` (ex. { "Coins" } ou { "Dinos", uuid }) puis réplique ce changement.
-- `fn` reçoit l'ancienne valeur et renvoie la nouvelle (nil = supprimer la clé).
-- Renvoie false si le profil n'est pas chargé (rien n'est modifié).
function DataService:Update(player: Player, path: { string }, fn: (old: any) -> any): boolean
	local profile = profiles[player]
	if not profile then
		return false
	end
	assert(#path >= 1, "chemin vide")

	local parent: any = profile.Data
	for i = 1, #path - 1 do
		parent = parent[path[i]]
		assert(type(parent) == "table", `chemin invalide : {table.concat(path, ".")}`)
	end
	local key = path[#path]
	local value = fn(parent[key])
	parent[key] = value

	Remotes.DataSync:FireClient(player, { kind = "set", path = path, value = value } :: Types.DataSyncMessage)
	if path[1] == "Coins" or path[1] == "Rebirths" then
		updateLeaderstats(player, profile.Data)
	end
	for _, callback in updateCallbacks do
		task.spawn(callback, player, path)
	end
	return true
end

-- Appelle `callback(player, path)` après chaque Update (côté serveur, ex. pour redessiner une parcelle).
function DataService:OnUpdate(callback: (player: Player, path: { string }) -> ())
	table.insert(updateCallbacks, callback)
end

-- Raccourci : ajoute `amount` à une monnaie numérique (Coins, Amber, Fossils…).
function DataService:Increment(player: Player, key: string, amount: number): boolean
	return self:Update(player, { key }, function(old: number)
		return old + amount
	end)
end

-- Sauvegarde immédiate (après un achat ou un échange). Sans effet si le profil n'est pas chargé.
function DataService:SaveNow(player: Player)
	local profile = profiles[player]
	if profile then
		profile:Save()
	end
end

-- Sauvegarde et attend la confirmation (achats Robux). Renvoie true si c'est écrit dans le DataStore,
-- ou si les DataStores sont indisponibles (Studio sans accès API : profil en mémoire, rien à attendre).
function DataService:SaveAndWait(player: Player, timeout: number): boolean
	local profile = profiles[player]
	if not profile then
		return false
	end
	if ProfileStore.DataStoreState ~= "Access" then
		return true
	end
	local saved = false
	local connection = profile.OnAfterSave:Connect(function()
		saved = true
	end)
	profile:Save()
	local deadline = os.clock() + timeout
	while not saved and os.clock() < deadline and profile:IsActive() do
		task.wait(0.1)
	end
	connection:Disconnect()
	return saved
end

-- Appelle `callback` pour chaque joueur dont le profil se charge (y compris ceux déjà chargés).
function DataService:OnLoaded(callback: (player: Player, data: Types.ProfileData) -> ())
	table.insert(loadedCallbacks, callback)
	for player, profile in profiles do
		task.spawn(callback, player, profile.Data)
	end
end

function DataService:Init()
	Players.PlayerRemoving:Connect(function(player)
		local profile = profiles[player]
		if profile then
			profile.Data.LastOnline = os.time()
			profile:EndSession()
		end
		profiles[player] = nil
	end)
end

function DataService:Start()
	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
end

return DataService
