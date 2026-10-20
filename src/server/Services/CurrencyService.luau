--!strict
-- Fossiles (monnaie principale) : SEUL module qui les modifie. Add / Spend / Get.
-- Tout montant négatif, NaN ou infini est refusé. Une dépense refusée prévient le client (CurrencyDenied)
-- pour l'animation du compteur. Exception : le revenu hors ligne est crédité par DataService au chargement.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local DataService = require(script.Parent.DataService)

local CurrencyService = {}

-- Montant utilisable : nombre fini et positif ou nul.
function CurrencyService.isValidAmount(amount: any): boolean
	return type(amount) == "number" and amount == amount and amount >= 0 and amount < math.huge
end

-- Solde après dépense, ou nil si le montant est invalide ou le solde insuffisant (pur, testé dans Currency.spec).
function CurrencyService.afterSpend(balance: number, amount: any): number?
	if not CurrencyService.isValidAmount(amount) or balance < amount then
		return nil
	end
	return balance - amount
end

function CurrencyService:Get(player: Player): number
	local data = DataService:GetLoaded(player)
	return if data then data.Fossils else 0
end

function CurrencyService:Add(player: Player, amount: any, reason: string): boolean
	if not CurrencyService.isValidAmount(amount) then
		warn(`[CurrencyService] Add refusé ({reason}) : {amount}`)
		return false
	end
	if amount == 0 then
		return true -- rien à répliquer
	end
	return DataService:Increment(player, "Fossils", amount)
end

-- Renvoie true si la dépense est faite. Sinon rien ne change et le client reçoit CurrencyDenied.
function CurrencyService:Spend(player: Player, amount: any, reason: string): boolean
	local data = DataService:GetLoaded(player)
	local after = if data then CurrencyService.afterSpend(data.Fossils, amount) else nil
	if after == nil then
		Remotes.CurrencyDenied:FireClient(player, reason)
		return false
	end
	return DataService:Update(player, { "Fossils" }, function()
		return after
	end)
end

return CurrencyService
