--!strict
-- Généré par blender/scripts/export_luau.py : ne pas éditer à la main.
-- Palette par dino (slots du mesh : 1 main, 2 belly, 3 accent, 6 glow, 7 back).
-- Slots fixés dans le code : 4 blanc d'œil / dents, 5 pupille, 8 intérieur de bouche, 9 langue.

export type DinoLook = { colors: { main: string, belly: string, accent: string, glow: string, back: string } }

local DinoLooks: { [string]: DinoLook } = {
	chronoraptor = { colors = { main = "#B0BEC5", belly = "#FFE27A", accent = "#FFB300", glow = "#00E5FF", back = "#546E7A" } },
}

for _, look in DinoLooks do
	table.freeze(look.colors)
	table.freeze(look)
end

return table.freeze(DinoLooks)
