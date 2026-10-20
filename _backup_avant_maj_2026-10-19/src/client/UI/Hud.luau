--!strict
-- HUD principal (mobile d'abord) :
--   haut : Pièces (+X/s), Ambre, Fossiles, Lancers Dorés (+ bouton), bandeau d'événement, Réglages ;
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

-- Pastille de monnaie du haut. Renvoie (valeur, sous-texte, cadre).
local function chip(parent: Instance, icon: string, order: number, width: number): (TextLabel, TextLabel, Frame)
	local _, body = Kit.panel(parent, { LayoutOrder = order, Size = UDim2.fromScale(width, 1) }, Theme.Parchment, 0.3)
	Kit.label(body, icon, { Position = UDim2.fromScale(0.03, 0.1), Size = UDim2.fromScale(0.22, 0.8) }, 30)
	local value = Kit.number(body, "0", {
		Position = UDim2.fromScale(0.26, 0.06),
		Size = UDim2.fromScale(0.72, 0.56),
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamBlack,
	}, 26)
	local sub = Kit.number(body, "", {
		Position = UDim2.fromScale(0.26, 0.6),
		Size = UDim2.fromScale(0.72, 0.34),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Theme.LeafDark,
	}, 16)
	return value, sub, body
end

-- Gros bouton carré à icône (rail de gauche, Sac, Améliorations).
local function iconButton(parent: Instance, icon: string, caption: string, color: Color3, onClick: () -> ()): TextButton
	local button = Kit.button(parent, "", { color = color, onClick = onClick })
	local padding = button:FindFirstChildOfClass("UIPadding")
	if padding then
		padding:Destroy()
	end
	Kit.label(button, icon, { Position = UDim2.fromScale(0, 0.04), Size = UDim2.fromScale(1, 0.6) }, 40)
	Kit.title(button, caption, {
		Position = UDim2.fromScale(0.04, 0.64),
		Size = UDim2.fromScale(0.92, 0.32),
		TextColor3 = Theme.White,
		TextStrokeTransparency = 0.3,
	}, 18)
	return button
end

local function toggleColor(on: boolean): Color3
	return if on then Theme.Leaf else Theme.Stone
end

function Hud.create(root: Frame)
	local data: Types.ProfileData = DataController:Get()

	-- Haut : monnaies -----------------------------------------------------------------------------------------
	local top = Kit.new("Frame", {
		Name = "TopBar",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 4),
		Size = UDim2.fromScale(0.72, 0.13),
		Parent = root,
	})
	Kit.limit(top, nil, Vector2.new(760, 50))
	Kit.list(top, true, 0.012, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

	local coins, income, coinsBody = chip(top, "💰", 1, 0.3)
	local amber, _, _ = chip(top, "🔶", 2, 0.18)
	local fossils, _, _ = chip(top, "🦴", 3, 0.18)
	local golden, _, goldenBody = chip(top, "✨", 4, 0.3)
	golden.Size = UDim2.fromScale(0.3, 0.56)
	local goldenCaption = Kit.number(goldenBody, "Lancers Dorés", {
		Position = UDim2.fromScale(0.26, 0.6),
		Size = UDim2.fromScale(0.3, 0.34),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Theme.AmberDark,
	}, 14)
	goldenCaption.Name = "GoldenCaption"
	local useHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.fromScale(0.98, 0.5),
		Size = UDim2.fromScale(0.42, 1),
		Parent = goldenBody,
	})
	Kit.button(useHolder, "Lancer", {
		color = Theme.Gold,
		textColor = Theme.Ink,
		maxText = 18,
		onClick = function()
			RollController:Golden()
		end,
	})

	-- Compteurs animés (défilement des chiffres).
	local setCoins = Kit.countUp(coins, Kit.big)
	local setIncome = Kit.countUp(income, function(v)
		return `+{Kit.big(v)}/s`
	end)
	local coinsPop = Kit.new("UIScale", { Parent = coinsBody })
	local lastCoins = data.Coins
	local function refreshCurrencies()
		setCoins(data.Coins)
		amber.Text = Kit.big(data.Amber)
		fossils.Text = Kit.big(data.Fossils)
		golden.Text = Kit.group(data.GoldenRolls)
		if data.Coins > lastCoins then
			coinsPop.Scale = 1.06
			Kit.tween(coinsPop, 0.25, { Scale = 1 })
		end
		lastCoins = data.Coins
	end
	-- Revenu réel renvoyé par le serveur (GetLuckBreakdown), rafraîchi avec la chance.
	local function refreshIncome()
		setIncome(LuckController:Get().incomePerSecond)
	end
	for _, key in { "Coins", "Amber", "Fossils", "GoldenRolls" } do
		DataController:OnChanged(key, refreshCurrencies)
	end
	LuckController:OnChanged(refreshIncome)
	refreshCurrencies()
	refreshIncome()

	-- Bandeau d'événement (provisoire : lit l'attribut « ServerEvent » du Workspace).
	local bannerHolder, bannerBody = Kit.panel(root, {
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0.14, 8),
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

	-- Réglages (coin haut droit).
	local settingsHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.fromScale(0.13, 0.13),
		Parent = root,
	})
	Kit.aspect(settingsHolder, 1, true)
	Kit.limit(settingsHolder, nil, Vector2.new(50, 50))
	Kit.button(settingsHolder, "⚙️", {
		color = Theme.Stone,
		maxText = 28,
		onClick = function()
			UIController:Open("Settings")
		end,
	})

	-- Rail de gauche -----------------------------------------------------------------------------------------
	local rail = Kit.new("Frame", {
		Name = "LeftRail",
		BackgroundTransparency = 1,
		-- En haut à gauche : le bas gauche est la zone du joystick tactile.
		Position = UDim2.fromOffset(6, 4),
		Size = UDim2.fromScale(0.2, 0.8),
		Parent = root,
	})
	Kit.aspect(rail, 0.2, true)
	Kit.limit(rail, nil, Vector2.new(70, 350))
	Kit.list(rail, false, 0.02, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)
	local railItems = {
		{ "🛒", "Boutique", "Shop", Theme.Amber },
		{ "🔁", "Rebirth", "Rebirth", Color3.fromHex("#B36AE2") },
		{ "📖", "Paléo", "Encyclopedia", Color3.fromHex("#8D6E4A") },
		{ "📜", "Quêtes", "Quests", Theme.Sky },
		{ "🤝", "Échange", "Trade", Theme.LeafDark },
	}
	for i, item in railItems do
		local cell = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = i, Size = UDim2.fromScale(1, 0.184), Parent = rail }
		)
		Kit.aspect(cell, 1, true)
		cell.Name = item[3] -- noms stables : tests et futurs tutoriels
		iconButton(cell, item[1], item[2], item[4], function()
			UIController:Open(item[3])
		end)
	end

	-- Deuxième colonne (Reliques, Potions), accrochée à la case Boutique pour rester hors du UIListLayout.
	local rail2 = Kit.new("Frame", {
		Name = "SecondRail",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, 6, 0, 0),
		Size = UDim2.fromScale(1, 2.11),
		Parent = rail:FindFirstChild("Shop"),
	})
	Kit.list(rail2, false, 0.05, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)
	for i, item in
		{
			{ "💍", "Reliques", Color3.fromHex("#C08A2E"), "Relics", nil },
			{ "🧪", "Potions", Color3.fromHex("#5C9E8F"), "Shop", 4 },
		}
	do
		local cell = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = i, Size = UDim2.fromScale(1, 0.474), Parent = rail2 }
		)
		cell.Name = item[4] .. (if item[5] then "Potions" else "")
		iconButton(cell, item[1], item[2], item[3], function()
			UIController:Open(item[4], item[5])
		end)
	end
	-- Bas : grappe du bouton LANCER ------------------------------------------------------------------------
	local ASPECT = 3 -- largeur / hauteur de la grappe : X = fraction de hauteur / ASPECT
	local cluster = Kit.new("Frame", {
		Name = "RollCluster",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -4),
		Size = UDim2.fromScale(1, 0.46),
		Parent = root,
	})
	Kit.aspect(cluster, ASPECT, true)
	Kit.limit(cluster, nil, Vector2.new(720, 240))

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
		autoButton.Text = if auto then "AUTO ✔" else "AUTO"
		hideButton.Text = if hide then "MASQUÉ ✔" else "MASQUER"
		Kit.paint(autoButton, toggleColor(auto))
		Kit.paint(hideButton, toggleColor(hide))
	end
	autoButton.Activated:Connect(function()
		SettingsController:Set("AutoRoll", not SettingsController:Get("AutoRoll"))
	end)
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
	local chancesHolder = place(0.3, 0.885, 0.6, 1.75)

	rollHolder.Name = "Roll"
	backpackHolder.Name = "Backpack"
	upgradesHolder.Name = "Upgrades"
	chancesHolder.Name = "Chances"
	local backpackButton = iconButton(backpackHolder, "🎒", "Sac", Color3.fromHex("#A0703C"), function()
		UIController:Open("Backpack")
	end)
	iconButton(upgradesHolder, "⬆️", "Améliorer", Theme.Sky, function()
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
