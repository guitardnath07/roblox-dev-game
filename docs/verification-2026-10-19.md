# Vérification — Dino RNG (« jeux premier »), 2026-10-19

Audit en lecture seule du code `jeux-premier/src` (rien n'a été corrigé). Fait par deux agents + vérifications en Play.
Simulation d'équilibrage : `scratchpad/audit/sim2.py` (1 000 joueurs, 10 h).

**Verdict : aucun bloquant, aucune duplication exploitable trouvée aujourd'hui.**

## Important
1. **Trous de 30 min à 4 h sans rien de nouveau** (100 % des joueurs simulés, médiane 73 min, dès ~1 h de jeu).
   Cause : le coût du rebirth saute de 5 M à 500 M (x100, `shared/Config/Rebirth.luau:6`), puis x10 par rebirth pour seulement +0,5.
   Piste : `firstCosts = {500K, 5M, 50M}` puis x8, ou des nœuds d'arbre entre 150 M et 5 Md.
2. **L'Auto-Lancer ralentit à ~1 lancer / 6,5 s** dès que la chance dépasse ~400 (dé 7, ~1 h) : chaque tirage est Épique+ et lance la grande
   révélation, que l'Auto-Lancer attend (`RollReveal.luau` `isBusy` + `RollController.luau:86-89`). La nouvelle arène 3D l'a allongée (≈6,5 s contre ≈3,6 s avant).
   Piste : grande révélation seulement si `oneInDisplayed ≥ 1 000` ou dino nouveau dans l'Index ; sinon petite carte.
3. **Écran des chances sans les trèfles** (`Chances.luau:80`) : le serveur applique le trèfle à chaque lancer (`RollService.luau:65-66`).
   Les dinos rares sortent ~10 % plus souvent qu'affiché (obligation Roblox d'afficher la vraie probabilité).
   Piste : `Odds.marginalDistribution(luck)` = Σ trèfle × `exactDistribution(luck × mult)`.
4. **Parcelles reconstruites toutes les 10 s** (`PlotService.luau:496-500`, rendu 216-284) : jusqu'à 270 modèles + billboards + prompts détruits
   et recréés, et le client relance leurs animations. Piste : reconstruire seulement si `PlotSlots` / `Rebirths` change ; sinon ne changer que le texte.
5. **Coffre de groupe réclamable plusieurs fois** (`RewardsService.luau:112-126`) : appel web `IsInGroup` entre la vérification et l'écriture.
   Inactif tant que `groupId = 0` ; exploitable dès qu'il sera configuré. Piste : verrou `claiming[player]` avant l'appel.
6. **Échange : deux sauvegardes indépendantes** (`TradeService.luau:150-158`) : un crash serveur pile entre les deux pourrait dupliquer.
   Théorique (aucun moyen trouvé de le provoquer). Piste : `SaveAndWait` des deux + contrôle de `TradeLog` au chargement.

## Mineur
7. Reçu Robux : pendant `SaveAndWait`, un 2e appel du même reçu renvoie `PurchaseGranted` trop tôt (`MonetizationService.luau:61,80`) → set `inFlight`.
8. `DataService:SaveAndWait` renvoie vrai si DataStore indisponible, aussi en live (`DataService.luau:192`) → limiter à `RunService:IsStudio()`.
9. Échange : la capacité du sac n'est pas vérifiée (`TradeLogic.plan`) → sac au-delà de sa taille (pas de dupe).
10. Volcan : distance au portail non vérifiée, équipe non gelée (vente/échange pendant le combat), index d'arène `#GetChildren()` (`VolcanoService.luau:48,114,198`).
11. Gains hors ligne calculés au pic : `LastIncomePerSecond` inclut potions / événement / amis (`IncomeService.luau:42`).
12. Remotes sans limiteur : `SetSetting` (déclenche un DataSync à chaque appel), `GetLuckBreakdown`, `VolcanoQuit`, `VolcanoSetAuto`, `TradeConfirm`, `TradeCancel`.
13. `TradeSetOffer` : longueur des uuids vérifiée après la boucle (`TradeLogic.luau:69`).
14. Éclipse : le serveur triple les peaux, l'écran des chances montre la base (`Chances.luau:115-117`).
15. Perf : `PlacedDinoController` fait un `PivotTo` par dino proche à chaque image ; Chances/Encyclopédie reconstruites toutes les 15 s ;
    `DataService:Get` attend avec `task.wait()` par image ; tick de revenu sans compensation du retard.
16. `DevGrant` / `DevGrantDino` acceptent des valeurs non valides — **inertes en live** (Studio uniquement).

## Vérifié et sain
Toutes les tables de tirage font exactement 1 000 000 ; l'écran des chances utilise la même chance que le serveur (même dé, mêmes passes) ;
vente (pas de yield, dédoublonnage, gel/pose vérifiés) ; échange (gel, « Prêt » remis à zéro, revérification, exécution sans yield, annulation au départ) ;
relances et auto-relances ; rebirth atomique ; sac plein au tirage ; reçus idempotents ; verrou de session ProfileStore ;
Fossiles écrits seulement par `CurrencyService` ; tables par joueur vidées au départ ; toutes les boucles ont un `task.wait` ; Maid sur les fenêtres.

## Équilibrage (1 000 joueurs, 10 h — hypothèses dans le script)
| Jalon | p10 | médiane | p90 | atteint |
|---|---|---|---|---|
| Dé 3 (x8) | 2 min | 3 min | 4 min | 100 % |
| Dé 5 (x50) | 13 | 17 | 20 | 100 % |
| Rebirth 1 | 16 | 20 | 24 | 100 % |
| Rebirth 2 | 33 | 41 | 48 | 100 % |
| Dé 7 (x300) | 49 | 60 | 69 | 100 % |
| Dé 8 (x800) | 87 | 107 | 123 | 100 % |
| Rebirth 3 | 113 | 137 | 157 | 100 % |
| Dé 9 (x2000) | 168 | 202 | 231 | 100 % |
| Rebirth 4 | 233 | 275 | 318 | 100 % |
| Dé 10 (x5000) | 305 | 362 | 414 | 100 % |
| Rebirth 5 (Empreintes) | 461 | 539 | 586 | 77 % |
| Dé 11+ | — | — | — | 2 % |

## Pas encore fait
- Captures téléphone / tablette / PC de chaque écran (le MCP ne change pas la taille de la fenêtre Studio).
- Play complet d'un nouveau joueur pendant 15 min (le Play lancé par le MCP repasse parfois en Édition).
- Tests Jest : bloqués par le flag Studio `FFlagEnableLoadModule` (les 11 vérifications monnaie / hors ligne / migration passent en assert).

## Ordre de correction proposé
1. Auto-Lancer + grande révélation (n° 2) — le plus visible pour les joueurs.
2. Écran des chances avec trèfles (n° 3) — obligation Roblox.
3. Courbe des rebirths (n° 1).
4. Parcelles reconstruites toutes les 10 s (n° 4).
5. Coffre de groupe avant de configurer le groupe (n° 5), puis échange (n° 6) et les mineurs.
