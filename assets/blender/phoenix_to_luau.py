# Convertit la forme exportée par phoenix.py (JSON, axes Blender) en module Luau (axes Roblox) pour ShrineService.
# Usage : python3 phoenix_to_luau.py PhoenixTotem_shapes.json ../../src/server/Data/PhoenixShape.luau
import json, sys
d = json.load(open(sys.argv[1]))
conv = lambda v: (v[0], v[2], -v[1])  # Blender (Z en haut, face -Y) -> Roblox (Y en haut, face +Z)
f = lambda v: "Vector3.new(%s)" % ", ".join("%.4f" % x for x in conv(v))
out = ["--!strict",
       "-- Forme du phénix du sanctuaire, GÉNÉRÉE par jeux-premier/assets/blender/phoenix.py + phoenix_to_luau.py",
       "-- (ne pas modifier à la main). Unités Blender, axes Roblox (Y en haut, le phénix regarde vers +Z).",
       "-- feathers : plume triangulaire (base p, direction d, axe de largeur u, longueur L, demi-largeur w, couleur c).",
       "", "return table.freeze({", "\tfeathers = {"]
for x in d["feathers"]:
    out.append('\t\t{ p = %s, d = %s, u = %s, L = %.4f, w = %.4f, c = "%s" },' % (f(x["p"]), f(x["d"]), f(x["u"]), x["L"], x["w"], x["c"]))
out += ["\t},", "\t-- balls : ellipsoïde (centre, rayons sur X / Y / Z Roblox, couleur).", "\tballs = {"]
for x in d["balls"]:
    s = x["s"]
    out.append('\t\t{ center = %s, radii = Vector3.new(%.4f, %.4f, %.4f), c = "%s" },' % (f(x["c"]), s[0], s[2], s[1], x["c2"]))
out += ["\t},", "\t-- cylinders : cou (centre, axe, rayon, longueur, couleur).", "\tcylinders = {"]
for x in d["cylinders"]:
    out.append('\t\t{ center = %s, axis = %s, r = %.4f, L = %.4f, c = "%s" },' % (f(x["c"]), f(x["a"]), x["r"], x["L"], x["c2"]))
out += ["\t},", "})"]
open(sys.argv[2], "w").write("\n".join(out) + "\n")
print("ok", len(d["feathers"]), "plumes")
