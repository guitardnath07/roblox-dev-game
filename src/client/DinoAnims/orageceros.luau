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
					gAiCgrAFgAgAiCgAiCgrAFgAgAiCgAiCgrAFgAgAiCgAiDgrAFgAgAiCgAiDgrAFgAgAiCgAiDgrAFgAgAiCgAiDgrAFgAgAiCgAiDgrAFgAgAiCgAiCgrAF
					gAgAiCgAiSgrAJgAgAi0gAiQgrAJgAgAiwgAiIgrAHgAgAiZgAiEgrAGgAgAiNgAiDgrAGgAgAiJgAiBgrAFgAgAiDgAiAgrAFgAgAiCgAiBgrAFgAgAiCgA
					iBgrAFgAgAiCgAiBgrAFgAgAiCgAiBgrAFgAgAiCgAiCgrAFgAgAiCgAiCgrAFgAgAiCgAiCgrAFgAgAiCgAiDgrAFgAgAiCgAiDgrAFgAgAiCgAiDgrAFgA
					gAiCgAiDgrAFgAgAiCgAiDgrAFgAgAiCgAiCgrAFgAgAiCgAiCgrAFgAgAiCgAiCgrAFgAgAiCgAiBgrAFgAgAiCgAiBgrAFgAgAiCgAiBgrAFgAgAiCgAiB
					grAFgAgAiCgAiAgrAFgAgAiCgAiBgrAFgAgAiCgAiBgrAFgAgAiCgAiBgrAFgAgAiCgAiBgrAFgAgAiC]],
				Spine1 = [[
					gAiEgWAFgAgAiCgAiFgWAFgAgAiHgAiFgWAGgAgAiLgAiFgWAGgAgAiOgAiGgWAGgAgAiQgAiGgWAGgAgAiRgAiGgWAGgAgAiQgAiFgWAGgAgAiOgAiFgWAG
					gAgAiLgAiVgWAJgAgAi5gAiUgWAJgAgAiwgAiMgWAGgAgAiVgAiHgWAFgAgAiFgAiGgWAFgAgAh+gAiDgWAEgAgAh2gAiDgWAEgAgAh0gAiDgWAEgAgAh1gA
					iDgWAEgAgAh3gAiEgWAFgAgAh6gAiEgWAFgAgAh+gAiEgWAFgAgAiCgAiFgWAFgAgAiHgAiFgWAGgAgAiLgAiFgWAGgAgAiOgAiGgWAGgAgAiQgAiGgWAGgA
					gAiRgAiGgWAGgAgAiQgAiFgWAGgAgAiOgAiFgWAGgAgAiLgAiFgWAFgAgAiHgAiEgWAFgAgAiCgAiEgWAFgAgAh+gAiEgWAFgAgAh6gAiDgWAEgAgAh3gAiD
					gWAEgAgAh1gAiDgWAEgAgAh0gAiDgWAEgAgAh1gAiDgWAEgAgAh3gAiEgWAFgAgAh6gAiEgWAFgAgAh+]],
				Spine2 = [[
					gAiHgB//gAgAgUgAiIgB//gAgAgLgAiIgB//gAgAgEgAiIgB//gAgAf9gAiJgB//gAgAf5gAiJgB//gAgAf4gAiJgB//gAgAf5gAiIgB//gAgAf9gAiIgB//
					gAgAgEgAiZgB//gAgAfZgAiXgB//gAgAfngAiPgB//gAgAgGgAiKgB//gAgAgagAiIgB//gAgAglgAiGgB/+gAgAgvgAiGgB/+gAgAgxgAiGgB/+gAgAgvgA
					iGgB//gAgAgrgAiGgB//gAgAglgAiHgB//gAgAgdgAiHgB//gAgAgUgAiIgB//gAgAgLgAiIgB//gAgAgEgAiIgB//gAgAf9gAiJgB//gAgAf5gAiJgB//gA
					gAf4gAiJgB//gAgAf5gAiIgB//gAgAf9gAiIgB//gAgAgEgAiIgB//gAgAgLgAiHgB//gAgAgUgAiHgB//gAgAgdgAiGgB//gAgAglgAiGgB//gAgAgrgAiG
					gB/+gAgAgvgAiGgB/+gAgAgxgAiGgB/+gAgAgvgAiGgB//gAgAgrgAiGgB//gAgAglgAiHgB//gAgAgd]],
				Spine3 = [[
					gAiHfs//gAgAgUgAiHfs//gAgAgHgAiIfs//gAgAf7gAiIfs//gAgAfygAiJfs//gAgAfsgAiJfs//gAgAfpgAiJfs//gAgAfsgAiIfs//gAgAfygAiIfs//
					gAgAf7gAiafs//gAgAfVgAiYfs//gAgAfngAiPfs//gAgAgLgAiJfs//gAgAgjgAiIfs/+gAgAgwgAiFfs/+gAgAg8gAiFfs/+gAgAg/gAiFfs/+gAgAg9gA
					iFfs/+gAgAg3gAiFfs/+gAgAgugAiGfs//gAgAgigAiHfs//gAgAgUgAiHfs//gAgAgHgAiIfs//gAgAf7gAiIfs//gAgAfygAiJfs//gAgAfsgAiJfs//gA
					gAfpgAiJfs//gAgAfsgAiIfs//gAgAfygAiIfs//gAgAf7gAiHfs//gAgAgHgAiHfs//gAgAgUgAiGfs//gAgAgigAiFfs/+gAgAgugAiFfs/+gAgAg3gAiF
					fs/+gAgAg9gAiFfs/+gAgAg/gAiFfs/+gAgAg9gAiFfs/+gAgAg3gAiFfs/+gAgAgugAiGfs//gAgAgi]],
				Neck1 = [[
					gAiGfXA2gAgAnQgAiHfXA4gAgAnXgAiIfXA5gAgAncgAiJfXA6gAgAnhgAiJfXA7gAgAnkgAiJfXA7gAgAnlgAiJfXA7gAgAnkgAiJfXA6gAgAnhgAiIfXA5
					gAgAncgAibfYBbgAgApXgAiYfXBVgAgApGgAiOfXBDgAgAoFgAiJfXA6gAgAnggAiHfXA7gAgAnjgAiEfXBBgAgAn7gAiDfXBLgAgAojgAiDfXBRgAgAo2gA
					iEfXBSgFgXo4gAiFfXBUgOhJo9gAiFfXBXgUhopCgAiGfXBZgUhppIgAiHfXBbgThppPgAiIfXBdgThppUgAiJfXBegThppZgAiJfXBdgJg1pcgAiJfXBefz
					e1pdgAiJfXBffteXpcgAiJfXBefteXpZgAiIfXBdfteXpUgAiHfXBbfteYpOgAiGfXBQfxe3owgAiFfXBBf7fpn9gAiFfXA2gAgAnQgAiEfXAygAgAm/gAiD
					fXAygAgAm8gAiDfXAygAgAm7gAiDfXAygAgAm8gAiEfXAygAgAm/gAiFfXA0gAgAnEgAiFfXA1gAgAnK]],
				Neck2 = [[
					gAiZeyCBgAgArHgAiaeyCBgAgArHgAibezCBgAgArHgAicezCBgAgArHgAicezCBgAgArHgAicezCBgAgArHgAicezCBgAgArHgAicezCBgAgArHgAibezCB
					gAgArHgAiye1DWgAgAuOgAive1DOgAgAt9gAijezClgAgAsjgAicezCRgAgArzgAiZezCYgAgAsFgAiXezCxgAgAs+gAiZe0DVgAgAuLgAiZe0DlgAgAusf/
					iae0DmgOgtusf9ibe1DqgqiNuqf8ice1Dwg8jKuof8ide1Dwg8jNuof8iee1Dwg7jNuof8ife1Dwg7jNunf8ige1Dwg6jNunf+ige1DogdhnurgDihe1DrfX
					dvuqgEige1DwfGczungEige1DwfGczungEife1DwfFczungEiee1DvfFc1umgDice0DTfVdzt8gBiZezCofxfTspgAiXeyCJgAgAregAiVeyCBgAgArHgAiV
					eyCBgAgArHgAiVeyCBgAgArHgAiVeyCBgAgArHgAiVeyCBgAgArHgAiWeyCBgAgArHgAiXeyCBgAgArH]],
				Neck3 = [[
					gAiueZCUgAgAr5gAiveZCRgAgArzgAixeZCPgAgArtgAixeZCNgAgArpgAiyeZCMgAgArmgAiyeZCMgAgArlgAiyeZCMgAgArmgAixeZCNgAgArpgAixeZCP
					gAgArtgAjNehEUgAgAwBgAjJegEKgAgAvvgAi7ecDOgAgAt9gAiyeaCygAgAtAgAixebDBgAgAthgAiwedDtgAgAu6gAizegEtgAgAwqgAi1ehFJgAgAxYf+
					i1ehFJgUhExVf6i2ehFQg/jSxNf3i3eiFYhZktxDf3i4eiFVhZkww9f3i5eiFShYkxw3f3i6eiFPhXkxwyf3i7ejFMhXkywuf8i8eiE5griZwzgGi8eiE+fD
					cnwvgJi8ejFKeqbOwrgJi7ejFMepbOwugJi6eiFPepbPwygJi5eiFQepbSw1gGi2egEhe/ctwAgCiyecDYfpe9uPgAiteZCmgAgAsmgAireZCagAgAsJgAir
					eZCbgAgAsMgAireZCcgAgAsNgAireZCbgAgAsMgAireZCagAgAsJgAiseZCZgAgAsFgAiteZCWgAgAr/]],
				Head = [[
					gAjTdy/7gAgAiAgAjUdy/7gAgAiGgAjVdy/6gAgAiMgAjWdy/6gAgAiRgAjWdy/6gAgAiUgAjWdy/6gAgAiVgAjWdy/6gAgAiUgAjWdy/6gAgAiRgAjVdy/6
					gAgAiMgAj7eG/ygAgAcXgAj3eF/zgAgAcjgAjld7/+gAgAe0gAjad2/+gAgAg7gAjad4//gAgAfcgAjcd+/0gAgAcwgAjjeH/egAgAaQgAjmeL/DgAgAYTf8
					jmeL/CgCeNYefyjmeM+wgJadZNftjneN+IgMYFYvfsjoeN+NgOYAZLfsjpeN+TgPYAZnfsjqeN+KgNYAY/fsjreN+TgPYAZkf2jseL/DgHb+ZfgOjseL+rf3
					lsY8gUjreN+VfwoAZvgUjreN+TfxoAZkgUjqeN+KfzoAY/gUjpeN+Vfxn7ZogOjleG/Ff9lka3gFjcd8/3gDhzd7gAjUd0/+gAgAg9gAjRdy/8gAgAhugAjQ
					dz/8gAgAhrgAjQdz/8gAgAhqgAjQdz/8gAgAhrgAjRdy/8gAgAhugAjSdy/8gAgAhzgAjSdy/7gAgAh5]],
				Jaw = [[
					gAiidp/xgAgAjzgAijdp/wgAgAj5gAikdp/vgAgAj/gAildp/ugAgAkEgAildp/ugAgAkHgAildp/ugAgAkIgAildp/ugAgAkHgAildp/ugAgAkEgAikdp/v
					gAgAj/gAjQdt/9gAgAhRgAjMdr/+gAgAhMgAi3do/7gAgAiDgAiqdq/0gAgAjYgAirdn/8gAgAh1gAixdl/+gAgAfJgAi8do/2gAgAc/gAjDdn/ngAgAbKf5
					jDdo/mgNeObVfqjCdr/QgqafcCfhjDdt+qg6YIbhfgjDdu+tg8YEb9fhjDdu+wg+YEcZfgjGdt+rg7YDbwfhjFdu+wg+YEcXfwjGdq/hgfcAcWgXjHdq/MfW
					lqbwgfjFdu+xfCn8chgfjFdu+wfCn8cXggjGdt+rfFn9bwgfjDdu+yfDn3cagWi9dq/ZfflidfgHivdm/8f7hygMgAikdo/3gAgAi3gAigdo/zgAgAjhgAig
					do/zgAgAjegAigdo/zgAgAjdgAigdo/zgAgAjegAigdo/zgAgAjhgAihdo/ygAgAjmgAihdo/xgAgAjs]],
				Mane = [[
					gAkNesRegAgA8ggAkPerRYgAgA8dgAkQerRTgAgA8agAkReqRPgAgA8YgAkReqRMgAgA8WgAkReqRLgAgA8WgAkReqRMgAgA8WgAkReqRPgAgA8YgAkQerRT
					gAgA8agAkefRaigAgA/hgAkafObagAgA/qgAkSe/YhgAgA/GgAkQe0X6gAgA+8gAkKe6YUgAgA/DgAkBfIavgAgA/jgAj7fVekgAgA/9gAj0fbfOgAgA/+gE
					j1fbfThugg/7gLj6fXftlYhZ/ggQj5fVe4nliU++gQj8fUfFnsiN+9gPj/fTfTnviE+9gQj9fUegnpiY+8gPkBfTe7ntiK+9gIkAfYfEj5hE/uf1j+fXeYak
					eT/cfxkCfTe/YSd5+9fxkBfTe7YTd2+9fwj9fUegYXdo+8fxj/fTetYYd1+9f2kAfPbaaueR/Kf9kGfCWgeUfa+fgAkKeySxgAgA9IgAkKetRugAgA8ngAkJ
					etRwgAgA8pgAkJetRxgAgA8pgAkJetRwgAgA8pgAkKetRugAgA8ngAkLetRpgAgA8lgAkMesRkgAgA8j]],
				["UpperLegF.L"] = [[
					fBhdfayiY/fD5GfBhdfaynZDfH5DfBhefZytZHfL5AfBhffZyyZKfN4+fBhffYy1ZMfP47fBhgfYy3ZNfQ47fBhffYy1ZMfP47fBhffZyyZKfN4+fBhefZyt
					ZHfL5AfBhxfYz1ZWfp4NfBhufZzgZQfh4cfBhlfay2ZDfN44fBhffbykY7fD5DfBhdfbyeY2e+5GfBhafcyYYye55JfBhafcyXYxe55JfBhafcyXYye55JfB
					hafcyYY0e75JfBhbfbyaY3e95JfBhcfbydY7fA5IfBhdfayiY/fD5GfBhdfaynZDfH5DfBhefZytZHfL5AfBhffZyyZKfN4+fBhffYy1ZMfP47fBhgfYy3ZN
					fQ47fBhffYy1ZMfP47fBhffZyyZKfN4+fBhefZytZHfL5AfBhdfaynZDfH5DfBhdfayiY/fD5GfBhcfbydY7fA5IfBhbfbyaY3e95JfBhafcyYY0e75JfBha
					fcyXYye55JfBhafcyXYxe55JfBhafcyXYye55JfBhafcyYY0e75JfBhbfbyaY3e95JfBhcfbydY7fA5I]],
				["LowerLegF.L"] = [[
					exg3fk9pcuhWrfeyg4fj9dczhPsAeyg5fi9Rc3hJseeyg5fi9Hc6hEs2eyg5fi9Ac8hAtGeyg6fh8+c9g/tMeyg5fi9Ac8hAtGeyg5fi9Hc6hEs2eyg5fi9R
					c3hJsee0hKfe79c+gevPezhIfg8bc8gtuUeyg/fj9UcyhKsVexg6fk9xcpharJexg4fl99cjhhqjexg1fm+Jcehnp+exg1fm+Lcchop3exg1fm+Kcdhop8ex
					g1fm+FcghlqKexg2fl9+ckhhqhexg2fl91cphcq+exg3fk9pcuhWrfeyg4fj9dczhPsAeyg5fi9Rc3hJseeyg5fi9Hc6hEs2eyg5fi9Ac8hAtGeyg6fh8+c9
					g/tMeyg5fi9Ac8hAtGeyg5fi9Hc6hEs2eyg5fi9Rc3hJseeyg4fj9dczhPsAexg3fk9pcuhWrfexg2fl91cphcq+exg2fl9+ckhhqhexg1fm+FcghlqKexg1
					fm+Kcdhop8exg1fm+Lcchop3exg1fm+Kcdhop8exg1fm+FcghlqKexg2fl9+ckhhqhexg2fl91cphcq+]],
				["FootF.L"] = [[
					eygjfN/lgPf+lIeygjfN/kgSf9lIeygjfN/kgVf9lIeygjfN/kgWf8lIeygjfN/kgXf8lIeygjfN/kgXf8lIeygjfN/kgXf8lIeygjfN/kgWf8lIeygjfN/k
					gVf9lIeygxfN/lgPf+lIeygvfN/kgRf9lIeygpfN/lgQf9lIeygmfN/lgLf+lIeygkfN/lgHf/lIeygjfN/lgDf/lIeygjfN/lgCgAlIeygjfN/lgDgAlIey
					gjfN/lgFf/lIeygjfN/lgIf/lIeygjfN/lgMf+lIeygjfN/lgPf+lIeygjfN/kgSf9lIeygjfN/kgVf9lIeygjfN/kgWf8lIeygjfN/kgXf8lIeygjfN/kgX
					f8lIeygjfN/kgXf8lIeygjfN/kgWf8lIeygjfN/kgVf9lIeygjfN/kgSf9lIeygjfN/lgPf+lIeygjfN/lgMf+lIeygjfN/lgIf/lIeygjfN/lgFf/lIeygj
					fN/lgDgAlIeygjfN/lgCgAlIeygjfN/lgDgAlIeygjfN/lgFf/lIeygjfN/lgIf/lIeygjfN/lgMf+lI]],
				["UpperLegF.R"] = [[
					g/hdfayinBg95Gg/hdfaynm9g55Dg/hefZytm5g15Ag/hffZyym2gz4+g/hffYy1m0gx47g/hgfYy3mzgw47g/hffYy1m0gx47g/hffZyym2gz4+g/hefZyt
					m5g15Ag/hxfYz1mqgX4Ng/hufZzgmwgf4cg/hlfay2m9gz44g/hffbyknFg95Dg/hdfbyenKhC5Gg/hafcyYnOhH5Jg/hafcyXnPhH5Jg/hafcyXnOhH5Jg/
					hafcyYnMhF5Jg/hbfbyanJhD5Jg/hcfbydnFhA5Ig/hdfayinBg95Gg/hdfaynm9g55Dg/hefZytm5g15Ag/hffZyym2gz4+g/hffYy1m0gx47g/hgfYy3mz
					gw47g/hffYy1m0gx47g/hffZyym2gz4+g/hefZytm5g15Ag/hdfaynm9g55Dg/hdfayinBg95Gg/hcfbydnFhA5Ig/hbfbyanJhD5Jg/hafcyYnMhF5Jg/ha
					fcyXnOhH5Jg/hafcyXnPhH5Jg/hafcyXnOhH5Jg/hafcyYnMhF5Jg/hbfbyanJhD5Jg/hcfbydnFhA5I]],
				["LowerLegF.R"] = [[
					hPg3fk9pjSeqrfhOg4fj9djNexsAhOg5fi9RjJe3sehOg5fi9HjGe8s2hOg5fi9AjEfAtGhOg6fh8+jDfBtMhOg5fi9AjEfAtGhOg5fi9HjGe8s2hOg5fi9R
					jJe3sehMhKfe79jCfivPhNhIfg8bjEfTuUhOg/fj9UjOe2sVhPg6fk9xjXemrJhPg4fl99jdefqjhPg1fm+JjieZp+hPg1fm+LjkeYp3hPg1fm+KjjeYp8hP
					g1fm+FjgebqKhPg2fl9+jcefqhhPg2fl91jXekq+hPg3fk9pjSeqrfhOg4fj9djNexsAhOg5fi9RjJe3sehOg5fi9HjGe8s2hOg5fi9AjEfAtGhOg6fh8+jD
					fBtMhOg5fi9AjEfAtGhOg5fi9HjGe8s2hOg5fi9RjJe3sehOg4fj9djNexsAhPg3fk9pjSeqrfhPg2fl91jXekq+hPg2fl9+jcefqhhPg1fm+FjgebqKhPg1
					fm+KjjeYp8hPg1fm+LjkeYp3hPg1fm+KjjeYp8hPg1fm+FjgebqKhPg2fl9+jcefqhhPg2fl91jXekq+]],
				["FootF.R"] = [[
					hOgjfN/lfxgClIhOgjfN/kfugDlIhOgjfN/kfrgDlIhOgjfN/kfqgElIhOgjfN/kfpgElIhOgjfN/kfpgElIhOgjfN/kfpgElIhOgjfN/kfqgElIhOgjfN/k
					frgDlIhOgxfN/lfxgClIhOgvfN/kfvgDlIhOgpfN/lfwgDlIhOgmfN/lf1gClIhOgkfN/lf5gBlIhOgjfN/lf9gBlIhOgjfN/lf+gAlIhOgjfN/lf9gAlIhO
					gjfN/lf7gBlIhOgjfN/lf4gBlIhOgjfN/lf0gClIhOgjfN/lfxgClIhOgjfN/kfugDlIhOgjfN/kfrgDlIhOgjfN/kfqgElIhOgjfN/kfpgElIhOgjfN/kfp
					gElIhOgjfN/kfpgElIhOgjfN/kfqgElIhOgjfN/kfrgDlIhOgjfN/kfugDlIhOgjfN/lfxgClIhOgjfN/lf0gClIhOgjfN/lf4gBlIhOgjfN/lf7gBlIhOgj
					fN/lf9gAlIhOgjfN/lf+gAlIhOgjfN/lf9gAlIhOgjfN/lf7gBlIhOgjfN/lf4gBlIhOgjfN/lf0gClI]],
				Tail1 = [[
					gAiAhLirgAgA/4gAiAhLirgOf+/4gAiAhLirgbf8/4gAiBhLirgof6/3gAiBhLirg0f4/3gAiBhLirg+f2/3gAiBhLirhHf1/3gAiBhLirhPf0/2gAiAhLir
					hUfz/2gAiOhLlXh0fq/fgAiNhLmJhXft/XgAiGhLlzgsf2/dgAiChLlmiEfg/bgAiBhLljg9fx/fgAh/hLldgof2/hgAh+hLlchxfk/egAh/hLlcgUf7/hgA
					h/hLlcgXf6/hgAh/hLlchMft/ggAh/hLlcfjgH/hgAiAhLlcgAgA/hgAiAhLlcgdf5/hgAiAhLlce0gT/ggAiBhLlcfpgG/hgAiBhLlcfsgF/hgAiBhLlceP
					gc/egAiBhLlcfYgK/hgAiBhLlcfDgP/ggAiAhLlcd8gg/dgAiAhLlKfQgL/kgAiAhLkbepgS/pgAh/hLjiecgS/wgAh/hLi3ewgN/1gAh/hLirexgM/2gAh/
					hLire5gL/3gAh+hLirfCgK/3gAh/hLirfMgI/3gAh/hLirfYgG/3gAh/hLirflgE/4gAh/hLirfygC/4]],
				Tail2 = [[
					gAh8hjkqfVgF/pgAh8hjkqfwgA/pgBh8hjkqgKf8/pgBh9hjkqglf4/pgBh9hjkqg+fz/ogBh9hjkqhWfw/ngCh9hjkqhsfs/mgCh9hjkqiAfp/lgCh8hjkq
					iQfn/kgDiGhipKjUfT+dgCiDhiqvihfZ+BgBh9hiqbhSfr+NgDh5hiqMkHe++BgBh4hiqLiDfg+QgBh2hiqGhefq+UgDh2hiqDj2fE+HgAh2hiqFhEfz+VgB
					h2hiqFhPfw+VgCh3hiqEi8fV+Of/h3hiqFfwgK+WgAh3hiqFgrf7+WgBh4hiqFhkft+Uf+h4hiqFeVgi+Uf/h4hiqGf9gH+XgAh5hiqGgBgG+Xf9h5hiqEdG
					g1+Nf/h5hiqFfUgQ+Wf/h4hiqFekgc+Uf9h4hiqDcThA+If/h4hjpiezgV+gf+h5hjoGdegl+1f+h6hjmWc+gm/Nf+h7hjlBddgc/ff+h7hjkqdagb/if+h6
					hjkqdigZ/jf/h6hjkqdtgX/kf/h6hjkqd8gU/lf/h7hjkqePgR/mf/h7hjkqekgN/ngAh7hjkqe8gJ/o]],
				Tail3 = [[
					f/h0h7l6eKgK/YgAh1h7l6etgE/agBh1h7l6fRf+/bgCh1h7l6f3f4/cgDh2h7l6gdfz/bgEh2h7l6hCft/bgEh2h7l6hmfo/ZgFh1h7l6iHfk/XgFh1h7l6
					ilfg/VgHh4h2sJkQfB9RgFhzh1udjKfI8WgDhuh2uKhffi8pgIhqh1t4lzej8MgEhph2t7i6fT8pgDhoh2t2iOfh8wgIhnh1tvl3es8QgChnh2t1h8fs8xgC
					hoh2t1iVfq8wgGhoh2txk9fE8bf/hoh2t2gYgN81gBhph2t1h1f58ygDhph2t0jPfl8rf8hph2t1eggv8zf/hqh2t2g8gK80gAhqh2t2hCgI80f6hqh2tzct
					hL8pf+hqh2t2f7gX81f9hqh2t2exgn8zf4hph1txbVha8df9hqh3tEe5gf9Lf6hth4q+cyg093f5hwh6oZb5g0+lf6hzh7mccdgm/If6hzh7l5cPgl/Nf7hz
					h7l5cQgj/Nf7hzh7l5cYgh/Of8hzh7l5clge/Qf8hzh7l6c3gZ/Sf9h0h7l6dPgV/Uf+h0h7l6drgQ/W]],
				Tail4 = [[
					f8hriSkgcxf8/gf+hsiSkgdWf3/kgAhsiSkgd/f0/ngChsiSkferfw/pgDhtiSkffZft/qgFhtiSkfgIfq/rgHhtiSkfg3fo/qgIhsiSkfhlfm/ogJhsiSkg
					iQfl/lgNhniHsmkjfC9CgJhgiDvpjNfB7tgEhaiFvXhGfX8CgPhXiDvFm9er7UgIhWiFvIjTfT7/gGhUiFvDilfh8GgPhUiDu6nke97QgEhUiGvDilfz8HgF
					hUiFvCjSf18DgMhViEu8m8fc7bgAhViGvDhEgZ8NgDhViGvBjKgM8EgHhWiFu+lKgA7yf6hWiFvCfBg88NgBhWiGvBiWgh8JgBhWiGvBiigh8If2hWiFvAc1
					hV8Cf+hWiGvChJgt8Nf7hWiGvCfkg58OfzhWiEu+a+hf7xf8hYiHuBfogt8vf2hdiLrRctg19vfzhkiOn3bYgq+qf1hpiRlPb/ga/Tf1hqiRkgbggW/Wf1hq
					iRkgbXgT/Vf2hqiRkgbUgQ/Uf3hqiSkgbZgM/Vf4hqiSkgblgI/Xf5hriSkgb4gE/Zf7hriSkgcSgA/d]],
				Tail5 = [[
					f3hlipjCbkfe/if6hliqjBcEfa/mf9hliqjBcqfX/qf/hmiqjAdWfW/ugChmiqjAeFfV/ygFhmiqjAe4fV/0gIhmiqi/ftfX/2gKhmiqi/gifZ/1gMhlipjA
					hWfd/0gThViXs/kQe185gNhKiPwviqel7GgFhFiSwdgKey7agYhDiOwMnbet6igMhBiSwPjFfE7XgJhAiTwLiXfU7fgYhAiPwDonfS6SgIhAiTwLiufy7dgK
					hAiTwKjzf/7WgVhBiQwDobgD6XgBhAiUwLhggl7jgIhBiTwIkQgs7SgOhCiSwEm3gy6yf6hBiTwJflhR7lgEhCiTwHjzhP7WgFhCiTwGkLhV7TfyhCiSwHdT
					hs7dgAhCiUwHiqhg7ef7hCiTwHgzhl7lfthBiRwFbLhx7Lf8hEiXu4g4hY8RfyhMidrfdQhG9tfthYijnQbigo+1fvhhioj9cMgT/hfuhjiojCbdgH/hfuhj
					iojCbGgB/dfvhjiojDa3f6/bfwhjiojDawfz/afxhkipjDaxft/afzhkipjDa6fn/bf1hkipjCbLfi/e]],
				["UpperLegB.L"] = [[
					fBhegz44W8fzx9fBhegz4zXAf2yFfBhegz4vXEf5yNfBhfgz4sXIf7yTfBhfgz4qXKf9yXfBhfgz4pXLf9yYfBhfgz4qXKf9yXfBhfgz4sXIf7yTfBhegz4v
					XEf5yNfBhtgx4XXdf6y5fBhrgy4fXVf2yrfBhkgy4wXEfyyMfBhggz46W5fvx4fBhfgz4/W0fsxvfBhdgz5EWvfrxmfBhcgz5EWufrxkfBhcgz5EWvfrxlfB
					hdgz5CWxfsxofBhdgz4/W0fuxufBhdgz48W3fxx1fBhegz44W8fzx9fBhegz4zXAf2yFfBhegz4vXEf5yNfBhfgz4sXIf7yTfBhfgz4qXKf9yXfBhfgz4pXL
					f9yYfBhfgz4qXKf9yXfBhfgz4sXIf7yTfBhegz4vXEf5yNfBhegz4zXAf2yFfBhegz44W8fzx9fBhdgz48W3fxx1fBhdgz4/W0fuxufBhdgz5CWxfsxofBhc
					gz5EWvfrxlfBhcgz5EWufrxkfBhcgz5EWvfrxlfBhdgz5CWxfsxofBhdgz4/W0fuxufBhdgz48W3fxx1]],
				["LowerLegB.L"] = [[
					e0g7gkvveJgW7ye0g7glv8eFgV7qe0g7glwIeBgU7je0g7glwRd+gT7ee0g7gmwXd8gT7ae0g7gmwZd7gT7Ye0g7gmwXd8gT7ae0g7glwRd+gT7ee0g7glwI
					eBgU7je0hJglwPeDgI7fe0hIglwAeIgK7pe0hBgkvqeOgR71e0g9gkvbeRgV7+e0g8gkvReUgW8Ee0g6gjvKeWgY8He0g6gjvIeWgY8Je0g6gjvJeVgY8Ie0
					g6gjvPeUgX8Ee0g6gkvYeRgX8Ae0g7gkvjeNgW75e0g7gkvveJgW7ye0g7glv8eFgV7qe0g7glwIeBgU7je0g7glwRd+gT7ee0g7gmwXd8gT7ae0g7gmwZd7
					gT7Ye0g7gmwXd8gT7ae0g7glwRd+gT7ee0g7glwIeBgU7je0g7glv8eFgV7qe0g7gkvveJgW7ye0g7gkvjeNgW75e0g6gkvYeRgX8Ae0g6gjvPeUgX8Ee0g6
					gjvJeVgY8Ie0g6gjvIeWgY8Je0g6gjvJeVgY8Ie0g6gjvPeUgX8Ee0g6gkvYeRgX8Ae0g7gkvjeNgW75]],
				["FootB.L"] = [[
					eygjgz/jgWf8lReygjgz/jgTf9lReygjgz/jgQf9lReygjgz/jgOf+lReygjgz/jgMf+lReygjgz/jgLf+lReygjgz/jgMf+lReygjgz/jgOf+lReygjgz/j
					gQf9lReygxgz/jgLf+lReygvgz/jgPf9lReygpgz/jgWf8lReygmgz/jgaf8lReygkgz/jgdf7lReygjgz/jgff7lReygjgz/jgff7lReygjgz/jgff7lRey
					gjgz/jgdf7lReygjgz/jgbf7lReygjgz/jgZf8lReygjgz/jgWf8lReygjgz/jgTf9lReygjgz/jgQf9lReygjgz/jgOf+lReygjgz/jgMf+lReygjgz/jgL
					f+lReygjgz/jgMf+lReygjgz/jgOf+lReygjgz/jgQf9lReygjgz/jgTf9lReygjgz/jgWf8lReygjgz/jgZf8lReygjgz/jgbf7lReygjgz/jgdf7lReygj
					gz/jgff7lReygjgz/jgff7lReygjgz/jgff7lReygjgz/jgdf7lReygjgz/jgbf7lReygjgz/jgZf8lR]],
				["UpperLegB.R"] = [[
					g/hegz44pEgNx9g/hegz4zpAgKyFg/hegz4vo8gHyNg/hfgz4so4gFyTg/hfgz4qo2gDyXg/hfgz4po1gDyYg/hfgz4qo2gDyXg/hfgz4so4gFyTg/hegz4v
					o8gHyNg/htgx4XojgGy5g/hrgy4forgKyrg/hkgy4wo8gOyMg/hggz46pHgRx4g/hfgz4/pMgUxvg/hdgz5EpRgVxmg/hcgz5EpSgVxkg/hcgz5EpRgVxlg/
					hdgz5CpPgUxog/hdgz4/pMgSxug/hdgz48pJgPx1g/hegz44pEgNx9g/hegz4zpAgKyFg/hegz4vo8gHyNg/hfgz4so4gFyTg/hfgz4qo2gDyXg/hfgz4po1
					gDyYg/hfgz4qo2gDyXg/hfgz4so4gFyTg/hegz4vo8gHyNg/hegz4zpAgKyFg/hegz44pEgNx9g/hdgz48pJgPx1g/hdgz4/pMgSxug/hdgz5CpPgUxog/hc
					gz5EpRgVxlg/hcgz5EpSgVxkg/hcgz5EpRgVxlg/hdgz5CpPgUxog/hdgz4/pMgSxug/hdgz48pJgPx1]],
				["LowerLegB.R"] = [[
					hMg7gkvvh3fq7yhMg7glv8h7fr7qhMg7glwIh/fs7jhMg7glwRiCft7ehMg7gmwXiEft7ahMg7gmwZiFft7YhMg7gmwXiEft7ahMg7glwRiCft7ehMg7glwI
					h/fs7jhMhJglwPh9f47fhMhIglwAh4f27phMhBgkvqhyfv71hMg9gkvbhvfr7+hMg8gkvRhsfq8EhMg6gjvKhqfo8HhMg6gjvIhqfo8JhMg6gjvJhrfo8IhM
					g6gjvPhsfp8EhMg6gkvYhvfp8AhMg7gkvjhzfq75hMg7gkvvh3fq7yhMg7glv8h7fr7qhMg7glwIh/fs7jhMg7glwRiCft7ehMg7gmwXiEft7ahMg7gmwZiF
					ft7YhMg7gmwXiEft7ahMg7glwRiCft7ehMg7glwIh/fs7jhMg7glv8h7fr7qhMg7gkvvh3fq7yhMg7gkvjhzfq75hMg6gkvYhvfp8AhMg6gjvPhsfp8EhMg6
					gjvJhrfo8IhMg6gjvIhqfo8JhMg6gjvJhrfo8IhMg6gjvPhsfp8EhMg6gkvYhvfp8AhMg7gkvjhzfq75]],
				["FootB.R"] = [[
					hOgjgz/jfqgElRhOgjgz/jftgDlRhOgjgz/jfwgDlRhOgjgz/jfygClRhOgjgz/jf0gClRhOgjgz/jf1gClRhOgjgz/jf0gClRhOgjgz/jfygClRhOgjgz/j
					fwgDlRhOgxgz/jf1gClRhOgvgz/jfxgDlRhOgpgz/jfqgElRhOgmgz/jfmgElRhOgkgz/jfjgFlRhOgjgz/jfhgFlRhOgjgz/jfhgFlRhOgjgz/jfhgFlRhO
					gjgz/jfjgFlRhOgjgz/jflgFlRhOgjgz/jfngElRhOgjgz/jfqgElRhOgjgz/jftgDlRhOgjgz/jfwgDlRhOgjgz/jfygClRhOgjgz/jf0gClRhOgjgz/jf1
					gClRhOgjgz/jf0gClRhOgjgz/jfygClRhOgjgz/jfwgDlRhOgjgz/jftgDlRhOgjgz/jfqgElRhOgjgz/jfngElRhOgjgz/jflgFlRhOgjgz/jfjgFlRhOgj
					gz/jfhgFlRhOgjgz/jfhgFlRhOgjgz/jfhgFlRhOgjgz/jfjgFlRhOgjgz/jflgFlRhOgjgz/jfngElR]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAh+grAMfLgFjKgAh/grAMfQgdjJgAiBgrAMfcgyjJgAiEgrAMfrhAjJgAiFgrAMf+hHjJgAiFgrAMgQhFjKgAiEgrAMghg7jKgAiBgrAMgtgqjLgAh/grAM
					g1gTjKgAh+grAMg1f7jKgAh/grAMgwfjjJgAiBgrAMgkfOjJgAiEgrAMgVfAjJgAiFgrAMgCe5jJgAiFgrAMfwe7jKgAiEgrAMfffFjKgAiBgrAMfTfWjLgA
					h/grAMfLftjK]],
				Spine1 = [[
					gAiCgWALflgDjKf/iDgWALfogSjJf/iFgXALfugfjJf/iIgXALf2gojJf/iJgXALgAgsjJf/iJgXALgJgrjKf/iIgXALgRgljKf/iFgXALgXgbjLgAiDgWAL
					gbgNjKgAiCgWALgbf9jKgBiDgWALgYfujJgBiFgXALgSfhjJgBiIgXALgKfYjJgBiJgXALgAfUjJgBiJgXALf3fVjKgBiIgXALfvfbjKgBiFgXALfpfljLgA
					iDgWALflfzjK]],
				Spine2 = [[
					gAiGgCACgAgAgzf/iHgCACgAgGgzf+iJgCACgAgLgyf+iMgCACgAgPgyf+iOgCACgAgSgzf+iOgCACgAgSgzf+iMgCACgAgPg0f/iKgCACgAgLg0f/iHgCAC
					gAgGg0gAiGgCACgAgAgzgBiHgCACgAf6gzgCiJgCACgAf1gygCiMgCACgAfxgygCiOgCACgAfugzgCiOgCACgAfugzgCiMgCACgAfxg0gBiKgCACgAf1g0gB
					iHgCACgAf6g0]],
				Spine3 = [[
					gAiHftACgbf/gzf/iIftACgZf8gzf+iKftACgUf6gyf9iNftACgNf4gyf9iPftACgEf3gzf9iPftACf7f3gzf+iNftACfyf5g0f+iLftACfrf7g0f/iIftAC
					fnf+g0gAiHftACflgBgzgBiIftACfngEgzgCiKftACfsgGgygDiNftACfzgIgygDiPftACf8gJgzgDiPftACgFgJgzgCiNftACgOgHg0gCiLftACgVgFg0gB
					iIftACgZgCg0]],
				Neck1 = [[
					gAiJfYA7gaf6nkf/iJfYA5gWfunZf+iLfYA5gPflnbf+iOfYA8gGffnof9iQfYBBf8fdn6f+iQfYBFf0ffoJf+iOfYBGfsfloNf/iMfYBEfnfvoGf/iJfYBA
					flf6n1gAiJfYA7fmgGnkgBiJfYA5fqgSnZgCiLfYA5fxgbnbgCiOfYA8f6ghnogDiQfYBBgEgjn6gCiQfYBFgMghoJgCiOfYBGgUgboNgBiMfYBEgZgRoGgB
					iJfYBAgbgGn1]],
				Neck2 = [[
					gAibezB2gZf3qqgAicezBvgRfkqVf/ieezBwgGfTqZf/ihezB5f7fIqyf/ije0CGfwfErUf/ike0CRfofHrxf/ije0CVfifSr6f/ige0CPfgfhrrf/ide0CC
					fhf1rLgAibezB2fngJqqgAicezBvfvgcqVgBieezBwf6gtqZgBihezB5gFg4qygBije0CGgQg8rUgBike0CRgYg5rxgBije0CVgegur6gBige0CPgggfrrgB
					ide0CCgfgLrL]],
				Neck3 = [[
					gBiweZB3gZf3qrgBiweYBtgOfbqOgBizeZBvgAfDqSgBi2eZB8fzeyq4gAi5ebCQfoerrsgAi7ecChfgevsWgAi6ecCmfbe8sjgAi3ebCdfbfRsNf/izeaCJ
					fffsref/iweZB3fngJqrf/iweYBtfyglqOf/izeZBvgAg9qSf/i2eZB8gNhOq4gAi5ebCQgYhVrsgAi7ecChgghRsWgAi6ecCmglhEsjgAi3ebCdglgvsNgB
					izeaCJghgUre]],
				Head = [[
					gCjSdv/vgYgBj9gDjRdu/rgNgqkcgEjTdu/tf/hQkCgEjYdw/zfyhsi8gEjed0/5fmh5hqgDjhd2/7fdh1gygCjgd3/8fZhkgvgBjcd1/7fZhJhigAjXdy/3
					ffgmizf+jSdv/vfof/j9f9jRdu/rfzfWkcf8jTdu/tgBewkCf8jYdw/zgOeUi8f8jed0/5gaeHhqf9jhd2/7gjeLgyf+jgd3/8gnecgvf/jcd1/7gne3higA
					jXdy/3ghfaiz]],
				Jaw = [[
					gDigds/rgYgCkagEifds/mgMgqk5gEihdr/pf+hQkggFindq/wfwhsjagEitdp/3fkh4iHgDixdp/6fbh1hQgCiwdp/7fXhkhMgAisdq/5fYhIiAf/ildr/0
					fegmjRf9igds/rfof+kaf8ifds/mf0fWk5f8ihdr/pgCewkgf7indq/wgQeUjaf8itdp/3gceIiHf9ixdp/6gleLhQf+iwdp/7gpechMgAisdq/5goe4iAgB
					ildr/0gifajR]],
				Mane = [[
					gAkTeiPwf1gW7jgAkTeePzfUf77kf/kUegQZe2fi75f/kWemRSehfK8Wf+kXeuSEebe58uf+kWe0SVejew83f+kWe1R+e2ey8sf/kVexRKfPe+8Uf/kUepQT
					frfS72gAkTeiPwgLfq7jgAkTeePzgsgF7kgBkUegQZhKge75gBkWemRShfg28WgCkXeuSEhlhH8ugCkWe0SVhdhQ83gCkWe1R+hKhO8sgBkVexRKgxhC8UgB
					kUepQTgVgu72]],
				["UpperLegF.L"] = [[
					fAhgfYqsZrdc9Xe/hhfYtuZQdN79e/hjfXyDYyd05Ue+hlfX1sYje92Re+hmfX6mYug+wLe/hmfX6PY+hEw3fAhjfX53Y9g4xcfBhhfX2uY6fy1XfChefY08
					Y9fL3HfDhdfYzpZDez4PfDhefYy0ZLet47fEhgfYyfZTe25NfEhjfYyjZefK5OfEhlfYyrZrfg5LfEhmfYyTZ4ft5gfDhlfYxGaEfr6YfChjfYvhaOfl7XfB
					hhfYrkZ6eY9K]],
				["LowerLegF.L"] = [[
					euhIf19/eKiaqvethDfu/TdLjKlFesg/fi/gcpjFjIevg+fW/IcgiHmKe3hCfD7Ub9fEwHe4hBfF67cIfGwze4g+fG6jcFe1xXe0g5fT9CcagQs7ezg3fZ9o
					cbglrfezg3fe9rcZglrYe0g4fh9QcbgZsce0g7fi8XcjgEuZe1g+fi7Ectfqwue2g/fi5nc2fTy4e2hAfk4mdCfN0Oe2hAfn4Vdafe0me0hBfr4Td6f30tex
					hGf07ZeohSwZ]],
				["FootF.L"] = [[
					eyg1fe/Chsfmnieyg5fS+8gtf0oHeyg4fF++gFf/oBeygye6/Kf9gBnQeygoe0/ae7gNl7eygme3/XfDf6mOeygje6/ie8gKlOeygje+/kfrgDlIeygjfD/l
					fxgClIeygjfH/kfvgDlIeygjfM/kfugDlIeygjfQ/lfwgDlIeygjfV/lfwgDlIeygjfZ/kfvgDlIeygjfe/lf2gClIeygjfi/lgQf9lIeygjfn/kg1f3lIey
					grfl/Sh8fnmX]],
				["UpperLegF.R"] = [[
					g9hdfYzpm9hN4Pg9hefYy0m1hT47g8hgfYyfmthK5Ng8hjfYyjmig25Og8hlfYyrmVgg5Lg8hmfYyTmIgT5gg9hlfYxGl8gV6Yg+hjfYvhlygb7Xg/hhfYrk
					mGho9KhAhgfYqsmVik9XhBhhfYtumwiz79hBhjfXyDnOiM5UhChlfX1sndhD2RhChmfX6mnSfCwLhBhmfX6PnCe8w3hAhjfX53nDfIxcg/hhfX2unGgO1Xg+
					hefY08nDg13H]],
				["LowerLegF.R"] = [[
					hNg3fe9rjnfbrYhMg4fh9QjlfnschMg7fi8Xjdf8uZhLg+fi7EjTgWwuhKg/fi5njKgty4hKhAfk4mi+gz0OhKhAfn4Vimgi0mhMhBfr4TiGgJ0thPhGf07Z
					hYeuwZhShIf19/h2dmqvhThDfu/Ti1c2lFhUg/fi/gjXc7jIhRg+fW/Ijgd5mKhJhCfD7UkDg8wHhIhBfF67j4g6wzhIg+fG6jj7hLxXhMg5fT9Cjmfws7hN
					g3fZ9ojlfbrf]],
				["FootF.R"] = [[
					hOgjfH/kgRf9lIhOgjfM/kgSf9lIhOgjfQ/lgQf9lIhOgjfV/lgQf9lIhOgjfZ/kgRf9lIhOgjfe/lgKf+lIhOgjfi/lfwgDlIhOgjfn/kfLgJlIhOgrfl/S
					eEgZmXhOg1fe/CeUganihOg5fS+8fTgMoHhOg4fF++f7gBoBhOgye6/KgDf/nQhOgoe0/ahFfzl7hOgme3/Xg9gGmOhOgje6/ihEf2lOhOgje+/kgVf9lIhO
					gjfD/lgPf+lI]],
				Tail1 = [[
					gAh6hLiGg5gy/5gBh7hLh1gngw/7gCh9hLhtgQgo/8gCh/hLhxf4gb/8gCiBhLh/fhgL/7gCiBhLiQfNf6/5gCh/hLiee/fq/4gBh9hLige5fc/3gBh7hLiX
					e8fT/4gAh6hLiGfHfO/5f/h7hLh1fZfQ/7f+h9hLhtfwfY/8f+h/hLhxgIfl/8f+iBhLh/gff1/7f+iBhLiQgzgG/5f+h/hLiehBgW/4f/h9hLighHgk/3f/
					h7hLiXhEgt/4]],
				Tail2 = [[
					gCh3hjioiZgp/ygCh4hjiHhmgq/4gCh6hjhvgngm/7gCh9hjhrfjgd/8gBh+hjh9ejgQ/5gBh9hjiddugB/0gAh8hji7dKfz/uf/h5hjjKc8fo/rf/h3hjjC
					dGfe/tf+h3hjiodnfX/yf+h4hjiHeafW/4f+h6hjhvfZfa/7f+h9hjhrgdfj/8f/h+hjh9hdfw/5f/h9hjidiSf//0gAh8hji7i2gN/ugBh5hjjKjEgY/rgB
					h3hjjCi6gi/t]],
				Tail3 = [[
					gFhzh8ijkRgg/mgEh1h8h4jMgj/xgDh4h8hQhvgh/6gBh6h8g9gEga/+f/h7h8hJeZgO/7f9h6h8huc7gB/zf8h3h7iab0f1/nf7h0h7i6bNfs/ff6hyh7i9
					bLfl/ef7hzh8ijbvfg/mf8h1h8h4c0fd/xf9h4h8hQeRff/6f/h6h8g9f8fm/+gBh7h8hJhnfy/7gDh6h8hujFf//zgEh3h7iakMgL/ngFh0h7i6kzgU/fgG
					hyh7i9k1gb/e]],
				Tail4 = [[
					gMhviTf1mHg8/YgJhyiUfJlDg2/kgGh2iVeUjYgr/wgBh5iVdwhTga/4f9h5iUdtfFgD/5f5h3iUeNc+fr/yf1hziTfBbOfW/nfzhwiSfxaCfI/afzhuiSgF
					ZlfD/Uf0hviTf1Z5fE/Yf3hyiUfJa9fK/kf6h2iVeUcofV/wf/h5iVdwetfm/4gDh5iUdtg7f9/5gHh3iUeNjCgV/ygLhziTfBkygq/ngNhwiSfxl+g4/agN
					huiSgFmbg9/U]],
				Tail5 = [[
					gVhviqc+nhhu+5gRhziscbmyhg/BgLh5itbjlOhK/OgDh8itaxjCgs/af7h9itadgegG/gf0h6isavd3fc/efuh1irbgbhe2/VfqhwipcYZteb/Hfphuipc9
					YqeP+8frhviqc+YfeS+5fvhziscbZOeg/Bf1h5itbjaye2/Of9h8itaxc+fU/agFh9itadfif6/ggMh6isaviJgk/egSh1irbgkfhK/VgWhwipcYmThl/HgX
					huipc9nWhx+8]],
				["UpperLegB.L"] = [[
					fDhWgx72VpeWrvfDhXgy7oV9eLsefDhagz7KWieRt5fDhdg06cXQekvqfChgg15pX7e7xTfBhhg14+YSfJyafBhhg04iYQfPy/fAhfgz4GYGfXzffAhdgy3X
					YDfo0We/hdgx2PYTgH1re/hdgv0jY7gx3dfAhfguxZachu6NfAhhgtwNamh66+fBhhgs0hXdgw2/fBhggs3GVZf7zbfChdgt5qTue+unfDhagu7gTPeEp/fD
					hXgv8OUEdwo6]],
				["LowerLegB.L"] = [[
					e2g+gU0Qcyf24je1g+gWzpdXfx5He1g+gbzldvfs5Me1g+ggz1d5fk5Ae1g+gkz8d+fc47e1g+gnzVePff5be0g9gpxveufs6lezg7gpvpfOf775eyg4gqtu
					fggD85ezg3gtsmfZgD9Ze0g3gys0euf+9Se3g7g8vyc8fo7pe3g+g+vYckfs72eyg8gumgfef8/Uexg9gijEgVfW/1eyhBgWkRf/eq/re0hGgOp7esey+Xe2
					hGgOv0djfi7s]],
				["FootB.L"] = [[
					eygjgZ/ifNgJlReygjgd/jfkgFlReygjgi/jfzgClReygjgm/jf3gClReygjgq/jf2gClReygjgv/jgDgAlReygjgz/jgef7lReygjg4/ig5f2lReygjg8/i
					hGf0lReygjhB/ig+f2lReygjhF/jgaf8lReygjhK/ie/gLlReygmhN/cetgPlxeygwhI/Kgvf1nNeyg4g9+7g+fwoHeyg5gx+4gYf6oWeyg2gl+/fogGn6ey
					gugc/PfagIm1]],
				["UpperLegB.R"] = [[
					hBhdgx2Pntf51rhBhdgv0jnFfP3dhAhfguxZlkeS6NhAhhgtwNlaeG6+g/hhgs0hojfQ2/g/hggs3GqngFzbg+hdgt5qsShCung9hagu7gsxh8p/g9hXgv8O
					r8iQo6g9hWgx72qXhqrvg9hXgy7oqDh1seg9hagz7Kpehvt5g9hdg06cowhcvqg+hgg15poFhFxTg/hhg14+nug3yag/hhg04inwgxy/hAhfgz4Gn6gpzfhA
					hdgy3Xn9gY0W]],
				["LowerLegB.R"] = [[
					hNg3gtsmgnf99ZhMg3gys0hSgC9ShJg7g8vyjEgY7phJg+g+vYjcgU72hOg8gumggigE/UhPg9gijEfrgq/1hOhBgWkRgBhW/rhMhGgOp7hUhO+XhKhGgOv0
					idge7shKg+gU0QjOgK4jhLg+gWzpipgP5HhLg+gbzliRgU5MhLg+ggz1iHgc5AhLg+gkz8iCgk47hLg+gnzVhxgh5bhMg9gpxvhSgU6lhNg7gpvpgygF75hO
					g4gqtuggf985]],
				["FootB.R"] = [[
					hOgjhB/ifCgKlRhOgjhF/jfmgElRhOgjhK/ihBf1lRhOgmhN/chTfxlxhOgwhI/KfRgLnNhOg4g9+7fCgQoHhOg5gx+4fogGoWhOg2gl+/gYf6n6hOgugc/P
					gmf4m1hOgjgZ/igzf3lRhOgjgd/jgcf7lRhOgjgi/jgNf+lRhOgjgm/jgJf+lRhOgjgq/jgKf+lRhOgjgv/jf9gAlRhOgjgz/jfigFlRhOgjg4/ifHgKlRhO
					gjg8/ie6gMlR]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAiPgrAEgAgAh1gAiFgrADgDgVhhgAh+grAHgEgiiUgAiDgrALgDgijHgAiOgrAJgCgVi0gAiPgrAEgAgAh1gAiFgrADf9frhhgAh+grAHf8feiUgAiDgrAL
					f9fejHgAiOgrAJf+fri0]],
				Spine1 = [[
					gAiSgWAGgAgAiMgAiHgWADgDgVhcf/iBgWAFgEgih6f/iHgWAKgDgii8gAiSgWALgCgVjHgAiSgWAGgAgAiMgAiHgWADf9frhcgBiBgWAFf8feh6gBiHgWAK
					f9fei8gAiSgWALf+frjH]],
				Spine2 = [[
					gAiVgBABgAgAgNf/iJgBACgBgVfBf/iDgBACgBgifIf/iLgCABgBgigaf/iWgBACgBgVhEgAiVgBABgAgAgNgBiJgBACf/frfBgBiDgBACf/fefIgBiLgCAB
					f/fegagBiWgBACf/frhE]],
				Spine3 = [[
					gAiVfsABgAgAgkf/iIfsACgBgVe8f+iCfsADgAgieuf+iLftABgAgigOf/iXftADgBgVhYgAiVfsABgAgAgkgBiIfsACf/fre8gCiCfsADgAfeeugCiLftAB
					gAfegOgBiXftADf/frhY]],
				Neck1 = [[
					gAiWfXBOgAgAotf+iGfXAqgGgUmZf9iAfXAhgIghlof9iMfYA6gIghnff+iZfYBbgHgUpYgAiWfXBOgAgAotgCiGfXAqf6fsmZgDiAfXAhf4fflogDiMfYA6
					f4ffnfgCiZfYBbf5fspY]],
				Neck2 = [[
					gAire0C0gAgAtEf+iXexBrgJgTqKf8iPexBSgLggo4f8ifezCAgMggrEf+iwe2DEgJgTtngAire0C0gAgAtEgCiXexBrf3ftqKgEiPexBSf1fgo4gEifezCA
					f0fgrEgCiwe2DEf3fttn]],
				Neck3 = [[
					gAjEeeDbgAgAuYf9ireXB6gJgTq1f7iheUBUgLggpBf7i0eaCMgMggrkf9jKegDqgKgSu0gAjEeeDbgAgAuYgDireXB6f3ftq1gFiheUBUf1fgpBgFi0eaCM
					f0fgrkgDjKegDqf2fuu0]],
				Head = [[
					gAjvd+ACgAgAgzf8jNdtAHgBgVdif6i+dnARf+gicFf6jYdyAEf+giedf9j2eCADgBgVhXgAjvd+ACgAgAgzgEjNdtAHf/frdigGi+dnARgCfecFgGjYdyAE
					gCfeedgDj2eCADf/frhX]],
				Jaw = [[
					gAjAds/4gAgAisf8icdl/bgCfrl7f5iMdk/IgGffnWf5iodn/lgFfelBf8jIdu/6gBfriHgAjAds/4gAgAisgEicdl/bf+gVl7gHiMdk/If6ghnWgHiodn/l
					f7gilBgEjIdu/6f/gViH]],
				Mane = [[
					gAkefBWpgAgA+lf+kJelUjgUgF93f7j+eaS2gggM9Jf8kRetT0gfgN9kf+kifGWLgUgG+cgAkefBWpgAgA+lgCkJelUjfsf793gFj+eaS2fgf09JgEkRetT0
					fhfz9kgCkifGWLfsf6+c]],
				["UpperLegF.L"] = [[
					fBhsfYs2a5f+82fAhdfdmqaBcp+he/hXffxqYLbc5Fe/hifb27YZdo02e/hvfY78YtgZtvfBhsfY7rYegxuJfDhdfb5tXbgExAfEhXfbx+X9eb5KfEhifXvf
					ZUfk7LfDhvfVwwbVhP60]],
				["LowerLegF.L"] = [[
					e1hNfy0MeNfO4vevhOgB+WdYiWpfeog2fq+Xacj8Ynetg8fV/mbuiKeve4hPe98qcIewtoe6hLe+8bb4fEuEe3g5fJ8oa5fGtTexgzfl+VbLhpoxe1hAfq5S
					c9gTzWe6hKfmxOdIef6w]],
				["FootF.L"] = [[
					eygwf4/Og1f0m7eyg9fo+1g0fyogeyhCfQ+XbuhRpBeyg+e3+vedgcosezg4eq+3fGfxoWe1g0es+ze3fPoheygje1/gd6gWlHeygjfL/jexgNlIeygjfh/l
					gEf/lIe0gvfy+HfHfFqs]],
				["UpperLegF.R"] = [[
					g/hsfY7rnifPuJg9hdfb5tolf8xAg8hXfbx+oDhl5Kg8hifXvfmsgc7Lg9hvfVwwkrex60g/hsfYs2lHgC82hAhdfdmql/jX+hhBhXffxqn1kk5FhBhifb27
					nniY02hBhvfY78nTfntv]],
				["LowerLegF.R"] = [[
					hGhLe+8bkIg8uEhJg5fJ8olHg6tThPgzfl+Vk1eXoxhLhAfq5SjDftzWhGhKfmxOi4hh6whLhNfy0Mhzgy4vhRhOgB+WiodqpfhYg2fq+XlkcEYnhTg8fV/m
					kSd2evhIhPe98qj4hQto]],
				["FootF.R"] = [[
					hLg0es+zhJgxohhOgje1/giGfqlHhOgjfL/jhPfzlIhOgjfh/lf8gBlIhMgvfy+Hg5g7qshOgwf4/OfLgMm7hOg9fo+1fMgOoghOhCfQ+XkSevpBhOg+e3+v
					hjfkoshNg4eq+3g6gPoW]],
				Tail1 = [[
					gAiOhLikgAgA/4gBiEhLg9frgC/+gBh7hLhWfegD/9gBh/hLjMfef//1gBiKhLj8frf9/vgAiOhLikgAgA/4f/iEhLg9gVf+/+f/h7hLhWgif9/9f/h/hLjM
					gigB/1f/iKhLj8gVgD/v]],
				Tail2 = [[
					gAiKhklDgegA/lgAiDhkiZfegE/5gAh5hkhueqgJ/6gAh6hjj+eXgC/sgAiEhjmBesf8/ZgAiKhklDfigA/lgAiDhkiZgif8/5gAh5hkhuhWf3/6gAh6hjj+
					hpf+/sgAiEhjmBhUgE/Z]],
				Tail3 = [[
					gBiCh7myhVgD/Pf/h/h8jwfwgF/xf+h2h8hxeQgL/5f+h0h7jndbgB/rf+h7h6mtdlf4/Mf/iCh7myerf9/PgBh/h8jwgQf7/xgCh2h8hxhwf1/5gCh0h7jn
					ilf//rgCh7h6mtibgI/M]],
				Tail4 = [[
					gDh4iSleiYgX/bf/h5iUi1gdgL/3f7h0iVfyeUgE/8f6huiTglc1fu/1f6hxiQkGclff/if9h4iSledofp/bgBh5iUi1fjf1/3gFh0iVfyhsf8/8gGhuiTgl
					jLgS/1gGhxiQkGjbgh/i]],
				Tail5 = [[
					gGhvipjdjXg6/ngAh1ith1hagh/5f5h0iteZe2gG/7f1htird5cvfc/vf1hriohBb7e8/sf6hvipjdcpfG/ngAh1ith1emff/5gHh0iteZhKf6/7gLhtird5
					jRgk/vgLhriohBkFhE/s]],
				["UpperLegB.L"] = [[
					fBhrg066X5hNvOfBhhg25hYKg5xmfBhZg15+Waexv+fBhegz0yZFf+3UfBhpgzvXbyhV7tfBhrg0uSbahf8OfBhhgz07V/f42BfBhZgw4ySMeUurfBhegv8Y
					S4dSmNfBhpgw7GW4gWuV]],
				["LowerLegB.L"] = [[
					e6hKge7laxfpvVe4g+gm6Ja2fHxrezg6ghu8fAgN8Re1g4g1t0ebfG8ze6hIhHvmdJe+7xe5hLhKujcqfG8Sewg9gxgVhFey/8eug/gZd7h2c4/te1hTgKtK
					eTfe9Ge4hLgY6+aQfYwM]],
				["FootB.L"] = [[
					e1gzgP+nddfno8eygkgb/UdPgUl7eygjgw/ig4f3lReygjhH/jfrgElRe1gwhV9lenfIsEezg1ha+eeUf9pleyg9hN+whPfqoteyhCg1+mgyfxpUeyg+gd+u
					f5gCo6eygzgK+6clg1ne]],
				["UpperLegB.R"] = [[
					g/hrg0uSkmeh8Og/hhgz07qBgI2Bg/hZgw4yt0hsurg/hegv8YtIiumNg/hpgw7GpIfquVg/hrg066oHezvOg/hhg25hn2fHxmg/hZg15+pmhPv+g/hegz0y
					m7gC3Ug/hpgzvXkOer7t]],
				["LowerLegB.R"] = [[
					hHhLhKujjWg68ShQg9gxgVe7hO/8hSg/gZd7eKjI/thLhTgKtKhtgi9GhIhLgY6+lwgowMhGhKge7llPgXvVhIg+gm6JlKg5xrhNg6ghu8hAfz8RhLg4g1t0
					hlg68zhGhIhHvmi3hC7x]],
				["FootB.R"] = [[
					hNg1ha+ehsgDplhOg9hN+wexgWothOhCg1+mfOgPpUhOg+gd+ugHf+o6hOgzgK+6jbfLnehLgzgP+nijgZo8hOgkgb/Uixfsl7hOgjgw/ifIgJlRhOgjhH/j
					gVf8lRhLgwhV9lhZg4sE]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAiFgrALgAgAjKgAiEguAKgAgAjBgAiCg1AIgAgAipgAh/g+AGgAgAiLgAh8hGAEgAgAhwgAh7hKADgAgAhggAh8g7AEgAgAhzgAiAgFAIgAgAiogAiAf8AM
					gAgAjSgAiAf8ATgAgAkRgAiAf8AQgAgAj6gAiAf+ALgAgAjPgAiBgFAKgAgAjCgAiCgSALgAgAjIgAiDgfALgAgAjLgAiFgpALgAgAjLgAiFgrALgAgAjKgA
					iFgrALgAgAjKgAiFgrALgAgAjK]],
				Spine1 = [[
					gAiJgWALgAgAjKgAiIgZAKgAgAi+gAiFggAHgAgAifgAiCgpAEgAgAh2gAh+gxADgAgAhSgAh9g1ACgAgAg9gAh+glADgAgAhYgAiEfwAIgAgAingAiEfnAM
					gAgAjSgAiFfoATgAgAkRgAiFfoAQgAgAj6gAiEfpALgAgAjPgAiFfwAKgAgAjCgAiGf9ALgAgAjIgAiIgKALgAgAjLgAiJgUALgAgAjLgAiJgWALgAgAjKgA
					iJgWALgAgAjKgAiJgWALgAgAjK]],
				Spine2 = [[
					gAiNgCACgAgAgzgAiMgEABgAgAgkgAiJgLABgAgAf9gAiEgTACgAgAfKgAiAgbADgAgAedgAh+ggAFgAgAeDgAiAgQADgAgAengAiHfbABgAgAgQgAiIfTAC
					gAgAg8gAiLfTAFgAgAh7gAiKfTADgAgAhjgAiIfUACgAgAg4gAiJfbABgAgAgsgAiKfoACgAgAgygAiMf1ACgAgAg1gAiNf/ACgAgAg1gAiNgCACgAgAgzgA
					iNgCACgAgAgzgAiNgCACgAgAgz]],
				Spine3 = [[
					gAiOftACgAgAgzgAiNfvABgAgAghgAiIf2ABgAgAfygAiDf/ACgAgAe1gAh+gHAFgAgAd+gAh7gLAHgAgAdggAh+f7AEgAgAeMgAiHfGABgAgAgPgAiKe+AC
					gAgAg8gAiNe+AFgAgAh7gAiMe+ADgAgAhjgAiJe/ACgAgAg4gAiKfHABgAgAgsgAiLfTACgAgAgygAiNfgACgAgAg1gAiOfqACgAgAg1gAiOftACgAgAgzgA
					iOftACgAgAgzgAiOftACgAgAgz]],
				Neck1 = [[
					gAiPfYA6gAgAnigAiNfaA0gAgAnGgAiIfhAlgAgAl9gAiBfqAVgAgAkegAh7fyALgAgAjIgAh4f2AHgAgAiXgAh8fmAMgAgAjUgAiIexAlgAgAl/gAiLepA7
					gAgAnlgAiQeqBmgAgAp8gAiOepBVgAgApFgAiLeqA5gAgAndgAiKeyAzgAgAnBgAiMe+A3gAgAnVgAiOfMA6gAgAnhgAiPfVA7gAgAnlgAiPfYA7gAgAnigA
					iPfYA6gAgAnigAiPfYA6gAgAni]],
				Neck2 = [[
					gAiiezB0gAgAqmgAife1BogAgAqBgAiXe7BLgAgAoggAiNfCAsgAgAmfgAiDfJAXgAgAkqgAh+fOAOgAgAjogAiFe+AYgAgAk1gAiXeKBEgAgAoIgAieeEB0
					gAgAqkgAioeIDVgAgAuMgAikeHCugAgAs4gAideFBvgAgAqXgAiceMBigAgApugAifeZBsgAgAqPgAihenB0gAgAqjgAiiewB2gAgAqqgAiiezB1gAgAqmgA
					iiezB0gAgAqmgAiiezB0gAgAqm]],
				Neck3 = [[
					gAi3eZB0gAgAqmgAizeaBlgAgAp4gAioeeBBgAgAn7gAiaejAegAgAlXgAiNepAKgAgAjBgAiGetAEgAgAhtgAiPeeALgAgAjLgAindtA1gAgAnKgAizdqBy
					gAgAqfgAjDd0D/gAgAvbgAi9dwDFgAgAtqgAiydrBsgAgAqOgAiwdxBagAgApVgAizd/BpgAgAqEgAi2eNBzgAgAqhgAi3eWB3gAgAqsgAi3eZB1gAgAqmgA
					i3eZB0gAgAqmgAi3eZB0gAgAqm]],
				Head = [[
					gAjZdv/zgAgAjZgAjTdv/sgAgAkXgAjCdv/OgAgAm9gAisdx+TgAgAqQgAiXd19LgAgAtHgAiLd48bgAgAuqgAiZdq9PgAgAs9gAi/c9+8gAgAoJgAjUdA/3
					gFfUi0gAjwdX/egoedaggAjndO/3gYevdigAjSdA/0gEfZjSgAjNdF/ogBfrk0gAjTdU/wgCfuj2gAjXdj/0gBf1jTgAjZdt/1gAf8jMgAjZdv/0gAgAjYgA
					jZdv/zgAgAjZgAjZdv/zgAgAjZ]],
				Jaw = [[
					gAindq/8gAgAh2gAihdt/2gAgAi7gAiRd1/dgAgAlygAh9eB+lgAgApagAhseO9bgAgAskgAhjeV8ogAgAuRgAhueC9hgAgAsUgAiOdH/SgAgAmrgAiic5/w
					gHfUjzf/jJc5/7g2ekfEgAi6c3/9ggeygzgAihc7/vgFfZkAgAibdE/rgBfrkggAihdQ/0gBfujWgAildd/5gBf1iZgAindn/8gAf8h3gAindq/8gAgAh2gA
					indq/8gAgAh2gAindq/8gAgAh2]],
				Mane = [[
					gAkXejQPgAgA71gAkUefPZgAgA7VgAkLeUNNgAgA54gAj7eFKjgAgA3ugAjpd6IXgAgA1jgAjdd0HPgAgA0QgAjrdwJPgAgA2egAkKdcQjgAgA8AgCkRd2WZ
					gqgP+ggFkKelemhYg9/6gEkOeVbjhKgp/pgCkRd1VzgmgN+UgBkRdzTZgUgH9ZgBkTeGSygRgH9IgBkWeXRvgKgF8ogAkXeiQvgDgC8HgAkXekQQgAgA72gA
					kXejQPgAgA71gAkXejQPgAgA71]],
				["UpperLegF.L"] = [[
					fBhlfY0vZdgA3dfBhkfb0tZPfz3bfBhefk1WYtfc2rfBhYfv3EX8fL0pfBhSf55BXMfHx3fBhPf/6NWvfKv0fBhTft21XLd00efBheeyq3ZgcW9JfBhheovt
					Z2fP7LfBhmenx5aPf554fBhkenw+aFfo6dfBhheqvuZ0fO7KfBhheytXZleE8SfBhje+s7ZedK8YfBhkfLv9ZWeR63fBhlfV0GZdf04BfBhlfY0wZdgA3dfB
					hlfY0vZdgA3dfBhlfY0vZdgA3d]],
				["LowerLegF.L"] = [[
					e1g+fb7Ac5gAw2e0g8fe78cygUvPezg3fk9kcSgzrneygyfo+nbhg5oGezgufp+8a3ggmTezgufq+7ajgCmHeugufm/dafhygjevhGfP/FcGiZmAezg+e768
					d4gtxGe1hAe04idrfp0Ze0hAe35kdzgFzGezg+e87Fd2gww4ewhDfK9hdlhtr8evhGfX+ycyiJnwewhCfd+AdKhqqle0g+fa7ZdAgPwPe1g+fb7Ac5gAw3e1
					g+fb7Ac5gAw2e1g+fb7Ac5gAw2]],
				["FootF.L"] = [[
					eygjfN/lgAgAlIeygjfN/lgBgAlIeygjfN/kfrgDlIeygjfN/je6gLlIeygjfN/heGgUlHeygjfN/fdqgYlHeygtfI/fdtgYlHeyg6ez/lf1gClIeygjeu/j
					hHf1lIeygjeu/kgkf6lIeygjeu/kg1f3lIeygjev/jhGf1lIeygte0/jhKf0lIeyg3e8/kgff7lIeygvfF/kgvf4lIeygjfL/lgLf+lIeygjfN/lgAgAlIey
					gjfN/lgAgAlIeygjfN/lgAgAlI]],
				["UpperLegF.R"] = [[
					g/hlfY0vmjgA3dg/hkfbo7l5ht+Gg/hefkz1nLg44Cg/hYfvt4nFio70g/hSf50noXiK24g/hPf/4ypKhWx+g/hTft21o1iM0eg/heeyq3mgjq9Jg/hheovt
					mKgx7Lg/hmenx5lxgH54g/hkenw+l7gY6dg/hheqvumMgy7Kg/hheytXmbh88Sg/hje+s7mii28Yg/hkfLv9mqhv63g/hlfV0GmjgM4Bg/hlfY0wmjgA3dg/
					hlfY0vmjgA3dg/hlfY0vmjgA3d]],
				["LowerLegF.R"] = [[
					hLg+fb7AjHgAw2hOhOf76OhQfHyQhOg4fp92jie0q3hSg6gF/Fj7dcl7hSgtf6/clIdzh1hPgsfw/TlefIjphSgufm/dlheOgjhRhGfP/Fj6dnmAhNg+e768
					iIfTxGhLhAe04iiVgX0ZhMhAe35kiNf7zGhNg+e87FiKfQw4hQhDfK9hibeTr8hRhGfX+yjOd3nwhQhCfd+Ai2eWqlhMg+fa7ZjAfxwPhLg+fb7AjHgAw3hL
					g+fb7AjHgAw2hLg+fb7AjHgAw2]],
				["FootF.R"] = [[
					hOgjfN/lgAgAlIhOgyfx/heCgUlHhOgkfS/lgDgAlIhOgufp/lgJf+lIhOgpfc/ihrfvlHhOglfS/fiRfolHhOgtfI/fiTfolHhOg6ez/lgLf+lIhOgjeu/j
					e5gLlIhOgjeu/kfcgGlIhOgjeu/kfLgJlIhOgjev/je6gLlIhOgte0/je2gMlIhOg3e8/kfhgFlIhOgvfF/kfRgIlIhOgjfL/lf1gClIhOgjfN/lgAgAlIhO
					gjfN/lgAgAlIhOgjfN/lgAgAlI]],
				Tail1 = [[
					gAiBhLiIgAgA/7gAiAhNiIgAgA/7gAh/hUiIgAgA/7gAh8hdiIgAgA/7gAh7hliIgAgA/7gAh6hqiIgAgA/7gAh7haiBgAgA/7gAh9gkhgf1gB/9gAh7gchV
					fTgE/9gAh5gbh2gAgA/8gAh6gbhfhFf6/8gAh7gdgzhpf1/8gAh9glgnhcf2/9gAh+gxg3ggf9/+gAh/g/hQfogC/9gAiAhIhqfggD/8gAiBhLh+f1gB/7gA
					iBhLiHgAgA/7gAiBhLiIgAgA/7]],
				Tail2 = [[
					gAh9hjicgAgA/5gAh9hmilgAgA/4gAh7hti9gAgA/2gAh5h2jbgAgA/zgAh3h+j2gAgA/wgAh2iDkGgAgA/ugAh3hzjmgAgA/ygAh7g9hwfsgC/8f/h5g0gv
					ePgM/7gAh2g0gxfCgI/9gCh4g0gahMf7/9gDh6g2fvizfs/3gCh8g+fijFfn/1gBh9hKf8hvfx/8f/h9hXgrf7f///f/h+hhhgfRgE/8gAh+hjiKfrgC/6gA
					h9hjicgAgA/5gAh9hjicgAgA/5]],
				Tail3 = [[
					gAh6h8iDgAgA/7gAh5h/iUgAgA/6gAh3iFjDgAgA/2gAh0iOkAgAgA/vgAhxiWk2gAgA/ngAhwiblVgAgA/igAhyiLkcgAgA/rf/h4hWhQfngC/9f8h4hNfa
					dOgR/3f+h1hNe+ddgV/3gEh3hNeogUgJ/9gHh7hOd8jCfz/xgHh8hWdwkUfi/ngDh9hjeTjNfm/yf/h8hwfYgxf3/+f+h7h5gnfYgC/+f/h6h8hmflgC/8gA
					h6h8iCgAgA/7gAh6h8iDgAgA/7]],
				Tail4 = [[
					gAh2iUe8gAgA/+gAh1iXfWgAgA//gAhyiegdgAgA//gAhuimh4gAgA/7gAhqiujLgAgA/1gAhoiyj4gAgA/wgAhrijimgAgA/4f/h2hueDfogA/7f4h5hlbb
					cof9/ef7h3hlaib3gI/PgEh5hmaKewgY/bgMh+hmZgiQgW/PgOiAhtZWkrgG+8gIh/h7aBkZf5/HgBh9iJbZh3f4/mf9h6iSdBf0f9/2f/h4iVeWfnf//8gA
					h2iUe8gAgA/+gAh2iUe8gAgA/+]],
				Tail5 = [[
					gAh4itbygAgA/tgAh2iwcVgAgA/xgAhxi3dzgAgA/6gAhri/ftgAgA//gAhljGhbgAgA/9gAhijKiYgAgA/5gAhni7gsgAgA//f+h5iHa0fwf+/kfziAh9Xd
					cvfi+pf0h/h8WLa6fm+AgCiCh9VzdGgS+LgPiIh9VJgsgy+EgViKiDVAj8g09xgPiIiRVzkxge98gDiEigXbiwgH+sf9h/irZagaf9/Tf+h6itbDfvf9/mgA
					h4itbygAgA/tgAh4itbygAgA/t]],
				["UpperLegB.L"] = [[
					fBhggx4BXxgAzcfBhfg04nXcf2yjfBhdg756WvfgwUfBhbhF7GWHfLt0fBhYhO7yVyfDsFfBhXhT8BVsfGrcfBhYhD7NVqe8tOfBhcgLuZbZhM8LfBhbgBs4
					b6hD8+fBhbf/skcHg09JfBhbgAsrcCg59FfBhbgDtFb2hE84fBhcgLuabdhH8LfBhdgXyjZwgu5SfBhfgk2CYXgP15fBhggu3qX3gCz8fBhggx4BXxgAzcfB
					hggx4BXxgAzcfBhggx4BXxgAzc]],
				["LowerLegB.L"] = [[
					e1g8gmwvd6gA7Me1g8gmw2d9gI7He0g9goxtdzga6je1g+gszodNgm5Ge1g+gy16cWgl3Ae2g+g23Wbxgd1ce0g9gpx7dpgu6Ye4g8ghupcne58Oe5g9gbtF
					c+ey9Ae5g+gaswdGen9Ke5g+gas4dDer9He5g9gctSc7ey86e4g8ghuqcqe18Ne2g4ghtydqfM8we1g5giuNeRfr8ne1g7glwCeDf87ne1g8gmwud6gA7Me1
					g8gmwvd6gA7Me1g8gmwvd6gA7M]],
				["FootB.L"] = [[
					eygjgz/jgAgAlReygjgz/jgHf/lReygjgz/jgOf+lReygjgz/jf+gAlReygjgz/jfZgHlReygjgz/ie5gMlReygjgz/jgTf9lReyglgx/QeKgFmjezgpgt+r
					eNfqo4ezgpgs+geNfkpdezgpgt+keNfnpPezgogu+xeNfuojeyglgx/OeKgDmueygjgz/ifKgJlReygjgz/jf8gBlReygjgz/jgCgAlReygjgz/jgAgAlRey
					gjgz/jgAgAlReygjgz/jgAgAlR]],
				["UpperLegB.R"] = [[
					g/hggx4BoPgAzcg/hfg04nokgKyjg/hdg756pRggwUg/hbhF7Gp5g1t0g/hYhO7yqOg9sFg/hXhT8BqUg6rcg/hYhD7NqWhEtOg/hcgLuZkne08Lg/hbgBs4
					kGe98+g/hbf/skj5fM9Jg/hbgAsrj+fH9Fg/hbgDtFkKe884g/hcgLuakje58Lg/hdgXyjmQfS5Sg/hfgk2Cnpfx15g/hggu3qoJf+z8g/hggx4BoPgAzcg/
					hggx4BoPgAzcg/hggx4BoPgAzc]],
				["LowerLegB.R"] = [[
					hLg8gmwviGgA7MhLg8gmw2iDf47HhMg9goxtiNfm6jhLg+gszoizfa5GhLg+gy16jqfb3AhKg+g23WkPfj1chMg9gpx7iXfS6YhIg8ghupjZhH8OhHg9gbtF
					jChO9AhHg+gaswi6hZ9KhHg+gas4i9hV9HhHg9gctSjFhO86hIg8ghuqjWhL8NhKg4ghtyiWg08whLg5giuNhvgV8nhLg7glwCh9gE7nhLg8gmwuiGgA7MhL
					g8gmwviGgA7MhLg8gmwviGgA7M]],
				["FootB.R"] = [[
					hOgjgz/jgAgAlRhOgjgz/jf5gBlRhOgjgz/jfygClRhOgjgz/jgCgAlRhOgjgz/jgnf5lRhOgjgz/ihHf0lRhOgjgz/jftgDlRhOglgx/Qh2f7mjhNgpgt+r
					hzgWo4hNgpgs+ghzgcpdhNgpgt+khzgZpPhNgogu+xhzgSojhOglgx/Oh2f9muhOgjgz/ig2f3lRhOgjgz/jgEf/lRhOgjgz/jf+gAlRhOgjgz/jgAgAlRhO
					gjgz/jgAgAlRhOgjgz/jgAgAlR]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiFgrALgAgAjKgAiEgtAKgAgAi+gAiAgyAIgAgAikgAh9g3AGgAgAiLgAh9g4AFgAgAiDgAiAgzAHgAgAihgAiFgqAPgAgAjygAiIgnAZgAgAk1gAiIgmAb
					gAgAlGgAiIgmAbgAgAlGgAiIgmAbgAgAlGgAiIgmAbgAgAlGgAiIgmAbgAgAlGgAiIgmAbgAgAlGgAiIgmAbgAgAlGgAiIgmAbgAgAlGgAiIgmAbgAgAlGgA
					iIgmAbgAgAlGgAiIgmAbgAgAlGgAiIgnAZgAgAk3gAiGgpARgAgAkDgAiFgrAMgAgAjTgAiFgrALgAgAjKgAiFgrALgAgAjKgAiFgrALgAgAjK]],
				Spine1 = [[
					gAiJgWALgAgAjKgAiHgYAJgAgAi5gAiEgdAGgAgAiRgAiAghAEgAgAhrgAh/gjADgAgAhggAiDgeAGgAgAiMgAiKgWARgAgAj8gAiOgTAdgAgAlUgAiPgSAh
					gAgAlpgAiPgSAhgAgAlpgAiPgSAhgAgAlpgAiPgSAhgAgAlpgAiPgSAhgAgAlpgAiPgSAhgAgAlpgAiPgSAhgAgAlpgAiPgSAhgAgAlpgAiPgSAhgAgAlpgA
					iPgSAhgAgAlpgAiPgSAhgAgAlpgAiOgSAegAgAlWgAiMgUAUgAgAkUgAiJgWAMgAgAjWgAiJgWALgAgAjKgAiJgWALgAgAjKgAiJgWALgAgAjK]],
				Spine2 = [[
					gAiNgCACgAgAgzgAiLgDABgAgAgdgAiHgIABgAgAfngAiDgMACgAgAe0gAiBgNADgAgAemgAiGgJABgAgAfggAiQgBAEgAgAhxgAiVf+ANgAgAjdgAiWf+AQ
					gAgAj3gAiWf+AQgAgAj3gAiWf+AQgAgAj3gAiWf+AQgAgAj3gAiWf+AQgAgAj3gAiWf+AQgAgAj3gAiWf+AQgAgAj3gAiWf+AQgAgAj3gAiWf+AQgAgAj3gA
					iWf+AQgAgAj3gAiWf+AQgAgAj3gAiVf+ANgAgAjfgAiRgAAGgAgAiOgAiOgBACgAgAhCgAiNgCACgAgAgzgAiNgCACgAgAgzgAiNgCACgAgAgz]],
				Spine3 = [[
					gAiOftACgAgAgzgAiMfvABgAgAgXgAiGfzABgAgAfUgAiBf3AEgAgAeVgAh/f5AFgAgAeCgAiGf0ACgAgAfMgAiSfsAFgAgAh7gAiZfqARgAgAj8gAibfqAV
					gAgAkagAibfqAVgAgAkagAibfqAVgAgAkagAibfqAVgAgAkagAibfqAVgAgAkagAibfqAVgAgAkagAibfqAVgAgAkagAibfqAVgAgAkagAibfqAVgAgAkagA
					ibfqAVgAgAkagAibfqAVgAgAkagAiafqARgAgAj/gAiUfrAHgAgAiegAiPfsACgAgAhFgAiOftACgAgAgzgAiOftACgAgAgzgAiOftACgAgAgz]],
				Neck1 = [[
					gAiPfYA6gAgAnigAiMfaAwgAgAmzgAiFfeAbgAgAlDgAh/fiAMgAgAjZgAh9fkAJgAgAi5gAiEffAYgAgAk1gAiUfXBXgAgApKgAiffWCagAgAsJgAihfVCs
					gAgAs0gAihfVCsgAgAs0gAihfVCsgAgAs0gAihfVCsgAgAs0gAihfVCsgAgAs0gAihfVCsgAgAs0gAihfVCsgAgAs0gAihfVCsgAgAs0gAihfVCsgAgAs0gA
					ihfVCsgAgAs0gAihfVCsgAgAs0gAiffWCbgAgAsMgAiXfWBogAgAqBgAiRfXBBgAgAn8gAiPfYA6gAgAnigAiPfYA6gAgAnigAiPfYA6gAgAni]],
				Neck2 = [[
					gAiiezB0gAgAqmgAide0BfgAgAplgAiSe3A1gAgAnKgAiHe6AZgAgAk1gAiEe7ASgAgAkJgAiRe3AwgAgAm2gAire1CpgAgAssgAi7e4EmgAgAwggAi/e5FI
					gAgAxWgAi/e5FIgAgAxWgAi/e5FIgAgAxWgAi/e5FIgAgAxWgAi/e5FIgAgAxWgAi/e5FIgAgAxWgAi/e5FIgAgAxWgAi/e5FIgAgAxWgAi/e5FIgAgAxWgA
					i/e5FIgAgAxWgAi/e5FIgAgAxWgAi8e4EpgAgAwkgAiwe1DKgAgAt0gAikezCBgAgArIgAiiezB0gAgAqmgAiiezB0gAgAqmgAiiezB0gAgAqm]],
				Neck3 = [[
					gAi3eZB0gAgAqmgAixeZBZgAgApSgAiheZAngAgAmJgAiReaALgAgAjHgAiNebAGgAgAiOgAifeZAigAgAlvgAjDeeC4gAgAtOgAjZepFhgAgAx8gAjeesGP
					gAgAy9gAjeesGPgAgAy9gAjeesGPgAgAy9gAjeesGPgAgAy9gAjeesGPgAgAy9gAjeesGPgAgAy9gAjeesGPgAgAy9gAjeesGPgAgAy9gAjeesGPgAgAy9gA
					jeesGPgAgAy9gAjeesGPgAgAy9gAjZepFkgAgAyBgAjKegDjgAgAuogAi6eaCEgAgArRgAi3eZB0gAgAqmgAi3eZB0gAgAqmgAi3eZB0gAgAqm]],
				Head = [[
					gAjZdv/zgAgAjZgAjOds/kgAgAlMgAi1dn+mgAgApWgAicdm9KgAgAtJgAiUdm8qgAgAuOgAiydn+bgAgBp3gAjsd7//gAgAfWgAkLeV/FgXfQYdgAkRec+M
					fgg1VegAkRec+cgAgAWKgAkRec+pgefKW3gAkRec+Mfgg1VegAkRec+cgAgAWKgAkRec+pgefKW3gAkRec+Mfgg1VegAkRec+cgAgAWKgAkRec+pgefKW3gA
					kRec+Mfgg1VegAkRec+cgAgAWKgAkLeV/DgYfPYVgAj2eB/1f3gbc3gAjedy/5gAgAiXgAjZdv/zgAgAjZgAjZdv/zgAgAjZgAjZdv/zgAgAjZ]],
				Jaw = [[
					gAindq/8gAgAh2gAicdt/wgAgAj1gAiFd1+3gAgAocgAhxd/9ZgAgAsogAhreC82gAgAt1gAiCd2+qgAgBpJgAi9dp/8gAgAhngAjodx/+gifWfkgAj1dy/5
					fTgrdygAjzdz/9gAgAeggAjyd1/9grfUfOgAj1dy/5fTgrdygAjzdz/9gAgAeggAjyd1/9grfUfOgAj1dy/5fTgrdygAjzdz/9gAgAeggAjyd1/9grfUfOgA
					j1dy/5fTgrdygAjzdz/9gAgAeggAjpdx/+gifWfjgAjKdo//f1gaf+gAisdp/8gAgAhmgAindq/8gAgAh2gAindq/8gAgAh2gAindq/8gAgAh2]],
				Mane = [[
					gAkXejQPgAgA71gAkTeZOsgAgA65gAkDeALQgAgA4WgAjtdrIWgAgA1igAjmdlHkgAgA0ogAkAd9K6f/gA4DgAkbe9WUgAgA+fgDkaflgHgqgi/+f9kQftlk
					fRfY/fgAkUftiygAgA/3gDkYftkIgxgm/tf9kQftkDfTfW/ugAkUftj5gAgA/wgDkYftjugwgn/wf9kQftjpfUfV/xgAkUftlAgAgA/mgDkYftiNgugp/5f9
					kQftlKfSfX/jgAkUftj5gAgA/wgDkafmgTgqgi/+f/kafKZxfofw/YgAkZeqRjgAgA8igAkXejQPgAgA71gAkXejQPgAgA71gAkXejQPgAgA71]],
				["UpperLegF.L"] = [[
					fBhlfY0vZdgA3dfBhjfb0TZMfr3xfBhcfi0VYofK3jfBhVfp1HYBez2ofBhUfr1cX0et2PfBhbfj0aYifG3dfBhrfU1sZwgP2qfBh2fN2najgt18fBh4fM2i
					argr2DfBh4fM2iargr2DfBh4fM2iargr2DfBh4fM2iargr2DfBh4fM2iargr2DfBh4fM2iargr2DfBh4fM2iargr2DfBh4fM2iargr2DfBh4fM2iargr2DfB
					h4fM2iargr2DfBh4fM2iargr2DfBh2fN2naggp18fBhufSvgZmdi7IfBhnfXwQZQd36ofBhlfY0rZcf+3gfBhlfY0vZdgA3dfBhlfY0vZdgA3d]],
				["LowerLegF.L"] = [[
					e1g+fb7Ac5gAw2ezg7ff8Rczghuneyg1fm+EcQhPqNewgvfp+8bkhlmpewgufq/GbXhplsexg0fm+PcJhTpme2hCfV5qc7fVy1e5hNfL3IdDeW11e5hPfK3C
					dKeU18e5hPfK3CdKeU18e5hPfK3CdKeU18e5hPfK3CdKeU18e5hPfK3CdKeU18e5hPfK3CdKeU18e5hPfK3CdKeU18e5hPfK3CdKeU18e5hPfK3CdKeU18e5
					hPfK3CdKeU18e5hPfK3CdKeU18e5hNfL3IdBeS11ewhNfl+ndLhsoqewhFfn+tcyh2oMe1g+fb7Fc5gCwwe1g+fb7Ac5gAw2e1g+fb7Ac5gAw2]],
				["FootF.L"] = [[
					eygjfN/lgAgAlIeygjfN/lgFf/lIeygjfN/kfvgDlIeygjfN/kfGgJlIeygjfN/je3gMlIeygjfN/kfqgElIeygmfL/lf0gClIezgvfJ/NfjfqnCezgxfI/G
					fqfjngezgxfI/GfqfjngezgxfI/GfqfjngezgxfI/GfqfjngezgxfI/GfqfjngezgxfI/GfqfjngezgxfI/GfqfjngezgxfI/GfqfjngezgxfI/Gfqfjngez
					gxfI/GfqfjngezgxfI/GfqfjngeygvfJ/Ufhfymgeyg9fL/kgxf4lIeyg1fN/kgbf8lIeygjfN/lgBgAlIeygjfN/lgAgAlIeygjfN/lgAgAlI]],
				["UpperLegF.R"] = [[
					g/hlfY0vmjgA3dg/hjfb0Tm0gV3xg/hcfi0VnYg23jg/hVfp1Hn/hN2og/hUfr1coMhT2Pg/hbfj0aneg63dg/hrfU1smQfx2qg/h2fN2nldfT18g/h4fM2i
					lVfV2Dg/h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/
					h4fM2ilVfV2Dg/h4fM2ilVfV2Dg/h2fN2nlefW18g/hufSxSmYhh6Hg/hnfXxlmthY51g/hlfY0tmjgB3fg/hlfY0vmjgA3dg/hlfY0vmjgA3d]],
				["LowerLegF.R"] = [[
					hLg+fb7AjHgAw2hNg7ff8RjNffunhOg1fm+EjwexqNhQgvfp+8kcebmphQgufq/GkpeXlshPg0fm+Pj3etpmhKhCfV5qjFgry1hHhNfL3Ii9hq11hHhPfK3C
					i2hs18hHhPfK3Ci2hs18hHhPfK3Ci2hs18hHhPfK3Ci2hs18hHhPfK3Ci2hs18hHhPfK3Ci2hs18hHhPfK3Ci2hs18hHhPfK3Ci2hs18hHhPfK3Ci2hs18hH
					hPfK3Ci2hs18hHhPfK3Ci2hs18hHhNfL3Ii+ht11hOhKfg9Vife7sfhPhCfk9ui6eqrYhLg+fb7DjHf/wyhLg+fb7AjHgAw2hLg+fb7AjHgAw2]],
				["FootF.R"] = [[
					hOgjfN/lgAgAlIhOgjfN/lf7gBlIhOgjfN/kgRf9lIhOgjfN/kg6f3lIhOgjfN/jhJf0lIhOgjfN/kgWf8lIhOgmfL/lgMf+lIhNgvfJ/NgdgWnChNgxfI/G
					gWgdnghNgxfI/GgWgdnghNgxfI/GgWgdnghNgxfI/GgWgdnghNgxfI/GgWgdnghNgxfI/GgWgdnghNgxfI/GgWgdnghNgxfI/GgWgdnghNgxfI/GgWgdnghN
					gxfI/GgWgdnghNgxfI/GgWgdnghOgvfJ/RgegSmvhOg0fL/kfEgKlIhOgufN/kfZgGlIhOgjfN/lf/gAlIhOgjfN/lgAgAlIhOgjfN/lgAgAlI]],
				Tail1 = [[
					gAiBhLiIgAgA/7gAiAhNh0gAgA/8gAh9hShFgAgA/+gAh7hWgZgAgA//gAh7hXgMgAgA//gAh9hShAgAgA/+gAiAhKjTfmgB/0gAiAhGlQgQgB/jgAiAhFlu
					g+gD/dgAiAhFlufOf+/dgAiAhFlufcf+/egAiAhFluhFgD/dgAiAhFlugAgA/egAiAhFlue7f9/dgAiAhFlugkgC/egAiAhFlugygC/dgAiAhFlufCf9/dgA
					iAhFlufuf//egAiAhFluhHgD/dgAiAhGlSfwf//jgAiAhIjzfjgA/wgAiBhKiZgEgA/5gAiBhLiIgAgA/7gAiBhLiIgAgA/7gAiBhLiIgAgA/7]],
				Tail2 = [[
					gAh9hjicgAgA/5gAh9hliAgAgA/7gAh8hqg9gAgA/+gAh7hvf+gAgA//gAh6hwfsgAgA//gAh7hrg2gBgA/+f/h7hikLfQgC/tgAh4hdnAf6f+/NgBh3hcnq
					iFgF+/f/h3hcnrfCgA/Cf/h3hcnrebf7/BgCh3hcnrhygD/AgAh3hcnrgqgE/Df+h3hcnqd5f7+/gBh3hcnrgcf//DgBh3hcnqh5gG/Af/h3hcnrelf+/BgA
					h3hcnre2f7/CgCh3hcnqiBgE+/gAh4hdnDgGgC/Nf/h7hgk4fDgB/mgAh9hji2gFgA/3gAh9hjicgAgA/5gAh9hjicgAgA/5gAh9hjicgAgA/5]],
				Tail3 = [[
					gAh6h8iDgAgA/7gAh6h+hegAgA/9gAh6iDgHgAgA//gAh7iIe1gAgA/+gAh7iJedgAgA/9gAh6iEf+gCgA//f+h0h6kVfIgC/rgAhth0oBfGf4+9gFhshyo4
					i5gI+mf9hshyo5figH+uf9hshyo4dWf0+ngEhshyo5h1f/+rgBhshyo5htgN+rf7hshyo4dSf7+ngChshyo5ftf2+ugEhshyo4i4gK+mf8hshyo5e0gE+tf+
					hshyo5dwfz+pgFhshyo5iXgC+pgAhthzoFg6gI+8f+hzh4lQeqgB/hgAh5h7ilgCgA/4gAh6h8iDgAgA/7gAh6h8iDgAgA/7gAh6h8iDgAgA/7]],
				Tail4 = [[
					gAh2iUe8gAgA/+gAh4iXePgAgA/8gAh6icckgAgA/zgAh8igbAgAgA/mgAh9iiaigAgA/hgAh6idcZgCgA/yf9huiShyfQf//7f/hhiJmZeLfk/SgJhfiGng
					jHgV+8f9hfiHnggfgZ/Ff5hfiGngcqfe+6gHhfiHnghQf5/EgEhfiHngitgm++f3hfiGngdWf0+/gBhfiHngerfh/EgIhfiGngjWgc+6f7hfiHngfmgR/Gf6
					hfiHngc3fb+8gIhfiGngiBgC/CgBhhiJmfh2gc/Rf8hriPi8ejf6/0gAh1iUfmf9gA//gAh2iUe8gAgA/+gAh2iUe8gAgA/+gAh2iUe8gAgA/+]],
				Tail5 = [[
					gAh4itbygAgA/tgAh6iva9gAgA/lgAh/i0ZAgAgA/NgAiEi4XMgAgA+wgAiGi5WqgAgA+mgAiAi1YzgDgA/Kf8hriqfLflgA/+f8hYigkudhfL/igOhTicmD
					irgR/Tf+hTidmChdg5/Xf0hTicmDclfR/OgJhTidmCgVff/agIhTidmDjRhA/OfzhTicmCd/gA/Wf/hTidmDdyfA/UgOhTicmDjKgh/Qf6hTidmCgmgv/Zf1
					hTicmDcjfG/NgLhTicmChNfv/ZgEhXigk0ihg2/gf6hningjexf3/9gAh1itckf4f//zgAh4itbygAgA/tgAh4itbygAgA/tgAh4itbygAgA/t]],
				["UpperLegB.L"] = [[
					fBhggx4BXxgAzcfBhfgz4pXXf0yffBhcg551WkfawVfBhZg+6tV8fEubfBhYhA67Vye+t4fBhcg65+WefWwCfBhhgu3mYFgA0GfBhjgo1vZRgX2efBhjgn1L
					Zngd3GfBhjgn1LZngd3GfBhjgn1LZngd3GfBhjgn1LZngd3GfBhjgn1LZngd3GfBhjgn1LZngd3GfBhjgn1LZngd3GfBhjgn1LZngd3GfBhjgn1LZngd3GfB
					hjgn1LZngd3GfBhjgn1LZngd3GfBhjgo1sZTgX2hfBhhgs2/YegK07fBhggw34X4gBzrfBhggx4BXxgAzcfBhggx4BXxgAzcfBhggx4BXxgAzc]],
				["LowerLegB.L"] = [[
					e1g8gmwvd6gA7Me0g7gmwfeDgJ7We0g7gmwaeKgb7Ze0g8gmwzeCgn7Je0g8gnxAd+gq7Be0g7gmwbeKgd7Ye1g7gmwhd/f17Ue2g8goxeddfS6qe2g8gpx7
					dPfI6Ve2g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2
					g8gpx7dPfI6Ve2g8gpx7dPfI6Ve2g8goxgdcfR6pe1g8gmw1d0fq7He1g8gmwud6f97Me1g8gmwvd6gA7Me1g8gmwvd6gA7Me1g8gmwvd6gA7M]],
				["FootB.L"] = [[
					eygjgz/jgAgAlReygjgz/jgMf+lReygjgz/jgcf7lReygjgz/jgff7lReygjgz/jgef7lReygjgz/jgdf7lReygjgz/jf8gBlReygjgz/ifQgIlReygjgz/i
					fAgLlReygjgz/ifAgLlReygjgz/ifAgLlReygjgz/ifAgLlReygjgz/ifAgLlReygjgz/ifAgLlReygjgz/ifAgLlReygjgz/ifAgLlReygjgz/ifAgLlRey
					gjgz/ifAgLlReygjgz/ifAgLlReygjgz/ifOgIlReygjgz/jftgDlReygjgz/jf+gAlReygjgz/jgAgAlReygjgz/jgAgAlReygjgz/jgAgAlR]],
				["UpperLegB.R"] = [[
					g/hggx4BoPgAzcg/hfgz4popgMyfg/hcg551pcgmwVg/hZg+6tqEg8ubg/hYhA67qOhCt4g/hcg65+pigqwCg/hhgu3mn7gA0Gg/hjgo1vmvfp2eg/hjgn1L
					mZfj3Gg/hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/
					hjgn1LmZfj3Gg/hjgn1LmZfj3Gg/hjgo1smtfp2hg/hhgs2/nif207g/hggw34oIf/zrg/hggx4BoPgAzcg/hggx4BoPgAzcg/hggx4BoPgAzc]],
				["LowerLegB.R"] = [[
					hLg8gmwviGgA7MhMg7gmwfh9f37WhMg7gmwah2fl7ZhMg8gmwzh+fZ7JhMg8gnxAiCfW7BhMg7gmwbh2fj7YhLg7gmwhiBgL7UhKg8goxeijgu6qhKg8gpx7
					ixg46VhKg8gpx7ixg46VhKg8gpx7ixg46VhKg8gpx7ixg46VhKg8gpx7ixg46VhKg8gpx7ixg46VhKg8gpx7ixg46VhKg8gpx7ixg46VhKg8gpx7ixg46VhK
					g8gpx7ixg46VhKg8gpx7ixg46VhKg8goxgikgv6phLg8gmw1iMgW7HhLg8gmwuiGgD7MhLg8gmwviGgA7MhLg8gmwviGgA7MhLg8gmwviGgA7M]],
				["FootB.R"] = [[
					hOgjgz/jgAgAlRhOgjgz/jf0gClRhOgjgz/jfkgFlRhOgjgz/jfhgFlRhOgjgz/jfigFlRhOgjgz/jfjgFlRhOgjgz/jgEf/lRhOgjgz/igwf4lRhOgjgz/i
					hAf1lRhOgjgz/ihAf1lRhOgjgz/ihAf1lRhOgjgz/ihAf1lRhOgjgz/ihAf1lRhOgjgz/ihAf1lRhOgjgz/ihAf1lRhOgjgz/ihAf1lRhOgjgz/ihAf1lRhO
					gjgz/ihAf1lRhOgjgz/ihAf1lRhOgjgz/igyf4lRhOgjgz/jgTf9lRhOgjgz/jgCgAlRhOgjgz/jgAgAlRhOgjgz/jgAgAlRhOgjgz/jgAgAlR]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiFgrALgAgAjKgAiLgrAigBgdlugAiFgrApgAhEmMgAiegrA4f+hEnSgAizgrBBf+gqn6gAi7grBEgAgAoGgAizgrBBgCfWn6gAiegrA4gCe8nSgAiFgrAp
					gAe8mMgAiJgrAsgAfWmggAiIgrArgAgAmbgAiogrA8f+gqnngAi4grBEf8hEoBgAi6grBEf8hEoEgAisgrA+f+gqnugAiQgrAvgAgAmwgAiIgrArgAfWmbgA
					iPgrA0gCe8m/gAiNgrAngAfNmDgAiHgrASf/f2kIgAiFgrALgAgAjK]],
				Spine1 = [[
					gAiJgWALgAgAjKf/iSgXAhgAgdlpf/iNgYAif/hElpf/ingYA6f+hEnaf/i+gZBIf+gqoWgAjGgZBNgAgAoogBi+gZBIgCfWoWgBingYA6gCe8nagBiNgYAi
					gBe8logBiRgYAogBfWmLgAiQgYAmgAgAmBf/iygZBBf/gqn6f/jDgZBMf9hEohf/jEgZBNf9hEolf/i2gZBEf/gqoFgAiYgYAsgAgAmjgBiQgYAmgBfWmBgB
					iYgYAzgCe8m/gBiVgYAngAfNmDgAiNgXASf/f2kIgAiJgWALgAgAjK]],
				Spine2 = [[
					gAiNgCACgAgAgzf/iagDAMf+gdjPf9iUgEAKf5hEiwf9ixgFAef5hElOf+jIgGAsf8gqmggAjRgHAxgAgAm5gCjIgGAsgEfWmggDixgFAegHe8lOgDiUgEAK
					gHe8ivgCiagEAOgEfWjggAiYgEAMgAgAjTf+i8gGAlf8gql6f9jOgHAwf5hEmvf9jPgHAxf5hEm0f+jBgGAnf8gqmJgAihgEARgAgAkCgCiYgEAMgEfWjTgD
					ihgFAYgHe8kqgCidgEAQgDfNjugAiSgCAEgAf2hygAiNgCACgAgAgz]],
				Spine3 = [[
					gAiOftACgAgAgzf+iefvALf+gdjLf8iYfvAHf4hDiMf8i3fyAff6hElWf9jRfzAyf9gqm9gAjaf0A5gAgAnbgDjRfzAygDfWm9gEi3fyAfgGe8lWgEiYfvAH
					gIe9iLgDiefwAMgFfWjLgAicfvAJgAgAi5f9jEfyAof8gqmNf8jWf0A3f7hEnQf8jYf0A5f7hEnWf9jJfzAsf8gqmggAimfwAQgAgAj1gDicfwAKgFfWi5gE
					infxAYgHe8kpgDihfvAQgDfNjugBiVftAEgAf2hygAiOftACgAgAgz]],
				Neck1 = [[
					gAiPfYA6gAgAnif+iifaBOgDgdotf6ibfaA3gChEnQf6i+feB4gFhEqrf9jafgCpgEgqssgAjjfhC7gAgAtUgDjafgCpf8fWssgGi+feB4f7e8qrgGibfaA3
					f+e8nPgDiifbBGf+fWoNgAigfbBBgAgAn8f9jMffCQgEgqruf6jgfhC1gIhEtFf6jhfhC5gIhEtNf9jRffCZgEgqsGgAirfcBTgAgAo+gDigfbBBf+fWn8gG
					itfdBhf8e8pogEimfbBXf7fNpJgBiXfZBDf+f2oEgAiPfYA6gAgAni]],
				Neck2 = [[
					gAiiezB0gAgAqmf9i4e3B2gFgdqpf4ite2BQgGhEouf4jYe+CkgJhDsdf7j4fEDtgIgpu4gAkCfGEHgAgAvrgFj4fEDtf4fXu4gIjYe+Ckf3e9sdgIite2BP
					f6e8otgFi3e3Bhf8fWpqgAi0e3BbgAgApZf7jofBDHgHgpttf4j+fFD+gNhDvYf4kAfGEEgNhDvif7jufCDVgHgpuKgAjBe5B0gAgAqjgFi0e3Bcf8fWpZgI
					jFe7CBf5e8rEgGi9e5B+f4fOq/gBire1B3f9f2qugAiiezB0gAgAqm]],
				Neck3 = [[
					gAi3eZB0gAgAqmf8jNedBegEgdpjf2i/eZA1gChEnGf2jwenCGgHhErRf6kTexDXgHgpuNgAkfe1D2gAgAvLgGkTexDXf5fXuNgKjwenCGf5e8rRgKi+eZA1
					f+e8nFgGjKecBDf+fWoDgAjHebA/gAgAnyf6kCesCrgFgqswf2kae0DrgMhDu0f2kde0DygMhDvBf6kIeuC7gGgqtUgAjWefBVgAgApFgGjHebA/f+fWnygK
					jbeiBef8e8pfgIjSefBkf5fNpzgCjAebBvf9f2qVgAi3eZB0gAgAqm]],
				Head = [[
					gAjZdv/zgAgAjZf6jrdx/yhQfsjUfyjWdp/ajBfIlOfzkTd//1i6feg5f4k+eR/3huf0dwgAlMeX/0gAgActgIk+eR/3eSgMdwgNkTd//1dGgig5gOjVdp/Z
					c/g4lPgIjkdt/peJgfkUgAjgds/pgAgAkof4kpeH/7hxfwfXf0lGeV/uixfxdBf0lJeW/tiwfyczf4kxeL/6hwfxewgAjzdy/0gAgAjTgIjgds/meJggkmgN
					j5d2/udBgriygKjyd0/xd0gii6gCjhdw/0fkgHjQgAjZdv/zgAgAjZ]],
				Jaw = [[
					gAindq/8gAgAh2f+i6ds/ehRfylkf7ildp+hjHfhpFf7jkdx/fi9f1k2f9kRd7/5hvgChugAkgd+//gAgAgrgDkRd7/5eRf+hugFjkdx/fdDgLk2gFikdp+g
					c5gfpFgDiydr+3eGgQoNgAiudq+1gAgAoif9j6d2/xhyf+jVf7kbd9/2ixgHg/f7ked+/3iwgIgxf9kDd3/0hxf/iugAjCds/KgAgAnOgDiudq+yeGgRoegF
					jIdu/Ic+gTmsgEjAdt/cdxgWlfgBivdr/1fkgIjFgAindq/8gAgAh2]],
				Mane = [[
					gAkXejSugAgA9Gf3kpemUef/hS90fqkZeWTBgFjJ9EfslJe8Vvfqi8+Jf0lmfXWzfkhr+lgAlwfgW6gAgA+rgMlmfXWzgceV+lgUlJe8VvgWdE+JgWkZeWTB
					f7c39EgNkleeTjgBeF9ZgAkjebRmgAgA8kf0lYfKUzfmhv96ftlrfeWwfLip+fftltffYWfSir+8f0lefPYXfvhw/BgAkyenU4gAgA9/gOkiebS1gCeF9FgV
					k1etStgXc+87gQkueqRSgWdx8TgDkfelRPgDfj8YgAkXejSvgAgA9G]],
				["UpperLegF.L"] = [[
					fBhlfY0vZdgA3de/h4fWyWaAeN5ce8hwfbz0Z5cw4Je8iVfWzia+eZ4ye+iyfT4PbfgR0ZfBi9fQ3ka8gO1CfFi0fO3IZ+f31QfHiXfOxtY4db5ifHhyfTvs
					YGai6LfFh5fSwQY1cC6TfBh3fVx+ZWdc5fe+ikfT4QbWgd0Ve8i4fU4acEgi0Se8i6fU2IbrfZ2re+ipfTyzaxd85RfBiCfUw+Zmcd6GfFh3fTwaYvcL6NfH
					iGfP06YxfG3FfFh+fQ2+ZNga1MfChtfV1ZZcgE23fBhlfY0vZdgA3d]],
				["LowerLegF.L"] = [[
					e1g+fb7Bc5gAw2ewhTfh+qd+hkowerhLfi/Vc7jJbTevhuff+sfZhko4e3iKfL4oeFeJ0Qe5iUfK4CdgeB04e6iMfJ3tcidl1Ee0h0fa9Jb9gHskevhUfj++
					YLhhgAewhZfi/RaphgjvewhTfh/Mclhrl9e3h7fL4qd+eT0Ne2iPfM4verec0LeyiRfU7vfbfzv7ewiDfe+efChRpmevhgfj/lcJh4ixewhWfi/Qaphjj5e4
					hffR6Sb2e4xue6hWfL3pb1eD1Ce2hFfW6LcsfeyFe1g+fb7Ac5gAw2]],
				["FootF.L"] = [[
					eygjfN/lgAgAlIeyhDfH/ihjfwlHeyhTfF/kgqf5lIeyhefF/Hi4fYm2eyhsfF+qg3fspGezh3fG98gTfYrPeyhufF+efRf8pteyhefF/OfKgMm4eyhTfF/L
					a9g1lEeyhRfF/heAgVlHeyhHfF/lgKf+lIeyhefF+0gufookeyhyfG+LhffQqeeyh3fF+dicfQpdeyhyfF+0iYfYoOeyhafF/efmgFlveyhPfF/heCgUlHey
					hDfF/jetgNlIeyg4fH/TeVf8maeygpfL/kfpgElIeygjfN/lgAgAlI]],
				["UpperLegF.R"] = [[
					g/hlfY0vmjgA3dg8h5fS1xmugL2cg5hyfTyEn6iL5Gg5iXfO0InHhX3zg7i0fOx0mXiu5qg/i9fQxUlpjB6IhCiyfTyzlJiF5RhEiVfW1Kk2g23fhEhwfb0Z
					lqhP39hCh4fY0ilyhD30g/h3fVx+mqik5fg7ilfOxGmgjC6Eg5i6fMwomojh6Sg5i8fMysmriZ4+g7irfO3KmJgG1Mg/iCfU1PmQgt3FhCh2fYzvl7hf4bhE
					iEfXz/lIhX4ahDh9fXywljhr5QhAhtfXzlmVgt4fg/hlfY0vmjgA3d]],
				["LowerLegF.R"] = [[
					hLg+fb7BjHgAw2hJhRfS57jng9yYhNhOfd9xk8fMqlhJhxfT68j8g5wyhMiQfa9XjBf4sUhPiZff+niBfEpBhQiMfe+Yg3e0p6hPhtfZ9OgvfXs/hRhJfg/E
					hheRnRhPhRfc99h0fArChQhTfh/MjbeVl9hNiCfd+DjXffqbhMiZfc9sj1gCrShKiYfW79jfgvvJhGiDfJ3wjkiY1AhMhafW8BivgHvMhQhPff+wh8egobhR
					hcfe+ggzelpghRhXfh+yhVeUobhNhGfe8likfXuHhLg+fb7AjHgAw2]],
				["FootF.R"] = [[
					hOgjfN/lgAgAlIhOg1fH/kgwf4lIhOg7fF/ihifwlIhOhWfF/Og9fzm4hOh6fF+uf3gDo6hOiJfF+fezgYplhOh6fF+odkgto4hOhWfF/Jdhgjm2hOg7fF/g
					d4gWlHhOg9fF/ieagRlHhOhHfF/lf2gClIhOhvfF/BgJf+n2hOiFfF+lgufypWhOh+fF+jgaf4pehOhlfF+sg4gAo9hOhBfF/efogElvhOhAfF/ieYgRlHhO
					hLfF/ddRgclHhOhHfH/fdugYlHhOgufL/kfQgIlIhOgjfN/lgAgAlI]],
				Tail1 = [[
					gAiBhLiIgAgA/7gBiChKkri9gD/ggCh7hJlGlSgK/IgCiRhJm1icgH/KgBimhIoOeCf7+2gAiuhIoobjf1+ff/imhIoMcvf3+wf+iRhJm3gUgB/Pf+h7hJlJ
					jLgG/af/h+hJlei9gI/YgAh9hJlZgAgA/igBibhIngdDf3+9gCirhIofc1f4+rgCishIoofsf/+zgBifhInwjRgJ+3gAiEhJl4kdgM/If/h9hJlZh+gF/ef+
					iEhJl9dkf3/Vf+iDhJk/cCf6/WgAiBhKjGe8gC/0gAiBhLiIgAgA/7]],
				Tail2 = [[
					gAh9hjicgAgA/5gFh6hhk+kbgB/SgKhzhglPpmgM+EgGiHhfnplegN+lf+iahdp1dNf++Uf5ihhcqTXnfy9Gf6iahdpqY4fw9qf+iHhfnwfxf+/CgDhzhglY
					mZgI+4gDh2hglqnSgO+ogAh1hhlth6gD/af9iQheoqa7f2+Xf9iehdqGYefu9agCifhdqccpfx+DgGiUhepHkHgD+ZgHh8hfmPoagR+OgCh1hglol2gK+8f6
					h6hgmSeIf7/Tf4h7hglQZof6+6f+h9hjjad2gG/vgAh9hjicgAgA/5]],
				Tail3 = [[
					gAh6h8iDgAgA/7gMhzh4klkngF/UgYhshzkptHgb8zgOh8hznopfgi9lf6iLhxqxeTgM+FftiShsrPU7fu70fviMhvqPUpfa8Gf+h7h1n6dYfx+4gMhrh2k7
					oAgQ+lgOhuh1lEragf9dgDhsh4lQlUgN/Gf1iDhypLapf6+LfyiQhuq4U5ff79f9iQhwrXYmfU89gMiGhypzjBf2+TgThzhzl4rHge9agLhth2lDqKga96f3
					hxh2l6ghgC/cfvhzh2k0Ybfz+tf7h3h7jAcxgH/rgAh6h8iDgAgA/7]],
				Tail4 = [[
					gAh2iUe8gAgA/+gThsiOhhjegZ/wgrhliChxvIh+8EgchxiFlGtfiH8ff4h8iEpFhCg3+pfeiDh5p8T+e675fgh/h8ocREdw66f6hwiKlYZwe0+4gYhkiKh8
					nqhA++gehniGiFuaiC8agLhkiOiJpchT+dfth2iFnIcQf7+9fjiCh7pZS0eT7ifyiBiApvUkdv8JgRh4iFn3gQfV/AgjhqiEjKsDhp9bgZhmiJiBt4h68sf4
					hoiNizkOgq/lfjhsiLh0YrfF/Ef2hziTf6b6fv/ugAh2iUe8gAgA/+]],
				Tail5 = [[
					gAh4itbygAgA/tgZhqineXhOgR/7g/hkiQe/vWjk71gvhriUiwwhkS66f6huiZnNkrih+tfNh3iGonUues8pfLh1iHm3O1b05xfwhoigi0V0c/+Cgkhhige3
					lfhR/egzhliVfSvxj17kgZhiiifKtPjL88fohribk6fTgz/mfRh2iHn/Sedb7vfhh1iOoMRgbo69gRhsiblucjd3/Ng1hniVgarFii95gthkiYfNwOj57Sf/
					hkilfroViK+zfYhqiheuaWeu/bfvhzircybgfR/ggAh4itbygAgA/t]],
				["UpperLegB.L"] = [[
					fBhggx4CXxgAzcfBhlgs05amge3mfChfgu4BYveezyfCh4gr0zbPfq31fCiOgo14aJfO2lfBiXgl1dZ3fq27fBiQgjzNavg35BfBh6gjzPaehc46fBhhgl10
					Yngt2MfBhlgmztaXhL4hfBhjgp15ZigF2afCiDgp0XbKf64MfCiTgp2wZ0ei1kfCiUgp21Zwee1dfCiHgo08ayfq3nfBhrgo0Jaqgm4QfBhjgm0wZtg23ffB
					hrgkzgaehp4sfBhognz5aRhg4VfBhjgu22Yngb1IfBhggx4BXxgAzc]],
				["LowerLegB.L"] = [[
					e1g8gmwud6gA7Me4g/gw1PcgeZ3ne0g7gkv2fWe17we4hRgv1EdDdq3ye2hogoxqeOeU6ke2hwgmwveDew7Ke4hqgszhcYez5De4hUgszlcLfT5Ae1g6gkvd
					dlf475e4g+gt0EcHfD4le2g8goxydmfC6de4hcgu0oc6d54Ke1htgmwlfBeP7Se0hvglwVfHeQ7ce3hggszldYeD5Fe4hEgu0ecdeh4Se3g9gqyYc0fT5+e5
					hFgsz2cPff4ze4hCgt0QcFfW4ce2g9gpx8dWfs6We1g8gmwvd6gA7M]],
				["FootB.L"] = [[
					eygjgz/jgAgAlReygjgz/ceGgRlleygjgz/jgUf9lReyg2gz/GeGgZnPeyhOgz+qfbgLpHeyhYgz+cffgLpzeyhPgz+heMgepaeyg5gy+yeSgIoheygjgz/j
					fngElReygjgz/ceKgQljeygjgz/ifOgIlReyhBgz+3eJgdoMeyhUgz+hgAgApkeyhWgz+fgGf+pteyhGgz+0engYoceygpgz/XeHgWl9eygjgz/iezgNlRez
					gqgx+0ebfvobeygngy/KeSf/nBeygjgz/jfcgGlReygjgz/jgAgAlR]],
				["UpperLegB.R"] = [[
					g/hggx4CoPgAzcg/hmgp0Nlwez4Gg/hhgl1ynYfS2Og/h6gjzPliek46g/iQgjzNlRfJ5Bg/iXgl1dmJgW27g+iOgo14l3gy2lg+h4gr0zkxgW31g+hfgu4C
					nShjzwg+hkgr2HmDgZ2Tg/hjgp15mef72ag/iEgkzZlUe/42g/iVghy1lZe35Rg/iXghyzlZe55Sg/iJgjzVlTfC46g/hrgo0JlWfa4Qg+higs2umggp1ig+
					hpgs1AkugH3qg+hngt1FlIfz3gg/hjgv3JnUf501g/hggx4BoPgAzc]],
				["LowerLegB.R"] = [[
					hLg8gmwuiGgA7MhIg/gu0kj6g74LhLg6gkvgicgJ74hIhUgszlj1gt5AhIhqgszhjohN5DhKhwgmwvh9hQ7KhKhogoxqhyhs6khIhRgv1Ei9iW3yhMg7gkv1
					gphL7xhKg9gqyxiQhe5xhKg8goxyiag+6dhIhegszujnhG46hIhvgrzJjyg95VhIhxgrzHjyg+5WhIhigszpjnhI49hIhEgu0ejjhf4ShLg8goxphxhS6mhH
					hCgv1Ri3iI3ohIhAgw1ZjOh33fhKg9gpyIibgg6PhLg8gmwviGgA7M]],
				["FootB.R"] = [[
					hOgjgz/jgAgAlRhOgkgy/Yh1f0l+hOgjgz/jgaf8lRhOg5gy+yhuf4ohhOhPgz+hh0fipahOhYgz+cghf1pzhOhOgz+qglf1pHhOg2gz/Gh6fnnPhOgjgz/j
					frgElRhOgjgz/ig9f2lRhOgjgz/igyf4lRhOhDgy+phwfvpAhOhVgz+Yh0ffp2hOhXgz+Xh1fdp5hOhIgy+mhxfqpLhOgpgz/Xh5fql9hOgjgz/jghf7lRhN
					gngy/IhsgFnLhOglgz/Uh1f4mRhOgjgz/jggf7lRhOgjgz/jgAgAlR]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiFgrALgAgAjKgAiFg3ARgAgAkCgAiFhAAYgAgAk0gAiFg/AXgAgAktgAiFg7AVgAgAkbgAiFg3ATf7e3kFgAiFgzASf4ebjygAiFgyAPf8fKjqgAiFgxAO
					gAgAjmgAiGgvANf1gKjagAiPgsASdcgQjNgAiggrA+Y7gtjFgAitgrCsTlhPi6gAixgrFKO6hsiqgAiwgrHRL9h/idgAiwgrH+LIiEiYgAiwgrHXL3iAicgA
					ixgrG1Mih7iggAiwgrHTL8h/idgAiwgrH9LJiEiYgAiwgrH/LIiEiYgAiwgrH/LIiEiYgAiwgrH/LIiEiYgAiwgrH/LIiEiYgAiwgrH/LIiEiY]],
				Spine1 = [[
					gAiJgWALgAgAjKgAiKgiARgAgAkCgAiLgsAYgAgAk0gAiLgqAXgAgAktgAiLgnAVgAgAkbgBiKgjATf7e3kFgCiKgfASf4ebjygBiKgdAPf8fKjqgAiKgcAO
					gAgAjmgAiKgaANf1gKjaf/iTgXASdbgKjNf+ijgWA+Y6gdjIf9ivgWCuTigzjFf8izgWFMO3hJjBf8ixgWHVL6hYi9f8ixgWICLFhci7f8ixgWHbLzhYi8f8
					iygWG4MehVi+f8ixgWHWL4hYi9f8ixgWIBLGhci7f8ixgWIDLEhci7f8ixgWIDLEhci7f8ixgWIDLEhci7f8ixgWIDLEhci7f8ixgWIDLEhci7]],
				Spine2 = [[
					gAiNgCACgAgAgzgAiQgNAEgAgAhsgAiSgYAHgAgAiegAiRgWAHgAgAiXgAiRgSAFgAgAiFgDiQgOAFgAe3hvgEiPgKAGgAebhcgCiPgIADgAfKhTgAiOgHAD
					gAgAhQgAiPgFACf0gIhDf/iYgCAIdbf4g4f9ingCA1Y4frg5f6izgCClTgfdhGf5i1gCFEO0fUhZf4izgCHOL3fRhof4iygCH7LCfRhtf4izgCHTLwfRhof4
					i0gCGxMbfRhlf4izgCHPL2fRhof4iygCH6LDfRhtf4iygCH7LBfRhtf4iygCH7LBfRhtf4iygCH7LBfRhtf4iygCH7LBfRhtf4iygCH7LBfRht]],
				Spine3 = [[
					gAiOftACgAgAgzgAiSf4AEgAgAhsgAiVgDAHgAgAiegAiUgBAHgAgAiXgAiTf+AFgAgAiFgEiSf5AFgAe3hvgGiRf1AGgAebhcgDiQfzADgAfKhTgAiQfyAD
					gAgAhQf/iQfwACf0gIhDf/iZftAJdbfyg4f9ioftA2Y4fag9f7i0ftCnTgfBhSf5i3ftFHO0ewhvf3i1ftHRL4epiIf3i1ftH+LDeoiQf3i1ftHXLyepiJf4
					i2ftG0MceqiDf3i1ftHSL3epiIf3i1ftH9LEeoiQf3i1ftH/LDeoiQf3i1ftH/LDeoiQf3i1ftH/LDeoiQf3i1ftH/LDeoiQf3i1ftH/LDeoiQ]],
				Neck1 = [[
					gAiPfYA6gAgAnigAiUfkBYgAgApQgAiYfuB4gAgAqvgAiXftBzgAgAqhgAiWfpBngAgAp/gGiUfkBbfve5pVgIiTfhBSfoeeoxgEiSffBLfzfLoggAiSfeBJ
					gAgAoZf/iRfbBCf2gLoAf/iafZBBdegfnif9iqfYBqZAhSnKf7i2fYDVTuiMmwf5i6fYFvPHi9mRf3i5fYH1MNjcl6f3i4fYIhLZjklzf3i5fYH6MGjdl5f3
					i5fYHZMxjWl/f3i5fYH2MMjcl6f3i4fYIgLajklzf3i4fYIhLYjklzf3i4fYIhLYjklzf3i4fYIhLYjklzf3i4fYIhLYjklzf3i4fYIhLYjklz]],
				Neck2 = [[
					gAiiezB0gAgAqmgAirfBC0gAgAtFgAiyfOD2gAgAvLgAixfMDsgAgAu4gAiufIDTgAgAuIgJirfCC5fme8tMgMioe+CjfdehsYgGine7CXftfNsAgAime6CS
					gAgAr1f/ile3CFf4gNrSf8ite0B6dlg4qif2i7ezCZZTiUp1fvjEezD5UNj6o4fqjDezGGPvlKnyfni/ezIBM5l3m8fmi9ezIpMGmEmrfni/ezIGMzl5m6fo
					jAezHnNclvnHfni/ezICM4l4m7fmi9ezIoMHmDmrfmi9ezIqMFmEmrfmi9ezIqMFmEmrfmi9ezIqMFmEmrfmi9ezIqMFmEmrfmi9ezIqMFmEmr]],
				Neck3 = [[
					gAi3eZB0gAgAqmgAjEerDMgAgAt4gAjOe8ErgAgAwogAjNe5EcgAgAwPgAjJezD5gAgAvRgKjEesDSfke8uCgOjAenC0fbeis+gIi+ejCkfsfNsegAi9eiCd
					gAgAsQf+i7eeCKf4gOrhf5jBeaB5dohBqgftjNeYCSZciqpffhjReXDrUbkZoMfZjLeXFuQBlrmsfVjCeXHjNMmVlkfUjAeXIJMZmglOfVjCeXHnNGmXlhfW
					jEeXHKNvmOlzfVjCeXHkNLmVlkfUjAeXIIMamflOfUi/eXIKMZmglOfUi/eXIKMZmglOfUi/eXIKMZmglOfUi/eXIKMZmglOfUi/eXIKMZmglO]],
				Head = [[
					gAjZdv/zgAgAjZgAjueK/8gAgAeWgAj+ej/agAgAZ8gAj7ef/igBgAamgAj2eW/wgAgAcJgNjveL/4eigveCgSjoeD/5d5hIfogKjld+/9e3gogfgAjjd8/+
					gAgAg4f9jfd2/7gZf4iAfzjidw/sinf3jhffjodt+0nHf1kwfKjkdr86sVgJl9e+jUdp6Twwg0nEe6jEdo4Hzehgnye5i/do3a0Ohvn/e6jEdo4Czkhinze6
					jHdp4ky9hWnpe6jEdo4Gzfhgnye5i/do3b0Nhun+e5i/do3Z0Ohvn/e5i/do3Z0Ohvn/e5i/do3Z0Ohvn/e5i/do3Z0Ohvn/e5i/do3Z0Ohvn/]],
				Jaw = [[
					gAindq/8gAgAh2gAjAd1//gAgAfegAjXeD/4gAgAdZgAjUeB/6gBgAdsgAjMd8/9gAgAecgJjCd2/8eggrfTgNi5dy/5d4hGgBgHi1dw/9e3gogegAizdv//
					gAgAgqf+iudt/9gZf3hQf7ixdr/ximfyiqf0i7dr+2nHfzknfujBdt8usVghm0fri+du50wrh3osfqi5dv3YzRjJpyfqi3dv2lz+jkqFfqi4dv3RzXjMp1fq
					i6dv34yyi3plfqi5dv3WzSjJpzfqi3dv2mz9jjqEfqi3dv2kz/jkqFfqi3dv2kz/jkqFfqi3dv2kz/jkqFfqi3dv2kz/jkqFfqi3dv2kz/jkqF]],
				Mane = [[
					gAkXejQPgAgA71gAkZfPU0gAgA9+gAkUfyZEgAgA/OgAkVftYbgAgB/FgAkXfhW6gAgA+qgOkZfSVIf6eX+CgUkZfETqf0do9agLkZe9S2f4et9IgAkZe5Se
					gAgA8/f9kZewRcf+ga8ffqkhekP2fEic7ffFkmecOhdHmg51eekZeWNqaUq83HeCj7eQNWXXuYz2d1jfeMNdVOwRxRdzjWeKNjUkwwwed1jeeLNZVEwSxGd3
					jleMNRVhv2xpd1jfeMNYVHwPxKdzjWeKNjUkwvwfdzjWeKNjUjwxwddzjWeKNjUjwxwddzjWeKNjUjwxwddzjWeKNjUjwxwddzjWeKNjUjwxwd]],
				["UpperLegF.L"] = [[
					fBhlfY0vZdgA3dfBhqfh2BZdfp2QfBhufq3FZffU1KfBhufp27ZffX1VfBhsfl2jZefe1ufHhrfd2EYogX19fKhpfZ1pYTgx2PfGhofa1eY1gW2mfBhofc1Z
					Zdf023fBhnfb1HZqf+3LfIhnfX05a6iM3lfXhpfV0pdZmM3ffuhsfS0EgOq/2XgEhwfQzMinvQ0ZgThzfPybkGx8ykgXh1fOyMkhysx9gUh0fPyakJyCyggQ
					hyfPymj0xby9gThzfPybkHx9yjgXh1fOyMkgyrx+gXh1fOyMkhytx9gXh1fOyMkhytx9gXh1fOyMkhytx9gXh1fOyMkhytx9gXh1fOyMkhytx9]],
				["LowerLegF.L"] = [[
					e1g+fb7Ac5gAw2e1hCfg76c5f1vUe1hHfl8oc6frt8e1hGfk8hc6fsuJe1hFfi8Rc5fwupe7hDfb77cSgyvIe9hBfX7ocEhNvle5hAfa7hccgnv6e1hAfd7e
					c5f6wGe1g/fd7RdHf9wdfCg9fb7De6hpw+fchAfb6kibkqxCgAhIfb5amhoWwSghhTfb3xqErqu4g0hdfb2XsRtxthg6hhfb16s5uYtDg1hefb2UsXt2tdgx
					hbfb2qr2tXt0g1hefb2WsTtytgg6hhfb17s5uXtEg6hhfb15s6uYtDg6hhfb15s6uYtDg6hhfb15s6uYtDg6hhfb15s6uYtDg6hhfb15s6uYtD]],
				["FootF.L"] = [[
					eygjfN/lgAgAlIeygpfP/0gAgAjXeygvfS/8gAgAhzeygufR/7gAgAiCeygsfQ/4gAgAile5gpfK/zf0hIjRe8gnfH/ufwhkj2e3gmfK/tf3g2kIeygmfO/t
					gAgAkQeygkfP/pgNf6kqfDgifO/bifgulWfmgmfP+om1iIl1gTgzfR81r5j/l4g6hFfS6ZwPlxlehRhVfT4Vy7m+k8hXhbfT3qzrnUkvhRhWfT4QzBnBk6hN
					hSfT4xyamvlDhRhWfT4Uy9m+k7hWhbfT3rzqnUkvhXhbfT3qzsnUkvhXhbfT3qzsnUkvhXhbfT3qzsnUkvhXhbfT3qzsnUkvhXhbfT3qzsnUkv]],
				["UpperLegF.R"] = [[
					g/hlfY0vmjgA3dg/hqfh2BmjgX2Qg/hufq3Fmhgs1Kg/hufp27migo1Ug/hsfl2jmigi1uhFhqfm2ElshI2bhHhpfl1plYhT25hDhofh1el7gw29g/hofc1Z
					mjgM23g+hofa1DmxgK3HhEh7faz9n+iC3nhIiffbyGqPlq3phFjGfdvnsiqJ2zg5jhfgtDuLuN1OgtjtfhrPvBw1ztgpjwfiqsvOxmzMgsjtfirKvDw7zpgv
					jrfhrmu3wV0CgtjtfhrOvBw3zsgpjwfiqtvOxkzMgpjwfiqrvOxmzLgpjwfiqrvOxmzLgpjwfiqrvOxmzLgpjwfiqrvOxmzLgpjwfiqrvOxmzL]],
				["LowerLegF.R"] = [[
					hLg+fb7AjHgAw2hLhCfg76jHgLvUhLhHfl8ojGgVt8hLhGfk8hjHgTuJhLhFfi8RjHgQuphRhCfm77ighKvWhThBfm7oiShev4hQhAfi7hirg0wEhLhAfd7e
					jHgGwGhLhBfc7PjWgDwbhWhWfe6mlIhmw7hkiBfh5Woikew+hpi0fm3SsZoAwPhhjafr01vmrLu4hUjvfvy6xhtNtmhQj1fvyTyDtytKhUjwfvy1xltStihX
					jsfuzTxJs0t3hUjwfvy5xitOtlhQj1fvyUyCtytKhQj1fwySyDtztJhQj1fwySyDtztJhQj1fwySyDtztJhQj1fwySyDtztJhQj1fwySyDtztJ]],
				["FootF.R"] = [[
					hOgjfN/lgAgAlIhOgpfP/0gAgAjXhOgvfS/8gAgAhzhOgufR/7gAgAiChOgsfQ/4gAgAilhVgpfV/zf0hIjRhYgnfX/ufwhkj2hTgmfT/tf3g2kIhOgmfO/t
					gAgAkQhPgmfN/pgNf6kpheg7fQ/diggtlPhzhqfV+sm2iDliiAijfb88r9jxlXh8jSfh6hwYlXk0hyjufl4ezImZkNhtj1fn3zz6msj/hxjvfm4ZzOmckLh0
					jpfl45ymmNkVhxjufl4dzJmakMhtj1fn30z4msj/htj1fn3zz6mtj/htj1fn3zz6mtj/htj1fn3zz6mtj/htj1fn3zz6mtj/htj1fn3zz6mtj/]],
				Tail1 = [[
					gAiBhLiIgAgA/7gAh/hWjAgAgA/2gAh9hfjygAgA/xgAh+hejrgBgA/xgAh+hajZgAgA/zf+h/hWjDeGgF/yf9h/hTiwdXgI/wf+iAhRioemgF/2gAiAhQik
					gAgA/4gAiBhOiYgQgL/5gBiLhMiMgTik/0gCichLiFg1nE/HgDiqhLh2hesa9ZgEivhLhgiAxE68gEiwhLhMiV0B40gEiwhLhFia024IgEiwhLhLiV0H4vgE
					iwhLhQiRzc5RgEiwhLhMiV0C4zgEiwhLhFia004JgEiwhLhFia024HgEiwhLhFia024HgEiwhLhFia024HgEiwhLhFia024HgEiwhLhFia024H]],
				Tail2 = [[
					gAh9hjicgAgA/5gAh6hujVgAgA/0gAh4h3kHgAgA/ugAh4h2kAgBgA/vgAh5hzjugAgA/xf7h6hujXdVgI/sf5h7hrjEcUgN/of8h8hpi8eCgI/ygAh8hpi5
					gAgA/3gBh9hmitgXgK/4gBiIhkiigdij/ygEiZhjiZhRnC/FgGiohjiDiOsV9XgIivhjhfjCw966gIiwhjg+jhz34zgIixhjgzjp0s4HgIiwhjg9jiz+4ugI
					iwhjhFjbzU5QgIiwhjg+jhz54ygIixhjg0jp0r4IgIixhjgzjp0t4GgIixhjgzjp0t4GgIixhjgzjp0t4GgIixhjgzjp0t4GgIixhjgzjp0t4G]],
				Tail3 = [[
					gAh6h8iDgAgA/7gAh1iGi8gAgA/2gAhxiPjtgAgA/xgAhyiOjmgBgA/ygAhziLjUgAgA/0f3h1iGi9clgI/qfzh2iCiqbRgN/hf5h3iCiidegI/ygAh3iBif
					gAgA/5gBh5h/iTgegK/5gCiEh9iKgjij/0gHiWh8iBhinB/HgLimh8hlitsT9XgNivh8g3jrw665gNizh7gNkQzy4xgNi0h7f+kZ0m4FgNizh7gLkRz44sgN
					iyh7gVkJzP5OgNizh7gMkQzz4wgNizh7f/kZ0l4GgNi0h7f+kZ0m4EgNi0h7f+kZ0m4EgNi0h7f+kZ0m4EgNi0h7f+kZ0m4EgNi0h7f+kZ0m4E]],
				Tail4 = [[
					gAh2iUe8gAgA/+gAhxiff1gAgA//gAhsingngAgA//gAhsimgggCgA//gAhuijgOgAgA//fyhwief4b1fv/tfshyiafmaPfs/df1hziafcc6f2/1gAh0iafY
					gAgA//gCh2iXfMgjgN/+gEiAiVfFgbim/3gJiTiUfAhNnJ/JgPimiUeoiIsh9VgSixiUd9i5xK6xgSi2iTdWjT0D4kgSi4iTdIjZ0332gSi3iTdUjU0J4egT
					i2iTdejOzf5CgSi3iTdVjT0E4jgSi4iTdIjZ0133gSi4iTdIjZ0331gSi4iTdIjZ0331gSi4iTdIjZ0331gSi4iTdIjZ0331gSi4iTdIjZ0331]],
				Tail5 = [[
					gAh4itbygAgA/tgAhxi3crgAgA/0gAhrjAddgAgA/4gAhsi/dVgCgA/4gAhui8dDgAgA/2frhxi2cwbIfN/cfjhzixcgZRe+/Efwh0iycUcYfd/kgAh1iycO
					gAgA/xgDh3iwcDgogS/vgEiCiub9gTip/ngLiVitb8g2nR+4gSipitbphhsu8/gUi2isbDiCxZ6TgUi9irafiS0S4AgTi/iraTiW1G3PgUi9iraeiT0Z36gU
					i8iraniQzv4fgUi9irafiS0U3+gTi/iraTiW1F3RgTi/iraTiW1G3PgTi/iraTiW1G3PgTi/iraTiW1G3PgTi/iraTiW1G3PgTi/iraTiW1G3P]],
				["UpperLegB.L"] = [[
					fBhggx4BXxgAzcfBhgg65EXyfjyFfBhghC57X0fJw1fBhghB5zX0fMxBfBhgg+5gXzfWxdfBhgg25HXGgYxtfBhggx4xW0g3yCfBhggy4oXQgYydfBhgg14j
					XxfxyxfChgg04ZX/f4zEfIhhgx5BZwhXy4fXhjgx6Kdijqx4fvhmgx60idmEwLgHhogx6inNn5uUgXhsgx51qdo6s8gbhtgx5jrapKshgXhsgx5zqlo8s4gU
					hrgx6Ap0outNgXhsgx51qfo6s7gbhtgx5jrZpKshgchtgx5jrbpKsggchtgx5jrbpKsggchtgx5jrbpKsggchtgx5jrbpKsggchtgx5jrbpKsg]],
				["LowerLegB.L"] = [[
					e1g8gmwvd6gA7Me1g9gryOd6f56Ne1g+gwzed7fy5Se1g+gvzTd7fz5be1g9guy2d7f15we1g9gmySc8ge6Ee2g9gixyckgw6We1g8glxldMgY6le1g8gpxe
					d6f86te2g8goxMeIgD66fBg7glxRfTiJ61fbg+gjxph4l25+f/hFggxqlOqG4IgfhPgdxFoatq1ygzhZgcwWqkv0z2g5hcgbwErNwbzPg0hZgcwUqpv5zygw
					hWgcwhqJva0Qg0hZgcwVqlv2z1g5hcgbwFrMwazQg5hcgbwErNwbzOg5hcgbwErNwbzOg5hcgbwErNwbzOg5hcgbwErNwbzOg5hcgbwErNwbzO]],
				["FootB.L"] = [[
					eygjgz/jgAgAlReygig1/zgAgAjgeygjg3/7gAgAh9eygjg3/6gAgAiLeygjg2/4gAgAivexgjgv/yf0hIjaexgjgt/sfvhkj/exgjgw/sf3g1kReygig0/s
					gAgAkZezgig0/ogNf5kwfCgigx/hijgZkxfkglgu+6nDg8kIgPgxgp9SsahVjJg2hBgm65xIhbiOhNhQgj4z0GhVhphThVgi4H08hShehOhRgj4t0NhUhnhJ
					hNgk5PzhhXhwhNhQgj4y0IhVhohThVgi4I07hShehUhVgi4G08hShehUhVgi4G08hShehUhVgi4G08hShehUhVgi4G08hShehUhVgi4G08hShe]],
				["UpperLegB.R"] = [[
					g/hggx4BoPgAzcg/hgg65EoOgdyFg/hghC57oMg3w1g/hghA5zoNgzxBg/hgg+5goNgqxdg+hgg/5HnhhWySg+hgg94xnQhhy2g+hgg54onug5y5g/hgg14j
					oPgPyxg/higz4ToegJzAhEh1gx3mqKhry/hIiagx2PthkayFhGjAgxz+xZnewUg8jagxxN0sp5uMgxjmgxu/2srRsigtjpgxuR3ProsBgwjngxu52wrUsegz
					jkgxvc2UrBs4gxjmgxu+2trSshgtjpgxuS3OrosBgtjpgxuR3QrosAgtjpgxuR3QrosAgtjpgxuR3QrosAgtjpgxuR3QrosAgtjpgxuR3QrosA]],
				["LowerLegB.R"] = [[
					hLg8gmwviGgA7MhLg9gryOiGgH6NhLg+gwzeiFgO5ShLg+gvzTiGgN5bhLg9guy2iFgL5whMg9gxyShHgu6OhMg8gxxygvg66khMg8gtxlhYgh6shLg8gpxe
					iGgE6thMg+gnxKiUgI65hWhTgmw1jdiN65hjh/gkwdl5mA6Hhoixgivmo4qa4WhgjXgguTrluK2AhUjsgftItUwd0EhQjxgesvt0xGzchUjsgftFtYwiz/hX
					jogftYs/wB0ehUjsgftHtVwe0DhQjxgesvt0xFzdhQjxgesut1xGzchQjxgesut1xGzchQjxgesut1xGzchQjxgesut1xGzchQjxgesut1xGzc]],
				["FootB.R"] = [[
					hOgjgz/jgAgAlRhOgig1/zgAgAjghOgjg3/7gAgAh9hOgjg3/6gAgAiLhOgjg2/4gAgAivhOgig7/yf0hIjahOgig8/sfvhkj/hOgig4/sf3g1kRhOgig0/s
					gAgAkZhQgkgz/ogNf5kwhdg7gy/gijgak4hxhpgv+4nChBkch9ihgs9OsZhjjqh5jPgq61xFh2i5hvjpgo4v0Dh7iYhrjwgn4D05h8iOhvjqgo4q0Kh7iXhy
					jkgo5Lzeh7ifhvjpgo4u0Eh7iYhrjwgn4E03h8iPhrjwgn4C05h8iOhrjwgn4C05h8iOhrjwgn4C05h8iOhrjwgn4C05h8iOhrjwgn4C05h8iO]],
			},
		},
	},
}
