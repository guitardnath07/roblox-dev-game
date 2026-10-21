# DINO DICE — Magmaroi (mythique, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi + « plaques » : grosse tête, gros yeux, griffes crème, facettes nettes)
# Référence réelle : Regaliceratops peterhewsi (cératopsien « royal » : collerette courte et large en demi-cercle
# bordée de grosses plaques en pentagone = couronne, grande corne nasale, petites cornes sourcilières, tête haute).
# Couche thématique : 7 pointes de couronne en lave refroidie (pointe émissive), corne nasale en obsidienne
# facettée, gemme de lave au centre de la collerette, cape de roche à facettes sur les épaules (tranche de magma),
# plaques de basalte sur le dos avec veines de magma, port de tête fier.
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_magmaroi.py [-- model]

import math
import os
import sys

import bmesh
import bpy
from mathutils import Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
import build_volcanokeros as V  # noqa: E402  (rubans de fissures émissives)
from quadruped_helpers import K, R, MAIN, BELLY, GLOW, BACK, WHITE  # noqa: E402

ID, NAME = "magmaroi", "Magmaroi"
HEIGHT = 3.4 * 1.75
COLORS = {"main": "#6B6262", "belly": "#F4511E", "accent": "#FF6D00", "glow": "#FFAB00", "back": "#262222"}

NODES = [
    ("bassin", (0, 0.55, 1.65), 1.08, None),
    ("dos", (0, 0.0, 1.78), 1.18, "bassin"),
    ("poitrail", (0, -0.5, 1.78), 1.08, "dos"),
    ("cou1", (0, -0.85, 2.1), 0.9, "poitrail"),
    ("cou2", (0, -1.1, 2.45), 0.95, "cou1"),
    ("crane", (0, -1.5, 2.95), 1.32, "cou2"),
    ("machoire", (0, -2.05, 2.65), 1.08, "crane"),
    ("museau", (0, -2.6, 2.47), 0.8, "machoire"),
    ("nez", (0, -3.0, 2.4), 0.52, "museau"),
    ("queue1", (0, 1.2, 1.48), 0.68, "bassin"),
    ("queue2", (0, 1.72, 1.32), 0.45, "queue1"),
    ("queue3", (0, 2.1, 1.3), 0.28, "queue2"),
    ("queue4", (0, 2.35, 1.38), 0.14, "queue3"),
    ("hanche", (0.82, 0.55, 1.12), 0.58, None),
    ("genou", (0.84, 0.35, 0.74), 0.54, "hanche"),
    ("cheville", (0.84, 0.52, 0.4), 0.52, "genou"),
    ("pied_ar", (0.84, 0.46, 0.3), 0.52, "cheville"),
    ("orteil_ar", (0.84, 0.2, 0.27), 0.42, "pied_ar"),
    ("epaule", (0.84, -0.48, 1.14), 0.58, None),
    ("coude", (0.86, -0.33, 0.74), 0.54, "epaule"),
    ("poignet", (0.86, -0.5, 0.4), 0.52, "coude"),
    ("pied_av", (0.86, -0.56, 0.3), 0.52, "poignet"),
    ("orteil_av", (0.86, -0.84, 0.27), 0.42, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.12, WHITE
BELLY_COS, BELLY_MAXX = 0.5, 0.85
BACK_NZ, BACK_ZMIN, BACK_MAXX = 0.6, 2.2, 1.3
SIGMA = 0.12
MOUTH = {"p": (0, -2.73, 2.3), "n": (0, -0.1, 1), "y0": -1.73, "gap": 0.07, "zmin": 1.5,
         "smile": 0.2, "smile_y": -2.53, "shell": 0.5, "shell_depth": 0.08}
# paupières mi-closes : regard hautain
EYE = {"target": (0.7, -1.73, 3.55), "size": 0.52, "look": (-0.1, -1.5, 0.12), "iris": 0.64,
       "lid": {"close": -52, "tilt": -10, "bone": "Head", "slot": BACK}}
NOSTRILS = [((0.2, -3.53, 2.67), (0.08, 0.06, 0.06))]
TEETH = V.grin_teeth(-2.93, -2.08, 5, 0.24, 0.09, inset_front=0.12)
TONGUE_AT = (-2.38, 0.45, 0.3)
GAIT = {"walk_step": 0.45, "walk_lift": 0.22, "run_step": 0.65, "run_lift": 0.28, "hop": 0.35, "rear": 0.75}
ATTACK = "stomp"
ROAR_JAW = 30
SPINE = ["Hips", "Spine1", "Spine2", "Spine3"]


def pentagon(r):
    """Plaque de couronne : pentagone pointe en haut (+Y local)."""
    return [(r * math.cos(math.pi / 2 + 2 * math.pi * i / 5), r * math.sin(math.pi / 2 + 2 * math.pi * i / 5))
            for i in range(5)]


def cape(body, slot_top, slot_rim):
    """Cape de roche à facettes drapée des épaules à mi-dos : dalle épaisse (grille grossière collée au corps),
    tranche (épaisseur) en magma ; bord arrière en dents."""
    rows = [-0.78, -0.5, -0.22, 0.06, 0.32]
    angs = [-74, -50, -25, 0, 25, 50, 74]
    bm = bmesh.new()
    top, bot = [], []
    for j, y in enumerate(rows):
        rt, rb = [], []
        for i, a in enumerate(angs):
            yy = y + (0.18 if (j == len(rows) - 1 and i % 2 == 0) else 0.0)
            if i in (0, len(angs) - 1) and j % 2:  # ourlet en dents sur les flancs
                a += 16 * (1 if a > 0 else -1)
            d = Vector((math.sin(math.radians(a)), 0, math.cos(math.radians(a))))
            c = Vector((0, yy, 1.75))
            ok, loc, nor, _ = body.ray_cast(c + d * 5, -d)
            if not ok:
                loc, nor = c + d * 1.2, d
            lift = 0.1 + 0.05 * (1 - abs(a) / 78)
            rt.append(bm.verts.new(loc + d * (lift + 0.28)))
            rb.append(bm.verts.new(loc + d * 0.02))
        top.append(rt)
        bot.append(rb)
    tf, sf = [], []
    for j in range(len(rows) - 1):
        for i in range(len(angs) - 1):
            tf.append(bm.faces.new((top[j][i], top[j][i + 1], top[j + 1][i + 1], top[j + 1][i])))
            bm.faces.new((bot[j][i], bot[j + 1][i], bot[j + 1][i + 1], bot[j][i + 1]))
    border = [top[0][i] for i in range(len(angs))] + [top[j][-1] for j in range(1, len(rows))] + \
        [top[-1][i] for i in range(len(angs) - 2, -1, -1)] + [top[j][0] for j in range(len(rows) - 2, 0, -1)]
    bborder = [bot[0][i] for i in range(len(angs))] + [bot[j][-1] for j in range(1, len(rows))] + \
        [bot[-1][i] for i in range(len(angs) - 2, -1, -1)] + [bot[j][0] for j in range(len(rows) - 2, 0, -1)]
    n = len(border)
    for k in range(n):
        sf.append(bm.faces.new((border[k], bborder[k], bborder[(k + 1) % n], border[(k + 1) % n])))
    bmesh.ops.recalc_face_normals(bm, faces=bm.faces[:])
    tri = bmesh.ops.triangulate(bm, faces=bm.faces[:])
    del tri
    me = bpy.data.meshes.new("Cape")
    bm.to_mesh(me)
    bm.free()
    Q.dd.fill_color(me, K.C[slot_top])
    # tranche (faces quasi perpendiculaires au corps) = liseré de magma
    attr = me.color_attributes[Q.dd.COLOR_ATTR]
    for p in me.polygons:
        c = p.center
        radial = Vector((c.x, 0, c.z - 1.75)).normalized()
        if abs(p.normal.dot(radial)) < 0.6:
            for li in p.loop_indices:
                attr.data[li].color_srgb = K.C[slot_rim]
    ob = bpy.data.objects.new("Cape", me)
    K.COL.objects.link(ob)
    return K.tag(ob, Q.gid(["Spine1", "Spine2", "Spine3", "Neck1"]))


def accessories(body, parts):
    # --- collerette-couronne : demi-disque large et court derrière le crâne
    cr = Q.node("crane")
    nrm = Vector((0, -0.95, 0.3)).normalized()
    Mf = K.frame_from(cr + Vector((0, 0.72, 0.3)), nrm, up=(0, 0.25, 1))
    pts = [(1.35 * math.cos(math.pi * i / 12), 0.1 + 0.95 * math.sin(math.pi * i / 12)) for i in range(13)]
    pts += [(-0.9, -0.35), (0.9, -0.35)][::-1]
    parts.append(Q.flat("Collerette", BELLY, "Head", pts, Mf, 0.22))
    # 7 pointes de couronne (pentagones de lave refroidie) + pointe émissive
    for i in range(7):
        a = math.pi * (0.08 + 0.84 * i / 6)
        c = Vector((1.4 * math.cos(a), 0.1 + 1.02 * math.sin(a), 0.0))
        dirv = Vector((math.cos(a) * 1.25, math.sin(a) * 0.85, 0)).normalized()
        ang = math.atan2(dirv.y, dirv.x) - math.pi / 2
        rot = [(x * math.cos(ang) - y * math.sin(ang), x * math.sin(ang) + y * math.cos(ang))
               for x, y in pentagon(0.3)]
        rot = [(c.x + x, c.y + y) for x, y in rot]
        parts.append(Q.flat("Couronne", MAIN, "Head", rot, Mf, 0.2))
        tipc = c + Vector((dirv.x, dirv.y, 0)) * 0.36
        V.spike(parts, Mf @ (c + Vector((dirv.x, dirv.y, 0)) * 0.2), Mf.to_3x3() @ Vector((dirv.x, dirv.y, 0)), 0.3,
                0.1, GLOW, "Head")
    # gemme de lave (octaèdre) au centre de la collerette, sur sa face avant, sertie dans un anneau
    gc = Mf @ Vector((0, 0.55, 0.16))
    parts.append(K.xform(Q.P("Gemme", "sphere", GLOW, "Head", scale=(0.17, 0.17, 0.2), u=4, v=2),
                         K.frame_from(gc, nrm, up=(0, 0, 1))))
    parts.append(K.xform(Q.P("Serti", "cone", BACK, "Head", segments=8, r1=0.25, r2=0.22, depth=0.08),
                         K.frame_from(Mf @ Vector((0, 0.55, 0.1)), nrm, up=(0, 0, 1))))
    # grande corne nasale en obsidienne facettée (5 pans) + 2 petites cornes sourcilières
    b = Q.dd.snap(body, (0, -2.72, 3.25), -0.06)
    M = K.frame_from(b, Vector((0, -0.45, 1)), up=(0, -1, 0))
    parts.append(K.xform(Q.P("CorneNez", "cone", BACK, "Head", loc=(0, 0, 0.36), segments=5, r1=0.24, r2=0.0,
                             depth=0.75), M))
    for s in (1, -1):
        b = Q.dd.snap(body, (s * 0.5, -1.6, 4.35), -0.05)
        M = K.frame_from(b, Vector((s * 0.4, -0.3, 1)), up=(0, -1, 0))
        parts.append(K.xform(Q.P("CorneSourcil", "cone", BACK, "Head", loc=(0, 0, 0.15), segments=5, r1=0.11,
                                 r2=0.0, depth=0.3), M))
    # bec
    tip = Q.dd.snap(body, (0, -3.95, 2.45), -0.12)
    M = K.frame_from(tip, Vector((0, -1, -0.55)), up=(0, 0, 1))
    parts.append(K.xform(Q.P("Bec", "cone", BACK, "Head", loc=(0, 0, 0.12), scale=(1, 0.75, 1), segments=8,
                             r1=0.32, r2=0.0, depth=0.45), M))
    for s in (1, -1):  # naseaux rougeoyants
        parts.append(Q.P("Braise", "sphere", GLOW, "Head", loc=Q.dd.snap(body, (s * 0.2, -3.53, 2.67), -0.005),
                         scale=(0.055, 0.04, 0.04), u=6, v=4))
    # --- veines de magma entre plaques de basalte sur les flancs (réseau en zigzag)
    up = [(0.45, 2.05), (0.75, 1.85), (1.05, 2.0), (1.35, 1.7)]
    lo = [(-0.6, 1.05), (-0.2, 0.95), (0.2, 1.1), (0.6, 0.95), (1.0, 1.15), (1.35, 1.1)]
    segs = list(zip(up, up[1:])) + list(zip(lo, lo[1:]))
    segs += [((0.75, 1.85), (0.6, 0.95)), ((1.05, 2.0), (1.0, 1.15)), ((0.45, 2.05), (0.2, 1.1))]
    parts.append(V.crack_strips(body, segs, w=0.045))
    # --- cape de roche
    parts.append(cape(body, BACK, GLOW))
    # --- plaques de basalte (hexagones) sur le reste du dos, posées sur une veine de magma un peu plus large
    for k, (x, y) in enumerate([(0.3, 0.55), (-0.3, 0.72), (0.26, 0.98), (-0.24, 1.2), (0.0, 1.45)]):
        ok, loc, nor, _ = body.ray_cast(Vector((x, y, 6.0)), Vector((0, 0, -1)))
        if not ok:
            continue
        r = 0.3 - 0.03 * k
        M = K.frame_from(loc, nor, up=(0, -1, 0))
        parts.append(K.xform(Q.P("Veine", "cone", GLOW, SPINE, loc=(0, 0, 0.02), segments=6, r1=r * 1.2,
                                 r2=r * 1.14, depth=0.06), M))
        parts.append(K.xform(Q.P("Plaque", "cone", BACK, SPINE, loc=(0, 0, 0.07), segments=6, r1=r, r2=r * 0.86,
                                 depth=0.12), M))
    # pointes de basalte le long de la queue
    for k, key in enumerate(TAIL[:3]):
        p = Q.node(key)
        r = Q.radius(key)
        ok, loc, nor, _ = body.ray_cast(Vector((0, p.y, p.z + 3)), Vector((0, 0, -1)))
        if ok:
            M = K.frame_from(loc, nor + Vector((0, 0.5, 0)), up=(0, -1, 0))
            parts.append(K.xform(Q.P("Epine", "cone", BACK, ["Tail%d" % (k + 1), "Tail%d" % (k + 2)],
                                     loc=(0, 0, r * 0.3), segments=4, r1=r * 0.4, r2=0.0, depth=r * 0.8), M))
    # bracelets de magma refroidi aux chevilles
    for keys, fb in ((Q.HIND_NODES, "B"), (Q.FRONT_NODES, "F")):
        c = Q.node(keys[2])
        r = Q.radius(keys[2])
        parts.append(Q.P("Bracelet", "cone", BACK, "LowerLeg%s.S" % fb, loc=(c.x, c.y, c.z + 0.12), mirror_x=True,
                         segments=8, r1=r * 1.08, r2=r * 1.02, depth=0.14))
        parts.append(Q.P("BraceletLave", "cone", GLOW, "LowerLeg%s.S" % fb, loc=(c.x, c.y, c.z + 0.215),
                         mirror_x=True, segments=8, r1=r * 1.02, r2=r * 0.98, depth=0.05))
    V.elbow_spikes(parts, 0.26, 0.11, BACK)


class Anims(V.ChibiAnims):
    # Royal et capricieux : lève le nez, frappe le sol de la patte avant droite, attend (regard en coin)
    STAMP = [0.42, 0.5, 0.58]

    def stamp(self, t):
        """Coup de patte : 1 au moment où le pied frappe le sol."""
        return sum(math.exp(-((t - c - 0.08) / 0.015) ** 2) for c in self.STAMP)

    def lift(self, t):
        return sum(math.sin(math.pi * (t - c) / 0.08) for c in self.STAMP if c < t < c + 0.08)

    def idle(self, t):
        self.base()
        br = R.S2(t, 2)
        nose = R.keys(t, [(0, 0), (0.1, 0), (0.22, 1), (0.36, 1), (0.66, 1), (0.76, 0.3), (0.9, 0.3), (1, 0)])
        side = R.keys(t, [(0, 0), (0.66, 0), (0.74, 1), (0.9, 1), (1, 0)])
        st = self.stamp(t)
        c = self.crouch(t, 0.6 * (1 - nose))  # prêt à bondir… sauf quand il prend la pose royale
        self.hips(z=c["hz"] + 0.012 * br - 0.02 * st, rz=1 * R.S2(t, 1), rx=c["hrx"])
        self.spine(rx=-0.8 * br)
        self.neck(rx=c["nrx"] + 1.2 * br - 9 * nose, rz=-5 * side)
        self.r("Head", (R.X, c["headx"] - 10 * nose + 2 * st), (R.Z, -10 * side), (R.Y, 5 * side))
        self.r("Jaw", (R.X, 12 - 6 * nose))  # sourire en coin, bouche plus fermée quand il snobe
        self.tail(lambda i: ((R.Z, 4 * R.S2(t, 1, -0.08 * i) + 8 * st), (R.X, c["tailx"] - 3 * nose)))

    def feet_still(self, leg, t, a, b):
        if leg != "FR":
            return a, b
        h = 0.3 * self.lift(t) * self.u
        off = Vector((0, -0.04 * h, h))
        return a + off, b + off + Vector((0, 0, 0.3 * h))


S_ = sys.modules[__name__]
if __name__ == "__main__":
    V.lego_patch()
    Q.main(S_)
