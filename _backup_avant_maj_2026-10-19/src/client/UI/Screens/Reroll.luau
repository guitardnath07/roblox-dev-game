--!strict
-- Écrans de relance, un par type : Instinct (Fossiles, RerollInstinct), Grade (Ambre, RerollGrade),
-- Empreinte (Pièces, RerollImprint). On choisit un dino, on voit son état, la chance de CHAQUE résultat
-- (obligation Roblox), puis « Relancer » ou « Auto » jusqu'à un seuil (stopAtId). Le serveur tire ;
-- le client ne fait que faire défiler les résultats renvoyés (petite roulette).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Economy = require(Shared.Config.Economy)
local Grades = require(Shared.Config.Grades)
local Helpers = require(Shared.Config.Helpers)
local Imprints = require(Shared.Config.Imprints)
local Instincts = require(Shared.Config.Instincts)
local Rebirth = require(Shared.Config.Rebirth)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local NotificationController = require(Controllers.NotificationController)
local UIController = require(Controllers.UIController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "Relance" }

type Kind = {
	title: string,
	list: { any },
	field: "instinct" | "grade" | "imprint",
	currency: "Fossils" | "Amber" | "Coins",
	currencyName: string,
	remote: RemoteFunction,
	auto: boolean,
	effect: (any) -> string,
	cost: (Types.ProfileData) -> number,
}

local function mult(label: string, value: number): string?
	return if value ~= 1 then `{label} {Kit.mult(value)}` else nil
end

local function bonus(label: string, value: number): string?
	return if value > 0 then `{label} +{math.floor(value * 100 + 0.5)} %` else nil
end

local function join(parts: { string? }): string
	local out = {}
	for _, p in parts do
		if p then
			table.insert(out, p)
		end
	end
	return if #out > 0 then table.concat(out, " · ") else "aucun effet"
end

local KINDS: { [string]: Kind } = {
	instinct = {
		title = "🦴 Relance d'Instinct",
		list = Instincts,
		field = "instinct",
		currency = "Fossils",
		currencyName = "Fossiles",
		remote = Remotes.RerollInstinct,
		auto = true,
		effect = function(e)
			if e.coinsMultiplier == e.healthMultiplier and e.coinsMultiplier == e.damageMultiplier then
				return if e.coinsMultiplier == 1 then "aucun effet" else `{Kit.mult(e.coinsMultiplier)} tout`
			end
			return join({
				mult("Pièces", e.coinsMultiplier),
				mult("PV", e.healthMultiplier),
				mult("Dégâts", e.damageMultiplier),
			})
		end,
		cost = function()
			return Economy.instinctRerollCostFossils
		end,
	},
	grade = {
		title = "🔶 Relance de Grade",
		list = Grades,
		field = "grade",
		currency = "Amber",
		currencyName = "Ambre",
		remote = Remotes.RerollGrade,
		auto = true,
		effect = function(e)
			return `Pièces {Kit.mult(e.coinsMultiplier)}`
		end,
		cost = function()
			return Economy.gradeRerollCostAmber
		end,
	},
	imprint = {
		title = "💰 Relance d'Empreinte",
		list = Imprints.list,
		field = "imprint",
		currency = "Coins",
		currencyName = "Pièces",
		remote = Remotes.RerollImprint,
		auto = false,
		effect = function(e)
			return join({
				bonus("Chance", e.luckBonus),
				bonus("Pièces", e.coinsBonus),
				bonus("Vitesse", e.rollSpeedBonus),
			})
		end,
		cost = function(data)
			return math.floor(Rebirth.cost(data.Rebirths + 1) * Economy.imprintRerollCostRatio)
		end,
	},
}

-- Rang d'un résultat (ordre de la table de config : plus loin = meilleur).
local function rank(kind: Kind, id: string?): number
	for i, e in kind.list do
		if e.id == id then
			return i
		end
	end
	return 0
end

function Screen.build(win: Window.Window, kindId: string?, uuid: string?)
	local data: Types.ProfileData = DataController:Get()
	local kind = KINDS[kindId or "instinct"] or KINDS.instinct
	win.setTitle(kind.title)
	local selected: string? = uuid
	local target: string? = nil
	local busy = false

	-- Colonne gauche : état actuel + choix du dino -------------------------------------------------------
	local stateHolder, stateBody = Kit.panel(win.content, { Size = UDim2.fromScale(0.38, 0.36) }, Theme.Parchment, 0.08)
	local _ = stateHolder
	local dinoName =
		Kit.title(stateBody, "", { Position = UDim2.fromScale(0.05, 0.04), Size = UDim2.fromScale(0.9, 0.26) }, 24)
	local current =
		Kit.title(stateBody, "", { Position = UDim2.fromScale(0.05, 0.32), Size = UDim2.fromScale(0.9, 0.38) }, 40)
	local currentPop = Kit.new("UIScale", { Parent = current })
	local currentEffect = Kit.label(stateBody, "", {
		Position = UDim2.fromScale(0.05, 0.72),
		Size = UDim2.fromScale(0.9, 0.24),
		TextColor3 = Theme.InkSoft,
	}, 18)

	local picker = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.38), Size = UDim2.fromScale(0.38, 0.62) })
	Kit.list(picker, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0), Parent = picker })

	-- Colonne droite : chances + actions -------------------------------------------------------------------
	local odds = Kit.scroll(win.content, { Position = UDim2.fromScale(0.4, 0), Size = UDim2.fromScale(0.6, 0.62) })
	Kit.list(odds, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.02, 0), PaddingRight = UDim.new(0.02, 0), Parent = odds })

	local costLabel = Kit.number(win.content, "", {
		Position = UDim2.fromScale(0.4, 0.64),
		Size = UDim2.fromScale(0.6, 0.1),
		Font = Enum.Font.GothamBold,
	}, 18)
	local actions = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.4, 0.76),
		Size = UDim2.fromScale(0.6, 0.22),
		Parent = win.content,
	})
	Kit.list(actions, true, 0.03, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
	local function action(order: number, width: number, text: string, color: Color3): TextButton
		local holder = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = order, Size = UDim2.fromScale(width, 1), Parent = actions }
		)
		return Kit.button(holder, text, { color = color, maid = win.maid, maxText = 20 })
	end
	local rerollButton = action(1, if kind.auto then 0.3 else 0.5, "Relancer", Theme.Amber)
	local autoButton = action(2, 0.42, "Auto", Theme.Leaf)
	autoButton.Parent.Visible = kind.auto
	local backButton = action(3, 0.22, "Sac", Theme.Stone)

	local rowMaid = Kit.maid()
	win.maid:add(rowMaid)

	local function valueOf(instance: Types.DinoInstance): string?
		return (instance :: any)[kind.field]
	end

	local function render()
		rowMaid:clean()
		local instance = selected and data.Dinos[selected]
		local currentId = instance and valueOf(instance)

		-- État actuel.
		if instance then
			local dino = Kit.dinoById[instance.dinoId]
			dinoName.Text = if dino then dino.displayName else instance.dinoId
			dinoName.TextColor3 = Kit.darker(Kit.rarityOf(instance.dinoId).color, 0.15)
			local entry = Kit.find(kind.list, currentId)
			if not busy then
				current.Text = if entry then entry.displayName else "—"
			end
			currentEffect.Text = if entry then kind.effect(entry) else "Jamais relancé"
		else
			dinoName.Text = "Choisis un dino"
			current.Text = "—"
			currentEffect.Text = ""
		end

		-- Choix du dino (meilleur revenu d'abord).
		local list = {}
		for id, inst in data.Dinos do
			table.insert(list, { uuid = id, instance = inst, income = Bonuses.instanceIncome(inst) })
		end
		table.sort(list, function(a, b)
			return if a.income ~= b.income then a.income > b.income else a.uuid < b.uuid
		end)
		for i, item in list do
			local dino = Kit.dinoById[item.instance.dinoId]
			local entry = Kit.find(kind.list, valueOf(item.instance))
			local row = Kit.new("TextButton", {
				AutoButtonColor = true,
				Text = "",
				LayoutOrder = i,
				BackgroundColor3 = if item.uuid == selected then Theme.Gold else Theme.Parchment,
				BackgroundTransparency = if item.uuid == selected then 0 else 0.4,
				Size = UDim2.new(1, 0, 0, 44),
				Parent = picker,
			})
			rowMaid:add(row)
			Kit.corner(row, 0.2)
			Kit.label(row, if dino then dino.displayName else "?", {
				Position = UDim2.fromScale(0.04, 0.1),
				Size = UDim2.fromScale(0.58, 0.8),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = Kit.darker(Kit.rarityOf(item.instance.dinoId).color, 0.2),
			}, 18)
			Kit.label(row, if entry then entry.displayName else "—", {
				Position = UDim2.fromScale(0.62, 0.1),
				Size = UDim2.fromScale(0.35, 0.8),
				TextXAlignment = Enum.TextXAlignment.Right,
			}, 18)
			rowMaid:add(row.Activated:Connect(function()
				if not busy then
					selected = item.uuid
					render()
				end
			end))
		end

		-- Chances de chaque résultat ; touche une ligne pour choisir le seuil d'auto-relance.
		rowMaid:add(Kit.row(odds, {
			{ text = "Résultat", width = 0.3, font = Theme.TitleFont },
			{ text = "Effet", width = 0.42, font = Theme.TitleFont },
			{ text = "Chance", width = 0.28, font = Theme.TitleFont, align = Enum.TextXAlignment.Right },
		}, 0, 30, Theme.ParchmentDeep))
		for i, entry in kind.list do
			local isCurrent = entry.id == currentId
			local isTarget = entry.id == target
			local row = Kit.new("TextButton", {
				AutoButtonColor = kind.auto,
				Text = "",
				LayoutOrder = i,
				BackgroundColor3 = if isTarget then Theme.Leaf elseif isCurrent then Theme.Gold else Theme.ParchmentDark,
				BackgroundTransparency = if isTarget or isCurrent or i % 2 == 0 then 0 else 1,
				Size = UDim2.new(1, 0, 0, 30),
				Parent = odds,
			})
			rowMaid:add(row)
			Kit.corner(row, 0.25)
			Kit.label(row, (if isTarget then "🎯 " elseif isCurrent then "▶ " else "") .. entry.displayName, {
				Position = UDim2.fromScale(0.01, 0.1),
				Size = UDim2.fromScale(0.29, 0.8),
				TextXAlignment = Enum.TextXAlignment.Left,
			}, 18)
			Kit.label(row, kind.effect(entry), {
				Position = UDim2.fromScale(0.31, 0.1),
				Size = UDim2.fromScale(0.41, 0.8),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = Theme.InkSoft,
			}, 16)
			Kit.number(row, Kit.percent(entry.perMillion / Helpers.PER_MILLION), {
				Position = UDim2.fromScale(0.72, 0.1),
				Size = UDim2.fromScale(0.27, 0.8),
				TextXAlignment = Enum.TextXAlignment.Right,
			}, 18)
			if kind.auto then
				rowMaid:add(row.Activated:Connect(function()
					target = if target == entry.id then nil else entry.id
					render()
				end))
			end
		end

		-- Coût et solde.
		local cost = kind.cost(data)
		local balance = (data :: any)[kind.currency] :: number
		local locked = kind.field == "imprint" and data.Rebirths < Imprints.unlockRebirth
		costLabel.Text = if locked
			then `🔒 Débloqué au rebirth {Imprints.unlockRebirth}`
			else `Coût : {Kit.big(cost)} {kind.currencyName} · Tu as {Kit.big(balance)}`
		Kit.paint(rerollButton, if locked or balance < cost or not instance then Theme.Disabled else Theme.Amber)
		local targetEntry = Kit.find(kind.list, target)
		autoButton.Text = if targetEntry then `Auto → {targetEntry.displayName}+` else "Auto : choisis 🎯"
		Kit.paint(autoButton, if targetEntry and instance and balance >= cost then Theme.Leaf else Theme.Disabled)
	end

	-- Roulette : fait défiler les résultats renvoyés par le serveur, ralentit, s'arrête sur le dernier.
	local function roulette(results: { string })
		local shown = {}
		for i = math.max(1, #results - 19), #results do
			table.insert(shown, results[i])
		end
		for i, id in shown do
			local entry = Kit.find(kind.list, id)
			current.Text = if entry then entry.displayName else id
			current.TextColor3 = Theme.InkSoft
			task.wait(0.04 + 0.16 * (i / #shown) ^ 2)
			if win.closed then
				return
			end
		end
		current.TextColor3 = if rank(kind, results[#results]) >= #kind.list - 3 then Theme.AmberDark else Theme.Ink
		currentPop.Scale = 1.4
		Kit.tween(currentPop, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
	end

	local function send(stopAtId: string?)
		local uuidNow = selected
		if busy or not uuidNow then
			return
		end
		busy = true
		local ok, response = pcall(function()
			if kind.field == "imprint" then
				return kind.remote:InvokeServer(uuidNow)
			end
			-- 5 relances par clic au plus : le serveur ramène au nombre permis (passe « Plus de … »).
			return kind.remote:InvokeServer(uuidNow, 5, stopAtId)
		end)
		if ok and type(response) == "table" and response.ok and type(response.results) == "table" then
			roulette(response.results)
			local last = Kit.find(kind.list, response.results[#response.results])
			if #response.results > 1 then
				NotificationController:Toast(
					`{#response.results} relances → {last and last.displayName or "?"}`,
					"info"
				)
			end
		else
			NotificationController:Toast(
				if ok and type(response) == "table" then tostring(response.reason) else "Réessaie dans un instant.",
				"error"
			)
		end
		busy = false
		if not win.closed then
			render()
		end
	end

	win.maid:add(rerollButton.Activated:Connect(function()
		send(nil)
	end))
	win.maid:add(autoButton.Activated:Connect(function()
		if target then
			send(target)
		else
			NotificationController:Toast("Touche un résultat dans la liste pour choisir le seuil 🎯.", "info")
		end
	end))
	win.maid:add(backButton.Activated:Connect(function()
		UIController:Open("Backpack", selected)
	end))

	local queued = false
	local function queue()
		if queued or busy then
			return
		end
		queued = true
		task.defer(function()
			queued = false
			if not win.closed and not busy then
				render()
			end
		end)
	end
	for _, key in { "Dinos", kind.currency, "Rebirths" } do
		win.maid:add(DataController:OnChanged(key, queue))
	end
	render()
end

return Screen
