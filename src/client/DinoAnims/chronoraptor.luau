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
					gAjVguAEgAgAh2gAjWguAEgAgIh2gAjWguAEgBgRh2gAjXguAFgBgYh2gAjXguAFgCgfh2gAjXguAFgCgmh2gAjXguAFgDgrh2gAjXguAFgDgwh2gAjWguAF
					gDgzh2gAjWguAFgDg1h2gAjVguAFgDg1h2gAjUguAFgDg1h2gAjTguAFgDgzh2gAjTguAFgDgwh2gAjTguAFgDgrh2gAjSguAFgCgmh2gAjTguAFgCgfh2gA
					jTguAFgBgYh2gAjTguAEgBgRh2gAjUguAEgAgIh2gAjVguAEgAgAh2gAjWguAEgAf4h2gAjWguAEf/fvh2gAjXguAFf/foh2gAjXguAFf+fhh2gAjXguAFf+
					fah2gAjXguAFf9fVh2gAjXguAFf9fQh2gAjWguAFf9fNh2gAjWguAFf9fLh2gAjVguAFf9fLh2gAjUguAFf9fLh2gAjTguAFf9fNh2gAjTguAFf9fQh2gAjW
					guAGf+fViNgAjhguAMf/fajOgAjbguAIf/fhiqgAjYguAHf/foiVgAjXguAGf/fviMgAjVguAFgAf4h9]],
				Spine1 = [[
					gAjYgTAjgAgAl0gAjZgTAlgCgIl8gAjagTAmgDgQmDf/jagTAngFgYmJf/jagTAogGgfmNf/jbgTAogHglmOf/jagTAogIgrmNf/jagTAogJgvmJf/jagTAn
					gLg6mDf/jZgTAmgQhXl8f/jYgTAmgVhzlzf/jXgTAlgXh6lrf/jXgTAkgWh4lkf/jWgTAjgWh1lef/jWgTAigVhxlaf/jWgTAhgUhrlZf/jWgTAhgThllaf/
					jWgTAhgShdlegAjXgTAhgMhBlkgAjXgTAigEgYlsgAjYgTAjgAgAl0gAjZgTAlf+f4l8gAjagTAmf9fwmDgBjagTAnf7fomJgBjagTAof6fhmNgBjbgTAof5
					fbmOgBjagTAof4fVmNgBjagTAof3fRmJgBjagTAnf2fOmDgBjZgTAlf2fMl8gBjYgTAkf2fLl0gBjXgTAif3fMlsgBjXgTAhf3fOlkgBjWgTAgf4fRlfgBja
					gUAjf5fVlxgBjngUAvf7famwgBjggUAof7fhmNgBjcgUAlf8fol9gAjbgUAkf9fwl6gAjZgTAjf/f4lz]],
				Spine2 = [[
					gAjsfhBcgAgApdf/jtfhBhgDgIptf/jufhBmgFgQp7f+jvfhBqgIgXqGf+jvfhBsgKgeqNf9jvfhBtgMgkqQf9jvfhBtgOgpqNf8jvfhBqgPgtqGf8jufhBn
					gVhAp7f6jtfhBlglh3psf5jsfhBkg1ispbf4jqfhBhg6i7pKf5jpfhBcg6i5o8f5jofhBZg5i2oxf5jofhBWg4ixoqf6jofgBVg2isonf6jofgBVg0imoqf7
					jofgBWgyieoxf8jpfgBWgjhuo+f/jqfhBYgMgmpNgAjsfhBcgAgApdgBjtfhBhf9f4ptgBjufhBmf7fwp7gCjvfhBqf4fpqGgCjvfhBsf2fiqNgDjvfhBtf0
					fcqQgDjvfhBtfyfXqNgEjvfhBqfxfTqGgEjufhBnfwfQp7gEjtfhBifwfOptgEjsfhBdfwfNpdgEjqfhBYfxfNpNgEjpfgBUfyfPo/gEjofgBRfzfSozgDjt
					fhBVf1fWpBgDj9fiBnf3fbp+gCj0fhBdf4fhpdgCjwfhBZf6fppRgBjvfhBaf8fwpUgBjsfhBaf+f4pU]],
				Neck1 = [[
					gAj8fJE9gAgAxFf/j9fJFAgEgHxKf+j/fKFDgJgOxOf+kAfKFFgNgUxRf9kBfKFGgRgaxTf8kBfKFHgVggxUf8kBfKFHgXgkxTf7kAfKFFgagoxRf6j/fKE1
					gvhLw0f3j9fKEKhvi2vYf1j8fKDpiwkct1f0j6fJDfjFk5tTf0j5fJDdjGk2tOf0j4fJDbjFkztLf1j3fIDZjEkutJf1j3fIDYjCkptJf2j3fIDXi/kktLf3
					j4fIDYi6kbtQf6j5fIDuiBjHuef+j6fIEfgrhDwQgAj8fJE9gAgAxFgBj9fJFAf8f5xKgCj/fKFDf3fyxOgCkAfKFFfzfsxRgDkBfKFGfvfmxTgEkBfKFHfr
					fgxUgEkBfKFHfpfcxTgFkAfKFFfmfYxRgFj/fKFDflfVxNgFj9fJFBfkfTxJgFj8fJE+fjfTxEgFj6fJE7fkfTxAgFj5fIE4flfVw8gFj4fIE2fnfXw4gEj9
					fJFUfpfbxngEkOfLG3frfgzxgDkFfKF+fvflylgCkAfJFhfzfrx8gCj/fJFWf3fyxrgBj8fJFEf8f5xP]],
				Neck2 = [[
					gAkwewHMg2hC0Jf/kyewHQg9hL0Nf+k0exHThChS0Qf9k1eyHWhHhY0Tf8k2eyHYhJhb0Vf7k2eyHYhKhb0Vf7k2eyHYhJha0Vf6k1eyHWhGhW0Tf4kzewG5
					hfh2zqfxkverFri+jtxifrkqenExkgllvLfpknemEilAmIuXfpkmelEflAmFuTfpkkelEdlAmBuQfqkkekEbk/l9uOfrkjekEak9l4uOfskkekEZk5lzuQft
					kkekEakylquXfzkoenE7jGjxwUf8ktesGSgegozAgAkwewHMfKe+0JgBkyewHQfDe10NgCk0exHTe+eu0QgDk1eyHWe5eo0TgEk2eyHYe3el0VgFk2eyHYe2
					el0VgFk2eyHYe3em0VgGk1eyHWe6eq0TgGk0exHTe/ew0QgHkyexHQfFe30NgHkwewHMfNfB0JgHkvevHIfWfM0FgGktevHEfgfY0BgGkseuHCfrflz+gFkz
					eyHlf2f00pgElHe9JXf+gF2mgEk8e3IWgLgS1igDk2ezH1gXgf08gCk0eyHogigs0sgBkxewHTgsg40T]],
				Head = [[
					f/lgemAQgPj1g3f+lienASgOj+hEf9ljeoATgNkChUf8lleoAUgMj/hnf7llepAUgLj2h6f6lmepATgLjmiMf6llepASgKjRiaf5lleoAQgKi3ijf2liekAQ
					gmjjhVftlceZA+iEmxc5fjlUePCyjgpyYKfflQeMDnj8qmWifglOeLDrj9qiWTfglNeLDvj9qcWCfhlMeKDzj9qVVwfilLeKD2j9qOVhfjlMeKD3j8qGVUfk
					lNeKDyj5p3VUfulTeRBkijmWY7f7lceeAEgjfveZgBlgemAQfxcLg3gClienASfycChEgDljeoATfzb+hUgElleoAUf0cBhngFllepAUf1cKh6gGlmepATf1
					caiMgGllepASf2cviagHlleoAQf2dJijgHljeoAOf3dningHlienALf4eKilgHlgemAJf6evidgHleelAGf8fWiQgHldekAFf/f/h/gGlbejAEgCgnhsgFlj
					epANf+hPjRgEl4e9BNfphzobgElseyAif3iXlMgDlmesAUgBi2jWgBlkeqASgFjQiggAlhenAQgMjlhU]],
				Jaw = [[
					fvlddl/ugDcLhcfulfdm/tgHcBhffslidn/tgKb+hdfslldo/tgMcBhWfrlndo/vgNcKhLfrlodo/xgMcag8fslpdo/0gKcvgrftlodn/3gHdJgbfolhdk/w
					fucbhdfRlKdg+sefZGlme6k1dl8ldOWAp8e0ktdo7oc2VKrfe0kqdo7jc1VOrue1kodo7ec0VTr/e2kmdo7ZczVasQe3kldo7VczVisfe5kldo7TczVqsse7
					kmdo7Yc1V4stfSkzde92d7ZfpRf8lOdd/vfcgOj6gRlddl/uf9j1hcgSlfdm/tf5j/hfgUlidn/tf2kChdgUlldo/tf0j/hWgVlndo/vfzj2hLgVlodo/xf0
					jmg8gUlpdo/0f2jRgrgTlodn/3f5i3gbgRlndm/5f8iZgLgPlmdl/8f+h3f/gNljdk/9gAhRf3gKlhdj//gBgqgEgHledi//gBgBgUgElcdh/+gBfZgngAlp
					do/9gMeyg/f9mTeB/5g5eZhef6l7dy/3goduhkf3ltdr/0gcdMhpf0lodp/ygWcxhrfylfdm/wgJcbhl]],
				ClockMin = [[
					gAj+f2gAJZgA2ngAj/f2h9JkeC2of/kAf3j2J6cG2df/kBf3lrKZaM2Jf+kBf3naLAYX1qf+kBf3pCLuWo1Df+kBf3qiMiVB0Uf9kBf3r8NbTgzef9kAf3tI
					OhR/ysf9j/f2t6QAQUyGf9j+f2uiReOrxVf8j9f2vXSpNXwKf9j9f1wSTvMRuxf9j8f1xKU7LRtRf9j8f1x+WNKXrqf9j8f0yvXmJlp7f+j8f1zbZGI7oFf+
					j8f10BasIbmJf/j9f10/cUIgkEf/j9f22FeFJCh/gAj+f22ngAJZgAgAj/f22oh+JkeDgBkAf32dj6J6cKgBkBf32Jl0KZaVgCkBf31qnpLAYmgCkBf31DpY
					LuW+gCkBf30Uq/MiVegDkBf3zesgNbUEgDkAf3yit6OXSxgDj/f3xhvNPYRkgDj+f2wawaQcQcgDj9f2vNxhRkPYgDj9f1t6yiSxOXgDj8f1sgzeUENbgCkB
					f2qy0bVsMbgCkPf4of1aX5LWgCkHf3nH11ZJK0gBkDf2lf2OaqKTgBkCf2jr2gcZJ3gAj/f2h52oeIJj]],
				ClockHour = [[
					gAj+f2gAJZgA2ngAj/f2gMJff02tf/kAf3gWJkfq2zf/kBf3geJqfh24f+kBf3gjJvfb29f+kBf3glJ0fZ3Bf+kBf3gjJ4fb3Ff9kBf3geJ7fh3If9kAf3gW
					KJfp3Wf9j/f2gMKzf039f9j+f2gALdgA4hf8j9f2f0LpgM4rf9j9f1fqLogW4qf9j8f1fhLmge4nf9j8f1fbLigk4lf9j8f0faLegl4hf+j8f1fbLZgj4df+
					j8f1fhLTge4Yf/j9f1fpKtgW33f/j9f2f0J1gM3EgAj+f2gAJZgA2ngAj/f2gMJTf02hgBkAf3gWJNfq2cgBkBf3gfJIfi2WgCkBf3glJDfd2RgCkBf3gnI/
					fb2MgCkBf3glI7fd2IgDkBf3gfI4fi2FgDkAf3gXI1fq2DgDj/f3gMI0f12BgDj+f2gAIzgA2BgDj9f2f0I0gL2BgDj9f1fpI1gW2DgDj8f1fhI4ge2FgCkB
					f2frI6gT2IgCkPf4gWI+fm2MgCkHf3f/JCf/2RgBkDf2f3JHgI2WgBkCf2f5JNgH2cgAj/f2f5JTgH2h]],
				["UpperArm.L"] = [[
					fGjue14CRAVSqTfFjwe14ORTU1pzfEjye24VRiUfpbfDjze34YRrUQpQfDj0e34VRtUKpTfCj0e44ORpUOpkfBj0e44CRfUZqAfBjze43yRRUsqne/jye53a
					RHU5rae8jwe92zRMUushe4jufA2MRUUjtle3jsfB10RPUxuPe4jrfA1oRGVFuoe4jpfA1hQ/VRu0e4jpfA1iQ9VUuye5joe/1qQ+VOuie6jpe/15RCVAuHe7
					jpe+2NRKUttge+jre72zRFU1sffDjse33hQ8VPrQfGjue14CRAVSqTfHjwe14UROVCprfIjye04hRYU4pMfJjze04pRdU1o7fKj0e04sRbU7o3fLj0ez4pRT
					VIpBfMj0ez4gRFVbpZfMjzez4SQzV0p6fMjyey4AQeWRqifNjwey3rQKWurMfNjuey3WP3XKr0fNjsey3CPpXhsXfMjqey2zPfXxswfMjpey2qPbX4s/fMjv
					ey3vQTWdrCfLkBe057TlSvkkfKj3e05DR8UTnyfJjye04hRTVBpOfIjxe04ZRPVEpgfHjue04EQ9VYqQ]],
				["LowerArm.L"] = [[
					ecjleXZ9G3NMgYebjoeYZ4HZMhgmeZjreYZ0HpMPg0eYjteZZxHlMVhCeXjueaZwHNM0hNeWjuebZxGlNqhXeWjsecZzFzOzheeVjqecZ2E9QJhieTjnefZy
					ELRohyeOjkelZgDjTKiieKjgesZRDHUejPeJjdeuZOC0VWjYeJjbeuZOCqVujPeJjZeuZLCsVnjEeKjYetZGC5VDi4eLjYesY/DSUFiseLjaerY4D3S1iheM
					jceqYyElRaiWeRjeekZDFWP2hreYjiebZnGIOVgxecjleXZ9G3NMgYedjoeWaCHZMegZeejreVaIHpMIgbegjteUaPHkMMgcehjueUaWHMMogceijueTadGj
					NcgbeijseTaiFxOjgXejjqeTamE7P4gSekjneTaoEHRSgLekjkeTaoDcSpgDekjgeUanC8Tyf8ekjdeUalCnUmf1ejjaeVajCeU/fvejjZeVagChU6fqeijj
					eUacEgQpf9eikGeUacNFG2hCehj0eTaSJGKcgfegjreUaMHqMGgSeejpeVaGHmMMgTedjleWaCG3NJgR]],
				["UpperArm.R"] = [[
					g6jue14CvAquqTg5jwe14Uuyq+prg4jye04huorIpMg3jze04pujrLo7g2j0e04sulrFo3g1j0ez4putq4pBg0j0ez4gu7qlpZg0jzez4SvNqMp6gyjyey4F
					vopjqagujwev3/wPodqogqjues32w1nZqzgpjser3lxLm2rMgpjqer3WxVmnrmgpjper3NxZmgr1gqjoer3MxXmir4grjoer3TxPmvrvgrjoer3hxCnDrbgs
					jpes3zwvngq+gxjqeu38wLohqwg2jsey38vfp1qqg6jue14CvAquqTg7jwe14OutrLpzg8jye24Vuerhpbg9jze34YuVrwpQg9j0e34VuTr2pTg+j0e44OuX
					rypkg/j0e44CuhrnqAg/jze43yuvrUqnhAjye43fu/q7rShAjwe43LvQqfr/hAjue422vgqEsphAjse42kvtprtMhAjqe32Xv3pXtkg/jpe32Qv9pLtwg/jv
					e33VvNqirtg+kBe55dsKuNlEg9j3e34ttysdoPg9jye24Ruerkplg8jxe24OunrVpvg7jue13/u9q0qY]],
				["LowerArm.R"] = [[
					hkjleXZ95Jy0gYhjjoeWaC4nzigZhijreVaI4Xz4gbhgjteUaP4cz0gchfjueUaW40zYgchejueTad5dykgbhejseTai6PxdgXhdjqeTam7FwIgShbjneRav
					74uxf8hVjkeNbF8jtjfDhPjgeJbY9AsieJhNjdeIbb9UrwdyhOjaeIbY9drXdshOjYeJbW9arddohPjXeJbW9MsAdohQjXeJbW8ys9drhRjZeJbX8NuLdxhS
					jbeJbW7fvkd9hYjeeNa+6sw2ethgjieTaV55x6fxhkjleXZ95Jy0gYhljoeYZ44nzfgmhnjreYZ04Xzxg0hojteZZx4bzrhChpjueaZw4zzMhNhqjuebZx5b
					yWhXhqjsecZz6NxNhehrjqecZ27Dv3hihrjnedZ572ubhkhsjkeeZ88htEhihsjgeeZ/9Cr7hdhsjdefaA9XrHhWhrjaefaA9gqvhNhrjZefZ/9eq1hChqjj
					ecZ17fvHhIhqkFebZky548h0hpj0eaZq251YhPhojreZZv4Vzxg4hnjpeYZy4ZzugshljleYZ45Iy0ge]],
				Tail1 = [[
					gAjYhUecgAgA/9gAjZhUeLgdgC/7gBjahUd9g6gE/6gBjahUdxhVgG/4gBjahUdphugI/2gBjbhUdniEgK/1gCjahUdqiXgL/0gCjahUdxingM/zgCjahUd9
					iygL/zgCjZhUeMi5gL/zgCjYhUeci7gJ/0gCjXhUeti5gI/1gCjXhUe8iygG/2gCjWhUfIingF/3gCjWhUfPiYgE/5gBjWhUfSiFgD/6gBjWhUfPhugD/7gB
					jWhUfHhVgC/8gBjXhUe8g6gC/9gAjXhUetgdgB/9gAjYhUecgAgA/9gAjZhUeLfjf+/7f/jahUd9fGf8/6f/jahUdxerf6/4f/jahUdpeSf4/2f/jbhUdnd8
					f2/1f+jahUdqdpf1/0f+jahUdxdZf0/zf+jahUd9dOf1/zf+jZhUeMdHf1/zf+jYhUecdFf3/0f+jXhUetdHf4/1f+jXhUe8dOf6/2f+jWhUfIdZf7/3f+jZ
					hUgHdof9/5f/jhhUitd7gA/zf/jchUhPeSf//7f/jahUgVerf+/9f/jZhUfyfGf+/+gAjYhUe+fjf//+]],
				Tail2 = [[
					gAjhise8ekf9/8gDjjiregfSf//8gGjlireCgBgC/7gIjmirdmgwgF/5gLjnirdOhdgJ/1gNjoiqc8iIgN/xgOjniqcziwgQ/tgQjmiqc0jTgT/qgRjliqc9
					jxgV/ngSjjiqdPkKgW/mgSjhiqdnkbgV/lgSjeiqeDkmgU/mgRjdiqehkqgS/ngQjbire9kmgP/pgPjairfVkbgN/rgNjairfnkJgK/ugLjairfwjxgJ/xgI
					jbisfvjTgH/0gGjdisfmivgG/3gDjeisfUiHgF/6gAjhise8hcgD/8f9jjireggugB/8f6jlireCf/f+/7f4jmirdmfQf7/5f1jnirdOejf3/1fzjoiqc8d4
					fz/xfyjniqczdQfw/tfwjmiqc0ctft/qfvjliqc9cPfr/nfujjiqdPb2fq/mfujhiqdnblfr/lfujeiqeDbafs/mfvjdiqehbWfu/nfwjbire9bafx/pfxjY
					irgublf1/rfzjSiqlDb3f7/Uf1jWiri8cPf6/of4jYishrctf6/xf6jbisg8dRf6/3f9jeisfwd5f7/6]],
				Tail3 = [[
					f4jnkDgZcff9/yf/jrkDgAdQf//3gGjwkDffeEgC/7gMj0kCe7e8gE/9gSj3kBeXf2gH/8gYj5kAd3gwgK/6gdj5j/dehpgO/2gij4j+dNiegR/xglj2j+dI
					jQgU/sgojyj+dOj9gW/ngqjuj+dekkgX/kgrjpj+d4lDgX/hgqjlj+eZlagW/fgpjhj/e9lpgU/egnjekAfhlvgS/dgjjckAgBltgP/egfjbkBgalhgN/gga
					jckCgqlMgK/jgVjfkCgwkwgH/ogOjikDgqkMgF/tgIjnkDgZjhgD/ygBjrkDgAiwgB/3f6jwkDffh8f+/7f0j0kCe7hEf8/9fuj3kBeXgKf5/8foj5kAd3fQ
					f2/6fjj5j/deeXfy/2fej4j+dNdifv/xfbj2j+dIcwfs/sfYjyj+dOcDfq/nfWjuj+debcfp/kfVjpj+d4a9fp/hfWjlj+eZamfq/ffXjhj/e9aXfs/efZjU
					kAhaaRfy/cfdi3j7ncaWf9+mfhjGj/kxahf4/JfmjPkBjTa0f3/ZfrjWkDimbRf4/ifyjfkDhQb0f6/s]],
				Tail4 = [[
					fljklZhca5gA/jfwjrlahRbdgD/pf7jylag9cJgG/vgGj6lZghc6gK/1gSkAlYf/dxgM/6gckElXfdergO/9gmkHlWe7fogQ/+gvkHlUefgkgS/8g3kFlTeL
					hggT/5g9kClSeAiagU/1hCj8lReAjPgV/whGj1lReLkAgV/rhIjulRefkqgU/nhIjnlRe8lNgU/jhGjhlSfdlngS/fhCjclTgAl5gQ/cg9jZlUghmBgO/ag2
					jZlVg9mBgL/agujblWhRl2gI/bgljflYhcljgE/egbjklZhclHgA/jgQjrlahRkjf9/pgFjylag9j3f6/vf6j6lZghjGf2/1fukAlYf/iPf0/6fkkElXfdhV
					fy/9fakHlWe7gYfw/+fRkHlUeffcfu/8fJkFlTeLegft/5fDkClSeAdmfs/1e+j8lReAcxfr/we6j1lReLcAfr/re4julRefbWfs/ne4jnlRe8azfs/je6jN
					lSh4aZf4/ce/iQlEpYaLgR+BfDislOmCaAgA+1fKi+lTkTaAf6/IfSjIlWjnaKf6/PfbjZlYiMadf8/b]],
				Hourglass = [[
					fJjdmshua5gD/ifXjkmuhkbNgF/lfmjtmvhQbogH/qf1j3mwg0cKgK/vgFkAmwgTcygN/1gVkHmvfwdggQ/5gkkNmtfPeRgT/7gykQmsezfFgV/9g/kQmqef
					f7gX/9hLkNmoeUgwgY/7hUkHmneUhlgY/6hcj/mmefiXgX/3hhj2mlezjFgW/0hkjtmkfPjugT/whkjkmkfwkSgQ/thijcmlgTkugM/ohejXmmg0lEgJ/lhX
					jUmnhQlRgF/ihOjUmohklWgD/ghDjXmqhulTgA/gg3jdmshulHf9/igpjkmuhkkzf7/lgajtmvhQkYf5/qgLj3mwg0j2f2/vf7kAmwgTjOfz/1frkHmvfwig
					fw/5fckNmtfPhvft/7fOkQmsezg7fr/9fBkQmqefgFfp/9e1kNmoeUfQfo/7eskHmneUebfo/6ekj/mmefdpfp/3efj2mlezc7fq/0ecjtmkfPcSft/wecjD
					mkiKbugB/oehhfmHpobSgr+IejiMmamUa9gQ+8eqinmiklawgF/Oeyi0mlj5aqgB/Te9jNmqifatgA/d]],
				Gear2 = [[
					gAkkiYgAJZgA2ngCkmiWgQJufv28gEkniVgiKDfc3PgGkpiUg0KXfH3hgIkqiThJKreu3xgKkqiThhK9eR3+gLkqiTh8LNdw4IgMkpiUiaLcdL4OgNkniUi6
					Lpcj4QgOkmiVjcL0b44OgOkkiXj/L8bN4IgOkiiYkjMCaj39gOkgiZlHMFZ73vgNkfialqMGZW3dgMkeibmLMDY23KgLkeibmqL+Yb20gJkeibnHL2YF2dgH
					kfibniLsX02EgFkgian7LhXo1sgCkiiZoTLUXe1TgAkkiYoqLHXW05f+kmiWpBK6XP0gf8kniVpaKvXH0Gf6kpiUp1KnW+zsf4kqiTqSKiWyzRf2kqiTqxKh
					Wjy3f1kqiTrUKlWQyef0kpiUr4KtV7yFfzkniUsfK7VixtfykmiVtFLNVGxWfykkiXtqLjUpxAfykiiYuNL9UKwtfykgiZutMaTqwdfzkfiavIM4TKwPf0kd
					iev8NwSNvrf0kZipxgPiQeuTf3kbikw8PSQuu7f5kdigwoPWQrvTf7kfiewePmQbvff+kiiawLPvQSv0]],
				Gear3 = [[
					gAkQjYgAJZgA2ngEkTjXgaJufl28gIkVjWg0KDfJ3PgMkXjVhPKYeq3ggPkZjUhtKteH3ugSkZjTiNLBdf36gVkZjTiwLTc04BgXkXjTjWLlcE4EgYkVjUj+
					L1bS4DgZkTjVkoMDad38gakQjVlTMQZp3wgakNjWl+MaY13ggZkKjXmqMjYF3MgYkIjYnUMpXY20gVkHjZn+MtWw2ZgTkGjZolMuWO19gQkHjZpLMtVy1ggM
					kIjZpvMqVb1CgIkKjZqRMlVI0jgEkNjYqzMgU50EgAkQjYrUMaUszmf8kTjXr1MWUgzGf4kVjWsXMUUVynf0kXjVs7MVUHyHfxkZjUtgMaT4xmfukZjTuIMk
					TmxFfrkZjTuyMzTRwjfpkXjTvcNIS5wBfokVjUwHNjSfvffnkTjVwxODSBu+fmkQjVxZOnRiuefmkNjWx9PPRCt/fnkKjXydP5QhthfokIjYy4QkP/tHfqkC
					jbzlRuPGsQftj0jh0yT8NoqZfwj8jf0YTtNqq9f0kCjd0JT0NcrLf4kGjc0AUKNGrLf8kMjZzwUWMzrV]],
				Gear1 = [[
					gAkzhBgAJZgA2ngAk0hBfpJfgX2tgAk0hBfTJlgu2ygAk1hBe9JrhF23gBk1hBenJyhc27gBk1hBeRJ4h029gBk1hBd7J+iL2/gBk1hBdlKDii3AgBk0hBdP
					KIi62/gBk0hBc5KNjR2+gBkzhBckKQjo27gBkyhBcOKTj/22gBkyhBb4KWkW2xgBkxhBbhKYks2qgBkxhBbLKalC2igBkwhBa0KblY2ZgBkxhBaeKclt2PgA
					kxhBaHKdmC2FgAkyhBZvKdmX15gAkyhBZYKemr1tgAkzhBZBKfm/1hgAk0hBYpKhnT1UgAk0hBYSKjnm1HgAk1hBX6Kmn606f/k1hBXjKqoN0tf/k1hBXMKu
					og0gf/k1hBW1K0oz0Uf/k1hBWfK6pG0If/k0hBWJLCpZz9f/k0hBVzLLpszyf/kzhBVeLVqAznf/kyhBVJLgqUzef/kyhBU2LsqozUf/kxhBUiL6q8zMf/k0
					hDUdMArDzLf/k9hJUzL5qwzbf/k4hGULMUrczHgAk2hETuMsr/y3gAk1hDTYNBsaysgAkzhCTANYs5ye]],
				["UpperLeg.L"] = [[
					e1iTgV7XdWf8wWe1iTgW7Vdcf2wae0iUgX7Udifvwde0iVgX7Tdnfqwfe0iVgY7Udsfkwfe0iVgY7Vdwfewde0iVgZ7ZdyfZwXe0iVgZ7dd0fVwQe0iUgZ7j
					d0fRwGe0iTgZ7od0fOv8e0iTgZ7udzfMvye0iSgZ7zdxfLvpe0iRgZ73dufLvhe0iQgZ75drfNvde0iQgZ76dofRvbe0iQgY75dlfVvee0iQgY71difbvke0
					iQgX7wdffivte0iRgX7pdcfqv5e1iSgW7gdZfzwHe1iTgV7XdWf8wWe1iTgV7OdTgFwme1iUgU7FdQgNw0e1iVgU68dNgVxAe2iVgT62dKgcxJe2iVgT6ydG
					ghxPe2iVgS6wdDgmxSe2iVgS6wdAgpxQe2iUgS6zc9grxLe2iTgR63c7gsxEe2iTgR69c5gsw7e2iSgR7Dc4gqwye2iRgS7Jc4gnwoe2iQgS7Oc5gjwge2iV
					gR6qdEgmxce2ihgN36drg91He2iagQ5wdYgnyye1iXgS6fdTgZxue1iVgT6ydUgQxSe1iTgU7MdTgFwo]],
				["LowerLeg.L"] = [[
					ewhff5tqgugC86evhgf6t5g1f+8zevhgf7uHg9f78sevhhf7uShEf48meuhhf8ubhLf28ieuhhf8ughRf08feuhhf8uhhXfy8eethhf8ufhcfx8fethhf8ua
					hffw8hethhf8uShifx8lethgf7uIhkfx8qethgf6t+hkfy8uethff6t1hjfz8zethff5tshgf184ethff5tlhcf287ethef5tghWf48+euhef5tehQf68/eu
					hef5tehIf88/evhef5thhAf+8+evhff5tlg3f/89ewhff5tqgugC86ewhff5twglgE84ewhff6t1gcgG81exhgf6t5gTgI80exhgf6t6gMgK8zeyhgf6t5gG
					gN80eyhff6t0gAgO82eyhff5ttf8gQ86eyhff5tkf6gR8+eyhef4tZf4gS9Deyhef3tOf4gS9Ieyhdf3tEf5gS9Neyhdf3s7f8gS9Qeyhcf2s2gAgR9Teyhf
					f5tmgBgO89ezhngFwzf2gD7Oeyhif9u2gGgH8Vexhgf7uIgRgG8sexhgf6t9gagF8yewhff5tqglgE87]],
				["Foot.L"] = [[
					eygsgj8wgDf/uBeygsgj8wgJf8uBeygsgj8wgPf5uBeygsgj8wgUf2uBeygsgj8wgafzuBeygsgj8wgffxuAeygsgj8wgkfvuAeygsgj8wgoftuAeygsgj8w
					grfruAeygsgj8wgufquAeygsgj8wgvfpuAeygsgj8wgvfpuAeygsgj8wgufpuAeygsgj8wgsfquAeygsgj8wgpfsuAeygsgj8wglfuuAeygsgj8wgffxuAey
					gsgj8wgZf0uBeygsgj8wgSf3uBeygsgj8wgKf7uBeygsgj8wgDf/uBeygsgj8wf7gCuBeygsgj8wf0gGuBeygsgj8wftgJuBeygsgj8wfngMuBeygsgj8wfh
					gPuAeygsgj8wfdgRuAeygsgj8wfagTuAeygsgj8wfYgUuAeygsgj8wfXgUuAeygsgj8wfXgUuAeygsgj8wfYgUuAeygsgj8wfagTuAeygsgj8wfdgRuAeygs
					gj8wfdgRuAeygsgj8wfRgXuAeygsgj8wfggPuAeygsgj8wfqgLuBeygsgj8wfygHuBeygsgj8wf7gCuB]],
				["Toe.L"] = [[
					eygPgN/7gCf+iGeygPgN/7gGf5iGeygPgN/7gLf0iGeygPgN/6gPfviGeygPgN/6gTfqiGeygPgN/6gXfmiGeygPgN/6gafiiGeygPgN/6gdffiGeygPgN/6
					ggfciGeygPgN/6gifaiGeygPgN/6gjfZiGeygPgN/6gjfZiGeygPgN/6gifZiGeygPgN/6ghfbiGeygPgN/6gefeiGeygPgN/6gbfiiGeygPgN/6gXfmiGey
					gPgN/6gSfriGeygPgN/7gNfxiGeygPgN/7gIf3iGeygPgN/7gCf+iGeygPgN/7f8gEiGeygPgN/7f3gKiGeygPgN/7fygQiGeygPgN/6ftgViGeygPgN/6fp
					gaiGeygPgN/6fmgdiGeygPgN/6fkggiGeygPgN/6figiiGeygPgN/6fhgiiGeygPgN/6fhgiiGeygPgN/6fighiGeygPgN/6fkggiGeygPgN/6fmgdiGeygP
					gN/6fmgdiGeygPgN/6fdgniGeygPgN/6fpgaiGeygPgN/6fwgSiGeygPgN/7f2gMiGeygPgN/7f8gEiG]],
				["UpperLeg.R"] = [[
					hLiTgV7XiqgEwWhLiTgV7Oitf7wmhLiUgU7Fiwfzw0hLiVgU68izfrxAhKiVgT62i2fkxJhKiVgT6yi6ffxPhKiVgS6wi9faxShKiVgS6wjAfXxQhKiUgS6z
					jDfVxLhKiTgR63jFfUxEhKiTgR69jHfUw7hKiSgR7DjIfWwyhKiRgS7JjIfZwohKiQgS7OjHfdwghKiQgS7TjFfhwYhKiQgT7WjCfmwThKiQgT7Zi/fswQhL
					iQgU7ai6fywPhLiRgU7ai1f4wQhLiSgV7Ziwf+wThLiTgV7XiqgEwWhLiTgW7VikgKwahMiUgX7UiegRwdhMiVgX7TiZgWwfhMiVgY7UiUgcwfhMiVgY7ViQ
					giwdhMiVgZ7ZiOgnwXhMiVgZ7diMgrwQhMiUgZ7jiMgvwGhMiTgZ7oiMgyv8hMiTgZ7uiNg0vyhMiSgZ7ziPg1vphMiRgZ73iSg1vhhMiQgZ75iVgzvdhMiU
					gX7UiNgmwfhMihgS4zhpgA0JhMiagU6UiEgPyEhMiWgV64iSgRxLhMiVgV7CiagNw7hLiTgV7UikgKwc]],
				["LowerLeg.R"] = [[
					hQhff5tqfSf+86hQhff5twfbf884hQhff6t1fkf681hPhgf6t5ftf480hPhgf6t6f0f28zhOhgf6t5f6fz80hOhff6t0gAfy82hOhff5ttgEfw86hOhff5tk
					gGfv8+hOhef4tZgIfu9DhOhef3tOgIfu9IhOhdf3tEgHfu9NhOhdf3s7gEfu9QhOhcf2s2gAfv9ThOhcf2szf8fw9UhPhcf2s1f2fy9ThPhdf2s6fwf09RhP
					hdf3tDfpf29NhQhef4tOfif59IhQhef4tcfaf79BhQhff5tqfSf+86hRhgf6t5fLgC8zhRhgf7uHfDgF8shRhhf7uSe8gI8mhShhf8ube1gK8ihShhf8ugev
					gM8fhShhf8uhepgO8ehThhf8ufekgP8fhThhf8uaehgQ8hhThhf8uSeegP8lhThgf7uIecgP8qhThgf6t+ecgO8uhThff6t1edgN8zhThff5tseggL84hShh
					f7uQeqgO8mhQhngGw+fFge7GhRhjf/vOe+gR8HhRhhf8uee/gK8ghRhgf7uNfFgG8phRhff6tzfLgC82]],
				["Foot.R"] = [[
					hOgsgj8wf9gBuBhOgsgj8wgFf+uBhOgsgj8wgMf6uBhOgsgj8wgTf3uBhOgsgj8wgZf0uBhOgsgj8wgffxuAhOgsgj8wgjfvuAhOgsgj8wgmftuAhOgsgj8w
					gofsuAhOgsgj8wgpfsuAhOgsgj8wgpfsuAhOgsgj8wgofsuAhOgsgj8wgmftuAhOgsgj8wgjfvuAhOgsgj8wgffxuAhOgsgj8wgafzuAhOgsgj8wgVf2uBhO
					gsgj8wgQf4uBhOgsgj8wgKf7uBhOgsgj8wgEf+uBhOgsgj8wf9gBuBhOgsgj8wf3gEuBhOgsgj8wfxgHuBhOgsgj8wfsgKuBhOgsgj8wfmgNuBhOgsgj8wfh
					gPuAhOgsgj8wfcgRuAhOgsgj8wfYgTuAhOgsgj8wfVgVuAhOgsgj8wfSgWuAhOgsgj8wfRgXuAhOgsgj8wfRgXuAhOgsgj8wfSgXuAhOgsgj8wfUgWuAhOgs
					gj8wfdgRuAhOgsgj8wf4gEuBhOgsgj8wfvgIuBhOgsgj8wfvgIuBhOgsgj8wfzgGuBhOgsgj8wf3gEuB]],
				["Toe.R"] = [[
					hOgPgN/7f+gCiGhOgPgN/7gEf8iGhOgPgN/7gJf2iGhOgPgN/7gOfwiGhOgPgN/6gTfriGhOgPgN/6gXfmiGhOgPgN/6gafjiGhOgPgN/6gcfgiGhOgPgN/6
					gefeiGhOgPgN/6gffeiGhOgPgN/6gffeiGhOgPgN/6geffiGhOgPgN/6gcfgiGhOgPgN/6gafjiGhOgPgN/6gXfmiGhOgPgN/6gUfqiGhOgPgN/6gQfuiGhO
					gPgN/7gMfziGhOgPgN/7gHf4iGhOgPgN/7gDf9iGhOgPgN/7f+gCiGhOgPgN/7f6gHiGhOgPgN/7f1gMiGhOgPgN/5fzgTdohOgPgN/5fwgYdohOgPgN//fr
					gbf0hOgPgN/sfsgibphOgPgN/8fjgihehOgPgN/gfpgqaehOgPgN/6fegmiGhOgPgN/ffnguaehOgPgN/8fegohehOgPgN/6fegniGhOgPgN/6ffgliGhOgP
					gN/6fmgdiGhOgPgN/7f6gGiGhOgPgN/7fzgOiGhOgPgN/7fzgOiGhOgPgN/7f3gKiGhOgPgN/7f6gHiG]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAjFgu/+hHf4gHgAjIgu/9g6e/gIgAjOgu/8gjeRgJgAjVgu/6gGd3gIgAjWgu/6fod0gGgAjSgu/7fOeJgEgAjLgu/8e9e0gEgAjFgu/+e3frgGgAjFgu/+
					e+gmgIgAjLgu/8fRhagJgAjSgu/7frh/gJgAjWgu/6gJiOgHgAjVgu/6gmiEgFgAjOgu/8g8hkgEgAjIgu/9hIgygF]],
				Spine1 = [[
					gAjEgTAOe6gQjef+jHgTAPfJgzjlf9jOgTASfihMj5f8jUgTAVgAhYkNf8jWgUAVgehUkTf9jSgTAUg2hCkHf+jLgTARhFgljyf/jFgTAPhIgCjhgBjFgTAP
					hAfejfgCjKgTAQgse/jvgDjSgTATgPeskEgEjWgUAVfxeokSgEjUgTAVfVezkPgDjOgTASfCfLj9gBjHgTAQe4fsjo]],
				Spine2 = [[
					f/jQfeAwe9gXmwf7jTfeA0fHgknBf5jbffA9fdgqnpf4jiffBGf5gnoOf4jkffBJgWgeoXf6jgffBCgtgQn/f8jXffA4g9gAnVgAjRfeAxhEfwm1gDjRfeAx
					hAfim0gGjXffA4gvfYnUgIjfffBCgVfWn+gIjkffBIf4fdoXgHjjffBGfefpoPgFjcffA9fKf4nqgCjUfeA0e+gInC]],
				Neck1 = [[
					f9jcfEDyfFgpvBf6jgfEDlfSgxupf3jpfFEFfpgyvmf3jxfGFBgFgoxLf3jzfGFzgegVyVf6jufGF0gwf/yWf9jkfFFEg6fsxOgBjdfEEIg9fdvpgEjdfEDm
					g2fSuqgHjkfFDwgkfOu/gJjtfGEigJfSwXgJjzfGFeftfhx3gIjxfGF7fYf2yggFjpfFFgfKgLx5gBjgfEEkfEgcwb]],
				Neck2 = [[
					f6kMejGIfMgxyyf2kPejGKfag3y0f0kaenGofxg0zcf1kmeuHPgKgn0Pf3kqeyHmgggS0rf7kkeyHcgvf70egAkZesG4g3fmzxgEkPemGTg4fVzAgIkMeiGF
					gufLytgLkUekGWgcfJzFgMkgeqG8gDfRz3gKkpewHefqfj0igHkoezHlfXf60qgDkfevHMfMgQ0Kf+kTepGkfHgjzX]],
				Head = [[
					f3k6eUAEe6gMhdfzk9eUAFfAf1hqfylJeaAGfTfhiDf0lVekAHfvfRiXf4laeqAIgNfIiZf9lUepAHgnfKiIgClIehAFg6fWhvgHk9eXAEhFfphegLk6eTAE
					hFf/hhgOlCeWAFg4gVh2gNlQefAHgfgoiOgKlZeoAIgBg1ibgGlYerAHflg4iTgAlPelAGfPgxh8f7lCecAFfAghhk]],
				Jaw = [[
					f2k6dS/6hHf8h+f0k9dR/7g/gRhxf0lLdY/8gpgkhef3lYdi/7gKgxhvf7lddo/7fsg1h2gAlWdn/7fTgxhtgFlJde/7fCgjhsgIk8dV/6e5gPh9gLk6dQ/6
					e7f5h6gMlDdU/8fLflhlgLlSdd/8fmfUhngHlcdm/7gGfMh0gClbdo/7gifMhzf9lQdj/7g2fVhlf5lCdZ/6hEfmh2]],
				ClockMin = [[
					f9jmfwe0Jhix2jf6jpfwjnJ7du2wf5jwfyoTLWYX1qf4j3fzsfNoTZzQf5j5fzv5QcPYv4f7j0fyyiTkMgsBf+jtfx0lXAKpn5gBjnfw2Ea/JrjggEjnfw2z
					fsJmezgHjsfx2Yk+KhaBgIj0fy0nqOMZVigIj5fzxquxO/RugGj3fzt/yNR+OtgEjxfyp/0jVPMYgAjqfwlv19Y6Kn]],
				ClockHour = [[
					f9jmfwe0Jhix2jf6jpfwe8Jqig2uf5jwfyfMJwh125f4j3fzfTJzhH2/f5j5fzfEJygr2/f7j0fyegJvgq25f+jtfxdzJpg62wgBjnfwdUJihJ2lgEjnfwdU
					JYhK2agHjsfxdzJMg82SgIj0fyejJDgv2OgIj5fzfKJAgx2NgGj3fzfZJDhM2PgEjxfyfPJLh32UgAjqfwe9JVig2a]],
				["UpperArm.L"] = [[
					fFjHezuoSYk44ffBjLe0vNSakU4Qe+jWe1wrSLjA3We9jge1ycR0hV16e9jle1z9Rafx0Te/jge10/RDeqy6fCjXez1iQveDx+fGjQey1wQhd5xffKjQey1x
					QaeExYfOjWex1lQbejxsfQjfex1DQlfYyffQjkex0BQ1gkzzfPjgeyyeRMiC1afMjWeywrRpjf29fJjMeyvMSFkj4D]],
				["LowerArm.L"] = [[
					eqibe/em+mW4hNemife+eu/IY0g7eiiqe5fJ/xccgpefi1eyfy/+g1gfeei7ergd/nk4gkefi6elg+/AnzgyeiizeghR+kpShFeliseehX+gpehXeqisechQ
					+xojhjeuixedg+/Omqhpexi4eggj/tj4hqeyi6elgC/8gWhoeyi0esfh/wcfhlewiqe1fE/LZGhieuige7ev+pXBha]],
				["UpperArm.R"] = [[
					g4jPey1yvkiExYg0jSex1tvnhvxegxjbex1YvhhFyBgwjiex0nvUgFzFgwjjexzTvAeu0lgyjceyxkumdO2Og1jReyv2uJb63kg5jIezuxtwbM4Wg9jIezuy
					tlbT4dhBjQe0v3tscS34hDjce1xkuAd12rhDjke1zQuZfg1GhCjje10iuyg3zkhAjce01UvHhuyYg8jTez1rvZiFxr]],
				["LowerArm.R"] = [[
					hYiredhVBaW4hehUiuechJBBYShnhQi1eegyAiaohqhOi6eigTAJd0hphOi4epfxAGhmhnhPivexfSAhlVhkhRike4e4BIoKhehUice9epBepUhVhYice/eo
					BMoahEhcike8e5Ailjgxhgiwe2fcAEhZgihii5evgIAKdDgghii7eogvAtZfgqhgi2eihJBRXSg8hdivefhVBhWfhP]],
				Tail1 = [[
					gAjMhTbohOhI/pgCjPhTauguhD/hgEjWhTabgIgw/fgFjchTa8figV/lgFjehTb7fAf4/tgFjZhTcuenfe/ygDjShTc0eefJ/ygBjNhTcIene6/tf/jNhTbI
					fBe4/lf9jThTaefkfF/ff8jahTamgLfd/hf7jehTbagwf6/pf7jchTcYhOgV/wf8jWhTc4hggt/yf+jPhTcjhghA/w]],
				Tail2 = [[
					gGjkiobaj6hD/ZgFjsimZliXhB/PgEj0imYdgcgw/EgCj4inYweegS/HgAj0ioaTcxfy/Tf9jripcEblfZ/bf7jkipc4bIfL/df6jiiocMbkfB/cf7joinaf
					cze8/Vf8jximY3elfF/If9j3imYagkfe/Ef/j3inZbibf//NgBjwipbOj6gc/YgEjnipcpkwgv/cgFjiipcukxg7/c]],
				Tail3 = [[
					gaj+j6canOgr+8gQkPj2aIlTgp+/gFkdj0YDifgh+4f6kfj1XjfTgK+2fvkTj5Y8cOfq++fmkBj7bWZxfS/Bfhj2j7dJYXfN+7fjj4j7dIYSfT+6fqkGj4bW
					ZmfW+/f1kXj1Y9cCfa+8gBkgj0XjfGfo+1gMkaj3YCiSgG+5gWkKj6aHlHgk/Bgdj6j7canGgy++gfj1j7dZn3gw+5]],
				Tail4 = [[
					hAkSlGdRqDgQ+PgskvlEbQoif7+dgSlHlAYqlkf1+of2lLlBXMhsfs+tfbk5lGX1dhfX+0fFkblJaKZvfD+ze5kGlIcoW/fG+fe6kIlHdmV2fh+PfJkglFcc
					Wgf9+Vfhk9lCZ6YzgJ+kf8lMlAXtcTgO+rgYlElDXPgZgd+wgxkqlIY3keg1+2hCkOlIbfn0g/+rhIkElHdYpzgu+V]],
				Hourglass = [[
					h0khmMdlnAgZ/HhZlImLbilUgU/OgvlumJY9ixga/Ff/l6mLXefzgN+1fPlkmRYGc2fk+1elk7mUadaZe/+/eKkZmQc+Y4fA/BeGkVmMd7Yofb/DeXkzmMcv
					Ztft/Me7ldmKaNb4fo/Mfpl4mKX/etfo+8gZlzmOXhhugG+zhIlQmTZJkegy+6hrknmTb0mghG/Bh7kTmOdunbg0/B]],
				Gear2 = [[
					f/kjiJexKaiw3Zf/kpiEeqKEiw3EgAkwiCe2JmiN2sgBk1iEfkJGg/2TgCkziKgmIsfd14gBksiOhjIceF1fgBkliPiAIXdP1RgBkiiLh+Ibc/1UgBkliGhy
					IqdD1mgAktiCh9JEc+1/f/kziDixJncb2Zf+k1iHkGKSbb2rf+kwiMlgLAaV2zf/koiPmjLiZl20f/kiiNnDLvZZ2y]],
				Gear3 = [[
					gFkbjLexKaiw3ZgDkkjGe2KDik3GgCktjFfPJlhz2vgAkvjHgKJGga2Uf+kpjMhaIues12f7kfjPikIidJ1Zf6kXjQjPIgcI1Gf6kYjNjaImbs1Gf8kfjIja
					I1bj1Vf9kpjFjwJSbQ1sf/kvjFktJ8af1/gBktjJmKKyZS2IgEkkjOnqLsX/2FgGkajQo0MaXD18gGkWjPpdMvWr1z]],
				Gear1 = [[
					f5kkg2faJfiL2nf7kng2e1KKik3Mf+kug1eKKui33pgAk0g1dcLHjD35gDk2g1ctLQjN35gGkxg1b+LHjY3pgHkqg2bQKxjm3LgHklg2anKSj62hgGklg2aE
					JwkV1xgEkqg2ZpJSk31DgBkxg1ZXI+le0df+k2g1ZLI3mJ0Ff7k0g1ZCJAm4z9f6kug2Y6JZno0Gf5kng2YvKBoY0a]],
				["UpperLeg.L"] = [[
					e6h7ge1ldZgu3de4h+gi3+dOfq0/e2iHgm7Fc7emwre0iPgo+RcndOpWeyiTgo/dcxbnh6ewiRgm/idVbafOeviLgj/tdccqgUewiGgf/ldLebj7exiFgb/F
					cqflmweziJgX+dcKgco/e2iOgU9Mb8hRsYe4iQgT7qb7hxvce6iNgU6WcEh5xne7iFgW5JcWhrzWe7h+ga3qcyhQ1Q]],
				["LowerLeg.L"] = [[
					e0hAgjk9fjfv/mewhEgagxgifS/+erhTgLgChqfK/8emhwf4kUjBfp/jehiOfwsHkRgw9SegiVfux/kXhu6CejiLfp1JjXhz3teph4fm2mh8hW2hethtfl1P
					gshJ34exhpflyBfshB6ae1hkfrvge5g478e3hef0tZebgx9Ae4hWf9q9eUgm+Ae4hMgHoHekgW+6e2hDgTlufBgD/d]],
				["Foot.L"] = [[
					eygshi8ve+gguAeyhBhc8Gf3gFvTeyhThN7ng6fewIeyheg27SiEewwheyhggd7IjJeGwjeyhZgE7Qjad+wReyhLfw7tisefvteyg3fm8XhafSuteygsft8w
					gNf6uBeygsf98wfTgWuAeygsgO8uelgst/eygsgf8seKg5t/eygsgw8seDg9t/eygshA8teNg4t/eygshR8uejgtt/]],
				["Toe.L"] = [[
					eygPhL/5fPg3iGeygihJ/yf5gIjieygzg7/qgpfLkfeyg9gm/ghceEk+eyhAgM/YiLdDlDeyg5fy/YiZc1kweygrfe/lh6dlkDeygZfR/0hBezi4eygPfW/7
					gKf1iGeygPfn/6fegmiGeygPf4/4e9hLiGeygPgI/2ephiiGeygPgZ/2ejhoiFeygPgq/3erhfiGeygPg7/4e7hNiG]],
				["UpperLeg.R"] = [[
					hQiFgd/Ki+gtmmhOiHgZ+3jpgBnnhLiMgW95j/fIqphJiQgU8bkGecuAhHiPgU6+kBeIwohFiJgV5wj0eLyghFiBgY4ejdeh0QhGh7gc2ti8fB2UhHh8gg2u
					isf02WhJiCgk5ci7g3zKhLiLgn8zjQiCtYhNiSgo/KjbjqlNhPiSgn/gi8kvf9hQiOgl/nijkFfahRiIgh/uirifh1]],
				["LowerLeg.R"] = [[
					hUhufn3Aeye72KhRhsfkzkf1e65ShNhnfowrgwfE7RhKhhfwudhZfL8fhIhbf5sPhrfU9ghIhRgCpjhmfh+fhJhHgNmyhOf0/PhLhAgblEgugG/lhOhBgfig
					f/gi/4hShKgUf4e8g2/9hXhggBhedtgs/3hdiAfyoKcSf3+thgiUfvvcbger7nhfiRfsz1cDeJ4thaiCfn2BdVea3A]],
				["Foot.R"] = [[
					hOgsfk8wfSgWuAhOgsf18wgRf4uBhOgsgG8vhGfeuAhOgsgX8thrfMt/hOgsgn8sh8fEt/hOgsg48sh6fEt/hOgshJ8thpfNt/hOgshZ8vhPfZuAhOg3hg8Z
					gnfsuthOhLhW71fpgNvxhOhZhC7beig4wYhOhggq7MdXhnwlhOhegQ7JcliEwchOhTf57cc3h2wChOhBfq8Bd7hJvQ]],
				["Toe.R"] = [[
					hOgPfO/6fegmiGhOgPff/7gNfyiGhOgPfv/5g0fGiGhOgPgA/3hPeniGhOgPgR/2hceZiGhOgPgh/2hbebiGhOgPgy/3hOepiGhOgPhD/5g7e+iGhOgZhL/2
					gdfei4hOgrhD/ufwgVkFhOg5gx/le+hYkyhOhAgZ/ceLiflEhOg9f//WdojNk8hOgzfn/edyi5kdhOgifW/tegh2ji]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAjSgu/8gAgAhygAi6gu/6fze1hygAi/gu/5fueWhygAjXgu/6fze1hygAjSgu/8gAgAhygAi6gu/6gNhLhygAi/gu/5gShqhygAjXgu/6gNhLhy]],
				Spine1 = [[
					gAjPgTAHgAgAihf+i3gTAFgVhJhwf9i8gUAHgehnh6f+jUgTAKgXhIisgAjPgTAHgAgAihgCi3gTAFfre3hwgDi8gUAHfieZh6gCjUgTAKfpe4is]],
				Spine2 = [[
					gAjXfeAsgAgAmhf6i9feAcgchGlAf4jDfeAhgphjlWf6jdfeAygghEm3gAjXfeAsgAgAmhgGi9feAcfke6lAgIjDfeAhfXedlWgGjdfeAyfge8m3]],
				Neck1 = [[
					gAjjfDFKgAgAxYf4jFfCDogxg6utf1jMfDD+hHhQvTf5jpfEFjg4g0x8gAjjfDFKgAgAxYgIjFfCDofPfGutgLjMfDD+e5ewvTgHjpfEFjfIfMx8]],
				Neck2 = [[
					gAkYerIIgAgA1Sf3j1ehGNg5gyy4fzj9ejGohThEzaf4kgeuImg/gq1xgAkYerIIgAgA1SgJj1ehGNfHfOy4gNj9ejGoete8zagIkgeuImfBfW1x]],
				Head = [[
					gAlIemAOgAgAjpf2kkeSAGgUgjiHfzkseXAIgfgxicf5lQerARgbghj/gAlIemAOgAgAjpgKkkeSAGfsfdiHgNkseXAIfhfPicgHlQerARflffj/]],
				Jaw = [[
					gAlRdk/8gAgAhqf0kldQ/gf0fZlgfwkwdU/oftfKkqf2ladp/+fqfbg0gAlRdk/8gAgAhqgMkldQ/ggMgnlggQkwdU/ogTg2kqgKladp/+gWglg0]],
				ClockMin = [[
					gAjufvd3JfiJ2hf8jVftlNK2aC2pf6jafts0O0RXysf8jzfwzRV2LHqlgAjufv2hd3JfiJgEjVft2pl+K2azgGjaftysupO0TMgEjzfwql05V2Mv]],
				ClockHour = [[
					gAjufvd3JfiJ2hf8jVftctKejK3Nf6jaftc6Kzi33kf8jzfwd/KUhy3WgAjufvd3JfiJ2hgEjVftc2IzjT1igGjaftdJIcjG1NgEjzfweOIqiB1s]],
				["UpperArm.L"] = [[
					fGjSeyq5Sal26Le9i0e3nLUVnR7+e6i7e5oGUdmn78e+jZe3rzTEkx6WfGjSeyq5Sal26LfQiyevm1SeoO68fTi4etnqR3oD6dfPjYeurpRamD5Q]],
				["LowerArm.L"] = [[
					eoisfIgF/4iWhEehiWfYgH/6dvf5eeicfZgR/9ewfbegizfMgg/zjXf8eoisfIgF/4iWhEewiTfMfv/1dviPeziYfHfp/2eyitexiwe/fu/vjZiL]],
				["UpperArm.R"] = [[
					g6jSeyq5tmaK6Lgwiyevm1tiXy68gti4etnquJX96dgxjYeurpumZ95Qg6jSeyq5tmaK6LhDi0e3nLrrYv7+hGi7e5oGrjZZ78hCjZe3rzs8bP6W]],
				["LowerArm.R"] = [[
					hYisfIgFAIdqhEhQiTfMfvALiRiPhNiYfHfpAKhOithPiwe/fuARcniLhYisfIgFAIdqhEhfiWfYgHAGiRf5hiicfZgRADhQfbhgizfMggANcpf8]],
				Tail1 = [[
					gAjdhScmg5f5/zgDjFhSa3gef+/kgEjKhSbJfygB/ngDjjhSc4fOgG/1gAjdhScmfHgH/zf9jFhSa3figC/kf8jKhSbJgOf//nf9jjhSc4gyf6/1]],
				Tail2 = [[
					gFjwioevivfs/2gFjhimbuhHf5/rgDjlimaxe1gD/if+j0iodxdPgL/yf7jwioevdRgU/2f7jhimbue5gH/rf9jlimaxhLf9/igCj0iodxixf1/y]],
				Tail3 = [[
					gUj3j/hMkwfe/ngMj4j6eci1fn/0f8kBj5bufOgE/sfvkAj+eecFgO/tfsj3j/hMbQgi/nf0j4j6ecdLgZ/0gEkBj5bugyf8/sgRkAj+eej7fy/t]],
				Tail4 = [[
					gujwlTipmFfW/SgbkBlRhek2fM/lf4kZlOd7gyf5/6fakIlTfGcNgT/wfSjwlTipZ7gq/SflkBlRhebKg0/lgIkZlOd7fOgH/6gmkIlTfGjzft/w]],
				Hourglass = [[
					hOjhmji0iEe7/yg1j4mkhnf5e5/7f8kkmleOd2gD/3fFkNmpfYc/gU/1eyjhmji0d8hF/yfLj4mkhngHhH/7gEkkmleOiKf9/3g7kNmpfYjBfs/1]],
				Gear2 = [[
					gEkwiNemKDhN3MgFkeiDehJxhY26gDkjiFf6JPgK2ef/k1iOiZI+d91+f8kwiNjWJBdG1zf7keiDjHJRdI2Gf9kjiFkOJ8bq2WgBk1iOmTK2ZK2H]],
				Gear3 = [[
					gIkkjOemKDhN3MgHkZjGe4JvhA27gCkcjHgqJQfb2df8knjQjiJIc412f4kkjOk2JTbs1kf5kZjGk+JnbV1zf+kcjHmXKdZf10gEknjQorLtWr1M]],
				Gear1 = [[
					gAkygsdcJiik2egBkZgscgKgjY3LgCkfgrbqLBkR3XgBk3gsa1K2lM22gAkygsZ9KNmD1zf/kZgsZDJpm10sf+kfgrYIJnnl0Df/k3gsXUKQob0G]],
				["UpperLeg.L"] = [[
					e1iLglyWdvgv6Gezh0gq4Hcqex0tezh6gt6jdFXzQbeziSgq/zeGeLiPe1iLgl/zdVf/iGe3hygg/lbvfziwe4h3gd47cchvzqe3iQggtKeNiE9B]],
				["LowerLeg.L"] = [[
					ewhUg5eMgqfv/7eog7ghQEi/gD7kefitgV5xl8hwx6esiKfw8uingdt2e0iEfq/6gbf0iNe1hoflxVfGgU64e1g+gPkXfWgi/re0hjhGlyfigZ/d]],
				["Foot.L"] = [[
					eyhbh67xgFf9v4eyh0hB7Hjmd0wdeyhzf96ylocnwMeyhXfH7viZepvsezh7ep/Jfzf2nSeygsgB8uepgquAeygshP8ve8ghuAeyhMiE6PfGgoyQ]],
				["Toe.L"] = [[
					eyg8hoASf+gFkIeyhUgwATeFjwgLeyhSfsBFcFlRbJeyg4e0AZeTiKb/ezhqeIAbgPgElCeygPfqAIhAe4d6eygPg4ADgtfDgteygph3AggNe7lb]],
				["UpperLeg.R"] = [[
					hLiLgl/zirgBiGhJhygg/lkRgNiwhIh3gd47jkeRzqhJiQggtKhzd89BhLiLglyWiRfR6GhNh0gq4HjWhP0thNh6gt6ji7oNQbhNiSgq/zh6h1iP]],
				["LowerLeg.R"] = [[
					hMiEfq/6flgMiNhLhoflxVg6fs64hLg+gPkXgqfe/rhMhjhGlygefn/dhQhUg5eMfWgR/7hYg7ghQEdBf97khhitgV5xaEeQx6hUiKfw8udZfjt2]],
				["Foot.R"] = [[
					hNh7ep/JgNgKnShOgsgB8uhXfWuAhOgshP8vhEffuAhOhMiE6Pg6fYyQhOhbh67xf7gDv4hOh0hB7HcaiMwdhOhzf96yaYjZwMhOhXfH7vdnhXvs]],
				["Toe.R"] = [[
					hNhqeIAbfxf8lChOgPfqAIfAhId6hOgPg4ADfTg9gthOgph3AgfzhFlbhOg8hoASgCf7kIhOhUgwATh7cQgLhOhSfsBFj7avbJhOg4e0AZhtd2b/]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAjXguAEgAgAh2gAjSgzAGgAgAiOgAjFg9ALgAgAjJgAi3hIASgAgAkHgAiwhOAWgAgAkngAjdgQABgAgAgFgAjzfpAIgAgAdZgAjzfpAIgAgAdZgAjzfpAI
					gAgAdZgAjxfuAGgAgAdsgAjqgAACgAgAe3gAjhgYABgAgAgYgAjZgqADgAgAhjgAjXguAEgAgAh2gAjXguAEgAgAh2gAjXguAEgAgAh2]],
				Spine1 = [[
					gAjbgTAjgAgAl0gAjWgYAmgAgAmCgAjKgiAtgAgAmlgAi+guA1gAgAnJgAi3g0A5gAgAncgAjdf1ATgAgAkQgAjvfPAGgAgAiOgAjvfPAGgAgAiOgAjvfPAG
					gAgAiOgAjtfTAHgAgAidgAjoflANgAgAjagAjhf9AXgAgAkpgAjcgPAggAgAllgAjbgTAjgAgAl0gAjbgTAjgAgAl0gAjbgTAjgAgAl0]],
				Spine2 = [[
					gAjufhBcgAgApdgAjqflBegAgApigAjgfxBhgAgAptgAjVf9BlgAgAp5gAjQgDBngAgAp/gAjrfBBEgAgAoHgAj2eZAvgAgAmwgAj2eZAvgAgAmwgAj2eZAv
					gAgAmwgAj2edAygAgAm8gAj0ewA8gAgAnpgAjxfIBMgAgAolgAjvfcBZgAgApSgAjufhBcgAgApdgAjufhBcgAgApdgAjufhBcgAgApd]],
				Neck1 = [[
					gAj+fJE9gAgAxFgAj6fNFXgAgAxtgAjxfZGbgAgAzNgAjmflHpgAgA0ugAjhfsIUgAgA1fgAj5enDzgAgAvFgAkCd/CAgAgArFgAkCd/CAgAgArFgAkCd/CA
					gAgArFgAkCeDCKgAgArggAkBeWC1gAgAtIgAkAewD2gAgAvLgAj/fEEugAgAwsgAj+fJE9gAgAxFgAj+fJE9gAgAxFgAj+fJE9gAgAxF]],
				Neck2 = [[
					gAkzewHKgAgA0KgAkwe3H1gAgA09gAkpfJJmgAgA21gAkgfcLogAgA4qgAkbfmMvgAgA5igAkqeHFkgAgAyBgAkodSCzgAgAtCgAkodSCzgAgAtCgAkodSCz
					gAgAtCgAkpdYDCgAgAtjgAktdwEBgAgAvggAkweQFhgAgAx8gAkzepG0gAgAzugAkzewHKgAgA0KgAkzewHKgAgA0KgAkzewHKgAgA0K]],
				Head = [[
					gAljemAEgAgAhqgAlgewALgAgAjJgAlZfKAvgAgAmxgAlQflBzgAgAqhgAlKf0CigAgAsbgAlXd1ACgAgAgwgAlMcyAagAgAa/gAlMcyAagAgAa/gAlMcyAa
					gAgAa/gAlOc5AWgAgAbbgAlWdWAJgAgAdLgAled+ABgAgAfdgAliedACgAgAhNgAljemAEgAgAhqgAljemAEgAgAhqgAljemAEgAgAhq]],
				Jaw = [[
					gAljdj//gAgAgpgAlndu//gAgAf2gAlveL/6gAgAdzgAlzet/qgAgAbZgAl0fA/egAgAaUgAlTcz86gAgAttgAkxb19egAgAscgAkxb1+xgAgAovgAkxb1+f
					gAgApqgAk1b7/GgAgAnigAlDcW/lgAgAlIgAlUc8/3gAgAi2gAlgdb/+gAgAhGgAljdj//gAgAgpgAljdj//gAgAgpgAljdj//gAgAgp]],
				ClockMin = [[
					gAkBf2gAJZgA2ngAj9f7g5JafH2mgAjzgGjHJmc52agAjogSlmKFaa17gAjigZnKKjY21dgAkAfUniKrYe1VgAkMerwRQTPvvtgAkMer2ngMJZf0gAkMerxc
					uaOkRmgAkMevs3ynTJNZgAkJfDrxzUUPMsgAkFfdpQ0pWwLXgAkCfxl/10aBKMgAkBf2i92bdDJlgAkBf2gz2nfNJZgAkBf2gA2ngAJZ]],
				ClockHour = [[
					gAkBf2gAJZgA2ngAj9f7gDJZf92ngAjzgGgMJZf02ngAjogSgVJZfr2ngAjigZgZJZfn2ngAkAfUfBJag/2mgAkMereCJeh+2igAkMereCJeh+2igAkMereC
					Jeh+2igAkMeveKJdh22jgAkJfDerJbhV2lgAkFfdfWJZgq2ngAkCfxf4JZgI2ngAkBf2gAJZgA2ngAkBf2gAJZgA2ngAkBf2gAJZgA2n]],
				["UpperArm.L"] = [[
					fGjxe10WRNgAzvfGjte51RQzeiyXfGjjfF3FQaatuzfGjZfR4SQ/Wjq4fGjUfX4oRsUao0fGjqeV34RAbXuXfGjxdt4JRjczu4fGjxdt4JRjczu4fGjxdt4J
					Rjczu4fGjxdy37RgdBvOfGjxeE3BRXd2wkfGjxed1uRPe8yPfGjxew0pRNfyzcfGjxe10WRNgAzvfGjxe10WRNgAzvfGjxe10WRNgAzv]],
				["LowerArm.L"] = [[
					eojHeogA/+gAhEemjHeog3/wjlhDeijJepi/9dsFgzeejNeylK4fz7gRecjPe4mQ1A3Tf5eljOd3hg/ilKgneojRdQf6/2dOhEeojRdQf6/2dOhEeojRdQf6
					/2dOhEeojQdWf6/3dahEeojNdsf8/6eIhEeojKeKf+/9fFhEeojIeigA/+f0hEeojHeogA/+gAhEeojHeogA/+gAhEeojHeogA/+gAhE]],
				["UpperArm.R"] = [[
					g6jxe10WuzgAzvg6jte51RvNheyXg6jjfF3FvmlTuzg6jZfR4SvBpdq4g6jUfX4ouUrmo0g6jqeV34vAkpuXg6jxdt4JudjNu4g6jxdt4JudjNu4g6jxdt4J
					udjNu4g6jxdy37ugi/vOg6jxeE3BupiKwkg6jxed1uuxhEyPg6jxew0puzgOzcg6jxe10WuzgAzvg6jxe10WuzgAzvg6jxe10WuzgAzv]],
				["LowerArm.R"] = [[
					hYjHeogAACgAhEhajHeog3AQcbhDhejJepi/CjT7gzhijNeylKHhMFgRhkjPe4mQLAItf5hbjOd3hgAea2gnhYjRdQf6AKiyhEhYjRdQf6AKiyhEhYjRdQf6
					AKiyhEhYjQdWf6AJimhEhYjNdsf8AGh4hEhYjKeKf+ADg7hEhYjIeigAACgMhEhYjHeogAACgAhEhYjHeogAACgAhEhYjHeogAACgAhE]],
				Tail1 = [[
					gAjbhUecgAgA/9gAjUhYebgAgA/8gAjFhjeYgAgA/8gAi1hteVgAgA/8gAishzeTgAgA/8gAjkg1bRgAgA/ogAkAgNaBfNgF/agAkAgNbQfUgC/ogAkAgNbQ
					gsf+/ogAj+gSbohmf8/pgAj0gkc+hXgA/0gAjng9eSgPgB/8gAjdhPe7fqf//+gAjbhUeof4gA/9gAjbhUecgAgA/9gAjbhUecgAgA/9]],
				Tail2 = [[
					gAjjiseRgAgA/8gAjdiwd3gAgA/6gAjOi6c2gAgA/1gAi+jFbygAgA/tgAi2jLbPgAgA/ogAj+iJZsgAgA/Xf8khheZ2eagJ/Wf8kahhcVepgE/wgEkahhcV
					hXf8/wgJkWhmczjLf5/rgHkFh7eViugB/1gBjxiUfbgfgC/+f+jjinfifVf9/+f/jiisepfwf//9gAjjiseRgAgA/8gAjjiseRgAgA/8]],
				Tail3 = [[
					gAjtkDe7gAgA/+gAjpkHeIgAgA/7gAjfkRcKgAgA/wgAjVkaaFgAgA/cgAjQkfZBgAgA/OgAkgjbY8gAgA/MfzlCiwagdogQ/bf1kui2ePd+gJ/4gLkui2eP
					iCf3/4gakni6e0kwfv/ngWkOjRghkFf9/ugEj0jshZgugB/9f6jmj/g+e/f9/9f+jqkDfgfof///gAjtkDe7gAgA/+gAjtkDe7gAgA/+]],
				Tail4 = [[
					gAjzlbftgAgA//gAjzlfehgAgA/9gAj0lmblgAgA/rgAj1lsYhgAgA/GgAj1luW9gAgA+rgAlGkqYUgAgA/DfmlgkBbSc2ga/efqk4kNgRdTgQ/4gWk4kNgR
					itfw/4g0ktkOg9mSfg/WgtkLkmi0lafz/agIjslEjfg9gA/yf1jglXiiepf+/3f8jslbgefggA//gAjzlbftgAgA//gAjzlbftgAgA//]],
				Hourglass = [[
					gAj0mzgAgAgA//gAj7m2e0gAgA/+gAkMm7b4gAgA/ugAkdm6Y0gAgA/LgAklm4XPgAgA+xgAlvl4YpcRg5+5fUl5lUbpZcg7+/fbk2lkgkdTgR/3glk2lkgk
					itfv/3hWkolfhQmvfe/PhKj8l4jHnPf8/AgNjZmajxjbgT/lftjSmti1glgK/3f5jqmzgxgCgB/+gAj0mzgAgAgA//gAj0mzgAgAgA//]],
				Gear2 = [[
					gAkmiYgAJZgA2ngAkgicgTJZft2ngAkRimhEJae82mgAkBixh7JeeF2igAj5i2ifJhdh2fgAk8hohAJafA2mf9lcg5koJUb51sf9lYhArpMEVAzOgDlYhAvg
					QNPswWgHlUhHwnSYNautgGlGhhxiTVMztqgBk0iAzNUXMhr0f/kniV0UViMHqPf/kmiZ0lWaLlphgAkmiY0yXFLOo7gAkmiY05XWLHoq]],
				Gear3 = [[
					gAkSjYgAJZgA2ngAkMjcgaJZfm2ngAj9jmhbJbel2lgAjtjxilJidb2egAjlj2jVJocr2YgAk1iriFJfd72hf5lah8nHJ+Zh1Gf6lRiCvhO6RRwhgGlRiCzb
					VXLqq7gNlMiJ0HYcJrn8gLk4ii0tZuJamqgCkgjA2AbhJrkjf9kRjV2tdXJyilf/kRjY2reqJhhWgAkSjY2nfnJZgZgAkSjY2ngAJZgA]],
				Gear1 = [[
					gAk1hBgAJZgA2ngAkwhIgBJZf/2ngAkhhXgCJZf+2ngAkRhogAJZgA2ngAkJhwf5JZgH2ngAk8gYcLJuj12SgAlTfiXDLPo90xgAlTfiSgN3tgyJgAlTfiPG
					Q+w6vCgAlRfoOESOx8tygAlKgBOcRxxkuPgAlAgiOtRbxTulgAk4g7OrRexVuigAk1hBOPSAxxuAgAk1hBN2ShyKtfgAk1hBNtStyTtT]],
				["UpperLeg.L"] = [[
					e1iVgV7EdbgAw2e1iQgY72dRf1vge1iFgf9Xc+fdsUe1h5gm+jcufEo2e1hygp/Bcne2m7e1iYf/33dzge1Le1isfk0PeQg44te1isfk0PeQg44te1isfk0P
					eQg44te1irfn0bePg34je1ikf01PeOg032e1icgF4Cd3gf1Ae1iWgS6kdfgGxpe1iVgV7EdbgAw2e1iVgV7EdbgAw2e1iVgV7EdbgAw2]],
				["LowerLeg.L"] = [[
					ewhgf7uMgrgA8qevhef5tigwgE8+evhbf1scg5gL9deuhaf0sBg+gR9oeuhaf0sHhAgU9lexhdf3tKggf29KeyhyfvtugRfs85eyhyfvtugRfs85eyhyfvtu
					gRfs85eyhwfyt8gRfs8yeyhpf7u5gSft8Texhif9uqgdf18bewhgf7uJgpf+8rewhgf7uMgrgA8qewhgf7uMgrgA8qewhgf7uMgrgA8q]],
				["Foot.L"] = [[
					eygsgj8wgAgAuBeygsgj8wgFf+uBeygsgj8wgOf5uBeygsgj8wgVf2uBeygsgj8wgXf1uBeygsgj8wf0gGuBeyg/gZ7JfogPw7eyg/gZ7JfogPw7eyg/gZ7J
					fogPw7eyg9gb7YfogPwieygzgg8OfngNvEeygsgj8wfygHuBeygsgj8wf+gBuBeygsgj8wgAgAuBeygsgj8wgAgAuBeygsgj8wgAgAuB]],
				["Toe.L"] = [[
					eygPgN/7gAgAiGeygPgN/7gEf8iGeygPgN/7gLf0iGeygPgN/6gPfviGeygPgN/6gRftiGeygPgN/+f4gKfBeygegJ//f0gZf2eygegJ//f0gZf2eygegJ//
					f0gZf2eygcgK//fzgZfxeygUgM//fwgYfheygPgN//f2gNgQeygPgN/8f+gChueygPgN/7gAgAiGeygPgN/7gAgAiGeygPgN/7gAgAiG]],
				["UpperLeg.R"] = [[
					hLiVgV7EilgAw2hLiQgY72ivgLvghLiFgf9XjCgjsUhLh5gm+jjSg8o2hLhygp/BjZhKm7hLiYf//CjkhKmxhLisfk+ijsi7XthLisfk+ijsi7XthLisfk+i
					jsi7XthLirfn+0juizYzhLikf0/rjxiFe0hLicgF+tjYg+oQhLiWgS8EiygNvGhLiVgV7EilgAw2hLiVgV7EilgAw2hLiVgV7EilgAw2]],
				["LowerLeg.R"] = [[
					hQhgf7uMfVgA8qhRhef5tifQf88+hRhbf1scfHf19dhShaf0sBfCfv9ohShaf0sHfAfs9lhSiAfJtJfAfo9JhSjLey4ifPfU0ghSjLey4ifPfU0ghSjLey4i
					fPfU0ghSjFez3YfNfU1zhSipe5ykfFfZ6ChSh/fSuLfEfp8qhRhmfxtzfPf782hQhgf7uMfVgA8qhQhgf7uMfVgA8qhQhgf7uMfVgA8q]],
				["Foot.R"] = [[
					hOgsgj8wgAgAuBhOgsgj8wf7gCuBhOgsgj8wfygHuBhOgsgj8wfrgKuBhOgsgj8wfpgLuBhOhPf1+TflgJqPhOiKem/8fnf/ePhOiKem/8fnf/ePhOiKem/8
					fnf/ePhOiDeu//flgAfthOhrfP/ifigFlThOhLf6+HfqgIqyhOgygb9Af6gDtehOgsgj8wgAgAuBhOgsgj8wgAgAuBhOgsgj8wgAgAuB]],
				["Toe.R"] = [[
					hOgPgN/7gAgAiGhOgPgN/7f8gEiGhOgPgN/7f1gMiGhOgPgN/6fxgRiGhOgPgN/6fvgTiGhOg4fY/dftgVaMhOiOeB5PfrgNMXhOiOeB5PfrgNMXhOiOeB5P
					frgNMXhOiEeK6ZfqgPN7hOhfes92fpgUUghOgzfe/xfwgRcThOgWgD/+f8gFhChOgPgN/7gAgAiGhOgPgN/7gAgAiGhOgPgN/7gAgAiG]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAjXguAEgAgAh2gAjUguADgAgAhcgAjLguABgAgAgggAjEguABgAgAfvgAjGguABgAgAf4gAjVguAGgAgAiQgAjeguATgAgAkSgAjfguAXgAgAkogAjfguAX
					gAgAkogAjfguAXgAgAkogAjfguAXgAgAkogAjfguAXgAgAkogAjfguAXgAgAkogAjfguAXgAgAkogAjfguAXgAgAkogAjfguAXgAgAkogAjfguAXgAgAkogA
					jfguAWgAgAkkgAjcguAOgAgAjngAjZguAGgAgAiSgAjXguAEgAgAh2gAjXguAEgAgAh2gAjXguAEgAgAh2]],
				Spine1 = [[
					gAjbgTAjgAgAl0gAjWgTAdgAgAlQgAjMgTARgAgAj+gAjEgTAKgAgAi8gAjFgTALgAgAjIgAjZgUAqgAgAmYgAjlgUBWgAgApJgAjngUBfgAgApngAjngUBf
					gAgApngAjngUBfgAgApngAjngUBfgAgApngAjngUBfgAgApngAjngUBfgAgApngAjngUBfgAgApngAjngUBfgAgApngAjngUBfgAgApngAjngUBfgAgApngA
					jngUBegAgApigAjigUBGgAgAoOgAjdgUArgAgAmbgAjbgTAjgAgAl0gAjbgTAjgAgAl0gAjbgTAjgAgAl0]],
				Spine2 = [[
					gAjufhBcgAgApdgAjofgBPgAgAowgAjaffA1gAgAnLgAjOfeAkgAgAl3gAjQfeAngAgAmGgAjufhBrgAgAqKgAkDfnDCgAgAtkgAkGfoDTgAgAuHgAkGfoDT
					gAgAuHgAkGfoDTgAgAuHgAkGfoDTgAgAuHgAkGfoDTgAgAuHgAkGfoDTgAgAuHgAkGfoDTgAgAuHgAkGfoDTgAgAuHgAkGfoDTgAgAuHgAkGfoDTgAgAuHgA
					kFfoDQgAgAuCgAj9flCigAgAscgAjyfiBsgAgAqNgAjufhBcgAgApdgAjufhBcgAgApdgAjufhBcgAgApd]],
				Neck1 = [[
					gAj+fJE9gAgAxFgAj3fHEKgAgAvvgAjmfFCmgAgAsmgAjYfDBmgAgAp7gAjbfDBwgAgAqZgAkAfKFZgAgAxvgAkZfUJkgAgA2ygAkdfWKTgAgA3ggAkdfWKT
					gAgA3ggAkdfWKTgAgA3ggAkdfWKTgAgA3ggAkdfWKTgAgA3ggAkdfWKTgAgA3ggAkdfWKTgAgA3ggAkdfWKTgAgA3ggAkdfWKTgAgA3ggAkdfWKTgAgA3ggA
					kcfWKLgAgA3YgAkSfRIIgAgA1TgAkDfLFsgAgAyLgAj+fJE9gAgAxFgAj+fJE9gAgAxFgAj+fJE9gAgAxF]],
				Neck2 = [[
					gAkzewHKgAgA0KgAkpepF6gAgAyggAkQecDfgAgAufgAj7eUB+gAgArAgAj/eVCNgAgArogAk1e0H2gAgA0+gAlUfVOagAgA6tgAlXfbPjgAgA7cgAlXfbPj
					gAgA7cgAlXfbPjgAgA7cgAlXfbPjgAgA7cgAlXfbPjgAgA7cgAlXfbPjgAgA7cgAlXfbPjgAgA7cgAlXfbPjgAgA7cgAlXfbPjgAgA7cgAlXfbPjgAgA7cgA
					lWfaPXgAgA7UgAlMfKMLgAgA5GgAk6e2IUgAgA1fgAkzewHKgAgA0KgAkzewHKgAgA0KgAkzewHKgAgA0K]],
				Head = [[
					gAljemAEgAgAhqgAlXeZADgAgAepgAk4eABDgAgAX8gAkadvC5gAgASvgAkgdxCggAgATpgAlmetANgAfpjZgAmAfoEJgYfKvsgAmCfyEWfOhxv9gAmCfyFD
					gQfgxNgAmCfyFXgsesxogAmCfyEZfRhowDgAmCfyE4gAgAw8gAmCfyFdg1ebxxgAmCfyEdfZhWwNgAmCfyEtfxggwrgAmCfyFhg6eTx1gAmCfyEkfjg9wagA
					mCfwEaflg8wJgAl7fVCfgWe1sQgAlqexASgAgGkJgAljemAEgAgAhqgAljemAEgAgAhqgAljemAEgAgAhq]],
				Jaw = [[
					gAljdj//gAgAgpgAlKdY/vgAgAj+gAkRdJ99gAgArPgAjkdI7SgAgAwtgAjsdI71gAgAvxgBltdr/tf7gWkMgEm1fA/8fSgmeqf4m3fL/7hke4gFgCm7fQ/9
					fjgTeqgGm8fS/5ewgzeIf5m3fL/8hce+f/gAm6fP/+gAgAe+gHm8fS/4egg8d+f6m4fM/9hNfJf0f+m5fN/+gdfsfSgIm8fT/3eXhBd4f8m5fN/+g3fZflf8
					m4fK/+g2fZfmgFmlei/8fRg+e5gAl1dw//gBf7gcgAljdj//gAgAgpgAljdj//gAgAgpgAljdj//gAgAgp]],
				ClockMin = [[
					gAkBf2gAJZgA2ngAj8f0gBJZf/2ngAjvfxgNJZfz2ngAjlfugwJZfQ2ngAjnfvh1JdeL2jgAkAf4lfKEah18gAkPgAreMhUizfgAkRgCxTRbOtulgAkRgC15
					aWKHlqgAkRgC1ompKYZXgAkRgCtryBSVN/gAkRgCfv2ngRJZgAkRgCR6xsuGOUgAkRgCKPmI1xZ4gAkRgCKQZ01wmMgAkRgCPERAw8vAgAkRgCUoMdrYzjgA
					kRgCYFK0n71MgAkMf9XvK9oR1DgAkEf4YTKvnt1RgAkBf2bWJ4kq2IgAkBf2erJbhV2lgAkBf2gAJZgA2n]],
				ClockHour = [[
					gAkBf2gAJZgA2ngAj8f0foJZgY2ngAjvfxezJbhN2lgAjlfuePJdhx2jgAjnfveoJbhY2lgAkAf4hyJdeO2jgAkPgAlTKBat1/gAkRgCncKpYk1XgAkRgCpy
					LnWO0ZgAkRgCsfNJThy3gAkRgCvRPUQvwsgAkRgCxzSDONt9gAkRgCz3VLMJq1gAkRgC1TYZKtnngAkRgC2JbYJ3kogAkRgC2hd5JfiHgAkRgC2nfsJZgUgA
					kRgC2ngmJZfagAkMf92nfkJZgcgAkEf42kedJchjgAkBf22me1JahLgAkBf22nfrJZgVgAkBf22ngAJZgA]],
				["UpperArm.L"] = [[
					fGjxe10WRNgAzvfGjoe00jRNf3zjfGjWez0+RNfizGfGjGez1UROfRytfGjJez1QROfTyxfGjze22rQFaQu7fGkRe93aSHRJn0fGkWe/3OTRPMmPfGkWe/3O
					TRPMmPfGkWe/3OTRPMmPfGkWe/3OTRPMmPfGkWe/3OTRPMmPfGkWe/3OTRPMmPfGkWe/3OTRPMmPfGkWe/3OTRPMmPfGkWe/3OTRPMmPfGkWe/3OTRPMmPfG
					kVe/3RTEPgmgfGkIe63XQhVUrIfGj3e21gQadfxqfGjxe10WRNgAzvfGjxe10WRNgAzvfGjxe10WRNgAzv]],
				["LowerArm.L"] = [[
					eojHeogA/+gAhEeoi/engB/+gUhEeoitekgC/9hBhEeoieeigD/7hlhEeoiheigE/8hghEegjZebjl+QpwgjeXkUemov101nd/eWkderpvzG3kdHeWkderpv
					zG3kdHeWkderpvzG3kdHeWkderpvzG3kdHeWkderpvzG3kdHeWkderpvzG3kdHeWkderpvzG3kdHeWkderpvzG3kdHeWkderpvzG3kdHeWkderpvzG3kdHeW
					kceqplzk3RdRebj/eemh6hwqfcekjUeihs/nkdg+eojHeogA/+gAhEeojHeogA/+gAhEeojHeogA/+gAhE]],
				["UpperArm.R"] = [[
					g6jxe10WuzgAzvg6joe00juzgJzjg6jWez0+uzgezGg6jGez1Uuygvytg6jJez1Quygtyxg6jze22rv7lwu7g6kRe93at5u3n0g6kWe/3Osvw0mPg6kWe/3O
					svw0mPg6kWe/3Osvw0mPg6kWe/3Osvw0mPg6kWe/3Osvw0mPg6kWe/3Osvw0mPg6kWe/3Osvw0mPg6kWe/3Osvw0mPg6kWe/3Osvw0mPg6kWe/3Osvw0mPg6
					kVe/3Rs8wgmgg6kIe63XvfqsrIg6j3e21gvmihxqg6jxe10WuzgAzvg6jxe10WuzgAzvg6jxe10WuzgAzv]],
				["LowerArm.R"] = [[
					hYjHeogAACgAhEhYi/engBACfshEhYitekgCADe/hEhYieeigDAFebhEhYiheigEAEeghEhgjZebjlBwWQgjhpkUemovKMKZd/hqkderpvM6IcdHhqkderpv
					M6IcdHhqkderpvM6IcdHhqkderpvM6IcdHhqkderpvM6IcdHhqkderpvM6IcdHhqkderpvM6IcdHhqkderpvM6IcdHhqkderpvM6IcdHhqkderpvM6IcdHhq
					kceqplMcIvdRhlj/eemhFfPWfchcjUeihsAZbjg+hYjHeogAACgAhEhYjHeogAACgAhEhYjHeogAACgAhE]],
				Tail1 = [[
					gAjbhUecgAgA/9gAjYhUeVgAgA/8gAjShUeGgAgA/7gAjNhTd6gAgA/7gAjNhTd8gAgA/7gAjXhUeZfxf//8gAjbhUesfaf+/9gAjchUeuhPgF/8gAjchUeu
					fpf//9gAjchUeufDf9/8gAjchUeuhJgE/8gAjchUeugAgA/9gAjchUeue3f8/8gAjchUeug9gD/8gAjchUeugXgB/9gAjchUeuexf7/8gAjchUeugrgD/9gA
					jchUeugrgC/9gAjbhUenfOf9/8gAjbhUefgEgA/9gAjbhUecgAgA/9gAjbhUecgAgA/9gAjbhUecgAgA/9]],
				Tail2 = [[
					gAjjiseRgAgA/8gAjhireegAgA/9gAjcire8gAgA/+gAjYirfUgAgA//gAjZirfQgAgA/+f/jgisdyf7f//6f9jjiscUeUf8/ugHjjircDh0gL/sf+jjiscD
					gbf8/vf7jjiscDd2f5/rgGjjiscDhYgK/tgAjjiscDhBf//uf6jjiscDdyf3/qgFjjiscDg1gJ/vgCjjiscDhigC/tf5jjircDd5f2/rgEjjiscDgOgH/vgE
					jjiscGh5gF/sf8jjisc3e2f6/0gAjjisd6f8gA/7gAjjiseRgAgA/8gAjjiseRgAgA/8gAjjiseRgAgA/8]],
				Tail3 = [[
					gAjtkDe7gAgA/+gAjpkDfcgAgA//gAjikDgngAgA//gAjckDhkgAgA/9gAjdkDhZgAgA/9f+jskDeAgVgA/7f0j3kBaydof7/egRj4kAaOhQgV/cgAj4kBaO
					hrf0/afvj4kAaOdXf0/WgOj4kBaOgigV/dgGj4kBaOiNf6/Yfuj4kAaOdpfw/YgKj4kBaOfwgU/dgKj4kBaOikgA/Xfuj4kAaOeIfs/agFj4kBaOfAgQ/cgO
					j4kAaUiqgG/Xf1j0kCb8fNf3/ugAjvkDeLfvgA/8gAjtkDe7gAgA/+gAjtkDe7gAgA/+gAjtkDe7gAgA/+]],
				Tail4 = [[
					gAjzlbftgAgA//gAjslbgigAgA//gAjflbiagAgA/5gAjTlaj7gAgA/wgAjVlajqgAgA/ygAj3laeWgqf//8fnkTlTZZd6fw/OgXkYlSYjgCgr/GgKkXlTYi
					iXfw/BfhkYlRYieBfi/CgQkYlTYjfSgo/GgSkXlSYiilf8/AfhkYlRYjekfb/EgIkYlTYjengj/EgYkXlSYiimgI+/fkkYlSYjfPfW/Gf/kXlTYieDga/Cgc
					kXlSYriWgT/DfxkKlXbKf/fv/nf/j5laekfogA/9gAjzlbftgAgA//gAjzlbftgAgA//gAjzlbftgAgA//]],
				Hourglass = [[
					gAj0mzgAgAgA//gAjqmzg1gAgA/+gAjRmyitgAgA/4gAi+mwkOgAgA/tgAjBmwj9gAgA/vgEkAmyepgKgA/9fck3mjZrcngC/LgWk/mhY0iugD/DgWk/mgY0
					hmf6/IfXlAmfY0b9gC+6gMk/mhY0hxgE/Hgfk/mgY0ilf7/EfalAmfY0cGgA+7gAk/mhY0grgF/Kgmk/mfY0jWf8+/fhlAmgY0cjf+++f0k/mhY0fhgG/Kgo
					k+mgY9jyf9++fxklmrbceQf//nf8kAmye3fwgA/+gAj0mzgAgAgA//gAj0mzgAgAgA//gAj0mzgAgAgA//]],
				Gear2 = [[
					gAkmiYgAJZgA2ngAkkiXgJJZf32ngAkfiWghJZff2ngAkbiUhAJafA2mgAkbiVhZJben2lf/kjiYiBJUeB2Xf9kmiZj2JScS14gFkmiZmaLQZH2cf/kmiZqk
					LuVqz1f8kmiZvEOQRywtgFkmiZx1TeM3tfgAkmiZ1SYXKunpf7kmiZ3WeNKRhpgEkmiZ1mj4JFb6gBkmiZ0movK9XFf7kmiZzns6N4UCgDkmiZwvueOhQ6gD
					kmiZvtvnPoPvf9kmiZwPwiQkQQgAkmiYvNwsQvPQgAkmiYuHxsR5OUgAkmiYtBygS/NggAkmiYsky0TcNM]],
				Gear3 = [[
					gAkSjYgAJZgA2ngAkQjXgOJZfy2ngAkMjWgyJZfO2ngAkJjVhdJcej2kgAkJjVh+JeeC2if+kPjYitJZdW2Tf7kRjYlDJibI1qgKkRjYoYL9W/1rf9kRjZtn
					NoSsx+f4kRjYyvSMOVtAgJkRjY02ZpJom3gAkRjZ2lhYJbeof3kRjY1ZphMGXIgIkRjYv8vFPEQCgDkRjZrBzeUvMHf2kRjYmW2naKLFgGkRjYiN2BdsJCgF
					kRjYgJ2Jf1I7f6kSjYfw3KgQJ9gAkSjYen2ihZJZgAkSjYco2XjYJpgAkSjYa22BlKJ/gAkSjYaJ12l3KK]],
				Gear1 = [[
					gAk1hBgAJZgA2ngAkyg/fiJZge2ngAkrg5ecJchk2kgAkkg1dbJiil2egAklg1dOJkiy2cgAkzhEeqJbhW2lgAk4hPe2JahK2mgAk4hRcwJojQ2YgAk4hRZi
					KVme1rgAk4hRVyL1qO0LgAk4hRR7OTuFxtgAk4hROeRtxiuTgAk4hRL1Vx0LqPgAk4hRKMaD10l9gAk4hRJeeB2ih/gAk4hRJbhU2lesgAk4hRJrjp2VcXgA
					k4hRJ7k72FbFgAk4hLKKl312aJgAk2hEKqne1WYigAk1hBLNo50zXHgAk1hBLqp40WWIgAk1hBL2qR0KVv]],
				["UpperLeg.L"] = [[
					e1iVgV7EdbgAw2e1iRgX7udRf3vue1iHgb86c8fmtVe1h/ge9scsfYrbe1iBge9kcvfarxe1iTgU7Hdaf+wxe1iggL4DeEgf0/e1iigK3ZeMgl1ve1iigK3Z
					eMgl1ve1iigK3ZeMgl1ve1iigK3ZeMgl1ve1iigK3ZeMgl1ve1iigK3ZeMgl1ve1iigK3ZeMgl1ve1iigK3ZeMgl1ve1iigK3ZeMgl1ve1iigK3ZeMgl1ve1
					iigK3geLgk1ne1idgO5Id2gVzre1iXgT6qdhgFxge1iVgV7EdbgAw2e1iVgV7EdbgAw2e1iVgV7EdbgAw2]],
				["LowerLeg.L"] = [[
					ewhgf7uMgrgA8qevhef5tggwgE8/evhbf0sSg4gK9heuhYfyrlg9gP9zeuhZfzrsg8gO9xewhff5tqgsgA87exhmgDwTgXfy7heyhngGw3gTfv7LeyhngGw3
					gTfv7LeyhngGw3gTfv7LeyhngGw3gTfv7LeyhngGw3gTfv7LeyhngGw3gTfv7LeyhngGw3gTfv7LeyhngGw3gTfv7LeyhngGw3gTfv7LeyhngGw3gTfv7Ley
					hngFwxgUfw7PexhkgAvdgef38Aewhhf8uagpf+8jewhgf7uMgrgA8qewhgf7uMgrgA8qewhgf7uMgrgA8q]],
				["Foot.L"] = [[
					eygsgj8wgAgAuBeygsgj8wgFf+uBeygsgj8wgOf5uBeygsgj8wgTf3uBeygsgj8wgSf3uBeygsgj8wgBf/uBeygsgj8wfrgKuBeygsgj8wfngMuBeygsgj8w
					fngMuBeygsgj8wfngMuBeygsgj8wfngMuBeygsgj8wfngMuBeygsgj8wfngMuBeygsgj8wfngMuBeygsgj8wfngMuBeygsgj8wfngMuBeygsgj8wfngMuBey
					gsgj8wfogMuBeygsgj8wfygHuBeygsgj8wf9gBuBeygsgj8wgAgAuBeygsgj8wgAgAuBeygsgj8wgAgAuB]],
				["Toe.L"] = [[
					eygPgN/7gAgAiGeygPgN/7gEf8iGeygPgN/7gKf1iGeygPgN/7gOfwiGeygPgN/7gNfxiGeygPgN/7gBf/iGeygPgN/6fxgRiGeygPgN/6fugViGeygPgN/6
					fugViGeygPgN/6fugViGeygPgN/6fugViGeygPgN/6fugViGeygPgN/6fugViGeygPgN/6fugViGeygPgN/6fugViGeygPgN/6fugViGeygPgN/6fugViGey
					gPgN/6fugUiGeygPgN/7f2gLiGeygPgN/7f+gCiGeygPgN/7gAgAiGeygPgN/7gAgAiGeygPgN/7gAgAiG]],
				["UpperLeg.R"] = [[
					hLiVgV7EilgAw2hLiRgX7uivgJvuhLiHgb86jEgatVhLh/ge9sjUgorbhLiBge9kjRgmrxhLiTgU7HimgCwxhLiggL4Dh8fh0/hLiigK3Zh0fb1vhLiigK3Z
					h0fb1vhLiigK3Zh0fb1vhLiigK3Zh0fb1vhLiigK3Zh0fb1vhLiigK3Zh0fb1vhLiigK3Zh0fb1vhLiigK3Zh0fb1vhLiigK3Zh0fb1vhLiigK3Zh0fb1vhL
					iigK3gh1fc1nhLidgO5IiKfrzrhLiXgT6qiff7xghLiVgV7EilgAw2hLiVgV7EilgAw2hLiVgV7EilgAw2]],
				["LowerLeg.R"] = [[
					hQhgf7uMfVgA8qhRhef5tgfQf88/hRhbf0sSfIf29hhShYfyrlfDfx9zhShZfzrsfEfy9xhQhff5tqfUgA87hPhmgDwTfpgO7hhOhngGw3ftgR7LhOhngGw3
					ftgR7LhOhngGw3ftgR7LhOhngGw3ftgR7LhOhngGw3ftgR7LhOhngGw3ftgR7LhOhngGw3ftgR7LhOhngGw3ftgR7LhOhngGw3ftgR7LhOhngGw3ftgR7LhO
					hngFwxfsgQ7PhPhkgAvdfigJ8AhQhhf8uafXgC8jhQhgf7uMfVgA8qhQhgf7uMfVgA8qhQhgf7uMfVgA8q]],
				["Foot.R"] = [[
					hOgsgj8wgAgAuBhOgsgj8wf7gCuBhOgsgj8wfygHuBhOgsgj8wftgJuBhOgsgj8wfugJuBhOgsgj8wf/gBuBhOgsgj8wgVf2uBhOgsgj8wgZf0uBhOgsgj8w
					gZf0uBhOgsgj8wgZf0uBhOgsgj8wgZf0uBhOgsgj8wgZf0uBhOgsgj8wgZf0uBhOgsgj8wgZf0uBhOgsgj8wgZf0uBhOgsgj8wgZf0uBhOgsgj8wgZf0uBhO
					gsgj8wgYf0uBhOgsgj8wgOf5uBhOgsgj8wgDf/uBhOgsgj8wgAgAuBhOgsgj8wgAgAuBhOgsgj8wgAgAuB]],
				["Toe.R"] = [[
					hOgPgN/7gAgAiGhOgPgN/7f8gEiGhOgPgN/7f2gLiGhOgPgN/7fygQiGhOgPgN/7fzgPiGhOgPgN/7f/gBiGhOgPgN/6gPfviGhOgPgN/6gSfriGhOgPgN/6
					gSfriGhOgPgN/6gSfriGhOgPgN/6gSfriGhOgPgN/6gSfriGhOgPgN/6gSfriGhOgPgN/6gSfriGhOgPgN/6gSfriGhOgPgN/6gSfriGhOgPgN/6gSfriGhO
					gPgN/6gSfsiGhOgPgN/7gKf1iGhOgPgN/7gCf+iGhOgPgN/7gAgAiGhOgPgN/7gAgAiGhOgPgN/7gAgAiG]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAjXguAEgAgAh2gAjUguAEgDgrhogAi8guAEgLhlgLgAj1guAKgDhmiogAklguATf/g/kJgAk1guAXgAgAkogAklguATgBfBkJgAj1guAKf9eaiogAi8guAE
					f1ebgLgAjHguADf6fBg1gAjEguABgAgAgpgAkMguAOgBg/jZgAkvguAXf+hmkcgAkzguAYf9hmkjgAkWguAQgAg/jsgAjWguADgAgAhZgAjEguACf6fBgpgA
					jXguAHf6eah0gAjXguAGf8e0h2gAjXguAEf/fwh2gAjXguAEgAgAh2]],
				Spine1 = [[
					gAjbgTAjgAgAl0f/jXgTAggIgrlff9i8gTAPgVhkjVf9j6gUAygRhlmwf+ksgUBPgIg+ougAk9gUBagAgApWgCksgUBPf4fCougDj6gUAyfvebmwgDi8gTAP
					frecjUgCjIgTAVf0fCkTgAjFgTARgAgAkBf+kSgUA/gJg+nyf9k3gUBYgNhlpGf9k6gUBbgNhlpOf+kcgUBFgJg+oJgAjYgTAbgAgAlEgCjFgTASfzfCkBgD
					jagUAlfteclxgCjbgUAkfye1l0gAjbgTAjf9fxl0gAjbgTAjgAgAl0]],
				Spine2 = [[
					gAjufhBcgAgApdf9jpfgBVgNgqpCf4jHfeAqgehhmNf4kQfiB2gdhiqif7lIfmCwgRg9s5gAlcfnDEgAgAtngFlIfmCwfvfDs5gIkQfiB2fjeeqigIjHfeAq
					fiefmMgFjXffA7ftfEnfgAjSffA0gAgAnIf7ksfkCSgRg9ryf4lUfnC+gbhitVf4lYfnDCgbhitff7k3flCdgRg9sOgAjpfgBJgAgAobgFjSffA1ftfEnHgI
					jtfhBefiefpYgGjufhBefpe3pdgBjufhBcf7fxpdgAjufhBcgAgApd]],
				Neck1 = [[
					gAj+fJE9gAgAxFf8j5fIElgXglwdf2jSfECcgwhasHf2kifMGBg3hWymf6lefTIngkg01ygAlyfVJfgAgA2ugGlefTInfcfM1ygKkifMGBfJeqymgKjSfECb
					fQemsFgGjkfFDUfhfJuGgAjffFDCgAgAtjf6lAfPHVgjg00Vf2lqfUJMg7hT2Xf2lufVJYg7hT2jf6lLfQH0gjg006gAj4fHECgAgAvigGjffFDCfhfJtigK
					j+fJE8fKeqw+gIj+fJE+fXe/xEgCj+fJE9f4fzxFgAj+fJE9gAgAxF]],
				Neck2 = [[
					gAkzewHKgAgA0Kf7ksetGugbgizlfyj7ebEFg7hTvhf0lZe5IZhBhP1if5mYfOLWgqgv4agAmsfVMVgAgA5OgHmYfOLWfWfR4agMlZe5IZe/ex1igOj7eaEE
					fGetvfgIkSeiFLfafNxZgAkLefE1gAgAw4f5l5fEJ5gpgw3Gf1mlfTL/hEhM46f1mpfVMMhEhM5Ef5mFfIKdgpgw3ngAkpeoGEgAgAyugIkMefE2fbfNw3gN
					kyewHIfAex0DgJkzewHMfQfF0JgCkzewHKf2f00KgAkzewHKgAgA0K]],
				Head = [[
					gAljemAEgAgAhqf6lbegAKeeguigfwkleBAVcbiKehfzmKe1AychhSl2f5nIfWBnd7ggpwgAnbfhB8gAgAq7gHnIfWBniFfgpwgNmKe1Ayjfeul2gQkkeBAV
					jld2efgJk+eOAIiNe0gkgAk3eKABgAgAf3f5mpfGBFd4gpn4f1nUfeCBcqguqlf1nYfgCGcrgsq1f5m1fMBSd5gmongAlXeZAFgAgAiGgKk3eKAHiNeyf8gO
					liemAfjhefj8gKljemAViqe0jbgCljemAGgkfviOgAljemAEgAgAhq]],
				Jaw = [[
					gAljdj//gAgAgqf3lfde/dhqfsljfpkXdA9ckFfJrzftmad1/bjuf7ktf1noed/6iJgNgwgAoBeq//gAgAfigLnoed/6d3fzgwgTmad1/bcSgFktgXkWdA9b
					b6g4r0gNk5dM+TdigZp7gAkwdI+LgAgAqnf1nDeJ/ziOgGisfvn4em/zjZgbf1fvn8ep/zjYgcflf1nReQ/2iMgJh8gAlZdW+2gAgAofgOkwdI+HdhgcqhgU
					lqdk/EcMgSmngPlqdk/cdIgclHgDlldj/6fagMiLgAljdj//gAgAgp]],
				ClockMin = [[
					gAkBf2gAJZgA2nf+j8f1mjK3ZK2Ef6jefvqoNWUD0ef6khf5x2UEMXtSf9lWf/1gbxJMktgAlogB2ZjJJnc3gDlWf/1OpmMHWzgGkhf5ytulPJSugGjefvvy
					xsRiQJgEjsfyok1rX4LqgAjofxht2jeTJdf9k7f8Xl0Po1Kcf7lhgARGvdwLOrf7llgBM/qA0yUof9lFf9Knkw2tazgAj9f0JZgw2nfQgEjofxJYac1TlIgG
					kAf2MzSGxZslgEkBf2SONCsyxmgBkBf2Y9KVm81WgAkBf2gAJZgA2n]],
				ClockHour = [[
					gAkBf2gAJZgA2nf+j8f1gRJ4ft3Gf6jefvexKkhI3sf6khf5igKsdW3kf9lWf/k4KobB2wgAlogBmDKNZ91zgDlWf/mKJiaB1FgGkhf5lHI2bS08gGjefvil
					Icd51XgEjsfykCJDcT1mgAjofxkMJyb02Of9k7f8n5LkXv1yf7lhgApaMsV+1ef7llgBqBNAVU1Kf9lFf9pxMZVx07gAj9f0n9K1YD1LgEjofxn5KFYr0qgG
					kAf2qLKlWzzZgEkBf2qpLHWIzZgBkBf2q4L+VTzugAkBf2rUMaUszm]],
				["UpperArm.L"] = [[
					fGjxe10WRNgAzwfBjqe31XPfXsvAe6jBe51fQqSPrse7kVe93yV2NcjCe/lUe/3pToPimVfGlqe+2gQjS+qZfOlVe44fTEQ9lbfTkWex5eVeP4h7fTjAeu25
					PzUkqRfOjTew0QN1XAuMfGjOez2iQlS7qVe/k1e94OWgNeh0e7lhfD3dUEO7mPe7lmfE17ROSCrWe/lBe+3gTRP1m4fGjoe04bUePZkMfOjOew29QVTpp5fT
					jwew1UONWVsmfQjxex3kP/WPqxfIjxe02AQIclwmfGjxe10WRNgAzv]],
				["LowerArm.L"] = [[
					eojHeogA/+gAhEeVjYegmd8qspf/eKi9emou8Ir6cPeKkhetlY6xu1YZePlaernt43x8bEeYlnemoz3izyfSehlceem05DyacvemkieYkB7XvVbKeni7eRnO
					8dsqe7ehjGeYoR7Bu5h4eYjLebn679tIdWePlCesk26QwDYueKlnexn54fyKabeKlhewpk3ozOd/ePlFepnz5RxXbOeYjyedlI8FtLaHehjKeVnc8CtXeLem
					jmeVoA6Cwsh0emjneSlu9FsCfqeljRediH/0ieg4eojHeogA/+gAhE]],
				["UpperArm.R"] = [[
					g6jxe10WuzgAzwg0jqey4WvCqppkgtjAeu25wNrdqQgtkWex1zxZqVrzgylVe44fs8vDlbg6lqe+4yogyWf7hBlUe/3psYwemVhFkVe90wwBsYthhGjBe51e
					vXtwrthBjUe33wr7xAlRg6jOez2ivbtFqVgyk1e22HwqrarPgtlje440s3uzkwgtlne45loyxFfcgylCe34WtTuwl+g6joe00YxeqLuHhBjOe32FvJtzqxhF
					jwe73rq1yLj9hDjxe52xvLrfr8g8jxe21fvtjVxbg6jxe10WuzgAzv]],
				["LowerArm.R"] = [[
					hYjHeogAACgAhEhejjeSkvBjXneQhZi7eRnNDjTVe7hakOeWoCGnOWhghflceem0G9Nmcvhol6eskCGnOMZUhxlaerntHJOEbEh2kNerpnGjPOe4h2i9emou
					D4UHcQhxjcejlvDvT2ZahojLebn6EDS4dWhfkveboWHUNdgphalrecmeHNNEdKhal4eijZGSODavhflHecm5GjOKc6hojdeeozFbQkgzhxjLehoXELTHchh2
					j6eqloEsSNYlhwjnehmmDCUcdghfjPehiVAoaTgshYjHeogAACgAhE]],
				Tail1 = [[
					gAjbhUecgAgA/9gCjYhUedkagK/pgEjDhTefn4fk++gEj3hUeQjpgY/vgCkjhUd/dHfZ/ygAkyhUd7Zjea/Of+kjhUeAbNfA/jf8j3hUePgegD/8f8jDhTed
					kwfv/mf+jMhUedkbf8/pgAjKhUecgAgA/9gCkMhUeJbpfU/ogEkshUd8bXe7/kgEkwhUd5fif5/6gCkUhUeGk1g3/jgAjahUeampgJ/Qf+jKhUeci9f7/0f8
					jahUedcWf1/vf9jbhUeeaEft/Zf/jbhUeceaf7/6gAjbhUecgAgA/9]],
				Tail2 = [[
					gAjjiseRgAgA/8gajgioeglsgN/cgujKiggHtwfO83gXkAipdLpCg7+jfzkuiqbGdZfK/ffek/ikajUvdB9SfkkuinbNVJdz9of/kAirdHeOf5/zgWjLingA
					obfh+3gWjViofZq6f++EgAjSirfekGgE/ufrkWiocIZ3e2/Ifrk4inaxVddp9pgBk7iralaGfF+9gckginbwkjhM/WgkjjikeurtgT9vgOjSiqfipQf8+nfo
					jjipeTenf8/6fdjjileVXVfi+vf3jjireRcvf1/xgAjjiseRgAgA/8]],
				Tail3 = [[
					gAjtkDe7gAgA/+g4joj6fXkAgA/uhyjIjYiWw0eX7EhGkRjyc/vMhK7+fllJj9ZKhufF/MeolgjhYFTgcF8FeulLjnZWPtdE6jf1kQkBc3Yofu++hDjKjziQ
					n9e5+4hOjYjrhEvlfl77gWjVkAhVqZgD+OfLksj3a/cVer/We3lXjoYgSXc07xfjlZj4YTTzei8hg0k3j5aWgPhT/dhgjqjkfvtQf+9Hg/jUjzhau+fn8Ofh
					jskAe/kQgK/sevjtjwe9Xofu+2fljtkBe8bdf2/pgAjtkDe7gAgA/+]],
				Tail4 = [[
					gAjzlbftgAgA//hOjslQgVgCf0//jAi4j+kYwGdC7IiPkikhc2zZhF5OfwltlMXqoMep9vdxmPkTWDWTaz8VdnlxkKXsNIcb4LfOkhlOc0SWf38whti9k/kc
					jgeC/biZjRkaiqwyex7FhMjOlGjJv9ft7ie4lIlJaMiIeQ/Vd6mDkWWhTMbw7aepmCksWTPheL5kg0lWlLZWZthu+miijrkegxqxfb+GiHjNkkjMx2e36Vf4
					jylVf0qugH+JeDjzk8fta3f9/kfMjzlVftbGf9/ngAjzlbftgAgA//]],
				Hourglass = [[
					gAj0mzgAgAgA//hOjqmogogCf0//kJickmkowEc47Gjjkzk2c4zZhE5OgbmWmNQPoRg06kdKnIlKFDcuVftQcemgkZGeeOM4eteKkxmFDNf6SWdTh+ikmSAo
					iAjfkvjnjClAE9hZwxi6iYi+lwEfgdv9jafFlnmaBGhoiPYRdFm5lCLdpZWULjdjmylFaSu2YmFRgRl3mVihmBdeAzjajmlie9VPgrB6jXi7lEckOLhUFtgv
					jzmZf7VSf/B3dnj0mPgAlJgAAcexj0mpgAk6gAAZgAj0mzgAgAgAAB]],
				Gear2 = [[
					gAkmiYgAJZgA2ngUkjiVgMMufq5hgokOiOgNPneG7agSlDiViIMPdn48f4lwiVj8HvcM0GfrmBiRmWGAajwpftlxiTpWH+YWxUf+lDiXrRMyUbz0gSkOiUrq
					Q+PmzzgSkYiVuES0NExHgAkViXy0TcNMskfylZiU25UvOeoCf1l7iT4XX2NqlJgCl+iV2pcSKAjggTliiTy6f9GOhAgckmiRxWhqFVdHgLkViW0DkBH9a1ft
					kmiW4CnEM7aafkkmiT44o7PCZ6f5kmiX2Bo0MFYCgAkmiY05oqLHXW]],
				Gear3 = [[
					gAkSjYgAJZgA2ngmkPjSgRMufj5hhFj5jGgePodq7YghkwjUi1MUcu41fslejUldICa8z1fQlwjMo0GuY/wDfZlfjQsgJdWFwIgAkwjXuhPGRFxcglj6jRuv
					T+LkvngjkEjSxIXKJIrTgAkBjX12aJKKl3fglHjS5cd/Mvg/fhlpjQ5jisNLdEgAlsjV11nEK2ZCgnlQjRwcpWJIUFg2kSjMt1qmK7PagXkBjVuZuhO7OTfe
					kSjUvfztTtQYfNkSjOuq1/WARAfykSjXsM0WU+NmgAkSjYrUzmUsMa]],
				Gear1 = [[
					gAk1hBgAJZgA2ngBkyhAfoJ4gY3GgCkbg3d8KoiC3ogClShGevKlhh3rgBl/hOeZKJh73OgAmPhRcyJnjO2Zf/l/hOaGJelY1Qf+lShGWnKOoazwf+kbg3Sz
					MTsJxtf/kmg7RIOEuEw0gAkjg6PbQowlvYgBlohKPcRpxsvKgCmJhQOsTTzVttgCmMhRNZVS0vrfgBlxhMLsXx1qomgAk0g+J6bL2Gk1f/kjg6I3dW1yiaf+
					k1hBIYeA1Zh0f/k1hBIlfG1vg2gAk1hBJOfy2cgOgAk1hBJZgA2ngA]],
				["UpperLeg.L"] = [[
					e1iVgV7FdbgAw2e0iRgZ74dpfRvfezh4gk+ZdNdipPezi0ga69eheyxIezjmgR+wezgMoue1j4gK+ad2gXpse2jngI/DcngGm5e4i0gL5Kcuhhzae4h2gV9b
					b4g8r1e2iCgV8ucZgftne1h/ga9ZcxfcsMezjMgU40epfu0JezjxgS+ufdgGo4ezj0gS+sfegGo/ezjWgS36e3f51Oe1iSgX8bdEfsuYe2h/gW9BcUgbs9e4
					iUgO6UcihYxze3iVgQ6dcxhDxqe1iVgU69dSgOxAe1iVgV7EdbgAw2]],
				["LowerLeg.L"] = [[
					ewhgf7uMgrgA8qethff6t5hcf28yenhYfzroi4gI9qesh/gBviiIfW74ezjHfe+thqfao0e0jWfa+dgRfnpye0jPfS9te9f8r1e1h7f7uUfFgi8le1hOfqof
					fMgW+1eyhVfvqmf2gW+LeuhWfwq9g8gM+CeviTgHxNhQfV67eyjRfg+nicfQo8eyjUfg+kibfQpEewibgLyGhIfP6Wevhjf0sKg2gH9leyhUfuqIf3gV+We1
					hef4tSfHgi9Fezhff5tmfgga89exhgf6uEgcgF8uewhgf7uMgrgA8q]],
				["Foot.L"] = [[
					eygsgj8wgAgAuBeygsgj8wgpfsuAeygsgj8sh/fCt+eyhGgj8PhKfZu+eyikeml5rGGAtweyiweksAiXaO8/eyiheipzbTtA7IeyhGgj8Pesgsu+eygsgj8u
					exgnuAeygsgj8wfWgUuAeygsgj8wgSf3uBeyhWgj7/gafyvfeyiteppip2LO0FeyiwepqMpXMe1Oeyhegj74gSf2vseyg1gj8lgLf7uXeygsgj8wfXgUuAey
					gsgj8ueugouAeygsgj8vfCgeuAeygsgj8wfzgGuBeygsgj8wgAgAuB]],
				["Toe.L"] = [[
					eygPgN/7gAgAiGeygPgN/6gefeiGeygPgN/2heeXiFeygogP/zg2e/jLeyiJfAqqgcDvqgeyiWe+2FgAZx2SeyiKe+zVgkt01ZeygogP/zfDhJjLeygPgN/5
					fFhCiGeygPgN/6fhgjiGeygPgN/7gOfxiGeyg3gQ/xgSfpjveyiRfAwbhQJCu/eyiUfAxdhSKYvyeyg+gQ/vgNfwj+eygXgN/5gIf3ifeygPgN/6figiiGey
					gPgN/5fDhEiGeygPgN/5fSgziGeygPgN/7f2gLiGeygPgN/7gAgAiG]],
				["UpperLeg.R"] = [[
					hLiVgV7FilgAw2hKiRgT7SjFfgwahIh2gV9akIfEr3hIi0gL5KjSefzahKjngI/DjZf6m5hLj4gK+aiKfppshNjmgR+whNf0ouhNi0ga69hfhOxIhNh4gk+a
					iziepNhNiDge9bishdsKhLh/ga9ZjPgksMhKjNgK3Niget11hIjzgE+sj9fooFhIj3gD+Uj4fgpbhKjXgJ3Hifet17hLiSgX8bi8gUuYhNiAgf9sizhkrdhN
					iUgd7zhvhcvrhNiVgb7lh7hEwDhMiVgW7MicgOwrhLiVgV7EilgAw2]],
				["LowerLeg.R"] = [[
					hQhgf7uMfVgA8qhOhdf3tGf9fw9MhLhOfqohg0fq+0hLh7f7uUg7fe8lhMjPfS9thDgEr1hMjWfa+dfvgZpyhNjHfe+teWgmo0hUh/gBvid4gq74hZhYfzrn
					dIf49qhVhaf1sKeBgA9hhShWfwq9fEf0+ChMiSgHxEgify7DhLjWfQ9mh6gBr/hLjWfS99h8gCrEhMicgGxNgifz6+hRhjf0sKfKf59lhWhZfzrzd9f99qhV
					hif/u+dtgg8LhUhif+u1eIgZ8RhRhhf8uUfFgF8mhQhgf7uMfVgA8q]],
				["Foot.R"] = [[
					hOgsgj8wgAgAuBhOgsgj8wggfwuAhOgsgj8uhPfZuAhOhGgj8PhUfUu+hOiheipzktTA7IhOiweksAdply8/hOikeml5U66AtwhOhGgj8Pe2gnu+hOgsgj8s
					eBg+t+hOgsgj8ve1gluAhOgsgj8wfugJuBhOhWgj7+hCfcvehOioegoIm4Mg3BhOireglUpJF6vLhOhggi7qhCfawChOg1gj8lf1gFuXhOgsgj8vexgmuAhO
					gsgj8uergpuAhOgsgj8vfBgfuAhOgsgj8wfzgGuBhOgsgj8wgAgAuB]],
				["Toe.R"] = [[
					hOgPgN/7gAgAiGhOgPgN/6gYfliGhOgPgN/5g7e+iGhOgogP/zg9e3jLhOiKe+zVfcSM1ZhOiWe+2FgAmP2ShOiJfAqqfk8RqghOgogP/zfKhBjLhOgPgN/2
					eihpiFhOgPgN/5fIg+iGhOgPgN/7fygPiGhOg3gQ/wgvfFjvhOiRe9wOfALXyPhOiUe9qqemEZsChOhAgQ/qgvfEkYhOgXgN/5f4gJifhOgPgN/5fGhBiGhO
					gPgN/4fBhHiGhOgPgN/5fRg0iGhOgPgN/7f2gLiGhOgPgN/7gAgAiG]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAjXguAEgAgAh2gAjXhFAQgAgAj4gAjXhUAcgAgAlKgAjXhQAYgAgFk1gAjXhIATgAflkKgAjXhAARf/d/jbgAjXg7ANf9eTi8gAjXg5AJf/fri0gAjXg1AH
					gBgOiegAjdgwAJh6f7iBgAjmguAvmefoh0gAjgguCfsLfThtgAjDguFDxIfBhkgAiqguHH0Ae2hcgAimguHb0Ze0hbgAixguGezLe5hfgAi0guGSy7e6hfgA
					ioguHP0Ke1hcgAikguHj0ie0hbgAikguHj0ie0hbgAikguHj0ie0hbgAikguHj0ie0hbgAikguHj0ie0hb]],
				Spine1 = [[
					gAjbgTAjgAgAl0gAjegrA/gAgAnzgAjgg6BVgAgApEgAjgg2BPgAgFougBjeguBDf9floEgDjdgmA8fveAnWgDjcggA0fweUm4gBjcgfAvf9fsmxgAjcgbAr
					gDgOmbgAjggVAph4frl+gBjpgTBNmYe1lsgCjigTC7r/dylYgDjEgTFdw3c5k6gDiqgTHfztcXkigDimgTHz0FcSkegDiygTG2y4chkqgDi1gTGrypcjksgD
					ipgTHnz3cVkggDilgTH60OcRkdgDilgTH60OcRkdgDilgTH60OcRkdgDilgTH60OcRkdgDilgTH60OcRkd]],
				Spine2 = [[
					gAjufhBcgAgApdgAj4f7CHgAgArYgAj+gMCmgAgAslgAj8gICdgBgFsRgCj5f/CNf6flrpgKj2f2CBfgeDq8gIjzfvB1fjeXqegCjzftBwf6fsqYf/jxfpBp
					gFgNqDgDj0fjBjh4fmpngJj7fhCHmVejpWgQjwfhD4r6dOpFgUjNfhGcwtcCorgWiufhIhzfbToVgWiqfhI1z3bMoSgWi4fhH3ysbhocgWi6fhHsydbloegW
					isfhIpzpbQoUgWiofhI80AbKoRgWiofhI80AbKoRgWiofhI80AbKoRgWiofhI80AbKoRgWiofhI80AbKoR]],
				Neck1 = [[
					gAj+fJE9gAgAxFgAkLflHjgAgA0ogAkTf5JegAgA2tgAkRfzI8gDgE2LgDkNfqH9fxfp1GgNkIfgG/e6eTz1gLkFfZGVfFekzAgCkEfWGJf1fvy0f/kCfRFt
					gIgMyNgEkFfLFGhje5xMgPkKfJFIlRcRwGgaj8fJGMqAZOuhgijVfJH7uNW0sjgli0fJJZwtVjrHgmivfJJnxDVYq5gli+fJI7v+V6rjgkjBfJIzvxWArrgm
					iyfJJfw2VerBgmiufJJtxLVVq0gmiufJJtxLVVq0gmiufJJtxLVVq0gmiufJJtxLVVq0gmiufJJtxLVVq0]],
				Neck2 = [[
					gAkzewHKgAgA0KgAlEfcKKgAgA3YgAlNf5MUgAgA5Nf/lLfxLugDgE4vgDlGfiKnfufr3ygPlBfTJgeuec2pgNk9fIIwe7es16gCk8fEIjfzfw1vf+k5e9IC
					gJgK1LgLk5ezHUhReh0Pgkk5euHIkRbEzBg/kfesHwoKXBw+hQjpeqI5rqT2uVhWi9epJ4tySMsXhWi2epKCuFR+sEhUjKepJktKSps+hUjOeqJfs/SytJhW
					i6epJ8t6SGsPhWi0epKGuMR6r+hWi0epKGuMR6r+hWi0epKGuMR6r+hWi0epKGuMR6r+hWi0epKGuMR6r+]],
				Head = [[
					gAljemAEgAgAhqgAl1ffBNgAgAoqgAl8gFCwgAgAs9f/l7f7CSf7gDr1gDl3fnBggdfspngQlyfTA/iQeTnRgOltfFAmh8edljgDlsfBAbgYftlCf+lpe3AQ
					fwgOj1gRlpepAIh2fOhzg3lkeiAvmSdlfshhlAeeClrncJdLh6j7ebFPwAboabiDjFeZHSybbwYliDi9eZHmyvbzYUiBjVeaGqxvbrZIiAjaeaGexibqZSiD
					jCeZHbyjbxYeiEi6eZHuy2b0YPiEi6eZHuy2b0YPiEi6eZHuy2b0YPiEi6eZHuy2b0YPiEi6eZHuy2b0YP]],
				Jaw = [[
					gAljdj//gAgAgpgAmRej/9gAgAeogAmofT/4gAgAdUf/mjfG/6gGf+dqgFmXet/8ffgMeVgYmIeV/2dehOe7gVl9eF/5d2hOfcgEl6eA//fmgPfrf9lyd1//
					gRf0gCgUlpdn/5eFgmheg+lbdg++ZehnkUhmkqdg8cT5huoDh4jcdh40Pbgprfh4iidi2ANHfatfh4iZdi1kM0fMtwh5izdi24Nwf0s6h5i4dh3HN8f7swh4
					iedi10M/fUtmh3iWdi1bMufHt2h3iWdi1bMufHt2h3iWdi1bMufHt2h3iWdi1bMufHt2h3iWdi1bMufHt2]],
				ClockMin = [[
					gAkBf2gAJZgA2ngAkIgSoMK7X01FgAkMgluaOkRmxcgAkLggyISjN0tigCkJgX0yWWLupUgHkGgN3NZ4LflJgGkFgG3sd3KshxgBkEgD2zhkJredf/kDf/2B
					kaJrbigFkHf410ldKwX6gRkMf211kaNJS6gej8f211iMRNOCgmjTf21pf+V9Ktgpiwf21ae4ZrJIgpirf21afkbJIwgoi7f21dhaa5I4goi+f21aiObVIzgp
					iuf21Yhmc8Idgpipf21WhkdmIXgpipf21VhvdyIVgpipf21Vh1d5IVgpipf21Vh3d7IVgpipf21Uh3d7IV]],
				ClockHour = [[
					gAkBf2gAJZgA2ngAkIgShcJbek2lgAkMgliXJgdp2ggAkLggiHJid52lgCkJgXhnJJeW2QgHkGgNhDICe01HgGkFgGgvIOfM1YgBkEgDgrJLfU2Yf/kDf/gc
					Jjfk2xgFkHf4eyJjei2sgRkMf2bfKMbW2fgej8f2XpLuXI1hgmjTf2UaNvTYz5gpiwf2SlPSRJyggpirf2SVPhQ1ySgoi7f2TGO0Ryy8goi+f2TQOrR+zEgp
					iuf2SePZRAyagpipf2SQPnQuyNgpipf2SQPnQuyNgpipf2SQPnQuyNgpipf2SQPnQuyNgpipf2SQPnQuyN]],
				["UpperArm.L"] = [[
					fGjxe10WRNgAzvfGkAfQ3zRfdIvafGkJfi5jR9bVsTfGkHfd5IR3bvtLfKkCfS4PRVdBujfWj9fD3IQOfHvdfUj5e+2UQTfkwsfJj4fA2HRFe1xnfFj1e+1f
					RXe+ymfJj+e4zcQXfD0AfUkVe3v9O3dR1ofnkce4r2N/aA22f9kFe6oROLWa3WgLjre7mPOvT73PgNjne7l9O2Tj3NgHj0e7m0OiUq3UgGj2e6m+OfU43UgM
					jqe7mHOyTx3OgOjme7l3O4Tb3MgOjme7l3O4Tb3MgOjme7l3O4Tb3MgOjme7l3O4Tb3MgOjme7l3O4Tb3M]],
				["LowerArm.L"] = [[
					eojHeogA/+gAhEeojee0gN/XmOhDeojwe/gW+VqHhBeojre8gU+qpGg8esjie0gN/KnFhee7jaengD/ek2jEe4jUemgD/sjXiwerjSesgG/0i/hZemjOetgF
					/7h6g2enjYeshj/8gJg5epj2ezlP/ieygKe1kLe9p6+VeKetfKkDfHuG8geNdAfajyfNwn6+emb2fdjvfOw+6verbrfVj4fLv47dedcMfUj5fLvr7mebcSfb
					jxfNwx64eobxfdjufOxF6qetbnfdjufOxF6qetbnfdjufOxF6qetbnfdjufOxF6qetbnfdjufOxF6qetbn]],
				["UpperArm.R"] = [[
					g6jxe10WuzgAzvg6kAfQ3zuhi4vag6kJfi5juDkrsTg5kHfd5IuPkKtHg9kCfV4NuMjku9hJj8fS3BtbjmxVhGj4fK2QtsiryQg8j4fD2Gujhmx6g4j1e81g
					u6gvyZg8jwe21LtdeWzyg+jnez1hqEZc0Zg5jLex1blxTfzWguidew0ZiFOUxCgkh7evzVgALZu+gih2evzKfvK/upgniFevzrgmMOvogoiIewzxgxMev0gj
					h5evzRf5LOu1gih1evzGfpK3uigih1evzGfpK3uigih1evzGfpK3uigih1evzGfpK3uigih1evzGfpK3ui]],
				["LowerArm.R"] = [[
					hYjHeogAACgAhEhYjee0gNApZyhDhYjwe/gWBrV5hBhXjre8gTBXW6hGhcjie5gRA0Y8gnhpjYe9gRAabKfChmjSe4gLANcpfXhbjRevgHAKdBgvhWjOeqgD
					AGeGhShUjDeqdwAIfvhOhEizeuYVBAg5hmgpiZezRyDehoiKgMh2e5MbG+iRixf7hde9JgJqiqjNf5hae+JHKEiujRgAhle8KVI1ijjEgBhne8KkImihjCf6
					hce+JVJ1isjPf4hZe+I/KNivjTf4hZe+I/KNivjTf4hZe+I/KNivjTf4hZe+I/KNivjTf4hZe+I/KNivjT]],
				Tail1 = [[
					gAjbhUecgAgA/9gAjWhrgegAgA//gAjTh5hxgAgA/8gAjUh1hbgJgB/9f/jVhugwfQf6/+f7jXhmgBcffq/yf8jYhgfidCfw/2f/jYhffafcf9/+gBjZhbfE
					gZgB/+gAjghWerf9eG/6gBjphUemfrZg/SgCjihUejfVTy9hgDjEhUeWfDO267gDiqhUeJe5L/42gDimhUeHe4Lm4igDiyhUeOe8Mz5ggDi1hUePe8ND5rgD
					iphUeIe4L04ugDilhUeGe3Ld4agDilhUeGe3Ld4agDilhUeGe3Ld4agDilhUeGe3Ld4agDilhUeGe3Ld4a]],
				Tail2 = [[
					gAjjiseRgAgA/8gAjTjDgTgAgA//gAjJjRhmgAgA/8gBjMjNhQgMgC/9f7jRjGgle8f3/+fojXi7f2a/ff/lfsjbi3fXbyfo/sf8jci3fPfMf8/+gDjeize5
					gjgC/9gBjniuekfzeF/5gBjxiseifEZe/RgCjriseYeJTw9cgDjPird4dWO36ygFi2irdZc6MC4qgFiyirdTc3Lq4VgEi+irdjdCM25VgEjAirdldENF5hgF
					i0irdWc5L44hgFixirdSc2Li4OgFixirdSc2Li4OgFixirdSc2Li4OgFixirdSc2Li4OgFixirdSc2Li4O]],
				Tail3 = [[
					gAjtkDe7gAgA/+gAjSkbg9gAgA/+gAjAkoiQgAgA/6gCjFklh6gQgC/7f1jOkehPenf3/8fNjYkPggZffd/UfVjekMgBahfo/gf4jgkPf5e9f8/+gGjkkLfj
					gugC/+gAjvkFfSfleF/7f+j6kDfTeSZf/Qf8j3kDe+coT09Xf9jhkBeGbNPB6ngBjMkAdRacMU4cgBjJkAdJaWL94Gf/jSkBdiaqNF5Hf/jUkBdnauNU5TgB
					jKkAdOaZMK4TgBjHkAdGaTL13+gBjHkAdGaTL13+gBjHkAdGaTL13+gBjHkAdGaTL13+gBjHkAdGaTL13+]],
				Tail4 = [[
					gAjzlbftgAgA//gAjMlzhvgAgA/8gAi0mAjCgAgA/2gDi6l8isgUgC/4ftjHl1iBeTf3/4eqjWlghQYAfi+8e3jflegyZQft/Qfyjglngretf9/9gKjnljgV
					g4gB/+f+jzldgIfXeG/7f1kAlbgLdeZi/OftkDlYfrbFT+9Oftj3lVebZCPX6XfyjqlSdQX7Mz4Hf0jolRdEXyMd3xfwjulTdoYPNh40fwjvlTdvYVNv5Afz
					jplSdLX3Mq3+f0jnlRdAXvMW3pf0jnlRdAXvMW3pf0jnlRdAXvMW3pf0jnlRdAXvMW3pf0jnlRdAXvMW3p]],
				Hourglass = [[
					gAj0mzgAgAgA//gAjDnKiCgAgA/7gAijnWjVgAgA/0gFisnTi/gjgD/2fki8nMiTc9fy/wd/jQmthbSFfU8weTjbmvhBULfm9sfrjdm+g+dtf8/5gOjlm6go
					hlgB/8f6jzm1f9fbeF/7fnkCmye4dvZc/NfVkPmsdGcKTm9FfSkSmka9bTOl57fakQmdZdbFLw3XfckQmcZPbFLY2+fXkRmgZ6bHMk4LfWkRmgaCbIMz4Zfb
					kQmdZXbFLm3NfdkPmcZKbFLQ21fdkPmcZKbFLQ21fdkPmcZKbFLQ21fdkPmcZKbFLQ21fdkPmcZKbFLQ21]],
				Gear2 = [[
					gAkmiYgAJZgA2ngAkYi4jZJpcn2XgAkPjLmJKPZ31xgBkRjGnmKzYY1Zf8kWi8o4KpXZ0WfskcivqiJXXLx8fvkfiornKSWJx5f9kginsIMcURy3gCkiiiss
					NnTBy2gJkqibslNGRYxJgdkviZq6LtOntxgzkaiaoQKEMNpDhCjqialhI3LEkWhIjDibj+IVK5hFhIi9ibkbIYK6gAhGjPibmOI4KzgchGjSibnCJJKxgFhI
					jAibmfI4K7eihJi7ibmlI4LBd1hJi7ibm6I+LEdihJi7ibnJJCLFdVhJi7ibnSJFLGdNhJi7ibnVJGLHdK]],
				Gear3 = [[
					gAkSjYgAJZgA2ngAj8j1kDJwb92QgAjukGnXKnYp1ZgBjykBpVLgWo0sf5j5j4rILuVQzTfekCjrtaK8U5wofkkHjluzMVThwKf7kIjmvWO2RKwigEkMjhwA
					QaPnv+gGkVjawSQLOGtqgSkdjYvQOuL7pcggkOjZtVMvKmj+gqjnjZrSLEKpe1gvjFjZqMKRLYbXgwjAjZq4KkLvaGgujQjZsqLrLlaRgtjSjZtiMRLtZwgw
					jDjZtPL9MYYLgwi/jZtdMEMvXbgwi/jZt1MVM6XDgwi/jZuGMhNCWzgwi/jZuQMoNHWpgwi/jZuTMrNIWm]],
				Gear1 = [[
					gAk1hBgAJZgA2ngAkyhkf3JZgJ2ngAkwh6fSJZgu2ngAkwh0doJkia2jf/kyhpbsJgkH18f+kzhcZiI5lc0cf+k0hUYFJlm+0OgAk0hSXTK4og0ugAk1hMWR
					Lwp30igLk6hET5M7px0bglk9hBQfPjnt1RhCkihBNOTakd2LhVjrhBLBXlhT2lhci+hBKCaoff2nhci3hBJ0blfw2nhajMhBJ8bDha2lhajQhBJ4bTiG2hhc
					i7hBJncyhZ2lhdi1hBJidchZ2lhdi1hBJgdthp2khdi1hBJfd4h12jhdi1hBJeeAh82ihdi1hBJeeCh+2i]],
				["UpperLeg.L"] = [[
					e1iVgV7EdbgAw2e1iZgk82dcfttle1icgu9ydefhrZe1ibgr9jdgfgr/e1iagk9EdOgBtFe5iZgX8bcXheuIe4iXgV8CcihSu9e1iXgb7+dQgIvSe0iWgb7q
					difuv4etikgX7Qb0e8wLehjHgV6uX2cvvPecjmgV5USyaTtOekjrgV3GOTYnrBevjlgV1QLqX2piexjjgV0+LTXwpUerjngV11MbYDp/eqjogV2AMpYHqHew
					jkgV1JLgXzpceyjjgV03LLXupPeyjjgV03LLXupPeyjjgV03LLXupPeyjjgV03LLXupPeyjjgV03LLXupP]],
				["LowerLeg.L"] = [[
					ewhgf7uMgrgA8qewhsf+xbgrgF60ewh1gBzYgqgI5cevhygBy3gvgF50exhuf9x2gSgS6ie3hqf0wse2g87Qe2hnf0v8fJgy7texhlf7vwgZgL71evhjf9vN
					g4f78Ieihyf6uXf3eS8ieIibf2tmd4aJ8Rd3jIfysmbiU663d6jdfvrTZoQT4qeEjgfsqVYkNm23eHjhfsqMYbNP2keBjgftqoY3OY3beAjgftquY9On3leF
					jhfsqSYgNc2veHjhfsqJYYNG2eeHjhfsqJYYNG2eeHjhfsqJYYNG2eeHjhfsqJYYNG2eeHjhfsqJYYNG2e]],
				["Foot.L"] = [[
					eygsgj8wgAgAuBeygvgZ+MgAgAqleyg1gT+5gAgAoTeygzgV+ugCf8o6ezgwgW+Wf0gZqFe1gvgS92fGh0rVe1gtgV9ifQhisLezgtgd9ff3gTsZeygsgh9P
					gGfzs+eeg9gi8+eSfLtcd2hrgg8kaGdWs2dViigd7TUwbUrYdOjGgb5MQAZ1pudWjUga3aNNZGomdYjVgZ3IM0ZAobdTjQga3+OBZTo8dSjPga4IOQZXpCdX
					jUga3TNCZEoidYjWgZ3CMrY+oYdYjWgZ3CMrY+oYdYjWgZ3CMrY+oYdYjWgZ3CMrY+oYdYjWgZ3CMrY+oY]],
				["Toe.L"] = [[
					eygPgN/7gAgAiGeygYf8/8gAgAeYeygifz/vgAgAb/eygff2/0gAf7coe0gaf4/6f+gbd3e5gWf2/6f2iBfMe3gTf8/8f4htgGezgSgD//f/gVgUeygRgJ/+
					gAfyg9ebghgK/5eGf4hfdrhSgI/TZhfyhGdDiQgE9kT0f7gNc4i7gA7AO3gVfec/jOf+47L/gufGdBjRf94mLmgyfDc8jJf+5kM0gmfNc7jIf/5wNDgkfPc/
					jPf+4yL0gwfFdBjSf94fLdg0fCdBjSf94fLdg0fCdBjSf94fLdg0fCdBjSf94fLdg0fCdBjSf94fLdg0fC]],
				["UpperLeg.R"] = [[
					hLiVgV7EilgAw2hLiZgk82ikgTtlhLicgu9yiigfrZhLibgr9jilgYr+hMiZgo9EiVgttJhOiXgq8bhfh8udhNiWgl8ChrhmvPhMiXge7+iagbvWhLiWgZ7q
					isf6v2hDiSgW7tg9fGv7griMgV8OcydNudgHh8gV8AXNbgr5fkhjgV6sSCaspYfPhSgV5SO5ajn0fNhQgV5DOdaknmfVhXgV5wP0akoRfXhYgV54QFaloafO
					hRgV5MOtajnufMhPgV4+OTaknhfMhPgV4+OTaknhfMhPgV4+OTaknhfMhPgV4+OTaknhfMhPgV4+OTaknh]],
				["LowerLeg.R"] = [[
					hQhgf7uMfVgA8qhQhsf+xbfVf760hQh1gBzYfWf45chQhygAy3faf250hShtgBx2e8gG6hhXhogIwsdhg17KhWhlgFv8dzgt7phRhlf+vwfCgH70hPhjf7vN
					fhf48JhChff5uMeheS8lgchefztCcnaJ8afshaftrjahU37HfEhOfop4Y8QL5AewhGflouYJNa3PethFfkojYDNC29e2hIfmpEYXON3ze3hJfmpKYbOc38ev
					hFflopYGNQ3HethEfkofYAM623ethEfkofYAM623ethEfkofYAM623ethEfkofYAM623ethEfkofYAM623]],
				["Foot.R"] = [[
					hOgsgj8wgAgAuBhOgvgZ+MgAgAqlhOg1gT+5gAgAoThOgzgU+ugCf8o6hOgwga+Wf0gZqFhQgtgl92fGh0rVhPgsgm9ifQhisLhOgsgg9ff3gTsZhNgsgf9P
					gGfzs+g5grgh9DeSfLtRgGgwge80aCdesRfIg5ga7uUkbwqTeZg9gX5tPravoSeDg+gV38MxaZm/eBg/gV3qMYaWm0eJg+gW4gNnaenYeLg+gW4qN3agnfeC
					g/gV30MnaYm6eAg/gV3kMPaWmweAg/gV3kMPaWmweAg/gV3kMPaWmweAg/gV3kMPaWmweAg/gV3kMPaWmw]],
				["Toe.R"] = [[
					hOgPgN/7gAgAiGhOgYf8/8gAgAeYhOgifz/vgAgAb/hNggf1/0gAf7cohPgaf8/6f+gbd3hTgUgK/6f2iBfMhSgSgM/8f4htgGhPgSgG//f/gVgUhNgRgG/+
					gAfyg9g2gQgJ/6eGf5hTf7gYgF/UZhf6gde3gof+9jT0gZfDeGg0f567O6hTd9dwg6f24zMFiFdbdug7f24eLtiNdXd2g4f35eM5h1dkd3g4f35pNIhxdndv
					g7f24qL7iIdZdtg8f24XLkiPdVdtg8f24XLkiPdVdtg8f24XLkiPdVdtg8f24XLkiPdVdtg8f24XLkiPdV]],
			},
		},
	},
}
