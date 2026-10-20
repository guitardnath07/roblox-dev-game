# Simulation de progression DINO DICE : N joueurs gratuits en jeu actif (auto-lancer).
# Lit les chiffres directement dans src/shared/Config/*.luau (aucune valeur recopiée à la main).
# Usage : python -I scripts/simulate_progression.py [joueurs=10000] [graine=1] [id_de=prix ...] [rebirth_after=x]
#   Les paires id_de=prix / rebirth_after=x testent une PROPOSITION sans toucher aux fichiers Luau.
# Sortie : tableaux Markdown (temps pour chaque dé, rebirths, trous de progression) sur la sortie standard.
#
# Modèle (hypothèses, voir docs/equilibrage.md) :
# - 1 lancer / Economy.rollCooldownSeconds, x vitesse de lancer (arbre). Pas de passes, potions, événements, amis.
# - Tirage exact du jeu (du plus rare au plus commun) + trèfles + mutations taille/peau ; nombre de copies
#   par pas de temps ~ Poisson(lancers x P_i). Pas d'Instinct ni de Grade (relances non simulées).
# - Le joueur pose ses meilleurs dinos sur ses socles (6 + 2 par rebirth), les meilleurs sur les socles
#   de plus haut niveau. Les autres sont vendus (revenu de vente ignoré : estimation prudente).
# - Achats, dans l'ordre : dé suivant dès qu'il est abordable ; rebirth si cela fait gagner du temps pour
#   atteindre le prix du dé suivant ; sinon l'achat le moins cher (nœud Pièces / Chance / Vitesse de lancer
#   ou niveau de socle) s'il coûte ≤ 25 % du prix du dé suivant.
import math
import os
import random
import re
import statistics
import sys
from bisect import bisect_left
from multiprocessing import Pool

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CONFIG = os.path.join(ROOT, "src", "shared", "Config")
PER_MILLION = 1_000_000
HORIZON_H = 400
GAP_H = 2


# ---------------------------------------------------------------- lecture des tables Luau
def read(name):
    with open(os.path.join(CONFIG, name + ".luau"), encoding="utf-8") as f:
        return f.read()


def num(text):
    return float(text.replace("_", ""))


def scalar(src, key):
    m = re.search(r"\b" + key + r"\s*=\s*([\d_.e]+(?:\s*\*\s*[\d_.e]+)*)", src)
    if not m:
        raise SystemExit(f"valeur introuvable : {key}")
    value = 1.0
    for part in m.group(1).split("*"):
        value *= num(part.strip())
    return value


FIELD = re.compile(r'(\w+)\s*=\s*("(?:[^"\\]|\\.)*"|[^,\n}]+)')


def rows(src):
    """Lignes de table Luau à plat ({ id = "...", clé = valeur, ... }) -> liste de dicts."""
    out = []
    for body in re.findall(r"\{([^{}]*)\}", src, re.S):
        fields = {}
        for key, value in FIELD.findall(body):
            value = value.strip()
            if value.startswith('"'):
                fields[key] = value[1:-1]
            else:
                try:
                    fields[key] = num(value)
                except ValueError:
                    fields[key] = value
        if "id" in fields:
            out.append(fields)
    return out


def with_remainder(table, remainder_id):
    rest = PER_MILLION - sum(r["perMillion"] for r in table if r["id"] != remainder_id)
    for r in table:
        if r["id"] == remainder_id:
            r["perMillion"] = rest
    return table


def load():
    dinos = [(r["id"], r["oneIn"], r["baseIncome"]) for r in rows(read("Dinos")) if "oneIn" in r]
    dice = [
        (m[0], num(m[1]), num(m[2]))
        for m in re.findall(r'die\("(\w+)",\s*"[^"]*",\s*([\d_.e]+),\s*([\d_.e]+)', read("Dice"))
    ]
    mut = read("Mutations")
    sizes_src, skins_src = mut.split("local Skins")
    sizes = with_remainder([r for r in rows(sizes_src) if "perMillion" in r], "normal")
    skins = with_remainder([r for r in rows(skins_src) if "perMillion" in r], "normal")
    clovers = with_remainder([r for r in rows(read("Clovers")) if "perMillion" in r], "none")
    upgrades = [
        dict(id=m[0], branch=m[1], cost=num(m[2]), stat=m[3], value=num(m[4]), prereq=None if m[5] == "nil" else m[5][1:-1])
        for m in re.findall(
            r'node\("(\w+)",\s*"[^"]*",\s*"(\w+)",\s*([\d_.e]+),\s*"(\w+)",\s*([\d_.e]+),\s*(nil|"\w+")', read("Upgrades")
        )
    ]
    reb = read("Rebirth")
    first = [num(x) for x in re.search(r"firstCosts = table\.freeze\(\{([^}]*)\}", reb).group(1).split(",")]
    rebirth = dict(
        first=first,
        after=scalar(reb, "COST_MULTIPLIER_AFTER"),
        coins=scalar(reb, "coinsMultiplierPerRebirth"),
        luck=scalar(reb, "luckMultiplierPerRebirth"),
    )
    plots_src = read("Plots")
    plots = {
        k: scalar(plots_src, k)
        for k in (
            "startingPedestals",
            "pedestalsPerRebirth",
            "maxPedestals",
            "baseLevelCost",
            "levelCostMultiplier",
            "coinsBonusPerLevel",
            "maxLevel",
        )
    }
    cooldown = scalar(read("Economy"), "rollCooldownSeconds")
    assert len(dinos) == 28 and len(dice) == 14, (len(dinos), len(dice))
    return dict(dinos=dinos, dice=dice, sizes=sizes, skins=skins, clovers=clovers, upgrades=upgrades,
                rebirth=rebirth, plots=plots, cooldown=cooldown)


C = load()


def apply_overrides(args):
    """Surcharges de test passées en ligne de commande (prix de dés, multiplicateur des rebirths)."""
    for arg in args:
        key, value = arg.split("=")
        if key == "rebirth_after":
            C["rebirth"]["after"] = num(value)
        else:
            C["dice"] = [(i, l, num(value) if i == key else p) for (i, l, p) in C["dice"]]


OVERRIDES = [a for a in sys.argv[3:] if "=" in a]
apply_overrides(OVERRIDES)
DINOS, DICE, PLOTS, REB = C["dinos"], C["dice"], C["plots"], C["rebirth"]
MAX_PED = int(PLOTS["maxPedestals"])
ECO_STATS = {"coinsMultiplier", "luckMultiplier", "rollSpeedMultiplier"}
ECO_NODES = [u for u in C["upgrades"] if u["stat"] in ECO_STATS]

# Mutations combinées (taille x peau), triées par multiplicateur décroissant.
COMBOS = sorted(
    ((s["coinsMultiplier"] * k["coinsMultiplier"], s["perMillion"] * k["perMillion"] / PER_MILLION**2)
     for s in C["sizes"] for k in C["skins"]),
    reverse=True,
)
COMBO_MULT = [m for m, _ in COMBOS]
COMBO_Q = [q for _, q in COMBOS]
COMBO_CUM = []
_acc = 0.0
for q in COMBO_Q:
    _acc += q
    COMBO_CUM.append(_acc)
MAX_MULT = COMBO_MULT[0]
CLOVERS = [(c["multiplier"], c["perMillion"] / PER_MILLION) for c in C["clovers"]]


def rebirth_cost(index):
    first = REB["first"]
    if index <= len(first):
        return first[index - 1]
    return first[-1] * REB["after"] ** (index - len(first))


def pedestals(rebirths):
    return int(min(MAX_PED, PLOTS["startingPedestals"] + PLOTS["pedestalsPerRebirth"] * rebirths))


def level_cost(level):
    return math.floor(PLOTS["baseLevelCost"] * PLOTS["levelCostMultiplier"] ** (level - 1))


def exact_distribution(luck):
    """Miroir d'Odds.exactDistribution : liste de P_i dans l'ordre de DINOS."""
    out = [0.0] * len(DINOS)
    none_yet = 1.0
    for i in range(len(DINOS) - 1, 0, -1):
        p = min(1.0, luck / DINOS[i][1])
        out[i] = p * none_yet
        none_yet *= 1 - p
    out[0] = none_yet
    return out


_dist_cache = {}


def roll_distribution(luck):
    """Distribution par lancer, trèfles inclus (mélange pondéré)."""
    d = _dist_cache.get(luck)
    if d is None:
        d = [0.0] * len(DINOS)
        for mult, w in CLOVERS:
            for i, p in enumerate(exact_distribution(luck * mult)):
                d[i] += w * p
        _dist_cache[luck] = d
    return d


# ---------------------------------------------------------------- tirages aléatoires
def poisson(rng, m):
    if m <= 0:
        return 0
    if m > 40:
        return max(0, int(round(rng.gauss(m, math.sqrt(m)))))
    limit, k, p = math.exp(-m), 0, rng.random()
    while p > limit:
        k += 1
        p *= rng.random()
    return k


def copies_multipliers(rng, c, floor_mult):
    """Multiplicateurs de mutation des meilleures copies (au plus MAX_PED) parmi c copies, > floor_mult."""
    out = []
    if c <= 8:
        for _ in range(c):
            m = COMBO_MULT[min(len(COMBO_CUM) - 1, bisect_left(COMBO_CUM, rng.random()))]
            if m > floor_mult:
                out.append(m)
        return out
    remaining, q_left = c, 1.0
    for mult, q in COMBOS:
        if remaining <= 0 or len(out) >= MAX_PED or mult <= floor_mult:
            break
        share = min(1.0, q / q_left) if q_left > 0 else 1.0
        n = min(remaining, poisson(rng, remaining * share))
        out.extend([mult] * min(n, MAX_PED - len(out)))
        remaining -= n
        q_left -= q
    return out


# ---------------------------------------------------------------- un joueur
def simulate(seed):
    rng = random.Random(seed)
    t, coins, die, rebirths = 0.0, 0.0, 0, 0
    owned = set()  # nœuds de l'arbre
    stats = {"coinsMultiplier": 1.0, "luckMultiplier": 1.0, "rollSpeedMultiplier": 1.0}
    levels = [1] * MAX_PED  # niveaux de socles (gardés au rebirth)
    top = []  # revenus des meilleures copies possédées, décroissants (au plus MAX_PED)
    species = set()
    die_times = [None] * len(DICE)
    die_times[0] = 0.0
    rebirth_times = []
    milestones = [(0.0, 0)]  # (instant, dé possédé) : instants où « quelque chose de nouveau » arrive

    def income(n_ped=None, reb=None):
        n_ped = pedestals(rebirths) if n_ped is None else n_ped
        reb = rebirths if reb is None else reb
        lv = sorted(levels[:n_ped], reverse=True)
        base = sum(v * (1 + PLOTS["coinsBonusPerLevel"] * (lv[j] - 1)) for j, v in enumerate(top[:n_ped]))
        return base * stats["coinsMultiplier"] * (1 + REB["coins"] * reb)

    while die < len(DICE) - 1 and t < HORIZON_H * 3600:
        dt = min(900.0, max(5.0, t / 30))
        luck = DICE[die][1] * stats["luckMultiplier"] * (1 + REB["luck"] * rebirths)
        rolls = dt * stats["rollSpeedMultiplier"] / C["cooldown"]
        coins += income() * dt
        t += dt

        # Nouveaux dinos de ce pas de temps.
        dist = roll_distribution(luck)
        threshold = top[-1] if len(top) >= MAX_PED else 0.0
        new = []
        for i in range(len(DINOS) - 1, -1, -1):
            base = DINOS[i][2]
            if base * MAX_MULT <= threshold:
                continue
            c = poisson(rng, rolls * dist[i])
            if c == 0:
                continue
            if i not in species:
                species.add(i)
                milestones.append((t, die))
            new.extend(base * m for m in copies_multipliers(rng, c, threshold / base))
        if new:
            top = sorted(top + new, reverse=True)[:MAX_PED]

        # Achats.
        while True:
            if die < len(DICE) - 1 and coins >= DICE[die + 1][2]:
                coins -= DICE[die + 1][2]
                die += 1
                die_times[die] = t
                milestones.append((t, die))
                continue
            goal = DICE[die + 1][2] if die < len(DICE) - 1 else math.inf
            cost = rebirth_cost(rebirths + 1)
            inc = income()
            if coins >= cost and inc > 0:
                t_no = max(0.0, goal - coins) / inc
                t_yes = goal / income(pedestals(rebirths + 1), rebirths + 1)
                if t_yes < t_no * 1.2:  # +20 % : le gain de chance n'est pas compté dans t_yes
                    rebirths += 1
                    coins = 0.0
                    rebirth_times.append(t)
                    milestones.append((t, die))
                    continue
            # Achat le moins cher parmi les nœuds éco disponibles et le niveau de socle le plus bas.
            best = None
            for u in ECO_NODES:
                if u["id"] not in owned and (u["prereq"] is None or u["prereq"] in owned):
                    if best is None or u["cost"] < best[0]:
                        best = (u["cost"], "node", u)
            n_ped = pedestals(rebirths)
            j = min(range(n_ped), key=lambda k: levels[k])
            if levels[j] < PLOTS["maxLevel"]:
                lc = level_cost(levels[j])
                if best is None or lc < best[0]:
                    best = (lc, "level", j)
            if best and best[0] <= coins and best[0] <= 0.25 * goal:
                coins -= best[0]
                if best[1] == "node":
                    u = best[2]
                    owned.add(u["id"])
                    stats[u["stat"]] = max(stats[u["stat"]], u["value"])
                    milestones.append((t, die))
                else:
                    levels[best[2]] += 1
                continue
            break

    milestones.sort()
    gaps = []  # (début, durée, dé possédé) des attentes > GAP_H sans rien de nouveau
    for (a, owned_die), (b, _) in zip(milestones, milestones[1:] + [(t, die)]):
        if b - a > GAP_H * 3600:
            gaps.append((a, b - a, owned_die))
    return dict(die_times=die_times, rebirth_times=rebirth_times, gaps=gaps, end=t, species=len(species))


# ---------------------------------------------------------------- agrégation
def fmt_h(seconds):
    if seconds is None:
        return "—"
    if seconds < 3600:
        return f"{seconds / 60:.0f} min"
    return f"{seconds / 3600:.1f} h".replace(".", ",")


SUFFIXES = ["K", "M", "Md", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc"]


def fmt_big(n):
    """Miroir d'Odds.formatBig."""
    if n < 1000:
        return str(int(n))
    tier = min(len(SUFFIXES), int(math.log10(n) // 3))
    scaled = math.floor(n / 10 ** (tier * 3) * 10) / 10
    return f"{scaled:.1f}".removesuffix(".0").replace(".", ",") + " " + SUFFIXES[tier - 1]


def pct(values, q):
    values = sorted(values)
    return values[min(len(values) - 1, int(q * len(values)))]


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    players = int(sys.argv[1]) if len(sys.argv) > 1 else 10_000
    seed = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    with Pool(max(1, (os.cpu_count() or 2) - 1)) as pool:
        results = pool.map(simulate, range(seed * 1_000_000, seed * 1_000_000 + players), chunksize=50)

    print(f"Joueurs simulés : {players}, horizon {HORIZON_H} h de jeu actif. Surcharges : {OVERRIDES or 'aucune'}.\n")
    print("| Dé | Chance | Prix | Atteint par | Temps médian | P10 | P90 | Attente médiane depuis le dé précédent |")
    print("|---|---|---|---|---|---|---|---|")
    for k, (did, luck, price) in enumerate(DICE):
        times = [r["die_times"][k] for r in results if r["die_times"][k] is not None]
        share = len(times) / players
        if not times:
            print(f"| {did} | x{luck:g} | {fmt_big(price)} | 0 % | — | — | — | — |")
            continue
        med = statistics.median(times)
        # Écart par joueur (dé k - dé k-1), médiane.
        steps = [r["die_times"][k] - r["die_times"][k - 1] for r in results
                 if k > 0 and r["die_times"][k] is not None and r["die_times"][k - 1] is not None]
        step = statistics.median(steps) if steps else 0.0
        flag = " ⚠" if step > GAP_H * 3600 else ""
        print(f"| {did} | x{luck:g} | {fmt_big(price)} | {share:.0%} | {fmt_h(med)} | {fmt_h(pct(times, 0.1))} | "
              f"{fmt_h(pct(times, 0.9))} | {fmt_h(step)}{flag} |")

    print("\n| Rebirth | Atteint par | Temps médian |")
    print("|---|---|---|")
    for n in range(1, 16):
        times = [r["rebirth_times"][n - 1] for r in results if len(r["rebirth_times"]) >= n]
        if not times:
            break
        print(f"| {n} | {len(times) / players:.0%} | {fmt_h(statistics.median(times))} |")

    print("\n| Pendant l'attente du dé suivant (dé possédé) | Joueurs ayant un trou > 2 h | Durée médiane du trou |")
    print("|---|---|---|")
    for k in range(len(DICE)):
        durations = [d for r in results for (_, d, die) in r["gaps"] if die == k]
        who = sum(1 for r in results if any(die == k for (_, _, die) in r["gaps"]))
        if who:
            print(f"| {DICE[k][0]} | {who / players:.1%} | {fmt_h(statistics.median(durations))} |")

    ends = [r["end"] for r in results]
    print(f"\nFin de simulation (dernier dé ou horizon) : médiane {fmt_h(statistics.median(ends))}, "
          f"espèces trouvées médiane {statistics.median(r['species'] for r in results):.0f} / 28.")


if __name__ == "__main__":
    main()
