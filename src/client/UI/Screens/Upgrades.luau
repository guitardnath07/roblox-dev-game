--!strict
-- Arbre d'améliorations hexagonal (positions axiales q/r de Config/Upgrades) : nœuds achetés / achetables /
-- verrouillés, traits vers le prérequis (ou le centre), fiche du nœud choisi (coût, effet) et « Acheter »
-- (BuyUpgrade ; le serveur vérifie prérequis et Fossiles). Le joueur l'appelle « arbre des connaissances » :
-- déplacement au doigt, zoom (➕ / ➖ / pincer), nœuds achetés lumineux, liens animés.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Shared = ReplicatedStorage.Shared
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)
local Dice = require(Shared.Config.Dice)
local Upgrades = require(Shared.Config.Upgrades)

local DataController = require(script.Parent.Parent.Parent.Controllers.DataController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "⬆️ Arbre d'améliorations" }

local SIDE = 36 -- rayon d'un hexagone, px logiques
local SQRT3 = math.sqrt(3)

-- Une couleur vive et bien distincte par catégorie (comme les arbres de Slime RNG et consorts).
local BRANCH: { [string]: { icon: string, color: Color3 } } = {
	coins = { icon = "🐚", color = Color3.fromHex("#FFD21F") }, -- jaune
	luck = { icon = "🍀", color = Color3.fromHex("#2ED84A") }, -- vert
	auto = { icon = "🤖", color = Color3.fromHex("#FF4FA3") }, -- rose
	roll_speed = { icon = "⚡", color = Color3.fromHex("#00E0FF") }, -- cyan
	dice = { icon = "🎲", color = Color3.fromHex("#FF9EF3") }, -- arc-en-ciel (rose clair)
	backpack = { icon = "🎒", color = Color3.fromHex("#FF8A1F") }, -- orange
	sell = { icon = "🏷️", color = Color3.fromHex("#2F7BFF") }, -- bleu
	walk_speed = { icon = "👟", color = Color3.fromHex("#3DF5C8") }, -- menthe
	damage = { icon = "⚔️", color = Color3.fromHex("#9B4DFF") }, -- violet
	health = { icon = "❤️", color = Color3.fromHex("#FF3B3B") }, -- rouge
	mutation = { icon = "✨", color = Color3.fromHex("#E040FB") }, -- magenta
	offline = { icon = "🌙", color = Color3.fromHex("#5A5CFF") }, -- indigo
}

local STAT_TEXT: { [string]: (number, Upgrades.Upgrade) -> string } = {
	autoRoll = function()
		return "Débloque l'Auto-Lancer (bouton AUTO)"
	end,
	equipBest = function()
		return "Débloque « Équiper les meilleurs » dans le sac à dos"
	end,
	diceUnlock = function(_, node)
		local die = Kit.find(Dice, node.unlocksDie)
		return if die
			then `Débloque le {die.displayName} (chance {Kit.mult(die.luck)}), équipé tout de suite`
			else "Débloque un dé"
	end,
	skinMutationMultiplier = function(v)
		return `Peaux spéciales {Kit.mult(v)} plus fréquentes`
	end,
	offlineRate = function(v)
		return `Gains hors ligne : {math.floor(v * 100 + 0.5)} % du revenu`
	end,
	coinsMultiplier = function(v)
		return `Fossiles {Kit.mult(v)} au total`
	end,
	luckMultiplier = function(v)
		return `Chance {Kit.mult(v)} au total`
	end,
	rollSpeedMultiplier = function(v)
		return `Vitesse de lancer {Kit.mult(v)} au total`
	end,
	backpackSize = function(v)
		return `Sac : {v} places`
	end,
	sellMultiplier = function(v)
		return `Prix de vente {Kit.mult(v)} au total`
	end,
	walkSpeedBonus = function(v)
		return `Vitesse de marche +{v}`
	end,
	damageMultiplier = function(v)
		return `Dégâts au Volcan {Kit.mult(v)}`
	end,
	healthMultiplier = function(v)
		return `PV au Volcan {Kit.mult(v)}`
	end,
}

local function roman(name: string): string
	return name:match("(%u+)$") or ""
end

local function axialToPixel(q: number, r: number): Vector2
	return Vector2.new(SIDE * SQRT3 * (q + r / 2), SIDE * 1.5 * r)
end

-- Hexagone à pointe en haut = union de 3 rectangles (s√3 × s) tournés de 0°, 60°, 120°.
local function hexagon(parent: Instance, size: number, color: Color3, z: number): { Frame }
	local parts = {}
	for i = 0, 2 do
		table.insert(
			parts,
			Kit.new("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(size * SQRT3, size),
				Rotation = i * 60,
				BackgroundColor3 = color,
				BorderSizePixel = 0,
				ZIndex = z,
				Parent = parent,
			})
		)
	end
	return parts
end

local function paint(parts: { Frame }, color: Color3)
	for _, p in parts do
		p.BackgroundColor3 = color
	end
end

-- Trait entre deux points du canevas.
local function line(parent: Instance, a: Vector2, b: Vector2, color: Color3): Frame
	local mid = (a + b) / 2
	local delta = b - a
	return Kit.new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromOffset(mid.X, mid.Y),
		Size = UDim2.fromOffset(delta.Magnitude, 5),
		Rotation = math.deg(math.atan2(delta.Y, delta.X)),
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		ZIndex = 1,
		Parent = parent,
	})
end

type NodeUi = {
	node: Upgrades.Upgrade,
	outer: { Frame },
	inner: { Frame },
	glow: { Frame },
	button: TextButton,
	lineFrame: Frame,
	sheen: UIGradient,
	label: TextLabel,
	state: string,
	fx: { Tween },
}

local MIN_ZOOM, MAX_ZOOM = 0.6, 1.8
-- Fond peint derrière l'arbre (rendu Blender original : arbre au coucher du soleil sous un ciel étoilé).
local BACKGROUND_IMAGE = "rbxassetid://122948084121708"

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()

	-- Bornes du canevas.
	local minP, maxP = Vector2.zero, Vector2.zero
	for _, node in Upgrades.list do
		local p = axialToPixel(node.q, node.r)
		minP = Vector2.new(math.min(minP.X, p.X), math.min(minP.Y, p.Y))
		maxP = Vector2.new(math.max(maxP.X, p.X), math.max(maxP.Y, p.Y))
	end
	local margin = SIDE * 1.6
	local origin = Vector2.new(-minP.X + margin, -minP.Y + margin)
	local canvasSize = maxP - minP + Vector2.new(margin * 2, margin * 2)

	-- Glisser pour se déplacer (ScrollingFrame), ➕ / ➖ ou pincer pour zoomer (UIScale du canevas).
	local backdrop = Kit.new("ImageLabel", {
		BackgroundColor3 = Color3.fromHex("#1B2A3A"),
		Image = BACKGROUND_IMAGE,
		ScaleType = Enum.ScaleType.Crop,
		Size = UDim2.fromScale(0.64, 1),
		Parent = win.content,
	})
	Kit.corner(backdrop, 0.03)
	local tree = Kit.scroll(win.content, {
		Size = UDim2.fromScale(0.64, 1),
		AutomaticCanvasSize = Enum.AutomaticSize.None,
		CanvasSize = UDim2.fromOffset(canvasSize.X, canvasSize.Y),
		ScrollingDirection = Enum.ScrollingDirection.XY,
		HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		BackgroundTransparency = 1, -- on voit le fond peint au travers
	})
	local canvas = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(canvasSize.X, canvasSize.Y),
		Parent = tree,
	})
	local zoomScale = Kit.new("UIScale", { Parent = canvas })
	local zoom = 1

	local function setZoom(z: number)
		local old = zoom
		zoom = math.clamp(z, MIN_ZOOM, MAX_ZOOM)
		-- Garde le point au centre de la vue au même endroit.
		local window = tree.AbsoluteWindowSize
		local centerPoint = (tree.CanvasPosition + window / 2) / old
		zoomScale.Scale = zoom
		tree.CanvasSize = UDim2.fromOffset(canvasSize.X * zoom, canvasSize.Y * zoom)
		tree.CanvasPosition = centerPoint * zoom - window / 2
	end

	local zoomBar = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.01, 0.02),
		Size = UDim2.fromScale(0.08, 0.4),
		ZIndex = 5,
		Parent = win.content,
	})
	Kit.list(zoomBar, false, 0.04)
	for i, info in { { "➕", 1.25 }, { "➖", 0.8 } } do
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Size = UDim2.fromScale(1, 0.45),
			ZIndex = 5,
			Parent = zoomBar,
		})
		Kit.aspect(holder, 1, true)
		local b = Kit.button(holder, info[1], {
			color = Theme.Stone,
			maid = win.maid,
			maxText = 22,
			onClick = function()
				setZoom(zoom * info[2])
			end,
		})
		b.ZIndex = 5
	end
	win.maid:add(UserInputService.TouchPinch:Connect(function(_, scale: number, _, state: Enum.UserInputState)
		if state == Enum.UserInputState.Change then
			setZoom(zoom * (1 + (scale - 1) * 0.08))
		end
	end))

	-- Fiche du nœud sélectionné.
	local infoHolder, info = Kit.panel(win.content, {
		Position = UDim2.fromScale(0.66, 0),
		Size = UDim2.fromScale(0.34, 1),
	}, Theme.Parchment, 0.06)
	local _ = infoHolder
	local infoTitle = Kit.title(
		info,
		"Choisis un nœud",
		{ Position = UDim2.fromScale(0.05, 0.03), Size = UDim2.fromScale(0.9, 0.16) },
		26
	)
	local infoBody = Kit.label(info, "Touche un hexagone pour voir son coût et son effet.", {
		Position = UDim2.fromScale(0.05, 0.21),
		Size = UDim2.fromScale(0.9, 0.5),
		TextYAlignment = Enum.TextYAlignment.Top,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, 20)
	local buyHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.08, 0.76),
		Size = UDim2.fromScale(0.84, 0.2),
		Parent = info,
	})
	local buyButton = Kit.button(buyHolder, "Acheter", { color = Theme.Disabled, maid = win.maid })
	buyButton.Visible = false

	-- Centre de l'arbre.
	local center = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromOffset(origin.X, origin.Y),
		Size = UDim2.fromOffset(SIDE * 2, SIDE * 2),
		ZIndex = 2,
		Parent = canvas,
	})
	hexagon(center, SIDE * 0.95, Theme.StoneDark, 2)
	hexagon(center, SIDE * 0.8, Theme.Amber, 3)
	Kit.label(
		center,
		"🦴",
		{ ZIndex = 4, Size = UDim2.fromScale(0.6, 0.6), Position = UDim2.fromScale(0.2, 0.2) },
		30
	)

	local nodes: { NodeUi } = {}
	local byId: { [string]: Upgrades.Upgrade } = {}
	for _, node in Upgrades.list do
		byId[node.id] = node
	end
	local selected: Upgrades.Upgrade? = nil

	local function state(node: Upgrades.Upgrade): "bought" | "buyable" | "affordable" | "locked"
		if data.Upgrades[node.id] then
			return "bought"
		elseif node.prerequisite == nil or data.Upgrades[node.prerequisite] then
			return if data.Fossils >= node.cost then "affordable" else "buyable"
		end
		return "locked"
	end

	local function refreshInfo()
		local node = selected
		if not node then
			return
		end
		local s = state(node)
		infoTitle.Text = node.displayName
		local effect = STAT_TEXT[node.stat](node.value, node)
		local prereq = node.prerequisite and byId[node.prerequisite]
		infoBody.Text = `{effect}\nCoût : {Kit.big(node.cost)} Fossiles`
			.. (if prereq then `\nPrérequis : {prereq.displayName}` else "")
		buyButton.Visible = true
		if s == "bought" then
			buyButton.Text = "Acheté ✔"
			Kit.paint(buyButton, Theme.LeafDark)
		elseif s == "locked" then
			buyButton.Text = "🔒 Verrouillé"
			Kit.paint(buyButton, Theme.Disabled)
		elseif s == "affordable" then
			buyButton.Text = `Acheter ({Kit.big(node.cost)})`
			Kit.paint(buyButton, Theme.Amber)
		else
			buyButton.Text = `Il manque {Kit.big(node.cost - data.Fossils)}`
			Kit.paint(buyButton, Theme.Disabled)
		end
	end

	for i, node in Upgrades.list do
		local p = origin + axialToPixel(node.q, node.r)
		local branch = BRANCH[node.branch]
		local from = if node.prerequisite then byId[node.prerequisite] else nil
		local a = if from then origin + axialToPixel(from.q, from.r) else origin
		local lineFrame = line(canvas, a, p, Theme.Stone)
		-- Reflet qui court le long des liens achetés.
		local sheen = Kit.new("UIGradient", {
			Enabled = false,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Theme.Gold),
				ColorSequenceKeypoint.new(0.5, Theme.White),
				ColorSequenceKeypoint.new(1, Theme.Gold),
			}),
			Offset = Vector2.new(-1, 0),
			Parent = lineFrame,
		})

		local button = Kit.new("TextButton", {
			BackgroundTransparency = 1,
			Text = "",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(p.X, p.Y),
			Size = UDim2.fromOffset(SIDE * SQRT3, SIDE * 2),
			ZIndex = 2,
			Parent = canvas,
		})
		Kit.feedback(button)
		Kit.stagger(button, i)
		local glow = hexagon(button, SIDE * 1.2, Theme.Gold, 1)
		for _, g in glow do
			g.BackgroundTransparency = 1
		end
		local outer = hexagon(button, SIDE * 0.95, Theme.StoneDark, 2)
		local inner = hexagon(button, SIDE * 0.8, branch.color, 3)
		local label = Kit.label(button, `{branch.icon}\n{roman(node.displayName)}`, {
			ZIndex = 4,
			Position = UDim2.fromScale(0.15, 0.2),
			Size = UDim2.fromScale(0.7, 0.6),
			TextColor3 = Theme.White,
			TextStrokeTransparency = 0.3,
			Font = Theme.TitleFont,
		}, 22)
		local ui: NodeUi = {
			node = node,
			outer = outer,
			inner = inner,
			glow = glow,
			button = button,
			lineFrame = lineFrame,
			sheen = sheen,
			label = label,
			state = "",
			fx = {},
		}
		table.insert(nodes, ui)

		local function choose()
			selected = node
			refreshInfo()
		end
		win.maid:add(button.Activated:Connect(choose)) -- clic uniquement : le survol ne change jamais la sélection
	end

	win.maid:add(buyButton.Activated:Connect(function()
		local node = selected
		if node and state(node) == "affordable" then
			Remotes.BuyUpgrade:FireServer(node.id)
		end
	end))

	-- Apparence d'un nœud selon son état ; les effets (tweens en boucle) ne changent qu'au changement d'état.
	local function apply(ui: NodeUi, s: string)
		for _, t in ui.fx do
			t:Destroy()
		end
		table.clear(ui.fx)
		local branchColor = BRANCH[ui.node.branch].color
		local visible = s ~= "locked" -- on ne voit que les cases achetées et celles qui les touchent
		ui.button.Visible = visible
		ui.lineFrame.Visible = visible
		ui.sheen.Enabled = s == "bought"
		for _, g in ui.glow do
			g.BackgroundTransparency = 1
		end
		if s == "bought" then
			paint(ui.inner, branchColor)
			paint(ui.outer, Theme.Gold)
			ui.lineFrame.BackgroundColor3 = Theme.White
			ui.label.TextTransparency = 0
			-- Halo doré qui respire + reflet qui file le long du lien.
			for _, g in ui.glow do
				g.BackgroundTransparency = 0.55
				table.insert(ui.fx, Kit.loop(g, 1.2, { BackgroundTransparency = 0.85 }, true, Enum.EasingStyle.Sine))
			end
			ui.sheen.Offset = Vector2.new(-1, 0)
			table.insert(ui.fx, Kit.loop(ui.sheen, 1.6, { Offset = Vector2.new(1, 0) }))
		elseif s == "affordable" then
			paint(ui.inner, Kit.darker(branchColor, 0.2))
			paint(ui.outer, Theme.Leaf)
			ui.lineFrame.BackgroundColor3 = Theme.Leaf
			ui.label.TextTransparency = 0
			for _, part in ui.outer do
				table.insert(ui.fx, Kit.loop(part, 0.7, { BackgroundColor3 = Theme.Gold }, true, Enum.EasingStyle.Sine))
			end
		elseif s == "buyable" then
			paint(ui.inner, Kit.darker(branchColor, 0.3))
			paint(ui.outer, Theme.StoneDark)
			ui.lineFrame.BackgroundColor3 = Theme.Stone
			ui.label.TextTransparency = 0
		else
			-- Verrouillé : couleur de la catégorie, atténuée (on reconnaît la branche même de loin).
			paint(ui.inner, branchColor:Lerp(Color3.fromRGB(110, 102, 96), 0.5))
			paint(ui.outer, Theme.StoneDark)
			ui.lineFrame.BackgroundColor3 = Color3.fromHex("#5E554B")
			ui.label.TextTransparency = 0.5
		end
	end

	local function refresh()
		for _, ui in nodes do
			local s = state(ui.node)
			if s ~= ui.state then
				if ui.state == "locked" and s ~= "locked" then
					-- Nouvelle case révélée : elle surgit avec un rebond.
					local scale = ui.button:FindFirstChildOfClass("UIScale")
					if scale then
						scale.Scale = 0.2
						Kit.tween(scale, 0.45, { Scale = 1 }, Enum.EasingStyle.Back)
					end
				elseif ui.state ~= "" and s == "bought" then
					-- Achat : petit rebond du nœud.
					local scale = ui.label.Parent and (ui.label.Parent :: Instance):FindFirstChildOfClass("UIScale")
					if scale then
						scale.Scale = 1.35
						Kit.tween(scale, 0.4, { Scale = 1 }, Enum.EasingStyle.Back)
					end
				end
				ui.state = s
				apply(ui, s)
			end
		end
		refreshInfo()
	end
	win.maid:add(DataController:OnChanged("Upgrades", refresh))
	win.maid:add(DataController:OnChanged("Fossils", refresh))
	refresh()
	win.maid:add(function()
		for _, ui in nodes do
			for _, t in ui.fx do
				t:Destroy()
			end
		end
	end)

	-- Démarre centré sur le cœur de l'arbre.
	task.defer(function()
		local window = tree.AbsoluteWindowSize
		local s = tree.AbsoluteCanvasSize.X / math.max(1, canvasSize.X)
		tree.CanvasPosition = Vector2.new(origin.X * s - window.X / 2, origin.Y * s - window.Y / 2)
	end)
end

return Screen
