--!strict
-- Anime le phénix du sanctuaire côté client (le serveur ne pose que des pièces ancrées) :
--   « idle » : battement d'ailes lent et le phénix qui flotte doucement ;
--   « flap » : grands battements rapides (cinématique du rebirth, UI/RebirthCinematic).
-- Les ailes (modèles WingL / WingR) tournent autour des épaules (attributs ShoulderL / ShoulderR posés par ShrineService),
-- dans le plan de l'emblème. Animé seulement quand le joueur est à moins de 150 studs.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

export type Mode = "idle" | "flap"

local MODES: { [Mode]: { amplitude: number, speed: number, bob: number } } = {
	idle = { amplitude = math.rad(10), speed = 2.2, bob = 0.5 },
	flap = { amplitude = math.rad(32), speed = 9, bob = 1.2 },
}
local MAX_DISTANCE = 150

local PhoenixController = {}

local mode: Mode = "idle"
local current = { amplitude = MODES.idle.amplitude, speed = MODES.idle.speed, bob = MODES.idle.bob }

type Rig = {
	phoenix: Model,
	parts: { BasePart },
	bases: { CFrame },
	side: { number }, -- -1 aile gauche, 1 aile droite, 0 corps
	shoulders: { [number]: CFrame },
}

local rig: Rig? = nil

local function buildRig(phoenix: Model): Rig?
	local left = phoenix:GetAttribute("ShoulderL")
	local right = phoenix:GetAttribute("ShoulderR")
	if typeof(left) ~= "Vector3" or typeof(right) ~= "Vector3" then
		return nil
	end
	local r: Rig = {
		phoenix = phoenix,
		parts = {},
		bases = {},
		side = {},
		shoulders = {
			[-1] = CFrame.new(left :: Vector3),
			[1] = CFrame.new(right :: Vector3),
		},
	}
	for _, group in phoenix:GetChildren() do
		local side = if group.Name == "WingL" then -1 elseif group.Name == "WingR" then 1 else 0
		for _, p in group:GetDescendants() do
			if p:IsA("BasePart") then
				table.insert(r.parts, p)
				table.insert(r.bases, p.CFrame)
				table.insert(r.side, side)
			end
		end
	end
	return r
end

local function findPhoenix(): Model?
	local shrine = Workspace:FindFirstChild("RebirthShrine")
	local emblem = shrine and shrine:FindFirstChild("Emblem")
	local phoenix = emblem and emblem:FindFirstChild("Phoenix")
	return if phoenix and phoenix:IsA("Model") then phoenix else nil
end

-- Change l'animation (transition douce d'environ 0,4 s).
function PhoenixController:SetMode(next: Mode)
	mode = next
end

function PhoenixController:Start()
	local t = 0
	local cframes: { CFrame } = {}
	RunService.RenderStepped:Connect(function(dt)
		if not rig or not rig.phoenix.Parent then
			local phoenix = findPhoenix()
			rig = if phoenix then buildRig(phoenix) else nil
			if not rig then
				return
			end
		end
		local r = rig :: Rig
		local character = Players.LocalPlayer.Character
		local root = character and character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if not root or (root.Position - r.shoulders[1].Position).Magnitude > MAX_DISTANCE then
			return
		end
		-- Transition douce vers les réglages du mode demandé.
		local target = MODES[mode]
		local k = math.min(1, dt * 5)
		current.amplitude += (target.amplitude - current.amplitude) * k
		current.speed += (target.speed - current.speed) * k
		current.bob += (target.bob - current.bob) * k
		t += dt * current.speed

		-- Battement : les ailes descendent vite et remontent plus lentement (sinus déformé).
		local wave = math.sin(t)
		local flap = current.amplitude * (if wave > 0 then wave else wave * 0.6)
		local lift = CFrame.new(0, math.sin(t * 0.5) * current.bob, 0)
		local swing = {
			[-1] = lift * r.shoulders[-1] * CFrame.Angles(0, 0, -flap) * r.shoulders[-1]:Inverse(),
			[1] = lift * r.shoulders[1] * CFrame.Angles(0, 0, flap) * r.shoulders[1]:Inverse(),
			[0] = lift,
		}
		for i, base in r.bases do
			cframes[i] = swing[r.side[i]] * base
		end
		Workspace:BulkMoveTo(r.parts, cframes, Enum.BulkMoveMode.FireCFrameChanged)
	end)
end

return PhoenixController
