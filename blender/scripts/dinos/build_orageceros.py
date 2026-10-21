# DINO DICE — Orageceros (épique, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi « plaques » : tête énorme, gros yeux nerveux, gueule ouverte, grosses griffes crème,
# corps à facettes, rayures sombres)
# Référence réelle : Styracosaurus albertensis (UNE grande corne nasale ≈ longueur du crâne, pas de cornes
# au-dessus des yeux, 6 longues pointes rayonnant du bord de la collerette, corps de rhinocéros).
# Couche thématique : corne nasale = éclair en zigzag (glow, émissif en jeu) ; les 6 pointes de collerette =
# nuages gris (grappes de 3 blocs) formant la « crinière » (os « Mane » qui se hérisse) ; 2 petits éclairs
# entre les nuages ; paratonnerre miniature planté sur la nuque ; 4 plots sur la plaque du dos (rareté épique).
#   python3 bb.py blender/scripts/dinos/build_orageceros.py [-- model]

import math
import os
import sys

import bmesh
import bpy
from mathutils import Matrix, Vector
from mathutils.bvhtree import BVHTree

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
from quadruped_helpers import K, R, MAIN, BELLY, ACCENT, WHITE, GLOW, BACK  # noqa: E402

ID, NAME = "orageceros", "Orageceros"
HEIGHT = 3.4 * 1.25
COLORS = {"main": "#546E7A", "belly": "#B0BEC5", "accent": "#FFEE58", "glow": "#FFF176", "back": "#263238"}

NODES = [
    ("bassin", (0, 0.35, 1.3), 0.95, None),
    ("dos", (0, -0.05, 1.38), 1.0, "bassin"),
    ("poitrail", (0, -0.45, 1.4), 0.94, "dos"),
    ("cou1", (0, -0.8, 1.58), 0.84, "poitrail"),
    ("cou2", (0, -1.05, 1.78), 0.9, "cou1"),
    ("crane", (0, -1.45, 2.1), 1.2, "cou2"),
    ("machoire", (0, -1.95, 1.92), 1.0, "crane"),
    ("museau", (0, -2.4, 1.85), 0.8, "machoire"),
    ("nez", (0, -2.75, 1.82), 0.55, "museau"),
    ("queue1", (0, 0.95, 1.22), 0.42, "bassin"),
    ("queue2", (0, 1.32, 1.16), 0.28, "queue1"),
    ("queue3", (0, 1.62, 1.18), 0.18, "queue2"),
    ("queue4", (0, 1.82, 1.24), 0.1, "queue3"),
    ("hanche", (0.6, 0.4, 0.95), 0.5, None),
    ("genou", (0.72, 0.3, 0.6), 0.47, "hanche"),
    ("cheville", (0.75, 0.42, 0.36), 0.43, "genou"),
    ("pied_ar", (0.75, 0.36, 0.28), 0.43, "cheville"),
    ("orteil_ar", (0.75, 0.1, 0.25), 0.35, "pied_ar"),
    ("epaule", (0.6, -0.45, 1.0), 0.48, None),
    ("coude", (0.72, -0.42, 0.62), 0.46, "epaule"),
    ("poignet", (0.75, -0.55, 0.36), 0.43, "coude"),
    ("pied_av", (0.75, -0.62, 0.28), 0.43, "poignet"),
    ("orteil_av", (0.75, -0.88, 0.25), 0.35, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.12, WHITE  # ongles du helper retirés : griffes plus bas
BELLY_COS, BELLY_MAXX = 0.5, 0.8
BACK_NZ, BACK_ZMIN, BACK_MAXX = 0.7, 9.0, 0.0  # pas de dos uni : rayures peintes dans paint()
SIGMA = 0.12
MOUTH = {"p": (0, -2.55, 1.62), "n": (0, -0.1, 1), "y0": -1.7, "gap": 0.03, "zmin": 1.0,
         "smile": 0.2, "smile_y": -2.5, "shell": 0.5, "shell_depth": 0.06}
# yeux nerveux : grands ouverts, petite pupille, paupière haute
EYE = {"target": (1.4, -1.75, 2.45), "size": 0.5, "iris": 0.6, "look": (-0.35, -1.5, 0.1), "iris_slot": ACCENT,
       "lid": {"close": -95, "tilt": 6, "slot": MAIN}}
NOSTRILS = [((0.17, -3.2, 2.05), (0.06, 0.05, 0.045))]
TEETH = [(-2.72, True, 0.22, 0.1, 0.2), (-2.42, True, 0.2, 0.09, 0.16), (-2.12, True, 0.16, 0.08, 0.14),
         (-2.58, False, 0.17, 0.08, 0.2), (-2.25, False, 0.15, 0.07, 0.16)]
TONGUE_AT = (-2.3, 0.5, 0.32)
GAIT = {"walk_step": 0.5, "walk_lift": 0.22, "run_step": 0.9, "run_lift": 0.3, "hop": 0.42}
ATTACK = "charge"
ROAR_JAW = 36
IDLE_JAW = 12

FRILL_C, FRILL_N = Vector((0, -0.95, 2.7)), Vector((0, -0.8, 0.6)).normalized()
BOLT_BIG = ([(0, 0), (0.2, 0.42), (-0.06, 0.52), (0.26, 0.98), (0.06, 1.06), (0.36, 1.45)],
            [0.2, 0.17, 0.15, 0.12, 0.09, 0.0])
BOLT_SMALL = ([(0, 0), (0.1, 0.18), (-0.04, 0.24), (0.1, 0.45)], [0.08, 0.07, 0.06, 0.0])


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


def stripes(me, setp, y0, y1, period, width, zmin, slot=BACK):
    for p in me.polygons:
        c = p.center
        if y0 < c.y < y1 and c.z > zmin and p.normal.z > -0.2 and ((c.y - y0) / period) % 1.0 < width:
            setp(p, slot)


# ------------------------------------------------------------------ pièces du dino
def bolt(pts, widths):
    """Ruban en zigzag (contour 2D) le long de `pts`, demi-largeur `widths` (0 = pointe)."""
    left, right = [], []
    for i, p in enumerate(pts):
        p = Vector(p)
        d = (Vector(pts[min(i + 1, len(pts) - 1)]) - Vector(pts[max(i - 1, 0)])).normalized()
        n = Vector((-d.y, d.x))
        left.append(tuple(p + n * widths[i]))
        right.append(tuple(p - n * widths[i]))
    return left + list(reversed(right[:-1]))


def EXTRA_BONES():
    return [("Mane", FRILL_C, FRILL_C + Vector((0, 0.3, 0.5)), "Head")]


def paint(me, setp):
    stripes(me, setp, -0.45, 1.9, 0.38, 0.4, 1.5)  # rayures d'orage sur le dos et la queue


def accessories(body, parts):
    claws(body, parts)
    # corne-éclair : ruban épais dans le plan de symétrie, penché vers l'avant (≈ longueur du crâne)
    loc, _n = top(body, -2.45)
    a = math.radians(24)
    fwd = Vector((0, -math.sin(a), math.cos(a)))
    M = Matrix((Vector((0, -math.cos(a), -math.sin(a))), fwd, Vector((1, 0, 0)))).transposed().to_4x4()
    M.translation = loc - Vector((0, 0, 0.12))
    parts.append(Q.flat("Eclair", GLOW, "Head", bolt(*BOLT_BIG), M, 0.18))
    # collerette courte : plaque à 8 pans (main) + plaque dessous (back), inclinées vers l'arrière
    F = K.frame_from(FRILL_C, FRILL_N, up=(0, 0, 1))
    parts.append(K.xform(Q.P("Collerette", "cone", MAIN, "Head", loc=(0, 0, 0.04), rot=(0, 0, 22.5), segments=8,
                             r1=1.12, r2=1.0, depth=0.14), F))
    parts.append(K.xform(Q.P("Collerette", "cone", BACK, "Head", loc=(0, 0, -0.06), rot=(0, 0, 22.5), segments=8,
                             r1=1.2, r2=1.2, depth=0.08), F))
    # 6 pointes = nuages (grappes de 3 blocs à facettes, belly) sur la moitié haute, os « Mane »
    for k in range(6):
        ang = math.radians(10 + k * 32)
        rd = Vector((math.cos(ang), math.sin(ang), 0))
        for j, (r_, s_) in enumerate(((0.98, 0.3), (1.26, 0.25), (1.5, 0.19))):
            p = F @ (rd * r_ + Vector((0, 0, 0.05 + 0.04 * j)))
            parts.append(Q.P("Nuage", "sphere", BELLY, "Mane", loc=p, scale=(s_, s_, s_ * 0.85), u=6, v=4))
    # 2 petits éclairs entre les nuages
    for k in (1, 3):
        ang = math.radians(10 + (k + 0.5) * 32)
        rd = Vector((math.cos(ang), math.sin(ang), 0))
        Mb = F @ Matrix.Translation(rd * 1.05 + Vector((0, 0, 0.14))) @ Matrix.Rotation(ang - math.pi / 2, 4, "Z")
        parts.append(Q.flat("PetitEclair", ACCENT, "Mane", bolt(*BOLT_SMALL), Mb, 0.07))
    # paratonnerre sur la nuque, derrière la collerette : socle + tige + boule
    loc, _n = top(body, 0.0)
    parts.append(Q.P("Paratonnerre", "cone", BACK, "Spine2", loc=loc + Vector((0, 0, 0.02)), segments=6,
                     r1=0.13, r2=0.06, depth=0.12))
    parts.append(Q.P("Paratonnerre", "cone", BELLY, "Spine2", loc=loc + Vector((0, 0, 0.32)), segments=6,
                     r1=0.04, r2=0.03, depth=0.6))
    parts.append(Q.P("ParatonnerreBoule", "sphere", ACCENT, "Spine2", loc=loc + Vector((0, 0, 0.66)),
                     scale=(0.1, 0.1, 0.1), u=6, v=4))
    # plaque de dos sur la croupe (trapèze biseauté) + 4 plots ronds (pièce de construction)
    loc, nor = top(body, 0.5)
    M = K.frame_from(loc - nor * 0.03, nor, up=(0, -1, 0))
    parts.append(K.xform(Q.P("PlaqueDos", "cone", BELLY, "Hips", loc=(0, 0, 0.05), rot=(0, 0, 45), segments=4,
                             r1=0.55, r2=0.45, depth=0.12), M))
    for dx, dy in ((-0.16, -0.16), (0.16, -0.16), (-0.16, 0.16), (0.16, 0.16)):
        parts.append(K.xform(Q.P("Plot", "cone", ACCENT, "Hips", loc=(dx, dy, 0.14), segments=8, r1=0.09, r2=0.09,
                                 depth=0.07), M))
    # petites pointes triangulaires sur les coudes
    _ok, loc, nor, _i = body.closest_point_on_mesh(Vector((1.3, -0.3, 0.75)))
    ob = cone_at("PointeCoude", BELLY, "UpperLegF.S", loc - nor * 0.04, nor + Vector((0, 0.8, 0.3)), 0.24, 0.09,
                 seg=4)
    K.mirror_inplace(ob)
    parts.append(ob)


class Anims(Q.QuadAnims):
    def mane(self, v):
        self.r("Mane", (R.X, -v))

    def jolt(self, t):
        return R.keys(t, [(0, 0), (0.2, 0), (0.23, 1), (0.3, 0.2), (0.36, 0), (1, 0)])

    # Nerveux, prêt à bondir : sursaute, la crinière se hérisse, regarde le ciel (gauche puis droite), se calme
    def idle(self, t):
        self.base()
        jolt = self.jolt(t)
        bristle = R.keys(t, [(0, 0), (0.2, 0), (0.24, 1), (0.7, 1), (0.82, 0), (1, 0)])
        sky = R.keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.72, 1), (0.82, 0), (1, 0)])
        scan = R.keys(t, [(0, 0), (0.4, 0), (0.48, 1), (0.58, 1), (0.64, -1), (0.72, -1), (0.8, 0), (1, 0)])
        tremble = bristle * R.S2(t, 14)
        br = R.S2(t, 2)
        self.hips(z=-0.03 + 0.012 * br + 0.16 * jolt, rx=4 - 3 * jolt)
        self.spine(rx=-0.8 * br)
        self.neck(rx=-3 + 1.2 * br - 7 * sky - 5 * jolt, rz=6 * scan)
        self.r("Head", (R.X, -12 * sky - 5 * jolt + 1.5 * tremble), (R.Z, 10 * scan), (R.Y, -5 * scan))
        self.r("Jaw", (R.X, IDLE_JAW + 12 * jolt + 4 * sky))
        self.mane(18 * bristle + 3 * tremble)
        self.tail(lambda i: ((R.Z, 5 * R.S2(t, 1, -0.08 * i) + 3 * tremble), (R.X, -6 - 10 * bristle)))

    def feet_still(self, leg, t, a, b):
        off = Vector((0, 0, 0.16 * self.jolt(t) * self.u * 0.9))  # les 4 pattes décollent au sursaut
        return a + off, b + off

    # Célébration : sauts de joie en se cabrant, pattes avant levées
    def celebrate_feet(self, leg, t, a, b):
        a, b = super().celebrate_feet(leg, t, a, b)
        if leg[0] != "F":
            return a, b
        joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
        ph = 0.0 if leg[1] == "L" else 0.5
        off = Vector((0, -0.08 * joy * self.u, (0.35 + 0.12 * R.S2(t, 3, ph)) * joy * self.u))
        return a + off, b + off

    def extra(self, clip, t):
        if clip == "Walk":
            self.mane(3 * R.S2(t, 2))
            self.r("Jaw", (R.X, IDLE_JAW * 0.6))
        elif clip == "Run":
            self.mane(10 + 4 * R.S2(t, 2))
            self.r("Jaw", (R.X, IDLE_JAW + 6))
        elif clip == "Attack":
            s = R.keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.58, 1), (0.88, 0), (1, 0)])
            self.mane(22 * s)
        elif clip == "Roar":
            r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
            self.mane(25 * r + 4 * r * R.S2(t, 10))
        elif clip == "Celebrate":
            air, sq = self.hop(t)
            joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
            self.hips(z=GAIT["hop"] * air - 0.1 * sq + 0.1 * joy, rx=-14 * joy - 4 * air + 3 * sq,
                      rz=4 * R.S2(t, 2) * joy)
            self.neck(rx=6 * joy - 4 * air)
            self.mane(10 + 8 * R.S2(t, 3))
        elif clip == "Death":
            f = R.keys(t, [(0, 0), (0.36, 0), (0.62, 1), (1, 1)])
            self.mane(-12 * f)


S_ = sys.modules[__name__]
if __name__ == "__main__":
    Q.main(S_)
