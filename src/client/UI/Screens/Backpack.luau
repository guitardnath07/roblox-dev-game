--!strict
-- Sac à dos : grille des dinos (filtre de rareté, tri), sélection multiple pour vendre (SellDinos, « Tout »
-- coche tous les dinos vendables du filtre),
-- fiche du dino choisi : verrou (ToggleLock), Poser sur un socle libre (PlaceDino) / Reprendre (RemoveDino),
-- relances (écran Reroll), « Équiper les meilleurs » (EquipBest) et l'interrupteur « AUTO » (réglage AutoEquip,
-- débloqué par le nœud auto_equip de l'arbre). Le serveur vérifie tout.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Grades = require(Shared.Config.Grades)
local Imprints = require(Shared.Config.Imprints)
local Instincts = require(Shared.Config.Instincts)
local Mutations = require(Shared.Config.Mutations)
local Plots = require(Shared.Config.Plots)
local Rarities = require(Shared.Config.Rarities)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local NotificationController = require(Controllers.NotificationController)
local SettingsController = require(Controllers.SettingsController)
local UIController = require(Controllers.UIController)

local DinoView = require(script.Parent.Parent.DinoView)
local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

-- Style « simulateur » : panneau bleu nuit, cartes colorées par rareté, fiche à droite, barre d'actions en bas.
local Screen = { title = "🎒 SAC À DOS", style = "cartoon", accent = Theme.Cyan }

local RARITY_ORDER: { Rarities.Rarity } = {}
for _, rarity in Rarities do
	table.insert(RARITY_ORDER, rarity)
end
table.sort(RARITY_ORDER, function(a, b)
	return a.order < b.order
end)

local SORTS = { "Revenu", "Rareté", "Récent" }

type Entry = { uuid: string, instance: Types.DinoInstance, income: number, order: number, placed: string? }

local function slotOf(data: Types.ProfileData, uuid: string): string?
	for slot, placed in data.PlotSlots do
		if placed == uuid then
			return slot
		end
	end
	return nil
end

-- Deux premières lettres (UTF-8) pour le médaillon d'une case.
local function initials(name: string): string
	local stop = utf8.offset(name, 3)
	return if stop then name:sub(1, stop - 1) else name
end

function Screen.build(win: Window.Window, selectedUuid: string?)
	local data: Types.ProfileData = DataController:Get()
	local filter = 0 -- 0 = toutes, sinon ordre de rareté
	local sortIndex = 1
	local selecting = false
	local selection: { [string]: boolean } = {}
	local selected: string? = selectedUuid

	-- Barre d'outils ---------------------------------------------------------------------------------------
	local bar = Kit.new("Frame", {
		BackgroundColor3 = Theme.Navy,
		Position = UDim2.fromScale(0, 0.87),
		Size = UDim2.fromScale(1, 0.13),
		Parent = win.content,
	})
	Kit.corner(bar, 0.3)
	Kit.stroke(bar, Theme.Outline, 3)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0), Parent = bar })
	Kit.list(bar, true, 0.012, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
	local function tool(order: number, width: number, text: string, color: Color3): TextButton
		local holder = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = order, Size = UDim2.fromScale(width, 1), Parent = bar }
		)
		local b = Kit.button(holder, text, { color = color, maid = win.maid, maxText = 18 })
		holder.Size = UDim2.fromScale(width, 0.8)
		return b
	end
	-- Compteur du sac (pastille), puis filtres et actions.
	local countHolder = Kit.new("Frame", {
		BackgroundColor3 = Theme.NavyDeep,
		LayoutOrder = 0,
		Size = UDim2.fromScale(0.13, 0.8),
		Parent = bar,
	})
	Kit.corner(countHolder, 0.4)
	Kit.stroke(countHolder, Theme.Cyan, 2)
	local count = Kit.number(countHolder, "", {
		Size = UDim2.fromScale(1, 1),
		Font = Enum.Font.GothamBlack,
		TextColor3 = Theme.Cyan,
	}, 22)
	local filterButton = tool(1, 0.17, "", Theme.NavyLight)
	local sortButton = tool(2, 0.15, "", Theme.NavyLight)
	local selectButton = tool(3, 0.14, "Sélection", Theme.Neutral)
	local sellButton = tool(4, 0.15, "Vendre", Theme.Lava)
	local bestButton = tool(5, 0.2, "ÉQUIPER MEILLEURS", Theme.Amber)
	local autoButton = tool(6, 0.13, "", Theme.Leaf)
	local allButton = tool(7, 0.2, "TOUT SÉLECTIONNER", Theme.Sky)

	-- Grille ---------------------------------------------------------------------------------------------------
	local grid = Kit.scroll(win.content, {
		BackgroundTransparency = 1,
		ScrollBarImageColor3 = Theme.Cyan,
		Size = UDim2.fromScale(0.6, 0.85),
	})
	Kit.grid(grid, 4, 0.82)

	-- Fiche ----------------------------------------------------------------------------------------------------
	local detailHolder, detailBody = Kit.panel(win.content, {
		Position = UDim2.fromScale(0.62, 0),
		Size = UDim2.fromScale(0.38, 0.85),
	}, Theme.NavyLight, 0.05)
	local _ = detailHolder;
	(detailBody:FindFirstChildOfClass("UIStroke") :: UIStroke).Color = Theme.Outline;
	(detailBody:FindFirstChildOfClass("UIGradient") :: UIGradient).Color =
		ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(170, 175, 210))
	local detail = Kit.scroll(detailBody, { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
	Kit.list(detail, false, 0)
	Kit.new("UIPadding", {
		PaddingLeft = UDim.new(0.04, 0),
		PaddingRight = UDim.new(0.04, 0),
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		Parent = detail,
	})

	local gridMaid = Kit.maid()
	local detailMaid = Kit.maid()
	win.maid:add(gridMaid)
	win.maid:add(detailMaid)

	local renderGrid: () -> ()

	local function entries(): { Entry }
		local list: { Entry } = {}
		for uuid, instance in data.Dinos do
			local rarity = Kit.rarityOf(instance.dinoId)
			if filter == 0 or rarity.order == filter then
				table.insert(list, {
					uuid = uuid,
					instance = instance,
					income = Bonuses.instanceIncome(instance),
					order = rarity.order,
					placed = slotOf(data, uuid),
				})
			end
		end
		table.sort(list, function(a, b)
			if sortIndex == 2 and a.order ~= b.order then
				return a.order > b.order
			elseif sortIndex == 3 and a.instance.obtainedAt ~= b.instance.obtainedAt then
				return a.instance.obtainedAt > b.instance.obtainedAt
			elseif a.income ~= b.income then
				return a.income > b.income
			end
			return a.uuid < b.uuid
		end)
		return list
	end

	local function infoRow(text: string, color: Color3?, height: number?, font: Enum.Font?)
		local l = Kit.label(detail, text, {
			LayoutOrder = #detail:GetChildren(),
			Size = UDim2.new(1, 0, 0, height or 22),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = color or Theme.White,
			TextStrokeColor3 = Theme.Outline,
			TextStrokeTransparency = 0.5,
			Font = font or Theme.BodyFont,
		}, 20)
		detailMaid:add(l)
	end

	local function actionRow(buttons: { { text: string, color: Color3, onClick: () -> () } })
		local row = Kit.new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = #detail:GetChildren(),
			Size = UDim2.new(1, 0, 0, 48),
			Parent = detail,
		})
		detailMaid:add(row)
		Kit.list(row, true, 0.03, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
		for i, b in buttons do
			local holder = Kit.new("Frame", {
				BackgroundTransparency = 1,
				LayoutOrder = i,
				Size = UDim2.new(0.97 / #buttons - 0.02, 0, 0, 46),
				Parent = row,
			})
			Kit.button(holder, b.text, { color = b.color, maid = detailMaid, onClick = b.onClick, maxText = 16 })
		end
	end

	local function openSlotPicker(uuid: string)
		local total = Plots.pedestalCount(data.Rebirths)
		-- holder -> fond assombri -> racine du calque des fenêtres
		local layerRoot = (win.holder.Parent :: Instance).Parent :: Instance
		local picker = Window.open(layerRoot, "Choisis un socle", { aspect = 1.6, height = 0.75, zIndex = 30 })
		win.maid:add(picker.close)
		local list = Kit.scroll(picker.content, { Size = UDim2.fromScale(1, 1) })
		Kit.grid(list, 3, 2.4)
		for slot = 1, total do
			local occupant = data.PlotSlots[tostring(slot)]
			local occupantDino = occupant and data.Dinos[occupant]
			local base = occupantDino and Kit.dinoById[occupantDino.dinoId]
			local level = data.SlotLevels[tostring(slot)] or 1
			local text = `Socle {slot} (Niv. {level})\n` .. (if base then `remplacer {base.displayName}` else "libre")
			local holder = Kit.new(
				"Frame",
				{ BackgroundTransparency = 1, LayoutOrder = (if occupant then 100 else 0) + slot, Parent = list }
			)
			Kit.button(holder, text, {
				color = if occupant then Theme.Stone else Theme.Leaf,
				maid = picker.maid,
				maxText = 18,
				onClick = function()
					Remotes.PlaceDino:FireServer(uuid, slot)
					picker.close()
				end,
			})
		end
	end

	local function renderDetail()
		detailMaid:clean()
		local uuid = selected
		local instance = uuid and data.Dinos[uuid]
		if not uuid or not instance then
			infoRow("Touche un dino pour voir sa fiche.", Theme.TextMuted, 60)
			return
		end
		local dino = Kit.dinoById[instance.dinoId]
		local rarity = Kit.rarityOf(instance.dinoId)

		local viewHolder = Kit.new("Frame", {
			BackgroundColor3 = rarity.color,
			LayoutOrder = 0,
			Size = UDim2.new(1, 0, 0, 120),
			Parent = detail,
		})
		detailMaid:add(viewHolder)
		Kit.corner(viewHolder, 0.12)
		Kit.stroke(viewHolder, Theme.Outline, 3)
		Kit.new("UIGradient", {
			Rotation = 90,
			Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(90, 90, 120)),
			Parent = viewHolder,
		})
		local view =
			DinoView.new(viewHolder, instance.dinoId, { rotate = true, size = instance.size, skin = instance.skin })
		detailMaid:add(view.destroy)

		infoRow(if dino then dino.displayName else instance.dinoId, Theme.White, 32, Theme.TitleFont)
		infoRow(`★ {rarity.displayName}`, rarity.color, 22, Theme.TitleFont)
		local size = Kit.find(Mutations.Sizes, instance.size)
		local skin = Kit.find(Mutations.Skins, instance.skin)
		infoRow(`Taille : {size and size.displayName or "?"} · Peau : {skin and skin.displayName or "?"}`)
		local instinct = Kit.find(Instincts, instance.instinct)
		local grade = Kit.find(Grades, instance.grade)
		local imprint = Kit.find(Imprints.list, instance.imprint)
		infoRow(`Instinct : {instinct and instinct.displayName or "Aucun"}`)
		infoRow(
			`Grade : {grade and grade.displayName or "—"} · Empreinte : {imprint and imprint.displayName or "—"}`
		)
		infoRow(
			`+{Kit.big(Kit.instanceIncome(data, instance))} Fossiles/s (hors socle)`,
			Color3.fromHex("#7CFF6B"),
			24,
			Enum.Font.GothamBlack
		)
		local slot = slotOf(data, uuid)
		if slot then
			infoRow(`📍 Posé sur le socle {slot}`, Theme.TextMuted)
		end

		actionRow({
			{
				text = if instance.locked then "🔓 Déverrouiller" else "🔒 Verrouiller",
				color = Theme.Neutral,
				onClick = function()
					Remotes.ToggleLock:FireServer(uuid)
				end,
			},
			if slot
				then {
					text = "Reprendre",
					color = Theme.Sky,
					onClick = function()
						Remotes.RemoveDino:FireServer(tonumber(slot))
					end,
				}
				else {
					text = "POSER",
					color = Theme.Cyan,
					onClick = function()
						openSlotPicker(uuid)
					end,
				},
		})
		actionRow({
			{
				text = "Instinct 🦴",
				color = Color3.fromHex("#8D6E4A"),
				onClick = function()
					UIController:Open("Reroll", "instinct", uuid)
				end,
			},
			{
				text = "Grade 🔶",
				color = Theme.Amber,
				onClick = function()
					UIController:Open("Reroll", "grade", uuid)
				end,
			},
		})
		actionRow({
			{
				text = "Empreinte 🐚",
				color = Color3.fromHex("#B36AE2"),
				onClick = function()
					UIController:Open("Reroll", "imprint", uuid)
				end,
			},
			{
				text = `Vendre {Kit.big(Bonuses.sellPrice(data, instance.dinoId))}`,
				color = if instance.locked or slot then Theme.Disabled else Theme.Lava,
				onClick = function()
					if not instance.locked and not slot then
						Remotes.SellDinos:FireServer({ uuid })
					end
				end,
			},
		})
	end

	local animateIn = true -- seulement à l'ouverture, pas à chaque mise à jour
	renderGrid = function()
		gridMaid:clean()
		local list = entries()
		local total = 0
		for _ in data.Dinos do
			total += 1
		end
		count.Text = `🦖 {total}/{Bonuses.backpackSize(data)}`
		filterButton.Text = if filter == 0 then "Toutes" else RARITY_ORDER[filter].displayName
		Kit.paint(filterButton, if filter == 0 then Theme.NavyLight else RARITY_ORDER[filter].color)
		sortButton.Text = `Tri : {SORTS[sortIndex]}`
		local selectedCount = 0
		for uuid in selection do
			if data.Dinos[uuid] then
				selectedCount += 1
			else
				selection[uuid] = nil
			end
		end
		selectButton.Text = if selecting then "Annuler" else "Sélection"
		sellButton.Visible = selecting
		sellButton.Parent.Visible = selecting
		sellButton.Text = `Vendre ({selectedCount})`
		allButton.Parent.Visible = selecting
		bestButton.Parent.Visible = not selecting
		autoButton.Parent.Visible = not selecting
		local autoOn = SettingsController:Get("AutoEquip")
		autoButton.Text = if not SettingsController:AutoEquipUnlocked()
			then "🔒 AUTO"
			elseif autoOn then "AUTO ON"
			else "AUTO OFF"
		Kit.paint(autoButton, if autoOn then Theme.Leaf else Theme.Disabled)

		for i, entry in list do
			local rarity = Kit.rarityOf(entry.instance.dinoId)
			local dino = Kit.dinoById[entry.instance.dinoId]
			local sellable = not entry.instance.locked and entry.placed == nil
			local picked = selection[entry.uuid] == true
			local cell = Kit.new("TextButton", {
				AutoButtonColor = true,
				Text = "",
				LayoutOrder = i,
				BackgroundColor3 = if picked then Theme.Gold else rarity.color,
				Parent = grid,
			})
			gridMaid:add(cell)
			Kit.feedback(cell)
			if animateIn then
				Kit.stagger(cell, i)
			end
			Kit.corner(cell, 0.16)
			Kit.stroke(
				cell,
				if selected == entry.uuid then Theme.White else Theme.Outline,
				if selected == entry.uuid then 4 else 3
			)
			Kit.new("UIGradient", {
				Rotation = 90,
				Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(110, 110, 140)),
				Parent = cell,
			})
			if rarity.effect ~= "none" then
				Kit.rarityEffect(cell, rarity, gridMaid)
			end
			-- Le dino en 3D (au-delà de 60 cartes, initiales pour ménager les petits appareils).
			local stage = Kit.new("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.05, 0.03),
				Size = UDim2.fromScale(0.9, 0.62),
				Parent = cell,
			})
			if #list <= 60 then
				local view = DinoView.new(stage, entry.instance.dinoId)
				gridMaid:add(view.destroy)
			else
				Kit.title(stage, initials(if dino then dino.displayName else "?"), {
					TextColor3 = Theme.White,
					TextStrokeColor3 = Theme.Outline,
					TextStrokeTransparency = 0,
				}, 30)
			end
			Kit.title(cell, if dino then dino.displayName else entry.instance.dinoId, {
				Position = UDim2.fromScale(0.04, 0.6),
				Size = UDim2.fromScale(0.92, 0.17),
				TextColor3 = Theme.White,
				TextStrokeColor3 = Theme.Outline,
				TextStrokeTransparency = 0,
			}, 15)
			local strip = Kit.new("Frame", {
				BackgroundColor3 = Theme.Outline,
				BackgroundTransparency = 0.35,
				Position = UDim2.fromScale(0.08, 0.79),
				Size = UDim2.fromScale(0.84, 0.17),
				Parent = cell,
			})
			Kit.corner(strip, 0.5)
			Kit.number(strip, `🐚 {Kit.big(entry.income)}/s`, {
				Size = UDim2.fromScale(1, 1),
				TextColor3 = Theme.White,
				Font = Enum.Font.GothamBlack,
			}, 13)
			local icons = (if entry.instance.locked then "🔒" else "") .. (if entry.placed then "📍" else "")
			if icons ~= "" then
				Kit.label(cell, icons, {
					Position = UDim2.fromScale(0.5, 0.02),
					Size = UDim2.fromScale(0.46, 0.2),
					TextXAlignment = Enum.TextXAlignment.Right,
				}, 18)
			end
			if selecting and not sellable then
				cell.BackgroundColor3 = Theme.Disabled
			end
			gridMaid:add(cell.Activated:Connect(function()
				if selecting then
					if sellable then
						selection[entry.uuid] = if selection[entry.uuid] then nil else true
						renderGrid()
					end
				else
					selected = entry.uuid
					renderGrid()
					renderDetail()
				end
			end))
		end
		if #list == 0 then
			local empty = Kit.label(
				grid,
				"Aucun dino ici. Lance les dés !",
				{ TextColor3 = Theme.TextMuted, LayoutOrder = 1 },
				20
			)
			gridMaid:add(empty)
		end
	end

	win.maid:add(filterButton.Activated:Connect(function()
		filter = (filter + 1) % (#RARITY_ORDER + 1)
		renderGrid()
	end))
	win.maid:add(sortButton.Activated:Connect(function()
		sortIndex = sortIndex % #SORTS + 1
		renderGrid()
	end))
	win.maid:add(selectButton.Activated:Connect(function()
		selecting = not selecting
		table.clear(selection)
		renderGrid()
	end))
	win.maid:add(allButton.Activated:Connect(function()
		for _, entry in entries() do
			local dino = Kit.dinoById[entry.instance.dinoId]
			-- comme SellAllUnplaced : un exclusif payé en Robux ne part jamais en lot
			if not entry.instance.locked and entry.placed == nil and not (dino and dino.exclusive) then
				selection[entry.uuid] = true
			end
		end
		renderGrid()
	end))
	win.maid:add(bestButton.Activated:Connect(function()
		Remotes.EquipBest:FireServer()
	end))
	win.maid:add(autoButton.Activated:Connect(function()
		if not SettingsController:AutoEquipUnlocked() then
			NotificationController:Toast("Débloque l'Équipement auto dans l'arbre d'améliorations.", "error")
			return
		end
		local on = not SettingsController:Get("AutoEquip")
		SettingsController:Set("AutoEquip", on)
		if on then
			Remotes.EquipBest:FireServer() -- applique tout de suite, puis le serveur suit chaque tirage
		end
		renderGrid()
	end))
	win.maid:add(sellButton.Activated:Connect(function()
		local list: { string } = {}
		local value = 0
		for uuid in selection do
			local instance = data.Dinos[uuid]
			if instance then
				table.insert(list, uuid)
				value += Bonuses.sellPrice(data, instance.dinoId)
			end
		end
		if #list == 0 then
			return
		end
		UIController:Dialog("Vendre ?", `Vendre {#list} dino(s) pour environ {Kit.big(value)} Fossiles ?`, {
			{ text = "Annuler", color = Theme.Stone },
			{
				text = "Vendre",
				color = Theme.Lava,
				onClick = function()
					Remotes.SellDinos:FireServer(list)
					table.clear(selection)
					selecting = false
					renderGrid()
				end,
			},
		})
	end))

	-- Redessin groupé : plusieurs changements dans la même image = un seul rendu.
	local queued = false
	local function queue()
		if queued then
			return
		end
		queued = true
		task.defer(function()
			queued = false
			if not win.closed then
				renderGrid()
				renderDetail()
			end
		end)
	end
	for _, key in { "Dinos", "PlotSlots", "Upgrades" } do
		win.maid:add(DataController:OnChanged(key, queue))
	end
	renderGrid()
	animateIn = false
	renderDetail()
end

return Screen
