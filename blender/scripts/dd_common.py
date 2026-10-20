# DINO DICE — module partagé des scripts de construction Blender (archétypes de dinos).
# Version : 1
#
# Méthode de modélisation (re-jouable) :
#   1. Blocking par squelette de sommets + modificateur Skin (une demi-créature, x >= 0).
#      Chaque sommet du squelette produit un anneau d'arêtes => boucles aux articulations
#      (cou, mâchoire, épaules, hanches, genoux, chevilles, chaque segment de queue).
#   2. Application du Skin, coupe exacte au plan x = 0, Mirror (clipping + fusion), Subdivision niveau 1.
#   3. Application, lissage, couleurs à plat par attribut de couleur (1 seul matériau).
#   4. Pièces rapportées (yeux, griffes, ailes, nageoires) en primitives low-poly, fusionnées dans le même mesh.
#   5. Mise à l'échelle (1 unité Blender = 1 stud), origine aux pieds, transforms appliqués.
#
# Convention d'axes : avant du dino = -Y, haut = +Z, largeur = X.
# Tout est construit dans une scène dédiée « DD_<Archetype> » : rien n'est touché dans les autres scènes.

import math

import bmesh
import bpy
from mathutils import Matrix, Vector, Euler

COLOR_ATTR = "Col"


# ---------------------------------------------------------------- utilitaires

def hex_rgba(h):
    h = h.lstrip("#")
    return (int(h[0:2], 16) / 255.0, int(h[2:4], 16) / 255.0, int(h[4:6], 16) / 255.0, 1.0)


def setup_scene(scene_name, collection_name):
    """Crée (ou réutilise) la scène et la collection de l'archétype, et la vide de NOS objets uniquement."""
    sc = bpy.data.scenes.get(scene_name) or bpy.data.scenes.new(scene_name)
    sc.unit_settings.system = "NONE"
    sc.unit_settings.system_rotation = "DEGREES"
    sc.unit_settings.scale_length = 1.0
    bpy.context.window.scene = sc

    def get_col(name):
        col = bpy.data.collections.get(name)
        if col is None:
            col = bpy.data.collections.new(name)
        if col.name not in sc.collection.children:
            sc.collection.children.link(col)
        # Nettoyage : uniquement les objets de NOTRE collection (re-jouable)
        for ob in list(col.objects):
            data = ob.data
            bpy.data.objects.remove(ob, do_unlink=True)
            if data is not None and data.users == 0:
                if isinstance(data, bpy.types.Mesh):
                    bpy.data.meshes.remove(data)
                elif isinstance(data, bpy.types.Camera):
                    bpy.data.cameras.remove(data)
                elif isinstance(data, bpy.types.Light):
                    bpy.data.lights.remove(data)
        return col

    col = get_col(collection_name)
    render_col = get_col(collection_name + "_Rendu")
    return sc, col, render_col


def fill_color(me, rgba):
    """Ajoute (si besoin) l'attribut de couleur par coin de face et le remplit d'une couleur unie."""
    attr = me.color_attributes.get(COLOR_ATTR)
    if attr is None:
        attr = me.color_attributes.new(COLOR_ATTR, "BYTE_COLOR", "CORNER")
    for d in attr.data:
        d.color_srgb = rgba
    me.color_attributes.active_color = attr
    me.color_attributes.render_color_index = me.color_attributes.find(COLOR_ATTR) if hasattr(me.color_attributes, "find") else 0
    return attr


def paint_faces(me, predicate, rgba):
    """Peint les faces (polygones) pour lesquelles predicate(center, normal) est vrai."""
    attr = me.color_attributes[COLOR_ATTR]
    n = 0
    for poly in me.polygons:
        if predicate(poly.center, poly.normal):
            for li in poly.loop_indices:
                attr.data[li].color_srgb = rgba
            n += 1
    return n


def paint_ventral(me, nodes, chain, rgba, cos_min=0.55, limbs=(), max_x=None):
    """
    Bande ventrale nette : `chain` = clés de la colonne ordonnées de la queue vers le museau.
    Une face est peinte si, vue depuis le point le plus proche de la colonne, elle est du côté ventral
    (X × direction avant : dessous du tronc, devant du cou, dessous de la mâchoire), à moins de
    acos(cos_min) de l'axe. Les faces dont le nœud le plus proche (distance / rayon) est dans `limbs`
    sont ignorées.
    """
    pos = {k: Vector(p) for k, p, _r, _par in nodes}
    rad = {k: (r if isinstance(r, (int, float)) else max(r)) for k, _p, r, _par in nodes}
    pts = [pos[k] for k in chain]
    xaxis = Vector((1, 0, 0))
    attr = me.color_attributes[COLOR_ATTR]
    for poly in me.polygons:
        c = poly.center.copy()
        c.x = abs(c.x)
        if max_x is not None and c.x > max_x:  # largeur max de la bande (évite bras et haut des cuisses)
            continue
        # distance rapportée au rayon : un gros torse « gagne » sur une petite épaule voisine
        if limbs and min(pos, key=lambda k: (pos[k] - c).length / rad[k]) in limbs:
            continue
        best = None
        for a, b in zip(pts, pts[1:]):
            ab = b - a
            t = max(0.0, min(1.0, (c - a).dot(ab) / ab.length_squared))
            p = a + ab * t
            d = (c - p).length
            if best is None or d < best[0]:
                best = (d, p, ab.normalized())
        _d, p, tdir = best
        ventral = xaxis.cross(tdir).normalized()
        off = c - p
        off -= tdir * off.dot(tdir)
        if off.length > 1e-6 and off.normalized().dot(ventral) > cos_min:
            for li in poly.loop_indices:
                attr.data[li].color_srgb = rgba


def _new_object(name, me, col):
    ob = bpy.data.objects.new(name, me)
    col.objects.link(ob)
    return ob


def bake_modifiers(ob):
    """Applique tous les modificateurs de l'objet (via le depsgraph, sans opérateur)."""
    dg = bpy.context.evaluated_depsgraph_get()
    dg.update()
    ob_eval = ob.evaluated_get(dg)
    new_me = bpy.data.meshes.new_from_object(ob_eval, preserve_all_data_layers=True, depsgraph=dg)
    old = ob.data
    ob.modifiers.clear()
    ob.data = new_me
    if old.users == 0:
        bpy.data.meshes.remove(old)
    return new_me


# ---------------------------------------------------------------- corps (Skin)

def skin_body(name, nodes, col, branch_smoothing=0.6, subdiv=1, smooth_iters=2, root=None):
    """
    nodes : liste de (clé, (x, y, z), rayon | (rx, ry), clé_parent | None), demi-squelette x >= 0.
    Chaque nœud sans parent est une racine (une par chaîne isolée), sauf si `root` impose la clé
    de la racine de la chaîne principale (utile pour orienter les anneaux depuis une extrémité).
    Retourne l'objet maillé final (Skin -> coupe x=0 -> Mirror -> Subdivision, tout appliqué).
    """
    index = {}
    verts = []
    for i, (key, pos, _r, _p) in enumerate(nodes):
        index[key] = i
        verts.append(pos)
    edges = [(index[p], index[k]) for (k, _pos, _r, p) in nodes if p is not None]

    me = bpy.data.meshes.new(name + "_squelette")
    me.from_pydata(verts, edges, [])
    me.update()
    ob = _new_object(name, me, col)

    skin = ob.modifiers.new("Skin", "SKIN")
    skin.branch_smoothing = branch_smoothing
    skin.use_smooth_shade = True
    if len(me.skin_vertices) == 0:
        me.skin_vertices.new()
    sv = me.skin_vertices[0].data
    for i, (key, _pos, r, parent) in enumerate(nodes):
        rr = (r, r) if isinstance(r, (int, float)) else r
        sv[i].radius = rr
        if root is None:
            sv[i].use_root = parent is None
        else:  # la racine de la chaîne principale (nœud 0) est déplacée sur `root`
            sv[i].use_root = key == root or (parent is None and i != 0)
    bake_modifiers(ob)

    # Coupe exacte au plan de symétrie, on garde x >= 0
    bm = bmesh.new()
    bm.from_mesh(ob.data)
    geom = bm.verts[:] + bm.edges[:] + bm.faces[:]
    bmesh.ops.bisect_plane(bm, geom=geom, plane_co=(0, 0, 0), plane_no=(1, 0, 0), clear_inner=True)
    for v in bm.verts:
        if abs(v.co.x) < 1e-4:
            v.co.x = 0.0
    # Le Skin laisse parfois des trous aux jonctions (hanches/épaules très chevauchantes) :
    # on bouche toute bordure qui n'est pas sur le plan de symétrie (la Subdivision lissera le bouchon).
    holes = [e for e in bm.edges if e.is_boundary and not (e.verts[0].co.x == 0.0 and e.verts[1].co.x == 0.0)]
    if holes:
        bmesh.ops.holes_fill(bm, edges=holes, sides=0)
    bm.to_mesh(ob.data)
    bm.free()

    mir = ob.modifiers.new("Mirror", "MIRROR")
    mir.use_axis = (True, False, False)
    mir.use_clip = True
    mir.use_mirror_merge = True
    mir.merge_threshold = 0.001
    if subdiv > 0:
        sub = ob.modifiers.new("Subdivision", "SUBSURF")
        sub.levels = subdiv
        sub.render_levels = subdiv
    bake_modifiers(ob)

    # Lissage léger (arrondit les facettes « boîte » du Skin sans changer la topologie)
    # + normales recalculées vers l'extérieur (le Skin en retourne parfois : utile avant paint_faces)
    bm = bmesh.new()
    bm.from_mesh(ob.data)
    for _ in range(smooth_iters):
        bmesh.ops.smooth_vert(bm, verts=bm.verts, factor=0.5, mirror_clip_x=True,
                              use_axis_x=True, use_axis_y=True, use_axis_z=True)
    bmesh.ops.recalc_face_normals(bm, faces=bm.faces)
    bm.to_mesh(ob.data)
    bm.free()
    ob.data.update()
    return ob


def skin_check(nodes, col, branch_smoothing=0.6):
    """Diagnostic : applique le Skin brut et renvoie les arêtes défectueuses (≠ 2 faces) hors plan x=0."""
    index = {n[0]: i for i, n in enumerate(nodes)}
    me = bpy.data.meshes.new("_dd_skin_check")
    me.from_pydata([n[1] for n in nodes], [(index[n[3]], index[n[0]]) for n in nodes if n[3]], [])
    ob = _new_object("_dd_skin_check", me, col)
    m = ob.modifiers.new("Skin", "SKIN")
    m.branch_smoothing = branch_smoothing
    if len(me.skin_vertices) == 0:
        me.skin_vertices.new()
    for i, n in enumerate(nodes):
        r = n[2]
        me.skin_vertices[0].data[i].radius = (r, r) if isinstance(r, (int, float)) else r
        me.skin_vertices[0].data[i].use_root = n[3] is None
    bake_modifiers(ob)
    bm = bmesh.new()
    bm.from_mesh(ob.data)
    bad = [tuple(round(c, 2) for c in (e.verts[0].co + e.verts[1].co) / 2)
           for e in bm.edges if len(e.link_faces) != 2]
    bm.free()
    data = ob.data
    bpy.data.objects.remove(ob, do_unlink=True)
    bpy.data.meshes.remove(data)
    return bad


def snap(body, point, offset=0.0):
    """Point le plus proche sur la surface du corps, décalé de `offset` le long de la normale
    (offset < 0 = enfoncé). Sert à coller yeux / griffes / cornes sur la peau."""
    ok, loc, nor, _ = body.closest_point_on_mesh(Vector(point))
    if not ok:
        return Vector(point)
    return loc + nor * offset


# ---------------------------------------------------------------- pièces rapportées

def part(name, kind, col, rgba, loc=(0, 0, 0), scale=(1, 1, 1), rot=(0, 0, 0), mirror_x=False, **kw):
    """
    Primitive low-poly colorée. kind : 'sphere' (u, v), 'cone' (segments, r1, r2, depth, cap),
    'cube'. rot en degrés. mirror_x : ajoute la copie symétrique en -X dans le même mesh.
    """
    bm = bmesh.new()
    if kind == "sphere":
        bmesh.ops.create_uvsphere(bm, u_segments=kw.get("u", 10), v_segments=kw.get("v", 7), radius=1.0)
    elif kind == "cone":
        bmesh.ops.create_cone(bm, cap_ends=kw.get("cap", True), cap_tris=True, segments=kw.get("segments", 6),
                              radius1=kw.get("r1", 1.0), radius2=kw.get("r2", 0.0), depth=kw.get("depth", 1.0))
    elif kind == "cube":
        bmesh.ops.create_cube(bm, size=1.0)
    else:
        raise ValueError(kind)

    mat = Matrix.LocRotScale(Vector(loc), Euler([math.radians(a) for a in rot]).to_quaternion(), Vector(scale))
    bmesh.ops.transform(bm, matrix=mat, verts=bm.verts)

    if mirror_x:
        dup = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
        dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
        dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
        bmesh.ops.scale(bm, vec=(-1, 1, 1), verts=dverts)
        bmesh.ops.reverse_faces(bm, faces=dfaces)

    me = bpy.data.meshes.new(name)
    bm.to_mesh(me)
    bm.free()
    fill_color(me, rgba)
    return _new_object(name, me, col)


def eye_pair(body, col, target, size, white=(1, 1, 1, 1), pupil=(0.1, 0.1, 0.13, 1), look=(0, -0.9, 0)):
    """Gros œil cartoon collé à la peau (près de `target`) + pupille tournée vers l'avant/extérieur."""
    _ok, loc, nor, _ = body.closest_point_on_mesh(Vector(target))
    center = loc + nor * (size * 0.25)
    d = (nor + Vector(look)).normalized()
    eye = part("Oeil", "sphere", col, white, loc=center, scale=(size, size * 1.05, size * 1.2),
               mirror_x=True, u=8, v=6)
    pup = part("Pupille", "sphere", col, pupil, loc=center + d * size * 0.72,
               scale=(size * 0.5, size * 0.5, size * 0.65), mirror_x=True, u=6, v=5)
    return [eye, pup]


def membrane(name, col, rgba, outline, thickness=0.06, mirror_x=False):
    """
    Membrane (aile, nageoire) : polygone plat défini par `outline` (liste de points 3D),
    extrudé en épaisseur selon sa normale, et triangulé proprement par éventail depuis le centre.
    """
    bm = bmesh.new()
    vs = [bm.verts.new(p) for p in outline]
    face = bm.faces.new(vs)
    bm.normal_update()
    n = face.normal.copy()
    # Pochette fermée : face du dessus + dessous + flancs
    ext = bmesh.ops.extrude_face_region(bm, geom=[face])
    top_verts = [g for g in ext["geom"] if isinstance(g, bmesh.types.BMVert)]
    bmesh.ops.translate(bm, vec=n * thickness, verts=top_verts)
    bmesh.ops.translate(bm, vec=-n * thickness * 0.5, verts=bm.verts[:])
    bmesh.ops.recalc_face_normals(bm, faces=bm.faces[:])
    # Les grandes n-gones sont découpées en éventail (quads/tris propres pour l'export)
    big = [f for f in bm.faces if len(f.verts) > 4]
    bmesh.ops.poke(bm, faces=big)
    if mirror_x:
        dup = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
        dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
        dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
        bmesh.ops.scale(bm, vec=(-1, 1, 1), verts=dverts)
        bmesh.ops.reverse_faces(bm, faces=dfaces)
    me = bpy.data.meshes.new(name)
    bm.to_mesh(me)
    bm.free()
    fill_color(me, rgba)
    return _new_object(name, me, col)


# ---------------------------------------------------------------- finalisation

def make_material(name):
    """Matériau unique : couleur de base lue dans l'attribut de couleur (couleurs à plat)."""
    mat = bpy.data.materials.get(name) or bpy.data.materials.new(name)
    mat.use_nodes = True
    nt = mat.node_tree
    nt.nodes.clear()
    out = nt.nodes.new("ShaderNodeOutputMaterial")
    bsdf = nt.nodes.new("ShaderNodeBsdfPrincipled")
    attr = nt.nodes.new("ShaderNodeVertexColor")
    attr.layer_name = COLOR_ATTR
    bsdf.inputs["Roughness"].default_value = 0.55
    nt.links.new(attr.outputs["Color"], bsdf.inputs["Base Color"])
    nt.links.new(bsdf.outputs["BSDF"], out.inputs["Surface"])
    attr.location = (-300, 0)
    out.location = (300, 0)
    return mat


def finalize(objs, final_name, material_name, target_height=None, target_length=None, recalc_normals=True):
    """
    Fusionne les objets en un seul mesh, met à l'échelle (hauteur ou longueur cible en studs),
    pose l'origine aux pieds (min Z = 0, centré en X/Y), applique les transforms, lisse, 1 matériau.
    """
    main = objs[0]
    with bpy.context.temp_override(active_object=main, object=main,
                                   selected_objects=objs, selected_editable_objects=objs):
        bpy.ops.object.join()
    ob = main
    ob.name = final_name
    me = ob.data
    me.name = final_name

    co = [v.co for v in me.vertices]
    minz = min(c.z for c in co)
    maxz = max(c.z for c in co)
    miny = min(c.y for c in co)
    maxy = max(c.y for c in co)
    s = 1.0
    if target_height:
        s = target_height / (maxz - minz)
    elif target_length:
        s = target_length / (maxy - miny)
    cy = (miny + maxy) * 0.5
    m = Matrix.Scale(s, 4) @ Matrix.Translation((0, -cy, -minz))
    me.transform(m)
    ob.matrix_world = Matrix.Identity(4)
    # Matrice squelette -> mesh final, gardée pour placer les os du rig sur les nœuds du Skin
    ob["dd_skel_matrix"] = [v for row in m for v in row]
    me.update()

    # Nettoyage : fusion des doublons, normales cohérentes
    bm = bmesh.new()
    bm.from_mesh(me)
    bmesh.ops.remove_doubles(bm, verts=bm.verts, dist=1e-5)
    loose_e = [e for e in bm.edges if not e.link_faces]
    if loose_e:
        bmesh.ops.delete(bm, geom=loose_e, context="EDGES")
    loose_v = [v for v in bm.verts if not v.link_edges]
    if loose_v:
        bmesh.ops.delete(bm, geom=loose_v, context="VERTS")
    if recalc_normals:  # False : pièces à une seule face / coques retournées volontairement (dinos uniques)
        bmesh.ops.recalc_face_normals(bm, faces=bm.faces)
    bm.to_mesh(me)
    bm.free()
    me.shade_smooth()

    mat = make_material(material_name)
    me.materials.clear()
    me.materials.append(mat)
    for p in me.polygons:
        p.material_index = 0
    attr = me.color_attributes.get(COLOR_ATTR)
    if attr is not None:
        me.color_attributes.active_color = attr
    return ob


def stats(ob):
    me = ob.data
    me.calc_loop_triangles()
    co = [v.co for v in me.vertices]
    dims = [max(c[i] for c in co) - min(c[i] for c in co) for i in range(3)]
    return {
        "objet": ob.name,
        "triangles": len(me.loop_triangles),
        "sommets": len(me.vertices),
        "faces": len(me.polygons),
        "dimensions_xyz": [round(d, 3) for d in dims],
        "min_z": round(min(c.z for c in co), 4),
        "materiaux": len(me.materials),
    }


# ---------------------------------------------------------------- rendu

def setup_render(sc, render_col, target, distance, height_ratio=0.35, res=900, azimuth=-35.0, lens=50):
    """Caméra 3/4 face (avant = -Y), fond uni, rendu Workbench lisible (couleurs d'attribut + contour)."""
    cam_data = bpy.data.cameras.new(render_col.name + "_Cam")
    cam_data.lens = lens
    cam = bpy.data.objects.new(render_col.name + "_Cam", cam_data)
    render_col.objects.link(cam)
    a = math.radians(azimuth)
    t = Vector(target)
    d = Vector((math.sin(a), -math.cos(a), height_ratio)).normalized()
    cam.location = t + d * distance
    cam.rotation_euler = (t - cam.location).to_track_quat("-Z", "Y").to_euler()
    sc.camera = cam

    world = bpy.data.worlds.get("DD_Fond") or bpy.data.worlds.new("DD_Fond")
    world.color = (0.80, 0.86, 0.93)
    sc.world = world

    r = sc.render
    r.engine = "BLENDER_WORKBENCH"
    r.resolution_x = res
    r.resolution_y = res
    r.resolution_percentage = 100
    r.film_transparent = False
    r.image_settings.file_format = "PNG"
    sh = sc.display.shading
    sh.light = "STUDIO"
    sh.color_type = "VERTEX"
    sh.show_object_outline = True
    sh.object_outline_color = (0.08, 0.08, 0.1)
    sh.show_cavity = True
    sh.cavity_type = "WORLD"
    sh.show_shadows = False
    sc.display.render_aa = "8"
    return cam


def render_to(sc, path):
    sc.render.filepath = path
    bpy.ops.render.render(write_still=True, scene=sc.name)
    return path
