# DINO DICE — Galetosaure (commun, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi « plaques » : tête énorme, gros yeux à paupières lourdes, bouche ouverte, grosses
# griffes crème, corps à facettes planes ; un Commun reste simple)
# Référence réelle : Minmi paravertebra (petit ankylosaure bas et large, rangées de petites plaques sur les flancs,
# tête triangulaire basse, queue courte sans massue) ; pattes raccourcies pour l'effet « galet ».
# Couche thématique : 7 galets en 2 rangées décalées sur le dos (plaques plates biseautées à 6 pans), touffe de
# mousse sur le plus gros, paupières lourdes (os Lid.L / Lid.R) pour l'Idle somnolent (s'endort, ronfle, sursaute).
#   python3 bb.py blender/scripts/dinos/build_galetosaure.py [-- model]

import math
import os
import sys

import bmesh
import bpy
from mathutils import Vector
from mathutils.bvhtree import BVHTree

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
from quadruped_helpers import K, R, MAIN, BELLY, ACCENT, WHITE, BACK  # noqa: E402

ID, NAME = "galetosaure", "Galetosaure"
HEIGHT = 3.4 * 0.9
COLORS = {"main": "#9AA5B1", "belly": "#E6E1D3", "accent": "#7BC67E", "glow": "#FFB74D", "back": "#6B7785"}

NODES = [
    ("bassin", (0, 0.35, 1.2), 1.02, None),
    ("dos", (0, -0.05, 1.28), 1.1, "bassin"),
    ("poitrail", (0, -0.45, 1.25), 1.0, "dos"),
    ("cou1", (0, -0.8, 1.38), 0.86, "poitrail"),
    ("cou2", (0, -1.05, 1.58), 0.9, "cou1"),
    ("crane", (0, -1.45, 1.88), 1.15, "cou2"),
    ("machoire", (0, -1.95, 1.7), 0.98, "crane"),
    ("museau", (0, -2.35, 1.63), 0.78, "machoire"),
    ("nez", (0, -2.68, 1.6), 0.52, "museau"),
    ("queue1", (0, 1.05, 1.02), 0.42, "bassin"),
    ("queue2", (0, 1.4, 0.92), 0.27, "queue1"),
    ("queue3", (0, 1.65, 0.86), 0.16, "queue2"),
    ("queue4", (0, 1.82, 0.84), 0.09, "queue3"),
    ("hanche", (0.62, 0.4, 0.78), 0.46, None),
    ("genou", (0.74, 0.32, 0.5), 0.44, "hanche"),
    ("cheville", (0.76, 0.42, 0.32), 0.41, "genou"),
    ("pied_ar", (0.76, 0.36, 0.26), 0.41, "cheville"),
    ("orteil_ar", (0.76, 0.12, 0.24), 0.33, "pied_ar"),
    ("epaule", (0.62, -0.45, 0.8), 0.45, None),
    ("coude", (0.74, -0.42, 0.5), 0.43, "epaule"),
    ("poignet", (0.76, -0.55, 0.32), 0.4, "coude"),
    ("pied_av", (0.76, -0.62, 0.26), 0.4, "poignet"),
    ("orteil_av", (0.76, -0.86, 0.24), 0.32, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.11, WHITE  # ongles du helper retirés : griffes plus bas
BELLY_COS, BELLY_MAXX = 0.5, 0.85
BACK_NZ, BACK_ZMIN, BACK_MAXX = 0.55, 1.75, 1.3  # dos gris plus foncé (ventre « pierre posée » clair)
SIGMA = 0.12
MOUTH = {"p": (0, -2.45, 1.4), "n": (0, -0.1, 1), "y0": -1.7, "gap": 0.03, "zmin": 0.78,
         "smile": 0.2, "smile_y": -2.4, "shell": 0.48, "shell_depth": 0.06}
EYE = {"target": (1.35, -1.7, 2.2), "size": 0.48, "iris": 0.66, "look": (-0.3, -1.5, 0.05),
       "lid": {"close": -55, "bone": "Lid.S", "slot": BACK}}
NOSTRILS = [((0.17, -2.95, 1.85), (0.06, 0.05, 0.045))]
TEETH = [(-2.6, True, 0.18, 0.09, 0.2), (-2.25, True, 0.15, 0.08, 0.15), (-2.45, False, 0.14, 0.07, 0.18)]
TONGUE_AT = (-2.0, 0.45, 0.3)
GAIT = {"walk_step": 0.45, "walk_lift": 0.2, "run_step": 0.8, "run_lift": 0.28, "hop": 0.38}
ATTACK = "tail"
ROAR_JAW = 34
IDLE_JAW = 10  # bouche entrouverte, air endormi content

# 7 galets (x, y, demi-axes) en 2 rangées décalées ; le n°2 (le plus gros) porte la mousse.
# Tous derrière la tête (y > -0.2) : devant, le rayon vertical toucherait l'arrière du gros crâne.
PEBBLES = [(0.36, -0.08, (0.36, 0.28, 0.11)), (-0.38, 0.16, (0.42, 0.32, 0.12)), (0.4, 0.44, (0.5, 0.38, 0.14)),
           (-0.4, 0.72, (0.38, 0.3, 0.11)), (0.32, 0.94, (0.3, 0.24, 0.1)), (-0.24, 1.12, (0.24, 0.2, 0.08)),
           (0.0, 0.66, (0.28, 0.24, 0.1))]


# ------------------------------------------------------------------ style « plaques » (facettes)
def shape(body):
    """Corps en plaques : on défait la subdivision du Skin (faces planes, grosses facettes)."""
    bm = bmesh.new()
    bm.from_mesh(body.data)
    bmesh.ops.unsubdivide(bm, verts=bm.verts, iterations=2)
    bm.to_mesh(body.data)
    bm.free()


_build_mesh = Q.build_mesh


def build_mesh_flat():
    """Rendus Blender = rendu en jeu (une normale par face)."""
    out = _build_mesh()
    me = out[3].data
    me.polygons.foreach_set("use_smooth", [False] * len(me.polygons))
    me.update()
    return out


Q.build_mesh = build_mesh_flat


# ------------------------------------------------------------------ pièces chibi
def cone_at(name, slot, bone, base, d, L, r, seg=6, up=(0, 0, 1), tip=0.1):
    M = K.frame_from(Vector(base), Vector(d).normalized(), up=up)
    return K.xform(Q.P(name, "cone", slot, bone, loc=(0, 0, L / 2), segments=seg, r1=r, r2=r * tip, depth=L), M)


def claws(body, parts, L=0.3, r=0.11):
    """Remplace les ongles ronds du helper par 3 grosses griffes crème pointues par pied (os du pied)."""
    for o in [p for p in parts if p.name.startswith("Ongle")]:
        parts.remove(o)
        bpy.data.objects.remove(o, do_unlink=True)
    for keys, fb in ((Q.HIND_NODES, "B"), (Q.FRONT_NODES, "F")):
        pied, ort, ro = Q.node(keys[3]), Q.node(keys[4]), Q.radius(keys[4])
        for dx in (-0.62, 0.0, 0.62):
            p = Vector((pied.x + dx * ro, ort.y - ro * (0.8 - 0.25 * abs(dx)), 0.22))
            _ok, sp, _n, _i = body.closest_point_on_mesh(p)
            d = Vector((dx * 0.45, -1, -0.15))
            ob = cone_at("Griffe", WHITE, "Foot%s.S" % fb, sp - d.normalized() * 0.06, d, L, r, seg=4)
            K.mirror_inplace(ob)
            parts.append(ob)


def top(body, y, x=0.0):
    """Point du dessus du corps en (x, y) : rayon vertical décalé du plan de symétrie (sinon il passe entre 2 faces)."""
    me = body.data
    bvh = BVHTree.FromPolygons([v.co for v in me.vertices], [p.vertices for p in me.polygons])
    loc, nor, _i, _d = bvh.ray_cast(Vector((x + 0.013, y, 8.0)), Vector((0, 0, -1)))
    assert loc is not None, (x, y)
    return Vector((x, loc.y, loc.z)), nor


# ------------------------------------------------------------------ pièces du dino
def lid_axes():
    look = S_.EYE_LOOK
    side = Vector((0, 0, 1)).cross(look).normalized()
    return side, Vector((side.x, -side.y, -side.z))  # droite : -(miroir de l'axe gauche)


def EXTRA_BONES():
    ec, look = S_.EYE_CENTER, S_.EYE_LOOK
    ecr = Vector((-ec.x, ec.y, ec.z))
    lr = Vector((-look.x, look.y, look.z))
    return [("Lid.L", ec, ec + look * 0.35, "Head"), ("Lid.R", ecr, ecr + lr * 0.35, "Head")]


def paint(me, setp):
    # le gris foncé du dos s'arrête à la nuque : le dessus de la grosse tête reste gris clair
    for p in me.polygons:
        if p.center.y < -0.55 and p.normal.z > BACK_NZ and p.center.z > BACK_ZMIN:
            setp(p, MAIN)


def accessories(body, parts):
    claws(body, parts)
    spine = ["Hips", "Spine1", "Spine2", "Spine3", "Tail1"]
    moss = None
    for i, (x, y, ax) in enumerate(PEBBLES):
        loc, nor = top(body, y, x)
        M = K.frame_from(loc - nor * 0.02, nor, up=(0, -1, 0))
        # galet = plaque plate biseautée à 6 pans (dessus plus petit que le dessous)
        parts.append(K.xform(Q.P("Galet", "cone", BELLY, spine, loc=(0, 0, ax[2]), scale=(ax[0], ax[1], 2 * ax[2]),
                                 segments=6, r1=1.0, r2=0.72, depth=1.0), M))
        if i == 2:
            moss = M
    for dx, dy, r in ((0.0, 0.0, 0.2), (0.17, 0.12, 0.15), (-0.16, 0.1, 0.14)):
        p = moss @ Vector((dx, dy, 2 * PEBBLES[2][2][2] + r * 0.5))
        parts.append(Q.P("Mousse", "sphere", ACCENT, spine, loc=p, scale=(r, r, r * 0.8), u=5, v=3))
    # Petites plaques osseuses le long des flancs (2 rangées décalées, couleur du dos, losanges)
    for row, z in enumerate((1.5, 1.2)):
        for k in range(4):
            y = -0.1 + k * 0.36 + row * 0.18
            _ok, loc, nor, _ = body.closest_point_on_mesh(Vector((2.0, y, z)))
            M = K.frame_from(loc - nor * 0.01, nor)
            ob = K.xform(Q.P("Plaque", "cone", BACK, spine, loc=(0, 0, 0.03), segments=4, r1=0.14, r2=0.08,
                             depth=0.07), M)
            K.mirror_inplace(ob)
            parts.append(ob)


class Anims(Q.QuadAnims):
    def lids(self, close):
        aL, aR = lid_axes()
        self.r("Lid.L", (aL, close))
        self.r("Lid.R", (aR, close))

    # Somnolent : paupières lourdes, s'endort tête basse, ronfle bouche ouverte (dos qui gonfle), sursaute
    def idle(self, t):
        self.base()
        sleep = R.keys(t, [(0, 0), (0.12, 0), (0.28, 1), (0.74, 1), (0.78, 0), (1, 0)])
        jolt = R.keys(t, [(0, 0), (0.74, 0), (0.78, 1), (0.86, 0.3), (1, 0)])
        snore = 0.5 - 0.5 * math.cos(2 * math.pi * 3 * ((t - 0.28) / 0.46)) if 0.28 < t < 0.74 else 0.0
        br = R.S2(t, 2) * (1 - sleep)
        self.hips(z=-0.04 * sleep + 0.03 * snore * sleep + 0.012 * br + 0.05 * jolt, rx=2 + 1 * sleep - 2 * jolt)
        self.spine(rx=-0.8 * br - 2.5 * snore * sleep)
        self.neck(rx=-2 + 4 * sleep + 1.5 * br - 6 * jolt, rz=3 * jolt * R.S2(t, 6))
        self.r("Head", (R.X, 5 * sleep - 1.5 * snore * sleep - 8 * jolt), (R.Z, 3 * R.S2(t, 1) * (1 - sleep)),
               (R.Y, 6 * sleep))
        self.r("Jaw", (R.X, IDLE_JAW * (1 - sleep) + 4 + 14 * snore * sleep + 10 * jolt))
        self.lids(40 * sleep - 30 * jolt + 6 * (1 - sleep) * max(0.0, R.S2(t, 4)) ** 8)
        self.tail(lambda i: ((R.Z, 5 * R.S2(t, 1, -0.08 * i) * (1 - sleep) + 6 * jolt * R.S2(t, 5)),
                             (R.X, -3 * jolt)))

    # Célébration : sauts de joie en se cabrant, pattes avant levées
    def celebrate_feet(self, leg, t, a, b):
        a, b = super().celebrate_feet(leg, t, a, b)
        if leg[0] != "F":
            return a, b
        joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
        ph = 0.0 if leg[1] == "L" else 0.5
        off = Vector((0, -0.08 * joy * self.u, (0.3 + 0.1 * R.S2(t, 3, ph)) * joy * self.u))
        return a + off, b + off

    def extra(self, clip, t):
        if clip == "Roar" or clip == "Attack":
            self.lids(-25 * R.keys(t, [(0, 0), (0.3, 1), (0.8, 1), (1, 0)]))
        if clip == "Roar":  # grosse tête basse : anticipation réduite (le museau ne touche pas le sol)
            a = R.keys(t, [(0, 0), (0.16, 1), (0.27, 0), (1, 0)])
            r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
            sh = r * R.S2(t, 8)
            self.neck(rx=2 * a - 9 * r)
            self.r("Head", (R.X, 4 * a - 14 * r + 3 * sh), (R.Z, 4 * sh))
        elif clip == "Walk":
            self.r("Jaw", (R.X, IDLE_JAW * 0.6))
        elif clip == "Run":
            self.r("Jaw", (R.X, IDLE_JAW + 6))
        elif clip == "Celebrate":
            self.lids(-15)
            air, sq = self.hop(t)
            joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
            self.hips(z=GAIT["hop"] * air - 0.1 * sq + 0.1 * joy, rx=-12 * joy - 4 * air + 3 * sq,
                      rz=4 * R.S2(t, 2) * joy)
            self.neck(rx=6 * joy - 4 * air)
        elif clip == "Death":
            self.lids(55 * R.keys(t, [(0, 0), (0.5, 0), (0.7, 1), (1, 1)]))


S_ = sys.modules[__name__]
if __name__ == "__main__":
    Q.main(S_)
