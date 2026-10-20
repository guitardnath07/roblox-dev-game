--!strict
-- Achats Robux. SEUL script qui assigne MarketplaceService.ProcessReceipt (règle Roblox).
-- Reçu : joueur présent + profil chargé, sinon NotProcessedYet ; PurchaseId déjà traité -> PurchaseGranted
-- sans redonner ; sinon on accorde, on mémorise le PurchaseId, on sauvegarde, et PurchaseGranted
-- seulement si la sauvegarde est confirmée. Les joueurs restreints (PolicyService) ne peuvent pas acheter
-- d'objets aléatoires payants : le serveur refuse d'ouvrir la fenêtre d'achat.

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Gamepasses = require(Shared.Config.Gamepasses)
local Products = require(Shared.Config.Products)
local Remotes = require(Shared.Net.Remotes)

local DataService = require(script.Parent.DataService)
local PolicyService = require(script.Parent.PolicyService)
local Purchases = require(script.Parent.Parent.Data.Purchases)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local SAVE_TIMEOUT = 15
local PROMPT_INTERVAL = 1
local RESTRICTED_MESSAGE = "Cet achat n'est pas disponible dans ton pays."

local limiter = RateLimit.new()

local MonetizationService = {}

local function byId<T>(list: { T }, id: any): T?
	if type(id) ~= "string" or #id > 64 then
		return nil
	end
	for _, entry in list do
		if (entry :: any).id == id then
			return entry
		end
	end
	return nil
end

local function grant(player: Player, product: Products.Product)
	if product.kind == "amber" then
		DataService:Increment(player, "Amber", product.amount)
	elseif product.kind == "fossils" then
		DataService:Increment(player, "Fossils", product.amount)
	elseif product.kind == "potion" and product.potionId then
		DataService:Update(player, { "Potions", product.potionId }, function(old: number?)
			return (old or 0) + product.amount
		end)
	end
end

local function processReceipt(receipt): Enum.ProductPurchaseDecision
	local player = Players:GetPlayerByUserId(receipt.PlayerId)
	local data = player and DataService:GetLoaded(player)
	if not player or not data then
		return Enum.ProductPurchaseDecision.NotProcessedYet -- Roblox réessaiera au prochain join
	end
	local purchaseId = tostring(receipt.PurchaseId)
	if Purchases.isProcessed(data.ProcessedPurchases, purchaseId) then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
	local product = Purchases.productFor(receipt.ProductId)
	if not product then
		warn(`[MonetizationService] produit inconnu {receipt.ProductId}`)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local ok, err = pcall(function()
		grant(player, product)
		DataService:Update(player, { "ProcessedPurchases" }, function(old: { string })
			return Purchases.remember(old, purchaseId)
		end)
	end)
	if not ok then
		warn(`[MonetizationService] octroi impossible : {err}`)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	if not DataService:SaveAndWait(player, SAVE_TIMEOUT) then
		-- PurchaseId mémorisé dans le profil : une nouvelle tentative ne redonnera pas l'objet en double.
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	Remotes.Notify:FireClient(player, `Merci ! {product.displayName} reçu.`, "info")
	return Enum.ProductPurchaseDecision.PurchaseGranted
end

local function isLuckPass(pass: Gamepasses.Gamepass): boolean
	return pass.luckMultiplier ~= 1 or pass.luckBonus ~= 0
end

local function onPromptPurchase(player: Player, kind: any, id: any)
	if not limiter:allow(player, PROMPT_INTERVAL) then
		return
	end
	local restricted = PolicyService:IsPaidRandomRestricted(player)
	if kind == "pass" then
		local pass = byId(Gamepasses, id)
		if not pass or pass.gamePassId == 0 then
			Remotes.Notify:FireClient(player, "Ce pass n'est pas encore en vente.", "error")
		elseif restricted and isLuckPass(pass) then
			Remotes.Notify:FireClient(player, RESTRICTED_MESSAGE, "error")
		else
			MarketplaceService:PromptGamePassPurchase(player, pass.gamePassId)
		end
	elseif kind == "product" then
		local product = byId(Products.products, id)
		if not product or product.productId == 0 then
			Remotes.Notify:FireClient(player, "Ce produit n'est pas encore en vente.", "error")
		elseif restricted and Purchases.isPaidRandom(product) then
			Remotes.Notify:FireClient(player, RESTRICTED_MESSAGE, "error")
		else
			MarketplaceService:PromptProductPurchase(player, product.productId)
		end
	end
end

local function onUsePotion(player: Player, potionId: any)
	local data = DataService:GetLoaded(player)
	local potion = byId(Products.potions, potionId)
	-- Pas de blocage PolicyService ici : un joueur restreint ne peut pas ACHETER de potions,
	-- celles de sa réserve viennent donc du jeu (quêtes) et restent utilisables.
	if not data or not potion or (data.Potions[potion.id] or 0) < 1 then
		return
	end
	DataService:Update(player, { "Potions", potion.id }, function(old: number)
		return old - 1
	end)
	DataService:Update(player, { "ActivePotions", potion.id }, function(expiresAt: number?)
		return math.max(os.time(), expiresAt or 0) + potion.durationSeconds
	end)
	Remotes.Notify:FireClient(player, `{potion.displayName} activée !`, "info")
end

function MonetizationService:Init()
	MarketplaceService.ProcessReceipt = processReceipt
	Remotes.PromptPurchase.OnServerEvent:Connect(onPromptPurchase)
	Remotes.UsePotion.OnServerEvent:Connect(function(player, potionId)
		if limiter:allow(player, PROMPT_INTERVAL) then
			onUsePotion(player, potionId)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		limiter:forget(player)
	end)
end

return MonetizationService
