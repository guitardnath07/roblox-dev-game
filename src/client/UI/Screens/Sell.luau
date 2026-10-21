--!strict
-- Comptoir de vente (prompt du décor Workspace.Hub.Stations.SellCounter) : 3 onglets Dinos / Reliques / Potions.
-- On coche des lignes puis « Vendre la sélection », ou « Vendre tout ». Dinos et reliques -> Fossiles,
-- potions -> Tickets d'Expédition. Les dinos posés, verrouillés ou exclusifs et les reliques équipées
-- ne sont pas listés (le serveur les refuse de toute façon).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Products = require(Shared.Config.Products)
local Relics = require(Shared.Config.Relics)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local UIController = require(Controllers.UIController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "🏷️ Comptoir de vente" }

local MAX_BATCH = 200 -- miroir de MAX_SELL_BATCH (InventoryService)

type Tab = "dinos" | "relics" | "potions"
local TABS: { { id: Tab, text: string } } = {
	{ id = "dinos", text = "🦖 Dinos" },
	{ id = "relics", text = "💍 Artefacts" },
	{ id = "potions", text = "🧪 Potions" },
}

-- Une ligne vendable : `key` = uuid (dino, relique) ou id de potion ; `count` > 1 seulement pour les potions.
type Item = { key: string, name: string, detail: string, color: Color3, price: number, count: number }

local function items(data: Types.ProfileData, tab: Tab): { Item }
	local list: { Item } = {}
	if tab == "dinos" then
		local placed: Types.Set = {}
		for _, uuid in data.PlotSlots do
			placed[uuid] = true
		end
		for uuid, instance in data.Dinos do
			local dino = Kit.dinoById[instance.dinoId]
			if dino and not dino.exclusive and not instance.locked and not placed[uuid] then
				local rarity = Kit.rarityOf(instance.dinoId)
				table.insert(list, {
					key = uuid,
					name = dino.displayName,
					detail = rarity.displayName,
					color = rarity.color,
					price = Bonuses.sellPrice(data, instance.dinoId),
					count = 1,
				})
			end
		end
	elseif tab == "relics" then
		local equipped: Types.Set = {}
		for _, uuid in data.EquippedRelics do
			equipped[uuid] = true
		end
		for uuid, owned in data.Relics do
			local relic: Relics.Relic? = Kit.find(Relics.list, owned.relicId)
			if relic and not equipped[uuid] then
				table.insert(list, {
					key = uuid,
					name = relic.displayName,
					detail = `Palier {relic.tier}`,
					color = Theme.Ink,
					price = Bonuses.relicSellPrice(relic.id),
					count = 1,
				})
			end
		end
	else
		for _, potion in Products.potions do
			local count = data.Potions[potion.id] or 0
			if count > 0 then
				table.insert(list, {
					key = potion.id,
					name = potion.displayName,
					detail = `x{count} en réserve`,
					color = Theme.Ink,
					price = potion.sellTickets,
					count = count,
				})
			end
		end
	end
	table.sort(list, function(a, b)
		if a.price ~= b.price then
			return a.price > b.price
		end
		return a.key < b.key
	end)
	return list
end

-- Envoie la vente au serveur (le serveur revérifie chaque ligne). `all` : tout l'onglet.
local function sell(tab: Tab, picked: { Item }, all: boolean)
	if tab == "dinos" and all then
		Remotes.SellAllUnplaced:FireServer(math.huge) -- toutes raretés, mêmes exclusions que cette liste
	elseif tab == "dinos" or tab == "relics" then
		local uuids: { string } = {}
		for i = 1, math.min(#picked, MAX_BATCH) do
			table.insert(uuids, picked[i].key)
		end
		if tab == "dinos" then
			Remotes.SellDinos:FireServer(uuids)
		else
			Remotes.SellRelics:FireServer(uuids)
		end
	else
		local counts: { [string]: number } = {}
		for _, item in picked do
			counts[item.key] = item.count
		end
		Remotes.SellPotions:FireServer(counts)
	end
end

function Screen.build(win: Window.Window, startTab: Tab?)
	local data: Types.ProfileData = DataController:Get()
	local tab: Tab = startTab or "dinos"
	local selection: { [string]: boolean } = {}

	local tabRow =
		Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.11), Parent = win.content })
	Kit.list(tabRow, true, 0.015, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
	local tabButtons: { [Tab]: TextButton } = {}
	for i, t in TABS do
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Size = UDim2.fromScale(0.31, 0.9),
			Parent = tabRow,
		})
		tabButtons[t.id] = Kit.button(holder, t.text, { maid = win.maid, maxText = 22 })
	end

	local list = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.13), Size = UDim2.fromScale(1, 0.73) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), Parent = list })

	local bar = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 0.88),
		Size = UDim2.fromScale(1, 0.12),
		Parent = win.content,
	})
	Kit.list(bar, true, 0.02, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
	local function barButton(order: number, color: Color3): TextButton
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = order,
			Size = UDim2.fromScale(0.44, 0.9),
			Parent = bar,
		})
		return Kit.button(holder, "", { color = color, maid = win.maid, maxText = 22 })
	end
	local sellPicked = barButton(1, Theme.Lava)
	local sellAll = barButton(2, Theme.Amber)

	local maid = Kit.maid()
	win.maid:add(maid)
	local current: { Item } = {}

	local function unit(): string
		return if tab == "potions" then "🎟️" else "🐚"
	end

	local function render()
		maid:clean()
		for id, button in tabButtons do
			Kit.paint(button, if id == tab then Theme.Cyan else Theme.Stone)
		end
		current = items(data, tab)
		local pickedCount, pickedValue, totalValue = 0, 0, 0
		for i, item in current do
			local value = item.price * item.count
			totalValue += value
			local picked = selection[item.key] == true
			if picked then
				pickedCount += 1
				pickedValue += value
			end
			local row = Kit.row(list, {
				{ text = if picked then "☑" else "☐", width = 0.08, align = Enum.TextXAlignment.Center },
				{ text = item.name, width = 0.36, font = Theme.TitleFont, color = item.color },
				{ text = item.detail, width = 0.26, color = Theme.InkSoft },
				{
					text = if item.count > 1
						then `{Kit.big(item.price)} {unit()} x{item.count}`
						else `{Kit.big(item.price)} {unit()}`,
					width = 0.3,
					align = Enum.TextXAlignment.Right,
				},
			}, i, 46, if picked then Theme.Gold elseif i % 2 == 0 then Theme.ParchmentDark else nil)
			maid:add(row)
			-- Toute la ligne est cliquable (≥ 44 px de haut) pour cocher / décocher.
			local hit = Kit.new("TextButton", {
				BackgroundTransparency = 1,
				Text = "",
				Size = UDim2.fromScale(1, 1),
				Parent = row,
			})
			maid:add(hit.Activated:Connect(function()
				selection[item.key] = if picked then nil else true
				render()
			end))
		end
		if #current == 0 then
			maid:add(
				Kit.label(
					list,
					if tab == "dinos"
						then "Aucun dino à vendre (les dinos posés ou verrouillés 🔒 sont gardés)."
						elseif tab == "relics" then "Aucun artefact à vendre (les reliques équipées sont gardées)."
						else "Aucune potion en réserve.",
					{ Size = UDim2.new(1, 0, 0, 60), TextColor3 = Theme.InkSoft },
					20
				)
			)
		end
		sellPicked.Text = `Vendre la sélection ({pickedCount}) · {Kit.big(pickedValue)} {unit()}`
		Kit.paint(sellPicked, if pickedCount > 0 then Theme.Lava else Theme.Disabled)
		sellAll.Text = `Vendre tout · {Kit.big(totalValue)} {unit()}`
		Kit.paint(sellAll, if #current > 0 then Theme.Amber else Theme.Disabled)
	end

	local function confirm(picked: { Item }, all: boolean)
		if #picked == 0 then
			return
		end
		local value, count = 0, 0
		for _, item in picked do
			value += item.price * item.count
			count += item.count
		end
		local sold = tab
		UIController:Dialog("Vendre ?", `Vendre {count} objet(s) pour {Kit.big(value)} {unit()} ?`, {
			{ text = "Annuler", color = Theme.Stone },
			{
				text = "Vendre",
				color = Theme.Lava,
				onClick = function()
					sell(sold, picked, all)
					table.clear(selection)
				end,
			},
		})
	end

	for id, button in tabButtons do
		win.maid:add(button.Activated:Connect(function()
			tab = id
			table.clear(selection)
			render()
		end))
	end
	win.maid:add(sellPicked.Activated:Connect(function()
		local picked: { Item } = {}
		for _, item in current do
			if selection[item.key] then
				table.insert(picked, item)
			end
		end
		confirm(picked, false)
	end))
	win.maid:add(sellAll.Activated:Connect(function()
		confirm(table.clone(current), true)
	end))

	-- Redessin groupé : une vente change plusieurs clés dans la même image.
	local queued = false
	local function queue()
		if queued then
			return
		end
		queued = true
		task.defer(function()
			queued = false
			if not win.closed then
				render()
			end
		end)
	end
	for _, key in { "Dinos", "PlotSlots", "Relics", "EquippedRelics", "Potions", "Upgrades" } do
		win.maid:add(DataController:OnChanged(key, queue))
	end
	render()
end

return Screen
