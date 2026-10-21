# DINO DICE — Ronceplaque (rare, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi « plaques » : tête énorme, gros yeux tristes, grosses griffes crème, corps à facettes,
# plaques plates biseautées, taches sombres)
# Référence réelle : Ankylosaurus magniventris (corps large et bas, tête triangulaire avec 2 petites cornes
# à l'arrière du crâne, queue rigide terminée par une massue à 2 lobes, pattes écartées).
# Couche thématique : 4 bandes de plaques sur le dos, chacune hérissée de 3 épines de ronce penchées vers l'arrière,
# 12 baies roses (glow, émissif en jeu) aux pointes ; massue = 2 boules de ronce épineuses ; sourcils tristes
# en accent circonflexe (paupières inclinées) ; pansement sur le museau.
#   python3 bb.py blender/scripts/dinos/build_ronceplaque.py [-- model]

import math
import os
import sys

import bmesh
import bpy
from mathutils import Vector
from mathutils.bvhtree import BVHTree

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
from quadruped_helpers import K, R, MAIN, BELLY, WHITE, GLOW, BACK  # noqa: E402

ID, NAME = "ronceplaque", "Ronceplaque"
HEIGHT = 3.4 * 1.1
COLORS = {"main": "#7B1FA2", "belly": "#A5D6A7", "accent": "#E91E63", "glow": "#FF4F9A", "back": "#4A148C"}

NODES = [
    ("bassin", (0, 0.3, 1.25), 1.0, None),
    ("dos", (0, -0.1, 1.3), 1.05, "bassin"),
    ("poitrail", (0, -0.5, 1.25), 0.95, "dos"),
    ("cou1", (0, -0.85, 1.35), 0.8, "poitrail"),
    ("cou2", (0, -1.1, 1.5), 0.88, "cou1"),
    ("crane", (0, -1.5, 1.75), 1.12, "cou2"),
    ("machoire", (0, -1.95, 1.6), 0.95, "crane"),
    ("museau", (0, -2.35, 1.52), 0.75, "machoire"),
    ("nez", (0, -2.65, 1.48), 0.5, "museau"),
    ("queue1", (0, 1.0, 1.15), 0.45, "bassin"),
    ("queue2", (0, 1.5, 1.05), 0.3, "queue1"),
    ("queue3", (0, 1.9, 1.0), 0.2, "queue2"),
    ("queue4", (0, 2.25, 1.0), 0.12, "queue3"),
    ("hanche", (0.75, 0.35, 0.85), 0.48, None),
    ("genou", (0.9, 0.28, 0.55), 0.45, "hanche"),
    ("cheville", (0.93, 0.38, 0.34), 0.42, "genou"),
    ("pied_ar", (0.93, 0.32, 0.27), 0.42, "cheville"),
    ("orteil_ar", (0.93, 0.07, 0.24), 0.34, "pied_ar"),
    ("epaule", (0.75, -0.5, 0.85), 0.47, None),
    ("coude", (0.9, -0.45, 0.55), 0.44, "epaule"),
    ("poignet", (0.93, -0.57, 0.34), 0.41, "coude"),
    ("pied_av", (0.93, -0.64, 0.27), 0.41, "poignet"),
    ("orteil_av", (0.93, -0.88, 0.24), 0.33, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.1, WHITE  # ongles du helper retirés : griffes plus bas
BELLY_COS, BELLY_MAXX = 0.45, 0.95
BACK_NZ, BACK_ZMIN, BACK_MAXX = 0.7, 9.0, 0.0  # pas de dos uni : taches peintes dans paint()
SIGMA = 0.12
MOUTH = {"p": (0, -2.2, 1.33), "n": (0, -0.1, 1), "y0": -1.6, "gap": 0.03, "zmin": 0.7,
         "smile": -0.08, "smile_y": -2.15, "shell": 0.45, "shell_depth": 0.06}
# yeux tristes : paupière inclinée vers l'extérieur (sourcil en accent circonflexe)
EYE = {"target": (1.3, -1.95, 2.05), "size": 0.42, "sink": 0.4, "iris": 0.68, "look": (-0.2, -1.4, 0.15), "iris_slot": BELLY,
       "lid": {"close": -58, "tilt": -14, "slot": MAIN}}
NOSTRILS = [((0.15, -2.9, 1.72), (0.055, 0.05, 0.04))]
TEETH = [(-2.3, True, 0.17, 0.08, 0.2), (-2.0, True, 0.14, 0.07, 0.16), (-2.15, False, 0.13, 0.06, 0.18)]
TONGUE_AT = (-1.95, 0.45, 0.3)
GAIT = {"walk_step": 0.45, "walk_lift": 0.2, "run_step": 0.8, "run_lift": 0.26, "hop": 0.35}
ATTACK = "tail"
ROAR_JAW = 32
IDLE_JAW = 8  # bouche entrouverte boudeuse

BANDS = [(-0.45, 0.85), (-0.05, 0.95), (0.35, 0.95), (0.75, 0.8)]  # (y, demi-largeur)


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


def claws(body, parts, L=0.34, r=0.12):
    """Remplace les ongles ronds du helper par 3 grosses griffes crème pointues par pied (os du pied)."""
    for o in [p for p in parts if p.name.startswith("Ongle")]:
        parts.remove(o)
        bpy.data.objects.remove(o, do_unlink=True)
    for keys, fb in ((Q.HIND_NODES, "B"), (Q.FRONT_NODES, "F")):
        pied, ort, ro = Q.node(keys[3]), Q.node(keys[4]), Q.radius(keys[4])
        for dx in (-0.62, 0.0, 0.62):
            p = Vector((pied.x + dx * ro, ort.y - ro * (0.8 - 0.25 * abs(dx)), 0.24))
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
def paint(me, setp):
    # taches sombres : quelques facettes isolées sur les flancs et le dos (motif fixe, pas d'aléatoire)
    for p in me.polygons:
        c = p.center
        if -0.6 < c.y < 1.3 and c.z > 0.9 and abs(c.x) > 0.25 and p.normal.z > -0.3 and p.index % 4 == 0:
            setp(p, BACK)


def band_bone(y):
    return "Spine3" if y < -0.3 else "Spine2" if y < 0.15 else "Spine1" if y < 0.55 else "Hips"


def accessories(body, parts):
    claws(body, parts)
    for y, hw in BANDS:
        b = band_bone(y)
        # bande : 3 plaques carrées biseautées (back), chacune avec 1 épine de ronce (belly) et sa baie (glow)
        for x in (-hw * 0.62, 0.0, hw * 0.62):
            loc, nor = top(body, y, x)
            M = K.frame_from(loc - nor * 0.02, nor, up=(0, -1, 0))
            parts.append(K.xform(Q.P("Plaque", "cone", BACK, b, loc=(0, 0, 0.05), rot=(0, 0, 45), segments=4,
                                     r1=0.3, r2=0.21, depth=0.12), M))
            d = (nor + Vector((0, 0.8, 0))).normalized()
            L = 0.4
            base = loc + nor * 0.09
            parts.append(cone_at("Epine", BELLY, b, base, d, L, 0.1, seg=4, tip=0.08))
            parts.append(Q.P("Baie", "sphere", GLOW, b, loc=base + d * (L + 0.03), scale=(0.09, 0.09, 0.09),
                             u=5, v=3))
    # 2 petites cornes à l'arrière du crâne (vers l'arrière-dehors)
    _ok, loc, nor, _i = body.closest_point_on_mesh(Vector((0.75, -1.15, 2.4)))
    ob = cone_at("Corne", BELLY, "Head", loc - nor * 0.05, (0.7, 0.6, 0.35), 0.42, 0.14, seg=4)
    K.mirror_inplace(ob)
    parts.append(ob)
    # massue : 2 boules de ronce (back) + épines (belly) au bout de la queue
    for sx in (1, -1):
        c = Vector((sx * 0.26, 2.3, 1.02))
        parts.append(Q.P("Massue", "sphere", BACK, "Tail5", loc=c, scale=(0.34, 0.36, 0.3), u=6, v=4))
        for th, ph in ((0, 0.4), (90, 0.2), (180, 0.4), (270, 0.1), (45, 1.2), (135, 1.3)):
            a = math.radians(th)
            d = Vector((sx * math.cos(a) * math.sin(ph + 0.6), math.sin(a) * math.sin(ph + 0.6) * 0.8,
                        math.cos(ph + 0.6)))
            if d.x * sx < -0.3:
                continue
            parts.append(cone_at("EpineMassue", BELLY, "Tail5", c + d.normalized() * 0.26, d, 0.22, 0.07, seg=4))
    # pansement sur le museau (blanc)
    loc, nor = top(body, -2.45, 0.18)
    M = K.frame_from(loc + nor * 0.01, nor, up=(0.6, -0.3, 0))
    parts.append(Q.flat("Pansement", WHITE, "Head", K.rect(0.44, 0.17), M, 0.03))
    # petites pointes triangulaires sur les coudes
    _ok, loc, nor, _i = body.closest_point_on_mesh(Vector((1.5, -0.3, 0.7)))
    ob = cone_at("PointeCoude", BELLY, "UpperLegF.S", loc - nor * 0.04, nor + Vector((0, 0.8, 0.3)), 0.22, 0.08,
                 seg=4)
    K.mirror_inplace(ob)
    parts.append(ob)


class Anims(Q.QuadAnims):
    # Câlin frustré : tend la tête vers le joueur (vers la caméra), attend... soupire, baisse les épaules
    def idle(self, t):
        self.base()
        reach = R.keys(t, [(0, 0), (0.1, 0), (0.24, 1), (0.5, 1), (0.58, 0), (1, 0)])
        inhale = R.keys(t, [(0, 0), (0.56, 0), (0.66, 1), (0.72, 1), (0.8, 0), (1, 0)])
        slump = R.keys(t, [(0, 0), (0.72, 0), (0.8, 1), (0.92, 1), (1, 0)])
        br = R.S2(t, 2) * (1 - reach)
        self.hips(z=0.01 * br + 0.05 * inhale - 0.04 * slump, rx=2 - 2 * inhale + 1 * slump)
        self.spine(rx=-0.8 * br - 2 * inhale + 2 * slump)
        self.neck(rx=-2 - 8 * reach + 1 * slump, rz=-10 * reach, ry=-3 * reach)
        self.r("Head", (R.X, -6 * reach - 4 * inhale + 3 * slump), (R.Z, -14 * reach + 3 * R.S2(t, 1)),
               (R.Y, 10 * reach * (1 + 0.15 * R.S2(t, 3))))
        self.r("Jaw", (R.X, IDLE_JAW + 6 * reach + 10 * inhale))
        self.tail(lambda i: ((R.Z, 4 * R.S2(t, 1, -0.08 * i) * (1 - slump)), (R.X, 1.5 * br + 2 * slump)))

    def feet_still(self, leg, t, a, b):
        if leg[0] != "F":
            return a, b
        slump = R.keys(t, [(0, 0), (0.72, 0), (0.8, 1), (0.92, 1), (1, 0)])
        sx = 1 if leg[1] == "L" else -1
        off = Vector((0.08 * sx * slump * self.u, 0, 0))  # pattes avant qui s'écartent : épaules qui tombent
        return a + off, b + off

    # Célébration : sauts de joie en se cabrant, pattes avant levées (enfin un câlin !)
    def celebrate_feet(self, leg, t, a, b):
        a, b = super().celebrate_feet(leg, t, a, b)
        if leg[0] != "F":
            return a, b
        joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
        ph = 0.0 if leg[1] == "L" else 0.5
        off = Vector((0, -0.08 * joy * self.u, (0.32 + 0.1 * R.S2(t, 3, ph)) * joy * self.u))
        return a + off, b + off

    def extra(self, clip, t):
        if clip == "Walk":
            self.r("Jaw", (R.X, IDLE_JAW))
        elif clip == "Run":
            self.r("Jaw", (R.X, IDLE_JAW + 8))
        elif clip == "Roar":  # grosse tête basse : anticipation réduite (le menton ne traverse pas le sol)
            a = R.keys(t, [(0, 0), (0.16, 1), (0.27, 0), (1, 0)])
            r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
            sh = r * R.S2(t, 8)
            self.neck(rx=0.5 * a - 9 * r)
            self.r("Head", (R.X, 2 * a - 14 * r + 3 * sh), (R.Z, 4 * sh))
            self.tail(lambda i: ((R.X, 3 * a - 1 * r), (R.Z, 4 * R.S2(t, 7, -0.1 * i) * r)))  # massue au-dessus du sol
        elif clip == "Celebrate":
            air, sq = self.hop(t)
            joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
            self.hips(z=GAIT["hop"] * air - 0.1 * sq + 0.1 * joy, rx=-12 * joy - 4 * air + 3 * sq,
                      rz=4 * R.S2(t, 2) * joy)
            self.neck(rx=6 * joy - 4 * air)


S_ = sys.modules[__name__]
if __name__ == "__main__":
    Q.main(S_)
