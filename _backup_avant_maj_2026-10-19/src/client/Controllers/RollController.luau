--!strict
-- Lancers : envoie l'intention « lancer » (bouton, Auto-Lancer, Lancer Doré) et montre le résultat du serveur.
-- Aucune logique de tirage ici. Le délai affiché vient de GetLuckBreakdown ; le serveur l'applique de son côté.
-- Auto-Lancer = le client renvoie RequestRoll en boucle ; il se met en pause pendant une grande révélation
-- et s'arrête quand le sac est plein (simple affichage dérivé du profil et de Bonuses.backpackSize).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataController = require(script.Parent.DataController)
local LuckController = require(script.Parent.LuckController)
local NotificationController = require(script.Parent.NotificationController)
local SettingsController = require(script.Parent.SettingsController)
local UIController = require(script.Parent.UIController)

local UI = script.Parent.Parent.UI
local Kit = require(UI.Kit)

local lastRoll = -math.huge
local rolledListeners: { (cooldown: number) -> () } = {}
local reveal: any = nil -- module RollReveal, chargé au Start

local RollController = {}

local function backpackFull(): boolean
	local data: Types.ProfileData = DataController:Get()
	local count = 0
	for _ in data.Dinos do
		count += 1
	end
	return count >= Bonuses.backpackSize(data)
end

-- Appelle `fn(cooldown)` à chaque lancer envoyé (pour l'anneau de recharge du bouton).
function RollController:OnRolled(fn: (cooldown: number) -> ()): () -> ()
	table.insert(rolledListeners, fn)
	return function()
		local i = table.find(rolledListeners, fn)
		if i then
			table.remove(rolledListeners, i)
		end
	end
end

-- Temps restant avant le prochain lancer possible (affichage).
function RollController:Remaining(): number
	return math.max(0, lastRoll + LuckController:Get().cooldown - os.clock())
end

function RollController:Roll(): boolean
	if self:Remaining() > 0.02 then
		return false
	end
	if backpackFull() then
		NotificationController:Toast("Ton sac est plein ! Vends ou agrandis ton sac.", "error")
		SettingsController:Set("AutoRoll", false)
		return false
	end
	lastRoll = os.clock()
	Remotes.RequestRoll:FireServer()
	local cooldown = LuckController:Get().cooldown
	for _, fn in rolledListeners do
		task.spawn(fn, cooldown)
	end
	return true
end

function RollController:Golden()
	local data: Types.ProfileData = DataController:Get()
	if data.GoldenRolls < 1 then
		NotificationController:Toast("Tu n'as aucun Lancer Doré.", "error")
		return
	end
	Remotes.UseGoldenRoll:FireServer()
end

local autoGeneration = 0 -- une seule boucle à la fois, même si on rallume vite

local function autoLoop()
	autoGeneration += 1
	local generation = autoGeneration
	while SettingsController:Get("AutoRoll") and generation == autoGeneration do
		if not (reveal and reveal.isBusy()) then
			RollController:Roll()
		end
		task.wait(math.max(0.1, RollController:Remaining() + 0.05))
	end
end

local function describe(result: Types.RollResult): string
	local dino = Kit.dinoById[result.dinoId]
	local rarity = Kit.rarityOf(result.dinoId)
	local name = if dino then dino.displayName else result.dinoId
	local new = if result.isNewInIndex then " · NOUVEAU !" else ""
	return `{name} ({rarity.displayName}) · 1 sur {Kit.big(result.oneInDisplayed)}{new}`
end

function RollController:Start()
	DataController:Get()
	reveal = require(UI.RollReveal)
	reveal.init(UIController:CreateLayer("DinoReveal", 8, true))

	Remotes.RollResult.OnClientEvent:Connect(function(result: Types.RollResult)
		if SettingsController:Get("HideReveal") then
			NotificationController:Toast(describe(result), "info")
		else
			reveal.play(result)
		end
	end)

	SettingsController:OnChanged(function(key, value)
		if key == "AutoRoll" and value then
			task.spawn(autoLoop)
		end
	end)
	if SettingsController:Get("AutoRoll") then
		task.spawn(autoLoop) -- réglage sauvegardé, lu avant que l'écouteur soit branché
	end
end

return RollController
