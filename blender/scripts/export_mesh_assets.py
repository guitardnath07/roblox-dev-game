# DINO DICE — Export FBX « mesh asset » (pose de repos, couleurs de sommets, une seule matière) pour l'import
# groupé dans Studio. Raison : le client Roblox ne garde que ~8 EditableMesh à la fois ; les dinos doivent donc
# être de vrais assets Mesh (voir src/shared/Config/DinoMeshIds.luau).
#   blender -b blender/dinos/<id>.blend --python-exit-code 1 -P blender/scripts/export_mesh_assets.py -- <dossier>
# Couleurs : même logique que meshFor() dans src/client/DinoModels.luau (slots 1-9, DinoLooks, glow éclairci).

import colorsys
import os
import re
import sys

import bpy

PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
LOOKS = os.path.join(PROJECT_DIR, "src", "shared", "Config", "DinoLooks.luau")


def hex_rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i:i + 2], 16) / 255 for i in (0, 2, 4))


def brighter(rgb):
    h, s, _ = colorsys.rgb_to_hsv(*rgb)
    return colorsys.hsv_to_rgb(h, s * 0.75, 1.0)


def looks(dino_id):
    src = open(LOOKS, encoding="utf-8").read()
    m = re.search(r"\b%s = \{ colors = \{([^}]*)\}" % re.escape(dino_id), src)
    assert m, "pas de couleurs pour %s dans DinoLooks" % dino_id
    return {k: hex_rgb(v) for k, v in re.findall(r'(\w+) = "(#[0-9A-Fa-f]{6})"', m.group(1))}


def main():
    out_dir = sys.argv[sys.argv.index("--") + 1]
    sc = next(s for s in bpy.data.scenes if s.get("dd_id"))
    bpy.context.window.scene = sc
    dino_id = sc["dd_id"]
    me_ob = bpy.data.objects[dino_id + "_Mesh"]
    arm = bpy.data.objects[dino_id + "_Armature"]
    c = looks(dino_id)
    slot_rgb = {
        1: c["main"], 2: c["belly"], 3: c["accent"], 4: (1, 1, 1), 5: hex_rgb("#1A1A1A"),
        6: brighter(c["glow"]), 7: c["back"], 8: hex_rgb("#9C2D4F"), 9: hex_rgb("#F06292"),
    }

    me = me_ob.data
    slot_attr = me.attributes["dd_slot"].data
    col = me.color_attributes.new("Col", "BYTE_COLOR", "CORNER")
    for poly in me.polygons:
        rgb = slot_rgb.get(slot_attr[poly.index].value, c["main"])
        for li in poly.loop_indices:
            col.data[li].color_srgb = (*rgb, 1.0)
        poly.use_smooth = False  # facettes « plaques »
    me.color_attributes.active_color = col
    me.materials.clear()
    mat = bpy.data.materials.new("Dino")
    me.materials.append(mat)
    for poly in me.polygons:
        poly.material_index = 0

    if arm.animation_data:
        arm.animation_data.action = None
    for pb in arm.pose.bones:
        pb.matrix_basis.identity()
    bpy.ops.object.select_all(action="DESELECT")
    for ob in (arm, me_ob):
        ob.hide_set(False)
        ob.select_set(True)
    bpy.context.view_layer.objects.active = arm
    os.makedirs(out_dir, exist_ok=True)
    path = os.path.join(out_dir, dino_id + ".fbx")
    bpy.ops.export_scene.fbx(
        filepath=path, use_selection=True, object_types={"ARMATURE", "MESH"},
        apply_scale_options="FBX_SCALE_UNITS", global_scale=1.0, apply_unit_scale=True,
        axis_forward="Z", axis_up="Y", add_leaf_bones=False, bake_anim=False,
        use_armature_deform_only=False, colors_type="SRGB", mesh_smooth_type="FACE",
        path_mode="COPY", embed_textures=True)
    print("DD_FBX", path, len(me.polygons))


main()
