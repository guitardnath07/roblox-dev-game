--!strict
-- Profil d'un nouveau joueur. ProfileStore:Reconcile() ajoute ces champs aux anciens profils.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Dice = require(ReplicatedStorage.Shared.Config.Dice)
local Types = require(ReplicatedStorage.Shared.Types)

local CURRENT_VERSION = 2

local template: Types.ProfileData = {
	DataVersion = CURRENT_VERSION,
	Fossils = 0,
	Amber = 0,
	Bones = 0,
	GoldenRolls = 0,
	Tickets = 0,
	TotalRolls = 0,
	Rebirths = 0,
	EquippedDice = Dice[1].id,
	OwnedDice = { [Dice[1].id] = true },
	Dinos = {},
	PlotSlots = {},
	SlotLevels = {},
	Upgrades = {},
	Relics = {},
	EquippedRelics = {},
	Index = { Found = {}, ClaimedMilestones = {} },
	Quests = { dailyPeriod = 0, weeklyPeriod = 0, daily = {}, weekly = {} },
	Daily = { Streak = 0, LastClaim = 0 },
	GroupChestLastClaim = 0,
	RedeemedCodes = {},
	ActivePotions = {},
	Potions = {},
	TradeLog = {},
	VolcanoBestFloor = 0,
	ProcessedPurchases = {},
	Settings = { AutoRoll = false, AutoEquip = false, HideReveal = false, Music = true, Sfx = true },
	LastOnline = 0,
	LastIncomePerSecond = 0,
	BestPull = { DinoId = "", OneIn = 0 },
	Profile = { Title = "explorer", Showcase = "" },
	Stats = {},
}

return {
	CURRENT_VERSION = CURRENT_VERSION,
	template = template,
}
