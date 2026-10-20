--!strict
-- Règles Roblox par joueur (PolicyService), vérifiées côté serveur. Voir docs/regles-roblox.md.
-- Échec de l'appel = joueur traité comme RESTREINT (aucun objet aléatoire payant, aucun échange).
-- Les attributs du joueur « PaidRandomRestricted » / « TradingAllowed » servent seulement à l'interface.

local Players = game:GetService("Players")
local RobloxPolicyService = game:GetService("PolicyService")

local ATTEMPTS = 3
local RETRY_DELAY = 2

type Policy = { paidRandomRestricted: boolean, tradingAllowed: boolean }

local RESTRICTED: Policy = { paidRandomRestricted = true, tradingAllowed = false }

local policies: { [Player]: Policy } = {}

local PolicyService = {}

-- Vrai si le joueur ne doit avoir accès à aucun objet aléatoire payant (achat de boosts de chance,
-- potions, Ambre/Os). Vrai aussi tant que la règle n'est pas connue.
function PolicyService:IsPaidRandomRestricted(player: Player): boolean
	return (policies[player] or RESTRICTED).paidRandomRestricted
end

-- Vrai seulement si le joueur peut échanger des objets payants.
function PolicyService:CanTradePaidItems(player: Player): boolean
	return (policies[player] or RESTRICTED).tradingAllowed
end

local function load(player: Player)
	local policy = RESTRICTED
	for attempt = 1, ATTEMPTS do
		local ok, info = pcall(RobloxPolicyService.GetPolicyInfoForPlayerAsync, RobloxPolicyService, player)
		if ok and type(info) == "table" then
			policy = {
				-- Champ absent = prudence : restreint / échange interdit.
				paidRandomRestricted = info.ArePaidRandomItemsRestricted ~= false,
				tradingAllowed = info.IsPaidItemTradingAllowed == true,
			}
			break
		end
		if attempt < ATTEMPTS then
			task.wait(RETRY_DELAY)
		end
	end
	if player.Parent == Players then
		policies[player] = policy
		player:SetAttribute("PaidRandomRestricted", policy.paidRandomRestricted)
		player:SetAttribute("TradingAllowed", policy.tradingAllowed)
	end
end

function PolicyService:Init()
	Players.PlayerRemoving:Connect(function(player)
		policies[player] = nil
	end)
end

function PolicyService:Start()
	Players.PlayerAdded:Connect(load)
	for _, player in Players:GetPlayers() do
		task.spawn(load, player)
	end
end

return PolicyService
