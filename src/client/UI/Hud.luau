--!strict
-- HUD principal (mobile d'abord) :
--   haut : bandeau d'événement, Réglages (les monnaies ont leur barre fine : CurrencyController) ;
--   gauche (repliable) : Boutique, Rebirth, Paléo-Encyclopédie, Quêtes, Échange, Sac, Améliorer, Reliques, Potions ;
--   bas : gros bouton LANCER ; au-dessus : Auto-Lancer, « Chance x… » (détail puis écran des chances), Masquer.
-- Affichage seul : les valeurs viennent de DataController, de LuckController et des modules partagés purs.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Events = require(Shared.Config.Events)
local Remotes = require(Shared.Net.Remotes)

local Controllers = script.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local UIController = require(Controllers.UIController)

local Kit = require(script.Parent.Kit)
local Theme = require(script.Parent.Theme)

local Hud = {}

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

function Hud.create(root: Frame)
	local secondary: { GuiObject } = {}

	-- Bandeau d'événement, coin haut droit au-dessus des Réglages (lit l'attribut « ServerEvent » du Workspace).
	local _, bannerBody = Kit.panel(root, {
		Name = "EventBanner",
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.fromOffset(220, 22),
	}, Theme.ParchmentDark, 0.5)
	local bannerText = Kit.title(bannerBody, "", { TextColor3 = Theme.InkSoft }, 14)
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
			Position = UDim2.new(1, -6 - (i - 1) * 56, 0, 30),
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
		Size = UDim2.fromOffset(120, 336),
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
		{ "🎒", "Sac", "Backpack", Color3.fromHex("#F2433A") },
		{ "⬆️", "Améliorer", "Upgrades", Color3.fromHex("#9BE22D") },
	}
	for i, item in railItems do
		local cell = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = i, Size = UDim2.fromScale(1, 0.184), Parent = rail }
		)
		cell.Name = item[3] -- noms stables : tests et futurs tutoriels
		local button = iconButton(cell, item[1], item[2], item[4], function()
			if item[3] == "Rebirth" then
				-- On renaît au Totem du Renouveau : le bouton y téléporte (l'écran s'ouvre au totem).
				Remotes.ShrineTeleport:FireServer("Shrine")
			else
				UIController:Open(item[3])
			end
		end)
		if item[3] == "Backpack" then
			-- Pastille « 12/30 » : rouge quand le sac est plein.
			local badge = Kit.label(button, "", {
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, 4, 0, -4),
				Size = UDim2.fromOffset(34, 14),
				BackgroundTransparency = 0,
				BackgroundColor3 = Theme.Navy,
				TextColor3 = Theme.White,
				ZIndex = 3,
			}, 10)
			Kit.corner(badge, 0.3)
			local data = DataController:Get()
			local function inventory()
				local count = 0
				for _ in data.Dinos do
					count += 1
				end
				local size = Bonuses.backpackSize(data)
				badge.Text = `{count}/{size}`
				badge.BackgroundColor3 = if count >= size then Theme.Lava else Theme.Navy
			end
			DataController:OnChanged("Dinos", inventory)
			DataController:OnChanged("Upgrades", inventory)
			inventory()
		end
	end

	for i, item in
		{
			{ "💍", "Reliques", "Relics", Theme.Neutral },
			{ "🧪", "Potions", "Shop", Theme.Cyan },
		}
	do
		local cell = Kit.new(
			"Frame",
			{ Name = item[2], BackgroundTransparency = 1, LayoutOrder = #railItems + i, Parent = rail }
		)
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
	require(script.Parent.RollDock).create(root)
end

return Hud
