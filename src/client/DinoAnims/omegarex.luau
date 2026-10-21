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
					gAkjhAANgAgAjbgAkkhAANgAgGjbgAklhAANgAgLjbgAkmhAANgBgQjbgAkmhAANgBgVjbgAkmhAANgBgZjbgAkmhAANgBgdjbgAkmhAANgBggjbgAklhAAN
					gBgijbgAkkhAANgBgjjbgAkjhAANgBgkjbgAkihAANgBgjjbgAkhhAANgBgijbgAkghAANgBggjbgAkfhAANgBgdjbgAkfhAANgBgZjbgAkfhAANgBgVjbgA
					kghAANgBgQjbgAkhhAANgAgLjbgAkihAANgAgGjbgAkjhAANgAgAjbgAkkhAANgAf6jbgAklhAANgAf1jbgAkmhAANf/fwjbgAkmhAANf/frjbgAkkhAAQf/
					fnj2gCkchAAWgAfDkdf+khhAAWgAf1kif+kghAAWgAfzkigDkZhAAXgAe7kigAkbhAAWgAfckif9kehAAWgAf/kigCkXhAAWgAfJkigCkWhAAWgAfLkif9kb
					hAAWgAgFkigAkYhAAVgAfnkcgBkahAARf/faj/gAkfhAANgAfyjhgAkhhAANgAf1jbgAkihAANgAf6jb]],
				Spine1 = [[
					gAksgVA6gAgAnggAktgVA8gBgGnogAkugVA+gCgLnwf/kvgVA/gDgQn1f/kwgVBAgEgVn5f/kwgVBBgFgZn6f/kwgVBAgFgcn5f/kvgVBAgGgfn1f/kugVA+
					gGghnvf+ktgVA8gGgjnof+ksgVA6gGgjngf+krgVA4gGgjnYf/kqgVA3gFginRf/kpgVA1gFgfnLf/kpgVA1gEgdnHf/kpgVA0gEgZnGf/kpgVA0gDgVnHf/
					kpgVA1gDgQnLgAkqgVA3gCgLnRgAkrgVA4gBgGnYgAksgVA6gAgAnggAktgVA8f/f6nogAkugVA+f+f1nwgBkvgVA/f9fwn1gBkwgVBAf8frn5gBkugVBHf8
					fnoUgFkogWBTf3fEo5f/ktgWBSf+f1o6f/ksgWBQf+fzo1gGkmgWBPf3e7otgCkogWBMf7fdolf9kqgWBKgAf/odgEkkgWBJf5fJoWgEkjgWBHf6fMoQf9ko
					gWBFgBgFoNgBklgWBEf9fnoGgDklgVA9f7fanqgAkpgVA3f+fynRgAkqgVA3f+f1nRgAkrgVA4f/f6nY]],
				Spine2 = [[
					gAlVfGCHgAgAraf/lWfHCNgCgFrpf/lYfHCTgDgLr3f+lZfHCXgFgPsCf9lafHCagHgUsJf9lafHCbgIgYsLf8lafHCagJgbsJf8lZfHCYgKgesCf8lYfHCT
					gKggr3f8lWfHCOgLgirpf8lVfGCIgKgirZf8lTfGCCgKgirKf8lRfGB9gJghq8f8lQfGB5gJgfqxf8lPfFB2gIgcqqf9lPfFB1gHgYqnf9lPfFB2gGgUqqf+
					lQfFB4gEgQqxf/lRfGB8gDgLq8f/lTfGCCgCgFrKgAlVfGCHgAgAragBlWfHCNf+f7rpgBlYfHCTf9f1r3gClZfHCXf7fxsCgDlafHCaf5fssJgDlbfJCmf4
					foskgKlYfLC1fvfGtGgAlcfLCzf9f2tEgAlbfLCvf8f0s5gLlUfLCqfue9srgElWfKCif3fdscf+lXfKCcgAf/sNgIlQfKCXfzfLr+gIlPfJCSf0fNrzf9lU
					fJCPgBgFrtgDlQfJCMf6fnrlgGlOfHCCf3fbrLgClQfGB6f8fyq3gBlRfGB8f9f1q8gBlTfGCCf+f7rK]],
				Neck1 = [[
					gAlzekGygAgAzrf/l1elG2gDgFzwf+l3emG5gGgJzzf9l5enG7gJgNz2f9l6enG9gMgRz4f8l6enG9gOgVz5f8l6enG9gQgYz4f7l5enG7gSgaz2f7l3emG5
					gTgczzf6l1elG2gUgdzvf6lzekGygUgezrf6lwekGvgUgdznf7luejGsgTgczjf7lteiGpgSgbzgf7lseiGogQgYzef8lreiGngOgVzdf9lseiGogMgSzef9
					lteiGpgJgOzgf+luejGsgGgJzjf/lwekGvgDgFzngAlzekGygAgAzrgBl1elG2f9f7zwgCl3emG5f6f3zzgDl5enG7f3fzz2gDl6enG9f0fvz4gEl7epHOfy
					fr0OgMl6etHofffN0rgAl+etHof6f30ugAl9esHmf5f10rgNl1esHjfbfF0mgGl2eqHfftfi0jf+l3epHbf/f/0egKlwepHZfjfR0agKlueoHWfkfT0Xf9lz
					eoHUgDgE0WgEluenHQfzfq0QgHlselG+fsfgz6gCltejGtf4f0zkgCluejGsf6f3zjgBlwekGvf9f7zn]],
				Neck2 = [[
					gAm8eSK2gAgA3/f/m/eTK6gEgE4Cf+nBeUK9gIgI4Gf9nCeVLAgLgL4If8nEeWLCgPgP4Kf8nEeWLDgSgS4Kf7nEeWLCgUgU4Kf6nCeVLBgWgX4If6nBeUK+
					gYgY4Gf6m/eTK6gZgZ4Cf6m8eSK2gZgZ3/f6m6eRKygZgZ37f6m3eQKugYgY34f6m2ePKrgWgX31f7m1eOKpgUgV3zf7m0eOKogSgS3zf8m1eOKpgPgP3zf9
					m2ePKrgLgM31f+m4eQKugIgI34f/m6eRKxgEgE37gAm8eSK2gAgA3/gBm/eTK6f8f84CgCnBeUK9f4f44GgDnCeVLAf1f14IgEnEeWLCfxfx4KgEnGeaLXfu
					fu4cgNnEehL2fXfU40gAnJehL3f5f442gBnHegL0f3f240gPm/efLxfRfN4wgGnBedLsfofm4tf+nCecLof/f/4qgMm6ebLkfbfX4mgLm4eaLhfdfZ4jf8m9
					eZLfgDgE4igFm5eYLafvft4egIm1eULEfmfk4LgDm2eQKvf2f235gCm4eQKuf4f434gBm6eRKxf8f837]],
				Head = [[
					gAn7eaAYf6hVknf/n9ebAZf6heksf+oAedAaf7hkkxf9oBeeAbf7hok1f8oCefAcf8hqk3f8oDefAcf8hok4f7oCefAbf9hlk3f6oBeeAbf+hfk1f6oAedAa
					f/hWkxf6n9ecAZgAhMksf6n7eaAXgBg/knf6n5eYAWgCgxkhf6n3eXAVgCgikcf6n1eWAUgDgSkZf7n0eVAUgDgBkWf7nzeVAUgEfxkVf8n0eVAUgEfhkWf9
					n1eWAVgFfRkYf+n3eXAWgFfDkcf/n5eYAXgFe2khgAn7eaAYgGerkngBn9ebAZgGeiksgCoAedAagFeckxgDoBeeAbgFeYk1gEoCefAcgEeWk3gEoEelA2gE
					e1nHgNoCeuCMgOdlrWgAoHeuBsfvgyqKgBoFetBqfvgwqGgPn+erCUgNdbrogGn/epB0f5fdqkf+oAeoBffphipdgMn4enCCgFeOrBgLn3elCAgGeQq+f8n7
					ekBcfrhppSgFn3ejBkf7fqp0gIn0edBBf/fCn4gCn1eXAZf6gxk2gCn3eXAWf7g9kcgBn5eYAXf7hKkh]],
				Jaw = [[
					f5oRdKADfwhTghf3oUdMADfuhcgbf2oXdOAEfthigXf1oZdPAEfshmgTf0oadQAEfshogQfzoadQAEfthngPfzoadQAEfvhjgQfzoZdPADfxhdgTfzoXdOAD
					fzhVgXf0oUdMADf2hLgcf1oRdKACf5g/ghf2oPdIACf8gxgnf3oMdHACf+gigrf5oKdGACgBgSgvf7oJdFACgDgCgyf9oIdFACgGfxgzf/oJdFACgIfhgygB
					oKdGACgKfSgvgDoMdHACgMfEgrgFoPdIADgOe3gmgHoRdKADgQetghgJoUdMADgSekgbgKoXdOAEgTeegXgLoZdPAEgUeagTgMoadQAEgUeYgQgKondaAGgZ
					e6eDgZo4dwAZhWd/bvf8o4drAqfYgjZqf8o2dpArfZghZmgco0duAehed4bQgJoxdoAlgLfeaFf1oudjA2e7hKY9gUotdnAig+egalgUordlAig9eiahf0oo
					dfA5e6hQYygGomdfAhgFfraZgNoadTAHgSfFd0f/oNdIACfzgvgGf9oMdHACf0g8grf7oPdIADfyhJgm]],
				["UpperArm.L"] = [[
					eblsd4JN2ZhZgRealvd5JN2YhogYeZlxd7JN2Xh3gfeYlzd8JO2WiDgkeXl1d8JO2WiLgmeWl1d9JO2ViQgleVl1d9JO2ViRgheUlzd9JO2WiOgZeUlxd9JO
					2WiHgPeUlud8JN2Xh9gEeUlrd8JN2Xhyf4eUlod7JN2YhmfseUlmd6JM2YhbfieUljd6JM2YhRfbeVlid5JM2ZhKfYeWlid5JM2ZhFfZeXlid4JM2ZhEfeeX
					lkd4JN2ZhGfmeZlmd4JN2ZhKfyealpd4JN2ZhRgBeblsd4JN2ZhZgReclvd4JN2Yhgggedlyd4JN2Yhngveel0d4JN2Xhrg7efl1d4JO2XhthEegl4d6JN0w
					oehFepl4d6J6wMwhfvebl8d/Kbvgxye5ecl6d+Kbvnxreyerlyd4KBv2w+fIeilzd6KSv7xMeqeYlzd9Kjv/xbeMeolrd3KLwQwwehenlpd3KNwWwreYeXls
					d8KowRxOdxeglod4KMxLv0eZeklkd1JU0dpef3eelld1JK2QiXf/edlmd2JN2bg7gCeclpd3JN2ahJgJ]],
				["LowerArm.L"] = [[
					eYlwc6xrp10TuOeWl0c8x2pt0VuDeVl4c9yApm0Xt4eTl7c+yIph0XtweSl8c/yPpe0XtqeRl9dAySpe0VtneQl8dAyTpi0TtoePl6dAySpo0PtrePl4c/yO
					px0KtxeOl0c/yIp70Ft4eOlwc+yBqG0AuBeOlsc9x5qQz7uKePloc9xyqZz4uTePllc8xrqgz1uaeQljc7xmqjz0ufeRljc7xiqjz1uieSlkc6xhqfz4uieT
					llc6xiqYz9ugeVloc6xkqO0DubeWlsc6xnqC0LuVeYlwc6xrp10TuOeZl0c7xvpo0buGeal4c7xypb0iuAecl7c7x0pR0pt7edl9c7x1pK0tt4eLmQdF0vsL
					0nkhd9mYddynt+zWVpdrmbdnyatyyfTodrmYdmydt5ybTwd9mRddyGuSy3UWdymQdgyeuSybUPdomQdky2uRx+UHd4mIdbyguoyaUsd4mGdbymuuyTUydmmI
					dizFuixrUYdzmFdZzluyyXW0eJl7dC0yt3z2iMeXlrc4ySq90Lsveblpc4xXqD0PujeZlsc5xhp90RuZ]],
				["UpperArm.R"] = [[
					hllsd4JNJnengRhklvd4JNJoeggghjlyd4JNJoeZgvhil0d4JNJpeVg7hhl1d4JOJpeThEhgl2d4JOJqeUhIhfl1d4JOJpeYhJhfl0d3JNJpeghGhelyd2JN
					Joepg/helvd1JNJne1g1helsd1JNJmfBgqhelpd0JNJlfMgehelmd0JOJkfWgShflkdzJOJkfcgIhflidzJOJkfggBhglid0JOJkfff8hhlid0JNJkfaf7hi
					lkd1JNJlfRf9hjlmd2JNJlfFgChklpd3JNJme3gJhllsd4JNJnengRhmlvd5JNJoeYgYhnlxd7JNJpeJgfholzd8JOJqd9gkhpl1d8JOJqd1gmhql4d/JYLS
					W/gjh0l3eGKyQCOOeqhml8eBKmQjOAethml6eBKnQdOEekh1lxeGLEQdNnd6hslyeBK0QPOFeChjlzd9KkQBOjeKhylpeCK+QCOIdhhxlneBK+P7OQdbhils
					d7KjPtO5d3hqlod9KiO9Pqd7huljd8JmLqVtfEholkd4JKJxdVfrhnlmd4JNJne2fyhmlpd4JNJnevgB]],
				["LowerArm.R"] = [[
					holwc6xrWLLtuOhnl0c7xvWYLluGhml4c7xyWlLeuAhkl7c7x0WvLXt7hjl9c7x1W2LTt4hil9c7xzW5LQt4hhl9c6xwW5LPt7hgl7c5xrW2LPuAhgl4c5xk
					WvLSuIhfl0c4xdWnLWuRhflwc3xVWdLbuahflsc2xOWSLgujhflpc2xIWILmurhglmc1xEWALruxhhlkc1xDV5Lvu0hiljc2xEV2Lxu0hjlkc2xIV2Lyuxhk
					lmc3xOV4Lyurhllpc4xXV9Lxujhnlsc5xhWDLvuZholwc6xrWLLtuOhql0c8x2WTLruDhrl4c9yAWaLpt4htl7c+yIWfLptwhul8c/yPWiLptqiCmQdL1NTr
					L5kLikmWdvznShN3UsiXmadrylSVNvTdiXmYdqyrSPN1TjiomOdxzMSXOgTQiemPdrzCSDOSTqiUmQdky3RwODUFikmGdrzWR3OtTyikmDdqzZRvOxT6iSmJ
					dhzARbOPUdiZmEdgz+RZOKWZiMl6dL1dR/M7hmhwlrc7ykU3MFsjhrloc6xkVyL9ubhqlsc6xnV+L1uV]],
				Tail1 = [[
					gAkkh1fYgAgA//gAklh1fHgWgC/+gBkmh1e4gsgF/9gBknh1ethAgH/8gBknh1elhTgK/7gBknh1ejhkgM/6gBknh1elhzgN/6gCknh1eth+gO/5gCkmh1e5
					iHgO/5gCklh1fIiMgO/5gCkkh1fYiOgN/6gCkjh1fpiNgL/6gCkih1f3iHgK/6gCkhh1gDh/gJ/7gBkgh1gLhzgH/8gBkgh1gOhlgG/8gBkgh1gLhUgF/9gB
					khh1gDhBgE/+gBkih1f3gsgD//gAkjh1fpgWgC//gAkkh1fYgAgA//gAklh1fHfqf+/+f/kmh1e4fUf7/9f/knh1etfAf5/8f/knh1eletf2/7f/kjh1efec
					fy/6f/kah1edcpfY/xf+keh1ekfGf1/8f+kdh1ewe9f0/8f/kWh1e/cJfV/vf+kZh1fPdzfp/5f9kbh1fgfif7//f/kUh1fvc2fi/1f/kUh1f6c/fk/2f+kZ
					h1gCf7f///f/kWh1gFecfz/8f/kZh1gGd2fy/6f/kgh1gDfFf8/+f/kih1f3fUf9//gAkjh1fpfqf+//]],
				Tail2 = [[
					gAknjAfPe3f5/9gCkpjAezfaf9/9gEkrjAeVf+gB/8gGktjAd5gjgG/6gHkujAdhhGgL/4gJkujAdPhngQ/1gKkujAdGiGgV/ygLktjAdGiigZ/wgMkrjAdQ
					i5gc/vgMkpjAdhjMgd/ugMknjAd5jbge/vgMkkjAeWjjgd/vgMkijAe0jngc/wgLkhjAfQjkga/xgKkfjAfojcgX/zgJkfjAf5jPgV/0gHkfjAgCi8gS/2gG
					khjAgCilgQ/4gEkijAf5iJgN/6gCkkjAfohrgK/8gAknjAfPhJgH/9f+kpjAezgmgD/9f8krjAeVgCf//8f6ktjAd5fdf6/6f5kujAdhe6f1/4f3kqjAcuey
					fv/zfwkhi+b1bee7/Yf6kljAbteLfn/pf5kjjAb2fbfz/tftkbi+cKa1ew/Tf0kcjAchbpfF/ff7kdjAc8fLf1/1fwkWi/dbbzfH/mfxkUi/d4aOe5/Xf9kZ
					jAeOerfx/6f3kWjAendufn/4f1kZjAfWbufc/sf7kgjAf7dffw/5f8kijAf5d3fz/6f+kkjAfoeVf2/8]],
				Tail3 = [[
					f7kqkLfydNfu/3f/kvkLfYdyfz/6gEkzkLe4ebf4/7gIk3kLeUfHf+/7gMk6kKdwfzgE/6gQk7kKdPgggL/3gUk8kJc2hNgR/zgXk7kJclh3gY/wgZk4kJcg
					iegd/sgbk1kJcmjBgi/qgckxkJc3jggm/ogdkskJdQj5go/ogckokJdxkMgq/ogckkkJeVkZgp/ogakhkKe5kego/pgYkgkKfZkdgm/qgVkfkKfzkVgj/sgS
					kgkLgDkFgf/ugOkjkLgIjwgb/xgKkmkLgDjUgX/0gFkqkLfyizgS/3gBkvkLfYiOgN/6f8kzkLe4hlgI/7f4k3kLeUg5gC/7f0k6kKdwgNf8/6fyk6kJcRgV
					f0/xfck1kEaccaey/Rfxk5kIZ+drfd/Uf2k2kJZ4gmf3/ZfWkukDaCb0eg/HfgktkGaRaden+8f3kskKane1fu/gfdkikHbJcce5/ZfWkfkFbwYyeQ+0f3kh
					kLcPc6fZ/nftkckKc9dlfd/wfhkckIefaXfG/cfvkgkLf1b4fe/ufykjkLgIcQfl/xf2kmkLgDcsfp/0]],
				Tail4 = [[
					fukrlWflb8fe/uf1kylWfacYfl/xf8k4lWfFc5fs/0gEk/lWeodffz/3gLlElVeHeJf6/4gSlIlUdke2gC/4gZlKlTdDflgK/2gflLlScngVgR/zgklJlRcS
					hEgY/wgplFlRcIhxge/tgslAlRcIibgk/qgvk6lRcTjCgp/ogwkzlRcojkgu/mgwkslRdEkAgx/mgvknlSdlkWgz/mgtkjlSeIklgz/mgpkhlTeqktgy/mgl
					khlUfGktgw/ngfkilUfakngs/pgZkmlVflkZgo/rgSkrlWflkEgi/ugLkylWfajogb/xgEk4lWfFjHgU/0f8k/lWeoihgN/3f1lElVeHh3gG/4fzlLlTcJiI
					f8/rfMlPlJZjfBex/SfnlVlNYweNfZ/Gf5lTlPYdhof7/CfElKlHYaeZeY+/fIlIlIYWbOeT+pfylFlRYcesfo/DfNk5lNY0eJey/Ge3k0lGZVZrdx+jfpkz
					lTZub1e//EfikrlUakd1fU/cfHkklPcvahez/UfckhlUexbLfM/lfhkilUfabZfU/pfnkmlVflbnfY/r]],
				Frag1 = [[
					fZk0mkhvb6fw/rfhk7mlhac6g+/yfplDmmg8d8iK/1fzlKmmgXe+jQ/zf8lRmmfxf8kQ/tgHlWmmfNgxlI/jgSlYmleyhcl3/ZgclYmkehh6md/PgmlWmkec
					iNm6/HgwlSmjekiUnM/Dg5lLmie3iTnT/ChAlEmifTiMnN/FhFk8mhf1iDm7/KhJk1mggYh8me/RhKkumgg5h6l2/YhJkpmghWiAlG/fhGknmghriQkP/lhB
					knmhh5injU/qg6kpmih9jGiV/sgxkumjh6jnhT/tgnk0mkhvkGgQ/rgck7mlhdkdfM/ogQlDmlhIkpeH/kgElLmkgvkmdD/gf4lRmigVkQcD/df4lgmdeYkY
					a7/PfDlumPcagpZJ/Cfbl0mRbtfaZQ++f9lxmTapiMZI+te8lomLbOeTXs+ee0llmKbqagX3+IfulhmWa1dVY/+qfJlUmSbLcQYg+feflOmIcXXfYT9ofblM
					mZcSZdZ1+efdlCmccvbdao/Cezk0mYfTYlbD+tfJkqmfhNZtcO/HfNkpmhhyaWdW/UfTkumjh3bDeh/h]],
				Frag2 = [[
					eYkaqHfUdCmV/NevkiqNfMdqny+7fJktqTfDeQpA+ofjk8qXe5ewp++Wf9lNqYewfKqq+IgVlcqZeofcrE9+gqloqYehfnrO96g7lwqXedftrH99hJlyqWec
					fvqw+FhUluqVeffxqJ+ThclmqVemf3pR+lhilZqVexgHoL+6hllKqVfAgim3/Ohnk6qUfThKlZ/ghnkrqTfoh/jz/shnkfqSf8i9iJ/yhnkXqRgOkAge/vhm
					kTqPgblCe1/khkkSqOgfl9dO/ThikVqMgbmpbr+/hekaqKgNnDaO+qhYkiqHf3nHY5+XhOkrqFfbmyXs+IhCk0qDe8mGWr99gzk+qBedlDV293g5llp6cWkJ
					VI9kfXmWpwa6fnT09IfhmqpvaQd0Ul9PgvmuppYvgJVe9Ue6mrplZscXUw9Dd+mypaabYxVu84ffmwpsZcbyX999ermlpmZ0bRYc+Fc/mhpIa5XJZD9gePmX
					plavZubr+nemmCp0bNcWdl/UdMlWpldPZxe0/Odrkqp1e/a/g+/kd1kbp7fZbti5/keEkYqAfZcXkr/b]],
				Omega = [[
					gAuodBKMgAgA3Zf+utdBKMgbgd3Zf9uxdBKNg1g53Yf7u0dBKOhNhT3Xf6u2dCKQhkhr3Vf5u3dCKRh4iB3Tf4u2dCKTiKiU3Sf3u0dCKUiYij3Qf2uxdBKV
					iiiu3Pf2utdBKWioi03Of2uodBKWiqi23Of2ukdBKWioi03Of2ugdAKViiiu3Pf3ucdAKUiYij3Qf4uadAKTiKiU3Sf5uZdAKRh4iB3Tf6uadAKQhkhr3Vf7
					ucdAKOhNhT3Xf9ugdAKNg1g53Yf+ukdBKMgbgd3ZgAuodBKMgAgA3ZgCutdBKMflfj3ZgDuxdBKNfLfH3YgFu0dBKOezet3XgGu2dCKQeceV3VgGvweBKleJ
					d93lgOw8fnLhbMag3dgAxJfzLBfjff4JgBxGfyLCfZfT4IgPw8fyLvakZw3UgHw7fxLLdcdE39f+w6fxLBgbgg4JgMwwfxLdbxbI3pgLwtfwLbb6bT3rf8ww
					fwLCg5hB4IgFwhfgLCeMd73/gKvkeVK0c+co3igEuqdOKSe9e43bgDugdAKNfLfH3YgCukdBKMflfj3Z]],
				Orbit1 = [[
					gAlNf0KMgAgA3ZgAlOf0KeiLkm3Gf/lPf0LTkSpF2Of/lQf0MrmTtV0yf+lRf0OhoIxPy1f+lRf0Q1pw0twaf+lRf0TgrH3ptlf+lQf0WfsN5/qaf9lPf0Zt
					s+7sm/f9lOf0dEta8sjZf9lNf0gfth8/fvf9lMf0j5tT8kcFf9lLf0nMsv7cYif+lKf0qTr55qVLf+lKf0tJqw3QSFf+lJf0vrpX0TPVf+lKf0x0nxw2M/f/
					lKf0zil/tALHf/lLf00zkEo2JvgAlMf01kiEkeI5gAlNf010gAgAIngAlOf01kd8biI5gBlPf00zb8XKJvgBlQf0ziaBTALHgClRf0x0YPPKM/gClQf1vdW5
					LmPIgHlLf3tBWNIpRdf/lQf3pqU7F1U+f/lPf3mqUKEDYcgIlJf3kNTyDEbrgDlLf3gfTgCkfuf9lNf3cvTqC7jxgGlHf3aOT8D0nCgGlGf3XHUoFgqlf9lL
					f3TnV7IOuOgClHf3RXW7LAw4gElHf2O/YCOezDgBlKf0MuZxSr02gBlLf0LTbuW72OgAlMf0Ked1ba3G]],
				Orbit2 = [[
					gAlNf0KMgAgA3ZgAlOf0L0c6cr4Zf/lPf0N7Z4Za40f/lQf0QeXAWT4of+lRf0TYUWTZ33f+lRf0WmR+Qz2gf+lRf0aCP7Ok0nf+lQf0doOQMvyNf9lPf0hS
					NBLXvWf9lOf0k5MPKgsGf9lNf0oaL8KLojf9lMf0ruMIKYkyf9lLf0uwMzLIg5f+lKf0xbN9Mac+f+lKf0zrPkOLZHf+lJf01cRmQZVbf+lKf02rT/TBSBf/
					lKf03WWtV9O9f/lLf03bZqZLMUgAlMf026cycjKMgAlNf010gAgAIngAlOf00LjOjdHogBlPf0yAmYm0HRgBlQf0vZpXp/HigClRf0sYsIs5IagClQf1oxuX
					vqJwgHlLf3kmwXyTMBf/lQf3hYxbz+OJf/lPf3dxym1SRNgIlJf3Ztzo19VOgDlLf3Wozn2PYif9lNf3TyzO2GcCgGlHf3Qbyj04gkgGlGf3N+xTzekef9lL
					f3MZvwyKnygClHf3KkttvgrpgElHf2JPrcsguwgBlKf0IlpDptxRgBlLf0IhmKmkzwgAlMf0JFjHjV11]],
				["UpperLeg.L"] = [[
					eKi4gO69eWgFxJeKi5gP67ebgCxNeKi6gQ65eff+xReKi6gQ63ejf7xTeJi7gR64enf3xTeJi7gR65eqf0xQeJi7gS69esfwxLeJi6gS7CetftxCeJi5gS7I
					etfpw4eJi4gT7PesfnwteJi3gT7WerfkwieJi2gT7ceqfjwZeJi1gS7geofjwReJi0gS7jelfkwMeJi0gS7kejfmwLeJi0gR7iehfpwNeJi0gR7eefftwTeK
					i0gQ7YecfywdeKi1gQ7Reaf4wqeKi2gP7HeYf/w5eKi4gO69eWgFxJeKi5gO6zeUgMxZeLi6gN6oeSgTxoeLi7gN6feQgYx1eLi7gM6YeOgdx/eLi6gJ6KeM
					gkyTePi1gB5sdng6y5eJi5gG57eggiyqeJi4gG5/eegjymeQizf/5vdfg/yzeMi0gD6DeDgsydeIi2gH6UepgZyJeOiwgB6HdrgzyUeOiwgB6NdsgxyMeHi0
					gI6meqgQxueLixgF6ieGgexxeNixgG6sd0ghxfeLi1gM6/eMgQxEeLi1gN7BeNgNxCeKi2gO6/eSgJxF]],
				["LowerLeg.L"] = [[
					eHh6fxruhqgD9ueGh7fyr/hwgB9meGh8fzsPh1f/9geGh8f0sch6f99aeGh9f0slh/f79WeFh9f1sqiEf69TeFh9f1spiIf69TeFh9f1sliLf69VeFh8f0sc
					iOf69ZeEh8f0sQiRf79deEh7fzsDiSf99jeEh6fyr1iSf+9oeEh5fxrpiSgA9teEh5fxreiQgB9xeEh4fwrWiNgC91eFh4fwrSiJgD93eFh4fwrRiEgD93eF
					h4fwrUh+gD92eGh5fwrbh4gD90eGh5fxrkhxgD9xeHh6fxruhqgD9ueHh6fyr5hkgD9qeIh7fysDhdgD9meIh7fzsLhXgD9jeIh8fzsQhRgE9heJh6fxrxhK
					gF9ueMh0fsqNgWf++UeHh4fwrYhfgO93eHh4fvrMhegP97eNhyfqpkgNf/+heJh0fsqMg/gL+TeGh2fvq2hxgW+CeLhwfppOgjgF+oeLhwfppEgmgF+reFh1
					ftqbh6gY+LeIhyfrpnhMgM+feKhyfrpvg5gE+deHh3fvq9hdgJ+BeHh4fwrOhggH97eHh5fwrdhlgF90]],
				["Foot.L"] = [[
					eOhIgn8Nf8gCvGeOhIgn8NgAgAvGeOhIgn8NgEf+vGeOhIgn8NgIf8vGeOhIgn8NgMf6vGeOhIgn8NgQf4vGeOhIgn8NgTf2vGeOhIgn8NgXf0vGeOhIgn8N
					gZfyvGeOhIgn8NgcfxvGeOhIgn8NgdfwvGeOhIgn8NgefwvGeOhIgn8NgefwvGeOhIgn8NgcfxvGeOhIgn8NgafyvGeOhIgn8NgXf0vGeOhIgn8NgSf2vGeO
					hIgn8NgOf5vGeOhIgn8NgIf8vGeOhIgn8NgCf/vGeOhIgn8Nf8gCvGeOhIgn8Nf2gGvGeOhIgn8NfwgJvGeOhIgn8NfqgMvGeOhIgn8NflgOvGeOhIgn8Nfg
					gRvGeOhIgn8LeygqvFeOhIgn8Nf0gHvGeOhIgn8NfzgHvGeOhIgn8LergtvFeOhIgn8MfYgVvGeOhIgn8NgFf9vGeOhIgn8Me/gjvFeOhIgn8MfCghvFeOhI
					gn8NgNf5vGeOhIgn8NfkgPvGeOhIgn8MfSgYvGeOhIgn8NfxgIvGeOhIgn8NfzgHvGeOhIgn8Nf3gFvG]],
				["Toe.L"] = [[
					eOgsgU/9f9gEhgeOgsgU/9gAgAhgeOgsgU/9gDf8hgeOgsgU/9gFf5hgeOgsgU/9gIf1hgeOgsgU/9gLfyhgeOgsgU/9gNfuhgeOgsgU/9gPfrhgeOgsgU/9
					gRfphgeOgsgU/9gTfnhgeOgsgU/8gUflhgeOgsgU/8gUflhgeOgsgU/8gUflhgeOgsgU/9gTfmhgeOgsgU/9gRfohgeOgsgU/9gPfrhgeOgsgU/9gMfvhgeO
					gsgU/9gJf0hgeOgsgU/9gFf5hgeOgsgU/9gBf+hgeOgsgU/9f9gEhgeOgsgU/9f5gKhgeOgsgU/9f1gPhgeOgsgU/9fxgUhgeOgsgU/9fugYhgeOgsgU/8fr
					gdhgeOgsgU/7fMhHhgeOgsgU/9f4gLhgeOgsgU/9f3gMhgeOgsgU/7fHhOhgeOgsgU/8flglhgeOgsgU/9gDf7hgeOgsgU/7fVg7hgeOgsgU/8fWg5hgeOgs
					gU/9gJf0hgeOgsgU/9ftgZhgeOgsgU/8fhgqhgeOgsgU/9f2gOhgeOgsgU/9f3gMhgeOgsgU/9f6gIhg]],
				["UpperLeg.R"] = [[
					h2i4gO69hqf7xJh2i5gO6zhsf0xZh1i6gN6ohuftxoh1i7gN6fhwfox1h1i7gM6Yhyfjx/h1i7gM6Uh1ffyFh1i7gL6Sh3fcyIh0i7gL6Th5fayGh0i6gL6X
					h8fZyBh0i5gK6ch+fZx5h0i4gK6ih/faxvh0i3gK6piAfcxlh0i2gL6wiAffxbh0i1gL62iAfhxSh1i0gL66h+flxKh1i0gM6+h9foxFh1i0gM7Ah6fsxCh1
					i1gN7Bh3fwxBh1i1gN7BhzfzxCh2i2gO6/huf3xFh2i4gO69hqf7xJh2i5gP67hlf+xNh2i6gQ65hhgCxRh2i6gQ63hdgFxTh3i7gR64hZgJxTh3i6gP6yhW
					gKxch7izgP7Rg3gkwth1i5gI6Ohmf8yPh1i4gJ6Vhlf/yGh7iwgP7hg0gvwRh3izgL6/hUgVxIhzi2gH6Wh0f7yDh6ivgN7hhEgnwRh5iugN7jhGgmwOhzi0
					gH6dh6f4x3h3iwgL7LhegQw0h5iwgP7mhRgdwIh2i0gQ7UhlgMwkh2i1gQ7RhmgIwqh2i2gP7HhogBw5]],
				["LowerLeg.R"] = [[
					h5h6fxrueWf99uh5h6fyr5ecf99qh4h7fysDejf99mh4h7fzsLepf99jh4h8fzsQevf89hh3h8fzsQe0f89hh3h7fzsMe4f79jh3h7fysEe6f69nh3h6fyr4
					e8f59rh3h6fxrqe9f49xh3h5fwrce9f393h3h4fvrOe7f298h3h3fvrBe5f2+Ah3h3fuq4e3f1+Dh4h2fuq0ezf1+Fh4h2fuqzevf2+Fh4h3fuq4eqf3+Dh4
					h3fvrBelf4+Ah5h4fwrOegf597h5h5fwrdebf790h5h6fxrueWf99uh6h7fyr/eQf/9mh6h8fzsPeLgB9gh6h8f0sceGgD9ah6h9f0sleBgF9Wh7h7fzsHd/
					gF9ih/h3fwq8dMfy97h4h5fwreefgN90h5h4fwrVecgN94iAh1fuqcdBft+Fh7h2fuqnd3gA+Gh3h3fuq3etgQ+Dh+hzfsp9dVfw+Sh+hyfspzdXfv+Vh3h1
					ftqXeygN+Ph7hzfsp+d+f7+Vh9h1fuqYdkfx+Kh6h4fwrNeFf995h6h5fwrbeIf990h6h5fxrkePf99x]],
				["Foot.R"] = [[
					hyhIgn8NgEf+vGhyhIgn8NgKf6vGhyhIgn8NgQf3vGhyhIgn8NgWf0vGhyhIgn8NgbfyvGhyhIgn8NgffwvGhyhIgn8MgifuvGhyhIgn8MgkftvGhyhIgn8M
					glfsvGhyhIgn8MgmfsvGhyhIgn8MglfsvGhyhIgn8MgkftvGhyhIgn8MgifuvGhyhIgn8NgffvvGhyhIgn8NgcfxvGhyhIgn8NgZfzvGhyhIgn8NgVf1vGhy
					hIgn8NgRf3vGhyhIgn8NgNf5vGhyhIgn8NgJf7vGhyhIgn8NgEf+vGhyhIgn8NgAgAvGhyhIgn8Nf8gCvGhyhIgn8Nf4gEvGhyhIgn8Nf0gGvGhyhIgn8Nfy
					gHvGhyhIgn8MfCghvFhyhIgn8NgPf4vGhyhIgn8NgMf6vGhyhIgn8Le3gnvFhyhIgn8NfpgMvGhyhIgn8NgbfyvGhyhIgn8MfIgevFhyhIgn8MfKgdvFhyhI
					gn8NgffwvGhyhIgn8NfugJvGhyhIgn8MfWgXvGhyhIgn8Nf2gGvGhyhIgn8Nf4gEvGhyhIgn8Nf+gBvG]],
				["Toe.R"] = [[
					hygsgU/9gDf8hghygsgU/9gHf2hghygsgU/9gLfxhghygsgU/9gPfshghygsgU/9gSfohghygsgU/8gVfkhghygsgU/8gXfhhghygsgU/8gYffhghygsgU/8
					gZfehghygsgU/8gZfehghygsgU/8gZfehghygsgU/8gYffhghygsgU/8gXfhhghygsgU/8gVfjhghygsgU/9gTfmhghygsgU/9gRfphghygsgU/9gOfthghy
					gsgU/9gLfxhghygsgU/9gJf0hghygsgU/9gGf4hghygsgU/9gDf8hghygsgU/9gAgAhghygsgU/9f9gEhghygsgU/9f7gHhghygsgU/9f4gLhghygsgU/9f3
					gNhghygsgU/8fWg5hghygsgU/9gKfzhghygsgU/9gIf1hghygsgU/7fPhDhghygsgU/9fwgVhghygsgU/9gSfnhghygsgU/8fbgzhghygsgU/8fbgyhghygs
					gU/8gVfkhghygsgU/9f0gQhghygsgU/8fkgmhghygsgU/9f5gJhghygsgU/9f7gHhghygsgU/9f/gChg]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAkUhAAGeJgNhHgAkXhAAFeXgshGgAkchAAFe3hDhFgAkhhAAEfjhOhGgAkihAAEgVhMhIgAkfhAAEhDg9hJgAkZhAAFhlgjhJgAkVhAAGh2gDhIgAkVhAAG
					hzfjhGgAkZhAAFhbfIhFgAkfhAAEg0e2hFgAkihAAEgEexhHgAkhhAAEfTe6hJgAkchAAFeqfPhKgAkXhAAFeQfshJ]],
				Spine1 = [[
					f/kXgUAUeLgYj/f+kagUAVeXggkHf9kfgUAWe2gjkcf9kkgUAYfhgfkvf9kmgUAZgSgVk0f9kigUAXg/gIkof/kdgUAWhif6kSgAkYgUAVh0fukCgBkYgUAV
					hyfkkBgDkcgUAWhcfekRgDkigUAXg2fekmgDklgUAYgHflk0gDkkgUAYfXfxkwgCkfgUAXeuf/kdgBkagUAVeTgMkI]],
				Spine2 = [[
					f8kte+AzeNgimxf6kwe/A2eUgVnDf5k3e/A/etgFnsf5k+fABHfVfyoQf7lAfABJgEfhoYf+k7e/BDgxfVn/gAk0e/A6hXfTnUgDkue+A0hufZm1gFkue+A0
					hyfkm2gHkze/A6hifznWgHk7e/BDhAgEoAgGlAfABJgUgXoZgEk+fABHflgmoPgBk4e/A+e6gtnqf+kwe/A2ebgrnC]],
				Neck1 = [[
					f5lAeVDReZg8t7f4lDeWDOebgtt2f4lMeXDmexgYupf6lVeYELfTf9vxf8lXeZEmf7fhwegAlReYEggjfJwUgDlIeWEAhIe9vZgGlBeVDchhe/uTgHlBeVDM
					hpfLtxgIlIeWDXhcfduKgHlReYD4g/f1vNgFlXeZEcgZgRwNgClVeYEnfxgswgf+lNeXESfKg/v7f8lEeWDteqhDu0]],
				Neck2 = [[
					fyl7dmF4ekhMyXfyl+dmF+ekg9ygf0mKdrGYe2gkzGf4mVdxG3fTgEzwf+mZd1HFf3fi0CgFmUd0G4gcfFzxgKmIduGag+e0zIgNl9doF/hWexyhgOl7dmF4
					hee6yXgNmDdoGJhVfOyxgKmQduGog9frzdgFmZd0HBgcgNz9f+mYd1HCf3guz+f4mOdxGqfShFzef0mCdrGLe0hPyy]],
				Head = [[
					frm2dRAIeJgQh+frm6dRAKeSfgiTfvnGdZALeue1iof2nTdiAMfZeWiwf/nXdnALgJeJilgJnRdlAKg3eRiOgQnEdcAIhceuh7gUm4dTAIhzfYh4gVm2dQAJ
					h1gIiHgTm/dVAKhjg2ifgOnNdeALg+hcivgFnXdmAMgPhzitf8nWdnAKffh1iafznLdhAJe1hjiDftm+dXAIeWg+h3]],
				Jaw = [[
					fpm/b+/qh3gHkIfunEb//mhlg3kof1nTcH/ng/hbkkf/ngcR/sgQhwkAgJnjcW/xfhhzjTgSnbcT/ze4hki7gXnMcK/xeYhDjIgYnBcB/teIgTjxgVnAb+/o
					ePfgkcgPnLcC/mese1krgHnacM/pfYeYkVf8njcU/ugIeMjofyngcV/yg1eSjDfrnUcP/yhaeqi9fonFcF/whyfUjb]],
				["UpperArm.L"] = [[
					eXkgduznQUkxzPeWkldtz8QDkayweVkzds0yPjjOxneWlBds1sO8hqwGeYlIds2WOXgLumeblGdr2pN4fDteeek/dr2rNieUs3efk5dr2nNYd6sqehk5dt2m
					Nbdxswehk/du2oNud6tHehlGdw2nOMedt3eflIdx2VOxfivEeclBdx1sPXhFwkeakzdw0yP5izx/eYkmdvz9QQkLy9]],
				["LowerArm.L"] = [[
					d+jpdfrj8hZ6mUd8jwdcsA8vbZlrd6kAdVs286eEkVd5kTdOtz8thQivd6kgdIun8HkKhXd7kkdDvQ7bmLgdd8kfdBvu68nIgCd9kbdBwB6wnHf9d+kbdDwG
					65mXgHd+kgdGv57Tk/ged+kkdKvW74jBhJd+kgdPug8bggiNd9kTdVtd8tdyjmd+kBdbsb8rbYlCd+jwdfrt8gZ8mD]],
				["UpperArm.R"] = [[
					hgk4ds2myoiNsrhfk7dt2nydiOs5hflDdv2pyEh5tchglIdx2gxihFuahjlGdy2Ew8fvvzhlk7dx1RwXeDxUhnksdw0Vv6ccyjhpkiduztvsbazMhqkhdtzs
					vybTzFhrkrds0VwLcHyQhrk6ds1Qwwdjw4hplGds2ExXfIvUhmlIdr2ix5gdt+hklDdr2ryUhYtGhik7dr2pylh7su]],
				["LowerArm.R"] = [[
					iDkadCwGFOZMgAiCkddEwCE7aQgQiCkidIvqEbb8gxiCkjdMu+D1eMhoiCkbdSuADZg3i4iDkKdYs7DSjgkViCj4ddsBDblglniCjrdgrjDimRmTiDjrdert
					DZlimGiFj3dZsZDKjZlEiHkKdRtVDJgXjiiHkbdKuPDkdOiAiGkjdFu9EPatg2iEkidCvgE3ZOgMiDkddBv5FNYyf9]],
				Tail1 = [[
					f/kdh0cLhKh7/rgBkfh0bTgPhv/mgDklh0bBfVhN/kgEkqh0biejgf/pgEkrh0cfeAfv/vgEknh0dQdxfD/xgDkih0dVd6ef/xgBkdh0cqedeI/ugAkeh0bs
					fTeI/of+kih0bEgPeg/kf9koh0bMhFfJ/mf8krh0b/hwf5/sf8kqh0c8iKgo/wf9kkh0dZiOhQ/yf+kfh0dEh3hv/w]],
				Tail2 = [[
					gEkvi9bQjzh+/WgBk1i8Zfh0hx/Of/k8i8YaflhK/Df9k/i8YudfgT/Df7k7i9aPbzfc/Lf6k0i+b8axex/Rf6kui+ctaneU/Uf7kti+cCbdeE/Wf+kyi9aX
					dJeF/TgAk5i8YzfTeg/IgCk+i8YYhgfR/BgEk+i9ZYjbgK/HgGk4i+bJk0g7/PgHkxi+cflbhf/TgGkti+cjlGh2/V]],
				Tail3 = [[
					gUlGkDbTnGh++xgIlUkBZFkvhr+0f7lfj/XGhnhD+qfxlgj/WoeTgH+ifolWkBYBbTfH+mfilIkDaVZCeX+qfik/kEcCX5eB+ofnlBkEcAYNd/+sfylNkCaQ
					Z9eK+1f/lakAX9cxem+wgKlhj/WogEfZ+lgUlckAXIjRga+jgblPkCZJl9hU+pgflCkDbXnth3+pgck/kEcRoJiC+p]],
				Tail4 = [[
					gzldlEa7p5iI96gbl0lCY9oAhi+IgBmHk+Wekugz+KfpmKk9VFgvf3+DfUl7lAVtcrew+FfEljlCX9ZHd0+He+lTlDaWWqdb99fFlVlEbQV1do93fYlolEaH
					W2eK+Bfyl/lAXrZhe0+LgLmLk9VkdPfp+HgimEk+VJhVgs+Dg1lvlBWtlNhx+HhAlalDZQoTie+DhAlSlDbDp/ii94]],
				Frag1 = [[
					hfl/mAc+qBhd+Mg8mdmDbnp4jm95gSm3mBZFnrlM91fqm7mBXQjWl/9/fGmmmFXUdil0+IeomHmIZFX/kb93eXlxmGbYUxiK9heZl0mCc2U4fv90eumNl+cp
					XjdX+jfRmql5a7bCbG+zf7m4l4Yqd9Zp+agmmvl7XNgXZx+HhOmTl+Xni5bO+Xhol4l8ZwlydM+thvlvl8cIocfQ+m]],
				Frag2 = [[
					jlmvo+dprpoJ8kjAnlo/coqmqX8JhzolpDZ/nPrI8egIpApNXbh1qT8/eOogpVWpbvnd9XcnnepGYcXOiz9sbymrovb0V2d79+b6mjoveSXJZ4+Ec3nDpCd/
					ZWWo9yeVn1pMbHa8Un9Df1obpGXmcBU38ghIoho+Vod/Xe89iLoCo9WWhybj+HjAnOpAZNmkgJ+kjimopAcRqSkk9t]],
				Omega = [[
					e3tqbnImevhY1ueztwbmIkgNih1ne9t7bmInhpjO1hfTuEbmIuizjY1ffxuHbmI0jdi81jgRuCbmI0jiiA1qgut4bmIwjAgu1whDttbmIph8fU1whMtobnIk
					gjeB1rhItobnIlfEdE1kg4ttboIqdvco1fgetxboIxc0cx1hgAtxboI1cbde1nfhttbnIzcren1tfHtpbnIsdff/1w]],
				Orbit1 = [[
					f8kzfvImevhY1uf6k1fvJCidnX03f5k6fvKtmLswzNf5lAfvNhpixZw+f6lBfvRNsQ1NuTf9k+fvVeuK4NrOgAk4fvaAvQ6XnvgDk0fvejvn7oj0gFkzfvi/
					vY75ffgHk4fvnOur7Ba5gHk9fvrPtl43WRgGlBfvu7sF1ZR+gElAfvyLqKwuOZgCk7fv01ntrFL1f/k2fv2pkuk6Kd]],
				Orbit2 = [[
					f8kzfvImevhY1uf6k1fvK7a1dc3Xf5k6fvN9XOZQ3+f5lAfvRkT3VD3Zf6lBfvVrQvRM1jf9k+fvaON7OGyggAk4fvfJLoMFuhgDk0fvkVKJLUp6gFkzfvpk
					JvLwlEgHk4fvuiKnNMgPgHk9fvy4MyPUbogGlBfv2QQGR5XUgElAfv4aULUuTXgCk7fv5RYnXwP0f/k2fv44dEbCMv]],
				["UpperLeg.L"] = [[
					eYiWgf2Jdigz28eViagj3vdjgP1TeRiigm6edpfgxyeLisgo99d0eLq2eGizgn/jeRcMjIeBi1gm/se+b5gsd+i0gj/xfFdLiLd+iygf/Ze4e2l4d/iygc+x
					ejfqopeCizgY+SeGf+qJeHi0gW9bdugXsWeMiygW8ZdagrufeSirgW7TdLg2waeWiigZ5/dEg7yZeYiZgc4SdLg50n]],
				["LowerLeg.L"] = [[
					eThSghiPfAfZ/5ePhWgbeEfrfV/7eKhjgMc1g5fk/0eBiBfzg1i0gf/2d1infmpTlGiC+Hdwizfkvrl4jN7EdyirfgzSlXjI4wd4iZfg1YkaiW3Rd8iOfh0i
					jjh64MeAiKfixfirhp6meFiDfmuththG8VeKh6ftr8gvge9qePhvf2o4f4f6+ueShhgBltfPfg/deThWgQjKe7fW/z]],
				["Foot.L"] = [[
					eOhIhq8GdjhUvCeOhfhk7oeOhCwAeOhyhU7TfcgWwqeOh+g77EhKfSw/eOiAgg64jAeHw+eOh5gF66j1dowteOhpfw7Pjjd5wQeOhTfl7yiweevieOhIfs8J
					h5e/vEeOhIf+8MhBfdvFeOhIgQ8NgGf9vGeOhIgi8MfLgcvFeOhIg08KeYg4vEeOhIhG8HdxhNvDeOhIhY8FdehXvC]],
				["Toe.L"] = [[
					eOgshY/1eWiQhfeOhChU/0e2hsikeOhUhF/0fpgjjTeOhggt/vgve2jseOhigR/kh5dAjweOhbf2/eiccOjgeOhMfg/liScli9eOg3fT/xh0dciEeOgsfa/4
					hSeRhfeOgsfs/7gsfFhgeOgsf+/9gEf7hgeOgsgQ/8fdgwhgeOgsgi/5e6hfhfeOgsg0/2egiDhfeOgshG/0eTiUhf]],
				["UpperLeg.R"] = [[
					iCixgd+1hNgXobiAiyga+lhtgOpPh8i0gX94iHf2rNh2izgW86idfetchxivgW73ivfOvehsingX6si6fGxYhpidga5Mi7fFzehoiXge3RisfK1xhpiXgh21
					iefe2Qhtiegl48iagHz4hyingn8QiShEuzh3iwgo/HiCi3mjh9i1gn/phWkQhQiAi1gl/wg6jlhFiCizgh/rhBiAjz]],
				["LowerLeg.R"] = [[
					iFiPfi2KcGeK2qiDiMfhy+c4eL5gh+iHfkwEdzeo7ih5h/fptWezfP9Ch0h1fxqdfuf1+Phwhof7nRgfgV/JhthbgIkSg+gn/rhthTgZidhGgp/3hvhTgff4
					gugr/+hzhbgVc+fygo/1h6hwgAeBePgF/4iFiWfqk9cAey/UiPiwfls7aSdP8kiQixfixvaTct5yiLijff0dbGdN37]],
				["Foot.R"] = [[
					hyhIfj8HduhOvDhyhIf18KeigyvFhyhIgH8MfcgTvGhyhIgZ8NgYfzvGhyhIgr8LhPfVvFhyhIg98Ih9e9vEhyhIhP8GicetvChyhIhh8FijepvChyhThp72
					iMeyvjhyhphd7chOfRwYhyh5hI7LfwgKw4hyiAgu6+d4hWxBhyh+gS63caiQw2hyhyf67CcPiTwghyhffp7fc0h2v7]],
				["Toe.R"] = [[
					hygsfR/2eeiFhfhygsfj/6fBhWhghygsf1/8foghhghygsgH/9gQfqhghygsgZ/7g1e3hghygsgr/4hUeOhfhygsg9/1hpdyhfhygshP/0hudrhfhyg3hX/0
					hcd+iEhyhMhN/0gze0i+hyhbg6/yf2gQjihyhigf/qeqiIjxhyhggD/fdujljqhyhUfq/hdmjtjRhyhCfZ/rd7jDij]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAkdhA//gAgAgUgAkGhA/+f0e1gUgAkLhA/8fweWgUgAkihA/+f0e1gUgAkdhA//gAgAgUgAkGhA/+gMhLgUgAkLhA/8gQhqgUgAkihA/+gMhLgU]],
				Spine1 = [[
					gAkcgUAMgAgAjTf9kFgUAJgShKihf7kKgUALgahoisf9khgUAOgUhJjdgAkcgUAMgAgAjTgDkFgUAJfue2ihgFkKgUALfmeYisgDkhgUAOfse3jd]],
				Spine2 = [[
					gAkue9AwgAgAmyf3kTe9AegZhIlRfzkZe9Akgkhllnf3k0e+A2gdhGnIgAkue9AwgAgAmygJkTe9Aefne4lRgNkZe9AkfceblngJk0e+A2fje6nI]],
				Neck1 = [[
					gAlBeUEbgAgAwMf0kieSDAgrg/tdfvkpeTDVg+hXuEf0lIeVEygyg5wxgAlBeUEbgAgAwMgMkieSDAfVfBtdgRkpeTDVfCepuEgMlIeVEyfOfHwx]],
				Neck2 = [[
					gAmDdvH3gAgA0/fxlcdhF/g1g2ykfrlldlGahNhKzGfymLdzIWg7gv1fgAmDdvH3gAgA0/gPlcdhF/fLfKykgVlldlGaeze2zGgOmLdzIWfFfR1f]],
				Head = [[
					gAnCdmATgAgAkRfwmYdNAJgTgkiufqmidTALgcgyjEfznLdtAXgZgikmgAnCdmATgAgAkRgQmYdNAJftfciugWmidTALfkfOjEgNnLdtAXfnfekm]],
				Jaw = [[
					gAnWcW/8gAgAh2ftmkb7/qf2fZkffmmwcB/1fufKjDfwnhcd/+fsfagZgAnWcW/8gAgAh2gTmkb7/qgKgnkfgamwcB/1gSg2jDgQnhcd/+gUgmgZ]],
				["UpperArm.L"] = [[
					ebktdswtPjlU1GeMkMd0uHRHms3neFkUd3uyRNl83deMk2d0xXQEkG1PebktdswtPjlU1GerkJdltwPmn/2YexkQdiuWPHn11teqk0dlxNOxlnz+]],
				["LowerArm.L"] = [[
					d7j4dnub8aiCh7dsjXd/uL8ed7iqdmjfeAuW8fegh1drkBdvuv8TiSggd7j4dnub8aiCh7eLjUdrt88YfAkweSjbdlt88ZgBkyeMj+dbuM8XjXii]],
				["UpperArm.R"] = [[
					hlktdswtwdas1GhVkJdltwwaYB2YhPkQdiuWw5YL1thWk0dlxNxPaZz+hlktdswtwdas1Gh0kMd0uHu5ZU3nh7kUd3uyuzaE3dh0k2d0xXv8b61P]],
				["LowerArm.R"] = [[
					iFj4dnubDmd+h7h1jUdrt8DohAkwhujbdlt8Dnf/kyh0j+dbuMDpcpiiiFj4dnubDmd+h7iUjXd/uLDiiFiqiajfeAuWDhhgh1iVkBdvuvDtdugg]],
				Tail1 = [[
					gAkqhzdbg5f7/4gEkThzbrgef//sgFkYhzb9fygB/vgEkvhzdtfOgF/5gAkqhzdbfHgF/4f8kThzbrfigB/sf7kYhzb9gOf//vf8kvhzdtgyf7/5]],
				Tail2 = [[
					gEk2i+e7iwf2/2gGkni8b6hIf+/tgEkri8a8e1f//kgAk6i+d9dPgB/zf8k2i+e7dQgK/2f6kni8b6e4gC/tf8kri8a8hLgB/kgAk6i+d9ixf//z]],
				Tail3 = [[
					gRk7kIgekxf4/ogLk6kFdui2f3/yf/lDkEbAfOf//lfzlDkHdvcEf4/qfvk7kIgebPgI/of1k6kFdudKgJ/ygBlDkEbAgygB/lgNlDkHdvj8gI/q]],
				Tail4 = [[
					gnk5lQgsmHgH/ZgZlFlOfgk6fz/nf7lalLb8gzgA/ufhlOlQdHcNf0/ofZk5lQgsZ5f5/ZfnlFlOfgbGgN/ngFlalLb8fNgA/ugflOlQdHjzgM/o]],
				Frag1 = [[
					hGk7mbi0mHfs/RgtlImfiGmZkn+8gAlmmeeUgtm3/MfTlZmhfEZ2k4+/e6k7mbi0Z5gU/RfLlJmWiqd9cC/kgBlmmUeUfTZJ/Mg2lZmYeWhzbA/g]],
				Frag2 = [[
					iZkRp2ijmumu+ciTkwp7ihkdqf9ygKmDqSd7eUo2+odyleqBefanhp/dddkRpyjSdSaP/Lepkgp2hxepV6+RgBl9p3cwdoW8+ahUl0p8daifeQ/v]],
				Omega = [[
					gAtVayHngAgA0sfqtHayHwitiT0kfhtPayH6j0jP0cfqtiayHwitiT0kgAtVayHngAgA0sgWs3a0HwdTdt0kgfs5a2H6cMcx0cgWtTa0HwdTdt0k]],
				Orbit1 = [[
					gAk0fsHngAgA0sf6keftJ5nRrHy7f4kjftP4sxz/uKf6k5ftXsv35bnggAk0fsgAw07OgAgGkeftoUv35bYggIkjftwIsxz/R2gGk5ft2HnRrHNF]],
				Orbit2 = [[
					gAk0fsHngAgA0sf6keftMIYTZQ23f4kjftTaROS51xf6k5ftdDLvORxAgAk0fsnwJYM0pJgGkeftxQLNO5f4gIkjft3iQpTkXJgGk5ft50YFZgQI]],
				["UpperLeg.L"] = [[
					eKipgpz8ekg149eHiUgx4OgDf+05eGiZg17lflVgTqeHiwgx/2fpdBfkeKipgp+DfKgtq6eOiRgg/tc7fKitePiVgd5WdPhmzReOitggqkfLia+F]],
				["LowerLeg.L"] = [[
					eIhmg4b2hZgG/seHhQgnO5jmi96ndgjHgU2xrVkiy4d7iyfu7ElrhlwAeMh9f096ipfdrAeJiGfdvcg4gn7/eOhTgKilgDgZ/4eOiChWqhf/gI+N]],
				["Foot.L"] = [[
					eOh5h+7bgAgAweeOiThF6wkQdVw0eOiRgA5SpyZ4v2eOh1fK7GkmdRwJeOhOe88ohQffuOeOhIgE8MfTgYvGeOhIhT8LeqguvFeOhUiP5bemhFzV]],
				["Toe.L"] = [[
					eOhchvAdgAgAlPeOh1g3AdeCkoheeOhzfyCYZ0pvcleOhXe6AmdCkddGeOgzeoADfGhAffeOgsfyAEgefXegeOgshAAFgzeshTeOg0iGAngJePl3]],
				["UpperLeg.R"] = [[
					h2ipgp+Dg2fTq6hyiRgg/tjFg2ithxiVgd5WixeazRhyitggqkg1dm+Fh2ipgpz8hcfL49h5iUgx4Of9gC05h6iZg17lgbqgTqh5iwgx/2gXi/fk]],
				["LowerLeg.R"] = [[
					h0h9f096dXgjrAh3iGfdvcfIfZ7/hyhTgKilf9fn/4hyiChWqhgBf4+Nh4hmg4b2enf6/sh5hQgnO5cadD6nigjHgU2xUrbey4iFiyfu7EaVebwA]],
				["Foot.R"] = [[
					hyhOe88oewghuOhyhIgE8MgtfovGhyhIhT8LhWfSvFhyhUiP5bhae7zVhyh5h+7bgAgAwehyiThF6wbwirw0hyiRgA5SWOmIv2hyh1fK7GbaivwJ]],
				["Toe.R"] = [[
					hygzeo/9fGhAghhygsfy/8gefXhghygshA/7gzesethyg0iG/ZgJePaJhyhchv/jgAgAaxhyh1g3/jeCkoeihyhzfy9oZ0pvjbhyhXe6/adCkdi6]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAkqhAAGgAgAiUgAkihHAIgAgAisgAkPhWAOgAgAjmgAj6hmAWgAgAkkgAjwhuAbgAgAlEgAkmgUABgAgAgjgAk9fbAGgAgAd3gAk9fbAGgAgAd3gAk9fbAG
					gAgAd3gAk8fiAEgAgAeKgAk3f8ABgAgAfUgAkwgfACgAgAg2gAkrg6AFgAgAiBgAkqhAAGgAgAiUgAkqhAAGgAgAiUgAkqhAAGgAgAiU]],
				Spine1 = [[
					gAkxgUAhgAgAlmgAkqgbAjgAgAl0gAkZgqAqgAgAmXgAkHg7AygAgAm7gAj+hEA2gAgAnOgAknfnARgAgAkCgAk3evAFgAgAh/gAk3evAFgAgAh/gAk3evAF
					gAgAh/gAk2e2AGgAgAiPgAk1fQALgAgAjMgAkzfzAVgAgAkagAkxgNAegAgAlXgAkxgUAhgAgAlmgAkxgUAhgAgAlmgAkxgUAhgAgAlm]],
				Spine2 = [[
					gAlPfBBPgAgAowgAlJfIBQgAgAo1gAk7fZBUgAgApAgAksfrBXgAgApMgAkkf1BZgAgApSgAk9eSA4gAgAnZgAlCdXAmgAgAmCgAlCdXAmgAgAmCgAlCdXAm
					gAgAmCgAlDdeAogAgAmOgAlGd5AygAgAm8gAlLeeBAgAgAn3gAlOe6BMgAgAolgAlPfBBPgAgAowgAlPfBBPgAgAowgAlPfBBPgAgAow]],
				Neck1 = [[
					gAlnebDwgAgAvAgAlheiEHgAgAvqgAlUezFDgAgAxOgAlFfFGKgAgAy1gAk+fPGxgAgAzqgAlSdpCwgAgAs7gAlTctBQgAgAozgAlTctBQgAgAozgAlTctBQ
					gAgAozgAlUc0BYgAgApOgAlZdQB7gAgAq5gAlgd2CygAgAtBgAlmeTDjgAgAumgAlnebDwgAgAvAgAlnebDwgAgAvAgAlnebDwgAgAvA]],
				Neck2 = [[
					gAmmdwGUgAgAzEgAmid6G9gAgAz5gAmYeTIogAgA11gAmNeuKlgAgA3wgAmHe8LqgAgA4rgAmKc2E0gAgAw2gAl7btCQgAgArxgAl7btCQgAgArxgAl7btCQ
					gAgArxgAl+b1CegAgAsSgAmKcWDYgAgAuSgAmZdDExgAgAwygAmjdnF/gAgAyngAmmdwGUgAgAzEgAmmdwGUgAgAzEgAmmdwGUgAgAzE]],
				Head = [[
					gAnideADgAgAhRgAngdsAJgAgAixgAnYePAqgAgAmZgAnMe0BrgAgAqKgAnFfICYgAgAsEgAnCcaABgAgAgXgAmma/AegAgAamgAmma/AegAgAamgAmma/Ae
					gAgAamgAmrbIAagAgAbDgAm9bwALgAgAcygAnRcnACgAgAfEgAnfdSACgAgAg1gAnideADgAgAhRgAnideADgAgAhRgAnideADgAgAhR]],
				Jaw = [[
					gAnncL/9gAgAhggAntca/+gAgAg1gAn3dC/+gAgAfEgAn9dx/1gAgAc6gAn+eM/vgAgAb/gAnDbH7cgAgAwdgAmJZx8ugAgAuGgAmJZx+cgAgApzgAmJZx+F
					gAgAq4gAmQZ6+2gAgAoegAmraf/bgAgAl9gAnLbU/xgAgAjsgAnicA/7gAgAh8gAnncL/9gAgAhggAnncL/9gAgAhggAnncL/9gAgAhg]],
				["UpperArm.L"] = [[
					eblYdw2YOtgAu8eblTd32vOPettveblGeI3TNgbTqxebk4ea3aNdXhnsebkwek3SNwVgmJebk/dA4AOMb+qpebk9cG4cO7dTrQebk9cG4cO7dTrQebk9cG4c
					O7dTrQebk/cN4VO5dergeblGco31OzeMsgeblPdM3IOvfHtweblWdp2iOtf0useblYdw2YOtgAu8eblYdw2YOtgAu8eblYdw2YOtgAu8]],
				["LowerArm.L"] = [[
					d7kwdNuQ8fgAi8d6kwdQvH8Cihhod1kydbwt53ogeRdxk1dsxi2DuMasdwk2d4xpzgwxY4d4kpcSvs7rjMg4d7khbYt88YdhkLd7khbYt88YdhkLd7khbYt8
					8YdhkLd7kibgt98ZdskGd7kmb9uD8ceVjxd7krcluK8efMjWd7kvdFuO8ff1jCd7kwdNuQ8fgAi8d7kwdNuQ8fgAi8d7kwdNuQ8fgAi8]],
				["UpperArm.R"] = [[
					hllYdw2YxTgAu8hllTd32vxxhTtvhllGeI3Tygktqxhlk4ea3ayjofnshlkwek3SyQqgmJhlk/dA4Ax0kCqphlk9cG4cxFitrQhlk9cG4cxFitrQhlk9cG4c
					xFitrQhlk/cN4VxHiirghllGco31xNh0sghllPdM3IxRg5twhllWdp2ixTgMushllYdw2YxTgAu8hllYdw2YxTgAu8hllYdw2YxTgAu8]],
				["LowerArm.R"] = [[
					iFkwdNuQDhgAi8iGkwdQvHD+dfhoiLkydbwtGJXgeRiPk1dsxiJ9R0asiQk2d4xpMgPPY4iIkpcSvsEVc0g4iFkhbYt8DoifkLiFkhbYt8DoifkLiFkhbYt8
					DoifkLiFkibgt9DniUkGiFkmb9uDDkhrjxiFkrcluKDig0jWiFkvdFuODhgLjCiFkwdNuQDhgAi8iFkwdNuQDhgAi8iFkwdNuQDhgAi8]],
				Tail1 = [[
					gAkvh1eRgAgA/8gAkmh7ePgAgA/8gAkPiKeMgAgA/8gAj3iaeJgAgA/8gAjrijeIgAgA/7gAkwhIbFgAgA/ngAlQgMZ1fNgE/YgAlQgMbEfUgC/mgAlQgMbE
					gsf+/mgAlNgTbdhmf9/ogAlFgvczhXgB/zgAk6hTeHgPgB/7gAkxhuewfqf+/9gAkvh1edf4gA/9gAkvh1eRgAgA/8gAkvh1eRgAgA/8]],
				Tail2 = [[
					gAk3jAddgAgA/4gAkujGdDgAgA/2gAkYjVcCgAgA/vgAkAjla+gAgA/mgAj0juabgAgA/ggAlHiPY5gAgA/Mf8lshSZDeagG/Lf9lnhUbhepgC/pgDlnhUbh
					hXf+/pgHljhbcAjLf+/lgGlUh5dhiugG/xgBlDieengfgC/9f+k3i5eufVf8/9f/k2jAd1fwf//6gAk3jAddgAgA/4gAk3jAddgAgA/4]],
				Tail3 = [[
					gAlDkKdMgAgA/3gAk8kQcZgAgA/ygAkqkeacgAgA/ggAkYktYZgAgA/EgAkOk0XVgAgA+ygAlojTXQgAgA+xf1mMiWYzdngI/Ff2l8iccgd+gC/vgKl8iccg
					iCf+/vgWl1ijdHkwgA/ggTlgjCeykEgL/tgDlJjpfqgugE/+f7k9kEfPe/f5/9f+lAkLdxfof+/6gAlDkKdMgAgA/3gAlDkKdMgAgA/3]],
				Tail4 = [[
					gAlQlUcugAgA/0gAlNlabigAgA/rgAlEllYpgAgA/IgAk6lwVpgAgA+RgAk1l1UIgAgA9sgAmPkTVcgAgA+MfqmtjZYXc1gH+5ftmMjldTdTgA/wgTmMjldT
					itgA/wgsmDjqeBmTgG/TgmllkLf3lZgU/igHlLk0ggg9gG/+f2lBlPfjeqf2/9f8lLlVdefgf8/4gAlQlUcugAgA/0gAlQlUcugAgA/0]],
				Frag1 = [[
					gAlnmje5gAgA/+f8lomodkhqi1/uf7lpmwagirk7/Af9lpm1XqihmO+JgBlom3WfhOmz9wgFm9lZYCfVmQ+VffnSkiacbOkn+yfhmek0fZcVhl/vgemgkzfZ
					jreb/vhFmQkzfqolby+hg7lllUhVn8aR+bgKlCl+igibZT/Ffzk8mahseOZP/LgAlUmhfYdoat/dgEljmheweddH/zgAlnmje5gAgA/+]],
				Frag2 = [[
					f7l2qQdYhnmt/IgQmJqWcsiMps+Ogam6qUabiBq39fgPnmqIXvg9qg9Df4n2qAWDfcol9Kfio0otXDeck4+SeIodn5Z6cGgW/KelmmocfPfCbu/rhQmjoYeB
					l0X5+Vi7l+n6c9pIV68yikk3oaegnQVn9VgokVpbglhFWV+efaksp9gVdMY//FfhlpqFeDeCdd/xfrl9qIdOgKiV/yf7l2qQdYhnmt/I]],
				Omega = [[
					gAuccUJZgAgA2ngAugcpJrg9g+23gAufdeKYhsh13cgAubeXLJiFia4DgAuXe1LjiJij4XgAt8akIRiKh81QgAtKYMGghlhMzOgAtGYOGegkgbzQgAtCYPGe
					fcflzQgAtFYgGsecezzdgAtcZjHedxeK0UgAt5a8Igdjdx1cgAuNcCJSdvdx2TgAuUcUJdePeP2jgAuYcUJafCfC2mgAuccUJZgAgA2n]],
				Orbit1 = [[
					gAlPfxJZgAgA2ngAlJf4KJi9l92YgAk6gKMMlcr01fgAkqgdPDnVxUzjgAkignSPo72CwZgAlCfBUFt739qrgAlKeFYHxd47l9gAlKeFdVyQ6EiBgAlKeFir
					yQ6Ed/gAlLeMn2xO5FZ/gAlMeosUu13ZVzgAlOfNv0rw0qRlgAlPfqyeoswrN4gAlPfx0ql6rmLWgAlPfx2IjBl7J4gAlPfx2ngAgAJZ]],
				Orbit2 = [[
					gAlPfxJZgAgA2ngAlJf4L7bsbm4IgAk6gKPxX1XJ4ygAkqgdUXUlS14KgAkignZDR1PI2HgAlCfBbAM3O4yZgAlKeFe+JePCvDgAlKeFkgIdOQrigAlKeFp2
					IdOQnggAlLeMuyJpO0jBgAlMeoy8MOPodzgAlOfN10PuRKYKgAlPfq3aTkTzS6gAlPfx4HXeXeOygAlPfx35bpbpLpgAlPfx2ngAgAJZ]],
				["UpperLeg.L"] = [[
					eKi8gW7QeWgAwqeKi1ga8JeOfzvGeKikgj91d+fUrVeKiTgs/Gd1exnDeKiKgx/jdzebkieKizf24jedgX0ceKjHfRvEfthX8MeKjHfRvEfthX8MeKjHfRvE
					fthX8MeKjGfWvXfshX8BeKjCfnz1fKg/5EeKi+f/4jemgb0ceKi8gR6yeYgFxaeKi8gW7QeWgAwqeKi8gW7QeWgAwqeKi8gW7QeWgAwq]],
				["LowerLeg.L"] = [[
					eGh/f3tPhxgA9EeGh8f0sZh2gJ9beEh3fvrFiBgg98eDh2fvq0iNg6+AeCh3fwrOiThJ92eHhwfqpLhlf1+meMiOf3u9g5fK8QeMiOf3u9g5fK8QeMiOf3u9
					g5fK8QeMiMf6vRg6fL8FeKiAf3tZhOfa9BeIh7fzsHhjfw9keHh+f1s4hvf99OeGh/f3tPhxgA9EeGh/f3tPhxgA9EeGh/f3tPhxgA9E]],
				["Foot.L"] = [[
					eOhIgn8NgAgAvGeOhIgn8NgGf9vGeOhIgn8NgUf1vGeOhIgn8MgifuvGeOhIgn8MgqfqvGeOhIgn8Nf3gFvGeOhRgg51fUgpy1eOhRgg51fUgpy1eOhRgg51
					fUgpy1eOhPgi6hfRgmx3eOhIgn8MfcgTvGeOhIgn8NfzgHvGeOhIgn8Nf+gBvGeOhIgn8NgAgAvGeOhIgn8NgAgAvGeOhIgn8NgAgAvG]],
				["Toe.L"] = [[
					eOgsgU/9gAgAhgeOgsgU/+gEf6g+eOgsgU//gNftfseOgsgU/8gUffeVeOgsgU/5gXfXdneOgsgU/ff8gJaYeOgygW/vf8g8cLeOgygW/vf8g8cLeOgygW/v
					f8g8cLeOgwgW/rf3g8bpeOgsgU/lfvgla+eOgsgU/8f4gNeSeOgsgU/+f/gCg2eOgsgU/9gAgAhgeOgsgU/9gAgAhgeOgsgU/9gAgAhg]],
				["UpperLeg.R"] = [[
					h2i8gW7QhqgAwqh2i1ga8JhygNvGh2ikgj91iCgsrVh2iTgs/GiLhPnDh2iKgx/jiNhlkih2izf24jhjfp0ch2jHfRvEgTep8Mh2jHfRvEgTep8Mh2jHfRvE
					gTep8Mh2jGfWvXgUep8Bh2jCfnz1g2fB5Eh2i+f/4jhafl0ch2i8gR6yhof7xah2i8gW7QhqgAwqh2i8gW7QhqgAwqh2i8gW7QhqgAwq]],
				["LowerLeg.R"] = [[
					h6h/f3tPePgA9Eh6h8f0sZeKf39bh8h3fvrFd/fg98h9h2fvq0dzfG+Ah+h3fwrOdte392h5hwfqpLebgL+mh0iOf3u9fHg28Qh0iOf3u9fHg28Qh0iOf3u9
					fHg28Qh0iMf6vRfGg18Fh2iAf3tZeygm9Bh4h7fzsHedgQ9kh5h+f1s4eRgD9Oh6h/f3tPePgA9Eh6h/f3tPePgA9Eh6h/f3tPePgA9E]],
				["Foot.R"] = [[
					hyhIgn8NgAgAvGhyhIgn8Nf6gDvGhyhIgn8NfsgLvGhyhIgn8MfegSvGhyhIgn8MfWgWvGhyhIgn8NgJf7vGhyhRgg51gsfXy1hyhRgg51gsfXy1hyhRgg51
					gsfXy1hyhPgi6hgvfax3hyhIgn8MgkftvGhyhIgn8NgNf5vGhyhIgn8NgCf/vGhyhIgn8NgAgAvGhyhIgn8NgAgAvGhyhIgn8NgAgAvG]],
				["Toe.R"] = [[
					hygsgU/9gAgAhghygsgU/+f8gGg+hygsgU//fzgTfshygsgU/8fsgheVhygsgU/5fpgpdnhygsgU/fgEf3aYhygygW/vgEfEcLhygygW/vgEfEcLhygygW/v
					gEfEcLhygwgW/rgJfEbphygsgU/lgRfba+hygsgU/8gIfzeShygsgU/+gBf+g2hygsgU/9gAgAhghygsgU/9gAgAhghygsgU/9gAgAhg]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAkqhAAGgAgAiUgAklhAAFgAgAh6gAkYhAACgAgAg+gAkOhAABgAgAgNgAkQhAABgAgAgWgAknhAAIgAgAiugAk0hAAYgAgAkwgAk1hAAbgAgAlFgAk1hAAb
					gAgAlFgAk1hAAbgAgAlFgAk1hAAbgAgAlFgAk1hAAbgAgAlFgAk1hAAbgAgAlFgAk1hAAbgAgAlFgAk1hAAbgAgAlFgAk1hAAbgAgAlFgAk1hAAbgAgAlFgA
					k1hAAagAgAlCgAkxhAASgAgAkEgAkshAAJgAgAiwgAkqhAAGgAgAiUgAkqhAAGgAgAiUgAkqhAAGgAgAiU]],
				Spine1 = [[
					gAkxgUAhgAgAlmgAkqgUAagAgAlCgAkbgUAPgAgAjwgAkPgUAIgAgAitgAkRgUAJgAgAi5gAkugUAngAgAmKgAlBgWBSgAgAo8gAlDgWBbgAgApZgAlDgWBb
					gAgApZgAlDgWBbgAgApZgAlDgWBbgAgApZgAlDgWBbgAgApZgAlDgWBbgAgApZgAlDgWBbgAgApZgAlDgWBbgAgApZgAlDgWBbgAgApZgAlDgWBbgAgApZgA
					lDgWBagAgApUgAk8gVBCgAgAoAgAk0gUAogAgAmNgAkxgUAhgAgAlmgAkxgUAhgAgAlmgAkxgUAhgAgAlm]],
				Spine2 = [[
					gAlPfBBPgAgAowgAlFfABDgAgAoDgAkwe+ArgAgAmdgAkee9AcgAgAlJgAkhe9AegAgAlYgAlQfDBdgAgApegAlwfLCvgAgAs5gAl1fNC/gAgAtdgAl1fNC/
					gAgAtdgAl1fNC/gAgAtdgAl1fNC/gAgAtdgAl1fNC/gAgAtdgAl1fNC/gAgAtdgAl1fNC/gAgAtdgAl1fNC/gAgAtdgAl1fNC/gAgAtdgAl1fNC/gAgAtdgA
					l0fNC8gAgAtXgAlnfICQgAgArwgAlVfDBegAgAphgAlPfBBPgAgAowgAlPfBBPgAgAowgAlPfBBPgAgAow]],
				Neck1 = [[
					gAlnebDwgAgAvAgAlceZDDgAgAtngAlBeUBvgAgAqWgAkseSA8gAgAnngAkweSBEgAgAoGgAlpedEIgAgAvsgAmSetH6gAgA1CgAmXewImgAgA1zgAmXewIm
					gAgA1zgAmXewImgAgA1zgAmXewImgAgA1zgAmXewImgAgA1zgAmXewImgAgA1zgAmXewImgAgA1zgAmXewImgAgA1zgAmXewImgAgA1zgAmXewImgAgA1zgA
					mXevIfgAgA1rgAmGenGmgAgAzcgAlvedEZgAgAwJgAlnebDwgAgAvAgAlnebDwgAgAvAgAlnebDwgAgAvA]],
				Neck2 = [[
					gAmmdwGUgAgAzEgAmWdoFIgAgAxWgAlwdZC4gAgAtPgAlPdPBhgAgApsgAlVdQBvgAgAqVgAmqd2G9gAgAz5gAndeiNRgAgA57gAnjeqOYgAgA6sgAnjeqOY
					gAgA6sgAnjeqOYgAgA6sgAnjeqOYgAgA6sgAnjeqOYgAgA6sgAnjeqOYgAgA6sgAnjeqOYgAgA6sgAnjeqOYgAgA6sgAnjeqOYgAgA6sgAnjeqOYgAgA6sgA
					niepOMgAgA6kgAnPeTLGgAgA4NgAmxd4HZgAgA0cgAmmdwGUgAgAzEgAmmdwGUgAgAzEgAmmdwGUgAgAzE]],
				Head = [[
					gAnideADgAgAhRgAnQdOAEgAgAeRgAmgcvBKgAgAXkgAl0cbDEgAgASZgAl8ceCqgAgATSgAnodoAKgAfpjAgAoZe2D9gYfKvWgAodfDEKfMhwvogAodfDE1
					gQfhw4gAodfDFJgtetxTgAodfDEMfQhnvtgAodfDErgAgAwngAodfDFQg2ecxcgAodfDERfYhVv3gAodfDEgfwggwVgAodfDFTg7eTxhgAodfDEYfjg9wFgA
					odfBEOfkg8v0gAoOecCVgXe1r5gAnvdtAPgAgGjxgAnideADgAgAhRgAnideADgAgAhRgAnideADgAgAhR]],
				Jaw = [[
					gAnncL/9gAgAhggAnFb8/ogAgAkzgAl0bo9pgAgAsBgAkzbn61gAgAxagAk+bm7ZgAgAwggCn2cW/jf6gWlTgFpeeI/+fQgkgPf2pjeX/4hoe9hxgDpned//
					figSgWgIpoeg/9euguf0f3pjeX/5hgfDhrgApmec//gAgAgqgJpoeh/8edg3fpf4pkeY/7hQfNhgf9plea/+gefug+gKpoeh/7eUg8fjf7pleZ/8g5fchRf7
					pjeW/8g4fchRgGpGdf/9fOg8gRgAoBcc/9gBf7hagAnncL/9gAgAhggAnncL/9gAgAhggAnncL/9gAgAhg]],
				["UpperArm.L"] = [[
					eblYdw2YOtgAu8eblLdv2cOtf8u3ebktdt2iOtf0usebkUds2oOtfuukebkYds2nOtfuuleblddy25NIa5qzebmPeA1tNtSJlCebmXeD1LOaQMj5ebmXeD1L
					OaQMj5ebmXeD1LOaQMj5ebmXeD1LOaQMj5ebmXeD1LOaQMj5ebmXeD1LOaQMj5ebmXeD1LOaQMj5ebmXeD1LOaQMj5ebmXeD1LOaQMj5ebmXeD1LOaQMj5eb
					mVeC1ROSQhkFebmAd62fM7WMnkeblidy2uNydutCeblYdw2YOtgAu8eblYdw2YOtgAu8eblYdw2YOtgAu8]],
				["LowerArm.L"] = [[
					d7kwdNuQ8fgAi8d7kjdMuQ8fgGi5d7kFdJuS8fgTizd7jtdIuT8fgeitd7jxdIuT8fgdiud0lKdGxW5/mve5drmhdcz1yVu/Xrdqmudlz9wHwTWAdqmudlz9
					wHwTWAdqmudlz9wHwTWAdqmudlz9wHwTWAdqmudlz9wHwTWAdqmudlz9wHwTWAdqmudlz9wHwTWAdqmudlz9wHwTWAdqmudlz9wHwTWAdqmudlz9wHwTWAdq
					msdjz8wfwGWSdvmCdPzG2VrpbEd4lDdKv27ljLhLd7kwdNuQ8fgAi8d7kwdNuQ8fgAi8d7kwdNuQ8fgAi8]],
				["UpperArm.R"] = [[
					hllYdw2YxTgAu8hllLdv2cxTgEu3hlktdt2ixTgMushlkUds2oxTgSukhlkYds2nxTgSulhllddy25y4lHqzhlmPeA1tyTt3lChlmXeD1Lxmv0j5hlmXeD1L
					xmv0j5hlmXeD1Lxmv0j5hlmXeD1Lxmv0j5hlmXeD1Lxmv0j5hlmXeD1Lxmv0j5hlmXeD1Lxmv0j5hlmXeD1Lxmv0j5hlmXeD1Lxmv0j5hlmXeD1Lxmv0j5hl
					mVeC1RxuvfkFhlmAd62fzFp0nkhllidy2uyOiStChllYdw2YxTgAu8hllYdw2YxTgAu8hllYdw2YxTgAu8]],
				["LowerArm.R"] = [[
					iFkwdNuQDhgAi8iFkjdMuQDhf6i5iFkFdJuSDhftiziFjtdIuTDhfiitiFjxdIuTDhfjiuiMlKdGxWGBZRe5iVmhdcz1NrRBXriWmudlz9P5PtWAiWmudlz9
					P5PtWAiWmudlz9P5PtWAiWmudlz9P5PtWAiWmudlz9P5PtWAiWmudlz9P5PtWAiWmudlz9P5PtWAiWmudlz9P5PtWAiWmudlz9P5PtWAiWmudlz9P5PtWAiW
					msdjz8PhP6WSiRmCdPzGJrUXbEiIlDdKv2Ebc1hLiFkwdNuQDhgAi8iFkwdNuQDhgAi8iFkwdNuQDhgAi8]],
				Tail1 = [[
					gAkvh1eRgAgA/8gAkrh1eKgAgA/8gAkhh0d7gAgA/7gAkah0dvgAgA/6gAkbh0dxgAgA/6gAkqh1eOfxf//8gAkwh1egfaf+/8gAkxh1eihPgF/7gAkxh1ei
					fpf//9gAkxh1eifDf8/8gAkxh1eihJgF/8gAkxh1eigAgA/9gAkxh1eie3f7/8gAkxh1eig9gE/8gAkxh1eigXgB/9gAkxh1eiexf7/7gAkxh1eigrgD/8gA
					kxh1eigqgD/8gAkwh1ecfOf9/8gAkvh1eTgEgA/8gAkvh1eRgAgA/8gAkvh1eRgAgA/8gAkvh1eRgAgA/8]],
				Tail2 = [[
					gAk3jAddgAgA/4gAkzjAdqgAgA/5gAkri/eIgAgA/7gAkki+eggAgA/9gAkmi/ecgAgA/9f/kyjAc+f7f//2f9k3jAbgeUf5/ogGk4jAbPh0gO/lf+k3jAbP
					gbf9/of8k4jAbPd2f1/jgFk4jAbPhYgM/mgAk3jAbPhBgB/nf7k4jAbPdyfz/jgEk4jAbPg1gK/ngCk3jAbPhigF/mf6k4jAbPd6fy/kgDk3jAbPgOgH/ogD
					k3jAbSh5gI/lf8k3jAcDe3f4/ugAk3jAdGf8gA/3gAk3jAddgAgA/4gAk3jAddgAgA/4gAk3jAddgAgA/4]],
				Tail3 = [[
					gAlDkKdMgAgA/3gAk+kKdtgAgA/6gAk0kKe4gAgA/+gAkrkJf1gAgA//gAktkKfqgAgA//f/lBkKcSgVgB/xf1lMkIZFdofy/JgOlOkHYhhPga/FgAlOkIYh
					hrf6/DfylOkHYidYfr+/gMlOkIYhgggX/GgFlOkIYiiNgC/BfwlOkHYidrfn/BgIlOkIYhfvgT/GgJlOkIYiijgJ/AfxlOkHYheJfm/DgElOkIYhe/gN/FgM
					lNkHYoipgP/Af3lKkJaPfOf0/dgAlFkKcdfvf//ygAlDkKdMgAgA/3gAlDkKdMgAgA/3gAlDkKdMgAgA/3]],
				Tail4 = [[
					gAlQlUcugAgA/0gAlJlVdjgAgA/5gAk5lVfbgAgA//gAkslVg8gAgA/+gAkvlVgrgAgA//gAlSlTbXgqgD/pfrlslLWgd8fk+egTlwlKVrf+gr+RgIlwlLVr
					iYf/+LfmlwlJVreEfW+NgOlwlLVrfPgk+QgPlwlKVqilgM+KfmlwlJVreofS+PgHlwlLVrekga+PgUlwlKVqikgY+KfplwlKVrfTfS+Qf/lwlLVreBgO+NgY
					lvlKVziTgh+Of0lllPYOgAfv/Bf/lVlUblfof+/rgAlQlUcugAgA/0gAlQlUcugAgA/0gAlQlUcugAgA/0]],
				Frag1 = [[
					gAlnmje5gAgA/+f9lbmmfphFiC/6f7lAmohWhjj+/rf7knmoithSli/Xf8kmmoidgpmf/OgClimldmhUm2/IfimUmUYceemk+WgWmcmQYTfmnK+NgZmemNYl
					hMlV+ofjmimLXycyjk+igMmlmKX1eeix+xgammmGXvilgB+zfemmmEX9fZdP+1f6mjmGYLf4cd+0gamgmGXzjrao+OfimcmHYcfsY3+Qf1mYmIYedYZi+Tgj
					mWmIXcgZZx+Lf4mCmUaIdrZq+tgClnmedfddaw/WgFlgmgeqeHcL/rgDlkmie0e3eA/4gAlnmje5gAgA/+]],
				Frag2 = [[
					f7l2qQdYhnmt/IgKldqVedhspB+mgWknqXgjgpqi+Mgaj7qWiQfDrB97gUkAqZiLd0qm+BgUmKqYdZe3px+Ve4oApuX0cpn59tf2oPpoXaeYmf+FgVoTplXX
					hCiq+qeioXpVXOdfe6+pflobpXXUfpcv+ng6ocpSWyjiZR9rfcoVpTXtfzWR9UgDoLpVXefSV59Hhgn/pLV/h+VS8Xf4n9pVW9djUr8afroCpSXKbHW087hF
					oIpLWAeqY99hftnepmY1dHab+ifmmXp+cKd9dX/lfql+qGdOfggl/3fvl7qLdPgtj0/of7l2qQdYhnmt/I]],
				Omega = [[
					gAuccUJZgAgA2ngAuVcEJGgrgq2UgAt5bgIfhVhO1ngAtebDIBh6hr1AgAthbIIJiSiB1FgAv4dkJyiUiY2ygAyQg5LTiKih4KgAynhmLih9iV4ZgAylhmLg
					hoh84bgAymhmLehKhZ4egAyqhnLdgngu4fgAywhoLcgAgA4ggAy2hpLdfZfS4fgAy6hpLee2en4egAy6hqLgeYeE4bgAy4hpLieDdr4ZgAyzhoLjd4de4YgA
					yohfLhd4de4VgAxNffKxd+dv3ugAvDdDJxePeM23gAuScUJbeueu2lgAuWcUJZfVfV2ngAuccUJZgAgA2n]],
				Orbit1 = [[
					gAlPfxJZgAgA2ngAlHfwKBkMn+1bgAk2fuMMogvEyNgAkoftQQsY0xtzgAkrftWDuy5EozgAlOfyc1uB8ZjRgAlkf4i+sL9OcjgAlnf5ojq66+V1gAlnf5te
					pE2aP9gAlnf5xTmfwCLZgAlnf5zujYoXIfgAlnf50kgAgAHggAlnf5zucoXpIfgAlnf5xTZhP+LZgAlnf5teW8JmP9gAlnf5ojVGFCV1gAlnf5i7UJCpchgA
					lnf5dEUGCrjfgAlef2XJUPFZp5gAlTfyRZVVKUvBgAlPfxM+YKQmzCgAlPfxKTb6X+1tgAlPfxJZgAgA2n]],
				Orbit2 = [[
					gAlPfxJZgAgA2ngAlHfwMYaBaL31gAk2fuQkUMVK2+gAkoftWNPJRP0ngAkrftdQLyOJw+gAlOfylULgK/rjgAlkf4r+M5JukRgAlnf5w5OqLVc1gAlnf50a
					RmO1VygAlnf52QVsTuPjgAlnf52UaoZmKqgAlnf50kgAgAHggAlnf5xJlYmaGVgAlnf5sVqUsSHOgAlnf5miuaxLKJgAlnf5gMxW0rO0gAlnf5Z2y42fU5gA
					lnf5UAy62db2gAlef2PByA0GiogAlTfyK6vowEotgAlPfxIZrWrWudgAlPfxH6l6l6zUgAlPfxJZgAgA2n]],
				["UpperLeg.L"] = [[
					eKi8gW7QeWgAwqeKi1gZ8EeNfyvQeKingg9fd7fTsMeKibgl+Ydve3preKidgk+Pdxe8qIeKi5gT7PeVgBwseKjNgG2xfBg62beKjQgE1UfOhI30eKjQgE1U
					fOhI30eKjQgE1UfOhI30eKjQgE1UfOhI30eKjQgE1UfOhI30eKjQgE1UfOhI30eKjQgE1UfOhI30eKjQgE1UfOhI30eKjQgE1UfOhI30eKjQgE1UfOhI30eK
					jPgE1ofLhF3ieKjIgK4hexgn0feKi/gT6secgJxjeKi8gW7QeWgAwqeKi8gW7QeWgAwqeKi8gW7QeWgAwq]],
				["LowerLeg.L"] = [[
					eGh/f3tPhxgA9EeGh8f0sXh5gI9ceEh3fvq9iKgZ9+eDh0ftqUiYgo+LeDh0ftqZiWgl+KeGh9f0sihvgC9YeKiJgFwihNfp7WeLiMgLx3hFfj6heLiMgLx3
					hFfj6heLiMgLx3hFfj6heLiMgLx3hFfj6heLiMgLx3hFfj6heLiMgLx3hFfj6heLiMgLx3hFfj6heLiMgLx3hFfj6heLiMgLx3hFfj6heLiMgLx3hFfj6heL
					iLgKxkhHfk6teJiFf+vDhYfx8MeHiAf4thhrf888eGh/f3tPhxgA9EeGh/f3tPhxgA9EeGh/f3tPhxgA9E]],
				["Foot.L"] = [[
					eOhIgn8NgAgAvGeOhIgn8NgIf8vGeOhIgn8NgbfyvGeOhIgn8MgqfpvGeOhIgn8MgnfrvGeOhIgn8Nf/gAvGeOhIgn8MfcgTvGeOhIgn8MfUgXvGeOhIgn8M
					fUgXvGeOhIgn8MfUgXvGeOhIgn8MfUgXvGeOhIgn8MfUgXvGeOhIgn8MfUgXvGeOhIgn8MfUgXvGeOhIgn8MfUgXvGeOhIgn8MfUgXvGeOhIgn8MfUgXvGeO
					hIgn8MfWgXvGeOhIgn8NfngNvGeOhIgn8Nf6gDvGeOhIgn8NgAgAvGeOhIgn8NgAgAvGeOhIgn8NgAgAvG]],
				["Toe.L"] = [[
					eOgsgU/9gAgAhgeOgsgU/9gGf4hgeOgsgU/9gSfohgeOgsgU/8gcfZhgeOgsgU/8gafchgeOgsgU/9f/gBhgeOgsgU/8foghhgeOgsgU/8fjgohgeOgsgU/8
					fjgohgeOgsgU/8fjgohgeOgsgU/8fjgohgeOgsgU/8fjgohgeOgsgU/8fjgohgeOgsgU/8fjgohgeOgsgU/8fjgohgeOgsgU/8fjgohgeOgsgU/8fjgohgeO
					gsgU/8fkgnhgeOgsgU/9fvgXhgeOgsgU/9f8gFhgeOgsgU/9gAgAhgeOgsgU/9gAgAhgeOgsgU/9gAgAhg]],
				["UpperLeg.R"] = [[
					h2i8gW7QhqgAwqh2i1gZ8EhzgOvQh2ingg9fiFgtsMh2ibgl+YiRhJprh2idgk+PiPhEqIh2i5gT7Phrf/wsh2jNgG2xg/fG2bh2jQgE1Ugye430h2jQgE1U
					gye430h2jQgE1Ugye430h2jQgE1Ugye430h2jQgE1Ugye430h2jQgE1Ugye430h2jQgE1Ugye430h2jQgE1Ugye430h2jQgE1Ugye430h2jQgE1Ugye430h2
					jPgE1og1e73ih2jIgK4hhPfZ0fh2i/gT6shkf3xjh2i8gW7QhqgAwqh2i8gW7QhqgAwqh2i8gW7QhqgAwq]],
				["LowerLeg.R"] = [[
					h6h/f3tPePgA9Eh6h8f0sXeHf49ch8h3fvq9d2fn9+h9h0ftqUdofY+Lh9h0ftqZdqfb+Kh6h9f0sieRf+9Yh2iJgFwiezgX7Wh1iMgLx3e7gd6hh1iMgLx3
					e7gd6hh1iMgLx3e7gd6hh1iMgLx3e7gd6hh1iMgLx3e7gd6hh1iMgLx3e7gd6hh1iMgLx3e7gd6hh1iMgLx3e7gd6hh1iMgLx3e7gd6hh1iMgLx3e7gd6hh1
					iLgKxke5gc6th3iFf+vDeogP8Mh5iAf4theVgE88h6h/f3tPePgA9Eh6h/f3tPePgA9Eh6h/f3tPePgA9E]],
				["Foot.R"] = [[
					hyhIgn8NgAgAvGhyhIgn8Nf4gEvGhyhIgn8NflgOvGhyhIgn8MfWgXvGhyhIgn8MfZgVvGhyhIgn8NgBgAvGhyhIgn8MgkftvGhyhIgn8MgsfpvGhyhIgn8M
					gsfpvGhyhIgn8MgsfpvGhyhIgn8MgsfpvGhyhIgn8MgsfpvGhyhIgn8MgsfpvGhyhIgn8MgsfpvGhyhIgn8MgsfpvGhyhIgn8MgsfpvGhyhIgn8MgsfpvGhy
					hIgn8MgqfpvGhyhIgn8NgZfzvGhyhIgn8NgGf9vGhyhIgn8NgAgAvGhyhIgn8NgAgAvGhyhIgn8NgAgAvG]],
				["Toe.R"] = [[
					hygsgU/9gAgAhghygsgU/9f6gIhghygsgU/9fugYhghygsgU/8fkgnhghygsgU/8fmgkhghygsgU/9gBf/hghygsgU/8gYffhghygsgU/8gdfYhghygsgU/8
					gdfYhghygsgU/8gdfYhghygsgU/8gdfYhghygsgU/8gdfYhghygsgU/8gdfYhghygsgU/8gdfYhghygsgU/8gdfYhghygsgU/8gdfYhghygsgU/8gdfYhghy
					gsgU/8gcfZhghygsgU/9gRfphghygsgU/9gEf7hghygsgU/9gAgAhghygsgU/9gAgAhghygsgU/9gAgAhg]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAkqhAAGgAgAiUgAklhAAGgDgriGgAkChAAEgNhlgpgAlAhAANgFhmjFgAlphAAXgAg/kmgAl2hAAbgAgAlFgAlphAAXgAfBkmgAlAhAANf7eajFgAkBhAAE
					fzebgogAkRhAAEf5fBhTgAkNhAACgAgAhHgAlVhAARgBg/j3gAlxhAAcf/hmk6gAl0hAAdf/hmlAgAlchAATgBg/kJgAkghAAEgAgAh2gAkNhAADf5fBhHgA
					kphAAJf5eaiSgAkqhAAIf6e0iUgAkqhAAGf/fwiUgAkqhAAGgAgAiU]],
				Spine1 = [[
					gAkxgUAhgAgAlmf+krgUAdgIgrlRf8kDgUANgUhkjGf8lIgVAvgQhlmif9l1gWBMgIg+oggAmEgWBWgAgApIgDl1gWBMf4fCoggElIgVAvfwebmigEkDgUAN
					fsecjGgDkVgUATf0fCkFgAkQgUAPgAgAjzf9lfgVA8gJg+nkf8l/gWBUgMhlo5f8mCgWBXgMhlpBf9logVBCgIg+n7gAklgUAZgAgAk1gDkQgUAQf0fCjzgE
					kwgUAjfuecljgDkxgUAifze1lmgBkxgUAhf9fwlmgAkxgUAhgAgAlm]],
				Spine2 = [[
					gAlPfBBPgAgAowf7lHfBBIgMgqoVfzkVe+AigchilffzlsfEBngbhip2f4mjfKCdgPg9sOgAm0fMCwgAgAs9gImjfKCdfxfDsOgNlsfEBnfleep2gNkUe+Ai
					fkeelegIkre/AwfvfDmxgAkle+AqgAgAmaf4mIfHCBgQg9rGf0mufMCrgZhjsrf0mxfMCvgZhjs0f4mSfICMgQg9rigAk/fAA+gAgAnugIkle+ArfvfDmagN
					lOfCBQfkeeosgJlPfCBQfre2owgClPfBBPf8fxowgAlPfBBPgAgAow]],
				Neck1 = [[
					gAlnebDwgAgAvAf5leeaDbgUgnuWfvkkeTBngphdp2fwmGegEtgxhawlf2nDeqHCggg2z+gAnWeuH2gAgA0+gKnDeqHCfgfKz+gQmGegEtfPemwlgRkkeTBn
					fXejp1gKk+eVCVflfHr6gAk3eUCGgAgArVf2mlelF3gfg3yafwnPetHlg0hY0lfwnTeuHvg0hX0yf2mxenGUgfg3zCgAlVeYC9gAgAtYgKk3eVCHflfHrVgQ
					lmebDvfQemu5gMlnebDxfce8u/gDlnebDwf5fyvAgAlnebDwgAgAvA]],
				Neck2 = [[
					gAmldwGUgAgAzEf3mbdsF5gagjyefqlQdWDbg3hWuSfsnJd9Hfg9hR0ff0oMeZKUgogx3fgAohejLRgAgA4WgMoMeZKUfYfP3fgUnJd9HffDev0fgWlQdWDb
					fJequRgNlydfEdfdfMwOgAlpdcEIgAgAvrf0nteLI7gngx2HftoZegK7hBhP4BfuodeiLIhBhP4Lf0n5eRJdgngx2qgAmOdnFSgAgAxlgOlpdcEJfdfMvrgV
					mkdxGSfDeuy9gQmmdxGVfSfDzDgDmmdwGUf3fzzEgAmmdwGUgAgAzE]],
				Head = [[
					gAnideADgAgAhRf2nXdXAIeegtiIfmmDcwAWcZiHeIfqoIdyAtcghQlef0pMeeBgd6gfpYgApgetB0gAgAqkgMpMeeBgiGfhpYgWoIdyAtjgewlegamDcwAW
					jnd5eGgPmqdAAHiOe2gLgAmfc7ABgAgAfffzoseIA/d4gnngftpYeoB5cqgrqOftpcerB+crgpqef0o4eRBLd5gkoPgAnIdNAEgAgAhtgPmfc7AIiOezfjgX
					nhdeAcjieijkgRnidfATire2jCgDnideAFgkfvh1gAnideADgAgAhR]],
				Jaw = [[
					gAnncL/9gAgAhgfyngcF/ThqfvmYfdl3bf9HkHfQskfhoicj/SjugClifvp5dZ/4iIgRhmgAqSdr//gAgAgYgRp5dZ/4d4fvhmgfoicj/ScSf+ligjl2bf9H
					b5gxsmgVmpbt+CdhgVqugAmbbo94gAgArafupQc+/uiOgJjiflqJdm/zjYghgrflqOdp/zjXgigbfupgdI/yiMgMiygAnQb7+ngAgApTgVmbbp90dggYrTgg
					nxcN+4cLgLnbgYnwcN/TdHgXl8gFnqcL/1fagLjBgAnncL/9gAgAhg]],
				["UpperArm.L"] = [[
					eblYdw2YOtgAu8eSlOd01OMGY4rOeGkOd30HMIUUpXeHl6d/1jQPOjiZeOm9eE1uO0QlkSebnUeB1TMmT/m9eom/d32dOZR5jGewl7dr3GP+QxgvewkLdj1X
					LgWeneeokqdnzvKRYyqdebkidt1AMHUyn0eOmdd/16Q4OUhKeHnKeK1hPMP6kUeHnOeL01NGTGoFeOmpeB1oOfQ/kyeblDdu2MO/QyjHeokhdn1YL8VdnOew
					lXdn0iKoX3o1erlYdp2iMVXendeelYdv2zNbdDsNeblYdw2YOtgAu8]],
				["LowerArm.L"] = [[
					d7kwdNuQ8fgAi8dllDdLzf32oOdWdTkTdU1Z2llnbFdUmVdmy+21nBWWddnSdlz50uq1XBdrneda0QzUuAZYd7nUdTzY1EsGYZeEmXdJyS3lo6YseFkQc30g
					3LnpdSd7kkc90112qdeRdrkpdF032snTbkddm6dnyf2poVWBdUnfduz50bqwWSdUnXdp0yzNs2Yaddm9dh0F0/qWXedrladOzM3umWY0d7koc90k24n8cQeF
					lWc70a1QsKdXeBlYc7zL4On9dnd6k9dEwM7ehlh8d7kwdNuQ8fgAi8]],
				["UpperArm.R"] = [[
					hllYdw2YxTgAu8hclOdr3Fy5pbmthQkMdj1X0fpjnehQl7dr041Co7oEhYm/d32dxnuHjGhlnUeB2ZuJx7fQhym9eE1uxMvbkSh5l6d/0A0Cq7qKh6kNd30G
					z4rrpXhykrd01lxZvYkThlkidt1Az5rOn0hYmedy1F0bqKnnhQnNd22uxft+iYhQnSd33IuWwwefhYmrd02Yx8ttjnhllDduzy1Mofqhhykidz0mzsr4oZh5
					lXd71dwZw2jPh1lYd511zEqMo6holYdy2fydi6s/hllYdw2YxTgAu8]],
				["LowerArm.R"] = [[
					iFkwdNuQDhgAi8iGlRc+ysGkbWd6h7kQc30gI1YWdSh7l9c+0RLMTDcliFnUdTzYK8T6YZiVn0dqxrJuVrVoijnSdlz5LSVLXBisl8dc1WLjVJaeitkTdU1a
					JbaabGijlAdVznIWa+YsiVkpdF03JUYtbkiFmkdI0SLxSmbUh8nkdRzELDTMYhh9nzdcxYJWU0W5iFm/dOzjKsUZY2iVlAdH1GKkVic+ikkqdP1IJgZVa5is
					lwdhzSI6Z4XDiklYdRzuICZgb0iNk7dJwYEzcOgjiFkwdNuQDhgAi8]],
				Tail1 = [[
					gAkvh1eRgAgA/8gCkqh1eSkagM/ogFkMh0eUn4fn+9gFlCh1eFjpgZ/ugDlmh1d0dIfY/xgAlyh1dwZjeY/Nf9lmh1d1bNe+/if7lCh1eEgegD/7f7kLh0eS
					kwfx/lf9kZh0eSkbf9/ogAkVh0eRgAgA/8gDlUh1d+bpfS/ngFlth1dxbYe5/jgFlwh1dufif5/6gDlbh1d7k1g5/igAkmh1ePmpgM/Pf9kVh0eRi9f8/zf7
					kuh1eRcWf0/vf8kvh1eTaFfr/Yf/kvh1eReaf6/5gAkvh1eRgAgA/8]],
				Tail2 = [[
					gAk3jAddgAgA/4gXkyi9dtlrgX/ZgpkTi2fXtxfl83gWlLi+capAhK+df2lwi+aSdafG/Wfjl9i5ZzU0cv9Jfnlxi8adVNdh9ff9lLjAcTeOf2/ugRkTi7fO
					obfv+2gRkhi8enq6gQ+CgAkei/erkGgL/sfvlei9bVZ5es/Bfwl4i8aBVhdY9ggDl6i/ZyaIe7+zgZlli8a8khhU/Pgfkui5d9rtgm9sgLkei+ewpQgL+mfq
					k2i+dfenf5/3fhk3i6djXWfU+sf4k3i/decvfv/ugAk3jAddgAgA/4]],
				Tail3 = [[
					gAlDkKdMgAgA/3gxk9kDdpkAgO/phkkVjlg3w4fR7Kg+ldj7bevGh/7xfrmLkEXehxfL+xe2mdjtWkTuba7ne6mNjyX7P5cM6Jf1lckIbMYqfU+wg3kXj8gl
					oAfV+9hCkoj2fjvlgb78gTkkkIfsqYgn+QfUl0kAZTcaef/CfFmWjyXBSjcF7UfpmXkAWxT5d48Dgtl9kBYpgKhU/GhSk4jweKtPgs9Eg0kjj8f4u+gb8Rfj
					lCkIdRkPgY/le6lDj6dSXqfR+wfplDkIdObefm/igAlDkKdMgAgA/3]],
				Tail4 = [[
					gAlQlUcugAgA/0hDlIlLdVgDf0/4inkPkGh0wTej7bh6l0kiagzNi540f0mxlEU6oSfa81eKnMkVTdW1Z67SeAm1kNVdNiar3TfUlzlIaISbel8VhckTk+hf
					jreX/tiCkrkegHw1gW7NhBkmlDgkv7hM7ufFmUlCXSiSed+qeUnCkXT/Tpal6Ze6nBkpT9Pwcp4jgsmflEWhZkhH92iKlCkhd9qygc+Dhzklkngtx3gi6hf3
					lPlPc/qqhH9/eUlQk6cwa5fe/afUlQlQcwbHfg/cgAlQlUcugAgA/0]],
				Frag1 = [[
					gAlnmje5gAgA/+hBlcmcfchOiC/5jukGkzlsxFha6ajFmSk6fX1AmF3Vganhl+Ylqtk380dpoHlFTcYig58cc/nnkdTcOHhi3TeZmMl+aHRDk37OhzkJmNkK
					gtht/qjNkuk/jEvZg073iHktlticv9gH7nfPnDmDZcjKcA+5droAkyYDULXf7WeCn0k0ZGQBY454gMnDl9aMZ9bA+di5lEladrq/ZN9Li5kdk/egxUZ76Kgq
					lamGczowbK+NeBlgmDfUY/bs+5e/lkmafKZ5dp/TgAlnmje5gAgA/+]],
				Frag2 = [[
					f7l2qQdYhnmt/IhQlgqLeThypB+mnGjDmJoMu7nQ6GmwnPlWirzOqk3IijpcogZkpFpI8kcCqxnYSQXPjS7UZwpqktSyNFhU2GbIm7n0aJQuid7Xh9jQp5jA
					i3eD/qmVkPnBfvx8cv6SlRkNnmepycbM5qgEoXpXYZjuVQ86bzqKm/Z5TsRg4+bcpxmVa1OzT23hfJobpFZfX4XC84lTk/oDbVpUXq9EmKkCmZdQwbaf6wiq
					l5pDcTo5dh+Zcfl+pUdRaKff/Vdkl7pxcubujC/Yf7l2qQdYhnmt/I]],
				Omega = [[
					gAuccUJZgAgA2nfzuZcMJRhOhN2cfitbbVIYipiY1RfivKc1KJi9jH29fuwFdzLPiujJ3+gAwTeGLjiKik4YgSv5dxLHhchq4Igeu1c0J9gxg03JgetGbXIP
					gSgQ1ZgStpbuIrgCgC15gAtmbmIjgAgA1wfuvndUKhf+f+3sfiwWeBLTfwfu4YfiwaeFLZfSfJ4cfuvzdgKxeieX31gAuJcCJMdndr2KgStgbnIwc9dL1kge
					uQcVJkc+c+2ZgWuScVJgdxdx2ggFuWcUJafGfG2mgAuccUJZgAgA2n]],
				Orbit1 = [[
					gAlPfxJZgAgA2nf9lJfxKilApP1Rf4kefuNqqWxIw6f4lof0UMr03/s/f7mYf4aVsB8Pm/gAmof5gAr/9qgAgFmYf4lrsB8PZBgIlof0r0r03/TBgIkefuyX
					qWxIPGgFkxfv16ldpTLVgAksfv3dgAgAKQf7mBf10LbUWTJof4mif5v7YCNqMyf4mlf5rBVqHWSVf7mKf2lxTlD8ZGgAlCfwgAREDugAgFksfvZnQ9FQmVgI
					lOfyT3TlIVssgGlPfxOWWyOlx+gBlPfxKkbWXC1egAlPfxJZgAgA2n]],
				Orbit2 = [[
					gAlPfxJZgAgA2nf9lJfxM0aAZ+4If4kefuQ3UQU93Gf4lof0ZPQePA1Jf7mYf4hlOBKsvlgAmof5pLM8JSntgFmYf4vpNfLJfVgIlof00yPxPqYOgIkefu4k
					TyVfTXgFkxfv46Z7adNtgAksfv3dgAgAKQf7mBf1x4lcmLGyf4mif5r7qLshHFf4mlf5leufx6Kgf7mKf2epyT1DQagAlCfwXq1R0qXagFksfvQY0syte9gI
					lOfyLCwpv7nQgGlPfxISr0rdtxgBlPfxH1mVmTy8gAlPfxJZgAgA2n]],
				["UpperLeg.L"] = [[
					eKi8gW7QeWgAwqeIi2gd8QepfNu7eHiRgu/Cegcxm4eHjTgd7ifbevwOeIkAgO3lftgL1neKkRgEztfdhW5JeNkCgAzQesh55cePjUgF5QddhlzZePiOgW94
					cxgoq7eNiggW9JdUgSs6eKicgf9+dzfGq7eIjqgT5hfYfwzSeHkJgQ3RgQf418eHkMgQ23gUf+2YeIjzgR42fgf60JeKiwgZ87eAfhtheNibgX9fdQgLsGeP
					i7gL6QdVhayCeOi8gN6ddmhFxzeLi8gU7GeMgOw5eKi8gW7QeWgAwq]],
				["LowerLeg.L"] = [[
					eGh/f3tPhxgA9EeDh+f2s5iqgB9Kd4h1fxqvkxhK9veBiXf8uKjbfn8eeHi8gIxIiJfO67eMjOgUzog/fb5PeNjBgSzOgMf75keOiSf0sef6gV9deNhifil0
					gLgZ/deJhufoomg5ga+zeDhwfqpPiPgk+ieFiogAvbibfd76eHjFgMx9ine46UeHjIgOyVije16EeGiwgDwBiUfX7leFh8ftqbiAgU+LeJhrfnoBg7gc+9eN
					h7fysEf9gV9oeMh8f0sdgagP9deIh+f2tEhfgD9KeGh/f3tPhxgA9E]],
				["Foot.L"] = [[
					eOhIgn8NgAgAvGeOhIgn8MgyflvGeOhIgn8Ei1efvBeOhdgn7bhYfLwYeOh6gn6ugSf0xleOiHgm6NfVggyVeOh6gn6qeog6xneOhdgn7bedg7wYeOhIgn8L
					evgrvFeOhIgn8MfWgXvGeOhIgn8MgjfuvGeOhqgn7Gghfrw/eOiBgn6kgrfjxzeOiDgn6hgoflx4eOhwgn68gbfvxPeOhPgn77gSf2vleOhIgn8MfZgVvGeO
					hIgn8Kefg0vFeOhIgn8Le3gnvFeOhIgn8NfxgIvGeOhIgn8NgAgAvG]],
				["Toe.L"] = [[
					eOgsgU/9gAgAhgeOgsgU/8gifShgeOgsgU/zh5dbhfeOhAgX/zg5eqi/eOhbga/sgLfukZeOhogb/ifngvlReOhbga/ofKhakceOhAgX/zfAhgi/eOgsgU/7
					fJhKhgeOgsgU/8fkgnhgeOgsgU/8gXfghgeOhMgY/xgVffjseOhiga/pgafTkqeOhkga/ogZfWkveOhSgZ/vgRflj+eOgzgV/7gMfwiEeOgsgU/8fmgkhgeO
					gsgU/6e/hYhgeOgsgU/7fPhDhgeOgsgU/9f2gOhgeOgsgU/9gAgAhg]],
				["UpperLeg.R"] = [[
					h2i8gW7QhqgAwqh0i2gT7fiMfjwOhxiOgW94jOfXq9hxjUgF5QijebzZhzkCgAzQhUeH5ch2kRgEztgjeq5Jh4kAgO3lgTf11nh5jTgd7iglhRwOh5iQgu/D
					hgjQm1h4ihgl+Chmh1qwh2icgf9+iNg6q7hzjrgE3mh3en1ehxkNf5yyhzdw5vhxkQf5ywhydw5whzj0gD2mhvee2ih2iwgZ87iAgfthh4icgm+VhqiAp2h5
					i7gi8KgshevGh5i8gf75g6hFvmh2i8gY7ZhggOwch2i8gW7QhqgAwq]],
				["LowerLeg.R"] = [[
					h6h/f3tPePgA9Eh3h6fxr0e8fz9thzhifil2f1fn/chyiSf0segGfr9dhzjBgSzOf0gF5kh0jOgUzofBgl5Ph5i8gIxId3gy67h/iXf8uKclgZ8eiIh1fxqu
					bPe19viCh2fwq6cjfd93h9hwfqpPdxfc+ih0inf+vFfmf78NhyjMgOyygVfw54hyjPgOyxgVfw56h0iwgCwFfqf97qh7h8ftqbeAfs+LiDh1fvqhccfV9/iA
					iCf9uUcXgS8Xh/iCf7uHc2gO8ih7h/f4tad9gD8+h6h/f3tPePgA9E]],
				["Foot.R"] = [[
					hyhIgn8NgAgAvGhyhIgn8MglfsvGhyhIgn8LhRfVvFhyhdgn7bhjfFwYhyh6gn6qhYfGxnhyiHgm6NgrfgyVhyh6gn6ufugMxlhyhdgn7beog1wYhyhIgn8E
					dLhhvBhyhIgn8Kebg2vEhyhIgn8MfdgSvGhyhqgn7FhKfSw/hyiGgl54hxevyrhyiJgl5uhxeuy5hyhwgn67hOfOxOhyhPgn77fugKvlhyhIgn8JeTg6vEhy
					hIgn8Keag2vEhyhIgn8Le1govFhyhIgn8NfxgIvGhyhIgn8NgAgAvG]],
				["Toe.R"] = [[
					hygsgU/9gAgAhghygsgU/8gZfehghygsgU/7g3e2hghyhAgX/zhAegi/hyhbga/og2emkchyhogb/igZfRlRhyhbga/sf1gSkZhyhAgX/zfHhWi/hygsgU/y
					eGilhfhygsgU/6e8hchfhygsgU/8fpgghghyhMgY/vgve2jshyhmga/ZhDeHluhyhpgb/WhDeGl/hyhSgZ/tgxeyj9hygzgV/7f0gQiEhygsgU/5e3hkhfhy
					gsgU/6e8hdhfhygsgU/7fOhFhghygsgU/9f2gOhghygsgU/9gAgAhg]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAkqhAAGgAgAiUgAkqhiAUgAgAkVgAkqh3AhgAgAlogAkqhyAdgAgFlSgAkqhnAXgAflkngAkqhbAUf9d/j4gAkqhSAPf8eTjZgAkqhQAMf/frjSgAkqhLAK
					gBgOi8gAk2hDALh6f5ifgAlHhAAxmefiiRgAlChAChsKfIiJgAkjhAFFxHexh9gAkChAHIz/ejhzgAj9hAHd0YehhygAkNhAGfzKenh2gAkQhAGUy6eoh3gA
					kAhAHR0JeihzgAj7hAHk0gehhxgAj7hAHk0gehhxgAj7hAHk0gehhxgAj7hAHk0gehhxgAj7hAHk0gehhx]],
				Spine1 = [[
					gAkxgUAhgAgAlmgAk2g3A7gAgAnlgAk6hOBRgAgAo2gAk5hIBLgAgFoggBk3g8BAf9fln3gGk1gwA5fweAnIgFk0gnAxfxeUmqgBkzglAsf9fsmjf/kygfAo
					gDgOmNgBk9gXAmh4fslwgDlNgUBKmYe3legFlHgUC5sAd4lLgGkmgUFbw5dAkugGkEgUHdzucgkXgGj+gUHx0HcbkTgGkPgUG0y6cpkegGkSgUGpyrcskggG
					kBgUHlz5cekVgGj8gUH40QcakSgGj8gUH40QcakSgGj8gUH40QcakSgGj8gUH40QcakSgGj8gUH40QcakS]],
				Spine2 = [[
					gAlPfBBPgAgAowgAlffpB3gAgAqsgAlogDCUgAgAr6f/lmf8CMgBgFrlgDlhfuB9f6flq9gQlbfhBxfjeCqPgNlYfXBmfmeWpygDlXfUBhf7fsprf+lUfNBa
					gEgOpWgElcfFBWh4fpo6gPlpfBB6mXesorgalcfBDrr9dgocghkzfBGQwzcaoFgkkKfBIVzmbwnzgkkDfBIpz+bqnwgjkXfBHryyb8n4gjkbfBHgyjcAn6gk
					kHfBIdzwbtnxgkkBfBIx0GbnnvgkkBfBIx0GbnnvgkkBfBIx0GbnnvgkkBfBIx0GbnnvgkkBfBIx0Gbnnv]],
				Neck1 = [[
					gAlnebDwgAgAvAgAl7fFGFgAgAyvgAmIfiH1gAgA08f/mFfaHWgCgE0YgEl+fLGcfzfozOgVl3e9FkfCeOx5gSlyeyE+fMegxBgDlxevEzf2fuw0f+ltenEa
					gHgMwLgHl0eeD5hofAvIgXl/ebEAlicruCgplvebFLqfZ/sig2lAebHDu3X6qtg6kTebInxcW1pYg7kMebI3xzWspMg5kiebIIwsXIpyg5kmebH/weXOp5g7
					kQebIuxmWxpTg7kJebI9x7WppHg7kJebI9x7WppHg7kJebI9x7WppHg7kJebI9x7WppHg7kJebI9x7WppH]],
				Neck2 = [[
					gAmmdwGUgAgAzEgAnDeuJLgAgA2agAnTfXLPgAgA4Vf/nPfMKrgDgE31gFnHe2Jnfvfq21gZm9ehIjeyeZ1qgWm2eSH1e/ep04gEm0eNHof0fv0tf9mveDHJ
					gJgL0IgPmzd1GdhVelzKgwm2duGVkfbQx7hUmXdsHDoiXYv6hrlWdqITsLUXtUhykcdpJXuYSzrZhzkTdpJiurSmrHhxkudpJCtvTPr/hwkzdpI8tjTXsKhz
					kYdpJcugSurRhzkPdpJmuySirAhzkPdpJmuySirAhzkPdpJmuySirAhzkPdpJmuySirAhzkPdpJmuySirA]],
				Head = [[
					gAnideADgAgAhRgAoDesBHgAgAoSgAoRfhCmgAgAsmf/oOfTCJf7gDregFoGe4BZgdfspQgbn8ecA5iReVm5gXn1eJAih+eflLgEnzeDAXgYftkqf9ntd1AN
					fwgNjcgWnvdjAHh3fPhahJntdZAvmTdqfUiAnAdVCorqcSc0ihlrdRFTwDb0aGiskkdPHYyeb+YSitkZdPHtyycCYCiqk7dQGvxyb5Y1iplBdQGkxlb4Y+is
					kgdPHhyncAYLitkVdPH0y5cDX8itkVdPH0y5cDX8itkVdPH0y5cDX8itkVdPH0y5cDX8itkVdPH0y5cDX8]],
				Jaw = [[
					gAnncL/9gAgAhggAordk//gAgAfegApMen/8gAgAeKf/pEeU/9gGf/eggIozdy/+fegLfLgmoddR/3dchKfwggoOc6/5d0hKgSgGoKcz/+flgPghf8n+ck/+
					gSf1g4gan1cQ/2eEgjiUhUnmcH+2ZbhclIiLmocG8OT2haozijlGcH4gPagNsJijj5cJ1pNIe6uEijjtcJ1NM2esuUikkRcI2hNxfVthikkYcI2xN9fdtXij
					j0cJ1dNAe0uLiijpcJ1DMwenuaiijpcJ1DMwenuaiijpcJ1DMwenuaiijpcJ1DMwenuaiijpcJ1DMwenua]],
				["UpperArm.L"] = [[
					eblYdw2YOtgAu8eblyeZ43PCcpqTebmCe159PmainGeal+eu5tPdbCoAegl2ed5JO9cfpYe2lueF4aOFe2qPexlnd831OFfarkeflleC3sOpeosneYlgd+3O
					O1e0tseglyd11ZNvfTvOezmad0x8L6eMxKfVmud2tqKibmy4f8mYd5pyKQYez8gVl2d7nfKiWL0PgZlwd7nLKmV20QgOmCd7oKKaW40LgMmFd6oWKYXF0KgX
					l0d7nXKjWC0Pgalud7nEKnVu0Qgalud7nEKnVu0Qgalud7nEKnVu0Qgalud7nEKnVu0Qgalud7nEKnVu0Q]],
				["LowerArm.L"] = [[
					d7kwdNuQ8fgAi8d7ladquj78ljgHd7l3eBuc7CpAeTd6lvd7ug7UoEeteClhdruh7wmggGeclSdUua7+lPijeXlHdPuZ8Kjwi8eAlEdXud8Vizh5d4k8dXua
					8dhnh5d8lMdTvo7yf9iteFl5dayo50eMiledmadm2O2vcuhae+mVdy5IzWbxfsfYl+d66tw8beeWfcl5d866wlbceJfQmGd46QxrbiewfOmId36Ix4bje4fa
					l8d76ywybdeQfdl3d86+wdbceEfdl3d86+wdbceEfdl3d86+wdbceEfdl3d86+wdbceEfdl3d86+wdbceE]],
				["UpperArm.R"] = [[
					hllYdw2YxTgAu8hllyeZ43w+jXqThlmCe159walenGhkl+et5twnk3n6hrl1ei5HwskJp2h/lree4SwMkGsbh7lleS3xwbjCtZhplleG3rxFh2s9hilgd73P
					xXg4tdhpladz3avxequ/htlKdt4fr3aUv2hlkfdr5CmtVCvNhSjido4ZiFQZtahBiydn3efYNsrtg+iqdm3TfBNVrbhGjBdn3ygKOesQhIjFdn33gZOssZhA
					ivdm3ZfONirmg9iodm3Pe5NNrVg9iodm3Pe5NNrVg9iodm3Pe5NNrVg9iodm3Pe5NNrVg9iodm3Pe5NNrV]],
				["LowerArm.R"] = [[
					iFkwdNuQDhgAi8iFladqujEEadgHiFl3eBucE+XAeTiDlvd6ufEsX4e2iLlgdyukENZ5fWijlPd1umDxcme8ielFdruhDldxf6iKlDdcueDndfhUiBk8dTuY
					DleNiSiCktdQsNCmfkjAhzkTdSm6BBgFj4hQjodXf7AXgCkpgni2ddZkBIf9lVgMiSdiVvCRf4lxgIiMdiVNCef3l1gUiddgW2B4f6lpgWigdgXKByf6lmgK
					iPdiVgCWf4lzgHiKdjVBCif3l3gHiKdjVBCif3l3gHiKdjVBCif3l3gHiKdjVBCif3l3gHiKdjVBCif3l3]],
				Tail1 = [[
					gAkvh1eRgAgA/8gAkoiXgSgAgA//gAkkishmgAgA/8gAklimhQgJgB/9f/knibglfQf6/+f5kqiPf2cffp/yf6kriHfXdCfv/2f/ksiFfPfcf9/+gBkth/e4
					gZgB/+gBk6h4egf9eG/5gClLh1eaftZg/SgDlGh1eYfaTy9ggEklh1eMfJO267gEkDh1eAfAL+42gFj9h1d+e/Ll4hgEkOh1eEfCMz5fgEkRh1eFfDNC5rgF
					kBh1eAfAL04tgFj7h1d+e/Ld4agFj7h1d+e/Ld4agFj7h1d+e/Ld4agFj7h1d+e/Ld4agFj7h1d+e/Ld4a]],
				Tail2 = [[
					gAk3jAddgAgA/4gAknjifegAgA//gAkcj3gygAgA/+gBkfjxgcgMgC//f7kkjmfxe8f2/+fpkrjYfDbAfW/kftkujRejbyfh/rf8kvjQebfNf6/8gDkyjKeE
					gjgD/7gBlBjDdwf2eF/2gClTjAdvfOZd/OgElOjAdoedTu9ZgFkvjAdMdyOz6ugHkNjAcwdbL+4lgHkIi/csdYLl4QgGkYjAc5diMy5QgGkbjAc8djNB5cgH
					kLjAcudaLz4dgHkGi/cqdXLd4JgHkGi/cqdXLd4JgHkGi/cqdXLd4JgHkGi/cqdXLd4JgHkGi/cqdXLd4J]],
				Tail3 = [[
					gAlDkKdMgAgA/3gAkpktfOgAgA/+gAkZlCghgAgA//gCkdk9gLgQgD//f2kmkyfgeofy/9fSkvkgezZifH/SfZk1kZeUaifV/ef5k3kbeKe9f4/6gFk7kVd0
					gugE/6gBlMkNdjfseE/1gBlekKdmeoZa/LgBlbkKdYdTTq9RgEk/kJcqcJOy6egHkhkIb9bhMC4QgIkckIb2bcLr36gGkrkJcLbsM148gGkukJcPbvND5IgH
					kfkIb6bfL44HgIkakIbzbaLj3ygIkakIbzbaLj3ygIkakIbzbaLj3ygIkakIbzbaLj3ygIkakIbzbaLj3y]],
				Tail4 = [[
					gAlQlUcugAgA/0gAktl5evgAgA/9gAkWmNgDgAgA//gDkcmIftgUgE//fwkol9fBeUft/7e0k2lleWYFey+7fAk+lgd3ZUfF/Mf0k/lmdseuf1/4gIlFlgdV
					g4gG/3gAlXlYdJfjeC/zf9lqlVdQeFZV/Gf6lrlTc8cPTk9Ef9lWlRb9aoOy6GgDk8lObBZwMI3wgEk4lOa3ZpLy3ZgBlFlPbUaAM44fgAlHlPbaaENG4sgD
					k7lOa8ZtL+3mgEk2lOazZnLq3RgEk2lOazZnLq3RgEk2lOazZnLq3RgEk2lOazZnLq3RgEk2lOazZnLq3R]],
				Frag1 = [[
					gAlnmje5gAgA/+f9k5nKg2hAiF/5f7kZnhh9hekA/pf/kdnchihzlh/bfjkpnPggfTmP/XeKk4mtemYPl++beflBmseqYXmO+afxlDm5f8crmH/OgSlOmygB
					ealJ/igDllmpfVdahb/2f5l7mjfIcvaz/YfxmCmde7bZT39Nfzl1mWd9ZpO46Lf8lgmQctYdMg3/f9ldmQcdYSMQ3sf4lnmSc/YtNV4vf4lpmSdGYzNj48f8
					lfmQckYXMd35f+lbmPcZYPMJ3kf+lbmPcZYPMJ3kf+lbmPcZYPMJ3kf+lbmPcZYPMJ3kf+lbmPcZYPMJ3k]],
				Frag2 = [[
					f7l2qQdYhnmt/IgKkoq5fmhWpF+pgWj3rPhJgcqj+LgjkErMhMfxrG9+fhkbrEgDcwqf+Dcak1qJdiV2og9BculAqId0WXm+9ne/lAqqfDbtlH/Rf4lQqle+
					e5ic/3fYlyqWeofFdd/2fJmTqKe8etW5+ne4mrp7e3c2RL8Je4m+pndhagNm5dfHnFpWb7ZKMG3vfLnGpUboY/MA3jfBnFpacIZYNF4oe/nEpccOZdNT41fJ
					nGpVbuZDMM3wfMnGpTbkY8L43bfMnGpTbkY8L43bfMnGpTbkY8L43bfMnGpTbkY8L43bfMnGpTbkY8L43b]],
				Omega = [[
					gAuccUJZgAgA2ngAvAeIK4gogt4AgAvTfVL5hJha40f/vRfBLqhqiA4jgIvLeZLJhth/4HgmvBdxKjg3g93sggu6dUKNhGhL3WgGu3dLKKh3h/3Nf8uwc3J6
					h6h+2+hLutceJqipf92vj6uIcUKAlPcF2Rm5r+cULGooXY06o0oscUMkrkTUyupdmIcUNmtJQ3wzpflvcUNgtBQPwNpPm5cUMtrzQxwupLnHcUMgrdQywvpa
					l8cUNFsZP/v+pflmcUNYs1P4v3pglmcUNltIQJwIpjlmcUN4tiQgwepllncUOQuBQ9w5polncUOruiRexV]],
				Orbit1 = [[
					gAlPfxJZgAgA2ngAlZgYK7g6iG38gAlfgyMEhpkQ4mgAldgrMFikmY4EgClageL1jPn/3RgKlXgQLUjTox2hgIlUgGLjkkq51lgClUgEMomWtq0hf/lSf9Nd
					nsvszVgElcf1Nxo2xBx9gPlpfxOJqXyNwTgalcfxOrsAzLuighkzfxPbtoz+s0gkkKfxQju90yrWgkkDfxR7vv11qDgjkXfxSuvz3LnxgjkbfxUMwY3/mTgk
					kHfxWtxf4WmOgkkBfxYtyC41lTgkkBfxagyY5SkAgkkBfxcUyn5nirgkkBfxeKyw50hWgkkBfxgAyz54gA]],
				Orbit2 = [[
					gAlPfxJZgAgA2ngAlZgYLkenea4hgAlfgyNZdWcu5rgAldgrOBcCbN5tgClageOjaPZa5VgKlXgQPeXmXH4fgIlUgGQQWXWE4JgClUgERDWBVf4Rf/lSf9R8
					VDUj3+gElcf1S5TvTA3DgPlpfxTtS8RB11galcfxUeSVO50RghkzfxVPRpNEyggkkKfxWPQwLvw4gkkDfxXuPnLFvwgjkXfxaHOPLRvlgjkbfxb5NTK5uhgk
					kHfxckMqJ3sIgkkBfxd5L7JfqZgkkBfxfgLOJZo8gkkBfxhHKpJancgkkBfxiuKKJjl5gkkBfxkUJzJzkU]],
				["UpperLeg.L"] = [[
					eKi8gW7QeWgAwqeKjCgq9AeXf0tZeKjHg397eYfsrLeKjFg09sebfqryeLjDgq9OeJgJs5eQjCgX8mdThkt/ePjAgU8NddhWu0eLi/gd8JeMgMvHeKi+ge71
					edfwvsd+jXgY7fcue+v/dokQgW7FYuc0vEdflHgW51TladtFdqlfgW3uO/Y0q7d7ldgW19MSYFpdd+lcgW1rL6YApQd1lfgW2hNEYSp5dzlggW2rNSYVqBd8
					ldgW11MHYDpYd/lbgW1kLxX+pLd/lbgW1kLxX+pLd/lbgW1kLxX+pLd/lbgW1kLxX+pLd/lbgW1kLxX+pL]],
				["LowerLeg.L"] = [[
					eGh/f3tPhxgA9EeGiOf9whhwgN7VeGiagDyhhvgV6BeGiXgCyAh0gR6YeJiRf7w9hXga7FeRiMftvyf6g/7zePiHfuvAgNg08PeIiGf3u1hegP8TeFiDf6uQ
					h9f+8kdzidf2tehAeR88dOjdfxs4fJaD8qc2kjftsHc6Uv7Nc6lNforEbEQE49dLlXfmqQaBNV3GdOlXfmqJZ4M920dFlVfnqgaUOI3rdDlUfnqlaaOW32dM
					lXfmqNZ+NL2+dPlXfmqGZ1M12tdPlXfmqGZ1M12tdPlXfmqGZ1M12tdPlXfmqGZ1M12tdPlXfmqGZ1M12t]],
				["Foot.L"] = [[
					eOhIgn8NgAgAvGeOhNgf9xgAgArueOhVgb+jgAgApdeOhTgd+XgCf8qEePhPgb98fzgYrPeThNgT9ZfChysdeShKgX9DfMhgtSePhJgh9Af2gStgeNhJgm8u
					gGfzuFd0hkgl8beUfGuic/ipgj8DaMdIt7cWj5gg62U8a5sacPkwgd4zQQZOqrcblFgb3ENeYZpfcelGgb2zNGYSpTcWlAgc3nOSYnp2cVk+gc3xOhYsp8cc
					lFgb29NUYWpacflHgb2sM9YQpPcflHgb2sM9YQpPcflHgb2sM9YQpPcflHgb2sM9YQpPcflHgb2sM9YQpP]],
				["Toe.L"] = [[
					eOgsgU/9gAgAhgeOg3gH/6gAgAdyeOhCgA/qgAgAbZeOg/gC/vgAf7cCeQg5gC/3f+gbdQeWg1f8/5f5iBemeUgxgB/8f6htfgePgwgL//f/gVfueNgugS//
					gAfygXdxhKgS/7eGf6g5c1iQgP/UZhf5ggcEjngK9kT0gJfpb5kmgG6/O3gqe+cElAgE45MAhGepcHlCgD4lLnhLemcAk5gE5jM1g9eub/k3gF5vNEg7ewcF
					lBgD4xL1hIeocIlDgD4dLehMelcIlDgD4dLehMelcIlDgD4dLehMelcIlDgD4dLehMelcIlDgD4dLehMel]],
				["UpperLeg.R"] = [[
					h2i8gW7QhqgAwqh2jCgq9AhpgMtZh2jHg397hogUrLh2jGgz9shrgOrxh3jCgw9Ohagls8h6i/g18mglh3uNh6i+gt8Ngwhju/h3i+gi8JhfgXvJh1i9ga71
					hwf3vrhoi7gX71gBfFvwhAizgW8Mb2dLuQgGihgW7zWTbdrpfOiKgW6URNappGeuh3gW41OHahngeph0gW4lNrahnSe3h9gW5UPAahn+e6h/gW5cPRahoGes
					h2gW4uN7ahnaeohzgW4gNiahnNeohzgW4gNiahnNeohzgW4gNiahnNeohzgW4gNiahnNeohzgW4gNiahnN]],
				["LowerLeg.R"] = [[
					h6h/f3tPePgA9Eh6iOf9wheQfz7Vh6iagDyheRfr6Bh5iXgByAeVfr6Zh8iQgCw9d3f87CiCiJgMvycagq7liBiGgHvAcsgl8Dh7iFf8u1d8gC8Rh4iDf3uQ
					ecf28mhkiAf0tLdfeQ8/guh/fur4bwaG8zfmh7fnqPZ4Ux7eeph0fhoeYjQE5VeJhsfdnRX6NS3jeFhqfdnGX1M53ReShvfenoYFOF4HeVhvfenuYIOU4ReI
					hrfdnMX4NH3beEhpfdnCX0Mx3KeEhpfdnCX0Mx3KeEhpfdnCX0Mx3KeEhpfdnCX0Mx3KeEhpfdnCX0Mx3K]],
				["Foot.R"] = [[
					hyhIgn8NgAgAvGhyhNgf9xgAgAruhyhVgb+jgAgApdhyhTgc+XgCf8qEhzhOgh98fzgYrPh2hKgv9ZfChysdh1hJgv9DfMhgtShzhJgl9Af2gStghyhJgj8u
					gGfzuFhXhKgk8heUfHuXgShRgh8VaJdPtXe9hdgc7UUvbVrWd7hngY5XP5aIpQdahpgW3qNAZqn5dXhpgV3YMnZnntdjhpgW4NN2ZxoTdmhogW4WOFZ0obdZ
					hpgW3iM1Zpn0dVhpgV3SMeZmnpdVhpgV3SMeZmnpdVhpgV3SMeZmnpdVhpgV3SMeZmnpdVhpgV3SMeZmnp]],
				["Toe.R"] = [[
					hygsgU/9gAgAhghyg3gH/6gAgAdyhyhCgA/qgAgAbZhyg/gB/vgAf7cCh0g4gI/3f+gbdQh4gygZ/5f5iBemh3gwgZ/8f6htfghzgwgQ//f/gVfuhxgugO//
					gAfygXhTgwgQ/7eGf7gtgIg6gL/VZhgCf3eshMgE9iT1goefdnhdf+64O7hodddHhkf74wMIidc9dDhlf74bLvilc5dQhjf85aM7iMdFdShif85mNKiHdIdF
					hlf74nL9igc7dChlf74TLnioc4dChlf74TLnioc4dChlf74TLnioc4dChlf74TLnioc4dChlf74TLnioc4]],
			},
		},
	},
}
