# DINO DICE — Galetosaure (commun, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 1
# Référence réelle : Minmi paravertebra (petit ankylosaure bas et large, rangées de petites plaques sur les flancs,
# tête triangulaire basse, queue courte sans massue) ; pattes raccourcies pour l'effet « galet ».
# Couche thématique : 7 galets lisses en 2 rangées décalées sur le dos, touffe de mousse sur le plus gros,
# paupières lourdes (os Lid.L / Lid.R) pour l'Idle somnolent (s'endort, ronfle, sursaute).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_galetosaure.py [-- model]

import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
from quadruped_helpers import K, R, BELLY, ACCENT, BACK  # noqa: E402

ID, NAME = "galetosaure", "Galetosaure"
HEIGHT = 3.4 * 0.9
COLORS = {"main": "#9AA5B1", "belly": "#E6E1D3", "accent": "#7BC67E", "glow": "#FFB74D", "back": "#6B7785"}

NODES = [
    ("bassin", (0, 0.6, 1.65), 1.10, None),
    ("dos", (0, 0.0, 1.80), 1.25, "bassin"),
    ("poitrail", (0, -0.6, 1.70), 1.08, "dos"),
    ("cou1", (0, -1.1, 1.85), 0.80, "poitrail"),
    ("cou2", (0, -1.4, 2.00), 0.80, "cou1"),
    ("crane", (0, -1.8, 2.20), 1.05, "cou2"),
    ("machoire", (0, -2.3, 2.00), 0.86, "crane"),
    ("museau", (0, -2.7, 1.90), 0.66, "machoire"),
    ("nez", (0, -3.0, 1.86), 0.48, "museau"),
    ("queue1", (0, 1.45, 1.45), 0.68, "bassin"),
    ("queue2", (0, 1.95, 1.20), 0.42, "queue1"),
    ("queue3", (0, 2.30, 1.05), 0.24, "queue2"),
    ("queue4", (0, 2.52, 1.00), 0.12, "queue3"),
    ("hanche", (0.60, 0.65, 1.25), 0.45, None),
    ("genou", (0.75, 0.55, 0.70), 0.44, "hanche"),
    ("cheville", (0.78, 0.68, 0.40), 0.38, "genou"),
    ("pied_ar", (0.78, 0.60, 0.30), 0.37, "cheville"),
    ("orteil_ar", (0.78, 0.36, 0.26), 0.29, "pied_ar"),
    ("epaule", (0.60, -0.60, 1.25), 0.44, None),
    ("coude", (0.75, -0.50, 0.70), 0.42, "epaule"),
    ("poignet", (0.78, -0.66, 0.40), 0.37, "coude"),
    ("pied_av", (0.78, -0.74, 0.30), 0.36, "poignet"),
    ("orteil_av", (0.78, -0.98, 0.26), 0.28, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.11, BELLY
BELLY_COS, BELLY_MAXX = 0.55, 0.75
BACK_NZ, BACK_ZMIN, BACK_MAXX = 0.55, 1.6, 1.3
SIGMA = 0.12
MOUTH = {"p": (0, -2.75, 1.74), "n": (0, -0.12, 1), "y0": -2.15, "gap": 0.025, "zmin": 1.2,
         "smile": 0.12, "smile_y": -2.65, "shell": 0.4}
EYE = {"target": (0.55, -2.2, 2.78), "size": 0.42, "look": (-0.15, -1.7, 0.05),
       "lid": {"close": -50, "bone": "Lid.S", "slot": BACK}}
NOSTRILS = [((0.15, -3.4, 2.0), (0.06, 0.05, 0.045))]
TEETH = [(-2.62, True, 0.12, 0.055, 0.12), (-2.4, True, 0.09, 0.045, 0.16),
         (-2.68, False, 0.09, 0.045, 0.18), (-2.45, False, 0.08, 0.04, 0.2)]
TONGUE_AT = (-2.5, 0.34, 0.22)
GAIT = {"walk_step": 0.55, "walk_lift": 0.22, "run_step": 0.95, "run_lift": 0.3, "hop": 0.4}
ATTACK = "tail"
ROAR_JAW = 34

# 7 galets (x, y, demi-axes) en 2 rangées décalées ; le n°2 (le plus gros) porte la mousse
PEBBLES = [(0.38, -0.55, (0.36, 0.28, 0.13)), (-0.38, -0.05, (0.42, 0.32, 0.15)), (0.4, 0.45, (0.5, 0.38, 0.17)),
           (-0.4, 0.95, (0.38, 0.3, 0.14)), (0.32, 1.38, (0.3, 0.24, 0.11)), (-0.3, -0.95, (0.3, 0.24, 0.11)),
           (0.0, 0.2, (0.3, 0.26, 0.12))]


def lid_axes():
    look = S_.EYE_LOOK
    side = Vector((0, 0, 1)).cross(look).normalized()
    return side, Vector((side.x, -side.y, -side.z))  # droite : -(miroir de l'axe gauche)


def EXTRA_BONES():
    ec, look = S_.EYE_CENTER, S_.EYE_LOOK
    ecr = Vector((-ec.x, ec.y, ec.z))
    lr = Vector((-look.x, look.y, look.z))
    return [("Lid.L", ec, ec + look * 0.35, "Head"), ("Lid.R", ecr, ecr + lr * 0.35, "Head")]


def accessories(body, parts):
    spine = ["Hips", "Spine1", "Spine2", "Spine3"]
    top = None
    for i, (x, y, ax) in enumerate(PEBBLES):
        _ok, loc, nor, _ = body.closest_point_on_mesh(Vector((x * 2.2, y, 4.0)))
        M = K.frame_from(loc + nor * (ax[2] * 0.35), nor, up=(0, -1, 0))
        parts.append(K.xform(Q.P("Galet", "sphere", BELLY, spine, scale=ax, u=12, v=7), M))
        if i == 2:
            top = (loc + nor * ax[2] * 1.2, nor, M)
    loc, nor, M = top
    for dx, dy, r in ((0.0, 0.0, 0.16), (0.14, 0.1, 0.12), (-0.12, 0.08, 0.11)):
        p = M @ Vector((dx, dy, 0.02))
        parts.append(Q.P("Mousse", "sphere", ACCENT, spine, loc=p, scale=(r, r, r * 0.8), u=8, v=6))
    # Petites plaques osseuses le long des flancs (2 rangées, couleur du dos)
    for row, z in enumerate((1.6, 1.3)):
        for k in range(5):
            y = -0.85 + k * 0.45 + row * 0.22
            _ok, loc, nor, _ = body.closest_point_on_mesh(Vector((2.0, y, z)))
            M = K.frame_from(loc, nor)
            ob = Q.P("Plaque", "cone", BACK, spine, segments=6, r1=0.12, r2=0.07, depth=0.08)
            K.xform(ob, M)
            K.mirror_inplace(ob)
            parts.append(ob)


class Anims(Q.QuadAnims):
    def lids(self, close):
        aL, aR = lid_axes()
        self.r("Lid.L", (aL, close))
        self.r("Lid.R", (aR, close))

    # Somnolent : paupières lourdes, s'endort tête basse, ronfle (dos qui gonfle), sursaute et se réveille
    def idle(self, t):
        self.base()
        sleep = R.keys(t, [(0, 0), (0.12, 0), (0.28, 1), (0.74, 1), (0.78, 0), (1, 0)])
        jolt = R.keys(t, [(0, 0), (0.74, 0), (0.78, 1), (0.86, 0.3), (1, 0)])
        snore = 0.5 - 0.5 * math.cos(2 * math.pi * 3 * ((t - 0.28) / 0.46)) if 0.28 < t < 0.74 else 0.0
        br = R.S2(t, 2) * (1 - sleep)
        self.hips(z=-0.06 * sleep + 0.04 * snore * sleep + 0.012 * br + 0.05 * jolt, rx=2 * sleep - 2 * jolt)
        self.spine(rx=-0.8 * br - 2.5 * snore * sleep)
        self.neck(rx=7 * sleep + 1.5 * br - 6 * jolt, rz=3 * jolt * R.S2(t, 6))
        self.r("Head", (R.X, 8 * sleep - 1.5 * snore * sleep - 8 * jolt), (R.Z, 3 * R.S2(t, 1) * (1 - sleep)),
               (R.Y, 5 * sleep))
        self.r("Jaw", (R.X, 2 + 12 * snore * sleep + 10 * jolt))
        self.lids(48 * sleep - 30 * jolt + 6 * (1 - sleep) * max(0.0, R.S2(t, 4)) ** 8)
        self.tail(lambda i: ((R.Z, 5 * R.S2(t, 1, -0.08 * i) * (1 - sleep) + 6 * jolt * R.S2(t, 5)),
                             (R.X, -3 * jolt)))

    def extra(self, clip, t):
        if clip == "Roar" or clip == "Attack":
            self.lids(-25 * R.keys(t, [(0, 0), (0.3, 1), (0.8, 1), (1, 0)]))
        elif clip == "Celebrate":
            self.lids(-15)
        elif clip == "Death":
            self.lids(55 * R.keys(t, [(0, 0), (0.5, 0), (0.7, 1), (1, 1)]))


S_ = sys.modules[__name__]
if __name__ == "__main__":
    Q.main(S_)
