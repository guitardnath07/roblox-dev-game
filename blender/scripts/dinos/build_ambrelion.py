# DINO DICE — Ambrelion (légendaire, théropode, taille 1,4) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi : tête énorme, gros yeux, grosses griffes crème, gueule souriante, petites pointes)
# Référence : Yutyrannus huali (grand tyrannosauroïde à plumes : filaments épais en crinière, petite crête ondulée
# sur le museau, bras à 3 doigts assez longs, pattes puissantes).
# Couche thématique : crinière = 14 pointes d'ambre en 2 couronnes autour du cou (3 moustiques piégés dans les
# pointes avant), touffe de queue en 5 mèches, crête ondulée en 3 bosses brunes sur le museau.
# Personnalité : fier ; secoue sa crinière, puis penche la tête pour « écouter » ses moustiques.
#   python3 bb.py blender/scripts/dinos/build_ambrelion.py [-- model]
import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401

# Style « plaques » (contournements locaux, les helpers restent intacts) : Skin sans subdivision (le helper fixe
# subdiv=1), primitives grossières (sphères 8 x 5, cônes <= 8 côtés), ombrage plat (une normale par face, comme en jeu).
_skin = H.dd.skin_body
H.dd.skin_body = lambda *a, **k: _skin(*a, **{**k, "subdiv": 0, "smooth_iters": SKIN_SMOOTH})
_part = H.dd.part
_build_mesh = H.build_mesh


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
SKIN_SMOOTH = 1

ID, NAME = "ambrelion", "Ambrelion"
HEIGHT = 4.0 * 1.4
COLORS = {"main": "#FF8F00", "belly": "#FFE082", "accent": "#6D4C41", "glow": "#FFCA28", "back": "#D84315"}
BG = (0.17, 0.20, 0.27)
NT = 4
NODES = [
    ("hanche", (0, 0.15, 1.55), 0.72, None),
    ("ventre", (0, -0.32, 1.62), 0.80, "hanche"),
    ("epaules", (0, -0.72, 1.90), 0.62, "ventre"),
    ("cou", (0, -0.90, 2.30), 0.55, "epaules"),
    ("cou2", (0, -0.98, 2.65), 0.58, "cou"),
    ("crane", (0, -1.20, 3.20), 1.25, "cou2"),
    ("machoire", (0, -1.85, 2.95), 0.88, "crane"),
    ("museau", (0, -2.35, 2.85), 0.66, "machoire"),
    ("nez", (0, -2.72, 2.88), 0.52, "museau"),
    ("queue1", (0, 0.68, 1.55), 0.55, "hanche"),
    ("queue2", (0, 1.05, 1.62), 0.42, "queue1"),
    ("queue3", (0, 1.38, 1.74), 0.30, "queue2"),
    ("queue4", (0, 1.64, 1.88), 0.21, "queue3"),
    ("queue5", (0, 1.86, 2.02), 0.14, "queue4"),
    # pattes courtes et épaisses
    ("bassin", (0.46, 0.08, 1.30), 0.60, None),
    ("cuisse", (0.58, -0.05, 0.95), 0.58, "bassin"),
    ("genou", (0.60, -0.22, 0.62), 0.34, "cuisse"),
    ("cheville", (0.58, 0.04, 0.32), 0.26, "genou"),
    ("pied", (0.58, -0.06, 0.17), 0.26, "cheville"),
    ("orteils", (0.58, -0.36, 0.14), 0.22, "pied"),
    # bras costauds à 3 doigts (pattes d'ours)
    ("epaule", (0.50, -0.92, 1.85), 0.20, None),
    ("coude", (0.78, -1.15, 1.55), 0.17, "epaule"),
    ("main", (0.74, -1.48, 1.55), 0.17, "coude"),
]
MOUTH_Y0 = -1.58
MOUTH_P = (0, -1.72, 2.76)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.15
BELLY_COS = 0.3
BELLY_MAX_X = 0.7
BACK_PAINT = (0.45, 0.6, 1.7, -2.0)
SMILE_LIFT = (0.16, 0.55)
TAIL_TIP = Vector((0, 1.86, 2.02))
NECK_A, NECK_B = Vector((0, -0.74, 2.0)), Vector((0, -0.98, 2.72))
EXTRA_BONES = [("Tuft", TAIL_TIP, TAIL_TIP + Vector((0, 0.5, 0)), "Tail4"),
               ("Mane", NECK_A, NECK_B, "Neck1")]
JAW_REST = 18.0  # gueule entrouverte en sourire, au repos


def neck_frame():
    """Repère du cou : axe (des épaules vers le crâne) et « haut » du collier = la nuque (vers l'arrière)."""
    ax = (NECK_B - NECK_A).normalized()
    up = Vector((0, 1, 0))
    up = (up - ax * up.dot(ax)).normalized()
    return NECK_A, NECK_B, ax, up


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.62, -1.95, 3.62), 0.52, iris=GLOW, look=(0.3, -1.0, 0.05), brow=(14, 1.0, 0.62), brow_slot=ACCENT, sink=0.42)
    B.mouth_parts(n_up=6, n_lo=5, size=0.17, inset=0.06, fangs=[(-2.2, 0.26, WHITE)])
    H.mirror_inplace(B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.17, -3.0, 3.2), -0.01),
                         scale=(0.07, 0.055, 0.045), u=6, v=4))
    # crête ondulée sur le museau : 3 plaques brunes en losange de plus en plus hautes vers le front
    for k, (y, r) in enumerate(((-2.6, 0.11), (-2.36, 0.13), (-2.1, 0.15))):
        loc, _n = B.top(y)
        B.flat("Crete%d" % k, ACCENT, gh, [(0, -0.05), (r * 1.1, r * 1.1), (0, r * 2.6), (-r * 1.1, r * 1.1)],
               H.frame_from(loc - Vector((0, 0, 0.06)), (1, 0, 0), (0, -0.3, 1)), 0.1)  # plaque en losange
    # crinière : 14 pointes d'ambre en 2 couronnes (8 + 6) autour du cou et de l'arrière du crâne
    gm = B.grp("rigid", "Mane")
    a, b, ax, up = neck_frame()
    side = Vector((1, 0, 0))
    spikes = []
    for ring, (t, angs, L, r) in enumerate(((0.95, (14, 50, 86, 122), 1.0, 0.24), (0.4, (32, 68, 104), 0.85, 0.21))):
        c = a.lerp(b, t)
        for ang in angs:
            th = math.radians(ang)
            d = (up * math.cos(th) + side * math.sin(th)).normalized()
            hit, loc, nor, _i = B.body.ray_cast(c, d)
            assert hit
            out = (d * 1.0 + nor * 0.3 + up * 0.2 + ax * (0.1 if ring == 0 else -0.05)).normalized()
            base = loc - nor * 0.1
            ob = B.cone_to("Crin%d_%d" % (ring, ang), GLOW, gm, base, out, L * (1.0 - 0.1 * (ang > 120)), r,
                           segments=4)
            H.mirror_inplace(ob)
            spikes.append((ring, ang, base, out, L))
    # 3 moustiques visibles dans les pointes avant (corps sombre + 2 ailes) : 2 symétriques + 1 à gauche
    for ring, ang, base, out, L in spikes:
        if ring == 0 and ang in (86, 50):
            p = base + out * L * 0.42
            n = out.cross(Vector((0, 0, 1))).normalized()
            if n.dot(Vector((0, -1, 0))) < 0:
                n = -n
            p = p + n * 0.1  # sur la face avant de la pointe
            obs = [B.ellipsoid("Moustique", DARK, gm, p, out, 0.2, 0.06, u=6, v=4)]
            for s in (-1, 1):
                w = [(0, 0), (0.14 * s, 0.05), (0.15 * s, 0.11), (0.04 * s, 0.07)]
                obs.append(B.flat("AileMoustique", WHITE, gm, w, H.frame_from(p + n * 0.02, n, out), 0.01))
            if ang == 86:
                B.mirror(obs)
    # touffe de queue : 5 mèches de filaments (cônes aplatis) en éventail
    gt = B.grp("rigid", "Tuft")
    for k, (ay, az, L) in enumerate(((0, 0, 0.75), (0.45, 0.25, 0.6), (-0.45, 0.25, 0.6), (0.3, -0.35, 0.55),
                                     (-0.3, -0.35, 0.55))):
        d = Vector((ay, 1.0, az)).normalized()
        ob = B.cone_to("Meche%d" % k, ACCENT, gt, TAIL_TIP - d * 0.15, d, L * 1.2, 0.2, segments=5)
        ob.data.transform(Matrix.Translation(TAIL_TIP) @ Matrix.Diagonal((1.0 if abs(ay) < 0.1 else 0.55,
                                                                          1, 0.55 if abs(ay) < 0.1 else 1, 1))
                          @ Matrix.Translation(-TAIL_TIP))
    # petites pointes triangulaires (filaments) sur le dos et la queue, et aux coudes
    for k, y in enumerate((-0.25, 0.08, 0.4, 0.72, 1.02, 1.3)):
        gi = B.grp("rigid", "Spine1" if y < 0.0 else "Hips" if y < 0.5 else "Tail1" if y < 1.0 else "Tail2")
        loc, nor = B.top(y)
        d = (Vector((0, 0.8, 1)) + nor * 0.3).normalized()
        ob = B.cone_to("Pointe%d" % k, BACK, gi, loc - nor * 0.06, d, 0.36 - 0.03 * k, 0.15, segments=3)
        ob.data.transform(Matrix.Translation(loc) @ Matrix.Diagonal((0.5, 1, 1, 1)) @ Matrix.Translation(-loc))
    ge = B.grp("rigid", "UpperArm.S")
    c = B.pos["coude"]
    H.mirror_inplace(B.cone_to("PointeCoude", BACK, ge, c + Vector((0.03, 0.12, 0.05)), (0.3, 1, 0.5), 0.3, 0.1,
                               segments=4))
    B.hands(n=3, length=0.32, r=0.11, claw=WHITE, spread=30, claw_len=0.22, down=0.25)
    B.feet(n=3, length=0.42, r=0.15, claw=WHITE, spread=30, claw_len=0.24, back=0.2)


class Anims(H.Anims):
    HEAVY = 0.3

    def extra(self, clip, t):
        amp = {"Idle": 0, "Walk": 10, "Run": 16, "Attack": 12, "Roar": 14, "Celebrate": 18, "Death": 4}[clip]
        k = {"Walk": 2, "Run": 2}.get(clip, 3)
        self.r("Mane", (R.X, 0.5 * amp * R.S2(t, k, 0.2)), (R.Y, amp * R.S2(t, k)))
        self.r("Tuft", (R.Z, 1.5 * amp * R.S2(t, k, -0.3)), (R.X, 0.5 * amp * R.S2(t, k, -0.1)))
        if clip in ("Walk", "Run"):  # grand sourire en marchant
            self.r("Jaw", (R.X, JAW_REST + 4 * R.S2(t, 2)))
        lift_toes(self, clip, t)


def lift_toes(A, clip, t):
    """Orteils relevés à la poussée (Run) et pendant la fente (Attack) : les grosses griffes ne rayent pas le sol
    (comme le pilote build_chronoraptor.py)."""
    for side, _sx in H.SIDES:
        if clip == "Run":
            ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
            k = R.keys(ph, [(0, 0), (0.2, 0), (0.36, 1), (0.55, 0.6), (0.75, 0), (1, 0)])
            A.r("Toe." + side, (R.X, -45 * k))
        elif clip == "Attack":
            k = R.keys(t, [(0, 0), (0.28, 0.4), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
            A.r("Toe." + side, (R.X, -35 * k))

    # Fier, prêt à bondir : accroupi, griffes levées ; secoue sa crinière (ébrouement), puis penche la tête
    # pour écouter ses moustiques
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        shake = R.keys(t, [(0, 0), (0.12, 0), (0.18, 1), (0.36, 1), (0.42, 0), (1, 0)])
        lst = R.keys(t, [(0, 0), (0.52, 0), (0.6, 1), (0.86, 1), (0.94, 0), (1, 0)])
        sh = shake * R.S2(t, 14)
        self.hips(z=-0.08 + 0.02 * br, rx=5 - 3 * lst, rz=2 * R.S2(t, 1))
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -2 * br - 3 * (1 - lst)), (R.Y, 3 * sh))
        H.rig.rot(P["Neck1"], (R.X, -6 * (1 - lst) + 2 * br), (R.Y, 8 * sh), (R.Z, 6 * lst))
        H.rig.rot(P["Neck2"], (R.Y, 10 * sh), (R.Z, 8 * lst))
        H.rig.rot(P["Head"], (R.X, -4 * (1 - lst) * (1 - shake) + 8 * lst), (R.Y, 12 * sh - 22 * lst),
                  (R.Z, 10 * lst + 4 * R.S2(t, 1, 0.25) * (1 - lst)))
        H.rig.rot(P["Jaw"], (R.X, JAW_REST + 3 * br + 8 * shake - 10 * lst))
        self.r("Mane", (R.Y, 18 * shake * R.S2(t, 14, 0.15)), (R.X, 6 * shake * R.S2(t, 14, 0.4)))
        self.r("Tuft", (R.Z, 14 * R.S2(t, 2, -0.3)))
        self.tail(lambda i: ((R.Z, 6 * R.S2(t, 1, -0.08 * i) + 4 * sh), (R.X, 3 + 2 * R.S2(t, 2, -0.1 * i))))
        for side, sx in H.SIDES:
            # griffes levées devant (prêt à bondir) ; main gauche à l'oreille pendant l'écoute
            lift = lst if side == "L" else 0.0
            H.rig.rot(P["UpperArm." + side], (R.X, -45 - 5 * R.S2(t, 2, 0.1) - 30 * lift), (R.Y, -sx * (10 + 12 * lift)))
            H.rig.rot(P["LowerArm." + side], (R.X, -35 - 6 * R.S2(t, 2, 0.2) - 30 * lift))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
