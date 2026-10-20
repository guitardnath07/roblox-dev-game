--!strict
-- Événements serveur : toutes les 30 min, un événement aléatoire de 5 min (Config/Events).
-- L'état est publié en attributs du Workspace, lus par le serveur (LuckService, IncomeService) et les clients
-- (ciel, bannière, compte à rebours) :
--   ServerEvent = id en cours ("" = aucun), ServerEventEndsAt / NextServerEventAt = workspace:GetServerTimeNow().

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Events = require(ReplicatedStorage.Shared.Config.Events)

local rng = Random.new()

local EventService = {}

function EventService:Start()
	Workspace:SetAttribute("ServerEvent", "")
	-- Un événement commence toutes les `intervalSeconds` (le temps de l'événement est compris dedans).
	local pause = Events.intervalSeconds - Events.durationSeconds
	while true do
		Workspace:SetAttribute("NextServerEventAt", Workspace:GetServerTimeNow() + pause)
		task.wait(pause)

		local event = Events.list[rng:NextInteger(1, #Events.list)]
		Workspace:SetAttribute("ServerEventEndsAt", Workspace:GetServerTimeNow() + Events.durationSeconds)
		Workspace:SetAttribute("ServerEvent", event.id)
		task.wait(Events.durationSeconds)
		Workspace:SetAttribute("ServerEvent", "")
	end
end

return EventService
