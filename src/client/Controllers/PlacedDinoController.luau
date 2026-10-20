--!strict
-- Anime côté client les dinos posés sur les parcelles (tag « PlacedDino ») : le serveur ne pose que des
-- modèles ancrés. Seuls les dinos à moins de 150 studs bougent, pour le mobile.
-- Maillage généré disponible (DinoModels) : le modèle serveur est masqué localement et un dino 3D client
-- est posé à ses pieds (Idle, Celebrate quand on vient de le poser). Le serveur redessine les socles toutes
-- les 10 s : un même dino sur le même socle réutilise son modèle client.
-- Sinon, modèle riggé (Animator) + Idle publiée dans Config/Animations, ou simple respiration (cube).

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Animations = require(ReplicatedStorage.Shared.Config.Animations)
local DinoModels = require(script.Parent.Parent.DinoModels)

local DINO_TAG = "PlacedDino"
local MAX_DISTANCE = 150
local BOB_HEIGHT = 0.25
local BOB_SPEED = 2
local RELEASE_DELAY = 1 -- s : laisse au serveur le temps de reposer le même dino avant de détruire le modèle client
local CELEBRATE_AFTER = 5 -- s : pas de Celebrate pour les dinos déjà posés à l'arrivée

type Entry = { model: Model, base: CFrame, phase: number, idle: AnimationTrack?, playing: boolean, meshed: boolean }
type Visual = { key: string, model: Model?, server: Model? }

local entries: { [Model]: Entry } = {}
local visuals: { [Instance]: Visual } = {} -- par socle
local pedestalOf: { [Model]: Instance } = {}
local folder: Folder
local startedAt = os.clock()

local function loadIdle(model: Model): AnimationTrack?
	local clips = (Animations :: any)[model:GetAttribute("Archetype") or ""]
	local id = clips and clips.Idle
	local animator = model:FindFirstChildWhichIsA("Animator", true)
	if not animator or not id or id == 0 then
		return nil
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = `rbxassetid://{id}`
	local track = (animator :: Animator):LoadAnimation(animation)
	track.Looped = true
	return track
end

local function setHidden(model: Model, hidden: boolean)
	for _, part in model:GetDescendants() do
		if part:IsA("BasePart") then
			part.LocalTransparencyModifier = if hidden then 1 else 0
		end
	end
end

-- Remplace localement le modèle serveur par le dino 3D généré. false si pas de données pour ce dino.
local function attachMesh(server: Model): boolean
	local dinoId = server:GetAttribute("DinoId")
	local pedestal = server.Parent
	if type(dinoId) ~= "string" or not pedestal or not pedestal:IsA("BasePart") or not DinoModels.has(dinoId) then
		return false
	end
	local size, skin = server:GetAttribute("Size"), server:GetAttribute("Skin")
	local key = `{dinoId}|{size}|{skin}`
	-- Cube serveur masqué, étiquette du serveur rattachée au-dessus de la tête du dino client.
	local function dress(child: Instance)
		local visual = visuals[pedestal]
		if child:IsA("BasePart") and visual then
			child.LocalTransparencyModifier = 1
		elseif child:IsA("BillboardGui") and visual and visual.model then
			local model = visual.model :: Model
			child.Adornee = model.PrimaryPart
			child.StudsOffset = Vector3.new(0, model:GetExtentsSize().Y / 2 + 1.5, 0)
		end
	end
	setHidden(server, true)
	-- Les enfants du modèle serveur peuvent être répliqués après le tag : on les traite aussi à leur arrivée.
	server.DescendantAdded:Connect(dress)
	pedestalOf[server] = pedestal
	-- Pieds sur le dessus du socle ; le socle regarde vers le centre de l'anneau et le joueur arrive de
	-- l'autre côté de sa parcelle : demi-tour pour que le dino lui fasse face.
	local feet = (pedestal :: BasePart).CFrame
		* CFrame.new(0, (pedestal :: BasePart).Size.Y / 2, 0)
		* CFrame.Angles(0, math.pi, 0)

	local visual = visuals[pedestal]
	if visual and visual.key == key then
		visual.server = server -- simple redessin serveur : on garde le modèle client
		for _, child in server:GetDescendants() do
			dress(child)
		end
		return true
	end
	if visual and visual.model then
		visual.model:Destroy()
	end
	local fresh: Visual = { key = key, server = server }
	visuals[pedestal] = fresh
	local celebrate = os.clock() - startedAt > CELEBRATE_AFTER
	task.spawn(function()
		local model = DinoModels.create(dinoId, size :: string?, skin :: string?)
		if visuals[pedestal] ~= fresh then
			if model then
				model:Destroy() -- remplacé pendant la construction
			end
			return
		elseif not model then
			visuals[pedestal] = nil
			setHidden(server, false) -- échec : on réaffiche le cube
			return
		end
		model:PivotTo(feet)
		model.Parent = folder
		fresh.model = model
		for _, child in (fresh.server or server):GetDescendants() do
			dress(child)
		end
		if celebrate then
			DinoModels.play(model, "Celebrate", { thenClip = "Idle" })
		else
			DinoModels.play(model, "Idle")
		end
	end)
	return true
end

local function add(instance: Instance)
	if instance:IsA("Model") then
		entries[instance] = {
			model = instance,
			base = instance:GetPivot(),
			phase = math.random() * math.pi * 2,
			idle = loadIdle(instance),
			playing = false,
			meshed = attachMesh(instance),
		}
	end
end

local function remove(instance: Instance)
	local entry = entries[instance :: Model]
	if entry and entry.idle then
		entry.idle:Stop()
	end
	entries[instance :: Model] = nil

	local pedestal = pedestalOf[instance :: Model]
	pedestalOf[instance :: Model] = nil
	local visual = pedestal and visuals[pedestal]
	if visual and visual.server == instance then
		visual.server = nil
		task.delay(RELEASE_DELAY, function()
			if visuals[pedestal :: Instance] == visual and not visual.server then
				visuals[pedestal :: Instance] = nil
				if visual.model then
					visual.model:Destroy() -- DinoModels oublie le modèle dès qu'il quitte le jeu
				end
			end
		end)
	end
end

local PlacedDinoController = {}

function PlacedDinoController:Start()
	folder = Instance.new("Folder")
	folder.Name = "ClientDinos"
	folder.Parent = Workspace
	startedAt = os.clock()

	for _, instance in CollectionService:GetTagged(DINO_TAG) do
		add(instance)
	end
	CollectionService:GetInstanceAddedSignal(DINO_TAG):Connect(add)
	CollectionService:GetInstanceRemovedSignal(DINO_TAG):Connect(remove)

	RunService.RenderStepped:Connect(function()
		local character = Players.LocalPlayer.Character
		local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if not root then
			return
		end
		local t = os.clock()
		for model, entry in entries do
			if not model.Parent then
				remove(model)
				continue
			end
			if entry.meshed then
				continue -- animé par DinoModels (distance gérée là-bas)
			end
			local near = (entry.base.Position - root.Position).Magnitude < MAX_DISTANCE
			if entry.idle then
				if near ~= entry.playing then
					entry.playing = near
					if near then
						entry.idle:Play()
					else
						entry.idle:Stop()
					end
				end
			elseif near then
				local offset = math.sin(t * BOB_SPEED + entry.phase) * BOB_HEIGHT
				model:PivotTo(entry.base * CFrame.new(0, offset, 0))
			end
		end
	end)
end

return PlacedDinoController
