# DINO DICE — Peluchorex (théropode, taille 1,0) : modèle + rig + 7 animations + rendus.
# Version : 1 (style chibi + « plaques » : primitives basse résolution, rendu à facettes / shade flat)
# Référence : Tyrannosaurus rex en PELUCHE cousue main (tête énorme, gueule immense, bras minuscules, assis/trapu).
# Couche thématique : coutures en relief (crâne, flanc droit de la queue, bras gauche), 2 gros boutons cousus en
# croix aux articulations droites (épaule, hanche), fermeture éclair sur le ventre (bande claire + crans + tirette
# qui pendouille, os Zip), pointes dorsales en feutre vert, paupières lourdes (l'œil droit à demi fermé),
# 2 éclats d'yeux dorés au fond de la gueule, gueule entrouverte au repos (JAW_REST).
# Personnalité : peluche vivante maladroite, grognon-mignonne ; l'Idle se dégonfle lentement puis se regonfle
# d'un coup ; Death = se ramollit et s'affale comme une peluche vide.
#   python3 bb.py blender/scripts/dinos/build_peluchorex.py [-- model]
import math
import os
import sys

import bmesh
import bpy
from mathutils import Matrix, Quaternion, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, MOUTH, TONGUE  # noqa: E402,F401

ID, NAME = "peluchorex", "Peluchorex"
HEIGHT = 4.0  # 4,0 x 1,0
COLORS = {"main": "#F77AB0", "belly": "#E8C9D3", "accent": "#7CB342", "glow": "#FFD54F", "back": "#D9668F"}
BG = (0.20, 0.22, 0.28)
NT = 5
NODES = [
    ("hanche", (0, 0.20, 1.10), 0.80, None),
    ("ventre", (0, -0.25, 1.15), 0.92, "hanche"),
    ("epaules", (0, -0.45, 1.62), 0.74, "ventre"),
    ("cou", (0, -0.55, 2.02), 0.66, "epaules"),
    ("cou2", (0, -0.68, 2.36), 0.74, "cou"),
    ("crane", (0, -0.90, 2.98), 1.30, "cou2"),
    ("machoire", (0, -1.55, 2.70), 1.02, "crane"),
    ("museau", (0, -2.12, 2.78), 0.82, "machoire"),
    ("nez", (0, -2.52, 2.90), 0.64, "museau"),
    # grosse queue posée au sol, bout recourbé vers le haut
    ("queue1", (0, 0.80, 0.92), 0.60, "hanche"),
    ("queue2", (0, 1.30, 0.64), 0.46, "queue1"),
    ("queue3", (0, 1.75, 0.50), 0.34, "queue2"),
    ("queue4", (0, 2.12, 0.58), 0.25, "queue3"),
    ("queue5", (0, 2.34, 0.84), 0.17, "queue4"),
    ("queue6", (0, 2.40, 1.12), 0.10, "queue5"),
    # pattes très courtes, cuisses rondes de peluche
    ("bassin", (0.74, 0.05, 0.95), 0.48, None),  # pattes assez écartées : les 2 pattes restent des îlots séparés
    ("cuisse", (0.78, -0.12, 0.68), 0.56, "bassin"),
    ("genou", (0.78, -0.32, 0.42), 0.34, "cuisse"),
    ("cheville", (0.76, -0.18, 0.26), 0.26, "genou"),
    ("pied", (0.76, -0.30, 0.18), 0.26, "cheville"),
    ("orteils", (0.76, -0.60, 0.15), 0.22, "pied"),
    # bras moignons
    ("epaule", (0.70, -0.55, 1.55), 0.28, None),
    ("coude", (0.90, -0.80, 1.30), 0.24, "epaule"),
    ("main", (0.80, -1.05, 1.22), 0.22, "coude"),
]
MOUTH_Y0 = -1.15
MOUTH_P = (0, -1.40, 2.55)
MOUTH_N = (0, -0.06, 1)
MOUTH_GAP = 0.03
CHIN_Y = None
JAW_DEPTH = 0.9
PALATE = 0.28
FLOOR = 0.22
BELLY_COS = 0.45
BELLY_MAX_X = 0.62
BACK_PAINT = (0.5, 0.5, 1.2, -0.4)
SMILE_LIFT = (0.10, 0.5)
EXTRA_BONES = [("Zip", Vector((0, -1.0, 1.58)), Vector((0, -1.0, 1.23)), "Spine2")]  # recalé sur le curseur
EYE, EYE_SIZE = (0.9, -1.6, 3.3), 0.48
JAW_REST = 22.0  # gueule entrouverte au repos (grande gueule de peluche)


_build_mesh = H.build_mesh


def build_mesh_flat(B):
    out = _build_mesh(B)
    for p in out[3].data.polygons:  # rendu à facettes (comme en jeu)
        p.use_smooth = False
    return out


H.build_mesh = build_mesh_flat


def paint(B, me):
    # tête uniformément rose (le dos plus foncé s'arrête à la nuque)
    B.paint_where(me, lambda c, n: c.z > 2.2 or c.y > 2.0, MAIN)


def nearest_bone(B, p, names=None):
    segs = [(n, hd, tl) for n, hd, tl, *_r in H.bone_specs_skel(B) if names is None or n in names]
    return min(segs, key=lambda s: R.seg_dist(Vector(p), s[1], s[2]))[0]


def bar(B, gi, loc, nor, d, L, w, slot, thick=0.04, lift=0.015):
    """Barrette plate (point de couture, cran) posée sur la peau, longue de L dans la direction d."""
    d = (Vector(d) - nor * Vector(d).dot(nor)).normalized()
    return B.flat("Barrette", slot, gi, [(-w, -L / 2), (w, -L / 2), (w, L / 2), (-w, L / 2)],
                  H.frame_from(loc + nor * lift, nor, d), thick)


def seam(B, pts, gi_fn, every=1, stitch=0.2):
    """Couture : trait sombre le long du chemin + points de couture clairs en travers."""
    hits = [B.surf(p) for p in pts]
    for k, ((a, na), (b, nb)) in enumerate(zip(hits, hits[1:])):
        mid, nor = B.surf((a + b) / 2)
        gi = gi_fn(mid)
        bar(B, gi, mid, nor, b - a, (b - a).length + 0.03, 0.022, BACK, thick=0.02, lift=0.006)
        if k % every == 0:
            side = (b - a).cross(nor)
            bar(B, gi, mid, nor, side, stitch, 0.035, WHITE, thick=0.04, lift=0.02)


def button(B, gi, loc, nor, r=0.2):
    """Gros bouton plat (8 pans) + fil en croix."""
    M = H.frame_from(loc + nor * 0.03, nor)
    B.P("Bouton", "cone", MOUTH, gi, M=M, segments=8, r1=r, r2=r * 0.92, depth=0.08)
    for a in (45, -45):
        R3 = M @ Matrix.Translation((0, 0, 0.05)) @ Matrix.Rotation(math.radians(a), 4, "Z")
        B.flat("Fil", BELLY, gi, [(-0.035, -r * 0.62), (0.035, -r * 0.62), (0.035, r * 0.62), (-0.035, r * 0.62)],
               R3, 0.03)


def lid(B, gi, ec, lk, size, squash, close, tilt):
    """Paupière : coque un peu plus grande que l'œil, coupée par un plan incliné (on garde le dessus)."""
    ob = B.P("Paupiere", "sphere", MAIN, gi, loc=ec, scale=(size * 1.25, size * 1.25, size * squash * 1.25), u=10, v=6)
    up = Vector((0, 0, 1))
    up = (up - lk * up.dot(lk)).normalized()
    up = Matrix.Rotation(math.radians(tilt), 3, lk) @ up
    bm = bmesh.new()
    bm.from_mesh(ob.data)
    co = ec + up * size * (1 - 2 * close)
    bmesh.ops.bisect_plane(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:], plane_co=co, plane_no=up,
                           clear_inner=True)
    bmesh.ops.holes_fill(bm, edges=[e for e in bm.edges if e.is_boundary], sides=0)
    bmesh.ops.recalc_face_normals(bm, faces=bm.faces)
    bm.to_mesh(ob.data)
    bm.free()
    ob.data.attributes["dd_grp"].data.foreach_set("value", [gi] * len(ob.data.vertices))
    H.dd.fill_color(ob.data, B.C[MAIN])
    B.paint_where(ob.data, lambda c, n: n.dot(up) < -0.9, DARK)  # face de coupe = bord sombre de la paupière
    return ob


class lowres:
    """Plafonne la résolution des primitives créées par les helpers (style plaques : grosses facettes)."""
    def __init__(self, B, u=6, v=4, seg=8):
        self.B, self.cap = B, {"u": u, "v": v, "segments": seg}

    def __enter__(self):
        P = self.B.P

        def low(*a, **kw):
            for k, m in self.cap.items():
                if k in kw:
                    kw[k] = min(kw[k], m)
            return P(*a, **kw)
        self.B.P = low

    def __exit__(self, *exc):
        del self.B.P


def side_hit(B, y, z, sx=-1):
    """Point de la peau le plus à l'extérieur (côté sx) à la hauteur z et à l'avancée y."""
    hit, loc, nor, _i = B.body.ray_cast(Vector((5 * sx, y, z)), Vector((-sx, 0, 0)))
    assert hit, (y, z)
    return loc, nor


def accessories(B):
    gh = B.grp("rigid", "Head")
    with lowres(B, u=10, v=6, seg=10):
        ec, lk = B.eyes(EYE, EYE_SIZE, iris=ACCENT, look=(0.15, -1.0, 0.0), sink=0.5, squash=1.1)
    # les reflets du helper sont en haut de l'iris (sous la paupière) : on les remplace par un reflet plus bas
    for ob in [o for o in B.parts if o.name.startswith("Reflet")]:
        B.parts.remove(ob)
        bpy.data.objects.remove(ob, do_unlink=True)
    fr = H.frame_from(ec + lk * EYE_SIZE * 0.93, lk)
    H.mirror_inplace(B.P("Reflet", "sphere", WHITE, gh, M=fr @ Matrix.Translation((-EYE_SIZE * 0.2, -EYE_SIZE * 0.12, 0.05)),
                         scale=(EYE_SIZE * 0.14, EYE_SIZE * 0.14, 0.03), u=6, v=4))
    # paupières lourdes inclinées (air grognon) : la gauche couvre 40 %, la droite est à demi fermée
    for sx, close in ((1, 0.40), (-1, 0.55)):
        lid(B, gh, Vector((ec.x * sx, ec.y, ec.z)), Vector((lk.x * sx, lk.y, lk.z)), EYE_SIZE, 1.1, close, 16 * sx)
    B.mouth_parts(n_up=8, n_lo=7, size=0.2, inset=0.07, tongue=False, fangs=[(-2.25, 0.22, WHITE)])
    # 2 éclats d'yeux dorés au fond de la gueule (sur le plancher, os Jaw) : visibles gueule ouverte
    N = B.mi["N"]
    gj = B.grp("rigid", "Jaw")
    for sx in (1, -1):
        p = Vector((0.3 * sx, MOUTH_Y0 - 0.5, 0))
        p.z = MOUTH_P[2] + (N.y * (MOUTH_P[1] - p.y)) / N.z - 0.07
        n = (N * 0.6 + Vector((0, -1, 0))).normalized()
        shape = [(-0.19, -0.03), (-0.05, 0.06), (0.18, 0.06), (0.06, -0.05)]
        B.flat("EclatOeil", GLOW, gj, [(x * sx, y) for x, y in shape], H.frame_from(p, n, (0, 0, 1)), 0.03)
    H.mirror_inplace(B.P("Narine", "sphere", DARK, gh, loc=B.snap((0.2, -3.1, 3.1), -0.01),
                         scale=(0.07, 0.05, 0.05), u=5, v=3))
    # coutures : crâne (du museau vers la nuque, un peu de travers), queue, bras gauche
    skull = []
    for k in range(8):
        hit, loc, _n, _i = B.body.ray_cast(Vector((0.04 + 0.06 * k, -2.85 + 0.34 * k, 20)), Vector((0, 0, -1)))
        if hit:
            skull.append(loc)
    seam(B, skull, lambda p: gh)
    q = H.tail_points(B, NT)
    tail = []
    for k in range(5):
        y = 0.9 + 0.3 * k
        c = min(q, key=lambda v: abs(v.y - y))
        tail.append(Vector((-0.35, y, c.z + 0.3)))  # côté droit, visible de 3/4
    seam(B, tail, lambda p: B.grp("rigid", nearest_bone(B, p, ["Tail1", "Tail2", "Tail3", "Tail4"])))
    ga = B.grp("rigid", "UpperArm.L")
    e, c = B.pos["epaule"], B.pos["coude"]
    mid = e.lerp(c, 0.55)
    ax = (c - e).normalized()
    u = ax.cross(Vector((0, 0, 1))).normalized()
    v = ax.cross(u)
    seam(B, [mid + (u * math.cos(a) + v * math.sin(a)) * 0.5 for a in [math.radians(45 * k - 70) for k in range(5)]],
         lambda p: ga)
    # gros boutons cousus en croix aux articulations droites (épaule, hanche), visibles de 3/4
    loc, nor = side_hit(B, -0.62, 1.48)
    button(B, B.grp("rigid", "UpperArm.R"), loc, nor, 0.2)
    loc, nor = side_hit(B, -0.12, 0.72)
    button(B, B.grp("rigid", "UpperLeg.R"), loc, nor, 0.24)
    # fermeture éclair sur le ventre : bande claire + crans sombres alternés + curseur et tirette (os Zip)
    gs = B.grp("dist", ["Spine1", "Spine2", "Hips"])
    pts = []
    for k in range(5):
        hit, loc, nor, _i = B.body.ray_cast(Vector((0, -5, 1.58 - 0.24 * k)), Vector((0, 1, 0)))
        assert hit, k
        pts.append((loc, nor))
    for k, ((a, _na), (b, _nb)) in enumerate(zip(pts, pts[1:])):
        mid, nor = B.surf((a + b) / 2)
        bar(B, gs, mid, nor, b - a, (b - a).length + 0.04, 0.09, WHITE, thick=0.03, lift=0.008)
        for j in range(2):
            qq, nq = B.surf(a.lerp(b, 0.25 + 0.5 * j))
            sx = 1 if j else -1
            bar(B, gs, qq + Vector((0.035 * sx, 0, 0)), nq, Vector((1, 0, 0)), 0.1, 0.03, DARK, thick=0.03,
                lift=0.03)
    top, ntop = pts[0]
    B.cfg.EXTRA_BONES = [("Zip", top.copy(), top + Vector((0, 0, -0.35)), "Spine2")]  # pivot de la tirette
    gz = B.grp("rigid", "Zip")
    B.P("Curseur", "cube", DARK, gz, M=H.frame_from(top + ntop * 0.05, ntop) @ Matrix.Diagonal((0.08, 0.1, 0.05, 1)))
    tab = [(-0.06, 0.0), (0.06, 0.0), (0.08, -0.22), (0.0, -0.28), (-0.08, -0.22)]
    B.flat("Tirette", GLOW, gz, tab, H.frame_from(top + ntop * 0.09, ntop, (0, 0, 1)), 0.035)
    # pointes dorsales en feutre vert : plaques plates de l'arrière du crâne au début de la queue
    head_c, body_c = Vector(B.pos["crane"]), Vector((0, 0.1, 1.5))
    for k, (cen, ang, h) in enumerate(((head_c, 42, 0.5), (head_c, 72, 0.56), (head_c, 102, 0.5),
                                        (body_c, 38, 0.52), (body_c, 62, 0.48), (body_c, 86, 0.4))):
        d = Vector((0, math.sin(math.radians(ang)), math.cos(math.radians(ang))))
        hit, loc, nor, _i = B.body.ray_cast(cen + d * 8, -d)
        assert hit, ang
        w = h * 0.55
        out = (nor + Vector((0, 0.3, 0))).normalized()
        shape = [(-w, -0.1), (w, -0.1), (w * 0.8, h * 0.5), (w * 0.15, h), (-w * 0.15, h), (-w * 0.8, h * 0.5)]
        gi = B.grp("rigid", nearest_bone(B, loc, ["Head", "Neck2", "Neck1", "Spine2", "Spine1", "Hips", "Tail1",
                                                  "Tail2"]))
        B.flat("Pointe%d" % k, ACCENT, gi, shape, H.frame_from(loc - nor * 0.05, (1, 0, 0), out), 0.13)
    with lowres(B, u=6, v=4, seg=5):
        B.hands(n=3, length=0.22, r=0.12, claw=DARK, spread=34, claw_len=0.24, down=0.3)
        B.feet(n=3, length=0.34, r=0.15, claw=DARK, spread=32, claw_len=0.2, back=0.18)


class Anims(H.Anims):
    HEAVY = 0.6
    ARM_SCALE = 0.8
    JAW_OPEN = 40.0

    def add_jaw(self, deg):
        """Ajoute `deg` d'ouverture à la pose de mâchoire déjà posée (gueule entrouverte au repos)."""
        pb = self.P["Jaw"]
        ax = (H.rig.rest3inv(pb) @ Vector(R.X)).normalized()
        pb.rotation_quaternion = pb.rotation_quaternion @ Quaternion(ax, math.radians(deg))

    def extra(self, clip, t):
        amp = {"Idle": 0, "Walk": 14, "Run": 22, "Attack": 18, "Roar": 16, "Celebrate": 26, "Death": 0}[clip]
        k = {"Walk": 2, "Run": 2}.get(clip, 3)
        self.r("Zip", (R.X, amp * R.S2(t, k, 0.2)), (R.Y, 0.6 * amp * R.S2(t, k * 0.5)))
        if clip in ("Walk", "Run", "Celebrate"):  # clips génériques : grande gueule de peluche ouverte
            self.add_jaw(JAW_REST)

    # Peluche maladroite : se dégonfle lentement (s'affaisse, tête qui tombe, bras ballants, petits frissons
    # « pfff »), puis se regonfle d'un coup avec un rebond (gueule qui s'ouvre en grand)
    def idle(self, t):
        P = self.base()
        d = R.keys(t, [(0, 0), (0.08, 0), (0.66, 1), (0.71, 1), (0.75, -0.45), (0.81, 0.16), (0.87, -0.06),
                       (0.93, 0), (1, 0)])
        dd_ = max(0.0, d)
        pf = 0.03 * R.S2(t, 30) * (dd_ * (1 - dd_)) * 4  # frissons de fuite d'air
        self.hips(z=-0.17 * d + pf, rx=3 * d, ry=5 * d, rz=3 * d)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, 3 * d))
        H.rig.rot(P["Neck1"], (R.X, 4 * d))
        H.rig.rot(P["Neck2"], (R.X, 3 * d), (R.Y, 5 * d))
        H.rig.rot(P["Head"], (R.X, 7 * d + 20 * pf), (R.Y, 8 * d))
        H.rig.rot(P["Jaw"], (R.X, JAW_REST * (1 - 0.85 * dd_) + 30 * max(0.0, -d)))
        self.r("Zip", (R.X, 25 * R.S2(t, 4) * (1 - dd_) * max(0.0, 1 - abs(t - 0.8) * 4)), (R.Y, 8 * d))
        self.tail(lambda i: ((R.X, -1 * d), (R.Z, 3 * R.S2(t, 1, -0.08 * i))))
        for side, sx in H.SIDES:
            H.rig.rot(P["UpperArm." + side], (R.X, -30 + 40 * d), (R.Y, -sx * (8 - 30 * min(0.0, d))))
            H.rig.rot(P["LowerArm." + side], (R.X, -25 + 28 * d))

    # Bouchée maladroite : se cabre un peu, gueule grande ouverte, CLAC en avant, puis vacille
    def attack(self, t):
        P = self.base()
        a = R.keys(t, [(0, 0), (0.28, 1), (0.36, 0), (1, 0)])
        s = R.keys(t, [(0, 0), (0.28, 0), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
        op = R.keys(t, [(0, 0), (0.22, 0.4), (0.34, 1), (0.40, 0), (1, 0)])
        snap = R.keys(t, [(0, 0), (0.36, 0), (0.40, 1), (0.6, 1), (0.8, 0), (1, 0)])
        wob = R.S2(t, 4) * R.keys(t, [(0, 0), (0.55, 0), (0.65, 1), (0.95, 0), (1, 0)])
        self.hips(y=0.15 * a - 0.3 * s, z=-0.06 * a + 0.03 * s, rx=-6 * a + 8 * s, rz=6 * wob, ry=4 * wob)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, 3 * a - 2 * s))
        H.rig.rot(P["Neck1"], (R.X, -8 * a + 6 * s))
        H.rig.rot(P["Neck2"], (R.X, -4 * a + 3 * s))
        H.rig.rot(P["Head"], (R.X, -10 * a + 5 * s), (R.Y, 6 * wob))
        H.rig.rot(P["Jaw"], (R.X, JAW_REST * (1 - snap) + 34 * op))
        self.tail(lambda i: ((R.X, 5 * a - 4 * s), (R.Z, 6 * wob)))
        for side, sx in H.SIDES:
            H.rig.rot(P["UpperArm." + side], (R.X, -40 * a - 30 * s), (R.Y, -sx * 20 * a))
            H.rig.rot(P["LowerArm." + side], (R.X, -30 * a + 30 * s))
        self.extra("Attack", t)

    # Rugissement (révélation) : petite prise d'élan (la grosse tête ne pique pas du nez), puis gueule béante
    def roar(self, t):
        P = self.base()
        a = R.keys(t, [(0, 0), (0.16, 1), (0.26, 0), (1, 0)])
        r = R.keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * R.S2(t, 7)
        self.hips(z=-0.06 * a + 0.06 * r, rx=4 * a - 8 * r)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, 2 * a - 4 * r))
        H.rig.rot(P["Neck1"], (R.X, 6 * a - 10 * r))
        H.rig.rot(P["Neck2"], (R.X, 4 * a - 8 * r))
        H.rig.rot(P["Head"], (R.X, 6 * a - 12 * r + 4 * sh), (R.Z, 7 * sh))
        H.rig.rot(P["Jaw"], (R.X, JAW_REST * (1 - a) + self.JAW_OPEN * r))
        self.tail(lambda i: ((R.X, -4 * a + 6 * r), (R.Z, 3 * R.S2(t, 7, -0.1 * i) * r)))
        for side, sx in H.SIDES:
            H.rig.rot(P["UpperArm." + side], (R.X, -20 * a - 55 * r), (R.Y, -sx * 35 * r))
            H.rig.rot(P["LowerArm." + side], (R.X, -30 * r))
        self.extra("Roar", t)

    # Se ramollit et s'affale comme une peluche vide : sursaut, les genoux lâchent (assis, jambes en avant),
    # puis tout le haut bascule mollement sur le côté, tête qui ballotte, bras et tirette qui pendouillent
    def death(self, t):
        P = self.base()
        h = R.keys(t, [(0, 0), (0.08, 1), (0.22, 0)])
        s = R.keys(t, [(0, 0), (0.12, 0), (0.4, 1), (1, 1)])
        f = R.keys(t, [(0, 0), (0.35, 0), (0.62, 1), (0.7, 0.88), (0.78, 1), (1, 1)])
        self.hips(y=0.2 * s, z=-self.drop * (0.7 * s + 0.3 * f), rx=-8 * h - 6 * f, ry=45 * f)
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, 5 * s), (R.Y, 8 * f))
        H.rig.rot(P["Neck1"], (R.X, -10 * h + 8 * s), (R.Y, 8 * f))
        H.rig.rot(P["Neck2"], (R.X, 6 * s), (R.Y, 10 * f))
        H.rig.rot(P["Head"], (R.X, -12 * h + 8 * s), (R.Y, 14 * f), (R.Z, -10 * f))
        H.rig.rot(P["Jaw"], (R.X, JAW_REST * 0.5 + 30 * h + 10 * f))
        self.r("Zip", (R.X, -15 * s), (R.Y, -25 * f))
        self.tail(lambda i: ((R.X, -6 * s), (R.Z, -8 * f)))
        for side, sx in H.SIDES:
            H.rig.rot(P["UpperLeg." + side], (R.X, -62 * s), (R.Y, sx * 18 * s))
            H.rig.rot(P["LowerLeg." + side], (R.X, -50 * s))
            H.rig.rot(P["Foot." + side], (R.X, 20 * s))
            H.rig.rot(P["UpperArm." + side], (R.X, -30 * h + 45 * s), (R.Y, -25 * f))
            H.rig.rot(P["LowerArm." + side], (R.X, 20 * s))


if __name__ == "__main__":
    H.run(sys.modules[__name__])
