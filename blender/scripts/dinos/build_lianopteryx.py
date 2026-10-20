# DINO DICE — Lianoptéryx (rare, ptérosaure) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 1
# Référence réelle : Rhamphorhynchus (longue queue raide terminée par une palette en losange, ailes étroites,
# museau long à dents projetées vers l'avant, cou court). Couche thématique (docs/dinos-concept.md) : ailes en
# grande feuille à nervures, palette de queue = feuille, crête = feuille recourbée vers l'arrière avec une fleur
# jaune, liane enroulée à chaque poignet prolongée par un bout de liane libre (os Vine).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_lianopteryx.py [-- model]
# Puis : blender -b blender/dinos/lianopteryx.blend --python-exit-code 1 -P blender/scripts/export_luau.py

import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from flyer_swimmer_helpers import *  # noqa: E402,F401,F403
from flyer_swimmer_helpers import Ptero, V, Matrix, SIDES, S2, keys, X, Y, Z, plane_yz, leaf, look_mat, \
    mirror_inplace, chain_resample, cycle_foot, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402
import dd_common as dd  # noqa: E402


class Lianopteryx(Ptero):
    ID, NAME = "lianopteryx", "Lianopteryx"
    COLORS = {"main": "#43A047", "belly": "#C5E1A5", "accent": "#FFEB3B", "glow": "#FF9800", "back": "#2E7D32"}
    HEIGHT = 3.8
    BG = (0.30, 0.24, 0.20)
    SKIN_ROOT = "bec3"
    NODES = [
        ("hanche", (0, 0.25, 1.25), 0.50, None),
        ("torse", (0, -0.02, 1.62), 0.56, "hanche"),
        ("poitrine", (0, -0.20, 2.00), 0.50, "torse"),
        ("cou1", (0, -0.30, 2.30), 0.32, "poitrine"),
        ("cou2", (0, -0.38, 2.55), 0.32, "cou1"),
        ("cou3", (0, -0.46, 2.80), 0.38, "cou2"),
        ("crane", (0, -0.62, 3.20), 0.74, "cou3"),
        ("bec1", (0, -1.20, 3.06), 0.44, "crane"),
        ("bec2", (0, -1.72, 2.96), 0.28, "bec1"),
        ("bec3", (0, -2.12, 2.90), 0.15, "bec2"),
        ("queue1", (0, 0.78, 1.08), 0.20, "hanche"),
        ("queue2", (0, 1.32, 0.98), 0.12, "queue1"),
        ("queue3", (0, 1.86, 0.94), 0.085, "queue2"),
        ("queue4", (0, 2.36, 0.94), 0.06, "queue3"),
        ("cuisse", (0.30, 0.20, 0.95), 0.26, None),
        ("genou", (0.38, 0.00, 0.60), 0.18, "cuisse"),
        ("cheville", (0.38, 0.12, 0.25), 0.13, "genou"),
        ("pied", (0.38, -0.20, 0.10), 0.12, "cheville"),
        ("epaule", (0.40, -0.18, 1.95), 0.20, None),
        ("coude", (1.10, -0.05, 2.30), 0.15, "epaule"),
        ("poignet", (1.80, 0.05, 2.62), 0.12, "coude"),
        ("doigt1", (2.45, 0.15, 2.85), 0.08, "poignet"),
        ("doigt2", (3.05, 0.25, 2.95), 0.06, "doigt1"),
        ("doigt3", (3.62, 0.36, 2.95), 0.035, "doigt2"),
    ]
    SPINE = ["queue4", "queue3", "queue2", "queue1", "hanche", "torse", "poitrine", "cou1", "cou2", "cou3", "crane",
             "bec1", "bec2", "bec3"]
    TAIL = ["queue1", "queue2", "queue3", "queue4"]
    NT = 3
    MOUTH = dict(P=(0, -1.4, 3.0), N=(0, -0.178, 1), y0=-0.95, gap=0.02, zmin=2.5, smile=0.09, smile_y=-1.45,
                 reach=0.36)
    JAW_BONE = ((0, -0.85, 2.92), (0, -2.12, 2.78))
    CREST_BONE = ((0, -0.45, 3.82), (0, 0.35, 4.15))
    WING_TRAIL = [(0.35, 0.30, 1.15), (1.0, 0.42, 1.25), (1.8, 0.48, 1.55), (2.6, 0.55, 2.05), (3.2, 0.56, 2.45),
                  (3.64, 0.42, 2.92)]
    WING_NC = 4
    DECIMATE = 0.72

    def wing_slot(self, u, v):
        return MAIN

    def wing(self, parts):
        super().wing(parts)
        gi = self.groups.index(next(g for g in self.groups[1:] if g[0] == "chain"))
        mid = [(0.06 + 0.92 * k / 10, 0.42 + 0.1 * math.sin(math.pi * k / 10) - 0.4 * (k / 10) ** 2) for k in range(11)]
        side = []
        for u0 in (0.22, 0.4, 0.58, 0.76):
            vm = 0.42 + 0.1 * math.sin(math.pi * (u0 - 0.06) / 0.92) - 0.4 * ((u0 - 0.06) / 0.92) ** 2
            side.append([(u0, vm), (u0 + 0.06, vm * 0.5), (u0 + 0.12, 0.04)])
            side.append([(u0, vm), (u0 + 0.07, vm + (0.92 - vm) * 0.5), (u0 + 0.13, 0.9)])
        parts.append(self.veins("Nervure", gi, [mid], 0.07, BELLY))
        parts.append(self.veins("NervureSec", gi, side, lambda k: 0.04 - 0.01 * k, BELLY))

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, self.SPINE, self.C[BELLY], cos_min=0.55,
                         limbs=set(self.ARM_NODES) | set(self.LEG_NODES), max_x=0.45)
        self.paint(me, lambda c, n: BACK if n.z > 0.55 and abs(c.x) < 0.55 and c.y > -1.0 and c.z > 1.2 else None)
        # rayures sombres sur la queue (bandes de liane)
        self.paint(me, lambda c, n: BACK if c.y > 0.9 and (c.y % 0.42) < 0.12 else None)
        self.clean_islands(me, BELLY, MAIN)

    def extras(self, body, parts):
        g_head, g_jaw = self.grp("rigid", "Head"), self.grp("rigid", "Jaw")
        self.wing(parts)
        parts += self.eyes(body, (0.52, -0.88, 3.48), 0.31, g_head, iris_slot=ACCENT, look=(-0.2, -1.4, 0.1))
        parts.append(self.part("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.1, -2.0, 3.0), -0.01),
                               scale=(0.04, 0.05, 0.03), mirror_x=True, u=5, v=3))
        # 2 dents cartoon qui dépassent (Rhamphorhynchus), + petites dents cachées, langue
        parts += self.teeth_row(body, g_head, [-1.86], -1, 0.2, 0.055, inset=0.03, seg=5)
        parts += self.teeth_row(body, g_head, [-1.55, -1.3], -1, 0.09, 0.035, inset=0.1)
        parts += self.teeth_row(body, g_jaw, [-1.7, -1.42], 1, 0.08, 0.035, inset=0.1)
        zt = self.mouth_z(-1.5) - 0.1
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.5, zt), scale=(0.13, 0.42, 0.05),
                               u=8, v=5))
        # Crête : grande feuille recourbée vers l'arrière + petite feuille, nervure, fleur jaune
        g_crest = self.grp("rigid", "Crest")
        base = dd.snap(body, (0, -0.55, 3.95), -0.08)
        for i, (ang, L, w) in enumerate(((150, 1.05, 0.30), (118, 0.6, 0.2))):
            M = Matrix.Translation(base + V((0, 0.05 * i, 0))) @ plane_yz(math.radians(ang))
            parts.append(self.flat("CreteFeuille%d" % i, MAIN if i == 0 else BACK, g_crest, leaf(L, w, 6), M, 0.07))
            parts.append(self.flat1("CreteNervure", BELLY, g_crest, [(-0.02, 0.05), (0.02, 0.05), (0.0, L * 0.85)],
                                    M @ Matrix.Translation((0, 0, 0.036))))
            parts.append(mirror_inplace(self.flat1("CreteNervure", BELLY, g_crest,
                                                   [(-0.02, 0.05), (0.0, L * 0.85), (0.02, 0.05)],
                                                   M @ Matrix.Translation((0, 0, -0.036)))))
        fc = base + V((0.0, 0.12, 0.12))
        Mf = Matrix.Translation(fc + V((0.06, 0, 0))) @ Matrix.Rotation(math.radians(90), 4, "Y") @ \
            Matrix.Rotation(math.radians(-20), 4, "X")
        for k in range(5):
            a = 2 * math.pi * k / 5
            parts.append(self.flat("Petale", ACCENT, g_crest, leaf(0.28, 0.12, 2, 0.0),
                                   Mf @ Matrix.Rotation(a, 4, "Z") @ Matrix.Translation((0, 0.03, 0)), 0.04,
                                   mirror_x=True))
        parts.append(self.part("Pistil", "sphere", GLOW, g_crest, loc=Mf.translation + V((0.03, 0, 0)),
                               scale=(0.06, 0.07, 0.07), mirror_x=True, u=6, v=4))
        # Palette de queue = feuille en losange verticale, nervure
        g_tail = self.grp("rigid", "Tail%d" % self.NT)
        tip = self.pos["queue4"] + V((0, -0.05, 0))
        M = Matrix.Translation(tip) @ plane_yz(math.radians(180))
        parts.append(self.flat("FeuilleQueue", MAIN, g_tail, [(0, 0), (0.22, 0.25), (0.26, 0.42), (0, 0.8),
                                                               (-0.26, 0.42), (-0.22, 0.25)], M, 0.06))
        parts.append(self.flat1("NervureQueue", BELLY, g_tail, [(-0.025, 0.05), (0.025, 0.05), (0, 0.7)],
                                M @ Matrix.Translation((0, 0, 0.031))))
        parts.append(mirror_inplace(self.flat1("NervureQueue", BELLY, g_tail, [(-0.025, 0.05), (0, 0.7), (0.025, 0.05)],
                                               M @ Matrix.Translation((0, 0, -0.031)))))
        # Liane enroulée au poignet (3 tours) + bout libre (os Vine.S) terminé par une petite feuille
        g_fore = self.grp("rigid", "Forearm.S")
        a, b = self.pos["coude"].lerp(self.pos["poignet"], 0.45), self.pos["poignet"]
        d = (b - a).normalized()
        e1 = d.cross(V((0, 0, 1))).normalized()
        e2 = d.cross(e1)
        pts = []
        for k in range(13):
            th = 2 * math.pi * 2.5 * k / 12
            pts.append(a.lerp(b, k / 12) + (e1 * math.cos(th) + e2 * math.sin(th)) * 0.15)
        for p0, p1 in zip(pts, pts[1:]):
            parts.append(self.cone_ab("Liane", BACK, g_fore, p0, p1, 0.045, 0.045, seg=4, mirror_x=True))
        g_vine = self.grp("rigid", "Vine.S")
        vine = self.vine_pts()
        for i, (p0, p1) in enumerate(zip(vine, vine[1:])):
            parts.append(self.cone_ab("LianeLibre", BACK, g_vine, p0, p1, 0.04 - 0.006 * i, 0.034 - 0.006 * i, seg=5,
                                      mirror_x=True))
        Ml = look_mat(vine[-1], V((0.1, 0.2, -1)), up=(1, 0, 0))
        parts.append(self.flat("FeuilleLiane", MAIN, g_vine, leaf(0.22, 0.09, 4), Ml, 0.04, mirror_x=True))
        # Griffes : 3 par pied, 1 pouce au poignet
        g_foot = self.grp("rigid", "Foot.S")
        for dx in (-0.08, 0.0, 0.08):
            t = dd.snap(body, (0.38 + dx, -0.32, 0.08), -0.02)
            parts.append(self.cone_ab("Griffe", ACCENT, g_foot, t, t + V((0, -0.14, -0.02)), 0.045, seg=4,
                                      mirror_x=True))
        t = dd.snap(body, (1.8, -0.12, 2.62), -0.02)
        g_wf = self.grp("rigid", "WingFinger1.S")
        parts.append(self.cone_ab("Pouce", ACCENT, g_wf, t, t + V((0, -0.18, 0.04)), 0.05, seg=4, mirror_x=True))

    def vine_pts(self):
        w = self.pos["poignet"] + V((0, 0.08, -0.1))
        return [w, w + V((0.03, 0.08, -0.16)), w + V((0.0, 0.14, -0.32)), w + V((0.04, 0.12, -0.46))]

    def extra_bones(self):
        out = []
        for side, sx in SIDES:
            v = self.vine_pts()
            a, b = V((v[0].x * sx, v[0].y, v[0].z)), V((v[-1].x * sx, v[-1].y, v[-1].z))
            out.append(("Vine." + side, a, b, "Forearm." + side, False, True))
        return out

    def vine(self, t, amp=12, k=2, ph=0.0):
        for side, sx in SIDES:
            self.r("Vine." + side, (X, amp * S2(t, k, ph)), (Y, sx * amp * 0.6 * S2(t, k, ph + 0.25)))

    # Idle acrobate : se balance d'une patte sur l'autre, ailes repliées en cape, queue-balancier
    def idle(self, t):
        super().idle(t)
        sway = S2(t, 2, 0.0)
        self.mv("Hips", x=0.06 * sway, z=-0.02 + 0.02 * S2(t, 4), ry=-7 * sway, rz=3 * S2(t, 1))
        self.r("Spine", (Y, 4 * sway))
        self.wings(up=-22 + 4 * S2(t, 2), sweep=30, elbow=-12, wrist=4, tip=8 + 4 * S2(t, 2, 0.2), twist=-18)
        self.tail(lambda i: ((Y, -6 * sway), (Z, 8 * S2(t, 2, -0.12 * (i + 1)))))
        self.vine(t, 10, 2, 0.1)

    def idle_feet(self, side, t, ank, toe):
        sway = S2(t, 2, 0.0)
        up = max(0.0, -sway if side == "L" else sway) * 0.16 * self.u  # la patte « délestée » se lève un peu
        return ank + V((0, 0, up)), toe + V((0, 0, up * 0.6))

    def walk(self, t):
        super().walk(t)
        self.vine(t, 18, 2, 0.15)

    def run(self, t):
        super().run(t)
        self.vine(t, 22, 1, -0.2)

    def attack(self, t):
        super().attack(t)
        self.vine(t, 25 * keys(t, [(0, 0), (0.4, 1), (1, 0)]), 3)

    def roar(self, t):
        super().roar(t)
        self.vine(t, 20, 3)

    def celebrate(self, t):
        super().celebrate(t)
        self.vine(t, 26, 4)

    def death(self, t):
        super().death(t)
        self.vine(t, 14 * keys(t, [(0, 1), (1, 0)]), 3)

    def feet(self):
        f = super().feet()
        f["Idle"] = self.idle_feet
        return f


if __name__ == "__main__":
    Lianopteryx().main()
