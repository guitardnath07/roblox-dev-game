# DINO DICE — base « chibi à plaques » des ptérosaures UNIQUES du modeleur C (Aurorasaure, Spectrosaure,
# Solaripteryx). Utilisé seulement par build_aurorasaure.py, build_spectrosaure.py, build_solaripteryx.py.
# Version : 1
# Style demandé par le joueur (brief, mises à jour n°1 et n°2) : tête énorme, gros yeux à sourcils, griffes crème
# surdimensionnées, mains en patte d'ours ; rendu en PLAQUES façon jouet de construction : Skin non subdivisé
# (facettes planes), primitives grossières, blocs séparés (tête / cou / bras / cuisses), plaques dorsales plates
# biseautées, ombrage plat dans les rendus. Cible 1 500–3 500 triangles.

import math

import bmesh
import bpy

from flyer_swimmer_helpers import Ptero, V, Matrix, SIDES, S2, keys, frame_from, circle, mirror_inplace, plane_yz, \
    MAIN, WHITE, DARK  # noqa: F401
import dd_common as dd
import flyer_swimmer_helpers as _fsh

# Facettes = ombrage plat par face (use_smooth = False) : la séparation des arêtes vives de la base est inutile, et
# sur un Skin non subdivisé elle découpe le corps en ~300 îlots dont le vote de région (rig_mesh) se trompe
# (bouts de doigts pondérés sur le cou). On la neutralise pour CES builds seulement (processus séparé).
_fsh.split_sharp = lambda ob, angle_deg: None


def set_uv(ob, u, v):
    """Pièce rapportée qui suit une membrane : mêmes attributs dd_u / dd_v qu'un point de la membrane."""
    me = ob.data
    for name, val in (("dd_u", u), ("dd_v", v)):
        a = me.attributes.get(name) or me.attributes.new(name, "FLOAT", "POINT")
        a.data.foreach_set("value", [val] * len(me.vertices))
    return ob


def plate_outline(L, w, kind="losange"):
    """Contour d'une plaque dorsale (base à 0, pointe à L le long de +Y) : losange, trapèze biseauté, pointe."""
    if kind == "trapeze":
        return [(-w, 0), (w, 0), (w * 0.55, L * 0.8), (w * 0.2, L), (-w * 0.2, L), (-w * 0.55, L * 0.8)]
    if kind == "pointe":
        return [(-w, 0), (w, 0), (w * 0.3, L * 0.6), (0, L), (-w * 0.3, L * 0.6)]
    return [(-w * 0.6, 0), (w * 0.6, 0), (w, L * 0.45), (0, L), (-w, L * 0.45)]


class ChibiPtero(Ptero):
    SUBDIV, SMOOTH, BRANCH = 0, 1, 0.5
    DECIMATE = 1.0
    WING_NS, WING_NC = 10, 3
    SKIN_ROOT = None
    TRI_BUDGET = 3500
    EYE = ((0.5, -1.0, 3.1), 0.4)
    # bras-ailes levés vers l'avant, ailes repliées, pattes d'ours visibles (pose « prête à bondir »)
    PAWS = dict(up=14, sweep=-36, elbow=30, wrist=-10, tip=-10, twist=-30, fold=70)
    FOLD = 45  # grandes ailes repliées au repos (le bout ne traîne pas au sol)

    # ---------------------------------------------------------------- mesh : facettes planes
    def build_mesh(self):
        sc, col, rcol, ob, st = super().build_mesh()
        for p in ob.data.polygons:  # rendu « plaques » : une normale par face (comme en jeu)
            p.use_smooth = False
        return sc, col, rcol, ob, st

    def rig_mesh(self, col, ob):
        """Le vote de région des îlots (distance / rayon) favorise l'énorme crâne chibi, qui « gagne » les îlots des
        bras : rayon du crâne plafonné le temps du vote (self.rad ne sert qu'à ça dans rig_mesh)."""
        keep = self.rad
        self.rad = {k: min(r, self.VOTE_RCAP) if k in ("crane", "bec1") else r for k, r in keep.items()}
        try:
            return super().rig_mesh(col, ob)
        finally:
            self.rad = keep

    VOTE_RCAP = 0.45

    # ---------------------------------------------------------------- yeux à facettes
    def eyes(self, body, target, size, gi, iris_slot=None, look=(0, -1, 0), iris=0.7, pupil=0.44, squash=1.12,
             sink=0.3, pupil_slot=DARK, highlights=True, glow_only=False):
        """Comme Dino.eyes (blanc, iris, pupille, 2 reflets ; symétrisé) mais en grosses facettes, et `look` est la
        direction ABSOLUE du regard de l'œil droit (x > 0) : sur une tête-bloc la normale saute d'une face à l'autre."""
        _ok, loc, nor, _ = body.closest_point_on_mesh(V(target))
        ec = loc - nor * size * sink
        lk = V(look).normalized()
        out = [self.part("Oeil", "sphere", WHITE if not glow_only else iris_slot, gi, loc=ec,
                         scale=(size, size, size * squash), mirror_x=True, u=8, v=6)]
        fr = frame_from(ec + lk * size * 0.97, lk)
        n0 = len(out)
        if not glow_only:
            out.append(self.flat1("Iris", iris_slot, gi, circle(size * iris, 8), fr))
            out.append(self.flat1("Pupille", pupil_slot, gi, circle(size * pupil, 8, size * pupil * 0.9),
                                  fr @ Matrix.Translation((0, 0, 0.014))))
        if highlights:
            out.append(self.flat1("Reflet", WHITE, gi, circle(size * 0.2, 6),
                                  fr @ Matrix.Translation((-size * 0.2, size * 0.24, 0.03))))
            out.append(self.flat1("Reflet2", WHITE, gi, circle(size * 0.09, 5),
                                  fr @ Matrix.Translation((size * 0.22, -size * 0.18, 0.03))))
        for ob in out[n0:]:
            mirror_inplace(ob)
        self.eye_c, self.eye_n = ec, nor
        return out

    def brow(self, gi, slot, size, tilt=0.0, lift=1.1, w=0.36):
        """Sourcil-bloc au-dessus de l'œil (après eyes) : tilt > 0 = bout intérieur plus bas (air décidé)."""
        ec, nor = self.eye_c, self.eye_n
        top = ec + V((0, 0, size * lift)) + nor * size * 0.3
        a = top + V((-0.03, -w * 0.45, -tilt))
        b = top + V((0.06, w * 0.55, tilt))
        return self.cone_ab("Sourcil", slot, gi, a, b, 0.075, 0.05, seg=4, mirror_x=True, scale_x=0.55)

    # ---------------------------------------------------------------- plaques, pattes, griffes
    def back_plates(self, body, parts, slot, spots, kinds=("losange",)):
        """Plaques dorsales plates (prismes) dans le plan de symétrie : spots = [(y, z_approx, L, w), …]."""
        g_back = self.grp("dist", ["Hips", "Spine", "Neck1"])
        for k, (y, z, L, w) in enumerate(spots):
            _ok, p, n, _ = body.closest_point_on_mesh(V((0, y, z + 1.0)))
            d = (n + V((0, 0.7, 0))).normalized()
            ang = math.atan2(d.z, -d.y)
            M = Matrix.Translation(p - d * 0.06) @ plane_yz(ang)
            parts.append(self.flat("Plaque", slot, g_back, plate_outline(L, w, kinds[k % len(kinds)]), M, 0.09))

    def elbow_plates(self, body, parts, slot):
        g_hum = self.grp("rigid", "Humerus.S")
        c = dd.snap(body, self.pos["coude"] + V((0, 0.3, 0.05)), -0.03)
        d = V((0.02, 0.24, 0.12))
        parts.append(self.cone_ab("PointeCoude", slot, g_hum, c, c + d, 0.09, seg=4, mirror_x=True, scale_x=0.5))

    def bear_paws(self, parts, paw_slot, claw_slot, claw_len=0.17):
        """Main en patte d'ours au poignet (portée par l'avant-bras) + 3 grosses griffes crème."""
        g_fore = self.grp("rigid", "Forearm.S")
        paw = self.pos["poignet"] + V((-0.02, -0.16, -0.04))
        parts.append(self.part("Patte", "sphere", paw_slot, g_fore, loc=paw, scale=(0.21, 0.18, 0.16),
                               mirror_x=True, u=6, v=4))
        for dx in (-0.11, 0.0, 0.11):
            a = paw + V((dx, -0.12, -0.03))
            parts.append(self.cone_ab("GriffeMain", claw_slot, g_fore, a, a + V((dx * 0.3, -claw_len, -0.12)), 0.06,
                                      seg=4, mirror_x=True))

    def foot_claws(self, body, parts, claw_slot):
        g_foot = self.grp("rigid", "Foot.S")
        px = self.pos["pied"].x
        for dx in (-0.11, 0.0, 0.11):
            t = dd.snap(body, (px + dx, self.pos["pied"].y - 0.15, 0.10), -0.03)
            parts.append(self.cone_ab("Griffe", claw_slot, g_foot, t, t + V((dx * 0.3, -0.18, -0.06)), 0.065,
                                      seg=4, mirror_x=True))

    def strip(self, name, axis, widthfn, bones, anchor, slotfn, mirror, ns=6, xoff=0.0, frac=1.0):
        """Bande plate (ruban, flamme) le long d'une polyligne `axis` (vue de côté), largeur widthfn(s) avec
        s = 0..1 sur la longueur, coupée à `frac` de l'axe ; pondérée le long des os `bones` (répartis sur l'axe
        entier) depuis `anchor`. Les os sans « .S » restent au centre même si la bande est symétrisée."""
        axis = [V(p) + V((xoff, 0, 0)) for p in axis]
        acc = [0.0]
        for a, b in zip(axis, axis[1:]):
            acc.append(acc[-1] + (b - a).length)
        tot = acc[-1]
        lead, trail = [], []
        for k in range(ns + 1):
            d0 = tot * frac * k / ns
            i = max(j for j in range(len(axis) - 1) if acc[j] <= d0 + 1e-9) if d0 < tot else len(axis) - 2
            seg = axis[i + 1] - axis[i]
            p = axis[i] + seg * ((d0 - acc[i]) / seg.length)
            t = seg.normalized()
            perp = t.cross(V((1, 0, 0))).normalized()
            if perp.z < 0:
                perp = -perp
            w = widthfn(k / ns)
            lead.append(p + perp * (w * 0.5 + 0.004))
            trail.append(p - perp * (w * 0.5 + 0.004))
        n = len(bones)
        kn = [(0.0, anchor)] + [(((i + 0.5) / n) / frac, b) for i, b in enumerate(bones)]
        kn.append((max(1.0, kn[-1][0] + 0.01), bones[-1]))
        gi = self.grp("chain", kn)
        return self.sheet(name, gi, lead, trail, ns, 1, 0.045, slotfn, mirror_x=mirror, smooth_trail=0,
                          taper=0.0)

    def paws_pose(self, side, k, **over):
        p = {key: val * k for key, val in self.PAWS.items()}
        p.update(over)
        self.wing_pose(side, **p)

    def hollow_plate(self, name, slot, gi, outer, holes, normal, thick=0.03):
        """Plaque plate à vrais trous (voile, disque ajouré) : remplissage par triangle_fill, 2 faces."""
        bm = bmesh.new()
        edges = []
        for loop in [outer] + holes:
            vs = [bm.verts.new(p) for p in loop]
            edges += [bm.edges.new((vs[i], vs[(i + 1) % len(vs)])) for i in range(len(vs))]
        bmesh.ops.triangle_fill(bm, use_beauty=True, use_dissolve=False, edges=edges, normal=V(normal))
        nn = V(normal).normalized()
        for f in bm.faces:
            f.normal_update()
            if f.normal.dot(nn) < 0:
                f.normal_flip()
        dup = bmesh.ops.duplicate(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:])
        dfaces = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMFace)]
        dverts = [g for g in dup["geom"] if isinstance(g, bmesh.types.BMVert)]
        bmesh.ops.reverse_faces(bm, faces=dfaces)
        bmesh.ops.translate(bm, vec=-nn * thick, verts=dverts)
        bmesh.ops.translate(bm, vec=nn * thick * 0.5, verts=bm.verts[:])
        me = bpy.data.meshes.new(name)
        bm.to_mesh(me)
        bm.free()
        dd.fill_color(me, self.C[slot])
        ob = bpy.data.objects.new(name, me)
        self.col.objects.link(ob)
        return self.tag(ob, gi)

    # Célébration : comme la base (2 sauts), mais bras-ailes LEVÉS bien haut qui battent (pose « victoire »)
    def celebrate(self, t):
        super().celebrate(t)
        joy = keys(t, [(0, 0), (0.08, 1), (0.86, 1), (1, 0)])
        f = S2(t, 4)
        self.wings(up=(38 + 22 * f) * joy - 10 * (1 - joy), sweep=-12 * joy + 18 * (1 - joy), elbow=24 * joy,
                   wrist=-14 * f * joy, tip=-12 * f * joy, twist=-10, fold=22 * joy + self.FOLD * (1 - joy))
