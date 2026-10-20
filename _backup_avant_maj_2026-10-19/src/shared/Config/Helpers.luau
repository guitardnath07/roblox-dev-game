--!strict
-- Outils communs aux tables de config (aucune valeur d'équilibrage ici).

local Helpers = {}

-- Toutes les chances des tables de tirage sont des entiers sur 1 000 000.
Helpers.PER_MILLION = 1_000_000

-- Gèle chaque ligne puis la liste.
function Helpers.freezeList<T>(list: { T }): { T }
	for _, entry in list do
		table.freeze(entry :: any)
	end
	return table.freeze(list)
end

-- Fixe `perMillion` de la ligne `remainderId` pour que la table fasse exactement 1 000 000, puis gèle tout.
-- Erreur au chargement si la ligne manque ou si les autres lignes dépassent déjà 1 000 000.
function Helpers.withRemainder<T>(list: { T }, remainderId: string): { T }
	local total = 0
	local remainder: any = nil
	for _, entry in list do
		local row = entry :: any
		if row.id == remainderId then
			remainder = row
		else
			total += row.perMillion
		end
	end
	assert(remainder ~= nil, `ligne de reste introuvable : {remainderId}`)
	assert(total <= Helpers.PER_MILLION, `chances > 1 000 000 ({total})`)
	remainder.perMillion = Helpers.PER_MILLION - total
	return Helpers.freezeList(list)
end

return table.freeze(Helpers)
