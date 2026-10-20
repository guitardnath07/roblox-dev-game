--!strict
-- Annonce des tirages très rares dans TOUS les serveurs via MessagingService (topic « RarePull »).
-- Au plus 1 message / 5 s par serveur ; les autres attendent dans une file courte.
-- Perdre un message ne casse rien : c'est purement cosmétique.

local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local TOPIC = "RarePull"
local PUBLISH_INTERVAL = 5
local MAX_QUEUE = 10

type Message = { text: string, rarityId: string }

local queue: { Message } = {}

local AnnounceService = {}

-- Met une annonce en file. Si la file est pleine, la plus ancienne est abandonnée.
function AnnounceService:Publish(text: string, rarityId: string)
	if #queue >= MAX_QUEUE then
		table.remove(queue, 1)
	end
	table.insert(queue, { text = text, rarityId = rarityId })
end

local function broadcastLocally(message: Message)
	Remotes.Announcement:FireAllClients(message.text, message.rarityId)
end

function AnnounceService:Start()
	local subscribed = pcall(MessagingService.SubscribeAsync, MessagingService, TOPIC, function(packet)
		local data = packet.Data
		if type(data) == "table" and type(data.text) == "string" and type(data.rarityId) == "string" then
			broadcastLocally({ text = data.text, rarityId = data.rarityId })
		end
	end)

	while true do
		task.wait(PUBLISH_INTERVAL)
		local message = table.remove(queue, 1)
		if message then
			-- Abonné : le message nous revient comme aux autres serveurs. Sinon (Studio sans API), on l'affiche ici.
			local published = subscribed and pcall(MessagingService.PublishAsync, MessagingService, TOPIC, message)
			if not published then
				broadcastLocally(message)
			end
		end
	end
end

return AnnounceService
