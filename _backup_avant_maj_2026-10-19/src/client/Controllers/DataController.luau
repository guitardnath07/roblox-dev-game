--!strict
-- Copie en lecture seule du profil, tenue à jour par le remote DataSync.
-- Usage : DataController:Get() (attend le chargement), DataController:OnChanged("Coins", fn).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local Types = require(ReplicatedStorage.Shared.Types)

type Listener = (path: { string }, value: any) -> ()

local data: Types.ProfileData? = nil
local listeners: { [string]: { Listener } } = {} -- clé de premier niveau -> écouteurs ; "*" = tout
local loaded = Instance.new("BindableEvent")

local DataController = {}

-- Attend le premier chargement puis renvoie le profil. Ne jamais le modifier côté client.
function DataController:Get(): Types.ProfileData
	while data == nil do
		loaded.Event:Wait()
	end
	return data :: Types.ProfileData
end

-- Appelle `fn(path, value)` à chaque changement sous `key` (ex. "Coins", "Dinos") ; "*" pour tout.
-- Renvoie une fonction qui retire l'écouteur.
function DataController:OnChanged(key: string, fn: Listener): () -> ()
	local list = listeners[key] or {}
	listeners[key] = list
	table.insert(list, fn)
	return function()
		local index = table.find(list, fn)
		if index then
			table.remove(list, index)
		end
	end
end

local function notify(path: { string }, value: any)
	for _, key in { path[1], "*" } do
		for _, fn in listeners[key] or {} do
			task.spawn(fn, path, value)
		end
	end
end

function DataController:Init()
	Remotes.DataSync.OnClientEvent:Connect(function(message: Types.DataSyncMessage)
		if message.kind == "full" then
			data = message.data
			loaded:Fire()
			for key, value in data :: any do
				notify({ key }, value)
			end
		elseif message.kind == "set" and data and message.path then
			local parent: any = data
			for i = 1, #message.path - 1 do
				parent = parent[message.path[i]]
				if type(parent) ~= "table" then
					return
				end
			end
			parent[message.path[#message.path]] = message.value
			notify(message.path, message.value)
		end
	end)
end

return DataController
