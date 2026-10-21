# DINO DICE — Boucératops (peu commun, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi : tête énorme, gros yeux, gueule ouverte, grosses griffes crème, rayures)
# Référence réelle : Triceratops horridus (2 longues cornes frontales vers l'avant, petite corne nasale,
# collerette pleine arrondie, corps massif sur 4 pattes trapues).
# Couche thématique : corde à linge tendue entre les 2 cornes du front, chaussette rayée + pince à linge
# (os « Sock » séparé pour le balancement), bord de collerette festonné en napperon (12 creux).
#   python3 bb.py blender/scripts/dinos/build_bouceratops.py [-- model]

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

ID, NAME = "bouceratops", "Bouceratops"
HEIGHT = 3.4 * 1.1
COLORS = {"main": "#FFA62B", "belly": "#FFF3E0", "accent": "#8D6E63", "glow": "#2FD158", "back": "#E0731A"}

NODES = [
    ("bassin", (0, 0.35, 1.3), 0.92, None),
    ("dos", (0, -0.05, 1.38), 0.98, "bassin"),
    ("poitrail", (0, -0.45, 1.42), 0.92, "dos"),
    ("cou1", (0, -0.8, 1.6), 0.82, "poitrail"),
    ("cou2", (0, -1.05, 1.8), 0.9, "cou1"),
    ("crane", (0, -1.45, 2.15), 1.22, "cou2"),
    ("machoire", (0, -1.95, 1.95), 1.02, "crane"),
    ("museau", (0, -2.4, 1.88), 0.8, "machoire"),
    ("nez", (0, -2.75, 1.85), 0.55, "museau"),
    ("queue1", (0, 0.95, 1.22), 0.42, "bassin"),
    ("queue2", (0, 1.32, 1.16), 0.28, "queue1"),
    ("queue3", (0, 1.62, 1.18), 0.18, "queue2"),
    ("queue4", (0, 1.82, 1.24), 0.1, "queue3"),
    ("hanche", (0.58, 0.4, 0.95), 0.5, None),
    ("genou", (0.7, 0.3, 0.6), 0.47, "hanche"),
    ("cheville", (0.73, 0.42, 0.36), 0.43, "genou"),
    ("pied_ar", (0.73, 0.36, 0.28), 0.43, "cheville"),
    ("orteil_ar", (0.73, 0.1, 0.25), 0.35, "pied_ar"),
    ("epaule", (0.58, -0.45, 1.0), 0.48, None),
    ("coude", (0.7, -0.42, 0.62), 0.46, "epaule"),
    ("poignet", (0.73, -0.55, 0.36), 0.43, "coude"),
    ("pied_av", (0.73, -0.62, 0.28), 0.43, "poignet"),
    ("orteil_av", (0.73, -0.88, 0.25), 0.35, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.12, WHITE  # ongles du helper retirés : griffes plus bas
BELLY_COS, BELLY_MAXX = 0.5, 0.8
BACK_NZ, BACK_ZMIN, BACK_MAXX = 0.7, 9.0, 0.0  # pas de dos uni : rayures peintes dans paint()
SIGMA = 0.12
MOUTH = {"p": (0, -2.55, 1.66), "n": (0, -0.1, 1), "y0": -1.7, "gap": 0.03, "zmin": 1.0,
         "smile": 0.22, "smile_y": -2.5, "shell": 0.5, "shell_depth": 0.06}
EYE = {"target": (0.72, -1.72, 2.62), "size": 0.5, "iris": 0.7, "look": (-0.1, -1.5, 0.05),
       "lid": {"close": -74, "tilt": 8, "slot": BACK}}
NOSTRILS = [((0.17, -3.2, 2.12), (0.06, 0.05, 0.045))]
# grosses dents triangulaires (y, haut ?, longueur, rayon, retrait)
TEETH = [(-2.72, True, 0.22, 0.1, 0.2), (-2.42, True, 0.2, 0.09, 0.16), (-2.12, True, 0.16, 0.08, 0.14),
         (-2.58, False, 0.17, 0.08, 0.2), (-2.25, False, 0.15, 0.07, 0.16)]
TONGUE_AT = (-2.3, 0.5, 0.32)
GAIT = {"walk_step": 0.5, "walk_lift": 0.22, "run_step": 0.85, "run_lift": 0.3, "hop": 0.42}
ATTACK = "charge"
ROAR_JAW = 36
IDLE_JAW = 16  # gueule ouverte en grand sourire au repos

# corde à linge : point d'attache sur chaque corne (fraction de la longueur), chaussette côté gauche (+X)
BROW = {"base": (0.45, -1.95, 3.15), "dir": (0.12, -0.75, 0.62), "L": 1.0, "r": 0.18}
LINE_T = 0.7
SOCK_X = 0.2
FRILL_C, FRILL_N = Vector((0, -0.9, 2.85)), Vector((0, -0.7, 0.72)).normalized()


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
    me = body.data  # BVH sur le maillage courant (Object.ray_cast peut lire un état évalué périmé)
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
def scallop(r, n, depth, k=3):
    """Cercle à n festons (creux arrondis) : rayon r - depth * |sin|^0.6 entre deux pointes."""
    pts = []
    for i in range(n * k):
        a = 2 * math.pi * i / (n * k)
        rr = r - depth * abs(math.sin(math.pi * i / k)) ** 0.6
        pts.append((rr * math.cos(a), rr * math.sin(a)))
    return pts


def brow_points():
    base = Vector(BROW["base"])
    d = Vector(BROW["dir"]).normalized()
    return base, d, base + d * BROW["L"] * LINE_T


def EXTRA_BONES():
    _b, _d, p = brow_points()
    top = Vector((SOCK_X, p.y, p.z))
    return [("Sock", top, top + Vector((0, 0, -0.45)), "Head")]


def paint(me, setp):
    stripes(me, setp, -0.45, 1.9, 0.4, 0.45, 1.5)  # rayures orange foncé sur le dos et la queue


def accessories(body, parts):
    claws(body, parts)
    # collerette : disque festonné (napperon crème) + dôme orange devant, inclinés vers l'arrière
    M = K.frame_from(FRILL_C, FRILL_N, up=(0, 0, 1))
    parts.append(Q.flat("Collerette", BELLY, "Head", scallop(1.5, 12, 0.17), M, 0.14))
    M2 = K.frame_from(FRILL_C + FRILL_N * 0.02, FRILL_N, up=(0, 0, 1))
    parts.append(K.xform(Q.P("Collerette2", "sphere", MAIN, "Head", scale=(1.26, 1.26, 0.2), u=12, v=4), M2))
    for i in range(12):  # petits trous du napperon
        a = 2 * math.pi * (i + 0.5) / 12
        if math.sin(a) < -0.35:
            continue
        p = M @ Vector((1.37 * math.cos(a), 1.37 * math.sin(a), 0.075))
        parts.append(Q.P("Trou", "sphere", ACCENT, "Head", loc=p, scale=(0.045, 0.045, 0.02), u=6, v=4))
    # 2 longues cornes frontales + petite corne nasale (crème)
    base, d, att = brow_points()
    ob = cone_at("Corne", BELLY, "Head", base, d, BROW["L"], BROW["r"], seg=6, tip=0.12)
    K.mirror_inplace(ob)
    parts.append(ob)
    nb, _n = top(body, -2.45)
    parts.append(cone_at("CorneNez", BELLY, "Head", nb - Vector((0, 0, 0.05)), (0, -0.45, 1), 0.42, 0.15,
                         up=(0, -1, 0)))
    # corde à linge entre les 2 cornes (légèrement affaissée au milieu : 2 segments)
    mid = Vector((0, att.y, att.z - 0.06))
    for a_, b_ in ((att, mid), (mid, Vector((-att.x, att.y, att.z)))):
        dv = b_ - a_
        parts.append(cone_at("Corde", BELLY, "Head", a_, dv, dv.length, 0.03, seg=5, up=(0, -1, 0), tip=1.0))
    # chaussette rayée (accent / crème) pendue sous la corde à x = SOCK_X, pointe du pied vers l'avant
    zt = att.z - 0.06 * (1 - SOCK_X / att.x) - 0.03
    y = att.y
    for i, slot in enumerate((BELLY, ACCENT, BELLY, ACCENT)):
        parts.append(Q.P("Chaussette", "cube", slot, "Sock", loc=(SOCK_X, y, zt - 0.06 - i * 0.1),
                         scale=(0.2, 0.09, 0.1)))
    parts.append(Q.P("Chaussette", "cube", BELLY, "Sock", loc=(SOCK_X, y - 0.07, zt - 0.44),
                     scale=(0.2, 0.24, 0.11)))
    parts.append(Q.P("Talon", "sphere", ACCENT, "Sock", loc=(SOCK_X, y - 0.19, zt - 0.44),
                     scale=(0.1, 0.05, 0.055), u=5, v=3))
    for dx in (-0.03, 0.03):  # pince à linge : 2 lamelles
        parts.append(Q.P("Pince", "cube", BACK, "Sock", loc=(SOCK_X + dx, y, zt + 0.01), scale=(0.025, 0.07, 0.16)))
    # petites pointes triangulaires : coudes (vers l'arrière-dehors) et 3 sur la croupe
    _ok, loc, nor, _i = body.closest_point_on_mesh(Vector((1.3, -0.3, 0.75)))
    ob = cone_at("PointeCoude", BELLY, "UpperLegF.S", loc - nor * 0.04, nor + Vector((0, 0.8, 0.3)), 0.24, 0.09)
    K.mirror_inplace(ob)
    parts.append(ob)
    for y_, b_ in ((0.2, "Spine1"), (0.55, "Hips"), (0.9, "Tail1")):
        loc, nor = top(body, y_)
        parts.append(cone_at("PointeDos", BELLY, b_, loc - nor * 0.04, nor + Vector((0, 0.6, 0)), 0.26, 0.11,
                             seg=5, up=(0, -1, 0)))


class Anims(Q.QuadAnims):
    def sock(self, swing, side=0.0):
        self.r("Sock", (R.X, swing), (R.Y, side))

    # Bon vivant, prêt à bondir : avant baissé, gueule ouverte ; secoue la tête (la chaussette balance),
    # gratte le sol de la patte avant droite
    def idle(self, t):
        self.base()
        br = R.S2(t, 2)
        shake = R.keys(t, [(0, 0), (0.1, 0), (0.14, 1), (0.42, 1), (0.48, 0), (1, 0)])
        sh = shake * math.sin(2 * math.pi * 6 * t)
        scr = self.scratch(t)
        self.hips(z=-0.04 + 0.015 * br, rz=1.5 * R.S2(t, 1), rx=4 + 2 * scr)
        self.spine(rx=-0.8 * br)
        self.neck(rx=-3 + 1.2 * br + 3 * scr, rz=4 * sh)
        self.r("Head", (R.X, -3 + 2 * R.S2(t, 2, 0.3) + 4 * scr), (R.Y, 14 * sh), (R.Z, 6 * sh))
        self.r("Jaw", (R.X, IDLE_JAW + 3 * br + 8 * shake))
        lag = shake * math.sin(2 * math.pi * 6 * t - 1.2)
        self.sock(4 * R.S2(t, 1), -30 * lag)
        self.tail(lambda i: ((R.Z, 10 * R.S2(t, 2, -0.08 * i) * (0.6 + shake)), (R.X, -6 + 1.5 * br)))

    def scratch(self, t):
        if 0.6 < t < 0.9:
            return math.sin(math.pi * (t - 0.6) / 0.3)
        return 0.0

    def feet_still(self, leg, t, a, b):
        if leg != "FR" or not 0.6 < t < 0.9:
            return a, b
        u = self.u
        k = self.scratch(t)
        q = math.sin(2 * math.pi * 3 * (t - 0.6) / 0.3)
        off = Vector((0, (0.18 * q + 0.05) * k * u, (0.14 + 0.06 * q) * k * u))
        return a + off, b + off

    # Célébration : sauts de joie en se cabrant, pattes avant levées qui battent l'air
    def celebrate_feet(self, leg, t, a, b):
        a, b = super().celebrate_feet(leg, t, a, b)
        if leg[0] != "F":
            return a, b
        joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
        ph = 0.0 if leg[1] == "L" else 0.5
        off = Vector((0, -0.08 * joy * self.u, (0.35 + 0.12 * R.S2(t, 3, ph)) * joy * self.u))
        return a + off, b + off

    def extra(self, clip, t):
        # chaussette : pendule en retard sur la tête
        if clip == "Walk":
            self.sock(10 * R.S2(t, 2, -0.15), 8 * R.S2(t, 1, -0.1))
            self.r("Jaw", (R.X, IDLE_JAW * 0.6))
        elif clip == "Run":
            self.sock(28 + 10 * R.S2(t, 2, -0.2), 10 * R.S2(t, 1))
            self.r("Jaw", (R.X, IDLE_JAW + 4))
        elif clip == "Attack":
            s = R.keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.58, 1), (0.88, 0), (1, 0)])
            tos = R.keys(t, [(0, 0), (0.4, 0), (0.5, 1), (0.66, 0.2), (0.9, 0), (1, 0)])
            self.sock(45 * s - 30 * tos, 15 * tos)
        elif clip == "Roar":
            r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
            self.sock(-20 * r, 18 * r * R.S2(t, 8))
        elif clip == "Celebrate":
            air, sq = self.hop(t)
            joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
            H = GAIT["hop"]
            self.hips(z=H * air - 0.1 * sq + 0.1 * joy, rx=-14 * joy - 4 * air + 3 * sq, rz=4 * R.S2(t, 2) * joy)
            self.neck(rx=6 * joy - 4 * air)
            self.sock(-25 * air + 10 * R.S2(t, 3), 25 * R.S2(t, 2))
        elif clip == "Death":
            f = R.keys(t, [(0, 0), (0.36, 0), (0.62, 1), (1, 1)])
            self.sock(10 * f, 70 * f)


S_ = sys.modules[__name__]
if __name__ == "__main__":
    Q.main(S_)
