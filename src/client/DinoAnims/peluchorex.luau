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
					gAh0g8AEgAgAhxgAh0g8AEgAgAhxgAh0g8AEgAgAhxgAh0g8AEgAgAhxgAh0g8AEgAgAhxgAh0g8AEf/gBhwgAh0g8AEf9gChvgAh0g8AEf6gEhugAhzg8AE
					f3gGhsgAhwg8AEfzgJhpgAhxg8AEfvgMhngAhyg8AEfqgPhjgAhvg8AEflgThggAhrg8ADfggWhdgAhtg8ADfagbhZgAhvg8ADfUgfhVgAhqg8AEfOgjhRgA
					hmg8AEfJgnhOgAhog8AEfEgrhKgAhpg8AEe/guhHgAhmg8AEe6gyhDgAhkg8AEe2g1hBgAhlg8AEezg3g+gAhlg8AEewg5g8gAhkg8AEeug7g7gAhjg8AEes
					g8g6gAhjg8AEerg9g5gAhjg8AEerg9g5gAhjg8AEerg9g5gAhog8ADfRghhTgAh8g8AGgnfmiJgAh4g8AFgTfzh9gAhyg8AEf2gHhrgAhxg8AEf1gIhqgAh1
					g8AEgAgAhxgAh1g8AEgFf9h0gAh1g8AEgDf+hzgAh0g8AEgAgAhxgAh0g8AEgAgAhxgAh0g8AEgAgAhx]],
				Spine1 = [[
					gAh3glB0gAgAqmgAh3glB0gAgAqmgAh3glB0gAgAqmgAh3glB0gAgAqmgAh3glB0gAgAqlgAh3glB0f/gBqkgAh2glBzf+gDqigAh2glByf8gFqfgAh1glBx
					f5gIqbgAhzglBvf2gMqXgAhzglBufzgQqRgAh1glBsfvgUqMgAhxglBqfrgZqFf/htglBofngep/f/hvglBlfigkp4f/hwglBjfegppxf/hsglBhfZgvppf/
					hoglBffVg0pjf/hqglBdfRg5pcf/hrglBcfNg+pVf/hoglBafJhCpQf/hlglBZfGhGpKf/hmglBYfDhJpGf/hmglBXfBhMpCf/hlglBWe/hOo/f/hkglBWe+
					hPo+f/hkglBVe+hQo9f/hkglBVe9hQo9f/hkglBVe9hQo9f/hqglBifbgspsgBh/glCFgefcrSgAh7glB9gPfuq8gAh1glBwf4gKqZgAhzglBwf3gKqZgAh3
					glB1gAgAqmgAh4glB3gEf7qsgAh4glB1gCf+qpgAh3glB0gAgAqmgAh3glB0gAgAqmgAh3glB0gAgAqm]],
				Spine2 = [[
					gAiRgEFVgAgAxpgAiRgEFVgAgAxpgAiRgEFVgAgAxpgAiRgEFVgAgAxpgAiRgEFUgAgAxpgAiRgEFTf/gBxngAiRgEFRf+gDxkgAiRgEFPf9gGxgf/iPgEFM
					f7gKxbf/iNgEFIf5gOxVf/iNgDFDf3gTxOf/iOgDE+f0gYxHf+iKgDE5fygdw+f+iGgDE0fvgjw1f+iHgDEufrgqwsf9iJgDEpfogwwif9iEgCEjflg2wZf9
					iAgCEefig8wPf8iCgCEZffhCwGf8iCgCEUfchIv+f8h/gCEQfZhNv2f7h8gCEMfXhRvvf7h9gCEJfVhVvpf7h9gCEGfThYvkf7h8gCEEfShavgf7h7gBEDfR
					hcvef7h7gBECfRhdvcf7h7gBECfRhdvcf7h7gBECfRhdvcf9iCgDElfmg0wdgCibgFF+gUfVykgBiWgFFpgKfryHf/iPgEFKf7gLxZf/iNgEFJf6gMxYgAiR
					gEFVgAgAxqgAiTgEFagDf6xxgAiSgEFXgBf9xtgAiRgEFVgAgAxpgAiRgEFVgAgAxpgAiRgEFVgAgAxp]],
				Neck1 = [[
					gAipf6GzgAgAzsgAipf6GzgAgAzsgAipf6GzgAgAzsgAipf6GzgAgAzsgAipf6GygAgAzrgAipf6Gwf/gBzpgAiof6Gtf/gDzlf/iof5Gpf+gGzgf/inf5Gk
					f8gKzZf/ikf5Gef6gOzRf+ilf5GXf4gTzHf+ilf4GPf2gZy9f9iif4GHf0geyxf9idf3F+fxglylf8iff3F1fugryYf8igf3FsfrgxyLf7ibf2Fjfog4x+f7
					iXf2Fbflg+xxf6iYf1FTfihExkf6iZf1FLfghJxYf5iVf1FFfdhOxNf5iTf0E/fbhTxEf5iTf0E6fZhXw7f4iTf0E2fXhaw0f4iRf0EyfWhcwvf4iRf0EwfV
					hewrf4iRf0EvfVhfwqf4iRf0EvfVhfwqf4iRf0EvfVhfwqf8iZf2Fnfqg1yDgEi0f9H1gQfU08gCiuf7HTgIfq0Uf/imf5Gif7gMzWf/ilf5Ggf7gMzUgAip
					f6GzgAgAztgAirf6G7gCf6z3gAiqf6G3gBf9zxgAipf6GzgAgAzsgAipf6GzgAgAzsgAipf6GzgAgAzs]],
				Neck2 = [[
					gAjSfwFqgAgAyJgAjSfwFqgAgAyJgAjSfwFqgAgAyJgAjSfwFqgAgAyJgAjSfwFpgAgAyIgAjRfwFnf+gCyFgAjRfvFkf8gFyAf/jRfvFff4gJx5f/jPfuFa
					f0gPxwf+jMftFTfvgVxmf+jNftFLfpgdxZf9jNfsFCfiglxMf8jJfrE5fbguw9f7jFfqEwfUg4wtf7jGfpEmfMhCwcf6jHfoEdfEhMwLf5jCfnEUe8hWv6f4
					i9fmELe0hgvqf3i+flEDethqvaf3i/fkD7emhzvKf2i7fjD1egh8u8f1i4fjDveaiDuvf1i4fiDqeViKulf0i4fiDmeRiPucf0i3fhDjeOiTuVf0i2fhDheM
					iVuQf0i2fhDgeLiXuOf0i2fhDgeLiXuOf0i2fhDgeLiXuOf5jAfnEYe/hSwCgFjdf3G3g0fAzvgDjXfzGPgafgy8f/jPfuFXfygRxsf+jNfuFVfxgTxqgAjS
					fwFrgBf/yKgBjTfxFzgHf3yWgAjTfwFvgEf8yQgAjSfwFqgAgAyJgAjSfwFqgAgAyJgAjSfwFqgAgAyJ]],
				Head = [[
					gAj0fjAWgAgAkjgAj0fjAWgAgAkjgAj0fjAWgAgAkjgAj0fjAWgAgAkjgAj0fjAWf/gAkigAj0fiAVf7gBkef/jzfiAUf1gEkVf/jzfhASfsgGkGf+jxfgAR
					fggKj6f9juffAPfSgPjtf8jufeANfDgUjTf7jvfcALexgbi0f6jrfbAKeeghijf5jmfZAKeKgpiSf4jmfYAJd1gxhtf2jnfWAJdgg5hHf1jifUALdLhBg2f0
					jdfTANc3hJglfzjdfRAPcjhRgBfxjdfQARcRhZfhfwjZfPAUcAhgfSfvjWfOAXbxhnfDfvjWfNAZbkhseufujVfMAcbahxeefujUfLAebSh1eVftjTfLAfbN
					h3ePftjTfLAgbKh4eLftjTfLAgbKh4eLftjTfLAgbKh4eLf2jgfVALdUg+hMgIkBfuA+iKfYnZgEj7foAmhFfrl+f+jxfgAQfbgMjzf+jvffAQfYgNj0gAj0
					fjAWgCgAklgBj2fkAZgSf6k7gBj1fjAYgJf9kvgAj0fjAWgAgAkkgAj0fjAWgAgAkjgAj0fjAWgAgAkj]],
				Jaw = [[
					gAkEe//EgAgAnogAkEe//EgAgAnogAkEe//EgAgAnogAkEe//EgAgAnogAkEe//EgBgAnogAkDe//EgFgAnof/kCe+/DgMgBnrf+kBe9/CgVgBnvf9j/e8/C
					ghgCnvf8j8e7/CgwgCntf7j7e5+/hBgCn2f6j6e3+8hTgCoCf4j1e2+8hogAn/f2jwe0+8h9f/n5f1jvey+3iTf8oHfzjuew+xiqf5oWfyjoeu+wjAf1oQfw
					jjet+vjWfxoLfujier+pjrfsoZftjgeq+kj+fnokfsjceo+ikQfiogfrjYen+gkgfdoefqjXem+cktfYomfpjWem+Zk4fVoqfojUel+YlAfRopfojTel+XlG
					fPoqfojSek+WlIfOorfojSek+WlJfOorfojSek+WlJfOorfyjnev+0i2f3oEgMkWfO+xd0fgocgGkNfG+8e4f1oDf9j+e7/BgngCnxf9j9e7/CgqgCntgAkE
					e//Ef+gAnpgCkGfB/Cftf+nvgBkFfA/Df2f/nsgAkEe//EgAgAnogAkEe//EgAgAnogAkEe//EgAgAno]],
				Zip = [[
					gAilez2ngAgA2ngAilez2ngAgA2ngAilez2ngAgA2ngAilez2ngAgA2ngAilez2ngBgA2ogAikez2mgDgC2pgAikey2jgHgE2rf/ikey2ggNgI2vf/iiey2c
					gVgN2zf+ieey2XgegS24f+ieex2QgogZ29f9ifex2Kg0gg3Df8iaex2ChAgn3Kf8iVex16hOgv3Qf7iVew1yhcg33Xf6iWew1qhqg/3ef6iRew1hh4hH3kf5
					iLev1YiGhP3qf4iMev1QiThX3wf4iMev1Iifhe32f3iIev1Birhk36f3iFeu06i1hq3/f2iEeu01i+hu4Cf2iEeu0ujGhy4Gf2iCeu0rjLh14If1iCeu0qjP
					h34Jf1iBeu0pjQh44Jf1iBeu0pjRh44Jf1iBeu0pjRh44Jf6iPew2ghwhE2pgFi0e23YenfG1xgDite00TfRfk4tf/iheyx4gZgP6hf/ifeyyZgbgQ6LgAil
					ez0Mf/f/40gBinez2uf0f52hgAimez4Wf6f80wgAilez42gAgA0KgAilez4agAgA0qgAilez3egAgA1v]],
				["UpperArm.L"] = [[
					e5iifw4DNcaBoDe5iifw4DNcaBoDe5iifw4DNcaBoDe5iifw4DNcaBoDe5iifw4CNcaCoFe5ihfw4ANbaIoNe5ihfw38NZaSoce4ihfw32NXahowe4iffw3v
					NVa0pKe4icfw3mNSbKppe3icfv3bNQbkqLe3icfv3NNOcBqye3iYfv2+NNchrae2iTfv2tNNdEsEe2iUfv2aNOdnsve1iVfv2HNQeMtae1iQfv1yNTexuDe0
					iLfv1cNXfWure0iMfv1GNbf5vQeziMfv0xNggbvyeziIfv0dNmg5wReyiFfv0LNrhVwseyiFfvz7NwhtxCeyiEfvztN0iAxUeyiDfvzjN4iPxieyiCfvzcN6
					iZxreyiCfvzYN7iexveyiCfvzYN7iexveyiCfvzYN7iexve1iOfv17NReitye9iwfx2nNCUQjve7ipfw3cM/XKl2e4iefw3sNUa8pWe4idfw3qNTbBpce5ii
					fw4CNbZ9oAe5ikfw36NRZRnde5ijfw3+NWZpnwe5iifw4CNcaAoCe5iifw4DNcaBoDe5iifw4DNcaBoD]],
				["LowerArm.L"] = [[
					ehibfPJrL2VZiZehibfPJrL2VZiZehibfPJrL2VZiZehibfPJrL2VZiZehibfPJqL1VciWehiafPJqLuVoiMehiZfPJpLkV7h7ehiYfPJoLVWYhiegiVfPJo
					LDW8hCegiRfQJpKuXngcegiPfQJsKZYafwefiOfRJxKCZSe/efiIfSJ5JsaQeKeeiCfSKEJYbRdTeeiBfTKTJFcVcZeeiAfVKkI1dabfedh5fWK5Ipefaled
					hyfXLQIgfiZtedhyfYLoIagiY3echxfaMBIXheYFechsfbMaIWiVXYechofcMyIXjFWwechnfdNHIajuWOechmfeNaIdkQVzechkffNoIfkpVeechjffNxIh
					k6VQechjfgN2IjlCVKechjfgN3IjlDVJechjfgN3IjlDVJedh3fVKwIueCa9eii7fUIsS3QmoWehisfQI3PJSylYegiUfPJoK7XNgzegiSfQJoK3XVgsehic
					fPJpL7VVidehigfPJZMrUrjLehiefPJhMRVCiyehicfPJqL3VZiZehibfPJrL2VZiZehibfPJrL2VZiZ]],
				["UpperArm.R"] = [[
					hHiifw4Dykl/oDhHiifw4Dykl/oDhHiifw4Dykl/oDhHiifw4Dykl/oDhHiifw4Cyll+oFhHiifw3/yol3oMhHihfv35ytlsoYhHiifv3xyzldoqhGigfv3m
					y8lJpBhGiefu3ZzGkypbhFiefu3JzQkXp6hFigft22zbj5qbhEicft2gzmjZq/hEiYfs2Jzxi4rlhDiZfs1vz8iVsLhDibfr1T0FhysyhCiXfq020NhPtXhC
					iTfq0Z0Ugtt8hBiUfpz70agNuehBiVfpzf0efvu+hAiSfozE0ifTvbhAiPfoyr0ke7v0hAiQfoyW0memwKg/iQfnyD0neVwbg/iPfnx20neJwog/iOfnxs0n
					eAwxg/iOfnxo0od8w1g/iOfnxn0od8w1g/iOfnxn0od8w1hDiUfr1C0KhetIhLiqf03Fx+sGkohJimfy3tyfpAmPhGigfv3hzAlApLhGiefv3ezCk8pQhHii
					fw4CykmDoAhHijfw3/ylmxnjhHijfw4BylmZnzhHiifw4CykmAoChHiifw4Dykl/oDhHiifw4Dykl/oD]],
				["LowerArm.R"] = [[
					hfibfPJr0KqniZhfibfPJr0KqniZhfibfPJr0KqniZhfibfPJr0KqniZhfibfPJq0LqkiWhfibfPJp0QqaiKheiafPJm0YqIh2heiZfOJj0jpuhaheiXfOJf
					0xpMg2hdiTfOJc0/okgKhdiTfOJa1Pn1fZhciSfOJY1dm/ejhciNfOJZ1rmFdohciIfPJc12lGcrhbiIfPJi1/kEbthbiIfPJq2EjAauhaiCfQJ02Gh7Zxha
					h9fQKB2Fg3Y2hZh9fRKP2Bf2X/hZh9fSKe17e4XMhZh5fSKu10d/WehZh2fTK+1rdMV3hYh2fULM1ichVVhYh1fULY1ab9U7hYh0fULi1UbiUmhYhzfVLo1P
					bQUZhYhzfVLs1NbHUThYhzfVLs1MbGUThYhzfVLs1MbGUThaiAfQJv2GiYaLhoizfYI4t3uipPhjiofSJDxQs2l1heiWfOJe02o9glheiUfOJd05o1gdhfic
					fPJp0GqqiehgiffPJdzcrPjThfidfPJkzzq8i2hficfPJq0JqniahfibfPJr0KqniZhfibfPJr0KqniZ]],
				Tail1 = [[
					gAhrhal0gAgA/dgAhrhal0gKf+/dgAhrhal0gUf8/dgAhrhal0gdf7/dgAhrhal0glf5/dgAhrhalzguf5/dgAhrhalyg2f5/cgAhrhalxg9f7/cgAhqhalw
					hDf9/dgAhnhaluhJgA/dgAhohalthNgD/dgBhqhalrhQgI/dgBhmhalohSgN/dgBhjhalmhTgS/egBhkhalkhSgY/egBhmhblihRgf/egBhihblfhOgl/fgC
					hehbldhKgs/fgChghblbhGgy/ggChihblZhBg5/ggChfhblYg7g//ggChchblWg0hE/ggChdhblVguhJ/ggChdhblUgnhN/hgChchblUghhR/hgChchblUga
					hU/hgChchblUgVhW/hgChchblUgQhX/hgChchblUgMhY/hgBhghbljfpg2/ff/hyhamAeifo/Yf/hvhal6eyf6/agAhphalwfMgU/dgAhohalwfRgU/dgAhr
					hal0fMgJ/cgAhshal1fPgE/cgAhshal1fZgF/cgAhrhal0fjgF/dgAhrhal0fsgE/dgAhrhal0f2gC/d]],
				Tail2 = [[
					gAhaiHnrfdgJ/DgAhaiHnrfvgE/DgBhaiHnrgBgA/DgBhaiHnrgUf7/DgChaiHnrgmf3/DgChaiHnrg5fz/CgChaiHnqhKfx/CgDhaiHnqhafw/BgDhZiHnp
					hpfv/BgEhXiHnoh2fw/AgEhYiHnniAfy/AgEhZiHnmiJf1/AgFhWiHnliOf5/AgFhSiHnkiSf+/AgFhUiHnjiSgE/AgFhWiHniiQgK/AgFhSiHnhiLgR/BgF
					hPiHngiEgZ/BgFhQiHngh6gh/CgFhSiHnfhvgp/DgFhPiInfhigx/DgFhNiInfhUg6/EgFhOiInfhFhB/EgFhOiIngg1hI/EgEhNiIngglhP/EgEhMiInggV
					hV/EgEhMiInhgGhZ/EgEhMiInif4hd/DgEhMiInifshg/DgBhPiHnne/hD/Cf6hhiGnsduf5++f8heiGnrd6gM+/f+hZiHnqeSgm/Af+hXiHnqeUgn/Af+ha
					iHnqePgc/Af+hbiHnreSgW/Af+hbiHnreegV/Bf/haiHnretgU/Bf/haiHnre7gR/CgAhaiHnrfLgN/D]],
				Tail3 = [[
					f+hEixjzeggL/ugAhEixjze3gJ/vgBhEixjzfQgG/wgChEixjzfqgD/wgDhEixjzgEgA/xgEhEixjzggf+/wgGhDixjzg7f8/wgHhEixjzhVf8/vgIhDixjz
					htf8/ugJhBixjziEf9/sgKhBixjziYf//rgKhDixjzipgC/qgLhAixjzi2gF/ogLg8ixjzjAgJ/ngMg+ixjzjGgO/ngMhAixjzjIgU/ngMg8ixjzjGga/ngM
					g5iyj0i/gh/ngLg7iyj0i1gn/ogLg8iyj1iogu/pgKg5iyj2iXg1/qgJg3iyj3iEg8/rgJg4iyj4huhD/sgIg4iyj6hXhJ/tgHg3iyj7g+hP/tgGg3iyj8gl
					hT/tgFg2iyj9gMhX/tgEg2iyj+f0hb/tgEg2iyj/fehe/tf+g5iyj7eqg9/tf0hLiwjqdZfq/rf2hHiwjudaf//qf6hCixj0dmgd/qf6hBixj0dhgf/qf5hE
					ixjydXgU/qf5hFixjxdWgP/qf6hEixjydfgR/qf7hEixjydrgS/rf8hEixjyd6gQ/sf9hEixjyeMgO/t]],
				Tail4 = [[
					f6g5jfZTdlff/Lf8g5jfZTd6fj/Nf/g5jfZTeSfo/OgBg5jfZSetfu/QgEg5jfZSfKf1/RgGg4jfZSfpf8/RgIg4jfZTgJgF/SgLg5jfZUgpgO/RgNg3jfZV
					hIgY/RgPg1jeZWhmgi/PgRg2jeZYiBgt/OgSg4jeZaiag3/MgTg1jeZbiwhB/LgUgxjeZdjBhK/JgVgzjeZejPhS/IgVg1jeZgjXha/HgVgyjeZijbhh/GgU
					gujfZjjahm/GgUgwjfZkjVhr/HgTgxjfZmjKhu/IgRgujfZni7hw/KgQgsjgZpiohx/MgOgtjgZqiShw/OgMgtjgZsh4hv/QgKgsjgZthchs/SgIgrjgZvg/
					hn/UgGgrjgZwgghi/VgEgrjgZxgBhc/WgDgrjgZyfjhW/Wf7gujfZle0gk/UfshAjdZCd5e3/Ifug8jeZLdofK/Jfzg3jeZYdgfp/Mfzg2jeZZdRfn/Lfxg5
					jeZUdCfX/Ifxg6jeZSc6fQ/Hfzg5jeZTc6fT/Hf0g5jeZUc+fW/If2g5jfZUdHfY/Jf4g5jfZUdUfb/K]],
				Tail5 = [[
					f0hMkIOedYeR6kf3hMkIOddkeZ6lf6hMkIOcd0ej6mf+hMkJObeHew6ogBhMkJOaeee/6pgFhLkJOae2fR6rgJhLkJOafRfk6tgMhLkIObftf66ugQhKkIOd
					gJgQ6vgThIkIOfglgn6wgWhJkIOhhAg+6wgYhKkIOkhahU6wgahHkHOohyhp6vgchEkHOriGh96vgdhGkHOviYiP6ugehIkHOyimif6ugehEkHO1ivis6ugd
					hAkIO4i1i36ugchCkIO7i2i+6vgahDkIO9iyjC6wgYhAkJO/iqjE6ygWg+kJPAiejB60gTg/kJPCiOi863gRg/kKPCh6i066gNg9kKPDhkip69gKg9kKPEhL
					ib7AgHg8kKPEgwiL7CgEg8kKPEgUh67EgBg8kKPFf3ho7Gf3hAkJOxfZgk68fnhUkGOEfFek6bfohQkHOPepes6ifshKkIOgeOfC6tfrhIkHOid5e26sfphM
					kHOcdpec6lfphNkHOadceN6ifrhMkHOcdSeK6ifshMkHOedNeK6jfuhMkIOedMeJ6jfxhMkIOedQeM6j]],
				["UpperLeg.L"] = [[
					exhKgb8sgAgAuIexhKgb8sgAgAuIexhKgb8sgAgAuIexhKgb8sgAgAuIexhKgb8tgAgAuGexhJgb8zgAf+t7exhJgc84gBf8txexhJgc86gBf6ttexhHgc9L
					gCf1tGexhFgc9kgDfusOexhFgd9lgEfqsKexhGgd9igFfmsTeyhCgd+BgHfcrCeyg9ge+fgKfTpqeyg+ge+cgKfNpxeyhAgf+ZgLfIp9eyg7gf+1gOe9odey
					g2gg/LgTeznEezg4gg/KgSeunIezg4gh/KgSeonGezg1gh/agWefl4ezgygh/kgaeXk7ezgygi/lgaeTk0ezgygi/ngaePklezgxgi/rgceKkEezgwgi/tgd
					eIjzezgwgi/tgeeHjvezgwgi/tgeeHjuezgwgi/tgeeHjueyg5gf+9gQe+n9ewhVgZ4af/g+0pewhQga7Uf9gZwqexhHgc9QgDfzs7exhFgc9egDfwscexhK
					gb8rgAgBuMexhLgb8Yf/gHuwexhLgb8if/gDucexhKgb8sgAgAuJexhKgb8sgAgAuIexhKgb8sgAgAuI]],
				["LowerLeg.L"] = [[
					exgvgHtLhpgA9GexgvgHtLhpgA9GexgvgHtLhpgA9GexgvgHtLhpgA9GexgvgHtJhpgA9HexgvgHs6hqgB9OexgvgHsxhqgB9SexgvgHs2hrf/9QexgugGsE
					hsgC9lexgtgFq4hugH+CexgtgFrJhvgE98exgugGrvhxf99texgsgEqGh0gG+TewgqgDoTh2gS+1ewgrgDpGh5gJ+newgsgEp9h8gA+WewgqgDoPiAgO+2ew
					gogCmxiEge/MewgpgCnmiHgT/AewgqgDoMiKgM+2ewgpgCnPiOga/FewgogCmtiTgl/MewgpgCnHiVgg/GewgpgCnSiYge/DewgpgCnHiagk/FewgogCnHic
					gm/FevgpgCnKidgm/FevgpgCnKidgm/FevgpgCnKidgm/FewgpgCnIh+ga/Heyg1gT1Zhkfx3vexgygLwIhmf87lexgugGr5htgC9pexgtgFrIhtgG98exgv
					gHtPhpgA9FexgwgIt3hof/8yexgwgHthhpgA88exgvgHtMhpgA9GexgvgHtLhpgA9GexgvgHtLhpgA9G]],
				["Foot.L"] = [[
					ezgfgV+ngAgApRezgfgV+ngAgApRezgfgV+ngAgApRezgfgV+ngAgApRezgfgV+ngAgApRezgfgV+ngBgApRezgfgV+ngCf/pRezgfgV+ngBgApRezgfgV+n
					gFf+pRezgfgV+ngMf9pRezgfgV+ngLf9pRezgfgV+ngIf+pRezgfgV+ngRf7pRezgfgV+ngef3pRezgfgV+ngaf4pRezgfgV+ngWf5pRezgfgV+ngkf1pRez
					gfgV+ngzfxpRezgfgV+ngufypRezgfgV+ngrfzpRezgfgV+mg4fvpRezgfgV+mhDfspRezgfgV+mhBfspRezgfgV+mhCfspRezgfgV+mhIfqpRezgfgV+mhK
					fqpRezgfgV+mhKfppRezgfgV+mhLfppRezgfgV+mhLfppRezgfgV+ngrfzpRezgfgV+nfmgIpRezgfgV+nf2gDpRezgfgV+ngGf+pRezgfgV+ngKf9pRezgf
					gV+ngAgApRezgfgV+nf9gBpRezgfgV+nf/gApRezgfgV+ngAgApRezgfgV+ngAgApRezgfgV+ngAgApR]],
				["Toe.L"] = [[
					ezgXgJ/8gAgAhmezgXgJ/8gAgAhmezgXgJ/8gAgAhmezgXgJ/8gAgAhmezgXgJ/8gAgAhmezgXgJ/8gBf/hmezgXgJ/8gCf/hmezgXgJ/8gBf/hmezgXgJ/8
					gFf9hmezgXgJ/8gKf6hmezgXgJ/8gJf6hmezgXgJ/8gHf8hmezgXgJ/8gQf3hmezgXgJ/8gbfwhmezgXgJ/8gXfyhmezgXgJ/8gTf0hmezgXgJ/8ggfthmez
					gXgJ/8gtflhmezgXgJ/8gpfnhmezgXgJ/8gnfphmezgXgJ/8gzfihmezgXgJ/7g8fchmezgXgJ/7g7fdhmezgXgJ/7g8fchmezgXgJ/7hAfahmezgXgJ/7hC
					fYhmezgXgJ/7hDfYhmezgXgJ/7hDfYhmezgXgJ/7hDfYhmezgXgJ/8gnfphmezgXgJ/8fpgOhmezgXgJ/8f3gFhmezgXgJ/8gFf9hmezgXgJ/8gJf7hmezgX
					gJ/8gAgAhmezgXgJ/8f+gBhmezgXgJ/8f/gBhmezgXgJ/8gAgAhmezgXgJ/8gAgAhmezgXgJ/8gAgAhm]],
				["UpperLeg.R"] = [[
					hPhKgb8sgAgAuIhPhKgb8sgAgAuIhPhKgb8sgAgAuIhPhKgb8sgAgAuIhPhKgb8tgAgAuIhPhJgb8wgAgAuBhPhJgb8wgBf+uBhPhKgb8sgBf8uKhPhJgb83
					gCf7tzhPhHgb9IgDf6tNhQhHgb9AgEf2tghQhJgb8vgFfwuChQhGgb9JgGfvtLhQhCgb9igFftsRhQhEga9TgIfns1hQhHga9AgKfhtfhQhDga9bgJffshhQ
					g/ga9vgGfdryhQhBga9igKfYsRhQhDga9YgNfTsphRhAga9ngLfRsEhRg+ga9wgJfOrvhRg/gZ9qgLfLr8hRg/gZ9pgMfJsAhRg+gZ9sgMfIr3hRg+gZ9tgL
					fHr1hRg+gZ9tgMfGr1hRg+gZ9tgMfGr1hRg+gZ9tgMfGr1hQhAga9sgGfjr5hOhPgc7vf2gTv8hPhMgc8Sf7gKu9hPhIgb84gCf6tvhPhHgb9FgCf7tUhPhK
					gb8sgAgAuJhPhLgc8mf/gDuVhPhKgb8pf/gBuPhPhKgb8sgAgAuIhPhKgb8sgAgAuIhPhKgb8sgAgAuI]],
				["LowerLeg.R"] = [[
					hPgvgHtLeXgA9GhPgvgHtLeXgA9GhPgvgHtLeXgA9GhPgvgHtLeXgA9GhPgvgHtKeXgA9HhPgvgHs+eXf+9MhPgvgHs6eXf99OhPgvgHtGeXf89JhPgvgGsc
					eYf39bhPgtgFrUeZfu94hPgugGrweZfu9thPgvgGskeafv9YhPgtgFq5ecfk+ChPgrgDo9eefV+qhPgsgEp9effZ+XhPgtgFrDeffb9+hPgrgDo9eifN+qhP
					gogCnBele9/KhPgqgCoAemfC+7hPgqgDoremfE+vhPgpgCnIepe4/IhPgngBmAerev/XhPgogBmaerex/ShPgogBmeesew/RhPgngBl7etes/YhPgngBlveu
					eq/ahPgngBlueueq/ahPgngBlueueq/bhPgngBlueueq/bhPgpgCnnejfF/BhPgygLwoeYgr7RhPgxgJu1eWgV8ShPgvgGsUeYf19fhPgugFrieZfw9yhPgv
					gHtNeXgA9FhPgwgItmeWgG86hPgwgHtZeWgD9AhPgvgHtLeXgA9GhPgvgHtLeXgA9GhPgvgHtLeXgA9G]],
				["Foot.R"] = [[
					hNgfgV+ngAgApRhNgfgV+ngAgApRhNgfgV+ngAgApRhNgfgV+ngAgApRhNgfgV+ngAgApRhNgfgV+nf/gApRhNgfgV+nf+gBpRhNgfgV+nf+gApRhNgfgV+n
					f7gCpRhNgfgV+nf1gDpRhNgfgV+nf2gDpRhNgfgV+nf5gCpRhNgfgV+nfxgEpRhNgfgV+nfogHpRhNgfgV+nfsgGpRhNgfgV+nfwgFpRhNgfgV+nfngIpRhN
					gfgV+nfdgLpRhNgfgV+nfigJpRhNgfgV+nflgIpRhNgfgV+nfdgLpRhNgfgV+nfYgMpRhNgfgV+nfagMpRhNgfgV+nfagLpRhNgfgV+nfYgMpRhNgfgV+nfX
					gNpRhNgfgV+nfXgNpRhNgfgV+nfXgNpRhNgfgV+nfXgNpRhNgfgV+nfggKpRhNgfgV+ngcf3pRhNgfgV+ngNf8pRhNgfgV+nf6gCpRhNgfgV+nf2gDpRhNgf
					gV+ngAgApRhNgfgV+ngDf/pRhNgfgV+ngCgApRhNgfgV+ngAgApRhNgfgV+ngAgApRhNgfgV+ngAgApR]],
				["Toe.R"] = [[
					hNgXgJ/8gAgAhmhNgXgJ/8gAgAhmhNgXgJ/8gAgAhmhNgXgJ/8gAgAhmhNgXgJ/8gAgAhmhNgXgJ/8f/gBhmhNgXgJ/8f+gBhmhNgXgJ/8f/gBhmhNgXgJ/8
					f7gDhmhNgXgJ/8f2gGhmhNgXgJ/8f3gFhmhNgXgJ/8f6gEhmhNgXgJ/8fzgIhmhNgXgJ/8fqgNhmhNgXgJ/8fugLhmhNgXgJ/8fygJhmhNgXgJ/8fpgNhmhN
					gXgJ/8fggThmhNgXgJ/8flgQhmhNgXgJ/8fogOhmhNgXgJ/8fhgThmhNgXgJ/8fcgWhmhNgXgJ/8fegUhmhNgXgJ/8fegUhmhNgXgJ/8fcgWhmhNgXgJ/8fb
					gWhmhNgXgJ/8fbgWhmhNgXgJ/8fbgWhmhNgXgJ/8fbgWhmhNgXgJ/8fjgRhmhNgXgJ/8gZfxhmhNgXgJ/8gMf5hmhNgXgJ/8f7gDhmhNgXgJ/8f3gFhmhNgX
					gJ/8gAgAhmhNgXgJ/8gDf+hmhNgXgJ/8gBf/hmhNgXgJ/8gAgAhmhNgXgJ/8gAgAhmhNgXgJ/8gAgAhm]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAhng8AEeZgKgUgAhpg8AEemgygSgAhtg8AEfDhRgSgAhwg8AEfqhigTgAhxg8AEgVhigVgAhvg8AEg8hRgXgAhrg8AEhZgygXgAhog8AEhngKgVgAhog8AE
					hjfhgTgAhrg8AEhNe9gSgAhvg8AEgrelgSgAhxg8AEgBecgUgAhwg8AEfXelgWgAhtg8AEe0e9gXgAhpg8AEeefhgW]],
				Spine1 = [[
					gAhoglBTefglozf/hpglBUevg0o7f+htglBafNg6pOf+hxglBefzg1phf+hyglBggcgmpmf+hvglBdg/gSpbf/hrglBXhYf6pGgAhoglBThifko2gBhoglBT
					hbfSo1gChrglBXhEfIpEgChvglBcghfHpZgChyglBgf4fRpmgChxglBffSfjpigBhtglBaezf6pRgBhqglBVehgRo8]],
				Spine2 = [[
					f9h+gBEKerg7vrf8iAgBETexg0v7f7iEgCEnfFglwff8iJgCE6fjgNw/f9iKgCE/gFfzxHf+iHgCExgmfcwxgAiCgCEchBfMwLgCh/gBENhSfFvvgEh+gBEN
					hUfHvvgFiCgCEchHfSwLgFiHgCEygtfmwxgEiKgCE/gMgAxHgDiJgCE6fqgZw/gBiFgCEnfLgtwef/iAgBETe1g5v6]],
				Neck1 = [[
					f7iUf0F4exhDyZf6iWf0Fxe1g7yPf6ibf2GTfJgqzAf7igf3HMflgR0Lf9ihf3H1gDfy08gAief2HxggfW03gCiZf1HDg5fDz9gEiVf0GLhLe8y0gGiVf0Fv
					hPfAyMgGiYf1F9hDfMyigGief2GvgqfizmgEihf3HlgMf+0pgCigf3H5fugd1Bf/icf2HdfTg10ff9iWf0Gme8hCzX]],
				Neck2 = [[
					f3i7fmFEeug/xLf2i9fmFIezg4xSf3jDfpFifHgox6f6jJfuGBfkgPypf+jLfxGRgEfzy/gCjIfwGGgjfZyvgGjCfsFog+fIyDgIi8fnFMhPfAxXgKi7flFD
					hRfDxJgKjAfnFThEfPxjgIjGfsFygrfkyTgFjKfwGMgMf/y5gAjKfxGPfsgby8f8jFfuF4fPgxybf5i/fpFYe4g9xr]],
				Head = [[
					fzjdfWAcecgZk8fzjffWAfeffxlOf1jlfcAie0fLlkf5jsfjAkfXetlwf+jufmAkgAeelpgEjrflAggoeglVgIjkfeAdhJezlAgMjefYAchffUk4gNjdfVAd
					hlf7lDgNjifZAhhYgjlZgKjpffAkg7hFlsgFjuflAkgUhdlvf/jtfmAifrhklgf6jnfiAefGhYlJf2jgfbAceqg+k6]],
				Jaw = [[
					fxjtez+2hmgSoUfyjwe0+7hTg1oCf2j3e5+/gvhPnyf7j+fB+5gBhcoLgCkAfE+1fVhZoagIj8fC+2ezhHoVgMj0e7+3eegooQgOjue1+1eXgCoXgPjtey+4
					ehfcoNgMjze2++e9e8n3gIj7e9+8fneon/gCkAfD+2gVekoVf7j+fE+0g9evoaf2j4e/+4hZfHoMfzjxe4+1hofroW]],
				Zip = [[
					f8iGeux+hChQ6af7iJeuychtht6Cf6iRev08iCh94Bf7iZew3lh0iC1cf9iaew4vhQhz0LgAiWew34gphH1QgCiNeu1YgCgF3zgEiHeuyufWfH57gFiHeux4
					enef6cgGiNeuzieEeK5MgFiVew2YeBd/2sgEiaew4ZeceD0igBiZew4jfEef0bf/iRev2xfrfZ2df9iJeuz8gUgc5B]],
				["UpperArm.L"] = [[
					e1iEfrzoPjk3yie0iHfrz9PYkayIeziPfs0xO8jLxCe0iWft1qOZhkvie2ibft2TN3gFuCe4iafs2mNbfAs5e7iWfr2pNFeXsPe9iTfq2nM6eFr/e+iTfq2m
					M7eCsBe/iWfr2oNIeRsUe/iaft2mNge3tAe9iafu2UN+f7uKe7iWfu1rOghcvqe5iPft0yPBjExJe3iIfsz9PakWyM]],
				["LowerArm.L"] = [[
					ekhhfgv64ga5r+ejhkfewn4tcErBehhufbx440eOpMehh5fXzQ4jg1m/eiiBfU0X38jPlAejiEfQ1H3Pk7jreliDfO1j2ulvjEeniAfN1w2ilvjFeoiAfN1t
					2qlIjgepiCfP1Y3Ej/kTepiEfR0t3piYlfeoiBfVzr4NgVnGenh5fZyX4ieGo+emhufcxC4kcIqtelhlffwF4ea8r1]],
				["UpperArm.R"] = [[
					hCiTfq2mzHh+r+hBiUfr2nzAh5sIhBiYfs2oythgsmhCibfu2fySgrtihEiZfu2CxxfXu5hGiTfu1PxPdvwbhIiLfs0VwxcOxvhKiFfrztwfbSydhMiFfrzu
					wgbQybhNiLfs0Vw1cIxqhMiTft1PxVdowUhLiZft2Bx4fOuxhJibft2fyYghtahGiYfr2pyxhYsghEiVfq2ozCh0sF]],
				["LowerArm.R"] = [[
					hYiAfN1xJdagjPhXiBfO1lJLbYj3hXiDfQ1FIqcxk1hXiDfT0PIEenmPhYh+fXzCHmgzoBhZh0faxrHbi9p4hahpfewfHfkmrXhbhiffv5HilQsChdhiffwK
					HakrrohehofdxNHNi9qMhfhzfZylHRgfoGhfh+fVz3Hud6l8heiDfS0yIbb0kQhciEfP1XJEakjShaiBfN1sJbaLjA]],
				Tail1 = [[
					gBhhhbjqhThY/ugChjhbi8gyhX/0gDhnhbiugKhF/2gDhqhbjIfigm/1gDhrhbj6e+gD/vgChohbkiejfh/ogBhkhbkmeZfD/mgAhhhbkDeiet/rf+hihbjR
					e8em/xf+hlhbiwfhew/2f9hphbi3gKfJ/2f9hrhbjggxfr/yf9hqhbkShRgO/rf+hmhbkqhkgv/mgAhjhbkZhlhJ/o]],
				Tail2 = [[
					gFhWiJlVjQgt/XgFhaiKj5h2hB/rgEhfiKjFgKhF/0gChhiKjceeg6/wgAhfiJkudCgn/ff+hbiImFcFgS/Kf8hXiImnbyf7/Bf7hWiJl+cQfg/Mf7hYiKkl
					dZfH/if8hciKjWe/e7/yf9hgiKjGgte//0f/hgiJkBiTfP/pgBhdiJldjhfj/UgDhZiImfkKf5/DgFhWiJmbkFgS/E]],
				Tail3 = [[
					gPhHi1hilpgk/cgLhPi4fjjrgy/xgEhVi5d+hGg1/5f+hWi4d3eZgn/3f3hRi2fTb+gR/ufyhJizhUaLf+/bfwhEizilZYfx/MfwhEi0iRZvfk/SfzhLi3gl
					bQfU/nf4hTi5eodlfL/3f/hXi5dtgRfQ/5gGhUi3ebi4fk/0gLhNi1gUlCf5/lgPhGiziHmXgJ/RgRhDiziommgV/M]],
				Tail4 = [[
					gghDjiXknvip9wgVhQjmValyiG9jgHhcjoTOi2hP9Kf5hdjnSafhgE89frhTjkTfcUex9LfhhFjfVzZrds9jfcg9jdXzYDdL9vfdg+jfYJX0dM9xflhJjkWm
					ZGdm9sfxhXjnUObneS9XgAhejnSle0fU9AgOhZjlSviIgm9BgahMjiUllHh19YgihAjeW8nTiq9rgkg8jeYOoQi49x]],
				Tail5 = [[
					gyhbkENooEmU4GgjhtkHL7m/lG3XgNh9kGJrkmjK2Of3iAkEIVhhgr1cfjh0kCIqeUd71tfThikAKhbZba2zfJhUj/MxZJZz30fKhVkBN1X+Zc4MfVhkkFM8
					YTaN30foh2kHKxaFbz2zf+iAkFI0c5eC1ugTh7kDIRgGgs1bgmhrkBJdjNja2Ngzhaj/Lsl2li3Xg4hTkANhnnmj4G]],
				["UpperLeg.L"] = [[
					e2gygg28e2ft2Qe0g1gj1hf1fU3qeyg7gm1bhzgX3rewhBgn/SiUermGeuhFgn/2ieeQgWeshGgm/5iJe/gJeshFgj/5hhf2h9eshDgg/kgvgilDeuhCgd/R
					gCgrmtewhDga+7fZguoGeyhFgY+Ie1gyqqe0hEgY9LeYgts/e2hAgY8PeEggu5e2g6ga65d+gMxMe2g0gd4zeOf40I]],
				["LowerLeg.L"] = [[
					ezgRgfU2fQfL99ezgUgmNRgcgX57e1gagpIVgbih1Xeug1gIgwjvjx/ieqhEgGtplakH8IeqhGgFz4ldjn4MeshAgC3Nk0i01Seug4gB4wjwh6z0evg1f/2h
					ihhd2iexgzf9xuhTg56lezgwf/tfgQgF9Ae0grgCpQfcfS+ne1glgGkBe4em/re1gcgMdiepeQ/0e0gUgWXYeyeh+v]],
				["Foot.L"] = [[
					ezgfgv+jeDgmpQezgogt98g4frrNezgvgn9Tj8eVsHezg0gd86jpeWtHezg1gT8rkvd1tLezgygI83k0d4sxezgsgA9YkJeVr1ezgkf8+KiyfDqRezgff/+l
					hVfmpRezgfgG+ngDf/pRezgfgN+me5gVpRezgfgU+jd9gopQezgfgb+fdOg2pPezgfgh+dc2g9pOezgfgo+edFg4pO]],
				["Toe.L"] = [[
					ezgXgj/4eQhDhmezgfgi/xgxfejoezglgc/WjbdbkrezgpgU/OjJdhlvezgqgJ/BkEcwl2ezgnf+/FkKcxlaezgif2/YjndYkYezgbfw/vieeairezgXfz/7
					hMfThmezgXf5/8gDf+hmezgXgA/7fBgmhmezgXgH/4eKhGhmezgXgO/0dghfhmezgXgV/ydLhshlezgXgc/zdZhkhm]],
				["UpperLeg.R"] = [[
					hThCgf/LfofOnHhRhDgc/LgTfUnIhPhEgZ+kg6fPpWhNhFgY9phbfPr5hLhCgY8uhzfYt9hKg9gZ7qiBfpv8hJg3gb57h+f+yphKgzge3vhhgP1ZhLgzgi2M
					gwgi3BhNg3gl01fcgq4RhPg+gn8jdugAuPhRhEgn/xdjhziDhThGgn/3dqhcf5hUhGgl/7eKglg4hUhDgi/ye4fyjW]],
				["LowerLeg.R"] = [[
					hRg0gB5Ic2eizfhQg0f+0DeIex40hOgyf+vifRfg78hNgugArcgMgV94hMgogDm0g4hF/OhLgggIg5hThp/6hMgXgRaOhWht/YhMgSgbVfhBhL+LhNgSgjQ2
					gOgU8KhNgWgqJ1e+e63BhNgkgSUbekck9lhVg/gGoibGb7+KhWhGgFxPaecE6EhVhEgD10azcx2lhTg9gB4Kbsdo0Y]],
				["Foot.R"] = [[
					hNgff7+jeCgmpQhNgfgC+nfVgNpRhNgfgJ+ngjf1pRhNgfgQ+khnfhpQhNgfgX+hidfRpPhNgfge+ejBfFpOhNgfgl+djJfDpOhNgfgs+higfQpPhNgkgv+R
					g1fuqUhNgsgq9gc0hSr4hNgygi9JdahJs5hNg1gY8vbpiAtNhNg0gN8ubJiNtChNgwgE9Fbbh9sXhNgof99wcehUrI]],
				["Toe.R"] = [[
					hNgXfv/4ePhDhmhNgXf2/8fZgXhmhNgXf9/8ggfthmhNgXgE/6hcfJhmhNgXgL/2iNeshmhNgXgS/yiteYhlhNgXgZ/yi0eUhlhNgXgg/2iPeqhmhNgbgj/3
					gvfiishNgigg/gdOiBkZhNgngZ/ZdxhvldhNgqgO/FcQjAl3hNgpgE/Bb0jUlthNglf6/NcCjAk+hNgffy/kc6iIjn]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAhug8/+gAgAhMgAhfg8/8f1e1hMgAhig8/7fweWhMgAhxg8/8f1e1hMgAhug8/+gAgAhMgAhfg8/8gLhLhMgAhig8/7gQhqhMgAhxg8/8gLhLhM]],
				Spine1 = [[
					gAhsglBDgAgAoDf+hdglA4gfhFnTf+hhglA8gshindf+hwglBHghhEoNgAhsglBDgAgAoDgChdglA4fhe7nTgChhglA8fUeendgChwglBHffe8oN]],
				Spine2 = [[
					gAiBgAEGgAgAvof8hwf/DZgug8uQf6h0gADkhChVujf8iFgAESgxg6v7gAiBgAEGgAgAvogEhwf/DZfSfEuQgGh0gADke+erujgEiFgAESfPfGv7]],
				Neck1 = [[
					gAiXfzHcgAgA0ff7iFfwFmg1g2yBf5iJfxGBhNhKykf7ibfzH6g7gv1AgAiXfzHcgAgA0fgFiFfwFmfLfKyBgHiJfxGBeze2ykgFibfzH6fFfR1A]],
				Neck2 = [[
					gAjAfrG7gAgAz3f6isfgFKg0g3xWf4ixfjFjhLhMx6f7jEfuHYg6gw0YgAjAfrG7gAgAz3gGisfgFKfMfJxWgIixfjFje1e0x6gFjEfuHYfGfQ0Y]],
				Head = [[
					gAjkfjA1gAgAnLf6jOfRAigXghlqf4jTfVAmgigul/f7jpfnA6gdgfnggAjkfjA1gAgAnLgGjOfRAifpfflqgIjTfVAmfefSl/gFjpfnA6fjfhng]],
				Jaw = [[
					gAj5fC+/gAgAn9f5jfev9zf+fYrof2jlez+Ff6fHq1f7j/fH/Lf0fXnIgAj5fC+/gAgAn9gHjfev9zgCgorogKjlez+FgGg5q1gFj/fH/LgMgpnI]],
				Zip = [[
					gAiIetwJgAgA7nf2hwesyKi+gp6Kfyh1es4JjQhW0sf2iOet2hihg32jgAiIetwJgAgA7ngKhwesyKdCfX6KgOh1es4Jcweq0sgKiOet2hdffJ2j]],
				["UpperArm.L"] = [[
					e5iOfqw1O+lt0bezh9ftuUQjnH3AexiBfwu+QnmW22e0iUfvxdPckd0me5iOfqw1O+lt0be/h7fit+PHod1ufBh+fhuiOpoT1Be/iSflxUOOl/zR]],
				["LowerArm.L"] = [[
					elhrflz24PhemUefhZfyzA4adsn2edhef0zT4eeDm8eehxfq0P4PhZk4elhrflz24PhemUerhXflyy4BfMpoeuhafhy73/gMpderhufdzw4Gi7mn]],
				["UpperArm.R"] = [[
					hHiOfqw1xCaT0bhBh7fit+w5Xj1ug/h+fhuixXXt1BhBiSflxUxyaBzRhHiOfqw1xCaT0bhNh9ftuUvdY53AhPiBfwu+vZZq22hMiUfvxdwkbj0m]],
				["LowerArm.R"] = [[
					hbhrflz2HxeimUhVhXflyyH/g0pohShafhy7IBf0pdhVhufdzwH6dFmnhbhrflz2HxeimUhhhZfyzAHmiUn2hjhef0zTHih9m8hihxfq0PHxenk4]],
				Tail1 = [[
					gAhrhbkTgrfy/sgChchbi6gmf1/2gDhfhbjIgKf9/1gChuhbkhfogI/qgAhrhbkTfVgO/sf+hchbi6fagL/2f9hfhbjIf2gD/1f+huhbkhgYf4/q]],
				Tail2 = [[
					gCheiJn8h8fP+6gEhTiKlcg3fs/ggEhWiKk3fQgQ/ngBhhiJnZeFgr/Df+heiJn8eEgx+6f8hTiKlcfJgU/gf8hWiKk3gwfw/nf/hhiJnZh7fV/D]],
				Tail3 = [[
					gHhHizlvjofG/QgGhDi3i5h9fg/zgChHi4g8fGgM/9f8hLi0jzcxgo/mf5hHizlvcYg6/Qf6hDi3i5eDgg/zf+hHi4g8g6f0/9gEhLi0jzjPfY/m]],
				Tail4 = [[
					gRg2jecalMgk/WgMg7jlaOjlgQ/Qf/hFjnXEf0f++tfzhAjgZOcNfa/Bfvg2jecaa0fc/Wf0g7jlaOcbfw/QgBhFjnXEgMgC+tgNhAjgZOjzgm/B]],
				Tail5 = [[
					gfhAkIRrlYi778gWhLkPQ3ktiO7sf+hdkNNmhFgj6IfphTkJOXc9eP6cfhhAkIRraodF78fqhLkPQ3bTdy7sgChdkNNme7fd6IgXhTkJOXjDhx6c]],
				["UpperLeg.L"] = [[
					exg+gkytgjg957evgwgq+slGlha+eug0gs95jJc/VeevhDgq/hiBg1k9exg+gk/CglgXntezguge/6e3fleNe1gxgc4NeLhF0zezhAgexefHhb6v]],
				["LowerLeg.L"] = [[
					ezgfguOugjg865e4g8gMfIcSm4/AemhIgT6Cq8mBtwexg5gK/Bl9gOlGeygvgG+4jCfwnxezgyf9wAgXfm7se0gQgXUIeze/9qe0gigrgafhf2//]],
				["Foot.L"] = [[
					ezgyg39lhFfksHezg8gh9EecgutPezg8gG55tZZ8rtezgyf19fmjd9qXezgkfz+yhGf7onezgfgI+leqgapRezgfgm+gdYgzpPezghhB+dehgepp]],
				["Toe.L"] = [[
					ezgogt/og8fUknezgxgX/aeqhEl0ezgxf979riW5lHezgpfq/Hl3cci7ezgdfn/9hCfqg6ezgXf8/7ezguhmezgXga/1dphahmezgZg1/5erg0h/]],
				["UpperLeg.R"] = [[
					hPg+gk/CfbfpnthNguge/6hJgbeNhLgxgc4Nh1e70zhNhAgexeg5el6vhPg+gkytfdfD57hRgwgq+sa6afa+hSg0gs95c3jBVehRhDgq/hd/fLk9]],
				["LowerLeg.R"] = [[
					hOgvgG+4c+gQnxhNgyf9wAfpga7shMgQgXUIhNhB9qhMgigrgagfgK//hNgfguOufdfE65hIg8gMfIjuZI/AhahIgT6CVEZ/twhPg5gK/BaDfylG]],
				["Foot.R"] = [[
					hNgkfz+ye6gFonhNgfgI+lhWfmpRhNgfgm+giofNpPhNghhB+dhffipphNgyg39le7gcsHhNg8gh9EhkfStPhNg8gG55SnmErthNgyf19fZdiDqX]],
				["Toe.R"] = [[
					hNgdfn/9e+gWg6hNgXf8/7hNfShmhNgXga/1iXemhmhNgZg1/5hVfMh/hNgogt/ofEgsknhNgxgX/ahWe8l0hNgxf979UepHlHhNgpfq/HaJjki7]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAh0g8AEgAgAhxgAh0g+AFgAgAh/gAhyhDAHgAgAijgAhvhIALgAgAjIgAhuhLANgAgAjbgAh1gvACgAgAg9gAh3gdABgAgAfigAh3gdABgAgAfigAh3gdAB
					gAgAfigAh3gfABfvgifsgAh2gnAEg0eegPgAh1gyADgVfahCgAh1g6AEfhg1hngAh0g8AEf+gEhxgAh0g8AEgAf/hxgAh0g8AEgAgAhx]],
				Spine1 = [[
					gAh3glB0gAgAqmgAh2gnB3gAgAqsgAh1gsB9gAgAq9gAh0gyCDgAgArOgAhzg1CHgAgArYgAh2gYBmgAgAp6gAh3gGBUgAgApAgAh3gGBUgAgApAgAh3gGBU
					gAgApAf/h3gJBWf6glpGgCh3gRBggVeTpegBh3gbBpgJfWqEf/h3gjBzfxg7qegAh3glB0f/gFqmgAh3glB0gAf/qmgAh3glB0gAgAqm]],
				Spine2 = [[
					gAiRgEFVgAgAxpgAiRgGFVgAgAxpgAiQgMFVgAgAxpgAiQgSFVgAgAxpgAiPgVFVgAgAxpgAiPf2E/gAgAxIgAiOfjEugAgAwtgAiOfjEugAgAwtgAiOfjEu
					gAgAwtf+iOflExgEgmwwgHiPfuE8f5eSw9gDiQf5FIf/fVxVf8iRgCFSgAg9xkgAiRgEFVgAgFxpgAiRgEFVgAf/xpgAiRgEFVgAgAxp]],
				Neck1 = [[
					gAipf6GzgAgAzsgAipf8G+gAgAz7gAiogCHcgAgA0fgAiogIH8gAgA1FgAingLIOgAgA1ZgAimfrGNgAgAy6gAilfXFLgAgAxagAilfXFLgAgAxagAilfXFL
					gAgAxaf9ilfZFSgFgmxkgJimfjFsf0eSyHgEiofuGPf8fVy8f7ipf4GrgFg9zhgAipf6GzgAgFzsgAipf6GzgAf/zsgAipf6GzgAgAzs]],
				Neck2 = [[
					gAjSfwFqgAgAyJgAjSfzF6gAgAyggAjRf6GkgAgAzZgAjRgCHSgAgA0UgAjRgGHsgAgA0ygAjOfeFBgAgAxKgAjLfGDxgAgAvCgAjLfGDxgAgAvCgAjLfGDx
					gAgAvCf8jLfJD5gBgmvPgMjNfUEYf8eRwBgFjQfiFAf/fVxIf5jRftFhgBg9x6f/jSfwFqgAgFyJgAjSfwFqgAf/yJgAjSfwFqgAgAyJ]],
				Head = [[
					gAj0fjAWgAgAkjgAj1fnAegAgAlXgAj1fwA4gAgAnWgAj1f7BcgAgApagAj1gBBygAgAqegAjwfOAMgAgAjUgAjqexABgAgAfjgAjqexABgAgAfjgAjqexAB
					gAgAfjf7jqe1ACfRgrf4gQjtfCALiKeGhNgGjxfSALg2fSi6f3jzffAVezg/kOf/j0fjAWf6gFkjgAj0fjAWgBf/kjgAj0fjAWgAgAkj]],
				Jaw = [[
					gAkEe//EgAgAnogAkGfE/EgAgAnngAkKfQ/JgAgAnUgAkPfe/WgAgAmZgAkRfl/KgAgAnNgAj8eq62gAgAxZgAjteL/UgAgAmigAjteL/UgAgAmigAjteL/U
					gAgAmif5jveO/Xg2ffmNgVj0ec/NddhWmYgIj9et/Be+gZnvf0kCe8+9hffin8f/kEe//EgHf+nogAkEe//Ef+gAnogAkEe//EgAgAno]],
				Zip = [[
					gAilezzAgAgA5vgAile10ahXhI4kgAike64gh1iN0XgAijfA5ohtiTy7gAijfE2lhQhQ2lgAifekyggAgA6GgAiceQzieme75RgAiceQ3yeGd31NgAiceQ49
					eOdwz0f7iceT10fReo3VgPieecyVeSgN6KgGiien0HgthN41f4ikew4eiwh70Vf/ilez5ohxiSy7gAilez2lhPhQ2lgAilezzAgAgA5v]],
				["UpperArm.L"] = [[
					e5iifw2dODgAuCe5iify2qNke0s/e5ihf426Mvbuqce5igf+2yMcYQn1e5iggB2lMjWZmie5iffh4HNpbapIe5idfO5COgb9one5idfO5COgb9one5idfO5C
					Ogb9one2icfS4+Ozb5pUfDiifS38NKeMpke9iifi3QNoe9r/e0iffx27OxfZuJe5iifw2eOGf+uEe5iifw2cOCgAuBe5iifw2dODgAuC]],
				["LowerArm.L"] = [[
					eliJfWzb4SgAngekiMfW0i3vhzl5ehiVfZ2p1tmFhteeiefe33yfqMdJedijfi4HwasEayejiUfA1Q3VirkjeliReszK4RfKoLeliReszK4RfKoLeliReszK
					4RfKoLehiPexy94je9nvexiSexz33XgHpHepiNfEzm37f/oKefiGfYzA4yflm8ekiIfXzZ4Uf+ndeliJfWzc4RgAnheliJfWzb4SgAng]],
				["UpperArm.R"] = [[
					hHiifw2dx9gAuChHiify2qychMs/hHihf426zRkSqchHigf+2yzknwn1hHiggB2lzdpnmihHiffh4HyXkmpIhHidfO5CxgkDonhHidfO5CxgkDonhHidfO5C
					xgkDonhEiefN40x6jcorhQibfg4mwnjlrZhLiffn3mxbhosqhCikfq2Xyqf7tPhHiifv2byBf+t/hHiifw2dx9gAuChHiifw2dx9gAuC]],
				["LowerArm.R"] = [[
					hbiJfWzbHugAnghciMfW0iIReNl5hfiVfZ2pKTZ7hthiiefe33NhV0dJhjijfi4HPmT8ayhdiUfA1QIrdVkjhbiReszKHvg2oLhbiReszKHvg2oLhbiReszK
					Hvg2oLhXiSerzYICgjoihmiJfCyjG5hUm1hgiJfLzEHYgjnThViMfPzzIPftoKhbiJfWzdHxf+njhbiJfWzbHugAnfhbiJfWzbHugAng]],
				Tail1 = [[
					gAhrhal0gAgA/dgAhqhcl0gAgA/dgAhnhhl0gAgA/dgAhkhml0gAgA/dgAhihol0gAgA/dgAhthOlVgAgA/igAhzg9k7gAgA/ngAhzg9k7gAgA/ngAhzg9k7
					gAgA/ngBhyg/k+hJgD/lf9hwhGlGcrfy/af/huhRlgeuf5/fgChshYluh1gM/bgAhrhal0gJgB/dgAhrhal0f+gA/dgAhrhal0gAgA/d]],
				Tail2 = [[
					gAhaiHnrgAgA/DgAhZiJndgAgA/HgAhWiNm7gAgA/PgAhTiSmWgAgA/WgAhRiVmDgAgA/agAhdh7nggAgA/GgAhkhqoHgAgA+8gAhkhqoHgAgA+8gAhkhqoH
					gAgA+8gFhkhsoDhuf0+6fzhihznvbBgf+of7heh9nyeEgJ++gHhbiFnoiwf3+8gBhaiHnrgOf//DgAhaiHnrf9gA/DgAhaiHnrgAgA/D]],
				Tail3 = [[
					gAhEixjzgAgA/xgAhDizjWgAgA/0gAhCi5iQgAgA/6gAhAi+hFgAgA/+gAg/jBgegAgA//gAhIilj8gAgA/vgAhNiUlkgAgA/ggAhNiUlkgAgA/ggAhNiUlk
					gAgA/ggJhMiWlbiUf6/cflhLibkuZTgK+7f1hHinkWdZgA/lgPhFiuj1jtgF/igBhEixjzgSgA/wgAhEixjzf8gA/xgAhEixjzgAgA/x]],
				Tail4 = [[
					gAg5jfZSgAgA/RgAg5jiYogAgA/IgAg7joXCgAgA+tgAg9juVXgAgA+KgAg+jxUggAgA92gAg8jTZvgAgA/XgAg8jAcXgAgA/ygAg8jAcXgAgA/ygAg8jAcX
					gAgA/ygQg8jCcKizgw/ofSg+jEbXX8ds+hfug6jUaTc4fB/Tgag6jbZfkahe++gCg5jfZSgWgH/RgAg5jfZSf8f+/RgAg5jfZSgAgA/R]],
				Tail5 = [[
					gAhMkJOYgAgA6sgAhOkKNpgAgA6MgAhUkOL4gAgA43gAhakRKHgAgA3VgAhdkSJPgAgA2egAhOj9PDgAgA7IgAhHjtSRgAgA85gAhHjtSRgAgA85gAhHjtSR
					gAgA85gYhIjtSEi2iB8le9hMjqRmX5aF6vflhLj+Puc4dm7QglhNkDO0kXjf6ZgDhMkJOYgWgS6sf/hMkJOYf8f86sgAhMkJOYgAgA6s]],
				["UpperLeg.L"] = [[
					exhKgb8sgAgAuIexhJgd89gAf/tmexhJgg9hgBf8sWexhIgk+AgCf6rGexhHgm+OgDf6qgexhIgR68f+gJxQexhJgD3PgAgY1/exhJgD3PgAgY1/exhJgD3P
					gAgY1/exhHgH4rgQf20XeyhNgE2pfGhf2iexhLgR6hfmgnx3exhHge9ZgmfPslexhKgc8xgDf8t+exhKgb8rf/gBuKexhKgb8sgAgAuI]],
				["LowerLeg.L"] = [[
					exgvgHtLhpgA9GexgwgItmhrgC86exgxgJuzhugG8UexgygLwRhygJ7fexgzgMxHh0gL6+exgqgDoYhaf8+2exgogBmRhLft/WexgogBmRhLft/WexgogBmR
					hLft/WexgngBlthlfp/cezgsgEprgQgE+feygsgEqJg+f++UewgvgHsyiff/9OexgvgHtMhugA9GexgvgHtLhogA9HexgvgHtLhpgA9G]],
				["Foot.L"] = [[
					ezgfgV+ngAgApRezgfgV+ngBgApRezgfgV+ngEf/pRezgfgV+ngHf+pRezgfgV+ngIf+pRezgfgV+nf7gBpRezgfgV+nfrgGpRezgfgV+nfrgGpRezgfgV+n
					frgGpRezgfgV+ngAgApRezgfgV+mfAgTpRezgfgV+nfigJpRezgfgV+ngsfzpRezgfgV+ngDf/pRezgfgV+nf/gApRezgfgV+ngAgApR]],
				["Toe.L"] = [[
					ezgXgJ/8gAgAhmezgXgJ/8gBf/hmezgXgJ/8gEf+hmezgXgJ/8gGf8hmezgXgJ/8gHf8hmezgXgJ/8f8gDhmezgXgJ/8fugLhmezgXgJ/8fugLhmezgXgJ/8
					fugLhmezgXgJ/8gAgAhmezgXgJ/7fHgihmezgXgJ/8flgQhmezgXgJ/8gofohmezgXgJ/8gDf+hmezgXgJ/8f/gAhmezgXgJ/8gAgAhm]],
				["UpperLeg.R"] = [[
					hPhKgb8sgAgAuIhPhJgd89gAgBtmhPhJgg9hf/gEsWhPhIgk+Af+gGrGhPhHgm+Of9gGqghPhIgR68gCf3xQhPhJgD3PgAfo1/hPhJgD3PgAfo1/hPhJgD3P
					gAfo1/hPhKgC2tgSfN2ghPhFgT7wfMhTv2hPhIgW8KfpgdvKhPhMgW7YgnfRwhhPhKgb8ogDf8uShPhKgb8tf/gBuGhPhKgb8sgAgAuI]],
				["LowerLeg.R"] = [[
					hPgvgHtLeXgA9GhPgwgItmeVf+86hPgxgJuzeSf68UhPgygLwReOf37fhPgzgMxHeMf16+hPgqgDoYemgE+2hPgogBmRe1gT/WhPgogBmRe1gT/WhPgogBmR
					e1gT/WhOgpgCnSfJgM/IhRgogCm0dWgT/JhQgsgEp2d+gG+XhOgvgGsjfLf+9ahPgvgHtKebgA9HhPgvgHtLeWgA9GhPgvgHtLeXgA9G]],
				["Foot.R"] = [[
					hNgfgV+ngAgApRhNgfgV+nf/gApRhNgfgV+nf8gBpRhNgfgV+nf5gCpRhNgfgV+nf4gCpRhNgfgV+ngFf/pRhNgfgV+ngVf6pRhNgfgV+ngVf6pRhNgfgV+n
					gVf6pRhNgfgV+ngjf1pRhNgfgV+mfGgRpRhNgfgV+nfogHpRhNgfgV+ngof0pRhNgfgV+ngDf/pRhNgfgV+nf/gApRhNgfgV+ngAgApR]],
				["Toe.R"] = [[
					hNgXgJ/8gAgAhmhNgXgJ/8f/gBhmhNgXgJ/8f8gChmhNgXgJ/8f6gEhmhNgXgJ/8f5gEhmhNgXgJ/8gEf9hmhNgXgJ/8gSf1hmhNgXgJ/8gSf1hmhNgXgJ/8
					gSf1hmhNgXgJ/8ggfthmhNgXgJ/8fMgfhmhNgXgJ/8fqgNhmhNgXgJ/8gkfqhmhNgXgJ/8gDf+hmhNgXgJ/8f/gAhmhNgXgJ/8gAgAhm]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAh0g8AEgAgAhxgAhzg8ADgAgAhkgAhxg8ACgAgAhGgAhvg8ACgAgAgugAhvg8ACgAgAgygAh1g8AGgAgAiQgAh6g8APgAgAjugAh7g8ARgAgAj/gAh7g8AR
					gAgAj/gAh7g8ARgAgAj/gAh7g8ARgAgAj/gAh7g8ARgAgAj/gAh7g8ARgAgAj/gAh7g8ARgAgAj/gAh7g8ARgAgAj/gAh7g8ARgAgAj/gAh7g8ARgAgAj/gA
					h6g8ARgAgAj9gAh4g8ALgAgAjLgAh1g8AFgAgAiIgAh0g8AEgAgAhxgAh0g8AEgAgAhxgAh0g8AEgAgAhx]],
				Spine1 = [[
					gAh3glB0gAgAqmgAh2glBugAgAqTgAhyglBggAgApogAhwglBVgAgApFgAhwglBXgAgApLgAh4glCEgAgArRgAh/gmC7gAgAtUgAiAgmDGgAgAtsgAiAgmDG
					gAgAtsgAiAgmDGgAgAtsgAiAgmDGgAgAtsgAiAgmDGgAgAtsgAiAgmDGgAgAtsgAiAgmDGgAgAtsgAiAgmDGgAgAtsgAiAgmDGgAgAtsgAiAgmDGgAgAtsgA
					iAgmDEgAgAtogAh9glClgAgAskgAh4glCAgAgArFgAh3glB0gAgAqmgAh3glB0gAgAqmgAh3glB0gAgAqm]],
				Spine2 = [[
					gAiRgEFVgAgAxpgAiPgEFGgAgAxTgAiLgCEmgAgAwggAiHgBEOgAgAv2gAiHgCESgAgAv9gAiUgFF3gAgAycgAifgKHrgAgA0xgAihgLICgAgA1MgAihgLIC
					gAgA1MgAihgLICgAgA1MgAihgLICgAgA1MgAihgLICgAgA1MgAihgLICgAgA1MgAihgLICgAgA1MgAihgLICgAgA1MgAihgLICgAgA1MgAihgLICgAgA1MgA
					ihgLH+gAgA1HgAibgIG/gAgAz7gAiUgFFugAgAyOgAiRgEFVgAgAxpgAiRgEFVgAgAxpgAiRgEFVgAgAxp]],
				Neck1 = [[
					gAipf6GzgAgAzsgAinf5GWgAgAzHgAihf2FagAgAxxgAidf0EsgAgAwpgAief1E0gAgAw2gAisf9HvgAgA02gAi5gGLMgAgA4SgAi7gIL3gAgA42gAi7gIL3
					gAgA42gAi7gIL3gAgA42gAi7gIL3gAgA42gAi7gIL3gAgA42gAi7gIL3gAgA42gAi7gIL3gAgA42gAi7gIL3gAgA42gAi7gIL3gAgA42gAi7gIL3gAgA42gA
					i6gHLwgAgA4wgAi1gCJ3gAgA3FgAisf8HhgAgA0lgAipf6GzgAgAzsgAipf6GzgAgAzsgAipf6GzgAgAzs]],
				Neck2 = [[
					gAjSfwFqgAgAyJgAjPftFJgAgAxXgAjIfmEDgAgAvjgAjCfhDQgAgAuCgAjDfiDZgAgAuTgAjWf2G1gAgAzvgAjigMLOgAgA4UgAjjgQMHgAgA5DgAjjgQMH
					gAgA5DgAjjgQMHgAgA5DgAjjgQMHgAgA5DgAjjgQMHgAgA5DgAjjgQMHgAgA5DgAjjgQMHgAgA5DgAjjgQMHgAgA5DgAjjgQMHgAgA5DgAjjgQMHgAgA5DgA
					jjgQL9gAgA47gAjegEJfgAgA2ugAjVf1GigAgAzWgAjSfwFqgAgAyJgAjSfwFqgAgAyJgAjSfwFqgAgAyJ]],
				Head = [[
					gAj0fjAWgAgAkjgAjxfeAMgAgAjUgAjnfTABgAgAgggAjffKAEgAgAeOgAjhfMADgAgAeogAj6fuA5f/fpnagAkGgSEIgNfGvqgAkHgZEIflh5vlgAkHgZEz
					gJfew1gAkHgZFHgbelxQgAkHgZELfmhvvqgAkHgZEpgAgAwkgAkHgZFOgheTxZgAkHgZEPfqhcv0gAkHgZEff3giwSgAkHgZFRgkeKxegAkHgZEWfwhCwCgA
					kHgYEOfxhAv0gAkDgECygKezs+gAj5frAsgAgGmfgAj0fjAWgAgAkjgAj0fjAWgAgAkjgAj0fjAWgAgAkj]],
				Jaw = [[
					gAkEe//EgAgAnogAj9e5/CgAgAnugAjtes+/gAgAn9gAjgek+8gAgAoJgAjiel+8gAgAoHgBkPfN/Nf3gVnBgCkqgC/efRgklrf8krgJ/Jhle5nEgBksgM/e
					figTlrgDksgN/iewgylKf8krgJ/Lhde/m+gAksgL/bgAgAl/gEksgO/jefg7k/f9krgJ/OhOfKm0f/krgK/XgdfsmTgEksgO/jeWhAk5f+krgK/Sg4famlf+
					krgI/Sg2fammgDkjfu/afMg6l6gAkNfJ/HgCf7nbgAkEe//EgAgAnogAkEe//EgAgAnogAkEe//EgAgAno]],
				Zip = [[
					gAilezzbgAgA5agAiheyzbg5gr5ZgAiXew1ChhhV4BgAiQeu3Dhyh32CgAiReu4OhuiB0ugAite15MhYhyzlgAjGfA44g6hI0EgAjKfC3KgRgS2EgAjKfC2u
					fefe2ggAjKfC4Se3er0wgAjKfC6eepd/xygAjKfC7xesdrvpgAjKfC7leyd5wBgAjKfC59e/elyngAjKfC3vfgfc1bgAjKfC2ngRgR2ngAjKfC3mg/hE1jgA
					jKfC5vhVh0y3gAi9e76ohdiOxhgAire15zhhiFyvgAilez37hWhh1JgAilez1Wg1gw3zgAilezzbgAgA5a]],
				["UpperArm.L"] = [[
					e5iifw2dODgAuCe5iffv2uODfqtle5iZft3TOFe3sle5iVfr3uOIeOrve5iVfr3qOHeVr4e5imfy3KMuZ7o1e5i0f61dOBQyi1e5i3f80zPBOthme5i3f80z
					PBOthme5i3f80zPBOthme5i3f80zPBOthme5i3f80zPBOthme5i3f80zPBOthme5i3f80zPBOthme5i3f80zPBOthme5i3f80zPBOthme5i3f80zPBOthme5
					i2f806O1PDhze5ivf32cMwVKlpe5ilfx20NJdfr2e5iifw2dODgAuCe5iifw2dODgAuCe5iifw2dODgAuC]],
				["LowerArm.L"] = [[
					eliJfWzb4SgAngeliHfUzk4SgenIeliEfQz34PhjmQeliBfN0F4KialjeliBfO0D4LiRlqegiffS3K1DmmgnebjFfk4kses4WGeajMfr4JqDttTteajMfr4J
					qDttTteajMfr4JqDttTteajMfr4JqDttTteajMfr4JqDttTteajMfr4JqDttTteajMfr4JqDttTteajMfr4JqDttTteajMfr4JqDttTteajMfr4JqDttTtea
					jLfq4PqdtmUGedi2fa4nw8qWbJeiiUfU1b3Hi8kreliJfWzb4SgAngeliJfWzb4SgAngeliJfWzb4SgAng]],
				["UpperArm.R"] = [[
					hHiifw2dx9gAuChHiffv2ux9gWtlhHiZft3Tx7hJslhHiVfr3ux4hyrvhHiVfr3qx5hrr4hHimfy3KzSmFo1hHi0f61dx/vOi1hHi3f80zw/xThmhHi3f80z
					w/xThmhHi3f80zw/xThmhHi3f80zw/xThmhHi3f80zw/xThmhHi3f80zw/xThmhHi3f80zw/xThmhHi3f80zw/xThmhHi3f80zw/xThmhHi3f80zw/xThmhH
					i2f806xLw9hzhHivf32czQq2lphHilfx20y3ihr2hHiifw2dx9gAuChHiifw2dx9gAuChHiifw2dx9gAuC]],
				["LowerArm.R"] = [[
					hbiJfWzbHugAnghbiHfUzkHufinIhbiEfQz3HxedmQhbiBfN0FH2dmljhbiBfO0DH1dvlqhgiffS3KK9ZagnhljFfk4kTiTIWGhmjMfr4JV9STTthmjMfr4J
					V9STTthmjMfr4JV9STTthmjMfr4JV9STTthmjMfr4JV9STTthmjMfr4JV9STTthmjMfr4JV9STTthmjMfr4JV9STTthmjMfr4JV9STTthmjMfr4JV9STTthm
					jLfq4PVjSaUGhji2fa4nPEVqbJheiUfU1bI5dEkrhbiJfWzbHugAnghbiJfWzbHugAnghbiJfWzbHugAng]],
				Tail1 = [[
					gAhrhal0gAgA/dgAhrhal2gAgA/cgAhphbl8gAgA/bgAhohbmBgAgA/agAhohbmAgAgA/bgAhrhal8f0gC/bgAhthZmAfigF/agAhthZmCg/f1/ZgAhthZmC
					fugD/agAhthZmCfQgI/agAhthZmCg6f2/agAhthZmCgAgA/agAhthZmCfGgK/agAhthZmCgwf4/agAhthZmCgSf9/agAhthZmCfBgL/ZgAhthZmCgif6/agA
					hthZmBgif6/agAhshZl9fYgH/bgAhshal2gDf//dgAhrhal0gAgA/dgAhrhal0gAgA/dgAhrhal0gAgA/d]],
				Tail2 = [[
					gAhaiHnrgAgA/DgAhZiHn9gAgA+/gAhXiHomgAgA+0gAhWiHpHgAgA+qgAhWiHpBgAgA+sf/haiGndf4gC/Hf/hbiFmJeugV/XgDhciFl7hlfp/Zf/hciFl7
					gKf7/bf+hciFl7eTgb/ZgDhciFl7hRfv/agAhciFl7gqfz/bf9hciFl7eMgc/YgChciFl7g2f2/bgBhciFl7hHft/af9hciFl7ePga/YgChciFl7gXf9/bgB
					hciFl9hcfo/Zf+hbiGmlfAgP/SgAhaiHnaf+gA/HgAhaiHnrgAgA/DgAhaiHnrgAgA/DgAhaiHnrgAgA/D]],
				Tail3 = [[
					gAhEixjzgAgA/xgAhCixkVgAgA/sgAg/iwligAgA/ggAg8ivmggAgA/UgAg8ivmVgAgA/Wf/hEixjOgKf+/1f7hJixged7gR/6gHhKixgAhjf+/9gAhKiygB
					hFfu/+f5hKixgAdkgR/5gGhKixgBg8gD/+gChKiygAhqfs/8f4hKixgAdsgN/6gFhKixgBgRgJ//gEhKixgAiGfr/6f4hKixgAd/gI/7gDhKiygBflgO//gF
					hKixgFiUft/6f7hIixhafCgE/8gAhFixjNf1gC/1gAhEixjzgAgA/xgAhEixjzgAgA/xgAhEixjzgAgA/x]],
				Tail4 = [[
					gAg5jfZSgAgA/RgAg2jeaEgAgA/bgAgvjcb0gAgA/tgAgpjbdQgAgA/3gAgqjbdAgAgA/2gAg6jfYYgfgF/Ef1hIjgUbdtfd9ugMhKjgTxgsgi9igDhKjhTx
					iCgM9ffyhKjgTxdofU9dgJhKjhTxf9gZ9jgHhKjhTxibgY9dfyhKjgTxeDfU9fgFhKjhTxfNgN9igKhKjgTyiogh9cfyhKjgTxeofX9hgBhKjhTxeigB9hgM
					hKjgT5ijgn9ff5hEjgVwfjfw+TgAg8jgYZfsf8/EgAg5jfZSgAgA/RgAg5jfZSgAgA/RgAg5jfZSgAgA/R]],
				Tail5 = [[
					gAhMkJOYgAgA6sgAhGkJPQgAgA7QgAg6kJRTgAgA8agAgxkITBgAgA9PgAgzkIStgAgA9GgBhQkINVgmgY59fvhnkCJJeges2SgNhqkBIefdgc1qgIhqkBIg
					iJhK1kfshqkAIfexem1ngIhqkBIee5gA1pgNhqkAIhiKhZ1kfthqkAIffUe11ogDhqkBIfeafl1ngQhqkAIhiAhh1kfvhqkAIef7fK1pf9hqkBIgeDfL1mgS
					hqkAInhqhf1tf4hfkFKggQf23rf/hRkINXfrfz5/gAhMkJOYgAgA6sgAhMkJOYgAgA6sgAhMkJOYgAgA6s]],
				["UpperLeg.L"] = [[
					exhKgb8sgAgAuIexhIgc9BgAf9teexhFgd9pgCf2sAexhCge+GgDfwq1exhCge+BgDfxrCexhLga8Pf/gFvBexhTgW5dgCgczXexhVgW4lgDgh0eexhVgW4l
					gDgh0eexhVgW4lgDgh0eexhVgW4lgDgh0eexhVgW4lgDgh0eexhVgW4lgDgh0eexhVgW4lgDgh0eexhVgW4lgDgh0eexhVgW4lgDgh0eexhVgW4lgDgh0eex
					hVgW4wgDgg0QexhRgY6rgAgTxpexhLga8RgAgEu9exhKgb8sgAgAuIexhKgb8sgAgAuIexhKgb8sgAgAuI]],
				["LowerLeg.L"] = [[
					exgvgHtLhpgA9GexgvgGslhrgF9XexgugFrdhvgP90ewgtgFqthzgZ+GewgtgFq0hzgX+DexgwgItjhlf888eygzgOyEhafo6Xeyg0gQzdhZfk5Weyg0gQzd
					hZfk5Weyg0gQzdhZfk5Weyg0gQzdhZfk5Weyg0gQzdhZfk5Weyg0gQzdhZfk5Weyg0gQzdhZfk5Weyg0gQzdhZfk5Weyg0gQzdhZfk5Weyg0gQzdhZfk5Wey
					g0gPzMhZfl5jexgygLwIhdfu7lexgwgItvhmf782exgvgHtLhpgA9GexgvgHtLhpgA9GexgvgHtLhpgA9G]],
				["Foot.L"] = [[
					ezgfgV+ngAgApRezgfgV+ngFf/pRezgfgV+ngQf7pRezgfgV+ngaf4pRezgfgV+ngYf5pRezgfgV+nf6gCpRezgfgV+nffgKpRezgfgV+nfZgMpRezgfgV+n
					fZgMpRezgfgV+nfZgMpRezgfgV+nfZgMpRezgfgV+nfZgMpRezgfgV+nfZgMpRezgfgV+nfZgMpRezgfgV+nfZgMpRezgfgV+nfZgMpRezgfgV+nfZgMpRez
					gfgV+nfagLpRezgfgV+nfogHpRezgfgV+nf6gCpRezgfgV+ngAgApRezgfgV+ngAgApRezgfgV+ngAgApR]],
				["Toe.L"] = [[
					ezgXgJ/8gAgAhmezgXgJ/8gEf9hmezgXgJ/8gOf3hmezgXgJ/8gXfyhmezgXgJ/8gVfzhmezgXgJ/8f6gDhmezgXgJ/8figShmezgXgJ/8fdgVhmezgXgJ/8
					fdgVhmezgXgJ/8fdgVhmezgXgJ/8fdgVhmezgXgJ/8fdgVhmezgXgJ/8fdgVhmezgXgJ/8fdgVhmezgXgJ/8fdgVhmezgXgJ/8fdgVhmezgXgJ/8fdgVhmez
					gXgJ/8fegUhmezgXgJ/8fqgNhmezgXgJ/8f7gDhmezgXgJ/8gAgAhmezgXgJ/8gAgAhmezgXgJ/8gAgAhm]],
				["UpperLeg.R"] = [[
					hPhKgb8sgAgAuIhPhIgc9BgAgDtehPhFgd9pf+gKsAhPhCge+Gf9gQq1hPhCge+Bf9gPrChPhLga8PgBf7vBhPhTgW5df+fkzXhPhVgW4lf9ff0ehPhVgW4l
					f9ff0ehPhVgW4lf9ff0ehPhVgW4lf9ff0ehPhVgW4lf9ff0ehPhVgW4lf9ff0ehPhVgW4lf9ff0ehPhVgW4lf9ff0ehPhVgW4lf9ff0ehPhVgW4lf9ff0ehP
					hVgW4wf9fg0QhPhRgY6rgAftxphPhLga8RgAf8u9hPhKgb8sgAgAuIhPhKgb8sgAgAuIhPhKgb8sgAgAuI]],
				["LowerLeg.R"] = [[
					hPgvgHtLeXgA9GhPgvgGsleVf79XhPgugFrdeRfx90hQgtgFqteNfn+GhQgtgFq0eNfp+DhPgwgItjebgE88hOgzgOyEemgY6XhOg0gQzdengc5WhOg0gQzd
					engc5WhOg0gQzdengc5WhOg0gQzdengc5WhOg0gQzdengc5WhOg0gQzdengc5WhOg0gQzdengc5WhOg0gQzdengc5WhOg0gQzdengc5WhOg0gQzdengc5WhO
					g0gPzMengb5jhPgygLwIejgS7lhPgwgItveagF82hPgvgHtLeXgA9GhPgvgHtLeXgA9GhPgvgHtLeXgA9G]],
				["Foot.R"] = [[
					hNgfgV+ngAgApRhNgfgV+nf7gBpRhNgfgV+nfwgFpRhNgfgV+nfmgIpRhNgfgV+nfogHpRhNgfgV+ngGf+pRhNgfgV+nghf2pRhNgfgV+ngnf0pRhNgfgV+n
					gnf0pRhNgfgV+ngnf0pRhNgfgV+ngnf0pRhNgfgV+ngnf0pRhNgfgV+ngnf0pRhNgfgV+ngnf0pRhNgfgV+ngnf0pRhNgfgV+ngnf0pRhNgfgV+ngnf0pRhN
					gfgV+ngmf1pRhNgfgV+ngYf5pRhNgfgV+ngGf+pRhNgfgV+ngAgApRhNgfgV+ngAgApRhNgfgV+ngAgApR]],
				["Toe.R"] = [[
					hNgXgJ/8gAgAhmhNgXgJ/8f8gDhmhNgXgJ/8fygJhmhNgXgJ/8fpgOhmhNgXgJ/8frgNhmhNgXgJ/8gGf9hmhNgXgJ/8gefuhmhNgXgJ/8gjfrhmhNgXgJ/8
					gjfrhmhNgXgJ/8gjfrhmhNgXgJ/8gjfrhmhNgXgJ/8gjfrhmhNgXgJ/8gjfrhmhNgXgJ/8gjfrhmhNgXgJ/8gjfrhmhNgXgJ/8gjfrhmhNgXgJ/8gjfrhmhN
					gXgJ/8gifshmhNgXgJ/8gWfzhmhNgXgJ/8gFf9hmhNgXgJ/8gAgAhmhNgXgJ/8gAgAhmhNgXgJ/8gAgAhm]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAh0g8AEgAgAhxgAhyg8AEgDgrhjgAheg8AEgLhlgGgAiEg8AKgDhmiigAigg8ASf/g/kDgAiqg8AWgAgAkjgAigg8ASgBfBkDgAiEg8AKf9eaiigAheg8AE
					f1ebgFgAhng8ADf7fBgwgAhkg8ABgAgAgkgAiSg8ANgAg/jUgAimg8AXf9hmkXgAiog8AYf9hmkdgAiYg8APgAg/jngAhwg8ADgAgAhTgAhkg8ACf6fBgkgA
					h0g8AHf6eahvgAh0g8AGf8e0hxgAh0g8AEf/fwhxgAh0g8AEgAgAhx]],
				Spine1 = [[
					gAh3glB0gAgAqmf/h0glBugPgpqSf+heglBIgkhfoLf+iIglCMgghhref/imgmC9gSg8tWgAiwgmDOgAgAt8gBimgmC9fufEtWgCiIglCMfgefregCheglBH
					fcehoKgBhoglBXfqfFpIgAhlglBRgAgAo3f/iXglCkgTg8sdf+isgmDJgchittf+iugmDNgchit1f/idgmCtgSg8s0gAhyglBlgAgAp3gBhlglBSfqfFo3gC
					h3glB2feegqigCh3glB2fne4qlgAh3glB0f7fxqmgAh3glB0gAgAqm]],
				Spine2 = [[
					gAiRgEFUgAgAxpf+iNgEFGgYgkxRf6hzgADqg4hVuvf6ikgGGAg3hWykf9jGgKHighg20lgAjRgMICgAgA1MgDjGgKHifffK0lgGikgGGAfJeqykgGhzgADq
					fIeruugDh/gCERfdfLv5gAh8gBEEgAgAvlf9i1gIGygig1zpf7jNgLH4g1hX08f7jPgMH/g1hX1Ef9i8gJHEgig10BgAiLgDEwgAgAwvgDh8gBEFfdfLvkgG
					iRgEFUfIerxkgEiRgEFWfWfAxogBiRgEFVf3fzxpgAiRgEFVgAgAxp]],
				Neck1 = [[
					gAipf6GygAgAzsf9ilf5GXgagjzHf5iIfyDzg5hUu/f6i9f+IAg/hQ1Ff8jggGK5gpgw4BgAjrgIL3gAgA42gEjggGK5fXfQ4BgGi9f+IAfBew1FgHiIfyDy
					fHeru+gEiVf1E3fbfNw5gAiSf0EhgAgAwXf8jOgCJegogx2rf6jngILihDhN4hf6jpgILuhDhN4sf8jVgDKBgogw3NgAiif3FugAgAyPgEiSf0EifcfMwXgH
					ipf6GxfBewzlgFipf6G0fRfEzrgBipf6Gzf2f0zsgAipf6GzgAgAzs]],
				Neck2 = [[
					gAjSfwFqgAgAyIf9jNftFQgYgkxif3irfaC8g0hYtRf5jmf4Gyg7hTzmf8kJgLJfgmgy2tgAkUgRKagAgA3mgEkJgLJffafO2tgHjmf4GyfFetzmgJirfaC7
					fMeotPgFi7fiD5fffLvOgAi2fgDlgAgAusf8j4gCIJglgz1Sf6kQgPKGg+hR3Qf6kSgQKSg+hR3bf8j/gGIqglgz12gAjJfoErgAgAwogFi2fgDmfffKurgI
					jRfwFofGesyCgGjSfwFrfVfByIgBjSfwFqf3fzyJgAjSfwFqgAgAyJ]],
				Head = [[
					gAj0fjAWgAgAkjf8jvfeAhejg3lZf1jHfCAUcpiehZf4kKfvBccphmoqf8kugLCod+gssegAk5gUDDgAgAtngEkugLCoiCfUsegIkKfvBcjXeaoqgLjHfCAU
					jXdihXgGjafOATiGeojdgAjVfKAJgAgAixf7kdf+B7d8g1qqf5k1gRDGcvhBtRf6k3gTDNcwg/tgf8kkgDCMd9gyrXgAjqfXAagAgAk+gGjVfKAPiGeli1gJ
					j0fiA/jXeLmygHj0fjAxijelmSgBj0fjAcgifslHgAj0fjAWgAgAkj]],
				Jaw = [[
					gAkEe//EgAgAnof5kAe79fhsgEsTfujOed6JkLgDx8fxkifR9ojpgvref4lNf0++iCgrntgAlZgA/UgAgAmigIlNf0++d+fVntgPkifR9ocXfRregSjOed6I
					b1f9x+gLjmeq7adgf2wUgAjgel7IgAgAw9f3k5fj+ciJglplfzlUf8/EjOhKmzfzlXf+/IjMhLmif4lBfq+qiHgno2gAj6e08PgAgAvCgLjgem7Fdef4w2gQ
					kHfC83cOfctPgMkHfB9kdGfzr3gCkFfA+qfZgDpGgAkEe//EgAgAno]],
				Zip = [[
					gAilezxQgAgA68f6ifeyxviNgu6hfyh2et0Hj2hG4jfyi+e365jNiVw2f4jsfA8liXi6t3gAj7fD6thrilxVgIjsfA2JgLhg3CgOi+e3x6eFgd6cgOh1etwo
					ckfp7GgJiIev2rcpd/2OgAiDeu5UdZcizEf4jVe77Yeob3v9fzj1fC5Lfnc5zffzj4fD1dg2es3rf4jee9zph6gU5LgAiZew0EiZh84ugJiDeu3liKj31KgO
					ikez6phck+w8gKilez5JhajvzXgCilez07hUhd4HgAilezxQgAgA68]],
				["UpperArm.L"] = [[
					e5iifw2dODgAuCe2iefy0/LZY7qYexiAfwzvLZUXomeyi2f608PiOYhye1jaf/1LOHQdjne5jnf904L5T9mLe+jcf217NvRwiYfBi3fs2gPWQigEfBh+fi0/
					K2Wempe+iNfnzeJnY5pme5iJfr0mLbUynBe1jJf71RQMOHgkeyjhgD0+OePzjqeyjkgE0aMWTGnWe1jPf81GNxQ4kGe5iaft1oOUQoibe+iJfm0/LRVcmafB
					ihfp0OJ+X7n+e/iifr2MLrXbmne6iifv2uMxdCrUe5iifw2dODgAuC]],
				["LowerArm.L"] = [[
					eliJfWzb4SgAngeZiYfV4+zHl3gCeRiGfY6Ux7ikeSeSjLfq4czQjTZUeVjrfq5Zwwm6Y9ebjwfi5zu1qVabehjsfe5Fw7ogaDeljLfW4FztlvbSemiDfE5v
					ySlIgDehiLfJ6Iwqn7gQebiQfP6ByAkYeZeVjefs4IzKkkYseSjyfw5YwlmrYOeRjsfs6Kuzo8ZueVjffn5jw7mhZiebisfY4ozxjKb/ehiQfJ51yHlLe8em
					ijfK55wOpce7elikfL4tzglugYejiSfQ1Y2+hAmKeliJfWzb4SgAng]],
				["UpperArm.R"] = [[
					hHiifw2dx9gAuChEiefs2tzjphl4g/h/fi1A1Jpjmog/i3fs0i1so6nOhCjcf217yRuQiYhHjnf91uuyyMerhLjaf/1Lx5vjjnhOi2f6zq0xq3pYhPiAfwzu
					0nroomhMiNfw1DyGvfjnhHiJfr0m0lrOnBhCjJfy0t1GqKmzg/jkf12LyJuIhqg/jmf22eu9xCd4hCjQf012ymt2i4hHiaftzg14oZpshMiJfv0N0ar3nohO
					ihf304xGw/imhMiif11fzyqNoHhIiifx2bzIi6sGhHiifw2dx9gAuC]],
				["LowerArm.R"] = [[
					hbiJfWzbHugAngheiifN4ALGdRhehaiEfE5vNua4gChbi6fN5zQIV+d8hfjsfe5FPFXgaDhlj/fu3kNFZfX0hrjrfq5ZPQZGY9hvi5fi6mQSYlcUhviGfY6U
					OFddeThriefb42MUeMcJhliQfP6BOAboeZhfjPfV52QhV0cjhbj1fc43PKWwaAhcj+fk3aM4YWY6hfjgfb5OO5X5aohliafR6YPnYYe9hsiRfW6MOHcbd2hu
					i0fm4pMndcaQhrikfa5EMicJe7hgiRfU14JQdMkWhbiJfWzbHugAng]],
				Tail1 = [[
					gAhrhal0gAgA/dgBhphalvjmfT/QgDhYhblXmZeM+1gDh6halyjOfk/TgCiThZl5d2gG/XgAibhYl1argE+/f+iThZl2b4gL/Lf9h6halzgEf//df9hYhblc
					jXfD/Vf+hghblljQfN/UgAhehblkgAgA/ggCiGhZl1crgT/RgDiYhYl4cggF/QgDiahYl7f8gA/cgCiLhZl1kHfu/LgAhohblllOe6/Cf+hehblkiGfe/bf9
					hrhalxc0gm/Tf+hrhalvbGg6/EgAhrhalzesgP/bgAhrhal0gAgA/d]],
				Tail2 = [[
					gAhaiHnrgAgA/DgLhYiGntk/es+ngUhIiEoJq+cG8qgMhpiFmunDem+cf8iCiFlldUgK/YfxiLiCkyWPgp+EfyiCiElTXKg9+Rf9hpiGm6e9gP/NgGhIiHoe
					mnds+CgHhPiHn/oNdh9xgAhNiIoWimfQ+xf4h1iFmKalgw+6f5iHiElDXcg2+ZgDiJiFlMcAgo/TgOh6iEl8kpfm/FgPhXiFnfpfda9ggEhNiHoMmtd8+Hf0
					haiGnrd9gh+/fwhaiFndYnh1+Kf8haiHnpdbgp+8gAhaiHnrgAgA/D]],
				Tail3 = [[
					gAhEixjzgAgA/xgZhBiukDksfW/Ygvguijlqu0ck7kgfhVish+sJfD9hf0hxixfififZ/+fVh8ineVT2e79hfahyipfKSNf382f6hVixiObXgg/kgXgvisl/
					n0eG+Ygcg3iqk4s9dx8wgHg1iwlWnOe7+rfphjiug2bIfw/mfhh4iqeqTvfk9gf3h5iweqW3ga+ogbhpiugZicgs/4gnhAinkAsLeM9QgVg1itlLr6d89Kfu
					hEiwj1hgf1/ufchEiqjqXqhA+pf1hEiwjxcKgd/igAhEixjzgAgA/x]],
				Tail4 = [[
					gAg5jfZSgAgA/Rgmg1jZZxiggZ/RhTgbi7dywhhR7ShAhOjOYFwKkJ6HfyhzjgTUkIf69Fe0iCjISmVYaI6Ye1h0jHUZPoaD4MfthOjeXZWld89QgsgcjSc/
					magA/Mg+gnjIcVvtia7hgbgljYcWsKiT9RfbhhjbVKeseg+CfAh8jLTJTeaj56feh9jYS/SxcI5xgihojdUhdsg29whHgzjHaksEiG9Dg0gljMcuvuie7jfz
					g4jdZfmbhZ+nfFg5jSZdZBeg+ffqg5jdZXbefC+8gAg5jfZSgAgA/R]],
				Tail5 = [[
					gAhMkJOYgAgA6sgthHkDO6fYfX7Bh7gijPUruZl65jhjhnjePtv1rfzXf9iUj+I/odj90KeiinjcIEbaXGyseYiWjRLzSKS8v5fWhmj9N7T8YB2Eg+glj7Sm
					i5fp85hjg0jeTWuSn24cg6gxj3T3t+ot4mfZh+j+KKjvgd3DepigjcI8YGWFyLfEifjnKAS9VhwGgbiGj/J7Y5dX13hlhEjlQFoZky6BhagwjjUTvaor39gE
					hLkEPppqmZ47ezhMj3Oicidt6efehMkFOlcCdY6ZgAhMkJOYgAgA6s]],
				["UpperLeg.L"] = [[
					exhKgb8tgAgAuIewhHgf9qgufir+eugxgo/ziXeOhueuhbgh85hpfStnevh6gb3ohMga1hexiFgU2fgGgr2vezh7gR1ufFg93ce0hcgS6beUhAx6e0gvgY9d
					eCgbsUezg6gZ99e8gSrKexg3gf/AgPfnn4evhrgc6thDf8xleuiAgd4AhzgO1FeuiCgd38hygN1Jevhwgc5uhGgGy/exhFgd+IgEfyqwezg3ga+Le9gQqje0
					hJgU7beTg5wWe0hKgW7veugrv4exhKga8ifvgJueexhKgb8sgAgAuI]],
				["LowerLeg.L"] = [[
					exgvgHtLhpgA9HevgvgHtRiwgi8+ergtgHsQlMjw82euhBgMwwj9gY69exhZgX3einfH1keyhkgV2ZhVfc2zezhagT1sgMfw3ge0g9gFrkfLfZ9ze0gYgBac
					fKes/dezgkgAjrgHfp/xewgngBmUh1hF/SewhMgPy7i2fp5oexhfgY3yjTe61GexhhgY3vjRe51KexhRgS0gixfc4ZewgwgDonhtgh+wezgigAiTgHfs/6e0
					gsgEqBfMfR+XezgtgFq8fzfd+DexgvgHsrhRf59WexgvgHtLhpgA9G]],
				["Foot.L"] = [[
					ezgfgV+ngAgApRezgfgV+mhLfppRezgfgV+Pk0ejpKezgugV9miDfLr7ezhDgV8Wggf0u0ezhOgV7ZfbgewgezhFgV8Aebg3vXezgugV9ldvg6r7ezgfgV+h
					dmgvpPezgfgV+me1gXpRezgfgV+mg8fupRezg3gV9Ig0fptMezhKgW75hLfivnezhMgW7whKfjv2ezg7gV86grfstrezgkgV+Sgbf3qSezgfgV+me5gVpRez
					gfgV+idugspQezgfgV+keSghpQezgfgV+nfpgHpRezgfgV+ngAgApR]],
				["Toe.L"] = [[
					ezgXgJ/8gAgAhmezgXgJ/7hDfYhmezgXgJ/jkUdbhlezgkgL/mhyetkbezg3gN/FgcfsnhezhCgO+kfjgmpZezg4gN+4erhOoJezgkgL/leChckbezgXgJ/2
					d2hShmezgXgJ/7e9gohmezgXgJ/8g2fghmezgsgM/dgsfdlxezg9gO+1hBfRoaezg/gO+xhBfSorezgwgM/XglfimSezgbgK/4gYfwiqezgXgJ/7fAgmhmez
					gXgJ/3d9hOhmezgXgJ/5edg7hmezgXgJ/8fsgMhmezgXgJ/8gAgAhm]],
				["UpperLeg.R"] = [[
					hPhKgb8tgAgAuIhOhGgZ8xgufst+hMgwgY9dh+flsThMhcgS6bhsfAx6hNh7gR1ug7fD3chPiFgU2ff6fV2vhRh6gb3oe0fm1hhShbgh85eXgutnhSgxgo/z
					dphyhqhRg7gj/Metg/m6hPg3gf/AfxgZn4hNhrgT4zhAfL0LhMiDgN1Bhke24ChMiFgN1Ahke24DhNhygS3Xg+fH10hPhFgd+If8gOqwhRg4gk/aemhElyhS
					hJgk9jeWg3sIhRhKgh9UewgpsthQhKgd82fvgJt0hPhKgb8sgAgAuI]],
				["LowerLeg.R"] = [[
					hPgvgHtLeXgA9HhOgsgEqMfZgQ+UhMgYgBakg3hU/fhMg9gFrkg1gn9zhNhagT1sf0gQ3ghOhkgV2Zergk2zhPhZgX3edZg51khShBgMwwcDfo69hVgtgHsQ
					a0cP82hSgsgFqrcheF95hQgngBmUeLe7/ShNhLgMw/f6gX7HhMhigS1CghgD4GhMhkgS1AghgD4IhNhQgQzdf3gU5ZhQgwgDoneTff+whTgsgFqNcadw+BhS
					gygMwdb3fW7HhSgygLvucffh7ohQgwgItrd+f582hPgvgHtLeXgA9G]],
				["Foot.R"] = [[
					hNgfgV+ngAgApRhNgfgV+mg5fvpRhNgfgV+hiafRpPhNgugV9liRfGr7hNhFgV8AhlfJvXhNhOgV7ZglfiwghNhDgV8WfggMu0hNgugV9md9g1r7hNgfgV+P
					bKhepKhNgfgV+gddgxpPhNgfgV+mfEgSpRhNg3gV9GhjfTtMhNhMgV7JiKexwwhNhOgU69iKewxChNg7gV84hkfQtqhNgkgV+SflgJqShNgfgV+fdLg3pPhN
					gfgV+idugspQhNgfgV+keTghpQhNgfgV+nfpgHpRhNgfgV+ngAgApR]],
				["Toe.R"] = [[
					hNgXgJ/8gAgAhmhNgXgJ/8gzfhhmhNgXgJ/2iKethmhNgkgL/lh+ekkbhNg4gN+4hVeyoJhNhCgO+kgdfapZhNg3gN/FfkgUnhhNgkgL/meOhTkbhNgXgJ/j
					bqimhlhNgXgJ/1dthYhmhNgXgJ/8fKgghmhNgsgM/bhVe8lwhNg/gO+YhzeSpshNhBgO+ShyeRqBhNgwgM/UhWe6mShNgbgK/4fogQiqhNgXgJ/0dehhhmhN
					gXgJ/3d9hOhmhNgXgJ/5eeg6hmhNgXgJ/8fsgMhmhNgXgJ/8gAgAhm]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAh0g8AEgAgAhxgAh0g8ALgAgAjIgAh0g8ARgAgAj9gAh1g8ALgAgAjOgAh3g+AGgAgAiKgAh8hCAEgAgAhxgAiChHAEgAgAhxgAiIhMAEgAgAhxgAiLhPAE
					f7gAhygAiNhQAHelgFh9gAiQhQAXb6gKiTgAiShQA+YtgMirgAiVhQB0V2gIi/gAiWhQCfUGgDjJgAiWhQCkT6gDjKgAiVhQCIVAgGjEgAiWhQCNUzgFjFgA
					iWhQCnTygCjLgAiXhQCoTxgCjLgAiXhQCoTxgCjLgAiXhQCoTxgCjLgAiXhQCoTxgCjLgAiXhQCoTxgCjL]],
				Spine1 = [[
					gAh3glB0gAgAqmgAh5glCTgAgAr3gAh6gmCogAgAspgAh5gmCVgAgAr8gAh6gnB5gAgAqzgAh/gsBrgAgAqKgAiFgxBkgAgAp1gAiKg1BegAgAphgAiOg4Ba
					f6gCpVgAiQg5BfeZggpbf/iTg5B5bZhYpqf/iWg6CyXwiVpzf+iZg6D9UijGpxf+iag6E3Skjhprf+ibg6E+SWjjpqf+iZg6EYTljTpvf+iag6EeTXjWpuf+
					ibg6FCSOjlppf+ibg6FDSMjlppf+ibg6FDSMjlppf+ibg6FDSMjlppf+ibg6FDSMjlppf+ibg6FDSMjlpp]],
				Spine2 = [[
					gAiRgEFVgAgAxpgAiWgHGGgAgAywgAiZgJGmgAgAzcgAiWgHGJgAgAy0gAiVgHFXgAgAxsgAiYgKE2gAgAw5gAidgOEegAgAwTgAiigTEKgAgAvvgAilgVD8
					f6gDvXf9iogWECeVg+vZf4iqgXEkbMiuvefzisgYFqXZktvQfuisgYHEUCmWuxfsisgYIJR/nSuTfrisgYIRRxnYuPftisgYHkTDmzujftisgYHsS0m6ugfr
					isgYIWRpncuNfrisgYIXRnncuNfrisgYIXRnncuNfrisgYIXRnncuNfrisgYIXRnncuNfrisgYIXRnncuN]],
				Neck1 = [[
					gAipf6GzgAgAzsgAivf/IygAgA1/gAiygCKIgAgA3VgAivf/I6gAgA2IgAitf9G+gAgAz6gAivf+F1gAgAyZgAi0gCFIgAgAxWgAi4gFEhgAgAwXgAi7gHEI
					f6gEvsf7i+gJELeLhLvofxi/gKEyaujRvnfmi+gLGGWklqvMfdi7gLHxS7nnuYfZi4gLJCQwottsfYi4gLJMQho0tmfbi6gLIXR3oKuEfai6gLIgRooRt/fY
					i4gLJSQYo5tjfYi4gLJTQWo6tifYi4gLJTQWo6tifYi4gLJTQWo6tifYi4gLJTQWo6tifYi4gLJTQWo6ti]],
				Neck2 = [[
					gAjSfwFqgAgAyJgAjYf8HggAgA0kgAjbgEIxgAgA1/gAjZf9HngAgA0sgAjWfzFtgAgAyNgAjXfwEggAgAwVgAjafxDrgAgAu3gAjdfxC/gAgAtef/jffyCk
					f4gEshf2jhfzCnd1hMsZfjjhf1DWZxjTsWfOjaf2E/U7lqrxe/jQf3HJQwngqxe3jHf3IxOUogp6e3jGf3I+ODonp0e7jMf3H5PkoAqYe6jLf3IFPSoHqSe2
					jFf3JFN6orpwe2jFf3JHN3ospve2jFf3JHN3ospve2jFf3JHN3ospve2jFf3JHN3ospve2jFf3JHN3ospv]],
				Head = [[
					gAj0fjAWgAgAkjgAj9f2BdgAgApggAkAgCCjgAgAsegAj9f3BjgAgApygAj4fmAagAgAk9gAj3ffAEgAgAhtgAj5fcABgAgAfegAj5fZAIgAgAdZf/j6fYAR
					f1f/cBfxj7fZAbdAf0b2fWj5fbBaXefYcTe5jtfeD5RGexc7eljbffHTL6eNdfecjNfeJ8JDd3d0ecjLfeKQIwd1d2ehjUfeIiKgeCdpegjTfeI1KLeAdreb
					jKfeKcIldzd3ebjKfeKfIjdzd3ebjKfeKfIjdzd3ebjKfeKfIjdzd3ebjKfeKfIjdzd3ebjKfeKfIjdzd3]],
				Jaw = [[
					gAkEe//qgAgAkngAkWfZ/qgAgAkngAkffr/qgAgAkngAkYfb/pgAgAksgAkJfD/fgAgAlogAkAe5/HgAgAnbgAj8e1+hgAgAplgAj4ez91gAgArjf/j1ey9T
					gKgEs1fyj2ez8+i0hEtOfYj0e178n7jPtBe8jqe35ftqmHsPeojae42PyLowrCefjNe4zw0mqWqEeejLe4ze02qhp9ejjUe41FzYpiqmeijSe40zzqptqfee
					jKe4zT0/qnp5eejKe4zQ1Cqpp3eejKe4zQ1Cqpp3eejKe4zQ1Cqpp3eejKe4zQ1Cqpp3eejKe4zQ1Cqpp3]],
				Zip = [[
					gAilez2ngAgA2ngAixe33jgAgA1pgAi3e74HgAgA1BgAixe43ogAgA1kgAipe13AgAgA2PgAine328gAgA2TgAipe73LgAgA2DgAiqe/3ZgAgA10gAirfC3j
					gDgC1pf8iufD3sg7gr1df2iyfE3xiph+1Jfui1fE3rkqjn0sfoi1fF3YmZlK0Ofli1fF3HnbmKz6fli1fF3FnimRz3fni1fF3Qm5lo0Ffmi1fF3OnAlw0Cfl
					i1fF3DnmmVz2fli1fF3DnnmWz2fli1fF3DnnmWz2fli1fF3DnnmWz2fli1fF3DnnmWz2fli1fF3DnnmWz2]],
				["UpperArm.L"] = [[
					e5iifw2dODgAuCe5iof04zOacapRe5isf35xPAaPmFe5ipf045OccOpAe5imfz2eODf+t/e5iof10COQiwxTe5isf5x0Ouk3zle5iwf8vhPXmw1ce5iyf/t7
					P7oD2ge1itgAuKQPpe2AexifgBviQkrg0SexiOgAxNRCtqxye2iAf/ytRmvSvPe8h4f+zoSAwHthe8h3f+zuSDwMtVe5h8f/zKRyvsube5h7f/zQR1vyuOe9
					h2f+zySFwPtOe9h2f+zzSGwQtMe9h2f+zzSGwQtMe9h2f+zzSGwQtMe9h2f+zzSGwQtMe9h2f+zzSGwQtM]],
				["LowerArm.L"] = [[
					eliJfWzb4SgAngelibfT0i3zk2jeelinfT0z3Anzg4elicfT0k3wlEjSeliNfZzS4Sfjn3eliIfkxc3wa8rYeliJfwvW2nXJuFeliMf8tC1AT0wPeliOgDrS
					zrRzxiekiHgFqWzhSZyuemh3gDpez6Uy0SeuhlgAof0RYB11e7hXf8np0fbL21fGhQf5nJ0ldO3QfHhPf4nG0mdc3SfAhTf6na0icJ3DfBhTf6nW0jcY3GfI
					hPf4nE0mdl3UfIhPf4nD0mdn3UfIhPf4nD0mdn3UfIhPf4nD0mdn3UfIhPf4nD0mdn3UfIhPf4nD0mdn3U]],
				["UpperArm.R"] = [[
					hHiifw2dx9gAuChHiof04zxmjmpRhHisf35xxAlxmFhHipf045xkjypAhHimfz2ex9gCt/hHiof10CxwdQxThHisf5x0xSbJzlhHiwf8vhwpZQ1chHizf/t3
					wHYG2khCi+gAtAwKZI3Xg2jPgBsQwhb74KgkjhgCrbwyfg4tgRjtgFqww6i34xgEjxgGqXw9k94lgDjygGqUw9lM4jgLjvgFqkw8j34tgKjwgFqhw8kG4rgC
					jygGqSw9lV4igCjygGqSw9lX4hgCjygGqSw9lX4hgCjygGqSw9lX4hgCjygGqSw9lX4hgCjygGqSw9lX4h]],
				["LowerArm.R"] = [[
					hbiJfWzbHugAnghbibfT0iINbKjehbinfT0zJAYNg4hbicfT0kIQa8jShbiNfZzSHugdn3hbiIfkxcIQlErYhbiJfwvWJZo3uFhbiMf8tCLAsMwPhbiQgDrX
					MXuUxbhZicgGrkM1vpwphSiygIs7NBxCuVhFjKgKujNVyVrQg1jbgNwANtzEoRgqjkgPw5OAzUmWgpjkgPw/OCzWmJgwjfgOwcN1zNnXgvjggOwiN4zPnJgo
					jlgPxDOEzWmBgojlgQxEOEzWl/gojlgQxEOEzWl/gojlgQxEOEzWl/gojlgQxEOEzWl/gojlgQxEOEzWl/]],
				Tail1 = [[
					gAhrhal0gAgA/dgAhphZnJgAgA/LgAhnhZn9gAgA+/gAhphanQgAgA/KgAhthcmbgAgA/VgAhzhhmcgAgA/VgAh5hmm8gAgA/OgAh+hrnZgAgA/IgAiChunt
					gAgF/DgBiEhun+gChb+8gCiGhuoWgEkF+ngEiIhuo1gCnR94gGiLhupTf9qG85gGiNhupmf5r08IgGiNhupof4sA8DgGiMhupcf7q78jgGiMhupef7rH8dgG
					iNhuppf4sH7/gGiNhupqf4sJ7+gGiNhupqf4sJ7+gGiNhupqf4sJ7+gGiNhupqf4sJ7+gGiNhupqf4sJ7+]],
				Tail2 = [[
					gAhaiHnrgAgA/DgAhUiEo/gAgA+tgAhQiDpzgAgA+dgAhUiEpHgAgA+qgAhbiIoggAgA+1gAhgiNo7gAgA+ugAhliRp4gAgA+bgAhpiVqxgAgA+IgAhsiYrX
					gAgF96gChtiYrsf6hc9vgGhuiXsIftkH9UgKhwiWsvfZnU8agOhyiVtYfGqH7OgRhziVt0e6ry6UgRhziVt3e5r+6NgPhyiVtlfAq76zgQhziVtpe/rH6tgR
					h0iVt5e4sE6JgRh0iVt5e4sG6IgRh0iVt5e4sG6IgRh0iVt5e4sG6IgRh0iVt5e4sG6IgRh0iVt5e4sG6I]],
				Tail3 = [[
					gAhEixjzgAgA/xgAg6itlJgAgA/kgAg0ipl+gAgA/bgAg6islSgAgA/jgAhCixk3gAgA/ngAhHi1ltgAgA/egAhJi4nMgAgA/LgAhLi6ojgAgA+1gAhMi8pd
					f+gF+kgDhMi7p5fhha+YgJhNi6qbelkA98gRhNi3rUdcnE89gYhPi0sVcbpr7qgdhQiztDb1rN6pgehQiztIbxrY6hgbhPi0srcJqb7MgbhQizswcEqm7Fge
					hQiytLbvre6dgehQiytMburg6cgehQiytMburg6cgehQiytMburg6cgehQiytMburg6cgehQiytMburg6c]],
				Tail4 = [[
					gAg5jfZSgAgA/RgAgrjZangAgA/igAgjjVbdgAgA/qgAgqjZaygAgA/jgAg0jealgAgA/hgAg2jhb0gAgA/tgAg0jid1gAgA/6gAgyjjfsgAgA//gAgxjjg9
					f8gE/+gDgxjhhhe5hG/6gJgvjfiQc0jF/mgSgtjajnaWlX+0gagsjVlRYQnP9ugggsjRmeXEoT83ghgsjQmnW8oa8wgdgsjTl1Xrnw9UgegsjSl9Xin49Ogh
					gsjQmsW3oe8sgigsjQmtW2of8rgigsjQmtW2of8rgigsjQmtW2of8rgigsjQmtW2of8rgigsjQmtW2of8r]],
				Tail5 = [[
					gAhMkJOYgAgA6sgAg6kFPhgAgA7agAgwkBQQgAgA72gAg5kEPrgAgA7ggAhDkJPsgAgA7hgAhCkNRJgAgA8VgAg6kQTbgAgA9agAgzkQVngAgA+QgAgvkQXG
					f6gC+ugAgskPXwebge+3gBgokLYqbhhR+ygEghkEadYIiH+bgJgZj6cuVYiv93gOgUj0eYT3jD9ZgPgUjzelTtjF9VgLgXj3dfUoi59qgMgWj2drUdi79mgP
					gUjyesTojG9TgPgUjyeuTmjG9TgPgUjyeuTmjG9TgPgUjyeuTmjG9TgPgUjyeuTmjG9TgPgUjyeuTmjG9T]],
				["UpperLeg.L"] = [[
					exhKgb8sgAgAuIexhNgY9RgAgAs6exhPgW9mgAgAsIexhNgY9XgCgBsrexhNgd9qgggTr9exhRgi+qhTg9o9exhXgn/giEh/kuexhdgs/uiijJguexhggv/k
					ixj+eDe1hcgv/UkGkHdAe+hTgu+0mpj9cVfMhLgr96pujzbjfbhGgp8zsbjsa7fkhEgn7+uEjpakflhEgn74uQjpahffhFgo8atOjrawfghFgo8Utajqatfm
					hEgn70uXjpagfmhEgn7zuYjpagfmhEgn7zuYjpagfmhEgn7zuYjpagfmhEgn7zuYjpagfmhEgn7zuYjpag]],
				["LowerLeg.L"] = [[
					exgvgHtLhpgA9Gexg0gBuZhpgE8hexg3f+vJhpgH8Iexg1gButhqgI8Xeyg2gFwqh3gv7Pe0hAgG1ZiLiA3me2hOgH6Viajjxpe3hcgL9digk9rMe5hlgP+p
					ikl4mie9hkgQ+vj0mWk3fFhdgO+WmTm1j+fRhWgM9kpPnci4fdhTgK8kr1n/h4fmhSgJ7ztZoVhQfnhSgJ7utjoXhMfhhSgJ8OsloJhlfihSgJ8IswoMhgfn
					hSgI7qtqoZhJfohSgI7ptroZhJfohSgI7ptroZhJfohSgI7ptroZhJfohSgI7ptroZhJfohSgI7ptroZhJ]],
				["Foot.L"] = [[
					ezgfgV+ngAgApRezgjgO+/gAgAn+ezglgK/LgAgAnJezgjgN/DgDgBnqe0gjgO/agjgMmBe3gqgI/7hggnhLe7g7f//bilhQaye/hPf89zjgiAVFfBhdf88G
					kIihRgfGhef97SlbiEQWfOhZf76jnsg3P8fbhVf55aqbfdPnfohUf34Js2ePPffwhVf23PuUdhPgfxhVf23IufdcPhfshVf33ttkd5PffthVf33ntudzPffy
					hVf23EuldZPhfyhVf23DumdYPhfyhVf23DumdYPhfyhVf23DumdYPhfyhVf23DumdYPhfyhVf23DumdYPh]],
				["Toe.L"] = [[
					ezgXgJ/8gAgAhmezgcgB//gAgAgPezgff9//gAgAfZezgcgA//gDgAf7e1gegB/8glgDeQe4gpf5/RhmgOZbe8hAfy9PizgmTWe/hYfx6Rj4hGONfChpf03w
					kohdLJfFhrf12slwgsKOfMhmf014nqe+J/fWhhfy0sp+c8J9fhhffwzbsCbMKJfohffvyjtTaIKYfphffvydtcaBKafkhffwzBsparKQflhffwy7syajKRfp
					hffvyZthZ8KbfphffvyYtiZ7KcfphffvyYtiZ7KcfphffvyYtiZ7KcfphffvyYtiZ7KcfphffvyYtiZ7Kc]],
				["UpperLeg.R"] = [[
					hPhKgb8sgAgAuIhPhNgY9RgAgAs6hPhPgW9mgAgAsIhPhNgY9Xf+f/srhPhNgd9qfgftr9hPhRgi+qetfDo9hPhXgn/gd8eBkuhPhdgs/udec3guhPhhgv/k
					dZcBeEhThqgv/keubrdYhXh8gv/ihbbhdZhaiRgw/NksbcdchZilgx+onpbgdhhXixgy+JpcbmdlhWizgy+FppbndmhYirgy+aohbidjhYisgy+XotbjdkhW
					izgz+DpxbndmhWi0gz+CpybndmhWi0gz+CpybndmhWi0gz+CpybndmhWi0gz+CpybndmhWi0gz+Cpybndm]],
				["LowerLeg.R"] = [[
					hPgvgHtLeXgA9GhPg0gBuZeXf88hhPg3f+vJeXf58IhPg1gButeWf48XhOg2gFwqeJfR7PhMhAgG1Zd1eA3mhKhOgH6VdmcdxphJhcgL9ddgbDrMhHhmgP+q
					dlaKmkhKhwgQ+9e8aJlZhOiBgP/BhlarlhhQiVgQ+ykxbblohPiogR+UnncPlrhNizgT94pXczlshMi1gT91pjc3lshOitgS+HodcglshNivgS+EoqcklshM
					i1gT9zpqc6lshMi1gT9ypsc6lshMi1gT9ypsc6lshMi1gT9ypsc6lshMi1gT9ypsc6lshMi1gT9ypsc6ls]],
				["Foot.R"] = [[
					hNgfgV+ngAgApRhNgjgO+/gAgAn+hNglgK/LgAgAnJhNgjgN/Df9f/nqhMgjgO/afdf0mBhJgqgI/7egfZhLhFg7f//bdbewayhBhPf89zcgeAVFg/hef88H
					cBdaRhhChpf97qdDclQlhHh5f87pfcbVQnhLiNf97XiZZ6QyhMiff+64lGYwRGhLirf/6dmyYFRXhLisf/6am+YBRZhLilf+6sl6YbROhLimf+6pmGYWRQhK
					itf/6YnFX+RbhKitf/6YnHX+RbhKitf/6YnHX+RbhKitf/6YnHX+RbhKitf/6YnHX+RbhKitf/6YnHX+Rb]],
				["Toe.R"] = [[
					hNgXgJ/8gAgAhmhNgcgB//gAgAgPhNgff9//gAgAfZhNgcgA//f9gAf7hLgegB/8fbf9eQhIgpf5/ReafyZbhEhAfy9PdNfaTWhBhYfx6RcIe6ONg/hqf03y
					bgedLJhBh2f13HcUdaKXhEiFf13GeVbnKZhFiYf224g3ZhKohEiqf32fjMXvLDhCi0f42JkrWsLahCi2f42Gk1WkLchDivf32Vj6XOLNhDiwf42SkEXHLQhB
					i2f42Ek7WgLehBi2f42Ek9WfLfhBi2f42Ek9WfLfhBi2f42Ek9WfLfhBi2f42Ek9WfLfhBi2f42Ek9WfLf]],
			},
		},
	},
}
