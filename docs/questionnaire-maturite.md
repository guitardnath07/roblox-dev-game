# Questionnaire de maturité — réponses conseillées pour DINO DICE

Où : Creator Dashboard → ton jeu → Publish settings (ou Audience) → **Content rating / Questionnaire de maturité**.
À refaire à chaque ajout d'un système monétisé ou d'échange. Des réponses inexactes peuvent valoir une modération :
réponds selon ce que le jeu fait **vraiment** au moment où tu remplis.

| Question | Réponse conseillée | Pourquoi |
|---|---|---|
| Violence | Légère / fantastique et cartoon | Combats automatiques de dinos au Volcan, sans sang ni gore. |
| Sang, gore | Non | — |
| Contenu effrayant | Non (ou très léger) | Style cartoon. |
| Grossièretés | Non | Textes du jeu sans grossièreté ; le chat passe par le filtre Roblox. |
| Contenu romantique ou sexuel | Non | — |
| Drogues, alcool, tabac | Non | Les « potions » sont magiques, pas de l'alcool. |
| Jeux d'argent (gambling) jouables ou représentés | **Non** | Pas de casino, pas de mise de Robux, pas de « Jackpot » payant. Les dés sont un tirage d'objets, pas un pari. |
| **Objets aléatoires payants** (paid random items) | **Oui** | Ambre et Fossiles (achetables en Robux) servent aux relances de Grade et d'Instinct ; les passes et potions de chance modifient les probabilités. |
| …le jeu utilise-t-il `ArePaidRandomItemsRestricted` ? | **Oui** | `PolicyService.luau` bloque ces achats et désactive les boosts de chance pour les joueurs concernés. |
| **Échange d'objets payants** | **Oui** | Les joueurs échangent des dinos, parfois relancés avec de l'Ambre ou des Fossiles achetés. |
| …le jeu utilise-t-il `IsPaidItemTradingAllowed` ? | **Oui** (dès que l'échange, Prompt 11, est en ligne) | L'échange est refusé si l'un des deux joueurs n'y a pas droit, ou si la vérification a échoué. |
| Chat vocal / texte libre | Selon tes réglages | Rien de spécial dans le jeu. |

Avant de cocher « Oui » aux deux questions d'API, vérifie en jeu que le blocage marche. Le QA (Prompt 18) le teste.
