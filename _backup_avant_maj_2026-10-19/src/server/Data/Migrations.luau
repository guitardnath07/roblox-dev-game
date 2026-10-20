--!strict
-- Migrations ordonnées du profil. Migrations[v] transforme un profil de la version v - 1 vers v.
-- Pour une nouvelle version : ajouter Migrations[v + 1] et monter CURRENT_VERSION dans Template.luau.

local Migrations: { [number]: (data: { [string]: any }) -> () } = {
	-- v0 -> v1 : profils créés avant le champ DataVersion (aucun en production, sert de modèle et de test).
	[1] = function(data)
		data.DataVersion = 1
	end,
}

-- Applique toutes les migrations manquantes, dans l'ordre. Ne fait rien si le profil est déjà à jour.
-- Un profil plus récent que le code (serveur pas encore mis à jour) est laissé tel quel.
local function run(data: { [string]: any }, currentVersion: number)
	local version = if type(data.DataVersion) == "number" then data.DataVersion else 0
	for v = version + 1, currentVersion do
		local migrate = Migrations[v]
		assert(migrate, `migration manquante vers la version {v}`)
		migrate(data)
		data.DataVersion = v
	end
end

return {
	run = run,
}
