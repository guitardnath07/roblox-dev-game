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
					gAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAAD
					gAgAhbgAhfgAADgAf3hbgAhggAADgAgAhbgAhkgAAEgCg2hbgAhkgAAGgFhmhbgAhggAAGgFhmhbgAhfgAAEgDg/hbgAhigAADgAgAhbgAhlgAAEf9fBhbgA
					hkgAAGf7eahbgAhggAAGf7eahbgAhfgAAEf9fBhbgAhigAADgAgAhbgAhlgAAEgDg/hbgAhkgAAGgFhmhbgAhggAAGgFhmhbgAhfgAAEgDg/hbgAhigAADgA
					gAhbgAhlgAAEf9fBhbgAhkgAAGf7eahbgAhggAAGf7eahbgAhfgAAEf9fBhbgAhigAADgAgAhbgAhlgAAEgDg/hbgAhkgAAGgFhmhbgAhggAAFgEhXhbgAhf
					gAADgBgfhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhb]],
				Spine2 = [[
					gAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbAD
					gAgAhbgAhifbADgAf3hbgAhkfbADgAgAhbf+hofbAEgCg2hbf8hnfbAGgFhmhbf8hjfbAGgFhmhbf+hifbAEgDg/hbgAhlfbADgAgAhbgChpfbAEf9fBhbgE
					hnfbAGf7eahbgEhjfbAGf7eahbgChifbAEf9fBhbgAhlfbADgAgAhbf+hpfbAEgDg/hbf8hnfbAGgFhmhbf8hjfbAGgFhmhbf+hifbAEgDg/hbgAhlfbADgA
					gAhbgChpfbAEf9fBhbgEhnfbAGf7eahbgEhjfbAGf7eahbgChifbAEf9fBhbgAhlfbADgAgAhbf+hpfbAEgDg/hbf8hnfbAGgFhmhbf9hjfbAFgEhXhbf/hi
					fbADgBgfhbgAhjfbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhb]],
				Spine3 = [[
					gAhle3AbgAgAlDgAhle3AdgAgAlPgAhle3AegAgAlZgAhle3AfgAgAldgAhle3AfgAgAlcgAhle3AegAgAlWgAhle3AcgAgAlLgAhle3AagAgAk/gAhle3AY
					gAgAk0gBhle3AXf/f3ksgAhne3AXgAgAkpf8hre3AYgKg/krf5hre3AdgViIkzf5hne3Aggaihk+f7hme3AggViFlLgAhpe3AfgLhHlWgFhse3AfgAgJlcgH
					hre3Aff5fildgHhne3Aef5filYgFhme3AdgBgIlPgAhpe3AcgLhHlDf7hse3AcgShwk3f5hre3AagPhlktf5hne3AXgGgzkpf7hme3AXf9f4kqgAhpe3AZf0
					e6kwgFhse3Aefrd7k6gHhre3AjfldVlGgHhne3AkfkdVlSgFhme3Ajfrd7lagAhpe3Agf2e5ldf7hse3AfgAf3lbf5hre3AegHgllTf6hne3AcgHgtlHf+hl
					e3AZgCgRk7gAhme3AYgAgAkwgAhle3AXgAgAkqgAhle3AXgAgAkpgAhle3AXgAgAkugAhle3AZgAgAk3]],
				Spine4 = [[
					gAhxeUAbgAgAlIgAhxeUAfgAgAlggAhyeUAjgAgAlzgAhyeUAlgAgAl8gAhyeUAkgAgAl6gAhxeUAigAgAltgAhxeUAegAgAlYgAhxeTAagAgAlAgAhweTAX
					gAgAkpgBhweTAUf/f3kZgAhyeTAUgAgAkTf6h2eTAWgLhKkYf0h2eUAegbirkofzhyeUAmgkjdk+f3hxeUAoghjLlXf+h1eUAngWiNlsgEh4eUAmgJhPl6gI
					h3eUAlgCgpl8gIhzeUAjgDgplygEhxeUAhgLhPlgf+h0eUAggXiNlHf4h3eUAegaiikvf1h1eUAXgOhlkdf3hxeUAUf8gBkUf8hweTAVfweykVgChzeTAbfo
					dzkigJh3eUAjffc1k2gNh2eUArfZcPlOgNhzeVAvfYcPllgJhyeUAuffc1l1gCh1eUAqfrdzl8f8h4eUAlf2exl3f3h3eUAhf+fllnf4hyeUAdgBgElQf9hx
					eTAZgAgCk4gAhxeTAWgAf/kigAhweTAUgAgAkVgAhweTAUgAgAkUgAhweTAVgAgAkdgAhweTAYgAgAkw]],
				Head = [[
					gAh9dxABgAgAgNgAh+dxABgAgAglgAh/dxACgAgAg4gAh/dxACgAgAhCgAh/dxACgAgAhAgAh+dxACgAgAgzgAh9dxABgAgAgdgAh8dwABgAgAgEgAh7dwAB
					gAgAftgBh6dwABgQf2fegAh7dwABgAgAfyf3iAdwAFephRg5fuiAdxARdei3hQfsh9dyAVdbjigtfwh+dyAOeZjNgqf5iCdyAJgDiPhogBiGdyAMhqhMikgH
					iEdyANingliTgHiAdyAKingqhKgBh+dxAGhohQgkf5iAdxAHgFiPhCfyiCdxANehirhlfyiAdxAMdahxg/f3h7dwAIdTgIfuf+h6dwAGeTe0fZgHh+dwAGf6
					dxgcgQiCdxARhccshvgViCdzAaidcGh9gVh/dzAYikcMhWgQh/dzAPhnc0hKgHiDdyAJf9dxh4f/iFdyALeWe0igf4iDdxAMdYfqh+f4h+dxAGdwgGgof9h8
					dwACfLgDf+gAh7dwABgAf/fvgAh6dwABgAgAfagAh6dwABgAgAfYgAh6dwABgAgAfhgAh7dwABgAgAf0]],
				Jaw = [[
					gAhsdL/+gAgAhCgAhudL/+gAgAhCgAhwdL/+gAgAhCgAhxdL/+gAgAhCgAhxdL/+gAgAhCgAhvdL/+gAgAhCgAhtdL/+gAgAhCgAhrdL/+gAgAhLgAhpdL/9
					gAgAhigBhodL/8fwgJhygAhqdK/9gAgAhdf2hxdJ/7haeygWfqhydL/wiodPf+fmhudM/riuckgifqhudM/xhwc4g1fzh1dL/6gFdxgNf9h7dK/7ebetfegD
					h5dK/4dcfQfxgDhydL/3dcfNgwf9hudL/6ecerhEfzhxdL/6gBdxgNfth0dK/2hmdZfqfwhxdK/1ireVgQf5hqdL/1iuf/hhgDhodL/3hqhRh2gNhudL/5gA
					iPgzgXh1dL/yecjQfggdh1dM/pdZj0fZgchxdN/qdPjqgXgWhxdM/yeNjFg1gNh2dL/6f6iPgNgDh7dK/7hlhTfef8h3dK/4ingffwf6hvdL/5iQgAgvf+hr
					dL/9g1f/hSgAhpdK/9gAgBhggAhodL/8gAgAh1gAhndL/8gAgAh3gAhodL/8gAgAhugAhqdL/9gAgAhb]],
				Antenna1 = [[
					gAkOcRGWgAgAzGgAkRcVGmerg+zYgAkUcYG2d2hizkgAkVcZG7d1hizsgAkVcZG3eqg9ztgAkTcXGtgAgAzkgAkQcUGihVfCzSgAkMcQGWiIeay7gAkJcMGJ
					iHeZyogEkHcKF/h0eaydgAkKcMGGgAgAywfkkUcYHWb1khzcfHkUcfJBY1obzTfAkOccI3ZRpFy+fPkQcaHpcYmizWftkbcgHShXhx0LgLkjcoITmbdM0Tgc
					kfcmJCpZabzagbkVcbIVpQaPyjgJkRcVHCmPc/ywfskWcaG6hYhwztfVkZchIGcFl60CfQkScaIpYLnsy5fekHcMHpXVmvxlf3kGcJGYZ2jRx1gUkQcUGjen
					eRzPgwkacjITjiZo0MhCkZcpJsmmW/0AhCkTcjJUmqW3zggxkUcfH8jsZkzugTkdcjHcepeP0Xf1kicoIRZli10QfikcciI5Wyl2zOfjkQcVH0YLlzyif1kL
					cPGccoimyvgAkJcMGEf/f/yugAkGcJF6hTe/ybgAkGcJF8iFeXyXgAkHcKGCiGeYyfgAkKcNGJhTfAyx]],
				Antenna2 = [[
					gAlgb4BGimfWn0f4lkb+Ave4gOmqfylmcDBPbkg4nefylocFCEaDhipaf4locFCHawhep/gAlmcBBQdZgnoZgIlib8AuhIfymjgOleb2BDkafBmsgOlabxBs
					l5eOoLgRlXbtCEnAdioegAlcbxBYlaeknVfDlhcEBLbriFnCePlUcTFtQolioDeHlNcQJVM/oHpCeolbcKHfPknpprfqlvcPCrYTjypdgslxcZBnlfgZoWhQ
					lhcUFjwOd6nfhPlWcEIo0IbZnGgplcb7Gqxmb7nafqlpcGCQo0gOnwewlmcUBhbcjcn1eZlScKFgQWkunWeplFbyIfMMmDmZfWlPbqGbOjkumdgXljb9CHXN
					f8nNhVlncZBokZb9oCh6lackGCvHZ4pGh7lUcbJjzBYDpshXlgcRHnwhYoqEgWlxcTCwnucSprfUlwcYBnahfnoTetlecQFgP1icnUezlUb/HON6lBnhfgla
					b1DnUijpofgAlbbxBFcmg6nWgIlXbsAhhIfwlggOlWbsA6kZe6mBgOlXbuBpl4eMn/gIlbbyBxlMeWo4]],
				["FinF1.L"] = [[
					e7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZ
					HdfZxre8hIeMpzG+fJxTe7hJeNnOFydwwse1hNeQmtFuduwyewhNeUptG4fYxQewhJeUptG4fYxQe0hIeRmBFedgwoe7hLeNjzEjcXvjfChOeJmKEgd4u+fH
					hNeGpuFSgWuqfHhJeGpuFSgWuqfChIeJmKEgd4u+e7hLeNjzEjcXvje0hOeRmBFedgwoewhNeUptG4fYxQewhJeUptG4fYxQe0hIeRmBFedgwoe7hLeNjzEj
					cXvjfChOeJmKEgd4u+fHhNeGpuFSgWuqfHhJeGpuFSgWuqfChIeJmKEgd4u+e7hLeNjzEjcXvje0hOeRmBFedgwoewhNeUptG4fYxQexhJeTp0G9fXxUe3hI
					ePoTGYeVxKe7hIeNpfG7e5xae7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxre7hIeNqZHdfZxr]],
				["FinF2.L"] = [[
					d6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2
					JrfS0rd7gydtpUJKe90Vd4hAdrm7H9dQzudyhGdwmbH5dKz0dvg3d1pLJDfL0Sdvgzd1pLJDfL0SdxhDdwlxHoc2zpd6hRdnjvGobdykeEhJdfl9GedNyHeO
					g3dbpOHJgFx6eOgzdbpOHJgFx6eEhDdfl9GedNyHd6hRdnjvGobdykdxhJdwlxHoc2zpdvg3d1pLJDfL0Sdvgzd1pLJDfL0SdxhDdwlxHoc2zpd6hRdnjvGo
					bdykeEhJdfl9GedNyHeOg3dbpOHJgFx6eOgzdbpOHJgFx6eEhDdfl9GedNyHd6hRdnjvGobdykdxhJdwlxHoc2zpdvg3d1pLJDfL0Sdxgyd0pSJJfL0Wd1g5
					dvn6Ikd+0Md5g0dupBJIeq0bd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0rd6gvdwp2JrfS0r]],
				["FinF1.R"] = [[
					hFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ
					4jgnxrhGhIeNpz44g9xihFhJeNnO6OiQwsg/hNeJm07Jh7vZg5hNeGpu6ufquqg5hJeGpu6ufquqg+hIeJmK7giIu+hFhLeNjz7djpvjhMhOeRmB6iigwohQ
					hNeUpt5IgoxQhQhJeUpt5IgoxQhMhIeRmB6iigwohFhLeNjz7djpvjg+hOeJmK7giIu+g5hNeGpu6ufquqg5hJeGpu6ufquqg+hIeJmK7giIu+hFhLeNjz7d
					jpvjhMhOeRmB6iigwohQhNeUpt5IgoxQhQhJeUpt5IgoxQhMhIeRmB6iigwohFhLeNjz7djpvjg+hOeJmK7giIu+g5hNeGpu6ufquqg7hJeHp16bfzvIhChI
					eKoW6JhawXhFhIeNpf5FhHxahFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxrhFhIeNqZ4jgnxr]],
				["FinF2.R"] = [[
					iGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp2
					2Vgu0riHgydvpT2rhI0iiIhAdrm74Diwzuh+hGdhmk5Iigyhhyg3dbpO43f7x6hygzdbpO43f7x6h8hDdfl95iizyHiGhRdnjv5YkjykiPhJdwlx4YjKzpiR
					g3d1pL29g10SiRgzd1pL29g10SiPhDdwlx4YjKzpiGhRdnjv5Ykjykh8hJdfl95iizyHhyg3dbpO43f7x6hygzdbpO43f7x6h8hDdfl95iizyHiGhRdnjv5Y
					kjykiPhJdwlx4YjKzpiRg3d1pL29g10SiRgzd1pL29g10SiPhDdwlx4YjKzpiGhRdnjv5Ykjykh8hJdfl95iizyHhyg3dbpO43f7x6h1gydepU4ggCyViCg5
					dnn+4DhzzdiHg0dupB24hW0biGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0riGgvdwp22Vgu0r]],
				Tail1 = [[
					gAhfgAfKgAgA/+gAhfgAfKgOgA/+gAhfgAfKgcgB/+gAhfgAfKgpgB/+gAhfgAfKg0gB/+gAhfgAfKg/gC/9gAhfgAfKhIgC/9gAhfgAfKhQgC/9gAhfgAfK
					hVgC/9gAhfgAfKhPgC/9gAhggAfKhZgC/8gAhkgAfLiOgE/5gAhkgAfLi7gF/2gAhggAfLi1gF/2gAhfgAfLiHgE/6gAhigAfKg/gC/9gAhlgAfKf2gA/+gA
					hkgAfKfDf+/9gAhggAfKe2f+/9gAhfgAfKfPf//+gAhigAfKgAgA/+gAhlgAfKgxgB/+gAhkgAfKhKgC/9gAhggAfKg9gC/9gAhfgAfKgKgA/+gAhigAfKfB
					f+/9gAhlgAfLd5f8/6gAhkgAfLdLf7/2gAhggAfLdFf7/2gAhfgAfLdpf8/5gAhigAfKenf+/8gAhlgAfKfnf//+gAhkgAfKgRgA/+gAhggAfKgHgA/+gAhf
					gAfKfXf//+gAhfgAfKfBf+/9gAhfgAfKfMf//+gAhfgAfKfXf//+gAhfgAfKfkf//+gAhfgAfKfygA/+]],
				Tail2 = [[
					gAhhgzfBfEgB/9gBhhgzfBfkgB/+gBhhgzfBgEgB/+gChhgzfBglgB/+gDhhgzfBhEgB/9gDhhgzfBhigB/8gEhhgzfBh9gB/6gEhhgzfBiWgB/5gEhhgzfB
					iqgB/3gEhigzfBiygA/2gEhjgzfBjHgA/0gHhngzfBkDgC/ugJhngyfBk0gD/ngJhjgyfBkxgD/ngHhigzfBkDgB/ugDhlgzfBi3f//2f/hogzfBhnf9/7f9
					hngzfBgqf8/+f8hjgzfBgRf8/+f+higzfBgcf9/+gAhlgzfBg8f//9gChogzfBhbgB/8gEhngzfBhigC/8gDhjgzfBhBgC/9gBhigzfBf7gB/+f9hlgzfBee
					f//8f5hogzfBdEf9/1f3hngyfBcFf8/vf3hjgyfBbwf8/sf4higzfBcHf+/vf8hlgzfBc5gA/0f/hogzfBdxgC/5gBhngzfBeWgD/7gAhjgzfBeLgD/7f+hi
					gzfBdbgB/3f9higzfBdJgB/2f9hhgzfBdbgB/3f+hhgzfBdwgB/5f/hhgzfBeJgB/7f/hhgzfBelgB/8]],
				Tail3 = [[
					f9hlhmf3c9gR/2f/hlhmf4dsgO/6gChlhmf4eegM/9gEhlhmf4fTgJ/+gGhlhmf4gJgF//gIhlhmf4g/gC/+gKhlhmf4hzf//8gLhlhlf3ilf7/4gNhlhlf3
					jSf4/0gNhlhlf3jxf1/xgOhmhlf3kcfy/rgUhqhkf2lrfw/egYhqhjf2mufv/RgYhmhjf2m5ft/PgUhlhkf2mVfs/WgMhohlf3lSfr/jgFhrhmf3kFfq/uf/
					hqhmf4jJfr/1f9hmhmf4irfs/4f/hlhmf4iuft/3gDhohmf3jDfv/2gHhrhmf3jTfy/0gJhqhmf3jHf1/1gGhmhmf3iTf4/6gAhlhmf4g2f7/+f4hohmf4fB
					f+/+fwhrhlf4dOgB/3frhqhkf3b2gE/ufphmhjf3bJgH/nfshlhkf3bIgL/nfyhohlf3bkgO/rf4hrhmf3cIgQ/wf8hqhmf3ccgS/yf7hmhmf3cCgU/vf2hl
					hlf3bIgV/nf0hlhlf3augV/jf1hlhlf3a8gV/lf3hlhmf3bSgV/of5hlhmf3bvgU/tf7hlhmf3cTgS/x]],
				Tail4 = [[
					fzhliYfbZ9gp/Zf4hliZfcavgn/if9hliZfcbqgk/rgChliZfdcsgf/zgGhliZfddzgb/6gLhliZfde+gV/+gQhliYfdgLgP//gUhliYfdhYgI/9gXhliXfc
					iigC/4gZhliXfcjff7/zgchniWfbkof1/pgmhqiUfamVfv/WgthqiSfZn0fq/BguhmiRfZoZfl+3gnhliTfZoOfg+6gdhoiWfanhfb/FgShriXfbmofX/SgJ
					hqiYfcl6fV/bgGhmiYfdlmfU/fgIhliYfclufV/dgNhoiYfbmDfX/ZgRhriYfbmPfa/XgShqiYfbl7fe/bgOhmiZfbk5fi/mgDhliZfcjLfn/0f1hoiZfdhC
					fr/+fnhriXfde2fw/9fdhqiVfddDf2/2fahmiUfdb5f8/ufdhliVfcbagE/pfkhoiWfbbYgL/pfrhriXfcbegT/qfwhqiYfcbUgZ/ofuhmiXfbafge/gfmhl
					iWfaZOgi/QfjhliWfaYfgl/FflhliWfaYbgo/EfohliWfaYjgq/GfrhliXfaY2gq/KfvhliYfbZUgq/R]],
				Tail5 = [[
					fghmjIgQW3hh+nfnhmjJgRXchg+yfvhnjKgTYPhd+/f3hnjLgVZOhX/Of/hnjMgWaXhQ/dgIhnjMgXbrhG/rgQhnjMgYdFg7/1gYhnjLgZelgu/8gfhnjKgZ
					gHgg//gkhnjJgYhfgR/9grhojHgXjIgC/1g6hsjDgVlWfy/ihGhsi/gTnXfj/IhIhoi+gQoffV+1hBhnjAgPo2fI+ug0hqjDgQoqe9+xgmhtjGgRoQez+4gc
					hsjIgToAes+8gXhojIgToGel+6gahmjIgSojeh+ygghqjIgQpJef+nglhtjHgOpgeg+gglhsjIgOpTei+kgdhojJgQoVeo+2gNhnjLgUmmew/Rf4hqjMgXkV
					e6/rfjhtjKgah8fG/6fUhsjHgbf1fT/+fNhojGgaeTfh/8fOhnjGgZdZfw/4fVhqjHgXc4f+/1fdhtjIgWcdgN/yfhhsjJgVbxgb/tfdhojHgUaZgq/ffRhm
					jFgSYlg3/GfMhnjDgQXWhD+xfOhmjDgPWzhN+nfRhmjEgOWehV+gfVhmjFgOWYhb+efahmjGgPWghf+g]],
				["FinB1.L"] = [[
					e+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoG
					OTfH5Xe+hEgVn+N4fF5Ge+hGgVnaNKel4ue/hKgZnPNKei4xfAhKgcn3NvfO5DfAhGgcn3NvfO5De/hFgZnFM+ed4re+hIgVmpMEeF4Ce9hLgRnKLge53de8
					hKgPn5LWgA3He8hGgPn5LWgA3He9hFgRnKLge53de+hIgVmpMEeF4Ce/hLgZnFM+ed4rfAhKgcn3NvfO5DfAhGgcn3NvfO5De/hFgZnFM+ed4re+hIgVmpME
					eF4Ce9hLgRnKLge53de8hKgPn5LWgA3He8hGgPn5LWgA3He9hFgRnKLge53de+hIgVmpMEeF4Ce/hLgZnFM+ed4rfAhKgcn3NvfO5DfAhGgbn5N1fN5Ge/hF
					gXnnNoew5Be+hFgVn6N9e95Le+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5Xe+hEgVoGOTfH5X]],
				["FinB2.L"] = [[
					eDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoU
					O6fH5teDgtgkoMOefE5deBgyginpNvek5FeCg2gmneNweh5JeFgygroEOWfN5aeFgugroEOWfN5aeCgygmnUNkeb5Cd/g4gem5MoeE4bd+g4gWnZMDe433d/
					gygSoHL6gA3hd/gugSoHL6gA3hd+gygWnZMDe433d/g4gem5MoeE4beCg4gmnUNkeb5CeFgygroEOWfN5aeFgugroEOWfN5aeCgygmnUNkeb5Cd/g4gem5Mo
					eE4bd+g4gWnZMDe433d/gygSoHL6gA3hd/gugSoHL6gA3hd+gygWnZMDe433d/g4gem5MoeE4beCg4gmnUNkeb5CeFgygroEOWfN5aeFgugqoHObfM5deDgv
					gmn2OOev5YeDgugloIOke85ieDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5teDgsgmoUO6fH5t]],
				["FinB1.R"] = [[
					hChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoG
					xtg55XhChEgWn9x6hA5RhChGgVnay2hb4uhDhKgSnT0HhF3whEhKgPn50qgA3HhEhGgPn50qgA3HhDhFgRnK0ghH3dhChIgVmpz8h74ChBhLgZnFzChj4rhA
					hKgcn3yRgy5DhAhGgcn3yRgy5DhBhFgZnFzChj4rhChIgVmpz8h74ChDhLgRnK0ghH3dhEhKgPn50qgA3HhEhGgPn50qgA3HhDhFgRnK0ghH3dhChIgVmpz8
					h74ChBhLgZnFzChj4rhAhKgcn3yRgy5DhAhGgcn3yRgy5DhBhFgZnFzChj4rhChIgVmpz8h74ChDhLgRnK0ghH3dhEhKgPn50qgA3HhEhGgQn70QgI3dhDhF
					gTnpzJhB4chChFgVn6yDhD5LhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55XhChEgVoGxtg55X]],
				["FinB2.R"] = [[
					h9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoU
					xGg55th9gtgmoLxThB5nh/gyginpyRhc5FiBg2gZnizjhG4JiBgygSoH0GgA3hiBgugSoH0GgA3hiCgygWnZz9hI33iBg4gem5zYh84bh+g4gmnUychl5Ch7
					gygroExqgz5ah7gugroExqgz5ah+gygmnUychl5CiBg4gem5zYh84biCg4gWnZz9hI33iBgygSoH0GgA3hiBgugSoH0GgA3hiCgygWnZz9hI33iBg4gem5zY
					h84bh+g4gmnUychl5Ch7gygroExqgz5ah7gugroExqgz5ah+gygmnUychl5CiBg4gem5zYh84biCg4gWnZz9hI33iBgygSoH0GgA3hiBgugVoJzrgI33iAgv
					gfn4yjhB40h9gugloIxchE5ih9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55th9gsgmoUxGg55t]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Spine1 = [[
					gAhfgAADgAgAhbgAhigAADgBgdhbgAhkgAAEgCg1hbgAhigAAEgDhEhbgAhggAAEgDhHhbgAhjgAAEgDg+hbgAhkgAADgCgqhbgAhhgAADgBgPhbgAhhgAAD
					f/fxhbgAhkgAADf+fWhbgAhjgAAEf9fChbgAhggAAEf9e5hbgAhigAAEf9e8hbgAhkgAAEf+fLhbgAhigAADf/fjhb]],
				Spine2 = [[
					gAhifbADf/fvhbf/hmfbADgAf5hbf+hnfbADgAgEhbf+hlfbADgBgOhbf9hjfbADgBgWhbf+hmfbADgBgahbf+hnfbADgBgZhbf/hkfbADgBgUhbgBhkfbAD
					gBgMhbgChnfbADgAgBhbgChmfbADgAf3hbgDhjfbADf/fthbgChlfbADf/fnhbgChnfbADf/fmhbgBhmfbADf/fphb]],
				Spine3 = [[
					gBhle3Abf4fRlDf/hpe3Abf4fLlDf+hqe3Abf4fPlDf9hoe3Abf6fclDf9hme3Abf9fvlDf9hqe3AbgBgElDf+hqe3AbgEgZlDf/hne3AbgHgqlDgAhne3Ab
					gIgzlDgBhqe3AbgIg0lDgDhqe3AbgHgrlDgDhme3AbgEgblDgDhoe3AbgBgHlDgDhqe3Abf+fxlDgChpe3Abf7felD]],
				Spine4 = [[
					gChxeUAdfxemlIgBh1eUAefveYlHgAh2eUAefweclHf+h0eUAdfzexlIf9hyeUAcf5fUlIf9h1eUAbgAf/lIf9h2eUAcgHgplIf9hzeUAdgNhNlIf+hzeUAe
					gQhjlHgAh2eUAegRholHgBh1eUAegPhclIgChyeUAcgKg/lIgDh0eUAcgEgXlIgDh2eUAcf9fslIgDh1eUAcf2fDlI]],
				Head = [[
					gFh9dx/9gAhbgIgFiAdx/6f/iHgXgDiBdx/5f/ibgOgBh/dx/6gBiUfzf/h+dx/7gChzfZf9iBdx/9gBg/fQf7iBdx//gAgAfef7h/dx/+gAfBf7f7h/dx/8
					gBeMgSf8iBdx/6gCdsgVf+iBdx/5gAdlgCgAh+dx/6f+d5flgCh/dx/8f+elfRgEiBdx/+f/fgfUgFiAdx//gAggfs]],
				Jaw = [[
					gJhrdL/6f7hbhpgKhudM/3f4iGh3gJhwdM/2f4iahugGhvdL/4f6iUhUgDhudL/7f9hzg6f/hydK/9f+g/gxf7hxdK/+gAgAg/f4hudL/8gDfBhcf3htdM/5
					gGeNhzf3hvdM/2gJdsh2f4hwdM/3gHdmhif7hudL/5gFd5hGf/hwdK/8gCelgygDhydK/+gBfgg1gGhwdL/9f/gghN]],
				Antenna1 = [[
					gOkMcPGLdWgPyrgSkOcNGHbugryRgSkQcPGJcTf0ydgPkRcSGaeoeJzDgJkRcVG1hQc4zdgCkVcWG8ijc+zff7kUcUGnh3eqzUf1kPcQGUf8hSzAfwkNcNGX
					eYjhyufukPcNGceakIytfvkRcQGYgKi6y7f0kQcUGgijgvzIf6kUcWGxj4e+zPgBkVcVGwjDebzVgIkScSGbgWfHzM]],
				Antenna2 = [[
					gFldbzAweJe+mfgCldbvBaYbfplcgHlgbyCKXfgMnvgSljb6Bebye0odgaljcBBBi6dnm+gXlmcCCDnvdYntgHlmb9CZnSd2pafvlhb3BHiNgcn/fbldb0BB
					bfiyl8fXleb1CPYRkZnpfjlib4CRabkQpff5lib8BCgTiGnugLllb/BWmggPmZgSlnb/CaoeeUoggNllb6B3k7eBpT]],
				["FinF1.L"] = [[
					e8hIeLq+MQdk2he6hLeMpRLEb118e5hNeNnrJXbC0qe3hLeOmcHgbXy+e3hJeOl4F0cqxFe3hMeOmREmegvLe3hMeOnqECgWtfe5hKeOpyENh3sUe6hKeNq/
					EniasGe8hMeNrDFBiDtAe+hMeMrKF7hVuue/hJeLrPHRgYw4e/hLeLrOI6fWzEe/hNeLrIKhec03e+hLeLrCLvd02D]],
				["FinF2.L"] = [[
					d3greMqXPDdt4+dxg6eKoONqbW4cdvhGeEmPLyZ73NdvhJd7kyJsZv1idyhHdwkOHvawzud4hEdmk0GOcpyAeBg8demhFde9wleJgxdapAFohQvqeOgtdZqX
					GHiSvgeMgvdbqcGph8wWeIgvdhqiHwhQx9eCgsdqqnJYgWz9d+gud1qmLRfZ17d7gweAqhNHei3id5gueIqaOfd84k]],
				["FinF1.R"] = [[
					hHhIeOq+7bdksBhFhLeNrA7QdusbhDhNeMrH6meStxhChLeMrN5dfJvxhBhJeLrP38gJyAhBhMeLrM2RhI0ChChMeLrF0zh61jhDhKeLq/z6iX2YhFhKeMqH
					0RjZ2VhHhMeNod1wkt1XhIhMeNm/3kk9z3hJhJeOmD5ZkGyChKhLeOl964idwHhJhNeOm37ygjuShIhLeOoq7/e2s0]],
				["FinF2.R"] = [[
					hzgrdZqX58dtvbhzgudaqZ5td2v0h2gwdeqf44eYxFh7gudlql3gfMy8iAgsdwqn1tgJ0+iEgvd7qkzyhE2ziGgveEqdyIh04IiIgteKqYxIiP42iMgzeMpS
					xljk40iQhBeInMzPlh35iShJeAlb1QmV2ZiQhId1kX3Vl50oiLhGdqkY5HkZy1iEhBdilj6RiOxQh7g2dcns6lf4wD]],
				Tail1 = [[
					gAhfgAfKhUgC/9gAhigAfKg7gC/9gAhkgAfKgXgB/+gAhigAfKfwgA/+gAhggAfKfLf//+gAhjgAfKewf+/9gAhkgAfKeif+/8gAhhgAfKelf+/8gAhhgAfK
					e3f+/9gAhkgAfKfWf//+gAhjgAfKf8gA/+gAhggAfKgjgB/+gAhigAfKhEgC/9gAhkgAfKhZgC/8gAhigAfKhfgC/8]],
				Tail2 = [[
					gEhhgzfBkOf//sgDhlgzfBjMf//0gBhmgzfBhnf//7f/hkgzfBfwgA/+f9hjgzfBd8gA/6f8hmgzfBcegB/yf7hmgzfBbogB/rf7hkgzfBbigB/qf8hkgzfB
					cNgB/wf+hmgzfBdjgB/4gAhmgzfBfTgB/+gChjgzfBhMgA/9gDhkgzfBi3gA/2gEhmgzfBkCf//ugFhlgzfBkhf//q]],
				Tail3 = [[
					gShlhkf1n2fg/AgNhohlf2nAfg/NgGhqhmf3k9fn/mf+hohmf4iCfx/7f3hmhmf4evf+/9fxhphlf3brgM/sfthphkf2ZYgX/Tfthnhkf1YPgf/Bfwhnhlf2
					Yagh/Ef2hphlf2Z4gd/Zf+hphmf3cbgV/ygGhmhmf4fngI//gMhohlf3i3f7/3gRhqhkf2lmfu/fgThohkf2nXfl/I]],
				Tail4 = [[
					gqhliRfYqgfO+NgjhoiTfYq6fD+DgWhqiXfaphfC+hgFhoiZfcmdfL/UfzhmiZfeiPfe/5fjhpiWfddlf3/5fZhqiTfbZYgS/SfVhniRfZWZgp+gfZhniSfX
					VEg5+CfjhqiVfYVkg/+OfyhpiYfbX1g7+6gEhmiZfdbjgs/qgWhoiYfegHgW//gjhqiUfckpf8/pgqhoiSfaoTfi+4]],
				Tail5 = [[
					hKhmi5gOqee7+NhEhpi6gIs8eR9NgzhrjBgJtQd59CgZhpjIgPrZd490f6hojLgYnkeO/CfbhrjJgdiSe5/4fEhrjBgacjfw/ze4hoi7gTXggq+1e4hoi5gL
					UDhc9ofDhqi9gISph98/fZhqjEgLTaiK9Vf2hnjKgUWTiA+agWhqjLgba9hf/jgyhsjFgdgmgs/+hEhqi+gXmIfy/Z]],
				["FinB1.L"] = [[
					e+hEgVofJVh900e/hIgXojKDhr1ke/hJgZopLjhG2/fAhHgaotNqgV4ufAhFgaosQGff6Xe/hJgZonSaew7ne/hJgYoiUGeP8Ye+hGgWofU0eB8re+hGgUoB
					UCc68Ze9hJgTnER/bH7ce9hJgRmFPdaU6Fe9hFgRlPM5ap4ie9hHgRk3Kvb/3De9hJgSlTJTd91ze9hIgUmmIzgF1A]],
				["FinB2.L"] = [[
					eEgogMorJ2iA1SeEgsgSovKlht2BeEgtgbo1MHhH3aeGgrgno5ORgV5FeJgpgxo5Qvff6qeOgsg6o0TEeu73eSgtg+ouUxeN8meTgqg/orVfd/83ePgug8n8
					Unck8neHg5g1miSaaO7neBhAgrlSPzY96Id9hCggkaNMZA4gd7hEgWkPK+aW3Dd8hAgOk9Jhco19d/g2gLmiJHfW1X]],
				["FinB1.R"] = [[
					hChEgVofrQh98phDhIgUnjs5kG7/hDhJgSmlvQlb6zhDhHgRlox2lr5UhDhFgRk90Qkz3xhDhJgRk+2GjF2ZhDhJgTl23Fg/1VhChGgUng3Fe800hChGgWog
					2beJ1GhBhJgYom1Tem2OhBhJgZorzdfS32hAhFgaotxIgG5khAhHgaoqutg57ChBhJgZoksqhj8EhBhIgXograh68l]],
				["FinB2.R"] = [[
					htgog+orqliA82h1g0g5nOsbku8Mh8g9gwl4u4ml66iBhCgmkyxinN5UiEhDgbkO0Ame3viFhDgRke14km2ciDg8gMlp21iC1mh/gvgLnk2rfT1Qh8gqgOos
					15eH1jh8gtgWoy0wek2qh7gsgho4y4fR4Ph5gpgso5whgG56h0grg2o2uDg77Uhwgtg9oxr/hl8Shtgsg/osqvh98y]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Spine1 = [[
					gAhngAAFgAgAh5gAh3f7AGgAgAiPgAh+f5AFgAgAiHgAh3f7ADgAgAhlgAhngAACgAgAg8gAhngAABgAgAgmgAhngAACgAgAgvgAhngAADgAgAhR]],
				Spine2 = [[
					gAhrfbAFgAgAh5gAh9fXAGgAgAiPgAiDfVAFgAgAiHgAh7fXADgAgAhlgAhpfbACgAgAg8gAhofbABgAgAgmgAhpfbACgAgAgvgAhqfbADgAgAhR]],
				Spine3 = [[
					gAhwe3AZgAgAk7gAiCeyAbgAgAlCgAiIewAcgAgAlKgAh/eyAcgAgAlOgAhre2AcgAgAlLgAhqe2AbgAgAlEgAhqe2AagAgAk8gAhte2AZgAgAk5]],
				Spine4 = [[
					gAh7eUAUgAgAkagAiNePATgAgAkSgAiUeNAXgAgAkqgAiKePAdgAgAlTgAh3eTAjgAgAl2gAh1eTAlgAgAl+gAh2eTAhgAgAlmgAh4eTAagAgAk9]],
				Head = [[
					gAiFdw/8gAgAhtgAiXds/7gAgAiBgAiedq/+gAgAhCgAiXds//gAgAfVgAiEdx/7gAgAd6gAiDdx/5gAgAdmgAiCdx/9gAgAelgAiDdw//gAgAgS]],
				Jaw = [[
					gAhwdM/hgAgAlbgAiBdI/egAgAlvgAiLdF/ogAgAkxgAiHdG/2gAgAjEgAh5dJ/8gAgAhpgAh4dJ/9gAgAhVgAh1dK/6gAgAiUgAhydL/vgAgAkB]],
				Antenna1 = [[
					gAkKcAEpd6howXgAkZb5FWeIhpxhgAkocAGtfXglzjgAkqcRIDg+fM1KgAkgcjIeiKed1ggAkgcmHkiHes0ggAkaccGBgvfjyogAkRcME3e8gtw3]],
				Antenna2 = [[
					fzlVbXAbbmhBiTfzlnbXBIaGh3lof7l7bqCOb+haq3gHmAcGCagIfzsIgOl0cbB/kdfPqEgNl0cXB4mIfCoxgElscBBQkIe6ntf6lebmAVfzf5kb]],
				["FinF1.L"] = [[
					e7hTeMrKNsco3ge7hmeHnHKHYr0+e7hseFkDFuaRw1e7hheIlMDJfZsxe7hNeNqqD9jhqge7hKeOqsE6i6s4e7hLeOq3H2ghx7e7hPeNq7Lxd52J]],
				["FinF2.L"] = [[
					d2g2eUqlQoc25ydwhoeElbMsXW3Xd3h4dph/H1XszIeEhadVjtEddGvkeVgudUqAFPjVt/eMgqddp/GeivwPd8gtdyqKKDge06d2gyeKqSOheA4p]],
				["FinF1.R"] = [[
					hFhTeMrKyUjY3ghFhmeHnH15nV0+hFhseFkD6Slvw1hFhheIlM83gnsxhFhNeNqq8DcfqghFhKeOqs7GdGs4hFhLeOq34Kffx7hFhPeNq70PiH2J]],
				["FinF2.R"] = [[
					iKg2eUqlvYjK5yiQhoeElbzUoq3XiJh4dph/4LoUzIh8hadVjt7ji6vkhrgudUqA6xcrt/h0gqddp/5idRwPiEgtdyqK19fi06iKgyeKqSxfiA4p]],
				Tail1 = [[
					gAhngAfFgAgA/+gAh3f7eQhMf8/7gAh+f5dohrf4/3gAh3f7dlhMf6/4gAhngAeIgAgA/8gAhngAe+e0gC/9gAhngAfmeVgB/8gAhngAfpe0gB/9]],
				Tail2 = [[
					gAhqgzfMfBgE/9gEh9gudFhcf8/0gFiGgsbejAfv/hgEh/gubTizfs/hgAhtgzcpg+f3/zf8hqgzevekgD/7f7hogzgXc/gH/2f8hogzgjdLgG/3]],
				Tail3 = [[
					f9hthmg4dcgU/4gIiGhgdugtgF/5gPiUhca3jgfp/YgNiOheZ+kOfU/IgDh4hlbiigfc/kf4huhmerfTf6/9fxhnhlhjcegR/wfzhmhlidbtgY/m]],
				Tail4 = [[
					f1hqiYhjb4gk/rgLiOiTd2fQgc/6gaikiLZzjCf9/PgaigiMXyk8fS+ggLiGiVY7kAfC+7f1hziZcngwfd/zfmhiiXgsc+gG/1fmhfiWita9ge/e]],
				Tail5 = [[
					fohljKjZa+g+/ZgIiUjFfxdtg9/5gki3i6a2h0gc/hgqi5i2Xkkufd+fgYibjCXzk3er+gf4h9jLbbiRez/jfchgjJgYeSft/8fWhWjGjobOgl/a]],
				["FinB1.L"] = [[
					e+hMgVksJ6cd2Xe+hcgPoGItgt0We+hjgOpAJ6hP1Se+hdgRo0NogQ4qe+hNgWoNSZe97ve+hOgXntVHeN9Be+hOgXmHSsaj76e+hNgWkaN8Zj5O]],
				["FinB2.L"] = [[
					d8hJgVkHKHaz2XeChFgDoMJHga0yeDhHgGpNKdhS1veEhAgdpBOPgQ5BeMgyg3oZTDe77/eUg0hCn5VyeJ9NeKhBg9lbTFZi8BeAhOgrjVOOXt5D]],
				["FinB1.R"] = [[
					hChMgVks2Gjj2XhChcgPoG3TfT0WhChjgOpA2Gex1ShChdgRo0yYfw4qhChNgWoNtnhD7vhChOgXntq5hz9BhChOgXmHtUld76hChNgWkayEmd5O]],
				["FinB2.R"] = [[
					iEhJgVkH15lN2Xh+hFgDoM25fm0yh9hHgGpN1jeu1vh8hAgdpBxxfw5Bh0gyg3oZs9hF7/hsg0hCn5qOh39Nh2hBg9lbs7me8BiAhOgrjVxyoT5D]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Spine1 = [[
					gAhigAADgAgAhbgAhkgDADgAgAhbgAhpgKADgAgAhbgAhugTADgAgAhbgAhygYADgAgAhbgAhwgDADgAgAhbgAhvfPADgAgAhbgAhvfPADgAgAhbgAhvfPAD
					gAgAhbgAhvfPADgAgAhbgAhsfZADgAgAhbgAhofrADgAgAhbgAhkf7ADgAgAhbgAhigAADgAgAhbgAhigAADgAgAhbgAhigAADgAgAhb]],
				Spine2 = [[
					gAhlfbADgAgAhbgAhnfeADgAgAhbgAhsflADgAgAhbgAhyfuADgAgAhbgAh1fzADgAgAhbgAhzfeADgAgAhbgAhzeqADgAgAhbgAhzeqADgAgAhbgAhzeqAD
					gAgAhbgAhyeqADgAgAhbgAhwe1ADgAgAhbgAhrfGADgAgAhbgAhnfWADgAgAhbgAhlfbADgAgAhbgAhlfbADgAgAhbgAhlfbADgAgAhb]],
				Spine3 = [[
					gAhpe3AbgAgAlDgAhre5AdgAgAlUgAhvfBAlgAgAl9gAh1fJAugAgAmtgAh5fPA1gAgAnLgAh2e6AmgAgAmBgAh2eFANgAgAjZgAh2eFANgAgAjZgAh2eFAN
					gAgAjZgAh2eGANgAgAjagAhzeQAPgAgAjwgAhuehAUgAgAkWgAhqexAZgAgAk4gAhpe3AbgAgAlDgAhpe3AbgAgAlDgAhpe3AbgAgAlD]],
				Spine4 = [[
					gAh0eUAbgAgAlIgAh3eXAhgAgAlpgAh9eeAygAgAm8gAiEenBJgAgAoZgAiJetBagAgApWgAiEeXAzgAgAnEgAh+dhAEgAgAhzgAh+dhAEgAgAhzgAh+dhAE
					gAgAhzgAh9diAEgAgAh2gAh8dsAHgAgAiigAh4d+APgAgAjugAh1eOAYgAgAkxgAh0eUAbgAgAlIgAh0eUAbgAgAlIgAh0eUAbgAgAlI]],
				Head = [[
					gAiAdxABgAgAgNgAiDd0ADgAgAhUgAiNd9ASgAgAkHgAiXeIA2gAgAnQgAidePBZgAgApRgAiUd2AigAgAlugAiCc8AGgGhmeigAiCc8AEgEg/eigAiCc8AE
					f8fBeigAiCc9AGf6ecejgAiBdIACgAgAe5gAiBdaACgBgrffgAiAdrABgAgHgBgAiAdxABgAgAgNgAiAdxABgAgAgNgAiAdxABgAgAgN]],
				Jaw = [[
					gAhvdL//gAgAgNgAh2dN//gAgAgSgAiGdU//gAgAf2gAiYde/6gAgAd1gAikdm/8gAgAeNgAiRdN/ugAgAkGf8htcZ/0f/eai/f+htcY/ngDfBkygChtcY/3
					gBg/itgEhtcZ/5gFhlh2gAhucj/9gAgAhhf+hvc1/+f/fVg6gAhvdF//gAf5gYgAhvdL//gAgAgNgAhvdL//gAgAgNgAhvdL//gAgAgN]],
				Antenna1 = [[
					gAkRcRGWgAgAzGgAkbcfHUfvgM0VgAkxdDKBfYgZ3OgAlDdwNhhTfS6EgAlLeOQFjMeY7ggAk9dOM0gAgA5mf2kIbPG+dnkazRf6kIbOFsedimx8gGkIbOFh
					hYdlxugJkIbPFshwchxwgAkKbcFlgAgAyCf8kNb0GAe3hwyhf/kQcJGPfegiy8gAkRcRGWgSfzzGgAkRcRGWgHf6zGgAkRcRGWgAgAzG]],
				Antenna2 = [[
					gAljb4BAgAgAn2f+lvcOBOfegHorf8mGdIECdlgdvUgImUeMFChCfzxLgTmUe3JmoNfp1TgAmPdmF8kef4x/fclYa6CQY6j8oefqlXavCiXfkIoGgVlXauAb
					hiemksgelWawCBnUb5nWgAlaa9A0itfNmjfxlebYA0c5hdmOf7libwBedsg2pMgCljb4ApgPf9mTgBljb4BQgVf6ozgAljb4BAgAgAn2]],
				["FinF1.L"] = [[
					e7hLeNrPH1gAxse7hNePqpHQfyxPe7hSeXo/F3fWwFe7hXefm8EgfAuwe7hbellhDve5t4e7hZeQn2FteawXe7hYdbrCLqd31+e7hYdbrCLqd31+e7hYdbrC
					Lqd31+e7hYdcrCLmd417e7hVdmrHKweU1Ge7hRd4rNJXfFzme7hMeHrPINfxyMe7hLeNrPH1gAxse7hLeNrPH1gAxse7hLeNrPH1gAxs]],
				["FinF2.L"] = [[
					d8gudwqnKCgA0sd8gzdwqEJaft0Sd8g/dyoiH6fCzNd+hMd0mnGaebx8eBhUd2lRFjeIxGd6hMdtnfH0d+zcd2g7dYqbOZd+4gd2g7dYqbOZd+4gd2g7dYqb
					OZd+4gd2g7dYqbOVeA4dd2g4ddqfNYea3vd4g0dlqlLzfJ2ad7gvdtqnKefy1Jd8gudwqnKCgA0sd8gudwqnKCgA0sd8gudwqnKCgA0s]],
				["FinF1.R"] = [[
					hFhLeNrP4LgAxshFhNePqp4wgOxPhFhSeXo/6JgqwFhFhXefm87ghAuwhFhbellh8RhHt4hFhZeQn26ThmwXhFhYdbrC0WiJ1+hFhYdbrC0WiJ1+hFhYdbrC
					0WiJ1+hFhYdcrC0aiI17hFhVdmrH1Qhs1GhFhRd4rN2pg7zmhFhMeHrP3zgPyMhFhLeNrP4LgAxshFhLeNrP4LgAxshFhLeNrP4LgAxs]],
				["FinF2.R"] = [[
					iEgudwqn1+gA0siEgzdwqE2mgT0SiEg/dyoi4Gg+zNiChMd0mn5mhlx8h/hUd2lR6dh4xGiGhMdtnf4MiCzciKg7dYqbxniC4giKg7dYqbxniC4giKg7dYqb
					xniC4giKg7dYqbxriA4diKg4ddqfyohm3viIg0dlql0Ng32aiFgvdtqn1igO1JiEgudwqn1+gA0siEgudwqn1+gA0siEgudwqn1+gA0s]],
				Tail1 = [[
					gAhigAe5gAgA/+gAhkgDeygAgA/+gAhpgKeigAgA/9gAhugTeQgAgA/8gAhygYeFgAgA/7gAhwgDeXgAgA/8gAhvfPe5iqf6/3gAhvfPe5hpf8/7gAhvfPe5
					eXgE/7gAhvfPe5dZgG/3gAhsfZe5gAgA/+gAhofre5hIf9/8gAhkf7e5gLgA/+gAhigAe5gAgA/+gAhigAe5gAgA/+gAhigAe5gAgA/+]],
				Tail2 = [[
					gAhmgzeegAgA/9gAhog2eRgAgA/8gAhug9dxgAgA/6gAh0hFdNgAgA/3gAh4hLc2gAgA/1gAh1g2dafcgF/4gIhzgBeek7fv/kgFhzgBeelUfo/gf7hzgBee
					eXgC/6f4hzgCeeZxgZ/VgAhwgMeeeOgK/5gEhrgeeeiGf5/4gBhngueeglf9/8gAhmgzeegAgA/9gAhmgzeegAgA/9gAhmgzeegAgA/9]],
				Tail3 = [[
					gAhrhmfCgAgA/+gAhthpevgAgA/9gAh1hweAgAgA/7gAh9h4dKgAgA/3gAiCh9cngAgA/zf+h9hoddeRgW/1gYh4gxfCk7fp/mgWh3gxfAp4et+Yf2h4g0fD
					hRfj/8fkh3gwfAW/hB+qf6h1g/fCakg3/ggKhwhQfCiGf2/6gChshgfChGf3/9gAhrhmfCgAgA/+gAhrhmfCgAgA/+gAhrhmfCgAgA/+]],
				Tail4 = [[
					gAhuiZeVgAgA/8gAhxicd8gAgA/7gAh7ijc8gAgA/2gAiGiqb1gAgA/tgAiNivbGgAgA/nf5iFibcPc3gt/mgoh6hieahbgk/6g0h5hbeRtLeJ9Cf6h7hnea
					m6eS/JfIh5hbeUW+g0+ofph3hveUWPhv+XgRhziDeWgngP/8gGhviTeVhffz/6gAhuiZeVgAgA/8gAhuiZeVgAgA/8gAhuiZeVgAgA/8]],
				Tail5 = [[
					gAhzjMe9gAgA/+gAh4jOedgAgA/9gAiFjVdOgAgA/3gAiTjcb0gAgA/tgAidjga6gAgA/lfuiRjLcVb5hH/fgsiAiVfQa5io/dhbh8h8e1tId59EgPh+iVfB
					tEcH87eth+iGfIa5fu/kfLh7iYe1TVi69NgTh5i2fAd1hJ/4gLh0jGe9hefx/8gAhzjMe9gAgA/+gAhzjMe9gAgA/+gAhzjMe9gAgA/+]],
				["FinB1.L"] = [[
					e+hIgVotOmgA5Ye+hKgYopOjf55Ye+hPggodOefp5Ye+hUgooQOXfV5Ye+hYgtoHOTfJ5Xe+hVgZoVO9fQ5ve+hVfkorQ3fP6ze+hVfkorQ3fP6ze+hVfkor
					Q3fP6ze+hVflorQ2fQ6ye+hSfvosQXfa6ge+hNgAotPjfr6Ae+hJgQotO1f75je+hIgVotOmgA5Ye+hIgVotOmgA5Ye+hIgVotOmgA5Y]],
				["FinB2.L"] = [[
					eFgrgmo5PNgA5ueFgugpo1PLf55ueFg0gxoqPFfo5ueEg7g5odO+fV5ueEg/g+oVO6fI5teFg8gsoiPlfP6FeJg5f/o3RhfO7GeJg5f/o3RhfO7GeJg5f/o3
					RhfO7GeJg4f/o3RffP7FeIg2gHo4RAfZ60eHgxgWo5QLfr6VeGgtgio5Pdf754eFgrgmo5PNgA5ueFgrgmo5PNgA5ueFgrgmo5PNgA5u]],
				["FinB1.R"] = [[
					hChIgVotxagA5YhChKgYopxdgH5YhChPggodxigX5YhChUgooQxpgr5YhChYgtoHxtg35XhChVgZoVxDgw5vhChVfkorvJgx6zhChVfkorvJgx6zhChVfkor
					vJgx6zhChVflorvKgw6yhChSfvosvpgm6ghChNgAotwdgV6AhChJgQotxLgF5jhChIgVotxagA5YhChIgVotxagA5YhChIgVotxagA5Y]],
				["FinB2.R"] = [[
					h7grgmo5wzgA5uh7gugpo1w1gH5uh7g0gxoqw7gY5uh8g7g5odxCgr5uh8g/g+oVxGg45th7g8gsoiwbgx6Fh3g5f/o3ufgy7Gh3g5f/o3ufgy7Gh3g5f/o3
					ufgy7Gh3g4f/o3uhgx7Fh4g2gHo4vAgn60h5gxgWo5v1gV6Vh6gtgio5wjgF54h7grgmo5wzgA5uh7grgmo5wzgA5uh7grgmo5wzgA5u]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAhggAADgAgAhbgAhggAADgAgAhbgAhggAADgAgAhbgAhggAADgAgAhbgAhggAADgAgAhbgAhjgAADgAgAhbgAhogAADgAgAhbgAhpgAADgAgAhbgAhpgAAD
					gAgAhbgAhpgAADgAgAhbgAhpgAADgAgAhbgAhpgAADgAgAhbgAhpgAADgAgAhbgAhpgAADgAgAhbgAhpgAADgAgAhbgAhpgAADgAgAhbgAhpgAADgAgAhbgA
					hpgAADgAgAhbgAhmgAADgAgAhbgAhigAADgAgAhbgAhggAADgAgAhbgAhggAADgAgAhbgAhggAADgAgAhb]],
				Spine2 = [[
					gAhkfbADgAgAhbgAhkfbADgAgAhbgAhkfbADgAgAhbgAhkfbADgAgAhbgAhkfbADgAgAhbgAhnfbADgAgAhbgAhrfbADgAgAhbgAhsfbADgAgAhbgAhsfbAD
					gAgAhbgAhsfbADgAgAhbgAhsfbADgAgAhbgAhsfbADgAgAhbgAhsfbADgAgAhbgAhsfbADgAgAhbgAhsfbADgAgAhbgAhsfbADgAgAhbgAhsfbADgAgAhbgA
					hsfbADgAgAhbgAhpfbADgAgAhbgAhlfbADgAgAhbgAhkfbADgAgAhbgAhkfbADgAgAhbgAhkfbADgAgAhb]],
				Spine3 = [[
					gAhne3AbgAgAlDgAhne3AZgAgAk5gAhne3AWgAgAkjgAhne3ATgAgAkRgAhne3AUgAgAkUgAhqe3AogAgAmPgAhue3BNgAgAopgAhve3BWgAgApIgAhve3BW
					gAgApIgAhve3BWgAgApIgAhve3BWgAgApIgAhve3BWgAgApIgAhve3BWgAgApIgAhve3BWgAgApIgAhve3BWgAgApIgAhve3BWgAgApIgAhve3BWgAgApIgA
					hve3BVgAgApDgAhse3A8gAgAnpgAhoe3AigAgAltgAhne3AbgAgAlDgAhne3AbgAgAlDgAhne3AbgAgAlD]],
				Spine4 = [[
					gAhyeUAbgAgAlIgAhyeTAYgAgAk0gAhxeTASgAgAkIgAhxeTAOgAgAjjgAhxeTAOgAgAjqgAh4eUA6gAgAnfgAiBeXCbgAgAsMgAiDeYC1gAgAtIgAiDeYC1
					gAgAtIgAiDeYC1gAgAtIgAiDeYC1gAgAtIgAiDeYC1gAgAtIgAiDeYC1gAgAtIgAiDeYC1gAgAtIgAiDeYC1gAgAtIgAiDeYC1gAgAtIgAiDeYC1gAgAtIgA
					iDeYCxgAgAs+gAh9eWBtgAgAqQgAh1eUArgAgAmbgAhyeUAbgAgAlIgAhyeUAbgAgAlIgAhyeUAbgAgAlI]],
				Head = [[
					gAh+dxABgAgAgNgAh9dwABgAgAflgAh7dwAEgAgAeLgAh5dvAKgAgAdCgAh5dvAJgAgAdPgAiJd0ANgCftjfgAibd9B3gQfQqrgAifd/B9fdhkq3gAifd/CT
					gLfkr3gAifd/Cegee1sOgAifd/B/fghcq7gAifd/COgAgArqgAifd/CiglemsWgAifd/CBflhMrDgAifd/CIf2gcrbgAifd/CkgoeesagAifd/CEfsg3rOgA
					ied/B/ftg2rAgAiUd5BEgQe/oCgAiEdyAFgAgFiAgAh+dxABgAgAgNgAh+dxABgAgAgNgAh+dxABgAgAgN]],
				Jaw = [[
					gAhudL//gAgAgNgAhrdL/+gAgAhCgAhmdM/3gAgAi6gAhhdN/rgAgAkbgAhidN/ugAgAkKgBiAdL/5f7gTiWgCimdV/1fdgli/f8iqdY/nhOe4kpgBitdY/y
					fpgUjlgDiudZ/zfCg0jMf8iqdY/ohIe+kkgAisdY/wgAgAj0gEiudZ/ze1g+jEf9iqdY/qg8fKkcf/isdY/ugXfskDgEiudZ/zeuhEi/f+irdY/sgrfZkRf+
					iqdX/tgqfZkMgCiXdP/6fdg5h+gAh4dL/+gBf7g0gAhudL//gAgAgNgAhudL//gAgAgNgAhudL//gAgAgN]],
				Antenna1 = [[
					gAkPcRGWgAgAzGgAkKcLGFcyieySgAj/b+E9dZiIwvgAj0b1D5g+fNvNgAj2b2D3jedTukgCkqc0GriDeszYgFlIeMLbdfft4Xf2lMeRL6cAid4cgDlKecMW
					esfv5NgIlJegM5jJeQ5Zf3lMeRLnkRgt4QgAlLeZMKgAgA5FgJlJeiMybyfG5Nf4lMeTL5c7h34nf9lLeXL+hVgQ46gKlJeiNNkIdw5df7lLeUL0iigd4rf7
					lLeSLzdzhV4qgGlBdqKVbggb3FgAkfcjHJe/gv0GgAkPcRGfitd/y/gAkPcRGjjQdly8gAkPcRGWgAgAzG]],
				Antenna2 = [[
					gAlib4BRkJe9nyfrlZbuBKZxhalmfvlKbYCEXIjUmEgGk8bGAGekgohkgVk6bFBGn5dvg1gOl8cdCIoNePnwf7mdeaCOfEeprjfdmdegEgWXgTtLf+meexEN
					Zle8uagbmae3DDkOgGs6gGmfeeEdpZiYtDgAmfetDakQgVtsf6mbe3DYaac5sxflmeejFDWWgcuQgCmfepCweQgjszgjmYe6EfofgWt6gEmfelEcoIhet/ft
					meeiCXekgPr8fzmVdtDvWue0rrf5lzcRCKZlhhpcgRlgb4A4j7fOmLgVlfb4C0pbdOoogAlib4BRkJe9ny]],
				["FinF1.L"] = [[
					e7hJeNrPH1gAxse7hJeNrFIAfvyAe7hJeNqvIYfIyre7hJeNqdIteozNe7hJeNqgIpetzHe7hMeNosF2fEwNe7hReNkXDAfPsue7hSeNg5CZeWr9e7hSeNi3
					ChfJsCe7hSeNjmCmfdsDe7hSeNhBCZeZr9e7hSeNibCfe+sBe7hSeNj1CofjsDe7hSeNhQCaegr+e7hSeNh/CcezsAe7hSeNj9CpfmsEe7hSeNhmCbeor/e7
					hReNh0CfeosGe7hPeNm7EKfbuJe7hLeNqAGtflw0e7hJeNrPH1gAxse7hJeNrPH1gAxse7hJeNrPH1gAxs]],
				["FinF2.L"] = [[
					d8gsdwqnKCgA0sd7gtdxqeKPfu0+d5gvd1qKKtfG1ld3gxd4p6LHek2Ed3gwd3p8LCeq1+d8g7donoHreFzOeEhMdaipERcivWeHhXdXfJDvbFuHeHhQdXhB
					DwcCuaeHhOdXhuDycYugeHhXdXfQDvbJuJeGhSdXgmDvb0uXeHhNdXh9DzcguieHhWdXffDvbQuLeHhTdXgMDubmuSeHhMdXiEDzckujeHhVdXfzDubauPeG
					hUdXgDDzbeuYeBhDdfldFndkxEd8g0drpMIsfHz3d8gsdwqnKCgA0sd8gsdwqnKCgA0sd8gsdwqnKCgA0s]],
				["FinF1.R"] = [[
					hFhJeNrP4LgAxshFhJeNrF4AgRyAhFhJeNqv3og4yrhFhJeNqd3ThYzNhFhJeNqg3XhTzHhFhMeNos6Kg8wNhFhReNkX9AgxsuhFhSeNg59nhqr9hFhSeNi3
					9fg3sChFhSeNjm9agjsDhFhSeNhB9nhnr9hFhSeNib9hhCsBhFhSeNj19YgdsDhFhSeNhQ9mhgr+hFhSeNh/9khNsAhFhSeNj99XgasEhFhSeNhm9lhYr/hF
					hReNh09hhYsGhFhPeNm772gluJhFhLeNqA5Tgbw0hFhJeNrP4LgAxshFhJeNrP4LgAxshFhJeNrP4LgAxs]],
				["FinF2.R"] = [[
					iEgsdwqn1+gA0siFgtdxqe1xgS0+iHgvd1qK1Tg61liJgxd4p605hc2EiJgwd3p80+hW1+iEg7dono4Vh7zOh8hMdaip7vjevWh5hXdXfJ8Rk7uHh5hQdXhB
					8Qj+uah5hOdXhu8Ojough5hXdXfQ8Rk3uJh6hSdXgm8RkMuXh5hNdXh98Njguih5hWdXff8RkwuLh5hTdXgM8SkauSh5hMdXiE8Njcujh5hVdXfz8SkmuPh6
					hUdXgD8NkiuYh/hDdfld6ZicxEiEg0drpM3Ug5z3iEgsdwqn1+gA0siEgsdwqn1+gA0siEgsdwqn1+gA0s]],
				Tail1 = [[
					gAhggAe5gAgA/+gAhggAe5gAgA/+gAhggAe5gAgA/+gAhggAe5gAgA/+gAhggAe5gAgA/+gAhjgAeVftgB/8gAhogAdbgzf8/4gAhpgAdOhqf3/0gAhpgAdO
					gef9/3gAhpgAdOevgH/2gAhpgAdOefgI/1gAhpgAdOgAgA/3gAhpgAdOhhf4/1gAhpgAdOhRf5/2gAhpgAdOfigD/3gAhpgAdOeWgJ/0gAhpgAdOfGgF/2gA
					hpgAdQg5f7/3gAhmgAd1hDf7/5gAhigAeogFgA/9gAhggAe5gAgA/+gAhggAe5gAgA/+gAhggAe5gAgA/+]],
				Tail2 = [[
					gAhkgzeegAgA/9gAhkgzeegAgA/9gAhkgzeegAgA/9gAhkgzeegAgA/9gAhkgzedgAgA/9f/hpgzdWfLgF/3gDhwgybigugA/qgFhygybJjHfr/dgChygybJ
					hxfv/kf8hygybJeXgG/kf7hygybJc4gX/dgAhygybJfCgM/mgFhygybJiVf0/igEhygybJi5fp/ff+hygybJgFf6/nf7hygybJdLgR/ff9hygybJdkgV/hgD
					hxgybNgzgA/ngDhtgzcXh+f1/ugAhmgzd8gSf+/7gAhkgzeegAgA/9gAhkgzeegAgA/9gAhkgzeegAgA/9]],
				Tail3 = [[
					gAhphmfCgAgA/+gAhphmfCgAgA/+gAhphmfCgAgA/+gAhphmfCgAgA/+gAhphmfCgAgA/+f8hxhldWepgN/2gFh+hjaqf1gU/igPiBhiaDj0fj/MgHiBhjaD
					jXfP/Pf3iBhjaDe+f1/afxiBhiaDbzgn/Jf9iBhjaDdigs/VgMiBhiaDiKf9/XgNiBhiaDkQfS/If/iBhjaDhZfd/ZfyiBhiaDc5gR/Rf1iBhiaDcCgx/LgF
					iAhjaKf0gX/cgKh4hkb4ibfv/ogBhthmePgjf7/8gAhphmfCgAgA/+gAhphmfCgAgA/+gAhphmfCgAgA/+]],
				Tail4 = [[
					gAhsiZeVgAgA/8gAhsiZeVgAgA/8gAhsiZeVgAgA/8gAhsiZeVgAgA/8gAhsiZeUgAgA/8f4h6iXcFeTgQ/tgEiPiUYiegg3/DgbiTiQXwjlf8+tgSiTiRXw
					kpe6+if0iUiSXxgTfK+5fkiTiQXwbmgY+lf1iTiSXwcDhL+ogTiTiSXxhIgm+4gbiTiQXwk4fV+ggDiUiTXwi8e2+vfoiTiRXwdjfu+0foiTiRXwbDg7+fgF
					iTiTX5eWhB+4gRiFiVaJiRf8/XgDhyiYdRgwf4/3gAhsiZeVgAgA/8gAhsiZeVgAgA/8gAhsiZeVgAgA/8]],
				Tail5 = [[
					gAhxjMe9gAgA/+gAhxjMe9gAgA/+gAhxjMe9gAgA/+gAhxjMe9gAgA/+gAhxjMe8gAgA/+fziGjJcJeRgR/tf/imjBXwdUhi+wgmisi7Wzilgu+hghisi7Ww
					lJex+Kf1iti/WzhueQ+ifWisi6WycRfz+Zfoisi9WwbNhl+NgWiti+W0fvhh+mgqisi6Wxklfs+SgNiti+WxkFeO+Tfgiti8W0eze2+mfZisi6Wwa8g0+Mf/
					isi/W8dChy+fgZiXjEZvhmgU/VgFh7jLdog1f2/5gAhxjMe9gAgA/+gAhxjMe9gAgA/+gAhxjMe9gAgA/+]],
				["FinB1.L"] = [[
					e+hGgVotOmgA5Ye+hGgVotOmgA5Ye+hGgVotOmgA5Ye+hGgVotOmgA5Ye+hGgVotOmgA5Ye+hJgVogOfft5Ye+hNgVoLOVfO5Xe+hOgVoGOTfH5Xe+hOgVoG
					OTfH5Xe+hOgVoGOTfH5Xe+hOgVoGOTfH5Xe+hOgVoGOTfH5Xe+hOgVoGOTfH5Xe+hOgVoGOTfH5Xe+hOgVoGOTfH5Xe+hOgVoGOTfH5Xe+hOgVoGOTfH5Xe+
					hOgVoHOTfI5Xe+hLgVoUOafc5Ye+hHgVonOjf35Ye+hGgVotOmgA5Ye+hGgVotOmgA5Ye+hGgVotOmgA5Y]],
				["FinB2.L"] = [[
					eFgqgmo5PNgA5ueFgqgmo5PNgA5ueFgqgmo5PNgA5ueFgqgmo5PNgA5ueFgqgmo5PNgA5ueFgugmotPGft5ueEg0gmoYO8fO5ueDg2gmoUO6fH5teDg2gmoU
					O6fH5teDg2gmoUO6fH5teDg2gmoUO6fH5teDg2gmoUO6fH5teDg2gmoUO6fH5teDg2gmoUO6fH5teDg2gmoUO6fH5teDg2gmoUO6fH5teDg2gmoUO6fH5teE
					g2gmoUO6fI5teEgxgmoiPBfc5ueFgsgmo0PKf35ueFgqgmo5PNgA5ueFgqgmo5PNgA5ueFgqgmo5PNgA5u]],
				["FinB1.R"] = [[
					hChGgVotxagA5YhChGgVotxagA5YhChGgVotxagA5YhChGgVotxagA5YhChGgVotxagA5YhChJgVogxhgT5YhChNgVoLxrgy5XhChOgVoGxtg55XhChOgVoG
					xtg55XhChOgVoGxtg55XhChOgVoGxtg55XhChOgVoGxtg55XhChOgVoGxtg55XhChOgVoGxtg55XhChOgVoGxtg55XhChOgVoGxtg55XhChOgVoGxtg55XhC
					hOgVoHxtg45XhChLgVoUxmgk5YhChHgVonxdgJ5YhChGgVotxagA5YhChGgVotxagA5YhChGgVotxagA5Y]],
				["FinB2.R"] = [[
					h7gqgmo5wzgA5uh7gqgmo5wzgA5uh7gqgmo5wzgA5uh7gqgmo5wzgA5uh7gqgmo5wzgA5uh7gugmotw6gT5uh8g0gmoYxEgy5uh9g2gmoUxGg55th9g2gmoU
					xGg55th9g2gmoUxGg55th9g2gmoUxGg55th9g2gmoUxGg55th9g2gmoUxGg55th9g2gmoUxGg55th9g2gmoUxGg55th9g2gmoUxGg55th9g2gmoUxGg55th8
					g2gmoUxGg45th8gxgmoiw/gk5uh7gsgmo0w2gJ5uh7gqgmo5wzgA5uh7gqgmo5wzgA5uh7gqgmo5wzgA5u]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Spine1 = [[
					gAhfgAADgAgAhbgAhfgAADgAgAhbgAhfgAADgAgAhbgAh6gAADgAgHhbgAifgAASgLj0hagAixgACcgisJhUgAipgAJahA2mhAgAiLgAWXhW+egbgAhfgAmg
					hZ/SfugAhfgA0dhG4jfGgAhxgA8ogouMevgAiZgA/igPlKemgAivgA/9gBgbelgAitgA/9gAgAelgAiSgA/9gAgAelgAhogA/9gAgAelgAhfgA/9gAgAelgA
					hfgA/9gAgAelgAhfgA/9gAgAelgAhfgA/9gAgAelgAhfgA/9gAgAel]],
				Spine2 = [[
					gAhifbADgAgAhbgAhifbADgAgAhbgAhifbADgAgAhbgAh9fbADgAgHhbf3ijfcASgLj0hafmi0fmCcgisJhUfbisgAJahA2mhAfriOgeWXhW+egbgPhigimg
					hZ/SfugkhigH0dhG4jfGgdh0fq8ogouMevgMicfd/igPlKemgBiyfb/9gBgbelgAiwfb/9gAgAelgAiVfb/9gAgAelgAhrfb/9gAgAelgAhifb/9gAgAelgA
					hifb/9gAgAelgAhifb/9gAgAelgAhifb/9gAgAelgAhifb/9gAgAel]],
				Spine3 = [[
					gAhle3AbgAgAlDgAhle3AogAgAmMgAhle3AugAgAmtgAiBe3AugBgHmtfvime5A9gzjvmpfMi3fMDFijr5mMe3iwgAJ5kv2HkvfWiRg8WkmZ90iBgdhlhDmY
					mk+oephIhlgN0BlJ4Cbug6h4fU8Ci+t5aAgXige6+3hFlDZZgCi2e3/RgGgbZUgAize3/SgAgAZTgAiZe3/SgAgAZTgAhve3/SgAgAZTgAhle3/SgAgAZTgA
					hle3/SgAgAZTgAhle3/WgAgAZngAhle3/ggAgAafgAhle3/lgAgAa9]],
				Spine4 = [[
					gAhxeUAbgAgAlIgAhzeUA4gAgAnZgAh0eVBJgAgAoZf/iQeVBJgCgHoZfni1eYBXhAjsoVe1jGe0DdjMrvnxeVi/gAKLl811l8fCighYWsoA9biigrh0himS
					oO+OeThph0gTzxmd3taohViHe/7qjvttYfgiivea+dhXk/XugDjFeV+3gHgbXngAjCeV+3gAgAXngAioeV+3gAgAXngAh+eV+3gAgAXngAh0eV+3gAgAXngA
					h0eV+3gAgAXngAh0eV/BgAgAYOgAhyeU/agAgAZ8gAhxeU/lgAgAa4]],
				Head = [[
					gAh9dxABgAgAgNgAiEd0ARedf2jqgAiHd1AjdYfnlMf/iid1AdfLf+lNffjId5AviPkAk+eejZedDFkhsVjwd1jRgAJ5k02diiewizhyWXkt+CiYg3iHh/mB
					ln+4hhiJiHgZz5la4aeZhviZes8SiUuBbWgsjBd8/IepkwahgEjYd1/dddgCaygAjVd1/jfJf4azgAi7d1/hhogQa0gAiQd1/ciwgba0gAiHd1/hhogQa0gA
					iHd1/jfJf4azgAiFd0/od3fvbwgAiAdy/8fXf+eYgAh9dx//gAgAfz]],
				Jaw = [[
					gAhsdL//gAgAgNgCh8dL/2hggdihgDiDdM/ribhGjigAiedM/ygzgQjifUjEdR/ce8bjjsd/jVeC83e/S6kPdMjOgC1+hcJFjkeYiviTp7jnB0gUhFiDimao
					i+Axc7ixiDgjMbhZHDcKiPiWeTDhhlR5c1g3i+dVAkimbzc2gCjUdMAUiegrcgf/jRdMAOgygXcdgCi3dMAQegfVcegDiNdMAVdde2cegCiDdMAQegfVcef/
					iDdMAOgygXcdf+h/dLAOiCgvdGf/hzdKADgpgFe3gAhsdLABgAgAfz]],
				Antenna1 = [[
					gAkOcRGWgAgAzGfykmc1JmX6kw0zfoktdGKRZWjf2Pf3lKdHJ0jqeN2rfjludJKRq7eM0sePl/dqK6q8nR0JdHl4fxSkr7xkzzeclaicb6z61yrphgktihjh
					172DZZi6ktgNsEuFymNviTlBeQ0CqKp7LghOlodX2Jomg9Kmgdl9dH2UiUfQJOgIl8dH2Aa6irJgfxlhdH17aci7Jlfnk2dG2RieetJOfxkudH1XoYbnKKgI
					kudH2LjmeIJUgTkoc82eZ4jcKWgGkZcf35Y+kxMhgAkOcR5qgAgAM6]],
				Antenna2 = [[
					gAlgb4B+nteDnmfElucsFDRehlpGfCl6dGIPONihrngMmddICHiogArFgPm3c7Igz7gholebnTdhF/uTpqm/dHnIgRM6fc0Gv9e0mrisaxmk4MzLhVmCikmF
					qu9Xc9i1l+gquwfI0qMjiSmXeR5NeVtTRjgzm5dO7qsuj2W+gRnSdI6ItaefTbglnNdH9ubtgLU/gRmxdH5CP+h9UWfYmLdI9Aa0geTkfDl2dE6duqfIVnfz
					mCdI5Zu0d6Tmg3l3c392acgZV7gwlhcN5BObkMXogAlgb4+CYTh9Ya]],
				["FinF1.L"] = [[
					e7hIeNrPH1gAxse7hIeNktEUdavGe7hIeNhcDZcot1e6hjeNhnDLdPteehiIegeTEcc2v1d+iaffYfJvdx1leNiShFccT7e59Yf2h0iGePjudo/ohuhIhOca
					zXfS5Mh+hIfRcg88hEtIgyhaeDd6/zivgxfjiCd9d2+3hxYCe+iYeLh99hjUUTe7iWeNlv82k3UZe7h7eNgw9JjXTSe7hReNeg8tjKSVe7hIeNek8njYSLe7
					hIeNek8njYSLe7hIeNcj8Gi7RZe7hIeNXS51hNPVe7hIeNUx4LgAOU]],
				["FinF2.L"] = [[
					d8grdwqnKCgA0sd8hIdkkjGUclyMeAhTdfhdFRbbw4eBhrdehlE+cCwkdiiZd8eOGfbVyoc6i5fZYCMRbz3gdZijh5baXOdt+VgIh6jPdFnPdU+6i1hThgbP
					1+fh2vi1hTefbk+Gh0pvg1hnc5dT/hj4dPe/iHc7dv9ri8UqeMiqdWh176k6RSeOi0dZla7Om1RoeFiLdbgq7bk0QReBhbdfeg63kXPQeAhTdfej6vklPIeA
					hTdfej6vklPId9hMdicp6Jj6OUd6g3drXs3thiMQd8grdwVZ1+gALU]],
				["FinF1.R"] = [[
					hFhIeNrP4LgAxshFhIeNkt7simvGhFhIeNhc8njYt1hEhjeMho87ixtSgoiId/fG+ijeo3fgiad9cO/Am4fseNiSe7hH9YjkT7eFh0g3i01PfEIRfvhIiFjA
					nud6BLhlhIhZhrYUcwBLiGhafxg6MJcrHLhmiCepehFSdpOohIiYeOiDC0cvTghFiWeNlvDKbJUZhFh7eNgwC3cpTShFhReNegDTc2SVhFhIeNekDZcoSLhF
					hIeNekDZcoSLhFhIeNcjD6dFRZhFhIeNXSGLezPVhFhIeNUxH1gAOU]],
				["FinF2.R"] = [[
					iEgrdwqn1+gA0siEhIdkkj5sjbyMiAhTdfhd6vklw4h9hrdchn7Jj9wYhPiZdCfY9Nk9sDfbi5c5dT+komi2dZijeHiT+VkmXOc7h6g+j83sffK4fLhTjGkM
					rFdqCZiHhTibilb2b9AqjNhngChcPHbgFQiriHeLeyHfcfLzh9iqdch9EgbJQihyi0dZlaEyZLRoh7iLdbgqElbMQRh/hbdfegFJbpPQiAhTdfejFRbbPIiA
					hTdfejFRbbPIiDhMdicpF3cGOUiGg3drXsITeeMQiEgrdwVZKCgALU]],
				Tail1 = [[
					gAhfgAe5gAgA/+gAhfgAe5iggG/4gAhfgAe5kPgJ/sgAh6gAeKhfgG/5gAifgAdJhMgH/1gAixgAcyn4g1+0gAipgAdo0miB4SgAiLgAfa+ziOoTgAhfgAgY
					+KhDVagAhfgAg02GgxI6gAhxgAhcuMguDYgAiZgAimoqgvBVgAivgAjQkpgfAigAitgAjOhYgJANgAiSgAigdZfzAOgAhogAhXbjf0AXgAhfgAhHdYf6AJgA
					hfgAhHhYgDAEgAhfgAhHjcgIAOgAhfgAhHhBgCADgAhfgAhHgAgAAC]],
				Tail2 = [[
					gAhigzeegAgA/9gIhigyeejzgG/ugNhigxefoigH+zgFiAgzdAkugE/ggEiogybAgogN/lgYi7gsaUj8hj/MgyizgIb4xJjn6cgZiSfUfA+bjxpEfghifYgc
					9AheSlfNhigChCyrhIGFfXh2gfiPsNhKCjfmiigrkgqahPCIfyi6gwlwo3gwB1f8i3gylskmgLA3gIiagykTc2fqAegOhsgxiBXufzBLgIhigyhiZZf+Awf8
					higzhigjgFAEf1higyhil5gHAmf9higzhiiRgBAJgAhigzhigAgAAD]],
				Tail3 = [[
					gAhnhmfCgAgA/+gUhnhkfCjngD/xgohnhde+rxfm9ugUiJhjc2o6fi+jgGi4hjZ1iPf9/UgjjOhaY2hhiJ/EhdjEgcbPtIk68Xg1ieerfP9bkdrte5hne3gG
					8ihARledhngSgSvNhID4e0h+hDh9orhjBUfHiwhRlcqGhmCMfXjMhYnTsBgmDSftjJhgnJowfpCFgSiohilFeefVAegnhzhdhwVdgKB3gdhnhhhBVIgkB8f6
					hnhmg9dugZAHfjhnhhg/mxf6Awf2hnhlg+jcf3AOgAhnhmg+gAgAAC]],
				Tail4 = [[
					gAhqiZeVgAgA/8gfhqiWeXh/gY/4hLhqiCeQtRfn9DgviTiNbcs5fF86gNjLiSXflifO+VgnjkiIWDhDiX+SiAjYg8ZkpSmv9KhXiseHfe7XmYvSeQhqeZgl
					8/hkSldyhqgugosohzCreaiGhuivkUimAieqjCh3nXnvi5B/e1jhh3p6tWhNEtfTjeiGprsofNERgXi4iSnBh3eaA5hHh4iFiqVMf5CBg+hqiIhxRtg4DdgB
					hqiYhoZpg+AtfNhqiQhql5gNAnfrhqiXhskPfzAWgAhqiZhrgAgAAE]],
				Tail5 = [[
					gAhwjMe9gAgA/+gmhwjIfDfXhA/9hxhuije3sxfe9ThVifitbPvpeL7bgejli6Whpcds89gnkDixUbiphm9qiXjxhiY3nEnz9WiAi/dwgq46nMyudphvd4g/
					+IgsVUdNhuhSf8r6htCXeNiPieiLgdjnATeVjbifntkGkhBkeSj+iPrLs0iGE/evj4igq/vQedGLgQjOjAngl8c5BphoiAiriMW8fiBahnhtimhWP5hpEdgV
					hvjHhDViiJB4e7hwi/g8jhgrAPfdhwjIhFkdfrAWgAhwjMhDgAgAAC]],
				["FinB1.L"] = [[
					e+hEgVotOmgA5Ye+hEgVnNN7d35Se+hEgVmhNqc65Me+hggWmqNPdb46fFiFgkkJO3bA6OfgiWg+eIVQYF9AgViPhCf0iZZl/PhChwgUf6xsY55rg0hEfSbp
					8ZaQs1f3hEe7Zd/Gc+d+fHhXfYZC79geSHe7h/f/Y83Fg1LCe9iVgUbu03kvIne+iSgVeb04n0JHe+h4gVa6zzkOHxe+hOgVZcyhi6G7e+hEgVZfyWjGG0e+
					hEgVZfyWjGG0e+hEgVZEyMihGwe+hEgVX6xtg4Gpe+hEgVXTxagAGo]],
				["FinB2.L"] = [[
					eFgogmo5PNgA5ueBgygmndOhd15oeAg3gmmyOQc35ieAhRglm6N1dZ5ReJiCg+kcPda56he6iohwecV1X09KgfiNiDf/jDZU/Ih9hgguf9yOYp5Phmg3eqbj
					8naAsMfxg3d7ZQ+/czdTeVhMewYx7mgYRid8huf2Ys2lg0Kld8iVgbbZ0WkzIPd/ijgfeD0Zn8Iwd+hzghanzQkRHZeAg/gmZLx7i9GleAg3gmZOxwjJGeeA
					g3gmZOxwjJGeeBg0gmY0xmijGaeEgsgmXsxGg5GTeFgogmXHwzgAGS]],
				["FinB1.R"] = [[
					hChEgVotxagA5YhChEgVnNyFiJ5ShChEgVmhyWjG5MhChggVmry7ii4yhFiFgFlN23j51ag+iWfhkQ8Cm9tEgViPe+mb/PgMiZfWhwfJkL9QaPVLe7hEgHht
					07Y/I6ffhEg9eNnnZBBygXhXhBcKaIaMBWg4h/gpZkQzc+EyhBiVgXb2LxbKIEhCiSgVebLIYMJHhCh4gVa6MNbyHxhChOgVZcNfdGG7hChEgVZfNqc6G0hC
					hEgVZfNqc6G0hChEgVZEN0dfGwhChEgVX6OTfIGphChEgVXTOmgAGo]],
				["FinB2.R"] = [[
					h7gogmo5wzgA5uh/gygmndxfiL5oiAg3gmmyxwjJ5iiAhRgjm8yWik5JiHiCgAli2Xj612hxioe7kq7vm7tlgfiNd9ms/IgBjDerhgeakS9baAV2d7g3gQhs
					1YYuJbfDg3h3eEoQYyCBgxhMh9b7azaBBShvhuhIZVRbc6EgiCiVgibiMUbFHsiBijgfeDLnYEIwiChzghanMwbvHZiAg/gmZLOFdDGliAg3gmZOOQc3GeiA
					g3gmZOOQc3Geh/g0gmY0OaddGah8gsgmXsO6fHGTh7gogmXHPNgAGS]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAhfgAADgAgAhbgAhfgMADgAgAhbgAhfgUADgAgAhbgAhfgSADgAgEhbgAhfgOADf/frhbgAhfgJAFf8efhbgAhfgGAFf8euhbgAhjgGADfofyhbgAiSgEAV
					bzgWhZgAjfgBB/VDgghVgAkcgAFiOGgzhLgAj/gAJgJUhAhAgAjKgALcHihFg6gAjYgALeHhhFg6gAjbgALeHhhFg6gAjJgALeHhhFg6gAjJgALeHhhFg6gA
					jJgALeHhhFg6gAjJgALeHhhFg6gAjJgALeHhhFg6gAjJgALeHhhFg6gAjJgALeHhhFg6gAjJgALeHhhFg6]],
				Spine2 = [[
					gAhifbADgAgAhbgAhifnADgAgAhbgAhifvADgAgAhbgAhiftADgAgEhbgBhifpADf/frhbgDhiflAFf8efhbgDhifiAFf8euhbgAhmfhADfofyhbf/iVffAV
					bzgWhZf+jhfcB/VDgghVf9kefbFiOGgzhLf9j/fbJgJUhAhAf9jJfbLcHihFg6f9jXfbLeHhhFg6f9jbfbLeHhhFg6f9jJfbLeHhhFg6f9jJfbLeHhhFg6f9
					jJfbLeHhhFg6f9jJfbLeHhhFg6f9jJfbLeHhhFg6f9jJfbLeHhhFg6f9jJfbLeHhhFg6f9jJfbLeHhhFg6]],
				Spine3 = [[
					gAhle3AbgAgAlDgAhlfDAkgAgAl5gAhlfKArgAgAmbgAhlfIApgBgEmSgBhlfEAlf8fsmAgHhlfAAkfveglsgGhle9AhfyewlggBhqe8Affmf1ldf+iYe6Av
					b3gzlQf8jke4CYVHhRk/f6kfe3F+OKhyk5f5j/e3KBJaiPk6f6jJe3MAHqick7f6jXe3MBHpick7f6jae3MBHpick7f6jIe3MBHpick7f6jIe3MBHpick7f6
					jIe3MBHpick7f6jIe3MBHpick7f6jIe3MBHpick7f6jIe3MBHpick7f6jIe3MBHpick7f6jIe3MBHpick7]],
				Spine4 = [[
					gAhxeUAbgAgAlIgAhyegAwgAgAmygAh0eoBAgAgAn2gAhzemA7gBgEnkgChzeiAzf7fsnBgKhyeeAtftehmagJhyebAnfxewmBgBh2eaAlfmf1l7f6ikeXAz
					b3gxllf1jteVCcVCgzlUfwkmeUGKOCgylpfukDeUKXJUg7mSftjMeUMcHnhEmoftjZeUMdHmhEmoftjdeUMdHmhEmoftjLeUMdHmhEmoftjLeUMdHmhEmoft
					jLeUMdHmhEmoftjLeUMdHmhEmoftjLeUMdHmhEmoftjLeUMdHmhEmoftjLeUMdHmhEmoftjLeUMdHmhEmo]],
				Head = [[
					gAh8dxABgAgAgNgAiCd/AQgAgAj6gAiFeIApgAgAmSf/iEeFAhgAgHlqgDiCeBAVgAfXkbgNiAd8AUf/c/jGgLh/d5AMf/ddiNgBiDd3AFfpfih/f3iwd1AV
					bygShRfvj4dyCAVEeZgtfokvdxFvOPcKhsfikMdyJ6JxaujjfgjTdyL8IMaQkjfgjhdyL9ILaQkkfgjldyL9ILaQkkfgjTdyL9ILaQkkfgjTdyL9ILaQkkfg
					jTdyL9ILaQkkfgjTdyL9ILaQkkfgjTdyL9ILaQkkfgjTdyL9ILaQkkfgjTdyL9ILaQkkfgjTdyL9ILaQkk]],
				Jaw = [[
					gAhsdL//gAgAgNgAh6dW/9gAgAhjgAiEdf/5gAgAibf/iBdc/6gCf5iMgEh8dY/8f4gohvgVh3dV/0fnjAhPgSh0dR/4fxiig7gDh3dQ/+gVggg2f6ijdO/s
					kOgBg6f9judM99qxiih4f8kxdN6Ow+mgiUf2kadQ2V0gqGhdfxjmdS0k1lrmgsfxj0dS0j1lrngsfxj4dS0j1lrngsfxjmdS0j1lrngsfxjmdS0j1lrngsfx
					jmdS0j1lrngsfxjmdS0j1lrngsfxjmdS0j1lrngsfxjmdS0j1lrngsfxjmdS0j1lrngsfxjmdS0j1lrngs]],
				Antenna1 = [[
					gAkNcRGWgAgAzGgAkldDIwddhd1xgAkvdlKQckhm3Jf/ktdcJTePg92cgGkodKH7gkfC1Cgdkgc6G6hMcEzZgZkbctFvhWcgx4gBkecoEygPfawyfPlCcfEY
					bAivvGealtcSF2TTkEsrdwl7cMJXM5j/rYdakycNM6JbjjrrdUjpcOOQIkjSsLdUj3cOOIIojKsJdUj6cOOmIHjPrzdUjocOPJHkjUradUjocOPXHVjXrQdU
					jocOPQHcjWrVdUjocOPCHqjTrfdUjocOO7HyjSrkdUjocOO7HxjSrkdUjocOO+HvjTridUjocOO/HujTrh]],
				Antenna2 = [[
					gAlgb4BNjofFnzfxl5c9BschgRpmftmDdqD4X7ghs5f1mCdbDdZDg8sngMl9c/BKerfnoVgxlycmBCkqczlsgtlpcPBfmvcRlvgElrcCAej9eljSe1mGbxAc
					a/fmeqdtmdbaD6RHdudZc8mabPIXK9bpescilKbQKyJjXvffcakBbTKVK9VhgKcbkPbTJgLYWqiCcbkQbRKKKiXLircbj7bQLSKEVagmccj6bPMKJZVIf+cc
					j7bQMQIjXBhccbj8bQLzJBWzhXcbj8bQLaKGVHf9cbj8bQLWJ0V1grcbj8bQLhJHXUiCcbj8bQLeJkWJg9]],
				["FinF1.L"] = [[
					e7hHeNrPH1gAxse7hHeZo5G4eUxne7hHegnWGYdQxee6hHeenwGidhxke9hHeZolGleLxVfGhHeQpeGRfJwcfEhHeOqBGnfgwqe9hKeRqbHVfexffChpeRtq
					JOhyxufaigeOysNAl7wrf8jUeN23STp7upgYi6eN5lYgtTrrgjiKeN6YcPu0pqgjiYeN6ZcRu1pogjibeN6ZcRu1pogjiJeN6ZcRu1pogjiJeN6ZcRu1pogj
					iJeN6ZcRu1pogjiJeN6ZcRu1pogjiJeN6ZcRu1pogjiJeN6ZcRu1pogjiJeN6ZcRu1pogjiJeN6ZcRu1po]],
				["FinF2.L"] = [[
					d8gqdwqnKCgA0sd4g3d8oeJIeC0md2g/eDnEIqcy0cd2g9eCncI0dG0id6g5d6oMI0d20VeHg0dtpBIXe5zieGgxdspgIufUzwd9gydzp3JifX0geLhAd1sz
					LWiG0te8hidxxXO3m7zgf/iPdw1GTwrmxJg9iAdw3JYRu0uchXhcdw3waawEtChXhqdw3wabwFtBhXhudw3wabwFtBhXhcdw3wabwFtBhXhcdw3wabwFtBhX
					hcdw3wabwFtBhXhcdw3wabwFtBhXhcdw3wabwFtBhXhcdw3wabwFtBhXhcdw3wabwFtBhXhcdw3wabwFtB]],
				["FinF1.R"] = [[
					hFhHeNrP4LgAxshFhHeZo55IhsxnhFhHegnW5oiwxehFhHeenw5iidxehIhHecoi5EiAx1hQhHedpW4EhwyzhOhHeZp83/hTyphIhOeTp24ohFx2hIiNeQnN
					5wixxVhEj6eOiE6lmMwkgvlUeNbz6Up5uqgXlFeNYU5hrxtNgLkSeNXv5WsEs8gLkgeNXv5WsEs8gLkkeNXv5WsEs8gLkSeNXv5WsEs8gLkSeNXv5WsEs8gL
					kSeNXv5WsEs8gLkSeNXv5WsEs8gLkSeNXv5WsEs8gLkSeNXv5WsEs8gLkSeNXv5WsEs8gLkSeNXv5WsEs8]],
				["FinF2.R"] = [[
					iEgqdwqn1+gA0siIg3d8oe24h+0miKg/eDnE3WjO0ciJg9eBnc3Ri40ciLg5eAoJ2yiV0ziUg0eGo41sh91siRgxeBpb1phc1jiJg4d3pW2YhQ01iMiGdym8
					3fjQ0UiGkNdwiQ4TnPzYhimDdwcf4JrmxJg7l/dwYF3FukutgslOdwWZ2bvntlgslcdwWZ2bvntlgslgdwWZ2bvntlgslOdwWZ2bvntlgslOdwWZ2bvntlgs
					lOdwWZ2bvntlgslOdwWZ2bvntlgslOdwWZ2bvntlgslOdwWZ2bvntlgslOdwWZ2bvntlgslOdwWZ2bvntl]],
				Tail1 = [[
					gAhfgAfKgAgA/+gAhfgMfKgAgA/+gAhfgUfKgAgA/+gAhfgSfKgGgA/+gAhfgOfKfef//+gAhfgJfLdef8/4gAhfgGfLd4f8/6gAhjgGfLfmgX/+gAiSgEfJ
					gHkO/sgAjfgBfWfWq8+DgAkcgAf2evx56fgAj/gAgceZ2p2hgAjKgAgveS4b0lgAjYgAgweS4c0kgAjbgAgweS4c0kgAjJgAgweS4c0kgAjJgAgweS4c0kgA
					jJgAgweS4c0kgAjJgAgweS4c0kgAjJgAgweS4c0kgAjJgAgweS4c0kgAjJgAgweS4c0kgAjJgAgweS4c0k]],
				Tail2 = [[
					gAhhgzfBgAgA/+gAhhg/fBgAgA/+gAhhhHfBgAgA/+gAhhhFfBgJgA/+f+hhhBfBfQf//9f4hhg8fBcef8/xf5hhg5fBdCf9/1f/hmg5fCfbgX/+gAiVg3e/
					gKkO/sf9jgg0fWe7q9+Cf8kbgzgRd4x46cf9j6gzhYdR2m2cf+jEgzh7dH4V0ef+jSgzh8dH4W0df+jWgzh8dH4W0df+jEgzh8dH4W0df+jEgzh8dH4W0df+
					jEgzh8dH4W0df+jEgzh8dH4W0df+jEgzh8dH4W0df+jEgzh8dH4W0df+jEgzh8dH4W0df+jEgzh8dH4W0d]],
				Tail3 = [[
					gAhkhmf4gAgA//gAhkhyf4gAgA//gAhkh6f4gAgA//gBhkh4f4gLgA//f8hkh0f4fCgC/+fthkhuf3begJ/qfwhkhrf3cMgI/wf9hphsf4fRgZ/+gAiYhqf1
					gVkN/tf5jhhngSe2rA+Bf3kWhmhfdjx96Uf6jxhli+c22p2Lf9i5hljucr4W0Jf9jHhljvcr4X0If9jLhljvcr4X0If9i5hljvcr4X0If9i5hljvcr4X0If9
					i5hljvcr4X0If9i5hljvcr4X0If9i5hljvcr4X0If9i5hljvcr4X0If9i5hljvcr4X0If9i5hljvcr4X0I]],
				Tail4 = [[
					gAhliZfcgAgA//gAhlilfcgAgA//gAhlitfcgAgA//gBhlirfcgOf///f5hlinfce1gD/9fehliffbaegO/gfkhlidfbbWgM/pf6hpiffdfHgZ/+gBiZidfZ
					gVkN/tf2jfiagBeUrC9+fzkOiYhqcix/6Lf6jkiWjrbi2l16f/iqiVksbS4Nz0f/i3iVksbS4Ozzf/i7iVksbS4Ozzf/ipiVksbS4Ozzf/ipiVksbS4Ozzf/
					ipiVksbS4Ozzf/ipiVksbS4Ozzf/ipiVksbS4Ozzf/ipiVksbS4Ozzf/ipiVksbS4Ozzf/ipiVksbS4Ozz]],
				Tail5 = [[
					gAhnjMgWgAgA//gAhnjYgWgAgA//gAhnjggWgAgA//gChnjegWgQf///f1hnjagWeogI/9fNhmjPgSZhgm/UfVhmjOgTaigg/hf4hrjSgXe9gd/+gCibjQgS
					ggkM/tfxjdjNg/eRrK96ftkDjKi6cRyL55f5jRjGlQbL2t1XgBiVjEmba74RzKgCijjEmca64SzJgCimjEmca64SzJgCiUjEmca64SzJgCiUjEmca64SzJgC
					iUjEmca64SzJgCiUjEmca64SzJgCiUjEmca64SzJgCiUjEmca64SzJgCiUjEmca64SzJgCiUjEmca64SzJ]],
				["FinB1.L"] = [[
					e+hEgVotOmgA5Ye+hEghnBN2dm5Re+hEgpl5NccD5Ee+hEgnmMNmcc5Ke+hEgimzNgdU5De8hEgYneM0ee4be9hEgXn2NLfB4ne+hHgaoIOHfM5PfHhngaqc
					Ptil5WffiggXuCShog37gAjVgVw+WeuP1Bgbi9gVy1bEzFwvgliOgVzWdz1Rt2glibgVzWd01St1glifgVzWd01St1gliNgVzWd01St1gliNgVzWd01St1gl
					iNgVzWd01St1gliNgVzWd01St1gliNgVzWd01St1gliNgVzWd01St1gliNgVzWd01St1gliNgVzWd01St1]],
				["FinB2.L"] = [[
					eFgogmo5PNgA5ueBgzgynROcdj5nd/g7g6mLOBcA5aeAg5g5mdOLcZ5geAg1gynDOFdS5Zd/gwgkntNZed4zeAgugjoFNxfA4/eEgvgqoVOufM5leWhAgrqk
					QWin5sfEhmgouATKon4QgFiWgmwyXFua1Ug+iJgmyPapybx9hWhlgmyqcVz/wNhWhzgmyqcWz/wMhWh3gmyqcWz/wMhWhlgmyqcWz/wMhWhlgmyqcWz/wMhW
					hlgmyqcWz/wMhWhlgmyqcWz/wMhWhlgmyqcWz/wMhWhlgmyqcWz/wMhWhlgmyqcWz/wMhWhlgmyqcWz/wM]],
				["FinB1.R"] = [[
					hChEgVotxagA5YhChEghnByKia5RhChEgpl5ykj95EhChEgnmMygji5GhChEgkmvyAi05ahAhEglnTwyiP6JhAhEghnww0hn6ChChKgcntxshg5ehHiKgYly
					yukB4+hDj1gWiDzXo53xgxlQgVdezTuN1CgalBgVa6yyw5y8gPkPgVagyrxUykgPkdgVagyrxUykgPkhgVagyrxUykgPkPgVagyrxUykgPkPgVagyrxUykgP
					kPgVagyrxUykgPkPgVagyrxUykgPkPgVagyrxUykgPkPgVagyrxUykgPkPgVagyrxUykgPkPgVagyrxUyk]],
				["FinB2.R"] = [[
					h7gogmo5wzgA5uh/gzgynRxkid5niBg7g6mLx/kA5aiAg5g4mex7jl5ch/g1g3nAxai35wh6gwg8niwLiR6dh6gug3n+wMhp6Xh9g0gun7xFhh50iGiBgpmE
					yJkF5UiBkFgnidy3pA4Ghhl6gmd+y6ua1Ug8l2gmagyNyHySgvlGgmZLxvzaw5gvlUgmZKxvzaw4gvlYgmZKxvzaw4gvlGgmZKxvzaw4gvlGgmZKxvzaw4gv
					lGgmZKxvzaw4gvlGgmZKxvzaw4gvlGgmZKxvzaw4gvlGgmZKxvzaw4gvlGgmZKxvzaw4gvlGgmZKxvzaw4]],
			},
		},
	},
}
