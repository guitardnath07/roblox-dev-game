--!strict
-- Asset Mesh Roblox publié par dino (couleurs de la peau Normale cuites dans les sommets, os skinnés).
-- Raison : le client ne garde que ~8 EditableMesh à la fois, l'Index en demande 29 d'un coup.
-- Un dino absent d'ici retombe sur l'EditableMesh construit au runtime (DinoModels.meshFor).
-- Les peaux mutées (Ambre, Jade…) passent encore par l'EditableMesh, avec repli sur l'asset si le budget est plein.

-- IDs importés via Studio (Importer 3D) le 21/10/2026 depuis Desktop/Dino Dice - FBX.
local DinoMeshIds: { [string]: number } = {
	abyssaure = 106241536460633,
	ambrelion = 134425886225357,
	aurorasaure = 78260564189316,
	bouceratops = 130850353468170,
	braisedos = 120679637883051,
	brindilraptor = 137569491667670,
	chronoraptor = 92112547168666,
	cristalodon = 107002987489178,
	eclipsaurus = 95618929287232,
	flaquodon = 130532428488718,
	gaiatops = 81413606886269,
	galetosaure = 135231113195300,
	givrecroc = 135652869808140,
	glitchosaure = 124051519264509,
	leviathodon = 133219228035963,
	lianopteryx = 83363697804661,
	magmaroi = 127674176031163,
	moussecrete = 128542583469682,
	nebulodon = 138521429210084,
	omegarex = 104521116376162,
	orageceros = 126050332623472,
	peluchorex = 139343806428590,
	ronceplaque = 127867296564702,
	sablegriffe = 116101795558317,
	solaripteryx = 99721357540505,
	spectrosaure = 84925817543224,
	titanomarbre = 123559030662553,
	tonnerrex = 94129897042710,
	volcanokeros = 117004102274047,
}

return DinoMeshIds
