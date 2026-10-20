--!strict
-- Direction artistique « carnet d'explorateur préhistorique » : parchemin, pierre taillée, encre brune.
-- Une seule source pour les couleurs et polices de l'interface (les couleurs de rareté viennent de Config/Rarities).

local Theme = {
	-- Polices : titres arrondis, chiffres lisibles.
	TitleFont = Enum.Font.FredokaOne,
	NumberFont = Enum.Font.Gotham,
	BodyFont = Enum.Font.GothamBold,

	-- Parchemin
	Parchment = Color3.fromHex("#F3E5C0"),
	ParchmentDark = Color3.fromHex("#E2CC97"),
	ParchmentDeep = Color3.fromHex("#CDB27A"),
	Ink = Color3.fromHex("#4A3B28"),
	InkSoft = Color3.fromHex("#7A6448"),

	-- Pierre taillée (bordures, boutons)
	Stone = Color3.fromHex("#8C8174"),
	StoneLight = Color3.fromHex("#B5AB9C"),
	StoneDark = Color3.fromHex("#4F473E"),

	-- Accents
	Amber = Color3.fromHex("#F4A93B"),
	AmberDark = Color3.fromHex("#B8741C"),
	Leaf = Color3.fromHex("#6DBE45"),
	LeafDark = Color3.fromHex("#3F7F27"),
	Lava = Color3.fromHex("#D9534F"),
	Sky = Color3.fromHex("#4FA3D9"),
	Gold = Color3.fromHex("#FFD54A"),
	Disabled = Color3.fromHex("#A49C90"),
	White = Color3.new(1, 1, 1),
	Black = Color3.new(0, 0, 0),

	-- Échelle globale : taille logique de référence (téléphone paysage) ; l'UIScale ne descend jamais sous 1
	-- pour que les boutons de 44 px logiques fassent toujours au moins 44 px à l'écran.
	ReferenceSize = Vector2.new(1000, 520),
	MinScale = 1,
	MaxScale = 1.8,
	MinTouch = 44,
}

return table.freeze(Theme)
