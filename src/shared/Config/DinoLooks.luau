--!strict
-- Généré par blender/scripts/export_luau.py : ne pas éditer à la main.
-- Palette par dino (slots du mesh : 1 main, 2 belly, 3 accent, 6 glow, 7 back).
-- Slots fixés dans le code : 4 blanc d'œil / dents, 5 pupille, 8 intérieur de bouche, 9 langue.

export type DinoLook = { colors: { main: string, belly: string, accent: string, glow: string, back: string } }

local DinoLooks: { [string]: DinoLook } = {
	abyssaure = { colors = { main = "#1A237E", belly = "#283593", accent = "#00E5FF", glow = "#E0FFFF", back = "#0B1150" } },
	ambrelion = { colors = { main = "#FF8F00", belly = "#FFE082", accent = "#6D4C41", glow = "#FFCA28", back = "#D84315" } },
	aurorasaure = { colors = { main = "#00BFA5", belly = "#7C4DFF", accent = "#F48FB1", glow = "#B9F6CA", back = "#00796B" } },
	bouceratops = { colors = { main = "#FFA62B", belly = "#FFF3E0", accent = "#8D6E63", glow = "#2FD158", back = "#E0731A" } },
	braisedos = { colors = { main = "#D32F2F", belly = "#FFD8A0", accent = "#FFB300", glow = "#FF6D00", back = "#4E342E" } },
	brindilraptor = { colors = { main = "#B5835A", belly = "#F3D9A4", accent = "#6D9B3A", glow = "#9CCC65", back = "#7A5236" } },
	chronoraptor = { colors = { main = "#B0BEC5", belly = "#FFE27A", accent = "#FFB300", glow = "#00E5FF", back = "#546E7A" } },
	cristalodon = { colors = { main = "#7E57C2", belly = "#E1BEE7", accent = "#80DEEA", glow = "#E0F7FA", back = "#4527A0" } },
	eclipsaurus = { colors = { main = "#212121", belly = "#FFF8E1", accent = "#FFD54F", glow = "#FFE57F", back = "#2F2940" } },
	flaquodon = { colors = { main = "#4FC3F7", belly = "#E1F5FE", accent = "#0288D1", glow = "#B2FFFF", back = "#8BC34A" } },
	gaiatops = { colors = { main = "#8B5A3C", belly = "#E6CBA8", accent = "#4CAF50", glow = "#FF80AB", back = "#5A3824" } },
	galetosaure = { colors = { main = "#9AA5B1", belly = "#E6E1D3", accent = "#7BC67E", glow = "#FFB74D", back = "#6B7785" } },
	givrecroc = { colors = { main = "#B3E5FC", belly = "#F5FBFF", accent = "#4FC3F7", glow = "#7FF6FF", back = "#7FB8DA" } },
	glitchosaure = { colors = { main = "#FF00FF", belly = "#00FF00", accent = "#000000", glow = "#00FFFF", back = "#9C00D6" } },
	leviathodon = { colors = { main = "#004D40", belly = "#00838F", accent = "#64FFDA", glow = "#A7FFEB", back = "#00332B" } },
	lianopteryx = { colors = { main = "#43A047", belly = "#C5E1A5", accent = "#FFEB3B", glow = "#FF9800", back = "#2E7D32" } },
	magmaroi = { colors = { main = "#6B6262", belly = "#F4511E", accent = "#FF6D00", glow = "#FFAB00", back = "#262222" } },
	moussecrete = { colors = { main = "#5DBB63", belly = "#F2E8C9", accent = "#2E7D32", glow = "#C6FF6B", back = "#3F9A48" } },
	nebulodon = { colors = { main = "#311B92", belly = "#E040FB", accent = "#FFFFFF", glow = "#B388FF", back = "#1A0E5C" } },
	omegarex = { colors = { main = "#2D1B69", belly = "#7B1FA2", accent = "#B388FF", glow = "#FFD740", back = "#0D0221" } },
	orageceros = { colors = { main = "#546E7A", belly = "#B0BEC5", accent = "#FFEE58", glow = "#FFF176", back = "#263238" } },
	ronceplaque = { colors = { main = "#7B1FA2", belly = "#A5D6A7", accent = "#E91E63", glow = "#FF4F9A", back = "#4A148C" } },
	sablegriffe = { colors = { main = "#E8C07D", belly = "#FFF1D0", accent = "#FF7043", glow = "#FFAB91", back = "#C68B4E" } },
	solaripteryx = { colors = { main = "#FFC107", belly = "#FF6F00", accent = "#FFFDE7", glow = "#FFEA00", back = "#E65100" } },
	spectrosaure = { colors = { main = "#CFD8DC", belly = "#80CBC4", accent = "#B388FF", glow = "#D1B3FF", back = "#78909C" } },
	titanomarbre = { colors = { main = "#F5F5F5", belly = "#BDBDBD", accent = "#FFD700", glow = "#FFC400", back = "#DCDCDC" } },
	tonnerrex = { colors = { main = "#1565C0", belly = "#90CAF9", accent = "#B0BEC5", glow = "#FFFF00", back = "#0D47A1" } },
	volcanokeros = { colors = { main = "#7B3F2A", belly = "#E8B48A", accent = "#FF5722", glow = "#FFB300", back = "#3B211A" } },
}

for _, look in DinoLooks do
	table.freeze(look.colors)
	table.freeze(look)
end

return table.freeze(DinoLooks)
