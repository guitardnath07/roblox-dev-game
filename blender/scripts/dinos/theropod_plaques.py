# DINO DICE — style « plaques » (MISE À JOUR STYLE n°2) + appui des pieds, pour les théropodes du Modeleur B
# (brindilraptor, sablegriffe, givrecroc, eclipsaurus, moussecrete, chronoraptor).
# Version : 1
# N'est importé QUE par ces build_<id>.py ; les helpers partagés (dd_common, theropod_helpers, dd_dino_rig...)
# ne sont pas modifiés : on remplace leurs fonctions dans le processus Blender du build seulement.
#
# apply(dd, R, set_split) :
#   - dd.skin_body : Skin sans subdivision (grandes facettes) ;
#   - dd.part : primitives grossières (u <= 8, v <= 5, segments <= 8) ;
#   - split_sharp : shade flat (une normale par face, comme en jeu) ;
#   - R.make_action : les cibles IK de cheville trop loin de la hanche (jambe qui ne peut pas les atteindre,
#     pied qui bascule et griffes sous le sol en Run/Attack) sont corrigées en levant le talon : le pied
#     pivote autour de la pointe de ses griffes jusqu'à ce que la cheville redevienne atteignable.
import math

from mathutils import Matrix, Vector

LOW = (("u", 8), ("v", 5), ("segments", 8))
REACH = 0.97  # part de la longueur cuisse + jambe utilisable par l'IK


def apply(dd, R, set_split, split, smooth=1):
    if getattr(dd, "_dd_plaques", False):
        return
    dd._dd_plaques = True
    skin, part, make_action = dd.skin_body, dd.part, R.make_action

    def skin_body(*a, **k):
        return skin(*a, **{**k, "subdiv": 0, "smooth_iters": smooth})

    def lowpoly_part(*a, **k):
        for key, lo in LOW:
            if key in k:
                k[key] = min(k[key], lo)
        return part(*a, **k)

    def flat(ob, angle):
        split(ob, angle)
        ob.data.shade_flat()

    def make_action_fixed(arm, col, dino_id, clip, length, loop, pose_fn, feet_fn=None):
        return make_action(arm, col, dino_id, clip, length, loop, pose_fn,
                           reach_fix(arm, col, feet_fn) if feet_fn else None)

    dd.skin_body, dd.part, R.make_action = skin_body, lowpoly_part, make_action_fixed
    set_split(flat)


def pose_matrix(arm, name):
    """Matrice de pose (espace armature) calculée à la main depuis les canaux de l'os et de ses parents :
    pendant make_action, la pose n'est pas encore évaluée par le depsgraph."""
    pb = arm.pose.bones[name]
    b = pb.bone
    basis = Matrix.Translation(pb.location) @ pb.rotation_quaternion.to_matrix().to_4x4()
    if b.parent is None:
        return b.matrix_local @ basis
    return pose_matrix(arm, b.parent.name) @ (b.parent.matrix_local.inverted() @ b.matrix_local) @ basis


def claw_tips(arm, col):
    """Décalage (pointe avant des griffes du pied - bout de l'os Foot) au repos, par côté."""
    mesh = next(o for o in col.objects if o.type == "MESH"
                and any(m.type == "ARMATURE" and m.object == arm for m in o.modifiers))
    out = {}
    for side in ("L", "R"):
        gi = mesh.vertex_groups["Toe." + side].index
        pts = [v.co for v in mesh.data.vertices if any(g.group == gi and g.weight > 0.5 for g in v.groups)]
        zmin = min(p.z for p in pts)
        tip = min((p for p in pts if p.z < zmin + 0.06), key=lambda p: p.y)
        out[side] = Vector((0.0, tip.y, tip.z)) - Vector((0.0, *arm.data.bones["Foot." + side].tail_local.yz))
    return out


def reach_fix(arm, col, feet_fn):
    bones = arm.data.bones
    tips = claw_tips(arm, col)
    reach = {s: REACH * (bones["UpperLeg." + s].length + bones["LowerLeg." + s].length) for s in ("L", "R")}

    def fixed(side, t, ank, toe):
        a, b = feet_fn(side, t, ank, toe)
        hip = pose_matrix(arm, "UpperLeg." + side).translation
        L = reach[side]
        if (a - hip).length <= L:
            return a, b
        piv = b + tips[side]

        def turn(p, th):  # rotation autour de l'axe X passant par la pointe des griffes (talon qui monte)
            d = p - piv
            c, s = math.cos(th), math.sin(th)
            return piv + Vector((d.x, d.y * c + d.z * s, -d.y * s + d.z * c))

        sgn = 1.0 if turn(a, 0.1).z > a.z else -1.0
        lo, hi = 0.0, 1.4
        if (turn(a, sgn * hi) - hip).length > L:
            lo = hi
        else:
            for _ in range(20):
                mid = 0.5 * (lo + hi)
                if (turn(a, sgn * mid) - hip).length > L:
                    lo = mid
                else:
                    hi = mid
            lo = hi
        return turn(a, sgn * lo), turn(b, sgn * lo)

    return fixed
