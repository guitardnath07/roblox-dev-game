# DINO DICE — Export FBX vers Roblox (modèle + une FBX par action), avec vérifications bloquantes.
# Version : 1
#
# Sans interface (--python-exit-code AVANT -P : Blender lit ses arguments dans l'ordre, placé après il est
# ignoré et une erreur sort quand même avec le code 0) :
#   blender -b blender/rigs/theropod.blend --python-exit-code 1 -P blender/scripts/export_roblox.py -- theropod
# Depuis une session Blender (MCP) : exec du fichier puis export_dino("theropod").
#
# Options FBX tirées de la doc Roblox (consultée le 2026-10-18) :
#   https://create.roblox.com/docs/art/blender                    -> Apply Scalings = FBX Unit Scale,
#                                                                    Forward = Z Forward, Up = Y Up,
#                                                                    Limit to Selected Objects
#   https://create.roblox.com/docs/art/modeling/export-requirements -> Path Mode = Copy, Embed Textures,
#                                                                    Add Leaf Bones = off,
#                                                                    Bake Animation = off (sauf animation)
# Choix maison (non imposés par la doc) : Simplify = 0 et clés début/fin forcées (boucles exactes),
# NLA Strips / All Actions = off (une action par fichier), « Only Deform Bones » = off (garder Root).

import os
import sys

import bpy
from mathutils import Matrix

PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
EXPORT_DIR = os.path.join(PROJECT_DIR, "blender", "exports")

# id -> (mesh, armature, budget triangles, actions)
DINOS = {
    "theropod": ("Theropode_Base", "Theropode_Armature", 5000, ("Idle", "Walk")),
}

FBX_COMMON = dict(
    use_selection=True,
    object_types={"ARMATURE", "MESH"},
    apply_scale_options="FBX_SCALE_UNITS",
    global_scale=1.0,
    apply_unit_scale=True,
    axis_forward="Z",
    axis_up="Y",
    use_mesh_modifiers=True,  # l'exporteur ignore le modificateur Armature, applique les autres
    mesh_smooth_type="FACE",
    add_leaf_bones=False,
    use_armature_deform_only=False,
    primary_bone_axis="Y",
    secondary_bone_axis="X",
    path_mode="COPY",
    embed_textures=True,
)


class ExportError(RuntimeError):
    pass


def check(mesh, arm, budget):
    """Vérifications bloquantes avant export (message clair sinon)."""
    errs = []
    me = mesh.data
    me.calc_loop_triangles()
    tris = len(me.loop_triangles)
    if tris > budget:
        errs.append("%d triangles > budget %d" % (tris, budget))
    if len(me.materials) != 1:
        errs.append("%d matériaux (1 attendu)" % len(me.materials))
    deform = {b.name for b in arm.data.bones if b.use_deform}
    names = [vg.name for vg in mesh.vertex_groups]
    infl = [sum(1 for g in v.groups if g.weight > 0 and names[g.group] in deform) for v in me.vertices]
    if max(infl) > 4:
        errs.append("%d sommets avec plus de 4 influences (max %d)" % (sum(n > 4 for n in infl), max(infl)))
    if min(infl) == 0:
        errs.append("%d sommets sans poids" % infl.count(0))
    roots = [b for b in arm.data.bones if b.parent is None]
    if [b.name for b in roots] != ["Root"]:
        errs.append("os racine attendu : un seul « Root » (trouvé %s)" % [b.name for b in roots])
    elif roots[0].head_local.length > 1e-4:
        errs.append("Root n'est pas à l'origine (%s)" % tuple(roots[0].head_local))
    bone_names = {b.name for b in arm.data.bones}
    clash = bone_names & {m.name for m in bpy.data.meshes} | bone_names & {o.name for o in bpy.data.objects}
    if clash:
        errs.append("os portant le nom d'un mesh/objet : %s" % sorted(clash))
    if mesh.parent != arm or not any(m.type == "ARMATURE" and m.object == arm for m in mesh.modifiers):
        errs.append("le mesh n'est pas skinné sur l'armature")
    if errs:
        raise ExportError("Export Roblox refusé :\n - " + "\n - ".join(errs))
    return {"triangles": tris, "max_influences": max(infl), "os": len(bone_names)}


def apply_transforms(objs):
    """Applique rotation/échelle/position si besoin (armature et mesh doivent être à l'identité)."""
    todo = [o for o in objs if o.matrix_world != Matrix.Identity(4)]
    if not todo:
        return []
    vl = bpy.context.view_layer
    for o in vl.objects:
        o.select_set(o in todo)
    vl.objects.active = todo[0]
    bpy.ops.object.transform_apply(location=True, rotation=True, scale=True)
    return [o.name for o in todo]


def select_only(objs):
    vl = bpy.context.view_layer
    for o in vl.objects:
        o.select_set(o in objs)
    vl.objects.active = objs[0]


def export_dino(dino_id):
    if dino_id not in DINOS:
        raise ExportError("id inconnu : %s (connus : %s)" % (dino_id, sorted(DINOS)))
    mesh_name, arm_name, budget, actions = DINOS[dino_id]
    mesh, arm = bpy.data.objects.get(mesh_name), bpy.data.objects.get(arm_name)
    if mesh is None or arm is None:
        raise ExportError("objets introuvables : %s / %s" % (mesh_name, arm_name))
    # La scène qui contient le rig doit être la scène courante (sélection = par view layer)
    sc = arm.users_scene[0]
    if bpy.context.window is not None:
        bpy.context.window.scene = sc
    if bpy.context.mode != "OBJECT":
        bpy.ops.object.mode_set(mode="OBJECT")

    report = {"transforms_appliques": apply_transforms([arm, mesh])}
    report.update(check(mesh, arm, budget))
    os.makedirs(EXPORT_DIR, exist_ok=True)
    select_only([arm, mesh])

    prev_action = arm.animation_data.action if arm.animation_data else None
    prev_range = (sc.frame_start, sc.frame_end)
    files = []
    try:
        # 1) Modèle : pose de repos, aucune animation
        if arm.animation_data:
            arm.animation_data.action = None
        for pb in arm.pose.bones:
            pb.matrix_basis = Matrix.Identity(4)
        path = os.path.join(EXPORT_DIR, "%s_model.fbx" % dino_id)
        bpy.ops.export_scene.fbx(filepath=path, bake_anim=False, **FBX_COMMON)
        files.append(path)

        # 2) Une FBX par action, bakée sur la plage exacte de l'action
        for name in actions:
            act = bpy.data.actions.get(name)
            if act is None:
                raise ExportError("action introuvable : %s" % name)
            arm.animation_data_create()
            arm.animation_data.action = act
            start, end = (int(round(f)) for f in act.frame_range)
            sc.frame_start, sc.frame_end = start, end
            path = os.path.join(EXPORT_DIR, "%s_%s.fbx" % (dino_id, name))
            bpy.ops.export_scene.fbx(
                filepath=path, bake_anim=True, bake_anim_use_all_bones=True,
                bake_anim_use_nla_strips=False, bake_anim_use_all_actions=False,
                bake_anim_force_startend_keying=True, bake_anim_step=1.0, bake_anim_simplify_factor=0.0,
                **FBX_COMMON)
            files.append(path)
    finally:
        sc.frame_start, sc.frame_end = prev_range
        if arm.animation_data:
            arm.animation_data.action = prev_action

    report["fichiers"] = {os.path.basename(f): os.path.getsize(f) for f in files}
    return report


if __name__ == "__main__":
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    if len(argv) != 1:
        raise SystemExit("usage : blender -b <fichier.blend> --python-exit-code 1 -P export_roblox.py -- <id>")
    print(export_dino(argv[0]))
