# DINO DICE — Solaripteryx (primordial, ptérosaure) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 2 (style du joueur : chibi « à plaques » — tête énorme, gros yeux à sourcils, griffes crème
# surdimensionnées, mains en patte d'ours, facettes planes, blocs séparés, plaques dorsales ; voir ptero_chibi.py)
# Référence réelle : Tupandactylus imperator (gigantesque crête-voile arrondie rejetée vers l'arrière, plus grande
# que la tête ; bec court et pointu ; cou fort ; queue très courte). Couche thématique (docs/dinos-concept.md) :
# crête = disque solaire à 12 rayons triangulaires, lumineux ; bord d'attaque des ailes dentelé en 7 flammes ;
# queue de feu (3 langues de flamme superposées, 1,2 de long, 3 os) ; anneau de lever de soleil (demi-tore) sous le
# menton. Personnalité : leader matinal (bat des ailes, pointe le bec vers le ciel, s'étire).
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_solaripteryx.py [-- model]

import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from flyer_swimmer_helpers import V, Matrix, SIDES, S2, keys, X, Y, Z, plane_yz, circle, leaf, look_mat, \
    chain_resample, bone_chain, MAIN, BELLY, ACCENT, DARK, GLOW, BACK, TONGUE  # noqa: E402
from ptero_chibi import ChibiPtero, set_uv  # noqa: E402
import dd_common as dd  # noqa: E402


class Solaripteryx(ChibiPtero):
    ID, NAME = "solaripteryx", "Solaripteryx"
    COLORS = {"main": "#FFC107", "belly": "#FF6F00", "accent": "#FFFDE7", "glow": "#FFEA00", "back": "#E65100"}
    HEIGHT = 3.8 * 1.9
    BG = (0.20, 0.14, 0.24)
    NODES = [
        ("hanche", (0, 0.18, 1.10), 0.56, None),
        ("torse", (0, -0.02, 1.42), 0.62, "hanche"),
        ("poitrine", (0, -0.16, 1.74), 0.56, "torse"),
        ("cou1", (0, -0.24, 1.98), 0.42, "poitrine"),
        ("cou2", (0, -0.30, 2.16), 0.42, "cou1"),
        ("cou3", (0, -0.36, 2.34), 0.46, "cou2"),
        ("crane", (0, -0.50, 2.84), 0.90, None),  # tête = bloc séparé du cou
        ("bec1", (0, -1.22, 2.66), 0.48, "crane"),
        ("bec2", (0, -1.66, 2.56), 0.26, "bec1"),
        ("bec3", (0, -2.00, 2.48), 0.10, "bec2"),
        ("queue1", (0, 0.66, 0.98), 0.18, "hanche"),
        ("cuisse", (0.33, 0.12, 0.92), 0.33, None),
        ("genou", (0.41, 0.00, 0.56), 0.25, "cuisse"),
        ("cheville", (0.41, 0.08, 0.25), 0.20, "genou"),
        ("pied", (0.41, -0.18, 0.13), 0.18, "cheville"),
        ("epaule", (0.44, -0.14, 1.74), 0.25, None),
        ("coude", (1.14, -0.02, 2.04), 0.19, "epaule"),
        ("poignet", (1.84, 0.06, 2.32), 0.16, "coude"),
        ("doigt1", (2.55, 0.15, 2.52), 0.09, "poignet"),
        ("doigt2", (3.22, 0.26, 2.58), 0.06, "doigt1"),
        ("doigt3", (3.82, 0.38, 2.52), 0.035, "doigt2"),
    ]
    SPINE = ["queue1", "hanche", "torse", "poitrine", "cou1", "cou2", "cou3", "crane", "bec1", "bec2", "bec3"]
    TAIL = ["queue1"]
    NT = 1
    MOUTH = dict(P=(0, -1.45, 2.56), N=(0, -0.2, 1), y0=-0.8, gap=0.025, zmin=2.15, smile=0.18, smile_y=-1.35,
                 reach=0.42)
    JAW_BONE = ((0, -0.62, 2.48), (0, -2.0, 2.36))
    DISC_C, DISC_R = V((0, 0.08, 3.70)), 0.95
    CREST_BONE = ((0, -0.40, 3.40), (0, 0.08, 3.70))
    WING_TRAIL = [(0.34, 0.30, 1.0), (1.0, 0.54, 1.02), (1.85, 0.68, 1.26), (2.7, 0.72, 1.70), (3.4, 0.62, 2.12),
                  (3.82, 0.38, 2.52)]
    FIRE = [(0, 0.66, 1.0), (0, 1.04, 1.10), (0, 1.46, 1.34), (0, 1.82, 1.72)]  # axe de la queue de feu
    EYE = ((0.40, -1.15, 3.0), 0.37)

    def wing_slot(self, u, v):
        return MAIN if v < 0.4 else (BELLY if v < 0.8 else BACK)

    def extras(self, body, parts):
        g_head, g_jaw, g_crest = self.grp("rigid", "Head"), self.grp("rigid", "Jaw"), self.grp("rigid", "Crest")
        self.wing(parts)
        gw = self.groups.index(next(g for g in self.groups[1:] if g[0] == "chain"))
        ev = self.sheet_eval
        # 7 flammes sur le bord d'attaque (suivent l'aile), dans le plan de la membrane, orange / jaune alternés
        for k in range(7):
            u = 0.2 + 0.76 * k / 6
            p, n, h = ev(u, 0.0)
            q, _n, _h = ev(u, 0.3)
            d = (p - q).normalized() + V((0, 0, 0.5)) + (ev(min(1, u + 0.05), 0)[0] - p).normalized() * 0.5
            L = 0.44 - 0.18 * k / 6
            M = look_mat(p - d.normalized() * 0.05, d, up=n)
            parts.append(set_uv(self.flat("FlammeAile", BELLY if k % 2 else GLOW, gw, leaf(L, L * 0.4, 2), M, 0.07,
                                          mirror_x=True), u, 0.0))
        # gros yeux (iris orange vif, grosse pupille, reflets), sourcils de chef (froncés, air décidé)
        target, size = self.EYE
        parts += self.eyes(body, target, size, g_head, iris_slot=BELLY, look=(0.32, -1.0, 0.12), sink=0.42)
        parts.append(self.brow(g_head, BACK, size, tilt=0.08, lift=1.12))
        parts.append(self.part("Narine", "cube", DARK, g_head, loc=dd.snap(body, (0.08, -1.82, 2.62), -0.01),
                               scale=(0.045, 0.07, 0.03), mirror_x=True))
        # grand sourire : dents triangulaires, langue
        parts += self.teeth_row(body, g_head, [-1.7, -1.4, -1.1], -1, 0.16, 0.065, inset=0.05, seg=4)
        parts += self.teeth_row(body, g_jaw, [-1.55, -1.25], 1, 0.13, 0.06, inset=0.06, seg=4)
        zt = self.mouth_z(-1.3) - 0.12
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.3, zt), scale=(0.18, 0.4, 0.06),
                               u=6, v=3))
        # crête = disque solaire à 12 pans (2 faces, cœur crème, anneau orange) + 12 rayons triangulaires ;
        # le disque est enfoncé dans l'arrière du crâne
        c, R = self.DISC_C, self.DISC_R
        M = Matrix.Translation(c) @ plane_yz(math.radians(90))
        parts.append(self.flat("Disque", GLOW, g_crest, circle(R, 12), M, 0.14))
        for sgn in (1, -1):
            Mi = M @ Matrix.Translation((0, 0, 0.072 * sgn)) @ (Matrix.Rotation(math.pi, 4, "Y") if sgn < 0
                                                                 else Matrix())
            parts.append(self.flat1("DisqueAnneau", BELLY, g_crest, circle(R * 0.78, 12), Mi))
            parts.append(self.flat1("DisqueCoeur", ACCENT, g_crest, circle(R * 0.55, 12),
                                    Mi @ Matrix.Translation((0, 0, 0.006))))
        for i in range(12):
            a = 2 * math.pi * (i + 0.5) / 12
            ca, sa = math.cos(a), math.sin(a)
            tri = [((R - 0.05) * ca + 0.15 * sa, (R - 0.05) * sa - 0.15 * ca), ((R + 0.32) * ca, (R + 0.32) * sa),
                   ((R - 0.05) * ca - 0.15 * sa, (R - 0.05) * sa + 0.15 * ca)]
            parts.append(self.flat("Rayon", GLOW if i % 2 else BELLY, g_crest, tri, M, 0.1))
        # anneau de lever de soleil : demi-tore (6 segments) sous le menton, porté par le cou
        g_neck = self.grp("rigid", "Neck3")
        cc, rr = V((0, -0.82, 2.30)), 0.40
        arc = [cc + V((rr * math.cos(a), 0.05 * math.sin(a), -rr * math.sin(a) * 0.8))
               for a in (math.pi * k / 6 for k in range(7))]
        for p0, p1 in zip(arc, arc[1:]):
            parts.append(self.cone_ab("Anneau", GLOW, g_neck, p0, p1, 0.075, 0.075, seg=5))
        for p in (arc[0], arc[-1]):
            parts.append(self.part("AnneauBout", "cube", BELLY, g_neck, loc=p, scale=(0.16, 0.16, 0.16)))
        # queue de feu : 3 langues superposées (orange foncé, jaune lumineux, cœur crème), os Fire1..3
        bones = ["Fire1", "Fire2", "Fire3"]
        flame = lambda w: (lambda s: w * math.sin(math.pi * min(1.0, 0.08 + s) ** 0.7))  # noqa: E731
        parts.append(self.strip("Feu", self.FIRE, flame(0.66), bones, "Tail1",
                                lambda u, v: BELLY if u < 0.8 else BACK, False, ns=6))
        parts.append(self.strip("FeuMilieu", self.FIRE, flame(0.42), bones, "Tail1", lambda u, v: GLOW, True, ns=5,
                                xoff=0.035, frac=0.78))
        parts.append(self.strip("FeuCoeur", self.FIRE, flame(0.24), bones, "Tail1", lambda u, v: ACCENT, True, ns=4,
                                xoff=0.06, frac=0.52))
        # plaques dorsales en pointes de rayon (orange), pointes de coude, pattes d'ours, griffes crème
        self.back_plates(body, parts, BELLY, [(-0.10, 2.10, 0.30, 0.13), (0.12, 1.80, 0.36, 0.15),
                                              (0.32, 1.48, 0.30, 0.14), (0.50, 1.20, 0.22, 0.11)], kinds=("pointe",))
        self.elbow_plates(body, parts, BELLY)
        self.bear_paws(parts, MAIN, ACCENT)
        self.foot_claws(body, parts, ACCENT)

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, self.SPINE, self.C[ACCENT], cos_min=0.55,
                         limbs=set(self.ARM_NODES) | set(self.LEG_NODES), max_x=0.44)
        # dos orange + rayures orange foncé
        self.paint(me, lambda c, n: BELLY if n.z > 0.5 and abs(c.x) < 0.5 and c.y > -0.6 and c.z > 1.0 else None)
        self.paint(me, lambda c, n: BACK if n.z > 0.2 and c.z > 1.0 and -0.9 < c.y < 0.2 and abs(c.x) < 0.75
                   and (c.y % 0.34) < 0.09 else None)
        self.paint(me, lambda c, n: BACK if c.y < -1.8 else None)  # pointe du bec
        self.clean_islands(me, ACCENT, MAIN)

    def extra_bones(self):
        return bone_chain(["Fire1", "Fire2", "Fire3"], chain_resample([V(p) for p in self.FIRE], 3), "Tail1")

    def fire(self, t, amp=10.0, k=3, ph=0.0):
        """Flammes qui lèchent l'air : vague rapide qui court le long de la queue de feu."""
        for i in range(3):
            self.r("Fire%d" % (i + 1), (X, amp * S2(t, k, ph - 0.15 * i)), (Z, amp * 0.8 * S2(t, k, ph + 0.3 - 0.15 * i)))

    # Idle leader matinal : campé, pattes d'ours levées (prêt à bondir) ; puis s'étire (ailes grandes ouvertes, bec
    # pointé vers le ciel), 3 battements d'ailes de réveil, et revient fièrement en garde.
    def idle(self, t):
        self.base()
        br = S2(t, 2)
        st = keys(t, [(0, 0), (0.22, 0), (0.36, 1), (0.52, 1), (0.60, 0.7), (0.80, 0.7), (0.90, 0), (1, 0)])
        sky = keys(t, [(0, 0), (0.24, 0), (0.38, 1), (0.54, 1), (0.64, 0), (1, 0)])
        flap = keys(t, [(0, 0), (0.56, 0), (0.60, 1), (0.82, 1), (0.88, 0), (1, 0)]) * S2(t, 12, 0.25)
        rest = 1 - st
        self.mv("Hips", z=-0.05 * rest + 0.02 * br + 0.06 * st, rx=5 * rest - 2 * br - 8 * sky,
                rz=2 * S2(t, 1) * rest)
        self.r("Spine", (X, -2 * br - 6 * sky))
        self.neck(rx=-5 * rest + 4 * br - 16 * sky, rz=8 * S2(t, 1, 0.2) * rest, head_rx=-34 * sky + 2 * S2(t, 2, 0.3),
                  head_ry=6 * S2(t, 1, 0.1) * rest)
        self.r("Jaw", (X, 8 + 3 * max(0.0, br) + 22 * sky * (0.6 + 0.4 * S2(t, 6))))
        self.r("Crest", (X, 3 * S2(t, 2, 0.2) + 6 * sky))
        for side, _sx in SIDES:
            self.paws_pose(side, rest, up=self.PAWS["up"] * rest + (30 + 22 * flap) * st + 3 * br,
                           sweep=self.PAWS["sweep"] * rest - 10 * st,
                           wrist=self.PAWS["wrist"] * rest - 10 * flap * st, tip=self.PAWS["tip"] * rest - 10 * flap * st)
        self.tail(lambda i: ((Z, 4 * S2(t, 1)),))
        self.fire(t, 10, 4)

    def walk(self, t):
        super().walk(t)
        roll = S2(t, 1)
        for side, sx in SIDES:
            self.wing_pose(side, up=-10 + 10 * roll * sx, sweep=20, elbow=-8, wrist=-8 + 6 * S2(t, 2, 0.15), tip=-6,
                           twist=-12, fold=self.FOLD)
        self.fire(t, 14, 2, 0.1)

    def run(self, t):
        super().run(t)
        self.fire(t, 16, 2, -0.2)

    # Attaque (coup de bec moins plongeant que la base)
    def attack(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.56, 1), (0.86, 0), (1, 0)])
        s2 = keys(t, [(0, 0), (0.36, 0), (0.48, 1), (0.64, 1), (0.94, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.22, 0.4), (0.33, 1), (0.42, 0), (0.48, 0.25), (0.62, 0), (1, 0)])
        self.mv("Hips", y=0.22 * a - 0.45 * s, z=-0.08 * a, rx=-12 * a + 12 * s)
        self.r("Spine", (X, -5 * a + 4 * s))
        self.neck(rx=-24 * a + 10 * s, head_rx=-10 * a + 8 * s)
        self.r("Jaw", (X, 45 * j))
        self.r("Crest", (X, -8 * s2 + 6 * a))
        self.wings(up=-10 + 40 * a - 16 * s, sweep=10 - 20 * a + 10 * s2, elbow=-10 + 10 * a,
                   wrist=-8 + 14 * a - 10 * s2, tip=-6 + 10 * a - 12 * s2, twist=-10, fold=self.FOLD * (1 - a) * 0.6)
        self.tail(lambda i: ((X, 6 * a - 8 * s2),))
        self.fire(t, 12 + 14 * s, 3)

    def roar(self, t):
        super().roar(t)
        self.fire(t, 22, 4)

    def celebrate(self, t):
        super().celebrate(t)
        self.fire(t, 22, 4)

    def death(self, t):
        super().death(t)
        self.fire(t, 14 * keys(t, [(0, 1), (1, 0.15)]), 3)


if __name__ == "__main__":
    Solaripteryx().main()
