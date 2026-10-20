# Miniature du jeu (1920x1080) : un T-rex cartoon jaillit d'un dé doré fissuré, rayons arc-en-ciel,
# volcan au coucher du soleil, titre « DINO RNG » en 3D. Création originale.
# Usage : Blender --background --python thumbnail.py -- sortie.png
import bpy, math, random, sys
from mathutils import Vector

out = sys.argv[sys.argv.index("--") + 1]
random.seed(3)
bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene

def lin(h):
    h = h.lstrip("#"); c = [int(h[i:i+2], 16) / 255 for i in (0, 2, 4)]
    return tuple(((x + 0.055) / 1.055) ** 2.4 if x > 0.04045 else x / 12.92 for x in c)

def mat(name, hx, emit=0.0, rough=0.45, alpha=1.0):
    m = bpy.data.materials.new(name); m.use_nodes = True
    b = m.node_tree.nodes["Principled BSDF"]
    b.inputs["Base Color"].default_value = (*lin(hx), 1)
    b.inputs["Roughness"].default_value = rough
    if emit:
        b.inputs["Emission Color"].default_value = (*lin(hx), 1)
        b.inputs["Emission Strength"].default_value = emit
    if alpha < 1:
        b.inputs["Alpha"].default_value = alpha
        if hasattr(m, "surface_render_method"):
            m.surface_render_method = "BLENDED"
    return m

def smooth(o, levels=2):
    o.modifiers.new("S", "SUBSURF").levels = levels
    o.modifiers["S"].render_levels = levels
    for p in o.data.polygons:
        p.use_smooth = True

def ball(loc, scale, m, rot=(0, 0, 0), sub=2):
    bpy.ops.mesh.primitive_uv_sphere_add(segments=24, ring_count=12, location=loc, rotation=rot)
    o = bpy.context.active_object; o.scale = scale; o.data.materials.append(m); smooth(o, sub); return o

def cone(loc, r1, r2, depth, m, rot=(0, 0, 0), verts=16, sm=True):
    bpy.ops.mesh.primitive_cone_add(vertices=verts, radius1=r1, radius2=r2, depth=depth, location=loc, rotation=rot)
    o = bpy.context.active_object; o.data.materials.append(m)
    if sm:
        for p in o.data.polygons:
            p.use_smooth = True
    return o

# ---------- Ciel : dégradé coucher de soleil (fenêtre) ----------
world = bpy.data.worlds.new("Sky"); scene.world = world; world.use_nodes = True
nt = world.node_tree; nt.nodes.clear()
tc = nt.nodes.new("ShaderNodeTexCoord"); sep = nt.nodes.new("ShaderNodeSeparateXYZ")
ramp = nt.nodes.new("ShaderNodeValToRGB"); bg = nt.nodes.new("ShaderNodeBackground"); wo = nt.nodes.new("ShaderNodeOutputWorld")
nt.links.new(tc.outputs["Window"], sep.inputs[0]); nt.links.new(sep.outputs["Y"], ramp.inputs[0])
nt.links.new(ramp.outputs[0], bg.inputs[0]); nt.links.new(bg.outputs[0], wo.inputs[0])
cr = ramp.color_ramp
cr.elements[0].position = 0.25; cr.elements[0].color = (*lin("#FFB13B"), 1)
cr.elements[1].position = 1.0; cr.elements[1].color = (*lin("#2A0F5C"), 1)
for p, c in ((0.42, "#FF5E3A"), (0.6, "#C02A7A"), (0.8, "#5A1C8C")):
    e = cr.elements.new(p); e.color = (*lin(c), 1)

# ---------- Caméra ----------
bpy.ops.object.camera_add(location=(0, -30, 9))
cam = bpy.context.active_object; scene.camera = cam; cam.data.lens = 30
aim = Vector((0, 0, 7.4)) - cam.location
cam.rotation_euler = aim.to_track_quat("-Z", "Y").to_euler()

# ---------- Fond : volcan, montagnes, palmiers en silhouette ----------
rock = mat("Rock", "#3A1838")
cone((10, 30, 0), 13, 3.2, 17, rock, verts=10, sm=False)
cone((10, 30, 8.3), 3.3, 2.6, 0.6, mat("Lava", "#FF6A1F", emit=8), verts=10, sm=False)
for i in range(4):  # coulées de lave
    a = -0.5 + i * 0.35
    bpy.ops.mesh.primitive_cube_add(size=1, location=(10 + math.sin(a) * 4, 26.5, 4.5))
    o = bpy.context.active_object; o.scale = (0.35, 0.1, 4.5); o.rotation_euler = (0, a * 0.6, 0)
    o.data.materials.append(bpy.data.materials["Lava"])
for i in range(7):
    x = -34 + i * 11 + random.uniform(-2, 2)
    cone((x, 34, 2.5), random.uniform(7, 10), 0, random.uniform(6, 10), mat("Mt%d" % i, "#4A1E52"), verts=5, sm=False)
palm = mat("Palm", "#1E0E2A")
for x in (-17, -13.5, 15.5, 19):
    h = random.uniform(6, 8)
    bpy.ops.mesh.primitive_cylinder_add(vertices=8, radius=0.25, depth=h, location=(x, 8, h / 2), rotation=(0, math.radians(random.uniform(-8, 8)), 0))
    bpy.context.active_object.data.materials.append(palm)
    for k in range(6):
        a = k * math.tau / 6
        bpy.ops.mesh.primitive_cube_add(size=1, location=(x + math.cos(a) * 1.5, 8 + math.sin(a) * 0.6, h - 0.2))
        o = bpy.context.active_object; o.scale = (1.8, 0.35, 0.08)
        o.rotation_euler = (0, math.radians(25), a); o.data.materials.append(palm)

# Sol de jungle.
bpy.ops.mesh.primitive_plane_add(size=200, location=(0, 0, 0))
bpy.context.active_object.data.materials.append(mat("Ground", "#2E8A3A", rough=0.9))

# ---------- Rayons arc-en-ciel derrière le dé ----------
center = Vector((0, 4, 4.5))
rainbow = ["#FF3B3B", "#FF9A1F", "#FFE32E", "#3CE05A", "#2FA8FF", "#9B4DFF", "#FF4FD8"]
for i in range(28):
    a = i * math.tau / 28
    if abs(math.cos(a)) < 0.2:
        continue  # pas de rayon horizontal qui barre le décor
    m = mat("Ray%d" % i, rainbow[i % len(rainbow)], emit=2.5, alpha=0.4)
    bpy.ops.mesh.primitive_plane_add(size=1, location=center + Vector((0, 1, 0)))
    o = bpy.context.active_object
    o.rotation_euler = (math.radians(90), a, 0)
    o.scale = (0.9 if i % 2 else 0.5, 40, 1)
    o.location = center + Vector((math.cos(a + math.pi / 2) * 0, 1.5, 0))
    o.data.materials.append(m)
# Halo doré.
for r, al in ((5, 0.3), (7.5, 0.15), (11, 0.07)):
    bpy.ops.mesh.primitive_circle_add(vertices=64, radius=r, fill_type="NGON", location=center + Vector((0, 1.2, 0)), rotation=(math.radians(90), 0, 0))
    bpy.context.active_object.data.materials.append(mat("Halo%d" % r, "#FFE07A", emit=4, alpha=al))

# ---------- Dé doré fissuré ----------
gold = mat("Gold", "#FFC21F", emit=0.6, rough=0.25)
bpy.ops.mesh.primitive_cube_add(size=4.4, location=(0, 1, 2.2), rotation=(math.radians(8), math.radians(-14), math.radians(28)))
die = bpy.context.active_object; die.data.materials.append(gold)
bev = die.modifiers.new("B", "BEVEL"); bev.width = 0.55; bev.segments = 6
pip = mat("Pip", "#5A2A00")
dm = die.matrix_world
for local in ((0, -2.21, 0), (-1.1, -2.21, 1.1), (1.1, -2.21, -1.1), (2.21, 0, 0), (2.21, 1.1, 1.1), (2.21, -1.1, -1.1)):
    n = Vector(local); normal = Vector((round(n.x / 2.21) if abs(n.x) > 2 else 0, round(n.y / 2.21) if abs(n.y) > 2 else 0, 0))
    bpy.ops.mesh.primitive_cylinder_add(vertices=24, radius=0.38, depth=0.1, location=dm @ n)
    o = bpy.context.active_object
    o.rotation_mode = "QUATERNION"; o.rotation_quaternion = dm.to_quaternion() @ Vector((0, 0, 1)).rotation_difference(normal)
    o.data.materials.append(pip)
crack = mat("Crack", "#FFF6C2", emit=12)
for i in range(7):  # fissures lumineuses sur le dessus
    a = i * math.tau / 7 + random.uniform(-0.2, 0.2)
    bpy.ops.mesh.primitive_cube_add(size=1, location=dm @ Vector((math.cos(a) * 1.2, math.sin(a) * 1.2, 2.25)))
    o = bpy.context.active_object; o.scale = (1.6, 0.08, 0.05)
    o.rotation_euler = (die.rotation_euler.x, die.rotation_euler.y, die.rotation_euler.z + a)
    o.data.materials.append(crack)
# Éclats de dé qui volent.
for _ in range(14):
    d = Vector((random.uniform(-1, 1), random.uniform(-0.6, 0.2), random.uniform(0.3, 1))).normalized()
    bpy.ops.mesh.primitive_cube_add(size=random.uniform(0.35, 0.8), location=Vector((0, 0.5, 4)) + d * random.uniform(3.5, 7))
    o = bpy.context.active_object; o.rotation_euler = (random.random() * 6, random.random() * 6, random.random() * 6)
    o.data.materials.append(gold)

# ---------- T-rex cartoon qui jaillit du dé ----------
_before = set(bpy.context.scene.objects)
skin = mat("Skin", "#2FD15A", rough=0.4)
belly = mat("Belly", "#FFE36B", rough=0.5)
spike = mat("Spike", "#FF7A1F", rough=0.4)
white = mat("White", "#FFFFFF", rough=0.2)
black = mat("Black", "#140A14", rough=0.2)
mouth = mat("Mouth", "#B3123A", rough=0.5)
base = Vector((0, 0.2, 4.4))
ball(base + Vector((0, 0, 1.2)), (1.7, 1.4, 2.0), skin, rot=(math.radians(-12), 0, 0))       # corps
ball(base + Vector((0, -1.0, 0.9)), (1.2, 0.7, 1.6), belly, rot=(math.radians(-12), 0, 0))   # ventre
ball(base + Vector((0, -0.4, 3.6)), (1.0, 0.9, 1.1), skin)                                 # cou
head = base + Vector((0, -1.5, 4.9))
ball(head, (1.65, 1.9, 1.25), skin, rot=(math.radians(-20), 0, 0))                          # crâne
ball(head + Vector((0, -1.5, -0.25)), (1.25, 1.2, 0.7), skin, rot=(math.radians(-20), 0, 0))  # museau
ball(head + Vector((0, -1.1, -1.35)), (1.15, 1.35, 0.42), skin, rot=(math.radians(18), 0, 0))  # mâchoire ouverte
ball(head + Vector((0, -1.15, -0.85)), (0.85, 0.9, 0.4), mouth, rot=(math.radians(5), 0, 0))  # intérieur de la gueule
for sx in (-1, 1):                                                                           # dents
    for k in range(4):
        t = k / 3
        cone(head + Vector((sx * (0.95 - t * 0.3), -0.7 - t * 1.6, -0.55)), 0.13, 0, 0.42, white, rot=(math.radians(180), 0, 0), verts=8)
        cone(head + Vector((sx * (0.85 - t * 0.25), -0.5 - t * 1.4, -1.15)), 0.12, 0, 0.36, white, verts=8)
for sx in (-1, 1):                                                                           # yeux expressifs
    e = head + Vector((sx * 0.85, -0.85, 0.6))
    ball(e, (0.55, 0.45, 0.6), white, sub=1)
    ball(e + Vector((sx * 0.05, -0.32, 0.02)), (0.3, 0.2, 0.36), black, sub=1)
    ball(e + Vector((sx * 0.12, -0.5, 0.18)), (0.1, 0.06, 0.1), white, sub=1)
    bpy.ops.mesh.primitive_cube_add(size=1, location=e + Vector((sx * 0.1, -0.3, 0.75)))   # sourcils féroces
    o = bpy.context.active_object; o.scale = (0.65, 0.18, 0.12); o.rotation_euler = (0, sx * math.radians(-22), 0)
    o.data.materials.append(black)
for k in range(6):                                                                          # crête orange
    t = k / 5
    cone(base + Vector((0, 0.6 + t * 0.6, 6.0 - t * 4.8)), 0.42 - t * 0.12, 0, 0.9, spike, rot=(math.radians(-30 - t * 40), 0, 0), verts=6)
for sx in (-1, 1):                                                                          # petits bras griffus
    arm = base + Vector((sx * 1.45, -1.25, 2.0))
    ball(arm, (0.32, 0.32, 0.75), skin, rot=(math.radians(50), sx * math.radians(25), 0), sub=1)
    for c in (-0.12, 0.12):
        cone(arm + Vector((sx * 0.1 + c, -0.7, -0.35)), 0.07, 0, 0.3, white, rot=(math.radians(100), 0, 0), verts=6)
bpy.ops.mesh.primitive_cone_add(vertices=16, radius1=1.0, radius2=0.1, depth=4.5,          # queue
                                location=base + Vector((1.8, 2.2, -0.2)), rotation=(math.radians(70), math.radians(35), 0))
t = bpy.context.active_object; t.data.materials.append(skin); smooth(t, 1)

bpy.ops.object.empty_add(location=(0, 0.2, 4.4))
pivot = bpy.context.active_object
for o in set(bpy.context.scene.objects) - _before - {pivot}:
    o.parent = pivot
    o.matrix_parent_inverse = pivot.matrix_world.inverted()
pivot.rotation_euler = (math.radians(-8), 0, math.radians(-28))
pivot.scale = (1.15, 1.15, 1.15)

# ---------- Particules / étincelles ----------
spark = mat("Spark", "#FFF3A0", emit=10)
for _ in range(90):
    d = Vector((random.uniform(-1, 1), random.uniform(-0.3, 0.3), random.uniform(-0.2, 1))).normalized()
    bpy.ops.mesh.primitive_ico_sphere_add(subdivisions=1, radius=random.uniform(0.05, 0.16), location=center + d * random.uniform(4, 15))
    bpy.context.active_object.data.materials.append(random.choice([spark, bpy.data.materials["Ray2"], bpy.data.materials["Ray4"]]))

# ---------- Titre 3D « DINO RNG » ----------
def title(text, loc, size, face_hex, edge_hex, extrude=0.35):
    bpy.ops.object.text_add(location=loc, rotation=(math.radians(84), 0, math.radians(-4) if text == "DINO" else math.radians(3)))
    o = bpy.context.active_object
    o.data.body = text; o.data.align_x = "CENTER"; o.data.align_y = "CENTER"
    try:
        o.data.font = bpy.data.fonts.load("/System/Library/Fonts/Supplemental/Arial Black.ttf")
    except Exception:
        pass
    o.data.size = size; o.data.extrude = extrude; o.data.bevel_depth = 0.07; o.data.bevel_resolution = 3
    o.data.offset = 0.06
    o.data.materials.append(mat("Face_" + text, face_hex, emit=0.12, rough=0.35))
    o.data.materials.append(mat("Edge_" + text, edge_hex, rough=0.4))
    return o
title("DINO", (-7.4, -6, 13.0), 3.6, "#FFC400", "#B33A00")
title("RNG", (7.4, -6, 13.0), 3.6, "#22C8FF", "#1B2A8C")
# Contours épais sombres : copie du titre légèrement agrandie derrière.
for name, loc in (("DINO", (-7.4, -5.2, 12.95)), ("RNG", (7.4, -5.2, 12.95))):
    o = title(name, loc, 3.95, "#1A0A24", "#1A0A24", extrude=0.2)

# ---------- Lumières ----------
bpy.ops.object.light_add(type="SUN", rotation=(math.radians(55), math.radians(-25), math.radians(15)))
bpy.context.active_object.data.energy = 3.2; bpy.context.active_object.data.color = lin("#FFE6C8")
bpy.ops.object.light_add(type="POINT", location=(0, -2, 5)); bpy.context.active_object.data.energy = 2500
bpy.context.active_object.data.color = lin("#FFC24A")
bpy.ops.object.light_add(type="AREA", location=(-8, -14, 12)); l = bpy.context.active_object
l.data.energy = 4000; l.data.size = 8; l.data.color = lin("#9FC8FF"); l.rotation_euler = (math.radians(50), math.radians(-30), 0)

scene.render.engine = "BLENDER_EEVEE"
scene.render.resolution_x, scene.render.resolution_y = 1920, 1080
scene.view_settings.view_transform = "Standard"
scene.view_settings.look = "None"
scene.render.filepath = out
bpy.ops.render.render(write_still=True)
print("RENDER_OK")
