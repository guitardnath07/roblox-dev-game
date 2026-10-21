# DINO DICE — Aurorasaure (légendaire, ptérosaure) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 2 (style « chibi » demandé par le joueur : tête énorme, gros yeux à sourcils, griffes crème
# surdimensionnées, mains en patte d'ours, petites pointes sur le dos et aux coudes, marques plus sombres)
# Référence réelle : Pteranodon longiceps (bec long et pointu SANS dents, crête arrière qui équilibre le bec =
# silhouette en « pioche », grande envergure, petit corps, queue très courte). Couche thématique
# (docs/dinos-concept.md) : la crête se prolonge en 2 rubans d'aurore (3 os chacun) ; membranes en dégradé
# vert -> violet -> rose avec 4 vagues lumineuses ; 3 rubans courts en guise de queue ; 6 petites étoiles
# (4 branches) au bord de fuite des ailes. Personnalité : timide-coquet (cils, mains sur les joues, déploie les
# ailes quand on le regarde). Reste SANS dents (fiche) : grand sourire bec entrouvert à la place.
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_aurorasaure.py [-- model]

import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from flyer_swimmer_helpers import V, Matrix, plane_yz, SIDES, S2, keys, X, Y, Z, star, frame_from, chain_resample, \
    bone_chain, mirror_inplace, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402
from ptero_chibi import ChibiPtero, set_uv  # noqa: E402
import dd_common as dd  # noqa: E402


class Aurorasaure(ChibiPtero):
    ID, NAME = "aurorasaure", "Aurorasaure"
    COLORS = {"main": "#00BFA5", "belly": "#7C4DFF", "accent": "#F48FB1", "glow": "#B9F6CA", "back": "#00796B"}
    HEIGHT = 3.8 * 1.45
    BG = (0.10, 0.12, 0.22)
    NODES = [
        ("hanche", (0, 0.18, 1.10), 0.55, None),
        ("torse", (0, -0.02, 1.42), 0.60, "hanche"),
        ("poitrine", (0, -0.16, 1.74), 0.52, "torse"),
        ("cou1", (0, -0.24, 1.98), 0.36, "poitrine"),
        ("cou2", (0, -0.30, 2.16), 0.36, "cou1"),
        ("cou3", (0, -0.36, 2.34), 0.42, "cou2"),
        ("crane", (0, -0.52, 2.84), 0.88, None),  # tête = bloc séparé du cou
        ("bec1", (0, -1.30, 2.64), 0.50, "crane"),
        ("bec2", (0, -1.98, 2.52), 0.30, "bec1"),
        ("bec3", (0, -2.55, 2.45), 0.12, "bec2"),
        ("queue1", (0, 0.66, 0.98), 0.18, "hanche"),
        ("cuisse", (0.32, 0.12, 0.92), 0.32, None),
        ("genou", (0.40, 0.00, 0.56), 0.24, "cuisse"),
        ("cheville", (0.40, 0.08, 0.25), 0.19, "genou"),
        ("pied", (0.40, -0.18, 0.13), 0.17, "cheville"),
        ("epaule", (0.42, -0.14, 1.72), 0.24, None),
        ("coude", (1.12, -0.02, 2.02), 0.18, "epaule"),
        ("poignet", (1.82, 0.06, 2.30), 0.15, "coude"),
        ("doigt1", (2.52, 0.15, 2.50), 0.09, "poignet"),
        ("doigt2", (3.18, 0.26, 2.56), 0.06, "doigt1"),
        ("doigt3", (3.76, 0.38, 2.50), 0.035, "doigt2"),
    ]
    SPINE = ["queue1", "hanche", "torse", "poitrine", "cou1", "cou2", "cou3", "crane", "bec1", "bec2", "bec3"]
    TAIL = ["queue1"]
    NT = 1
    MOUTH = dict(P=(0, -1.75, 2.52), N=(0, -0.13, 1), y0=-0.85, gap=0.025, zmin=2.15, smile=0.16, smile_y=-1.55,
                 reach=0.42)
    JAW_BONE = ((0, -0.62, 2.45), (0, -2.55, 2.34))
    CREST_BONE = ((0, -0.45, 3.45), (0, 1.35, 3.85))
    WING_TRAIL = [(0.34, 0.30, 1.0), (1.0, 0.52, 1.02), (1.8, 0.66, 1.25), (2.65, 0.70, 1.68), (3.35, 0.62, 2.1),
                  (3.76, 0.38, 2.5)]
    # rubans d'aurore de la crête : axe (x > 0), 1,2 de long ; rubans de queue (centre + paire), 0,6
    RIB = [(0.07, 1.30, 3.84), (0.16, 1.72, 3.70), (0.24, 2.08, 3.40), (0.30, 2.30, 3.00)]
    TRIB_C = [(0.0, 0.70, 0.98), (0.0, 0.98, 0.86), (0.0, 1.28, 0.74)]
    TRIB_S = [(0.10, 0.66, 1.0), (0.30, 0.92, 0.92), (0.46, 1.16, 0.78)]
    EYE = ((0.40, -1.20, 3.02), 0.37)

    def wing_slot(self, u, v):
        return MAIN if v < 0.34 else (BELLY if v < 0.68 else ACCENT)

    def extras(self, body, parts):
        g_head, g_jaw, g_crest = self.grp("rigid", "Head"), self.grp("rigid", "Jaw"), self.grp("rigid", "Crest")
        self.wing(parts)
        gw = self.groups.index(next(g for g in self.groups[1:] if g[0] == "chain"))
        # 4 vagues d'aurore lumineuses (des deux côtés de la membrane), en segments droits
        waves = [[(0.08 + 0.86 * i / 6, v0 + 0.06 * (1 if (i + k) % 2 else -1)) for i in range(7)]
                 for k, v0 in enumerate((0.2, 0.42, 0.62, 0.82))]
        parts.append(self.veins("Vague", gw, waves, lambda k: 0.06 - 0.004 * k, GLOW))
        # 6 étoiles (3 par aile) au bord de fuite : suivent la membrane (mêmes dd_u / dd_v)
        ev = self.sheet_eval
        for u in (0.42, 0.66, 0.86):
            p, n, h = ev(u, 0.9)
            for sgn in (1, -1):
                M = frame_from(p + n * (h + 0.012) * sgn, n * sgn)
                parts.append(mirror_inplace(set_uv(self.flat1("Etoile", GLOW, gw, star(0.17, 0.05, 4), M), u, 0.9)))
        # gros yeux (iris rose vif, grosse pupille, reflets), sourcils relevés (timide) + cils coquets
        target, size = self.EYE
        parts += self.eyes(body, target, size, g_head, iris_slot=ACCENT, look=(0.32, -1.0, 0.1), sink=0.4)
        parts.append(self.brow(g_head, BELLY, size, tilt=-0.06, lift=1.15))
        ec, nor = self.eye_c, self.eye_n
        for k in range(3):
            a = ec + V((0.0, 0.14 * (k - 1) + 0.08, size * 0.95)) + nor * size * 0.3
            parts.append(self.cone_ab("Cil", DARK, g_head, a, a + V((0.10, 0.08 * (k - 1) + 0.04, 0.17)), 0.035,
                                      seg=3, mirror_x=True))
        # joues roses (pastilles plates)
        ch = dd.snap(body, (0.62, -1.2, 2.62), -0.02)
        parts.append(self.part("Joue", "sphere", ACCENT, g_head, loc=ch, scale=(0.05, 0.16, 0.1), mirror_x=True,
                               u=6, v=3))
        parts.append(self.part("Narine", "cube", DARK, g_head, loc=dd.snap(body, (0.09, -2.3, 2.56), -0.01),
                               scale=(0.05, 0.08, 0.035), mirror_x=True))
        zt = self.mouth_z(-1.6) - 0.13
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.55, zt), scale=(0.2, 0.55, 0.07),
                               u=6, v=3))
        # crête « pioche » : lame plate biseautée (prisme) qui part de l'arrière du crâne + liseré lumineux
        M = Matrix.Translation(V((0, -0.55, 3.38))) @ plane_yz(math.radians(165))
        crest = [(0, -0.30), (0, 0.32), (0.55, 0.42), (2.05, 0.1), (2.12, 0.0), (1.9, -0.08), (0.5, -0.3)]
        parts.append(self.flat("Crete", BACK, g_crest, [(-z, y) for y, z in crest], M, 0.16))
        parts.append(self.flat("CreteLisere", GLOW, g_crest, [(-z, y) for y, z in
                                                             ((0.5, 0.36), (2.0, 0.08), (2.0, 0.04), (0.5, 0.26))],
                               M, 0.2))
        # 2 rubans d'aurore (3 os chacun) qui prolongent la crête
        parts.append(self.strip("Ruban", self.RIB, lambda s: 0.32 * (1 - 0.35 * s), ["Ribbon1.S", "Ribbon2.S",
                                "Ribbon3.S"], "Crest", lambda u, v: MAIN if u < 0.34 else (BELLY if u < 0.67 else ACCENT),
                                True))
        # 3 rubans courts en guise de queue
        sl = lambda u, v: BELLY if u < 0.5 else ACCENT  # noqa: E731
        parts.append(self.strip("RubanQueue", self.TRIB_C, lambda s: 0.22 * (1 - 0.3 * s), ["TailRibC1", "TailRibC2"],
                                "Tail1", sl, False, ns=4))
        parts.append(self.strip("RubanQueueS", self.TRIB_S, lambda s: 0.18 * (1 - 0.3 * s),
                                ["TailRib1.S", "TailRib2.S"], "Tail1", sl, True, ns=4))
        # plaques du dos (losanges plats), pointes de coude, pattes d'ours, griffes crème
        self.back_plates(body, parts, ACCENT, [(-0.10, 2.10, 0.26, 0.13), (0.12, 1.80, 0.32, 0.15),
                                               (0.32, 1.48, 0.28, 0.14), (0.50, 1.20, 0.2, 0.11)])
        self.elbow_plates(body, parts, ACCENT)
        self.bear_paws(parts, MAIN, WHITE)
        self.foot_claws(body, parts, WHITE)

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, self.SPINE, self.C[BELLY], cos_min=0.55,
                         limbs=set(self.ARM_NODES) | set(self.LEG_NODES), max_x=0.42)
        # dos plus sombre + rayures sombres en travers du dos et du crâne
        self.paint(me, lambda c, n: BACK if n.z > 0.55 and abs(c.x) < 0.5 and c.y > -0.6 and c.z > 1.0 else None)
        self.paint(me, lambda c, n: BACK if n.z > 0.2 and c.z > 1.0 and -0.9 < c.y < 0.2 and abs(c.x) < 0.75
                   and (c.y % 0.34) < 0.09 else None)
        self.paint(me, lambda c, n: ACCENT if c.y < -2.25 else None)  # pointe du bec rose
        self.clean_islands(me, BELLY, MAIN)

    def extra_bones(self):
        out = []
        for side, sx in SIDES:
            m = lambda pts: [V((p[0] * sx, p[1], p[2])) for p in pts]  # noqa: E731
            out += bone_chain(["Ribbon%d.%s" % (i + 1, side) for i in range(3)], chain_resample(m(self.RIB), 3),
                              "Crest")
            out += bone_chain(["TailRib%d.%s" % (i + 1, side) for i in range(2)], chain_resample(m(self.TRIB_S), 2),
                              "Tail1")
        out += bone_chain(["TailRibC1", "TailRibC2"], chain_resample([V(p) for p in self.TRIB_C], 2), "Tail1")
        return out

    def ribbons(self, t, amp=12.0, k=2, ph=0.0):
        """Rubans qui ondulent (vague qui court le long de chaque ruban)."""
        for side, sx in SIDES:
            for i in range(3):
                self.r("Ribbon%d.%s" % (i + 1, side), (X, amp * S2(t, k, ph - 0.12 * i)),
                       (Z, sx * amp * 0.5 * S2(t, k, ph + 0.25 - 0.12 * i)))
            for i in range(2):
                self.r("TailRib%d.%s" % (i + 1, side), (Z, sx * amp * S2(t, k, ph + 0.1 - 0.15 * i)),
                       (X, amp * 0.6 * S2(t, k, ph + 0.3 - 0.15 * i)))
        for i in range(2):
            self.r("TailRibC%d" % (i + 1), (X, amp * S2(t, k, ph + 0.2 - 0.15 * i)))

    # Idle timide-coquet : accroupi, pattes levées près des joues, regard en coin ; quand il « nous voit », il
    # déploie les ailes en éventail et bat des cils, puis se cache de nouveau.
    def idle(self, t):
        super().idle(t)
        show = keys(t, [(0, 0), (0.30, 0), (0.40, 1), (0.66, 1), (0.78, 0), (1, 0)])
        peek = keys(t, [(0, 0), (0.18, 0), (0.26, 1), (0.40, 0.4), (0.70, 0.4), (0.80, 0), (1, 0)])
        br = S2(t, 2)
        hide = 1 - show
        self.mv("Hips", z=-0.06 * hide + 0.02 * br, rx=6 * hide - 2 * br - 4 * peek, rz=-6 * peek)
        self.neck(rx=-6 * hide + 4 * br - 8 * peek + 6 * show, rz=-16 * peek, ry=8 * peek,
                  head_rx=6 * peek - 6 * show, head_rz=-14 * peek + 6 * show * S2(t, 4), head_ry=14 * peek + 8 * show)
        self.r("Jaw", (X, 10 + 4 * max(0.0, br) + 8 * show))
        for side, _sx in SIDES:
            self.paws_pose(side, hide, up=self.PAWS["up"] * hide + (28 + 3 * br) * show,
                           sweep=self.PAWS["sweep"] * hide - 8 * show,
                           wrist=self.PAWS["wrist"] * hide + 6 * S2(t, 2, 0.1) * show)
        self.ribbons(t, 10 + 6 * show, 2)

    def walk(self, t):
        super().walk(t)
        roll = S2(t, 1)
        for side, sx in SIDES:
            self.wing_pose(side, up=-10 + 10 * roll * sx, sweep=20, elbow=-8, wrist=-8 + 6 * S2(t, 2, 0.15), tip=-6,
                           twist=-12, fold=self.FOLD)
        self.ribbons(t, 16, 2, 0.1)

    def run(self, t):
        super().run(t)
        self.ribbons(t, 22, 2, -0.2)

    # Attaque (comme la base, mais coup de bec moins plongeant : le long bec ne doit pas piquer le sol)
    def attack(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.56, 1), (0.86, 0), (1, 0)])
        s2 = keys(t, [(0, 0), (0.36, 0), (0.48, 1), (0.64, 1), (0.94, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.22, 0.4), (0.33, 1), (0.42, 0), (0.48, 0.25), (0.62, 0), (1, 0)])
        self.mv("Hips", y=0.22 * a - 0.45 * s, z=-0.08 * a, rx=-12 * a + 10 * s)
        self.r("Spine", (X, -5 * a + 4 * s))
        self.neck(rx=-24 * a + 6 * s, head_rx=-10 * a + 4 * s)
        self.r("Jaw", (X, 45 * j))
        self.r("Crest", (X, -8 * s2 + 6 * a))
        self.wings(up=-10 + 40 * a - 16 * s, sweep=10 - 20 * a + 10 * s2, elbow=-10 + 10 * a,
                   wrist=-8 + 14 * a - 10 * s2, tip=-6 + 10 * a - 12 * s2, twist=-10, fold=self.FOLD * (1 - a) * 0.6)
        self.tail(lambda i: ((X, 6 * a - 8 * s2),))
        self.ribbons(t, 18 * keys(t, [(0, 0.4), (0.4, 1), (1, 0.4)]), 3)

    def roar(self, t):
        super().roar(t)
        self.ribbons(t, 22, 3)

    def celebrate(self, t):
        super().celebrate(t)
        self.ribbons(t, 26, 4)

    def death(self, t):
        super().death(t)
        self.ribbons(t, 16 * keys(t, [(0, 1), (1, 0.2)]), 3)


if __name__ == "__main__":
    Aurorasaure().main()
