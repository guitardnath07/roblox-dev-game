# DINO DICE — Spectrosaure (mythique, ptérosaure) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 2 (style du joueur : chibi « à plaques » — tête énorme, gros yeux à sourcils, facettes planes,
# blocs séparés, plaques dorsales plates ; voir ptero_chibi.py)
# Référence réelle : Nyctosaurus (immense crête en 2 longues branches, une vers le haut et une vers l'arrière,
# plus haute que le crâne ; ailes sans doigts griffus ; bec long et fin). Couche thématique (docs/dinos-concept.md) :
# voile fantôme déchiré (3 vrais trous) tendu entre les 2 branches ; ailes en lambeaux (6 pointes irrégulières au
# bord de fuite) ; pas de pattes : bas du corps en traîne de drap ondulée (3 os) ; petit miroir à main au cou ;
# yeux = 2 ovales violets lumineux sans pupille. Personnalité : farceur (« clignote », fait « bouh » ailes ouvertes).
# Fiche oblige : pas de griffes (ni aux mains ni aux pieds, il n'a pas de pattes) ; sourire de farceur à dents.
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_spectrosaure.py [-- model]

import math
import os
import sys

import bmesh
import bpy

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from flyer_swimmer_helpers import V, Matrix, SIDES, S2, keys, X, Y, Z, circle, joint_knots, \
    MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402
from ptero_chibi import ChibiPtero  # noqa: E402
import dd_common as dd  # noqa: E402


def trail_tattered():
    """Bord de fuite en lambeaux : courbe + 6 pointes irrégulières séparées par des encoches (13 points)."""
    base = [V(p) for p in ((0.30, 0.40, 0.95), (1.0, 0.58, 1.0), (1.75, 0.70, 1.22), (2.55, 0.72, 1.62),
                           (3.2, 0.60, 2.05), (3.6, 0.38, 2.46))]

    def C(s):
        f = s * (len(base) - 1)
        i = min(int(f), len(base) - 2)
        return base[i].lerp(base[i + 1], f - i)
    depth = (0.0, 0.28, 0.42, 0.24, 0.46, 0.3, 0.4, 0.2, 0.36, 0.18, 0.28, 0.1, 0.0)
    jit = (0, 0.02, -0.03, 0.03, 0.0, -0.02, 0.03, 0.01, -0.02, 0.02, 0.0, 0.01, 0)
    pts = []
    for k in range(13):  # pair = pointe (sur la courbe), impair = encoche (vers le bord d'attaque)
        p = C(min(1.0, max(0.0, k / 12 + jit[k])))
        if k % 2:
            p = p + V((0, -0.8, 0.55)).normalized() * depth[k]
        pts.append(p)
    return pts


class Spectrosaure(ChibiPtero):
    ID, NAME = "spectrosaure", "Spectrosaure"
    COLORS = {"main": "#CFD8DC", "belly": "#80CBC4", "accent": "#B388FF", "glow": "#D1B3FF", "back": "#78909C"}
    HEIGHT = 3.8 * 1.6
    BG = (0.12, 0.10, 0.20)
    LEGS = False
    NODES = [
        ("hanche", (0, 0.18, 1.12), 0.52, None),
        ("torse", (0, -0.02, 1.42), 0.56, "hanche"),
        ("poitrine", (0, -0.16, 1.74), 0.50, "torse"),
        ("cou1", (0, -0.24, 1.98), 0.34, "poitrine"),
        ("cou2", (0, -0.30, 2.16), 0.34, "cou1"),
        ("cou3", (0, -0.36, 2.34), 0.40, "cou2"),
        ("crane", (0, -0.52, 2.84), 0.88, None),  # tête = bloc séparé du cou
        ("bec1", (0, -1.28, 2.68), 0.44, "crane"),
        ("bec2", (0, -1.95, 2.56), 0.24, "bec1"),
        ("bec3", (0, -2.50, 2.48), 0.09, "bec2"),
        ("epaule", (0.40, -0.14, 1.72), 0.22, None),
        ("coude", (1.08, -0.02, 2.00), 0.16, "epaule"),
        ("poignet", (1.75, 0.06, 2.26), 0.13, "coude"),
        ("doigt1", (2.42, 0.15, 2.44), 0.08, "poignet"),
        ("doigt2", (3.05, 0.26, 2.50), 0.055, "doigt1"),
        ("doigt3", (3.60, 0.38, 2.46), 0.03, "doigt2"),
    ]
    SPINE = ["hanche", "torse", "poitrine", "cou1", "cou2", "cou3", "crane", "bec1", "bec2", "bec3"]
    TAIL = ["queue1", "queue2", "queue3"]  # os du drap (pas des nœuds du Skin : voir __init__)
    NT = 3
    DRAPE = {"queue1": (0, 0.26, 0.80), "queue2": (0, 0.38, 0.44), "queue3": (0, 0.56, 0.08)}
    MOUTH = dict(P=(0, -1.75, 2.56), N=(0, -0.13, 1), y0=-0.85, gap=0.025, zmin=2.15, smile=0.18, smile_y=-1.5,
                 reach=0.4)
    JAW_BONE = ((0, -0.62, 2.48), (0, -2.50, 2.38))
    CB = V((0, -0.40, 3.46))  # base de la crête en bois (sur le crâne)
    UP_TIP = V((0, -0.10, 5.25))
    BACK_TIP = V((0, 1.65, 4.20))
    CREST_BONE = ((0, -0.40, 3.46), (0, -0.2, 4.6))
    WING_TRAIL = trail_tattered()
    WING_NS, WING_NC = 12, 2
    EYE = ((0.36, -1.25, 3.04), 0.34)

    def __init__(self):
        super().__init__()
        self.pos.update({k: V(p) for k, p in self.DRAPE.items()})

    def wing_slot(self, u, v):
        return BACK if v > 0.7 else MAIN

    def wing(self, parts):
        """Comme la base, mais bord de fuite non lissé (les pointes des lambeaux restent pointues)."""
        lead = [self.pos[k] for k in self.ARM_NODES]
        kn, acc = joint_knots(lead, list(self.WING_BONES), ("Spine", "Hips"))
        self.wing_acc = acc
        gi = self.grp("chain", kn, (acc[2], ("Spine", "Hips")))
        parts.append(self.sheet("Aile", gi, lead, self.WING_TRAIL, self.WING_NS, self.WING_NC, 0.05,
                                self.wing_slot, mirror_x=True, smooth_trail=0))

    def drape_mesh(self, gi):
        """Bas du corps en drap de fantôme : cloche à 8 pans ouverte vers le bas, ourlet en dents (4 vagues),
        épaisse (dehors + dedans + ourlet)."""
        nr, na = 3, 8
        bm = bmesh.new()
        rows = []
        for i in range(nr + 1):
            t = i / nr
            zc, yc = 1.30 - 1.25 * t, 0.16 + 0.40 * t * t
            row = []
            for j in range(na):
                a = 2 * math.pi * (j + 0.5) / na
                r = 0.42 + 0.30 * t
                z = zc + (0.16 * (1 if j % 2 else -1) if i == nr else 0.0)
                row.append(bm.verts.new((r * math.sin(a), yc - r * math.cos(a) * 0.95, z)))
            rows.append(row)
        for i in range(nr):
            for j in range(na):
                bm.faces.new((rows[i][j], rows[i][(j + 1) % na], rows[i + 1][(j + 1) % na], rows[i + 1][j]))
        for f in bm.faces:  # vers l'extérieur
            f.normal_update()
            cc = f.calc_center_median()
            if f.normal.dot(V((cc.x, cc.y - 0.3, 0))) < 0:
                f.normal_flip()
        inner = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
        ifaces = [g for g in inner["geom"] if isinstance(g, bmesh.types.BMFace)]
        iverts = [g for g in inner["geom"] if isinstance(g, bmesh.types.BMVert)]
        bmesh.ops.reverse_faces(bm, faces=ifaces)
        for v in iverts:
            v.co.x *= 0.9
            v.co.y = 0.3 + (v.co.y - 0.3) * 0.9
        n_out = len(bm.verts) - len(iverts)
        bm.verts.ensure_lookup_table()
        irow = [bm.verts[n_out + nr * na + j] for j in range(na)]
        for j in range(na):
            bm.faces.new((rows[-1][(j + 1) % na], rows[-1][j], irow[j], irow[(j + 1) % na]))
        me = bpy.data.meshes.new("Drap")
        bm.to_mesh(me)
        bm.free()
        attr = dd.fill_color(me, self.C[MAIN])
        for p in me.polygons:  # ourlet plus sombre en bas
            if p.center.z < 0.36:
                for li in p.loop_indices:
                    attr.data[li].color_srgb = self.C[BACK]
        ob = bpy.data.objects.new("Drap", me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def extras(self, body, parts):
        g_head, g_jaw, g_crest = self.grp("rigid", "Head"), self.grp("rigid", "Jaw"), self.grp("rigid", "Crest")
        self.wing(parts)
        gw = self.groups.index(next(g for g in self.groups[1:] if g[0] == "chain"))
        # traînées fantômes lumineuses sur les ailes (segments droits)
        wisps = [[(0.1 + 0.8 * i / 5, v0 + 0.05 * (1 if i % 2 else -1)) for i in range(6)] for v0 in (0.3, 0.55)]
        parts.append(self.veins("Trainee", gw, wisps, lambda k: 0.05 - 0.004 * k, GLOW))
        # yeux : 2 gros ovales violets lumineux sans pupille, 1 reflet ; sourcils de farceur (en V malicieux)
        target, size = self.EYE
        parts += self.eyes(body, target, size, g_head, iris_slot=GLOW, look=(0.32, -1.0, 0.1), sink=0.55,
                           glow_only=True, squash=1.4)
        parts.append(self.brow(g_head, BACK, size, tilt=0.09, lift=1.45))
        parts.append(self.part("Narine", "cube", DARK, g_head, loc=dd.snap(body, (0.08, -2.25, 2.58), -0.01),
                               scale=(0.045, 0.07, 0.03), mirror_x=True))
        # sourire de farceur : dents triangulaires (blanches) en haut et en bas, langue
        parts += self.teeth_row(body, g_head, [-2.05, -1.75, -1.45, -1.15], -1, 0.17, 0.065, inset=0.05, seg=4)
        parts += self.teeth_row(body, g_jaw, [-1.9, -1.6, -1.3], 1, 0.14, 0.06, inset=0.06, seg=4)
        zt = self.mouth_z(-1.5) - 0.12
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.5, zt), scale=(0.17, 0.5, 0.06),
                               u=6, v=3))
        # crête en 2 longues branches (prismes aplatis) + petits andouillers, voile fantôme à 3 vrais trous ;
        # la base est collée sur le dessus de la tête-bloc (enfoncée), les pointes gardent leur décalage
        cb = dd.snap(body, self.CB + V((0, 0.1, 0.6)), -0.12)
        self.UP_TIP, self.BACK_TIP = self.UP_TIP + (cb - self.CB), self.BACK_TIP + (cb - self.CB)
        self.CB = cb
        for tip, r0, sub in ((self.UP_TIP, 0.28, (0.55, V((0, 0.38, 0.26)))),
                             (self.BACK_TIP, 0.26, (0.5, V((0, 0.24, 0.40))))):
            parts.append(self.cone_ab("Branche", BACK, g_crest, self.CB, tip, r0, 0.05, seg=4, scale_x=0.55))
            s0 = self.CB.lerp(tip, sub[0])
            parts.append(self.cone_ab("Andouiller", BACK, g_crest, s0, s0 + sub[1], 0.08, 0.02, seg=4, scale_x=0.6))
        a, b, c = self.CB + V((0, 0.10, 0.2)), self.UP_TIP + V((0, 0.03, -0.25)), self.BACK_TIP + V((0, -0.25, -0.02))
        outer = []
        for p, q in ((a, b), (b, c), (c, a)):
            for k in range(4):
                m = p.lerp(q, k / 4)
                if (p, q) == (b, c) and k % 2:  # bord libre déchiré (creusé vers a)
                    m = m.lerp(a, 0.16)
                outer.append(m)
        holes = []
        for (wa, wb, wc), r in (((0.5, 0.3, 0.2), 0.14), ((0.22, 0.52, 0.26), 0.1), ((0.28, 0.2, 0.52), 0.11)):
            o = a * wa + b * wb + c * wc
            holes.append([o + V((0, x, y)) for x, y in circle(r, 5, r * 0.8)])
        parts.append(self.hollow_plate("Voile", ACCENT, g_crest, outer, holes, (1, 0, 0)))
        # miroir à main accroché au cou : cordon (anneau à 8 pans), cadre violet, glace blanche des 2 côtés, manche
        g_neck = self.grp("rigid", "Neck1")
        c0, r = V((0, -0.26, 2.0)), 0.36
        ring = [c0 + V((r * math.sin(a), r * math.cos(a) * 0.9 - 0.02, 0.06 * math.cos(a)))
                for a in (2 * math.pi * k / 8 for k in range(9))]
        for p0, p1 in zip(ring, ring[1:]):
            parts.append(self.cone_ab("Cordon", ACCENT, g_neck, p0, p1, 0.035, 0.035, seg=4))
        mc = dd.snap(body, (0, -0.85, 1.62), 0.08)
        Mm = Matrix.Translation(mc) @ Matrix.Rotation(math.radians(-80), 4, "X") @ \
            Matrix.Rotation(math.radians(12), 4, "Y")
        parts.append(self.xf(self.part("Cadre", "cone", ACCENT, g_neck, segments=8, r1=1.0, r2=1.0, depth=1.0),
                             Mm @ Matrix.Diagonal((0.16, 0.2, 0.07, 1))))
        for sgn in (1, -1):
            Mg = Mm @ Matrix.Translation((0, 0, 0.037 * sgn)) @ (Matrix.Rotation(math.pi, 4, "Y") if sgn < 0
                                                                 else Matrix())
            parts.append(self.flat1("Glace", WHITE, g_neck, circle(0.16, 8, 0.12), Mg))
        parts.append(self.cone_ab("Manche", ACCENT, g_neck, Mm @ V((0, -0.19, 0)), Mm @ V((0, -0.4, 0)), 0.04,
                                  0.05, seg=4))
        parts.append(self.cone_ab("Lien", ACCENT, g_neck, ring[4], Mm @ V((0, 0.19, 0)), 0.025, 0.025, seg=4))
        parts.append(self.drape_mesh(self.grp("dist", ["Hips", "Tail1", "Tail2", "Tail3"])))
        # plaques dorsales (trapèzes biseautés), pointes de coude
        self.back_plates(body, parts, BACK, [(-0.10, 2.06, 0.24, 0.12), (0.12, 1.76, 0.30, 0.14),
                                             (0.32, 1.46, 0.24, 0.12)], kinds=("trapeze",))
        self.elbow_plates(body, parts, BACK)

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, self.SPINE, self.C[BELLY], cos_min=0.6, limbs=set(self.ARM_NODES), max_x=0.4)
        self.paint(me, lambda c, n: BACK if n.z > 0.6 and abs(c.x) < 0.4 and -0.6 < c.y < 0.3 and c.z > 1.5 else None)
        self.clean_islands(me, BELLY, MAIN)

    # ---------------------------------------------------------------- animations
    HOVER = 0.3  # studs (espace final) : le fantôme flotte, l'ourlet du drap ne touche pas le sol

    def origin_shift(self, m):
        return super().origin_shift(m) + V((0, 0, self.HOVER))

    def drape(self, t, amp=8.0, k=2, ph=0.0):
        self.tail(lambda i: ((Z, amp * (0.6 + 0.4 * i) * S2(t, k, ph - 0.12 * i)),
                             (X, amp * 0.5 * S2(t, k, ph + 0.25 - 0.12 * i))))

    # Idle farceur : flotte, bras-ailes levés vers l'avant façon fantôme (« ouhouh ») ; « clignote » (petit saut de
    # côté instantané, comme une téléportation), puis « BOUH ! » : se penche vers nous, ailes grandes ouvertes,
    # bec ouvert ; et rigole.
    def idle(self, t):
        self.base()
        br = S2(t, 2)
        blink = 1.0 if 0.28 <= t < 0.34 else 0.0  # quelques images décalées = clignotement
        boo = keys(t, [(0, 0), (0.48, 0), (0.54, 1), (0.70, 1), (0.82, 0), (1, 0)])
        laugh = keys(t, [(0, 0), (0.70, 0), (0.74, 1), (0.86, 1), (0.92, 0), (1, 0)])
        self.mv("Hips", x=0.35 * blink, z=0.06 * br - 0.04 * boo, rx=4 - 2 * br + 8 * boo, rz=3 * S2(t, 1) + 8 * blink)
        self.r("Spine", (X, -2 * br + 6 * boo))
        self.neck(rx=-4 + 4 * br + 10 * boo, rz=10 * S2(t, 1, 0.2) * (1 - boo),
                  head_rx=-14 * boo + 6 * laugh * S2(t, 12), head_ry=10 * S2(t, 1, 0.1) * (1 - boo))
        self.r("Jaw", (X, 8 + 4 * max(0.0, br) + 36 * boo + 18 * laugh * (0.5 + 0.5 * S2(t, 12))))
        self.r("Crest", (X, 3 * S2(t, 2, 0.2) - 8 * boo))
        rest = 1 - boo
        for side, _sx in SIDES:
            self.paws_pose(side, rest, up=self.PAWS["up"] * rest + 34 * boo + 4 * br,
                           sweep=self.PAWS["sweep"] * rest - 14 * boo,
                           wrist=self.PAWS["wrist"] * rest + 6 * S2(t, 2, 0.1) * rest)
        self.drape(t, 8 + 6 * boo, 2)

    # Marche = glisse en flottant, drap qui ondule
    def walk(self, t):
        self.base()
        self.mv("Hips", z=0.12 + 0.06 * S2(t, 2), rx=8, rz=5 * S2(t, 1))
        self.r("Spine", (X, 2 * S2(t, 2, 0.1)))
        self.neck(rx=-6 + 3 * S2(t, 2, 0.1), rz=-4 * S2(t, 1), head_rx=-4)
        self.r("Jaw", (X, 8))
        for side, sx in SIDES:
            self.wing_pose(side, up=-6 + 8 * S2(t, 1) * sx, sweep=18, elbow=-8, wrist=-8 + 6 * S2(t, 2, 0.15),
                           tip=-6 + 6 * S2(t, 2, 0.3), twist=-10, fold=30)
        self.tail(lambda i: ((X, 14 + 4 * i), (Z, 12 * (0.6 + 0.4 * i) * S2(t, 1, -0.15 * i))))

    def run(self, t):
        super().run(t)
        self.tail(lambda i: ((X, 30 + 8 * i * S2(t, 1, -0.12 * i)), (Z, 8 * S2(t, 1, -0.15 * i))))

    def attack(self, t):
        super().attack(t)
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.56, 1), (0.86, 0), (1, 0)])
        self.mv("Hips", y=0.22 * a - 0.45 * s, z=0.1 * s, rx=-12 * a + 12 * s)
        self.neck(rx=-24 * a + 8 * s, head_rx=-10 * a + 6 * s)
        self.tail(lambda i: ((X, 6 * a + 10 * s), (Z, 6 * S2(t, 2, -0.1 * i))))

    def roar(self, t):
        super().roar(t)
        r = keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        self.drape(t, 6 + 10 * r, 3)

    def celebrate(self, t):
        super().celebrate(t)
        self.drape(t, 14, 4)

    def death(self, t):
        super().death(t)
        f = keys(t, [(0, 0), (0.36, 0), (0.62, 1), (0.71, 0.9), (0.8, 1), (1, 1)])
        self.tail(lambda i: ((X, -20 * f), (Z, 8 * f)))


if __name__ == "__main__":
    Spectrosaure().main()
