--!strict
-- Classements : meilleur tirage (oneIn), total de lancers, rebirths (OrderedDataStore, tous serveurs),
-- et total de lancers de la semaine (MemoryStore SortedMap, expire après 8 jours).
-- Écriture toutes les 5 min et au départ ; lecture du top 50 toutes les 60 s par serveur.
-- Les tops sont publiés dans ReplicatedStorage.Leaderboards (StringValue JSON) pour les panneaux et l'UI.
-- Tout appel réseau est dans un pcall : un échec ne fait que retarder la mise à jour.

local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Shared.Types)

local DataService = require(script.Parent.DataService)

local WRITE_INTERVAL = 5 * 60
local READ_INTERVAL = 60
local TOP = 50
local WEEK_SECONDS = 7 * 24 * 3600
local WEEK_OFFSET = 3 * 24 * 3600 -- semaines coupées le lundi (le 1/1/1970 était un jeudi)
local WEEKLY_EXPIRY = 8 * 24 * 3600

type Board = { id: string, store: string, value: (data: Types.ProfileData) -> number }

local BOARDS: { Board } = {
	{
		id = "BestPull",
		store = "LB_BestPull_v1",
		value = function(data)
			return data.BestPull.OneIn
		end,
	},
	{
		id = "TotalRolls",
		store = "LB_TotalRolls_v1",
		value = function(data)
			return data.TotalRolls
		end,
	},
	{
		id = "Rebirths",
		store = "LB_Rebirths_v1",
		value = function(data)
			return data.Rebirths
		end,
	},
}

local rollsAtJoin: { [Player]: number } = {} -- pour le compteur hebdo : lancers faits depuis le join
local folder: Folder

local LeaderboardService = {}

local function weekKey(): string
	return `Weekly_Rolls_{math.floor((os.time() + WEEK_OFFSET) / WEEK_SECONDS)}`
end

local function write(player: Player)
	local data = DataService:GetLoaded(player)
	if not data then
		return
	end
	for _, board in BOARDS do
		local value = math.floor(board.value(data))
		if value > 0 then
			pcall(function()
				DataStoreService:GetOrderedDataStore(board.store):SetAsync(tostring(player.UserId), value)
			end)
		end
	end
	-- Hebdo : on ajoute les lancers faits depuis la dernière écriture.
	local delta = data.TotalRolls - (rollsAtJoin[player] or data.TotalRolls)
	if delta > 0 then
		local ok = pcall(function()
			MemoryStoreService:GetSortedMap(weekKey()):UpdateAsync(tostring(player.UserId), function(old)
				return (old or 0) + delta
			end, WEEKLY_EXPIRY)
		end)
		if ok then
			rollsAtJoin[player] = data.TotalRolls
		end
	end
end

local function publish(id: string, entries: { { userId: number, value: number } })
	local value = folder:FindFirstChild(id) :: StringValue?
	if not value then
		local created = Instance.new("StringValue")
		created.Name = id
		created.Parent = folder
		value = created
	end
	(value :: StringValue).Value = HttpService:JSONEncode(entries)
end

local function read()
	for _, board in BOARDS do
		local ok, pages = pcall(function()
			return DataStoreService:GetOrderedDataStore(board.store):GetSortedAsync(false, TOP)
		end)
		if ok and pages then
			local entries = {}
			for _, item in pages:GetCurrentPage() do
				table.insert(entries, { userId = tonumber(item.key) or 0, value = item.value })
			end
			publish(board.id, entries)
		end
	end
	local ok, items = pcall(function()
		return MemoryStoreService:GetSortedMap(weekKey()):GetRangeAsync(Enum.SortDirection.Descending, TOP)
	end)
	if ok and items then
		local entries = {}
		for _, item in items do
			table.insert(entries, { userId = tonumber(item.key) or 0, value = item.value })
		end
		publish("WeeklyRolls", entries)
	end
end

function LeaderboardService:Init()
	folder = Instance.new("Folder")
	folder.Name = "Leaderboards"
	folder.Parent = ReplicatedStorage

	Players.PlayerRemoving:Connect(function(player)
		write(player)
		rollsAtJoin[player] = nil
	end)
end

function LeaderboardService:Start()
	DataService:OnLoaded(function(player, data)
		rollsAtJoin[player] = data.TotalRolls
	end)
	task.spawn(function()
		while true do
			task.wait(WRITE_INTERVAL)
			for _, player in Players:GetPlayers() do
				task.spawn(write, player)
			end
		end
	end)
	-- shortcut: la récompense cosmétique hebdo (hoverboard) n'est pas encore distribuée ; il faudra un job
	-- qui lit le top de la semaine passée et l'enregistre dans les profils des gagnants.
	while true do
		read()
		task.wait(READ_INTERVAL)
	end
end

return LeaderboardService
