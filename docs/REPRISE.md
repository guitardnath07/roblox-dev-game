# Reprise — état au 2026-10-19 (tout arrêté)

## Fait
- Jeu : version « jeux-premier » dans `src/` (ancienne version sauvegardée dans `_backup_avant_maj_2026-10-19/`). `rojo build` OK.
- Références des 28 dinos : `docs/dinos-concept.md` (vrai dinosaure + couche thématique).
- Dinos 3D :
  | Dino | .blend | Données jeu (`src/client/DinoMeshes` + `DinoAnims`) |
  |---|---|---|
  | chronoraptor | ✅ v2 (pilote validé) | ✅ format v2 « dd64 » |
  | moussecrete | ✅ | ✅ |
  | galetosaure | en cours (modèle) | ❌ |
  | lianopteryx | en cours (rig/animations à faire) | ❌ |
  | 24 autres | ❌ | ❌ |
- Scripts de construction : `blender/scripts/dinos/` (`build_<id>.py`, outils `dd_dino_rig.py`, aides par famille), export `blender/scripts/export_luau.py`.
- Couleurs : `src/shared/Config/DinoLooks.luau` (chronoraptor) + `blender/dinos/<id>_look.json` (à fusionner dans DinoLooks).
- Rendus : `docs/renders/dinos/`. Progression : `docs/renders/dinos/progress_A.md`.
- Code jeu qui affiche les dinos 3D : `src/client/DinoModels.luau`.

## À faire
1. **Mettre `DinoModels.luau` au format v2 « dd64 »** (l'intégrateur a été arrêté en plein test) — le décodeur est en commentaire en tête de chaque fichier généré. Tant que ce n'est pas fait, les dinos v2 ne s'affichent pas en jeu.
2. Fusionner les `*_look.json` dans `DinoLooks.luau` (champs main, belly, accent, glow, back).
3. Finir galetosaure et lianopteryx, puis les 24 autres (liste par famille : théropodes A, quadrupèdes B, ptérosaures + aquatiques C).
4. Tester en Play dans Studio : sens des faces, bouche au rugissement, perfs avec 20–30 dinos.

## Pour relancer
- Rojo : `rojo serve default.project.json` (Rokit : `%USERPROFILE%\.rokit\bin`), puis Connect dans le plugin Studio.
- Construire un dino sans interface : `blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_<id>.py`.
- Les agents s'arrêtaient sur la **limite d'usage du compte Claude** (HTTP 429), pas sur un bug.
