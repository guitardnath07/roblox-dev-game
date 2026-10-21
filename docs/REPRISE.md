# Reprise — état au 2026-10-19 (tout arrêté)

## Fait
- Jeu : version « jeux-premier » dans `src/` (ancienne version sauvegardée dans `_backup_avant_maj_2026-10-19/`). `rojo build` OK.
- Références des 28 dinos : `docs/dinos-concept.md` (vrai dinosaure + couche thématique).
- Dinos 3D (21/10/2026) : les 28 dinos + Peluchorex (29e, pas encore dans Config/Dinos.luau, rareté à choisir) sont construits,
  rendus et exportés (`src/client/DinoMeshes` + `DinoAnims`), style chibi + « plaques » à facettes (normales par face :
  `FLAT_SHADING` dans `DinoModels.luau`). Planche : `docs/renders/dinos/planche.jpg`. Palettes fusionnées dans `DinoLooks.luau`.
  Blender tourne aussi dans le cloud (`pip install bpy==5.2.2` + libegl1), voir les build_<id>.py.
- Scripts de construction : `blender/scripts/dinos/` (`build_<id>.py`, outils `dd_dino_rig.py`, aides par famille), export `blender/scripts/export_luau.py`.
- Rendus : `docs/renders/dinos/`. Progression : `docs/renders/dinos/progress_A.md`.
- Code jeu qui affiche les dinos 3D : `src/client/DinoModels.luau`.

## À faire
1. Choisir la rareté de Peluchorex et l'ajouter à `Config/Dinos.luau` + `docs/dinos-concept.md`.
2. Tester en Play dans Studio et sur mobile : facettes, bouche au rugissement, perfs avec 20–30 dinos.

## Pour relancer
- Rojo : `rojo serve default.project.json` (Rokit : `%USERPROFILE%\.rokit\bin`), puis Connect dans le plugin Studio.
- Construire un dino sans interface : `blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_<id>.py`.
- Les agents s'arrêtaient sur la **limite d'usage du compte Claude** (HTTP 429), pas sur un bug.
