# DINO DICE — Éclipsaurus (légendaire, théropode, taille 1,4) : modèle + rig + 7 animations + rendus.
# Version : 3 (style chibi + plaques)
# Référence : Dilophosaurus (2 fines crêtes parallèles en arc du nez au-dessus des yeux, cou fin en S,
# encoche dans la mâchoire supérieure, corps élancé, longue queue fine ; pas de collerette).
# Couche thématique : les 2 crêtes dessinent un croissant de lune doré ; anneau d'éclipse derrière la tête
# (disque noir + couronne dorée émissive + 8 rayons) qui tourne lentement ; corps noir, ventre crème,
# constellation d'étoiles dorées sur le dos ; étoile à 4 branches au bout de la queue.
# Personnalité : majestueux (lève le menton, l'anneau tourne lentement).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_eclipsaurus.py [-- model]
import math
import os
import sys

import bmesh
import bpy
from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401

import theropod_plaques as TP  # noqa: E402

# STYLE n°2 « plaques » + appui des pieds (local à ce build, helpers partagés intacts)
TP.apply(H.dd, R, lambda f: setattr(H, "split_sharp", f), H.split_sharp)

ID, NAME = "eclipsaurus", "Eclipsaurus"
HEIGHT = 5.6  # 4,0 x 1,4
COLORS = {"main": "#212121", "belly": "#FFF8E1", "accent": "#FFD54F", "glow": "#FFE57F", "back": "#2F2940"}
BG = (0.20, 0.24, 0.30)
NT = 5
LIP_SLOT = ACCENT  # trait de bouche doré (un trait sombre disparaîtrait sur le corps noir)
# Style chibi (MISE À JOUR STYLE) : tête énorme, corps court, cou un peu plus long en S (Dilophosaurus),
# longue queue fine, pattes courtes et épaisses.
NODES = [
    ("hanche", (0, 0.15, 1.42), 0.58, None),
    ("ventre", (0, -0.24, 1.48), 0.64, "hanche"),
    ("epaules", (0, -0.56, 1.74), 0.48, "ventre"),
    # cou fin en S
    ("cou", (0, -0.78, 2.14), 0.38, "epaules"),
    ("cou2", (0, -0.72, 2.56), 0.42, "cou"),
    ("crane", (0, -1.00, 3.06), 1.04, "cou2"),
    ("machoire", (0, -1.64, 2.84), 0.70, "crane"),
    ("museau", (0, -2.20, 2.74), 0.52, "machoire"),
    ("nez", (0, -2.66, 2.76), 0.42, "museau"),
    # longue queue fine
    ("queue1", (0, 0.70, 1.42), 0.44, "hanche"),
    ("queue2", (0, 1.22, 1.46), 0.33, "queue1"),
    ("queue3", (0, 1.74, 1.54), 0.24, "queue2"),
    ("queue4", (0, 2.24, 1.64), 0.17, "queue3"),
    ("queue5", (0, 2.70, 1.76), 0.12, "queue4"),
    ("queue6", (0, 3.10, 1.90), 0.08, "queue5"),
    ("bassin", (0.42, 0.10, 1.22), 0.48, None),
    ("cuisse", (0.52, -0.04, 0.94), 0.46, "bassin"),
    ("genou", (0.56, -0.22, 0.60), 0.27, "cuisse"),
    ("cheville", (0.55, 0.04, 0.30), 0.20, "genou"),
    ("pied", (0.55, -0.08, 0.15), 0.21, "cheville"),
    ("orteils", (0.55, -0.36, 0.12), 0.16, "pied"),
    ("epaule", (0.46, -0.72, 1.70), 0.17, None),
    ("coude", (0.68, -0.90, 1.46), 0.14, "epaule"),
    ("main", (0.70, -1.16, 1.48), 0.13, "coude"),
]
MOUTH_Y0 = -1.48
MOUTH_P = (0, -1.64, 2.62)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.05
BELLY_COS = 0.42
BELLY_MAX_X = 0.45
BACK_PAINT = (0.45, 0.5, 1.6, -2.0)
RING_C = Vector((0, 0.42, 3.45))
RING_N = Vector((0, -1.0, 0.25)).normalized()  # le disque regarde vers l'avant
EXTRA_BONES = [("Ring", RING_C, RING_C + RING_N * 0.5, "Head")]
CLAW = BELLY  # griffes crème


def spine_bones(y):
    return ["Spine2", "Neck1"] if y < -0.55 else ["Spine1", "Spine2"] if y < -0.15 else \
        ["Hips", "Spine1"] if y < 0.45 else ["Tail1", "Tail2"] if y < 1.2 else ["Tail2", "Tail3"]


def new_ob(B, name, bm, slot, gi):
    bmesh.ops.recalc_face_normals(bm, faces=bm.faces)
    me = bpy.data.meshes.new(name)
    bm.to_mesh(me)
    bm.free()
    H.dd.fill_color(me, B.C[slot])
    ob = bpy.data.objects.new(name, me)
    B.col.objects.link(ob)
    return B.add(B.tag(ob, gi))


def torus(B, name, slot, gi, center, normal, R0, r0, n=20, m=6):
    M = H.frame_from(center, normal)
    bm = bmesh.new()
    rings = []
    for i in range(n):
        a = 2 * math.pi * i / n
        ca, sa = math.cos(a), math.sin(a)
        rings.append([bm.verts.new(M @ Vector(((R0 + r0 * math.cos(b)) * ca, (R0 + r0 * math.cos(b)) * sa,
                                               r0 * math.sin(b))))
                      for b in (2 * math.pi * j / m for j in range(m))])
    for i in range(n):
        a, b = rings[i], rings[(i + 1) % n]
        for k in range(m):
            bm.faces.new((a[k], b[k], b[(k + 1) % m], a[(k + 1) % m]))
    return new_ob(B, name, bm, slot, gi)


def ribbon(B, name, slot, gi, inner, outer, side, thick):
    """Bande plate épaisse entre deux polylignes 3D (crête en croissant)."""
    bm = bmesh.new()
    off = Vector(side).normalized() * thick * 0.5
    lay = []
    for s in (-1, 1):
        lay.append(([bm.verts.new(p + off * s) for p in inner], [bm.verts.new(p + off * s) for p in outer]))
    n = len(inner)
    for (ia, oa) in lay:
        for i in range(n - 1):
            bm.faces.new((ia[i], ia[i + 1], oa[i + 1], oa[i]))
    (i0, o0), (i1, o1) = lay
    for a, b in ((i0, i1), (o0, o1)):
        for i in range(n - 1):
            bm.faces.new((a[i], a[i + 1], b[i + 1], b[i]))
    for k in (0, n - 1):
        bm.faces.new((i0[k], o0[k], o1[k], i1[k]))
    return new_ob(B, name, bm, slot, gi)


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.48, -1.72, 3.38), 0.40, look=(0.2, -1.0, 0.1), iris=ACCENT, iris_r=0.68, pupil_r=0.3,
           brow=(12, 0.84, 0.5), brow_slot=ACCENT, pupil_shape=[(0, 0.46), (0.14, 0), (0, -0.46), (-0.14, 0)])
    B.mouth_parts(n_up=6, n_lo=5, size=0.14)
    # encoche de la mâchoire supérieure : chevron doré de chaque côté de la lèvre
    e = min(B.mi["upper"], key=lambda v: abs(v.y + 2.05) + (0 if v.x > 0 else 9))
    loc, nor = B.surf(e + Vector((0.02, 0, 0.05)))
    ob = B.flat("Encoche", ACCENT, gh, [(-0.1, 0), (0, -0.1), (0.1, 0), (0.07, 0), (0, -0.055), (-0.07, 0)],
                H.frame_from(loc + nor * 0.01, nor, (0, 0, 1)), 0.03)
    H.mirror_inplace(ob)
    ob = B.P("Narine", "sphere", ACCENT, gh, loc=B.snap((0.14, -2.92, 3.02), -0.01), scale=(0.055, 0.04, 0.035),
             u=6, v=4)
    H.mirror_inplace(ob)
    # 2 crêtes fines parallèles en croissant de lune, du nez au-dessus des yeux (plaques à facettes)
    for sx in (1, -1):
        x = 0.24 * sx
        inner, outer = [], []
        n = 6
        for i in range(n):
            s = i / (n - 1)
            y = -2.45 + s * 1.25
            top, _n = B.top(y, x)
            h = 0.45 * math.sin(math.pi * (0.08 + 0.84 * s)) * (0.55 + 0.45 * s)
            inner.append(top + Vector((0, 0.06 * s, -0.04 + 0.3 * h)))
            outer.append(top + Vector((0, 0.10 * s, -0.05 + h + 0.05)))
        outer[-1] = outer[-1] + Vector((0, 0.14, 0.12))  # corne arrière du croissant
        ribbon(B, "Crete", ACCENT, gh, inner, outer, (1, 0, 0), 0.05)
    # anneau d'éclipse : disque noir + couronne émissive (facettes) + 8 rayons triangulaires
    gr = B.grp("rigid", "Ring")
    M = H.frame_from(RING_C, RING_N)
    B.P("Disque", "cone", DARK, gr, M=M, segments=12, r1=0.98, r2=0.98, depth=0.06)
    torus(B, "Couronne", GLOW, gr, RING_C + RING_N * 0.01, RING_N, 1.08, 0.1, n=12, m=4)
    loc, nor = B.surf(RING_C + Vector((0, -0.3, -0.1)))
    B.cone_to("Support", ACCENT, gh, loc - nor * 0.05, RING_C - loc, (RING_C - loc).length, 0.08, segments=6, r2=0.06)
    for k in range(8):
        a = 2 * math.pi * k / 8
        dl = Vector((math.cos(a), math.sin(a), 0))
        ray = [(-0.11, 0.0), (0.11, 0.0), (0.0, 0.32)]
        Rm = Matrix.Rotation(a - math.pi / 2, 4, "Z")
        B.flat("Rayon%d" % k, GLOW, gr, ray, M @ Matrix.Translation(dl * 1.13) @ Rm, 0.05)
    # plaques dorsales : trapèzes biseautés violet nuit à liseré doré, la plus grande porte 2 x 2 plots dorés
    for k, (y, w, l) in enumerate(((-0.38, 0.40, 0.30), (0.02, 0.46, 0.34), (0.44, 0.40, 0.30), (0.86, 0.32, 0.26),
                                   (1.28, 0.24, 0.22))):
        loc, nor = B.top(y)
        g = B.grp("dist", spine_bones(y))
        trap = [(-w / 2, -l / 2), (w / 2, -l / 2), (w * 0.36, l / 2), (-w * 0.36, l / 2)]
        B.flat("Liseré%d" % k, ACCENT, g, [(x * 1.18, y_ * 1.18) for x, y_ in trap],
               H.frame_from(loc + nor * 0.01, nor, (0, -1, 0)), 0.05)
        B.flat("Plaque%d" % k, BACK, g, trap, H.frame_from(loc + nor * 0.05, nor, (0, -1, 0)), 0.06)
        if k == 1:
            Mp = H.frame_from(loc + nor * 0.08, nor, (0, -1, 0))
            for i in (-1, 1):
                for j in (-1, 1):
                    p = Mp @ Vector((i * 0.09, j * 0.075, 0.02))
                    B.cone_to("Plot", ACCENT, g, p, nor, 0.05, 0.05, segments=8, r2=0.05)
    # constellation : étoiles dorées sur les flancs et la queue
    for k, (x, y, z) in enumerate(((0.45, -0.25, 1.75), (0.5, 0.25, 1.6), (0.35, 0.9, 1.6), (0.22, 1.6, 1.7))):
        loc, nor = B.surf((x, y, z))
        ob = B.star("Etoile%d" % k, ACCENT, B.grp("dist", spine_bones(y)), loc + nor * 0.005, nor,
                    (0.11, 0.08, 0.1, 0.08)[k], rot=0.3 * k, thick=0.03)
        H.mirror_inplace(ob)
    # pointes dorées aux coudes
    e = B.pos["coude"]
    ob = B.cone_to("PointeCoude", ACCENT, B.grp("rigid", "UpperArm.S"), e + Vector((0.03, 0.08, 0.02)),
                   (0.3, 1.0, 0.4), 0.22, 0.07, segments=4)
    H.mirror_inplace(ob)
    # étoile à 4 branches au bout de la queue
    gt = B.grp("rigid", "Tail5")
    tp = B.pos["queue6"]
    B.star("EtoileQueue", GLOW, gt, tp + Vector((0, 0.16, 0.03)), (1, 0, 0), 0.22, thick=0.06)
    B.hands(n=3, length=0.26, r=0.09, claw=CLAW, spread=30, claw_len=0.18, down=0.5)
    B.feet(n=3, length=0.32, r=0.12, claw=CLAW, spread=32, back=0.24, claw_len=0.18)


class Anims(H.Anims):
    SPIN = {"Idle": 45, "Walk": 0, "Run": 0, "Attack": 45, "Roar": 90, "Celebrate": 180, "Death": 0}

    def extra(self, clip, t):
        self.r("Ring", (R.Y, self.SPIN[clip] * t))

    # Majestueux : lève lentement le menton, regard de côté, hanches droites ; l'anneau tourne de 45° par boucle
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        chin = R.keys(t, [(0, 0.2), (0.25, 1), (0.6, 1), (0.85, 0.2), (1, 0.2)])
        look = R.keys(t, [(0, 0), (0.30, 0), (0.42, 1), (0.58, 1), (0.70, 0), (1, 0)])
        self.hips(z=-0.02 + 0.02 * br, rx=-3 * chin)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -1.5 * br - 2 * chin))
        H.rig.rot(P["Neck1"], (R.X, -6 * chin + 2 * br))
        H.rig.rot(P["Neck2"], (R.X, -4 * chin), (R.Z, 8 * look))
        H.rig.rot(P["Head"], (R.X, -14 * chin), (R.Z, 12 * look), (R.Y, -6 * look))
        self.tail(lambda i: ((R.Z, 6 * R.S2(t, 1, -0.08 * i)), (R.X, 2 * R.S2(t, 2, -0.1 * i) - 2 * chin)))
        H.rig.rot(P["Jaw"], (R.X, 8 + 6 * look))
        for side, sx in H.SIDES:  # bras levés, griffes en avant (prêt à bondir), immobiles et dignes
            H.rig.rot(P["UpperArm." + side], (R.X, -50 - 6 * chin - 3 * br), (R.Y, -sx * 25))
            H.rig.rot(P["LowerArm." + side], (R.X, -15 + 3 * br))
        self.extra("Idle", t)


if __name__ == "__main__":
    H.run(sys.modules[__name__])
