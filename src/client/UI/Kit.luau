--!strict
-- Boîte à outils de l'interface : création d'instances, style parchemin / pierre, boutons, formats de nombres,
-- et « Maid » (sac de connexions à libérer quand un écran se ferme). Affichage seul, aucune logique de jeu.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Types = require(Shared.Types)
local Dinos = require(Shared.Config.Dinos)
local Odds = require(Shared.Odds)
local Rarities = require(Shared.Config.Rarities)
local Theme = require(script.Parent.Theme)

local Kit = {}

-- Maid -------------------------------------------------------------------------------------------------

export type Maid = {
	add: (self: Maid, item: any) -> any,
	clean: (self: Maid) -> (),
}

-- Accepte : RBXScriptConnection, Instance, fonction, thread, ou autre Maid.
function Kit.maid(): Maid
	local items: { any } = {}
	local maid = {} :: any
	function maid.add(_self, item: any): any
		table.insert(items, item)
		return item
	end
	function maid.clean(_self)
		for i = #items, 1, -1 do
			local item = items[i]
			local kind = typeof(item)
			if kind == "RBXScriptConnection" then
				item:Disconnect()
			elseif kind == "Instance" then
				item:Destroy()
			elseif kind == "function" then
				task.spawn(item)
			elseif kind == "thread" then
				pcall(task.cancel, item)
			elseif kind == "table" and item.clean then
				item:clean()
			end
		end
		table.clear(items)
	end
	return maid :: Maid
end

-- Création ----------------------------------------------------------------------------------------------

-- Crée une instance, applique `props` (Parent en dernier) et range les `children` dedans.
function Kit.new(className: string, props: { [string]: any }?, children: { Instance }?): any
	local instance: any = Instance.new(className)
	local parent = nil
	for key, value in props or {} do
		if key == "Parent" then
			parent = value
		else
			instance[key] = value
		end
	end
	for _, child in children or {} do
		child.Parent = instance
	end
	if parent then
		instance.Parent = parent
	end
	return instance
end

function Kit.corner(parent: Instance, radius: number?): UICorner
	return Kit.new("UICorner", { CornerRadius = UDim.new(radius or 0.2, 0), Parent = parent })
end

-- Bordure (mode Border : contour de la boîte, jamais du texte).
function Kit.stroke(parent: Instance, color: Color3?, thickness: number?, transparency: number?): UIStroke
	return Kit.new("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = color or Theme.StoneDark,
		Thickness = thickness or 2,
		Transparency = transparency or 0,
		Parent = parent,
	})
end

function Kit.aspect(parent: Instance, ratio: number, dominantHeight: boolean?): UIAspectRatioConstraint
	return Kit.new("UIAspectRatioConstraint", {
		AspectRatio = ratio,
		DominantAxis = if dominantHeight then Enum.DominantAxis.Height else Enum.DominantAxis.Width,
		Parent = parent,
	})
end

function Kit.limit(parent: Instance, minSize: Vector2?, maxSize: Vector2?): UISizeConstraint
	return Kit.new("UISizeConstraint", {
		MinSize = minSize or Vector2.zero,
		MaxSize = maxSize or Vector2.new(math.huge, math.huge),
		Parent = parent,
	})
end

-- Taille tactile minimale (44 px logiques, l'UIScale globale ne descend jamais sous 1).
function Kit.touch(parent: Instance, minWidth: number?)
	Kit.limit(parent, Vector2.new(minWidth or Theme.MinTouch, Theme.MinTouch))
end

function Kit.padding(parent: Instance, scale: number?): UIPadding
	local s = UDim.new(scale or 0.04, 0)
	return Kit.new(
		"UIPadding",
		{ PaddingLeft = s, PaddingRight = s, PaddingTop = s, PaddingBottom = s, Parent = parent }
	)
end

function Kit.list(
	parent: Instance,
	horizontal: boolean?,
	padding: number?,
	hAlign: Enum.HorizontalAlignment?,
	vAlign: Enum.VerticalAlignment?
): UIListLayout
	return Kit.new("UIListLayout", {
		FillDirection = if horizontal then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical,
		Padding = UDim.new(padding or 0.02, 0),
		HorizontalAlignment = hAlign or Enum.HorizontalAlignment.Center,
		VerticalAlignment = vAlign or Enum.VerticalAlignment.Top,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = parent,
	})
end

-- Zone défilante verticale (ou XY) au style parchemin foncé.
function Kit.scroll(parent: Instance, props: { [string]: any }?): ScrollingFrame
	local scroll = Kit.new("ScrollingFrame", {
		BackgroundColor3 = Theme.ParchmentDark,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = Theme.StoneDark,
		VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = parent,
	})
	for key, value in props or {} do
		(scroll :: any)[key] = value
	end
	Kit.corner(scroll, 0.03)
	return scroll
end

-- Grille de `columns` colonnes ; hauteur des cases = largeur / aspect.
function Kit.grid(scroll: Instance, columns: number, aspect: number, gap: number?): UIGridLayout
	local g = gap or 0.015
	local layout = Kit.new("UIGridLayout", {
		CellSize = UDim2.new(1 / columns - g, 0, 0, 10),
		CellPadding = UDim2.new(g, 0, 0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		Parent = scroll,
	})
	-- Hauteur des cases = largeur / aspect. (Un UIAspectRatioConstraint sous le UIGridLayout n'agit pas dans
	-- une ScrollingFrame.) Les tailles absolues incluent l'UIScale des ancêtres : on la retire pour l'offset.
	local function resize()
		local s = 1
		local node: Instance? = scroll
		while node do
			local uiScale = node:FindFirstChildOfClass("UIScale")
			if uiScale then
				s *= uiScale.Scale
			end
			node = node.Parent
		end
		local width = (scroll :: any).AbsoluteWindowSize.X * (1 / columns - g)
		layout.CellSize = UDim2.new(1 / columns - g, 0, 0, math.max(10, width / aspect / math.max(s, 0.01)))
	end
	scroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(resize)
	task.defer(resize)
	Kit.new("UIPadding", {
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		Parent = scroll,
	})
	return layout
end

-- Texte -------------------------------------------------------------------------------------------------

-- Texte ajusté à sa boîte, plafonné à `maxSize` px logiques.
function Kit.label(parent: Instance, text: string, props: { [string]: any }?, maxSize: number?): TextLabel
	local l = Kit.new("TextLabel", {
		BackgroundTransparency = 1,
		Text = text,
		Font = Theme.BodyFont,
		TextColor3 = Theme.Ink,
		TextScaled = true,
		TextWrapped = true,
		Size = UDim2.fromScale(1, 1),
		Parent = parent,
	})
	for key, value in props or {} do
		(l :: any)[key] = value
	end
	Kit.new("UITextSizeConstraint", { MaxTextSize = maxSize or 40, MinTextSize = 7, Parent = l })
	return l
end

function Kit.title(parent: Instance, text: string, props: { [string]: any }?, maxSize: number?): TextLabel
	local l = Kit.label(parent, text, props, maxSize or 48)
	l.Font = Theme.TitleFont
	return l
end

-- Nombre (police Gotham).
function Kit.number(parent: Instance, text: string, props: { [string]: any }?, maxSize: number?): TextLabel
	local l = Kit.label(parent, text, props, maxSize)
	l.Font = Theme.NumberFont
	return l
end

-- Animations ----------------------------------------------------------------------------------------------

function Kit.tween(
	instance: Instance,
	seconds: number,
	goal: { [string]: any },
	style: Enum.EasingStyle?,
	direction: Enum.EasingDirection?
): Tween
	local t = TweenService:Create(
		instance,
		TweenInfo.new(seconds, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
		goal
	)
	t:Play()
	return t
end

-- Tween en boucle infinie (aller-retour si `reverses`) : animé par le moteur, pas de boucle Lua par image.
-- Le Tween est une Instance : un Maid le détruit (et l'arrête) à la fermeture.
function Kit.loop(
	instance: Instance,
	seconds: number,
	goal: { [string]: any },
	reverses: boolean?,
	style: Enum.EasingStyle?
): Tween
	local t = TweenService:Create(
		instance,
		TweenInfo.new(seconds, style or Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, reverses == true),
		goal
	)
	t:Play()
	return t
end

-- Apparition décalée d'un élément de liste / grille (petit « pop » Back), au plus 0,4 s de retard.
function Kit.stagger(item: GuiObject, index: number)
	local scale = item:FindFirstChildOfClass("UIScale") or Kit.new("UIScale", { Parent = item })
	scale.Scale = 0
	task.delay(math.min(index * 0.025, 0.4), function()
		if scale.Parent then
			Kit.tween(scale, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
		end
	end)
end

-- Compteur animé : renvoie `set(value)` qui fait défiler le texte jusqu'à la nouvelle valeur (0,4 s).
function Kit.countUp(label: TextLabel, format: (number) -> string): (number) -> ()
	local value = Kit.new("NumberValue", { Parent = label })
	value.Changed:Connect(function(v: number)
		label.Text = format(v)
	end)
	local first = true
	return function(target: number)
		if first or target < value.Value then
			first = false
			value.Value = target -- première valeur ou baisse (achat) : affichage immédiat
			label.Text = format(target)
		else
			Kit.tween(value, 0.4, { Value = target })
		end
	end
end

-- Boutons -----------------------------------------------------------------------------------------------

export type ButtonOptions = {
	color: Color3?,
	textColor: Color3?,
	font: Enum.Font?,
	maxText: number?,
	maid: Maid?,
	onClick: (() -> ())?,
	minWidth: number?,
}

local function darker(color: Color3, amount: number): Color3
	local h, s, v = color:ToHSV()
	return Color3.fromHSV(h, s, math.max(0, v - amount))
end
Kit.darker = darker

-- Retour visuel d'un bouton : léger grossissement au survol (PC), rebond à l'appui (tous).
-- Les connexions vivent sur le bouton : elles partent avec lui quand il est détruit.
function Kit.feedback(button: GuiButton)
	local scale = button:FindFirstChildOfClass("UIScale") or Kit.new("UIScale", { Parent = button })
	local hovered = false
	button.MouseEnter:Connect(function()
		if not UserInputService.MouseEnabled then
			return -- tactile : pas de survol
		end
		hovered = true
		Kit.tween(scale, 0.15, { Scale = 1.05 }, Enum.EasingStyle.Quint)
	end)
	button.MouseLeave:Connect(function()
		hovered = false
		Kit.tween(scale, 0.15, { Scale = 1 }, Enum.EasingStyle.Quint)
	end)
	button.MouseButton1Down:Connect(function()
		Kit.tween(scale, 0.07, { Scale = 0.92 })
	end)
	button.MouseButton1Up:Connect(function()
		Kit.tween(scale, 0.25, { Scale = if hovered then 1.05 else 1 }, Enum.EasingStyle.Back)
	end)
end

-- Bouton « bonbon » : couleur vive, reflet brillant sur le haut, taches de lumière, contour foncé épais,
-- petit rebond à l'appui, 44 px minimum. Le dégradé est multiplicatif : Kit.paint n'a qu'à changer la couleur.
local GLOSS_GRADIENT = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
	ColorSequenceKeypoint.new(0.5, Color3.new(0.94, 0.94, 0.94)),
	ColorSequenceKeypoint.new(0.51, Color3.new(0.82, 0.82, 0.82)),
	ColorSequenceKeypoint.new(1, Color3.new(0.88, 0.88, 0.88)),
})

function Kit.button(parent: Instance, text: string, opts: ButtonOptions?): TextButton
	local o: ButtonOptions = opts or {}
	local color = o.color or Theme.Amber
	local button = Kit.new("TextButton", {
		BackgroundColor3 = color,
		AutoButtonColor = true,
		Text = text,
		Font = o.font or Theme.TitleFont,
		TextColor3 = o.textColor or Theme.White,
		TextScaled = true,
		TextWrapped = true,
		TextStrokeTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Parent = parent,
	})
	Kit.corner(button, 0.18)
	Kit.stroke(button, color:Lerp(Theme.White, 0.18), 1, 0.55)
	Kit.new("UIGradient", { Rotation = 90, Color = GLOSS_GRADIENT, Parent = button })
	Kit.new("UITextSizeConstraint", { MaxTextSize = o.maxText or 26, MinTextSize = 7, Parent = button })
	Kit.new("UIPadding", {
		PaddingLeft = UDim.new(0.06, 0),
		PaddingRight = UDim.new(0.06, 0),
		PaddingTop = UDim.new(0.1, 0),
		PaddingBottom = UDim.new(0.1, 0),
		Parent = button,
	})
	Kit.touch(button, o.minWidth)
	Kit.feedback(button)
	if o.onClick then
		local conn = button.Activated:Connect(o.onClick)
		if o.maid then
			o.maid:add(conn)
		end
	end
	return button
end

-- Icône 3D : ReplicatedStorage.Assets.Icons.<name> dans un ViewportFrame qui flotte doucement.
-- Si le modèle manque (pas encore généré), on affiche l'emoji à la place.
function Kit.icon(parent: Instance, name: string?, emoji: string, props: { [string]: any }): GuiObject
	local assets = ReplicatedStorage:FindFirstChild("Assets")
	local folder = assets and assets:FindFirstChild("Icons")
	local source = if name and folder then folder:FindFirstChild(name) else nil
	if not (source and source:IsA("Model")) then
		return Kit.label(parent, emoji, props, 40)
	end
	local viewport: ViewportFrame = Kit.new("ViewportFrame", {
		Name = "Icon3D",
		BackgroundTransparency = 1,
		Ambient = Color3.fromRGB(190, 190, 190),
		LightColor = Color3.new(1, 1, 1),
		LightDirection = Vector3.new(-0.6, -1, 0.8),
		Parent = parent,
	})
	for key, value in props do
		(viewport :: any)[key] = value
	end
	local model = source:Clone()
	model.Parent = viewport
	local box, size = model:GetBoundingBox()
	local radius = math.max(size.X, size.Y, size.Z)
	local camera = Kit.new("Camera", { FieldOfView = 30, Parent = viewport })
	-- Vue de face légèrement plongeante ; chaque modèle est tourné face caméra (-Z) dans Assets.Icons.
	camera.CFrame = CFrame.lookAt(box.Position + Vector3.new(radius * 0.35, radius * 0.45, -radius * 2.1), box.Position)
	viewport.CurrentCamera = camera
	-- Flottement : tween moteur en boucle, pas de code par image.
	-- Icônes statiques : aucun tween permanent dans les menus repliés.
	return viewport
end

-- Change la couleur d'un bouton Kit (et sa bordure assortie).
function Kit.paint(button: GuiObject, color: Color3)
	button.BackgroundColor3 = color
	local stroke = button:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Color = darker(color, 0.35)
	end
end

-- Panneaux ------------------------------------------------------------------------------------------------

-- Panneau parchemin à bord de pierre et ombre douce. Renvoie (support, corps) :
-- le support se place et s'anime, le contenu va dans le corps.
function Kit.panel(parent: Instance, props: { [string]: any }?, color: Color3?, radius: number?): (Frame, Frame)
	local holder = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = parent })
	for key, value in props or {} do
		(holder :: any)[key] = value
	end
	local shadow = Kit.new("Frame", {
		Name = "Shadow",
		BackgroundColor3 = Theme.Black,
		BackgroundTransparency = 0.7,
		Position = UDim2.fromOffset(0, 5),
		Size = UDim2.fromScale(1, 1),
		Parent = holder,
	})
	Kit.corner(shadow, radius or 0.06)
	local body = Kit.new("Frame", {
		Name = "Body",
		BackgroundColor3 = color or Theme.Parchment,
		Size = UDim2.fromScale(1, 1),
		Parent = holder,
	})
	Kit.corner(body, radius or 0.06)
	Kit.stroke(body, Theme.Stone, 1, 0.35)
	-- Léger dégradé pour un aspect de vieux papier.
	Kit.new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(200, 220, 245)),
		Parent = body,
	})
	return holder, body
end

-- Ligne de tableau (hauteur fixe en px logiques, pour les listes défilantes).
export type Cell = {
	text: string,
	width: number, -- part de la largeur
	align: Enum.TextXAlignment?,
	color: Color3?,
	font: Enum.Font?,
}

function Kit.row(parent: Instance, cells: { Cell }, order: number, height: number?, background: Color3?): Frame
	local row = Kit.new("Frame", {
		BackgroundColor3 = background or Theme.Parchment,
		BackgroundTransparency = if background then 0 else 1,
		LayoutOrder = order,
		Size = UDim2.new(1, 0, 0, height or 28),
		Parent = parent,
	})
	if background then
		Kit.corner(row, 0.25)
	end
	local x = 0.01
	for _, cell in cells do
		Kit.label(row, cell.text, {
			Position = UDim2.fromScale(x, 0.1),
			Size = UDim2.fromScale(cell.width - 0.01, 0.8),
			TextXAlignment = cell.align or Enum.TextXAlignment.Left,
			TextColor3 = cell.color or Theme.Ink,
			Font = cell.font or Theme.BodyFont,
		}, 20)
		x += cell.width
	end
	return row
end

-- Icône 2D d'un dé : carré arrondi coloré + 5 points. Renvoie la fonction qui change sa couleur.
function Kit.dieIcon(parent: Instance, color: Color3?): (Color3) -> ()
	local face = Kit.new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		Rotation = -8,
		Parent = parent,
	})
	Kit.aspect(face, 1, true)
	Kit.corner(face, 0.22)
	local stroke = Kit.stroke(face, Theme.StoneDark, 2)
	for _, p in
		{
			Vector2.new(0.25, 0.25),
			Vector2.new(0.75, 0.25),
			Vector2.new(0.5, 0.5),
			Vector2.new(0.25, 0.75),
			Vector2.new(0.75, 0.75),
		}
	do
		local pip = Kit.new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme.White,
			Position = UDim2.fromScale(p.X, p.Y),
			Size = UDim2.fromScale(0.18, 0.18),
			Parent = face,
		})
		Kit.corner(pip, 0.5)
	end
	local function paint(c: Color3)
		face.BackgroundColor3 = c
		stroke.Color = darker(c, 0.4)
	end
	paint(color or Theme.Stone)
	return paint
end

-- Formats -------------------------------------------------------------------------------------------------

Kit.big = Odds.formatBig
Kit.percent = Odds.formatPercent

-- Entier groupé par milliers : 1234567 -> « 1 234 567 ».
function Kit.group(n: number): string
	local s = tostring(math.floor(math.abs(n)))
	local out = s:reverse():gsub("(%d%d%d)", "%1 "):reverse()
	out = out:gsub("^ ", "")
	return (if n < 0 then "-" else "") .. out
end

-- Nombre décimal court à la française : 1.25 -> « 1,25 », 12 -> « 12 ».
function Kit.decimal(x: number): string
	local text = string.format("%.2f", x):gsub("0+$", ""):gsub("%.$", "")
	return (text:gsub("%.", ","))
end

-- Multiplicateur : « x1,25 », « x1 234 », « x3,4 M ».
function Kit.mult(x: number): string
	if x >= 1e6 then
		return "x" .. Odds.formatBig(x)
	elseif x >= 100 then
		return "x" .. Kit.group(x + 0.5)
	end
	return "x" .. Kit.decimal(x)
end

-- Raretés et dinos ------------------------------------------------------------------------------------------

local dinoById: { [string]: Dinos.Dino } = {}
for _, dino in Dinos do
	dinoById[dino.id] = dino
end
Kit.dinoById = dinoById

function Kit.rarityOf(dinoId: string): Rarities.Rarity
	local dino = dinoById[dinoId]
	return if dino then Rarities[dino.rarity] else Rarities.common
end

-- Cherche `id` dans une liste de config ({ id, displayName, ... }).
function Kit.find(list: { any }, id: string?): any
	if id == nil then
		return nil
	end
	for _, entry in list do
		if entry.id == id then
			return entry
		end
	end
	return nil
end

-- Contexte des bonus vu du client, pour l'AFFICHAGE seulement (revenu/s, prix) : le client ne connaît ni les
-- passes ni les amis présents, donc ces deux bonus sont absents ici (le serveur reste la référence).
function Kit.clientContext(): Bonuses.Context
	local eventId = Workspace:GetAttribute("ServerEvent")
	return {
		ownedPasses = {},
		eventId = if type(eventId) == "string" and eventId ~= "" then eventId else nil,
		now = os.time(),
		friendCount = 0,
	}
end

-- Revenu par seconde « propre » d'un exemplaire avec les multiplicateurs globaux connus du client (hors socle).
function Kit.instanceIncome(data: Types.ProfileData, instance: Types.DinoInstance): number
	return Bonuses.instanceIncome(instance) * Bonuses.globalCoinsMultiplier(data, Kit.clientContext())
end

-- Anime un UIGradient selon l'effet de la rareté (reflet turquoise ou arc-en-ciel). Rien pour « none ».
function Kit.rarityEffect(target: Instance, rarity: Rarities.Rarity, maid: Maid)
	if rarity.effect == "none" then
		return
	end
	local gradient = Kit.new("UIGradient", { Parent = target })
	if rarity.effect == "rainbow" then
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHex("#FF5252")),
			ColorSequenceKeypoint.new(0.2, Color3.fromHex("#FFD740")),
			ColorSequenceKeypoint.new(0.4, Color3.fromHex("#69F0AE")),
			ColorSequenceKeypoint.new(0.6, Color3.fromHex("#40C4FF")),
			ColorSequenceKeypoint.new(0.8, Color3.fromHex("#E040FB")),
			ColorSequenceKeypoint.new(1, Color3.fromHex("#FF5252")),
		})
	else
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, rarity.color),
			ColorSequenceKeypoint.new(0.45, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(0.55, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, rarity.color),
		})
	end
	maid:add(Kit.loop(gradient, 4, { Rotation = 360 }))
end

return Kit
