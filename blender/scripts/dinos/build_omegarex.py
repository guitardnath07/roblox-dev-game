# DINO DICE — Omégarex (secret, théropode, taille 2,5, le plus rare du jeu) : modèle + rig + 7 animations + rendus.
# Version : 1 (style chibi « plaques » : tête énorme, gros yeux, grosses griffes crème, facettes plates)
# Référence : Giganotosaurus carolinii (crâne plus long et plus bas que celui du T. rex : silhouette distincte de
# Tonnerrex ; petite crête osseuse au-dessus des yeux, bras à 3 doigts, longue queue puissante).
# Couche thématique : couronne de 7 cornes torsadées en galaxie le long du crâne, symbole Ω doré qui flotte
# au-dessus de la tête (os Omega, enfant des hanches), 2 anneaux d'orbite inclinés autour du torse avec chacun une petite planète
# (os Orbit1 / Orbit2), étoiles dorées sur la peau, fin de queue en 10 fragments qui se détachent en étoiles
# (os Frag1 / Frag2), plaques dorsales en losange.
# Personnalité : boss final ; regarde le joueur de haut, croise les petits bras, rugit en faisant trembler l'écran.
#   python3 bb.py blender/scripts/dinos/build_omegarex.py [-- model]
import math
import os
import sys

import bmesh
import bpy
from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401

# Style « plaques » (contournements locaux, les helpers restent intacts) : Skin sans subdivision (le helper fixe
# subdiv=1), primitives grossières (sphères 8 x 5, cônes <= 8 côtés), ombrage plat (une normale par face, comme en jeu).
SKIN_SMOOTH = 1
_skin = H.dd.skin_body
H.dd.skin_body = lambda *a, **k: _skin(*a, **{**k, "subdiv": 0, "smooth_iters": SKIN_SMOOTH})
_part = H.dd.part
_build_mesh = H.build_mesh


LOC_BONES = ["Omega", "Frag1", "Frag2"]

# key_all (build_theropod_rig) ne pose de clé de position que sur Hips : on ajoute les os qui se déplacent
_key_all = H.rig.key_all


def _key_all_loc(arm, f):
    _key_all(arm, f)
    for name in LOC_BONES:
        arm.pose.bones[name].keyframe_insert("location", frame=f, group=name)


H.rig.key_all = _key_all_loc

def _coarse_part(name, kind, col, rgba, **kw):
    if kind == "sphere":
        kw["u"], kw["v"] = min(kw.get("u", 10), 8), min(kw.get("v", 7), 5)
    elif kind == "cone":
        kw["segments"] = min(kw.get("segments", 6), 8)
    return _part(name, kind, col, rgba, **kw)


def _build_mesh_flat(B):
    sc, col, rcol, ob, st = _build_mesh(B)
    ob.data.shade_flat()
    return sc, col, rcol, ob, st


H.dd.part = _coarse_part
H.build_mesh = _build_mesh_flat

ID, NAME = "omegarex", "Omegarex"
HEIGHT = 4.0 * 2.5
# main éclairci (#0D0221 de la fiche -> dos) pour que les facettes restent lisibles
COLORS = {"main": "#2D1B69", "belly": "#7B1FA2", "accent": "#B388FF", "glow": "#FFD740", "back": "#0D0221"}
BG = (0.24, 0.26, 0.33)
NT = 4
NODES = [
    ("hanche", (0, 0.18, 1.55), 0.76, None),
    ("ventre", (0, -0.30, 1.62), 0.84, "hanche"),
    ("epaules", (0, -0.72, 1.88), 0.64, "ventre"),
    ("cou", (0, -0.95, 2.22), 0.58, "epaules"),
    ("cou2", (0, -1.05, 2.55), 0.60, "cou"),
    # crâne long et bas (Giganotosaurus)
    ("crane", (0, -1.30, 3.00), 1.15, "cou2"),
    ("machoire", (0, -2.00, 2.80), 0.86, "crane"),
    ("museau", (0, -2.65, 2.70), 0.68, "machoire"),
    ("nez", (0, -3.18, 2.72), 0.54, "museau"),
    ("queue1", (0, 0.75, 1.60), 0.58, "hanche"),
    ("queue2", (0, 1.25, 1.68), 0.44, "queue1"),
    ("queue3", (0, 1.70, 1.76), 0.32, "queue2"),
    ("queue4", (0, 2.08, 1.84), 0.22, "queue3"),
    # cuisses massives, pattes courtes et épaisses
    ("bassin", (0.52, 0.10, 1.30), 0.64, None),
    ("cuisse", (0.64, -0.05, 0.95), 0.64, "bassin"),
    ("genou", (0.66, -0.22, 0.62), 0.36, "cuisse"),
    ("cheville", (0.62, 0.04, 0.32), 0.27, "genou"),
    ("pied", (0.62, -0.06, 0.17), 0.27, "cheville"),
    ("orteils", (0.62, -0.38, 0.14), 0.23, "pied"),
    # petits bras à 3 doigts
    ("epaule", (0.55, -0.95, 1.80), 0.16, None),
    ("coude", (0.72, -1.14, 1.58), 0.14, "epaule"),
    ("main", (0.68, -1.38, 1.56), 0.14, "coude"),
]
MOUTH_Y0 = -1.62
MOUTH_P = (0, -1.80, 2.62)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.4
BELLY_COS = 0.35
BELLY_MAX_X = 0.65
BACK_PAINT = (0.45, 0.65, 1.7, -2.4)
SMILE_LIFT = (0.16, 0.55)
JAW_REST = 12.0

OMEGA = Vector((0, -1.45, 4.95))
TORSO = Vector((0, -0.25, 1.75))
ORBITS = [  # (os, rayon, axe de bascule, angle, angle de la planète, slot de la planète)
    ("Orbit1", 1.62, (1, 0, 0), -18.0, 200.0, ACCENT),
    ("Orbit2", 1.92, (0, 1, 0), 22.0, 30.0, BELLY),
]
TAIL_TIP = Vector((0, 2.08, 1.84))
FRAGS = []  # (centre, taille) des 10 fragments de queue
for _k in range(10):
    FRAGS.append((TAIL_TIP + Vector((0, 0.3 + 0.27 * _k - 0.009 * _k * _k, 0.08 * _k * 0.27)), 0.21 - 0.014 * _k))
EXTRA_BONES = [
    ("Omega", OMEGA, OMEGA + Vector((0, 0, 0.5)), "Hips"),  # Hips : ne suit pas les coups de tête
    ("Orbit1", TORSO, TORSO + Vector((0, 0, 0.6)), "Hips"),
    ("Orbit2", TORSO, TORSO + Vector((0, 0, 0.6)), "Hips"),
    ("Frag1", TAIL_TIP, FRAGS[4][0], "Tail4"),
    ("Frag2", FRAGS[4][0], FRAGS[9][0], "Frag1"),
]


def box(B, name, slot, gi, center, size, M=None):
    """Bloc (sx, sy, sz) centré, orienté par la rotation de M."""
    T = Matrix.Translation(Vector(center))
    if M is not None:
        T = T @ M.to_3x3().to_4x4()
    return B.P(name, "cube", slot, gi, M=T @ Matrix.Diagonal((*size, 1)))


def ring(B, name, slot, gi, M, rad, r, n=16, sides=4):
    """Anneau à section carrée (tore grossier) dans le plan XY local de M."""
    bm = bmesh.new()
    rows = []
    for i in range(n):
        a = 2 * math.pi * i / n
        radial = Vector((math.cos(a), math.sin(a), 0))
        c = radial * rad
        rows.append([bm.verts.new(M @ (c + radial * r * math.cos(b) + Vector((0, 0, r * math.sin(b)))))
                     for b in [2 * math.pi * j / sides + math.pi / 4 for j in range(sides)]])
    for i in range(n):
        for j in range(sides):
            a, b = rows[i], rows[(i + 1) % n]
            bm.faces.new((a[j], a[(j + 1) % sides], b[(j + 1) % sides], b[j]))
    me = bpy.data.meshes.new(name)
    bm.to_mesh(me)
    bm.free()
    H.dd.fill_color(me, B.C[slot])
    ob = bpy.data.objects.new(name, me)
    B.col.objects.link(ob)
    return B.add(B.tag(ob, gi))


def orbit_matrix(axis, ang):
    return Matrix.Translation(TORSO) @ Matrix.Rotation(math.radians(ang), 4, Vector(axis))


def flank(B, y, z):
    hit, loc, nor, _i = B.body.ray_cast(Vector((0, y, z)), Vector((1, 0, 0)))
    assert hit, (y, z)
    return loc, nor


def accessories(B):
    gh = B.grp("rigid", "Head")
    ec, lk = B.eyes((0.68, -2.05, 3.38), 0.47, iris=GLOW, look=(0.3, -1.0, -0.1), brow=(24, 0.95, 0.66),
                    brow_slot=ACCENT, sink=0.42)
    B.mouth_parts(n_up=8, n_lo=6, size=0.18, inset=0.06, fangs=[(-2.6, 0.28, WHITE), (-2.2, 0.24, WHITE)])
    H.mirror_inplace(B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.19, -3.42, 3.02), -0.01),
                         scale=(0.075, 0.06, 0.045), u=6, v=4))
    # petite crête osseuse au-dessus des yeux : 3 plaques triangulaires en ligne (Giganotosaurus)
    obs = []
    for k, y in enumerate((-2.55, -2.3, -2.05)):
        loc, nor = B.top(y, 0.42)
        h = 0.16 + 0.05 * k
        obs.append(B.flat("CreteOeil%d" % k, ACCENT, gh, [(-0.13, 0), (0.13, 0), (0.02, h)],
                          H.frame_from(loc - nor * 0.04, (1, 0, 0), (0, 0.4, 1)), 0.08))
    B.mirror(obs)
    # couronne de 7 cornes torsadées (3 tronçons à 5 pans, chacun tourné : effet spirale ; pointe dorée)
    head_c = Vector((0, -1.3, 3.0))
    for k, (x, y, L) in enumerate(((0.0, -1.0, 0.95), (0.42, -1.3, 0.75), (0.62, -0.95, 0.85), (0.48, -0.6, 0.7))):
        loc, nor = B.top(y, x)
        d = ((loc - head_c).normalized() + Vector((0, 0.55, 0.7))).normalized()
        base = loc - nor * 0.08
        obs = []
        p, r = base, 0.17 if k == 0 else 0.14
        for s in range(3):
            seg = L / 3
            ds = (d + Vector((0, 0.25 * s, -0.12 * s))).normalized()
            up = Matrix.Rotation(math.radians(36 * s), 3, ds) @ Vector((0, 0, 1))
            r2 = r * 0.62 if s < 2 else 0.0
            obs.append(B.cone_to("Corne%d_%d" % (k, s), (ACCENT, BELLY, GLOW)[s], gh, p - ds * 0.03, ds, seg + 0.05,
                                 r, r2=r2, segments=5, up=up))
            p, r = p + ds * seg, r2
        if x > 0:
            B.mirror(obs)
    # symbole Ω flottant (os Omega) : arc de 10 blocs + 2 pieds, face vers l'avant
    go = B.grp("rigid", "Omega")
    rad, w = 0.36, 0.1
    a0, a1 = math.radians(-50), math.radians(230)
    n = 10
    pts = [OMEGA + Vector((rad * math.cos(a0 + (a1 - a0) * i / n), 0, rad * math.sin(a0 + (a1 - a0) * i / n)))
           for i in range(n + 1)]
    for i, (a, b) in enumerate(zip(pts, pts[1:])):
        d = b - a
        M = H.frame_from((a + b) / 2, (0, -1, 0), d)
        box(B, "Omega%d" % i, GLOW, go, (a + b) / 2, (w, d.length + 0.03, 0.07), M)
    for end, sx in ((pts[0], 1), (pts[-1], -1)):
        box(B, "OmegaPied", GLOW, go, end + Vector((sx * 0.09, 0, -0.01)), (0.24, 0.08, w))
    # anneaux d'orbite (os Orbit1 / Orbit2) + leur planète
    for name, rr, axis, ang, pa, pslot in ORBITS:
        gi = B.grp("rigid", name)
        M = orbit_matrix(axis, ang)
        ring(B, name + "Anneau", GLOW, gi, M, rr, 0.035)
        pp = M @ Vector((rr * math.cos(math.radians(pa)), rr * math.sin(math.radians(pa)), 0))
        B.P(name + "Planete", "sphere", pslot, gi, loc=pp, scale=(0.17, 0.17, 0.17), u=6, v=4)
        B.P(name + "PlaneteAnneau", "cone", GLOW, gi, M=Matrix.Translation(pp) @ Matrix.Rotation(0.5, 4, "X"),
            segments=8, r1=0.27, r2=0.27, depth=0.02)
    # plaques dorsales en losange (violet) : de la nuque au milieu de la queue
    for k, y in enumerate((-0.62, -0.28, 0.06, 0.4, 0.74, 1.08, 1.4)):
        gi = B.grp("rigid", "Spine2" if y < -0.3 else "Spine1" if y < 0.0 else "Hips" if y < 0.5 else
                   "Tail1" if y < 1.0 else "Tail2")
        loc, nor = B.top(y)
        h = 0.5 - 0.035 * abs(k - 2)
        B.flat("Plaque%d" % k, BELLY, gi, [(0, -0.05), (h * 0.42, h * 0.42), (0, h), (-h * 0.42, h * 0.42)],
               H.frame_from(loc - nor * 0.08, (1, 0, 0), (0, 0.35, 1)), 0.1)
    # étoiles dorées sur les flancs (motif « ciel cosmique »)
    gs = B.grp("dist", ["Hips", "Spine1", "Spine2", "Tail1"])
    for k, (y, z, r) in enumerate(((-0.45, 2.05, 0.11), (-0.05, 1.45, 0.09), (0.3, 2.0, 0.13), (0.75, 1.62, 0.1),
                                   (1.2, 1.85, 0.08))):
        loc, nor = flank(B, y, z)
        B.mirror([B.star("Etoile%d" % k, GLOW, gs, loc + nor * 0.01, nor, r, thick=0.03, rot=0.3 * k)])
    # fin de queue : 10 fragments (blocs tournés) qui deviennent des étoiles
    for k, (c, s) in enumerate(FRAGS):
        gi = B.grp("rigid", "Frag1" if k < 5 else "Frag2")
        if k < 6:
            M = Matrix.Rotation(math.radians(35 * k), 4, "Y") @ Matrix.Rotation(math.radians(25 + 20 * k), 4, "X")
            box(B, "Fragment%d" % k, (MAIN, BELLY)[k % 2], gi, c, (s * 1.3, s * 1.3, s * 1.3), M)
        else:
            B.star("FragEtoile%d" % k, GLOW, gi, c, (1, 0, 0.25), s * 2.0, thick=0.05, rot=0.4 * k)
    B.hands(n=3, length=0.26, r=0.09, claw=WHITE, spread=28, claw_len=0.2, down=0.25)
    B.feet(n=3, length=0.44, r=0.16, claw=WHITE, spread=30, claw_len=0.26, back=0.22)


def lift_toes(A, clip, t):
    """Orteils relevés à la poussée (Run) et pendant la fente (Attack) : les grosses griffes ne rayent pas le sol."""
    for side, _sx in H.SIDES:
        if clip == "Run":
            ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
            k = R.keys(ph, [(0, 0), (0.2, 0), (0.36, 1), (0.55, 0.6), (0.75, 0), (1, 0)])
            A.r("Toe." + side, (R.X, -45 * k))
        elif clip == "Attack":
            k = R.keys(t, [(0, 0), (0.28, 0.4), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
            A.r("Toe." + side, (R.X, -35 * k))


class Anims(H.Anims):
    HEAVY = 0.9
    ARM_SCALE = 0.8
    JAW_OPEN = 55.0

    def cosmos(self, t, turns, frag=1.0, flat=0.0, roll=0.0, lift=0.0):
        """Orbites qui tournent (nombre de tours entier : boucle propre), Ω qui flotte, fragments qui dérivent.
        flat : 1 = anneaux remis à l'horizontale ; roll : compense la bascule des hanches (mort) ;
        lift : Ω monte et recule quand la tête se relève (rugissement)."""
        P, u = self.P, self.u
        for k, (name, _r, axis, ang, _pa, _s) in enumerate(ORBITS):
            n = Matrix.Rotation(math.radians(ang), 3, Vector(axis)) @ Vector((0, 0, 1))
            spin = 360 * turns * t * (1 if k == 0 else -1)
            H.rig.rot(P[name], (R.Y, roll), (tuple(axis), -ang * flat), (tuple(n), spin))
        H.rig.loc(P["Omega"], (0, 1.0 * lift * u, (0.06 * R.S2(t, max(1, round(turns))) + 1.4 * lift) * u))
        self.r("Omega", (R.Z, 12 * R.S2(t, 1)))
        for k, name in enumerate(("Frag1", "Frag2")):
            H.rig.loc(P[name], (0.03 * u * R.S2(t, 2, 0.3 * k) * frag, 0.05 * u * frag * (k + 1) * (0.5 + 0.5 * R.S2(t, 1)),
                                0.04 * u * R.S2(t, 2, 0.2 + 0.3 * k) * frag))
            self.r(name, (R.Y, 25 * R.S2(t, 1, 0.2 * k) * frag), (R.Z, 8 * R.S2(t, 2, 0.3 * k) * frag))

    def extra(self, clip, t):
        turns = {"Idle": 2, "Walk": 1, "Run": 1, "Attack": 1, "Roar": 2, "Celebrate": 2, "Death": 0}[clip]
        if clip == "Death":
            f = R.keys(t, [(0, 0), (0.36, 0), (0.62, 1), (1, 1)])
            # anneaux remis à plat, bascule des hanches (ry = -80) compensée : ils restent au-dessus du sol
            self.cosmos(t, 0.5, frag=1 - f, flat=f, roll=80 * f)
        elif clip == "Roar":  # même courbe que le rugissement générique
            self.cosmos(t, turns, lift=R.keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)]))
        else:
            self.cosmos(t, turns)
        if clip in ("Walk", "Run"):  # grand sourire en marchant
            self.r("Jaw", (R.X, JAW_REST + 4 * R.S2(t, 2)))
        lift_toes(self, clip, t)

    # Boss final : se redresse et toise le joueur, croise les petits bras, puis RUGIT (secousse de tout le corps)
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        rr = R.keys(t, [(0, 0), (0.6, 0), (0.66, 1), (0.86, 1), (0.94, 0), (1, 0)])
        cross = 1 - rr
        sh = rr * R.S2(t, 12)
        self.hips(z=-0.04 + 0.02 * br - 0.04 * rr + 0.02 * sh, x=0.015 * sh, rx=-4 * cross - 8 * rr,
                  rz=2 * R.S2(t, 1) + 2 * sh)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -1.5 * br - 3 * cross - 3 * rr))
        H.rig.rot(P["Neck1"], (R.X, 2 * br - 10 * cross - 10 * rr))
        H.rig.rot(P["Neck2"], (R.X, -4 * cross - 4 * rr))
        H.rig.rot(P["Head"], (R.X, 12 * cross - 6 * rr + 4 * sh), (R.Z, 5 * R.S2(t, 1, 0.2) * cross + 6 * sh))
        H.rig.rot(P["Jaw"], (R.X, (JAW_REST * 0.4 + 2 * br) * cross + 50 * rr))
        self.tail(lambda i: ((R.Z, 4 * R.S2(t, 1, -0.08 * i) + 3 * R.S2(t, 12, -0.1 * i) * rr),
                             (R.X, 2 * R.S2(t, 2, -0.1 * i) + 3 * rr)))
        for side, sx in H.SIDES:
            # bras croisés devant la poitrine ; écartés, griffes sorties, pendant le rugissement
            H.rig.rot(P["UpperArm." + side], (R.X, -35 * cross - 60 * rr), (R.Z, -sx * 38 * cross),
                      (R.Y, -sx * 35 * rr))
            H.rig.rot(P["LowerArm." + side], (R.X, -20 * cross - 25 * rr), (R.Z, -sx * 55 * cross))
        self.cosmos(t, 2, lift=0.6 * rr)
        self.r("Omega", (R.Z, 12 * R.S2(t, 1) + 15 * sh))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
