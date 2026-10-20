# DINO DICE — Export d'un dino unique vers des modules Luau lus au runtime (EditableMesh + squelette maison).
# Version : 2 (v2 : tableaux encodés « dd64 » (voir plus bas), animations en position + quaternion, fps par clip
#              (Idle 10), os quasi immobiles retirés, slots 7-9, couleur « back » ; v1 : nombres en clair, matrices 3x3)
#
# Sans interface (--python-exit-code AVANT -P, sinon une erreur sort avec le code 0) :
#   blender -b blender/dinos/<id>.blend --python-exit-code 1 -P blender/scripts/export_luau.py
#
# Écrit (espace ROBLOX : Y haut, le modèle regarde -Z, 1 unité = 1 stud, origine entre les pieds) :
#   src/client/DinoMeshes/<id>.luau  positions, triangles (1-based, anti-horaires vus de l'extérieur), slots,
#                                    bones (repos en clair : cf = x,y,z,R00..R22, espace MODÈLE), skinBones/skinWeights
#   src/client/DinoAnims/<id>.luau   par clip : loop, fps, frames, bones[nom] = 7 valeurs/image x,y,z,qx,qy,qz,qw
#                                    = CFrame.new(...) POSÉE en espace MODÈLE ; os absent = pose de repos
#   src/shared/Config/DinoLooks.luau entrée [id] = { colors = { main, belly, accent, glow, back } }
# Conversion Blender -> Roblox : (x, y, z) -> (-x, z, y) (rotation propre : l'avant -Y devient -Z).
# Boucles : `frames` images sans doublon de la première (le runtime reboucle) ; non-boucles : dernière image incluse.
import json
import math
import os
import re

import bpy
from mathutils import Matrix

PROJECT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
HEADER = "-- Généré par blender/scripts/export_luau.py : ne pas éditer à la main."
SRC_FPS, DEFAULT_FPS = 30, 15
CLIP_FPS = {"Idle": 10}  # Idle lent : 10 i/s suffisent (interpolation au runtime)
CLIP_ORDER = ["Idle", "Walk", "Run", "Attack", "Roar", "Celebrate", "Death"]
CONV = Matrix(((-1, 0, 0), (0, 0, 1), (0, 1, 0)))
TRI_MAX, TRI_BUDGET = 20000, 5000
STILL_POS, STILL_DEG = 0.01, 1.0  # un os qui bouge moins que ça (studs / degrés) sur tout le clip est retiré
QS = 2047  # échelle des composantes de quaternion (w=2 signé : -2048..2047)


def num(v, dec=3):
    """Nombre court : arrondi, zéros inutiles retirés, « 0. » initial retiré (-.25 est un nombre Luau valide)."""
    r = round(float(v), dec)
    if r == 0:
        return "0"
    s = ("%." + str(dec) + "f") % r
    s = s.rstrip("0").rstrip(".")
    return s.replace("0.", ".", 1) if s.startswith(("0.", "-0.")) else s


def conv(M):
    """Matrice 4x4 Blender (espace armature = modèle) -> (position, rotation 3x3) en espace Roblox."""
    return CONV @ M.translation, CONV @ M.to_3x3() @ CONV


def cf12(M):
    p, R = conv(M)
    return [num(x) for x in (p.x, p.y, p.z)] + [num(R[i][j]) for i in range(3) for j in range(3)]


def rows(values, per_line, indent):
    return "\n".join(indent + ",".join(values[i:i + per_line]) + "," for i in range(0, len(values), per_line))


def lua_key(name):
    return name if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", name) else '["%s"]' % name


def ordered_bones(arm):
    order, seen = [], set()

    def visit(b):
        if b.name not in seen:
            if b.parent:
                visit(b.parent)
            seen.add(b.name)
            order.append(b)

    for b in arm.data.bones:
        visit(b)
    return order


# ------------------------------------------------------------------ encodage « dd64 »
# Chaque valeur entière tient sur `w` caractères de l'alphabet base64 (6 bits par caractère, poids fort d'abord).
# Valeurs signées : on stocke v + 64^w / 2. Les chaînes sont des [[...]] coupées en lignes (retirer les blancs).
ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
DECODER = """-- Décodage (Luau) :
--   local A = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
--   local LUT = {} for i = 1, 64 do LUT[string.byte(A, i)] = i - 1 end
--   local function decode(s: string, w: number, signed: boolean, scale: number): { number }
--   	s = string.gsub(s, "%s", "")
--   	local out, half = table.create(#s // w), if signed then 64 ^ w / 2 else 0
--   	for i = 1, #s, w do
--   		local v = 0
--   		for j = i, i + w - 1 do v = v * 64 + LUT[string.byte(s, j)] end
--   		table.insert(out, (v - half) * scale)
--   	end
--   	return out
--   end"""


def enc(values, w, signed=False, scale=1.0):
    half = 64 ** w // 2 if signed else 0
    out = []
    for x in values:
        v = int(round(x / scale)) + half
        assert 0 <= v < 64 ** w, "valeur hors plage pour l'encodage : %r (w=%d)" % (x, w)
        out.append("".join(ALPHA[(v >> (6 * (w - 1 - k))) & 63] for k in range(w)))
    return "".join(out)


def dec(s, w, signed=False, scale=1.0):
    """Miroir Python du décodeur Luau (auto-contrôle de l'export)."""
    s = "".join(s.split())
    half = 64 ** w // 2 if signed else 0
    out = []
    for i in range(0, len(s), w):
        v = 0
        for ch in s[i:i + w]:
            v = v * 64 + ALPHA.index(ch)
        out.append((v - half) * scale)
    return out


def block(s, indent, width=120):
    lines = [s[i:i + width] for i in range(0, len(s), width)] or [""]
    return "[[\n" + "\n".join(indent + ln for ln in lines) + "]]"


def quant63(ws):
    """4 poids -> entiers 0..63 de somme exacte 63 (plus forts restes)."""
    raw = [w * 63 for w in ws]
    q = [int(math.floor(r)) for r in raw]
    for i in sorted(range(len(ws)), key=lambda i: -(raw[i] - q[i]))[:63 - sum(q)]:
        q[i] += 1
    return q


def export_mesh(dino_id, me_ob, bones):
    me = me_ob.data
    me.calc_loop_triangles()
    tris = me.loop_triangles
    assert len(tris) <= min(TRI_MAX, TRI_BUDGET), "budget dépassé : %d triangles" % len(tris)
    assert len(bones) <= 63, "trop d'os pour l'encodage sur 1 caractère"
    slot_attr = me.attributes["dd_slot"].data
    idx = {b.name: i + 1 for i, b in enumerate(bones)}
    gname = {g.index: g.name for g in me_ob.vertex_groups}

    pos, sb, sw = [], [], []
    for v in me.vertices:
        p = CONV @ v.co
        pos += [p.x, p.y, p.z]
        inf = sorted(((g.weight, idx[gname[g.group]]) for g in v.groups if g.weight > 1e-4), reverse=True)[:4]
        assert inf, "sommet %d sans poids" % v.index
        tot = sum(w for w, _ in inf)
        inf += [(0.0, 0)] * (4 - len(inf))
        q = quant63([w / tot for w, _ in inf])
        sb += [b if qq > 0 else 0 for qq, (_, b) in zip(q, inf)]
        sw += q
    # Sens des triangles : ordre de Blender conservé = anti-horaire vu de l'extérieur ; la conversion d'axes
    # étant une rotation propre, c'est encore vrai dans l'espace Roblox. Contrôle : volume signé > 0.
    P = [CONV @ v.co for v in me.vertices]
    vol = sum(P[a].dot(P[b].cross(P[c])) for a, b, c in (t.vertices for t in tris)) / 6.0
    assert vol > 0, "triangles retournés (volume signé %.3f)" % vol
    tri = [i + 1 for t in tris for i in t.vertices]
    assert all(abs(a - b) < 0.0051 for a, b in zip(dec(enc(pos, 2, True, 0.01), 2, True, 0.01), pos)), "dd64 positions"
    assert dec(enc(tri, 3), 3) == tri, "dd64 triangles"
    slots = [slot_attr[t.polygon_index].value for t in tris]
    height = max(v.co.z for v in me.vertices)
    root = bones[0]
    assert root.name == "Root" and root.head_local.length < 1e-6, "os racine absent ou hors origine"
    bl = ['\t\t{ name = "%s", parent = %d, cf = { %s } },' % (b.name, idx[b.parent.name] if b.parent else 0,
                                                              ",".join(cf12(b.matrix_local))) for b in bones]
    src = "\n".join([
        HEADER,
        "-- Format v2 « dd64 » : tableaux numériques encodés en chaînes (voir décodeur ci-dessous).",
        "--   positions   : 3 valeurs/sommet, w=2, signé, x0.01 stud     triangles : w=3, non signé, 1-based",
        "--   slots       : w=1 (1 main, 2 belly, 3 accent, 4 blanc, 5 pupille, 6 glow, 7 back, 8 bouche, 9 langue)",
        "--   skinBones   : 4 par sommet, w=1 (0 = inutilisé)              skinWeights : 4 par sommet, w=1, x1/63",
        DECODER,
        "return {",
        "\tversion = 2,",
        '\tencoding = "dd64",',
        '\tid = "%s",' % dino_id,
        "\theight = %s," % num(height, 2),
        "\tvertexCount = %d," % len(me.vertices),
        "\ttriangleCount = %d," % len(tris),
        "\tpositions = %s," % block(enc(pos, 2, True, 0.01), "\t\t"),
        "\ttriangles = %s," % block(enc(tri, 3), "\t\t"),
        "\tslots = %s," % block(enc(slots, 1), "\t\t"),
        "\tbones = { -- repos en espace MODÈLE (nombres en clair), parent = index 1-based (0 = aucun), parents avant enfants",
        "\n".join(bl),
        "\t},",
        "\tskinBones = %s," % block(enc(sb, 1), "\t\t"),
        "\tskinWeights = %s," % block(enc(sw, 1), "\t\t"),
        "}",
        "",
    ])
    return src, {"triangles": len(tris), "sommets": len(me.vertices), "os": len(bones), "hauteur": round(height, 3),
                 "volume_signe": round(vol, 2)}


def export_anims(dino_id, arm, bones):
    sc = bpy.context.scene
    acts = sorted((a for a in bpy.data.actions if a.get("dd_clip") and a.name.startswith(dino_id + "_")),
                  key=lambda a: CLIP_ORDER.index(a["dd_clip"]))
    rest = {b.name: conv(b.matrix_local) for b in bones}
    parts, info = [], {}
    for act in acts:
        clip = act["dd_clip"]
        fps = CLIP_FPS.get(clip, DEFAULT_FPS)
        step = SRC_FPS // fps
        L, loop = int(act["dd_len"]), bool(act["dd_loop"])
        assert L % step == 0, "%s : longueur %d non multiple de %d" % (act.name, L, step)
        frames = list(range(0, L if loop else L + 1, step))
        arm.animation_data.action = act
        data = {b.name: [] for b in bones}
        for f in frames:
            sc.frame_set(f)
            for b in bones:
                data[b.name].append(conv(arm.pose.bones[b.name].matrix))
        lines = ["\t\t%s = {" % clip, "\t\t\tloop = %s," % ("true" if loop else "false"), "\t\t\tfps = %d," % fps,
                 "\t\t\tframes = %d," % len(frames), "\t\t\tbones = {"]
        kept = 0
        for b in bones:
            rp, rR = rest[b.name]
            rq = rR.to_quaternion()
            moves = any((p - rp).length > STILL_POS or math.degrees(R.to_quaternion().rotation_difference(rq).angle)
                        > STILL_DEG for p, R in data[b.name])
            if not moves:
                continue
            kept += 1
            vals, prev = [], None
            for p, R in data[b.name]:
                q = R.to_quaternion().normalized()
                if prev is not None and q.dot(prev) < 0:  # q et -q : même rotation ; on garde le signe continu
                    q.negate()
                prev = q
                vals += [p.x / 0.01, p.y / 0.01, p.z / 0.01, q.x * QS, q.y * QS, q.z * QS, q.w * QS]
            lines.append("\t\t\t\t%s = %s," % (lua_key(b.name), block(enc(vals, 2, True), "\t\t\t\t\t")))
        lines += ["\t\t\t},", "\t\t},"]
        parts.append("\n".join(lines))
        info[clip] = {"fps": fps, "frames": len(frames), "os_animes": kept}
    src = "\n".join([
        HEADER,
        "-- Format v2 « dd64 » : par os animé, une chaîne de 7 valeurs par image (w=2, signé) :",
        "--   x, y, z (x0.01 stud) puis qx, qy, qz, qw (x1/%d) -> CFrame.new(x, y, z, qx, qy, qz, qw) POSÉE," % QS,
        "--   espace MODÈLE. Os absent d'un clip = pose de repos. Boucles sans doublon de la 1re image.",
        DECODER,
        "return {", "\tversion = 2,", '\tencoding = "dd64",',
        "\tfps = %d, -- par défaut ; chaque clip précise le sien" % DEFAULT_FPS, "\tclips = {"] + parts +
        ["\t},", "}", ""])
    return src, info

LOOKS_HEAD = """--!strict
-- Généré par blender/scripts/export_luau.py : ne pas éditer à la main.
-- Palette par dino (slots du mesh : 1 main, 2 belly, 3 accent, 6 glow, 7 back).
-- Slots fixés dans le code : 4 blanc d'œil / dents, 5 pupille, 8 intérieur de bouche, 9 langue.

export type DinoLook = { colors: { main: string, belly: string, accent: string, glow: string, back: string } }

local DinoLooks: { [string]: DinoLook } = {
"""
LOOKS_TAIL = """}

for _, look in DinoLooks do
	table.freeze(look.colors)
	table.freeze(look)
end

return table.freeze(DinoLooks)
"""
KEYS = ("main", "belly", "accent", "glow", "back")
HEX = r'"(#[0-9A-Fa-f]{6})"'
LOOK_LINE = re.compile(r"^\t(\w+) = \{ colors = \{ " + ", ".join("%s = %s" % (k, HEX) for k in KEYS) + r" \} \},$")
LOOK_LINE_V1 = re.compile(r"^\t(\w+) = \{ colors = \{ " + ", ".join("%s = %s" % (k, HEX) for k in KEYS[:4]) +
                          r" \} \},$")


def update_looks(dino_id, colors):
    path = os.path.join(PROJECT_DIR, "src", "shared", "Config", "DinoLooks.luau")
    entries = {}
    if os.path.exists(path):
        with open(path, encoding="utf-8") as fh:
            text = fh.read()
        body = text.split("local DinoLooks: { [string]: DinoLook } = {\n", 1)
        assert len(body) == 2, "DinoLooks.luau n'a pas le format généré : mise à jour refusée (rien n'est écrasé)"
        for line in body[1].split("\n}", 1)[0].splitlines():
            if not line.strip():
                continue
            m = LOOK_LINE.match(line) or LOOK_LINE_V1.match(line)
            assert m, "ligne inattendue dans DinoLooks.luau : %r (rien n'est écrasé)" % line
            g = m.groups()
            entries[g[0]] = tuple(g[1:]) + ((g[1],) if len(g) == 5 else ())  # v1 sans « back » : back = main
    entries[dino_id] = tuple(colors[k] for k in KEYS)
    lines = ["\t%s = { colors = { %s } }," % (k, ", ".join('%s = "%s"' % kv for kv in zip(KEYS, entries[k])))
             for k in sorted(entries)]
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(LOOKS_HEAD + "\n".join(lines) + "\n" + LOOKS_TAIL)
    return path


def write(path, src):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(src)
    return round(os.path.getsize(path) / 1024, 1)


def export_dino():
    sc = next(s for s in bpy.data.scenes if s.get("dd_id"))
    bpy.context.window.scene = sc
    dino_id = sc["dd_id"]
    me_ob = bpy.data.objects[dino_id + "_Mesh"]
    arm = bpy.data.objects[dino_id + "_Armature"]
    for ob in (me_ob, arm):
        assert ob.matrix_world == Matrix.Identity(4), "%s : transforms non appliqués" % ob.name
    bones = ordered_bones(arm)
    mesh_src, minfo = export_mesh(dino_id, me_ob, bones)
    anim_src, ainfo = export_anims(dino_id, arm, bones)
    return {
        "mesh": minfo, "clips": ainfo,
        "DinoMeshes_KB": write(os.path.join(PROJECT_DIR, "src", "client", "DinoMeshes", dino_id + ".luau"), mesh_src),
        "DinoAnims_KB": write(os.path.join(PROJECT_DIR, "src", "client", "DinoAnims", dino_id + ".luau"), anim_src),
        "DinoLooks": update_looks(dino_id, json.loads(sc["dd_colors"])),
    }


if __name__ == "__main__":
    print("DD_RESULT", json.dumps(export_dino()))
