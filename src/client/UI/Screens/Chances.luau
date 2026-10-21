--!strict
-- Écran des chances (obligation Roblox) : probabilité EXACTE de chaque dino avec le dé équipé et la chance
-- totale actuelle (Odds.exactDistribution), plus les tables des trèfles, tailles et peaux.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Clovers = require(Shared.Config.Clovers)
local Dice = require(Shared.Config.Dice)
local Dinos = require(Shared.Config.Dinos)
local Helpers = require(Shared.Config.Helpers)
local Mutations = require(Shared.Config.Mutations)
local Odds = require(Shared.Odds)
local Rarities = require(Shared.Config.Rarities)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local LuckController = require(Controllers.LuckController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "🎲 Chances exactes" }

local function section(list: Instance, order: number, text: string)
	Kit.row(list, { { text = text, width = 1, font = Theme.TitleFont, color = Theme.Ink } }, order, 32)
end

local function perMillionRows(list: Instance, order: number, entries: { any }, label: (any) -> string): number
	for i, entry in entries do
		Kit.row(list, {
			{ text = label(entry), width = 0.6 },
			{
				text = Kit.percent(entry.perMillion / Helpers.PER_MILLION),
				width = 0.4,
				align = Enum.TextXAlignment.Right,
				font = Theme.NumberFont,
			},
		}, order + i, 26, if i % 2 == 0 then Theme.ParchmentDark else nil)
	end
	return order + #entries + 1
end

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()

	local header = Kit.label(win.content, "", {
		Size = UDim2.fromScale(1, 0.13),
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Theme.BodyFont,
	}, 20)
	local list = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.15), Size = UDim2.fromScale(1, 0.85) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", {
		PaddingLeft = UDim.new(0.015, 0),
		PaddingRight = UDim.new(0.015, 0),
		PaddingTop = UDim.new(0, 4),
		Parent = list,
	})

	local function render(b: LuckController.Breakdown)
		for _, child in list:GetChildren() do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end
		local die = Kit.find(Dice, data.EquippedDice) or Dice[1]
		header.Text =
			`{die.displayName} ({Kit.mult(die.luck)}) · Chance totale {Kit.mult(b.total)} — chances de CE lancer, sans trèfle.`

		Kit.row(list, {
			{ text = "Dino", width = 0.32, font = Theme.TitleFont },
			{ text = "Rareté", width = 0.2, font = Theme.TitleFont },
			{ text = "Base", width = 0.2, font = Theme.TitleFont, align = Enum.TextXAlignment.Right },
			{ text = "Chance exacte", width = 0.28, font = Theme.TitleFont, align = Enum.TextXAlignment.Right },
		}, 0, 30, Theme.ParchmentDeep)

		local distribution = Odds.exactDistribution(b.total)
		for i, dino in Dinos do
			if dino.exclusive then
				continue
			end
			local rarity = Rarities[dino.rarity]
			local found = data.Index.Found[dino.id] == true
			Kit.row(list, {
				{
					text = (if found then "" else "❔ ") .. dino.displayName,
					width = 0.32,
					color = Kit.darker(rarity.color, 0.15),
				},
				{ text = rarity.displayName, width = 0.2, color = Kit.darker(rarity.color, 0.15) },
				{
					text = `1 sur {Kit.big(dino.oneIn)}`,
					width = 0.2,
					align = Enum.TextXAlignment.Right,
					font = Theme.NumberFont,
				},
				{
					text = Kit.percent(distribution[dino.id] or 0),
					width = 0.28,
					align = Enum.TextXAlignment.Right,
					font = Theme.NumberFont,
				},
			}, i, 28, if i % 2 == 0 then Theme.ParchmentDark else nil)
		end

		local order = 100
		section(list, order, "🍀 Trèfle (multiplie la chance du lancer)")
		order = perMillionRows(list, order, Clovers, function(c)
			return if c.multiplier == 1 then "Aucun trèfle" else `Trèfle x{c.multiplier}`
		end)
		section(list, order + 100, "📏 Taille (tirée à chaque dino)")
		order = perMillionRows(list, order + 100, Mutations.Sizes, function(s)
			return `{s.displayName} (Fossiles {Kit.mult(s.coinsMultiplier)})`
		end)
		section(list, order + 100, "🎨 Peau (tirée à chaque dino)")
		perMillionRows(list, order + 100, Mutations.Skins, function(s)
			return `{s.displayName} (Fossiles {Kit.mult(s.coinsMultiplier)})`
		end)
	end

	win.maid:add(LuckController:OnChanged(render))
	render(LuckController:Get())
	LuckController:Refresh()
end

return Screen
