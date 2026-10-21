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
					gAi1gx/7gAgAiCgAi1gx/7gAgAiCgAi2gx/7gAgAiCgAi2gx/7gAgAiCgAi3gx/7gAgAiCgAi3gx/7gAgAiCgAi3gx/7gAgAiCgAi2gx/6gAgAiKgAi0gx/5
					gAgAihgAizgx/2gAgAjAgAixgx/zgAgAjggAiwgx/wgAgAj2gAiwgx/vgAgAj/gAiwgx/vgAgAj/gAiwgx/vgAgAj/gAiwgx/vgAgAj/gAiwgx/vgAgAj/gA
					iwgx/vgAgAj/gAiwgx/vgAgAj/gAiwgx/vgAgAj/gAiwgx/vgAgAj/gAiwgx/xgAgAjygAiygx/0gAgAjRgAi0gx/4gAgAipgAi2gx/6gAgAiKgAi3gx/7gA
					gAiCgAi3gx/7gAgAiCgAi2gx/7gAgAiCgAi2gx/7gAgAiCgAi1gx/7gAgAiCgAi1gx/7gAgAiCgAi0gx/7gAgAiCgAi0gx/7gAgAiCgAizgx/7gAgAiCgAiz
					gx/7gAgAiCgAizgx/7gAgAiCgAizgx/7gAgAiCgAizgx/7gAgAiCgAi0gx/7gAgAiCgAi0gx/7gAgAiC]],
				Spine1 = [[
					gAiygY/7gAgAiCgAiygY/7gAgAh+gAizgY/7gAgAh6gAizgY/8gAgAh3gAizgY/8gAgAh1gAi0gY/8gAgAh0gAizgY/8gAgAh1gAizgY/7gAgAiDgAiwgY/4
					gAgAiogAiugY/zgAgAjZgAirgY/ugAgAkHgAiqgY/pgAgAkogAipgY/ogAgAk0gAipgY/ogAgAk0gAipgY/ogAgAk0gAipgY/ogAgAk0gAipgY/ogAgAk0gA
					ipgY/ogAgAk0gAipgY/ogAgAk0gAipgY/ogAgAk0gAipgY/ogAgAk0gAiqgY/rgAgAkhgAitgY/xgAgAjvgAiwgY/3gAgAixgAizgY/7gAgAiBgAi0gY/8gA
					gAh0gAizgY/8gAgAh1gAizgY/8gAgAh3gAizgY/7gAgAh6gAiygY/7gAgAh+gAiygY/7gAgAiCgAixgY/7gAgAiHgAiwgY/6gAgAiLgAiwgY/6gAgAiOgAiw
					gY/6gAgAiQgAiwgY/6gAgAiQgAiwgY/6gAgAiQgAiwgY/6gAgAiOgAiwgY/6gAgAiLgAixgY/7gAgAiH]],
				Spine2 = [[
					gAiuf+/agAgAmFgAivf+/bgAgAl9gAiwf+/dgAgAl1gAiwf+/egAgAlvgAixf+/fgAgAlrgAixf+/fgAgAlpgAixf+/fgAgAlrgAivf+/bgAgAl/gAisf//R
					gAgAmygAiof//BgAgAnygAilf/+xgAgAovgAijgA+lgAgApYgAiigA+hgAgApmgAiigA+hgAgApmgAiigA+hgAgApmgAiigA+hgAgApmgAiigA+hgAgApmgA
					iigA+hgAgApmgAiigA+hgAgApmgAiigA+hgAgApmgAiigA+hgAgApmgAijgA+ogAgApOgAinf/+6gAgAoOgAisf//OgAgAm8gAiwf+/bgAgAl8gAixf+/fgA
					gAlpgAixf+/fgAgAlrgAiwf+/egAgAlvgAiwf+/dgAgAl1gAivf+/bgAgAl9gAiuf+/agAgAmFgAiuf+/YgAgAmOgAitf+/WgAgAmWgAitf+/VgAgAmcgAis
					f+/UgAgAmggAisf+/UgAgAmhgAisf+/UgAgAmggAitf+/VgAgAmcgAitf+/WgAgAmWgAiuf+/YgAgAmO]],
				Spine3 = [[
					gAimfo/agAgAmFgAimfo/cgAgAl4gAinfo/egAgAlsgAiofo/ggAgAljgAiofo/hgAgAldgAiofo/hgAgAlbgAiofo/hgAgAldgAinfo/cgAgAl4gAiifp/P
					gAgAm5gAidfq+7gAgAoKgAiZfr+mgAgApVgAiVfs+WgAgAqIgAiUft+QgAgAqZgAiUft+QgAgAqZgAiUft+QgAgAqZgAiUft+QgAgAqZgAiUft+QgAgAqZgA
					iUft+QgAgAqZgAiUft+QgAgAqZgAiUft+QgAgAqZgAiUft+QgAgAqZgAiWfs+agAgAp8gAibfr+ygAgAorgAiifp/MgAgAnEgAinfo/dgAgAlzgAiofo/hgA
					gAlbgAiofo/hgAgAldgAiofo/ggAgAljgAinfo/egAgAlsgAimfo/cgAgAl4gAimfo/agAgAmFgAilfp/XgAgAmSgAikfp/VgAgAmegAijfp/TgAgAmngAij
					fp/RgAgAmtgAijfp/RgAgAmvgAijfp/RgAgAmtgAijfp/TgAgAmngAikfp/VgAgAmegAilfp/XgAgAmS]],
				Neck1 = [[
					gAidfTAHgAgAiagAiefSAHgAgAiggAiffSAIgAgAimgAigfSAIgAgAirgAigfSAIgAgAiugAihfSAJgAgAivgAigfSAIgAgAiugAiefSAHgAgAiigAiZfUAF
					gAgAiEgAiSfWADgAgAhfgAiLfYACgAgAg8gAiHfZABgAgAglgAiGfaABgAgAgdgAiGfaABgAgAgdgAiGfaABgAgAgdgAiGfaABgAgAgdgAiGfaABgAgAgdgA
					iGfaABgAgAgdgAiGfaABgAgAgdgAiGfaABgAgAgdgAiGfaABgAgAgdgAiIfZABgAgAgqgAiPfXADgAgAhQgAiYfUAFgAgAh/gAiffSAIgAgAikgAihfSAJgA
					gAivgAigfSAIgAgAiugAigfSAJgAgAi4gAiffSAOgAgAjpgAiefSAQgAgAj5gAidfTAPgAgAjzgAicfTAPgAgAjsgAibfTAOgAgAjmgAiafTANgAgAjhgAiZ
					fTANgAgAjegAiZfTAMgAgAjQgAiZfTAHgAgAicgAiafTAGgAgAiIgAibfTAGgAgAiNgAicfTAGgAgAiT]],
				Neck2 = [[
					gAijepBggAgApogAileoBggAgApogAimeoBggAgApogAineoBggAgApogAioeoBggAgApogAioeoBggAgApogAioeoBggAgApogAileoBggAgApqgAieeqBi
					gAgApwgAiWerBlgAgAp5gAiOetBogAgAqBgAiJevBqgAgAqHgAiHevBrgAgAqKgAiHevBrgAgAqKgAiHevBrgAgAqKgAiHevBrgAgAqKgAiHevBrgAgAqKgA
					iHevBrgAgAqKgAiHevBrgAgAqKgAiHevBrgAgAqKgAiHevBrgAgAqKgAiKeuBqgAgAqGgAiSesBngAgAp9gAideqBjgAgApygAileoBggAgApqgAioeoBggA
					gApogAioeoBggAgApogAineoBogAgAqBgAipepCMgAgArmgAioepCdgAgAsPgAinepCdgAgAsPgAilepCdgAgAsPgAikeqCdgAgAsPgAijeqCdgAgAsPgAii
					eqCdgAgAsPgAiieqCTgAgAr3gAigepBugAgAqSgAifepBggAgApogAigepBggAgApogAiiepBggAgApo]],
				Neck3 = [[
					gAi4eLCYgAgAsEgAi5eLCWgAgAr9gAi7eLCTgAgAr4gAi8eLCSgAgAr0gAi8eLCQgAgArxgAi9eLCQgAgArwgAi8eLCQgAgArxgAi5eLCXgAgAsBgAizeMCn
					gAgAsogAireOC+gAgAtbgAijeQDUgAgAuKgAieeSDlgAgAurgAideTDrgAgAu2gAideTDrgAgAu2gAideTDrgAgAu2gAideTDrgAgAu2gAideTDrgAgAu2gA
					ideTDrgAgAu2gAideTDrgAgAu2gAideTDrgAgAu2gAideTDrgAgAu2gAigeSDhgAgAujgAioePDIgAgAtwgAiyeNCrgAgAswgAi6eLCWgAgAr+gAi9eLCQgA
					gArwgAi8eLCQgAgArxgAi9eLCggAgAsYgAjBeODngAgAuvgAjCeQEKgAgAvvgAjAeQENgAgAv0gAi/eQEQgAgAv6gAi+eQETgAgAv/gAi9eQEWgAgAwEgAi8
					eQEXgAgAwGgAi6ePEEgAgAvlgAi2eNC7gAgAtUgAi0eLCfgAgAsUgAi1eLCdgAgAsPgAi2eLCbgAgAsK]],
				Head = [[
					gAjjdf/7gAgAh7gAjkde/7gAgAh9gAjlde/7gAgAh7gAjmde/8gAgAh2gAjmde/8gAgAhugAjndd/9gAgAhkgAjmde/9gAgAhZgAjkdf/+gGgBg2gAjgdi//
					gZgGfsgAjadm/7gzgPePgAjUdr/0hMgac5gAjRdu/thdgicAgAjPdv/rhfgkbygAjPdv/shaghb8gAjPdv/uhRgecHgAjPdv/whHgacSgAjPdv/xg7gVcbgA
					jPdv/ygugQcjgAjPdv/zgfgLcogAjPdv/0gQgFcqgAjPdv/0gAgAcogAjSdt/3fyf7dHgAjYdo/9fsf6edgAjfdi//fxf9gHgAjlde/9f8f/hVgAjndd/9gA
					gAhkgAjmde/9gAgAhZgAjpdg//gAgAgXgAjzdr/0gAgAcrgAj3dw/ngAgAbGgAj1dw/mgAgAbBgAj0dx/mgAgAbAgAjzdx/mgAgAbCgAjydy/ngAgAbHgAjy
					dy/ogAgAbPgAjvdv/xgAgAcPgAjkdk//gAgAf8gAjgdg/9gAgAhlgAjhdg/8gAgAhvgAjidf/8gAgAh2]],
				Jaw = [[
					gAiide/vgAgAkBgAijde/tgAgAkOgAikdd/sgAgAkWgAildd/sgAgAkZgAimdc/sgAgAkWgAimdb/tgAgAkOgAimdb/vgAgAkBgAikda/0gGgCjXgCigdY/7
					gYgIiCgDibdX/+gygSgcgFiXdW/8hKgffAgGiVdW/7hagqeqgGiUdX/8hagwf1gGiUdX/7hTgwhXgFiTdY/5hKgsiHgFiTdZ/7hCglhtgEiTdZ/+g4gcgfgD
					iTda/+gsgUfOgCiTda/9gfgNevgBiSda/9gPgGexgAiTda/9gAgAevf/iUda/+fyf6fPf/iYda/+fsf5gsf/ifdb/5fyf8iigAikdc/vf8f/j8gAimdb/tgA
					gAkOgAimdb/vgAgAkBgAipdZ/0gAgAjPgAi2dV/+gAgAgygAi8dU//gAgAfmgAi7dV//gAgAfWgAi6dV/+gAgAfJgAi4dW/+gAgAfBgAi3dW/+gAgAe/gAi3
					dX/+gAgAfCgAiydY//gAgAfsgAikdc/7gAgAiFgAifde/1gAgAjOgAigde/zgAgAjggAihde/xgAgAjy]],
				["UpperLegF.L"] = [[
					e6hjfWzNW+ff37e6hlfVzTXFfm35e6hmfUzaXLft32e6hmfTzhXQfy3ye6hnfTzmXTf23we6hnfTznXVf33ue6hnfTzmXTf23we6hlfVz+W8fr3Se6hffa1w
					V/ff1Me6hZfg5CUjfuwSe6hUfn7ZTOgFqfe6hRfr7sSpf7o1e6hQft7wSdf4oUe6hQft7wSdf4oUe6hQft7wSdf4oUe6hQft7wSdf4oUe6hQft7wSdf4oUe6
					hQft7wSdf4oUe6hQft7wSdf4oUe6hQft7wSdf4oUe6hQft7wSdf4oUe6hRfq7pSxf9pLe6hXfj7DTxgPr6e6hffb2bVwfi0Xe6hlfU0BW/fu3Re6hnfTznXV
					f33ue6hnfTzmXTf23we6hmfTzhXQfy3ye6hmfUzaXLft32e6hlfVzTXFfm35e6hjfWzNW+ff37e6hifXzKW3fZ37e6hhfXzHWwfU36e6hhfYzHWrfQ35e6hg
					fZzHWnfN33e6hgfZzHWmfM33e6hgfZzHWnfN33e6hhfYzHWrfQ35e6hhfXzHWwfU36e6hifXzKW3fZ37]],
				["LowerLegF.L"] = [[
					eng+fb9Fbtgzsleog/fa8zb0gptQeohAfY8hb5gft4ephBfY8Sb9gWuZephBfX8Hb/gQuuephBfX8Db/gNu2ephBfX8Hb/gQuueog/fX83bqghtGeog6fV96
					awgoqCeqg4fM9/ZsfepLevg8fG9dZGd+qNewg9fI97Y0eFoiewg9fI+CYueHoBewg9fI+CYueHoBewg9fI+CYueHoBewg9fI+CYueHoBewg9fI+CYueHoBew
					g9fI+CYueHoBewg9fI+CYueHoBewg9fI+CYueHoBewg9fI+CYueHoBewg9fH91Y4eDo4eug8fF8+ZXd5rpeog6fT9+ajgdpweog/fX8ubtgctZephBfX8Db/
					gNu2ephBfX8Hb/gQuuephBfY8Sb9gWuZeohAfY8hb5gft4eog/fa8zb0gptQeng+fb9Fbtgzsleng9fc9Vbmg9r8eng8fc9ibfhErXemg8fd9sbahKq7emg7
					fd9ybWhOqpemg7fd90bVhPqjemg7fd9ybWhOqpemg8fd9sbahKq7eng8fc9ibfhErXeng9fc9Vbmg9r8]],
				["FootF.L"] = [[
					emgnfF/mf4gBk+emgnfF/mf8gBk+emgnfF/mf+gAk+emgnfF/mgAgAk+emgnfF/mgAgAk+emgnfF/mgAgAk+emgnfF/mgAgAk+emgnfC/mfxgCk+emgne7/l
					e6gLk+emgney/gdmgYk9engret/VcvgDllepguet/Rcgfslyepgvet/Qcafmlxepgvet/Qcafmlxepgvet/Qcafmlxepgvet/Qcafmlxepgvet/Qcafmlxep
					gvet/Qcafmlxepgvet/Qcafmlxepgvet/Qcafmlxepgvet/Qcafmlxeogtes/Rcjfxlyemgoeu/bc/gWlLemgne5/kergNk+emgnfC/mfzgCk+emgnfF/mgA
					gAk+emgnfF/mgAgAk+emgnfF/mgAgAk+emgnfF/mf+gAk+emgnfF/mf8gBk+emgnfF/mf4gBk+emgnfF/mf0gCk+emgnfF/mfvgDk+emgnfF/mfqgDk+emgn
					fF/mfngEk+emgnfF/mfmgEk+emgnfF/mfngEk+emgnfF/mfqgDk+emgnfF/mfvgDk+emgnfF/mf0gCk+]],
				["UpperLegF.R"] = [[
					hGhjfWzNpCgh37hGhlfVzTo7ga35hGhmfUzao1gT32hGhmfTzhowgO3yhGhnfTzmotgK3whGhnfTznorgJ3uhGhnfTzmotgK3whGhlfVz+pEgV3ShGhffa1w
					qBgh1MhGhZfg5CrdgSwShGhUfn7Zsyf7qfhGhRfr7stXgFo1hGhQft7wtjgIoUhGhQft7wtjgIoUhGhQft7wtjgIoUhGhQft7wtjgIoUhGhQft7wtjgIoUhG
					hQft7wtjgIoUhGhQft7wtjgIoUhGhQft7wtjgIoUhGhQft7wtjgIoUhGhRfq7ptPgDpLhGhXfj7DsPfxr6hGhffb2bqQge0XhGhlfU0BpBgS3RhGhnfTznor
					gJ3uhGhnfTzmotgK3whGhmfTzhowgO3yhGhmfUzao1gT32hGhlfVzTo7ga35hGhjfWzNpCgh37hGhifXzKpJgn37hGhhfXzHpQgs36hGhhfYzHpVgw35hGhg
					fZzHpZgz33hGhgfZzHpag033hGhgfZzHpZgz33hGhhfYzHpVgw35hGhhfXzHpQgs36hGhifXzKpJgn37]],
				["LowerLegF.R"] = [[
					hZg+fb9FkTfNslhYg/fa8zkMfXtQhYhAfY8hkHfht4hXhBfY8SkDfquZhXhBfX8HkBfwuuhXhBfX8DkBfzu2hXhBfX8HkBfwuuhYg/fX83kWfftGhYg6fV96
					lQfYqChWg4fM9/mUgipLhRg8fG9dm6iCqNhQg9fI97nMh7oihQg9fI+CnSh5oBhQg9fI+CnSh5oBhQg9fI+CnSh5oBhQg9fI+CnSh5oBhQg9fI+CnSh5oBhQ
					g9fI+CnSh5oBhQg9fI+CnSh5oBhQg9fI+CnSh5oBhQg9fI+CnSh5oBhQg9fH91nIh9o4hSg8fF8+mpiHrphYg6fT9+ldfjpwhYg/fX8ukTfktZhXhBfX8DkB
					fzu2hXhBfX8HkBfwuuhXhBfY8SkDfquZhYhAfY8hkHfht4hYg/fa8zkMfXtQhZg+fb9FkTfNslhZg9fc9VkafDr8hZg8fc9ikhe8rXhag8fd9skme2q7hag7
					fd9ykqeyqphag7fd90krexqjhag7fd9ykqeyqphag8fd9skme2q7hZg8fc9ikhe8rXhZg9fc9VkafDr8]],
				["FootF.R"] = [[
					hagnfF/mgIf/k+hagnfF/mgEf/k+hagnfF/mgCgAk+hagnfF/mgAgAk+hagnfF/mgAgAk+hagnfF/mgAgAk+hagnfF/mgAgAk+hagnfC/mgPf+k+hagne7/l
					hGf1k+hagney/giafok9hZgret/VjRf9llhXguet/RjggUlyhXgvet/QjmgalxhXgvet/QjmgalxhXgvet/QjmgalxhXgvet/QjmgalxhXgvet/QjmgalxhX
					gvet/QjmgalxhXgvet/QjmgalxhXgvet/QjmgalxhXgvet/QjmgalxhYgtes/RjdgPlyhagoeu/bjBfqlLhagne5/khVfzk+hagnfC/mgNf+k+hagnfF/mgA
					gAk+hagnfF/mgAgAk+hagnfF/mgAgAk+hagnfF/mgCgAk+hagnfF/mgEf/k+hagnfF/mgIf/k+hagnfF/mgMf+k+hagnfF/mgRf9k+hagnfF/mgWf9k+hagn
					fF/mgZf8k+hagnfF/mgaf8k+hagnfF/mgZf8k+hagnfF/mgWf9k+hagnfF/mgRf9k+hagnfF/mgMf+k+]],
				Tail1 = [[
					gAixhbjAgAgA/2gAixhbi3gTf9/3gAiyhbiwgmf7/3gAiyhbiqg4f4/3gAiyhbimhJf2/3gAizhbilhYf0/2gAiyhbimhkfz/2gAiyhbiqhnfx/1gAiyhbiv
					hYfx/2gAixhbizg9f0/2gAixhbiygef5/3gAixhbiwgIf+/3gAixhbiugAgA/4gAixhbiugAgA/4gAixhbiugAgA/4gAixhbiugAgA/4gAixhbiugAgA/4gA
					ixhbiugAgA/4gAixhbiugAgA/4gAixhbiugAgA/4gAixhbiugAgA/4gAixhbivf+gA/4gAixhbivfygD/3gAiyhbirfZgH/3gAiyhbine8gK/3gAizhbileo
					gM/2gAiyhbimecgN/2gAiyhbiqeSgP/1gAiyhbiweKgQ/0gAixhbi3eGgR/zgAixhbi/eEgS/ygAiwhbjIeGgS/ygAiwhbjPeLgS/xgAivhbjVeSgR/xgAiv
					hbjZecgQ/xgAivhbjaepgO/xgAivhbjZe3gM/ygAivhbjVfIgJ/zgAiwhbjPfagG/0gAiwhbjIftgD/1]],
				Tail2 = [[
					gAiqiAjyfEgF/wgBiqiAjifpgA/ygBiriAjTgPf8/0gCisiAjHg0f4/1gDisiAi/hYf0/0gDisiAi9h6fw/zgEisiAi/iZft/wgEisiAjPiofp/tgDiriAjw
					iXfo/rgCiqiAkWhtfr/pgBiqiAk0g5fz/ngAiqiAlGgQf8/lgAiqiAlLgAgA/kgAiqiAlLgAgA/kgAiqiAlLgAgA/kgAiqiAlLgAgA/kgAiqiAlLgAgA/kgA
					iqiAlLgAgA/kgAiqiAlLgAgA/kgAiqiAlLgAgA/kgAiqiAlLgAgA/kgAiqiAlAgCgA/mf/iriAkef7gD/rf/iriAjwfcgI/xf+isiAjJeugM/zf9isiAi9eG
					gQ/zf8isiAi/dngT/wf8isiAjGdMgW/tf8iriAjSc2ga/qf8iqiAjhckgc/nf7iqiAjxcYge/jf8ipiAkBcSgg/gf8ioiAkQcRgg/ef8iniAkccXgg/df8in
					iAkkcige/ef9iniAkmcygb/ff9iniAkkdHgY/if+iniAkddhgT/lf/ioiAkRd/gP/pf/ipiAkCeggK/s]],
				Tail3 = [[
					f+ihilkIdbgG/ngAiiiljveLgC/ugCijiljZe/f9/ygEilimjHf1f5/1gGilili8gqf1/2gIilili4hffx/0gJilili8iRft/xgKikiljYizfp/sgJiiilkV
					iufl/kgGigilldiFfn/dgDifilmZhJfw/UgBieilm+gVf7/OgAieilnKgAgA/LgAieilnKgAgA/LgAieilnKgAgA/LgAieilnKgAgA/LgAieilnKgAgA/LgA
					ieilnKgAgA/LgAieilnKgAgA/LgAieilnKgAgA/LgAieilnKgAgA/LgAifilmzgMgA/Qf/igillxgYgD/df9ijilkYgIgI/sf7ililjOfZgM/0f4ilili4eh
					gP/0f3ilili8dvgT/xf1ililjHdAgX/sf0ijikjZcXgb/mf0iiikjvbzge/ffzihikkHbWgh/YfzifikkfbAgj/Rfzieijk1azgl/Mf0idijlHatgk/If0ic
					ijlSavgi/Gf1iciklWa6gf/Hf3iciklSbMgb/Lf4idiklHbmgW/Rf6ieikk2cHgR/Yf8ifilkgcugM/g]],
				Tail4 = [[
					f4iXjJjybff6/cf8iZjKjScSf2/mgAibjKi0dLfz/vgEidjLiceJfx/2gHiejLiNfKfw/5gLifjKiIgNfu/6gPiejKiNhPfs/5gQicjJi2iFfo/ygPiYjJkP
					iXfj/ngLiTjIl5h/fl/YgGiQjHnThLfu/HgCiOjHoMgXf7+7gAiOjHodgAgA+2gAiOjHodgAgA+2gAiOjHodgAgA+2gAiOjHodgAgA+2gAiOjHodgAgA+2gA
					iOjHodgAgA+2gAiOjHodgAgA+2gAiOjHodgAgA+2gAiOjHodgAgA+2gAiPjHn7gZgB+/gAiTjImZhDgH/Vf+iYjKkUhTgO/rf5idjLiogygR/3f1ifjKiIfz
					gS/6fxiejKiNexgU/5fuidjJicdxgW/0fsibjJi0c1gZ/tfqiZjIjSb+gb/kfoiXjHjybOge/ZfoiUjGkTalgf/OfniSjGkwaFgf/EfoiRjFlIZvgd+8foiQ
					jFlXZhga+3fqiPjFlcZegV+1fsiQjGlXZlgQ+4fuiRjHlIZ2gK++fxiSjHkwaQgE/Gf0iVjIkTazf+/R]],
				Tail5 = [[
					ftiOjtiAZ0fP/UfziSjuhWaffN/ef5iVjvgwbUfO/of/iXjwgRcRfQ/wgFiZjwf+dTfU/3gMiajwf2ebfY/8gRiZjwf9flfc//gViVjugygsfd/+gUiOjtio
					hafc/2gPiGjrk1heff/lgIh/jpmvg+fs/QgCh7jon7gUf6+/gAh6jnoTgAgA+5gAh6jnoTgAgA+5gAh6jnoTgAgA+5gAh6jnoTgAgA+5gAh6jnoTgAgA+5gA
					h6jnoTgAgA+5gAh6jnoTgAgA+5gAh6jnoTgAgA+5gAh6jnoTgAgA+5gBh8jonmgkgF/EgDiEjrlihvgW/dgBiOjuixilgn/wf7iXjwghihgs/4f0iajwf2hl
					go/8fviZjwf9gbgk//fpiXjvgPfRgg/+fliVjtgteHgd/7fhiRjshTdBgb/0fdiOjqh9cAgY/rfbiKjpinbGgV/gfaiHjnjNaTgQ/UfZiFjmjrZqgJ/JfaiD
					jmj+ZLgB/AfbiDjmkFY2f4+6fdiDjnj/Ysft+4fgiFjojsYtfj+7fkiHjpjPY6fa/BfoiLjripZRfT/K]],
				["UpperLegB.L"] = [[
					e2h2g74UXkgIzAe2h2g74MXqgMzMe2h3g74FXxgQzYe2h3g73+X2gTzie2h3g736X5gWzpe2h3g735X7gWzre2h3g736X5gWzpe2h3g74HXvgSzUe2h1g94h
					XZgLype2h0g/49XBgFx5e2hzhB5SWtgCxQe2hyhC5fWhgBw2e2hyhC5jWdgBwue2hyhC5jWdgBwue2hyhC5jWdgBwue2hyhC5jWdgBwue2hyhC5jWdgBwue2
					hyhC5jWdgBwue2hyhC5jWdgBwue2hyhC5jWdgBwue2hyhC5jWdgBwue2hyhC5bWkgCw9e2h0hA5FW5gFxoe2h1g94kXXgMyle2h3g74EXygTzae2h3g735X7
					gWzre2h3g736X5gWzpe2h3g73+X2gTzie2h3g74FXxgQzYe2h2g74MXqgMzMe2h2g74UXkgIzAe2h1g74bXdgEy0e2h0g74hXYgByqe2h0g74lXUf+yie2h0
					g74oXRf8yde2h0g74pXQf8ybe2h0g74oXRf8yde2h0g74lXUf+yie2h0g74hXYgByqe2h1g74bXdgEy0]],
				["LowerLegB.L"] = [[
					enhJgsxAdrgK7AenhKgtxSdlgJ6zenhKguxkdfgH6neohKguxydagF6deohKgvx8dXgE6XeohKgvx/dWgE6UeohKgvx8dXgE6XenhKguxrdcgI6ienhKgtxQ
					djgR60enhJgsw9dmga7BenhJgsw2dlgi7FenhJgsw4dhgn7DenhJgsw6dfgp7CenhJgsw6dfgp7CenhJgsw6dfgp7CenhJgsw6dfgp7CenhJgsw6dfgp7Cen
					hJgsw6dfgp7CenhJgsw6dfgp7CenhJgsw6dfgp7CenhJgsw6dfgp7CenhJgsw5dhgm7CenhJgsxAdjge6/enhKgtxWdhgS6xeohKguxzdZgH6ceohKgvx/dW
					gE6UeohKgvx8dXgE6XeohKguxydagF6denhKguxkdfgH6nenhKgtxSdlgJ6zenhJgsxAdrgK7AenhJgswudxgM7LenhJgrwed3gN7VenhJgrwSd7gO7denhI
					gqwKd9gP7ienhIgqwHd+gP7jenhIgqwKd9gP7ienhJgrwSd7gO7denhJgrwed3gN7VenhJgswudxgM7L]],
				["FootB.L"] = [[
					ejgqg7/jf7gBlRejgqg7/jf2gClRejgqg7/jfxgClRejgqg7/jftgDlRejgqg7/jfqgElRejgqg7/jfpgElRejgqg7/jfqgElRejgqg7/jfwgDlRejgqg7/j
					f6gBlRejgqg7/jgBgAlRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRej
					gqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgFf/lRejgqg7/jgCgAlRejgqg7/jf5gBlRejgqg7/jfugDlRejgqg7/jfp
					gElRejgqg7/jfqgElRejgqg7/jftgDlRejgqg7/jfxgClRejgqg7/jf2gClRejgqg7/jf7gBlRejgqg7/jgAgAlRejgqg7/jgEf/lRejgqg7/jgHf/lRejgq
					g7/jgIf/lRejgqg7/jgJf+lRejgqg7/jgIf/lRejgqg7/jgHf/lRejgqg7/jgEf/lRejgqg7/jgAgAlR]],
				["UpperLegB.R"] = [[
					hKh2g74Uocf4zAhKh2g74MoWf0zMhKh3g74FoPfwzYhKh3g73+oKftzihKh3g736oHfqzphKh3g735oFfqzrhKh3g736oHfqzphKh3g74HoRfuzUhKh1g94h
					onf1yphKh0g/49o/f7x5hKhzhB5SpTf+xQhKhyhC5fpff/w2hKhyhC5jpjf/wuhKhyhC5jpjf/wuhKhyhC5jpjf/wuhKhyhC5jpjf/wuhKhyhC5jpjf/wuhK
					hyhC5jpjf/wuhKhyhC5jpjf/wuhKhyhC5jpjf/wuhKhyhC5jpjf/wuhKhyhC5bpcf+w9hKh0hA5FpHf7xohKh1g94kopf0ylhKh3g74EoOftzahKh3g735oF
					fqzrhKh3g736oHfqzphKh3g73+oKftzihKh3g74FoPfwzYhKh2g74MoWf0zMhKh2g74Uocf4zAhKh1g74bojf8y0hKh0g74hoof/yqhKh0g74losgCyihKh0
					g74oovgEydhKh0g74powgEybhKh0g74oovgEydhKh0g74losgCyihKh0g74hoof/yqhKh1g74bojf8y0]],
				["LowerLegB.R"] = [[
					hZhJgsxAiVf27AhZhKgtxSibf36zhZhKguxkihf56nhYhKguxyimf76dhYhKgvx8ipf86XhYhKgvx/iqf86UhYhKgvx8ipf86XhZhKguxrikf46ihZhKgtxQ
					idfv60hZhJgsw9iafm7BhZhJgsw2ibfe7FhZhJgsw4iffZ7DhZhJgsw6ihfX7ChZhJgsw6ihfX7ChZhJgsw6ihfX7ChZhJgsw6ihfX7ChZhJgsw6ihfX7ChZ
					hJgsw6ihfX7ChZhJgsw6ihfX7ChZhJgsw6ihfX7ChZhJgsw6ihfX7ChZhJgsw5iffa7ChZhJgsxAidfi6/hZhKgtxWiffu6xhYhKguxzinf56chYhKgvx/iq
					f86UhYhKgvx8ipf86XhYhKguxyimf76dhZhKguxkihf56nhZhKgtxSibf36zhZhJgsxAiVf27AhZhJgswuiPf07LhZhJgrweiJfz7VhZhJgrwSiFfy7dhZhI
					gqwKiDfx7ihZhIgqwHiCfx7jhZhIgqwKiDfx7ihZhJgrwSiFfy7dhZhJgrweiJfz7VhZhJgswuiPf07L]],
				["FootB.R"] = [[
					hdgqg7/jgFf/lRhdgqg7/jgKf+lRhdgqg7/jgPf+lRhdgqg7/jgTf9lRhdgqg7/jgWf8lRhdgqg7/jgXf8lRhdgqg7/jgWf8lRhdgqg7/jgQf9lRhdgqg7/j
					gGf/lRhdgqg7/jf/gAlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhd
					gqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf7gBlRhdgqg7/jf+gAlRhdgqg7/jgHf/lRhdgqg7/jgSf9lRhdgqg7/jgX
					f8lRhdgqg7/jgWf8lRhdgqg7/jgTf9lRhdgqg7/jgPf+lRhdgqg7/jgKf+lRhdgqg7/jgFf/lRhdgqg7/jgAgAlRhdgqg7/jf8gBlRhdgqg7/jf5gBlRhdgq
					g7/jf4gBlRhdgqg7/jf3gClRhdgqg7/jf4gBlRhdgqg7/jf5gBlRhdgqg7/jf8gBlRhdgqg7/jgAgAlR]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAitgx/9g2gChNgAiugx/9gzfphNgAiwgx/9grfUhNgAizgx/8gdfDhNgAi1gx/8gMe6hNgAi1gx/8f5e5hMgAizgx/8fofBhMgAiwgx/9fZfRhMgAiugx/9
					fPfmhMgAitgx/9fKf+hNgAiugx/9fNgXhNgAiwgx/9fVgshNgAizgx/8fjg9hNgAi1gx/8f0hGhNgAi1gx/8gHhHhMgAizgx/8gYg/hMgAiwgx/9gngvhMgA
					iugx/9gxgahM]],
				Spine1 = [[
					gAirgY/9gbgBhNf/isgY/9gafyhNf/iugY/9gWfkhNf/ixgY/9gPfahNf+izgY/9gGfUhNf+izgY/9f9fUhMf+ixgY/9f0fZhMf/iugY/9ftfjhMf/isgY/9
					fnfwhMgAirgY/9flf/hNgBisgY/9fmgOhNgBiugY/9fqgchNgBixgY/9fxgmhNgCizgY/9f6gshNgCizgY/9gDgshMgCixgY/9gMgnhMgBiugY/9gTgdhMgB
					isgY/9gZgQhM]],
				Spine2 = [[
					gAipf+/jgAgAlRf/iqf+/jgBf6lRf+isf+/jgCf1lRf+ivf+/jgDfxlRf9ixf+/jgDfvlRf9ixf+/jgDfvlQf9iwf+/jgDfxlQf+itf+/jgCf1lQf/iqf+/j
					gBf6lQgAipf+/jgAgAlRgBiqf+/jf/gGlRgCisf+/jf+gLlRgCivf+/jf9gPlRgDixf+/jf9gRlRgDixf+/jf9gRlQgDiwf+/jf9gPlQgCitf+/jf+gLlQgB
					iqf+/jf/gGlQ]],
				Spine3 = [[
					gAihfo/jfmf8lQf/iifo/jfnf/lRf+ilfo/jfrgClRf9iofo/jfygFlRf9iqfo/jf6gIlRf9iqfo/jgDgJlQf9iofo/jgMgKlQf+ilfo/jgTgJlQf/iifo/j
					gYgHlQgAihfo/jgagElQgBiifo/jgZgBlRgCilfo/jgVf+lRgDiofo/jgOf7lRgDiqfo/jgGf4lRgDiqfo/jf9f3lQgDiofo/jf0f2lQgCilfo/jftf3lQgB
					iifo/jfof5lQ]],
				Neck1 = [[
					gAiZfRAHgbf+icf/iafRAGgYfyiRf+idfSAGgTfoiTf9igfSAIgLfgigf9iifSAJgCfcizf9iifSALf5fdjCf9igfSALfxfijHf+idfSAKfqfri/f/ibfRAJ
					fmf2iugAiZfRAHflgCicgBiafRAGfogOiRgCidfSAGftgYiTgDigfSAIf1ggiggDiifSAJf+gkizgDiifSALgHgjjCgDigfSALgPgejHgCidfSAKgWgVi/gB
					ibfRAJgagKiu]],
				Neck2 = [[
					gAigenBSgaf5o4gAigenBMgSflokf/ijenBNgJfUonf/ineoBVf+fIpBf+ipeoBgf0fDpkf+iqeoBpfrfGqBf/ioeoBsflfQqKf/ileoBmfifgp7f/iieoBc
					fifzpbgAigenBSfmgHo4gAigenBMfugbokgBijenBNf3gsongBineoBVgCg4pBgCipeoBggMg9pkgCiqeoBpgVg6qBgBioeoBsgbgwqKgBileoBmgeggp7gB
					iieoBcgegNpb]],
				Neck3 = [[
					gBizeJB0gZf3qlgBizeJBqgOfbqHgBi2eJBtgAfDqMgBi6eJB6fzeyqxgAi+eKCOfoerrlgAjAeLCffgeusPgAi+eLCkfbe8scgAi6eLCafbfRsHf/i2eKCH
					fffsrYf/izeJB0fngJqlf/izeJBqfyglqHf/i2eJBtgAg9qMf/i6eJB6gNhOqxgAi+eKCOgYhVrlgAjAeLCfgghSsPgAi+eLCkglhEscgAi6eLCaglgvsHgB
					i2eKCHghgUrY]],
				Head = [[
					gCjadZ/tgYgBkLgDjYdX/pgMgqkrgEjbdY/rf/hQkRgFjhda/yfxhsjLgFjodd/4flh5h5gEjrdf/6fch1hBgDjqdg/7fYhkg+gBjmdf/6fZhIhxgAjfdc/1
					fegmjCf+jadZ/tfof/kLf9jYdX/pf0fWkrf8jbdY/rgBewkRf7jhda/ygPeUjLf7jodd/4gbeHh5f8jrdf/6gkeLhBf9jqdg/7goecg+f/jmdf/6gne4hxgA
					jfdc/1gifajC]],
				Jaw = [[
					gDiadh/ogYgCkugEiYdi/jgLgqlNgEibdh/mf9hQk0gEihde/ufvhrjugDindc/1fjh4icgCirdb/5fah1hkgBiqdc/6fWhjhhf/ildd/4fXhIiUf+ifdg/y
					fegljlf9iadh/ofof+kuf8iYdi/jf1fWlNf8ibdh/mgDewk0f8ihde/ugReVjuf9indc/1gdeIicf+irdb/5gmeLhkf/iqdc/6gqedhhgBildd/4gpe4iUgC
					ifdg/ygifbjl]],
				["UpperLegF.L"] = [[
					e4hifRn+YlcU92e3hjfRsaXobx79e3hlfRx3Wicy4le2hofR11WAei1Fe3hpfR6lWDhGute3hofR6NWchVvme4hmfR50WchGwRe5hjfR2oWjfy0je6hgfR0l
					Wue+2oe7hefRzCW7eg4Ae8hffSx9XKeY45e9hifSxaXZen5Ye9hmfSxTXofB5je9hofSxRX5fd5re9hpfSwuYNfs6Ie8hofSvWYhfr7De7hlfStlY1fk8Ee6
					hjfSo8Yxd79y]],
				["LowerLegF.L"] = [[
					ekhRfy+DcdiGqMeghJfp/Sa4jUiwefhEfa/WapjagTejhDfM/Pa+iLkKethIe578a1ejuneuhGe77fbFeqvieuhDe97GbBeTwKepg9fK9abTgDrreng6fR+A
					bRgkqCeng6fX+BbOgnp7eog8fb9nbUgYrKepg/fd8vbjf/tWeqhCfe7cb1fgv6erhEfe5/cGfEyOeshGfg46cYe8zterhGfk4dc0fJ0XeqhGfo4KdXfc0yem
					hOfx7Pdxg1wm]],
				["FootF.L"] = [[
					emg9fZ/Fgqf2njemhDfK+6ezgUoKemhCe7+6eYgboDemg6et/JfBgPnPemgven/YekgLmFengseq/XexfzmLemgoeu/ieogJlNemgney/mfVgHk+emgne4/m
					fbgGk+emgne9/mfYgGk+emgnfD/mfbgGk+emgnfI/mfkgEk+emgnfO/mfrgDk+emgnfT/mfwgCk+emgnfZ/mf8gBk+emgnfe/mgYf8k+emgnfk/lg9f2k+em
					gyfi/UhyfpmT]],
				["UpperLegF.R"] = [[
					hFhefRzCpFhg4AhEhffSx9o2ho45hDhifSxaonhZ5YhDhmfSxToYg/5jhDhofSxRoHgj5rhDhpfSwunzgU6IhEhofSvWnfgV7DhFhlfStlnLgc8EhGhjfSo8
					nPiF9yhIhifRn+nbjs92hJhjfRsaoYkP79hJhlfRx3pejO4lhKhofR11qAhe1FhJhpfR6lp9e6uthJhofR6NpkervmhIhmfR50pke6wRhHhjfR2opdgO0jhG
					hgfR0lpShC2o]],
				["LowerLegF.R"] = [[
					hZg6fX+BkyfZp7hYg8fb9nksforKhXg/fd8vkdgBtWhWhCfe7ckLggv6hVhEfe5/j6g8yOhUhGfg46johEzthVhGfk4djMg30XhWhGfo4Kipgk0yhahOfx7P
					iPfLwmhchRfy+Djjd6qMhghJfp/SlIcsiwhhhEfa/WlXcmgThdhDfM/PlCd1kKhThIe578lLhdunhShGe77fk7hWvihShDe97Gk/htwKhXg9fK9aktf9rrhZ
					g6fR+AkvfcqC]],
				["FootF.R"] = [[
					hagne9/mgof6k+hagnfD/mglf6k+hagnfI/mgcf8k+hagnfO/mgVf9k+hagnfT/mgQf+k+hagnfZ/mgEf/k+hagnfe/mfogEk+hagnfk/lfDgKk+hagyfi/U
					eOgXmThag9fZ/FfWgKnjhahDfK+6hNfsoKhahCe7+6hofloDhag6et/Jg/fxnPhagven/Yhcf1mFhZgseq/XhPgNmLhagoeu/ihYf3lNhagney/mgrf5k+ha
					gne4/mglf6k+]],
				Tail1 = [[
					gAimhaibg5gx/4gBinhaiKgngw/5gCiqhaiBgRgo/6gDithaiFf4gb/6gDivhaiTfhgM/5gDivhailfNf7/4gCithaiye/fr/2gCiqhai1e5fd/1gBinhais
					e8fT/2gAimhaibfHfP/4f/inhaiKfZfQ/5f+iqhaiBfvfY/6f9ithaiFgIfl/6f9ivhaiTgff0/5f9ivhailgzgF/4f+ithaiyhBgV/2f+iqhai1hHgj/1f/
					inhaishEgt/2]],
				Tail2 = [[
					gDihiAiBiZgs/1gDiiiAhghlgs/6gDiliAhIgmgn/9gCioiAhEfjgc/9gCipiAhXejgO/7gBipiAh2duf+/2gAimiAiVdLfw/xf/ijiAijc9fk/vf+ihiAic
					dHfa/wf9ihiAiBdnfU/1f9iiiAhgebfU/6f9iliAhIfafZ/9f+ioiAhEgdfk/9f+ipiAhXhdfy/7f/ipiAh2iSgC/2gAimiAiVi1gQ/xgBijiAijjDgc/vgC
					ihiAici5gm/w]],
				Tail3 = [[
					gIicilhUkQgr/rgHifimgojLgr/0gEijimgAhtgl/8gBilimftgDga//f+imimf5eZgK/8f7ikilgec7f5/1f5ihilhLb0fq/sf4idilhrbOfg/lf3ibilhu
					bMfZ/kf4icilhUbwfV/rf5ifimgoc1fV/0f8ijimgAeTfb/8f/ilimftf9fm//gCimimf5hnf2/8gFikilgejFgH/1gHihilhLkMgW/sgIidilhrkygg/lgJ
					ibilhuk0gn/k]],
				Tail4 = [[
					gSiZjKf9mHg6/YgOidjLfRlDg0/kgIijjMecjYgq/xgBimjMd4hTga/5f7imjMd2fFgE/5f0ijjLeWc+fs/zfviejJfKbOfX/nfsiajJf5aCfK/afsiXjJgN
					ZlfF/UfuiZjKf9Z5fG/YfyidjLfRa9fM/kf4ijjMeccofW/xf/imjMd4etfm/5gFimjMd2g7f8/5gMijjLeWjCgU/zgRiejJfKkygp/ngUiajJf5l+g2/agU
					iXjJgNmbg7/U]],
				Tail5 = [[
					ghiajtdCniht+5gaifjvcfmyhf/BgQimjxbnlOhJ/PgFirjya1jCgr/af4isjxahgegG/gftinjwazd3fd/ffkigjubkbhe2/VfeiajsccZteb/HfdiXjsdB
					YqeQ+8ffiajtdCYeeT+5fmifjvcfZOeh/Bfwimjxbnaye3/Pf7irjya1c+fV/agIisjxahfif6/ggTinjwaziJgj/fgcigjubkkfhK/VgiiajsccmThl/Hgj
					iXjsdBnWhw+8]],
				["UpperLegB.L"] = [[
					e6hpg37yVheVrwe5hqg57kV1eKsge5hug77HWbePt6e4hyg86bXLehvpe3h1g95qX2e3xPe2h2g95BYPfHyVe1h1g84lYSfPy8e0h0g74IYMfazfezhyg53Z
					YMfu0Yezhxg32QYcgN1tezhyg20lZDg23eezh0g0xpaZhu6Ce0h1gzwdahh560e1h2gy0dXjgz3Fe2h1gy3CVef/zje4hygz5kTvfEuxe4hug07bTKeMqKe5
					hqg28JT9d1pB]],
				["LowerLegB.L"] = [[
					ephMgUz0cofk44eohLgYzNdNfg5beohLgdzHdoff5ienhLgjzVd4fe5ZenhLgozYeEfc5XemhLgsyueZfj54elhKgtxLe6fy6+ekhHguvIfbgD8LejhEgwtQ
					fugM9HekhDg0sKfmgN9lelhDg5sZe8gI9eeohHhEvCdVf08HephKhHupc6f08RekhIg0mVfcf+/WejhKgmi7gMfR/2ekhPgXkEfwec/senhVgNpleceZ+cep
					hVgNvbdVfJ75]],
				["FootB.L"] = [[
					ejgqgb/ie3gMlRejgqgh/ifQgIlRejgqgm/jfjgFlRejgqgs/jfugDlRejgqgx/jf2gClRejgqg3/jgJf/lRejgqg8/jgnf5lRejgqhC/ihEf1lRejgqhH/h
					hTfylRejgqhM/ihLfzlRejgqhS/jgof5lRejgqhX/jfVgHlRejguhb/cfAgMlxejg7hV/Kgrf2nNejhDhI+7gwfzoHejhGg5+4f/gAoWejhBgq+/fKgOn6ej
					g3gf/Pe9gPm1]],
				["UpperLegB.R"] = [[
					hNhxg32Qnkfz1thNhyg20lm9fK3ehNh0g0xplneS6ChMh1gzwdlfeH60hLh2gy0dodfN3FhKh1gy3CqigBzjhIhygz5ksRg8uxhIhug07bs2h0qKhHhqg28J
					sDiLpBhGhpg37yqfhrrwhHhqg57kqLh2sghHhug77Hplhxt6hIhyg86bo1hfvphJh1g95qoKhJxPhKh2g95Bnxg5yVhLh1g84lnugxy8hMh0g74In0gmzfhN
					hyg53Zn0gS0Y]],
				["LowerLegB.R"] = [[
					hchDg0sKgafz9lhbhDg5sZhEf49ehYhHhEvCirgM8HhXhKhHupjGgM8RhchIg0mVgkgC/WhdhKgmi7f0gv/2hchPgXkEgQhk/shZhVgNplhkhn+chXhVgNvb
					irg375hXhMgUz0jYgc44hYhLgYzNizgg5bhYhLgdzHiYgh5ihZhLgjzViIgi5ZhZhLgozYh8gk5XhahLgsyuhngd54hbhKgtxLhGgO6+hchHguvIglf98Lhd
					hEgwtQgSf09H]],
				["FootB.R"] = [[
					hdgqhM/ie1gNlRhdgqhS/jfYgHlRhdgqhX/jgrf5lRhdguhb/chAf0lxhdg7hV/KfVgKnNhdhDhI+7fQgNoHhdhGg5+4gBgAoWhdhBgq+/g2fyn6hdg3gf/P
					hDfxm1hdgqgb/ihJf0lRhdgqgh/igwf4lRhdgqgm/jgdf7lRhdgqgs/jgSf9lRhdgqgx/jgKf+lRhdgqg3/jf3gBlRhdgqg8/jfZgHlRhdgqhC/ie8gLlRhd
					gqhH/hetgOlR]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAjBgx/5gAgAiigAi1gx/3gAfri1gAisgx/7gAfeiCgAizgx/9gBfehPgAjAgx/9gBfrhjgAjBgx/5gAgAiigAi1gx/3gAgVi1gAisgx/7gAgiiCgAizgx/9
					f/gihPgAjAgx/9f/gVhj]],
				Spine1 = [[
					gAi9gY/6gAgAiKf/ixgY/2gAfri6f/ipgY/5gBfeidf/ixgY/9gBfehbf/i9gY/9gAfrhPgAi9gY/6gAgAiKgBixgY/2gAgVi6gBipgY/5f/giidgBixgY/9
					f/gihbgBi9gY/9gAgVhP]],
				Spine2 = [[
					gAi6f+/dgAgAl2f/isf//NgCfrnBf+ilf+/PgGfem5f+iuf+/fgGfflqf/i7f+/mgDfrlAgAi6f+/dgAgAl2gBisf//Nf+gVnBgCilf+/Pf6gim5gCiuf+/f
					f6ghlqgBi7f+/mf9gVlA]],
				Spine3 = [[
					gAiyfo/hgAgAlff+iifp/MgDfrnGf+ibfp/JgGffnTf+imfo/cgGffl1f+i0fo/pgDfrksgAiyfo/hgAgAlfgCiifp/Mf9gVnGgCibfp/Jf6ghnTgCimfo/c
					f6ghl1gCi0fo/pf9gVks]],
				Neck1 = [[
					gAiqfSAOgAgAjnf+iYfUADgDgVhPf9iQfUABgCgigef9iefSAHgDgiiXf+itfRAUgDgVkUgAiqfSAOgAgAjngCiYfUADf9frhPgDiQfUABf+fegegDiefSAH
					f9feiXgCitfRAUf9frkU]],
				Neck2 = [[
					gAizepCGgAgArWf9ibeqBJgIgUoYf7iSepA0gJghnFf7ikeoBagKggpTf9i5eoCUgIgTr6gAizepCGgAgArWgDibeqBJf4fsoYgFiSepA0f3ffnFgFikeoBa
					f2fgpTgDi5eoCUf4ftr6]],
				Neck3 = [[
					gAjLeODYgAgAuSf9iteLB4gJgTquf6iheJBSgLggo7f6i4eKCJgMggref9jReODngKgSuugAjLeODYgAgAuSgDiteLB4f3ftqugGiheJBSf1fgo7gGi4eKCJ
					f0fgregDjReODnf2fuuu]],
				Head = [[
					gAj8dpABgAgAgkf8jUdbAIgAgVdTf5jCdVATf9gib2f5jhdcAEf+gieOf8kEdrACgBgVhIgAj8dpABgAgAgkgEjUdbAIgAfrdTgHjCdVATgDfeb2gHjhdcAE
					gCfeeOgEkEdrACf/frhI]],
				Jaw = [[
					gAi9de/4gAgAiqf8iUde/cgCfrl6f5iCdd/IgGffnVf5ihdb/mgFfek/f8jEde/7gBfriGgAi9de/4gAgAiqgEiUde/cf+gVl6gHiCdd/If6ghnVgHihdb/m
					f7gik/gEjEde/7f/gViG]],
				["UpperLegF.L"] = [[
					e6hwfTq0Zrf89be4hffclXY0ar+Pe3hYfezWUdZL1qe3hkfW3bVUcsyse4h0fR7tV+gbsde6hwfT7bV5hCs9e8hffZ6fUbgYtse9hXfZyRVfeB3+e9hkfSuA
					Xufd7ie8h0fOvvaOhx7M]],
				["LowerLegF.L"] = [[
					erhWfw0Vdwer4kekhVgA+maHiNm5eYg8fe8LXEkSUjeghDfK/GZtiFcmevhXez9Ea/eRsRexhSe38za2eys3ewhBe/8OZmd2tcelg1ff+fZkhmnEeqhFfm5r
					cPgGysexhQfhwfcpdx7H]],
				["FootF.L"] = [[
					emg3f2/OhFfxm6emhHfj+weFgiojemhOfI8xVfjKopemhJer+jcbhBoueohCed+5ewfqoMerg8ei+4ene+oKengqer/XdMgHloemgnfC/hd2gWk9emgnfc/m
					gFf/k+epg1fv+IfDewqp]],
				["UpperLegF.R"] = [[
					hGhwfT7bqHe+s9hEhffZ6frlfotshDhXfZyRqhh/3+hDhkfSuAoSgj7ihEh0fOvvlyeP7MhGhwfTq0mVgE9bhIhffclXnMlV+PhJhYfezWrjm11qhJhkfW3b
					qsjUyshIh0fR7tqCflsd]],
				["LowerLegF.R"] = [[
					hPhSe38zlKhOs3hQhBe/8OmaiKtchbg1ff+fmceanEhWhFfm5rjxf6yshPhQfhwfjXiP7HhVhWfw0ViQhV4khchVgA+ml5dzm5hog8fe8Lo8buUjhghDfK/G
					mTd7cmhRhXez9ElBhvsR]],
				["FootF.R"] = [[
					hVg8ei+4hZhCoKhZgqer/Xi0f5lohagnfC/hiKfqk9hagnfc/mf7gBk+hXg1fv+Ig9hQqphag3f2/Oe7gPm6hahHfj+wh7feojhahOfI8xqhc2ophahJer+j
					jle/ouhYhCed+5hQgWoM]],
				Tail1 = [[
					gAi/hbi4gAgA/3gBizhbhRfrgC/9gBiohbhqfegD/8gBishajhfef//ygBi6hbkRfrf+/tgAi/hbi4gAgA/3f/izhbhRgVf+/9f/iohbhqgif9/8f/ishajh
					gigB/yf/i6hbkRgVgC/t]],
				Tail2 = [[
					gAi4iAkcgegB/rgAiwiBhyfegD/8gAikiBhHeqgH/8gAikiAjXeXgA/xgAiwh/laesf7/ggAi4iAkcfif//rgAiwiBhygif9/8gAikiBhHhWf5/8gAikiAjX
					hpgA/xgAiwh/lahUgF/g]],
				Tail3 = [[
					gBitillkhVgH/ef/isinigfwgE/5f9ihimgheQgG/8f8iciliYdbf7/zf9ikijledmfy/bf/itillkerf5/egBisiniggQf8/5gDihimghhwf6/8gEiciliY
					ilgF/zgDikijleiagO/b]],
				Tail4 = [[
					gEigjIlniYgW/Zf+imjMi9gdgL/2f5igjMf7eUgE/8f2iWjKgtc1fv/0f3iXjGkOclfg/hf8igjIlndofq/ZgCimjMi9fjf1/2gHigjMf7hsf8/8gKiWjKgt
					jLgR/0gJiXjGkOjbgg/h]],
				Tail5 = [[
					gKiTjsjhjYg6/mf/ifjxh5hagh/5f1igjyede2gH/7fviVjvd9cvfc/wfviNjqhFb7e8/sf2iTjsjhcofG/mgBifjxh5emff/5gLigjyedhKf5/7gRiVjvd9
					jRgk/wgRiNjqhFkFhE/s]],
				["UpperLegB.L"] = [[
					e2iCg96wX9hOvie2h3g/5bYNg6xwe2htg96CWbezv3e2hzg61AY/f83Fe2iAg6vlbuhU7le2iCg9usbThd7/e2h2g81mVxf21Re2htg449SPecuce2hzg18T
					S5dfmne2iAg37tWUfrst]],
				["LowerLegB.L"] = [[
					ethagj7ZayfpvqerhLgt6Ca1fIx1elhGglute+gK8ZenhFg8tfeffJ89ethXhSv0dFfA7oeshbhXu9ckfJ8DehhLg3geg/ez/8efhMgceEhjc1/venhkgJsG
					eafO9kephfgW45bIgEzf]],
				["FootB.L"] = [[
					eng9gR+odcfqo2ejgrgg/WdOgXltejgqg5/igyf4lRejgqhS/jftgDlRemg5hk9yekfPriekg+hq+teSgGozejhKha+whGfsotejhQg++mgZf4pUejhMgi+u
					fxgEo6ejg+gN/Bd6ggnf]],
				["UpperLegB.R"] = [[
					hKiCg9usktej7/hKh2g81mqPgK1RhKhtg449txhkuchKhzg18TtHihmnhKiAg37tpsgVsthKiCg96woDeyvihKh3g/5bnzfGxwhKhtg96CplhNv3hKhzg61A
					nBgE3FhKiAg6vlkSes7l]],
				["LowerLegB.R"] = [[
					hUhbhXu9jcg38DhfhLg3gefBhN/8hhhMgceEedjL/vhZhkgJsGhmgy9khXhfgW45k4f8zfhThagj7ZlOgXvqhVhLgt6ClLg4x1hbhGgluthCf28ZhZhFg8tf
					hhg389hThXhSv0i7hA7o]],
				["FootB.R"] = [[
					hcg+hq+thuf6ozhdhKha+we6gUothdhQg++mfngIpUhdhMgi+ugPf8o6hdg+gN/BiGfgnfhZg9gR+oikgWo2hdgrgg/Wiyfplthdgqg5/ifOgIlRhdgqhS/j
					gTf9lRhag5hk9yhcgxri]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAi1gx/+gAgAhNgAi0gx/+gDgNhNgAizgx/9gNgxhMgAixgx/7gZhghLgAivgx/4gliOhKgAiugx/2gtithIgAiugx/2gtishIgAizgx/9f5fjhMgAi1gx/y
					fMcqhGgAi1gx/tfCcEhDgAi1gx/tfCcEhDgAi1gx/ufDcFhDgAi1gx/xfKcihFgAi1gx/3fYdehJgAi1gx/8fqemhLgAi1gx/9f5fihMgAi1gx/+gAf/hNgA
					i1gx/+gAgAhNgAi1gx/+gAgAhN]],
				Spine1 = [[
					gAizgY/+gAgAhNgAiygY/9gDgRhNgBixgY/9gMg/hMgCivgY/6gYh9hLgEitgY/1gji4hJgEisgY/xgrjghHgEisgY/xgrjfhHf/ixgY/9f6fchMf7izgY/r
					fObuhEf6izgY/kfFa+hAf6izgY/kfFa+hAf6izgY/kfGa/hBf6izgY/pfMbjhDf8izgY/zfacwhIf+izgY/6freNhLf/izgY/9f5fahMgAizgY/+gAf/hNgA
					izgY/+gAgAhNgAizgY/+gAgAhN]],
				Spine2 = [[
					gAixf+/jgAgAlRgBiwf+/jgAgVlQgDivf+/igChOlQgGitf+/egDiblNgIirf//XgEjklKgKiqf//SgFkVlHgKiqf//SgFkVlHf+ivf+/jgAfTlQf0iygA/J
					f8avlCfyiygA+/f7Zzk9fyiygA+/f7Zzk9fyiygA+/f7Z1k9fziygA/Hf7ahlBf3ixf//Uf8cAlIf7ixf+/ff+dylOf+ixf+/jf/fRlQgAixf+/jgAf/lRgA
					ixf+/jgAgAlRgAixf+/jgAgAlR]],
				Spine3 = [[
					gAipfo/jgAgAlRgBipfo/jgAgZlQgFinfo/hf/hclQgJimfo/bf+i3lNgNikfp/Sf9kNlIgQijfq/Kf9lHlEgQijfq/Lf9lHlEf9iofo/jgBfMlQfsirfq+/
					gGZ0k/fpirfr+xgHYvk4fpirfr+xgHYvk4fpirfr+xgHYwk4frirfr+8gGZkk9fxiqfp/OgEbTlGf4iqfo/dgCdZlNf9ipfo/igBfJlQgAipfo/jgAf+lRgA
					ipfo/jgAgAlRgAipfo/jgAgAlR]],
				Neck1 = [[
					gAiifRAHgAgAiagCihfRAGf7f1iVgHigfSAGfwfWiHgNiefSAGfiesh1gTidfTAIfYeDhlgYicfUAJfSdohbgYicfUAJfSdohbf8igfSAGgLgziKfjijfWAa
					hQkLigffikfXAihek6ijffikfXAihek6ijffikfXAihek5ijfiikfWAchUkVihfqijfUASg9jKief0iifSAKgihwibf8iifSAHgLgliagAiifRAHgAgBiagA
					iifRAHgAgAiagAiifRAHgAgAia]],
				Neck2 = [[
					gAioenBQgAgAo0gCinenBNf9gCoqgIileoBGf2gIoPgRijeoA9fxgNnrgYihepA1fwgRnKgeifeqAwfygTm0geifeqAwfygTm0f6imenBJgVgxoWfZiqetBY
					hkiBo3fSirevBbh2iYo4fSirevBbh2iYo4fSirevBbh1iXo4fXireuBYhoiGo3fiiperBVhMhio2fvipeoBSgqg2o1f7ioeoBQgOgSo0gAioenBQgAgBo0gA
					ioenBQgAgAo0gAioenBQgAgAo0]],
				Neck3 = [[
					gAi7eJBygAgAqfgCi6eJBtgBgPqRgIi3eIBhgHg1pogQi0eIBSgVhmoygYixeJBHgpiSn9gdiueKBBg6iunbgdiueKBBg6iunbf5i4eIBkgYgwpzfVi+ePB0
					hDgJqgfOi/eRB0hPgKqgfOi/eRB0hPgKqgfOi/eRB0hPgKqgfUi+ePB0hGgJqgffi9eMBzgzgHqgfui8eKBygcgEqff6i7eJBygJgBqfgAi7eJBygAgAqfgA
					i7eJBygAgAqfgAi7eJBygAgAqf]],
				Head = [[
					gAjhdY/ygAgAjogBjgdY/wgHfgj3gFjbdW/ngWeKkhgKjUdU/UggcWlYgQjOdT+7gganmKgUjKdT+mgaZdmpgUjLdT+mgaZempf2jcdW/qgpe0kVfWjkdf/v
					g1hDjtfPjldh/vg/hPjvfPjldh/vg/hPjvfPjldh/vg/hOjvfVjkdf/vg4hGjtfgjjdc/wgogzjrfujidZ/xgWgcjpf6jidZ/ygHgJjogAjhdY/ygAgAjogA
					jhdY/ygAgAjogAjhdY/ygAgAjo]],
				Jaw = [[
					gAihdf/8gAgAh1gCifdf/6gFfgiPgHibdg/wgSeJjVgNiVdi/agccWkygTiQdk+7gfanmHgXiNdm+hgfZem+gXiNdm+hgfZem9f5icdf/qgpe0kYfaikdl/X
					gwhHmJfTildo/Mg3hVm6fTildo/Mg3hVm6fTildo/Mg3hUm5fYikdm/VgyhKmUfjijdj/kgmg1lFfwiidg/xgWgcjof7ihdf/5gIgJibgAihdf/8gAgAh2gA
					ihdf/8gAgAh1gAihdf/8gAgAh1]],
				["UpperLegF.L"] = [[
					e6hofRzyXbgA3oe8hofQzIXCfy4BfChlfLxlV/fQ4xfKhjfGwGUmey5JfShgfBv4TFe44jfYhfe+waR6fX3jfYhfe+waR6fX3je2hnfV0SYOgD3fefhufw72
					efiPvhechvf28QfpiMu1echvf28QfpiMu1echvf28QfoiNu2eehufx78ewiOvXelhsfo7Gc2iKwlethqfe32aNhL0ee2hpfV06YSgU29e6hofSz0XdgB3ne6
					hofRzyXbgA3oe6hofRzyXbgA3o]],
				["LowerLegF.L"] = [[
					ephCfV7ocDgAvoeqhCfV7gbif7vueshCfU60aCfjwYexhDfQ5GX+ekyFe3hCfJ17WHcy01e8hAfCyxVJbG3Ae8hAfCyxVJbG3AenhAfY8pdNgnt+eihKfa71
					iUgIvneghNff8GjZgQu6eghNff8GjZgQu6eghNff8GjXgQu7eihLfb75ikgKvcelhHfV7TgxfywpemhCfW8IfHgUvNeohCfX8HdMgUu/ephCfV7pcGgBvnep
					hCfV7ocDgAvoephCfV7ocDgAvo]],
				["FootF.L"] = [[
					emgnfF/mgAgAk+emgnfF/mfegFk+emgnfF/id6gVk9emgnfF/Sbkgtk7emgnfF+0Y/hHk2engpfF+OXChIlWengpfF+OXDhIlWemgnfF/khSfzk+elgvfK+o
					mGe4m3ekgzfN+QnLewnaekgzfN+QnLewnaekgzfN+RnKewnaelgwfK+imWe2nAelgrfH/GkhfKl7emgnfF/djCfhk9emgnfF/lhMf0k+emgnfF/mgCgAk+em
					gnfF/mgAgAk+emgnfF/mgAgAk+]],
				["UpperLegF.R"] = [[
					hGhofRzyolgA3ohIhofT0FoNf93hhNhnfY1HnKfv28hUhnff25lufS1mhZhmfl47kPeuzjhdhmfq6pjEeOxWhdhmfq6ojFeOxXhChmfOyTpagi4fghhme7vs
					udf932gZhme5ukvMf64GgZhme5ukvMf64Ggahme5ulvLf64Fgfhme7vbuof936grhmfAxWtUf53Wg4hnfHySrRgL3thChofOy4pbgP4ChGhofRzwomgB3phG
					hofRzyolgA3ohGhofRzyolgA3o]],
				["LowerLegF.R"] = [[
					hXhCfV7oj9gAvohYhBfX8Ejafvu9hahAfZ88h/fNtehdg+fb9hgSeysSheg+fb9ge+eusPhdg/fZ8/eafItahdg/fZ8/eafItZhVhCfV7blEgHvqg9hIfAyE
					rckK3bg3hKe+xFsYkI3sg3hKe+xFsYkI3sg3hKe+xHsXkJ3rg8hIfAx1rqkK3fhEhFfCzgqCkA28hOhEfL3knriQ0HhUhDfT61lJgewphXhCfV7nj/gBvqhX
					hCfV7oj9gAvohXhCfV7oj9gAvo]],
				["FootF.R"] = [[
					hagnfF/mgAgAk+hagnfF/mfZgGk+hagnfF/id4gVk9hagnfF/XcHgnk8hagnfF/La2g0k6hagnfF/Gabg4k5hagnfF/Gabg4k5hagnfF/lhIf1k+hSgwfD9M
					p1gVophOg0fC8MrKg8qIhOg0fC8MrKg8qIhOg0fC8OrJg7qGhRgxfD8/qIgdo+hXgsfE+Rn4fnmthagnfF/SkZfUk7hagnfF/khTfzk+hagnfF/mgCgAk+ha
					gnfF/mgAgAk+hagnfF/mgAgAk+]],
				Tail1 = [[
					gAiuhaicgAgA/5f/iuhaicfsgF/5f+ishaide0gU/4f8iqhaiedrgo/zf7iohaigcjg7/sf5inhaihb0hI/mf5inhaihb0hH/mgBithaidgXf3/5gIiuhai8
					k/eo/bgKiuhZjjm/eK+9gKiuhZjtnWeG+2gKiuhZjtnVeG+3gIiuhajrm0eR+/gGiuhajkljes/RgDiuhajRjpfP/mgBiuhai7hsfu/0gAiuhaingbf+/4gA
					iuhaidgBgA/5gAiuhaicgAgA/5]],
				Tail2 = [[
					gAipiAh2gAgA/8f/ioiAh2fhgG/7f7iniAh2eOgV/4f3ikh/h4cegp/vfziih/h7azg9/ffwihh+h9ZshK/Rfwihh+h9ZshK/SgCiniAh3gRf3/7gTinh9ix
					nVei++gZilh7j8rKd59pgaikh6kQr/dx9Rgaikh6kQr9dx9RgYilh7kNrVd99jgTilh9kBppeZ+MgMimh/jfmqfD/FgFioiAiyjXfo/sgBioiAiLg+f8/5gA
					ipiAh3gDgA/8gAipiAh2gAgA/8]],
				Tail3 = [[
					gAikimgzgAgA/+f+ikimgzfUgF/+f3iiilg0ddgS/4fvigikg2a/gk/lfnidijg7Yog1/Gfhibihg/XEg/+rfhibihg/XEg/+sgDijimg0gJf4/+gkififiN
					qOer+NgxiaiWj8wGeE7SgziZiUkZxZd86ZgziZiUkZxYd86agwiaiWkVwpeG66goibibkDuheg8LgbieigjQqYfH+EgNihikiOldfr/cgDijimhThpf9/7gA
					ikimg0gFgA/+gAikimgzgAgA/+]],
				Tail4 = [[
					gAiijMfEgAgA/+f8iijMfEfEgC/9fxigjLfGcjgI/yfjiejIfMZNgP/QfWibjEfUWDgW+ZfNiZjBfcT/gZ9pfNiZjBfcUAgZ9pgDihjMfGgAf4/+g7iZi8hF
					tlfV88hRiQioji1ZfJ3ghViOiikJ3CfI1zhViOiikJ3AfI10hQiPimkC2PfP2ohGiRiwjnz2fe40gyiWi+ieuofz8WgaicjIhAn6gC++gHigjLfwidgE/5gA
					iijMfGgIgA/+gAiijMfEgAgA/+]],
				Tail5 = [[
					gAiljyb2gAgA/uf6ikjyb2eyf6/sfpiijwb7bhfp/afTifjrcIXOfS+ge/icjjcdTOe89GeziZjccvQret72eziZjccvQset73gDijjyb5f1f3/uhYiXjVe3
					xLhO68h2iIiriq6OiNx/h6iGigjl70icvMh6iGigjl7zicvOh2iHimjX7JicwbhqiKi4ij43iWz1hRiRjTgszDh85ngsiZjpecqphN+GgNihjxctjYgc/ogB
					ikjyb5gLgB/ugAiljyb2gAgA/u]],
				["UpperLegB.L"] = [[
					e2h1g34BXxgAzce2h0g34BXjgGzXe3hyg037XCgYzPe4hvgx3rWag0zPe5hsgt3UV5hTzZe5hqgr3AVlhpzke5hqgr3AVlhpzke2h0g64jXwffyxe1h5hH43
					ageLzRe2h6hJ4nbbeSz1e2h6hJ4nbbeSz1e2h6hJ4obZeRz0e1h6hH42areKzWe1h4hD43ZoebzCe1h3g+4nYsfCzDe2h2g64QYDfrzSe2h1g44CXxf/zce2
					h1g34BXxgAzce2h1g34BXxgAzc]],
				["LowerLegB.L"] = [[
					enhJgrwSd+gA7denhIgpvud6gF7yenhGgmuOdvgQ8keohDgjsUdagY9aephAggqjdCga+Depg+gfpacwgZ+Zepg+gfpacwgZ+ZemhIgqwLeif67kenhNg52B
					fbeC3HephMg+3hfJdJ1fephMg+3hfJdJ1fephMg+3efKdL1ienhNg62Tfad420emhMg10cfTew4kemhLgwyfe0fb6EemhJgsw/eRf17DenhJgrwTd+gA7cen
					hJgrwSd+gA7denhJgrwSd+gA7d]],
				["FootB.L"] = [[
					ejgqg7/jgAgAlRejgqg7/jf/gAlRejgqg7/jf5gBlRejgqg7/jfogElRejgqg7/ifRgIlRejgqg7/ie+gLlRejgqg7/ie+gLlRejgqg7/jgXf8lRejgqg7/j
					gGf/lRejgqg7/jfWgHlRejgqg7/jfWgHlRejgqg7/jfYgHlRejgqg7/jf/gAlRejgqg7/jgaf8lRejgqg7/jgYf8lRejgqg7/jgKf+lRejgqg7/jgAgAlRej
					gqg7/jgAgAlRejgqg7/jgAgAlR]],
				["UpperLegB.R"] = [[
					hKh1g34BoPgAzchKh1g44PoNgNzNhKh0g74voHgwykhLhzg+5Wn9hfxwhLhyhC52nziMxBhLhxhE6JnriqwihLhxhE6JnriqwjhKhzg14Dovf1zMhGhxgo1c
					p1db1dhFhwgl0yqCc818hFhwgl0yqCc818hFhwgl0zqCc917hGhxgn1Tp4dU1khHhygs2OpgeD03hJhzgx3JpAe80IhKh1g13xogfqzphKh1g34BoQf/zdhK
					h1g34BoPgAzchKh1g34BoPgAzc]],
				["LowerLegB.R"] = [[
					hZhJgrwSiCgA7dhahJgrwVh0gD7chbhJgrwhhOgK7XhchJgsw3gdgT7LhdhKgtxTfxga65hehKguxpfUgf6rhehKguxpfVgf6rhZhHgou3iGf08QhVhDgksK
					kpfB9NhUhCgjrqlLe19UhUhCgjrqlLe19UhUhCgjrqlLe19UhUhCgksCkwe/9PhWhEgls+j9fQ89hYhGgnuVjEfl8chZhIgpvniXf270hZhIgrwRiDgA7ehZ
					hJgrwSiCgA7dhZhJgrwSiCgA7d]],
				["FootB.R"] = [[
					hdgqg7/jgAgAlRhdgqg7/jf3gClRhdgqg7/jfegGlRhdgqg7/ie+gLlRhdgqg7/heggQlRhdgqg7/geNgTlRhdgqg7/geNgTlRhdgqg7/jf/gAlRhdgqg7/h
					hkfvlRhdgqg7/fh4fslRhdgqg7/fh4fslRhdgqg7/fh4fslRhdgqg7/ghofvlRhdgqg7/ihJf0lRhdgqg7/jgmf6lRhdgqg7/jgLf+lRhdgqg7/jgAgAlRhd
					gqg7/jgAgAlRhdgqg7/jgAgAlR]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAi1gx/+gAgAhNgAizgz/9gAgAhYgAivg5/8gAgAhzgAisg//6gAgAiMgAirhA/6gAgAiTgAivg6/8gAgAh2gAi1gw//gAgAgkgAi4gs//gAgAfggAi5gr/+
					gAgAfQgAi5gr/+gAgAfQgAi5gr/+gAgAfQgAi5gr/+gAgAfQgAi5gr/+gAgAfQgAi5gr/+gAgAfQgAi5gr/+gAgAfQgAi5gr/+gAgAfQgAi5gr/+gAgAfQgA
					i5gr/+gAgAfQgAi5gr/+gAgAfQgAi4gr//gAgAffgAi3gu//gAgAgTgAi1gx/+gAgAhDgAi1gx/+gAgAhNgAi1gx/+gAgAhNgAi1gx/+gAgAhN]],
				Spine1 = [[
					gAizgY/+gAgAhNgAixga/9gAgAhegAitgg/7gAgAiGgAiogl/4gAgAirgAingn/3gAgAi3gAisgh/6gAgAiKgAi1gW//gAgAgagAi5gS/+gAgAfBgAi6gR/9
					gAgAesgAi6gR/9gAgAesgAi6gR/9gAgAesgAi6gR/9gAgAesgAi6gR/9gAgAesgAi6gR/9gAgAesgAi6gR/9gAgAesgAi6gR/9gAgAesgAi6gR/9gAgAesgA
					i6gR/9gAgAesgAi6gR/9gAgAesgAi5gS/+gAgAe/gAi2gV//gAgAgCgAizgX/+gAgAhAgAizgY/+gAgAhNgAizgY/+gAgAhNgAizgY/+gAgAhN]],
				Spine2 = [[
					gAixf+/jgAgAlRgAivgB/fgAgAlngAipgG/VgAgAmbgAikgM/KgAgAnNgAijgO/HgAgAnbgAiogH/UgAgAmigAi0f9/sgAgAkUgAi7f4/4gAgAingAi8f4/6
					gAgAiNgAi8f4/6gAgAiNgAi8f4/6gAgAiNgAi8f4/6gAgAiNgAi8f4/6gAgAiNgAi8f4/6gAgAiNgAi8f4/6gAgAiNgAi8f4/6gAgAiNgAi8f4/6gAgAiNgA
					i8f4/6gAgAiNgAi8f4/6gAgAiNgAi7f4/4gAgAilgAi2f7/wgAgAj3gAiyf+/mgAgAlCgAixf+/jgAgAlRgAixf+/jgAgAlRgAixf+/jgAgAlR]],
				Spine3 = [[
					gAipfo/jgAgAlRgAinfq/egAgAlsgAigfx/RgAgAmugAiaf3/DgAgAnsgAiYf5+/gAgAn+gAiffy/QgAgAm2gAiufm/ugAgAkJgAi3fh/6gAgAiIgAi5fg/8
					gAgAhqgAi5fg/8gAgAhqgAi5fg/8gAgAhqgAi5fg/8gAgAhqgAi5fg/8gAgAhqgAi5fg/8gAgAhqgAi5fg/8gAgAhqgAi5fg/8gAgAhqgAi5fg/8gAgAhqgA
					i5fg/8gAgAhqgAi5fg/8gAgAhqgAi3fh/7gAgAiGgAiwfk/ygAgAjmgAirfn/mgAgAk/gAipfo/jgAgAlRgAipfo/jgAgAlRgAipfo/jgAgAlR]],
				Neck1 = [[
					gAiifRAHgAgAiagAiefUAFgAgAh7gAiWfbACgAgAgxgAiPfiABgAgAfsgAiNfkABgAgAfXgAiVfcABgAgAgqgAiofPAWgAgAkigAi0fKBAgAgAn6gAi2fJBO
					gAgAougAi2fJBOgAgAougAi2fJBOgAgAougAi2fJBOgAgAougAi2fJBOgAgAougAi2fJBOgAgAougAi2fJBOgAgAougAi2fJBOgAgAougAi2fJBOgAgAougA
					i2fJBOgAgAougAi2fJBOgAgAougAi0fKBBgAgAn+gAirfNAegAgAlWgAijfRAJgAgAi5gAiifRAHgAgAiagAiifRAHgAgAiagAiifRAHgAgAia]],
				Neck2 = [[
					gAioenBQgAgAo0gAijeqBHgAgAoUgAiYexA0gAgAnGgAiOe4AkgAgAl7gAiLe6AggAgAllgAiXeyAzgAgAnAgAizemCRgAgArzgAjIekEZgAgAwKgAjNelFC
					gAgAxMgAjNelFCgAgAxMgAjNelFCgAgAxMgAjNelFCgAgAxMgAjNelFCgAgAxMgAjNelFCgAgAxMgAjNelFCgAgAxMgAjNelFCgAgAxMgAjNelFCgAgAxMgA
					jNelFCgAgAxMgAjNelFCgAgAxMgAjIekEcgAgAwPgAi5elCtgAgAs1gAirenBdgAgApggAioenBQgAgAo0gAioenBQgAgAo0gAioenBQgAgAo0]],
				Neck3 = [[
					gAi7eJBygAgAqfgAi2eLBmgAgAp9gAioeQBNgAgAopgAibeWA5gAgAnagAiXeYAzgAgAnCgAimeRBMgAgAokgAjMeMDagAgAuUgAjneTGvgAgAzngAjteVHv
					gAgA01gAjteVHvgAgA01gAjteVHvgAgA01gAjteVHvgAgA01gAjteVHvgAgA01gAjteVHvgAgA01gAjteVHvgAgA01gAjteVHvgAgA01gAjteVHvgAgA01gA
					jteVHvgAgA01gAjteVHvgAgA01gAjoeTG0gAgAztgAjUeMEDgAgAvjgAi/eJCGgAgArXgAi7eJBygAgAqfgAi7eJBygAgAqfgAi7eJBygAgAqf]],
				Head = [[
					gAjhdY/ygAgAjogAjadZ/sgAgAkUgAjIdc/bgAgAl+gAi3df/GgAgAnhgAiydg++gAgAn+gAjGdc/agAgBmDgAj+dn/7gAgAeGgAkjeE+kgbfSWlgAkqeM9X
					fbgyTXgAkqeM9qgAgAUBgAkqeM96gifNUtgAkqeM9XfbgyTXgAkqeM9qgAgAUBgAkqeM96gifNUtgAkqeM9XfbgyTXgAkqeM9qgAgAUBgAkqeM96gifNUtgA
					kqeM9XfbgyTXgAkqeM9qgAgAUBgAkkeE+hgcfRWcgAkIds/uf2gbb8gAjodb/5gAgAiagAjhdY/ygAgAjogAjhdY/ygAgAjogAjhdY/ygAgAjo]],
				Jaw = [[
					gAihdf/8gAgAh1gAiadi/4gAgAitgAiJdr/ogAgAkygAh6d1/RgAgAmugAh2d4/JgAgAnTgAiIdt/lgAgBlDgAi/dX//gAgAgGgAjzdZ/3gkfYdYgAkEdY/n
					fQgnbRgAkCda/vgAgAb/gAkAdb/zgufXctgAkEdY/nfQgnbRgAkCda/vgAgAb/gAkAdb/zgufXctgAkEdY/nfQgnbRgAkCda/vgAgAb/gAkAdb/zgufXctgA
					kEdY/nfQgnbRgAkCda/vgAgAb/gAj0dZ/3glfYdUgAjMdU/9f0gaeygAiodc/9gAgAhYgAihdf/8gAgAh1gAihdf/8gAgAh1gAihdf/8gAgAh1]],
				["UpperLegF.L"] = [[
					e6hofRzyXbgA3oe6hlfWzuXEfp3ie6hdfh0qWHfC2Ue6hWfr2RVGer0Ke6hUfu20UxenzWe6hcfi03V+e92De6hufLz6X3gH3re6h7e/1bZFhE2te6h+e81O
					ZThC29e6h+e81OZThC29e6h+e81OZThC29e6h+e81OZThC29e6h+e81OZThC29e6h+e81OZThC29e6h+e81OZThC29e6h+e81OZThC29e6h+e81OZThC29e6
					h+e81OZThC29e6h+e81OZThC29e6h8e+1ZZDg92ve6hyfHtOYNcj73e6hqfQvBXedC6we6hofRzuXbf+3re6hofRzyXbgA3oe6hofRzyXbgA3o]],
				["LowerLegF.L"] = [[
					ephCfV7ocDgAvoeog/fZ8xbyggtVemg4fg+Ta1hIoyemgzfi+4Z4hHlmemgxfj+8ZohAk6emg3fg+carhKoNeqhIfP6lcYfdxaevhTe/2Scfdl2jevhWe92D
					cpdj2zevhWe92Dcpdj2zevhWe92Dcpdj2zevhWe92Dcpdj2zevhWe92Dcpdj2zevhWe92Dcpdj2zevhWe92Dcpdj2zevhWe92Dcpdj2zevhWe92Dcpdj2zev
					hWe92Dcpdj2zevhWe92Dcpdj2zevhTe/2Qccde2kekhWfe+ubyhonpekhLfh+6bQiAmcephCfV7scEgCviephCfV7ocDgAvoephCfV7ocDgAvo]],
				["FootF.L"] = [[
					emgnfF/mgAgAk+emgnfF/mf4gBk+emgnfF/lfFgJk+emgnfF/ieCgUk9emgnfF/hdtgXk9emgofF/le7gLk+emgrfC/mgJf/k+eng0e//Vfjfrmaeng3e+/N
					fsffm/eng3e+/Nfsffm/eng3e+/Nfsffm/eng3e+/Nfsffm/eng3e+/Nfsffm/eng3e+/Nfsffm/eng3e+/Nfsffm/eng3e+/Nfsffm/eng3e+/Nfsffm/en
					g3e+/Nfsffm/eng3e+/Nfsffm/emg1e//cfff2l1emhHfC/mgIf/k+emg+fE/mfpgEk+emgofF/mgBgAk+emgnfF/mgAgAk+emgnfF/mgAgAk+]],
				["UpperLegF.R"] = [[
					hGhofRzyolgA3ohGhlfWzuo8gX3ihGhdfh0qp5g+2UhGhWfr2Rq6hV0KhGhUfu20rPhZzWhGhcfi03qChD2DhGhufLz6oJf53rhGh7e/1bm7e82thGh+e81O
					mte+29hGh+e81Omte+29hGh+e81Omte+29hGh+e81Omte+29hGh+e81Omte+29hGh+e81Omte+29hGh+e81Omte+29hGh+e81Omte+29hGh+e81Omte+29hG
					h+e81Omte+29hGh+e81Omte+29hGh8e+1Zm8fA2vhGhyfHvLn7iC68hGhqfQwXojh16DhGhofRzwolgB3qhGhofRzyolgA3ohGhofRzyolgA3o]],
				["LowerLegF.R"] = [[
					hXhCfV7oj9gAvohYg/fZ8xkOfgtVhag4fg+TlLe4oyhagzfi+4mIe5lmhagxfj+8mYfAk6hag3fg+clVe2oNhWhIfP6ljogjxahRhTe/2Sjhib2jhRhWe92D
					jXid2zhRhWe92DjXid2zhRhWe92DjXid2zhRhWe92DjXid2zhRhWe92DjXid2zhRhWe92DjXid2zhRhWe92DjXid2zhRhWe92DjXid2zhRhWe92DjXid2zhR
					hWe92DjXid2zhRhWe92DjXid2zhRhTe/2Rjiif2khahSfZ9ljVe6rrhbhIfe+GkCehp9hXhCfV7qj8f/vkhXhCfV7oj9gAvohXhCfV7oj9gAvo]],
				["FootF.R"] = [[
					hagnfF/mgAgAk+hagnfF/mgIf/k+hagnfF/lg7f3k+hagnfF/ih+fsk9hagnfF/hiTfpk9hagofF/lhFf1k+hagrfC/mf3gBk+hZg0e//VgdgVmahZg3e+/N
					gUghm/hZg3e+/NgUghm/hZg3e+/NgUghm/hZg3e+/NgUghm/hZg3e+/NgUghm/hZg3e+/NgUghm/hZg3e+/NgUghm/hZg3e+/NgUghm/hZg3e+/NgUghm/hZ
					g3e+/NgUghm/hZg3e+/NgUghm/hag1e//ZgfgPmFhag8fC/lfGgJk+hag1fE/mftgDk+hagnfF/mf/gAk+hagnfF/mgAgAk+hagnfF/mgAgAk+]],
				Tail1 = [[
					gAiuhaicgAgA/5gAithdiIgAgA/6gAirhjhagAgA/9gAiohogtgAgA/+gAinhqgggAgA//gAiqhkhVgAgA/9gAithZjofmgB/ygAithUlkgQgA/ggAithTmC
					g+gC/ZgAithTmCfOf+/agAithTmCfcf//agAithTmChFgD/ZgAithTmCgAgA/agAithTmCe7f9/ZgAithTmCgkgB/agAithTmCgygC/agAithTmCfCf+/ZgA
					ithTmCfuf//agAithTmChHgD/ZgAithUlmfwgA/fgAiuhXkHfjgB/ugAiuhaiugEgA/4gAiuhaicgAgA/5gAiuhaicgAgA/5gAiuhaicgAgA/5]],
				Tail2 = [[
					gAipiAh2gAgA/8gAioiDhZgAgA/9gAiniJgWgAgA//gAimiOfXgAgA//gAimiQfFgAgA/+gAiniKgPgBgA//f/ilh+jlfQgB/ygBigh4maf6f+/WgCifh2nF
					iEgI/If+ifh2nFfCf//Lf/ifh2nFebf5/KgDifh2nFhygF/JgAifh2nFgqgF/Mf9ifh2nEd5f5/IgBifh2nFgcf//MgCifh2nFh5gI/Jf+ifh2nFelf9/Kf/
					ifh2nFe2f6/LgDifh2nFiBgH/If/igh4mdgGgC/Vf/ikh8kSfDgA/sgAioh/iQgFgA/6gAipiAh2gAgA/8gAipiAh2gAgA/8gAipiAh2gAgA/8]],
				Tail3 = [[
					gAikimgzgAgA/+gAilipgOgAgA//gAimive3gAgA/+gAioi0dlgAgA/5gAioi2dNgAgA/3gAimiweugCgA/9f9icijjFfIgA/1gAiRibmzfHf2/PgHiPiYnr
					i5gP+7f8iPiZnsfigG/Df7iPiYnrdXft+8gHiPiYnsh1gE/AgCiPiZnshsgR/Af5iPiYnrdTf0+8gCiPiZnsftf2/DgGiPiYnri3gS+7f6iPiYnse0gB/Cf9
					iPiZnrdwfu++gHiPiYnriXgI+9gAiRibm3g6gL/Of9iaihkAeqf+/tgAijilhVgCgA/9gAikimgzgAgA/+gAikimgzgAgA/+gAikimgzgAgA/+]],
				Tail4 = [[
					gAiijMfEgAgA/+gAikjPeXgAgA/8gAipjVcsgAgA/0gAiujabIgAgA/ngAivjbargAgA/igAipjVchgCgA/zf7iVjIh7fQf//7f+iCi9mieLfl/QgOh9i5no
					jHgU+6f7h9i6npgfgZ/Df1h9i6nocpff+4gLh9i6nohQf4/CgGh9i6noitgl+8fyh9i5nodWf1+9gCh9i6noerfh/CgNh9i5nojWgb+4f4h9i6npfmgR/Ef3
					h9i6noc3fc+6gNh9i5noiBgC/AgCiBi9mnh2gc/Pf6iRjFjEejf6/zgAifjLfvf9gA//gAiijMfEgAgA/+gAiijMfEgAgA/+gAiijMfEgAgA/+]],
				Tail5 = [[
					gAiljyb2gAgA/ugAioj0bBgAgA/mgAixj6ZEgAgA/OgAi5j+XQgAgA+xgAi7j/WugAgA+ngAiyj7Y3gDgA/Lf5iRjufPflgA/+f6hzjgkydgfL/hgVhsjamH
					irgR/Sf8hrjcmGhdg5/WfthsjamHclfR/NgOhsjbmGgVff/ZgMhsjbmHjRhA/NfshsjamGd/gA/Vf+hsjcmGdyfA/TgVhsjamHjKgh/Pf3hsjcmGgmgv/Zfw
					hsjbmHcifH/MgRhsjbmGhNfv/YgGhyjfk4ihg2/gf2iKjqgnexf3/9gAigjxcof4f//0gAiljyb2gAgA/ugAiljyb2gAgA/ugAiljyb2gAgA/u]],
				["UpperLegB.L"] = [[
					e2h1g34BXxgAzce2h0g74qXXf0yde2hwhC55WkfbwOe2hthJ6zV8fGuPe2hshL7CVyfAtre2hvhD6DWdfXv6e2h2g03eYHgB0Pe2h4gr1SZcga29e2h5gp0j
					Z3gi3ue2h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2
					h5gp0jZ3gi3ue2h5gp0jZ3gi3ue2h4gr1PZegb3Be2h3gx2zYigL1Je2h1g232X4gBzte2h1g34BXxgAzce2h1g34BXxgAzce2h1g34BXxgAzc]],
				["LowerLegB.L"] = [[
					enhJgrwSd+gA7demhIgqwFeFgJ7lemhIgqwIeJgZ7kemhJgswqd+gk7PemhJgsw5d5gn7FemhIgqwKeJgb7ienhIgqwAeDf07oephJgtxEddfQ67ephKguxr
					dKfF6gephKguxrdKfF6gephKguxrdKfF6gephKguxrdKfF6gephKguxrdKfF6gephKguxrdKfF6gephKguxrdKfF6gephKguxrdKfF6gephKguxrdKfF6gep
					hKguxrdKfF6gephKguxrdKfF6gephJgtxGdbfP66enhIgrwTd3fp7cenhIgrwQd+f97fenhJgrwSd+gA7denhJgrwSd+gA7denhJgrwSd+gA7d]],
				["FootB.L"] = [[
					ejgqg7/jgAgAlRejgqg7/jgLf+lRejgqg7/jgYf8lRejgqg7/jgZf8lRejgqg7/jgXf8lRejgqg7/jgZf8lRejgqg7/jf7gBlRejgqg7/ifLgJlRejgqg7/i
					e3gMlRejgqg7/ie3gMlRejgqg7/ie3gMlRejgqg7/ie3gMlRejgqg7/ie3gMlRejgqg7/ie3gMlRejgqg7/ie3gMlRejgqg7/ie3gMlRejgqg7/ie3gMlRej
					gqg7/ie3gMlRejgqg7/ie3gMlRejgqg7/ifKgJlRejgqg7/jftgDlRejgqg7/jf+gAlRejgqg7/jgAgAlRejgqg7/jgAgAlRejgqg7/jgAgAlR]],
				["UpperLegB.R"] = [[
					hKh1g34BoPgAzchKh0g74qopgMydhKhwhC55pcglwOhKhthJ6zqEg6uPhKhshL7CqOhAtrhKhvhD6Dpjgpv6hKh2g03en5f/0PhKh4gr1Smkfm29hKh5gp0j
					mJfe3uhKh5gp0jmJfe3uhKh5gp0jmJfe3uhKh5gp0jmJfe3uhKh5gp0jmJfe3uhKh5gp0jmJfe3uhKh5gp0jmJfe3uhKh5gp0jmJfe3uhKh5gp0jmJfe3uhK
					h5gp0jmJfe3uhKh5gp0jmJfe3uhKh4gr1Pmifl3BhKh3gx2znef11JhKh1g232oIf/zthKh1g34BoPgAzchKh1g34BoPgAzchKh1g34BoPgAzc]],
				["LowerLegB.R"] = [[
					hZhJgrwSiCgA7dhahIgqwFh7f37lhahIgqwIh3fn7khahJgswqiCfc7PhahJgsw5iHfZ7FhahIgqwKh3fl7ihZhIgqwAh9gM7ohXhJgtxEijgw67hXhKguxr
					i2g76ghXhKguxri2g76ghXhKguxri2g76ghXhKguxri2g76ghXhKguxri2g76ghXhKguxri2g76ghXhKguxri2g76ghXhKguxri2g76ghXhKguxri2g76ghX
					hKguxri2g76ghXhKguxri2g76ghXhJgtxGilgx66hZhIgrwTiJgX7chZhIgrwQiCgD7fhZhJgrwSiCgA7dhZhJgrwSiCgA7dhZhJgrwSiCgA7d]],
				["FootB.R"] = [[
					hdgqg7/jgAgAlRhdgqg7/jf1gClRhdgqg7/jfogElRhdgqg7/jfngElRhdgqg7/jfpgElRhdgqg7/jfngElRhdgqg7/jgFf/lRhdgqg7/ig1f3lRhdgqg7/i
					hJf0lRhdgqg7/ihJf0lRhdgqg7/ihJf0lRhdgqg7/ihJf0lRhdgqg7/ihJf0lRhdgqg7/ihJf0lRhdgqg7/ihJf0lRhdgqg7/ihJf0lRhdgqg7/ihJf0lRhd
					gqg7/ihJf0lRhdgqg7/ihJf0lRhdgqg7/ig2f3lRhdgqg7/jgTf9lRhdgqg7/jgCgAlRhdgqg7/jgAgAlRhdgqg7/jgAgAlRhdgqg7/jgAgAlR]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAi1gx/+gAgAhNgAi8gx/9gDfjengAi1gx/6gJe9eIgAjTgx/1gLe9dBgAjugx/xgIfXcYgAj3gx/wgAgAcMgAjugx/xf4gpcYgAjTgx/1f1hDdBgAi1gx/6
					f3hDeJgAi6gx/6f6gqdzgAi4gx/7gAgAd5gAjggx/zgHfXcrgAj0gx/wgNe9cQgAj2gx/vgNe9cOgAjlgx/zgIfXckgAjCgx/5gAgAdkgAi4gx/6f6gqd5gA
					jBgx/3f1hDdUgAi+gx/7f5gzeRgAi4gx//f/gKgOgAi1gx/+gAgAhN]],
				Spine1 = [[
					gAizgY/+gAgAhNf/i+gY/9gDfjerf+i4gY/8gKe9esf+jYgY/0gLe9c5f/jzgY/ugHfXb7gAj9gY/sgAgAbogBjzgY/uf5gpb7gCjYgY/0f1hDc5gCi4gY/8
					f2hDesgBi9gY/7f6gpeJgAi8gY/8gAgAeTf/jlgY/xgHfXcYf+j6gY/sgMe9bvf+j8gY/rgMe9brf/jqgY/wgHfXcNgAjGgY/6gAgAdxgBi8gY/8f6gqeTgC
					jGgY/3f1hDdUgBjBgY/7f5gzeRgAi4gY//f/gKgOgAizgY/+gAgAhN]],
				Spine2 = [[
					gAixf+/jgAgAlRf/jAf+/3gHfki1f9i6f+/zgUe/jVf9jdf//9gTe/g2f+j6f//+gMfYfigAkEgA/+gAgAfJgCj6f//+f0gofigDjdf//9fthBg2gDi6f+/z
					fshBjVgCjAf+/4f0goikgAi+f+/3gAgAiyf+jrf///gMfYgJf9kAgA/9gTe/fSf9kCgA/9gTe/fNf+jxf///gMfYf6gAjJf+/7gAgAiDgCi+f+/3f0goiygD
					jKf//8fthBhagDjEf+/5fzgxiWgBi3f+/sf+gKkTgAixf+/jgAgAlR]],
				Spine3 = [[
					gAipfo/jgAgAlRf+i8fn/2gHfki6f7i1fn/vgVe/j4f7jbfn/9gTe/gtf9j7fo/+gLfYfFgAkFfo/9gAgAelgDj7fo/+f1gofFgFjbfn/9fthBgtgFi1fn/v
					frhBj5gDi9fn/2fzgoi6gAi6fn/1gAgAjMf9jrfo//gMfYf1f7kBfo/8gSe/exf7kEfo/8gSe/erf9jxfo/+gLfYfigAjGfn/6gAgAiPgDi6fn/0fzgojMgF
					jIfn/8fthBhbgEjAfn/5fzgxiWgBixfn/sf+gKkTgAipfo/jgAgAlR]],
				Neck1 = [[
					gAiifRAHgAgAiaf9i4fQAOf/gdjnf6ivfQAHf3hDiIf6jafQAif6hElqf8j8fQA/f+gqnxgAkHfRBKgAgAocgEj8fQA/gCfWnxgGjafQAigGe8lqgGivfQAH
					gJe9iHgEi4fQALgFfWjGgAi2fQAJgAgAi1f8jrfQAwf9gqmxf6kDfRBGf9hEoMf6kFfRBJf9hEoVf8jxfQA1f9gqnKgAjDfQAQgAgAj5gEi2fQAJgFfWi1gG
					jGfQAXgHe8klgFi9fQASgDfNkEgBirfQAKgAf2i9gAiifRAHgAgAia]],
				Neck2 = [[
					gAioenBQgAgAo0f8jBemBSgDgdo4f3i1emAzgChEm7f3jpeoB5gFhEqvf6kQerC4gFgqtOgAkdesDQgAgAuBgGkQerC4f7fWtOgJjpeoB5f7e8qvgJi1emAy
					f+e8m6gGjAemBAf+fWn4gAi9emA8gAgAnnf6j8epCXgEgqsAf3kYesDIgJhDtuf3kbesDNgJhDt5f6kEeqCjgFgqsegAjNemBQgAgAoygGi9emA8f/fWnngJ
					jSenBbf8e8pTgHjIenBYf6fNpOgBizenBTf+f2o9gAioenBQgAgAo0]],
				Neck3 = [[
					gAi7eJBygAgAqff7jVeIBdgEgdpcf1jEeGA0gChEnAf1kAeMCDgGhErLf5kreTDUgHgpuHgAk6eWDzgAgAvGgHkreTDUf5fXuHgLkAeMCDf6e8rLgLjEeGA0
					f+e8m/gHjSeHBCf+fWn9gAjOeGA9gAgAnsf5kVePCogFgqsqf1k0eVDogLhDuuf1k3eWDvgMhDu7f5keeRC4gGgqtOgAjgeIBTgAgAo/gHjOeGA9f+fWnsgL
					jmeJBcf8e8pYgJjceJBif6fNpsgCjGeIBsf9f2qOgAi7eJBygAgAqf]],
				Head = [[
					gAjhdY/ygAgAjof6j4dV/xhQfsjjfxjfdO/XjCfKlcfxkode/1i7ffhIf3lcdu/4hvf1d/gAltd0/2gAgAc8gJlcdu/4eRgLd/gPkode/1dFghhIgPjedO/X
					c+g2ldgJjvdR/meJgfkjgAjrdQ/ngAgAk3f3lCdl/8hxfwfmfylndy/wixfydQfylqdz/viwfzdCf3lMdo/7hwfye/gAkCdU/zgAgAjigJjrdQ/keJgfk1gP
					kIdW/tdBgqjBgLj/dW/wdzghjJgCjrdX/zfkgHjfgAjhdY/ygAgAjo]],
				Jaw = [[
					gAihdf/8gAgAh1f/i3db/ehRfxljf9igdb+hjHfhpDf8jpda/fi9f1k0f+kedd/5hvgChtgAkvdf//gAgAgqgCkedd/5eRf+htgEjpda/fdDgLk0gDigdb+h
					c5ggpEgCiwdb+3eGgRoMgAirdb+1gAgAogf+kDdb/xhyf+jUf8kqdf/2ixgGg+f8ktdf/3iwgHgwf+kNdc/1hxf/itgAjBda/KgAgAnNgCirdb+yeGgRodgD
					jJda/Ic+gTmrgDi/db/cdxgWlegBirdd/1fkgIjEgAihdf/8gAgAh1]],
				["UpperLegF.L"] = [[
					e6hofRzyXbgA3oe3h/fJv+Yddg6je0h1fQzfXdaw3Te0iifEwIZqdy6ze2jGe90JaHfr4Je6jTe51lZ6ga20e+jIe41CY4f43BfBike7uNX3ch7QfAh3fHt1
					WqX66Ee+iAfFtkXoaL7He6h9fIvrX0cV6Ze2i0fA2naFgs11ezjNe+2na/g02DezjQe+yVahfD5ne2i7e/uuZxdP7ke6iLfFuDYaas7Ne+h9fGt8XcaZ66fA
					iPe+x8Xaek5Ae/iFfC1uXmgo16e7hyfMzvXkf73te6hofRzyXbgA3o]],
				["LowerLegF.L"] = [[
					ephCfV7ocDgAvoekhefa+3dBhwnqechUfV+AaBjpXZejiAfW+ye+huofeqiefD5gedekzNevire62TdNdD2lewige517cKca2seqiHfP8tbVfetUejhgfa98
					U7gxeMelhmfa+8YahGisejhdfZ/ObHhxkoetiLe93Tdidc1oesike83KeWdo14emiqfK7mfnfwwLekibfU+ReshAqOejhvfa/WaChphnekhjfa+9YehPiset
					hrfH6Xbeenxgexhee/21bLdJ1seqhLfQ68cDfjwyephCfV7ocDgAvo]],
				["FootF.L"] = [[
					emgnfF/mgAgAk+emhPe+/khZfyk+emhje7/fdXgbk9emhwe7/FjPfTmzemiAe7+oiIfYo+eniMe696gufKrSemiCe6+hflf5pjemhwe7/PfPgLm2emhje7+f
					XthTkzemhge7/YcTglk8emhUe7/mfagGk+emhse7++g+fvn6emiFe7+Qh5fLqKemiOe7+Ujae7pjemiIe7+xiwfRoRemhre7/bd/gXlnemhde7/ZcZgkk8em
					hPe7/lfGgJk+emhAe9/beNgDluemgvfC/mf4gBk+emgnfF/mgAgAk+]],
				["UpperLegF.R"] = [[
					hGhofRzyolgA3ohDiAfFzSoZgi4GhAh3fHv/pijA52g/ike7w/oUh85vhCjIe4tvnIjm7xhGjTe5skmNkD8ehKjGe9ukmEiy7shMiifEx9mShO5shMh1fQy2
					nnhy4phKh/fKyTnhhg5GhGh9fIvroMjr6ZhCi2e6tAnSkH8Ag/jQe2sOnJkp8Tg/jSe1u+nejF7FhCi8e51LnVgE21hGiLfFymn2hI4yhKh8fLxonqiH5ehM
					iNfHxAmmh56NhLiEfJwInEiW6mhHhyfOyDoLg85GhGhofRzyolgA3o]],
				["LowerLegF.R"] = [[
					hXhCfV7oj9gAvohVhafL6pkCg3xNhYhYfU93mGfSpshUiCfI6okThXxJhWirfO8mjcg0t5hZi4fT+AilgCqyhbimfT+EhHfMq1hbh9fR9bg4fJsfhehQfY/V
					iod0lbhbhafU+Tigesp1hdhdfZ/Ok5ePkohXiafS9hkFgUrphUi2fP8qkfhYtahTizfI6zjxh3w9hQiVe62Gj/ji2ghYhmfN8ZjKf/uYhdhZfX/Bi6eLnBhd
					hpfV+thReTovhdhifZ+/iIeEnahZhNfX9DjVfOs8hXhCfV7oj9gAvo]],
				["FootF.R"] = [[
					hagnfF/mgAgAk+hag+e+/mgUf9k+hahFe7/ih7ftk9hahme7/Pgkf4m2haiSe7+sfjgIpAhaike7+cepgcpthaiSe7+kdHg2o9hahme7/Fc1gsmzhahFe7/j
					eJgTk+hahIe7/jeOgSk+hahUe7/mgmf6k+haiFe7/AgJf+n4haife7+jgmf0pdhaiXe7+hf8gBpmhah3e7+ygpf+oqhahMe7/efNgJlohahLe7/keggPk+ha
					hZe7/cc5gfk9hahUe9/hdtgXk9hag2fC/lfMgIk+hagnfF/mgAgAk+]],
				Tail1 = [[
					gAiuhaicgAgA/5gBivhZk/i9gB/dgDinhYlalSgH/FgDjChXnJicgG/FgCjbhXoieCf8+xgAjkhWo7bjf4+Zf+jbhXogcuf5+qf9jChXnLgUgB/Lf9inhYld
					jLgE/Xf+irhYlyi9gG/UgAiqhYlugAgA/egCjOhXn0dDf5+4gDjhhWozc1f6+lgDjjhWo8fsf/+tgCjThXoEjSgH+ygAiyhYmMkdgJ/Ef+iqhYlth+gD/af9
					ixhYmSdkf5/Rf+ixhZlUcCf8/TgAivhajae8gD/ygAiuhaicgAgA/5]],
				Tail2 = [[
					gAipiAh2gAgA/8gIijh8kYkbgH/YgPiah6kqplgY+KgIiyh5nElegU+uf9jIh3pQdNf6+ff2jQh1pwXnfo9Sf3jIh3pFY5fn91f+ixh6nKfxf+/LgFiah8ky
					mZgQ++gFidh7lFnRgX+vgAich8lHh5gG/hf7i8h4oFa7fw+if7jNh2piYefl9mgCjOh3p3cpft+PgJjBh3oikHgI+jgKikh6lqoZgb+WgDich8lCl2gR/Df4
					ijh6lseIf4/bf1ikh7kqZofy/Af9inh/izd2gE/ygAipiAh2gAgA/8]],
				Tail3 = [[
					gAikimgzgAgA/+gSiZigjWkngR/egliQiYjhtFg889gViiiZmdpdg592f3iziWpleTgI+efji7iPqJU8fS8Pfni0iTpIUse98ef9ihicmsdZfr/LgUiPidju
					n/gk+wgWiSibj6rYg79ogEiQigkClTgb/SfviqiXn/aqfs+gfri4iRpxU7fD8Xf6i4iVqOYofB9YgTitiXonjBf9+qgdiYiYkurFg69ngRiRidj4qIgz+Ffz
					iViekrghgD/pfmiaidjnYcfg+3f4igikhwcxf//xgAikimgzgAgA/+]],
				Tail4 = [[
					gAiijMfEgAgA/+gdiRjDhqjegZ/whBiJiwh4vJh68DgqiUi1lNtfiE8dfzidi1pNhCg2+mfMimikqDT9e973fOiiipojREd063f3iRi+lgZwe2+3gmiHi9iE
					nrg+++gviKi2iMubh+8ZgRiHjCiRpchQ+dfjiYi2nRcQf8+7fTilinpgS0eX7gfpijivp3Ujdy8HgZiai2n/gQfV++g2iOizjSsDhm9agniJi6iIt4h28rf0
					iKjCi7kOgp/kfUiSi9h8YrfH/EfwicjJgDb6fw/ugAiijMfEgAgA/+]],
				Tail5 = [[
					gAiljyb2gAgA/ugliOjoebhOgR/7hhiIjFfDvWji71hIiLjMizwhkQ66f2iIjVnRkrig+seyiTi4orUueu8oeviTi5m6O1b25wfoiFjfi4V0dA+Cg4iDjee7
					lfhR/ehOiIjNfWvxjz7kgmiDjhfOtPjK88faiHjXk+fTg0/le3iTi5oDSddd7ufQiQjEoQRfbq68gaiHjYlycjd4/MhRiIjOgerGih95hFiGjSfRwPj37Sf+
					iEjmfvoViJ+zfDiOjfeyaWeu/cfnicjuc2bgfR/ggAiljyb2gAgA/u]],
				["UpperLegB.L"] = [[
					e2h1g34CXxgAzce2h8gv0Uaxge4Je3h0gw3XY/em0qe3iSgrz8bdfr4me2iugnzjbRfr44e2i5gjyobQgN5ke2iwghyUbBg55ve2iVgiydauhe5je2h2gm08
					ZAg33Ie2h7gnzBalhM5He2h5gq02Z/gQ3ge2iggozdbaf74+e3i0go1Oafe03Qe3i1go1Vaaew3Je2ilgozXbbf35De2iCgpzZa5gn46e2h5gnzAaihK5He2
					iDgjy0athr5Re2h/gozTaehh43e2h4gz2sYqgb1Te2h1g34BXxgAzc]],
				["LowerLegB.L"] = [[
					enhJgrwSd+gA7derhNg20nckea4KemhHgovKfSes8Ierhkg00LdIds4jeriAgxy8dPd55ieriLgxyvczeQ5qeriCgwylcje15yeshngwyycVfV5oeohHgpvR
					dcfy7/erhNgyzVcPfF5MephKguxsdYe56ferhygzzsdBd748eoiFgrwneid97OeoiHgrwVepd+7Zerh3gzzndBd45AerhUgzzscjej48erhLgzzVcLfD5Mes
					hVgwzIcXfg5YeshRgyzpcMfY49eohKgtxWddft6wenhJgrwSd+gA7d]],
				["FootB.L"] = [[
					ejgqg7/jgAgAlRejgrg7/beGgQlpejgqg7/jgHf/lRejhCg7/BeHgVnlejhfg7+neXgfpHejhqg7+ZeNglpyekhig6+VeSgWqAekhGg6+peXgCpBejgqg7/j
					fbgGlRejgsg7/ZeOgMl4ejgqg7/ie7gMlRejhQg7+weMgXooejhmg7+hfagMpkejhpg7+efhgKpsejhWg7+seLgbo1ejgzg7/UeJgSmRejgqg7/feLgTlWel
					g0g5+seffqo4ekgvg6/HeVf8nPejgqg7/jfegGlRejgqg7/jgAgAlR]],
				["UpperLegB.R"] = [[
					hKh1g34CoPgAzchKh8grzolkey4nhKh2gm06m+fI3KhKiVgiydlSei5jhKiwghyUk/fH5vhKi5gjyokwfz5khKiugnzjkvgV44hJiSgrz8kjgV4mhJh0gw3Y
					nChb0ohKh6gt1BllgO3dhKh5gq02mBfw3ghKiigiyklDe95ihKi3gfx7lGe15+hKi4gfx4lFe26AhKingiyelBfB5nhKiCgpzZlHfZ46hKh4gt13mKgg2ihJ
					iBgt0PkhgH4XhKh+gv0ck9fz4GhKh4g02/nSf51BhKh1g34BoPgAzc]],
				["LowerLegB.R"] = [[
					hZhJgrwSiCgA7dhVhOg0z+j0g64rhYhHgpvUilgP79hUhngwyyjrgr5ohViCgwyljdhL5yhViLgxyvjNhw5qhViAgxy8ixiH5ihVhkg00Li4iU4jhahHgovI
					gthU8JhXhLgxyqighp50hXhKguxsiohH6fhVh0gwy2jehD5mhViJgvyNjng66ChViMgvyKjmg76EhVh5gwywjehG5qhVhUgzzsjdhd48hYhJgtxPh6ha62hU
					hSg00fiyiI4UhVhPg20vjKh24FhYhKguxgiVgf6qhZhJgrwSiCgA7d]],
				["FootB.R"] = [[
					hdgqg7/jgAgAlRhdgsg7/Whyf2mGhdgqg7/jgmf6lRhchGg6+phpf+pBhchig6+VhufqqAhdhqg7+Zhzfbpyhdhfg7+nhpfhpHhdhCg7/Bh5frnlhdgqg7/j
					f5gBlRhdgqg7/hhTfylRhdgqg7/ihFf0lRhchTg6+fhrf2pihchpg6+Lhufpqfhchrg6+KhufnqihchZg6+bhsfypvhdgzg7/Uh3fumRhdgqg7/igwf4lRhc
					gwg6/EhsgHnehcgtg7/Sh1f5mYhdgqg7/jgef7lRhdgqg7/jgAgAlR]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAi1gx/+gAgAhNgAi1g///gAgAgUgAi1hL//gAgAfhgAi1hJ//gAgAfpgAi1hF//gAgAf7gAi1g//+f7hJgRgAi1g7/8f6hlgjgAi1g5/+f9g2gsgAi1g4/+
					gAgAgwgAi2g1/+gMf3g9gAjAgy/3ilgGhJgAjSgx/KnHgRhLgAjfgx9bsegehHgAjigx6+xLgphBgAjfgx410Igwg8gAjfgx4I09gyg6gAjfgx4w0Pgwg7gA
					jggx5Szkgvg9gAjfgx400Jgwg7gAjfgx4J08gyg6gAjfgx4I0+gyg6gAjfgx4I0+gyg6gAjfgx4I0+gyg6gAjfgx4I0+gyg6gAjfgx4I0+gyg6]],
				Spine1 = [[
					gAizgY/+gAgAhNgAi0gl//gAgAgUgAi2gx//gAgAfhgAi1gv//gAgAfpgAi1gr//gAgAf7gCi0gm/+f7hJgRgDi0gh/8f6hlgjgBi0gf/+f9g2gsgAi0ge/+
					gAgAgwgAi0gb/+gMf4g9gAi+gY/3ilgMhIgBjQgY/KnGghhHgBjegY9csdg6g7gCjhgY6+xJhNgqgCjfgY420GhYgbgCjegY4J07hbgXgCjfgY4w0NhYgbgC
					jggY5TzihWgegCjfgY410IhYgbgCjegY4K06hbgXgCjegY4J08hbgXgCjegY4J08hbgXgCjegY4J08hbgXgCjegY4J08hbgXgCjegY4J08hbgX]],
				Spine2 = [[
					gAixf+/jgAgAlRgAi0gM/sgAgAkYgAi2gX/ygAgAjmgAi2gW/xgAgAjugAi1gR/vgAgAj/gEi0gM/rfyhIkVgFizgI/nfthkkngDizgG/of2g1kwgAiygF/o
					gAgAk0gAizgC/mgNf6lBgBi9f//dihgnlLgCjPf++ym7hrlBgDjdf+9GsLi6kfgEjhf+6twwj7jvgEjgf+4pzpkijGgEjff+3+0dksi4gEjgf+4kzvkjjEgE
					jgf+5FzFkbjOgEjgf+4ozqkijFgEjff+3/0cksi5gEjff+390eksi4gEjff+390eksi4gEjff+390eksi4gEjff+390eksi4gEjff+390eksi4]],
				Spine3 = [[
					gAipfo/jgAgAlRgAitf1/sgAgAkYgAixgA/ygAgAjmgAixf//xgAgAjugAivf7/vgAgAj/gFiuf2/rfyhIkVgHisfy/nfthkkngEisfv/of2g1kwgAirfu/o
					gAgAk0gAirfr/mgNf6lBgCi1fp/diggtlKgGjIfo+ym5h7k9gKjZfo9HsGjVkTgMjffo6vwpkejYgMjhfo4szglIimgMjhfo4B0UlUiVgMjhfo4nznlKikgM
					jgfo5Iy9lBiwgMjhfo4rzilJilgMjhfo4C0TlTiWgMjhfo4A0VlUiVgMjhfo4A0VlUiVgMjhfo4A0VlUiVgMjhfo4A0VlUiVgMjhfo4A0VlUiV]],
				Neck1 = [[
					gAiifRAHgAgAiagAinfeATgAgAkLgAisfpAigAgAlugAirfoAfgAgAlggAipfkAagAgAk9gHinffAVf6e3kRgJimfbARf4ebjsgFilfZANf8fKjagAikfYAM
					gAgAjSf/ikfVAJf1gJi5gEiufSAOdbgEibgKjCfSA5Y5gJiLgRjVfSCoTigLiCgUjffSFFO3gMh9gUjifSHML6gMh7gUjjfSH5LFgMh7gUjifSHSLzgMh7gU
					jifSGvMegMh7gUjifSHNL5gMh7gUjjfSH4LGgMh7gUjjfSH5LEgMh7gUjjfSH5LEgMh7gUjjfSH5LEgMh7gUjjfSH5LEgMh7gUjjfSH5LEgMh7]],
				Neck2 = [[
					gAioenBQgAgAo0gAiye1CGgAgArXgAi7fCDBgAgAthgAi6fAC3gAgAtNgAi2e7CigAgAscgKize2CLfqe6regOiveyB4fiefqqgHiuevBufwfMqRgAiteuBq
					gAgAqGf/iserBef3gMpigDi0eoBWdigvoygJjHenB4ZLh7oGgOjZenDbUAjOnPgRjjeoFsPekNmRgRjmeoHpMmkwligQjneoITLyk5lTgQjmeoHvMfkxlggR
					jleoHPNJkplsgRjmeoHrMkkwligQjneoISLzk5lUgQjneoITLxk5lTgQjneoITLxk5lTgQjneoITLxk5lTgQjneoITLxk5lTgQjneoITLxk5lT]],
				Neck3 = [[
					gAi7eJBygAgAqfgAjKeaDJgAgAtygAjWeqEogAgAwjgAjVeoEZgAgAwJgAjQeiD2gAgAvLgMjLebDPfke8t8gQjGeWCxfbeis4gJjEeTChftfNsYgAjDeRCa
					gAgAsKf+jAeOCIf4gNragAjHeKB3dohBqZgBjXeICQZbippZgBjleIDpUakXoGgBjpeHFtP/lomngBjpeHHhNLmRlfgAjoeHIIMYmblJgBjpeHHmNFmTlcgB
					jpeHHJNumKlugBjpeHHjNKmSlfgAjoeHIHMZmblKgAjoeHIJMXmclJgAjoeHIJMXmclJgAjoeHIJMXmclJgAjoeHIJMXmclJgAjoeHIJMXmclJ]],
				Head = [[
					gAjhdY/ygAgAjogAj6dz/9gAgAelgAkNeO/dgAgAaLgAkKeK/kgBgAa1gAkEeA/ygAgAcYgPj7d1/5eigueRgVj0dt/5d5hHf3gLjwdo/9e2gogugAjudl/+
					gAgAhHf+jpdg/6gZf4iPf5jtdZ/qinf4jwfwj3dW+ynHf4k/fnj7dU83sVgPmLfjj0dT6Qwwg8nRfijrdS4Dzdhpn9fijodS3W0Nh4oKfijqdS3+zjhrn/fi
					jtdS4hy8hfn1fijrdS4Czehpn+fijodS3X0Mh4oJfijodS3W0Nh4oKfijodS3W0Nh4oKfijodS3W0Nh4oKfijodS3W0Nh4oKfijodS3W0Nh4oK]],
				Jaw = [[
					gAihdf/8gAgAh1gAi7dl//gAgAfdgAjUdv/4gAgAdXgAjQdt/6gBgAdrgAjHdq/8gAgAebgJi9dm/8eggrfSgNi0dj/5d4hGgAgHivdi/9e3gogdgAitdi//
					gAgAgpf/ipdg/9gZf3hOgEitdg/ximfyipgMi+dh+2nHfzkmgVjQdj8usVggmzgbjadl50wrh2orgejfdn3YzRjIpygejhdn2mz+jjqEgejgdn3SzXjLp0ge
					jfdm35yyi2plgejgdn3XzTjJpygejhdn2nz9jjqEgejhdn2lz/jkqEgejhdn2lz/jkqEgejhdn2lz/jkqEgejhdn2lz/jkqEgejhdn2lz/jkqE]],
				["UpperLegF.L"] = [[
					e6hofRzyXbgA3oe6hufb1EXcfh2fe6hzfj2JXefH1ce6hyfi1/XefK1me6hwff1nXdfU1+fBhufX1HWngN2HfEhtfS0sWSgp2Xe/hsfT0hW0gQ2we6hrfW0b
					Xcfx3Ee6hqfV0LXpf83YfIhqfR0GY0iO3ufkhwfO0KbNmR3jgJh7fLz9d/rH2UgqiHfJzbgZvY0Pg+iSfHy6h7yDyVhDiWfHyviWyyxtg/iTfHy5h+yJyRg6
					iQfIzBhoxiyvg+iTfHy6h8yEyUhDiWfHywiWyxxuhDiWfHyviXyzxshDiWfHyviXyzxshDiWfHyviXyzxshDiWfHyviXyzxshDiWfHyviXyzxs]],
				["LowerLegF.L"] = [[
					ephCfV7ocDgAvoephHfa8dcEfyuEephNff9HcFfmsqephMff9BcFfns4ephKfd8ycEfstYewhIfV8ebggwt1ezhGfR8NbShNuSeuhFfU8GbpgnupephFfY8D
					cEf5u3eqhDfX74cSf7vPe+hCfV7veJhkvvflhGfV7Yhykbv1gYhUfU6WmEn8vIhDhofU4ypzrGtyhdh5fU3ZsKtHsfhjh/fU28s1tssDhdh6fU3WsQtMsbhY
					h1fU3srtsusxhdh5fU3ZsLtIsehjh/fU29s0trsDhjh/fU28s1tssChjh/fU28s1tssChjh/fU28s1tssChjh/fU28s1tssChjh/fU28s1tssC]],
				["FootF.L"] = [[
					emgnfF/mgAgAk+emgvfH/1gAgAjNemg2fK/8gAgAhpelg1fJ/7gAgAh4emgyfI/5gAgAibeugvfB/0f1hIjHexgte+/vfwhkjsergsfB/uf4g2j+emgrfG/u
					gAgAkGemgpfG/rgNf6kge+gmfF/diggtlMfugsfG+qm2iGlsgqg/fH83r6j7lvhdhZfI6bwRlslWh5hxfI4Xy9m4k0iAh5fJ3szunOknh6hyfI4RzDm7kyh0
					hsfI4yycmpk8h5hxfI4Wy/m5k0iAh4fJ3tztnNkoiAh5fJ3rzunOkniAh5fJ3rzunOkniAh5fJ3rzunOkniAh5fJ3rzunOkniAh5fJ3rzunOkn]],
				["UpperLegF.R"] = [[
					hGhofRzyolgA3ohGhufb1Eokgf2fhGhzfj2Joig51chGhyfi1/oig11mhGhwff1nojgs1+hNhufh1HnthN2uhPhsfg0snZhV3NhLhrfb0hn8gz3NhGhrfW0b
					okgP3EhGhsfU0FoygM3ThSiAfTy2p6iC3zhiisfVwur/ln32hqjffYt8uAqF3DhlkFfarLvWuI1ihbkafcpPv+ww0DhWkgfdoqwHxhzjhakbfcpKv/w20Ahd
					kWfcpnv3wQ0YhakafcpOv+wy0DhXkffdorwGxgzkhWkgfdopwHxhzjhWkgfdopwHxhzjhWkgfdopwHxhzjhWkgfdopwHxhzjhWkgfdopwHxhzj]],
				["LowerLegF.R"] = [[
					hXhCfV7oj9gAvohXhHfa8dj8gOuEhXhNff9Hj7gasqhXhMff9Bj8gYs3hXhKfd8yj8gUtYhdhHfh8ejYhOuHhfhGfi8NjLhiurhbhFfd8Gjig3u2hXhFfY8D
					j8gHu3hXhFfW71kLgDvMhphdfY7KmBhgvuiBiRfc5yphkNv0iQjQfi3ktenjvLiNkDfn08wuqkt7iBkhfqy4yrsgsvh9kpfryOzNtEsUiBkifqyzyvslsriE
					kbfqzTyTsIs/iBkhfqy3ysshsuh9kpfryPzMtDsVh8kpfryOzNtEsUh8kpfryOzNtEsUh8kpfryOzNtEsUh8kpfryOzNtEsUh8kpfryOzNtEsU]],
				["FootF.R"] = [[
					hagnfF/mgAgAk+hagvfH/1gAgAjNhag2fK/8gAgAhphag1fJ/7gAgAh4hagyfI/5gAgAibhigvfO/0f1hIjHhlgsfQ/vfwhkjshggrfL/uf4g2j+hagrfG/u
					gAgAkGhbgrfF/rgNf6kghxhEfI/eiggtlFiRh6fN+tm3iBlYiojAfU89r+julOipj8fa6jwZlSkrifkgfe4fzKmTkFiakqfg30z8mmj4iekiff4azQmWkEii
					kafe47yomHkOifkhfe4ezLmUkFiakqfg31z6mmj4iakrfg30z8mmj3iakrfg30z8mmj3iakrfg30z8mmj3iakrfg30z8mmj3iakrfg30z8mmj3]],
				Tail1 = [[
					gAiuhaicgAgA/5gAishojVgAgA/0gAiqhzkHgAgA/ugAiqhxj/gBgA/vgAirhtjugAgA/xf9ishojXeGgG/wf8ithkjFdYgJ/vf+ithii8emgF/0gAithhi4
					gAgA/3gAivheisgRgL/4gBi6hbihgVik/ygDjMhaiZg6nE/GgFjbhaiJhmsZ9XgGjfhahxiLxD67gGjehahciiz/4zgGjehahVio004HgGjehahbii0G4ugG
					jehahgidzb5QgGjehahcii0B4ygGjehahVio0z4IgGjehahUio014GgGjehahUio014GgGjehahUio014GgGjehahUio014GgGjehahUio014G]],
				Tail2 = [[
					gAipiAh2gAgA/8gAikiNivgAgA/4gAihiYjggAgA/zgAihiWjZgBgA/zgAiiiSjHgAgA/1f5ikiNixdVgF/wf2imiJiecUgJ/rf6imiHiWeCgF/2gAiniGiS
					gAgA/6gBioiEiGgXgL/6gCi0iBh8gaik/1gGjHiAh0hInD/IgKjXiAhfh/sY9ZgMjeiAg+itxB68gNjfiAggjJz740gNjfiAgWjQ0w4IgNjfiAgfjJ0C4vgN
					jfiAgmjEzY5RgNjfiAggjJz94zgNjfiAgWjQ0v4JgNjfiAgWjQ0x4HgNjfiAgWjQ0x4HgNjfiAgWjQ0x4HgNjfiAgWjQ0x4HgNjfiAgWjQ0x4H]],
				Tail3 = [[
					gAikimgzgAgA/+gAieiyhsgAgA/8gAiYi9iegAgA/5gAiZi7iWgBgA/5gAibi4iEgAgA/7fyieiyhuclf//wftigithbbRgB/mf2ihithTdegB/3gAihishP
					gAgA/9gCijiphDgdgM/+gEiving6gdik/3gKjDimgzhQnF/KgQjWimgbiOsa9ZgTjgilfzjBxC66gUjjilfOjez84xgTjkilfCjl0w4EgUjjilfNjf0C4rgU
					jiilfWjZzY5OgUjjilfOjez94wgTjkilfCjl0v4FgTjkilfCjl0w4DgTjkilfCjl0w4DgTjkilfCjl0w4DgTjkilfCjl0w4DgTjkilfCjl0w4D]],
				Tail4 = [[
					gAiijMfEgAgA/+gAiajYf9gAgA//gAiSjigvgAgA/+gAiUjhgogCgA//gAiWjdgWgAgA//fqiajXgAb1fw/tfiicjRfuaPfu/dfwiejSflc6f3/1gAiejSfh
					gAgA//gDihjPfVgjgN/+gFitjNfOgcim/3gNjCjMfIhPnJ/JgVjXjLewiMsg9VgZjkjLeEi9xJ6xgZjqjKdcjY0C4lgYjrjKdOjf0233gZjqjKdajZ0I4fgZ
					jpjKdljTzf5CgZjqjKdcjY0D4jgYjrjKdPjf0034gYjrjKdOjf0232gYjrjKdOjf0232gYjrjKdOjf0232gYjrjKdOjf0232gYjrjKdOjf0232]],
				Tail5 = [[
					gAiljyb2gAgA/ugAiaj+cvgAgA/0gAiRkIdhgAgA/5gAiSkHdZgCgA/4gAiVkDdHgAgA/3fgiaj8c0bIfO/cfVidj1ckZRe//Efpifj3cYcYfe/kgAifj4cS
					gAgA/xgEiij1cHgogS/vgGivjycBgTip/ogPjFjxb/g3nR+4gZjcjxbthjsu8/gcjrjwbHiExZ6UgbjzjvaiiV0S4Agaj1jvaWiY1G3Qgbj0jvahiV0Z36gc
					jyjvaqiSzv4fgbjzjvaiiV0U3/gaj1jvaWiY1E3Rgaj1jvaWiY1G3Qgaj1jvaWiY1G3Qgaj1jvaWiY1G3Qgaj1jvaWiY1G3Qgaj1jvaWiY1G3Q]],
				["UpperLegB.L"] = [[
					e2h1g34BXxgAzce2h1hB5EXyfjyFe2h1hK57X0fJw1e2h1hJ5zX0fMxBe2h1hG5gXzfWxde2h1g95HXGgYxte2h1g34xW0g3yCe2h1g54oXQgYyde2h1g84j
					Xxfxyxe3h1g74ZX/f4zEfBh1g45BZwhXy4fZh4g36Kdijqx4f6h+g360idmEwLgaiEg36inNn5uUgviKg351qdo6s8g1iNg35jrapKshgwiKg35zqlo8s4gr
					iIg36Ap0outNgviKg351qfo6s7g1iMg35jrZpKshg1iNg35jrbpKsgg1iNg35jrbpKsgg1iNg35jrbpKsgg1iNg35jrbpKsgg1iNg35jrbpKsg]],
				["LowerLegB.L"] = [[
					enhJgrwSd+gA7denhKgwxzd+f56genhMg0zEd+fy5menhMg0y4d/fz5venhLgyybd+f26EeohKgqx3c/ge6XeohKgmxXcngu6penhJgpxJdPgX63enhJgtxD
					d+f86/eohJgtwweMgE7Me5hHgpw0fUiK7HfehLgmxNh1l76QgOhWgjxQlHqO4ag4hlggwtoOt12ChShzgev/qWwB0GhZh4gevuq+wozehTh0gev9qbwG0BhN
					hwgfwKp8vn0ghShzgev/qXwC0FhZh4gevvq9wnzfhZh4gevuq/wpzdhZh4gevuq/wpzdhZh4gevuq/wpzdhZh4gevuq/wpzdhZh4gevuq/wpzd]],
				["FootB.L"] = [[
					ejgqg7/jgAgAlRejgqg9/zgAgAjgejgqg+/7gAgAh9ejgqg+/6gAgAiLejgqg+/4gAgAivejgqg2/yf0hIjaejgqgz/sfvhkj/ejgqg3/sf3g1kRejgqg8/s
					gAgAkZelgqg8/ogNf5kwe6gog5/hijgZkxfogtg1+6nDg8kIgig8gw9SsahVjJhVhTgr65xIhbiOhyhogo4z0GhVhph5hwgn4H08hShehzhpgo4t0NhUhnhs
					hkgp5PzhhXhwhyhpgo4y0IhVhoh5hvgn4I07hSheh5hwgn4G08hSheh5hwgn4G08hSheh5hwgn4G08hSheh5hwgn4G08hSheh5hwgn4G08hShe]],
				["UpperLegB.R"] = [[
					hKh1g34BoPgAzchKh1hB5EoOgdyFhKh1hK57oMg3w1hKh1hJ5zoNgzxBhKh1hG5goNgqxdhJh1hH5HnhhWyShJh1hG4xnQhhy2hJh1hB4onug5y5hKh1g84j
					oPgPyxhLh3g64ToegJzAhTiNg43mqKhry/hei4g32PthkayFhhjog3z+xZnewUhZkKg3xN0sp5uMhOkbg3u/2srRsihJkfg3uR3ProsBhNkbg3u52wrUsehQ
					kYg3vc2UrBs4hOkbg3u+2trSshhKkfg3uS3OrosBhJkfg3uR3QrosAhJkfg3uR3QrosAhJkfg3uR3QrosAhJkfg3uR3QrosAhJkfg3uR3QrosA]],
				["LowerLegB.R"] = [[
					hZhJgrwSiCgA7dhZhKgwxziCgH6ghZhMg0zEiCgO5mhZhMg0y4iCgM5vhZhLgyybiCgK6EhahKg2x3hDgt6hhahJg3xXgrg562hahJgyxJhUgg6+hZhJgtxD
					iCgE6/hahLgrwuiQgI7LhphkgqwZjXiO7Lh/iYgowClwmE6ZiLjVglvOoqqh4niFkGgjt+rTuU2Rh5khgis1tBwp0Uh0koghsdtgxSzrh4kigisytFwu0Ph8
					kcgitFsrwN0uh5khgis0tCwq0Sh0koghsdtfxRzsh0koghsctgxTzrh0koghsctgxTzrh0koghsctgxTzrh0koghsctgxTzrh0koghsctgxTzr]],
				["FootB.R"] = [[
					hdgqg7/jgAgAlRhdgqg9/zgAgAjghdgqg+/7gAgAh9hdgqg+/6gAgAiLhdgqg+/4gAgAivhcgphE/yf0hIjahcgphG/sfvhkj/hcgqhB/sf3g1kRhdgqg8/s
					gAgAkZhfgsg7/ogNf5kwhyhGg6/gijgak4iQh9g3+4nChBkcikjCgz9OsZhjjqikj8gw61xFh2i5iakegu4v0Dh7iYiVkogt4D05h8iOiZkfgu4q0Kh7iXic
					kYgu5Lzeh7ifiZkegu4u0Eh7iYiVkngt4E03h8iPiVkogt4C05h8iOiVkogt4C05h8iOiVkogt4C05h8iOiVkogt4C05h8iOiVkogt4C05h8iO]],
			},
		},
	},
}
