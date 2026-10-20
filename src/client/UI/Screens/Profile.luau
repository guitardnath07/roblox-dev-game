--!strict
-- Profil du joueur (façon Anime Vanguards) :
--   à gauche, la carte : avatar, pseudo, titre équipé (avec sa couleur), dino vitrine en 3D qui tourne, chiffres clés ;
--   à droite, deux onglets : Titres (débloqués = « Choisir », verrouillés = comment les obtenir) et Dinos
--   (icônes des espèces trouvées, cliquer = dino vitrine ; espèces pas encore trouvées en silhouette).
-- Le choix part au serveur (SetProfile), qui vérifie titre débloqué / espèce trouvée. Affichage seul ici.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Dinos = require(Shared.Config.Dinos)
local Remotes = require(Shared.Net.Remotes)
local Titles = require(Shared.Config.Titles)
local Types = require(Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)

local DinoView = require(script.Parent.Parent.DinoView)
local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "👤 Profil", aspect = 1.6 }

local function count(set: { [any]: any }): number
	local n = 0
	for _ in set do
		n += 1
	end
	return n
end

-- Titre affiché : celui choisi s'il est débloqué, sinon le titre de départ (même règle que ProfileService).
local function currentTitle(data: Types.ProfileData): Titles.Title
	for _, t in Titles do
		if t.id == data.Profile.Title and t.unlocked(data) then
			return t
		end
	end
	return Titles[1]
end

local function buildCard(parent: Frame, win: Window.Window): () -> ()
	local _, card = Kit.panel(parent, { Size = UDim2.fromScale(0.36, 1) }, Theme.ParchmentDark, 0.06)
	local player = Players.LocalPlayer

	local avatar = Kit.new("ImageLabel", {
		BackgroundColor3 = Theme.Parchment,
		Position = UDim2.fromScale(0.05, 0.03),
		Size = UDim2.fromScale(0.26, 0.26),
		SizeConstraint = Enum.SizeConstraint.RelativeXX,
		Parent = card,
	})
	Kit.corner(avatar, 0.5)
	Kit.stroke(avatar, Theme.StoneDark, 2)
	task.spawn(function()
		local ok, image = pcall(function()
			return Players:GetUserThumbnailAsync(
				player.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size150x150
			)
		end)
		if ok and avatar.Parent then
			avatar.Image = image
		end
	end)
	Kit.title(card, player.DisplayName, {
		Position = UDim2.fromScale(0.36, 0.04),
		Size = UDim2.fromScale(0.6, 0.09),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, 28)
	local titleLabel = Kit.title(card, "", {
		Position = UDim2.fromScale(0.36, 0.13),
		Size = UDim2.fromScale(0.6, 0.07),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextStrokeColor3 = Theme.Ink,
		TextStrokeTransparency = 0.15,
	}, 22)

	-- Dino vitrine : socle rond + modèle 3D qui tourne.
	local stage = Kit.new("Frame", {
		BackgroundColor3 = Theme.Parchment,
		Position = UDim2.fromScale(0.08, 0.3),
		Size = UDim2.fromScale(0.84, 0.42),
		Parent = card,
	})
	Kit.corner(stage, 0.12)
	Kit.stroke(stage, Theme.ParchmentDeep, 2)
	local showcaseName = Kit.label(card, "", {
		Position = UDim2.fromScale(0.05, 0.73),
		Size = UDim2.fromScale(0.9, 0.06),
		TextColor3 = Theme.InkSoft,
	}, 18)
	local stats = Kit.label(card, "", {
		Position = UDim2.fromScale(0.07, 0.8),
		Size = UDim2.fromScale(0.86, 0.18),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextColor3 = Theme.Ink,
	}, 18)

	local view: DinoView.View? = nil
	local shownId: string? = nil
	win.maid:add(function()
		if view then
			view.destroy()
		end
	end)
	return function()
		local data: Types.ProfileData = DataController:Get()
		local t = currentTitle(data)
		titleLabel.Text = t.displayName
		titleLabel.TextColor3 = t.color
		local id = data.Profile.Showcase
		local dino = Kit.dinoById[id]
		if id ~= shownId then
			shownId = id
			if view then
				view.destroy()
				view = nil
			end
			if dino then
				view = DinoView.new(stage, id, { rotate = true, speed = 0.12 })
			end
		end
		showcaseName.Text = if dino
			then `{dino.displayName} · {Kit.rarityOf(id).displayName}`
			else "Choisis ton dino vitrine →"
		local best = Kit.dinoById[data.BestPull.DinoId]
		stats.Text =
			`🎲 {Kit.group(data.TotalRolls)} lancers\n📖 {count(data.Index.Found)} / {#Dinos} espèces\n🏆 {if best
				then `{best.displayName} (1 sur {Kit.big(data.BestPull.OneIn)})`
				else "—"}`
	end
end

local function buildTitles(page: Frame, win: Window.Window): () -> ()
	local scroll = Kit.scroll(page, { Size = UDim2.fromScale(1, 1) })
	Kit.list(scroll, false, 0)
	local layout = scroll:FindFirstChildOfClass("UIListLayout")
	if layout then
		layout.Padding = UDim.new(0, 6)
	end
	Kit.new(
		"UIPadding",
		{ PaddingTop = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), Parent = scroll }
	)
	local rows: { () -> () } = {}
	for i, t in Titles do
		local row = Kit.new("Frame", {
			BackgroundColor3 = Theme.Parchment,
			LayoutOrder = i,
			Size = UDim2.new(1, 0, 0, 52),
			Parent = scroll,
		})
		Kit.corner(row, 0.25)
		local stroke = Kit.stroke(row, Theme.ParchmentDeep, 2)
		local name = Kit.title(row, t.displayName, {
			Position = UDim2.fromScale(0.03, 0.06),
			Size = UDim2.fromScale(0.62, 0.52),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextStrokeColor3 = Theme.Ink,
			TextStrokeTransparency = 0.15,
		}, 22)
		local hint = Kit.label(row, t.hint, {
			Position = UDim2.fromScale(0.03, 0.56),
			Size = UDim2.fromScale(0.62, 0.38),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextColor3 = Theme.InkSoft,
		}, 14)
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(0.98, 0.5),
			Size = UDim2.fromScale(0.3, 0.8),
			Parent = row,
		})
		local button = Kit.button(holder, "", {
			maxText = 18,
			maid = win.maid,
			onClick = function()
				Remotes.SetProfile:FireServer("Title", t.id)
			end,
		})
		table.insert(rows, function()
			local data: Types.ProfileData = DataController:Get()
			local unlocked = t.unlocked(data)
			local equipped = currentTitle(data).id == t.id
			name.TextColor3 = if unlocked then t.color else Theme.Disabled
			hint.Text = if unlocked then (if equipped then "Équipé" else "Débloqué") else `🔒 {t.hint}`
			button.Text = if equipped then "Équipé" elseif unlocked then "Choisir" else "🔒"
			button.Active = unlocked and not equipped
			Kit.paint(button, if equipped then Theme.Leaf elseif unlocked then Theme.Amber else Theme.Disabled)
			stroke.Color = if equipped then Theme.Gold else Theme.ParchmentDeep
		end)
	end
	return function()
		for _, fn in rows do
			fn()
		end
	end
end

local function buildDinos(page: Frame, win: Window.Window): () -> ()
	local scroll = Kit.scroll(page, { Size = UDim2.fromScale(1, 1) })
	Kit.grid(scroll, 5, 0.85)
	local cells: { () -> () } = {}
	for i, dino in Dinos do
		local cell = Kit.new("TextButton", {
			AutoButtonColor = false,
			Text = "",
			BackgroundColor3 = Theme.Parchment,
			LayoutOrder = i,
			Parent = scroll,
		})
		Kit.corner(cell, 0.15)
		local stroke = Kit.stroke(cell, Kit.rarityOf(dino.id).color, 3)
		local stage = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.78), Parent = cell })
		local view = DinoView.new(stage, dino.id, { silhouette = true })
		win.maid:add(view.destroy)
		local name = Kit.label(cell, "???", {
			Position = UDim2.fromScale(0.04, 0.76),
			Size = UDim2.fromScale(0.92, 0.22),
			TextColor3 = Theme.Ink,
		}, 14)
		Kit.feedback(cell)
		win.maid:add(cell.Activated:Connect(function()
			Remotes.SetProfile:FireServer("Showcase", dino.id)
		end))
		table.insert(cells, function()
			local data: Types.ProfileData = DataController:Get()
			local found = data.Index.Found[dino.id] == true
			local selected = data.Profile.Showcase == dino.id
			view.setSilhouette(not found)
			name.Text = if found then dino.displayName else "???"
			cell.Active = found
			cell.BackgroundColor3 = if selected
				then Theme.Gold
				elseif found then Theme.Parchment
				else Theme.ParchmentDeep
			stroke.Thickness = if selected then 5 else 3
		end)
	end
	return function()
		for _, fn in cells do
			fn()
		end
	end
end

function Screen.build(win: Window.Window)
	local body = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = win.content })
	local refreshCard = buildCard(body, win)

	local right = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.39, 0),
		Size = UDim2.fromScale(0.61, 1),
		Parent = body,
	})
	local tabs = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.12), Parent = right })
	Kit.list(tabs, true, 0.02, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
	local pages: { Frame } = {}
	local buttons: { TextButton } = {}
	local function show(index: number)
		for i, page in pages do
			page.Visible = i == index
			Kit.paint(buttons[i], if i == index then Theme.Amber else Theme.Neutral)
		end
	end
	for i, name in { "🏷️ Titres", "🦖 Dinos" } do
		local holder = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = i, Size = UDim2.fromScale(0.4, 1), Parent = tabs }
		)
		buttons[i] = Kit.button(holder, name, {
			maxText = 20,
			maid = win.maid,
			onClick = function()
				show(i)
			end,
		})
		pages[i] = Kit.new("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0, 0.15),
			Size = UDim2.fromScale(1, 0.85),
			Parent = right,
		})
	end
	local refreshTitles = buildTitles(pages[1], win)
	local refreshDinos = buildDinos(pages[2], win)
	show(1)

	local function refresh()
		refreshCard()
		refreshTitles()
		refreshDinos()
	end
	for _, key in { "Profile", "Index", "TotalRolls", "Rebirths", "BestPull", "VolcanoBestFloor" } do
		win.maid:add(DataController:OnChanged(key, refresh))
	end
	refresh()
end

return Screen
