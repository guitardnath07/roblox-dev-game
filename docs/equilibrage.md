# Équilibrage — DINO DICE

Source de vérité : `src/shared/Config/*.luau`. Ce document explique les choix, liste les valeurs **proposées**
(absentes de CLAUDE.md, marquées `shortcut:` dans le code) et donne la simulation de progression.

## 1. Conventions

- **Ids** : snake_case ASCII, figés à vie (les profils les référencent). Dinos = nom sans accent (`galetosaure`,
  `lianopteryx`, `omegarex`) ; dés = anglais (`pebble`, `ancient_volcano`, `big_bang`) ; raretés, tailles, peaux,
  Instincts, Grades, Empreintes, nœuds de l'arbre, potions, quêtes, reliques : anglais snake_case
  (`fossil_gold`, `pack_leader`, `a_plus`, `coins_3`). Renommer = changer `displayName`, jamais `id`.
- **Chances** : entiers sur **1 000 000** (`perMillion`). La ligne « reste » (`none` / `normal` / `d` /
  `velocity_1`) est calculée au chargement par `Helpers.withRemainder` : chaque table fait exactement 1 000 000.
  Tirage : `Odds.pickPerMillion` (entier uniforme 1..1 000 000).
- `Dice[1]` = dé de départ ; `Instincts[1]` = `none` (instinct d'un dino tout juste tiré) ; `Mutations.defaultId` = `normal`.

| Table | Reste calculé | Valeur |
|---|---|---|
| Tailles | `normal` | 850 000 (85 %) |
| Peaux | `normal` | 900 000 (90 %) |
| Instincts | `none` | 27 490 (2,749 %, conforme CLAUDE.md) |
| Grades | `d` | 449 700 (44,97 %, conforme CLAUDE.md) |
| Trèfles | `none` (x1) | 937 520 (93,752 %) |
| Empreintes | `velocity_1` | 300 910 (30,091 %) — **proposition** |

## 2. Valeurs inventées ou interprétées (à valider)

| Sujet | Proposition | Fichier |
|---|---|---|
| Empreintes | Tirage payé en Pièces, **1 Md** le tirage. Flair / Trésor / Vélocité : I 30 %, II 3 %, III 0,3 % (Vélocité I reçoit le reste, 30,091 %) ; Paléontologue 0,009 % (CLAUDE.md). Vélocité = +10 / +20 / +35 % de vitesse de lancer. | `Imprints.luau` |
| Arbre d'améliorations | Valeurs totales par palier : Pièces et Chance x1,1 / 1,25 / 1,5 / 2 / 3 / 4 ; Vitesse de lancer x1,25 / x1,5 ; Vente x1,25 / 1,5 / 2 ; Dégâts et PV x1,2 / 1,5 / 2 / 3 / 5. Coûts de 1 K (Pièces I) à 100 Md (Dégâts V / PV V). Sac et Vitesse de marche = CLAUDE.md. | `Upgrades.luau` |
| Forme de l'arbre | Centre (0,0) sans nœud ; 6 branches rayonnent (Pièces E, Chance O, Sac NE, Vente SO, Dégâts N, PV S) ; Vitesse de lancer greffée sur Chance II, Vitesse de marche sur Vente I. | `Upgrades.luau` |
| Socles | Lvl 1→2 = 250 Pièces, x1,6 ensuite, niveau max 50. Niveaux **gardés** au rebirth (interprétation de « garde … améliorations »). | `Plots.luau`, `Rebirth.luau` |
| Vente | Prix de vente = revenu/s x 10 s (x Vente I–III). | `Economy.luau` |
| Relances | Grade 10 Ambre, Instinct 10 Fossiles. | `Economy.luau` |
| Stats Volcan des dinos | Dégâts ≈ 10 x revenu^0,55, PV = 6 x dégâts (10 / 60 pour Galetosaure → 11 000 / 67 000 pour Omégarex). | `Dinos.luau` |
| Volcan | Ennemi : 300 PV et 15 dégâts/s à l'étage 1, x1,11 par étage ; boss x4 PV, x1,5 dégâts. Récompense 1re victoire : 5 + f Ambre, 2 + f/2 Fossiles (x5 et une potion sur les boss) ; rejouer = 20 %. **À recaler avec un vrai simulateur de combat.** | `Volcano.luau` |
| Reliques | « 0,5 % dès 25, 0,25 % dès 60, 0,02 % dès 90 » lu comme 3 **tiers** de reliques (tier 1, 2, 3), chacun tenté indépendamment à chaque étage gagné. 15 reliques (5 emplacements x 3 tiers). | `Relics.luau` |
| Paliers d'Index | 25 → 500 Ambre, 0 → 200 Fossiles, titre « Paléontologue en chef » à 28. | `Economy.luau` |
| Produits, codes, quêtes | Packs 100 / 600 / 2 000 ; potions x2 (x3 « super ») 15 min ; LANCEMENT = 50 Ambre, 20 Fossiles, 5 Lancers Dorés, 1 potion ; quêtes 3 + 3 tirées dans les pools, boutique 5–10 Tickets. | `Products.luau`, `Codes.luau`, `Quests.luau` |

## 3. Simulation de progression

Script : `python -I scripts/simulate_progression.py [joueurs] [graine] [id_dé=prix …] [rebirth_after=x]`.
Il **lit les tables Luau** (dinos, dés, mutations, trèfles, arbre, rebirth, socles, délai de lancer) : relancer après
chaque modification. Les paires `id=prix` testent une proposition sans toucher au code.

Modèle : 10 000 joueurs gratuits, jeu actif en auto-lancer (1 lancer/s x Vitesse de lancer), sans passes, potions,
événements, amis ni hors-ligne. Tirage exact (du plus rare au plus commun, trèfles, mutations de taille et de peau).
Le joueur pose ses 6 (+2 par rebirth) meilleurs dinos, achète le dé suivant dès que possible, fait un rebirth quand
ça le rapproche du dé suivant, et achète le nœud Pièces / Chance / Vitesse ou niveau de socle le moins cher s'il coûte
≤ 25 % du prochain dé. Revenu de vente, Instincts, Grades et Empreintes ignorés (estimation prudente).
« Rien de nouveau » = ni dé, ni rebirth, ni nœud de l'arbre, ni nouvelle espèce.

### 3.1 Valeurs actuelles (CLAUDE.md)

| Dé | Chance | Prix | Temps médian | P10 | P90 | Attente depuis le dé précédent |
|---|---|---|---|---|---|---|
| Galet | x1 | départ | 0 | — | — | — |
| Fougère | x3 | 500 | < 1 min | | | < 1 min |
| Ambre | x8 | 5 K | 2 min | 1 min | 2 min | 1 min |
| Lave | x20 | 50 K | 4 min | 3 min | 5 min | 3 min |
| Glacier | x50 | 400 K | 10 min | 7 min | 12 min | 5 min |
| Tempête | x120 | 3 M | 20 min | 16 min | 24 min | 11 min |
| Fossile | x300 | 25 M | 36 min | 28 min | 42 min | 16 min |
| Météore | x800 | 200 M | 1,0 h | 48 min | 1,1 h | 23 min |
| Éclipse | x2 000 | 1,5 Md | 1,9 h | 1,5 h | 2,2 h | 56 min |
| Volcan Ancien | x5 000 | 12 Md | 3,4 h | 2,8 h | 3,8 h | 1,5 h |
| Comète | x12 000 | 100 Md | 6,7 h | 5,7 h | 7,7 h | **3,3 h ⚠** |
| Primordial | x30 000 | 900 Md | 13,7 h | 11,9 h | 15,2 h | **6,9 h ⚠** |
| Nébuleuse | x80 000 | 8 T | 37,7 h | 33,2 h | 41,7 h | **24,2 h ⚠** |
| Big Bang | x250 000 | 80 T | 52,2 h | 46,2 h | 57,4 h | **14,5 h ⚠** |

Rebirths (médiane) : 1 → 13 min, 2 → 25 min, 3 → 1,8 h, 4 → 3,5 h, 5 → 6,9 h, 6 → 14,4 h, 7 → 38,9 h.
Les 28 espèces sont trouvées (médiane) avant la fin.

**Trous de progression (> 2 h sans rien de nouveau)** :

| Dé possédé | Joueurs touchés | Durée médiane du trou |
|---|---|---|
| Volcan Ancien (en attendant Comète) | 21 % | 2,2 h |
| Comète (→ Primordial) | 100 % | 5,9 h |
| Primordial (→ Nébuleuse) | 100 % | **23,3 h** |
| Nébuleuse (→ Big Bang) | 100 % | 13,3 h |

Constat : jusqu'au Dé Volcan Ancien (~3,4 h) le rythme est bon (un dé toutes les 1 à 90 min). Ensuite les prix
font x8–x10 par dé alors que le revenu ne progresse plus que par les rebirths (+0,5 chacun, coûts x10) : l'arbre
est fini vers 12 Md et il ne reste plus rien à acheter.

### 3.2 Proposition (NON appliquée)

Prix : Volcan Ancien **10 Md** (au lieu de 12), Comète **40 Md** (100), Primordial **200 Md** (900),
Nébuleuse **1 T** (8 T), Big Bang **5 T** (80 T) ; coûts de rebirth **x4** après 500 M (au lieu de x10).
Commande : `python -I scripts/simulate_progression.py 10000 1 ancient_volcano=10e9 comet=40e9 primordial=200e9 nebula=1e12 big_bang=5e12 rebirth_after=4`

| Dé | Prix proposé | Temps médian | Attente depuis le précédent |
|---|---|---|---|
| Volcan Ancien | 10 Md | 3,1 h | 1,2 h |
| Comète | 40 Md | 4,2 h | 1,1 h |
| Primordial | 200 Md | 6,5 h | 2,2 h ⚠ |
| Nébuleuse | 1 T | 12,2 h | 5,8 h ⚠ |
| Big Bang | 5 T | 21,7 h | 9,5 h ⚠ |

Rebirths : 8 en 12,4 h (au lieu de 7 en 38,9 h). Trous restants : Primordial → Nébuleuse (5,5 h, 99 %) et
Nébuleuse → Big Bang (9,2 h, 100 %).

Baisser encore les prix raccourcirait trop le jeu (Big Bang en ~16 h avec Nébuleuse 600 Md / Big Bang 2,5 T).
Pour les deux derniers paliers, il faut plutôt **du contenu qui rapporte en Pièces** entre deux dés. Pistes chiffrées :
1. Ajouter Pièces VII (x6, 200 Md) et Chance VII (x6, 500 Md) dans l'arbre, pour donner un objectif
   intermédiaire en fin de jeu (non simulé).
2. Rebirth : +0,75 au lieu de +0,5 au-delà du rebirth 6 (garde l'intérêt des rebirths chers ; non simulé).
3. Le revenu hors-ligne (plafond 8 h), les relances de Grade (x1,1 → x25) et d'Instinct et le Volcan ne sont pas
   simulés : en jeu réel ils remplissent une partie de ces attentes. À re-simuler une fois les coûts d'Ambre / Fossiles fixés.

Le début de jeu (9 dés en 2 h) est rapide ; c'est voulu pour accrocher, mais on peut le ralentir en montant
les prix Fougère → Météore (à re-simuler avant).
