# DINO DICE — Base d'archétype QUADRUPÈDE (corps massif, 4 pattes en colonnes, cou court/moyen).
# Version : 3 (v3 : 1re boucle de queue reculée, sinon le Skin trouait la jonction bassin/cuisse ; v2 : corps en tonneau plus massif, pattes-colonnes attachées sous le corps (fin des déchirures du Skin), ventre net)
# Re-jouable : reconstruit la scène « DD_Quadrupede » / collection « Quadrupede » à chaque exécution.
# Lancement : depuis Blender (Text Editor > Run) ou via build_all.py (enregistre blender/archetypes.blend).

import importlib
import os
import sys

from mathutils import Vector

SCRIPTS_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(os.path.dirname(SCRIPTS_DIR))
if SCRIPTS_DIR not in sys.path:
    sys.path.insert(0, SCRIPTS_DIR)
import dd_common as dd  # noqa: E402

importlib.reload(dd)

NAME = "Quadrupede"
HEIGHT = 3.4  # studs (dos + tête) : massif mais pas plus haut qu'un théropode commun

C_BODY = dd.hex_rgba("#FFA94D")
C_BELLY = dd.hex_rgba("#FFF0D9")
C_NAIL = dd.hex_rgba("#FFF8E8")
C_DARK = dd.hex_rgba("#8A4B12")

# Demi-squelette (x >= 0) : (clé, position, rayon, parent). Un sommet = une boucle d'arêtes.
NODES = [
    ("bassin", (0, 0.90, 2.00), 1.20, None),
    ("dos", (0, 0.00, 2.25), 1.42, "bassin"),
    ("poitrail", (0, -0.90, 2.10), 1.20, "dos"),
    ("cou1", (0, -1.70, 2.40), 0.75, "poitrail"),
    ("cou2", (0, -2.10, 2.80), 0.65, "cou1"),
    ("crane", (0, -2.45, 3.10), 0.92, "cou2"),
    ("machoire", (0, -3.00, 2.95), 0.78, "crane"),
    ("museau", (0, -3.45, 2.82), 0.60, "machoire"),
    ("nez", (0, -3.78, 2.76), 0.44, "museau"),
    # Queue (courte et épaisse) : un segment = une boucle
    ("queue1", (0, 2.10, 1.85), 0.75, "bassin"),
    ("queue2", (0, 2.60, 1.65), 0.55, "queue1"),
    ("queue3", (0, 3.15, 1.45), 0.38, "queue2"),
    ("queue4", (0, 3.60, 1.30), 0.24, "queue3"),
    ("queue5", (0, 3.95, 1.22), 0.13, "queue4"),
    # Patte arrière droite (colonne) : hanche -> genou -> cheville -> pied
    ("hanche", (0.62, 0.95, 1.25), 0.62, "bassin"),
    ("genou", (0.82, 0.90, 0.75), 0.58, "hanche"),
    ("cheville", (0.82, 0.95, 0.38), 0.50, "genou"),
    ("pied_ar", (0.82, 0.88, 0.24), 0.52, "cheville"),
    # Patte avant droite (colonne) : épaule -> coude -> poignet -> pied
    ("epaule", (0.62, -0.95, 1.25), 0.60, "poitrail"),
    ("coude", (0.82, -1.00, 0.75), 0.55, "epaule"),
    ("poignet", (0.82, -1.02, 0.38), 0.48, "coude"),
    ("pied_av", (0.82, -1.08, 0.24), 0.50, "poignet"),
]


def build():
    sc, col, rcol = dd.setup_scene("DD_" + NAME, NAME)

    body = dd.skin_body(NAME + "_Corps", NODES, col, branch_smoothing=0.7, subdiv=1, smooth_iters=2)
    dd.fill_color(body.data, C_BODY)
    # Ventre, gorge et dessous de la mâchoire plus clairs
    dd.paint_faces(body.data,
                   lambda c, n: n.z < -0.3 and c.z > 1.3 and abs(c.x) < 0.6,
                   C_BELLY)

    parts = [body]
    parts += dd.eye_pair(body, col, (0.8, -2.85, 3.38), 0.27)
    parts.append(dd.part("Narine", "sphere", col, C_DARK, loc=dd.snap(body, (0.17, -4.2, 3.0), -0.01),
                         scale=(0.065, 0.05, 0.05), mirror_x=True, u=6, v=4))
    # Ongles ronds (3 par pied, à l'avant de chaque pied)
    for foot, (fx, fy) in (("Av", (0.82, -1.08)), ("Ar", (0.86, 0.85))):
        for i, dx in enumerate((-0.2, 0.0, 0.2)):
            p = dd.snap(body, (fx + dx, fy - 0.9, 0.14), -0.03)
            parts.append(dd.part("Ongle%s%d" % (foot, i), "sphere", col, C_NAIL, loc=p,
                                 scale=(0.1, 0.07, 0.09), mirror_x=True, u=6, v=4))

    ob = dd.finalize(parts, NAME + "_Base", "M_" + NAME, target_height=HEIGHT)
    st = dd.stats(ob)

    dd.setup_render(sc, rcol, target=(0, -0.3, HEIGHT * 0.45), distance=11.5, azimuth=-40, height_ratio=0.3)
    out = os.path.join(PROJECT_DIR, "docs", "renders", "archetype_quadruped.png")
    os.makedirs(os.path.dirname(out), exist_ok=True)
    dd.render_to(sc, out)
    st["rendu"] = out
    return st


if __name__ == "__main__":
    print(build())
