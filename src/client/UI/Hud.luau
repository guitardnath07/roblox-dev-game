--!strict
-- HUD principal (mobile d'abord) :
--   haut : bandeau d'événement, Réglages (les monnaies ont leur barre fine : CurrencyController) ;
--   gauche : Boutique, Rebirth, Paléo-Encyclopédie, Quêtes, Échange ;
--   bas : gros bouton LANCER (couleur du dé équipé, anneau de recharge), Sac à gauche, Améliorations à droite,
--         bouton texte « Chances » ; au-dessus : Auto-Lancer, « Chance x… » (détail), Masquer.
-- Affichage seul : les valeurs viennent de DataController, de LuckController et des modules partagés purs.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Dice = require(Shared.Config.Dice)
local Events = require(Shared.Config.Events)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local LuckController = require(Controllers.LuckController)
local NotificationController = require(Controllers.NotificationController)
local RollController = require(Controllers.RollController)
local SettingsController = require(Controllers.SettingsController)
local UIController = require(Controllers.UIController)

local Kit = require(script.Parent.Kit)
local Theme = require(script.Parent.Theme)

local Hud = {}

-- Anneau de progression circulaire (deux moitiés découpées + dégradé net qui tourne).
local function makeRing(parent: Instance, color: Color3, thickness: number): (number) -> ()
	local gradients: { UIGradient } = {}
	for side = 1, 2 do
		local clip = Kit.new("Frame", {
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Position = UDim2.fromScale(if side == 1 then 0.5 else 0, 0),
			Size = UDim2.fromScale(0.5, 1),
			Parent = parent,
		})
		local circle = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(if side == 1 then -0.86 else 0.14, 0.07),
			Size = UDim2.fromScale(1.72, 0.86),
			Parent = clip,
		})
		Kit.corner(circle, 0.5)
		local stroke = Kit.stroke(circle, color, thickness)
		gradients[side] = Kit.new("UIGradient", {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.501, 1),
				NumberSequenceKeypoint.new(1, 1),
			}),
			Parent = stroke,
		})
	end
	return function(p: number)
		local progress = math.clamp(p, 0, 1)
		gradients[1].Rotation = math.min(progress, 0.5) * 360
		gradients[2].Rotation = 180 + math.clamp(progress - 0.5, 0, 0.5) * 360
	end
end

-- Icône 3D (ReplicatedStorage.Assets.Icons) de chaque emoji du HUD ; l'emoji reste en repli.
local ICONS: { [string]: string } = {
	["🛒"] = "Shop",
	["🔁"] = "Rebirth",
	["📖"] = "Index",
	["📜"] = "Quests",
	["🤝"] = "Trade",
	["💍"] = "Relics",
	["🧪"] = "Potions",
	["🎒"] = "Backpack",
	["⬆️"] = "Upgrade",
	["⚙️"] = "Settings",
}

-- Gros bouton carré « bonbon » à icône 3D (rail de gauche, Sac, Améliorations).
local function iconButton(parent: Instance, icon: string, caption: string, color: Color3, onClick: () -> ()): TextButton
	local button = Kit.button(parent, "", { color = Theme.Navy, onClick = onClick })
	local border = button:FindFirstChildOfClass("UIStroke")
	if border then
		border.Color = color
		border.Transparency = 0.3
	end
	local padding = button:FindFirstChildOfClass("UIPadding")
	if padding then
		padding:Destroy()
	end
	Kit.icon(button, ICONS[icon], icon, { Position = UDim2.fromScale(0.05, 0.02), Size = UDim2.fromScale(0.9, 0.64) })
	Kit.title(button, caption, {
		Position = UDim2.fromScale(0.04, 0.64),
		Size = UDim2.fromScale(0.92, 0.32),
		TextColor3 = Theme.White,
		TextStrokeTransparency = 1,
	}, 18)
	return button
end

local function toggleColor(on: boolean): Color3
	return if on then Theme.Leaf else Theme.Neutral
end

function Hud.create(root: Frame)
	local data: Types.ProfileData = DataController:Get()
	local secondary: { GuiObject } = {}

	-- Bandeau d'événement (provisoire : lit l'attribut « ServerEvent » du Workspace).
	local bannerHolder, bannerBody = Kit.panel(root, {
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0.075, 10),
		Size = UDim2.fromScale(0.32, 0.065),
	}, Theme.ParchmentDark, 0.5)
	Kit.limit(bannerHolder, nil, Vector2.new(360, 26))
	local bannerText = Kit.title(bannerBody, "", { TextColor3 = Theme.InkSoft }, 18)
	local function clock(at: any): string
		local left = if type(at) == "number" then math.max(0, at - Workspace:GetServerTimeNow()) else 0
		return string.format("%d:%02d", left // 60, left % 60)
	end
	local function refreshEvent()
		local id = Workspace:GetAttribute("ServerEvent")
		local event = if type(id) == "string" then Kit.find(Events.list, id) else nil
		if event then
			bannerText.Text = `⚡ {event.displayName} ! ({clock(Workspace:GetAttribute("ServerEventEndsAt"))})`
			bannerText.TextColor3 = Theme.Lava
		else
			local nextAt = Workspace:GetAttribute("NextServerEventAt")
			bannerText.Text = if type(nextAt) == "number"
				then `Prochain événement dans {clock(nextAt)}`
				else "Prochain événement bientôt…"
			bannerText.TextColor3 = Theme.InkSoft
		end
	end
	Workspace:GetAttributeChangedSignal("ServerEvent"):Connect(function()
		refreshEvent()
	end)
	task.spawn(function()
		while bannerText.Parent do
			refreshEvent()
			task.wait(1)
		end
	end)

	-- Profil et Réglages (coin haut droit). Noms stables : tests et futurs tutoriels.
	for i, item in
		{
			{ name = "Settings", icon = "⚙️", color = Theme.Neutral, screen = "Settings" },
			{ name = "Profile", icon = "👤", color = Color3.fromHex("#2F9BFF"), screen = "Profile" },
		}
	do
		local holder = Kit.new("Frame", {
			Name = item.name,
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -6 - (i - 1) * 56, 0, 4),
			Size = UDim2.fromScale(0.13, 0.13),
			Parent = root,
		})
		table.insert(secondary, holder)
		Kit.aspect(holder, 1, true)
		Kit.limit(holder, nil, Vector2.new(50, 50))
		local button = Kit.button(holder, "", {
			color = item.color,
			onClick = function()
				UIController:Open(item.screen)
			end,
		})
		Kit.icon(button, ICONS[item.icon], item.icon, { Size = UDim2.fromScale(1, 1) })
	end

	-- Rail de gauche -----------------------------------------------------------------------------------------
	local rail = Kit.new("CanvasGroup", {
		Name = "LeftRail",
		BackgroundTransparency = 1,
		-- En haut à gauche : le bas gauche est la zone du joystick tactile.
		Position = UDim2.fromOffset(6, 4),
		Size = UDim2.fromOffset(120, 268),
		Parent = root,
	})

	Kit.new("UIGridLayout", {
		CellSize = UDim2.fromOffset(56, 60),
		CellPadding = UDim2.fromOffset(8, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = rail,
	})
	local railItems = {
		{ "🛒", "Boutique", "Shop", Color3.fromHex("#FFA21F") },
		{ "🔁", "Rebirth", "Rebirth", Color3.fromHex("#E040FB") },
		{ "📖", "Paléo", "Encyclopedia", Color3.fromHex("#FF6A2B") },
		{ "📜", "Quêtes", "Quests", Color3.fromHex("#2F7BFF") },
		{ "🤝", "Échange", "Trade", Color3.fromHex("#2FD14A") },
	}
	for i, item in railItems do
		local cell = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = i, Size = UDim2.fromScale(1, 0.184), Parent = rail }
		)
		cell.Name = item[3] -- noms stables : tests et futurs tutoriels
		iconButton(cell, item[1], item[2], item[4], function()
			if item[3] == "Rebirth" then
				-- On renaît au Totem du Renouveau : le bouton y téléporte (l'écran s'ouvre au totem).
				Remotes.ShrineTeleport:FireServer("Shrine")
			else
				UIController:Open(item[3])
			end
		end)
	end

	for i, item in
		{
			{ "💍", "Reliques", "Relics", Theme.Neutral },
			{ "🧪", "Potions", "Shop", Theme.Cyan },
		}
	do
		local cell =
			Kit.new("Frame", { Name = item[2], BackgroundTransparency = 1, LayoutOrder = 5 + i, Parent = rail })
		iconButton(cell, item[1], item[2], item[4], function()
			UIController:Open(item[3], if i == 2 then 4 else nil)
		end)
	end
	local handle = Kit.new("Frame", {
		Name = "IconsToggle",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(134, 8),
		Size = UDim2.fromOffset(44, 44),
		Parent = root,
	})
	local collapse = Kit.button(handle, "‹", { color = Theme.Navy, maxText = 30 })
	local expanded = true
	local slide: Tween? = nil
	local fade: Tween? = nil
	collapse.Activated:Connect(function()
		expanded = not expanded
		collapse.Text = if expanded then "‹" else "›"
		if slide then
			slide:Cancel()
		end
		if fade then
			fade:Cancel()
		end
		if expanded then
			rail.Visible = true
		end
		slide = Kit.tween(rail, 0.22, {
			Position = UDim2.fromOffset(if expanded then 6 else -130, 4),
		}, Enum.EasingStyle.Quart)
		fade = Kit.tween(rail, 0.18, { GroupTransparency = if expanded then 0 else 1 })
		Kit.tween(handle, 0.22, { Position = UDim2.fromOffset(if expanded then 134 else 6, 8) })
		for _, object in secondary do
			object.Visible = expanded
		end
		if not expanded and fade then
			fade.Completed:Once(function()
				if not expanded then
					rail.Visible = false
				end
			end)
		end
	end)
	-- Bas : grappe du bouton LANCER ------------------------------------------------------------------------
	local ASPECT = 3 -- largeur / hauteur de la grappe : X = fraction de hauteur / ASPECT
	local cluster = Kit.new("Frame", {
		Name = "RollCluster",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -4),
		Size = UDim2.fromScale(0.86, 0.36),
		Parent = root,
	})
	Kit.aspect(cluster, ASPECT, true)
	Kit.limit(cluster, nil, Vector2.new(600, 200))

	local function place(height: number, centerX: number, y: number, aspect: number?): Frame
		local width = height * (aspect or 1) / ASPECT
		return Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(centerX - width / 2, y),
			Size = UDim2.fromScale(width, height),
			Parent = cluster,
		})
	end

	-- Rangée du haut : Auto, Chance, Masquer.
	local autoButton = Kit.button(place(0.27, 0.13, 0, 2.3), "AUTO", { color = toggleColor(false), maxText = 22 })
	local hideButton = Kit.button(place(0.27, 0.87, 0, 2.3), "MASQUER", { color = toggleColor(false), maxText = 22 })
	local luckButton = Kit.button(place(0.27, 0.5, 0, 4.6), "🍀 Chance x1", {
		color = Theme.Parchment,
		textColor = Theme.LeafDark,
		font = Enum.Font.GothamBlack,
		maxText = 22,
		onClick = function()
			UIController:Open("LuckBreakdown")
		end,
	})
	luckButton.TextStrokeTransparency = 1

	local function refreshToggles()
		local auto = SettingsController:Get("AutoRoll")
		local hide = SettingsController:Get("HideReveal")
		autoButton.Text = if not SettingsController:AutoRollUnlocked()
			then "🔒 AUTO"
			elseif auto then "AUTO ✔"
			else "AUTO"
		hideButton.Text = if hide then "MASQUÉ ✔" else "MASQUER"
		Kit.paint(autoButton, toggleColor(auto))
		Kit.paint(hideButton, toggleColor(hide))
	end
	autoButton.Activated:Connect(function()
		if not SettingsController:AutoRollUnlocked() then
			NotificationController:Toast(
				"Débloque l'Auto-Lancer dans l'arbre d'améliorations (à côté de Chance I).",
				"error"
			)
			return
		end
		SettingsController:Set("AutoRoll", not SettingsController:Get("AutoRoll"))
	end)
	DataController:OnChanged("Upgrades", refreshToggles)
	hideButton.Activated:Connect(function()
		local hide = not SettingsController:Get("HideReveal")
		SettingsController:Set("HideReveal", hide)
		NotificationController:Toast(
			if hide
				then "Révélations masquées : une simple notification par tirage."
				else "Révélations affichées.",
			"info"
		)
	end)
	SettingsController:OnChanged(refreshToggles)
	refreshToggles()

	local function refreshLuck(b: { total: number })
		luckButton.Text = `🍀 Chance {Kit.mult(b.total)}`
	end
	LuckController:OnChanged(refreshLuck)
	refreshLuck(LuckController:Get())

	-- Rangée du bas : Sac, LANCER, Améliorations, Chances.
	local rollHolder = place(0.68, 0.5, 0.31)
	local backpackHolder = place(0.5, 0.288, 0.45)
	local upgradesHolder = place(0.5, 0.712, 0.45)
	local chancesHolder = place(0.3, 0.9, 0.6, 1.75)

	rollHolder.Name = "Roll"
	table.insert(secondary, backpackHolder)
	table.insert(secondary, upgradesHolder)
	table.insert(secondary, chancesHolder)
	backpackHolder.Name = "Backpack"
	upgradesHolder.Name = "Upgrades"
	chancesHolder.Name = "Chances"
	local backpackButton = iconButton(backpackHolder, "🎒", "Sac", Color3.fromHex("#F2433A"), function()
		UIController:Open("Backpack")
	end)
	iconButton(upgradesHolder, "⬆️", "Améliorer", Color3.fromHex("#9BE22D"), function()
		UIController:Open("Upgrades")
	end)
	Kit.button(chancesHolder, "Chances", {
		color = Theme.Parchment,
		textColor = Theme.Ink,
		maxText = 20,
		onClick = function()
			UIController:Open("Chances")
		end,
	})

	-- Pastille « 12/30 » sur le Sac.
	local badge = Kit.new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Ink,
		Position = UDim2.fromScale(0.85, 0.08),
		Size = UDim2.fromScale(0.62, 0.26),
		ZIndex = 3,
		Parent = backpackButton,
	})
	Kit.corner(badge, 0.5)
	local badgeText = Kit.number(badge, "", { TextColor3 = Theme.White, ZIndex = 3, Font = Enum.Font.GothamBold }, 16)
	local function refreshBadge()
		local count = 0
		for _ in data.Dinos do
			count += 1
		end
		local size = Bonuses.backpackSize(data)
		badgeText.Text = `{count}/{size}`
		badge.BackgroundColor3 = if count >= size then Theme.Lava else Theme.Ink
	end
	DataController:OnChanged("Dinos", refreshBadge)
	DataController:OnChanged("Upgrades", refreshBadge)
	refreshBadge()

	-- Le bouton LANCER lui-même.
	local setRing = makeRing(rollHolder, Theme.Gold, 5)
	local rollButton = Kit.new("TextButton", {
		Name = "RollButton",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.8, 0.8),
		Text = "",
		AutoButtonColor = true,
		Parent = rollHolder,
	})
	Kit.corner(rollButton, 0.5)
	local rollStroke = Kit.stroke(rollButton, Theme.StoneDark, 4)
	Kit.touch(rollButton)
	Kit.feedback(rollButton)
	local iconHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 0.12),
		Size = UDim2.fromScale(0.42, 0.42),
		Parent = rollButton,
	})
	local paintDie = Kit.dieIcon(iconHolder)
	Kit.title(rollButton, "LANCER", {
		Position = UDim2.fromScale(0.1, 0.58),
		Size = UDim2.fromScale(0.8, 0.26),
		TextColor3 = Theme.White,
		TextStrokeTransparency = 0,
		TextStrokeColor3 = Theme.Ink,
	}, 30)
	local press = Kit.new("UIScale", { Parent = rollHolder })
	local dieSpin: Tween? = nil

	local function refreshDie()
		local die = Kit.find(Dice, data.EquippedDice) or Dice[1]
		local h, s, v = die.color:ToHSV()
		rollButton.BackgroundColor3 = Color3.fromHSV(h, s * 0.75, math.min(1, v + 0.1))
		rollStroke.Color = Kit.darker(die.color, 0.45)
		paintDie(die.color)
	end
	DataController:OnChanged("EquippedDice", refreshDie)
	refreshDie()

	rollButton.Activated:Connect(function()
		press.Scale = 0.9
		Kit.tween(press, 0.2, { Scale = 1 }, Enum.EasingStyle.Back)
		RollController:Roll()
	end)

	-- Anneau de recharge : se remplit pendant le délai renvoyé par GetLuckBreakdown.
	setRing(1)
	local ringConnection: RBXScriptConnection? = nil
	RollController:OnRolled(function(cooldown: number)
		if dieSpin then
			dieSpin:Cancel()
		end
		iconHolder.Rotation = -24
		dieSpin = Kit.tween(iconHolder, math.min(cooldown, 0.45), { Rotation = 0 }, Enum.EasingStyle.Back)
		if ringConnection then
			ringConnection:Disconnect()
		end
		local start = os.clock()
		ringConnection = RunService.RenderStepped:Connect(function()
			local p = (os.clock() - start) / math.max(cooldown, 0.05)
			setRing(p)
			if p >= 1 and ringConnection then
				ringConnection:Disconnect()
				ringConnection = nil
			end
		end)
	end)
end

return Hud
