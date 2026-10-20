--!strict
-- Constantes globales d'économie et de social (une seule source de vérité).
-- DataService lit `offlineCapSeconds` et `startingBackpackSize` : ne pas renommer.

return table.freeze({
	offlineCapSeconds = 8 * 3600, -- plafond du revenu hors ligne
	offlineRate = 0.5, -- part du revenu par seconde payée pendant l'absence
	studioStartingFossils = 100_000, -- Studio sans accès DataStore uniquement (rien n'est sauvegardé)
	startingBackpackSize = 30, -- places du sac avant Sac I-IV (Upgrades)

	-- Délai de base entre deux lancers, avant bonus de vitesse (miroir de BASE_COOLDOWN dans RollService).
	-- shortcut: RollService garde sa propre constante tant qu'il n'est pas branché sur cette table.
	rollCooldownSeconds = 1.0,

	-- shortcut: proposition (non définie dans CLAUDE.md) : prix de vente = revenu/s du dino x ce nombre de secondes.
	sellValueSeconds = 10,

	-- Coût d'UNE relance (Prompt 6 : 1 Os par relance d'Instinct, « même principe » pour le Grade).
	gradeRerollCostAmber = 1,
	instinctRerollCostFossils = 1,
	-- Relance d'Empreinte : 5 % du coût du prochain rebirth, en Fossiles (Prompt 6).
	imprintRerollCostRatio = 0.05,
	maxAutoRerolls = 1_000, -- l'auto-relance s'arrête au plus tard après ce nombre de relances

	-- Pastilles d'Ambre sur la map : réapparaissent toutes les 2 min, +2 Ambre au toucher.
	amberPickupAmount = 2,
	amberPickupRespawnSeconds = 120,
	baseWalkSpeed = 16,

	-- Annonce dans tous les serveurs pour un tirage affiché ≥ 1 sur ce nombre.
	globalAnnounceOneIn = 1_000_000,

	Social = table.freeze({
		serverSize = 9,
		tradeUnlockRolls = 1_000,
		friendCoinsBonus = 0.05, -- +5 % de Fossiles par ami dans le serveur
		friendCoinsBonusMax = 0.20,
	}),

	-- Paléo-Encyclopédie : récompense au N-ième dino différent trouvé.
	-- shortcut: montants proposés (CLAUDE.md ne donne que les paliers).
	-- stylua: ignore
	IndexMilestones = table.freeze({
		table.freeze({ found = 5, amber = 25, bones = 0, title = "" }),
		table.freeze({ found = 10, amber = 50, bones = 20, title = "" }),
		table.freeze({ found = 15, amber = 100, bones = 40, title = "" }),
		table.freeze({ found = 20, amber = 200, bones = 80, title = "" }),
		table.freeze({ found = 28, amber = 500, bones = 200, title = "Paléontologue en chef" }),
	}),
})
