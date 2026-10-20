# DINO DICE — Base d'archétype PTÉROSAURE (ailes membraneuses, bec, crête).
# Version : 4 (v4 : bord de fuite lisse au lieu de dents de scie ; v3 : membrane redressée, quasi verticale, au lieu d'être vue par la tranche ; v2 : crête plus longue rabattue vers l'arrière, membrane inclinée vers le bas pour être lisible de 3/4, bec allongé, budget triangles)
# Pose de référence : debout sur les pattes arrière, ailes déployées (silhouette lisible de loin).
# Re-jouable : reconstruit la scène « DD_Pterosaure » / collection « Pterosaure » à chaque exécution.
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

NAME = "Pterosaure"
HEIGHT = 3.8  # studs, du pied au sommet de la crête

C_BODY = dd.hex_rgba("#7E6CF2")
C_BELLY = dd.hex_rgba("#EDE7FF")
C_WING = dd.hex_rgba("#D4C6FF")
C_BEAK = dd.hex_rgba("#FFC233")
C_CREST = dd.hex_rgba("#FF5C8A")
C_CLAW = dd.hex_rgba("#FFF4D6")

# Demi-squelette (x >= 0). Les chaînes qui partent d'une grosse boucle (bras-aile, jambe)
# ont leur propre racine (None) et sont plantées dans le corps : le Skin reste propre.
NODES = [
    ("bassin", (0, 0.30, 1.30), 0.55, None),
    ("torse", (0, -0.10, 1.75), 0.66, "bassin"),
    ("poitrine", (0, -0.30, 2.20), 0.60, "torse"),
    ("cou", (0, -0.50, 2.80), 0.36, "poitrine"),
    ("crane", (0, -0.72, 3.30), 0.64, "cou"),
    ("bec1", (0, -1.25, 3.20), 0.36, "crane"),
    ("bec2", (0, -1.80, 3.08), 0.22, "bec1"),
    ("bec3", (0, -2.25, 2.98), 0.08, "bec2"),
    # Petite queue
    ("queue1", (0, 0.82, 1.08), 0.22, "bassin"),
    ("queue2", (0, 1.22, 0.95), 0.08, "queue1"),
    # Jambe droite : cuisse -> genou -> cheville -> pied
    ("cuisse", (0.30, 0.25, 1.00), 0.30, None),
    ("genou", (0.42, 0.02, 0.62), 0.22, "cuisse"),
    ("cheville", (0.42, 0.22, 0.27), 0.16, "genou"),
    ("pied", (0.42, -0.08, 0.13), 0.15, "cheville"),
    # Bras-aile droit : épaule -> coude -> poignet -> long doigt de l'aile
    ("epaule", (0.42, -0.25, 2.15), 0.26, None),
    ("coude", (1.20, -0.12, 2.50), 0.18, "epaule"),
    ("poignet", (2.00, -0.02, 2.85), 0.14, "coude"),
    ("doigt", (3.45, 0.38, 3.02), 0.07, "poignet"),
]

# Crête (chaîne à part, plantée dans l'arrière du crâne, couleur d'accent)
CREST = [
    ("crete1", (0, -0.45, 3.58), 0.32, None),
    ("crete2", (0, 0.20, 3.82), 0.22, "crete1"),
    ("crete3", (0, 0.85, 3.98), 0.08, "crete2"),
]

# Membrane de l'aile droite : bord d'attaque le long du bras, bord de fuite en courbe lisse (sans dents de scie) qui tombe vers la hanche.
# Membrane presque face caméra (et face au joueur placé derrière) : surface d'aile lisible de loin.
WING = [
    (0.45, -0.18, 2.15),
    (1.20, -0.08, 2.50),
    (2.00, 0.02, 2.85),
    (2.80, 0.18, 3.00),
    (3.50, 0.40, 3.00),
    (3.15, 0.46, 2.45),
    (2.60, 0.50, 2.05),
    (1.95, 0.53, 1.78),
    (1.30, 0.52, 1.55),
    (0.45, 0.45, 1.30),
]


def build():
    sc, col, rcol = dd.setup_scene("DD_" + NAME, NAME)

    body = dd.skin_body(NAME + "_Corps", NODES, col, branch_smoothing=0.7, subdiv=1, smooth_iters=2)
    dd.fill_color(body.data, C_BODY)
    dd.paint_faces(body.data, lambda c, n: c.y < -1.12 and c.z > 2.8, C_BEAK)
    dd.paint_faces(body.data,
                   lambda c, n: ((n.z < -0.2 or n.y < -0.6) and 1.0 < c.z < 2.6 and abs(c.x) < 0.38
                                 and c.y < 0.5),
                   C_BELLY)

    crest = dd.skin_body(NAME + "_Crete", CREST, col, branch_smoothing=0.7, subdiv=1, smooth_iters=1)
    dd.fill_color(crest.data, C_CREST)

    parts = [body, crest]
    parts.append(dd.membrane("Aile", col, C_WING, WING, thickness=0.07, mirror_x=True))
    parts += dd.eye_pair(body, col, (0.55, -0.92, 3.45), 0.21)
    # Griffes des pieds (2 par pied, cônes à 3 côtés : budget triangles)
    for i, dx in enumerate((-0.07, 0.07)):
        tip = dd.snap(body, (0.42 + dx, -0.4, 0.08), -0.03)
        parts.append(dd.part("Griffe%d" % i, "cone", col, C_CLAW, loc=tip + Vector((0, -0.05, 0)),
                             rot=(90, 0, 0), mirror_x=True, segments=3, r1=0.065, r2=0.0, depth=0.18))
    # Griffe au poignet (pouce de l'aile)
    tip = dd.snap(body, (2.0, -0.3, 2.85), -0.02)
    parts.append(dd.part("Pouce", "cone", col, C_CLAW, loc=tip + Vector((0, -0.05, 0)), rot=(90, 0, 0),
                         mirror_x=True, segments=4, r1=0.05, r2=0.0, depth=0.16))

    ob = dd.finalize(parts, NAME + "_Base", "M_" + NAME, target_height=HEIGHT)
    st = dd.stats(ob)

    dd.setup_render(sc, rcol, target=(0, -0.2, HEIGHT * 0.5), distance=12.5, azimuth=-35, height_ratio=0.55)
    out = os.path.join(PROJECT_DIR, "docs", "renders", "archetype_pterosaur.png")
    os.makedirs(os.path.dirname(out), exist_ok=True)
    dd.render_to(sc, out)
    st["rendu"] = out
    return st


if __name__ == "__main__":
    print(build())
