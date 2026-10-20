# DINO DICE — outils partagés des dinos QUADRUPÈDES uniques (Modeler B).
# Version : 1
# Chaque build_<id>.py décrit seulement : NODES (demi-squelette Skin), bouche, yeux, palette, accessoires,
# os en plus et personnalité ; ce module fait le reste (corps, bouche ouvrable, yeux, ongles, rig 27 os,
# poids, 7 animations à 4 pattes en IK, rendus, .blend, <id>_look.json).
# Réutilise le pilote (build_chronoraptor : pièces, slots, nettoyage) et dd_dino_rig (armature, poids, actions).
#
# Clés imposées dans NODES : tronc « bassin, dos, poitrail, cou1, cou2, crane, ..., nez » (chaîne, racine « nez »),
# queue = S.TAIL (de la base vers la pointe) ; pattes en chaînes SÉPARÉES (îlots propres pour les poids) :
#   arrière « hanche > genou > cheville > pied_ar > orteil_ar », avant « epaule > coude > poignet > pied_av > orteil_av ».
# Rig : Root, Hips, Spine1-3, Neck1-3, Head, Jaw, Tail1-5, {UpperLeg, LowerLeg, Foot}{B,F}.{L,R} = 27 os (+ extras).

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
for p in (SCRIPTS_DIR, HERE):
    if p not in sys.path:
        sys.path.insert(0, p)
import dd_common as dd  # noqa: E402
import build_theropod_rig as rig  # noqa: E402
import dd_dino_rig as R  # noqa: E402
import build_chronoraptor as K  # noqa: E402  (pièces / slots du pilote ; K.C et K.COL pointés sur le dino courant)

RENDERS = os.path.join(PROJECT_DIR, "docs", "renders", "dinos")
MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, MOUTH, TONGUE = range(1, 10)
FIXED = {"white": "#FFFFFF", "pupil": "#1B1B22", "mouth": "#6A1B2A", "tongue": "#F06292"}
LEGS = ("BL", "FL", "BR", "FR")
HIND_NODES = ("hanche", "genou", "cheville", "pied_ar", "orteil_ar")
FRONT_NODES = ("epaule", "coude", "poignet", "pied_av", "orteil_av")
NT = 5
TRUNK = ["Hips", "Spine1", "Spine2", "Spine3", "Neck1", "Neck2", "Neck3", "Head"] + ["Tail%d" % i for i in range(1, NT + 1)]
S = None  # module du dino courant


def bn(part, leg):
    """Nom d'os de patte : bn('Upper', 'BL') -> 'UpperLegB.L' ; part in Upper/Lower/Foot."""
    return "%s%s.%s" % (part + ("Leg" if part != "Foot" else ""), leg[0], leg[1])


def palette(colors):
    hexes = [colors["main"], colors["belly"], colors["accent"], FIXED["white"], FIXED["pupil"], colors["glow"],
             colors["back"], FIXED["mouth"], FIXED["tongue"]]
    return [None] + [dd.hex_rgba(h) for h in hexes]


def P(name, kind, slot, bone, **kw):
    return K.P(name, kind, slot, gid(bone), **kw)


_GID = {}


def gid(bone):
    """Groupe d'os d'une pièce : 'Head' (rigide) ou ['A', 'B'] (poids par distance) ; '.S' = côté par signe de x."""
    key = bone if isinstance(bone, str) else tuple(bone)
    if key not in _GID:
        _GID[key] = K.grp("rigid", bone) if isinstance(bone, str) else K.grp("dist", list(bone))
    return _GID[key]


def flat(name, slot, bone, outline, M, thick, mirror_x=False):
    return K.flat_shape(name, slot, gid(bone), outline, M, thick, mirror_x)


def poly(name, slot, bone, outline, M):
    return K.flat_poly(name, slot, gid(bone), outline, M)


def node(key):
    return Vector(next(n[1] for n in S.NODES if n[0] == key))


def radius(key):
    return next(n[2] for n in S.NODES if n[0] == key)


# ------------------------------------------------------------------ bouche (version paramétrée de K.make_mouth)

def mouth_z(y):
    M = S.MOUTH
    n = Vector(M["n"]).normalized()
    return M["p"][2] + (-n.y / n.z) * (y - M["p"][1])


def smile_dz(y):
    M = S.MOUTH

    def sm(u):
        u = max(0.0, min(1.0, u))
        return u * u * (3 - 2 * u)
    return M.get("smile", 0.1) * sm((y - M["smile_y"]) / max(0.05, M["y0"] - M["smile_y"])) * \
        (1 - sm((y - M["y0"]) / 0.3))


def make_mouth(body):
    M = S.MOUTH
    Pm, Nm, Y0, GAP = Vector(M["p"]), Vector(M["n"]).normalized(), M["y0"], M.get("gap", 0.025)
    zmin = M.get("zmin", -1e9)
    me = body.data
    bm = bmesh.new()
    bm.from_mesh(me)

    def front(f):
        c = f.calc_center_median()
        return c.y < Y0 and c.z > zmin
    for off in (-GAP, GAP):
        geom = [f for f in bm.faces if front(f)]
        geom = list({g for f in geom for g in (*f.verts, *f.edges)}) + geom
        bmesh.ops.bisect_plane(bm, geom=geom, plane_co=Pm + Nm * off, plane_no=Nm)
    jaw = bm.verts.layers.float.new("dd_jaw")
    shell = bm.faces.layers.int.new("dd_shell")
    for v in bm.verts:
        v[jaw] = max(0.0, min(1.0, 0.5 - (v.co - Pm).dot(Nm) / (2 * GAP))) if v.co.z > zmin else 0.0
    bm.normal_update()
    band_h = M.get("shell", 0.42)
    src = [f for f in bm.faces if f.calc_center_median().y < Y0 + 0.15 and f.calc_center_median().z > zmin
           and abs((f.calc_center_median() - Pm).dot(Nm)) < band_h]
    dup = bmesh.ops.duplicate(bm, geom=src)
    dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
    dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
    for v in dverts:
        v.co -= v.normal * M.get("shell_depth", 0.05)
    bmesh.ops.reverse_faces(bm, faces=dfaces)
    for f in dfaces:
        f[shell] = 1
    # bande = faces entièrement entre les 2 coupes (une n-gone non coupée peut avoir son centre dans la bande)
    band = [f for f in bm.faces if not f[shell] and front(f)
            and all(abs((v.co - Pm).dot(Nm)) < GAP + 1e-4 for v in f.verts)]
    bmesh.ops.delete(bm, geom=band, context="FACES")
    for v in bm.verts:
        d = (v.co - Pm).dot(Nm)
        v.co.z += smile_dz(v.co.y) * math.exp(-(d / 0.18) ** 2)
    bm.to_mesh(me)
    bm.free()


def fix_shell_normals(ob):
    me = ob.data
    minv = skel_matrix(ob).inverted()
    bm = bmesh.new()
    bm.from_mesh(me)
    sh = bm.faces.layers.int.get("dd_shell")
    bm.normal_update()
    m3 = skel_matrix(ob).to_3x3()
    flip = []
    for f in bm.faces:
        if f[sh]:
            c = minv @ f.calc_center_median()
            axis = Vector((0, c.y, mouth_z(c.y)))
            if (m3.inverted() @ f.normal).dot(c - axis) > 0:
                flip.append(f)
    bmesh.ops.reverse_faces(bm, faces=flip)
    bm.to_mesh(me)
    bm.free()


def skel_matrix(ob):
    v = list(ob["dd_skel_matrix"])
    return Matrix([v[0:4], v[4:8], v[8:12], v[12:16]])


# ------------------------------------------------------------------ peinture

def spine_chain():
    return list(reversed(S.TAIL)) + ["bassin", "dos", "poitrail", "cou1", "cou2", "crane"] + S.HEAD_CHAIN


def limb_nodes():
    return set(HIND_NODES) | set(FRONT_NODES) | set(getattr(S, "EXTRA_LIMB_NODES", ()))


def paint_body(body):
    me = body.data
    C = K.C
    dd.fill_color(me, C[MAIN])
    dd.paint_ventral(me, S.NODES, spine_chain(), C[BELLY], cos_min=S.BELLY_COS, limbs=limb_nodes(),
                     max_x=S.BELLY_MAXX)
    attr = me.color_attributes[dd.COLOR_ATTR]
    bz = S.BACK_NZ
    for p in me.polygons:  # dos plus foncé : faces tournées vers le haut, sur le tronc
        if p.normal.z > bz and p.center.z > S.BACK_ZMIN and abs(p.center.x) < S.BACK_MAXX:
            for li in p.loop_indices:
                attr.data[li].color_srgb = C[BACK]
    K.clean_islands(me, BELLY, MAIN)
    K.clean_islands(me, BACK, MAIN)
    if hasattr(S, "paint"):
        S.paint(me, lambda p, slot: [setattr(attr.data[li], "color_srgb", C[slot]) for li in p.loop_indices])
    sh = me.attributes["dd_shell"].data
    for p in me.polygons:
        if sh[p.index].value:
            for li in p.loop_indices:
                attr.data[li].color_srgb = C[MOUTH]


# ------------------------------------------------------------------ pièces communes

def eyes(body, parts):
    E = S.EYE
    size = E["size"]
    _ok, loc, nor, _ = body.closest_point_on_mesh(Vector(E["target"]))
    ec = loc - nor * size * E.get("sink", 0.3)
    look = (nor + Vector(E.get("look", (-0.2, -1.4, 0.15)))).normalized()
    g = "Head"
    parts.append(P("Oeil", "sphere", WHITE, g, loc=ec, scale=(size, size, size * 1.1), mirror_x=True, u=12, v=8))
    fr = K.frame_from(ec + look * size * 0.95, look)
    n0 = len(parts)
    ir = E.get("iris", 0.62)
    parts.append(poly("Iris", E.get("iris_slot", GLOW), g, K.circle(size * ir, 16), fr))
    parts.append(poly("Pupille", DARK, g, K.circle(size * ir * 0.55, 14), fr @ Matrix.Translation((0, 0, 0.01))))
    parts.append(K.xform(P("Reflet", "sphere", WHITE, g, scale=(size * 0.2, size * 0.2, size * 0.1), u=6, v=4),
                         fr @ Matrix.Translation((-size * 0.2, size * 0.24, 0.04))))
    parts.append(K.xform(P("Reflet2", "sphere", WHITE, g, scale=(size * 0.09, size * 0.09, size * 0.05), u=6, v=4),
                         fr @ Matrix.Translation((size * 0.22, -size * 0.2, 0.035))))
    for ob in parts[n0:]:
        K.mirror_inplace(ob)
    lid = E.get("lid")  # paupière / sourcil : demi-dôme au-dessus de l'œil (angle de fermeture, os)
    if lid:
        bm = bmesh.new()
        bmesh.ops.create_uvsphere(bm, u_segments=12, v_segments=8, radius=size * 1.17)
        bmesh.ops.delete(bm, geom=[v for v in bm.verts if v.co.z < -1e-4], context="VERTS")
        bmesh.ops.holes_fill(bm, edges=[e for e in bm.edges if e.is_boundary], sides=0)
        side_ax = Vector((0, 0, 1)).cross(look).normalized()
        Mr = Matrix.Translation(ec) @ Matrix.Rotation(math.radians(lid["close"]), 4, side_ax) @ \
            Matrix.Rotation(math.radians(lid.get("tilt", 0)), 4, look)
        bmesh.ops.transform(bm, matrix=Mr, verts=bm.verts)
        me = bpy.data.meshes.new("Paupiere")
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, K.C[lid.get("slot", MAIN)])
        ob = bpy.data.objects.new("Paupiere", me)
        K.COL.objects.link(ob)
        K.tag(ob, gid(lid.get("bone", "Head")))
        K.mirror_inplace(ob)
        parts.append(ob)
    return ec, look


def nostrils(body, parts):
    for pnt, sc in S.NOSTRILS:
        parts.append(P("Narine", "sphere", DARK, "Head", loc=dd.snap(body, pnt, -0.01), scale=sc, mirror_x=True,
                       u=6, v=4))


def teeth_tongue(body, parts):
    """S.TEETH : liste (y, haut?, longueur, rayon, retrait_x) ; langue S.TONGUE_AT = (y, longueur, largeur)."""
    GAP = S.MOUTH.get("gap", 0.025)
    for y, upper, L, r, inset in S.TEETH:
        sign = -1 if upper else 1
        z = mouth_z(y) + smile_dz(y) - sign * (GAP + 0.01)
        _ok, sp, _n, _ = body.closest_point_on_mesh(Vector((2.0, y, z)))
        x = max(0.05, sp.x - inset)
        parts.append(P("Dent", "cone", WHITE, "Head" if upper else "Jaw", loc=(x, y, z + sign * L * 0.5 - sign * 0.01),
                       rot=(0 if sign > 0 else 180, 0, 0), mirror_x=True, segments=5, r1=r, r2=r * 0.15, depth=L))
    y, ln, w = S.TONGUE_AT
    parts.append(P("Langue", "sphere", TONGUE, "Jaw", loc=(0, y, mouth_z(y) - 0.1), scale=(w, ln, 0.07), u=10, v=6))


def nails(body, parts):
    """3 ongles arrondis à l'avant de chaque pied (+ symétrie)."""
    for keys, fb in ((HIND_NODES, "B"), (FRONT_NODES, "F")):
        pied, ort = node(keys[3]), node(keys[4])
        r = radius(keys[3])
        for dx in (-0.55, 0.0, 0.55):
            p = Vector((pied.x + dx * r, ort.y - radius(keys[4]) * (0.8 - 0.25 * abs(dx)), S.NAIL_Z))
            sp = dd.snap(body, p, -0.03)
            sp.z = max(sp.z, S.NAIL_Z)
            k = S.NAIL_SIZE
            parts.append(P("Ongle", "sphere", S.NAIL_SLOT, "Foot%s.S" % fb, loc=sp, scale=(k, k * 0.8, k * 0.75),
                           mirror_x=True, u=8, v=5))


def flatten_soles(body, z):
    for v in body.data.vertices:
        if v.co.z < z:
            v.co.z = z


# ------------------------------------------------------------------ maillage complet

def build_mesh():
    K.GROUPS[1:] = []
    _GID.clear()
    K.C = palette(S.COLORS)
    sc, col, rcol = dd.setup_scene("DD_" + S.NAME, S.NAME)
    K.COL = col
    body = dd.skin_body(S.NAME + "_Corps", S.NODES, col, branch_smoothing=0.7, subdiv=1,
                        smooth_iters=getattr(S, "SMOOTH", 1), root="nez")
    flatten_soles(body, S.SOLE_Z)
    if hasattr(S, "shape"):
        S.shape(body)
    make_mouth(body)
    paint_body(body)
    parts = [body]
    S.EYE_CENTER, S.EYE_LOOK = eyes(body, parts)
    nostrils(body, parts)
    teeth_tongue(body, parts)
    nails(body, parts)
    S.accessories(body, parts)
    tri_parts = {}
    for o in parts:
        o.data.calc_loop_triangles()
        k = o.name.split(".")[0]
        tri_parts[k] = tri_parts.get(k, 0) + len(o.data.loop_triangles)
    ob = dd.finalize(parts, S.ID + "_Mesh", "M_" + S.ID, target_height=S.HEIGHT, recalc_normals=False)
    m = skel_matrix(ob)
    fy = (m @ ((node("cheville") + node("poignet")) * 0.5)).y
    T = Matrix.Translation((0, -fy, 0))
    ob.data.transform(T)
    ob["dd_skel_matrix"] = [v for row in (T @ m) for v in row]
    fix_shell_normals(ob)
    K.assign_slots(ob)
    K.split_sharp(ob, 50.0)
    st = dd.stats(ob)
    st["par_piece"] = tri_parts
    return sc, col, rcol, ob, st


# ------------------------------------------------------------------ rig

def resample(poly_pts, n):
    acc = [0.0]
    for a, b in zip(poly_pts, poly_pts[1:]):
        acc.append(acc[-1] + (b - a).length)

    def at(d):
        for k in range(len(poly_pts) - 1):
            if d <= acc[k + 1] + 1e-9:
                return poly_pts[k].lerp(poly_pts[k + 1], (d - acc[k]) / (acc[k + 1] - acc[k]))
        return poly_pts[-1].copy()
    return [at(acc[-1] * i / n) for i in range(n + 1)]


def bone_specs_skel():
    b, d, pt = node("bassin"), node("dos"), node("poitrail")
    s = [
        ("Hips", b, b.lerp(d, 0.5), "Root", False, True),
        ("Spine1", b.lerp(d, 0.5), d, "Hips", True, True),
        ("Spine2", d, d.lerp(pt, 0.5), "Spine1", True, True),
        ("Spine3", d.lerp(pt, 0.5), pt, "Spine2", True, True),
        ("Neck1", pt, node("cou1"), "Spine3", True, True),
        ("Neck2", node("cou1"), node("cou2"), "Neck1", True, True),
        ("Neck3", node("cou2"), node("crane"), "Neck2", True, True),
        ("Head", node("crane"), node("nez"), "Neck3", True, True),
    ]
    y0 = S.MOUTH["y0"]
    yn = node("nez").y
    s.append(("Jaw", Vector((0, y0 + 0.2, mouth_z(y0) - 0.08)), Vector((0, yn, mouth_z(yn) - 0.12)), "Head", False,
              True))
    tail = resample([b.lerp(node(S.TAIL[0]), 0.5)] + [node(k) for k in S.TAIL], NT)
    for i in range(NT):
        s.append(("Tail%d" % (i + 1), tail[i], tail[i + 1], "Hips" if i == 0 else "Tail%d" % i, i > 0, True))
    for leg in LEGS:
        sx = 1.0 if leg[1] == "L" else -1.0
        keys = HIND_NODES if leg[0] == "B" else FRONT_NODES
        pts = [node(k) * 1 for k in (keys[0], keys[1], keys[2], keys[4])]
        for p_ in pts:
            p_.x *= sx
        par = "Hips" if leg[0] == "B" else "Spine3"
        s += [(bn("Upper", leg), pts[0], pts[1], par, False, True),
              (bn("Lower", leg), pts[1], pts[2], bn("Upper", leg), True, True),
              (bn("Foot", leg), pts[2], pts[3], bn("Lower", leg), True, True)]
    eb = getattr(S, "EXTRA_BONES", [])
    for name, hd, tl, par in (eb() if callable(eb) else eb):
        s.append((name, Vector(hd), Vector(tl), par, False, True))
    return s


def rig_mesh(col, ob):
    m = skel_matrix(ob)
    skel = bone_specs_skel()
    specs = [("Root", Vector((0, 0, 0)), Vector((0, 0, 0.8)), None, False, False)]
    specs += [(n, m @ hd, m @ tl, par, con, dfm) for n, hd, tl, par, con, dfm in skel]
    arm = R.build_armature(col, S.ID + "_Armature", specs)
    segs = {n: (hd, tl) for n, hd, tl, *_ in skel}
    minv = m.inverted()
    me = ob.data
    Sv = [minv @ v.co for v in me.vertices]
    G = [a.value for a in me.attributes["dd_grp"].data]
    JAW = [a.value for a in me.attributes["dd_jaw"].data]
    region = [None] * len(me.vertices)
    for g in rig.islands(me):
        if G[g[0]] != 0:
            continue
        c = sum((Sv[i] for i in g), Vector()) / len(g)
        c.x = abs(c.x)
        nd = min(S.NODES, key=lambda n: (Vector(n[1]) - c).length / n[2])[0]
        kind = "B" if nd in HIND_NODES else "F" if nd in FRONT_NODES else "trunk"
        for i in g:
            region[i] = kind
    sigma = S.SIGMA
    Y0, zmin = S.MOUTH["y0"], S.MOUTH.get("zmin", -1e9)
    W = []
    for i, s in enumerate(Sv):
        side = "L" if s.x > 0 else "R"
        gi = G[i]
        if gi == 0:
            kind = region[i]
            if kind in ("B", "F"):
                leg = kind + side
                bones = [bn("Upper", leg), bn("Lower", leg), bn("Foot", leg)]
                bones.append("Hips" if kind == "B" else "Spine3")
            else:
                bones = TRUNK
            wd = R.dist_weights(s, bones, segs, sigma)
            if kind in ("B", "F"):  # pied rigide sous la cheville : la semelle reste à plat au sol
                za = node("cheville" if kind == "B" else "poignet").z
                k = max(0.0, min(1.0, (za + 0.08 - s.z) / 0.16))
                if k > 0:
                    wd = {b_: v * (1 - k) for b_, v in wd.items()}
                    fb = bn("Foot", kind + side)
                    wd[fb] = wd.get(fb, 0.0) + k
            if kind == "trunk":
                fy = max(0.0, min(1.0, (Y0 + 0.15 - s.y) / 0.35))
                jw = fy * JAW[i] if s.z > zmin else 0.0
                if jw > 0:
                    wd = {k: v * (1 - jw) for k, v in wd.items()}
                    wd["Jaw"] = wd.get("Jaw", 0.0) + jw
        else:
            kind, b = K.GROUPS[gi]
            if kind == "rigid":
                wd = {b.replace(".S", "." + side): 1.0}
            else:
                wd = R.dist_weights(s, [x.replace(".S", "." + side) for x in b], segs, sigma)
        W.append(wd)
    info = R.apply_weights(ob, arm, W)
    assert info["max_influences"] <= 4 and info["sans_poids"] == 0, info
    assert not info["os_deformants_sans_poids"], info
    return arm, m[0][0], info


def setup_ik4(arm, col):
    """Remplace rig.setup_ik (bipède) : 4 pattes, IK chaîne 2 sur LowerLeg + Damped Track du pied."""
    empties = {}
    for leg in LEGS:
        fb = arm.data.bones[bn("Foot", leg)]
        ank, toe = fb.head_local.copy(), fb.tail_local.copy()
        e1 = bpy.data.objects.new("DD_IK_A." + leg, None)
        e2 = bpy.data.objects.new("DD_IK_T." + leg, None)
        for e, p_ in ((e1, ank), (e2, toe)):
            col.objects.link(e)
            e.location = p_
        ik = arm.pose.bones[bn("Lower", leg)].constraints.new("IK")
        ik.target, ik.chain_count, ik.use_tail = e1, 2, True
        dt = arm.pose.bones[bn("Foot", leg)].constraints.new("DAMPED_TRACK")
        dt.target, dt.track_axis = e2, "TRACK_Y"
        empties[leg] = (e1, e2, ank, toe)
    return empties


rig.setup_ik = setup_ik4  # R.make_action appelle rig.setup_ik : version 4 pattes dans ce processus


# ------------------------------------------------------------------ animations (t dans [0, 1])

def ramp(t, a, b):
    u = max(0.0, min(1.0, (t - a) / (b - a)))
    return u * u * (3 - 2 * u)


class QuadAnims:
    WALK_PH = {"BL": 0.0, "FL": 0.25, "BR": 0.5, "FR": 0.75}  # pas latéral (4 temps)
    RUN_PH = {"BL": 0.0, "FR": 0.0, "BR": 0.5, "FL": 0.5}  # trot bondissant (diagonales)
    death_drop = 0.0

    def __init__(self, arm, u):
        self.arm, self.u, self.P = arm, u, arm.pose.bones
        g = S.GAIT
        self.g = g

    def base(self):
        rig.reset_pose(self.arm)
        return self.P

    def r(self, name, *ax):
        rig.rot(self.P[name], *ax)

    def hips(self, x=0.0, y=0.0, z=0.0, rx=0.0, ry=0.0, rz=0.0):
        u = self.u
        rig.loc(self.P["Hips"], (x * u, y * u, z * u))
        rig.rot(self.P["Hips"], (R.X, rx), (R.Y, ry), (R.Z, rz))

    def tail(self, fn):
        for i in range(NT):
            self.r("Tail%d" % (i + 1), *fn(i))

    def spine(self, rx=0.0, rz=0.0, ry=0.0):
        for n in ("Spine1", "Spine2", "Spine3"):
            self.r(n, (R.X, rx), (R.Z, rz), (R.Y, ry))

    def neck(self, rx=0.0, rz=0.0, ry=0.0):
        for n in ("Neck1", "Neck2", "Neck3"):
            self.r(n, (R.X, rx), (R.Z, rz), (R.Y, ry))

    def extra(self, clip, t):
        pass

    # --- pieds (cibles IK)
    def cyc(self, leg, t, ank, toe, ph, step, lift, stance):
        u = self.u
        p = (t - ph) % 1.0
        if p < stance:
            q = p / stance
            dy, dz, drop = -step / 2 + step * q, 0.0, 0.0
        else:
            q = (p - stance) / (1 - stance)
            sm = 0.5 - 0.5 * math.cos(math.pi * q)
            dy, dz, drop = step / 2 - step * sm, lift * math.sin(math.pi * q), 0.35 * lift * math.sin(math.pi * q)
        off = Vector((0, dy * u, dz * u))
        return ank + off, toe + off - Vector((0, 0, drop * u))

    def feet_walk(self, leg, t, a, b):
        g = self.g
        return self.cyc(leg, t, a, b, self.WALK_PH[leg], g["walk_step"], g["walk_lift"], 0.65)

    def feet_run(self, leg, t, a, b):
        g = self.g
        return self.cyc(leg, t, a, b, self.RUN_PH[leg], g["run_step"], g["run_lift"], 0.42)

    def feet_still(self, leg, t, a, b):
        return a, b

    # --- clips
    def idle(self, t):
        self.base()
        br = R.S2(t, 2)
        look = R.keys(t, [(0, 0), (0.2, 0), (0.3, 1), (0.48, 1), (0.58, -0.7), (0.75, -0.7), (0.85, 0), (1, 0)])
        self.hips(z=-0.01 + 0.012 * br, rz=1.5 * R.S2(t, 1))
        self.spine(rx=-0.8 * br)
        self.neck(rx=1.2 * br, rz=6 * look)
        self.r("Head", (R.X, 2 * R.S2(t, 2, 0.3)), (R.Z, 8 * look), (R.Y, -6 * look))
        self.r("Jaw", (R.X, 2 + 2 * max(0.0, br)))
        self.tail(lambda i: ((R.Z, 6 * R.S2(t, 1, -0.08 * i)), (R.X, 1.5 * R.S2(t, 2, -0.1 * i))))
        self.extra("Idle", t)

    def walk(self, t):
        self.base()
        bob = math.cos(4 * math.pi * t)
        self.hips(z=-0.03 - 0.035 * bob, rz=4 * R.S2(t, 1), ry=3 * R.S2(t, 1, 0.25))
        self.spine(rz=-1.5 * R.S2(t, 1), ry=-1.5 * R.S2(t, 1, 0.25))
        self.neck(rx=-1 + 1.5 * R.S2(t, 2, 0.1), rz=-1.5 * R.S2(t, 1))
        self.r("Head", (R.X, 2.5 * R.S2(t, 2, 0.2)), (R.Z, -2 * R.S2(t, 1)), (R.Y, 3 * R.S2(t, 1, 0.3)))
        self.r("Jaw", (R.X, 4))
        self.tail(lambda i: ((R.Z, -7 * R.S2(t, 1, -0.07 * (i + 1))), (R.X, 1.5 * R.S2(t, 2, -0.1 * i))))
        self.extra("Walk", t)

    def run(self, t):
        self.base()
        low = math.cos(4 * math.pi * (t - 0.21))  # 1 au milieu de l'appui
        self.hips(z=0.02 - 0.09 * low, rx=3 + 3 * R.S2(t, 2, 0.1), rz=2 * R.S2(t, 1))
        self.spine(rx=1.5 * low)
        self.neck(rx=-3 + 2.5 * low)
        self.r("Head", (R.X, -2 - 2 * low))
        self.r("Jaw", (R.X, 10 + 4 * low))
        self.tail(lambda i: ((R.X, -4 + 4 * R.S2(t, 2, -0.1 * (i + 1))), (R.Z, -4 * R.S2(t, 1, -0.07 * i))))
        self.extra("Run", t)

    # Attaque par défaut : charge tête baissée (cornes en avant), coup de tête vers le haut
    def attack(self, t):
        self.base()
        style = getattr(S, "ATTACK", "charge")
        if style == "tail":
            return self.attack_tail(t)
        if style == "stomp":
            return self.attack_stomp(t)
        a = R.keys(t, [(0, 0), (0.3, 1), (0.4, 0), (1, 0)])
        s = R.keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.58, 1), (0.88, 0), (1, 0)])
        tos = R.keys(t, [(0, 0), (0.4, 0), (0.5, 1), (0.66, 0.2), (0.9, 0), (1, 0)])
        s2 = R.keys(t, [(0, 0), (0.36, 0), (0.5, 1), (0.66, 1), (0.95, 0), (1, 0)])
        scrape = math.sin(math.pi * 3 * t / 0.3) ** 2 * (1 - ramp(t, 0.22, 0.3)) if t < 0.3 else 0.0
        self.hips(y=0.3 * a - 0.45 * s, z=-0.1 * a - 0.05 * s, rx=6 * a + 2 * s - 6 * tos)
        self.spine(rx=2 * a)
        self.neck(rx=7 * a + 4 * s - 9 * tos)
        self.r("Head", (R.X, 10 * a + 5 * s - 18 * tos), (R.Z, 6 * tos))
        self.r("Jaw", (R.X, 22 * tos + 4 * a))
        self.tail(lambda i: ((R.X, -6 * a + 5 * s2), (R.Z, 6 * s2 * R.S2(t, 2, -0.1 * i))))
        self._scrape = scrape
        self.extra("Attack", t)

    def attack_feet(self, leg, t, a, b):
        u = self.u
        style = getattr(S, "ATTACK", "charge")
        if style == "stomp":
            return self.stomp_feet(leg, t, a, b)
        if style == "tail":
            return a, b
        s = R.keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.58, 1), (0.88, 0), (1, 0)])
        off = Vector((0, 0, 0))
        if leg[0] == "F":  # les pattes avant suivent la charge
            off = Vector((0, -0.3 * s * u, 0.25 * u * math.sin(math.pi * ramp(t, 0.3, 0.45)) +
                          0.2 * u * math.sin(math.pi * ramp(t, 0.6, 0.85))))
        if leg == "FR" and t < 0.3:  # gratte le sol
            k = math.sin(math.pi * 3 * t / 0.3) ** 2 * (1 - ramp(t, 0.24, 0.3))
            off += Vector((0, 0.35 * k * u, 0.15 * k * u))
        return a + off, b + off

    def attack_tail(self, t):
        """Coup de queue : torsion d'anticipation, fouet latéral, rebond."""
        a = R.keys(t, [(0, 0), (0.32, 1), (0.42, 0), (1, 0)])
        s = R.keys(t, [(0, 0), (0.34, 0), (0.48, 1), (0.6, 1), (0.9, 0), (1, 0)])
        s2 = R.keys(t, [(0, 0), (0.38, 0), (0.54, 1), (0.68, 1), (0.96, 0), (1, 0)])
        self.hips(z=-0.06 * a, rz=-10 * a + 14 * s, ry=3 * a - 4 * s)
        self.spine(rz=-3 * a + 4 * s)
        self.neck(rz=10 * a - 8 * s, rx=4 * a)
        self.r("Head", (R.Z, 14 * a - 6 * s), (R.Y, 8 * s))
        self.r("Jaw", (R.X, 8 * a + 18 * s))
        self.tail(lambda i: ((R.Z, (-10 * a + 16 * s2 + 6 * s) * (0.6 + 0.2 * i)), (R.X, -4 * s2)))
        self.extra("Attack", t)

    def attack_stomp(self, t):
        """Se cabre (anticipation) puis écrase le sol des 2 pattes avant."""
        a = R.keys(t, [(0, 0), (0.36, 1), (0.48, -0.25), (0.6, 0), (1, 0)])
        imp = R.keys(t, [(0, 0), (0.44, 0), (0.5, 1), (0.6, 0.2), (0.9, 0), (1, 0)])
        self.hips(y=0.25 * a, z=0.06 * a - 0.08 * imp, rx=-16 * a)
        self.spine(rx=-4 * a + 3 * imp)
        self.neck(rx=6 * a + 6 * imp)
        self.r("Head", (R.X, 8 * a + 6 * imp))
        self.r("Jaw", (R.X, 20 * max(a, 0) + 30 * imp))
        self.tail(lambda i: ((R.X, 8 * a - 4 * imp), (R.Z, 4 * imp * R.S2(t, 3, -0.1 * i))))
        self.extra("Attack", t)

    def stomp_feet(self, leg, t, a, b):
        u = self.u
        if leg[0] != "F":
            return a, b
        up = R.keys(t, [(0, 0), (0.36, 1), (0.48, 0), (1, 0)])
        off = Vector((0, -0.1 * up * u, S.GAIT.get("rear", 0.9) * up * u))
        return a + off, b + off + Vector((0, 0, 0.1 * up * u))

    # Rugissement : anticipation (tête basse), redresse l'avant, gueule grande ouverte qui tremble
    def roar(self, t):
        self.base()
        a = R.keys(t, [(0, 0), (0.16, 1), (0.27, 0), (1, 0)])
        r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * R.S2(t, 8)
        self.hips(y=0.12 * a - 0.05 * r, z=-0.08 * a + 0.03 * r, rx=4 * a - 7 * r)
        self.spine(rx=2 * a - 2 * r)
        self.neck(rx=7 * a - 7 * r)
        self.r("Head", (R.X, 10 * a - 14 * r + 3 * sh), (R.Z, 4 * sh))
        self.r("Jaw", (R.X, 4 * a + S.ROAR_JAW * r))
        self.tail(lambda i: ((R.X, 3 * a - 6 * r), (R.Z, 4 * R.S2(t, 7, -0.1 * i) * r)))
        self.extra("Roar", t)

    def roar_feet(self, leg, t, a, b):
        u = self.u
        if leg[0] != "F":
            return a, b
        r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
        stomp = math.sin(math.pi * ramp(t, 0.78, 0.92)) * (1 if leg == "FL" else 0.6)
        off = Vector((0, -0.05 * r * u, (0.08 * r + 0.25 * stomp) * u))
        return a + off, b + off

    # Célébration : 2 sauts de joie à 4 pattes, queue qui frétille, tête qui dodeline, sourire
    def hop(self, t):
        h1 = math.sin(math.pi * (t - 0.12) / 0.26) if 0.12 < t < 0.38 else 0.0
        h2 = math.sin(math.pi * (t - 0.5) / 0.26) if 0.5 < t < 0.76 else 0.0
        sq = sum(math.exp(-((t - c) / 0.035) ** 2) for c in (0.1, 0.4, 0.48, 0.78))
        return h1 + h2, sq

    def celebrate(self, t):
        self.base()
        air, sq = self.hop(t)
        joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
        H = S.GAIT.get("hop", 0.45)
        self.hips(z=H * air - 0.1 * sq, rx=-5 * air + 3 * sq, rz=4 * R.S2(t, 2) * joy)
        self.spine(rx=-2 * air + 2 * sq)
        self.neck(rx=-6 * air * joy + 4 * sq)
        self.r("Head", (R.X, -6 * joy), (R.Y, 10 * R.S2(t, 2) * joy))
        self.r("Jaw", (R.X, S.ROAR_JAW * 0.55 * joy))
        self.tail(lambda i: ((R.Z, 16 * R.S2(t, 3, -0.07 * i) * joy), (R.X, -6 * air)))
        self.extra("Celebrate", t)

    def celebrate_feet(self, leg, t, a, b):
        air, _sq = self.hop(t)
        H = S.GAIT.get("hop", 0.45)
        tuck = 0.12 * air * self.u
        off = Vector((0, 0, H * air * self.u * 0.92))
        return a + off + Vector((0, 0, tuck)), b + off
    # Mort : coup reçu (recul), vacille, bascule sur le flanc droit, pattes raides, petit rebond

    def death(self, t):
        self.base()
        h = R.keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = R.S2(t, 3) * R.keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        f = R.keys(t, [(0, 0), (0.36, 0), (0.62, 1), (0.71, 0.92), (0.8, 1), (1, 1)])
        lift = 0.15 * math.sin(math.pi * min(1.0, f))
        # bascule sur le flanc GAUCHE (+X) : ventre et pattes raides tournés vers la caméra des rendus 3/4
        self.hips(y=0.2 * h, z=-self.death_drop * f + lift, rx=-6 * h, rz=6 * w, ry=82 * f)
        self.spine(rz=-3 * f)
        self.neck(rx=-6 * h + 3 * f, rz=5 * f)
        self.r("Head", (R.X, -10 * h + 5 * f), (R.Z, 8 * f), (R.Y, 8 * w))
        self.r("Jaw", (R.X, 18 * h + 16 * f))
        self.tail(lambda i: ((R.Z, 4 * f + 4 * w), (R.X, -1 * f)))
        for leg in LEGS:
            k = 1.0 if leg[1] == "L" else 0.7
            sgn = 1 if leg[0] == "F" else -1
            self.r(bn("Upper", leg), (R.X, sgn * 18 * f * k - 6 * h))
            self.r(bn("Lower", leg), (R.X, -sgn * 6 * f * k))
        self.extra("Death", t)


CLIPS = [("Idle", 120, True), ("Walk", 36, True), ("Run", 20, True), ("Attack", 36, False),
         ("Roar", 48, False), ("Celebrate", 40, False), ("Death", 48, False)]


def animate(arm, col, u, mesh_ob):
    A = getattr(S, "Anims", QuadAnims)(arm, u)
    feet = {"Idle": A.feet_still, "Walk": A.feet_walk, "Run": A.feet_run, "Attack": A.attack_feet,
            "Roar": A.roar_feet, "Celebrate": A.celebrate_feet, "Death": None}
    acts, out = {}, {}
    for clip, length, loop in getattr(S, "CLIPS", CLIPS):
        fn = getattr(A, clip.lower())
        act = R.make_action(arm, col, S.ID, clip, length, loop, fn, feet[clip])
        lo = R.min_z(mesh_ob, arm, act, step=1)
        if clip == "Death":  # la chute est réglée pour que le flanc touche le sol sans le traverser
            for _ in range(8):
                if abs(lo) < 0.03:
                    break
                A.death_drop += lo / u
                act = R.make_action(arm, col, S.ID, clip, length, loop, fn, feet[clip])
                lo = R.min_z(mesh_ob, arm, act, step=1)
        acts[clip] = act
        info = {"images": length, "boucle": loop, "min_z": round(lo, 3)}
        if loop:
            info["erreur_boucle"] = round(R.loop_error(arm, act), 5)
        out[clip] = info
    g = S.GAIT
    out["vitesse_marche_studs_s"] = round(g["walk_step"] * u / (0.65 * 36 / 30), 2)
    out["vitesse_course_studs_s"] = round(g["run_step"] * u / (0.42 * 20 / 30), 2)
    return acts, out


# ------------------------------------------------------------------ rendus / sauvegarde

def setup_cam(sc, rcol, ob):
    cam = dd.setup_render(sc, rcol, target=(0, 0, S.HEIGHT * 0.45), distance=12, azimuth=-40, height_ratio=0.3)
    sh = sc.display.shading
    sh.show_cavity = False
    sh.show_specular_highlight = True
    sh.show_backface_culling = True
    sc.world.color = (0.16, 0.19, 0.27)
    co = [v.co for v in ob.data.vertices]
    S.FRAME = max(max(c.y for c in co) - min(c.y for c in co), S.HEIGHT)
    S.CY = (max(c.y for c in co) + min(c.y for c in co)) / 2
    return cam


def render_still(sc, name, azimuth=-40, h=0.3, k=1.0, target=None):
    dist = (S.FRAME * 1.75 + 1.0) * k
    rig.place_cam(sc, target or (0, S.CY, S.HEIGHT * 0.42), azimuth, dist, h)
    sc.render.resolution_x = sc.render.resolution_y = 512
    os.makedirs(RENDERS, exist_ok=True)
    return dd.render_to(sc, os.path.join(RENDERS, "%s_%s.png" % (S.ID, name)))


def save_blend(sc):
    for s_ in list(bpy.data.scenes):
        if s_ != sc:
            for o in list(s_.collection.all_objects):
                if len(o.users_scene) == 1:
                    bpy.data.objects.remove(o, do_unlink=True)
            bpy.data.scenes.remove(s_)
    sc["dd_id"] = S.ID
    sc["dd_colors"] = json.dumps(S.COLORS)
    path = os.path.join(PROJECT_DIR, "blender", "dinos", S.ID + ".blend")
    os.makedirs(os.path.dirname(path), exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=path, check_existing=False)
    with open(os.path.join(PROJECT_DIR, "blender", "dinos", S.ID + "_look.json"), "w", encoding="utf-8") as fh:
        json.dump(S.COLORS, fh, indent=2)
    return path


def main(spec):
    global S
    S = spec
    args = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    sc, col, rcol, ob, st = build_mesh()
    setup_cam(sc, rcol, ob)
    out = {"mesh": st}
    render_still(sc, "34")
    render_still(sc, "side", azimuth=-90, h=0.1)
    render_still(sc, "front", azimuth=0, h=0.15)
    if "model" in args:
        render_still(sc, "head", azimuth=-35, h=0.2, k=0.4, target=skel_matrix(ob) @ node("crane"))
        render_still(sc, "headside", azimuth=-90, h=0.05, k=0.4, target=skel_matrix(ob) @ node("crane"))
        print("DD_RESULT", json.dumps(out))
        return
    assert st["triangles"] <= 5000, st
    render_still(sc, "back34", azimuth=140, h=0.45)
    arm, u, winfo = rig_mesh(col, ob)
    out["poids"] = winfo
    out["os"] = len(arm.data.bones)
    assert out["os"] <= 30, out["os"]
    acts, out["clips"] = animate(arm, col, u, ob)
    tmp = os.path.join(bpy.app.tempdir or os.environ.get("TEMP", "."), "dd_" + S.ID)
    if "norender" not in args:
        only = [a for a in args if a[:1].isupper()]
        for clip, _l, _lp in CLIPS:
            if only and clip not in only:
                continue
            act = acts[clip]
            arm.animation_data.action = act
            L = int(act["dd_len"])
            n = 8
            frames = [round(i * L / (n if act["dd_loop"] else n - 1)) for i in range(n)]
            az = -90 if clip in ("Walk", "Run") else -40
            rig.place_cam(sc, (0, S.CY, S.HEIGHT * 0.42), az, S.FRAME * 2.0 + 1.5, 0.2)
            out["rendu_" + clip] = R.render_sheet(sc, frames, os.path.join(RENDERS, "%s_%s.png" % (S.ID, clip.lower())),
                                                  tmp, size=256)
    arm.animation_data.action = acts["Idle"]
    sc.frame_set(0)
    out["fichier"] = save_blend(sc)
    print("DD_RESULT", json.dumps(out, default=str))
