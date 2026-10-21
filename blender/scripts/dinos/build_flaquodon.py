# DINO DICE — Flaquodon (peu commun, aquatique) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 3 (v3 : MISE À JOUR STYLE n°2 : rendu en plaques/facettes, primitives grossières, mesh final en flat ;
#   v2 : MISE À JOUR STYLE du brief : tête énorme, gros yeux à paupière boudeuse, gueule souriante
#   ouverte à dents triangulaires, griffes crème aux nageoires, petites pointes, taches foncées, pose prête à bondir)
# Référence réelle : Henodus chelyops (placodonte « tortue plate » : carapace très plate plus large que longue,
# tête au museau carré à bec, 4 nageoires courtes aux coins). Couche thématique (docs/dinos-concept.md) :
# carapace = disque de flaque (12 côtés) couleur secondaire + 3 cercles de ricochet, goutte émissive sur le front,
# nénuphar fendu posé de travers sur la carapace, joues = 2 sphères séparées (os Cheek, gonflent par translation).
# Premier aquatique : il vit HORS de l'eau (socle) -> HOVER = 0, ventre et bouts de nageoires au sol, animations
# « terrestres » (reptation en diagonale, galop à plat ventre, se retourne sur le dos à la mort).
# Convention de taille aquatique (posée ici) : HEIGHT = 3,0 studs x taille de la fiche (0,8).
#   python3 <scratchpad>/bb.py blender/scripts/dinos/build_flaquodon.py [-- model]

import math
import os
import sys

import bmesh
import bpy
from mathutils.bvhtree import BVHTree

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from flyer_swimmer_helpers import Aqua, V, Matrix, SIDES, S2, keys, X, Y, Z, pulse, mirror_inplace, frame_from, \
    MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402
import dd_common as dd  # noqa: E402


class AquaLand(Aqua):
    """Aquatique posé HORS de l'eau (socle) : ventre et bouts de nageoires au sol (HOVER = 0), rendu en plaques
    (mesh final en flat), outils de style partagés par les 5 aquatiques (dents, paupières, griffes, reflets) et
    animations « terrestres » génériques (reptation, galop, coup de gueule, cabré, sauts, roulé sur le flanc).
    Les build_<id>.py aquatiques importent cette classe : from build_flaquodon import AquaLand."""
    HOVER = 0.0
    BG = (0.20, 0.26, 0.30)
    FIN_NS, FIN_NC = 4, 2
    NECK = ("Spine3", "Spine4")  # os relevés au rugissement / tendus à l'attaque
    ROLL = 100  # mort : roulé sur le flanc (degrés)
    ROLL_LIFT = 1.0  # levée (squelette) au milieu du roulé pour que le flanc ne traverse pas le sol
    CRAWL = (24, 26)  # levée / balayage des nageoires à la marche
    DEATH_DROP = 1.8  # départ trop bas : le réajustement de la descente (helper) converge alors par en dessous

    def build_mesh(self):
        sc, col, rcol, ob, st = super().build_mesh()
        ob.data.polygons.foreach_set("use_smooth", [False] * len(ob.data.polygons))  # plaques : une normale par face
        ob.data.update()
        return sc, col, rcol, ob, st

    def ring(self, name, slot, gi, r_in, r_out, n, M, sx=1.0, sy=1.0):
        """Anneau plat (une face, vue de +Z local) : cercles de ricochet."""
        bm = bmesh.new()
        inn = [bm.verts.new(M @ V((r_in * sx * math.cos(a), r_in * sy * math.sin(a), 0)))
               for a in (2 * math.pi * i / n for i in range(n))]
        out = [bm.verts.new(M @ V((r_out * sx * math.cos(a), r_out * sy * math.sin(a), 0)))
               for a in (2 * math.pi * i / n for i in range(n))]
        for i in range(n):
            j = (i + 1) % n
            bm.faces.new((inn[i], out[i], out[j], inn[j]))
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, self.C[slot])
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def teeth_arc(self, body, gi, angles, sign, L, r, inset=0.07, yc=None, side_ys=()):
        """Dents réparties sur l'arc avant de la bouche : rayon lancé depuis l'axe (y = yc, centre de la tête par
        défaut) à l'angle donné (0 = droit devant), un peu au-dessus (haut) / au-dessous (bas) de la fente, puis
        rentré de `inset` ; side_ys ajoute des dents sur le côté (rayon à 90° depuis l'axe en y) pour les museaux longs."""
        m = self.MOUTH
        me = body.data
        bvh = BVHTree.FromPolygons([v.co for v in me.vertices], [p.vertices[:] for p in me.polygons])
        yc = self.pos["tete"].y - 0.1 if yc is None else yc  # le Skin lissé est bien plus petit que ses rayons
        out = []
        for a, c in [(a, V((0, yc, 0))) for a in angles] + [(90, V((0, y, 0))) for y in side_ys]:
            d = V((math.sin(math.radians(a)), -math.cos(math.radians(a)), 0))
            y = c.y + d.y * 0.4
            z = self.mouth_z(y) + self.smile_dz(y)
            o = V((0, c.y, z - sign * (m["gap"] + 0.06)))  # rayon lancé de l'extérieur : la coque intérieure de la bouche est ignorée
            hit, _n, _i, _d = bvh.ray_cast(o + d * 3.0, -d)  # (Object.ray_cast renvoie ici des points faux)
            if hit is None:
                continue
            p = hit - d * inset
            p.z = z - sign * (m["gap"] + 0.01)
            out.append(self.part("Dent", "cone", WHITE, gi, loc=(p.x, p.y, p.z + sign * L * 0.5 - sign * 0.01),
                                 rot=(0 if sign > 0 else 180, 0, 0), mirror_x=True, segments=4, r1=r, r2=0.0,
                                 depth=L))
        return out

    def lid(self, name, slot, gi, center, size, normal, d):
        """Paupière : calotte d'ellipsoïde (un peu plus grande que l'œil) coupée par un plan incliné, symétrisée."""
        bm = bmesh.new()
        bmesh.ops.create_uvsphere(bm, u_segments=10, v_segments=8, radius=1.0)
        bmesh.ops.transform(bm, matrix=Matrix.Translation(center) @ Matrix.Diagonal((size * 1.12, size * 1.12,
                                                                                       size * 1.26, 1)),
                            verts=bm.verts)
        n = V(normal).normalized()
        bmesh.ops.bisect_plane(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:], plane_co=center + n * d * size,
                               plane_no=n, clear_inner=True)
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, self.C[slot])
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return mirror_inplace(self.tag(ob, gi))

    def eyes_styled(self, body, parts, gi, tgt, es, look, iris_slot, lid_slot=MAIN, lid_n=(-0.4, -0.3, 1.0), lid_d=0.62,
                    iris=0.7, pupil=0.42, ring_slot=None):
        """Gros yeux expressifs en facettes : blanc + iris vif + grosse pupille + 2 reflets sous une paupière qui donne
        l'attitude (lid_n incliné vers l'intérieur = air boudeur/déterminé). ring_slot : anneau oculaire à 8 pans."""
        look = V(look)
        parts += self.eyes(body, tgt, es, gi, iris_slot=iris_slot, look=look, iris=iris, pupil=pupil, highlights=False)
        _ok, loc, nor, _ = body.closest_point_on_mesh(V(tgt))
        lk = (nor + look).normalized()
        ec = loc - nor * es * 0.3
        fr = frame_from(ec + lk * es * 0.95, lk)  # même repère que l'iris (helper eyes)
        for dx, dy, r in ((-0.26, 0.12, 0.2), (0.24, -0.26, 0.1)):
            rf = self.part("Reflet", "sphere", WHITE, gi, scale=(es * r, es * r, es * 0.08), u=8, v=4)
            parts.append(mirror_inplace(self.xf(rf, fr @ Matrix.Translation((dx * es, dy * es, 0.03)))))
        if lid_slot:
            parts.append(self.lid("Paupiere", lid_slot, gi, ec, es, lid_n, lid_d))
        if ring_slot:
            fr2 = frame_from(ec + lk * es * 0.5, lk)  # posé sur le globe, autour de l'iris
            parts.append(mirror_inplace(self.ring("AnneauOeil", ring_slot, gi, es * 0.86, es * 1.0, 8, fr2)))
        return ec, lk

    def claws(self, parts, n=(0.12, 0.5, 0.88), L=0.17, r=0.055, slot=WHITE):
        """Griffes crème au bout des nageoires (pattes « d'ours »), sur l'os FinX2."""
        for key, spec in (("F", self.FIN_F), ("B", self.FIN_B)):
            if not spec:
                continue
            lead, trail = spec
            g_f = self.grp("rigid", "Fin%s2.S" % key)
            a, b = V(lead[-1]), V(trail[-1])
            mid = (V(lead[-2]) + V(trail[-2])) / 2
            for k in n:
                p0 = a.lerp(b, k)
                d = (p0 - mid)
                d.z = 0
                d.normalize()
                parts.append(self.cone_ab("Griffe", slot, g_f, p0 - d * 0.05 + V((0, 0, 0.02)),
                                          p0 + d * L + V((0, 0, -0.01)), r, 0.0, seg=5, mirror_x=True))

    def gem(self, name, slot, gi, a, b, r, k=0.4, seg=8, mirror_x=False):
        """Gemme taillée (bipyramide à `seg` pans) de a vers b, rondiste au fraction k : cristaux, lobes diamant."""
        g = V(a).lerp(V(b), k)
        return [self.cone_ab(name, slot, gi, a, g, r * 0.35, r, seg=seg, mirror_x=mirror_x),
                self.cone_ab(name, slot, gi, g, b, r, 0.0, seg=seg, mirror_x=mirror_x)]

    def cheeks(self, k):
        pass

    def flipper(self, key, side, ph, lift, swing):
        """Reptation : ph 0..0.5 = nageoire levée qui revient vers l'avant, 0.5..1 = appui qui pousse."""
        s = math.sin(2 * math.pi * ph)
        self.fin_pose(key, side, up=lift * max(0.0, s), sweep=swing * math.cos(2 * math.pi * ph), bend=lift * 0.3 * max(0.0, s))

    def crawl(self, t, k, lift, swing):
        for key, side, off in (("F", "L", 0.0), ("B", "R", 0.0), ("F", "R", 0.5), ("B", "L", 0.5)):
            self.flipper(key, side, (k * t + off) % 1.0, lift, swing)

    def tail(self, fn):
        for i in range(self.NT):
            self.r("Tail%d" % (i + 1), *fn(i))

    def fins_pose(self, fn):
        for key in ("F", "B"):
            for side, _sx in SIDES:
                self.fin_pose(key, side, **fn(key))

    # ---------------------------------------------------------------- animations génériques (hors de l'eau)
    def idle(self, t):
        self.base()
        br = S2(t, 3)
        look = keys(t, [(0, 0), (0.25, 0), (0.35, 1), (0.5, 1), (0.6, -1), (0.78, -1), (0.88, 0), (1, 0)])
        self.mv("Spine1", z=0.015 + 0.012 * (1 + br))
        for i, b in enumerate(self.NECK):
            self.r(b, (X, -1.5 * br), (Z, 4 * look))
        self.r("Head", (Z, 12 * look), (X, 2 * br), (Y, -5 * look))
        self.r("Jaw", (X, 3 + 3 * max(0.0, br)))
        self.fins_pose(lambda key: dict(up=(6 if key == "F" else 3) * (1 + S2(t, 2, 0.1 if key == "F" else 0.4)),
                                        sweep=4 * S2(t, 1)))
        self.tail(lambda i: ((Z, (5 + 2 * i) * S2(t, 1, -0.08 * i)), (X, 3)))

    def walk(self, t):
        self.base()
        bob = abs(math.sin(2 * math.pi * 2 * t))
        self.mv("Spine1", z=0.02 + 0.03 * bob, rz=4 * S2(t, 1))
        for i in range(1, self.NS):
            self.r("Spine%d" % (i + 1), (Z, -3 * S2(t, 1, 0.05 * i)))
        self.r("Head", (Z, -4 * S2(t, 1)), (X, 2 * S2(t, 2, 0.1)))
        self.r("Jaw", (X, 4))
        self.crawl(t, 1, *self.CRAWL)
        self.tail(lambda i: ((Z, -(8 + 3 * i) * S2(t, 1, -0.1 * (i + 1))), (X, 3)))

    def run(self, t):
        self.base()
        ph = t % 1.0
        bounce = max(0.0, math.sin(2 * math.pi * ph))
        self.mv("Spine1", z=0.07 + 0.14 * bounce, y=-0.04 * bounce, rx=-3 * math.sin(2 * math.pi * ph + 0.6))
        for b in self.NECK:
            self.r(b, (X, 3 * math.sin(2 * math.pi * ph + 0.8)))
        self.r("Head", (X, 5 * math.sin(2 * math.pi * ph + 1.0)))
        self.r("Jaw", (X, 12))
        for side, _sx in SIDES:
            self.flipper("F", side, ph, 34, 32)
            self.flipper("B", side, (ph + 0.35) % 1.0, 28, 28)
        self.tail(lambda i: ((X, 5 + 6 * math.sin(2 * math.pi * ph - 0.5 * i)), (Z, 6 * S2(t, 1, -0.1 * i))))

    def attack(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.58, 1), (0.86, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.2, 0.5), (0.33, 1), (0.42, 0), (0.48, 0.35), (0.56, 0), (1, 0)])
        self.mv("Spine1", y=0.15 * a - 0.3 * s, z=0.03 + 0.06 * a + 0.04 * s)
        for b in self.NECK:
            self.r(b, (X, -8 * a + 6 * s))
        self.r("Head", (X, -12 * a + 10 * s), (Z, 6 * s * S2(t, 3)))
        self.r("Jaw", (X, 45 * j))
        for side, _sx in SIDES:
            self.fin_pose("F", side, up=24 * a, sweep=-18 * a + 22 * s)
            self.fin_pose("B", side, up=4 * a, sweep=10 * s)
        self.tail(lambda i: ((X, 4 + 3 * a), (Z, (10 + 4 * i) * s * S2(t, 3, -0.1 * i))))

    def roar(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.16, 1), (0.26, 0), (1, 0)])
        r = keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * S2(t, 7)
        self.mv("Spine1", z=0.03 + 0.05 * r)
        n = len(self.NECK)
        for b in self.NECK:
            self.r(b, (X, (6 * a - 30 * r) / n))
        self.r("Head", (X, 6 * a - 12 * r + 3 * sh), (Z, 6 * sh))
        self.r("Jaw", (X, 4 * a + 55 * r))
        for side, _sx in SIDES:
            self.fin_pose("F", side, up=4 * a + 34 * r + 6 * sh, sweep=8 * a - 26 * r, bend=10 * r)
            self.fin_pose("B", side, up=4 * r)
        self.tail(lambda i: ((X, 4 + 6 * r), (Z, 6 * S2(t, 4, -0.1 * i) * r)))

    def celebrate(self, t):
        self.base()
        joy = keys(t, [(0, 0), (0.08, 1), (0.86, 1), (1, 0)])
        spin = keys(t, [(0, 0), (0.14, 0), (0.62, 360), (1, 360)])
        air = pulse(t, 0.12, 0.40) + pulse(t, 0.48, 0.76)
        self.mv("Spine1", z=0.02 + 0.5 * air, rz=spin)
        for b in self.NECK:
            self.r(b, (X, -6 * joy))
        self.r("Head", (X, -6 * joy), (Y, 10 * S2(t, 3) * joy))
        self.r("Jaw", (X, 30 * joy))
        self.fins_pose(lambda key: dict(up=(40 if key == "F" else 14) * joy + (12 + 16 * S2(t, 5)) * air,
                                        sweep=-8 * air - (16 if key == "F" else 0) * joy))
        self.tail(lambda i: ((Z, 16 * S2(t, 3, -0.08 * i) * joy), (X, 4 + 8 * air)))

    def death(self, t):
        self.base()
        h = keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = S2(t, 3) * keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        roll = keys(t, [(0, 0), (0.3, 0), (0.55, self.ROLL), (1, self.ROLL)])
        bounce = 0.12 * pulse(t, 0.56, 0.68)  # petit rebond (vers le haut seulement : la pose finale reste au sol)
        f = keys(t, [(0, 0), (0.45, 0), (0.55, 1), (1, 1)])
        c = keys(t, [(0, 0), (0.34, 0), (0.55, 1), (1, 1)])
        lift = self.ROLL_LIFT * math.sin(math.radians(min(roll, 90))) + 0.3 * min(1.0, roll / 90)
        self.mv("Spine1", y=0.12 * h, z=0.03 / self.u + lift + bounce - self.death_drop * f, rz=6 * w, ry=roll)
        for b in self.NECK:
            self.r(b, (X, -5 * h), (Z, -8 * c))
        self.r("Head", (X, -12 * h + 6 * c), (Z, -10 * c + 6 * w))
        self.r("Jaw", (X, 30 * h + 28 * c))
        self.fins_pose(lambda key: dict(up=18 * h - 14 * f, bend=12 * f))
        self.tail(lambda i: ((Z, 4 * w - 6 * c), (X, 3)))

    def sheet_cam(self, clip):
        return (-90 if clip in ("Walk", "Run") else -40), 0.35, 1.25, 0.0


class Flaquodon(AquaLand):
    ID, NAME = "flaquodon", "Flaquodon"
    COLORS = {"main": "#4FC3F7", "belly": "#E1F5FE", "accent": "#0288D1", "glow": "#B2FFFF", "back": "#8BC34A"}
    HEIGHT = 3.0 * 0.8
    SKIN_ROOT = "corps"
    FIN_NS, FIN_NC = 8, 3
    NODES = [
        ("corps", (0, 0.10, 0.36), 0.32, None),
        ("poitrine", (0, -0.42, 0.42), 0.36, "corps"),
        ("cou", (0, -0.95, 0.62), 0.44, "poitrine"),
        ("tete", (0, -1.45, 1.02), 0.86, "cou"),
        ("museau", (0, -2.02, 0.86), 0.62, "tete"),
        ("queue1", (0, 0.95, 0.36), 0.24, "corps"),
        ("queue2", (0, 1.30, 0.33), 0.15, "queue1"),
        ("queue3", (0, 1.56, 0.32), 0.10, "queue2"),
    ]
    SPINE_PATH = ["corps", "poitrine", "cou"]
    HEAD_PATH = ["cou", "museau"]
    TAIL_PATH = ["corps", "queue1", "queue2", "queue3"]
    MOUTH = dict(P=(0, -1.9, 0.72), N=(0, 0.0, 1), y0=-1.3, gap=0.1, zmin=0.25, smile=0.16, smile_y=-2.0,
                 reach=0.42, shell=0.06)
    JAW_BONE = ((0, -1.3, 0.66), (0, -2.62, 0.62))
    FIN_F = ([(0.85, -0.55, 0.30), (1.20, -0.82, 0.17), (1.50, -0.78, 0.07)],
             [(0.95, -0.12, 0.28), (1.36, -0.30, 0.15), (1.58, -0.56, 0.07)])
    FIN_B = ([(0.85, 0.30, 0.28), (1.17, 0.48, 0.16), (1.40, 0.66, 0.07)],
             [(0.75, 0.68, 0.28), (1.04, 0.95, 0.15), (1.28, 0.86, 0.07)])
    FIN_THICK = 0.15
    LOC_BONES = ("Spine1", "Cheek.L", "Cheek.R")
    CHEEK = (0.62, -1.42, 0.86)
    EYE = ((0.42, -2.0, 1.38), 0.34)

    def fin_slot(self, u, v):
        return ACCENT if u > 0.84 else MAIN

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, ["queue3", "queue2", "queue1", "corps", "poitrine", "cou", "tete", "museau"],
                         self.C[BELLY], cos_min=0.55)
        spots = [((0.46, -1.2, 1.66), 0.15), ((0.70, -1.05, 1.32), 0.11), ((0.24, -0.98, 1.72), 0.09)]
        self.paint(me, lambda c, n: ACCENT if any((V((abs(c.x), c.y, c.z)) - V(p)).length < r for p, r in spots)
                   or (c.y > 0.85 and n.z > 0.2 and (c.y - 0.85) % 0.3 < 0.1) else None)  # taches et rayures foncées
        self.clean_islands(me, BELLY, MAIN)
    def extras(self, body, parts):
        g_head, g_jaw, g_body = self.grp("rigid", "Head"), self.grp("rigid", "Jaw"), self.grp("rigid", "Spine1")
        self.fins(parts)
        # Tronc plat et large (ellipsoïde rigide sur Spine1) : le Skin à rayons elliptiques se vrille aux jonctions
        tr = self.part("Tronc", "sphere", MAIN, g_body, loc=(0, 0.08, 0.40), scale=(1.06, 0.98, 0.38), u=10, v=6)
        attr = tr.data.color_attributes[dd.COLOR_ATTR]
        for poly in tr.data.polygons:
            if poly.center.z < 0.30:
                for li in poly.loop_indices:
                    attr.data[li].color_srgb = self.C[BELLY]
        parts.append(tr)
        # Carapace = disque de flaque (12 côtés, bord arrondi), plus large que longue
        zc, SX, SY = 0.70, 1.12, 0.88
        sh = self.part("Carapace", "cone", BELLY, g_body, segments=12, r1=1.0, r2=0.90, depth=0.2)
        self.xf(sh, Matrix.Translation((0, 0.18, zc)) @ Matrix.Diagonal((SX, SY, 1, 1)))
        parts.append(sh)
        Mt = Matrix.Translation((0, 0.18, zc + 0.101))
        for k, r in enumerate((0.22, 0.48, 0.74)):
            parts.append(self.ring("Ricochet", ACCENT, g_body, r, r + 0.05 - 0.01 * k, 16, Mt, SX, SY))
        # Nénuphar fendu posé de travers + petit bouton rose
        Ml = Matrix.Translation((0.42, 0.46, zc + 0.12)) @ Matrix.Rotation(math.radians(8), 4, "X") @ \
            Matrix.Rotation(math.radians(-30), 4, "Z")
        pad = [(0, 0)] + [(0.2 * math.cos(a), 0.2 * math.sin(a)) for a in
                          (math.radians(20 + 320 * i / 12) for i in range(13))]
        parts.append(self.flat("Nenuphar", BACK, g_body, pad, Ml, 0.03))
        parts.append(self.part("Bouton", "cone", TONGUE, g_body, segments=5, r1=0.06, r2=0.0, depth=0.12,
                               loc=Ml @ V((-0.06, -0.04, 0.07))))
        # Gros yeux expressifs (iris vert vif = couleur du nénuphar) + paupière boudeuse (coin intérieur plus bas)
        tgt, es = self.EYE
        self.eyes_styled(body, parts, g_head, tgt, es, (-0.35, -1.9, 0.1), BACK)
        # Petites pointes triangulaires derrière la tête et sur la queue
        for k, (y, L) in enumerate(((-1.12, 0.24), (-0.86, 0.19), (-0.66, 0.14))):
            b = dd.snap(body, (0, y, 2.0), -0.04)
            parts.append(self.cone_ab("Pointe", ACCENT, g_head, b, b + V((0, 0.08, L)), 0.1, 0.0, seg=4,
                                      scale_x=0.45))
        for i, q in enumerate(("queue1", "queue2")):
            b = dd.snap(body, self.pos[q] + V((0, 0.1, 0.4)), -0.03)
            gt = self.grp("rigid", "Tail%d" % (4 + i))
            parts.append(self.cone_ab("PointeQueue", ACCENT, gt, b, b + V((0, 0.06, 0.15 - 0.04 * i)), 0.07, 0.0,
                                      seg=4, scale_x=0.45))
        # Goutte du front (larme 0,2 x 0,3, émissive)
        top = dd.snap(body, (0, -1.62, 2.0), -0.04)
        parts.append(self.part("Goutte", "sphere", GLOW, g_head, loc=top + V((0, 0, 0.09)), scale=(0.1, 0.1, 0.1),
                               u=8, v=6))
        parts.append(self.cone_ab("GoutteBout", GLOW, g_head, top + V((0, 0, 0.12)), top + V((0, 0.02, 0.32)),
                                  0.088, 0.0, seg=8))
        # Narines, langue
        parts.append(self.part("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.15, -2.58, 1.02), -0.01),
                               scale=(0.035, 0.04, 0.03), mirror_x=True, u=5, v=3))
        zt = self.mouth_z(-1.9) - 0.1
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.58, zt), scale=(0.2, 0.28, 0.05),
                               u=8, v=5))
        # Grand sourire : dents triangulaires bien lisibles (haut sur la tête, bas sur la mâchoire)
        parts += self.teeth_arc(body, g_head, (8, 28, 48, 68), -1, 0.17, 0.07, inset=0.05)
        parts += self.teeth_arc(body, g_jaw, (18, 38, 58), 1, 0.13, 0.06, inset=0.05)
        # Griffes crème au bout des 4 nageoires (pattes « d'ours »)
        self.claws(parts)
        # Joues : 2 sphères séparées (os Cheek.S), à demi rentrées dans la tête
        g_ck = self.grp("rigid", "Cheek.S")
        parts.append(self.part("Joue", "sphere", MAIN, g_ck, loc=self.CHEEK, scale=(0.2, 0.22, 0.18), mirror_x=True,
                               u=8, v=5))
        # Queue en spatule (palette horizontale)
        g_tail = self.grp("rigid", "Tail%d" % self.NT)
        Mq = Matrix.Translation(self.pos["queue3"] + V((0, -0.08, 0))) @ Matrix.Rotation(math.radians(180), 4, "Z")
        parts.append(self.flat("Spatule", MAIN, g_tail, [(0, 0), (0.18, -0.1), (0.3, -0.34), (0.22, -0.56),
                                                          (0, -0.62), (-0.22, -0.56), (-0.3, -0.34), (-0.18, -0.1)],
                               Mq, 0.06))

    def extra_bones(self):
        out = []
        for side, sx in SIDES:
            c = V((self.CHEEK[0] * sx, self.CHEEK[1], self.CHEEK[2]))
            out.append(("Cheek." + side, c, c + V((0.2 * sx, 0, 0)), "Head", False, True))
        return out

    def cheeks(self, k):
        for side, sx in SIDES:
            self.mv("Cheek." + side, x=0.13 * k * sx, z=0.02 * k)

    # Idle : « prêt à bondir » (avant redressé, nageoires avant levées qui piétinent), puis susceptible :
    # gonfle les joues, se détourne vexé (nez en l'air), jette un œil, revient en garde
    def idle(self, t):
        self.base()
        br = S2(t, 4)
        ready = keys(t, [(0, 1), (0.2, 1), (0.28, 0), (0.88, 0), (0.96, 1), (1, 1)])
        puff = keys(t, [(0, 0), (0.2, 0), (0.27, 1), (0.8, 1), (0.88, 0), (1, 0)])
        turn = keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.6, 1), (0.64, 0.75), (0.68, 1), (0.78, 1), (0.9, 0), (1, 0)])
        peek = keys(t, [(0, 0), (0.58, 0), (0.62, 1), (0.68, 1), (0.72, 0), (1, 0)])
        step = pulse(t, 0.3, 0.42) + pulse(t, 0.78, 0.9)
        paw = S2(t, 10)
        self.mv("Spine1", z=0.012 + 0.01 * br + 0.03 * step + 0.07 * ready, rz=55 * turn, rx=-5 * ready)
        self.r("Head", (X, -2 * br - 16 * turn * (1 - peek) + 4 * ready), (Z, 20 * turn - 55 * peek), (Y, -8 * turn))
        self.r("Jaw", (X, (3 + 3 * max(0.0, br)) * (1 - puff)))
        self.cheeks(puff * (1 + 0.15 * S2(t, 8)))
        for key, side, off in (("F", "L", 0.0), ("B", "R", 0.0), ("F", "R", 0.5), ("B", "L", 0.5)):
            self.flipper(key, side, (t * 6 + off) % 1.0, 22 * step, 8 * step)
            if key == "F":  # nageoires avant levées « en garde », piétinement alterné
                sx = 1 if side == "L" else -1
                self.fin_pose("F", side, up=ready * (30 + 10 * paw * sx), sweep=-14 * ready, twist=-10 * ready,
                              bend=12 * ready)
        self.tail(lambda i: ((Z, (6 + 20 * turn) * S2(t, 2, -0.1 * i)), (X, 4 + 4 * ready)))

    def walk(self, t):
        self.base()
        bob = abs(math.sin(2 * math.pi * 2 * t))
        self.mv("Spine1", z=0.02 + 0.035 * bob, rz=5 * S2(t, 1))
        self.r("Head", (Z, -6 * S2(t, 1)), (X, 2 * S2(t, 2, 0.1)))
        self.r("Jaw", (X, 3))
        self.crawl(t, 1, 24, 26)
        self.tail(lambda i: ((Z, -12 * S2(t, 1, -0.1 * (i + 1))), (X, 5)))

    # Course : galop à plat ventre (les 2 avant ensemble, puis les 2 arrière), le corps rebondit
    def run(self, t):
        self.base()
        ph = t % 1.0
        bounce = max(0.0, math.sin(2 * math.pi * ph))
        self.mv("Spine1", z=0.08 + 0.14 * bounce, y=-0.04 * bounce, rx=-4 * math.sin(2 * math.pi * ph + 0.6))
        self.r("Head", (X, 6 * math.sin(2 * math.pi * ph + 1.0)))
        self.r("Jaw", (X, 12))
        for side, _sx in SIDES:
            self.flipper("F", side, ph, 34, 34)
            self.flipper("B", side, (ph + 0.35) % 1.0, 30, 30)
        self.tail(lambda i: ((X, 6 + 6 * math.sin(2 * math.pi * ph - 0.5 * i)),))

    # Attaque : se ramasse, tête rentrée, puis détend le cou et claque du bec
    def attack(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.58, 1), (0.86, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.2, 0.5), (0.33, 1), (0.42, 0), (0.48, 0.35), (0.56, 0), (1, 0)])
        self.mv("Spine1", y=0.18 * a - 0.32 * s, z=0.02 + 0.12 * a + 0.06 * s, rx=-10 * a + 4 * s)
        self.r("Spine3", (X, 6 * a - 6 * s))
        self.r("Spine4", (X, 8 * a - 8 * s))
        self.r("Head", (X, -14 * a + 10 * s))
        self.r("Jaw", (X, 40 * j))
        self.cheeks(0.6 * a)
        for side, _sx in SIDES:
            self.fin_pose("F", side, up=26 * a, sweep=-18 * a + 22 * s)
            self.fin_pose("B", side, up=6 * a, sweep=10 * s)
        self.tail(lambda i: ((X, (14 if i == 0 else 3) * a + 3), (Z, 14 * s * S2(t, 3, -0.1 * i))))

    # Rugissement : se cabre sur les nageoires arrière, bec grand ouvert, joues gonflées, nageoires avant en l'air
    def roar(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.16, 1), (0.26, 0), (1, 0)])
        r = keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * S2(t, 7)
        self.mv("Spine1", z=0.02 + 0.24 * r, y=0.1 * r, rx=2 * a - 14 * r)
        self.r("Spine3", (X, -6 * r))
        self.r("Head", (X, 8 * a - 18 * r + 3 * sh), (Z, 6 * sh))
        self.r("Jaw", (X, 4 * a + 52 * r))
        self.cheeks(0.5 * r)
        for side, _sx in SIDES:
            self.fin_pose("F", side, up=4 * a + 30 * r + 6 * sh, sweep=10 * a - 34 * r, bend=10 * r)
            self.fin_pose("B", side, up=-14 * r, sweep=-10 * r)
        self.tail(lambda i: ((X, 18 * r if i == 0 else 4 * r), (Z, 6 * S2(t, 4, -0.1 * i) * r)))

    # Célébration : 2 petits sauts, pirouette complète, nageoires qui battent, joues gonflées de fierté
    def celebrate(self, t):
        self.base()
        joy = keys(t, [(0, 0), (0.08, 1), (0.86, 1), (1, 0)])
        spin = keys(t, [(0, 0), (0.14, 0), (0.62, 360), (1, 360)])
        air = pulse(t, 0.12, 0.40) + pulse(t, 0.48, 0.76)
        self.mv("Spine1", z=0.01 + 0.55 * air, rz=spin, rx=-6 * air)
        self.r("Head", (X, -10 * joy), (Y, 10 * S2(t, 3) * joy))
        self.r("Jaw", (X, 28 * joy))
        self.cheeks(0.7 * joy)
        for key in ("F", "B"):
            for side, _sx in SIDES:
                lift = (40 if key == "F" else 14) * joy  # nageoires avant levées bien haut (« bras levés »)
                self.fin_pose(key, side, up=lift + (12 + 16 * S2(t, 5)) * air, sweep=-8 * air - (16 if key == "F" else 0) * joy)
        self.tail(lambda i: ((Z, 16 * S2(t, 3, -0.08 * i) * joy), (X, 4 + 8 * air)))

    # Mort : coup reçu, vacille, se retourne sur le dos (carapace au sol), nageoires qui gigotent puis s'arrêtent
    def death(self, t):
        self.base()
        h = keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = S2(t, 3) * keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        roll = keys(t, [(0, 0), (0.28, 0), (0.55, 180), (1, 180)])
        f = keys(t, [(0, 0), (0.45, 0), (0.55, 1), (1, 1)])
        c = keys(t, [(0, 0), (0.34, 0), (0.5, 1), (1, 1)])
        # le bord de la carapace ne traverse pas le sol pendant le roulé ; la descente (réajustée) pose le dos au sol
        lift = 1.6 * math.sin(math.radians(roll)) + 0.3 * roll / 180
        wig = keys(t, [(0, 0), (0.6, 0), (0.66, 1), (0.84, 1), (0.95, 0), (1, 0)]) * S2(t, 9)
        self.mv("Spine1", y=0.15 * h, z=0.02 + lift - self.death_drop * f, rx=-8 * h, rz=8 * w, ry=roll)
        self.r("Spine3", (X, 10 * c))
        self.r("Spine4", (X, 12 * c))
        self.r("Head", (X, -16 * h + 50 * c), (Z, 10 * w + 10 * c))
        self.r("Jaw", (X, 30 * h + 26 * c))
        self.cheeks(-0.3 * f)
        for key in ("F", "B"):
            for side, _sx in SIDES:
                self.fin_pose(key, side, up=20 * h - 18 * f + 12 * wig, bend=10 * f)
        self.tail(lambda i: ((Z, 5 * w), (X, 4)))

if __name__ == "__main__":
    Flaquodon().main()
