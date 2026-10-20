--!strict
-- Pastilles d'Ambre au sol : +2 Ambre au toucher, réapparition toutes les 2 min.
-- Emplacements : les Parts taguées « AmberSpawn » (posées par le level-designer) ; sinon quelques points
-- provisoires autour du spawn. Le toucher est détecté par le serveur et la distance revérifiée.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Economy = require(ReplicatedStorage.Shared.Config.Economy)

local DataService = require(script.Parent.DataService)

local SPAWN_TAG = "AmberSpawn"
local MAX_TOUCH_DISTANCE = 12
local FALLBACK_SPOTS = 6
local FALLBACK_RADIUS = 40

local AmberPickupService = {}

local function spawnPickup(at: CFrame, folder: Folder)
	local pickup = Instance.new("Part")
	pickup.Name = "AmberPickup"
	pickup.Shape = Enum.PartType.Ball
	pickup.Size = Vector3.new(2, 2, 2)
	pickup.Material = Enum.Material.Neon
	pickup.Color = Color3.fromHex("#F2A33A")
	pickup.Anchored = true
	pickup.CanCollide = false
	pickup.CFrame = at
	pickup.Parent = folder

	local taken = false
	pickup.Touched:Connect(function(hit)
		if taken then
			return
		end
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		local root = player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if not player or not root or (root.Position - pickup.Position).Magnitude > MAX_TOUCH_DISTANCE then
			return
		end
		if DataService:Increment(player, "Amber", Economy.amberPickupAmount) then
			taken = true
			pickup:Destroy()
			task.delay(Economy.amberPickupRespawnSeconds, spawnPickup, at, folder)
		end
	end)
end

function AmberPickupService:Start()
	local folder = Instance.new("Folder")
	folder.Name = "AmberPickups"
	folder.Parent = Workspace

	local spots: { CFrame } = {}
	for _, marker in CollectionService:GetTagged(SPAWN_TAG) do
		if marker:IsA("BasePart") then
			table.insert(spots, marker.CFrame + Vector3.new(0, 2, 0))
		end
	end
	if #spots == 0 then
		-- shortcut: emplacements provisoires autour de l'origine tant que la map (Prompt 16) n'existe pas.
		for i = 1, FALLBACK_SPOTS do
			local angle = math.rad(i * 360 / FALLBACK_SPOTS)
			table.insert(spots, CFrame.new(math.cos(angle) * FALLBACK_RADIUS, 3, math.sin(angle) * FALLBACK_RADIUS))
		end
	end
	for _, spot in spots do
		spawnPickup(spot, folder)
	end
end

return AmberPickupService
