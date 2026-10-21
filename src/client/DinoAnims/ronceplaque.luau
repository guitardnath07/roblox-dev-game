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
					gAiqg3ADgAgAhcgAiqg3ADgAgAhcgAirg3ADgAgAhcgAirg3ADgAgAhcgAirg3ADgAgAhcgAirg3ADgAgAhcgAirg3ADgAgAhcgAirg3ADgAgAhcgAiqg3AD
					gAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgA
					iqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAiqg3ADgAgAhcgAirg3ADgAgAhcgAisg3ADgAgAhdgAiug3AEgAgAhogAixg3AEgA
					gAh1gAiyg3AFgAgAh+gAiyg3AFgAgAh/gAiyg3AFgAgAh/gAixg3AFgAgAh/gAitg3AEgAgAhvgAing3ADgAgAhWgAikg3ACgAgAhKgAijg3ACgAgAhKgAij
					g3ACgAgAhKgAijg3ACgAgAhKgAijg3ACgAgAhKgAijg3ACgAgAhKgAilg3ADgAgAhPgAiog3ADgAgAhY]],
				Spine1 = [[
					gAitgbADgAgAhcgAitgbADgAgAhggAitgbADgAgAhkgAiugbAEgAgAhngAiugbAEgAgAhpgAiugbAEgAgAhpgAiugbAEgAgAhlgAitgbADgAgAhhgAitgbAD
					gAgAhdgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgA
					itgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhcgAitgbADgAgAhhgAiugbAEgAgAhrgAixgbAFgAgAiCgAi0gbAHgA
					gAiegAi2gbAIgAgAivgAi2gbAIgAgAiugAi1gbAIgAgAirgAi1gbAIgAgAimgAiwgbAFgAgAh8gAipgbACgAgAg9gAimgbABgAgAgegAilgbABgAgAgagAil
					gbABgAgAgYgAilgbABgAgAgYgAilgbABgAgAgYgAilgbABgAgAgbgAiogbACgAgAgugAirgbACgAgAhL]],
				Spine2 = [[
					gAivf//5gAgAijgAiwf//5gAgAiagAiwf//6gAgAiSgAixf//6gAgAiMgAixf//6gAgAiIgAixf//6gAgAiJgAiwf//6gAgAiPgAiwf//5gAgAiZgAivf//5
					gAgAiggAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgA
					ivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAijgAivf//5gAgAihgAiwf//5gAgAiXgAixf//7gAgAiGgAi0f//9gAgAhjgAi4f//+gA
					gAg4gAi6f///gAgAgfgAi6f///gAgAghgAi6f///gAgAgngAi5f//+gAgAgxgAi0f//8gAgAh0gAirf//zgAgAjZgAimf//tgAgAkMgAimf//sgAgAkTgAim
					f//sgAgAkXgAimf//sgAgAkYgAimf//sgAgAkXgAimf//tgAgAkSgAipf//xgAgAjxgAitf//2gAgAi/]],
				Spine3 = [[
					gAirfj/5gAgAijgAirfj/6gAgAiWgAisfj/6gAgAiKgAitfj/7gAgAiAgAitfj/7gAgAh6gAitfj/7gAgAh7gAisfj/7gAgAiGgAisfj/6gAgAiTgAirfj/5
					gAgAiegAirfj/5gAgAiigAirfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAijgA
					irfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAijgAirfj/5gAgAiggAisfj/6gAgAiRgAitfj/7gAgAh5gAixfj/+gAgAhJgAi3fj//gA
					gAgQgAi6fj//gAgAfvgAi6fj//gAgAfxgAi5fj//gAgAf7gAi4fj//gAgAgJgAiwfj/8gAgAhngAilfj/xgAgAjxgAiffk/ngAgAk4gAiffk/mgAgAlBgAie
					fk/lgAgAlHgAiefk/kgAgAlJgAiefk/lgAgAlHgAiffk/mgAgAlAgAiifk/tgAgAkSgAiofj/1gAgAjM]],
				Neck1 = [[
					gAimfHAVgAgAkcgAinfHAXgAgAkpgAiofHAYgAgAk1gAipfHAagAgAk+gAiqfHAbgAgAlEgAiqfHAcgDfylOgAipfHAggKfMlhgAinfHAngUeal6gAinfHAv
					ggdsmVgAimfHA2gndPmogAimfHA3gpdKmrgAimfHA3gpdKmrgAimfHA3gpdKmrgAimfHA3gpdKmrgAimfHA3gpdKmrgAimfHA3gpdKmrgAimfHA3gpdKmrgA
					imfHA3gpdKmrgAimfHA3gpdKmrgAimfHA3gpdKmrgAimfHA3gpdKmrgAimfHAtgedymOgAiofHAfgKfHlZgAiqfHAbgAf+lHgAivfHAjgAgAl1gAi2fHAugA
					gAmsgAi6fHA2gAgAnNgAi6fHA1gAgAnLgAi5fHAzgAgAnBgAi4fHAwgAgAmzgAiufHAdgAgAlSgAiefIAKgAgAjAgAiXfJAEgAgAh1gAiWfJAEgAgAhrgAiV
					fJADgAgAhlgAiVfJADgAgAhjgAiVfJADgAgAhlgAiWfJAEgAgAhtgAibfIAHgAgAihgAiifIAPgAgAjv]],
				Neck2 = [[
					gAi0eWBVgAgApFgAi2eWBZgAgApRgAi4eXBcgAgApdgAi5eXBfgAgApmgAi6eXBhgAgApsgBi6eXBogBfjp/gDi6eXB6gGeXqtgFi6eYCZgOcyrpgIi6eZC9
					gYbUsigJi7eZDYggaatHgJi7eaDdghaQtNgJi7eaDdghaQtNgJi7eaDdghaQtNgJi7eaDdghaQtNgJi7eaDdghaQtNgJi7eaDdghaQtNgJi7eaDdghaQtNgJ
					i7eaDdghaQtNgJi7eaDdghaQtNgJi7eaDdghaQtNgJi7eaDdghaQtNgHi6eZC2gWbhsXgDi5eXB5gGeNqpgAi6eXBigAf8pwgAjCeXBxgAgAqbgAjLeYCEgA
					gArQgAjQeZCQgAgArvgAjQeZCPgAgArtgAjPeZCLgAgArkgAjNeZCGgAgArWgAi+eXBkgAgAp0gAioeWA6gAgAnegAiceWApgAgAmQgAibeWAngAgAmHgAia
					eWAmgAgAmBgAiaeWAlgAgAl/gAiaeWAmgAgAmBgAibeWAngAgAmIgAijeWAzgAgAnBgAiueWBIgAgAoW]],
				Neck3 = [[
					gAjKd0BlgAgAp5gAjNd0BpgAgAqFgAjPd1BtgAgAqRgAjQd1BwgAgAqagAjRd1BygAgAqfgCjSd2B9gCfVq9gHjUd4CfgHdisFgNjVd7DagSbMthgTjXd+Ei
					ggZCu0gWjYeBFWgqXuvngXjZeBFhgsXfvwgXjZeBFhgsXfvwgXjZeBFhgsXfvwgXjZeBFhgsXfvwgXjZeBFhgsXfvwgXjZeBFhgsXfvwgXjZeBFhgsXfvwgX
					jZeBFhgsXfvwgXjZeBFhgsXfvwgXjZeBFhgsXfvwgXjZeBFhgsXfvwgSjWd+EWgdZUumgHjSd4CggHdUsEgAjSd1B0gAf7qkgAjbd3CDgAgArOgAjmd6CYgA
					gAsCgAjsd7CkgAgAshgAjsd7CjgAgAsfgAjqd7CggAgAsWgAjod6CagAgAsIgAjWd2BzgAgAqigAi6dyBDgAgAoFgAisdwAwgAgAm0gAiqdwAugAgAmrgAip
					dwAtgAgAmlgAipdwAsgAgAmjgAipdwAtgAgAmlgAirdwAugAgAmsgAi0dxA8gAgAnqgAjCdzBWgAgApG]],
				Head = [[
					gAjxc//4gAgAikgAj0dA/5gBf4iXgAj3dA/6gDfwiLgAj5dB/7gEfoiCgAj6dB/7gFfhh8gEj9dD/9gBgXhUgQkCdJ/3fri3fzgfkHdT/TfBmLd8gskLdf+W
					eJpNcSg0kNdn9jderCbRg1kOdp9ZdUrVbFg1kOdp9YdXrWbGg1kOdp9YddrbbKg1kOdp9WdlribOg1kOdp9VdurqbUg1kOdp9Td1rybYg1kOdp9Rd4r6bcg1
					kOdp9Od2sAbdg1kOdp9LdvsFbdg1kOdp9JdjsIbag1kOdp9GdVsLbXgrkKdd+Qd/ppcqgSkAdJ/ufSkDf0gBj7dC/8f7gfhxgAkGdF/+f6gfgygAkUdK/+f3
					glfegAkcdO/9f0gqergAkbdN/9fzguesgAkadM/9fzgxe1gAkWdL/9fygzfFgAj/dC/8f2g1hYgAjbc4/nf8g1k2gAjIc0/Tf/gzmjgAjFc0/Rf/gwmsgAjE
					c0/Qf/grmygAjDc0/Qf/gmm0gAjEc0/Qf/gfmygAjGc0/Sf/gYmqgAjTc3/hf/gRldgAjmc7/yf/gIjl]],
				Jaw = [[
					gAizdI/2gAgAi9gAi2dI/3gBf4iwgAi4dI/4gDfwikgAi6dJ/5gEfoibgAi7dJ/5gGfhiVgEi+dI/8gAgXh1gPjDdI/2fni2gqgdjJdK/XexmIfPgqjOdO+g
					dppGd9gyjSdS9ycyq2dJgzjSdT9pcmrIc/gzjSdT9pcorKdAgzjSdT9ocurPdEg0jSdU9mc2rWdIg0jSdU9kc+rfdNg1jSdV9idFrndSg1jSdV9gdHrvdVg1
					jSdV9ddFr1dXg0jSdV9ac9r6dWg0jSdU9Ycxr8dTgzjSdU9Vcjr+dQgnjNdO+YdfpheRgPjBdI/ufLkCgtgAi8dI/5f6gfiVgAjHdI/6f4gfiIf/jVdI/7f0
					gkh5f/jddI/7fwgohyf/jddI/7fvgsh3f/jbdH/6fugwiBf/jXdH/5ftgyiPf/jAdH/xfyg0jsf/iedK/cf6g1l1f/iNdN/Of+gzm7f/iMdN/Mf+gwnFf/iK
					dO/Kf/grnLf/iKdO/Kf/gmnNgAiKdO/Lf/gfnLgAiMdN/Nf/gYnDgAiXdL/df/gRl1gAipdJ/vf/gIj+]],
				["UpperLegF.L"] = [[
					eXhufJx7WXfk4reXhvfIyFWefr4neXhwfIyPWkfx4heXhxfHyZWpf34ceXhyfHyfWsf74YeXhyfHyeWsf64ZeXhxfIyTWmf04feXhvfIyGWffs4meXhvfJx+
					WZfm4qeXhufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reX
					hufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reXhufJx7WXfk4reXhufJx9WYfl4qeXhwfIyIWgft4leXhyfHymWtf+4UeXh4fE06XLhE2heXh+fB1iX1
					hj2JeXiDe/1aYJhn2YeXiCe/1bYIhn2XeXiCfA1dYDhm2SeXiAfB1hX6hl2MeXh2fG0ZWmgY2xeXhnfOxYU5d84XeXhgfTxCT7dB4DeXhffUxCT0c93/eXhe
					fUxDTwc738eXhefUxDTuc637eXhefUxDTwc738eXhffTxCT2c/4AeXhjfQxIUqdt4aeXhqfMxgVye64u]],
				["LowerLegF.L"] = [[
					eAhFfS8bb+gwuFeBhGfR8JcCgjureBhHfQ72cGgWvPeBhIfP7ncIgLvseChIfP7ccJgEv/eChIfP7ecJgFv8eBhHfQ7wcHgRvbeBhGfR8GcDgguxeAhGfS8V
					cAgruSeAhFfS8bb+gvuGeAhFfS8bb+gwuFeAhFfS8bb+gwuFeAhFfS8bb+gwuFeAhFfS8bb+gwuFeAhFfS8bb+gwuFeAhFfS8bb+gwuFeAhFfS8bb+gwuFeA
					hFfS8bb+gwuFeAhFfS8bb+gwuFeAhFfS8bb+gwuFeAhFfS8bb+gwuFeAhGfS8Xb/gtuNeBhHfR8DcEgeu3eChIfO7VcJf/wLeHhLfE4ObyeF0XeJhRe/2ub7
					dg2AeKhVe+2icLdk2PeKhVe+2jcKdk2OeKhUe/2ncGdk2KeJhTe/2sb/di2DeEhKfG4+bTd8zUd6hBfW8+Zcf3r3d3g9fa9jX+gHpOd3g8fa9nX2gMo6d3g8
					fb9qXxgPoud3g8fb9rXwgQopd3g8fb9qXxgPoud3g8fa9nX4gNo8d6g/fZ9jZOghqLd+hDfV9DbIg0se]],
				["FootF.L"] = [[
					d+gre9/mgGf/k+d+gre9/mgHf/k+d+gre9/mgGf/k+d+gre9/mgFf/k+d+gre9/mgEf/k+d+gre9/mgFf/k+d+gre9/mgGf/k+d+gre9/mgHf/k+d+gre9/m
					gGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+
					gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgGf/k+d+gre9/mgHf/k+d+gre9/mgDgAk+d+gre9/lfFgJk+d/gwe+/Qe8
					fpmweAg0e++/fMfTn3eAg0e+/AfLfUn1eAgze+/DfIfYnmeAgye+/JfBfgnOd6gre9/kepgOk+d1gre9/fdbgak9dzgre9/Wb+gpk7dzgre9/Vb2gqk7dzgr
					e9/Ubygrk7dzgre9/Ubwgrk7dzgre9/Ubygrk7dzgre9/Vb5gpk7d2gre9/fdVgbk9d7gre9/mfUgHk+]],
				["UpperLegF.R"] = [[
					hphufJx7ppgc4rhphvfIyFpigV4nhphwfIyPpcgP4hhphxfHyZpXgJ4chphyfHyfpUgF4YhphyfHyepUgG4ZhphxfIyTpagM4fhphvfIyGphgU4mhphvfJx+
					pnga4qhphufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhp
					hufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhphufJx7ppgc4rhphufJx9pogb4qhphwfIyIpggT4lhphyfHympTgC4Uhph4fE06o1e82hhph+fB1ioL
					ed2JhpiDe/1an3eZ2YhpiCe/1bn4eZ2XhpiCfA1dn9ea2ShpiAfB1hoGeb2Mhph2fG0Zpafo2xhphnfOxYrHiE4XhphgfTxCsFi/4DhphffUxCsMjD3/hphe
					fUxDsQjF38hphefUxDsSjG37hphefUxDsQjF38hphffTxCsKjB4AhphjfQxIrWiT4ahphqfMxgqOhG4u]],
				["LowerLegF.R"] = [[
					iAhFfS8bkCfQuFh/hGfR8Jj+fdurh/hHfQ72j6fqvPh/hIfP7nj4f1vsh+hIfP7cj3f8v/h+hIfP7ej3f7v8h/hHfQ7wj5fvvbh/hGfR8Gj9fguxiAhGfS8V
					kAfVuSiAhFfS8bkCfRuGiAhFfS8bkCfQuFiAhFfS8bkCfQuFiAhFfS8bkCfQuFiAhFfS8bkCfQuFiAhFfS8bkCfQuFiAhFfS8bkCfQuFiAhFfS8bkCfQuFiA
					hFfS8bkCfQuFiAhFfS8bkCfQuFiAhFfS8bkCfQuFiAhFfS8bkCfQuFiAhGfS8XkBfTuNh/hHfR8Dj8fiu3h+hIfO7Vj3gBwLh5hLfE4OkOh70Xh3hRe/2ukF
					ig2Ah2hVe+2ij1ic2Ph2hVe+2jj2ic2Oh2hUe/2nj6ic2Kh3hTe/2skBie2Dh8hKfG4+ktiEzUiGhBfW8+mkgJr3iJg9fa9joCf5pOiJg8fa9noKf0o6iJg8
					fb9qoPfxouiJg8fb9roQfwopiJg8fb9qoPfxouiJg8fa9noIfzo8iGg/fZ9jmyffqLiChDfV9Dk4fMse]],
				["FootF.R"] = [[
					iCgre9/mf6gBk+iCgre9/mf5gBk+iCgre9/mf6gBk+iCgre9/mf7gBk+iCgre9/mf8gBk+iCgre9/mf7gBk+iCgre9/mf6gBk+iCgre9/mf5gBk+iCgre9/m
					f6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iC
					gre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf6gBk+iCgre9/mf5gBk+iCgre9/mf9gAk+iCgre9/lg7f3k+iBgwe+/QhE
					gXmwiAg0e++/g0gtn3iAg0e+/Ag1gsn1iAgze+/Dg4gonmiAgye+/Jg/ggnOiGgre9/khXfyk+iLgre9/filfmk9iNgre9/WkCfXk7iNgre9/VkKfWk7iNgr
					e9/UkOfVk7iNgre9/UkQfVk7iNgre9/UkOfVk7iNgre9/VkHfXk7iKgre9/firflk9iFgre9/mgsf5k+]],
				Tail1 = [[
					gAilhphtgAgA/8gAilhphlgLf//8gAimhphegWf+/9gAimhphYggf9/9gAimhphUgqf9/9gAimhphVgyf8/9gAimhphbg6f7/8gAilhphkg/f7/8gAilhphq
					hEf6/7gAilhphthGf6/7gAilhphthHf6/7gAilhphthGf6/7gAilhphthEf6/7gAilhphtg/f6/7gAilhphtg6f7/7gAilhphtgyf8/7gAilhphtgqf8/8gA
					ilhphtggf9/8gAilhphtgWf+/8gAilhphtgLf//8gAilhphtgAgA/8gAilhphsf1gB/8gAilhphjfqgC/9gAimhphafggC/9gAiohohgfWgD/8gAiqhohtfO
					gD/7gAirhoh3fGgD/7gAirhoh7fAgE/6gAirhoiBe8gE/6gAiqhoiIe6gF/5gAinhoh2fPgE/7gAiihphUfwgB/9gAifhphIgAgA/+gAifhphOgAgA/+gAif
					hphRgAgA/9gAifhphTgAgA/9gAifhphRgAgA/9gAifhphOgAgA/+gAihhphYf5gB/9gAijhphqf3gB/8]],
				Tail2 = [[
					gAigiWihfegE/4gAihiWiQfzgC/6gBihiWiBgJf//7gBiiiWh2gef9/7gCiiiWhugzf7/7gCiiiWhvhGf5/7gDiiiWh8hYf3/5gDihiWiNhnf1/3gDigiWib
					h0fz/2gDigiVigh+fy/1gDigiVigiFfx/0gDigiVigiJfw/0gDigiVigiJfw/0gDigiVigiGfx/0gDigiWihiAfx/1gCigiWihh2fz/1gCigiWihhqf0/2gB
					igiWihhbf2/3gBigiWihhKf4/3gAigiWihg3f6/4gAigiWihgif8/4gAigiWidgNf//5f/ihiWiLf3gB/6f/iiiWh4figD/7f+ikiWh6fNgE/7f+iliViFe6
					gG/5f9imiViReogH/4f9imiViZeZgJ/3f9iliVileMgK/1f9ikiViyeDgM/zf+iiiVieekgJ/3f/ieiWh0figD/7gAiciWhngAgA/8gAibiWhzgAgA/8gAib
					iWh7gAgA/7gAibiWh9gAgA/7gAibiWh7gAgA/7gAibiWh0f/gA/8gAidiWiDfpgD/7gAifiWiefWgF/4]],
				Tail3 = [[
					f/iZjCiNeigK/4gAiajCh1e+gH/7gBicjDhefbgF/8gDidjDhNf6gC/+gEidjDhBgZf//+gFidjDhDg3f9/9gGicjChXhTf5/7gHibjChxhuf2/5gIiZjCiE
					iGfy/2gJiZjCiMiafw/0gJiZjCiNirfu/zgJiZjCiNi4ft/ygJiZjCiNjAfs/xgJiZjCiNjDfs/xgIiZjCiNjCfs/xgHiZjCiNi8fs/xgGiZjCiNixfu/ygF
					iZjCiNiifv/0gEiZjCiNiOfx/1gDiZjCiNh4fz/3gBiZjCiNhef2/4gAiZjCiIhCf5/5f/ibjChtglf8/8f9idjDhPgGf+/9f8iejChOfngA/9f7ifjChXfJ
					gD/8f6igjChkesgF/7f5ifjChweSgH/5f4iejCiCd6gK/2f3icjBiWdngM/0f6ibjCh/eJgK/4f+iZjDhNfXgE/9gAiXjDhAgAgA/+gAiWjDhSgAgA/9gAiW
					jDhdgAgA/9gAiVjDhhgAgA/9gAiWjDhdgAgA/9gAiWjDhTf+gA/9f/iXjDhmfUgF/8f+iYjCiKejgK/4]],
				Tail4 = [[
					f6iTjvhRdbgM/3f9iVjvgwd4gL/6gAiYjwgSeZgJ/8gCiZjwf6e9gI/+gFibjwfrfigG//gIiajwfugIgD//gKiYjvgIgugA/+gMiWjvgrhSf8/9gOiTjuhF
					h1f4/6gPiTjuhQiUf1/4gQiTjuhRiwfz/2gRiTjuhRjIfx/0gRiTjuhRjafw/ygRiTjuhRjofv/wgRiTjuhQjvfu/vgQiTjuhQjxfu/vgOiTjuhQjtfu/wgM
					iTjuhRjjfv/xgKiTjvhRjUfw/ygIiTjvhRi/fy/0gGiTjvhRilf0/3gDiTjvhKiIf2/5gAiWjvglhnf3/8f+iZjwf9hDf4/+f7ibjwf4gef6//f4ibjvgAf4
					f8//f2ibjvgOfSf+/+f0iajugeeugB/9fyiYjug2eLgE/7fxiWjuhSdtgH/4f1iVjvg4eGgG/7f8iWjwf9fUgD//gAiVjwfvgAgA//gAiTjwgHgAgA//gAiS
					jwgWgAgA//gAiRjwgbgAgA//gAiSjwgWgAgA//gAiTjwgJf+gA//f9iSjwghe/gF/+f6iSjvhOdrgL/4]],
				Tail5 = [[
					fziPkbfdcagE/yf3iTkcezczgE/zf7iXkdeOdSgF/0gAiakddwd1gH/1gEickdddecgI/2gIibkddhfEgI/4gMiYkdeBfvgG/7gQiUkcesgagD/9gTiQkbfO
					hEgA/9gWiPkbfbhsf+/8gYiPkafciSf9/5gaiPkafci0f9/3gbiPkafcjSf8/0gbiPkafdjrf8/xgbiPkafdj9f8/vgaiPkafdkKf7/tgZiPkafdkQf7/tgW
					iPkafdkPf7/tgUiPkbfdkIf7/ugQiPkbfdj6f8/vgNiPkbfdjmf8/ygJiQkcfTjNf8/0gFiUkcemiuf7/2gAiZkddziLf6/1f8ibkddqhlf5/3f4ibkcdxg8
					f5/5f0ibkceAgRf5/7fwiZkceUfmf5/8ftiWkbexe8f7/8fqiSkafUeVf9/8fviTkbe4ebf+/7f6iWkdd1fYf//6gAiVkddngAgA/5gAiSkdeEgAgA/7gAiR
					kdeXgAgA/8gAiQkdeegAgA/9gAiRkdeXgAgA/8gAiSkdeGf9gA/7f6iRkdejeugC/7fziOkcfac9gE/1]],
				["UpperLegB.L"] = [[
					eXhyhA2WUvgHz7eXhzhA2SU2gN0DeXhzhA2OU9gR0MeXhzhA2KVDgV0TeXh0hA2IVHgY0XeXh0hA2JVGgX0WeXhzhA2MU/gT0PeXhzhA2RU3gN0FeXhyhA2V
					UxgJz+eXhyhA2WUvgIz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eX
					hyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2WUvgHz7eXhyhA2VUwgJz9eXhzhA2QU4gO0GeXh0hA2GVLga0ceXh2hA1gWEg91eeXh5g/0cXg
					h33BeXh6g+0bXnh53EeXh6g+0aXnh53FeXh6g+0aXnh43FeXh5g+0ZXlh33FeXh1g/1rVzgv1MeXhvhB2wT8fny/eXhshB3DTRfNyJeXhshB3ETNfKyFeXhs
					hB3FTLfJyCeXhrhB3FTKfIyBeXhshB3FTLfJyCeXhshB3ETOfLyFeXhuhB25TnfayleXhxhA2lUTf2za]],
				["LowerLegB.L"] = [[
					eChIg2xYdWgK6ueChJg2xldOgH6leDhJg3xydHgD6ceDhJg3x8dAgB6UeDhJg3yDc8f/6PeDhJg3yBc9f/6QeDhJg3x2dEgC6YeChJg2xndNgG6jeChIg2xc
					dTgJ6reChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueC
					hIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xYdWgK6ueChIg2xbdUgJ6seChJg2xpdLgF6ieDhJg3yHc5f96LeFhKg7zbcBfd5GeIhLhB1Yaj
					el3HeIhMhB1Waqen3LeIhMhB1Waqen3LeIhMhB1Wapem3LeIhMhB1Vanel3LeEhJg5y4cZfm5keBhHgywCeGge7neAhGgwu+eqgs8Od/hGgwu3etgs8Sd/hG
					gwuyevgt8Vd/hFgwuxewgt8Wd/hGgwuyevgt8Vd/hGgwu4etgs8SeAhGgxvjeXgl76eBhIg0wqdwgV7O]],
				["FootB.L"] = [[
					d+grhD/mf8gBk+d+grhD/mf1gCk+d+grhD/mfugDk+d+grhD/mfogEk+d+grhD/mfkgEk+d+grhD/mflgEk+d+grhD/mfsgDk+d+grhD/mf0gCk+d+grhD/m
					f6gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+
					grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf8gBk+d+grhD/mf7gBk+d+grhD/mfzgCk+d+grhD/mfhgFk+d+grhD/kemgOk+d+gshC/Zc+
					gZlWd/gthC/UdEgQl2d/gthC/UdEgQl1d+gthC/VdDgSlvd+gshC/WdBgUlld+grhD/le8gLk+d+grhD/mgof6k+d+grhD/lhIf1k+d+grhD/lhLf0k+d+gr
					hD/lhNf0k+d+grhD/lhOf0k+d+grhD/lhNf0k+d+grhD/lhLf0k+d+grhD/lg4f3k+d+grhD/mgVf9k+]],
				["UpperLegB.R"] = [[
					hphyhA2WrRf5z7hphzhA2SrKfz0DhphzhA2OrDfv0MhphzhA2Kq9fr0Thph0hA2Iq5fo0Xhph0hA2Jq6fp0WhphzhA2MrBft0PhphzhA2RrJfz0FhphyhA2V
					rPf3z+hphyhA2WrRf4z7hphyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2WrRf5z7hp
					hyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2WrRf5z7hphyhA2VrQf3z9hphzhA2QrIfy0Ghph0hA2Gq1fm0chph2hA1gp8fD1ehph5g/0cog
					eJ3Bhph6g+0boZeH3Ehph6g+0aoZeH3Fhph6g+0aoZeI3Fhph5g+0ZobeJ3Fhph1g/1rqNfR1MhphvhB2wsEgZy/hphshB3DsvgzyJhphshB3Eszg2yFhphs
					hB3Fs1g3yChphrhB3Fs2g4yBhphshB3Fs1g3yChphshB3Esyg1yFhphuhB25sZgmylhphxhA2lrtgKza]],
				["LowerLegB.R"] = [[
					h+hIg2xYiqf26uh+hJg2xliyf56lh9hJg3xyi5f96ch9hJg3x8jAf/6Uh9hJg3yDjEgB6Ph9hJg3yBjDgB6Qh9hJg3x2i8f+6Yh+hJg2xnizf66jh+hIg2xc
					itf36rh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+
					hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xYiqf26uh+hIg2xbisf36sh+hJg2xpi1f76ih9hJg3yHjHgD6Lh7hKg7zbj/gj5Gh4hLhB1Yld
					hb3Hh4hMhB1WlWhZ3Lh4hMhB1WlWhZ3Lh4hMhB1WlXha3Lh4hMhB1VlZhb3Lh8hJg5y4jnga5kh/hHgywCh6fi7niAhGgwu+hWfU8OiBhGgwu3hTfU8SiBhG
					gwuyhRfT8ViBhFgwuxhQfT8WiBhGgwuyhRfT8ViBhGgwu4hTfU8SiAhGgxvjhpfb76h/hIg0wqiQfr7O]],
				["FootB.R"] = [[
					iCgrhD/mgEf/k+iCgrhD/mgLf+k+iCgrhD/mgSf9k+iCgrhD/mgYf8k+iCgrhD/mgcf8k+iCgrhD/mgbf8k+iCgrhD/mgUf9k+iCgrhD/mgMf+k+iCgrhD/m
					gGf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iC
					grhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgEf/k+iCgrhD/mgFf/k+iCgrhD/mgNf+k+iCgrhD/mgff7k+iCgrhD/khafyk+iCgshC/ZjC
					fnlWiBgthC/Ui8fwl2iBgthC/Ui8fwl1iCgthC/Vi9fulviCgshC/Wi/fslliCgrhD/lhEf1k+iCgrhD/mfYgGk+iCgrhD/le4gLk+iCgrhD/le1gMk+iCgr
					hD/lezgMk+iCgrhD/leygMk+iCgrhD/lezgMk+iCgrhD/le1gMk+iCgrhD/lfIgJk+iCgrhD/mfrgDk+]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAihg3AGfLgDh/gAiig3AGfPgch/gAilg3AGfagwh+gAiog3AGfpg/h+gAiqg3AGf7hHh/gAiqg3AGgOhGh/gAiog3AGgfg8iAgAilg3AGgsgriAgAiig3AG
					g0gViAgAihg3AGg1f9h/gAiig3AGgxfkh/gAilg3AGgmfQh+gAiog3AGgXfBh+gAiqg3AGgFe5h/gAiqg3AGfye6h/gAiog3AGfhfEiAgAilg3AGfUfViAgA
					iig3AGfMfriA]],
				Spine1 = [[
					gAikgbAFflgCh/f/imgbAFfogRh/f/iogbAFftgeh+f+isgbAFf1gnh+f+iugbAFf+gsh/f+iugbAFgHgsh/f+isgbAFgQgmiAf/ipgbAFgWgbiAgAimgbAF
					gagOiAgAikgbAFgbf+h/gBimgbAFgYfvh/gBiogbAFgTfih+gCisgbAFgLfZh+gCiugbAFgCfUh/gCiugbAFf5fUh/gCisgbAFfwfaiAgBipgbAFfqfliAgA
					imgbAFfmfyiA]],
				Spine2 = [[
					gAiof//7gAgAh/f/ipf//7gAf6iAf+isf//7gBf1iAf9ivf//7gBfxiAf9ixf//7gBfuh/f9ixf//7gBfuh/f9ivf//7gBfxh+f+isf//7gBf1h+f/ipf//7
					gAf6h/gAiof//7gAgAh/gBipf//7gAgGiAgCisf//7f/gLiAgDivf//7f/gPiAgDixf//7f/gSh/gDixf//7f/gSh/gDivf//7f/gPh+gCisf//7f/gLh+gB
					ipf//7gAgGh/]],
				Spine3 = [[
					gAikfj/7flf+h/f+ilfj/7fngCiAf9iofj/7frgEiAf9isfj/7fygHiAf8iufj/7f7gIh/f8iufj/7gEgJh/f9isfj/7gNgJh/f+ipfj/7gUgHh+f/imfj/7
					gZgFh/gAikfj/7gbgCh/gCilfj/7gZf+iAgDiofj/7gVf8iAgDisfj/7gOf5iAgEiufj/7gFf4h/gEiufj/7f8f3h/gDisfj/7fzf3h/gCipfj/7fsf5h+gB
					imfj/7fnf7h/]],
				Neck1 = [[
					gAihfHAVgbf8kef+iifHAUgXfwkTf+ilfHAUgRfmkVf9iofHAWgJffkif9iqfHAZgAfck1f9iqfHAbf3felEf9iofHAcfvfjlJf+ilfHAbfpfslBf/iifHAY
					flf4kwgAihfHAVflgEkegCiifHAUfpgQkTgCilfHAUfvgakVgDiofHAWf3ghkigDiqfHAZgAgkk1gDiqfHAbgJgilEgDiofHAcgRgdlJgCilfHAbgXgUlBgB
					iifHAYgbgIkw]],
				Neck2 = [[
					gAiveWBNgaf5omf/iweWBHgTfloSf/iyeWBIgJfUoVf/i2eWBQf/fIovf+i6eXBaf0fDpSf+i6eXBjfsfGpvf+i5eXBmflfQp4f/i1eXBhfiffppf/ixeXBX
					fifzpJgAiveWBNfmgHomgBiweWBHftgboSgBiyeWBIf3gsoVgBi2eWBQgBg4ovgCi6eXBagMg9pSgCi6eXBjgUg6pvgCi5eXBmgbgwp4gBi1eXBhgeghppgB
					ixeXBXgegNpJ]],
				Neck3 = [[
					gBjEdzBSgaf5o6gBjEdzBKgQfcocgBjHdzBMgEfDohgBjMd0BXf4eypHgBjQd1Bofteqp8gAjSd2B3fketqngAjRd2B7ffe6q0gAjMd1BzfdfPqegAjHd0Bi
					fgfqpuf/jEdzBSfmgHo6f/jEdzBKfwgkocf/jHdzBMf8g9ohf/jMd0BXgIhOpHf/jQd1BogThWp8gAjSd2B3gchTqngAjRd2B7ghhGq0gAjMd1BzgjgxqegA
					jHd0BigggWpu]],
				Head = [[
					gBjoc8/tgYgBkPgDjmc6/ogMgqkugFjpc6/rf/hQkVgFjwc9/yfxhsjPgFj3dA/3flh5h9gFj7dC/6fch1hFgEj7dD/7fYhkhCgCj1dC/6fZhIh1gAjuc//1
					fegmjGf/joc8/tfof/kPf9jmc6/of0fWkuf7jpc6/rgBewkVf7jwc9/ygPeUjPf7j3dA/3gbeHh9f7j7dC/6gkeLhFf8j7dD/7goechCf+j1dC/6gne4h1gA
					juc//1gifajG]],
				Jaw = [[
					gDiqdM/pgYgCkogEipdM/kgMgqlHgEisdL/nf+hQkugEiydJ/vfwhrjogDi5dH/2fjh4iWgCi8dG/5fah1hegBi8dH/6fWhjhbf/i2dI/4fYhIiOf+iwdK/y
					fegljff9iqdM/pfof+kof8ipdM/kf0fWlHf8isdL/ngCewkuf8iydJ/vgQeVjof9i5dH/2gdeIiWf+i8dG/5gmeLhef/i8dH/6gqedhbgBi2dI/4goe4iOgC
					iwdK/ygifbjf]],
				["UpperLegF.L"] = [[
					eVhsfHoOXncl9jeUhtfHreWvb98GeThvfHwOVwcw5YeThyfH0BVQeX2deThzfG3yVVghyieUhyfG5LVohfwueVhvfH21Vsgcz5eWhrfH0mVvfc2NeYhofHy2
					V4er3veZhmfHxhWEeP4zeahnfIwqWSeM5debhrfIwWWieg5xebhvfIwfWyfC5zebhyfIwuXGfk5xeahzfIwcXbf56EeZhyfIvTXwf563eYhvfItsYFfx7zeW
					htfIpaX8eI9c]],
				["LowerLegF.L"] = [[
					d8hYfq9ldBiTrld4hSfi/BbojulRd2hMfU/QbIj+ild6hJfG/EbPiylReChJe39FbBf6sWeHhJex6ya1eMwoeDhEe88ibMfotpeAhBfF9kbXgqrTd/g/fM98
					bThBqNd/g/fR94bQg+qVeAhCfV9abWgprreChFfW8fblgHt3eDhIfX7Jb0fewZeFhKfW5ncBe4yteFhLfY4dcQen0PeEhMfc4Acre002eDhMfg30dPfJ1Kd/
					hUfp63d5gxxO]],
				["FootF.L"] = [[
					d+hAfR/HhSftnVd+hGfD/Af5gCn5d+hFez/BfRgMnzd+g+em/MfegInDd+gxef/de/gMlwd+gsei/eeWgGldd+grem/lfGgJk+d+grer/mfggFk+d+grex/m
					figFk+d+gre2/mfegFk+d+gre8/mffgFk+d+grfB/mflgEk+d+grfG/mfngEk+d+grfM/mflgEk+d+grfR/mfrgDk+d+grfX/mgGf/k+d+grfc/mgtf5k+d+
					g1fb/Vh3fpmL]],
				["UpperLegF.R"] = [[
					hnhmfHxhp8hx4zhmhnfIwqpuh05dhlhrfIwWpehg5xhlhvfIwfpOg+5zhlhyfIwuo6gc5xhmhzfIwcolgH6EhnhyfIvToQgH63hohvfItsn7gP7zhqhtfIpa
					oEh49chrhsfHoOoZjb9jhshtfHrepRkD8GhthvfHwOqQjQ5YhthyfH0Bqwhp2dhthzfG3yqrffyihshyfG5LqYehwuhrhvfH21qUfkz5hqhrfH0mqRgk2Nho
					hofHy2qIhV3v]],
				["LowerLegF.R"] = [[
					iBg/fR94kwfCqViAhCfV9akqfXrrh+hFfW8fkbf5t3h9hIfX7JkMgiwZh7hKfW5nj/hIyth7hLfY4djwhZ0Ph8hMfc4AjVhM02h9hMfg30ixg31KiBhUfp63
					iHfPxOiEhYfq9li/dtrliIhSfi/BkYcSlRiKhMfU/Qk4cCiliGhJfG/EkxdOlRh+hJe39Fk/gGsWh5hJex6ylLh0woh9hEe88ik0gYtpiAhBfF9kkpfWrTiB
					g/fM98kte/qN]],
				["FootF.R"] = [[
					iCgre2/mgif7k+iCgre8/mghf7k+iCgrfB/mgbf8k+iCgrfG/mgZf8k+iCgrfM/mgbf8k+iCgrfR/mgVf9k+iCgrfX/mf6gBk+iCgrfc/mfTgHk+iCg1fb/V
					eJgXmLiChAfR/HeugTnViChGfD/AgHf+n5iChFez/Bgvf0nziCg+em/Mgif4nDiCgxef/dhBf0lwiCgsei/ehqf6ldiCgrem/lg6f3k+iCgrer/mggf7k+iC
					grex/mgef7k+]],
				Tail1 = [[
					gAiahoiQg5gy/5gCibhoh/gngw/6gCiehoh2gQgo/7gDihhoh6f4gb/7gDijhoiIfhgL/6gDijhoiafNf7/5gDihhoine/fq/3gCiehoiqe5fd/2gBibhoih
					e8fT/3gAiahoiQfHfO/5f+ibhoh/fZfQ/6f+iehoh2fwfY/7f9ihhoh6gIfl/7f9ijhoiIgff1/6f9ijhoiagzgF/5f9ihhoinhBgW/3f+iehoiqhHgj/2f/
					ibhoihhEgt/3]],
				Tail2 = [[
					gDiUiVjQiagm/ugDiWiVivhngo/1gDiZiViXgngm/5gDiciViTfkgd/5gCidiVilekgR/2gBidiVjFdugE/wgAiaiVjjdKf3/qf/iWiVjyc8fr/nf+iUiVjq
					dFfh/pf9iUiVjQdmfa/uf9iWiViveZfY/1f9iZiViXfZfa/5f9iciViTgcfj/5f+idiVilhcfv/2f/idiVjFiSf8/wgAiaiVjji2gJ/qgBiWiVjyjEgV/ngC
					iUiVjqi7gf/p]],
				Tail3 = [[
					gKiLjBjRkSga/igIiOjCimjNge/ugFiSjCh+hvge/4gCiVjChsgFgZ/8f+iWjCh3eagQ/5f7iUjBicc7gF/vf4iQjAjJb0f7/jf2iMjAjobMfz/af1iKjAjr
					bKfs/af2iLjBjRbufm/if4iOjCimczfi/uf7iSjCh+eRfi/4f+iVjChsf7fn/8gCiWjCh3hmfw/5gFiUjBicjFf7/vgIiQjAjJkMgF/jgKiMjAjok0gN/agL
					iKjAjrk2gU/a]],
				Tail4 = [[
					gWiCjsiqmLgY/RgRiHjth/lHgY/hgKiNjvhMjbgX/ygCiRjvgohVgS/9f6iRjugmfFgJ/+fyiNjthFc9f9/0fsiHjrh4bLfy/kfpiCjqimZ/fr/TfoiAjqi6
					Zhfp/MfqiCjsiqZ1fo/RfviHjth/a5fo/hf2iNjvhMclfp/yf+iRjvgoerfu/9gGiRjugmg7f3/+gOiNjthFjDgD/0gUiHjrh4k1gO/kgXiCjqimmBgV/TgY
					iAjqi6mfgX/M]],
				Tail5 = [[
					gnh7kVhFnsgu/BgfiBkYgjm7gm/OgUiKkbftlVgd/igGiPkce9jGgS/0f3iPkbeqgfgC/9fpiKkZe7d0fv/5ffiCkWfrbafc/pfYh7kUghZkfR/UfWh4kThE
					YffO/EfZh7kVhFYUfS/BfhiBkYgjZFfa/OfsiKkbftarfj/if6iPkce9c6fu/0gJiPkbeqfhf+/9gXiKkZe7iMgR/5ghiCkWfrkmgk/pgoh7kUghmcgv/Ugq
					h4kThEnhgy/E]],
				["UpperLegB.L"] = [[
					eahjg+5sRfdJsBeahlhB5hR3dEsxeahphD5OSqdcuOeZhuhF4vTueFwCeYhxhG4FUwezxxeXhzhG3cVYfOy/eWhzhF27VafUzneVhxhD2XVPfY0LeVhvhB1h
					VSfr1HeUhug+0SVzgR2ieUhvg8yeXBhO4feVhxg6vjZVig7CeVhzg4umZYil7keWhzg3xyVGgx4PeXhxg3z6SCfb0xeYhug42GPhd8wFeZhpg64FOjcirQea
					hlg85UPfcGps]],
				["LowerLegB.L"] = [[
					eDhKgd0Bchga4teChKghzrdEgU5DeChKgnz0dVgK49eChLgt0QdUf34neDhLgz0idNfi4XeDhKg30Fdbfe4xeBhJg5yjeIfw5/eAhHg5wbe9gD7bd/hFg7ub
					fdgI8jd/hDg+tRfSf+9GeChEhEtqeGfk83eHhIhPwPbhe47LeIhMhQvRbZe+7td/hKg+nWfofk/Id7hLgwjjhffF/vd7hPghkShheh/od/hVgXpsfxe/+eeB
					hUgWvrd4gI7z]],
				["FootB.L"] = [[
					d+grgj/mfngEk+d+grgo/mf9gAk+d+grgu/mgEf/k+d+grgz/mf5gBk+d+grg5/mfngEk+d+grg+/mfugDk+d+grhD/mgWf9k+d+grhJ/lhCf2k+d+grhO/k
					hWfyk+d+grhT/lhEf1k+d+grhZ/mf6gBk+d+gshd/ZdpgOlnd+gxhg/RdigPmSd+g7hc/Pg1f0m1d+hEhP+/h9fhnsd+hHhA+8htfkn7d+hCgx/Fgyf0ngd+
					g4gn/VgPf9md]],
				["UpperLegB.R"] = [[
					hshug+0SqNfv2ihshvg8yeo/ey4fhrhxg6vjmrdg7Chrhzg4ummodb7khqhzg3xyq6fP4Phphxg3z6t+gl0xhohug42GwfiEwFhnhpg64FxdjerQhmhlg85U
					whj6pshmhjg+5suhi3sBhmhlhB5huJi8sxhmhphD5OtWikuOhnhuhF4vsSh7wChohxhG4FrQhNxxhphzhG3cqogyy/hqhzhF27qmgsznhrhxhD2Xqxgo0Lhr
					hvhB1hqugV1H]],
				["LowerLegB.R"] = [[
					iBhDg+tRgugC9Gh+hEhEtqh6gc83h5hIhPwPkfhI7Lh4hMhQvRknhC7tiBhKg+nWgYgc/IiFhLgwjjehg7/viFhPghkSefhf/oiBhVgXpsgPhB+eh/hUgWvr
					iIf47zh9hKgd0Bjffm4th+hKghzri8fs5Dh+hKgnz0irf249h+hLgt0QisgJ4nh9hLgz0iizge4Xh9hKg30Filgi4xh/hJg5yjh4gQ5/iAhHg5wbhDf97biB
					hFg7ubgjf48j]],
				["FootB.R"] = [[
					iCgrhT/le8gLk+iCgrhZ/mgGf/k+iCgshd/ZiXfylniCgxhg/RiefxmSiCg7hc/PfLgMm1iChEhP+/eDgfnsiChHhA+8eTgcn7iChCgx/FfOgMngiCg4gn/V
					fxgDmdiCgrgj/mgZf8k+iCgrgo/mgDgAk+iCgrgu/mf8gBk+iCgrgz/mgHf/k+iCgrg5/mgZf8k+iCgrg+/mgSf9k+iCgrhD/mfqgDk+iCgrhJ/le+gKk+iC
					grhO/keqgOk+]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAi4g3ABgAgAgqgAiqg3ABgCgVgXgAigg3ADgDgihKgAing3AFgCgih9gAi2g3AEgCgVhpgAi4g3ABgAgAgqgAiqg3ABf+frgXgAigg3ADf9fehKgAing3AF
					f+feh9gAi2g3AEf+frhp]],
				Spine1 = [[
					gAi5gbACgAgAhCf/irgbABgCgVgSf/iigbACgDgigvf/irgbAEgCgihxf/i5gbAFgCgVh9gAi5gbACgAgAhCgBirgbABf+frgSgBiigbACf9fegvgBirgbAE
					f+fehxgBi5gbAFf+frh9]],
				Spine2 = [[
					gAi7f//4gAgAilf/isf//xgAfrjxf+ikf//xgCfejpf+iuf//5gCfeiZf/i8f//8gBfrhugAi7f//4gAgAilgBisf//xgAgVjxgCikf//xf+gijpgCiuf//5
					f+giiZgBi8f//8f/gVhu]],
				Spine3 = [[
					gAi2fj/6gAgAiOf+ilfj/wgAfrj2f9idfk/ugDfekEf9iqfj/4gDfeikf+i5fj/9gAfrhbgAi2fj/6gAgAiOgCilfj/wgAgVj2gDidfk/uf9gikEgDiqfj/4
					f9giikgCi5fj/9gAgVhb]],
				Neck1 = [[
					gAiyfHAhgAgAlpf+iefIAMgEgVjSf8iWfIAIgEgiihf8ilfIAVgFgikaf+i3fHAqgFgUmVgAiyfHAhgAgAlpgCiefIAMf8frjSgEiWfIAIf8feihgEilfIAV
					f7fekagCi3fHAqf7fsmV]],
				Neck2 = [[
					gAjEeXCAgAgArFf9ipeWBEgHgUoGf7ieeWAwgJghmzf7izeWBUgKghpBf9jLeYCNgIgTrogAjEeXCAgAgArFgDipeWBEf5fsoGgFieeWAwf3ffmzgFizeWBU
					f2ffpBgDjLeYCNf4ftro]],
				Neck3 = [[
					gAjfd4CpgAgAssf8i9dzBVgIgTpEf5ivdxA2gJghnOf6jJd0BkgLggp0f8jmd6C2gJgTtJgAjfd4CpgAgAssgEi9dzBVf4ftpEgHivdxA2f3ffnOgGjJd0Bk
					f1fgp0gEjmd6C2f3fttJ]],
				Head = [[
					gAkPdLABgAgAggf7jhc7AJgAgVdPf4jMc1ATf9gibyf4jwc/AFf+gieKf7kYdOACgBgVhFgAkPdLABgAgAgggFjhc7AJgAfrdPgIjMc1ATgDfebygIjwc/AF
					gCfeeKgFkYdOACf/frhF]],
				Jaw = [[
					gAjQdJ/6gAgAiIf7iidG/igBfrlYf4iPdG/QgFfemzf4ixdF/rgFfekdf7jZdK/8gBfrhjgAjQdJ/6gAgAiIgFiidG/if/gVlYgIiPdG/Qf7gimzgIixdF/r
					f7gikdgFjZdK/8f/gVhj]],
				["UpperLegF.L"] = [[
					eXh6fIsVZNgp8ueVhnfRkpX1bQ+NeThffTwRT8ZG3yeThtfN1rUfcn0OeVh/fH61VHgrtmeXh6fI6mU9hNt4eZhmfM3oTqfwxrebhefMv4Uvdn5RebhtfGtY
					XCfn7oeZh/fDvaZph/7O]],
				["LowerLegF.L"] = [[
					eGhZflySdHds5/d8hdf499bgihp+duhDfc9RXeliYEd3hIfF/NZ3i8eOeJhcep8gayd7tYeMhXeq8UaleatyeEhAe69OZVfHrJd9g8fY+PZqiPoAeDhLfd42
					cPfvzzeMhXfZwWccdS7I]],
				["FootF.L"] = [[
					d+g6fw/SgBgAmqd+hJfd+7fsgFoJd+hPfB9yYRiMocd+hLej+vdEgzoTeAhEeT+8ecfwn9eEg9eV+5ePfBoFd+greg/edKgdk9d+gre7/jeHgTk+d+grfV/m
					f7gBk+eDg6fo+Cereqq2]],
				["UpperLegF.R"] = [[
					hph6fI6mrDezt4hnhmfM3osWgQxrhlhefMv4rRiZ5RhlhtfGtYo+gZ7ohnh/fDvamXeB7Ohph6fIsVmzfX8uhrhnfRkpoLkw+NhthffTwRsEm63yhthtfN1r
					rhjZ0Ohrh/fH61q5fVtm]],
				["LowerLegF.R"] = [[
					h0hXeq8Ulbhmtyh8hAe69Omrg5rJiDg8fY+PmWdxoAh9hLfd42jxgRzzh0hXfZwWjkiu7Ih6hZflySi5iU5/iEhdf499kgdfp+iShDfc9RoiaeYEiJhIfF/N
					mJdEeOh3hcep8glOiFtY]],
				["FootF.R"] = [[
					h8g9eV+5hxg/oFiCgreg/ei2fjk9iCgre7/jh5ftk+iCgrfV/mgFf/k+h9g6fo+ChVhWq2iCg6fw/Sf/gAmqiChJfd+7gUf7oJiChPfB9ynvd0ociChLej+v
					i8fNoTiAhEeT+8hkgQn9]],
				Tail1 = [[
					gAi1hpitgAgA/4gBiohphGfrgC/+gCichphffegD/9gCihhojWfef//0gBiwhokGfrf9/ugAi1hpitgAgA/4f/iohphGgVf+/+f+ichphfgif9/9f+ihhojW
					gigB/0f/iwhokGgVgD/u]],
				Tail2 = [[
					gAitiVlrgegA/egAiliWjBfegE/2gAiYiWiWergK/4gAiXiVkleXgE/ngAiliUmoesf+/RgAitiVlrfigA/egAiliWjBgif8/2gAiYiWiWhVf2/4gAiXiVkl
					hpf8/ngAiliUmohUgC/R]],
				Tail3 = [[
					gBiejAnghVgB/Ef/idjCkefwgF/rf8iRjCigeQgN/2f8iKjAkVdbgF/lf8iSi+nadlf8/Bf/iejAngerf//EgBidjCkegQf7/rgEiRjCighwfz/2gEiKjAkV
					ilf7/lgEiSi+naibgE/B]],
				Tail4 = [[
					gFiJjooSiagJ+zf+iQjulsgegJ/ef4iKjvireVgO/1f0h+jrjcc1gB/pf2h+jlm7cjfz/Cf7iJjooSdmf3+zgCiQjulsfif3/egIiKjvirhrfy/1gMh+jrjc
					jLf//pgKh+jlm7jdgN/C]],
				Tail5 = [[
					gMhykPnmjdgd+4f/iBkYmChdgV/YfziCkbine3gQ/3frh1kWiGcsf3/wfshrkNlLb0fe/Sf0hykPnmcjfj+4gBiBkYmCejfr/YgNiCkbinhJfw/3gVh1kWiG
					jUgJ/wgUhrkNlLkMgi/S]],
				["UpperLegB.L"] = [[
					eXiBhD5zVEhwvVeXh0hG4cVQhZxkeXhphF36SqeJwceXhvhCzQWlgM3weXh+hCu0aPiH7reXiBhDtwZ0iP8IeXhzhCyVSpfo2keXhpg+06NxdLvqeXhvg75G
					OcbmoFeXh+g95WUOhAvi]],
				["LowerLegB.L"] = [[
					eLhagp7LZWfWvfeJhKgz5zZRepxnd/hGguvdfKgw7/eDhEhHuLd9ey8leLhXhavYcRee7weKhbheuYbtel8Nd6hNhCh+h9en/1d2hPgmfgjjcu/nd/hkgTtX
					fFgd9DeIhYgk63Yaekvk]],
				["FootB.L"] = [[
					eEg/gY+kcZfiosd/gtgm/Nb9galvd+grhA/khlfwk+d+grhb/mfWgHk+eDg8hr9ndze7r2eAhBhw+Xdbf3pud+hJhi+3iDfdoId+hPhG+siWfWosd+hLgo+3
					hRfqoVd+g+gT+vavhInD]],
				["UpperLegB.R"] = [[
					hpiBhDtwmMdx8IhphzhCyVtXgY2khphpg+06yPi1vqhphvg75GxkkaoFhph+g95WryfAvihpiBhD5zq8eQvVhph0hG4cqwenxkhphphF36tWh3wchphvhCzQ
					pbf03whph+hCu0lxd57r]],
				["LowerLegB.R"] = [[
					h2hbheuYkThb8NiGhNhCh+eDhZ/1iKhPgmfgcdjS/niBhkgTtXg7fj9Dh4hYgk63nmhcvkh1hagp7Lmqgqvfh3hKgz5zmvhXxniBhGguvdg2fQ7/h9hEhHuL
					iDhO8lh1hXhavYjvhi7w]],
				["FootB.R"] = [[
					iAhBhw+XilgJpuiChJhi+3d9gjoIiChPhG+sdqgqosiChLgo+3evgWoViCg+gT+vlRe4nDh8g/gY+kjngeosiBgtgm/NkDfmlviCgrhA/kebgQk+iCgrhb/m
					gqf5k+h9g8hr9niNhFr2]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAiqg3AFgAgAh/gAipg3AFf7fzh/gAiog3AGfvfRh/gAimg3AHfeejiAgAijg3AKfNd2iCgAiig3ANfCdZiDgAiig3ANfCdZiDgAiog3AFgJgch/gAiqg3AR
					hJjQiFgAiqg3AWhWj0iHgAiqg3AWhWj0iHgAiqg3AWhWj0iHgAiqg3AShMjYiFgAiqg3AMg4ieiCgAiqg3AHgfhXiAgAiqg3AFgKgdh/gAiqg3AFgAgBh/gA
					iqg3AFgAgAh/gAiqg3AFgAgAh/]],
				Spine1 = [[
					gAiugbAFgAgAh/gAitgbAFf7fvh/gBirgbAGfufDiAgDipgbAJfceGiBgEingcAOfLdNiCgEimgcASe/cmiEgEimgcASe/cmiEf/isgbAFgKgkh/f6iugcAY
					hNkMiGf5iugcAghak7iJf5iugcAghak7iJf6iugcAghak6iJf6iugcAahQkWiHf8iugcAQg6jLiDf+iugbAIghhxiAf/iugbAFgLglh/gAiugbAFgAgBh/gA
					iugbAFgAgAh/gAiugbAFgAgAh/]],
				Spine2 = [[
					gAixf//7gAgAh/gBiwf//7gDgVh/gDivf//6gKhOh/gGitgA/1gTiah9gJirgA/vgcjjh6gKiqgA/pgikTh3gKiqgA/pgikTh3f+ivf//7f7fUh/fziygB/g
					fZaxh0fxiygC/VfSZ2hvfxiygC/VfSZ2hvfxiygB/VfSZ3hvfziygB/dfXakhzf2ixgA/rficCh5f7ixgA/2fvdzh9f+ixf//7f7fSh/gAixf//7gAf/h/gA
					ixf//7gAgAh/gAixf//7gAgAh/]],
				Spine3 = [[
					gAiufj/7gAgAh/gBitfj/7gCgZh/gFirfj/5gJhch+gKipfk/zgRi2h8gPiofl/qgZkMh5gSimfl/hgelGh1gSimfl/hgelGh1f9isfj/6f8fMh/fqivfm/V
					fdZ1hxfmivfo/GfXYwhsfmivfo/GfXYwhsfmivfo/HfXYyhsfpivfn/SfcZmhwfviufl/lflbUh3f3iufk/0fxdZh9f9iufj/6f7fJh/gAiufj/7gAf+h/gA
					iufj/7gAgAh/gAiufj/7gAgAh/]],
				Neck1 = [[
					gAiqfHAVgAgAkcgCipfHAUf7f1kXgIiofIATftfXkJgPimfIASfdeuj3gWikfKASfQeGjngbijfLATfIdrjdgbijfLATfIdrjdf8iofHATgOgzkMffisfMAp
					hhkFkhfaitfOAxhykzkjfaitfOAxhykzkjfaitfOAwhykykjfeisfNAqhlkPkifnirfKAghKjGkffyiqfIAYgphukdf7iqfHAVgNgkkcgAiqfHAVgAgBkcgA
					iqfHAVgAgAkcgAiqfHAVgAgAkc]],
				Neck2 = [[
					gAi4eWBLgAgAoigDi3eWBJf9gCoYgKi1eWBBf2gIn9gTiyeXA5fxgNnZgciweYAxfwgRm3giiueZAsfygTmhgiiueZAsfygTmhf5i1eWBEgVgxoEfTi7edBT
					hjiColfMi8egBWh0iZomfMi8egBWh0iZomfMi8egBWh0iYomfSi7eeBThniHolfei6eaBQhLhiokfti5eXBNgqg3ojf6i4eWBLgOgSoigAi4eWBLgAgBoigA
					i4eWBLgAgAoigAi4eWBLgAgAoi]],
				Neck3 = [[
					gAjNdzBQgAgAo0gCjMdzBMgAgPolgJjJdzBCgEg1n8gSjFdzA2gQhnnFgbjBdzAughiUmQghi/d0Aqgxixltghi/d0Aqgwixluf4jJdzBFgVgxoHfPjQd6BS
					hDgMo1fHjRd9BShPgPo1fHjRd9BShPgPo1fHjRd9BShOgPo1fOjQd7BShFgNo1fbjPd3BRgzgJo1frjOd1BRgcgFo0f5jNdzBQgJgCo0gAjNdzBQgAgAo0gA
					jNdzBQgAgAo0gAjNdzBQgAgAo0]],
				Head = [[
					gAjwc7/xgAgAjsgCjuc6/vgHfgj7gGjoc5/mgWeKklgMjhc3/TghcXlcgSjac3+6ghaomOgWjWc3+lgbZdmtgWjWc3+lgbZemsf1jqc5/qgpe0kYfQjzdC/v
					g1hDjxfIj0dF/ug/hPjzfIj0dF/ug/hPjzfIj0dF/ug/hPjzfOjzdD/vg3hGjxfbjyc//wgogzjufrjxc9/xgWgcjsf5jwc7/xgHgJjsgAjwc7/xgAgAjsgA
					jwc7/xgAgAjsgAjwc7/xgAgAjs]],
				Jaw = [[
					gAiydJ/8gAgAh2gCixdJ/6gFfgiQgIisdK/wgSeJjWgQildM/agccWkzgYigdO+7gganmIgdicdQ+hgfZem/gdicdQ+hgfZem/f4itdK/qgpe0kZfTi2dR/X
					gwhHmKfLi3dU/Mg3hVm7fLi3dU/Mg3hVm7fLi3dU/Mg2hUm6fRi2dS/VgyhKmVfdi0dO/kgmg1lHftizdL/xgWgcjpf6iydJ/5gIgJicgAiydJ/8gAgAh3gA
					iydJ/8gAgAh2gAiydJ/8gAgAh2]],
				["UpperLegF.L"] = [[
					eXhyfHyrWqgA4OeZhxfFx7WTfy4qeghue+wIVWfU5eephre2unUEfD50ezhoevveSof+4me6hmequIR/fz5De6hmequIR/fz5DeShxfNzeXYgC33d7h6f08J
					dIiCuzd4h7f88qeLh7t+d4h7f88qeLh7t+d4h7f88peJh7t/d6h6f28RdXiBumeAh4fo7NboiFwGeJh1fZ32ZPhS0MeShzfN0GXdgU3XeXhyfHyuWsgA4NeX
					hyfHyrWqgA4OeXhyfHyrWqgA4O]],
				["LowerLegF.L"] = [[
					eChIfO7WcGgAwHeDhIfO7Ibmf7wYeGhJfL6FaKfdxkeLhJfE3fYFeH0IeUhFe3x5WAbE4DeZhGe1wtVHa04deZhGe1wtVHa04dd/hGfS8fdNgouRd8hTfZ8R
					h5fku3d7hWff8mi6fouBd7hWff8mi6fouBd7hWff8mi4fouCd8hTfa8WiIfluqd/hOfR7mgbfSwKd/hHfQ79ezf5vgeAhHfQ7/dKgSvOeChIfO7YcIgBwFeC
					hIfO7WcGgAwHeChIfO7WcGgAwH]],
				["FootF.L"] = [[
					d+gre9/mgAgAk+d+gre9/mfggFk+d+gre9/id8gVk9d+gre9/RbZguk7d+gre9+cXthIlKeCgue89zWVgrmbeBgue89zWVgrmad+gre9/lhRfzk+d9g3fG+n
					lmeznSd9g7fK+Smneonwd9g7fK+Smneonwd9g7fK+Tmmepnvd9g4fH+il1ewnad+gwfB/FkDfImVd+gre9/finfmk9d+gre9/lhIf1k+d+gre9/mgCgAk+d+
					gre9/mgAgAk+d+gre9/mgAgAk+]],
				["UpperLegF.R"] = [[
					hphyfHyrpWgA4OhrhyfKzHpAf+4BhxhxfR0koDfv3Jh4hxfb2+mvfQ1Nh+hxfl52lTejyCiBhwfs72kKd+vDiBhwfr71kLd+vEhkhvfCw/qHgh5Jg9huelta
					uUfd5Rg0huegsOu7fW5hg0huegsOu7fW5hg0huegsQu6fW5gg7huektIudfc5VhJhvesvRtZfg4uhYhwe3xJrwfw4UhkhxfCxiqHgN4xhphyfHyppXgA4Qhp
					hyfHyrpWgA4OhphyfHyrpWgA4O]],
				["LowerLegF.R"] = [[
					h+hIfO7Wj6gAwHh/hHfQ73jZfvvWiChFfT82iEfQtqiEhDfV9bgmfDsgiDhFfU9CfrfrtaiChJfR8LfXgivHiChJfR8LfXgjvIh9hIfN67k+gJwjhehOexwB
					rakY42hXhQetu8sQkR5IhXhQetu8sQkR5IhXhQetu+sPkR5IhdhPewvxrmkX47hnhLe1xqqHkW4ThyhJe/1pnyjB2Bh7hJfL6UlFghxdh+hIfO7Vj8gBwJh+
					hIfO7Wj6gAwHh+hIfO7Wj6gAwH]],
				["FootF.R"] = [[
					iCgre9/mgAgAk+iCgre9/mfagGk+iCgre9/id/gUk9iCgre9/acfgjk8iCgre9/Ubxgrk7iCgse//PbsgwlViCgse//PbsgwlViCgre9/lhFf1k+h2g3e58e
					qhg6qDhwg7e27Jr3htr8hwg7e27Jr3htr8hwg7e37Lr1hsr5h0g4e48Mq1hGqeh9gxe895ohf7njiCgre9/Nk9fOk6iCgre9/khTfzk+iCgre9/mgCgAk+iC
					gre9/mgAgAk+iCgre9/mgAgAk+]],
				Tail1 = [[
					gAijhoiRgAgA/6f/iihoiRfsgF/6f+ihhoiSe0gU/4f8iehoiTdqgn/0f6ichoiVcjg6/tf4ibhoiXbzhG/nf4ibhoiXb0hG/ngBihhoiSgXf3/6gKiihnix
					k/ep/cgLiihnjYm/eN++gLiihnjjnXeI+3gLiihnjjnWeI+4gKiihnjhm0eU/AgHijhojZlket/SgEijhojHjpfQ/ngBijhoiwhtfu/0gAijhoicgbf+/5gA
					ijhoiSgBgA/6gAijhoiRgAgA/6]],
				Tail2 = [[
					gAidiVjEgAgA/2f/iciVjEfhgH/1f7iaiVjFePgZ/yf1iYiUjGcggy/ofwiViUjJa2hK/ZftiUiTjLZvhZ/LftiUiTjLZvhZ/LgCibiVjGgRf3/1gXiaiSj+
					nReQ+2geiYiPlFrEde9egfiXiOlYr5dT9FgfiXiOlYr3dU9GgciYiPlWrPdh9XgWiZiRlLpkeB+BgOiaiTkrmoey+7gGibiVkAjWfg/jgBiciVjag9f6/ygA
					idiVjGgDgA/1gAidiVjEgAgA/2]],
				Tail3 = [[
					gAiUjCixgAgA/3f9iTjCixfUgI/3f2iSjBiydfgc/xfsiPjAizbBg4/dfiiMi+i2YshS+/fciKi8i4XJhj+kfciKi8i4XJhj+kgDiSjCizgJf4/3gqiOi5kE
					qIeD+Ag6iIivlov9dE6/g8iHismBxPc36Fg8iHitmBxOc36Gg4iHivl/wfdE6lgviJi0lyuadm73ggiMi7lHqTee90gPiQjAkKlbfV/PgEiTjBjRhpf2/ygA
					iUjCizgFgA/3gAiUjCixgAgA/3]],
				Tail4 = [[
					gAiMjuh1gAgA/8f7iMjuh1fFgH/7fviKjth2ckgb/wfeiHjqh4ZQg1/NfOiDjlh8WIhM+VfEiBjhh/UFhb9lfEiBjhh/UFhb9lgDiKjuh3f/f4/8hFiCjcjk
					teeK8vheh3jDli1PdU3Hhih0i8mA23dJ1Xhih0i8mA22dK1Yhdh1jBl+2FdU2MhRh4jMlvzvdx4ag6h+jck6ujei8BgeiEjpjrn4fW+xgIiJjtifidf2/zgA
					iMjuh3gIgA/8gAiMjuh1gAgA/8]],
				Tail5 = [[
					gAiHkbgAgAgA//f5iGkbgAeygE/+fliEkZgCbhgO/rfLiBkTgIXMgb+we0h9kKgRTNgn9Telh6kCgZQogt8Celh6kCgZQpgt8DgDiFkbgDf0f4//hmh2j4iX
					xMe/62iIhmjGk+6SeyxgiMhji4li75e0umiMhji4li74e0uoiHhkjAld7Oe5v2h7hojUlH49fGzVhehwj1kAzIfc5Ugzh6kPiXqtf0+DgPiCkag2jagA/zgB
					iHkbgDgLgA//gAiHkbgAgAgA//]],
				["UpperLegB.L"] = [[
					eXhyg+2NU6gA0LeXhxg92IUogC0HeYhug510UBgM0GeYhrg11OTYgj0UeZhngw0gS6hA0veahlgtz7SqhV1Ieahlgtz7SqhV1IeXhxhB2yUtfYzZeYh4hU3w
					Yofk0HeYh5hY4PY5fOzneYh5hY4PY5fOzneYh5hX4OY4fOzoeYh4hV33Ysff0AeXh3hP3BYSgD01eXh1hH3EWCfVzyeXhzhB2iVNfuz+eXhyg+2NU6f/0LeX
					hyg+2NU6gA0LeXhyg+2NU6gA0L]],
				["LowerLegB.L"] = [[
					eChIg1w9dlgA7BeChHgzwPdsgI7deBhFgvuZd4gV8feBhCgrsEd7ga9jeCg+gop9dzgV+UeCg8gnoodqgQ+teCg8gnoodqgQ+teBhIg1xEeLgC6/eJhMhK4l
					cdcfz3eJhNhM5Cc3cLzTeJhNhM5Cc3cLzTeJhNhM5Bc2cLzUeJhMhK4rcjcazveIhKhH34b7c60qeDhKg80MdmfL4reChJg3x9drf06XeChIg1w/dlgA7AeC
					hIg1w9dlgA7BeChIg1w9dlgA7B]],
				["FootB.L"] = [[
					d+grhD/mgAgAk+d+grhD/mgIf/k+d+grhD/mgSf9k+d+grhD/mgOf+k+d+grhD/mf9gBk+d+grhD/mfsgDk+d+grhD/mfsgDk+d+grhD/mgff7k+d/gthD/W
					dOgOltd/gvhE/RdagCmNd/gvhE/RdagCmNd/gvhE/RdagCmMd/gthD/VdRgLl1d+grhD/cdBgdlBd+grhD/mfrgDk+d+grhD/mgAgAk+d+grhD/mgAgAk+d+
					grhD/mgAgAk+d+grhD/mgAgAk+]],
				["UpperLegB.R"] = [[
					hphyg+2NrGgA0LhphyhA2crIgPz5hphxhD3CrLg3zLhphwhI3trJhpyShphwhN4RrCiXxhhphvhQ4nq6i0xDhphvhQ4nq7izxDhphvg72Drwf+z/hlhsgpyR
					r3dQ3RhjhrglxNrvct4DhjhrglxNrvct4DhjhrglxPrvct4ChkhsgoyDr2dI3chmhtguzgr5eA2Uhohvg105rte91Mhphxg710rWfs0dhphyg+2MrHf/0Mhp
					hyg+2NrGgA0Lhphyg+2NrGgA0L]],
				["LowerLegB.R"] = [[
					h+hIg1w9ibgA7Bh+hIg1xHiNgB68h/hJg2xohsgD6piAhKg4yehIgI6GiBhKg6zbgtgP5ZiBhLg80IgfgW42iBhLg80IgfgW43h/hGgxvOiGfu8Dh6hBgsrz
					ktfW9Wh5hAgsrelbfN9Wh5hAgsrelbfN9Wh5hAgsrelafN9Xh6hBgsrtk2fU9Xh7hCgtsoj3ff9Ih9hFgvuSjCfq8dh+hHgzwBilf37kh+hIg0w7ibgA7Ch+
					hIg1w9ibgA7Bh+hIg1w9ibgA7B]],
				["FootB.R"] = [[
					iCgrhD/mgAgAk+iCgrhD/mf1gCk+iCgrhD/mfcgGk+iCgrhD/lfBgKk+iCgrhD/ketgNk+iCgrhD/kelgOk+iCgrhD/kelgOk+iCgrhD/mfrgDk+iCgrhD/j
					hpfvk+iCgrhD/hiJfqk9iCgrhD/hiJfqk9iCgrhD/iiIfrk9iCgrhD/jhwfuk+iCgrhD/lhCf2k+iCgrhD/mgaf8k+iCgrhD/mgFf/k+iCgrhD/mgAgAk+iC
					grhD/mgAgAk+iCgrhD/mgAgAk+]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiqg3AFgAgAh/gAiog6AEgAgAh0gAikhAADgAgAhZgAighGACgAgAhAgAifhIACgAgAg4gAijhBADgAgAhWgAirg2AIgAgAiogAiugxAPgAgAjrgAiugwAR
					gAgAj8gAiugwARgAgAj8gAiugwARgAgAj8gAiugwARgAgAj8gAiugwARgAgAj8gAiugwARgAgAj8gAiugwARgAgAj8gAiugwARgAgAj8gAiugwARgAgAj8gA
					iugwARgAgAj8gAiugwARgAgAj8gAiugxAPgAgAjtgAisg0AJgAgAi5gAiqg3AGgAgAiJgAiqg3AFgAgAh/gAiqg3AFgAgAh/gAiqg3AFgAgAh/]],
				Spine1 = [[
					gAiugbAFgAgAh/gAirgeAEgAgAhugAingkACgAgAhGgAiigqABgAgAgggAiggsABgAgAgVgAimglACgAgAhBgAivgaAJgAgAiygAi0gWASgAgAkKgAi1gVAV
					gAgAkfgAi1gVAVgAgAkfgAi1gVAVgAgAkfgAi1gVAVgAgAkfgAi1gVAVgAgAkfgAi1gVAVgAgAkfgAi1gVAVgAgAkfgAi1gVAVgAgAkfgAi1gVAVgAgAkfgA
					i1gVAVgAgAkfgAi1gVAVgAgAkfgAi0gWATgAgAkMgAixgYALgAgAjJgAiugbAGgAgAiLgAiugbAFgAgAh/gAiugbAFgAgAh/gAiugbAFgAgAh/]],
				Spine2 = [[
					gAixf//7gAgAh/gAiugC/6gAgAiWgAiogI/1gAgAjLgAijgO/vgAgAj9gAihgQ/tgAgAkMgAiogJ/0gAgAjSgAi0f+/+gAgAhCgAi7f6//gAgAfVgAi9f6/+
					gAgAe7gAi9f6/+gAgAe7gAi9f6/+gAgAe7gAi9f6/+gAgAe7gAi9f6/+gAgAe7gAi9f6/+gAgAe7gAi9f6/+gAgAe7gAi9f6/+gAgAe7gAi9f6/+gAgAe7gA
					i9f6/+gAgAe7gAi9f6/+gAgAe7gAi8f6/+gAgAfTgAi3f9//gAgAgkgAiyf//8gAgAhwgAixf//7gAgAh/gAixf//7gAgAh/gAixf//7gAgAh/]],
				Spine3 = [[
					gAiufj/7gAgAh/gAiqfm/5gAgAibgAijfs/zgAgAjegAicfy/rgAgAkdgAiaf0/ogAgAkvgAiift/ygAgAjmgAiyfi/+gAgAg3gAi9fe/+gAgAe2gAi/fe/8
					gAgAeXgAi/fe/8gAgAeXgAi/fe/8gAgAeXgAi/fe/8gAgAeXgAi/fe/8gAgAeXgAi/fe/8gAgAeXgAi/fe/8gAgAeXgAi/fe/8gAgAeXgAi/fe/8gAgAeXgA
					i/fe/8gAgAeXgAi/fe/8gAgAeXgAi9fe/+gAgAezgAi2fg//gAgAgUgAivfj/8gAgAhtgAiufj/7gAgAh/gAiufj/7gAgAh/gAiufj/7gAgAh/]],
				Neck1 = [[
					gAiqfHAVgAgAkcgAimfKARgAgAj/gAidfRAJgAgAi5gAiUfXAEgAgAh2gAiRfZADgAgAhjgAicfSAJgAgAiygAixfGArgAgAmdgAi/fCBggAgApogAjCfCBw
					gAgAqagAjCfCBwgAgAqagAjCfCBwgAgAqagAjCfCBwgAgAqagAjCfCBwgAgAqagAjCfCBwgAgAqagAjCfCBwgAgAqagAjCfCBwgAgAqagAjCfCBwgAgAqagA
					jCfCBwgAgAqagAjCfCBwgAgAqagAi/fCBhgAgApsgAi1fEA2gAgAnPgAisfHAZgAgAk6gAiqfHAVgAgAkcgAiqfHAVgAgAkcgAiqfHAVgAgAkc]],
				Neck2 = [[
					gAi4eWBLgAgAoigAizeZBDgAgAoEgAimefAygAgAm9gAiaelAkgAgAl5gAiWenAggAgAllgAikegAxgAgAm3gAjFeXCGgAgArXgAjceYEBgAgAvfgAjheZEl
					gAgAwegAjheZElgAgAwegAjheZElgAgAwegAjheZElgAgAwegAjheZElgAgAwegAjheZElgAgAwegAjheZElgAgAwegAjheZElgAgAwegAjheZElgAgAwegA
					jheZElgAgAwegAjheZElgAgAwegAjceYEDgAgAvkgAjLeWCfgAgAsUgAi7eWBXgAgApLgAi4eWBLgAgAoigAi4eWBLgAgAoigAi4eWBLgAgAoi]],
				Neck3 = [[
					gAjNdzBQgAgAo0gAjHd1BIgAgAoVgAi3d6A1gAgAnKgAipd/AmgAgAmDgAikeAAigAgAlugAi1d6A0gAgAnGgAjgd5CjgAgAsegAj/eDFTgAgAxmgAkFeGGI
					gAgAyzgAkFeGGIgAgAyzgAkFeGGIgAgAyzgAkFeGGIgAgAyzgAkFeGGIgAgAyzgAkFeGGIgAgAyzgAkFeGGIgAgAyzgAkFeGGIgAgAyzgAkFeGGIgAgAyzgA
					kFeGGIgAgAyzgAkFeGGIgAgAyzgAj/eDFXgAgAxsgAjpd6DFgAgAtpgAjSd0BggAgAppgAjNdzBQgAgAo0gAjNdzBQgAgAo0gAjNdzBQgAgAo0]],
				Head = [[
					gAjwc7/xgAgAjsgAjoc8/tgAgAkRgAjUc+/fgAgAlrgAjBdB/OgAgAm+gAi8dC/IgAgAnXgAjSc//egAgBltgAkQdL/8gAgAeagAk7dp+ygafRXWgAlEdy9t
					fdgzUMgAlEdy9/gAgAU3gAlEdy+NghfMVjgAlEdy9tfdgzUMgAlEdy9/gAgAU3gAlEdy+NghfMVjgAlEdy9tfdgzUMgAlEdy9/gAgAU3gAlEdy+NghfMVjgA
					lEdy9tfdgzUMgAlEdy9/gAgAU3gAk8dp+vgbfRXNgAkbdQ/yf2gbcZgAj4c+/5gAgAiigAjwc7/xgAgAjsgAjwc7/xgAgAjsgAjwc7/xgAgAjs]],
				Jaw = [[
					gAiydJ/8gAgAh2gAirdM/4gAgAingAiZdU/rgAgAkcgAiIdc/ZgAgAmJgAiDde/SgAgAmpgAiXdV/pgAgBkqgAjRdE//gAgAf9gBkGdH/2gifXdJf/kWdG/l
					fSgqbAgAkUdI/tgAgAbugBkTdK/xgsfUccf/kWdG/lfSgqbAgAkUdI/tgAgAbugBkTdK/xgsfUccf/kWdG/lfSgqbAgAkUdI/tgAgAbugBkTdK/xgsfUccf/
					kWdG/lfSgqbAgAkUdI/tgAgAbugBkHdH/2gjfWdGgAjedB/9f0gaergAi5dH/9gAgAhYgAiydJ/8gAgAh2gAiydJ/8gAgAh2gAiydJ/8gAgAh2]],
				["UpperLegF.L"] = [[
					eXhyfHyrWqgA4OeXhufMyYWRfj4TeXhlfWyxVSev3ieXhdfgz9UMeJ19eXhafj0YT0eA1WeXhkfXy7VIeo3WeXh5fCzXXFgO32eXiIe31NYShP2peXiLe11H
					YghN2zeXiLe11HYghN2zeXiLe11HYghN2zeXiLe11HYghN2zeXiLe11HYghN2zeXiLe11HYghN2zeXiLe11HYghN2zeXiLe11HYghN2zeXiLe11HYghN2zeX
					iLe11HYghN2zeXiLe11HYghN2zeXiIe31LYPhI2qeXh9e+s1XPcZ7ueXh0fGt7Wkc07BeXhyfHyoWqf+4ReXhyfHyrWqgA4OeXhyfHyrWqgA4O]],
				["LowerLegF.L"] = [[
					eChIfO7WcGgAwHeAhFfT8kb3gstyd9g9fa+Pa5huo9d7g2fe+4ZziKlJd7g0fe+9ZeiNkLd9g8fb+Yavh1oTeEhOfH6McSfNx+eJhae32TcRdK2ceJhee22L
					ccdJ2meJhee22LccdJ2meJhee22LccdJ2meJhee22LccdJ2meJhee22LccdJ2meJhee22LccdJ2meJhee22LccdJ2meJhee22LccdJ2meJhee22LccdJ2meJ
					hee22LccdJ2meJhee22LccdJ2meJhbe32ScOdD2cd8hffX+ib8h8oad7hUfb+rbbiYneeChIfO7acGgCwBeChIfO7WcGgAwHeChIfO7WcGgAwH]],
				["FootF.L"] = [[
					d+gre9/mgAgAk+d+gre9/mf/gAk+d+gre9/mfRgHk+d+gre9/jeJgTk+d+gre9/hdxgXk9d+gre9/lfHgJk+d+gve7/mf8gBk+d/g6e3/SfMfompeAg9e2/K
					fWfcnNeAg9e2/KfWfcnNeAg9e2/KfWfcnNeAg9e2/KfWfcnNeAg9e2/KfWfcnNeAg9e2/KfWfcnNeAg9e2/KfWfcnNeAg9e2/KfWfcnNeAg9e2/KfWfcnNeA
					g9e2/KfWfcnNeAg9e2/KfWfcnNd/g6e3/ZfHfzmFd+hOe6/mgXf8k+d+hEe9/mf8gBk+d+gre9/mgBgAk+d+gre9/mgAgAk+d+gre9/mgAgAk+]],
				["UpperLegF.R"] = [[
					hphyfHyrpWgA4OhphufMyYpvgd4ThphlfWyxquhR3ihphdfgz9r0h319hphafj0YsMiA1WhphkfXy7q4hY3Whph5fCzXo7fy32hpiIe31Nnuex2phpiLe11H
					ngez2zhpiLe11Hngez2zhpiLe11Hngez2zhpiLe11Hngez2zhpiLe11Hngez2zhpiLe11Hngez2zhpiLe11Hngez2zhpiLe11Hngez2zhpiLe11Hngez2zhp
					iLe11Hngez2zhpiLe11Hngez2zhpiIe31Mnve12qhph9e+u2oziF62hph0fGvYpah86XhphyfHyppWgB4QhphyfHyrpWgA4OhphyfHyrpWgA4O]],
				["LowerLegF.R"] = [[
					h+hIfO7Wj6gAwHiAhFfT8kkJfUtyiDg9fa+PlHeSo9iFg2fe+4mNd2lJiFg0fe+9midzkLiDg8fb+YlReLoTh8hOfH6Mjugzx+h3hae32Tjvi22ch3hee22L
					jki32mh3hee22Ljki32mh3hee22Ljki32mh3hee22Ljki32mh3hee22Ljki32mh3hee22Ljki32mh3hee22Ljki32mh3hee22Ljki32mh3hee22Ljki32mh3
					hee22Ljki32mh3hee22Ljki32mh3hbe32Sjxi62ciChafS9UjQe2sUiDhQfX90j4eUq0h+hIfO7Zj6f/wEh+hIfO7Wj6gAwHh+hIfO7Wj6gAwH]],
				["FootF.R"] = [[
					iCgre9/mgAgAk+iCgre9/mgBgAk+iCgre9/mgvf5k+iCgre9/jh3ftk+iCgre9/hiPfpk9iCgre9/lg5f3k+iCgve7/mgEf/k+iBg6e3/Sg0gYmpiAg9e2/K
					gqgknNiAg9e2/KgqgknNiAg9e2/KgqgknNiAg9e2/KgqgknNiAg9e2/KgqgknNiAg9e2/KgqgknNiAg9e2/KgqgknNiAg9e2/KgqgknNiAg9e2/KgqgknNiA
					g9e2/KgqgknNiAg9e2/KgqgknNiBg6e3/Wg3gSmViChCe6/lfCgKk+iCg6e9/mfhgFk+iCgre9/mf/gAk+iCgre9/mgAgAk+iCgre9/mgAgAk+]],
				Tail1 = [[
					gAijhoiRgAgA/6gAiihrh9gAgA/7gAifhyhPgAgA/9gAich4gigAgA//gAibh5gVgAgA//gAiehyhJgAgA/+gAiihni8fmgB/2gAiihhkNgQgA/tgAihhgkf
					g+gA/qgAihhgkffNgA/qgAihhgkffcgA/qgAihhgkfhFgA/qgAihhgkfgAgA/rgAihhgkfe7gA/qgAihhgkfgkgA/qgAihhgkfgzgA/qgAihhgkffCgA/qgA
					ihhgkffugA/rgAihhgkfhHgA/qgAiihhkOfwgA/tgAiihljTfjgB/0gAijhoicgEgA/5gAijhoiRgAgA/6gAijhoiRgAgA/6gAijhoiRgAgA/6]],
				Tail2 = [[
					gAidiVjEgAgA/2gAiciYiogAgA/4gAibifhmgAgA/8gAibilgmgAgA//gAiaingUgAgA//gAibighcgBgA/9f/iZiTjxfQgE/wgBiWiNlPf6gA/jgDiViMlj
					iFf9/cf+iViMlkfCgC/ff+iViMljebgC/dgDiViMljhyf9/dgAiViMlkgqf//ff9iViMljd4gE/bgCiViMlkgcf//ggCiViMljh5f9/cf9iViMljelgD/ef/
					iViMlje2gC/fgDiViMljiBf8/cf/iWiNlRgGgA/jf/iZiRkOfDgE/sgAiciUjRgFgA/0gAidiVjEgAgA/2gAidiVjEgAgA/2gAidiVjEgAgA/2]],
				Tail3 = [[
					gAiUjCixgAgA/3gAiVjFiNgAgA/6gAiXjMg2gAgA/+gAiZjSfkgAgA//gAiajUfLgAgA/+gAiXjNgpgCgA//f9iPi/jhfIgE/ygAiHi4lLfGgA/jgIiFi2lh
					i6f9/Yf7iFi2lifjgC/gf6iFi2lhdVgC/ZgIiFi2lih2f9/dgCiFi2lihuf//df3iFi2lhdSgD/ZgDiFi2lifsf//ggHiFi2lhi4f9/Yf5iFi2lie0gD/ff8
					iFi2lhdvgC/bgJiFi2lhiXf9/bgAiHi4lNg7gA/jf8iNi9kDeqgF/tgAiTjBi/gCgA/2gAiUjCixgAgA/3gAiUjCixgAgA/3gAiUjCixgAgA/3]],
				Tail4 = [[
					gAiMjuh1gAgA/8gAiPjyhIgAgA/+gAiVj5fdgAgA//gAiaj/d4gAgA/6gAickBdagAgA/4gAiVj6fNgCgA/+f6iFjrinfQgC/4f+h5jjkeeIf+/ngQh2jgk3
					jJgB/df6h2jhk4gigE/nfzh2jgk3cmf9/cgNh2jgk4hPf+/mgHh2jgk3iygE/ffwh2jgk3dVgA/ggCh2jhk4enf8/lgPh2jgk3jZgC/cf2h2jgk4fpgD/nf2
					h2jgk3czf8/dgPh2jgk3iBf//jgCh4jikgh6gD/nf4iCjojPejgD/ygAiKjtiEf9gA/7gAiMjuh1gAgA/8gAiMjuh1gAgA/8gAiMjuh1gAgA/8]],
				Tail5 = [[
					gAiHkbgAgAgA//gAiLkffKgAgA/+gAiWkmdLgAgA/3gAigksbUgAgA/pgAijkuaxgAgA/jgAiYknc5gDgA/1f4h+kYg0fmgA/+f5hskOi5dYfz/wgZhokKjV
					irgI/tf7hokMjWhogN/xfphokKjVcffy/ngQhokLjWgNf7/0gOhokLjVjbgR/ofohokKjVeCf8/wf+hokMjVdmfx/ugZhokKjVjNgM/pf1hokLjWgwgJ/zft
					hokKjVcafw/ngVhokLjWhIf//zgHhskOi8iqgN/vf0h5kUhjexf+/7gAiFkagQf4gA//gAiHkbgAgAgA//gAiHkbgAgAgA//gAiHkbgAgAgA//]],
				["UpperLegB.L"] = [[
					eXhyg+2NU6gA0LeXhwhC2yURfpzIeXhshJ35TCe7w0eXhphR4sSHeUuxeXhohT45R4eKuLeXhshK4CS4e0wfeXhyg71vVagE08eXh1gyzcXyhB4BeXh2gwyk
					YohW49eXh2gwykYohW49eXh2gwykYohW49eXh2gwykYohW49eXh2gwykYohW49eXh2gwykYohW49eXh2gwykYohW49eXh2gwykYohW49eXh2gwykYohW49eX
					h2gwykYohW49eXh2gwykYohW49eXh1gyzXX3hD4HeXh0g41GWFgZ16eXhyg92DVFgD0ceXhyg+2NU6gA0LeXhyg+2NU6gA0LeXhyg+2NU6gA0L]],
				["LowerLegB.L"] = [[
					eChIg1w9dlgA7BeBhIg0wvd4gU7LeAhIg0wzeHg57JeAhJg1xad8hT6ueAhJg2xqd1hZ6jeAhIg0w2eIg97HeChIg0wudmfr7KeGhJg4yab+ed5zeIhJg7zV
					bNeC49eIhJg7zVbNeC49eIhJg7zVbNeC49eIhJg7zVbNeC49eIhJg7zVbNeC49eIhJg7zVbNeC49eIhJg7zVbNeC49eIhJg7zVbNeC49eIhJg7zVbNeC49eI
					hJg7zVbNeC49eIhJg7zVbNeC49eGhJg5ygb5ea5ueDhIg1xFdMfV65eChIg0w8djf67CeChIg1w9dlgA7BeChIg1w9dlgA7BeChIg1w9dlgA7B]],
				["FootB.L"] = [[
					d+grhD/mgAgAk+d+grhD/mgaf8k+d+grhD/lg+f2k+d+grhD/lhIf1k+d+grhD/lhHf1k+d+grhD/lhBf2k+d+grhD/mfzgCk+d+grhD/id4gVk9d+grhC/c
					dEgblId+grhC/cdEgblId+grhC/cdEgblId+grhC/cdEgblId+grhC/cdEgblId+grhC/cdEgblId+grhC/cdEgblId+grhC/cdEgblId+grhC/cdEgblId+
					grhC/cdEgblId+grhC/cdEgblId+grhD/hdzgWk9d+grhD/mfSgHk+d+grhD/mf7gBk+d+grhD/mgAgAk+d+grhD/mgAgAk+d+grhD/mgAgAk+]],
				["UpperLegB.R"] = [[
					hphyg+2NrGgA0LhphwhC2yrvgXzIhphshJ35s+hFw0hphphR4st5hsuxhphohT45uIh2uLhphshK4CtIhMwfhphyg71vqmf808hph1gyzcoOe/4Bhph2gwyk
					nYeq49hph2gwyknYeq49hph2gwyknYeq49hph2gwyknYeq49hph2gwyknYeq49hph2gwyknYeq49hph2gwyknYeq49hph2gwyknYeq49hph2gwyknYeq49hp
					h2gwyknYeq49hph2gwyknYeq49hph1gyzXoJe94Hhph0g41Gp7fn16hphyg92Dq7f90chphyg+2NrGgA0Lhphyg+2NrGgA0Lhphyg+2NrGgA0L]],
				["LowerLegB.R"] = [[
					h+hIg1w9ibgA7Bh/hIg0wviIfs7LiAhIg0wzh5fH7JiAhJg1xaiEet6uiAhJg2xqiLen6jiAhIg0w2h4fD7Hh+hIg0wuiagV7Kh6hJg4yakChj5zh4hJg7zV
					kzh+49h4hJg7zVkzh+49h4hJg7zVkzh+49h4hJg7zVkzh+49h4hJg7zVkzh+49h4hJg7zVkzh+49h4hJg7zVkzh+49h4hJg7zVkzh+49h4hJg7zVkzh+49h4
					hJg7zVkzh+49h4hJg7zVkzh+49h6hJg5ygkHhm5uh9hIg1xFi0gr65h+hIg0w8idgG7Ch+hIg1w9ibgA7Bh+hIg1w9ibgA7Bh+hIg1w9ibgA7B]],
				["FootB.R"] = [[
					iCgrhD/mgAgAk+iCgrhD/mfmgEk+iCgrhD/lfCgKk+iCgrhD/le4gLk+iCgrhD/le5gLk+iCgrhD/le/gKk+iCgrhD/mgNf+k+iCgrhD/iiIfrk9iCgrhC/c
					i8fllIiCgrhC/ci8fllIiCgrhC/ci8fllIiCgrhC/ci8fllIiCgrhC/ci8fllIiCgrhC/ci8fllIiCgrhC/ci8fllIiCgrhC/ci8fllIiCgrhC/ci8fllIiC
					grhC/ci8fllIiCgrhC/ci8fllIiCgrhD/hiNfqk9iCgrhD/mguf5k+iCgrhD/mgFf/k+iCgrhD/mgAgAk+iCgrhD/mgAgAk+iCgrhD/mgAgAk+]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiqg3AFgAgAh/gAiyg3ATgAgdkMgAiqg3AWf/hEkfgAjIg3Aif9hElmgAjgg3Aof9gqmOgAjpg3ArgAgAmagAjgg3AogDfWmOgAjIg3AigDe8lmgAiqg3AW
					gBe8kfgAivg3AZgBfWk0gAiug3AXgAgAkugAjUg3Alf9gql7gAjmg3Arf7hEmWgAjog3Arf7hEmYgAjYg3Amf9gqmCgAi3g3AbgAgAlDgAiug3AYgBfWkugA
					i4g3AegDe8lTgAi1g3AWgBfNkfgAiug3AJgAf2i1gAiqg3AFgAgAh/]],
				Spine1 = [[
					gAiugbAFgAgAh/f/i5gcASgAgdkHf+iygcASf+hEj8f+jRgdAjf9hEluf/jrgdAuf+gqmrgAj0gdAygAgAm9gBjrgdAugCfWmrgCjRgdAjgDe8lugCiygcAS
					gCe8j7gBi4gcAWgCfWkegAi2gcAUgAgAkUf/jegdApf+gqmOf+jxgdAyf8hEm2f+jzgdAyf8hEm6f/jjgdArf+gqmZgAjAgdAZgAgAk3gBi2gcAUgCfWkUgC
					jBgdAegDe8lSgBi8gcAWgBfNkfgAiygcAJgAf2i1gAiugbAFgAgAh/]],
				Spine2 = [[
					gAixf//7gAgAh/f+jAgB//gEfjf7f8i5gB/+gMe9gmf8jbgD/6gLe9eHf+j3gD/0gHfXc0gAkAgE/ygAgAcagCj3gD/0f5gpc0gEjbgD/6f1hDeHgEi5gB/+
					f0hDgngCjAgB//f5gpf1gAi+gB//gAgAgDf+jpgD/4gHfXdaf8j9gE/ygLe9ckf8j/gE/xgLe9cff+jugD/3gHfXdLgAjIgC//gAgAfUgCi+gB//f5gpgDgE
					jKgC/8f1hDergDjEgB/+f5gyffgBi3gA/+f/gKhKgAixf//7gAgAh/]],
				Spine3 = [[
					gAiufj/7gAgAh/f+jBfl//gEfjgAf6i4fl/9gNe9hKf6jffn/6gLe9d/f9j8fo/xgGfWcXgAkGfo/ugAgAb3gDj8fo/xf6gqcXgGjffn/6f1hDd/gGi4fl/9
					fzhDhKgDjAfl//f4gpgLgAi+fl//gAgAgdf9jtfn/2gHfXdHf6kDfo/ugKe9cDf6kFfo/tgKe9b8f9jzfn/0gHfXc0gAjKfl//gAgAfggDi+fl/+f4gpgdgG
					jNfm/8f1hDesgEjFfl/+f5gyffgBi1fk/+f/gKhKgAiufj/7gAgAh/]],
				Neck1 = [[
					gAiqfHAVgAgAkcf9jBfIAdgBgdlQf5i2fJAPf9hEjnf5jifLA2gAhEnIf7kDfMBYgBgqpNgAkOfNBlgAgAp4gFkDfMBYf/fWpNgHjifLA2gAe8nIgHi2fJAP
					gDe8jmgFjAfJAXgBfWklgAi9fJAUgAgAkTf7jyfLBGgAgqoNf5kKfNBhgChEpof5kMfNBkgChEpwf7j5fMBNgBgqomgAjLfJAegAgAlXgFi9fJAUgCfWkTgH
					jPfKAngBe8mDgGjGfJAif/fNlrgBizfHAZf/f2k2gAiqfHAVgAgAkc]],
				Neck2 = [[
					gAi4eWBLgAgAoif7jReYBGgEgdoOf1jBeXAogChEmGf1j4edBngGhEp7f5kfeiCjgGgqscgAksekC5gAgAtQgHkfeiCjf6fWscgLj4edBnf6e8p7gLjBeXAn
					f+e8mFgHjOeYA0f+fWnDgAjKeYAvgAgAmyf5kMefCDgFgqrNf1knejCygKhDs9f1kpekC2gKhDtHf5kTegCPgFgqrsgAjbeZBBgAgAn9gHjKeYAwf+fWmygL
					jiebBMf8e8ofgIjYeZBMf6fNoigCjDeXBLf+f2oigAi4eWBLgAgAoi]],
				Neck3 = [[
					gAjNdzBQgAgAo0f6jld1A4gDgdnYfzjQdxAZf/hEkufzkQd8BVgEhEo/f4k8eFCXgFgqsAgAlKeJCygAgAtBgIk8eFCXf7fWsAgNkQd8BVf8e8o/gNjQdxAY
					gBe8kugIjgdzAigAfWltgAjbdyAfgAgAlbf4kmeABzgEgqqgfzlFeICpgJhDspfzlIeJCugJhDs2f4kveCCAgEgqrFgAjvd1AvgAgAmwgIjbdzAfgAfWlbgN
					j3d4A2f/e8nJgKjtd2A8f8fNnmgCjYd0BJf+f2obgAjNdzBQgAgAo0]],
				Head = [[
					gAjwc7/xgAgAjsf5kDc6/thQfsj/fujkcy/QjBfHmDfvk0dE/zi6fchvf2lqdW/6hufzengAl7dd/5gAgAdjgKlqdW/6eSgNengRk0dE/zdGgkhvgSjjcy/Q
					c/g5mEgLj3c1/geJgglKgAjxc0/hgAgAlef1lPdN/8hxfvgOfvl1db/ziwfvd4fvl5dc/yiwfwdqf1ladQ/8hwfwfmgAkKc5/ugAgAkJgLjxc0/deJghlcgS
					kTc8/odCgtjogNkLc8/td0gijogDj5c7/xfkgHjrgAjwc7/xgAgAjs]],
				Jaw = [[
					gAiydJ/8gAgAh2f+jGdJ/fhRfvlhf7iqdJ+ijFfZpBf6j2dL/fi9fukyf8krdQ/5hvf+hrgAk9dT//gAgAgogEkrdQ/5eRgChrgGj2dL/fdDgSkygFiqdJ+h
					c7gnpCgDi7dJ+4eHgVoKgAi2dJ+2gAgAoef8kRdN/xhyf6jRf6k3dS/2ixgAg7f6k7dS/3ixgBgtf8kbdO/1hxf7iqgAjNdJ/LgAgAnKgDi2dJ+zeGgWobgG
					jXdK/Jc+gampgEjOdJ/cdygalcgBi8dJ/1fkgIjEgAiydJ/8gAgAh2]],
				["UpperLegF.L"] = [[
					eXhyfHyrWqgA4PeUiJfEwoXRds5yeQh9fNzbV8a72yeQiqfDxzYXd75YeSjNe90cY1fh3ieXjae42KYqgf14ecjPe11YXrf+2Sefite2vDWlcx6aeeh/e/s2
					VKYN6EebiJe+txWGad6jeXiFfDwAWacT5ueSi8e/1jYpgI2dePjTe/3eZqg70xePjWe/zgZQfB4beSjCe+wrYdda6HeXiTfAu5W1bB6UebiGe/t9V7ak6aef
					iZe4yNWRex4ZediQe71YWkgw11eYh8fDy/Wtf94AeXhyfHyrWqgA4O]],
				["LowerLegF.L"] = [[
					eChIfO7XcGgAwHd7hjfT+tc7h/oNdyhYfQ+VaQknY/d6iCfQ+8eiiEnueCihfB7CeNe+w+eJise13Kcuco1keLijez2lbrb/13eDiLfI8jbGfhtjd7hnfU+I
					Vdhzgtd8hsfT+1Yvh1kEd7hifT/Ia7iUkzeDiPe+6JdueeyPeFime44Sd5dU0jd+iqfH8sfOgGuId8icfP+ieUhZpTd6hzfU/SaUibijd8hpfT+1Yrh7j7eG
					hxfA6MbDeVxneLhke420awcs1ieDhRfJ6xb9fdxCeChIfO7WcGgAwH]],
				["FootF.L"] = [[
					d+gre9/mgAgAk+d+hRe2/khYfyk+d+hley/jeOgSk+d+hyey/Hi3fYm0d+iCey+oh8fco/d/iMez+KgOfgqqd+iDey+mfBgKpQd+hyey/Pe+gOm1d+hley+z
					Y7hHk2d+hjey/cc4gfk9d+hXey/mfWgHk+d+hvey++hWfqn3d+iFey+ehafgpod+iPey+XjEfCpjd+iJey+ziafXoSd+htey/dehgRlod+hgey/cc1ggk8d+
					hTey/kekgPk+d+hEe1/bdngLlhd+gze7/mfugDk+d+gre9/mgAgAk+]],
				["UpperLegF.R"] = [[
					hphyfHyrpWgA4PhmiJe+y2pbgi4Ehih/e/vOqwjU5yhhite2xUpeh15HhkjPe1vMocjX6phpjae4uwnrj07EhujNe9wmnZio6NhwiqfDzHnghK4ghwh8fNzJ
					o/h/37htiHfHymoyhm4dhpiFfDwApmjt5uhki+e2ugorjz65hhjXeyt5olkS7LhhjaeywGoti56FhkjFe21cohf92KhpiTfAydpDhS4fhtiEfIyDo/iN4vhw
					iXfFycn3hs44huiOfFxOoRiG5khqh7fGxtpEg15ChphyfHyrpWgA4O]],
				["LowerLegF.R"] = [[
					h+hIfO7Xj6gAwHh8hgfF6ykTg4w7iAhefO9ymge7poh6iHfB6ukshgw5h+isfI8yjugmtdiCi3fO+Siyfdp5iEimfO+bhiexpsiDiAfM94hWe5rSiHhUfT/b
					jCdMkSiEhefP+ki5eSo0iFhifT/IlFdskzh/idfL9gkNgBroh8i4fJ8vklhEtPh6i1fC7DkIh3wdh2iYe02skej91wiAhqfJ87jhfrtMiGhdfR/HjSdsmSiF
					htfP+whreFoaiFhnfT+3iTd3n1iBhTfQ8ujYfQtph+hIfO7Wj6gAwH]],
				["FootF.R"] = [[
					iCgre9/mgAgAk+iChCe2/mgmf6k+iChKey/hiRfpk9iChpey/PhCfym2iCiTey+sf2gDpAiCijey+de2gYptiCiTey+mdegvo+iChpey/IdPgnm0iChKey/k
					eagQk+iChMey/keggPk+iChXey/mgqf5k+iCiGey/AgRf8n3iCifey+jgvfxpdiCiYey+ggXf5pmiCh5ey+1hOfuoaiChRey/ffggGloiChPey/lexgMk+iC
					hcey/edPgck9iChWe1/hd0gWk9iCg5e7/mfQgIk+iCgre9/mgAgAk+]],
				Tail1 = [[
					gAijhoiRgAgA/6gBikhnkci9gA/igDibhnktlSgD/MgDi2hlmcicgE/PgCjNhln0eCf++9gAjVhloPbjf7+lf+jNhlnzcuf8+2f9i2hlmdgUgA/Vf9ibhnkv
					jMgC/ef+ighmlEi9gD/cgAifhmlAgAgA/mgCjBhlnGdDf8/DgDjShloGc0f8+ygDjUhkoPfsgA+6gCjFhlnXjSgF+9gAinhmlekdgF/Nf+ifhmk/h+gC/if9
					inhmlkdkf7/af+imhnkvcCf+/Zf/ikhojGe8gD/0gAijhoiRgAgA/6]],
				Tail2 = [[
					gAidiVjEgAgA/2gKiYiSlNkbf4/QgSiPiPlTpmf1+DgKikiOnulegA+kf9i3iMp5dNgE+Sf0i/iKqXXngG9Ff1i3iMpuY4gB9of+ikiPn0fxf//BgGiOiRlc
					mZf5+3gGiSiRlunSf9+ngAiRiSlyh6f//af6itiNova7gC+Wf7i8iLqKYegA9YgCi9iMqgcpf5+BgLixiMpLkHf6+XgMiYiPmToaf9+OgDiRiRlsl2f8+7f2
					iXiQmXeIf//TfziZiQldZogH+3f9ibiUj5d2gK/rgAidiVjEgAgA/2]],
				Tail3 = [[
					gAiUjCixgAgA/3gWiJi7k6knf7/RgriAiykztHf58ygZiPi0nypggJ9if1idiwq7eUgR+BfeikiorZU7gK7xfiieisqYUpf38Cf9iOi3oFdYf4+2gXh/i4lG
					oAf8+jgaiCi2lOragC9bgFiBi8lalUgA/FfsiWixpVapgI+IfnihiqrCU5f775f5ihiurhYkfn85gWiYixp+jAfu+QgjiHiymCrHgB9YgTiBi5lNqKf/94fx
					iGi5mEghgB/afhiKi4lHYbgE+qf3iQjAjlcxgN/ogAiUjCixgAgA/3]],
				Tail4 = [[
					gAiMjuh1gAgA/8gjh8jkkAjfgD/jhNh0jOjzvQgV73gyh7jUnJtogq8CfxiAjTrShIgv95fDiIi/r8T6gO7GfGiEjEqYQ6fX6Of2h4jennZqfg+agthxjdkM
					nugL+wg4h1jWkJujge8LgUhyjkkWphgS+Ofeh9jUpXcQgV+WfLiGjCrXSufv6yfmiEjLrxUZe+7Xgeh+jVqGgMfU+WhAh3jSlTsJgV9HguhzjakGuAga8efy
					h1jjlGkRgN/SfNh8jdkNYof2+1fuiGjripb6gI/ngAiMjuh1gAgA/8]],
				Tail5 = [[
					gAiHkbgAgAgA//gshxkPiNhQgF/5hyhrjliMvthP7whUhqjsl0w+hy6bf1hij0qrk/hy9senhrjSr2UqgZ7deihtjUpxOaeb40fkhkkCmPVeei9hhChmkEie
					lngc/ZhchrjvicwKhc7dgthmkHiftkhL82fUhkj5offbg6+0eshsjUrHSPfe6pfJhojgrPRAd251gehjj5pRcSea+Whfhqjvj1rWg39phShqj1iWwohc7Mf+
					hnkMjNokg5+pe4hxkEieaOfj/Xfih/kWg1bcf4/pgAiHkbgAgAgA//]],
				["UpperLegB.L"] = [[
					eXhyg+2NU6gA0LeXh5g60CYhhB3xeYhxg82eVveW0QeYiOg40DZJgJ3+eXingz0ZX9fc3SeXixgvzoX7f537eXiqgrx7ZFhS5ieXiRgrx9Y2h+5aeXhzgvzk
					WrhF3geXh4gwyiYjhu47eXh2g1z/Xvgr3keXibg1zeZLgX4ceYisg21YXKed2DeYiug11bXDeW18eXifg0zYZMgS4heXh/gzzIYvhH4jeXh2gwygYehq47eX
					iBgsyVY2iR5HeXh9gwyuYhiH4veXh1g61BWYg02FeXhyg+2NU6gA0L]],
				["LowerLegB.L"] = [[
					eChIg1w9dlgA7BeIhMg/0zbXdz3weBhHgzwcfEe07ZeIhhg+0ub4dA31eFh7g2xwdbdv6ZeFiFg0w0dPeF7AeIh+g4ymbdeD5jeJhlg4yrbTep5geEhHgzv4
					cxfW7leIhLg7zUbHea4+eGhJg5ymcQeW5teIhug90Ib0dM4WeCiBgzwjetd47QeCiDgzwTe4d77beIhzg90CbzdI4aeIhSg8z4bXd44ieIhKg7zSbBeY4+eK
					hUg3zDbZe75QeJhQg6zgbJex42eFhJg4yXcbfS58eChIg1w9dlgA7B]],
				["FootB.L"] = [[
					d+grhD/mgAgAk+d+gthC/WdGgTlqd+grhD/mgWf9k+d+hChC/BdDgjnOd+hehD+reugYo/d+hohD+dewgaptd/hghC+XdSgnpseAhHhB+odbgGo4d+grhD/l
					e6gLk+d+gthC/VdOgQlyd+grhD/ieCgUk9d+hPhC+xdIgooOd+hkhD+jf1gDpdd+hnhD+hf/gApmd+hUhC+udFgwoZd+gzhC/RdHgamFd+grhC/bdJgYlReB
					g2hA+qdpfko0eAgxhB/Cdbf5nTd+grhD/lewgNk+d+grhD/mgAgAk+]],
				["UpperLegB.R"] = [[
					hphyg+2NrGgA0Lhph6g0zFnneO4dhphzgvzipTe63ihpiRgrx9nKeC5ahpiqgrx7m7eu5ihpixgvzooFgH37hpingz0ZoDgk3ShoiOg40Dm3f33+hohwg82e
					qShr0Phph2g50Zn1fu3Yhph2g1z/oRfV3khpidgsyLm/eg5Vhpiwgoxam8ee54hpiygoxYm8eh56hpiigsyFm+el5ahph/gzzInRe54jhph1g51Mo2gU2Rho
					h+g50Vmyfi3vhph7g70UnOfP3nhph1g81cptfk1rhphyg+2NrGgA0L]],
				["LowerLegB.R"] = [[
					h+hIg1w9ibgA7Bh3hNg8z4k7hh4hh8hHgzv8jSgr7ih3hlg4yrkthX5gh4h+g4ymkjh95jh7iFg0w0ixh77Ah7h7g2xwiliR6Zh4hhg+0ukIjA31h/hHgzwa
					g7hL7ah5hJg8z0j2iR4uh6hJg5ymjwhq5th3hwg5y4kihy5Xh4iFg3yGkqhu56h4iHg3yDkrhv58h3h2g5yxkih25bh4hSg8z4kpiI4ih8hJg3yNisht6Hh3
					hQg+1Aj8it3ph3hOg/1EkWic3jh8hJg5yljTg150h+hIg1w9ibgA7B]],
				["FootB.R"] = [[
					iCgrhD/mgAgAk+iBguhC/Riwf2mKiCgrhD/lhIf1k+iAhHhB+oilf6o4iBhghC+XiufZpsiChohD+dhQfmptiChehD+rhSfoo/iChChC/Bi9fdnOiCgrhD/m
					fpgEk+iCgrhD/giYfok9iCgrhD/ih+fsk9iBhShB+giofrpRiBhnhC+MitfXqNiBhphC+LiufVqQiBhXhB+ciqflpdiCgzhC/Ri5fmmFiCgrhD/lhNf0k+iA
					gxhC/DingHnNiBgvhC/Pizf4mUiCgrhD/lhHf1k+iCgrhD/mgAgAk+]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiqg3AFgAgAh/gAiqhGAJgAgAi4gAiqhTAOgAgAjqgAiqhRAOgAgAjjgAiqhNAMgAgAjRgAiqhHALf+e3i7gAiqhCAKf8ebiogAiqhAAIf9fKifgAiqg/AH
					gAgAicgAirg8AGf1gKiPgAi9g4AMdbgKiDgAjcg3A4Y6gch8gAj4g3CnTjgyh1gAkIg3FFO3hEhrgAkPg3HNL6hQhjgAkRg3H6LEhThggAkPg3HSLzhRhigA
					kOg3GwMehOhlgAkPg3HOL4hQhjgAkRg3H4LFhThggAkRg3H6LEhThggAkRg3H6LEhThggAkRg3H6LEhThggAkRg3H6LEhThggAkRg3H6LEhThg]],
				Spine1 = [[
					gAiugbAFgAgAh/gAivgqAJgAgAi4gAiwg4AOgAgAjqgAiwg2AOgAgAjjgAiwgxAMgAgAjRgCivgrALf+e3i7gDivgmAKf8ebiogBiugkAIf9fKifgAiugjAH
					gAgAicgAivggAGf0gJiPf/jAgcAMdbgEiDf+jfgbA4Y5gMiAf9j7gbCoThgWiBf9kKgbFGO1ghiCf9kQgbHPL4gpiDf9kRgbH8LCgriDf9kQgbHVLxgpiDf9
					kOgbGyMcgniDf9kQgbHQL2gpiDf9kRgbH7LDgriDf9kRgbH9LCgriDf9kRgbH9LCgriDf9kRgbH9LCgriDf9kRgbH9LCgriDf9kRgbH9LCgriD]],
				Spine2 = [[
					gAixf//7gAgAh/gAi0gP/+gAgAhGgAi3gc//gAgAgUgAi2ga//gAgAgcgAi1gV/+gAgAgtgEi0gQ/9f5hJhDgGizgL/7f4hlhWgDizgI/8f8g2hfgAizgH/9
					gAgAhjf/izgE/8gNf5hvf/jEgA/1ikgWh6f9jif//InEg9h1f8j+f/9asahphef6kMf/69xEiMg+f5kSf/410Aifgjf5kTf/4J01ikgaf5kSf/4w0Giggif6
					kRf/5Szcicgof5kSf/400Bifgif5kTf/4K00ikgaf5kTf/4I01ikgaf5kTf/4I01ikgaf5kTf/4I01ikgaf5kTf/4I01ikgaf5kTf/4I01ikga]],
				Spine3 = [[
					gAiufj/7gAgAh/gAiyfz/+gAgAhGgAi2gA//gAgAgUgAi2f+//gAgAgcgAi0f5/+gAgAgtgGiyf0/9f5hJhDgIixfv/7f4hlhWgEiwfs/8f8g2hfgAiwfr/9
					gAgAhjf/iwfo/8gNf5hvgAjBfk/1ijgch6gAjffj/InDhNhxf/j8fj9ZsXiEhSf+kNfj68xAivgnf9kUfj41z7jGgCf9kVfj4I0wjMf3f9kUfj4v0CjHgBf+
					kSfj5RzXjCgKf9kUfj40z9jHgCf9kVfj4J0vjMf3f9kVfj4I0xjMf3f9kVfj4I0xjMf3f9kVfj4I0xjMf3f9kVfj4I0xjMf3f9kVfj4I0xjMf3]],
				Neck1 = [[
					gAiqfHAVgAgAkcgAiwfWAogAgAmNgAi2fkA+gAgAnugAi1fiA6gAgAnggAizfdAygAgAm9gIixfXAqf2e3mSgLivfTAkfyecltgGiufQAgf4fKlcgAitfPAd
					gAgAlUf/itfLAZf1gKk7gBi9fIAcdcgPkdgCjdfHBGY6gmkKgDj8fHC0Tkg+j6gDkOfIFQO6hSjqgCkXfIHXL+hejggBkZfIIELJhhjdgCkXfIHdL3hfjggC
					kVfIG7MihcjigCkXfIHYL8hejggBkZfIIDLKhhjdgBkZfIIELIhhjdgBkZfIIELIhhjdgBkZfIIELIhhjdgBkZfIIELIhhjdgBkZfIIELIhhjd]],
				Neck2 = [[
					gAi4eWBLgAgAoigAjEenCAgAgArFgAjOe3C5gAgAtQgAjMe0CwgAgAs8gAjJevCbgAgAsLgLjEeoCEfqe6rNgQjAejByfjefqYgJi/egBofxfMp/gAi+efBk
					gAgAp0f/i9ebBYf3gMpQf/jLeXBRdigtogf+jpeWB0ZKh3n0f8kGeWDXT+jHm+f5kWeWFoPbkDmCf3kdeWHmMjkllUf2keeWIQLvktlGf3kdeWHrMckmlSf4
					kbeWHMNGkeldf3kdeWHnMhkllTf2keeWIPLwktlGf2keeWIQLuktlFf2keeWIQLuktlFf2keeWIQLuktlFf2keeWIQLuktlFf2keeWIQLuktlF]],
				Neck3 = [[
					gAjNdzBQgAgAo0gAjeeICbgAgAsMgAjsecDxgAgAvBgAjqeZDjgAgAungAjleSDDgAgAtngOjfeKChfoe7sWgTjaeDCHfgegrQgKjXd/B5fvfMqwgAjWd9Bz
					gAgAqhf+jTd5Bjf3gNpxf8jgd0BWdlg4ovf1j7dyByZSiSnwfukTdyDPUMjumifpkddyFYPtkvlKfmkgdxHRM3lPkJflkgdxH4MDlWj1fmkgdxHVMwlQkGfm
					kgdxG3NalJkWfmkgdxHSM1lPkIflkgdxH3MElWj1flkgdxH5MDlWj1flkgdxH5MDlWj1flkgdxH5MDlWj1flkgdxH5MDlWj1flkgdxH5MDlWj1]],
				Head = [[
					gAjwc7/xgAgAjsgAkNdZ/9gAgAepgAkjd3/dgAgAaPgAkgdy/lgBgAa4gAkYdo/ygAgAccgRkOdc/6eigueVgYkFdS/5d5hGf7gNkBdM/9e2gngygAj/dK/+
					gAgAhLf9j6dD/6gZf4iTf1kCc8/qinf4j0flkXc5+ynHf5lCfWklc382sVgQmOfOklc26Pwwg+nUfLkgc14DzdhroAfLkfc13V0Nh7oMfLkgc139zjhtoCfL
					khc14gy8hhn4fLkgc14BzehsoAfLkfc13W0Mh6oMfLkfc13V0Nh7oMfLkfc13V0Nh7oMfLkfc13V0Nh7oMfLkfc13V0Nh7oMfLkfc13V0Nh7oM]],
				Jaw = [[
					gAiydJ/8gAgAh2gAjOdT//gAgAfegAjodg/4gAgAdZgAjkde/6gBgAdsgAjbdZ/9gAgAecgMjQdU/8eggrfTgQjGdR/5d4hGgBgIjCdP/9e3gogegAjAdO//
					gAgAgqf/i7dM/9gZf3hQgAjGdL/ximfyiqgBjhdL+2nHfzkngCj+dN8usVghm0gDkPdP50wrh3osgDkYdQ3YzRjJpygDkadR2lz+jkqFgDkYdQ3RzXjMp1gD
					kWdQ34yyi3plgDkYdQ3WzSjJpzgDkadR2mz9jjqEgDkadR2kz/jkqFgDkadR2kz/jkqFgDkadR2kz/jkqFgDkadR2kz/jkqFgDkadR2kz/jkqF]],
				["UpperLegF.L"] = [[
					eXhyfHyrWqgA4OeXh4fT0AWrff3JeXh+fe1HWufC2JeXh9fc09WtfG2TeXh7fZ0kWsfQ2qefh5fN0DV0gI2wejh3fGznVfgj2+edh2fJzbWCgN3XeXh1fNzW
					Wrfv3teXh0fLzFW3f83/eih1fGzDX9iR4Te8h9fCzOaMmZ4EfjiKe+zMc0rU2vgKiYe7y3fGvn0kgjime4yfgkyTyngqire3yXg/zDx9gkime4yegnyZyige
					ije5ykgSxyzCgjime4yfglyUymgqire3yXg+zCx+gqire3yXg/zDx8gqire3yXg/zDx8gqire3yXg/zDx8gqire3yXg/zDx8gqire3yXg/zDx8]],
				["LowerLegF.L"] = [[
					eChIfO7WcGgAwHeChOfW8NcGfyukeChTfc85cHfmtLeChTfb8ycHfntYeChRfZ8jcHfst4eKhPfN8PbigwuVeNhNfI78bThNuyeIhLfM72brgmvIeChLfS7y
					cGf5vWeChJfR7ncUf8vueUhJfO7deKhmwOe7hOfM7GhwkiwTfwhefL6El+oHvlgjhzfJ4gpprVuMhDiHfI3Jr+tYs3hMiOfH2ssot+sahFiIfI3GsDtdszg9
					iCfI3crhs/tJhEiHfI3Ir/tZs2hMiOfI2tsnt9sbhMiOfH2ssot+sZhMiOfH2ssot+sZhMiOfH2ssot+sZhMiOfH2ssot+sZhMiOfH2ssot+sZ]],
				["FootF.L"] = [[
					d+gre9/mgAgAk+d+gyfC/1gAgAjNd+g6fG/8gAgAhpd+g5fF/7gAgAh4d+g2fE/5gAgAibeHgze5/0f1hIjHeLgxe0/vfwhkjseEgve5/uf4g2j+d+gue//u
					gAgAkGd+gtfA/rgNf6kgeVgre+/diggtlMfFgye9+qm2iGlsgFhGe983r6j7lvg/hje96bwRlslWhih+e94Xy9m4k0hsiHe93szunOknhkh/e94RzDm7kyhc
					h4e94yycmpk8hjh+e94Wy/m5k0hsiHe93tztnNkohsiHe93rzunOknhsiHe93rzunOknhsiHe93rzunOknhsiHe93rzunOknhsiHe93rzunOkn]],
				["UpperLegF.R"] = [[
					hphyfHyrpWgA4Ohph4fT0ApVgh3Jhph+fe1HpSg+2Jhph9fc09pTg62Thph7fZ0kpUgw2qhxh4fc0DodhO3ah0h2fbznoIhT35hvh1fUzbosgz33hph1fNzW
					pVgR3thph2fKy/pigN36hyiXfKxrqliE4Zh5jYfMvdsels4bh0kgfRsmuQqN3nhilVfVp0vXuT2EhOlxfXn4vzw+0lhHl4fYnUv5xv0EhNlyfYn0v0xE0hhS
					lsfXoRvvwd05hOlxfXn3v0w/0khHl4fYnVv5xu0FhHl4fYnTv5xv0EhHl4fYnTv5xv0EhHl4fYnTv5xv0EhHl4fYnTv5xv0EhHl4fYnTv5xv0E]],
				["LowerLegF.R"] = [[
					h+hIfO7Wj6gAwHh+hOfW8Nj6gOukh+hTfc85j5gatLh+hTfb8yj5gYtYh+hRfZ8jj5gUt4iFhOff8PjVhNuniIhMfg78jHhhvLiEhLfZ72jfg2vWh+hLfS7y
					j6gHvWh+hMfP7kkIgDvsiNhxfS65l8hjwNiei7fX5hpakTwSigkSff3UtTnuvniOlVfl0uwgqzuVh5l7fqysybsytGhxmFfryDy8tWsrh4l8fqynyfs2tDh+
					l0fpzGyDsZtXh4l7fqyrybsztGhxmEfryEy7tVsshxmFfryCy8tWsrhxmFfryCy8tWsrhxmFfryCy8tWsrhxmFfryCy8tWsrhxmFfryCy8tWsr]],
				["FootF.R"] = [[
					iCgre9/mgAgAk+iCgyfC/1gAgAjNiCg6fG/8gAgAhpiCg5fF/7gAgAh4iCg2fE/5gAgAibiLgyfL/0f1hIjHiOgwfO/vfwhkjsiJgvfH/uf4g2j+iCgue//u
					gAgAkGiDgwe+/rgNf6kgiWhVfC/eiggtlFiviifI+tm3iBlYi5kAfR89r+julOitlNfZ6jwZlSkriZl6fe4fzKmTkFiRmGfg30z8mmj4iYl8fe4azQmWkEid
					lyfd47yomHkOiYl7fe4ezLmUkFiRmGfg31z6mmj4iRmGfg30z8mmj3iRmGfg30z8mmj3iRmGfg30z8mmj3iRmGfg30z8mmj3iRmGfg30z8mmj3]],
				Tail1 = [[
					gAijhoiRgAgA/6gAigh3jKgAgA/1gAieiDj8gAgA/vgAieiBj0gBgA/wgAifh9jjgAgA/yf8igh3jMeGgF/xf7ihhzi6dYgJ/wf9ihhxixemgF/1gAiihwit
					gAgA/4gBikhsihgQgL/5gBi2hpiWgUik/zgDjVhoiOg3nE/HgFjzhoh/hhsa9YgGkFhohoiFxE67gHkNhohTib0A40gHkQhohMig014HgHkOhohSib0H4ugH
					kMhohYiXzc5QgHkNhohTib0B4zgHkQhohMig004IgHkQhohMih024HgHkQhohMih024HgHkQhohMih024HgHkQhohMih024HgHkQhohMih024H]],
				Tail2 = [[
					gAidiVjEgAgA/2gAiXijj9gAgA/vgAiTivkvgAgA/ogAiUitkngBgA/qgAiVipkWgAgA/sf3iXijj/dWgL/of0iZifjscVgS/kf5iaidjkeCgK/ugAiaicjh
					gAgA/zgBidiZjVgXgK/0gDiviWjKggij/ugHjQiVjAhanA/CgLjwiVioiesS9UgOkEiViBjXw564gOkPiVhdj6zz4ygOkSiVhSkD0n4GgOkPiVhcj7z54sgO
					kNiVhljzzP5OgOkPiVhdj6z04wgOkSiVhSkD0m4HgOkSiVhRkD0o4FgOkSiVhRkD0o4FgOkSiVhRkD0o4FgOkSiVhRkD0o4FgOkSiVhRkD0o4F]],
				Tail3 = [[
					gAiUjCixgAgA/3gAiMjPjqgAgA/ygAiGjbkcgAgA/rgAiHjZkUgBgA/sgAiJjVkDgAgA/vfwiMjPjrclgN/mfqiOjJjYbSgU/df0iQjJjRdegL/ugAiQjIjN
					gAgA/1gCiTjFjBgegK/2gFinjCi4gnii/wgNjIjBiuhsm//DgUjsjBiQi/sP9UgZkFjBhekEw063gakSjBgxkszr4xgZkWjBgik30f4FgakTjBgvkuzy4rga
					kQjBg6klzI5NgakTjBgwktzt4wgZkWjBgik30e4GgZkWjBghk30g4EgZkWjBghk30g4EgZkWjBghk30g4EgZkWjBghk30g4EgZkWjBghk30g4E]],
				Tail4 = [[
					gAiMjuh1gAgA/8gAiCj7iugAgA/4gAh5kGjfgAgA/zgAh7kEjYgCgA/0gAh+kBjGgAgA/1fmiCj6ivb0gH/mfdiFj0ibaPgO/XftiGj0iUc6gI/wgAiHj1iR
					gAgA/6gEiLjyiFgkgK/6gHifjvh9gqij/0gTjCjuh0h2nA/GgfjpjthSjQsR9VglkHjtgYkbw162glkZjsfklGzq4tglkejsfTlR0d4AglkajsfilHzx4ogl
					kWjsfvk+zI5KglkZjsfklGzs4sglkejsfTlR0c4BglkejsfSlR0e4AglkejsfSlR0e4AglkejsfSlR0e4AglkejsfSlR0e4AglkejsfSlR0e4A]],
				Tail5 = [[
					gAiHkbgAgAgA//gAh6kog5gAgA/+gAhvkyhrgAgA/8gAhxkxhkgCgA/9gAh1kthSgAgA/9fbh6klg7bEf3/mfNh+kdgoZMf3/QfkiAkgggcWf8/xgAiBkigc
					gAgA//gFiFkfgRgqgM/+gJiZkcgLgpil/4gZi+kagChznG/JgojpkZfgjLsa9TgwkNkYekkUw/6ugwkjkXdtk8z04hgvkpkXdalG0m3zgvkkkXdqk9z64bgw
					kekXd4k1zR4/gwkjkXdsk8z14ggvkpkXdblG0l30gvkpkXdalG0n3ygvkpkXdalG0n3ygvkpkXdalG0n3ygvkpkXdalG0n3ygvkpkXdalG0n3y]],
				["UpperLegB.L"] = [[
					eXhyg+2NU6gA0LeXhyhK3TU7fYy6eXhyhU4MU+e2xweXhyhT4EU9e7x7eXhyhP3vU8fHyVeXhyhD3VUNgJyceXhyg82+T7gqyseXhyg/20UYgPzKeXhyhE2w
					U6fszjeYhyhD2nVIf1z2ehh1g/3dWwhXzpe6h8g+5DaWjtytffiGg+6UfJmMxGgGiRg+6nj5oHvTghicg+6TnMpMt+gpihg+6IoLpftkgiidg+6SnUpPt7gc
					iag+6ZmipAuPghidg+6TnOpNt9gpihg+6IoJpetlgpihg+6IoMpftkgpihg+6IoMpftkgpihg+6IoMpftkgpihg+6IoMpftkgpihg+6IoMpftk]],
				["LowerLegB.L"] = [[
					eChIg1w9dlgA7BeChJg8ycdlf36CeChLhCzsdmfw5GeChKhBzgdmfx5PeChKg/zEdlf05keDhKgzygcnge54eDhJgtyBcQgv6KeChJgyxzc3gY6ZeChIg4xt
					dlf86ieDhIg4xbdzgD6veThIgzxhe/iI6qe4hOgwx7hnlz5zfthbgtx/lAqA3+gghugqxcoPti1ohBiAgpwuqcvrzuhKiHgowcrGwRzHhCiBgpwsqivwzpg7
					h8gpw4qBvR0IhBiAgpwtqdvszthKiHgowdrFwQzIhLiHgowcrGwRzHhLiHgowcrGwRzHhLiHgowcrGwRzHhLiHgowcrGwRzHhLiHgowcrGwRzH]],
				["FootB.L"] = [[
					d+grhD/mgAgAk+d+gqhG/1gAgAjNd+grhK/8gAgAhpd+grhJ/7gAgAh4d+gqhI/5gAgAibd+grg9/0f1hIjHd+grg4/vfwhkjsd9gqg+/uf4g2j+d+gqhE/u
					gAgAkGd/gqhF/rgNf5kdeUgqhB/kijgYkefCgxg8+9nEg4j1gAhDg49UsbhOi3g7hdgz66xIhQh+hfh2gw400HhJhahph+gw4H09hFhPhgh3gw4u0OhIhYhY
					hwgx5QzihLhhhfh2gw4z0IhIhZhph+gw4I07hFhQhph+gw4H09hFhPhph+gw4H09hFhPhph+gw4H09hFhPhph+gw4H09hFhPhph+gw4H09hFhP]],
				["UpperLegB.R"] = [[
					hphyg+2NrGgA0LhphyhK3TrFgoy6hphyhU4MrChKxwhphyhT4ErDhFx7hphyhP3vrEg5yVhohxhS3VqWhczOhohxhR2+qFhjzyhphyhL20qkg8zwhphyhE2w
					rGgUzjhqh1hB2erUgNzwhxiWg/1js4hyzvh3jXg+z2v6ksy1hxkdg+xOzVn9xBhflQg+uN2Jqlu0hNlqg+r23zsFtEhGlxg+rG4QsesghMlrg+rw33sIs/hR
					llg+sV3grztbhMlqg+r030sFtDhGlxg+rH4PseshhGlxg+rF4QsfsghGlxg+rF4QsfsghGlxg+rF4QsfsghGlxg+rF4QsfsghGlxg+rF4Qsfsg]],
				["LowerLegB.R"] = [[
					h+hIg1w9ibgA7Bh+hJg8ycibgJ6Ch+hLhCzsiagQ5Gh+hKhBzgibgP5Ph+hKg/zEibgM5kh+hJhFyghdgw6Dh+hIhGyBhFg86Zh+hIg/xzhtgi6hh+hIg4xt
					ibgE6ih/hLg1xYipgI6uiMhxg0xCjziM6uici7gywmmRl+58idkQgvvrpRqX4LiMlSgtuTr+uF12h3l2gstFtuwXz6hwmAgssruNw/zSh2l4gstCtywcz1h8
					lwgstWtYv70Uh3l3gstFtvwYz5hwmAgsssuNw+zThwmAgssruOxAzShwmAgssruOxAzShwmAgssruOxAzShwmAgssruOxAzShwmAgssruOxAzS]],
				["FootB.R"] = [[
					iCgrhD/mgAgAk+iCgqhG/1gAgAjNiCgrhK/8gAgAhpiCgrhJ/7gAgAh4iCgqhI/5gAgAibiBgqhQ/0f1hIjHiBgqhS/vfwhkjsiCgqhM/uf4g2j+iCgqhE/u
					gAgAkGiEgthC/rgNf5kdiVhUhB/jijgYklitihg++6nDg8kJi2j9g79QsahcjYiqlJg462xGhsipiWl0g24w0EhviJiPmAg14E06hviAiWl2g24r0LhviIib
					lsg25NzghviPiWl0g24v0GhviJiPmAg14F04hviAiPmAg14E06hviAiPmAg14E06hviAiPmAg14E06hviAiPmAg14E06hviAiPmAg14E06hviA]],
			},
		},
	},
}
