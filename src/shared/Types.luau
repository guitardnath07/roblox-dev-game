--!strict
-- Types partagés entre serveur et client.

-- Un exemplaire de dino possédé (identifié par un UUID serveur).
export type DinoInstance = {
	dinoId: string,
	size: string, -- Mutations.Sizes[].id
	skin: string, -- Mutations.Skins[].id
	instinct: string, -- Instincts[].id
	grade: string?, -- Grades[].id ; nil tant que jamais relancé
	imprint: string?, -- Imprints[].id
	obtainedAt: number, -- os.time()
	locked: boolean,
}

-- Ce que le serveur renvoie au client après un tirage.
export type RollResult = {
	uuid: string,
	dinoId: string,
	size: string,
	skin: string,
	clover: number, -- multiplicateur du trèfle, 1 = aucun
	oneInDisplayed: number,
	isNewInIndex: boolean,
}

-- Réponse d'une relance : ok + les résultats successifs (le dernier est gardé), ou ok = false + raison.
export type RerollResponse = {
	ok: boolean,
	results: { string }?,
	reason: string?,
}

-- État d'un échange envoyé aux deux joueurs. `you` / `them` vus depuis le joueur qui reçoit.
-- Les dinos proposés sont envoyés en entier pour que chacun voie ce qu'il reçoit.
export type TradeSide = {
	userId: number,
	name: string,
	dinos: { [string]: DinoInstance }, -- uuid -> exemplaire proposé
	amber: number,
	bones: number,
	ready: boolean,
	confirmed: boolean,
}

export type TradeState = {
	phase: "offer" | "countdown" | "confirm",
	countdownEndsAt: number?, -- workspace:GetServerTimeNow() de fin du compte à rebours
	you: TradeSide,
	them: TradeSide,
}

-- Quêtes du jour / de la semaine en cours. `period` = numéro du jour (ou de la semaine) UTC de tirage.
export type QuestProgress = { id: string, progress: number, claimed: boolean }
export type QuestState = {
	dailyPeriod: number,
	weeklyPeriod: number,
	daily: { QuestProgress },
	weekly: { QuestProgress },
}

-- État du Volcan envoyé au joueur.
export type VolcanoState = {
	phase: "fighting" | "won" | "lost",
	floor: number,
	isBoss: boolean,
	enemyHealth: number,
	team: { { uuid: string, dinoId: string, health: number, damage: number } },
	rewards: { amber: number, bones: number, potionId: string?, relicId: string? }?,
	auto: boolean,
}

-- Ensemble sérialisable en DataStore : clé -> true.
export type Set = { [string]: boolean }

-- Profil sauvegardé d'un joueur. Les clés numériques (socles) sont des chaînes pour rester du JSON valide.
export type ProfileData = {
	DataVersion: number,
	Fossils: number,
	Amber: number,
	Bones: number,
	GoldenRolls: number,
	Tickets: number,
	TotalRolls: number,
	Rebirths: number,
	EquippedDice: string,
	OwnedDice: Set,
	Dinos: { [string]: DinoInstance }, -- uuid -> exemplaire
	PlotSlots: { [string]: string }, -- index du socle -> uuid
	SlotLevels: { [string]: number }, -- index du socle -> niveau
	Upgrades: Set,
	Relics: { [string]: { relicId: string, obtainedAt: number } }, -- uuid -> relique
	EquippedRelics: { [string]: string }, -- emplacement -> uuid
	Index: { Found: Set, ClaimedMilestones: Set },
	Quests: QuestState,
	Daily: { Streak: number, LastClaim: number }, -- LastClaim = numéro du jour UTC réclamé
	GroupChestLastClaim: number, -- os.time()
	RedeemedCodes: Set,
	ActivePotions: { [string]: number }, -- Products.potions[].id -> os.time() d'expiration
	Potions: { [string]: number }, -- Products.potions[].id -> nombre de potions en réserve
	TradeLog: { any }, -- 20 derniers échanges { with, gave, got, at }
	VolcanoBestFloor: number, -- plus haut étage gagné (0 = aucun)
	ProcessedPurchases: { string }, -- 100 derniers PurchaseId
	Settings: { AutoRoll: boolean, HideReveal: boolean, Music: boolean, Sfx: boolean },
	LastOnline: number, -- os.time() de la dernière sauvegarde
	LastIncomePerSecond: number, -- revenu au moment du départ, pour les gains hors ligne
	BestPull: { DinoId: string, OneIn: number },
	Profile: { Title: string, Showcase: string }, -- titre choisi (Config/Titles) et dino vitrine (id d'espèce)
	Stats: { [string]: number },
}

-- Message de synchronisation serveur -> client.
-- "full" : data = profil complet ; "set" : path = chemin de clés, value = nouvelle valeur (nil = supprimé).
export type DataSyncMessage = {
	kind: "full" | "set",
	data: ProfileData?,
	path: { string }?,
	value: any,
}

return {}
