# DINO DICE — Glitchosaure (secret, théropode, taille 1,6) : modèle + rig + 7 animations + rendus.
# Version : 1
# Référence : Spinosaurus aegyptiacus (grande voile dorsale = point le plus haut, museau long et étroit de
# crocodile, pattes arrière courtes, queue haute et aplatie en rame). Clin d'œil : dino « jamais fini de charger ».
# Couche thématique : corps en blocs (Skin sans subdivision, facettes vives) + blocs voxels décalés collés dessus ;
# voile = 9 colonnes de voxels de hauteurs inégales (2 décalées sur le côté) ; queue = 6 cubes flottants séparés
# (un os chacun) ; un œil en pixel carré, l'autre en « ? » ; damier magenta/noir (texture manquante) sur le museau ;
# arêtes néon vertes au sommet de la voile.
# Personnalité : instable ; se fige, saccade, se téléporte de côté, « T-pose » une fraction de seconde.
#   python3 bb.py blender/scripts/dinos/build_glitchosaure.py [-- model]
import math
import os
import sys

from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import theropod_helpers as H  # noqa: E402
from theropod_helpers import R, MAIN, BELLY, ACCENT, WHITE, DARK, GLOW, BACK, TONGUE  # noqa: E402,F401

# Style « plaques » (contournements locaux, les helpers restent intacts) : corps en blocs = Skin sans subdivision
# ni lissage (le helper fixe subdiv=1), primitives grossières (sphères 8 x 5, cônes <= 8 côtés), rendu à plat.
_skin = H.dd.skin_body
H.dd.skin_body = lambda *a, **k: _skin(*a, **{**k, "subdiv": 0, "smooth_iters": 0})
_part = H.dd.part


LOC_BONES = ["TailCube%d" % i for i in range(1, 7)]

# key_all (build_theropod_rig) ne pose de clé de position que sur Hips : on ajoute les os qui se déplacent
_key_all = H.rig.key_all


def _key_all_loc(arm, f):
    _key_all(arm, f)
    for name in LOC_BONES:
        arm.pose.bones[name].keyframe_insert("location", frame=f, group=name)


H.rig.key_all = _key_all_loc

def _coarse_part(name, kind, col, rgba, **kw):
    if kind == "sphere":
        kw["u"], kw["v"] = min(kw.get("u", 10), 8), min(kw.get("v", 7), 5)
    elif kind == "cone":
        kw["segments"] = min(kw.get("segments", 6), 8)
    return _part(name, kind, col, rgba, **kw)


H.dd.part = _coarse_part

ID, NAME = "glitchosaure", "Glitchosaure"
HEIGHT = 4.0 * 1.6
COLORS = {"main": "#FF00FF", "belly": "#00FF00", "accent": "#000000", "glow": "#00FFFF", "back": "#9C00D6"}
BG = (0.18, 0.18, 0.24)
NT = 2
NODES = [
    ("hanche", (0, 0.12, 1.40), 0.66, None),
    ("ventre", (0, -0.32, 1.50), 0.74, "hanche"),
    ("epaules", (0, -0.72, 1.72), 0.58, "ventre"),
    ("cou", (0, -0.92, 2.10), 0.50, "epaules"),
    ("cou2", (0, -1.00, 2.45), 0.52, "cou"),
    ("crane", (0, -1.20, 2.95), 1.08, "cou2"),
    ("machoire", (0, -1.85, 2.75), 0.70, "crane"),
    ("museau", (0, -2.45, 2.68), 0.52, "machoire"),
    ("nez", (0, -2.95, 2.72), 0.46, "museau"),
    ("queue1", (0, 0.62, 1.45), 0.50, "hanche"),
    ("queue2", (0, 0.98, 1.52), 0.38, "queue1"),
    # pattes arrière courtes et épaisses
    ("bassin", (0.44, 0.06, 1.15), 0.54, None),
    ("cuisse", (0.54, -0.04, 0.85), 0.54, "bassin"),
    ("genou", (0.56, -0.18, 0.56), 0.30, "cuisse"),
    ("cheville", (0.54, 0.04, 0.28), 0.23, "genou"),
    ("pied", (0.54, -0.05, 0.15), 0.23, "cheville"),
    ("orteils", (0.54, -0.33, 0.12), 0.20, "pied"),
    ("epaule", (0.46, -0.90, 1.60), 0.18, None),
    ("coude", (0.70, -1.12, 1.35), 0.15, "epaule"),
    ("main", (0.66, -1.42, 1.30), 0.15, "coude"),
]
MOUTH_Y0 = -1.6
MOUTH_P = (0, -1.75, 2.58)
MOUTH_N = (0, -0.03, 1)
MOUTH_GAP = 0.02
CHIN_Y = -2.25
BELLY_COS = 0.5
BELLY_MAX_X = 0.5
BACK_PAINT = (0.4, 0.6, 1.6, -2.0)
SMILE_LIFT = (0.0, 0.5)
JAW_REST = 16.0
# Queue : 6 cubes flottants (centre y, z, longueur, hauteur, largeur, décalage x « glitch »), écarts 0,08 à 0,13
TCUBES = [(1.50, 1.60, 0.40, 0.72, 0.28, 0.00), (1.955, 1.68, 0.35, 0.64, 0.25, 0.05),
          (2.385, 1.62, 0.31, 0.55, 0.22, -0.04), (2.785, 1.72, 0.27, 0.46, 0.19, 0.03),
          (3.155, 1.66, 0.23, 0.37, 0.16, -0.06), (3.50, 1.75, 0.20, 0.28, 0.14, 0.02)]
EXTRA_BONES = [("TailCube%d" % (i + 1), Vector((0, y - L / 2, z)), Vector((0, y + L / 2, z)),
                "Tail2" if i == 0 else "TailCube%d" % i) for i, (y, z, L, _h, _w, _x) in enumerate(TCUBES)]
VOX = 0.26


def box(B, name, slot, gi, center, size, M=None):
    """Cube axe-aligné (ou orienté par M, dont seule la rotation compte) de taille (sx, sy, sz)."""
    T = Matrix.Translation(Vector(center))
    if M is not None:
        T = T @ M.to_3x3().to_4x4()
    return B.P(name, "cube", slot, gi, M=T @ Matrix.Diagonal((*size, 1)))


def side_hit(B, sx):
    hit, loc, nor, _i = B.body.ray_cast(Vector((0, -1.55, 3.2)), Vector((sx, -0.2, 0.15)).normalized())
    assert hit
    return loc, nor


def accessories(B):
    gh = B.grp("rigid", "Head")
    B.mouth_parts(n_up=6, n_lo=5, size=0.16, inset=0.06)
    # --- œil gauche : pixel carré (bloc blanc + pupille carrée noire + reflet carré)
    loc, nor = side_hit(B, 1)
    fr = H.frame_from(loc + nor * 0.02, nor)
    box(B, "OeilPixel", WHITE, gh, loc - nor * 0.02, (0.62, 0.62, 0.22), fr)
    box(B, "PupillePixel", DARK, gh, loc + nor * 0.1 + fr.to_3x3() @ Vector((-0.04, 0.0, 0)), (0.3, 0.3, 0.06), fr)
    box(B, "RefletPixel", WHITE, gh, loc + nor * 0.135 + fr.to_3x3() @ Vector((-0.12, 0.1, 0)), (0.1, 0.1, 0.02), fr)
    # --- œil droit : plaque blanche + « ? » en pixels noirs (lisible de face : +X local = avant)
    loc, nor = side_hit(B, -1)
    fr = H.frame_from(loc + nor * 0.02, nor)
    R3 = fr.to_3x3()
    box(B, "OeilPlaque", WHITE, gh, loc - nor * 0.02, (0.62, 0.68, 0.22), fr)
    q = [".#.", "#.#", "..#", ".#.", "...", ".#."]
    px = 0.1
    for r, row in enumerate(q):
        for c, ch in enumerate(row):
            if ch == "#":
                off = Vector(((c - 1) * px, (2.5 - r) * px, 0))
                box(B, "Interro", DARK, gh, loc + nor * 0.1 + R3 @ off, (px, px, 0.05), fr)
    # --- narines carrées
    for sx in (1, -1):
        box(B, "Narine", DARK, gh, B.snap((0.13 * sx, -3.15, 3.0), -0.005), (0.07, 0.07, 0.05))
    # --- damier « texture manquante » sur le dessus du museau (4 x 2 cases, noir sur magenta)
    for i in range(4):
        for j in range(2):
            if (i + j) % 2 == 0:
                continue
            y, x = -2.85 + 0.17 * i, (j - 0.5) * 0.17
            loc, nor = B.top(y, x)
            box(B, "Damier", ACCENT, gh, loc + nor * 0.005, (0.17, 0.17, 0.05), H.frame_from(loc, nor, (0, -1, 0)))
    # --- voile : 9 colonnes de voxels, hauteurs inégales, 2 colonnes décalées sur le côté
    heights = [4, 6, 8, 10, 9, 11, 8, 7, 4]
    for k, hgt in enumerate(heights):
        y = -0.75 + 0.19 * k
        bone = "Spine2" if y < -0.45 else "Spine1" if y < 0.0 else "Hips"
        g = B.grp("rigid", bone)
        loc, _n = B.top(y)
        x = 0.1 if k == 3 else -0.1 if k == 6 else 0.0
        z0 = loc.z - VOX * 0.6
        for s in range(hgt):
            slot = GLOW if s == hgt - 1 else (MAIN if s % 2 else BACK)
            dy = 0.03 * ((s * 7 + k * 3) % 3 - 1)  # petits décalages
            box(B, "Voile", slot, g, (x, y + dy, z0 + VOX * (s + 0.5)), (VOX * 0.7, VOX * 0.8, VOX * 0.96))
    # --- blocs voxels décalés collés au corps (morceaux « mal chargés »)
    gt = B.grp("dist", ["Hips", "Spine1", "Spine2"])
    for k, (p, sz, slot, gi) in enumerate((((0.62, -0.45, 1.65), 0.32, MAIN, gt), ((0.58, 0.2, 1.55), 0.28, BACK, gt),
                                            ((-0.6, -0.1, 1.75), 0.3, BACK, gt), ((-0.55, 0.4, 1.35), 0.24, MAIN, gt),
                                            ((0.55, -0.95, 3.7), 0.28, BACK, gh), ((-0.7, -1.0, 2.75), 0.3, MAIN, gh),
                                            ((0.42, 0.45, 1.0), 0.2, GLOW, gt))):
        loc, nor = B.surf(p)
        box(B, "Voxel%d" % k, slot, gi, loc + nor * sz * 0.12 + Vector((0, 0.04 * (k % 2), 0)), (sz, sz, sz))
    # --- queue : 6 cubes flottants séparés (aplatis en rame), arête néon sur le dessus
    for i, (y, z, L, hgt, w, dx) in enumerate(TCUBES):
        g = B.grp("rigid", "TailCube%d" % (i + 1))
        box(B, "QueueCube%d" % i, MAIN if i % 2 == 0 else BACK, g, (dx, y, z), (w, L, hgt))
        box(B, "QueueNeon%d" % i, GLOW, g, (dx, y, z + hgt / 2 + 0.03), (w * 0.7, L * 0.9, 0.06))
    B.hands(n=3, length=0.28, r=0.1, claw=WHITE, spread=30, claw_len=0.2, down=0.25)
    B.feet(n=3, length=0.38, r=0.14, claw=WHITE, spread=30, claw_len=0.22, back=0.2)


def build_mesh_flat(B):
    """Comme H.build_mesh, puis ombrage plat (une normale par face, comme en jeu)."""
    sc, col, rcol, ob, st = _build_mesh(B)
    ob.data.shade_flat()
    return sc, col, rcol, ob, st


_build_mesh = H.build_mesh
H.build_mesh = build_mesh_flat


def noise(t, seed, fps=15):
    """Bruit en escalier (valeurs dans [-1, 1]) qui change à chaque image exportée : saccades."""
    n = int(t * 120 * fps / 30 + 0.5) if t < 1 else 0
    x = math.sin(n * 12.9898 + seed * 78.233) * 43758.5453
    return (x - math.floor(x)) * 2 - 1


def step(t, a, b):
    return 1.0 if a <= t < b else 0.0



def lift_toes(A, clip, t):
    """Orteils relevés à la poussée (Run) et pendant la fente (Attack) : les grosses griffes ne rayent pas le sol
    (comme le pilote build_chronoraptor.py)."""
    for side, _sx in H.SIDES:
        if clip == "Run":
            ph = (t + (0.5 if side == "L" else 0.0)) % 1.0
            k = R.keys(ph, [(0, 0), (0.2, 0), (0.36, 1), (0.55, 0.6), (0.75, 0), (1, 0)])
            A.r("Toe." + side, (R.X, -45 * k))
        elif clip == "Attack":
            k = R.keys(t, [(0, 0), (0.28, 0.4), (0.38, 1), (0.55, 1), (0.85, 0), (1, 0)])
            A.r("Toe." + side, (R.X, -35 * k))

class Anims(H.Anims):
    HEAVY = 0.2

    def cubes(self, t, amp, wave, k=1.0):
        """Cubes de queue : ondulation + saccades de position (glitch)."""
        for i in range(6):
            n = self.P["TailCube%d" % (i + 1)]
            H.rig.rot(n, (R.Z, wave * R.S2(t, k, -0.12 * i)), (R.X, 0.5 * wave * R.S2(t, 2 * k, -0.1 * i)))
            H.rig.loc(n, (amp * noise(t, i) * self.u, 0, amp * noise(t, i + 9) * self.u))

    def extra(self, clip, t):
        amp = {"Idle": 0, "Walk": 0.03, "Run": 0.05, "Attack": 0.05, "Roar": 0.08, "Celebrate": 0.06, "Death": 0.02}
        k = {"Walk": 1, "Run": 1}.get(clip, 2)
        if clip != "Idle":
            self.cubes(t, amp[clip] * (step(t % 0.25, 0, 0.1)), 8, k)
        if clip in ("Walk", "Run"):  # grand sourire en marchant
            self.r("Jaw", (R.X, JAW_REST + 4 * R.S2(t, 2)))
        lift_toes(self, clip, t)

    # Instable : respire, se FIGE, saccade, se téléporte de côté puis revient, T-pose éclair
    def idle(self, t):
        P = self.base()
        frz = step(t, 0.18, 0.3)
        tf = 0.18 if frz else t  # figé : la pose de t = 0,18 reste affichée
        jit = step(t, 0.32, 0.4)
        tele = 0.45 * step(t, 0.48, 0.72)  # décalage latéral (multiples de u)
        tp = step(t, 0.8, 0.86)  # T-pose
        br = R.S2(tf, 2) * (1 - tp)
        self.hips(x=tele + 0.04 * jit * noise(t, 1), z=-0.02 + 0.02 * br + 0.03 * jit * noise(t, 2),
                  rz=(3 * R.S2(tf, 1) + 8 * jit * noise(t, 3)) * (1 - tp))
        for n in ("Spine1", "Spine2"):
            H.rig.rot(P[n], (R.X, -1.5 * br))
        H.rig.rot(P["Neck1"], (R.X, 2 * br + 10 * jit * noise(t, 4)))
        H.rig.rot(P["Head"], (R.X, (3 * R.S2(tf, 2, 0.3) + 14 * jit * noise(t, 5)) * (1 - tp)),
                  (R.Z, (10 * R.S2(tf, 1, 0.25) + 25 * jit * noise(t, 6)) * (1 - tp)),
                  (R.Y, 20 * jit * noise(t, 7)))
        H.rig.rot(P["Jaw"], (R.X, (JAW_REST + 3 * br + 30 * jit * max(0.0, noise(t, 8))) * (1 - tp)))
        self.tail(lambda i: ((R.Z, 5 * R.S2(tf, 1, -0.08 * i) * (1 - tp)), (R.X, 2 * R.S2(tf, 2, -0.1 * i) * (1 - tp))))
        for side, sx in H.SIDES:
            if tp:  # bras à l'horizontale, sur les côtés
                d = Vector((0.22 * sx, -0.25, -0.30)).normalized()  # repos épaule -> coude (NODES)
                q = d.rotation_difference(Vector((sx, -0.1, 0.05)).normalized())
                H.rig.rot(P["UpperArm." + side], (tuple(q.axis), math.degrees(q.angle)))
                H.rig.rot(P["LowerArm." + side], (R.X, 0))
            else:
                H.rig.rot(P["UpperArm." + side], (R.X, -8 * R.S2(tf, 2, 0.1) + 30 * jit * noise(t, 10 + sx)))
                H.rig.rot(P["LowerArm." + side], (R.X, -10 * R.S2(tf, 2, 0.2)))
        self.cubes(tf, 0.06 * jit + 0.02 * step(t % 0.2, 0.0, 0.05) * (1 - frz), 6 * (1 - tp), 1)

    def idle_feet(self, side, t, ank, toe):
        off = Vector((0.45 * step(t, 0.48, 0.72) * self.u, 0, 0))
        return ank + off, toe + off


if __name__ == "__main__":
    H.run(sys.modules[__name__])
