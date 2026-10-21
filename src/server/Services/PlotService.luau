--!strict
-- Parcelles : une des 9 parcelles par joueur, socles où poser les dinos, niveaux de socles.
-- Utilise Workspace.Plots.Plot1..9 construites par le level-designer ; sinon génère des parcelles
-- provisoires en Parts. Le serveur pose des modèles ANCRÉS (attribut DinoId) ; les clients les animent.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Shared = ReplicatedStorage.Shared
local Bonuses = require(Shared.Bonuses)
local Dinos = require(Shared.Config.Dinos)
local Mutations = require(Shared.Config.Mutations)
local Odds = require(Shared.Odds)
local Plots = require(Shared.Config.Plots)
local Rarities = require(Shared.Config.Rarities)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local CurrencyService = require(script.Parent.CurrencyService)
local DataService = require(script.Parent.DataService)
local IncomeService = require(script.Parent.IncomeService)
local InventoryService = require(script.Parent.InventoryService)
local QuestService = require(script.Parent.QuestService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local PLOT_SIZE = 60
local RING_RADIUS = 120
local PEDESTAL_COLUMNS = 6
local PEDESTAL_SPACING = 8
local LABEL_REFRESH_SECONDS = 10 -- événements et potions changent le revenu sans toucher au profil
local ACTION_INTERVAL = 0.2
local DINO_TAG = "PlacedDino" -- les clients animent les modèles portant ce tag

local dinoById: { [string]: Dinos.Dino } = {}
for _, dino in Dinos do
	dinoById[dino.id] = dino
end

local plotOf: { [Player]: Model } = {}
local renderQueued: { [Player]: boolean } = {}
local limiter = RateLimit.new()

local PlotService = {}

-- Parcelle provisoire : dalle 60×60, socles en grille, panneau. Même structure que les parcelles du level-designer.
local function buildTemporaryPlot(index: number, folder: Folder): Model
	local angle = math.rad((index - 1) * 360 / Plots.plotsPerServer)
	local center = Vector3.new(math.cos(angle) * RING_RADIUS, 0, math.sin(angle) * RING_RADIUS)
	local origin = CFrame.lookAt(center, Vector3.new(0, 0, 0))

	local plot = Instance.new("Model")
	plot.Name = `Plot{index}`

	local base = Instance.new("Part")
	base.Name = "Base"
	base.Anchored = true
	base.Size = Vector3.new(PLOT_SIZE, 1, PLOT_SIZE)
	base.CFrame = origin
	base.Material = Enum.Material.Grass
	base.Color = Color3.fromHex("#6FA85A")
	base.Parent = plot
	plot.PrimaryPart = base

	local pedestals = Instance.new("Folder")
	pedestals.Name = "Pedestals"
	pedestals.Parent = plot
	local rows = math.ceil(Plots.maxPedestals / PEDESTAL_COLUMNS)
	for i = 1, Plots.maxPedestals do
		local column = (i - 1) % PEDESTAL_COLUMNS
		local row = math.floor((i - 1) / PEDESTAL_COLUMNS)
		local offset = Vector3.new(
			(column - (PEDESTAL_COLUMNS - 1) / 2) * PEDESTAL_SPACING,
			1.5,
			(row - (rows - 1) / 2) * PEDESTAL_SPACING + 4
		)
		local pedestal = Instance.new("Part")
		pedestal.Name = `Pedestal{i}`
		pedestal.Anchored = true
		pedestal.Size = Vector3.new(5, 2, 5)
		pedestal.CFrame = origin * CFrame.new(offset)
		pedestal.Material = Enum.Material.Slate
		pedestal.Color = Color3.fromHex("#8C8478")
		pedestal.Parent = pedestals
	end

	local sign = Instance.new("Part")
	sign.Name = "Sign"
	sign.Anchored = true
	sign.Size = Vector3.new(16, 6, 1)
	sign.CFrame = origin * CFrame.new(0, 4, -PLOT_SIZE / 2 + 2) * CFrame.Angles(0, math.pi, 0)
	sign.Material = Enum.Material.Wood
	sign.Color = Color3.fromHex("#8B5A2B")
	local surface = Instance.new("SurfaceGui")
	surface.Face = Enum.NormalId.Back
	surface.Parent = sign
	local text = Instance.new("TextLabel")
	text.Name = "Owner"
	text.Size = UDim2.fromScale(1, 1)
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.FredokaOne
	text.TextScaled = true
	text.TextColor3 = Color3.new(1, 1, 1)
	text.Text = "Parcelle libre"
	text.Parent = surface
	sign.Parent = plot

	plot:SetAttribute("OwnerUserId", 0)
	plot.Parent = folder
	return plot
end

local function ensurePlots(): Folder
	local folder = Workspace:FindFirstChild("Plots") :: Folder?
	if folder then
		for _, plot in folder:GetChildren() do
			if plot:GetAttribute("OwnerUserId") == nil then
				plot:SetAttribute("OwnerUserId", 0)
			end
		end
		return folder
	end
	local created = Instance.new("Folder")
	created.Name = "Plots"
	created.Parent = Workspace
	for i = 1, Plots.plotsPerServer do
		buildTemporaryPlot(i, created)
	end
	return created
end

local function setSign(plot: Model, text: string)
	local sign = plot:FindFirstChild("Sign")
	local label = sign and sign:FindFirstChild("Owner", true)
	if label and label:IsA("TextLabel") then
		label.Text = text
	end
end

local function pedestalOf(plot: Model, slot: number): BasePart?
	local pedestals = plot:FindFirstChild("Pedestals")
	local pedestal = pedestals and pedestals:FindFirstChild(`Pedestal{slot}`)
	return if pedestal and pedestal:IsA("BasePart") then pedestal else nil
end

local function byId<T>(list: { T }, id: string): T?
	for _, entry in list do
		if (entry :: any).id == id then
			return entry
		end
	end
	return nil
end

-- Modèle affiché sur le socle (ReplicatedStorage.Assets.Dinos) : celui du dino (<modelName>), sinon celui
-- de son archétype (<archetype>, ex. « theropod »), sinon un cube à la couleur de la rareté.
-- shortcut: modèle d'archétype partagé et cubes tant que les 28 variantes 3D ne sont pas importées.
local function buildDinoModel(instance: Types.DinoInstance, base: Dinos.Dino): Model
	local size = byId(Mutations.Sizes, instance.size)
	local scale = if size then size.modelScale else 1

	local assets = ReplicatedStorage:FindFirstChild("Assets")
	local folder = assets and assets:FindFirstChild("Dinos")
	local template = folder and (folder:FindFirstChild(base.modelName) or folder:FindFirstChild(base.archetype))
	local model: Model
	if template and template:IsA("Model") then
		model = template:Clone()
		model:ScaleTo(scale)
	else
		model = Instance.new("Model")
		local body = Instance.new("Part")
		body.Name = "Body"
		body.Size = Vector3.new(3, 3, 3) * scale
		body.Color = Rarities[base.rarity].color
		body.Material = Enum.Material.SmoothPlastic
		body.Parent = model
		model.PrimaryPart = body
	end
	for _, part in model:GetDescendants() do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
		end
	end
	model.Name = "Dino"
	model:SetAttribute("DinoId", base.id)
	model:SetAttribute("Archetype", base.archetype) -- le client choisit les animations de l'archétype
	model:SetAttribute("Size", instance.size)
	model:SetAttribute("Skin", instance.skin)
	return model
end

local function billboard(parent: Instance, lines: { { text: string, color: Color3 } }, height: number)
	local gui = Instance.new("BillboardGui")
	gui.Size = UDim2.fromOffset(200, 22 * #lines)
	gui.StudsOffset = Vector3.new(0, height, 0)
	gui.AlwaysOnTop = false
	gui.MaxDistance = 80
	local layout = Instance.new("UIListLayout")
	layout.Parent = gui
	for _, line in lines do
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 0, 22)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.FredokaOne
		label.TextScaled = true
		label.TextColor3 = line.color
		label.TextStrokeTransparency = 0.4
		label.Text = line.text
		label.Parent = gui
	end
	gui.Parent = parent
end

local function render(player: Player)
	renderQueued[player] = nil
	local plot = plotOf[player]
	local data = DataService:GetLoaded(player)
	if not plot or not data then
		return
	end
	local count = Plots.pedestalCount(data.Rebirths)
	for slot = 1, Plots.maxPedestals do
		local pedestal = pedestalOf(plot, slot)
		if pedestal then
			for _, child in pedestal:GetChildren() do
				if child.Name == "Dino" or child:IsA("BillboardGui") or child:IsA("ProximityPrompt") then
					child:Destroy()
				end
			end
			pedestal.Transparency = if slot <= count then 0 else 0.85
			pedestal.CanCollide = slot <= count

			local key = tostring(slot)
			local level = data.SlotLevels[key] or 1
			local uuid = data.PlotSlots[key]
			local instance = uuid and data.Dinos[uuid]
			local base = instance and dinoById[instance.dinoId]
			if slot <= count and instance and base and uuid then
				local model = buildDinoModel(instance, base)
				model:PivotTo(pedestal.CFrame * CFrame.new(0, pedestal.Size.Y / 2 + model:GetExtentsSize().Y / 2, 0))
				model.Parent = pedestal
				CollectionService:AddTag(model, DINO_TAG)

				local rarity = Rarities[base.rarity]
				local mutations = {}
				local size = byId(Mutations.Sizes, instance.size)
				local skin = byId(Mutations.Skins, instance.skin)
				if size and size.id ~= Mutations.defaultId then
					table.insert(mutations, size.displayName)
				end
				if skin and skin.id ~= Mutations.defaultId then
					table.insert(mutations, skin.displayName)
				end
				local income = IncomeService:GetDinoIncome(player, uuid, key)
				-- Lus par le client pour l'effet de pièces (CurrencyController) : rien de décisionnel.
				model:SetAttribute("OwnerId", player.UserId)
				model:SetAttribute("Income", income)
				billboard(model, {
					{ text = base.displayName, color = Color3.new(1, 1, 1) },
					{
						text = rarity.displayName
							.. (if #mutations > 0 then " · " .. table.concat(mutations, " ") else ""),
						color = rarity.color,
					},
					{ text = `+{Odds.formatBig(income)}/s · Lvl {level}`, color = Color3.fromHex("#FFD54F") },
				}, model:GetExtentsSize().Y / 2 + 2)

				local prompt = Instance.new("ProximityPrompt")
				prompt.ActionText = "Reprendre"
				prompt.ObjectText = base.displayName
				prompt.MaxActivationDistance = 10
				prompt.RequiresLineOfSight = false
				prompt:SetAttribute("Slot", slot)
				prompt.Parent = pedestal
				prompt.Triggered:Connect(function(who)
					if who == player then
						PlotService:Remove(player, slot)
					end
				end)
			elseif slot <= count then
				billboard(pedestal, { { text = `Lvl {level}`, color = Color3.fromHex("#FFD54F") } }, 2)
			end
		end
	end
end

-- Redessine au plus une fois par image même si plusieurs changements arrivent d'un coup.
local function queueRender(player: Player)
	if not renderQueued[player] then
		renderQueued[player] = true
		task.defer(render, player)
	end
end

-- Valide un index de socle venu du client : entier entre 1 et le nombre de socles débloqués.
local function validSlot(data: Types.ProfileData, slot: any): number?
	if type(slot) ~= "number" or slot ~= slot or slot % 1 ~= 0 then
		return nil
	end
	if slot < 1 or slot > Plots.pedestalCount(data.Rebirths) then
		return nil
	end
	return slot
end

function PlotService:Place(player: Player, uuid: any, slotArg: any)
	local data = DataService:GetLoaded(player)
	if not data or type(uuid) ~= "string" or #uuid > 64 or not data.Dinos[uuid] then
		return
	end
	local slot = validSlot(data, slotArg)
	if not slot or InventoryService:IsFrozen(player, uuid) then
		return
	end
	local slots = table.clone(data.PlotSlots)
	for key, placed in slots do
		if placed == uuid then
			slots[key] = nil -- déplacé : on libère son ancien socle
		end
	end
	slots[tostring(slot)] = uuid -- un dino déjà sur ce socle retourne simplement dans le sac
	DataService:Update(player, { "PlotSlots" }, function()
		return slots
	end)
end

function PlotService:Remove(player: Player, slotArg: any)
	local data = DataService:GetLoaded(player)
	local slot = data and validSlot(data, slotArg)
	if not data or not slot or not data.PlotSlots[tostring(slot)] then
		return
	end
	DataService:Update(player, { "PlotSlots", tostring(slot) }, function()
		return nil
	end)
end

-- Pose les dinos au meilleur revenu propre sur les socles de plus haut niveau.
function PlotService:EquipBest(player: Player)
	local data = DataService:GetLoaded(player)
	if not data or Bonuses.upgradeStat(data.Upgrades, "equipBest") < 1 then
		return
	end
	local candidates: { { uuid: string, income: number } } = {}
	for uuid, instance in data.Dinos do
		if not InventoryService:IsFrozen(player, uuid) then
			table.insert(candidates, { uuid = uuid, income = Bonuses.instanceIncome(instance) })
		end
	end
	table.sort(candidates, function(a, b)
		return a.income > b.income
	end)

	local slots: { number } = {}
	for slot = 1, Plots.pedestalCount(data.Rebirths) do
		table.insert(slots, slot)
	end
	table.sort(slots, function(a, b)
		local la, lb = data.SlotLevels[tostring(a)] or 1, data.SlotLevels[tostring(b)] or 1
		return if la == lb then a < b else la > lb
	end)

	local placed: { [string]: string } = {}
	for i, slot in slots do
		local candidate = candidates[i]
		if candidate then
			placed[tostring(slot)] = candidate.uuid
		end
	end
	DataService:Update(player, { "PlotSlots" }, function()
		return placed
	end)
end

function PlotService:LevelUp(player: Player, slotArg: any, amount: any)
	local data = DataService:GetLoaded(player)
	local slot = data and validSlot(data, slotArg)
	if not data or not slot or (amount ~= 1 and amount ~= 5) then
		return
	end
	local key = tostring(slot)
	local level = data.SlotLevels[key] or 1
	local coins = data.Fossils
	local spent = 0
	local gained = 0
	for _ = 1, amount do
		local cost = Plots.levelCost(level + gained)
		if level + gained >= Plots.maxLevel or coins - spent < cost then
			break
		end
		spent += cost
		gained += 1
	end
	if gained == 0 then
		Remotes.Notify:FireClient(player, "Pas assez de Fossiles pour monter ce socle.", "error")
		return
	end
	if not CurrencyService:Spend(player, spent, "pedestal") then
		return
	end
	DataService:Update(player, { "SlotLevels", key }, function()
		return level + gained
	end)
	QuestService:Progress(player, "upgrade_pedestal", gained)
end

local function assign(player: Player)
	local folder = ensurePlots()
	for _, plot in folder:GetChildren() do
		if plot:IsA("Model") and plot:GetAttribute("OwnerUserId") == 0 then
			plot:SetAttribute("OwnerUserId", player.UserId)
			plotOf[player] = plot
			setSign(plot, `Parcelle de {player.DisplayName}`)
			return
		end
	end
	warn(`[PlotService] aucune parcelle libre pour {player.Name}`)
end

local function teleportToPlot(player: Player, character: Model)
	local plot = plotOf[player]
	if plot and plot.PrimaryPart then
		character:PivotTo(plot.PrimaryPart.CFrame * CFrame.new(0, 5, PLOT_SIZE / 2 - 6))
	end
end

-- Parcelle d'un joueur (nil s'il n'en a pas).
function PlotService:GetPlot(player: Player): Model?
	return plotOf[player]
end

local function guarded(handler: (Player, ...any) -> ())
	return function(player: Player, ...)
		if limiter:allow(player, ACTION_INTERVAL) then
			handler(player, ...)
		end
	end
end

function PlotService:Init()
	Remotes.PlaceDino.OnServerEvent:Connect(guarded(function(player, uuid, slot)
		self:Place(player, uuid, slot)
	end))
	Remotes.RemoveDino.OnServerEvent:Connect(guarded(function(player, slot)
		self:Remove(player, slot)
	end))
	Remotes.EquipBest.OnServerEvent:Connect(guarded(function(player)
		self:EquipBest(player)
	end))
	Remotes.LevelUpSlot.OnServerEvent:Connect(guarded(function(player, slot, amount)
		self:LevelUp(player, slot, amount)
	end))

	-- Redessine quand ce qui est affiché change : socles, niveaux, rebirths, arbre, ou un dino posé (relance).
	local RENDER_KEYS = { PlotSlots = true, SlotLevels = true, Rebirths = true, Upgrades = true }
	DataService:OnUpdate(function(player, path)
		local data = DataService:GetLoaded(player)
		local placedDinoChanged = path[1] == "Dinos"
			and path[2] ~= nil
			and data ~= nil
			and InventoryService:IsPlaced(data, path[2])
		if RENDER_KEYS[path[1]] or placedDinoChanged then
			queueRender(player)
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		local plot = plotOf[player]
		if plot then
			plot:SetAttribute("OwnerUserId", 0)
			setSign(plot, "Parcelle libre")
			for _, pedestal in (plot:FindFirstChild("Pedestals") :: Instance):GetChildren() do
				for _, child in pedestal:GetChildren() do
					child:Destroy()
				end
			end
		end
		plotOf[player] = nil
		renderQueued[player] = nil
		limiter:forget(player)
	end)
end

function PlotService:Start()
	ensurePlots()
	DataService:OnLoaded(function(player)
		assign(player)
		queueRender(player)
		if player.Character then
			teleportToPlot(player, player.Character)
		end
		player.CharacterAdded:Connect(function(character)
			task.defer(teleportToPlot, player, character)
		end)
	end)

	while true do
		task.wait(LABEL_REFRESH_SECONDS)
		for player in plotOf do
			queueRender(player)
		end
	end
end

return PlotService
