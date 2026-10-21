# DINO DICE — Sablegriffe (peu commun, théropode, taille 1,0) : modèle + rig + 7 animations + rendus.
# Version : 1
# Référence : Mononykus (bras minuscules à UNE grosse griffe, longues pattes fines de coureur, queue longue).
# Style chibi (références du 21/10/2026 : grosse tête, gros yeux, grosses griffes, posture de combat).
# Couche thématique : griffes = pelles de plage, bandeau de sport sur le front, 3 rayures de dune sur le dos.
# Personnalité : sportif (boxe dans le vide, sautille sur place).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_sablegriffe.py [-- model]
import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401

ID, NAME = "sablegriffe", "Sablegriffe"
HEIGHT = 4.0
COLORS = {"main": "#E8C07D", "belly": "#F7E6BE", "accent": "#FF7043", "glow": "#FFD180", "back": "#C68B4E"}
BG = (0.22, 0.24, 0.30)
NT = 5
NODES = [
    ("hanche", (0, 0.15, 2.05), 0.58, None),
    ("ventre", (0, -0.33, 2.10), 0.66, "hanche"),
    ("epaules", (0, -0.75, 2.35), 0.50, "ventre"),
    ("cou", (0, -0.95, 2.80), 0.42, "epaules"),
    ("cou2", (0, -1.05, 3.20), 0.45, "cou"),
    ("crane", (0, -1.25, 3.72), 1.20, "cou2"),
    ("machoire", (0, -1.80, 3.48), 0.70, "crane"),
    ("museau", (0, -2.18, 3.40), 0.54, "machoire"),
    ("nez", (0, -2.50, 3.40), 0.46, "museau"),
    ("queue1", (0, 0.75, 2.00), 0.50, "hanche"),
    ("queue2", (0, 1.25, 1.95), 0.38, "queue1"),
    ("queue3", (0, 1.70, 1.92), 0.27, "queue2"),
    ("queue4", (0, 2.10, 1.92), 0.17, "queue3"),
    ("queue5", (0, 2.42, 1.95), 0.09, "queue4"),
    ("bassin", (0.40, 0.10, 1.85), 0.46, None),
    ("cuisse", (0.48, -0.05, 1.42), 0.42, "bassin"),
    ("genou", (0.50, -0.25, 0.95), 0.20, "cuisse"),
    ("cheville", (0.48, 0.12, 0.42), 0.14, "genou"),
    ("pied", (0.48, 0.00, 0.15), 0.15, "cheville"),
    ("orteils", (0.48, -0.30, 0.12), 0.13, "pied"),
    ("epaule", (0.40, -0.92, 2.15), 0.16, None),
    ("coude", (0.55, -1.12, 1.95), 0.13, "epaule"),
    ("main", (0.52, -1.32, 1.92), 0.12, "coude"),
]
MOUTH_Y0 = -1.55
MOUTH_P = (0, -1.9, 3.22)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.0
SUBDIV, SHARP = 0, 1.0  # style « plaques » (demande du 21/10/2026) : peu de faces, toutes à plat
BELLY_COS = 0.42
BELLY_MAX_X = 0.5
BACK_PAINT = (2.0, 0.0, 99.0, 99.0)  # pas de dos foncé : le slot « back » sert aux rayures de dune


def paint(B, me):
    # 3 rayures de dune en zigzag sur le dos (texture = couleur par face)
    def dune(c, n):
        if n.z < 0.35 or c.y < -0.7 or c.y > 1.6 or c.z < 1.9:
            return False
        zig = 0.12 * abs(((c.x * 4.0) % 2.0) - 1.0)
        return ((c.y + zig + 0.6) % 0.6) < 0.16
    B.paint_where(me, dune, BACK)


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.eyes((0.6, -1.75, 4.05), 0.44, iris=ACCENT, brow=(18, 0.95, 0.5), brow_slot=BACK)
    B.mouth_parts(n_up=6, n_lo=4, size=0.1, smile=0.3)
    for ob in [B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.16, -2.85, 3.55), -0.01), scale=(0.05, 0.04, 0.035),
                   u=6, v=4)]:
        H.mirror_inplace(ob)
    # Bandeau de sport : anneau un peu incliné autour du crâne + nœud à l'arrière
    c = B.pos["crane"] + Vector((0, 0.3, 0.38))
    B.P("Bandeau", "cone", ACCENT, gh, M=Matrix.Translation(c) @ Matrix.Rotation(math.radians(-24), 4, "X"),
        segments=16, r1=1.0, r2=0.94, depth=0.18)
    knot = B.snap((0, 0.2, 4.0), 0.04)
    B.P("Noeud", "sphere", ACCENT, gh, loc=knot, scale=(0.12, 0.1, 0.1), u=8, v=5)
    for sx in (1, -1):
        B.cone_to("PanBandeau", ACCENT, gh, knot, (0.3 * sx, 1, -0.6), 0.4, 0.07, segments=4, r2=0.03)
    # Une pelle de plage par bras (bras minuscules, 1 énorme « griffe ») : manche court + lame
    g = B.grp("rigid", "LowerArm.S")
    h, e = B.pos["main"], B.pos["coude"]
    d = ((h - e).normalized() + Vector((0, -0.6, -0.2))).normalized()
    B.cone_to("Manche", BACK, g, h, d, 0.22, 0.045, segments=6, r2=0.045)
    tip = h + d * 0.2
    M = H.frame_from(tip, (0, -1, 0.35), (0, 0, 1)) @ Matrix.Translation((0, -0.05, 0))
    blade = [(x * 1.6, y * 1.6) for x, y in ((-0.17, 0.0), (0.17, 0.0), (0.2, -0.18), (0.14, -0.3), (0.0, -0.36),
                                              (-0.14, -0.3), (-0.2, -0.18))]
    B.flat("Pelle", ACCENT, g, blade, M, 0.07)
    B.mirror([b for b in B.parts[-2:]])
    B.feet(n=3, length=0.32, r=0.09, claw=WHITE, spread=30, back=0.18)


class Anims(H.Anims):
    ARM_SCALE = 1.3

    def jabs(self, t, amp=1.0):
        """Direct gauche-droite alterné (épaule en avant, avant-bras tendu)."""
        for side, sx in H.SIDES:
            j = max(0.0, R.S2(t, 4, 0.0 if side == "L" else 0.5)) ** 2 * amp
            H.rig.rot(self.P["UpperArm." + side], (R.X, -60 - 20 * j), (R.Y, -sx * 10 * j))
            H.rig.rot(self.P["LowerArm." + side], (R.X, -60 + 60 * j))

    def bounce(self, t):
        return abs(math.sin(2 * math.pi * 4 * t))

    # Sportif : garde haute, sautille sur place, enchaîne des directs, souffle (petite pause tête qui hoche)
    def idle(self, t):
        P = self.base()
        box = R.keys(t, [(0, 0), (0.2, 0), (0.28, 1), (0.7, 1), (0.8, 0), (1, 0)])
        b = self.bounce(t)
        self.hips(z=-0.06 + 0.1 * b, rx=4 + 3 * box, rz=4 * R.S2(t, 2) * box, ry=6 * R.S2(t, 4) * box)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, 2 * box), (R.Z, -4 * R.S2(t, 4) * box))
        H.rig.rot(P["Neck1"], (R.X, -4 * box))
        H.rig.rot(P["Head"], (R.X, 6 * box + 5 * R.S2(t, 2, 0.3) * (1 - box)), (R.Z, 8 * R.S2(t, 1) * (1 - box)))
        H.rig.rot(P["Jaw"], (R.X, 6 * (1 - box) * max(0.0, R.S2(t, 2))))
        self.tail(lambda i: ((R.Z, 6 * R.S2(t, 4, -0.08 * i) * box + 4 * R.S2(t, 1, -0.08 * i)),
                             (R.X, -4 * b)))
        self.jabs(t, box)  # garde haute, directs quand box > 0

    def idle_feet(self, side, t, ank, toe):
        up = Vector((0, 0, 0.1 * self.bounce(t) * self.u))
        return ank + up, toe + up

    def attack(self, t):
        super().attack(t)
        up = R.keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.6, 1), (0.9, 0), (1, 0)])
        for side, sx in H.SIDES:  # uppercut à la pelle
            H.rig.rot(self.P["UpperArm." + side], (R.X, -45 * up))
            H.rig.rot(self.P["LowerArm." + side], (R.X, -70 * up))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
