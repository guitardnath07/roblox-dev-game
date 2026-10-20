# Fond de l'arbre d'améliorations : arbre au coucher du soleil sous un ciel étoilé (création originale).
import bpy, math, random, sys
from mathutils import Vector

out = sys.argv[sys.argv.index("--") + 1]
random.seed(7)
bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene

def mat(name, color, emission=0.0, rough=0.8):
    m = bpy.data.materials.new(name)
    m.use_nodes = True
    b = m.node_tree.nodes["Principled BSDF"]
    b.inputs["Base Color"].default_value = (*color, 1)
    b.inputs["Roughness"].default_value = rough
    if emission > 0:
        b.inputs["Emission Color"].default_value = (*color, 1)
        b.inputs["Emission Strength"].default_value = emission
    return m

def hexc(h):
    h = h.lstrip("#")
    srgb = [int(h[i:i+2], 16) / 255 for i in (0, 2, 4)]
    return tuple(((c + 0.055) / 1.055) ** 2.4 if c > 0.04045 else c / 12.92 for c in srgb)

# Ciel : dégradé vertical (nuit en haut -> coucher de soleil à l'horizon), via les coordonnées « Window ».
world = bpy.data.worlds.new("Sky"); scene.world = world; world.use_nodes = True
nt = world.node_tree; nt.nodes.clear()
tc = nt.nodes.new("ShaderNodeTexCoord"); sep = nt.nodes.new("ShaderNodeSeparateXYZ")
ramp = nt.nodes.new("ShaderNodeValToRGB"); bg = nt.nodes.new("ShaderNodeBackground"); outn = nt.nodes.new("ShaderNodeOutputWorld")
nt.links.new(tc.outputs["Window"], sep.inputs[0]); nt.links.new(sep.outputs["Y"], ramp.inputs[0])
nt.links.new(ramp.outputs[0], bg.inputs[0]); nt.links.new(bg.outputs[0], outn.inputs[0])
cr = ramp.color_ramp
cr.elements[0].position = 0.28; cr.elements[0].color = (*hexc("#FFB347"), 1)
cr.elements[1].position = 1.0; cr.elements[1].color = (*hexc("#0B1530"), 1)
for pos, col in ((0.36, "#F07A3A"), (0.48, "#7A4A6E"), (0.62, "#1F4A63"), (0.8, "#13284A")):
    e = cr.elements.new(pos); e.color = (*hexc(col), 1)
bg.inputs[1].default_value = 1.0

# Caméra.
bpy.ops.object.camera_add(location=(0, -46, 9.5), rotation=(math.radians(87), 0, 0))
cam = bpy.context.active_object; scene.camera = cam; cam.data.lens = 30

# Soleil couchant (disque lumineux) derrière l'arbre.
bpy.ops.mesh.primitive_circle_add(vertices=64, radius=6, fill_type="NGON", location=(0, 34, 7.5), rotation=(math.radians(90), 0, 0))
bpy.context.active_object.data.materials.append(mat("Sun", hexc("#FFD98A"), emission=3))
for i, (radius, alpha) in enumerate(((8, 0.35), (10.5, 0.2), (13.5, 0.12), (17.5, 0.06))):
    glow = mat("Glow%d" % i, hexc("#FFA94D"), emission=1.5)
    glow.node_tree.nodes["Principled BSDF"].inputs["Alpha"].default_value = alpha
    if hasattr(glow, "surface_render_method"):
        glow.surface_render_method = "BLENDED"
    bpy.ops.mesh.primitive_circle_add(vertices=64, radius=radius, fill_type="NGON", location=(0, 34.1 + i * 0.05, 7.5), rotation=(math.radians(90), 0, 0))
    bpy.context.active_object.data.materials.append(glow)

# Étoiles dans le haut du ciel.
star = mat("Star", (1, 1, 1), emission=8)
for _ in range(170):
    x = random.uniform(-50, 50); z = random.uniform(16, 42)
    bpy.ops.mesh.primitive_ico_sphere_add(subdivisions=1, radius=random.uniform(0.04, 0.13), location=(x, 40, z))
    bpy.context.active_object.data.materials.append(star)

# Montagnes en silhouette sur l'horizon.
mount = mat("Mountains", hexc("#3B2A45"))
for i in range(9):
    x = -36 + i * 9 + random.uniform(-2, 2); h = random.uniform(3.5, 7)
    bpy.ops.mesh.primitive_cone_add(vertices=4, radius1=random.uniform(5, 7), depth=h, location=(x, 18, h / 2 - 0.5))
    bpy.context.active_object.data.materials.append(mount)

# Sol de terre craquelée.
bpy.ops.mesh.primitive_plane_add(size=120, location=(0, 0, 0))
bpy.context.active_object.data.materials.append(mat("Ground", hexc("#3E2722")))
crack = mat("Crack", hexc("#8A5A3C"))
for _ in range(60):
    x = random.uniform(-22, 22); y = random.uniform(-18, 10)
    bpy.ops.mesh.primitive_cube_add(size=1, location=(x, y, 0.02), rotation=(0, 0, random.uniform(0, math.pi)))
    o = bpy.context.active_object; o.scale = (random.uniform(1, 3.5), 0.06, 0.01); o.data.materials.append(crack)
grass = mat("Tuft", hexc("#2F5E2C"))
for _ in range(40):
    bpy.ops.mesh.primitive_cone_add(vertices=5, radius1=0.35, depth=random.uniform(0.5, 1.1), location=(random.uniform(-24, 24), random.uniform(-14, 8), 0.3))
    bpy.context.active_object.data.materials.append(grass)

# Arbre : tronc et branches récursives (cylindres), feuillage en grappes de sphères.
bark = mat("Bark", hexc("#3A2418"))
leaf_mats = [mat("Leaf%d" % i, hexc(c)) for i, c in enumerate(("#2F6B2E", "#3F8A37", "#5BA846"))]

def limb(start, direction, length, radius, depth):
    end = start + direction.normalized() * length
    mid = (start + end) / 2
    bpy.ops.mesh.primitive_cylinder_add(vertices=10, radius=radius, depth=length, location=mid)
    o = bpy.context.active_object
    o.rotation_mode = "QUATERNION"; o.rotation_quaternion = Vector((0, 0, 1)).rotation_difference(direction)
    o.data.materials.append(bark)
    bpy.ops.mesh.primitive_uv_sphere_add(segments=10, ring_count=8, radius=radius * 1.02, location=end)
    bpy.context.active_object.data.materials.append(bark)
    if depth == 0:
        for _ in range(9):
            off = Vector((random.uniform(-1, 1), random.uniform(-0.6, 0.6), random.uniform(-0.2, 1.0))) * 1.9
            bpy.ops.mesh.primitive_ico_sphere_add(subdivisions=2, radius=random.uniform(1.3, 2.3), location=end + off)
            bpy.context.active_object.data.materials.append(random.choice(leaf_mats))
        return
    for k in range(3 if depth > 1 else 2):
        ang = random.uniform(0.35, 0.8) * (1 if k % 2 == 0 else -1)
        d = direction.normalized()
        new = Vector((d.x * math.cos(ang) - d.z * math.sin(ang), d.y + random.uniform(-0.35, 0.35), d.x * math.sin(ang) + d.z * math.cos(ang)))
        limb(end, new, length * random.uniform(0.62, 0.78), radius * 0.62, depth - 1)

# Racines.
for a in range(6):
    t = a / 6 * math.tau
    limb(Vector((0, 0, 1.2)), Vector((math.cos(t), math.sin(t) * 0.6, -0.35)), 3.2, 0.45, 0)
for o in [o for o in bpy.context.scene.objects if o.type == "MESH" and o.data.materials and o.data.materials[0].name.startswith("Leaf") and o.location.z < 2]:
    bpy.data.objects.remove(o)
limb(Vector((0, 0, 0)), Vector((0, 0, 1)), 7.5, 1.1, 4)

# Lumières : contre-jour chaud du soleil + douce lumière froide de face.
bpy.ops.object.light_add(type="SUN", location=(0, 20, 10), rotation=(math.radians(-70), 0, 0))
bpy.context.active_object.data.energy = 3; bpy.context.active_object.data.color = hexc("#FFC07A"); bpy.context.active_object.data.use_shadow = False
bpy.ops.object.light_add(type="SUN", location=(0, -20, 10), rotation=(math.radians(55), 0, 0))
bpy.context.active_object.data.energy = 1.2; bpy.context.active_object.data.color = hexc("#9BB8FF")

scene.render.engine = "BLENDER_EEVEE"
scene.render.resolution_x, scene.render.resolution_y = 1600, 1000
scene.view_settings.view_transform = "Standard"
# Bloom (lueur du soleil et des étoiles) via le compositeur.
try:
    scene.use_nodes = True
    ct = scene.node_tree
    rl = ct.nodes.new("CompositorNodeRLayers"); glare = ct.nodes.new("CompositorNodeGlare")
    comp = [n for n in ct.nodes if n.bl_idname == "CompositorNodeComposite"] or [ct.nodes.new("CompositorNodeComposite")]
    glare.glare_type = "FOG_GLOW" if "FOG_GLOW" in [i.identifier for i in glare.bl_rna.properties["glare_type"].enum_items] else glare.glare_type
    ct.links.new(rl.outputs["Image"], glare.inputs[0]); ct.links.new(glare.outputs[0], comp[0].inputs[0])
except Exception as e:
    print("BLOOM_SKIPPED", e)
scene.render.filepath = out
bpy.ops.render.render(write_still=True)
print("RENDER_OK")
