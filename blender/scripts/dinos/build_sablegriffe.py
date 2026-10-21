# DINO DICE — Sablegriffe (peu commun, théropode, taille 1,0) : modèle + rig + 7 animations + rendus.
# Version : 3 (style chibi + plaques)
# Référence : Mononykus (bras minuscules terminés par UNE grosse griffe, longues pattes fines de coureur,
# petite tête étroite — grossie ici, museau carré — et longue queue).
# Couche thématique : chaque griffe = pelle de plage (accent), bandeau de sport sur le front, 3 rayures de dune
# en zigzag sur le dos, petit tas de sable collé au pied gauche.
# Personnalité : sportif (boxe dans le vide, sautille sur place).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_sablegriffe.py [-- model]
import math
import os
import sys

import bmesh
import bpy
from mathutils import Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401

import theropod_plaques as TP  # noqa: E402

# STYLE n°2 « plaques » + appui des pieds (local à ce build, helpers partagés intacts)
TP.apply(H.dd, R, lambda f: setattr(H, "split_sharp", f), H.split_sharp)

ID, NAME = "sablegriffe", "Sablegriffe"
HEIGHT = 4.0  # 4,0 x 1,0
COLORS = {"main": "#E8C07D", "belly": "#FFF1D0", "accent": "#FF7043", "glow": "#FFAB91", "back": "#C68B4E"}
BG = (0.20, 0.24, 0.30)
NT = 5
# Style chibi (MISE À JOUR STYLE) : tête énorme, corps court et rond, pattes épaisses (un peu plus longues que
# les autres : coureur), bras courts mais énormes griffes-pelles, petites pointes triangulaires.
NODES = [
    ("hanche", (0, 0.15, 1.55), 0.62, None),
    ("ventre", (0, -0.26, 1.60), 0.72, "hanche"),
    ("epaules", (0, -0.60, 1.88), 0.56, "ventre"),
    ("cou", (0, -0.78, 2.25), 0.46, "epaules"),
    ("cou2", (0, -0.86, 2.60), 0.52, "cou"),
    ("crane", (0, -1.08, 3.14), 1.12, "cou2"),
    ("machoire", (0, -1.74, 2.90), 0.80, "crane"),
    ("museau", (0, -2.28, 2.80), 0.64, "machoire"),
    ("nez", (0, -2.70, 2.82), 0.56, "museau"),  # museau carré et large
    ("queue1", (0, 0.72, 1.55), 0.48, "hanche"),
    ("queue2", (0, 1.20, 1.58), 0.36, "queue1"),
    ("queue3", (0, 1.65, 1.64), 0.27, "queue2"),
    ("queue4", (0, 2.05, 1.72), 0.19, "queue3"),
    ("queue5", (0, 2.40, 1.82), 0.13, "queue4"),
    ("queue6", (0, 2.66, 1.92), 0.08, "queue5"),
    ("bassin", (0.46, 0.10, 1.35), 0.52, None),
    ("cuisse", (0.56, -0.05, 1.05), 0.52, "bassin"),
    ("genou", (0.60, -0.26, 0.66), 0.29, "cuisse"),
    ("cheville", (0.58, 0.06, 0.32), 0.21, "genou"),
    ("pied", (0.58, -0.06, 0.16), 0.22, "cheville"),
    ("orteils", (0.58, -0.38, 0.13), 0.17, "pied"),
    ("epaule", (0.48, -0.78, 1.84), 0.19, None),
    ("coude", (0.70, -0.98, 1.60), 0.15, "epaule"),
    ("main", (0.70, -1.22, 1.62), 0.14, "coude"),
]
MOUTH_Y0 = -1.52
MOUTH_P = (0, -1.70, 2.66)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.05
BELLY_COS = 0.42
BELLY_MAX_X = 0.5
BACK_PAINT = (2.0, 0.0, 99.0, 99.0)  # pas de dos uni : les rayures de dune le remplacent
BAND_C = Vector((0, -0.95, 3.35))
BAND_N = Vector((0, 0.45, 1.0)).normalized()
CLAW = BELLY  # griffes et pelles crème (style) : le ventre est crème


def paint(B, me):
    """3 rayures de dune en chevrons (slot dos) en travers du dos, entre les épaules et la queue."""
    attr = me.color_attributes[H.dd.COLOR_ATTR]
    for poly in me.polygons:
        c, n = poly.center, poly.normal
        if n.z < 0.1 or abs(c.x) > 0.6 or not (-0.55 < c.y < 1.4) or c.z < 1.75:
            continue
        y = c.y - 0.45 * abs(c.x)  # chevrons (zigzag de dune) pointés vers l'avant
        k = (y + 0.55) / 0.5
        if k >= 0 and 0.45 < (k % 1.0) and int(k) < 3:
            for li in poly.loop_indices:
                attr.data[li].color_srgb = B.C[BACK]


def ring_on_body(B, name, slot, gi, center, normal, n=18, width=0.13, thick=0.06):
    """Anneau collé à la peau (bandeau) : rayons lancés dans le plan (center, normal) jusqu'à la surface."""
    nrm = Vector(normal).normalized()
    ax = Vector((1, 0, 0))
    ay = nrm.cross(ax).normalized()
    ax = ay.cross(nrm).normalized()
    bm = bmesh.new()
    rings = []
    for i in range(n):
        a = 2 * math.pi * i / n
        d = ax * math.cos(a) + ay * math.sin(a)
        ok, loc, nor, _ = B.body.ray_cast(center + d * 3.0, -d)
        assert ok, ("bandeau", i)
        p = loc + d * thick * 0.6
        vs = [bm.verts.new(p + nrm * (-width / 2) - d * thick), bm.verts.new(p + nrm * (width / 2) - d * thick),
              bm.verts.new(p + nrm * (width / 2)), bm.verts.new(p + nrm * (-width / 2))]
        rings.append(vs)
    for i in range(n):
        a, b = rings[i], rings[(i + 1) % n]
        for k in range(4):
            bm.faces.new((a[k], a[(k + 1) % 4], b[(k + 1) % 4], b[k]))
    bmesh.ops.recalc_face_normals(bm, faces=bm.faces)
    me = bpy.data.meshes.new(name)
    bm.to_mesh(me)
    bm.free()
    H.dd.fill_color(me, B.C[slot])
    ob = bpy.data.objects.new(name, me)
    B.col.objects.link(ob)
    return B.add(B.tag(ob, gi))


def spine_bones(y):
    return ["Spine2", "Neck1"] if y < -0.55 else ["Spine1", "Spine2"] if y < -0.15 else \
        ["Hips", "Spine1"] if y < 0.45 else ["Tail1", "Tail2"] if y < 1.2 else ["Tail2", "Tail3"]


def plates(B, ys, slot, size, thick=0.09):
    """Plaques triangulaires plates (prismes biseautés) dressées le long du dos, dans le plan YZ."""
    for k, (y, h) in enumerate(ys):
        loc, nor = B.top(y)
        H_, W = h * size, h * size * 0.75
        tri = [(-W * 0.5, -0.08), (W * 0.5, -0.08), (W * 0.12, H_ * 0.92), (0, H_), (-W * 0.12, H_ * 0.92)]
        up = (Vector((0, 0.35, 1.0)) + nor * 0.3).normalized()
        B.flat("Plaque%d" % k, slot, B.grp("dist", spine_bones(y)), tri, H.frame_from(loc, (1, 0, 0), up), thick)


def studs(B, gi, center, normal, up, n_x, n_y, step=0.17, r=0.055, h=0.05, slot=ACCENT):
    """Plots ronds (cylindres courts 8 côtés) en grille, façon pièce de construction."""
    M = H.frame_from(center, normal, up)
    for i in range(n_x):
        for j in range(n_y):
            p = M @ Vector(((i - (n_x - 1) / 2) * step, (j - (n_y - 1) / 2) * step, h * 0.5))
            B.cone_to("Plot", slot, gi, p - Vector(normal).normalized() * h * 0.5, normal, h, r, segments=8, r2=r)


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.46, -1.92, 3.36), 0.42, look=(0.15, -1.0, 0.1), iris=ACCENT, iris_r=0.66, pupil_r=0.40,
           brow=(20, 0.82, 0.55), brow_slot=BACK)
    B.mouth_parts(n_up=6, n_lo=5, size=0.15)
    ob = B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.17, -3.05, 3.12), -0.01), scale=(0.07, 0.05, 0.045),
             u=6, v=4)
    H.mirror_inplace(ob)
    # bandeau de sport (anneau accent + liseré blanc), derrière les yeux
    ring_on_body(B, "Bandeau", ACCENT, gh, BAND_C, BAND_N, n=12, width=0.2, thick=0.08)
    ring_on_body(B, "Liseré", WHITE, gh, BAND_C + BAND_N * 0.12, BAND_N, n=12, width=0.05, thick=0.085)
    # 2 petites pointes à l'arrière du crâne + rangée sur le dos
    for sx in (1, -1):
        loc, nor = B.surf((0.35 * sx, -0.25, 3.6))
        B.cone_to("PointeTete", BACK, gh, loc - nor * 0.04, nor + Vector((0, 0.8, 0.3)), 0.3, 0.13, segments=4)
    plates(B, ((0.55, 1.0), (0.95, 0.8), (1.35, 0.6)), BACK, 0.3)
    # selle plate (trapèze biseauté) sur le dos, 2 x 2 plots ronds
    loc, nor = B.top(0.15)
    gs = B.grp("dist", spine_bones(0.15))
    sad = [(-0.26, -0.2), (0.26, -0.2), (0.2, 0.2), (-0.2, 0.2)]
    B.flat("Selle", ACCENT, gs, sad, H.frame_from(loc + nor * 0.03, nor, (0, -1, 0)), 0.07)
    studs(B, gs, loc + nor * 0.065, nor, (0, -1, 0), 2, 2, slot=ACCENT)
    # pattes « pelles » : gros poing + 1 énorme griffe en pelle de plage (lame crème, douille accent)
    g = B.grp("rigid", "LowerArm.S")
    h, c = B.pos["main"], B.pos["coude"]
    d = ((h - c).normalized() + Vector((0.1, -0.3, -0.9))).normalized()
    obs = [B.P("Poing", "sphere", MAIN, g, loc=h + d * 0.05, scale=(0.2, 0.2, 0.18), u=9, v=6)]
    obs.append(B.cone_to("Manche", CLAW, g, h + d * 0.1, d, 0.2, 0.05, segments=6, r2=0.05))
    base = h + d * 0.26
    blade = [(x * 1.6, y * 1.6) for x, y in ((-0.15, 0), (0.15, 0), (0.17, 0.12), (0.15, 0.24), (0.06, 0.33),
                                              (0, 0.36), (-0.06, 0.33), (-0.15, 0.24), (-0.17, 0.12))]
    side = Vector((0.75, 0.65, 0))  # lame à 45° : lisible de face et de profil
    nrm = d.cross(side).normalized()
    obs.append(B.flat("Pelle", ACCENT, g, blade, H.frame_from(base, nrm, d), 0.06))
    obs.append(B.cone_to("Douille", CLAW, g, base - d * 0.04, d, 0.1, 0.07, segments=6, r2=0.1))
    # pointe de coude
    e = B.pos["coude"]
    obs.append(B.cone_to("PointeCoude", BACK, B.grp("rigid", "UpperArm.S"), e + Vector((0.02, 0.08, 0.02)),
                         (0.2, 1.0, 0.5), 0.22, 0.08, segments=4))
    B.mirror(obs)
    B.feet(n=3, length=0.34, r=0.13, claw=CLAW, spread=32, back=0.26, claw_len=0.19)
    # petit tas de sable collé au pied gauche (+X)
    gt = B.grp("rigid", "Toe.L")
    o = B.pos["orteils"]
    B.P("TasSable", "cone", BACK, gt, loc=(o.x + 0.36, o.y + 0.3, 0.09), segments=10, r1=0.3, r2=0.04, depth=0.18)


class Anims(H.Anims):
    JAW_OPEN = 50.0

    # Sportif : garde de boxe « prête à bondir », sautille sur place puis enchaîne gauche-droite-gauche ;
    # gueule ouverte en grand sourire
    def idle(self, t):
        P = self.base()
        hop = abs(math.sin(2 * math.pi * 4 * t)) * R.keys(t, [(0, 1), (0.4, 1), (0.48, 0), (0.92, 0), (1, 1)])
        jab = [R.keys(t, [(0, 0), (0.50, 0), (0.55, 1), (0.61, 0), (0.78, 0), (0.83, 1), (0.89, 0), (1, 0)]),
               R.keys(t, [(0, 0), (0.64, 0), (0.69, 1), (0.75, 0), (1, 0)])]
        self.hips(z=-0.07 + 0.18 * hop, rx=5, rz=4 * R.S2(t, 4) + 6 * (jab[0] - jab[1]))
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -2 * hop), (R.Z, -5 * (jab[0] - jab[1])))
        H.rig.rot(P["Neck1"], (R.X, -4))
        H.rig.rot(P["Head"], (R.X, -3 * hop - 2), (R.Z, 5 * (jab[1] - jab[0])))
        H.rig.rot(P["Jaw"], (R.X, 20 + 4 * hop + 6 * (jab[0] + jab[1])))
        self.tail(lambda i: ((R.X, -5 * hop), (R.Z, 6 * R.S2(t, 4, -0.08 * i))))
        for k, (side, sx) in enumerate(H.SIDES):
            H.rig.rot(P["UpperArm." + side], (R.X, -60 - 8 * hop - 30 * jab[k]), (R.Y, -sx * (35 - 30 * jab[k])))
            H.rig.rot(P["LowerArm." + side], (R.X, -10 + 10 * jab[k]))

    def idle_feet(self, side, t, ank, toe):
        hop = abs(math.sin(2 * math.pi * 4 * t)) * R.keys(t, [(0, 1), (0.4, 1), (0.48, 0), (0.92, 0), (1, 1)])
        off = Vector((0, 0, 0.18 * hop * self.u))
        return ank + off, toe + off


if __name__ == "__main__":
    H.run(sys.modules[__name__])
