# DINO DICE — outils communs des THÉROPODES uniques (Modeleur A) : corps, bouche ouvrable, yeux, mains, pieds,
# rig, 7 animations génériques (surchargées par dino), rendus de contrôle, sauvegarde.
# Version : 1
# Reprend la méthode du pilote build_chronoraptor.py (mêmes nœuds de squelette, mêmes os, mêmes conventions)
# sans le modifier ; dd_dino_rig.py et export_luau.py sont utilisés tels quels.
#
# Un dino = un module build_<id>.py qui définit ID, NAME, HEIGHT, COLORS, NODES, MOUTH_*, EYE, etc.,
# une fonction accessories(B), et une sous-classe d'Anims (au moins idle), puis appelle run(module).
#
# Bouche : coupe au plan de la bouche devant la commissure, lèvres DÉCOUSUES (charnière aux commissures),
# palais et plancher en éventail (rouge sombre, slot 7), langue (slot 8), dents blanches : bouche fermée =
# trait fin sombre ; ouverte (os Jaw) = gueule avec intérieur, langue et dents.
# Slots (export v2) : 1 main, 2 belly, 3 accent, 4 blanc, 5 sombre, 6 glow, 7 dos, 8 intérieur de bouche,
# 9 langue / joues.

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
from build_chronoraptor import plane_yz, frame_from, arrow, mirror_inplace, split_sharp  # noqa: E402,F401

MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, MOUTH, TONGUE = range(1, 10)
FIXED = {WHITE: "#FFFFFF", DARK: "#1B1B22", MOUTH: "#6A1B2A", TONGUE: "#F06292"}  # comme le pilote v2 / export v2
RENDERS = os.path.join(PROJECT_DIR, "docs", "renders", "dinos")
SIDES = (("L", 1.0), ("R", -1.0))
LEG = ("UpperLeg", "LowerLeg", "Foot", "Toe")
ARMB = ("UpperArm", "LowerArm")
LEG_NODES = ("bassin", "cuisse", "genou", "cheville", "pied", "orteils")
ARM_NODES = ("epaule", "coude", "main")
LIMBS = set(LEG_NODES) | set(ARM_NODES)
HEAD_CHAIN = ["hanche", "ventre", "epaules", "cou", "cou2", "crane", "machoire", "museau", "nez"]


def clamp01(x):
    return max(0.0, min(1.0, x))


class Builder:
    def __init__(self, cfg):
        self.cfg = cfg
        self.id = cfg.ID
        hexes = [None, cfg.COLORS["main"], cfg.COLORS["belly"], cfg.COLORS["accent"], FIXED[WHITE], FIXED[DARK],
                 cfg.COLORS["glow"], cfg.COLORS["back"], FIXED[MOUTH], FIXED[TONGUE]]
        self.C = [None] + [dd.hex_rgba(h) for h in hexes[1:]]
        self.groups = [None]
        self.parts = []
        self.pos = {k: Vector(p) for k, p, _r, _par in cfg.NODES}
        self.rad = {k: (r if isinstance(r, (int, float)) else max(r)) for k, _p, r, _par in cfg.NODES}
        tails = sorted((k for k in self.pos if k.startswith("queue")), key=lambda k: int(k[5:]))
        self.tails = tails
        self.spine = list(reversed(tails)) + HEAD_CHAIN
        self.col = None
        self.body = None
        self.mi = {}

    # ------------------------------------------------------------ pièces
    def grp(self, kind, bones):
        key = (kind, bones if isinstance(bones, str) else tuple(bones))
        for i, g in enumerate(self.groups[1:], 1):
            if (g[0], g[1] if isinstance(g[1], str) else tuple(g[1])) == key:
                return i
        self.groups.append((kind, bones))
        return len(self.groups) - 1

    def tag(self, ob, gi):
        a = ob.data.attributes.new("dd_grp", "INT", "POINT")
        a.data.foreach_set("value", [gi] * len(ob.data.vertices))
        return ob

    def add(self, ob):
        self.parts.append(ob)
        return ob

    def P(self, name, kind, slot, gi, M=None, **kw):
        ob = self.tag(dd.part(name, kind, self.col, self.C[slot], **kw), gi)
        if M is not None:
            ob.data.transform(M)
        return self.add(ob)

    def flat(self, name, slot, gi, outline2d, M, thick, mirror_x=False):
        pts = [M @ Vector((x, y, 0)) for x, y in outline2d]
        return self.add(self.tag(dd.membrane(name, self.col, self.C[slot], pts, thickness=thick, mirror_x=mirror_x), gi))

    def mirror(self, obs):
        for ob in obs:
            mirror_inplace(ob)

    def snap(self, p, off=0.0):
        return dd.snap(self.body, p, off)

    def top(self, y, x=0.0, z0=20.0):
        """Point du dessus du corps à (x, y) (rayon vertical), et sa normale."""
        hit, loc, nor, _i = self.body.ray_cast(Vector((x, y, z0)), Vector((0, 0, -1)))
        assert hit, ("rien sous", x, y)
        return loc, nor

    def surf(self, p):
        _ok, loc, nor, _ = self.body.closest_point_on_mesh(Vector(p))
        return loc, nor

    def ellipsoid(self, name, slot, gi, center, axis, length, r, u=8, v=6, up=(0, 0, 1)):
        """Ellipsoïde allongé le long de `axis` (longueur totale `length`, rayon r ou (rx, ry))."""
        rx, ry = (r, r) if isinstance(r, (int, float)) else r
        M = frame_from(center, axis, up) @ Matrix.Diagonal((rx, ry, length * 0.5, 1))
        return self.P(name, "sphere", slot, gi, M=M, u=u, v=v)

    def cone_to(self, name, slot, gi, base, direction, depth, r, segments=5, r2=0.0, up=(0, 0, 1)):
        """Cône dont la base est en `base` et la pointe vers `direction`."""
        d = Vector(direction).normalized()
        M = frame_from(base, d, up) @ Matrix.Translation((0, 0, depth * 0.5))
        return self.P(name, "cone", slot, gi, M=M, segments=segments, r1=r, r2=r2, depth=depth)

    def star(self, name, slot, gi, center, normal, r, branches=4, inner=0.38, thick=0.04, rot=0.0, up=(0, 0, 1)):
        pts = []
        for k in range(branches * 2):
            a = rot + math.pi * k / branches
            rr = r if k % 2 == 0 else r * inner
            pts.append((rr * math.sin(a), rr * math.cos(a)))
        return self.flat(name, slot, gi, pts, frame_from(center, normal, up), thick)

    # ------------------------------------------------------------ peinture
    def paint_where(self, me, pred, slot):
        attr = me.color_attributes[dd.COLOR_ATTR]
        for poly in me.polygons:
            if pred(poly.center, poly.normal):
                for li in poly.loop_indices:
                    attr.data[li].color_srgb = self.C[slot]

    def clean_islands(self, me, slot_a, slot_b, passes=2):
        attr = me.color_attributes[dd.COLOR_ATTR]
        ca, cb = Vector(self.C[slot_a][:3]), Vector(self.C[slot_b][:3])
        bm = bmesh.new()
        bm.from_mesh(me)
        bm.faces.ensure_lookup_table()
        for _ in range(passes):
            col = [Vector(attr.data[me.polygons[f.index].loop_indices[0]].color_srgb[:3]) for f in bm.faces]
            is_a = [(c - ca).length < 0.02 for c in col]
            is_b = [(c - cb).length < 0.02 for c in col]
            for f in bm.faces:
                nb = {g.index for e in f.edges for g in e.link_faces if g.index != f.index}
                for mine, other, rgba in ((is_a, is_b, self.C[slot_b]), (is_b, is_a, self.C[slot_a])):
                    if mine[f.index] and sum(other[i] for i in nb) >= len(nb) - 1 and len(nb) >= 3:
                        for li in me.polygons[f.index].loop_indices:
                            attr.data[li].color_srgb = rgba
        bm.free()

    # ------------------------------------------------------------ corps
    def build_body(self):
        cfg = self.cfg
        body = dd.skin_body(cfg.NAME + "_Corps", cfg.NODES, self.col, branch_smoothing=getattr(cfg, "BRANCH", 0.7),
                            subdiv=getattr(cfg, "SUBDIV", 1), smooth_iters=getattr(cfg, "SMOOTH", 1), root="nez")
        self.body = body
        me = body.data
        dd.fill_color(me, self.C[MAIN])
        dd.paint_ventral(me, cfg.NODES, self.spine, self.C[BELLY], cos_min=getattr(cfg, "BELLY_COS", 0.6),
                         limbs=LIMBS, max_x=getattr(cfg, "BELLY_MAX_X", 0.40))
        chin = getattr(cfg, "CHIN_Y", None)
        if chin is not None:
            self.paint_where(me, lambda c, n: c.y < chin, MAIN)
        self.clean_islands(me, BELLY, MAIN)
        # Dos plus foncé (slot 7) : dessus du tronc et de la queue, membres exclus
        bz, bx, bzmin, bymin = getattr(cfg, "BACK_PAINT", (0.42, 0.5, 0.0, -99.0))
        pos, rad = self.pos, self.rad

        def is_back(c, n):
            if n.z <= bz or abs(c.x) >= bx or c.z <= bzmin or c.y <= bymin:
                return False
            q = Vector((abs(c.x), c.y, c.z))
            return min(pos, key=lambda k: (pos[k] - q).length / rad[k]) not in LIMBS
        self.paint_where(me, is_back, BACK)
        self.clean_islands(me, BACK, MAIN)
        if hasattr(cfg, "paint"):
            cfg.paint(self, me)
        self.cut_mouth(body)
        self.parts.insert(0, body)
        return body

    def cut_mouth(self, body):
        cfg = self.cfg
        Y0 = cfg.MOUTH_Y0
        Pm = Vector(cfg.MOUTH_P)
        N = Vector(cfg.MOUTH_N).normalized()
        gap = cfg.MOUTH_GAP
        zmin = Pm.z - getattr(cfg, "JAW_DEPTH", 0.7)
        me = body.data
        bm = bmesh.new()
        bm.from_mesh(me)

        def dist(co):
            return (co - Pm).dot(N)

        def front(f):
            c = f.calc_center_median()
            return c.y < Y0 and c.z > zmin

        for off in (0.0, gap):
            faces = [f for f in bm.faces if front(f)]
            geom = list({g for f in faces for g in (*f.verts, *f.edges)}) + faces
            bmesh.ops.bisect_plane(bm, geom=geom, plane_co=Pm + N * off, plane_no=N, dist=1e-5)

        fl = bm.faces.layers.int.new("dd_mpaint")  # couches créées avant de garder des références BMesh
        vl = bm.verts.layers.int.new("dd_low")

        def on(v):
            return abs(dist(v.co)) < 1e-4

        cut = [e for e in bm.edges if on(e.verts[0]) and on(e.verts[1]) and len(e.link_faces) == 2
               and all(front(f) for f in e.link_faces)]
        deg = {}
        for e in cut:
            for v in e.verts:
                deg[v] = deg.get(v, 0) + 1
        ends = [v for v, n in deg.items() if n == 1]
        assert len(ends) == 2 and max(deg.values()) == 2, ("coupe de bouche non continue", len(ends), len(cut))
        eL, eR = sorted(ends, key=lambda v: -v.co.x)
        # bande de la lèvre (trait de bouche) : faces entre les 2 plans
        for f in bm.faces:
            if front(f) and 0 < dist(f.calc_center_median()) < gap:
                f[fl] = 1
        bmesh.ops.split_edges(bm, edges=cut)
        bnd = [e for e in bm.edges if e.is_boundary and on(e.verts[0]) and on(e.verts[1])]
        up = [e for e in bnd if dist(e.link_faces[0].calc_center_median()) > 0]
        lo = [e for e in bnd if dist(e.link_faces[0].calc_center_median()) < 0]

        def chain(edges, start):
            adj = {}
            for e in edges:
                for v in e.verts:
                    adj.setdefault(v, []).append(e)
            seq, used, cur = [start], set(), start
            while True:
                nxt = [e for e in adj.get(cur, []) if e not in used]
                if not nxt:
                    break
                used.add(nxt[0])
                cur = nxt[0].other_vert(cur)
                seq.append(cur)
            assert len(used) == len(edges) and cur is eR, ("chaîne de lèvre", len(used), len(edges))
            return seq

        upc, loc_ = chain(up, eL), chain(lo, eL)
        for v in loc_[1:-1]:
            v.co -= N * 0.004  # évite la refusion des lèvres (remove_doubles) ; invisible
        for v in bm.verts:  # dd_low : 1 = mâchoire (avant la courbe du sourire)
            if v.co.y < Y0 + 0.15 and v.co.z > zmin and dist(v.co) < -1e-6:
                v[vl] = 1
        # Sourire : commissures relevées (fondu le long de la bouche et autour de la fente), comme le pilote v2
        lift, span = getattr(cfg, "SMILE_LIFT", (0.10, 0.5))

        def sm(x):
            x = clamp01(x)
            return x * x * (3 - 2 * x)
        for v in bm.verts:
            dz = lift * sm((v.co.y - (Y0 - span)) / span) * (1 - sm((v.co.y - Y0) / 0.3))
            if dz:
                v.co.z += dz * math.exp(-(dist(v.co) / 0.16) ** 2)
        dep_up = getattr(cfg, "PALATE", 0.16)
        dep_lo = getattr(cfg, "FLOOR", 0.16)
        cen_u = sum((v.co for v in upc), Vector()) / len(upc)
        cen_l = sum((v.co for v in loc_), Vector()) / len(loc_)
        cu = bm.verts.new(cen_u + N * dep_up)
        cl = bm.verts.new(cen_l - N * dep_lo)
        for seq, c, code in ((upc, cu, 2), (loc_, cl, 3)):
            ring = seq + [seq[0]]
            for a, b in zip(ring, ring[1:]):
                f = bm.faces.new((c, a, b))
                f[fl] = code
        cl[vl] = 1
        self.mi = {"upper": [v.co.copy() for v in upc], "lower": [v.co.copy() for v in loc_],
                   "cu": cen_u.copy(), "cl": cen_l.copy(), "floor": cen_l - N * dep_lo, "N": N, "eL": eL.co.copy()}
        bmesh.ops.recalc_face_normals(bm, faces=bm.faces)
        bm.to_mesh(me)
        bm.free()
        me.update()
        mp = me.attributes["dd_mpaint"].data
        attr = me.color_attributes[dd.COLOR_ATTR]
        lip = getattr(cfg, "LIP_SLOT", DARK)
        for poly in me.polygons:
            code = mp[poly.index].value
            if code:
                for li in poly.loop_indices:
                    attr.data[li].color_srgb = self.C[lip if code == 1 else MOUTH]

    # ------------------------------------------------------------ bouche : dents, langue, sourire
    def mouth_parts(self, n_up=6, n_lo=4, size=0.10, inset=0.05, smile=0.0, tongue=True, fangs=None):
        mi, N = self.mi, self.mi["N"]
        g_head, g_jaw = self.grp("rigid", "Head"), self.grp("rigid", "Jaw")

        def picks(seq, n):
            L = len(seq)
            out = []
            for k in range(n):
                t = 0.18 + 0.64 * (k + 0.5) / n
                out.append(seq[int(t * (L - 1))])
            return out

        for k, p in enumerate(picks(mi["upper"], n_up)):
            q = p + (mi["cu"] - p).normalized() * inset
            self.cone_to("Dent%d" % k, WHITE, g_head, q + N * 0.02, -N, size, size * 0.42, segments=4)
        for k, p in enumerate(picks(mi["lower"], n_lo)):
            q = p + (mi["cl"] - p).normalized() * inset
            self.cone_to("DentBas%d" % k, WHITE, g_jaw, q - N * 0.02, N, size * 0.8, size * 0.38, segments=4)
        if tongue:
            lo = mi["lower"]
            ys = [v.y for v in lo]
            xs = [abs(v.x) for v in lo]
            length = (max(ys) - min(ys)) * 0.62
            c = mi["floor"] + N * (self.cfg.FLOOR if hasattr(self.cfg, "FLOOR") else 0.16) * 0.45
            c.y = min(ys) + length * 0.62
            self.ellipsoid("Langue", TONGUE, g_jaw, c, (0, -1, 0), length, (max(xs) * 0.45, 0.06), u=10, v=6)
        if smile:
            e = mi["eL"]
            loc, nor = self.surf(e + Vector((0.05, 0.02, 0.0)))
            pts_t, pts_b = [], []
            for i in range(6):
                t = i / 5
                x, y = t * smile, (t * t) * smile * 0.55
                w = 0.022 * (1 - 0.6 * t)
                pts_t.append((x, y + w))
                pts_b.append((x, y - w))
            outline = pts_b + list(reversed(pts_t))
            M = frame_from(loc + nor * 0.004, nor, (0, 0, 1))
            ob = self.flat("Sourire", getattr(self.cfg, "LIP_SLOT", DARK), g_head, outline, M, 0.02)
            mirror_inplace(ob)
        if fangs:  # crocs visibles bouche fermée : liste de (y, longueur, slot)
            for k, (y, L, slot) in enumerate(fangs):
                p = min(mi["upper"], key=lambda v: abs(v.y - y) + (0 if v.x > 0 else 9))
                loc, nor = self.surf(p + Vector((0.02, 0, 0)))
                base = loc - nor * 0.02 + N * 0.03
                ob = self.cone_to("Croc%d" % k, slot, g_head, base, -N + nor * 0.15, L, L * 0.3, segments=5)
                mirror_inplace(ob)

    # ------------------------------------------------------------ yeux
    def eyes(self, target, size, look=(0.4, -1.0, 0.1), iris=GLOW, iris_r=0.64, pupil_r=0.34, sink=0.30,
             squash=1.12, brow=None, brow_slot=MAIN, pupil_shape=None, extra=None):
        g_head = self.grp("rigid", "Head")
        _ok, loc, nor, _ = self.body.closest_point_on_mesh(Vector(target))
        ec = loc - nor * size * sink
        lk = (nor + Vector(look)).normalized()
        obs = [self.P("Oeil", "sphere", WHITE, g_head, loc=ec, scale=(size, size, size * squash), u=12, v=7)]
        fr = frame_from(ec + lk * size * 0.93, lk)
        obs.append(self.P("Iris", "cone", iris, g_head, M=fr, segments=16, r1=size * iris_r, r2=size * iris_r,
                          depth=0.04))
        if pupil_shape is None:
            obs.append(self.P("Pupille", "cone", DARK, g_head, M=fr @ Matrix.Translation((0, 0, 0.015)), segments=12,
                              r1=size * pupil_r, r2=size * pupil_r, depth=0.05))
        else:  # contour 2D (pupille fendue, etc.)
            obs.append(self.flat("Pupille", DARK, g_head, [(x * size, y * size) for x, y in pupil_shape],
                                 fr @ Matrix.Translation((0, 0, 0.018)), 0.05))
        obs.append(self.P("Reflet", "sphere", WHITE, g_head, M=fr @ Matrix.Translation((-size * 0.2, size * 0.26, 0.05)),
                          scale=(size * 0.2, size * 0.2, 0.04), u=8, v=4))
        obs.append(self.P("Reflet2", "sphere", WHITE, g_head, M=fr @ Matrix.Translation((size * 0.22, -size * 0.2, 0.05)),
                          scale=(size * 0.09, size * 0.09, 0.03), u=6, v=4))
        if brow is not None:  # (inclinaison en degrés : > 0 = air fâché, < 0 = air inquiet), hauteur, longueur
            tilt, hgt, ln = brow
            fb = frame_from(ec, lk, (0, 0, 1))
            M = fb @ Matrix.Translation((0, size * hgt, size * 0.62)) @ Matrix.Rotation(math.radians(tilt), 4, "Z")
            obs.append(self.P("Sourcil", "sphere", brow_slot, g_head, M=M, scale=(size * ln, size * 0.17, size * 0.2),
                              u=8, v=5))
        if extra:
            obs += extra(self, ec, lk, fr, size) or []
        self.mirror(obs)
        self.eye_info = (ec, lk, size)
        return ec, lk

    # ------------------------------------------------------------ mains et pieds
    def hands(self, n=3, length=0.2, r=0.055, claw=WHITE, spread=24, claw_len=0.12, slot=MAIN, down=0.35):
        g = self.grp("rigid", "LowerArm.S")
        h, c = self.pos["main"], self.pos["coude"]
        d = (h - c).normalized()
        lat = Vector((1, 0, 0))
        lat = (lat - d * lat.dot(d)).normalized()
        ax = d.cross(lat)
        base = h + d * self.rad["main"] * 0.35
        obs = []
        angs = [0.0] if n == 1 else [spread * (i / (n - 1) * 2 - 1) for i in range(n)]
        for i, a in enumerate(angs):
            di = (Matrix.Rotation(math.radians(a), 3, ax) @ d).normalized()
            di = (di + Vector((0, 0, -down * 0.4))).normalized()
            Lk = length * (1.0 if i == len(angs) // 2 else 0.85)
            obs.append(self.ellipsoid("Doigt%d" % i, slot, g, base + di * Lk * 0.5, di, Lk, r, u=6, v=5))
            tip = base + di * Lk * 0.9
            obs.append(self.cone_to("GriffeMain%d" % i, claw, g, tip, di + Vector((0, 0, -down)), claw_len, r * 0.75,
                                    segments=5))
        self.mirror(obs)

    def feet(self, n=3, length=0.3, r=0.1, claw=WHITE, spread=28, claw_len=0.14, slot=MAIN, toe_node="orteils", back=0.0):
        g = self.grp("rigid", "Toe.S")
        o = self.pos[toe_node]
        base = Vector((o.x, o.y + self.rad[toe_node] * 0.2 + back, o.z - self.rad[toe_node] + r))
        obs = []
        angs = [0.0] if n == 1 else [spread * (i / (n - 1) * 2 - 1) for i in range(n)]
        for i, a in enumerate(angs):
            di = Matrix.Rotation(math.radians(a), 3, "Z") @ Vector((0, -1, 0))
            Lk = length * (1.0 if i == len(angs) // 2 else 0.82)
            c = base + di * Lk * 0.5
            obs.append(self.ellipsoid("Orteil%d" % i, slot, g, c, di, Lk, (r, r * 0.85), u=7, v=5))
            tip = base + di * Lk * 0.92 + Vector((0, 0, -r * 0.25))
            obs.append(self.cone_to("Griffe%d" % i, claw, g, tip, di + Vector((0, 0, -0.35)), claw_len, r * 0.6,
                                    segments=5))
        self.mirror(obs)


# ------------------------------------------------------------------ finalisation (comme le pilote)

def assign_slots(B, ob):
    me = ob.data
    attr = me.color_attributes[dd.COLOR_ATTR]
    pal = [(s, Vector(B.C[s][:3])) for s in range(1, 10)]
    slots = []
    for p in me.polygons:
        c = Vector(attr.data[p.loop_indices[0]].color_srgb[:3])
        slots.append(min(pal, key=lambda e: (e[1] - c).length)[0])
    a = me.attributes.get("dd_slot") or me.attributes.new("dd_slot", "INT", "FACE")
    a.data.foreach_set("value", slots)
    for p, s in zip(me.polygons, slots):
        for li in p.loop_indices:
            attr.data[li].color_srgb = B.C[s]
    return {s: slots.count(s) for s in set(slots)}


def build_mesh(B):
    cfg = B.cfg
    sc, col, rcol = dd.setup_scene("DD_" + cfg.NAME, cfg.NAME)
    B.col = col
    B.build_body()
    cfg.accessories(B)
    ob = dd.finalize(B.parts, B.id + "_Mesh", "M_" + B.id, target_height=cfg.HEIGHT)
    m = skel_matrix(ob)
    fy = (m @ B.pos["cheville"].lerp(B.pos["orteils"], 0.5)).y
    T = Matrix.Translation((0, -fy, 0))
    ob.data.transform(T)
    ob["dd_skel_matrix"] = [v for row in (T @ m) for v in row]
    B.slot_counts = assign_slots(B, ob)
    split_sharp(ob, getattr(B.cfg, "SHARP", 50.0))  # SHARP petit = facettes plates (style « plaques »)
    st = dd.stats(ob)
    assert st["triangles"] <= getattr(cfg, "TRI_BUDGET", 5000), st
    return sc, col, rcol, ob, st


def skel_matrix(ob):
    v = list(ob["dd_skel_matrix"])
    return Matrix([v[0:4], v[4:8], v[8:12], v[12:16]])


# ------------------------------------------------------------------ rig

def tail_points(B, nt):
    p = B.pos
    poly = [p["hanche"].lerp(p[B.tails[0]], 0.5)] + [p[k] for k in B.tails]
    acc = [0.0]
    for a, b in zip(poly, poly[1:]):
        acc.append(acc[-1] + (b - a).length)

    def at(d):
        for k in range(len(poly) - 1):
            if d <= acc[k + 1] + 1e-9:
                return poly[k].lerp(poly[k + 1], (d - acc[k]) / (acc[k + 1] - acc[k]))
        return poly[-1].copy()
    return [at(acc[-1] * i / nt) for i in range(nt + 1)]


def bone_specs_skel(B):
    cfg = B.cfg
    p = B.pos
    nt = getattr(cfg, "NT", 5)
    h, v, e = p["hanche"], p["ventre"], p["epaules"]
    hv, ve = h.lerp(v, 0.5), v.lerp(e, 0.5)
    N = Vector(cfg.MOUTH_N).normalized()
    Pm = Vector(cfg.MOUTH_P)
    jh = Vector((0, cfg.MOUTH_Y0 + 0.12, 0))
    jh.z = Pm.z + (N.y * (Pm.y - jh.y)) / N.z - 0.06
    jt = Vector((0, p["nez"].y - 0.1, 0))
    jt.z = Pm.z + (N.y * (Pm.y - jt.y)) / N.z - 0.12
    s = [
        ("Hips", h, hv, "Root", False, True),
        ("Spine1", hv, ve, "Hips", True, True),
        ("Spine2", ve, e, "Spine1", True, True),
        ("Neck1", e, p["cou"], "Spine2", True, True),
        ("Neck2", p["cou"], p["cou2"], "Neck1", True, True),
        ("Head", p["cou2"], p["nez"], "Neck2", True, True),
        ("Jaw", jh, jt, "Head", False, True),
    ]
    tail = tail_points(B, nt)
    for i in range(nt):
        s.append(("Tail%d" % (i + 1), tail[i], tail[i + 1], "Hips" if i == 0 else "Tail%d" % i, i > 0, True))
    for name, hd, tl, par in getattr(cfg, "EXTRA_BONES", []):
        s.append((name, Vector(hd), Vector(tl), par, False, True))
    for side, sx in SIDES:
        def q(k):
            w = p[k].copy()
            w.x *= sx
            return w
        legs = [q(k) for k in ("cuisse", "genou", "cheville", "pied", "orteils")]
        for i, n in enumerate(LEG):
            s.append(("%s.%s" % (n, side), legs[i], legs[i + 1], "Hips" if i == 0 else "%s.%s" % (LEG[i - 1], side),
                      i > 0, True))
        sh, el, ha = q("epaule"), q("coude"), q("main")
        s += [("UpperArm." + side, sh, el, "Spine2", False, True),
              ("LowerArm." + side, el, ha + (ha - el) * 0.35, "UpperArm." + side, True, True)]
    return s


def rig_mesh(B, col, ob):
    cfg = B.cfg
    nt = getattr(cfg, "NT", 5)
    trunk = ["Hips", "Spine1", "Spine2", "Neck1", "Neck2", "Head"] + ["Tail%d" % i for i in range(1, nt + 1)]
    m = skel_matrix(ob)
    skel = bone_specs_skel(B)
    specs = [("Root", Vector((0, 0, 0)), Vector((0, 0, 0.8)), None, False, False)]
    specs += [(n, m @ hd, m @ tl, par, con, dfm) for n, hd, tl, par, con, dfm in skel]
    arm = R.build_armature(col, B.id + "_Armature", specs)
    segs = {n: (hd, tl) for n, hd, tl, *_ in skel}
    minv = m.inverted()
    me = ob.data
    S = [minv @ v.co for v in me.vertices]
    G = [d.value for d in me.attributes["dd_grp"].data]
    low = [d.value for d in me.attributes["dd_low"].data]
    isl = rig.islands(me)
    region = [None] * len(me.vertices)
    for g in isl:
        if G[g[0]] != 0:
            continue
        c = sum((S[i] for i in g), Vector()) / len(g)
        c.x = abs(c.x)
        node = min(cfg.NODES, key=lambda n: (Vector(n[1]) - c).length / B.rad[n[0]])[0]
        kind = "leg" if node in LEG_NODES else "arm" if node in ARM_NODES else "trunk"
        for i in g:
            region[i] = kind
    sigma = getattr(cfg, "SIGMA", 0.07)
    Y0 = cfg.MOUTH_Y0
    extra_w = getattr(cfg, "TRUNK_EXTRA", {})  # os supplémentaires mêlés au tronc (ex. crête souple)
    W = []
    for i, s in enumerate(S):
        side = "L" if s.x > 0 else "R"
        gi = G[i]
        if gi == 0:
            kind = region[i]
            if kind == "leg":
                bones = ["%s.%s" % (n, side) for n in LEG] + ["Hips"]
            elif kind == "arm":
                bones = ["%s.%s" % (n, side) for n in ARMB] + ["Spine2"]
            else:
                bones = trunk
            wd = R.dist_weights(s, bones, segs, sigma)
            if kind == "trunk" and low[i]:
                jw = clamp01((Y0 + 0.12 - s.y) / 0.3)
                if jw > 0:
                    wd = {k: w * (1 - jw) for k, w in wd.items()}
                    wd["Jaw"] = wd.get("Jaw", 0.0) + jw
        else:
            kind, b = B.groups[gi]
            if kind == "rigid":
                wd = {b.replace(".S", "." + side): 1.0}
            else:
                wd = R.dist_weights(s, [x.replace(".S", "." + side) for x in b], segs, sigma)
        W.append(wd)
    info = R.apply_weights(ob, arm, W)
    assert info["max_influences"] <= 4 and info["sans_poids"] == 0, info
    assert not info["os_deformants_sans_poids"], info
    return arm, m[0][0], info


# ------------------------------------------------------------------ animations génériques (t dans [0, 1])

class Anims:
    """Poses génériques d'un théropode cartoon (anticipation + suivi). Les dinos surchargent idle (personnalité)
    et peuvent régler l'amplitude via les attributs de classe ou ajouter leurs os dans extra()."""
    HEAVY = 0.0  # 0 = léger et nerveux, 1 = lourd (T-rex) : bonds plus bas, gestes plus lents
    ARM_SCALE = 1.0
    JAW_OPEN = 48.0
    FALL_LIFT = 0.8  # remontée des hanches pendant la chute (le pied du côté de la chute ne traverse pas le sol)

    def __init__(self, arm, u, B):
        self.arm, self.u, self.P, self.B = arm, u, arm.pose.bones, B
        self.nt = getattr(B.cfg, "NT", 5)
        self.drop = 0.0
        self.names = {b.name for b in arm.data.bones}

    def base(self):
        rig.reset_pose(self.arm)
        return self.P

    def r(self, name, *ax):
        if name in self.names:
            rig.rot(self.P[name], *ax)

    def hips(self, x=0.0, y=0.0, z=0.0, rx=0.0, ry=0.0, rz=0.0):
        u = self.u
        rig.loc(self.P["Hips"], (x * u, y * u, z * u))
        rig.rot(self.P["Hips"], (R.X, rx), (R.Y, ry), (R.Z, rz))

    def tail(self, fn):
        k = 6.0 / self.nt
        for i in range(self.nt):
            rig.rot(self.P["Tail%d" % (i + 1)], *[(ax, deg * k) for ax, deg in fn(i * k)])

    def arms(self, up, low, spread=0.0, side_sign=None):
        for side, sx in SIDES:
            a = self.ARM_SCALE
            rig.rot(self.P["UpperArm." + side], (R.X, up * a), (R.Y, -sx * spread * a))
            rig.rot(self.P["LowerArm." + side], (R.X, low * a))

    def extra(self, clip, t):
        pass

    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        self.hips(z=-0.02 + 0.02 * br, rz=3 * R.S2(t, 1))
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, -1.5 * br))
        rig.rot(P["Neck1"], (R.X, 2 * br))
        rig.rot(P["Head"], (R.X, 3 * R.S2(t, 2, 0.3)), (R.Z, 10 * R.S2(t, 1, 0.25)))
        rig.rot(P["Jaw"], (R.X, 3 * max(0.0, br)))
        self.tail(lambda i: ((R.Z, 5 * R.S2(t, 1, -0.08 * i)), (R.X, 2 * R.S2(t, 2, -0.1 * i))))
        self.arms(-8 * R.S2(t, 2, 0.1), -10 * R.S2(t, 2, 0.2))
        self.extra("Idle", t)

    def walk(self, t):
        P = self.base()
        hv = 1 - 0.5 * self.HEAVY
        bob = math.cos(2 * math.pi * 2 * t)
        self.hips(z=-0.08 - 0.07 * bob * hv, rx=7 - 3 * self.HEAVY, rz=8 * R.S2(t, 1) * hv,
                  ry=(4 + 3 * self.HEAVY) * R.S2(t, 1, 0.25))
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.Z, -3 * R.S2(t, 1)), (R.X, 1.5 * bob))
        rig.rot(P["Neck1"], (R.X, -5 + 6 * R.S2(t, 2, 0.1) * hv))
        rig.rot(P["Neck2"], (R.X, -4 * R.S2(t, 2, 0.1) * hv))
        rig.rot(P["Head"], (R.X, -3 - 3 * R.S2(t, 2, 0.15)), (R.Z, -5 * R.S2(t, 1)))
        rig.rot(P["Jaw"], (R.X, 4 + 3 * max(0.0, -bob)))
        self.tail(lambda i: ((R.Z, -8 * R.S2(t, 1, -0.06 * (i + 1))), (R.X, 2 + 3 * R.S2(t, 2, -0.08 * i))))
        for side, sx in SIDES:
            sgn = 1 if side == "L" else -1
            rig.rot(P["UpperArm." + side], (R.X, 22 * R.S2(t, 1, 0.25) * sgn * self.ARM_SCALE))
            rig.rot(P["LowerArm." + side], (R.X, (14 * R.S2(t, 1, 0.35) * sgn - 10) * self.ARM_SCALE))
        self.extra("Walk", t)

    def run(self, t):
        P = self.base()
        low = math.cos(2 * math.pi * 2 * (t - 0.17))
        self.hips(z=-0.12 - 0.14 * low * (1 - 0.4 * self.HEAVY), rx=13 - 4 * self.HEAVY, rz=6 * R.S2(t, 1))
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, 2 * low))
        rig.rot(P["Neck1"], (R.X, -10 + 4 * low))
        rig.rot(P["Neck2"], (R.X, -4))
        rig.rot(P["Head"], (R.X, -4 - 4 * low), (R.Z, -3 * R.S2(t, 1)))
        rig.rot(P["Jaw"], (R.X, 14 + 6 * low))
        self.tail(lambda i: ((R.Z, -5 * R.S2(t, 1, -0.07 * (i + 1))), (R.X, -2.5 + 3 * R.S2(t, 2, -0.1 * (i + 1)))))
        self.arms(40 + 8 * low, -55)
        self.extra("Run", t)

    def attack(self, t):
        P = self.base()
        a = R.keys(t, [(0, 0), (0.28, 1), (0.36, 0), (1, 0)])
        s = R.keys(t, [(0, 0), (0.28, 0), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
        s2 = R.keys(t, [(0, 0), (0.34, 0), (0.46, 1), (0.62, 1), (0.92, 0), (1, 0)])
        j = R.keys(t, [(0, 0), (0.25, 0.3), (0.36, 1), (0.43, 0), (0.5, 0.2), (0.65, 0), (1, 0)])
        self.hips(y=0.25 * a - 0.55 * s, z=-0.32 * a + 0.22 * s * (1 - 0.6 * self.HEAVY), rx=-10 * a + 16 * s)
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, 4 * a - 3 * s))
        rig.rot(P["Neck1"], (R.X, -18 * a + 14 * s))
        rig.rot(P["Neck2"], (R.X, -8 * a + 6 * s))
        rig.rot(P["Head"], (R.X, -12 * a - 6 * s))
        rig.rot(P["Jaw"], (R.X, (self.JAW_OPEN + 4) * j))
        self.tail(lambda i: ((R.X, 7 * a - 6 * s2 + 3 * s), (R.Z, 4 * s2 * R.S2(t, 2))))
        for side, sx in SIDES:
            rig.rot(P["UpperArm." + side], (R.X, (-55 * a - 35 * s) * self.ARM_SCALE), (R.Y, -sx * 20 * a))
            rig.rot(P["LowerArm." + side], (R.X, (-40 * a + 35 * s) * self.ARM_SCALE))
        self.extra("Attack", t)

    def attack_feet(self, side, t, ank, toe):
        s = R.keys(t, [(0, 0), (0.3, 0), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
        if side == "R" and self.HEAVY < 0.5:  # coup de griffe du pied vers l'avant
            off = Vector((0, -0.8 * s * self.u, 0.55 * s * self.u))
            return ank + off, toe + off + Vector((0, 0, 0.2 * s * self.u))
        return ank, toe

    def roar(self, t):
        P = self.base()
        a = R.keys(t, [(0, 0), (0.16, 1), (0.26, 0), (1, 0)])
        r = R.keys(t, [(0, 0), (0.18, 0), (0.3, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * R.S2(t, 7)
        self.hips(z=-0.16 * a + 0.06 * r, rx=8 * a - 10 * r)
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, 3 * a - 4 * r))
        rig.rot(P["Neck1"], (R.X, 16 * a - 12 * r))
        rig.rot(P["Neck2"], (R.X, 10 * a - 10 * r))
        rig.rot(P["Head"], (R.X, 18 * a - 18 * r + 4 * sh), (R.Z, 7 * sh))
        rig.rot(P["Jaw"], (R.X, 6 * a + self.JAW_OPEN * r))
        self.tail(lambda i: ((R.X, -4 * a + 6 * r), (R.Z, 3 * R.S2(t, 7, -0.1 * i) * r)))
        for side, sx in SIDES:
            rig.rot(P["UpperArm." + side], (R.X, (-20 * a - 55 * r) * self.ARM_SCALE), (R.Y, -sx * 35 * r))
            rig.rot(P["LowerArm." + side], (R.X, -30 * r * self.ARM_SCALE))
        self.extra("Roar", t)

    def hop(self, t):
        h1 = math.sin(math.pi * (t - 0.12) / 0.26) if 0.12 < t < 0.38 else 0.0
        h2 = math.sin(math.pi * (t - 0.50) / 0.26) if 0.50 < t < 0.76 else 0.0
        sq = sum(math.exp(-((t - c) / 0.035) ** 2) for c in (0.1, 0.4, 0.48, 0.78))
        return h1 + h2, sq

    def celebrate(self, t):
        P = self.base()
        air, sq = self.hop(t)
        hv = 1 - 0.5 * self.HEAVY
        joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
        self.hips(z=0.75 * air * hv - 0.22 * sq, rx=-10 * air + 6 * sq, rz=6 * R.S2(t, 2) * joy)
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, -3 * air + 3 * sq))
        rig.rot(P["Neck1"], (R.X, -10 * air * joy + 8 * sq))
        rig.rot(P["Head"], (R.X, -8 * joy), (R.Y, 14 * R.S2(t, 2) * joy))
        rig.rot(P["Jaw"], (R.X, 30 * joy))
        self.tail(lambda i: ((R.Z, 16 * R.S2(t, 3, -0.07 * i) * joy), (R.X, 8 * air - 4 * sq)))
        for side, sx in SIDES:
            w = R.S2(t, 5, 0 if side == "L" else 0.5) * joy
            rig.rot(P["UpperArm." + side], (R.X, (-60 + 25 * w) * joy * self.ARM_SCALE), (R.Y, -sx * 30 * joy))
            rig.rot(P["LowerArm." + side], (R.X, -30 * w * self.ARM_SCALE))
        self.extra("Celebrate", t)

    def celebrate_feet(self, side, t, ank, toe):
        air, _sq = self.hop(t)
        off = Vector((0, 0, 0.6 * air * self.u * (1 - 0.5 * self.HEAVY)))
        return ank + off, toe + off + Vector((0, 0, -0.1 * air * self.u))

    def death(self, t):
        P = self.base()
        h = R.keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = R.S2(t, 3) * R.keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        f = R.keys(t, [(0, 0), (0.36, 0), (0.62, 1), (0.71, 0.9), (0.8, 1), (1, 1)])
        self.hips(y=0.3 * h, z=-self.drop * f + 1.4 * f * (1 - f) * self.FALL_LIFT, rx=-12 * h, rz=8 * w, ry=-80 * f)
        rig.rot(P["Spine2"], (R.Z, 6 * f))
        rig.rot(P["Neck1"], (R.X, -14 * h + 8 * f), (R.Z, -12 * f))
        rig.rot(P["Neck2"], (R.Z, -10 * f))
        rig.rot(P["Head"], (R.X, -16 * h + 10 * f), (R.Z, -14 * f), (R.Y, 10 * w))
        rig.rot(P["Jaw"], (R.X, 30 * h + 22 * f))
        self.tail(lambda i: ((R.Z, -5 * f + 4 * w), (R.X, -2 * f)))
        for side, sx in SIDES:
            k = 1.0 if side == "R" else 0.6
            rig.rot(P["UpperLeg." + side], (R.X, -30 * f * k - 10 * h))
            rig.rot(P["LowerLeg." + side], (R.X, 40 * f * k))
            rig.rot(P["Foot." + side], (R.X, -30 * f * k))
            rig.rot(P["UpperArm." + side], (R.X, -25 * h + 35 * f), (R.Y, sx * 15 * f))
            rig.rot(P["LowerArm." + side], (R.X, -20 * f))
        self.extra("Death", t)


CLIPS = [("Idle", 120, True), ("Walk", 30, True), ("Run", 16, True), ("Attack", 30, False),
         ("Roar", 44, False), ("Celebrate", 40, False), ("Death", 44, False)]


def animate(B, arm, col, u, mesh_ob, AnimCls):
    cfg = B.cfg
    A = AnimCls(arm, u, B)
    p = B.pos
    leg = (p["cuisse"] - p["genou"]).length + (p["genou"] - p["cheville"]).length
    step, lift = 0.95 * leg * u * getattr(cfg, "STEP", 1.0), 0.4 * leg * u
    rstep, rlift = 1.6 * leg * u * getattr(cfg, "STEP", 1.0), 0.55 * leg * u
    clips = getattr(cfg, "CLIPS", CLIPS)

    def cyc(side, t, ank, toe, st, lf, stance):
        ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
        if ph < stance:
            q = ph / stance
            dy, dz, drop = -st / 2 + st * q, 0.0, 0.0
        else:
            q = (ph - stance) / (1 - stance)
            sm = 0.5 - 0.5 * math.cos(math.pi * q)
            dy, dz, drop = st / 2 - st * sm, lf * math.sin(math.pi * q), 0.06 * u * math.sin(math.pi * q)
        off = Vector((0, dy, dz))
        return ank + off, toe + off - Vector((0, 0, drop))

    feet = {
        "Idle": getattr(A, "idle_feet", None) or (lambda s, t, a, b: (a, b)),
        "Walk": lambda s, t, a, b: cyc(s, t, a, b, step, lift, 0.5),
        "Run": lambda s, t, a, b: cyc(s, t, a, b, rstep, rlift, 0.36),
        "Attack": A.attack_feet,
        "Roar": lambda s, t, a, b: (a, b),
        "Celebrate": A.celebrate_feet,
        "Death": None,
    }
    acts, out = {}, {}
    for clip, length, loop in clips:
        act = R.make_action(arm, col, B.id, clip, length, loop, getattr(A, clip.lower()), feet[clip])
        if clip == "Death":  # descente des hanches réglée pour que le dino couché touche juste le sol
            arm.animation_data.action = act
            bpy.context.scene.frame_set(length)
            dg = bpy.context.evaluated_depsgraph_get()
            me = mesh_ob.evaluated_get(dg).to_mesh()
            lo = min(v.co.z for v in me.vertices)
            mesh_ob.evaluated_get(dg).to_mesh_clear()
            A.drop = lo / u
            act = R.make_action(arm, col, B.id, clip, length, loop, A.death, None)
        acts[clip] = act
        info = {"images": length, "boucle": loop, "min_z": round(R.min_z(mesh_ob, arm, act), 3)}
        if loop:
            info["erreur_boucle"] = round(R.loop_error(arm, act), 5)
        out[clip] = info
    return acts, out


# ------------------------------------------------------------------ rendus, sauvegarde

def frame_info(ob):
    co = [v.co for v in ob.data.vertices]
    ys = [c.y for c in co]
    zs = [c.z for c in co]
    return (min(ys) + max(ys)) / 2, max(ys) - min(ys), max(zs)


def setup_cam(B, sc, rcol, ob):
    cy, L, H = frame_info(ob)
    dd.setup_render(sc, rcol, target=(0, cy, H * 0.45), distance=12, azimuth=-40, height_ratio=0.3)
    sc.display.shading.show_cavity = False
    sc.display.shading.show_specular_highlight = True
    sc.display.shading.show_backface_culling = True  # comme Roblox
    sc.world.color = getattr(B.cfg, "BG", (0.16, 0.19, 0.27))
    B.view = (cy, max(L * 1.45, H * 2.0), H)


def render_still(B, sc, name, azimuth=-40, h=0.3, k=1.0, res=512):
    cy, dist, H = B.view
    rig.place_cam(sc, (0, cy, H * 0.45), azimuth, dist * k, h)
    sc.render.resolution_x = sc.render.resolution_y = res
    os.makedirs(RENDERS, exist_ok=True)
    return dd.render_to(sc, os.path.join(RENDERS, "%s_%s.png" % (B.id, name)))


def save_blend(B, sc):
    for s in list(bpy.data.scenes):
        if s != sc:
            for o in list(s.collection.all_objects):
                if len(o.users_scene) == 1:
                    bpy.data.objects.remove(o, do_unlink=True)
            bpy.data.scenes.remove(s)
    sc["dd_id"] = B.id
    sc["dd_colors"] = json.dumps(B.cfg.COLORS)
    path = os.path.join(PROJECT_DIR, "blender", "dinos", B.id + ".blend")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=path, check_existing=False)
    with open(os.path.join(PROJECT_DIR, "blender", "dinos", B.id + "_look.json"), "w", encoding="utf-8") as fh:
        json.dump(B.cfg.COLORS, fh)
    return path


def run(cfg):
    args = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    B = Builder(cfg)
    sc, col, rcol, ob, st = build_mesh(B)
    setup_cam(B, sc, rcol, ob)
    out = {"mesh": st, "slots": B.slot_counts}
    out["r34"] = render_still(B, sc, "34")
    out["rside"] = render_still(B, sc, "side", azimuth=-90, h=0.1)
    out["rfront"] = render_still(B, sc, "front", azimuth=0, h=0.15)
    if "model" in args:
        print("DD_RESULT", json.dumps(out))
        return
    arm, u, winfo = rig_mesh(B, col, ob)
    out["poids"] = winfo
    out["os"] = len(arm.data.bones)
    acts, out["clips"] = animate(B, arm, col, u, ob, cfg.Anims)
    tmp = os.path.join(bpy.app.tempdir or os.environ.get("TEMP", "."), "dd_" + B.id)
    only = [a for a in args if a[:1].isupper()]
    if "norender" not in args:
        for clip, _l, _loop in getattr(cfg, "CLIPS", CLIPS):
            if only and clip not in only:
                continue
            act = acts[clip]
            arm.animation_data.action = act
            L = int(act["dd_len"])
            n = 8
            frames = [round(i * L / (n if act["dd_loop"] else n - 1)) for i in range(n)]
            az = -90 if clip in ("Walk", "Run") else -40
            cy, dist, H = B.view
            rig.place_cam(sc, (0, cy, H * 0.42), az, dist * 1.12, 0.2)
            out["rendu_" + clip] = R.render_sheet(sc, frames, os.path.join(RENDERS, "%s_%s.png" % (B.id, clip.lower())),
                                                  tmp, size=256)
    arm.animation_data.action = acts["Idle"]
    sc.frame_set(0)
    out["fichier"] = save_blend(B, sc)
    print("DD_RESULT", json.dumps(out, default=str))
