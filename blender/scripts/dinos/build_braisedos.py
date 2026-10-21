# DINO DICE — Braisedos (rare, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi « plaques » : tête énorme, gueule ouverte, grosses griffes crème, flammes aux pattes,
# corps à facettes planes)
# Référence réelle : Stegosaurus (dos voûté, point haut au-dessus des hanches, pattes avant plus courtes,
# plaques dorsales en 2 rangées ALTERNÉES ; queue réduite à 2 pointes pour la lisibilité).
# Couche thématique : 9 plaques en losange = cœur charbon (back) + liseré braise (glow, émissif en jeu) ;
# 3 bûches croisées sous la gorge ; 1 guimauve plantée sur la pointe de queue gauche ; flammes aux 4 pattes.
# Pas de marques sombres sur le corps (on ne reprend pas les marquages du perso de la référence de style).
# Les étincelles du souffle (Idle) sont prévues en particules Roblox côté client (pas de mesh, pas d'os scale).
#   python3 bb.py blender/scripts/dinos/build_braisedos.py [-- model]

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

ID, NAME = "braisedos", "Braisedos"
HEIGHT = 3.4 * 1.15
# fiche : #C62828 / #4E342E / #FFB300 ; le charbon (#4E342E) passe en « back » (cœurs des plaques),
# le ventre devient crème chaud (style : ventre clair)
COLORS = {"main": "#D32F2F", "belly": "#FFD8A0", "accent": "#FFB300", "glow": "#FF6D00", "back": "#4E342E"}

NODES = [
    ("bassin", (0, 0.3, 1.45), 0.95, None),
    ("dos", (0, -0.1, 1.42), 0.95, "bassin"),
    ("poitrail", (0, -0.45, 1.3), 0.85, "dos"),
    ("cou1", (0, -0.78, 1.35), 0.75, "poitrail"),
    ("cou2", (0, -1.02, 1.5), 0.85, "cou1"),
    ("crane", (0, -1.4, 1.8), 1.15, "cou2"),
    ("machoire", (0, -1.9, 1.6), 0.98, "crane"),
    ("museau", (0, -2.35, 1.52), 0.78, "machoire"),
    ("nez", (0, -2.7, 1.5), 0.52, "museau"),
    ("queue1", (0, 0.95, 1.35), 0.5, "bassin"),
    ("queue2", (0, 1.4, 1.3), 0.34, "queue1"),
    ("queue3", (0, 1.8, 1.32), 0.22, "queue2"),
    ("queue4", (0, 2.1, 1.4), 0.12, "queue3"),
    ("hanche", (0.58, 0.35, 0.95), 0.5, None),
    ("genou", (0.7, 0.25, 0.6), 0.47, "hanche"),
    ("cheville", (0.73, 0.38, 0.36), 0.43, "genou"),
    ("pied_ar", (0.73, 0.32, 0.28), 0.43, "cheville"),
    ("orteil_ar", (0.73, 0.06, 0.25), 0.35, "pied_ar"),
    ("epaule", (0.55, -0.45, 0.85), 0.45, None),
    ("coude", (0.68, -0.42, 0.55), 0.43, "epaule"),
    ("poignet", (0.71, -0.55, 0.34), 0.41, "coude"),
    ("pied_av", (0.71, -0.62, 0.27), 0.41, "poignet"),
    ("orteil_av", (0.71, -0.86, 0.24), 0.33, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.1, WHITE  # ongles du helper retirés : griffes plus bas
BELLY_COS, BELLY_MAXX = 0.5, 0.8
BACK_NZ, BACK_ZMIN, BACK_MAXX = 0.7, 9.0, 0.0  # pas de dos uni
SIGMA = 0.12
MOUTH = {"p": (0, -2.2, 1.31), "n": (0, -0.1, 1), "y0": -1.55, "gap": 0.03, "zmin": 0.65,
         "smile": 0.22, "smile_y": -2.15, "shell": 0.5, "shell_depth": 0.06}
EYE = {"target": (0.7, -1.67, 2.27), "size": 0.48, "iris": 0.7, "look": (-0.1, -1.5, 0.05), "iris_slot": GLOW,
       "lid": {"close": -72, "tilt": -6, "slot": MAIN}}
NOSTRILS = [((0.17, -2.95, 1.75), (0.06, 0.05, 0.045))]
TEETH = [(-2.37, True, 0.22, 0.1, 0.2), (-2.07, True, 0.2, 0.09, 0.16), (-1.77, True, 0.16, 0.08, 0.14),
         (-2.23, False, 0.17, 0.08, 0.2), (-1.9, False, 0.15, 0.07, 0.16)]
TONGUE_AT = (-1.95, 0.5, 0.32)
GAIT = {"walk_step": 0.5, "walk_lift": 0.22, "run_step": 0.85, "run_lift": 0.3, "hop": 0.42}
ATTACK = "tail"
ROAR_JAW = 36
IDLE_JAW = 14

# plaques : (y, hauteur, largeur, côté) ; la plus grande au-dessus des hanches, alternées gauche/droite
PLATES = [(-0.72, 0.4, 0.34, -1), (-0.48, 0.55, 0.44, 1), (-0.22, 0.72, 0.56, -1), (0.04, 0.84, 0.66, 1),
          (0.3, 0.92, 0.72, -1), (0.57, 0.8, 0.62, 1), (0.84, 0.62, 0.5, -1), (1.1, 0.46, 0.38, 1),
          (1.36, 0.32, 0.28, -1)]
FLAME = [(-0.26, 0), (0.26, 0), (0.32, 0.22), (0.22, 0.58), (0.12, 0.3), (0.02, 0.8), (-0.08, 0.32),
         (-0.2, 0.52), (-0.3, 0.2)]


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
def diamond(w, h):
    return [(0, -0.15), (w / 2, h * 0.42), (0, h), (-w / 2, h * 0.42)]


def plate_bone(y):
    for lim, b in ((-0.55, "Spine3"), (-0.25, "Spine2"), (0.1, "Spine1"), (0.75, "Hips"), (1.2, "Tail1")):
        if y < lim:
            return b
    return "Tail2"


def accessories(body, parts):
    claws(body, parts)
    for y, h, w, side in PLATES:
        loc, _n = top(body, y)
        up = Vector((side * 0.22, 0, 1)).normalized()
        M = Matrix((Vector((0, 1, 0)), up, Vector((0, 1, 0)).cross(up))).transposed().to_4x4()
        M.translation = Vector((side * 0.13, loc.y, loc.z - 0.08))
        b = plate_bone(y)
        parts.append(Q.flat("Plaque", GLOW, b, diamond(w, h), M, 0.08))
        parts.append(Q.flat("PlaqueCoeur", BACK, b, diamond(w * 0.7, h * 0.78), M @ Matrix.Translation((0, h * 0.07, 0)),
                            0.14))
    # 2 pointes de queue (en V, vers l'arrière-haut-dehors) + guimauve sur la gauche (+X)
    tip = Vector((0, 1.95, 1.42))
    for sx in (1, -1):
        d = Vector((sx * 0.75, 0.45, 0.55))
        base = tip + Vector((sx * 0.08, 0, 0.04))
        parts.append(cone_at("Pointe", WHITE, "Tail4", base, d, 0.6, 0.12, seg=5, up=(0, 1, 0), tip=0.05))
        if sx > 0:
            Mt = K.frame_from(base, d.normalized(), up=(0, 1, 0))
            parts.append(K.xform(Q.P("Guimauve", "cone", WHITE, "Tail4", loc=(0, 0, 0.36), segments=6, r1=0.1,
                                     r2=0.1, depth=0.15), Mt))
    # 3 bûches croisées sous la gorge (bois = back), bouts braise
    for ang, dz in ((25, 0.0), (-25, 0.0), (90, 0.1)):
        a = math.radians(ang)
        d = Vector((math.cos(a), math.sin(a) * 0.6, 0)).normalized()
        Mb = K.frame_from(Vector((0, -1.2, 0.6 + dz)), d, up=(0, 0, 1))
        parts.append(K.xform(Q.P("Buche", "cone", BACK, "Neck2", segments=6, r1=0.09, r2=0.09, depth=0.62), Mb))
        for e in (-1, 1):
            parts.append(K.xform(Q.P("BucheBout", "cone", GLOW, "Neck2", loc=(0, 0, e * 0.313), segments=6,
                                     r1=0.075, r2=0.075, depth=0.01), Mb))
    # flammes aux 4 pattes : 2 languettes plates (braise + ambre) sur le côté extérieur de chaque pied
    for keys, fb, k in ((Q.HIND_NODES, "B", 1.0), (Q.FRONT_NODES, "F", 0.85)):
        c = Q.node(keys[2])
        Mf = Matrix((Vector((0, -1, 0)), Vector((0, 0, 1)), Vector((1, 0, 0)))).transposed().to_4x4()
        Mf.translation = Vector((c.x + Q.radius(keys[2]) * 0.75, c.y + 0.05, 0.3))
        Mf = Mf @ Matrix.Diagonal((k, k, 1, 1))
        for slot, sc, dz in ((GLOW, 1.0, 0.0), (ACCENT, 0.62, 0.05)):
            ob = Q.flat("Flamme", slot, "Foot%s.S" % fb, [(u * sc, v * sc) for u, v in FLAME],
                        Mf @ Matrix.Translation((0, 0.02, dz)), 0.05)
            K.mirror_inplace(ob)
            parts.append(ob)
    # petites pointes triangulaires sur les coudes
    _ok, loc, nor, _i = body.closest_point_on_mesh(Vector((1.3, -0.3, 0.7)))
    ob = cone_at("PointeCoude", BELLY, "UpperLegF.S", loc - nor * 0.04, nor + Vector((0, 0.8, 0.3)), 0.22, 0.08)
    K.mirror_inplace(ob)
    parts.append(ob)


class Anims(Q.QuadAnims):
    # Chaleureux, prêt à bondir : s'étire comme un chat (avant bas, croupe haute), puis souffle (gueule ouverte)
    def stretch(self, t):
        return R.keys(t, [(0, 0), (0.15, 0), (0.3, 1), (0.5, 1), (0.62, 0), (1, 0)])

    def idle(self, t):
        self.base()
        st = self.stretch(t)
        blow = R.keys(t, [(0, 0), (0.66, 0), (0.72, 1), (0.86, 1), (0.92, 0), (1, 0)])
        yawn = R.keys(t, [(0, 0), (0.25, 0), (0.35, 1), (0.45, 0), (1, 0)])
        br = R.S2(t, 2) * (1 - st)
        self.hips(z=0.015 * br - 0.04 * st, rx=3 + 7 * st)
        self.spine(rx=-0.8 * br + 3 * st)
        self.neck(rx=-3 + 1.2 * br - 9 * st - 5 * blow)
        self.r("Head", (R.X, -2 + 2 * R.S2(t, 2, 0.3) - 8 * st - 6 * blow), (R.Y, 6 * st * R.S2(t, 1)))
        self.r("Jaw", (R.X, IDLE_JAW + 2 * br + 14 * yawn + 8 * blow))
        self.tail(lambda i: ((R.Z, 7 * R.S2(t, 1, -0.08 * i) * (1 - st)), (R.X, -5 - 6 * st + 1.5 * br)))

    def feet_still(self, leg, t, a, b):
        if leg[0] != "F":
            return a, b
        st = self.stretch(t)
        off = Vector((0, -0.3 * st * self.u, 0))  # pattes avant tendues vers l'avant
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
            self.r("Jaw", (R.X, IDLE_JAW * 0.6))
        elif clip == "Run":
            self.r("Jaw", (R.X, IDLE_JAW + 4))
        elif clip == "Roar":  # grosse tête basse : anticipation réduite pour ne pas piquer du nez dans le sol
            a = R.keys(t, [(0, 0), (0.16, 1), (0.27, 0), (1, 0)])
            r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
            sh = r * R.S2(t, 8)
            self.neck(rx=1 * a - 10 * r)
            self.r("Head", (R.X, 3 * a - 14 * r + 3 * sh), (R.Z, 4 * sh))
        elif clip == "Celebrate":
            air, sq = self.hop(t)
            joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
            self.hips(z=GAIT["hop"] * air - 0.1 * sq + 0.1 * joy, rx=-14 * joy - 4 * air + 3 * sq,
                      rz=4 * R.S2(t, 2) * joy)
            self.neck(rx=6 * joy - 4 * air)


S_ = sys.modules[__name__]
if __name__ == "__main__":
    Q.main(S_)
