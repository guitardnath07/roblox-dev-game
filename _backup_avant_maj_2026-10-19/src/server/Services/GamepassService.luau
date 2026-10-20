--!strict
-- Possession des Game Passes : vérifiée une fois par session (pcall, cache), puis mise à jour à l'achat.
-- Un pass dont gamePassId vaut 0 (pas encore créé sur Roblox) n'est jamais possédé.

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Gamepasses = require(ReplicatedStorage.Shared.Config.Gamepasses)
local Types = require(ReplicatedStorage.Shared.Types)

local owned: { [Player]: Types.Set } = {}
local changedCallbacks: { (player: Player) -> () } = {}

local GamepassService = {}

-- Ensemble des id de passes possédés (vide tant que la vérification n'est pas finie).
function GamepassService:GetOwned(player: Player): Types.Set
	return owned[player] or {}
end

function GamepassService:Owns(player: Player, passId: string): boolean
	return self:GetOwned(player)[passId] == true
end

-- `callback(player)` à chaque changement (chargement, achat), pour recalculer revenus et chance.
function GamepassService:OnChanged(callback: (player: Player) -> ())
	table.insert(changedCallbacks, callback)
end

local function fireChanged(player: Player)
	for _, callback in changedCallbacks do
		task.spawn(callback, player)
	end
end

local function load(player: Player)
	local set: Types.Set = {}
	for _, pass in Gamepasses do
		if pass.gamePassId ~= 0 then
			local ok, result =
				pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, pass.gamePassId)
			-- En cas d'erreur réseau, on considère le pass non possédé ; un achat le réactivera.
			if ok and result then
				set[pass.id] = true
			end
		end
	end
	if player.Parent == Players then
		owned[player] = set
		fireChanged(player)
	end
end

function GamepassService:Init()
	Players.PlayerRemoving:Connect(function(player)
		owned[player] = nil
	end)

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, purchased)
		if not purchased then
			return
		end
		for _, pass in Gamepasses do
			if pass.gamePassId == gamePassId and pass.gamePassId ~= 0 then
				local set = owned[player] or {}
				set[pass.id] = true
				owned[player] = set
				fireChanged(player)
			end
		end
	end)
end

function GamepassService:Start()
	Players.PlayerAdded:Connect(load)
	for _, player in Players:GetPlayers() do
		task.spawn(load, player)
	end
end

return GamepassService
