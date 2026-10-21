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
					gAiCguAIgAgAimgAiDguAIgAgAimgAiDguAIgAgAimgAiDguAIgAgAimgAiEguAIgAgAimgAiEguAIgAgAimgAiDguAIgAgAilgAiCguAHgAgAihgAiBguAH
					gAgAidgAh/guAHgAgAiZgAh+guAGgAgAiWgAh+guAGgAgAiUgAh+guAGgAgAiUgAiAguAGgAgAiUgAiBguAGgAgAiUgAiBguAGgAgAiUgAh/guAGgAgAiUgA
					h+guAGgAgAiUgAh+guAGgAgAiUgAiAguAGgAgAiUgAiBguAGgAgAiUgAiBguAGgAgAiUgAh/guAGgAgAiUgAh+guAGgAgAiUgAh+guAGgAgAiUgAiAguAGgA
					gAiUgAiBguAGgAgAiUgAiBguAGgAgAiUgAiAguAGgAgAiUgAh+guAGgAgAiUgAh/guAHgAgAicgAiHguALgAgAjIgAiHguALgAgAjGgAiEguAKgAgAi7gAiD
					guAJgAgAiygAiDguAJgAgAixgAiCguAIgAgAivgAiCguAIgAgAisgAiCguAIgAgAipgAiCguAIgAgAin]],
				Spine1 = [[
					gAiGgYAIgAgAimgAiGgYAIgAgAirgAiHgYAIgAgAiugAiHgYAJgAgAiygAiHgYAJgAgAi0gAiHgYAJgAgAi0gAiHgXAJgAgAixgAiGgXAIgAgAiqgAiEgXAH
					gAgAihgAiDgXAHgAgAiagAiCgXAGgAgAiWgAiBgXAGgAgAiUgAiCgXAHgAgAibgAiDgXAJgAgAixgAiEgXAKgAgAjAgAiEgXAKgAgAi7gAiDgXAIgAgAimgA
					iBgXAGgAgAiWgAiCgXAHgAgAiZgAiDgXAIgAgAiugAiEgXAKgAgAi/gAiEgXAKgAgAi9gAiDgXAIgAgAipgAiBgXAHgAgAiXgAiBgXAHgAgAiYgAiDgXAIgA
					gAirgAiEgXAKgAgAi+gAiEgXAKgAgAi+gAiDgXAIgAgAisgAiBgXAHgAgAiYgAiDgXAHgAgAicgAiLgYAKgAgAjDgAiLgYAKgAgAi+gAiJgYAJgAgAivgAiH
					gYAIgAgAikgAiGgYAHgAgAiigAiGgYAHgAgAihgAiGgYAHgAgAihgAiGgYAHgAgAihgAiGgYAHgAgAij]],
				Spine2 = [[
					gAiKgB/8gAgAhwgAiKgB/8gAgAhngAiLgB/9gAgAhggAiLgB/9gAgAhZgAiLgB/9gAgAhVgAiLgB/9gAgAhUgAiLgB/9gAgAhZgAiJgB/9gAgAhkgAiIgB/8
					gAgAhxgAiGgB/7gAgAh7gAiFgB/7gAgAiBgAiEgB/7gAgAiCgAiFgB/8gAgAh0gAiHgB/+gAgAhJgAiJgB//gAgAgrgAiIgB/+gAgAg1gAiGgB/9gAgAhfgA
					iFgB/7gAgAiAgAiFgB/7gAgAh4gAiHgB/9gAgAhPgAiJgB//gAgAgtgAiIgB/+gAgAgxgAiGgB/9gAgAhZgAiFgB/7gAgAh9gAiFgB/7gAgAh8gAiHgB/9gA
					gAhWgAiIgB/+gAgAgvgAiIgB/+gAgAgugAiHgB/9gAgAhSgAiFgB/7gAgAh6gAiGgB/7gAgAh6gAiQgC/9gAgAhXgAiPgC/9gAgAhhgAiMgB/8gAgAhzgAiK
					gB/7gAgAiAgAiKgB/7gAgAiCgAiKgB/7gAgAiDgAiJgB/7gAgAiBgAiJgB/7gAgAh+gAiJgB/7gAgAh4]],
				Spine3 = [[
					gAiHfr/8gAgAhwgAiIfr/9gAgAhjgAiJfr/9gAgAhXgAiJfr/+gAgAhOgAiJfr/+gAgAhIgAiJfr/+gAgAhGgAiJfr/+gAgAhMgAiHfr/9gAgAhcgAiFfr/8
					gAgAhtgAiDfr/7gAgAh6gAiCfr/7gAgAiBgAiCfr/7gAgAiCgAiDfr/8gAgAhtgAiGfr//gAgAgtgAiIfr//gAgAf/gAiHfr//gAgAgOgAiEfr/+gAgAhNgA
					iCfr/7gAgAh+gAiCfr/8gAgAhzgAiFfr/+gAgAg2gAiIfr//gAgAgCgAiHfr//gAgAgIgAiFfr/+gAgAhEgAiCfr/7gAgAh7gAiCfr/7gAgAh4gAiFfr/+gA
					gAg/gAiHfr//gAgAgGgAiHfr//gAgAgEgAiFfr/+gAgAg7gAiCfr/8gAgAh2gAiEfr/7gAgAh6gAiOfs/9gAgAhbgAiNfs/8gAgAhpgAiKfs/7gAgAh+gAiI
					fs/6gAgAiNgAiHfs/6gAgAiRgAiHfs/6gAgAiQgAiHfr/6gAgAiNgAiHfr/7gAgAiGgAiHfr/7gAgAh9]],
				Neck1 = [[
					gAiFfWAhgAgAlqgAiGfVAigAgAlvgAiHfVAjgAgAlzgAiHfVAkgAgAl3gAiIfVAkgAgAl5gAiIfVAkgAgAl6gAiHfVAigAgAlwgAiFfVAfgAgAlcgAiDfVAb
					gAgAlDgAiBfVAXgAgAkrgAh/fVAUgAgAkZgAh/fVATgAgAkSgAiAfVAWgAgAkngAiFfVAhgAgAlmgAiIfVApgAgAmUgAiHfVAmgAgAmEgAiCfVAbgAgAlHgA
					h/fVAUgAgAkWgAiAfVAVgAgAkhgAiEfVAfgAgAldgAiIfVApgAgAmRgAiHfVAngAgAmKgAiDfVAdgAgAlQgAh/fVAUgAgAkZgAiAfVAVgAgAkcgAiDfVAdgA
					gAlUgAiHfVAogAgAmMgAiHfVAogAgAmPgAiEfVAegAgAlZgAiAfVAVgAgAkegAiBfWAYgAgAk0gAiMfWA9f7fXnogAiLfWA6f7fTnegAiHfWAvf/f2mvgAiF
					fWAngCgKmJgAiEfWAmgDgPmDgAiEfWAlgBgIl9gAiEfWAjgAf9l1gAiEfWAif/f8ltgAiEfWAhgAf/lo]],
				Neck2 = [[
					gAiTevCBgAgArHgAiUevB/gAgArEgAiVevB+gAgArBgAiWevB+gAgAq/gAiXevB9gAgAq+gAiXevB9gAgAq9gAiWevB5gAgAqygAiTevBwgAgAqZgAiQeuBl
					gAgAp4gAiNeuBagAgApWgAiLeuBSgAgAo7gAiKeuBPgAgAovgAiMeuBVgAgApDgAiTevBogAgAqAgAiYevB3gAgAqsgAiWevBxgAgAqdgAiPeuBegAgApigA
					iKeuBQgAgAoygAiLeuBTgAgAo9gAiSevBlgAgAp3gAiXevB2gAgAqpgAiXevBzgAgAqigAiQeuBhgAgApqgAiLeuBRgAgAo2gAiLeuBRgAgAo4gAiRevBigA
					gApvgAiXevB0gAgAqlgAiXevB1gAgAqngAiRevBjgAgApzgAiLeuBSgAgAo6gAiNeuBggAgApogCifexDhfpewuggCidexDffneouagAiYewC8f6futWgAiU
					ewCigHgTsdf/iTewCfgKgesVgAiTevCagFgPsJgAiSevCTf+f7r2gAiSevCKf9f4rhgAiSevCEf/f+rQ]],
				Neck3 = [[
					gAiqeUCCgAgArLgAireUB+gAgArAgAiseUB6gAgAq2gAiteUB3gAgAqugAiteUB2gAgAqpgAiteUB1gAgAqngAiseUBwgAgAqagAipeTBmgAgAp8gAikeSBZ
					gAgApSgAigeRBMgAgAolgAideQBCgAgAoAgAiceQA9gAgAnugAifeQBCgAgAoCgAioeSBTgAgAo/gAiueUBhgAgAprgAiseUBcgAgApdgAijeRBLgAgAohgA
					ideQA+gAgAnxgAieeQBBgAgAn8gAimeSBRgAgAo2gAiteUBggAgAppgAiseUBegAgApigAileSBNgAgAopgAideQA/gAgAn0gAieeQBAgAgAn2gAileSBOgA
					gAougAiteUBfgAgAplgAiteUBfgAgApngAimeSBQgAgAoygAieeQBAgAgAn5gAiheRBUgAgApAgEi7edEZfgeIwCgEi6ecEYfdd9v/gBizeZDif4fkukf/it
					eXC9gJgdtXf/iseXC4gOgttNf/iseWCwgHgWs8gAireWCjf9f4segAiqeVCVf8f0r8gAipeVCJf/f9rd]],
				Head = [[
					gAjOdr/5gAgAidgAjPdq/4gBf4ipgAjPdq/3gCfwizgAjQdq/2gDfoi8gAjQdp/2gEfhjBgAjQdp/1gFfbjDgAjOdo/zgOfajZgAjJdn/tggfgkIgAjDdk/k
					g3fqlHgAi9di/XhPf0mKgAi4dg/Lhif8nAgAi2df/Fhrf/nZgAi6dg/KhrgAnBgAjFdk/ahrgEl2gAjNdn/jhrgHlAgAjLdm/ghrgGlSgAjAdi/ShrgCmcgA
					i3dg/Ghrf/nWgAi5dg/JhrgAnJgAjEdk/YhrgEmBgAjNdn/ihrgHlDgAjMdn/hhrgHlLgAjBdj/UhrgDmRgAi3dg/Hhrf/nRgAi4dg/HhrgAnPgAjCdj/Whr
					gDmMgAjMdn/ihrgHlIgAjNdn/ihrgHlGgAjDdj/XhrgDmGgAi4dg/IhrgAnMgAi/dj/ehbgMllgIjreC/efjisa/gJjpeB/fffi3bIgCjfd5/3fvhKdcf+jX
					dz//f5gLfXf9jWdz//f8f2fmf+jUdx//f7gIgAgBjSdv/+f6gggsgBjQdt/9f8gdhdgAjOds/7f+gLiG]],
				Jaw = [[
					gAiZdi/pgAgAkpgAiadi/ogCf4k0gAiadi/mgDfwk/gAiadi/lgFfolHgAibdi/kgGfhlMgAibdi/jgIfblOgAiYdi/igQfblVgBiTdj/fghfhlkgDiNdk/b
					g4frl5gEiHdl/VhPf1mSgFiDdm/Qhif7mpgGiBdn/Nhrf9m0gGiFdn/KhrgAnDgGiQdm/AhrgLnsgGiYdm+4hqgSoKgGiVdm+7hqgPoAgGiKdm/FhrgFnXgG
					iCdn/Mhrf+m3gGiEdn/Lhrf/m+gGiOdm/ChrgJnmgGiYdm+5hqgRoIgGiWdm+6hqgQoEgGiMdm/EhrgHndgGiCdn/Mhrf+m6gGiDdn/Mhrf+m7gGiNdm/Dhr
					gInggGiXdm+6hqgRoFgGiXdm+5hqgRoHgGiOdm/ChrgInjgGiDdn/Lhrf/m9gFiKdk/bhbgNlzgLjAdi/3fKimfugMi+di/3fEiwfygDiwdg/8fmhIhQf+il
					dg/5f4gLidf8ijdg/4f9f2imf+iidg/3f7gHi4gBifdg/0f4gfjVgBicdh/wf5gdj4gAiadh/sf+gLkW]],
				["Lid.L"] = [[
					e0jxdbdCA3e6mje0jxdadAA4fImqe0jydadMA2gXmqe0jydadLA4ggmxe0jydac7A8fim+e0jydbc7A9flnEezjvdZdMA7g1m+ezjodWdxA/jimmeyjfdRei
					BcnGmAeyjVdMfTCUqnlWexjOdJf5DStPkzexjKdHgKD0ubkjexjPdJgODquHkiexjcdOgZDJtCkhexjldSghCzsQkgexjidRgeC7shkhexjVdLgTDZtkkiex
					jLdHgLDzuZkiexjNdIgNDtuNkiexjadNgXDOtMkhexjldSggC1sTkgexjjdRgfC4sakhexjXdMgVDVtbkhexjMdIgMDxuVkiexjMdIgMDwuTkiexjYdMgWDS
					tWkhexjkdSgfC3sYkhexjkdSggC2sVkgexjZdNgWDQtRkhexjNdIgMDvuQkieyjXdNfjCFqKk+fAkVd3d7ElQjlUfBkUd2d9D6Rsk/e4kHdvddCQWYmNeyj9
					dpdHBpZRm6exj7dqdGBmZznLezj6dmdIBYaim2e1j3dhdIBFbymWe2j0dddGA5dMmRe1jxdbdEA2eXmb]],
				["Lid.R"] = [[
					hMjxdbdC/JhGmjhMjxdZdA/Mg6mZhMjydYdL/RfsmJhLjydXdJ/SflmBhLjydWc6/QglmBhLjydVc6/Sgjl6hLjwdTc4/TfWlxhKjsdQc1/KculmhJjmdMcz
					+oZRlchJjgdIc29sV2lVhIjcdFc68tTRlShIjadDc88KSHlRhIjedFdA8USblThIjsdMdN8zTglahIj1dRdW9IUSlfhIjydPdT9CUBldhIjldIdH8kS+lXhI
					jadEc98LSJlRhIjddFc/8RSVlShIjqdLdL8vTWlZhIj0dRdW9HUPlehIjzdQdU9EUIlehIjndJdI8pTHlYhIjbdEc98NSNlShIjcdEc+8OSPlShIjodKdJ8r
					TMlYhIj0dQdV9FUKlehIj0dQdV9GUNlehIjpdKdK8tTRlZhIjcdEc+8QSSlShJjldMc19xWVlwhVkNePc86SunqfhWkLePdO65tcqjhPkEd6dc9TpSohhKj8
					drdR+TmqnShJj7dodR+fmNm7hKj5dndO+mlanGhNj2dmdK+vkHnWhNjzdidH+7itnKhMjxdddF/Fhnmx]],
				["UpperLegF.L"] = [[
					e8hTfXzaXvfp4De8hUfXzhX1fv3/e8hVfWzpX7f137e8hWfVzxYAf632e8hWfVz3YCf+3ye8hWfVz4YDf/3xe8hWfVzpYAf338e8hUfWzNX4fm4Qe8hRfXyz
					XufU4he8hPfYygXnfE4se8hOfYyVXje64ye8hNfYyRXhe241e8hPfXyPXse946e8hTfUycYKfX47e8hWfSy/Yffu4oe8hVfSywYYfl4we8hRfVyRX7fK4+e8
					hOfYyQXje342e8hOfXyPXpe745e8hTfUyYYGfT48e8hWfSy8Ydfs4qe8hWfSy1Yafo4ue8hSfVyUYAfN4+e8hOfYyQXle443e8hOfYyPXme544e8hSfVyVYC
					fP49e8hWfSy4Ycfq4se8hWfSy6Ydfr4re8hSfUyXYEfR49e8hOfXyPXoe644e8hQfYylXnfH4oe8hafW2tYBhF1Ce8hZfX1xX5gt1/e8hWfY0bXtgG3Le8hT
					fZzyXjfu3qe8hTfZztXhfr3ue8hSfZzoXhfo3ye8hSfZzhXifl34e8hSfYzbXkfj3+e8hTfYzXXpfk4D]],
				["LowerLegF.L"] = [[
					etgzfc9VcugpsUeug0fb9CcygdtCeug0fa8vc2gStseug1fZ8ec4gIuPevg1fZ8Sc6gBunevg1fZ8Pc6f/uueug1fa8lc5gMuCeugzfc9Nc2glsoetgyfd90
					cug/rEesgwff+QclhSpvesgvff+ecfhdo7esguff+jcdhhopesgwff+TcphUpnetgzfb9OdHgmssevg2fY8CdUf5vLeug1fZ8fdRgJuTetgyfd90c6g/rIes
					gvff+hcfhfo0esgvff+YcmhYpUetgzfc9ZdDgtsPeug2fY8IdTf8u/eug1fZ8UdSgDunetgyfd9qc+g4rkesgvff+echhdo+esgvff+ccjhcpFetgyfc9ldA
					g0ryeug2fZ8QdSgBuweug2fZ8MdTf/u4etgzfc9fdCgxsAesgvff+ackhapMesgwfe+McmhQp6eyg4fS5YcVeWzDewg3fV6zcffHxGevg1fa8lcmgIt9etgz
					fc9bcigrsEetgyfd9ichgwrwetgyfd9mchgzrletgyfd9pcig2rdetgyfd9pclg2rfetgyfd9jcpgyrw]],
				["FootF.L"] = [[
					esgifL/vgDgAkCesgifL/vgEf/kCesgifL/vgEf/kCesgifL/vgEgAkCesgifL/vgDgAkCesgifL/vgDgAkCesgifL/vgGf/kCesgifL/vgJf/kCesgifL/v
					gJf/kCesgifL/vgFf/kCesgifL/vgCgAkCesgifL/vgBgAkCesgifL/vgKf/kCesgifL/vgaf9kCesgifL/vgaf9kCesgifL/vgbf9kCesgifL/vgUf9kCes
					gifL/vgDgAkCesgifL/vgHf/kCesgifL/vgZf9kCesgifL/vgaf9kCesgifL/vgbf9kCesgifL/vgWf9kCesgifL/vgEf/kCesgifL/vgFf/kCesgifL/vgX
					f9kCesgifL/vgbf9kCesgifL/vgaf9kCesgifL/vgYf9kCesgifL/vgGf/kCesgifL/vgFf/kCesgifL/ue8gJkCesgifL/ufXgFkCesgifL/vfygCkCesgi
					fL/vf5gBkCesgifL/vf5gBkCesgifL/vf6gBkCesgifL/vf7gBkCesgifL/vf+gAkCesgifL/vgBgAkC]],
				["UpperLegF.R"] = [[
					hEhTfXzaoRgX4DhEhUfXzhoLgR3/hEhVfWzpoFgL37hEhWfVzxoAgG32hEhWfVz3n+gC3yhEhWfVz4n9gB3xhEhWfVzpoAgJ38hEhUfWzNoIga4QhEhRfXyz
					oSgs4hhEhPfYygoZg84shEhOfYyVodhG4yhEhNfYyRofhK41hEhPfXyPoUhD46hEhTfUycn2gp47hEhWfSy/nhgS4ohEhVfSywnogb4whEhRfVyRoFg24+hE
					hOfYyQodhJ42hEhOfXyPoXhF45hEhTfUyYn6gt48hEhWfSy8njgU4qhEhWfSy1nmgY4uhEhSfVyUoAgz4+hEhOfYyQobhI43hEhOfYyPoahH44hEhSfVyVn+
					gx49hEhWfSy4nkgW4shEhWfSy6njgV4rhEhSfUyXn8gv49hEhOfXyPoYhG44hEhQfYyloZg54ohEhafW2tn/e71ChEhZfX1xoHfT1/hEhWfY0boTf63LhEhT
					fZzyodgS3qhEhTfZztofgV3uhEhSfZzoofgY3yhEhSfZzhoegb34hEhSfYzbocgd3+hEhTfYzXoXgc4D]],
				["LowerLegF.R"] = [[
					hTgzfc9VjSfXsUhSg0fb9CjOfjtChSg0fa8vjKfutshSg1fZ8ejIf4uPhRg1fZ8SjGf/unhRg1fZ8PjGgBuuhSg1fa8ljHf0uChSgzfc9NjKfbsohTgyfd90
					jSfBrEhUgwff+QjbeupvhUgvff+ejhejo7hUguff+jjjefophUgwff+TjXespnhTgzfb9Oi5fasshRg2fY8CisgHvLhSg1fZ8fivf3uThTgyfd90jGfBrIhU
					gvff+hjheho0hUgvff+YjaeopUhTgzfc9Zi9fTsPhSg2fY8IitgEu/hSg1fZ8Uiuf9unhTgyfd9qjCfIrkhUgvff+ejfejo+hUgvff+cjdekpFhTgyfc9ljA
					fMryhSg2fZ8Qiuf/uwhSg2fZ8MitgBu4hTgzfc9fi+fPsAhUgvff+ajcempMhUgwfe+Mjaewp6hOg4fS5YjrhqzDhQg3fV6zjhg5xGhRg1fa8ljaf4t9hTgz
					fc9bjefVsEhTgyfd9ijffQrwhTgyfd9mjffNrlhTgyfd9pjefKrdhTgyfd9pjbfKrfhTgyfd9jjXfOrw]],
				["FootF.R"] = [[
					hUgifL/vf9gAkChUgifL/vf8gBkChUgifL/vf8gBkChUgifL/vf8gAkChUgifL/vf9gAkChUgifL/vf9gAkChUgifL/vf6gBkChUgifL/vf3gBkChUgifL/v
					f3gBkChUgifL/vf7gBkChUgifL/vf+gAkChUgifL/vf/gAkChUgifL/vf2gBkChUgifL/vfmgDkChUgifL/vfmgDkChUgifL/vflgDkChUgifL/vfsgDkChU
					gifL/vf9gAkChUgifL/vf5gBkChUgifL/vfngDkChUgifL/vfmgDkChUgifL/vflgDkChUgifL/vfqgDkChUgifL/vf8gBkChUgifL/vf7gBkChUgifL/vfp
					gDkChUgifL/vflgDkChUgifL/vfmgDkChUgifL/vfogDkChUgifL/vf6gBkChUgifL/vf7gBkChUgifL/uhEf3kChUgifL/ugpf7kChUgifL/vgOf+kChUgi
					fL/vgHf/kChUgifL/vgHf/kChUgifL/vgGf/kChUgifL/vgFf/kChUgifL/vgCgAkChUgifL/vf/gAkC]],
				Tail1 = [[
					gAh6hUjdgAgA/zgAh6hUjdgOf+/zgAh7hUjdgbf8/zgAh7hUjdgof6/zgAh7hUjdg0f5/ygAh7hUjdg+f3/ygAh7hUjchBf3/ygAh6hUjZg6f4/zgAh4hVjV
					gqf6/zgAh3hVjQgXf9/0gAh2hVjNgHf//1gAh2hVjMgAgA/1gAh3hVjMgAgA/1gAh4hVjMgAgA/1gAh5hVjMgAgA/1gAh5hVjMgAgA/1gAh3hVjMgAgA/1gA
					h2hVjMgAgA/1gAh2hVjMgAgA/1gAh4hVjMgAgA/1gAh5hVjMgAgA/1gAh5hVjMgAgA/1gAh4hVjMgAgA/1gAh2hVjMgAgA/1gAh2hVjMgAgA/1gAh4hVjMgA
					gA/1gAh5hVjMgAgA/1gAh5hVjMgAgA/1gAh4hVjMgAgA/1gAh2hVjMgAgA/1gAh3hVjbfkgE/zgAh9hUkxdkgY/igAh9hUktesgN/ngAh7hUkRfdgF/sgAh6
					hUj6fbgF/vgAh6hUj3fXgG/wgAh6hUjzfMgI/wgAh5hUjsfLgI/xgAh5hUjlfcgF/ygAh5hUjffwgC/z]],
				Tail2 = [[
					gAh0htjpfVgG/xgAh1htjpfwgC/ygBh1htjpgLf+/ygBh1htjpglf6/xgBh2htjpg/f3/xgCh2htjphXfz/wgCh1htjnhkfx/vgBh0htjkhefy/wgBhzhtjg
					hIf1/xgBhyhtjcgpf6/zgAhxhtjZgOf+/zgAhxhtjXgAgA/0gAhyhtjXgAgA/0gAhzhtjXgAgA/0gAh0htjXgAgA/0gAh0htjXgAgA/0gAhyhtjXgAgA/0gA
					hxhtjXgAgA/0gAhxhtjXgAgA/0gAhzhtjXgAgA/0gAh0htjXgAgA/0gAh0htjXgAgA/0gAhzhtjXgAgA/0gAhxhtjXgAgA/0gAhxhtjXgAgA/0gAhzhtjXgA
					gA/0gAh0htjXgAgA/0gAh0htjXgAgA/0gAhzhtjXgAgA/0gAhxhtjXgAgA/0f/hyhtjvfJgJ/wf8h2hsltbOgx/Gf+h1hslndWgb/Yf/h0htk7ewgM/lf/h0
					htkXemgO/qf/h0htkSeYgQ/qf/h0htkLd8gU/pf/h0htkAd2gV/qf/h0htj1eSgQ/tgAh0htjse5gL/w]],
				Tail3 = [[
					f/hviGj4eLgS/sgAhviGj4eugN/ugBhviGj4fSgH/vgChwiGj4f4gB/wgDhwiGj4gef7/wgEhwiGj4hEf1/vgEhwiGj3hffx/ugEhviGj0hkfw/ugDhuiGjv
					hTfz/vgChtiGjrgzf4/xgBhsiGjogSf9/ygAhsiGjngBgA/ygAhsiGjngAgA/ygAhuiGjngAgA/ygAhviGjngAgA/ygAhviGjngAgA/ygAhtiGjngAgA/ygA
					hsiGjngAgA/ygAhsiGjngAgA/ygAhuiGjngAgA/ygAhviGjngAgA/ygAhviGjngAgA/ygAhtiGjngAgA/ygAhsiGjngAgA/ygAhsiGjngAgA/ygAhtiGjngA
					gA/ygAhviGjngAgA/ygAhviGjngAgA/ygAhuiGjngAgA/ygAhsiGjngAgA/yf+hsiGkGeygN/tf1htiDmqZRhJ+if6htiEmkcTgo/Ff9htiFlpeQgS/cf9ht
					iFk3d3gW/if9htiFkwdYgb/hf8htiFkmclgj/ef7htiFkXcSgl/ef8huiGkIc0gg/jf+huiGj8dmgY/p]],
				Tail4 = [[
					f8hoiejSczgd/qf+hpiejTdXgX/tgAhpifjTeAgS/wgChqifjTesgM/ygEhqiejTfagF/0gFhqiejTgJf//0gGhpiejSg0f5/0gGhpiejOhLf1/zgFhoifjK
					hIf2/0gDhnifjGgxf5/1gBhmifjDgSf9/2gAhmifjCgBgA/2gAhnifjBgAgA/2gAhoifjBgAgA/2gAhpifjBgAgA/2gAhpifjBgAgA/2gAhnifjBgAgA/2gA
					hmifjBgAgA/2gAhmifjBgAgA/2gAhoifjBgAgA/2gAhpifjBgAgA/2gAhpifjBgAgA/2gAhoifjBgAgA/2gAhmifjBgAgA/2gAhmifjBgAgA/2gAhoifjBgA
					gA/2gAhpifjBgAgA/2gAhpifjBgAgA/2gAhoifjBgAgA/2gAhmifjBgAgA/2f8hmiejoeigO/wfrhiiYm1X4hT+Jf0hiiamubygs+/f7hkicljePgS/df6hl
					idkkdhgX/kf5hlidkacsge/gf2hmidkNbagp/Xf2hmidj6a1gu/Uf4hniejmbWgp/cf6hoiejXcMgi/l]],
				Tail5 = [[
					f3hji3hybiga/nf6hki3hycCgX/sf9hki3hzcogU/wgAhki3hzdTgQ/0gDhli3hzeDgL/4gFhli3hze2gH/6gIhki3hyfsgC/8gIhki3hvgYf+/8gHhji3hq
					gqf8/8gEhii4hmgkf9/8gBhhi4hjgPf+/9gAhhi4higBgA/9gAhii4hhgAgA/9gAhji4hhgAgA/9gAhli4hhgAgA/9gAhki4hhgAgA/9gAhji4hhgAgA/9gA
					hhi4hhgAgA/9gAhii4hhgAgA/9gAhji4hhgAgA/9gAhki4hhgAgA/9gAhki4hhgAgA/9gAhji4hhgAgA/9gAhhi4hhgAgA/9gAhii4hhgAgA/9gAhji4hhgA
					gA/9gAhki4hhgAgA/9gAhki4hhgAgA/9gAhji4hhgAgA/9gAhii4hhgAgA/9f6hgi3iQeXgL/3fghYirmKXIhH+FfuhYixl/b8gl/Kf4hbi0kje3gN/pf2he
					i1jWdygQ/vfzhei1jLcjgW/pfvhfi0i7augg/afuhgi0ijZxgl/Rfwhhi1iLaLgi/Yf0hji2h5bAgd/i]],
				["UpperLegB.L"] = [[
					e8hUg13eV3gGzOe8hVg13YV/gLzZe8hVg13TWGgQzje8hVg13OWMgUzse8hWg13LWQgXzye8hWg13KWRgYzze8hVg13TWGgRzje8hUg13lVvgDzCe8hTg132
					VWfzyde8hRg14EVBfmx+e8hQg14NUzfexqe8hQg24QUufbxie8hRg24MU1fgxse8hSg23+VMfvyNe8hTg23yVef8yoe8hTg232VYf4yee8hRg24FVAfnx8e8
					hQg24PUvfbxje8hQg24NUzfexpe8hSg24AVJftyIe8hTg23zVdf7yme8hTg231Vaf5yie8hSg24DVEfqyBe8hQg24PUwfcxle8hQg24OUxfdxme8hSg24CVF
					fryDe8hTg230Vcf6yje8hTg230Vcf7yle8hSg24BVHfsyGe8hQg24OUyfdxoe8hSg14CVFfnyEe8hZgz07Yghq28e8hYgz1xXuhL15e8hWg020Wpgg0Ye8hV
					g03TWFgLzje8hVg03XV/gIzbe8hUg03aV7gGzVe8hUg03eV2gDzNe8hUg13hVzgCzIe8hUg13iVygDzH]],
				["LowerLegB.L"] = [[
					evg2grwrd+gI7Oevg2gsw9d2gG7Cevg2gsxOdvgD63evg2gsxcdogB6tevg2gtxldkf/6nevg2gtxodjf+6levg2gsxQdugD62evg2grwfeDgM7Weug1gqvp
					eagU73eug0gpu8etga8Qeug0goufe4gd8getg0gouUe8ge8leug0goume1gd8ceug1gpvfeegY78eug1gqwMeLgT7ieug1gqv8eRgV7reug0gpvCeqgb8Net
					g0gouXe7ge8keug0gouge3gd8feug1gpvXehgZ8Beug1gqwJeMgT7keug1gqwCePgU7oeug1gpvKemga8Ieug0gouae6ge8ieug0gouce5ge8heug1gpvOel
					ga8Geug1gqwEeOgU7meug1gqwHeNgU7leug1gpvTejgZ8Deug0gouee4gd8geug0gpu/ergY8Oezg4g01qbTet3Cexg3gx0HcPfM4kewg3gtx/dXfy6Uevg2
					grw4d5gC7Gevg2grwtd9gE7Nevg2grwmeAgG7Revg2grweeEgI7Wevg2grwaeFgK7Zevg2grweeEgK7X]],
				["FootB.L"] = [[
					esgig1/uf9gAkKesgig1/uf2gBkKesgig1/ufwgCkKesgig1/ufqgDkKesgig1/tfmgDkKesgig1/tflgEkKesgig1/ufvgCkKesgig1/ugCgAkKesgig1/u
					gVf9kKesgig1/tglf7kKesgig1/tguf6kKesgig1/tgxf6kKesgig1/tgsf6kKesgig1/tgaf9kKesgig1/ugMf+kKesgig1/ugRf+kKesgig1/tgjf7kKes
					gig1/tgwf6kKesgig1/tgtf6kKesgig1/tgdf8kKesgig1/ugNf+kKesgig1/ugPf+kKesgig1/tghf8kKesgig1/tgvf6kKesgig1/tgvf6kKesgig1/tgg
					f8kKesgig1/ugOf+kKesgig1/ugNf+kKesgig1/tgef8kKesgig1/tguf6kKesgig1/tgjf7kKesgig1/ldNgXkLesgig1/qeMgPkKesgig1/tfVgGkKesgi
					g1/uf1gBkKesgig1/uf5gBkKesgig1/uf9gAkKesgig1/ugAgAkKesgig1/ugCgAkKesgig1/ugBgAkK]],
				["UpperLegB.R"] = [[
					hEhUg13eqJf6zOhEhVg13YqBf1zZhEhVg13Tp6fwzjhEhVg13Op0fszshEhWg13LpwfpzyhEhWg13KpvfozzhEhVg13Tp6fvzjhEhUg13lqRf9zChEhTg132
					qqgNydhEhRg14Eq/gax+hEhQg14NrNgixqhEhQg24QrSglxihEhRg24MrLggxshEhSg23+q0gRyNhEhTg23yqigEyohEhTg232qogIyehEhRg24FrAgZx8hE
					hQg24PrRglxjhEhQg24NrNgixphEhSg24Aq3gTyIhEhTg23zqjgFymhEhTg231qmgHyihEhSg24Dq8gWyBhEhQg24PrQgkxlhEhQg24OrPgjxmhEhSg24Cq7
					gVyDhEhTg230qkgGyjhEhTg230qkgFylhEhSg24Bq5gUyGhEhQg24OrOgjxohEhSg14Cq7gZyEhEhZgz07ngeW28hEhYgz1xoSe115hEhWg020pXfg0YhEhV
					g03Tp7f1zjhEhVg03XqBf4zbhEhUg03aqFf6zVhEhUg03eqKf9zNhEhUg13hqNf+zIhEhUg13iqOf9zH]],
				["LowerLegB.R"] = [[
					hRg2grwriCf47OhRg2gsw9iKf67ChRg2gsxOiRf963hRg2gsxciYf/6thRg2gtxlicgB6nhRg2gtxoidgC6lhRg2gsxQiSf962hRg2grwfh9f07WhSg1gqvp
					hmfs73hSg0gpu8hTfm8QhSg0goufhIfj8ghTg0gouUhEfi8lhSg0goumhLfj8chSg1gpvfhifo78hSg1gqwMh1ft7ihSg1gqv8hvfr7rhSg0gpvChWfl8NhT
					g0gouXhFfi8khSg0goughJfj8fhSg1gpvXhffn8BhSg1gqwJh0ft7khSg1gqwChxfs7ohSg1gpvKhafm8IhSg0gouahGfi8ihSg0gouchHfi8hhSg1gpvOhb
					fm8GhSg1gqwEhyfs7mhSg1gqwHhzfs7lhSg1gpvThdfn8DhSg0gouehIfj8ghSg0gpu/hVfo8OhNg4g01qkthT3ChPg3gx0Hjxg04khQg3gtx/ipgO6UhRg2
					grw4iHf+7GhRg2grwtiDf87NhRg2grwmiAf67RhRg2grweh8f47WhRg2grwah7f27ZhRg2grweh8f27X]],
				["FootB.R"] = [[
					hUgig1/ugDgAkKhUgig1/ugKf/kKhUgig1/ugQf+kKhUgig1/ugWf9kKhUgig1/tgaf9kKhUgig1/tgbf8kKhUgig1/ugRf+kKhUgig1/uf+gAkKhUgig1/u
					frgDkKhUgig1/tfbgFkKhUgig1/tfSgGkKhUgig1/tfPgGkKhUgig1/tfUgGkKhUgig1/tfmgDkKhUgig1/uf0gCkKhUgig1/ufvgCkKhUgig1/tfdgFkKhU
					gig1/tfQgGkKhUgig1/tfTgGkKhUgig1/tfjgEkKhUgig1/ufzgCkKhUgig1/ufxgCkKhUgig1/tffgEkKhUgig1/tfRgGkKhUgig1/tfRgGkKhUgig1/tfg
					gEkKhUgig1/ufygCkKhUgig1/ufzgCkKhUgig1/tfigEkKhUgig1/tfSgGkKhUgig1/tfdgFkKhUgig1/lizfpkLhUgig1/qh0fxkKhUgig1/tgrf6kKhUgi
					g1/ugLf/kKhUgig1/ugHf/kKhUgig1/ugDgAkKhUgig1/ugAgAkKhUgig1/uf+gAkKhUgig1/uf/gAkK]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAh7guAMfLgFjKgAh8guAMfQgdjJgAh+guAMfcgyjJgAiBguAMfrhAjJgAiDguAMf+hHjJgAiDguAMgQhFjKgAiBguAMghg7jKgAh+guAMgtgqjLgAh8guAM
					g1gTjKgAh7guAMg1f7jKgAh8guAMgwfjjJgAh+guAMgkfOjJgAiBguAMgVfAjJgAiDguAMgCe5jJgAiDguAMfwe7jKgAiBguAMfffFjKgAh+guAMfTfWjLgA
					h8guAMfLftjK]],
				Spine1 = [[
					gAiAgYALflgDjKf/iAgYALfogSjJf/iDgYALfugfjJf/iFgYALf2gojJf+iHgYALgAgsjJf/iHgYALgJgrjKf/iFgYALgRgljKf/iDgYALgXgbjLgAiBgYAL
					gbgNjKgAiAgYALgbf9jKgBiAgYALgYfujJgBiDgYALgSfhjJgBiFgYALgKfYjJgCiHgYALgAfUjJgBiHgYALf3fVjKgBiFgYALfvfbjKgBiDgYALfpfljLgA
					iBgYALflfzjK]],
				Spine2 = [[
					gAiEgC/+gAgAhNf/iFgC/+gAf6hNf+iHgC/+gAf1hNf+iKgC/9gBfxhNf9iLgC/9gBfuhNf+iLgC/+gBfuhMf+iKgC/+gBfxhMf/iHgC/+gAf1hMf/iFgC/+
					gAf6hMgAiEgC/+gAgAhNgBiFgC/+gAgGhNgCiHgC/+gAgLhNgCiKgC/9f/gPhNgDiLgC/9f/gShNgCiLgC/+f/gShMgCiKgC/+f/gPhMgBiHgC/+gAgLhMgB
					iFgC/+gAgGhM]],
				Spine3 = [[
					gAiCfs/9flf/hNf/iDfs/9fngChNf+iFfs/9frgFhNf9iIfs/9fygHhNf9iKfs/+f7gJhNf9iKfs/+gEgJhMf+iIfs/+gNgIhMf+iGfs/9gUgHhMf/iDfs/9
					gZgEhMgAiCfs/9gbgBhNgBiDfs/9gZf+hNgCiFfs/9gVf7hNgDiIfs/9gOf5hNgDiKfs/+gFf3hNgDiKfs/+f8f3hMgCiIfs/+fzf4hMgCiGfs/9fsf5hMgB
					iDfs/9fnf8hM]],
				Neck1 = [[
					gAiBfWAigaf7lsf/iCfWAggXfwlhf+iEfWAggQfmljf9iGfWAjgIfflwf9iIfWAmf/fcmDf9iIfWApf2femSf+iHfWAqfufkmXf/iEfWAofoftmPf/iCfWAl
					flf5l+gAiBfWAifmgFlsgBiCfWAgfpgQlhgCiEfWAgfwgaljgDiGfWAjf4ghlwgDiIfWAmgBgkmDgDiIfWApgKgimSgCiHfWAqgSgcmXgBiEfWAogYgTmPgB
					iCfWAlgbgHl+]],
				Neck2 = [[
					gAiPevB2gZf3qqgAiPevBvgRfkqVf/iSevBwgGfTqZf/iVevB5f7fIqyf/iXewCGfwfErUf/iYewCRfofHrxf/iXewCVfifSr6f/iUewCPfgfhrrgAiRevCC
					fhf1rLgAiPevB2fngJqqgAiPevBvfvgcqVgBiSevBwf6gtqZgBiVevB5gFg4qygBiXewCGgQg8rUgBiYewCRgYg5rxgBiXewCVgegur6gBiUewCPgggfrrgA
					iRevCCgfgLrL]],
				Neck3 = [[
					gBileUBsgZf3qNgBileTBjgOfbpvgBineTBlgBfDp0gBireUByf0eyqagAiveVCFfperrOgAiweWCVfheur4gAiveWCafce7sFgAiseWCRfbfRrvgAioeVB+
					fffsrAf/ileUBsfngJqNf/ileTBjfyglpvf/ineTBlf/g9p0f/ireUBygMhOqagAiveVCFgXhVrOgAiweWCVgfhSr4gAiveWCagkhFsFgAiseWCRglgvrvgA
					ioeVB+ghgUrA]],
				Head = [[
					gBjGdo/ugYgBkIgDjFdm/pgMgqkogEjIdn/sf/hQkOgEjNdp/yfxhsjIgEjTds/4flh5h2gEjWdv/6fch1g+gDjVdv/7fYhkg7gBjRdu/6fZhIhugAjLdr/1
					fegmi/f/jGdo/ufof/kIf9jFdm/pf0fWkof8jIdn/sgBewkOf8jNdp/ygPeUjIf8jTds/4gbeHh2f8jWdv/6gkeLg+f9jVdv/7goecg7f/jRdu/6gne4hugA
					jLdr/1gifai/]],
				Jaw = [[
					gDiRdk/ugYgBkGgEiPdl/pgMgqklgFiSdk/sf/hQkMgFiYdi/zfyhsjFgFiedh/4flh5hzgEiidg/6fch1g7gCiidh/7fYhkg4gAiddi/7fZhIhrf/iWdj/2
					fegmi8f9iRdk/ufof/kGf8iPdl/pf0fWklf7iSdk/sgBewkMf7iYdi/zgOeUjFf7iedh/4gbeHhzf8iidg/6gkeLg7f+iidh/7goecg4gAiddi/7gne4hrgB
					iWdj/2gifai8]],
				["Lid.L"] = [[
					e1jmdUdEA0gomae3jkdPc2AthBlte5jodNczAngjlKe7jvdPc3AjfZk0e7j4dUc+AleFkue7j9dZdAAqdNk1e6j8dbc7AtdKlGe4j3dacuAud+lde2jwdXcf
					AxfRl3e0jpdUcVA4gemXexjndVcVBBhDm8evjpdZcjBIgvnleujvdfc8BOfwoIeuj1dmdXBTejodeuj4drdsBWduogevj3dqdyBRdroQexjydldqBHeanxez
					jrdddXA8flnI]],
				["Lid.R"] = [[
					hMjpdUcV/IfimXhPjndVcV+/e9m8hRjpdZcj+4fRnlhSjvdfc8+ygQoIhSj1dmdX+thdodhSj4drds+qiSoghRj3dqdy+viVoQhPjydldq+5hmnxhNjrdddX
					/EgbnIhLjmdUdE/MfYmahJjkdPc2/Te/lthHjodNcz/ZfdlKhFjvdPc3/dgnk0hFj4dUc+/bh7kuhFj9dZdA/Wizk1hGj8dbc7/Ti2lGhIj3dacu/SiCldhK
					jwdXcf/Pgvl3]],
				["UpperLegF.L"] = [[
					e6hRfWpqY+dB9he5hSfVuHX8cn7We5hUfVy5XEdd4Fe5hWfV2TWue509e5hXfV6zWyhIuze5hWfV6aXHhSvpe6hUfV5YXGgyxTe7hRfV2mXLfq02e9hPfV0z
					XSe62qe+hNfWzYXded37e+hOfWyXXqeV4ye/hRfWxzX4ej5Re/hUfWxpYHe95ee/hWfWxiYYfY5oe+hXfWw8Yrfo6Ie9hWfWvkZAfq7De8hUfWt0ZVfm8Ee7
					hSfWp7ZVeT9o]],
				["LowerLegF.L"] = [[
					eqg/fv+0dcihnzeng5fn/hcRj6ghemg2fb/fcBj1e7epg2fQ/fcKibjSexg7fB8Dbwefuseyg5fD7nb8ehvkexg1fG8Hb/euuqeugwfQ+CcLgNqWetgufW+j
					cEgnonetgufa+lb8gnobeugwfd+Ob+gWpqevgyff9bcMf6r8ewg1fg8Ocdfaunewg3fh65cufAw/ewg4fi58dCe7ycewg5fm5ndefNy+evg5fp5eeBfjzPes
					g+fw8Weag/ut]],
				["FootF.L"] = [[
					esgzfa/Tg/fzmgesg3fP/MfsgFnHesg2fD/NfVgKnAesgxe5/YfmgFmNesgnez/lengNk4etgke2/kewf5lBesgie4/te3gJkCesgie8/ufcgFkCesgifB/u
					fcgFkCesgifF/ufTgGkCesgifJ/ufRgGkCesgifN/ufYgFkCesgifS/uffgEkCesgifW/vflgDkCesgifa/vfzgCkCesgife/vgRf+kCesgifj/ug4f5kCes
					gqfh/ghrfulT]],
				["UpperLegF.R"] = [[
					hChNfWzYojhj37hChOfWyXoWhr4yhBhRfWxzoIhd5RhBhUfWxpn5hD5ehBhWfWxinogo5ohChXfWw8nVgY6IhDhWfWvknAgW7DhEhUfWt0mrga8EhFhSfWp7
					mrht9ohGhRfWpqnCi/9hhHhSfVuHoEjZ7WhHhUfVy5o8ij4FhHhWfV2TpShH09hHhXfV6zpOe4uzhHhWfV6ao5euvphGhUfV5Yo6fOxThFhRfV2mo1gW02hD
					hPfV0zouhG2q]],
				["LowerLegF.R"] = [[
					hTgufa+lkEfZobhSgwfd+OkCfqpqhRgyff9bj0gGr8hQg1fg8OjjgmunhQg3fh65jShAw/hQg4fi58i+hFychQg5fm5niigzy+hRg5fp5eh/gdzPhUg+fw8W
					hmfButhWg/fv+0ikdfnzhZg5fn/hjvcGghhag2fb/fj/cLe7hXg2fQ/fj2dljShPg7fB8DkQhhushOg5fD7nkEhfvkhPg1fG8HkBhSuqhSgwfQ+Cj1fzqWhT
					gufW+jj8fZon]],
				["FootF.R"] = [[
					hUgifF/ugtf6kChUgifJ/ugvf6kChUgifN/ugof7kChUgifS/ughf8kChUgifW/vgbf9kChUgifa/vgNf+kChUgife/vfvgCkChUgifj/ufIgHkChUgqfh/g
					eVgSlThUgzfa/TfBgNmghUg3fP/MgUf7nHhUg2fD/Ngrf2nAhUgxe5/Ygaf7mNhUgnez/lhZfzk4hTgke2/khQgHlBhUgie4/thJf3kChUgie8/ugkf7kChU
					gifB/ugkf7kC]],
				Tail1 = [[
					gBhxhUj/g8gu/ugBhyhUjvgpgu/wgCh1hUjmgTgn/ygDh3hUjqf6gc/xgDh5hUj4figN/wgDh5hUkKfNf9/tgCh3hUkXe+fu/rgBh0hUkae3fh/qgAhyhUkQ
					e6fX/rf/hxhUj/fEfS/uf/hyhUjvfXfS/wf+h1hUjmftfZ/yf9h3hUjqgGfk/xf9h5hUj4gefz/wf9h5hUkKgzgD/tf+h3hUkXhCgS/rf/h0hUkahJgf/qgA
					hyhUkQhGgp/r]],
				Tail2 = [[
					gChrhtkYibgg/mgDhshtj3hogl/tgDhvhtjfgpgk/ygDhxhtjbflge/zgChzhtjuekgV/vgBhyhtkNdvgJ/ogAhwhskrdKf+/hf/huhsk5c7fy/df/hshtky
					dEfo/ff+hrhtkYdlfg/mf9hshtj3eYfb/tf9hvhtjffXfc/yf9hxhtjbgbfi/zf+hzhtjuhcfr/vf/hyhtkNiRf3/ogAhwhskri2gC/hgBhuhsk5jFgO/dgB
					hshtkyi8gY/f]],
				Tail3 = [[
					gGhkiFk7kTgL/UgFhmiFkRjOgT/igEhpiGjphxgY/ugChsiGjXgGgZ/0gAhtiFjiebgV/wf+hsiFkHc7gP/kf8hpiEkyb0gJ/Wf7hmiElRbMgD/Lf6hkiElU
					bKf8/Lf6hkiFk7btf1/Uf7hmiFkRcyft/if8hpiGjpePfo/uf+hsiGjXf6fn/0gAhtiFjihlfr/wgChsiFkHjFfx/kgEhpiEkykMf3/WgFhmiElRk0f9/LgG
					hkiElUk2gE/L]],
				Tail4 = [[
					gNhdickqmLf//CgKhgidj/lHgE/UgHhkiejNjcgJ/pgChnieirhWgN/2f9hnieiofGgM/3f5hlidjHc9gJ/sf1hhicj5bLgF/YfzheibklZ+gE/Ffyhcibk4
					ZggD+8fzhdickqZ1gB/Cf2hgidj/a5f8/Uf5hkiejNckf3/pf+hnieireqfz/2gDhnieiog6f0/3gHhlidjHjDf3/sgLhhicj5k1f7/YgNheibklmCf8/FgO
					hcibk4mgf9+8]],
				Tail5 = [[
					gWhWiyjXnugJ+3gShai1i2m9gF/GgMhfi2iClWgE/egEhii3hUjHgD/0f8hji3hBgfgA/+f0hgi1hSdzf5/4fuhbiziAbYfy/lfqhXiyi0Zhfv/MfohUixjX
					Ydfy+5fqhWiyjXYSf3+3fuhai1i2ZDf7/Gf0hfi2iCaqf8/ef8hii3hUc5f9/0gEhji3hBfhgA/+gMhgi1hSiNgH/4gShbiziAkogO/lgWhXiyi0mfgR/MgY
					hUixjXnjgO+5]],
				["UpperLegB.L"] = [[
					e+hKgz7ETHdjq5e+hLg163Tcdcrse+hOg26fUKdutSe+hRg354VHeQvOe9hUg45IWAe1xCe8hVg44eWgfKyQe7hVg33/WgfQy5e6hTg23bWXfYzie6hRg12h
					Wafs0le5hRgz1MW2gR2Je6hRgyzUX1hF4Ie6hTgwvhaSiZ7Re6hVgvuhaTie70e7hVguyeWQg44Ne8hUgu03Tcfr0ve9hRgv3eQ8eQvke+hNgw5xQCc7pve+
					hLgy68RIcloC]],
				["LowerLegB.L"] = [[
					ewg4gZ0ccjf14Xewg4gczydNfz4+evg4ggzudnfw5Fevg4glz/dyfo44evg4gp0Gd4fe4zevg3gszWeQfj5aeug2gtxefAf26yetg0gtu+fzgI8Resgygvsr
					gSgN9XesgxgyrZgLgF95eugxg2r0fMfz9ueyg1hAwCcQfE7aeyg4hBvBcGfL79esg2g0lRgKfk/jeqg3gpgzhzey/6eqg6gdhshsd4/1euhAgUopfneK+vew
					g/gUvsdsfY7x]],
				["FootB.L"] = [[
					esgigd/se4gJkKesgigh/tfTgGkKesgigl/tfkgEkKesgigp/tfngDkKesgigu/tfkgEkKesgigy/uf3gBkKesgig2/tghf8kKesgig6/shKf2kKesgig+/r
					hdf0kKesgihD/shPf2kKesgihH/ugXf9kKetgihL/nd9gPkYetgmhN/gd2gOlJesgvhJ/Ygsf3mKesg2hA/KhYfsnFesg4gz/Igvf1nWesg0go/PfkgGm4es
					gsgg/dfMgKlw]],
				["UpperLegB.R"] = [[
					hHhRgz1MpKfv2JhGhRgyzUoLe74IhGhTgwvhludn7RhGhVgvuhltdi70hFhVguyepwfI4NhEhUgu03skgV0vhDhRgv3evEhwvkhChNgw5xv+jFpvhChLgy68
					u4jboChChKgz7Es5idq5hChLg163skikrshChOg26fr2iStShChRg354q5hwvOhDhUg45IqAhLxChEhVg44epgg2yQhFhVg33/pggwy5hGhTg23bppgozihG
					hRg12hpmgU0l]],
				["LowerLegB.R"] = [[
					hUgxgyrZf1f795hSgxg2r0g0gN9uhOg1hAwCjwg87ahOg4hBvBj6g179hUg2g0lRf2gc/jhWg3gpgzeNhO/6hWg6gdhseUiI/1hShAgUopgZh2+vhQg/gUvs
					iUgo7xhQg4gZ0cjdgL4XhQg4gczyizgN4+hRg4ggzuiZgQ5FhRg4glz/iOgY44hRg4gp0GiIgi4zhRg3gszWhwgd5ahSg2gtxehAgK6yhTg0gtu+gNf48RhU
					gygvsrfufz9X]],
				["FootB.R"] = [[
					hUgihD/sexgKkKhUgihH/ufpgDkKhTgihL/niDfxkYhTgmhN/giKfylJhUgvhJ/YfUgJmKhUg2hA/KeogUnFhUg4gz/IfRgLnWhUg0go/Pgcf6m4hUgsgg/d
					g0f2lwhUgigd/shIf3kKhUgigh/tgtf6kKhUgigl/tgcf8kKhUgigp/tgZf9kKhUgigu/tgcf8kKhUgigy/ugJf/kKhUgig2/tffgEkKhUgig6/se2gKkKhU
					gig+/rejgMkK]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAiNguAEgAgAh1gAiDguADgDgVhhgAh7guAHgEgiiUgAiAguALgDgijHgAiMguAJgCgVi0gAiNguAEgAgAh1gAiDguADf9frhhgAh7guAHf8feiUgAiAguAL
					f9fejHgAiMguAJf+fri0]],
				Spine1 = [[
					gAiQgXAGgAgAiMgAiFgXADgDgVhcf/h+gXAFgEgih6f/iFgYAKgDgii8gAiQgYALgCgVjHgAiQgXAGgAgAiMgAiFgXADf9frhcgBh+gXAFf8feh6gBiFgYAK
					f9fei8gAiQgYALf+frjH]],
				Spine2 = [[
					gAiTgB/8gAgAhzf/iHgB/2gAfri/f/iBgB/3gBfei3f/iJgC/8gCfehmf/iUgC/+gAfrg8gAiTgB/8gAgAhzgBiHgB/2gAgVi/gBiBgB/3f/gii3gBiJgC/8
					f+gihmgBiUgC/+gAgVg8]],
				Spine3 = [[
					gAiQfr/9gAgAhbf/iDfr/1gAfrjEf+h9fs/0gCfejSf+iHfs/8gCfehxf/iTfs/+gAfrgogAiQfr/9gAgAhbgBiDfr/1gAgVjEgCh9fs/0f+gijSgCiHfs/8
					f+gihxgBiTfs/+gAgVgo]],
				Neck1 = [[
					gAiOfVAxgAgAm3f+h/fWAWgFgUkhf9h4fWAPgGghjvf9iEfWAhgGghlof+iSfWA7gFgUnigAiOfVAxgAgAm3gCh/fWAWf7fskhgDh4fWAPf6ffjvgDiEfWAh
					f6fflogCiSfWA7f7fsni]],
				Neck2 = [[
					gAigewC0gAgAtEf9iKeuBrgJgTqKf8iCeuBSgLggo4f8iSevCAgMggrEf9ilexDEgJgTtngAigewC0gAgAtEgDiKeuBrf3ftqKgEiCeuBSf1fgo4gEiSevCA
					f0fgrEgDilexDEf3fttn]],
				Neck3 = [[
					gAi6eYDNgAgAt7f9ifeSBvgJgTqWf7iVeQBMgLggoif7ipeUCAgMggrGf9jAebDbgKgTuXgAi6eYDNgAgAt7gDifeSBvf3ftqWgFiVeQBMf1fgoigFipeUCA
					f0fgrGgDjAebDbf2ftuX]],
				Head = [[
					gAjld2ABgAgAgnf8jBdnAIgAgVdWf5ixdhASf9gib5f6jNdrAEf+gieRf8jsd6ADgBgVhMgAjld2ABgAgAgngEjBdnAIgAfrdWgHixdhASgDfeb5gGjNdrAE
					gCfeeRgEjsd6ADf/frhM]],
				Jaw = [[
					gAizdj/6gAgAiJf8iMde/igBfrlZf5h7dd/QgFfem0f5iZdf/rgFfekef8i7dl/8gBfrhkgAizdj/6gAgAiJgEiMde/if/gVlZgHh7dd/Qf7gim0gHiZdf/r
					f7gikegEi7dl/8f/gVhk]],
				["Lid.L"] = [[
					e0kKdtdrBGb8mzewjkdYc9A7fJm2etjSdQcrA9glm6etjxdfdJBAeQnIewkSdzdvBQbanKe0kKdtdrBGb8mze4jjdVdCAyfGmNe8jSdLcuAvgel3e7jxdadN
					AyeKmGe4kSdwd2BHbXmi]],
				["Lid.R"] = [[
					hMkKdtdr+6kEmzhIjjdVdC/Og6mNhEjSdLcu/Rfil3hFjxdadN/Oh2mGhIkSdwd2+5kpmihMkKdtdr+6kEmzhQjkdYc9/Fg3m2hTjSdQcr/Dfbm6hTjxdfdJ
					/AhwnIhQkSdzdv+wkmnK]],
				["UpperLegF.L"] = [[
					e8hdfWq5aPgC9he6hOfdmRZIbO+Oe5hHff1XUMZvzte5hTfa4VV+dIx9e6hgfV7/WtgfsYe8hdfW7pWkg+tAe+hNfa6vVCgMtue/hHfayQWEd04Oe/hTfVuA
					YRfZ7se+hgfSv9aihq7I]],
				["LowerLegF.L"] = [[
					ewhHfv03eRed4JephDf6/LbSitkqefgvfZ6hYymCQzeog2fN/Ia+ifbNezhIe89Pb8eRsMe1hDe+87bveos5ezg0fD8Zaddjtcergqfg/AaXh2lJevg4fn6f
					c1f9xpe1hCfiwrdGdc7B]],
				["FootF.L"] = [[
					esgvfz/bgwf3l7esg7fj/CejgXnleshAfN9NV3itnyesg9e2+6dUgrnyeug3er/Ge4fqnaexgyeu/EeqfFneetgie0/ldHgUkIesgifJ/qd7gRkBesgife/v
					f3gBkCevgsft+gese/pe]],
				["UpperLegF.R"] = [[
					hEhdfW7ppcfCtAhChNfa6vq+f0tuhBhHfayQp8iM4OhBhTfVuAnvgn7shChgfSv9leeW7IhEhdfWq5lxf+9hhGhOfdmRm4ky+OhHhHff1Xr0mRzthHhTfa4V
					qCi4x9hGhgfV7/pTfhsY]],
				["LowerLegF.R"] = [[
					hLhDe+87kRhYs5hNg0fD8ZljidtchVgqfg/AlpeKlJhRg4fn6fjLgDxphLhCfiwri6ik7BhQhHfv03hvhj4JhXhDf6/LkudTkqhhgvfZ6hnOZ+QzhYg2fN/I
					lCdhbNhNhIe89PkEhvsM]],
				["FootF.R"] = [[
					hPgyeu/EhWg7nehTgie0/li5fskIhUgifJ/qiFfvkBhUgife/vgJf/kChRgsft+ghUhBpehUgvfz/bfQgJl7hUg7fj/ChdfpnlhUhAfN9NqJdTnyhUg9e2+6
					isfVnyhSg3er/GhIgWna]],
				Tail1 = [[
					gAiHhVkdgAgA/rgBh9hVi2frgD/3gBhzhVjPfegF/0gBh3hUlFfegB/lgBiDhUl1frf//dgAiHhVkdgAgA/rf/h9hVi2gVf9/3f/hzhVjPgif7/0f/h3hUlF
					gif//lf/iDhUl1gVgB/d]],
				Tail2 = [[
					gAiAhtmygef+/QgAh4hukJfegF/tgAhuhtjeergN/xgAhvhslteXgH/bgAh6hsnvesgB/BgAiAhtmyfigC/QgAh4hukJgif7/tgAhuhtjehVfz/xgAhvhslt
					hpf5/bgAh6hsnvhUf//B]],
				Tail3 = [[
					gBh1iEpHhVf9+of/hyiGmIfwgG/Zf+hoiGkLeRgT/qf+hmiEl/dbgO/Uf+huiCpBdlgE+mf/h1iEpHergD+ogBhyiGmIgQf6/ZgChoiGkLhvft/qgChmiEl/
					ilfy/UgChuiCpBibf8+m]],
				Tail4 = [[
					gDhniZqPiaf/+Nf/hoienrgegH/Df8hiiekseWgU/mf6hcibldc1gO/Xf7hgiXo4cjgB+if9hniZqPdmgB+NgBhoienrfif5/DgEhiiekshqfs/mgGhcibld
					jLfy/XgFhgiXo4jdf/+i]],
				Tail5 = [[
					gGhYitp2jfgN+PgAhci0oVhegO+2f5hai3k9e5gW/lf1hUizkbcsgH/gf1hTisnebzfy+0f6hYitp2chfz+PgAhci0oVeify+2gHhai3k9hHfq/lgLhUizkb
					jUf5/ggLhTisnekNgO+0]],
				["UpperLegB.L"] = [[
					e8hgg36uWOhjuie8hVg55cWXhMwye8hNg45QUFeWvhe8hSg2zxXrgK3ue8heg2uobIh679e8hgg3taaviA8ge8hVg2ypT/fu3De8hNgz1HO9dDwre8hSgx6t
					Psb5lKe8hegz6hVPgvuR]],
				["LowerLegB.L"] = [[
					e1hEgj71aOfeurezg4gq6haKeyw2etg0gmuWfkge8levgyg5s9epe19Me1hBhIvBc7en8CezhFhMt2cYes8lepg4g4d5ikeE/wekg4gkZVk/bI+fevhNgRsx
					evfM9SezhEge7xZMetuS]],
				["FootB.L"] = [[
					exgygW+vcvfjoMetgkgg/WcSgQlIesgigz/shNf2kKesgihI/tfVgGkKewgvhU9ud9fArneug0hZ+mdlf7pBesg7hO+/hhfonzeshAg4+zhsfiocesg9gh++
					fygEoBetgygQ+1azhAmq]],
				["UpperLegB.R"] = [[
					hEhgg3talReA8ghEhVg2ypsBgS3DhEhNgz1HxDi9wrhEhSgx6twUkHlKhEhegz6hqxfRuRhEhgg36upyeduihEhVg55cppe0wyhEhNg45Qr7hqvhhEhSg2zx
					oVf23uhEheg2uok4eG79]],
				["LowerLegB.R"] = [[
					hNhFhMt2johU8lhXg4g4d5dch8/whcg4gkZVbBk4+fhRhNgRsxhRg09ShNhEge7xm0hTuShLhEgj71lygiurhNg4gq6hl2hOw2hTg0gmuWgcfi8lhRgyg5s9
					hXhL9MhLhBhIvBjFhZ8C]],
				["FootB.R"] = [[
					hSg0hZ+mibgFpBhUg7hO+/efgYnzhUhAg4+zeUgeochUg9gh++gOf8oBhTgygQ+1lNfAmqhPgygW+vjRgdoMhTgkgg/WjufwlIhUgigz/sezgKkKhUgihI/t
					grf6kKhQgvhU9uiDhArn]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAiCguALgAgAjKgAiCguALf7fzjKgAiBguAMftfSjKgAh/guANfaekjLgAh9guAQfId4jMgAh8guATe8dbjNgAh8guATe8dbjNgAiBguALgKgcjKgAiCguAX
					hRjNjPgAiCguAchfjxjRgAiCguAchfjxjRgAiCguAchfjwjRgAiCguAYhUjVjPgAiCguASg9ibjNgAiCguANgihWjLgAiCguALgLgcjKgAiCguALgAgBjKgA
					iCguALgAgAjKgAiCguALgAgAjK]],
				Spine1 = [[
					gAiHgYALgAgAjKgAiGgYALf6fwjKgBiFgYAMfrfDjKgCiDgYAPfXeIjLgDiCgYAUfEdPjNgDiBgYAYe3cojOgDiBgYAYe3cojOf/iFgYALgLgjjKf8iHgYAf
					hXkJjQf7iHgYAmhmk4jSf7iHgYAmhmk4jSf7iHgYAmhlk2jSf8iHgYAghakTjQf9iHgYAWhCjJjNf+iHgYAOglhwjLf/iHgYALgMgljKgAiHgYALgAgBjKgA
					iHgYALgAgAjKgAiHgYALgAgAjK]],
				Spine2 = [[
					gAiLgC/+gAgAhNgBiLgC/9gDgVhNgCiJgC/8gMhNhMgEiIgC/4gXiZhKgHiGgC/xghjihIgIiFgC/rgpkThFgIiFgC/rgpkShFf/iKgC/9f6fUhMf2iMgD/i
					fRayhCf1iMgD/XfJZ3g+f1iMgD/XfJZ3g+f1iMgD/YfJZ5g+f2iMgD/gfPalhBf5iLgC/ufccChGf8iLgC/5fsdzhLf/iLgC/9f5fShMgAiLgC/+gAf/hNgA
					iLgC/+gAgAhNgAiLgC/+gAgAhN]],
				Spine3 = [[
					gAiKfs/+gAgAhNgBiJfs/9gDgZhNgEiIfs/8gLhchMgIiGfs/1gWi1hKgLiFft/sggkMhGgOiEft/kgnlFhEgOiEft/kgmlFhEf+iIfs/9f6fMhMfviLfu/X
					fTZ2hAfsiLfv/JfMYyg7fsiLfv/JfMYyg7fsiLfv/JfMYzg7fuiLfu/UfRZng+fziKft/ofebVhFf5iKfs/3ftdahKf+iKfs/9f6fJhMgAiKfs/+gAf+hNgA
					iKfs/+gAgAhNgAiKfs/+gAgAhN]],
				Neck1 = [[
					gAiIfWAhgAgAlqgCiHfWAgf6f1llgGiGfWAffrfYlXgMiFfWAdfaevlGgRiDfXAdfLeIk2gViDfYAdfCdtkrgViDfYAdfCdtkrf9iGfWAfgQgylbfniJfaA1
					hrkBlvfiiKfbA9h+kulwfiiKfbA9h+kulwfjiKfbA9h+ktlwfmiJfaA3hwkLlvftiJfYAthSjDltf1iIfWAlgthslrf8iIfWAigPgklqgAiIfWAhgAgBlqgA
					iIfWAhgAgAlqgAiIfWAhgAgAlq]],
				Neck2 = [[
					gAiWevB0gAgAqmgCiVevBxf9gCqcgHiUevBof2gIqBgPiSewBdfygOpegWiQexBTfxgSo9gaiPexBNfzgTongaiPexBNfzgTonf7iUevBrgYgvqIfdiYe1B8
					hrh7qofYiZe3B/h+iRqofYiZe3B/h+iRqofYiZe3B/h+iQqofciYe1B9hviAqofmiXeyB5hRhdqnfxiXewB2gtg0qmf7iWevB1gPgRqmgAiWevB0gAgAqmgA
					iWevB0gAgAqmgAiWevB0gAgAqm]],
				Neck3 = [[
					gAiseUBqgAgAqHgCireTBlgBgPp5gHipeTBZgHg1pQgOimeTBLgUhmoZgVijeTBBgoiSnlgZiheTA8g4ivnCgZiheTA8g4ivnCf5ipeTBcgXgwpafbiueZBr
					hDgKqIfUivecBshPgLqIfUivecBshPgLqIfVivebBshPgLqIfZiveaBshGgKqIfkiteXBrgzgHqIfwiteVBqgcgEqHf7iseUBqgJgBqHgAiseUBqgAgAqHgA
					iseUBqgAgAqHgAiseUBqgAgAqH]],
				Head = [[
					gAjNdo/ygAgAjlgBjMdn/wgHfgj0gEjHdl/ngWeKkegJjBdj/VggcWlVgOi8dj+7gfanmHgRi5dj+ngZZdmmgRi5dj+ngaZemmf3jIdm/rgpe0kSfbjPdt/w
					g2hDjqfVjQdw/vg/hPjsfVjQdw/vg/hPjsfVjQdw/vg/hOjsfajQdu/wg4hFjqfkjOdr/xgpgzjofwjOdp/ygWgcjmf7jNdo/ygHgJjlgAjNdo/ygAgAjlgA
					jNdo/ygAgAjlgAjNdo/ygAgAjl]],
				Jaw = [[
					gAiYdi/8gAgAh3gBiWdi/6gGfgiRgEiSdj/wgSeJjXgJiMdk/agccWk0gNiHdm+7gganmJgQiDdo+hgfZenAgQiDdo+hgfZem/f5iTdi/qgpe0kaffiado/X
					gwhHmLfZibdr/Mg3hVm8fZibdr/Mg3hVm8fZibdr/Mg2hUm7feiadp/UgyhKmWfniZdm/kgmg1lIfyiYdj/xgWgcjqf7iYdi/5gIgJidgAiYdi/7gAgAh4gA
					iYdi/8gAgAh3gAiYdi/8gAgAh3]],
				["Lid.L"] = [[
					e0jvdVczA1gAmce1jtdWcsA9fvm9e3jndacOBXfFoVe6jhdfbTCDeQqCe/jddlaJC2dlrhfDjbdpZSDbdUsafDjbdpZQDcdOsaepjndYbkB7aNoGePjsdWcm
					BhZamOeJjsdXcyBdZdmFeJjsdXcyBdZdmFeJjsdXcyBdZdmGeNjsdWcoBgZbmMeYjtdVcVBmZXmZekjtdUb+BtZTmoevjudVbvBsZtmze0jvdVcCBQcBmwe0
					jvdVckA6eymje0jvdVczA1gAmc]],
				["Lid.R"] = [[
					hMjvdVcz/LgAmchMjtdRcm/PgZl+hNjodIcN/YhakrhOjgc8cD/fiti8hOjYczcT/hj0hShOjSctcp/gkYgMhOjSctcp/fkegNhAjrdMbK+emXligmj1dfaa
					90mvnmggj3diaN9wmuntggj3diaN9wmuntggj3diaN9wmuntglj2dgaX9zmvnogvjzdcar95mwncg8jxdYbD+BmxnNhHjvdWbc+OmUnAhMjvdVcB+wj/mxhM
					jvdVck/GhOmjhMjvdVcz/LgAmc]],
				["UpperLegF.L"] = [[
					e8hWfW0AYAgA3pe+hWfUzSXmfv4GfDhUfQxhWhfG5AfKhRfLvxVFec5jfRhPfGvUTgeW5GfXhOfDwBSLe139fXhOfDwBSLe139e4hVfZ0wY0gL3Qelhcfz8T
					fDicureihdf58sgJiZt8eihdf58sgJiZt8eihdf58sgIiZt9ekhcf18afTibugephafs7mddiWv0exhYfh45a4hizXe4hXfZ1WY4gb2ve8hWfW0DYBgB3ne8
					hWfW0AYAgA3pe8hWfW0AYAgA3p]],
				["LowerLegF.L"] = [[
					evg1fZ8Sc3gAunevg1fZ8McUf6urexg2fY7hatfdvae1g2fV5tYfeVxZe6g2fO2UWhcT0ie+g0fIydVjaO3Pe+g0fIyeVkaO3Petg0fb9NeDgps6epg/ff8M
					jFgXuzenhBfj8ckGgfuEenhBfj8ckGgfuEenhBfj8bkFgfuFeog/fg8QjUgZuoerg7fa7shlgAv7esg2fY8GfygHvSetg1fa8reCgVuCevg1fZ8Tc5gBulev
					g1fZ8Sc3gAunevg1fZ8Sc3gAun]],
				["FootF.L"] = [[
					esgifL/vgAgAkCesgifL/ufcgFkCesgifL/qdwgSkBesgifL/XbOgnj/esgifL+0Yag+j6etgjfK+GWKg+kaetgjfK+GWKg+kaesgifL/thWf1kCergrfR+s
					mIfJmkeqgufU+WnKfGnHeqgufU+WnKfGnHeqgufU+WnIfGnGergrfS+nmXfImtesgmfN/KkkfTliesgifL/ni2fpkBesgifL/thOf2kCesgifL/vgCgAkCes
					gifL/vgAgAkCesgifL/vgAgAkC]],
				["UpperLegF.R"] = [[
					hEhWfW0AoAgA3phGhWfX0annf53bhLhWfc1wmjfh2hhQhVfi37lEe50mhVhVfp6kjbeHxZhYhUfu8NiMdluvhYhUfu8NiNdluvhAhUfSyYo3gn4ogjhUfAvR
					uLgd4RgchUe9uGu7ga4igchUe9uGu7ga4igchUe9uHu6ga4hghhUe/vAuXgd4VgshUfExEtBgX3tg3hVfLxuqwgo4WhAhWfSy5o4gX4PhEhWfWz+oCgB3qhE
					hWfW0AoAgA3phEhWfW0AoAgA3p]],
				["LowerLegF.R"] = [[
					hRg1fZ8SjJgAunhSg1fa8rilfut7hUgzfc9ahJfLshhWgyfc9ufhe0rxhWg0fb9EejfLtPhVg3fa8ReKfru3hVg3fa8QeKfru4hQg1fZ8IkVgKung7g7fFxv
					rDk/3tg2g9fEwtsBk/3/g2g9fEwtsBk/3/g2g9fEwur/k/3+g6g7fFxfrRlA3xhCg4fIzRplkx3LhKg3fR4anEiWzShQg2fX7jkaggvphRg1fZ8RjLgBuohR
					g1fZ8SjJgAunhRg1fZ8SjJgAun]],
				["FootF.R"] = [[
					hUgifL/vgAgAkChUgifL/ufYgFkChUgifL/qd1gSkBhUgifL/gcKgfkAhUgifL/ZbWgmj/hUgjfM/SbHgpkdhUgjfM/SbIgpkdhUgifL/thMf2kChMgpfJ9D
					qsgkoChIgsfI77sFhTpzhIgsfI77sFhTpzhIgsfI79sDhSpxhLgqfJ80rAgvochRglfK+QooftlxhUgifL/Zkofaj/hUgifL/thYf1kChUgifL/vgCgAkChU
					gifL/vgAgAkChUgifL/vgAgAkC]],
				Tail1 = [[
					gAh4hUkBgAgA/vgAh4hUkBfsgG/vf+h3hUkBe2gY/tf9h1hUkCdtgv/pf7hzhUkEcnhG/if6hyhUkFb4hV/bf6hyhUkFb4hV/bgBh3hUkCgXf1/vgHh4hTkg
					k6eY/QgJh4hTlFm4d0+wgJh4hTlPnQdu+ogJh4hTlPnPdv+ogIh4hTlNmud8+xgGh4hUlHlfea/EgDh4hUk1jmfD/ZgBh4hUkfhrfo/ogAh4hUkMgbf8/tgA
					h4hUkBgBgA/vgAh4hUkBgAgA/v]],
				Tail2 = [[
					gAhyhtkNgAgA/tf/hyhtkNfigI/tf9hwhtkNeQgd/qf5huhskOcig6/gf2hthskQa5hV/Qf0hrhrkRZyhn/Df0hrhrkRZzhn/DgChxhtkOgQf2/tgPhxhqlE
					nNeA+sgThvhpmIq+dF9RgThvhomaryc484gThvhomarxc584gRhvhpmZrJdH9KgOhwhqmPpfds90gIhxhslxmlej+vgEhxhslIjVfY/ZgBhyhtkig9f3/pgA
					hyhtkOgDgA/tgAhyhtkNgAgA/t]],
				Tail3 = [[
					gAhsiFkcgAgA/rf+hriFkcfVgK/rf6hqiFkcdggl/lf0hoiEkdbFhJ/RfuhmiDkeYxhq+yfrhkiCkfXPiA+XfrhkiCkfXPiA+XgChqiFkegIf3/rgZhoiAlo
					qAdh9wgihlh6nCvxcP6qgjhkh5nYxDb95ugjhkh5nYxCb+5vghhlh6nYwUcN6Pgbhmh9nPuQc27hgShniBmrqNd89ggJhpiElzlYfD+/gChriFk8hofx/kgA
					hriFkegFf//rgAhsiFkcgAgA/r]],
				Tail4 = [[
					gAhliej3gAgA/wf9hkiej3fFgL/vf2hjidj3cngp/kfthgibj3ZUhQ/BfkheiZj4WOh0+KfehciWj4UMiM9ZfehdiWj4UNiM9ZgChjiej5f/f4/wgnhfiTlZ
					tVdT8dg1hZiFnA1Cb92tg3hXiBnX2pbs07g3hXiBnX2nbt09g0hYiEnY14b61xgthZiKnSzjcg4AgghdiTmsubdn7qgRhgialon1e2+egFhjidkhicfs/kgA
					hkiej5gIf//wgAhliej3gAgA/w]],
				Tail5 = [[
					gAhei2iXgAgA/5f8hei2iXezgK/4fxhci1iYbigj/lfjhaiyiZXQhF+qfVhYitibTShj9NfNhWioidQuh178fNhWioidQvh178gChdi2iaf0f5/5g5hViikW
					xEdu6nhLhNiGmQ6Ic2xFhNhLh+mm7vcwuJhNhLh/mm7tcwuMhKhLiDmn7Ec4vahDhNiOmh40dQy5gzhSigl3zCeC49gchXivklqqfC9zgIhci1jMjZfv/pgA
					hei2iagLf//5gAhei2iXgAgA/5]],
				["UpperLegB.L"] = [[
					e8hUgz3SWCgAzie8hTgy3OVygEzee8hRgw2/VMgQzbe9hPgt2gUigpzne+hMgq14UBhG0Ae+hKgo1WTuhb0Xe+hKgo1XTuhb0We8hTg133V5fayve8hYhB4D
					Z4fd0Le8hZhD4haLfHzse8hZhD4haLfHzse8hZhD4gaLfIzte8hYhC4KZ8fY0Ee8hXg+4WYSe6zPe7hWg54EXCfKzDe8hVg13lWUfszUe8hUgz3SWCf/zie8
					hUgz3SWCgAzie8hUgz3SWCgAzi]],
				["LowerLegB.L"] = [[
					evg1gqwKeNgA7jevg1gpvbeQgG7+eugzgntheTgQ88evgwgkrGeOgS98evgugio4eBgL+qevgsghndd2gE/Cevgsghned2gE/Ceug1gqwHe1gA7nezg4g64p
					dacoz9ezg4g75Ed1cTzaezg4g75Ed1cTzaezg4g75Dd1cUzbezg4g64vdgcjz1ewg4g02BedeU3Geug3gvzLepfY5keug2gsxGeZf26/evg1gqwMeOgA7iev
					g1gqwKeNgA7jevg1gqwKeNgA7j]],
				["FootB.L"] = [[
					esgig1/ugAgAkKesgig1/ugEf/kKesgig1/ugHf/kKesgig1/uf9gAkKesgig1/ufogDkKesgig1/tfWgGkKesgig1/tfWgGkKesgig1/tgcf8kKetgig1/k
					dSgUkWetgjg2/hdagMk0etgjg2/hdagMk0etgjg2/hdagMk0etgig1/kdUgSkdesgig1/tfPgGkKesgig1/ugBgAkKesgig1/ugFf/kKesgig1/ugAgAkKes
					gig1/ugAgAkKesgig1/ugAgAkK]],
				["UpperLegB.R"] = [[
					hEhUgz3Sp+gAzihEhUg03hp/gPzQhEhTg24Hp/g2yfhFhTg54zp8hoxihFhSg85Xp1iYwqhFhRg+5spwi3wHhFhRg+5spwi2wHhEhSgx3Nqlf7zUhBhQglzw
					rKdV2ZhAhQgiy2rOc03EhAhQgiy2rOc03EhAhQgjy3rOc13DhBhQgkzjrLdO2ihChRgo01rAeC1jhDhSgt2Gqqe80ghEhUgx28qPfrz0hEhUgz3Rp/f/zjhE
					hUgz3Sp+gAzihEhUgz3Sp+gAzi]],
				["LowerLegB.R"] = [[
					hRg1gqwKhzgA7jhSg1gqwQhkgB7ghSg2grwmg+gD7VhTg2gsxOgSgH69hUg3gtx+ftgK6dhUg3guyjfXgN6DhUg3guyjfXgN6DhSg0gouWhnfz8jhOgwglrB
					kNfW9uhOgwglqjk1fM9zhOgwglqjk1fM9zhOgwglqjk0fN9zhOgwglq5kWfU9whPgxglr7jcfg9ehQgzgntlimfs82hRg1gpvRiCf48ChRg1gqwIhzgA7khR
					g1gqwKhzgA7jhRg1gqwKhzgA7j]],
				["FootB.R"] = [[
					hUgig1/ugAgAkKhUgig1/uf2gBkKhUgig1/tfcgFkKhUgig1/te9gJkKhUgig1/sejgMkKhUgig1/reUgOkKhUgig1/reUgOkKhUgig1/uf0gCkKhUgig1/r
					hgfzkKhUgig1/qh4fwkKhUgig1/qh4fwkKhUgig1/qh4fwkKhUgig1/rhmfzkKhUgig1/thBf3kKhUgig1/tgef8kKhUgig1/ugIf/kKhUgig1/ugAgAkKhU
					gig1/ugAgAkKhUgig1/ugAgAkK]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiCguALgAgAjKgAiBgwAKgAgAi+gAh+g1AIgAgAikgAh7g5AGgAgAiLgAh6g7AFgAgAiDgAh9g1AHgAgAihgAiDgtAPgAgAjygAiFgpAZgAgAk1gAiGgoAb
					gAgAlGgAiGgoAbgAgAlGgAiGgoAbgAgAlGgAiGgoAbgAgAlGgAiGgoAbgAgAlGgAiGgoAbgAgAlGgAiGgoAbgAgAlGgAiGgoAbgAgAlGgAiGgoAbgAgAlGgA
					iGgoAbgAgAlGgAiGgoAbgAgAlGgAiFgpAZgAgAk3gAiEgrARgAgAkDgAiDgtAMgAgAjTgAiCguALgAgAjKgAiCguALgAgAjKgAiCguALgAgAjK]],
				Spine1 = [[
					gAiHgYALgAgAjKgAiFgaAJgAgAi5gAiBgfAGgAgAiRgAh+gjAEgAgAhrgAh9gkADgAgAhggAiBgfAGgAgAiMgAiIgXARgAgAj8gAiMgTAdgAgAlUgAiNgTAh
					gAgAlpgAiNgTAhgAgAlpgAiNgTAhgAgAlpgAiNgTAhgAgAlpgAiNgTAhgAgAlpgAiNgTAhgAgAlpgAiNgTAhgAgAlpgAiNgTAhgAgAlpgAiNgTAhgAgAlpgA
					iNgTAhgAgAlpgAiNgTAhgAgAlpgAiMgTAegAgAlWgAiKgVAUgAgAkUgAiHgXAMgAgAjWgAiHgYALgAgAjKgAiHgYALgAgAjKgAiHgYALgAgAjK]],
				Spine2 = [[
					gAiLgC/+gAgAhNgAiJgE/9gAgAhjgAiEgI/5gAgAiZgAiAgN/1gAgAjLgAh/gO/zgAgAjagAiEgJ/5gAgAifgAiOgB//gAgAgPgAiTf+/9gAgAeigAiUf+/7
					gAgAeIgAiUf+/7gAgAeIgAiUf+/7gAgAeIgAiUf+/7gAgAeIgAiUf+/7gAgAeIgAiUf+/7gAgAeIgAiUf+/7gAgAeIgAiUf+/7gAgAeIgAiUf+/7gAgAeIgA
					iUf+/7gAgAeIgAiUf+/7gAgAeIgAiTf+/9gAgAeggAiQgA//gAgAfygAiMgB/+gAgAg+gAiLgC/+gAgAhNgAiLgC/+gAgAhNgAiLgC/+gAgAhN]],
				Spine3 = [[
					gAiKfs/+gAgAhNgAiHfu/8gAgAhpgAiBfz/4gAgAisgAh8f3/ygAgAjqgAh6f5/vgAgAj9gAiAfz/3gAgAi0gAiNfr//gAgAgFgAiVfo/7gAgAeDgAiXfo/5
					gAgAdlgAiXfo/5gAgAdlgAiXfo/5gAgAdlgAiXfo/5gAgAdlgAiXfo/5gAgAdlgAiXfo/5gAgAdlgAiXfo/5gAgAdlgAiXfo/5gAgAdlgAiXfo/5gAgAdlgA
					iXfo/5gAgAdlgAiXfo/5gAgAdlgAiVfo/7gAgAeBgAiQfq//gAgAfhgAiLfr/+gAgAg7gAiKfs/+gAgAhNgAiKfs/+gAgAhNgAiKfs/+gAgAhN]],
				Neck1 = [[
					gAiIfWAhgAgAlqgAiFfYAcgAgAlJgAh9fdAQgAgAj5gAh3fiAIgAgAiugAh1fjAHgAgAiXgAh8feAPgAgAjxgAiNfVA8gAgAnogAiYfSB5gAgAqzgAiafSCL
					gAgArkgAiafSCLgAgArkgAiafSCLgAgArkgAiafSCLgAgArkgAiafSCLgAgArkgAiafSCLgAgArkgAiafSCLgAgArkgAiafSCLgAgArkgAiafSCLgAgArkgA
					iafSCLgAgArkgAiafSCLgAgArkgAiYfSB7gAgAq3gAiQfUBJgAgAobgAiJfVAngAgAmIgAiIfWAhgAgAlqgAiIfWAhgAgAlqgAiIfWAhgAgAlq]],
				Neck2 = [[
					gAiWevB0gAgAqmgAiSexBogAgAqAgAiHe1BMgAgAongAh+e5A2gAgAnRgAh7e7AxgAgAm3gAiGe2BKgAgAoegAigexC6gAgAtRgAiyezFHgAgAxVgAi2e0Fw
					gAgAyRgAi2e0FwgAgAyRgAi2e0FwgAgAyRgAi2e0FwgAgAyRgAi2e0FwgAgAyRgAi2e0FwgAgAyRgAi2e0FwgAgAyRgAi2e0FwgAgAyRgAi2e0FwgAgAyRgA
					i2e0FwgAgAyRgAi2e0FwgAgAyRgAiyezFKgAgAxagAilewDYgAgAuRgAiZevCDgAgArNgAiWevB0gAgAqmgAiWevB0gAgAqmgAiWevB0gAgAqm]],
				Neck3 = [[
					gAiseUBqgAgAqHgAineUBcgAgApcgAiaeXA/gAgAn1gAiNeaApgAgAmTgAiJebAjgAgAl1gAiYeXA9gAgAnsgAi7eaDEgAgAtogAjSekGEgAgAyugAjXeoG9
					gAgAz4gAjXeoG9gAgAz4gAjXeoG9gAgAz4gAjXeoG9gAgAz4gAjXeoG9gAgAz4gAjXeoG9gAgAz4gAjXeoG9gAgAz4gAjXeoG9gAgAz4gAjXeoG9gAgAz4gA
					jXeoG9gAgAz4gAjXeoG9gAgAz4gAjTekGIgAgAy0gAjBebDrgAgAu3gAiweVB8gAgAq7gAiseUBqgAgAqHgAiseUBqgAgAqHgAiseUBqgAgAqH]],
				Head = [[
					gAjNdo/ygAgAjlgAjGdn/rgAgAkdgAi0dm/UgAgAmggAiidn+3gAgAobgAiddn+tgAgAo/gAiydn/SgAgBmqgAjld2/9gAgAecgAkGeT+wgafRXPgAkNeb9r
					fdgzUFgAkNeb98gAgAUwgAkNeb+LghfMVcgAkNeb9rfdgzUFgAkNeb98gAgAUwgAkNeb+LghfMVcgAkNeb9rfdgzUFgAkNeb98gAgAUwgAkNeb+LghfMVcgA
					kNeb9rfdgzUFgAkNeb98gAgAUwgAkHeT+tgafQXGgAjvd8/xf2gbcSgAjTdr/5gAgAibgAjNdo/ygAgAjlgAjNdo/ygAgAjlgAjNdo/ygAgAjl]],
				Jaw = [[
					gAiYdi/8gAgAh3gAiQdl/2gAgAi7gAh+dr/igAgAlagAhudy/CgAgAnugAhpd0+3gAgAoagAh8ds/egAgBlvgAi0dg//gAgAgVgAjkdp/5gjfXdpgAj0dr/q
					fSgpblgAjydt/xgAgAcSgAjwdu/1gtfVdBgAj0dr/qfSgpblgAjydt/xgAgAcSgAjwdu/1gtfVdBgAj0dr/qfSgpblgAjydt/xgAgAcSgAjwdu/1gtfVdBgA
					j0dr/qfSgpblgAjydt/xgAgAcSgAjldq/4gkfXdmgAjBdf/+f0gae8gAiedh/9gAgAhcgAiYdi/8gAgAh3gAiYdi/8gAgAh3gAiYdi/8gAgAh3]],
				["Lid.L"] = [[
					e0jvdVczA1gAmce0jmdTckA2gjmYe0jRdOb+A7hrmNe0i9dLbVBBiSmAe0i2dKa7BBhYl+e0jPdObIBIdrmZe0kLdvcwDIU8nhezkpegenGzOgo6e1kyeqfF
					IjLjnUe0kverfJINMToNezktetfLH5NEpGe1kyeqfFIjLjnUe0kverfJINMToNezktetfLH5NEpGe1kyeqfFIjLjnUe0kverfJINMToNezktetfLH5NEpGe1
					kyeqfFIjLjnUe0kverfJINMToNezkpeheqG5OYo7e1kWd4dRD4S7nSe0j2dacJBkaNm9e0jvdVcTBCdfmqe0jvdVcqA4fTmge0jvdVczA1gAmc]],
				["Lid.R"] = [[
					hMjvdVcz/LgAmchMjmdTck/KfdmYhMjRdOb+/FeVmNhMi9dLbV+/dumAhMi2dKa7+/eol+hMjPdObI+3iUmahMkLdvcw84rEnhhLkueaeW5dx3nThNkrevfl
					3O0BpIhMkverfJ3zztoNhLk0enew4XzXnRhNkrevfl3O0BpIhMkverfJ3zztoNhLk0enew4XzXnRhNkrevfl3O0BpIhMkverfJ3zztoNhLk0enew4XzXnRhN
					krevfl3O0BpIhMkverfJ3zztoNhLkvebeY5Xx/nThMkUd8dS7+s7oKhMj2dacJ+clzm9hMjvdVcT++ihmqhMjvdVcq/IgtmghMjvdVcz/LgAmc]],
				["UpperLegF.L"] = [[
					e8hWfW0AYAgA3pe8hTfZz8Xpfp3ke8hMfh02Wve/2Ze8hGfp2cVueg0Te8hEfs2+VaeZzhe8hLfj1EWle52Ie8hcfS0fYXgL3We8hnfJ2IZYhE2He8hqfH1/
					ZkhD2Te8hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8
					hqfH1/ZkhD2Te8hqfH1/ZkhD2Te8hofJ2HZWg92He8hffOusYic47Pe8hYfUv/X5dQ6We8hWfWz9YAf+3se8hWfW0AYAgA3pe8hWfW0AYAgA3p]],
				["LowerLegF.L"] = [[
					evg1fZ8Sc3gAuneugzfc9acogksGesgsfh+4bwhXnCergnfj/Wa2hjjVergmfj/Zamhgifesgrfh/AbnhbmYewg6fU7KdEfWwoezhFfH29dFdf18ezhIfG2y
					dOde2IezhIfG2ydOde2IezhIfG2ydOde2IezhIfG2ydOde2IezhIfG2ydOde2IezhIfG2ydOde2IezhIfG2ydOde2IezhIfG2ydOde2IezhIfG2ydOde2Iez
					hIfG2ydOde2IezhIfG2ydOde2IezhFfH29dCdY17eqhFff/Vcah6lDeqg8fi/YcBiQkKevg1fZ8Wc3gCugevg1fZ8Sc3gAunevg1fZ8Sc3gAun]],
				["FootF.L"] = [[
					esgifL/vgAgAkCesgifL/vf8gAkCesgifL/ufRgGkCesgifL/seTgOkBesgifL/rd/gQkBesgifL/ufIgHkCesglfJ/vf/gAkCetgtfG/efUftloeugwfF/X
					fdfjmOeugwfF/XfdfjmOeugwfF/XfdfjmOeugwfF/XfdfjmOeugwfF/XfdfjmOeugwfF/XfdfjmOeugwfF/XfdfjmOeugwfF/XfdfjmOeugwfF/XfdfjmOeu
					gwfF/XfdfjmOeugwfF/XfdfjmOetgtfG/lfQf2lCesg9fI/vgDgAkCesg1fK/vftgCkCesgifL/vgBgAkCesgifL/vgAgAkCesgifL/vgAgAkC]],
				["UpperLegF.R"] = [[
					hEhWfW0AoAgA3phEhTfZz8oXgX3khEhMfh02pRhB2ZhEhGfp2cqShg0ThEhEfs2+qmhnzhhEhLfj1EpbhH2IhEhcfS0fnpf13WhEhnfJ2Imoe82HhEhqfH1/
					mce92ThEhqfH1/mce92ThEhqfH1/mce92ThEhqfH1/mce92ThEhqfH1/mce92ThEhqfH1/mce92ThEhqfH1/mce92ThEhqfH1/mce92ThEhqfH1/mce92ThE
					hqfH1/mce92ThEhqfH1/mce92ThEhofJ2HmpfA2IhEhffOwPnehx6ehEhYfUxCoChq5zhEhWfWz+oAgB3rhEhWfW0AoAgA3phEhWfW0AoAgA3p]],
				["LowerLegF.R"] = [[
					hRg1fZ8SjJgAunhSgzfc9ajYfcsGhUgsfh+4kQepnChVgnfj/WlKedjVhVgmfj/ZlaegifhUgrfh/AkZelmYhQg6fU7Ki8gqwohNhFfH29i7ih18hNhIfG2y
					iyii2IhNhIfG2yiyii2IhNhIfG2yiyii2IhNhIfG2yiyii2IhNhIfG2yiyii2IhNhIfG2yiyii2IhNhIfG2yiyii2IhNhIfG2yiyii2IhNhIfG2yiyii2IhN
					hIfG2yiyii2IhNhIfG2yiyii2IhNhFfH28i9il18hUhCfc+Site3p4hVg6ff+sjQeboQhRg1fZ8UjJf/uihRg1fZ8SjJgAunhRg1fZ8SjJgAun]],
				["FootF.R"] = [[
					hUgifL/vgAgAkChUgifL/vgEgAkChUgifL/ugvf6kChUgifL/shtfykBhUgifL/riBfwkBhUgifL/ug4f5kChUglfJ/vgBgAkChTgtfG/egsgTlohSgwfF/X
					gjgdmOhSgwfF/XgjgdmOhSgwfF/XgjgdmOhSgwfF/XgjgdmOhSgwfF/XgjgdmOhSgwfF/XgjgdmOhSgwfF/XgjgdmOhSgwfF/XgjgdmOhSgwfF/XgjgdmOhS
					gwfF/XgjgdmOhSgwfF/XgjgdmOhTgtfG/igugOlThUg0fI/ufPgGkChUgufK/vfsgDkChUgifL/vf/gAkChUgifL/vgAgAkChUgifL/vgAgAkC]],
				Tail1 = [[
					gAh4hUkBgAgA/vgAh3hWjtgAgA/xgAh1hci/gAgA/2gAhzhgiTgAgA/6gAhyhiiGgAgA/7gAh1hci6gAgA/3gAh3hTlMfmgC/kgAh3hOnHgQgA/MgAh3hNnl
					g+f//EgAh3hNnlfNgB/EgAh3hNnlfcgA/EgAh3hNnlhFf//EgAh3hNnlgAgA/FgAh3hNnle7gB/EgAh3hNnlgkgA/EgAh3hNnlgzf//EgAh3hNnlfCgB/EgA
					h3hNnlfugA/FgAh3hNnlhHf//DgAh3hOnKfwgA/LgAh4hRlrfjgC/egAh4hUkTgEgA/sgAh4hUkBgAgA/vgAh4hUkBgAgA/vgAh4hUkBgAgA/v]],
				Tail2 = [[
					gAhyhtkNgAgA/tgAhyhvjxgAgA/xgAhxh0iugAgA/4gAhvh5hvgAgA/8gAhvh7hcgAgA/9gAhwh1ingBgA/4f/hvhrl7fQgF/bgAhshlotf6f++ygBhrhkpX
					iFf++hf/hrhkpYfCgD+kf/hrhkpXebgA+jgChrhkpXhyf9+igAhrhkpYgqgB+lf+hrhkpXd5gD+hgBhrhkpYgcf9+lgBhrhkpXh5f/+if/hrhkpXelgD+jgA
					hrhkpYe2f/+kgChrhkpXiBf9+hgAhshlowgGgC+xf/hvhpmnfDgF/SgAhyhskmgFf//qgAhyhtkNgAgA/tgAhyhtkNgAgA/tgAhyhtkNgAgA/t]],
				Tail3 = [[
					gAhsiFkcgAgA/rgAhsiIj3gAgA/wgAhsiNihgAgA/5gAhtiThPgAgA/9gAhtiUg3gAgA/+gAhsiOiYgCgA/5f+hmiCmtfIgG/RgAhfh7qUfGf8+RgFhdh4rK
					i5f692f9hdh5rMfjgJ9+f9hdh5rKdWgB93gEhdh4rLh1f296gBhdh5rLhugE97f7hdh4rKdSgI93gChdh5rMfsf49+gEhdh4rKi4f992f8hdh5rLe0gK98f+
					hdh5rLdvf+95gFhdh4rKiXf394gAhfh6qZg7gE+Pf+hliAnmeqgI/DgAhqiEk+gCgA/mgAhsiFkcgAgA/rgAhsiFkcgAgA/rgAhsiFkcgAgA/r]],
				Tail4 = [[
					gAhliej3gAgA/wgAhmigjKgAgA/1gAhoinhfgAgA/9gAhrisf6gAgA//gAhriufcgAgA//gAhoinhUgCgA/9f9hciZmrfQgG/Rf/hQiPrIeIf397gJhNiLsK
					jHf29bf9hNiMsMgigU9kf5hNiLsKcnf/9ZgHhNiLsMhOfs9jgEhNiMsLixgL9df3hNiLsLdWgO9dgBhNiMsMenfu9igIhNiLsKjYf79Zf7hNiMsMfpgU9kf6
					hNiMsKc0f69agIhNiLsLiAfv9ggBhPiOrNh5gK95f8hZiWnyekgI+/gAhjidkhf9gA/rgAhliej3gAgA/wgAhliej3gAgA/wgAhliej3gAgA/w]],
				Tail5 = [[
					gAhei2iXgAgA/5gAhhi5hhgAgA/9gAhmjAfigAgA//gAhrjFdqgAgA/6gAhsjHdHgAgA/3gAhmjBfVgDgA//f8hRixlvfmgF/ef8g/iirEdZft95gNg7idsU
					irfu9Zf+g7iesVhngl9ef0g7idsUcgf/9UgJg7idsVgNfc9ggIg7idsUjZgU9Vfzg7idsVeCga9df/g7iesUdofe9bgNg7idsUjNf39Wf6g7iesVgugm9gf2
					g7idsUcbf19UgLg7idsVhIfg9fgEg/ihrLipgU93f6hNitnFexgH/LgAhci1jJf4gA/1gAhei2iXgAgA/5gAhei2iXgAgA/5gAhei2iXgAgA/5]],
				["UpperLegB.L"] = [[
					e8hUgz3SWCgAzie8hTg239VeftyZe8hQg85PUYfEv1e8hNhC6JTlejthe8hMhD6YTYeas3e8hPg95ZUPe+vde8hVgw2uWegE0ae8hXgp0SYZgx3ie8hXgozK
					ZRhH4se8hXgozKZRhH4se8hXgozKZRhH4se8hXgozKZRhH4se8hXgozKZRhH4se8hXgozKZRhH4se8hXgozKZRhH4se8hXgozKZRhH4se8hXgozKZRhH4se8
					hXgozKZRhH4se8hXgozKZRhH4se8hXgp0OYcgy3me8hVgu1/XEgV1ce8hUgy3GWLgDz1e8hUgz3SWCgAzie8hUgz3SWCgAzie8hUgz3SWCgAzi]],
				["LowerLegB.L"] = [[
					evg1gqwKeNgA7jeug1gqv8eagP7seug1gqwJeggr7keug2gsw/eNg97Beug2gsxWeDhA6yeug1gqwNefgu7hevg1gqv1eRfv7vexg2gsxVdHe06teyg3gvyr
					cTea5qeyg3gvyrcTea5qeyg3gvyrcTea5qeyg3gvyrcTea5qeyg3gvyrcTea5qeyg3gvyrcTea5qeyg3gvyrcTea5qeyg3gvyrcTea5qeyg3gvyrcTea5qey
					g3gvyrcTea5qeyg3gvyrcTea5qexg2gsxZdFez6qevg1gqwNd9fe7gevg1gqwHeMf77kevg1gqwKeNgA7jevg1gqwKeNgA7jevg1gqwKeNgA7j]],
				["FootB.L"] = [[
					esgig1/ugAgAkKesgig1/ugTf9kKesgig1/tgrf6kKesgig1/tgsf6kKesgig1/tgpf7kKesgig1/tgtf6kKesgig1/uf2gBkKesgig1/redgNkKesgig1/o
					dpgUkJesgig1/odpgUkJesgig1/odpgUkJesgig1/odpgUkJesgig1/odpgUkJesgig1/odpgUkJesgig1/odpgUkJesgig1/odpgUkJesgig1/odpgUkJes
					gig1/odpgUkJesgig1/odpgUkJesgig1/rebgNkKesgig1/tfdgFkKesgig1/uf8gBkKesgig1/ugAgAkKesgig1/ugAgAkKesgig1/ugAgAkK]],
				["UpperLegB.R"] = [[
					hEhUgz3Sp+gAzihEhTg239qigTyZhEhQg85Prog8v1hEhNhC6JsbhdthhEhMhD6Ysohms3hEhPg95ZrxhCvdhEhVgw2upif80ahEhXgp0SnnfP3ihEhXgozK
					mve54shEhXgozKmve54shEhXgozKmve54shEhXgozKmve54shEhXgozKmve54shEhXgozKmve54shEhXgozKmve54shEhXgozKmve54shEhXgozKmve54shE
					hXgozKmve54shEhXgozKmve54shEhXgp0OnkfO3mhEhVgu1/o8fr1chEhUgy3Gp1f9z1hEhUgz3Sp+gAzihEhUgz3Sp+gAzihEhUgz3Sp+gAzi]],
				["LowerLegB.R"] = [[
					hRg1gqwKhzgA7jhSg1gqv8hmfx7shSg1gqwJhgfV7khSg2gsw/hzfD7BhSg2gsxWh9fA6yhSg1gqwNhhfS7hhRg1gqv1hvgR7vhPg2gsxVi5hM6thOg3gvyr
					jthm5qhOg3gvyrjthm5qhOg3gvyrjthm5qhOg3gvyrjthm5qhOg3gvyrjthm5qhOg3gvyrjthm5qhOg3gvyrjthm5qhOg3gvyrjthm5qhOg3gvyrjthm5qhO
					g3gvyrjthm5qhOg3gvyrjthm5qhPg2gsxZi7hN6qhRg1gqwNiDgi7ghRg1gqwHh0gF7khRg1gqwKhzgA7jhRg1gqwKhzgA7jhRg1gqwKhzgA7j]],
				["FootB.R"] = [[
					hUgig1/ugAgAkKhUgig1/uftgDkKhUgig1/tfVgGkKhUgig1/tfUgGkKhUgig1/tfXgFkKhUgig1/tfTgGkKhUgig1/ugKf/kKhUgig1/rhjfzkKhUgig1/o
					iXfskJhUgig1/oiXfskJhUgig1/oiXfskJhUgig1/oiXfskJhUgig1/oiXfskJhUgig1/oiXfskJhUgig1/oiXfskJhUgig1/oiXfskJhUgig1/oiXfskJhU
					gig1/oiXfskJhUgig1/oiXfskJhUgig1/rhlfzkKhUgig1/tgjf7kKhUgig1/ugEf/kKhUgig1/ugAgAkKhUgig1/ugAgAkKhUgig1/ugAgAkK]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiCguALgAgAjKgAiJguAegBgdlWgAiCguAigBhElpgAibguAwf/hEmvgAiwguA4f/gqnXgAi3guA7gAgAnjgAiwguA4gBfWnXgAibguAwgBe8mvgAiCguAi
					f/e8logAiHguAlgAfWl9gAiFguAkgAgAl4gAilguA0f/gqnEgAi0guA7f9hEnegAi2guA7f9hEnhgAipguA2f/gqnLgAiNguAogAgAmNgAiFguAkf/fWl4gA
					iNguAsgAe8mcgAiLguAif/fNlpgAiFguARf/f2j/gAiCguALgAgAjK]],
				Spine1 = [[
					gAiHgYALgAgAjKf/iQgYAdgBgdlRf/iKgZAcgAhElGf/ikgZAyf/hEm3f/i6gaA/f/gqnzgAjBgaBEgAgAoGgBi6gaA/gBfWnzgBikgZAygBe8m3gBiKgZAc
					gAe8lFgBiPgZAhgAfWlogAiOgZAfgAgAlef/ivgZA4f/gqnXf/i/gaBDf+hEn/f/jAgaBEf+hEoDf/izgZA7f/gqnigAiWgZAlgAgAmAgBiOgZAggAfWlegB
					iWgZAsgAe8mcgBiSgZAif/fNlpgAiLgYARf/f2j/gAiHgYALgAgAjK]],
				Spine2 = [[
					gAiLgC/+gAgAhNf/iXgD/+gDfjfJf9iRgD/+gKe9fzf9itgF/3gKe9dUf+jEgG/vgGfWcBgAjMgG/sgAgAbogCjEgG/vf6gqcBgDitgF/3f2hDdUgDiRgD/+
					f2hDf0gCiXgE/+f6gqfDgAiVgE/+gAgAfRf+i5gF/zgGfWcof9jJgG/sgKe9byf9jLgG/rgKe9bsf+i9gG/xgGfWcZgAiegE/9gAgAehgCiVgE/+f6gqfQgD
					ifgF/5f2hDd5gCiagE/9f6gzesgAiQgC//f/gKgXgAiLgC/+gAgAhN]],
				Spine3 = [[
					gAiJfs/+gAgAhNf+iYft/+gDfjfNf8iRft/+gLe9gXf8ixfv/2gJe9dMf9jKfx/rgFfWbkgAjSfx/ngAgAbFgDjKfx/rf7gqbkgEixfv/2f3hDdMgEiRft/+
					f1hDgYgDiYfu/+f5gpfYgAiWfu//gAgAfqf9i9fw/xgGfWcUf8jPfx/ngJe9bRf8jRfx/mgIe9bKf9jCfw/vgFfWcBgAigfu/9gAgAeugDiWfu/+f5gpfqgE
					iifv/5f2hDd5gDicfu/9f6gzesgBiQfs//f/gKgXgAiKfs/+gAgAhN]],
				Neck1 = [[
					gAiIfWAhgAgAlqf+iZfXAsgCgdmef6iRfXAagAhEk1f6i1faBJgChEoUf8jQfbBwgDgqqZgAjZfcB/gAgArCgEjQfbBwf9fWqZgGi1faBJf+e8oUgGiRfXAZ
					gAe8k0gEiZfYAjgAfWlzgAiXfYAggAgAlhf8jCfaBcgCgqpZf6jWfcB6gFhEqzf6jYfcB9gFhEq7f8jHfbBjgCgqpygAiifYAtgAgAmlgEiXfYAggAfWlhgG
					ilfZA3f/e8nQgEiefYAyf9fNm5gBiPfWAmf/f2mEgAiIfWAhgAgAlq]],
				Neck2 = [[
					gAiWevB0gAgAqmf8iqeyBugFgdqSf3idewBGgHhEoMf4jKe2CWgLhDr8f7jpe7DcgIgpuZgAj0e9D2gAgAvLgFjpe7Dcf4fXuZgIjKe2CWf1e9r8gJidewBG
					f5e8oLgFinexBXf7fWpIgAilexBRgAgAo3f7jZe4C4gHgptMf4jwe8DtgOhCu4f4jye9DzgOhCvDf7jfe5DFgIgptqgAiyezBogAgAqBgFilexBSf7fWo3gI
					i3e0B0f3e9qigGivezB1f3fOqlgBieewB0f9f2qmgAiWevB0gAgAqm]],
				Neck3 = [[
					gAiseUBqgAgAqHf8i/eWBOgEgdosf1iveSAngChEmEf2jiedBvgHhEqSf6kFemC6gHgptQgAkRepDXgAgAuPgGkFemC6f5fXtQgKjiedBvf5e8qSgLiueSAn
					f+e8mDgHi7eUAzf+fWnCgAi3eTAvgAgAmwf6j0ehCRgFgqrxf2kNeoDNgMhDt4f2kPepDTgMhDuFf6j7ejCggGgqsWgAjHeWBDgAgAoEgHi3eTAwf+fWmwgL
					jNeZBLf8e8oegIjFeXBTf6fNo6gCi0eUBif9f2pugAiseUBqgAgAqH]],
				Head = [[
					gAjNdo/ygAgAjlf6jcdn/uhQfrj4fyjDdf/RjBfGl8fykDdx/0i6fchof4kveC/6hufzeggAk9eI/4gAgAdcgIkveC/6eSgNeggOkDdx/0dGgkhogOjDdf/R
					c/g6l9gJjSdi/ieJghlDgAjOdh/igAgAlXf4kZd5/8hxfugHfzk4eG/yiwfudxfzk7eH/xiwfwdjf4kid8/8hwfwffgAjidm/vgAgAkCgJjOdh/feJgilVgO
					jpdp/pdCgujhgKjidp/td0gjjhgCjUdo/yfkgHjkgAjNdo/ygAgAjl]],
				Jaw = [[
					gAiYdi/8gAgAh3f+indi/chRfwlwf7iOdh+cjGfbpVf7jQdl/ci9fwlGf9j+ds/4hvf/h/gAkOdv/+gAgAg8gDj+ds/4eRgBh/gFjQdl/cdDgQlGgFiOdh+b
					c6glpWgDiddi+yeHgUoegAiYdi+wgAgAoyf9jndo/vhyf7jmf7kJdu/2ixgChQf7kMdv/2iwgDhCf9jwdq/zhxf8i/gAitdi/GgAgAnegDiZdh+teGgVovgF
					i0dk/Ec+gZm9gEiudj/ZdygZlsgBifdi/1fkgIjKgAiYdi/8gAgAh3]],
				["Lid.L"] = [[
					e0jvdVcABRb7mxerj3dWdDBNcjnUegjUdPeJBGfDn+ehkZdnfDBia0oMeolMd7etCOXin5e0ljeDdYCnWJnafBldd6bkCeWumtfKk0dgZ2B3ZZlwfLjudBY6
					BTdik3fCj6dJaFBPc6lpe0jtdLboBFdrmieok2dweXB0ZDn1eilQeBf2CaXHoQeilTeDf4CeW6oQeok+d0egB9Yen3e0kDdTb6BNcYmtfCj1dHaBBNdMlmfL
					kXdSZaBjbLlYfFkOdTaGBcbWlve3j4dUboBSb0mke0jvdVcABRb7mx]],
				["Lid.R"] = [[
					hMjvdVcA+vkFmxhDkDdRa2+tkFmIg1judBY6+tifk3g2k0dgZ2+Jmnlwg/ldd6bk9ipSmthMljeDdY9Zp3nahYlMd7et9yoen5hfkZdnfD+elMoMhgjTdPeJ
					+6g8n+hZjqdRdV+6iKnehMjtdLbo+7iVmig/lGdtbL99nzmeg3lqeAay9KqMmdg3lteCa29GqZmfg/lPdybU9zoXmkhMkDdTb6+zjomthZjldPdR+7h4ndhg
					j8dceq+vjXoHhbj6dad9+wjknyhPj0dWcZ+wj+m/hMjvdVcA+vkFmx]],
				["UpperLegF.L"] = [[
					e8hWfW0AYAgA3pe5hofTylYqea47e2hffZ2TXgcd1Ae2iEfSzoZye64de4ihfN36aQgx0de8irfJ3BZxgm1UfAiifI2cYugB1mfCiGfJxFXvdU5nfBhgfQws
					V+ZK4ce/hofPwtXObX5ae8hlfTyfXudN4me4iSfO4CaCg+0Pe2imfO4Ka6hK0Ue2iofO1hamf93De4iYfOyfZxeZ5Te8hxfQxmYDcH5Ne/hmfQw7XEbd5OfC
					h1fK0eXYfM3AfAhtfN2nXsgk1Ce9hefT0gX/gC3Ne8hWfW0AYAgA3p]],
				["LowerLegF.L"] = [[
					evg1fZ8Sc3gAumerhJfb/KdvhwmoelhAfV9/b/kPWjeqhjfY/IfZhznHexh+fG4jeHdj0ReziJfF3xdjdN1Fe1iAfE3Ycgch1RewhpfT9TbjfVsBeohIfa+R
					WfhpcVeqhNfa/SZkhkg9eqhHfa/ib4h9izexhwfH4ud+dv0FexiEfH4texeA0MetiGfP8LfqfvvJerh4fX+yfChNojephUfa/kbViNf3eqhLfa/RZhhpg3ez
					hVfM6Xbld5xde1hMfI3vbpdB0xewg9fV7ecqfYwBevg1fZ8Sc3gAun]],
				["FootF.L"] = [[
					esgifL/vgAgAkCesg/fF/thXf1kCeshNfC/ufigEkCeshYfC/Si6fdl9eshnfC+4g4fxoSeuhxfD+LgVfWqlethpfC+rfJf7pDeshYfC/ZepgRl/eshNfC+5
					Yyg7j7eshLfC/kc0gakAeshDfC/ufdgEkCethZfC/EgrfunkethsfD+chlfSpseshxfC+misfOo4eshrfC/AiXfbnheshUfC/neugMkteshJfC/kcygakAes
					g/fC/reLgPkBetg1fE/hd1f/lCesgofI/vfogDkCesgifL/vgAgAkC]],
				["UpperLegF.R"] = [[
					hEhWfW0AoAgA3phChpfP03oMgO20g/hgfQxzpjiw4qg+iGfJzZoXhY3/hAiifIxEnSip57hEirfJwomfi16ZhIihfNyYmGho5ahKiEfS0/mFgU3XhKhffZ1S
					nahF2rhIhnfV0rnVg13RhEhlfTyfoSiz4mhAiUfJwfngjD6Mg+ipfFvynejm6kg+irfFx8noiU5QhAiZfI2indf71chEhxfQ0nnugr3NhIhlfW0NnhhW3mhK
					hzfT0Tmagz33hIhsfTzFm2hS4uhFhefUzRntgk4WhEhWfW0AoAgA3p]],
				["LowerLegF.R"] = [[
					hRg1fZ8SjJgAumhPhIfQ7EjshPwnhShDfY+gl1fWnphOhmfN7IkMhywVhRiFfT9XjPgusQhTiOfX+viKfiokhViBfW+qg1e8pBhUhifU92gqfPrchXg+fa/q
					h8dqjehVhGfX+ziCetoRhWhHfa/ikIeDizhSh3fW+KjsgJqAhQiNfU9gkMhIrkhOiMfP7mjth+vohLh4fF3gjojb1HhShQfS9Hi4gHs8hWhEfZ/aiUeGlShW
					hSfX+8g1eZn8hWhMfa/OhceGmjhTg9fa9ciqfYsMhRg1fZ8SjJgAun]],
				["FootF.R"] = [[
					hUgifL/vgAgAkChUgyfF/ug4f5kChUg4fC/piefskBhUhRfC/ZhXfwl/hUh0fC+5gKf9oRhUiBfC+qe/gTpChUh0fC+zdkgqoQhUhRfC/UdZggl+hUg4fC/r
					eKgPkBhUg6fC/teigMkChUhDfC/ugjf8kChUhpfC/Mgjf4nEhUh9fC+vhHfsowhUh4fC+tgsfzo6hThgfC+6hEf/oMhUg+fC/pfvgDkuhUg8fC/teqgLkChU
					hGfC/ndRgWkBhUhCfE/qdygSkBhUgsfI/ufWgFkChUgifL/vgAgAkC]],
				Tail1 = [[
					gAh4hUkBgAgA/vgBh5hSmLi8f1/QgDhzhSmalSfw+5gDiIhRoJicf7+1gCichQpgeCgE+egAijhQp5bjgL+Gf+ichQpecvgH+Yf9iIhRoKgUf/+7f9hzhSmd
					jLf2/Lf+h2hSmyi9f5/IgAh1hSmugAgA/RgCiShQozdDgG+ngDighQpyc1gI+SgDiihQp7fsgB+agCiWhQpDjSf5+ggAh8hSnLkdf2+2f+h1hSmth+f7/Of9
					h8hRnRdkgD/Df+h7hSmccCgM/FgAh5hUk2e8gH/mgAh4hUkBgAgA/v]],
				Tail2 = [[
					gAhyhtkNgAgA/tgGhwhpmUkbfu/DgLhphomXplff92gGh8hnozlef0+Rf/iOhlq+dNgL97f5iUhjrZXngZ8sf6iOhlqxY4gR9Rf+h8hno6fxgA+ugChphpmi
					mZfq+qgDhshom0nRfs+ZgAhrhpm5h5f6/Lf9iEhmpza7gO+Bf+iShkrMYegR9AgCiThkrkcogB9ogGiIhlqQkGfw+BgHhxhnnXoafp9+gBhrhpmyl2fv+tf6
					hwhoneeIgD/Df4hxhpmiZogW+qf+hyhslBd2gP/hgAhyhtkNgAgA/t]],
				Tail3 = [[
					gAhsiFkcgAgA/rgMhmiAmjknfr++gZhfh7mTtGfN8fgOhvh7pUpgfp9Ff7h9h4sfeVgW9ZfuiEhzs1U9gv7Ifvh+h2r2Upgd7df+huh8prdYgB+YgMheh+ms
					n/fh+PgOhhh9mwrZfb9HgDhgiAnClUfu+wf2h2h5q6aqga9mfziCh0seU5gg7Sf9iCh3tBYjgA8QgMh5h4rii/fk9rgThmh7nkrGfc9BgKhgh+mxqJfd9kf3
					hlh+ntghf//Cfuhnh+mtYcgd+Wf7hqiElPcygX/ZgAhsiFkcgAgA/r]],
				Tail4 = [[
					gAhliej3gAgA/wgThciWmAjff0/OgrhWiKlkvQfX7jgchhiLo7tpfy7hf4hriJtLhLgr9Hffhyh+tpT9g/6SfghuiCsCQ6gV5gf6hgiRpiZpf693gYhUiSmJ
					nufr+bgehXiOl7ujfi73gLhViVmRphfr95fuhmiLrScSgk9sfkhwiAtDSugl6AfzhwiFtfUWfu6kgRhoiLsBgJfT9pgjhbiLnJsJfk8ugZhWiQl6t/fh8Jf4
					hZiUnFkRf7+6fjhdiSmLYogU+gf2hiibkpb7gZ/YgAhliej3gAgA/w]],
				Tail5 = [[
					gAhei2iXgAgA/5gZhTitkjhQgA/pg/hOiWkOvwgF7hguhViXnwxDgh57f6hYias2lHha80fQhgiHt1UuhO6hfNheiJrkOVfu4CfwhSikoaVZfU8+gjhLinky
					logC/IgyhPibkewOgQ7NgZhMiokntngK8lfphVidqvffg8+HfUhfiItDSPgf5wfjheiOtHQ5e948gQhWidrecLer9lg0hQibmBrYgB9SgshOiekWwsgN68f+
					hOiqldomgR+UfYhTinkyaNf+/GfvhaizjKbcgO/ggAhei2iXgAgA/5]],
				["UpperLegB.L"] = [[
					e8hUgz3SWBgAzie8hagv0TZfg731e8hTgw3MW9ef0Ce8hrgt0IaIgG4Ke8iBgp0nZFfk3ee8iJgmz9Y7gA3/e8iCgkyEZ8hT5qe8hugkyMZrh95de8hVgn0i
					XZhA28e8hZgoy0Zbhq49e8hXgr0wYbgg3Ie8h2gqziaJgW4pe8iFgr1pYcet2Re8iHgr1uYVen2Ke8h6gqzcaKgR4ue8hfgqzWZqhE4pe8hXgoyzZWhn49e8
					hgglynZqiO5Je8hdgozEZYiC4ve8hXgw1/XPgr1ge8hUgz3SWCgAzi]],
				["LowerLegB.L"] = [[
					evg1gqwKeNgA7jezg5gz05cFeB31eug1gpvSfoe18EezhLgy0ncmdQ4EexhggsxUd7d66vewhpgqwOd0eT7cezhjguylcFeX5sezhNguywb7e75kewg0gous
					dqfo8Uezg4gwzbbweq5Cexg2gtxpdSet6hezhVgx0Ccgde4kevhlgqv2fEd97sevhngpvifOd/74ezhagxz7cfda4pezg+gxz6cDeI4qeyg3gwzZbreo5Ce0
					g/guzLcAfL5Rezg8gwzqbzfA43ewg2gtxndUfg6kevg1gqwKeNgA7j]],
				["FootB.L"] = [[
					esgig1/ugAgAkKetgjg1/hdRgQkuesgig1/ugJf/kKetg1g1/LdJgemleshMg1+zemgZofeshVg1+levgZpRethOg1+jdbglpGeug4g0+2dogHoGesgig1/t
					fSgGkKetgjg1/iddgOkvesgig1/rehgNkKethAg1+7dOgknpeshSg1+sfggJo/eshUg1+pfpgHpJethEg1+4dLgrn2etgog1/ddTgXlLesgig1/mdYgWkLeu
					gqgz+5d3fon/eugmg0/Qdqf6mXesgig1/tfFgIkKesgig1/ugAgAkK]],
				["UpperLegB.R"] = [[
					hEhUgz3Sp/gAzihEhagrzbmueT4dhEhVgn0home/2+hEhugkyMmVeD5dhEiCgkyEmEet5qhEiJgmz9nFgA3/hEiBgp0nm7gc3ehEhrgt0Il4f64KhEhTgw3N
					pEhh0AhEhYgu1CnHf63ChEhXgr0wnlfg3IhEh3glyXmJeg5bhEiIgixkmIec5/hEiJgixhmHee6BhEh8glyQmHel5hhEhfgqzWmWe84phEhWgu1zn3gV2DhE
					hegu0dlzfm35hEhcgv0imPfU3thEhXgx2Woxfr1IhEhUgz3Sp+gAzi]],
				["LowerLegB.R"] = [[
					hRg1gqwKhzgA7jhNg5gx0CkQhT4ihQg0gpuwiYgZ8ShNhNguywkFhF5khNhjguylj7hp5shQhpgqwOiMht7chPhggsxUiFiG6vhNhLgy0njaiw4EhSg1gpvQ
					gXhL8GhPg3gvy9ixh45jhPg2gtxpiuhT6hhNhXguy4j6hf5fhNhogtyFkDha6ChNhqgtyCkDhb6FhNhcguyxj6hj5khNg+gxz6j9h44qhQg2gsxZh7hg6vhM
					g9gy08jPie31hNg6gz1GjoiO3rhQg2gtx2idgq6bhRg1gqwKhzgA7j]],
				["FootB.R"] = [[
					hUgig1/ugAgAkKhTgkg1/eiif3lLhUgig1/tgvf6kKhSg4g0+2iYf5oGhThOg1+jilfbpGhUhVg1+lhRfnpRhUhMg1+zhafnofhTg1g1/Li3fimlhUgig1/u
					f2gBkKhUgig1/qh4fwkKhUgig1/rhffzkKhThCg0+tiefsoohThTg1+ZijfZpohThVg1+YikfWprhThGg1+pigfmo1hTgog1/ditfplLhUgig1/shFf3kKhS
					gng1/OiggHmhhTgkg1/Ziqf6lfhUgig1/tg2f5kKhUgig1/ugAgAkK]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiCguALgAgAjKgAiCg5ARgAgAkCgAiChEAYgAgAk0gAiChCAXgAgAktgAiCg+AVgAgAkbgAiCg6ATf7e3kFgAiCg2ASf4ebjygAiCg0APf8fKjqgAiCgzAO
					gAgAjmgAiDgxANf1gKjagAiNguASdcgQjNgAieguA+Y7gtjFgAirguCsTlhPi6gAivguFKO6hsiqgAivguHRL9h/idgAiuguH+LIiEiYgAivguHXL3iAicgA
					ivguG1Mih7iggAivguHTL8h/idgAiuguH9LJiEiYgAiuguH/LIiEiYgAiuguH/LIiEiYgAiuguH/LIiEiYgAiuguH/LIiEiYgAiuguH/LIiEiY]],
				Spine1 = [[
					gAiHgYALgAgAjKgAiIgkARgAgAkCgAiJguAYgAgAk0gAiJgtAXgAgAktgAiIgpAVgAgAkbgCiIgkATf7e3kFgCiIggASf4ebjygBiHgeAPf8fKjqgAiHgeAO
					gAgAjmgAiIgbANf1gKjaf/iRgYASdbgKjNf+iigYA+Y6gdjIf9iugYCuTigzjFf8ixgYFMO3hJjBf8iwgYHVL6hYi9f8ivgYICLFhci7f8ivgYHbLzhYi8f8
					iwgYG4MehVi+f8iwgYHWL4hYi9f8ivgYIBLGhci7f8ivgYIDLEhci7f8ivgYIDLEhci7f8ivgYIDLEhci7f8ivgYIDLEhci7f8ivgYIDLEhci7]],
				Spine2 = [[
					gAiLgC/+gAgAhNgAiOgO//gAgAgUgAiQgZ//gAgAfhgAiPgX//gAgAfpgAiPgT//gAgAf7gDiOgP/+f7hJgRgEiNgL/8f6hlgjgCiNgJ/+f9g2gsgAiMgI/+
					gAgAgwgAiNgF/+gMf4g9f/iWgC/3ikgShIf9imgC/KnGgyhDf6iygC9bschVgvf4i0gC6+xHhxgTf4iygC420Dh/f7f3ixgC4J04iDf0f4ixgC4w0KiAf6f4
					iygC5Szfh9gAf4ixgC400Fh/f7f3ixgC4K03iDf0f3ixgC4I05iDfzf3ixgC4I05iDfzf3ixgC4I05iDfzf3ixgC4I05iDfzf3ixgC4I05iDfz]],
				Spine3 = [[
					gAiKfs/+gAgAhNgAiNf4//gAgAgUgAiQgD//gAgAfhgAiQgB//gAgAfpgAiPf9//gAgAf7gFiNf5/+f7hJgRgHiMf1/8f6hlgjgDiMfz/+f9g2gsgAiLfy/+
					gAgAgwf/iLfv/+gMf5g9f/iUfs/3ikgYhHf+ilfs/KnFhCg/f8iyfs9bsahxgjf7i1fs69xEiUf8f6izfs400Ainfbf5izfs4I01irfQf6izfs4v0Hinfaf6
					i0fs5Rzcikfif6izfs4z0Binfbf5izfs4J00irfRf5izfs4H01irfQf5izfs4H01irfQf5izfs4H01irfQf5izfs4H01irfQf5izfs4H01irfQ]],
				Neck1 = [[
					gAiIfWAhgAgAlqgAiNfiA5gAgAnagAiRftBSgAgAo7gAiQfrBOgAgAosgAiPfnBFgAgAoKgGiNfjA7fze4nfgJiLffA0fuecm7gFiLfdAuf2fLmqgAiKfcAs
					gAgAmif/iKfZAnf2gKmJgAiTfWAodcgVlrgAikfWBSY8g3lWf/iyfWC/TnhdlCf9i2fWFaO+h8ksf8i2fWHhMCiQkdf8i2fWINLNiVkYf8i2fWHmL7iQkdf8
					i2fWHFMmiMkgf8i2fWHiMBiQkdf8i2fWIMLOiVkZf8i2fWIOLNiVkYf8i2fWIOLNiVkYf8i2fWIOLNiVkYf8i2fWIOLNiVkYf8i2fWIOLNiVkY]],
				Neck2 = [[
					gAiWevB0gAgAqmgAife9C0gAgAtFgAinfKD2gAgAvLgAimfIDsgAgAu4gAijfDDTgAgAuIgJige+C5fme8tMgMide6CjfdehsYgHibe3CXftfNsAgAibe2CS
					gAgAr1f/iZezCFf4gNrSf+ihewB6dlg4qif6iwevCZZTiUp1f2i8evD5UNj6o4fzi+evGGPvlKnyfwi7evIBM5l3m8fwi6evIpMGmEmrfwi7evIGMzl5m6fx
					i8evHnNclvnHfwi7evICM4l4m7fwi6evIoMHmDmrfwi6evIqMFmEmrfwi6evIqMFmEmrfwi6evIqMFmEmrfwi6evIqMFmEmrfwi6evIqMFmEmr]],
				Neck3 = [[
					gAiseUBqgAgAqHgAi6emC+gAgAtcgAjEe3EbgAgAwNgAjDe0EMgAgAvzgAi/euDqgAgAu1gLi6enDEfle8tlgPi2ehCnfcehshgIi0eeCYftfNsBgAizecCR
					gAgAryf+ixeZB/f4gNrDf6i3eUBvdng/qBfxjDeTCJZZikpBfojKeSDjUXkOnvfhjGeSFoP7lbmSfei/eRHdNGmClMfdi9eRIEMTmMk2fei/eRHiNAmElJfe
					jBeRHENpl7lafei/eRHeNFmDlLfdi9eRIDMUmMk3fdi9eRIFMSmMk2fdi9eRIFMSmMk2fdi9eRIFMSmMk2fdi9eRIFMSmMk2fdi9eRIFMSmMk2]],
				Head = [[
					gAjNdo/ygAgAjlgAjjeC/9gAgAeigAj0ec/cgAgAaIgAjyeY/kgBgAaygAjseP/ygAgAcVgNjkeE/5eigueOgTjed7/5d5hHf0gKjad3/9e2gogrgAjZd0/+
					gAgAhEf9jUdv/6gZf4iMf1jXdo/qinf4jtfjjfdl+znHf4k8fRjcdk84sVgOmIfHjOdi6Qwwg7nOfDjAdh4Ezdhnn7fDi8dh3X0Nh2oHfDjAdh3/zjhpn8fE
					jDdh4iy8hdnyfDjAdh4Dzehnn7fDi8dh3Y0Mh2oHfDi8dh3W0Oh3oHfDi8dh3W0Oh3oHfDi8dh3W0Oh3oHfDi8dh3W0Oh3oHfDi8dh3W0Oh3oH]],
				Jaw = [[
					gAiYdi/8gAgAh3gAiyds//gAgAffgAjLd6/4gAgAdagAjId3/6gBgAdtgAi/dy/9gAgAedgKi0dt/8eggrfUgNirdp/5d4hGgCgHindn/9e3gogfgAildn//
					gAgAgrf/igdl/9gZf3hRf9iidj/ximfyirf5iudk+2nHfzkof3i3dl8tsVghm1f3i3dn5zwrh4otf3i0do3XzRjJpzf3izdp2lz+jlqGf3i0do3RzXjNp1f3
					i1do34yyi4pmf3i0do3WzSjKp0f3izdp2mz9jkqFf3izdp2kz/jlqGf3izdp2kz/jlqGf3izdp2kz/jlqGf3izdp2kz/jlqGf3izdp2kz/jlqG]],
				["Lid.L"] = [[
					e0jvdVczA1gAmce0kJd7d3BObGm3e0kbefe1CMW5nGe0kYeaesCBXhnEe0kTeNeVBoY/m/fGkRd7clBRacmBfOkMdsbqBEb1ldfCkEdncXA9c5l+e0j9dndU
					A8djmrexj2dgddA3evmvekjsdYfTAxgtm0ePjadWjeBIi8nBeEi7dXodCZlYmxeIiVdYtIEqo0lCeTh7dZwcHzs4hYeXhzdZxeKqwBdqeTh6dZw8MEx5bseQ
					iAdZwcMHyXbfeTh7dZw2MmyZbGeXh0dZxZNRycajeXhzdZxaNTycaieXhzdZxaNTycaieXhzdZxaNTycaieXhzdZxaNTycaieXhzdZxaNTycai]],
				["Lid.R"] = [[
					hMjvdVcz/LgAmchMkJd7d3+yk6m3hMkbefe190pHnGhMkZeaer9/ognEhMkTeNeV+YnBm/hdkDeBfR+qk1nvhjj4d3fh+zjHoDhZj5dted++iinbhMj9dndU
					/EidmrhIj5decu/Ihdmag5kEdUaS+5gbl/gYkbdKVu91gFlOfukldCQi7ofzkffMkac7MX4td8kye6kKc3Ki17aTnAe1kEc2LU0QWhpwe5kJc3NXz7TrrRe9
					kNc4OV0KSzrae5kJc3N3zqS7rre1kEc2NQy9TFsDe1kEc2NOy7TGsEe1kEc2NOy7TGsEe1kEc2NOy7TGsEe1kEc2NOy7TGsEe1kEc2NOy7TGsE]],
				["UpperLegF.L"] = [[
					e8hWfW0AYAgA3pe8hbff1TYBfj2fe8hgfo2XYDfK1be8hffm2NYDfO1le8hefj11YCfX1+fChcfb1WXLgQ2IfFhafW07W2gr2ZfBhZfX0vXYgS2xe8hZfa0q
					YAfy3Fe8hYfZ0ZYNf93YfFhXfV0RZZiN3wfYhafS0QbzmR3mfzhffQz8emrG2YgOhkfNzUg/vX0VgehqfMyvigyDydgjhsfLyji7yzx0gfhqfMyuijyJyYgb
					hpfMy3iNxiy2gfhqfMyvigyEybgjhsfLyji6yyx1gjhsfLyji7yzx0gjhsfLyji7yzx0gjhsfLyji7yzx0gjhsfLyji7yzx0gjhsfLyji7yzx0]],
				["LowerLegF.L"] = [[
					evg1fZ8Sc3gAunevg6ff9Dc3f1tAevg/fk9qc4frrkevg+fj9kc4fsryevg8fh9Xc4fwsTe1g7fZ9EcWg1sze4g5fV80cJhRtSezg4fY8ucegqtnevg4fc8r
					c3f6t0evg2fb8hdFf8uMe9g1fZ8VfAheuvfag2fY73ivkNu4gAg+fY6rnInjuRgkhKfX48q7qmtBg5hVfX3ctUsirzg/hZfX28t/tGrZg6hVfX3YtZsnrwg1
					hTfX3ws3sKsEg5hVfX3btVsjrzg/hZfX29t+tFrZg/hZfX28uAtGrYg/hZfX28uAtGrYg/hZfX28uAtGrYg/hZfX28uAtGrYg/hZfX28uAtGrY]],
				["FootF.L"] = [[
					esgifL/vgAgAkCesgofO/6gAgAiQesgufS//gAgAgsesgtfR/+gAgAg7esgrfQ/9gAgAhfe0gpfJ/5f3hJiKe3gnfF/1fzhkiveyglfI/1f5g2jBesglfM/1
					gAgAjJetgjfM/ygNf6jke+ggfL/mihgpkQfhgjfL+0m5h5kxgPgvfM9BsBjkk4g3hAfM6kwblNkjhPhQfM4fzKmUkFhVhVfM30z7moj6hQhQfM4azQmWkEhK
					hMfM47ypmGkMhPhQfM4ezLmUkFhVhVfM31z6moj6hVhVfM3zz8mpj6hVhVfM3zz8mpj6hVhVfM3zz8mpj6hVhVfM3zz8mpj6hVhVfM3zz8mpj6]],
				["UpperLegF.R"] = [[
					hEhWfW0AoAgA3phEhbff1Tn/gd2fhEhgfo2Xn9g21bhEhffm2Nn+gy1lhEhefj11n+gp1+hKhbfl1WnJhM2thNhafk07m0hU3MhJhZff0vnYgy3NhEhZfa0q
					oAgO3FhEhZfY0ToNgM3UhLhtfYzHpXiC3zhSiVfZxErelp32hSjAfcuXtkqH3ChHjfferqu/uL1fg6jufgpwvqw00Ag2jyfhpMv0xkzfg6jufgpsvsw6z8g9
					jrfgqJvjwT0Vg6jufgpvvrw1z/g2jyfhpNv0xjzgg2jyfhpMv0xlzfg2jyfhpMv0xlzfg2jyfhpMv0xlzfg2jyfhpMv0xlzfg2jyfhpMv0xlzf]],
				["LowerLegF.R"] = [[
					hRg1fZ8SjJgAunhRg6ff9DjJgLtAhRg/fk9qjIgVrkhRg+fj9kjIgTryhRg8fh9XjIgQsThXg6fl9EinhNtChZg4fm80iahitmhWg4fh8uiwg2tyhRg4fc8r
					jJgGt0hSg4fa8fjXgCuKhdhPfc74lRhcushsh9ff6oo6kAuzhxizfk4gtCnNuMhpjcfp17weqFtAhcjzfsz5yjr8r3hXj4ftzQzIserdhbjzfsz0yosAr0hf
					jvfr0UyKrlsHhcjzfsz4ylr9r2hXj4ftzRzHsdrehXj5ftzPzJserdhXj5ftzPzJserdhXj5ftzPzJserdhXj5ftzPzJserdhXj5ftzPzJserd]],
				["FootF.R"] = [[
					hUgifL/vgAgAkChUgofO/6gAgAiQhUgufS//gAgAgshUgtfR/+gAgAg7hUgrfQ/9gAgAhfhbgofV/5f3hJiKhdgmfW/1fzhkivhZglfR/1f5g2jBhUglfM/1
					gAgAjJhUglfL/ygNf6jjhjg7fO/nihgokJh4hsfS+3m7h0keiDimfY9GsFjXkXh+jWfd6rwjkzj5hyjyfh4mzVlvjXhtj5fi370ImAjKhxjzfh4hzclxjVh1
					jtfg5Cyzljjehxjyfh4lzXlvjWhtj5fi380GmAjLhtj5fi360ImAjKhtj5fi360ImAjKhtj5fi360ImAjKhtj5fi360ImAjKhtj5fi360ImAjK]],
				Tail1 = [[
					gAh4hUkBgAgA/vgAh2hfk5gAgA/ngAh0hplrgAgA/fgAh1hnljgBgA/ggAh1hklSgAgA/jf9h2hgk8eHgM/jf8h3hckpdYgS/if+h3hakhemgK/pgAh3hakd
					gAgA/rgAh5hXkRgRgK/tgCiDhVkFgdij/ogEiVhUj7hQnB+8gHikhUjmiNsT9OgJirhUjGjBw76zgKithUiqjhz14tgKithUihjp0q4BgKithUipjiz84ogK
					ishUiwjbzS5JgKithUiqjhz34sgKithUihjp0p4CgKithUihjp0r4AgKithUihjp0r4AgKithUihjp0r4AgKithUihjp0r4AgKithUihjp0r4A]],
				Tail2 = [[
					gAhyhtkNgAgA/tgAhvh3lFgAgA/lgAhsiBl2gAgA/cgAhsh/lvgBgA/egAhth8legAgA/hf6huh4lHdWgR/ef4hwh0kzcWga/af8hwhzkseCgP/lgAhwhykp
					gAgA/pgBhyhwkdgYgJ/rgDh9htkSgmih/mgIiPhtkHhpm9+6gMightjqi6sM9NgQiphti+j+wx6ygRithtiWkmzp4tgRiuhtiIky0d4CgRithtiUkozw4ogQ
					ishtiekfzG5JgRithtiVknzr4sgRiuhtiJkx0c4DgRiuhtiIky0e4BgRiuhtiIky0e4BgRiuhtiIky0e4BgRiuhtiIky0e4BgRiuhtiIky0e4B]],
				Tail3 = [[
					gAhsiFkcgAgA/rgAhniQlUgAgA/jgAhjiYmGgAgA/agAhjiXl+gBgA/bgAhliUltgAgA/ef2hmiPlVcmgY/WfzhoiMlBbTgk/Pf5hpiLk7dfgU/ggAhpiKk4
					gAgA/ngChriIksgegI/pgEh2iGkjgvig/jgMiKiFkWiEm5+3gTidiFjyjosE9KgXipiFi4k8wl6wgZiuiFiEluza4sgZiwiFhyl70N4BgZiviFiClwzg4ngY
					itiFiPlly35IgZiuiFiDluzb4rgZiwiFhzl70M4CgZiwiFhyl80O4AgZiwiFhyl80O4AgZiwiFhyl80O4AgZiwiFhyl80O4AgZiwiFhyl80O4A]],
				Tail4 = [[
					gAhliej3gAgA/wgAheinkvgAgA/ogAhZiwlhgAgA/ggAhaivlZgCgA/igAhcislIgAgA/lfxheinkwb1gY/XfrhgijkbaQgl/Jf1hhijkWc7gV/igAhhijkT
					gAgA/sgChkigkHglgI/ugGhviej/g0ig/ogQiEidjyiSm4+7gaiaidjJkCsC9MggipiciGlfwg6xgiixichJmVzT4sghi0icg1mk0F4AgiiyichGmXzZ4mgh
					iwichWmLyx5IgiixichImWzV4qghi0icg1mj0E4Bghi0icg0mk0G3/ghi0icg0mk0G3/ghi0icg0mk0G3/ghi0icg0mk0G3/ghi0icg0mk0G3/]],
				Tail5 = [[
					gAhei2iXgAgA/5gAhXjAjQgAgA/0gAhQjIkCgAgA/vgAhRjHj6gCgA/wgAhUjEjpgAgA/yfrhXi+jQbEgO/cfjhZi5i8ZNgX/Hfwhai7i2cWgO/pgAhbi7iz
					gAgA/3gDhdi5ingrgJ/4gIhpi3ihg1ih/ygVh/i2iViUm8/DgiiXi1hqkFsJ9Rgpiri0giljwn6wgqi2izfhmZzZ4ngqi5izfLmn0L37gqi2izfembzf4igq
					i0i0fvmPy35Egqi2izfgmZza4mgqi5izfLmm0K38gqi5izfLmn0L36gqi5izfLmn0L36gqi5izfLmn0L36gqi5izfLmn0L36gqi5izfLmn0L36]],
				["UpperLegB.L"] = [[
					e8hUgz3SWCgAzie8hUg84VWCfcyNe8hUhE5MWFe9xAe8hUhD5EWFfCxMe8hUhA4xWEfNxne8hUg44XVWgQxxe8hUgz4BVFgwyEe8hUg134VhgTyhe8hUg430
					WCfuy4e8hUg23rWQf2zMfEhUg04bX+hVy/fXhXgz51brjnyBfyhagz60gkl/wYgNhegz62lXn0ulgfhigz6Xoqo1tQgkhkgz6IpppGs2gghjgz6Voyo3tNgc
					hhgz6foAopthgfhigz6Woso1tPgkhkgz6IpopFs2gkhkgz6IpqpGs2gkhkgz6IpqpGs2gkhkgz6IpqpGs2gkhkgz6IpqpGs2gkhkgz6IpqpGs2]],
				["LowerLegB.L"] = [[
					evg1gqwKeNgA7jevg2gwxreNf66nevg4g1y9eOf05tevg3g1yxeOf152evg3gzyUeNf36Levg3grxvdOge6eevg2gmxPc2gv6wevg2gpxBdfgY6+evg2gtw7
					eNf97Gevg1gtwoebgE7Se8g0gqwrfjiL7NfYg2gnxCiDl96Wf9g9glxClSqR4fgghGgjweoXt52Hg3hQgivwqdwH0Kg9hTghverFwuzig3hQgivuqiwM0Fgy
					hOgiv6qDvs0kg3hQgivvqfwI0Jg9hTghvfrEwtzjg9hUghverFwuzhg9hUghverFwuzhg9hUghverFwuzhg9hUghverFwuzhg9hUghverFwuzh]],
				["FootB.L"] = [[
					esgig1/ugAgAkKesghg5/5gAgAiYesgig8/+gAgAg0esgig7/+gAgAhDesgig6/8gAgAhnesgigz/4f2hJiTesgigw/0fzhki4esgigz/0f5g2jJesghg3/0
					gAgAjSeughg3/ygNf5joe9ggg0/rikgTjqfegjgx/CnFgsjCgLgsgu9Ysdg5iHgzg7gr69xKg0hShLhJgp420IgngxhShOgo4J0+gigohMhKgo4w0PgngwhH
					hGgp5Szkgrg3hLhJgp400KgngwhShOgo4K09gjgohShOgo4I0/gigohShOgo4I0/gigohShOgo4I0/gigohShOgo4I0/gigohShOgo4I0/gigo]],
				["UpperLegB.R"] = [[
					hEhUgz3Sp+gAzihEhUg84Vp+gkyNhEhUhE5Mp7hDxAhEhUhD5Ep8g+xLhEhUhA4xp8gzxnhEhUhC4XpQhbyfhDhUhA4Bo/hjzDhEhUg834pdg8zDhEhUg430
					p+gSy4hFhWg13jqNgLzGhLhqg02tr2htzFhRiSgz1IvDkgyLhRi8gzynytnnwZhHjZgzvq1wqGuPg7jogztV3krhsjg3jrgzsl4Er5sBg7jogztP3orksfg+
					jlgzt03PrQs5g7jogztT3lrhsig3jrgzsm4Dr4sCg3jrgzsl4Er5sAg3jrgzsl4Er5sAg3jrgzsl4Er5sAg3jrgzsl4Er5sAg3jrgzsl4Er5sA]],
				["LowerLegB.R"] = [[
					hRg1gqwKhzgA7jhRg2gwxrhzgG6nhRg4g1y9hygM5thRg3g0yxhzgL52hRg3gzyUhzgJ6LhSg2g2xvg0gs6mhRg2g3xPgbg467hRg2gyxBhEgf7EhRg2gtw7
					hzgD7GhSg3grwmiBgI7RhdhOgqwSjHiP7Rhqh8gov+lfmF6fhvixgnvNoZqj4thmjZglt/rCuX2Whajvgks5swws0ZhVj0gkshtPxWzxhZjwgks2s0wx0Uhd
					jrgktIsbwQ0zhajvgks4sxwt0YhVj0gkshtPxVzyhVj0gkshtQxWzwhVj0gkshtQxWzwhVj0gkshtQxWzwhVj0gkshtQxWzwhVj0gkshtQxWzw]],
				["FootB.R"] = [[
					hUgig1/ugAgAkKhUghg5/5gAgAiYhUgig8/+gAgAg0hUgig7/+gAgAhDhUgig6/8gAgAhnhTghg//4f2hJiThTghhA/0fzhki4hTghg8/0f5g2jJhUghg3/0
					gAgAjShVgjg2/ygNf5jphig7g1/qikgUjxh1hrgy/AnEgxjWh/ikgw9VschHioh6jSgu66xIhPh9hvjtgs4z0GhOhghqj0gs4H08hNhYhujtgs4u0NhOhfhy
					jogt5QzihPhmhvjtgs4y0IhOhghqjzgs4I07hNhYhqj0gs4G09hNhYhqj0gs4G09hNhYhqj0gs4G09hNhYhqj0gs4G09hNhYhqj0gs4G09hNhY]],
			},
		},
	},
}
