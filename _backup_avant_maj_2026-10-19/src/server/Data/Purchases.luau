--!strict
-- Logique pure des reçus d'achat : mémoire des PurchaseId traités (idempotence) et contenu d'un produit.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Products = require(ReplicatedStorage.Shared.Config.Products)

local KEEP_LAST = 100

local Purchases = {}

function Purchases.isProcessed(processed: { string }, purchaseId: string): boolean
	return table.find(processed, purchaseId) ~= nil
end

-- Nouvelle liste avec `purchaseId` ajouté, en ne gardant que les KEEP_LAST derniers.
function Purchases.remember(processed: { string }, purchaseId: string): { string }
	local list = table.clone(processed)
	table.insert(list, purchaseId)
	while #list > KEEP_LAST do
		table.remove(list, 1)
	end
	return list
end

-- Produit développeur correspondant à un ProductId Roblox (jamais un id 0 non configuré).
function Purchases.productFor(productId: number): Products.Product?
	if productId == 0 then
		return nil
	end
	for _, product in Products.products do
		if product.productId == productId then
			return product
		end
	end
	return nil
end

-- Vrai si ce produit est un objet aléatoire payant au sens Roblox (interdit aux joueurs restreints) :
-- Ambre et Fossiles servent aux relances aléatoires ; les potions de chance modifient les probabilités.
function Purchases.isPaidRandom(product: Products.Product): boolean
	if product.kind == "amber" or product.kind == "fossils" then
		return true
	end
	for _, potion in Products.potions do
		if potion.id == product.potionId then
			return potion.stat == "luck"
		end
	end
	return false
end

Purchases.KEEP_LAST = KEEP_LAST

return Purchases
