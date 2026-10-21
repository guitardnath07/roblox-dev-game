# CLAUDE.md — Projet « DINO DICE » (jeu Roblox)

> Ce fichier se place à la racine du dépôt. Claude Code le lit à chaque session.
> Il contient la « bible » du jeu : toute décision qui contredit ce fichier doit d'abord être validée par moi.

## 1. Le jeu en une phrase
Un jeu Roblox « roll + idle tycoon » : on lance des dés pour obtenir des **dinosaures inventés** (espèces qui n'existent pas), on les pose sur les socles de sa parcelle où ils rapportent des Pièces par seconde (même hors ligne), on achète de meilleurs dés (plus de chance), on améliore, on renaît (rebirth), on affronte le Volcan des Défis, on échange avec les autres joueurs.

Inspiration : la **boucle de gameplay** des jeux de dés Roblox (type Anime Dice / Pet Dice). On reprend les MÉCANIQUES, jamais les noms, images, modèles, sons ou textes de ces jeux. Tout le contenu (dinos, dés, noms, UI, sons) est original.

## 2. Boucle principale
1. Clic sur « Lancer » (ou Auto-Lancer) → le serveur tire un dino avec le dé équipé.
2. Révélation animée (passable avec « Masquer ») : carte avec rareté, « 1 sur X », Pièces/s.
3. Le dino va dans le sac à dos. Sac plein = impossible de lancer (on vend ou on agrandit).
4. On place les meilleurs dinos sur les socles de sa parcelle → ils rapportent des Pièces/s.
5. Les Pièces achètent : dés, améliorations (arbre), niveaux de socles.
6. Rebirth : remet les Pièces à 0, garde dinos/dés/améliorations, donne un multiplicateur permanent + des socles en plus.

## 3. Monnaies
| Monnaie | Gagnée par | Sert à |
|---|---|---|
| Pièces | dinos posés (aussi hors ligne, plafond 8 h) | dés, arbre d'améliorations, niveaux de socles, rebirth, Instincts |
| Ambre | Volcan des Défis, quêtes, codes, récompenses quotidiennes | relancer le Grade |
| Fossiles | Volcan, quêtes, codes, quotidien | relancer l'Instinct (trait) |
| Lancers Dorés | codes, quêtes, quotidien | lancer gratuit avec la chance actuelle |
| Tickets d'Expédition | quêtes | boutique de quêtes (potions, Fossiles, Ambre) |

**Règle :** les Pièces ne s'achètent JAMAIS avec des Robux (ça simplifie la conformité « objets aléatoires payants »).

## 4. Raretés et liste des dinos (28 espèces inventées)
« 1 sur X » = chance de base. Pièces/s = revenu de base.

| Rareté | Dino | 1 sur X | Pièces/s | Archétype 3D |
|---|---|---|---|---|
| Commun | Galetosaure | 2 | 1 | Quadrupède |
| Commun | Moussecrête | 3 | 2 | Théropode |
| Commun | Brindilraptor | 4 | 3 | Théropode |
| Peu commun | Flaquodon | 7 | 5 | Aquatique |
| Peu commun | Sablegriffe | 11 | 7 | Théropode |
| Peu commun | Boucératops | 16 | 9 | Quadrupède |
| Rare | Braisedos | 30 | 14 | Quadrupède |
| Rare | Givrecroc | 52 | 19 | Théropode |
| Rare | Lianoptéryx | 90 | 26 | Ptérosaure |
| Rare | Ronceplaque | 150 | 35 | Quadrupède |
| Épique | Orageceros | 400 | 60 | Quadrupède |
| Épique | Cristalodon | 800 | 90 | Aquatique |
| Épique | Volcanokéros | 1 500 | 130 | Quadrupède |
| Épique | Abyssaure | 3 000 | 190 | Aquatique |
| Légendaire | Éclipsaurus | 8 000 | 320 | Théropode |
| Légendaire | Ambrelion | 15 000 | 450 | Théropode |
| Légendaire | Tonnerrex | 30 000 | 650 | Théropode |
| Légendaire | Aurorasaure | 60 000 | 950 | Ptérosaure |
| Mythique | Nébulodon | 150 000 | 1 600 | Aquatique |
| Mythique | Chronoraptor | 400 000 | 2 800 | Théropode |
| Mythique | Magmaroi | 900 000 | 4 400 | Quadrupède |
| Mythique | Spectrosaure | 2 000 000 | 7 000 | Ptérosaure |
| Primordial | Titanomarbre | 6 000 000 | 13 000 | Quadrupède |
| Primordial | Solaripteryx | 15 000 000 | 22 000 | Ptérosaure |
| Primordial | Gaïatops | 40 000 000 | 38 000 | Quadrupède |
| Primordial | Léviathodon | 100 000 000 | 65 000 | Aquatique |
| Secret | Glitchosaure | 500 000 000 | 160 000 | Théropode |
| Secret | Omégarex | 2 000 000 000 | 350 000 | Théropode |

**Exclusif** (rose animé #FF4FA3, validé le 21/10/2026) : Peluchorex, T-rex en peluche, Théropode, 75 Pièces/s. Jamais tiré au dé, absent de l'écran des chances et de l'Index ; s'obtient uniquement par achat Robux direct (non aléatoire).

Couleurs de rareté : Commun gris #9AA0A6, Peu commun vert #4CAF50, Rare bleu #2196F3, Épique violet #9C27B0, Légendaire orange #FF9800, Mythique rouge #E53935, Primordial turquoise animé, Secret arc-en-ciel animé.

## 5. Le tirage (modèle « du plus rare au plus commun »)
- Chance effective d'un dino = `min(1, chance_totale / X)`.
- Le serveur teste les dinos du PLUS RARE au plus commun ; le premier qui réussit est gagné ; si aucun → Galetosaure.
- Le « 1 sur X » affiché après un tirage = `max(1, X / chance_totale)` arrondi.
- Probabilité EXACTE de chaque dino (pour l'écran des chances) : `P_i = p_i × Π(1 − p_j)` pour tous les j plus rares. La somme fait 100 %.
- Chance totale = dé × arbre (Chance I–VI) × rebirth × passes × potions × trèfle × événement × bonus amis. Toujours calculée côté serveur.
- Trèfles : chaque lancer a 5 % de chance de recevoir un badge x2 (et 1 % x4, 0,2 % x8, 0,04 % x16, 0,008 % x32) qui multiplie la chance de CE lancer.

## 6. Dés (achetés avec des Pièces, aucune garantie de rareté)
| Dé | Chance | Prix (Pièces) |
|---|---|---|
| Dé Galet | x1 | départ |
| Dé Fougère | x3 | 500 |
| Dé Ambre | x8 | 5 000 |
| Dé Lave | x20 | 50 000 |
| Dé Glacier | x50 | 400 000 |
| Dé Tempête | x120 | 3 M |
| Dé Fossile | x300 | 25 M |
| Dé Météore | x800 | 200 M |
| Dé Éclipse | x2 000 | 1,5 Md |
| Dé Volcan Ancien | x5 000 | 12 Md |
| Dé Comète | x12 000 | 100 Md |
| Dé Primordial | x30 000 | 900 Md |
| Dé Nébuleuse | x80 000 | 8 T |
| Dé Big Bang | x250 000 | 80 T |

## 7. Couches de modificateurs d'un dino
Chaque exemplaire = dino de base + 4 couches.

**A. Mutation (fixée au tirage, non modifiable)**
- Taille : Bébé 10 % (x0,8 revenu, modèle x0,7) · Normal 85 % · Géant 4,5 % (x2, modèle x1,5) · Colossal 0,5 % (x5, modèle x2).
- Peau : Normale 90 % · Ambre 6 % (x1,5) · Jade 2,5 % (x2,5) · Obsidienne 1 % (x4) · Or fossile 0,45 % (x8) · Arc-en-ciel 0,05 % (x20).

**B. Instinct (relancé avec des Fossiles, 1 par dino, le nouveau remplace l'ancien)**
| Instinct | Effet | Chance |
|---|---|---|
| Vorace I / II / III | x1,2 / x1,5 / x2 Pièces | 25 % / 6 % / 1,2 % |
| Robuste I / II / III | x1,2 / x1,5 / x2 PV | 25 % / 6 % / 1,2 % |
| Féroce I / II / III | x1,2 / x1,5 / x2 Dégâts | 25 % / 6 % / 1,2 % |
| Alpha | x3 tout | 0,5 % |
| Chef de Meute | x5 tout | 0,12 % |
| Roi Ancien | x8 tout | 0,025 % |
| Primordial | x15 tout | 0,006 % |
| Aucun | — | 2,749 % (complète à 100 %) |

**C. Grade (relancé avec de l'Ambre, revenu uniquement)**
D 44,97 % x1,1 · C 28 % x1,2 · B 15 % x1,6 · A 8 % x3 · A+ 3 % x4,5 · S 0,9 % x7 · S+ 0,1 % x10 · Z 0,023 % x15 · Z+ 0,007 % x25 (total 100 %).

**D. Empreinte (débloquée au rebirth 5, coûte des Pièces, bonus passif quand le dino est posé)**
Flair I–III (+10/25/50 % chance), Trésor I–III (+10/25/50 % Pièces), Vélocité I–III (lancer plus rapide), Paléontologue (+15 % chance, +75 % Pièces, 0,009 %).
**À trancher :** tirage aléatoire payé en Pièces ou achat direct ? Chances de Flair, Trésor et Vélocité non définies (seul Paléontologue a 0,009 %).

## 8. Progression
- **Parcelle** : 6 socles au départ, +2 par rebirth (max 30). Chaque socle a des niveaux (Lvl N → N+1, coût ×1,6, +10 % revenu par niveau), achat x1 / x5.
- **Arbre d'améliorations** (hexagonal) : Pièces I–VI, Chance I–VI, Vitesse de lancer I–II, Sac I–IV (30 → 50 → 80 → 120 → 200 places), Vente I–III, Vitesse de marche I–III, Dégâts I–V, PV I–V.
- **Rebirth** : coûts 500 K, 5 M, 500 M puis ×10 ; chaque rebirth +0,5 au multiplicateur Pièces ET chance.
- **Volcan des Défis** (seul combat) : 100 étages, équipe de 5 dinos, combat automatique (Dégâts/PV), boss tous les 10 étages. Récompenses : Ambre, Fossiles, potions, et des **Reliques** (équipement joueur : Tête, Torse, Dos, Taille, Bras) à 0,5 % dès l'étage 25, 0,25 % dès 60, 0,02 % dès 90.
- **Index (Paléo-Encyclopédie)** : tous les dinos, trouvés/non trouvés ; récompense par palier (5/10/15/20/28 trouvés → Ambre, Fossiles, titre).
- **Quêtes** quotidiennes et hebdo → Tickets d'Expédition.
- **Événements serveur** toutes les 30 min (5 min) : Pluie de Météores (chance x2), Éclipse (mutations de peau x3), Éruption (Pièces x2).
- **Classements** : plus rare dino obtenu, total de lancers, rebirths ; hebdo avec récompense cosmétique (hoverboard).

## 9. Social
- Serveurs de 9 joueurs, 9 parcelles.
- Échange débloqué après 1 000 lancers.
- Bonus amis : +5 % Pièces par ami dans le serveur (max +20 %).
- Codes (un par mise à jour + paliers de likes/joueurs simultanés), récompenses quotidiennes, coffre de groupe.
- Annonce globale (tous serveurs) pour tout tirage ≥ 1 sur 1 000 000.

## 10. Monétisation (Robux)
Passes : Chance (x2), Ultra Chance (x3), Plus de Pièces (x2), VIP (x1,5 Pièces + chat tag + 10 % chance), Vitesse de lancer (x2), Double Lancer, Plus de Grades (+5 relances par clic), Plus d'Instincts (+5).
Produits : packs d'Ambre, packs de Fossiles, potions, dino exclusif Peluchorex (achat direct, non aléatoire). **Pas de vente de Pièces, pas de « Jackpot » payant au lancement.**
Conformité obligatoire (voir docs/regles-roblox.md) : écran des chances complet avant achat, effet chiffré des boosts de chance, `PolicyService` respecté par joueur.

## 11. Règles techniques (non négociables)
- Luau, `--!strict` sur tout le code partagé.
- Rojo + Wally + Selene + StyLua (via Rokit). Le code vit dans `src/`, jamais édité directement dans Studio.
- Serveur autoritaire : le client envoie seulement des INTENTIONS (« lancer », « placer dino #uuid sur socle 3 »). Le serveur vérifie tout, tire au sort, sauvegarde.
- Données joueur : ProfileStore (session lock), un profil par joueur, champ `DataVersion` + migrations.
- Chaque dino possédé a un UUID généré par le serveur.
- Toutes les tables d'équilibrage dans `src/shared/Config/` (une seule source de vérité, affichage client calculé depuis ces tables).
- Tests Jest-Lua pour : tirage (fréquences), migrations, échange, reçus d'achat.
- Mobile d'abord : UI en Scale + UIAspectRatioConstraint + UIScale, boutons ≥ 44 px.
- Les dinos des autres joueurs et les effets sont animés côté client.

## 12. 3D (Blender → Roblox)
- 4 rigs d'archétype réutilisés : Théropode, Quadrupède, Ptérosaure, Aquatique. Chaque dino = variante de forme + couleurs d'un archétype.
- Budget : 1 500–5 000 triangles par dino (boss du Volcan : jusqu'à 10 000). Max 20 000 par mesh (limite Roblox).
- 1 matériau + 1 texture 512 ou 1024 px par dino. Style « cartoon » chunky, grosse tête, couleurs vives.
- Max 4 influences d'os par vertex. Os racine à l'origine, transforms appliqués.
- Animations par archétype : Idle, Marche, Course, Attaque, Rugissement (révélation), Célébration, Mort (Volcan).
- Import Roblox : 3D Importer, Rig Type = Custom, AnimationController + Animator (pas de Humanoid).
