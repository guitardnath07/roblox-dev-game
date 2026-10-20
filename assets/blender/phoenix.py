# Phénix (création originale) pour le totem du sanctuaire : ailes levées en V, crête, longues plumes de queue.
# Un objet par couleur (Phoenix_Red / Phoenix_Orange / Phoenix_Gold / Phoenix_Dark) : Roblox les recolore à l'import.
import bpy, math, sys
from mathutils import Vector, Matrix

args = sys.argv[sys.argv.index("--") + 1:]
render_out, fbx_out = args[0], args[1]
bpy.ops.wm.read_factory_settings(use_empty=True)

def lin(h):
    h = h.lstrip("#"); c = [int(h[i:i+2], 16) / 255 for i in (0, 2, 4)]
    return tuple(((x + 0.055) / 1.055) ** 2.4 if x > 0.04045 else x / 12.92 for x in c)

COLORS = {"Red": "#C42A1C", "Orange": "#F2711C", "Gold": "#FFC23A", "Dark": "#2A1410"}
mats = {}
for name, hx in COLORS.items():
    m = bpy.data.materials.new("Phoenix_" + name); m.use_nodes = True
    b = m.node_tree.nodes["Principled BSDF"]; b.inputs["Base Color"].default_value = (*lin(hx), 1); b.inputs["Roughness"].default_value = 0.5
    m.use_backface_culling = False
    if name in ("Gold", "Orange"):
        b.inputs["Emission Color"].default_value = (*lin(hx), 1); b.inputs["Emission Strength"].default_value = 0.25
    mats[name] = m
groups = {k: [] for k in COLORS}
SHAPES = {"feathers": [], "balls": [], "cylinders": []}

def add(obj, color):
    obj.data.materials.append(mats[color]); groups[color].append(obj)

def feather(base, direction, length, width, color, twist=0.0):
    """Plume = losange allongé (cône à 4 côtés aplati) de `base` dans la direction donnée."""
    bpy.ops.mesh.primitive_cone_add(vertices=4, radius1=width, radius2=0.0, depth=length)
    o = bpy.context.active_object
    o.scale = (1, 0.18, 1)
    bpy.ops.object.transform_apply(scale=True)
    d = direction.normalized()
    rot = Vector((0, 0, 1)).rotation_difference(d).to_matrix().to_4x4() @ Matrix.Rotation(twist, 4, "Z")
    o.matrix_world = Matrix.Translation(base + d * length / 2) @ rot
    add(o, color)
    u = (rot.to_3x3() @ Vector((1, 0, 0))).normalized()
    SHAPES["feathers"].append({"p": list(base), "d": list(d), "u": list(u), "L": length, "w": width, "c": color})

def ball(loc, scale, color, seg=16):
    bpy.ops.mesh.primitive_uv_sphere_add(segments=seg, ring_count=seg // 2, location=loc)
    o = bpy.context.active_object; o.scale = scale; add(o, color)
    SHAPES["balls"].append({"c": list(loc), "s": list(scale), "c2": color})

# Corps : poitrail, ventre, cou, tête.
ball((0, 0, 0), (0.55, 0.45, 0.8), "Red")
ball((0, -0.12, -0.35), (0.42, 0.35, 0.55), "Orange")
bpy.ops.mesh.primitive_cone_add(vertices=12, radius1=0.36, radius2=0.22, depth=0.6, location=(0, -0.1, 0.85), rotation=(math.radians(-15), 0, 0))
add(bpy.context.active_object, "Red")
SHAPES["cylinders"].append({"c": [0, -0.1, 0.85], "a": list(bpy.context.active_object.matrix_world.to_3x3() @ Vector((0, 0, 1))), "r": 0.3, "L": 0.6, "c2": "Red"})
ball((0, -0.2, 1.3), (0.3, 0.3, 0.3), "Red")
# Bec doré pointé vers l'avant (-Y dans Blender).
feather(Vector((0, -0.42, 1.27)), Vector((0, -1, -0.18)), 0.4, 0.12, "Gold")
for x in (-0.13, 0.13):
    ball((x, -0.43, 1.36), (0.05, 0.05, 0.05), "Dark", seg=8)
# Crête : plumes dorées vers l'arrière.
for i, a in enumerate((-30, -10, 10, 30)):
    feather(Vector((0, -0.1, 1.5)), Vector((math.sin(math.radians(a)) * 0.4, 0.6, 1.0)), 0.55 + (1.5 - abs(i - 1.5)) * 0.15, 0.08, "Gold")

# Ailes levées en V : un bras qui monte de l'épaule jusqu'au-dessus de la tête ; les plumes partent du bras
# vers l'extérieur et le bas (rangées : couvertures rouges, secondaires orange, primaires dorées).
for side in (-1, 1):
    shoulder = Vector((side * 0.4, 0.05, 0.45))
    tip = Vector((side * 2.3, 0.15, 3.1))
    arm = (tip - shoulder).normalized()
    out = Vector((side * abs(arm.z), 0, -abs(arm.x))).normalized()  # perpendiculaire au bras, vers l'extérieur et le bas
    rows = ((13, 0.6, 0.3, "Red", 0.0), (14, 1.1, 0.32, "Orange", 0.06), (15, 1.8, 0.34, "Gold", 0.12))
    for count, length, width, color, depth in rows:
        for i in range(count):
            t = i / (count - 1)
            base = shoulder + (tip - shoulder) * (0.08 + 0.92 * t) + Vector((0, depth, 0))
            # Près du corps les plumes tombent ; vers le bout elles s'ouvrent et pointent vers le haut.
            direction = (out * (1 - t) + (out + arm * 1.6) * t).normalized()
            feather(base, direction, length * (0.75 + 0.55 * t), width, color, twist=side * 0.15)
    # Bord d'attaque garni de petites plumes rouges.
    for i in range(9):
        t = i / 8
        base = shoulder + (tip - shoulder) * t + Vector((0, -0.05, 0))
        feather(base, arm, 0.5, 0.24, "Red", twist=side * 0.3)

# Queue : 7 longues plumes larges en éventail vers le bas, terminées par une pointe dorée.
for i in range(7):
    a = __import__("math").radians(-33 + i * 11)
    direction = Vector((__import__("math").sin(a), 0.2, -__import__("math").cos(a)))
    length = 2.5 - abs(i - 3) * 0.22
    feather(Vector((0, 0.15, -0.6)), direction, length, 0.42, "Orange" if i % 2 else "Red")
    tipPos = Vector((0, 0.15, -0.6)) + direction.normalized() * (length - 0.1)
    feather(tipPos, direction, 0.8, 0.45, "Gold")
# Serres dorées.
for x in (-0.18, 0.18):
    feather(Vector((x, -0.1, -0.85)), Vector((0, -0.3, -1)), 0.4, 0.07, "Gold")

import json
json.dump(SHAPES, open(fbx_out.replace(".fbx", "_shapes.json"), "w"))

# Un objet par couleur.
for color, objs in groups.items():
    bpy.ops.object.select_all(action="DESELECT")
    for o in objs:
        o.select_set(True)
    bpy.context.view_layer.objects.active = objs[0]
    bpy.ops.object.join()
    joined = bpy.context.active_object; joined.name = "Phoenix_" + color
    bpy.ops.object.shade_flat()
tris = sum(len(p.vertices) - 2 for o in bpy.context.scene.objects if o.type == "MESH" for p in o.data.polygons)
print("TRIANGLES", tris)

# Export FBX pour l'importeur 3D de Roblox.
bpy.ops.object.select_all(action="SELECT")
bpy.ops.export_scene.fbx(filepath=fbx_out, use_selection=True, apply_unit_scale=True, apply_scale_options="FBX_SCALE_UNITS", add_leaf_bones=False, path_mode="COPY", embed_textures=True, mesh_smooth_type="FACE")

# Rendu d'aperçu.
scene = bpy.context.scene
world = bpy.data.worlds.new("W"); scene.world = world; world.use_nodes = True
world.node_tree.nodes["Background"].inputs[0].default_value = (*lin("#1C2433"), 1)
bpy.ops.object.camera_add(location=(1.8, -9, 1.2), rotation=(math.radians(88), 0, math.radians(11)))
scene.camera = bpy.context.active_object; scene.camera.data.lens = 40
bpy.ops.object.light_add(type="SUN", rotation=(math.radians(50), math.radians(10), math.radians(20)))
bpy.context.active_object.data.energy = 3.5
bpy.ops.object.light_add(type="AREA", location=(0, 4, 3)); bpy.context.active_object.data.energy = 600
scene.render.engine = "BLENDER_EEVEE"; scene.render.resolution_x = 1000; scene.render.resolution_y = 1000
scene.render.filepath = render_out
bpy.ops.render.render(write_still=True)
print("RENDER_OK")
