--!strict
-- Révélation d'un tirage (le moment fort du jeu). Trois niveaux selon la rareté renvoyée par le serveur :
--   Commun → Rare : la carte glisse vers le haut (0,4 s) avec une petite secousse.
--   Épique et + : arène 3D façon « crate opening » (laser, dé qui tremble, explosion, zoom sur le dino), ~5 s.
--   Mythique et + : en plus, caméra qui tremble, confettis et grand « 1 sur X ». Un clic passe l'animation (la petite carte s'affiche alors).
-- Les grandes révélations passent en file ; l'Auto-Lancer attend (isBusy).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Dice = require(Shared.Config.Dice)
local Dinos = require(Shared.Config.Dinos)
local Mutations = require(Shared.Config.Mutations)
local Types = require(Shared.Types)

local DataController = require(script.Parent.Parent.Controllers.DataController)
local DinoModels = require(script.Parent.Parent.DinoModels)
local DinoView = require(script.Parent.DinoView)
local Kit = require(script.Parent.Kit)
local Theme = require(script.Parent.Theme)

local SMALL_HOLD = 1.8
local BIG_HOLD = 2.6
local MYTHIC_HOLD = 3.6

local root: Frame
local busy = false
local queue: { Types.RollResult } = {}
local smallMaid: Kit.Maid? = nil

local RollReveal = {}

-- Carte ---------------------------------------------------------------------------------------------------

local function mutationText(result: Types.RollResult): string
	local parts = {}
	if result.size ~= Mutations.defaultId then
		local size = Kit.find(Mutations.Sizes, result.size)
		table.insert(parts, if size then size.displayName else result.size)
	end
	if result.skin ~= Mutations.defaultId then
		local skin = Kit.find(Mutations.Skins, result.skin)
		table.insert(parts, "Peau " .. (if skin then skin.displayName else result.skin))
	end
	return if #parts > 0 then table.concat(parts, " · ") else "Sans mutation"
end

local CLOVER_COLORS: { [number]: Color3 } = {
	[2] = Color3.fromHex("#7BC96F"),
	[4] = Color3.fromHex("#43A047"),
	[8] = Color3.fromHex("#00BFA5"),
	[16] = Color3.fromHex("#FFD54A"),
	[32] = Color3.fromHex("#FF6E40"),
}

-- Carte d'un résultat. `holder` est déjà placé/dimensionné par l'appelant.
local function buildCard(parent: Instance, result: Types.RollResult, maid: Kit.Maid, props: { [string]: any }): Frame
	local data: Types.ProfileData = DataController:Get()
	local dino = Kit.dinoById[result.dinoId]
	local rarity = Kit.rarityOf(result.dinoId)

	local holder, body = Kit.panel(parent, props, nil, 0.08)
	maid:add(holder)
	Kit.aspect(holder, 1.65, true)
	local stroke = body:FindFirstChildOfClass("UIStroke") :: UIStroke
	stroke.Color = rarity.color
	stroke.Thickness = 4
	Kit.rarityEffect(stroke, rarity, maid)

	-- Vue 3D dans un médaillon.
	local medal = Kit.new("Frame", {
		BackgroundColor3 = Kit.darker(rarity.color, 0.45),
		BackgroundTransparency = 0.2,
		Position = UDim2.fromScale(0.03, 0.08),
		Size = UDim2.fromScale(0.38, 0.84),
		Parent = body,
	})
	Kit.corner(medal, 0.12)
	Kit.stroke(medal, rarity.color, 2)
	local view = DinoView.new(medal, result.dinoId, {
		rotate = true,
		size = result.size,
		skin = result.skin,
		roar = rarity.order >= 4, -- Épique et +
	})
	maid:add(view.destroy)

	local name = Kit.title(body, if dino then dino.displayName else result.dinoId, {
		Position = UDim2.fromScale(0.44, 0.05),
		Size = UDim2.fromScale(0.54, 0.22),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = rarity.color,
		TextStrokeTransparency = 0,
		TextStrokeColor3 = Theme.Ink,
	}, 40)
	Kit.rarityEffect(name, rarity, maid)

	local pill = Kit.new("Frame", {
		BackgroundColor3 = rarity.color,
		Position = UDim2.fromScale(0.44, 0.29),
		Size = UDim2.fromScale(0.3, 0.12),
		Parent = body,
	})
	Kit.corner(pill, 0.5)
	Kit.title(pill, rarity.displayName, { TextColor3 = Theme.White, TextStrokeTransparency = 0.4 }, 22)

	Kit.label(body, mutationText(result), {
		Position = UDim2.fromScale(0.44, 0.43),
		Size = UDim2.fromScale(0.54, 0.11),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Theme.InkSoft,
	}, 20)

	Kit.number(body, `1 sur {Kit.big(result.oneInDisplayed)}`, {
		Position = UDim2.fromScale(0.44, 0.55),
		Size = UDim2.fromScale(0.54, 0.17),
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamBlack,
	}, 34)

	local income = Kit.instanceIncome(data, {
		dinoId = result.dinoId,
		size = result.size,
		skin = result.skin,
		instinct = "none",
		obtainedAt = 0,
		locked = false,
	})
	Kit.number(body, `+{Kit.big(income)} Fossiles/s`, {
		Position = UDim2.fromScale(0.44, 0.74),
		Size = UDim2.fromScale(0.54, 0.14),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Theme.LeafDark,
	}, 26)

	if result.clover > 1 then
		local badge = Kit.new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = CLOVER_COLORS[result.clover] or Theme.Leaf,
			Position = UDim2.fromScale(0.05, 0.08),
			Size = UDim2.fromScale(0.3, 0.3),
			Rotation = -12,
			Parent = body,
		})
		Kit.aspect(badge, 1, true)
		Kit.corner(badge, 0.5)
		Kit.stroke(badge, Theme.White, 2)
		Kit.title(badge, `🍀\nx{result.clover}`, { TextColor3 = Theme.White, TextStrokeTransparency = 0.3 }, 22)
	end

	if result.isNewInIndex then
		local ribbon = Kit.new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme.Gold,
			Position = UDim2.fromScale(0.9, 0.04),
			Size = UDim2.fromScale(0.3, 0.14),
			Rotation = 10,
			Parent = body,
		})
		Kit.corner(ribbon, 0.3)
		Kit.stroke(ribbon, Theme.AmberDark, 2)
		Kit.title(ribbon, "NOUVEAU !", { TextColor3 = Theme.Ink }, 22)
	end

	return holder
end

-- Petite carte (Commun → Rare) ---------------------------------------------------------------------------

local function showSmall(result: Types.RollResult)
	if smallMaid then
		smallMaid:clean()
	end
	local maid = Kit.maid()
	smallMaid = maid
	local card = buildCard(root, result, maid, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 1.4),
		Size = UDim2.fromScale(1, 0.38),
	})
	Kit.tween(card, 0.4, { Position = UDim2.fromScale(0.5, 0.33) }, Enum.EasingStyle.Back)
	maid:add(task.delay(0.4, function()
		-- Petite secousse à l'arrivée.
		for _, angle in { -4, 4, -2, 1, 0 } do
			Kit.tween(card, 0.05, { Rotation = angle })
			task.wait(0.05)
		end
	end))
	maid:add(task.delay(SMALL_HOLD, function()
		Kit.tween(card, 0.3, { Position = UDim2.fromScale(0.5, 1.4) }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		task.wait(0.3)
		if smallMaid == maid then
			smallMaid = nil
		end
		maid:clean()
	end))
end

-- Outils des grandes révélations ------------------------------------------------------------------------

-- Fond plein écran cliquable (déborde des marges pour couvrir toute la surface).
local function backdrop(maid: Kit.Maid, color: Color3, transparency: number): TextButton
	local b = Kit.new("TextButton", {
		AutoButtonColor = false,
		Text = "",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(3, 3),
		BackgroundColor3 = color,
		BackgroundTransparency = transparency,
		Parent = root,
	})
	maid:add(b)
	return b
end

-- Arène façon « crate opening » : écran noir + laser, le dé équipé tremble sur un socle, explosion de couleurs,
-- d'autres dinos apparaissent autour, puis la caméra plonge sur le dino gagné. Tout vit dans un ViewportFrame
-- (rien dans le Workspace).

local ORANGE = Color3.fromRGB(255, 140, 50)
local PEDESTAL_TOP = 1.4
local SPARK_COLORS = {
	Color3.fromRGB(255, 60, 60),
	Color3.fromRGB(255, 160, 40),
	Color3.fromRGB(255, 235, 60),
	Color3.fromRGB(80, 230, 90),
	Color3.fromRGB(60, 220, 255),
	Color3.fromRGB(110, 90, 255),
	Color3.fromRGB(255, 80, 210),
}

local function part(parent: Instance, props: { [string]: any }): Part
	props.Anchored = true
	props.Parent = parent
	return Kit.new("Part", props)
end

-- Socle cylindrique vertical avec un anneau néon sur le dessus.
local function pedestal(parent: Instance, pos: Vector3, diameter: number, height: number, ringColor: Color3): Part
	local up = CFrame.Angles(0, 0, math.pi / 2)
	part(parent, {
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(height, diameter, diameter),
		CFrame = CFrame.new(pos + Vector3.new(0, height / 2, 0)) * up,
		Color = Color3.fromRGB(205, 205, 212),
		Material = Enum.Material.SmoothPlastic,
	})
	return part(parent, {
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.25, diameter + 0.6, diameter + 0.6),
		CFrame = CFrame.new(pos + Vector3.new(0, height - 0.1, 0)) * up,
		Color = ringColor,
		Material = Enum.Material.Neon,
	})
end

-- Met le modèle à la taille `height` et pose le bas de sa boîte sur `ground`. Renvoie son pivot.
local function fit(model: Model, height: number, ground: Vector3): CFrame
	local _, size = model:GetBoundingBox()
	model:ScaleTo(model:GetScale() * height / math.max(size.X, size.Y, size.Z, 0.01))
	local box, boxSize = model:GetBoundingBox()
	local target = model:GetPivot() + (ground - (box.Position - Vector3.new(0, boxSize.Y / 2, 0)))
	model:PivotTo(target)
	return target
end

-- Le dé équipé (cube + un point blanc par face) en modèle 3D.
local function dieModel(): Model
	local data: Types.ProfileData = DataController:Get()
	local die = Kit.find(Dice, data.EquippedDice) or Dice[1]
	local model = Instance.new("Model")
	model.PrimaryPart = part(model, {
		Size = Vector3.new(2, 2, 2),
		Color = die.color,
		Material = die.material,
	})
	for _, normal in { Vector3.xAxis, -Vector3.xAxis, Vector3.yAxis, -Vector3.yAxis, Vector3.zAxis, -Vector3.zAxis } do
		part(model, {
			Shape = Enum.PartType.Ball,
			Size = Vector3.new(0.5, 0.5, 0.5),
			CFrame = CFrame.new(normal * 0.9),
			Color = Color3.new(1, 1, 1),
			Material = Enum.Material.SmoothPlastic,
		})
	end
	return model
end

type Arena = { viewport: ViewportFrame, world: WorldModel, camera: Camera, ring: Part, sides: { Vector3 } }

local function buildArena(maid: Kit.Maid, color: Color3): Arena
	local viewport: ViewportFrame = Kit.new("ViewportFrame", {
		BackgroundColor3 = Color3.fromRGB(30, 10, 12), -- fond rouge sombre, comme la vidéo
		BackgroundTransparency = 0,
		-- Déborde du calque pour couvrir aussi la barre du haut (marges de sécurité).
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1.3, 1.3),
		Ambient = Color3.fromRGB(110, 80, 70),
		LightColor = Color3.fromRGB(255, 200, 150),
		LightDirection = Vector3.new(0.2, -1, 0.4),
		Parent = root,
	})
	maid:add(viewport)
	local camera: Camera = Kit.new("Camera", { FieldOfView = 50, Parent = viewport })
	viewport.CurrentCamera = camera

	local up = CFrame.Angles(0, 0, math.pi / 2)
	part(viewport, {
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.5, 80, 80),
		CFrame = CFrame.new(0, -0.25, 0) * up,
		Color = Color3.fromRGB(46, 26, 22),
		Material = Enum.Material.Slate,
	})
	-- Flaque de lumière orange au sol.
	part(viewport, {
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.05, 34, 34),
		CFrame = CFrame.new(0, 0.03, 0) * up,
		Color = ORANGE,
		Material = Enum.Material.Neon,
		Transparency = 0.88,
	})
	local ring = pedestal(viewport, Vector3.zero, 7, PEDESTAL_TOP, color)

	local sides = {}
	for i = 0, 5 do
		local a = math.rad(-110 + i * 44)
		local pos = Vector3.new(math.sin(a) * 12, 0, math.cos(a) * 12)
		pedestal(viewport, pos, 4.5, 1, ORANGE)
		table.insert(sides, pos + Vector3.new(0, 1, 0))
	end

	-- Guirlande de lampes et deux grandes arches derrière le socle.
	for i = 0, 11 do
		local a = math.rad(-100 + i * (200 / 11))
		part(viewport, {
			Shape = Enum.PartType.Ball,
			Size = Vector3.new(1.3, 1.3, 1.3),
			CFrame = CFrame.new(math.sin(a) * 24, 7, math.cos(a) * 24),
			Color = Color3.fromRGB(255, 190, 90),
			Material = Enum.Material.Neon,
		})
	end
	for _, arch in { { 16, 20 }, { 21, 27 } } do
		local radius, z = arch[1], arch[2]
		for k = 0, 23 do
			local theta = math.pi * k / 23
			part(viewport, {
				Size = Vector3.new(1.4, radius * math.pi / 22, 1.4),
				CFrame = CFrame.new(math.cos(theta) * radius, math.sin(theta) * radius, z) * CFrame.Angles(0, 0, theta),
				Color = if k % 3 == 0 then ORANGE else Color3.fromRGB(150, 50, 30),
				Material = if k % 3 == 0 then Enum.Material.Neon else Enum.Material.SmoothPlastic,
			})
		end
	end

	-- Les dinos vont dans un WorldModel : sans lui, le squelette ne déforme pas le maillage dans un ViewportFrame.
	local world: WorldModel = Kit.new("WorldModel", { Parent = viewport })
	return { viewport = viewport, world = world, camera = camera, ring = ring, sides = sides }
end

-- Petits cubes néon projetés en l'air depuis `origin` (animés par l'appelant).
local function burst(
	parent: Instance,
	origin: Vector3,
	count: number,
	colors: { Color3 }
): { { part: Part, velocity: Vector3 } }
	local sparks = {}
	for _ = 1, count do
		local a = math.random() * math.pi * 2
		local speed = 8 + math.random() * 12
		table.insert(sparks, {
			part = part(parent, {
				Size = Vector3.new(0.45, 0.45, 0.45),
				CFrame = CFrame.new(origin) * CFrame.Angles(math.random() * 6, math.random() * 6, 0),
				Color = colors[math.random(1, #colors)],
				Material = Enum.Material.Neon,
			}),
			velocity = Vector3.new(math.cos(a) * speed, 6 + math.random() * 10, math.sin(a) * speed),
		})
	end
	return sparks
end

-- Flash de couleur (simple cadre : ne bloque pas le clic qui passe l'animation).
local function flash(maid: Kit.Maid, color: Color3)
	local f = Kit.new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(3, 3),
		BackgroundColor3 = color,
		BackgroundTransparency = 0,
		Parent = root,
	})
	maid:add(f)
	Kit.tween(f, 0.45, { BackgroundTransparency = 1 })
end

local function confetti(maid: Kit.Maid, color: Color3)
	local layer = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = root })
	maid:add(layer)
	local palette = { color, Theme.Gold, Theme.White, Theme.Leaf, Theme.Sky, Theme.Lava }
	for _ = 1, 70 do
		local piece = Kit.new("Frame", {
			BackgroundColor3 = palette[math.random(1, #palette)],
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(math.random(), -0.05 - math.random() * 0.3),
			Size = UDim2.fromOffset(math.random(6, 11), math.random(10, 16)),
			Rotation = math.random(0, 360),
			Parent = layer,
		})
		local fall = 1.6 + math.random() * 1.4
		Kit.tween(piece, fall, {
			Position = UDim2.fromScale(piece.Position.X.Scale + (math.random() - 0.5) * 0.3, 1.1),
			Rotation = piece.Rotation + math.random(-540, 540),
		}, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
	end
end

-- Tremblement de caméra (après la caméra par défaut, chaque image).
local SHAKE_NAME = "DinoRevealShake"
local function shakeCamera(maid: Kit.Maid, seconds: number, strength: number)
	local start = os.clock()
	RunService:BindToRenderStep(SHAKE_NAME, Enum.RenderPriority.Camera.Value + 1, function()
		local camera = Workspace.CurrentCamera
		local k = 1 - (os.clock() - start) / seconds
		if k <= 0 or not camera then
			RunService:UnbindFromRenderStep(SHAKE_NAME)
			return
		end
		local a = strength * k
		camera.CFrame *= CFrame.Angles(
			math.rad((math.random() - 0.5) * a),
			math.rad((math.random() - 0.5) * a),
			math.rad((math.random() - 0.5) * a * 0.5)
		)
	end)
	maid:add(function()
		RunService:UnbindFromRenderStep(SHAKE_NAME)
	end)
end

-- Grandes révélations -----------------------------------------------------------------------------------

-- Joue une grande révélation et attend sa fin (fin naturelle ou clic).
local function playBig(result: Types.RollResult)
	local rarity = Kit.rarityOf(result.dinoId)
	local mythic = rarity.order >= 6
	local maid = Kit.maid()
	local finished = false
	local skipped = false
	local sequence: thread? = nil

	local function finish()
		if finished then
			return
		end
		finished = true
		if sequence and sequence ~= coroutine.running() then
			pcall(task.cancel, sequence)
		end
		maid:clean()
	end

	local back = backdrop(maid, Theme.Black, 1)
	maid:add(back.Activated:Connect(function()
		skipped = true
		finish()
	end))

	sequence = task.spawn(function()
		local dino = Kit.dinoById[result.dinoId]

		-- 1. Écran noir, un laser rouge traverse l'écran.
		back.BackgroundTransparency = 0
		local laser = Kit.new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(0, 0, 0, 3),
			BackgroundColor3 = Color3.fromRGB(255, 40, 70),
			BorderSizePixel = 0,
			Parent = root,
		})
		maid:add(laser)
		Kit.tween(laser, 0.35, { Size = UDim2.new(1.4, 0, 0, 3) })
		task.wait(0.45)
		laser:Destroy()

		-- 2. L'arène : le dé tremble de plus en plus fort sur le socle central.
		local arena = buildArena(maid, rarity.color)
		local die: Model? = dieModel()
		local dieBase = fit(die :: Model, 2.4, Vector3.new(0, PEDESTAL_TOP + 0.6, 0));
		(die :: Model).Parent = arena.viewport
		local sparks: { { part: Part, velocity: Vector3 } } = {}
		local spinning: { { model: Model, base: CFrame } } = {}
		local t0 = os.clock()
		local zoomAt = math.huge
		maid:add(RunService.RenderStepped:Connect(function(dt)
			local t = os.clock() - t0
			if die then
				local shake = math.min(t / 1.5, 1) * 0.35
				die:PivotTo(
					dieBase
						* CFrame.new(
							(math.random() - 0.5) * shake,
							0.25 + math.sin(t * 6) * 0.25,
							(math.random() - 0.5) * shake
						)
						* CFrame.Angles(0, t * (2 + t * 5), math.sin(t * 9) * shake)
				)
			end
			arena.ring.Transparency = 0.25 + 0.25 * math.sin(t * 10)
			for _, s in sparks do
				s.velocity -= Vector3.new(0, 28 * dt, 0)
				s.part.CFrame = (s.part.CFrame + s.velocity * dt) * CFrame.Angles(dt * 8, dt * 6, 0)
				s.part.Transparency = math.min(s.part.Transparency + dt * 0.7, 1)
			end
			for _, m in spinning do
				m.model:PivotTo(m.base * CFrame.Angles(0, t * 1.2, 0))
			end
			-- Caméra : lent travelling autour de l'arène, puis plongée sur le socle central.
			local orbit = -0.3 + t * 0.12
			-- Près du dé au début (comme la caisse de la vidéo), on recule pour l'explosion.
			local radius = 13 + 13 * math.clamp((t - 1.4) / 0.5, 0, 1)
			local widePos = Vector3.new(math.sin(orbit) * radius, 4 + radius * 0.25, -math.cos(orbit) * radius)
			local k = TweenService:GetValue(
				math.clamp((t - zoomAt) / 0.7, 0, 1),
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			)
			local pos = widePos:Lerp(Vector3.new(0, 7, -15), k)
			local look = Vector3.new(0, 2, 0):Lerp(Vector3.new(0, 1.2, 0), k) -- socle au-dessus de l'étiquette
			arena.camera.CFrame = CFrame.lookAt(pos, look)
		end))
		task.wait(1.5)

		-- 3. Le dé explose : flash, gerbe de couleurs, d'autres dinos apparaissent autour.
		flash(maid, rarity.color);
		(die :: Model):Destroy()
		die = nil
		sparks = burst(arena.viewport, Vector3.new(0, PEDESTAL_TOP + 1.5, 0), 45, SPARK_COLORS)
		local others = {}
		for _, d in Dinos do
			if d.id ~= result.dinoId then
				table.insert(others, d.id)
			end
		end
		for _, pos in arena.sides do
			if #others == 0 then
				break
			end
			local decoy = DinoView.model(table.remove(others, math.random(1, #others)))
			local base = fit(decoy, 2.6, pos)
			decoy.Parent = arena.world
			table.insert(spinning, { model = decoy, base = base })
		end
		task.wait(1.2)

		-- 4. Le dino gagné apparaît sur le socle central, la caméra plonge dessus.
		local winner = DinoView.model(result.dinoId, result.size, result.skin)
		local winnerBase = fit(winner, 3, Vector3.new(0, PEDESTAL_TOP, 0))
		winner.Parent = arena.world
		DinoModels.play(winner, "Roar", { thenClip = "Idle" }) -- sans effet sur le cube de repli
		table.insert(spinning, { model = winner, base = winnerBase })
		for _, s in burst(arena.viewport, Vector3.new(0, PEDESTAL_TOP + 2, 0), 25, { rarity.color, Theme.White }) do
			table.insert(sparks, s)
		end
		zoomAt = os.clock() - t0
		task.wait(0.7)

		-- 5. Étiquette sous le socle : rareté, nom, mutations, « 1 sur X », revenu.
		local tag = Kit.title(root, rarity.displayName, {
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.fromScale(0.5, 0.64),
			Size = UDim2.fromScale(0.6, 0.09),
			TextColor3 = rarity.color,
			TextStrokeTransparency = 0,
		}, 60)
		maid:add(tag)
		Kit.rarityEffect(tag, rarity, maid)
		local nameLabel =
			Kit.title(root, (if dino then dino.displayName else result.dinoId) .. "  ·  " .. mutationText(result), {
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0.74),
				Size = UDim2.fromScale(0.8, 0.06),
				TextColor3 = Theme.White,
				TextStrokeTransparency = 0.2,
			}, 34)
		maid:add(nameLabel)
		local oneIn = Kit.title(root, `1 sur {Kit.big(result.oneInDisplayed)}`, {
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.fromScale(0.5, 0.81),
			Size = UDim2.fromScale(0.8, if mythic then 0.12 else 0.08),
			TextColor3 = Theme.White,
			TextStrokeTransparency = 0,
			TextStrokeColor3 = rarity.color,
		}, if mythic then 90 else 50)
		maid:add(oneIn)
		local income = Kit.instanceIncome(DataController:Get(), {
			dinoId = result.dinoId,
			size = result.size,
			skin = result.skin,
			instinct = "none",
			obtainedAt = 0,
			locked = false,
		})
		local incomeLabel = Kit.number(root, `+{Kit.big(income)} Fossiles/s`, {
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.fromScale(0.5, if mythic then 0.93 else 0.89),
			Size = UDim2.fromScale(0.6, 0.05),
			TextColor3 = Theme.Leaf,
		}, 30)
		maid:add(incomeLabel)
		for _, label in { tag, nameLabel, oneIn, incomeLabel } do
			local pop = Kit.new("UIScale", { Scale = 0.3, Parent = label })
			Kit.tween(pop, 0.4, { Scale = 1 }, Enum.EasingStyle.Back)
		end
		if mythic then
			shakeCamera(maid, 0.8, 6)
			confetti(maid, rarity.color)
		end
		task.wait(if mythic then MYTHIC_HOLD else BIG_HOLD)
		finish()
	end)

	while not finished do
		task.wait()
	end
	if skipped then
		showSmall(result)
	end
end

local function runQueue()
	busy = true
	while #queue > 0 do
		local result = table.remove(queue, 1) :: Types.RollResult
		playBig(result)
	end
	busy = false
end

-- API -----------------------------------------------------------------------------------------------------

function RollReveal.init(layerRoot: Frame)
	root = layerRoot
end

-- Vrai tant qu'une grande révélation joue ou attend.
function RollReveal.isBusy(): boolean
	return busy or #queue > 0
end

function RollReveal.play(result: Types.RollResult)
	if not Kit.dinoById[result.dinoId] then
		return
	end
	if Kit.rarityOf(result.dinoId).order >= 4 then
		table.insert(queue, result)
		if not busy then
			task.spawn(runQueue)
		end
	elseif not busy then
		showSmall(result)
	end
end

return RollReveal
