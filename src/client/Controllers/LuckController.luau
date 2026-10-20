--!strict
-- Copie du détail de chance renvoyé par le serveur (GetLuckBreakdown) : total, facteurs, délai de lancer.
-- Rafraîchi quand le profil change (dé, arbre, rebirth, potions, dinos posés, reliques), quand l'événement
-- serveur change, et toutes les 15 s (expiration des potions, passes).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Bonuses = require(ReplicatedStorage.Shared.Bonuses)
local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local DataController = require(script.Parent.DataController)

-- incomePerSecond : revenu réel (passes et amis compris), calculé par le serveur.
export type Breakdown = { total: number, factors: { Bonuses.Factor }, cooldown: number, incomePerSecond: number }

local REFRESH_SECONDS = 15
local WATCHED =
	{ "EquippedDice", "Upgrades", "Rebirths", "ActivePotions", "PlotSlots", "SlotLevels", "EquippedRelics", "Dinos" }

local state: Breakdown = { total = 1, factors = {}, cooldown = 1, incomePerSecond = 0 }
local listeners: { (Breakdown) -> () } = {}
local queued = false

local LuckController = {}

function LuckController:Get(): Breakdown
	return state
end

function LuckController:OnChanged(fn: (Breakdown) -> ()): () -> ()
	table.insert(listeners, fn)
	return function()
		local i = table.find(listeners, fn)
		if i then
			table.remove(listeners, i)
		end
	end
end

local function fetch()
	queued = false
	local ok, result = pcall(function()
		return Remotes.GetLuckBreakdown:InvokeServer()
	end)
	if ok and type(result) == "table" and type(result.total) == "number" then
		state = {
			total = result.total,
			factors = if type(result.factors) == "table" then result.factors else {},
			cooldown = if type(result.cooldown) == "number" then result.cooldown else 1,
			incomePerSecond = if type(result.incomePerSecond) == "number" then result.incomePerSecond else 0,
		}
		for _, fn in listeners do
			task.spawn(fn, state)
		end
	end
end

-- Demande un rafraîchissement (regroupé : un seul appel serveur par image).
function LuckController:Refresh()
	if not queued then
		queued = true
		task.delay(0.1, fetch)
	end
end

function LuckController:Start()
	DataController:Get()
	self:Refresh()
	for _, key in WATCHED do
		DataController:OnChanged(key, function(path)
			-- Un nouveau dino tiré ne change rien ; une relance (Empreinte, Instinct, Grade) change chance ou revenu.
			if key ~= "Dinos" or path[3] == "imprint" or path[3] == "instinct" or path[3] == "grade" then
				self:Refresh()
			end
		end)
	end
	Workspace:GetAttributeChangedSignal("ServerEvent"):Connect(function()
		self:Refresh()
	end)
	while true do
		task.wait(REFRESH_SECONDS)
		self:Refresh()
	end
end

return LuckController
