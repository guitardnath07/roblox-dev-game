# DINO DICE — lance export_luau.py SANS toucher src/shared/Config/DinoLooks.luau (palette : blender/dinos/<id>_look.json).
# Version : 1
#   blender -b blender/dinos/<id>.blend --python-exit-code 1 -P blender/scripts/dinos/export_nolooks.py
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import export_luau as E  # noqa: E402

E.update_looks = lambda dino_id, colors: "non modifié (blender/dinos/%s_look.json)" % dino_id
print("DD_RESULT", json.dumps(E.export_dino()))
