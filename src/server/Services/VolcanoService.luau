--!strict
-- Volcan des Défis : portail -> arène séparée par joueur (même serveur, décalée en hauteur),
-- équipe de 5 dinos, combat simulé sur le serveur (VolcanoCombat), effets visuels envoyés au client.
-- Le client ne fait que choisir l'équipe, commencer, abandonner, activer « continuer automatiquement ».

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Relics = require(Shared.Config.Relics)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)
local Volcano = require(Shared.Config.Volcano)

local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)
local PlotService = require(script.Parent.PlotService)
local QuestService = require(script.Parent.QuestService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)
local RewardsService = require(script.Parent.RewardsService)
local VolcanoCombat = require(script.Parent.Parent.Data.VolcanoCombat)

local ARENA_HEIGHT = 1000
local ARENA_SPACING = 200
local BETWEEN_FLOORS = 3
local ACTION_INTERVAL = 0.5

type Run = { team: { string }, floor: number, auto: boolean, active: boolean }

local rng = Random.new()
local runs: { [Player]: Run } = {}
local arenas: { [Player]: BasePart } = {}
local limiter = RateLimit.new()

local VolcanoService = {}

local function arenaFor(player: Player): BasePart
	local existing = arenas[player]
	if existing and existing.Parent then
		return existing
	end
	local folder = Workspace:FindFirstChild("VolcanoArenas") or Instance.new("Folder")
	folder.Name = "VolcanoArenas"
	folder.Parent = Workspace
	local index = #folder:GetChildren()
	-- shortcut: arène = simple dalle de lave, en attendant le décor du level-designer (Prompt 16).
	local floor = Instance.new("Part")
	floor.Name = `Arena_{player.UserId}`
	floor.Anchored = true
	floor.Size = Vector3.new(80, 2, 80)
	floor.Position = Vector3.new(index * ARENA_SPACING, ARENA_HEIGHT, 0)
	floor.Material = Enum.Material.Basalt
	floor.Color = Color3.fromHex("#3A2420")
	floor.Parent = folder
	arenas[player] = floor
	return floor
end

local function teleport(player: Player, cframe: CFrame)
	local character = player.Character
	if character then
		character:PivotTo(cframe)
	end
end

local function returnToHub(player: Player)
	local plot = PlotService:GetPlot(player)
	if plot and plot.PrimaryPart then
		teleport(player, plot.PrimaryPart.CFrame * CFrame.new(0, 5, 0))
	end
end

-- Relique tirée selon le palier atteint (le palier le plus haut dont fromFloor <= étage).
local function rollRelic(floor: number): string?
	local tier: Relics.Tier? = nil
	for _, candidate in Relics.tiers do
		if floor >= candidate.fromFloor then
			tier = candidate
		end
	end
	if not tier or rng:NextInteger(1, 1_000_000) > tier.dropPerMillion then
		return nil
	end
	local pool = {}
	for _, relic in Relics.list do
		if relic.tier == tier.tier then
			table.insert(pool, relic.id)
		end
	end
	return if #pool > 0 then pool[rng:NextInteger(1, #pool)] else nil
end

local function teamState(data: Types.ProfileData, team: { string })
	local list = {}
	for _, uuid in team do
		local instance = data.Dinos[uuid]
		if instance then
			local damage, health = Bonuses.combatStats(data, instance)
			table.insert(list, { uuid = uuid, dinoId = instance.dinoId, health = health, damage = damage })
		end
	end
	return list
end

local function playFloor(player: Player, run: Run)
	local data = DataService:GetLoaded(player)
	local floorDef = Volcano.floors[run.floor]
	if not data or not floorDef then
		return false
	end
	local team = teamState(data, run.team)
	if #team == 0 then
		return false
	end
	local state: Types.VolcanoState = {
		phase = "fighting",
		floor = run.floor,
		isBoss = floorDef.isBoss,
		enemyHealth = floorDef.enemyHealth,
		team = team,
		auto = run.auto,
	}
	Remotes.VolcanoState:FireClient(player, state)

	local fighters = {}
	for _, member in team do
		table.insert(
			fighters,
			{ uuid = member.uuid, damage = member.damage, health = member.health, maxHealth = member.health }
		)
	end
	local outcome = VolcanoCombat.simulate(fighters, floorDef.enemyHealth, floorDef.enemyDamage)

	-- Le résultat est déjà décidé ; on le rejoue au rythme des ticks pour les animations du client.
	for _, tick in outcome.ticks do
		if not run.active or player.Parent ~= Players then
			return false
		end
		Remotes.VolcanoFx:FireClient(player, tick.hits)
		task.wait(VolcanoCombat.TICK_SECONDS)
	end

	if not outcome.won then
		state.phase = "lost"
		Remotes.VolcanoState:FireClient(player, state)
		return false
	end

	local firstClear = run.floor > data.VolcanoBestFloor
	local ratio = if firstClear then 1 else Volcano.repeatRewardRatio
	local amber = math.floor(floorDef.amber * ratio)
	local bones = math.floor(floorDef.bones * ratio)
	local potionId = if firstClear then floorDef.potionId else nil
	RewardsService:Grant(player, {
		amber = amber,
		bones = bones,
		potions = if potionId then { [potionId] = 1 } else nil,
	})
	local relicId = rollRelic(run.floor)
	if relicId then
		DataService:Update(player, { "Relics", HttpService:GenerateGUID(false) }, function()
			return { relicId = relicId, obtainedAt = os.time() }
		end)
	end
	if firstClear then
		DataService:Update(player, { "VolcanoBestFloor" }, function()
			return run.floor
		end)
	end
	QuestService:Progress(player, "volcano_floors", 1)

	state.phase = "won"
	state.rewards = { amber = amber, bones = bones, potionId = potionId, relicId = relicId }
	Remotes.VolcanoState:FireClient(player, state)
	return true
end

local function runLoop(player: Player, run: Run)
	while run.active and run.floor <= Volcano.floorCount do
		local won = playFloor(player, run)
		if not won or not run.auto then
			break
		end
		run.floor += 1
		task.wait(BETWEEN_FLOORS)
	end
	if runs[player] == run then
		runs[player] = nil
		task.wait(BETWEEN_FLOORS)
		Remotes.VolcanoState:FireClient(player, nil)
		returnToHub(player)
	end
end

local function onStart(player: Player, uuids: any)
	local data = DataService:GetLoaded(player)
	if not data or runs[player] or type(uuids) ~= "table" then
		return
	end
	local team: { string } = {}
	local seen: { [string]: boolean } = {}
	for i = 1, math.min(#uuids, Volcano.teamSize) do
		local uuid = uuids[i]
		if
			type(uuid) == "string"
			and not seen[uuid]
			and data.Dinos[uuid]
			and not InventoryService:IsFrozen(player, uuid)
		then
			seen[uuid] = true
			table.insert(team, uuid)
		end
	end
	if #team == 0 then
		Remotes.Notify:FireClient(player, "Choisis au moins un dino pour ton équipe.", "error")
		return
	end
	local run: Run = {
		team = team,
		floor = math.min(data.VolcanoBestFloor + 1, Volcano.floorCount),
		auto = false,
		active = true,
	}
	runs[player] = run
	teleport(player, arenaFor(player).CFrame * CFrame.new(0, 5, 30))
	task.spawn(runLoop, player, run)
end

local function onEquipRelic(player: Player, slotId: any, uuid: any)
	local data = DataService:GetLoaded(player)
	if not data or type(slotId) ~= "string" then
		return
	end
	local validSlot = false
	for _, slot in Relics.slots do
		validSlot = validSlot or slot.id == slotId
	end
	if not validSlot then
		return
	end
	if uuid == nil then
		DataService:Update(player, { "EquippedRelics", slotId }, function()
			return nil
		end)
		return
	end
	local owned = type(uuid) == "string" and data.Relics[uuid]
	if not owned then
		return
	end
	for _, relic in Relics.list do
		if relic.id == owned.relicId and relic.slot == slotId then
			DataService:Update(player, { "EquippedRelics", slotId }, function()
				return uuid
			end)
		end
	end
end

-- Portail du Volcan : le Part « VolcanoPortal » de la map (level-designer) ou un portail provisoire.
local function ensurePortal()
	local portal = Workspace:FindFirstChild("VolcanoPortal", true)
	if not portal then
		local part = Instance.new("Part")
		part.Name = "VolcanoPortal"
		part.Anchored = true
		part.Size = Vector3.new(8, 12, 2)
		part.Position = Vector3.new(0, 6, -60)
		part.Material = Enum.Material.Neon
		part.Color = Color3.fromHex("#FF5722")
		part.Parent = Workspace
		portal = part
	end
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Entrer"
	prompt.ObjectText = "Volcan des Défis"
	prompt.RequiresLineOfSight = false
	prompt.Parent = portal
	-- Le client ouvre l'écran de choix d'équipe quand il voit ce prompt déclenché (attribut OpensVolcano).
	prompt:SetAttribute("OpensVolcano", true)
end

function VolcanoService:Init()
	Remotes.VolcanoStart.OnServerEvent:Connect(function(player, uuids)
		if limiter:allow(player, ACTION_INTERVAL) then
			onStart(player, uuids)
		end
	end)
	Remotes.VolcanoQuit.OnServerEvent:Connect(function(player)
		local run = runs[player]
		if run then
			run.active = false
		end
	end)
	Remotes.VolcanoSetAuto.OnServerEvent:Connect(function(player, auto)
		local run = runs[player]
		if run and type(auto) == "boolean" then
			run.auto = auto
		end
	end)
	Remotes.EquipRelic.OnServerEvent:Connect(function(player, slotId, uuid)
		if limiter:allow(player, ACTION_INTERVAL) then
			onEquipRelic(player, slotId, uuid)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		local run = runs[player]
		if run then
			run.active = false
		end
		runs[player] = nil
		local arena = arenas[player]
		if arena then
			arena:Destroy()
		end
		arenas[player] = nil
		limiter:forget(player)
	end)
end

function VolcanoService:Start()
	ensurePortal()
end

return VolcanoService
