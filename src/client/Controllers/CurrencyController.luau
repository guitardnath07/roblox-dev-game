--!strict
-- Monnaies, affichage fin et « vivant » :
--   trois compteurs bleu nuit / cyan centrés (Fossiles, Ambre, Os), lancers dorés séparés ;
--   le « +X/s » des Fossiles n'apparaît qu'au survol / toucher ; les nombres défilent en douceur ;
--   pulsation de la pièce au plus toutes les 5 s ; popup centré seulement pour les gros gains ;
--   la pilule des Fossiles tremble et rougit quand le serveur refuse une dépense (CurrencyDenied).
-- Effets 3D décoratifs, vus par le joueur seul (créés côté client, jamais répliqués) :
--   une pièce dorée sort régulièrement de chacun de SES dinos posés, avec un petit « +X », puis file vers lui ;
--   une petite gerbe d'éclats retombe à ses pieds après un achat.
-- Le revenu hors ligne garde son popup (OfflineEarningsController). Affichage seul : le serveur fait foi.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local Types = require(ReplicatedStorage.Shared.Types)

local DataController = require(script.Parent.DataController)
local LuckController = require(script.Parent.LuckController)
local RollController = require(script.Parent.RollController)
local SettingsController = require(script.Parent.SettingsController)
local UIController = require(script.Parent.UIController)

local Kit = require(script.Parent.Parent.UI.Kit)
local Theme = require(script.Parent.Parent.UI.Theme)

-- Tous les réglages des effets de monnaie, au même endroit.
local CURRENCY_FX = {
	enabled = true, -- futur réglage « Effets de monnaie : On/Off » (menu Paramètres)
	-- Barre
	barHeight = 0.06, -- part de la hauteur d'écran
	pillColor = Color3.fromHex("#0D2038"),
	pillTransparency = 0,
	textColor = Color3.fromRGB(250, 246, 236),
	countSeconds = 0.3,
	pulseScale = 1.15,
	pulseSeconds = 0.18,
	pulseCooldown = 5,
	incomeTouchSeconds = 2.5, -- durée d'affichage du « +X/s » après un toucher
	deniedSeconds = 0.3,
	deniedColor = Color3.fromRGB(255, 120, 120),
	-- Popup des gros gains
	bigGainRatio = 0.10, -- gain >= 10 % du solde précédent
	popupHold = 2,
	popupFade = 0.4,
	-- Pièces qui sortent des dinos posés
	coinInterval = 3.5, -- secondes entre deux pièces d'un même dino (+ un peu de hasard)
	coinMaxDistance = 70, -- au-delà, pas d'effet (mobile)
	coinMaxActive = 14,
	coinSize = 1.8,
	coinColor = Color3.fromRGB(255, 196, 46),
	coinRimColor = Color3.fromRGB(255, 236, 140),
	coinRise = 3.2,
	coinPopSeconds = 0.45,
	coinFlySeconds = 0.5,
	-- Gerbe d'achat
	shardSize = 0.4,
	shardTransparency = 0.35,
	burstMin = 5,
	burstMax = 8,
	burstSeconds = 1,
	soundId = 0, -- son court et doux à uploader (0 = muet)
	soundVolume = 0.3,
}

local CurrencyController = {}

local player = Players.LocalPlayer
local fossilPill: Frame
local fossilStroke: UIStroke
local coinScale: UIScale
local popupRoot: Frame
local activeCoins = 0

-- Petits appareils : qualité graphique réglée bas à la main -> moitié moins d'effets.
local function lowEnd(): boolean
	local ok, level = pcall(function()
		return UserSettings():GetService("UserGameSettings").SavedQualityLevel
	end)
	return ok and level ~= Enum.SavedQualitySetting.Automatic and level.Value <= 3
end

-- Dossier des effets locaux : créé par ce client, donc jamais vu par les autres joueurs.
local function fxFolder(): Folder
	local folder = Workspace:FindFirstChild("LocalCurrencyFx")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "LocalCurrencyFx"
		folder.Parent = Workspace
	end
	return folder :: Folder
end

local function rootPart(): BasePart?
	local character = player.Character
	return character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function invisiblePart(props: { [string]: any }): Part
	props.Anchored = true
	props.CanCollide = false
	props.CanQuery = false
	props.CanTouch = false
	props.CastShadow = false
	return Kit.new("Part", props)
end

-- Barre ----------------------------------------------------------------------------------------------------

-- Pilule sombre : pièce ronde colorée à gauche (avec reflet), nombre en blanc. Renvoie (pilule, nombre, pièce).
local function pill(
	parent: Instance,
	order: number,
	emoji: string,
	coinColor: Color3,
	_aspect: number
): (Frame, TextLabel, Frame)
	local frame = Kit.new("Frame", {
		BackgroundColor3 = CURRENCY_FX.pillColor,
		BackgroundTransparency = CURRENCY_FX.pillTransparency,
		LayoutOrder = order,
		Size = UDim2.fromScale(1, 1),
		Parent = parent,
	})
	frame.Size = UDim2.new(1 / 3, -8, 1, 0)
	frame.Name = if order == 1 then "Fossils" elseif order == 2 then "Amber" else "Bones"
	Kit.corner(frame, 0.18)
	Kit.stroke(frame, Theme.Cyan, 1.5, 0.15)
	Kit.new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(190, 210, 235)),
		Parent = frame,
	})
	local coin = Kit.new("Frame", {
		Name = "CurrencyIcon",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.fromOffset(34, 34),
		Parent = frame,
	})
	Kit.label(coin, emoji, { TextColor3 = coinColor, Size = UDim2.fromScale(1, 1) }, 30)
	local value = Kit.number(frame, "0", {
		Position = UDim2.fromOffset(43, 5),
		Size = UDim2.new(1, -49, 1, -10),
		Font = Enum.Font.GothamBold,
		TextColor3 = Theme.White,
		TextXAlignment = Enum.TextXAlignment.Center,
	}, 21)
	return frame, value, coin
end

-- Nombre qui défile vers sa cible (hausse comme baisse).
local function rolling(label: TextLabel, format: (number) -> string): (number) -> ()
	local shown = Instance.new("NumberValue")
	shown.Parent = label
	shown.Changed:Connect(function(v: number)
		label.Text = format(math.floor(v))
	end)
	local first = true
	return function(target: number)
		if first then
			first = false
			shown.Value = target
			label.Text = format(target)
		else
			Kit.tween(shown, CURRENCY_FX.countSeconds, { Value = target })
		end
	end
end

local function buildBar(root: Frame, data: Types.ProfileData): { [string]: (number) -> () }
	local bar = Kit.new("Frame", {
		Name = "CurrencyBar",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 6),
		Size = UDim2.new(0.48, 0, 0, 44),
		Parent = root,
	})
	Kit.limit(bar, Vector2.new(300, 44), Vector2.new(460, 44))
	Kit.list(bar, true, 0.025, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

	local fossilValue, coin
	fossilPill, fossilValue, coin = pill(bar, 1, "🪙", Color3.fromHex("#FFC22E"), 4.2)
	fossilStroke = fossilPill:FindFirstChildOfClass("UIStroke") :: UIStroke
	coinScale = Kit.new("UIScale", { Parent = coin })
	local _, amberValue = pill(bar, 2, "🔶", Color3.fromHex("#FF8A1F"), 3)
	local _, bonesValue = pill(bar, 3, "🐚", Color3.fromHex("#E8DCC4"), 3)
	-- Les trois soldes principaux restent centrés comme dans la maquette.
	-- Les lancers dorés sont une commande secondaire, pas une quatrième monnaie dans la barre.
	local goldenHolder = Kit.new("Frame", {
		Name = "GoldenRolls",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -8, 0, 64),
		Size = UDim2.fromOffset(132, 44),
		Parent = root,
	})
	local goldenButton = Kit.button(goldenHolder, "", {
		color = Theme.Navy,
		textColor = Theme.Gold,
		maxText = 15,
		onClick = function()
			RollController:Golden()
		end,
	})
	local goldenStroke = goldenButton:FindFirstChildOfClass("UIStroke")
	if goldenStroke then
		goldenStroke.Color = Theme.Gold
		goldenStroke.Transparency = 0.3
	end
	local goldenValue = Kit.label(goldenButton, "", { Size = UDim2.fromScale(1, 1), TextColor3 = Theme.Gold }, 15)

	-- « +X/s » sous les Fossiles : au survol (souris) ou quelques secondes après un toucher.
	local income = Kit.new("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.25, 1.05),
		Size = UDim2.fromScale(0.7, 0.55),
		Font = Enum.Font.GothamBold,
		Text = "",
		TextColor3 = Color3.fromRGB(190, 190, 190),
		TextStrokeTransparency = 0.5,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Visible = false,
		Parent = fossilPill,
	})
	local hit = Kit.new(
		"TextButton",
		{ BackgroundTransparency = 1, Text = "", Size = UDim2.fromScale(1, 1), Parent = fossilPill }
	)
	local touchToken = 0
	hit.MouseEnter:Connect(function()
		income.Visible = true
	end)
	hit.MouseLeave:Connect(function()
		income.Visible = false
	end)
	hit.Activated:Connect(function()
		touchToken += 1
		local token = touchToken
		income.Visible = true
		task.delay(CURRENCY_FX.incomeTouchSeconds, function()
			if token == touchToken then
				income.Visible = false
			end
		end)
	end)
	local function refreshIncome()
		income.Text = `+{Kit.big(LuckController:Get().incomePerSecond)}/s`
	end
	LuckController:OnChanged(refreshIncome)
	refreshIncome()

	local setters = {
		Fossils = rolling(fossilValue, Kit.big),
		Amber = rolling(amberValue, Kit.big),
		Bones = rolling(bonesValue, Kit.big),
		GoldenRolls = rolling(goldenValue, function(value: number): string
			return `✨ {Kit.group(value)} · Lancer`
		end),
	}
	for key, set in setters do
		set((data :: any)[key])
	end
	return setters
end

local function denied()
	Kit.tween(fossilStroke, CURRENCY_FX.deniedSeconds / 2, { Color = CURRENCY_FX.deniedColor, Transparency = 0 })
	task.delay(CURRENCY_FX.deniedSeconds / 2, function()
		Kit.tween(fossilStroke, CURRENCY_FX.deniedSeconds / 2, { Color = Theme.Cyan, Transparency = 0.15 })
	end)
	local base = fossilPill.Rotation
	for _, angle in { -3, 3, -2, 1, 0 } do
		fossilPill.Rotation = base + angle
		task.wait(CURRENCY_FX.deniedSeconds / 5)
	end
	fossilPill.Rotation = base
end

-- Popup centré « +X 🐚 » : reste `popupHold` s puis disparaît en fondu.
local function bigGainPopup(amount: number)
	local label = Kit.new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.36),
		Size = UDim2.fromScale(0.4, 0.075),
		BackgroundColor3 = CURRENCY_FX.pillColor,
		BackgroundTransparency = 0.2,
		Font = Enum.Font.GothamBlack,
		Text = `+{Kit.big(amount)} 🐚`,
		TextColor3 = Color3.fromHex("#FFD54A"),
		TextScaled = true,
		Parent = popupRoot,
	})
	Kit.corner(label, 0.5)
	Kit.aspect(label, 4.5, true)
	Kit.stroke(label, Color3.fromHex("#FFC22E"), 2, 0.3)
	Kit.new("UIPadding", { PaddingTop = UDim.new(0.15, 0), PaddingBottom = UDim.new(0.15, 0), Parent = label })
	local pop = Kit.new("UIScale", { Scale = 0.5, Parent = label })
	Kit.tween(pop, 0.35, { Scale = 1 }, Enum.EasingStyle.Back)
	task.delay(CURRENCY_FX.popupHold, function()
		Kit.tween(label, CURRENCY_FX.popupFade, { TextTransparency = 1, BackgroundTransparency = 1 })
		task.wait(CURRENCY_FX.popupFade)
		label:Destroy()
	end)
end

-- Pièces 3D des dinos ---------------------------------------------------------------------------------------

-- Pièce dorée (disque + liseré néon) qui sort de la tête du dino, tourne, monte, puis file vers le joueur.
local function coinFromDino(model: Model, amount: number)
	local root = rootPart()
	if not root then
		return
	end
	activeCoins += 1
	local _, extents = model:GetBoundingBox()
	local start = model:GetPivot().Position + Vector3.new(0, extents.Y / 2 + 0.4, 0)
	local size = CURRENCY_FX.coinSize
	local coin = Instance.new("Model")
	local disc = invisiblePart({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(size * 0.18, size, size),
		Color = CURRENCY_FX.coinColor,
		Material = Enum.Material.SmoothPlastic,
		Reflectance = 0.25,
		Parent = coin,
	})
	local rim = invisiblePart({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(size * 0.12, size * 1.12, size * 1.12),
		Color = CURRENCY_FX.coinRimColor,
		Material = Enum.Material.Neon,
		Transparency = 0.45,
		Parent = coin,
	})
	coin.PrimaryPart = disc
	coin.Parent = fxFolder()

	local tag = Kit.new("BillboardGui", {
		Size = UDim2.fromOffset(130, 38),
		StudsOffset = Vector3.new(0, 1.1, 0),
		AlwaysOnTop = true,
		LightInfluence = 0,
		Adornee = disc,
		Parent = coin,
	})
	local text = Kit.new("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Font = Enum.Font.GothamBlack,
		Text = `+{Kit.big(amount)}`,
		TextColor3 = Color3.fromHex("#FFD54A"),
		TextStrokeColor3 = Color3.fromRGB(60, 35, 0),
		TextStrokeTransparency = 0.2,
		TextScaled = true,
		Parent = tag,
	})

	local function place(position: Vector3, spin: number, scale: number)
		local cf = CFrame.new(position) * CFrame.Angles(0, spin, 0) -- l'axe du cylindre (X) reste horizontal : pièce debout
		disc.Size = Vector3.new(size * 0.18, size, size) * scale
		rim.Size = Vector3.new(size * 0.12, size * 1.12, size * 1.12) * scale
		disc.CFrame = cf
		rim.CFrame = cf
	end

	-- Phase 1 : apparition en rebond + montée + rotation.
	local alpha = Instance.new("NumberValue")
	alpha.Changed:Connect(function(t: number)
		local ease = TweenService:GetValue(t, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		place(
			start
				+ Vector3.new(
					0,
					CURRENCY_FX.coinRise * TweenService:GetValue(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					0
				),
			t * 9,
			math.max(ease, 0.05)
		)
	end)
	local rise =
		TweenService:Create(alpha, TweenInfo.new(CURRENCY_FX.coinPopSeconds, Enum.EasingStyle.Linear), { Value = 1 })
	rise.Completed:Once(function()
		-- Phase 2 : la pièce file vers le joueur (position relue à chaque image) en rapetissant.
		local top = start + Vector3.new(0, CURRENCY_FX.coinRise, 0)
		local fly = Instance.new("NumberValue")
		fly.Changed:Connect(function(t: number)
			local target = (rootPart() or root).Position + Vector3.new(0, 1.5, 0)
			local mid = (top + target) / 2 + Vector3.new(0, 2, 0)
			local a = top:Lerp(mid, t)
			local b = mid:Lerp(target, t)
			place(a:Lerp(b, t), 9 + t * 14, 1 - 0.5 * t)
			text.TextTransparency = t
			text.TextStrokeTransparency = 0.2 + 0.8 * t
		end)
		local tween = TweenService:Create(
			fly,
			TweenInfo.new(CURRENCY_FX.coinFlySeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			{ Value = 1 }
		)
		tween.Completed:Once(function()
			coin:Destroy()
			fly:Destroy()
			activeCoins -= 1
		end)
		tween:Play()
		alpha:Destroy()
	end)
	rise:Play()
end

-- Chaque dino posé du joueur a son propre rythme (décalé au hasard) pour éviter les vagues synchronisées.
local function runDinoCoins()
	local nextAt: { [Model]: number } = setmetatable({}, { __mode = "k" }) :: any
	while true do
		task.wait(0.2)
		local root = rootPart()
		if not CURRENCY_FX.enabled or not root then
			continue
		end
		local interval = CURRENCY_FX.coinInterval * (if lowEnd() then 2 else 1)
		local now = os.clock()
		for _, model in CollectionService:GetTagged("PlacedDino") do
			if not model:IsA("Model") or model:GetAttribute("OwnerId") ~= player.UserId then
				continue
			end
			local due = nextAt[model]
			if not due then
				nextAt[model] = now + math.random() * interval -- première pièce décalée
				continue
			end
			local income = model:GetAttribute("Income")
			local near = (model:GetPivot().Position - root.Position).Magnitude < CURRENCY_FX.coinMaxDistance
			if
				now >= due
				and near
				and type(income) == "number"
				and income > 0
				and activeCoins < CURRENCY_FX.coinMaxActive
			then
				nextAt[model] = now + interval + math.random() * 0.8
				-- Montant indicatif : ce que ce dino a rapporté depuis sa dernière pièce.
				coinFromDino(model, income * interval)
			elseif now >= due then
				nextAt[model] = now + 0.5
			end
		end
	end
end

-- Gerbe d'achat ---------------------------------------------------------------------------------------------

-- Éclat le long d'une courbe de Bézier p0 -> p1 -> p2, qui s'efface pendant `seconds`.
local function shard(p0: Vector3, p1: Vector3, p2: Vector3, seconds: number)
	local part = invisiblePart({
		Material = Enum.Material.Neon,
		Color = CURRENCY_FX.coinColor,
		Transparency = CURRENCY_FX.shardTransparency,
		Size = Vector3.one * CURRENCY_FX.shardSize,
		CFrame = CFrame.new(p0),
		Parent = fxFolder(),
	})
	local alpha = Instance.new("NumberValue")
	local spin = CFrame.Angles(math.random() * 6, math.random() * 6, 0)
	alpha.Changed:Connect(function(t: number)
		local a = p0:Lerp(p1, t)
		local b = p1:Lerp(p2, t)
		part.CFrame = CFrame.new(a:Lerp(b, t)) * spin * CFrame.Angles(t * 6, t * 4, 0)
		part.Transparency = CURRENCY_FX.shardTransparency + (1 - CURRENCY_FX.shardTransparency) * t * t
	end)
	local tween = TweenService:Create(alpha, TweenInfo.new(seconds, Enum.EasingStyle.Sine), { Value = 1 })
	tween.Completed:Once(function()
		part:Destroy()
		alpha:Destroy()
	end)
	tween:Play()
end

-- Petite gerbe qui retombe aux pieds du joueur (achat), avec un son doux.
local function purchaseBurst()
	local root = rootPart()
	if not root then
		return
	end
	local count = math.random(CURRENCY_FX.burstMin, CURRENCY_FX.burstMax)
	if lowEnd() then
		count = math.ceil(count / 2)
	end
	local feet = root.Position - Vector3.new(0, 2.8, 0)
	for _ = 1, count do
		local angle = math.random() * math.pi * 2
		local out = Vector3.new(math.cos(angle), 0, math.sin(angle)) * (1 + math.random() * 1.5)
		local top = root.Position + Vector3.new(0, 2.5, 0)
		shard(top, top + out * 0.6 + Vector3.new(0, 1.5, 0), feet + out, CURRENCY_FX.burstSeconds)
	end
	if CURRENCY_FX.soundId ~= 0 and SettingsController:Get("Sfx") then
		local sound = Instance.new("Sound")
		sound.SoundId = `rbxassetid://{CURRENCY_FX.soundId}`
		sound.Volume = CURRENCY_FX.soundVolume
		SoundService:PlayLocalSound(sound)
		task.delay(2, sound.Destroy, sound)
	end
end

function CurrencyController:Start()
	local data: Types.ProfileData = DataController:Get()
	local root = UIController:CreateLayer("DinoCurrency", 2)
	popupRoot = root
	local setters = buildBar(root, data)

	for _, key in { "Amber", "Bones", "GoldenRolls" } do
		DataController:OnChanged(key, function()
			setters[key]((data :: any)[key])
		end)
	end

	local last = data.Fossils
	local lastPulse = -math.huge
	DataController:OnChanged("Fossils", function()
		local now = data.Fossils
		local delta = now - last
		setters.Fossils(now)
		if delta > 0 then
			if os.clock() - lastPulse >= CURRENCY_FX.pulseCooldown then
				lastPulse = os.clock()
				coinScale.Scale = CURRENCY_FX.pulseScale
				Kit.tween(coinScale, CURRENCY_FX.pulseSeconds, { Scale = 1 }, Enum.EasingStyle.Back)
			end
			if last > 0 and delta >= last * CURRENCY_FX.bigGainRatio then
				bigGainPopup(delta)
			end
		elseif delta < 0 and CURRENCY_FX.enabled then
			purchaseBurst()
		end
		last = now
	end)

	Remotes.CurrencyDenied.OnClientEvent:Connect(denied)
	task.spawn(runDinoCoins)
end

return CurrencyController
