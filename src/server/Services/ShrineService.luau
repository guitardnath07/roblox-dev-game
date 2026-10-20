--!strict
-- Sanctuaire du Phénix : île flottante (loin au-dessus de la carte), temple voxel avec l'emblème du Phénix et l'autel REBIRTH.
-- Le bouton Rebirth du HUD y téléporte (ShrineTeleport "Shrine") ; on renaît en interagissant avec le totem
-- (ProximityPrompt « OpensRebirth » -> écran Rebirth côté client), et ProgressionService refuse un rebirth loin du totem.
-- La pierre de retour (prompt « ReturnToPlot ») ramène à sa parcelle (ShrineTeleport "Plot").
-- Si Workspace.RebirthShrine existe déjà (construit à la main), il est utilisé tel quel ; sinon on le construit ici.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local PlotService = require(script.Parent.PlotService)
local PhoenixShape = require(script.Parent.Parent.Data.PhoenixShape)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local CENTER = Vector3.new(0, 500, 0)
local TOTEM_RANGE = 20 -- distance max au totem pour renaître (studs)
local TELEPORT_INTERVAL = 1

local limiter = RateLimit.new()
local shrine: Model

local ShrineService = {}

local function part(parent: Instance, props: { [string]: any }): Part
	local p = Instance.new("Part")
	p.Anchored = true
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	for key, value in props do
		(p :: any)[key] = value
	end
	p.Parent = parent
	return p
end

local function cylinder(parent: Instance, height: number, diameter: number, y: number, color: Color3, material: Enum.Material): Part
	return part(parent, {
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(height, diameter, diameter),
		CFrame = CFrame.new(CENTER + Vector3.new(0, y, 0)) * CFrame.Angles(0, 0, math.pi / 2),
		Color = color,
		Material = material,
	})
end

local function prompt(parent: BasePart, action: string, object: string, attribute: string)
	local p = Instance.new("ProximityPrompt")
	p.ActionText = action
	p.ObjectText = object
	p.HoldDuration = 0.4
	p.MaxActivationDistance = 12
	p.RequiresLineOfSight = false
	p:SetAttribute(attribute, true)
	p.Parent = parent
end

-- Couleurs du sanctuaire du Phénix (style voxel : blocs lisses aux couleurs franches).
local GOLD = Color3.fromRGB(255, 196, 36)
local ORANGE = Color3.fromRGB(255, 132, 24)
local RED = Color3.fromRGB(214, 38, 44)
local DEEP_RED = Color3.fromRGB(150, 22, 30)
local BLUE = Color3.fromRGB(36, 70, 190)
local GRASS = Color3.fromRGB(76, 201, 58)
local DIRT = Color3.fromRGB(120, 84, 52)

-- Bloc posé relativement au centre de l'île (offset en studs, rotation en degrés).
local function block(parent: Instance, size: Vector3, offset: Vector3, color: Color3, rot: Vector3?, props: { [string]: any }?): Part
	local r = rot or Vector3.zero
	local p = part(parent, {
		Size = size,
		CFrame = CFrame.new(CENTER + offset) * CFrame.Angles(math.rad(r.X), math.rad(r.Y), math.rad(r.Z)),
		Color = color,
		Material = Enum.Material.SmoothPlastic,
	})
	for key, value in props or {} do
		(p :: any)[key] = value
	end
	return p
end

-- Texte peint sur la face avant (+Z) d'un bloc.
local function paintText(target: BasePart, text: string, color: Color3)
	local gui = Instance.new("SurfaceGui")
	gui.Face = Enum.NormalId.Front
	gui.PixelsPerStud = 50
	gui.LightInfluence = 0
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Font = Enum.Font.Arcade
	label.Text = text
	label.TextScaled = true
	label.TextColor3 = color
	label.TextStrokeColor3 = Color3.fromRGB(90, 20, 10)
	label.TextStrokeTransparency = 0
	label.Parent = gui
	gui.Parent = target
end

local function brazier(parent: Instance, offset: Vector3)
	local bowl = block(parent, Vector3.new(2.8, 1, 2.8), offset, GOLD)
	bowl.Name = "Brazier"
	block(parent, Vector3.new(2.2, 0.4, 2.2), offset + Vector3.new(0, 0.6, 0), ORANGE)
	for i = 1, 3 do
		block(parent, Vector3.new(1.4 - i * 0.3, 1, 1.4 - i * 0.3), offset + Vector3.new(0, 0.6 + i * 0.8, 0), if i == 3 then Color3.fromRGB(255, 236, 120) else ORANGE, Vector3.new(0, i * 25, 0), { Material = Enum.Material.Neon })
	end
	local fire = Instance.new("Fire")
	fire.Size = 6
	fire.Heat = 12
	fire.Color = ORANGE
	fire.SecondaryColor = Color3.fromRGB(255, 220, 80)
	fire.Parent = bowl
	local light = Instance.new("PointLight")
	light.Color = ORANGE
	light.Range = 16
	light.Brightness = 1.5
	light.Parent = bowl
end

local function pillar(parent: Instance, x: number, z: number)
	local base = Vector3.new(x, 0, z)
	block(parent, Vector3.new(3.4, 1, 3.4), base + Vector3.new(0, 1.5, 0), GOLD)
	block(parent, Vector3.new(2.4, 10, 2.4), base + Vector3.new(0, 7, 0), BLUE)
	for _, y in { 3.5, 7, 10.5 } do
		block(parent, Vector3.new(2.8, 0.6, 2.8), base + Vector3.new(0, y, 0), GOLD)
	end
	block(parent, Vector3.new(3.4, 1, 3.4), base + Vector3.new(0, 12.5, 0), GOLD)
	brazier(parent, base + Vector3.new(0, 13.5, 0))
	-- Bannière rouge tournée vers le centre, avec le symbole du rebirth.
	local yaw = math.deg(math.atan2(-x, -z))
	local facing = Vector3.new(-x, 0, -z).Unit
	local banner = block(parent, Vector3.new(1.8, 4.2, 0.2), base + Vector3.new(0, 7.5, 0) + facing * 1.3, RED, Vector3.new(0, yaw, 0))
	paintText(banner, "↻", GOLD)
end

local function tree(parent: Instance, offset: Vector3, scale: number)
	block(parent, Vector3.new(2, 7, 2) * scale, offset + Vector3.new(0, 3.5 * scale, 0), Color3.fromRGB(110, 70, 40))
	local greens = { Color3.fromRGB(61, 190, 58), Color3.fromRGB(46, 158, 46), Color3.fromRGB(91, 216, 74) }
	for i = 1, 5 do
		local s = (4 + (i % 3)) * scale
		local o = Vector3.new(((i * 37) % 5 - 2) * 1.1, 7 + (i % 3) * 1.6, ((i * 53) % 5 - 2) * 1.1) * scale
		block(parent, Vector3.new(s, s * 0.8, s), offset + o, greens[i % 3 + 1], Vector3.new(0, i * 17, 0))
	end
end

-- Couleurs des pièces du phénix importé (une pièce par couleur dans le fichier Blender : Phoenix_Red, …).
local STATUE_COLORS: { [string]: { color: Color3, material: Enum.Material } } = {
	Red = { color = Color3.fromRGB(214, 44, 30), material = Enum.Material.SmoothPlastic },
	Orange = { color = Color3.fromRGB(255, 120, 30), material = Enum.Material.SmoothPlastic },
	Gold = { color = Color3.fromRGB(255, 200, 60), material = Enum.Material.Neon },
	Dark = { color = Color3.fromRGB(40, 20, 16), material = Enum.Material.SmoothPlastic },
}

-- Pose une copie du phénix 3D : ancrée, recolorée, à la bonne taille (≈ 17 studs de haut), centrée sur `at`.
local function placeStatue(parent: Instance, source: Model, at: Vector3)
	local statue = source:Clone()
	statue.Name = "Phoenix"
	for _, d in statue:GetDescendants() do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
			for key, look in STATUE_COLORS do
				if d.Name:find(key) then
					d.Color = look.color
					d.Material = look.material
				end
			end
		end
	end
	local _, size = statue:GetBoundingBox()
	statue:ScaleTo(statue:GetScale() * 17 / math.max(size.Y, 0.01))
	local box = statue:GetBoundingBox()
	statue:PivotTo(statue:GetPivot() + (at - box.Position))
	statue.Parent = parent
end

-- Reconstruit le phénix modélisé dans Blender (Data/PhoenixShape) en pièces Roblox, centré sur `at`, haut de `height` :
-- chaque plume = 2 WedgeParts formant un triangle, sphères = ellipsoïdes (SpecialMesh), cou = cylindre.
local FEATHER_THICKNESS = 0.08 -- épaisseur d'une plume, en unités Blender

local function buildPhoenix(parent: Instance, at: Vector3, height: number)
	local model = Instance.new("Model")
	model.Name = "Phoenix"
	local lo, hi = Vector3.one * math.huge, -Vector3.one * math.huge
	local function grow(v: Vector3)
		lo, hi = lo:Min(v), hi:Max(v)
	end
	for _, f in PhoenixShape.feathers do
		grow(f.p)
		grow(f.p + f.d * f.L)
	end
	for _, b in PhoenixShape.balls do
		grow(b.center - b.radii)
		grow(b.center + b.radii)
	end
	local scale = height / math.max(hi.Y - lo.Y, 0.01)
	local mid = (lo + hi) / 2
	local function place(v: Vector3): Vector3
		return at + (v - mid) * scale
	end
	-- Trois groupes pour l'animation côté client (PhoenixController) : ailes gauche / droite autour des épaules, corps.
	local groups: { [string]: Model } = {}
	for _, name in { "WingL", "WingR", "Body" } do
		local g = Instance.new("Model")
		g.Name = name
		g.Parent = model
		groups[name] = g
	end
	local function groupOf(v: Vector3): Model
		-- Les plumes d'aile partent à plus de 0,35 de l'axe et au-dessus de la taille (unités Blender).
		if v.X > 0.35 and v.Y > 0.2 then
			return groups.WingR
		elseif v.X < -0.35 and v.Y > 0.2 then
			return groups.WingL
		end
		return groups.Body
	end
	model:SetAttribute("ShoulderL", place(Vector3.new(-0.4, 0.45, -0.05)))
	model:SetAttribute("ShoulderR", place(Vector3.new(0.4, 0.45, -0.05)))

	local function look(p: BasePart, color: string, group: Model?)
		local style = STATUE_COLORS[color] or STATUE_COLORS.Red
		p.Anchored = true
		p.CanCollide = false
		p.CastShadow = false
		p.Color = style.color
		p.Material = style.material
		p.TopSurface = Enum.SurfaceType.Smooth
		p.BottomSurface = Enum.SurfaceType.Smooth
		p.Parent = group or groups.Body
	end

	for _, f in PhoenixShape.feathers do
		local d = f.d.Unit
		local u = (f.u - d * f.u:Dot(d)).Unit
		local length, width = f.L * scale, f.w * scale
		local base = place(f.p)
		for _, side in { 1, -1 } do
			-- Coin : angle droit au centre de la base, un côté le long de la plume (-Z local), l'autre vers le bord (+Y local).
			local y = u * side
			local z = -d
			local wedge = Instance.new("WedgePart")
			wedge.Size = Vector3.new(FEATHER_THICKNESS * scale, width, length)
			wedge.CFrame = CFrame.fromMatrix(base + y * (width / 2) + d * (length / 2), y:Cross(z), y, z)
			look(wedge, f.c, groupOf(f.p))
		end
	end
	for _, b in PhoenixShape.balls do
		local ball = Instance.new("Part")
		ball.Size = b.radii * 2 * scale
		ball.CFrame = CFrame.new(place(b.center))
		local mesh = Instance.new("SpecialMesh")
		mesh.MeshType = Enum.MeshType.Sphere
		mesh.Parent = ball
		look(ball, b.c)
	end
	for _, c in PhoenixShape.cylinders do
		local x = c.axis.Unit
		local y = x:Cross(if math.abs(x.Z) < 0.9 then Vector3.zAxis else Vector3.xAxis).Unit
		local neck = Instance.new("Part")
		neck.Shape = Enum.PartType.Cylinder
		neck.Size = Vector3.new(c.L, c.r * 2, c.r * 2) * scale
		neck.CFrame = CFrame.fromMatrix(place(c.center), x, y, x:Cross(y))
		look(neck, c.c)
	end
	model.Parent = parent
end

local function build(): Model
	local model = Instance.new("Model")
	model.Name = "RebirthShrine"

	-- Île : herbe voxel sur des couches de terre.
	cylinder(model, 2, 96, -1, GRASS, Enum.Material.SmoothPlastic)
	cylinder(model, 6, 92, -5, DIRT, Enum.Material.SmoothPlastic)
	cylinder(model, 9, 64, -12, Color3.fromRGB(96, 66, 42), Enum.Material.SmoothPlastic)
	cylinder(model, 8, 32, -20, Color3.fromRGB(80, 56, 36), Enum.Material.SmoothPlastic)

	-- Plateforme ronde à anneaux (or / bleu / rouge / bleu) et losanges dorés.
	cylinder(model, 0.8, 38, 0.4, GOLD, Enum.Material.SmoothPlastic)
	cylinder(model, 1, 36, 0.5, BLUE, Enum.Material.SmoothPlastic)
	cylinder(model, 1.1, 28, 0.55, RED, Enum.Material.SmoothPlastic)
	cylinder(model, 1.2, 21, 0.6, BLUE, Enum.Material.SmoothPlastic)
	cylinder(model, 1.3, 8, 0.65, GOLD, Enum.Material.SmoothPlastic)
	for i = 0, 11 do
		local a = i * math.pi / 6
		block(model, Vector3.new(1.6, 0.3, 1.6), Vector3.new(math.sin(a) * 12.3, 1.2, math.cos(a) * 12.3), GOLD, Vector3.new(0, 45 + math.deg(a), 0))
	end

	-- Scène surélevée derrière l'autel.
	block(model, Vector3.new(24, 2.4, 8), Vector3.new(0, 2.2, -10), RED)
	block(model, Vector3.new(24.6, 0.6, 8.6), Vector3.new(0, 3.6, -10), GOLD)
	block(model, Vector3.new(16, 1, 2), Vector3.new(0, 1.5, -5.5), GOLD)

	-- Autel « REBIRTH » : c'est lui qu'on touche (nom « Totem » pour ShrineService / la cinématique).
	local altar = block(model, Vector3.new(11, 3.4, 4), Vector3.new(0, 2.9, -2.5), ORANGE)
	altar.Name = "Totem"
	block(model, Vector3.new(11.8, 0.6, 4.8), Vector3.new(0, 4.9, -2.5), DEEP_RED)
	local plaque = block(model, Vector3.new(8, 1.8, 0.25), Vector3.new(0, 3, -0.4), RED)
	paintText(plaque, "REBIRTH", GOLD)
	block(model, Vector3.new(9, 0.6, 1.6), Vector3.new(0, 1.4, 0.4), GOLD)
	prompt(altar, "Renaître", "Autel du Phénix", "OpensRebirth")

	-- Emblème du Phénix : disque rouge cerclé d'or, pointes solaires, phénix doré aux ailes déployées.
	local emblem = Instance.new("Model")
	emblem.Name = "Emblem"
	local ez = -11
	local ey = 16
	local disc = block(emblem, Vector3.new(1, 18, 18), Vector3.new(0, ey, ez), RED, Vector3.new(0, 90, 0), { Shape = Enum.PartType.Cylinder })
	disc.Name = "Disc"
	block(emblem, Vector3.new(0.8, 19.6, 19.6), Vector3.new(0, ey, ez - 0.2), GOLD, Vector3.new(0, 90, 0), { Shape = Enum.PartType.Cylinder })
	block(emblem, Vector3.new(1.1, 7, 7), Vector3.new(0, ey + 1, ez + 0.1), Color3.fromRGB(255, 120, 40), Vector3.new(0, 90, 0), { Shape = Enum.PartType.Cylinder })
	for i = 0, 15 do
		local a = i * math.pi / 8
		block(emblem, Vector3.new(1, 2.6, 0.7), Vector3.new(math.sin(a) * 10.6, ey + math.cos(a) * 10.6, ez - 0.1), GOLD, Vector3.new(0, 0, -math.deg(a)))
	end
	-- Phénix : le modèle 3D importé (ReplicatedStorage.Assets.PhoenixTotem, fait dans Blender) s'il existe,
	-- sinon le même phénix reconstruit en pièces depuis Data/PhoenixShape (généré par le script Blender).
	local assets = ReplicatedStorage:FindFirstChild("Assets")
	local statue = assets and assets:FindFirstChild("PhoenixTotem")
	if statue and statue:IsA("Model") then
		placeStatue(emblem, statue, CENTER + Vector3.new(0, ey, ez + 2.2))
	else
		buildPhoenix(emblem, CENTER + Vector3.new(0, ey, ez + 2.2), 17)
	end
	emblem.Parent = model

	-- Piliers bleu et or avec braseros et bannières.
	for _, xz in { { 15, -2 }, { -15, -2 }, { 12, -10 }, { -12, -10 }, { 6, -15 }, { -6, -15 } } do
		pillar(model, xz[1], xz[2])
	end
	-- Braseros au sol de part et d'autre de l'entrée.
	brazier(model, Vector3.new(7, 1.6, 12))
	brazier(model, Vector3.new(-7, 1.6, 12))

	-- Arbres voxel autour (pas devant l'entrée).
	for i = 0, 13 do
		local a = math.rad(40 + i * (280 / 13))
		local r = 36 + (i % 3) * 3
		tree(model, Vector3.new(math.sin(a) * r, 0, math.cos(a) * r), 1 + (i % 2) * 0.25)
	end

	-- Arrivée (face à l'autel) et pierre de retour.
	part(model, {
		Name = "Arrival",
		Size = Vector3.new(4, 1, 4),
		CFrame = CFrame.lookAt(CENTER + Vector3.new(0, 3.5, 26), CENTER + Vector3.new(0, 3.5, 0)),
		Transparency = 1,
		CanCollide = false,
	})
	local returnStone = part(model, {
		Name = "ReturnStone",
		Size = Vector3.new(4, 5, 1.6),
		CFrame = CFrame.new(CENTER + Vector3.new(0, 3, 34)),
		Color = Color3.fromRGB(70, 160, 230),
		Material = Enum.Material.SmoothPlastic,
	})
	local sign = Instance.new("SurfaceGui")
	sign.Face = Enum.NormalId.Back
	sign.PixelsPerStud = 40
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Font = Enum.Font.FredokaOne
	label.Text = "↩ Retour"
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 0.3
	label.Parent = sign
	sign.Parent = returnStone
	prompt(returnStone, "Retour", "À ma parcelle", "ReturnToPlot")

	-- Murets invisibles sur le bord pour ne pas tomber de l'île.
	for i = 0, 23 do
		local a = i * math.pi / 12
		part(model, {
			Size = Vector3.new(14, 14, 1),
			CFrame = CFrame.new(CENTER + Vector3.new(math.cos(a) * 47, 7, math.sin(a) * 47)) * CFrame.Angles(0, -a + math.pi / 2, 0),
			Transparency = 1,
		})
	end

	model.PrimaryPart = altar
	model.Parent = Workspace
	return model
end

local function rootOf(player: Player): BasePart?
	local character = player.Character
	return character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

-- Vrai si le joueur se tient près du totem (vérifié avant tout rebirth).
function ShrineService:IsNearTotem(player: Player): boolean
	local root = rootOf(player)
	local totem = shrine and shrine:FindFirstChild("Totem") :: BasePart?
	return root ~= nil and totem ~= nil and (root.Position - totem.Position).Magnitude <= TOTEM_RANGE
end

local function teleport(player: Player, where: any)
	local character = player.Character
	if not character or not rootOf(player) then
		return
	end
	if where == "Shrine" then
		local arrival = shrine:FindFirstChild("Arrival") :: BasePart?
		if arrival then
			character:PivotTo(arrival.CFrame + Vector3.new(0, 3, 0))
		end
	elseif where == "Plot" then
		local plot = PlotService:GetPlot(player)
		local target = if plot then plot:GetPivot().Position else Vector3.new(0, 0, 26)
		character:PivotTo(CFrame.new(target + Vector3.new(0, 6, 0)))
	end
end

function ShrineService:Init()
	local existing = Workspace:FindFirstChild("RebirthShrine")
	shrine = if existing and existing:IsA("Model") then existing else build()
	Remotes.ShrineTeleport.OnServerEvent:Connect(function(player: Player, where: any)
		if limiter:allow(player, TELEPORT_INTERVAL) then
			teleport(player, where)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		limiter:forget(player)
	end)
end

return ShrineService
