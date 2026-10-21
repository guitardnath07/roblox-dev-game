# DINO DICE — Titanomarbre (primordial, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi + « plaques » : grosse tête, gros yeux, griffes crème, facettes nettes, plots)
# Référence réelle : Patagotitan mayorum (titanosaure : long cou, longue queue, petite tête — grossie x2 —,
# 4 pattes en piliers, épaules un peu plus hautes que les hanches) ; cou raccourci à ~ la longueur du corps.
# Couche thématique : statue de marbre — pattes en colonnes doriques cannelées (8 cannelures, chapiteau carré),
# socle mouluré sous les 4 pieds avec plaque « ΤΙΤΑΝ », cornes en volutes ioniques, couronne de laurier dorée
# (9 feuilles) au cou, veines dorées émissives.
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_titanomarbre.py [-- model]

import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
import build_volcanokeros as V  # noqa: E402  (rubans de veines émissives)
from quadruped_helpers import K, R, MAIN, BELLY, ACCENT, GLOW, BACK, WHITE  # noqa: E402

ID, NAME = "titanomarbre", "Titanomarbre"
HEIGHT = 3.4 * 2.0
COLORS = {"main": "#F5F5F5", "belly": "#BDBDBD", "accent": "#FFD700", "glow": "#FFC400", "back": "#DCDCDC"}

PED = 0.3  # hauteur du socle (unités du squelette) : les pieds sont posés dessus
NODES = [
    ("bassin", (0, 0.55, 1.75), 1.05, None),
    ("dos", (0, 0.0, 1.92), 1.15, "bassin"),
    ("poitrail", (0, -0.5, 1.95), 1.05, "dos"),
    ("cou1", (0, -1.0, 2.5), 0.66, "poitrail"),
    ("cou2", (0, -1.3, 3.15), 0.6, "cou1"),
    ("crane", (0, -1.6, 3.75), 1.0, "cou2"),
    ("machoire", (0, -2.15, 3.55), 0.82, "crane"),
    ("museau", (0, -2.6, 3.42), 0.62, "machoire"),
    ("nez", (0, -2.95, 3.36), 0.42, "museau"),
    ("queue1", (0, 1.25, 1.6), 0.66, "bassin"),
    ("queue2", (0, 1.95, 1.4), 0.45, "queue1"),
    ("queue3", (0, 2.65, 1.38), 0.28, "queue2"),
    ("queue4", (0, 3.25, 1.55), 0.13, "queue3"),
    ("hanche", (0.78, 0.55, 1.28), 0.55, None),
    ("genou", (0.8, 0.38, 0.92), 0.5, "hanche"),
    ("cheville", (0.8, 0.55, PED + 0.3), 0.48, "genou"),
    ("pied_ar", (0.8, 0.5, PED + 0.12), 0.48, "cheville"),
    ("orteil_ar", (0.8, 0.28, PED + 0.08), 0.38, "pied_ar"),
    ("epaule", (0.78, -0.5, 1.32), 0.55, None),
    ("coude", (0.8, -0.33, 0.94), 0.5, "epaule"),
    ("poignet", (0.8, -0.5, PED + 0.3), 0.48, "coude"),
    ("pied_av", (0.8, -0.55, PED + 0.12), 0.48, "poignet"),
    ("orteil_av", (0.8, -0.78, PED + 0.08), 0.38, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = PED, PED + 0.1, 0.12, WHITE
BELLY_COS, BELLY_MAXX = 0.5, 0.85
BACK_NZ, BACK_ZMIN, BACK_MAXX = 2.0, 9.0, 0.0
SIGMA = 0.12
MOUTH = {"p": (0, -2.68, 3.27), "n": (0, -0.1, 1), "y0": -1.9, "gap": 0.06, "zmin": 2.8,
         "smile": 0.18, "smile_y": -2.5, "shell": 0.42, "shell_depth": 0.07}
EYE = {"target": (0.62, -1.85, 4.2), "size": 0.48, "look": (-0.1, -1.5, 0.05), "iris": 0.64,
       "lid": {"close": -72, "tilt": -8, "bone": "Head", "slot": BELLY}}
NOSTRILS = [((0.15, -3.3, 3.62), (0.06, 0.05, 0.05))]
TEETH = V.grin_teeth(-2.85, -2.15, 4, 0.18, 0.075, inset_front=0.1)
TONGUE_AT = (-2.35, 0.36, 0.24)
GAIT = {"walk_step": 0.4, "walk_lift": 0.2, "run_step": 0.6, "run_lift": 0.24, "hop": 0.3, "rear": 0.75}
ATTACK = "stomp"
ROAR_JAW = 30
SPINE = ["Hips", "Spine1", "Spine2", "Spine3"]

# veines dorées (y, z) sur les flancs, le cou et la queue
VEINS = [((-0.4, 1.4), (-0.1, 1.9)), ((-0.1, 1.9), (0.1, 2.5)), ((-0.1, 1.9), (0.35, 1.75)),
         ((0.35, 1.75), (0.75, 2.05)), ((0.75, 2.05), (1.05, 1.65)), ((0.75, 2.05), (0.85, 2.5)),
         ((1.05, 1.65), (1.6, 1.6)), ((1.6, 1.6), (2.2, 1.45)), ((-0.75, 2.2), (-1.05, 2.6)),
         ((-1.05, 2.6), (-1.25, 3.1)), ((0.2, 1.2), (0.6, 1.35))]


def fluted(name, slot, bone, center, r, h, flutes=8):
    """Colonne dorique : cylindre à 2 x flutes pans, un sommet sur deux rentré (cannelures)."""
    ob = Q.P(name, "cone", slot, bone, loc=center, segments=flutes * 2, r1=r, r2=r * 0.94, depth=h)
    c = Vector(center)
    for v in ob.data.vertices:
        d = Vector((v.co.x - c.x, v.co.y - c.y))
        if d.length < 1e-4:
            continue
        a = math.atan2(d.y, d.x)
        k = round(a / (math.pi / flutes))
        if k % 2:
            v.co.x = c.x + d.x * 0.84
            v.co.y = c.y + d.y * 0.84
    return ob


def volute_outline(r, turns=1.5, w=0.32, n=22):
    """Spirale plate (volute ionique) : ruban dont la largeur diminue vers le centre."""
    out, inn = [], []
    for i in range(n + 1):
        t = i / n
        a = 2 * math.pi * turns * t
        rr = r * (1 - 0.8 * t)
        ww = r * w * (1 - 0.6 * t)
        out.append(((rr) * math.cos(a), (rr) * math.sin(a)))
        inn.append(((rr - ww) * math.cos(a), (rr - ww) * math.sin(a)))
    return out + inn[::-1]


def bar(x0, y0, x1, y1, w):
    d = Vector((x1 - x0, y1 - y0)).normalized()
    n = Vector((-d.y, d.x)) * w / 2
    return [(x0 - n.x, y0 - n.y), (x1 - n.x, y1 - n.y), (x1 + n.x, y1 + n.y), (x0 + n.x, y0 + n.y)]


# lettres « ΤΙΤΑΝ » en traits (cellule 0..1 x 0..1)
LETTERS = {"T": [(0, 1, 1, 1), (0.5, 1, 0.5, 0)], "I": [(0.5, 1, 0.5, 0)],
           "A": [(0, 0, 0.5, 1), (0.5, 1, 1, 0), (0.22, 0.4, 0.78, 0.4)],
           "N": [(0, 0, 0, 1), (0, 1, 1, 0), (1, 0, 1, 1)]}


def pedestal(parts):
    """Socle de statue (pavé mouluré) sous les 4 pieds + plaque gravée à l'avant ; os Root (immobile)."""
    fx = Q.node("pied_av").x + 0.75
    y0, y1 = Q.node("orteil_av").y - 0.65, Q.node("pied_ar").y + 0.65
    yc, ly = (y0 + y1) / 2, y1 - y0
    parts.append(Q.P("Socle", "cube", MAIN, "Root", loc=(0, yc, PED * 0.55), scale=(2 * fx, ly, PED * 0.7)))
    parts.append(Q.P("Moulure", "cube", BELLY, "Root", loc=(0, yc, PED * 0.1), scale=(2 * fx + 0.16, ly + 0.16,
                                                                                         PED * 0.2)))
    parts.append(Q.P("Corniche", "cube", BACK, "Root", loc=(0, yc, PED * 0.95), scale=(2 * fx + 0.08, ly + 0.08,
                                                                                         PED * 0.1)))
    # plaque dorée + lettres en relief (face avant, -Y)
    yf = y0 - 0.06
    M = Matrix(((1, 0, 0, 0), (0, 0, 1, yf), (0, 1, 0, PED * 0.52), (0, 0, 0, 1))) @ Matrix.Rotation(math.pi, 4, "Y")
    parts.append(Q.poly("Plaque", ACCENT, "Root", K.rect(1.5, PED * 0.6), M))
    # plots dorés aux coins et au milieu des côtés du socle (pièce de construction)
    sx, sy0, sy1 = fx - 0.16, y0 + 0.16, y1 - 0.16
    V.studs(parts, Matrix.Translation((0, 0, PED)), [(x, y) for x in (-sx, sx) for y in (sy0, yc, sy1)], 0.09, 0.07,
            ACCENT, "Root")
    M2 = M @ Matrix.Translation((0, 0, 0.012))
    word, h, cw, gap = "TITAN", PED * 0.42, PED * 0.3, PED * 0.12
    x = -(len(word) * cw + (len(word) - 1) * gap) / 2
    for ch in word:
        for x0, y0_, x1, y1_ in LETTERS[ch]:
            parts.append(Q.poly("Lettre", BACK, "Root",
                                bar(x + x0 * cw, -h / 2 + y0_ * h, x + x1 * cw, -h / 2 + y1_ * h, 0.035), M2))
        x += cw + gap


def accessories(body, parts):
    pedestal(parts)
    # --- pattes : colonnes doriques cannelées + chapiteau carré + base ronde
    for keys, fb in ((Q.HIND_NODES, "B"), (Q.FRONT_NODES, "F")):
        g, c = Q.node(keys[1]), Q.node(keys[2])
        r = Q.radius(keys[1]) * 0.95
        z0, z1 = c.z + 0.1, g.z + 0.22  # bas de colonne au-dessus de la cheville : ne pique pas dans le socle
        cy = (g.y + c.y) / 2
        col = fluted("Colonne", MAIN, "LowerLeg%s.S" % fb, (c.x, cy, (z0 + z1) / 2), r, z1 - z0)
        K.mirror_inplace(col)
        parts.append(col)
        parts.append(Q.P("Chapiteau", "cube", BELLY, "LowerLeg%s.S" % fb, loc=(c.x, cy, z1 + 0.06), mirror_x=True,
                         scale=(r * 1.75, r * 1.75, 0.1)))
        parts.append(Q.P("Echine", "cone", BACK, "LowerLeg%s.S" % fb, loc=(c.x, cy, z1 - 0.04), mirror_x=True,
                         segments=8, r1=r * 0.98, r2=r * 1.12, depth=0.1))
        parts.append(Q.P("Base", "cone", BELLY, "Foot%s.S" % fb, loc=(c.x, Q.node(keys[3]).y, PED + 0.07),
                         mirror_x=True, segments=8, r1=r * 1.15, r2=r * 1.05, depth=0.14))
    # --- volutes ioniques au-dessus des yeux (spirales plates dorées, 1,5 tour), plan face au côté
    for s in (1, -1):
        b = Q.dd.snap(body, (s * 0.6, -1.65, 4.55), 0.0)
        M = K.frame_from(b + Vector((s * 0.02, 0.02, 0.2)), Vector((s, 0.25, 0)), up=(0, 0, 1))
        parts.append(Q.flat("Volute", ACCENT, "Head", volute_outline(0.3, n=14), M, 0.08))
    # crête de marbre sur le crâne (petite pointe sculptée)
    # --- couronne de laurier dorée (9 feuilles) autour du cou
    a_, b_ = Q.node("cou1"), Q.node("cou2")
    ax = (b_ - a_).normalized()
    c0 = a_.lerp(b_, 0.42)
    rr = (0.66 * 0.58 + 0.6 * 0.42) * 1.25
    side = ax.cross(Vector((1, 0, 0))).normalized()
    for i in range(9):
        th = 2 * math.pi * i / 9
        rad = Vector((1, 0, 0)) * math.cos(th) + side * math.sin(th)
        p = c0 + rad * rr
        M = K.frame_from(p, rad, up=ax)
        M = M @ Matrix.Rotation(math.radians(35), 4, "Z")
        parts.append(K.xform(Q.P("Laurier", "sphere", ACCENT, ["Neck1", "Neck2"], scale=(0.1, 0.24, 0.04),
                                 u=6, v=3), M))
    parts.append(K.xform(Q.P("Ruban", "cone", GLOW, ["Neck1", "Neck2"], segments=8, r1=rr - 0.02, r2=rr - 0.04,
                             depth=0.08, cap=False), K.frame_from(c0, ax, up=(0, -1, 0))))
    # --- veines dorées émissives
    parts.append(V.crack_strips(body, VEINS, w=0.05))
    # --- plaques ostéodermes de marbre gris (losanges plats) le long du dos ; la plus grande porte 4 plots dorés
    for k, y in enumerate((-0.25, 0.25, 0.75, 1.25, 1.7)):
        st = ([(-0.1, -0.1), (0.1, -0.1), (-0.1, 0.1), (0.1, 0.1)], 0.055, 0.06, ACCENT) if k == 1 else None
        V.plate(parts, body, 0.0, y, 0.34 - 0.04 * abs(k - 1), BELLY, V.TRUNK_BONES, shape=4, lean=0.15, stud=st)


POSES = [  # (cou_rx, cou_rz, tete_rx, tete_rz, queue_rz, patte avant levée, hanches_rx, accroupi)
    (0, 0, 0, 0, 0, 0, 0, 1),        # « le sprinter » : prêt à bondir
    (-10, 0, -12, 0, 14, 1, -1, 0),  # « le conquérant » : tête haute, patte levée
    (6, 18, 10, 20, -16, 0, 1, 0),   # « le penseur » : tête tournée vers le public, inclinée
]
SEQ = [(0.0, 0), (0.08, 0), (0.16, 1), (0.42, 1), (0.5, 2), (0.84, 2), (0.94, 0), (1.0, 0)]


def pose_at(t):
    """Poses tenues (statue) avec transitions rapides ; renvoie les valeurs interpolées."""
    vals = []
    for j in range(len(POSES[0])):
        vals.append(R.keys(t, [(tt, POSES[i][j]) for tt, i in SEQ]))
    return vals


class Anims(V.ChibiAnims):
    death_drop = -0.08  # le socle touche déjà le sol (réglage auto inopérant) : la statue se couche SUR le socle
    # Poseur : prend une pose de statue, la tient (seulement une respiration à peine visible), change de pose
    def idle(self, t):
        self.base()
        nrx, nrz, hrx, hrz, tz, _leg, hx, cr = pose_at(t)
        c = self.crouch(t, cr)
        br = 0.3 * R.S2(t, 2)
        self.hips(z=c["hz"] + 0.004 * br, rx=hx + c["hrx"])
        self.spine(rx=-0.3 * br)
        self.neck(rx=nrx + c["nrx"], rz=nrz)
        self.r("Head", (R.X, hrx + c["headx"]), (R.Z, hrz))
        self.r("Jaw", (R.X, 12))  # sourire de statue satisfaite
        self.tail(lambda i: ((R.Z, tz * (0.5 + 0.25 * i)), (R.X, 1 + c["tailx"])))

    def feet_still(self, leg, t, a, b):
        if leg != "FL":
            return a, b
        lift = pose_at(t)[5]
        off = Vector((0, -0.12 * lift * self.u, 0.4 * lift * self.u))
        return a + off, b + off + Vector((0, 0, 0.12 * lift * self.u))

    def death(self, t):
        """Mort du helper (bascule sur le flanc) ; la statue est soulevée pendant la chute pour rester AU-DESSUS du
        socle (le réglage automatique de la chute vise le sol, que le socle touche déjà)."""
        super().death(t)
        h = R.keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = R.S2(t, 3) * R.keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        f = R.keys(t, [(0, 0), (0.36, 0), (0.62, 1), (0.71, 0.92), (0.8, 1), (1, 1)])
        lift = 0.15 * math.sin(math.pi * min(1.0, f)) + 0.45 * math.sin(math.pi * f)
        self.hips(y=0.2 * h, z=-self.death_drop * f + lift + 0.1 * h, rx=-6 * h, rz=6 * w, ry=82 * f)


S_ = sys.modules[__name__]
if __name__ == "__main__":
    V.lego_patch()
    Q.main(S_)
