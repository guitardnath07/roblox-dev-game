-- Généré par blender/scripts/export_luau.py : ne pas éditer à la main.
-- Format v2 « dd64 » : par os animé, une chaîne de 7 valeurs par image (w=2, signé) :
--   x, y, z (x0.01 stud) puis qx, qy, qz, qw (x1/2047) -> CFrame.new(x, y, z, qx, qy, qz, qw) POSÉE,
--   espace MODÈLE. Os absent d'un clip = pose de repos. Boucles sans doublon de la 1re image.
-- Décodage (Luau) :
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
--   end
return {
	version = 2,
	encoding = "dd64",
	fps = 15, -- par défaut ; chaque clip précise le sien
	clips = {
		Idle = {
			loop = true,
			fps = 10,
			frames = 40,
			bones = {
				Hips = [[
					gAiFguAFfdgFiCgAiHguAFfhgViCgAiIguAGfogjiCgAiIguAGfyguiCgAiHguAGf9g0iCgAiFguAGgIg1iCgAiHguAGgTgxiDgAiIguAGgbgoiDgAiIguAG
					ghgbiDgAiHguAGgkgLiDgAiFguAFgjf7iCgAiHguAFgffriCgAiIguAGgYfdiCgAiIguAGgOfSiCgAiHguAGgDfMiCgAiFguAGf4fLiCgAiHguAGftfPiDgA
					iIguAGflfYiDgAiIguAGfffliDgAiHguAGfcf1iDgAiFguAFfdgFiCgAiHguAFfhgViCgAiIguAGfogjiCgAiIguAGfyguiCgAiHguAGf9g0iCgAiFguAGgI
					g1iCgAiHguAGgTgxiDgAiIguAGgbgoiDgAiIguAGghgbiDgAiHguAGgkgLiDgAiFguAFgjf7iCgAiHguAFgffriCgAiIguAGgYfdiCgAiIguAGgOfSiCgAiH
					guAGgDfMiCgAiFguAGf4fLiCgAiHguAGftfPiDgAiIguAGflfYiDgAiIguAGfffliDgAiHguAGfcf1iD]],
				Spine1 = [[
					gAiIgWAFfdgFiCf/iKgWAGfggNiHf/iLgWAGfmgUiLf/iLgWAGfvgZiOf/iKgWAGf5gbiQf/iIgWAGgFgaiRf/iKgWAGgPgXiQf/iLgWAGgYgSiOf/iLgWAG
					gfgLiLgAiKgWAGgjgDiHgAiIgWAFgjf7iCgBiKgWAFggfzh+gBiLgWAFgafsh6gBiLgWAFgSfnh3gBiKgWAFgIflh1gBiIgWAEf9flh0gBiKgWAFfyfoh1gB
					iLgWAFfofuh3gBiLgWAFfhf1h6gAiKgWAFfdf9h+gAiIgWAFfdgFiCf/iKgWAGfggNiHf/iLgWAGfmgUiLf/iLgWAGfvgZiOf/iKgWAGf5gbiQf/iIgWAGgF
					gaiRf/iKgWAGgPgXiQf/iLgWAGgYgSiOf/iLgWAGgfgLiLgAiKgWAGgjgDiHgAiIgWAFgjf7iCgBiKgWAFggfzh+gBiLgWAFgafsh6gBiLgWAFgSfnh3gBiK
					gWAFgIflh1gBiIgWAEf9flh0gBiKgWAFfyfoh1gBiLgWAFfofuh3gBiLgWAFfhf1h6gAiKgWAFfdf9h+]],
				Spine2 = [[
					gAiLf+/4gkgAirf/iNf+/4gigAiif/iOf+/5gdgAiaf+iOf+/6gUgAiUf+iNf//6gKgAiQf+iMf//6f/gAiOf+iNf+/6f0gAiQf/iOf+/6fqgAiUf/iOf+/5
					fjgAiagAiNf+/4fegAiigAiLf+/4fcgAirgBiNf+/3fegAi0gBiOf+/2fjgAi8gCiNf+/2fqgAjCgCiNf+/1f0gAjGgCiLf+/1f/gAjHgCiNf+/1gKgAjGgB
					iOf+/2gUgAjCgBiOf+/2gdgAi8gAiNf+/3gigAi0gAiLf+/4gkgAirf/iNf+/4gigAiif/iOf+/5gdgAiaf+iOf+/6gUgAiUf+iNf//6gKgAiQf+iMf//6f/
					gAiOf+iNf+/6f0gAiQf/iOf+/6fqgAiUf/iOf+/5fjgAiagAiNf+/4fegAiigAiLf+/4fcgAirgBiNf+/3fegAi0gBiOf+/2fjgAi8gCiNf+/2fqgAjCgCiN
					f+/1f0gAjGgCiLf+/1f/gAjHgCiNf+/1gKgAjGgBiOf+/2gUgAjCgBiOf+/2gdgAi8gAiNf+/3gigAi0]],
				Spine3 = [[
					gAiIfp/4gkgAirf/iKfp/5gigIidf/iLfp/6gcgPiRf+iLfp/6gUgViIf+iKfp/7gKgZiCf+iJfp/7f+gbiAf+iKfp/7f0gaiCf/iLfp/6fqgWiIf/iLfp/6
					fjgQiSgAiKfp/5fegJiegAiIfp/4fcgAirgBiJfp/2fef4i4gBiKfp/1fifwjEgCiJfp/0fqfqjNgCiIfp/0fzfmjTgCiHfp/0f+fljVgCiIfp/0gJfnjUgB
					iJfp/0gUfrjOgBiKfp/1gcfxjEgAiJfp/2gif4i4gAiIfp/4gkgAirf/iKfp/5gigIidf/iLfp/6gcgPiRf+iLfp/6gUgViIf+iKfp/7gKgZiCf+iJfp/7f+
					gbiAf+iKfp/7f0gaiCf/iLfp/6fqgWiIf/iLfp/6fjgQiSgAiKfp/5fegJiegAiIfp/4fcgAirgBiJfp/2fef4i4gBiKfp/1fifwjEgCiJfp/0fqfqjNgCiI
					fp/0fzfmjTgCiHfp/0f+fljVgCiIfp/0gJfnjUgBiJfp/0gUfrjOgBiKfp/1gcfxjEgAiJfp/2gif4i4]],
				Neck1 = [[
					gAiEfUAufegKmqf/iGfUAwffgNmxf/iIfUAxfkgPm2f/iIfUAyfsgRm7f/iHfUAyf3gUm+f/iGfUAzgCgYm/f/iHfUAygOgdm+f/iIfUAygZgjm7f/iIfUAx
					gjgrm3gAiGfUAxgqgzmzgAiEfUAygug8m2gBiFfUA2guhDnIgBiGfUA5gshJnUgBiFfUA2gmhNnFgBiEfUA0gehNm/gBiCfUA2gShLnKgBiEfUA0gGhEm/gB
					iFfUAuf5g6mngBiGfUAsfugtmggAiFfUAtfkgdmkgAiEfUAufegKmqf/iGfUAwfbf3mxf/iIfUAxfdfkm3f/iIfUAyfhfRm8f/iHfUAzfpfBm+f/iGfUA0fy
					e0nAf/iHfUA2f7ernIf/iIfUA7gFelndf/iIfUA/gNeknqgAiGfUA7gTeonagAiEfUA4gXeunRgBiFfUA5gYe3nXgBiGfUA1gWfDnGgBiFfUAugRfPmngBiE
					fUAqgJfcmYgBiCfUAqgAfnmVgBiEfUAqf3fymWgBiFfUAqfuf6mZgBiGfUArfmgBmegAiFfUAtfggHmk]],
				Neck2 = [[
					f/iUewCnfhgRsof/iWewCnflgesnf+iYewCnftgqsnf+iZexCnf4g0snf+iYexCogFg+snf+iXexCogThIsnf+iYexCpgihSsnf+iZexCqgvhcsof+iYexCr
					g7hmsof+iWewCthEhvsrf+iUexC2hKh3s9f/iWexDLhKh8tqf/iXexDbhIiAuLf/iWexDRhDiAt4f/iVexDOg6h9tzf/iTexDYgth2uJf/iVexDMgehqtyf/
					iVexC1gNhatCf/iVewCqf8hFsrf/iVewCoftgssnf/iUewCnfhgRsof/iWewCofYfzsogAiYewCofTfVsogAiZexCpfRe4sogBiYexCqfTeesngBiXexCsfY
					eHspgCiYexC0fed1s6gDiaexDKfldotmgDiaeyDafsdhuHgDiYexDRfydht0gDiVexDOf2dltvgEiXexDYf6dvuGgDiWexDNf6d9txgDiVexC2f3ePtBgDiT
					ewCrf0ejsrgCiRewCofve3sngCiTewCofqfLsogBiUewCoflffsogAiVewCnfhfxsogAiVewCnffgCso]],
				Neck3 = [[
					f+iseaDUfhgTuJf9iueaDSfpgquDf9iveaDPfzhAt9f8iweaDOgAhUt4f8iveaDNgPhnt1f8iueaDOggh4t1f8iweaDQgwiJt2f8iweaDTg/iYt5f8iweaDX
					hMilt+f8iueaDehWiwuHf8itebDvhci5unf8ivedEWhci8vvf8ixeeE1hZi8wjf8ivedEmhUi5wMf8iuedEjhKixwIf8iteeE0g8ikwpf8iuedEegriRwHf8
					itebD0gYh5u/f9iteaDfgEhbuaf9iseaDYfyg4uPf+iseaDUfhgTuJf/iueaDSfVfquEgAiweaDRfNfCt/gCiweaDQfIebt6gDiweaDRfHd3t2gEiuebDUfJ
					dXt4gGiwebDjfNc+uRgGizedEIfTcrvVgHizeeEmfZcgwHgIixedEafeccvxgIivedEZficgvwgIiweeEufncqwXgHiwedEdfoc7v9gGitebD3fmdRu9gFir
					eaDlfkdrufgEipeaDhfieGubgDireaDgffejubgCiseaDdfdfBuZgAiteaDbfcfduVf/iseaDYfef5uQ]],
				Head = [[
					f9jWd5/7hfgThSf7jYd5/6h0f1hUf5jZd5/5iDfWhSf4jad5/4iMe3hMf4jZd5/2iQeZhCf3jYd5/1iQd8g3f3jZd5/ziMdggqf2jad6/yiGdGgdf2jad6/w
					h9cwgQf2jZd7/vh0cdgAf2jYd9/uhqcSfOf2jdeC/ohgcRdYf2jgeG/ghVcTcHf2jeeE/mhLcSc9f2jdeD/qhBcbdUf2jdeG/og3cucmf3jceD/xgsdFduf3
					jZd9/5gfdlf3f5jYd7/7gQeOg9f6jXd6/8f+e7hPf9jWd5/9fofphTf/jYd5/9fQgZhTgCjad5/7e3hHhPgFjad5/4edhyhHgIjZd5/1eFiZg9gLjYd6/xdv
					i5grgNjbd8/udejRf0gPjgeB/ndUjfd1gQjieF/ddOjocXgRjfeD/gdMjwdAgRjceD/hdQjwdIgQjfeF/ddbjncOgPjeeD/ldrjddKgOjZd+/weDjPfMgMjW
					d7/0egi7gPgJjUd7/3fAijgkgGjWd6/6fiiIgwgEjXd6/7gFhsg8gBjXd6/8gmhPhFf/jXd6/8hFgyhN]],
				Jaw = [[
					gCiidn/8hfgSg8gAikdm/7h0fzg9f/ildm/6iCfUg7f+imdm/4iLe2g1f9ildl/3iPeXgsf7ikdl/1iOd6ggf6imdk/0iKdegTf5indk/yiEdFgGf4indk/x
					h7cuf6f2imdj/vhyccfsf1imdj/uhpcSfGf0ivdj/qhjcSdyfzi0dj/mhbcVc4fziwdk/qhPcUdhfziudk/shFccd0fziwdl/sg8cvdXf0itdl/zgvdGePf1
					indm/5gfdlf0f3ijdn/7gPeOgpf5iidn/9f9e7g4f7ihdn/+fofqg9f9ikdm/9fRgZg8gAildm/8e4hIg4gDimdm/5eehzgxgFildl/1eGiagngIikdl/xdx
					i7gXgKipdk/udfjSfsgNixdj/odRjdeOgOi2dj/idJjkdJgPixdj/jdHjtdkgPiudj/kdMjtdpgPizdj/idVjjc/gOiwdj/odojadrgMindk/weEjPfKgLij
					dl/0eii8f8gJigdl/3fCikgOgIiidm/6fkiJgagGijdm/8gGhsglgFijdn/9gnhPgvgDijdn/9hFgxg3]],
				["UpperLegF.L"] = [[
					e7hQfau0e7fj8Ve7hSfZu3e3fv8Te6hUfYu8e0f88Qe5hVfXu6eygG8Re5hVfWuvewgO8Xe4hUfWueewgS8ge4hWfWvKeygW8Je4hYfXvve2gX71e4hYfXwB
					e6gT7qe4hXfZwBe9gM7re4hVfav3fAgC7we5hWfbwgfFf67Ye5hWfcw7fHfy7Ie6hWfdxBfJfo7Ee6hUfew0fJff7Me7hRfewafIfX7ce7hSfewifGfV7Xe8
					hTfdwdfEfV7ae8hSfdwGfBfY7ne7hRfbvhe+fc79e7hQfau0e7fj8Ve7hSfZu3e3fv8Te6hUfYu8e0f88Qe5hVfXu6eygG8Re5hVfWuvewgO8Xe4hUfWueew
					gS8ge4hWfWvKeygW8Je4hYfXvve2gX71e4hYfXwBe6gT7qe4hXfZwBe9gM7re4hVfav3fAgC7we5hWfbwgfFf67Ye5hWfcw7fHfy7Ie6hWfdxBfJfo7Ee6hU
					few0fJff7Me7hRfewafIfX7ce7hSfewifGfV7Xe8hTfdwdfEfV7ae8hSfdwGfBfY7ne7hRfbvhe+fc79]],
				["LowerLegF.L"] = [[
					e5gzfu+pfefypLe4g1ft+Rfof/qXe4g3fr96fzgOrXe3g4fr9qf+gdr+e2g4fq9lgJgssJe2g4fr9qgVg4r9e2g5fp9Tgag9sye2g6fp9Hgcg9tOe2g6fp9L
					geg6tFe2g5fq9fgfg1sYe2g3fs97gdgtrSe3g3fr95gWgfrYe3g3fs99gPgRrOe4g2fs+KgGgDqqe4g0fu+ef7f4pue4gzfv+yfvfvoqe5gzfu+rfoflpDe5
					g0fu+lfhfhpXe5g0fu+jfdfhpde5g0fu+lfcfnpVe5gzfu+pfefypLe4g1ft+Rfof/qXe4g3fr96fzgOrXe3g4fr9qf+gdr+e2g4fq9lgJgssJe2g4fr9qgV
					g4r9e2g5fp9Tgag9sye2g6fp9Hgcg9tOe2g6fp9Lgeg6tFe2g5fq9fgfg1sYe2g3fs97gdgtrSe3g3fr95gWgfrYe3g3fs99gPgRrOe4g2fs+KgGgDqqe4g0
					fu+ef7f4pue4gzfv+yfvfvoqe5gzfu+rfoflpDe5g0fu+lfhfhpXe5g0fu+jfdfhpde5g0fu+lfcfnpV]],
				["FootF.L"] = [[
					e4gifU/dfcgHl0e4gifU/dfogEl0e4gifU/df1gCl0e4gifU/dgDf/l0e4gifU/dgRf9l0e4gifU/dgef6l0e4gifU/dgkf5l0e4gifU/dgmf5l0e4gifU/d
					gof5l0e4gifU/dgof5l0e4gifU/dglf5l0e4gifU/dgbf7l0e4gifU/dgRf9l0e4gifU/dgGf/l0e4gifU/df6gBl0e4gifU/dfsgEl0e4gifU/dfjgFl0e4
					gifU/dfcgHl0e4gifU/dfYgHl0e4gifU/dfXgIl0e4gifU/dfcgHl0e4gifU/dfogEl0e4gifU/df1gCl0e4gifU/dgDf/l0e4gifU/dgRf9l0e4gifU/dge
					f6l0e4gifU/dgkf5l0e4gifU/dgmf5l0e4gifU/dgof5l0e4gifU/dgof5l0e4gifU/dglf5l0e4gifU/dgbf7l0e4gifU/dgRf9l0e4gifU/dgGf/l0e4gi
					fU/df6gBl0e4gifU/dfsgEl0e4gifU/dfjgFl0e4gifU/dfcgHl0e4gifU/dfYgHl0e4gifU/dfXgIl0]],
				["UpperLegF.R"] = [[
					hIhVfav3hAf+7whHhXfawWg7gG7ehHhYfawog3gP7UhGhYfawkg0gY7WhGhWfawLgzgi7lhFhUfavngzgq76hFhVfav0g0gr7yhEhVfav3g3gq7whEhUfavr
					g7gn73hFhSfavRhAgj8FhFhQfau0hFgd8VhFhRfavFhLgS8LhGhSfavThPgH8EhHhSfbvWhSf98ChHhSfbvPhTf28GhIhRfbvDhTfx8NhIhTfavlhRfs76hI
					hVfawBhMfq7qhIhWfawOhIft7jhIhWfawJhEf07mhIhVfav3hAf+7whHhXfawWg7gG7ehHhYfawog3gP7UhGhYfawkg0gY7WhGhWfawLgzgi7lhFhUfavngz
					gq76hFhVfav0g0gr7yhEhVfav3g3gq7whEhUfavrg7gn73hFhSfavRhAgj8FhFhQfau0hFgd8VhFhRfavFhLgS8LhGhSfavThPgH8EhHhSfbvWhSf98ChHhS
					fbvPhTf28GhIhRfbvDhTfx8NhIhTfavlhRfs76hIhVfawBhMfq7qhIhWfawOhIft7jhIhWfawJhEf07m]],
				["LowerLegF.R"] = [[
					hKg3fs97fjfTrShJg4fq9mfqfjsIhJg5fq9afyf0slhIg5fq9cf6gEsghIg4fr9sgDgRr5hHg2fs+DgOgbq+hHg3fs98gWgjrPhHg3fs98gbgmrPhHg2fs+F
					gggjq2hHg1ft+WgigbqGhHgzfu+pgigOpLhIg0fu+hgagApkhIg1ft+cgSfxp2hJg1ft+bgHfip4hKg0fu+ff8fTpphKg0fu+lfwfGpUhKg1ft+RfpfBqUhK
					g3fs99fkfArJhKg3fr9yfifDrmhKg3fr9yfhfJrnhKg3fs97fjfTrShJg4fq9mfqfjsIhJg5fq9afyf0slhIg5fq9cf6gEsghIg4fr9sgDgRr5hHg2fs+DgO
					gbq+hHg3fs98gWgjrPhHg3fs98gbgmrPhHg2fs+Fgggjq2hHg1ft+WgigbqGhHgzfu+pgigOpLhIg0fu+hgagApkhIg1ft+cgSfxp2hJg1ft+bgHfip4hKg0
					fu+ff8fTpphKg0fu+lfwfGpUhKg1ft+RfpfBqUhKg3fs99fkfArJhKg3fr9yfifDrmhKg3fr9yfhfJrn]],
				["FootF.R"] = [[
					hIgifU/dfbgHl0hIgifU/dflgFl0hIgifU/dfwgDl0hIgifU/df7gBl0hIgifU/dgGf/l0hIgifU/dgTf9l0hIgifU/dgbf7l0hIgifU/dgif6l0hIgifU/d
					gmf5l0hIgifU/dgnf5l0hIgifU/dgkf5l0hIgifU/dgaf7l0hIgifU/dgPf9l0hIgifU/dgCgAl0hIgifU/df0gCl0hIgifU/dfmgFl0hIgifU/dfegGl0hI
					gifU/dfZgHl0hIgifU/dfXgHl0hIgifU/dfYgHl0hIgifU/dfbgHl0hIgifU/dflgFl0hIgifU/dfwgDl0hIgifU/df7gBl0hIgifU/dgGf/l0hIgifU/dgT
					f9l0hIgifU/dgbf7l0hIgifU/dgif6l0hIgifU/dgmf5l0hIgifU/dgnf5l0hIgifU/dgkf5l0hIgifU/dgaf7l0hIgifU/dgPf9l0hIgifU/dgCgAl0hIgi
					fU/df0gCl0hIgifU/dfmgFl0hIgifU/dfegGl0hIgifU/dfZgHl0hIgifU/dfXgHl0hIgifU/dfYgHl0]],
				Tail1 = [[
					gAiBhLgkgEgk/+gBiDhLgVjdgM/zgBiEhLgLkOgD/tgBiEhLgFh6gK/7gBiDhLgCehgT/9gBiBhLgAc9gR/2gBiDhLgBeff9/9gBiEhLgIh2fg/7gBiEhLgS
					kJfK/tgAiDhLgcjWfJ/zgAiBhLgkf8fc/+f/iDhLgrcjf2/zf/iEhLg0bygC/sf/iEhLg/eGf5/6f/iDhLhGhefp/8f/iBhLhHjDfo/0f/iDhLhFhhf//8f/
					iEhLhCeLgj/6f/iEhLg8b5g7/sgAiDhLgycrg6/ygAiBhLgkgEgk/+gBiDhLgVjdgM/zgBiEhLgLkOgD/tgBiEhLgFh6gK/7gBiDhLgCehgT/9gBiBhLgAc9
					gR/2gBiDhLgBeff9/9gBiEhLgIh2fg/7gBiEhLgSkJfK/tgAiDhLgcjWfJ/zgAiBhLgkf8fc/+f/iDhLgrcjf2/zf/iEhLg0bygC/sf/iEhLg/eGf5/6f/iD
					hLhGhefp/8f/iBhLhHjDfo/0f/iDhLhFhhf//8f/iEhLhCeLgj/6f/iEhLg8b5g7/sgAiDhLgycrg6/y]],
				Tail2 = [[
					gAiAhkfneog0/8gGiChjfJlff8/ggIiDhjeyn+fi+9gEiEhjelkVfz/qf/iDhjeadjgZ/2f9iBhjePZagu/Pf/iDhjeLbRgb/lgEiDhjeRhofq/5gHiDhjef
					nGe7/IgFiChjevnEev/JgAiAhke9hZfO/7f6iChjfKahgB/gf4iChjfcYAgf+9f8iChjf1bqgP/sgBiBhjgIicfi/5gDh/hjgPmmfH/SgBiBhjgSkwfe/of8
					iChjgSeZge/8f5iChjgLY8hV/Lf7iBhjf+Y+hd/LgAiAhkfneog0/8gGiChjfJlff8/ggIiDhjeyn+fi+9gEiEhjelkVfz/qf/iDhjeadjgZ/2f9iBhjePZa
					gu/Pf/iDhjeLbRgb/lgEiDhjeRhofq/5gHiDhjefnGe7/IgFiChjevnEev/JgAiAhke9hZfO/7f6iChjfKahgB/gf4iChjfcYAgf+9f8iChjf1bqgP/sgBiB
					hjgIicfi/5gDh/hjgPmmfH/SgBiBhjgSkwfe/of8iChjgSeZge/8f5iChjgLY8hV/Lf7iBhjf+Y+hd/L]],
				Tail3 = [[
					f+iBh8eVcAhV/qgOiEh6dvmLgB/TgTiFh4dMrRfG9zgLiGh7c3nnfO+6f7iFh8ckeBgJ/vfziEh6cOWsg++Wf4iFh7b/XmhA+lgGiGh8b+gCgK/vgSiFh5cK
					o8fD+dgQiDh5cbqyee93gCiCh8cokDey/hfyiDh6c3Z1fx/OftiDh4dPUsgn9yf1iCh7dxYWgm++gFiBh8eRh/fx/4gNh/h6ejpVe8+igIiAh7euode++0f6
					iCh8e4gBgE/+fuiBh5e4XHha+rfwiBh5etVSh9+Df+iBh8eVcAhV/qgOiEh6dvmLgB/TgTiFh4dMrRfG9zgLiGh7c3nnfO+6f7iFh8ckeBgJ/vfziEh6cOWs
					g++Wf4iFh7b/XmhA+lgGiGh8b+gCgK/vgSiFh5cKo8fD+dgQiDh5cbqyee93gCiCh8cokDey/hfyiDh6c3Z1fx/OftiDh4dPUsgn9yf1iCh7dxYWgm++gFiB
					h8eRh/fx/4gNh/h6ejpVe8+igIiAh7euode++0f6iCh8e4gBgE/+fuiBh5e4XHha+rfwiBh5etVSh9+D]],
				Tail4 = [[
					f4iDiUYUYXg2+FgYiHiRXrlWhT+ZgkiJiKXetqg/7ngWiKiQW6rRgO8hf4iKiUWOf5fe+cfliJiNWEVJfQ8ZfriLiPVwT/fx70gGiMiUVNdMgk9+gfiKiNVf
					pZhA8tggiIiMV9t+gi69gIiHiTVtnrfW9SfoiIiRVyaweS9zfciHiKWkSaeR7UfqiGiRW8UufL8hgIiDiUXOgHgW+wgbiAiOX/q7g58+gViCiQYWsGgj8mf6
					iDiVYSi1f5+6fhiCiOYtWjfn9rfgiCiMY9R+gD73f4iDiUYUYXg2+FgYiHiRXrlWhT+ZgkiJiKXetqg/7ngWiKiQW6rRgO8hf4iKiUWOf5fe+cfliJiNWEVJ
					fQ8ZfriLiPVwT/fx70gGiMiUVNdMgk9+gfiKiNVfpZhA8tggiIiMV9t+gi69gIiHiTVtnrfW9SfoiIiRVyaweS9zfciHiKWkSaeR7UfqiGiRW8UufL8hgIiD
					iUXOgHgW+wgbiAiOX/q7g58+gViCiQYWsGgj8mf6iDiVYSi1f5+6fhiCiOYtWjfn9rfgiCiMY9R+gD73]],
				Tail5 = [[
					ftiOinRvUreq6QgfiUilQni0ia7zg2iViXRUuUkP4LgmiXifQ7uXi74Hf4iZioPYjBfg7KfWiXicPkVacr5FfbiZicPwRbc73LgCicimOYZjf455gsiZicOg
					n5jX5XgyiViWPtvjkG2VgTiVikO4rThb4gfiiXijONdedA6SfLiUiWPtSGao3JfaiSifQDR7b/3jgIiQipPWdBgH7JgqiMieQkqgjz5sgliNifRiugj+4Qf+
					iPiqQxmWg/7YfUiNigRVX4dU7HfNiLiZSqQOcY4JftiOinRvUreq6QgfiUilQni0ia7zg2iViXRUuUkP4LgmiXifQ7uXi74Hf4iZioPYjBfg7KfWiXicPkVa
					cr5FfbiZicPwRbc73LgCicimOYZjf455gsiZicOgn5jX5XgyiViWPtvjkG2VgTiVikO4rThb4gfiiXijONdedA6SfLiUiWPtSGao3JfaiSifQDR7b/3jgIiQ
					ipPWdBgH7JgqiMieQkqgjz5sgliNifRiugj+4Qf+iPiqQxmWg/7YfUiNigRVX4dU7HfNiLiZSqQOcY4J]],
				["UpperLegB.L"] = [[
					e9hYgy9AeMfutXe9hagz82eYfhtue9hbg08tejfXuBe8hcg18resfQuHe8hbg28weyfMt7e7hbg286e0fMtne7hdg18de6fWuje6hfg18Ee8fivUe6hfg073
					e5fvvqe6hegz77exf8vie6hdgy8JelgIvJe6hegx7vefgXv3e6hfgw7geXgjwQe6hegv7jeOgqwKe7hcgv71eGgsvpe7hagv8Pd/gpu5e8hbgv8Hd+glvHe8
					hbgv8IeAgcvGe9hbgw8UeDgPuxe9hagx8peHf/uIe9hYgy9AeMfutXe9hagz82eYfhtue9hbg08tejfXuBe8hcg18resfQuHe8hbg28weyfMt7e7hbg286e0
					fMtne7hdg18de6fWuje6hfg18Ee8fivUe6hfg073e5fvvqe6hegz77exf8vie6hdgy8JelgIvJe6hegx7vefgXv3e6hfgw7geXgjwQe6hegv7jeOgqwKe7hc
					gv71eGgsvpe7hagv8Pd/gpu5e8hbgv8Hd+glvHe8hbgv8IeAgcvGe9hbgw8UeDgPuxe9hagx8peHf/uI]],
				["LowerLegB.L"] = [[
					e6g8gau9fsfl8Re6g9gcv7f8fi7ve6g+gewugMfg7Re5g/gfxKgbfi6/e5g/gfxNgpfn69e4g+gew9gzfw7He4g/ggxvg0f26ne4hAghyOgyf+6Se4g/ghyM
					gsgI6Te4g/ggxmgigT6te5g+gewpgWgd7Ue5g+gew6gFgh7Ke5g+gew4f1gk7Le6g+gdwZflgk7de6g9gbvjfZgg78e7g8gaulfQgX8de7g8gau+fLgO8Qe7
					g8gbvQfLgE8Ge7g9gbvUfRf48Ee7g8gbvLfcfu8Ke6g8gau9fsfl8Re6g9gcv7f8fi7ve6g+gewugMfg7Re5g/gfxKgbfi6/e5g/gfxNgpfn69e4g+gew9gz
					fw7He4g/ggxvg0f26ne4hAghyOgyf+6Se4g/ghyMgsgI6Te4g/ggxmgigT6te5g+gewpgWgd7Ue5g+gew6gFgh7Ke5g+gew4f1gk7Le6g+gdwZflgk7de6g9
					gbvjfZgg78e7g8gaulfQgX8de7g8gau+fLgO8Qe7g8gbvQfLgE8Ge7g9gbvUfRf48Ee7g8gbvLfcfu8K]],
				["FootB.L"] = [[
					e6gigs/ZfggGmIe6gigs/ZfrgEmIe6gigs/Zf3gCmJe6gigs/ZgEf/mJe6gigs/ZgSf9mIe6gigs/Zgff6mIe6gigs/Zgjf5mIe6gigs/Zgmf5mIe6gigs/Z
					gnf4mIe6gigs/Zgmf5mIe6gigs/Zgif5mIe6gigs/ZgYf7mIe6gigs/ZgMf+mIe6gigs/ZgAgAmJe6gigs/Zf0gCmIe6gigs/ZfogFmIe6gigs/ZfegHmIe6
					gigs/ZfYgImIe6gigs/ZfWgImIe6gigs/ZfZgImIe6gigs/ZfggGmIe6gigs/ZfrgEmIe6gigs/Zf3gCmJe6gigs/ZgEf/mJe6gigs/ZgSf9mIe6gigs/Zgf
					f6mIe6gigs/Zgjf5mIe6gigs/Zgmf5mIe6gigs/Zgnf4mIe6gigs/Zgmf5mIe6gigs/Zgif5mIe6gigs/ZgYf7mIe6gigs/ZgMf+mIe6gigs/ZgAgAmJe6gi
					gs/Zf0gCmIe6gigs/ZfogFmIe6gigs/ZfegHmIe6gigs/ZfYgImIe6gigs/ZfWgImIe6gigs/ZfZgImI]],
				["UpperLegB.R"] = [[
					hGhdgy8Jhbf4vJhGhegx7vhhfpv3hGhfgw7ghpfdwQhGhegv7jhyfWwKhFhcgv71h6fUvphFhagv8PiBfXu5hEhbgv8HiCfbvHhEhbgv8IiAfkvGhDhbgw8U
					h9fxuxhDhagx8ph5gBuIhDhYgy9Ah0gStXhDhagz82hogftuhDhbg08thdgpuBhEhcg18rhUgwuHhEhbg28whOg0t7hFhbg286hMg0tnhFhdg18dhGgqujhG
					hfg18EhEgevUhGhfg073hHgRvqhGhegz77hPgEvihGhdgy8Jhbf4vJhGhegx7vhhfpv3hGhfgw7ghpfdwQhGhegv7jhyfWwKhFhcgv71h6fUvphFhagv8PiB
					fXu5hEhbgv8HiCfbvHhEhbgv8IiAfkvGhDhbgw8Uh9fxuxhDhagx8ph5gBuIhDhYgy9Ah0gStXhDhagz82hogftuhDhbg08thdgpuBhEhcg18rhUgwuHhEhb
					g28whOg0t7hFhbg286hMg0tnhFhdg18dhGgqujhGhfg18EhEgevUhGhfg073hHgRvqhGhegz77hPgEvi]],
				["LowerLegB.R"] = [[
					hHg+gewpfqfj7UhHg+gew6f7ff7KhHg+gew4gLfc7LhGg+gdwZgbfc7dhGg9gbvjgnfg78hFg8gaulgwfp8dhFg8gau+g1fy8QhFg8gbvQg1f88GhFg9gbvU
					gvgI8EhFg8gbvLgkgS8KhGg8gau9gUgb8RhGg9gcv7gEge7vhGg+gewuf0gg7RhHg/gfxKflge6/hHg/gfxNfXgZ69hIg+gew9fNgQ7HhIg/ggxvfMgK6nhI
					hAghyOfOgC6ShIg/ghyMfUf46ThIg/ggxmfeft6thHg+gewpfqfj7UhHg+gew6f7ff7KhHg+gew4gLfc7LhGg+gdwZgbfc7dhGg9gbvjgnfg78hFg8gaulgw
					fp8dhFg8gau+g1fy8QhFg8gbvQg1f88GhFg9gbvUgvgI8EhFg8gbvLgkgS8KhGg8gau9gUgb8RhGg9gcv7gEge7vhGg+gewuf0gg7RhHg/gfxKflge6/hHg/
					gfxNfXgZ69hIg+gew9fNgQ7HhIg/ggxvfMgK6nhIhAghyOfOgC6ShIg/ghyMfUf46ThIg/ggxmfeft6t]],
				["FootB.R"] = [[
					hGgigs/ZfegHmIhGgigs/ZfogFmIhGgigs/Zf0gCmIhGgigs/ZgAgAmJhGgigs/ZgMf+mIhGgigs/ZgYf7mIhGgigs/Zgif5mIhGgigs/Zgof4mIhGgigs/Z
					gqf4mIhGgigs/Zgnf4mIhGgigs/Zggf6mIhGgigs/ZgVf8mIhGgigs/ZgJf+mJhGgigs/Zf8gBmJhGgigs/ZfugDmIhGgigs/ZfhgGmIhGgigs/ZfdgHmIhG
					gigs/ZfagHmIhGgigs/ZfZgImIhGgigs/ZfagHmIhGgigs/ZfegHmIhGgigs/ZfogFmIhGgigs/Zf0gCmIhGgigs/ZgAgAmJhGgigs/ZgMf+mIhGgigs/ZgY
					f7mIhGgigs/Zgif5mIhGgigs/Zgof4mIhGgigs/Zgqf4mIhGgigs/Zgnf4mIhGgigs/Zggf6mIhGgigs/ZgVf8mIhGgigs/ZgJf+mJhGgigs/Zf8gBmJhGgi
					gs/ZfugDmIhGgigs/ZfhgGmIhGgigs/ZfdgHmIhGgigs/ZfagHmIhGgigs/ZfZgImIhGgigs/ZfagHmI]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAiEguANfLgGjbgAiFguANfRgejbgAiGguAOfcgyjagAiIguAOfshAjbgAiKguAOf+hHjbgAiKguAOgRhFjcgAiIguAOghg7jcgAiGguAOgugpjcgAiFguAO
					g1gTjcgAiEguANg1f6jbgAiFguANgvfijbgAiGguAOgkfOjagAiIguAOgUfAjbgAiKguAOgCe5jbgAiKguAOfve7jcgAiIguAOfffFjcgAiGguAOfSfXjcgA
					iFguAOfLftjc]],
				Spine1 = [[
					gAiJgXANflgDjbf/iKgXANfpgSjbf/iMgXANfvgfjbf+iOgXANf3gojbf+iPgXANgAgsjbf+iPgXANgJgrjcf/iOgXANgRgljcf/iMgXANgXgajcgAiKgXAN
					gbgMjcgAiJgXANgbf9jbgBiKgXANgXfujbgBiMgXANgRfhjbgCiOgXANgJfYjbgCiPgXANgAfUjbgCiPgXANf3fVjcgBiOgXANfvfbjcgBiMgXANfpfmjcgA
					iKgXANflf0jc]],
				Spine2 = [[
					gAiOf//9gAgAhSf/iPf//9gAf6hSf+iRf//9gAf1hSf9iTf//9gBfxhSf9iUf//9gBfuhSf9iUf//9gBfuhRf+iTf//9gBfxhRf/iRf//9gAf1hRf/iPf//9
					gAf6hRgAiOf//9gAgAhSgBiPf//9gAgGhSgCiRf//9gAgLhSgDiTf//9f/gPhSgDiUf//9f/gShSgDiUf//9f/gShRgCiTf//9f/gPhRgBiRf//9gAgLhRgB
					iPf//9gAgGhR]],
				Spine3 = [[
					gAiMfq/9flf/hSf/iNfq/9fngChSf+iPfq/9frgFhSf9iRfq/9fygHhSf9iSfq/9f7gJhSf9iSfq/9gEgJhRf+iRfq/9gNgIhRf+iPfq/9gUgHhRf/iNfq/9
					gZgEhRgAiMfq/9gbgBhSgBiNfq/9gZf+hSgCiPfq/9gVf7hSgDiRfq/9gOf5hSgDiSfq/9gFf3hSgDiSfq/9f8f3hRgCiRfq/9fzf4hRgCiPfq/9fsf5hRgB
					iNfq/9fnf8hR]],
				Neck1 = [[
					gAiLfUAngaf7mJf/iLfUAlgWfvl/f+iNfUAmgQfmmAf9iPfUAogHffmNf9iRfUAsf+fcmgf9iRfUAvf1femvf+iPfUAwftfkm0f/iNfUAufofumsf/iMfUAr
					flf5mbgAiLfUAnfmgFmJgBiLfUAlfqgRl/gCiNfUAmfwgamAgDiPfUAof5ghmNgDiRfUAsgCgkmggDiRfUAvgLgimvgCiPfUAwgTgcm0gBiNfUAugYgSmsgB
					iMfUArgbgHmb]],
				Neck2 = [[
					gAiZewBvgZf3qWf/iaewBogRfkqBf/icewBqgGfTqFf/ieewByf7fIqef+igexB/fxfErBf+ihexCKfpfHrdf/igexCNfjfRrmf/idexCHfgfhrXf/ibewB7
					fif0q3gAiZewBvfngJqWgBiaewBofvgcqBgBicewBqf6gtqFgBieewBygFg4qegCigexB/gPg8rBgCihexCKgXg5rdgBigexCNgdgvrmgBidexCHgggfrXgB
					ibewB7gegMq3]],
				Neck3 = [[
					gAiteWBqgZf4qHgAiteWBhgOfbppgAiveWBjgBfDpugAiyeXBwf1eyqTgAi1eYCDfperrIgAi2eZCTfheurygAi2eZCYfce7r/gAizeYCOfcfRrpgAiweXB8
					fffrq6gAiteWBqfngIqHgAiteWBhfyglppgAiveWBjf/g9pugAiyeXBwgLhOqTgAi1eYCDgXhVrIgAi2eZCTgfhSrygAi2eZCYgkhFr/gAizeYCOgkgvrpgA
					iweXB8ghgVq6]],
				Head = [[
					gBjNds/TgYgDmlgCjMdq/MgJgrnEgDjOdr/Qf5hPmrgEjTdt/dfphqlmgEjYdv/pfch2kUgDjbdy/vfThyjcgCjbdz/xfQhgjZgBjXdx/sfThFkMgAjSdu/g
					fcgjldf/jNds/Tfof9mlf+jMdq/Mf3fVnEf9jOdr/QgHexmrf8jTdt/dgXeWlmf8jYdv/pgkeKkUf9jbdy/vgteOjcf+jbdz/xgwegjZf/jXdx/sgte7kMgA
					jSdu/ggkfdld]],
				Jaw = [[
					gDiVdr/zgYgBjfgDiUdr/vgNgqj+gEiWdq/xgBhQjlgEibdo/2f0hsiegEihdn/6foh5hMgDikdm/7ffh2gUgBikdn/8fahlgRgAigdo/8fahJhEf+iadq/5
					ffgniVf9iVdr/zfof/jff9iUdr/vfzfWj+f8iWdq/xf/ewjlf8ibdo/2gMeUief8ihdn/6gYeHhMf9ikdm/7gheKgUf/ikdn/8gmebgRgAigdo/8gme3hEgC
					iadq/5ghfZiV]],
				["UpperLegF.L"] = [[
					e4hbfWoZfFf++2e3hbfWqSfBgM+Re2hdfWuXfDgX8ke2hefVyRfIgf6Pe2hffV1ofNgl3je3hefV2tfOgj2he4hdfV0+fIgW4Ie5hafVzPfBgG5ie6hYfWxu
					e8f16ne7hXfWwle4fl7Ve8hYfWv8e2fa7te9hafWv1e0fV7xe9hcfXwEezfV7oe9hefXwVe3fZ7ee8hffXwKe7fg7le7hefWvVfCfp8De6hdfWuHfKfz8se5
					hbfWqIfKf1+V]],
				["LowerLegF.L"] = [[
					e2hJf088g8gstke1hGfy+nhPhJpIe1hBfq/RhMhUmfe1g9fi/Eg6hLnfe2g8fY9zgig0rme3g7fV8lgTghuXe3g6fa9HgPgYtPe3g4ff9kgEgLsOe4g4fj9x
					fzf8rue5g4fm9pfhfssAe5g6fo9LfUfdtEe6g8fo8YfOfTuve6g+fo7SfQfNwqe6hAfn6HfXfMyce5hBfo5MfhfTzte5hBfp4pfvff0Ye4hBfs4UgBfw0ye3
					hGfy6rgdgNxq]],
				["FootF.L"] = [[
					e4gxfg/khDf1lGe4g1fY/lhdfxk6e4g0fO/khffxk8e4gvfG/jhJf0lMe4gnfB/fgrf4lme4gifC/dgZf7l0e4gifG/dgTf9l0e4gifJ/dgGf/l0e4gifM/d
					fzgCl0e4gifQ/dfegGl0e4gifT/cfPgJl0e4gifW/cfIgKl0e4gifa/cfJgKl0e4gifd/cfPgJl0e4gifg/dfagHl0e4gifk/dfqgEl0e4gifn/df+gAl0e4
					gqfm/hgef7ld]],
				["UpperLegF.R"] = [[
					hFhXfWwlhIgb7VhEhYfWv8hKgm7thDhafWv1hMgr7xhDhcfXwEhNgr7ohDhefXwVhJgn7ehEhffXwKhFgg7lhFhefWvVg+gX8DhGhdfWuHg2gN8shHhbfWqI
					g2gL+VhIhbfWoZg7gC+2hJhbfWqSg/f0+RhKhdfWuXg9fp8khKhefVyRg4fh6PhKhffV1ogzfb3jhJhefV2tgyfd2hhIhdfV0+g4fq4IhHhafVzPg/f65ihG
					hYfWxuhEgL6n]],
				["LowerLegF.R"] = [[
					hHg4fm9pgfgUsAhHg6fo9LgsgjtEhGg8fo8YgygtuvhGg+fo7SgwgzwqhGhAfn6Hgpg0ychHhBfo5MgfgtzthHhBfp4pgRgh0YhIhBfs4Uf/gQ0yhJhGfy6r
					fjfzxqhKhJf088fEfUtkhLhGfy+nexe3pIhLhBfq/Re0esmfhLg9fi/EfGe1nfhKg8fY9zfefMrmhJg7fV8lftffuXhJg6fa9HfxfotPhJg4ff9kf8f1sOhI
					g4fj9xgNgEru]],
				["FootF.R"] = [[
					hIgifQ/dgif6l0hIgifT/cgxf3l0hIgifW/cg4f2l0hIgifa/cg3f2l0hIgifd/cgxf3l0hIgifg/dgmf5l0hIgifk/dgWf8l0hIgifn/dgCgAl0hIgqfm/h
					figFldhIgxfg/ke9gLlGhIg1fY/lejgPk6hIg0fO/kehgPk8hIgvfG/je3gMlMhIgnfB/ffVgIlmhIgifC/dfngFl0hIgifG/dftgDl0hIgifJ/df6gBl0hI
					gifM/dgNf+l0]],
				Tail1 = [[
					gAh9hKjmg7gv/xgBh+hKjWgpgu/zgCiAhKjNgSgn/0gCiChKjRf5gc/0gCiDhKjffhgN/zgCiDhKjwfNf9/wgCiChKj+e+ft/ugBiAhKkAe4fg/tgAh+hKj3
					e6fW/ugAh9hKjmfFfR/xf/h+hKjWfXfS/zf+iAhKjNfufZ/0f+iChKjRgHfk/0f+iDhKjfgffz/zf+iDhKjwgzgD/wf+iChKj+hCgT/uf/iAhKkAhIgg/tgA
					h+hKj3hGgq/u]],
				Tail2 = [[
					gCh4hikKibgh/ngCh5hjjphogl/vgCh7hjjSgpgk/0gCh9hjjOflge/0gBh+hijgekgU/xgBh+hikAdugI/qgAh8hikedKf8/jf/h6hiksc7fx/ff/h4hikk
					dFfn/hf+h4hikKdlff/nf+h5hjjpeYfb/vf+h7hjjSfXfc/0f+h9hjjOgbfi/0f/h+hijghcfs/xf/h+hikAiSf4/qgAh8hikei2gE/jgBh6hiksjFgP/fgB
					h4hikki7gZ/h]],
				Tail3 = [[
					gGhyh6kTkTgR/agFh0h6jojOgX/ngDh2h7jAhwgb/zgBh4h7iugFgZ/3f/h5h6i6eagT/0f9h3h6jec7gL/pf8h1h6kKb0gE/cf6hzh5kpbMf9/Sf6hxh6ks
					bKf2/Rf6hyh6kTbtfv/af7h0h6jocyfp/nf9h2h7jAeQfl/zf/h4h7iuf7fn/3gBh5h6i6hmft/0gDh3h6jejFf1/pgEh1h6kKkMf8/cgGhzh5kpk0gD/SgG
					hxh6ksk2gK/R]],
				Tail4 = [[
					gMhriRfimGg//YgKhuiSe1lCg5/jgGhxiTeBjYgt/vgBh0iTdchTgb/3f9h0iTdafFgD/3f5hyiSd6c+fp/xf1hviReubOfT/mfzhsiQfdaDfF/afzhqiQfy
					Zle//Uf0hriRfiZ6fB/Yf2huiSe1a+fH/jf6hxiTeBcofT/vf/h0iTdcetfl/3gDh0iTdag7f9/3gHhyiSd6jCgX/xgLhviReukygt/mgNhsiQfdl9g7/agN
					hqiQfymbhB/U]],
				Tail5 = [[
					gVhsioZdnSik+WgRhwipY5mkiR+agLh1irYAlEhw+ggDh4irXOi8hC+mf7h4irW4gdgJ+qf0h1iqXLd8fN+qfuhxioX8bseW+nfqhtinY2Z8dt+ffphrinZc
					Y6da+YfrhsioZdYudc+WfvhwipY5Zcdv+af1h1irYAa8eQ+gf9h4irXOdEe++mgFh4irW4fjf3+qgMh1iqXLiEgz+qgShxioX8kUhq+ngWhtinY2mEiT+fgX
					hrinZcnGim+Y]],
				["UpperLegB.L"] = [[
					e+hVgu+ceJfcpne9hWgw+ReYfLqNe9hZgx91epfArce9hcgz9Le6e9tBe8hegz8efIfBuge7hfgz77fOfIvke6hfgz7mfNfTwJe6hegx7VfGfiwme5hdgw65
					e9f1xSe5hdgu6Je1gMyYe5hdgt5Ceugkz3e6hegr3meog51ie6hfgq3NedhF18e7hfgq5eeGhCzOe8hegq7wdyg1vue9hcgq9zdhghrWe9hZgr+8dfgHnte9
					hWgt/GdufunH]],
				["LowerLegB.L"] = [[
					e7hAgQzWfhfU5de6hAgTzBf8fR5te6hAgWzDgVfT5re5hAgazSgpfX5ge5hAgdzXg3fc5ce4hAggy7hBfl5xe4g/ggxxhHf06ke4g9ggwKhGgE7le4g8ghuh
					g9gT8fe4g6gitSgtge9Fe4g5gkswgYgk9Ve5g5gos9gAgn9Pe6g6gorsfsgq9xe6g8gfncffgk/Ge7g/gXlsfOgM/ee8hDgPnYe/fq/He8hHgLrwe9fR9ue8
					hGgLwFfMfO7o]],
				["FootB.L"] = [[
					e6gigY/YfOgKmIe6gigc/ZfhgGmIe6gigf/Zf2gCmIe6gigi/ZgIf+mJe6gigm/ZgWf8mIe6gigp/Zgkf5mIe6gigs/Ygxf3mIe6gigw/Yg5f1mIe6gigz/Y
					g7f0mIe6gig2/Yg1f2mIe6gig6/Zgpf4mIe6gig9/ZgYf7mIe6glg//bgKf+mAe6gug7/gf7gBlke6g0g0/jfegGlRe6g1gq/je8gLlMe6gygh/heugOlVe6
					grgb/de6gNls]],
				["UpperLegB.R"] = [[
					hHhdgu6JhLf0yYhHhdgt5ChSfcz3hGhegr3mhYfH1ihGhfgq3Nhje718hFhfgq5eh6e+zOhEhegq7wiOfLvuhDhcgq9zifffrWhDhZgr+8ihf5nthDhWgt/G
					iSgSnHhChVgu+ch3gkpnhDhWgw+Rhog1qNhDhZgx91hXhArchDhcgz9LhGhDtBhEhegz8eg4g/ughFhfgz77gyg4vkhGhfgz7mgzgtwJhGhegx7Vg6gewmhH
					hdgw65hDgLxS]],
				["LowerLegB.R"] = [[
					hIg6gitSfTfi9FhIg5gkswfofc9VhHg5gos9gAfZ9PhGg6gorsgUfW9xhGg8gfncghfc/GhFg/gXlsgyf0/ehEhDgPnYhBgW/HhEhHgLrwhDgv9uhEhGgLwF
					g0gy7ohFhAgQzWgfgs5dhGhAgTzBgEgv5thGhAgWzDfrgt5rhHhAgazSfXgp5ghHhAgdzXfJgk5chIhAggy7e/gb5xhIg/ggxxe5gM6khIg9ggwKe6f87lhI
					g8ghuhfDft8f]],
				["FootB.R"] = [[
					hGgig2/YfLgKmIhGgig6/ZfXgImIhGgig9/ZfogFmIhGglg//bf2gCmAhGgug7/ggFf/lkhGg0g0/jgif6lRhGg1gq/jhEf1lMhGgygh/hhSfylVhGgrgb/d
					hGfzlshGgigY/Ygyf2mIhGgigc/Zgff6mIhGgigf/ZgKf+mIhGgigi/Zf4gCmJhGgigm/ZfqgEmIhGgigp/ZfcgHmIhGgigs/YfPgJmIhGgigw/YfHgLmIhG
					gigz/YfFgMmI]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAiEguAJgAgAi1gAiAguAIgDgViogAh9guALgEgijKgAh/guAPgDgijrgAiDguANgCgVjfgAiEguAJgAgAi1gAiAguAIf9friogAh9guALf8fejKgAh/guAP
					f9fejrgAiDguANf+frjf]],
				Spine1 = [[
					gAiIgXALgAgAjMgAiEgXAIgDgVijf/iCgXAJgDgiivf/iFgXAOgDgijggAiJgXAPgCgVjygAiIgXALgAgAjMgAiEgXAIf9frijgBiCgXAJf9feivgBiFgXAO
					f9fejggAiJgXAPf+frjy]],
				Spine2 = [[
					gAiNf//+gAgAhKf/iIf//6gAfriPf+iGf//5gCfeiZf+iKf//9gCfehYf/iOf///gAfrgngAiNf//+gAgAhKgBiIf//6gAgViPgCiGf//5f+giiZgCiKf//9
					f+gihYgBiOf///gAgVgn]],
				Spine3 = [[
					gAiLfp/+gAgAgyf/iFfp/6gAfriUf+iDfq/3gCfeizf+iIfq/8gCfehkf/iNfq//gAfrgUgAiLfp/+gAgAgygBiFfp/6gAgViUgCiDfq/3f+giizgCiIfq/8
					f+gihkgBiNfq//gAgVgU]],
				Neck1 = [[
					gAiKfUBCgAgAoAf+iCfUAjgFgUlyf9h/fUAYgGgikwf9iGfUAqgGghmXf+iNfUBIgFgUoXgAiKfUBCgAgAoAgCiCfUAjf7fslygDh/fUAYf6fekwgDiGfUAq
					f6ffmXgCiNfUBIf7fsoX]],
				Neck2 = [[
					gAideyC+gAgAtbf9iQewB1gIgTqof8iLevBWgKggpGf8iVexB/gLggrCf9ihezDFgJgTtqgAideyC+gAgAtbgDiQewB1f4ftqogEiLevBWf2fgpGgEiVexB/
					f1fgrCgDihezDFf3fttq]],
				Neck3 = [[
					gAi2edDfgAgAuff9ikeWB/gIgTrCf7ideUBUgKggo+f7iqeYCFgLggrSf9i6eeDkgKgTuogAi2edDfgAgAufgDikeWB/f4ftrCgFideUBUf2fgo+gFiqeYCF
					f1fgrSgDi6eeDkf2ftuo]],
				Head = [[
					gAjhd9/+gAgAhKf8jHdu/sgCfrkUf5i5dn/agGffmBf6jOdw/vgFfej7f8jld//+gBfrg6gAjhd9/+gAgAhKgEjHdu/sf+gVkUgHi5dn/af6ghmBgGjOdw/v
					f7gij7gEjld//+f/gVg6]],
				Jaw = [[
					gAitdqADgAgAhTf8iPdlALf/gVc8f5iCdkAhf7giaWf5iXdmAKf8gidEf8ixdrADgBgVhYgAitdqADgAgAhTgEiPdlALgBfrc8gHiCdkAhgFfeaWgHiXdmAK
					gEfedEgEixdrADf/frhY]],
				["UpperLegF.L"] = [[
					e6hYfUmWfIfz/We4hQfajafXf6/ze3hOfdtafrgP9Ce3hUfZyHfrgM6Xe4hbfU0yfagB4Te6hYfU3ne7f81je7hQfYy3eXfh5ye8hOfYuJeLfR8oe8hVfVrI
					eWfg98e7hbfRs/eyf99N]],
				["LowerLegF.L"] = [[
					e4hLf04/gPf/z+e2hJf9+VhEgdqHe2gzf0/uhgg8cVe2g0fm/5hQg2d+e3g4fa/lgogelEe4g2fR+Qf4gBqae4gvfi/TfMgLmke4gyfu+1ewgOobe5g+fv7g
					fEgDwUe5hBfp07fgfs4M]],
				["FootF.L"] = [[
					e4gsfu/igOf+lVe4g2fk/mhJf1k2e4g6fW/liBftkpe4g4fH/lhpfwkye4gve8/jgwf4lOe4gie4/df5gBl0e4gifG/cfNgJl0e4gifT/beygOlze4gifg/c
					fGgLl0e4gift/dfcgHl0]],
				["UpperLegF.R"] = [[
					hGhYfU3nhFgE1jhFhQfYy3hpgf5yhEhOfYuJh1gv8ohEhVfVrIhqgg98hFhbfRs/hOgD9NhGhYfUmWg4gN/WhIhQfajagpgG/zhJhOfdtagVfx9ChJhUfZyH
					gVf06XhIhbfU0ygmf/4T]],
				["LowerLegF.R"] = [[
					hIg2fR+QgIf/qahIgvfi/Tg0f1mkhIgyfu+1hQfyobhHg+fv7gg8f9wUhHhBfp07gggU4MhIhLf04/fxgBz+hKhJf9+Ve8fjqHhKgzf0/uegfEcVhKg0fm/5
					ewfKd+hJg4fa/lfYfilE]],
				["FootF.R"] = [[
					hIgie4/dgHf/l0hIgifG/cgzf3l0hIgifT/bhOfylzhIgifg/cg6f1l0hIgift/dgkf5l0hIgsfu/ifygClVhIg2fk/me3gLk2hIg6fW/ld/gTkphIg4fH/l
					eXgQkyhIgve8/jfQgIlO]],
				Tail1 = [[
					gAh/hLkygAgA/ogBh7hLjRfrgC/0gBh4hKjZfegE/zgBh5hKk+fegA/mgBh9hKl1frf+/dgAh/hLkygAgA/of/h7hLjRgVf+/0f/h4hKjZgif8/zf/h5hKk+
					gigA/mf/h9hKl1gVgC/d]],
				Tail2 = [[
					gAh3hinSgef//JgAh2hjkwfegE/ogAhyhjj0ergL/vgAhxhilyeXgG/bgAh0hhn6esgA++gAh3hinSfigB/JgAh2hjkwgif8/ogAhyhjj0hVf1/vgAhxhily
					hpf6/bgAh0hhn6hUgA++]],
				Tail3 = [[
					gBhsh4pMhVgA+nf/hvh6mUfwgF/Xf+hsh7kFeRgP/rf+hoh5lpdbgJ/Yf+hoh3oydlf/+qf/hsh4pMergA+ngBhvh6mUgQf7/XgChsh7kFhvfx/rgChoh5lp
					ilf3/YgChoh3oyibgB+q]],
				Tail4 = [[
					gDhfiNl5iXgc/Wf/hliRjWgcgM/0f7hmiSgDeUgB/8f6hgiQgkc2fr/1f6hbiMkLcmfa/hf9hfiNl5dpfk/WgBhliRjWfkf0/0gFhmiSgDhsf//8gGhgiQgk
					jKgV/1gGhbiMkLjagm/h]],
				Tail5 = [[
					gGhWikgijNhX/zgAhgipfAhUgt/8f5hmirbTe2f9/nf1hfioajc1fC/Wf1hVijdxcGeb/of6hWikgiczep/zgAhgipfAesfT/8gHhmirbThKgD/ngLhfioaj
					jLg+/WgLhVijdxj6hl/o]],
				["UpperLegB.L"] = [[
					e7hZgw+Bedf4q8e7hVgy+beefdpve7hTgx9zeefQrhe7hUgw7femfawTe7hYgw35ezfz1Pe7hZgw5HecgAzwe7hVgv7td9gIv2e7hSgt+edlgEpde7hVgr/s
					dof2jne7hYgt/ed+fxlX]],
				["LowerLegB.L"] = [[
					e6hBgU3+fygC1Le5hAgUy8gUgD5xe4g6gWtRgrf79Ge4g0geplgrfv+he5g0grpYgWft+le5g1gnkggSf5/re5g2gcfngLf7//e6g+gOhtf5fz/8e6hMgHrW
					fmf796e6hMgKyrfogK5+]],
				["FootB.L"] = [[
					e6gigQ/Zf2gCmJe6gigd/ZgSf9mIe6gigq/Zgff6mIe6gig4/ZgYf7mIe6gihF/ZgGf/mJe6gshF/fgLf+loe6g2g7/kgHf/lIe6g6gt/nfwgCk7e6g4gf/l
					fpgElEe6gvgU/gfzgClh]],
				["UpperLegB.R"] = [[
					hFhZgw5HhkgAzwhFhVgv7tiDf4v2hFhSgt+eibf8pdhFhVgr/siYgKjnhFhYgt/eiCgPlXhFhZgw+BhjgIq8hFhVgy+bhigjpvhFhTgx9zhigwrhhFhUgw7f
					hagmwThFhYgw35hNgN1P]],
				["LowerLegB.R"] = [[
					hHg1gnkgfugH/rhHg2gcfnf1gF//hGg+gOhtgHgN/8hGhMgHrWgagF96hGhMgKyrgYf25+hGhBgU3+gOf+1LhHhAgUy8fsf95xhIg6gWtRfVgF9GhIg0gepl
					fVgR+hhHg0grpYfqgT+l]],
				["FootB.R"] = [[
					hGgshF/ff1gClohGg2g7/kf5gBlIhGg6gt/ngQf+k7hGg4gf/lgXf8lEhGgvgU/ggNf+lhhGgigQ/ZgKf+mJhGgigd/ZfugDmIhGgigq/ZfhgGmIhGgig4/Z
					fogFmIhGgihF/Zf6gBmJ]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAiJguANgAgAjbgAiJgvAMgAgAjXgAiIgyALgAgAjLgAiGg2AKgAgAi8gAiFg5AIgAgAiugAiEg7AIgAgAingAiFg1AJgAgAizgAiGggANgAgAjagAiFgdAS
					gAgAkHgAiFgdAbgAgAlGgAiFgdAYgAgAkvgAiFgeARgAgAkDgAiGghAPgAgAjxgAiHglAPgAgAjtgAiIgqAOgAgAjmgAiJgtANgAgAjfgAiJguANgAgAjcgA
					iJguANgAgAjbgAiJguANgAgAjb]],
				Spine1 = [[
					gAiPgXANgAgAjbgAiOgYAMgAgAjWgAiNgbALgAgAjGgAiLgeAJgAgAiygAiJghAHgAgAifgAiIgjAGgAgAiVgAiJgdAIgAgAimgAiLgJANgAgAjZgAiLgGAS
					gAgAkHgAiNgGAbgAgAlGgAiMgGAYgAgAkvgAiLgGARgAgAkDgAiMgJAPgAgAjxgAiNgOAPgAgAjtgAiOgSAOgAgAjmgAiOgWANgAgAjfgAiPgXANgAgAjcgA
					iPgXANgAgAjbgAiPgXANgAgAjb]],
				Spine2 = [[
					gAiUf//9gAgAhSgAiTgA/9gAgAhZgAiRgD/8gAgAhtgAiPgG/7gAgAiGgAiNgK/5gAgAidgAiMgL/4gAgAiqgAiNgF/6gAgAiVgAiQfx/9gAgAhUgAiSfu//
					gAgAglgAiUfv//gAgAfngAiTfv//gAgAf+gAiRfv//gAgAgqgAiRfx/+gAgAg8gAiSf2/+gAgAhAgAiTf7/+gAgAhHgAiUf+/+gAgAhOgAiUf//9gAgAhSgA
					iUf//9gAgAhSgAiUf//9gAgAhS]],
				Spine3 = [[
					gAiSfq/9gAgAhSgAiRfr/9gAgAhagAiPft/8gAgAhygAiMfx/6gAgAiQgAiKf0/4gAgAisgAiIf2/2gAgAi7gAiKfw/5gAgAiigAiOfc/9gAgAhVgAiRfZ//
					gAgAglgAiVfa//gAgAfngAiTfZ//gAgAf+gAiRfZ//gAgAgqgAiQfc/+gAgAg8gAiRfh/+gAgAhAgAiSfl/+gAgAhHgAiSfp/+gAgAhOgAiSfq/9gAgAhSgA
					iSfq/9gAgAhSgAiSfq/9gAgAhS]],
				Neck1 = [[
					gAiQfUAngAgAmHgAiPfVAlgAgAl9gAiNfYAggAgAligAiJfcAagAgAk/gAiGffAVgAgAkfgAiEfhATgAgAkNgAiGfbAXgAgAkrgAiMfGAmgAgAmEgAiQfDA/
					gAgAnzgAiVfEBrgAgAqKgAiTfEBZgAgApTgAiQfEA8gAgAnogAiPfGAygAgAm8gAiQfLAwgAgAmzgAiQfQAsgAgAmigAiQfTApgAgAmRgAiQfUAngAgAmHgA
					iQfUAngAgAmHgAiQfUAngAgAmH]],
				Neck2 = [[
					gAifewBtgAgAqSgAieexBqgAgAqGgAiaezBggAgAppgAiVe3BUgAgApCgAiRe6BKgAgAoegAiPe7BFgAgAoLgAiSe1BOgAgAorgAibeiBsgAgAqOgAiiehCu
					gAgAs3gAitelEhgAgAwWgAipekDzgAgAvGgAiiehCmgAgAsmgAifejCLgAgArigAigeoCGgAgArWgAigesB8gAgAq7gAifevBygAgAqggAifewBugAgAqSgA
					ifewBtgAgAqSgAifewBtgAgAqS]],
				Neck3 = [[
					gAizeWBogAgAqBgAixeXBkgAgAp0gAiteZBZgAgApTgAinebBNgAgAongAiieeBCgAgAn/gAifefA8gAgAnpgAijeaBGgAgAoOgAiveIBmgAgAp8gAi6eLDC
					gAgAtjgAjJeWFugAgAyPgAjEeREpgAgAwkgAi5eLC3gAgAtMgAi1eLCQgAgArwgAi1ePCJgAgArfgAi1eTB8gAgAq6gAi0eWBvgAgAqVgAizeWBogAgAqCgA
					izeWBogAgAqBgAizeWBogAgAqB]],
				Head = [[
					gAjTdr/agAgAmCgAjQds/XgAgAmQgAjKds/PgAgAm3gAjDdu/EgAgAnogAi7dv+4gAgAoVgAi3dw+ygAgAotgAi9dr+9gAgAoFgAjOdd/ZgAgAmHgAjjdp/+
					gQfXgbgAj8eD/Dg+epYegAj0d5/ogqe3bXgAjhdo/+gOfbhAgAjadk/0gGfrjVgAjZdo/xgFfvjwgAjXdq/pgDf1kpgAjUdr/ggBf8ljgAjTdr/agAgAmBgA
					jTdr/agAgAmCgAjTdr/agAgAmC]],
				Jaw = [[
					gAibdp/8gAgAhzgAiYdq/7gAgAiHgAiSdt/3gAgAi5gAiLdx/wgAgAj7gAiEd1/ngAgAk2gAiAd3/igAgAlXgAiFdw/rgAgAkhgAiWdb/7gAgAh6gAiwdT/7
					gNfWeAgAjZdX/Gg/epYrgAjJdU/ggoe2angAitdU/8gKfaeZgAijdY//gEfrf+gAiidd//gDfugQgAigdj/+gBf1g3gAicdn/9gAf8hegAibdp/8gAgAhzgA
					ibdp/8gAgAhzgAibdp/8gAgAhz]],
				["UpperLegF.L"] = [[
					e6hffWx+fDgA6ce6hefXx6fCf/6fe6hbfbx/fAf86be6hYfgyge8f56Ee6hVflzTe5f35fe6hTfoz1e4f25Ee6hVfgx/e4fu6be6hbfIuje8fk8de6hefDza
					fCf+5ae6hkfB2PfIgJ2+e6hifB00fFgE4Re6hefEzRfCf+5he6hdfHwOe/fy7je6hefMt6e/fp8ye6hefRu9fAfy8Qe6hffVxzfDf/6ke6hffWx+fDgA6ce6
					hffWx+fDgA6ce6hffWx+fDgA6c]],
				["LowerLegF.L"] = [[
					e4g+fj7agAgAwfe4g9fk75gAgCvqe4g6fo8+gAgHtje4g2fs+Df+gMq+e3gzfv+wf8gPoze3gxfw/Ef6gQnpe3g0ft/mf7gYlAe3g+fc/tf8gbkRe4g8fM8W
					f/gBu1e4hBfC5Lf4fwzve4g/fH6wf8f4xie4g8fN8cf/gCuqe3g+fY+UgCgPqOe3hCfi/BgBgVn0e3hBfl94gEgOrbe4g+fi7pgAgBwFe4g+fj7agAgAwfe4
					g+fj7agAgAwfe4g+fj7agAgAwf]],
				["FootF.L"] = [[
					e4gifU/dgAgAl0e4gifU/dgAgAl0e4gifU/dgBgAl0e4gifU/dgAgAl0e4gifU/df+gAl0e4gifU/df9gAl0e4grfQ/df/gAl0e4g2e+/dgBgAl0e4gje6/d
					f/gAl0e4gie6/df1gCl0e4gie6/df7gBl0e4gje7/df/gAl0e4gre//dgEf/l0e4g0fG/dgFf/l0e4gtfN/dgGf/l0e4gjfT/dgBgAl0e4gifU/dgAgAl0e4
					gifU/dgAgAl0e4gifU/dgAgAl0]],
				["UpperLegF.R"] = [[
					hGhffWx+g9gA6chGhefXnfg4gJ/FhGhbfbwjhAgG7XhGhYfgpCg+gR+rhGhVfluFhDgQ8thGhTfoyShHgN6OhGhVfgx/hIgS6bhGhbfIujhEgc8dhGhefDza
					g+gC5ahGhkfB2Pg4f32+hGhifB00g7f84RhGhefEzRg+gC5hhGhdfHwOhBgO7jhGhefMt6hBgX8yhGhefRu9hAgO8QhGhffVxzg9gB6khGhffWx+g9gA6chG
					hffWx+g9gA6chGhffWx+g9gA6c]],
				["LowerLegF.R"] = [[
					hIg+fj7agAgAwfhIhOf34dfzgC0nhIg8fs89f+f3tmhJhFf+8wf2fyuBhJg5f7+of/fspOhJgyf0/HgEftnahJg0ft/mgFfolAhJg+fc/tgEflkRhIg8fM8W
					gBf/u1hIhBfC5LgIgQzvhIg/fH6wgEgIxihIg8fN8cgBf+uqhJg+fY+Uf+fxqOhJhCfi/Bf/frn0hJhBfl94f8fyrbhIg+fi7pgAf/wFhIg+fj7agAgAwfhI
					g+fj7agAgAwfhIg+fj7agAgAwf]],
				["FootF.R"] = [[
					hIgifU/dgAgAl0hIgvfx/dfzgCl0hIgkfY/df9gBl0hIgsfr/df0gCl0hIgofh/df7gBl0hIgkfY/dgBgAl0hIgrfQ/dgBgAl0hIg2e+/df/gAl0hIgje6/d
					gBgAl0hIgie6/dgLf+l0hIgie6/dgFf/l0hIgje7/dgBgAl0hIgre//df8gBl0hIg0fG/df7gBl0hIgtfN/df6gBl0hIgjfT/df/gAl0hIgifU/dgAgAl0hI
					gifU/dgAgAl0hIgifU/dgAgAl0]],
				Tail1 = [[
					gAiDhKjogAgA/ygAiDhLjsgAgA/xgAiChOj4gAgA/wgAiBhSkHgAgA/ugAiAhVkUgAgA/sgAh/hXkcgAgA/rgAiAhRkQgAgA/tgAh/g8jgf1gB/zgAh+g5jZ
					fTgF/zgAh8g4j5gAgA/wgAh8g5jihEf4/xgAh+g5i2hpfy/0gAh/g8ikhcfy/2gAiAhBiqggf7/4gAiChGi5fpgD/2gAiDhJjMfggE/1gAiDhKjef1gB/zgA
					iDhKjogAgA/ygAiDhKjogAgA/y]],
				Tail2 = [[
					gAh9hij/gAgA/vgAh9hkkMgAgA/tgAh8hmkvgAgA/ogAh7hqldgAgA/hgAh5htmFgAgA/agAh5hvmcgAgA/VgAh5hpl2gAgA/cgAh6hUjyfsgD/xf/h4hRi2
					ePgQ/0gAh2hQi4fCgK/2gCh3hRihhMf5/3gCh5hSh0iyfn/0gCh7hVhijEfg/zgBh8hZhzhuft/5f/h9heiYf7f//5f/h+hijFfRgG/1gAh+hijtfrgD/xgA
					h9hij/gAgA/vgAh9hij/gAgA/v]],
				Tail3 = [[
					gAh3h6jzgAgA/wgAh3h7kJgAgA/ugAh1h+lDgAgA/lgAhyiBmPgAgA/YgAhwiEnSgAgA/JgAhviGn3gAgA/AgAhwiAm5gAgA/Pf/h0hsjgfngD/zf8h0hphv
					dOgY/0f/hxhphTdegb/3gDhzhpg8gVgI/+gHh3hqgPjBfs/2gHh5htf8kSfX/sgDh5hygXjLfc/0f/h6h3hSgxf1/9f+h5h6iafYgE/5f/h4h7jXfmgD/zgA
					h3h6jzgAgA/xgAh3h6jzgAgA/w]],
				Tail4 = [[
					gAhyiSepgAgA/9gAhwiTfHgAgA/+gAhtiVgagAgA//gAhpiYiFgAgA/7gAhliajkgAgA/ygAhjickagAgA/sgAhmiXjCgAgA/2f/hviFeQfof//8f4hxiBbr
					cof4/hf7hviBayb2gB/SgEhyiCaaewgW/egLh2iCZviPga/SgNh5iFZfkrgN++gIh5iKaBkZf+/HgAh4iPbPh3f6/lf9h1iScwf0f9/0f/hziTeDfnf//7gA
					hyiSeogAgA/9gAhyiSepgAgA/9]],
				Tail5 = [[
					gAh0irYMgAgA/BgAhyisYygAgA/KgAhsiuaagAgA/fgAhmixcigAgA/zgAhgizedgAgA/9gAhcizfigAgA//gAhhivdwgAgA/6f+hxidXufwf8+5fzh4iZUh
					c1fG9rf0h3iYTTbAe786gCh6iZS7dFf69CgPiAiZSRglg383gUiCiaSEjzhU8hgPiCigSukrhD8tgDh/inUHiugb9kf9h6iqV6gagA+Wf+h2irXefvf7+1gA
					h0irYLgAgA/BgAh0irYMgAgA/B]],
				["UpperLegB.L"] = [[
					e7hfgu7WekgAwie7hegw7mejf/wHe7hdgz8Neff8vAe7hcg385ecf5tpe7hag79aeZf3sfe7hZg99qeYf1r3e7hag39IeZf3tHe7hbgg50elgCy2e7hagb4z
					epgE0Le7hagZ4HeugE0/e7haga4XesgE0se7hagc47epgE0Ae7hbgg5mengCzJe7hcgk6TelgByKe7hdgp66ekgAxQe7hegt7QekgAwse7hfgu7WekgAwje7
					hfgu7WekgAwie7hfgu7WekgAwi]],
				["LowerLegB.L"] = [[
					e6g+gdwfgAgA7ae6g+gdwmgAgB7We5g+gexAgAgC7Ge5g/ggxtf/gE6pe5hAghyff+gF6He6hAgjy9f9gG5xe5g+gew8gBgF7Ie5g4gVrvgHf99we5g2gUqz
					gHf7+He5g2gUqqgGf5+Ke5g2gUqsgHf6+Je5g2gUq7gHf7+Ee5g4gVrygHf89ve5g6gXtKgFf+9Ke5g8gauzgDf/8Xe6g9gcwFgBgA7qe6g+gdwfgAgA7ae6
					g+gdwfgAgA7ae6g+gdwfgAgA7a]],
				["UpperLegB.R"] = [[
					hFhfgu7WhcgAwihFhegw7mhdgBwHhFhdgz8NhhgEvAhFhcg385hkgHtphFhag79ahngJsfhFhZg99qhogLr3hFhag39IhngJtHhFhbgg50hbf+y2hFhagb4z
					hXf80LhFhagZ4HhSf80/hFhaga4XhUf80shFhagc47hXf80AhFhbgg5mhZf+zJhFhcgk6Thbf/yKhFhdgp66hcgAxQhFhegt7QhcgAwshFhfgu7WhcgAwjhF
					hfgu7WhcgAwihFhfgu7WhcgAwi]],
				["LowerLegB.R"] = [[
					hGg+gdwfgAgA7ahGg+gdwmgAf/7WhHg+gexAgAf+7GhHg/ggxtgBf86phHhAghyfgCf76HhGhAgjy9gDf65xhHg+gew8f/f77IhHg4gVrvf5gD9whHg2gUqz
					f5gF+HhHg2gUqqf6gH+KhHg2gUqsf5gG+JhHg2gUq7f5gF+EhHg4gVryf5gE9vhHg6gXtKf7gC9KhHg8gauzf9gB8XhGg9gcwFf/gA7qhGg+gdwfgAgA7ahG
					g+gdwfgAgA7ahGg+gdwfgAgA7a]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiJguANgAgAjbgAiJgwAMgAgAjXgAiIg0ALgAgAjNgAiHg4AKgAgAjEgAiHg5AKgAgAjBgAiIg0ALgAgAjNgAiKguASgAgAkHgAiMgrAbgAgAlHgAiMgqAe
					gAgAlXgAiMgqAegAgAlXgAiMgqAegAgAlXgAiMgqAegAgAlXgAiMgqAegAgAlXgAiMgqAegAgAlXgAiMgqAegAgAlXgAiMgqAegAgAlXgAiMgqAegAgAlXgA
					iMgqAegAgAlXgAiMgqAegAgAlXgAiMgrAcgAgAlIgAiLgsAUgAgAkVgAiKguAOgAgAjlgAiJguANgAgAjbgAiJguANgAgAjbgAiJguANgAgAjb]],
				Spine1 = [[
					gAiPgXANgAgAjbgAiOgYAMgAgAjUgAiNgcAKgAgAjEgAiMggAJgAgAi0gAiLghAJgAgAivgAiNgdAKgAgAjDgAiQgWAUgAgAkTgAiTgUAggAgAlmgAiUgTAk
					gAgAl6gAiUgTAkgAgAl6gAiUgTAkgAgAl6gAiUgTAkgAgAl6gAiUgTAkgAgAl6gAiUgTAkgAgAl6gAiUgTAkgAgAl6gAiUgTAkgAgAl6gAiUgTAkgAgAl6gA
					iUgTAkgAgAl6gAiUgTAkgAgAl6gAiTgUAhgAgAlngAiRgVAWgAgAklgAiPgWAOgAgAjogAiPgXANgAgAjbgAiPgXANgAgAjbgAiPgXANgAgAjb]],
				Spine2 = [[
					gAiUf//9gAgAhSgAiTgB/9gAgAhcgAiSgE/8gAgAhzgAiQgI/6gAgAiJgAiQgJ/6gAgAiQgAiRgF/8gAgAh0gAiXf///gAgAgOgAicf9/9gAgAengAidf9/8
					gAgAeNgAidf9/8gAgAeNgAidf9/8gAgAeNgAidf9/8gAgAeNgAidf9/8gAgAeNgAidf9/8gAgAeNgAidf9/8gAgAeNgAidf9/8gAgAeNgAidf9/8gAgAeNgA
					idf9/8gAgAeNgAidf9/8gAgAeNgAicf9/9gAgAelgAiYf+//gAgAf3gAiVf//+gAgAhDgAiUf//9gAgAhSgAiUf//9gAgAhSgAiUf//9gAgAhS]],
				Spine3 = [[
					gAiSfq/9gAgAhSgAiRfr/9gAgAhegAiPfv/7gAgAh8gAiNfz/5gAgAiZgAiNf0/5gAgAihgAiPfw/7gAgAh/gAiXfp//gAgAgCgAiefo/7gAgAeIgAiffn/5
					gAgAdqgAiffn/5gAgAdqgAiffn/5gAgAdqgAiffn/5gAgAdqgAiffn/5gAgAdqgAiffn/5gAgAdqgAiffn/5gAgAdqgAiffn/5gAgAdqgAiffn/5gAgAdqgA
					iffn/5gAgAdqgAiffn/5gAgAdqgAiefo/7gAgAeGgAiYfo//gAgAfmgAiTfp/+gAgAhAgAiSfq/9gAgAhSgAiSfq/9gAgAhSgAiSfq/9gAgAhS]],
				Neck1 = [[
					gAiQfUAngAgAmHgAiPfWAjgAgAl1gAiNfaAcgAgAlKgAiKfdAWgAgAkigAiJfeAUgAgAkWgAiMfaAbgAgAlIgAiXfUBEgAgAoGgAigfSB+gAgArBgAiifSCQ
					gAgArvgAiifSCQgAgArvgAiifSCQgAgArvgAiifSCQgAgArvgAiifSCQgAgArvgAiifSCQgAgArvgAiifSCQgAgArvgAiifSCQgAgArvgAiifSCQgAgArvgA
					iifSCQgAgArvgAiifSCQgAgArvgAigfSB/gAgArEgAiZfTBPgAgAowgAiSfUAsgAgAmjgAiQfUAngAgAmHgAiQfUAngAgAmHgAiQfUAngAgAmH]],
				Neck2 = [[
					gAifewBtgAgAqSgAidexBmgAgAp7gAiZe1BVgAgApEgAiVe4BGgAgAoRgAiUe5BCgAgAoBgAiZe1BUgAgApBgAiqeyCvgAgAs5gAi5e0EsgAgAwogAi9e2FQ
					gAgAxigAi9e2FQgAgAxigAi9e2FQgAgAxigAi9e2FQgAgAxigAi9e2FQgAgAxigAi9e2FQgAgAxigAi9e2FQgAgAxigAi9e2FQgAgAxigAi9e2FQgAgAxigA
					i9e2FQgAgAxigAi9e2FQgAgAxigAi6e1EugAgAwtgAiteyDIgAgAtwgAihewB7gAgAq3gAifewBtgAgAqSgAifewBtgAgAqSgAifewBtgAgAqS]],
				Neck3 = [[
					gAizeWBogAgAqBgAiweXBfgAgAplgAireZBLgAgAohgAilecA6gAgAnhgAijedA2gAgAnOgAiqeaBKgAgAoegAjCecC8gAgAtXgAjWemFlgAgAyCgAjbepGY
					gAgAzJgAjbepGYgAgAzJgAjbepGYgAgAzJgAjbepGYgAgAzJgAjbepGYgAgAzJgAjbepGYgAgAzJgAjbepGYgAgAzJgAjbepGYgAgAzJgAjbepGYgAgAzJgA
					jbepGYgAgAzJgAjbepGYgAgAzJgAjWemFpgAgAyIgAjGedDdgAgAubgAi2eXB4gAgAqxgAizeWBogAgAqBgAizeWBogAgAqBgAizeWBogAgAqB]],
				Head = [[
					gAjTdr/agAgAmCgAjPdr/TgAgAmngAjGds++gAgAn/gAi+ds+ngAgApRgAi7dt+ggAgApqgAjFds+9gAgBoDgAjqd5/+gAgAhGgAkIeS/egcfSaXgAkOeZ+v
					fagxXOgAkOeZ+9gAgAX7gAkOeZ/HgkfNYogAkOeZ+vfagxXOgAkOeZ+9gAgAX7gAkOeZ/HgkfNYogAkOeZ+vfagxXOgAkOeZ+9gAgAX7gAkOeZ/HgkfNYogA
					kOeZ+vfagxXOgAkOeZ+9gAgAX7gAkIeT/dgdfSaOgAjxd+/+f1gafJgAjYdu/mgAgAk9gAjTdr/agAgAmCgAjTdr/agAgAmCgAjTdr/agAgAmC]],
				Jaw = [[
					gAibdp/8gAgAhzgAiXdr/4gAgAilgAiOdw/sgAgAkZgAiGd1/ZgAgAmGgAiEd3/TgAgAmmgAiOdx/qgAgBkngAi2dm//gAgAgBgAjgdr/3ghfVdWgAjvdr/n
					fUgsbPgAjtds/vgAgAb9gAjrdu/zgqfScrgAjvdr/nfUgsbPgAjtds/vgAgAb9gAjrdu/zgqfScrgAjvdr/nfUgsbPgAjtds/vgAgAb9gAjrdu/zgqfScrgA
					jvdr/nfUgsbPgAjtds/vgAgAb9gAjhdr/3ghfVdTgAjAdk/9f1gaexgAigdo/9gAgAhXgAibdp/8gAgAhzgAibdp/8gAgAhzgAibdp/8gAgAhz]],
				["UpperLegF.L"] = [[
					e6hffWx+fDgA6ce6hdfYyDfCf/6Ze6hbfdyje/f86De6hYfizVe8f65de6hYfkzne7f65Qe6hbfeyqe+f859e6hlfSzVfIgF5ee6hvfK1ifSgO3pe6hxfI1Z
					fTgO3xe6hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6
					hxfI1ZfTgO3xe6hxfI1ZfTgO3xe6hvfK1gfRgN3re6hnfPsTfDft9ge6hgfVtMfAfu9Ie6hffWx7fDgA6ee6hffWx+fDgA6ce6hffWx+fDgA6c]],
				["LowerLegF.L"] = [[
					e4g+fj7agAgAwfe4g9fl8BgAgCvbe4g6fp9Mf/gHtFe4g3fs+Bf9gKrDe4g2ft+Of8gLqee4g5fp9Uf/gHsze4hDfb5hf9f3zSe5hMfN1mf2fm3le5hPfM1d
					f3fm3ue5hPfM1df3fm3ue5hPfM1df3fm3ue5hPfM1df3fm3ue5hPfM1df3fm3ue5hPfM1df3fm3ue5hPfM1df3fm3ue5hPfM1df3fm3ue5hPfM1df3fm3ue5
					hPfM1df3fm3ue5hPfM1df3fm3ue5hMfN1kf2fm3ne3hOfo9fgJgNsYe3hGfs+HgFgRqye4g+fj7dgAgAwbe4g+fj7agAgAwfe4g+fj7agAgAwf]],
				["FootF.L"] = [[
					e4gifU/dgAgAl0e4gifU/dgAgAl0e4gifU/dgAgAl0e4gifU/df/gAl0e4gifU/df+gAl0e4gifU/dgAgAl0e4glfT/df8gBl0e4gtfQ/AfygAn5e4gwfP+y
					fzf/ore4gwfP+yfzf/ore4gwfP+yfzf/ore4gwfP+yfzf/ore4gwfP+yfzf/ore4gwfP+yfzf/ore4gwfP+yfzf/ore4gwfP+yfzf/ore4gwfP+yfzf/ore4
					gwfP+yfzf/ore4gwfP+yfzf/ore4gtfQ/IfxgBnYe4g4fS/dgLf+l0e4gyfU/dgIf/l0e4gifU/dgAgAl0e4gifU/dgAgAl0e4gifU/dgAgAl0]],
				["UpperLegF.R"] = [[
					hGhffWx+g9gA6chGhdfYyDg+gB6ZhGhbfdyjhBgE6DhGhYfizVhEgG5dhGhYfkznhFgG5QhGhbfeyqhCgE59hGhlfSzVg4f75ehGhvfK1igufy3phGhxfI1Z
					gtfy3xhGhxfI1Zgtfy3xhGhxfI1Zgtfy3xhGhxfI1Zgtfy3xhGhxfI1Zgtfy3xhGhxfI1Zgtfy3xhGhxfI1Zgtfy3xhGhxfI1Zgtfy3xhGhxfI1Zgtfy3xhG
					hxfI1Zgtfy3xhGhxfI1Zgtfy3xhGhvfK1hgufy3qhGhnfPusg7gK8ZhGhgfVu4g/gL8ThGhffWx8g9gA6dhGhffWx+g9gA6chGhffWx+g9gA6c]],
				["LowerLegF.R"] = [[
					hIg+fj7agAgAwfhIg9fl8BgAf+vbhIg6fp9MgBf5tFhIg3fs+BgDf2rDhIg2ft+OgEf1qehIg5fp9UgBf5szhIhDfb5hgDgJzShHhMfN1mgKga3lhHhPfM1d
					gJga3uhHhPfM1dgJga3uhHhPfM1dgJga3uhHhPfM1dgJga3uhHhPfM1dgJga3uhHhPfM1dgJga3uhHhPfM1dgJga3uhHhPfM1dgJga3uhHhPfM1dgJga3uhH
					hPfM1dgJga3uhHhPfM1dgJga3uhHhMfN1lgKga3nhIhKfk8Pf5f6vChJhDfp9Nf7f1tChIg+fj7cgAgAwchIg+fj7agAgAwfhIg+fj7agAgAwf]],
				["FootF.R"] = [[
					hIgifU/dgAgAl0hIgifU/dgAgAl0hIgifU/dgAgAl0hIgifU/dgBgAl0hIgifU/dgCgAl0hIgifU/dgAgAl0hIglfT/dgEf/l0hIgtfQ/AgOgAn5hIgwfP+y
					gNgBorhIgwfP+ygNgBorhIgwfP+ygNgBorhIgwfP+ygNgBorhIgwfP+ygNgBorhIgwfP+ygNgBorhIgwfP+ygNgBorhIgwfP+ygNgBorhIgwfP+ygNgBorhI
					gwfP+ygNgBorhIgwfP+ygNgBorhIgtfQ/EgPgAnnhIgxfS/df4gBl0hIgsfU/df5gBl0hIgifU/dgAgAl0hIgifU/dgAgAl0hIgifU/dgAgAl0]],
				Tail1 = [[
					gAiDhKjogAgA/ygAiDhMjbgAgA/zgAiChQi9gAgA/2gAiBhUihgAgA/5gAiBhViYgAgA/5gAiChRi7gAgA/2gAiDhJk3fmgC/ngAiChGmvgQgA/RgAiChFnM
					g+gA/KgAiChFnMfNgA/KgAiChFnMfcgA/KgAiChFnMhFgA/JgAiChFnMgAgA/LgAiChFnMe7gA/JgAiChFnMgkgA/KgAiChFnMgzgA/KgAiChFnMfCgA/KgA
					iChFnMfugA/KgAiChFnMhHgA/JgAiChGmxfwgA/RgAiDhIlSfjgC/jgAiDhKj5gEgA/wgAiDhKjogAgA/ygAiDhKjogAgA/ygAiDhKjogAgA/y]],
				Tail2 = [[
					gAh9hij/gAgA/vgAh9hkjqgAgA/ygAh+hoi4gAgA/3gAh+hsiJgAgA/6gAh+hth7gAgA/7gAh9hpi0gBgA/3f/h7hhlxfQgE/dgAh4hcogf6f++1gBh3hbpK
					iFf/+lf/h3hbpLfCgD+of/h3hbpKebgA+ngCh3hbpKhyf9+mgAh3hbpLgqgC+pf+h3hbpKd5gC+lgBh3hbpLgcf9+pgBh3hbpKh5gA+mf/h3hbpKelgD+ngA
					h3hbpLe2f/+ogCh3hbpKiBf++lgAh4hcojgGgC+0f/h7hfmafDgE/VgAh9hikZgFf//sgAh9hij/gAgA/vgAh9hij/gAgA/vgAh9hij/gAgA/v]],
				Tail3 = [[
					gAh3h6jzgAgA/wgAh4h8jWgAgA/0gAh5iBiQgAgA/6gAh6iFhOgAgA/+gAh7iGg6gAgA/+gAh5iBiKgCgA/6f+hyh4mIfIgF/YgAhshypufGf7+dgFhqhwqj
					i5f++Df9hqhwqlfjgJ+Lf9hqhwqkdWf9+FgEhqhwqlh1f5+IgBhqhwqlhugG+Jf7hqhwqkdSgE+EgBhqhwqlfsf3+MgEhqhwqji4gA+Ef8hqhwqle0gI+Kf+
					hqhwqkdvf7+HgFhqhwqkiXf6+GgAhrhxpyg7gF+cf+hxh2m/eqgG/MgAh2h6kVgCgA/sgAh3h6jzgAgA/wgAh3h6jzgAgA/wgAh3h6jzgAgA/w]],
				Tail4 = [[
					gAhyiSepgAgA/9gAhziUeCgAgA/7gAh2iZcogAgA/0gAh4idbUgAgA/pgAh5iea7gAgA/lgAh2iacggCgA/zf9hpiPhjfQf+/8f/hdiGmHeLfj/WgJhbiDnN
					jGgX/Af9haiDnOgfgZ/Kf5hbiDnNcqfc+/gHhaiDnNhQf5/JgEhaiDnNitgn/Cf3hbiDnNdWfy/DgBhaiDnNerfg/IgIhbiDnNjVge+/f7haiDnOfmgQ/Kf7
					hbiDnNc4fZ/AgIhbiDnNiBgE/GgBhdiFmMh2gd/Vf8hmiMioejf5/2gAhwiSfTf9gA//gAhyiSepgAgA/9gAhyiSepgAgA/9gAhyiSepgAgA/9]],
				Tail5 = [[
					gAh0irYMgAgA/BgAh2itXfgAgA+1gAh7ixV1gAgA+VgAiAi1UTgAgA9xgAiBi2T2gAgA9mgAh7iyVrgDgB+Rf8hninblflf9/rf8hUichFdoe5/3gNhQiYib
					iogl/yf+hQiZiahWhE/2f0hQiYiccse4/tgJhQiZiagYfi/5gIhQiZicjIhY/tfzhQiZiaeAfx/1f/hQiZibd6ew/zgNhQiYibjFg4/vf6hQiZiagggz/4f2
					hQiZiccret/sgLhQiZiahPf4/4gEhUichMiahI/3f6hiilc5ezfu/0gAhxiqY9f4f+/NgAh0irYMgAgA/BgAh0irYMgAgA/BgAh0irYMgAgA/B]],
				["UpperLegB.L"] = [[
					e7hfgu7WekgAwie7hegw7qeif/wAe7hdg08Uegf8uze7hcg582edf6tve7hcg68/edf5tce7hdg18aeff8upe7hfgs6zeogCxbe7hhgm5ZewgGzae7hhgl5B
					eygHz5e7hhgl5BeygHz5e7hhgl5BeygHz5e7hhgl5BeygHz5e7hhgl5BeygHz5e7hhgl5BeygHz5e7hhgl5BeygHz5e7hhgl5BeygHz5e7hhgl5BeygHz5e7
					hhgl5BeygHz5e7hhgl5BeygHz5e7hhgm5XewgGzce7hggq6aeqgDyAe7hfgu7NelgAwxe7hfgu7WekgAwie7hfgu7WekgAwie7hfgu7WekgAwi]],
				["LowerLegB.L"] = [[
					e6g+gdwfgAgA7ae6g+gewwgAgB7Qe6g/gfxhf/gC6xe6hAghyYf+gD6Me6hAgiypf9gE5/e6g/ggxpf/gC6se6g+gdwPgAf+7je6g9gcwDf+f77qe6g9gcwH
					f9f67oe6g9gcwHf9f67oe6g9gcwHf9f67oe6g9gcwHf9f67oe6g9gcwHf9f67oe6g9gcwHf9f67oe6g9gcwHf9f67oe6g9gcwHf9f67oe6g9gcwHf9f67oe6
					g9gcwHf9f67oe6g9gcwHf9f67oe6g9gcwEf+f77qe6g9gcwGgAf97pe6g+gdwZgAgA7ee6g+gdwfgAgA7ae6g+gdwfgAgA7ae6g+gdwfgAgA7a]],
				["UpperLegB.R"] = [[
					hFhfgu7WhcgAwihFhegw7qhegBwAhFhdg08UhggEuzhFhcg582hjgGtvhFhcg68/hjgHtchFhdg18ahhgEuphFhfgs6zhYf+xbhFhhgm5ZhQf6zahFhhgl5B
					hOf5z5hFhhgl5BhOf5z5hFhhgl5BhOf5z5hFhhgl5BhOf5z5hFhhgl5BhOf5z5hFhhgl5BhOf5z5hFhhgl5BhOf5z5hFhhgl5BhOf5z5hFhhgl5BhOf5z5hF
					hhgl5BhOf5z5hFhhgl5BhOf5z5hFhhgm5XhQf6zchFhggq6ahWf9yAhFhfgu7NhbgAwxhFhfgu7WhcgAwihFhfgu7WhcgAwihFhfgu7WhcgAwi]],
				["LowerLegB.R"] = [[
					hGg+gdwfgAgA7ahGg+gewwgAf/7QhGg/gfxhgBf+6xhGhAghyYgCf96MhGhAgiypgDf85/hGg/ggxpgBf+6shGg+gdwPgAgC7jhGg9gcwDgCgF7qhGg9gcwH
					gDgG7ohGg9gcwHgDgG7ohGg9gcwHgDgG7ohGg9gcwHgDgG7ohGg9gcwHgDgG7ohGg9gcwHgDgG7ohGg9gcwHgDgG7ohGg9gcwHgDgG7ohGg9gcwHgDgG7ohG
					g9gcwHgDgG7ohGg9gcwHgDgG7ohGg9gcwEgCgF7qhGg9gcwGgAgD7phGg+gdwZgAgA7ehGg+gdwfgAgA7ahGg+gdwfgAgA7ahGg+gdwfgAgA7a]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiJguANgAgAjbgAiLgxAWgAgAkmgAiNg2AzgAgAnDgAiPg5BMgAgAolgAiPg5BNgAgAoogAiPg5BNgAgAoogAiPg5BNgAgAoogAiPg5BNgAgAoogAiPg5BN
					gAgAoogAiWg5BNgAgAoogAiZg5BNgAgAoogAiWg5BNgAgAoogAiPg5BNgAgAoogAiPg5BNgAgAoogAiPg5BNgAgAoogAiPg5BNgAgAoogAiPg5BNgAgAoogA
					iOg4BHgAgAoSgAiNg0AsgAgAmggAiKgwAUgAgAkYgAiJguANgAgAjb]],
				Spine1 = [[
					gAiPgXANgAgAjbgAiSgaAYgAgAkygAiXggA8gAgAnngAibgkBbgAgApYgAibgkBcgAgApcgAibgkBcgAgApcgAibgkBcgAgApcgAibgkBcgAgApcgAibgkBc
					gAgApcgAijgkBcgAgApcgAimgkBcgAgApcgAijgkBcgAgApcgAibgkBcgAgApcgAibgkBcgAgApcgAibgkBcgAgApcgAibgkBcgAgApcgAibgkBcgAgApcgA
					iagjBUgAgApDgAiWgeAygAgAm/gAiRgZAWgAgAkhgAiPgXANgAgAjb]],
				Spine2 = [[
					gAiUf//9gAgAhSgAiZgC//gAgAfugAijgK/ygAgAcdgAipgQ/fgAgAaZgAipgQ/fgAgAaVgAipgQ/fgAgAaVgAipgQ/fgAgAaVgAipgQ/fgAgAaVgAipgQ/f
					gAgAaVgAiwgQ/fgAgAaVgAizgQ/fgAgAaVgAiwgQ/fgAgAaVgAipgQ/fgAgAaVgAipgQ/fgAgAaVgAipgQ/fgAgAaVgAipgQ/fgAgAaVgAipgQ/fgAgAaVgA
					iogP/kgAgAazgAiggI/3gAgAdMgAiYgC//gAgAgCgAiUf//9gAgAhS]],
				Spine3 = [[
					gAiSfq/9gAgAhSgAiZft//gAgAfjgAinf1/ugAgAb5gAiwf8/VgAgAZlgAiwf8/UgAgAZggAiwf8/UgAgAZggAiwf8/UgAgAZggAiwf8/UgAgAZggAiwf8/U
					gAgAZggAi4f8/UgAgAZggAi7f8/UgAgAZggAi4f8/UgAgAZggAiwf8/UgAgAZggAiwf8/UgAgAZggAiwf8/UgAgAZggAiwf8/UgAgAZggAiwf8/UgAgAZggA
					iuf6/bgAgAaBgAikfz/0gAgActgAiYfs//gAgAf4gAiSfq/9gAgAhS]],
				Neck1 = [[
					gAiQfUAngAgAmHgAiafXA2gAgAnNgAitfgBdgAgApfgAi5foB8gAgAq6gAi5foB9gAgAq9gAi5foB9gAgAq9gAi5foB9gAgAq9gAi5foB9gAgAq9gAi5foB9
					gAgAq9gAjAfoB9gAgAq9gAjDfoB9gAgAq9gAjAfoB9gAgAq9gAi5foB9gAgAq9gAi5foB9gAgAq9gAi5foB9gAgAq9gAi5foB9gAgAq9gAi5foB9gAgAq9gA
					i2fmB1gAgAqogAipfeBTgAgAo/gAiYfXAygAgAm/gAiQfUAngAgAmH]],
				Neck2 = [[
					gAifewBtgAgAqSgAire0B4gAgAqwgAjDfACPgAgArugAjSfKCggAgAsWgAjSfKCggAgAsXgAjSfKCggAgAsXgAjSfKCggAgAsXgAjSfKCggAgAsXgAjSfKCg
					gAgAsXgAjZfKCggAgAsXgAjcfKCggAgAsXgAjZfKCggAgAsXgAjSfKCggAgAsXgAjSfKCggAgAsXgAjSfKCggAgAsXgAjSfKCggAgAsXgAjSfKCggAgAsXgA
					jPfICcgAgAsOgAi+e9CKgAgArggAioezB2gAgAqqgAifewBtgAgAqS]],
				Neck3 = [[
					gAizeWBogAgAqBgAi/ebBmgAgAp6gAjZepBggAgApqgAjpezBdgAgApfgAjpe0BdgAgApfgAjpe0BdgAgApfgAjpe0BdgAgApfgAjpe0BdgAgApfgAjpe0Bd
					gAgApfgAjwe0BdgAgApfgAjze0BdgAgApfgAjwe0BdgAgApfgAjpe0BdgAgApfgAjpe0BdgAgApfgAjpe0BdgAgApfgAjpe0BdgAgApfgAjpe0BdgAgApfgA
					jmexBegAgAphgAjTelBigAgAptgAi9eaBmgAgAp7gAizeWBogAgAqB]],
				Head = [[
					gAjTdr/agAgAmCgAjfdw/XgcgFmSgAj4d9/MiLgXmxgAkHeH/CjHgfnFgAkHeH/Ih8gTnHgAkHeH/MgAgAnIgAkHeH/IeEftnHgAkHeH/Cc3fhnGgAkHeH/C
					c3fhnGgAkPeH/IeEftnHgAkSeH/MgAgAnIgAkPeH/Ih8gTnHgAkHeH/CjJgfnGgAkHeH/CjJgfnGgAkHeH/Ih8gTnHgAkHeH/MgAgAnIgAkHeH/IeEftnHgA
					kEeF/EdEfinBgAjyd6/PeKfsmqgAjcdv/Yfqf8mOgAjTdr/agAgAmC]],
				Jaw = [[
					gAibdp/8gAgAhzgCindu/zgcgDjcgIjAd9/LiLgYm2gLjQeI+jjFgro+gHjQeJ+nh7gbpEgAjQeJ+rgAgApFf5jQeJ+neFflpEf1jReJ+hc5fUpCf1jReJ+h
					c5fUpCf5jXeJ+neFflpEgAjaeJ+rgAgApFgHjXeJ+nh7gbpEgLjReJ+hjHgspCgLjReJ+hjHgspCgHjQeJ+nh7gbpEgAjQeJ+rgAgApFf5jQeJ+neFflpEf2
					jNeG+rdGfZokf5i7d5/WeKfumGf/ildt/1fqf+jIgAibdp/8gAgAhz]],
				["UpperLegF.L"] = [[
					e6hffWx+fDgA6ce6hofUvKfEf08Je6h9fRrCfIfd+Ae6iMfSuAfLfY8ve6iMfSyzfIfl53e6iMfS09fHfs4Je6iMfSyzfIfl53e6iMfSuCfLfY8ue6iMfSqE
					fPfO+We6iTfSrAfOfQ+Be6iWfSvvfJfd71e6iTfSz8fHfp4/e6iMfS0sfHfr4Ye6iMfSxXfIfh62e6iMfSsZfMfU9ee6iMfSpufQfN+de6iMfSsZfMfU9ee6
					iJfSxBfIfj7Ee6h4fSyQfFfx6Qe6hmfUxcfEf66ze6hffWx+fDgA6c]],
				["LowerLegF.L"] = [[
					e4g+fj7agAgAwfe4hLfn86gGgItre3hnfs+sgJgOpCe3hwfo/ggGgRlle3hrfd/IgGgMnZe4hpfX+sgEgGpCe3hrfd/IgGgMnZe3hwfo/hgGgRlde3h3fu/g
					gCgNlhe3h9ft/igDgPlYe3h4fk/cgGgQl4e4hxfa+7gFgJoNe4hpfY+wgEgHoze3hsfh/TgGgOmke3hzfr/jgFgQlUe3h4fv/ggCgNlle3hzfr/jgFgQlUe3
					hpfh/KgHgOnPe4hXfe90gFgHrle4hGfi8XgDgDuze4g+fj7agAgAwf]],
				["FootF.L"] = [[
					e4gifU/dgAgAl0e4gzfT/wgIf/j0e4hWfS//gNgAfpe4hlfL/3gMgBdPe4hdfB/3gKgBdKe4hZe9/3gGgBdKe4hdfB/3gKgBdKe4hmfK/3gMgBdKe4htfR/3
					gIgBdKe4hyfQ/3gJgBdKe4htfH/3gNgBdKe4hie//3gIgBdKe4hZe9/3gHgBdKe4hgfE/3gMgBdKe4hpfN/3gLgBdKe4htfS/3gHgBdKe4hpfN/3gLgBdKe4
					hcfF/6gMgBdre4hCfH//gHgAgje4gsfQ/tgDgAkNe4gifU/dgAgAl0]],
				["UpperLegF.R"] = [[
					hGhffWx+g9gA6chGhofUxYg8gH61hGh9fRyug6gR57hGiMfSxTg4gf64hGiMfSsZg0gs9ehGiMfSpugwgz+dhGiMfSsZg0gs9ehGiMfSxXg4gf62hGiMfS0s
					g5gV4YhGiTfSz8g5gX4/hGiWfSvvg3gj71hGiTfSrAgygw+BhGiMfSqEgxgy+WhGiMfSuCg1go8uhGiMfSyzg4gb53hGiMfS09g5gU4JhGiMfSyzg4gb53hG
					iJfSt2g2gm80hGh4fSrrg5ge9xhGhmfUvpg8gK75hGhffWx+g9gA6c]],
				["LowerLegF.R"] = [[
					hIg+fj7agAgAwfhIhIfi8jf9f8uahIhcfd+Hf7f5q0hJhsfh/Sf6fymqhJhzfr/jf7fwlUhJh4fv/gf+fzllhJhzfr/jf7fwlUhJhsfh/Tf6fymkhIhpfY+w
					f8f5ozhIhxfa+7f7f3oNhJh4fk/cf6fwl4hJh9ft/if9fxlYhJh3fu/gf+fzlhhJhwfo/hf6fvldhJhrfd/If6f0nZhIhpfX+sf8f6pChJhrfd/If6f0nZhJ
					htfo/Xf5fwmThJhhfr+Xf3fyqDhIhIfm8rf7f5uKhIg+fj7agAgAwf]],
				["FootF.R"] = [[
					hIgifU/dgAgAl0hIgvfP/wf8gAj0hIhIfE//f5gAfphIhffE/3f0f/dPhIhpfN/3f1f/dKhIhtfS/3f5f/dKhIhpfN/3f1f/dKhIhgfE/3f0f/dKhIhZe9/3
					f5f/dKhIhie//3f4f/dKhIhtfH/3fzf/dKhIhyfQ/3f3f/dKhIhtfR/3f4f/dKhIhmfK/3f0f/dKhIhdfB/3f2f/dKhIhZe9/3f6f/dKhIhdfB/3f2f/dKhI
					hhfL/6fzf/drhIhOfS//fygAgjhIgvfT/tf5gBkNhIgifU/dgAgAl0]],
				Tail1 = [[
					gAiDhKjogAgA/ygAiChMkmg6f8/pgAiAhPmojTgE/HgAh/hRn9higI+8gAh/hRn+dEfx+1gAh/hRn6bBfn+lgAh/hRn+dEfx+1gAh/hRoAhjgI+7gAh/hRn7
					kwgY+ogAiHhRn8kDgU+ugAiKhRoAgAgA++gAiHhRn8b9fs+ugAh/hRn7bQfo+ogAh/hRoAedf4+7gAh/hRn+i8gP+1gAh/hRn6k/gZ+lgAh/hRn+i8gP+1gA
					iAhRntekf6/AgAiBhPmMdNgA/QgAiChMkafSgE/rgAiDhKjogAgA/y]],
				Tail2 = [[
					gAh9hij/gAgA/vgBh7hkkyhcf5/mgFh2hlmUmtgD+ogCh0hnnbk7gR+uf8h0hmngcIfs+2f4h0hmnMWmfX9tf8h0hmnVYufj+RgCh0hnnjg7gI/EgHh0hmnR
					oUgm+BgGh7hmnOo3gl93gAh+hnniiJgG/Bf6h7hmnZZlfi+df5h0hmnLWafX9qf+h0hnndbCfu+tgEh0hmngj4gU+2gIh0hmnMpagp9tgEh0hmnVnSgd+Rf+
					h0hmnUfJf6/If8h3hlmBbEgD/Cf/h8hkkoeagJ/ngAh9hij/gAgA/v]],
				Tail3 = [[
					gAh3h6jzgAgA/wgEh0h7kahgf5/pgPhth6lapigJ+DgKhph7mMpagh98f2hoh8mjdZfm/Nfrhqh4l8TnfA84fxhph6l+T+fP9BgEhoh9mkeOgG/QgThqh4mK
					qEg59ugThxh4l0tZg88cgDhyh8mbl+gP+wfwhwh6mZZSfU+nfrhqh3lzSfe/8Zf2hoh7mNWgfe96gKhoh8mjinga/NgVhqh4l8sZhA84gPhph6l+sCgx9Bf8
					hph9mYhqf6/Tf0huh7lUaAf/++f8h0h7kSdigO/mgAh3h6jzgAgA/w]],
				Tail4 = [[
					gAhyiSepgAgA/9gGhtiTfEhGgI/9gdhliNf5rGiE97gXhgiOgVtti98wfyhfiSgpgrfn/+fZhiiHgXS5ci8+fghhiKgPQMcY7kgBheiTgmaFfH/agihhiKgg
					pbit+cgmhpiHgNwWj77NgMhpiRgeqdiE+KfmhniPgnbVeX/mfYhjiGgQQkcI7vfohgiOgWSLdA8sgOhfiSgpfVgZ/+gnhiiHgXtHje8+gghhiKgPv0jo7kf/
					hfiTgeligz/ffrhmiRfxaSe9/df5huiTe/c2fw/0gAhyiSepgAgA/9]],
				Tail5 = [[
					gAh0irYMgAgA/BgHhuisYbgRgI/FgthnigZVqxkl9BgrhhieaBwQnN56fzheirZflAhR+5fHhkiYZuU2Z68rfLhkiWaIOuX95Af4heiqZpV6cN9cgwhiifZi
					mXkC+ag7hsiTaGwuoI5XgbhpilZ2t+l37fffhnimZcfRei/RfDhliTZ8RVYi6wfVhhidaCPoYu50gNheirZfbAev+5g5hkiYZurKmG8rg1hkiWaIxSoD5AgH
					hfiqZhpejf9qfjhnioY6b/eJ+4f0hwirYbcmfB+4gAh0irYMgAgA/B]],
				["UpperLegB.L"] = [[
					e7hfgu7WekgAwie7hggu66epgBxPe7hjgs5ie1gGzOe7hmgr3pfDgN1he7hmgr3hfEgN1qe7hmgr3hfEgN1qe7hmgr3hfEgN1qe7hmgr3hfEgN1qe7hmgr3h
					fEgN1qe7htgr3hfEgN1qe7hwgr3hfEgN1qe7htgr3hfEgN1qe7hmgr3hfEgN1qe7hmgr3hfEgN1qe7hmgr3hfEgN1qe7hmgr3hfEgN1qe7hmgr3hfEgN1qe7
					hlgr4Ne/gL05e7higs57eygFyse7hggu7AeogBxGe7hfgu7WekgAwi]],
				["LowerLegB.L"] = [[
					e6g+gdwfgAgA7ae6g+gew5f/f+7Le6hAgiygf7f46Ge6hBgn05fzfy4Oe6hBgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6hBgo1D
					fzfx4Fe6hJgo1Dfzfx4Fe6hMgo1Dfzfx4Fe6hJgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6hBgo1Dfzfx4Fe6
					hBgm0Mf2fz40e6g/ggyBf8f66be6g+gewzf/f+7Oe6g+gdwfgAgA7a]],
				["FootB.L"] = [[
					e6gigs/ZgAgAmJe6gigs/Zf+gAmJe6gigs/Zf3gCmJe6gigs/ZftgEmJe6gigs/ZftgEmIe6gigs/ZftgEmIe6gigs/ZftgEmIe6gigs/ZftgEmIe6gigs/Z
					ftgEmIe6gqgs/ZftgEmIe6gtgs/ZftgEmIe6gqgs/ZftgEmIe6gigs/ZftgEmIe6gigs/ZftgEmIe6gigs/ZftgEmIe6gigs/ZftgEmIe6gigs/ZftgEmIe6
					gigs/ZfwgDmIe6gigs/Zf5gBmJe6gigs/Zf/gAmJe6gigs/ZgAgAmJ]],
				["UpperLegB.R"] = [[
					hFhfgu7WhcgAwihFhggu66hXf/xPhFhjgs5ihLf6zOhFhmgr3pg9fz1hhFhmgr3hg8fz1qhFhmgr3hg8fz1qhFhmgr3hg8fz1qhFhmgr3hg8fz1qhFhmgr3h
					g8fz1qhFhtgr3hg8fz1qhFhwgr3hg8fz1qhFhtgr3hg8fz1qhFhmgr3hg8fz1qhFhmgr3hg8fz1qhFhmgr3hg8fz1qhFhmgr3hg8fz1qhFhmgr3hg8fz1qhF
					hlgr4NhBf105hFhigs57hOf7yshFhggu7AhYf/xGhFhfgu7WhcgAwi]],
				["LowerLegB.R"] = [[
					hGg+gdwfgAgA7ahGg+gew5gBgC7LhGhAgiyggFgI6GhGhBgn05gNgO4OhGhBgo1DgNgP4FhGhBgo1DgNgP4FhGhBgo1DgNgP4FhGhBgo1DgNgP4FhGhBgo1D
					gNgP4FhGhJgo1DgNgP4FhGhMgo1DgNgP4FhGhJgo1DgNgP4FhGhBgo1DgNgP4FhGhBgo1DgNgP4FhGhBgo1DgNgP4FhGhBgo1DgNgP4FhGhBgo1DgNgP4FhG
					hBgm0MgKgN40hGg/ggyBgEgG6bhGg+gewzgBgC7OhGg+gdwfgAgA7a]],
				["FootB.R"] = [[
					hGgigs/ZgAgAmJhGgigs/ZgCgAmJhGgigs/ZgJf+mJhGgigs/ZgTf8mJhGgigs/ZgTf8mIhGgigs/ZgTf8mIhGgigs/ZgTf8mIhGgigs/ZgTf8mIhGgigs/Z
					gTf8mIhGgqgs/ZgTf8mIhGgtgs/ZgTf8mIhGgqgs/ZgTf8mIhGgigs/ZgTf8mIhGgigs/ZgTf8mIhGgigs/ZgTf8mIhGgigs/ZgTf8mIhGgigs/ZgTf8mIhG
					gigs/ZgQf9mIhGgigs/ZgHf/mJhGgigs/ZgBgAmJhGgigs/ZgAgAmJ]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiJguANgAgAjbgAiJg4AUgAgAkUgAiJhAAbgAgAlGgAiJg+AagAgAk+gAiJg8AXgAgAktgAiJg4AVf6e3kXgAiJg1AUf3ebkEgAiJg0ARf7fKj8gAiJgzAQ
					gAgAj4gAiLgxAPf1gKjrgAiYgvAUdcgRjegAiwguBAY8gxjWgAjHguCuTmhWjKgAjXguFLO7h2i5gAjfguHTL/iKiqgAjhguH/LJiQimgAjfguHYL4iLiqgA
					jdguG2MjiGiugAjfguHUL9iKiqgAjhguH+LLiQimgAjhguIALJiQimgAjhguIALJiQimgAjhguIALJiQimgAjhguIALJiQimgAjhguIALJiQim]],
				Spine1 = [[
					gAiPgXANgAgAjbgAiQggAUgAgAkUgAiRgpAbgAgAlGgAiRgnAagAgAk+gAiRgkAXgAgAktgCiQghAVf6e3kXgCiQgeAUf3ebkEgBiPgcARf7fKj8gAiPgbAQ
					gAgAj4gAiQgZAPf1gKjrf/idgXAUdbgLjff+i0gXBAY6ghjaf8jLgXCwTjg6jWf7jZgXFOO3hSjQf7jggXHXL7hjjKf7jigXIELGhojJf7jggXHcL0hjjKf7
					jfgXG6MfhfjMf7jggXHYL5hjjKf7jigXIDLHhojJf7jigXIELFhojJf7jigXIELFhojJf7jigXIELFhojJf7jigXIELFhojJf7jigXIELFhojJ]],
				Spine2 = [[
					gAiUf//9gAgAhSgAiWgJ//gAgAgZgAiZgS//gAgAfngAiYgQ//gAgAfugAiYgN//gAgAgAgDiXgK/+f7hJgWgFiWgG/8f6hlgogDiVgF/+f9g2gxgAiVgE/+
					gAgAg1f/iWgC/+gMf4hCf+iigA/3ikgThNf8i5f//KnFgzhIf5jPf/9bschXg0f3jcf/6+xHhzgXf2jif/420DiDf/f2jkf/4J04iGf3f2jif/4w0KiDf+f2
					jhf/5SzfiAgEf2jif/400FiDf/f2jkf/4K03iGf4f2jkf/4I05iGf3f2jkf/4I05iGf3f2jkf/4I05iGf3f2jkf/4I05iGf3f2jkf/4I05iGf3]],
				Spine3 = [[
					gAiSfq/9gAgAhSgAiWfz//gAgAgZgAiZf8//gAgAfngAiZf7//gAgAfugAiYf4//gAgAgAgFiWf0/+f7hJgWgHiVfx/8f6hlgogEiUfv/+f9g2gxgAiUfu/+
					gAgAg1f/iUfs/+gMf5hCf/ihfq/3ikgZhMf9i4fq/KnFhDhEf7jPfq9bsahzgof5jdfq69xEiXgAf4jkfq40z/iqfff4jmfq4I00iufUf4jkfq4v0Girfef4
					jjfq5Rzcinfmf4jkfq4z0Biqfff4jmfq4J0ziufVf4jmfq4H01ivfUf4jmfq4H01ivfUf4jmfq4H01ivfUf4jmfq4H01ivfUf4jmfq4H01ivfU]],
				Neck1 = [[
					gAiQfUAngAgAmHgAiVfeBAgAgAn3gAiafnBbgAgApXgAiZflBWgAgApJgAiYfiBMgAgAongGiWffBCfye4n8gJiUfcA7ftednXgFiTfaA1f2fLnGgAiTfZAy
					gAgAm/f/iTfXAtf2gLmmgAiffVAuddgXmIf/i3fUBXY9g+lyf+jPfUDETphpldf8jffUFfPAiMlFf7jnfVHlMEiik0f6jpfVISLQiokuf7jnfVHrL+ijkzf7
					jlfVHJMoiek3f7jnfVHnMDiik0f6jpfVIRLRiokvf6jpfVISLPiokuf6jpfVISLPiokuf6jpfVISLPiokuf6jpfVISLPiokuf6jpfVISLPioku]],
				Neck2 = [[
					gAifewBtgAgAqSgAioe8CrgAgAsxgAiwfGDsgAgAu5gAiufFDigAgAulgAisfBDKgAgAt1gJioe9Cwfme7s5gMile5CbfeehsFgHike3CQfufNrtgAije2CL
					gAgArif/ijezB9f4gNq+f+iuexBzdkg2qPf6jEewCTZSiQphf1jZewD0ULjyomfxjmewGBPsk/nhfvjsewH8M2lrmsfujtewIlMCl2mbfvjsewIBMvlsmqfv
					jrewHiNZljm3fvjsewH9M0lrmsfujtewIkMDl2mcfujtewIlMBl2mbfujtewIlMBl2mbfujtewIlMBl2mbfujtewIlMBl2mbfujtewIlMBl2mb]],
				Neck3 = [[
					gAizeWBogAgAqBgAjAelC7gAgAtWgAjKe0EYgAgAwHgAjJeyEJgAgAvtgAjFetDngAgAuvgLjAenDBfle8tfgPi8eiCkfcehsbgIi6efCVftfNr7gAi5eeCP
					gAgArsf+i3eaB9f4gNq9f6jBeXBtdng+p7fxjVeVCHZZiio7fojmeVDhUWkLnpfhjteVFnP6lYmNfejveUHcNFl+lHfdjveUIDMSmIkxfejveUHhM/mAlEfe
					jveUHDNol4lVfejveUHdNEl/lGfdjveUICMTmIkyfdjveUIEMRmIkxfdjveUIEMRmIkxfdjveUIEMRmIkxfdjveUIEMRmIkxfdjveUIEMRmIkx]],
				Head = [[
					gAjTdr/agAgAmCgAjoeD/+gAgAhBgAj5ea/zgAgAcmgAj3eW/3gBgAdQgAjxeO/+gAgAe0gNjpeE/8eegngtgTjid9/0d0g8iTgKjfd4/zezgijKgAjed2/y
					gAgAjjf9jadx/pgaf6kqf1jgds/SingFmKfjjvdp+UnGgbnUfSj3dn8UsShLoWfIj1dm5nwoiOpPfEjwdl3YzRjHpxfEjvdl2q0Ajap6fEjwdl3TzXjKpyfF
					jxdl32yxi7prfEjwdl3XzTjIpxfEjvdl2rz/jap6fEjvdl2p0Bjbp6fEjvdl2p0Bjbp6fEjvdl2p0Bjbp6fEjvdl2p0Bjbp6fEjvdl2p0Bjbp6]],
				Jaw = [[
					gAibdp/8gAgAhzgAi0dv//gAgAfbgAjMd4/4gAgAdWgAjId3/5gBgAdqgAjAdz/8gAgAeZgJi2dv/8eggrfQgNitdt/5d4hGf/gHipds/9e3gogbgAindr//
					gAgAgof/iidq/9gZf3hNf+ipdq/ximfyinf7i8dr+2nHfyklf6jQdt8usVggmyf6jddu50wrh2oqf6jkdw3YzRjHpwf6jmdw2mz/jiqDf6jldw3SzXjKpzf6
					jjdv35yyi1pjf6jkdw3XzTjIpxf6jmdw2nz+jiqDf6jmdw2lz/jjqDf6jmdw2lz/jjqDf6jmdw2lz/jjqDf6jmdw2lz/jjqDf6jmdw2lz/jjqD]],
				["UpperLegF.L"] = [[
					e6hffWx+fDgA6ce6hkfdzbfEf95Ze6hofj0pfEf64be5hnfi0dfEf64ke6hmfg0CfEf747fAhkfYzfeHgm5TfDhifUzAdwg25ne+hhfWyzeXgd51e6hhfZyt
					fDf+58e5hgfYyXfRgF6MfChjfVxpgPiV6lfVhrfSwmiImg6ffxh6fQvLkFrl5WgMiKfNttlhwG3YgdiYfMsqmSy+1igiidfLsWmfzy07geiYfMsnmUzE1ega
					iVfMs3mJya17gdiYfMspmSy/1hgiidfLsWmezx08giidfLsVmfzy06giidfLsVmfzy06giidfLsVmfzy06giidfLsVmfzy06giidfLsVmfzy06]],
				["LowerLegF.L"] = [[
					e4g+fj7agAgAwfe4hCfm8TgAgAu7e4hFfp8/gAgAtie4hFfo85gAgAtve4hDfn8pgAgAuPe+hCfh8Ufag/u1fAhBfe8BfMhXvWe8hAfh76fkguvme4hAfk73
					gAgAvue4g/fk7qgOgAwEfFhCfj7NiDhmwofghOfi6RljkgwygEhifi4mpkoHwKgkh6fi2es8rYu4g3iNfh0xu/tgtng8iUfh0OvkuGtLg3iOfh0svEtktkgz
					iJfh1HumtGt5g3iOfh0wvAthtmg8iUfh0PvjuFtMg8iUfh0NvkuHtLg8iUfh0NvkuHtLg8iUfh0NvkuHtLg8iUfh0NvkuHtLg8iUfh0NvkuHtL]],
				["FootF.L"] = [[
					e4gifU/dgAgAl0e4gofU/vgAgAkDe4gufV/5gAgAife4gtfV/4gAgAiue4grfV/0gAgAjSe/gpfP/ufzhIj9fBgnfO/ofuhkkie9gmfR/nf2g1k0e4glfU/n
					gAgAk8e4gkfV/igNf7lWfKgnfV/UiegymBftg1fW+fmyiRmggZhPfX8trzkPmgg/hvfY6RwHmImChUiIfY4OyxnYldhaiRfZ3jzhnvlQhViJfY4Jy3nblchQ
					iDfY4pyRnIlmhUiJfY4NyznZldhaiRfZ3kzgnvlQhaiRfZ3jzinwlPhaiRfZ3jzinwlPhaiRfZ3jzinwlPhaiRfZ3jzinwlPhaiRfZ3jzinwlP]],
				["UpperLegF.R"] = [[
					hGhffWx+g9gA6chGhkfdzbg8gD5ZhGhofj0pg8gG4bhGhnfi0dg9gG4khGhmfg0Cg8gF47hNhjfizfgAgt5XhPhifizAfpg75thLhhfeyzgQgg54hGhhfZyt
					g9gC58hGhifXyXhKgG6LhNh5fYxoiIiT6ghUiofZwkkEmZ6ThSjefcvHmHrW5FhHkJfftkntvv3Eg6kgfhsdomyi1Pg1kmfhsHo1zV0og5khfhsaooyo1Kg9
					kcfgsrobyA1og6kgfhscomyk1Og1kmfhsHo0zU0og1knfhsHo1zV0ng1knfhsHo1zV0ng1knfhsHo1zV0ng1knfhsHo1zV0ng1knfhsHo1zV0n]],
				["LowerLegF.R"] = [[
					hIg+fj7agAgAwfhIhCfm8TgAgAu7hIhFfp8/gAgAtihIhFfo85gAgAtvhIhDfn8pgAgAuPhOhCfr8Ufag/u1hPhAft8BfMhXvWhMhAfo76fkguvmhIhAfk73
					gAgAvuhIhBfj7qgOgAwEhUhZfl7RiDhlwihjiMfp6clmkdwhhpjJft44ptn8vuhij7fx22tNrEuUhWkZf01KvZtDs/hSkhf10ov/tnsihWkaf01GvdtHs7hZ
					kTf01hu+sqtRhWkZf01JvatEs+hSkhf10ov/tmsjhSkhf10nwAtnsihSkhf10nwAtnsihSkhf10nwAtnsihSkhf10nwAtnsihSkhf10nwAtnsi]],
				["FootF.R"] = [[
					hIgifU/dgAgAl0hIgofU/vgAgAkDhIgufV/5gAgAifhIgtfV/4gAgAiuhIgrfV/0gAgAjShPgofa/ufzhIj9hRgmfc/ofuhkkihNglfY/nf2g1k0hIglfU/n
					gAgAk8hJgmfU/igNf7lVhZg+fX/Viegxl6hvhzfb+jmziNmMh+i2fh80r4kCl/h8jwfm6awQlulYhzkUfq4Yy/m0kvhvkffr3tzwnIkghzkWfq4SzFm2kth1
					kOfp4zydmmk4hzkVfq4XzAm0kuhvkefr3uzvnHkghvkffr3tzxnIkghvkffr3tzxnIkghvkffr3tzxnIkghvkffr3tzxnIkghvkffr3tzxnIkg]],
				Tail1 = [[
					gAiDhKjogAgA/ygAiChTkggAgA/rgAiAhblSgAgA/jgAiAhalKgBgA/kgAiBhXk5gAgA/nf+iBhTkjeGgK/nf9iChRkQdYgQ/mf/iChPkIemgJ/sgAiChPkE
					gAgA/ugAiEhNj4gRgK/wgBiRhLjsgbij/rgDiqhKjihKnB+/gFjDhKjPiDsV9RgGjUhKixizw961gGjdhKiWjRz44vgGjghKiOjZ0t4DgGjehKiVjSz/4pgG
					jchKicjLzU5LgGjehKiWjRz64ugGjghKiOjZ0s4EgGjghKiOjZ0u4CgGjghKiOjZ0u4CgGjghKiOjZ0u4CgGjghKiOjZ0u4CgGjghKiOjZ0u4C]],
				Tail2 = [[
					gAh9hij/gAgA/vgAh7hrk4gAgA/ngAh4hylpgAgA/fgAh4hxligBgA/ggAh5hulQgAgA/jf7h6hrk5dWgQ/gf5h7hokmcVgZ/cf8h8hnkfeCgO/ngAh8hnkb
					gAgA/rgBh+hlkPgYgJ/tgCiMhjkFglii/ogGilhij6hmm++8gJi/hijei0sN9OgMjThiiyj3wz60gMjehiiLkezr4ugNjhhih+kp0f4DgMjehiiKkgzy4pgM
					jchiiUkXzI5KgMjehiiLkezt4tgNjhhih+kp0e4EgNjhhih+kp0g4CgNjhhih+kp0g4CgNjhhih+kp0g4CgNjhhih+kp0g4CgNjhhih+kp0g4C]],
				Tail3 = [[
					gAh3h6jzgAgA/wgAhziCksgAgA/pgAhwiJldgAgA/hgAhwiIlWgBgA/igAhxiGlEgAgA/lf3hziCktclgU/df0h0h/kZbTge/Vf5h1h/kTdegR/mgAh1h+kQ
					gAgA/tgBh3h9kEgegJ/ugEiGh7j6gsih/pgJigh6jvh7m7+8gPi8h6jNjYsJ9OgTjSh6iWknwr6zgUjfh6hklVzh4ugUjjh6hUli0U4DgUjgh6hilXzn4pgU
					jdh6hvlNy+5KgUjgh6hklWzi4tgUjjh6hUlh0T4EgUjjh6hTli0V4CgUjjh6hTli0V4CgUjjh6hTli0V4CgUjjh6hTli0V4CgUjjh6hTli0V4C]],
				Tail4 = [[
					gAhyiSepgAgA/9gAhsiafigAgA//gAhnihgUgAgA//gAhoiggMgCgA//gAhqidf6gAgA//fyhsiZflb1ft/tfthuiWfTaPfp/df2huiWfJc6f0/1gAhviWfF
					gAgA/+gChxiVe5gjgO/9gFiAiTeygaim/3gOibiSethJnK/IgWi6iSeWiBsi9UgbjTiRdtiuxL6wgcjjiRdHjH0F4igcjniRc6jN0530gcjjiRdFjH0L4dgc
					jgiRdPjCzh5AgcjjiRdGjH0G4hgcjniRc6jM0331gcjniRc6jN053zgcjniRc6jN053zgcjniRc6jN053zgcjniRc6jN053zgcjniRc6jN053z]],
				Tail5 = [[
					gAh0irYMgAgA/BgAhtizZDgAgA/OgAhni5Z0gAgA/YgAhoi4ZtgCgB/XgAhqi2ZbgAgA/TfshtixZLbQeq+3fkhvitY+ZceN+dfxhwiuYucefD+7gAhwivYn
					gAgA/IgDhzitYcgmgW/EgFiCisYYf/iq+9gPidirYbgBnV+NgYi9iqYWgDs08TgcjYiqYFgCxh5kgdjpipXyf90b3NgcjuipXrf61O2cgdjqipXxf80h3Hgd
					jmipX2f+z33tgdjpipXxf90c3MgcjuipXrf61N2dgcjuipXrf61P2bgcjuipXrf61P2bgcjuipXrf61P2bgcjuipXrf61P2bgcjuipXrf61P2b]],
				["UpperLegB.L"] = [[
					e7hfgu7WekgAwie7hfg18Oekf7u/e7hfg787ekf2tme7hfg680elf3tze7hfg48lekf5uTe7hfgx8Pd+g5u2e8hfgt79dwhTvVe7hfgv72eIgrvoe7hfgy7y
					ekf9vye8hfgx7oezf9wFfDhigv7ugzhRv6fVhrgu7vk2jTu0fvh4gu6+p4lYtAgKiGgu5Yuem2rFgciTgu30xenkprghiXgu3RyVnvpQgciTgu3wxlnmpogY
					iQgu4Kw5ncp9gciTgu3zxfnlprghiXgu3SyUnvpRghiXgu3RyWnvpQghiXgu3RyWnvpQghiXgu3RyWnvpQghiXgu3RyWnvpQghiXgu3RyWnvpQ]],
				["LowerLegB.L"] = [[
					e6g+gdwfgAgA7ae6hAggx/gAgA6de6hCgjzQgAgA5je6hCgjzEgAgA5se6hBgiyogAgA6Ae7hAgcyDfBgm6Ze8hAgZxjepg06se7g/gbxVfSgc64e6g/gfxP
					gAgA69e6g/gfw7gOgG7JfGhDgcw2hXiM7EfghPgaw8j3l+6MgDhigYwonDqT4Ugih5gWvxqCt815g1iMgUu3sDwJz7g6iSgUuisowwzSg2iMgUu0sHwOz2gx
					iIgVvErqvu0Vg1iMgUu2sEwKz6g6iSgUujsnwvzTg6iSgUuisowwzSg6iSgUuisowwzSg6iSgUuisowwzSg6iSgUuisowwzSg6iSgUuisowwzS]],
				["FootB.L"] = [[
					e6gigs/ZgAgAmJe6gjgs/sgAgAkYe6gkgs/3gAgAi0e6gkgs/2gAgAjDe6gkgs/ygAgAjne6gjgn/rfyhIkSe6gjgl/lfthjk3e6gjgo/kf2g1lJe6gjgs/j
					gAgAlRe7gjgs/fgOf5lnfLgngq/Yiigeloftg1gn+ynBhJk+gYhOgj9MsYhrj8g9htgg60xFh5i+hSiFgd4v0Dh4iUhYiNgd4D05h2iIhTiGgd4q0Kh4iThO
					iAge5Mzfh5ichSiGgd4u0Fh4iUhYiNgd4E04h2iJhYiOgd4D06h2iIhYiOgd4D06h2iIhYiOgd4D06h2iIhYiOgd4D06h2iIhYiOgd4D06h2iI]],
				["UpperLegB.R"] = [[
					hFhfgu7WhcgAwihFhfg18OhcgFu/hFhfg787hcgKtmhFhfg680hcgJtzhFhfg48lhcgHuThFheg68Pg2hEu9hEheg679gohavehFheg272hAgxvthFhfgy7y
					hcgDvyhFhggw7mhrgAwFhLh4gv7ZjqhVwDhRingu64nnjhvMhPjbgu5gsYl3tnhEkDgu3bwnnrr1g4kZgu1kzUorqeg0kfgu090Go8qDg4kagu1fzbotqag7
					kVgu19yzogqvg4kZgu1jzWosqdg0kfgu0+0Fo7qDg0kfgu080Go8qCg0kfgu080Go8qCg0kfgu080Go8qCg0kfgu080Go8qCg0kfgu080Go8qC]],
				["LowerLegB.R"] = [[
					hGg+gdwfgAgA7ahGhAggx/gAgA6dhGhCgjzQgAgA5jhGhCgjzEgAgA5shGhBgiyogAgA6AhIhAgmyDfBgm6ZhIg/gnxjepg06shHg/gjxVfSgc64hGg/gfxP
					gAgA69hHhAgdw7gOgG7JhShZgdwwhWiN7IhgiLgbwrjzmB6WhmjHgZwMm3qb4mhfj4gYvOpsuM2ShUkVgXuQrjwg0XhQkdgXt7sGxJzvhUkWgXuOrowl0ShX
					kQgXuerMwE0whUkVgXuQrkwh0WhQkdgXt8sFxIzwhQkdgXt7sGxJzuhQkdgXt7sGxJzuhQkdgXt7sGxJzuhQkdgXt7sGxJzuhQkdgXt7sGxJzu]],
				["FootB.R"] = [[
					hGgigs/ZgAgAmJhGgjgs/sgAgAkYhGgkgs/3gAgAi0hGgkgs/2gAgAjDhGgkgs/ygAgAjnhHgjgx/rfyhIkShHgjgz/lfthjk3hHgjgw/kf2g1lJhGgjgs/j
					gAgAlRhIgkgr/fgOf5lohWg+gr/Xiigelvhshygo+vnBhNlSh6izgm9HsWh5kdh5jsgj6vxBiUjohxkPgh4qz/iejDhtkZgh3+01igi5hxkQgh4l0GifjChz
					kIgi5GzbidjLhxkPgh4p0BiejDhtkZgh3/0zigi5htkZgh3+01igi4htkZgh3+01igi4htkZgh3+01igi4htkZgh3+01igi4htkZgh3+01igi4]],
			},
		},
	},
}
