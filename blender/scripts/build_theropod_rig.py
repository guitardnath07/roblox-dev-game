# DINO DICE — Rig + animations du THÉROPODE (armature faite main, sans Rigify).
# Version : 2 (v2 : Walk penché vers l'avant, queue relevée ; garde-fou si le Bone Heat échoue)
# Reconstruit le mesh (build_theropod), crée l'armature « Theropode_Armature », les poids, les actions
# « Idle » (4 s) et « Walk » (1 s) à 30 i/s, les rendus de vérification, puis enregistre blender/rigs/theropod.blend.
#
# Règles Roblox appliquées :
#   - os racine « Root » à (0, 0, 0), sans poids (use_deform = False) ;
#   - objets armature + mesh à transform identité (rotation 0, échelle 1), aucun roll exotique ;
#   - max 4 influences par sommet, poids normalisés ;
#   - noms d'os uniques, jamais égaux au nom d'un mesh.
# Les pieds des deux actions sont posés par IK temporaire (cibles = empties), puis tout est « baké » en FK
# (contraintes supprimées) : les FBX ne contiennent que des os.

import importlib
import math
import os
import sys

import bmesh
import bpy
import numpy as np
from mathutils import Matrix, Quaternion, Vector
from mathutils.kdtree import KDTree

SCRIPTS_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(os.path.dirname(SCRIPTS_DIR))
if SCRIPTS_DIR not in sys.path:
    sys.path.insert(0, SCRIPTS_DIR)
import dd_common as dd  # noqa: E402
import build_theropod as bt  # noqa: E402

importlib.reload(dd)
importlib.reload(bt)

ARM_NAME = "Theropode_Armature"
FPS = 30
IDLE_LEN = 120  # 4 s
WALK_LEN = 30  # 1 s
STEP = 0.9  # longueur de pas (studs)
LIFT = 0.35  # hauteur de levée du pied (studs)
RENDERS = os.path.join(PROJECT_DIR, "docs", "renders")
TMP = os.path.join(bpy.app.tempdir or os.environ.get("TEMP", "."), "dd_frames")

LEG_BONES = ("UpperLeg", "LowerLeg", "Foot", "Toe")
SIDES = (("L", 1.0), ("R", -1.0))  # +X = gauche du dino (il regarde vers -Y)


# ------------------------------------------------------------------ squelette

def skel_matrix(mesh_ob):
    v = list(mesh_ob["dd_skel_matrix"])
    return Matrix([v[0:4], v[4:8], v[8:12], v[12:16]])


def bone_specs(m):
    """(nom, tête, queue, parent, connecté, déforme) en coordonnées finales, posés sur les nœuds du Skin."""
    pos = {k: Vector(p) for k, p, _r, _par in bt.NODES}

    def P(k, sx=1.0):
        p = pos[k].copy() if isinstance(k, str) else Vector(k)
        p.x *= sx
        return m @ p

    h, v, e, c, cr = P("hanche"), P("ventre"), P("epaules"), P("cou"), P("crane")
    hv, ve, n2 = h.lerp(v, 0.5), v.lerp(e, 0.5), c.lerp(cr, 0.6)
    specs = [
        ("Root", Vector((0, 0, 0)), Vector((0, 0, 0.6)), None, False, False),
        ("Hips", h, hv, "Root", False, True),
        ("Spine1", hv, v, "Hips", True, True),
        ("Spine2", v, ve, "Spine1", True, True),
        ("Spine3", ve, e, "Spine2", True, True),
        ("Neck1", e, c, "Spine3", True, True),
        ("Neck2", c, n2, "Neck1", True, True),
        ("Head", n2, P("museau"), "Neck2", True, True),
        ("Jaw", P((0, -1.15, 2.88)), P((0, -2.55, 2.72)), "Head", False, True),
    ]
    # Queue : têtes d'os sur les boucles queue1..queue5, le dernier os finit dans la pointe (queue6)
    tail = [h.lerp(P("queue1"), 0.5)] + [P("queue%d" % i) for i in range(1, 7)]
    for i in range(6):
        specs.append(("Tail%d" % (i + 1), tail[i], tail[i + 1], "Hips" if i == 0 else "Tail%d" % i, i > 0, True))
    for side, sx in SIDES:
        legs = [P(k, sx) for k in ("cuisse", "genou", "cheville", "pied", "orteils")]
        for i, name in enumerate(LEG_BONES):
            specs.append(("%s.%s" % (name, side), legs[i], legs[i + 1],
                          "Hips" if i == 0 else "%s.%s" % (LEG_BONES[i - 1], side), i > 0, True))
        sh, el, ha = P("epaule", sx), P("coude", sx), P("main", sx)
        wr = el.lerp(ha, 0.6)  # poignet avancé : la main (petite) reste dans le mesh
        specs += [
            ("UpperArm." + side, sh, el, "Spine3", False, True),
            ("LowerArm." + side, el, wr, "UpperArm." + side, True, True),
            ("Hand." + side, wr, ha + (ha - el) * 0.3, "LowerArm." + side, True, True),
        ]
    return specs


def build_armature(col, mesh_ob):
    old = bpy.data.armatures.get(ARM_NAME + "_Data")
    if old is not None and old.users == 0:
        bpy.data.armatures.remove(old)
    data = bpy.data.armatures.new(ARM_NAME + "_Data")
    arm = bpy.data.objects.new(ARM_NAME, data)
    col.objects.link(arm)
    arm.show_in_front = True
    data.display_type = "STICK"

    vl = bpy.context.view_layer
    for o in vl.objects:
        o.select_set(False)
    vl.objects.active = arm
    arm.select_set(True)
    bpy.ops.object.mode_set(mode="EDIT")
    ebs = {}
    for name, head, tail, parent, connect, deform in bone_specs(skel_matrix(mesh_ob)):
        eb = data.edit_bones.new(name)
        eb.head, eb.tail, eb.roll = head, tail, 0.0
        eb.use_deform = deform
        if parent:
            eb.parent = ebs[parent]
            eb.use_connect = connect
        ebs[name] = eb
    bpy.ops.object.mode_set(mode="OBJECT")
    for pb in arm.pose.bones:
        pb.rotation_mode = "QUATERNION"
    return arm


# ------------------------------------------------------------------ poids

def islands(me):
    parent = list(range(len(me.vertices)))

    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    for e in me.edges:
        a, b = find(e.vertices[0]), find(e.vertices[1])
        if a != b:
            parent[a] = b
    groups = {}
    for i in range(len(me.vertices)):
        groups.setdefault(find(i), []).append(i)
    return list(groups.values())


def vertex_colors(me):
    attr = me.color_attributes[dd.COLOR_ATTR]
    col = [None] * len(me.vertices)
    for loop in me.loops:
        if col[loop.vertex_index] is None:
            col[loop.vertex_index] = tuple(round(c, 2) for c in attr.data[loop.index].color_srgb[:3])
    return col


class HeatFailed(RuntimeError):
    pass


ARM_BONES = ("UpperArm", "LowerArm", "Hand")


def auto_weights(mesh_ob, arm, with_arms, keep):
    """Automatic Weights (Bone Heat) sur une copie temporaire ne gardant que les sommets `keep` (une pièce
    fermée). Sans les bras pour le tronc : sinon les os de bras, plantés dans la poitrine, la « volent »."""
    for b in arm.data.bones:
        if b.name.split(".")[0] in ARM_BONES:
            b.use_deform = with_arms
    me = mesh_ob.data.copy()
    tmp = bpy.data.objects.new("_dd_heat_tmp", me)
    mesh_ob.users_collection[0].objects.link(tmp)
    orig = me.attributes.new("_dd_orig", "INT", "POINT")
    orig.data.foreach_set("value", list(range(len(me.vertices))))
    keep = set(keep)
    bm = bmesh.new()
    bm.from_mesh(me)
    bmesh.ops.delete(bm, geom=[v for v in bm.verts if v.index not in keep], context="VERTS")
    bm.to_mesh(me)
    bm.free()
    vl = bpy.context.view_layer
    for o in vl.objects:
        o.select_set(False)
    tmp.select_set(True)
    arm.select_set(True)
    vl.objects.active = arm
    bpy.ops.object.parent_set(type="ARMATURE_AUTO")
    names = [vg.name for vg in tmp.vertex_groups]
    W = [{} for _ in mesh_ob.data.vertices]
    oi = me.attributes["_dd_orig"].data
    for v in me.vertices:
        W[oi[v.index].value] = {names[g.group]: g.weight for g in v.groups if g.weight > 1e-4}
    bpy.data.objects.remove(tmp, do_unlink=True)
    bpy.data.meshes.remove(me)
    if sum(1 for i in keep if W[i]) < len(keep) // 2:
        raise HeatFailed("Automatic Weights (Bone Heat) : échec de la résolution")
    return W


def skin_weights(mesh_ob, arm):
    vl = bpy.context.view_layer
    me = mesh_ob.data
    # Peau (corps + bras) vs accessoires (yeux, narines, griffes) reconnus à leur couleur
    skin_cols = {tuple(round(c, 2) for c in bt.C_BODY[:3]), tuple(round(c, 2) for c in bt.C_BELLY[:3])}
    vc = vertex_colors(me)
    isl = islands(me)
    skin = [i for g in isl if vc[g[0]] in skin_cols for i in g]
    acc = [g for g in isl if vc[g[0]] not in skin_cols]

    # La peau est faite de plusieurs pièces fermées qui se traversent (Skin : tronc+queue, bassin+jambes,
    # cou+tête, 2 bras). Le Bone Heat échoue sur des pièces qui se traversent : une passe PAR pièce.
    # Les bras (pièces dont le centre est le plus proche d'un nœud de bras) ne prennent que les os de bras ;
    # les autres pièces, jamais.
    minv = skel_matrix(mesh_ob).inverted()
    nodes = bt.NODES
    W = [{} for _ in me.vertices]
    W_arms = W
    arm_isl = []
    for g in (g for g in isl if vc[g[0]] in skin_cols):
        ctr = minv @ (sum((me.vertices[i].co for i in g), Vector()) / len(g))
        ctr.x = abs(ctr.x)
        is_arm = min(nodes, key=lambda n: (Vector(n[1]) - ctr).length / n[2])[0] in ("epaule", "coude", "main")
        Wp = auto_weights(mesh_ob, arm, with_arms=is_arm, keep=g)
        for i in g:
            W[i] = Wp[i]
        if is_arm:
            arm_isl.append(g)
    for b in arm.data.bones:
        b.use_deform = b.name != "Root"
    # Mesh enfant de l'armature + modificateur Armature (ce que fait « Parent > With Automatic Weights »)
    mesh_ob.parent = arm
    mesh_ob.matrix_parent_inverse.identity()
    mesh_ob.modifiers.clear()
    mesh_ob.vertex_groups.clear()
    mod = mesh_ob.modifiers.new("Armature", "ARMATURE")
    mod.object = arm
    minv = skel_matrix(mesh_ob).inverted()
    S = [minv @ v.co for v in me.vertices]  # coordonnées « squelette » (celles de NODES)

    # 1) bras = îlots séparés : poids de la passe « avec bras », limités aux os du bras + Spine3
    for g in arm_isl:
        for i in g:
            W[i] = {k: w for k, w in W_arms[i].items() if k.split(".")[0] in ARM_BONES or k == "Spine3"}

    # 1a) os oubliés par le Bone Heat (os à cheval sur deux pièces, ex. Spine2, Hand) : les sommets dont
    #     cet os est le plus proche reçoivent 50 % sur lui (le reste est renormalisé plus bas)
    def seg_dist(p, b):
        a, c = b.head_local, b.tail_local
        ac = c - a
        t = max(0.0, min(1.0, (p - a).dot(ac) / ac.length_squared))
        return (p - (a + ac * t)).length

    got = {k for wd in W for k in wd}
    arm_set = {i for g in arm_isl for i in g}
    for b in arm.data.bones:
        if not b.use_deform or b.name in got:
            continue
        b_is_arm = b.name.split(".")[0] in ARM_BONES
        cands = [o for o in arm.data.bones if o.use_deform and (o.name.split(".")[0] in ARM_BONES) == b_is_arm]
        for i in skin:
            if (i in arm_set) != b_is_arm:
                continue
            co = me.vertices[i].co
            if min(cands, key=lambda o: seg_dist(co, o)) == b:
                W[i] = {k: w * 0.5 for k, w in W[i].items()}
                W[i][b.name] = 0.5

    # 1b) sommets de peau sans poids (échec possible du Bone Heat) : poids du voisin pesé le plus proche
    weighted = [i for i in skin if W[i]]
    kd = KDTree(len(weighted))
    for n, i in enumerate(weighted):
        kd.insert(me.vertices[i].co, n)
    kd.balance()
    unweighted_fixed = 0
    for i in skin:
        if not W[i]:
            _co, n, _d = kd.find(me.vertices[i].co)
            W[i] = dict(W[weighted[n]])
            unweighted_fixed += 1

    # 2) mâchoire nette : devant la charnière, sous la ligne de la bouche = Jaw, au-dessus = Head
    for i in skin:
        s = S[i]
        if s.y < -1.25 and s.z > 2.35:
            mouth = 3.02 + (s.y + 1.25) * 0.06
            w = min(1.0, max(0.0, (mouth + 0.06 - s.z) / 0.12))
            W[i] = {"Head": 1.0 - w, "Jaw": w}
        else:
            W[i].pop("Jaw", None)
        # 3) queue nette : derrière le bassin, aucune influence des jambes
        if s.y > 0.7 and abs(s.x) < 0.55 and s.z > 0.95:
            for k in list(W[i]):
                if k.split(".")[0] in LEG_BONES:
                    del W[i][k]

    # 4) accessoires rigides : chaque îlot copie les poids du point de peau le plus proche de son centre
    kd2 = KDTree(len(skin))
    for n, i in enumerate(skin):
        kd2.insert(me.vertices[i].co, n)
    kd2.balance()
    for g in acc:
        center = sum((me.vertices[i].co for i in g), Vector()) / len(g)
        _co, n, _d = kd2.find(center)
        for i in g:
            W[i] = dict(W[skin[n]])

    # Réécriture des groupes
    for vg in mesh_ob.vertex_groups:
        vg.remove(list(range(len(me.vertices))))
    for i, wd in enumerate(W):
        for k, w in wd.items():
            if w > 1e-4:
                vg = mesh_ob.vertex_groups.get(k) or mesh_ob.vertex_groups.new(name=k)
                vg.add([i], w, "REPLACE")
    used = {k for wd in W for k, w in wd.items() if w > 1e-4}
    empty = [b.name for b in arm.data.bones if b.use_deform and b.name not in used]
    if empty:
        raise HeatFailed("Os de déformation sans aucun poids : %s" % empty)

    # Limit Total 4 + Normalize All (opérateurs Blender, comme à la main)
    vl.objects.active = mesh_ob
    for o in vl.objects:
        o.select_set(o == mesh_ob)
    bpy.ops.object.vertex_group_limit_total(group_select_mode="ALL", limit=4)
    bpy.ops.object.vertex_group_normalize_all(group_select_mode="ALL", lock_active=False)
    bpy.ops.object.vertex_group_clean(group_select_mode="ALL", limit=0.0001)

    infl = [sum(1 for g in v.groups if g.weight > 0) for v in me.vertices]
    return {"max_influences": max(infl), "sans_poids": sum(1 for n in infl if n == 0),
            "bone_heat_repares": unweighted_fixed, "groupes": len(mesh_ob.vertex_groups)}


# ------------------------------------------------------------------ pose / animation

def rest3inv(pb):
    return pb.bone.matrix_local.to_3x3().inverted()


def rot(pb, *axis_deg):
    """Rotation(s) autour d'axes MONDE (exprimés dans le repère de repos de l'os)."""
    q = Quaternion()
    inv = rest3inv(pb)
    for axis, deg in axis_deg:
        q = q @ Quaternion((inv @ Vector(axis)).normalized(), math.radians(deg))
    pb.rotation_quaternion = q


def loc(pb, world_vec):
    pb.location = rest3inv(pb) @ Vector(world_vec)


def reset_pose(arm):
    for pb in arm.pose.bones:
        pb.location = (0, 0, 0)
        pb.rotation_quaternion = (1, 0, 0, 0)
        pb.scale = (1, 1, 1)


def key_all(arm, f):
    for pb in arm.pose.bones:
        pb.keyframe_insert("rotation_quaternion", frame=f, group=pb.name)
        if pb.name == "Hips":
            pb.keyframe_insert("location", frame=f, group=pb.name)


X, Y, Z = (1, 0, 0), (0, 1, 0), (0, 0, 1)
S2 = lambda t, k=1.0, ph=0.0: math.sin(2 * math.pi * (k * t + ph))  # noqa: E731


def leg_rest(arm, side):
    b = arm.data.bones
    return b["Foot." + side].head_local.copy(), b["Foot." + side].tail_local.copy()


def setup_ik(arm, col):
    """Cibles IK temporaires (empties) : cheville (IK sur LowerLeg, chaîne 2) + pointe du pied (Damped Track)."""
    empties = {}
    for side, _sx in SIDES:
        ank, toe = leg_rest(arm, side)
        e1 = bpy.data.objects.new("DD_IK_Cheville." + side, None)
        e2 = bpy.data.objects.new("DD_IK_Pied." + side, None)
        for e, p in ((e1, ank), (e2, toe)):
            col.objects.link(e)
            e.location = p
        ik = arm.pose.bones["LowerLeg." + side].constraints.new("IK")
        ik.target, ik.chain_count, ik.use_tail = e1, 2, True
        dt = arm.pose.bones["Foot." + side].constraints.new("DAMPED_TRACK")
        dt.target, dt.track_axis = e2, "TRACK_Y"
        empties[side] = (e1, e2, ank, toe)
    return empties


def teardown_ik(empties):
    for e1, e2, _a, _t in empties.values():
        for e in (e1, e2):
            if e.animation_data and e.animation_data.action:
                bpy.data.actions.remove(e.animation_data.action)
            bpy.data.objects.remove(e, do_unlink=True)


def new_action(arm, name, length):
    old = bpy.data.actions.get(name)
    if old is not None and old.get("dd_rig") == ARM_NAME:
        bpy.data.actions.remove(old)
    act = bpy.data.actions.new(name)
    act["dd_rig"] = ARM_NAME
    act.use_fake_user = True
    act.use_frame_range = True
    act.frame_start, act.frame_end = 0, length
    act.use_cyclic = True
    arm.animation_data_create()
    arm.animation_data.action = act
    return act


def bake(arm, length):
    vl = bpy.context.view_layer
    for o in vl.objects:
        o.select_set(o == arm)
    vl.objects.active = arm
    bpy.ops.nla.bake(frame_start=0, frame_end=length, step=1, only_selected=False, visual_keying=True,
                     clear_constraints=True, use_current_action=True, bake_types={"POSE"},
                     channel_types={"LOCATION", "ROTATION", "SCALE"})


def pose_idle(arm, t):
    """t dans [0, 1[ : respiration (2 cycles), tête qui regarde autour, queue qui ondule (1 cycle)."""
    P = arm.pose.bones
    reset_pose(arm)
    br = S2(t, 2)
    loc(P["Hips"], (0, 0, -0.03 + 0.03 * br))
    rot(P["Hips"], (Z, 3 * S2(t, 1)))
    for i, n in enumerate(("Spine1", "Spine2", "Spine3")):
        rot(P[n], (X, -2.5 * br), (Z, 1.5 * S2(t, 1, 0.1 * i)))
    rot(P["Neck1"], (X, 3 * br))
    rot(P["Neck2"], (X, 2 * S2(t, 2, 0.15)), (Z, 6 * S2(t, 1, 0.25)))
    rot(P["Head"], (X, 4 * S2(t, 2, 0.3)), (Z, 10 * S2(t, 1, 0.2)), (Y, 7 * S2(t, 1, 0.35)))
    rot(P["Jaw"], (X, -6 * max(0.0, br)))  # petite bouche qui s'entrouvre à l'inspiration
    for i in range(6):
        rot(P["Tail%d" % (i + 1)], (Z, 7 * S2(t, 1, -0.08 * i)), (X, 2.5 * S2(t, 2, -0.1 * i)))
    for side, sx in SIDES:
        rot(P["UpperArm." + side], (X, -10 * S2(t, 2, 0.1)), (Y, sx * 6 * br))
        rot(P["LowerArm." + side], (X, -12 * S2(t, 2, 0.2)))
        rot(P["Hand." + side], (X, 10 * S2(t, 2, 0.3)))


def pose_walk(arm, t):
    """t dans [0, 1[ : pas droit au contact à t=0, pas gauche à t=0,5. Style cartoon exagéré."""
    P = arm.pose.bones
    reset_pose(arm)
    bob = math.cos(2 * math.pi * 2 * t)  # 1 aux contacts (t = 0 ; 0,5)
    loc(P["Hips"], (0, 0, -0.08 - 0.08 * bob))
    # +X = penché vers l'avant (museau en bas, queue en haut)
    rot(P["Hips"], (Z, 9 * S2(t, 1)), (Y, 5 * S2(t, 1, 0.25)), (X, 8))
    for n in ("Spine1", "Spine2", "Spine3"):
        rot(P[n], (Z, -4 * S2(t, 1)), (X, 2 * bob))
    rot(P["Neck1"], (X, -6 - 3 * bob))  # compense la penche : la tête reste à l'horizontale
    rot(P["Head"], (X, 6 * bob), (Z, -5 * S2(t, 1)))
    rot(P["Jaw"], (X, -4 - 4 * max(0.0, -bob)))
    for i in range(6):
        rot(P["Tail%d" % (i + 1)], (Z, -10 * S2(t, 1, -0.07 * (i + 1))), (X, 3 + 3 * S2(t, 2, -0.08 * i)))
    for side, sx in SIDES:
        sw = S2(t, 1, 0.25) * (1 if side == "L" else -1)  # bras opposé à la jambe
        rot(P["UpperArm." + side], (X, 28 * sw))
        rot(P["LowerArm." + side], (X, 18 * S2(t, 1, 0.35) * (1 if side == "L" else -1) - 10))
        rot(P["Hand." + side], (X, 10 * sw))


def foot_target(ank, toe, phase):
    """phase dans [0, 1[ : 0 -> 0,5 appui (le pied recule à vitesse constante), 0,5 -> 1 vol (lève et avance)."""
    if phase < 0.5:
        u = phase / 0.5
        dy, dz = -STEP / 2 + STEP * u, 0.0
    else:
        u = (phase - 0.5) / 0.5
        s = 0.5 - 0.5 * math.cos(math.pi * u)  # avance en douceur
        dy, dz = STEP / 2 - STEP * s, LIFT * math.sin(math.pi * u)
    off = Vector((0, dy, dz))
    tip = toe + off
    if phase >= 0.5:  # pointe un peu tombante pendant le vol
        tip.z -= 0.12 * math.sin(math.pi * u)
    return ank + off, tip


def make_action(arm, col, name, length, pose_fn, walk):
    act = new_action(arm, name, length)
    sc = bpy.context.scene
    sc.render.fps = FPS
    sc.frame_start, sc.frame_end = 0, length
    empties = setup_ik(arm, col)
    for f in range(length + 1):
        t = (f % length) / length  # f = length rejoue exactement f = 0 : boucle parfaite
        pose_fn(arm, t)
        key_all(arm, f)
        for side, (e1, e2, ank, toe) in empties.items():
            if walk:
                ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
                a, b = foot_target(ank, toe, ph)
            else:
                a, b = ank, toe
            e1.location, e2.location = a, b
            e1.keyframe_insert("location", frame=f)
            e2.keyframe_insert("location", frame=f)
    bake(arm, length)
    teardown_ik(empties)
    arm.animation_data.action = act  # le bake garde l'action courante
    if walk:
        for f in (0, length // 2):
            mk = act.pose_markers.new("Footstep")
            mk.frame = f
    return act


def loop_error(arm, act, length):
    arm.animation_data.action = act
    sc = bpy.context.scene
    sc.frame_set(0)
    a = [pb.matrix.copy() for pb in arm.pose.bones]
    sc.frame_set(length)
    b = [pb.matrix.copy() for pb in arm.pose.bones]
    return max(max(abs(x - y) for ra, rb in zip(m1, m2) for x, y in zip(ra, rb)) for m1, m2 in zip(a, b))


def foot_slide(arm, act):
    """Glissement : pendant l'appui, la cheville doit reculer de STEP/15 par image, au sol."""
    arm.animation_data.action = act
    sc = bpy.context.scene
    worst = 0.0
    for side, off in (("R", 0), ("L", WALK_LEN // 2)):
        pts = []
        for f in range(off, off + WALK_LEN // 2 + 1):
            sc.frame_set(f % WALK_LEN if f > WALK_LEN else f)
            pts.append((arm.matrix_world @ arm.pose.bones["Foot." + side].head).copy())
        for i in range(1, len(pts)):
            d = pts[i] - pts[i - 1]
            worst = max(worst, abs(d.y - STEP / (WALK_LEN / 2)), abs(d.x), abs(d.z))
    return worst


# ------------------------------------------------------------------ rendus de contrôle

def place_cam(sc, target, azimuth, dist, h):
    a = math.radians(azimuth)
    t = Vector(target)
    cam = sc.camera
    cam.location = t + Vector((math.sin(a), -math.cos(a), h)).normalized() * dist
    cam.rotation_euler = (t - cam.location).to_track_quat("-Z", "Y").to_euler()


def contact_sheet(paths, out, cols):
    imgs = [bpy.data.images.load(p, check_existing=False) for p in paths]
    w, h = imgs[0].size
    rows = (len(imgs) + cols - 1) // cols
    sheet = np.ones((rows * h, cols * w, 4), dtype=np.float32)
    for i, im in enumerate(imgs):
        px = np.array(im.pixels[:], dtype=np.float32).reshape(h, w, 4)
        r, c = divmod(i, cols)
        y0 = (rows - 1 - r) * h  # les pixels Blender partent du bas
        sheet[y0:y0 + h, c * w:(c + 1) * w] = px
        bpy.data.images.remove(im)
    res = bpy.data.images.new("_dd_sheet", cols * w, rows * h, alpha=True)
    res.pixels.foreach_set(sheet.ravel())
    res.filepath_raw = out
    res.file_format = "PNG"
    res.save()
    bpy.data.images.remove(res)
    return out


def render_frames(sc, name, frames, size=420, cols=4):
    os.makedirs(TMP, exist_ok=True)
    rx, ry = sc.render.resolution_x, sc.render.resolution_y
    sc.render.resolution_x = sc.render.resolution_y = size
    paths = []
    for i, f in enumerate(frames):
        if callable(f):
            f()
        else:
            sc.frame_set(f)
        p = os.path.join(TMP, "%s_%02d.png" % (name, i))
        dd.render_to(sc, p)
        paths.append(p)
    sc.render.resolution_x, sc.render.resolution_y = rx, ry
    return contact_sheet(paths, os.path.join(RENDERS, "theropod_%s.png" % name), cols)


def extreme_poses(arm):
    P = arm.pose.bones

    def pose_a():
        reset_pose(arm)
        rot(P["Neck1"], (Z, 25))
        rot(P["Neck2"], (X, -25))
        rot(P["Head"], (Z, 35), (X, -15))
        rot(P["Jaw"], (X, -35))
        for i in range(6):
            rot(P["Tail%d" % (i + 1)], (Z, 22))
        rot(P["UpperLeg.L"], (X, 70))
        rot(P["LowerLeg.L"], (X, -80))
        rot(P["Foot.L"], (X, 30))
        rot(P["UpperArm.L"], (X, -80))
        rot(P["UpperArm.R"], (X, 60), (Y, -40))
        rot(P["LowerArm.R"], (X, -70))

    def pose_b():
        reset_pose(arm)
        loc(P["Hips"], (0, 0, -0.45))
        rot(P["Hips"], (X, 20))
        rot(P["Spine2"], (X, -25))
        rot(P["Neck1"], (X, 30))
        rot(P["Head"], (X, 30), (Y, -25))
        for i in range(6):
            rot(P["Tail%d" % (i + 1)], (X, 15), (Z, -10))
        for s in ("L", "R"):
            rot(P["UpperLeg." + s], (X, 55))
            rot(P["LowerLeg." + s], (X, -85))
            rot(P["Foot." + s], (X, 35))
            rot(P["UpperArm." + s], (X, -50))

    return [pose_a, pose_b]


# ------------------------------------------------------------------ main

def build(save=True, renders=True):
    # shortcut: le Bone Heat de Blender échoue parfois au hasard (0 sommet pesé) ; reconstruire mesh +
    # armature et réessayer suffit en pratique. Si ça persiste : passer à des poids calculés par distance.
    for attempt in range(3):
        stats = bt.build()  # reconstruit le mesh (scène DD_Theropode, collection Theropode)
        sc = bpy.context.scene
        col = bpy.data.collections[bt.NAME]
        mesh_ob = bpy.data.objects[stats["objet"]]
        arm = build_armature(col, mesh_ob)
        try:
            w = skin_weights(mesh_ob, arm)
            break
        except HeatFailed:
            if attempt == 2:
                raise
    out = {"triangles": stats["triangles"], "os": len(arm.data.bones), **w}

    if renders:
        sc.frame_set(0)
        poses = extreme_poses(arm)
        # 2 poses extrêmes x 2 angles de vue
        out["rendu_poses"] = render_frames(sc, "poses", [
            lambda: (place_cam(sc, (0, -0.4, 1.7), -40, 10.5, 0.3), poses[0]()),
            lambda: (place_cam(sc, (0, -0.4, 1.7), 50, 10.5, 0.3), poses[0]()),
            lambda: (place_cam(sc, (0, -0.4, 1.7), -40, 10.5, 0.3), poses[1]()),
            lambda: (place_cam(sc, (0, -0.4, 1.7), -90, 10.5, 0.15), poses[1]()),
        ], cols=4)
        reset_pose(arm)

    idle = make_action(arm, col, "Idle", IDLE_LEN, pose_idle, walk=False)
    walk = make_action(arm, col, "Walk", WALK_LEN, pose_walk, walk=True)
    out["boucle_idle"] = round(loop_error(arm, idle, IDLE_LEN), 6)
    out["boucle_walk"] = round(loop_error(arm, walk, WALK_LEN), 6)
    out["glissement_pied_max"] = round(foot_slide(arm, walk), 4)
    out["footsteps"] = [m.frame for m in walk.pose_markers]

    if renders:
        arm.animation_data.action = walk
        place_cam(sc, (0, -0.2, 1.7), -90, 11.0, 0.12)
        out["rendu_walk"] = render_frames(sc, "walk", list(range(0, WALK_LEN, 4)), cols=4)
        arm.animation_data.action = idle
        place_cam(sc, (0, -0.4, 1.9), -40, 10.5, 0.3)
        out["rendu_idle"] = render_frames(sc, "idle", list(range(0, IDLE_LEN, 15)), cols=4)
    arm.animation_data.action = idle
    sc.frame_set(0)

    if save:
        path = os.path.join(PROJECT_DIR, "blender", "rigs", "theropod.blend")
        os.makedirs(os.path.dirname(path), exist_ok=True)
        bpy.data.libraries.write(path, {sc, idle, walk}, path_remap="RELATIVE_ALL", fake_user=True)
        out["fichier"] = path
    return out


if __name__ == "__main__":
    print(build())
