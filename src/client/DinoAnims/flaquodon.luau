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
				Spine1 = [[
					gAg3gAALgAgAjPgAg4gAALgAgAjPgAg4gAALgAgAjPgAg4gAALgAgAjPgAg4gAALgAgAjPgAg3gAALgAgAjPgAg2gAALgAgAjPgAg2gAALgAgAjPgAg2gAAL
					gAgAjPgAg0gAAKgAgAi7gAgwgAAGgAgAiRgAgvgAAEgAgAh2gAgvgAAEgAgAh2gAgxgAAHgGhlh1gAgygAAlgVlqh0gAgxgAB0gmqahvgAgvgADOgzt1hqgA
					gsgADrg2uwhogAgsgADrg2uwhogAgtgADrg2uwhogAgugADrg2uwhogAgugADrg2uwhogAgvgADrg2uwhogAgvgADrg2uwhogAgugADrg2uwhogAgugACjgt
					sWhsgAgtgACUgrrxhtgAgsgADng2unhogAgsgADrg2uwhogAgtgADrg2uwhogAgugADrg2uwhogAgugADrg2uwhogAgxgADOgzt1hqgAgzgAB0gmqahvgAgy
					gAAlgVlqh0gAgwgAAHgGhlh1gAgugAAFgAgAiDgAgygAAIgAgAirgAg1gAALgAgAjLgAg2gAALgAgAjP]],
				Spine2 = [[
					gAg+fdAOgAgAjigAg/fdAOgAgAjigAg/fdAOgAgAjigAg/fdAOgAgAjigAg/fdAOgAgAjigAg+fdAOgAgAjigAg9fdAOgAgAjigAg9fdAOgAgAjigAg9fdAO
					gAgAjigAg6fdALgAgAjOgAg1fdAIgAgAilgAgzfdAGgAgAiKgAgzfdAGgAgAiJf9g1fdAIgHhliJf0g2ffAmgYlpiHfqg1fkB1gtqZiCflgzfqDPg7t0h8fj
					gwfsDsg/uvh6fjgwfsDsg/uvh6fjgxfsDsg/uvh6fjgyfsDsg/uvh6fjgyfsDsg/uvh6fjgzfsDsg/uvh6fjgzfsDsg/uvh6fjgyfsDsg/uvh6fngyfnCkg1
					sWh/fogxfmCVgzrxiAfjgwfsDog/unh6fjgwfsDsg/uvh6fjgxfsDsg/uvh6fjgyfsDsg/uvh6fjgyfsDsg/uvh6flg1fqDPg7t0h8fqg3fkB1gtqZiCf0g2
					ffAmgYlpiHf9g0fdAIgHhliJgAgzfdAHgAgAiWgAg4fdAKgAgAi+gAg8fdANgAgAjfgAg9fdAOgAgAji]],
				Spine3 = [[
					gAhGe7A0gAgAnHgAhGe7A0gAgAnHgAhHe7A0gAgAnHgAhHe7A0gAgAnHgAhGe7A0gAgAnHgAhGe7A0gAgAnHgAhFe7A0gAgAnHgAhEe7A0gAgAnHgAhEe7A0
					gAgAnHgAhBe7AwgAgAmzgAg7e6AngAgAmKgAg3e6AigAgAlwgAg4e6AigAgAlvf5g6e6AlgShklvfog7e+BChBlklqfVg6fJCQh4qQlbfJg4fUDpiftolLfH
					g1fYEGiquilGfHg1fYEGiquilGfHg2fYEGiquilGfHg2fYEGiquilGfHg3fYEGiquilGfHg4fYEGiquilGfHg4fYEGiquilGfHg3fYEGiquilGfOg2fPC/iO
					sLlTfQg2fNCwiHrmlVfHg1fXECioualHfHg1fYEGiquilGfHg2fYEGiquilGfHg2fYEGiquilGfHg3fYEGiquilGfJg6fUDpiftolLfVg7fJCQh4qQlbfog7
					e+BChBlklqf5g5e6AlgShklvgAg4e6AlgAgAl8gAg+e6AsgAgAmkgAhEe7AzgAgAnDgAhFe7A0gAgAnH]],
				Spine4 = [[
					gAhVebA0gAgAnHgAhWebA0gAgAnHgAhWebA0gAgAnHgAhWebA0gAgAnHgAhWebA0gAgAnHgAhVebA0gAgAnHgAhUebA0gAgAnHgAhUebA0gAgAnHgAhUebA0
					gAgAnHgAhQebAwgAgAmzgAhJeZAngAgAmKgAhEeZAigAgAlwgAhEeZAigAgAlvf2hHeZAlgShklvfchHefBChBlklqfAhHevCQh4qQlbevhEfADpiftolLer
					hCfFEGiquilGerhCfFEGiquilGerhCfFEGiquilGerhDfFEGiquilGerhEfFEGiquilGerhEfFEGiquilGerhEfFEGiquilGerhEfFEGiquilGe2hDe4C/iO
					sLlTe5hCe1CwiHrmlVeshCfEECioualHerhCfFEGiquilGerhCfFEGiquilGerhDfFEGiquilGerhEfFEGiquilGevhGfADpiftolLfAhIevCQh4qQlbfchH
					efBChBlklqf2hFeZAlgShklvgAhFeZAlgAgAl8gAhMeaAsgAgAmkgAhTebAzgAgAnDgAhUebA0gAgAnH]],
				Head = [[
					gAhkd7APgAgAjzgAhld7ASgAgAkIgAhld7AUgAgAkVgAhld7AUgAgAkVgAhld7ASgAgAkIgAhkd7APgAgAjzgAhjd7ANgAgAjegAhjd7AMgAgAjRgAhjd7AM
					gAgAjRgAhfd6ANgAgAjagAhWd5AOgAgAjngAhQd4AQgAgAj2gAhRd4ARgAgAkDfzhTd4AaggiIkffRhUeABah4nklLeshTeVD3jktvleeWhRerGjkyx/lUeQ
					hOeyHYlEzGlIeQhOeyHYlEzGlIeQhPeyHblIzGlUeQhPeyHglOzFloeQhQeyHllUzDl7eQhReyHolYzDmHeQhReyHolYzDmHeQhQeyDTkxshkeefhPegAUiD
					hwjZejhPedAPhqg7jNeRhOexAoiYlGiueQhOeyDJkVsijweQhPeyHblIzGlUeQhPeyHglOzFloeQhQeyHllUzDl7eWhTerGvlAx9mIeshUeVD+jrtvl/fRhU
					eABah4nklLfzhSd4AWgfiIj9gAhSd4AMgAgAjPgAhbd6ALgAgAjKgAhid7AMgAgAjRgAhjd7ANgAgAje]],
				Jaw = [[
					gAhqdO/+gAgAhDgAhsdO/+gAgAhNgAhtdO/9gAgAhUgAhtdO/9gAgAhUgAhsdO/+gAgAhNgAhqdO/+gAgAhDgAhpdO/9gAgAhYgAhndO/9gAgAhlgAhndO/9
					gAgAhlgAhkdN/+gAgAhNgAhbdL//gAgAgkgAhXdK//gAgAgKgAhXdL//gAgAf9fshbdM/6fxd1fge8hfdZ/AfGYReteKhhd68meMR7eGdthgec57dhNjd6dn
					heen5FdXMbeAdnheen5FdXMbeAdnhfen5DdTMbdzdnhgen5BdNMbdfdohien4+dHMcdLdohjen49dDMcc/dohjen49dDMcc/dxhceT9Cc2S/fKeahVdz/3eM
					eBgmeghTdv/7efe4gzeDhSeG/eeSaqhOdwhYeT9HdSTCf5dnhfen5DdTMbdzdnhgen5BdNMbdfdohien4+dHMcdLduhked51dSNkdGeKhjd68lePR6d6e8hf
					dZ/BfUYQfmfshYdM/5f2d1g3gAhWdL/8gAgAhngAhfdM/8gAgAhsgAhndO/8gAgAhlgAhpdO/9gAgAhY]],
				["Cheek.L"] = [[
					ewiEc/gNJZfz2newiGc/gbJZfl2newiIdAglJZfb2newiIdAglJZfb2newiGc/gbJZfl2newiEc/gNJZfz2newiCc+f+JZgC2newiBc+f1JZgL2newiBc+f1
					JZgL2nerh+c9f7JZgF2neih3c8gEJZf82nech0c8gPJZfx2nedh1c8gYJZfo2neMh5dLggK/fI4FdkiAd7giPkeB7XdIiEfAgOVvc6+JdFiFf2fzatcS/VdH
					iCgDfncHcP/hdIiCgAfncHcP/hdJiCgAftcIcE/gdJiEgDf3cKbx/edKiFgGgBcLbf/cdKiGgFgHcMbU/adLiFgCgHcMbU/acuiJfPeiUpcu9sc7h8dvenK2
					ey37c/h5dmesKNfI3Xckh6eVeNNgfQ6BcriEfOeVUkdj9udJiCgAftcIcE/gdJiEgDf3cKbx/edKiFgGgBcLbf/cdIiHf3gOaybj/PdMiFe9ghVxce+Gdsh+
					d2giPkeB7Xebh0dIgJK+fh4Gewhwc7fzJZgN2newh4c8fwJZgQ2newiAc+f0JZgM2newiCc+f+JZgC2n]],
				["Cheek.R"] = [[
					hQiEc/gN2ngN2nhQiGc/gb2ngb2nhQiIdAgl2ngl2nhQiIdAgl2ngl2nhQiGc/gb2ngb2nhQiEc/gN2ngN2nhQiCc+f+2nf+2nhQiBc+f12nf12nhQiBc+f1
					2nf12nhVh+c9f72nf72nheh3c8gE2ngE2nhkh0c8gP2ngP2nhjh1c8gY2ngY2nhKh3cxg44Fgg1BgLh5chh/7Xgiwce+h7cljG+JgOqReGh6c6ju/VfzlTd2
					h4dDjx/hfnj5d1h4dGjx/hfnj5d2h5dHj8/gftj4d3h8dGkP/ef3j2d4h/dEkh/cgBj1d5iAdFks/agHj0d4iAdIks/agHj0ephrdCjS9seirXf7hmdYhO37
					en1KgFhmdYg43Xes1zfdhidVgw6BeNygephndBid9ueVrcd2h5dHj8/gftj4d3h8dGkP/ef3j2d4h/dEkh/cgBj1eHiBc8kd/PgOlOe7h+cqji+GghqPgCh4
					cmh/7Xgiwcg7hycygf4GgJ1ChQhwc7fz2nfz2nhQh4c8fw2nfw2nhQiAc+f02nf02nhQiCc+f+2nf+2n]],
				["FinF1.L"] = [[
					eSg2erkICJbHpheSg3erheB+aRpSeSg4erkICJbHpheSg4ermvCjb/pseSg3erkICJbHpheSg2erheB+aRpSeSg2erkICJbHpheSg1ermvCjb/pseSg1erkI
					CJbHpheSgyerjgCYbPqieSgreroREEeOtFeSgnesp5FRf9uheSgnesp7FTgAujeKgpe3p6GDfhv3d7gqfXpxITeQzDd1gpgBpYLgcx2dd5gngho8OPbt4rd8
					glgqozPCbb5Pd8glgqozPCbb5Pd8glgqozPCbb5Pd8gmgqozPCbb5Pd8gngqozPCbb5Pd8gngqozPCbb5Pd8gngqozPCbb5Pd8gngqozPCbb5Pd3gmgUpJNA
					cL3wd2glgOpOMjcW3Yd7glgpo0O7be5Kd8glgqozPCbb5Pd8glgqozPCbb5Pd8gmgqozPCbb5Pd8gngqozPCbb5Pd5gpgho8OPbt4rd1grgBpYLgcx2dd7gq
					fXpxITeQzDeKgoe3p6GDfhv3eSgoespKEsfIt4eSguerlGC2cKrheSg0erkXCObQpueSg2ermvCjb/ps]],
				["FinF2.L"] = [[
					d0hBeEhoG+Wrxhd1hHeEfYHEVLw1d0hCeEhoG+Wrxhdzg9eEj3HFYPyEd0hCeEhoG+Wrxhd1hGeEfYHEVLw1d0hAeEhoG+Wrxhdzg6eEj3HFYPyEd0hAeEho
					G+Wrxhdxg8eGhSHZXSybdsgleKlsJDc71UdrgZeOnQKff72idrgZeOnSKigA2kdhgbednRLsfp3ndNgcfJnLO4eu6BdFgbgCm4TEdo8VdKgZgtmkWbc29pdN
					gWg4mdXYcp97dNgWg4mdXYcp97dNgXg4mdXYcp97dNgYg4mdXYcp97dNgYg4mdXYcp97dNgZg4mdXYcp97dNgZg4mdXYcp97dNgYg4mdXYcp97dGgYgamuU8
					dM9HdGgXgTmxUXdU85dNgWg3meXQcr95dNgWg4mdXYcp97dNgXg4mdXYcp97dNgYg4mdXYcp97dNgYg4mdXYcp97dKgbgtmkWbc29pdFgcgCm4TEdo8VdNgc
					fJnLO4eu6BdhgaednRLsfp3ndrgdeMmjJyeh2Bdvg0eHiyH2ZJzndzg+eEh3HCW/xwdzg7eEj3HFYPyE]],
				["FinF1.R"] = [[
					hug2erkI93k5phhug3ermv9dkBpshug4erkI93k5phhug4erhe+ClvpShug3erkI93k5phhug2ermv9dkBpshug2erkI93k5phhug1erhe+ClvpShug1erkI
					93k5phhugyerng8+jRqzhugreroR78hytFhugnesp26wgFuhhugnesp76tgAujhlgpehp67ZfhtNhKgqeLpx83eQpmgjgpd6pY9/cxlEgDgnd1o8+Ybthkf6
					gld1oz+abbglf6gld1oz+abbglf6gld1oz+abbglf6gmd1oz+abbglf6gnd1oz+abbglf6gnd1oz+abbglf6gnd1oz+abbglf6gnd1oz+abbglgRgmd2pJ+Q
					cLjGgXgld3pO+McWjsf7gld1o0+abeguf6gld1oz+abbglf6gld1oz+abbglf6gmd1oz+abbglf6gnd1oz+abbglgDgpd1o8+Ybthkgjgrd6pY9/cxlEhKgq
					eLpx83eQpmhlgoehp67ZfhtNhugoespK7Ug4t4hugueroH8iinrthug0erkX9ykwpuhug2erhe+ClvpS]],
				["FinF2.R"] = [[
					iMhBeEho5CpVxhiNg8eEj347nxyEiMhCeEho5CpVxhiLhHeEfY48q1w1iMhCeEho5CpVxhiNg8eEj347nxyEiMhAeEho5CpVxhiLhFeEfY48q1w1iMhAeEho
					5CpVxhiQgzeFkr4YmJzNiUgleKls29jF1UiVgZeOnO1hgH2iiVgZeOnS1egA2kiJgbeAnR2kfp1ehkgcdhnL5IeuyagvgbdLm47pdouWgEgZdFmk9Ic2rDf4
					gWdFmd9dcpqHf4gWdFmd9dcpqHf4gXdFmd9dcpqHf4gYdFmd9dcpqHf4gYdFmd9dcpqHf4gZdFmd9dcpqHf4gZdFmd9dcpqHf4gYdFmd9dcpqHgXgYdGmu8h
					dMshgegXdHmx8RdUtEf6gWdFme9acrqPf4gWdFmd9dcpqHf4gXdFmd9dcpqHf4gYdFmd9dcpqHf4gYdFmd9dcpqHgEgbdFmk9Ic2rDgvgcdLm47pdouWhkgc
					dhnL5IeuyaiJgaeAnR2kfp1eiVgdeMmj2Ohf2BiRgseHlU32ky0FiNg+eEh34+pBxwiLhFeEfY48q1w1]],
				Tail1 = [[
					gAg3gAfKgAgA/+gAg4gAfKghgE/+gAg4gAfKg/gH/9gAg4gAfKhWgK/8gAg4gAfKhlgM/8gAg3gAfKhqgM/7gAg2gAfKhlgM/8gAg2gAfKhWgK/8gAg2gAfK
					g/gH/9gAg0gAfGghgD/+gAgwgAe+gAgA/+gAgvgAe5fff//9gAgvgAe5fBf+/9gAgxgAe5fxf//+gAgygAe5iIgF/5gAgxgAe5lDgL/kgAgvgAe7ntgR/CgA
					gsgAe8pWgV+lgAgsgAe9q3gY+EgAgtgAe+svgc9UgAgugAfBuxgh8XgAgugAfDwtgl7QgAgvgAfGyagp6JgAgvgAfIzsgs5MgAgugAfJ0fgu4igAgugAfFx5
					go6ggAgtgAfDw7gm7IgAgsgAfHzigs5TgAgsgAfGyagp6JgAgtgAfDwtgl7QgAgugAfBuxgh8XgAgugAe+svgc9UgAgxgAe8qGgX+VgAgzgAe6mGgO/YgAgy
					gAe5iIgF/5gAgwgAe5fVf//9gAgugAe7eaf7/7gAgygAfDeqf5/8gAg1gAfKfBf5/9gAg2gAfKfff8/+]],
				Tail2 = [[
					gAg5gmc8fBf9/1gBg6gmc8f/gF/2gCg6gmc8g+gL/1gDg6gmc8h2gR/ygEg6gmc8ijgV/vgEg5gmc8jAgX/sgEg4gmc8jKgX/rgDg4gmc8jAgU/sgCg4gmc8
					ikgQ/vgBg2gmdIh3gI/zgAgzgmdhg/gB/4f/gxgmdxgAf+/6f+gygmdxfBf8/5f/g0gmdxfEf//5gFg1gmdyf7gJ/6gMg0gkd0gmgW/6gSgyghd4hOgi/5gV
					gvgfd7iNgp/1gYgvgdd9kJgv/pgcgwgad/nJg4/GgfgwgWeCq1hB+BgigxgReHuvhK8TgkgygNeLyXhS6GglgygJeQ1YhY3sglgxgHeT3ihb1jgjgwgOeL11
					hP3SgigwgReJ1fhK3mglgvgKeS4qhV0QgkgvgNeO3jhQ1jgigwgReI1YhJ3sgfgwgWeCyYhB6Ggcgxgad9uvg58TgXg0ged5qFgt+SgOg1gjd0kZgb/ngFg1
					gmdyf7gJ/6f+gzgmdxdhf9/0f8gxgmdqc1f3/vf9g0gmdSc/fx/uf+g3gmc+dcfx/vf/g4gmc8eJf2/y]],
				Tail3 = [[
					f+hAhLa3dcf8/egBhBhLa3epgH/igFhBhLa3f+gR/kgHhBhLa3hUga/igKhBhKa3ihgg/egLhAhKa3jfgj/YgLg/hKa3kGgi/TgKg/hKa3kUge/RgIg/hLa3
					kIgY/TgGg9hLbSjhgM/cgCg5hLcMilgA/qf/g2hLcxhXf6/zf7g3hLcygAf3/1f9g5hLcyfxf7/1gFg6hLczf7gJ/1gNg5hJc3e4gc/0gUg3hHc/dKgt/tga
					g0hFdGcVg5/ogig0hBdLdPhF/ugsg1g8dQf7hT/2g3g2gzdVkHhj/khAg2gndapRhy+dhHg3gZdfurh+8PhKg3gNdkzmiG5FhLg2gDdp3fiJ1fhJg1gRdb3K
					h212hHg1gUdY38hs0/hJg0gCdm74h3vYhJg0gJdg7khtv8hHg1gVdX6IhgyNhCg2gidN3ghU1eg6g2gvdDzohH5Dgtg5g8c7tzg38rgYg6hHc1mEgg/PgFg6
					hLczf7gJ/1f5g4hLczc1f6/rf1g2hKchb3fy/hf2g7hKbpbqfq/Zf4g+hLa8b4fp/Uf6g/hLa3cffy/Y]],
				Tail4 = [[
					f4hMhvZ5b3gF/If+hNhvZ5c+gT/QgEhNhvZ6eZgf/XgKhNhvZ6f9gp/ZgPhNhuZ6higu/XgThMhtZ5i9gu/QgUhLhtZ5kFgq/IgUhLhtZ5k0gi/BgShLhtZ5
					lEgX+/gOhIhuakk2gF/JgIhChwb/kJf1/dgCg+hwc5jBfu/sf7g+hwc7hlfs/zf9hBhwc7hlfu/zgFhChwc6iHf6/xgKhAhvc9glgQ/1gOg+hsdHdKgu/ugR
					g7hpdSaIhI/Tgbg7hmddZEhg/Fgsg7hhdqaIh3/ThAg8hXd2dRiJ/uhVg9hGeBiMiX/xhlg+gveHoUif+vhug+gWeIutif8Phwg+gAeE0biZ4bhug9gOdp1z
					h73Ohsg8gPdd38hm1Ahpg7fudg85hktahpg7f2dU9chOsJhqg7gIdJ9Ag3tJhog8gfdA7jgiv9hfg9g4c74xgS0BhKhAhTc5zVgG5TgmhChqc5qXf++GgFhC
					hwc6iHf6/xfxhAhvc7dhf2/vfrg/huceb3fx/hfshFhubGbKfq/PfuhKhtaAa7fq/AfyhLhuZ5bKf3/B]],
				Tail5 = [[
					fuhaiQXHa7f5+Tf3hbiRXHbpgS+agAhbiSXIcygp+jgKhciSXIeQg8+rgThbiRXIf5hJ+tgZhaiQXIhjhP+rgdhaiPXIjDhO+jgfhZiOXHkPhE+agdhZiPXH
					lBg0+TgZhViQX/lVgZ+ggShLiTZ6lHf9+/gJhFiVbIkXfu/Uf/hGiVbLjLfl/dgAhIiWbLj0fi/ZgKhJiVbMlnfk/HgMhIiUbNk/fu/OgHhEiQbThJgE/ngE
					hAiMbfcRgj/cgLhAiIbvY/hH+5gehAiEcDX3hw+og5hBh8cZY+iZ+6hahChrcwcPi+/dh4hEhPdEhaje/oiNhFgsdTn2j1+qiUhFgHdbulkB8EiThEgQczxu
					jl6NiRhDgKck1WjR3WiFhBfWc87wjYvOiEhAfccp9Vi3r+iGhAfvcT9wiQq6iIhBgMb+9Whmr+iDhCgwbt77g9u9hvhGhdbc4BgX0og9hJiHbQvXf37qgKhJ
					iVbMlnfk/HfrhHiUbLfVfe/nfihHiSakc2fZ/XfhhQiQYvbtfN+2fjhYiPXQa/fN+WfnhZiPXGasfh+Q]],
				["FinB1.L"] = [[
					eSgqgZm/QjfV7HeSgrgZm/QjfV7HeSgrgZm/QjfV7HeSgrgZm/QjfV7HeSgrgZm/QjfV7HeSgqgZm/QjfV7HeSgpgZm/QjfV7HeSgpgZm/QjfV7HeSgpgZm/
					QjfV7HeSgogZmvQife7LeSglgamLQifz7TeSgkgal0QigA7YeSglgalzQigA7ZeVgngllKQlfB7ieigog/lxUBfS9Fe5gnhYlfaTeH+8fPgkhmlKezdW/cfW
					gihplJe7dV/cfWgihplJe7dV/cfWgjhplJe7dV/cfWgjhplJe7dV/cfWgkhplJe7dV/cfWglhplJe7dV/cfWglhplJe7dV/cfWgkhplJe7dV/cfFgjhhlXcU
					dw/PfBgjhelZbtd3/KfVgihplKeydW/bfWgihplJe7dV/cfWgjhplJe7dV/cfWgjhplJe7dV/cfWgkhplJe7dV/cfPgmhmi3dHb8/ee5gohYkOYIdZ+meigo
					g/lxUBfS9FeVgmgllzR6fu8HeSgkgal/Qif67WeSgmgZmhQifm7OeSgpgZm9QifW7HeSgpgZm/QjfV7H]],
				["FinB2.L"] = [[
					dtgagtmlSSfa8IdtgbgtmlSSfa8IdtgcgtmlSSfa8IdtgcgtmlSSfa8IdtgbgtmlSSfa8IdtgagtmlSSfa8IdtgagtmlSSfa8IdtgZgtmlSSfa8IdtgZgtml
					SSfa8IdtgZgtmUSRfi8MdtgXgulvSRf08UdtgWgvlXSRgA8ZdtgXgvlWSRgA8Zdvgcg6knSTer8geDgahclUV3fW93epgZiAlEcReR/UfLgXiRkwgzdj/ifS
					gUiUkwg7di/hfSgUiUkwg7di/hfSgViUkwg7di/hfSgViUkwg7di/hfSgWiUkwg7di/hfSgXiUkwg7di/hfSgXiUkwg7di/hfSgWiUkwg7di/he6gViKk8eU
					d8/fe1gViHk+dteC/dfQgUiTkwgydj/ifSgUiUkwg7di/hfSgViUkwg7di/hfSgViUkwg7di/hfSgWiUkwg7di/hfGggiSh4fAbc/mejgfh+jgaAdC/FeDga
					hclUV3fW93dygYg9lWTsfv9CdtgVgvliSRf68WdtgXgumFSRfp8PdtgZgtmiSSfb8JdtgagtmlSSfa8I]],
				["FinB1.R"] = [[
					hugqgZm/vdgr7HhugrgZm/vdgr7HhugrgZm/vdgr7HhugrgZm/vdgr7HhugrgZm/vdgr7HhugqgZm/vdgr7HhugpgZm/vdgr7HhugpgZm/vdgr7HhugpgZm/
					vdgr7HhugogZmvvegi7LhuglgamLvegN7Thugkgal0vegA7YhuglgalzvegA7ZhwgngPlzvuf97PhwgofykxzPil4/hngnfRkZ4Kjm0MhZgke6k/6kfHxGhV
					gie1lJ6YdVxJhVgie1lJ6YdVxJhVgje1lJ6YdVxJhVgje1lJ6YdVxJhVgke1lJ6YdVxJhVgle1lJ6YdVxJhVgle1lJ6YdVxJhVgke1lJ6YdVxJhggjfElX43
					dwzRhigjfHlZ4fd3zwhVgie1lK6TdWxRhVgie1lJ6YdVxJhVgje1lJ6YdVxJhVgje1lJ6YdVxJhVgke1lJ6YdVxJhZgme6lQ5ndjyRhngofRlm2Ped2Qhwgo
					fykxzPil4/hwgmgPkHxYjA6Yhugkgal/vegG7WhugmgZmhvega7OhugpgZm9vegq7HhugpgZm/vdgr7H]],
				["FinB2.R"] = [[
					iTgagtmltugm8IiTgbgtmltugm8IiTgcgtmltugm8IiTgcgtmltugm8IiTgbgtmltugm8IiTgagtmltugm8IiTgagtmltugm8IiTgZgtmltugm8IiTgZgtml
					tugm8IiTgZgtmUtvge8MiTgXgulvtvgM8UiTgWgvlXtvgA8ZiTgXgvlWtvgA8ZiWgZgjlWuAf98Ricgif8kMxrjr6EiTgnfJkE2zld1YiBgbenkt5gf3yuh7
					gUeikw5Tdiy2h7gUeikw5Tdiy2h7gVeikw5Tdiy2h7gVeikw5Tdiy2h7gWeikw5Tdiy2h7gXeikw5Tdiy2h7gXeikw5Tdiy2h7gWeikw5Tdiy2iJgVe4k83p
					d803iMgVe9k+3PeC1Vh8gUejkw5Ndjy9h7gUeikw5Tdiy2h7gVeikw5Tdiy2h7gVeikw5Tdiy2h7gWeikw5Tdiy2iBgZerk24ddvz6iSgafPlK01el3sicgi
					f8kMxrjr6EiaghggjbvxkI7UiTgVgvlitvgG8WiTgXgumFtvgX8PiTgZgtmitugl8JiTgagtmltugm8I]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Spine1 = [[
					gAgvgAAEgAgAh2gAgygAAFgCgkh1gAgzgAAFgEhCh1gAgxgAAGgFhVh1gAgwgAAGgFhZh1gAgzgAAGgEhNh1gAgzgAAFgDg0h1gAgxgAAEgBgTh2gAgxgAAE
					f/fth2gAgzgAAFf9fMh1gAgzgAAGf8ezh1gAgwgAAGf7enh1gAgxgAAGf7erh1gAgzgAAFf8e+h1gAgygAAFf+fch1]],
				Spine2 = [[
					gAgzfdAGgAgAiJf/g2fdAGgCgkiJf+g3fdAHgEhCiJf9g1fdAHgGhViJf9g0fdAIgGhZiJf9g3fdAHgFhNiJf+g3fdAGgEg0iJf/g1fdAGgBgTiJgBg1fdAG
					f/ftiJgCg3fdAGf8fMiJgDg3fdAHf7eziJgDg0fdAIf6eniJgDg1fdAHf6eriJgCg3fdAHf8e+iJgBg2fdAGf+fciJ]],
				Spine3 = [[
					gAg3e6AigAgAlvf+g7e6AjgHgklvf7g8e6AjgMhBlvf6g6e6AkgPhUlvf6g4e6AkgQhXlvf7g7e6AkgOhMlvf8g8e6AjgJg0lvf/g5e6AigDgSlvgBg5e6Ai
					f9fulvgEg8e6Ajf3fMlvgFg7e6Akfye0lvgGg4e6AkfweplvgGg6e6AkfxeslvgFg8e6Ajf0e/lvgCg7e6Ajf5fclv]],
				Spine4 = [[
					gAhEeZAigAgAlvf8hHeZAjgHgklvf5hIeZAjgMhBlvf3hHeZAkgPhUlvf3hFeZAkgQhXlvf4hIeZAkgOhMlvf7hIeZAjgJg0lvf+hGeZAigDgSlvgChGeZAi
					f9fulvgFhIeZAjf3fMlvgIhIeZAkfye0lvgJhFeZAkfweplvgJhHeZAkfxeslvgHhIeZAjf0e/lvgEhHeZAjf5fclv]],
				Head = [[
					gAhQd4ALgAgAjMf7hUd4AKf/f5i+f3hVd4ALf/fzjHf1hTd4AOf+fvjhf0hRd4ARf+fuj8f2hUd4ASf+fxkFf5hVd4AQf/f2j2f+hSd4ANgAf8jagChSd4AK
					gAgEjDgHhVd4AKgBgKjAgKhUd4AMgCgPjTgMhRd4APgCgSjwgLhTd4ASgCgRkDgJhVd4ARgCgNkAgFhUd4AOgBgHjp]],
				Jaw = [[
					gAhVdK/8gAgAhqf7hXdK/7gAgHh4f4hZdK/8f/gNhvf1hYdL/9f/gRhVf1hYdL/+f/gSg6f2hbdL/+gAgPgxf5hbdL/+gAgKhAf+hXdK/9gAgEhcgChWdK/8
					gAf8hzgHhYdK/8gBf2h3gKhZdL/9gBfxhjgLhXdL/+gBfuhGgLhadL/+gAfvgzgIhcdL/+gAfzg2gFhZdK/+gAf5hN]],
				["Cheek.L"] = [[
					ewhuc6fxJZgP2nerhxc5fnJUgZ2ieohzc5ftJPgT2eelhyc6gAJNgA2belhyc7gTJMft2bemh2c7gZJOfn2ceph1c7gPJRfx2gethxc6f7JWgF2leyhwc6fq
					JbgW2qe2hyc7foJggY2ve5hzc8f2JkgK2ye6hxc9gKJlf220e6h0c+gYJlfo2ze4h2c9gWJifq2xe0hzc8gFJef72t]],
				["Cheek.R"] = [[
					hQhuc6fx2nfx2nhMhxc6fn2ifn2shIhzc7ft2eft2xhGhyc9gA2bgA2zhGhyc+gT2bgT20hHh2c9gZ2cgZ2yhKh1c8gP2ggP2vhOhxc7f72lf72qhThwc6fq
					2qfq2lhXhyc5fo2vfo2ghahzc6f22yf22chbhxc6gK20gK2bhbh0c7gY2zgY2bhYh2c7gW2xgW2ehVhzc7gF2tgF2i]],
				["FinF1.L"] = [[
					eSgnespqJRdx0MePgqewnpIecKz6eMgrezlzHLbeyyeLgqe1keFob5xCeLgoe2j/EHdLu5eMgre0kkC+e4skeOgrexmJCYgfqWeQgpeuoaCchworeTgpeqpq
					CriRoDeWgremptC3iEoseYgrekpzDahgqXeZgoeip5EZgrsveZgqejp6FvfuvUeXgrelp2HOe0xoeVgqeopvIheIzV]],
				["FinF2.L"] = [[
					digZeinGQKeX60degkemk9Pcbu6kdcgseli+N/Z+5kddgtehhfL/Zd4Cdhgqeag8JzaK2QdngoeRhkHzb10bdvgkeJjTGZeDyyd4gceDlwF5gdxjd+gbd+nG
					F8hrxDd/gdd7nIGUhhxod9gdd8nNHYhGzFd3gaeAnRJFgf1FdxgbeHnSLMfz3LdrgdeRnPNYfJ4+dmgceanKPLeo6N]],
				["FinF1.R"] = [[
					hugnespq9TdxoLhrgqeopr9SdyoPhpgrelpw86eMpbhngqejp38Ke5rfhngoeip76/f0uChogrekp55igwwihqgrempz4Fhkykhtgpeqps3BiGz3hwgpeuop
					3EjJ0Lhygrexmr4IkVzch0gre0lC5mkdx+h1goe2kG7KjjwAh1gqe1kJ8hiAtvh0grezlQ9agTrahxgqewnO9se2pb]],
				["FinF2.R"] = [[
					iEgZeAnG5/eXxKiBgcd8nG59eYxNiCgdd7nK5PeryQiGgbd9nP32fM0CiMgaeDnS16f32JiSgdeMnRztgj4IiYgdeWnMxphJ5qicgbefnHwOhi6miggfekmC
					wGjD6zikgpemj7xNlT6JikgtekiIy+md42iigreehF1HmV3KicgqeWhH3RlG1ViVgmeNiU5AjHzkiMggeGke5/gxyG]],
				Tail1 = [[
					gAgvgAenh+gF/5gAgygAenhRgE/7gAgzgAengWgB/9gAgxgAenfXf+/9gAgwgAeneff8/7gAgzgAend4f6/5gAgzgAendpf5/3gAgxgAend0f6/4gAgxgAen
					eWf7/6gAgzgAenfMf+/8gAgzgAengKgA/9gAgwgAenhGgD/8gAgxgAenh3gF/6gAgzgAeniTgG/4gAgygAeniVgH/4]],
				Tail2 = [[
					gFgygldPlIgL/dgDg1gmdOjvgH/pgBg3gmdOhtgC/0f+g1gmdOfXf8/3f8gzgmdOdJf4/vf7g2gldPbaf0/if6g2gldPaffz/Zf7g0gldPagf0/Zf8g0gmdP
					bef3/jf+g2gmdOdOf7/vgAg2gmdOfdgB/3gDgzgmdOhzgG/0gEg1gmdOj0gK/pgFg3gldPlKgN/cgFg1gldPlogN/X]],
				Tail3 = [[
					gRg5hJcBoOgO+qgMg8hKcAnBgG+9gFg9hLb+klf9/Zf9g7hLb9hVf1/tf2g6hKb+d1fu/qfwg9hJb/avfr/Tfug9hIcAYlfr+2fug6hJcBXsfv+ofyg6hJcA
					YOf2+xf4g9hLb/aFf+/Lf/g9hLb+c+gH/lgHg6hLb9gbgP/ugNg7hKb+jzgU/ggRg9hJb/mfgW/EgTg8hIcAoDgU+t]],
				Tail4 = [[
					gjhChpb3qGgB+EgchFhrb3pyfx+LgPhGhub2n0fj+vgAhFhwb2kefb/ZfxhDhvb2gTfZ/tfkhGhsb2cFfe/efdhGhpb2Ylfp+1fbhEhob3WZf3+OfghEhqb3
					V2gI+DfqhGhtb2XAgW+af4hGhvb2Ztgi/FgIhDhwb2djgn/ngWhFhtb2h3gl/qgghGhqb2l0gd/LglhFhob3otgQ+g]],
				Tail5 = [[
					g6hLiGZ7qEgq9vgyhOiJZ7rDgM9ZghhQiOZ7qMfs9tgLhOiTZ6nmfP+dfyhNiTZ6joe6/LfbhQiPZ6e+ey/XfMhQiKZ6ahe3+5fGhNiGZ7XFfJ+GfJhNiHZ7
					VOfk9ffVhPiLZ7VKgE9efphPiRZ6W6gj+DgChNiUZ6aQg9+3gahPiSZ6erhL/WguhQiNZ6jVhN/Ng4hPiHZ7nYhB+g]],
				["FinB1.L"] = [[
					eSgkgalqKxhU3NeTgogeltLphG3/eUgpghlxNYgs5WeUgngjlzPwgL67eUglgjlzSZfn8XeUgogilvU1fI9aeTgpgglrWjez+AeSgmgclqXNer+NeRgmgYlS
					Wbdd99eRgpgUkiUaba9HeQgogSjrR1aR72eQglgQi3PJaQ6aeQgngRicMybU5BeQgpgTiwLIdI36eRgogWj6KZfQ3Q]],
				["FinB2.L"] = [[
					dngWgclNMPhN4kdogagklQNKhA5TdrgbgtlUO/gp6jdugZg2lWRdgK7/dygXg9lVUNfp9Qd3gahBlSWtfM+Id6gbhClPYde5+od6gYg/lNZIey+yd3gag6kr
					YTdN+kdxgig0joWPad9udsgmgsiqTmYt8cdngngkh6Q0YU7BdlgqgdhqOWZU5xdkgogZiIMjbd45dlghgZjZLzeQ4g]],
				["FinB1.R"] = [[
					hugkgalqo7hU+KhvgogWk7qfjq9mhwgpgTkHs2lT8hhwgngRjQvil57JhwglgQilyHlW5shwgogSif0Kj34ahvgpgUjP1Yh13ghvgmgYkv1kft3Jhugmgclr
					06ey3ghtgpgglvzmfG4nhsgogilyxgfk6Jhsglgjlzu8gH7shsgngjlxsVgp88hsgpghltqNhE9whtgogelqo+hT+J]],
				["FinB2.R"] = [[
					iHgWg9lNnAhN+wiMgeg3kJopkR+OiSglgwjIrDml9IiXgngoiQtznr7uiagogghtwfnW6Wicgqgahyyrlv5RicglgYirz+jM4piagcgakR0JgR4fiYgYgglO
					zbe442iXgbgolSyCfK54iUgagxlVv2fm7RiQgXg6lWtLgH8qiLgZhAlUqfgm9viIgbhClQoTg/+biGgahBlOnEhM+v]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Spine1 = [[
					gAg3gAAHgAgAiegAhDf8AKgAgAi8gAhJf7AJgAgAiwgAhDf8AFgAgAiDgAg3gAACgAgAhNgAg3gAACgAgAgvgAg3gAACgAgAg7gAg3gAAEgAgAho]],
				Spine2 = [[
					gAg8fdAJgAgAixgAhKfaAMgAgAjPgAhPfYAKgAgAjEgAhIfZAHgAgAiWgAg5fdADgAgAhhgAg4fdACgAgAhDgAg5fdACgAgAhOgAg6fdAFgAgAh8]],
				Spine3 = [[
					gAhCe6AqgAgAmXgAhRe3AwgAgAm0gAhVe1AugAgAmpgAhNe2AlgAgAl8gAg9e6AbgAgAlIgAg6e5AXgAgAkqgAg7e6AYgAgAk1gAg+e6AggAgAli]],
				Spine4 = [[
					gAhQeaAqgAgAmXgAhgeXAwgAgAm0gAhkeVAugAgAmpgAhaeVAlgAgAl8gAhIeYAbgAgAlIgAhFeYAXgAgAkqgAhGeYAYgAgAk1gAhKeZAggAgAli]],
				Head = [[
					gAhed5AJgAgAiwgAhud3AKgAgAi/gAhyd1AOgAgAjigAhnd1ASgAgAkFgAhTd3AUgAgAkTgAhPd2ASgAgAkEgAhQd2ANgAgAjggAhWd3AKgAgAi+]],
				Jaw = [[
					gAhhdM/qgAgAkmgAhydJ/sgAgAkXgAh3dH/wgAgAj0gAhudH/0gAgAjRgAhadJ/2gAgAjDgAhWdJ/0gAgAjTgAhVdJ/wgAgAj2gAhadK/sgAgAkY]],
				["Cheek.L"] = [[
					ewh6c7fdJZgj2newiLc5foJZgY2newiRc4gBJZf/2newiIc5gZJZfn2newh1c7gjJZfd2newhwc6gYJZfo2newhvc5f/JZgB2newhzc5fnJZgZ2n]],
				["Cheek.R"] = [[
					hQh6c7fd2nfd2nhQiLc5fo2nfo2nhQiRc4gB2ngB2nhQiIc5gZ2ngZ2nhQh1c7gj2ngj2nhQhwc6gY2ngY2nhQhvc5f/2nf/2nhQhzc5fn2nfn2n]],
				["FinF1.L"] = [[
					eSgyerp6Kycs1ieShBeolVHoZByxeShGemiFDta7t3eSg9eojeBegBo5eSgrespXCSjfmTeSgpespZC8jEpAeSgqespgFUgxu1eSguesplI6eFz3]],
				["FinF2.L"] = [[
					dhgkeonhSHdm7udhhIedixOzXU5YdqhReJfRJoW308d3g6d9goFPcCxDeCgbd/mqE7iqvcd7gYeDmhGYiZx2drgaePmoKjgo2xdjgfehm9Ptem6m]],
				["FinF1.R"] = [[
					hugyerp61OjU1ihuhBeolV4Ym/yxhuhGemiF8TlFt3hug9eoje+if/o5hugrespX9uchmThugpespZ9Ec8pAhugqespg6sfPu1huguespl3Gh7z3]],
				["FinF2.R"] = [[
					ifgkeonht5ia7uifhIedixxNos5YiWhReJfR2YpJ08iJg6d9go6xj+xDh+gbd/mq7FdWvciFgYeDmh5odnx2iVgaePmo1dfY2xidgfehm9wTha6m]],
				Tail1 = [[
					gAg3gAe9gAgA/+gAhDf8ePgAgA/8gAhJf7dlgAgA/5gAhDf8dWgAgA/4gAg3gAdtgAgA/6gAg3gAeagAgA/8gAg3gAfFgAgA/+gAg3gAfTgAgA//]],
				Tail2 = [[
					gAg5gmeFgAgA/7gAhIgicHgAgA/wgAhOggadgAgA/ggAhKgiaGgAgA/cgAg8gmbPgAgA/ogAg6gmdOgAgA/3gAg5gme4gAgA/+gAg4gmfPgAgA/+]],
				Tail3 = [[
					gAg+hMd9gAgA/7gAhRhHa7gAgA/lgAhbhEYEgAgA+/gAhXhFXAgAgA+sgAhHhKYVgAgA/DgAhBhLbUgAgA/pgAg7hMePgAgA/8gAg6hMfVgAgA//]],
				Tail4 = [[
					gAhChxfMgAgA/+gAhdhrblgAgA/rgAhuhlXigAgA+2gAhshlVZgAgA+LgAhZhrWUgAgA+fgAhMhvZ0gAgA/YgAhAhxd7gAgA/7gAg8hygKgAgA//]],
				Tail5 = [[
					gAhEiXeXgAgA/8gAhniPa0gAgA/kgAiBiGV9gAgA+XgAiEiDSrgAgA9FgAhviKStgAgA9GgAhaiSWCgAgA+ZgAhEiXa5gAgA/lgAg7iYeZgAgA/8]],
				["FinB1.L"] = [[
					eSgrgah/L1bS4SeSg3gWlfJ0fz2ZeSg9gUmWLGgo3WeSg5gWl+PbgI6seSgtgalKU5fV9jeSgugbkkYAez+neSgugbjUVtaf9meSgsgahxQnYu7B]],
				["FinB2.L"] = [[
					dmgvgihQNVZI5BdmgtgVlELOfT3xdngvgXl8Mlgk4tdrgqgolhRHgI7xd1ggg6ksWxfX+Qd8gjhAkHZ8e2/Hd1gqg9iPXiZT+CdsgygygjSXWb7T]],
				["FinB1.R"] = [[
					hugrgah/0Lku4Shug3gWlf2MgN2Zhug9gUmW06fY3Whug5gWl+wlf46shugtgalKrHgr9jhugugbkkoAhN+nhugugbjUqTlh9mhugsgahxvZnS7B]],
				["FinB2.R"] = [[
					iagvgihQyrm45BiagtgVlE0ygt3xiZgvgXl8zbfc4tiVgqgolhu5f47xiLggg6kspPgp+QiEgjhAkHmEhK/HiLgqg9iPoemt+CiUgygygjtppl7T]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Spine1 = [[
					gAgvgAAEgAgAh2gAgxgDAGgAgAiKgAg1gKAKgAgAi/gAg6gSAQgAgAj7gAg+gXAWgAgAkigAg6gEAMgAgAjUgAg3fWACgAgAgugAg3fWACgAgAgugAg3fWAC
					gAgAgugAg2fXACgAgAgvgAg1fgACgAgAg+gAgyfuADgAgAhXgAgwf7AEgAgAhugAgvgAAEgAgAh2gAgvgAAEgAgAh2gAgvgAAEgAgAh2]],
				Spine2 = [[
					gAgzfdAGgAgAiJgAg1fgAHgAgAiegAg8fnAMgAgAjTgAhDfvATgAgAkOgAhIf1AZgAgAk1gAhCfiAOgAgAjngAg4ezACgAgAhCgAg4ezACgAgAhCgAg4ezAC
					gAgAhCgAg4e0ACgAgAhDgAg3e8ADgAgAhRgAg1fLAEgAgAhrgAgzfYAFgAgAiBgAgzfdAGgAgAiJgAgzfdAGgAgAiJgAgzfdAGgAgAiJ]],
				Spine3 = [[
					gAg3e6AigAgAlvgAg7e9AkgAgAl4gAhDfEAogAgAmMgAhMfNAtgAgAmkgAhSfTAwgAgAmzgAhKe/AtgAgAmkgAg6eQApgAgAmSgAg6eQApgAgAmSgAg6eQAp
					gAgAmSgAg6eQApgAgAmSgAg6eZAngAgAmLgAg5eoAlgAgAl+gAg4e1AjgAgAlzgAg3e6AigAgAlvgAg3e6AigAgAlvgAg3e6AigAgAlv]],
				Spine4 = [[
					gAhEeZAigAgAlvgAhHecAhgAgAlngAhQekAdgAgAlSgAhaetAZgAgAk6gAhhezAXgAgAkrgAhYefAigAgAlvgAhIdvBKgAgAodgAhIdvBKgAgAodgAhIdvBK
					gAgAodgAhIdwBJgAgAobgAhHd4BAgAgAn4gAhGeHAxgAgAm6gAhEeUAmgAgAmCgAhEeZAigAgAlvgAhEeZAigAgAlvgAhEeZAigAgAlv]],
				Head = [[
					gAhQd4ANgAgAjhgAhUd7AQgAgAj2gAhceCAXgAgAkrgAhleLAhgAgAlmgAhreRAogAgAmNgAhkd+AdgAgAlRgAhadRANgAgAjhgAhadRANgAgAjhgAhadRAN
					gAgAjhgAhadRANgAgAjhgAhYdZANgAgAjhgAhVdnANgAgAjhgAhSdzANgAgAjhgAhQd4ANgAgAjhgAhQd4ANgAgAjhgAhQd4ANgAgAjh]],
				Jaw = [[
					gAhWdK//gAgAgfgAhadN/9gAgAhjgAhkdV/zgAgAjhgAhwdf/vgAgAj+gAh4dl/YgAgAmOgAhudR+fgAgAptgAhfcj/8gAgAhzgAhfcj/wgAgAj7gAhfcj/9
					gAgAhdgAhfck//gAgAgfgAhdcs//gAgAgfgAhac6//gAgAgfgAhXdG//gAgAgfgAhWdK//gAgAgfgAhWdK//gAgAgfgAhWdK//gAgAgf]],
				["Cheek.L"] = [[
					ewhwc7gAJZgA2neuh0c+gPJZfx2neriAdIg0JZfM2neoiNdThfJceh2kemiWdah6JeeG2iepiLdFhPJbex2lewh5cUgAJZgA2newh5cUgAJZgA2newh5cUgA
					JZgA2newh5cUgAJZgA2newh3ccgAJZgA2newh0cqgAJZgA2newhxc2gAJZgA2newhwc7gAJZgA2newhwc7gAJZgA2newhwc7gAJZgA2n]],
				["Cheek.R"] = [[
					hQhwc7gA2ngA2nhSh0c+gP2ngP2nhViAdIg02ng02nhYiNdThf2khf2khaiWdah62ih62ihXiLdFhP2lhP2lhQh5cUgA2ngA2nhQh5cUgA2ngA2nhQh5cUgA
					2ngA2nhQh5cUgA2ngA2nhQh3ccgA2ngA2nhQh0cqgA2ngA2nhQhxc2gA2ngA2nhQhwc7gA2ngA2nhQhwc7gA2ngA2nhQhwc7gA2ngA2n]],
				["FinF1.L"] = [[
					eSgnesp7FTgAujeSgqeupWEyfit+eSgze1nvDpebsieSg+e9lqCodUrAeShEfCkMCIcrqGeSg6ewmgDkdUs1eSgpeDpDIhe7zteSgpeDpDIhe7zteSgpeDpD
					Ihe7zteSgpeDpEIee8zpeSgoeMpTHwfLypeSgoeappGkfkw1eSgnenp3Fnf5vJeSgnesp7FTgAujeSgnesp7FTgAujeSgnesp7FTgAuj]],
				["FinF2.L"] = [[
					drgZeOnSKigA2kdsgfePm7J8fU2GdtgueSl2Indp04dwg/eXkWHYb3zgdzhKebjPGvaxyodsg6eOk9IxcP1Fdjgad3mOPNfN6fdjgad3mOPNfN6fdjgad3mO
					PNfN6fdjgad3mPPJfN6cdkgZd8mgOIfa5tdngZeEm5Mcft4WdqgZeLnMLBf73DdrgZeOnSKigA2kdrgZeOnSKigA2kdrgZeOnSKigA2k]],
				["FinF1.R"] = [[
					hugnesp76tgAujhugqeupW7Oget+hugze1nv8Xhlsihug+e9lq9YisrAhuhEfCkM94jVqGhug6ewmg8ciss1hugpeDpD3fhFzthugpeDpD3fhFzthugpeDpD
					3fhFzthugpeDpE3ihEzphugoeMpT4Qg1yphugoeapp5cgcw1hugnenp36ZgHvJhugnesp76tgAujhugnesp76tgAujhugnesp76tgAuj]],
				["FinF2.R"] = [[
					iVgZeOnS1egA2kiUgfePm72Egs2GiTgueSl23ZiX04iQg/eXkW4okJzgiNhKebjP5RlPyoiUg6eOk93Pjx1Fidgad3mOwzgz6fidgad3mOwzgz6fidgad3mO
					wzgz6fidgad3mPw3gz6cicgZd8mgx4gm5tiZgZeEm5zkgT4WiWgZeLnM0/gF3DiVgZeOnS1egA2kiVgZeOnS1egA2kiVgZeOnS1egA2k]],
				Tail1 = [[
					gAgvgAfKgAgA/+gAgxgDfCgAgA/+gAg1gKetgAgA/9gAg6gSeVgAgA/8gAg+gXeFgAgA/7gAg6gEeMgAgA/8gAg3fWeEjtfy/tgAg3fWeDiTf3/2gAg3fWeD
					dtgJ/2gAg2fXeFcWgO/ugAg1fgeTgAgA/8gAgyfueshlf8/7gAgwf7fDgQgA/+gAgvgAfKgAgA/+gAgvgAfKgAgA/+gAgvgAfKgAgA/+]],
				Tail2 = [[
					gAgxgmeVgAgA/8gAgzgpeGgAgA/7gAg4gvdhgAgA/5gAg+g3c3gAgA/1gAhCg8ccgAgA/ygAg/gqc1fbgE/1gJg7f7dQl+fr/TgFg7f8dQl+fm/Tf7g7f8dO
					dtgF/yf3g7f8dSYvgc/CgAg5gFddeOgJ/1gEg1gUd3ijf6/0gBgygheNgqf+/7gAgxgmeVgAgA/8gAgxgmeVgAgA/8gAgxgmeVgAgA/8]],
				Tail3 = [[
					gAg1hMdngAgA/5gAg3hOdTgAgA/4gAg+hVcegAgA/ygAhGhcbigAgA/rgAhLhha7gAgA/lf/hGhPbmehgL/pgXhBgecjl+f0/PgThBgecmpjfT+Vf1hCghch
					f/fx/zfnhBgdcnWkgi+Xf8g/gqcxbWgb/egKg6g5dKikf+/wgCg2hHdghEf9/4gAg1hMdngAgA/5gAg1hMdngAgA/5gAg1hMdngAgA/5]],
				Tail4 = [[
					gAg6hxeBgAgA/7gAg+h0dmgAgA/5gAhGh6cigAgA/zgAhQiBbUgAgA/pgAhXiFaigAgA/hf7hRhzbfdngY/kglhJhAc+jvgJ/ogphIg9dArrey9nf1hKhGc+
					jofG/ofRhIg8dAWkgq+afxhGhOdMYig++9gQhBhedkhmgG/2gFg8hsd5hUf6/5gAg6hxeBgAgA/7gAg6hxeBgAgA/7gAg6hxeBgAgA/7]],
				Tail5 = [[
					gAg/iXchgAgA/zgAhDiZcAgAgA/vgAhPifasgAgA/jgAhbilZOgAgA/QgAhjipYQgAgA/Cf1hbiXZfdCgX/LgthQhkblgFhA/qhDhOhYbmrtfV9bf+hRhqbl
					nRem+ze8hOhabmYtfz+1ffhMhvbxWzg8+VgUhHiDcFgCgc/vgIhBiScZhUf+/wgAg/iXchgAgA/zgAg/iXchgAgA/zgAg/iXchgAgA/z]],
				["FinB1.L"] = [[
					eSgkgalzQigA7ZeSgmgcl/Qgfr7VeSgpgjmdQce27KeSgtgqm+Qad66+eSgvgunTQbdS61eSgugdmlRAeR7beSgufxkyS+f980eSgufxkyS+f980eSgufxky
					S+f980eSgufykzS8f98zeSgsf6lBSbf+8heSgogJlZRjgA8BeSglgWltQygA7jeSgkgalzQigA7ZeSgkgalzQigA7ZeSgkgalzQigA7Z]],
				["FinB2.L"] = [[
					dtgWgvlWSRgA8ZdsgYgxljSPfs8Vdsgbg3mESMe58Ldsgfg9mpSLd/7/drgihBnBSMdY73dtgggzmPSyeV8adxgigNkTUyf79pdxgigNkTUyf79pdxgigNkT
					Uyf79pdxgigNkUUwf79odwgfgVkiUOf99Zdugbghk6TVf/89dtgYgrlPSigA8idtgWgvlWSRgA8ZdtgWgvlWSRgA8ZdtgWgvlWSRgA8Z]],
				["FinB1.R"] = [[
					hugkgalzvegA7Zhugmgcl/vggV7VhugpgjmdvkhK7Khugtgqm+vmiG6+hugvgunTvliu61hugugdmlvAhv7bhugufxkytCgD80hugufxkytCgD80hugufxky
					tCgD80hugufykztEgD8zhugsf6lBtlgC8hhugogJlZudgA8BhuglgWltvOgA7jhugkgalzvegA7ZhugkgalzvegA7ZhugkgalzvegA7Z]],
				["FinB2.R"] = [[
					iTgWgvlWtvgA8ZiUgYgxljtxgU8ViUgbg3mEt0hH8LiUgfg9mpt1iB7/iVgihBnBt0io73iTgggzmPtOhr8aiPgigNkTrOgF9piPgigNkTrOgF9piPgigNkT
					rOgF9piPgigNkUrQgF9oiQgfgVkirygD9ZiSgbghk6srgB89iTgYgrlPtegA8iiTgWgvlWtvgA8ZiTgWgvlWtvgA8ZiTgWgvlWtvgA8Z]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAgvgAAEgAgAh2gAgvgAAEgAgAhvgAgvgAADgAgAhggAgvgAADgAgAhUgAgvgAADgAgAhWgAg5gEAKgAgAjBgAhKgLAdgAgAlQgAhOgNAigAgAlugAhOgNAi
					gAgAlugAhOgNAigAgAlugAhOgNAigAgAlugAhOgNAigAgAlugAhOgNAigAgAlugAhOgNAigAgAlugAhOgNAigAgAlugAhOgNAigAgAlugAhOgNAigAgAlugA
					hNgNAhgAgAlpgAhCgIATgAgAkTgAg0gCAHgAgAidgAgvgAAEgAgAh2gAgvgAAEgAgAh2gAgvgAAEgAgAh2]],
				Spine2 = [[
					gAgzfdAGgAgAiJgAgzfdAFgAgAiDgAgyfdAEgAgAh0gAgyfdAEgAgAhngAgyfdAEgAgAhqgAhAfiAMgAgAjUgAhVfqAggAgAljgAhafsAmgAgAmBgAhafsAm
					gAgAmBgAhafsAmgAgAmBgAhafsAmgAgAmBgAhafsAmgAgAmBgAhafsAmgAgAmBgAhafsAmgAgAmBgAhafsAmgAgAmBgAhafsAmgAgAmBgAhafsAmgAgAmBgA
					hZfsAlgAgAl8gAhMfmAWgAgAkmgAg5ffAJgAgAiwgAgzfdAGgAgAiJgAgzfdAGgAgAiJgAgzfdAGgAgAiJ]],
				Spine3 = [[
					gAg3e6AigAgAlvgAg3e6AhgAgAlpgAg2e6AegAgAlagAg1e6AcgAgAlOgAg1e6AdgAgAlQgAhHe/A5gAgAncgAhifJBygAgAqegAhnfLCBgAgArHgAhnfLCB
					gAgArHgAhnfLCBgAgArHgAhnfLCBgAgArHgAhnfLCBgAgArHgAhnfLCBgAgArHgAhnfLCBgAgArHgAhnfLCBgAgArHgAhnfLCBgAgArHgAhnfLCBgAgArHgA
					hmfLB+gAgArBgAhWfEBXgAgApKgAg/e8AtgAgAmngAg3e6AigAgAlvgAg3e6AigAgAlvgAg3e6AigAgAlv]],
				Spine4 = [[
					gAhEeZAigAgAlvgAhDeZAhgAgAlpgAhCeYAegAgAlagAhBeYAcgAgAlOgAhBeYAdgAgAlQgAhXegA5gAgAncgAh3etBygAgAqegAh+ewCBgAgArHgAh+ewCB
					gAgArHgAh+ewCBgAgArHgAh+ewCBgAgArHgAh+ewCBgAgArHgAh+ewCBgAgArHgAh+ewCBgAgArHgAh+ewCBgAgArHgAh+ewCBgAgArHgAh+ewCBgAgArHgA
					h9ewB+gAgArBgAhpenBXgAgApKgAhNecAtgAgAmngAhEeZAigAgAlvgAhEeZAigAgAlvgAhEeZAigAgAlv]],
				Head = [[
					gAhQd4ANgAgAjhgAhQd4AKgAgAjAgAhOd3AEgAgAh1gAhMd3ACgAgAg5gAhMd3ACgAgAhEgAhneAAsgAftmigAiNeRCugKfOs3gAiVeVCyfrhos6gAiVeVDM
					gHfjt5gAiVeVDZgTexuPgAiVeVCzfthgs+gAiVeVDGgAgAtrgAiVeVDdgYehuWgAiVeVC2fwhPtGgAiVeVC/f6getegAiVeVDfgaeZuagAiVeVC6f0g5tRgA
					iUeVC1f1g4tFgAh9eJB0gIe+qigAhcd8AcgAgFlJgAhQd4ANgAgAjhgAhQd4ANgAgAjhgAhQd4ANgAgAjh]],
				Jaw = [[
					gAhWdK//gAgAgfgAhTdK/+gAgAhOgAhOdJ/3gAgAi2gAhKdJ/tgAgAkLgAhKdJ/vgAgAj8gBh1dU/4f7gTimgCirdv/yffgmjhf7i0dz/hhKe0lMgBi2d1/u
					fqgVkJgEi3d2/vfFg3jwf8i0d0/ihEe6lIgAi1d1/sgAgAkYgEi3d3/we4hCjof8i0d0/kg5fGlAf/i1d0/pgWfrkngFi3d3/weyhIjjf9i0d0/ngpfXk1f9
					izdz/ogofXkvgDiVdj/4feg6ibgAhldP/+gBf7hJgAhWdK//gAgAgfgAhWdK//gAgAgfgAhWdK//gAgAgf]],
				["Cheek.L"] = [[
					ewhwc7gAJZgA2newhtc6foJZgY2newhmc3ezJbhN2lewhhc1eJJdh32jewhic2eQJdhw2jeuiSdJiIJRd12TerjNdummJ5ZF1DehjOd+nKLlZk2qepjXd4na
					KXYY1Besjad3neJ8X60YeijOd+nLLgZf2kenjVd5nXKnYp1Zetjbd2nfJ0Xx0LejjPd9nNLWZW2XeljTd7nUK4Y61weujcd2ngJwXs0EekjRd8nQLIZJ2Fek
					jPd6nHLFZR2Ieui2dbk5JQay1UeuiBdDhKJee22pewhwc7gAJZgA2newhwc7gAJZgA2newhwc7gAJZgA2n]],
				["Cheek.R"] = [[
					hQhwc7gA2ngA2nhQhtc6fo2nfo2nhQhmc3ez2lez2lhQhhc1eJ2jeJ2jhQhic2eQ2jeQ2jhUiRdMiL2TiI2vhbjId1m71Dmm2HhSjYdvmc2qnK0bhbjTd8no
					1Bna1phdjReBoG0Yne2EhTjYdwmh2knL0ghZjVd5nX1ZnX1ZhejQeDoP0Lnf2MhUjXdxmq2XnN0qhXjWd2nG1wnU1IhfjQeEoU0Eng2QhVjXd0m32FnQ04hV
					jVdymv2InH07haixdllO1Uk52whRiBdChK2phK2ihQhwc7gA2ngA2nhQhwc7gA2ngA2nhQhwc7gA2ngA2n]],
				["FinF1.L"] = [[
					eSgnesp7FTgAujeSgmespsFef1vBeSglespMF5fbwCeSgkesoxGRfEw0eSgkeso1GMfHwreSg4ewn5DhepsJeShUe3kKBMdvnKeShbe5gqA3dEmreShbe5it
					A4dgmWeShbe5jeA6drmOeShbe5gyA3dFmqeShbe5iQA3dambeShbe5juA7dvmMeShbe5hCA3dJmoeShbe5hzA2dUmgeShbe5j2A8dxmKeShbe5hYA2dOmkeS
					hae5hmA5dPmseShIe0mjCEeSpBeSgveto9EQfWtIeSgnesp7FTgAujeSgnesp7FTgAujeSgnesp7FTgAuj]],
				["FinF2.L"] = [[
					drgZeOnSKigA2kdqgYePnEK3fz28dogYeTmmLnfV3vdmgYeVmNMOe74VdmgYeVmRMHe/4PdugyeMlYIOdL0hd7hYeKh7E5Zkvmd9hjeMerExXrugd9hheLgl
					EgYnukd+hgeLhSEcY+uld9hjeMezEwXvuhd9hheLgKEjYaukd+hfeLhgEbZFuld9hjeMfCEtX2uhd9hieMfvEnYMujd+hfeLhoEbZJuld9hieMfWEqYAuid9
					hheMfjEtYIutd2hHeJkJGCbhxpdtgleMmaJJep1ZdrgZeOnSKigA2kdrgZeOnSKigA2kdrgZeOnSKigA2k]],
				["FinF1.R"] = [[
					hugnesp76tgAujhugmesps6igLvBhuglespM6HglwChugkesox5vg8w0hugkeso150g5wrhug4ewn58fhXsJhuhUe3kK+0iRnKhuhbe5gq/Ji8mrhuhbe5it
					/IigmWhuhbe5je/GiVmOhuhbe5gy/Ji7mqhuhbe5iQ/Jimmbhuhbe5ju/FiRmMhuhbe5hC/Ji3mohuhbe5hz/Kismghuhbe5j2/EiPmKhuhbe5hY/Kiymkhu
					hae5hm/HixmshuhIe0mj98hupBhugveto97wgqtIhugnesp76tgAujhugnesp76tgAujhugnesp76tgAuj]],
				["FinF2.R"] = [[
					iVgZeOnS1egA2kiWgYePnE1JgN28iYgYeTmm0Zgr3viagYeVmNzyhF4ViagYeVmRz5hB4PiSgyeMlY3yi10hiFhYeKh77HmcvmiDhjeMer7PoVugiDhheLgl
					7gnZukiChgeLhS7knCuliDhjeMez7QoRuhiDhheLgK7dnmukiChfeLhg7lm7uliDhjeMfC7ToKuhiDhieMfv7Zn0ujiChfeLho7lm3uliDhieMfW7WoAuiiD
					hheMfj7Tn4utiKhHeJkJ5+kfxpiTgleMma23hX1ZiVgZeOnS1egA2kiVgZeOnS1egA2kiVgZeOnS1egA2k]],
				Tail1 = [[
					gAgvgAgAgAgA//gAgvgAf5gAgA//gAgvgAfqgAgA//gAgvgAfegAgA//gAgvgAfggAgA//gAg5gEffftgA//gAhKgLfBgzf+/9gAhOgNe5hqf8/7gAhOgNe5
					gef//+gAhOgNe5evgD/8gAhOgNe5efgD/7gAhOgNe5gAgA/+gAhOgNe5hhf9/7gAhOgNe5hRf9/8gAhOgNe5figB/+gAhOgNe5eWgE/7gAhOgNe5fGgC/9gA
					hNgNe6g5f+/9gAhCgIfThDf//9gAg0gCf1gFgA//gAgvgAgAgAgA//gAgvgAgAgAgA//gAgvgAgAgAgA//]],
				Tail2 = [[
					gAgvgmgAgAgA//gAgvgmf5gAgA//gAgwgmfqgAgA//gAgwgmfegAgA//gAgwgmfggAgA//f/g6gqfHfLgB/+gChMgxeDgugA/7gEhQgzdyjIf5/wgBhRgzdx
					hzf6/3f9hQgzdxeXgC/3f8hQgzdyc2gH/wgAhRgzdxfBgE/5gEhQgzdxiWf8/1gDhQgzdyi7f5/xf/hRgzdxgGf9/6f8hQgzdydJgF/yf+hRgzdxdjgH/0gC
					hQgyd0gzgA/6gChEguemh/f9/5gAg0gofqgSgA//gAgvgmgAgAgA//gAgvgmgAgAgA//gAgvgmgAgAgA//]],
				Tail3 = [[
					gAgvhMgIgAgA//gAgvhMgBgAgA//gAgwhMfygAgA//gAgxhMfmgAgA//gAgxhMfogAgA//f9g9hQe3eogC/8gEhRhXdMfygH/3gLhWhXczj3f6/mgFhWhYcz
					jdfy/pf5hWhYcyfAf6/0f1hWhXczbugJ/if+hWhYcydcgN/ugJhWhYcyiKgC/wgKhWhYczkWf0/if/hWhYcyhef0/yf1hWhYczc3gC/rf4hWhYczb8gN/kgE
					hVhYc3fxgJ/1gHhHhTeBicf+/1gBg1hOfmgjgA//gAgvhMgIgAgA//gAgvhMgIgAgA//gAgvhMgIgAgA//]],
				Tail4 = [[
					gAguhyhXgAgA/9gAgvhyhRgAgA/9gAgxhyhCgAgA/+gAgyhyg2gAgA/+gAgyhyg4gAgA/+f6g/h2fveRgH/8gDhYh8ddeZgW/2gUhdh7c7jlf9/pgOhdh8c7
					kzfh/ef3hdh9c7gafq/1frhdh7c7bjgM/hf4hdh9c7b4gh/kgOhdh9c7hDgP/0gUhdh7c7k/fs/cgDhdh9c7jHfg/sfuhdh8c7dmf6/wfuhdh8c7a6gb/bgD
					hch9dBeNgb/zgNhMh5ejiRf8/4gCg2h0gqgxf9/+gAguhyhXgAgA/9gAguhyhXgAgA/9gAguhyhXgAgA/9]],
				Tail5 = [[
					gAgriYgtgAgA//gAgsiYgmgAgA//gAguiYgXgAgA//gAgwiYgLgAgA//gAgwiYgNgAgA//f2hAibesePgD/6f/heihb1dBgg/kgdhkigbLiagZ/igZhkigbK
					lXfr/Kf4hliibLiEfW/jfghkifbLcWfy/afuhkihbLa6ge/NgRhliibLfbgn/ngghkifbLkogC/SgKhkiibLkbfb/TfohlihbLfDff/mfjhkifbLazgJ/Mf/
					hjiibScsgn/dgShPiedMhhgJ/1gEg0iaf0g3f+/+gAgriYgtgAgA//gAgriYgtgAgA//gAgriYgtgAgA//]],
				["FinB1.L"] = [[
					eSgkgalzQigA7ZeSglgaluQigD7aeSglgalhQigK7ceSglgalWQigQ7eeSglgalYQigP7eeSgtgdndP8gs6oeSg6gjqXO8hb49eSg+gkq/Ouhk4heSg+gkq/
					Ouhk4heSg+gkq/Ouhk4heSg+gkq/Ouhk4heSg+gkq/Ouhk4heSg+gkq/Ouhk4heSg+gkq/Ouhk4heSg+gkq/Ouhk4heSg+gkq/Ouhk4heSg+gkq/Ouhk4heS
					g9gjq4Owhj4meSg0ggpGPahF5xeSgogcmoQQgT7DeSgkgalzQigA7ZeSgkgalzQigA7ZeSgkgalzQigA7Z]],
				["FinB2.L"] = [[
					dtgWgvlWSRgA8ZdtgXgvlQSRgD8adtgXgvlDSRgJ8cdtgYgwk4SRgP8edtgYgwk6SRgO8edtgbgvm+Rogy7tdugigsp3Qihr6JdugkgsqeQRh35vdugkgsqe
					QRh35vdugkgsqeQRh35vdugkgsqeQRh35vdugkgsqeQRh35vdugkgsqeQRh35vdugkgsqeQRh35vdugkgsqeQRh35vdugkgsqeQRh35vdugkgsqeQRh35vdu
					gjgsqYQUh150dtgeguomRChR66dtgYgvmKR+gW8FdtgWgvlWSRgA8ZdtgWgvlWSRgA8ZdtgWgvlWSRgA8Z]],
				["FinB1.R"] = [[
					hugkgalzvegA7Zhuglgaluvef97ahuglgalhvef27chuglgalWvefw7ehuglgalYvefx7ehugtgdndwEfU6ohug6gjqXxEel49hug+gkq/xSec4hhug+gkq/
					xSec4hhug+gkq/xSec4hhug+gkq/xSec4hhug+gkq/xSec4hhug+gkq/xSec4hhug+gkq/xSec4hhug+gkq/xSec4hhug+gkq/xSec4hhug+gkq/xSec4hhu
					g9gjq4xQed4mhug0ggpGwme75xhugogcmovwft7DhugkgalzvegA7ZhugkgalzvegA7ZhugkgalzvegA7Z]],
				["FinB2.R"] = [[
					iTgWgvlWtvgA8ZiTgXgvlQtvf98aiTgXgvlDtvf38ciTgYgwk4tvfx8eiTgYgwk6tvfy8eiTgbgvm+uYfO7tiSgigsp3veeV6JiSgkgsqevveJ5viSgkgsqe
					vveJ5viSgkgsqevveJ5viSgkgsqevveJ5viSgkgsqevveJ5viSgkgsqevveJ5viSgkgsqevveJ5viSgkgsqevveJ5viSgkgsqevveJ5viSgkgsqevveJ5viS
					gjgsqYvseL50iTgeguomu+ev66iTgYgvmKuCfq8FiTgWgvlWtvgA8ZiTgWgvlWtvgA8ZiTgWgvlWtvgA8Z]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Spine1 = [[
					gAgtgAAEgAgAh2gAgtgAAEgAgAh2gAgtgAAEgAgAh2gAhFgAAHgAgHiZgAhlgAAZgEj0jIgAh0gACmgEsKjPgAhugAJggP2niXgAhTgAWZg6+fg1gAgtgAmg
					hz/RfogAgtgA0cha4ie1gAg9gA8mgquMeBgAhggA/bgHlKdBgAhzgA/zgAgccigAhxgA/zgAgAcmgAhagA/3gAgAdIgAg1gA/7gAgAd/gAgtgA/8gAgAeKgA
					gtgA/8gAgAeKgAgtgA/8gAgAeKgAgtgA/8gAgAeKgAgtgA/8gAgAeK]],
				Spine2 = [[
					gAgxfdAGgAgAiJgAgxfdAGgAgAiJgAgxfdAGgAgAiJgAhKfdAIgAgHisf4hsfeAbgGj0jbfnh7foCogMsKjhfdhygAJigd2nilfshWgdWZhN+eg7gOgxggmg
					iG/QfkgjgxgG0chp4heogchCfr8kgyuMdwgLhmff/ZgKlKcugBh7fd/xgAgccPgAh4fd/xgAgAcSgAhgfd/1gAgAc0gAg6fd/6gAgAdrgAgxfd/6gAgAd3gA
					gxfd/6gAgAd3gAgxfd/6gAgAd3gAgxfd/6gAgAd3gAgxfd/6gAgAd3]],
				Spine3 = [[
					gAg2e6AigAgAlvgAg2e6AigAgAlvgAg2e6AigAgAlvgAhQe6ApgBgHmSfvh0e9BBgijym+fPiCfPDNhksDm0e6h2gBJ+jA2blHfYhZg6Wkkp+JiAgcg2hAma
					lo+0e1hFg2gN0Jka4LcVg4hHfW8IiZuAaigWhue++1gvlHZMgCiDe7/IgEgbYqgAiAe7/JgAgAYugAhne7/RgAgAZPgAg/e6/cgAgAaFgAg2e6/egAgAaRgA
					g2e6/egAgAaRgAg2e6/egAgAaRgAg2e6/egAgAaRgAg2e6/egAgAaR]],
				Spine4 = [[
					gAhDeZAigAgAlvgAhDeZAigAgAlvgAhDeZAigAgAlvf/heeaApgBgHmSfoiDeeBBgijym+e3iRe5DNhksDm0eZiDgCJ+jA2blHfFhkhVWkkp+JiAgphDhfma
					lo+0e1hlhDgT0Jka4LcVhShUfC8IiZuAaighh8eg+1gvlHZMgDiTec/IgEgbYqgAiQeb/JgAgAYugAh2ea/RgAgAZPgAhMeZ/cgAgAaFgAhDeZ/egAgAaRgA
					hDeZ/egAgAaRgAhDeZ/egAgAaRgAhDeZ/egAgAaRgAhDeZ/egAgAaR]],
				Head = [[
					gAhPd4ANgAgAjhgAhPd4AhecgFlbgAhPd4AwdWgEmQf/hrd5AxfKgHm1fgiSd/BLiOjznTegigejDXkVsEmOd4iPgDKAkj2XkUeyhvhxWpk5+Di/g2hPh9mb
					mr+mhViGhPgZ0EmQ4Aduhshheu8Ciot9aDgriLeC+nemlDYUgEiid8+5dagWYIgAigd8/AfJf/YMgAiEd6/GhpgBYtgAhZd4/Niyf9ZkgAhPd4/Vhpf+ZvgA
					hPd4/WfJgBZugAhPd4/Zd2gFaQgAhPd4/sfXgDbsgAhPd4/zgAgAcf]],
				Jaw = [[
					gAhUdK//gAgAgff/hadL/thhgYj8f/hcdM/aigg6lef/h6dO/mg1gNk8fWiidV/YfTbqkWeCiweF89gUTMkjdMicgE2Ej2Jhj7eZh6iWpzmTCOgnhJhcilaf
					k2BFcdixhcggMei2HXa4iPhveUDtimSCbbg6ibdZAsjJbzcHgGi0dSAXijgncMgAixdRARgzgVcFf/iUdPAYeffZbkf/hmdMAldZfCauf/hcdMAiedfcaigA
					hcdMAgg0gTahgBhbdMAaiEgnbegAhXdLAFgpgEeGgAhUdKABgAgAfh]],
				["Cheek.L"] = [[
					ewhuc7gAJZgA2nelhuc+ieJZfv2feghrc/j1JZf62TehiTdEi+JieP2gd9jIdlheMncA5Fc/jYfAgCUNbw9bdDi7hgf4gSdO/3ffiPjWgRusdj8UimhriLfI
					6bcRxnjPhtfEdc/pdhjFhgiOdFdP+LhQV2fqjIc5eX5jkZNVewjhdMeu2Xk/JuemjVdLdi2UjsJhehiqdFcJ2khjJuefh0c/b82ngIJwehhxdAc42ng0Jmem
					h/dCep2eilJberiEdCf72ajHJZeuh1c9f52mhBJZewhuc7gA2ngAJZ]],
				["Cheek.R"] = [[
					hQhuc7gA2ngA2nhVh/dAgR2fie2nhWiJdEgG2Tj12nhZiddFhx2gi+2egvi5c1kA5FhezZe9jGc6kQ9bgCrzdAi6eoiy/3f4fudJifhsid8UgRRUf9iJjPjv
					xnfIFliqiHh3ifjFdcAXjQiLfYewV2dPB1iYirdtbnNVeXGdhmjDdJbBJueuJphejLdJcUJhdiJshYi8dJedJucJJchViUdFf4Jwb8JZhYiDdDfMJmc4JZhe
					h1dBdbJbepJihehsc+c5JZf7JmhVhuc8e/JZf5JahQhuc7gAJZgAJZ]],
				["FinF1.L"] = [[
					eSgmesp7FTgAujeSgmesi6CeeFrzeSgmesfgB5dpqheRhAesf5BwdrqHeBhifIdBC+dJsyd2hrgRYOH1e9zbeshchtdSQuge7+gqhEiEfdgDfr//iHgmghdz
					wcg/7Vhngmejeh7Xh6wZgAg5d1gM/jjAkXeyhheNfp/miWbreUh0eojh+bjlXeeShxernZ9fkmXKeShYeria+TjJWjeSgvesgY+LiWVqeSgmesgg+HiXVfeS
					gmesgg+HiXVfeSgmeseb90iIUteSgmesY18Gg8SjeSgmesWF6tgARd]],
				["FinF2.L"] = [[
					drgXeOnSKigA2kdvgoeHhaHab0z+dygteFecGnaVyjdzhHeEe2GWadyPddhuemb/IZZV0HdJh8gDWOOxaX4deBhiiIZyZYeb+ogqhGi2b4pKgI+Xizgtg5ax
					3Vis1FiTgteLcq+gk2npgOhCdFfZ+6mobLelhodcgE8mltS1d8iCd+j36DnwPmd7iFeDnS45ptP/d2hjeDjC5wm/Oodzg2eEhb5gloNmdygteFhk5ZlrNddy
					gteFhk5ZlrNddwgqeGfv49kzMldsgfeLa+29h3KYdrgXeOYu1egAJc]],
				["FinF1.R"] = [[
					hugmesp76tgAujhugmesi69ih7rzhugmesfg+HiXqhhuhAerf6+ViVp6hXhmeUdO/KjvlhgTh7d2Zc+Nnnc1eshweReG7llWQ1d1hLgFgpyZhFF3e8gmh5ib
					kLgBAYg/gmh8iJU0e4CJiGg1gkh7JbeQJgiDhbfTfqDbdxR0hxh0eujhB0cjWphuhxernZChbaXKhuhYeriaBtc3WjhugvesgYB1dqVqhugmesggB5dpVfhu
					gmesggB5dpVfhugmesebCMd4UthugmesY1D6fESjhugmesWFFTgARd]],
				["FinF2.R"] = [[
					iVgXeOnS1egA2kiRgoeHha4mkMz+iOgteFec5ZlryjiLhHeCe45ylkyEhnhzdldN7nn1t2gFiQdLbu8pspk7eBh8d4g896pFZRdGhPgWjm4zjcMbevgtiql4
					s/gZDXhggtihlXd/dlAoi4g9gkkVRIbmEXishhe1hNJFa8KUiLiBeGkAGZYaO4iFiFeDnSHHWTP/iKhjeDjCGQZBOoiNg2eEhbGgaYNmiOgteFhkGnaVNdiO
					gteFhkGnaVNdiQgqeGfvHDbNMliUgfeLa+JDeJKYiVgXeOYuKigAJc]],
				Tail1 = [[
					gAgtgAe5gAgA/+gAgtgAe5iggG/4gAgtgAe5kPgJ/sgAhFgAethfgH/7gAhlgAedhMgK/7gAh0gAeYn1hP+9gAhugAex0ei/4XgAhTgAfo+vjFoUgAgtgAgY
					+KhDVagAgtgAg02GgxI6gAg9gAhHuLg4DXgAhggAhdoohDBQgAhzgAhpknguAagAhxgAhphXgNAGgAhagAhddZftAKgAg1gAhLbjfyAWgAgtgAhHdYf6AJgA
					gtgAhHhYgDAEgAgtgAhHjcgIAOgAgtgAhHhBgCADgAgtgAhHgAgAAC]],
				Tail2 = [[
					gAgwgmdxgAgA/6gGgwgldyjzgL/sgKgwgld0ohgT+wgDhIgmc4kugQ/fgDhpgmbngngP/rgSh5ghbQj0h1/Wglh0gHcjw2ky6igThbfgfE+NlSpFfogwfigv
					89iGSmfagwgChmyqhiGHfihBgXiisKhkCkfshkggkDqUh2CDf1h3gkk4oyhZBrf9h1gmk1klggAugGhdglj9c4ffAbgKg4gkigXvflBNgGgwgliNZZf0Ayf9
					gwgmiPgjgGAGf4gwgliOl5gPApf+gwgmiPiRgFALgAgwgmiPgAgAAG]],
				Tail3 = [[
					gAg1hLcygAgA/1gPg1hKczjmgT/ogdg1hFc4rxgb9lgOhPhJbOo6gU+WgEhzhKY6iPgN/HgaiEhEYRhPiU+7hFiBgXalsdmb8PgnhnfCev82nUrqfMg1fKhH
					8ZjARoe3g1gOiQvFiMD+fIhIgxjxohiQBffWhug9mcp4irCZfiiDhDn3r2iDDbfyiAhInxougsCPgNhnhJmRejfLAsgdg+hFjsVefXCCgVg1hIjJVIfzCGf7
					g1hLjNdsgOARfqg1hIjMmxgZA6f4g1hLjNjcgGAXgAg1hLjOgAgAAL]],
				Tail4 = [[
					gAg9hxc6gAgA/1gXg9huc8h+ge/yg3g8hgc+tRgM88gihahoaqs7f48xgJiEhsXZllft+TgciWhmWSg0ic+XhciTgvZpoonk9Lg/h4eqfO61oVvReug9e0hL
					85i2SneYg8gih7sjiWCve1hRhRjxkKi2ApfCh+hZnlnfjgCDfKiVhapvtLieEpfgiShkpispgZEOgQh1hsnYh+ekA+g0hHhhj0VOfWCJgug8hkjDRrgQDkgB
					g9hwjBZngsA0fbg9hqjDl5gdAufwg9hvjGkPf/AdgAg9hxjGgAgAAL]],
				Tail5 = [[
					gAhEiWbJgAgA/ngchEiTbPfQg6/nhThDh4bXsvhA89g+hmh/YdvvgV6zgWiXiKURpsfP8IgcisiFSdiViB80hrilhMWwlro48whdiJebe83lqyyteRhEeciQ
					91kSVgd9hDg8jfrojICleshbh1llf+joAueziRh2qMjWlGCTexishstAsRkPF0fGimh3sxvThDHAgLiGiOqImWd1CahMhQh+lpXEeZB3hMhDh6koP0ftEzgQ
					hDiSkpVWg4COfNhEiMkujahGAkfmhEiTk2kdgNAtgAhEiWk3gAgAAZ]],
				["FinB1.L"] = [[
					eSgjgalzQigA7ZeSgjgakfQGds7SeSgjgaj4P8cq7LeSg6gakcPgc263ebhXgyixRsaI73fEhghedbY6Xm97gahZhtfHlxbI/EhphHgqfe0bb74Rhbgje8b8
					94c5qNf6gjePa9/LfKa8epg1e4bB6wiPPWePhWf1as1RiZI1eRhmgWc1yNmYGreShkgZfTxvpoHMeShOgZcjxSlTF1eSgrgab8wQjRE9eSgjgacIwEjWE1eS
					gjgacIwEjWE1eSgjgabwv+iuEweSgjgaavvrg9EoeSgjgaaNvegAEn]],
				["FinB2.L"] = [[
					dtgVgvlWSRgA8ZdrgcgvkLR3dn8SdqgfgvjoRucj8Ldqg0gukNRRcw75d3hXhNiqTjZ+8uezhsiGdba6XP+PgqhZiXe1nwbG+oiVhBgyfO19cM28h3gfeZb4
					+gdJoQftgfdkbB+yfbY8eAgzekbH5nidNpdjhQf3a6zvihHednhpglc2wemkFkdqhxgqfGv/p9GKdohOgrcqvhldEydqgmgucLuejYD8dqgfgvcYuSjdD1dq
					gfgvcYuSjdD1dqgdgvcDuNi0DwdsgYgvbIt6g/DodtgVgvaqtvgADn]],
				["FinB1.R"] = [[
					hugjgalzvegA7Zhugjgakfv6iU7Shugjgaj4wEjW7Lhug6gZkdwsjI6vhxhbf+jz0ilm3lhhhwfEjh5yp+vtgahueRla+2j0lSe1hOerjc+odwXweQgjgUif
					3WbiKvfTgjhogFqma5CQgugxhneRdJbAAmhghRg7bOTVcmDPhuhmgcc9OgZoGMhuhkgZfTORWYHMhuhOgZcjOuatF1hugrgab8PwcvE9hugjgacIP8cqE1hu
					gjgacIP8cqE1hugjgabwQCdSEwhugjgaavQVfDEohugjgaaNQigAEn]],
				["FinB2.R"] = [[
					iTgVgvlWtvgA8ZiVgcgvkLuJiZ8SiWgfgvjouSjd8LiXg0gskOu7jO7yiehdgFjxy7lz42iHiCe2j74kqPxTgqh2dolo+YkDnQeehKeEji/HeEZudkgfgRip
					4rbvMSe3gfiLgVsgbAC/g3gtiTehfLa+AdiChJhYbgVNclCbiXhpgtc/QQZbFIiWhxgqfGQBWDGKiYhOgrcqQfajEyiWgmgucLRicoD8iWgfgvcYRucjD1iW
					gfgvcYRucjD1iWgdgvcDRzdMDwiUgYgvbISGfBDoiTgVgvaqSRgADn]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAgvgAAEgAgAh2gAgvgMALgAgAjMgAgvgTARgAgAkDgAgvgRAQgAgFj1gAgvgNANgAfljYgAgvgJANf9d/i4gAgvgGAKf8eTikgAhQgGANdjfxiggAi7gEB9
					VQgsiDgAkPgBIPKrhKhcgAjqgASgDEhqgygAiDgAb5AVh1gPgAhOgAf+AEh2gAgAhNgAgAAEh2gAgAhNgAgAAEh2gAgAhNgAgAAEh2gAgAhNgAgAAEh2gAgA
					hNgAgAAEh2gAgAhNgAgAAEh2gAgAhNgAgAAEh2gAgAhNgAgAAEh2gAgAhNgAgAAEh2gAgAhNgAgAAEh2gA]],
				Spine2 = [[
					gAgzfdAGgAgAiJgAg2fpANgAgAjfgAg4fxAUgAgAkXgAg3fvASgAgFkIgBg2frAPf/fljrgEg1fnAPf8d/jMgEg0fkAMf7eTi3gAhWfjAPdjfzizf9i/fhB+
					VQgziVf8kQfeIQKshXhrf9jnfdSgDFh8g6f/h/fdb5AXiIgSgAhKfdf+AGiJgAgAhJfdgAAGiJgAgAhJfdgAAGiJgAgAhJfdgAAGiJgAgAhJfdgAAGiJgAgA
					hJfdgAAGiJgAgAhJfdgAAGiJgAgAhJfdgAAGiJgAgAhJfdgAAGiJgAgAhJfdgAAGiJgAgAhJfdgAAGiJgA]],
				Spine3 = [[
					gAg3e6AigAgAlvgAg9fHA0gAgAnEgAhBfPBBgAgAn6gAhAfNA9gBgFnsgCg+fJA2f8flnQgJg8fEAzfteAmxgHg7fBAufveUmcgAhcfAAwdjgEmYf6jDe+Ca
					Vah9llf3kRe7IeK3jDjif5jke6SkDMjLhff+h7e6b5Abi9gZgAhFe6f+AKi+gAgAhFe6gAAKi+gAgAhFe6gAAKi+gAgAhFe6gAAKi+gAgAhFe6gAAKi+gAgA
					hFe6gAAKi+gAgAhFe6gAAKi+gAgAhFe6gAAKi+gAgAhFe6gAAKi+gAgAhFe6gAAKi+gAgAhFe6gAAKi+gA]],
				Spine4 = [[
					gAhEeZAigAgAlvgAhNenA0gAgAnEgAhSewBBgAgAn6f/hReuA9gBgFnsgDhOepA2f8flnQgNhLekAzfteAmxgLhJehAufveUmcf/hqefAwdjgEmYfyjNedCY
					VZh5laftkSeZIVKwiLikfzjfeXSfDCgtgVf8h1eXb4ASfpf9gAg/eXf+ABfogAgAg+eXgAABfogAgAg+eXgAABfogAgAg+eXgAABfogAgAg+eXgAABfogAgA
					g+eXgAABfogAgAg+eXgAABfogAgAg+eXgAABfogAgAg+eXgAABfogAgAg+eXgAABfogAgAg+eXgAABfogA]],
				Head = [[
					gAhQd4ANgAgAjhgAhceHA6gAgAnhgAhjeRBogAgAqCf/hheOBbgAgLpYgEhdeJBEf9fDoEgRhZeFBCfsbfmmgOhXeBAwfscNlqf+h3d/AmdhfmlffqjXd8CE
					VVhljRfmkTd2IJLId9cTfyjed0SYF8VgZEf8h1d0alEzQob7gAg/d0eGEUQOd7gAg/d0eIEUQOd8gAg/d0eIEUQOd8gAg/d0eIEUQOd8gAg/d0eIEUQOd8gA
					g/d0eIEUQOd8gAg/d0eIEUQOd8gAg/d0eIEUQOd8gAg/d0eIEUQOd8gAg/d0eIEUQOd8gAg/d0eIEUQOd8]],
				Jaw = [[
					gAhWdK//gAgAgfgAhsdc/9gAgAhggAh6dq/6gAgAiKf/h3dm/7gEf1h/gGhvdf/7fxg7hpgehndb/pfMkdhPgZhidW/vfhjyhBf+iCdS/4iWg5g6fljadO+B
					qxgbiVf2kOdM2Zz4mupBgSjwdYq31nx9qxgOibdhjs0P31ltgIhodhhF0i4XingIhodhhD0i4XilgIhodhhD0i4XilgIhodhhD0i4XilgIhodhhD0i4XilgI
					hodhhD0i4XilgIhodhhD0i4XilgIhodhhD0i4XilgIhodhhD0i4XilgIhodhhD0i4XilgIhodhhD0i4Xil]],
				["Cheek.L"] = [[
					ewhwc7gAJZgA2newiJdUi3JkdJ2cewiYdmksJ4bU2IeuiUdikOJ6b02We3iOdTjOI9ct1sfViHc7iGGhdpzFfOh/c3heG6eZzteriSdCjHJBgU2CeWi7dBnl
					K/nq1kfbjAc3qDMdy/tbg+irdArkNk3cfohaiBdIupPl1OWlhVhidIwnRlz1T8hVhidIwoRmz1T7hVhidIwoRmz1T7hVhidIwoRmz1T7hVhidIwoRmz1T7hV
					hidIwoRmz1T7hVhidIwoRmz1T7hVhidIwoRmz1T7hVhidIwoRmz1T7hVhidIwoRmz1T7hVhidIwoRmz1T7]],
				["Cheek.R"] = [[
					hQhwc7gA2ngA2nhQiJdUi32ci32chQiYdmks2Iks2IhPiVdgkM2WkO2GhXiMdcjT1sjO3DhviAdoiXzFiG5fhrh8ddhnzthe5GhKiqdKfs2CjH2/gTkhc9YW
					1knl1BfxlfcuNBtbqDzjfnkyc0IkforkycfMjBdAKyWlupwbfAh8dAMLT8wnubfAh7dAMLT7wouafAh7dAMLT7wouafAh7dAMLT7wouafAh7dAMLT7wouafA
					h7dAMLT7wouafAh7dAMLT7wouafAh7dAMLT7wouafAh7dAMLT7wouafAh7dAMLT7wouafAh7dAMLT7woua]],
				["FinF1.L"] = [[
					eSgnesp7FTgAujeSgue3npEfdTuKeSgze/mJEPbjt8eRgxe9miEUcAuEeUgve2nVEOdAtvedgtenoKDweXsfebgrenotEEe/s3eWg7euq6Fbf6uDevhwevxw
					JqkLt1f8ihes5ISgplq2hNiaes8ZdutMmJhthves7LojuigvhuhVes42t7uYdwhuhVes40t+uYduhuhVes3zvpuMcvhuhVes52r+uhe3huhVes4ZutuTdThu
					hVes4ZutuTdThuhVes52r+uhe3huhVes3bwNuHcahuhVes5OtQuceJhuhVes40t+uYduhuhVes40t+uYdu]],
				["FinF2.L"] = [[
					drgZeOnSKigA2kdpgreZl7KAcs2Odpg2ehlAJ7aj18dogzeglPJ/bH2EdsgueXlvJrcR13d5goeEmSIsdu03d3gjeEmmJBeh1MdxgtePoUKggM2LeYhPeRtu
					N3ms1egFh6eOztUru5w4hwiGeO2idi0dpiiUh5eO2DlO2eiIiPhveO07ov2hediOhveO06ox2hebiLhzeO0QqL2Wc4iShpeO1inF2kgNiNhweO0ppY2ddxiN
					hweO0ppY2ddxiShpeO1inF2kgNiJh0eO0Bqp2RcXiQhteO1KoK2jfFiOhveO06ox2hebiOhveO06ox2heb]],
				["FinF1.R"] = [[
					hugnesp76tgAujhugue3np7hituKhugze/mJ7xkdt8hugye8mj7wj/t7hxgve8nU7YjKufh4gsfDoI6Zijv9h3gqe+os6Yh4vxhwhde0mx7jigukhZj8evfk
					8glmtZgUl9etVW6Yp6qye/lDesMB0TtMmLeXinesH7vNuPjAeShWesHMt/uYiSeShVesHMt+uYiSeShVesINvpuMjReShVesGKr+uhhJeShVesHnutuTiteS
					hVesHnutuTiteShVesGKr+uhhJeShVesIlwNuHjmeShVesGytQuch3eShVesHMt+uYiSeShVesHMt+uYiS]],
				["FinF2.R"] = [[
					iVgZeOnS1egA2kiXgreZl72AjU2OiXg2ehlA2Fld18iXgzeelQ2Ik419iagteflt1uj12dikgleqmJ0ci43pihgiekmg0liF3hiZhaeXk+17jY2gh/kNeSfH
					2rof04glmieQW80tvTwsexlqeOPpvr0dpjd6jEeOMBqs2RjsdyhveOLHoy2hhmdyhveOLGox2hhld1hzeOLwqL2WjIduhpeOKenF2kfzdzhweOLXpY2diPdz
					hweOLXpY2diPduhpeOKenF2kfzd3h0eOL/qp2RjpdwhteOK2oK2jg7dyhveOLGox2hhldyhveOLGox2hhl]],
				Tail1 = [[
					gAgvgAe5gAgA/+gAgvgMgPgAgA//gAgvgThHgAgA/+gAgvgRg4gIgB/+gAgvgNgbfUf8/+gAgvgJf8cufy/0gAgvgGfndPf2/3gAhQgGflfWia/5gAi7gEfO
					f1qy+HgAkPgBfPfN1W3zgAjqgAfie/8+thgAiDgAf3e5/tkIgAhOgAgAe5/+gCgAhNgAgAe5/+gAgAhNgAgAe5/+gAgAhNgAgAe5/+gAgAhNgAgAe5/+gAgA
					hNgAgAe5/+gAgAhNgAgAe5/+gAgAhNgAgAe5/+gAgAhNgAgAe5/+gAgAhNgAgAe5/+gAgAhNgAgAe5/+gA]],
				Tail2 = [[
					gAgxgmdxgAgA/6gAgugyfIgAgA/+gAgsg5f/gAgA//gAgtg3fxgLgB//f+gugzfUfDf6/+f4gvgue1bffo/pf5gwgsegcMfu/uf+hRgseefEiY/2f/i8gpeI
					flqx+Ef9kPgneaed1U3wf+jogmfEd/86tgf/iBgmfudy/pkHgAhLgmgAdx/6gCgAhLgmgAdx/6gAgAhLgmgAdx/6gAgAhLgmgAdx/6gAgAhLgmgAdx/6gAgA
					hLgmgAdx/6gAgAhLgmgAdx/6gAgAhLgmgAdx/6gAgAhLgmgAdx/6gAgAhLgmgAdx/6gAgAhLgmgAdx/6gA]],
				Tail3 = [[
					gAg3hLcygAgA/1gAgwhYeIgAgA/8gAgshffAgAgA/+gBgthdexgOgC/9f8gvhZeUeyf4/7fugyhTd2aQff/ZfxgzhQdhbJfo/hf8hUhRdgeyiW/yf9jAhPdJ
					fYqv9/f4kQhMdqd01Q3sf6jlhLepdF82tdf+h8hLflc0/kkGgAhGhLgAcy/1gCgAhFhLgAcy/1gAgAhFhLgAcy/1gAgAhFhLgAcy/1gAgAhFhLgAcy/1gAgA
					hFhLgAcy/1gAgAhFhLgAcy/1gAgAhFhLgAcy/1gAgAhFhLgAcy/1gAgAhFhLgAcy/1gAgAhFhLgAcy/1gA]],
				Tail4 = [[
					gAg+hxc6gAgA/1gAg1h9eQgAgA/8gAguiFfIgAgA/+gBgwiDe5gRgB/+f5gzh/ecehf5/6fgg3h2d8ZAfn/Jflg5h0doaHfv/Wf5hah3dpemiY/yf5jGh0dO
					fjqv+AfxkQhydwd61Q3tf0jghxesdN82tef8h0hxfmc8/kkHgAg+hxgAc6/1gCgAg+hxgAc6/1gAgAg+hxgAc6/1gAgAg+hxgAc6/1gAgAg+hxgAc6/1gAgA
					g+hxgAc6/1gAgAg+hxgAc6/1gAgAg+hxgAc6/1gAgAg+hxgAc6/1gAgAg+hxgAc6/1gAgAg+hxgAc6/1gA]],
				Tail5 = [[
					gAhGiWbJgAgA/ngAg5ijcegAgA/zgAgxirdWgAgA/4gCgzipdHgUgC/3f2g3ikcqeQf1/xfQg8iYcMX0fW+rfYg/iXb3ZGfh+9f1hficb5eRiU/mf2jMiabg
					fFqr9zfpkRiXcbcu1H3ifvjbiWd8bm8ptYf6htiWfYbL/WkFgAg3iWgAbJ/ngCgAg3iWgAbJ/ngAgAg3iWgAbJ/ngAgAg3iWgAbJ/ngAgAg3iWgAbJ/ngAgA
					g3iWgAbJ/ngAgAg3iWgAbJ/ngAgAg3iWgAbJ/ngAgAg3iWgAbJ/ngAgAg3iWgAbJ/ngAgAg3iWgAbJ/ngA]],
				["FinB1.L"] = [[
					eSgkgalzQigA7ZeSgigllSQJcc7CeSghgsk6QIaJ6seSghgqlAQLaw61eRgigjlPPwb+6wePgkgUlgOfdd6EeQgkgUlmO1eU6WeUg0gcmyQZgb7Feyhsgdqi
					THoO6Df+iggauqYLyF0ghPicgawfev41rkhthxgavwlB7WhZhuhYgauZoI7DbxhuhYgauYoK7DbuhuhYgatypI6sZ4huhYgau+m/7Td4huhYgauIol66a7hu
					hYgauIol66a7huhYgau+m/7Td4huhYgatkpc6iZPhuhYgaunnv7KcghuhYgauYoK7DbuhuhYgauYoK7Dbu]],
				["FinB2.L"] = [[
					dtgWgvlWSRgA8Zdqgbg5lER7ca8CdqgdhAk1R7aG7sdqgdg/k4R+at71dpgcg3lDRib87ydmgbgklPQMda7MdngZgklRQieS7cdvgjgwmTSHgf8HechLgypl
					Uooj7AgIh6gvtKZLyw1QhxiJgvutfD5vsAiUh7gvuLkC8RiriNhxgvtWmR8UeEiNhxgvtVmT8UeBiKh1gvs3nM8HcFiRhrgvtylO8ZgRiMhygvtJms8QdMiM
					hygvtJms8QdMiRhrgvtylO8ZgRiIh2gvssng8BbbiPhvgvtgl68Xe2iNhxgvtVmT8UeBiNhxgvtVmT8UeB]],
				["FinB1.R"] = [[
					hugkgalzvegA7ZhugigllSv3jk7Chughgsk6v4l36shughgplBv9lQ6whugigplLvhkG7MhqgigwlSuDjA8FhrgjgrleuRiJ8BhuhVgikXvvj27Phcj4gef/
					wlqM5ZgWl8gcZ6vSyh0PfBlFgaUcr040rmeYiqgaSEo46zlpeShYgaRooK7DkTeShYgaRooK7DkSeShYgaSOpI6smIeShYgaRCm/7TiIeShYgaR4ol66lFeS
					hYgaR4ol66lFeShYgaRCm/7TiIeShYgaScpc6imxeShYgaRZnv7KjgeShYgaRooK7DkSeShYgaRooK7DkS]],
				["FinB2.R"] = [[
					iTgWgvlWtvgA8ZiWgbg5lEuFjm8CiWgdhAk1uFl67siWgdg+k6uLlT7wiUgbg/k+tukI8KiOgYhJlAsOjA8/iPgYhElIsciJ88iVhQg4kJt8j78OiBkHgygO
					uzqj6VgnmfgxawtszM0+e0lrgvV0qq5usBd8jFgvTVnh8AkpdzhxgvSrmT8UiAdzhxgvSrmT8Uh/d2h1gvTJnM8Hj7dvhrgvSOlO8Zfvd0hygvS3ms8Qi0d0
					hygvS3ms8Qi0dvhrgvSOlO8Zfvd4h2gvTUng8BkldxhvgvSgl68XhKdzhxgvSrmT8Uh/dzhxgvSrmT8Uh/]],
			},
		},
	},
}
