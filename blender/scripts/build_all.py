# DINO DICE — Reconstruit les 4 bases d'archétype et les enregistre dans blender/archetypes.blend.
# Version : 1
# Lancement : `blender -b -P blender/scripts/build_all.py` ou depuis le Text Editor de Blender.
# Chaque archétype vit dans sa scène « DD_<Archetype> » avec sa collection (mesh) + « <Archetype>_Rendu »
# (caméra de rendu). L'enregistrement passe par bpy.data.libraries.write : le fichier ouvert dans Blender
# n'est ni renommé ni modifié en dehors de ces scènes.

import importlib
import os
import sys

import bpy

SCRIPTS_DIR = os.path.dirname(os.path.abspath(__file__))
BLENDER_DIR = os.path.dirname(SCRIPTS_DIR)
if SCRIPTS_DIR not in sys.path:
    sys.path.insert(0, SCRIPTS_DIR)

MODULES = ["build_theropod", "build_quadruped", "build_pterosaur", "build_aquatic"]


def build_all(save=True):
    results = {}
    scenes = set()
    for name in MODULES:
        mod = importlib.import_module(name)
        importlib.reload(mod)
        results[name] = mod.build()
        scenes.add(bpy.data.scenes["DD_" + mod.NAME])
    if save:
        path = os.path.join(BLENDER_DIR, "archetypes.blend")
        bpy.data.libraries.write(path, scenes, path_remap="RELATIVE_ALL", fake_user=True)
        results["fichier"] = path
    return results


if __name__ == "__main__":
    print(build_all())
