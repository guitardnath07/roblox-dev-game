# DINO DICE — Flaquodon (peu commun, aquatique, taille 0,8) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 1
# Référence réelle : Henodus chelyops (placodonte « tortue plate » : carapace presque carrée, plus large que longue,
# museau carré à bec, 4 nageoires courtes aux coins). Couche thématique (docs/dinos-concept.md) : carapace = disque
# de flaque avec 3 ronds de ricochet, goutte lumineuse sur le front, nénuphar de travers sur le dos, joues séparées
# (os Cheek) qui gonflent. Personnalité : susceptible (gonfle les joues, se retourne vexé puis revient).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_flaquodon.py [-- model]
# Puis : blender -b blender/dinos/flaquodon.blend --python-exit-code 1 -P blender/scripts/export_luau.py

import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from flyer_swimmer_helpers import Aqua, V, Matrix, SIDES, S2, keys, X, Y, Z, circle, frame_from, mirror_inplace, \
    MAIN, BELLY, ACCENT, DARK, GLOW, BACK, TONGUE  # noqa: E402
import dd_common as dd  # noqa: E402


class Flaquodon(Aqua):
    ID, NAME = "flaquodon", "Flaquodon"
    COLORS = {"main": "#4FC3F7", "belly": "#E1F5FE", "accent": "#0288D1", "glow": "#B3FFFF", "back": "#43A047"}
    LENGTH = 3.6  # archétype aquatique 6 studs x taille 0,8, moins la longueur de queue d'un placodonte
    HOVER = 0.45
    BG = (0.18, 0.24, 0.30)
    SKIN_ROOT = "museau"
    NODES = [
        ("corps", (0, 0.00, 1.20), (1.30, 0.55), None),
        ("poitrine", (0, -0.70, 1.24), (1.20, 0.55), "corps"),
        ("cou", (0, -1.30, 1.30), 0.52, "poitrine"),
        ("crane", (0, -1.72, 1.40), 0.64, "cou"),
        ("museau", (0, -2.22, 1.30), (0.46, 0.40), "crane"),
        ("queue1", (0, 0.80, 1.20), (0.95, 0.45), "corps"),
        ("queue2", (0, 1.40, 1.20), 0.32, "queue1"),
        ("queue3", (0, 1.85, 1.22), 0.18, "queue2"),
    ]
    SPINE = ["queue3", "queue2", "queue1", "corps", "poitrine", "cou", "crane", "museau"]
    HEAD_PATH = ["cou", "museau"]
    JAW_BONE = ((0, -1.55, 1.18), (0, -2.55, 1.10))
    MOUTH = dict(P=(0, -2.3, 1.2), N=(0, -0.08, 1), y0=-1.9, gap=0.02, zmin=0.8, smile=0.07, smile_y=-2.35,
                 reach=0.34)
    # Nageoires courtes aux 4 coins de la carapace (bord d'attaque, bord de fuite), x > 0
    FIN_F = ([(1.05, -0.90, 1.12), (1.45, -1.05, 1.00), (1.75, -1.00, 0.92)],
             [(1.10, -0.50, 1.10), (1.42, -0.65, 1.00), (1.75, -0.85, 0.92)])
    FIN_B = ([(1.00, 0.40, 1.10), (1.35, 0.58, 1.00), (1.60, 0.78, 0.94)],
             [(0.88, 0.80, 1.10), (1.18, 0.95, 1.00), (1.50, 1.00, 0.94)])
    FIN_NS, FIN_NC, FIN_THICK = 6, 3, 0.12
    SWIM_LAT, SWIM_FLIP = 0.3, 1.0  # placodonte : peu d'ondulation, nage aux nageoires
    LOC_BONES = ("Spine1", "Cheek.L", "Cheek.R")
    CHEEK = (0.50, -1.95, 1.30)
    SHELL_Z = 1.70

    def paint_body(self, me):
        self.paint(me, lambda c, n: BELLY if n.z < -0.35 else None)
        self.paint(me, lambda c, n: ACCENT if c.y < -2.45 else None)  # bec carré
        self.clean_islands(me, BELLY, MAIN)

    def extras(self, body, parts):
        g_head, g_jaw = self.grp("rigid", "Head"), self.grp("rigid", "Jaw")
        g_back = self.grp("dist", ["Spine1", "Spine2", "Tail1"])
        self.fins(parts)
        parts += self.eyes(body, (0.42, -1.85, 1.85), 0.3, g_head, iris_slot=ACCENT, look=(-0.1, -1.2, 0.25))
        parts.append(self.part("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.14, -2.62, 1.45), -0.01),
                               scale=(0.04, 0.035, 0.03), mirror_x=True, u=5, v=3))
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -2.0, self.mouth_z(-2.0) - 0.1),
                               scale=(0.16, 0.24, 0.05), u=8, v=5))
        # Joues séparées (gonflent : os Cheek.L / Cheek.R, déplacés vers l'extérieur)
        g_cheek = self.grp("rigid", "Cheek.S")
        parts.append(self.part("Joue", "sphere", MAIN, g_cheek, loc=dd.snap(body, self.CHEEK, -0.08),
                               scale=(0.2, 0.22, 0.18), mirror_x=True, u=9, v=6))
        # Goutte du front (émissive) : sphère + pointe vers le haut, un peu inclinée vers l'arrière
        top = dd.snap(body, (0, -1.85, 2.3), 0.02)
        parts.append(self.part("Goutte", "sphere", GLOW, g_head, loc=top + V((0, 0, 0.1)), scale=(0.1, 0.1, 0.11),
                               u=8, v=6))
        parts.append(self.cone_ab("GouttePointe", GLOW, g_head, top + V((0, 0, 0.16)), top + V((0, 0.06, 0.36)),
                                  0.085, 0.0, seg=8))
        # Carapace = disque de flaque 12 côtés + 3 ronds de ricochet concentriques (décalques empilés)
        c = V((0, 0.05, self.SHELL_Z))
        parts.append(self.part("Carapace", "cone", BELLY, g_back, loc=c, segments=12, r1=1.45, r2=1.4, depth=0.34))
        top_m = Matrix.Translation(c + V((0, 0, 0.171)))
        for k, (r, slot) in enumerate(((1.15, MAIN), (1.0, BELLY), (0.72, MAIN), (0.6, BELLY), (0.34, MAIN),
                                        (0.24, BELLY))):
            parts.append(self.flat1("Ricochet", slot, g_back, circle(r, 12), top_m @ Matrix.Translation((0, 0,
                                                                                                         0.004 * k))))
        # Nénuphar posé de travers : disque fendu (encoche en V) + petit bouton de fleur
        Ml = Matrix.Translation(c + V((0.55, 0.45, 0.21))) @ Matrix.Rotation(math.radians(12), 4, "Y") @ \
            Matrix.Rotation(math.radians(35), 4, "Z")
        pad = [(0, 0)] + [(0.24 * math.cos(math.radians(a)), 0.24 * math.sin(math.radians(a)))
                          for a in range(20, 341, 32)]
        parts.append(self.flat("Nenuphar", BACK, g_back, pad, Ml, 0.035))
        parts.append(self.part("Bouton", "sphere", TONGUE, g_back, loc=Ml @ V((-0.06, 0.02, 0.06)),
                               scale=(0.06, 0.06, 0.07), u=6, v=4))
        # Spatule de queue : palette plate horizontale au bout de la queue
        g_tail = self.grp("rigid", "Tail%d" % self.NT)
        tip = self.pos["queue3"]
        Mt = Matrix.Translation(tip + V((0, -0.3, 0)))
        parts.append(self.flat("Spatule", ACCENT, g_tail, [(0, 0), (0.22, 0.12), (0.3, 0.38), (0.18, 0.58), (0, 0.62),
                                                           (-0.18, 0.58), (-0.3, 0.38), (-0.22, 0.12)], Mt, 0.06))

    def extra_bones(self):
        out = []
        for side, sx in SIDES:
            a = V((self.CHEEK[0] * sx, self.CHEEK[1], self.CHEEK[2]))
            out.append(("Cheek." + side, a, a + V((0.3 * sx, 0, 0)), "Head", False, True))
        return out

    def cheeks(self, puff):
        for side, _sx in SIDES:
            self.mv("Cheek." + side, y=0.09 * puff)

    # Susceptible : nage sur place, gonfle les joues, se retourne vexé (dos tourné), boude, puis revient
    def idle(self, t):
        super().idle(t)
        puff = keys(t, [(0, 0), (0.12, 0), (0.2, 1), (0.8, 1), (0.88, 0), (1, 0)])
        turn = keys(t, [(0, 0), (0.25, 0), (0.4, 1), (0.66, 1), (0.82, 0), (1, 0)])
        huff = keys(t, [(0, 0), (0.42, 0), (0.46, 1), (0.52, 0), (0.56, 1), (0.62, 0), (1, 0)])
        self.mv("Spine1", z=0.06 * S2(t, 2) + 0.05 * huff, rz=150 * turn + 3 * S2(t, 1), rx=-3 * huff)
        self.r("Head", (X, -10 * puff + 6 * huff), (Z, 8 * (1 - turn) * S2(t, 1)))
        self.r("Jaw", (X, 0))
        self.cheeks(puff + 0.3 * huff)

    def attack(self, t):
        super().attack(t)
        self.cheeks(keys(t, [(0, 0), (0.25, 1), (0.4, 0), (1, 0)]))

    def roar(self, t):
        super().roar(t)
        self.cheeks(keys(t, [(0, 0), (0.15, 1), (0.28, 0), (1, 0)]))

    def celebrate(self, t):
        super().celebrate(t)
        self.cheeks(0.6 + 0.4 * S2(t, 4))

    def death(self, t):
        super().death(t)
        self.cheeks(keys(t, [(0, 0), (0.1, 1), (0.4, 0), (1, 0)]))


if __name__ == "__main__":
    Flaquodon().main()
