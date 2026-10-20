--!strict
-- Fenêtre d'échange en cours (ouverte par TradeController à la réception de TradeState) :
-- choix de ses dinos (8 max, ni posés ni verrouillés) + Ambre / Os (TradeSetOffer), offre de l'autre,
-- « Prêt » (TradeSetReady), compte à rebours de 5 s (countdownEndsAt), « Confirmer » (TradeConfirm), Annuler.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local Types = require(ReplicatedStorage.Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local TradeController = require(Controllers.TradeController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "🤝 Échange" }

local MAX_DINOS = 8

local function isPlaced(data: Types.ProfileData, uuid: string): boolean
	for _, placed in data.PlotSlots do
		if placed == uuid then
			return true
		end
	end
	return false
end

-- Colonne « offre » (la sienne ou celle de l'autre) : titre, dinos, monnaies, badge Prêt.
local function offerColumn(parent: Instance, x: number, title: string): (TextLabel, ScrollingFrame, TextLabel)
	local _, body = Kit.panel(
		parent,
		{ Position = UDim2.fromScale(x, 0), Size = UDim2.fromScale(0.33, 0.76) },
		Theme.Parchment,
		0.06
	)
	local header =
		Kit.title(body, title, { Position = UDim2.fromScale(0.04, 0.02), Size = UDim2.fromScale(0.92, 0.13) }, 20)
	local list = Kit.scroll(body, { Position = UDim2.fromScale(0.04, 0.17), Size = UDim2.fromScale(0.92, 0.5) })
	Kit.list(list, false, 0)
	local footer = Kit.number(body, "", {
		Position = UDim2.fromScale(0.04, 0.69),
		Size = UDim2.fromScale(0.92, 0.12),
		Font = Enum.Font.GothamBold,
	}, 18)
	return header, list, footer
end

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()
	local current = TradeController:Get()
	local offer: { uuids: { string }, amber: number, bones: number } = { uuids = {}, amber = 0, bones = 0 }
	if current then
		for uuid in current.you.dinos do
			table.insert(offer.uuids, uuid)
		end
		offer.amber = current.you.amber
		offer.bones = current.you.bones
	end

	-- Envoi groupé de l'offre (0,25 s après le dernier changement).
	local sendGeneration = 0
	local function sendOffer()
		sendGeneration += 1
		local generation = sendGeneration
		task.delay(0.25, function()
			if generation == sendGeneration and not win.closed then
				Remotes.TradeSetOffer:FireServer({ uuids = offer.uuids, amber = offer.amber, bones = offer.bones })
			end
		end)
	end

	-- Gauche : mes dinos échangeables.
	Kit.title(win.content, "Tes dinos", { Size = UDim2.fromScale(0.3, 0.1) }, 20)
	local mine = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.11), Size = UDim2.fromScale(0.3, 0.65) })
	Kit.list(mine, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0), Parent = mine })

	-- Milieu : mon offre (+ saisie Ambre / Os). Droite : l'offre de l'autre.
	local youHeader, youList, youFooter = offerColumn(win.content, 0.32, "Ton offre")
	local themHeader, themList, themFooter = offerColumn(win.content, 0.67, "Son offre")
	local youBody = youHeader.Parent :: Instance
	local function currencyBox(x: number, icon: string, key: "amber" | "bones")
		local box = Kit.new("TextBox", {
			BackgroundColor3 = Theme.White,
			Position = UDim2.fromScale(x, 0.83),
			Size = UDim2.fromScale(0.44, 0.15),
			Font = Theme.NumberFont,
			PlaceholderText = icon .. " 0",
			Text = if offer[key] > 0 then tostring(offer[key]) else "",
			TextScaled = true,
			TextColor3 = Theme.Ink,
			ClearTextOnFocus = false,
			Parent = youBody,
		})
		Kit.corner(box, 0.25)
		Kit.stroke(box, Theme.Stone, 2)
		Kit.touch(box)
		Kit.new("UITextSizeConstraint", { MaxTextSize = 20, Parent = box })
		win.maid:add(box.FocusLost:Connect(function()
			local n = math.floor(tonumber(box.Text) or 0)
			local max = if key == "amber" then data.Amber else data.Bones
			n = math.clamp(n, 0, max)
			box.Text = if n > 0 then tostring(n) else ""
			if n ~= offer[key] then
				offer[key] = n
				sendOffer()
			end
		end))
	end
	currencyBox(0.04, "🔶", "amber")
	currencyBox(0.52, "🦴", "bones")

	-- Bas : état + actions.
	local status = Kit.label(win.content, "", {
		Position = UDim2.fromScale(0, 0.79),
		Size = UDim2.fromScale(0.42, 0.2),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, 22)
	local mainHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.44, 0.8),
		Size = UDim2.fromScale(0.32, 0.19),
		Parent = win.content,
	})
	local mainButton = Kit.button(mainHolder, "Prêt", { color = Theme.Leaf, maid = win.maid })
	local cancelHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.78, 0.8),
		Size = UDim2.fromScale(0.22, 0.19),
		Parent = win.content,
	})
	Kit.button(cancelHolder, "Annuler", {
		color = Theme.Lava,
		maid = win.maid,
		onClick = function()
			Remotes.TradeCancel:FireServer()
		end,
	})

	local rowMaid = Kit.maid()
	win.maid:add(rowMaid)

	local function dinoRow(list: Instance, order: number, instance: Types.DinoInstance): Frame
		local dino = Kit.dinoById[instance.dinoId]
		local rarity = Kit.rarityOf(instance.dinoId)
		local row = Kit.row(list, {
			{ text = if dino then dino.displayName else "?", width = 0.62, color = Kit.darker(rarity.color, 0.2) },
			{ text = rarity.displayName, width = 0.38, align = Enum.TextXAlignment.Right, color = Theme.InkSoft },
		}, order, 30)
		rowMaid:add(row)
		return row
	end

	local function render()
		rowMaid:clean()
		local s = TradeController:Get()
		if not s then
			return
		end
		themHeader.Text = `Offre de {s.them.name}`
		youHeader.Text = "Ton offre" .. (if s.you.ready then " ✔" else "")
		if s.them.ready then
			themHeader.Text ..= " ✔"
		end

		-- Mes dinos échangeables (posés et verrouillés exclus), cochés s'ils sont dans l'offre.
		local chosen: { [string]: boolean } = {}
		for _, uuid in offer.uuids do
			chosen[uuid] = true
		end
		local order = 0
		for uuid, instance in data.Dinos do
			if not instance.locked and not isPlaced(data, uuid) then
				order += 1
				local dino = Kit.dinoById[instance.dinoId]
				local rarity = Kit.rarityOf(instance.dinoId)
				local row = Kit.new("TextButton", {
					AutoButtonColor = true,
					Text = "",
					LayoutOrder = -Kit.rarityOf(instance.dinoId).order * 1000 + order,
					BackgroundColor3 = if chosen[uuid] then Theme.Gold else Theme.Parchment,
					BackgroundTransparency = if chosen[uuid] then 0 else 0.4,
					Size = UDim2.new(1, 0, 0, 44),
					Parent = mine,
				})
				rowMaid:add(row)
				Kit.corner(row, 0.2)
				Kit.label(row, (if chosen[uuid] then "✔ " else "") .. (if dino then dino.displayName else "?"), {
					Position = UDim2.fromScale(0.05, 0.1),
					Size = UDim2.fromScale(0.9, 0.8),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextColor3 = Kit.darker(rarity.color, 0.2),
				}, 18)
				rowMaid:add(row.Activated:Connect(function()
					if s.phase ~= "offer" then
						return
					end
					local index = table.find(offer.uuids, uuid)
					if index then
						table.remove(offer.uuids, index)
					elseif #offer.uuids < MAX_DINOS then
						table.insert(offer.uuids, uuid)
					end
					sendOffer()
					render()
				end))
			end
		end

		local i = 0
		for _, instance in s.you.dinos do
			i += 1
			dinoRow(youList, i, instance)
		end
		youFooter.Text = `🔶 {Kit.big(s.you.amber)}   🦴 {Kit.big(s.you.bones)}   ({i}/{MAX_DINOS})`
		i = 0
		for _, instance in s.them.dinos do
			i += 1
			dinoRow(themList, i, instance)
		end
		themFooter.Text = `🔶 {Kit.big(s.them.amber)}   🦴 {Kit.big(s.them.bones)}`

		if s.phase == "offer" then
			mainButton.Text = if s.you.ready then "Annuler Prêt" else "Prêt"
			Kit.paint(mainButton, if s.you.ready then Theme.Stone else Theme.Leaf)
			status.Text = if s.you.ready
				then `En attente de {s.them.name}…`
				else "Prépare ton offre puis touche Prêt."
		elseif s.phase == "countdown" then
			mainButton.Text = "…"
			Kit.paint(mainButton, Theme.Disabled)
		else
			mainButton.Text = if s.you.confirmed then "Confirmé ✔" else "Confirmer"
			Kit.paint(mainButton, if s.you.confirmed then Theme.Stone else Theme.Amber)
			status.Text = if s.you.confirmed then `En attente de {s.them.name}…` else "Vérifie bien, puis confirme !"
		end
	end

	win.maid:add(mainButton.Activated:Connect(function()
		local s = TradeController:Get()
		if not s then
			return
		end
		if s.phase == "offer" then
			Remotes.TradeSetReady:FireServer(not s.you.ready)
		elseif s.phase == "confirm" and not s.you.confirmed then
			Remotes.TradeConfirm:FireServer()
		end
	end))

	-- Compte à rebours : texte mis à jour 10 fois par seconde tant que la fenêtre est ouverte.
	win.maid:add(task.spawn(function()
		while not win.closed do
			local s = TradeController:Get()
			if s and s.phase == "countdown" and s.countdownEndsAt then
				local left = math.max(0, s.countdownEndsAt - Workspace:GetServerTimeNow())
				status.Text = `Vérification… confirmation possible dans {math.ceil(left)} s`
			end
			task.wait(0.1)
		end
	end))

	win.maid:add(TradeController:OnState(function(s)
		if s and not win.closed then
			render()
		end
	end))
	win.maid:add(DataController:OnChanged("Dinos", function()
		if not win.closed then
			render()
		end
	end))
	-- Fermer la fenêtre pendant un échange = l'annuler.
	win.maid:add(function()
		if TradeController:Get() then
			Remotes.TradeCancel:FireServer()
		end
	end)
	render()
end

return Screen
