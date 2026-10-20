# DINO DICE — export d'un théropode du Modeleur A avec export_luau.py tel quel, SANS écrire DinoLooks.luau
# (plusieurs modeleurs en parallèle : la palette est dans blender/dinos/<id>_look.json, fusionnée par le lead).
#   blender -b blender/dinos/<id>.blend --python-exit-code 1 -P blender/scripts/dinos/theropod_export.py
import json
import os
import sys

SCRIPTS_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, SCRIPTS_DIR)
import export_luau as E  # noqa: E402

E.update_looks = lambda dino_id, colors: "non écrit (voir blender/dinos/%s_look.json)" % dino_id
print("DD_RESULT", json.dumps(E.export_dino()))
