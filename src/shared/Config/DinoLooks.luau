--!strict
-- Généré par blender/scripts/export_luau.py : ne pas éditer à la main.
-- Palette par dino (slots du mesh : 1 main, 2 belly, 3 accent, 6 glow, 7 back).
-- Slots fixés dans le code : 4 blanc d'œil / dents, 5 pupille, 8 intérieur de bouche, 9 langue.

export type DinoLook = { colors: { main: string, belly: string, accent: string, glow: string, back: string } }

local DinoLooks: { [string]: DinoLook } = {
	chronoraptor = { colors = { main = "#B0BEC5", belly = "#FFE27A", accent = "#FFB300", glow = "#00E5FF", back = "#546E7A" } },
	galetosaure = { colors = { main = "#9AA5B1", belly = "#E6E1D3", accent = "#7BC67E", glow = "#FFB74D", back = "#6B7785" } },
	lianopteryx = { colors = { main = "#43A047", belly = "#C5E1A5", accent = "#FFEB3B", glow = "#FF9800", back = "#2E7D32" } },
	moussecrete = { colors = { main = "#5DBB63", belly = "#F2E8C9", accent = "#2E7D32", glow = "#C6FF6B", back = "#3F9A48" } },
}

for _, look in DinoLooks do
	table.freeze(look.colors)
	table.freeze(look)
end

return table.freeze(DinoLooks)
