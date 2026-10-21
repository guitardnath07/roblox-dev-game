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
					gAiCgeADgAgAhRgAiCgeADf9flhRgAiDgeADgAgAhRgAiDgeADgDgbhRgAiDgeADgAgAhRgAiDgeADf9flhRgAiDgeADgAgAhRgAiDgeADgDgbhRgAiDgeAD
					gAgAhRgAiCgeADf9flhRgAiCgeADgAgAhRgAiBgeADgDgbhRgAiAgeADgAgAhRgAiAgeADf+fvhRgAiAgeADgAgAhRgAiAgeADgAgAhRgAiAgeADgAgAhRgA
					iAgeADgAgAhRgAiAgeADgAgAhcgAiBgeAEgAgAhzgAiCgeAGgAgAiNgAiCgeAHgAgAiigAiDgeAIgAgAiqgAiDgeAIgAgAiqgAiBgeAEgAgAh1gAiAgeABgA
					gAfsgAiAgeABgAgAfmgAh/geABgAgAfmgAh/geABgAgAfmgAh/geABgAgAfxgAh/geABgAgAgNgAiAgeACgAgAgwgAiAgeACgAgAhKgAiAgeADgAgAhRgAiA
					geADgAgAhRgAiAgeADgAgAhRgAiAgeADgAgAhRgAiAgeADf+fphRgAiAgeADgAgAhRgAiBgeADgDgbhR]],
				Spine1 = [[
					gAiDgLAjgAgAl1gAiEgLAlfzfMl9gAiEgLAmgAgAmEgAiFgLAogNg0mKgAiFgLAogAgAmOgAiFgLApfzfMmPgAiFgLAogAgAmOgAiFgLAogNg0mKgAiEgLAm
					gAgAmEgAiEgLAlfzfMl9gAiDgLAjgAgAl1gAiCgLAigNg0lsgAiCgLAggAgAllgAiCgLAgf4fflfgAiBgLAfgAgAlbgAiBgLAegAgAlagAiBgLAfgAgAlbgA
					iCgLAfgAgAlggAiCgLAkgAgAl3gAiDgLAsgAgAmigAiEgLA3gAgAnTgAiFgLBBgAgAn8gAiGgLBGgAgAoPgAiGgLBIgAgAoVgAiEgLA1gAgAnLgAh/gLAQgA
					gAj6gAh/gLAPgAgAjvgAh/gLAPgAgAjrgAh+gLAOgAgAjlgAh+gLAPgAgAjugAh/gLATgAgAkRgAiBgLAZgAgAk7gAiCgLAfgAgAlagAiCgLAfgAgAlfgAiB
					gLAfgAgAlbgAiBgLAegAgAlagAiBgLAfgAgAlbgAiCgLAgf1fUlfgAiCgLAggAgAllgAiCgLAigNg0ls]],
				Spine2 = [[
					gAiRfoBngAgAp+gCiRfoBufie2qNgAiSfoBxgAgAqcf+iTfoB2gehKqmgAiTfoB3gAgAqugCiTfoB6fie2qwgAiTfoB3gAgAquf+iTfoB2gehKqmgAiSfoBx
					gAgAqcgCiRfoBufie2qNgAiRfoBngAgAp+f+iQfoBjgehKpugAiPfoBdgAgApggBiOfoBaftfRpUgAiOfnBYgAgApNgAiOfnBXgAgApLgAiOfnBYgAgApNgA
					iOfoBagAgApVgAiQfoBlgAgAp3gAiSfpB6gAgAq1gAiVfpCUgAgAr7gAiXfqCtgAgAs1gAiZfrC6gAgAtSgAiZfrC/gAgAtdgAiUfpCXgAgAsCgAiIfmA+gA
					gAnwgAiIfmA6gAgAnhgAiHfmA4gAgAnZgAiHfmA2gAgAnOgAiHfmA3gAgAnVgAiJfnBBgAgAn8gAiMfnBPgAgAovgAiOfnBZgAgApSgAiOfoBagAgApVgAiO
					fnBYgAgApNgAiOfnBXgAgApLgAiOfnBYgAgApNgCiOfoBbfmfApUgAiPfoBdgAgApgf+iQfoBjgehKpu]],
				Neck1 = [[
					gAidfXEzgAgAw0gDiefYE+e/egxBgAiffYFDgAgAxPf9igfYFNhBhgxXgAigfYFOgAgAxfgDigfZFSe/egxggAigfYFOgAgAxff9igfYFNhBhgxXgAiffYFD
					gAgAxPgDiefYE+e/egxBgAidfXEzgAgAw0f8ibfXEthChfwkgAiafXEigAgAwZgCiafXEdfWfEwOgAiZfXEYgAgAwIgAiZfWEXgAgAwGgAiZfXEYgAgAwIgA
					iafXEdgAgAwQgAicfXE7gAgAxBgAiffZF4gAgAydgAijfbHFgAgA0DgAimfcIJgAgA1TgAiofdIpgAgA13gAipfeIxgAgA1/gAiifbGggAgAzUgAiSfUCIgA
					gArbgAiRfUB+gAgArBgAiRfUB8gAgAq6gAiQfUB4gAgAqvgAiQfUCDgAgArOgAiTfVCrgAgAsxgAiXfWDkgAgAupgAiZfXETgAgAv+gAiafXEcgAgAwPgAiZ
					fXEYgAgAwIgAiZfWEXgAgAwGgAiZfXEYgAgAwIgDiafXEefHevwOgAiafXEigAgAwZf8ibfXEthChfwk]],
				Neck2 = [[
					gAi+fHHDgAgA0BgFjAfIHQezep0MgAjBfIHXgAgA0Zf7jCfJHhhMhX0ggAjDfJHkgAgA0ogFjDfKHoe0ep0ogAjDfJHkgAgA0of7jCfJHhhMhX0ggAjBfIHX
					gAgA0ZgFjAfIHQezep0MgAi+fHHDgAgA0Bf7i9fGG8hNhXzygAi8fFGwgAgAzogDi7fEGqfPfKzegAi6fEGkgAgAzZgAi6fEGigAgAzXgAi6fEGkgAgAzZgA
					i7fEGqgAgAzggAi+fHHZgAgA0bgAjDfMI6gAgA2IgAjIfTK1gAgA3+gAjMfYMfgAgA5WgAjOfbNQgAgA57gAjOfbNagAgA6BgAjHfQJpgAgA24gAire4CngA
					gAsngAiqe3CYgAgAsEgAipe3CVgAgAr9gAioe3CRgAgArygAipe4ClgAgAsigAive7DngAgAuugAi2fAFGgAgAxSgAi6fEGWgAgAzGgAi7fEGogAgAzfgAi6
					fEGkgAgAzZgAi6fEGigAgAzXgAi6fEGkgAgAzZgFi7fEGqe+e2zdgAi8fFGwgAgAzof7i9fGG8hNhXzy]],
				Head = [[
					gAjge/AEgAgAhvgGjifBAMgodUh5gAjjfCAFgAgAh5f6jkfDANfXiriCgAjlfDAFgAgAiAgGjlfEANgqdViFgAjlfDAFgAgAiAf6jkfDANfXiriCgAjjfCAF
					gAgAh5gGjifBAMgodUh5gAjge/AEgAgAhvf6jfe+AMfbishugAjde8ADgAgAhkgEjce8AGgXeUhigAjbe7ADgAgAhegAjbe7ADgAgAhdgAjbe7ADgAgAhegA
					jce8ADgAgAhjgAjgfBAKgAgAjFgAjlfLAogAgAmLgAjqfXBigAgAptgAjtfhCigAgAsbgAjvfmC/gAgAtegAjvfnDBgAgAthgAjpfRAugAgAmtgAjEegCIgA
					gAUkgAjCefCcgAgATzgAjBeeCdgAgATxgAi/edCegAgATtgAjCegB9gAgAVCgAjLenA4gAgAYrgAjVexAJgAgAdLgAjbe6ABgAgAgmgAjce7ADgAgAhhgAjb
					e7ADgAgAhegAjbe7ADgAgAhdgAjbe7ADgAgAhegFjce8AJgfdthkgAjde8ADgAgAhkf6jfe+AMfbishu]],
				Jaw = [[
					gAjieK/hgAgAldgPjkeN/ZeyielcgAjleN/fgAgAlnfyjneP/YhRdjllgAjneP/egAgAlugOjoeQ/XeuiclogAjneP/egAgAlufyjneP/YhRdjllgAjleN/f
					gAgAlngPjkeN/ZeyielcgAjieK/hgAgAldfxjgeK/ZhLdhlcgAjeeI/fgAgAlngJjdeH/cfShklpgAjceG/egAgAlugAjceG/egAgAlugAjceG/egAgAlugA
					jdeH/fgAgAlpgAjmeM/ogAgAkwgAj2eZ/3gAgAi6gAkFeq/+gAgAgwgAkQe5/+gAgAfNgAkUfB/9gAgAeqgAkVfC/9gAgAeugAj7eg/qgAgAkngAied87kgA
					gAwOgAiad87VgAgAwngAiZd87XgAgAwlgAiXd77ZgAgAwigAidd68CgAgAvagAiwd69cgAgAshgAjId++rgAgApEgAjZeF/WgAgAmZgAjdeH/fgAgAlrgAjc
					eG/egAgAlugAjceG/egAgAlugAjceG/egAgAlugNjdeI/afBiIlngAjeeI/fgAgAlnfxjgeK/ZhLdhlc]],
				["UpperArm.L"] = [[
					fPiafHzjM+RGnffUibfD0cNSRQmIfPicfHzqNMQznMfLidfLy4NKQaoTfPiefIzvNWQonAfUiefE0jNkQ7lxfPiefIzvNWQonAfLidfLy4NKQaoTfPicfHzq
					NMQznMfUibfD0cNSRQmIfPiafHzjM+RGnffKiYfKyqMvQ/o3fPiXfGzcMvRYnyfSiWfEz7MwRrnJfPiVfGzXMmRkn+fPiVfGzWMlRmoAfPiVfGzXMmRkn+fP
					iWfGzZMqRfn5fPiZfHziM6RKnjfPidfIzwNZQjm7fPiifK0AN+P4mNfPimfL0LOePWllfPipfM0ROvPElRfPiqfN0TO2O+lJfPiifK0nMTUcovfPiNfEy4K7
					cHuafPiLfEyxK5cSujfPiLfEytK4cXunfPiKfEyoK3cfuufPiKfEyzKwbbuEfPiOfFzOK0YcsJfPiSfFzeLfUzp4fPiWfGzdMZSJoRfPiWfGzZMqRgn5fPiV
					fGzXMmRkn+fPiVfGzWMlRmoAfPiVfGzXMmRkn+fTiWfD0HMzRwm4fPiXfGzcMvRYnyfKiYfKyqMvQ/o3]],
				["LowerArm.L"] = [[
					euike1JrT3U/v/e0imewLMUETAwseuine2J6UCUzwVeoioe8IyT+Wwv7euipe2KEUJUswie0iqexLgUSSzxFeuipe2KEUJUswieoioe8IyT+Wwv7euine2J6
					UCUzwVe0imewLMUETAwseuike1JrT3U/v/eoiie6IWTsXIvQeuihe0JbTsVLvpeyigewKLTsUCv3euife0JRTmVTvbeuifezJQTlVUvZeuife0JRTmVTvbeu
					ige0JWToVQvheuije1JnT1VCv6euipe3KIULUpwneuive5KwUmUOxaeui0e8LTU+T4yDeui3e9LlVKTtyXeui4e+LsVPTpyfewileyJQQcWftIeyh+euHsML
					cflKeyh9euHqMJcpk+eyh8euHpMIcuk5eyh6euHnMHc1kweyh+euHhMrb7lyewiIetHnOaZjoxeviVevIQQ7XEsVeuieezJGTDVku6euige0JVToVQvgeuif
					e0JRTmVTvbeuifezJQTlVUvZeuife0JRTmVTvbezigevKfTtTnv+euihe0JbTsVLvpeoiie6IWTsXIvQ]],
				["UpperArm.R"] = [[
					gxiafHzjzCu6nfg1ibfLzIySwWnggxicfHzqy0vNnMgsidfE0HzXuCm3gxiefIzvyqvYnAg1iefMzQyAwrnJgxiefIzvyqvYnAgsidfE0HzXuCm3gxicfHzq
					y0vNnMg1ibfLzIySwWnggxiafHzjzCu6nfgsiYfDz5zytenbgxiXfGzczRuonyg0iWfJzGy9vUoBgxiVfGzXzaucn+gxiVfGzWzbuaoAgxiVfGzXzaucn+gx
					iWfGzZzWuhn5gxiZfHzizGu2njgxidfIzwynvdm7gxiifK0AyCwImNgximfL0LxiwqllgxipfM0RxRw8lRgxiqfN0TxKxClJgxiifK0nztrkovgxiNfEy41F
					j5uagxiLfEyx1HjuujgxiLfEyt1IjpungxiKfEyo1JjhuugxiKfEyz1QkluEgxiOfFzO1MnksJgxiSfFze0hrNp4gxiWfGzdznt3oRgxiWfGzZzWugn5gxiV
					fGzXzaucn+gxiVfGzWzbuaoAgxiVfGzXzaucn+g1iWfJy/y0vnoDgxiXfGzczRuonygsiYfDz5zytenb]],
				["LowerArm.R"] = [[
					hSike1JrsJrBv/hYine8KLqfraxhhSine2J6r+rNwVhMinevJotVq/u+hSipe2KEr3rUwihYire+KfqRrnx5hSipe2KEr3rUwihMinevJotVq/u+hSine2J6
					r+rNwVhYine8KLqfraxhhSike1JrsJrBv/hMiheuJMtnqnuThSihe0JbsUq1vphWihe4Jjrbq9wZhSife0JRsaqtvbhSifezJQsbqsvZhSife0JRsaqtvbhS
					ige0JWsYqwvhhSije1JnsLq+v6hSipe3KIr1rXwnhSive5KwraryxahSi0e8LTrCsIyDhSi3e9Llq2sTyXhSi4e+LsqxsXyfhQileyJQvkphtIhOh+euHsz1
					jhlKhOh9euHqz3jXk+hOh8euHpz4jSk5hOh6euHnz5jLkwhOh+euHhzVkFlyhQiIetHnxmmdoxhRiVevIQvFo8sVhSieezJGs9qcu6hSige0JVsYqwvghSif
					e0JRsaqtvbhSifezJQsbqsvZhSife0JRsaqtvbhXihe6JprFrCwshSihe0JbsUq1vphMiheuJMtnqnuT]],
				Tail1 = [[
					gAiCg5fQgAgA/+f/iDg5fQfIgD/+gAiEg5fQgaf//+gBiEg5fQhsf7/8gAiEg5fQgyf+/+f/iEg5fQf3gA/+gAiEg5fQhFf9/9gBiEg5fQiSf5/5gAiEg5fQ
					hRf8/9f/iDg5fQgPf//+gAiCg5fQhWf8/9gBiCg5fQiaf5/5gAiBg5fQhRf8/9gAiBg5fQghf+/+gAiBg5fQhFf9/9gAiBg5fQg9f9/+gAiBg5fQgyf+/+gA
					iBg5fQgnf+/+gAiBg5fTgaf//+gAiBg5fagNgA//gAiBg5fhgAgA//gAiBg5fnfzgA//gAiBg5fpfmf///gAiCg5fpfZf///gAiBg5fffOgB/+gAiDg5e9fE
					gI/9gAiDg5e7e7gK/9gAiDg5e7e0gL/8gAiDg5e7evgL/8gAiCg5e9esgL/8gAiCg5fDergJ/8gAiCg5fKesgG/9gAiBg5fPevgE/9gAiBg5fQe0gE/9gAiB
					g5fQe7gD/9gAiBg5fQfDgD/+gAiBg5fQfOgC/+f/iBg5fQeegF/8gAiBg5fQfmgB/+gBiCg5fQg4f9/+]],
				Tail2 = [[
					gAiEhheefPgB/8f9iFhheed4gD/4gBiFhheegCgA/9gFiGhheeiMf9/4gCiGhheeg1f//8f/iGhheefcgB/8gDiGhheehif+/6gGiGhhefjlf7/wgDiFhhee
					iGf9/4gAiFhheegif//8gDiEhheeicf9/3gHiEhhefkSf6/qgDiDhheeikf8/2gBiDhheehbf+/7gDiDhheeibf9/3gCiChheeiRf9/4gCiDhheeiDf9/4gC
					iDhheehyf+/5gBiDhheZhff//6gBiDhhePhIgA/7gAiChheDgxgA/7f/iChhd6gYgA/6f/iChhd3f+f+/6f+iDhhd3fkf9/6f+iDhheXfLf//8f+iGhhfce1
					gK/9f9iGhhfeefgN/8f9iGhhfeeMgP/7f9iFhhfed8gR/6f9iFhhfYdugQ/5f9iEhhfHdkgN/4f9iEhheydegI/3f9iDhhejddgF/2f9iDhheedfgE/2f9iD
					hheedlgD/3f+iChheedvgD/4f+iDhheed9gD/4f8iDhheecugF/yf/iDhheeehgC/6gDiEhheegof//8]],
				Tail3 = [[
					f+iIiKc2d/f8/xf4iJiJc3cDf5/lgBiJiKc2e/f+/0gLiKiJc2h9gE/xgEiKiKc1gGgA/1f+iKiKc2eOf9/ygHiKiJc2hLgC/0gPiKiIc3kHgI/kgJiJiJc2
					iKgE/wgBiJiKc1gJgA/1gKiIiJc2i7gF/sgSiIiIc5lmgK/WgKiHiJc3jZgG/pgEiHiJc2h/gE/xgJiGiJc3jigH/ogIiGiJc3jfgH/pgHiGiJc3jWgG/qgG
					iHiJc2jHgG/rgFiHiJcpi0gG/sgDiHiKcPicgH/rgCiHiKbwiAgH/pgAiHiJbYhigF/nf/iIiJbPhBgB/nf9iIiJbPgef9/of8iHiKcZf6f+/yf7iHiJfEfX
					gK/+f5iHiJfLe1gN/9f4iHiJfLeVgO/7f4iHiJfMd3gP/6f3iGiJe8ddgO/3f2iHiJeUdGgJ/0f2iHiJdlc0gB/vf2iHiJdBcnf7/qf3iHiJc3cgf5/pf3iG
					iJc3cef5/of4iGiJc3chf5/pf5iGiJc3cqf6/qfziHiJc4a1f2/af7iHiJc2dMf7/tgFiIiKc1f/gA/1]],
				Tail4 = [[
					f5iQixbActft/bfuiRiwbEaGff/Df/iRixbAdrfz/ggPiSiwa/hVgH/kgEiSixa/e3f6/kf5iSixbBcbfs/ZgKiSixa/gKgB/mgaiSivbBj5gW/XgOiRixa/
					hdgI/kgCiRixa/e9f6/lgRiQiwbAimgP/fgfiPitbFmIgj/AgSiPiwbBjfgU/agJiPixa/h3gL/igSiOiwbBkCgX/VgRiOiwbBkKgX/UgQiOiwbBkMgY/UgO
					iPiwbBkHgX/VgMiPiwasj7gY/TgJiQiwaCjqgZ/NgHiSiwZRjSgX/GgEiTiwYqi2gT/AgBiUiwYbiWgN+/f/iUiwYbhygG/Bf8iQixaOhKgE/cf5iKiyedgg
					gS/8f2iJiyeof2gT/9f0iJixepfMgT/8fyiJixepekgS/7fwiJixeRd9gO/4fviLixdTdagF/xfuiNiwcIc7f4/mfuiOiwbQchfv/cfuiPiwbBcNfr/XfuiO
					iwbBb+fp/VfviOiwbBb2fp/UfwiOiwbBb0fo/UfmiOiubGZTfa+4f0iPixbBcEfq/WgEiQixa/fbf9/l]],
				Tail5 = [[
					fxidjXYlb3fU+1fgidjUYuYgev+Nf5iejXYkcjfb+6gTiejXYhgvgI/GgBifjYYidlfm/AfwifjXYoagfF+ogKifjXYhe2f0/FgjiejUYjjPgj+8gRiejXYh
					gOgC/Gf/idjYYjdNfi++gXidjWYhhlgR/EguicjRYpl5g/+jgbicjVYjiyge++gOibjXYhg9gK/FgcibjVYkjtgo+4gbibjVYlkDgr+2gaibjVYlkRgu+0gY
					ibjWYlkagv+ygVidjVYJkagy+rgSifjVXQkUg0+dgPiijUWOkHg0+KgLiljUVaj1gu97gHimjUVGjdgl93gDinjUVGi/gb96f/iejXXdicgX+uf6iOjadOhy
					gn/0f2iNjaddhIgn/3fyiNjadcgcgl/4fuiMjZdcfvgi/4friNjZc7fDga/0fpiSjYbneYgJ/pfniXjXaCdxf2/WfliajWY3dNfl/DflibjVYjcufd+7fkib
					jVYkcTfY+4flibjVYlb9fV+2fmibjVYlbvfS+0fWibjRYvYfev+NfricjWYlblfQ+ygDicjYYhfYf5/G]],
				["UpperLeg.L"] = [[
					fKhTgP8ncXfpt0fKhUgO8WcKgEuVfKhUgP8fcafsuGfJhVgR8ocqfTt3fKhVgP8ZccftuSfKhVgO8LcOgHuqfKhVgP8ZccftuSfJhVgR8ocqfTt3fKhUgP8f
					cafsuGfKhUgO8WcKgEuVfKhTgP8ncXfpt0fJhTgR84ckfNtTfKhSgP8vcUfmtifKhSgP8qcKf2trfKhSgP80cSfltXfKhRgP81cRfktWfKhSgP80cSfltXfK
					hSgP8ycTfltcfKhSgP8qcVfntvfKhTgO8acafruQfKhUgN8Hcgfwu3fKhVgM72clfzvXfKhWgL7tcnf2vpfKhWgL7pcpf3vvfKhUgO8VccftuafKhQgU9jcF
					fZrmfKhQgU9mcEfYrefKhQgU9ncDfXrafKhPgU9qcCfWrSfKhPgU9mcDfXrcfKhQgS9YcHfbsDfKhRgR9EcNfhszfKhSgQ81cSfltWfKhSgP8ycSfltcfKhS
					gP80cSfltXfKhRgP81cRfktWfKhSgP80cSfltXfKhSgO8ncGf7twfKhSgP8vcUfmtifJhTgR84ckfNtT]],
				["LowerLeg.L"] = [[
					fFg3f5rLhGgK99fGg3f4q8gngM+DfFg4f5rhhFgJ90fEg5f6sEhjgG9lfFg4f6rwhEgI9vfGg4f5rYglgM95fFg4f6rwhEgI9vfEg5f6sEhjgG9lfFg4f5rh
					hFgJ90fGg3f4q8gngM+DfFg3f5rLhGgK99fEg4f5rahmgI92fFg3f4q0hIgL+FfGg2f3qag1gM+PfFg2f4qmhJgL+KfFg2f4qkhJgL+LfFg2f4qmhJgL+KfF
					g2f4qrhIgL+IfFg3f4qvhHgK+HfFg3f4qwhGgI+HfFg3f4qzhEgG+GfFg3f4q6hDgE+DfFg3f4rEhBgD+AfFg3f5rNhBgD98fFg3f4q5hFgI+DfFg4f5rkhK
					gR9zfFg4f5rnhKgS9yfFg4f5rjhLgS90fFg4f5rbhLgS92fFg4f5rRhLgS96fFg3f4rEhKgQ9/fFg3f4q5hJgN+DfFg3f4qzhIgL+GfFg2f4qshIgL+IfFg2
					f4qmhJgL+KfFg2f4qkhJgL+LfFg2f4qmhJgL+KfGg2f3qUgugM+RfFg3f4q0hIgL+FfEg4f5rahmgI92]],
				["Foot.L"] = [[
					fIgggU9EgOf6tXfIgggU9EfzgGtXfIgggU9EgMf6tXfIgggU9DglfvtXfIgggU9EgLf7tXfIgggU9EfxgHtXfIgggU9EgLf7tXfIgggU9DglfvtXfIgggU9E
					gMf6tXfIgggU9EfzgGtXfIgggU9EgOf6tXfIgggU9DgpfttXfIgggU9EgQf5tXfIgggU9EgAgAtXfIgggU9EgRf4tXfIgggU9EgRf4tXfIgggU9EgRf4tXfI
					gggU9EgQf5tXfIgggU9EgPf5tXfIgggU9EgOf6tXfIgggU9EgLf7tXfIgggU9EgJf8tXfIgggU9EgIf8tXfIgggU9EgHf9tXfIgggU9EgNf6tXfIgggU9EgT
					f3tXfIgggU9EgTf3tXfIgggU9EgTf3tXfIgggU9EgUf3tXfIgggU9EgUf3tXfIgggU9EgTf3tXfIgggU9EgRf4tXfIgggU9EgQf5tXfIgggU9EgQf5tXfIgg
					gU9EgRf4tXfIgggU9EgRf4tXfIgggU9EgRf4tXfIgggU9Ef6gDtXfIgggU9EgQf5tXfIgggU9DgpfttX]],
				["Toe.L"] = [[
					fIgTgI/8gKf1hmfIgTgI/8f2gKhmfIgTgI/8gJf2hmfIgTgI/8gcfjhmfIgTgI/8gIf3hmfIgTgI/8f1gMhmfIgTgI/8gIf3hmfIgTgI/8gcfjhmfIgTgI/8
					gJf2hmfIgTgI/8f2gKhmfIgTgI/8gKf1hmfIgTgI/8gfffhmfIgTgI/8gMf0hmfIgTgI/8gAgAhmfIgTgI/8gNfzhmfIgTgI/8gNfzhmfIgTgI/8gNfzhmfI
					gTgI/8gMfzhmfIgTgI/8gMf0hmfIgTgI/8gKf1hmfIgTgI/8gJf3hmfIgTgI/8gHf4hmfIgTgI/8gGf6hmfIgTgI/8gFf6hmfIgTgI/8gKf2hmfIgTgI/8gO
					fxhmfIgTgI/8gOfxhmfIgTgI/8gPfwhmfIgTgI/8gPfwhmfIgTgI/8gPfwhmfIgTgI/8gOfxhmfIgTgI/8gNfyhmfIgTgI/8gMfzhmfIgTgI/8gMfzhmfIgT
					gI/8gNfzhmfIgTgI/8gNfzhmfIgTgI/8gNfzhmfIgTgI/8f7gFhmfIgTgI/8gMf0hmfIgTgI/8gfffhm]],
				["UpperLeg.R"] = [[
					g2hTgP8njpgXt0g3hUgR8vjZgvtng2hUgP8fjmgUuGg2hVgO8Ojzf6ukg2hVgP8ZjkgTuSg3hVgR8ljVgst+g2hVgP8ZjkgTuSg2hVgO8Ojzf6ukg2hUgP8f
					jmgUuGg3hUgR8vjZgvtng2hTgP8njpgXt0g2hTgO8ej5f/uCg2hSgP8vjsgatig3hSgQ86jlgrtMg2hSgP80jugbtXg2hRgP81jvgctWg2hSgP80jugbtXg2
					hSgP8yjtgbtcg2hSgP8qjrgZtvg2hTgO8ajmgVuQg2hUgN8HjggQu3g2hVgM72jbgNvXg2hWgL7tjZgKvpg2hWgL7pjXgJvvg2hUgO8VjkgTuag2hQgU9jj7
					gnrmg2hQgU9mj8goreg2hQgU9nj9gprag2hPgU9qj+gqrSg2hPgU9mj9gprcg2hQgS9Yj5glsDg2hRgR9Ejzgfszg2hSgQ81jugbtWg2hSgP8yjugbtcg2hS
					gP80jugbtXg2hRgP81jvgctWg2hSgP80jugbtXg3hSgR89jhgxtHg2hSgP8vjsgatig2hTgO8ej5f/uC]],
				["LowerLeg.R"] = [[
					g7g3f5rLe6f299g8g4f6rxecf59tg7g4f5rhe7f390g6g4f5rRfaf098g7g4f6rwe8f49vg8g5f6sMeef79ig7g4f6rwe8f49vg6g4f5rRfaf098g7g4f5rh
					e7f390g8g4f6rxecf59tg7g3f5rLe6f299g6g2f4qkfYf0+Mg7g3f4q0e4f1+Fg7g3f4q9ekf2+Bg7g2f4qme3f1+Kg7g2f4qke3f1+Lg7g2f4qme3f1+Kg7
					g2f4qre4f1+Ig7g3f4qve5f2+Hg7g3f4qwe6f4+Hg7g3f4qze8f6+Gg7g3f4q6e9f8+Dg7g3f4rEe/f9+Ag7g3f5rNe/f998g7g3f4q5e7f4+Dg7g4f5rke2
					fv9zg7g4f5rne2fu9yg7g4f5rje1fu90g7g4f5rbe1fu92g7g4f5rRe1fu96g7g3f4rEe2fw9/g7g3f4q5e3fz+Dg7g3f4qze4f1+Gg7g2f4qse4f1+Ig7g2
					f4qme3f1+Kg7g2f4qke3f1+Lg7g2f4qme3f1+Kg8g3f5rDedf39+g7g3f4q0e4f1+Fg6g2f4qkfYf0+M]],
				["Foot.R"] = [[
					g4gggU9EfygGtXg4gggU9DfZgStXg4gggU9Ef0gGtXg4gggU9EgOf5tXg4gggU9Ef1gFtXg4gggU9DfcgRtXg4gggU9Ef1gFtXg4gggU9EgOf5tXg4gggU9E
					f0gGtXg4gggU9DfZgStXg4gggU9EfygGtXg4gggU9EgLf7tXg4gggU9EfwgHtXg4gggU9DffgPtXg4gggU9EfvgItXg4gggU9EfvgItXg4gggU9EfvgItXg4
					gggU9EfwgHtXg4gggU9EfxgHtXg4gggU9EfygGtXg4gggU9Ef1gFtXg4gggU9Ef3gEtXg4gggU9Ef4gEtXg4gggU9Ef5gDtXg4gggU9EfzgGtXg4gggU9Eft
					gJtXg4gggU9EftgJtXg4gggU9EftgJtXg4gggU9EfsgJtXg4gggU9EfsgJtXg4gggU9EftgJtXg4gggU9EfvgItXg4gggU9EfwgHtXg4gggU9EfwgHtXg4gg
					gU9EfvgItXg4gggU9EfvgItXg4gggU9EfvgItXg4gggU9DfZgStXg4gggU9EfwgHtXg4gggU9EgLf7tX]],
				["Toe.R"] = [[
					g4gTgI/8f2gLhmg4gTgI/8fjgfhmg4gTgI/8f3gKhmg4gTgI/8gLf1hmg4gTgI/8f4gJhmg4gTgI/8flgdhmg4gTgI/8f4gJhmg4gTgI/8gLf1hmg4gTgI/8
					f3gKhmg4gTgI/8fjgfhmg4gTgI/8f2gLhmg4gTgI/8gIf3hmg4gTgI/8f0gMhmg4gTgI/8fngahmg4gTgI/8fzgNhmg4gTgI/8fzgNhmg4gTgI/8fzgNhmg4
					gTgI/8f0gNhmg4gTgI/8f0gMhmg4gTgI/8f2gLhmg4gTgI/8f3gJhmg4gTgI/8f5gIhmg4gTgI/8f6gGhmg4gTgI/8f7gGhmg4gTgI/8f2gKhmg4gTgI/8fy
					gPhmg4gTgI/8fygPhmg4gTgI/8fxgQhmg4gTgI/8fxgQhmg4gTgI/8fxgQhmg4gTgI/8fygPhmg4gTgI/8fzgOhmg4gTgI/8f0gNhmg4gTgI/8f0gNhmg4gT
					gI/8fzgNhmg4gTgI/8fzgNhmg4gTgI/8fzgNhmg4gTgI/8fjgfhmg4gTgI/8f0gMhmg4gTgI/8gIf3hm]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAh5geACe5gKgbgAh7geADfHhCgZgAiAgeAEffhwgZgAiFgeAGf9iKgagAiGgeAGgbiMgcgAiDgeAFg0h2gdgAh+geAEhFhLgegAh6geADhJgUgcgAh6geAD
					hBfZgagAh+geAEguelgZgAiDgeAFgTeBgZgAiGgeAGf0dygbgAiFgeAGfYd8gdgAiAgeAFfCedgegAh7geADe4fPgd]],
				Spine1 = [[
					gAh6gLAXe7gTklf/h8gLAZfLg0ktf+iBgLAcfkhNlBf9iFgLAfgDhYlUf9iHgLAgghhTlaf+iEgLAeg4hAlOf/h+gLAbhGgjk5gAh6gLAYhIf/kogBh6gLAY
					g/fckngCh+gLAagpe+k2gCiDgLAegMeslLgDiHgLAgfueplZgCiGgLAgfTe1lWgCiBgLAcfAfNlEgBh8gLAZe3fukv]],
				Spine2 = [[
					f/iEfnBJe+gboXf9iHfnBOfJgnoof7iMfnBZffgspPf6iSfoBkf7gop0f7iTfoBngXgcp9f8iQfnBfgugNplf+iKfnBTg9f9o7gAiFfnBLhDfsocgCiFfnBL
					g+ffobgEiJfnBTgtfWo6gGiPfoBfgTfVpkgGiTfoBnf2fdp9gFiSfoBkfdfrp0gDiNfnBZfJf7pQgBiHfnBOe/gMoo]],
				Neck1 = [[
					f+iPfVDpfFgouvf8iRfWDdfRgxuYf6iYfWD8fpgxvUf6iefXE3gFgow6f6iffXFogegVyFf8ibfXFpgwf/yGf+iVfWE5g6fsw9gBiPfVD+g9fdvXgDiPfVDd
					g2fTuZgFiUfWDngkfOutgGibfXEYgJfSwGgGiffXFTfufhxngFiefXFvfYf2yQgDiYfWFVfKgLxpgBiRfWEafEgcwK]],
				Neck2 = [[
					f8itfAGCfLgwyof5ive/GDfag3yrf4i3fCGhfwg0zTf4jAfHHIgKgn0Gf6jDfKHfgggS0if9i/fJHVgvf70WgAi3fFGxg4fmzogDivfBGMg4fWy3gGite/F+
					gvfLykgIizfAGPgcfJy7gIi8fEG1gDfRzugHjCfIHXfqfj0ZgFjBfKHefXf60hgCi7fIHFfMgQ0Cf/iyfDGdfHgjzO]],
				Head = [[
					f5jOe0AFe6gMhif3jQe0AFfAf2huf2jZe5AGfTfhiHf4jhe/AIfvfRicf6jlfEAIgNfIief+jhfDAHgnfKiNgCjYe9AGg6fWh0gFjQe3AFhFfphjgIjOe0AF
					hFf/hmgKjUe2AGg4gVh6gJjde8AHgfgoiTgHjkfCAIgCg1iggEjjfEAIfmg4iYgAjdfAAGfPgxiAf8jUe5AFfAghhp]],
				Jaw = [[
					f5jPeA/1hHf+i5f3jSeA/3g+gTisf4jceE/5gogliZf6jleL/3gJgxiqf9jpeP/3fqg1ixgBjkeO/3fSgviogEjaeI/3fBgiingGjReC/1e5gNi4gIjPd//2
					e8f3i1gJjWeB/4fMfjiggHjheH/4fnfUiigEjoeO/3gHfMivgBjneP/3gjfNiuf+jfeM/4g3fWigf7jVeF/2hEfoix]],
				["UpperArm.L"] = [[
					fNiGfFu2N6mC09fLiKfGvVN4lX0wfJiSfHwiNkjyz5fIiafIx6NIhxyhfJidfIzEMuf4w+fLiafHz0MZegvnfNiTfG0MMJdwurfQiOfF0WL9diuLfTiOfE0Y
					L3dsuCfViTfE0RL4eOuTfWiZfFz7MBfMvDfWicfFzKMQgowTfViZfFx9Moicx3fTiSfFwgNHkQzYfQiKfFvTNmlm0e]],
				["LowerArm.L"] = [[
					e3hmfD1U2aZnlEe0hqfC1o2uaxjdexhzfA2G28dIgpewh+e72X2ugKdaeviEe32R2GjIanexiEez2A1ZlZYweziAew1z07mrX7e2h8eu1002nAYAe5h7et2A
					1GmfYxe8h/et2R1llMaIe+iDev2h2KjNcFe+iDey2l2mgpeje+h9e32X2vd3hRe8hze8152kbajre6hqfA1c2XZ3lG]],
				["UpperArm.R"] = [[
					gviNfF0Y0HicuEgsiQfE0W0JiGuHgqiWfE0I0EhXungqibfFzmz4gKvngqicfFynzlegxEgsiWfFxPzKcoyqguiOfFv2ypa/0AgxiHfFu9yNaE0zg0iHfGu/
					yEaL08g2iNfHv4yQbV0Zg4iWfIxOyqdNzQg4icfIyizGfPxvg2icfIzfzdg5wQg0iXfH0Dzwh8vGgyiQfF0Tz+iauY]],
				["LowerArm.R"] = [[
					hIh7etKH07m2nthFh9esJ41Ul7mohDiBeuJm13kSk+hCiEewJb2ah+iwhCiBe0Jf2tfQgGhDh4e5J32rcjddhFhue+KX2cafbdhHhnfCKs2WZkauhKhnfDKl
					2jaBbkhNhufBKJ24b0d2hQh5e+Jv25eng/hRiCe5Jp2chskGhQiFe1J31ukXmdhOiCexKI1HmKnzhMh9evKO01m9oJ]],
				Tail1 = [[
					gAh7g5duhDhE/4gCh+g5c/g1hA/0gDiDg5cwgfgv/0gEiHg4dKgFgW/3gEiIg4d9fpf6/7gDiFg5enfPfg/8gCiAg5ere/fL/8gBh8g5eIe6e//5f/h8g5dU
					fDe8/2f+iAg5cyfVfH/zf9iFg5c4fufd/1f8iIg4djgKf4/5f8iHg5eVglgU/8f9iDg5evg6gr/8f/h+g5eehFg8/7]],
				Tail2 = [[
					gDiBhhcyi/g9/rgDiFhgbSh1g+/kgEiLhgabgagx/fgEiPhgaze8gZ/igDiOhhcIdpf8/qgBiJhhdjctfk/ugAiDhheIcWfT/uf+iBhhddcpfH/sf9iDhhcA
					djfB/of8iIhgaue3fH/hf8iNhgadgWfa/gf9iPhhbYhwf2/mf+iLhhc5i5gR/tgAiGhhd/jjgl/ugBiBhhd8jmg0/t]],
				Tail3 = [[
					gKiKiIbYlfhA/KgIiRiHZVjzg9/CgFiZiGXuhfgv+2gBiciHXme+gS+2f9iXiIZDcoft/Cf5iPiIbIa1fR/Lf3iIiIccZ5fE/Lf2iHiIcIaCfA/Lf3iNiHaZ
					bRfB/Hf6iWiHYZdUfI+8f9ibiGXcfxfe+0gBiaiHYKiQgB+7gFiTiIaGkXgj/IgIiLiIb9lxg3/MgKiHiIcgmLg//L]],
				Tail4 = [[
					gXiVisZ4oAhW+VgQiiirXsmThF+OgIitipVajhgu9+f+iwipUjgLgI93f1ioirVpc2fW+GftibitYBaAer+XfoiRitaFYKeb+ZfniRisadXrej+WfsibisY5
					Ysez+Tf0ioiqWdbAfF+Gf9iwipUveIfj94gHitiqU4hhgR98gQiiisWxkrhC+QgWiVitZMnFhg+agZiQitaioShj+Y]],
				Tail5 = [[
					gpiljNXop9iO9Jgfi2jLVwowhn8+gPjHjITLmCg98qf+jLjIRliUgH8dfujBjLR+eQfA8rffivjNUIaed89HfWihjOWqXkdZ9SfUigjNX2WIdi9NfbitjMW4
					WbeF9Efpi/jJUcYdeu81f5jLjHSKbwfc8hgKjIjJRgfugb8ggai5jMS5juhk85gninjOVdnJib9QgsiejNXgpXin9R]],
				["UpperLeg.L"] = [[
					fNhHgS2Xcfgs2lfMhJgV4DcYfr0xfKhQgY6+cLekwtfJhWgZ+JcDdEpffHhZgZ/XcabkinfGhXgY/hc7befzfGhSgW/qc8clgEfGhPgT/ocjeJitfHhOgQ/R
					b9fTlXfJhRgN+kbcgSoQfLhVgL9MbNhNsHfMhXgK7nbLhvvTfNhUgL6YbRh3xYfOhOgN5Ubfhqy8fOhJgP4Ab4hP0s]],
				["LowerLeg.L"] = [[
					fIgigShKfwfi/9fGgmgQdcg0fO/3fDgwgHdjiGfT/0fAhCf8jHjlgC/oe9hUf3rbk0hP9de8hYf1xVk2iG6Xe+hTfy0dj2iH4NfBhJfv1miYhp3afEhDfuzx
					hBhU5GfHg/fuwMf8hB7kfJg8fxtnfDgu87fKg4f3riehgh9zfLgzf8o1eXgS+tfLgsgClZenf//gfKglgJiUfIfv/5]],
				["Foot.L"] = [[
					fIggg29Ce8gftXfIgsgz8hf7gCuffIg1gr8GhJfYvPfIg7ge7yiceovnfIg9gQ7njkd/vofIg5gD7tj3d3vXfIgxf48IjJeWu1fIgmfy8uhwfKt8fIggf29E
					gbf0tXfIggf/9DfZgStXfIgggI9BekgqtWfIgggR9AeEg5tVfIgggb8/d5g+tVfIgggk8/eCg6tVfIgggt9BeagvtW]],
				["Toe.L"] = [[
					fIgTgr/7fMg3hmfIgegp/3f8gEi2fIgngh/wg1fAjtfIgtgV/mhwd1kKfIgugH/cikczkOfIgqf5/cizclj8fIgjfu/niTdTjTfIgYfn/2hUekiQfIgTfr/8
					gUfqhmfIgTf0/8figfhmfIgTf9/6e6hJhmfIgTgG/4eihjhmfIgTgP/3eZhshmfIgTgY/4eghlhmfIgTgi/5ezhShm]],
				["UpperLeg.R"] = [[
					g5hOgR/YjqhCk6g4hPgO/AkWgPmjg2hTgM98kufOqMg1hWgL8Yk1eet2gzhWgL68kzeKwdgyhRgM52kpeOyLgyhLgO4tkWeizygzhHgR3Oj2fC1pg0hHgU3F
					jkf113g1hMgX5Xjug3zHg3hTgZ8sj6iItbg4hYga/Bj2jzlog5hYgZ/djSksgug6hVgX/ljBkEfng6hQgU/sjPiqhG]],
				["LowerLeg.R"] = [[
					g9hDfv1veZeq3Yg7hBftx4fje16fg4g9fvuxgjfK8Xg2g6f0slhRfZ9Yg1g2f6qThnfm+Pg1gwf/nKhjf3/Jg2gogFjthKgK/wg3gjgOhbglgY/8g5gjgRe6
					fvgq/9g8gqgMc6ekgz/zg/g4gCfpdMgb/3hChMf4nXbtfZ+1hEhYf2uybAeP73hDhXf0zMbkd05HhAhOfx1Oc4eG3q]],
				["Foot.R"] = [[
					g4ggfx9DfBgdtXg4ggf79EgHf9tXg4gggE9ChEfhtXg4gggN9AhvfNtWg4gggW8/iFfDtVg4gggf8/iFfDtVg4gggo9Ah0fLtWg4gggx9ChWfZtWg4gmg18x
					gmftt+g4gxgv8SffgSu7g4g5gl77eNhAveg4g9gX7rc9hvvqg4g7gJ7ncJiLvhg4g1f974cZh9vIg4gsf08adhhRuc]],
				["Toe.R"] = [[
					g4gTfm/7fQgyhmg4gTfv/8gFf6hmg4gTf4/7gzfKhmg4gTgC/5hUenhmg4gTgL/3hkeWhmg4gTgU/3hleWhmg4gTgd/4hYejhmg4gTgm/6hBe8hmg4gYgr/5
					gdfhiRg4gjgm/0fogdjUg4gqgc/rethmj+g4gugO/hd0ivkPg4gtgA/adPjdkIg4gnfz/gdYjKjrg4gefq/veKiGi1]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAiDge/9gAgAhQgAhxge/8fye2hQgAh1ge/7fseXhQgAiHge/8fye2hQgAiDge/9gAgAhQgAhxge/8gOhKhQgAh1ge/7gUhphQgAiHge/8gOhKhQ]],
				Spine1 = [[
					gAiBgLAOgAgAjpf/hvgLALgYhIi3f+hzgLANgihmjCf/iGgLARgahHjzgAiBgLAOgAgAjpgBhvgLALfoe4i3gChzgLANfeeajCgBiGgLARfme5jz]],
				Spine2 = [[
					gAiKfmBEgAgAoIf8h2fmAvgghFmof6h7fmA1guhhm9f8iPfnBLgkhDodgAiKfmBEgAgAoIgEh2fmAvfge7mogGh7fmA1fSefm9gEiPfnBLfce9od]],
				Neck1 = [[
					gAiUfVE/gAgAxIf7h+fUDfgxg6ucf5iDfUD0hGhRvCf7iZfVFYg3g0xsgAiUfVE/gAgAxIgFh+fUDffPfGucgHiDfUD0e6evvCgFiZfVFYfJfMxs]],
				Neck2 = [[
					gAi2fEIAgAgA1Jf6ide9GGg5gyyuf3ije/GhhShFzRf7i8fGIfg/gr1pgAi2fEIAgAgA1JgGide9GGfHfOyugJije/Gheue7zRgFi8fGIffBfV1p]],
				Head = [[
					gAjZfAAPgAgAjuf5i+eyAGgVgjiMf3jEe2AIgfgxihf7jefEASgbghkDgAjZfAAPgAgAjugHi+eyAGfrfdiMgJjEe2AIfhfPihgFjefEASflffkD]],
				Jaw = [[
					gAjheM/4gAgAilf4jBd+/Vf1fZmaf1jIeB/ffufJlkf5joeQ/8frfahvgAjheM/4gAgAilgIjBd+/VgLgnmagLjIeB/fgSg3lkgHjoeQ/8gVgmhv]],
				["UpperArm.L"] = [[
					fPiPfErZOJns2tfJh5fHoPQQps4xfGh+fJpEQQo54xfJiVfIsOOome3BfPiPfErZOJns2tfWh3fAnyOpqq3afYh8e/ofOCqX21fWiTfBsBNOnu1m]],
				["LowerArm.L"] = [[
					e3hxfJJmJeeWjRexhdfWJPJribg1evhifXJLJxiBh5ewh3fNJdJ5eZkye3hxfJJmJeeWjRe9hbfMJgJTgyfLfAhffIJoJKfufle9h0fCKAJOc2jM]],
				["UpperArm.R"] = [[
					gxiPfErZx3YU2tgqh3fAnyxXVW3agoh8e/ofx+Vp21gqiTfBsByyYS1mgxiPfErZx3YU2tg3h5fHoPvwWU4xg6h+fJpEvwXH4xg3iVfIsOxYZi3B]],
				["LowerArm.R"] = [[
					hJhxfJJm2ihqjRhDhbfMJg2tfOfLhAhffIJo22gSflhDh0fCKA2yjKjMhJhxfJJm2ihqjRhPhdfWJP2Vdlg1hRhifXJL2Pd/h5hQh3fNJd2Hhnky]],
				Tail1 = [[
					gAiIg4eLgtf4/7gCh2g4cxgnf7/0gDh6g4dAgKf//2gCiMg4eZfngE/8gAiIg4eLfTgI/7f+h2g4cxfZgF/0f9h6g4dAf2gB/2f+iMg4eZgZf8/8]],
				Tail2 = [[
					gCiNhhfOiEft/6gEh+hgcpg6f5/zgDiChgcEfOgE/vgBiQhhepd+gN/5f+iNhhfOd8gT/6f8h+hgcpfGgH/zf9iChgcEgyf8/vf/iQhhepiCfz/5]],
				Tail3 = [[
					gHiPiJfSjvft/wgGiHiIcZiAf0/ugBiLiHacfFgC/ff8iUiJdUctgG/tf5iPiJfScRgT/wf6iHiIcZeAgM/uf/iLiHacg7f+/fgEiUiJdUjTf6/t]],
				Tail4 = [[
					gQiQiwejlOf//hgLiQivcWjlf2/lf/iZitZLf0f//Qf0iaiwbWcKf1/afwiQiwejaygB/hf1iQivcWcbgK/lgBiZitZLgMgB/QgMiaiwbWj2gL/a]],
				Tail5 = [[
					gdiUjWcemGgl/MgUiZjVbolMgM/Qf+iqjSYBhNgF+9fqimjVY2cgfl++fjiUjWceZ6fb/MfsiZjVboa0f0/QgCiqjSYBezf7+9gWimjVY2jggb++]],
				["UpperLeg.L"] = [[
					fKhTgX0Fc6gx4sfIhCgbuTcTdM8PfIhGgc6wcTXFRYfIhYgb/xdUdyhafKhTgX/vcpgAiHfLhAgT/harffg8fMhEgR5bbfhtyzfLhWgTuMdwiR8f]],
				["LowerLeg.L"] = [[
					fFgwgebwhEfs/se+gmgwGimZfPyQe7hkgNGxYheJN7fDhVf3EVdCfWQQfJhOfzAGfegQd0fJg+fvQrg8f/D8fJghgGfbgff2ACfJg5gpZDgjfyAy]],
				["Foot.L"] = [[
					fIg5hA8PgUf1vBfIhGgj3SvVXYtHfIhFgA68nQb8vHfIg3fk8Miieru1fJhJfP/Zflf2mGfIgggC9BeYgwtWfIgggq9Ce5ghtXfIgqhJ8Be2gpvY]],
				["Toe.L"] = [[
					fIgrg3/zgPfvjcfIg3ga6frBSSjgfIg3f3+olOZikAfIgofb/sh3d1jSfIhDe//afjgBZ/fIgTf3/5exhThmfIgTgf/7fKg5hmfIgbhA/ufKhBj2]],
				["UpperLeg.R"] = [[
					g2hTgX/vjXgAiHg1hAgT/hlVghg8g0hEgR5bkheTyzg1hWgTuMiQdv8fg2hTgX0FjGfP4sg4hCgbuTjti08Pg4hGgc6wjto7RYg4hYgb/xisiOha]],
				["LowerLeg.R"] = [[
					g3hOfz/6fegQiMg3g+fvvVg8f/8Eg3ghgGglgff2/+g3g5gpm9gjfy/Og7gwgebwe8gU/shCgmgwGiZngxyQhFhkgNGxnfh3N7g9hVf3EVi+gqQQ]],
				["Foot.R"] = [[
					g3hJfP/ZgbgKmGg4gggC9BhofQtWg4gggq9ChHfftXg4gqhJ8BhKfXvYg4g5hA8PfsgLvBg4hGgj3SQrootHg4hFgA68YwkEvHg4g3fk8MdehVu1]],
				["Toe.R"] = [[
					g4hDe/AmfjgBmBg4gTf3AHexhTeag4gTgfAFfKg5eag4gbhAASfKhBcKg4grg3ANgPfvckg4g3gaFhrBSScgg4g3f3BYlOZicAg4gofbAUh3d1cu]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAiHgeAHgAgAiYgAiDghAJgAgAiwgAh5gpAOgAgAjrgAhvgxAXgAgAkogAhpg1AcgAgAlJgAiLgHABgAgAgngAicfqAFgAgAd7gAicfqAFgAgAd7gAicfqAF
					gAgAd7gAiafuAEgAgAeOgAiVf7ABgAgAfZgAiOgNACgAgAg6gAiJgbAFgAgAiFgAiHgeAHgAgAiYgAiHgeAHgAgAiYgAiHgeAHgAgAiY]],
				Spine1 = [[
					gAiKgLAxgAgAm7gAiGgOA1gAgAnJgAh+gWA9gAgAnrgAh0gfBGgAgAoPgAhvgjBLgAgAoigAiMf0AegAgAlXgAiZfYAMgAgAjWgAiZfYAMgAgAjWgAiZfYAM
					gAgAjWgAiYfbAOgAgAjlgAiUfoAWgAgAkhgAiPf6AigAgAlwgAiLgIAugAgAmrgAiKgLAxgAgAm7gAiKgLAxgAgAm7gAiKgLAxgAgAm7]],
				Spine2 = [[
					gAiafpB+gAgArBgAiXfsCAgAgArGgAiPf1CEgAgArRgAiHf+CJgAgArdgAiDgDCLgAgArjgAiYfRBhgAgAptgAihezBIgAgAoXgAihezBIgAgAoXgAihezBI
					gAgAoXgAihe2BLgAgAojgAiffEBYgAgApQgAicfXBrgAgAqKgAiaflB6gAgAq2gAiafpB+gAgArBgAiafpB+gAgArBgAiafpB+gAgArB]],
				Neck1 = [[
					gAinfZEzgAgAw0gAikfdFMgAgAxcgAidfmGPgAgAy9gAiVfvHcgAgA0fgAiQf0IHgAgA1RgAikfADqgAgAu0gAirehB5gAgAqzgAirehB5gAgAqzgAirehB5
					gAgAqzgAirelCDgAgArOgAiqezCtgAgAs2gAipfHDtgAgAu6gAinfWEkgAgAwcgAinfZEzgAgAw0gAinfZEzgAgAw0gAinfZEzgAgAw0]],
				Neck2 = [[
					gAjJfJHDgAgA0BgAjHfOHugAgA00gAjBfaJegAgA2tgAi6foLfgAgA4igAi2fwMmgAgA5bgAjDerFegAgAx3gAjDeECugAgAs4gAjDeECugAgAs4gAjDeECu
					gAgAs4gAjEeIC9gAgAtZgAjGeaD8gAgAvWgAjIexFbgAgAxzgAjJfEGtgAgAzlgAjJfJHDgAgA0BgAjJfJHDgAgA0BgAjJfJHDgAgA0B]],
				Head = [[
					gAjrfBAEgAgAhvgAjpfIALgAgAjOgAjjfbAwgAgAm2gAjcfuB1gAgAqmgAjXf5CkgAgAsggAjjeeACgAgAg1gAjddsAagAgAbEgAjddsAagAgAbEgAjddsAa
					gAgAbEgAjedyAVgAgAbggAjjeHAJgAgAdQgAjoekABgAgAfigAjqe7ADgAgAhSgAjrfBAEgAgAhvgAjrfBAEgAgAhvgAjrfBAEgAgAhv]],
				Jaw = [[
					gAjseM/9gAgAhkgAjveU/+gAgAgzgAj2ep/+gAgAe0gAj6fD/ygAgAcdgAj6fR/qgAgAbagAjidp8RgAgAu/gAjJc89AgAgAtegAjJc8+fgAgAprgAjJc8+L
					gAgAqogAjMdA+2gAgAocgAjWdU/agAgAmCgAjidw/xgAgAjxgAjreG/7gAgAiBgAjseM/9gAgAhkgAjseM/9gAgAhkgAjseM/9gAgAhk]],
				["UpperArm.L"] = [[
					fPilfJzcMkgAwWfPiifM0CMMeTvDfPibfV1EL6Z8rzfPiTfe1iMsVPoZfPiPfj1jNiS1mrfPihev1/MgaZrWfPineR2hNBbzrwfPineR2hNBbzrwfPineR2h
					NBbzrwfPineU2WM9cEsFfPimej1nMxdLtVfPime20kMnenu6fPilfFzrMkfuwEfPilfJzcMkgAwWfPilfJzcMkgAwWfPilfJzcMkgAwW]],
				["LowerArm.L"] = [[
					e3iNe2JaJagAhne2iOe2JOKGdbkKeziRe7J/NBXaqNexiVfFMkR6R+vzewiXfMOgVFPtyOe1iWeUJEKscllle3iZd1JXJgh+fpe3iZd1JXJgh+fpe3iZd1JX
					Jgh+fpe3iYd5JXJfh2fxe3iUeKJXJdhVgSe3iQegJYJbgpg9e3iOexJaJagIhfe3iNe2JaJagAhne3iNe2JaJagAhne3iNe2JaJagAhn]],
				["UpperArm.R"] = [[
					gxilfJzczcgAwWgxiifM0Cz0htvDgxibfV1E0GmErzgxiTfe1izUqxoZgxiPfj1jyetLmrgxihev1/zglnrWgxineR2hy/kNrwgxineR2hy/kNrwgxineR2h
					y/kNrwgxineU2WzDj8sFgximej1nzPi1tVgxime20kzZhZu6gxilfFzrzcgSwEgxilfJzczcgAwWgxilfJzczcgAwWgxilfJzczcgAwW]],
				["LowerArm.R"] = [[
					hJiNe2Ja2mgAhnhKiOe2JO16ilkKhNiRe7J/y/omqNhPiVfFMkuGuCvzhQiXfMOgq7wTyOhLiWeUJE1UjbllhJiZd1JX2geCfphJiZd1JX2geCfphJiZd1JX
					2geCfphJiYd5JX2heKfxhJiUeKJX2jergShJiQegJY2lfXg9hJiOexJa2mf4hfhJiNe2Ja2mgAhnhJiNe2Ja2mgAhnhJiNe2Ja2mgAhn]],
				Tail1 = [[
					gAiGg5gYgAgA//gAiCg8gcgAgA//gAh2hEglgAgA//gAhqhLgvgAgA/+gAhkhQg0gAgA/+gAiNgidegAgA/5gAiigEb7fYgG/ugAiigEc7fdgE/1gAiigEc7
					gjf8/1gAiggIdShRf3/2gAiZgWemhGf7/8gAiQgof9gMgA//gAiIg1gtfvgA/+gAiGg5ghf6gA//gAiGg5gYgAgA//gAiGg5gYgAgA//]],
				Tail2 = [[
					gAiFhhflgAgA//gAiBhkfVgAgA//gAh1hsetgAgA/9gAhoh0eDgAgA/7gAhih4dtgAgA/6gAiUhKbjgAgA/rf+itgsbJevgK/mf/iqgsdJe7gH/2gBiqgsdJ
					hFf5/2gDingwdliify/zgDidg+fCiLf6/5gAiQhQgOgYgA//f/iGhegifdf//+gAiFhhf5fzgA//gAiFhhflgAgA//gAiFhhflgAgA//]],
				Tail3 = [[
					gAiGiKd9gAgA/7gAiCiNdZgAgA/4gAh4iUcAgAgA/vgAhticaigAgA/hgAhoigZxgAgA/YgAifhxY0gAgA/Lf7i5hSZieGgJ/Rf8ixhUcheYgF/wgEixhUch
					hof7/wgKithXdCj0f4/ogIifhmeojRgC/ygBiPh5foglgC//f+iFiGfifMf8/+f/iFiKeaftf//8gAiGiKd9gAgA/7gAiGiKd9gAgA/7]],
				Tail4 = [[
					gAiMiycFgAgA/wgAiJi1bOgAgA/ogAiCi8ZFgAgA/PgAh7jCW3gAgA+qgAh3jGVtgAgA+SgAiwiVV7gAgA+Xf2jJh3XvddgD+zf4i6h7bqd1f+/ngIi6h7bq
					iLgC/ngTi1h+cSlEgI/XgQijiOeAkVgT/ogDiQihe0gxgF/9f8iGiveSe7f3/7f+iJiycsfmf9/0gAiMiycFgAgA/wgAiMiycFgAgA/w]],
				Tail5 = [[
					gAiVjZZmgAgA/WgAiVjcYcgAgA/FgAiTjgVogAgA+QgAiRjkSugAgA9GgAiQjmRQgAgA8ZgAjJi2ShgAgA9AfwjdiaVXc1fz+AfyjFiiaMdTfw/VgOjFiiaM
					itgQ/Vggi+ija8mRgq+9gbioi0cxlWgy/XgFiTjKdWg8gL/3f5iLjXcaerfu/wf9iSjaaXfgf5/fgAiVjZZmgAgA/WgAiVjZZmgAgA/W]],
				["UpperLeg.L"] = [[
					fKhagM7MczgAwifKhXgO8Ecmfyu+fKhOgT9vcMfQrHfKhFgZ+/b3eqmnfKhAgc/abueUj8fKhcf726dagt2KfKhsfmzEd+hL5lfKhsfmzEd+hL5lfKhsfmzE
					d+hL5lfKhqfozRd9hK5bfKhlfy0Ld7hF4ufKhff/3Wddgs1tfKhbgK6kc6gIxjfKhagM7MczgAwifKhagM7MczgAwifKhagM7MczgAwi]],
				["LowerLeg.L"] = [[
					fGg6f7sxg6gA9UfFg5f6r8hBgF9qfFg3f4quhNgQ+HfFg3f4qvhTgZ+GfFg4f5rZhTgd93fHg4f5rlgnfv90fHhJfwsbgTfk9efHhJfwsbgTfk9efHhJfwsb
					gTfk9efHhHfyspgTfk9YfHhCf5ttgUfl85fHg7f9tfgkfu9AfGg6f7ssg3f99WfGg6f7sxg6gA9UfGg6f7sxg6gA9UfGg6f7sxg6gA9U]],
				["Foot.L"] = [[
					fIgggU9EgAgAtXfIgggU9EgIf8tXfIgggU9EgVf2tXfIgggU9DgdfztXfIgggU9DgefytXfIgggU9EfrgKtXfIgvgJ62fbgYxZfIgvgJ62fbgYxZfIgvgJ62
					fbgYxZfIgtgL7KfbgXw4fIgmgQ8RfZgVu8fIgggU9EfogLtXfIgggU9Ef8gCtXfIgggU9EgAgAtXfIgggU9EgAgAtXfIgggU9EgAgAtX]],
				["Toe.L"] = [[
					fIgTgI/8gAgAhmfIgTgI/8gGf6hmfIgTgI/8gQfvhmfIgTgI/8gWfphmfIgTgI/8gXfohmfIgTgI/8fwgRhmfIgfgC/YfngkmKfIgfgC/YfngkmKfIgfgC/Y
					fngkmKfIgegD/ffmgjlkfIgYgG/zfjgijWfIgTgI/8fugThmfIgTgI/8f9gDhmfIgTgI/8gAgAhmfIgTgI/8gAgAhmfIgTgI/8gAgAhm]],
				["UpperLeg.R"] = [[
					g2hagM7MjNgAwig2hXgO8EjagOu+g2hOgT9vj0gwrHg2hFgZ+/kJhWmng2hAgc/akShsj8g2hcf7+bkMhAo3g2hsfm/LknivbQg2hsfm/LknivbQg2hsfm/L
					knivbQg2hqfo/Xknilchg2hlfy/jkdh1iOg2hff/+Kj+g2p3g2hbgK78jYgLvNg2hagM7MjNgAwig2hagM7MjNgAwig2hagM7MjNgAwi]],
				["LowerLeg.R"] = [[
					g6g6f7sxfGgA9Ug7g5f6r8e/f79qg7g3f4quezfw+Hg7g3f4qvetfn+Gg7g4f5rZetfj93g7hJfcqnevfq+Jg7h3fD07fAfY4Kg7h3fD07fAfY4Kg7h3fD07
					fAfY4Kg7hzfFzye9fY5Hg7hhfPvle1fb76g7hLfisde1fq9cg6g9f2sbfBf79dg6g6f7sxfGgA9Ug6g6f7sxfGgA9Ug6g6f7sxfGgA9U]],
				["Foot.R"] = [[
					g4gggU9EgAgAtXg4gggU9Ef4gEtXg4gggU9EfrgKtXg4gggU9DfjgNtXg4gggU9DfigOtXg4gzf4+/fggIn8g4hUfJ/Ifof6Yqg4hUfJ/Ifof6Yqg4hUfJ/I
					fof6Yqg4hQfO/cfkf7aHg4hDfh/+fdgBgxg4gxf7+xfogHowg4gjgP9Zf6gDspg4gggU9EgAgAtXg4gggU9EgAgAtXg4gggU9EgAgAtX]],
				["Toe.R"] = [[
					g4gTgI/8gAgAhmg4gTgI/8f6gGhmg4gTgI/8fwgRhmg4gTgI/8fqgXhmg4gTgI/8fpgYhmg4grfp/tflgUb2g4hbe56KfngENmg4hbe56KfngENmg4hbe56K
					fngENmg4hWe96/fkgGO2g4hCfQ9+fggOU1g4gofs/0fsgPcrg4gXgD/+f7gFgzg4gTgI/8gAgAhmg4gTgI/8gAgAhmg4gTgI/8gAgAhm]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiHgeAHgAgAiYgAiEgeAFgAgAh+gAh+geACgAgAhCgAh5geABgAgAgRgAh6geABgAgAgagAiFgeAJgAgAiygAiMgeAYgAgAk0gAiNgeAcgAgAlKgAiNgeAc
					gAgAlKgAiNgeAcgAgAlKgAiNgeAcgAgAlKgAiNgeAcgAgAlKgAiNgeAcgAgAlKgAiNgeAcgAgAlKgAiNgeAcgAgAlKgAiNgeAcgAgAlKgAiNgeAcgAgAlKgA
					iNgeAbgAgAlGgAiLgeASgAgAkIgAiIgeAJgAgAi0gAiHgeAHgAgAiYgAiHgeAHgAgAiYgAiHgeAHgAgAiY]],
				Spine1 = [[
					gAiKgLAxgAgAm7gAiHgLAqgAgAmXgAh/gLAbgAgAlGgAh5gLARgAgAkDgAh6gLATgAgAkPgAiJgLA6gAgAnegAiSgMBsgAgAqOgAiTgMB2gAgAqrgAiTgMB2
					gAgAqrgAiTgMB2gAgAqrgAiTgMB2gAgAqrgAiTgMB2gAgAqrgAiTgMB2gAgAqrgAiTgMB2gAgAqrgAiTgMB2gAgAqrgAiTgMB2gAgAqrgAiTgMB2gAgAqrgA
					iTgMB1gAgAqmgAiQgMBZgAgApTgAiLgLA6gAgAnhgAiKgLAxgAgAm7gAiKgLAxgAgAm7gAiKgLAxgAgAm7]],
				Spine2 = [[
					gAiafpB+gAgArBgAiVfoBvgAgAqVgAiLfnBPgAgAoxgAiDfmA6gAgAnfgAiEfnA9gAgAnugAiafqCPgAgArugAipfuDygAgAvDgAirfvEEgAgAvlgAirfvEE
					gAgAvlgAirfvEEgAgAvlgAirfvEEgAgAvlgAirfvEEgAgAvlgAirfvEEgAgAvlgAirfvEEgAgAvlgAirfvEEgAgAvlgAirfvEEgAgAvlgAirfvEEgAgAvlgA
					iqfvEBgAgAvggAilfsDOgAgAt8gAidfqCQgAgArxgAiafpB+gAgArBgAiafpB+gAgArBgAiafpB+gAgArB]],
				Neck1 = [[
					gAinfZEzgAgAw0gAiifYEAgAgAvegAiWfWCfgAgAsTgAiMfUBggAgApogAiOfVBqgAgAqHgAiofbFOgAgAxfgAi6fiJWgAgA2lgAi8fkKFgAgA3SgAi8fkKF
					gAgA3SgAi8fkKFgAgA3SgAi8fkKFgAgA3SgAi8fkKFgAgA3SgAi8fkKFgAgA3SgAi8fkKFgAgA3SgAi8fkKFgAgA3SgAi8fkKFgAgA3SgAi8fkKFgAgA3SgA
					i8fkJ9gAgA3LgAi1fgH7gAgA1EgAirfbFhgAgAx7gAinfZEzgAgAw0gAinfZEzgAgAw0gAinfZEzgAgAw0]],
				Neck2 = [[
					gAjJfJHDgAgA0BgAjCfEFzgAgAyWgAixe7DagAgAuVgAiie1B6gAgAq1gAike2CJgAgAregAjKfMHugAgA01gAjffiOQgAgA6ngAjifmPagAgA7WgAjifmPa
					gAgA7WgAjifmPagAgA7WgAjifmPagAgA7WgAjifmPagAgA7WgAjifmPagAgA7WgAjifmPagAgA7WgAjifmPagAgA7WgAjifmPagAgA7WgAjifmPagAgA7WgA
					jhfmPNgAgA7OgAjafbMCgAgA4/gAjOfNIMgAgA1XgAjJfJHDgAgA0BgAjJfJHDgAgA0BgAjJfJHDgAgA0B]],
				Head = [[
					gAjrfBAEgAgAhvgAjie4ADgAgAeugAjMenBCgAgAYAgAi4ebC3gAgAS0gAi8edCegAgATtgAjtfGANgAfpjegAj/fwELgXfJvwgAkAf2EZfOhxwCgAkAf2FF
					gQfgxRgAkAf2FZgresxsgAkAf2EbfShowHgAkAf2E6gAgAxAgAkAf2Fgg1ebx1gAkAf2EgfZhWwRgAkAf2EwfxggwvgAkAf2Fkg6eTx5gAkAf2Enfkg9wfgA
					kAf1Ecflg8wNgAj8fiCggWe1sUgAjwfJATgAgGkOgAjrfBAEgAgAhvgAjrfBAEgAgAhvgAjrfBAEgAgAhv]],
				Jaw = [[
					gAjseM/9gAgAhkgAjaeE/ngAgAk4gAiwd79ngAgAsGgAiOd76ygAgAxegAiUd77XgAgAwkgBj0eS/of6gWkvgDkqfR/8fSgmemf6ksfZ/7hke3f5gCkufd/8
					fjgUeegFkvfe/5ewgzd8f6ksfZ/8hce9fzgAkufc/+gAgAeygGkvff/3egg9dxf7ksfa/9hNfJfof+ktfb/+gdfsfGgGkvff/2eXhCdrf9ktfa/+g3fZfYf9
					ksfY/+g1fZfbgEkee7/9fQg+fHgAj6eV/+gBf7hLgAjseM/9gAgAhkgAjseM/9gAgAhkgAjseM/9gAgAhk]],
				["UpperArm.L"] = [[
					fPilfJzcMkgAwWfPiffHzmMkf0wKfPiSfFz9MkfZvufPiGfE0PMlfCvXfPiIfF0MMlfGvbfPinfK0kLmZkr8fPi8fSz5ODPqmJfPi/fTzePUNjk/fPi/fTze
					PUNjk/fPi/fTzePUNjk/fPi/fTzePUNjk/fPi/fTzePUNjk/fPi/fTzePUNjk/fPi/fTzePUNjk/fPi/fTzePUNjk/fPi/fTzePUNjk/fPi/fTzePUNjk/fP
					i/fTzjPGN5lLfPi2fP0aMPUNowfPiqfK0CL1dMuZfPilfJzcMkgAwWfPilfJzcMkgAwWfPilfJzcMkgAwW]],
				["LowerArm.L"] = [[
					e3iNe2JaJagAhne3iHe0JbJafyh1e3h6exJeJbfSiVe3hwevJhJce4ive3hyewJhJce8ireyieexI2M9ZMo0eujKfCMGWdSFyfetjQfINeZGRM0TetjQfINe
					ZGRM0TetjQfINeZGRM0TetjQfINeZGRM0TetjQfINeZGRM0TetjQfINeZGRM0TetjQfINeZGRM0TetjQfINeZGRM0TetjQfINeZGRM0TetjQfINeZGRM0Tet
					jPfHNPYpRU0Bevi6e4J8RlUzuRe1iYezI0Kwc0k2e3iNe2JaJagAhne3iNe2JaJagAhne3iNe2JaJagAhn]],
				["UpperArm.R"] = [[
					gxilfJzczcgAwWgxiffHzmzcgMwKgxiSfFz9zcgnvugxiGfE0Pzbg+vXgxiIfF0Mzbg6vbgxinfK0k0amcr8gxi8fSz5x9wWmJgxi/fTzewsydk/gxi/fTze
					wsydk/gxi/fTzewsydk/gxi/fTzewsydk/gxi/fTzewsydk/gxi/fTzewsydk/gxi/fTzewsydk/gxi/fTzewsydk/gxi/fTzewsydk/gxi/fTzewsydk/gx
					i/fTzjw6yHlLgxi2fP0azxrzowgxiqfK0C0Li0uZgxilfJzczcgAwWgxilfJzczcgAwWgxilfJzczcgAwW]],
				["LowerArm.R"] = [[
					hJiNe2Ja2mgAhnhJiHe0Jb2mgOh1hJh6exJe2lguiVhJhwevJh2khIivhJhyewJh2khEirhOieexI2zDm0o0hSjKfCMGpjt7yfhTjQfINem6u00ThTjQfINe
					m6u00ThTjQfINem6u00ThTjQfINem6u00ThTjQfINem6u00ThTjQfINem6u00ThTjQfINem6u00ThTjQfINem6u00ThTjQfINem6u00ThTjQfINem6u00ThT
					jPfHNPnXus0BhRi6e4J8ubrNuRhLiYezI01QjMk2hJiNe2Ja2mgAhnhJiNe2Ja2mgAhnhJiNe2Ja2mgAhn]],
				Tail1 = [[
					gAiGg5gYgAgA//gAiEg5gNgAgA//gAh/g5f1gAgA//gAh8g5figAgA//gAh8g5flgAgA//gAiEg5gbf0gA//gAiHg4hEfhgA/+gAiHg4hKhAgB/9gAiHg4hK
					fugA/+gAiHg4hKfPf//9gAiHg4hKg6gB/9gAiHg4hKgAgA/+gAiHg4hKfGf//9gAiHg4hKgxgB/9gAiHg4hKgSgA/+gAiHg4hKfAf//9gAiHg4hKgjgA/9gA
					iHg4hJgigA/9gAiHg5g3fYgA/+gAiGg5gggDgA//gAiGg5gYgAgA//gAiGg5gYgAgA//gAiGg5gYgAgA//]],
				Tail2 = [[
					gAiFhhflgAgA//gAiEhhfrgAgA//gAiAhhf3gAgA//gAh9hhgAgAgA//gAh9hhf/gAgA//gAiDhhfSf4gA/+f/iEhhegerf+/7gDiEhheXhngF/6f/iEhheX
					gLf9/8f+iEhheXePf9/5gCiEhheXhTgF/7gAiEhheXgsf//8f+iEhheXeJf8/5gCiEhheXg3gF/8gBiEhheXhJgA/7f9iEhheXeMf7/5gBiEhheXgXgE/8gB
					iEhheYhfgC/6f+iFhhe0e/f+/9gAiFhhfZf+gA//gAiFhhflgAgA//gAiFhhflgAgA//gAiFhhflgAgA//]],
				Tail3 = [[
					gAiGiKd9gAgA/7gAiEiKeSgAgA/8gAiAiKfCgAgA/+gAh9iKfpgAgA//gAh9iKfigAgA//f/iFiKdTgKgA/4f7iIiJbId6f3/jgHiIiJavhhgR/hgAiIiJav
					hIf8/if6iIiJavdkfy/dgGiIiJavg6gP/igCiIiJavhsgC/gf5iIiJavdsfv/egEiIiJavgPgM/jgEiIiJaviIgG/ff5iIiJaveAfu/fgCiIiJavfjgI/jgF
					iIiJaziVgL/ef8iIiJb7fCf4/tgAiHiKdcf1f//4gAiGiKd9gAgA/7gAiGiKd9gAgA/7gAiGiKd9gAgA/7]],
				Tail4 = [[
					gAiMiycFgAgA/wgAiJiycqgAgA/0gAiDiyd+gAgA/7gAh+iyfCgAgA/+gAh/iye2gAgA/+gAiLiybFgfgD/mf2iUivXldrfo+xgKiWivW+gvgf+rgDiWivW+
					iCgD+nf0iWivW+dlff+lgIiWivW+f+gZ+rgGiWivW+icgN+lfziWivW+eAfd+ngFiWivW+fOgR+rgJiWivW+iqgV+kf0iWivW+elfe+pgBiWivW+eigH+pgL
					iVivXFimgc+mf5iSiwY1fhfy/LgAiNiybRfsf+/ogAiMiycFgAgA/wgAiMiycFgAgA/wgAiMiycFgAgA/w]],
				Tail5 = [[
					gAiVjZZmgAgA/WgAiRjaabgAgA/ggAiIjacSgAgA/xgAiAjbdzgAgA/6gAiBjbdhgAgA/5gBiYjYYSgsgI/CfxipjSTjeIfU9ZgMisjRSwfqgn9GgHisjRSw
					iagU9AfuisjQSweWfI9DgHisjRSwe9ga9GgMisjRSwihgi9AfvisjQSwe9fK9FgDisjRSweXgL9EgPisjQSwibgt9AfxisjRSwfpfQ9Gf9isjRSwd5f79CgR
					irjQS4iFgz9Ff4ikjVVNgMfx+Hf/iZjYYffof7/GgAiVjZZmgAgA/WgAiVjZZmgAgA/WgAiVjZZmgAgA/W]],
				["UpperLeg.L"] = [[
					fKhagM7MczgAwifKhXgN74cmf1vUfKhQgQ9HcLffssfKhKgS96b3fNqjfKhLgS9xb7fRq7fKhZgL7Ocyf+wffKhigG38dogn1EfKhkgF3Odygv14fKhkgF3O
					dygv14fKhkgF3Odygv14fKhkgF3Odygv14fKhkgF3Odygv14fKhkgF3Odygv14fKhkgF3Odygv14fKhkgF3Odygv14fKhkgF3Odygv14fKhkgF3Odygv14fK
					hjgF3Wdwgt1vfKhggH5HdWgbzpfKhcgL6wc7gGxRfKhagM7MczgAwifKhagM7MczgAwifKhagM7MczgAwi]],
				["LowerLeg.L"] = [[
					fGg6f7sxg6gA9UfFg5f6r2hBgF9sfFg2f3qNhLgN+TfFg0f2pRhRgS+mfFg0f2pahQgR+jfGg5f6sEg8gA9nfHg+gBvigfft79fHg/gCwQgZfq7jfHg/gCwQ
					gZfq7jfHg/gCwQgZfq7jfHg/gCwQgZfq7jfHg/gCwQgZfq7jfHg/gCwQgZfq7jfHg/gCwQgZfq7jfHg/gCwQgZfq7jfHg/gCwQgZfq7jfHg/gCwQgZfq7jfH
					g/gCwIgafq7ofHg9f+ubgpfz8ifGg7f8tFg3f99LfGg6f7sxg6gA9UfGg6f7sxg6gA9UfGg6f7sxg6gA9U]],
				["Foot.L"] = [[
					fIgggU9EgAgAtXfIgggU9EgHf9tXfIgggU9EgUf3tXfIgggU9Egbf0tXfIgggU9Egaf0tXfIgggU9EgCf/tXfIgggU9DfigOtXfIgggU9DfbgRtXfIgggU9D
					fbgRtXfIgggU9DfbgRtXfIgggU9DfbgRtXfIgggU9DfbgRtXfIgggU9DfbgRtXfIgggU9DfbgRtXfIgggU9DfbgRtXfIgggU9DfbgRtXfIgggU9DfbgRtXfI
					gggU9DfdgQtXfIgggU9EftgJtXfIgggU9Ef8gCtXfIgggU9EgAgAtXfIgggU9EgAgAtXfIgggU9EgAgAtX]],
				["Toe.L"] = [[
					fIgTgI/8gAgAhmfIgTgI/8gFf6hmfIgTgI/8gPfwhmfIgTgI/8gUfrhmfIgTgI/8gTfshmfIgTgI/8gBf+hmfIgTgI/8fpgYhmfIgTgI/8fkgdhmfIgTgI/8
					fkgdhmfIgTgI/8fkgdhmfIgTgI/8fkgdhmfIgTgI/8fkgdhmfIgTgI/8fkgdhmfIgTgI/8fkgdhmfIgTgI/8fkgdhmfIgTgI/8fkgdhmfIgTgI/8fkgdhmfI
					gTgI/8flgchmfIgTgI/8fxgQhmfIgTgI/8f9gDhmfIgTgI/8gAgAhmfIgTgI/8gAgAhmfIgTgI/8gAgAhm]],
				["UpperLeg.R"] = [[
					g2hagM7MjNgAwig2hXgN74jagLvUg2hQgQ9Hj1ghssg2hKgS96kJgzqjg2hLgS9xkFgvq7g2hZgL7OjOgCwfg2higG38iYfZ1Eg2hkgF3OiOfR14g2hkgF3O
					iOfR14g2hkgF3OiOfR14g2hkgF3OiOfR14g2hkgF3OiOfR14g2hkgF3OiOfR14g2hkgF3OiOfR14g2hkgF3OiOfR14g2hkgF3OiOfR14g2hkgF3OiOfR14g2
					hjgF3WiQfT1vg2hggH5Hiqflzpg2hcgL6wjFf6xRg2hagM7MjNgAwig2hagM7MjNgAwig2hagM7MjNgAwi]],
				["LowerLeg.R"] = [[
					g6g6f7sxfGgA9Ug7g5f6r2e/f79sg7g2f3qNe1fz+Tg7g0f2pRevfu+mg7g0f2paewfv+jg6g5f6sEfEgA9ng5g+gBvifhgT79g5g/gCwQfngW7jg5g/gCwQ
					fngW7jg5g/gCwQfngW7jg5g/gCwQfngW7jg5g/gCwQfngW7jg5g/gCwQfngW7jg5g/gCwQfngW7jg5g/gCwQfngW7jg5g/gCwQfngW7jg5g/gCwQfngW7jg5
					g/gCwIfmgW7og5g9f+ubfXgN8ig6g7f8tFfJgD9Lg6g6f7sxfGgA9Ug6g6f7sxfGgA9Ug6g6f7sxfGgA9U]],
				["Foot.R"] = [[
					g4gggU9EgAgAtXg4gggU9Ef5gDtXg4gggU9EfsgJtXg4gggU9EflgMtXg4gggU9EfmgMtXg4gggU9Ef+gBtXg4gggU9DgefytXg4gggU9DglfvtXg4gggU9D
					glfvtXg4gggU9DglfvtXg4gggU9DglfvtXg4gggU9DglfvtXg4gggU9DglfvtXg4gggU9DglfvtXg4gggU9DglfvtXg4gggU9DglfvtXg4gggU9DglfvtXg4
					gggU9DgjfwtXg4gggU9EgTf3tXg4gggU9EgEf+tXg4gggU9EgAgAtXg4gggU9EgAgAtXg4gggU9EgAgAtX]],
				["Toe.R"] = [[
					g4gTgI/8gAgAhmg4gTgI/8f7gGhmg4gTgI/8fxgQhmg4gTgI/8fsgVhmg4gTgI/8ftgUhmg4gTgI/8f/gChmg4gTgI/8gXfohmg4gTgI/8gcfjhmg4gTgI/8
					gcfjhmg4gTgI/8gcfjhmg4gTgI/8gcfjhmg4gTgI/8gcfjhmg4gTgI/8gcfjhmg4gTgI/8gcfjhmg4gTgI/8gcfjhmg4gTgI/8gcfjhmg4gTgI/8gcfjhmg4
					gTgI/8gbfkhmg4gTgI/8gPfwhmg4gTgI/8gDf9hmg4gTgI/8gAgAhmg4gTgI/8gAgAhmg4gTgI/8gAgAhm]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiHgeAHgAgAiYgAiFgeAGgEgriKgAhzgeAEgNhlgtgAidgeANgFhmjJgAjBgeAYgAg/kqgAjOgeAcgAgAlKgAjBgeAYgAfBkqgAidgeANf7eajJgAhygeAE
					fzebgtgAh7geAEf5fBhXgAh4geACgAgAhLgAivgeARgCg/j7gAjJgeAcf/hmk+gAjMgeAdf/hmlEgAi2geAUgBg/kNgAiGgeAFgAgAh6gAh4geADf5fBhLgA
					iHgeAJf4eaiWgAiHgeAIf6e0iYgAiHgeAHf/fwiYgAiHgeAHgAgAiY]],
				Spine1 = [[
					gAiKgLAxgAgAm7f/iHgLAtgKgqmmf+hzgLAXgZhjkcf+ihgMBCgUhkn2f/jHgMBkgLg+pzgAjUgMBwgAgAqagBjHgMBkf1fCpzgCihgMBCfsecn2gChzgLAX
					fnedkbgBh8gLAffxfDlagAh6gLAcgAgAlJf/izgMBSgMg+o3f+jPgMBugQhlqLf+jSgMBxgQhlqTf/i7gMBZgLg+pOgAiIgLAngAgAmLgBh6gLAdfxfDlJgC
					iKgLAzfqedm3gBiKgLAzfve1m6gAiKgLAxf9fxm7gAiKgLAxgAgAm7]],
				Spine2 = [[
					gAiafpB+gAgArBf+iWfpB1gPgpqnf7h+fnBCgjhgn0f7izfqCbgihgsFf9jdftDdgUg8uZgAjrfuDzgAgAvGgDjdftDdfsfEuZgFizfqCbfeegsFgFh+fnBB
					fdegnzgDiJfoBWfqfFpFgAiGfnBPgAgAouf9jIfsC8gVg8tTf7jmfuDtgghhu0f7jpfuDygghhu9f9jQfsDIgUg8tvgAiWfoBogAgAqBgDiGfnBQfqfFougF
					iZfpB/fdegq9gEiafpCAfme4rBgBiafpB+f7fxrBgAiafpB+gAgArB]],
				Neck1 = [[
					gAinfZEzgAgAw0f9ijfZEbgXglwMf5iHfVCVgvhar1f5jBfcF2g2hWyVf8jtfhIZgjg01kgAj8fjJRgAgA2ggEjtfhIZfdfM1kgHjBfcF2fKeqyVgHiHfVCU
					fRemrzgEiUfXDLfhfJt1gAiQfWC5gAgAtRf8jXfeHIgjg10Ff5j2fjI+g6hU2Jf5j5fjJKg6hU2Vf8jffgHngjg00rgAiifYD5gAgAvQgEiQfWC6fifJtRgH
					infaExfLepwtgFinfaE0fYe/wzgBinfaEzf4fzw0gAinfZEzgAgAw0]],
				Neck2 = [[
					gAjJfJHDgAgA0Bf8jEfGGngbgizcf3ihe6D/g6hUvXf4jlfPIShBhP1Zf7kTfeLNgpgv4SgAkifjMMgAgA5HgFkTfeLNfXfR4SgIjlfPISe/ex1ZgJihe6D+
					fGesvVgGixe/FFfbfNxQgAite9EvgAgAwuf7j8fXJxgpgw2+f5kcfhL2hEhM4yf5kffiMDhEhM49f7kFfZKVgpgw3ggAjCfDF+gAgAylgGite9EwfbfNwugJ
					jIfJHBfAewz6gGjJfJHEfQfE0AgBjJfJHDf2f00BgAjJfJHDgAgA0B]],
				Head = [[
					gAjrfBAEgAgAhvf8jle9ALefguilf1i/enAVcbiLelf3kHfMAzchhTl7f7k1fjBpd7ggp0gAlDfrB+gAgArAgFk1fjBpiFfgp0gJkHfMAzjfetl7gLi+enAV
					jld1ejgGjRewAIiNe0gpgAjMetABgAgAf8f7kffYBGd4gpn9f5k+foCCcrguqqf5lBfqCIcrgsq5f7knfcBTd5gmosgAjje4AGgAgAiKgHjMeuAHiNexgBgJ
					jqfBAgjheekBgHjrfBAWiqe0jfgBjrfBAHgkfviTgAjrfBAEgAgAhv]],
				Jaw = [[
					gAjseM/9gAgAhlf6jqeJ/Shrfvmdfvi1d09FkHfQspfykWeZ/RjugClnf4lQe2/4iIgRhrgAlifA//gAgAgdgIlQe2/4d4fvhrgOkWeZ/RcSf+lngRi1d09F
					b5gwsqgKjPd8+AdhgVqzgAjHd593gAgArff4k0eo/tiOgKjnf0lbe9/zjYghgwf0lfe//zjXgjgff4k/et/yiMgNi2gAjmeD+lgAgApYgKjId59ydggXrYgP
					jzeN+3cLgLnggLjyeN/SdHgWmBgCjueN/1fagLjGgAjseM/9gAgAhk]],
				["UpperArm.L"] = [[
					fPilfJzcMkgAwWfMihfKy3LBXRsRfHiDfKyMMVRfpvfHjBfQz6SKLRiWfKjvfTz+PpN0lEfPj/fSzNMVR8oVfUjvfN06PMPCj6fYjBfG1zR5NWg3fYiBfAzu
					LpTen6fViQfDxdJkWwrYfPiMfGzPMYR4oRfKjXfR0VS7LGhNfHj4fXzwQENNlHfHj7fXyoM4RKpffKjgfSz3PPONlifPiffH0tQrNTjDfViMfDztMLSfntfY
					ilfEyYKCVwp4fWilfF0rLyVEoOfQilfI0ULmcItYfPilfJzcMkgAwW]],
				["LowerArm.L"] = [[
					e3iNe2JaJagAhneride0IKQFXUrNekiLe6G+SXaStVeljTfKKmRKbLx7eoj+fHKfT4W4yKeukIe/KrVPSfwbe0j/e9K+S/VbxTe4jUe6LHPkY/wWe5iJeqHz
					Q2X/r+e1iQesILSVUOrYeuiVezHvRyYttZeojrfLLaRGaHygekkHfMKoUUXJyvekkDfIKEV0Tvw9eojvfFKFTqXLxqeuixe7JsP+bLvpe0iVeuIBRVYAs9e5
					ioesJMSyS/sne4ipesIWPTYCrAe1iWevIOK+ePjie3iNe2JaJagAhn]],
				["UpperArm.R"] = [[
					gxilfJzczcgAwWgtihfG1WzNsGnOgoiCfAzv0Wsjn5gojBfGyx1jrEpMgsjvfN06w0w+j6gxj/fS07r41Efcg2jvfTz+wXyMlEg5jBfQxr0cs1rVg5iCfKyL
					zrugpwg2iQfJ0Av0y3kIgxiMfGzPzouIoRgsjYfLy+02sRo2goj6fN1Pwrw2jOgoj9fN11sHz9ewgsjhfM0zxOwmkXgxiffHxf1zqerhg2iMfJyvzauvo2g5
					ilfOz0um0MjIg3ilfMzzzjscptgyilfJz50TjpuPgxilfJzczcgAwW]],
				["LowerArm.R"] = [[
					hJiNe2Ja2mgAhnhMineuH1yLkTphhHiJeqH0vKoBr/hHjGevJtsvtftehMj/e9K+tBqlxThSkTfNMuu9nhzQhYj+fHKfsIpIyKhcjFe/IirdrJuvhciLe6G+
					tqlttVhYihe+JEvqjrvchSiVezHvuOnTtZhMjfe1KEr+tjuqhIkKe8LatIrOxXhJkSfFM6vwokyXhMjwe7KktQqSw0hSiheyIKs8rdsghYiVe4Hgtvmltzhb
					i3fHJ9vCkQxHhZipe4H0v1mMsOhOiVezIo0pj8l6hJiNe2Ja2mgAhn]],
				Tail1 = [[
					gAiGg5gYgAgA//gBiEg5gVjrf6/xgDh0g5gCmnfT/SgDibg5gXjPgI/0gCi8g4ged3fu/6gAjIg4geavfK/if+i8g4gdb6fe/uf9ibg5gXgEgA//f9h0g5gC
					jffo/zf+h7g5gLjWfx/0gAh5g5gIgAgA//gCirg5gbcrfu/0gDjEg4gecjff/zgDjGg4gff8f///gCiyg4gckHgb/ugAiGg5gOlVf0/if+h5g5gIiKf1/6f9
					iGg5gXcwgD/0f+iGg5gXbAgE/mgAiGg5gYergB/9gAiGg5gYgAgA//]],
				Tail2 = [[
					gAiFhhflgAgA//gKiDhgfulJf//kgTh0hegprmfA9ygLiahge0nLgb/Jf8i7hhdfdXff/xfzjHhfdCWZeJ+Tf0i7hgdfXNes+of9iahhe0e7f+/8gGh0hggn
					m/fc/NgHh7hggOokfr+0gAh5hhgUisf8/4f5iqhgeKakfX/df6jDhgdNXgeq+rgDjFhhdHb+fm/mgMixhgd6kmgy/lgNiFhffyp1f4+cgEh5hhgVnAft/Nf1
					iFhgfnd5f//6fxiFhffmYYf6/Ef8iFhhfldWf+/4gAiFhhflgAgA//]],
				Tail3 = [[
					gAiGiKd9gAgA/7gXiEiHeRkvgN/lguhxh8givMfU8JgcieiFcksHhR9Yf2jCiIZufqfU/WfcjQh/Y/UQcu8uffjCiBZ7SddW8Nf7idiJccbWfq/cgXhyiFgX
					oCfj+9gch6iDfjtJgL9KgHh4iJfrnTgQ/JfsiviGbFbQe3/OfmjKiCZUUBdW8xf5jMiHZGW8ev93gXi2iGaliShH/bgliFiAemsTgc9fgVh4iGfysFgJ9nfw
					iGiJeAhggH/5ffiGiDeBXofe+zf2iGiJd+cJfw/sgAiGiKd9gAgA/7]],
				Tail4 = [[
					gAiMiycFgAgA/wgjiIitckiigL/thQhviSgNwkfz7Xg4inihabweis6uf1jRitV9kGfi+FfDjjiZU/U5bG7efCjTiYWlPKbh5HfvimivaCWbey96grhxiofx
					mYfb/Vg6h7ieeyv3hA7vgZh5iue9sUhN9efgi8irX4ekeo+4fMjcicVfTCbs68fkjeilVVSfdU60gcjEisXNdyhD+qhCiJicdLsNhB9agxh5ijfMv4hE7vf0
					iLixcPmig0/FfKiMimcMY6fI+8fsiMiwcIbZfc/agAiMiycFgAgA/w]],
				Tail5 = [[
					gAiVjZZngAgA/WgpiRjUaOfLfp/ch0hvilfBvkgH77hai2ixYHy+kx4Df/jpjNSLpUgh7Sevj/iuQwYbZd6RekjsikTLOSZD2SfZi1jOXdR1dG7Og7hxjNeV
					ijem/0hdh/iydYwLh97Zg1h9jKd6wNi37WfejQjOUVjpfC9ie0j3iuRYU+Zw5efJj3i2RmP/bJ3JgWjZjOTqYbgN8hheiRi4a8pkhT+EhUh8i3eFxiiU6lgD
					iVjVaIrWiV9Pe5iVjJZqb7fL/FfhiVjWZrbWfD+/gAiVjZZmgAgA/W]],
				["UpperLeg.L"] = [[
					fKhagM7MczgAwifJhXgP8GdAfPu+fIhEgW+sccdPnzfIhxgQ7Ld+ezwtfJiXgJ+ueXgSovfKikgF+WdZgepxfLiYgD+TcRgjpjfMhygF5AcKhlzhfMhDgM9R
					a5g4rzfLhMgM8vblgatVfKhKgQ9jb9fUrifJiDgL41eOf30GfIifgL+tfCgMo5fIihgK+rfDgMpBfJiLgL3zeggF1VfKhYgO8kcVfot6fLhKgM9CbegWspfM
					hagH6Ob4haxyfLhagI6bcIhExlfKhagL7DcqgOwwfKhagM7MczgAwi]],
				["LowerLeg.L"] = [[
					fGg6f7sxg6gA9UfEg6f7sZhwf99cfAg0f3pkjagj+VfDhRf/ulidff8XfIiEfq+shyfVo0fJiPfn+bgXfip3fJiDfl+ee8fupqfJhOf8s+fLgX9OfJgqfxks
					fXf9/ofHgxf0n1gFgM/BfFgyf1oXhRgO+2fGhggEwwhbfU7NfIiLfs+lilfMo9fIiOfs+jikfMpFfGhngGx7hPfL6cfFg8f3qDhJgJ+WfHgwfznKgGgK/LfJ
					g4f5rlfPgX9zfIg5f6r/fpgR9qfGg6f7smgpgD9ZfGg6f7sxg6gA9U]],
				["Foot.L"] = [[
					fIgggU9EgAgAtXfIgggU9DgufrtXfIgggU8+iXe6tVfIg0gU8RhNfXu6fIhwfMzSkMag4kfIh6fKy9gZfH5wfIhufHwXbumY6ZfIg0gU8Qelgwu6fIgggU9C
					esgntWfIgggU9DfYgTtXfIgggU9Egbf0tXfIhAgU75gTf1vqfIh4fO0FlUZt3gfIh6fO0LlKZ63gfIhFgU7ugIf8v9fIgngU8ygQf4t9fIgggU9DfYgStXfI
					gggU9CepgotWfIgggU9De+getXfIgggU9EfygGtXfIgggU9EgAgAtX]],
				["Toe.L"] = [[
					fIgTgI/8gAgAhmfIgTgI/8gifchmfIgTgI/2hzeHhmfIgmgK/yg5e9jVfIhgfQ7Ch1ZWvofIhqfP7LgCfCw2fIhffP5BeangyafIgmgK/xe9hPjVfIgTgI/6
					fAhDhmfIgTgI/8fhgghmfIgTgI/8gUfrhmfIgxgL/ugOfvkKfIhnfQ7YimYLuWfIhpfQ7eiiYbuUfIg2gL/rgFf5kffIgZgJ/6gMfziPfIgTgI/8figghmfI
					gTgI/6e+hFhmfIgTgI/7fOg1hmfIgTgI/8f2gLhmfIgTgI/8gAgAhm]],
				["UpperLeg.R"] = [[
					g2hagM7MjNgAwig2hXgL7WjwfhwLg0hDgM9RlHfIr1g0hygF5Aj2ebzhg1iYgD+Tjvfdpjg2ikgF+Winfipxg3iXgJ+uhpfuovg4hxgQ7LiChNwtg4hEgX+t
					jliynwg3hNgS9sjchnrRg2hKgQ9jkDgsrig1iEgF24i7ej2Ig0iggA9/kWfVqPg0ijgA98kVfTqXg1iLgE+fj1fio5g2hYgO8kjrgYt6g3hKgT99jkhwqfg4
					hagS8FiVhevFg4hagQ70iihFvjg3hagN7VjEgOwVg2hagM7MjNgAwi]],
				["LowerLeg.R"] = [[
					g6g6f7sxfGgA9Ug5g4f5rUfwf197g3gqfxkugpgD/og3hOf8s+g1fp9Og3iDfl+ehEgSpqg3iPfn+bfpgep3g4iEfq+seOgro0g9hRf/uldjgh8XhAg0f3pj
					clfd+Vg+g1f3qHdmfx+Qg7gyf1oXevfy+2g3hggDwngff77Vg2iKfj+Nh6gJqWg2iNfj+Kh5gJqeg3h4fl+rhIgUpAg7g8f3qDe3f3+Wg+g0f3podift+ag9
					g8f+t3dWgU8tg9g8f9tqdzgQ81g7g6f8s9e1gD9Og6g6f7sxfGgA9U]],
				["Foot.R"] = [[
					g4gggU9EgAgAtXg4gggU9DghfxtXg4gggU9ChUfZtWg4g0gU8QhbfQu6g4hufHwXkSZo6Zg4h6fKy9fng55wg4hwfMzSb0lg4kg4g0gU8Rezgpu6g4gggU8+
					dohGtVg4gggU9CengptWg4gggU9EflgMtXg4hAgU73hOfUvpg4h0fHvemTWV5gg4h3fHv0l+XD5og4hlfHuvmXVd5lg4gngU8yfwgIt9g4gggU9BeigrtWg4
					gggU9BelgqtWg4gggU9De9gftXg4gggU9EfygGtXg4gggU9EgAgAtX]],
				["Toe.R"] = [[
					g4gTgI/8gAgAhmg4gTgI/8gZfmhmg4gTgI/6hAe9hmg4gmgK/xhDexjVg4hffP5BhmYgyag4hqfP7Lf+g+w2g4hgfQ7CeLmqvog4gmgK/yfHhDjVg4gTgI/2
					eNh5hmg4gTgI/6e9hHhmg4gTgI/8fsgVhmg4gxgL/sg4e6kKg4hlfO32iQUrx6g4hnfO4OiNVex6g4hWfQ3Mh+T2yRg4gZgJ/6f0gNiPg4gTgI/6e5hLhmg4
					gTgI/6e7hJhmg4gTgI/7fNg2hmg4gTgI/8f2gLhmg4gTgI/8gAgAhm]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiHgeAHgAgAiYgAiHgvAUgAgAkZgAiHg6AigAgAlsgAiHg3AegAgFlWgAiHgyAXgAflkrgAiHgrAVf9d/j8gAiHgnAQf8eTjegAiHgmAMf/frjWgAiHgjAK
					gBgOjAgAiOggALh6f5ijgAiXgeAxmefhiVgAiXgeChsKfGiNgAiIgeFFxGeuiBgAh4geHJz+ehh3gAh1geHd0Xefh1gAh9geGfzJelh6gAh/geGUy6emh7gA
					h3geHR0Jegh2gAh0geHk0geeh1gAh0geHk0geeh1gAh0geHk0geeh1gAh0geHk0geeh1gAh0geHk0geeh1]],
				Spine1 = [[
					gAiKgLAxgAgAm7gAiMgdBSgAgAo5gAiOgoBqgAgAqIgAiNglBjgBgFpzgBiNgfBXf8flpKgCiMgZBOfqeAocgCiLgVBFfseVn+gAiLgUBAf8fsn3gAiLgRA6
					gDgOnhgAiRgNA3h3fnnFgBiagLBbmVemmxgCiZgLDIr6dXmZgDiJgLFpwwcTl2gDh5gLHqzkbrlZgDh2gLH+z8bllVgDh+gLHCywb2ligDiAgLG2yhb6lkgD
					h4gLHyzubplXgDh1gLIF0FbklTgDh1gLIF0FbklTgDh1gLIF0FbklTgDh1gLIF0FbklTgDh1gLIF0FbklT]],
				Spine2 = [[
					gAiafpB+gAgArBgAihf9CvgAgAs6gAilgKDSgAgAuGgAikgHDJgBgFtygBihgAC3f4fmtKgHiff5CnfZeEsegGief0CafeeZsCgBidfyCVf5fsr7f/icfvCM
					gFgNrngCihfrCGh2fgrLgHipfpCpmQeOq5gNikfpEYrvcnqhgRiQfpG7wfbLp/gSh8fpI+zOaTpigSh5fpJTzmaLpegSiDfpIVybajprgSiEfpIKyNaopugS
					h7fpJHzYaPpggSh4fpJazuaIpcgSh4fpJazuaIpcgSh4fpJazuaIpcgSh4fpJazuaIpcgSh4fpJazuaIpc]],
				Neck1 = [[
					gAinfZEzgAgAw0gAiwfvHXgAgA0ZgAi1f+JQgAgA2fgAizf6IvgDgE18gCixfyHwfxfp03gJiufrGze7eSzmgHisflGJfGekywgBirfkF9f1fuykf/iqfgFi
					gIgMx8gEiufbE8hke5w8gMi1faE+lTcUv2gWiufaGDqEZUuRgciXfaH0uTW9sUgfiBfaJSwzVtq5gfh9faJhxJVjqrgeiIfaI0wFWErVgeiKfaIsv3WKrdgf
					h/faJYw9Vpqzgfh8faJmxRVfqmgfh8faJmxRVfqmgfh8faJmxRVfqmgfh8faJmxRVfqmgfh8faJmxRVfqm]],
				Neck2 = [[
					gAjJfJHDgAgA0BgAjVfoKCgAgA3QgAjaf9MLgAgA5GgAjZf4LmgDgE4ogCjWftKffvfr3qgKjSfiJYeuec2hgJjQfaIoe7er1xgCjPfXIbfzfw1nf/jNfSH7
					gJgK1DgIjQfLHNhRei0HgajTfHHBkTbFy4gtjEfGHqoNXEw1g6ijfFI0ruT6uNg+iGfEJ0t3SRsPg+iBfEJ+uKSEr9g9iPfFJgtPSus2g8iSfFJatES3tBg+
					iEfEJ4t/SLsHg+iAfEKCuRR/r2g+iAfEKCuRR/r2g+iAfEKCuRR/r2g+iAfEKCuRR/r2g+iAfEKCuRR/r2]],
				Head = [[
					gAjrfBAEgAgAhvgAj3fqBPgAgAovgAj8gFCygAgAtBgAj7f+CUf7gDr6gCj5fwBhgdfspsgLj1fhBAiQeTnVgJjyfXAnh8edlogCjxfUAbgYftlHf/jvfNAQ
					fwgOj5gMjyfEAJh2fNh3gojye+AvmRdkfxhFjbe8ClrmcHdPhYiwe6FOv/bmafheiMe5HRyabtYpheiGe4HlyubwYYhciXe5GpxubpZMhciae5GdxiboZWhe
					iJe5HayjbvYiheiEe4Hsy2byYSheiEe4Hsy2byYSheiEe4Hsy2byYSheiEe4Hsy2byYSheiEe4Hsy2byYS]],
				Jaw = [[
					gAjseM/9gAgAhkgAkPe7//gAgAfigAkgff/8gAgAePf/kcfV/9gGf/elgEkTfD/+fegLfQgRkIex/3dbhKf1gPkAel/5dzhKgXgDj+eh/+flgPgmf+j4eZ/+
					gSf1g9gOj0eP/1eEgiiZgujseK+1ZbhblNhLjLeK8MT2hYo3hXiYeL4ePagLsMhXhweM1mNJe3uHhWhqeN1KM2epuYhYh8eM2fNxfTtkhYiAeM2vN9fatahX
					hteN1bNBexuOhWhoeN1BMwekudhWhoeN1BMwekudhWhoeN1BMwekudhWhoeN1BMwekudhWhoeN1BMwekud]],
				["UpperArm.L"] = [[
					fPilfJzcMkgAwWfPiwfe2QM8cOsQfPi2ft3nNkZ3pXfPi1fp3SNZabqMfRixfg2mM2b/rYfaiufU1uL3eVr8fZirfP1EL3fCtKfRiqfS05MfeZuRfOipfQ0Y
					MtetvSfTiyfLyVLwfRwofejHfKulKVeQyYfxjQfMqDJkbx0BgFjDfNmFJ4Yx1FgSixfOjzKiWk1bgUiufOjfKqWP1dgOi3fNkcKUXP1XgNi5fNkpKQXb1VgT
					iwfOjqKlWb1cgVitfOjYKtWI1dgVitfOjYKtWI1dgVitfOjYKtWI1dgVitfOjYKtWI1dgVitfOjYKtWI1d]],
				["LowerArm.L"] = [[
					e3iNe2JaJagAhne3igfDKKJ2bnl+e3iufPLFKkY3ore2iqfMKzKXZpoBe6ikfEKXJ7atmRfFide4KDJjbKjlfDiYe1JyJcccixe5iWe6JrJfdrjfe1iTe7Jj
					Jee0jHe4ice5IXKjf7h3e+i1e9F+NghHhefLjHfEDhRyiMiGfejGfMB6WJjBjSfsi7fRBQZFjVkVfui4fRBMZgjXkffoi/fPBaYMjQkAfnjAfPBeX8jPj6ft
					i6fRBOZQjWkZfvi3fRBLZpjYkjfvi3fRBLZpjYkjfvi3fRBLZpjYkjfvi3fRBLZpjYkjfvi3fRBLZpjYkj]],
				["UpperArm.R"] = [[
					gxilfJzczcgAwWgxiwfe2QzEjysQgxi2ft3nycmJpXgwi1fp3TyrleqGgzixfj2jyxklr5g7itfg1myNkPuag6irfa0/yejHvOgziqfU04zNiBuqgwipfO0Z
					zhhBvBg0infK0nyIejwXg4igfH2CurZ4w5g2iLfG3Kp/UVv1gvhrfF3JlrPjtlgnhSfE2ojGM1rlgmhOfE2hivMerRgqhafE20j2NmsOgqhcfE23kEN1sZgn
					hRfE2li8MrrdglhNfE2finMWrKglhNfE2finMWrKglhNfE2finMWrKglhNfE2finMWrKglhNfE2finMWrK]],
				["LowerArm.R"] = [[
					hJiNe2Ja2mgAhnhJigfDKK2KkZl+hJiufPLF1cnJorhJiqfLK01rmen6hMijfIKU1/ktm3hWibfKJ52HiAmchUiWfFJs2ThLlLhLiWe9Jq2eh4j8hIiTe4Jk
					2khgizhIiLe3LF4JgIhohAh9e5Pb7WfNgWguhme8Vt+PeqfHgXhMfAb4/meUd2gJg6fDfz/zeNc/gGg3fDgX/yeMc3gNg/fCep/yePdQgOhBfCeU/yePdUgI
					g4fDgC/yeNc8gGg2fEgj/xeMc1gGg2fEgj/xeMc1gGg2fEgj/xeMc1gGg2fEgj/xeMc1gGg2fEgj/xeMc1]],
				Tail1 = [[
					gAiGg5gYgAgA//gAiDhKiagAgA/5gAiBhUjtgAgA/xgAiBhRjXgIgB/0f/iChMisfUf9/3f9iEhGh8cxf4/xf9iEhChddSf8/1f/iFhBhWfff//9gAiFg+g/
					gXf//+gAiNg6gmf4eG/7gAiXg5gdfaZi/Uf/iWg5gVe2T19kf/iIg5gDeXO66/f/h4g5fyeGMD47f/h1g5fveELq4nf/h9g5f3eLM45kf/h/g5f5eNNH5wf/
					h3g5fxeFL44yf/h0g5fueDLh4ff/h0g5fueDLh4ff/h0g5fueDLh4ff/h0g5fueDLh4ff/h0g5fueDLh4f]],
				Tail2 = [[
					gAiFhhflgAgA//gAh9hyhngAgA/8gAh3h8i7gAgA/2gAh5h5ilgLgB/4f+h8h0h5fEf7/7f0h/hthKbkfu/qf2iBhqgrcRf1/xf+iBhpgjfSf+/+gBiDhmgN
					gfgA//f/iLhjf3fyeG/7f+iWhhfyfDZh/Uf8iWhhfmeJT19hf8iKhhfHdXO766f8h7hheqc7MG40f8h5hhelc3Lu4ff8iAhhezdDM65ef8iBhhe2dFNJ5pf8
					h6hheoc5L84rf8h4hhekc2Ll4Yf8h4hhekc2Ll4Yf8h4hhekc2Ll4Yf8h4hhekc2Ll4Yf8h4hhekc2Ll4Y]],
				Tail3 = [[
					gAiGiKd9gAgA/7gAh5iaf/gAgA//gAhwijhSgAgA/9gBhyihg8gOgC/+f7h3icgRe0f2/9fph8iUfiaZfX/ffth/iRfDbSfi/nf8iAiSe7fGf7/9gCiCiPek
					gngD/9f/iLiLeRfveF/4f8iXiKeRe3Zd/Pf4iZiJeFdwTu9Zf3iPiJdfczO16rf4iDiJc5cSMC4hf4iBiJczcOLq4Lf3iHiJdFcbM15Mf3iIiJdJceNE5Yf4
					iCiJc3cQL44Yf4iAiJcxcMLi4Ef4iAiJcxcMLi4Ef4iAiJcxcMLi4Ef4iAiJcxcMLi4Ef4iAiJcxcMLi4E]],
				Tail4 = [[
					gAiMiycFgAgA/wgAh5jCeHgAgA/7gAhtjMfagAgA//gBhwjJfEgRgE/+f4h2jEeZelfu/6fbh9i6duZRe1/KfhiCi4dOaUfG/Wf6iDi6dDe6f1/1gEiGi3ct
					gwgG/0f/iQi0cdfueD/uf6iciycjevZW/Ef1igixcXdeTj9If0iZiwbscZOp6Rf1iPivbAbzL43/f2iNiva5buLh3pf1iSiwbOb9Mr4tf1iTiwbScAM545f2
					iOiva9bxLu32f2iMiva2btLZ3hf2iMiva2btLZ3hf2iMiva2btLZ3hf2iMiva2btLZ3hf2iMiva2btLZ3h]],
				Tail5 = [[
					gAiVjZZmgAgA/WgAh+jrbngAgA/sgAhuj0c5gAgA/1gChyjycjgTgG/zf1h6jsb5eWfi/rfLiEjebUYPeB+nfTiJjdazZbeb+1f3iKjiakevft/fgGiOjfaO
					g3gM/cf+iZjbaCfveA/Xf4iljZaNewZL+rfzirjYaGdeTQ8ofyinjWZbcWOU5kf1ifjUYtbwLl3If2idjUYmbrLO2wf0iijVY8b6MW34f0ijjVZAb9Ml4Gf2
					iejUYqbuLb2+f2idjUYjbpLG2nf2idjUYjbpLG2nf2idjUYjbpLG2nf2idjUYjbpLG2nf2idjUYjbpLG2n]],
				["UpperLeg.L"] = [[
					fKhagM7MczgAwifKhdgY87c1fotRfKhfgf92c3fZrEfJhege9nc5fZrrfKhdgY9Jcnf8swfMhdgO8hbxhbtyfMhcgN8Ib7hPunfKhbgR8EcpgGu+fJhbgQ7x
					c6fsvlfFhogN7VbMe9v4e8iEgM6sXOcxu7e6idgM5LSLaYs6fAimgM22NvYuqufIikgM07LIX+pOfKijgM0oKyX4pAfGilgM1iL5YKprfFilgM1sMHYOpzfJ
					ijgM0zK/X8pIfKiigM0hKqX3o8fKiigM0hKqX3o8fKiigM0hKqX3o8fKiigM0hKqX3o8fKiigM0hKqX3o8]],
				["LowerLeg.L"] = [[
					fGg6f7sxg6gA9UfGhCgAwGg6gH7ofGhHgEyHg5gL6WfGhGgDxlg+gI6tfHhDf/wighgS7YfLhAf4vWfDg48CfKg+f4ukfWgv8efHg9f8uYgngL8kfFg8f9t0
					hHf881e9hJf7s+gLeQ9Methpf4sQeZaB85ejiLf2rXcTUq7bemief0qNamP/5KeviifzpXZqNO3TewiifypOZiM23AesiifzpnZ7OB34erihfzpsaAOQ4Dev
					iifypTZmNE3LexiifypMZfMu26exiifypMZfMu26exiifypMZfMu26exiifypMZfMu26exiifypMZfMu26]],
				["Foot.L"] = [[
					fIgggU9EgAgAtXfIgigS+agAgAp6fIgmgR/EgAgAnmfIglgR+6gCf7oOfIgjgQ+kf0gZpafKgigL+GfJh1qqfJghgN9zfShjrgfIghgS9wf3gTrvfHgggU9h
					gFfzsVe8gvgT9QeRfNszekhRgS82aCdesNeTh5gQ7jUpbkqxeRiSgO5ZP4aMpKeYibgN3mNDZhoEeZibgN3UMqZcn6eViZgO4KN3ZtoZeViYgO4UOGZwofeY
					ibgN3eM4ZfoAeaicgN3NMiZan3eaicgN3NMiZan3eaicgN3NMiZan3eaicgN3NMiZan3eaicgN3NMiZan3]],
				["Toe.L"] = [[
					fIgTgI/8gAgAhmfIgYgE/6gAgAd4fIgegB/rgAgAbgfHgcgC/wgAf7cIfIgZgC/4f+gbdXfMgXf+/5f4iBetfLgVgA/8f6htfmfIgVgF//f/gVf0fHgUgI//
					gAfygde6gigH/6eGf6g/efhGgG/UZhf4gneKhwgD9kT0gHfveHiOgB6/O3gmfDeOiZgA46MAhCeuePiZgA4lLnhHereLiWgA5jM1g5ezeKiVgA5vNEg3e1eO
					iZgA4xL1hEesePiagA4eLehIeqePiagA4eLehIeqePiagA4eLehIeqePiagA4eLehIeqePiagA4eLehIeq]],
				["UpperLeg.R"] = [[
					g2hagM7MjNgAwig2hdgY87jLgYtRg2hfgf92jJgnrEg2hegd9njMgfrqg3hdgb9Ji8gys2g4hbgc8hiIiAuMg4hbgY8JiThpu9g3hbgT8EjCgdvCg2hbgP7x
					jTf7vigxhbgN73hkfJvogghYgM8cdYdUuKgHhQgM8UXwbtrofuhEgM7DSha+pLfgg5gM5sPVa4nqfeg4gM5eO5a5ndfkg9gM6JQRa4oGflg9gM6RQia4oPff
					g4gM5mPJa4nlfdg3gM5ZOva5nYfdg3gM5ZOva5nYfdg3gM5ZOva5nYfdg3gM5ZOva5nYfdg3gM5ZOva5nY]],
				["LowerLeg.R"] = [[
					g6g6f7sxfGgA9Ug6hCgAwGfGf57og6hHgEyHfHf16Wg6hGgCxlfLf06tg7hDgCwietgD7Wg+g/gGvWdPgt77g+g9gEukdign8Xg7g9f/uYezgF8jg6g8f8tz
					fSf482gxg8f6sxeXeP9PgYg8f3rlcraB9Bf3g7fzqIa2Up7qfcg3fwohZhP55efNgxfunbY4NG3qfLgwfunRYzMt3YfRgzfunwZDN64PfTg0fvn2ZGOJ4ZfN
					gxfunXY2M83ifLgwfunNYxMl3RfLgwfunNYxMl3RfLgwfunNYxMl3RfLgwfunNYxMl3RfLgwfunNYxMl3R]],
				["Foot.R"] = [[
					g4gggU9EgAgAtXg4gigS+agAgAp6g4gmgR/EgAgAnmg4glgR+6gCf7oOg5gjgT+kf0gZpag6ghgZ+GfJh1qqg5gggZ9zfShjrgg5ghgU9wf3gTrvg4gggS9h
					gFfzsUgsgigS9VeRfOsngMgmgQ9FZ/dmroflgsgO78UfcBprfHgvgM54PkbHnte4gugK4FMqa0mde2gugK3zMQazmSe8gvgL4qNga4m1e9gvgL40Nva5m8e3
					gugK3+MfazmYe1gugK3tMHaymOe1gugK3tMHaymOe1gugK3tMHaymOe1gugK3tMHaymOe1gugK3tMHaymO]],
				["Toe.R"] = [[
					g4gTgI/8gAgAhmg4gYgE/6gAgAd4g4gegB/rgAgAbgg4gcgB/wgAf7cIg5gZgF/4f+gbdXg7gWgM/5f4iBetg7gVgM/8f6htfmg5gVgH//f/gVf0g4gUgG//
					gAfygdgqgVgH/7eGf7gzgIgbgE/VZhgAf+fegkgA9iT0glele+grf965O7hkdievgtf74wMHiZdCetgtf74bLvihc+ezgsf85bM7iIdKe0gsf85nNKiEdNeu
					gtf74oL9icdAetgtf74ULmikc9etgtf74ULmikc9etgtf74ULmikc9etgtf74ULmikc9etgtf74ULmikc9]],
			},
		},
	},
}
