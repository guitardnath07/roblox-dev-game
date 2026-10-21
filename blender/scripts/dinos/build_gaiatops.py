# DINO DICE — Gaïatops (primordial, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi + « plaques » : grosse tête, gros yeux, griffes crème, facettes nettes, plots)
# Référence réelle : Torosaurus latus (cératopsien au crâne immense : collerette géante et plate percée de
# 2 grandes fenêtres, 2 longues cornes au-dessus des yeux, petite corne nasale, dos large et plat).
# Couche thématique : collerette bordée de 9 racines, fenêtres remplies de mousse, cornes -> bois de cerf
# (2 branches + 3 andouillers), petite forêt sur le dos (3 sapins, 5 champignons roses lumineux, lucioles)
# posée sur une plaque de mousse à plots, nid avec un oiseau (os « Oiseau » animé : il se pose dans l'Idle).
# Os en plus : Arbre1 (grand sapin), Arbre2 (2 petits sapins), Oiseau -> 30 os.
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_gaiatops.py [-- model]

import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
import build_volcanokeros as V  # noqa: E402  (kit chibi : griffes, dents, pointes, plaques, poses)
from quadruped_helpers import K, R, BELLY, ACCENT, GLOW, BACK, WHITE, DARK  # noqa: E402

ID, NAME = "gaiatops", "Gaiatops"
HEIGHT = 3.4 * 2.2
COLORS = {"main": "#8B5A3C", "belly": "#E6CBA8", "accent": "#4CAF50", "glow": "#FF80AB", "back": "#5A3824"}

NODES = [
    ("bassin", (0, 0.55, 1.62), 1.1, None),
    ("dos", (0, 0.0, 1.75), 1.22, "bassin"),
    ("poitrail", (0, -0.5, 1.7), 1.1, "dos"),
    ("cou1", (0, -0.92, 1.82), 0.88, "poitrail"),
    ("cou2", (0, -1.22, 2.0), 0.95, "cou1"),
    ("crane", (0, -1.72, 2.3), 1.3, "cou2"),
    ("machoire", (0, -2.3, 2.0), 1.08, "crane"),
    ("museau", (0, -2.88, 1.8), 0.8, "machoire"),
    ("nez", (0, -3.3, 1.72), 0.52, "museau"),
    ("queue1", (0, 1.22, 1.42), 0.66, "bassin"),
    ("queue2", (0, 1.72, 1.3), 0.43, "queue1"),
    ("queue3", (0, 2.08, 1.3), 0.26, "queue2"),
    ("queue4", (0, 2.3, 1.42), 0.13, "queue3"),
    ("hanche", (0.82, 0.55, 1.1), 0.58, None),
    ("genou", (0.84, 0.35, 0.72), 0.54, "hanche"),
    ("cheville", (0.84, 0.52, 0.4), 0.52, "genou"),
    ("pied_ar", (0.84, 0.46, 0.3), 0.52, "cheville"),
    ("orteil_ar", (0.84, 0.2, 0.27), 0.42, "pied_ar"),
    ("epaule", (0.84, -0.48, 1.1), 0.58, None),
    ("coude", (0.86, -0.33, 0.72), 0.54, "epaule"),
    ("poignet", (0.86, -0.5, 0.4), 0.52, "coude"),
    ("pied_av", (0.86, -0.56, 0.3), 0.52, "poignet"),
    ("orteil_av", (0.86, -0.84, 0.27), 0.42, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.12, WHITE
BELLY_COS, BELLY_MAXX = 0.5, 0.85
BACK_NZ, BACK_ZMIN, BACK_MAXX = 2.0, 9.0, 0.0  # dos : rayures (paint) + plaque de mousse
SIGMA = 0.12
MOUTH = {"p": (0, -2.95, 1.63), "n": (0, -0.1, 1), "y0": -1.95, "gap": 0.07, "zmin": 0.85,
         "smile": 0.22, "smile_y": -2.75, "shell": 0.5, "shell_depth": 0.08}
# paupières mi-closes : air serein ; iris vert
EYE = {"target": (0.72, -1.95, 2.9), "size": 0.54, "look": (-0.1, -1.5, 0.05), "iris": 0.64, "iris_slot": ACCENT,
       "lid": {"close": -60, "tilt": -6, "bone": "Head", "slot": BACK}}
NOSTRILS = [((0.2, -3.8, 2.0), (0.08, 0.06, 0.06))]
TEETH = V.grin_teeth(-3.15, -2.3, 5, 0.22, 0.085, inset_front=0.12)
TONGUE_AT = (-2.6, 0.45, 0.3)
GAIT = {"walk_step": 0.42, "walk_lift": 0.2, "run_step": 0.6, "run_lift": 0.26, "hop": 0.32, "rear": 0.75}
ATTACK = "charge"
ROAR_JAW = 30
SPINE = ["Hips", "Spine1", "Spine2", "Spine3"]

# repère de la forêt sur le dos (calculé dans accessories, repris par EXTRA_BONES)
FOREST = {}


def paint(me, setp):
    V.stripes(me, setp, (-0.3, 0.95), 0.12, 1.7, BACK, slant=0.2)


def stick(name, slot, bone, a, b, r0, r1, segs=5):
    """Cylindre/cône (segs pans) du point a au point b."""
    a, b = Vector(a), Vector(b)
    d = b - a
    M = K.frame_from(a, d, up=(0, 0, 1) if abs(d.normalized().z) < 0.95 else (0, -1, 0))
    return K.xform(Q.P(name, "cone", slot, bone, loc=(0, 0, d.length / 2), segments=segs, r1=r0, r2=r1,
                       depth=d.length), M)


def fir(parts, M, h, bone):
    """Sapin low-poly : tronc + 3 cônes empilés (6 pans), base au repère M (Z = haut)."""
    parts.append(K.xform(Q.P("Tronc", "cone", BACK, bone, loc=(0, 0, h * 0.12), segments=5, r1=h * 0.09,
                             r2=h * 0.07, depth=h * 0.24), M))
    for k, (z, rr, hh) in enumerate(((0.2, 0.38, 0.42), (0.45, 0.3, 0.36), (0.66, 0.2, 0.34))):
        parts.append(K.xform(Q.P("Sapin", "cone", ACCENT, bone, loc=(0, 0, h * (z + hh / 2)), segments=6,
                                 r1=h * rr, r2=0.0, depth=h * hh), M @ Matrix.Rotation(0.5 * k, 4, "Z")))


def mushroom(parts, M, x, y, cap, bone):
    h = cap * 1.1
    parts.append(K.xform(Q.P("Pied", "cone", BELLY, bone, loc=(x, y, h / 2), segments=5, r1=cap * 0.35,
                             r2=cap * 0.3, depth=h), M))
    parts.append(K.xform(Q.P("Chapeau", "cone", GLOW, bone, loc=(x, y, h + cap * 0.22), segments=7, r1=cap,
                             r2=cap * 0.3, depth=cap * 0.45), M))


def accessories(body, parts):
    # --- collerette géante (≈ hauteur du corps) derrière le crâne
    cr = Q.node("crane")
    nrm = Vector((0, -0.86, 0.5)).normalized()
    Mf = K.frame_from(cr + Vector((0, 0.8, 0.35)), nrm, up=(0, 0.2, 1))
    W, H = 1.75, 1.4
    rim = [(W * math.cos(math.pi * i / 10), 0.05 + H * math.sin(math.pi * i / 10)) for i in range(11)]
    pts = rim + [(-W * 0.62, -0.45), (W * 0.62, -0.45)][::-1]
    parts.append(Q.flat("Collerette", BELLY, "Head", pts, Mf, 0.22))
    # 2 fenêtres ovales remplies de mousse (des 2 côtés de la collerette)
    for s in (1, -1):
        for side in (1, -1):
            ov = [(s * 0.72 + 0.38 * math.cos(2 * math.pi * i / 8), 0.7 + 0.45 * math.sin(2 * math.pi * i / 8))
                  for i in range(8)]
            if side < 0:
                ov = ov[::-1]
            M = Mf @ Matrix.Translation((0, 0, side * 0.125))
            parts.append(Q.poly("Mousse", ACCENT, "Head", ov, M))
    # bord : 9 racines-boudins (cylindres 6 pans d'un point du bord au suivant, légèrement débordants)
    edge = [(W * 1.02 * math.cos(math.pi * i / 9), 0.05 + H * 1.02 * math.sin(math.pi * i / 9)) for i in range(10)]
    for i in range(9):
        a = Mf @ Vector((edge[i][0], edge[i][1], 0.0))
        b = Mf @ Vector((edge[i + 1][0], edge[i + 1][1], 0.0))
        parts.append(stick("Racine", BACK, "Head", a.lerp(b, -0.08), b.lerp(a, -0.08), 0.15, 0.12, segs=6))
    # --- bois de cerf (au-dessus des yeux) : merrain + 2 branches + 3 andouillers
    for s in (1, -1):
        b0 = Q.dd.snap(body, (s * 0.6, -1.95, 3.6), -0.08)
        b1 = b0 + Vector((s * 0.45, -0.3, 0.95))
        b2 = b1 + Vector((s * 0.55, 0.25, 0.7))
        b3 = b1 + Vector((-s * 0.05, -0.55, 0.65))
        parts.append(stick("Bois", BELLY, "Head", b0, b1, 0.17, 0.13))
        parts.append(stick("Bois", BELLY, "Head", b1, b2, 0.11, 0.05))
        parts.append(stick("Bois", BELLY, "Head", b1, b3, 0.1, 0.04))
        for p0, dv in ((b0.lerp(b1, 0.55), (s * 0.4, -0.35, 0.2)), (b1.lerp(b2, 0.5), (s * 0.1, 0.15, 0.45)),
                       (b1.lerp(b3, 0.5), (s * 0.35, -0.2, 0.25))):
            parts.append(stick("Andouiller", BELLY, "Head", p0, p0 + Vector(dv) * 0.7, 0.06, 0.0, segs=4))
    # petite corne nasale + bec
    b = Q.dd.snap(body, (0, -3.0, 2.65), -0.04)
    parts.append(K.xform(Q.P("CorneNez", "cone", BELLY, "Head", loc=(0, 0, 0.17), segments=5, r1=0.14, r2=0.0,
                             depth=0.34), K.frame_from(b, Vector((0, -0.3, 1)), up=(0, -1, 0))))
    tip = Q.dd.snap(body, (0, -4.25, 1.7), -0.12)
    parts.append(K.xform(Q.P("Bec", "cone", BACK, "Head", loc=(0, 0, 0.12), scale=(1, 0.75, 1), segments=6,
                             r1=0.34, r2=0.0, depth=0.48), K.frame_from(tip, Vector((0, -1, -0.55)), up=(0, 0, 1))))
    # --- plaque de mousse (hexagone à plots) = sol de la forêt sur le dos large et plat
    Mp = V.plate(parts, body, 0.0, 0.45, 1.05, ACCENT, SPINE, shape=6, thick=0.14, lean=0.0,
                 stud=([(-0.55, 0.45), (0.55, 0.45), (-0.62, -0.1)], 0.08, 0.08, ACCENT))
    Mt = Mp @ Matrix.Translation((0, 0, 0.14))
    FOREST["M"] = Mt
    fir(parts, Mt @ Matrix.Translation((0.25, -0.15, 0)), 1.7, "Arbre1")
    fir(parts, Mt @ Matrix.Translation((-0.45, 0.3, 0)), 1.4, "Arbre2")
    fir(parts, Mt @ Matrix.Translation((0.2, 0.62, 0)), 1.15, "Arbre2")
    for x, y, c in ((-0.62, -0.38, 0.24), (0.68, 0.22, 0.2), (-0.12, 0.32, 0.15), (0.62, -0.6, 0.17)):
        mushroom(parts, Mt, x, y, c, SPINE)
    mushroom(parts, Mt, -0.8, 0.62, 0.18, ["Hips", "Spine1"])
    # lucioles autour des sapins
    for x, y, z in ((0.8, -0.25, 1.2), (-0.85, 0.0, 1.5), (0.1, 1.0, 1.0), (-0.3, -0.8, 1.7)):
        parts.append(K.xform(Q.P("Luciole", "sphere", GLOW, "Arbre1", loc=(x, y, z), scale=(0.07, 0.07, 0.07),
                                 u=4, v=2), Mt))
    # --- nid + oiseau à l'avant de la plaque (oiseau sur son os)
    Mn = Mt @ Matrix.Translation((-0.35, -0.62, 0))
    parts.append(K.xform(Q.P("Nid", "cone", BACK, SPINE, loc=(0, 0, 0.08), segments=7, r1=0.26, r2=0.3,
                             depth=0.16), Mn))
    parts.append(K.xform(Q.P("Oiseau", "sphere", BELLY, "Oiseau", loc=(0, 0.02, 0.24), scale=(0.13, 0.16, 0.12),
                             u=6, v=4), Mn))
    parts.append(K.xform(Q.P("TeteOiseau", "sphere", BELLY, "Oiseau", loc=(0, -0.12, 0.36),
                             scale=(0.09, 0.09, 0.09), u=6, v=4), Mn))
    parts.append(K.xform(Q.P("BecOiseau", "cone", GLOW, "Oiseau", loc=(0, -0.24, 0.35), rot=(90, 0, 0),
                             segments=4, r1=0.035, r2=0.0, depth=0.08), Mn))
    parts.append(K.xform(Q.P("AileOiseau", "cube", BACK, "Oiseau", loc=(0.12, 0.04, 0.25),
                             scale=(0.04, 0.2, 0.1), mirror_x=True), Mn))
    parts.append(K.xform(Q.P("OeilOiseau", "sphere", DARK, "Oiseau", loc=(0.06, -0.17, 0.38),
                             scale=(0.02, 0.02, 0.02), mirror_x=True, u=4, v=2), Mn))
    # --- pointes triangulaires (queue, coudes)
    V.back_spikes(body, parts, (1.25, 1.55, 1.85), 0.26, 0.11, BACK)
    V.elbow_spikes(parts, 0.26, 0.11, BACK)


def EXTRA_BONES():
    Mt = FOREST["M"]
    up = (Mt.to_3x3() @ Vector((0, 0, 1))).normalized()
    a1 = Mt @ Vector((0.25, -0.15, 0))
    a2 = Mt @ Vector((-0.15, 0.45, 0))
    nb = Mt @ Vector((-0.35, -0.62, 0.12))
    return [("Arbre1", a1, a1 + up * 1.0, "Spine1"), ("Arbre2", a2, a2 + up * 0.9, "Spine1"),
            ("Oiseau", nb, nb + Vector((0, -0.3, 0)), "Spine2")]


class Anims(V.ChibiAnims):
    def forest(self, sway, lag=0.0):
        self.r("Arbre1", (R.Y, sway), (R.X, 0.5 * sway))
        self.r("Arbre2", (R.Y, -0.8 * sway + lag), (R.X, -0.4 * sway))

    def bird(self, x=0.0, y=0.0, z=0.0, ry=0.0):
        u = self.u
        Q.rig.loc(self.P["Oiseau"], (x * u, y * u, z * u))
        self.r("Oiseau", (R.Z, ry))

    # Sereine : respiration lente et ample, tête qui oscille doucement, les sapins se balancent,
    # un oiseau arrive en voletant et se pose dans le nid
    def idle(self, t):
        self.base()
        br = R.S2(t, 1)
        c = self.crouch(t, 0.4)
        self.hips(z=c["hz"] + 0.025 * br, rx=c["hrx"], rz=1.5 * R.S2(t, 1, 0.2))
        self.spine(rx=-2 * br)
        self.neck(rx=c["nrx"] + 2 * br, rz=4 * R.S2(t, 1, 0.1))
        self.r("Head", (R.X, c["headx"] + 1.5 * br), (R.Z, 5 * R.S2(t, 1, 0.1)), (R.Y, 3 * R.S2(t, 1)))
        self.r("Jaw", (R.X, 10 + 2 * br))
        self.tail(lambda i: ((R.Z, 6 * R.S2(t, 1, -0.08 * i)), (R.X, c["tailx"])))
        self.forest(5 * R.S2(t, 2), 2 * R.S2(t, 2, 0.3))
        land = R.keys(t, [(0, 0), (0.05, 0), (0.35, 1), (1, 1)])  # 0 = en vol, 1 = posé
        flap = (1 - land) * R.S2(t, 12)
        hop = math.exp(-((t - 0.6) / 0.03) ** 2) + math.exp(-((t - 0.66) / 0.03) ** 2)
        self.bird(x=1.4 * (1 - land), y=-0.8 * (1 - land), z=1.6 * (1 - land) + 0.08 * flap + 0.1 * hop,
                  ry=40 * (1 - land) + 25 * hop)

    def extra(self, clip, t):
        if clip in ("Walk", "Run"):
            k = 1.0 if clip == "Walk" else 1.6
            self.forest(4 * k * R.S2(t, 1, -0.15), 2 * k * R.S2(t, 2, -0.2))
            self.bird(z=0.05 * k * abs(R.S2(t, 2)))
        elif clip in ("Roar", "Attack", "Celebrate"):
            e = R.keys(t, [(0, 0), (0.3, 1), (0.8, 1), (1, 0)])
            self.forest(8 * e * R.S2(t, 4))
            self.bird(z=0.5 * e + 0.1 * e * R.S2(t, 6), ry=20 * e * R.S2(t, 3))
        elif clip == "Death":
            e = R.keys(t, [(0, 0), (0.3, 1), (1, 1)])
            self.forest(-6 * e)
            self.bird(x=0.6 * e, z=1.5 * e, ry=90 * e)

    def attack(self, t):
        super().attack(t)  # charge par défaut du helper (bois en avant) ; on limite la plongée de la tête
        a = R.keys(t, [(0, 0), (0.3, 1), (0.4, 0), (1, 0)])
        s = R.keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.58, 1), (0.88, 0), (1, 0)])
        tos = R.keys(t, [(0, 0), (0.4, 0), (0.5, 1), (0.66, 0.2), (0.9, 0), (1, 0)])
        self.hips(y=0.15 * a - 0.2 * s, z=-0.06 * a - 0.05 * s, rx=3 * a - 6 * tos)
        self.neck(rx=1 * a - 9 * tos)
        self.r("Head", (R.X, 1 * a - 16 * tos), (R.Z, 6 * tos))
        self.r("Jaw", (R.X, 16 * tos + 3 * a))
        self.extra("Attack", t)


S_ = sys.modules[__name__]
if __name__ == "__main__":
    V.lego_patch()
    Q.main(S_)
