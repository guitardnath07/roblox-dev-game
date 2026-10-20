--!strict
-- Calcul pur des bonus d'un joueur (aucun effet de bord), à partir de son profil et d'un contexte serveur.
-- Le serveur s'en sert pour décider ; le client pour afficher le détail (écran des chances, boutique).

local Shared = script.Parent
local Dice = require(Shared.Config.Dice)
local Dinos = require(Shared.Config.Dinos)
local Economy = require(Shared.Config.Economy)
local Events = require(Shared.Config.Events)
local Gamepasses = require(Shared.Config.Gamepasses)
local Grades = require(Shared.Config.Grades)
local Imprints = require(Shared.Config.Imprints)
local Instincts = require(Shared.Config.Instincts)
local Mutations = require(Shared.Config.Mutations)
local Plots = require(Shared.Config.Plots)
local Products = require(Shared.Config.Products)
local Rebirth = require(Shared.Config.Rebirth)
local Relics = require(Shared.Config.Relics)
local Upgrades = require(Shared.Config.Upgrades)
local Types = require(Shared.Types)

-- Ce que le profil ne contient pas : décidé par le serveur à l'instant du calcul.
export type Context = {
	ownedPasses: Types.Set, -- id de Gamepasses possédés
	eventId: string?, -- événement serveur en cours (Events.list[].id)
	now: number, -- os.time(), pour l'expiration des potions
	friendCount: number?, -- amis présents dans le serveur (bonus de Pièces)
}

-- Une ligne du détail affiché au joueur : « Dé Ambre x8 », « Rebirth x1,5 »…
export type Factor = { label: string, multiplier: number }

local MIN_ROLL_COOLDOWN = 0.25

local Bonuses = {}

local function byId<T>(list: { T }, id: string?): T?
	if id == nil then
		return nil
	end
	for _, entry in list do
		if (entry :: any).id == id then
			return entry
		end
	end
	return nil
end

-- Valeur totale d'une stat de l'arbre : celle du nœud le plus fort acheté dans la branche, sinon la base.
function Bonuses.upgradeStat(owned: Types.Set, stat: Upgrades.Stat): number
	local value = Upgrades.baseValues[stat]
	for _, node in Upgrades.list do
		if node.stat == stat and owned[node.id] then
			value = math.max(value, node.value)
		end
	end
	return value
end

-- Somme des bonus additifs des Empreintes des dinos POSÉS et des Reliques équipées pour une stat.
local function additiveBonus(
	data: Types.ProfileData,
	imprintField: "luckBonus" | "coinsBonus" | "rollSpeedBonus",
	relicStat: Relics.RelicStat
): number
	local total = 0
	for _, uuid in data.PlotSlots do
		local dino = data.Dinos[uuid]
		local imprint = dino and byId(Imprints.list, dino.imprint)
		if imprint then
			total += (imprint :: any)[imprintField]
		end
	end
	for _, uuid in data.EquippedRelics do
		local owned = data.Relics[uuid]
		local relic = owned and byId(Relics.list, owned.relicId)
		if relic and relic.stat == relicStat then
			total += relic.value
		end
	end
	return total
end

local function passProduct(ctx: Context, field: "luckMultiplier" | "coinsMultiplier" | "rollSpeedMultiplier"): number
	local total = 1
	for _, pass in Gamepasses do
		if ctx.ownedPasses[pass.id] then
			total *= pass[field]
		end
	end
	return total
end

local function passBonus(ctx: Context): number
	local total = 0
	for _, pass in Gamepasses do
		if ctx.ownedPasses[pass.id] then
			total += pass.luckBonus
		end
	end
	return total
end

-- Produit des potions actives (non expirées) pour une stat.
function Bonuses.potionMultiplier(data: Types.ProfileData, ctx: Context, stat: Products.PotionStat): number
	local total = 1
	for potionId, expiresAt in data.ActivePotions do
		local potion = byId(Products.potions, potionId)
		if potion and potion.stat == stat and expiresAt > ctx.now then
			total *= potion.multiplier
		end
	end
	return total
end

function Bonuses.event(ctx: Context): Events.ServerEvent?
	return byId(Events.list, ctx.eventId)
end

-- Chance totale (sans trèfle, tiré à chaque lancer) et son détail ligne par ligne.
-- Chance = dé × arbre × rebirth × passes × (1 + bonus additifs) × potions × événement.
-- Le bonus amis de CLAUDE.md §9 porte sur les Pièces uniquement (voir IncomeService).
function Bonuses.luck(data: Types.ProfileData, ctx: Context): (number, { Factor })
	local die = byId(Dice, data.EquippedDice) or Dice[1]
	local event = Bonuses.event(ctx)
	local factors: { Factor } = {
		{ label = die.displayName, multiplier = die.luck },
		{ label = "Arbre (Chance)", multiplier = Bonuses.upgradeStat(data.Upgrades, "luckMultiplier") },
		{ label = "Rebirth", multiplier = Rebirth.luckMultiplier(data.Rebirths) },
		{ label = "Passes", multiplier = passProduct(ctx, "luckMultiplier") },
		{
			label = "VIP, Empreintes et Reliques",
			multiplier = 1 + passBonus(ctx) + additiveBonus(data, "luckBonus", "luckBonus"),
		},
		{ label = "Potions", multiplier = Bonuses.potionMultiplier(data, ctx, "luck") },
		{
			label = if event then event.displayName else "Événement",
			multiplier = if event then event.luckMultiplier else 1,
		},
	}
	local total = 1
	for _, factor in factors do
		total *= factor.multiplier
	end
	return total, factors
end

-- Délai minimal entre deux lancers, en secondes (jamais moins de 0,25 s).
function Bonuses.rollCooldown(data: Types.ProfileData, ctx: Context): number
	local speed = Bonuses.upgradeStat(data.Upgrades, "rollSpeedMultiplier")
		* passProduct(ctx, "rollSpeedMultiplier")
		* Bonuses.potionMultiplier(data, ctx, "rollSpeed")
		* (1 + additiveBonus(data, "rollSpeedBonus", "rollSpeedBonus"))
	return math.max(MIN_ROLL_COOLDOWN, Economy.rollCooldownSeconds / speed)
end

-- Nombre de lancers par clic (Double Lancer).
function Bonuses.rollsPerClick(ctx: Context): number
	local total = 1
	for _, pass in Gamepasses do
		if ctx.ownedPasses[pass.id] then
			total += pass.extraRolls
		end
	end
	return total
end

function Bonuses.backpackSize(data: Types.ProfileData): number
	return Bonuses.upgradeStat(data.Upgrades, "backpackSize")
end

-- Prix de vente d'un exemplaire : revenu de base × Economy.sellValueSeconds × arbre (Vente).
function Bonuses.sellPrice(data: Types.ProfileData, dinoId: string): number
	local dino = byId(Dinos, dinoId)
	if not dino then
		return 0
	end
	return math.floor(dino.baseIncome * Economy.sellValueSeconds * Bonuses.upgradeStat(data.Upgrades, "sellMultiplier"))
end

-- Multiplicateur de Pièces commun à tous les dinos posés d'un joueur :
-- arbre × rebirth × passes × (1 + Empreintes/Reliques) × potions × événement × amis.
function Bonuses.globalCoinsMultiplier(data: Types.ProfileData, ctx: Context): number
	local event = Bonuses.event(ctx)
	local friends =
		math.min(Economy.Social.friendCoinsBonusMax, Economy.Social.friendCoinsBonus * (ctx.friendCount or 0))
	return Bonuses.upgradeStat(data.Upgrades, "coinsMultiplier")
		* Rebirth.coinsMultiplier(data.Rebirths)
		* passProduct(ctx, "coinsMultiplier")
		* (1 + additiveBonus(data, "coinsBonus", "coinsBonus"))
		* Bonuses.potionMultiplier(data, ctx, "coins")
		* (if event then event.coinsMultiplier else 1)
		* (1 + friends)
end

-- Revenu propre d'un exemplaire (sans socle ni bonus globaux) : base × taille × peau × instinct × grade.
function Bonuses.instanceIncome(instance: Types.DinoInstance): number
	local dino = byId(Dinos, instance.dinoId)
	if not dino then
		return 0
	end
	local size = byId(Mutations.Sizes, instance.size)
	local skin = byId(Mutations.Skins, instance.skin)
	local instinct = byId(Instincts, instance.instinct)
	local grade = byId(Grades, instance.grade)
	return dino.baseIncome
		* (if size then size.coinsMultiplier else 1)
		* (if skin then skin.coinsMultiplier else 1)
		* (if instinct then instinct.coinsMultiplier else 1)
		* (if grade then grade.coinsMultiplier else 1)
end

-- Revenu final par seconde d'un dino posé sur le socle `slot` (index en chaîne, comme dans le profil).
function Bonuses.dinoIncome(data: Types.ProfileData, ctx: Context, uuid: string, slot: string): number
	local instance = data.Dinos[uuid]
	if not instance then
		return 0
	end
	return Bonuses.instanceIncome(instance)
		* Plots.levelMultiplier(data.SlotLevels[slot] or 1)
		* Bonuses.globalCoinsMultiplier(data, ctx)
end

-- Stats de combat (Volcan) d'un exemplaire : base × instinct (Féroce/Robuste/Alpha…) × arbre × (1 + Reliques).
-- Le Grade ne compte pas : il ne touche que le revenu. Dégâts = dégâts par seconde.
function Bonuses.combatStats(data: Types.ProfileData, instance: Types.DinoInstance): (number, number)
	local dino = byId(Dinos, instance.dinoId)
	if not dino then
		return 0, 0
	end
	local instinct = byId(Instincts, instance.instinct)
	local relicDamage, relicHealth = 0, 0
	for _, uuid in data.EquippedRelics do
		local owned = data.Relics[uuid]
		local relic = owned and byId(Relics.list, owned.relicId)
		if relic and relic.stat == "damageBonus" then
			relicDamage += relic.value
		elseif relic and relic.stat == "healthBonus" then
			relicHealth += relic.value
		end
	end
	local damage = dino.baseDamage
		* (if instinct then instinct.damageMultiplier else 1)
		* Bonuses.upgradeStat(data.Upgrades, "damageMultiplier")
		* (1 + relicDamage)
	local health = dino.baseHealth
		* (if instinct then instinct.healthMultiplier else 1)
		* Bonuses.upgradeStat(data.Upgrades, "healthMultiplier")
		* (1 + relicHealth)
	return damage, health
end

-- Revenu total par seconde de tous les dinos posés.
function Bonuses.totalIncome(data: Types.ProfileData, ctx: Context): number
	local total = 0
	for slot, uuid in data.PlotSlots do
		local instance = data.Dinos[uuid]
		if instance then
			total += Bonuses.instanceIncome(instance) * Plots.levelMultiplier(data.SlotLevels[slot] or 1)
		end
	end
	return total * Bonuses.globalCoinsMultiplier(data, ctx)
end

return Bonuses
