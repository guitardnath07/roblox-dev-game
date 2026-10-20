--!strict
-- Volcan des Défis : choix de l'équipe (5 dinos max, Dégâts / PV de Bonuses.combatStats), puis VolcanoStart.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)
local Volcano = require(Shared.Config.Volcano)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local UIController = require(Controllers.UIController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "🌋 Volcan des Défis" }

type Candidate = { uuid: string, instance: Types.DinoInstance, damage: number, health: number, power: number }

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()
	local size = Volcano.teamSize
	local team: { string } = {}

	local candidates: { Candidate } = {}
	for uuid, instance in data.Dinos do
		local damage, health = Bonuses.combatStats(data, instance)
		table.insert(
			candidates,
			{ uuid = uuid, instance = instance, damage = damage, health = health, power = damage * health }
		)
	end
	table.sort(candidates, function(a, b)
		return if a.power ~= b.power then a.power > b.power else a.uuid < b.uuid
	end)

	local startFloor = math.min(data.VolcanoBestFloor + 1, Volcano.floorCount)
	local floorDef = Volcano.floors[startFloor]
	Kit.label(
		win.content,
		`Étage {startFloor}{if floorDef.isBoss then " (BOSS)" else ""} · ennemi {Kit.big(floorDef.enemyHealth)} PV, {Kit.big(
			floorDef.enemyDamage
		)} dégâts/s · record : {data.VolcanoBestFloor}`,
		{
			Size = UDim2.fromScale(1, 0.12),
			TextXAlignment = Enum.TextXAlignment.Left,
		},
		20
	)

	local grid = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.14), Size = UDim2.fromScale(1, 0.64) })
	Kit.grid(grid, 5, 1.1)

	local bottom = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 0.8),
		Size = UDim2.fromScale(1, 0.2),
		Parent = win.content,
	})
	Kit.list(bottom, true, 0.02, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)
	local summary = Kit.number(
		bottom,
		"",
		{ LayoutOrder = 0, Size = UDim2.fromScale(0.4, 1), TextXAlignment = Enum.TextXAlignment.Left },
		20
	)
	local function action(order: number, text: string, color: Color3): TextButton
		local holder = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = order, Size = UDim2.fromScale(0.27, 1), Parent = bottom }
		)
		return Kit.button(holder, text, { color = color, maid = win.maid })
	end
	local bestButton = action(1, "Meilleure équipe", Theme.Sky)
	local goButton = action(2, "Partir !", Theme.Lava)

	local cellMaid = Kit.maid()
	win.maid:add(cellMaid)
	local animateIn = true

	local function render()
		cellMaid:clean()
		local damage, health = 0, 0
		for i, c in candidates do
			local index = table.find(team, c.uuid)
			if index then
				damage += c.damage
				health += c.health
			end
			local dino = Kit.dinoById[c.instance.dinoId]
			local rarity = Kit.rarityOf(c.instance.dinoId)
			local cell = Kit.new("TextButton", {
				AutoButtonColor = true,
				Text = "",
				LayoutOrder = i,
				BackgroundColor3 = if index then Theme.Gold else Theme.Parchment,
				Parent = grid,
			})
			cellMaid:add(cell)
			Kit.corner(cell, 0.12)
			Kit.stroke(cell, rarity.color, if index then 4 else 2)
			Kit.feedback(cell)
			if animateIn then
				Kit.stagger(cell, i)
			end
			Kit.title(cell, (if index then `#{index} ` else "") .. (if dino then dino.displayName else "?"), {
				Position = UDim2.fromScale(0.05, 0.06),
				Size = UDim2.fromScale(0.9, 0.3),
				TextColor3 = Kit.darker(rarity.color, 0.2),
			}, 18)
			Kit.number(
				cell,
				`⚔️ {Kit.big(c.damage)}`,
				{ Position = UDim2.fromScale(0.05, 0.42), Size = UDim2.fromScale(0.9, 0.24) },
				16
			)
			Kit.number(
				cell,
				`❤️ {Kit.big(c.health)}`,
				{ Position = UDim2.fromScale(0.05, 0.7), Size = UDim2.fromScale(0.9, 0.24) },
				16
			)
			cellMaid:add(cell.Activated:Connect(function()
				local at = table.find(team, c.uuid)
				if at then
					table.remove(team, at)
				elseif #team < size then
					table.insert(team, c.uuid)
				end
				render()
			end))
		end
		animateIn = false
		summary.Text = `Équipe {#team}/{size} · ⚔️ {Kit.big(damage)}/s · ❤️ {Kit.big(health)}`
		Kit.paint(goButton, if #team > 0 then Theme.Lava else Theme.Disabled)
	end

	win.maid:add(bestButton.Activated:Connect(function()
		table.clear(team)
		for i = 1, math.min(size, #candidates) do
			table.insert(team, candidates[i].uuid)
		end
		render()
	end))
	win.maid:add(goButton.Activated:Connect(function()
		if #team > 0 then
			Remotes.VolcanoStart:FireServer(team)
			UIController:CloseWindow()
		end
	end))
	render()
end

return Screen
