# DINO DICE — Tonnerrex (légendaire, théropode, taille 1,5) : modèle + rig + 7 animations + rendus.
# Version : 1
# Référence : Tyrannosaurus rex (crâne énorme et large à l'arrière, bras minuscules à 2 doigts, cuisses massives,
# queue épaisse à l'horizontale, posture penchée).
# Couche thématique : 2 cornes-paratonnerres (tige métal + 3 anneaux + boule jaune), 6 rayures zigzag jaunes sur
# chaque flanc, dernier tiers de la queue plié en éclair (2 coudes à ~40°, bout jaune), petit nuage d'orage
# (3 boules + éclair) qui flotte au-dessus de la tête (os Cloud).
# Personnalité : bruyant ; ouvre grand la gueule... rien ne sort, il s'étonne, puis rugit avec 1 s de retard.
#   python3 bb.py blender/scripts/dinos/build_tonnerrex.py [-- model]
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


LOC_BONES = ["Cloud"]

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
SKIN_SMOOTH = 1

ID, NAME = "tonnerrex", "Tonnerrex"
HEIGHT = 4.0 * 1.5
COLORS = {"main": "#1565C0", "belly": "#90CAF9", "accent": "#B0BEC5", "glow": "#FFFF00", "back": "#0D47A1"}
BG = (0.20, 0.22, 0.28)
NT = 6
NODES = [
    ("hanche", (0, 0.18, 1.55), 0.78, None),
    ("ventre", (0, -0.32, 1.62), 0.86, "hanche"),
    ("epaules", (0, -0.74, 1.88), 0.66, "ventre"),
    ("cou", (0, -0.94, 2.25), 0.62, "epaules"),
    ("cou2", (0, -1.02, 2.60), 0.64, "cou"),
    ("crane", (0, -1.25, 3.15), 1.32, "cou2"),
    ("machoire", (0, -1.95, 2.90), 0.95, "crane"),
    ("museau", (0, -2.50, 2.80), 0.72, "machoire"),
    ("nez", (0, -2.92, 2.83), 0.56, "museau"),
    # queue épaisse et horizontale, dernier tiers en éclair (haut / bas / haut, coudes ~40°)
    ("queue1", (0, 0.75, 1.58), 0.60, "hanche"),
    ("queue2", (0, 1.20, 1.64), 0.46, "queue1"),
    ("queue3", (0, 1.60, 1.70), 0.34, "queue2"),
    ("queue4", (0, 1.95, 2.15), 0.24, "queue3"),
    ("queue5", (0, 2.27, 1.72), 0.20, "queue4"),
    ("queue6", (0, 2.62, 2.12), 0.15, "queue5"),
    # cuisses massives, pattes courtes et épaisses
    ("bassin", (0.52, 0.10, 1.30), 0.64, None),
    ("cuisse", (0.64, -0.05, 0.95), 0.64, "bassin"),
    ("genou", (0.66, -0.22, 0.62), 0.36, "cuisse"),
    ("cheville", (0.62, 0.04, 0.32), 0.27, "genou"),
    ("pied", (0.62, -0.06, 0.17), 0.27, "cheville"),
    ("orteils", (0.62, -0.38, 0.14), 0.23, "pied"),
    # bras ridicules (mais grosses griffes)
    ("epaule", (0.55, -0.95, 1.78), 0.14, None),
    ("coude", (0.70, -1.10, 1.60), 0.12, "epaule"),
    ("main", (0.68, -1.28, 1.58), 0.12, "coude"),
]
MOUTH_Y0 = -1.62
MOUTH_P = (0, -1.78, 2.72)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.4
BELLY_COS = 0.42
BELLY_MAX_X = 0.6
BACK_PAINT = (0.45, 0.65, 1.7, -2.2)
SMILE_LIFT = (0.16, 0.55)
JAW_REST = 14.0
CLOUD = Vector((0, -1.2, 5.5))
EXTRA_BONES = [("Cloud", CLOUD, CLOUD + Vector((0, 0, 0.5)), "Head")]


def paint(B, me):
    # bout de queue jaune (l'éclair)
    B.paint_where(me, lambda c, n: c.y > 1.78 and c.z > 1.4, GLOW)


def flank(B, y, z):
    """Point de la peau du flanc gauche à (y, z) : rayon tiré depuis l'axe du corps vers +X."""
    hit, loc, nor, _i = B.body.ray_cast(Vector((0, y, z)), Vector((1, 0, 0)))
    assert hit, (y, z)
    return loc, nor


def strip(B, gi, p0, p1, w, name="Zig"):
    """Bande plate (4 sommets) collée au flanc, de p0 à p1 (coordonnées (y, z))."""
    (a, _n), (b, _m) = flank(B, *p0), flank(B, *p1)
    loc, nor = flank(B, (p0[0] + p1[0]) / 2, (p0[1] + p1[1]) / 2)
    d = b - a
    d = (d - nor * d.dot(nor)).normalized()
    L = (b - a).length + w
    return B.flat(name, GLOW, gi, [(-w, -L / 2), (w, -L / 2), (w, L / 2), (-w, L / 2)],
                  H.frame_from(loc + nor * 0.012, nor, d), 0.04)


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.66, -2.02, 3.6), 0.48, iris=GLOW, look=(0.3, -1.0, 0.0), brow=(20, 1.0, 0.62), brow_slot=BACK, sink=0.42)
    B.mouth_parts(n_up=7, n_lo=6, size=0.18, inset=0.06, fangs=[(-2.4, 0.28, WHITE), (-2.05, 0.22, WHITE)])
    H.mirror_inplace(B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.19, -3.2, 3.15), -0.01),
                         scale=(0.075, 0.06, 0.045), u=6, v=4))
    # cornes-paratonnerres au-dessus des yeux
    for side in (1,):
        loc, nor = B.surf((0.5 * side, -1.6, 4.6))
        d = Vector((0.35 * side, 0.25, 1)).normalized()
        base = loc - nor * 0.08
        obs = [B.cone_to("Paratonnerre", ACCENT, gh, base, d, 0.72, 0.06, r2=0.04, segments=6)]
        for k in range(3):
            obs.append(B.cone_to("Anneau%d" % k, GLOW, gh, base + d * (0.2 + 0.14 * k), d, 0.045, 0.1 - 0.012 * k,
                                 r2=0.1 - 0.012 * k, segments=8))
        obs.append(B.P("Boule", "sphere", GLOW, gh, loc=base + d * 0.8, scale=(0.13, 0.13, 0.13), u=8, v=6))
        B.mirror(obs)
    # rayures zigzag sur les flancs : 6 éclairs en 3 segments chacun
    gs = B.grp("dist", ["Hips", "Spine1", "Spine2", "Tail1"])
    for k in range(6):
        y = -0.55 + 0.33 * k
        zt, zb = 2.3 - 0.05 * k, 1.72 + 0.02 * k
        pts = [(y, zt), (y - 0.16, zt - (zt - zb) * 0.5), (y + 0.06, zt - (zt - zb) * 0.5), (y - 0.1, zb)]
        obs = [strip(B, gs, a, b, 0.05) for a, b in zip(pts, pts[1:])]
        B.mirror(obs)
    # nuage d'orage miniature + petit éclair, sur l'os Cloud
    gc = B.grp("rigid", "Cloud")
    for k, (x, y, z, r) in enumerate(((0, 0, 0.05, 0.36), (0.36, 0.05, -0.04, 0.27), (-0.36, -0.04, -0.05, 0.28),
                                      (0.12, 0.25, 0.0, 0.24), (-0.1, -0.24, 0.02, 0.25))):
        B.P("Nuage%d" % k, "sphere", ACCENT, gc, loc=CLOUD + Vector((x, y, z)),
            scale=(r, r * 0.9, r * 0.75), u=9, v=6)
    bolt = [CLOUD + Vector(v) for v in ((0.1, 0, -0.2), (-0.05, -0.03, -0.42), (0.08, -0.04, -0.46), (-0.08, -0.06, -0.7))]
    for a, b in zip(bolt, bolt[1:]):
        d = (b - a)
        mid = (a + b) / 2
        B.flat("Eclair", GLOW, gc, [(-0.04, -d.length / 2), (0.04, -d.length / 2), (0.04, d.length / 2),
                                    (-0.04, d.length / 2)], H.frame_from(mid, (0, -1, 0), d), 0.04)
    # petites pointes triangulaires bleu nuit le long du dos et de la queue
    for k, y in enumerate((-0.45, -0.12, 0.2, 0.52, 0.84, 1.16, 1.45)):
        gi = B.grp("rigid", "Spine2" if y < -0.3 else "Spine1" if y < 0.0 else "Hips" if y < 0.5 else
                   "Tail1" if y < 1.0 else "Tail2")
        loc, nor = B.top(y)
        d = (Vector((0, 0.7, 1)) + nor * 0.3).normalized()
        ob = B.cone_to("Pointe%d" % k, BACK, gi, loc - nor * 0.06, d, 0.34 - 0.02 * k, 0.15, segments=3)
        ob.data.transform(Matrix.Translation(loc) @ Matrix.Diagonal((0.5, 1, 1, 1)) @ Matrix.Translation(-loc))
    B.hands(n=2, length=0.2, r=0.085, claw=WHITE, spread=22, claw_len=0.18, down=0.25)
    B.feet(n=3, length=0.44, r=0.16, claw=WHITE, spread=30, claw_len=0.26, back=0.22)



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

class Anims(H.Anims):
    HEAVY = 0.8
    ARM_SCALE = 0.7
    JAW_OPEN = 52.0

    def extra(self, clip, t):
        amp = {"Idle": 0, "Walk": 0.06, "Run": 0.1, "Attack": 0.08, "Roar": 0.12, "Celebrate": 0.15, "Death": 0}[clip]
        k = {"Walk": 2, "Run": 2}.get(clip, 3)
        H.rig.loc(self.P["Cloud"], (0, 0, amp * self.u * R.S2(t, k)))
        self.r("Cloud", (R.Y, 60 * amp * R.S2(t, k, 0.25)))
        if clip in ("Walk", "Run"):  # grand sourire en marchant
            self.r("Jaw", (R.X, JAW_REST + 4 * R.S2(t, 2)))
        lift_toes(self, clip, t)

    # Bruyant : grande gueule ouverte... silence, il s'étonne (tête penchée), puis RUGIT avec 1 s de retard
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        op = R.keys(t, [(0, 0), (0.1, 0), (0.2, 1), (0.42, 1), (0.48, 0.25), (0.6, 0.25), (0.66, 1.2), (0.86, 1.2),
                        (0.95, 0), (1, 0)])
        huh = R.keys(t, [(0, 0), (0.24, 0), (0.3, 1), (0.42, 1), (0.52, 0), (1, 0)])
        rr = R.keys(t, [(0, 0), (0.6, 0), (0.66, 1), (0.86, 1), (0.94, 0), (1, 0)])
        sh = rr * R.S2(t, 9)
        self.hips(z=-0.08 + 0.02 * br - 0.04 * rr, rx=5 - 9 * rr + 2 * huh, rz=2 * R.S2(t, 1))
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -1.5 * br - 3 * rr))
        H.rig.rot(P["Neck1"], (R.X, 2 * br - 6 * op * (1 - rr) - 10 * rr))
        H.rig.rot(P["Neck2"], (R.X, -4 * rr), (R.Z, 8 * huh))
        H.rig.rot(P["Head"], (R.X, -6 * op + 4 * sh), (R.Z, 6 * sh + 12 * huh), (R.Y, -18 * huh))
        H.rig.rot(P["Jaw"], (R.X, JAW_REST * (1 - min(1.0, op)) + 2 * max(0.0, br) + 42 * op))
        self.tail(lambda i: ((R.Z, 4 * R.S2(t, 1, -0.08 * i) + 2 * R.S2(t, 9, -0.1 * i) * rr),
                             (R.X, 2 * R.S2(t, 2, -0.1 * i) + 3 * rr)))
        # petits bras levés, griffes en avant (prêt à bondir)
        self.arms(-50 - 8 * R.S2(t, 2, 0.1) - 30 * rr + 25 * huh, -40 - 10 * R.S2(t, 2, 0.2) - 10 * rr, spread=20 * rr)
        # le nuage gronde pendant le rugissement
        H.rig.loc(P["Cloud"], (0, 0, (0.05 * R.S2(t, 2) + 0.08 * rr) * self.u))
        self.r("Cloud", (R.Y, 10 * sh), (R.Z, 6 * R.S2(t, 1)))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
