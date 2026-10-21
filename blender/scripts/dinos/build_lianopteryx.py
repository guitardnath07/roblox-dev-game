# DINO DICE — Lianoptéryx (rare, ptérosaure) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 2 (style du joueur : chibi « à plaques » — tête énorme, gros yeux à sourcils, dents et griffes
# lisibles, mains en patte d'ours, facettes planes, blocs séparés, plaques dorsales ; voir ptero_chibi.py)
# Référence réelle : Rhamphorhynchus (longue queue raide terminée par une palette en losange, ailes étroites,
# museau long à dents projetées vers l'avant, cou court). Couche thématique (docs/dinos-concept.md) : ailes en
# grande feuille à nervures, palette de queue = feuille, crête = feuille recourbée vers l'arrière avec une fleur
# jaune, liane enroulée à chaque poignet prolongée par un bout de liane libre (os Vine).
# Personnalité : acrobate (se balance d'une patte sur l'autre, ailes repliées en cape, pattes levées).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_lianopteryx.py [-- model]
# Puis : blender -b blender/dinos/lianopteryx.blend --python-exit-code 1 -P blender/scripts/export_luau.py

import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from flyer_swimmer_helpers import V, Matrix, SIDES, S2, keys, X, Y, Z, plane_yz, leaf, look_mat, \
    mirror_inplace, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402
from ptero_chibi import ChibiPtero  # noqa: E402
import dd_common as dd  # noqa: E402


class Lianopteryx(ChibiPtero):
    ID, NAME = "lianopteryx", "Lianopteryx"
    COLORS = {"main": "#43A047", "belly": "#C5E1A5", "accent": "#FFEB3B", "glow": "#FF9800", "back": "#2E7D32"}
    HEIGHT = 3.8
    BG = (0.30, 0.24, 0.20)
    NODES = [
        ("hanche", (0, 0.18, 1.10), 0.54, None),
        ("torse", (0, -0.02, 1.42), 0.58, "hanche"),
        ("poitrine", (0, -0.16, 1.74), 0.50, "torse"),
        ("cou1", (0, -0.24, 1.98), 0.36, "poitrine"),
        ("cou2", (0, -0.30, 2.16), 0.36, "cou1"),
        ("cou3", (0, -0.36, 2.34), 0.42, "cou2"),
        ("crane", (0, -0.52, 2.84), 0.86, None),  # tête = bloc séparé du cou
        ("bec1", (0, -1.26, 2.66), 0.46, "crane"),
        ("bec2", (0, -1.86, 2.56), 0.28, "bec1"),
        ("bec3", (0, -2.32, 2.50), 0.13, "bec2"),
        ("queue1", (0, 0.70, 1.00), 0.22, "hanche"),
        ("queue2", (0, 1.25, 0.94), 0.14, "queue1"),
        ("queue3", (0, 1.80, 0.92), 0.10, "queue2"),
        ("queue4", (0, 2.32, 0.92), 0.07, "queue3"),
        ("cuisse", (0.32, 0.12, 0.92), 0.31, None),
        ("genou", (0.40, 0.00, 0.56), 0.23, "cuisse"),
        ("cheville", (0.40, 0.08, 0.25), 0.18, "genou"),
        ("pied", (0.40, -0.18, 0.13), 0.16, "cheville"),
        ("epaule", (0.42, -0.14, 1.72), 0.23, None),
        ("coude", (1.08, -0.02, 2.00), 0.17, "epaule"),
        ("poignet", (1.72, 0.06, 2.26), 0.14, "coude"),
        ("doigt1", (2.32, 0.15, 2.44), 0.085, "poignet"),
        ("doigt2", (2.90, 0.26, 2.50), 0.06, "doigt1"),
        ("doigt3", (3.40, 0.38, 2.46), 0.035, "doigt2"),
    ]
    SPINE = ["queue4", "queue3", "queue2", "queue1", "hanche", "torse", "poitrine", "cou1", "cou2", "cou3", "crane",
             "bec1", "bec2", "bec3"]
    TAIL = ["queue1", "queue2", "queue3", "queue4"]
    NT = 3
    MOUTH = dict(P=(0, -1.65, 2.54), N=(0, -0.15, 1), y0=-0.85, gap=0.025, zmin=2.15, smile=0.16, smile_y=-1.5,
                 reach=0.42)
    JAW_BONE = ((0, -0.62, 2.46), (0, -2.32, 2.36))
    CREST_BONE = ((0, -0.40, 3.42), (0, 0.45, 3.75))
    # ailes étroites (Rhamphorhynchus) : corde plus courte que chez les grands ptérosaures
    WING_TRAIL = [(0.34, 0.30, 1.02), (0.95, 0.44, 1.08), (1.65, 0.52, 1.32), (2.4, 0.56, 1.75), (3.0, 0.52, 2.12),
                  (3.40, 0.38, 2.46)]
    EYE = ((0.40, -1.18, 3.02), 0.37)

    def wing_slot(self, u, v):
        return MAIN

    def extras(self, body, parts):
        g_head, g_jaw = self.grp("rigid", "Head"), self.grp("rigid", "Jaw")
        self.wing(parts)
        gi = self.groups.index(next(g for g in self.groups[1:] if g[0] == "chain"))
        # nervures de la feuille-aile : nervure centrale + 6 secondaires, en segments droits
        mid = [(0.06 + 0.9 * k / 5, 0.45 - 0.3 * (k / 5) ** 2) for k in range(6)]
        side = []
        for u0 in (0.24, 0.46, 0.68):
            vm = 0.45 - 0.3 * ((u0 - 0.06) / 0.9) ** 2
            side.append([(u0, vm), (u0 + 0.12, 0.05)])
            side.append([(u0, vm), (u0 + 0.13, 0.92)])
        parts.append(self.veins("Nervure", gi, [mid], 0.08, BELLY))
        parts.append(self.veins("NervureSec", gi, side, lambda k: 0.05, BELLY))
        # gros yeux (iris jaune vif, grosse pupille, reflets), sourcils d'acrobate (malicieux, un peu relevés)
        target, size = self.EYE
        parts += self.eyes(body, target, size, g_head, iris_slot=ACCENT, look=(0.32, -1.0, 0.1), sink=0.4)
        parts.append(self.brow(g_head, BACK, size, tilt=0.04, lift=1.15))
        parts.append(self.part("Narine", "cube", DARK, g_head, loc=dd.snap(body, (0.09, -2.15, 2.6), -0.01),
                               scale=(0.045, 0.07, 0.03), mirror_x=True))
        # 2 grandes dents cartoon projetées vers l'avant (Rhamphorhynchus) + petites dents visibles, langue
        parts += self.teeth_row(body, g_head, [-2.12], -1, 0.26, 0.08, inset=0.03, seg=4)
        parts += self.teeth_row(body, g_head, [-1.8, -1.5, -1.2], -1, 0.13, 0.055, inset=0.06, seg=4)
        parts += self.teeth_row(body, g_jaw, [-1.95, -1.65, -1.35], 1, 0.12, 0.05, inset=0.06, seg=4)
        zt = self.mouth_z(-1.55) - 0.12
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.55, zt), scale=(0.17, 0.48, 0.06),
                               u=6, v=3))
        # crête : grande feuille recourbée vers l'arrière + petite feuille, nervures, fleur jaune (5 pétales)
        g_crest = self.grp("rigid", "Crest")
        base = dd.snap(body, (0, -0.45, 3.75), -0.1)
        for i, (ang, L, w) in enumerate(((150, 1.15, 0.34), (118, 0.68, 0.22))):
            M = Matrix.Translation(base + V((0, 0.05 * i, 0))) @ plane_yz(math.radians(ang))
            parts.append(self.flat("CreteFeuille%d" % i, MAIN if i == 0 else BACK, g_crest, leaf(L, w, 3), M, 0.09))
            for sgn in (1, -1):
                nv = self.flat1("CreteNervure", BELLY, g_crest, [(-0.025, 0.05), (0.025, 0.05), (0.0, L * 0.85)],
                                M @ Matrix.Translation((0, 0, 0.047 * sgn)))
                parts.append(mirror_inplace(nv) if sgn < 0 else nv)
        fc = base + V((0.0, 0.14, 0.14))
        Mf = Matrix.Translation(fc + V((0.07, 0, 0))) @ Matrix.Rotation(math.radians(90), 4, "Y") @ \
            Matrix.Rotation(math.radians(-20), 4, "X")
        for k in range(5):
            a = 2 * math.pi * k / 5
            parts.append(self.flat("Petale", ACCENT, g_crest, leaf(0.3, 0.13, 1, 0.0),
                                   Mf @ Matrix.Rotation(a, 4, "Z") @ Matrix.Translation((0, 0.03, 0)), 0.05,
                                   mirror_x=True))
        parts.append(self.part("Pistil", "cube", GLOW, g_crest, loc=Mf.translation + V((0.035, 0, 0)),
                               scale=(0.11, 0.12, 0.12), mirror_x=True))
        # palette de queue = feuille en losange verticale (prisme), nervure
        g_tail = self.grp("rigid", "Tail%d" % self.NT)
        tip = self.pos["queue4"] + V((0, -0.05, 0))
        M = Matrix.Translation(tip) @ plane_yz(math.radians(180))
        parts.append(self.flat("FeuilleQueue", MAIN, g_tail, [(0, 0), (0.24, 0.26), (0.28, 0.44), (0, 0.85),
                                                               (-0.28, 0.44), (-0.24, 0.26)], M, 0.08))
        for sgn in (1, -1):
            nv = self.flat1("NervureQueue", BELLY, g_tail, [(-0.03, 0.05), (0.03, 0.05), (0, 0.75)],
                            M @ Matrix.Translation((0, 0, 0.042 * sgn)))
            parts.append(mirror_inplace(nv) if sgn < 0 else nv)
        # liane enroulée au poignet (2,5 tours, segments à 3 pans) + bout libre (os Vine.S) terminé par une feuille
        g_fore = self.grp("rigid", "Forearm.S")
        a, b = self.pos["coude"].lerp(self.pos["poignet"], 0.4), self.pos["poignet"]
        d = (b - a).normalized()
        e1 = d.cross(V((0, 0, 1))).normalized()
        e2 = d.cross(e1)
        pts = []
        for k in range(9):
            th = 2 * math.pi * 2.5 * k / 8
            pts.append(a.lerp(b, k / 8) + (e1 * math.cos(th) + e2 * math.sin(th)) * 0.22)
        for p0, p1 in zip(pts, pts[1:]):
            parts.append(self.cone_ab("Liane", BACK, g_fore, p0, p1, 0.05, 0.05, seg=3, mirror_x=True))
        g_vine = self.grp("rigid", "Vine.S")
        vine = self.vine_pts()
        for i, (p0, p1) in enumerate(zip(vine, vine[1:])):
            parts.append(self.cone_ab("LianeLibre", BACK, g_vine, p0, p1, 0.05 - 0.008 * i, 0.042 - 0.008 * i, seg=4,
                                      mirror_x=True))
        Ml = look_mat(vine[-1], V((0.1, 0.2, -1)), up=(1, 0, 0))
        parts.append(self.flat("FeuilleLiane", MAIN, g_vine, leaf(0.26, 0.11, 2), Ml, 0.05, mirror_x=True))
        # plaques du dos (losanges vert sombre), pointes de coude, pattes d'ours, griffes crème
        self.back_plates(body, parts, BACK, [(-0.10, 2.08, 0.24, 0.12), (0.12, 1.78, 0.30, 0.14),
                                             (0.32, 1.46, 0.26, 0.13), (0.52, 1.18, 0.18, 0.1)])
        self.elbow_plates(body, parts, BACK)
        self.bear_paws(parts, MAIN, WHITE)
        self.foot_claws(body, parts, WHITE)

    def vine_pts(self):
        w = self.pos["poignet"] + V((0.02, 0.12, -0.14))
        return [w, w + V((0.03, 0.08, -0.16)), w + V((0.0, 0.14, -0.32)), w + V((0.04, 0.12, -0.46))]

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, self.SPINE, self.C[BELLY], cos_min=0.55,
                         limbs=set(self.ARM_NODES) | set(self.LEG_NODES), max_x=0.42)
        self.paint(me, lambda c, n: BACK if n.z > 0.55 and abs(c.x) < 0.5 and -0.6 < c.y < 0.6 and c.z > 1.0
                   else None)
        # bandes sombres sur la queue (liane) et rayures en travers du crâne
        self.paint(me, lambda c, n: BACK if c.y > 0.85 and (c.y % 0.42) < 0.14 else None)
        self.paint(me, lambda c, n: BACK if n.z > 0.3 and c.z > 3.0 and -1.0 < c.y < 0.1 and (c.y % 0.36) < 0.1
                   else None)
        self.clean_islands(me, BELLY, MAIN)

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

    # Idle acrobate : se balance d'une patte sur l'autre, pattes d'ours levées (prêt à bondir), ailes repliées en
    # cape, queue-balancier
    def idle(self, t):
        super().idle(t)
        sway = S2(t, 2, 0.0)
        self.mv("Hips", x=0.06 * sway, z=-0.04 + 0.02 * S2(t, 4), ry=-7 * sway, rx=4, rz=3 * S2(t, 1))
        self.r("Spine", (Y, 4 * sway))
        self.r("Jaw", (X, 10 + 4 * max(0.0, S2(t, 2))))
        for side, sx in SIDES:
            self.paws_pose(side, 0.9 + 0.1 * S2(t, 2, 0.2 * sx), wrist=self.PAWS["wrist"] + 6 * sway * sx)
        self.tail(lambda i: ((Y, -6 * sway), (Z, 8 * S2(t, 2, -0.12 * (i + 1)))))
        self.vine(t, 10, 2, 0.1)

    def idle_feet(self, side, t, ank, toe):
        sway = S2(t, 2, 0.0)
        up = max(0.0, -sway if side == "L" else sway) * 0.16 * self.u  # la patte « délestée » se lève un peu
        return ank + V((0, 0, up)), toe + V((0, 0, up * 0.6))

    def walk(self, t):
        super().walk(t)
        roll = S2(t, 1)
        for side, sx in SIDES:
            self.wing_pose(side, up=-10 + 10 * roll * sx, sweep=20, elbow=-8, wrist=-8 + 6 * S2(t, 2, 0.15), tip=-6,
                           twist=-12, fold=self.FOLD)
        self.vine(t, 18, 2, 0.15)

    def run(self, t):
        super().run(t)
        self.vine(t, 22, 1, -0.2)

    # Attaque : comme la base, mais coup de bec moins plongeant (la grosse tête chibi ne doit pas toucher le sol)
    def attack(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.56, 1), (0.86, 0), (1, 0)])
        s2 = keys(t, [(0, 0), (0.36, 0), (0.48, 1), (0.64, 1), (0.94, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.22, 0.4), (0.33, 1), (0.42, 0), (0.48, 0.25), (0.62, 0), (1, 0)])
        self.mv("Hips", y=0.22 * a - 0.45 * s, z=-0.08 * a, rx=-12 * a + 10 * s)
        self.r("Spine", (X, -5 * a + 4 * s))
        self.neck(rx=-24 * a + 8 * s, head_rx=-10 * a + 6 * s)
        self.r("Jaw", (X, 45 * j))
        self.r("Crest", (X, -8 * s2 + 6 * a))
        self.wings(up=-10 + 40 * a - 16 * s, sweep=10 - 20 * a + 10 * s2, elbow=-10 + 10 * a,
                   wrist=-8 + 14 * a - 10 * s2, tip=-6 + 10 * a - 12 * s2, twist=-10, fold=self.FOLD * (1 - a) * 0.6)
        self.tail(lambda i: ((X, 6 * a - 8 * s2),))
        self.vine(t, 25 * keys(t, [(0, 0), (0.4, 1), (1, 0)]), 3)

    def roar(self, t):
        super().roar(t)
        self.vine(t, 20, 3)

    def celebrate(self, t):
        super().celebrate(t)
        self.vine(t, 26, 4)

    def death(self, t):
        super().death(t)
        f = keys(t, [(0, 0), (0.36, 0), (0.62, 1), (0.71, 0.9), (0.8, 1), (1, 1)])
        self.tail(lambda i: ((Z, -6 * f), (X, -(30 + 12 * i) * f)))  # la longue queue raide retombe au sol (pas en l'air)
        self.vine(t, 14 * keys(t, [(0, 1), (1, 0)]), 3)

    def feet(self):
        f = super().feet()
        f["Idle"] = self.idle_feet
        return f


if __name__ == "__main__":
    Lianopteryx().main()
