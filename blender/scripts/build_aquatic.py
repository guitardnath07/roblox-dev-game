# DINO DICE — Base d'archétype AQUATIQUE (corps fuselé, 4 nageoires, queue en pagaie).
# Version : 3 (v3 : queue en pagaie horizontale au lieu d'un aileron vertical ; v2 : racine du Skin au bout du museau = anneaux alignés, fin du torse « en boîte » ; Subdivision 2 ; 2 boucles retirées pour le budget)
# Pose de référence : flotte à l'horizontale ; origine au point le plus bas (sous la nageoire caudale / le ventre).
# Re-jouable : reconstruit la scène « DD_Aquatique » / collection « Aquatique » à chaque exécution.
# Lancement : depuis Blender (Text Editor > Run) ou via build_all.py (enregistre blender/archetypes.blend).

import importlib
import os
import sys

SCRIPTS_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(os.path.dirname(SCRIPTS_DIR))
if SCRIPTS_DIR not in sys.path:
    sys.path.insert(0, SCRIPTS_DIR)
import dd_common as dd  # noqa: E402

importlib.reload(dd)

NAME = "Aquatique"
LENGTH = 6.0  # studs, du museau au bout de la pagaie
SMOOTH = 1  # passes de lissage du corps
SUBDIV = 2  # corps fuselé simple (peu de boucles) : Subdivision 2 pour un corps bien rond, budget tenu

C_BODY = dd.hex_rgba("#33B5E5")
C_BELLY = dd.hex_rgba("#E6F7FF")
C_FIN = dd.hex_rgba("#1E7FC2")
C_DARK = dd.hex_rgba("#0D3B66")

# Demi-squelette (x >= 0), corps horizontal : tête -> torse -> queue (une boucle par segment).
NODES = [
    ("corps", (0, 0.00, 1.20), 1.00, None),
    ("poitrine", (0, -0.80, 1.30), 0.95, "corps"),
    ("cou", (0, -1.50, 1.50), 0.62, "poitrine"),
    ("crane", (0, -2.05, 1.75), 0.88, "cou"),
    ("machoire", (0, -2.60, 1.65), 0.72, "crane"),
    ("museau", (0, -3.15, 1.53), 0.50, "machoire"),
    ("queue1", (0, 0.90, 1.20), 0.80, "corps"),
    ("queue2", (0, 1.70, 1.25), 0.56, "queue1"),
    ("queue3", (0, 2.60, 1.32), 0.30, "queue2"),
]

# Nageoire dorsale (plan de symétrie x = 0)
DORSAL = [(0, -0.45, 2.00), (0, 0.10, 2.75), (0, 0.45, 2.70), (0, 0.80, 1.95)]
# Queue en pagaie : palette plate et HORIZONTALE (plan XY) au bout de la queue, contour arrondi convexe
_PADDLE_R = [(0.28, 2.45), (0.75, 2.75), (1.00, 3.15), (0.95, 3.55), (0.60, 3.85)]
CAUDAL = ([(x, y, 1.30) for x, y in _PADDLE_R] + [(0.0, 3.95, 1.30)]
          + [(-x, y, 1.30) for x, y in reversed(_PADDLE_R)])
# Nageoires droites (le miroir crée les gauches), légèrement inclinées vers le bas
FLIPPER_AV = [(0.70, -1.05, 1.00), (1.55, -1.30, 0.70), (2.25, -1.15, 0.45), (2.25, -0.80, 0.42),
              (1.50, -0.55, 0.68), (0.70, -0.45, 0.95)]
FLIPPER_AR = [(0.65, 0.55, 0.95), (1.30, 0.55, 0.65), (1.80, 0.75, 0.45), (1.75, 1.05, 0.45),
              (1.20, 1.05, 0.65), (0.60, 1.05, 0.95)]


def build():
    sc, col, rcol = dd.setup_scene("DD_" + NAME, NAME)

    body = dd.skin_body(NAME + "_Corps", NODES, col, branch_smoothing=0.7, subdiv=SUBDIV, smooth_iters=SMOOTH,
                        root="museau")
    dd.fill_color(body.data, C_BODY)
    dd.paint_faces(body.data, lambda c, n: n.z < -0.25 and c.y < 2.2, C_BELLY)

    parts = [body]
    parts.append(dd.membrane("Dorsale", col, C_FIN, DORSAL, thickness=0.16))
    parts.append(dd.membrane("Caudale", col, C_FIN, CAUDAL, thickness=0.18))
    parts.append(dd.membrane("NageoireAv", col, C_FIN, FLIPPER_AV, thickness=0.16, mirror_x=True))
    parts.append(dd.membrane("NageoireAr", col, C_FIN, FLIPPER_AR, thickness=0.14, mirror_x=True))
    parts += dd.eye_pair(body, col, (0.75, -2.45, 2.05), 0.25)
    parts.append(dd.part("Narine", "sphere", col, C_DARK, loc=dd.snap(body, (0.15, -3.75, 1.7), -0.01),
                         scale=(0.06, 0.05, 0.045), mirror_x=True, u=6, v=4))

    ob = dd.finalize(parts, NAME + "_Base", "M_" + NAME, target_length=LENGTH)
    st = dd.stats(ob)

    dd.setup_render(sc, rcol, target=(0, -0.2, 1.3), distance=11.0, azimuth=-40, height_ratio=0.45)
    out = os.path.join(PROJECT_DIR, "docs", "renders", "archetype_aquatic.png")
    os.makedirs(os.path.dirname(out), exist_ok=True)
    dd.render_to(sc, out)
    st["rendu"] = out
    return st


if __name__ == "__main__":
    print(build())
