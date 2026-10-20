--!strict
-- Détail de la chance totale, ligne par ligne, tel que calculé par le serveur (GetLuckBreakdown).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Clovers = require(ReplicatedStorage.Shared.Config.Clovers)
local Helpers = require(ReplicatedStorage.Shared.Config.Helpers)

local Controllers = script.Parent.Parent.Parent.Controllers
local LuckController = require(Controllers.LuckController)
local UIController = require(Controllers.UIController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "🍀 Détail de la chance" }

function Screen.build(win: Window.Window)
	local list = Kit.scroll(win.content, { Size = UDim2.fromScale(0.62, 1) })
	Kit.list(list, false, 0.01)
	Kit.padding(list, 0.02)

	local side = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.65, 0),
		Size = UDim2.fromScale(0.35, 1),
		Parent = win.content,
	})
	local cooldown = Kit.number(side, "", { Size = UDim2.fromScale(1, 0.16) }, 20)
	local cloverLines = {}
	for _, clover in Clovers do
		if clover.multiplier > 1 then
			table.insert(cloverLines, `x{clover.multiplier} : {Kit.percent(clover.perMillion / Helpers.PER_MILLION)}`)
		end
	end
	Kit.label(side, "Trèfle à chaque lancer (en plus) :\n" .. table.concat(cloverLines, "\n"), {
		Position = UDim2.fromScale(0, 0.18),
		Size = UDim2.fromScale(1, 0.52),
		TextColor3 = Theme.InkSoft,
		Font = Theme.NumberFont,
	}, 16)
	local chances = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 0.76),
		Size = UDim2.fromScale(1, 0.22),
		Parent = side,
	})
	Kit.button(chances, "Toutes les chances", {
		color = Theme.Leaf,
		maid = win.maid,
		maxText = 20,
		onClick = function()
			UIController:Open("Chances")
		end,
	})

	local function render(b: LuckController.Breakdown)
		for _, child in list:GetChildren() do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end
		for i, factor in b.factors do
			Kit.row(list, {
				{ text = factor.label, width = 0.7 },
				{
					text = Kit.mult(factor.multiplier),
					width = 0.3,
					align = Enum.TextXAlignment.Right,
					font = Theme.NumberFont,
					color = if factor.multiplier > 1 then Theme.LeafDark else Theme.InkSoft,
				},
			}, i, 30, if i % 2 == 0 then Theme.ParchmentDark else nil)
		end
		Kit.row(list, {
			{ text = "Chance totale", width = 0.6, font = Theme.TitleFont },
			{
				text = Kit.mult(b.total),
				width = 0.4,
				align = Enum.TextXAlignment.Right,
				font = Enum.Font.GothamBlack,
				color = Theme.LeafDark,
			},
		}, 100, 36, Theme.ParchmentDeep)
		cooldown.Text = `Délai entre deux lancers : {Kit.decimal(b.cooldown)} s`
	end
	win.maid:add(LuckController:OnChanged(render))
	render(LuckController:Get())
	LuckController:Refresh()
end

return Screen
