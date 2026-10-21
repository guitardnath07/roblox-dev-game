# DINO DICE — Nébulodon (mythique, aquatique) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 1 (style n°1 + n°2 du brief : grosse tête au bout du long cou, yeux rêveurs mi-clos, sourire à dents,
#   rendu en plaques/facettes, mesh final en flat)
# Référence réelle : Elasmosaurus platyurus (plésiosaure au cou très long, raccourci ici à ≈ 1,2 x le corps, petite
# tête grossie, corps en tonneau aplati, 4 palettes en aile). Couche thématique (docs/dinos-concept.md) : les 4
# palettes deviennent des voiles de gaz (membranes fines à bord frangé lumineux), 12 étoiles à 4 branches
# incrustées le long du cou, queue = comète (cône allongé 1,4 x 1,6, dégradé blanc -> violet), 1 étoile tenue
# dans la gueule (sur la mâchoire). Personnalité : rêveur, FLOTTE en l'air (HOVER > 0, seul aquatique qui ne
# touche pas le socle), croque une étoile, regard perdu.
# Taille : HEIGHT = 3,0 studs (base aquatique, cf. build_flaquodon.py) x 1,6.
#   python3 <scratchpad>/bb.py blender/scripts/dinos/build_nebulodon.py [-- model]

import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_flaquodon import AquaLand  # noqa: E402
from flyer_swimmer_helpers import V, Matrix, SIDES, S2, keys, X, Y, Z, pulse, plane_yz, frame_from, circle, star, \
    leaf, mirror_inplace, MAIN, BELLY, ACCENT, GLOW, BACK, TONGUE, DARK  # noqa: E402
import dd_common as dd  # noqa: E402


class Nebulodon(AquaLand):
    ID, NAME = "nebulodon", "Nebulodon"
    COLORS = {"main": "#311B92", "belly": "#E040FB", "accent": "#FFFFFF", "glow": "#B388FF", "back": "#1A0E5C"}
    HEIGHT = 3.0 * 1.6
    HOVER = 0.5  # flotte au-dessus du socle (fiche : « flotte en l'air »)
    SKIN_ROOT = "corps"
    SMOOTH = 2
    NODES = [
        ("corps", (0, 0.30, 0.62), 0.64, None),
        ("poitrine", (0, -0.25, 0.70), 0.56, "corps"),
        ("cou1", (0, -0.68, 0.98), 0.34, "poitrine"),
        ("cou2", (0, -0.95, 1.40), 0.28, "cou1"),
        ("cou3", (0, -1.10, 1.84), 0.26, "cou2"),
        ("cou4", (0, -1.30, 2.20), 0.28, "cou3"),
        ("tete", (0, -1.68, 2.48), 0.70, "cou4"),
        ("museau", (0, -2.16, 2.36), 0.32, "tete"),
        ("queue1", (0, 0.92, 0.62), 0.38, "corps"),
        ("queue2", (0, 1.30, 0.66), 0.24, "queue1"),
        ("queue3", (0, 1.58, 0.72), 0.13, "queue2"),
    ]
    SPINE_PATH = ["corps", "poitrine", "cou1", "cou2", "cou3", "cou4"]
    NS = 6
    NECK = ("Spine3", "Spine4", "Spine5", "Spine6")
    HEAD_PATH = ["cou4", "museau"]
    TAIL_PATH = ["corps", "queue1", "queue2", "queue3"]
    MOUTH = dict(P=(0, -2.0, 2.30), N=(0, 0.0, 1), y0=-1.78, gap=0.06, zmin=2.0, smile=0.1, smile_y=-2.1,
                 reach=0.3, shell=0.045)
    JAW_BONE = ((0, -1.72, 2.24), (0, -2.42, 2.24))
    FIN_F = ([(0.45, -0.35, 0.58), (0.95, -0.55, 0.44), (1.42, -0.48, 0.30)],
             [(0.52, 0.05, 0.52), (1.00, 0.00, 0.38), (1.40, -0.20, 0.28)])
    FIN_B = ([(0.45, 0.60, 0.56), (0.90, 0.80, 0.44), (1.25, 1.00, 0.32)],
             [(0.40, 0.95, 0.56), (0.75, 1.15, 0.44), (1.05, 1.25, 0.32)])
    FIN_NS, FIN_NC, FIN_THICK = 5, 2, 0.06
    EYE = ((0.34, -1.98, 2.72), 0.31)
    ROLL_LIFT = 0.8

    def fin_slot(self, u, v):
        return GLOW if (u > 0.8 or v > 0.7) else (MAIN if u < 0.2 else BELLY)

    def paint_body(self, me):
        dd.paint_ventral(me, self.NODES, ["queue3", "queue2", "queue1", "corps", "poitrine", "cou1", "cou2", "cou3",
                                          "cou4", "tete", "museau"], self.C[BELLY], cos_min=0.55)
        # taches de nébuleuse sombres sur le dos
        spots = [((0.3, 0.2, 1.15), 0.2), ((0.0, 0.6, 1.12), 0.16), ((0.42, -0.2, 1.1), 0.14), ((0.2, 1.0, 0.9), 0.1)]
        self.paint(me, lambda c, n: BACK if n.z > 0.2 and any((V((abs(c.x), c.y, c.z)) - V(p)).length < r
                                                             for p, r in spots) else None)
        self.clean_islands(me, BELLY, MAIN)

    def extras(self, body, parts):
        g_head, g_jaw = self.grp("rigid", "Head"), self.grp("rigid", "Jaw")
        self.fins(parts)
        # Yeux rêveurs : iris magenta, paupière basse et droite (regard perdu)
        tgt, es = self.EYE
        self.eyes_styled(body, parts, g_head, tgt, es, (-0.5, -1.4, 0.0), BELLY, lid_slot=MAIN,
                         lid_n=(0.0, -0.15, 1.0), lid_d=0.42)
        parts += self.teeth_arc(body, g_head, (0, 32, 62), -1, 0.11, 0.045, inset=0.03, yc=-1.9)
        parts += self.teeth_arc(body, g_jaw, (16, 46), 1, 0.09, 0.04, inset=0.03, yc=-1.9)
        zt = self.mouth_z(-2.0) - 0.06
        parts.append(self.part("Langue", "sphere", TONGUE, g_jaw, loc=(0, -1.98, zt), scale=(0.12, 0.2, 0.04),
                               u=6, v=4))
        parts.append(self.part("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.09, -2.4, 2.5), -0.01),
                               scale=(0.025, 0.03, 0.02), mirror_x=True, u=5, v=3))
        # Étoile croquée, tenue dans la gueule (sur la mâchoire)
        sm = self.mouth_z(-2.25)
        Ms = Matrix.Translation((0, -2.32, sm - 0.02)) @ plane_yz(math.radians(90))
        parts.append(self.flat("EtoileGueule", ACCENT, g_jaw, star(0.2, 0.08, 4), Ms, 0.06))
        # 12 étoiles à 4 branches incrustées le long du cou (alternées gauche / droite)
        neck = [self.pos[k] for k in ("cou1", "cou2", "cou3", "cou4")]
        bones = ["Spine3", "Spine4", "Spine5", "Spine6"]
        for k in range(12):
            u = (k + 0.5) / 12
            s3 = u * 3
            i0 = min(int(s3), 2)
            p = neck[i0].lerp(neck[i0 + 1], s3 - i0)
            sx = 1 if k % 2 == 0 else -1
            _ok, loc, nor, _ = body.closest_point_on_mesh(p + V((sx * 0.5, -0.15, 0.05 * (k % 3))))
            M = frame_from(loc + nor * 0.012, nor) @ Matrix.Rotation(0.4 * k, 4, "Z")
            r = 0.06 + 0.05 * ((k * 5) % 4) / 3
            parts.append(self.flat1("EtoileCou", ACCENT, self.grp("dist", bones), star(r, r * 0.38, 4), M))
        # Queue-comète : cône allongé, dégradé blanc -> lilas -> magenta (os Tail5)
        g_tail = self.grp("rigid", "Tail%d" % self.NT)
        q = self.pos["queue3"]
        d = V((0, 1, 0.18)).normalized()
        pts = [q + d * L for L in (-0.08, 0.35, 0.8, 1.4)]
        for (a, b), (r1, r2), slot in zip(zip(pts, pts[1:]), ((0.22, 0.2), (0.2, 0.13), (0.13, 0.0)),
                                          (ACCENT, GLOW, BELLY)):
            parts.append(self.cone_ab("Comete", slot, g_tail, a, b, r1, r2, seg=8))
        # Franges lumineuses au bord des voiles (gouttes de gaz)
        for key, (lead, trail) in (("F", self.FIN_F), ("B", self.FIN_B)):
            pts = [V(p) for p in trail]
            for k in range(4):
                u = 0.25 + 0.75 * k / 3
                seg = min(int(u * 2), 1)
                p = pts[seg].lerp(pts[seg + 1], u * 2 - seg)
                bone = "Fin%s%d.S" % (key, 1 if u < 0.5 else 2)
                M = Matrix.Translation(p + V((0, -0.03, 0)))  # goutte de gaz couchée dans le plan du voile
                parts.append(self.flat("Frange", GLOW, self.grp("rigid", bone), leaf(0.22, 0.08, 3), M, 0.03,
                                       mirror_x=True))
        # Petites pointes triangulaires le long du dos, points lumineux sur les flancs
        for i, (y, bone) in enumerate(((-0.1, "Spine1"), (0.3, "Spine1"), (0.7, "Tail1"))):
            b = dd.snap(body, (0, y, 1.8), -0.03)
            parts.append(self.cone_ab("Pointe", BELLY, self.grp("rigid", bone), b, b + V((0, 0.06, 0.2 - 0.03 * i)),
                                      0.09, 0.0, seg=4, scale_x=0.45))
        for k, (y, z) in enumerate(((-0.1, 0.8), (0.25, 0.95), (0.55, 0.75), (0.85, 0.85))):
            _ok, loc, nor, _ = body.closest_point_on_mesh(V((1.0, y, z)))
            M = frame_from(loc + nor * 0.012, nor)
            parts.append(mirror_inplace(self.flat1("Lueur", GLOW, self.grp("dist", ["Spine1", "Spine2", "Tail1"]),
                                                   star(0.07, 0.03, 4) if k % 2 else circle(0.05, 6), M)))

    # ---------------------------------------------------------------- animations (il flotte)
    def veils(self, t, k, amp, base=0.0):
        """Voiles de gaz qui ondulent (retard avant / arrière, pointe qui suit)."""
        for key, ph in (("F", 0.0), ("B", 0.3)):
            for side, _sx in SIDES:
                f = S2(t, k, ph)
                self.fin_pose(key, side, up=base + amp * f, sweep=amp * 0.3 * S2(t, k, ph + 0.25),
                              twist=-amp * 0.3 * S2(t, k, ph + 0.25), bend=amp * 0.6 * S2(t, k, ph - 0.15))

    def neck_wave(self, t, amp, k=1, lag=0.1, pitch=0.0):
        for i, b in enumerate(self.NECK):
            self.r(b, (Z, amp * S2(t, k, -lag * i)), (X, pitch / len(self.NECK) + 0.4 * amp * S2(t, k, 0.25 - lag * i)))

    # Idle rêveur : flotte, voiles qui ondulent, cou qui se balance, regard perdu, croque une étoile (vers 0,55)
    def idle(self, t):
        self.base()
        chomp = keys(t, [(0, 0), (0.48, 0), (0.54, 1), (0.58, 0), (0.62, 1), (0.66, 0), (1, 0)])
        reach = keys(t, [(0, 0), (0.42, 0), (0.5, 1), (0.7, 1), (0.78, 0), (1, 0)])
        self.mv("Spine1", z=0.06 * S2(t, 2), rx=2 * S2(t, 2, 0.2), rz=4 * S2(t, 1))
        self.neck_wave(t, 4, 1, pitch=-6 * reach)
        self.r("Head", (Y, 12 * S2(t, 1, 0.3) * (1 - reach)), (X, 6 * S2(t, 2, 0.1) - 10 * reach), (Z, 6 * S2(t, 1)))
        self.r("Jaw", (X, 4 + 28 * chomp))
        self.veils(t, 2, 14, base=4)
        self.tail(lambda i: ((Z, (6 + 3 * i) * S2(t, 1, -0.12 * i)), (X, 3 * S2(t, 2, -0.1 * i))))

    # Marche = nage dans l'air : voiles qui battent en alternance, cou en S qui ondule
    def walk(self, t):
        self.base()
        self.mv("Spine1", z=0.06 * S2(t, 2, 0.1), rx=-3 + 2 * S2(t, 2), rz=3 * S2(t, 1))
        self.neck_wave(t, 5, 1, 0.12, pitch=4)
        self.r("Head", (X, -4), (Z, -4 * S2(t, 1)))
        self.r("Jaw", (X, 4))
        self.veils(t, 1, 26, base=2)
        self.tail(lambda i: ((Z, (10 + 4 * i) * S2(t, 1, -0.1 * (i + 1))),))

    def run(self, t):
        self.base()
        self.mv("Spine1", z=0.1 + 0.08 * S2(t, 1), y=-0.05, rx=-8 + 3 * S2(t, 1))
        self.neck_wave(t, 4, 1, 0.12, pitch=14)
        self.r("Head", (X, -10))
        self.r("Jaw", (X, 8))
        self.veils(t, 1, 40, base=4)
        self.tail(lambda i: ((Z, (8 + 4 * i) * S2(t, 1, -0.12 * (i + 1))), (X, -4)))

    def celebrate(self, t):
        super().celebrate(t)
        joy = keys(t, [(0, 0), (0.08, 1), (0.86, 1), (1, 0)])
        self.veils(t, 4, 30 * joy, base=24 * joy)
        self.neck_wave(t, 8 * joy, 2, pitch=-12 * joy)


if __name__ == "__main__":
    Nebulodon().main()
