--!strict
-- Réglages, deux onglets :
--   Réglages : interrupteurs (Musique, Effets sonores, Masquer les révélations, Auto-Lancer) ;
--   Statistiques : chiffres du joueur lus dans son profil (DataController) et sa chance / revenu (LuckController).
-- Affichage seul : rien n'est calculé ici qui compte pour le jeu.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Dice = require(Shared.Config.Dice)
local Odds = require(Shared.Odds)
local Types = require(Shared.Types)
local Upgrades = require(Shared.Config.Upgrades)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local LuckController = require(Controllers.LuckController)
local SettingsController = require(Controllers.SettingsController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "⚙️ Réglages", aspect = 1.5 }

local ITEMS: { { key: SettingsController.Key, label: string } } = {
	{ key = "Music", label = "🎵 Musique" },
	{ key = "Sfx", label = "🔊 Effets sonores" },
	{ key = "HideReveal", label = "🙈 Masquer les révélations" },
	{ key = "AutoRoll", label = "🎲 Auto-Lancer" },
}

local function count(set: { [any]: any }?): number
	local n = 0
	for _ in set or {} do
		n += 1
	end
	return n
end

-- Chaque statistique : icône + nom, et la fonction qui donne le texte à afficher.
local STATS: { { label: string, value: (data: Types.ProfileData) -> string } } = {
	{
		label = "🎲 Lancers",
		value = function(data)
			return Kit.group(data.TotalRolls)
		end,
	},
	{
		label = "🏆 Meilleur tirage",
		value = function(data)
			local dino = Kit.dinoById[data.BestPull.DinoId]
			return if dino then `{dino.displayName} (1 sur {Kit.big(data.BestPull.OneIn)})` else "—"
		end,
	},
	{
		label = "📖 Espèces trouvées",
		value = function(data)
			return `{count(data.Index.Found)} / {Odds.rollableCount}`
		end,
	},
	{
		label = "🦖 Dinos possédés",
		value = function(data)
			return Kit.group(count(data.Dinos))
		end,
	},
	{
		label = "🐚 Revenu",
		value = function()
			return `+{Kit.big(LuckController:Get().incomePerSecond)}/s`
		end,
	},
	{
		label = "🍀 Chance totale",
		value = function()
			return Kit.mult(LuckController:Get().total)
		end,
	},
	{
		label = "🔁 Rebirths",
		value = function(data)
			return Kit.group(data.Rebirths)
		end,
	},
	{
		label = "🎲 Dés possédés",
		value = function(data)
			return `{count(data.OwnedDice)} / {#Dice}`
		end,
	},
	{
		label = "⬆️ Améliorations",
		value = function(data)
			return `{count(data.Upgrades)} / {#Upgrades.list}`
		end,
	},
	{
		label = "💍 Reliques",
		value = function(data)
			return Kit.group(count(data.Relics))
		end,
	},
	{
		label = "🌋 Volcan (étage max)",
		value = function(data)
			return if data.VolcanoBestFloor > 0 then tostring(data.VolcanoBestFloor) else "—"
		end,
	},
	{
		label = "📅 Série quotidienne",
		value = function(data)
			return `{data.Daily.Streak} jour(s)`
		end,
	},
}

local function buildSettings(page: Frame, win: Window.Window)
	local list = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.84), Parent = page })
	Kit.list(list, false, 0.03)
	local refreshers: { () -> () } = {}
	for i, item in ITEMS do
		local row = Kit.new("Frame", {
			BackgroundColor3 = Theme.ParchmentDark,
			LayoutOrder = i,
			Size = UDim2.fromScale(1, 0.22),
			Parent = list,
		})
		Kit.corner(row, 0.2)
		Kit.title(row, item.label, {
			Position = UDim2.fromScale(0.03, 0.1),
			Size = UDim2.fromScale(0.6, 0.8),
			TextXAlignment = Enum.TextXAlignment.Left,
		}, 26)
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(0.98, 0.5),
			Size = UDim2.fromScale(0.25, 0.86),
			Parent = row,
		})
		local button = Kit.button(holder, "", {
			maid = win.maid,
			onClick = function()
				SettingsController:Set(item.key, not SettingsController:Get(item.key))
			end,
		})
		table.insert(refreshers, function()
			local on = SettingsController:Get(item.key)
			button.Text = if on then "Oui" else "Non"
			Kit.paint(button, if on then Theme.Leaf else Theme.Neutral)
		end)
	end
	local function refresh()
		for _, fn in refreshers do
			fn()
		end
	end
	win.maid:add(SettingsController:OnChanged(refresh))
	refresh()
	Kit.label(page, "Tes réglages sont sauvegardés.", {
		Position = UDim2.fromScale(0, 0.87),
		Size = UDim2.fromScale(1, 0.12),
		TextColor3 = Theme.InkSoft,
	}, 16)
end

-- Grille de cartes (2 colonnes) : nom en petit, valeur en gros.
local function buildStats(page: Frame, win: Window.Window)
	local grid = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = page })
	Kit.new("UIGridLayout", {
		CellSize = UDim2.fromScale(0.485, 0.145),
		CellPadding = UDim2.fromScale(0.03, 0.022),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = grid,
	})
	local values: { TextLabel } = {}
	for i, stat in STATS do
		local card = Kit.new("Frame", { BackgroundColor3 = Theme.ParchmentDark, LayoutOrder = i, Parent = grid })
		Kit.corner(card, 0.25)
		Kit.stroke(card, Theme.ParchmentDeep, 2)
		Kit.label(card, stat.label, {
			Position = UDim2.fromScale(0.05, 0.06),
			Size = UDim2.fromScale(0.9, 0.38),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Theme.InkSoft,
		}, 16)
		values[i] = Kit.number(card, "", {
			Position = UDim2.fromScale(0.05, 0.44),
			Size = UDim2.fromScale(0.9, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Theme.Ink,
			Font = Enum.Font.GothamBlack,
		}, 24)
	end
	local function refresh()
		local data: Types.ProfileData = DataController:Get()
		for i, stat in STATS do
			values[i].Text = stat.value(data)
		end
	end
	win.maid:add(DataController:OnChanged("*", refresh))
	win.maid:add(LuckController:OnChanged(refresh))
	refresh()
end

function Screen.build(win: Window.Window)
	local tabs = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.12), Parent = win.content })
	Kit.list(tabs, true, 0.02, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
	local pages: { Frame } = {}
	local buttons: { TextButton } = {}
	local function show(index: number)
		for i, page in pages do
			page.Visible = i == index
			Kit.paint(buttons[i], if i == index then Theme.Amber else Theme.Neutral)
		end
	end
	for i, name in { "⚙️ Réglages", "📊 Statistiques" } do
		local holder = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = i, Size = UDim2.fromScale(0.36, 1), Parent = tabs }
		)
		buttons[i] = Kit.button(holder, name, {
			maxText = 22,
			maid = win.maid,
			onClick = function()
				show(i)
			end,
		})
		pages[i] = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0, 0.15),
			Size = UDim2.fromScale(1, 0.85),
			Parent = win.content,
		})
	end
	buildSettings(pages[1], win)
	buildStats(pages[2], win)
	show(1)
end

return Screen
