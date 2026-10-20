# DINO DICE â€” outils partagÃ©s des dinos UNIQUES ptÃ©rosaures et aquatiques (build_<id>.py du modeleur C).
# Version : 1
# MÃªme mÃ©thode que le pilote (build_chronoraptor.py) : Skin + piÃ¨ces rapportÃ©es, 1 mesh, 1 matÃ©riau, slots de
# couleur par face (1 main, 2 belly, 3 accent, 4 blanc, 5 pupille, 6 glow, 7 back, 8 bouche, 9 langue),
# vraie bouche (fente + coque intÃ©rieure), rig maison, actions Â« <id>_<Clip> Â» Ã  30 i/s, rendus de contrÃ´le.
# En plus : membranes en grille (ailes, nageoires, voiles) pondÃ©rÃ©es le long d'une chaÃ®ne d'os (attribut dd_u).
#
# Chaque dino : une sous-classe de Ptero ou Aqua (nÅ“uds du Skin, piÃ¨ces, couleurs, poses perso).
# Lancement (sans interface) : blender -b --factory-startup --python-exit-code 1 -P build_<id>.py [-- model]

import json
import math
import os
import sys

import bmesh
import bpy
from mathutils import Matrix, Vector

HERE = os.path.dirname(os.path.abspath(__file__))
SCRIPTS_DIR = os.path.dirname(HERE)
PROJECT_DIR = os.path.dirname(os.path.dirname(SCRIPTS_DIR))
for _p in (SCRIPTS_DIR, HERE):
    if _p not in sys.path:
        sys.path.insert(0, _p)
import dd_common as dd  # noqa: E402
import build_theropod_rig as rig  # noqa: E402
import dd_dino_rig as R  # noqa: E402

RENDERS = os.path.join(PROJECT_DIR, "docs", "renders", "dinos")
DINOS_DIR = os.path.join(PROJECT_DIR, "blender", "dinos")
MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, MOUTH, TONGUE = range(1, 10)
FIXED = {"white": "#FFFFFF", "pupil": "#1B1B22", "mouth": "#6A1B2A", "tongue": "#F06292"}
X, Y, Z = R.X, R.Y, R.Z
S2, keys = R.S2, R.keys
SIDES = (("L", 1.0), ("R", -1.0))  # +X = gauche du dino (il regarde vers -Y)
V = Vector


def clamp01(x):
    return max(0.0, min(1.0, x))


def sstep(x):
    x = clamp01(x)
    return x * x * (3 - 2 * x)


def pulse(t, a, b):
    """0 hors de [a, b], bosse sinus dedans."""
    return math.sin(math.pi * (t - a) / (b - a)) if a < t < b else 0.0


# ------------------------------------------------------------------ gÃ©omÃ©trie pure (comme le pilote)

def frame_from(origin, normal, up=(0, 0, 1)):
    """Matrice locale : Z = normale, Y = Â« haut Â» projetÃ©."""
    n = V(normal).normalized()
    u = V(up)
    u = (u - n * u.dot(n))
    if u.length < 1e-6:
        u = V((0, 1, 0)) - n * n.y
    u.normalize()
    x = u.cross(n)
    M = Matrix((x, u, n)).transposed().to_4x4()
    M.translation = V(origin)
    return M


def plane_yz(angle):
    """Plan local XY -> plan YZ (normale +X) ; +Y local Ã  `angle` rad depuis l'avant (-Y) vers le haut (+Z)."""
    d = V((0, -math.cos(angle), math.sin(angle)))
    x = V((1, 0, 0))
    return Matrix((d.cross(x), d, x)).transposed().to_4x4()


def look_mat(origin, direction, up=(0, 0, 1)):
    """Matrice locale : Y = direction, Z ~ up (pour poser une piÃ¨ce plate Â« le long Â» d'une direction)."""
    d = V(direction).normalized()
    u = V(up)
    u = u - d * u.dot(d)
    if u.length < 1e-6:
        u = V((1, 0, 0))
    u.normalize()
    x = d.cross(u)
    M = Matrix((x, d, u)).transposed().to_4x4()
    M.translation = V(origin)
    return M


def mirror_inplace(ob):
    bm = bmesh.new()
    bm.from_mesh(ob.data)
    dup = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
    dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
    dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
    bmesh.ops.scale(bm, vec=(-1, 1, 1), verts=dverts)
    bmesh.ops.reverse_faces(bm, faces=dfaces)
    bm.to_mesh(ob.data)
    bm.free()
    return ob


def split_sharp(ob, angle_deg):
    me = ob.data
    bm = bmesh.new()
    bm.from_mesh(me)
    lim = math.radians(angle_deg)
    sharp = [e for e in bm.edges if len(e.link_faces) == 2 and e.calc_face_angle(0.0) > lim]
    bmesh.ops.split_edges(bm, edges=sharp)
    bm.to_mesh(me)
    bm.free()
    me.shade_smooth()


def circle(r, n, rx=None):
    rx = r if rx is None else rx
    return [(rx * math.cos(2 * math.pi * i / n), r * math.sin(2 * math.pi * i / n)) for i in range(n)]


def rect(w, h):
    return [(-w / 2, -h / 2), (w / 2, -h / 2), (w / 2, h / 2), (-w / 2, h / 2)]


def star(r_out, r_in, n=4, rot=0.0):
    pts = []
    for i in range(2 * n):
        a = rot + math.pi * i / n + math.pi / 2
        r = r_out if i % 2 == 0 else r_in
        pts.append((r * math.cos(a), r * math.sin(a)))
    return pts


def leaf(L, w, n=5, tip_round=0.0):
    """Feuille / goutte le long de +Y (base Ã  0, pointe Ã  L), largeur max w au tiers."""
    right = []
    for i in range(1, n + 1):
        t = i / (n + 1)
        right.append((w * math.sin(math.pi * t ** 0.8) * (1 - tip_round * t), L * t))
    return [(0, 0)] + right + [(0, L)] + [(-x, y) for x, y in reversed(right)]


def chaikin(pts, it=2, closed=False):
    pts = [V(p) for p in pts]
    for _ in range(it):
        out = [pts[0]] if not closed else []
        rng = range(len(pts)) if closed else range(len(pts) - 1)
        for i in rng:
            a, b = pts[i], pts[(i + 1) % len(pts)]
            out += [a.lerp(b, 0.25), a.lerp(b, 0.75)]
        if not closed:
            out.append(pts[-1])
        pts = out
    return pts


def resample(pts, n):
    """n + 1 points Ã  abscisse curviligne rÃ©guliÃ¨re ; renvoie aussi les abscisses normalisÃ©es des points d'entrÃ©e."""
    pts = [V(p) for p in pts]
    acc = [0.0]
    for a, b in zip(pts, pts[1:]):
        acc.append(acc[-1] + (b - a).length)
    L = acc[-1]
    out = []
    for i in range(n + 1):
        d = L * i / n
        for k in range(len(pts) - 1):
            if d <= acc[k + 1] + 1e-9:
                seg = acc[k + 1] - acc[k]
                out.append(pts[k].lerp(pts[k + 1], (d - acc[k]) / seg if seg > 0 else 0.0))
                break
    return out, [a / L for a in acc]


def chain_resample(pts, n):
    """n segments Ã©gaux le long d'une polyligne -> liste de n + 1 points (tÃªtes/queues d'os)."""
    return resample(pts, n)[0]


# ------------------------------------------------------------------ dino gÃ©nÃ©rique

class Dino:
    ID = NAME = ""
    COLORS = {}  # main, belly, accent, glow, back
    HEIGHT = None  # hauteur (studs) OU
    LENGTH = None  # longueur (studs)
    NODES = []
    SKIN_ROOT = None
    SUBDIV, SMOOTH, BRANCH = 1, 1, 0.7
    DECIMATE = 1.0
    CAM_K = 2.2
    MOUTH = None  # dict(P, N, y0, gap, zmin, smile, smile_y, reach)
    BG = (0.16, 0.19, 0.27)
    SIGMA = 0.07
    TRI_BUDGET = 5000
    LOC_BONES = ("Hips",)
    CLIPS = [("Idle", 120, True), ("Walk", 30, True), ("Run", 16, True), ("Attack", 30, False),
             ("Roar", 44, False), ("Celebrate", 40, False), ("Death", 44, False)]
    DEATH_DROP = 0.3  # descente (squelette) en fin de mort, rÃ©ajustÃ©e pour toucher le sol sans le traverser
    CAM_H = 0.3

    def __init__(self):
        c = self.COLORS
        hexes = [c["main"], c["belly"], c["accent"], FIXED["white"], FIXED["pupil"], c["glow"],
                 c.get("back", c["main"]), FIXED["mouth"], FIXED["tongue"]]
        self.C = [None] + [dd.hex_rgba(h) for h in hexes]
        self.groups = [None]
        self.col = None
        self.pos = {k: V(p) for k, p, _r, _par in self.NODES}
        self.rad = {k: (r if isinstance(r, (int, float)) else max(r)) for k, _p, r, _par in self.NODES}
        self.death_drop = self.DEATH_DROP
        if self.MOUTH:
            m = self.MOUTH
            self.mP, self.mN = V(m["P"]), V(m["N"]).normalized()

    # ---------------------------------------------------------------- piÃ¨ces
    def grp(self, kind, bones, extra=None):
        self.groups.append((kind, bones, extra))
        return len(self.groups) - 1

    def tag(self, ob, gi):
        a = ob.data.attributes.get("dd_grp") or ob.data.attributes.new("dd_grp", "INT", "POINT")
        a.data.foreach_set("value", [gi] * len(ob.data.vertices))
        return ob

    def part(self, name, kind, slot, gi, **kw):
        return self.tag(dd.part(name, kind, self.col, self.C[slot], **kw), gi)

    @staticmethod
    def xf(ob, M):
        ob.data.transform(M)
        return ob

    def flat(self, name, slot, gi, outline, M, thick, mirror_x=False):
        pts = [M @ V((x, y, 0)) for x, y in outline]
        return self.tag(dd.membrane(name, self.col, self.C[slot], pts, thickness=thick, mirror_x=mirror_x), gi)

    def flat1(self, name, slot, gi, outline, M):
        """Polygone Ã  UNE face (vu de +Z local), en Ã©ventail : dÃ©calques (iris, Ã©toiles, runes)."""
        bm = bmesh.new()
        vs = [bm.verts.new(M @ V((x, y, 0))) for x, y in outline]
        f = bm.faces.new(vs)
        bmesh.ops.poke(bm, faces=[f])
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, self.C[slot])
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def cone_ab(self, name, slot, gi, a, b, r1, r2=0.0, seg=5, mirror_x=False, scale_x=1.0):
        """CÃ´ne de a (rayon r1) vers b (rayon r2) : griffes, dents, cornes, tiges."""
        a, b = V(a), V(b)
        d = b - a
        q = d.to_track_quat("Z", "Y")
        ob = self.part(name, "cone", slot, gi, segments=seg, r1=r1, r2=r2, depth=d.length, mirror_x=False)
        self.xf(ob, Matrix.Translation((a + b) / 2) @ q.to_matrix().to_4x4() @ Matrix.Diagonal((scale_x, 1, 1, 1)))
        return mirror_inplace(ob) if mirror_x else ob

    def sheet(self, name, gi, lead, trail, ns, nc, thick, slotfn, mirror_x=False, bulge=0.0, smooth_trail=2,
              taper=0.5, smooth_lead=0, up_hint=None):
        """Membrane en grille (aile, nageoire, voile) : stations i (0 = racine, ns = bout) de `lead` Ã  `trail`,
        nc rangÃ©es dans la corde ; Ã©paisseur `thick` (amincie vers le bord de fuite), fermÃ©e (2 faces + tranche).
        Attributs par sommet : dd_u (envergure 0..1) et dd_v (corde 0..1). slotfn(u, v) -> slot de la face."""
        L = resample(chaikin(lead, smooth_lead), ns)[0]
        T = resample(chaikin(trail, smooth_trail), ns)[0]
        bm = bmesh.new()
        lu = bm.verts.layers.float.new("dd_u")
        lv = bm.verts.layers.float.new("dd_v")
        top, bot = [], []
        prev_n = None
        NS = []
        for i in range(ns + 1):
            a, b = L[i], T[i]
            span = L[min(i + 1, ns)] - L[max(i - 1, 0)]
            chord = b - a
            n = span.cross(chord)
            if n.length < 1e-6:
                n = prev_n if prev_n is not None else V(up_hint or (0, 0, 1))
            n = n.normalized()
            if up_hint is not None and n.dot(V(up_hint)) < 0:
                n = -n
            if prev_n is not None and n.dot(prev_n) < 0:
                n = -n
            prev_n = n
            NS.append(n)
            rt, rb = [], []
            for j in range(nc + 1):
                v = j / nc
                p = a.lerp(b, v) + n * bulge * math.sin(math.pi * v) * math.sin(math.pi * min(1.0, i / max(ns, 1) * 1.0 + 0.15))
                h = thick * 0.5 * (1 - taper * v) * (1 - 0.5 * (i / ns) ** 3)
                for lst, sgn in ((rt, 1), (rb, -1)):
                    bv = bm.verts.new(p + n * h * sgn)
                    bv[lu], bv[lv] = i / ns, v
                    lst.append(bv)
            top.append(rt)
            bot.append(rb)
        for i in range(ns):
            for j in range(nc):
                bm.faces.new((top[i][j], top[i + 1][j], top[i + 1][j + 1], top[i][j + 1]))
                bm.faces.new((bot[i][j + 1], bot[i + 1][j + 1], bot[i + 1][j], bot[i][j]))
        ring = [(i, 0) for i in range(ns + 1)] + [(ns, j) for j in range(1, nc + 1)] + \
               [(i, nc) for i in range(ns - 1, -1, -1)] + [(0, j) for j in range(nc - 1, 0, -1)]
        for (i0, j0), (i1, j1) in zip(ring, ring[1:] + ring[:1]):
            bm.faces.new((top[i0][j0], bot[i0][j0], bot[i1][j1], top[i1][j1]))
        bmesh.ops.remove_doubles(bm, verts=bm.verts, dist=1e-5)
        bmesh.ops.recalc_face_normals(bm, faces=bm.faces)

        def ev(u, v):
            s = clamp01(u) * ns
            i0 = min(int(s), ns - 1)
            f = s - i0
            a, b = L[i0].lerp(L[i0 + 1], f), T[i0].lerp(T[i0 + 1], f)
            n = NS[i0].lerp(NS[i0 + 1], f).normalized()
            h = thick * 0.5 * (1 - taper * v) * (1 - 0.5 * u ** 3)
            return a.lerp(b, v), n, h
        self.sheet_eval = ev
        slots = []
        for f in bm.faces:
            u = sum(v[lu] for v in f.verts) / len(f.verts)
            vv = sum(v[lv] for v in f.verts) / len(f.verts)
            slots.append(slotfn(u, vv))
        if mirror_x:
            dup = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
            dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
            dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
            bmesh.ops.scale(bm, vec=(-1, 1, 1), verts=dverts)
            bmesh.ops.reverse_faces(bm, faces=dfaces)
            slots += slots
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        attr = dd.fill_color(me, self.C[MAIN])
        for p, s in zip(me.polygons, slots):
            for li in p.loop_indices:
                attr.data[li].color_srgb = self.C[s]
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def veins(self, name, gi, paths, width, slot, mirror_x=True, ev=None):
        """Bandes plates (nervures, liserÃ©s, vagues) collÃ©es sur les 2 faces de la DERNIÃˆRE membrane construite :
        paths = listes de (u, v) ; mÃªmes dd_u / dd_v que la membrane (donc mÃªmes poids)."""
        ev = ev or self.sheet_eval
        bm = bmesh.new()
        lu = bm.verts.layers.float.new("dd_u")
        lv = bm.verts.layers.float.new("dd_v")
        for path in paths:
            pts = [ev(u, v) for u, v in path]
            w_of = width if callable(width) else (lambda k, n=len(pts), w0=width: w0 * (1 - 0.6 * k / max(1, n - 1)))
            for sgn in (1, -1):
                rows = []
                for k, (p, n, h) in enumerate(pts):
                    d = (pts[min(k + 1, len(pts) - 1)][0] - pts[max(k - 1, 0)][0]).normalized()
                    side = n.cross(d).normalized() * w_of(k) * 0.5
                    c = p + n * (h + 0.006) * sgn
                    row = []
                    for e in (-1, 1):
                        bv = bm.verts.new(c + side * e)
                        bv[lu], bv[lv] = path[k]
                        row.append(bv)
                    rows.append(row)
                for r0, r1 in zip(rows, rows[1:]):
                    f = bm.faces.new((r0[0], r0[1], r1[1], r1[0]))
                    f.normal_update()
                    if f.normal.dot(pts[0][1]) * sgn < 0:
                        f.normal_flip()
        if mirror_x:
            dup = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
            dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
            dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
            bmesh.ops.scale(bm, vec=(-1, 1, 1), verts=dverts)
            bmesh.ops.reverse_faces(bm, faces=dfaces)
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, self.C[slot])
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    def eyes(self, body, target, size, gi, iris_slot=GLOW, look=(0, -1, 0), iris=0.64, pupil=0.36, squash=1.12,
             sink=0.3, pupil_slot=DARK, highlights=True, glow_only=False):
        """Gros Å“il cartoon : blanc, iris, pupille, 2 reflets ; fait Ã  droite (x > 0) puis symÃ©trisÃ©."""
        _ok, loc, nor, _ = body.closest_point_on_mesh(V(target))
        ec = loc - nor * size * sink
        lk = (nor + V(look)).normalized()
        out = []
        out.append(self.part("Oeil", "sphere", WHITE if not glow_only else iris_slot, gi, loc=ec,
                             scale=(size, size, size * squash), mirror_x=True, u=12, v=8))
        fr = frame_from(ec + lk * size * 0.95, lk)
        n0 = len(out)
        if not glow_only:
            out.append(self.flat1("Iris", iris_slot, gi, circle(size * iris, 16), fr))
            out.append(self.flat1("Pupille", pupil_slot, gi, circle(size * pupil, 12, size * pupil * 0.9),
                                  fr @ Matrix.Translation((0, 0, 0.012))))
        if highlights:
            out.append(self.xf(self.part("Reflet", "sphere", WHITE, gi, scale=(size * 0.26, size * 0.26, size * 0.12),
                                         u=6, v=4), fr @ Matrix.Translation((-size * 0.22, size * 0.26, 0.05))))
            out.append(self.xf(self.part("Reflet2", "sphere", WHITE, gi, scale=(size * 0.12, size * 0.12, size * 0.07),
                                         u=6, v=4), fr @ Matrix.Translation((size * 0.24, -size * 0.2, 0.04))))
        for ob in out[n0:]:
            mirror_inplace(ob)
        return out

    # ---------------------------------------------------------------- bouche (comme le pilote, paramÃ©trÃ©e)
    def mouth_z(self, y):
        return self.mP.z + (-self.mN.y / self.mN.z) * (y - self.mP.y)

    def smile_dz(self, y):
        m = self.MOUTH
        y0, ys, amp = m["y0"], m.get("smile_y", m["y0"] - 0.5), m.get("smile", 0.08)
        return amp * sstep((y - ys) / max(1e-3, y0 - ys)) * (1 - sstep((y - y0) / 0.3))

    def make_mouth(self, body):
        m = self.MOUTH
        gap, y0 = m["gap"], m["y0"]
        me = body.data
        bm = bmesh.new()
        bm.from_mesh(me)
        for off in (-gap, gap):
            geom = [f for f in bm.faces if f.calc_center_median().y < y0]
            geom = list({g for f in geom for g in (*f.verts, *f.edges)}) + geom
            bmesh.ops.bisect_plane(bm, geom=geom, plane_co=self.mP + self.mN * off, plane_no=self.mN)
        jaw = bm.verts.layers.float.new("dd_jaw")
        shell = bm.faces.layers.int.new("dd_shell")
        for v in bm.verts:
            v[jaw] = clamp01(0.5 - (v.co - self.mP).dot(self.mN) / (2 * gap))
        bm.normal_update()
        reach = m.get("reach", 0.42)
        src = [f for f in bm.faces if f.calc_center_median().y < y0 + 0.15
               and abs((f.calc_center_median() - self.mP).dot(self.mN)) < reach]
        dup = bmesh.ops.duplicate(bm, geom=src)
        dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
        dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
        for v in dverts:
            v.co -= v.normal * m.get("shell", 0.045)
        bmesh.ops.reverse_faces(bm, faces=dfaces)
        for f in dfaces:
            f[shell] = 1
        band = [f for f in bm.faces if not f[shell] and f.calc_center_median().y < y0
                and abs((f.calc_center_median() - self.mP).dot(self.mN)) < gap]
        bmesh.ops.delete(bm, geom=band, context="FACES")
        for v in bm.verts:
            d = (v.co - self.mP).dot(self.mN)
            v.co.z += self.smile_dz(v.co.y) * math.exp(-(d / 0.16) ** 2)
        bm.to_mesh(me)
        bm.free()

    def fix_shell_normals(self, ob, minv):
        me = ob.data
        bm = bmesh.new()
        bm.from_mesh(me)
        sh = bm.faces.layers.int.get("dd_shell")
        if sh is None:
            bm.free()
            return
        bm.normal_update()
        flip = []
        for f in bm.faces:
            if f[sh]:
                c = minv @ f.calc_center_median()
                axis = V((0, c.y, self.mouth_z(c.y)))
                # normale (espace final) comparÃ©e Ã  la direction vers l'extÃ©rieur (espace squelette, mÃªme rotation)
                if f.normal.dot(c - axis) > 0:
                    flip.append(f)
        bmesh.ops.reverse_faces(bm, faces=flip)
        bm.to_mesh(me)
        bm.free()

    def teeth_row(self, body, gi, ys, sign, L, r, inset=0.08, x_min=0.05, seg=4, probe_x=0.6):
        """Dents le long de la bouche : sign = -1 haut (pointe en bas), +1 bas. Renvoie les piÃ¨ces."""
        out = []
        gap = self.MOUTH["gap"]
        for y in ys:
            z = self.mouth_z(y) + self.smile_dz(y) - sign * (gap + 0.01)
            _ok, sp, _n, _ = body.closest_point_on_mesh(V((probe_x, y, z)))
            x = max(x_min, sp.x - inset)
            out.append(self.part("Dent", "cone", WHITE, gi, loc=(x, y, z + sign * L * 0.5 - sign * 0.01),
                                 rot=(0 if sign > 0 else 180, 0, 0), mirror_x=True, segments=seg, r1=r, r2=0.0,
                                 depth=L))
        return out

    # ---------------------------------------------------------------- peinture
    def paint(self, me, fn):
        """fn(centre, normale) -> slot ou None (inchangÃ©)."""
        attr = me.color_attributes[dd.COLOR_ATTR]
        for poly in me.polygons:
            s = fn(poly.center, poly.normal)
            if s:
                for li in poly.loop_indices:
                    attr.data[li].color_srgb = self.C[s]

    def clean_islands(self, me, slot_a, slot_b, passes=2):
        attr = me.color_attributes[dd.COLOR_ATTR]
        ca, cb = V(self.C[slot_a][:3]), V(self.C[slot_b][:3])
        bm = bmesh.new()
        bm.from_mesh(me)
        bm.faces.ensure_lookup_table()
        for _ in range(passes):
            col = [V(attr.data[me.polygons[f.index].loop_indices[0]].color_srgb[:3]) for f in bm.faces]
            is_a = [(c - ca).length < 0.02 for c in col]
            is_b = [(c - cb).length < 0.02 for c in col]
            for f in bm.faces:
                nb = {g.index for e in f.edges for g in e.link_faces if g.index != f.index}
                for mine, other, rgba in ((is_a, is_b, self.C[slot_b]), (is_b, is_a, self.C[slot_a])):
                    if mine[f.index] and sum(other[i] for i in nb) >= len(nb) - 1 and len(nb) >= 3:
                        for li in me.polygons[f.index].loop_indices:
                            attr.data[li].color_srgb = rgba
        bm.free()

    def assign_slots(self, ob):
        me = ob.data
        attr = me.color_attributes[dd.COLOR_ATTR]
        pal = [(s, V(self.C[s][:3])) for s in range(1, len(self.C))]
        slots = []
        for p in me.polygons:
            c = V(attr.data[p.loop_indices[0]].color_srgb[:3])
            slots.append(min(pal, key=lambda e: (e[1] - c).length)[0])
        a = me.attributes.get("dd_slot") or me.attributes.new("dd_slot", "INT", "FACE")
        a.data.foreach_set("value", slots)
        for p, s in zip(me.polygons, slots):
            for li in p.loop_indices:
                attr.data[li].color_srgb = self.C[s]

    # ---------------------------------------------------------------- crochets Ã  surcharger
    def paint_body(self, me):
        pass

    def extras(self, body, parts):
        pass

    def origin_shift(self, m):
        """Translation finale (espace final) appliquÃ©e aprÃ¨s finalize()."""
        return V((0, 0, 0))

    def bone_specs(self):
        raise NotImplementedError

    def region_bones(self, node):
        """Os candidats (poids par distance) d'un Ã®lot de peau dont le nÅ“ud le plus proche est `node`."""
        return self.trunk_bones()

    def trunk_bones(self):
        raise NotImplementedError

    def jaw_zone(self, s):
        return s.z > self.MOUTH.get("zmin", -1e9)

    # ---------------------------------------------------------------- construction du mesh
    def build_mesh(self):
        self.groups[1:] = []
        sc, col, rcol = dd.setup_scene("DD_" + self.NAME, self.NAME)
        self.col = col
        body = dd.skin_body(self.NAME + "_Corps", self.NODES, col, branch_smoothing=self.BRANCH, subdiv=self.SUBDIV,
                            smooth_iters=self.SMOOTH, root=self.SKIN_ROOT)
        if self.DECIMATE < 1.0:  # budget : dÃ©cimation symÃ©trique du corps (avant la bouche)
            mod = body.modifiers.new("Decimate", "DECIMATE")
            mod.ratio = self.DECIMATE
            mod.use_symmetry = True
            mod.symmetry_axis = "X"
            dd.bake_modifiers(body)
        if self.MOUTH:
            self.make_mouth(body)
        me = body.data
        dd.fill_color(me, self.C[MAIN])
        self.paint_body(me)
        if self.MOUTH:
            sh = me.attributes["dd_shell"].data
            attr = me.color_attributes[dd.COLOR_ATTR]
            for poly in me.polygons:
                if sh[poly.index].value:
                    for li in poly.loop_indices:
                        attr.data[li].color_srgb = self.C[MOUTH]
        parts = [body]
        self.extras(body, parts)
        tris = {}
        for p in parts:
            k = p.name.split(".")[0].rstrip("0123456789")
            tris[k] = tris.get(k, 0) + sum(len(f.vertices) - 2 for f in p.data.polygons)
        self.part_tris = dict(sorted(tris.items(), key=lambda kv: -kv[1]))
        ob = dd.finalize(parts, self.ID + "_Mesh", "M_" + self.ID, target_height=self.HEIGHT,
                         target_length=self.LENGTH, recalc_normals=False)
        m = skel_matrix(ob)
        T = Matrix.Translation(self.origin_shift(m))
        ob.data.transform(T)
        m = T @ m
        ob["dd_skel_matrix"] = [v for row in m for v in row]
        if self.MOUTH:
            self.fix_shell_normals(ob, m.inverted())
        self.assign_slots(ob)
        split_sharp(ob, 50.0)
        st = dd.stats(ob)
        st["par_piece"] = self.part_tris
        if "model" not in sys.argv:
            assert st["triangles"] <= self.TRI_BUDGET, st
        return sc, col, rcol, ob, st

    # ---------------------------------------------------------------- rig
    def rig_mesh(self, col, ob):
        m = skel_matrix(ob)
        skel = self.bone_specs()
        specs = [("Root", V((0, 0, 0)), V((0, 0, 0.8)), None, False, False)]
        specs += [(n, m @ V(hd), m @ V(tl), par, con, dfm) for n, hd, tl, par, con, dfm in skel]
        arm = R.build_armature(col, self.ID + "_Armature", specs)
        segs = {n: (V(hd), V(tl)) for n, hd, tl, *_ in skel}
        minv = m.inverted()
        me = ob.data
        n = len(me.vertices)
        S = [minv @ v.co for v in me.vertices]

        def read(name, default=0.0):
            a = me.attributes.get(name)
            return [a.data[i].value for i in range(n)] if a else [default] * n
        G, U, Vv, JAW = read("dd_grp", 0), read("dd_u"), read("dd_v"), read("dd_jaw")

        isl = rig.islands(me)
        region = [None] * n
        for g in isl:
            if G[g[0]] != 0:
                continue
            votes = {}  # nœud majoritaire de l'îlot (plus robuste que le centre de l'îlot)
            for i in g[::3]:
                c = S[i].copy()
                c.x = abs(c.x)
                nd = min(self.NODES, key=lambda nd: (V(nd[1]) - c).length / self.rad[nd[0]])[0]
                votes[nd] = votes.get(nd, 0) + 1
            node = max(votes, key=votes.get)
            for i in g:
                region[i] = node
        trunk = set(self.trunk_bones())
        W = []
        for i, s in enumerate(S):
            side = "L" if s.x > 0 else "R"
            gi = G[i]
            if gi == 0:
                bones = [b.replace(".S", "." + side) for b in self.region_bones(region[i])]
                wd = R.dist_weights(s, bones, segs, self.SIGMA)
                if self.MOUTH and set(bones) <= trunk:
                    fy = clamp01((self.MOUTH["y0"] + 0.12 - s.y) / 0.3)
                    jw = fy * JAW[i] if self.jaw_zone(s) else 0.0
                    if jw > 0:
                        wd = {k: v * (1 - jw) for k, v in wd.items()}
                        wd["Jaw"] = wd.get("Jaw", 0.0) + jw
            else:
                kind, b, extra = self.groups[gi]
                if kind == "rigid":
                    wd = {b.replace(".S", "." + side): 1.0}
                elif kind == "dist":
                    wd = R.dist_weights(s, [x.replace(".S", "." + side) for x in b], segs, self.SIGMA)
                else:  # chain : knots [(u, os | (os_v0, os_v1))], extra = (u_coupe, (os_v0, os_v1)) ancrage au corps
                    wd = chain_weights(U[i], Vv[i], b, side)
                    if extra:
                        ucut, anchor = extra
                        a = clamp01(Vv[i] * 1.4) * (1 - sstep(U[i] / ucut))
                        if a > 0:
                            wd = {k: w * (1 - a) for k, w in wd.items()}
                            for k, w in expand_knot(anchor, Vv[i], side).items():
                                wd[k] = wd.get(k, 0.0) + w * a
            W.append(wd)
        info = R.apply_weights(ob, arm, W)
        assert info["max_influences"] <= 4 and info["sans_poids"] == 0, info
        cnt = {}
        for rg in region:
            cnt[rg] = cnt.get(rg, 0) + 1
        info["regions"] = {str(k): v for k, v in cnt.items()}
        assert not info["os_deformants_sans_poids"], info
        self.arm, self.u, self.P = arm, m[0][0], arm.pose.bones
        return arm, info

    # ---------------------------------------------------------------- animation
    def base(self):
        rig.reset_pose(self.arm)
        return self.P

    def r(self, name, *axdeg):
        pb = self.P.get(name)
        if pb is not None:
            rig.rot(pb, *axdeg)

    def mv(self, bone, x=0.0, y=0.0, z=0.0, rx=0.0, ry=0.0, rz=0.0):
        u = self.u
        rig.loc(self.P[bone], (x * u, y * u, z * u))
        rig.rot(self.P[bone], (X, rx), (Y, ry), (Z, rz))

    def make_action(self, col, clip, length, loop, pose_fn, feet_fn=None):
        arm = self.arm
        act = R.new_action(arm, self.ID, clip, length, loop)
        sc = bpy.context.scene
        sc.render.fps = 30
        sc.frame_start, sc.frame_end = 0, length
        empties = rig.setup_ik(arm, col) if feet_fn else {}
        for f in range(length + 1):
            t = ((f % length) / length) if loop else f / length
            pose_fn(t)
            for pb in arm.pose.bones:
                pb.keyframe_insert("rotation_quaternion", frame=f, group=pb.name)
                if pb.name in self.LOC_BONES:
                    pb.keyframe_insert("location", frame=f, group=pb.name)
            for side, (e1, e2, ank, toe) in empties.items():
                a, b = feet_fn(side, t, ank.copy(), toe.copy())
                e1.location, e2.location = a, b
                e1.keyframe_insert("location", frame=f)
                e2.keyframe_insert("location", frame=f)
        if feet_fn:
            rig.bake(arm, length)
            rig.teardown_ik(empties)
        arm.animation_data.action = act
        return act

    def feet(self):
        """{clip: feet_fn ou None} ; None = FK pur."""
        return {}

    def animate(self, col, ob):
        feet = self.feet()
        acts, out = {}, {}
        for clip, length, loop in self.CLIPS:
            fn = getattr(self, clip.lower())
            act = self.make_action(col, clip, length, loop, fn, feet.get(clip))
            lo = R.min_z(ob, self.arm, act, step=1)
            if clip == "Death":  # la chute finale touche le sol sans le traverser
                for _ in range(8):
                    if -0.03 < lo < 0.06:
                        break
                    self.death_drop += (lo - 0.01) / self.u
                    act = self.make_action(col, clip, length, loop, fn, feet.get(clip))
                    lo = R.min_z(ob, self.arm, act, step=1)
            acts[clip] = act
            info = {"images": length, "boucle": loop, "min_z": round(lo, 3)}
            if clip == "Death":
                info["descente"] = round(self.death_drop, 3)
            if loop:
                info["erreur_boucle"] = round(R.loop_error(self.arm, act), 5)
            out[clip] = info
        return acts, out

    # ---------------------------------------------------------------- rendus
    def setup_cam(self, sc, rcol, ob):
        dd.setup_render(sc, rcol, target=(0, 0, 1), distance=12, azimuth=-40, height_ratio=0.3)
        sh = sc.display.shading
        sh.show_cavity = False
        sh.show_specular_highlight = True
        sh.show_backface_culling = True
        sc.world.color = self.BG
        co = [v.co for v in ob.data.vertices]
        lo = V([min(c[i] for c in co) for i in range(3)])
        hi = V([max(c[i] for c in co) for i in range(3)])
        self.center = (lo + hi) / 2
        self.radius = (hi - lo).length / 2

    def still(self, sc, name, az, h=None, k=1.0, res=600, target=None):
        dist = self.radius * self.CAM_K * k
        rig.place_cam(sc, target or self.center, az, dist, self.CAM_H if h is None else h)
        sc.render.resolution_x = sc.render.resolution_y = res
        os.makedirs(RENDERS, exist_ok=True)
        return dd.render_to(sc, os.path.join(RENDERS, "%s_%s.png" % (self.ID, name)))

    def sheet_cam(self, clip):
        """(azimut, hauteur, facteur de distance, dÃ©calage de cible en z) pour la planche d'un clip."""
        return (-90 if clip in ("Walk", "Run") else -40), 0.2, 1.1, 0.0

    def render_sheets(self, sc, acts, out, clips=None):
        tmp = os.path.join(bpy.app.tempdir or os.environ.get("TEMP", "."), "dd_" + self.ID)
        for clip, _l, _lp in self.CLIPS:
            if clips and clip not in clips:
                continue
            act = acts[clip]
            self.arm.animation_data.action = act
            L = int(act["dd_len"])
            n = 8
            frames = [round(i * L / (n if act["dd_loop"] else n - 1)) for i in range(n)]
            az, h, k, dz = self.sheet_cam(clip)
            rig.place_cam(sc, self.center + V((0, 0, dz)), az, self.radius * self.CAM_K * k, h)
            out["rendu_" + clip] = R.render_sheet(sc, frames, os.path.join(RENDERS, "%s_%s.png" % (self.ID,
                                                                                                    clip.lower())), tmp, size=300)

    # ---------------------------------------------------------------- sauvegarde
    def save_blend(self, sc):
        for s in list(bpy.data.scenes):
            if s != sc:
                for o in list(s.collection.all_objects):
                    if len(o.users_scene) == 1:
                        bpy.data.objects.remove(o, do_unlink=True)
                bpy.data.scenes.remove(s)
        sc["dd_id"] = self.ID
        sc["dd_colors"] = json.dumps(self.COLORS)
        os.makedirs(DINOS_DIR, exist_ok=True)
        path = os.path.join(DINOS_DIR, self.ID + ".blend")
        bpy.ops.wm.save_as_mainfile(filepath=path, check_existing=False)
        with open(os.path.join(DINOS_DIR, self.ID + "_look.json"), "w", encoding="utf-8") as fh:
            json.dump({k: self.COLORS[k] for k in ("main", "belly", "accent", "glow", "back") if k in self.COLORS},
                      fh, indent=2)
        return path

    def main(self):
        args = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
        sc, col, rcol, ob, st = self.build_mesh()
        self.setup_cam(sc, rcol, ob)
        out = {"mesh": st}
        out["r34"] = self.still(sc, "34", -40)
        out["rside"] = self.still(sc, "side", -90, h=0.1)
        out["rfront"] = self.still(sc, "front", 0, h=0.15)
        if "model" in args:
            print("DD_RESULT", json.dumps(out))
            return
        arm, winfo = self.rig_mesh(col, ob)
        out["poids"] = winfo
        out["os"] = len(arm.data.bones)
        acts, out["clips"] = self.animate(col, ob)
        if "norender" not in args:
            only = [a for a in args if a[:1].isupper()]
            self.render_sheets(sc, acts, out, only or None)
        arm.animation_data.action = acts["Idle"]
        sc.frame_set(0)
        out["fichier"] = self.save_blend(sc)
        print("DD_RESULT", json.dumps(out, default=str))


def skel_matrix(ob):
    v = list(ob["dd_skel_matrix"])
    return Matrix([v[0:4], v[4:8], v[8:12], v[12:16]])


def expand_knot(b, v, side):
    if isinstance(b, tuple):
        d = {}
        for k, w in ((b[0], 1 - v), (b[1], v)):
            k = k.replace(".S", "." + side)
            d[k] = d.get(k, 0.0) + w
        return d
    return {b.replace(".S", "." + side): 1.0}


def chain_weights(u, v, knots, side):
    """Poids linÃ©aires par morceaux le long de l'envergure (u), entre les nÅ“uds (u_k, os_k)."""
    if u <= knots[0][0]:
        return expand_knot(knots[0][1], v, side)
    for (u0, b0), (u1, b1) in zip(knots, knots[1:]):
        if u <= u1:
            t = (u - u0) / (u1 - u0) if u1 > u0 else 1.0
            d = {}
            for b, w in ((b0, 1 - t), (b1, t)):
                for k, x in expand_knot(b, v, side).items():
                    d[k] = d.get(k, 0.0) + x * w
            return {k: x for k, x in d.items() if x > 1e-4}
    return expand_knot(knots[-1][1], v, side)


def bone_chain(names, pts, parent, first_connected=False):
    """Os successifs le long de pts (len(names) + 1 points)."""
    out = []
    for i, n in enumerate(names):
        out.append((n, pts[i], pts[i + 1], parent if i == 0 else names[i - 1], i > 0 or first_connected, True))
    return out


def joint_knots(lead_pts, bones, anchor):
    """NÅ“uds de chain_weights pour une membrane dont le bord d'attaque suit les os `bones` (un segment de
    lead_pts par os) : ancre Ã  u = 0, milieu de chaque os, dernier os au bout."""
    _pts, acc = resample(lead_pts, 4)
    kn = [(0.0, anchor)]
    for i, b in enumerate(bones):
        kn.append(((acc[i] + acc[i + 1]) / 2, b))
    kn.append((1.0, bones[-1]))
    return kn, acc


# ================================================================== PTÃ‰ROSAURE

class Ptero(Dino):
    """NÅ“uds attendus : hanche, torse, poitrine, cou1, cou2, cou3, crane, becâ€¦ (tronc) ; cuisse, genou, cheville,
    pied (jambe, x > 0) ; epaule, coude, poignet, doigt1, doigt2, doigt3 (bras-aile, x > 0) ; queue* optionnels."""
    LEGS = True
    TAIL = []  # nÅ“uds de la queue (aprÃ¨s Â« hanche Â»)
    NT = 0
    HEAD_TIP = "bec3"
    JAW_BONE = ((0, -0.9, 3.15), (0, -2.2, 3.0))
    CREST_BONE = ((0, -0.7, 3.9), (0, 0.4, 4.2))
    WING_TRAIL = []  # bord de fuite, de la hanche au bout de l'aile (x > 0)
    WING_NS, WING_NC, WING_THICK, WING_BULGE = 14, 4, 0.06, 0.0
    ARM_NODES = ("epaule", "coude", "poignet", "doigt1", "doigt2", "doigt3")
    LEG_NODES = ("cuisse", "genou", "cheville", "pied")
    WING_BONES = ("Humerus.S", "Forearm.S", "WingFinger1.S", "WingFinger2.S", "WingFinger3.S")
    STEP, LIFT = 0.55, 0.32  # pas du dandinement (squelette)

    def wing_slot(self, u, v):
        return BELLY

    def wing(self, body_parts):
        """Membrane de l'aile (grille) + pondÃ©ration le long du bras-aile."""
        lead = [self.pos[k] for k in self.ARM_NODES]
        kn, acc = joint_knots(lead, list(self.WING_BONES), ("Spine", "Hips"))
        self.wing_acc = acc
        gi = self.grp("chain", kn, (acc[2], ("Spine", "Hips")))
        body_parts.append(self.sheet("Aile", gi, lead, self.WING_TRAIL, self.WING_NS, self.WING_NC, self.WING_THICK,
                                     self.wing_slot, mirror_x=True, bulge=self.WING_BULGE))

    def origin_shift(self, m):
        if self.LEGS:
            p = self.pos
            return V((0, -(m @ p["cheville"].lerp(p["pied"], 0.5)).y, 0))
        return V((0, -(m @ self.pos["hanche"]).y, 0))

    def bone_specs(self):
        p = self.pos
        s = [("Hips", p["hanche"], p["torse"], "Root", False, True),
             ("Spine", p["torse"], p["poitrine"], "Hips", True, True),
             ("Neck1", p["poitrine"], p["cou1"], "Spine", True, True),
             ("Neck2", p["cou1"], p["cou2"], "Neck1", True, True),
             ("Neck3", p["cou2"], p["cou3"], "Neck2", True, True),
             ("Head", p["cou3"], p[self.HEAD_TIP], "Neck3", True, True),
             ("Jaw", V(self.JAW_BONE[0]), V(self.JAW_BONE[1]), "Head", False, True),
             ("Crest", V(self.CREST_BONE[0]), V(self.CREST_BONE[1]), "Head", False, True)]
        if self.NT:
            pts = chain_resample([p["hanche"]] + [p[k] for k in self.TAIL], self.NT)
            s += bone_chain(["Tail%d" % (i + 1) for i in range(self.NT)], pts, "Hips")
        for side, sx in SIDES:
            def q(k):
                w = p[k].copy()
                w.x *= sx
                return w
            arm = [q(k) for k in self.ARM_NODES]
            s += bone_chain([b.replace(".S", "." + side) for b in self.WING_BONES], arm, "Spine")
            if self.LEGS:
                leg = [q(k) for k in self.LEG_NODES]
                s += bone_chain(["UpperLeg." + side, "LowerLeg." + side, "Foot." + side], leg, "Hips")
        return s + self.extra_bones()

    def extra_bones(self):
        return []

    def trunk_bones(self):
        return ["Hips", "Spine", "Neck1", "Neck2", "Neck3", "Head"] + ["Tail%d" % (i + 1) for i in range(self.NT)]

    def region_bones(self, node):
        if node in self.ARM_NODES:
            return list(self.WING_BONES) + ["Spine"]
        if node in self.LEG_NODES:
            return ["UpperLeg.S", "LowerLeg.S", "Foot.S", "Hips"]
        return self.trunk_bones()

    # ---------------------------------------------------------------- poses
    def wing_pose(self, side, up=0.0, sweep=0.0, twist=0.0, elbow=0.0, wrist=0.0, tip=0.0, fold=0.0, ffold=None):
        """up > 0 lÃ¨ve l'aile, sweep > 0 la balaie vers l'arriÃ¨re, fold replie avant-bras/doigt vers l'arriÃ¨re."""
        sx = 1.0 if side == "L" else -1.0
        self.r("Humerus." + side, (Y, -sx * up), (Z, sx * sweep), (X, twist))
        self.r("Forearm." + side, (Y, -sx * elbow), (Z, sx * fold))
        self.r("WingFinger1." + side, (Y, -sx * wrist), (Z, sx * (fold * 1.2 if ffold is None else ffold)))
        self.r("WingFinger2." + side, (Y, -sx * tip))
        self.r("WingFinger3." + side, (Y, -sx * tip * 1.2))

    def wings(self, **kw):
        for side, _sx in SIDES:
            self.wing_pose(side, **kw)

    def tail(self, fn):
        for i in range(self.NT):
            self.r("Tail%d" % (i + 1), *fn(i))

    def neck(self, rx=0.0, rz=0.0, ry=0.0, head_rx=0.0, head_rz=0.0, head_ry=0.0):
        for n in ("Neck1", "Neck2", "Neck3"):
            self.r(n, (X, rx / 3), (Z, rz / 3), (Y, ry / 3))
        self.r("Head", (X, head_rx), (Z, head_rz), (Y, head_ry))

    def legs_tuck(self, k):
        for side, _sx in SIDES:
            self.r("UpperLeg." + side, (X, -55 * k))
            self.r("LowerLeg." + side, (X, 70 * k))
            self.r("Foot." + side, (X, -60 * k))

    # Idle : respiration, regarde autour, ailes Ã  demi repliÃ©es qui Â« respirent Â»
    def idle(self, t):
        self.base()
        br = S2(t, 2)
        look = keys(t, [(0, 0), (0.2, 0), (0.3, 1), (0.5, 1), (0.6, -1), (0.8, -1), (0.9, 0), (1, 0)])
        self.mv("Hips", z=-0.02 + 0.02 * br, rx=-2 * br, rz=3 * S2(t, 1))
        self.r("Spine", (X, -2 * br))
        self.neck(rx=4 * br, rz=14 * look, head_rx=3 * S2(t, 2, 0.3), head_rz=10 * look, head_ry=-6 * look)
        self.r("Jaw", (X, 4 * max(0.0, br)))
        self.r("Crest", (X, 3 * S2(t, 2, 0.2)))
        self.wings(up=-20 + 4 * br, sweep=18, elbow=-12, wrist=-14 + 4 * S2(t, 2, 0.1), tip=-10 + 5 * S2(t, 2, 0.2),
                   twist=-15)
        self.tail(lambda i: ((Z, 5 * S2(t, 1, -0.1 * i)), (X, 2 * S2(t, 2, -0.1 * i))))

    # Marche : dandinement sautillant, ailes en balancier
    def walk(self, t):
        self.base()
        bob = math.cos(2 * math.pi * 2 * t)
        roll = S2(t, 1)
        self.mv("Hips", z=-0.06 - 0.08 * bob, rx=6, ry=10 * roll, rz=8 * S2(t, 1, 0.25))
        self.r("Spine", (Y, -5 * roll), (X, 2 * bob))
        self.neck(rx=-6 + 5 * S2(t, 2, 0.1), ry=-4 * roll, head_rx=-2 - 4 * S2(t, 2, 0.15), head_ry=-6 * roll)
        self.r("Jaw", (X, 3 + 3 * max(0.0, -bob)))
        for side, sx in SIDES:
            k = roll * sx
            self.wing_pose(side, up=-24 + 12 * k, sweep=16, elbow=-10, wrist=-10 + 6 * S2(t, 2, 0.15), tip=-8,
                           twist=-12)
        self.tail(lambda i: ((Z, -8 * S2(t, 1, -0.08 * (i + 1))), (X, 3 * S2(t, 2, -0.1 * i))))

    def walk_feet(self, side, t, ank, toe):
        return cycle_foot(side, t, ank, toe, self.STEP * self.u, self.LIFT * self.u, 0.5, self.u)

    # Course = vol battu : corps Ã  l'horizontale, ailes qui battent (retard du bout), pattes repliÃ©es
    FLY_Z, FLY_PITCH, FLAP = 1.1, 55, 42

    def run(self, t):
        self.base()
        f = S2(t, 1, 0.25)  # 1 = ailes en haut
        self.mv("Hips", z=self.FLY_Z + 0.12 * S2(t, 1, 0.75), rx=self.FLY_PITCH + 4 * f)
        self.r("Spine", (X, -3 * f))
        self.neck(rx=-self.FLY_PITCH * 0.75 + 3 * f, head_rx=-self.FLY_PITCH * 0.25 - 4 * f)
        self.r("Jaw", (X, 6))
        self.r("Crest", (X, -4 * S2(t, 1, 0.1)))
        A = self.FLAP
        for side, _sx in SIDES:
            self.wing_pose(side, up=8 + A * f, sweep=-4 + 6 * S2(t, 1), twist=-10 * S2(t, 1),
                           elbow=-14 * S2(t, 1, 0.12), wrist=-16 * S2(t, 1, 0.05), tip=-14 * S2(t, 1, -0.05))
        self.legs_tuck(1.0)
        self.tail(lambda i: ((X, -6 * S2(t, 1, -0.1 * (i + 1))),))

    # Attaque : anticipation (recule, ailes levÃ©es, bec ouvert), coup de bec, retour
    def attack(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.56, 1), (0.86, 0), (1, 0)])
        s2 = keys(t, [(0, 0), (0.36, 0), (0.48, 1), (0.64, 1), (0.94, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.22, 0.4), (0.33, 1), (0.42, 0), (0.48, 0.25), (0.62, 0), (1, 0)])
        self.mv("Hips", y=0.22 * a - 0.45 * s, z=-0.12 * a, rx=-12 * a + 22 * s)
        self.r("Spine", (X, -5 * a + 6 * s))
        self.neck(rx=-24 * a + 20 * s, head_rx=-10 * a + 14 * s)
        self.r("Jaw", (X, 45 * j))
        self.r("Crest", (X, -8 * s2 + 6 * a))
        self.wings(up=-20 + 50 * a - 30 * s, sweep=10 - 20 * a + 10 * s2, elbow=-10 + 10 * a, wrist=-8 + 14 * a - 10 * s2,
                   tip=-6 + 10 * a - 12 * s2, twist=-10)
        self.tail(lambda i: ((X, 6 * a - 8 * s2),))

    # Rugissement : se tasse, se dresse ailes grandes ouvertes, bec grand ouvert qui tremble
    def roar(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.16, 1), (0.26, 0), (1, 0)])
        r = keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * S2(t, 7)
        self.mv("Hips", z=-0.14 * a + 0.08 * r, rx=12 * a - 12 * r)
        self.r("Spine", (X, 4 * a - 6 * r))
        self.neck(rx=18 * a - 22 * r, head_rx=14 * a - 16 * r + 4 * sh, head_rz=6 * sh)
        self.r("Jaw", (X, 6 * a + 50 * r))
        self.r("Crest", (X, -6 * r + 3 * sh))
        self.wings(up=-12 * a + 28 * r, sweep=20 * a - 14 * r, elbow=-10 * a + 6 * r, wrist=-12 * a + 10 * r,
                   tip=-8 * a + 10 * r + 4 * sh, twist=-10 * a)
        self.tail(lambda i: ((X, 4 * a + 14 * r), (Z, 4 * sh)))

    # CÃ©lÃ©bration : 2 sauts avec battements d'ailes, tÃªte qui dodeline, bec ouvert
    def hop(self, t):
        h1, h2 = pulse(t, 0.12, 0.40), pulse(t, 0.50, 0.78)
        sq = sum(math.exp(-((tt - c) / 0.035) ** 2) for tt, c in ((t, 0.1), (t, 0.42), (t, 0.48), (t, 0.8)))
        return h1 + h2, sq

    def celebrate(self, t):
        self.base()
        air, sq = self.hop(t)
        joy = keys(t, [(0, 0), (0.08, 1), (0.86, 1), (1, 0)])
        self.mv("Hips", z=0.7 * air - 0.16 * sq, rx=-6 * air + 6 * sq, rz=8 * S2(t, 2) * joy)
        self.neck(rx=-10 * air * joy + 8 * sq, head_ry=14 * S2(t, 2) * joy)
        self.r("Jaw", (X, 30 * joy))
        self.r("Crest", (X, 8 * S2(t, 4) * joy))
        f = S2(t, 4) * joy
        self.wings(up=-10 + 40 * f * joy + 10 * joy, sweep=6, elbow=-10 * S2(t, 4, 0.1), wrist=-12 * S2(t, 4, 0.05),
                   tip=-12 * S2(t, 4, -0.05), twist=-8)
        self.tail(lambda i: ((Z, 14 * S2(t, 3, -0.07 * i) * joy),))

    def celebrate_feet(self, side, t, ank, toe):
        air, _sq = self.hop(t)
        off = V((0, 0, 0.6 * air * self.u))
        return ank + off, toe + off + V((0, 0, -0.1 * air * self.u))

    # Mort : coup reÃ§u, vacille, s'effondre sur le flanc, ailes qui retombent
    def death(self, t):
        self.base()
        h = keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = S2(t, 3) * keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        f = keys(t, [(0, 0), (0.36, 0), (0.62, 1), (0.71, 0.9), (0.8, 1), (1, 1)])
        # chute vers l'avant, à plat ventre, ailes étalées au sol (« splat »), tête de côté, bec entrouvert
        self.mv("Hips", y=0.25 * h - 0.35 * f, z=-self.death_drop * f, rx=-14 * h + 72 * f, rz=8 * w + 6 * f)
        self.neck(rx=-14 * h - 58 * f, rz=-10 * f, head_rx=-14 * h - 26 * f, head_rz=-10 * f, head_ry=10 * w + 28 * f)
        self.r("Jaw", (X, 30 * h + 22 * f))
        self.r("Crest", (X, 10 * f))
        self.wings(up=24 * h - 10 * w - 6 * f, sweep=-10 * h - 4 * f, elbow=-6 * f, wrist=-8 * f, tip=-10 * f,
                   twist=-20 * f)
        for side, _sx in SIDES:
            self.r("UpperLeg." + side, (X, -45 * f))
            self.r("LowerLeg." + side, (X, 20 * f))
            self.r("Foot." + side, (X, -40 * f))
        self.tail(lambda i: ((Z, -6 * f), (X, -10 * f)))

    def attack_feet(self, side, t, ank, toe):
        return ank, toe

    def feet(self):
        if not self.LEGS:
            return {}
        fixed = lambda s, t, a, b: (a, b)  # noqa: E731
        return {"Idle": fixed, "Walk": self.walk_feet, "Run": None, "Attack": self.attack_feet, "Roar": fixed,
                "Celebrate": self.celebrate_feet, "Death": None}

    def sheet_cam(self, clip):
        if clip == "Run":
            return -35, 0.6, 1.1, 0.8 * self.u
        return super().sheet_cam(clip)


def cycle_foot(side, t, ank, toe, st, lf, stance, u):
    ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
    if ph < stance:
        q = ph / stance
        dy, dz, drop = -st / 2 + st * q, 0.0, 0.0
    else:
        q = (ph - stance) / (1 - stance)
        sm = 0.5 - 0.5 * math.cos(math.pi * q)
        dy, dz, drop = st / 2 - st * sm, lf * math.sin(math.pi * q), 0.1 * u * math.sin(math.pi * q)
    off = V((0, dy, dz))
    return ank + off, toe + off - V((0, 0, drop))


# ================================================================== AQUATIQUE

class Aqua(Dino):
    """NÅ“uds attendus : corps (centre), chaÃ®ne avant SPINE_PATH (corps -> base de la tÃªte), museau (bout) ;
    queue QUEUE_PATH. Os : Spine1-4 (Spine1 = centre du corps, porte les dÃ©placements), Head, Jaw, Tail1-5,
    FinF1/FinF2 et FinB1/FinB2 par cÃ´tÃ© (nageoires en grille)."""
    LOC_BONES = ("Spine1",)
    SPINE_PATH = ["corps", "poitrine", "cou"]
    NS = 4
    HEAD_PATH = ["cou", "museau"]
    TAIL_PATH = ["corps", "queue1", "queue2", "queue3"]
    NT = 5
    JAW_BONE = ((0, -1.9, 1.5), (0, -3.1, 1.4))
    HOVER = 0.6  # studs entre le ventre et le sol au repos
    # Nageoires : (bord d'attaque racine -> bout, bord de fuite racine -> bout, os parent) ; x > 0
    FIN_F = None
    FIN_B = None
    FIN_NS, FIN_NC, FIN_THICK = 8, 3, 0.1
    SWIM_LAT, SWIM_FLIP = 1.0, 0.5  # part d'ondulation latÃ©rale / de battement des nageoires
    FIN_F_PARENT, FIN_B_PARENT = "Spine2", "Spine1"

    def fin_slot(self, u, v):
        return ACCENT

    def origin_shift(self, m):
        co_min = self._minz_final
        return V((0, -(m @ self.pos["corps"]).y, self.HOVER - co_min))

    def build_mesh(self):
        self._minz_final = 0.0
        return super().build_mesh()

    def fins(self, parts):
        for key, spec, par in (("F", self.FIN_F, self.FIN_F_PARENT), ("B", self.FIN_B, self.FIN_B_PARENT)):
            if not spec:
                continue
            lead, trail = spec
            kn = [(0.0, par), (0.3, "Fin%s1.S" % key), (0.72, "Fin%s2.S" % key), (1.0, "Fin%s2.S" % key)]
            gi = self.grp("chain", kn)
            parts.append(self.sheet("Nageoire" + key, gi, lead, trail, self.FIN_NS, self.FIN_NC, self.FIN_THICK,
                                    self.fin_slot, mirror_x=True, up_hint=(0, 0, 1)))

    def spine_pts(self):
        return chain_resample([self.pos[k] for k in self.SPINE_PATH], self.NS)

    def bone_specs(self):
        p = self.pos
        sp = self.spine_pts()
        s = bone_chain(["Spine%d" % (i + 1) for i in range(self.NS)], sp, "Root")
        hp = [p[k] for k in self.HEAD_PATH]
        s.append(("Head", hp[0], hp[-1], "Spine%d" % self.NS, True, True))
        s.append(("Jaw", V(self.JAW_BONE[0]), V(self.JAW_BONE[1]), "Head", False, True))
        tp = chain_resample([p[k] for k in self.TAIL_PATH], self.NT)
        s += bone_chain(["Tail%d" % (i + 1) for i in range(self.NT)], tp, "Spine1")
        for key, spec, par in (("F", self.FIN_F, self.FIN_F_PARENT), ("B", self.FIN_B, self.FIN_B_PARENT)):
            if not spec:
                continue
            lead = [V(q) for q in spec[0]]
            pts = chain_resample(lead, 2)
            for side, sx in SIDES:
                m = [V((q.x * sx, q.y, q.z)) for q in pts]
                s += bone_chain(["Fin%s1.%s" % (key, side), "Fin%s2.%s" % (key, side)], m, par)
        return s + self.extra_bones()

    def extra_bones(self):
        return []

    def trunk_bones(self):
        return ["Spine%d" % (i + 1) for i in range(self.NS)] + ["Head"] + ["Tail%d" % (i + 1) for i in range(self.NT)]

    # ---------------------------------------------------------------- poses
    def body_wave(self, t, amp, k=1.0, lag=0.09, pitch=0.0):
        """Ondulation : la tÃªte bouge peu, la queue beaucoup (latÃ©rale si SWIM_LAT, verticale sinon)."""
        lat, vert = self.SWIM_LAT, 1.0 - self.SWIM_LAT
        for i in range(self.NS):
            w = amp * 0.18 * (self.NS - i) / self.NS
            self.r("Spine%d" % (i + 1), (Z, lat * w * S2(t, k, lag * (i + 1))), (X, vert * w * S2(t, k, lag * (i + 1))))
        self.r("Head", (Z, -lat * amp * 0.12 * S2(t, k, 0.05)), (X, -vert * amp * 0.1 * S2(t, k, 0.05) + pitch))
        for i in range(self.NT):
            w = amp * (0.35 + 0.22 * i)
            ph = -lag * (i + 1)
            self.r("Tail%d" % (i + 1), (Z, lat * w * S2(t, k, ph)), (X, vert * w * S2(t, k, ph)))

    def fin_pose(self, key, side, up=0.0, sweep=0.0, twist=0.0, bend=0.0):
        sx = 1.0 if side == "L" else -1.0
        self.r("Fin%s1.%s" % (key, side), (Y, -sx * up), (Z, sx * sweep), (X, twist))
        self.r("Fin%s2.%s" % (key, side), (Y, -sx * bend))

    def paddle(self, t, k, amp, sweep=0.0, base=0.0, front_only=False):
        for key, ph in (("F", 0.0), ("B", 0.5)):
            if front_only and key == "B":
                continue
            for side, _sx in SIDES:
                f = S2(t, k, ph)
                self.fin_pose(key, side, up=base + amp * f, sweep=sweep + amp * 0.4 * S2(t, k, ph + 0.25),
                              twist=-amp * 0.5 * S2(t, k, ph + 0.25), bend=amp * 0.5 * S2(t, k, ph - 0.12))

    def idle(self, t):
        self.base()
        br = S2(t, 2)
        look = keys(t, [(0, 0), (0.25, 0), (0.35, 1), (0.5, 1), (0.6, -1), (0.78, -1), (0.88, 0), (1, 0)])
        self.mv("Spine1", z=0.08 * S2(t, 2), rx=-2 * S2(t, 2, 0.2), rz=4 * S2(t, 1))
        self.body_wave(t, 6, k=1)
        self.r("Head", (Z, 12 * look), (X, 3 * br), (Y, -6 * look))
        self.r("Jaw", (X, 5 * max(0.0, br)))
        self.paddle(t, 2, 14, base=-4)

    def walk(self, t):
        self.base()
        self.mv("Spine1", z=0.06 * S2(t, 2, 0.1), rx=-3, ry=3 * S2(t, 1, 0.3))
        self.body_wave(t, 12 * self.SWIM_LAT + 6, k=1)
        self.r("Jaw", (X, 4))
        self.paddle(t, 1, 18 + 18 * self.SWIM_FLIP)

    def run(self, t):
        self.base()
        self.mv("Spine1", z=0.12 + 0.08 * S2(t, 2), rx=6, ry=4 * S2(t, 1, 0.3))
        self.body_wave(t, 20 * self.SWIM_LAT + 10, k=1, lag=0.11)
        self.r("Jaw", (X, 10))
        self.paddle(t, 1, 26 + 26 * self.SWIM_FLIP, sweep=12)

    def attack(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.3, 1), (0.38, 0), (1, 0)])
        s = keys(t, [(0, 0), (0.3, 0), (0.4, 1), (0.56, 1), (0.86, 0), (1, 0)])
        s2 = keys(t, [(0, 0), (0.36, 0), (0.48, 1), (0.64, 1), (0.94, 0), (1, 0)])
        j = keys(t, [(0, 0), (0.2, 0.5), (0.33, 1), (0.42, 0), (0.48, 0.3), (0.6, 0), (1, 0)])
        self.mv("Spine1", y=0.4 * a - 0.9 * s, z=0.15 * a - 0.05 * s, rx=-10 * a + 10 * s)
        for i in range(self.NS):
            self.r("Spine%d" % (i + 1), (X, -3 * a + 3 * s))
        self.r("Head", (X, -18 * a + 12 * s), (Z, 8 * s2 * S2(t, 3)))
        self.r("Jaw", (X, 50 * j))
        for i in range(self.NT):
            self.r("Tail%d" % (i + 1), (X, 6 * a - 8 * s2), (Z, (10 + 6 * i) * s2 * S2(t, 2, -0.1 * i)))
        for key in ("F", "B"):
            for side, _sx in SIDES:
                self.fin_pose(key, side, up=30 * a - 30 * s, sweep=-20 * a + 30 * s, bend=-15 * s2)

    def roar(self, t):
        self.base()
        a = keys(t, [(0, 0), (0.16, 1), (0.26, 0), (1, 0)])
        r = keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * S2(t, 7)
        self.mv("Spine1", z=-0.1 * a + 0.3 * r, rx=8 * a - 22 * r)
        for i in range(self.NS):
            self.r("Spine%d" % (i + 1), (X, 2 * a - 4 * r))
        self.r("Head", (X, 10 * a - 14 * r + 4 * sh), (Z, 7 * sh))
        self.r("Jaw", (X, 6 * a + 55 * r))
        for i in range(self.NT):
            self.r("Tail%d" % (i + 1), (X, -4 * a + 10 * r), (Z, 6 * S2(t, 4, -0.1 * i) * r))
        for key in ("F", "B"):
            for side, _sx in SIDES:
                self.fin_pose(key, side, up=-20 * a + 40 * r + 6 * sh, sweep=15 * a - 15 * r, bend=12 * r)

    def celebrate(self, t):
        self.base()
        joy = keys(t, [(0, 0), (0.08, 1), (0.86, 1), (1, 0)])
        roll = keys(t, [(0, 0), (0.15, 0), (0.6, 360), (1, 360)])
        air = pulse(t, 0.1, 0.65)
        self.mv("Spine1", z=0.9 * air, ry=roll, rx=-10 * air)
        self.body_wave(t, 14 * joy, k=2)
        self.r("Jaw", (X, 30 * joy))
        self.paddle(t, 4, 30 * joy, base=10 * joy)

    def death(self, t):
        self.base()
        h = keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = S2(t, 3) * keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        f = keys(t, [(0, 0), (0.3, 0), (0.62, 1), (0.72, 0.92), (0.82, 1), (1, 1)])
        roll = keys(t, [(0, 0), (0.25, 0), (0.6, 170), (1, 180)])
        self.mv("Spine1", y=0.3 * h, z=-self.death_drop * f, rx=-10 * h, rz=8 * w, ry=roll)
        self.r("Head", (X, -16 * h + 10 * f), (Z, 10 * w))
        self.r("Jaw", (X, 30 * h + 25 * f))
        for i in range(self.NT):
            self.r("Tail%d" % (i + 1), (Z, 5 * w), (X, 4 * f))
        for key in ("F", "B"):
            for side, _sx in SIDES:
                self.fin_pose(key, side, up=25 * h - 10 * f, bend=20 * f)

    def sheet_cam(self, clip):
        return (-90 if clip in ("Walk", "Run") else -40), 0.25, 1.25, 0.0
