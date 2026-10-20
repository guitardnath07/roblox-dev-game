--!strict
-- Vue 3D d'un dino dans un ViewportFrame : le modèle généré au runtime (DinoModels, animé en Idle) s'il existe,
-- sinon ReplicatedStorage.Assets.Dinos.<modelName>, sinon un cube aux couleurs de la rareté.
-- Option silhouette (noir) et rotation lente.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local DinoModels = require(script.Parent.Parent.DinoModels)
local Kit = require(script.Parent.Kit)

local DinoView = {}

export type View = {
	frame: ViewportFrame,
	setSilhouette: (on: boolean) -> (),
	destroy: () -> (),
}

export type Options = {
	rotate: boolean?,
	silhouette: boolean?,
	speed: number?, -- tours par seconde (rotation)
	size: string?, -- mutation de taille (id de Config/Mutations)
	skin: string?, -- mutation de peau
	roar: boolean?, -- rugissement à l'apparition (révélation Épique+)
}

local function findModel(modelName: string): Model?
	local assets = ReplicatedStorage:FindFirstChild("Assets")
	local folder = assets and assets:FindFirstChild("Dinos")
	local model = folder and folder:FindFirstChild(modelName)
	return if model and model:IsA("Model") then model else nil
end

-- Modèle de repli : cube arrondi aux couleurs de la rareté, avec deux « yeux ».
local function placeholder(color: Color3): Model
	local model = Instance.new("Model")
	local body = Kit.new("Part", {
		Size = Vector3.new(2, 2, 2),
		Color = color,
		Material = Enum.Material.SmoothPlastic,
		Anchored = true,
		CFrame = CFrame.new(),
		Parent = model,
	})
	for _, x in { -0.45, 0.45 } do
		Kit.new("Part", {
			Shape = Enum.PartType.Ball,
			Size = Vector3.new(0.45, 0.45, 0.45),
			Color = Color3.new(1, 1, 1),
			Material = Enum.Material.SmoothPlastic,
			Anchored = true,
			CFrame = CFrame.new(x, 0.35, -1),
			Parent = model,
		})
	end
	model.PrimaryPart = body
	return model
end

-- Copie ancrée et sans scripts du modèle importé du dino (ou du cube de repli). Ne cède jamais la main.
local function staticModel(dinoId: string): Model
	local dino = Kit.dinoById[dinoId]
	local source = dino and findModel(dino.modelName)
	local model: Model = if source then source:Clone() else placeholder(Kit.rarityOf(dinoId).color)
	for _, d in model:GetDescendants() do
		if d:IsA("BaseScript") then
			d:Destroy()
		elseif d:IsA("BasePart") then
			d.Anchored = true
		end
	end
	return model
end

-- Modèle du dino : maillage généré animé en Idle si disponible (cède la main), sinon modèle statique.
-- Dans un ViewportFrame, le placer dans un WorldModel pour que le squelette déforme le maillage.
function DinoView.model(dinoId: string, size: string?, skin: string?): Model
	local model = DinoModels.create(dinoId, size, skin)
	if model then
		DinoModels.play(model, "Idle")
		return model
	end
	return staticModel(dinoId)
end

-- Crée la vue dans `parent` (taille 1×1 du parent) pour le dino `dinoId`.
function DinoView.new(parent: Instance, dinoId: string, opts: Options?): View
	local o: Options = opts or {}

	local frame: ViewportFrame = Kit.new("ViewportFrame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Ambient = Color3.fromRGB(170, 160, 150),
		LightColor = Color3.fromRGB(255, 245, 230),
		LightDirection = Vector3.new(-1, -1.5, -1),
		Parent = parent,
	})
	local world = Kit.new("WorldModel", { Parent = frame })
	local camera = Kit.new("Camera", { FieldOfView = 40, Parent = frame })
	frame.CurrentCamera = camera

	local model: Model
	local base: CFrame
	local center: Vector3
	-- Cadrage : caméra reculée selon la taille de la boîte englobante.
	local function show(m: Model)
		model = m
		m.Parent = world
		local boxCFrame, boxSize = m:GetBoundingBox()
		center = boxCFrame.Position
		local radius = math.max(boxSize.X, boxSize.Y, boxSize.Z)
		camera.CFrame = CFrame.lookAt(center + Vector3.new(radius * 1.2, radius * 0.7, -radius * 2.3), center)
		base = m:GetPivot()
	end
	show(staticModel(dinoId))

	-- Le maillage généré se construit en tâche de fond ; on remplace le cube s'il arrive avant la fermeture.
	if DinoModels.has(dinoId) then
		task.spawn(function()
			local mesh = DinoModels.create(dinoId, o.size, o.skin)
			if not mesh then
				return
			elseif not frame.Parent then
				mesh:Destroy()
				return
			end
			model:Destroy()
			show(mesh)
			if o.roar then
				DinoModels.play(mesh, "Roar", { thenClip = "Idle" })
			else
				DinoModels.play(mesh, "Idle")
			end
		end)
	end

	local connection: RBXScriptConnection? = nil
	if o.rotate then
		local speed = (o.speed or 0.15) * math.pi * 2
		local angle = 0
		connection = RunService.RenderStepped:Connect(function(dt)
			if frame.Visible then
				angle += dt * speed
				local offset = base.Position - center
				model:PivotTo(CFrame.new(center) * CFrame.Angles(0, angle, 0) * CFrame.new(offset) * base.Rotation)
			end
		end)
	end

	local function setSilhouette(on: boolean)
		frame.ImageColor3 = if on then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
	end
	setSilhouette(o.silhouette == true)

	return {
		frame = frame,
		setSilhouette = setSilhouette,
		destroy = function()
			if connection then
				connection:Disconnect()
			end
			frame:Destroy()
		end,
	}
end

return DinoView
