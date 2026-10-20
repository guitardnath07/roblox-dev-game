--!strict
-- Profil public : titre choisi + dino vitrine (Profile.Title / Profile.Showcase).
-- Le client demande (SetProfile) ; le serveur vérifie que le titre est débloqué et que l'espèce a été trouvée.
-- Le titre est affiché au-dessus de la tête du joueur (visible par tous) et publié en attributs du Player
-- (Title, TitleColor, Showcase) pour que les autres clients puissent le lire.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Remotes = require(Shared.Net.Remotes)
local Titles = require(Shared.Config.Titles)
local Types = require(Shared.Types)

local DataService = require(script.Parent.DataService)
local RateLimit = require(script.Parent.Parent.Data.RateLimit)

local ACTION_INTERVAL = 0.3
local OVERHEAD_NAME = "DinoTitle"

local limiter = RateLimit.new()

local ProfileService = {}

local function titleById(id: any): Titles.Title?
	for _, t in Titles do
		if t.id == id then
			return t
		end
	end
	return nil
end

-- Titre réellement affiché : celui choisi s'il est (encore) débloqué, sinon le titre de départ.
function ProfileService:GetTitle(data: Types.ProfileData): Titles.Title
	local chosen = titleById(data.Profile.Title)
	return if chosen and chosen.unlocked(data) then chosen else Titles[1]
end

local function overhead(player: Player, t: Titles.Title)
	local character = player.Character
	local head = character and character:FindFirstChild("Head")
	if not head then
		return
	end
	local gui = head:FindFirstChild(OVERHEAD_NAME) :: BillboardGui?
	if not gui then
		local new = Instance.new("BillboardGui")
		new.Name = OVERHEAD_NAME
		new.Size = UDim2.fromOffset(200, 26)
		new.StudsOffset = Vector3.new(0, 2.6, 0)
		new.MaxDistance = 60
		new.LightInfluence = 0
		local label = Instance.new("TextLabel")
		label.Name = "Text"
		label.BackgroundTransparency = 1
		label.Size = UDim2.fromScale(1, 1)
		label.Font = Enum.Font.FredokaOne
		label.TextScaled = true
		label.TextStrokeTransparency = 0.3
		label.Parent = new
		new.Parent = head
		gui = new
	end
	local label = (gui :: BillboardGui):FindFirstChild("Text") :: TextLabel
	label.Text = t.displayName
	label.TextColor3 = t.color
end

local function apply(player: Player)
	local data = DataService:GetLoaded(player)
	if not data then
		return
	end
	local t = ProfileService:GetTitle(data)
	player:SetAttribute("Title", t.displayName)
	player:SetAttribute("TitleColor", t.color)
	player:SetAttribute("Showcase", data.Profile.Showcase)
	overhead(player, t)
end

local function setProfile(player: Player, kind: any, id: any)
	local data = DataService:GetLoaded(player)
	if not data or type(id) ~= "string" or #id > 64 then
		return
	end
	if kind == "Title" then
		local t = titleById(id)
		if not t or not t.unlocked(data) then
			return
		end
		DataService:Update(player, { "Profile", "Title" }, function()
			return id
		end)
	elseif kind == "Showcase" then
		if data.Index.Found[id] ~= true then
			return
		end
		DataService:Update(player, { "Profile", "Showcase" }, function()
			return id
		end)
	else
		return
	end
	apply(player)
end

function ProfileService:Init()
	Remotes.SetProfile.OnServerEvent:Connect(function(player: Player, kind: any, id: any)
		if limiter:allow(player, ACTION_INTERVAL) then
			setProfile(player, kind, id)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		limiter:forget(player)
	end)
end

function ProfileService:Start()
	DataService:OnLoaded(function(player: Player)
		apply(player)
		player.CharacterAdded:Connect(function(character)
			character:WaitForChild("Head", 10)
			apply(player)
		end)
	end)
	-- Un nouveau titre peut se débloquer en jouant (lancers, rebirths, espèces) : on garde l'affichage juste.
	DataService:OnUpdate(function(player: Player, path: { string })
		local key = path[1]
		if key == "TotalRolls" or key == "Rebirths" or key == "Index" or key == "BestPull" or key == "VolcanoBestFloor" then
			apply(player)
		end
	end)
end

return ProfileService
