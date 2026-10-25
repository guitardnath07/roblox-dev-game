--!strict
-- Tous les remotes du jeu, déclarés ici et nulle part ailleurs.
-- Le serveur les crée dans ReplicatedStorage.Remotes ; le client les attend.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local folder: Instance
if RunService:IsServer() then
	folder = Instance.new("Folder")
	folder.Name = "Remotes"
	folder.Parent = ReplicatedStorage
else
	folder = ReplicatedStorage:WaitForChild("Remotes")
end

local function remote(className: string, name: string): Instance
	if RunService:IsServer() then
		local instance = Instance.new(className)
		instance.Name = name
		instance.Parent = folder
		return instance
	end
	return folder:WaitForChild(name)
end

local function event(name: string): RemoteEvent
	return remote("RemoteEvent", name) :: RemoteEvent
end

local function func(name: string): RemoteFunction
	return remote("RemoteFunction", name) :: RemoteFunction
end

return table.freeze({
	-- client -> serveur : intention « lancer », aucun argument. Le serveur applique le délai.
	RequestRoll = event("RequestRoll"),
	-- client -> serveur : lancer avec un Lancer Doré (ignore le délai, consomme 1 Lancer Doré).
	UseGoldenRoll = event("UseGoldenRoll"),
	-- serveur -> client : Types.RollResult.
	RollResult = event("RollResult"),
	-- client -> serveur : (uuids: { string }) à vendre.
	SellDinos = event("SellDinos"),
	-- client -> serveur : (maxRarityOrder: number) vend tous les dinos non posés et non verrouillés jusqu'à cette rareté.
	SellAllUnplaced = event("SellAllUnplaced"),
	-- client -> serveur : (uuids: { string }) reliques à vendre au Comptoir (les équipées sont ignorées).
	SellRelics = event("SellRelics"),
	-- client -> serveur : ({ [potionId]: number }) vend des potions de réserve contre des Tickets.
	SellPotions = event("SellPotions"),
	-- client -> serveur : (uuid: string) verrouille / déverrouille un dino.
	ToggleLock = event("ToggleLock"),
	-- client -> serveur : (uuid: string, slot: number) pose un dino sur un socle de sa parcelle.
	PlaceDino = event("PlaceDino"),
	-- client -> serveur : (slot: number) reprend le dino du socle.
	RemoveDino = event("RemoveDino"),
	-- client -> serveur : pose automatiquement les dinos au meilleur revenu.
	EquipBest = event("EquipBest"),
	-- client -> serveur : (slot: number, amount: 1 | 5) monte le niveau d'un socle.
	LevelUpSlot = event("LevelUpSlot"),
	-- client -> serveur : (upgradeId: string) achète un nœud de l'arbre.
	BuyUpgrade = event("BuyUpgrade"),
	-- client -> serveur : (diceId: string) achète un dé (puis l'équipe).
	BuyDice = event("BuyDice"),
	-- client -> serveur : (diceId: string) équipe un dé déjà possédé.
	EquipDice = event("EquipDice"),
	-- client -> serveur : rebirth (le client a déjà montré la confirmation).
	Rebirth = event("Rebirth"),
	-- client -> serveur, renvoie Types.RerollResponse : (uuid, count, stopAtId?) relance l'Instinct (Os).
	RerollInstinct = func("RerollInstinct"),
	-- client -> serveur, renvoie Types.RerollResponse : (uuid, count, stopAtId?) relance le Grade (Ambre).
	RerollGrade = func("RerollGrade"),
	-- client -> serveur, renvoie Types.RerollResponse : (uuid) relance l'Empreinte (Fossiles, rebirth 5+).
	RerollImprint = func("RerollImprint"),
	-- client -> serveur : (key: string, value: boolean) enregistre un réglage (AutoRoll, AutoEquip, HideReveal, Music, Sfx).
	SetSetting = event("SetSetting"),
	-- client -> serveur, renvoie { total, factors: { Bonuses.Factor }, cooldown, incomePerSecond }.
	GetLuckBreakdown = func("GetLuckBreakdown"),
	-- client -> serveur : (kind: "pass" | "product", id: string) demande d'achat Robux (le serveur vérifie
	-- PolicyService puis ouvre la fenêtre d'achat Roblox). L'octroi passe uniquement par ProcessReceipt.
	PromptPurchase = event("PromptPurchase"),
	-- client -> serveur : (potionId: string) boit une potion de sa réserve (la durée s'additionne).
	UsePotion = event("UsePotion"),
	-- Volcan des Défis. client -> serveur : (uuids: { string }) commence avec ces 5 dinos.
	VolcanoStart = event("VolcanoStart"),
	-- client -> serveur : abandonne et retourne au campement.
	VolcanoQuit = event("VolcanoQuit"),
	-- client -> serveur : (auto: boolean) enchaîner les étages automatiquement.
	VolcanoSetAuto = event("VolcanoSetAuto"),
	-- serveur -> client : (state: Types.VolcanoState?) début d'étage, victoire, défaite ; nil = sorti du Volcan.
	VolcanoState = event("VolcanoState"),
	-- serveur -> client (non fiable, purement visuel) : (hits: { VolcanoCombat.Hit }) coups d'un tick.
	VolcanoFx = remote("UnreliableRemoteEvent", "VolcanoFx") :: UnreliableRemoteEvent,
	-- client -> serveur : (slotId: string, uuid: string?) équipe une Relique (nil = retirer).
	EquipRelic = event("EquipRelic"),
	-- Récompenses : chacune renvoie { ok: boolean, message: string }.
	-- (code: string) code promo, insensible à la casse, une fois par compte.
	RedeemCode = func("RedeemCode"),
	-- Récompense quotidienne du jour (série de 7 jours UTC).
	ClaimDaily = func("ClaimDaily"),
	-- Coffre de groupe (toutes les 24 h, membres du groupe Roblox).
	ClaimGroupChest = func("ClaimGroupChest"),
	-- (found: number) palier de la Paléo-Encyclopédie (5, 10, 15, 20, 28).
	ClaimIndexMilestone = func("ClaimIndexMilestone"),
	-- (scope: "daily" | "weekly", index: number) réclame une quête terminée.
	ClaimQuest = func("ClaimQuest"),
	-- (itemId: string) achète un objet de la boutique de quêtes avec des Tickets.
	BuyQuestItem = func("BuyQuestItem"),
	-- serveur -> client : (minutes: number) récompense de temps de jeu reçue.
	PlaytimeReward = event("PlaytimeReward"),
	-- Échanges (même serveur). client -> serveur : (targetUserId: number) demande d'échange.
	TradeRequest = event("TradeRequest"),
	-- client -> serveur : (fromUserId: number, accept: boolean) réponse à une demande.
	TradeRespond = event("TradeRespond"),
	-- client -> serveur : ({ uuids: { string }, amber: number, bones: number }) remplace son offre.
	TradeSetOffer = event("TradeSetOffer"),
	-- client -> serveur : (ready: boolean) « Prêt ».
	TradeSetReady = event("TradeSetReady"),
	-- client -> serveur : « Confirmer » (après le compte à rebours).
	TradeConfirm = event("TradeConfirm"),
	-- client -> serveur : ferme la fenêtre / annule.
	TradeCancel = event("TradeCancel"),
	-- serveur -> client : (fromUserId: number, fromName: string) quelqu'un te propose un échange.
	TradeInvite = event("TradeInvite"),
	-- serveur -> client : (state: Types.TradeState?) état de l'échange en cours ; nil + (reason: string) = fini.
	TradeState = event("TradeState"),
	-- client -> serveur : (key: string, amount: number) DANS STUDIO UNIQUEMENT, accorde une monnaie pour tester.
	DevGrant = event("DevGrant"),
	-- serveur -> client : (text: string, kind: "info" | "error") petite notification.
	Notify = event("Notify"),
	-- serveur -> tous les clients : (text: string, rarityId: string) annonce d'un tirage très rare (tous serveurs).
	Announcement = event("Announcement"),
	-- serveur -> client : Types.DataSyncMessage (profil complet au chargement, puis changements).
	DataSync = event("DataSync"),
	-- serveur -> client : (coins: number, seconds: number) gagnés pendant l'absence.
	OfflineEarnings = event("OfflineEarnings"),
	-- serveur -> client : (rebirths: number) rebirth fait au sanctuaire : joue la cinématique du Phénix.
	RebirthCinematic = event("RebirthCinematic"),
	-- client -> serveur : (where: "Shrine" | "Plot") téléporte au Sanctuaire du Renouveau ou à sa parcelle.
	ShrineTeleport = event("ShrineTeleport"),
	-- client -> serveur : (kind: "Title" | "Showcase", id: string) change le titre ou le dino vitrine du profil.
	SetProfile = event("SetProfile"),
	-- serveur -> client : (reason: string) dépense de Fossiles refusée (le compteur tremble).
	CurrencyDenied = event("CurrencyDenied"),
	-- client -> serveur : (dinoId: string, count: number) DANS STUDIO UNIQUEMENT, ajoute des dinos pour tester.
	DevGrantDino = event("DevGrantDino"),
})
