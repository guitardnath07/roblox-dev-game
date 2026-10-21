# DINO DICE — Léviathodon (primordial, aquatique) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 1 (style n°1 + n°2 du brief : tête énorme, yeux lourds mi-clos, gueule souriante à grosses dents,
#   cuirasse en vraies plaques plates + 4 plots ronds, rendu en facettes, mesh final en flat)
# Référence réelle : Kronosaurus queenslandicus (pliosaure : tête énorme ≈ 1/3 du corps, cou presque inexistant,
# bout de mâchoire en cuillère à grosses dents, 4 grandes palettes en aile, les arrière plus grandes, queue courte).
# Couche thématique (docs/dinos-concept.md) : 7 plaques d'armure segmentées sur le dos (cuirasse de crustacé),
# chacune gravée d'une rune-vague émissive ; 4 palettes en ailes de raie (bord arrière ondulé) ; gorge en 2 pièces
# émissives visibles quand il bâille (mâchoire ouvrable à 70°) ; vortex autour de la queue = 2 anneaux en spirale
# (Ø 0,8 / 0,6 x 2,4) sur un os Vortex qui tourne. Personnalité : flegmatique, bâille énormément.
# Taille : HEIGHT = 3,0 studs (base aquatique, cf. build_flaquodon.py) x 2,4.
#   python3 <scratchpad>/bb.py blender/scripts/dinos/build_leviathodon.py [-- model]

import math
import os
import sys

import bmesh
import bpy
from mathutils.bvhtree import BVHTree

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_flaquodon import AquaLand  # noqa: E402
from flyer_swimmer_helpers import V, Matrix, S2, keys, X, Y, Z, frame_from, \
    MAIN, BELLY, ACCENT, GLOW, BACK, TONGUE, DARK  # noqa: E402
import dd_common as dd  # noqa: E402


class Leviathodon(AquaLand):
    ID, NAME = "leviathodon", "Leviathodon"
    COLORS = {"main": "#004D40", "belly": "#00838F", "accent": "#64FFDA", "glow": "#A7FFEB", "back": "#00332B"}
    HEIGHT = 3.0 * 2.4
    SKIN_ROOT = "corps"
    SMOOTH = 2
    NODES = [
        ("corps", (0, 0.25, 0.62), 0.66, None),
        ("poitrine", (0, -0.25, 0.68), 0.64, "corps"),
        ("cou", (0, -0.62, 0.80), 0.64, "poitrine"),
        ("tete", (0, -1.15, 1.00), 0.92, "cou"),
        ("museau", (0, -1.92, 0.88), 0.62, "tete"),
        ("bout", (0, -2.40, 0.84), 0.44, "museau"),
        ("queue1", (0, 0.85, 0.62), 0.42, "corps"),
        ("queue2", (0, 1.22, 0.60), 0.26, "queue1"),
        ("queue3", (0, 1.50, 0.58), 0.13, "queue2"),
    ]
    SPINE_PATH = ["corps", "poitrine", "cou"]
    HEAD_PATH = ["cou", "bout"]
    TAIL_PATH = ["corps", "queue1", "queue2", "queue3"]
    MOUTH = dict(P=(0, -1.9, 0.80), N=(0, 0.0, 1), y0=-0.9, gap=0.08, zmin=0.25, smile=0.14, smile_y=-1.7,
                 reach=0.45, shell=0.06)
    JAW_BONE = ((0, -0.85, 0.74), (0, -2.6, 0.72))
    FIN_F = ([(0.55, -0.45, 0.45), (1.10, -0.65, 0.25), (1.55, -0.55, 0.06)],
             [(0.60, -0.05, 0.42), (1.15, -0.10, 0.22), (1.50, -0.30, 0.06)])
    FIN_B = ([(0.55, 0.40, 0.45), (1.20, 0.50, 0.25), (1.75, 0.62, 0.06)],
             [(0.45, 0.85, 0.45), (1.00, 1.05, 0.22), (1.55, 0.98, 0.06)])
    FIN_NS, FIN_NC, FIN_THICK = 4, 2, 0.13
    EYE = ((0.5, -1.45, 1.75), 0.42)
    VORTEX = ((0, 0.95, 0.62), (0, 1.45, 0.62))  # os Vortex (axe de rotation = la queue)

    def fin_slot(self, u, v):
        return BELLY if v > 0.6 else MAIN

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, ["queue3", "queue2", "queue1", "corps", "poitrine", "cou", "tete", "museau",
                                          "bout"], self.C[BELLY], cos_min=0.5)
        # rayures sombres sur les flancs et le dessus de la tête
        self.paint(me, lambda c, n: BACK if abs(n.x) > 0.5 and n.z > -0.2 and -0.8 < c.y < 1.3
                   and (c.y + 0.3 * c.z) % 0.38 < 0.11 else None)
        self.clean_islands(me, BELLY, MAIN)

    def band(self, name, slot, gi, pts, width, M):
        """Bande plate (une face, vue de +Z local) le long d'une polyligne 2D : runes-vagues."""
        bm = bmesh.new()
        rows = []
        for k, (x, y) in enumerate(pts):
            a, b = V(pts[max(k - 1, 0)]), V(pts[min(k + 1, len(pts) - 1)])
            d = (b - a).normalized()
            nrm = V((-d.y, d.x)) * width * 0.5
            rows.append([bm.verts.new(M @ V((x + nrm.x * s, y + nrm.y * s, 0))) for s in (-1, 1)])
        for r0, r1 in zip(rows, rows[1:]):
            bm.faces.new((r0[0], r1[0], r1[1], r0[1]))
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, self.C[slot])
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def torus(self, name, slot, gi, center, R, r, tilt, N=12, M=4):
        """Anneau (tore grossier à facettes) autour de l'axe Y, incliné de `tilt` degrés (spirale)."""
        bm = bmesh.new()
        T = Matrix.Translation(center) @ Matrix.Rotation(math.radians(tilt), 4, "X") @ \
            Matrix.Rotation(math.radians(90), 4, "X")
        grid = []
        for i in range(N):
            a = 2 * math.pi * i / N
            ring = []
            for j in range(M):
                b = 2 * math.pi * j / M + math.pi / 4
                rr = R + r * math.cos(b)
                ring.append(bm.verts.new(T @ V((rr * math.cos(a), rr * math.sin(a), r * math.sin(b)))))
            grid.append(ring)
        for i in range(N):
            for j in range(M):
                i2, j2 = (i + 1) % N, (j + 1) % M
                bm.faces.new((grid[i][j], grid[i2][j], grid[i2][j2], grid[i][j2]))
        bmesh.ops.recalc_face_normals(bm, faces=bm.faces)
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, self.C[slot])
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def extras(self, body, parts):
        g_head, g_jaw = self.grp("rigid", "Head"), self.grp("rigid", "Jaw")
        self.fins(parts)
        # Yeux lourds mi-clos (flegmatique), iris aigue-marine
        tgt, es = self.EYE
        self.eyes_styled(body, parts, g_head, tgt, es, (-0.7, -1.4, 0.0), ACCENT, lid_slot=MAIN,
                         lid_n=(0.0, -0.1, 1.0), lid_d=0.3)
        # Grosses dents coniques (bout de mâchoire en cuillère)
        parts += self.teeth_arc(body, g_head, (0, 24, 48, 72), -1, 0.24, 0.085, inset=0.04, yc=-1.6,
                                side_ys=(-1.35, -1.1))
        parts += self.teeth_arc(body, g_jaw, (12, 36, 60), 1, 0.18, 0.07, inset=0.04, yc=-1.6, side_ys=(-1.2,))
        # Gorge en 2 pièces émissives (palais sur la tête, plancher sur la mâchoire) + langue
        zm = self.mouth_z(-1.2)
        parts.append(self.part("GorgeHaut", "sphere", GLOW, g_head, loc=(0, -1.1, zm + 0.16), scale=(0.3, 0.3, 0.06),
                               u=8, v=4))
        parts.append(self.part("GorgeBas", "sphere", ACCENT, g_jaw, loc=(0, -1.15, zm - 0.18), scale=(0.32, 0.34, 0.06),
                               u=8, v=4))
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.7, zm - 0.12), scale=(0.24, 0.42, 0.06),
                               u=6, v=4))
        parts.append(self.part("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.16, -2.6, 1.15), -0.01),
                               scale=(0.04, 0.05, 0.035), mirror_x=True, u=5, v=3))
        # Petites pointes derrière les yeux
        for dx, y in ((0.32, -1.0), (0.18, -0.8)):
            b = dd.snap(body, (dx, y, 2.2), -0.03)
            parts.append(self.cone_ab("Pointe", ACCENT, g_head, b, b + V((0.03, 0.08, 0.18)), 0.08, 0.0, seg=4,
                                      scale_x=0.5, mirror_x=True))
        # Cuirasse : 7 plaques plates biseautées qui se chevauchent, chacune gravée d'une rune-vague émissive
        bones = ["Spine1", "Spine2", "Spine3", "Tail1", "Tail2", "Tail3"]
        me = body.data
        bvh = BVHTree.FromPolygons([v.co for v in me.vertices], [p.vertices[:] for p in me.polygons])
        for k in range(7):
            y = -0.5 + 1.8 * k / 6
            w = 0.95 - 0.08 * k - 0.25 * (k / 6) ** 2
            L = 0.34 - 0.02 * k
            loc, nor, _i, _d = bvh.ray_cast(V((0, y, 5.0)), V((0, 0, -1)))  # dessus du dos, pas la tête
            nor = (nor + V((0, 0.35, 0))).normalized()  # bord arrière relevé : écailles qui se recouvrent
            M = frame_from(loc + nor * 0.05, nor, up=(0, -1, 0))
            g = self.grp("dist", bones)
            outline = [(-w * 0.5, -L * 0.5), (-w * 0.38, -L * 0.62), (w * 0.38, -L * 0.62), (w * 0.5, -L * 0.5),
                       (w * 0.42, L * 0.55), (-w * 0.42, L * 0.55)]
            parts.append(self.flat("Plaque", BELLY, g, outline, M, 0.1))
            wave = [(x, 0.05 * math.sin(x / (w * 0.3) * math.pi)) for x in
                    (w * (-0.32 + 0.64 * i / 8) for i in range(9))]
            parts.append(self.band("Rune", ACCENT, g, wave, 0.05, M @ Matrix.Translation((0, 0, 0.052))))
            if k == 2:  # 4 plots ronds façon pièce de construction sur la plus grande plaque
                for sx, sy in ((-1, -1), (1, -1), (-1, 1), (1, 1)):
                    c = M @ V((sx * w * 0.22, sy * L * 0.27, 0.05))
                    parts.append(self.cone_ab("Plot", BELLY, g, c, c + nor * 0.06, 0.06, 0.06, seg=8))
        # Bord arrière ondulé des palettes (ailes de raie) : lobes plats
        for key, (lead, trail) in (("F", self.FIN_F), ("B", self.FIN_B)):
            pts = [V(p) for p in trail]
            for k in range(5):
                u = 0.15 + 0.85 * k / 4
                seg = min(int(u * 2), 1)
                p = pts[seg].lerp(pts[seg + 1], u * 2 - seg)
                bone = "Fin%s%d.S" % (key, 1 if u < 0.5 else 2)
                parts.append(self.part("Ondule", "sphere", MAIN, self.grp("rigid", bone), loc=p + V((0, 0.04, 0)),
                                       scale=(0.12, 0.11, 0.05), mirror_x=True, u=6, v=3))
        self.claws(parts, n=(0.15, 0.5, 0.85), L=0.2, r=0.065)
        # Vortex : 2 anneaux en spirale autour de la queue (os Vortex qui tourne)
        g_v = self.grp("rigid", "Vortex")
        a, _b = (V(p) for p in self.VORTEX)
        parts.append(self.torus("Vortex", GLOW, g_v, a + V((0, 0.05, 0.02)), 0.32, 0.035, 20))
        parts.append(self.torus("Vortex", ACCENT, g_v, a + V((0, 0.32, 0.0)), 0.24, 0.03, -25))

    def extra_bones(self):
        a, b = (V(p) for p in self.VORTEX)
        return [("Vortex", a, b, "Tail1", False, True)]

    def vortex(self, t, turns):
        """L'eau tourbillonne : rotation continue autour de l'axe de la queue (boucle exacte si `turns` entier)."""
        self.r("Vortex", (Y, (360 * turns * t) % 360))

    # Idle flegmatique : respire lentement, regard lourd, puis ÉNORME bâillement (mâchoire à 70°)
    def idle(self, t):
        super().idle(t)
        y = keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.6, 1), (0.7, 0), (1, 0)])
        st = keys(t, [(0, 0), (0.28, 0), (0.4, 1), (0.62, 1), (0.72, 0), (1, 0)])
        # bâillement : se redresse et lève le nez pour que la mâchoire à 70° reste au-dessus du sol
        self.mv("Spine1", z=0.03 + 0.12 * st, rx=-10 * st)
        for b in self.NECK:
            self.r(b, (X, -14 * st / len(self.NECK)))
        self.r("Head", (X, -30 * y + 2 * S2(t, 3)), (Y, 6 * y * S2(t, 3)))
        self.r("Jaw", (X, 4 + 66 * y))
        self.fins_pose(lambda key: dict(up=(4 if key == "F" else 2) + 10 * st * (key == "F"), sweep=-6 * st))
        self.vortex(t, 3)

    def walk(self, t):
        super().walk(t)
        self.vortex(t, 1)

    def run(self, t):
        super().run(t)
        self.vortex(t, 1)

    def attack(self, t):
        super().attack(t)
        j = keys(t, [(0, 0), (0.2, 0.5), (0.33, 1), (0.42, 0), (0.48, 0.35), (0.56, 0), (1, 0)])
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.58, 1), (0.86, 0), (1, 0)])
        self.mv("Spine1", y=0.15 * a - 0.3 * s, z=0.04 + 0.1 * a + 0.08 * s)
        self.mv("Spine1", y=0.15 * a - 0.3 * s, z=0.06 + 0.12 * a + 0.12 * s, rx=-6 * a - 6 * s)
        self.r("Head", (X, -24 * a - 16 * s), (Z, 5 * s * S2(t, 3)))
        self.r("Jaw", (X, 40 * j))
        self.vortex(t, 2)

    def roar(self, t):
        super().roar(t)
        r = keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        self.r("Jaw", (X, 70 * r))
        self.vortex(t, 3)

    def celebrate(self, t):
        super().celebrate(t)
        self.vortex(t, 4)

    def death(self, t):
        super().death(t)
        h = keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        c = keys(t, [(0, 0), (0.34, 0), (0.55, 1), (1, 1)])
        # grandes palettes : repliées vers le dos pendant le roulé (sinon celle du dessous se plante dans le sol)
        self.fins_pose(lambda key: dict(up=18 * h + 75 * c, bend=10 * c))
        self.vortex(t * keys(t, [(0, 1), (1, 0.4)]), 2)


if __name__ == "__main__":
    Leviathodon().main()
