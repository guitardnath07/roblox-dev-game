# DINO DICE — Chronoraptor (mythique, théropode) : modèle + rig + 7 animations + rendus de contrôle.
# Version : 1
# Référence réelle : Velociraptor (griffe en faucille relevée, queue droite et raide, bras repliés à plumes,
# museau long légèrement concave). Couche thématique (docs/dinos-concept.md) : griffe = aiguille d'horloge dorée,
# cadran cyan sur chaque flanc (12 graduations, 2 aiguilles mobiles), 3 engrenages dorés épaules/dos,
# crête = 3 aiguilles de montre en éventail, plumes de bras en aiguilles de pendule, sablier en bout de queue,
# yeux en petit cadran (iris cyan à 4 traits).
#
# Sans interface (n'ouvre ni ne touche la session Blender de l'utilisateur) :
#   blender -b --factory-startup --python-exit-code 1 -P blender/scripts/dinos/build_chronoraptor.py [-- model]
#   (« model » = modèle + rendu seulement, pour itérer sur la forme)
# Sortie : blender/dinos/chronoraptor.blend, docs/renders/dinos/chronoraptor_*.png
# Puis : blender -b blender/dinos/chronoraptor.blend --python-exit-code 1 -P blender/scripts/export_luau.py

import json
import math
import os
import sys

import bmesh
import bpy
from mathutils import Matrix, Vector
from mathutils.kdtree import KDTree

HERE = os.path.dirname(os.path.abspath(__file__))
SCRIPTS_DIR = os.path.dirname(HERE)
PROJECT_DIR = os.path.dirname(os.path.dirname(SCRIPTS_DIR))
if SCRIPTS_DIR not in sys.path:
    sys.path.insert(0, SCRIPTS_DIR)
import dd_common as dd  # noqa: E402
import build_theropod_rig as rig  # noqa: E402  (helpers génériques : rot, loc, reset_pose, key_all, bake, ik...)
if HERE not in sys.path:
    sys.path.insert(0, HERE)
import dd_dino_rig as R  # noqa: E402

ID = "chronoraptor"
NAME = "Chronoraptor"
HEIGHT = 6.0  # taille 1,5 x théropode de base (4 studs)
TRI_BUDGET = 5000
FPS = 30
RENDERS = os.path.join(PROJECT_DIR, "docs", "renders", "dinos")
BLEND = os.path.join(PROJECT_DIR, "blender", "dinos", ID + ".blend")

# Palette exportée dans DinoLooks (main / belly / accent / glow / back) ; slots 4, 5, 8, 9 fixés côté code.
COLORS = {"main": "#B0BEC5", "belly": "#FFE27A", "accent": "#FFB300", "glow": "#00E5FF", "back": "#546E7A"}
FIXED = {"white": "#FFFFFF", "pupil": "#1B1B22", "mouth": "#6A1B2A", "tongue": "#F06292"}
SLOT_HEX = [None, COLORS["main"], COLORS["belly"], COLORS["accent"], FIXED["white"], FIXED["pupil"], COLORS["glow"],
            COLORS["back"], FIXED["mouth"], FIXED["tongue"]]
C = [None] + [dd.hex_rgba(h) for h in SLOT_HEX[1:]]
MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, MOUTH, TONGUE = range(1, 10)

# Demi-squelette (x >= 0) pour le Skin : (clé, position, rayon, parent). Avant = -Y, haut = +Z.
NODES = [
    ("hanche", (0, 0.15, 2.05), 0.60, None),
    ("ventre", (0, -0.35, 2.08), 0.66, "hanche"),
    ("epaules", (0, -0.82, 2.28), 0.52, "ventre"),
    ("cou", (0, -1.08, 2.72), 0.40, "epaules"),
    ("cou2", (0, -1.12, 3.12), 0.42, "cou"),
    ("crane", (0, -1.30, 3.52), 0.86, "cou2"),
    ("machoire", (0, -1.85, 3.38), 0.60, "crane"),
    ("museau", (0, -2.35, 3.25), 0.42, "machoire"),
    ("nez", (0, -2.78, 3.27), 0.32, "museau"),
    # Queue raide et droite (Velociraptor)
    ("queue1", (0, 0.75, 2.10), 0.46, "hanche"),
    ("queue2", (0, 1.35, 2.16), 0.34, "queue1"),
    ("queue3", (0, 1.95, 2.20), 0.26, "queue2"),
    ("queue4", (0, 2.55, 2.22), 0.20, "queue3"),
    ("queue5", (0, 3.10, 2.22), 0.15, "queue4"),
    ("queue6", (0, 3.55, 2.22), 0.11, "queue5"),
    # Jambe (chaîne séparée) : longue, métatarse incliné
    ("bassin", (0.44, 0.10, 1.85), 0.50, None),
    ("cuisse", (0.56, -0.05, 1.40), 0.50, "bassin"),
    ("genou", (0.58, -0.32, 0.92), 0.25, "cuisse"),
    ("cheville", (0.56, 0.08, 0.40), 0.155, "genou"),
    ("pied", (0.56, -0.12, 0.13), 0.14, "cheville"),
    ("orteils", (0.56, -0.56, 0.08), 0.085, "pied"),  # orteil médian (porte l'os Toe)
    ("orteil_ext", (0.76, -0.45, 0.08), 0.075, "pied"),
    ("orteil_int", (0.40, -0.30, 0.22), 0.07, "pied"),  # 2e orteil relevé : porte la faucille-aiguille
    # Bras repliés (chaîne séparée), main à 3 doigts
    ("epaule", (0.40, -1.00, 2.10), 0.17, None),
    ("coude", (0.62, -1.08, 1.72), 0.13, "epaule"),
    ("main", (0.58, -1.42, 1.70), 0.10, "coude"),
    ("doigt1", (0.49, -1.62, 1.66), 0.045, "main"),
    ("doigt2", (0.60, -1.67, 1.63), 0.045, "main"),
    ("doigt3", (0.70, -1.58, 1.62), 0.045, "main"),
]
SPINE = ["queue6", "queue5", "queue4", "queue3", "queue2", "queue1", "hanche", "ventre", "epaules", "cou",
         "cou2", "crane", "machoire", "museau", "nez"]
LEG_NODES = {"bassin", "cuisse", "genou", "cheville", "pied", "orteils", "orteil_ext", "orteil_int"}
ARM_NODES = {"epaule", "coude", "main", "doigt1", "doigt2", "doigt3"}
LIMBS = LEG_NODES | ARM_NODES

# Engrenages (squelette) : centre (y, z), rayon, dents. Dents de même pas -> rapports de vitesse exacts.
GEARS = [("Gear1", (-0.05, 2.85), 0.48, 10), ("Gear2", (-0.80, 2.98), 0.34, 8), ("Gear3", (0.60, 2.66), 0.24, 6)]
DIAL = (0.0, -0.30, 2.02)  # centre du cadran (y, z utilisés ; x = surface du flanc)
DIAL_R = 0.34
# Plan de la bouche (squelette) : passe par la commissure, légèrement descendant vers le nez
MOUTH_Y0 = -1.70  # commissure (rien n'est coupé derrière)
MOUTH_P = Vector((0, -1.75, 3.17))
MOUTH_N = Vector((0, -0.06, 1)).normalized()
MOUTH_GAP = 0.02

# Groupes d'os par pièce : ("rigid", os) | ("dist", [os]) ; « .S » = côté choisi par le signe de x.
GROUPS = [None]


def grp(kind, bones):
    GROUPS.append((kind, bones))
    return len(GROUPS) - 1


def tag(ob, gi):
    a = ob.data.attributes.new("dd_grp", "INT", "POINT")
    a.data.foreach_set("value", [gi] * len(ob.data.vertices))
    return ob


def P(name, kind, rgba_slot, gi, **kw):
    return tag(dd.part(name, kind, COL, C[rgba_slot], **kw), gi)


def xform(ob, M):
    ob.data.transform(M)
    return ob


def frame_from(origin, normal, up=(0, 0, 1)):
    """Matrice locale : Z = normale, Y = « haut » projeté (12 h vers le haut)."""
    n = Vector(normal).normalized()
    u = Vector(up)
    u = (u - n * u.dot(n)).normalized()
    x = u.cross(n)
    M = Matrix((x, u, n)).transposed().to_4x4()
    M.translation = Vector(origin)
    return M


def flat_shape(name, slot, gi, outline2d, M, thick, mirror_x=False):
    """Pièce plate (aiguille, plume, engrenage) : contour 2D dans le plan local XY, placé par M."""
    pts = [M @ Vector((x, y, 0)) for x, y in outline2d]
    ob = dd.membrane(name, COL, C[slot], pts, thickness=thick, mirror_x=mirror_x)
    return tag(ob, gi)


def arrow(L, w, head=0.32, hw=2.4, tail=0.0):
    """Contour d'aiguille d'horloge le long de +Y : tige, pointe en losange."""
    hl = L * head
    return [(-w, -tail), (w, -tail), (w, L - hl), (w * hw, L - hl * 0.55), (0, L), (-w * hw, L - hl * 0.55),
            (-w, L - hl)]


def gear_outline(r, teeth):
    rr = r * 0.76
    pts = []
    for i in range(teeth):
        a = 2 * math.pi * i / teeth
        p = 2 * math.pi / teeth
        for da, rad in ((0.0, rr), (0.14, r), (0.36, r), (0.5, rr)):
            pts.append((rad * math.cos(a + da * p), rad * math.sin(a + da * p)))
    return pts


COL = None


def smile_dz(y):
    """Relèvement des commissures : monte de y = -2,25 à la commissure, puis s'efface derrière elle."""
    def sm(u):
        u = max(0.0, min(1.0, u))
        return u * u * (3 - 2 * u)
    return 0.10 * sm((y + 2.25) / 0.5) * (1 - sm((y - MOUTH_Y0) / 0.3))


def mouth_z(y):
    """Hauteur du plan de la bouche (squelette) à l'abscisse y."""
    return MOUTH_P.z + (-MOUTH_N.y / MOUTH_N.z) * (y - MOUTH_P.y)


def make_mouth(body):
    """Vraie bouche : coupe de la peau le long du plan de la bouche (fente ouverte), coque intérieure
    rouge sombre (normales vers l'intérieur : seule la face du fond se voit par la fente), poids de
    mâchoire mémorisés AVANT la courbe du sourire (attribut dd_jaw), puis commissures relevées."""
    me = body.data
    bm = bmesh.new()
    bm.from_mesh(me)
    for off in (-MOUTH_GAP, MOUTH_GAP):
        geom = [f for f in bm.faces if f.calc_center_median().y < MOUTH_Y0]
        geom = list({g for f in geom for g in (*f.verts, *f.edges)}) + geom
        bmesh.ops.bisect_plane(bm, geom=geom, plane_co=MOUTH_P + MOUTH_N * off, plane_no=MOUTH_N)
    jaw = bm.verts.layers.float.new("dd_jaw")
    shell = bm.faces.layers.int.new("dd_shell")
    for v in bm.verts:  # 1 sous la fente, 0 au-dessus (fondu dans la bande)
        v[jaw] = max(0.0, min(1.0, 0.5 - (v.co - MOUTH_P).dot(MOUTH_N) / (2 * MOUTH_GAP)))
    bm.normal_update()
    # Coque : faces de l'avant de la tête proches de la bouche, dupliquées, rentrées de 0,04, retournées
    src = [f for f in bm.faces if f.calc_center_median().y < MOUTH_Y0 + 0.15
           and abs((f.calc_center_median() - MOUTH_P).dot(MOUTH_N)) < 0.42]
    dup = bmesh.ops.duplicate(bm, geom=src)
    dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
    dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
    for v in dverts:
        v.co -= v.normal * 0.045
    bmesh.ops.reverse_faces(bm, faces=dfaces)
    for f in dfaces:
        f[shell] = 1
    # Fente : on retire la bande de peau extérieure entre les 2 coupes
    band = [f for f in bm.faces if not f[shell] and f.calc_center_median().y < MOUTH_Y0
            and abs((f.calc_center_median() - MOUTH_P).dot(MOUTH_N)) < MOUTH_GAP]
    bmesh.ops.delete(bm, geom=band, context="FACES")
    # Sourire : commissures relevées (fondu le long de la bouche et autour de la fente)
    for v in bm.verts:
        d = (v.co - MOUTH_P).dot(MOUTH_N)
        v.co.z += smile_dz(v.co.y) * math.exp(-(d / 0.16) ** 2)
    bm.to_mesh(me)
    bm.free()


def paint_body(body):
    me = body.data
    dd.fill_color(me, C[MAIN])
    dd.paint_ventral(me, NODES, SPINE, C[BELLY], cos_min=0.6, limbs=LIMBS, max_x=0.40)
    attr = me.color_attributes[dd.COLOR_ATTR]

    def paint(poly, slot):
        for li in poly.loop_indices:
            attr.data[li].color_srgb = C[slot]

    for poly in me.polygons:
        c, n = poly.center, poly.normal
        if c.y < -2.05 and c.z > 2.6:  # pas de ventre doré au bout du menton
            paint(poly, MAIN)
        # Dos bleu-gris foncé : du crâne au bout de la queue, sur le dessus du tronc (pas les membres)
        if n.z > 0.42 and abs(c.x) < 0.5 and c.z > 2.0 and c.y > -2.35:
            paint(poly, BACK)
    clean_islands(me, BELLY, MAIN)
    clean_islands(me, BACK, MAIN)
    for poly in me.polygons:
        c = poly.center
        # Rayures transverses (Velociraptor), qui descendent sur les flancs
        if c.z > 1.95 and 0.55 < c.y < 3.3 and (c.y % 0.6) < 0.15 and abs(c.x) < 0.62:
            paint(poly, DARK)
    sh = me.attributes["dd_shell"].data
    for poly in me.polygons:
        if sh[poly.index].value:
            paint(poly, MOUTH)


def build_mesh():
    global COL
    GROUPS[1:] = []
    sc, col, rcol = dd.setup_scene("DD_" + NAME, NAME)
    COL = col

    body = dd.skin_body(NAME + "_Corps", NODES, col, branch_smoothing=0.7, subdiv=1, smooth_iters=1, root="nez")
    make_mouth(body)
    paint_body(body)
    parts = [body]

    g_head, g_jaw = grp("rigid", "Head"), grp("rigid", "Jaw")
    # --- Yeux en petit cadran : blanc, iris cyan à 4 traits, pupille, 2 reflets (faits à droite puis symétrisés)
    _ok, loc, nor, _ = body.closest_point_on_mesh(Vector((0.48, -2.0, 3.86)))
    size = 0.34
    ec = loc - nor * size * 0.30
    look = (nor + Vector((-0.3, -1.6, 0.1))).normalized()
    parts.append(P("Oeil", "sphere", WHITE, g_head, loc=ec, scale=(size, size, size * 1.12), mirror_x=True, u=10, v=7))
    fr = frame_from(ec + look * size * 0.93, look)
    n0 = len(parts)
    parts.append(flat_poly("Iris", GLOW, g_head, circle(size * 0.66, 16), fr))
    parts.append(flat_poly("Pupille", DARK, g_head, circle(size * 0.32, 12), fr @ Matrix.Translation((0, 0, 0.012))))
    for k in range(4):
        a = k * math.pi / 2
        m = fr @ Matrix.Translation((math.cos(a) * size * 0.5, math.sin(a) * size * 0.5, 0.008)) @ \
            Matrix.Rotation(a, 4, "Z")
        parts.append(flat_poly("IrisTrait", DARK, g_head, rect(0.08, 0.028), m))
    parts.append(xform(P("Reflet", "sphere", WHITE, g_head, scale=(0.095, 0.095, 0.045), u=6, v=4),
                       fr @ Matrix.Translation((-size * 0.2, size * 0.24, 0.05))))
    parts.append(xform(P("Reflet2", "sphere", WHITE, g_head, scale=(0.04, 0.04, 0.025), u=6, v=4),
                       fr @ Matrix.Translation((size * 0.22, -size * 0.2, 0.04))))
    for ob in parts[n0:]:
        mirror_inplace(ob)
    # --- Narines
    parts.append(P("Narine", "sphere", DARK, g_head, loc=dd.snap(body, (0.14, -2.9, 3.48), -0.01),
                   scale=(0.06, 0.05, 0.04), mirror_x=True, u=6, v=4))
    # --- Dents : 1 paire de crocs visibles bouche fermée + rangées haut/bas visibles bouche ouverte, langue rose
    for row, (gi, sign, ys) in enumerate(((g_head, -1, (-2.62, -2.42, -2.2, -1.98)), (g_jaw, 1, (-2.5, -2.28, -2.06)))):
        for k, y in enumerate(ys):
            z = mouth_z(y) + smile_dz(y) - sign * (MOUTH_GAP + 0.01)
            _ok, sp, _n, _ = body.closest_point_on_mesh(Vector((1.0, y, z)))
            big = row == 0 and k == 1  # croc avant : visible bouche fermée ; les autres restent dedans
            x = max(0.06, sp.x - (0.05 if big else 0.16))
            L = 0.2 if big else 0.11
            parts.append(P("Dent", "cone", WHITE, gi, loc=(x, y, z + sign * L * 0.5 - sign * 0.01),
                           rot=(0 if sign > 0 else 180, 0, 0), mirror_x=True, segments=4,
                           r1=0.06 if big else 0.045, r2=0.0, depth=L))
    zt = mouth_z(-2.2) - 0.12
    parts.append(P("Langue", "sphere", TONGUE, g_jaw, loc=(0, -2.15, zt), scale=(0.2, 0.42, 0.07), u=10, v=6))

    # --- Crête : 3 aiguilles de montre effilées qui rayonnent d'un moyeu-engrenage sur le crâne
    hub = dd.snap(body, (0, -1.42, 4.6), -0.02)
    # heure (courte, large), minute (longue), trotteuse (fine, avec contrepoids)
    # Aiguilles « à pomme » : tige effilée + anneau doré à cœur cyan aux 2/3 (motif d'aiguille de montre)
    for i, (ang, L, w, tail, ring) in enumerate(((104, 0.66, 0.075, 0.0, 0.13), (156, 1.08, 0.06, 0.0, 0.12),
                                                 (130, 0.92, 0.03, 0.22, 0.0))):
        M = Matrix.Translation(hub) @ plane_yz(math.radians(ang))
        parts.append(flat_shape("Crete%d" % i, ACCENT, g_head, lance(L, w, tail), M, 0.07 - 0.015 * i))
        if ring:
            Mr = M @ Matrix.Translation((0, L * 0.62, 0))
            parts.append(flat_shape("CreteAnneau", ACCENT, g_head, circle(ring, 12), Mr, 0.07))
            parts.append(flat_poly("CreteCoeur", GLOW, g_head, circle(ring * 0.6, 10),
                                   Mr @ Matrix.Translation((0, 0, 0.037))))
            mirror_inplace(parts[-1])
    parts.append(flat_shape("CreteMoyeu", ACCENT, g_head, gear_outline(0.2, 8), Matrix.Translation(hub) @ plane_yz(0),
                            0.13))
    parts.append(P("CreteAxe", "cone", GLOW, g_head, loc=hub, rot=(0, 90, 0), segments=8, r1=0.06, r2=0.06,
                   depth=0.17))

    # --- Cadran sur chaque flanc (normale = X exact : les aiguilles tournent autour de X)
    g_spine = grp("rigid", "Spine1")
    _ok, dloc, _n, _ = body.closest_point_on_mesh(Vector((1.0, DIAL[1], DIAL[2])))
    dx = dloc.x + 0.02
    Md = Matrix.Translation((dx, DIAL[1], DIAL[2])) @ Matrix.Rotation(math.radians(90), 4, "Y") @ \
        Matrix.Rotation(math.radians(90), 4, "Z")  # local Z -> +X monde, local Y -> +Z monde (12 h en haut)
    n0 = len(parts)
    parts.append(xform(P("CadranBord", "cone", ACCENT, g_spine, segments=16, r1=DIAL_R + 0.07, r2=DIAL_R + 0.07,
                         depth=0.12), Md))
    parts.append(flat_poly("Cadran", GLOW, g_spine, circle(DIAL_R, 16), Md @ Matrix.Translation((0, 0, 0.062))))
    for k in range(12):
        a = k * math.pi / 6
        big = k % 3 == 0
        m = Md @ Matrix.Translation((math.sin(a) * DIAL_R * 0.8, math.cos(a) * DIAL_R * 0.8, 0.07)) @ \
            Matrix.Rotation(-a, 4, "Z")
        parts.append(flat_poly("Graduation", DARK, g_spine, rect(0.035, 0.11 if big else 0.06), m))
    g_min, g_hour = grp("rigid", "ClockMin"), grp("rigid", "ClockHour")
    for nm, gi, L, ang, z in (("AiguilleMin", g_min, DIAL_R * 0.85, 60, 0.08), ("AiguilleHeure", g_hour, DIAL_R * 0.55,
                                                                                 -60, 0.09)):
        m = Md @ Matrix.Translation((0, 0, z)) @ Matrix.Rotation(math.radians(-ang), 4, "Z")
        parts.append(flat_poly(nm, DARK, gi, watch_hand(L, 0.03, tail=0.06), m))
    parts.append(flat_poly("Axe", ACCENT, g_spine, circle(0.05, 8), Md @ Matrix.Translation((0, 0, 0.1))))
    for ob in parts[n0:]:
        mirror_inplace(ob)

    # --- Engrenages dorés sur le dos, moyeu cyan
    for gname, (gy, gz), r, n in GEARS:
        gi = grp("rigid", gname)
        M = Matrix.Translation((0, gy, gz)) @ plane_yz(0.0)
        parts.append(flat_shape(gname, ACCENT, gi, gear_outline(r, n), M, 0.16))
        parts.append(P(gname + "Moyeu", "cone", GLOW, gi, loc=(0, gy, gz), rot=(0, 90, 0), segments=8,
                       r1=r * 0.32, r2=r * 0.32, depth=0.22))

    # --- Sablier en bout de queue (axe = queue), sable cyan, disques dorés
    g_hg = grp("rigid", "Hourglass")
    tip = Vector((0, 3.56, 2.22))
    hl = 0.20
    for i, (y, rot) in enumerate(((tip.y + hl * 0.5, -90), (tip.y + hl * 1.5, 90))):
        parts.append(P("SablierVerre%d" % i, "cone", GLOW, g_hg, loc=(0, y, tip.z), rot=(rot, 0, 0), segments=8,
                       r1=0.17, r2=0.03, depth=hl))
    for i, y in enumerate((tip.y - 0.02, tip.y + hl * 2 + 0.02)):
        parts.append(P("SablierDisque%d" % i, "cone", ACCENT, g_hg, loc=(0, y, tip.z), rot=(90, 0, 0), segments=8,
                       r1=0.22, r2=0.22, depth=0.06))
    for i, a in enumerate((45, 165, 285)):
        x, z = 0.17 * math.cos(math.radians(a)), 0.17 * math.sin(math.radians(a))
        parts.append(P("SablierMontant%d" % i, "cube", ACCENT, g_hg, loc=(x, tip.y + hl, tip.z + z),
                       scale=(0.035, hl * 2, 0.035)))

    # --- Griffes : petites griffes au bout des 2 orteils au sol + des 3 doigts ; grande faucille-aiguille
    #     dorée sur l'orteil intérieur relevé
    pos = {k: Vector(v) for k, v, _r, _p in NODES}
    g_toe, g_foot, g_hand = grp("rigid", "Toe.S"), grp("rigid", "Foot.S"), grp("rigid", "LowerArm.S")
    for key, gi, ln, r1 in (("orteils", g_toe, 0.17, 0.06), ("orteil_ext", g_foot, 0.15, 0.055),
                            ("doigt1", g_hand, 0.09, 0.03), ("doigt2", g_hand, 0.09, 0.03),
                            ("doigt3", g_hand, 0.09, 0.03)):
        par = pos[[n for n in NODES if n[0] == key][0][3]]
        d = (pos[key] - par).normalized()
        tipp = pos[key] + d * 0.05
        q = d.to_track_quat("Z", "Y")
        parts.append(xform(P("Griffe", "cone", ACCENT, gi, segments=5, r1=r1, r2=0.0, depth=ln),
                           Matrix.Translation(tipp + d * ln * 0.35) @ q.to_matrix().to_4x4()))
        mirror_inplace(parts[-1])
    base = pos["orteil_int"] + Vector((0, 0.02, 0.02))
    M = Matrix.Translation(base) @ plane_yz(math.radians(32))  # aiguille relevée, pointée vers l'avant
    parts.append(flat_shape("Faucille", ACCENT, g_foot, watch_hand(0.5, 0.065, tail=0.04), M, 0.07, mirror_x=True))

    ob = dd.finalize(parts, ID + "_Mesh", "M_" + ID, target_height=HEIGHT, recalc_normals=False)
    # Origine entre les pieds (et non au centre de la boîte englobante, tirée vers l'arrière par la queue)
    m = skel_matrix(ob)
    fy = (m @ pos["cheville"].lerp(pos["orteils"], 0.5)).y
    T = Matrix.Translation((0, -fy, 0))
    ob.data.transform(T)
    ob["dd_skel_matrix"] = [v for row in (T @ m) for v in row]
    fix_shell_normals(ob)
    assign_slots(ob)
    split_sharp(ob, 50.0)
    st = dd.stats(ob)
    assert st["triangles"] <= TRI_BUDGET, st
    return sc, col, rcol, ob, st


def fix_shell_normals(ob):
    """finalize() recalcule les normales vers l'extérieur : la coque de la bouche doit regarder vers l'intérieur."""
    me = ob.data
    minv = skel_matrix(ob).inverted()
    bm = bmesh.new()
    bm.from_mesh(me)
    sh = bm.faces.layers.int.get("dd_shell")
    bm.normal_update()
    flip = []
    for f in bm.faces:
        if f[sh]:
            c = minv @ f.calc_center_median()
            axis = Vector((0, c.y, mouth_z(c.y)))
            if f.normal.dot(c - axis) > 0:
                flip.append(f)
    bmesh.ops.reverse_faces(bm, faces=flip)
    bm.to_mesh(me)
    bm.free()


def lance(L, w, tail=0.0):
    """Aiguille en lance : large au tiers, effilée jusqu'à la pointe ; contrepoids rond si tail > 0."""
    pts = [(-w * 0.5, 0), (w * 0.5, 0), (w, L * 0.3), (0, L), (-w, L * 0.3)]
    if tail:
        pts = [(-w * 0.5, 0)] + [(tail * 0.35 * math.cos(a), -tail + tail * 0.35 * math.sin(a))
                                 for a in [math.radians(d) for d in (200, 250, 290, 340)]] + pts[1:]
    return pts


def circle(r, n):
    return [(r * math.cos(2 * math.pi * i / n), r * math.sin(2 * math.pi * i / n)) for i in range(n)]


def rect(w, h):
    return [(-w / 2, -h / 2), (w / 2, -h / 2), (w / 2, h / 2), (-w / 2, h / 2)]


def watch_hand(L, w, tail=0.0):
    """Aiguille de montre effilée le long de +Y : tige qui s'affine, petit losange avant la pointe."""
    return [(-w, -tail), (w, -tail), (w * 0.55, L * 0.62), (w * 1.7, L * 0.74), (w * 0.25, L * 0.86), (0, L),
            (-w * 0.25, L * 0.86), (-w * 1.7, L * 0.74), (-w * 0.55, L * 0.62)]


def flat_poly(name, slot, gi, outline2d, M):
    """Polygone plat à UNE face (vu seulement de devant = +Z local), triangulé en éventail : peu de sommets."""
    bm = bmesh.new()
    vs = [bm.verts.new(M @ Vector((x, y, 0))) for x, y in outline2d]
    f = bm.faces.new(vs)
    bmesh.ops.poke(bm, faces=[f])
    me = bpy.data.meshes.new(name)
    bm.to_mesh(me)
    bm.free()
    dd.fill_color(me, C[slot])
    ob = bpy.data.objects.new(name, me)
    COL.objects.link(ob)
    return tag(ob, gi)


def plane_yz(angle):
    """Pièce plate du plan local XY -> plan YZ du monde (normale +X) ; le +Y local pointe à `angle` radians
    depuis l'avant (-Y) vers le haut (+Z) : 0 = avant, pi/2 = haut, pi = arrière."""
    d = Vector((0, -math.cos(angle), math.sin(angle)))
    x = Vector((1, 0, 0))
    return Matrix((d.cross(x), d, x)).transposed().to_4x4()

def mirror_inplace(ob):
    """Ajoute la copie symétrique (-X) dans le même mesh."""
    bm = bmesh.new()
    bm.from_mesh(ob.data)
    dup = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
    dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
    dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
    bmesh.ops.scale(bm, vec=(-1, 1, 1), verts=dverts)
    bmesh.ops.reverse_faces(bm, faces=dfaces)
    bm.to_mesh(ob.data)
    bm.free()


def clean_islands(me, slot_a, slot_b, passes=2):
    """Faces isolées (taches) : une face `slot_a` entourée surtout de `slot_b` repasse en `slot_b`, et inversement."""
    attr = me.color_attributes[dd.COLOR_ATTR]
    ca, cb = Vector(C[slot_a][:3]), Vector(C[slot_b][:3])
    bm = bmesh.new()
    bm.from_mesh(me)
    bm.faces.ensure_lookup_table()
    for _ in range(passes):
        col = [Vector(attr.data[me.polygons[f.index].loop_indices[0]].color_srgb[:3]) for f in bm.faces]
        is_a = [(c - ca).length < 0.02 for c in col]
        is_b = [(c - cb).length < 0.02 for c in col]
        for f in bm.faces:
            nb = {g.index for e in f.edges for g in e.link_faces if g.index != f.index}
            for mine, other, rgba in ((is_a, is_b, C[slot_b]), (is_b, is_a, C[slot_a])):
                if mine[f.index] and sum(other[i] for i in nb) >= len(nb) - 1 and len(nb) >= 3:
                    for li in me.polygons[f.index].loop_indices:
                        attr.data[li].color_srgb = rgba
    bm.free()


def split_sharp(ob, angle_deg):
    """Ombrage lisse partout, arêtes vives (> angle) séparées : les sommets exportés portent déjà les
    coupures, donc les normales automatiques de Roblox (EditableMesh) donnent le même rendu que Blender."""
    me = ob.data
    bm = bmesh.new()
    bm.from_mesh(me)
    lim = math.radians(angle_deg)
    sharp = [e for e in bm.edges if len(e.link_faces) == 2 and e.calc_face_angle(0.0) > lim]
    bmesh.ops.split_edges(bm, edges=sharp)
    bm.to_mesh(me)
    bm.free()
    me.shade_smooth()


def assign_slots(ob):
    """Slot de couleur par face (attribut FACE « dd_slot ») = couleur de palette la plus proche."""
    me = ob.data
    attr = me.color_attributes[dd.COLOR_ATTR]
    pal = [(s, Vector(C[s][:3])) for s in range(1, len(C))]
    slots = []
    for p in me.polygons:
        c = Vector(attr.data[p.loop_indices[0]].color_srgb[:3])
        slots.append(min(pal, key=lambda e: (e[1] - c).length)[0])
    a = me.attributes.get("dd_slot") or me.attributes.new("dd_slot", "INT", "FACE")
    a.data.foreach_set("value", slots)
    # couleurs « propres » (exactes) pour les rendus
    for p, s in zip(me.polygons, slots):
        for li in p.loop_indices:
            attr.data[li].color_srgb = C[s]


# ------------------------------------------------------------------ rendus

def setup_cam(sc, rcol):
    cam = dd.setup_render(sc, rcol, target=(0, 0, HEIGHT * 0.45), distance=12, azimuth=-40, height_ratio=0.3)
    sc.display.shading.show_cavity = False
    sc.display.shading.show_specular_highlight = True
    sc.display.shading.show_backface_culling = True  # comme Roblox (faces simples, coque de la bouche)
    sc.world.color = (0.16, 0.19, 0.27)  # fond sombre : l'argent et l'or ressortent
    return cam


def render_still(sc, name, azimuth=-40, h=0.3, dist=12.5, target=None, res=900):
    rig.place_cam(sc, target or (0, 0.3, HEIGHT * 0.45), azimuth, dist, h)
    sc.render.resolution_x = sc.render.resolution_y = res
    os.makedirs(RENDERS, exist_ok=True)
    return dd.render_to(sc, os.path.join(RENDERS, "%s_%s.png" % (ID, name)))


# ------------------------------------------------------------------ rig

ARM = ID + "_Armature"
SIDES = (("L", 1.0), ("R", -1.0))  # +X = gauche du dino (il regarde vers -Y)
LEG = ("UpperLeg", "LowerLeg", "Foot", "Toe")
ARMB = ("UpperArm", "LowerArm")
NT = 4  # os de queue (30 os au total : budget du runtime)
TRUNK = ["Hips", "Spine1", "Spine2", "Neck1", "Neck2", "Head"] + ["Tail%d" % i for i in range(1, NT + 1)]
GEAR_PARENT = {"Gear1": "Spine1", "Gear2": "Spine2", "Gear3": "Spine1"}


def bone_specs_skel():
    """(nom, tête, queue, parent, connecté, déforme) en coordonnées SQUELETTE (celles de NODES)."""
    p = {k: Vector(v) for k, v, _r, _par in NODES}
    h, v, e = p["hanche"], p["ventre"], p["epaules"]
    hv, ve = h.lerp(v, 0.5), v.lerp(e, 0.5)
    s = [
        ("Hips", h, hv, "Root", False, True),
        ("Spine1", hv, ve, "Hips", True, True),
        ("Spine2", ve, e, "Spine1", True, True),
        ("Neck1", e, p["cou"], "Spine2", True, True),
        ("Neck2", p["cou"], p["cou2"], "Neck1", True, True),
        ("Head", p["cou2"], p["nez"], "Neck2", True, True),
        ("Jaw", Vector((0, -1.55, 3.08)), Vector((0, -2.85, 3.02)), "Head", False, True),
        ("ClockMin", Vector((0, DIAL[1], DIAL[2])), Vector((0.4, DIAL[1], DIAL[2])), "Spine2", False, True),
        ("ClockHour", Vector((0, DIAL[1], DIAL[2])), Vector((0.3, DIAL[1], DIAL[2])), "Spine2", False, True),
    ]
    for gname, (gy, gz), _r, _n in GEARS:
        s.append((gname, Vector((0, gy, gz)), Vector((0.4, gy, gz)), GEAR_PARENT[gname], False, True))
    # Queue : NT os répartis à longueur égale le long de la polyligne des nœuds queue1..queue6
    poly = [h.lerp(p["queue1"], 0.5)] + [p["queue%d" % i] for i in range(1, 7)]
    acc = [0.0]
    for a, b in zip(poly, poly[1:]):
        acc.append(acc[-1] + (b - a).length)

    def at(d):
        for k in range(len(poly) - 1):
            if d <= acc[k + 1] + 1e-9:
                return poly[k].lerp(poly[k + 1], (d - acc[k]) / (acc[k + 1] - acc[k]))
        return poly[-1].copy()
    tail = [at(acc[-1] * i / NT) for i in range(NT + 1)]
    for i in range(NT):
        s.append(("Tail%d" % (i + 1), tail[i], tail[i + 1], "Hips" if i == 0 else "Tail%d" % i, i > 0, True))
    s.append(("Hourglass", tail[NT], tail[NT] + Vector((0, 0.5, 0)), "Tail%d" % NT, True, True))
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


def skel_matrix(ob):
    v = list(ob["dd_skel_matrix"])
    return Matrix([v[0:4], v[4:8], v[8:12], v[12:16]])


def rig_mesh(col, ob):
    m = skel_matrix(ob)
    skel = bone_specs_skel()
    specs = [("Root", Vector((0, 0, 0)), Vector((0, 0, 0.8)), None, False, False)]
    specs += [(n, m @ hd, m @ tl, par, con, dfm) for n, hd, tl, par, con, dfm in skel]
    arm = R.build_armature(col, ARM, specs)
    segs = {n: (hd, tl) for n, hd, tl, *_ in skel}  # segments en coordonnées squelette
    minv = m.inverted()
    me = ob.data
    S = [minv @ v.co for v in me.vertices]
    gattr = me.attributes["dd_grp"].data
    G = [gattr[i].value for i in range(len(me.vertices))]
    jattr = me.attributes["dd_jaw"].data
    JAW = [jattr[i].value for i in range(len(me.vertices))]

    # Peau : îlots classés (tronc / jambe / bras) par le nœud le plus proche de leur centre
    isl = rig.islands(me)
    region = [None] * len(me.vertices)
    for g in isl:
        if G[g[0]] != 0:
            continue
        c = sum((S[i] for i in g), Vector()) / len(g)
        side = "L" if c.x > 0 else "R"
        c.x = abs(c.x)
        node = min(NODES, key=lambda n: (Vector(n[1]) - c).length / n[2])[0]
        kind = "leg" if node in LEG_NODES else "arm" if node in ARM_NODES else "trunk"
        for i in g:
            region[i] = (kind, side)

    sigma = 0.07
    W = []
    for i, s in enumerate(S):
        side = "L" if s.x > 0 else "R"
        gi = G[i]
        if gi == 0:
            kind = region[i][0]  # côté = signe de x du sommet (les 2 jambes peuvent former un seul îlot)
            if kind == "leg":
                bones = ["%s.%s" % (n, side) for n in LEG] + ["Hips"]
            elif kind == "arm":
                bones = ["%s.%s" % (n, side) for n in ARMB] + ["Spine2"]
            else:
                bones = TRUNK
            wd = R.dist_weights(s, bones, segs, sigma)
            if kind == "trunk":
                # Mâchoire : sous le plan de la bouche (fondu dans la fine bande), devant la commissure
                fy = max(0.0, min(1.0, (MOUTH_Y0 + 0.12 - s.y) / 0.3))
                jw = fy * JAW[i] if s.z > 2.6 else 0.0  # dd_jaw : calculé avant la courbe du sourire
                if jw > 0:
                    wd = {k: v * (1 - jw) for k, v in wd.items()}
                    wd["Jaw"] = wd.get("Jaw", 0.0) + jw
        else:
            kind, b = GROUPS[gi]
            if kind == "rigid":
                wd = {b.replace(".S", "." + side): 1.0}
            else:
                wd = R.dist_weights(s, [x.replace(".S", "." + side) for x in b], segs, sigma)
        W.append(wd)
    info = R.apply_weights(ob, arm, W)
    assert info["max_influences"] <= 4 and info["sans_poids"] == 0, info
    assert not info["os_deformants_sans_poids"], info
    return arm, m[0][0], info


# ------------------------------------------------------------------ animations (t dans [0, 1])

def gears(Pb, adv_teeth, sign=1.0):
    """Engrenages : chacun avance de `adv_teeth` dents (même pas -> engrènement), sens alternés."""
    for k, (gname, _c, _r, n) in enumerate(GEARS):
        d = sign * (1.0 if k == 0 else -1.0)
        rig.rot(Pb[gname], (R.X, d * adv_teeth * 360.0 / n))


class Anims:
    def __init__(self, arm, u):
        self.arm, self.u, self.P = arm, u, arm.pose.bones

    def base(self):
        rig.reset_pose(self.arm)
        return self.P

    def hips(self, x=0.0, y=0.0, z=0.0, rx=0.0, ry=0.0, rz=0.0):
        P, u = self.P, self.u
        rig.loc(P["Hips"], (x * u, y * u, z * u))
        rig.rot(P["Hips"], (R.X, rx), (R.Y, ry), (R.Z, rz))

    def tail(self, fn):
        """fn(i) écrit pour 6 segments : rééchantillonné sur NT os, angles mis à l'échelle (même courbure totale)."""
        k = 6.0 / NT
        for i in range(NT):
            rig.rot(self.P["Tail%d" % (i + 1)], *[(ax, deg * k) for ax, deg in fn(i * k)])

    # Idle : respiration, regarde son cadran (flanc gauche), tape du pied, sursaute ; engrenages qui tournent
    def idle(self, t):
        P = self.base()
        br = R.S2(t, 2)
        c = R.keys(t, [(0, 0), (0.18, 0), (0.27, 1), (0.42, 1), (0.5, 0), (1, 0)])
        st = R.keys(t, [(0, 0), (0.84, 0), (0.87, 1), (0.92, 0.35), (1, 0)])
        tap = math.sin(math.pi * 4 * (t - 0.56) / 0.22) ** 2 if 0.56 < t < 0.78 else 0.0
        self.hips(z=-0.02 + 0.02 * br + 0.12 * st, rx=-5 * st, rz=3 * R.S2(t, 1))
        for i, n in enumerate(("Spine1", "Spine2")):
            rig.rot(P[n], (R.X, -1.5 * br), (R.Z, 4 * c))
        rig.rot(P["Neck1"], (R.X, 2 * br + 14 * c - 8 * st), (R.Z, 10 * c))
        rig.rot(P["Neck2"], (R.X, 8 * c), (R.Z, 8 * c + 5 * R.S2(t, 1, 0.2) * (1 - c)))
        rig.rot(P["Head"], (R.X, 3 * R.S2(t, 2, 0.3) + 16 * c - 14 * st),
                (R.Z, 16 * c + 9 * R.S2(t, 1, 0.25) * (1 - c)), (R.Y, -12 * c))
        rig.rot(P["Jaw"], (R.X, 3 * max(0.0, br) + 28 * st))
        self.tail(lambda i: ((R.Z, 5 * R.S2(t, 1, -0.08 * i)), (R.X, 2 * R.S2(t, 2, -0.1 * i) - 5 * st)))
        for side, sx in SIDES:
            rig.rot(P["UpperArm." + side], (R.X, -8 * R.S2(t, 2, 0.1) - 35 * st))
            rig.rot(P["LowerArm." + side], (R.X, -10 * R.S2(t, 2, 0.2) - 20 * st))
        rig.rot(P["Toe.R"], (R.X, -28 * tap))
        gears(P, 2 * t)
        rig.rot(P["ClockMin"], (R.X, -360 * t))
        rig.rot(P["Hourglass"], (R.Z, 6 * R.S2(t, 1, -0.5)))

    def walk(self, t):
        P = self.base()
        bob = math.cos(2 * math.pi * 2 * t)  # 1 aux contacts (t = 0 ; 0,5)
        self.hips(z=-0.08 - 0.07 * bob, rx=7, rz=8 * R.S2(t, 1), ry=4 * R.S2(t, 1, 0.25))
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.Z, -3 * R.S2(t, 1)), (R.X, 1.5 * bob))
        # hochement de tête « d'oiseau » : le cou avance et recule, la tête reste à l'horizontale
        rig.rot(P["Neck1"], (R.X, -5 + 6 * R.S2(t, 2, 0.1)))
        rig.rot(P["Neck2"], (R.X, -4 * R.S2(t, 2, 0.1)))
        rig.rot(P["Head"], (R.X, -3 - 3 * R.S2(t, 2, 0.15)), (R.Z, -5 * R.S2(t, 1)))
        rig.rot(P["Jaw"], (R.X, 4 + 3 * max(0.0, -bob)))
        self.tail(lambda i: ((R.Z, -8 * R.S2(t, 1, -0.06 * (i + 1))), (R.X, 2 + 3 * R.S2(t, 2, -0.08 * i))))
        for side, sx in SIDES:
            sw = R.S2(t, 1, 0.25) * (1 if side == "L" else -1)
            rig.rot(P["UpperArm." + side], (R.X, 22 * sw))
            rig.rot(P["LowerArm." + side], (R.X, 14 * R.S2(t, 1, 0.35) * (1 if side == "L" else -1) - 10))
        gears(P, t)
        rig.rot(P["ClockMin"], (R.X, -360 * t))
        rig.rot(P["Hourglass"], (R.Z, 12 * R.S2(t, 1, -0.3)))

    def run(self, t):
        P = self.base()
        low = math.cos(2 * math.pi * 2 * (t - 0.17))  # 1 au milieu de l'appui
        self.hips(z=-0.12 - 0.14 * low, rx=13, rz=6 * R.S2(t, 1))
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, 2 * low))
        rig.rot(P["Neck1"], (R.X, -10 + 4 * low))
        rig.rot(P["Neck2"], (R.X, -4))
        rig.rot(P["Head"], (R.X, -4 - 4 * low), (R.Z, -3 * R.S2(t, 1)))
        rig.rot(P["Jaw"], (R.X, 14 + 6 * low))
        self.tail(lambda i: ((R.Z, -5 * R.S2(t, 1, -0.07 * (i + 1))), (R.X, -2.5 + 3 * R.S2(t, 2, -0.1 * (i + 1)))))
        for side, sx in SIDES:
            ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
            # poussée : les orteils se relèvent quand le pied part loin derrière (la griffe ne raye pas le sol)
            push = R.keys(ph, [(0, 0), (0.2, 0), (0.36, 1), (0.55, 0.6), (0.75, 0), (1, 0)])
            rig.rot(P["Toe." + side], (R.X, -45 * push))
            rig.rot(P["UpperArm." + side], (R.X, 40 + 8 * low))
            rig.rot(P["LowerArm." + side], (R.X, -55))
        gears(P, 1 * t)
        rig.rot(P["ClockMin"], (R.X, -360 * t))
        rig.rot(P["Hourglass"], (R.Z, 18 * R.S2(t, 1, -0.35)))

    # Attaque : anticipation (accroupi, recule), bond + coup de griffe-aiguille + morsure, retour
    def attack(self, t):
        P = self.base()
        a = R.keys(t, [(0, 0), (0.28, 1), (0.36, 0), (1, 0)])
        s = R.keys(t, [(0, 0), (0.28, 0), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
        s2 = R.keys(t, [(0, 0), (0.34, 0), (0.46, 1), (0.62, 1), (0.92, 0), (1, 0)])  # suivi (queue)
        j = R.keys(t, [(0, 0), (0.25, 0.3), (0.36, 1), (0.43, 0), (0.5, 0.2), (0.65, 0), (1, 0)])
        self.hips(y=0.25 * a - 0.55 * s, z=-0.32 * a + 0.22 * s, rx=-10 * a + 16 * s)
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, 4 * a - 3 * s))
        rig.rot(P["Neck1"], (R.X, -18 * a + 14 * s))
        rig.rot(P["Neck2"], (R.X, -8 * a + 6 * s))
        rig.rot(P["Head"], (R.X, -12 * a - 6 * s))
        rig.rot(P["Jaw"], (R.X, 50 * j))
        self.tail(lambda i: ((R.X, 7 * a - 6 * s2 + 3 * s), (R.Z, 4 * s2 * R.S2(t, 2))))
        for side, sx in SIDES:
            rig.rot(P["UpperArm." + side], (R.X, -55 * a - 35 * s), (R.Y, -sx * 20 * a))
            rig.rot(P["LowerArm." + side], (R.X, -40 * a + 35 * s))
        rig.rot(P["Toe.R"], (R.X, -25 * s))
        rig.rot(P["Toe.L"], (R.X, -20 * s))
        g = R.keys(t, [(0, 0), (0.3, 0.3), (0.6, 2.5), (1, 3)])
        gears(P, g)
        rig.rot(P["ClockMin"], (R.X, -360 * g / 3))
        rig.rot(P["Hourglass"], (R.Z, 25 * (s2 - s)))

    def attack_feet(self, side, t, ank, toe):
        u = self.u
        s = R.keys(t, [(0, 0), (0.3, 0), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
        if side == "R":  # coup de pied-faucille vers l'avant et le haut
            off = Vector((0, -1.0 * s * u, 0.75 * s * u))
            return ank + off, toe + off + Vector((0, 0, 0.25 * s * u))
        return ank, toe

    # Rugissement : anticipation (tête basse), se cabre, gueule grande ouverte qui tremble, rouages qui s'emballent
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
        rig.rot(P["Jaw"], (R.X, 6 * a + 52 * r))
        self.tail(lambda i: ((R.X, -4 * a + 6 * r), (R.Z, 3 * R.S2(t, 7, -0.1 * i) * r)))
        for side, sx in SIDES:
            rig.rot(P["UpperArm." + side], (R.X, -20 * a - 55 * r), (R.Y, -sx * 35 * r))
            rig.rot(P["LowerArm." + side], (R.X, -30 * r))
        g = R.keys(t, [(0, 0), (0.2, 0.2), (0.8, 6), (1, 6.5)])
        gears(P, g)
        rig.rot(P["ClockMin"], (R.X, -720 * g / 6.5))
        rig.rot(P["ClockHour"], (R.X, -180 * g / 6.5))
        rig.rot(P["Hourglass"], (R.Z, 10 * sh))

    # Célébration : 2 sauts de joie, bras qui s'agitent, queue qui frétille, le sablier fait un salto par saut
    def hop(self, t):
        h1 = math.sin(math.pi * (t - 0.12) / 0.26) if 0.12 < t < 0.38 else 0.0
        h2 = math.sin(math.pi * (t - 0.50) / 0.26) if 0.50 < t < 0.76 else 0.0
        sq = sum(math.exp(-((t - c) / 0.035) ** 2) for c in (0.1, 0.4, 0.48, 0.78))
        return h1 + h2, sq

    def celebrate(self, t):
        P = self.base()
        air, sq = self.hop(t)
        joy = R.keys(t, [(0, 0), (0.08, 1), (0.85, 1), (1, 0)])
        self.hips(z=0.75 * air - 0.22 * sq, rx=-10 * air + 6 * sq, rz=6 * R.S2(t, 2) * joy)
        for n in ("Spine1", "Spine2"):
            rig.rot(P[n], (R.X, -3 * air + 3 * sq))
        rig.rot(P["Neck1"], (R.X, -10 * air * joy + 8 * sq))
        rig.rot(P["Head"], (R.X, -8 * joy), (R.Y, 14 * R.S2(t, 2) * joy))
        rig.rot(P["Jaw"], (R.X, 30 * joy))
        self.tail(lambda i: ((R.Z, 16 * R.S2(t, 3, -0.07 * i) * joy), (R.X, 8 * air - 4 * sq)))
        for side, sx in SIDES:
            w = R.S2(t, 5, 0 if side == "L" else 0.5) * joy
            rig.rot(P["UpperArm." + side], (R.X, (-60 + 25 * w) * joy), (R.Y, -sx * 30 * joy))
            rig.rot(P["LowerArm." + side], (R.X, -30 * w))
        flip = R.keys(t, [(0, 0), (0.14, 0), (0.36, 180), (0.52, 180), (0.74, 360), (1, 360)])
        rig.rot(P["Hourglass"], (R.X, flip))
        g = R.keys(t, [(0, 0), (1, 5)])
        gears(P, g)
        rig.rot(P["ClockMin"], (R.X, -720 * t))
        rig.rot(P["ClockHour"], (R.X, -60 * t))

    def celebrate_feet(self, side, t, ank, toe):
        air, _sq = self.hop(t)
        off = Vector((0, 0, 0.6 * air * self.u))
        return ank + off, toe + off + Vector((0, 0, -0.1 * air * self.u))

    # Mort : coup reçu (recul), vacille, s'écroule sur le flanc droit avec un petit rebond ; rouages ralentissent
    def death(self, t):
        P = self.base()
        h = R.keys(t, [(0, 0), (0.08, 1), (0.3, 0.3), (0.45, 0)])
        w = R.S2(t, 3) * R.keys(t, [(0, 0), (0.12, 0), (0.22, 1), (0.42, 0), (1, 0)])
        f = R.keys(t, [(0, 0), (0.36, 0), (0.62, 1), (0.71, 0.9), (0.8, 1), (1, 1)])
        lift = 0.3 * math.sin(math.pi * min(1.0, f))  # les hanches montent un peu pendant la bascule : le pied ne raye pas le sol
        self.hips(y=0.3 * h, z=-DEATH_DROP * f + lift, rx=-12 * h, rz=8 * w, ry=-80 * f)
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
        g = 2.5 * (1 - (1 - t) ** 2)
        gears(P, g)
        rig.rot(P["ClockMin"], (R.X, -270 * (1 - (1 - t) ** 3)))
        rig.rot(P["Hourglass"], (R.Z, 25 * w), (R.X, 20 * f))


DEATH_DROP = 0.52  # descente des hanches (squelette) une fois couché sur le flanc (réglée au rendu)

CLIPS = [  # nom, images à 30 i/s (paires : export à 15 i/s), boucle
    ("Idle", 120, True), ("Walk", 30, True), ("Run", 16, True), ("Attack", 30, False),
    ("Roar", 44, False), ("Celebrate", 40, False), ("Death", 44, False),
]


def animate(arm, col, u, mesh_ob):
    A = Anims(arm, u)
    step, lift = 1.0 * u, 0.42 * u
    rstep, rlift = 1.8 * u, 0.6 * u

    def cyc(side, t, ank, toe, st, lf, stance):
        ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
        if ph < stance:
            q = ph / stance
            dy, dz, drop = -st / 2 + st * q, 0.0, 0.0
        else:
            q = (ph - stance) / (1 - stance)
            sm = 0.5 - 0.5 * math.cos(math.pi * q)
            dy, dz, drop = st / 2 - st * sm, lf * math.sin(math.pi * q), 0.12 * u * math.sin(math.pi * q)
        off = Vector((0, dy, dz))
        return ank + off, toe + off - Vector((0, 0, drop))

    feet = {
        "Idle": lambda s, t, a, b: (a, b),
        "Walk": lambda s, t, a, b: cyc(s, t, a, b, step, lift, 0.5),
        "Run": lambda s, t, a, b: cyc(s, t, a, b, rstep, rlift, 0.36),
        "Attack": A.attack_feet,
        "Roar": lambda s, t, a, b: (a, b),
        "Celebrate": A.celebrate_feet,
        "Death": None,
    }
    acts, out = {}, {}
    for clip, length, loop in CLIPS:
        act = R.make_action(arm, col, ID, clip, length, loop, getattr(A, clip.lower()), feet[clip])
        lo = R.min_z(mesh_ob, arm, act, step=1)
        for _ in range(6):  # Mort : on remonte la chute jusqu'à ce que rien ne passe sous le sol
            if clip != "Death" or lo > -0.02:
                break
            global DEATH_DROP
            DEATH_DROP -= (0.01 - lo) / u
            act = R.make_action(arm, col, ID, clip, length, loop, getattr(A, clip.lower()), feet[clip])
            lo = R.min_z(mesh_ob, arm, act, step=1)
        acts[clip] = act
        info = {"images": length, "boucle": loop, "min_z": round(lo, 3)}
        if clip == "Death":
            info["descente_hanches"] = round(DEATH_DROP, 3)
        if loop:
            info["erreur_boucle"] = round(R.loop_error(arm, act), 5)
        out[clip] = info
    return acts, out


def save_blend(sc):
    for s in list(bpy.data.scenes):
        if s != sc:
            for o in list(s.collection.all_objects):
                if len(o.users_scene) == 1:
                    bpy.data.objects.remove(o, do_unlink=True)
            bpy.data.scenes.remove(s)
    sc["dd_id"] = ID
    sc["dd_colors"] = json.dumps(COLORS)
    os.makedirs(os.path.dirname(BLEND), exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=BLEND, check_existing=False)
    return BLEND

def main():
    args = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    sc, col, rcol, ob, st = build_mesh()
    setup_cam(sc, rcol)
    out = {"mesh": st}
    out["r34"] = render_still(sc, "34")
    out["rside"] = render_still(sc, "side", azimuth=-90, h=0.1)
    out["rback"] = render_still(sc, "back34", azimuth=140, h=0.45)
    out["rfront"] = render_still(sc, "front", azimuth=0, h=0.15)
    if "model" in args:
        print("DD_RESULT", json.dumps(out))
        return
    arm, u, winfo = rig_mesh(col, ob)
    out["poids"] = winfo
    out["os"] = len(arm.data.bones)
    acts, out["clips"] = animate(arm, col, u, ob)
    tmp = os.path.join(bpy.app.tempdir or os.environ.get("TEMP", "."), "dd_chrono")
    sheets = [("Idle", 8), ("Walk", 8), ("Run", 8), ("Attack", 8), ("Roar", 8), ("Celebrate", 8), ("Death", 8)]
    if "norender" not in args:
        for clip, n in sheets:
            act = acts[clip]
            arm.animation_data.action = act
            L = int(act["dd_len"])
            frames = [round(i * L / (n if act["dd_loop"] else n - 1)) for i in range(n)]
            az = -90 if clip in ("Walk", "Run") else -40
            rig.place_cam(sc, (0, 0.3, HEIGHT * 0.42), az, 14, 0.2)
            out["rendu_" + clip] = R.render_sheet(sc, frames, os.path.join(RENDERS, "%s_%s.png" % (ID, clip.lower())),
                                                  tmp)
    arm.animation_data.action = acts["Idle"]
    sc.frame_set(0)
    out["fichier"] = save_blend(sc)
    print("DD_RESULT", json.dumps(out, default=str))


if __name__ == "__main__":
    if HERE not in sys.path:
        sys.path.insert(0, HERE)
    main()
