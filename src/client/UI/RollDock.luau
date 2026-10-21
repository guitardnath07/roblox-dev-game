--!strict
-- Commandes de lancer : dé facetté 3D sur socle, boutons sombres et contours cyan.
local Controllers = script.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local LuckController = require(Controllers.LuckController)
local RollController = require(Controllers.RollController)
local SettingsController = require(Controllers.SettingsController)
local NotificationController = require(Controllers.NotificationController)
local UIController = require(Controllers.UIController)
local Kit = require(script.Parent.Kit)
local Theme = require(script.Parent.Theme)

local RollDock = {}
local NAVY = Color3.fromHex("#0D2038")
local CYAN = Color3.fromHex("#41D9FF")
local GOLD = Color3.fromHex("#FFC132")

local function surface(parent: Instance, text: string, click: (() -> ())?): TextButton
	local button = Kit.button(parent, text, { color = NAVY, maxText = 16, onClick = click })
	local edge = button:FindFirstChildOfClass("UIStroke")
	if edge then
		edge.Color = CYAN
		edge.Transparency = 0.25
		edge.Thickness = 1.5
	end
	return button
end

-- Les faces et arêtes sont construites une fois. Seul un lancer anime le pivot.
local function diceStage(parent: Instance): (number) -> ()
	local viewport: ViewportFrame = Kit.new("ViewportFrame", {
		Name = "AmberDiceStage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Ambient = Color3.fromRGB(210, 164, 95),
		LightColor = Color3.fromRGB(255, 235, 180),
		LightDirection = Vector3.new(-1, -1, -1),
		Parent = parent,
	})
	local camera = Kit.new("Camera", { FieldOfView = 34, Parent = viewport })
	camera.CFrame = CFrame.lookAt(Vector3.new(5.4, 3.7, 8), Vector3.new(0, 0.8, 0))
	viewport.CurrentCamera = camera
	local world = Kit.new("WorldModel", { Parent = viewport })
	local function part(kind: string, props: { [string]: any }): BasePart
		props.Anchored = true
		props.CanCollide = false
		props.CastShadow = false
		props.Parent = world
		return Kit.new(kind, props)
	end
	local up = CFrame.Angles(0, 0, math.pi / 2)
	part("Part", {
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.45, 4.5, 4.5),
		CFrame = CFrame.new(0, -0.85, 0) * up,
		Color = Color3.fromHex("#27354B"),
		Material = Enum.Material.Slate,
	})
	part("Part", {
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.12, 4.2, 4.2),
		CFrame = CFrame.new(0, -0.57, 0) * up,
		Color = Color3.fromHex("#B8802A"),
		Material = Enum.Material.Metal,
	})
	-- Un anneau polygonal cyan autour du socle.
	for i = 0, 31 do
		local a, b = i * math.pi / 16, (i + 1) * math.pi / 16
		local v, w =
			Vector3.new(math.cos(a) * 2.15, -0.48, math.sin(a) * 2.15),
			Vector3.new(math.cos(b) * 2.15, -0.48, math.sin(b) * 2.15)
		part("Part", {
			Size = Vector3.new(0.035, 0.035, (v - w).Magnitude),
			CFrame = CFrame.lookAt((v + w) / 2, w),
			Color = CYAN,
			Material = Enum.Material.Neon,
		})
	end
	local die = Kit.new("Model", { Name = "AmberD20", Parent = world })
	local function diePart(kind: string, props: { [string]: any }): BasePart
		local object = part(kind, props)
		object.Parent = die
		return object
	end
	local phi = (1 + math.sqrt(5)) / 2
	local vertices: { Vector3 } = {}
	for _, a in { -1, 1 } do
		for _, b in { -phi, phi } do
			table.insert(vertices, Vector3.new(0, a, b) * 0.8)
			table.insert(vertices, Vector3.new(a, b, 0) * 0.8)
			table.insert(vertices, Vector3.new(b, 0, a) * 0.8)
		end
	end
	local function triangle(a: Vector3, b: Vector3, c: Vector3)
		local ab, ac, bc = b - a, c - a, c - b
		if ab.Magnitude > ac.Magnitude and ab.Magnitude > bc.Magnitude then
			a, c = c, a
		elseif ac.Magnitude > bc.Magnitude then
			a, b = b, a
		end
		ab, ac, bc = b - a, c - a, c - b
		local right = ac:Cross(ab).Unit
		local back = bc.Unit
		local vertical = bc:Cross(right).Unit
		local h = math.abs(ab:Dot(vertical))
		for _, spec in
			{
				{
					size = Vector3.new(0.018, h, math.abs(ab:Dot(back))),
					cf = CFrame.fromMatrix((a + b) / 2, right, vertical, back),
				},
				{
					size = Vector3.new(0.018, h, math.abs(ac:Dot(back))),
					cf = CFrame.fromMatrix((a + c) / 2, -right, vertical, -back),
				},
			}
		do
			diePart("WedgePart", {
				Size = spec.size,
				CFrame = spec.cf,
				Color = Color3.fromHex("#F5A01B"),
				Material = Enum.Material.Metal,
			})
		end
		local center = (a + b + c) / 3
		local normal = center.Unit
		if normal:Dot(Vector3.new(0.5, 0.4, 0.8).Unit) > 0.65 then
			local stamp = CFrame.lookAt(center + normal * 0.025, center + normal)
			for _, spot in { { 0, -0.06, 0.12 }, { -0.13, 0.12, 0.07 }, { 0, 0.19, 0.08 }, { 0.13, 0.12, 0.07 } } do
				diePart("Part", {
					Shape = Enum.PartType.Ball,
					Size = Vector3.new(spot[3] * 2, spot[3] * 2, 0.025),
					CFrame = stamp * CFrame.new(spot[1], spot[2], 0),
					Color = Color3.fromHex("#FFF08C"),
					Material = Enum.Material.Neon,
				})
			end
		end
	end
	for i, a in vertices do
		for j = i + 1, #vertices do
			local b = vertices[j]
			if math.abs((a - b).Magnitude - 1.6) < 0.01 then
				diePart("Part", {
					Size = Vector3.new(0.035, 0.035, (a - b).Magnitude),
					CFrame = CFrame.lookAt((a + b) / 2, b),
					Color = GOLD,
					Material = Enum.Material.Neon,
				})
				for k = j + 1, #vertices do
					local c = vertices[k]
					if math.abs((a - c).Magnitude - 1.6) < 0.01 and math.abs((b - c).Magnitude - 1.6) < 0.01 then
						triangle(a, b, c)
					end
				end
			end
		end
	end
	local resting = CFrame.new(0, 1, 0) * CFrame.Angles(0.12, 0.25, -0.15)
	die:PivotTo(resting)
	local spin = Kit.new("NumberValue", { Parent = viewport })
	spin.Changed:Connect(function(v: number)
		die:PivotTo(
			resting
				* CFrame.new(0, math.sin(v * math.pi) * 0.35, 0)
				* CFrame.Angles(v * math.pi * 2, v * math.pi * 2, 0)
		)
	end)
	local animation: Tween? = nil
	return function(seconds: number)
		if animation then
			animation:Cancel()
		end
		spin.Value = 0
		animation = Kit.tween(spin, math.clamp(seconds, 0.18, 0.65), { Value = 1 }, Enum.EasingStyle.Quart)
	end
end

function RollDock.create(root: Frame)
	local dock = Kit.new("Frame", {
		Name = "RollCluster",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -8),
		Size = UDim2.fromOffset(440, 190),
		Parent = root,
	})
	-- Une grille logique stable : chaque commande reste à au moins 44 px, même sur téléphone.
	local function holder(name: string, x: number, y: number, w: number, h: number): Frame
		return Kit.new("Frame", {
			Name = name,
			BackgroundTransparency = 1,
			Position = UDim2.new(x / 440, 0, 0, y),
			Size = UDim2.new(w / 440, 0, 0, h),
			Parent = dock,
		})
	end
	-- Auto et Masquer : ronds, de part et d'autre de LANCER.
	local function round(button: TextButton): TextButton
		local corner = button:FindFirstChildOfClass("UICorner")
		if corner then
			corner.CornerRadius = UDim.new(0.5, 0)
		end
		Kit.aspect(button, 1)
		return button
	end
	local auto = round(surface(holder("Auto", 36, 96, 72, 72), "▶\nAUTO", nil))
	-- Chance : sous le bouton des Lancers Dorés (CurrencyController), coin haut droit.
	local luckHolder = Kit.new("Frame", {
		Name = "Luck",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -8, 0, 140),
		Size = UDim2.fromOffset(132, 44),
		Parent = root,
	})
	local luck = surface(luckHolder, "🍀 Chance x1", function()
		UIController:Open("LuckBreakdown")
	end)
	luck.TextColor3 = Color3.fromHex("#A9EC52")
	local hide = round(surface(holder("Hide", 332, 96, 72, 72), "◉\nMASQUER", nil))
	local rollArea = holder("Roll", 122, 48, 194, 142)
	local stage = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(-8, -8),
		Size = UDim2.new(1, 16, 1, 8),
		Parent = rollArea,
	})
	local spin = diceStage(stage)
	local roll = Kit.new("TextButton", {
		Name = "RollButton",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Parent = rollArea,
	})
	Kit.touch(roll)
	Kit.feedback(roll)
	Kit.title(roll, "LANCER", {
		Position = UDim2.fromScale(0.08, 0.78),
		Size = UDim2.fromScale(0.84, 0.2),
		TextColor3 = Color3.fromHex("#FFF1B0"),
		TextStrokeColor3 = Theme.Outline,
		TextStrokeTransparency = 0.3,
	}, 24)
	local track = Kit.new("Frame", {
		Name = "Cooldown",
		BackgroundColor3 = NAVY,
		Position = UDim2.fromScale(0.22, 0.98),
		Size = UDim2.new(0.56, 0, 0, 3),
		BorderSizePixel = 0,
		Parent = rollArea,
	})
	local fill =
		Kit.new("Frame", { BackgroundColor3 = CYAN, Size = UDim2.fromScale(1, 1), BorderSizePixel = 0, Parent = track })
	Kit.corner(track, 0.5)
	Kit.corner(fill, 0.5)
	local cooldownTween: Tween? = nil
	roll.Activated:Connect(function()
		RollController:Roll()
	end)
	RollController:OnRolled(function(seconds: number)
		spin(seconds)
		if cooldownTween then
			cooldownTween:Cancel()
		end
		fill.Size = UDim2.fromScale(0, 1)
		cooldownTween =
			Kit.tween(fill, math.max(seconds, 0.05), { Size = UDim2.fromScale(1, 1) }, Enum.EasingStyle.Linear)
	end)
	auto.Activated:Connect(function()
		if not SettingsController:AutoRollUnlocked() then
			NotificationController:Toast("Débloque l'Auto-Lancer dans les améliorations.", "error")
			return
		end
		SettingsController:Set("AutoRoll", not SettingsController:Get("AutoRoll"))
	end)
	hide.Activated:Connect(function()
		SettingsController:Set("HideReveal", not SettingsController:Get("HideReveal"))
	end)
	local function toggles()
		local enabled = SettingsController:Get("AutoRoll")
		auto.Text = if not SettingsController:AutoRollUnlocked()
			then "🔒\nAUTO"
			elseif enabled then "Ⅱ\nAUTO"
			else "▶\nAUTO"
		auto.TextColor3 = if enabled then Theme.Leaf else Theme.White
		hide.Text = if SettingsController:Get("HideReveal") then "◉\nMASQUÉ" else "◉\nMASQUER"
		hide.TextColor3 = if SettingsController:Get("HideReveal") then CYAN else Theme.White
	end
	SettingsController:OnChanged(toggles)
	DataController:OnChanged("Upgrades", toggles)
	toggles()
	local function refreshLuck()
		luck.Text = `🍀 Chance {Kit.mult(LuckController:Get().total)}`
	end
	LuckController:OnChanged(refreshLuck)
	refreshLuck()
	-- Réduction des marges sur petit écran, sans réduire les cibles tactiles.
	local function fit()
		local width = root.AbsoluteSize.X / UIController:GetScale()
		dock.Size = UDim2.fromOffset(math.min(440, math.max(300, width - 16)), 190)
		if width < 460 then
			dock.Position = UDim2.new(0.5, 0, 1, -4)
		else
			dock.Position = UDim2.new(0.5, 0, 1, -8)
		end
	end
	root:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit)
	fit()
end

return RollDock
