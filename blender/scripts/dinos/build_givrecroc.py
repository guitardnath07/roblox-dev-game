# DINO DICE — Givrecroc (rare, théropode, taille 1,05) : modèle + rig + 7 animations + rendus.
# Version : 3 (style chibi + plaques)
# Référence : Cryolophosaurus (crête transversale en éventail au-dessus des yeux, crâne long, bras moyens à
# 3 doigts, prédateur moyen).
# Couche thématique : crête = éventail de 5 stalactites de glace en travers du crâne, 6 pics de glace sur le dos,
# 2 crocs bleus qui dépassent, écharpe de givre à 2 pans, goutte au nez (rhume).
# Personnalité : enrhumé (frissonne, éternue : recul de tête puis coup sec vers l'avant).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_givrecroc.py [-- model]
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

ID, NAME = "givrecroc", "Givrecroc"
HEIGHT = 4.2  # 4,0 x 1,05
COLORS = {"main": "#B3E5FC", "belly": "#F5FBFF", "accent": "#4FC3F7", "glow": "#7FF6FF", "back": "#7FB8DA"}
BG = (0.20, 0.24, 0.30)
NT = 5
# Style chibi (MISE À JOUR STYLE) : tête énorme au crâne long, corps court et rond, pattes courtes et épaisses,
# mains « pattes d'ours » à grosses griffes, pose prête à bondir bras levés.
NODES = [
    ("hanche", (0, 0.15, 1.40), 0.66, None),
    ("ventre", (0, -0.25, 1.46), 0.76, "hanche"),
    ("epaules", (0, -0.58, 1.74), 0.58, "ventre"),
    ("cou", (0, -0.76, 2.10), 0.48, "epaules"),
    ("cou2", (0, -0.84, 2.46), 0.54, "cou"),
    ("crane", (0, -1.08, 3.00), 1.10, "cou2"),
    ("machoire", (0, -1.76, 2.76), 0.78, "crane"),
    ("museau", (0, -2.34, 2.66), 0.60, "machoire"),
    ("nez", (0, -2.86, 2.68), 0.48, "museau"),  # crâne long
    ("queue1", (0, 0.72, 1.38), 0.50, "hanche"),
    ("queue2", (0, 1.18, 1.38), 0.37, "queue1"),
    ("queue3", (0, 1.60, 1.42), 0.27, "queue2"),
    ("queue4", (0, 1.98, 1.50), 0.19, "queue3"),
    ("queue5", (0, 2.30, 1.60), 0.13, "queue4"),
    ("queue6", (0, 2.54, 1.72), 0.08, "queue5"),
    ("bassin", (0.48, 0.10, 1.20), 0.54, None),
    ("cuisse", (0.58, -0.04, 0.92), 0.54, "bassin"),
    ("genou", (0.62, -0.22, 0.58), 0.32, "cuisse"),
    ("cheville", (0.60, 0.04, 0.30), 0.23, "genou"),
    ("pied", (0.60, -0.08, 0.16), 0.24, "cheville"),
    ("orteils", (0.60, -0.38, 0.13), 0.18, "pied"),
    ("epaule", (0.52, -0.76, 1.72), 0.21, None),
    ("coude", (0.78, -0.96, 1.46), 0.17, "epaule"),
    ("main", (0.80, -1.24, 1.48), 0.16, "coude"),
]
MOUTH_Y0 = -1.52
MOUTH_P = (0, -1.70, 2.52)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.15
BELLY_COS = 0.42
BELLY_MAX_X = 0.5
BACK_PAINT = (0.45, 0.55, 1.6, -2.2)
SCARF_C = Vector((0, -0.74, 2.12))
SCARF_N = Vector((0, -0.35, 1.0)).normalized()


def ring_on_body(B, name, slot, gi, center, normal, n=10, width=0.13, thick=0.06, puff=0.0):
    """Anneau à facettes collé à la peau : rayons lancés dans le plan (center, normal) jusqu'à la surface.
    Section hexagonale (bord extérieur bombé de `puff`)."""
    nrm = Vector(normal).normalized()
    ax = Vector((1, 0, 0))
    ay = nrm.cross(ax).normalized()
    ax = ay.cross(nrm).normalized()
    bm = bmesh.new()
    rings = []
    prof = [(-0.5, 0.0), (-0.5, 1.0), (-0.2, 1.0 + puff), (0.2, 1.0 + puff), (0.5, 1.0), (0.5, 0.0)]
    for i in range(n):
        a = 2 * math.pi * i / n
        d = ax * math.cos(a) + ay * math.sin(a)
        ok, loc, _nor, _ = B.body.ray_cast(center + d * 3.0, -d)
        assert ok, (name, i)
        p = loc - d * thick * 0.3
        rings.append([bm.verts.new(p + nrm * (w * width) + d * (h * thick)) for w, h in prof])
    m = len(prof)
    for i in range(n):
        a, b = rings[i], rings[(i + 1) % n]
        for k in range(m):
            bm.faces.new((a[k], a[(k + 1) % m], b[(k + 1) % m], b[k]))
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


def ice_plate(B, name, gi, base, up, h, w, thick, slot=GLOW):
    """Pic de glace = prisme plat en losange allongé (plaque biseautée), dressé dans le plan YZ."""
    pts = [(0, -0.06), (w * 0.5, h * 0.35), (0, h), (-w * 0.5, h * 0.35)]
    return B.flat(name, slot, gi, pts, H.frame_from(base, (1, 0, 0), up), thick)


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.52, -1.80, 3.30), 0.42, look=(0.2, -1.0, 0.1), iris=ACCENT, iris_r=0.66, pupil_r=0.40,
           brow=(-14, 0.84, 0.52), brow_slot=BACK)
    B.mouth_parts(n_up=6, n_lo=5, size=0.15, fangs=[(-2.3, 0.3, ACCENT)])
    ob = B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.15, -3.20, 2.98), -0.01), scale=(0.065, 0.05, 0.045),
             u=6, v=4)
    H.mirror_inplace(ob)
    # goutte au nez (rhume) sous la narine gauche
    p = B.snap((0.15, -3.26, 2.84), 0.0)
    B.P("Goutte", "sphere", GLOW, gh, loc=p + Vector((0, -0.03, -0.09)), scale=(0.07, 0.07, 0.09), u=6, v=4)
    B.cone_to("GoutteBout", GLOW, gh, p + Vector((0, -0.03, -0.05)), (0, 0, 1), 0.08, 0.055, segments=6)
    # crête transversale : socle bleu (bloc) + éventail de 5 stalactites (prismes 4 côtés) en travers du crâne
    yc = -1.45
    loc0, _n = B.top(yc)
    B.ellipsoid("SocleCrete", ACCENT, gh, loc0 + Vector((0, 0, -0.02)), (1, 0, 0), 1.1, (0.12, 0.14), u=6, v=4)
    for k, (x, hgt) in enumerate(((-0.4, 0.3), (-0.2, 0.42), (0.0, 0.52), (0.2, 0.42), (0.4, 0.3))):
        loc, nor = B.surf(Vector((x, yc, loc0.z + 0.2)))
        d = Vector((x * 2.2, 0.15, 1.0)).normalized()
        B.cone_to("Stalactite%d" % k, GLOW, gh, loc - nor * 0.03, d, hgt * 1.6, 0.13, segments=4)
    # 6 pics de glace dégressifs le long du dos = plaques losanges plates
    for k, (y, hgt) in enumerate(((-0.40, 0.42), (-0.05, 0.46), (0.30, 0.42), (0.68, 0.34), (1.05, 0.26),
                                  (1.42, 0.18))):
        loc, nor = B.top(y)
        up = (Vector((0, 0.45, 1.0)) + nor * 0.3).normalized()
        ice_plate(B, "Pic%d" % k, B.grp("dist", spine_bones(y)), loc - nor * 0.05, up, hgt, hgt * 0.7, 0.09)
    # 2 petites pointes de glace aux coudes
    ge = B.grp("rigid", "UpperArm.S")
    e = B.pos["coude"]
    ob = B.cone_to("PointeCoude", GLOW, ge, e + Vector((0.03, 0.08, 0.02)), (0.3, 1.0, 0.4), 0.24, 0.08, segments=4)
    H.mirror_inplace(ob)
    # écharpe de givre (anneau bombé à facettes) + 2 pans qui pendent devant à gauche
    gs = B.grp("dist", ["Spine2", "Neck1"])
    ring_on_body(B, "Echarpe", ACCENT, gs, SCARF_C, SCARF_N, n=10, width=0.32, thick=0.15, puff=0.5)
    ring_on_body(B, "EcharpeBord", WHITE, gs, SCARF_C + SCARF_N * 0.17, SCARF_N, n=10, width=0.05, thick=0.16)
    g2 = B.grp("rigid", "Spine2")
    loc, nor = B.surf(SCARF_C + Vector((0.32, -0.3, -0.05)))
    for k, (ang, L) in enumerate(((8, 0.62), (-18, 0.5))):
        base = loc + nor * 0.16 + Vector((0.08 * k, 0.05 * k, 0))
        a = math.radians(ang)
        down = Vector((math.sin(a) * 0.6, -0.15, -1.0)).normalized()
        pan = [(-0.13, 0), (0.13, 0), (0.14, L - 0.08), (0.08, L), (0.0, L - 0.06), (-0.08, L), (-0.14, L - 0.08)]
        M = H.frame_from(base, nor + Vector((0.2, -0.3, 0)), down)
        B.flat("Pan%d" % k, ACCENT, g2, pan, M, 0.06)
        tip = M @ Vector((0, L - 0.05, 0))
        B.flat("Frange%d" % k, WHITE, g2, [(-0.14, -0.06), (0.14, -0.06), (0.14, 0.02), (-0.14, 0.02)],
               H.frame_from(tip + (M.to_3x3() @ Vector((0, -0.02, 0.01))), nor + Vector((0.2, -0.3, 0)), down), 0.07)
    # pattes d'ours : gros doigts griffus (griffes blanc cassé)
    B.hands(n=3, length=0.3, r=0.11, claw=WHITE, spread=30, claw_len=0.2, down=0.5)
    B.feet(n=3, length=0.34, r=0.13, claw=WHITE, spread=32, back=0.26, claw_len=0.19)


class Anims(H.Anims):
    JAW_OPEN = 48.0

    # Enrhumé : « prêt à bondir » bras levés mais frissonnant, inspiration (tête en arrière), éternuement
    # (coup sec en avant, bras qui retombent), puis se remet en garde
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        shiv = R.keys(t, [(0, 1), (0.30, 1), (0.36, 0), (0.88, 0), (0.94, 1), (1, 1)]) * R.S2(t, 30)
        inh = R.keys(t, [(0, 0), (0.42, 0), (0.55, 1), (0.60, 1), (0.63, 0), (1, 0)])
        sn = R.keys(t, [(0, 0), (0.58, 0), (0.62, 1), (0.70, 1), (0.82, 0), (1, 0)])
        self.hips(z=-0.06 + 0.02 * br - 0.04 * sn, rx=4 - 5 * inh + 6 * sn, rz=1.5 * shiv)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -1.5 * br - 3 * inh + 3 * sn), (R.Z, 1.5 * shiv))
        H.rig.rot(P["Neck1"], (R.X, -4 - 10 * inh + 14 * sn), (R.Z, 2 * shiv))
        H.rig.rot(P["Neck2"], (R.X, -8 * inh + 10 * sn))
        H.rig.rot(P["Head"], (R.X, -14 * inh + 16 * sn + 2 * br), (R.Z, 3 * shiv), (R.Y, 3 * shiv))
        H.rig.rot(P["Jaw"], (R.X, 14 + 18 * inh - 10 * sn + 2 * max(0.0, br)))
        self.tail(lambda i: ((R.Z, 4 * R.S2(t, 1, -0.08 * i) + 2 * shiv), (R.X, 3 * inh - 4 * sn)))
        up = 1 - 0.6 * sn
        for side, sx in H.SIDES:
            H.rig.rot(P["UpperArm." + side], (R.X, (-60 + 3 * shiv) * up), (R.Y, -sx * 30 * up))
            H.rig.rot(P["LowerArm." + side], (R.X, -15 * up + 4 * shiv))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
