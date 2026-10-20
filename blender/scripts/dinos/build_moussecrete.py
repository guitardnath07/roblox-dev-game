# DINO DICE — Moussecrête (commun, théropode, taille 0,9) : modèle + rig + 7 animations + rendus.
# Version : 1
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

ID, NAME = "moussecrete", "Moussecrete"
HEIGHT = 3.6
COLORS = {"main": "#5DBB63", "belly": "#F2E8C9", "accent": "#2E7D32", "glow": "#C6FF6B", "back": "#3F9A48"}
BG = (0.20, 0.24, 0.30)
NT = 4
NODES = [
    ("hanche", (0, 0.15, 1.75), 0.62, None),
    ("ventre", (0, -0.35, 1.80), 0.72, "hanche"),
    ("epaules", (0, -0.80, 2.05), 0.54, "ventre"),
    ("cou", (0, -1.00, 2.50), 0.42, "epaules"),
    ("cou2", (0, -1.05, 2.90), 0.45, "cou"),
    ("crane", (0, -1.25, 3.38), 1.0, "cou2"),
    ("machoire", (0, -1.80, 3.18), 0.64, "crane"),
    ("museau", (0, -2.30, 3.08), 0.47, "machoire"),
    ("nez", (0, -2.72, 3.10), 0.37, "museau"),
    ("queue1", (0, 0.70, 1.72), 0.54, "hanche"),
    ("queue2", (0, 1.12, 1.66), 0.44, "queue1"),
    ("queue3", (0, 1.48, 1.62), 0.33, "queue2"),
    ("queue4", (0, 1.76, 1.62), 0.22, "queue3"),
    ("queue5", (0, 1.95, 1.64), 0.12, "queue4"),
    ("bassin", (0.42, 0.10, 1.55), 0.50, None),
    ("cuisse", (0.52, -0.05, 1.15), 0.48, "bassin"),
    ("genou", (0.55, -0.24, 0.78), 0.27, "cuisse"),
    ("cheville", (0.53, 0.08, 0.38), 0.19, "genou"),
    ("pied", (0.53, -0.04, 0.17), 0.20, "cheville"),
    ("orteils", (0.53, -0.34, 0.13), 0.16, "pied"),
    ("epaule", (0.44, -0.95, 1.98), 0.17, None),
    ("coude", (0.68, -1.22, 1.64), 0.13, "epaule"),
    ("main", (0.62, -1.60, 1.62), 0.11, "coude"),
]
MOUTH_Y0 = -1.62
MOUTH_P = (0, -1.75, 2.98)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.15
BELLY_COS = 0.42
BELLY_MAX_X = 0.5
BACK_PAINT = (0.45, 0.55, 1.9, -2.0)
CREST = Vector((0, -1.35, 4.1))
EXTRA_BONES = [("Crest", CREST, CREST + Vector((0, 0.1, 0.6)), "Head")]


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.5, -1.85, 3.75), 0.38, iris=ACCENT, brow=(-16, 1.12, 0.42), brow_slot=BACK)
    B.mouth_parts(n_up=5, n_lo=3, size=0.08)
    # narines
    for ob in [B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.13, -2.95, 3.32), -0.01), scale=(0.05, 0.04, 0.035),
                   u=6, v=4)]:
        H.mirror_inplace(ob)
    # joues roses (air flatté)
    loc, nor = B.surf((0.62, -1.75, 3.2))
    ob = B.P("Joue", "sphere", TONGUE, gh, M=H.frame_from(loc + nor * 0.005, nor), scale=(0.17, 0.12, 0.03), u=10, v=5)
    H.mirror_inplace(ob)
    # crête de mousse : 5 grosses boules du nez au front + petites boules satellites
    gc = B.grp("rigid", "Crest")
    puffs = [(-2.45, 0.13), (-2.12, 0.15), (-1.78, 0.17), (-1.38, 0.23), (-0.98, 0.27)]
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
        B.cone_to("TigeTrefle", BACK, gc, base, d, 0.32, 0.025, segments=4, r2=0.015)
        tip = base + d * 0.32
        for j in range(3):
            a = math.radians(120 * j + 30)
            M = H.frame_from(tip, (0.2 * math.cos(a), 0.2 * math.sin(a), 1)) @ Matrix.Rotation(a - math.pi / 2, 4, "Z")
            leaf = [(0, 0), (0.07, 0.07), (0.075, 0.14), (0.035, 0.17), (0, 0.13), (-0.035, 0.17), (-0.075, 0.14),
                    (-0.07, 0.07)]
            B.flat("Feuille", GLOW, gc, leaf, M, 0.025)
    B.hands(n=3, length=0.22, r=0.068, claw=WHITE, spread=26)
    B.feet(n=3, length=0.36, r=0.11, claw=WHITE, spread=30, back=0.22)
    # quelques taches de dos plus foncées
    gs = B.grp("dist", ["Hips", "Spine1", "Spine2", "Tail1"])
    for k, (x, y) in enumerate(((0.25, -0.15), (0.32, 0.45), (0.18, 0.95))):
        loc, nor = B.surf((x, y, 3.0))
        ob = B.P("Tache", "sphere", BACK, gs, M=H.frame_from(loc + nor * 0.004, nor),
                 scale=(0.13 - 0.02 * k, 0.1 - 0.015 * k, 0.025), u=8, v=4)
        H.mirror_inplace(ob)


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
