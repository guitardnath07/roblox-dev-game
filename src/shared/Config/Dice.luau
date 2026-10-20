--!strict
-- Dés achetés avec des Fossiles. `luck` multiplie la chance ; aucune garantie de rareté.
-- Dice[1] est le dé de départ (équipé par défaut dans le profil). `id` ne change jamais.
-- `color` / `material` : apparence suggérée du dé (UI + modèle 3D).
-- `treeOnly` : dé offert par l'arbre d'améliorations (Config/Upgrades, stat « diceUnlock »), jamais vendu en boutique.

export type Die = {
	id: string,
	displayName: string,
	luck: number,
	price: number, -- en Fossiles ; 0 = dé de départ
	color: Color3,
	material: Enum.Material,
	treeOnly: boolean?,
}

local function die(
	id: string,
	displayName: string,
	luck: number,
	price: number,
	hex: string,
	material: Enum.Material,
	treeOnly: boolean?
): Die
	return table.freeze({
		id = id,
		displayName = displayName,
		luck = luck,
		price = price,
		color = Color3.fromHex(hex),
		material = material,
		treeOnly = treeOnly,
	})
end

-- stylua: ignore
local Dice: { Die } = {
	die("pebble", "Dé Galet", 1, 0, "#9E9A91", Enum.Material.Slate),
	die("fern", "Dé Fougère", 3, 500, "#5DAA4A", Enum.Material.Grass),
	die("amber", "Dé Ambre", 8, 5_000, "#F2A33A", Enum.Material.Glass),
	die("lava", "Dé Lave", 20, 50_000, "#E2502C", Enum.Material.CrackedLava),
	die("golden", "Dé en Or", 30, 0, "#FFC400", Enum.Material.Foil, true),
	die("glacier", "Dé Glacier", 50, 400_000, "#8FD3F4", Enum.Material.Ice),
	die("storm", "Dé Tempête", 120, 3e6, "#5B6CC9", Enum.Material.Neon),
	die("fossil", "Dé Fossile", 300, 25e6, "#D8C7A0", Enum.Material.Limestone),
	die("diamond", "Dé de Diamant", 400, 0, "#7FE8FF", Enum.Material.Glass, true),
	die("meteor", "Dé Météore", 800, 200e6, "#6B4F3A", Enum.Material.Basalt),
	die("eclipse", "Dé Éclipse", 2_000, 1.5e9, "#2B2140", Enum.Material.Glass),
	die("rainbow", "Dé Arc-en-ciel", 3_000, 0, "#FF5FD2", Enum.Material.Neon, true),
	die("ancient_volcano", "Dé Volcan Ancien", 5_000, 12e9, "#B3261E", Enum.Material.CrackedLava),
	die("comet", "Dé Comète", 12_000, 100e9, "#B9F0FF", Enum.Material.Neon),
	die("primordial", "Dé Primordial", 30_000, 900e9, "#1DE9B6", Enum.Material.ForceField),
	die("nebula", "Dé Nébuleuse", 80_000, 8e12, "#A35BD9", Enum.Material.Glass),
	die("big_bang", "Dé Big Bang", 250_000, 80e12, "#FFF4C2", Enum.Material.Neon),
}

return table.freeze(Dice)
