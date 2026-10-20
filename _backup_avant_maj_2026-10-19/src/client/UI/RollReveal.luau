--!strict
-- Révélation d'un tirage (le moment fort du jeu). Trois niveaux selon la rareté renvoyée par le serveur :
--   Commun → Rare : la carte glisse vers le haut (0,4 s) avec une petite secousse.
--   Épique / Légendaire : fond assombri, dé qui tourne 1 s, flash de la couleur, carte auréolée.
--   Mythique et + : écran noir 0,3 s, caméra qui tremble, silhouette noire qui se remplit de couleur,
--     grand « 1 sur X », confettis, 3–4 s. Un clic passe l'animation (la petite carte s'affiche alors).
-- Les grandes révélations passent en file ; l'Auto-Lancer attend (isBusy).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Dice = require(Shared.Config.Dice)
local Mutations = require(Shared.Config.Mutations)
local Types = require(Shared.Types)

local DataController = require(script.Parent.Parent.Controllers.DataController)
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
	local view = DinoView.new(medal, result.dinoId, { rotate = true })
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
	Kit.number(body, `+{Kit.big(income)} Pièces/s`, {
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

-- Dé équipé qui tourne dans un ViewportFrame.
local function spinningDie(maid: Kit.Maid): Frame
	local data: Types.ProfileData = DataController:Get()
	local die = Kit.find(Dice, data.EquippedDice) or Dice[1]
	local holder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.5, 0.5),
		Parent = root,
	})
	maid:add(holder)
	Kit.aspect(holder, 1, true)
	local viewport = Kit.new("ViewportFrame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Ambient = Color3.fromRGB(180, 180, 180),
		LightDirection = Vector3.new(-1, -1, -1),
		Parent = holder,
	})
	local cube = Kit.new("Part", {
		Size = Vector3.new(2, 2, 2),
		Color = die.color,
		Material = die.material,
		Anchored = true,
		Parent = viewport,
	})
	-- Points blancs sur chaque face (un par face, simple et lisible même petit).
	for _, normal in { Vector3.xAxis, -Vector3.xAxis, Vector3.yAxis, -Vector3.yAxis, Vector3.zAxis, -Vector3.zAxis } do
		local pip = Kit.new("Part", {
			Shape = Enum.PartType.Ball,
			Size = Vector3.new(0.5, 0.5, 0.5),
			Color = Color3.new(1, 1, 1),
			Material = Enum.Material.SmoothPlastic,
			Anchored = true,
			CFrame = CFrame.new(normal * 0.9),
			Parent = cube,
		})
		pip:SetAttribute("Offset", normal * 0.9)
	end
	local camera = Kit.new("Camera", {
		CFrame = CFrame.lookAt(Vector3.new(0, 1, -6), Vector3.zero),
		FieldOfView = 40,
		Parent = viewport,
	})
	viewport.CurrentCamera = camera
	local t = 0
	maid:add(RunService.RenderStepped:Connect(function(dt)
		t += dt
		local rotation = CFrame.Angles(t * 9, t * 13, t * 5)
		cube.CFrame = rotation
		for _, pip in cube:GetChildren() do
			if pip:IsA("BasePart") then
				pip.CFrame = rotation * CFrame.new(pip:GetAttribute("Offset") or Vector3.zero)
			end
		end
	end))
	local pop = Kit.new("UIScale", { Scale = 0.3, Parent = holder })
	Kit.tween(pop, 0.5, { Scale = 1 }, Enum.EasingStyle.Back)
	return holder
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

-- Auréole : disque de la couleur de rareté + rayons qui tournent derrière la carte.
local function halo(maid: Kit.Maid, color: Color3, size: number): Frame
	local container = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(size, size),
		Parent = root,
	})
	maid:add(container)
	Kit.aspect(container, 1, true)
	local disc = Kit.new("Frame", {
		BackgroundColor3 = color,
		BackgroundTransparency = 0.55,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.75, 0.75),
		Parent = container,
	})
	Kit.corner(disc, 0.5)
	Kit.new("UIGradient", {
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 1),
		}),
		Parent = disc,
	})
	local rays = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = container })
	for i = 0, 5 do
		Kit.new("Frame", {
			BackgroundColor3 = color,
			BackgroundTransparency = 0.6,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.07, 1),
			Rotation = i * 30,
			Parent = rays,
		})
	end
	-- Tweens en boucle (moteur), pas de boucle Lua par image.
	maid:add(Kit.loop(rays, 14, { Rotation = 360 }))
	disc.BackgroundTransparency = 0.35
	maid:add(Kit.loop(disc, 0.8, { BackgroundTransparency = 0.65 }, true, Enum.EasingStyle.Sine))
	return container
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
		if mythic then
			-- 1. Écran noir.
			back.BackgroundTransparency = 0
			task.wait(0.3)
			-- 2. Caméra qui tremble, silhouette noire qui se remplit de couleur.
			shakeCamera(maid, 0.8, 6)
			Kit.tween(back, 0.6, { BackgroundTransparency = 0.12 })
			halo(maid, rarity.color, 0.95)
			local stage = Kit.new("Frame", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.42),
				Size = UDim2.fromScale(0.62, 0.62),
				Parent = root,
			})
			maid:add(stage)
			Kit.aspect(stage, 1, true)
			local view = DinoView.new(stage, result.dinoId, { rotate = true, silhouette = true, speed = 0.08 })
			maid:add(view.destroy)
			local pop = Kit.new("UIScale", { Scale = 0.6, Parent = stage })
			Kit.tween(pop, 0.8, { Scale = 1 }, Enum.EasingStyle.Back)
			task.wait(0.5)
			Kit.tween(view.frame, 1.2, { ImageColor3 = Color3.new(1, 1, 1) }, Enum.EasingStyle.Sine)
			task.wait(1.1)
			-- 3. Flash, textes, confettis.
			flash(maid, rarity.color)
			local dino = Kit.dinoById[result.dinoId]
			local title = Kit.title(root, `{rarity.displayName} !`, {
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0.03),
				Size = UDim2.fromScale(0.8, 0.12),
				TextColor3 = rarity.color,
				TextStrokeTransparency = 0,
			}, 60)
			maid:add(title)
			Kit.rarityEffect(title, rarity, maid)
			local oneIn = Kit.title(root, `1 sur {Kit.big(result.oneInDisplayed)}`, {
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.fromScale(0.5, 0.97),
				Size = UDim2.fromScale(0.9, 0.17),
				TextColor3 = Theme.White,
				TextStrokeTransparency = 0,
				TextStrokeColor3 = rarity.color,
			}, 90)
			maid:add(oneIn)
			local nameLabel = Kit.title(
				root,
				(if dino then dino.displayName else result.dinoId) .. "  ·  " .. mutationText(result),
				{
					AnchorPoint = Vector2.new(0.5, 1),
					Position = UDim2.fromScale(0.5, 0.8),
					Size = UDim2.fromScale(0.8, 0.07),
					TextColor3 = Theme.White,
					TextStrokeTransparency = 0.2,
				},
				34
			)
			maid:add(nameLabel)
			local punch = Kit.new("UIScale", { Scale = 2.4, Parent = oneIn })
			Kit.tween(punch, 0.45, { Scale = 1 }, Enum.EasingStyle.Back)
			confetti(maid, rarity.color)
			task.wait(MYTHIC_HOLD - 1.9)
		else
			-- 1. Fond assombri + dé qui tourne 1 s.
			Kit.tween(back, 0.25, { BackgroundTransparency = 0.45 })
			local die = spinningDie(maid)
			task.wait(1)
			die.Visible = false
			-- 2. Flash de la couleur, carte auréolée.
			flash(maid, rarity.color)
			halo(maid, rarity.color, 1.05)
			local card = buildCard(root, result, maid, {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(1, 0.58),
			})
			local pop = Kit.new("UIScale", { Scale = 0.3, Parent = card })
			Kit.tween(pop, 0.4, { Scale = 1 }, Enum.EasingStyle.Back)
			task.wait(BIG_HOLD)
		end
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
