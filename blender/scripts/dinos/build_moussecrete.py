# DINO DICE — Moussecrête (commun, théropode, taille 0,9) : modèle + rig + 7 animations + rendus.
# Version : 3 (style chibi + plaques)
# Référence : Guanlong (crête unique dans l'axe du crâne, museau long, bras à 3 doigts assez longs, bipède léger).
# Couche thématique : crête = touffe de mousse (5 boules du nez au front) + 2 trèfles, joues roses, ventre crème,
# queue courte et dodue. Personnalité : timide et flatté (se dandine, se cache le museau, la crête frétille).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_moussecrete.py [-- model]
import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401
import theropod_plaques as TP  # noqa: E402

# STYLE n°2 « plaques » + appui des pieds (local à ce build, helpers partagés intacts)
TP.apply(H.dd, R, lambda f: setattr(H, "split_sharp", f), H.split_sharp)

ID, NAME = "moussecrete", "Moussecrete"
HEIGHT = 3.6
COLORS = {"main": "#5DBB63", "belly": "#F2E8C9", "accent": "#2E7D32", "glow": "#C6FF6B", "back": "#3F9A48"}
BG = (0.20, 0.24, 0.30)
NT = 4
# Style chibi (MISE À JOUR STYLE) : tête énorme, corps court et rond, pattes courtes et épaisses,
# queue courte et dodue.
NODES = [
    ("hanche", (0, 0.15, 1.38), 0.66, None),
    ("ventre", (0, -0.24, 1.44), 0.76, "hanche"),
    ("epaules", (0, -0.56, 1.72), 0.56, "ventre"),
    ("cou", (0, -0.72, 2.08), 0.46, "epaules"),
    ("cou2", (0, -0.80, 2.42), 0.52, "cou"),
    ("crane", (0, -1.02, 2.96), 1.10, "cou2"),
    ("machoire", (0, -1.66, 2.72), 0.76, "crane"),
    ("museau", (0, -2.18, 2.62), 0.58, "machoire"),
    ("nez", (0, -2.60, 2.64), 0.46, "museau"),
    ("queue1", (0, 0.70, 1.36), 0.58, "hanche"),
    ("queue2", (0, 1.10, 1.34), 0.46, "queue1"),
    ("queue3", (0, 1.44, 1.36), 0.34, "queue2"),
    ("queue4", (0, 1.70, 1.42), 0.22, "queue3"),
    ("queue5", (0, 1.88, 1.50), 0.11, "queue4"),
    ("bassin", (0.46, 0.10, 1.18), 0.52, None),
    ("cuisse", (0.56, -0.04, 0.90), 0.52, "bassin"),
    ("genou", (0.60, -0.22, 0.56), 0.30, "cuisse"),
    ("cheville", (0.58, 0.04, 0.29), 0.22, "genou"),
    ("pied", (0.58, -0.08, 0.15), 0.22, "cheville"),
    ("orteils", (0.58, -0.36, 0.12), 0.17, "pied"),
    ("epaule", (0.50, -0.72, 1.70), 0.19, None),
    ("coude", (0.74, -0.90, 1.46), 0.15, "epaule"),
    ("main", (0.74, -1.16, 1.48), 0.14, "coude"),
]
MOUTH_Y0 = -1.46
MOUTH_P = (0, -1.62, 2.50)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.05
BELLY_COS = 0.42
BELLY_MAX_X = 0.5
BACK_PAINT = (0.45, 0.55, 1.6, -2.0)
CREST = Vector((0, -1.25, 3.95))
EXTRA_BONES = [("Crest", CREST, CREST + Vector((0, 0.1, 0.6)), "Head")]


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.5, -1.74, 3.30), 0.42, look=(0.2, -1.0, 0.1), iris=ACCENT, iris_r=0.66, pupil_r=0.38,
           brow=(-16, 0.84, 0.5), brow_slot=BACK)
    B.mouth_parts(n_up=5, n_lo=4, size=0.13)
    # narines
    for ob in [B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.14, -2.90, 2.92), -0.01), scale=(0.06, 0.045, 0.04),
                   u=6, v=4)]:
        H.mirror_inplace(ob)
    # joues roses (air flatté)
    loc, nor = B.surf((0.66, -2.0, 2.78))
    ob = B.P("Joue", "sphere", TONGUE, gh, M=H.frame_from(loc + nor * 0.005, nor), scale=(0.2, 0.14, 0.035), u=8, v=4)
    H.mirror_inplace(ob)
    # crête de mousse : 5 grosses boules du nez au front + petites boules satellites
    gc = B.grp("rigid", "Crest")
    puffs = [(-2.30, 0.15), (-1.98, 0.17), (-1.64, 0.20), (-1.24, 0.26), (-0.82, 0.30)]
    tops = []
    for k, (y, r) in enumerate(puffs):
        loc, nor = B.top(y)
        c = loc + Vector((0, 0, r * 0.45))
        tops.append((c, r))
        B.P("Mousse%d" % k, "sphere", ACCENT, gc, loc=c, scale=(r * 1.05, r, r * 0.9), u=9, v=6)
        for j, a in enumerate((60, 240)):
            d = Vector((math.cos(math.radians(a + 40 * k)) * 0.75, math.sin(math.radians(a + 40 * k)) * 0.75, 0.55))
            B.P("MousseBrin", "sphere", ACCENT if j else BACK, gc, loc=c + d * r * 0.85, scale=(r * 0.45,) * 3, u=6, v=4)
    # 2 trèfles piqués dans la mousse (tige + 3 feuilles en cœur)
    for k, (pi, tilt) in enumerate(((3, -30), (4, 26))):
        c, r = tops[pi]
        d = Vector((math.sin(math.radians(tilt)), 0.15, 1)).normalized()
        base = c + d * r * 0.6
        B.cone_to("TigeTrefle", BACK, gc, base, d, 0.4, 0.035, segments=4, r2=0.025)
        tip = base + d * 0.4
        for j in range(3):
            a = math.radians(120 * j + 30)
            M = H.frame_from(tip, (0.2 * math.cos(a), 0.2 * math.sin(a), 1)) @ Matrix.Rotation(a - math.pi / 2, 4, "Z")
            leaf = [(x * 1.7, y * 1.7) for x, y in ((0, 0), (0.07, 0.07), (0.075, 0.14), (0.035, 0.17), (0, 0.13),
                                                     (-0.035, 0.17), (-0.075, 0.14), (-0.07, 0.07))]
            B.flat("Feuille", GLOW, gc, leaf, M, 0.035)
    B.hands(n=3, length=0.26, r=0.1, claw=BELLY, spread=30, claw_len=0.17, down=0.5)
    B.feet(n=3, length=0.32, r=0.13, claw=BELLY, spread=32, back=0.24, claw_len=0.17)
    # plaques de dos plates (losanges biseautés, vert foncé) ; la plus grande porte 2 plots ronds
    for k, (y, w) in enumerate(((-0.30, 0.36), (0.12, 0.42), (0.56, 0.34), (0.98, 0.26))):
        loc, nor = B.top(y)
        bones = ["Spine1", "Spine2"] if y < -0.15 else ["Hips", "Spine1"] if y < 0.45 else ["Tail1", "Tail2"]
        g = B.grp("dist", bones)
        M = H.frame_from(loc + nor * 0.02, nor, (0, -1, 0))
        B.flat("Plaque%d" % k, BACK, g, [(0, -w * 0.6), (w * 0.5, 0), (0, w * 0.6), (-w * 0.5, 0)], M, 0.07)
        if k == 1:
            for i in (-1, 1):
                p = M @ Vector((0, i * 0.11, 0.04))
                B.cone_to("Plot", ACCENT, g, p, nor, 0.05, 0.05, segments=8, r2=0.05)


class Anims(H.Anims):
    def extra(self, clip, t):
        amp = {"Idle": 4, "Walk": 6, "Run": 9, "Attack": 8, "Roar": 10, "Celebrate": 12, "Death": 0}[clip]
        k = {"Idle": 4, "Walk": 2, "Run": 2}.get(clip, 3)
        self.r("Crest", (R.Y, amp * R.S2(t, k)), (R.X, 0.4 * amp * R.S2(t, k, 0.25)))

    # Timide et flatté : se dandine, puis se cache le museau derrière les mains (crête qui frétille), jette un œil
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        hide = R.keys(t, [(0, 0), (0.40, 0), (0.50, 1), (0.74, 1), (0.84, 0), (1, 0)])
        peek = R.keys(t, [(0, 0), (0.58, 0), (0.62, 1), (0.67, 1), (0.71, 0), (1, 0)])
        sway = R.S2(t, 2) * (1 - hide)
        self.hips(z=-0.02 + 0.02 * br - 0.08 * hide, rx=5 * hide, rz=7 * sway, ry=6 * sway)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, 3 * hide - 1.5 * br), (R.Z, -3 * sway))
        H.rig.rot(P["Neck1"], (R.X, 12 * hide), (R.Z, 8 * hide))
        H.rig.rot(P["Neck2"], (R.X, 8 * hide - 6 * peek), (R.Z, 10 * hide))
        H.rig.rot(P["Head"], (R.X, 20 * hide - 14 * peek + 3 * br * (1 - hide)), (R.Z, 14 * hide + 6 * sway),
                  (R.Y, 10 * sway - 10 * hide))
        H.rig.rot(P["Jaw"], (R.X, 2 * max(0.0, br)))
        self.tail(lambda i: ((R.Z, 10 * R.S2(t, 2, -0.08 * i) * (1 - hide) + 14 * R.S2(t, 6, -0.1 * i) * hide),
                             (R.X, 2 * R.S2(t, 2, -0.1 * i))))
        for side, sx in H.SIDES:
            H.rig.rot(P["UpperArm." + side], (R.X, -8 * R.S2(t, 2, 0.1) - 80 * hide + 25 * peek),
                      (R.Y, sx * 18 * hide), (R.Z, -sx * 10 * hide))
            H.rig.rot(P["LowerArm." + side], (R.X, -10 * R.S2(t, 2, 0.2) - 65 * hide))
        self.r("Crest", (R.Y, 4 * R.S2(t, 4) + 14 * R.S2(t, 12) * hide), (R.X, 3 * R.S2(t, 2)))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
