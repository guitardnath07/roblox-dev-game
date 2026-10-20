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

local Screen = { title = "🛒 Boutique" }

-- Dés --------------------------------------------------------------------------------------------------------

local function buildDice(page: Frame, maid: Kit.Maid)
	local data: Types.ProfileData = DataController:Get()
	local grid = Kit.scroll(page, { Size = UDim2.fromScale(1, 1) })
	Kit.grid(grid, 5, 0.78)

	local cells: { () -> () } = {}
	local highlightStroke: UIStroke? = nil

	-- Le meilleur dé abordable pas encore possédé, sinon le prochain dans l'ordre.
	local function nextDie(): string?
		local best, first = nil, nil
		for _, die in Dice do
			if not data.OwnedDice[die.id] then
				first = first or die.id
				if die.price <= data.Coins then
					best = die.id
				end
			end
		end
		return best or first
	end

	for i, die in Dice do
		local holder, body = Kit.panel(grid, { LayoutOrder = i }, Theme.Parchment, 0.1)
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
			{ Position = UDim2.fromScale(0.04, 0.36), Size = UDim2.fromScale(0.92, 0.16) },
			18
		)
		Kit.number(body, `Chance {Kit.mult(die.luck)}`, {
			Position = UDim2.fromScale(0.04, 0.52),
			Size = UDim2.fromScale(0.92, 0.12),
			TextColor3 = Theme.LeafDark,
			Font = Enum.Font.GothamBold,
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
			elseif data.Coins >= die.price then
				Remotes.BuyDice:FireServer(die.id)
			else
				NotificationController:Toast(`Il te manque {Kit.big(die.price - data.Coins)} Pièces.`, "error")
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
			else
				button.Text = `Acheter {Kit.big(die.price)}`
				Kit.paint(button, if data.Coins >= die.price then Theme.Amber else Theme.Disabled)
			end
			local isNext = nextDie() == die.id
			stroke.Color = if isNext then Theme.Gold else Theme.Stone
			stroke.Thickness = if isNext then 4 else 3
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
	for _, key in { "Coins", "OwnedDice", "EquippedDice" } do
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
		return true -- Ambre et Fossiles servent aux relances aléatoires
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
		table.insert(parts, `Pièces {Kit.mult(pass.coinsMultiplier)}`)
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
	local list = Kit.scroll(page, { Size = UDim2.fromScale(1, 1) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), Parent = list })

	local order = 0
	local function line(name: string, effect: string, blocked: boolean, onBuy: () -> ())
		order += 1
		local row = Kit.row(list, {
			{ text = name, width = 0.3, font = Theme.TitleFont },
			{ text = effect, width = 0.48, color = Theme.InkSoft },
		}, order, 46, if order % 2 == 0 then Theme.ParchmentDark else nil)
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.79, 0.04),
			Size = UDim2.fromScale(0.2, 0.92),
			Parent = row,
		})
		local button = Kit.button(holder, if blocked then "Indisponible" else "Acheter", {
			color = if blocked then Theme.Disabled else Theme.Leaf,
			maid = maid,
			maxText = 16,
		})
		if not blocked then
			maid:add(button.Activated:Connect(onBuy))
		end
	end

	Kit.row(list, { { text = "Passes (permanents)", width = 1, font = Theme.TitleFont } }, 0, 32, Theme.ParchmentDeep)
	for _, pass in Gamepasses do
		line(pass.displayName, passEffect(pass), restricted and isLuckPass(pass), function()
			Remotes.PromptPurchase:FireServer("pass", pass.id)
		end)
	end
	order += 1
	Kit.row(list, { { text = "Objets", width = 1, font = Theme.TitleFont } }, order, 32, Theme.ParchmentDeep)
	for _, product in Products.products do
		local effect = if product.kind == "amber"
			then `{product.amount} Ambre`
			elseif product.kind == "fossils" then `{product.amount} Fossiles`
			else (function()
				local potion = Kit.find(Products.potions, product.potionId)
				return if potion
					then `{product.amount} x {potion.displayName} ({Kit.mult(potion.multiplier)}, {math.floor(
						potion.durationSeconds / 60
					)} min)`
					else ""
			end)()
		line(product.displayName, effect, restricted and isPaidRandom(product), function()
			Remotes.PromptPurchase:FireServer("product", product.id)
		end)
	end
	if restricted then
		order += 1
		Kit.row(list, {
			{ text = "Certains objets ne sont pas disponibles dans ton pays.", width = 1, color = Theme.InkSoft },
		}, order, 30)
	end
end

-- Codes ------------------------------------------------------------------------------------------------------

local function buildCodes(page: Frame, maid: Kit.Maid)
	Kit.title(
		page,
		"Entre un code promo :",
		{ Position = UDim2.fromScale(0.1, 0.08), Size = UDim2.fromScale(0.8, 0.16) },
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
	Kit.stroke(box, Theme.Stone, 2)
	Kit.touch(box)
	Kit.new("UITextSizeConstraint", { MaxTextSize = 28, Parent = box })
	local result = Kit.label(page, "", {
		Position = UDim2.fromScale(0.1, 0.56),
		Size = UDim2.fromScale(0.8, 0.14),
		TextColor3 = Theme.InkSoft,
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
				result.TextColor3 = if response.ok then Theme.LeafDark else Theme.Lava
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
	local list = Kit.scroll(page, { Size = UDim2.fromScale(1, 1) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), Parent = list })
	local rows: { () -> () } = {}
	for i, potion in Products.potions do
		local row = Kit.row(list, {
			{ text = `🧪 {potion.displayName}`, width = 0.36, font = Theme.TitleFont },
			{
				text = `{Kit.mult(potion.multiplier)} · {math.floor(potion.durationSeconds / 60)} min`,
				width = 0.2,
				color = Theme.InkSoft,
			},
		}, i, 50, if i % 2 == 0 then Theme.ParchmentDark else nil)
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
			info.TextColor3 = if left > 0 then Theme.LeafDark else Theme.Ink
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
	{ "🎲 Dés", buildDice },
	{ "💎 Robux", buildRobux },
	{ "🎟️ Codes", buildCodes },
	{ "🧪 Potions", buildPotions },
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
			Kit.paint(b, if i == index then Theme.Amber else Theme.Stone)
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
			color = Theme.Stone,
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
