# DINO DICE — outils génériques de rig / poids / actions / rendus pour les modèles UNIQUES (blender/scripts/dinos/).
# Version : 1
# Utilisé par build_<dino>.py. Les poses de chaque dino restent dans son propre script.
#
# Règles appliquées : os « Root » à (0, 0, 0) sans poids ; armature et mesh à transform identité ;
# 4 influences max par sommet, poids normalisés ; actions à 30 i/s nommées « <id>_<Clip> ».

import math
import os

import bpy
import numpy as np
from mathutils import Matrix, Vector

import build_theropod_rig as rig  # rot, loc, reset_pose, key_all, bake, setup_ik, teardown_ik, place_cam

X, Y, Z = (1, 0, 0), (0, 1, 0), (0, 0, 1)


def S2(t, k=1.0, ph=0.0):
    return math.sin(2 * math.pi * (k * t + ph))


def keys(t, pts):
    """Interpolation douce (cosinus) entre points (temps, valeur) triés ; constante hors bornes."""
    if t <= pts[0][0]:
        return pts[0][1]
    for (t0, v0), (t1, v1) in zip(pts, pts[1:]):
        if t <= t1:
            u = (t - t0) / (t1 - t0) if t1 > t0 else 1.0
            return v0 + (v1 - v0) * (0.5 - 0.5 * math.cos(math.pi * u))
    return pts[-1][1]


# ------------------------------------------------------------------ armature

def build_armature(col, name, specs):
    """specs : (nom, tête, queue, parent, connecté, déforme) en coordonnées finales (studs)."""
    old = bpy.data.armatures.get(name + "_Data")
    if old is not None and old.users == 0:
        bpy.data.armatures.remove(old)
    data = bpy.data.armatures.new(name + "_Data")
    arm = bpy.data.objects.new(name, data)
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
    for bname, head, tail, parent, connect, deform in specs:
        eb = data.edit_bones.new(bname)
        eb.head, eb.tail, eb.roll = head, tail, 0.0
        eb.use_deform = deform
        if parent:
            eb.parent = ebs[parent]
            eb.use_connect = connect
        ebs[bname] = eb
    bpy.ops.object.mode_set(mode="OBJECT")
    for pb in arm.pose.bones:
        pb.rotation_mode = "QUATERNION"
    return arm


def seg_dist(p, a, b):
    ab = b - a
    t = max(0.0, min(1.0, (p - a).dot(ab) / ab.length_squared))
    return (p - (a + ab * t)).length


def dist_weights(p, bones, segs, sigma):
    """Poids par distance aux segments d'os : exp(-(d - dmin) / sigma), 4 meilleurs, normalisés."""
    ds = [(seg_dist(p, *segs[b]), b) for b in bones]
    dmin = min(d for d, _ in ds)
    w = sorted(((math.exp(-(d - dmin) / sigma), b) for d, b in ds), reverse=True)[:4]
    w = [(x, b) for x, b in w if x > 0.03]
    s = sum(x for x, _ in w)
    return {b: x / s for x, b in w}


def limit_normalize(wd, n=4):
    top = sorted(wd.items(), key=lambda kv: -kv[1])[:n]
    top = [(k, v) for k, v in top if v > 1e-3]
    s = sum(v for _, v in top)
    return {k: v / s for k, v in top}


def apply_weights(mesh_ob, arm, W):
    mesh_ob.parent = arm
    mesh_ob.matrix_parent_inverse.identity()
    mesh_ob.modifiers.clear()
    mesh_ob.vertex_groups.clear()
    mod = mesh_ob.modifiers.new("Armature", "ARMATURE")
    mod.object = arm
    groups = {}
    for i, wd in enumerate(W):
        for k, w in limit_normalize(wd).items():
            vg = groups.get(k) or groups.setdefault(k, mesh_ob.vertex_groups.new(name=k))
            vg.add([i], w, "REPLACE")
    me = mesh_ob.data
    infl = [len(v.groups) for v in me.vertices]
    deform = [b.name for b in arm.data.bones if b.use_deform]
    return {"max_influences": max(infl), "sans_poids": sum(1 for n in infl if n == 0),
            "os_deformants_sans_poids": [b for b in deform if b not in groups]}


# ------------------------------------------------------------------ actions

def new_action(arm, dino_id, clip, length, loop):
    name = "%s_%s" % (dino_id, clip)
    old = bpy.data.actions.get(name)
    if old is not None:
        bpy.data.actions.remove(old)
    act = bpy.data.actions.new(name)
    act["dd_clip"], act["dd_loop"], act["dd_len"] = clip, bool(loop), int(length)
    act.use_fake_user = True
    act.use_frame_range = True
    act.frame_start, act.frame_end = 0, length
    act.use_cyclic = bool(loop)
    arm.animation_data_create()
    arm.animation_data.action = act
    return act


def make_action(arm, col, dino_id, clip, length, loop, pose_fn, feet_fn=None):
    """pose_fn(t) pose l'armature (t = f/length) ; feet_fn(side, t, ank, toe) -> (cheville, pointe) en IK,
    ou None = pas d'IK (FK pur). Tout est « baké » en FK (contraintes et cibles supprimées)."""
    act = new_action(arm, dino_id, clip, length, loop)
    sc = bpy.context.scene
    sc.render.fps = 30
    sc.frame_start, sc.frame_end = 0, length
    empties = rig.setup_ik(arm, col) if feet_fn else {}
    for f in range(length + 1):
        t = ((f % length) / length) if loop else f / length  # boucle : f = length rejoue f = 0
        pose_fn(t)
        rig.key_all(arm, f)
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


def loop_error(arm, act):
    arm.animation_data.action = act
    sc = bpy.context.scene
    sc.frame_set(0)
    a = [pb.matrix.copy() for pb in arm.pose.bones]
    sc.frame_set(int(act["dd_len"]))
    b = [pb.matrix.copy() for pb in arm.pose.bones]
    return max(max(abs(x - y) for ra, rb in zip(m1, m2) for x, y in zip(ra, rb)) for m1, m2 in zip(a, b))


def min_z(mesh_ob, arm, act, step=3):
    """Point le plus bas du mesh déformé sur toute l'action (contrôle : rien sous le sol)."""
    arm.animation_data.action = act
    sc = bpy.context.scene
    lo = 1e9
    for f in range(0, int(act["dd_len"]) + 1, step):
        sc.frame_set(f)
        dg = bpy.context.evaluated_depsgraph_get()
        me = mesh_ob.evaluated_get(dg).to_mesh()
        co = np.empty(len(me.vertices) * 3, dtype=np.float32)
        me.vertices.foreach_get("co", co)
        lo = min(lo, float(co[2::3].min()))
        mesh_ob.evaluated_get(dg).to_mesh_clear()
    return lo


# ------------------------------------------------------------------ rendus

def render_sheet(sc, frames, out, tmpdir, size=400, cols=4, cam=None):
    os.makedirs(tmpdir, exist_ok=True)
    rx, ry = sc.render.resolution_x, sc.render.resolution_y
    sc.render.resolution_x = sc.render.resolution_y = size
    paths = []
    for i, f in enumerate(frames):
        sc.frame_set(f)
        p = os.path.join(tmpdir, "f_%02d.png" % i)
        sc.render.filepath = p
        bpy.ops.render.render(write_still=True, scene=sc.name)
        paths.append(p)
    sc.render.resolution_x, sc.render.resolution_y = rx, ry
    os.makedirs(os.path.dirname(out), exist_ok=True)
    return rig.contact_sheet(paths, out, cols)
