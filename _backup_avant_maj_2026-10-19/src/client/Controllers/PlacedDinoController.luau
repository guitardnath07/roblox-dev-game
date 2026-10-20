--!strict
-- Anime côté client les dinos posés sur les parcelles (tag « PlacedDino ») : le serveur ne pose que des
-- modèles ancrés. Seuls les dinos à moins de 150 studs bougent, pour le mobile.
-- Modèle riggé (Animator) + Idle publiée dans Config/Animations : on joue l'Idle.
-- Sinon (cube provisoire, ID à 0) : simple respiration (montée/descente).

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Animations = require(ReplicatedStorage.Shared.Config.Animations)

local DINO_TAG = "PlacedDino"
local MAX_DISTANCE = 150
local BOB_HEIGHT = 0.25
local BOB_SPEED = 2

type Entry = { model: Model, base: CFrame, phase: number, idle: AnimationTrack?, playing: boolean }

local entries: { [Model]: Entry } = {}

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

local function add(instance: Instance)
	if instance:IsA("Model") then
		entries[instance] = {
			model = instance,
			base = instance:GetPivot(),
			phase = math.random() * math.pi * 2,
			idle = loadIdle(instance),
			playing = false,
		}
	end
end

local function remove(instance: Instance)
	local entry = entries[instance :: Model]
	if entry and entry.idle then
		entry.idle:Stop()
	end
	entries[instance :: Model] = nil
end

local PlacedDinoController = {}

function PlacedDinoController:Start()
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
