# DINO DICE — Cristalodon (épique, aquatique) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 1 (style n°1 + n°2 du brief : tête énorme, yeux immenses à paupière « fard », sourire à petites dents,
#   rendu en plaques/facettes, mesh final en flat)
# Référence réelle : Ophthalmosaurus icenicus (ichthyosaure « lézard-œil » : corps en goutte, rostre fin, yeux
# ÉNORMES, caudale en croissant à 2 lobes, dorsale triangulaire). Couche thématique (docs/dinos-concept.md) :
# dorsale remplacée par une grappe de 5 cristaux hexagonaux (0,15 à 0,5 x 1,2), nageoires pectorales taillées en
# facettes, caudale = 2 lobes diamant (gemmes à 8 pans), anneau oculaire facetté, petit lustre à 3 pendeloques
# sous le menton. Posé au sol (ventre + nageoires), queue relevée pour que la caudale ne touche pas le sol.
# Taille : HEIGHT = 3,0 studs (base aquatique, cf. build_flaquodon.py) x 1,2.
#   python3 <scratchpad>/bb.py blender/scripts/dinos/build_cristalodon.py [-- model]

import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_flaquodon import AquaLand  # noqa: E402
from flyer_swimmer_helpers import V, SIDES, S2, keys, X, Y, Z, pulse, \
    MAIN, BELLY, ACCENT, GLOW, BACK, TONGUE, DARK  # noqa: E402
import dd_common as dd  # noqa: E402


class Cristalodon(AquaLand):
    ID, NAME = "cristalodon", "Cristalodon"
    COLORS = {"main": "#7E57C2", "belly": "#E1BEE7", "accent": "#80DEEA", "glow": "#E0F7FA", "back": "#4527A0"}
    HEIGHT = 3.0 * 1.2
    SKIN_ROOT = "corps"
    SMOOTH = 2
    NODES = [
        ("corps", (0, 0.10, 0.62), 0.66, None),
        ("poitrine", (0, -0.35, 0.68), 0.62, "corps"),
        ("cou", (0, -0.80, 0.82), 0.56, "poitrine"),
        ("tete", (0, -1.30, 1.05), 0.90, "cou"),
        ("museau", (0, -1.98, 0.86), 0.36, "tete"),
        ("bec", (0, -2.32, 0.80), 0.20, "museau"),
        ("queue1", (0, 0.62, 0.66), 0.44, "corps"),
        ("queue2", (0, 1.00, 0.78), 0.28, "queue1"),
        ("queue3", (0, 1.30, 0.95), 0.16, "queue2"),
        ("queue4", (0, 1.50, 1.12), 0.09, "queue3"),
    ]
    SPINE_PATH = ["corps", "poitrine", "cou"]
    HEAD_PATH = ["cou", "bec"]
    TAIL_PATH = ["corps", "queue1", "queue2", "queue3", "queue4"]
    MOUTH = dict(P=(0, -2.0, 0.76), N=(0, 0.0, 1), y0=-1.45, gap=0.07, zmin=0.3, smile=0.14, smile_y=-2.1,
                 reach=0.34, shell=0.05)
    JAW_BONE = ((0, -1.4, 0.7), (0, -2.38, 0.7))
    FIN_F = ([(0.45, -0.50, 0.50), (0.85, -0.45, 0.25), (1.15, -0.15, 0.05)],
             [(0.48, -0.12, 0.46), (0.80, 0.00, 0.22), (1.00, 0.12, 0.05)])
    FIN_B = ([(0.36, 0.50, 0.42), (0.58, 0.68, 0.22), (0.76, 0.86, 0.06)],
             [(0.30, 0.74, 0.46), (0.46, 0.88, 0.26), (0.58, 1.00, 0.08)])
    FIN_NS, FIN_NC, FIN_THICK = 3, 2, 0.12
    EYE = ((0.48, -1.62, 1.40), 0.42)
    CRAWL = (22, 22)

    def fin_slot(self, u, v):
        return ACCENT if u > 0.78 else (BELLY if v > 0.6 else MAIN)

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, ["queue4", "queue3", "queue2", "queue1", "corps", "poitrine", "cou", "tete",
                                          "museau", "bec"], self.C[BELLY], cos_min=0.5)
        # chevrons dorsaux plus foncés (facettes « taillées »)
        self.paint(me, lambda c, n: BACK if n.z > 0.45 and -1.0 < c.y < 2.0 and (c.y + 2 * abs(c.x)) % 0.42 < 0.14
                   else None)
        self.clean_islands(me, BELLY, MAIN)

    def extras(self, body, parts):
        g_head, g_jaw, g_body = self.grp("rigid", "Head"), self.grp("rigid", "Jaw"), self.grp("rigid", "Spine1")
        self.fins(parts)
        # Yeux immenses (« lézard-œil »), paupière fardée calme, anneau oculaire facetté à 8 pans
        tgt, es = self.EYE
        self.eyes_styled(body, parts, g_head, tgt, es, (-0.6, -1.5, 0.0), ACCENT, lid_slot=BACK,
                         lid_n=(-0.15, -0.25, 1.0), lid_d=0.68, ring_slot=GLOW)
        # Grappe de 5 cristaux hexagonaux (prisme + pointe) à la place de la dorsale
        for dx, dy, h, lx, ly in ((0.0, -0.05, 0.62, 0.0, -0.1), (0.15, -0.26, 0.44, 0.25, -0.2),
                                  (-0.14, -0.22, 0.38, -0.25, -0.15), (0.12, 0.20, 0.30, 0.2, 0.25),
                                  (-0.1, 0.22, 0.2, -0.2, 0.3)):
            b = dd.snap(body, (dx, dy, 1.6), -0.06)
            d = V((lx, ly, 1.0)).normalized()
            r = 0.07 + 0.08 * h
            parts.append(self.cone_ab("Cristal", ACCENT, g_body, b, b + d * h * 0.72, r, r, seg=6))
            parts.append(self.cone_ab("CristalPointe", GLOW, g_body, b + d * h * 0.72, b + d * h, r, 0.0, seg=6))
        # Caudale : 2 lobes diamant (gemmes à 8 pans) en croissant
        g_tail = self.grp("rigid", "Tail%d" % self.NT)
        q = self.pos["queue4"]
        for tip in ((0, 1.92, 1.75), (0, 1.88, 0.72)):
            parts += self.gem("LobeDiamant", GLOW, g_tail, q + V((0, -0.06, 0)), V(tip), 0.17, k=0.35)
        # Petites pointes sur la queue
        for i, (qn, bone) in enumerate((("queue1", "Tail2"), ("queue2", "Tail3"), ("queue3", "Tail4"))):
            b = dd.snap(body, self.pos[qn] + V((0, 0.05, 0.6)), -0.03)
            parts.append(self.cone_ab("Pointe", BACK, self.grp("rigid", bone), b, b + V((0, 0.08, 0.16 - 0.03 * i)),
                                      0.08, 0.0, seg=4, scale_x=0.45))
        # Sourire à petites dents triangulaires le long du rostre
        parts += self.teeth_arc(body, g_head, (0, 40), -1, 0.11, 0.045, inset=0.03, yc=-2.1, side_ys=(-1.86, -1.66))
        parts += self.teeth_arc(body, g_jaw, (22,), 1, 0.09, 0.04, inset=0.03, yc=-2.1, side_ys=(-1.95, -1.75))
        zt = self.mouth_z(-1.8) - 0.07
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.78, zt), scale=(0.13, 0.26, 0.04),
                               u=6, v=4))
        parts.append(self.part("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.1, -2.2, 1.0), -0.01),
                               scale=(0.03, 0.04, 0.025), mirror_x=True, u=5, v=3))
        # Petit lustre sous le menton : barre + 3 pendeloques (gemmes à 4 pans)
        ch = dd.snap(body, (0, -1.8, 0.2), -0.02)
        bar = ch + V((0, 0, -0.1))
        parts.append(self.cone_ab("LustreTige", ACCENT, g_jaw, ch, bar, 0.02, 0.02, seg=4))
        parts.append(self.cone_ab("LustreBarre", ACCENT, g_jaw, bar + V((-0.13, 0, 0)), bar + V((0.13, 0, 0)), 0.025,
                                  0.025, seg=4))
        for dx in (-0.12, 0.0, 0.12):
            p0 = bar + V((dx, 0, -0.01))
            parts += self.gem("Pendeloque", GLOW, g_jaw, p0, p0 + V((0, 0, -0.16 - 0.04 * (dx == 0))), 0.045,
                              k=0.4, seg=4)
        self.claws(parts, n=(0.2, 0.6), L=0.12, r=0.045)

    # Idle élégant : ondule lentement, puis petite pirouette sur lui-même, nageoires écartées comme une danseuse
    def idle(self, t):
        super().idle(t)
        pir = keys(t, [(0, 0), (0.38, 0), (0.62, 1), (1, 1)])
        p = pulse(t, 0.36, 0.66)
        self.mv("Spine1", z=0.02 + 0.06 * p + 0.012 * S2(t, 3), rz=(360 * pir) % 360)
        self.body_wave_land(t, 4)
        self.fins_pose(lambda key: dict(up=(30 if key == "F" else 10) * p + 5 * (1 + S2(t, 2)), sweep=-10 * p,
                                        twist=-12 * p))
        self.r("Head", (X, -8 * p), (Y, 10 * p))

    def body_wave_land(self, t, amp):
        for i in range(1, self.NS):
            self.r("Spine%d" % (i + 1), (Z, amp * 0.6 * S2(t, 1, 0.1 * i)))
        self.tail(lambda i: ((Z, amp * (1.2 + 0.6 * i) * S2(t, 1, -0.12 * (i + 1))), (X, 3)))

    # le lustre pend sous le menton : la tête ne pique pas vers le sol (attaque en morsure « de côté »)
    def attack(self, t):
        super().attack(t)
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.58, 1), (0.86, 0), (1, 0)])
        self.mv("Spine1", y=0.15 * a - 0.3 * s, z=0.05 + 0.08 * a + 0.12 * s)
        self.r("Head", (X, -14 * a - 6 * s), (Y, 18 * s), (Z, 6 * s * S2(t, 3)))

    def roar(self, t):
        super().roar(t)
        a = keys(t, [(0, 0), (0.16, 1), (0.26, 0), (1, 0)])
        r = keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        self.r("Head", (X, -6 * a - 14 * r + 3 * r * S2(t, 7)), (Z, 6 * r * S2(t, 7)))
        for b in self.NECK:
            self.r(b, (X, (-6 * a - 30 * r) / len(self.NECK)))

    def celebrate(self, t):
        super().celebrate(t)
        self.r("Head", (X, -10), (Y, 14 * S2(t, 2)))


if __name__ == "__main__":
    Cristalodon().main()
