--!strict
-- Paléo-Encyclopédie : les 28 espèces, silhouettes noires pour celles pas encore trouvées, chance de base,
-- et paliers de récompense (Economy.IndexMilestones, réclamés par ClaimIndexMilestone).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Dinos = require(Shared.Config.Dinos)
local Economy = require(Shared.Config.Economy)
local Rarities = require(Shared.Config.Rarities)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataController = require(script.Parent.Parent.Parent.Controllers.DataController)
local NotificationController = require(script.Parent.Parent.Parent.Controllers.NotificationController)

local DinoView = require(script.Parent.Parent.DinoView)
local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "📖 Paléo-Encyclopédie" }

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()

	local progress = Kit.title(win.content, "", {
		Size = UDim2.fromScale(0.3, 0.21),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, 26)
	local milestones = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.31, 0),
		Size = UDim2.fromScale(0.69, 0.21),
		Parent = win.content,
	})
	Kit.list(milestones, true, 0.01, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)

	local grid = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.23), Size = UDim2.fromScale(1, 0.61) })
	Kit.grid(grid, 7, 0.8)
	local detail = Kit.label(win.content, "Touche un dino pour lire sa fiche.", {
		Position = UDim2.fromScale(0, 0.86),
		Size = UDim2.fromScale(1, 0.14),
		TextColor3 = Theme.InkSoft,
	}, 18)

	local cellMaid = Kit.maid()
	win.maid:add(cellMaid)

	local animateIn = true
	local function render()
		cellMaid:clean()
		local foundCount = 0
		for _ in data.Index.Found do
			foundCount += 1
		end
		progress.Text = `Trouvés : {foundCount} / {#Dinos}`

		for i, m in Economy.IndexMilestones do
			local reached = foundCount >= m.found
			local claimed = data.Index.ClaimedMilestones[tostring(m.found)] == true
			local pill = Kit.new("TextButton", {
				AutoButtonColor = reached and not claimed,
				Text = "",
				BackgroundColor3 = if claimed then Theme.Stone elseif reached then Theme.Leaf else Theme.ParchmentDark,
				LayoutOrder = i,
				Size = UDim2.fromScale(0.19, 0.9),
				Parent = milestones,
			})
			cellMaid:add(pill)
			Kit.touch(pill)
			if reached and not claimed then
				cellMaid:add(pill.Activated:Connect(function()
					local ok, response = pcall(function()
						return Remotes.ClaimIndexMilestone:InvokeServer(m.found)
					end)
					local good = ok and type(response) == "table" and response.ok
					NotificationController:Toast(
						if ok and type(response) == "table"
							then tostring(response.message)
							else "Réessaie dans un instant.",
						if good then "info" else "error"
					)
				end))
			end
			Kit.corner(pill, 0.3)
			Kit.stroke(pill, if reached then Theme.LeafDark else Theme.Stone, 2)
			local reward = `{m.amber}🔶` .. (if m.fossils > 0 then ` {m.fossils}🦴` else "")
			Kit.number(pill, `{if claimed then "✔ " else ""}{m.found} : {reward}`, {
				TextColor3 = if reached then Theme.White else Theme.Ink,
				Font = Enum.Font.GothamBold,
			}, 16)
		end

		for i, dino in Dinos do
			local rarity = Rarities[dino.rarity]
			local found = data.Index.Found[dino.id] == true
			local cell = Kit.new("TextButton", {
				AutoButtonColor = true,
				Text = "",
				BackgroundColor3 = if found then Theme.Parchment else Theme.ParchmentDeep,
				LayoutOrder = i,
				Parent = grid,
			})
			cellMaid:add(cell)
			Kit.feedback(cell)
			if animateIn then
				Kit.stagger(cell, i)
			end
			Kit.corner(cell, 0.12)
			Kit.stroke(cell, if found then rarity.color else Theme.Stone, 2)
			local viewHolder = Kit.new("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.05, 0.03),
				Size = UDim2.fromScale(0.9, 0.6),
				Parent = cell,
			})
			local view = DinoView.new(viewHolder, dino.id, { silhouette = not found })
			cellMaid:add(view.destroy)
			Kit.title(cell, if found then dino.displayName else "???", {
				Position = UDim2.fromScale(0.04, 0.64),
				Size = UDim2.fromScale(0.92, 0.18),
				TextColor3 = if found then Kit.darker(rarity.color, 0.2) else Theme.InkSoft,
			}, 16)
			Kit.number(cell, `1 sur {Kit.big(dino.oneIn)}`, {
				Position = UDim2.fromScale(0.04, 0.82),
				Size = UDim2.fromScale(0.92, 0.15),
				TextColor3 = Theme.InkSoft,
			}, 14)
			cellMaid:add(cell.Activated:Connect(function()
				if found then
					detail.Text =
						`{dino.displayName} · {rarity.displayName} · {Kit.big(dino.baseIncome)} Pièces/s de base — {dino.description}`
				else
					detail.Text =
						`??? · {rarity.displayName} · chance de base 1 sur {Kit.big(dino.oneIn)}. Pas encore trouvé !`
				end
			end))
		end
	end

	-- Redessine seulement quand l'Index change (pas à chaque Pièce gagnée).
	win.maid:add(DataController:OnChanged("Index", render))
	render()
	animateIn = false
end

return Screen
