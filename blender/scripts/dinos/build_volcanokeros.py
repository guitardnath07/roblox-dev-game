# DINO DICE — Volcanokéros (épique, quadrupède) : modèle + rig + 7 animations + rendus.
# Version : 2 (style chibi : grosse tête, gros yeux, grosses griffes crème, gueule souriante)
# Référence réelle : Diabloceratops eatoni (cératopsien : bec, petite corne nasale, cornes au-dessus des yeux,
# collerette courte surmontée de 2 très longues pointes dressées).
# Couche thématique : les 2 pointes = obélisques de basalte (prismes 6 côtés), cratère fumant sur le dos
# (cône tronqué + disque de lave), pattes en colonnes hexagonales, 5 fissures de lave en Y, naseaux de braise.
# Ce fichier porte aussi le « kit chibi » (griffes, dents, pointes, rayures, poses) réutilisé par
# build_magmaroi / build_titanomarbre / build_gaiatops.
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_volcanokeros.py [-- model]

import math
import os
import sys

import bmesh
import bpy
from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import quadruped_helpers as Q  # noqa: E402
from quadruped_helpers import K, R, MAIN, BELLY, ACCENT, GLOW, BACK, WHITE  # noqa: E402

# ====================================================================== kit chibi (mes 4 quadrupèdes)

def claws(body, parts):
    """Remplace Q.nails : 3 grosses griffes crème recourbées par pied (cônes pliés vers le sol)."""
    S = Q.S
    k = getattr(S, "CLAW", 1.0)
    for keys, fb in ((Q.HIND_NODES, "B"), (Q.FRONT_NODES, "F")):
        pied, ort = Q.node(keys[3]), Q.node(keys[4])
        r = Q.radius(keys[4])
        for dx in (-0.62, 0.0, 0.62):
            L, rb = r * 0.8 * k, r * 0.3 * k
            base = Vector((pied.x + dx * r * 0.95, ort.y - r * 0.62 * (1 - 0.3 * abs(dx)), S.SOLE_Z + rb + 0.08))
            d = Vector((dx * 0.45, -1, -0.3)).normalized()
            ob = Q.P("Griffe", "cone", WHITE, "Foot%s.S" % fb, loc=(0, 0, L / 2), segments=5, r1=rb, r2=0.0, depth=L)
            for v in ob.data.vertices:
                u = max(0.0, v.co.z / L)
                v.co.y -= 0.45 * L * u * u
            K.xform(ob, K.frame_from(base, d, up=(0, 0, 1)))
            lo = min(v.co.z for v in ob.data.vertices)
            if lo < S.SOLE_Z + 0.01:
                for v in ob.data.vertices:
                    v.co.z += S.SOLE_Z + 0.01 - lo
            K.mirror_inplace(ob)
            parts.append(ob)


def grin_teeth(y_front, y_back, n, L, r, inset_front=0.08, inset_back=0.3, lower_k=0.85):
    """Rangées de grosses dents triangulaires (haut + bas décalées) pour S.TEETH."""
    out = []
    for i in range(n):
        u = i / max(1, n - 1)
        y = y_front + (y_back - y_front) * u
        ins = inset_front + (inset_back - inset_front) * u
        out.append((y, True, L * (1 - 0.35 * u), r * (1 - 0.25 * u), ins))
        if i < n - 1:
            y2 = y + (y_back - y_front) / max(1, n - 1) * 0.5
            out.append((y2, False, L * lower_k * (1 - 0.35 * u), r * 0.9 * (1 - 0.25 * u), ins + 0.03))
    return out


TRUNK_BONES = ["Hips", "Spine1", "Spine2", "Spine3", "Neck1", "Neck2", "Tail1", "Tail2", "Tail3"]


def spike(parts, base, d, h, r, slot, bone, segs=4):
    M = K.frame_from(base, d, up=(0, 0, 1) if abs(Vector(d).normalized().z) < 0.9 else (0, -1, 0))
    parts.append(K.xform(Q.P("Pic", "cone", slot, bone, loc=(0, 0, h * 0.42), segments=segs, r1=r, r2=0.0,
                             depth=h), M))


def back_spikes(body, parts, ys, h, r, slot, lean=0.45, x=0.0, bone=None):
    """Petites pointes triangulaires le long de la ligne du dos (rayon lancé du haut)."""
    for y in ys:
        ok, loc, nor, _ = body.ray_cast(Vector((x, y, 12.0)), Vector((0, 0, -1)))
        if ok:
            spike(parts, loc - nor * 0.03, nor + Vector((0, lean, 0)), h, r, slot, bone or TRUNK_BONES)


def elbow_spikes(parts, h, r, slot, which="FB"):
    """Pointe sur le coude (avant) et le genou (arrière), côté extérieur, vers l'arrière."""
    for keys, fb in ((Q.FRONT_NODES, "F"), (Q.HIND_NODES, "B")):
        if fb not in which:
            continue
        c = Q.node(keys[1])
        rr = Q.radius(keys[1])
        base = c + Vector((rr * 0.55, rr * 0.55, 0.05))
        before = len(parts)
        spike(parts, base, (0.85, 0.55, 0.55), h, r, slot, "LowerLeg%s.S" % fb)
        K.mirror_inplace(parts[before])


def studs(parts, M, pts, r, h, slot, bone):
    """Plots ronds de jouet de construction (cylindres courts 8 pans) posés sur une plaque (repère M, Z = normale)."""
    for x, y in pts:
        parts.append(K.xform(Q.P("Plot", "cone", slot, bone, loc=(x, y, h / 2), segments=8, r1=r, r2=r, depth=h), M))


def plate(parts, body, x, y, size, slot, bone, shape=4, thick=0.12, lean=0.0, stud=None):
    """Vraie plaque plate (prisme biseauté : 4 = losange, 6 = hexagone) posée sur le dos ; plots en option."""
    ok, loc, nor, _ = body.ray_cast(Vector((x, y, 12.0)), Vector((0, 0, -1)))
    if not ok:
        return None
    M = K.frame_from(loc - nor * 0.02, nor + Vector((0, lean, 0)), up=(0, -1, 0))
    parts.append(K.xform(Q.P("Plaque", "cone", slot, bone, loc=(0, 0, thick / 2), segments=shape, r1=size,
                             r2=size * 0.8, depth=thick), M))
    if stud:
        studs(parts, M @ Matrix.Translation((0, 0, thick)), stud[0], stud[1], stud[2], stud[3], bone)
    return M


def stripes(me, setp, ys, w, zmin, slot, slant=0.0, xmax=9.0):
    """Marques foncées : bandes transversales sur le dessus du corps, effilées vers les flancs."""
    for p in me.polygons:
        c = p.center
        if c.z < zmin or abs(c.x) > xmax:
            continue
        taper = min(1.0, (c.z - zmin) / 0.45)
        for yc in ys:
            if abs(c.y - yc - slant * abs(c.x)) < w * taper:
                setp(p, slot)
                break


def lego_patch(subdiv=0):
    """Contournements (dans CE processus seulement, les helpers ne sont pas modifiés) pour le style « plaques » :
    corps Skin sans Subdivision (facettes nettes), griffes du kit à la place des ongles ronds, mesh final en
    shade flat avant les rendus."""
    orig_skin, orig_build = Q.dd.skin_body, Q.build_mesh

    def skin(*a, **kw):
        kw["subdiv"] = subdiv
        return orig_skin(*a, **kw)

    def build():
        out = orig_build()
        for p in out[3].data.polygons:
            p.use_smooth = False
        return out
    Q.dd.skin_body = skin
    Q.build_mesh = build
    Q.nails = claws


class ChibiAnims(Q.QuadAnims):
    """Idle « prêt à bondir » (avant baissé, tête haute, arrière-train qui frétille) et Celebrate dressé sur
    les pattes arrière, pattes avant levées qui s'agitent, grand sourire."""
    CROUCH = 1.0

    def cyc(self, leg, t, ank, toe, ph, step, lift, stance):
        """Comme Q.QuadAnims.cyc, mais la pointe du pied plonge moins en l'air (les grosses griffes avant
        traverseraient le sol)."""
        u = self.u
        p = (t - ph) % 1.0
        if p < stance:
            dy, dz, drop = -step / 2 + step * p / stance, 0.0, 0.0
        else:
            q = (p - stance) / (1 - stance)
            sm = 0.5 - 0.5 * math.cos(math.pi * q)
            dy, dz, drop = step / 2 - step * sm, lift * math.sin(math.pi * q), -0.1 * lift * math.sin(math.pi * q)
        off = Vector((0, dy * u, dz * u))
        return ank + off, toe + off - Vector((0, 0, drop * u))

    def run(self, t):
        """Course du helper, bassin un peu plus bas : pattes chibi courtes, sinon jambes en butée et pieds qui
        piquent du nez (griffes dans le sol)."""
        super().run(t)
        low = math.cos(4 * math.pi * (t - 0.21))
        self.hips(z=-0.1 - 0.04 * low, rx=1 + 2 * R.S2(t, 2, 0.1), rz=2 * R.S2(t, 1))

    def roar(self, t):
        """Rugissement à anticipation douce : la tête chibi est énorme, la baisser la ferait traverser le sol."""
        self.base()
        a = R.keys(t, [(0, 0), (0.16, 1), (0.27, 0), (1, 0)])
        r = R.keys(t, [(0, 0), (0.2, 0), (0.32, 1), (0.76, 1), (0.9, 0), (1, 0)])
        sh = r * R.S2(t, 8)
        self.hips(y=0.12 * a - 0.05 * r, z=-0.03 * a + 0.03 * r, rx=1.5 * a - 7 * r)
        self.spine(rx=1 * a - 2 * r)
        self.neck(rx=2 * a - 8 * r)
        self.r("Head", (R.X, 3 * a - 14 * r + 3 * sh), (R.Z, 4 * sh))
        self.r("Jaw", (R.X, 4 * a + Q.S.ROAR_JAW * r))
        self.tail(lambda i: ((R.X, 3 * a - 6 * r), (R.Z, 4 * R.S2(t, 7, -0.1 * i) * r)))
        self.extra("Roar", t)

    def crouch(self, t, k=1.0):
        """Valeurs de base de la posture prête à bondir (à ajouter dans l'idle de chaque dino)."""
        c = self.CROUCH * k
        return {"hz": -0.05 * c, "hrx": 5 * c, "nrx": -7 * c, "headx": -3 * c, "tailx": 6 * c}

    def celebrate(self, t):
        self.base()
        up = R.keys(t, [(0, 0), (0.16, 1), (0.82, 1), (1, 0)])
        hop = math.sin(math.pi * (t - 0.4) / 0.2) if 0.4 < t < 0.6 else 0.0
        self.hips(y=0.12 * up, z=0.06 * up + 0.12 * hop, rx=-19 * up)
        self.spine(rx=-3 * up)
        self.neck(rx=10 * up)
        self.r("Head", (R.X, 2 * up), (R.Y, 12 * R.S2(t, 2) * up))
        self.r("Jaw", (R.X, Q.S.ROAR_JAW * 0.75 * up))
        self.tail(lambda i: ((R.Z, 18 * R.S2(t, 3, -0.07 * i) * up), (R.X, 3 * up)))
        self.extra("Celebrate", t)

    def celebrate_feet(self, leg, t, a, b):
        u = self.u
        up = R.keys(t, [(0, 0), (0.16, 1), (0.82, 1), (1, 0)])
        hop = math.sin(math.pi * (t - 0.4) / 0.2) if 0.4 < t < 0.6 else 0.0
        if leg[0] != "F":
            off = Vector((0, 0, 0.12 * hop * u))
            return a + off, b + off
        wave = R.S2(t, 3, 0.0 if leg[1] == "L" else 0.5)
        off = Vector((0, -0.15 * up * u + 0.12 * wave * up * u,
                      (Q.S.GAIT.get("rear", 0.9) * up + 0.12 * wave * up + 0.12 * hop) * u))
        return a + off, b + off + Vector((0, -0.05 * u * up, 0.2 * up * u))


# ====================================================================== Volcanokéros

ID, NAME = "volcanokeros", "Volcanokeros"
HEIGHT = 3.4 * 1.35
COLORS = {"main": "#7B3F2A", "belly": "#E8B48A", "accent": "#FF5722", "glow": "#FFB300", "back": "#3B211A"}

NODES = [
    ("bassin", (0, 0.55, 1.6), 1.05, None),
    ("dos", (0, 0.0, 1.72), 1.15, "bassin"),
    ("poitrail", (0, -0.5, 1.68), 1.05, "dos"),
    ("cou1", (0, -0.92, 1.85), 0.88, "poitrail"),
    ("cou2", (0, -1.22, 2.08), 0.98, "cou1"),
    ("crane", (0, -1.72, 2.45), 1.36, "cou2"),
    ("machoire", (0, -2.3, 2.12), 1.12, "crane"),
    ("museau", (0, -2.85, 1.92), 0.84, "machoire"),
    ("nez", (0, -3.25, 1.84), 0.55, "museau"),
    ("queue1", (0, 1.2, 1.45), 0.66, "bassin"),
    ("queue2", (0, 1.7, 1.32), 0.43, "queue1"),
    ("queue3", (0, 2.05, 1.35), 0.26, "queue2"),
    ("queue4", (0, 2.25, 1.48), 0.13, "queue3"),
    ("hanche", (0.8, 0.55, 1.1), 0.56, None),
    ("genou", (0.82, 0.35, 0.72), 0.52, "hanche"),
    ("cheville", (0.82, 0.52, 0.4), 0.5, "genou"),
    ("pied_ar", (0.82, 0.46, 0.3), 0.5, "cheville"),
    ("orteil_ar", (0.82, 0.2, 0.27), 0.4, "pied_ar"),
    ("epaule", (0.82, -0.48, 1.1), 0.56, None),
    ("coude", (0.84, -0.33, 0.72), 0.52, "epaule"),
    ("poignet", (0.84, -0.5, 0.4), 0.5, "coude"),
    ("pied_av", (0.84, -0.56, 0.3), 0.5, "poignet"),
    ("orteil_av", (0.84, -0.84, 0.27), 0.4, "pied_av"),
]
TAIL = ["queue1", "queue2", "queue3", "queue4"]
HEAD_CHAIN = ["machoire", "museau", "nez"]
SOLE_Z, NAIL_Z, NAIL_SIZE, NAIL_SLOT = 0.0, 0.1, 0.12, WHITE
BELLY_COS, BELLY_MAXX = 0.5, 0.85
BACK_NZ, BACK_ZMIN, BACK_MAXX = 2.0, 9.0, 0.0  # pas de dos uni : rayures à la place (paint)
SIGMA = 0.12
MOUTH = {"p": (0, -2.95, 1.78), "n": (0, -0.1, 1), "y0": -1.95, "gap": 0.07, "zmin": 1.0,
         "smile": 0.22, "smile_y": -2.75, "shell": 0.5, "shell_depth": 0.08}
EYE = {"target": (0.72, -1.95, 3.05), "size": 0.56, "look": (-0.1, -1.5, 0.05), "iris": 0.66,
       "lid": {"close": -78, "tilt": -14, "bone": "Head", "slot": BACK}}
NOSTRILS = [((0.2, -3.75, 2.15), (0.08, 0.06, 0.06))]
TEETH = grin_teeth(-3.15, -2.3, 5, 0.24, 0.09, inset_front=0.12)
TONGUE_AT = (-2.6, 0.45, 0.3)
GAIT = {"walk_step": 0.45, "walk_lift": 0.22, "run_step": 0.65, "run_lift": 0.28, "hop": 0.38, "rear": 0.75}
ATTACK = "charge"
ROAR_JAW = 30

# 5 fissures en Y sur chaque flanc : tronc (y, z) -> fourche, puis 2 branches
CRACKS = [((-0.55, 1.0), (-0.45, 1.4), (-0.6, 1.75), (-0.25, 1.75)),
          ((0.05, 0.85), (0.0, 1.3), (-0.15, 1.7), (0.2, 1.72)),
          ((0.6, 0.95), (0.6, 1.35), (0.45, 1.7), (0.85, 1.65)),
          ((1.3, 1.25), (1.5, 1.4), (1.6, 1.6), (1.75, 1.3)),
          ((-1.0, 1.55), (-1.15, 1.95), (-1.35, 2.3), (-0.95, 2.3))]


def paint(me, setp):
    stripes(me, setp, (-0.25, 0.3, 0.85), 0.13, 1.95, BACK, slant=0.15)


def crack_strips(body, segs, w=0.05, step=0.12):
    """Fissures de lave : rubans fins collés sur le flanc (+X, puis symétrie), suivent la surface par lancer de rayon."""
    bm = bmesh.new()
    for a, b in segs:
        a, b = Vector(a), Vector(b)
        n = max(2, int((b - a).length / step) + 1)
        prev = None
        for i in range(n + 1):
            q = a.lerp(b, i / n)
            ok, loc, nor, _ = body.ray_cast(Vector((4.0, q.x, q.y)), Vector((-1, 0, 0)))
            if not ok:
                prev = None
                continue
            d = Vector((0, b.x - a.x, b.y - a.y)).normalized()
            side = nor.cross(d).normalized() * w * (1.0 - 0.5 * i / n)
            p0 = loc + nor * 0.02
            pair = (bm.verts.new(p0 - side), bm.verts.new(p0 + side))
            if prev:
                bm.faces.new((prev[0], prev[1], pair[1], pair[0]))
            prev = pair
    bm.normal_update()
    for f in bm.faces:
        if f.normal.x < 0:
            f.normal_flip()
    me = bpy.data.meshes.new("Fissure")
    bm.to_mesh(me)
    bm.free()
    Q.dd.fill_color(me, K.C[GLOW])
    ob = bpy.data.objects.new("Fissure", me)
    K.COL.objects.link(ob)
    K.tag(ob, Q.gid(TRUNK_BONES + ["Neck3"]))
    K.mirror_inplace(ob)
    return ob


def obelisk(base, d, h, r, slot_tip):
    """Prisme hexagonal de basalte + pointe ; base au point `base`, axe `d`."""
    M = K.frame_from(base, d, up=(0, -1, 0))
    out = [K.xform(Q.P("Obelisque", "cone", BACK, "Head", loc=(0, 0, h / 2), segments=6, r1=r, r2=r * 0.8,
                       depth=h), M),
           K.xform(Q.P("Pointe", "cone", slot_tip, "Head", loc=(0, 0, h + r * 0.9), segments=6, r1=r * 0.8, r2=0.0,
                       depth=r * 1.8), M)]
    return out


def accessories(body, parts):
    spine = ["Hips", "Spine1", "Spine2", "Spine3"]
    # --- collerette courte (demi-disque festonné) derrière le crâne, presque dressée
    cr = Q.node("crane")
    n = Vector((0, -0.94, 0.33)).normalized()
    Mf = K.frame_from(cr + Vector((0, 0.78, 0.45)), n, up=(0, 0.2, 1))
    pts = []
    for i in range(15):
        a = math.pi * i / 14
        rr = 1.3 + (0.14 if i % 2 else 0.0)
        pts.append((rr * 1.05 * math.cos(a), 0.15 + rr * 0.9 * math.sin(a)))
    pts += [(-1.0, -0.3), (1.0, -0.3)][::-1]
    parts.append(Q.flat("Collerette", BELLY, "Head", pts, Mf, 0.26))
    # liseré de magma (pointes émissives) sur le bord festonné
    for i in range(1, 14, 2):
        a = math.pi * i / 14
        p = Mf @ Vector((1.38 * 1.05 * math.cos(a), 0.15 + 1.38 * 0.9 * math.sin(a), 0.0))
        dv = Mf.to_3x3() @ Vector((math.cos(a) * 1.05, math.sin(a) * 0.9, 0.0))
        spike(parts, p, dv, 0.32, 0.13, ACCENT, "Head")
    # 2 obélisques de basalte dressés en haut de la collerette (légèrement en V)
    for s in (1, -1):
        base = Mf @ Vector((s * 0.5, 1.05, -0.05))
        d = (Mf.to_3x3() @ Vector((s * 0.3, 1.0, 0.55))).normalized()
        parts += obelisk(base, d, 1.25, 0.16, ACCENT)
    # cornes au-dessus des yeux (petites, vers l'avant/haut) + corne nasale
    for s in (1, -1):
        b = Q.dd.snap(body, (s * 0.5, -1.85, 3.9), -0.05)
        M = K.frame_from(b, Vector((s * 0.3, -0.45, 1)), up=(0, -1, 0))
        parts.append(K.xform(Q.P("CorneSourcil", "cone", BELLY, "Head", loc=(0, 0, 0.24), segments=6, r1=0.14,
                                 r2=0.0, depth=0.5), M))
    b = Q.dd.snap(body, (0, -3.0, 2.8), -0.04)
    M = K.frame_from(b, Vector((0, -0.35, 1)), up=(0, -1, 0))
    parts.append(K.xform(Q.P("CorneNez", "cone", BELLY, "Head", loc=(0, 0, 0.25), segments=6, r1=0.19, r2=0.0,
                             depth=0.5), M))
    # bec (pointe cornée) au bout du museau
    tip = Q.dd.snap(body, (0, -4.2, 1.85), -0.12)
    M = K.frame_from(tip, Vector((0, -1, -0.55)), up=(0, 0, 1))
    parts.append(K.xform(Q.P("Bec", "cone", BELLY, "Head", loc=(0, 0, 0.12), scale=(1, 0.75, 1), segments=8,
                             r1=0.36, r2=0.0, depth=0.5), M))
    # naseaux de braise
    for s in (1, -1):
        parts.append(Q.P("Braise", "sphere", GLOW, "Head", loc=Q.dd.snap(body, (s * 0.2, -3.75, 2.15), -0.005),
                         scale=(0.055, 0.04, 0.04), u=6, v=4))
    parts.append(crack_strips(body, [seg for tr, fk, b1, b2 in CRACKS for seg in ((tr, fk), (fk, b1), (fk, b2))]))
    # --- cratère sur le dos : cône tronqué + lave + rochers sur le bord
    _ok, top, nor, _ = body.ray_cast(Vector((0, 0.3, 12.0)), Vector((0, 0, -1)))  # milieu du dos (pas la tête)
    M = K.frame_from(top - nor * 0.12, nor, up=(0, -1, 0))
    parts.append(K.xform(Q.P("Cratere", "cone", BACK, spine, loc=(0, 0, 0.3), segments=10, r1=0.68, r2=0.38,
                             depth=0.6, cap=False), M))
    parts.append(K.xform(Q.P("CratereIn", "cone", MAIN, spine, loc=(0, 0, 0.3), segments=10, r1=0.6, r2=0.32,
                             depth=0.58, cap=False), M))
    parts[-1].data.flip_normals()
    parts.append(K.xform(Q.P("Lave", "cone", GLOW, spine, loc=(0, 0, 0.55), segments=10, r1=0.37, r2=0.35,
                             depth=0.04), M))
    for i in range(6):
        a = 2 * math.pi * i / 6 + 0.3
        parts.append(K.xform(Q.P("Roc", "sphere", BACK, spine, loc=(0.68 * math.cos(a), 0.68 * math.sin(a), 0.08),
                                 scale=(0.16, 0.13, 0.11), u=6, v=4), M))
    # petites pointes de basalte derrière le cratère, jusqu'à la queue
    back_spikes(body, parts, (0.7, 1.05, 1.4, 1.72), 0.3, 0.13, BACK)
    # --- pattes : colonnes de basalte hexagonales (manchon sur le bas de patte) + socle hexagonal au pied
    for keys, fb in ((Q.HIND_NODES, "B"), (Q.FRONT_NODES, "F")):
        g, c = Q.node(keys[1]), Q.node(keys[2])
        r = Q.radius(keys[1]) * 1.08
        z0, z1 = c.z + 0.02, g.z + 0.32
        parts.append(Q.P("Colonne", "cone", MAIN, "LowerLeg%s.S" % fb, loc=(c.x, (g.y + c.y) / 2, (z0 + z1) / 2),
                         mirror_x=True, segments=6, r1=r, r2=r, depth=z1 - z0))
        parts.append(Q.P("Chapiteau", "cone", BACK, "LowerLeg%s.S" % fb, loc=(c.x, (g.y + c.y) / 2, z1),
                         mirror_x=True, segments=6, r1=r * 1.12, r2=r * 1.0, depth=0.1))
        pd = Q.node(keys[3])
        parts.append(Q.P("Base", "cone", BACK, "Foot%s.S" % fb, loc=(pd.x, pd.y, 0.12), mirror_x=True, segments=6,
                         r1=r * 1.12, r2=r * 1.05, depth=0.2))


class Anims(ChibiAnims):
    # Joyeux : se dandine, queue qui frétille vite, 2 petites bouffées par le nez (tête qui se relève)
    def idle(self, t):
        self.base()
        br = R.S2(t, 2)
        puff = sum(math.exp(-((t - c) / 0.04) ** 2) for c in (0.3, 0.38, 0.7, 0.78))
        bounce = abs(R.S2(t, 4))
        c = self.crouch(t)
        self.hips(z=c["hz"] + 0.03 * bounce, rx=c["hrx"], rz=3 * R.S2(t, 2), ry=2 * R.S2(t, 2, 0.25))
        self.spine(rx=-0.8 * br, rz=-1.5 * R.S2(t, 2))
        self.neck(rx=c["nrx"] + 1.2 * br - 3 * puff, rz=4 * R.S2(t, 1))
        self.r("Head", (R.X, c["headx"] - 5 * puff + 2 * R.S2(t, 2, 0.3)), (R.Y, 6 * R.S2(t, 1, 0.1)),
               (R.Z, 4 * R.S2(t, 1)))
        self.r("Jaw", (R.X, 14 + 4 * puff))  # grand sourire
        self.tail(lambda i: ((R.Z, 14 * R.S2(t, 6, -0.06 * i)), (R.X, c["tailx"] + 2 * R.S2(t, 2, -0.1 * i))))

    # Charge cornes en avant : la tête est basse (cératopsien), on la baisse moins que la charge par défaut
    def attack(self, t):
        self.base()
        a = R.keys(t, [(0, 0), (0.3, 1), (0.4, 0), (1, 0)])
        s = R.keys(t, [(0, 0), (0.3, 0), (0.42, 1), (0.58, 1), (0.88, 0), (1, 0)])
        tos = R.keys(t, [(0, 0), (0.4, 0), (0.5, 1), (0.66, 0.2), (0.9, 0), (1, 0)])
        s2 = R.keys(t, [(0, 0), (0.36, 0), (0.5, 1), (0.66, 1), (0.95, 0), (1, 0)])
        self.hips(y=0.15 * a - 0.2 * s, z=-0.06 * a - 0.05 * s, rx=3 * a - 6 * tos)
        self.spine(rx=1 * a)
        self.neck(rx=1 * a - 9 * tos)
        self.r("Head", (R.X, 1 * a - 16 * tos), (R.Z, 6 * tos))
        self.r("Jaw", (R.X, 16 * tos + 3 * a))
        self.tail(lambda i: ((R.X, -6 * a + 5 * s2), (R.Z, 6 * s2 * R.S2(t, 2, -0.1 * i))))


S_ = sys.modules[__name__]
if __name__ == "__main__":
    lego_patch()
    Q.main(S_)
