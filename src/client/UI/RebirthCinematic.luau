--!strict
-- Cinématique du rebirth au sanctuaire du Phénix (jouée après la confirmation, le serveur a déjà fait le rebirth).
-- Plans, dans l'ordre (≈ 14 s, « Touche pour passer ») :
--   1. plan large du sanctuaire, les braseros s'embrasent ;
--   2. gros plan sur l'emblème du Phénix, étincelles ;
--   3. rayons dorés derrière l'emblème, plan moyen sur le joueur devant l'autel ;
--   4. la caméra tourne autour du joueur, colonnes de feu ;
--   5. flash blanc puis jaune : le joueur brûle, il ne reste qu'un tas de cendres fumant ;
--   6. plan large teinté de rouge : une boule de feu descend de l'emblème et file au sol jusqu'aux cendres ;
--   7. explosion + flash ;
--   8. « REBIRTH » lettre par lettre avec des rayons, le joueur renaît et s'élève dans les flammes ;
--   9. les bonus apparaissent un par un, puis « RENÉ ! » ;
--  10. plan large : « DE TES CENDRES… » / « TA NOUVELLE AVENTURE COMMENCE ! », retour au jeu.
-- Tout est local au joueur (caméra, effets, transparence de son personnage) : les autres ne voient rien.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Plots = require(Shared.Config.Plots)
local Rebirth = require(Shared.Config.Rebirth)

local Kit = require(script.Parent.Kit)
local PhoenixController = require(script.Parent.Parent.Controllers.PhoenixController)

local GOLD = Color3.fromRGB(255, 206, 60)
local INK = Color3.fromRGB(90, 24, 8)

local RebirthCinematic = {}

local playing = false

local function tween(
	instance: Instance,
	seconds: number,
	goal: { [string]: any },
	style: Enum.EasingStyle?,
	direction: Enum.EasingDirection?
): Tween
	local t = TweenService:Create(
		instance,
		TweenInfo.new(seconds, style or Enum.EasingStyle.Sine, direction or Enum.EasingDirection.InOut),
		goal
	)
	t:Play()
	return t
end

local function fxPart(parent: Instance, props: { [string]: any }): Part
	props.Anchored = true
	props.CanCollide = false
	props.CanQuery = false
	props.CanTouch = false
	props.CastShadow = false
	return Kit.new("Part", props)
end

-- Texte arcade doré qui surgit (rebond) au point donné de l'écran.
local function popText(parent: Instance, text: string, position: UDim2, height: number, color: Color3?): TextLabel
	local label = Kit.new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = position,
		Size = UDim2.fromScale(0.9, height),
		Font = Enum.Font.Arcade,
		Text = text,
		TextColor3 = color or GOLD,
		TextStrokeColor3 = INK,
		TextStrokeTransparency = 0,
		TextScaled = true,
		ZIndex = 5,
		Parent = parent,
	})
	local scale = Kit.new("UIScale", { Scale = 0.2, Parent = label })
	tween(scale, 0.35, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	return label
end

local function setCharacterHidden(character: Model, hidden: boolean)
	for _, d in character:GetDescendants() do
		if d:IsA("BasePart") or d:IsA("Decal") then
			(d :: any).LocalTransparencyModifier = if hidden then 1 else 0
		end
	end
end

function RebirthCinematic.play(rebirths: number, closeWindows: () -> ())
	if playing then
		return
	end
	local player = Players.LocalPlayer
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
	local shrine = Workspace:FindFirstChild("RebirthShrine")
	local altar = shrine and shrine:FindFirstChild("Totem") :: BasePart?
	local emblem = shrine and shrine:FindFirstChild("Emblem")
	local disc = emblem and emblem:FindFirstChild("Disc") :: BasePart?
	if not character or not root or not altar or not disc then
		return
	end
	playing = true
	closeWindows()
	local maid = Kit.maid()
	local camera = Workspace.CurrentCamera
	local center = altar.Position + Vector3.new(0, -2.9, 2.5)
	local up = Vector3.yAxis

	-- Le joueur se place devant l'autel, face à l'emblème ; on fige son personnage le temps de la scène.
	local stand = CFrame.lookAt(center + Vector3.new(0, 3.2, 6), center + Vector3.new(0, 3.2, -10))
	root.CFrame = stand
	root.Anchored = true
	local head = character:FindFirstChild("Head")
	local overhead = head and head:FindFirstChild("DinoTitle") :: BillboardGui?
	if overhead then
		overhead.Enabled = false
	end
	maid:add(function()
		root.Anchored = false
		setCharacterHidden(character, false)
		if overhead then
			overhead.Enabled = true
		end
	end)

	-- Caméra scriptée.
	camera.CameraType = Enum.CameraType.Scriptable
	maid:add(function()
		camera.CameraType = Enum.CameraType.Custom
	end)
	local function shot(
		fromPos: Vector3,
		toPos: Vector3,
		lookFrom: Vector3,
		lookTo: Vector3,
		seconds: number,
		style: Enum.EasingStyle?
	)
		camera.CFrame = CFrame.lookAt(fromPos, lookFrom)
		local lookValue = Instance.new("Vector3Value")
		lookValue.Value = lookFrom
		maid:add(lookValue)
		local posValue = Instance.new("Vector3Value")
		posValue.Value = fromPos
		maid:add(posValue)
		local conn = RunService.RenderStepped:Connect(function()
			camera.CFrame = CFrame.lookAt(posValue.Value, lookValue.Value)
		end)
		maid:add(conn)
		tween(posValue, seconds, { Value = toPos }, style)
		tween(lookValue, seconds, { Value = lookTo }, style)
		task.wait(seconds)
		conn:Disconnect()
	end

	-- Calque d'interface plein écran : bandes cinéma, flash, textes, « Touche pour passer ».
	local gui = Kit.new("ScreenGui", {
		Name = "RebirthCinematic",
		DisplayOrder = 50,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	maid:add(gui)
	local hidden: { ScreenGui } = {}
	for _, other in player.PlayerGui:GetChildren() do
		if
			other:IsA("ScreenGui")
			and other.Enabled
			and (other.Name:sub(1, 4) == "Dino" or other.Name == "Notifications")
		then
			other.Enabled = false
			table.insert(hidden, other)
		end
	end
	maid:add(function()
		for _, other in hidden do
			other.Enabled = true
		end
	end)
	for _, top in { true, false } do
		local bar = Kit.new("Frame", {
			BackgroundColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0, if top then 0 else 1),
			Position = UDim2.fromScale(0, if top then 0 else 1),
			Size = UDim2.fromScale(1, 0),
			ZIndex = 2,
			Parent = gui,
		})
		tween(bar, 0.4, { Size = UDim2.fromScale(1, 0.1) })
	end
	local flash = Kit.new("Frame", {
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 4,
		Parent = gui,
	})
	local skip = Kit.new("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		ZIndex = 6,
		Parent = gui,
	})
	Kit.new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.985),
		Size = UDim2.fromScale(0.4, 0.035),
		Font = Enum.Font.Arcade,
		Text = "touche pour passer",
		TextColor3 = Color3.new(1, 1, 1),
		TextTransparency = 0.2,
		TextScaled = true,
		ZIndex = 7,
		Parent = gui,
	})
	gui.Parent = player.PlayerGui

	-- Effets du monde (locaux) rangés dans un dossier détruit à la fin.
	local fx = Instance.new("Folder")
	fx.Name = "RebirthFx"
	fx.Parent = Workspace
	maid:add(fx)
	local grade = Instance.new("ColorCorrectionEffect")
	grade.Parent = camera
	maid:add(grade)
	local braziers: { Fire } = {}
	for _, d in shrine:GetDescendants() do
		if d:IsA("Fire") then
			table.insert(braziers, d)
		end
	end
	local function burn(size: number)
		for _, fire in braziers do
			fire.Size = size
		end
	end
	maid:add(function()
		burn(6)
		PhoenixController:SetMode("idle")
	end)

	local function doFlash(color: Color3, hold: number, fade: number)
		flash.BackgroundColor3 = color
		flash.BackgroundTransparency = 0
		task.wait(hold)
		tween(flash, fade, { BackgroundTransparency = 1 })
	end

	local thread = task.spawn(function()
		local discPos = disc.Position
		local playerPos = stand.Position

		-- 1. Plan large, les braseros s'embrasent.
		burn(11)
		shot(
			center + Vector3.new(0, 15, 46),
			center + Vector3.new(0, 11, 34),
			center + Vector3.new(0, 9, -4),
			center + Vector3.new(0, 8, -4),
			1.4
		)

		-- 2. Gros plan sur l'emblème : le phénix bat des ailes, étincelles dorées.
		PhoenixController:SetMode("flap")
		local sparkle = Kit.new("ParticleEmitter", {
			Color = ColorSequence.new(GOLD),
			LightEmission = 1,
			Size = NumberSequence.new(0.5, 0),
			Lifetime = NumberRange.new(0.8, 1.4),
			Rate = 40,
			Speed = NumberRange.new(4, 8),
			SpreadAngle = Vector2.new(180, 180),
			Parent = fxPart(fx, { Size = Vector3.new(8, 8, 1), CFrame = disc.CFrame, Transparency = 1 }),
		})
		shot(
			discPos + Vector3.new(2, 0, 22),
			discPos + Vector3.new(-1, -1, 14),
			discPos,
			discPos + Vector3.new(0, 0.5, 0),
			2
		)

		-- 3. Rayons dorés derrière l'emblème + plan moyen sur le joueur.
		local rays = Instance.new("Model")
		rays.Parent = fx
		for i = 0, 11 do
			local a = i * math.pi / 6
			local beam = fxPart(rays, {
				Size = Vector3.new(1.2, 0.1, 0.3),
				CFrame = CFrame.new(discPos + Vector3.new(0, 0, -0.8)) * CFrame.Angles(0, 0, a) * CFrame.new(0.6, 0, 0),
				Color = Color3.fromRGB(255, 230, 120),
				Material = Enum.Material.Neon,
				Transparency = 0.15,
			})
			tween(beam, 0.6, {
				Size = Vector3.new(30, 1.6, 0.3),
				CFrame = CFrame.new(discPos + Vector3.new(0, 0, -0.8)) * CFrame.Angles(0, 0, a) * CFrame.new(15, 0, 0),
			}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		end
		shot(
			playerPos + Vector3.new(9, 4, 13),
			playerPos + Vector3.new(5, 3, 10),
			playerPos + Vector3.new(0, 2, -4),
			playerPos + Vector3.new(0, 3, -6),
			1
		)

		-- 4. Tour de caméra autour du joueur, colonnes de feu.
		burn(15)
		sparkle.Rate = 120
		local orbit = Instance.new("NumberValue")
		orbit.Value = math.rad(40)
		maid:add(orbit)
		local orbitConn = RunService.RenderStepped:Connect(function()
			local a = orbit.Value
			camera.CFrame =
				CFrame.lookAt(playerPos + Vector3.new(math.sin(a) * 10, 3, math.cos(a) * 10), playerPos + up * 1.5)
		end)
		maid:add(orbitConn)
		tween(orbit, 1, { Value = math.rad(-50) }, Enum.EasingStyle.Quad)
		task.wait(1)
		orbitConn:Disconnect()

		-- 5. Flash : le joueur brûle, il ne reste que des cendres qui fument.
		doFlash(Color3.new(1, 1, 1), 0.12, 0.05)
		doFlash(Color3.fromRGB(255, 230, 90), 0.18, 0.4)
		setCharacterHidden(character, true)
		rays:Destroy()
		local ground = playerPos - Vector3.new(0, 2.6, 0)
		for i = 1, 7 do
			fxPart(fx, {
				Size = Vector3.new(1, 0.6, 1) * (1.4 - i * 0.12),
				CFrame = CFrame.new(
					ground + Vector3.new(((i * 37) % 5 - 2) * 0.35, i * 0.25, ((i * 53) % 5 - 2) * 0.35)
				) * CFrame.Angles(0, i, 0),
				Color = Color3.fromRGB(40 + i * 6, 38 + i * 5, 36 + i * 5),
				Material = Enum.Material.Slate,
			})
		end
		Kit.new("Smoke", {
			Color = Color3.fromRGB(60, 56, 52),
			Opacity = 0.35,
			RiseVelocity = 4,
			Size = 2,
			Parent = fxPart(fx, { Size = Vector3.one, CFrame = CFrame.new(ground + up), Transparency = 1 }),
		})
		task.wait(0.3)

		-- 6. Plan large teinté de rouge : la boule de feu descend de l'emblème et file au sol.
		grade.TintColor = Color3.fromRGB(255, 120, 105)
		grade.Saturation = 0.3
		camera.CFrame = CFrame.lookAt(center + Vector3.new(11, 7, 24), center + Vector3.new(0, 4, -1))
		local ball = fxPart(fx, {
			Shape = Enum.PartType.Ball,
			Size = Vector3.new(5, 5, 5),
			CFrame = CFrame.new(discPos + Vector3.new(0, 0, 2.5)),
			Color = Color3.fromRGB(255, 150, 40),
			Material = Enum.Material.Neon,
		})
		Kit.new(
			"Fire",
			{ Size = 14, Heat = 8, Color = Color3.fromRGB(255, 120, 30), SecondaryColor = GOLD, Parent = ball }
		)
		Kit.new("PointLight", { Color = Color3.fromRGB(255, 140, 40), Range = 20, Brightness = 3, Parent = ball })
		local trail = Kit.new("ParticleEmitter", {
			Color = ColorSequence.new(Color3.fromRGB(255, 200, 60), Color3.fromRGB(255, 70, 20)),
			LightEmission = 1,
			Size = NumberSequence.new(3, 0),
			Lifetime = NumberRange.new(0.5, 0.9),
			Rate = 120,
			Speed = NumberRange.new(0.5, 2),
			Parent = ball,
		})
		local _ = trail
		tween(
			ball,
			0.7,
			{ CFrame = CFrame.new(center + Vector3.new(0, 2.8, -6)) },
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		)
		task.wait(0.7)
		tween(
			ball,
			1,
			{ CFrame = CFrame.new(ground + Vector3.new(0, 1.5, 0)) },
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		)
		task.wait(1)

		-- 7. Explosion et flash.
		local burst = Kit.new("ParticleEmitter", {
			Color = ColorSequence.new(GOLD, Color3.fromRGB(255, 80, 20)),
			LightEmission = 1,
			Size = NumberSequence.new(2, 0),
			Lifetime = NumberRange.new(0.5, 1),
			Rate = 0,
			Speed = NumberRange.new(20, 35),
			SpreadAngle = Vector2.new(180, 180),
			Parent = ball,
		})
		burst:Emit(120)
		ball.Transparency = 1
		doFlash(Color3.new(1, 1, 1), 0.15, 0.5)
		grade.TintColor = Color3.new(1, 1, 1)
		grade.Saturation = 0.15
		for _, child in fx:GetChildren() do
			if child:IsA("BasePart") and child.Material == Enum.Material.Slate then
				child:Destroy() -- les cendres disparaissent dans l'explosion
			end
		end

		-- 8. « REBIRTH » lettre par lettre ; le joueur renaît et s'élève dans les flammes.
		setCharacterHidden(character, false)
		local aura = Kit.new(
			"Fire",
			{ Size = 7, Heat = 10, Color = Color3.fromRGB(255, 140, 30), SecondaryColor = GOLD, Parent = root }
		)
		maid:add(aura)
		tween(root, 2.2, { CFrame = stand + up * 4 }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local title = Kit.new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.22),
			Size = UDim2.fromScale(0.5, 0.16),
			ZIndex = 5,
			Parent = gui,
		})
		local raysUi = Kit.new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.45, 2.4),
			ZIndex = 4,
			Parent = title,
		})
		for i = 0, 7 do
			Kit.new("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 220, 90),
				BackgroundTransparency = 0.4,
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(0, 10, 1, 0),
				Rotation = i * 22.5,
				ZIndex = 4,
				Parent = raysUi,
			})
		end
		Kit.loop(raysUi, 6, { Rotation = 360 })
		local word = "REBIRTH"
		for i = 1, #word do
			popText(title, word:sub(i, i), UDim2.fromScale((i - 0.5) / #word, 0.5), 1, GOLD).Size =
				UDim2.fromScale(1 / #word, 1)
			task.wait(0.09)
		end
		shot(
			playerPos + Vector3.new(4, 1, 17),
			playerPos + Vector3.new(2, 3, 14),
			playerPos + up * 4,
			playerPos + up * 6,
			1.6
		)

		-- 9. Les bonus, un par un, puis « RENÉ ! ».
		local slotsGained = Plots.pedestalCount(rebirths) - Plots.pedestalCount(rebirths - 1)
		local lines = {
			`🐚 FOSSILES x{Kit.decimal(Rebirth.coinsMultiplier(rebirths))}`,
			`🍀 CHANCE x{Kit.decimal(Rebirth.luckMultiplier(rebirths))}`,
		}
		if slotsGained > 0 then
			table.insert(lines, `+{slotsGained} SOCLES`)
		end
		for i, text in lines do
			popText(gui, text, UDim2.fromScale(0.2 + (i - 1) * 0.3, 0.72), 0.06)
			task.wait(0.45)
		end
		popText(gui, "RENÉ !", UDim2.fromScale(0.5, 0.82), 0.08, Color3.new(1, 1, 1))
		task.wait(0.8)

		-- 10. Plan large final, le joueur se pose.
		title:Destroy()
		tween(root, 0.6, { CFrame = stand }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		aura:Destroy()
		popText(gui, "DE TES CENDRES...", UDim2.fromScale(0.5, 0.3), 0.06)
		shot(
			center + Vector3.new(0, 10, 36),
			center + Vector3.new(0, 12, 42),
			center + Vector3.new(0, 9, -6),
			center + Vector3.new(0, 10, -6),
			1.2
		)
		popText(gui, "TA NOUVELLE AVENTURE COMMENCE !", UDim2.fromScale(0.5, 0.4), 0.07)
		task.wait(1.2)
		maid:clean()
		playing = false
	end)

	maid:add(skip.Activated:Connect(function()
		if coroutine.status(thread) ~= "dead" then
			pcall(task.cancel, thread)
		end
		root.CFrame = stand
		maid:clean()
		playing = false
	end))
end

return RebirthCinematic
