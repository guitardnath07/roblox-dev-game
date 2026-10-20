--!strict
-- Nombre d'amis Roblox présents dans le serveur, pour le bonus de Fossiles.
-- IsFriendsWith est appelé une fois par paire (pcall, mis en cache) quand un joueur arrive.

local Players = game:GetService("Players")

local friendsOf: { [Player]: { [Player]: boolean } } = {}

local FriendService = {}

function FriendService:Count(player: Player): number
	local count = 0
	for other in friendsOf[player] or {} do
		if other.Parent == Players then
			count += 1
		end
	end
	return count
end

local function link(a: Player, b: Player)
	local ok, isFriend = pcall(a.IsFriendsWith, a, b.UserId)
	if ok and isFriend and a.Parent == Players and b.Parent == Players then
		friendsOf[a] = friendsOf[a] or {}
		friendsOf[b] = friendsOf[b] or {}
		friendsOf[a][b] = true
		friendsOf[b][a] = true
	end
end

local function onPlayerAdded(player: Player)
	for _, other in Players:GetPlayers() do
		if other ~= player then
			task.spawn(link, player, other)
		end
	end
end

function FriendService:Init()
	Players.PlayerRemoving:Connect(function(player)
		for other in friendsOf[player] or {} do
			if friendsOf[other] then
				friendsOf[other][player] = nil
			end
		end
		friendsOf[player] = nil
	end)
end

function FriendService:Start()
	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
end

return FriendService
