# Pipeline 3D : Blender → Roblox (Théropode d'abord)

Fichiers produits par le blender-artist dans `blender/exports/` :
`theropod_model.fbx` (le modèle riggé), `theropod_Idle.fbx` et `theropod_Walk.fbx` (une animation chacun).

Ces étapes se font dans l'interface de Studio : le MCP ne sait pas importer de FBX ni publier d'animations.

## 1. Importer le modèle
1. Studio → onglet **Accueil** (Home) → **Importer en 3D** (Import 3D) → choisis `blender/exports/theropod_model.fbx`.
2. Dans la fenêtre d'import :
   - **Rig Type** : `Custom` (pas R15, pas de Humanoid).
   - **Set Pivot to Scene Origin** : coché.
   - **Upload to Roblox** : coché.
   - Lis les avertissements en bas et note-les si tu en vois.
3. **Import**. Le modèle arrive dans le Workspace.
4. Si le modèle n'a pas d'`AnimationController`, clic droit sur le modèle → **Insérer un objet** → `AnimationController`, puis dans celui-ci → `Animator`.
5. Renomme le modèle exactement **`theropod`**.
6. Dans l'Explorateur, crée `ReplicatedStorage` → Dossier **`Assets`** → Dossier **`Dinos`**, et glisse `theropod` dedans.
   Le jeu l'utilise alors pour **tous les Théropodes** posés sur les socles, en attendant les variantes.

## 2. Importer et publier les animations
1. Onglet **Avatar** → **Éditeur d'animation** (Animation Editor) → clique sur le modèle `theropod`.
2. Menu **…** → **Importer** → **Depuis un fichier FBX** → `theropod_Idle.fbx`.
3. Coche **Boucle** (Looping), et choisis la priorité **Idle**.
4. Menu **…** → **Publier sur Roblox** → propriétaire = **le même que le jeu** (ton groupe, ou ton compte si le jeu est à ton nom).
   Copie l'**ID** affiché.
5. Recommence avec `theropod_Walk.fbx` : boucle cochée, priorité **Movement**.
6. Envoie-moi les deux ID : je les mets dans `src/shared/Config/Animations.luau` (`theropod = { Idle = …, Walk = … }`).

## 3. Si les os arrivent tournés dans tous les sens
C'est un bug connu de l'import FBX dans Roblox.
1. Réimporte l'animation en choisissant l'option de pose de repos « rotations remises à zéro », si Studio la propose.
2. Sinon, dis-le-moi : le blender-artist réaligne l'armature sur les axes du monde et réexporte.
Note ici ce qui a marché, pour les 3 autres archétypes :

- Résultat : _(à remplir)_
