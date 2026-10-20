# Génère un script Luau qui recrée l'arbre Rojo (src/) dans Studio via le MCP.
# Usage : python -I gen_sync.py <racine_projet> <sortie.luau>
import os, sys

root, out = sys.argv[1], sys.argv[2]
MOUNTS = [  # (dossier source, chemin Studio du parent, nom de l'instance racine)
    ("src/shared", 'game:GetService("ReplicatedStorage")', "Shared"),
    ("src/server", 'game:GetService("ServerScriptService")', "Server"),
    ("src/client", 'game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")', "Client"),
]

def classify(filename):
    base = filename[:-5]  # retire .luau
    if base.endswith(".server"): return base[:-7], "Script"
    if base.endswith(".client"): return base[:-7], "LocalScript"
    return base, "ModuleScript"

def lit(src):
    level = 1
    while ("]" + "=" * level + "]") in src: level += 1
    eq = "=" * level
    return f"[{eq}[\n{src}]{eq}]"

lines = ["local function mk(class, name, parent, src)",
         "\tlocal i = Instance.new(class); i.Name = name",
         "\tif src then i.Source = src end",
         "\ti.Parent = parent; return i end",
         "local count = 0"]
n = 0
def emit_dir(path, parent_var, name):
    global n
    entries = sorted(os.listdir(path))
    init = next((e for e in entries if e.startswith("init.") and e.endswith(".luau")), None)
    var = f"v{n}"; n += 1
    if init:
        _, cls = classify(init)
        src = open(os.path.join(path, init), encoding="utf-8").read()
        lines.append(f"local {var} = mk('{cls}', '{name}', {parent_var}, {lit(src)}); count += 1")
    else:
        lines.append(f"local {var} = mk('Folder', '{name}', {parent_var})")
    for e in entries:
        full = os.path.join(path, e)
        if e == init: continue
        if os.path.isdir(full):
            emit_dir(full, var, e)
        elif e.endswith(".luau"):
            nm, cls = classify(e)
            src = open(full, encoding="utf-8").read()
            lines.append(f"mk('{cls}', '{nm}', {var}, {lit(src)}); count += 1")
    return var

for src_dir, parent_expr, name in MOUNTS:
    pv = f"p{n}"; n += 1
    lines.append(f"local {pv} = {parent_expr}")
    lines.append(f"do local old = {pv}:FindFirstChild('{name}'); if old then old:Destroy() end end")
    emit_dir(os.path.join(root, src_dir), pv, name)
lines.append("return 'scripts synchronisés : ' .. count")
open(out, "w", encoding="utf-8").write("\n".join(lines) + "\n")
print("ok", os.path.getsize(out), "octets")
