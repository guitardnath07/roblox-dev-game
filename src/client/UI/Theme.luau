--!strict
-- Surfaces bleu nuit, texte clair et accents cyan / ambre.
-- Une seule source pour les couleurs et polices de l'interface (les couleurs de rareté viennent de Config/Rarities).

local Theme = {
	-- Polices : titres arrondis, chiffres lisibles.
	TitleFont = Enum.Font.GothamBold,
	NumberFont = Enum.Font.Gotham,
	BodyFont = Enum.Font.GothamBold,

	-- Parchemin
	Parchment = Color3.fromHex("#152237"),
	ParchmentDark = Color3.fromHex("#1C2D46"),
	ParchmentDeep = Color3.fromHex("#263C57"),
	Ink = Color3.fromHex("#EDF5FF"),
	InkSoft = Color3.fromHex("#A9BCD2"),

	-- Pierre taillée (bordures, boutons)
	Stone = Color3.fromHex("#38536F"),
	StoneLight = Color3.fromHex("#557492"),
	StoneDark = Color3.fromHex("#0B1424"),

	-- Accents
	Amber = Color3.fromHex("#FFA21F"),
	AmberDark = Color3.fromHex("#B8741C"),
	Leaf = Color3.fromHex("#3CD34B"),
	LeafDark = Color3.fromHex("#73E7B0"),
	Lava = Color3.fromHex("#FF4A3D"),
	Sky = Color3.fromHex("#2F9BFF"),
	Gold = Color3.fromHex("#FFD54A"),
	Neutral = Color3.fromHex("#31445E"), -- boutons neutres « bonbon » (interrupteurs éteints, réglages)
	Disabled = Color3.fromHex("#A49C90"),
	White = Color3.new(1, 1, 1),

	-- Style « cartoon » des fenêtres de simulateur (Sac, Boutique) : panneaux bleu nuit, contours épais.
	Navy = Color3.fromHex("#152237"),
	NavyDeep = Color3.fromHex("#0D1728"),
	NavyLight = Color3.fromHex("#243B56"),
	Cyan = Color3.fromHex("#3FD0FF"),
	Outline = Color3.fromHex("#080F1C"),
	TextMuted = Color3.fromHex("#A9BCD2"),
	Black = Color3.new(0, 0, 0),

	-- Échelle globale : taille logique de référence (téléphone paysage) ; l'UIScale ne descend jamais sous 1
	-- pour que les boutons de 44 px logiques fassent toujours au moins 44 px à l'écran.
	ReferenceSize = Vector2.new(1000, 520),
	MinScale = 1,
	MaxScale = 1.8,
	MinTouch = 44,
}

return table.freeze(Theme)
