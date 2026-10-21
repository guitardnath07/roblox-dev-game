# DINO DICE — Abyssaure (épique, aquatique) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 1 (style n°1 + n°2 du brief : tête énorme, gros yeux ronds à sourcil narquois, sourire à 2 rangs de
#   dents, rendu en plaques/facettes, mesh final en flat)
# Référence réelle : Tylosaurus (mosasaure : longue tête de lézard marin à bout de museau en « bouton », 4 nageoires
# en palette, queue coudée vers le bas avec nageoire en croissant). Couche thématique (docs/dinos-concept.md) :
# antenne-lanterne (tige courbe 0,6 x 1,3 partant du front, 2 os) terminée par une boule à facettes (icosphère,
# Ø 0,2 x 1,3, facettes cyan / blanc alternées, émissive) ; 8 points lumineux par flanc ; bord des nageoires frangé
# (5 dents arrondies) ; yeux ronds avec reflet ; 2 rangs de petites dents blanches visibles bouche fermée.
# Personnalité : fêtard des profondeurs, balance sa lanterne comme une boule à facettes (os Antenna1/Antenna2).
# Taille : HEIGHT = 3,0 studs (base aquatique, cf. build_flaquodon.py) x 1,3.
#   python3 <scratchpad>/bb.py blender/scripts/dinos/build_abyssaure.py [-- model]

import math
import os
import sys

import bmesh
import bpy

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_flaquodon import AquaLand  # noqa: E402
from flyer_swimmer_helpers import V, Matrix, S2, keys, X, Y, Z, plane_yz, frame_from, circle, mirror_inplace, \
    MAIN, BELLY, ACCENT, GLOW, BACK, TONGUE, DARK  # noqa: E402
import dd_common as dd  # noqa: E402


class Abyssaure(AquaLand):
    ID, NAME = "abyssaure", "Abyssaure"
    COLORS = {"main": "#1A237E", "belly": "#283593", "accent": "#00E5FF", "glow": "#E0FFFF", "back": "#0B1150"}
    HEIGHT = 3.0 * 1.3
    SKIN_ROOT = "corps"
    SMOOTH = 2
    NODES = [
        ("corps", (0, 0.15, 0.56), 0.58, None),
        ("poitrine", (0, -0.30, 0.60), 0.56, "corps"),
        ("cou", (0, -0.72, 0.74), 0.54, "poitrine"),
        ("tete", (0, -1.18, 0.98), 0.84, "cou"),
        ("museau", (0, -1.85, 0.84), 0.55, "tete"),
        ("bout", (0, -2.32, 0.76), 0.34, "museau"),
        ("queue1", (0, 0.68, 0.56), 0.40, "corps"),
        ("queue2", (0, 1.08, 0.50), 0.28, "queue1"),
        ("queue3", (0, 1.42, 0.44), 0.17, "queue2"),
        ("queue4", (0, 1.68, 0.36), 0.10, "queue3"),
    ]
    SPINE_PATH = ["corps", "poitrine", "cou"]
    HEAD_PATH = ["cou", "bout"]
    TAIL_PATH = ["corps", "queue1", "queue2", "queue3", "queue4"]
    MOUTH = dict(P=(0, -1.8, 0.70), N=(0, 0.0, 1), y0=-1.0, gap=0.06, zmin=0.25, smile=0.13, smile_y=-1.75,
                 reach=0.4, shell=0.05)
    JAW_BONE = ((0, -0.95, 0.64), (0, -2.55, 0.62))
    FIN_F = ([(0.42, -0.55, 0.42), (0.85, -0.75, 0.22), (1.20, -0.80, 0.05)],
             [(0.48, -0.15, 0.40), (0.95, -0.40, 0.20), (1.28, -0.55, 0.05)])
    FIN_B = ([(0.40, 0.28, 0.40), (0.80, 0.40, 0.20), (1.08, 0.50, 0.05)],
             [(0.36, 0.60, 0.40), (0.72, 0.76, 0.20), (0.98, 0.82, 0.05)])
    FIN_NS, FIN_NC, FIN_THICK = 4, 2, 0.12
    EYE = ((0.45, -1.50, 1.42), 0.38)
    ANT = [(0, -1.30, 1.62), (0, -1.45, 2.12), (0, -1.82, 2.32)]  # tige de l'antenne (racine -> boule)

    def fin_slot(self, u, v):
        return BELLY if v > 0.55 else MAIN

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, ["queue4", "queue3", "queue2", "queue1", "corps", "poitrine", "cou", "tete",
                                          "museau", "bout"], self.C[BELLY], cos_min=0.5)
        # rayures dorsales sombres (bandes de profondeur)
        self.paint(me, lambda c, n: BACK if n.z > 0.5 and -1.0 < c.y < 2.0 and (c.y % 0.4) < 0.16 else None)
        self.clean_islands(me, BELLY, MAIN)

    def ico(self, name, gi, center, r):
        """Boule à facettes : icosaèdre subdivisé une fois (80 facettes), facettes cyan / blanc alternées."""
        bm = bmesh.new()
        bmesh.ops.create_icosphere(bm, subdivisions=2, radius=r)
        bmesh.ops.translate(bm, vec=V(center), verts=bm.verts)
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        attr = dd.fill_color(me, self.C[ACCENT])
        for p in me.polygons:
            if (p.index * 7) % 3 == 0:
                for li in p.loop_indices:
                    attr.data[li].color_srgb = self.C[GLOW]
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def extras(self, body, parts):
        g_head, g_jaw = self.grp("rigid", "Head"), self.grp("rigid", "Jaw")
        self.fins(parts)
        # Gros yeux ronds, iris cyan, sourcil relevé vers l'extérieur (air narquois de fêtard)
        tgt, es = self.EYE
        self.eyes_styled(body, parts, g_head, tgt, es, (-0.9, -1.6, 0.1), ACCENT, lid_slot=MAIN,
                         lid_n=(0.45, -0.3, 1.0), lid_d=0.74)
        # Bout du museau en « bouton »
        parts.append(self.part("Bouton", "sphere", BELLY, g_head, loc=dd.snap(body, (0, -2.8, 0.82), -0.06),
                               scale=(0.2, 0.16, 0.18), u=8, v=5))
        parts.append(self.part("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.12, -2.45, 1.02), -0.01),
                               scale=(0.035, 0.045, 0.03), mirror_x=True, u=5, v=3))
        # 2 rangs de petites dents blanches le long de la longue gueule
        parts += self.teeth_arc(body, g_head, (0, 40), -1, 0.12, 0.05, inset=0.03, yc=-2.1,
                                side_ys=(-1.95, -1.7, -1.45, -1.22))
        parts += self.teeth_arc(body, g_jaw, (20,), 1, 0.1, 0.045, inset=0.03, yc=-2.1,
                                side_ys=(-1.85, -1.6, -1.36))
        zt = self.mouth_z(-1.6) - 0.08
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.55, zt), scale=(0.16, 0.38, 0.05),
                               u=6, v=4))
        # Antenne-lanterne (2 os) + boule à facettes
        a0, a1, a2 = (V(p) for p in self.ANT)
        a0 = dd.snap(body, a0 + V((0, 0, 0.3)), -0.05)
        g1, g2 = self.grp("rigid", "Antenna1"), self.grp("rigid", "Antenna2")
        parts.append(self.cone_ab("Antenne", BELLY, g1, a0, a1, 0.07, 0.05, seg=6))
        parts.append(self.cone_ab("Antenne", BELLY, g2, a1, a2, 0.05, 0.035, seg=6))
        parts.append(self.ico("BouleFacettes", g2, a2 + V((0, -0.08, -0.1)), 0.15))
        # 8 points lumineux en ligne sur chaque flanc (disques 0,06 x 1,3)
        for k in range(8):
            y = -0.6 + 1.7 * k / 7
            z = 0.66 - 0.08 * (k / 7) ** 2
            _ok, loc, nor, _ = body.closest_point_on_mesh(V((1.0, y, z)))
            M = frame_from(loc + nor * 0.012, nor)
            g = self.grp("dist", ["Spine1", "Spine2", "Tail1", "Tail2", "Tail3"])
            parts.append(mirror_inplace(self.flat1("Lumiere", ACCENT, g, circle(0.078, 6), M)))
        # Franges : 5 dents arrondies sur le bord de fuite de chaque nageoire
        for key, (lead, trail) in (("F", self.FIN_F), ("B", self.FIN_B)):
            pts = [V(p) for p in trail]
            for k in range(5):
                u = 0.2 + 0.8 * k / 4
                seg = min(int(u * 2), 1)
                f = u * 2 - seg
                p = pts[seg].lerp(pts[seg + 1], f)
                bone = "Fin%s%d.S" % (key, 1 if u < 0.5 else 2)
                parts.append(self.part("Frange", "sphere", MAIN, self.grp("rigid", bone), loc=p + V((0, 0.05, 0)),
                                       scale=(0.1, 0.1, 0.045), mirror_x=True, u=6, v=3))
        # Nageoire caudale en croissant (lobe bas plus grand, posé au sol), plan vertical
        g_tail = self.grp("rigid", "Tail%d" % self.NT)
        q = self.pos["queue4"]
        M = Matrix.Translation(q + V((0, -0.05, 0))) @ plane_yz(math.radians(180))
        parts.append(self.flat("Caudale", MAIN, g_tail, [(0, 0), (-0.32, 0.12), (-0.33, 0.5), (-0.15, 0.3),
                                                          (0.0, 0.3), (0.26, 0.42), (0.24, 0.14)], M, 0.07))
        # Petites pointes sur le dos et la queue
        for i, (y, bone) in enumerate(((-0.45, "Spine2"), (-0.08, "Spine1"), (0.3, "Tail1"), (0.62, "Tail2"),
                                       (0.95, "Tail3"))):
            b = dd.snap(body, (0, y, 1.6), -0.03)
            parts.append(self.cone_ab("Pointe", ACCENT, self.grp("rigid", bone), b, b + V((0, 0.07, 0.17 - 0.02 * i)),
                                      0.08, 0.0, seg=4, scale_x=0.45))
        self.claws(parts, n=(0.2, 0.6, 0.95), L=0.13, r=0.045)

    def extra_bones(self):
        a0, a1, a2 = (V(p) for p in self.ANT)
        return [("Antenna1", a0, a1, "Head", False, True), ("Antenna2", a1, a2, "Antenna1", True, True)]

    def antenna(self, t, amp, k=2, ph=0.0, pitch=0.0):
        """La lanterne se balance comme une boule à facettes (retard du 2e segment)."""
        self.r("Antenna1", (Y, amp * S2(t, k, ph)), (X, pitch))
        self.r("Antenna2", (Y, amp * 1.4 * S2(t, k, ph - 0.12)), (X, pitch * 0.6 + 6 * S2(t, 2 * k, ph)))

    # Idle fêtard : dodeline au rythme, balance sa lanterne, tape des nageoires
    def idle(self, t):
        super().idle(t)
        beat = S2(t, 8)
        groove = keys(t, [(0, 0), (0.2, 0), (0.3, 1), (0.8, 1), (0.9, 0), (1, 0)])
        self.mv("Spine1", z=0.02 + 0.02 * groove * (1 + beat), rz=6 * groove * S2(t, 4))
        self.r("Head", (Y, 10 * groove * S2(t, 4)), (X, -3 * groove * (1 + beat)))
        self.antenna(t, 10 + 22 * groove, 4)
        self.fins_pose(lambda key: dict(up=(14 if key == "F" else 4) * groove * (1 + S2(t, 8, 0.25)) + 4,
                                        sweep=-8 * groove))

    def walk(self, t):
        super().walk(t)
        self.antenna(t, 14, 2, 0.1)

    def run(self, t):
        super().run(t)
        self.antenna(t, 10, 1, 0.2, pitch=8 * S2(t, 1, 0.4))

    def attack(self, t):
        super().attack(t)
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.58, 1), (0.86, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.2, 0.5), (0.33, 1), (0.42, 0), (0.48, 0.35), (0.56, 0), (1, 0)])
        # longue mâchoire : la morsure part vers l'avant-haut pour que la mâchoire ouverte ne pique pas dans le sol
        self.mv("Spine1", y=0.15 * a - 0.3 * s, z=0.04 + 0.1 * a + 0.08 * s)
        self.r("Head", (X, -18 * a - 6 * s), (Z, 6 * s * S2(t, 3)))
        self.r("Jaw", (X, 34 * j))
        self.antenna(t, 18 * keys(t, [(0, 0), (0.4, 1), (1, 0)]), 3, pitch=-14 * keys(t, [(0, 0), (0.3, 1), (0.5, 0)]))

    def roar(self, t):
        super().roar(t)
        self.antenna(t, 16, 4, pitch=12 * keys(t, [(0, 0), (0.3, 1), (0.76, 1), (0.9, 0)]))

    def celebrate(self, t):
        super().celebrate(t)
        self.antenna(t, 30, 4)

    def death(self, t):
        super().death(t)
        self.antenna(t, 14 * keys(t, [(0, 1), (1, 0)]), 3, pitch=30 * keys(t, [(0, 0), (0.6, 1), (1, 1)]))


if __name__ == "__main__":
    Abyssaure().main()
