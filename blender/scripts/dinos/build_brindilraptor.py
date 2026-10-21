# DINO DICE — Brindilraptor (commun, théropode, taille 0,85) : modèle + rig + 7 animations + rendus.
# Version : 3 (style chibi + plaques)
# Référence : Sinosauropteryx (raptor minuscule, très longue queue rayée clair/foncé, bras courts, pattes fines).
# Couche thématique : 3 brindilles en éventail sur la nuque + 2 au bout de la queue (chacune avec 1 feuille),
# fagot de 4 brindilles ficelé sous le bras gauche (sa collection), 7 bandes sur la queue.
# Personnalité : maniaque (compte en hochant la tête 3 fois, regarde à gauche puis à droite).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_brindilraptor.py [-- model]
import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401

import theropod_plaques as TP  # noqa: E402

# STYLE n°2 « plaques » + appui des pieds (local à ce build, helpers partagés intacts)
TP.apply(H.dd, R, lambda f: setattr(H, "split_sharp", f), H.split_sharp)

ID, NAME = "brindilraptor", "Brindilraptor"
HEIGHT = 3.4  # 4,0 x 0,85
COLORS = {"main": "#B5835A", "belly": "#F3D9A4", "accent": "#6D9B3A", "glow": "#9CCC65", "back": "#7A5236"}
BG = (0.20, 0.24, 0.30)
NT = 5
# Style chibi (MISE À JOUR STYLE) : tête énorme, corps court et rond, pattes courtes, très longue queue rayée.
NODES = [
    ("hanche", (0, 0.15, 1.40), 0.58, None),
    ("ventre", (0, -0.24, 1.46), 0.66, "hanche"),
    ("epaules", (0, -0.56, 1.72), 0.50, "ventre"),
    ("cou", (0, -0.72, 2.08), 0.42, "epaules"),
    ("cou2", (0, -0.80, 2.42), 0.48, "cou"),
    ("crane", (0, -1.02, 2.96), 1.06, "cou2"),
    ("machoire", (0, -1.66, 2.72), 0.74, "crane"),
    ("museau", (0, -2.20, 2.62), 0.56, "machoire"),
    ("nez", (0, -2.66, 2.64), 0.44, "museau"),
    # Très longue queue fine, relevée (≈ 1,5 x le corps) : 8 anneaux = 7 bandes alternées
    ("queue1", (0, 0.62, 1.40), 0.46, "hanche"),
    ("queue2", (0, 0.98, 1.43), 0.39, "queue1"),
    ("queue3", (0, 1.34, 1.48), 0.33, "queue2"),
    ("queue4", (0, 1.70, 1.55), 0.28, "queue3"),
    ("queue5", (0, 2.06, 1.63), 0.23, "queue4"),
    ("queue6", (0, 2.42, 1.74), 0.19, "queue5"),
    ("queue7", (0, 2.76, 1.86), 0.15, "queue6"),
    ("queue8", (0, 3.08, 2.00), 0.11, "queue7"),
    ("bassin", (0.42, 0.10, 1.20), 0.48, None),
    ("cuisse", (0.52, -0.04, 0.92), 0.46, "bassin"),
    ("genou", (0.55, -0.22, 0.58), 0.26, "cuisse"),
    ("cheville", (0.54, 0.04, 0.30), 0.19, "genou"),
    ("pied", (0.54, -0.08, 0.15), 0.20, "cheville"),
    ("orteils", (0.54, -0.36, 0.12), 0.15, "pied"),
    # Bras courts
    ("epaule", (0.46, -0.72, 1.70), 0.17, None),
    ("coude", (0.66, -0.88, 1.48), 0.14, "epaule"),
    ("main", (0.66, -1.10, 1.48), 0.13, "coude"),
]
MOUTH_Y0 = -1.46
MOUTH_P = (0, -1.62, 2.50)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.05
BELLY_COS = 0.42
BELLY_MAX_X = 0.45
BACK_PAINT = (0.45, 0.5, 1.6, -2.0)
TAIL_Y0 = 0.62  # 7 bandes alternées sur la queue (une par segment d'anneaux)
TAIL_SEG = [0.80, 1.16, 1.52, 1.88, 2.24, 2.59, 2.92]
NAPE = Vector((0, -0.62, 3.40))
EXTRA_BONES = [("Crest", NAPE, NAPE + Vector((0, 0.35, 0.45)), "Head")]
TWIG_R = 0.075


def paint(B, me):
    attr = me.color_attributes[H.dd.COLOR_ATTR]
    for poly in me.polygons:
        c = poly.center
        if c.y < TAIL_Y0 or abs(c.x) > 0.6:
            continue
        k = min(range(len(TAIL_SEG)), key=lambda i: abs(TAIL_SEG[i] - c.y))
        slot = BACK if k % 2 == 0 else MAIN
        if slot == MAIN and poly.normal.z < -0.3:
            slot = BELLY
        for li in poly.loop_indices:
            attr.data[li].color_srgb = B.C[slot]


def twig(B, gi, base, d, L, leaf_side=1.0):
    """Brindille (cylindre 6 côtés) + petit nœud + 1 feuille en losange (accent) près du bout."""
    d = Vector(d).normalized()
    B.cone_to("Brindille", BACK, gi, base, d, L, TWIG_R, segments=6, r2=TWIG_R * 0.7)
    # petit rameau latéral
    side = d.cross(Vector((1, 0, 0)))
    if side.length < 0.1:
        side = d.cross(Vector((0, 1, 0)))
    side.normalize()
    mid = base + d * L * 0.55
    B.cone_to("Rameau", BACK, gi, mid, (d + side * leaf_side * 0.9).normalized(), L * 0.25, TWIG_R * 0.6,
              segments=4, r2=0.008)
    tip = base + d * L * 0.98
    leaf = [(0, 0), (0.11, 0.13), (0, 0.3), (-0.11, 0.13)]
    M = H.frame_from(tip, Vector((1, 0, 0)), d + side * leaf_side * 0.6)
    B.flat("Feuille", ACCENT, gi, leaf, M, 0.02)


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.48, -1.74, 3.28), 0.40, look=(0.2, -1.0, 0.1), iris=ACCENT, iris_r=0.62, pupil_r=0.30,
           brow=(12, 0.84, 0.5), brow_slot=BACK)
    B.mouth_parts(n_up=5, n_lo=4, size=0.13)
    ob = B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.14, -2.95, 2.94), -0.01), scale=(0.06, 0.045, 0.04), u=6, v=4)
    H.mirror_inplace(ob)
    # éventail de 3 brindilles sur la nuque
    gc = B.grp("rigid", "Crest")
    for k, a in enumerate((-40, 0, 40)):
        loc, nor = B.surf(NAPE + Vector((math.sin(math.radians(a)) * 0.1, 0.05, 0)))
        base = loc - nor * 0.04
        d = Vector((math.sin(math.radians(a)) * 1.2, 0.3, 1.0))
        twig(B, gc, base, d, (0.62, 0.8, 0.62)[k], 1 if a >= 0 else -1)
    # 2 brindilles au bout de la queue
    gt = B.grp("rigid", "Tail5")
    tp = B.pos["queue8"]
    for k, a in enumerate((-25, 25)):
        d = Vector((math.sin(math.radians(a)), 0.6, 0.75))
        twig(B, gt, tp + Vector((0, -0.02, 0.03)), d, 0.5, 1 if a > 0 else -1)
    # fagot de 4 brindilles ficelé, coincé sous le bras gauche (+X)
    gf = B.grp("rigid", "UpperArm.L")
    e, c = B.pos["epaule"], B.pos["coude"]
    ctr = Vector((0.90, -0.80, 1.30))
    d = Vector((0.12, -1.0, -0.15)).normalized()
    for k, off in enumerate(((0.045, 0, 0.045), (-0.045, 0, 0.045), (0.045, 0, -0.045), (-0.045, 0, -0.045))):
        o = Vector(off)
        B.cone_to("Fagot%d" % k, BACK, gf, ctr + o - d * 0.4, d + o * 1.5, 0.8, TWIG_R, segments=6, r2=TWIG_R * 0.8)
    B.P("Ficelle", "cone", ACCENT, gf, M=H.frame_from(ctr, d), segments=8, r1=0.12, r2=0.12, depth=0.09)
    B.hands(n=3, length=0.24, r=0.09, claw=WHITE, spread=30, claw_len=0.17, down=0.5)
    B.feet(n=3, length=0.32, r=0.12, claw=WHITE, spread=32, back=0.24, claw_len=0.17)


class Anims(H.Anims):
    def extra(self, clip, t):
        amp = {"Idle": 3, "Walk": 5, "Run": 8, "Attack": 7, "Roar": 9, "Celebrate": 10, "Death": 0}[clip]
        self.r("Crest", (R.Y, amp * R.S2(t, 3)), (R.X, 0.5 * amp * R.S2(t, 3, 0.25)))

    # Maniaque : compte (3 hochements de tête secs), puis regarde à gauche et à droite, méfiant
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        cnt = R.keys(t, [(0, 0), (0.08, 0), (0.12, 1), (0.16, 0), (0.22, 1), (0.26, 0), (0.32, 1), (0.36, 0), (1, 0)])
        look = R.keys(t, [(0, 0), (0.45, 0), (0.52, 1), (0.64, 1), (0.72, -1), (0.84, -1), (0.92, 0), (1, 0)])
        self.hips(z=-0.02 + 0.02 * br, rz=2 * R.S2(t, 1))
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -1.5 * br))
        H.rig.rot(P["Neck1"], (R.X, 2 * br + 4 * cnt), (R.Z, 10 * look))
        H.rig.rot(P["Neck2"], (R.Z, 12 * look))
        H.rig.rot(P["Head"], (R.X, 16 * cnt), (R.Z, 20 * look), (R.Y, -6 * look))
        H.rig.rot(P["Jaw"], (R.X, 14 + 4 * cnt + 2 * max(0.0, br)))  # petit sourire satisfait
        self.tail(lambda i: ((R.Z, 6 * R.S2(t, 1, -0.08 * i) + 6 * look), (R.X, 2 * R.S2(t, 2, -0.1 * i))))
        # bras gauche serré sur le fagot ; bras droit levé, griffes prêtes, qui « pointe » à chaque compte
        H.rig.rot(P["UpperArm.L"], (R.X, -10 - 3 * br))
        H.rig.rot(P["LowerArm.L"], (R.X, -20))
        H.rig.rot(P["UpperArm.R"], (R.X, -55 - 15 * cnt - 4 * br), (R.Y, 20))
        H.rig.rot(P["LowerArm.R"], (R.X, -20 + 15 * cnt))
        self.r("Crest", (R.X, -8 * cnt), (R.Y, 4 * R.S2(t, 3)))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
