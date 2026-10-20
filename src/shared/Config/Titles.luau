--!strict
-- Titres de profil : débloqués par la progression, choisis par le joueur dans son Profil, affichés au-dessus de sa tête.
-- `unlocked` est un calcul pur sur le profil : le serveur (ProfileService) et le client (écran Profil) utilisent le même.
-- Titles[1] est le titre de départ (toujours débloqué). `id` ne change jamais (sauvegardé dans Profile.Title).

local Dinos = require(script.Parent.Dinos)
local Types = require(script.Parent.Parent.Types)

export type Title = {
	id: string,
	displayName: string,
	color: Color3,
	hint: string, -- comment le débloquer (affiché quand il est verrouillé)
	unlocked: (data: Types.ProfileData) -> boolean,
}

local function count(set: { [any]: any }): number
	local n = 0
	for _ in set do
		n += 1
	end
	return n
end

local function foundRarity(data: Types.ProfileData, rarity: string): boolean
	for _, dino in Dinos do
		if dino.rarity == rarity and data.Index.Found[dino.id] then
			return true
		end
	end
	return false
end

local function title(
	id: string,
	displayName: string,
	hex: string,
	hint: string,
	unlocked: (data: Types.ProfileData) -> boolean
): Title
	return table.freeze({ id = id, displayName = displayName, color = Color3.fromHex(hex), hint = hint, unlocked = unlocked })
end

local Titles: { Title } = {
	title("explorer", "Explorateur", "#D8C59A", "Titre de départ", function()
		return true
	end),
	title("roller", "Lanceur Fou", "#4FC3F7", "1 000 lancers", function(d)
		return d.TotalRolls >= 1_000
	end),
	title("dice_master", "Maître des Dés", "#2979FF", "100 000 lancers", function(d)
		return d.TotalRolls >= 100_000
	end),
	title("collector", "Collectionneur", "#81C784", "10 espèces trouvées", function(d)
		return count(d.Index.Found) >= 10
	end),
	title("chief", "Paléontologue en chef", "#FFD54F", "Toutes les espèces trouvées", function(d)
		return count(d.Index.Found) >= #Dinos
	end),
	title("lucky", "Chanceux", "#AED581", "Tirer un dino « 1 sur 10 000 » ou plus rare", function(d)
		return d.BestPull.OneIn >= 10_000
	end),
	title("legend", "Légende Vivante", "#FF7043", "Tirer un dino « 1 sur 1 000 000 » ou plus rare", function(d)
		return d.BestPull.OneIn >= 1_000_000
	end),
	title("reborn", "Renaissant", "#CE93D8", "1 rebirth", function(d)
		return d.Rebirths >= 1
	end),
	title("eternal", "Éternel", "#AB47BC", "10 rebirths", function(d)
		return d.Rebirths >= 10
	end),
	title("lava_tamer", "Dompteur de Lave", "#FF5722", "Étage 25 du Volcan", function(d)
		return d.VolcanoBestFloor >= 25
	end),
	title("volcano_king", "Roi du Volcan", "#D84315", "Étage 100 du Volcan", function(d)
		return d.VolcanoBestFloor >= 100
	end),
	title("primordial", "Primordial", "#1DE9B6", "Trouver un dino Primordial", function(d)
		return foundRarity(d, "primordial")
	end),
	title("glitched", "Glitché", "#E040FB", "Trouver un dino Secret", function(d)
		return foundRarity(d, "secret")
	end),
}

return table.freeze(Titles)
