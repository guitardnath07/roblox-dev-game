# DINO DICE — Fiches concept des 28 dinos

Source des données : `src/shared/Config/Dinos.luau` (id, rareté, archétype).
Tout est **inventé** : style cartoon chunky et mignon-cool, grosse tête, couleurs vives, silhouette lisible à 30 studs, rendu low-poly à faces plates (« stylized retro »).
Plus la rareté monte, plus la silhouette est spectaculaire (Secret = effets glitch / cosmiques).
Inspiration de style uniquement : on ne copie aucune créature, aucun nom d'une franchise existante.

**Taille relative** : 1,0 = base de l'archétype (Théropode commun ≈ 4 studs de haut).
**Couleurs** : principale / secondaire / accent (l'accent sert aussi aux parties émissives).
**Émissif** : parties en matériau Neon côté Roblox (ou couleur émissive dans la texture).
**Référence réelle** : animal préhistorique dont on garde l'anatomie (proportions chibi : tête ×1,6, pattes raccourcies sauf mention). Sources : Wikipédia (anglais).
**Couche thématique** : accessoires et formes à modéliser par-dessus. Cotes en studs pour un dino de taille 1,0 (multiplier par la taille de la fiche). Chaque accessoire = pièce du même mesh, mêmes UV, reste dans le budget 1 500–5 000 triangles.

---

## Commun

### Galetosaure — Quadrupède — taille 0,9
- Silhouette : corps tout rond comme un galet, pattes très courtes, cou court, petites bosses lisses sur le dos.
- Couleurs : `#9AA5B1` / `#D9D4C7` / `#7BC67E`
- Émissif : aucun.
- Personnalité (Idle) : somnolent ; paupières qui tombent, se rendort, ronflement (dos qui gonfle).
- Référence réelle : *Minmi paravertebra*, petit ankylosaure (~3 m) d'Australie couvert de petites plaques osseuses — https://en.wikipedia.org/wiki/Minmi_(dinosaur)
  - À garder : corps bas et large, rangées de petites plaques osseuses le long des flancs, tête triangulaire basse, queue courte sans massue. (Le vrai Minmi a des pattes assez longues : on les raccourcit pour l'effet galet.)
- Couche thématique : 7 galets lisses (ellipsoïdes aplatis 0,35 × 0,25 × 0,12) en 2 rangées décalées sur le dos, couleur secondaire ; 1 touffe de mousse (3 sphères 0,12, couleur accent) sur le plus gros galet ; ventre plat comme une pierre posée ; paupières en demi-disques séparés (pour l'animation de sommeil).

### Moussecrête — Théropode — taille 0,9
- Silhouette : crête de mousse en touffe ronde sur la tête, ventre clair, queue courte et dodue.
- Couleurs : `#5DBB63` / `#F2E8C9` / `#2E7D32`
- Émissif : aucun.
- Personnalité : timide et flatté ; se dandine, se cache le museau, la crête frétille.
- Référence réelle : *Guanlong wucaii*, petit tyrannosauroïde (~3 m) au nom de « dragon couronné » grâce à sa fine crête sur le museau — https://en.wikipedia.org/wiki/Guanlong
  - À garder : crête unique dans l'axe du crâne (du nez au-dessus des yeux), museau long, bras à 3 doigts assez longs, bipède léger.
- Couche thématique : la crête osseuse est remplacée par une touffe de mousse faite de 5 sphères low-poly (rayons 0,25 / 0,2 / 0,2 / 0,15 / 0,15) posées en ligne du nez au front, couleur accent ; 2 brins de trèfle (losanges plats 0,1) piqués dedans ; joues roses peintes dans la texture (pour l'air flatté).

### Brindilraptor — Théropode — taille 0,85
- Silhouette : raptor fin, 2 brindilles plantées en plumes sur la nuque et la queue, griffes visibles.
- Couleurs : `#B5835A` / `#F3D9A4` / `#6D9B3A`
- Émissif : aucun.
- Personnalité : maniaque ; compte (hoche la tête 3 fois), regarde à gauche à droite.
- Référence réelle : *Sinosauropteryx prima*, minuscule théropode (~1 m) à duvet de filaments, queue rayée clair/foncé — https://en.wikipedia.org/wiki/Sinosauropteryx
  - À garder : très longue queue (≈ 1,5 × le corps), bras courts, pattes fines, rayures alternées sur la queue (7 bandes dans la texture).
- Couche thématique : 3 brindilles (cylindres 6 côtés, Ø 0,05, longueur 0,5–0,7) en éventail sur la nuque, 2 sur le bout de la queue, chacune avec 1 petite feuille (losange 0,12, couleur accent) ; un petit fagot de 4 brindilles ficelé tenu sous le bras gauche (sa collection).

## Peu commun

### Flaquodon — Aquatique — taille 0,8
- Silhouette : petit, très rond, gros yeux, nageoires courtes, queue en spatule, gouttelette sur le front.
- Couleurs : `#4FC3F7` / `#E1F5FE` / `#0288D1`
- Émissif : la goutte du front, léger.
- Personnalité : susceptible ; gonfle les joues, se retourne vexé puis revient.
- Référence réelle : *Henodus chelyops*, placodonte d'1 m ressemblant à une tortue plate, vivant en lagune d'eau saumâtre — https://en.wikipedia.org/wiki/Henodus
  - À garder : carapace presque carrée très plate et plus large que longue, tête au museau carré et bec, 4 nageoires courtes qui dépassent des coins.
- Couche thématique : carapace = disque de flaque (cylindre 12 côtés, Ø 1,6, épaisseur 0,15) couleur secondaire avec 3 cercles concentriques de ricochet peints ; goutte du front (forme larme 0,2 × 0,3) ; 1 nénuphar (disque fendu Ø 0,4, vert) posé de travers sur la carapace ; joues en 2 sphères séparées (animation « gonfle les joues »).

### Sablegriffe — Théropode — taille 1,0
- Silhouette : grandes griffes de pelle aux bras, bandeau de rayures sur le dos, museau carré.
- Couleurs : `#E8C07D` / `#C68B4E` / `#FF7043`
- Émissif : aucun.
- Personnalité : sportif ; boxe dans le vide, sautille sur place.
- Référence réelle : *Mononykus olecranus*, petit théropode (~1 m) du désert de Gobi aux bras très courts terminés par UNE seule grosse griffe — https://en.wikipedia.org/wiki/Mononykus
  - À garder : bras minuscules avec 1 griffe énorme chacun, longues pattes fines de coureur, tête petite et étroite (on la grossit, museau carré), queue longue.
- Couche thématique : chaque griffe = pelle de plage (lame 0,35 × 0,3, manche court), couleur accent ; bandeau de sport (anneau 0,08) sur le front ; 3 rayures de dune (zigzags) sur le dos dans la texture ; petit tas de sable (cône aplati Ø 0,6) collé à un pied pour les poses statiques.

### Boucératops — Quadrupède — taille 1,1
- Silhouette : collerette ronde avec 3 cornes (2 au front, 1 au nez), une chaussette accrochée à une corne.
- Couleurs : `#FFB74D` / `#FFF3E0` / `#8D6E63`
- Émissif : aucun.
- Personnalité : bon vivant ; secoue la tête (la chaussette balance), gratte le sol.
- Référence réelle : *Triceratops horridus*, cératopsien à 3 cornes et collerette pleine — https://en.wikipedia.org/wiki/Triceratops
  - À garder : 2 longues cornes au-dessus des yeux vers l'avant, 1 petite corne nasale, collerette pleine arrondie, bec, corps massif sur 4 pattes trapues.
- Couche thématique : corde à linge (cylindre Ø 0,03) tendue entre les 2 cornes du front, avec 1 chaussette rayée (accent/secondaire, 0,3 × 0,15) et 1 pince à linge (2 boîtes 0,05) ; bord de la collerette festonné comme un napperon (12 creux) ; chaussette = os séparé pour le balancement.

## Rare

### Braisedos — Quadrupède — taille 1,15
- Silhouette : 2 rangées de plaques dorsales en losange, queue à 2 pointes.
- Couleurs : `#C62828` / `#4E342E` / `#FFB300`
- Émissif : bords des plaques orange-braise, pulsation lente.
- Personnalité : chaleureux ; s'étire comme un chat, petites étincelles quand il souffle.
- Référence réelle : *Stegosaurus*, plaques dorsales en 2 rangées alternées et pointes caudales — https://en.wikipedia.org/wiki/Stegosaurus
  - À garder : dos très voûté (point haut au-dessus des hanches), pattes avant plus courtes que les arrière, petite tête basse, plaques alternées (pas symétriques). Queue réduite à 2 pointes (choix de lisibilité, le vrai en a 4).
- Couche thématique : 9 plaques en losange (la plus grande 0,7 × 0,55 au-dessus des hanches, décroissantes), chacune en 2 parties : cœur charbon (secondaire) + liseré braise (accent, émissif) ; 3 « bûches » (cylindres Ø 0,08) croisées sous le menton ; 1 guimauve (cylindre blanc 0,1) plantée sur la pointe de queue gauche.

### Givrecroc — Théropode — taille 1,05
- Silhouette : crête de pics de glace sur la tête et le dos, crocs bleus qui dépassent, écharpe de givre.
- Couleurs : `#B3E5FC` / `#FFFFFF` / `#4FC3F7`
- Émissif : pics de glace, bleu pâle.
- Personnalité : enrhumé ; frissonne, éternue (recul de tête + flocons).
- Référence réelle : *Cryolophosaurus ellioti*, théropode d'Antarctique (« lézard à crête froide ») dont la crête se dresse EN TRAVERS du crâne, façon banane — https://en.wikipedia.org/wiki/Cryolophosaurus
  - À garder : crête transversale en éventail au-dessus des yeux (perpendiculaire au museau), crâne long, bras moyens à 3 doigts, silhouette de prédateur moyen.
- Couche thématique : la crête = éventail de 5 stalactites de glace (cônes 4 côtés, 0,25 à 0,45 de haut) disposés en travers du crâne ; 6 petits pics dégressifs le long du dos ; 2 crocs bleus (cônes 0,12) qui dépassent de la mâchoire supérieure ; écharpe (tore aplati Ø 0,7) avec 2 pans qui pendent ; goutte au nez (larme 0,08) pour le rhume.

### Lianoptéryx — Ptérosaure — taille 1,0
- Silhouette : ailes en feuilles géantes, lianes enroulées aux poignets, crête en feuille recourbée.
- Couleurs : `#43A047` / `#C5E1A5` / `#FFEB3B`
- Émissif : aucun.
- Personnalité : acrobate ; se balance d'une patte sur l'autre, ailes repliées comme une cape.
- Référence réelle : *Rhamphorhynchus*, ptérosaure à longue queue terminée par une palette en losange, dents pointues vers l'avant — https://en.wikipedia.org/wiki/Rhamphorhynchus
  - À garder : longue queue rigide (≈ longueur du corps + tête) avec palette au bout, ailes étroites, museau long à dents qui dépassent (2 dents cartoon seulement), cou court.
- Couche thématique : la palette de queue = feuille (losange 0,35 × 0,25 avec nervure centrale) ; ailes découpées en grande feuille (bord lisse, 3 nervures peintes) ; crête = feuille recourbée vers l'arrière (0,5) ; liane (spirale de 3 tours, Ø 0,05) à chaque poignet, prolongée par 0,4 de liane libre (os séparé) ; 1 fleur jaune (5 pétales, accent) sur la crête.

### Ronceplaque — Quadrupède — taille 1,1
- Silhouette : dos couvert d'épines en ronces, queue en massue épineuse, petits yeux tristes.
- Couleurs : `#6A1B9A` / `#A5D6A7` / `#E91E63`
- Émissif : petites baies au bout des épines, rose.
- Personnalité : câlin frustré ; tend la tête vers le joueur, soupire, baisse les épaules.
- Référence réelle : *Ankylosaurus magniventris*, ankylosaure large et bas, couvert de plaques osseuses, queue à massue — https://en.wikipedia.org/wiki/Ankylosaurus
  - À garder : corps très large et plat, tête triangulaire avec 2 petites cornes à l'arrière du crâne, queue rigide terminée par une massue à 2 lobes, pattes écartées.
- Couche thématique : dos = 4 bandes de plaques, chacune hérissée de 3 épines de ronce courbées (cônes 0,2 penchés vers l'arrière) ; 12 baies (sphères 0,07, accent émissif) aux pointes ; massue = 2 boules de ronce entrelacée (Ø 0,35) avec épines ; sourcils en accent circonflexe peints (air triste) ; 1 pansement (rectangle beige) sur le museau.

## Épique

### Orageceros — Quadrupède — taille 1,25
- Silhouette : une très longue corne en éclair zigzag sur le nez, crinière de nuage gris sur la nuque.
- Couleurs : `#37474F` / `#90A4AE` / `#FFEE58`
- Émissif : corne jaune électrique, arcs qui crépitent.
- Personnalité : nerveux ; sursaute, la crinière se hérisse, regarde le ciel.
- Référence réelle : *Styracosaurus albertensis*, cératopsien à très longue corne nasale et collerette bordée de longues pointes — https://en.wikipedia.org/wiki/Styracosaurus
  - À garder : UNE grande corne nasale (≈ longueur du crâne), pas de cornes au-dessus des yeux, 6 longues pointes rayonnant du bord de la collerette, corps de rhinocéros.
- Couche thématique : corne nasale = éclair en 3 segments zigzag (longueur totale 0,9, section losange) émissif ; les 6 pointes de collerette deviennent des nuages (grappes de 3 sphères 0,2 en gris clair) formant la « crinière » ; 2 petits éclairs (0,25) entre les nuages ; 1 paratonnerre miniature planté sur la nuque (tige + boule 0,08).

### Cristalodon — Aquatique — taille 1,2
- Silhouette : rangée de cristaux le long du dos, nageoires taillées en facettes, queue diamant.
- Couleurs : `#7E57C2` / `#E1BEE7` / `#80DEEA`
- Émissif : cristaux cyan, scintillement.
- Personnalité : élégant ; ondule lentement, petite pirouette sur lui-même.
- Référence réelle : *Ophthalmosaurus icenicus*, ichthyosaure en forme de dauphin aux yeux immenses (« lézard-œil ») — https://en.wikipedia.org/wiki/Ophthalmosaurus
  - À garder : corps en goutte fuselé, rostre fin, ÉNORMES yeux (≈ 1/3 de la hauteur de la tête), nageoire caudale en croissant à 2 lobes, nageoire dorsale triangulaire.
- Couche thématique : nageoire dorsale remplacée par 5 cristaux hexagonaux (prismes 6 côtés, 0,15 à 0,5) en grappe ; nageoires pectorales taillées en facettes (3 faces visibles chacune) ; caudale = 2 lobes en diamant (taille brillant, 8 facettes) ; anneau oculaire facetté autour de chaque œil ; 1 petit lustre (3 pendeloques) suspendu sous le menton.

### Volcanokéros — Quadrupède — taille 1,35
- Silhouette : cratère fumant sur le dos, 2 cornes de roche, pattes comme des colonnes de basalte.
- Couleurs : `#3E2723` / `#5D4037` / `#FF5722`
- Émissif : fissures de lave sur le corps + bouche du cratère + naseaux.
- Personnalité : joyeux ; souffle des ronds de fumée par le nez, frétille de la queue.
- Référence réelle : *Diabloceratops eatoni*, cératopsien (« face cornue du diable ») à 2 très longues pointes sur la collerette — https://en.wikipedia.org/wiki/Diabloceratops
  - À garder : 2 longues pointes dressées en haut de la collerette (les « 2 cornes de roche »), petites cornes au-dessus des yeux, petite corne nasale, collerette courte.
- Couche thématique : les 2 pointes de collerette = obélisques de basalte (prismes 6 côtés, 0,7 de haut) ; cratère sur le dos = cône tronqué (Ø base 0,9, Ø bouche 0,4, h 0,35) avec disque de lave émissif dedans ; pattes en colonnes hexagonales (6 faces plates nettes) ; 5 fissures de lave en Y dans la texture ; panache de fumée = particules Roblox (pas de mesh).

### Abyssaure — Aquatique — taille 1,3
- Silhouette : longue mâchoire, antenne-lanterne au front, nageoires frangées, gros yeux ronds.
- Couleurs : `#1A237E` / `#283593` / `#00E5FF`
- Émissif : lanterne + points lumineux sur les flancs.
- Personnalité : fêtard des profondeurs ; balance sa lanterne comme une boule à facettes.
- Référence réelle : *Tylosaurus*, mosasaure au long museau terminé par un rostre osseux sans dents, 4 palettes et queue à 2 lobes — https://en.wikipedia.org/wiki/Tylosaurus
  - À garder : tête longue de lézard marin (≈ 1/4 du corps), bout du museau en « bouton », 4 nageoires en palette, queue coudée vers le bas avec nageoire en croissant.
- Couche thématique : antenne-lanterne (tige courbe 0,6 partant du front, os à 2 segments) terminée par une boule à facettes (icosphère 1 subdivision, Ø 0,2, émissive) ; 8 points lumineux (disques 0,06) en ligne sur chaque flanc ; bord des nageoires frangé (5 dents arrondies chacune) ; yeux ronds en sphères pleines 0,18 avec reflet peint ; 2 rangs de petites dents blanches visibles bouche fermée.

## Légendaire

### Éclipsaurus — Théropode — taille 1,4
- Silhouette : anneau solaire (halo d'éclipse) fixé derrière la tête, crête en croissant, queue longue fine.
- Couleurs : `#212121` / `#FFD54F` / `#FFF8E1`
- Émissif : contour de l'anneau doré (couronne solaire).
- Personnalité : majestueux ; lève le menton, l'anneau tourne lentement.
- Référence réelle : *Dilophosaurus wetherilli*, théropode élancé à 2 fines crêtes parallèles sur le crâne — https://en.wikipedia.org/wiki/Dilophosaurus
  - À garder : 2 crêtes minces en arc du nez au-dessus des yeux, cou fin en S, encoche visible dans la mâchoire supérieure, corps élancé, longue queue fine. (Pas de collerette ni de crachat : c'est une invention de film.)
- Couche thématique : les 2 crêtes fusionnent en croissant de lune (arc plat 0,6, couleur secondaire) ; anneau d'éclipse derrière la tête : disque noir Ø 0,9 + tore Ø 1,1 émissif doré + 8 rayons triangulaires (0,2) sur le tore ; texture corps noir avec ventre crème ; bout de queue effilé avec 1 petite étoile (4 branches, 0,12).

### Ambrelion — Théropode — taille 1,4
- Silhouette : grosse crinière de pointes d'ambre autour du cou, queue à touffe, pattes musclées.
- Couleurs : `#FF8F00` / `#FFE082` / `#6D4C41`
- Émissif : pointes d'ambre translucides (3 petits points noirs dedans).
- Personnalité : fier ; secoue sa crinière, écoute ses moustiques (tête penchée).
- Référence réelle : *Yutyrannus huali*, grand tyrannosauroïde (« beau tyran à plumes ») couvert de longs filaments, avec une crête ondulée sur le museau — https://en.wikipedia.org/wiki/Yutyrannus
  - À garder : plumage filamenteux épais (en crinière autour du cou), petite crête ondulée sur le museau, bras à 3 doigts encore assez longs, pattes puissantes.
- Couche thématique : crinière = collier de 14 pointes d'ambre (cônes 4 côtés 0,3–0,5, matériau translucide, Transparency 0,3 côté Roblox) en 2 couronnes ; 3 moustiques (corps 0,05 + 2 ailes plates) visibles dans 3 pointes avant ; touffe de queue = 5 mèches de filaments (cônes aplatis) ; crête ondulée sur le museau en 3 bosses couleur accent.

### Tonnerrex — Théropode — taille 1,5
- Silhouette : T-rex massif, 2 cornes-paratonnerres, rayures en zigzag, queue en éclair.
- Couleurs : `#1565C0` / `#0D47A1` / `#FFFF00`
- Émissif : rayures et cornes, éclairs intermittents.
- Personnalité : bruyant ; ouvre la gueule, rien ne sort... puis rugit avec 1 s de retard.
- Référence réelle : *Tyrannosaurus rex*, grand tyrannosauridé au crâne massif et aux bras minuscules à 2 doigts — https://en.wikipedia.org/wiki/Tyrannosaurus
  - À garder : crâne énorme et large à l'arrière, bras ridicules à 2 doigts, cuisses massives, queue épaisse à l'horizontale (posture penchée, pas « kangourou »).
- Couche thématique : 2 cornes-paratonnerres au-dessus des yeux (tige métal 0,4 + boule 0,1 + 3 anneaux, accent émissif) ; 6 rayures zigzag sur les flancs (texture émissive) ; dernier tiers de la queue plié en éclair (2 coudes à 40°) ; 1 nuage d'orage miniature (3 sphères) qui flotte au-dessus de la tête (pièce séparée attachée à un os).

### Aurorasaure — Ptérosaure — taille 1,45
- Silhouette : très grandes ailes dégradées, longue crête en ruban, queue à rubans flottants.
- Couleurs : `#00BFA5` / `#7C4DFF` / `#F48FB1`
- Émissif : membranes des ailes (dégradé vert-violet-rose qui ondule).
- Personnalité : timide-coquet ; déploie les ailes quand on le regarde, les replie sinon.
- Référence réelle : *Pteranodon longiceps*, grand ptérosaure sans dents à longue crête dirigée vers l'arrière — https://en.wikipedia.org/wiki/Pteranodon
  - À garder : bec long et pointu sans dents, crête arrière qui équilibre le bec (silhouette en « pioche »), grande envergure, queue très courte, petit corps.
- Couche thématique : la crête se prolonge en 2 rubans d'aurore (plans courbes 1,2 de long, 3 os chacun) ; membranes des ailes en dégradé vertical vert → violet → rose avec 4 vagues peintes ; 3 rubans courts (0,6) en guise de queue ; 6 petites étoiles (4 branches, 0,08) collées au bord de fuite des ailes.

## Mythique

### Nébulodon — Aquatique — taille 1,6
- Silhouette : corps translucide de nébuleuse, nageoires en voiles de gaz, étoiles incrustées, queue en comète.
- Couleurs : `#311B92` / `#E040FB` / `#FFFFFF`
- Émissif : étoiles + bord des nageoires + traînée de queue.
- Personnalité : rêveur ; flotte en l'air, croque une étoile, regard perdu.
- Référence réelle : *Elasmosaurus platyurus*, plésiosaure au cou extrêmement long (plus de la moitié du corps), petite tête et 4 grandes palettes — https://en.wikipedia.org/wiki/Elasmosaurus
  - À garder : cou très long en courbe de cygne (on le raccourcit à ≈ 1,2 × le corps pour le chibi), petite tête (grossie), corps en tonneau aplati, 4 palettes en aile.
- Couche thématique : les 4 palettes deviennent des voiles de gaz (plans ondulés à bord frangé, 0,9 de long, alpha dégradé dans la texture) ; 12 étoiles (4 branches, 0,05–0,12) incrustées le long du cou ; queue = comète (cône allongé 1,4, dégradé blanc → violet, émissif) ; 1 étoile tenue dans la gueule (pièce attachée à la mâchoire, masquable).

### Chronoraptor — Théropode — taille 1,5
- Silhouette : cadran d'horloge sur le flanc, crête en aiguilles, sablier sur le bout de queue, rouages aux épaules.
- Couleurs : `#B0BEC5` / `#FFD700` / `#00E5FF`
- Émissif : cadran et sablier cyan, aiguilles qui tournent.
- Personnalité : pressé ; regarde son flanc-horloge, tape du pied, sursaute.
- Référence réelle : *Velociraptor mongoliensis*, dromaeosaure à plumes, griffe en faucille au 2ᵉ orteil et queue raidie — https://en.wikipedia.org/wiki/Velociraptor
  - À garder : griffe en faucille relevée sur chaque pied, longue queue droite et rigide, bras repliés avec plumes de bras, museau long et légèrement concave.
- Couche thématique : la griffe en faucille = aiguille d'horloge dorée (0,3) ; cadran sur le flanc (disque Ø 0,6, 12 graduations, 2 aiguilles séparées pour la rotation) ; 3 engrenages dorés sur les épaules et le dos (rayons 0,25 / 0,18 / 0,12, 10 / 8 / 6 dents) ; crête = 3 aiguilles de montre en éventail ; plumes de bras en forme d'aiguilles de pendule ; bout de queue = sablier (2 cônes 0,15 + 2 disques dorés) au sable cyan émissif ; yeux en petit cadran (iris à 4 traits).

### Magmaroi — Quadrupède — taille 1,75
- Silhouette : couronne de lave refroidie, cape de roche sur les épaules, plaques de basalte, cou dressé fier.
- Couleurs : `#212121` / `#BF360C` / `#FFAB00`
- Émissif : pointes de la couronne + veines de magma entre les plaques.
- Personnalité : royal et capricieux ; lève le nez, frappe le sol d'une patte, attend qu'on s'incline.
- Référence réelle : *Regaliceratops peterhewsi*, cératopsien canadien (« face cornue royale ») à collerette en forme de couronne — https://en.wikipedia.org/wiki/Regaliceratops
  - À garder : collerette courte et large en demi-cercle bordée de grosses plaques en pentagone (la couronne), grande corne nasale, petites cornes au-dessus des yeux, tête portée haute.
- Couche thématique : les plaques de bord de la collerette = 7 pointes de couronne en lave refroidie (pentagones 0,3, pointe émissive) ; corne nasale en obsidienne facettée ; cape de roche (plan épais à 6 facettes) drapée des épaules à mi-dos, bord liseré de magma ; 1 gemme de lave (octaèdre 0,15) au centre de la collerette ; veines de magma entre plaques de basalte en texture émissive.

### Spectrosaure — Ptérosaure — taille 1,6
- Silhouette : ailes déchirées en lambeaux fantômes, crête en voile, pas de pattes visibles (bas du corps en traîne).
- Couleurs : `#CFD8DC` / `#80CBC4` / `#B388FF`
- Émissif : tout le corps semi-transparent + yeux violets.
- Personnalité : farceur ; disparaît/réapparaît (clignotement), fait « bouh » en ouvrant les ailes.
- Référence réelle : *Nyctosaurus*, ptérosaure (« lézard de la nuit ») à immense crête en bois de cerf et mains sans griffes — https://en.wikipedia.org/wiki/Nyctosaurus
  - À garder : crête en 2 longues branches (une vers le haut, une vers l'arrière), plus haute que le crâne ; ailes sans doigts griffus ; bec long et fin.
- Couche thématique : entre les 2 branches de la crête, un voile fantôme (plan triangulaire déchiré, 3 trous) ; ailes en lambeaux (bord de fuite découpé en 6 pointes irrégulières) ; bas du corps en traîne de drap (cône ondulé 0,8, 3 os) ; 1 petit miroir à main (ovale 0,25) accroché au cou ; yeux = 2 ovales émissifs violets sans pupille.

## Primordial

### Titanomarbre — Quadrupède — taille 2,0
- Silhouette : colosse sculpté, colonnes antiques comme pattes, socle sous les pieds, veines dorées, cornes en volutes.
- Couleurs : `#F5F5F5` / `#BDBDBD` / `#FFD700`
- Émissif : veines dorées, lueur lente.
- Personnalité : poseur ; prend une pose de statue, la tient, change de pose.
- Référence réelle : *Patagotitan mayorum*, titanosaure argentin parmi les plus grands animaux terrestres connus — https://en.wikipedia.org/wiki/Patagotitan
  - À garder : silhouette de sauropode (long cou, longue queue, petite tête — grossie ×2), 4 pattes en piliers, épaules un peu plus hautes que les hanches. Cou raccourci à ≈ la longueur du corps pour tenir sur un socle.
- Couche thématique : 4 pattes = colonnes doriques cannelées (8 cannelures, chapiteau carré 0,1 en haut) ; socle de statue (pavé 0,15 d'épaisseur, bord mouluré) sous les 4 pieds ; 2 cornes en volutes ioniques (spirales plates de 1,5 tour, Ø 0,3) au-dessus des yeux ; feuille de laurier dorée (couronne de 9 feuilles) autour du cou ; veines dorées émissives en texture ; plaque gravée « ΤΙΤΑΝ » sur le socle.

### Solaripteryx — Ptérosaure — taille 1,9
- Silhouette : ailes en rayons de soleil (bord dentelé en flammes), crête-disque solaire, longue queue de feu.
- Couleurs : `#FFC107` / `#FF6F00` / `#FFFDE7`
- Émissif : crête-disque + bord des ailes + queue (flammes).
- Personnalité : leader matinal ; bat des ailes, pointe le bec vers le ciel, s'étire.
- Référence réelle : *Tupandactylus imperator*, ptérosaure brésilien à gigantesque crête arrondie (hauteur ≈ 1/3 de l'envergure) et bec court — https://en.wikipedia.org/wiki/Tupandactylus
  - À garder : crête-voile énorme, ronde et rejetée vers l'arrière (plus grande que la tête), bec court et pointu, cou fort, queue très courte (la queue de feu est entièrement thématique).
- Couche thématique : la crête = disque solaire (Ø 1,0) avec 12 rayons triangulaires (0,2) sur le pourtour, émissif ; bord d'attaque des ailes dentelé en 7 flammes ; queue de feu ajoutée (3 langues de flamme superposées, 1,2 de long, 3 os) ; anneau de lever de soleil (demi-tore) sous le menton.

### Gaïatops — Quadrupède — taille 2,2
- Silhouette : une petite forêt (3 arbres + champignons) sur le dos, collerette en racines, cornes en bois de cerf.
- Couleurs : `#795548` / `#4CAF50` / `#FF80AB`
- Émissif : champignons roses lumineux, lucioles.
- Personnalité : sereine ; respire lentement, les arbres se balancent, un oiseau se pose.
- Référence réelle : *Torosaurus latus*, cératopsien au crâne parmi les plus longs de tous les animaux terrestres, à collerette géante percée de 2 grandes ouvertures — https://en.wikipedia.org/wiki/Torosaurus
  - À garder : collerette immense et plate (≈ hauteur du corps) avec 2 fenêtres ovales, 2 longues cornes au-dessus des yeux, petite corne nasale, dos large et plat (sol de la forêt).
- Couche thématique : collerette = entrelacs de racines (bord fait de 9 racines-boudins), les 2 fenêtres remplies de mousse ; les 2 cornes deviennent des bois de cerf (2 branches + 3 andouillers chacune) ; sur le dos : 3 sapins low-poly (cônes empilés, h 0,6 / 0,5 / 0,4) + 5 champignons (chapeau Ø 0,1–0,18, accent émissif) ; 1 petit nid avec oiseau (pièce séparée animée).

### Léviathodon — Aquatique — taille 2,4
- Silhouette : immense, mâchoire géante, nageoires-ailes, plaques d'armure abyssales, vortex d'eau autour de la queue.
- Couleurs : `#004D40` / `#00838F` / `#64FFDA`
- Émissif : runes-marées sur les plaques + gorge quand il bâille.
- Personnalité : flegmatique ; bâille énormément (gueule grande ouverte), l'eau tourbillonne.
- Référence réelle : *Kronosaurus queenslandicus*, pliosaure au crâne de 2 m et plus, cou court et 4 grandes palettes (les arrière plus grandes) — https://en.wikipedia.org/wiki/Kronosaurus
  - À garder : tête énorme (≈ 1/3 du corps), cou presque inexistant, bout de mâchoire en cuillère avec grosses dents, 4 palettes en aile (arrière > avant), queue courte.
- Couche thématique : 7 plaques d'armure segmentées sur le dos (cuirasse de crustacé, chaque plaque gravée d'une rune-vague émissive) ; 4 palettes en ailes de raie (bord arrière ondulé) ; gorge en 2 pièces (intérieur émissif visible en bâillant, mâchoire ouvrable à 70°) ; vortex autour de la queue = 2 tores en spirale (Ø 0,8 / 0,6) semi-transparents, os de rotation.

## Secret

### Glitchosaure — Théropode — taille 1,6
- Silhouette : corps en blocs voxels décalés, morceaux qui flottent détachés (queue en cubes), un œil pixel.
- Couleurs : `#FF00FF` / `#00FF00` / `#000000`
- Émissif : tout le corps, effet « glitch » RGB (décalage de couleurs, frames qui sautent).
- Personnalité : instable ; se téléporte de quelques studs, se fige, saccade, « T-pose » une fraction de seconde.
- Référence réelle : *Spinosaurus aegyptiacus*, grand théropode à voile dorsale et museau de crocodile, dont l'apparence reconstituée a changé plusieurs fois (bipède, quadrupède, nageur) — https://en.wikipedia.org/wiki/Spinosaurus
  - À garder : grande voile dorsale (point le plus haut de la silhouette), museau long et étroit, pattes arrière courtes, queue haute et aplatie comme une rame. Le clin d'œil : un dino « jamais fini de charger », à l'image de ses reconstitutions successives.
- Couche thématique : tout le mesh en cubes plats (aucun biseau) ; voile = 9 colonnes de voxels (0,2) de hauteurs inégales, 2 colonnes décalées de 0,1 sur le côté ; queue en 6 cubes séparés flottants (os distincts, écart 0,05–0,15) ; 1 œil en pixel carré (0,15) et l'autre en « ? » ; 1 face du museau texturée en damier magenta/noir (texture manquante) ; contour de chaque bloc en ligne verte néon.

### Omégarex — Théropode — taille 2,5
- Silhouette : T-rex cosmique, couronne de cornes en galaxie, symbole Ω flottant au-dessus de la tête, queue qui se dissout en étoiles, anneaux d'orbite.
- Couleurs : `#0D0221` / `#7B1FA2` / `#FFD740`
- Émissif : symbole Ω + yeux + motifs d'étoiles qui défilent sur la peau (texture ciel cosmique).
- Personnalité : boss final ; regarde le joueur de haut, croise les petits bras, rugit en faisant trembler l'écran.
- Référence réelle : *Giganotosaurus carolinii*, carcharodontosauridé argentin rival du T. rex en taille, au crâne long et étroit — https://en.wikipedia.org/wiki/Giganotosaurus
  - À garder : crâne plus long et plus bas que celui du T. rex (silhouette distincte de Tonnerrex), petite crête osseuse au-dessus des yeux, bras à 3 doigts, longue queue puissante.
- Couche thématique : couronne de 7 cornes en spirale de galaxie (cônes torsadés 0,3–0,6) le long du crâne ; symbole Ω (extrusion 0,5 × 0,5 × 0,06, émissif doré) qui flotte 0,6 au-dessus de la tête ; 2 anneaux d'orbite inclinés (tores Ø 2,0 et 2,4, épaisseur 0,04) autour du torse, chacun avec 1 petite planète (sphère 0,12) ; derniers 40 % de la queue en 10 fragments de plus en plus petits qui se détachent en étoiles (4 branches).

## Exclusif (jamais tiré au dé, vendu en Robux)

### Peluchorex — Théropode — taille 1,0
- Silhouette : T-rex en peluche cousue main, assis et trapu : tête énorme (≈ le torse) au museau rond, gueule immense toujours entrouverte, bras moignons à 3 grosses griffes sombres, cuisses rondes, grosse queue posée au sol au bout recourbé, petites pointes de feutre vert de l'arrière du crâne au dos.
- Couleurs : `#F77AB0` / `#E8C9D3` / `#7CB342` (dos `#D9668F`, boutons marron foncé = intérieur de bouche `#6A1B2A`)
- Émissif : 2 éclats d'yeux dorés `#FFD54F` au fond de la gueule (visibles gueule ouverte) + tirette dorée de la fermeture éclair.
- Personnalité : peluche vivante maladroite, grognon-mignonne. Idle : se dégonfle lentement (s'affaisse, tête qui penche, gueule qui se referme, petits frissons « pfff »), puis se regonfle d'un coup avec un rebond, gueule grande ouverte. Death : sursaut, les genoux lâchent, puis bascule mollement sur le côté comme une peluche vide.
- Référence réelle : *Tyrannosaurus rex* — https://en.wikipedia.org/wiki/Tyrannosaurus
  - À garder : crâne énorme et large, grande gueule aux dents triangulaires, bras minuscules, cuisses massives, queue épaisse (ici posée au sol, comme une peluche assise).
- Couche thématique : coutures en relief (trait rose foncé + points blancs en travers) du museau à la nuque, sur la queue et en anneau sur le bras gauche ; 2 gros boutons à 8 pans (Ø 0,4–0,5) cousus en croix à l'épaule et à la hanche droites ; fermeture éclair sur le ventre (bande blanche ≈ 0,18 × 1,0, crans sombres, tirette dorée qui pendouille, os Zip) ; 7 pointes de feutre vert en plaques plates ; paupières lourdes inclinées, air grognon, iris vert ; 2 éclats dorés au fond de la gueule ; griffes sombres, dents blanches triangulaires.
