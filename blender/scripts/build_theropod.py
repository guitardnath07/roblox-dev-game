# DINO DICE — Base d'archétype THÉROPODE (bipède, grosse tête, petits bras, longue queue).
# Version : 6 (v6 : jambes en chaîne Skin séparée => queue+torse+cou+tête d'un seul tenant ; v5 : bande ventrale continue calculée depuis la colonne ; v4 : bras en chaîne Skin séparée = plus de faces doublées à l'épaule ; v3 : ventre net, griffes plus visibles, cadrage ; v2 : jambes plus courtes et trapues, bassin relié, tête plus grosse, pièces collées à la peau)
# Re-jouable : reconstruit la scène « DD_Theropode » / collection « Theropode » à chaque exécution.
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

NAME = "Theropode"
HEIGHT = 4.0  # studs : théropode commun ≈ 4 studs de haut

C_BODY = dd.hex_rgba("#5DBB63")
C_BELLY = dd.hex_rgba("#F2E8C9")
C_EYE = dd.hex_rgba("#FFFFFF")
C_PUPIL = dd.hex_rgba("#1B1B22")
C_CLAW = dd.hex_rgba("#FFF4D6")
C_DARK = dd.hex_rgba("#2E5E32")

# Demi-squelette (x >= 0) : (clé, position, rayon, parent). Un sommet = une boucle d'arêtes.
NODES = [
    ("hanche", (0, 0.10, 1.75), 0.85, None),
    ("ventre", (0, -0.40, 1.95), 0.85, "hanche"),
    ("epaules", (0, -0.75, 2.30), 0.64, "ventre"),
    ("cou", (0, -0.95, 2.70), 0.54, "epaules"),
    ("crane", (0, -1.10, 3.18), 0.92, "cou"),
    ("machoire", (0, -1.65, 3.12), 0.82, "crane"),
    ("museau", (0, -2.20, 3.02), 0.62, "machoire"),
    ("nez", (0, -2.58, 2.98), 0.44, "museau"),
    # Queue : un segment = une boucle
    ("queue1", (0, 0.85, 1.72), 0.64, "hanche"),
    ("queue2", (0, 1.45, 1.62), 0.50, "queue1"),
    ("queue3", (0, 2.02, 1.50), 0.38, "queue2"),
    ("queue4", (0, 2.55, 1.40), 0.27, "queue3"),
    ("queue5", (0, 3.02, 1.33), 0.18, "queue4"),
    ("queue6", (0, 3.40, 1.30), 0.10, "queue5"),
    # Jambe droite (le Mirror crée la gauche) : bassin -> cuisse -> genou -> cheville -> pied -> orteils
    # Chaîne séparée plantée dans les hanches : en branche de « hanche », le Skin coupait le tronc en
    # 3 pièces disjointes (queue / torse+tête / jambes) qui s'ouvraient à l'animation.
    ("bassin", (0.50, 0.05, 1.50), 0.44, None),
    ("cuisse", (0.60, 0.00, 1.22), 0.52, "bassin"),
    ("genou", (0.66, -0.22, 0.82), 0.40, "cuisse"),
    ("cheville", (0.63, 0.08, 0.38), 0.28, "genou"),
    ("pied", (0.63, -0.22, 0.22), 0.27, "cheville"),
    ("orteils", (0.63, -0.58, 0.20), 0.23, "pied"),
    # Petit bras : épaule -> coude -> main. Chaîne séparée (racine propre) plantée dans le torse :
    # en branche du torse, le Skin produisait des faces doublées/trous à l'épaule.
    ("epaule", (0.52, -0.98, 2.08), 0.22, None),
    ("coude", (0.74, -1.18, 1.82), 0.16, "epaule"),
    ("main", (0.68, -1.42, 1.88), 0.14, "coude"),
]


# Colonne (queue -> museau) pour la bande ventrale, et nœuds de membres exclus
SPINE = ["queue6", "queue5", "queue4", "queue3", "queue2", "queue1", "hanche", "ventre", "epaules", "cou",
         "crane", "machoire", "museau", "nez"]
LIMBS = {"bassin", "cuisse", "genou", "cheville", "pied", "orteils", "epaule", "coude", "main"}


def build():
    sc, col, rcol = dd.setup_scene("DD_" + NAME, NAME)

    body = dd.skin_body(NAME + "_Corps", NODES, col, branch_smoothing=0.7, subdiv=1, smooth_iters=2,
                        root="nez")  # racine au bout du museau : anneaux alignés, torse rond (pas « en boîte »)
    dd.fill_color(body.data, C_BODY)
    # Ventre, gorge et dessous de la mâchoire plus clairs
    # Bande ventrale continue : dessous de queue -> ventre -> gorge -> dessous de mâchoire
    dd.paint_ventral(body.data, NODES, SPINE, C_BELLY, cos_min=0.64, limbs=LIMBS, max_x=0.42)

    parts = [body]
    parts += dd.eye_pair(body, col, (0.6, -1.62, 3.48), 0.24, white=C_EYE, pupil=C_PUPIL)
    # Narines (enfoncées dans le bout du museau)
    parts.append(dd.part("Narine", "sphere", col, C_DARK, loc=dd.snap(body, (0.16, -2.95, 3.22), -0.01),
                         scale=(0.06, 0.05, 0.045), mirror_x=True, u=6, v=4))
    # Griffes des pieds (3 par pied, pointées vers l'avant, plantées au bout des orteils)
    for i, dx in enumerate((-0.15, 0.0, 0.15)):
        tip = dd.snap(body, (0.63 + dx, -0.95, 0.12), -0.04)
        parts.append(dd.part("Griffe%d" % i, "cone", col, C_CLAW, loc=tip + Vector((0, -0.06, 0)),
                             rot=(90, 0, 0), mirror_x=True, segments=5, r1=0.09, r2=0.0, depth=0.27))
    # Griffes des mains
    for i, dx in enumerate((-0.05, 0.05)):
        tip = dd.snap(body, (0.68 + dx, -1.75, 1.88), -0.02)
        parts.append(dd.part("GriffeMain%d" % i, "cone", col, C_CLAW, loc=tip + Vector((0, -0.04, -0.02)),
                             rot=(110, 0, 0), mirror_x=True, segments=4, r1=0.045, r2=0.0, depth=0.14))

    ob = dd.finalize(parts, NAME + "_Base", "M_" + NAME, target_height=HEIGHT)
    st = dd.stats(ob)

    dd.setup_render(sc, rcol, target=(0, -0.45, HEIGHT * 0.48), distance=10.5, azimuth=-40, height_ratio=0.3)
    out = os.path.join(PROJECT_DIR, "docs", "renders", "archetype_theropod.png")
    os.makedirs(os.path.dirname(out), exist_ok=True)
    dd.render_to(sc, out)
    st["rendu"] = out
    return st


if __name__ == "__main__":
    print(build())
