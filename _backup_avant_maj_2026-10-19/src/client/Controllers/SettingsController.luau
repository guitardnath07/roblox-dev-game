--!strict
-- Réglages du joueur (Auto-Lancer, Masquer, Musique, Effets). Valeurs de départ = profil (Settings).
-- Chaque changement est envoyé au serveur (SetSetting), qui le sauvegarde dans le profil.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local Types = require(ReplicatedStorage.Shared.Types)
local DataController = require(script.Parent.DataController)

export type Key = "AutoRoll" | "HideReveal" | "Music" | "Sfx"

local values: { [string]: boolean } = { AutoRoll = false, HideReveal = false, Music = true, Sfx = true }
local listeners: { (key: string, value: boolean) -> () } = {}

local SettingsController = {}

function SettingsController:Get(key: Key): boolean
	return values[key] == true
end

function SettingsController:Set(key: Key, value: boolean)
	if values[key] == value then
		return
	end
	values[key] = value
	Remotes.SetSetting:FireServer(key, value)
	for _, fn in listeners do
		task.spawn(fn, key, value)
	end
end

-- Appelle `fn(key, value)` à chaque changement. Renvoie la fonction qui retire l'écouteur.
function SettingsController:OnChanged(fn: (key: string, value: boolean) -> ()): () -> ()
	table.insert(listeners, fn)
	return function()
		local i = table.find(listeners, fn)
		if i then
			table.remove(listeners, i)
		end
	end
end

function SettingsController:Start()
	local data: Types.ProfileData = DataController:Get()
	local saved = data.Settings
	if saved then
		values.HideReveal = saved.HideReveal == true
		values.Music = saved.Music ~= false
		values.Sfx = saved.Sfx ~= false
		if saved.AutoRoll == true then
			self:Set("AutoRoll", true) -- relance la boucle d'Auto-Lancer (RollController écoute)
		end
	end
end

return SettingsController
