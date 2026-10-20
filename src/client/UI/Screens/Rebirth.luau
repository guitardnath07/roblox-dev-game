--!strict
-- Rebirth : coût, progression, ce qui est gardé / perdu, nouveau multiplicateur (Config/Rebirth, Config/Plots),
-- puis confirmation avant d'envoyer l'intention « Rebirth » (le serveur vérifie le coût).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Plots = require(Shared.Config.Plots)
local Rebirth = require(Shared.Config.Rebirth)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local UIController = require(Controllers.UIController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "🔁 Rebirth" }

local function box(parent: Instance, title: string, color: Color3, x: number): TextLabel
	local holder, body = Kit.panel(parent, {
		Position = UDim2.fromScale(x, 0.36),
		Size = UDim2.fromScale(0.32, 0.42),
	}, Theme.Parchment, 0.08)
	local stroke = body:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Color = color
	end
	Kit.title(
		body,
		title,
		{ Position = UDim2.fromScale(0.05, 0.03), Size = UDim2.fromScale(0.9, 0.22), TextColor3 = color },
		24
	)
	local _ = holder
	return Kit.label(body, "", {
		Position = UDim2.fromScale(0.06, 0.28),
		Size = UDim2.fromScale(0.88, 0.68),
		TextYAlignment = Enum.TextYAlignment.Top,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, 18)
end

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()

	local headline = Kit.title(win.content, "", { Size = UDim2.fromScale(1, 0.14) }, 30)
	local barBack = Kit.new("Frame", {
		BackgroundColor3 = Theme.ParchmentDeep,
		Position = UDim2.fromScale(0.1, 0.17),
		Size = UDim2.fromScale(0.8, 0.12),
		Parent = win.content,
	})
	Kit.corner(barBack, 0.5)
	Kit.stroke(barBack, Theme.Stone, 2)
	local bar = Kit.new("Frame", { BackgroundColor3 = Theme.Amber, Size = UDim2.fromScale(0, 1), Parent = barBack })
	Kit.corner(bar, 0.5)
	local barText = Kit.number(barBack, "", { ZIndex = 2, Font = Enum.Font.GothamBold }, 20)

	local kept = box(win.content, "✔ Tu gardes", Theme.LeafDark, 0)
	local lost = box(win.content, "✖ Tu perds", Theme.Lava, 0.34)
	local gained = box(win.content, "⭐ Tu gagnes", Theme.AmberDark, 0.68)

	local buttonHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 0.82),
		Size = UDim2.fromScale(0.4, 0.17),
		Parent = win.content,
	})
	local button = Kit.button(buttonHolder, "Renaître", { color = Theme.Amber, maid = win.maid })

	local function refresh()
		local n = data.Rebirths
		local cost = Rebirth.cost(n + 1)
		local p = math.clamp(data.Fossils / cost, 0, 1)
		headline.Text = `Rebirth {n} → {n + 1}`
		bar.Size = UDim2.fromScale(p, 1)
		barText.Text = `{Kit.big(data.Fossils)} / {Kit.big(cost)} Fossiles`
		kept.Text = "• Tous tes dinos\n• Tes dés\n• Tes améliorations"
			.. (if Rebirth.keepsPedestalLevels then "\n• Les niveaux de tes socles" else "")
		lost.Text = `• Tous tes Fossiles ({Kit.big(data.Fossils)})`
		gained.Text = `• Fossiles {Kit.mult(Rebirth.coinsMultiplier(n))} → {Kit.mult(Rebirth.coinsMultiplier(n + 1))}\n`
			.. `• Chance {Kit.mult(Rebirth.luckMultiplier(n))} → {Kit.mult(Rebirth.luckMultiplier(n + 1))}\n`
			.. `• Socles {Plots.pedestalCount(n)} → {Plots.pedestalCount(n + 1)}`
		Kit.paint(button, if p >= 1 then Theme.Amber else Theme.Disabled)
		button.Text = if p >= 1 then "Renaître" else `Il manque {Kit.big(cost - data.Fossils)}`
	end

	win.maid:add(button.Activated:Connect(function()
		local cost = Rebirth.cost(data.Rebirths + 1)
		if data.Fossils < cost then
			return
		end
		UIController:Dialog(
			"Confirmer le rebirth ?",
			`Tes {Kit.big(data.Fossils)} Fossiles seront remis à 0. Tu gardes tes dinos, dés et améliorations, `
				.. `et tes multiplicateurs passent à {Kit.mult(Rebirth.coinsMultiplier(data.Rebirths + 1))}.`,
			{
				{ text = "Annuler", color = Theme.Stone },
				{
					text = "Renaître !",
					color = Theme.Amber,
					onClick = function()
						Remotes.Rebirth:FireServer()
					end,
				},
			}
		)
	end))
	win.maid:add(DataController:OnChanged("Fossils", refresh))
	win.maid:add(DataController:OnChanged("Rebirths", refresh))
	refresh()
end

return Screen
