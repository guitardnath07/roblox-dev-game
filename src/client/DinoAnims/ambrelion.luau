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
					gAjSgpAHgAgAiXgAjTgpAHgBgIiXgAjUgpAHgBgRiXgAjUgpAHgCgYiXgAjVgpAHgCgfiXgAjVgpAHgDgmiXgAjVgpAHgDgriXgAjUgpAHgEgwiXgAjUgpAH
					gEgziXgAjTgpAHgEg1iXgAjSgpAHgEg1iXgAjRgpAHgEg1iXgAjRgpAHgEgziXgAjQgpAHgEgwiXgAjQgpAHgDgriXgAjQgpAHgDgmiXgAjQgpAHgCgfiXgA
					jQgpAHgCgYiXgAjRgpAHgBgRiXgAjRgpAHgBgIiXgAjSgpAHgAgAiXgAjTgpAHf/f4iXgAjUgpAHf/fviXgAjUgpAHf+foiXgAjVgpAHf+fhiXgAjVgpAHf9
					faiXgAjVgpAHf9fViXgAjUgpAHf8fQiXgAjUgpAHf8fNiXgAjTgpAHf8fLiXgAjSgpAHf8fLiXgAjRgpAHf8fLiXgAjRgpAHf8fNiXgAjQgpAHf8fQiXgAjQ
					gpAHf9fViXgAjQgpAHf9faiXgAjQgpAHf+fhiXgAjQgpAHf+foiXgAjRgpAHf/fviXgAjRgpAHf/f4iX]],
				Spine1 = [[
					gAjXgKAmgAgAmFgAjYgKAogCgImNf/jYgKApgDgQmVf/jZgKArgFgYmaf/jZgKAsgGgfmef/jagKAsgIglmff/jZgKAsgJgqmef/jZgKArgKgvmaf+jYgKAq
					gKgymUf+jYgKApgKg0mNf+jXgKAngKg1mFf+jWgKAlgKg0l9f+jVgKAkgJgyl2f/jVgKAjgJgvlwf/jUgKAigIgrlsf/jUgKAigHgllrf/jUgKAigGgflsf/
					jVgKAigEgYlwf/jVgKAjgDgQl2gAjWgKAlgCgIl9gAjXgKAmgAgAmFgAjYgKAof+f4mNgBjYgKApf9fwmVgBjZgKArf7fomagBjZgKAsf6fhmegBjagKAsf4
					fbmfgBjZgKAsf3fWmegBjZgKArf2fRmagCjYgKAqf2fOmUgCjYgKApf2fMmNgCjXgKAnf2fLmFgCjWgKAlf2fMl9gCjVgKAkf3fOl2gBjVgKAjf3fRlwgBjU
					gKAif4fVlsgBjUgKAif5fblrgBjUgKAif6fhlsgBjVgKAif8folwgBjVgKAjf9fwl2gAjWgKAlf+f4l9]],
				Spine2 = [[
					gAjufQBggAgApnf/jvfRBlgDgIp3f/jwfRBpgFgQqFf+jxfRBtgIgXqRf9jyfRBwgKgeqYf9jyfRBxgMgkqaf8jyfRBwgOgpqYf8jxfRBugPgtqQf8jwfRBq
					gQgwqFf7jvfRBlgQgyp3f7jufRBggQgzpnf7jtfQBbgQgzpXf8jsfQBXgPgxpJf8jrfQBUgNguo+f8jqfQBRgMgqo2f9jqfQBRgKgko0f9jqfQBRgJgeo3f+
					jrfQBTgHgXo+f/jsfQBXgFgQpJf/jtfQBbgCgIpYgAjufQBggAgApngBjvfRBlf9f4p3gBjwfRBpf7fwqFgCjxfRBtf4fpqRgDjyfRBwf2fiqYgDjyfRBxf0
					fcqagEjyfRBwfyfXqYgEjxfRBufxfTqQgEjwfRBqfwfQqFgFjvfRBlfwfOp3gFjufRBgfwfNpngFjtfQBbfwfNpXgEjsfQBXfxfPpJgEjrfQBUfzfSo+gEjq
					fQBRf0fWo2gDjqfQBRf2fco0gDjqfQBRf3fio3gCjrfQBTf5fpo+gBjsfQBXf7fwpJgBjtfQBbf+f4pY]],
				Neck1 = [[
					gAkAe2FJgAgAxXf/kCe3FMgFgHxcf+kEe3FPgJgOxgf9kFe3FRgNgUxjf9kGe4FTgRgaxmf8kGe4FTgVggxmf7kGe4FTgYgkxlf7kFe3FRgagoxjf6kEe3FP
					gcgrxgf6kCe3FNgdgsxcf6kAe2FKgdgtxXf6j/e2FHgdgtxSf6j9e1FEgbgrxOf7j8e1FCgagoxLf7j7e1FAgXglxJf8j7e1FAgUggxIf8j7e1FAgRgbxJf9
					j8e1FBgNgVxLf+j9e1FDgJgOxPf/j/e2FGgFgHxTgAkAe2FJgAgAxXgBkCe3FMf7f5xcgCkEe3FPf3fyxggDkFe3FRfzfsxjgDkGe4FTfvfmxmgEkGe4FTfr
					fgxmgFkGe4FTfofcxlgFkFe3FRfmfYxjgGkEe3FPfkfVxggGkCe3FNfjfUxcgGkAe2FKfjfTxXgGj/e2FHfjfTxSgGj9e1FEflfVxOgFj8e1FCfmfYxLgFj7
					e1FAfpfbxJgEj7e1FAfsfgxIgEj7e1FAfvflxJgDj8e1FBfzfrxLgCj9e1FDf3fyxPgBj/e2FGf7f5xT]],
				Neck2 = [[
					gAk1eeG/gAgAz8f/k3efHDgFgH0Af+k5egHGgKgN0Ef9k6egHJgPgT0Hf8k7ehHKgUgY0Jf7k7ehHLgYgd0Kf6k7ehHKgbgi0Jf6k6egHJgegl0Hf5k5egHG
					gggo0Ef5k3efHDghgp0Af5k1eeHAghgqz8f5kzeeG8ghgpz3f5kyedG5gggozzf5kwecG3gdgmzwf6kwecG1gbgizuf7kvecG1gXgezuf8kwecG1gTgZzvf9
					kwecG3gPgTzxf+kyedG5gKgNz0f/kzedG8gFgHz4gAk1eeG/gAgAz8gBk3efHDf7f50AgCk5egHGf2fz0EgDk6egHJfxft0HgEk7ehHKfsfo0JgFk7ehHLfo
					fj0KgGk7ehHKflfe0JgGk6egHJfifb0HgHk5egHGfgfY0EgHk3efHDfffX0AgHk1eeHAfffWz8gHkzeeG8fffXz3gHkyedG5fgfYzzgHkwecG3fjfazwgGkw
					ecG1flfezugFkvecG1fpfizugEkwecG1ftfnzvgDkwecG3fxftzxgCkyedG5f2fzz0gBkzedG8f7f5z4]],
				Head = [[
					gAlkeUAKgQiyhTf/lleVAMgPi4hgf+lneWANgOi6hxf9loeWANgMi3iEf8lpeXAOgLiviXf7lqeXAPgJikiof6lpeXAPgIiUi2f5loeXAOgIiAjAf5lneWAN
					gHhqjDf4lleVAMgGhRjBf4lkeUAKgFg1i5f4lieTAIgDgZisf4lgeSAHgBf8ibf5lfeRAGf+ffiIf6leeRAFf7fDh1f6ldeRAFf3eohkf7leeRAGf0eQhWf8
					lfeRAHfyd6hNf+lgeSAIfwdohJf/lieTAJfwdZhLgAlkeUAKfwdOhTgBlleVAMfxdIhggClneWANfydGhxgDloeWANf0dJiEgElpeXAOf1dRiXgFlqeXAPf3
					dciogGlpeXAPf4dsi2gHloeXAOf4eAjAgHlneWANf5eWjDgIlleVAMf6evjBgIlkeUAKf7fLi5gIlieTAIf9fnisgIlgeSAHf/gEibgHlfeRAGgCghiIgGle
					eRAFgFg9h1gGldeRAFgJhYhkgFleeRAGgMhwhWgElfeRAHgOiGhNgClgeSAIgQiYhJgBlieTAJgQinhL]],
				Jaw = [[
					f1lpdV/xgFdOicfzlsdW/wgIdIigfylvdX/wgLdGiefxlxdY/xgNdJiXfxlzdZ/zgOdRiLfwl0dZ/1gOddh9fxl1dZ/3gNdshsfxl1dY/5gKeAhbfyl0dX/7
					gHeWhMfzlydW/8gEevhAf1lvdV/+gBfKg3f3ltdU/+gAfnhEf5lqdT/9f/gEhVf7lndS/8f+ghhof9lldR/6f+g+h7gAlkdR/4f+hYiMgCljdR/2f+hxiagF
					lkdS/0f+iHijgHlldT/yf+iZingJlndU/xf9ioilgLlpdV/xf7iyicgNlsdW/wf4i4iggOlvdX/wf1i6iegPlxdY/xfzi3iXgPlzdZ/zfyiviLgQl0dZ/1fy
					ijh9gPl1dZ/3fziUhsgPl1dY/5f2iAhbgOl0dX/7f5hqhMgNlydW/8f8hRhAgLlvdV/+f/g2g3gJltdU/+gAgZhEgHlqdT/9gBf8hVgFlndS/8gCffhogDll
					dR/6gCfCh7gAlkdR/4gCeoiMf+ljdR/2gCePiaf7lkdS/0gCd5ijf5lldT/ygCdninf3lndU/xgDdYil]],
				Mane = [[
					gAkOezGDgAgAytf/kPe0GHgFgHyxf+kRe0GKgKgNy1f9kSe1GMgOgUy5f8kTe1GOgTgZy6f8kTe1GOgWgfy7f7kTe1GOgagjy6f7kSe1GMgcgny4f6kRe1GK
					gegpy1f6kPe0GHgfgryxf6kOe0GEgfgrysf6kMezGBgfgryof6kKeyF+gegpykf6kJeyF7gcgnyhf7kIeyF6gZgjyff8kIeyF5gWgfyef8kIeyF6gSgayff9
					kJeyF7gOgUyhf+kKeyF9gKgNykf/kMezGAgFgHyogAkOezGDgAgAytgBkPe0GHf7f5yxgCkRe0GKf2fzy1gDkSe1GMfyfsy5gEkTe1GOftfny6gEkTe1GOfq
					fhy7gFkTe1GOfmfdy6gFkSe1GMfkfZy4gGkRe1GKfifXy1gGkPe0GHfhfVyxgGkOe0GEfhfVysgGkMezGBfhfVyogGkKeyF+fifXykgGkJeyF7fkfZyhgFkI
					eyF6fnfdyfgEkIeyF5fqfhyegEkIeyF6fufmyfgDkJeyF7fyfsyhgCkKeyF9f2fzykgBkMezGAf7f5yo]],
				["UpperArm.L"] = [[
					e+j6ec01NMfPvVe9j8ed1LNRetu6e8j+ed1bNWeSuoe7j/ee1iNbeCufe6kAef1iNed9uje5kBef1aNgeDuze4kAeg1LNieUvNe3j/eg01Njetvue3j+eg0a
					NlfNwUe3j8egz9Nnfvw7e3j6efzhNpgRxee3j4efzHNrgux7e3j2eey0NshEyOe3j0eeyqNrhSyYe4jzedyqNohVyVe5jzedyzNkhNyIe6jzedzFNfg9xwe7
					j0eczeNZglxPe8j2ecz7NUgIwoe9j4ec0ZNPfqv+e+j6ec01NMfPvVe/j8eb1MNKe4uwfAj+eb1cNHepuUfBj/eb1lNFejuDfCkAeb1mNCent+fDkBeb1eM+
					e2uGfEkAea1OM6fNuafFj/ea03M1fsu2fFj+eZ0bMygOvYfFj8eZz8Mwgxv9fFj6eYzeMwhSwffFj4eYzDMxhtw8fFj2eYywMziAxTfFj0eYylM1iJxgfEjz
					eYylM4iHxjfDjzeYyvM6h6xbfCjzeZzDM8hixLfBj0eZzdM/hCwzfAj2eaz7NDgdwVe/j4eb0ZNHf1v0]],
				["LowerArm.L"] = [[
					eZjVd6gP/sj9h6eYjZd6gU/kk1hyeWjcd6gX/hlPhpeVjed6gY/ilIhieUjfd7gW/okihbeTjfd8gS/xjfhVeSjdd+gL/5iGhQeRjbeAgD/9gghMeRjXeCf6
					/8e3hIeQjUeEfx/3dVhGeQjQeGfq/ucEhFeQjNeIfl/mbMhGeRjKeJfj/iaxhHeRjIeJfk/ja4hLeSjHeIfo/pbehPeTjHeHfu/xchhVeUjIeFf2/4d6hceV
					jKeCf+/8fghjeWjNd/gF/7hJhreYjRd9gL/1ishzeZjVd6gP/sj9h6eajZd4gR/jk1iCecjcd2gS/flPiKedjed1gQ/flJiSeejfd1gN/kkjiZegjfd1gJ/s
					jgigegjdd1gF/0iHimehjbd2gB/4ggireijXd4f9/2e3iueijUd6f6/wdUiweijQd7f3/ocDiveijNd9f1/gbLiuehjKd+f0/cawisehjId/f0/da3ipegjH
					eAf1/kbdilefjHd/f3/scgigeejId/f6/1d5iaedjKd9f+/5fgiUecjNd8gE/5hJiMeajRd7gK/0isiD]],
				["UpperArm.R"] = [[
					hCj6ec01y0gxvVhBj8eb1My2hIuwhAj+eb1cy5hXuUg/j/eb1ly7hduDg+kAeb1my+hZt+g9kBeb1ezChKuGg8kAea1OzGgzuag7j/ea03zLgUu2g7j+eZ0b
					zOfyvYg7j8eZz8zQfPv9g7j6eYzezQeuwfg7j4eYzDzPeTw8g7j2eYywzNeAxTg7j0eYylzLd3xgg8jzeYylzId5xjg9jzeYyvzGeGxbg+jzeZzDzEeexLg/
					j0eZzdzBe+wzhAj2eaz7y9fjwVhBj4eb0Zy5gLv0hCj6ec01y0gxvVhDj8ed1LyvhTu6hEj+ed1byqhuuohFj/ee1iylh+ufhGkAef1iyiiDujhHkBef1ayg
					h9uzhIkAeg1LyehsvNhJj/eg01ydhTvuhJj+eg0aybgzwUhJj8egz9yZgRw7hJj6efzhyXfvxehJj4efzHyVfSx7hJj2eey0yUe8yOhJj0eeyqyVeuyYhIjz
					edyqyYeryVhHjzedyzycezyIhGjzedzFyhfDxwhFj0eczeynfbxPhEj2ecz7ysf4wohDj4ec0ZyxgWv+]],
				["LowerArm.R"] = [[
					hnjVd6gPAUcDh6hmjZd4gRAdbLiChkjcd2gSAhaxiKhjjed1gQAha3iShijfd1gNAcbdiZhgjfd1gJAUcgighgjdd1gFAMd5imhfjbd2gBAIfgirhejXd4f9
					AKhJiuhejUd6f6AQisiwhejQd7f3AYj9ivhejNd9f1Agk1iuhfjKd+f0AklQishfjId/f0AjlJiphgjHeAf1AckjilhhjHd/f3AUjgighijId/f6ALiHiahj
					jKd9f+AHggiUhkjNd8gEAHe3iMhmjRd7gKAMdUiDhnjVd6gPAUcDh6hojZd6gUAcbLhyhqjcd6gXAfaxhphrjed6gYAea4hihsjfd7gWAYbehbhtjfd8gSAP
					chhVhujdd+gLAHd6hQhvjbeAgDADfghMhvjXeCf6AEhJhIhwjUeEfxAJirhGhwjQeGfqASj8hFhwjNeIflAak0hGhvjKeJfjAelPhHhvjIeJfkAdlIhLhujH
					eIfoAXkihPhtjHeHfuAPjfhVhsjIeFf2AIiGhchrjKeCf+AEgghjhqjNd/gFAFe3hrhojRd9gLALdUhz]],
				Tail1 = [[
					gAjShMfEgAgA/+gAjThMezgdgB/9gBjUhMekg6gD/8gBjUhMeYhVgE/7gBjVhMeRhugG/5gBjVhMeOiEgH/4gBjVhMeRiXgI/2gCjUhMeZingI/2gCjUhMel
					iygI/1gCjThMezi5gH/1gCjShMfEi7gG/2gCjRhMfUi5gE/2gCjRhMfjiygD/3gCjQhMfvingB/4gBjQhMf3iYgB/5gBjQhMf5iFgA/7gBjQhMf3hugB/8gB
					jQhMfvhVgB/9gBjRhMfjg6gB/+gAjRhMfUgdgB/+gAjShMfEgAgA/+gAjThMezfjf//9f/jUhMekfGf9/8f/jUhMeYerf8/7f/jVhMeReSf6/5f/jVhMeOd8
					f5/4f/jVhMeRdpf4/2f+jUhMeZdZf4/2f+jUhMeldOf4/1f+jThMezdHf5/1f+jShMfEdFf6/2f+jRhMfUdHf8/2f+jRhMfjdOf9/3f+jQhMfvdZf//4f/jQ
					hMf3dof//5f/jQhMf5d7gA/7f/jQhMf3eSf//8f/jQhMfverf//9f/jRhMfjfGf//+gAjRhMfUfjf//+]],
				Tail2 = [[
					gAjVh/c0elf3/zgCjXh/cXfSf8/xgDjYh/b6gBgC/ugFjah+begvgI/qgHjah+bGhcgP/lgIjbh+a1iHgW/fgJjah+asiugc/bgKjah+atjRgh/YgLjYh+a2
					jvgl/WgLjXh+bIkIgo/VgLjVh+bgkZgo/XgLjUh+b9kkgo/ZgLjSh+cakogm/cgKjRh+c2klgj/ggJjQh+dOkagg/jgIjQh+dfkIgc/ngHjQh/dojwgZ/rgF
					jRh/dnjSgV/ugDjSh/deiugS/xgCjUh/dMiGgO/zgAjVh/c0hbgJ/zf+jXh/cXgugE/xf9jYh/b6f/f+/uf7jah+befRf4/qf5jah+bGekfx/lf4jbh+a1d5
					fq/ff3jah+asdSfk/bf2jah+atcvff/Yf1jYh+a2cRfb/Wf1jXh+bIb4fY/Vf1jVh+bgbnfY/Xf1jUh+b9bcfY/Zf1jSh+cabYfa/cf2jRh+c2bbfd/gf3jQ
					h+dObmfg/jf4jQh+dfb4fk/nf5jQh/docQfn/rf7jRh/dncufr/uf9jSh/dedSfu/xf+jUh/dMd6fy/z]],
				Tail3 = [[
					f8jfixa8cjfX/Zf/jiiwaidSfh/ZgDjliwaBeGfs/XgHjoivZee9f5/TgLjqivY6f1gF/MgOjriuYbgtgS/EgRjritYChlgf+8gUjqitXziZgs+0gWjpitXv
					jKg3+ugYjmitX1j2hB+rgZjkitYHkbhJ+qgZjhitYhk6hO+sgZjeiuZBlShR+vgYjbiuZklhhS+0gXjZivaIlnhR+6gVjYivanllhO/BgSjYiwbAlZhJ/HgP
					jZiwbPlGhD/NgMjaiwbUkqg7/SgIjdixbNkHgz/WgEjfixa8jdgp/ZgBjiiwaiiugf/Zf9jliwaBh6gU/Xf5joivZehDgH/Tf1jqivY6gLf7/MfyjriuYbfT
					fu/EfvjritYCebfh+8fsjqitXzdnfU+0fqjpitXvc2fJ+ufojmitX1cKe/+rfnjkitYHble3+qfnjhitYhbGey+sfnjeiuZBauev+vfojbiuZkafeu+0fpjZ
					ivaIaZev+6frjYivanabey/BfujYiwbAane3/HfxjZiwbPa6e9/Nf0jaiwbUbWfF/Sf4jdixbNb5fN/W]],
				Tail4 = [[
					fxjvjgZNbEer+1f3j0jgZBbme4+4f+j4jfYscPfG+5gEj8jeYPc/fW+4gKkAjdXudzfn+0gQkCjbXMeqf4+ugWkEjaWsfkgJ+mgbkEjZWRgfgb+dgfkCjYV+
					hYgr+VgikAjYV0iPg7+Oglj8jYV2jDhK+Kgnj4jYWBjyhW+Igoj0jZWWkahh+JgojwjaWzk8hp+MgnjsjbXUlWhv+RgljpjcX2lohy+XgijojdYXlxhx+egf
					jojeYylxhu+lgajpjfZFloho+rgVjsjgZPlWhg+xgPjvjgZNk8hV+1gJj0jgZBkahI+4gCj4jfYsjxg6+5f8j8jeYPjBgq+4f2kAjdXuiNgZ+0fwkCjbXMhW
					gI+ufqkEjaWsgcf3+mflkEjZWRfhfl+dfhkCjYV+eofV+VfekAjYV0dxfF+Ofbj8jYV2c9e2+KfZj4jYWBcOeq+IfYj0jZWWbmef+JfYjwjaWzbEeX+MfZjs
					jbXUaqeR+RfbjpjcX2aYeO+XfejojdYXaPeP+efhjojeYyaPeS+lfmjpjfZFaYeY+rfrjsjgZPaqeg+x]],
				Tuft = [[
					fjkFkMhua5gD/ifqkKkMhkbdgG/ofzkPkLhPcJgJ/uf7kUkKgzc6gL/1gEkZkIgSdxgO/6gMkdkGfwergP/9gUkgkEfOfogR/+gckhkCeyglgS/9gikhkBee
					hggS/6gokfkAeTiagT/2gtkbkAeTjQgT/xgxkXkAeekAgS/sg0kRkBeykqgS/og2kMkCfPlNgR/jg2kHkEfwlngP/fg1kDkFgTl5gN/cgzkAkHg0mCgK/agv
					j/kJhQmBgH/Zgqj/kKhkl2gE/agkkBkLhuljgB/dgdkFkMhulHf9/igWkKkMhkkjf6/ogNkPkLhPj3f3/ugFkUkKgzjGf1/1f8kZkIgSiPfy/6f0kdkGfwhV
					fx/9fskgkEfOgYfv/+fkkhkCeyfbfu/9fekhkBeeegfu/6fYkfkAeTdmft/2fTkbkAeTcwft/xfPkXkAeecAfu/sfMkRkBeybWfu/ofKkMkCfPazfv/jfKkH
					kEfwaZfx/ffLkDkFgTaHfz/cfNkAkHg0Z+f2/afRj/kJhQZ/f5/ZfWj/kKhkaKf8/afckBkLhuadf//d]],
				["UpperLeg.L"] = [[
					eziDgP7meSf8wGeziEgP7keYf2wJeziFgQ7jeefwwMeziFgQ7iekfqwOeziGgR7jepfkwNeyiGgR7letffwJeyiGgS7pewfawDeyiFgS7ueyfVv5eyiFgS70
					ezfRvueyiEgT77eyfOvieyiDgT8CexfMvWeyiCgT8IewfLvLeyiBgS8MetfMvCeyiBgS8PerfOu9eyiAgS8PenfRu8eyiAgR8NekfWvAeziAgR8JehfcvHez
					iBgQ8DedfjvTeziBgQ77eafrvieziCgP7xeWfzvzeziDgP7meSf8wGe0iEgO7bePgFwYe0iFgN7QeLgNwqe0iFgN7GeHgVw5e0iGgM6+eDgbxEe0iGgM65eA
					ghxMe1iGgL63d8gmxPe1iFgL63d5gpxOe1iFgL66d2grxJe1iEgL6/d0gsxBe1iDgL7Fdzgrw3e1iCgL7Mdygqwse1iBgL7Tdzgnwhe1iBgL7Zd0gkwWe1iA
					gL7fd2gfwOe0iAgM7jd5gawHe0iAgM7md9gVwCe0iBgN7oeBgPwAe0iBgN7oeHgJwAe0iCgO7neMgCwC]],
				["LowerLeg.L"] = [[
					exhYf2smg7gC9ZewhZf3s5hDgA9Qewhaf4tKhLf99Iewhaf5tZhTf79Bevhbf5tkhbf487evhbf5trhif384evhbf5tthof283evhbf5tqhtf184euhbf5tj
					hxf187euhaf5tYh0f29Aeuhaf4tMh1f39FeuhZf4s/h1f49LeuhZf3szh0f59ReuhYf3snhxf69WeuhYf2sehsf89aevhYf2sYhmf99devhYf2sVhff+9eev
					hYf2sWhXf/9fewhYf2sZhOgA9eewhYf2sfhEgB9cexhYf2smg7gC9ZexhZf3stgxgD9WexhZf3s0gogF9TeyhZf3s5gfgG9ReyhZf3s7gXgI9QeyhZf3s5gQ
					gK9RezhZf3s0gKgL9UezhZf2srgGgM9YezhYf2segDgN9dezhYf1sQgBgO9jezhXf1sCgBgO9pezhWf0r1gCgO9uezhWf0rqgFgO9yezhWf0rigJgN91ezhW
					fzrfgNgM92eyhWf0rhgTgL92eyhWf0rngagK9zeyhWf0rygigI9vexhXf1sBgqgH9pexhYf1sTgygE9h]],
				["Foot.L"] = [[
					ezgyga8NgCf/vGezgyga8NgJf7vGezgyga8NgQf3vGezgyga8NgWf0vGezgyga8NgdfxvGezgyga8MgifuvGezgyga8MgnfrvGezgyga8MgsfpvGezgyga8M
					gvfnvGezgyga8MgyflvGezgyga8MgzfkvGezgyga8Mg0fkvFezgyga8MgzflvGezgyga8MgwfmvGezgyga8MgsfovGezgyga8MgnfrvGezgyga8MghfuvGez
					gyga8NgafyvGezgyga8NgTf2vGezgyga8NgLf6vGezgyga8NgCf/vGezgyga8Nf6gDvGezgyga8NfygHvGezgyga8NfrgLvGezgyga8NfkgPvGezgyga8Mfe
					gSvGezgyga8MfZgVvGezgyga8MfWgXvGezgyga8MfTgYvGezgyga8MfSgZvGezgyga8MfSgZvGezgyga8MfTgYvGezgyga8MfVgXvGezgyga8MfYgVvGezgy
					ga8MfdgTvGezgyga8NfigQvGezgyga8NfngNvGezgyga8NfugKvGezgyga8Nf0gGvGezgyga8Nf7gDvG]],
				["Toe.L"] = [[
					ezgfgN/8gCf+hmezgfgN/8gGf4hmezgfgN/8gLfxhmezgfgN/8gPfshmezgfgN/8gTfmhmezgfgN/8gXfhhmezgfgN/8gbfchmezgfgN/8gefYhmezgfgN/8
					ggfVhmezgfgN/8gifShmezgfgN/8gjfRhmezgfgN/8gjfRhmezgfgN/8gifShmezgfgN/8ghfUhmezgfgN/8gefYhmezgfgN/8gbfchmezgfgN/8gXfihmez
					gfgN/8gSfohmezgfgN/8gNfvhmezgfgN/8gHf2hmezgfgN/8gCf+hmezgfgN/8f8gFhmezgfgN/8f3gNhmezgfgN/8fygUhmezgfgN/8ftgahmezgfgN/8fp
					gfhmezgfgN/8fmgjhmezgfgN/8fjgnhmezgfgN/8figphmezgfgN/8fhgqhmezgfgN/8fhgqhmezgfgN/8figphmezgfgN/8fjgnhmezgfgN/8flgkhmezgf
					gN/8fogghmezgfgN/8fsgchmezgfgN/8fvgWhmezgfgN/8f0gRhmezgfgN/8f4gLhmezgfgN/8f9gEhm]],
				["UpperLeg.R"] = [[
					hNiDgP7mhugEwGhMiEgO7bhxf7wYhMiFgN7Qh1fzwqhMiFgN7Gh5frw5hMiGgM6+h9flxEhMiGgM65iAffxMhLiGgL63iEfaxPhLiFgL63iHfXxOhLiFgL66
					iKfVxJhLiEgL6/iMfUxBhLiDgL7FiNfVw3hLiCgL7MiOfWwshLiBgL7TiNfZwhhLiBgL7ZiMfcwWhLiAgL7fiKfhwOhMiAgM7jiHfmwHhMiAgM7miDfrwChM
					iBgN7oh/fxwAhMiBgN7oh5f3wAhMiCgO7nh0f+wChNiDgP7mhugEwGhNiEgP7khogKwJhNiFgQ7jhigQwMhNiFgQ7ihcgWwOhNiGgR7jhXgcwNhOiGgR7lhT
					ghwJhOiGgS7phQgmwDhOiFgS7uhOgrv5hOiFgS70hNgvvuhOiEgT77hOgyvihOiDgT8ChPg0vWhOiCgT8IhQg1vLhOiBgS8MhTg0vChOiBgS8PhVgyu9hOiA
					gS8PhZgvu8hOiAgR8NhcgqvAhNiAgR8JhfgkvHhNiBgQ8DhjgdvThNiBgQ77hmgVvihNiCgP7xhqgNvz]],
				["LowerLeg.R"] = [[
					hPhYf2smfFf+9ZhPhZf3stfPf99WhPhZf3s0fYf79ThOhZf3s5fhf69RhOhZf3s7fpf49QhOhZf3s5fwf29RhNhZf3s0f2f19UhNhZf2srf6f09YhNhYf2se
					f9fz9dhNhYf1sQf/fy9jhNhXf1sCf/fy9phNhWf0r1f+fy9uhNhWf0rqf7fy9yhNhWf0rif3fz91hNhWfzrffzf092hOhWf0rhftf192hOhWf0rnfmf29zhO
					hWf0ryfef49vhPhXf1sBfWf59phPhYf1sTfOf89hhPhYf2smfFf+9ZhQhZf3s5e9gA9QhQhaf4tKe1gD9IhQhaf5tZetgF9BhRhbf5tkelgI87hRhbf5tree
					gJ84hRhbf5tteYgK83hRhbf5tqeTgL84hShbf5tjePgL87hShaf5tYeMgK9AhShaf4tMeLgJ9FhShZf4s/eLgI9LhShZf3szeMgH9RhShYf3snePgG9WhShY
					f2seeUgE9ahRhYf2sYeagD9dhRhYf2sVehgC9ehRhYf2sWepgB9fhQhYf2sZeygA9ehQhYf2sfe8f/9c]],
				["Foot.R"] = [[
					hNgyga8Nf+gBvGhNgyga8NgGf9vGhNgyga8NgOf5vGhNgyga8NgVf1vGhNgyga8NgcfxvGhNgyga8MgifuvGhNgyga8MgnfrvGhNgyga8MgqfpvGhNgyga8M
					gtfovGhNgyga8MgufnvGhNgyga8MgufnvGhNgyga8MgtfovGhNgyga8MgrfpvGhNgyga8MgofrvGhNgyga8MgjftvGhNgyga8NgefwvGhNgyga8NgZfzvGhN
					gyga8NgSf2vGhNgyga8NgMf6vGhNgyga8NgFf9vGhNgyga8Nf+gBvGhNgyga8Nf3gFvGhNgyga8NfwgJvGhNgyga8NfqgMvGhNgyga8NfjgPvGhNgyga8Mfe
					gSvGhNgyga8MfZgVvGhNgyga8MfUgXvGhNgyga8MfRgZvGhNgyga8MfOgbvGhNgyga8MfNgcvGhNgyga8MfMgcvFhNgyga8MfNgbvGhNgyga8MfQgavGhNgy
					ga8MfUgYvGhNgyga8MfZgVvGhNgyga8MffgSvGhNgyga8NfmgOvGhNgyga8NftgKvGhNgyga8Nf1gGvG]],
				["Toe.R"] = [[
					hNgfgN/8f+gChmhNgfgN/8gEf7hmhNgfgN/8gJfzhmhNgfgN/8gOfshmhNgfgN/8gTfmhmhNgfgN/8gXfhhmhNgfgN/8gafdhmhNgfgN/8gdfZhmhNgfgN/8
					gefXhmhNgfgN/8gffWhmhNgfgN/8gffWhmhNgfgN/8gefXhmhNgfgN/8gdfZhmhNgfgN/8gbfchmhNgfgN/8gYfghmhNgfgN/8gUfkhmhNgfgN/8gRfqhmhN
					gfgN/8gMfvhmhNgfgN/8gIf1hmhNgfgN/8gDf8hmhNgfgN/8f+gChmhNgfgN/8f6gIhmhNgfgN/8f1gPhmhNgfgN/8fxgUhmhNgfgN/8ftgahmhNgfgN/8fp
					gfhmhNgfgN/8flgkhmhNgfgN/8figohmhNgfgN/8fggrhmhNgfgN/8feguhmhNgfgN/8fdgvhmhNgfgN/8fdgvhmhNgfgN/8feguhmhNgfgN/8ffgshmhNgf
					gN/8figohmhNgfgN/8flgkhmhNgfgN/8fpgehmhNgfgN/8fugYhmhNgfgN/8fzgRhmhNgfgN/8f5gKhm]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAjCgpADepgLgqgAjFgpAEe3g7gogAjLgpAEfRhhgogAjRgpAFf0h2gpgAjSgpAFgYh3grgAjOgpAFg5hjgtgAjIgpAEhPg+gtgAjDgpADhYgOgrgAjDgpAD
					hSfcgpgAjIgpAEg9ewgogAjOgpAFgeeSgogAjSgpAFf6eHgqgAjRgpAFfXeRgsgAjLgpAEe7eugtgAjFgpAEeqfZgs]],
				Spine1 = [[
					gAjEgKATergUj/f+jGgKAUe5gtkHf9jMgKAWfTg/kbf8jSgKAZf2hFkuf8jTgKAZgag/k0f9jQgKAYg5gukof+jJgKAVhOgWkTgAjEgKAThXf6kCgBjEgKAT
					hQffkBgCjJgKAVg7fIkQgDjPgKAXgce8klgEjTgKAZf4e8kzgDjSgKAZfWfIkwgCjNgKAWe7fdkegBjGgKAUesf4kJ]],
				Spine2 = [[
					f+jTfOA3etgdnKf7jWfOA7e2ggnbf5jdfOBEfNgfoEf4jkfPBNftgWoof5jmfPBQgPgJoxf7jhfOBJguf7oZf9jafOA/hFfwnvgBjUfOA4hSfnnPgEjUfOA4
					hQfhnPgGjZfOA/hAfgnugIjhfPBJgkfloYgIjmfPBPgCfwoxgGjkfPBNfhf+opgEjefOBEfFgLoEgBjWfOA7ezgVnc]],
				Neck1 = [[
					f8jhexEJe5gzvqf5jkexD/fBgzvZf4jteyEffXgrwRf3j1ezFWf1gbxrf5j3ezGCgRgEyqf7jyezGBgpfsyof/jpexFUg8faxmgCjiexEdhGfQwMgFjiexD/
					hFfMvYgIjoeyEKg1fQvtgJjxezE5gafcw+gIj3ezFwf9fwyRgGj1ezGIfigJyygDjueyFufNgeyNgAjlexE3e+gsw4]],
				Neck2 = [[
					f4kSeSGKe/g7yyf1kVeSGNfIg6y3f0kgeWGpfdgwzef2kqedHOf3gc0Of5kuehHjgSgC0nf+kpegHXgofp0ZgCkeebG1g4fVztgGkVeUGThBfIzAgKkTeSGH
					g+fEyvgMkaeUGYgufKzIgLkleZG8gWfZz3gJktefHcf7fx0fgFksehHhfjgL0lgAkkeeHIfPgi0Ff8kZeXGjfCgyzU]],
				Head = [[
					f0k/eEAIeqgPiMfxlCeEAJewfwicfxlNeKAKfGfTizf0lZeTAMfme+jEf6lceZAMgKezjCgAlXeXAKgqe2ivgFlMePAJhEfHiXgKlCeHAIhTfiiLgOk/eDAI
					hVgAiSgPlHeGAJhHgfiogNlTePALgrg5i9gJlceXAMgIhJjFgDlbeZALflhNi6f9lSeUAJfIhDijf4lGeLAIezgtiP]],
				Jaw = [[
					fzlIdF/ShXgJmjfylMdE/KhIgnnHf0lZdL/Mgqg8nCf4lldU/VgFhHmVf+lpda/ffihIlfgElidY/jfFg9lEgJlWdQ/hewgnlVgMlLdH/XeogImHgOlJdE/N
					evfnm5gNlSdH/KfGfNnKgKlgdQ/Qfoe9mvgFlodY/bgNe3l5f/lnda/igte8lMf5lcdV/jhGfNlHf1lPdL/chWfols]],
				Mane = [[
					f7juesESe5gzv6f4jxetEUdgiMvrf3j6euFXdPicxTf3kCexG1efhWzof5kEeyH5gyfv1Bf8j/exHwiseY0of/j2evGZjEd1yzgDjvetEzh9egwpgGjuesEF
					gPf9vmgJj1etElezg9wZgJj+ewF+ebg1yhgIkEeyHefcgE0hgGkDeyH+g+fW1FgCj7ewHDhkfBz7f/jyeuFbgofdxx]],
				["UpperArm.L"] = [[
					e7jReYv4Onl301e4jVeZwXOglS0ie2jgeaxgOHjwzje1jreay2NnhyyFe2jweaz8NKf7wce5jseZ0oMzeivEe8jkeY08MhdvuJe/jdeX1DMXdatsfDjdeX1D
					MUdftpfGjjeX0+Mbd7t/fHjreY0rMqe0u2fGjveY0AM/gPwMfFjreYy4NbiFx0fCjgeYxgN8j9zXe/jWeYwVOZlX0b]],
				["LowerArm.L"] = [[
					eaiceTeI+nXLiGeXiheReV/IZHh8eTiueMe5/wcuhweRi9eEfs/7hGhqeQjId9gi/hlIhveSjKd3hN+5oAh7eVjFdzhp+bpeiKeYjAdxh1+XppiVecjAdwhw
					+ooviaefjEdxhb/Hm3iXehjJd1g3/okHiQeijHd6gI/6gmiKehi9eBfX/vcwiIegiveJet/MZYiJeeiieQeR+qXUiK]],
				["UpperArm.R"] = [[
					g/jceX1Ezsimtng8jfeX1CzqiXtwg6jneX02zfhsuWg5jueY0ZzMgivdg6jueZzfyze4w/g9jmeYyNyVc+yohAjbeYw3x1bQz+hDjSeYwAxeaQ0uhHjSeYwA
					xaaT0xhJjaeZw4xrbZ0IhLjmeayMyJdNy3hLjueazcyofMxQhJjvea0VzCg2vthGjoeZ00zXh8uihCjgeY1Bzlift3]],
				["LowerArm.R"] = [[
					hmi/dwh1BjWsiYhijCdwhoBJYGiZhgjHdzhLAnaaiUhejJd3ggAMdliNhejDd+fvAHhViJhfi2eFfBAglEiIhhineNedBHn4iKhkieeSeKBcpBiJhnideTeL
					BLoHiBhrinePekAilQh2hui2eIfRAGhHhshwjEeAgIAOczhrhvjKd6g5AzZRh1htjId1hdBZXGiDhqjCdyhxBqWTiQ]],
				Tail1 = [[
					gAjGhMcfhPhY/vgCjJhMblgmhR/pgDjPhMbTf5g6/ogEjUhMbzfOga/tgEjWhMcyeqf3/zgEjShMdleUfY/2gCjLhMdqeQe9/1gBjHhMc/eies/yf/jHhMb/
					fFep/sf+jMhMbVfxe5/of8jShMbdgefV/qf8jWhMcRhFf4/wf8jUhMdQhjgZ/1f9jPhMduhxg2/2f+jJhMdZhqhN/0]],
				Tail2 = [[
					gDjRh9Zijzhl/DgDjXh9XviHhZ+zgCjeh8WogGg6+kgBjih9W8eIgM+ngAjgh9Ydcefe+4f+jah+aNbXe7/Gf9jTh+bAbCem/Kf9jRh+aUbmec/If9jUh9Yo
					c/ee+8f9jbh8XCe5e0+qf+jgh8Wmg6fc+jf/jih9XmiwgM+vgBjdh+ZYkLg1/AgCjWh+axk7hR/JgDjRh+a1kzhg/K]],
				Tail3 = [[
					gOjmirXVm8iM97gIjxioVGk7hx9ngCj6inTGiEhC9Lf7j9inSne9gA9Cf1j3ipT/cCe39XfxjsirWUZveA9xfujjisYFYddo9+fwjjirYDYgdr9+f1jriqWS
					Z8d/9zf7j2inT9ccek9YgBj9inSnfffd9CgIj7ioTGikgl9JgNjyiqVIlOho9lgRjnisXXnDiQ95gRjiisYUnsiZ9/]],
				Tail4 = [[
					ghkBjRVrpkjJ8jgVkSjNTroEiY8TgGkgjJRKlIhY71f4kkjIPwhZgG7hfrkbjMQWdfek7vfgkKjRSmZ/dN8Rfaj9jTVCXbcg8lfbj8jTWAWVcm8mflkJjQU2
					W/dN8dfykajLSYZReG8FgBkkjIQPcsfO7ogOkhjKPzglgq7kgbkTjPRVkWiL8AgkkCjST6ndjQ8egnj7jTVypVjj8n]],
				Tuft = [[
					g5kijxelmPgm/Vgpk2jrbek4gq/SgTlKjjYAkdgU+pf8lRjhWgjxfP+TfmlHjmX+hReV+5fTkyjubWcdee/afFkfjzeXWxfU+kfDkcjyfFS4gA9KfOkrjudJ
					StgQ88filBjnZpWqgK97f5lQjhW5ddf0+jgPlOjjWykPfs+Vgkk9jrZUolgG+Fg1knjxc6ptgn+Ug+kbjzfOoWgr+3]],
				["UpperLeg.L"] = [[
					e6hrgY2vdugf2Ze5hugb4jdyft0Ze2h2ge7ed2e2wNezh+gg+md+dloyewiCgg/qedcIhxeuiBgf/ufDcEfXesh8gc/2fFdNgResh4gY/weteujdeuh4gV/V
					eKfsmKewh7gR+vdpgYoiezh/gP9jdRhDr5e2iAgO8LdDhbuze5h8gP7Ac9hfw0e7h1gR57dChUyde7htgU4idRg90U]],
				["LowerLeg.L"] = [[
					e3g6gXiPfEfc/5e0g+gSehf6fK/8ewhLgHeZhHfP/7eqhlf3jji1gA/qekh9fxrnkjhW9beiiDfvxVk9iX6Uekh8fs0ckNib4Ieohufo11i9h73Ieshlfn0Z
					hvhn4ievhifnxJgqhU69ezhdfsulfrg58de2hYfysTe8gg9ge4hQf5pieggJ+ge5hGgBmPeafz/Ve4g9gLjYenfj/x]],
				["Foot.L"] = [[
					ezgyhL8KeVg5vEezhDhH7qfHghwCezhRg77TgSf1wqezhZgp7Chwe6w+ezhbgV63jMd/w9ezhWgC67jvdswtezhKfz7SjQeEwRezg7fr72iKezvjezgyfx8M
					g/fevFezgyf98Nf+gBvGezgygK8MfEggvFezgygX8KeYg4vEezgygk8Id9hGvDezgygx8HdzhLvDezgyg+8Id7hHvD]],
				["Toe.L"] = [[
					ezgfg9/5e4hihmezgug7/3fbg2irezg7gw/zgLfvjaezhEgf/shHeRjyezhFgL/iiCc0j2ezhAf4/eiZcUjnezg1fo/niHc3jEezgnff/0hcd/iLezgffj/7
					grfGhmezgffw/8f/gChmezgff9/7fXg3hmezgfgK/5e6hfhmezgfgX/3eoh3hmezgfgk/2ehiAhmezgfgx/3emh5hm]],
				["UpperLeg.R"] = [[
					hTh4gW/ahigil1hRh5gT/HiIgAnHhOh9gQ+NikfRqMhLiAgO82i3eutdhIh/gO7jjBehv5hGh5gQ6ejCelxohFhxgS5Si4e2zWhFhrgW3riifR1WhGhsga3h
					iQf71khJhygd54iMguyrhLh6gf9LiHhus2hOiBgg/ah3jOkzhRiCgg/shNkIgChTh/gd/yg4jdfghUh6ga/3hGiChm]],
				["LowerLeg.R"] = [[
					hWhmfp2Kdvea26hThkfnyte0eh54hPhffpvyf3e67zhLhbfvtdgvfU9AhJhUf2rAhUfr+AhIhMf9n6hlgC+9hHhCgFkrhigW/nhJg7gRiihMgh/3hLg7gVgB
					gigw/+hOhDgNd5fig4/6hThXf+gReGge/7hZhzfynqcPfY+0heiDfwu3bEeD71heiBftzJbVdh5Ehah1fq1Tcady3g]],
				["Foot.R"] = [[
					hNgyfq8Kefg0vEhNgyf38NfhgQvGhNgygE8MggfvvGhNgygR8LhUfTvFhNgyge8Jh3fAvEhNgygr8IiKe2vDhNgyg38HiLe1vDhNgyhE8Jh6e/vEhNg7hK75
					hUfRvlhNhKhB7egWfzwZhNhWgz7KfBgnw3hNhbgf68dehmxAhNhZgM62cZiRw2hNhRf67EcaiMwhhNhDfu7idQhmv9]],
				["Toe.R"] = [[
					hNgffd/5e+hYhmhNgffq/8frgchmhNgff3/8gWfjhmhNgfgE/6g5ezhmhNgfgQ/4hReThmhNgfgd/2hdeChmhNgfgq/2heeBhmhNgfg3/4hSeRhmhNgng9/4
					g4exiLhNg1g2/1gOfrjFhNhAgo/wfYg+jphNhFgV/neaihj3hNhEgB/edtjmjxhNg7fv/idsjhjYhNgufi/ueNiniq]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAjOgp/+gAgAg7gAi3gp/9fze1g7gAi8gp/7fteXg7gAjTgp/9fze1g7gAjOgp/+gAgAg7gAi3gp/9gNhLg7gAi8gp/7gThpg7gAjTgp/9gNhLg7]],
				Spine1 = [[
					gAjMgKALgAgAjIf+i2gKAIgVhJiWf9i7gKAKgehnihf+jRgKANgXhIjSgAjMgKALgAgAjIgCi2gKAIfre3iWgDi7gKAKfieZihgCjRgKANfpe4jS]],
				Spine2 = [[
					gAjYfNAzgAgAnBf5i/fNAhgchGlgf3jEfNAmgphjl1f6jefNA5gghFnWgAjYfNAzgAgAnBgHi/fNAhfke6lggJjEfNAmfXedl1gGjefNA5fge7nW]],
				Neck1 = [[
					gAjmewFigAgAx8f3jKeuD8gxg6vTf0jQevEThHhQv5f4jsewF8g4g0yggAjmewFigAgAx8gJjKeuD8fPfGvTgMjQevETe5ewv5gIjsewF8fIfMyg]],
				Neck2 = [[
					gAkceaIKgAgA1Vf2j6ePGPg4gzy7fykCeSGrhRhGzdf3kjedIpg+gs10gAkceaIKgAgA1VgKj6ePGPfIfNy7gOkCeSGreve6zdgJkjedIpfCfU10]],
				Head = [[
					gAlLeVAVgAgAkbf1koeBAKgVgji4fykweGAMgfgxjOf4lSeaAYgbghkwgAlLeVAVgAgAkbgLkoeBAKfrfdi4gOkweGAMfhfPjOgIlSeaAYflffkw]],
				Jaw = [[
					gAlcdX/sgAgAkWfzkzdC/Of3fZm9fvk9dH/ffwfJlif2lldd/2fufZi5gAlcdX/sgAgAkWgNkzdC/OgJgnm9gRk9dH/fgQg3ligKlldd/2gSgni5]],
				Mane = [[
					gAjzeuFQgAgAxif3jWeqEwdcj0wGf0jderGWhQhHzBf4j6evHhkseYz+gAjzeuFQgAgAxigJjWeqElb4iEv0gMjderGWewe5zBgIj6evHoi3c60S]],
				["UpperArm.L"] = [[
					e+jbeXsYOonR2te0i9ebpNQrpL45evjFeeqCQsoZ42e0jjectNPImD29e+jbeXsYOonR2tfJi7eSowPDqM3kfNjCeQpdOdp62+fIjheTs/NtnW1l]],
				["LowerArm.L"] = [[
					eZipeegK/0ish7eQiQezgE/7eEgweLiXezgP/+fFgSeOixeigm/wjsgzeZipeegK/0ish7ejiNekfu/yeFjGeoiSeefq/xfIjkekiueUf2/ojujC]],
				["UpperArm.R"] = [[
					hCjbeXsYxYYv2tg3i7eSoww9V03kgzjCeQpdxjWG2+g4jheTs/yTYq1lhCjbeXsYxYYv2thMi9ebpNvVW145hRjFeeqCvUXn42hMjjectNw4Z929]],
				["LowerArm.R"] = [[
					hnipeegKAMdUh7hdiNekfuAOh7jGhYiSeefqAPg4jkhciueUf2AYcSjChnipeegKAMdUh7hwiQezgEAFh8gwh1iXezgPACg7gShyixeigmAQcUgz]],
				Tail1 = [[
					gAjVhLdjg5f5/4gDi+hLb0gef+/tgEjDhLcFfygB/wgDjahLd1fOgH/6gAjVhLdjfHgH/4f9i+hLb0figC/tf8jDhLcFgOf//wf9jahLd1gyf5/6]],
				Tail2 = [[
					gDjdh9c8iwf6/ugEjMh8Z9hIf//ZgDjQh8Y/e1f+/MgAjhh+b+dPf+/nf9jdh9c8dQgG/uf8jMh8Z9e4gB/Zf9jQh8Y/hLgC/MgAjhh+b+ixgC/n]],
				Tail3 = [[
					gMjmivcFkxgW/YgIjfisZWi2gI/Kf/jmiqWrfPf6+lf3juiuZYcGfg/Df0jmivcFbPfq/Yf4jfisZWdKf4/KgBjmiqWrgxgG+lgJjuiuZYj6gg/D]],
				Tail4 = [[
					gajzjeaxmChA+9gQjzjZZkk4gi+8f9kCjVWCgygH+ZfskCjbXNcRfR+hfmjzjeaxZ+fA+9fwjzjZZkbIfe+8gDkCjVWCfOf5+ZgUkCjbXNjvgv+h]],
				Tuft = [[
					gskEkLkXfuev/qgfkIkGgPi2fO/2f/kgj+dVnGf6/FfhkdkFhgeSgY/6fUkEkLkhT4gf9QfhkIkGgYZHgS/PgBkgj+dRljgD/YgfkdkFhhl0fX/a]],
				["UpperLeg.L"] = [[
					ezh7gf07eYge4Jeyhlgl13fbfe3Wexhrgn7CfDXjRMeyiBgl/6fUeDg+ezh7gf+Devgdq5e2hjga/1c8f5g1e3hogY6MdPhjyFe2h/garUe8h791]],
				["LowerLeg.L"] = [[
					exhKgmcbg3f7/xevg1goLZjDho4OeciSgSHAXfdIOMesh+f0ELcZfRQrezhbf6B/e/gXVBe1hhfpPlgpf4Eke2g6gGdvgufrAHe1heg/UvgffoCF]],
				["Foot.L"] = [[
					ezhWhZ7bgJf7weezhogw6ok9c5wvezhnf/55oCa+wOezhTfY7TjOeFwQezg5fR82gOf5t1ezgygC8LerguvFezgyg68LerguvFe0g7hm5re3gvzC]],
				["Toe.L"] = [[
					ezhBhOAcf9gJlJezhTgmAldtlYhXezhSf1Bra5n/cZezg+fNAYd6jHc+ezgnfDABf2gMf1ezgff0AGg5eyeaezgfgtAFgzethNezglhfApgOeqmK]],
				["UpperLeg.R"] = [[
					hNh7gf+DhRfjq5hKhjga/1jEgHg1hJhogY6MixedyFhKh/garUhEeF91hNh7gf07hofi4JhOhlgl13glgi3WhPhrgn7Cg9odRMhOiBgl/6gsh9g+]],
				["LowerLeg.R"] = [[
					hNhbf6+Be/gXq/hLhhfpwbgpf47chKg6gGiRgufr/5hLheg/rRgffo97hPhKgmcbfJgF/xhRg1goLZc9eY4OhkiSgSHAohi4OMhUh+f0ELjngvQr]],
				["Foot.R"] = [[
					hNg5fR82fygHt1hNgygC8LhVfSvFhNgyg68LhVfSvFhMg7hm5rhJfRzChNhWhZ7bf3gFwehNhogw6obDjHwvhNhnf/55X+lCwOhNhTfY7Tcyh7wQ]],
				["Toe.R"] = [[
					hNgnfD//f2gMgLhNgff0/6g5eyhmhNgfgt/7gzetezhNglhf/XgOeqZ2hNhBhO/kf9gJa3hNhTgm/bdtlYephNhSf1+Va5n/jnhNg+fN/od6jHjC]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAjVgpAHgAgAiXgAjPgtAIgAgAivgAjBg4AOgAgAjpgAizhEAWgAgAkngAirhKAbgAgAlIgAjXgJABgAgAgmgAjtfgAFgAgAd6gAjtfgAFgAgAd6gAjtfgAF
					gAgAd6gAjrflAEgAgAeNgAjlf4ABgAgAfYgAjdgRACgAgAg5gAjWgkAFgAgAiEgAjVgpAHgAgAiXgAjVgpAHgAgAiXgAjVgpAHgAgAiX]],
				Spine1 = [[
					gAjagKAmgAgAmFgAjVgOApgAgAmTgAjIgaAwgAgAm2gAi8gmA5gAgAnagAi1gsA9gAgAntgAjZfqAWgAgAkhgAjpfBAHgAgAifgAjpfBAHgAgAifgAjpfBAH
					gAgAifgAjofGAIgAgAivgAjkfZAPgAgAjrgAjefyAZgAgAk6gAjbgFAjgAgAl2gAjagKAmgAgAmFgAjagKAmgAgAmFgAjagKAmgAgAmF]],
				Spine2 = [[
					gAjxfQBggAgApngAjtfVBhgAgApsgAjifhBlgAgAp3gAjXfuBpgAgAqDgAjSf1BrgAgAqJgAjqeuBHgAgAoRgAjyeEAxgAgAm7gAjyeEAxgAgAm7gAjyeEAx
					gAgAm7gAjyeJA0gAgAnHgAjyedA/gAgAn0gAjxe3BPgAgAovgAjxfLBcgAgApcgAjxfQBggAgApngAjxfQBggAgApngAjxfQBggAgApn]],
				Neck1 = [[
					gAkDe2FJgAgAxXgAj/e7FjgAgAx/gAj1fHGogAgAzegAjrfVH3gAgA0/gAjlfcIjgAgA1wgAj6eSD9gAgAvZgAkAdnCIgAgAragAkAdnCIgAgAragAkAdnCI
					gAgAragAkAdsCSgAgAr1gAkBeAC+gAgAtcgAkCebEBgAgAvegAkDexE6gAgAw/gAkDe2FJgAgAxXgAkDe2FJgAgAxXgAkDe2FJgAgAxX]],
				Neck2 = [[
					gAk4eeG/gAgAz8gAk1emHqgAgA0wgAkte4JagAgA2ogAkkfMLagAgA4egAkffXMhgAgA5YgAkrdzFbgAgAxygAkmc8CsgAgAsygAkmc8CsgAgAsygAkmc8Cs
					gAgAsygAkodCC6gAgAtTgAktdbD5gAgAvRgAkzd8FYgAgAxugAk3eXGpgAgAzggAk4eeG/gAgAz8gAk4eeG/gAgAz8gAk4eeG/gAgAz8]],
				Head = [[
					gAlmeUAFgAgAiGgAlkeeAOgAgAjlgAlde4A2gAgAnNgAlTfVB8gAgAq8gAlNfjCtgAgAs1gAlXdhACgAgAhMgAlJcbAWgAgAbbgAlJcbAWgAgAbbgAlJcbAW
					gAgAbbgAlMcjASgAgAb3gAlVdBAHgAgAdngAlfdqABgAgAf5gAlleLAEgAgAhqgAlmeUAFgAgAiGgAlmeUAFgAgAiGgAlmeUAFgAgAiG]],
				Jaw = [[
					gAlvdU/8gAgAhqgAlydg/+gAgAg5gAl5d//+gAgAe6gAl8ek/zgAgAcjgAl8e4/rgAgAbfgAlcch8OgAgAvEgAk3be8+gAgAtkgAk3be+dgAgApxgAk3be+J
					gAgAqtgAk8bl+1gAgAoigAlMcB/ZgAgAmHgAlfcq/wgAgAj3gAlsdL/7gAgAiHgAlvdU/8gAgAhqgAlvdU/8gAgAhqgAlvdU/8gAgAhq]],
				Mane = [[
					gAkQezFKgAgAxZgAkMe5GDdch4ybgAkDfHIWeSg+1cgAj4fWKIhyfL3QgAjyfeJyi3en2ygAkHeOD+gAgAvagAkLdfCgd8ibr8gAkLdfDNephbtxgAkLdfDe
					hZenuUgAkLdkDEiLdrtPgAkNd6C/gAgAtdgAkPeXEddoiHv9gAkQeuGbeZhIzGgAkQezHEhqe8z8gAkQezGMileJyngAkQezFKgAgAxZ]],
				["UpperArm.L"] = [[
					e+j9ec0LNLgAwLe+j5eh0xMxeWu0e+jvet1yMcaFrde+jle62NNJVdn7e+jffB2MN8TFmIe+jxd52rNEajq/e+j1dO3NNnb7rbe+j1dO3NNnb7rbe+j1dO3N
					Nnb7rbe+j1dT3CNkcMrwe+j3dn2UNYdQtDe+j6eB1SNOequse+j8eW0aNLfuv4e+j9ec0LNLgAwLe+j9ec0LNLgAwLe+j9ec0LNLgAwL]],
				["LowerArm.L"] = [[
					eZjVd9gA/7gAh7eXjXd9g9/ujjh6eTjfeDjT9br/hmePjoeRls4ezyg8eOjrecm41A3IgdeWjfdNho/glHhdeZjecif1/0dOh7eZjecif1/0dOh7eZjecif1
					/0dOh7eZjdcnf2/1dah7eZjac+f5/4eIh7eZjXdef8/6fFh7eZjVd3f//7f0h7eZjVd9gA/7gAh7eZjVd9gA/7gAh7eZjVd9gA/7gAh7]],
				["UpperArm.R"] = [[
					hCj9ec0Ly1gAwLhCj5eh0xzPhqu0hCjvet1yzkl7rdhCjle62Ny3qjn7hCjffB2MyEs7mIhCjxd52ry8ldq/hCj1dO3NyZkFrbhCj1dO3NyZkFrbhCj1dO3N
					yZkFrbhCj1dT3Cycj0rwhCj3dn2UyoiwtDhCj6eB1SyyhWushCj8eW0ay1gSv4hCj9ec0Ly1gAwLhCj9ec0Ly1gAwLhCj9ec0Ly1gAwL]],
				["LowerArm.R"] = [[
					hnjVd9gAAFgAh7hpjXd9g9AScdh6htjfeDjTClUBhmhxjoeRlsHiMOg8hyjrecm4LAI4gdhqjfdNhoAga5hdhnjecif1AMiyh7hnjecif1AMiyh7hnjecif1
					AMiyh7hnjdcnf2ALimh7hnjac+f5AIh4h7hnjXdef8AGg7h7hnjVd3f/AFgMh7hnjVd9gAAFgAh7hnjVd9gAAFgAh7hnjVd9gAAFgAh7]],
				Tail1 = [[
					gAjVhMfEgAgA/+gAjOhQfDgAgA/+gAi/hbfAgAgA/+gAiuhme8gAgA/+gAilhse7gAgA/+gAjbgsb4gAgA/ugAj2gCaofNgG/hgAj2gCb3fVgD/tgAj2gCb3
					grf9/tgAj0gHcQhmf6/ugAjrgbdmhXf//3gAjgg0e6gPgA/+gAjXhHfjfqf///gAjVhMfQf4gA/+gAjVhMfEgAgA/+gAjVhMfEgAgA/+]],
				Tail2 = [[
					gAjYh/cIgAgA/wgAjSiDbugAgA/tgAjCiOavgAgA/jgAixiZZrgAgA/XgAioifZIgAgA/PgAjohdXmgAgA+3f9kHgyXxeagC+3f+kDgzaNepf+/bgCkDgzaN
					hXgC/bgFkAg4asjLgH/YgEjzhNcNiugN/pgBjjhndSgegE/3f/jZh6dZfVf6/4gAjXh/chfwf+/zgAjYh/cIgAgA/wgAjYh/cIgAgA/w]],
				Tail3 = [[
					gAjkiwZdgAgA/UgAjfi0YrgAgA/JgAjSi+WxgAgA+ogAjFjIUygAgA99gAi+jNTxgAgA9jgAkCiJTsgAgA9hf5khheVMdof2+Bf6kWhjYzd+fy/GgGkWhjYz
					iCgO/GgPkRhnZakugk+8gNj/h+bEkBgq/WgCjsiZb5gtgJ/uf9jhisbffAfy/pf/jiixaBfof7/bgAjkiwZdgAgA/UgAjkiwZdgAgA/U]],
				Tail4 = [[
					gAj5jfXbgAgA+0gAj2jiWSgAgA+egAjvjpTigAgA9dgAjmjvQugAgA8GgAjijxPTgAgA7SgAkmitQhgAgA7/fylBiFTSc2fl9LfzksiQYAdVfi+2gNksiQYA
					irge+2gdkliUYymNhJ+hgZkPitallRhN/DgEj5jKbIg7gQ/mf6jvjdaMetfn/bf+j1jgYKfhf3/AgAj5jfXbgAgA+0gAj5jfXbgAgA+0]],
				Tuft = [[
					gAkTkLg+bPgJ/ngAkTkMd1dDgB/ygAkTkMaVi8fx/WgAkRkLY5kpe8+0gAkPkJYygAgA/KgAlSjIZobahQ+/fplminarZ8gq+8fslFi8e9gPgV/+gUlFi8gn
					naf0/Hgvk8i+izmPfI/PgpkgjakAgpfR/ugHkIj7iyeCfm/zf2kBkNhPhkgU/7f8kNkNgwkRgH/sgAkTkLhmgAgA/8gAkTkLg+bPgJ/n]],
				["UpperLeg.L"] = [[
					eziGgP7QeWgAwqeziBgR8KePf2vEezh0gY94eAfgrPezhoge/Kd1fHm2ezhhgi/mdxe4kReziGf43oengZ1heziZfdvzfcg/7yeziZfdvzfcg/7yeziZfdvz
					fcg/7yeziYfgwDfcg+7qeziSftxIfZg96/eziLf+3yerga1WeziHgL6reZgFxleziGgP7QeWgAwqeziGgP7QeWgAwqeziGgP7QeWgAwq]],
				["LowerLeg.L"] = [[
					exhaf4tRg5gA9GewhYf2sag9gF9eewhUfzrChFgQ+AevhUfyqvhLgc+HevhVfzrKhNgi99exhVfzrPguf198ezhvf2vugSfh72ezhvf2vugSfh72ezhvf2vu
					gSfh72ezhtf4v+gSfh7tezhmgCxDgTfi7Deyhbf5tggsfz8/exhaf4tJg3f+9Kexhaf4tRg5gA9Gexhaf4tRg5gA9Gexhaf4tRg5gA9G]],
				["Foot.L"] = [[
					ezgyga8NgAgAvGezgyga8NgFf+vGezgyga8NgNf5vGezgyga8NgVf1vGezgyga8NgXfzvGezgyga8Nf2gGvGezhCgR3yfkgZ1YezhCgR3yfkgZ1YezhCgR3y
					fkgZ1YezhAgT4afjgZ0qezg2gZ7EfdgWxCezgyga8NfzgHvGezgyga8Nf+gBvGezgyga8NgAgAvGezgyga8NgAgAvGezgyga8NgAgAvG]],
				["Toe.L"] = [[
					ezgfgN/8gAgAhmezgfgN/+gDf8hFezgfgN//gIfzfyezgfgN/8gMfsebezgfgN/6gNfpdtezgfgN/gf7gLafezgqgO/+f9glfiezgqgO/+f9glfiezgqgO/+
					f9glfiezgogP/+f7gmfOezghgO/3fygmdTezgfgN/8f5gMeYezgfgN/+f/gCg8ezgfgN/8gAgAhmezgfgN/8gAgAhmezgfgN/8gAgAhm]],
				["UpperLeg.R"] = [[
					hNiGgP7QhqgAwqhNiBgR8KhxgKvEhNh0gY94iAggrPhNhoge/KiLg5m2hNhhgi/miPhIkRhNiGf4/AiSg6ndhNiZfd++iSijYzhNiZfd++iSijYzhNiZfd++
					iSijYzhNiYfg/QiUiZaDhNiSft/3iXhqgLhNiLf++oiIgvo8hNiHgL8JhxgJvHhNiGgP7QhqgAwqhNiGgP7QhqgAwqhNiGgP7QhqgAwq]],
				["LowerLeg.R"] = [[
					hPhaf4tRfHgA9GhQhYf2safDf79ehQhUfzrCe7fw+AhRhUfyqve1fk+HhRhVfzrKezfe99hRhwfMrPewfn97hTivex2qeRfJ2ghTivex2qeRfJ2ghTivex2q
					eRfJ2ghSiqez1eeVfL3phSiSe8wzekfX7LhRhxfVtAe0fr9NhQhefws4fDf89RhPhaf4tRfHgA9GhPhaf4tRfHgA9GhPhaf4tRfHgA9G]],
				["Foot.R"] = [[
					hNgyga8NgAgAvGhNgyga8Nf7gCvGhNgyga8NfzgHvGhNgyga8NfrgLvGhNgyga8NfpgNvGhNhNfz+UfhgLqNhNh7ex/He+fwYqhNh7ex/He+fwYqhNh7ex/H
					e+fwYqhNh2e4/fe/f0abhNhjfU/4fNgEighNhKf4+DfpgJq+hNg3gT8if7gCuehNgyga8NgAgAvGhNgyga8NgAgAvGhNgyga8NgAgAvG]],
				["Toe.R"] = [[
					hNgfgN/8gAgAhmhNgfgN/+f9gEhFhNgfgN//f4gNfyhNgfgN/8f0gUebhNgfgN/6fzgXdthNg/fg+JfugcVVhNiGebx2fFgiFehNiGebx2fFgiFehNiGebx2
					fFgiFehNh+ehz1fIgjG7hNhfe869fagiOzhNg7fl/ZfwgTZ5hNgkgF//f9gEgPhNgfgN/8gAgAhmhNgfgN/8gAgAhmhNgfgN/8gAgAhm]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAjVgpAHgAgAiXgAjRgpAFgAgAh9gAjIgpACgAgAhBgAjBgpABgAgAgQgAjCgpABgAgAgZgAjSgpAJgAgAixgAjcgpAYgAgAkzgAjdgpAcgAgAlJgAjdgpAc
					gAgAlJgAjdgpAcgAgAlJgAjdgpAcgAgAlJgAjdgpAcgAgAlJgAjdgpAcgAgAlJgAjdgpAcgAgAlJgAjdgpAcgAgAlJgAjdgpAcgAgAlJgAjdgpAcgAgAlJgA
					jdgpAbgAgAlFgAjagpASgAgAkHgAjWgpAJgAgAizgAjVgpAHgAgAiXgAjVgpAHgAgAiXgAjVgpAHgAgAiX]],
				Spine1 = [[
					gAjagKAmgAgAmFgAjVgKAggAgAlhgAjKgKATgAgAkQgAjBgKALgAgAjNgAjDgKANgAgAjZgAjYgKAugAgAmpgAjlgLBcgAgApagAjngLBlgAgAp3gAjngLBl
					gAgAp3gAjngLBlgAgAp3gAjngLBlgAgAp3gAjngLBlgAgAp3gAjngLBlgAgAp3gAjngLBlgAgAp3gAjngLBlgAgAp3gAjngLBlgAgAp3gAjngLBlgAgAp3gA
					jngLBjgAgApygAjigLBKgAgAofgAjcgKAugAgAmsgAjagKAmgAgAmFgAjagKAmgAgAmFgAjagKAmgAgAmF]],
				Spine2 = [[
					gAjxfQBggAgApngAjqfQBSgAgAo7gAjafOA4gAgAnVgAjOfNAmgAgAmCgAjQfNApgAgAmRgAjxfRBvgAgAqVgAkIfYDHgAgAtugAkLfZDYgAgAuRgAkLfZDY
					gAgAuRgAkLfZDYgAgAuRgAkLfZDYgAgAuRgAkLfZDYgAgAuRgAkLfZDYgAgAuRgAkLfZDYgAgAuRgAkLfZDYgAgAuRgAkLfZDYgAgAuRgAkLfZDYgAgAuRgA
					kLfZDVgAgAuLgAkCfVCmgAgAsmgAj1fSBwgAgAqXgAjxfQBggAgApngAjxfQBggAgApngAjxfQBggAgApn]],
				Neck1 = [[
					gAkDe2FJgAgAxXgAj7e0EVgAgAwCgAjpexCvgAgAs6gAjaevBtgAgAqQgAjcevB3gAgAqugAkFe4FlgAgAyCgAkhfDJzgAgA3CgAklfGKjgAgA3ugAklfGKj
					gAgA3ugAklfGKjgAgA3ugAklfGKjgAgA3ugAklfGKjgAgA3ugAklfGKjgAgA3ugAklfGKjgAgA3ugAklfGKjgAgA3ugAklfGKjgAgA3ugAklfGKjgAgA3ugA
					kkfFKbgAgA3ngAkZe/IXgAgA1jgAkJe4F4gAgAydgAkDe2FJgAgAxXgAkDe2FJgAgAxXgAkDe2FJgAgAxX]],
				Neck2 = [[
					gAk4eeG/gAgAz8gAkteYFwgAgAyRgAkUeKDXgAgAuPgAj9eBB4gAgAqvgAkBeCCHgAgArYgAk7ejHqgAgA0wgAlbfFOLgAgA6jgAlffLPUgAgA7TgAlffLPU
					gAgA7TgAlffLPUgAgA7TgAlffLPUgAgA7TgAlffLPUgAgA7TgAlffLPUgAgA7TgAlffLPUgAgA7TgAlffLPUgAgA7TgAlffLPUgAgA7TgAlffLPUgAgA7TgA
					lefKPIgAgA7LgAlTe6L9gAgA47gAk/elIIgAgA1SgAk4eeG/gAgAz8gAk4eeG/gAgAz8gAk4eeG/gAgAz8]],
				Head = [[
					gAlmeUAFgAgAiGgAlaeHACgAgAfGgAk5dtA8gAgAYXgAkbdcCugAgATJgAkgdfCVgAgAUDgAlqebAQgAfpj1gAmHfXEXgXfJwEgAmJfhElfPhywWgAmJfhFS
					gPfgxlgAmJfhFmgresyAgAmJfhEnfThowbgAmJfhFHgAgAxUgAmJfhFtg0ebyIgAmJfhEsfahWwlgAmJfhE8fxggxDgAmJfhFxg5eSyMgAmJfhEzfkg+wzgA
					mIffEoflg9whgAmBfECqgVe1sqgAluefAWgAgGklgAlmeUAFgAgAiGgAlmeUAFgAgAiGgAlmeUAFgAgAiG]],
				Jaw = [[
					gAlvdU/8gAgAhqgAlWdH/mgAgAk+gAkcc09lgAgAsLgAjscx6vgAgAxjgAj0cx7UgAgAwpgBl5dd/of6gWk0gEm+e4/8fSgmesf4nBfD/7hke3f+gCnEfI/9
					fjgTejgGnEfK/5ewgzeCf5nBfD/8hce9f5gAnDfH/+gAgAe4gHnEfL/3egg9d3f6nBfE/9hNfJfuf+nDfG/+gdfsfMgInEfL/2eXhCdxf8nCfF/+g3fZfef8
					nBfC/+g1fZfhgFmweY/9fQg+fNgAmBdi/9gBf7hRgAlvdU/8gAgAhqgAlvdU/8gAgAhqgAlvdU/8gAgAhq]],
				Mane = [[
					gAkQezFBgAgAxKgAkIewEbdzh9v7gAj0eqDfdTiwt+gAjkemCzelhks4gAjnenDRgxfOuAgAkSe2HgjBeI0QgAkufHK9jRen31gAkyfKKkhBfk3ugAkyfKKZ
					eFg33fgAkyfKLRcche4DgAkyfKMddOg/5JgAkyfKNQgAgA56gAkyfKNMi0fG5sgAkyfKMMjoer40gAkyfKK4h8fL37gAkyfKKUfAgd3fgAkyfKK6cvhZ3ygA
					kxfJL8cshQ4qgAkmfBKre/gc30gAkWe2IHh1e81KgAkQezGwjMd1zQgAkQezFviWeOyAgAkQezFBgAgAxK]],
				["UpperArm.L"] = [[
					e+j9ec0LNLgAwLe+jzea0VNLf0v+e+jeeY0rNMfavhe+jNeX09NMfEvKe+jQeX06NMfHvNe+j/ed1TMHZtrme+kieo0iOWP6lje+kneq0GPlNzkUe+kneq0G
					PlNzkUe+kneq0GPlNzkUe+kneq0GPlNzkUe+kneq0GPlNzkUe+kneq0GPlNzkUe+kneq0GPlNzkUe+kneq0GPlNzkUe+kneq0GPlNzkUe+kneq0GPlNzkUe+
					kmeq0LPXOJkhe+kYek1HMpUaoRe+kDed0xMadQuJe+j9ec0LNLgAwLe+j9ec0LNLgAwLe+j9ec0LNLgAwL]],
				["LowerArm.L"] = [[
					eZjVd9gA/7gAh7eZjMd7gB/7gUh7eZi5d3gE/6hBh7eZipd1gG/5hlh7eZisd1gG/5hgh7eSjxd0j2+OpphYeKk3eNpV131XeleJlBeXqYzL3TdoeJlBeXqY
					zL3TdoeJlBeXqYzL3TdoeJlBeXqYzL3TdoeJlBeXqYzL3TdoeJlBeXqYzL3TdoeJlBeXqYzL3TdoeJlBeXqYzL3TdoeJlBeXqYzL3TdoeJlBeXqYzL3TdoeJ
					k/eVqNzo3AdzeNked+m+6hwfgKeVjmd4hz/lkah0eZjVd9gA/7gAh7eZjVd9gA/7gAh7eZjVd9gA/7gAh7]],
				["UpperArm.R"] = [[
					hCj9ec0Ly1gAwLhCjzea0Vy1gMv+hCjeeY0ry0gmvhhCjNeX09y0g8vKhCjQeX06y0g5vNhCj/ed1Tz5mTrmhCkieo0ixqwGljhCkneq0GwbyNkUhCkneq0G
					wbyNkUhCkneq0GwbyNkUhCkneq0GwbyNkUhCkneq0GwbyNkUhCkneq0GwbyNkUhCkneq0GwbyNkUhCkneq0GwbyNkUhCkneq0GwbyNkUhCkneq0GwbyNkUhC
					kmeq0Lwpx3khhCkYek1HzXrmoRhCkDed0xzmiwuJhCj9ec0Ly1gAwLhCj9ec0Ly1gAwLhCj9ec0Ly1gAwL]],
				["LowerArm.R"] = [[
					hnjVd9gAAFgAh7hnjMd7gBAFfsh7hni5d3gEAGe/h7hnipd1gGAHebh7hnisd1gGAHegh7hujxd0j2ByWXhYh2k3eNpVKJKpelh3lBeXqYM1Itdoh3lBeXqY
					M1Itdoh3lBeXqYM1Itdoh3lBeXqYM1Itdoh3lBeXqYM1Itdoh3lBeXqYM1Itdoh3lBeXqYM1Itdoh3lBeXqYM1Itdoh3lBeXqYM1Itdoh3lBeXqYM1Itdoh3
					k/eVqNMYJAdzhzked+m+FfPhgKhrjmd4hzAbbmh0hnjVd9gAAFgAh7hnjVd9gAAFgAh7hnjVd9gAAFgAh7]],
				Tail1 = [[
					gAjVhMfEgAgA/+gAjShMe9gAgA/+gAjLhMeugAgA/9gAjFhMeigAgA/9gAjGhMekgAgA/9gAjShMfBfxgA/+gAjXhMfTfaf//+gAjXhLfWhPgD/9gAjXhLfW
					fpf//+gAjXhLfWfDf+/+gAjXhLfWhJgD/9gAjXhLfWgAgA//gAjXhLfWe3f9/9gAjXhLfWg9gC/+gAjXhLfWgXgB/+gAjXhLfWexf9/9gAjXhLfWgrgC/+gA
					jXhLfVgrgC/+gAjWhMfPfOf+/+gAjVhMfHgEgA/+gAjVhMfEgAgA/+gAjVhMfEgAgA/+gAjVhMfEgAgA/+]],
				Tail2 = [[
					gAjYh/cIgAgA/wgAjVh/cWgAgA/ygAjPh/c0gAgA/1gAjKh+dMgAgA/3gAjLh+dHgAgA/3f/jVh/bqf7f//sf+jZh+aNeUf0/agEjZh+Z8hzgS/Wf/jZh+Z7
					gbf+/af9jZh+Z8d2fv/VgEjZh+Z8hXgQ/YgAjZh+Z8hBgD/Zf8jZh+Z8dzft/VgDjZh+Z8g1gM/ZgBjZh+Z8higJ/Xf8jZh+Z8d6ft/VgCjZh+Z7gNgH/agC
					jZh+Z/h4gN/Xf+jYh/ave3f1/igAjYh/byf8gA/tgAjYh/cIgAgA/wgAjYh/cIgAgA/wgAjYh/cIgAgA/w]],
				Tail3 = [[
					gAjkiwZdgAgA/UgAjhiwZ+gAgA/agAjZixbIgAgA/ngAjTixcEgAgA/vgAjUixb5gAgA/uf/jiiwYkgVgD/Hf5jriuVedrfh+HgJjsitU7hLgj9+gAjsiuU7
					hrgH99f2jsitU7dcfX95gIjsitU6gdgb+AgDjsiuU7iMgS97f2jsitU7dufW96gFjsiuU6ftgR+AgGjsitU7ihgc95f2jsitU7eNfY98gDjsiuU6e+gF9/gI
					jsitVBimgj97f6jpivWkfPfu+jgAjliwYvfvf9/JgAjkiwZdgAgA/UgAjkiwZdgAgA/UgAjkiwZdgAgA/U]],
				Tail4 = [[
					gAj5jfXbgAgA+0gAj0jgYPgAgA/CgAjpjhaEgAgA/bgAjgjibkgAgA/rgAjhjibTgAgA/pgAj6jdWIgpgK+afykLjVRieCfO8cgMkNjUQvf2gq8HgFkNjUQw
					iWgY8BfvkNjTQweNfC8CgJkNjUQvfKgb8GgJkNjUQwiggn8AfwkNjTQwexfE8EgEkNjUQwehgK8FgNkNjUQwiegz8AfxkNjUQvfcfL8GgAkNjUQweAf58DgP
					kNjUQ4iMg58Ff4kGjZTIgDfv9Sf/j8jeWVfpf6+fgAj5jfXbgAgA+0gAj5jfXbgAgA+0gAj5jfXbgAgA+0]],
				Tuft = [[
					gAkTkLhIadgN/fgAkMkNgZbAfz/mgAj7kRg/fBf3/9gAjukTiZjpgt/rgAjwkTjPlxg2/SgCkYkHfnkmfr/pfuk0jzbkdQgF/jgLk4jwahbbh+/HgLk4jvZA
					c2hB/Cfsk4jvXebgf8+ggGk4jwW7hggO+pgPk4jvX3n+e994fuk4jvZcjbeR/EgAk4jwahfngX/ggTk4jvaqfChA/gfxk4jvZeZmgz+pf6k4jwYBaMhJ+agU
					k3jvXHi+gU+lf4krj7aCkzfS/Df+kZkIexlRf1/hgAkTkLhZilf5/2gAkTkLh8dugJ/2gAkTkLhIadgN/f]],
				["UpperLeg.L"] = [[
					eziGgP7QeWgAwqeziBgR8DeOf3vQezh3gV9fd+fksNezhvgZ+ZdyfTptezhwgZ+Qd0fWqKeziEgN7QeVgAwreziSgD28e6gk2ReziTgB1qfEgs3geziTgB1q
					fEgs3geziTgB1qfEgs3geziTgB1qfEgs3geziTgB1qfEgs3geziTgB1qfEgs3geziTgB1qfEgs3geziTgB1qfEgs3geziTgB1qfEgs3geziTgB1qfEgs3gez
					iTgB17fCgq3ReziOgG4metgY0aeziIgM6tebgGxjeziGgP7QeWgAwqeziGgP7QeWgAwqeziGgP7QeWgAwq]],
				["LowerLeg.L"] = [[
					exhaf4tRg5gA9GewhYf2sbg9gE9dewhUfzrDhHgN+AevhTfxqahOgU+OevhTfxqfhMgT+MexhYf2sjg5gB9aeyhggBwUgifx7gezhigFxcgcft60ezhigFxc
					gcft60ezhigFxcgcft60ezhigFxcgcft60ezhigFxcgcft60ezhigFxcgcft60ezhigFxcgcft60ezhigFxcgcft60ezhigFxcgcft60ezhigFxcgcft60ez
					higExNgdfu69eyhef9u8gpf28Rexhbf5tig1f+8+exhaf4tRg5gA9Gexhaf4tRg5gA9Gexhaf4tRg5gA9G]],
				["Foot.L"] = [[
					ezgyga8NgAgAvGezgyga8NgFf9vGezgyga8NgPf4vGezgyga8NgWf0vGezgyga8NgVf1vGezgyga8NgAgAvGezgyga8NfpgMvGezgyga8NfkgPvGezgyga8N
					fkgPvGezgyga8NfkgPvGezgyga8NfkgPvGezgyga8NfkgPvGezgyga8NfkgPvGezgyga8NfkgPvGezgyga8NfkgPvGezgyga8NfkgPvGezgyga8NfkgPvGez
					gyga8NflgPvGezgyga8NfxgIvGezgyga8Nf9gCvGezgyga8NgAgAvGezgyga8NgAgAvGezgyga8NgAgAvG]],
				["Toe.L"] = [[
					ezgfgN/8gAgAhmezgfgN/8gDf7hmezgfgN/8gKfyhmezgfgN/8gPfshmezgfgN/8gOfthmezgfgN/8gAgAhmezgfgN/8fxgVhmezgfgN/8ftgahmezgfgN/8
					ftgahmezgfgN/8ftgahmezgfgN/8ftgahmezgfgN/8ftgahmezgfgN/8ftgahmezgfgN/8ftgahmezgfgN/8ftgahmezgfgN/8ftgahmezgfgN/8ftgahmez
					gfgN/8fugZhmezgfgN/8f2gOhmezgfgN/8f+gDhmezgfgN/8gAgAhmezgfgN/8gAgAhmezgfgN/8gAgAhm]],
				["UpperLeg.R"] = [[
					hNiGgP7QhqgAwqhNiBgR8DhygJvQhNh3gV9fiCgcsNhNhvgZ+ZiOgtpthNhwgZ+QiMgqqKhNiEgN7QhrgAwrhNiSgD28hGfc2RhNiTgB1qg8fU3ghNiTgB1q
					g8fU3ghNiTgB1qg8fU3ghNiTgB1qg8fU3ghNiTgB1qg8fU3ghNiTgB1qg8fU3ghNiTgB1qg8fU3ghNiTgB1qg8fU3ghNiTgB1qg8fU3ghNiTgB1qg8fU3ghN
					iTgB17g+fW3RhNiOgG4mhTfo0ahNiIgM6thlf6xjhNiGgP7QhqgAwqhNiGgP7QhqgAwqhNiGgP7QhqgAwq]],
				["LowerLeg.R"] = [[
					hPhaf4tRfHgA9GhQhYf2sbfDf89dhQhUfzrDe5fz+AhRhTfxqaeyfs+OhRhTfxqfe0ft+MhPhYf2sjfHf/9ahOhggBwUfegP7ghNhigFxcfkgT60hNhigFxc
					fkgT60hNhigFxcfkgT60hNhigFxcfkgT60hNhigFxcfkgT60hNhigFxcfkgT60hNhigFxcfkgT60hNhigFxcfkgT60hNhigFxcfkgT60hNhigFxcfkgT60hN
					higExNfjgS69hOhef9u8fXgK8RhPhbf5tifLgC8+hPhaf4tRfHgA9GhPhaf4tRfHgA9GhPhaf4tRfHgA9G]],
				["Foot.R"] = [[
					hNgyga8NgAgAvGhNgyga8Nf7gDvGhNgyga8NfxgIvGhNgyga8NfqgMvGhNgyga8NfrgLvGhNgyga8NgAgAvGhNgyga8NgXf0vGhNgyga8NgcfxvGhNgyga8N
					gcfxvGhNgyga8NgcfxvGhNgyga8NgcfxvGhNgyga8NgcfxvGhNgyga8NgcfxvGhNgyga8NgcfxvGhNgyga8NgcfxvGhNgyga8NgcfxvGhNgyga8NgcfxvGhN
					gyga8NgbfxvGhNgyga8NgPf4vGhNgyga8NgDf+vGhNgyga8NgAgAvGhNgyga8NgAgAvGhNgyga8NgAgAvG]],
				["Toe.R"] = [[
					hNgfgN/8gAgAhmhNgfgN/8f9gFhmhNgfgN/8f2gOhmhNgfgN/8fxgUhmhNgfgN/8fygThmhNgfgN/8gAgAhmhNgfgN/8gPfrhmhNgfgN/8gTfmhmhNgfgN/8
					gTfmhmhNgfgN/8gTfmhmhNgfgN/8gTfmhmhNgfgN/8gTfmhmhNgfgN/8gTfmhmhNgfgN/8gTfmhmhNgfgN/8gTfmhmhNgfgN/8gTfmhmhNgfgN/8gTfmhmhN
					gfgN/8gSfnhmhNgfgN/8gKfyhmhNgfgN/8gCf9hmhNgfgN/8gAgAhmhNgfgN/8gAgAhmhNgfgN/8gAgAhm]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAjVgpAHgAgAiXgAjRgpAGgEgriJgAi4gpAEgNhlgsgAjvgpANgFhmjIgAkagpAYgAg/kpgAkpgpAcgAgAlJgAkagpAYgAfBkpgAjvgpANf7eajIgAi4gpAE
					fzebgsgAjDgpAEf5fBhWgAjAgpACgAgAhKgAkEgpARgCg/j6gAkkgpAcf/hmk9gAkngpAdf/hmlDgAkNgpAUgBg/kMgAjRgpAFgAgAh5gAjAgpADf5fBhKgA
					jUgpAJf4eaiVgAjVgpAIf6e0iXgAjVgpAHf/fwiXgAjVgpAHgAgAiX]],
				Spine1 = [[
					gAjagKAmgAgAmFf/jVgKAjgIgrlwf9i5gKARgWhjjmf9j1gKA1gShknBf+kjgLBUgJg+o+gAkzgLBfgAgApmgCkjgLBUf3fCo+gDj1gKA1fuecnBgDi5gKAQ
					fqedjlgCjGgKAXfzfCkkgAjCgKAUgAgAkTf+kMgLBEgKg+oDf9ktgLBdgOhlpXf9kwgLBggNhlpff+kVgLBKgJg+oagAjVgKAegAgAlVgCjCgKAUfzfCkTgD
					jZgKAoftecmCgCjagKAofxe1mFgAjagKAmf9fxmFgAjagKAmgAgAmF]],
				Spine2 = [[
					gAjxfQBggAgApnf8jrfQBYgNgqpNf3jHfOAtgfhhmXf3kQfTB5gdhiqsf7lFfXC0gRg9tDgAlXfYDIgAgAtxgFlFfXC0fvfDtDgJkQfTB5fjeeqsgJjHfOAs
					fhefmWgFjXfOA9ftfEnpgAjTfOA3gAgAnSf7kqfVCWgSg8r8f3lQfYDDgbhitff3lUfZDHgbhitpf7k0fVChgSg8sYgAjpfPBMgAgAomgFjTfOA4ftfEnSgJ
					jwfRBhfhefpjgHjxfRBhfpe3pngBjxfQBgf7fxpngAjxfQBggAgApn]],
				Neck1 = [[
					gAkDe2FJgAgAxXf7j9e1ExgXglwwf0jUewCkgxhZsbf1kke6GOg4hVy3f5ldfBI2gkgz2DgAlwfEJvgAgA2+gHldfBI2fcfN2DgLkke6GOfIery3gMjTewCk
					fPensZgHjmeyDefgfKuagAjhexDLgAgAt3f5lAe9Hjgkg00mf1lpfEJbg7hT2nf1lsfEJng8hT2yf5lLe/ICgkg01KgAj6e0ENgAgAv1gHjhexDMfhfJt2gL
					kCe2FIfJeqxRgJkDe2FKfWfAxXgCkDe2FJf3fzxXgAkDe2FJgAgAxX]],
				Neck2 = [[
					gAk4eeG/gAgAz8f6kxebGjgbgizXfxj9eID8g6hUvRfzlbeoIOhAhP1Vf4mWe/LJgpgw4OgAmpfGMHgAgA5DgImWe/LJfXfQ4OgNlbeoIOfAex1VgPj9eID7
					fGesvQgJkVeQFCfbfNxKgAkOeNEsgAgAwpf4l5e0Jtgpgw26f0mifELyhDhM4uf0mmfFL/hDhM45f4mFe4KQgpgw3cgAkseWF6gAgAyggJkOeNEtfbfNwogO
					k3eeG9fBewz1gKk4efHBfQfEz7gCk4eeG/f2f0z8gAk4eeG/gAgAz8]],
				Head = [[
					gAlmeUAFgAgAiGf5leeOANefgvi9fvklduAUcdiNe9fymKejA3cihVmSf4nFfGBwd7giqLgAnYfRCGgAgArWgInFfGBwiFfeqLgOmKejA3jeermSgRklduAU
					jjdze7gKlAd8AIiMeyhAgAk4d3ABgAgAgUf4mpe1BMd5groUf0nRfNCKcrgxrAf0nVfPCQcsgvrPf4m0e7BZd6gnpCgAlYeGAHgAgAiigKk4d3AIiMewgYgP
					lleUAjjfeckYgLlmeUAYipeyj3gClmeUAIgjfviqgAlmeUAFgAgAiG]],
				Jaw = [[
					gAlvdU/8gAgAhqf2lqdQ/Rhrfvmjfmkgcv9DkHfRsufqmido/QjugDltf0nseT/3iIgShxgAoCeh//gAgAgjgMnseT/3d4fuhxgWmido/QcSf9ltgakgcv9C
					b5gvswgPlEc89+dhgUq4gAk6c391gAgArkfznJd+/siOgKjsftn6ec/zjYgig2ftn+ef/zjXgjglfznXeG/yiMgNi8gAljdH+jgAgApdgQk6c49wdggXrdgX
					l2dW+1cLgKnmgRl1dW/RdHgWmGgElxdV/0fagLjMgAlvdU/8gAgAhq]],
				Mane = [[
					gAkQezEvgAgAwuf7kKeyE1dSjOwVf0jfepDtdhkwt7f0kxe5Infqh+1uf5lqfEL0jbfr4lgAl9fILxkqeL4RgHlqfEJGiCd12IgMkxe5Fsd7flyEgMjfepCy
					cFiMsNgHjzetExcXh1wRgAjterFIgAgAxWf5lOe+KKkUfC28f1l2fHKtlWfV3Qf1l5fHJTiTgn2af5lZfAHseCiX0kgAkHewE+cMjQwWgIjterEudMhHwbgM
					kPe0HpgTd+0ogJkQe0HWjQcezzgCkQezF2jGdWx8gAkQezEvgAgAwu]],
				["UpperArm.L"] = [[
					e+j9ec0LNLgAwLe4j2eezoLdXar5ewjIeey7MqRqpOewkfem0aSYLkhne2lceq0lP6OFkae+lxepz6MrSJn0fHldei1fPgPUjQfMkgeY2SSLNrgJfNjHeR0c
					MCTtnbfHjceVyQJ9W6rBe+jWeYz8MuSGnwe1k9em00TJLZgcewloev0WQVNdkbewlsewzWNMRVo8e1lJeo0fPhOdk4e+jxea1RQ8NmiXfHjWeU0aMiSunMfM
					j8eWzJKbV9pefJj9eX1YMNVTnwfAj9eb1EMKcOtGe+j9ec0LNLgAwL]],
				["LowerArm.L"] = [[
					eZjVd9gA/7gAh7eGjvd6mz8qsegxd5jVeDpD8OrrdAd7k9ebly69urZHeAl0eWoL4/xubveKl+eJpV3jzif6eVl2eHnT5IyOdbeak+eDkb7fvNb5ecjSdsnj
					8esdfseVjcdvoq69uqimeKjkd5oQ8Bs6eGeBldeclS6cv6Zbd6mAedoY4px8bGd6l4eVqF3ry9eoeAlgeSoR5YxJb6eKkNeFle8OtCa3eVjkdynz8FtKe7ec
					kAdvoc5+weiheakCdumC9Fr4gdeXjkdziL/xiahveZjVd9gA/7gAh7]],
				["UpperArm.R"] = [[
					hCj9ec0Ly1gAwLg8j2eY2Byzr2mtgzjHeR0cz+sUnag0kgeYzh1Lq2owg5ldei1fwgwsjQhClxep1Wrq0ueqhKlceq0lwGx7kahQkfemyc0Gssq4hQjIeey6
					zXuVpPhLjded0lvjymjchCjWeYz8zSt6nwg5k+eezt0fsDoYg0lqei10wXwiikg0luej2Pr2zmeAg5lKeg1Zw5wTjvhCjxeayR1bqVrHhLjXeczdzFuioThQ
					j8ej0XuYz6iahMj9eh0hzKsRpNhEj9ed0ozvjkt+hCj9ec0Ly1gAwL]],
				["LowerArm.R"] = [[
					hnjVd9gAAFgAh7hrj/dwk9BhXwfEhkjTdsnjDiTifshkkndyogGqOkiMhrl2eHnTG4Nydbh2mRefkhGcOTaAiAl0eWoLHBOSbviHkmeJqEGiPffliHjVeDpD
					DyUWdAiAj3eKmEDkUAaLh2jkd5oQD/TGeGhrlId6o2HWNshThlmEeGm/HJNQd0hmmQeUj4GJOKbbhrlieEnYGeOXdmh2j0d4pNFdQ0hhiAjleAouEFTWdRiF
					kYeVmAEgSXZUiAkCd/m6C+UneShvjid4ifAqaXhjhnjVd9gAAFgAh7]],
				Tail1 = [[
					gAjVhMfEgAgA/+gBjShMfEkagE/rgDi7hMfGn3fa+/gDjthMe4jpgU/wgCkVhMendHfd/0gAkjhLeiZhej/Qf+kVhMenbMfG/lf9jthMe3gegD/9f9i7hMfE
					kwfp/nf+jFhMfEkbf2/qgAjDhMfEgAgA/+gCkBhMewbofZ/qgDkehLejbWfB/mgDkhhLehfif5/9gCkJhMetk2gx/lgAjShMfBmqgB/Rf+jDhMfEi9f3/1f9
					jUhMfEcWf6/xf9jVhMfFaEf1/bf/jVhMfEeaf9/8gAjVhMfEgAgA/+]],
				Tail2 = [[
					gAjYh/cJgAgA/wgPjVh9calqgm/Rgci+h4eLtygJ80gPjxh9bJo8hi+Sf5kah9ZAdde//Gfskph6YmU+cR83fvkah8ZPVUdF9Pf+jxh/a/eOfx/igMi+h8d8
					ocgF+ygMjIh9dYq4gt99gAjGh/dXkFgW/nf0kFh9aEZ8ec+zf1kjh8YzVoc89PgCkmh+YhaLes+hgRkNh8Zqkdhf/AgVjVh6cvrqhF9lgHjGh+dgpPgj+hfx
					jXh9cLenf2/ufrjYh7cSXYe9+kf6jYh/cKcwfn/lgAjYh/cIgAgA/w]],
				Tail3 = [[
					gAjkiwZdgAgA/UghjgirZ7j9gs/JhDjDiYdqw2hR7EgpkBimYPuwjw7CfykwirT6h2fZ9jfPlCibTYUXZ/6TfSkxifU5QdaU5Bf5kBivXmYyed9+gljEioc7
					oCgR+0gsjRijcQvbiQ7sgNjOivcIqPh1+AfjkYioVscneE+BfZk7ifT3THah6Efxk9ioTiUPcd6xgekhipVCgAhV+Bg3jgifawtDiP8pgjjOiocju0iM8Dft
					jkivZlkKg4/DfRjkilZsXzeS+OfwjkivZhbjfE+/gAjkiwZdgAgA/U]],
				Tail4 = [[
					gAj5jfXbgAgA+0gtjzjZYCgFf1++hwjMiudMwUhU7WhOkbi9WbycmF3jf4lTjPQOoRg06ke4lqixPDX+Yd4yexlViuRtOsXq1NfkkbjWVeS2cV68g+jOjTcJ
					j5fA/ghWjfi9bjwijK61grjbjWb6vfj27afbk4jQSRige38we+liizPvUvYl4AfWlii+QAQjZ92LgdlCjQRpZegB71hbjyi+Y8qjiP9RhMjbjEcQxijh6Qf5
					j4jcYAqVi59De5j5jOXibDeo+afjj5jcXibRes+dgAj5jfXbgAgA+0]],
				Tuft = [[
					gAkTkLhcY6gV/KgtkMkGf0Z+fj/aidjVjGimwQeG7Xh0k9jFbo3xh204gNl+jiYdumc07QexmajBYlX/as9meYmCiuZJJ0fa1/fFk8jsdwMChK43hLjakDi9
					fPdV/uiBjwjTg+yvgT56hUjtjwiW1ohU3afjlfjvbqn8dB+ievmRi/Y2S5c28He+mPi/X0K/hf2ogKlqjqaMTEjJ8fh4kJjhfDolfz+zh5jrjXh01Sgx3zgV
					kSj+fbxdgd6zerkTj3hefRgC/8fWkTkGicY1gk/EgAkTkLhcY6gV/K]],
				["UpperLeg.L"] = [[
					eziGgP7QeWgAwqeyiCgT8PeofSu9exhngf/GeddXm3exihgS7NfceywxeyjPgI0jgEgS4hezjggBz2fTg45Ee1jQf/zcejhd5Ue2ihgD5Adhhezve2hlgQ97
					c5g/q0e1hygP9LdZggs2ezhvgV9/d2fbq6eyi3gM4rfdft0WexjYgK0wghf64VexjcgJ0ughf64XeyjAgK3lfof41neziBgR83eEfstoe1hvgQ9hdWgcsCe2
					iFgH6UdYhXx8e2iGgJ6gdohCxve0iGgN7HeNgOw4eziGgP7QeWgAwq]],
				["LowerLeg.L"] = [[
					exhaf4tRg5gA9GeuhZf3s6htf79OeohTfzqqjagm99eth1f9uoidfe8VezifgR0chHfC4jeziwgMzygUfm5Ie0ihgLzafkgJ5be1hyf4tLfNgc9Je2hGfqmE
					fLgI/ZezhOfuovf9gQ+xevhQfvpUhLgR+lewiHgCwlhifZ7UeyiogR0ohles4XeyirgR0mhkes4ZexiPgGxphafS6oewhbfyqohDgK+KezhMftoLf9gP+7e1
					hXf1sLfNga9ke0hYf2sjfngU9bexhaf4tHgogE9Lexhaf4tRg5gA9G]],
				["Foot.L"] = [[
					ezgyga8NgAgAvGezgyga8MgtfovGezgyga8HiUexvDezhKga7chSfPwYezhrga6kgLf5xzezh9gZ5jfigXzPezhugZ6Ce3gyyjezhKga7bemg1wYezgyga8K
					eigyvFezgyga8MfPgavGezgyga8NgUf1vGezhZga7Gggfsw/ezh0ga6NgmfoyVezh3ga6Egmfoyiezhfga68gafwxPezg7ga78gLf6vlezgyga8MfQgavGez
					gyga8LemgwvFezgyga8Me8gkvFezgyga8NfygIvGezgyga8NgAgAvG]],
				["Toe.L"] = [[
					ezgfgN/8gAgAhmezgfgN/8gefXhmezgfgN/2hkd5hmezg1gP/zg1ewjFezhVgR/ogHf1kwezhmgS/UfughmeezhYgR/dfThMlpezg1gP/zfGhXjFezgfgN/6
					fBhVhmezgfgN/8ffgthmezgfgN/8gNfuhmezhDgQ/wgUfgjyezhegS/hgYfalYezhhgS/fgYfaloezhJgQ/ugQfmkEezgmgO/6gHf2iKezgfgN/8ffgshmez
					gfgN/6fDhShmezgfgN/7fSg+hmezgfgN/8f2gNhmezgfgN/8gAgAhm]],
				["UpperLeg.R"] = [[
					hNiGgP7QhqgAwqhLiBgM7giKfgwLhKhlgQ96jHfBq2hKihgD5AifeizvhLjQf/zchdej5UhNjggBz2gtfI5EhOjPgI0jf8fu4hhPihgS7NgkhOwxhPhngf/G
					hkipm0hOhzgY+ChlhgqxhNhvgV9/iKglq6hLi4gC2mhyex2jhKjbf7zBh6eL5lhKjef6zAh5eL5mhLjBgBz1hgek5BhNiBgR83h8gUtohOhvgZ+Whqhnp3hP
					iFgW8IgvhbvJhOiGgU73g8hDvphNiGgQ7ZhggOwdhNiGgP7QhqgAwq]],
				["LowerLeg.R"] = [[
					hPhaf4tRfHgA9GhNhXf0r5fzf09shKhGfqmGg1f4/ZhLhyf4tLgzfk9JhMihgLzagcf35bhNiwgMzyfsga5IhNifgR0ce5g+4jhTh1f9uodjgi8VhYhTfzqp
					clfa9+hUhUfzq5drfy9/hRhQfvpUe1fv+lhMiHgCwlgVf07WhLisgJzCg5fi5shLivgIzAg5fi5thMiSgMzSgcf35hhQhbfyqoe9f2+KhUhTfyqgdmfs+HhU
					hcf8uSdYgY8ghThcf7uGd0gT8ohQhaf5tce2gE9AhPhaf4tRfHgA9G]],
				["Foot.R"] = [[
					hNgyga8NgAgAvGhNgyga8MgkftvGhNgyga8KhdfOvFhNhKga7bhafLwYhNhugZ6ChJfOyjhNh9gZ5jgefpzPhNhrga6kf1gHxzhNhKga7ceugxwYhNgyga8H
					dshPvDhNgyga8LesgtvFhNgyga8NfsgLvGhNhZga7FhCfXw/hMh6gY5Thie8zfhMh9gY5Khhe8zrhNhfga67hKfRxOhNg7ga78f1gGvlhNgyga8LengvvFhN
					gyga8KeigyvFhNgyga8Le6glvFhNgyga8NfygIvGhNgyga8NgAgAvG]],
				["Toe.R"] = [[
					hNgfgN/8gAgAhmhNgfgN/8gYffhmhNgfgN/6g/erhmhNg1gP/zg6epjFhNhYgR/dgte0lphNhmgS/UgSffmehNhVgR/of5gLkwhNg1gP/zfLhQjFhNgfgN/2
					eciHhmhNgfgN/6fHhMhmhNgfgN/8fzgShmhNhDgQ/vgqe/jyhNhjgS/Ng7eZmzhNhmgS/Jg7eZnChNhJgQ/tgue2kEhNgmgO/6f5gKiKhNgfgN/6fEhRhmhN
					gfgN/6fBhWhmhNgfgN/7fRg/hmhNgfgN/8f2gNhmhNgfgN/8gAgAhm]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAjVgpAHgAgAiXgAjVhBAUgAgAkYgAjVhQAhgAgAlrgAjVhMAegAgFlVgAjVhEAXgAflkqgAjVg8AVf9d/j7gAjVg2AQf8eTjdgAjVg0AMf/frjVgAjVgwAK
					gBgOi/gAjggrALh6f5iigAjzgpAxmefhiUgAj4gpChsKfGiMgAjpgpFFxGeviAgAjWgpHJz/ehh2gAjTgpHd0Yefh0gAjdgpGfzJelh5gAjegpGUy6emh6gA
					jVgpHR0Jehh1gAjSgpHk0gefh0gAjSgpHk0gefh0gAjSgpHk0gefh0gAjSgpHk0gefh0gAjSgpHk0gefh0]],
				Spine1 = [[
					gAjagKAmgAgAmFgAjdgjBDgAgAoEgAjggzBagAgApUgAjfgvBTgAgFo/gBjegmBIf9floVgEjdgdBAfueAnngDjcgXA4fveUnJgBjbgWAzf9fsnCgAjbgRAu
					gDgOmsgBjlgMAsh4fqmPgCj3gKBQmXexl9gDj7gKC+r+dslogEjrgKFgw1cvlIgFjXgKHhzrcMkvgFjUgKH10DcIkrgEjegKG5y2cWk3gEjggKGtyncZk5gF
					jWgKHqz1cKkugFjTgKH80McGkqgFjTgKH80McGkqgFjTgKH80McGkqgFjTgKH80McGkqgFjTgKH80McGkq]],
				Spine2 = [[
					gAjxfQBggAgApngAj8ftCLgAgArigAkCgACqgAgAsvgAkBf7CigBgFsbgCj9fxCRf6flrzgLj5fnCEffeDrGgJj3fgB5fjeXqpgCj2feBzf6fsqif/j0fZBs
					gFgNqNgDj9fTBnh4fmpxgLkMfQCKmVehphgUkLfQD7r5dKpPgZj1fQGfwsb8ozgbjcfQIkzdbModgbjYfQI4z2bGoagbjlfQH6yqbaokgajnfQHvycbeomgb
					jbfQIszobJocgbjXfQI/z+bDoYgbjXfQI/z+bDoYgbjXfQI/z+bDoYgbjXfQI/z+bDoYgbjXfQI/z+bDoY]],
				Neck1 = [[
					gAkDe2FJgAgAxXgAkRfVHygAgA05gAkafqJugAgA28f/kYfkJMgDgE2bgDkTfZIMfxfp1WgPkOfPHNe5eU0GgMkLfHGifEelzSgCkKfFGWf1fvzGf+kIe/F5
					gIgLyfgFkPe5FShie3xfgSkde2FTlPcNwZgfkae2GWp7ZHuzgpj/e2IEuHWrs0gtjje2JgwmVXrWgtjee2Jvw8VNrJgsjse2JDv3Vvrzgrjve2I7vqV2r7gt
					jhe2JnwvVTrRgtjde2J0xDVJrEgtjde2J0xDVJrEgtjde2J0xDVJrEgtjde2J0xDVJrEgtjde2J0xDVJrE]],
				Neck2 = [[
					gAk4eeG/gAgAz8gAlLfMJ9gAgA3LgAlUfrMGgAgA5Cf/lSfjLhgDgE4kgDlNfTKafvfr3mgRlHfDJUeueb2dgOlDe3Ike8er1tgDlCe0IXfzfw1if+k+esH2
					gJgL0+gMlEehHJhRei0CgnlNecG+kUbGy0hEk9eaHnoPXGwxhXkTeZIxrxT9uIhdjseYJyt6SUsLhejmeXJ8uNSGr4hcj4eYJdtSSxsyhbj8eYJXtGS5s8hd
					jpeYJ2uCSOsDhejjeXJ/uTSCryhejjeXJ/uTSCryhejjeXJ/uTSCryhejjeXJ/uTSCryhejjeXJ/uTSCry]],
				Head = [[
					gAlmeUAFgAgAiGgAl6fPBVgAgApFgAmCf2C8gAgAtXf/mAfrCdf7gDsQgEl8fXBpgdfrqCgRl2fCBFiPeRnsgPlye0Arh7ebl/gDlxevAfgYfslef+ltelAT
					fwgOkRgRlyeXAKh2fMiPg6l2eQAvmPdfgIhllceMCjrkb/dliAkkeJFKv8baayiJjzeHHMyXbgY7iKjseHHgyrbjYqiHkDeIGkxrbcZfiGkHeIGYxebbZpiJ
					jweHHUygbhY0iKjpeHHnyybkYkiKjpeHHnyybkYkiKjpeHHnyybkYkiKjpeHHnyybkYkiKjpeHHnyybkYk]],
				Jaw = [[
					gAlvdU/8gAgAhqgAmdeZ//gAgAfogAmzfM/8gAgAeVf/mue+/9gGf/ergFmiek/+fegLfWgamUeK/3dbhJf7gXmJd5/5dzhKgdgEmHdz/+flgPgsf9l+do/+
					gSf1hDgVl7dY/1eEgiiehEl1dR+0ZbhZlShxlNdP8LT2hWo8iFkJdP4cPagIsRiHjTdQ1kNJe0uLiGjLdQ1IM2emubiHjkdQ2dNxfPtoiHjpdQ2tN9fXteiH
					jQdQ1YNBeuuSiGjIdQ0+MweguhiGjIdQ0+MweguhiGjIdQ0+MweguhiGjIdQ0+MweguhiGjIdQ0+Mweguh]],
				Mane = [[
					gAkQezFwgAgAyRgAkffWIjfRga1vgAknftK2e/gc3+f/klfnKnfggT3xgDkhfbJsgBfh27gPkcfPIjfrd51pgMkYfGHjf3eG0igCkXfEHDgFfk0Af+kVe+Gi
					fpghzWgHkde2GBgmfdypgXkpezGKkWcax+gpkjeyHZpcYewfg1kEeyJVuBVUuGg5jmeyKuwpT7sIg5jheyKgw1UOryg4jweyJUvVVYsqg4jyeyI8uoVztKg5
					jkeyJuvjU+syg6jfeyKbwIUOsmg6jfeyK7woTtsTg6jfeyLFxBTnr6g6jfeyKwxCT+rsg6jfeyKNwrUkrz]],
				["UpperArm.L"] = [[
					e+j9ec0LNLgAwLe+kOe628NicWr8e+kZfO4QOJaDo+e9kWfJ38N/amp0fCkRe83RNccIrDfQkLes2bMeeertfNkHel1xMffIs8fBkFeo1mNGeduCe8kCem1G
					NUevvEfDkRefzGMUfRwdfSkyeevaKzeMyPfrlEegq9J5bqz5gGk6ehnAKEYn08gXkkejkuKpWY1QgakgejkaKwWC1RgSkseilYKcXD1MgRkueilkKZXQ1LgY
					kjejkmKsWP1RgbkfejkUKyV71SgbkfejkUKyV71SgbkfejkUKyV71SgbkfejkUKyV71SgbkfejkUKyV71S]],
				["LowerArm.L"] = [[
					eZjVd9gA/7gAh7eZj1ePgY/UmNh5eZkLeegn+TqGh1eYkFeagk+npFhxeej6ePgZ/HnEiUewjvd/gM/Yk2j7esjmd8gJ/njXjnedjkeCgL/xi/iPeXjeeDgI
					/4h6hteZjteChk/6gGhwefkUeIlM/hephBewk2eUp3+Wd5fifIk8efuD8kd1dxfbkxenwl7FeKclfekveow762eOcafVk1ekv17jeCc7fTk2ekvo7reAdCfc
					kwenwu6/eLcgffkueoxD6xeQcWffkueoxD6xeQcWffkueoxD6xeQcWffkueoxD6xeQcWffkueoxD6xeQcW]],
				["UpperArm.R"] = [[
					hCj9ec0Ly1gAwLhCkOe628yejqr8hCkZfO4Qx3l9o+hBkWfI38yGlTpuhGkQfA3PyLkdrkhTkJe82SxokMuFhRkGez1sx4jFu8hFkFer1mymh+uahAkCek1H
					y5g+uzhGkBed1UxdekwNhLj9ea2nt5Z9wzhJjneY3kpHUcv1g+jDeW3YkwPqtsg0ikeV2viKM8rwgyifeV2ohzMlrcg3iueV2+i6NusXg4iweW3CjIN8sigz
					iieV2siAMyrngxieeV2lhrMdrVgxieeV2lhrMdrVgxieeV2lhrMdrVgxieeV2lhrMdrVgxieeV2lhrMdrV]],
				["LowerArm.R"] = [[
					hnjVd9gAAFgAh7hnj1ePgYAsZzh5hnkLeegnBtV6h1hmkGeZgjBZW7h7hsj5eUgdA2Y8hdh9jseYgaAZbLf5h5jleRgRAMcqgOhrjkeHgMAMdBhmhljeeAgG
					AJeGiJhkjUd/dwALfsiFhXjFeCYUBEgsicg5iteIRwDjhQi7gXiSePMYHDhvjcgCh/eUJcJwiDj0f/h8eVJDKKiGj3gIiFeTKRI6h9jsgKiGeSKgIrh8jqgB
					h9eUJRJ7iEj1f+h7eVI7KTiHj4f+h7eVI7KTiHj4f+h7eVI7KTiHj4f+h7eVI7KTiHj4f+h7eVI7KTiHj4]],
				Tail1 = [[
					gAjVhMfEgAgA/+gAjQhkhGgAgA/+gAjOhziZgAgA/5gAjOhviDgJgB/7f/jQhnhYfQf7/9f8jRhegpcefu/yf8jThZgKdCf0/2f/jThXgCfcf+//gAjUhTfr
					gZgB//gAjghOfTf6eG/7gAjzhMfMfjZh/UgAj4hMfHfGTz9igAjphMe4etO369gAjWhMeoegMA44gAjThMemeeLn4kgAjdhMetekM15igAjehMevelNE5tgA
					jVhMenefL24wgAjShMeleeLf4cgAjShMeleeLf4cgAjShMeleeLf4cgAjShMeleeLf4cgAjShMeleeLf4c]],
				Tail2 = [[
					gAjYh/cIgAgA/wgAjNiXeKgAgA/8gAjGilfdgAgA//gBjIihfHgMgD/+f9jLiaece9fz/7fwjQiQdvbCfJ/gfzjSiLdQb0fW/lf9jTiKdGfNf4/2gCjViGcw
					gjgE/0gAjiiBccf7eE/uf/j1h/ccfgZb/Gf+j7h/cae+Tq9Rf+juh/cFegOu6lf/jdh+bveQL44cf/jah+bseOLg4Gf/jjh/b3eUMs5Hf/jkh/b5eWM75Tf/
					jbh+buePLu4Tf/jZh+bqeOLX3/f/jZh+bqeOLX3/f/jZh+bqeOLX3/f/jZh+bqeOLX3/f/jZh+bqeOLX3/]],
				Tail3 = [[
					gAjkiwZdgAgA/UgAjTjJbdgAgA/qgAjIjYcwgAgA/0gBjLjUcagQgF/yf5jQjMbveqfo/rfhjXjAbIZreW+7fmjbi7anaqes/Df7jci8aae/fw/egDjfi4aE
					gtgK/bgAjtizZ0f7eC/UgAkBixZ8fbZS+rgAkHiwZ9exTb8wgBj7iwZkeMOd55gDjrivZId5Lp3mgEjoivZDd3LR3QgDjwiwZRd+Md4UgCjyiwZUeAMs4hgD
					jpivZGd4Lf3dgEjnivZCd2LJ3IgEjnivZCd2LJ3IgEjnivZCd2LJ3IgEjnivZCd2LJ3IgEjnivZCd2LJ3I]],
				Tail4 = [[
					gAj5jfXbgAgA+0gAjhj6ZZgAgA/TgAjSkKargAgA/igCjWkGaWgTgH/ff1jej9ZseZfb/UfOjnjtZMYZde+NfWjsjoYqZkd++Zf4jtjsYXexfn/CgGjyjoYC
					g2gQ++gBkBjiX2f4d/+3gCkUjgYFfPZG+NgEkajgYHeXTH8JgIkPjeXpdmOH5DgMj/jdXGdLLX2lgNj8jdXAdILA2MgLkFjeXSdTMJ3WgKkGjeXVdVMY3kgN
					j+jdXEdKLN2bgNj7jdW+dHK42EgNj7jdW+dHK42EgNj7jdW+dHK42EgNj7jdW+dHK42EgNj7jdW+dHK42E]],
				Tuft = [[
					gAkTkLgVeagB/8gAj2kph6ekf6/5gAjjk6i2fuf+/3gDjok2iehXgK/3fxjyksiIf9gA/6e5j+kVh0ZGfu/LfEkEkShmZEf4/Mf0kFkZhadVf9/2gIkKkUgq
					fRf+/+gDkakOf+eoeE/5gFkskNgDeKZi/RgJkykMgPcjUA9cgRkokKfhaAPa6rgYkZkIeBXrM+4QgakWkHdCWgMy3jgWkekIdDWrNy4agVkgkJdHXcN04tgZ
					kYkHdGYKMl4AgakVkHdvY3MO3/gakVkHeMYyMT4EgakVkHd+X3Md35gakVkHdPWvMp3jgakVkHcfWMMs3R]],
				["UpperLeg.L"] = [[
					eziGgP7QeWgAwqeziKgd9AeXf0tZeziNgm97eYfsrLeziMgk9sebfqrye0iLgd9OeJgJs5e3iKgQ8mdThkt/e3iIgO8NddhWu0e0iHgU8JeMgMvHeziHgU71
					edfwvseqibgQ7fcue+v/eajIgP7FYuc0vEeSj1gP51TladtFeYkNgP3uO/Y0q7eikQgP19MSYFpdekkQgP1rL6YApQeekQgP2hNEYSp5eekQgP2rNSYVqBej
					kQgP11MHYDpYelkQgP1kLxX+pLelkQgP1kLxX+pLelkQgP1kLxX+pLelkQgP1kLxX+pLelkQgP1kLxX+pL]],
				["LowerLeg.L"] = [[
					exhaf4tRg5gA9Gexhkf9wkg4gH7WexhtgBykg4gL6CewhqgAyCg8gI6Zeyhmf8xAgfgT7Ge4hjfyv1fCg67xe3hgfyvDfVgw8Neyhff5u3gmgM8Uewhdf6uT
					hFf88mejhxf3tdgHeR8+eHijf0sveRaD8rd0jcfxr0cFUw7Pd2kAfuqoaTQF4/d/kLfspvZUNW3JeBkMfspnZMM+23d8kJftqBZmOJ3ud7kIftqGZrOY35eA
					kMfspsZQNM3BeCkMfspkZJM22weCkMfspkZJM22weCkMfspkZJM22weCkMfspkZJM22weCkMfspkZJM22w]],
				["Foot.L"] = [[
					ezgyga8NgAgAvGezg2gV9xgAgAruezg7gS+jgAgApdezg5gT+XgCf8qEe0g3gS98fzgYrPe3g2gN9ZfChysde2g0gP9DfMhgtSe0gzgW9Af2gStgezgzga8u
					gGfzuFehhJgZ8beUfGuid7h/gY8DaMdIt7dci/gV62U8a5sadWjugT4zQQZOqrddkBgS3ENeYZpfdfkDgS2zNGYSpTdaj8gT3nOSYnp2dZj7gT3xOhYsp8de
					kCgS29NUYWpadfkDgS2sM9YQpPdfkDgS2sM9YQpPdfkDgS2sM9YQpPdfkDgS2sM9YQpPdfkDgS2sM9YQpP]],
				["Toe.L"] = [[
					ezgfgN/8gAgAhmezgmgE/6gAgAd4ezguf+/rgAgAbgezgrgA/wgAf7cIe0gngA/4f+gbdXe5gkf8/5f4iBete3gigA/8f6htfme0ghgH//f/gVf0ezgggL//
					gAfygdeeg2gL/6eGf6g/dzhugJ/UZhf4gndPiygG9kT0gHfvdGjmgD6/O3gmfDdNj9gB46MAhCeudOkAgB4lLnhHerdKj4gC5jM1g5ezdJj2gC5vNEg3e1dN
					j+gB4xL1hEesdPkBgB4eLehIeqdPkBgB4eLehIeqdPkBgB4eLehIeqdPkBgB4eLehIeqdPkBgB4eLehIeq]],
				["UpperLeg.R"] = [[
					hNiGgP7QhqgAwqhNiKgd9AhpgMtZhNiNgm97hogUrLhMiMgj9shrgOrxhNiKgh9Ohagls8hPiIgj8mglh3uNhPiHge8Ngwhju/hNiHgX8JhfgXvJhMiHgS71
					hwf3vrhDiJgQ71gBfFvwgniLgP8Mb2dLuQf+iJgP7zWTbdrpfZiCgP6URNappGfDh7gP41OHahngfAh5gP4lNrahnSfJh9gP5UPAahn+fLh+gP5cPRahoGfC
					h6gP4uN7ahnae/h5gP4gNiahnNe/h5gP4gNiahnNe/h5gP4gNiahnNe/h5gP4gNiahnNe/h5gP4gNiahnN]],
				["LowerLeg.R"] = [[
					hPhaf4tRfHgA9GhPhkf9wkfIf57WhPhtgBykfIf16ChPhqf/yCfNf06ahRhmgAxAevgE7EhVhhgGv0dSgw7qhUhfgDvDdkgp8HhQhef8u3e1gF8ThOhdf4uT
					fUf48nhAhff2tReXeQ9AgahmfysGcmaE80fohvfsqnarUu7ee+hzfoo+ZRQA5Uephyfmn2YkNN3hemhyflnrYfM13PevhzfmoMYwOB4FexhzfnoSY0OQ4Peo
					hyfmnxYiND3ZemhxflnoYdMs3JemhxflnoYdMs3JemhxflnoYdMs3JemhxflnoYdMs3JemhxflnoYdMs3J]],
				["Foot.R"] = [[
					hNgyga8NgAgAvGhNg2gV9xgAgAruhNg7gS+jgAgApdhMg6gS+XgCf8qEhNg3gW98fzgYrPhPg0gg9ZfChysdhOgzgg9DfMhgtShNgzgZ9Af2gStghMgzgY8u
					gGfzuFg5g3gY8heUfHuXgIhEgW8VaJdPtXfMhXgS7UUvbVrWeehngQ5XP5aIpQeIhtgO3qNAZqn5eFhugO3YMnZnnteOhsgP4NN2ZxoTeQhrgP4WOFZ0obeH
					hugO3iM1Zpn0eFhugO3SMeZmnpeFhugO3SMeZmnpeFhugO3SMeZmnpeFhugO3SMeZmnpeFhugO3SMeZmnp]],
				["Toe.R"] = [[
					hNgfgN/8gAgAhmhNgmgE/6gAgAd4hNguf+/rgAgAbghMgrf//wgAf7cIhOgngF/4f+gbdXhRgjgQ/5f4iBethQghgQ/8f6htfmhNghgK//f/gVf0hMgggJ//
					gAfygdg3gkgK/7eGf7gzgBgzgH/VZhgAf+fAhLgC9iT0gleleQhgf965O7hkdid6hqf74wMHiZdCd4hsf74bLvihc+eAhof85bM7iIdKeChnf85nNKiEdNd5
					hrf74oL9icdAd3hsf74ULmikc9d3hsf74ULmikc9d3hsf74ULmikc9d3hsf74ULmikc9d3hsf74ULmikc9]],
			},
		},
	},
}
