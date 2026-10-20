# Règles Roblox applicables à DINO DICE

Pages officielles lues le 2026-10-18 (via WebFetch). Les résumés sont des reformulations ; en cas de doute, la page officielle fait foi.

---

## 1. Paid Random Items (objets aléatoires payants)

Lien : https://create.roblox.com/docs/production/monetization/paid-random-items

Résumé :
- **Ce qui est concerné** : tout résultat aléatoire obtenu directement ou indirectement avec des Robux, y compris via une monnaie in-game achetable en Robux (gemmes, tickets, jetons de reroll...). Quatre familles sont citées : capsules (roues, œufs, coffres), améliorations (potions à durée aléatoire, upgrade avec chance de réussite), combinaisons (fusion pour tenter un meilleur résultat) et **modificateurs de probabilité** (boosts de chance, pity, drops améliorés, rate-up).
- **Affichage des chances** : chaque résultat possible doit être listé avec sa probabilité réelle, **avant l'achat**. S'il y a trop de résultats pour l'écran, on peut utiliser une pop-up ouverte par un bouton portant un mot descriptif (« Info », « Détails »). **Une simple icône (i) seule ne suffit pas.**
- **Achats indirects** : pour les clés, jetons de reroll ou tickets achetés en Robux, les chances doivent être visibles avant de dépenser la monnaie in-game.
- **Format** : probabilités en **pourcentages**, dont le total fait exactement **100 %**.
- **Précision / arrondi** : pour les décimales longues, arrondir en gardant **au moins 4 décimales après le premier chiffre non nul** (ex. 0,000123456 % -> 0,0001235 %). En cas d'arrondi, ajouter un avertissement du type « Les probabilités sont arrondies ; la somme affichée peut ne pas faire exactement 100 % ».
- **Chances identiques** : si beaucoup de résultats ont la même probabilité, on peut l'indiquer une seule fois en tête de liste.
- **Résultats uniques** : si un résultat ne peut être obtenu qu'une fois, les chances restantes doivent être recalculées pour ce joueur.
- **Boosters de chance** : leur effet doit être **expliqué en chiffres avant l'achat**, et pendant qu'ils sont actifs, les chances affichées doivent se mettre à jour pour montrer les chances réelles du joueur.
- **Exemption** : un aléatoire gagné uniquement par le gameplay (sans Robux ni monnaie achetée) n'a pas besoin d'affichage des chances.
- **PolicyService** : vérifier par joueur avec `GetPolicyInfoForPlayerAsync()` ; le dictionnaire contient `ArePaidRandomItemsRestricted` et `IsPaidItemTradingAllowed`.
- **Si `ArePaidRandomItemsRestricted` = true** : le joueur ne doit pas pouvoir utiliser de générateur aléatoire payant (Robux ou monnaie achetée). Traitements acceptés : chemin gratuit gagnable en jouant ; ordre prédéterminé annoncé avant achat ; vente directe d'un résultat garanti (prix basé sur la valeur attendue) ; retrait/masquage de l'objet ; achat bloqué avec message d'erreur ; ou retrait du joueur de la zone concernée.
- **Si `IsPaidItemTradingAllowed` = false** : interdiction d'échanger les résultats d'objets aléatoires payants **ou d'autres objets payants**.

## 2. PolicyService (référence API)

Lien : https://create.roblox.com/docs/reference/engine/classes/PolicyService

Résumé :
- `GetPolicyInfoForPlayerAsync(player)` renvoie un dictionnaire de règles propres à ce joueur. La méthode **yield** (elle attend une réponse réseau).
- Les exemples de la page l'appellent dans un **`pcall`** et loguent un avertissement en cas d'échec.
- **Clés visibles sur cette page** : seulement `ArePaidRandomItemsRestricted` et `IsEligibleToPurchaseCommerceProduct` (dans les exemples de code).
- **Non vérifié sur cette page** : `IsPaidItemTradingAllowed` **n'apparaît pas** dans la page de référence lors de la lecture (il est en revanche cité par la page Paid Random Items et par le questionnaire de maturité). La page ne documente pas de codes d'erreur, de politique de retry ni de cache, et ne dit pas explicitement si l'appel doit se faire côté serveur ou client (ses exemples sont côté client).

## 3. Content Maturity (questionnaire de maturité)

Lien : https://create.roblox.com/docs/production/promotion/content-maturity

Résumé :
- Le label (Minimal, Mild, Moderate, Restricted) dépend du contenu le plus mature du jeu et détermine quelles tranches d'âge y ont accès.
- Le questionnaire se remplit dans le Creator Dashboard : jeu > Publish settings > **Content rating** > Start, puis Save and Continue page par page, aperçu, puis Submit. On peut le refaire à tout moment.
- **Questions de monétisation qui concernent DINO DICE** :
  - Le jeu contient-il des objets aléatoires payants ? Et utilise-t-il l'API `ArePaidRandomItemsRestricted` pour s'adapter aux régions restreintes ?
  - Les joueurs peuvent-ils échanger des objets payants ? Et le jeu utilise-t-il l'API `IsPaidItemTradingAllowed` ?
- Le « gambling » (jeu d'argent non jouable, représenté) est une question séparée qui influe sur le label.
- **Conséquences** : sans questionnaire, Roblox restreint automatiquement la jouabilité du jeu pour tous. Des réponses inexactes peuvent entraîner la modération du jeu et du compte.

## 4. Developer Products (ProcessReceipt)

Lien : https://create.roblox.com/docs/production/monetization/developer-products

Résumé :
- Le callback `MarketplaceService.ProcessReceipt` ne peut être défini **qu'une seule fois, par un seul Script serveur** (ServerScriptService).
- Pour chaque reçu : vérifier l'utilisateur, l'ID du produit, puis donner l'objet. Chaque produit a son handler qui doit réussir pour que l'achat compte.
- Retourner **`PurchaseGranted`** uniquement **après** avoir effectivement donné l'objet.
- Retourner **`NotProcessedYet`** si l'objet ne peut pas être donné (joueur absent du serveur, erreur dans le handler attrapée par `pcall`) : Roblox réessaiera, notamment au prochain join du joueur.
- Ne pas utiliser `PromptProductPurchaseFinished` pour donner les objets : cet événement ne garantit pas que l'achat a réussi.
- Roblox contrôle les implémentations de ProcessReceipt dans le temps ; un problème détecté peut retirer un produit listé de la visibilité hors du jeu.
- **Non couvert par la page** : l'idempotence par `PurchaseId` et l'ordre « sauvegarder en DataStore avant d'accorder » ne sont pas décrits sur cette page (elle dit seulement que suivre l'historique des achats via DataStore est de la responsabilité du développeur). Les points correspondants de la checklist ci-dessous sont donc de la bonne pratique, pas une citation de la doc.

---

## Ce que DINO DICE doit faire

### A. Écran des chances (dés, Grade, Instinct, packs)
- [ ] Chaque système aléatoire touché par des Robux (lancer de dé si la chance est boostée par un pass/potion payant, reroll de **Grade**, reroll d'**Instinct**, packs **Ambre/Fossile** s'ils ont un contenu aléatoire) a un écran de chances.
- [ ] L'écran est ouvert par un **bouton avec du texte** (« Chances », « Détails », « Info ») – pas une icône (i) seule.
- [ ] Il est accessible **avant** tout achat lié à la chance : depuis la boutique Robux (pass x2, x3, VIP, potions), avant d'acheter des packs Ambre/Fossile, et avant chaque dépense d'Ambre/Fossile pour un reroll.
- [ ] **100 % des résultats** sont listés (chaque Grade, chaque Instinct, chaque issue de pack), en **pourcentages**, total = 100 %.
- [ ] Arrondi : garder au moins **4 décimales après le premier chiffre non nul** pour les très petites chances ; afficher l'avertissement d'arrondi quand on arrondit.
- [ ] Chances générées depuis la **même table de config** que le serveur utilise pour tirer (pas de valeurs recopiées à la main).
- [ ] Si un résultat est unique par joueur, recalculer les chances restantes pour ce joueur.

### B. Boosters de chance (x2, x3, VIP +10 %, potions)
- [ ] Sur la fiche de chaque pass/potion, avant achat, montrer l'effet **en chiffres** : ex. « Légendaire : 0,5 % -> 1 % avec x2 ».
- [ ] Expliquer le cumul (x2 + VIP + potion : multiplication ou addition ?) avec un exemple chiffré.
- [ ] Quand un booster est actif, l'écran des chances affiche les **chances réelles actuelles** du joueur, mises à jour en direct (et à l'expiration d'une potion).

### C. PolicyService par joueur
- [ ] Au join, appeler `PolicyService:GetPolicyInfoForPlayerAsync(player)` dans un `pcall`, stocker le résultat par joueur.
- [ ] **Échec de l'appel = traiter le joueur comme restreint** (`ArePaidRandomItemsRestricted = true`, `IsPaidItemTradingAllowed = false`). Réessai possible plus tard.
- [ ] Les vérifications qui comptent sont faites **côté serveur** (le client peut seulement adapter l'UI).
- [ ] Si `ArePaidRandomItemsRestricted` = true : bloquer pour ce joueur les reroll Grade/Instinct payés en Ambre/Fossile, l'achat des packs aléatoires et des boosters de chance – ou appliquer un des traitements autorisés (version gratuite gagnable en jouant, ordre prédéterminé, achat direct d'un résultat garanti, masquage, achat bloqué avec message clair).
- [ ] Ne jamais mélanger Ambre/Fossile gagnés gratuitement et achetés si on veut garder un chemin gratuit pour les joueurs restreints (ou bien considérer toute l'Ambre/Fossile comme payante).

### D. Échanges de dinos
- [ ] Si `IsPaidItemTradingAllowed` = false (ou appel en échec) : **échanges désactivés** pour ce joueur (côté serveur), bouton grisé avec explication.
- [ ] Le serveur refuse un échange si **l'un des deux** joueurs n'y a pas droit.
- [ ] Rappel : la règle couvre les résultats d'objets aléatoires payants **et autres objets payants** ; un dino rerollé avec de l'Ambre/Fossile achetée est concerné.

### E. ProcessReceipt
- [ ] Un **seul** Script serveur assigne `MarketplaceService.ProcessReceipt`.
- [ ] Joueur introuvable -> `NotProcessedYet`.
- [ ] Handler dans `pcall` ; erreur -> `warn` + `NotProcessedYet`.
- [ ] `PurchaseGranted` **seulement après** que l'octroi est enregistré.
- [ ] (Bonne pratique, non décrite par la page) Idempotence : enregistrer chaque `PurchaseId` traité dans le DataStore du joueur, en même temps que l'octroi ; si le `PurchaseId` est déjà connu, renvoyer `PurchaseGranted` sans redonner.
- [ ] (Bonne pratique) Si la sauvegarde DataStore échoue -> `NotProcessedYet`.
- [ ] Ne jamais donner d'objet depuis `PromptProductPurchaseFinished`.
- [ ] Les Coins ne sont jamais vendus contre des Robux (cohérent avec le design).

### F. Questionnaire de maturité
- [ ] Remplir/mettre à jour le questionnaire dans le Creator Dashboard : répondre **oui** aux objets aléatoires payants et **oui** à l'usage de `ArePaidRandomItemsRestricted` ; **oui** à l'échange d'objets payants et **oui** à l'usage de `IsPaidItemTradingAllowed` (seulement une fois ces API réellement branchées).
- [ ] Le refaire à chaque ajout de système monétisé ou d'échange.

---

## Points non vérifiés
- `IsPaidItemTradingAllowed` n'apparaît pas sur la page de référence PolicyService lue ; son existence vient des pages Paid Random Items et Content Maturity.
- La doc lue ne précise pas si `GetPolicyInfoForPlayerAsync` doit être appelé côté serveur, ni le comportement en cas d'erreur (la règle « échec = restreint » est une précaution, pas une citation).
- L'idempotence par `PurchaseId` n'est pas décrite sur la page Developer Products lue.
