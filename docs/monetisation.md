# Monétisation — à créer dans le Creator Dashboard

C'est **toi** qui crées ces passes et produits (Creator Dashboard → ton jeu → Monetization). Ensuite, colle chaque ID dans
`src/shared/Config/Gamepasses.luau` (`gamePassId`) ou `src/shared/Config/Products.luau` (`productId`).
Tant qu'un ID vaut 0, l'achat est refusé proprement en jeu (« pas encore en vente »).

Prix conseillés : repères courants des jeux de dés Roblox, à ajuster selon les ventes.

## Game Passes

| id config | Nom | Description (à coller) | Prix conseillé | Icône à faire |
|---|---|---|---|---|
| `luck` | Chance | Ta chance totale est multipliée par 2 pour toujours. | 199 R$ | Trèfle doré x2 |
| `ultra_luck` | Ultra Chance | Ta chance totale est multipliée par 3 pour toujours (se cumule avec Chance). | 549 R$ | Trèfle arc-en-ciel x3 |
| `more_coins` | Plus de Pièces | Tes dinos rapportent 2 fois plus de Pièces. | 249 R$ | Pile de pièces x2 |
| `vip` | VIP | x1,5 Pièces, +10 % de chance et un tag VIP dans le chat. | 399 R$ | Couronne d'os dorée |
| `roll_speed` | Vitesse de lancer | Tu lances les dés 2 fois plus vite. | 149 R$ | Dé avec traînée de vitesse |
| `double_roll` | Double Lancer | Chaque lancer tire 2 dinos. | 299 R$ | Deux dés |
| `more_grades` | Plus de Grades | Relance jusqu'à 5 Grades par clic. | 99 R$ | Lettre S sur ambre |
| `more_instincts` | Plus d'Instincts | Relance jusqu'à 5 Instincts par clic. | 99 R$ | Griffe sur fossile |

Les passes **Chance**, **Ultra Chance** et **VIP** modifient la chance : ce sont des objets aléatoires payants.
L'écran Chances doit montrer leur effet chiffré avant l'achat. Le jeu bloque leur achat pour les joueurs restreints par PolicyService.

## Produits développeur

| id config | Nom | Contenu | Prix conseillé |
|---|---|---|---|
| `amber_small` | Poignée d'Ambre | 100 Ambre | 49 R$ |
| `amber_medium` | Bocal d'Ambre | 600 Ambre | 249 R$ |
| `amber_large` | Coffre d'Ambre | 2 000 Ambre | 699 R$ |
| `fossils_small` | Sachet de Fossiles | 100 Fossiles | 49 R$ |
| `fossils_medium` | Caisse de Fossiles | 600 Fossiles | 249 R$ |
| `fossils_large` | Musée de Fossiles | 2 000 Fossiles | 699 R$ |
| `luck_potion_x3` | 3 Potions de Chance | 3 × (chance x2 pendant 15 min) | 79 R$ |
| `super_luck_potion_x3` | 3 Super Potions de Chance | 3 × (chance x3 pendant 15 min) | 149 R$ |
| `coins_potion_x3` | 3 Potions de Pièces | 3 × (Pièces x2 pendant 15 min) | 79 R$ |

**Jamais de Pièces à vendre, jamais de « Jackpot » payant.** L'Ambre et les Fossiles servent aux relances aléatoires, ce sont donc des
objets aléatoires payants. Les potions de chance aussi. Tous sont bloqués pour les joueurs restreints.

## Ce que fait le code (pour vérifier)
- Un seul `ProcessReceipt` (`src/server/Services/MonetizationService.luau`) : joueur absent ou profil non chargé → `NotProcessedYet` ;
  `PurchaseId` déjà vu → `PurchaseGranted` sans redonner ; sinon octroi + mémorisation du `PurchaseId` + sauvegarde confirmée → `PurchaseGranted`.
- `PolicyService` (`src/server/Services/PolicyService.luau`) : vérifié au join, 3 essais. En cas d'échec, le joueur est **restreint** :
  pas d'achat d'objets aléatoires payants, et les passes de chance n'ont aucun effet pour lui.
