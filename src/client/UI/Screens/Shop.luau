--!strict
-- Boutique : onglets Dés (BuyDice / EquipDice, prochain dé abordable en surbrillance), Robux (PromptPurchase,
-- grisé si le joueur est restreint : attribut PaidRandomRestricted) et Codes (RedeemCode).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Dice = require(Shared.Config.Dice)
local Gamepasses = require(Shared.Config.Gamepasses)
local Products = require(Shared.Config.Products)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local NotificationController = require(Controllers.NotificationController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

-- Style « simulateur » : cadre rose-violet fluo (référence « The Hive »), cartes colorées, gros boutons verts.
local Screen = { title = "🛒 BOUTIQUE", style = "cartoon", accent = Color3.fromHex("#E040FB") }

-- Carte « cartoon » : fond coloré en dégradé, contour sombre épais.
local function card(parent: Instance, props: { [string]: any }, color: Color3): (Frame, Frame)
	local holder, body = Kit.panel(parent, props, color, 0.12)
	local stroke = body:FindFirstChildOfClass("UIStroke") :: UIStroke
	stroke.Color = Theme.Outline
	stroke.Thickness = 3
	(body:FindFirstChildOfClass("UIGradient") :: UIGradient).Color =
		ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(150, 150, 175))
	return holder, body
end

-- Texte blanc à contour sombre, lisible sur n'importe quelle couleur de carte.
local LIGHT_TEXT = { TextColor3 = Theme.White, TextStrokeColor3 = Theme.Outline, TextStrokeTransparency = 0 }
local function light(props: { [string]: any }): { [string]: any }
	for key, value in LIGHT_TEXT do
		props[key] = value
	end
	return props
end

-- Dés --------------------------------------------------------------------------------------------------------

local function buildDice(page: Frame, maid: Kit.Maid)
	local data: Types.ProfileData = DataController:Get()
	local grid = Kit.scroll(page, { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
	Kit.grid(grid, 5, 0.78)

	local cells: { () -> () } = {}
	local highlightStroke: UIStroke? = nil

	-- Le meilleur dé abordable pas encore possédé, sinon le prochain dans l'ordre.
	local function nextDie(): string?
		local best, first = nil, nil
		for _, die in Dice do
			if not data.OwnedDice[die.id] and not die.treeOnly then
				first = first or die.id
				if die.price <= data.Fossils then
					best = die.id
				end
			end
		end
		return best or first
	end

	for i, die in Dice do
		local holder, body = card(grid, { LayoutOrder = i }, die.color)
		Kit.stagger(holder, i)
		local stroke = body:FindFirstChildOfClass("UIStroke") :: UIStroke
		local iconHolder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.3, 0.05),
			Size = UDim2.fromScale(0.4, 0.3),
			Parent = body,
		})
		Kit.dieIcon(iconHolder, die.color)
		Kit.title(
			body,
			die.displayName,
			light({ Position = UDim2.fromScale(0.04, 0.36), Size = UDim2.fromScale(0.92, 0.16) }),
			18
		)
		local luckPill = Kit.new("Frame", {
			BackgroundColor3 = Theme.Outline,
			BackgroundTransparency = 0.3,
			Position = UDim2.fromScale(0.12, 0.52),
			Size = UDim2.fromScale(0.76, 0.12),
			Parent = body,
		})
		Kit.corner(luckPill, 0.5)
		Kit.number(luckPill, `🍀 {Kit.mult(die.luck)}`, {
			Size = UDim2.fromScale(1, 1),
			TextColor3 = Color3.fromHex("#FFE45C"),
			Font = Enum.Font.GothamBlack,
		}, 16)
		local buttonHolder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.06, 0.66),
			Size = UDim2.fromScale(0.88, 0.3),
			Parent = body,
		})
		local button = Kit.button(buttonHolder, "", { maid = maid, maxText = 16 })
		maid:add(button.Activated:Connect(function()
			if data.EquippedDice == die.id then
				return
			elseif data.OwnedDice[die.id] then
				Remotes.EquipDice:FireServer(die.id)
			elseif die.treeOnly then
				NotificationController:Toast(`Le {die.displayName} se débloque dans l'arbre d'améliorations.`, "info")
			elseif data.Fossils >= die.price then
				Remotes.BuyDice:FireServer(die.id)
			else
				NotificationController:Toast(`Il te manque {Kit.big(die.price - data.Fossils)} Fossiles.`, "error")
			end
		end))
		table.insert(cells, function()
			local owned = data.OwnedDice[die.id] == true
			if data.EquippedDice == die.id then
				button.Text = "Équipé"
				Kit.paint(button, Theme.LeafDark)
			elseif owned then
				button.Text = "Équiper"
				Kit.paint(button, Theme.Sky)
			elseif die.treeOnly then
				button.Text = "🌳 Arbre"
				Kit.paint(button, Theme.Neutral)
			else
				button.Text = `Acheter {Kit.big(die.price)}`
				Kit.paint(button, if data.Fossils >= die.price then Theme.Leaf else Theme.Disabled)
			end
			local isNext = nextDie() == die.id
			stroke.Color = if isNext then Theme.Gold else Theme.Outline
			stroke.Thickness = if isNext then 5 else 3
			if isNext then
				highlightStroke = stroke
			end
		end)
	end

	local pulsing: UIStroke? = nil
	local pulse: Tween? = nil
	local function refresh()
		highlightStroke = nil
		for _, fn in cells do
			fn()
		end
		-- Pulsation (tween en boucle) du prochain dé à viser.
		if highlightStroke ~= pulsing then
			if pulse then
				pulse:Destroy()
			end
			if pulsing then
				pulsing.Transparency = 0
			end
			pulsing = highlightStroke
			pulse = if pulsing then Kit.loop(pulsing, 0.6, { Transparency = 0.7 }, true, Enum.EasingStyle.Sine) else nil
		end
	end
	for _, key in { "Fossils", "OwnedDice", "EquippedDice" } do
		maid:add(DataController:OnChanged(key, refresh))
	end
	refresh()
	maid:add(function()
		if pulse then
			pulse:Destroy()
		end
	end)
end

-- Robux ------------------------------------------------------------------------------------------------------

local function isLuckPass(pass: Gamepasses.Gamepass): boolean
	return pass.luckMultiplier > 1 or pass.luckBonus > 0 or pass.extraGradeRerolls > 0 or pass.extraInstinctRerolls > 0
end

local function isPaidRandom(product: Products.Product): boolean
	if product.kind ~= "potion" then
		return true -- Ambre et Os servent aux relances aléatoires
	end
	local potion = Kit.find(Products.potions, product.potionId)
	return potion ~= nil and potion.stat == "luck"
end

local function passEffect(pass: Gamepasses.Gamepass): string
	local parts = {}
	if pass.luckMultiplier > 1 then
		table.insert(parts, `Chance {Kit.mult(pass.luckMultiplier)}`)
	end
	if pass.coinsMultiplier > 1 then
		table.insert(parts, `Fossiles {Kit.mult(pass.coinsMultiplier)}`)
	end
	if pass.luckBonus > 0 then
		table.insert(parts, `Chance +{math.floor(pass.luckBonus * 100)} %`)
	end
	if pass.rollSpeedMultiplier > 1 then
		table.insert(parts, `Lancer {Kit.mult(pass.rollSpeedMultiplier)} plus vite`)
	end
	if pass.extraRolls > 0 then
		table.insert(parts, `+{pass.extraRolls} lancer par clic`)
	end
	if pass.extraGradeRerolls > 0 then
		table.insert(parts, `+{pass.extraGradeRerolls} relances de Grade par clic`)
	end
	if pass.extraInstinctRerolls > 0 then
		table.insert(parts, `+{pass.extraInstinctRerolls} relances d'Instinct par clic`)
	end
	if pass.chatTag then
		table.insert(parts, "tag de chat")
	end
	return table.concat(parts, " · ")
end

local function buildRobux(page: Frame, maid: Kit.Maid)
	local restricted = Players.LocalPlayer:GetAttribute("PaidRandomRestricted") ~= false
	local list = Kit.scroll(page, { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
	Kit.list(list, false, 0)
	local layout = list:FindFirstChildOfClass("UIListLayout") :: UIListLayout
	layout.Padding = UDim.new(0, 8)
	Kit.new(
		"UIPadding",
		{ PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 4), Parent = list }
	)

	local order = 0
	local function header(text: string)
		order += 1
		local label = Kit.title(
			list,
			text,
			light({ LayoutOrder = order, Size = UDim2.new(1, 0, 0, 34), TextXAlignment = Enum.TextXAlignment.Left }),
			26
		)
		label.AutomaticSize = Enum.AutomaticSize.None
	end
	-- Une section = une grille de cartes jaunes (3 par ligne) dont la hauteur suit son contenu.
	local function section(): Frame
		order += 1
		local grid = Kit.new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = order,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = list,
		})
		Kit.new("UIGridLayout", {
			CellSize = UDim2.new(0.323, 0, 0, 150),
			CellPadding = UDim2.new(0.015, 0, 0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = grid,
		})
		return grid
	end
	local function item(grid: Frame, i: number, name: string, effect: string, blocked: boolean, onBuy: () -> ())
		local _, body = card(grid, { LayoutOrder = i }, if blocked then Theme.Disabled else Color3.fromHex("#FFC93C"))
		Kit.stagger(body, i)
		Kit.title(body, name, light({ Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.9, 0.24) }), 24)
		Kit.label(body, effect, {
			Position = UDim2.fromScale(0.05, 0.3),
			Size = UDim2.fromScale(0.9, 0.34),
			TextColor3 = Color3.fromHex("#5A3A00"),
			Font = Theme.TitleFont,
		}, 22)
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.18, 0.66),
			Size = UDim2.fromScale(0.64, 0.28),
			Parent = body,
		})
		local button = Kit.button(holder, if blocked then "Indisponible" else "Acheter", {
			color = if blocked then Theme.Disabled else Theme.Leaf,
			maid = maid,
			maxText = 20,
		})
		if not blocked then
			maid:add(button.Activated:Connect(onBuy))
		end
	end

	header("⭐ Passes (permanents)")
	local passes = section()
	for i, pass in Gamepasses do
		item(passes, i, pass.displayName, passEffect(pass), restricted and isLuckPass(pass), function()
			Remotes.PromptPurchase:FireServer("pass", pass.id)
		end)
	end
	header("🎁 Objets")
	local objects = section()
	for i, product in Products.products do
		local effect = if product.kind == "amber"
			then `{product.amount} Ambre`
			elseif product.kind == "bones" then `{product.amount} Os`
			else (function()
				local potion = Kit.find(Products.potions, product.potionId)
				return if potion
					then `{product.amount} x {potion.displayName} ({Kit.mult(potion.multiplier)}, {math.floor(
						potion.durationSeconds / 60
					)} min)`
					else ""
			end)()
		item(objects, i, product.displayName, effect, restricted and isPaidRandom(product), function()
			Remotes.PromptPurchase:FireServer("product", product.id)
		end)
	end
	if restricted then
		order += 1
		Kit.label(list, "Certains objets ne sont pas disponibles dans ton pays.", {
			LayoutOrder = order,
			Size = UDim2.new(1, 0, 0, 26),
			TextColor3 = Theme.TextMuted,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, 16)
	end
end

-- Codes ------------------------------------------------------------------------------------------------------

local function buildCodes(page: Frame, maid: Kit.Maid)
	Kit.title(
		page,
		"Entre un code promo :",
		light({ Position = UDim2.fromScale(0.1, 0.08), Size = UDim2.fromScale(0.8, 0.16) }),
		28
	)
	local box = Kit.new("TextBox", {
		BackgroundColor3 = Theme.White,
		Position = UDim2.fromScale(0.1, 0.3),
		Size = UDim2.fromScale(0.55, 0.2),
		Font = Theme.TitleFont,
		PlaceholderText = "CODE",
		Text = "",
		TextScaled = true,
		TextColor3 = Theme.Ink,
		ClearTextOnFocus = false,
		Parent = page,
	})
	Kit.corner(box, 0.2)
	Kit.stroke(box, Theme.Outline, 3)
	Kit.touch(box)
	Kit.new("UITextSizeConstraint", { MaxTextSize = 28, Parent = box })
	local result = Kit.label(page, "", {
		Position = UDim2.fromScale(0.1, 0.56),
		Size = UDim2.fromScale(0.8, 0.14),
		TextColor3 = Theme.TextMuted,
	}, 20)
	local holder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.68, 0.3),
		Size = UDim2.fromScale(0.22, 0.2),
		Parent = page,
	})
	local busy = false
	Kit.button(holder, "Valider", {
		color = Theme.Leaf,
		maid = maid,
		onClick = function()
			local code = box.Text:gsub("%s", "")
			if busy or code == "" then
				return
			end
			busy = true
			result.Text = "…"
			local ok, response = pcall(function()
				return Remotes.RedeemCode:InvokeServer(code)
			end)
			busy = false
			if ok and type(response) == "table" then
				result.Text = tostring(response.message)
				result.TextColor3 = if response.ok then Theme.Leaf else Theme.Lava
				if response.ok then
					box.Text = ""
				end
			else
				result.Text = "Réessaie dans un instant."
				result.TextColor3 = Theme.Lava
			end
		end,
	})
end

-- Potions ----------------------------------------------------------------------------------------------------

-- Réserve (profil « Potions »), potions actives et temps restant (« ActivePotions »), « Boire » (UsePotion).
local function buildPotions(page: Frame, maid: Kit.Maid)
	local data: Types.ProfileData = DataController:Get()
	local list = Kit.scroll(page, { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), Parent = list })
	local rows: { () -> () } = {}
	for i, potion in Products.potions do
		local row = Kit.row(list, {
			{ text = `🧪 {potion.displayName}`, width = 0.36, font = Theme.TitleFont, color = Theme.White },
			{
				text = `{Kit.mult(potion.multiplier)} · {math.floor(potion.durationSeconds / 60)} min`,
				width = 0.2,
				color = Theme.TextMuted,
			},
		}, i, 50, if i % 2 == 0 then Theme.Navy else Theme.NavyLight)
		Kit.stagger(row, i)
		local info = Kit.number(row, "", {
			Position = UDim2.fromScale(0.57, 0.1),
			Size = UDim2.fromScale(0.22, 0.8),
			TextXAlignment = Enum.TextXAlignment.Left,
			Font = Enum.Font.GothamBold,
		}, 16)
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.8, 0.04),
			Size = UDim2.fromScale(0.19, 0.92),
			Parent = row,
		})
		local button = Kit.button(holder, "Boire", { color = Theme.Leaf, maid = maid, maxText = 18 })
		maid:add(button.Activated:Connect(function()
			if (data.Potions[potion.id] or 0) > 0 then
				Remotes.UsePotion:FireServer(potion.id)
			end
		end))
		table.insert(rows, function()
			local count = data.Potions[potion.id] or 0
			local left = (data.ActivePotions[potion.id] or 0) - os.time()
			info.Text = `Réserve : {count}`
				.. (if left > 0 then string.format("\nActive : %d:%02d", left // 60, left % 60) else "")
			info.TextColor3 = if left > 0 then Theme.Leaf else Theme.White
			Kit.paint(button, if count > 0 then Theme.Leaf else Theme.Disabled)
		end)
	end
	local function refresh()
		for _, fn in rows do
			fn()
		end
	end
	maid:add(DataController:OnChanged("Potions", refresh))
	maid:add(DataController:OnChanged("ActivePotions", refresh))
	-- Temps restant : une mise à jour par seconde.
	maid:add(task.spawn(function()
		while true do
			refresh()
			task.wait(1)
		end
	end))
end

-- Onglets ----------------------------------------------------------------------------------------------------

local TABS = {
	{ "🎲 Dés", buildDice, Color3.fromHex("#E040FB") },
	{ "💎 Robux", buildRobux, Color3.fromHex("#FFB21F") },
	{ "🎟️ Codes", buildCodes, Color3.fromHex("#2ED84A") },
	{ "🧪 Potions", buildPotions, Color3.fromHex("#22C3E6") },
}

function Screen.build(win: Window.Window, tab: number?)
	local bar = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.15), Parent = win.content })
	Kit.list(bar, true, 0.015, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
	local page = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 0.17),
		Size = UDim2.fromScale(1, 0.83),
		Parent = win.content,
	})
	local pageMaid = Kit.maid()
	win.maid:add(pageMaid)
	local buttons: { TextButton } = {}

	local function show(index: number)
		pageMaid:clean()
		for i, b in buttons do
			Kit.paint(b, if i == index then TABS[i][3] else Theme.NavyLight)
		end
		local frame = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = page })
		pageMaid:add(frame)
		TABS[index][2](frame, pageMaid)
	end

	for i, tabInfo in TABS do
		local holder = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = i, Size = UDim2.fromScale(0.2, 1), Parent = bar }
		)
		buttons[i] = Kit.button(holder, tabInfo[1], {
			color = Theme.NavyLight,
			maid = win.maid,
			maxText = 20,
			onClick = function()
				show(i)
			end,
		})
	end
	show(math.clamp(tonumber(tab) or 1, 1, #TABS))
end

return Screen
