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
					gAjKhDAJgAgAi4gAjKhDAJgAgDi4gAjLhDAJgBgFi4gAjLhDAJgBgIi4gAjLhDAJgBgKi4gAjMhDAKgCgNi9gAjNhDALgCgOjLgAjOhDANgCgQjdgAjOhDAO
					gCgRjpgAjOhDAPgCgSjtgAjOhDAPgCgSjtgAjNhDAPgCgSjtgAjNhDAPgCgRjtgAjNhDAPgCgQjtgAjMhDAPgCgOjtgAjMhDAPgBgNjtgAjMhDAPgBgKjtgA
					jNhDAPgBgIjtgAjNhDAPgBgFjtgAjNhDAPgAgDjtgAjLhDAPgAgAjtgAjOhDAPgAf9jtgAjPhDAPf/f7jtgAjNhDAPf/f4jtgAjPhDAPf/f2jtgAjPhDAPf/
					fzjtgAjOhDAPf+fyjtgAjOhDAPf+fwjrgAjOhDANf+fvjggAjMhDAMf+fvjSgAjLhDALf+fujJgAjLhDALf+fvjIgAjKhDALf+fvjIgAjKhDALf+fwjIgAjK
					hDALf+fyjIgAjKhDALf+fzjIgAjKhDALf/f2jIgAjKhDALf/f4jFgAjKhDAKf/f7jAgAjKhDAJgAf9i6]],
				Spine1 = [[
					gAjQghAJgAgAi4gAjRghAKgAgDi8gAjRghAKgBgFjAgAjSghAKgBgIjDgAjSghALgCgKjFgAjSghALgCgMjLgAjUghANgCgOjZf/jVghAOgCgQjof/jWghAP
					gCgRjyf/jWghAPgCgSjxf/jWghAPgCgSjtf/jVghAOgCgSjpf/jVghAOgCgRjlf/jVghAOgCgQjigAjUghANgCgOjggAjUghANgBgNjfgAjUghANgBgKjggA
					jVghANgBgIjigAjVghAOgBgFjlgAjVghAOgAgDjpgAjTghAPgAgAjtgAjWghAPgAf9jxgAjXghAQf/f7j1gAjVghAQf/f4j5gAjXghAQf/f2j7gAjXghARf+
					fzj7gAjWghAQf+fyj7gBjWghAQf+fwj2gBjVghAOf+fvjogBjTghAMf+fvjWgBjSghALf+fujJgBjRghAKf+fvjDgBjRghAKf+fvi/gBjRghAKf+fwi8gAjR
					ghAKf+fyi6gAjQghAJf+fzi5gAjRghAKf/f2i6gAjRghAJf/f4i6gAjQghAJf/f7i3gAjQghAJgAf9i2]],
				Spine2 = [[
					gAjXf+gAACg2gAgAjXf+gAABgtgDgAjYf+gAABglgGf/jYf+gAABgegIf/jYf+gAABgagKf/jZf+gAABgTgNf/jbf+gAABgHgOf/jdf/gAABf5gQf/jff/gA
					ABfzgRf/jff/gAABf3gSf/jef/gAABgAgSf/jdf/gAABgJgSf/jdf/gAABgRgRf/jcf/gAABgXgQf/jcf/gAABgbgOf/jcf/gAABgdgNf/jcf/gAABgbgKf/
					jcf/gAABgXgIgAjdf/gAABgRgGgAjdf/gAABgJgDgAjbf/gAABgAgAgAjef/gAABf3f9gAjff/gAABfvf6gBjdf/gAABfpf4gBjff/gAABflf2gBjgf/gAAB
					fjfzgBjef/gAABflfygBjef/gAABfrfwgBjdf/gAABf8fvgBjbf+gAABgSfugBjZf+gAABglfugBjYf+gAACgufugBjYf+gAACg2fvgBjXf+gAACg9fwgBjX
					f+gAAChBfygBjXf+gAAChCfzgBjXf+gAAChBf2gBjXf+gAACg/f4gAjXf+gAACg+f6gAjWf+gAACg8f9]],
				Spine3 = [[
					gAjVffgA/+fKgAgAjWffgA//fYf9f/jXffgA//fkf6f/jXffgA//ftf4f/jYffgA//fzf2f/jZffgB//f7fzf/jbffgB//gHfyf+jdffgA//gSfwf+jffggA
					//gWfvf+jffggA//gNfuf+jefggA//gAfuf+jdfggA//fzfuf+jcfggA//fnfvf+jcfggA//fdfwf/jbffgA//fXfyf/jbffgA//fVfzf/jbffgA//fXf2f/
					jcfggA//fdf4f/jcfggA//fnf6gAjdfggA//fzf9gAjbfggA//gAgAgAjffggA//gNgDgBjgfggA//gZgGgBjefggA//gjgIgBjgfggA//gpgKgBjhfggA//
					grgNgBjffggA//gpgOgCjffggA//ghgQgCjdffgA//gMgRgCjaffgA//fygSgCjYffgA//fbgSgCjXffgA/+fNgSgCjWffgA/+fBgRgCjVffgA/+e4gQgBjV
					ffgA/9eygOgBjVffgA/9ewgNgBjVffgA/9eygKgBjVffgA/+e1gIgBjVffgA/+e5gGgAjUffgA/+fAgD]],
				Neck1 = [[
					gAjTfACUgAgAr5gAjVfACWgBgDr/f/jWfACYgCgFsEf/jXfACagDgHsJf/jXfACbgFgJsMf+jZfAChgFgLsaf+jbfACwgGgNs7f+jefADBgHgOthf+jgfADN
					gHgPt7f+jffADPgIgQt+f+jefADMgIgQt4f+jdfADJgIgQtyf+jcfADGgHgPttf+jbfADEgHgOtpf+jafADDgGgNtmf+jafADDgFgLtlf/jafADDgEgKtmf/
					jbfADEgDgHtpf/jcfADGgCgFttgAjdfADJgBgDtygAjbfADMgAgAt4gAjffADPf/f9t+gBjgfADRf+f7uEgBjffBDTf8f5uIgBjhfBDVf7f3uLgCjifBDVf6
					f1uMgCjgfBDVf6fzuLgCjgfBDRf3fquDgCjefADEfrfGtlgCjafACzfeejs9gCjXfACnfbecshgCjVfACkfbecsYgCjUfAChfbedsTgCjTfACffbeesOgCjT
					fACefbefsMgCjSfACefcehsLgBjTfACefdejsMgBjTfACcfiexsJgBjSfACXfufRsAgAjTfACUf6fxr4]],
				Neck2 = [[
					gAj8eVESgAgAv9gAj+eVESgCgCv9f/j/eVESgDgFv9f/kAeWESgEgHv9f+kBeWESgGgJv9f+kDeWEegHgLwRf+kHeYE9gIgMxFf9kLeaFlgJgNyBf9kOecGE
					gKgOyuf9kOecGNgKgOy6f9kMecGNgLgOy6f9kLebGNgKgOy6f9kJebGNgKgOy6f9kIebGNgJgNy6f+kHebGNgJgMy6f+kHebGNgHgKy6f+kHebGNgGgIy6f/
					kIebGNgFgHy6f/kJebGNgDgEy6gAkLebGNgCgCy6gAkKecGNgAgAy6gAkOecGNf+f+y6gBkPecGNf9f8y6gBkOecGNf7f5y6gCkQedGNf6f4y6gCkRedGNf5
					f2y6gCkPedGNf3f0y6gDkPecGIfxflyzgFkLebFwfTegyMgGkGeZFTeyddxYgHkBeXE/eqdQw2gHj/eXE9epdRwzgHj+eXE9epdSwzgGj9eWE9epdTwzgGj8
					eWE9eqdUwzgGj8eWE9erdWwzgGj8eWE8esdXwzgFj8eWE1e5dxwsgDj8eVElfVeswZgBj7eVEXfzfmwG]],
				Neck3 = [[
					gAkrd6EcgAgAwOf/ksd6EYgCgCwIf/ktd7EVgDgFwDf+kvd7ETgEgHv/f+kvd7ERgGgJv8f+kyd9EhgHgLwXf9k3eBFOgIgMxff9k9eHGIgKgNyzf9lBeLG4
					gLgNzzf9lBeMHJgLgO0If9k/eLHNgLgO0Nf9k+eLHRgLgO0Sf9k8eLHVgLgN0Xf9k7eLHYgKgM0af9k7eKHagJgL0df+k6eKHbgIgK0df+k7eKHagHgI0df/
					k7eLHYgFgG0af/k8eLHVgEgE0Xf/k+eLHRgCgC0SgAk9eLHNgAgA0NgBlBeMHJf+f+0IgBlCeMHFf9f80DgBlBeMHCf7f6z/gClEeMHAf5f4z9gClEeNHAf4
					f2z8gDlCeMHAf3f1z9gElCeMG7fuffz2gHk9eIGcfEd3zFgLk3eDF5eXcRyBgMkxeAFheKb+xZgMkweAFieJb/xagMkud/FleJcAxfgMktd/FoeJcBxjgLks
					d/FpeJcCxlgLksd/FqeKcExmgLksd/FpeMcGxmgJksd+FbedcrxagFkrd8E/fFeCw+gCkqd6Emfufawf]],
				Head = [[
					gAlwdT/5gAgAicf/lydT/5gAf9ijf/lzdT/4gAf6iof+l0dT/4gAf4itf+l0dT/3gAf2iwf9l4dX/7gAfziCf9mAdh//gAfygHf9mJdu/6f/fwdxf9mPd4/v
					f+fvb/f9mPd7/qf9fvbaf9mOd7/pf9fubUf9mMd7/of9fvbNf9mLd8/nf9fvbHf9mKd8/mf+fwbDf9mJd8/mf+fybAf+mJd8/mf+f0a/f+mJd8/mf+f2bAf+
					mKd8/mf/f4bDf/mLd8/nf/f7bHf/mMd7/ogAf9bPgAmLd7/ugAgAb3gBmPd7/qgAgDbdgBmQd7/rgBgFbhgCmPd7/wgBgIcFgCmRd7/tgBgKbugCmSd7/sgC
					gNbpgDmQd7/vgCgOb/gFmPd5/vf+g3cDgNmKdy/oftj3dSgWmBdo/Pflm1fOgYl6di/HfqnbgYgYl5dh/HfrnagZgXl3di/HfrnagTgXl2di/HfrnZgOgXl2
					di/IfrnYgLgWl2di/IfrnWgKgWl2di/JfrnUgLgTl1df/XfwmPgfgLlzda/wf5jrhOgElwdV/6f/hGiC]],
				Jaw = [[
					gAkkdA/7gAgAh+f/kldA/7gAf9iFf/kmdB/6gAf6iLf+kndB/6gAf4iQf9kodB/6gAf2iTf9ksdB/9gAfzhaf8k4dD/+f/fyfCf8lGdG/wf+fwcKf8lQdI/a
					f9fvZ/f8lSdJ/Sf8fvZUf8lRdJ/Qf8fvZNf8lQdJ/Pf8fvZHf8lPdJ/Of8fvZBf8lOdI/Nf8fwY8f8lOdI/Mf9fyY5f9lNdI/Mf9f0Y4f9lOdI/Mf+f2Y5f+
					lOdI/Nf+f4Y8f/lPdJ/Of/f7ZBf/lQdJ/Pf/f9ZJgAlNdL/YgAgAZwgBlSdJ/SgBgDZWgBlTdJ/TgBgFZagClQdM/agCgIZ+gDlUdK/WgCgKZngDlVdK/VgD
					gMZigElSdL/ZgDgOZ4gHlRdK/agBg3aAgVlIdI/cf6j4blgik6dJ/Lf3m2d9gkkxdI/Hf4nbfagkkvdI/Hf5nbfdgjkudH/Hf5nafXgjktdH/Hf5nZfSgjkt
					dH/Hf5nYfPgiktdH/If5nWfOgiktdH/If5nUfPgdksdF/Xf7mQfngRkodC/xf+jsghgFkldA/8gAhGhf]],
				["UpperLegF.L"] = [[
					eXiEfGwQfBf47ieXiFfGwYfGf67deXiGfFwgfLf87ZeWiHfFwofPf+7UeWiIfEwufTf/7ReWiJfEw+fWgB7HeViLfDxifagD6weViOfDyPfdgG6ReViQfDyw
					ffgH56eViPfEyuffgH57eViOfFyfffgH6GeViNfGySfegG6PeViMfHyIfdgF6WeViLfHyAfbgE6ceWiKfIx7fYgD6feWiKfHx3fWgC6heWiKfHx2fTgC6ieW
					iLfGx3fPgB6heXiMfFx7fMgA6eeXiNfEyAfJgA6beXiMfDxgfFf+6xeYiPfCyXfDgA6LeYiRfAynfAgA5/eYiPe/yDe8f96YeZiSe/y1e6gA52eZiSe+zCe3
					gA5seZiQe+yVe0f96MeZiQe/ySexf86OeZiOfAxveuf56leaiKfCw6erf17IeaiHfDwbepfy7aeZiGfFwTeofx7feZiFfGwQepfw7heZiEfGwPeqfw7ieZiD
					fHwPerfx7heZiDfHwReufy7geZiDfHwUexfz7feYiDfHwVe1f07feYiDfHwRe5f17heYiDfHwOe9f27j]],
				["LowerLegF.L"] = [[
					eUhVfg9OgCgLtCeUhWff9AgIgLtfeUhXfe8zgNgKt6eUhYfd8pgSgKuPeUhYfc8igXgKudeUhZfb8UgagJu4eUhbfZ70gcgHvzeUhcfW7NgdgEw1eUhdfU60
					gdgDxceUhdfV6/gegDxLeUhcfW7XgfgFwjeUhbfY7tgfgGv+eUhafa7/gfgHveeUhZfb8MgdgHvGeUhZfb8UgagIu4eUhZfb8WgXgHu0eUhZfb8SgTgHu7eU
					hafa8JgPgGvNeUhafZ76gKgEvpeVhbfY7ngFgDwJeVhbfY7ugBgDv9eVhdfU61f7f+xaeVhefS6Zf2f7yEeVhefT6ofyf8xueWhffP54ftf3yzeWhffO5ofp
					f1zIeWhefR6Mfnf3yXeWhefR6Ufkf4yLeWhdfU6+fjf7xMeVhafZ76fhgBvoeVhYfc8ifggEudeVhXfe80fggGt4eVhWff9CfhgItaeVhVfg9NfjgJtBeVhV
					fh9VflgKsxeVhUfh9YfpgKsqeVhUfh9XftgKsteVhVfh9WfygLsveUhUfh9Xf3gLsseUhUfh9Wf9gLsu]],
				["FootF.L"] = [[
					eVgyfA/dgEf/l0eVgyfA/dgKf+l0eVgyfA/dgPf9l0eVgyfA/dgUf8l0eVgyfA/dgYf8l0eVgyfA/dgbf7l0eVgyfA/dgcf7l0eVgyfA/dgcf7l0eVgyfA/d
					gcf7l0eVgyfA/dgef7l0eVgyfA/dgff6l0eVgyfA/dgff6l0eVgyfA/dgff6l0eVgyfA/dgdf7l0eVgyfA/dgbf7l0eVgyfA/dgYf8l0eVgyfA/dgUf8l0eV
					gyfA/dgQf9l0eVgyfA/dgLf+l0eVgyfA/dgGf/l0eVgyfA/dgCgAl0eVgyfA/df7gBl0eVgyfA/df1gCl0eVgyfA/dfygDl0eVgyfA/dfsgEl0eVgyfA/dfn
					gFl0eVgyfA/dfmgFl0eVgyfA/dfjgFl0eVgyfA/dfjgFl0eVgyfA/dfjgFl0eVgyfA/dfigGl0eVgyfA/dfigFl0eVgyfA/dfjgFl0eVgyfA/dflgFl0eVgy
					fA/dfogEl0eVgyfA/dfrgEl0eVgyfA/dfvgDl0eVgyfA/df0gCl0eVgyfA/df5gBl0eVgyfA/df/gAl0]],
				["UpperLegF.R"] = [[
					hpiEfGwQg/gI7ihoiFfFwRhCgJ7hhoiGfEwShFgJ7ghoiHfDwUhIgK7fhniHfCwVhMgL7fhniJfBwhhOgL7XhniLfAxDhQgJ7ChniOfAxwhQgG6lhniQfAyR
					hRgF6PhmiPfAyNhSgF6RhmiOfBx8hUgH6dhniNfCxuhUgI6mhniMfDxkhUgI6thniLfExdhTgJ6xhniKfFxbhSgI6zhniKfFxbhPgI6zhniKfFxfhMgH6who
					iLfFv+hKgN7shoiMfEr7hHgj9qhoiNfEsShDgd9hhpiMfDxgg7gC6xhpiPfCsSg7gW9hhpiRfCr2g4gV9thqiPfBwVgwgD7ghqiSfBtFgwgL9LhqiSfBrrgv
					gO9xhriQfBvIgpgD8LhriQfCyugif557hriOfEyRgif66QhriKfFxhgif86whriHfHxGgjf97ChriGfIw/gkf+7GhriFfJw7gmf+7JhriEfKw4gof/7LhqiD
					fKw1gqgA7MhqiDfKwygtgB7OhqiDfKwwgwgC7PhqiDfJwqg0gD7ThpiDfIwfg3gF7ZhpiDfIwVg7gH7f]],
				["LowerLegF.R"] = [[
					hshVfg9Of+f1tChshWff89gDf3tlhrhXfd8ugIf4uFhrhYfc8hgNf6ughrhZfc8XgRf7uyhrhafa8GgVf9vShrhbfX7jgYgBwPhqhdfU65gcgFxUhqhefS6d
					gegIx+hqhefT6ogfgHxthqhdfV7BgfgFxHhqhcfX7ZgfgCwhhrhbfY7sgegAwAhrhafZ77gcf/vmhrhafa8FgZf+vUhrhafa8JgWf9vNhrhafa8HgSf9vQhr
					hdff9IgNf2tOhshnfr/WgOfomZhshnfp/DgFfpnqhrhbfY7uf/f9v9hshpfo+0f1fpomhthsfo+7fufnoMhshgfb8Qftf4vAhthqfk+Mfifrqkhthufo+6fb
					fkoNhthkff9FfdfytUhshefT6qflf+xshshcfW7Tfif7wqhshZfb8Nfef3vEhshXfe80fcf0t5hshWff9FfdfztUhshVfg9Sfefys3hshUfh9bfgfyshhshU
					fi9hfjfxsUhshTfi9ifmfysRhshUfi9ffqfysYhshUfh9dfvfzsfhshUfh9cfzfzshhshUfh9Zf4fzso]],
				["FootF.R"] = [[
					hrgyfA/df8gBl0hrgyfA/dgBgAl0hrgyfA/dgGf/l0hrgyfA/dgLf+l0hrgyfA/dgQf9l0hrgyfA/dgUf8l0hrgyfA/dgYf8l0hrgyfA/dgcf7l0hrgyfA/d
					gef6l0hrgyfA/dgff6l0hrgyfA/dgff6l0hrgyfA/dgef6l0hrgyfA/dgdf7l0hrgyfA/dgbf7l0hrgyfA/dgYf8l0hrgyfA/dgVf8l0hrgyfA/dgRf9l0hr
					g5fA/lgKf+lGhrhUe//6gHgAiMhrhRe//4f+gAikhrgyfA/df+gAl0hrhRe//4fvgBikhrhUe//6fngCiMhrg5fA/lfsgDlFhrhMe//1fdgDjFhrhXe//7fU
					gDh9hrhAfA/rfbgFkYhrgyfA/dfmgFl0hrgyfA/dfigGl0hrgyfA/dfegGl0hrgyfA/dfbgHl0hrgyfA/dfbgHl0hrgyfA/dfcgHl0hrgyfA/dfegGl0hrgy
					fA/dfhgGl0hrgyfA/dfkgFl0hrgyfA/dfogEl0hrgyfA/dftgEl0hrgyfA/dfxgDl0hrgyfA/df2gCl0]],
				Tail1 = [[
					gAjChsiQgAgA/6gAjChsiQgOf+/6gAjChsiQgbf9/6gAjDhsiQgof7/6gAjDhsiQg0f6/5gBjDhsihg/f4/4gBjEhsjPhIf2/zgBjEhskGhPf1/tgBjEhskv
					hUfz/ngBjEhsk6hXfy/lgBjDhsk6hYfy/lgBjDhsk6hXfy/lgBjChsk6hUfz/lgBjChsk6hPf0/lgBjChsk6hHf1/lgBjChsk6g+f2/mgAjChsk6g0f4/mgA
					jChsk6gof6/mgAjChsk6gbf8/ngAjDhsk6gXf8/ngAjBhsk5iNfq/igAjDhsk6f7gB/ngAjEhsk6fngE/ngAjChsk6hWfz/lgAjEhsk6fkgE/nf/jFhsk6fC
					gK/mf/jDhsk6gTf9/nf/jDhsk0flgE/of/jEhskResgM/rf/jDhsjjepgM/wf/jChsjGengM/zf/jChsjDepgM/0f/jBhsjDesgL/0f/jBhsjDexgK/0f/jB
					hsjDe4gK/0f/jBhsjDfBgI/1gAjBhsjDfMgH/1gAjBhsi8fYgF/2gAjBhsipflgE/4gAjBhsiXfygC/5]],
				Tail2 = [[
					gAi8iSh3fegG/7gBi9iSh3f2gD/8gBi9iSh3gOf//8gCi9iSh3gmf8/7gCi+iSh3g9f5/7gDi9iSiUhSf1/4gDi8iRjhhlfx/wgDi6iRk9h2fs/jgEi5iQmC
					iEfo/WgEi4iQmViOfm/RgEi4iQmViVfl/RgEi3iQmUiZfl/RgEi3iQmUiZfl/RgDi2iQmViVfm/RgDi2iQmViNfn/SgDi2iQmViCfp/SgCi2iQmVhzfs/TgC
					i2iQmVhifv/UgBi3iQmVhPfz/VgBi3iQmVhKf0/VgFi1iQmRk6fK++gAi4iQmVgcf8/Wf/i4iQmVf3gD/WgDi3iQmUjWfc/Lf/i5iQmVfzgD/Wf9i5iQmVew
					gP/VgAi3iQmVhQfz/Vf+i4iQmLfygD/Zf8i6iQlQd8gW/ff8i6iRkEdxgX/pf8i7iRjSdqgX/vf8i6iRjNdmgX/vf8i6iRjNdngX/vf8i6iRjNdrgX/vf9i5
					iRjNdzgW/wf9i5iRjNd+gU/wf+i5iRjNeMgS/xf+i6iSjAeegP/0f/i7iSiiexgM/3f/i8iSiDfHgJ/6]],
				Tail3 = [[
					f/i4i4gfejgQ/9gAi4i4gffBgM/+gCi5i4gffigJ//gDi5i4gfgDgF//gFi5i4gfgjgA/+gGi4i3hJhDf7/9gHi0i2i2hhf0/1gIivi1k3h9fs/jgIirizmY
					iVfl/QgJipizmyiqfh/JgJipizmyi7ff/IgJioiymyjHfd/GgJioizmxjPfd/GgJioizmxjRfd/FgIinizmxjOfe/GgHinizmyjGfg/GgGinizmyi6fj/IgF
					ioizmyiofm/JgEioizmyiTfq/LgEioizmyiUfr/LgQimixmon/ew+PgBipizmzhaf1/Of/iqizmzgnf9/QgKioiymtl3fH+tf+iqizmzglf+/Qf6iqizmzfA
					gP/PgDipizmyivfo/Jf+iqizmkgff+/Tf4iti0lSdrgZ/df3ixi1jmdVgZ/rf3izi2ifdEgZ/wf3izi2iYc3gb/vf3iyi2iYcwgc/vf3iyi2iYcugd/uf4iy
					i2iYcxgd/vf4iyi2iYc5gc/vf5iyi2iYdGgb/xf7izi3iHdXgZ/zf8i1i3hcdtgW/4f9i3i4gxeGgT/7]],
				Tail4 = [[
					f7i3jdcAdbgL/of+i3jdcAd7gM/rgBi4jdcAefgM/tgDi4jdcAfFgM/ugGi4jdcAfsgM/vgIi1jdc2gUgJ/1gKitjbfCg8gC/9gMijjYhqhif5/6gNicjWjo
					iFfy/tgPiajUkLilfv/ngQiZjUkLjBfv/kgQiZjUkLjZfu/igQiYjUkKjrfv/ggQiYjUkKj3fv/egPiYjUkKj+fw/egOiYjUkKj+fy/egNiYjVkKj3f0/egL
					iYjVkKjrf2/ggJiYjVkLjZf4/igJiZjVkKjlf5/hghiXjPkDrQfg9qgEiZjVkLipf+/ngAiajVkLhsgD/rgXiYjSkGoyfr+ff/iajVkLh1gD/qf4ibjVkLfv
					gK/tgJiZjVkKkxf6/Xf/ibjWj3hwgD/tfyihjYiNd7gK/2fxiojagBdagF/4fwitjbemc+gC/0fvitjbedcmgD/xfvitjbedcUgE/vfvisjbedcIgG/tfwis
					jbedcCgH/tfxisjbedcCgH/tfzisjbedcIgI/tf0iujceGcUgI/uf3ixjcdOcngJ/sf5i1jdcXc+gK/o]],
				Tail5 = [[
					f1jAkCWMcbfr+Pf5jAkCWLc3fy+Sf9jBkCWLdXf5+VgBjBkCWKd8gA+XgFjBkCWKekgH+agJi8kCXJfPgK+ugNivkBZwf8gG/XgQifj+c7gqf//1gSiTj6fW
					hWf6/9gViQj5gBh/f8/7gXiPj4gBikgC/4gYiPj4gCjGgH/1gZiOj4gCjjgL/ygZiOj4gCj6gQ/wgYiOj4gDkKgU/tgXiOj4gDkVgY/sgWiOj4gDkYgb/sgU
					iOj4gDkVge/sgRiOj5gDkLgf/tgRiPj5gDkmgl/pg6iOjqgTuIhn8qgKiQj6gCjzgk/wgEiQj6gCizgg/3griPjxgNrphc9wgEiQj6gCjPgm/0f4iRj6gBgw
					gW/+gUiPj4gFnDhB/MgDiRj7fpjZgn/zfticj9dmerf//3frioj/a8eDfv/hfpiwkAZPdefk/KfnixkAZFc9fg/FfmiwkAZFcgfd/CfmiwkAZGcIfb+/fniw
					kAZGb3fa+9foiwkAZGbsfa+7fqiwkAZGbofb+7fsiykAYrbrfd+1fvi4kBXpb1fg+lfyi9kBWncFfl+V]],
				["UpperLegB.L"] = [[
					eaiIhH8Ledf8vEeaiIhH8Ieff6vKeaiJhH8Fehf4vPeaiJhI8Dejf2vTeaiJhI8Cekf1vVeaiKhI7+emfzveeaiLhH7xepfzv0eaiMhG7jesfywNeaiMhF7Z
					eufyweeaiMhF7aeufxwceaiMhF7fetfxwTeaiLhF7kesfwwLeaiLhF7oerfwwEeaiKhF7reqfxv/eaiKhF7sepfyv9eaiKhF7seofzv9eaiKhE7qenf1wAea
					iKhE7nemf4wGeaiLhE7iemf6wOeaiLhE7eelf9wVeaiJhD7vehf9v4eaiMhD7RejgDwqeaiMhD7JeigGw2eaiLhD7ceegGwYeaiNhC7FeggKw+eaiNhC6+ef
					gNxJeaiLhC7PecgMwseaiMhC7MecgOwyeaiMhC7ReagPwpeaiKhD7keYgOwIeaiJhE7yeWgNvweaiJhE74eWgMvneaiIhE78eVgLvgeaiIhE7/eWgKvZeaiI
					hE8CeWgIvVeaiIhE8DeXgHvSeaiIhF8EeYgFvReaiIhF8FeZgDvOeaiIhG8JeagBvIeaiIhG8Mebf+vD]],
				["LowerLegB.L"] = [[
					eXhcgpwXgCgD7feXhcgqwigEgB7YeXhcgqwtgGgA7SeXhcgrw2gIf/7MeXhcgrw9gKf+7IeXhdgrxEgLf87EeXhdgsxMgNf76/eXhdgsxTgNf566eXhdgsxW
					gOf464eXhdgsxRgPf367eXhdgrxIgPf47BeXhdgrw+gQf47HeXhcgqw2gQf47MeXhcgqwugPf57ReXhcgqwogOf67UeXhcgqwlgMf77WeXhcgqwkgKf87XeX
					hcgqwlgIf97WeXhcgqwpgGf+7UeXhcgqwrgDf/7TeXhbgowEgCgB7qeXhcgrw3f9gB7LeXhdgrw/f6gC7GeXhcgpwXf6gE7feYhcgrw9f2gF7HeYhdgrxFf0
					gF7CeYhcgpwhf0gH7ZeYhcgqwofygI7VeYhcgqwqfxgI7UeYhcgpwXfxgJ7feYhbgowJfxgK7neYhbgowAfygK7seYhbgov5fzgJ7weYhbgnv1f0gJ7zeXhb
					gnvzf1gI70eXhbgnv0f3gI7zeXhbgov4f5gH7xeXhbgov9f7gG7ueXhbgowEf9gF7qeXhbgowMf/gE7l]],
				["UpperLegB.R"] = [[
					hmiIhH8LhjgEvEhmiIhH8GhkgBvOhmiJhG8Ahlf+vXhmiJhG78hlf8vfhmiJhG75hmf5vlhmiKhF7yhnf3vxhmiLhE7jhmf1wLhmiMhD7ShlfywohmiMhC7G
					hkfxw7hmiMhC7Ghlfww6hmiMhC7LhlfxwyhmiLhC7QhmfxwqhmiLhC7VhmfywihmiKhC7Zhmf0wchmiKhC7chlf1wXhmiKhC7ehlf3wUhmiKhC7ehjf4wThm
					iKhD7ehif6wVhmiLhD7chgf8wYhmiLhD7bhef+wahmiJhD7vhfgDv4hmiMhE7UhagCwmhmiMhE7QhYgEwthmiLhE7lhZgIwJhmiNhE7QhVgIwshmiNhF7MhT
					gJwzhmiLhF7fhVgNwThmiMhF7dhUgOwWhmiMhG7jhUgPwNhmiKhH72hWgRvrhmiJhH8DhYgSvThmiJhI8IhZgTvKhmiIhH8MhZgTvDhmiIhH8OhagSu+hmiI
					hH8QhbgRu8hmiIhH8PhdgPu8hmiIhH8OhdgOu/hmiIhH8NhfgLvBhmiIhH8OhggJu/hmiIhH8OhigHu+]],
				["LowerLegB.R"] = [[
					hphcgpwXf+f97fhphcgpwbgBf87chphcgpwfgEf77ahphcgqwigHf67YhphcgqwjgJf57YhohcgqwkgLf57XhohcgqwpgNf47UhohcgqwvgOf47Qhohcgqwx
					gPf47PhohcgqwrgQf47ThohcgpwhgPf47ZhohcgpwYgPf47ehohbgpwRgOf47jhohbgowLgNf47mhohbgowJgLf57nhphbgowJgKf67nhphbgpwNgIf77lhp
					hbgpwUgGf87hhphcgpwdgEf97bhphcgqwlgCf+7XhphbgowEf+f/7qhphcgrw9f+gB7IhphdgsxLf8gD6/hphcgqwpf4gD7UhphdgsxUf4gG65hphdgtxgf3
					gH6xhphdgrxAfzgH7GhphdgrxKfygI7AhphdgsxQfygI68hphdgrxBfwgH7Fhphcgqw0fvgG7NhphcgqwrfvgF7ThphcgqwjfvgF7XhphcgpwcfwgE7chphc
					gpwXfxgE7fhphbgpwTfygD7hhphbgpwSf0gC7ihphbgpwSf3gB7ihphbgpwSf5gA7ihphbgpwTf8f+7h]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAjGhDAPfLgGjtgAjHhDAPfRgejsgAjJhDAQfdgyjsgAjMhDAQfthBjsgAjOhDAQf/hHjtgAjOhDAQgRhFjtgAjMhDAQgig6jugAjJhDAQgugpjugAjHhDAQ
					g1gSjugAjGhDAPg1f6jtgAjHhDAPgvfijsgAjJhDAQgjfOjsgAjMhDAQgTe/jsgAjOhDAQgBe5jtgAjOhDAQfve7jtgAjMhDAQfefGjugAjJhDAQfSfXjugA
					jHhDAQfLfuju]],
				Spine1 = [[
					gAjOghAPflgDjtf/jPghAPfpgSjsf+jRghAPfvgfjsf+jUghAPf3gojsf+jWghAPgAgsjtf+jWghAPgKgrjtf+jUghAPgSgljuf/jRghAPgYgajugAjPghAP
					gbgMjugAjOghAPgbf9jtgBjPghAPgXfujsgCjRghAPgRfhjsgCjUghAPgJfYjsgCjWghAPgAfUjtgCjWghAPf2fVjtgCjUghAPfufbjugBjRghAPfofmjugA
					jPghAPflf0ju]],
				Spine2 = [[
					f/jWf/gA//gAgAf+jXf/gA//f/f6f9jZf/gA//f/f1f8jcf/gA//f/fxf8jef/gA//gAfuf8jef/gA//gAfuf9jcf/gA//gBfxf+jaf/gA//gBf1f/jXf/gA
					//gBf6gBjWf/gA//gAgAgCjXf/gA//f/gGgDjZf/gA//f/gLgEjcf/gA//f/gPgEjef/gA//gAgSgEjef/gA//gAgSgDjcf/gA//gBgPgCjaf/gA//gBgLgB
					jXf/gA//gBgG]],
				Spine3 = [[
					f/jWfggb//gAgAf+jXfggZ//gAgDf9jZfggV//f/gGf8jcfggN//f/gIf8jefggF//gAgJf8jefgf7//gAgJf8jcfgfz//gBgIf+jafgfr//gBgGf/jXfgfn
					//gAgDgBjWfgfl//gAgAgCjXfgfn//gAf9gDjZfgfr//f/f6gEjcfgfz//f/f4gEjefgf7//gAf3gEjefggF//gAf3gEjcfggN//gBf4gCjafggV//gBf6gB
					jXfggZ//gAf9]],
				Neck1 = [[
					f/jWfACNgZf2rnf+jXfACJgTfsrdf9jZfACJgLfjref8jcfACOgBferqf8jefBCVf4fdr8f8jefBCbfvfhsKf9jdfBCdfpfosPf+jafACaflfysIf/jXfACT
					fkf+r4gBjWfACNfngKrngCjXfACJftgUrdgDjZfACJf1gdregEjcfACOf/girqgEjefBCVgIgjr8gEjefBCbgRgfsKgDjdfBCdgXgYsPgCjafACagbgOsIgB
					jXfACTgcgCr4]],
				Neck2 = [[
					gAj+eVDmgYf0usf/j+eUDcgNfiuZf/kBeVDegAfTucf+kEeVDrfzfKu0f9kHeWD8fofHvVf9kIeXELfgfLvvf9kGeXEPfcfWv3f+kDeWEHfcfmvqf/kAeWD3
					fgf5vMgAj+eVDmfogMusgBj+eUDcfzgeuZgBkBeVDegAgtucgCkEeVDrgNg2u0gDkHeWD8gYg5vVgDkIeXELggg1vvgDkGeXEPgkgqv3gCkDeWEHgkgavqgB
					kAeWD3gggHvM]],
				Neck3 = [[
					gCkqd2DOgYf0t8gBkpd1DBgKfatggBksd1DDf6fEtkgAkwd3DVfre0uIgAk0d5Dvffeuu5f/k2d7EEfXezvhf+k1d7ELfUfAvtf+kxd6D+fWfWvZf+ktd4Dm
					fdfwusf+kqd2DOfogMt8f/kpd1DBf2gmtgf/ksd1DDgGg8tkgAkwd3DVgVhMuIgAk0d5DvghhSu5gBk2d7EEgphNvhgCk1d7ELgshAvtgCkxd6D+gqgqvZgC
					ktd4DmgjgQus]],
				Head = [[
					gDlodE/ZgYgDmJgElmdB/SgKgrmogFlpdC/Wf6hQmPgFlwdG/hfrhqlJgEl2dM/sfeh3j4gDl6dR/yfVhzjAgBl5dS/zfShhi9gAl0dQ/vfUhGjwf+ludK/l
					fcgklBf9lodE/Zfof9mJf8lmdB/Sf2fVmof7lpdC/WgGewmPf7lwdG/hgVeWlJf8l2dM/sgieJj4f9l6dR/ygreNjAf/l5dS/zguefi9gAl0dQ/vgse6jwgC
					ludK/lgkfclB]],
				Jaw = [[
					gFkadD/zgYgBjfgGkYdD/vgNgqj+gGkbdB/xgBhQjlgFkhdA/2f0hsifgEkodA/6foh5hMgCktdA/7ffh2gUgAksdC/8fahlgRf+kndD/8fahJhEf8kfdD/5
					ffgniVf7kadD/zfof/jff6kYdD/vfzfWj+f6kbdB/xf/ewjlf7khdA/2gMeUiff8kodA/6gYeHhMf+ktdA/7gheKgUgAksdC/8gmebgRgCkndD/8gme3hEgE
					kfdD/5ghfZiV]],
				["UpperLegF.L"] = [[
					eViJfDo/fGf++seTiKfDqsfCgL+IeTiMfCudfFgW8heSiOfCyOfKgd6ReTiPfC1kfPgj3neUiOfC2rfQgi2jeViLfC0+fJgV4IeXiIfCzSfDgF5geYiFfDx0
					e+f06jeaiDfDwue6fl7PebiEfDwJe4fb7leciHfEwFe2fW7oeciLfEwXe2fW7deciOfEwpe5fb7SebiPfEwhe+fi7YeaiOfEvvfFfq71eYiMfDujfMf08eeW
					iKfDqrfLf2+J]],
				["LowerLegF.L"] = [[
					eShsfw82g9gutweQhofs+dhPhIppeQhhfi/HhMhSnPeRhcfV+5g5hJoNeShafH9lghgysHeThZfC8WgSggu0eUhXfK86gNgWtteUhUfR9XgCgKsteVhTfX9k
					fyf7sOeWhUfb9dfhfrsdeXhWfd9AfUfeteeYhZfe8MfPfUvEeYhcfd7IfSfPw7eYhffc5+fZfOypeXhgfd5DfjfVz3eWhgff4kfxfi0feVhhfj4RgCfy01eT
					hoft6ogfgPxu]],
				["FootF.L"] = [[
					eVhHfS/khFf1lGeVhNfF/lhefxk6eVhMe3/khffxk8eVhFes/jhIf0lMeVg5el/fgqf5lmeVgyen/dgXf8l0eVgyes/dgRf9l0eVgyew/dgEf/l0eVgye1/d
					fygDl0eVgye6/dfegGl0eVgye//cfPgJl0eVgyfE/cfJgKl0eVgyfI/cfKgKl0eVgyfN/cfRgJl0eVgyfS/dfcgHl0eVgyfX/dfsgEl0eVgyfc/dgAgAl0eV
					g9fa/hghf6ld]],
				["UpperLegF.R"] = [[
					hmiDfDwuhGgb7PhliEfDwJhIgl7lhkiHfEwFhKgq7ohkiLfEwXhKgq7dhkiOfEwphHgl7ShliPfEwhhCge7YhmiOfEvvg7gW71hoiMfDujg0gM8ehqiKfDqr
					g1gK+JhriJfDo/g6gC+shtiKfDqsg+f1+IhtiMfCudg7fq8hhuiOfCyOg2fj6RhtiPfC1kgxfd3nhsiOfC2rgwfe2jhriLfC0+g3fr4IhpiIfCzSg9f75gho
					iFfDx0hCgM6j]],
				["LowerLegF.R"] = [[
					hqhUfb9dgfgVsdhphWfd9AgsgitehohZfe8MgxgsvEhohcfd7Igugxw7hohffc5+gngyyphphgfd5Dgdgrz3hqhgff4kgPge0fhrhhfj4Rf+gO01hthoft6o
					fhfxxuhuhsfw82fDfStwhwhofs+dexe4pphwhhfi/He0eunPhvhcfV+5fHe3oNhuhafH9lfffOsHhthZfC8Wfufgu0hshXfK86fzfqtthshUfR9Xf+f2sthr
					hTfX9kgOgFsO]],
				["FootF.R"] = [[
					hrgye6/dgif6l0hrgye//cgxf3l0hrgyfE/cg3f2l0hrgyfI/cg2f2l0hrgyfN/cgvf3l0hrgyfS/dgkf5l0hrgyfX/dgUf8l0hrgyfc/dgAgAl0hrg9fa/h
					ffgGldhrhHfS/ke7gLlGhrhNfF/leigPk6hrhMe3/kehgPk8hrhFes/je4gMlMhrg5el/ffWgHlmhrgyen/dfpgEl0hrgyes/dfvgDl0hrgyew/df8gBl0hr
					gye1/dgOf9l0]],
				Tail1 = [[
					gBi7hskEg8gu/tgBi8hsjzgqgu/wgCi/hsjrgTgn/xgDjChsjuf6gc/xgDjEhsj8figN/vgDjDhskOfNf9/sgCjChskbe+fu/qgBi/hskee3fh/pgAi8hskU
					e5fX/rf/i7hskEfEfS/tf/i8hsjzfWfS/wf+i/hsjrftfZ/xf9jChsjugGfk/xf9jEhsj8gefz/vf9jDhskOgzgD/sf+jChskbhCgS/qf/i/hskehJgf/pgA
					i8hskUhHgp/r]],
				Tail2 = [[
					gDiyiRk3icge/hgDiziRkWhpgj/pgDi2iRj/gpgk/ugDi5iRj7flgf/vgCi6iRkNelgW/rgBi6iQksdvgL/kgAi3iQlKdKgA/cf/i0iQlYc7f1/Yf+iyiQlR
					dEfr/af9iyiRk3dkfi/hf9iziRkWeXfd/pf9i2iRj/fXfc/uf9i5iRj7gbfh/vf+i6iRkNhbfq/rf/i6iQksiRf1/kgAi3iQlKi2gA/cgBi0iQlYjFgL/YgC
					iyiQlRi8gV/a]],
				Tail3 = [[
					gJimi0k0kTgM/VgHipi1kKjOgU/jgFiti2jihxgZ/vgCiwi2jQgGgZ/0f/iwi1jbebgV/xf8ivi0kAc7gP/lf5iri0krb0gI/Xf3ioizlKbMgC/Nf3imi0lN
					bKf7/Mf3imi0k0btf0/Vf5ipi1kKcyfs/jf7iti2jiePfn/vf+iwi2jQf6fn/0gBiwi1jbhlfr/xgEivi0kAjFfx/lgHiri0krkMf4/XgJioizlKk0f+/NgJ
					imi0lNk2gF/M]],
				Tail4 = [[
					gTibjXhtmKgk/WgPifjZhBlGgi/kgJiljagNjage/zgCiojbfphVgV/9f7iojafnfFgH/+f0iljYgHc9f2/2fvigjXg6bMfo/nfsicjWhoaAff/YfriajWh8
					Zifc/RftibjXhtZ2fc/WfxifjZhBa6fe/kf3iljagNcmfi/zf+iojbfperfr/9gFiojafng7f5/+gMiljYgHjDgK/2gRigjXg6k0gY/ngUicjWhomAgh/YgV
					iajWh8megk/R]],
				Tail5 = [[
					ghiXj6dDniht+5gbidj9cfmyhf/BgRikj/bnlOhJ/PgFipkAa2jCgr/af5ipkAahgegG/gftilj+azd3fd/ffkiej7bkbhe2/VfeiYj5ccZtec/HfciVj4dB
					YqeQ+8ffiXj6dDYeeT+5flidj9cfZOeh/Bfvikj/bnaye3/Pf7ipkAa2c+fV/agHipkAahfif6/ggTilj+aziJgj/fgciej7bkkfhK/VgiiYj5ccmThk/Hgk
					iVj4dBnWhw+8]],
				["UpperLegB.L"] = [[
					edh+hD+ceJfcppediAhG+QeXfLqOediDhI90eofArdeciHhK9Le6e9tDebiLhK8dfIfBujeZiNhK75fPfJvneYiNhK7kfNfTwMeXiLhI7UfGfiwmeXiKhG66
					e+f2xQeWiJhD6Me1gNyVeXiKhB5GeugkzyeXiLg/3peog61feYiNg93TechF12eZiNg85peGhBzAebiLg877dyg1vbeciHg996dighrEediDg/++dfgInked
					iAhB/HdufunF]],
				["LowerLegB.L"] = [[
					eahggXzifhfT5UeZhfgbzOf7fQ5jeYhfggzSgUfR5heXhggmzhgofV5VeWhggrzng3fb5QeWhfguzNhBfl5keVhegvyHhHf06WeUhcgvwkhGgF7WeUhZgvu+
					g9gU8QeVhXgxtygugf83eWhWg0tQgZgl9HeWhWg6tbgBgp9CeXhXg6sKfsgs9leYhagtoGfegl+8eZheggmgfNgO/UeahlgUoMe+fs+6ebhrgPsVe7fS9feb
					hpgRwafLfO7c]],
				["FootB.L"] = [[
					eXgygk/YfMgKmIeXgygo/ZfggGmIeXgygt/Zf1gCmIeXgygy/ZgHf/mJeXgyg3/ZgWf8mIeXgyg8/Zgkf5mIeXgyhA/Ygxf2mIeXgyhF/Yg6f1mIeXgyhK/Y
					g8f0mIeXgyhP/Yg2f1mIeXgyhT/Zgqf4mIeXgyhY/ZgYf7mIeXg2hb/bgKf+mAeXhChW/gf8gBlkeXhLhL/jffgGlReXhNg9/je8gLlMeXhJgw/hetgOlVeX
					g/gn/de4gNls]],
				["UpperLegB.R"] = [[
					hqiJhD6MhLfzyVhpiKhB5GhSfczyhpiLg/3phYfG1fhoiNg93Thke712hniNg85ph6e/zAhliLg877iOfLvbhkiHg996ieffrEhjiDg/++ihf4nkhjiAhB/H
					iSgSnFhjh+hD+ch3gkpphjiAhG+Qhpg1qOhjiDhI90hYhArdhkiHhK9LhGhDtDhliLhK8dg4g/ujhniNhK75gxg3vnhoiNhK7kgzgtwMhpiLhI7Ug6gewmhp
					iKhG66hCgKxQ]],
				["LowerLegB.R"] = [[
					hrhXgxtyfSfh83hqhWg0tQfnfb9HhqhWg6tbf/fX9ChphXg6sKgUfU9lhohagtoGgifb+8hnheggmggzfy/UhmhlgUoMhCgU+6hlhrgPsVhFgu9fhlhpgRwa
					g1gy7chmhggXzigfgt5UhnhfgbzOgFgw5jhohfggzSfsgv5hhphggmzhfYgr5VhqhggrznfJgl5QhqhfguzNe/gb5khrhegvyHe5gM6Whshcgvwke6f77Whs
					hZgvu+fDfs8Q]],
				["FootB.R"] = [[
					hpgyhP/YfKgLmIhpgyhT/ZfWgImIhpgyhY/ZfogFmIhpg2hb/bf2gCmAhphChW/ggEf/lkhphLhL/jghf6lRhphNg9/jhEf1lMhphJgw/hhTfylVhpg/gn/d
					hIfzlshpgygk/Yg0f2mIhpgygo/Zggf6mIhpgygt/ZgLf+mIhpgygy/Zf5gBmJhpgyg3/ZfqgEmIhpgyg8/ZfcgHmIhpgyhA/YfPgKmIhpgyhF/YfGgLmIhp
					gyhK/YfEgMmI]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAjGhDALgAgAjGgAjAhDAKgDgVi5gAi8hDANgEgijbgAi/hDARgEgij9gAjFhDAPgCgVjwgAjGhDALgAgAjGgAjAhDAKf9fri5gAi8hDANf8fejbgAi/hDAR
					f8fej9gAjFhDAPf+frjw]],
				Spine1 = [[
					gAjMghANgAgAjef/jHghAJgDgVi0f/jEghAKgEgijBf/jIghAQgDgijyf/jNghASgDgVkEgAjMghANgAgAjegBjHghAJf9fri0gBjEghAKf8fejBgBjIghAQ
					f9fejygBjNghASf9frkE]],
				Spine2 = [[
					gAjUf+gA//gIgAf/jNf+gA/+fCfrf+jKf+f//9e5fef+jQf/f///f5fef/jWf/gA/+gqfrgAjUf+gA//gIgAgBjNf+gA/+fCgVgCjKf+gB/9e5gigCjQf/gB
					//f5gigBjWf/gA/+gqgV]],
				Spine3 = [[
					gAjUffgAABfggAf+jLffgAAChDgVf9jIffgBAEhigif9jQfggBABgSgif+jXfgf/ACfCgVgAjUffgAABfggAgCjLffgAAChDfrgDjIfff/AEhifegDjQfgf/
					ABgSfegCjXfggBACfCfr]],
				Neck1 = [[
					gAjVfAC8gAgAtXf9jJfACEgIgTrRf8jFfABugLggqSf8jPfBCSgMggr0f9jZfBDGgJgTttgAjVfAC8gAgAtXgDjJfACEf4ftrRgEjFfABuf1fgqSgEjPfBCS
					f0fgr0gDjZfBDGf3fttt]],
				Neck2 = [[
					gAkCeaFRgAgAxkf8jweTDvgLgSu9f6jpeRDBgPgftif6j4eWD8gQgevWf9kHebFbgMgRxygAkCeaFRgAgAxkgEjweTDvf1fuu9gGjpeRDBfxfhtigGj4eWD8
					fwfivWgDkHebFbf0fvxy]],
				Neck3 = [[
					gAkzeEFmgAgAyDf8kcd1DqgLgSu0f5kSdvCugOgfs3f5kld5DygQgevDf8k4eHFsgMgRyLgAkzeEFmgAgAyDgEkcd1Dqf1fuu0gHkSdvCufyfhs3gHkld5Dy
					fwfivDgEk4eHFsf0fvyL]],
				Head = [[
					gAl+dn/+gAgAguf7ledI/wgBfrj4f3lNc5/fgFfelkf4lndM/zgEfejff8mDdr//gAfrgegAl+dn/+gAgAgugFledI/wf/gVj4gJlNc5/ff7gilkgIlndM/z
					f8gijfgEmDdr//gAgVge]],
				Jaw = [[
					gAk0dMADgAgAhSf7kQc7ALf/gVc8f3j/c1Aif7giaWf3kac+AKf8gidEf7k6dOADgBgVhXgAk0dMADgAgAhSgFkQc7ALgBfrc8gJj/c1AigFfeaWgJkac+AK
					gEfedEgFk6dOADf/frhX]],
				["UpperLegF.L"] = [[
					eXiFfAnAfIfz/NeVh6fKkWfYf5/seTh2fOs/frgL9PeTh/fIxsfsgJ6peViJfB0ifdgA4heXiFfA3Ze+f81zeah5fFyyebfj52ebh2fHuXeOfV8hebiAfBrn
					eYfj9weaiJe8tZe0f+9B]],
				["LowerLegF.L"] = [[
					eUhvfw5HgQgBz0eThrf9+UhDgcqKeShPfy/4hdg3d+eThOfd/8hPgyfPeThVfK/cgogcl1eVhQe8+Ef5gCq6eVhHfW/JfPgMnSeVhLfm+re1gPpAeWhcfo7b
					fHgFwdeWhhff1Dfhfv4F]],
				["FootF.L"] = [[
					eVhBfl/igQf9lVeVhPfX/mhIf1k2eVhVfD/mh6fukpeVhRet/lhlfxkyeVhEee/jgvf4lOeVgyeY/df6gBl0eVgyer/cfRgJl0eVgye+/ce4gNlzeVgyfS/c
					fKgKl0eVgyfl/dfdgGl0]],
				["UpperLegF.R"] = [[
					hpiFfA3ZhCgE1zhmh5fFyyhlgd52hlh2fHuXhygr8hhliAfBrnhogd9whmiJe8tZhMgC9BhpiFfAnAg4gN/Nhrh6fKkWgogH/shth2fOs/gVf19Phth/fIxs
					gUf36phriJfB0igjgA4h]],
				["LowerLegF.R"] = [[
					hrhQe8+EgHf+q6hrhHfW/Jgxf0nShrhLfm+rhLfxpAhqhcfo7bg5f7wdhqhhff1DgfgR4Fhshvfw5Hfwf/z0hthrf9+Ue9fkqKhuhPfy/4ejfJd+hthOfd/8
					exfOfPhthVfK/cfYfkl1]],
				["FootF.R"] = [[
					hrgyeY/dgGf/l0hrgyer/cgvf3l0hrgye+/chIfzlzhrgyfS/cg2f2l0hrgyfl/dgjf6l0hrhBfl/ifwgDlVhrhPfX/me4gLk2hrhVfD/meGgSkphrhRet/l
					ebgPkyhrhEee/jfRgIlO]],
				Tail1 = [[
					gAi9hslPgAgA/jgBi4hsjvfrgC/xgBiyhsj3fegE/wgBi0hslcfegB/hgBi6hsmSfrf+/XgAi9hslPgAgA/jf/i4hsjvgVf+/xf/iyhsj3gif8/wf/i0hslc
					gif//hf/i6hsmSgVgC/X]],
				Tail2 = [[
					gAiwiQn+gef/++gAiviRlcfegF/hgAipiRkhergN/pgAiniPmeeXgI/SgAisiPomesgB+ygAiwiQn+figB++gAiviRlcgif7/hgAipiRkhhVfz/pgAiniPme
					hpf4/SgAisiPomhUf/+y]],
				Tail3 = [[
					gBieixpthVf/+df/iii1m1fwgG/Qf9ifi1kneRgR/nf8iYiymKdbgM/Sf9iYivpTdlgC+hf/ieixptergB+dgBiii1m1gQf6/QgDifi1knhvfv/ngEiYiymK
					ilf0/SgDiYivpTibf++h]],
				Tail4 = [[
					gEiIjQoCiZgR+3f+iSjXligdgK/gf5iUjZiQeUgI/3f2iKjVixc1f5/tf4iDjOmWckfp/Kf8iIjQoCdnfv+3gCiSjXlifjf2/ggHiUjZiQhsf4/3gKiKjVix
					jLgH/tgIiDjOmWjcgX/K]],
				Tail5 = [[
					gKh2jxkPjWg//hf/iGj7iuhZgj/1f1iPj/fBe2gF/9fviDj5eQcvfa/xfvh0jwheb8e5/rf2h2jxkPcqfB/hgBiGj7iuenfd/1gLiPj/fBhKf7/9gRiDj5eQ
					jRgm/xgRh0jwhekEhH/r]],
				["UpperLegB.L"] = [[
					eaiEhG9+edf4rEeah+hJ+aeefcpxeah6hI91eefPraeah9hG7memfZwGeaiDhF4Eezfz1CeaiEhG5Zebf/zYeah+hF8Gd8gHvJeah6hB+sdmgDoreah9g//t
					dpf1jdeaiDhB/dd+fwla]],
				["LowerLegB.L"] = [[
					eYhhgd4AfzgD1JeWhfgdzOgVgD5keWhXggtzgrf782eWhPgrqNgqfv+TeXhOg+p6gVft+aeXhQg4lTgRf6/jeXhSgng9gJf9/+eYhegTjQf2f3/0eYhygLsA
					fmf+9peYhxgPy4fpgL50]],
				["FootB.L"] = [[
					eXgygX/Zf3gCmJeXgygq/ZgSf8mIeXgyg+/Zgff6mIeXgyhR/ZgYf7mIeXgyhk/ZgGf/mJeXhBhk/fgLf+loeXhPhW/kgHf/lIeXhVhC/nfxgCk7eXhRgt/l
					fqgDlEeXhEgd/gf1gClh]],
				["UpperLegB.R"] = [[
					hmiEhG5ZhlgBzYhmh+hF8GiEf5vJhmh6hB+siaf9orhmh9g//tiXgLjdhmiDhB/diCgQlahmiEhG9+hjgIrEhmh+hJ+ahigkpxhmh6hI91higxrahmh9hG7m
					hagnwGhmiDhF4EhNgN1C]],
				["LowerLegB.R"] = [[
					hphQg4lTfvgG/jhphSgng9f3gD/+hohegTjQgKgJ/0hohygLsAgagC9phohxgPy4gXf150hohhgd4AgNf91JhqhfgdzOfrf95khqhXggtzfVgF82hqhPgrqN
					fWgR+ThphOg+p6frgT+a]],
				["FootB.R"] = [[
					hphBhk/ff1gClohphPhW/kf5gBlIhphVhC/ngPf+k7hphRgt/lgWf9lEhphEgd/ggLf+lhhpgygX/ZgJf+mJhpgygq/ZfugEmIhpgyg+/ZfhgGmIhpgyhR/Z
					fogFmIhpgyhk/Zf6gBmJ]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAjOhDAPgAgAjtgAjOhFARgAgAj9gAjPhKAXgAgAkrgAjRhRAhgAgAlqgAjThZAugAgAmtgAjUhfA7gAgAnkgAjVhiBDgAgAoCgAjUhdA4gAgAnWgAjOhDAP
					gAgAjugAjCg8AIgAgAirgAjIhBAMgAgAjYgAjMhDAPgAgAjtgAjMhDAPgAgAjtgAjMhDAPgAgAjtgAjNhDAPgAgAjtgAjOhDAPgAgAjtgAjOhDAPgAgAjtgA
					jOhDAPgAgAjtgAjOhDAPgAgAjt]],
				Spine1 = [[
					gAjWghAPgAgAjtgAjXgjARgAgAkBgAjagoAZgAgAk6gAjdgwAngAgAmJgAjhg4A5gAgAncgAjkg/BLgAgAoggAjmhDBVgAgApGgAjkg+BGgAgAoQgAjWghAP
					gAgAjtgAjIgZADgAgAhlgAjPgfAJgAgAi2gAjUghAOgAgAjigAjUghAOgAgAjkgAjVghAOgAgAjmgAjVghAOgAgAjpgAjWghAPgAgAjsgAjWghAPgAgAjtgA
					jWghAPgAgAjtgAjWghAPgAgAjt]],
				Spine2 = [[
					gAjef/gAABgAgAgAjggBgAABfngAgAjkgHgAADejgAgAjrgPgAAKdDgAgAjxgZgAAWbdgAgAj3ghgAAjaKgAgAj5gmgAAtZcgAgAj1gfgAAgaegAgAjef/gA
					ABgBgAgAjLf2gAALjPgAgAjVf8gAADhZgAgAjcf/gAABgVgAgAjcf/gAABgTgAgAjcf/gAABgOgAgAjdf/gAABgIgAgAjef/gAABgDgAgAjef/gAABgAgAgA
					jef/gAABgAgAgAjef/gAABgAgA]],
				Spine3 = [[
					gAjefggAABgAgAgAjgfigAABfjgAgAjnfogAAEeTgAgAjwfxgAANcjgAgAj6f7gAAdatgAgAkCgEgAAwZNgAgAkGgJgAA8YXgAgAkAgCgAArZkgAgAjefggA
					ABgBgAgAjFfYgAAUkVgAgAjTfdgAAFh7gAgAjbfggAABgggAgAjbfggAABgcgAgAjcfggAABgVgAgAjdfggAABgLgAgAjefggAABgEgAgAjefggAABgAgAgA
					jefggAABgAgAgAjefggAABgAgA]],
				Neck1 = [[
					gAjefACMgAgArlgAjhfDCUgAgAr6gAjqfJCsgAgAs0gAj3fSDRgAgAuEgAkEfeD8gAgAvXgAkPfoEjgAgAwagAkUfuE5gAgAw/gAkMflEZgAgAwKgAjefACL
					gAgArigAi9e6AogAgAmMgAjPe+BUgAgApCgAjafAB5gAgAqzgAjafAB7gAgAq5gAjbfACAgAgArFgAjdfACFgAgArTgAjdfACKgAgArfgAjefACMgAgArlgA
					jefACMgAgArlgAjefACMgAgArl]],
				Neck2 = [[
					gAkGeVDkgAgAupgAkKeYDrgAgAu3gAkWehEBgAgAvfgAkmeuEhgAgAwXgAk2e+FFgAgAxRgAlDfMFkgAgAyAgAlKfUF2gAgAyagAlAfIFcgAgAx1gAkGeVDi
					gAgAulgAjTeDBGgAgAoNgAjveMCKgAgArfgAkAeTDDgAgAtmgAkAeTDHgAgAttgAkCeTDOgAgAt9gAkEeUDYgAgAuRgAkFeVDggAgAuhgAkGeVDkgAgAuogA
					kGeVDkgAgAupgAkGeVDkgAgAup]],
				Neck3 = [[
					gAkxd2DLgAgAt3gAk2d5DQgAgAuAgAlDeEDcgAgAuagAlVeVDvgAgAu9gAlnenEDgAgAvjgAl1e4EUgAgAwBgAl8fCEegAgAwSgAlxe0EQgAgAv6gAkxd1DI
					gAgAtxgAjudUAngAgAmHgAkTdkBngAgAp9gAkpdwCjgAgAsfgAkqdxCogAgAspgAksdyCxgAgAs+gAkud0C8gAgAtYgAkwd1DGgAgAttgAkxd2DLgAgAt2gA
					kxd2DLgAgAt3gAkxd2DLgAgAt3]],
				Head = [[
					gAlwdE/fgAgAlmgAl1dI/ggAgAlkgAmDdV/hgAgAlegAmXdo/igAgAlWgAmqd9/kgAgAlOgAm6eQ/lgAgAlHgAnCeb/lgAgAlDgAm2eM/kgAgAlJgAlvdD/e
					gAgAlugAkMcK8jgAgAubgAlCck+RgAgAqXgAlic5/IgAgAnZgAlkc6/LgAgAnMgAlnc9/RgAgAmwgAlrdA/YgAgAmPgAludC/dgAgAlzgAlwdE/fgAgAlmgA
					lwdE/fgAgAlmgAlwdE/fgAgAlm]],
				Jaw = [[
					gAkhdA/8gAgAh0gAkndE/7gAgAiGgAk1dQ/3gAgAi5gAlIdj/vgAgAkBgAlcd4/kgAgAlNgAlreK/YgAgAmLgAl0eV/RgAgAmugAloeG/bgAgAl8gAkhdA/7
					gAgAiDgAjIcz6NgAgAyVgAj2c4+DgAgAq9gAkUc+/jgAgAlTgAkVc+/ngAgAk5gAkZc//ugAgAkEgAkcc//2gAgAjEgAkgdA/6gAgAiOgAkhdA/8gAgAh0gA
					khdA/8gAgAh0gAkhdA/8gAgAh0]],
				["UpperLegF.L"] = [[
					eXiOfDyNfGgA6SeXiRfDxsfFf96peXibfDwqfFf27TeXipfEv7fGfu7ueXi4fGv+fHfm7teXjFfJwmfIfg7VeXjNfLxLfJfd6+eXjCfIwLfIff7leXiOfDug
					fBfw8geXhwfRvye3fw7zeXiAfKwOe/f37jeXiKfFxifEf96veXiLfFxmfEf96seXiMfExvfEf+6meXiNfEx8fFf/6eeXiOfDyHfFgA6WeXiOfDyNfGgA6SeX
					iOfDyNfGgA6SeXiOfDyNfGgA6S]],
				["LowerLegF.L"] = [[
					eVhcfW7NgAgAw0eVhgfX7tgCgCv/eUhrfb8ygFgHt8eUh7fe97gHgMrTeUiKfh+1gHgPoieUiWfh/YgGgRmMeUicfh/ngFgSk2eUiTfi/egFgTlweUhjfi+G
					gEgRq2eUhDft/df7gclzeUhSfk93gBgPrceVhZfb8LgBgFvKeVhafa8EgBgEvVeVhafZ73gBgDvueVhbfX7lgAgCwNeVhcfW7VgAgBwneVhcfW7OgAgAw0eV
					hcfW7NgAgAw0eVhcfW7NgAgAw0]],
				["FootF.L"] = [[
					eVgyfA/dgAgAl0eVg3fA/ggCgAlleVhGe+/ngGf/k6eVhbe7/vgKf/j8eVhxe4/3gLf/i4eViEe1/7gLf/h/eViOe0/9gLf/heeViDe2/7gLf/iDeVhFe+/m
					gIf/k/eVgyfA/dgBgAl0eVgyfA/dgEf/l0eVgyfA/dgCgAl0eVgyfA/dgCgAl0eVgyfA/dgBgAl0eVgyfA/dgBgAl0eVgyfA/dgAgAl0eVgyfA/dgAgAl0eV
					gyfA/dgAgAl0eVgyfA/dgAgAl0]],
				["UpperLegF.R"] = [[
					hpiOfDyNg6gA6ShpiRfDxsg7gD6phpibfDwqg7gK7ThpipfEv7g6gS7uhpi4fGv+g5ga7thpjFfJwmg4gg7VhpjNfLxLg3gj6+hpjCfIwLg4gh7lhpiOfDug
					g/gQ8ghphwfRvyhJgQ7zhpiAfKwOhBgJ7jhpiKfFxig8gD6vhpiLfFxmg8gD6shpiMfExvg8gC6mhpiNfEx8g7gB6ehpiOfDyHg7gA6WhpiOfDyNg6gA6Shp
					iOfDyNg6gA6ShpiOfDyNg6gA6S]],
				["LowerLegF.R"] = [[
					hrhcfW7NgAgAw0hrhgfX7tf+f+v/hshrfb8yf7f5t8hsh7fe97f5f0rThsiKfh+1f5fxoihsiWfh/Yf6fvmMhsicfh/nf7fuk2hsiTfi/ef7ftlwhshjfi+G
					f8fvq2hshDft/dgFfklzhshSfk93f/fxrchrhZfb8Lf/f7vKhrhafa8Ef/f8vVhrhafZ73f/f9vuhrhbfX7lgAf+wNhrhcfW7VgAf/wnhrhcfW7OgAgAw0hr
					hcfW7NgAgAw0hrhcfW7NgAgAw0]],
				["FootF.R"] = [[
					hrgyfA/dgAgAl0hrg3fA/gf+gAllhrhGe+/nf6gBk6hrhbe7/vf2gBj8hrhxe4/3f1gBi4hriEe1/7f1gBh/hriOe0/9f1gBhehriDe2/7f1gBiDhrhFe+/m
					f4gBk/hrgyfA/df/gAl0hrgyfA/df8gBl0hrgyfA/df+gAl0hrgyfA/df+gAl0hrgyfA/df/gAl0hrgyfA/df/gAl0hrgyfA/dgAgAl0hrgyfA/dgAgAl0hr
					gyfA/dgAgAl0hrgyfA/dgAgAl0]],
				Tail1 = [[
					gAjDhskFgAgA/ugAjDhtkNgAgA/tgAjChykkgAgA/qgAjCh4lEgAgA/lgAjBh+llgAgA/ggAjAiDmBgAgA/bgAjAiGmQgAgA/XgAjAiCl6gAgA/cgAjDhskG
					gBgA/ugAi6hlkrgAgA/pgAi+hqkgffgE/qgAjBhskTf0gB/sgAjBhskSgAgA/tgAjChskOgIf//tgAjChskKgEf//ugAjDhskHgAgA/ugAjDhskFgAgA/ugA
					jDhskFgAgA/ugAjDhskFgAgA/u]],
				Tail2 = [[
					gAi6iRksgAgA/pgAi5iSksgAgA/pgAi4iWksgAgA/pgAi2icksgAgA/pgAi0iiksgAgA/pgAiyinksgAgA/pgAixipksgAgA/pgAizimksgAgA/pgAi5iRku
					gCgA/pgAiviKm4gqf9/Pf/i0iOl3fQgH/cgAi3iQlIfmgE/kgAi3iQlFf5gB/lgAi4iRk+gMf+/mgAi5iRk2gJf//ngAi5iRkvgBgA/ogAi6iRksgAgA/pgA
					i6iRksgAgA/pgAi6iRksgAgA/p]],
				Tail3 = [[
					gAivi1kVgAgA/sgAiui2kNgAgA/tgAiti7j2gAgA/wgAirjAjWgAgA/0gAipjGi0gAgA/3gAinjLiYgAgA/5gAimjOiJgAgA/6gAiojKifgAgA/5gAiui1kY
					gCgA/sgBifisoHhuf6+5f9imiymQfYgH/Xf/iri0k/fbgF/mgAiri1k6ftgC/ngBisi1kwgKf//ogAiti1kkgNf+/qgAiui1kagDgA/rgAivi1kVgAgA/sgA
					ivi1kVgAgA/sgAivi1kVgAgA/s]],
				Tail4 = [[
					gAikjZg2gAgA/+gAikjbglgAgA//gAikjff4gAgA//gAijjle4gAgA/+gAiijsd0gAgA/6gAiijwc8gAgA/2gAihjzccgAgA/ygAiijvdJgAgA/3gAikjZg5
					gDgA/+gFiNjNmTixgK/Pf8iXjVjif0gF/yf9ifjYhvfYgB/8f/igjZhofhgA/8gBihjZhbgDgA/9gBijjZhKgOgA/+gAikjZg8gEgA/+gAikjZg2gAgA/+gA
					ikjZg2gAgA/+gAikjZg2gAgA/+]],
				Tail5 = [[
					gAiij/b2gAgA/ugAijkBbegAgA/qgAikkFaagAgA/ggAilkLY8gAgA/MgAinkRXZgAgA+zgAipkWWIgAgA+bgAiqkYVcgAgA+MgAiokVWbgAgA+hgAiij/b6
					gCgA/ugMh+jvi/jWgr/qf7iPj6fTgYgM/+f8ibj+c9fef8/1f+icj+c1faf6/1gBiej/ckf6f//zgBigj/cQgMgC/xgAiij/b/gFgB/vgAiij/b3gAgA/ugA
					iij/b2gAgA/ugAiij/b2gAgA/u]],
				["UpperLegB.L"] = [[
					eaiMhD7WekgAwieaiMhE7VelgAwkeaiNhG7QengAwseaiPhJ7DesgCxCeaiShM6neygFxteaiUhP53e5gKyzeaiWhQ4afEgS0qeaiUhO6Ge3gIydeaiMhD7X
					ekgAwgeaiAhA8keVf3uSeaiGhC8Hecf7vMeaiKhD7qehf+wAeaiKhD7oeif+wEeaiKhD7jeif/wMeaiLhD7dejf/wWeaiLhD7YekgAweeaiMhD7WekgAwiea
					iMhD7WekgAwieaiMhD7WekgAwi]],
				["LowerLegB.L"] = [[
					eXhcgqw0gAgA7NeXhdgrxFgAgA7DeXhegux1f/f/6jeXhfgyzCf8f95teYhhg30jf5f64heYhhg+2Qf0f22/eYhhhH4Yftfw0ueYhhg81xf2f33ceXhcgqwy
					gAgA7PeXhVggtIgIgD9LeXhZglu+gFgC8ReXhbgpwOgCgB7keXhbgpwSgCgB7ieXhcgpwbgBgB7deXhcgqwmgBgA7WeXhcgqwwgAgA7QeXhcgqw0gAgA7NeX
					hcgqw0gAgA7NeXhcgqw0gAgA7N]],
				["FootB.L"] = [[
					eXgyhA/ZgAgAmJeXgyhA/ZgAgAmJeXgyhA/Zf+gAmJeXgyhA/Zf7gBmJeXgyhA/Zf3gCmJeXgyhA/ZfwgDmIeXgyhA/ZfmgFmJeXgyhA/ZfygDmIeXgyhA/Z
					gAgAmJeXgyhA/ZgJf+mJeXgyhA/ZgFf/mJeXgyhA/ZgCgAmJeXgyhA/ZgCgAmJeXgyhA/ZgBgAmJeXgyhA/ZgBgAmJeXgyhA/ZgAgAmJeXgyhA/ZgAgAmJeX
					gyhA/ZgAgAmJeXgyhA/ZgAgAmJ]],
				["UpperLegB.R"] = [[
					hmiMhD7WhcgAwihmiMhE7VhbgAwkhmiNhG7QhZgAwshmiPhJ7DhUf+xChmiShM6nhOf7xthmiUhP53hHf2yzhmiWhQ4ag8fu0qhmiUhO6GhJf4ydhmiMhD7X
					hcgAwghmiAhA8khrgJuShmiGhC8HhkgFvMhmiKhD7qhfgCwAhmiKhD7ohegCwEhmiKhD7jhegBwMhmiLhD7dhdgBwWhmiLhD7YhcgAwehmiMhD7WhcgAwihm
					iMhD7WhcgAwihmiMhD7WhcgAwi]],
				["LowerLegB.R"] = [[
					hphcgqw0gAgA7NhphdgrxFgAgA7Dhphegux1gBgB6jhphfgyzCgEgD5thohhg30jgHgG4hhohhg+2QgMgK2/hohhhH4YgTgQ0uhohhg81xgKgJ3chphcgqwy
					gAgA7PhphVggtIf4f99LhphZglu+f7f+8RhphbgpwOf+f/7khphbgpwSf+f/7ihphcgpwbf/f/7dhphcgqwmf/gA7WhphcgqwwgAgA7Qhphcgqw0gAgA7Nhp
					hcgqw0gAgA7Nhphcgqw0gAgA7N]],
				["FootB.R"] = [[
					hpgyhA/ZgAgAmJhpgyhA/ZgAgAmJhpgyhA/ZgCgAmJhpgyhA/ZgFf/mJhpgyhA/ZgJf+mJhpgyhA/ZgQf9mIhpgyhA/Zgaf7mJhpgyhA/ZgOf9mIhpgyhA/Z
					gAgAmJhpgyhA/Zf3gCmJhpgyhA/Zf7gBmJhpgyhA/Zf+gAmJhpgyhA/Zf+gAmJhpgyhA/Zf/gAmJhpgyhA/Zf/gAmJhpgyhA/ZgAgAmJhpgyhA/ZgAgAmJhp
					gyhA/ZgAgAmJhpgyhA/ZgAgAmJ]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAjOhDAPgAgAjtgAjNhGAOgAgAjpgAjMhLANgAgAjfgAjKhRAMgAgAjVgAjKhSAMgAgAjTgAjMhMANgAgAjfgAjPhCAUgAgAkZgAjRg+AegAgAlZgAjRg9Ah
					gAgAlpgAjRg9AhgAgAlpgAjRg9AhgAgAlpgAjRg9AhgAgAlpgAjRg9AhgAgAlpgAjRg9AhgAgAlpgAjRg9AhgAgAlpgAjRg9AhgAgAlpgAjRg9AhgAgAlpgA
					jRg9AhgAgAlpgAjRg9AhgAgAlpgAjRg+AegAgAlagAjPhAAWgAgAkmgAjOhDAQgAgAj3gAjOhDAPgAgAjtgAjOhDAPgAgAjtgAjOhDAPgAgAjt]],
				Spine1 = [[
					gAjWghAPgAgAjtgAjVgjAOgAgAjmgAjTgpAMgAgAjVgAjSguALgAgAjGgAjRgwAKgAgAjBgAjTgqAMgAgAjVgAjYggAWgAgAklgAjdgdAkgAgAl3gAjegcAo
					gAgAmMgAjegcAogAgAmMgAjegcAogAgAmMgAjegcAogAgAmMgAjegcAogAgAmMgAjegcAogAgAmMgAjegcAogAgAmMgAjegcAogAgAmMgAjegcAogAgAmMgA
					jegcAogAgAmMgAjegcAogAgAmMgAjdgdAkgAgAl5gAjZgfAZgAgAk3gAjWghAQgAgAj5gAjWghAPgAgAjtgAjWghAPgAgAjtgAjWghAPgAgAjt]],
				Spine2 = [[
					gAjef/gAABgAgAgAjdgBgAABgKgAgAjbgGgAABghgAgAjYgMgAACg3gAgAjYgNgAACg+gAgAjagHgAABgjgAgAjif/gAACe8gAgAjpf8gAAIdWgAgAjrf7gA
					AKc8gAgAjrf7gAAKc8gAgAjrf7gAAKc8gAgAjrf7gAAKc8gAgAjrf7gAAKc8gAgAjrf7gAAKc8gAgAjrf7gAAKc8gAgAjrf7gAAKc8gAgAjrf7gAAKc8gAgA
					jrf7gAAKc8gAgAjrf7gAAKc8gAgAjqf8gAAIdTgAgAjkf9gAADelgAgAjff+gAABfxgAgAjef/gAABgAgAgAjef/gAABgAgAgAjef/gAABgAgA]],
				Spine3 = [[
					gAjefggAABgAgAgAjdfigAABgNgAgAjafngAABgrgAgAjXfsgAAChHgAgAjWfugAADhQgAgAjZfogAABgtgAgAjkffgAADewgAgAjvfdgAALc3gAgAjxfdgA
					AOcYgAgAjxfdgAAOcYgAgAjxfdgAAOcYgAgAjxfdgAAOcYgAgAjxfdgAAOcYgAgAjxfdgAAOcYgAgAjxfdgAAOcYgAgAjxfdgAAOcYgAgAjxfdgAAOcYgAgA
					jxfdgAAOcYgAgAjxfdgAAOcYgAgAjvfdgAALc0gAgAjnfegAAEeVgAgAjfffgAABfugAgAjefggAABgAgAgAjefggAABgAgAgAjefggAABgAgA]],
				Neck1 = [[
					gAjefACMgAgArlgAjcfDCFgAgArUgAjYfIB2gAgAqrgAjVfNBpgAgAqEgAjUfPBlgAgAp4gAjYfJB1gAgAqogAjnfAC/gAgAtcgAj1e/EZgAgAwKgAj4e+Ez
					gAgAw0gAj4e+EzgAgAw0gAj4e+EzgAgAw0gAj4e+EzgAgAw0gAj4e+EzgAgAw0gAj4e+EzgAgAw0gAj4e+EzgAgAw0gAj4e+EzgAgAw0gAj4e+EzgAgAw0gA
					j4e+EzgAgAw0gAj4e+EzgAgAw0gAj1e+EbgAgAwNgAjqe/DRgAgAuEgAjgfACWgAgAsAgAjefACMgAgArlgAjefACMgAgArlgAjefACMgAgArl]],
				Neck2 = [[
					gAkGeVDkgAgAupgAkDeWDZgAgAuTgAj+eaDAgAgAtggAj4eeCqgAgAsvgAj2efCkgAgAsggAj9ebC/gAgAtdgAkUeaE9gAgAxFgAkoeiHcgAgA0fgAktekII
					gAgA1TgAktekIIgAgA1TgAktekIIgAgA1TgAktekIIgAgA1TgAktekIIgAgA1TgAktekIIgAgA1TgAktekIIgAgA1TgAktekIIgAgA1TgAktekIIgAgA1TgA
					ktekIIgAgA1TgAktekIIgAgA1TgAkpeiHfgAgA0jgAkZebFegAgAx3gAkJeWD2gAgAvMgAkGeVDkgAgAupgAkGeVDkgAgAupgAkGeVDkgAgAup]],
				Neck3 = [[
					gAkxd2DLgAgAt3gAkud2C+gAgAtcgAknd4CigAgAscgAkfd5CJgAgAregAkdd6CCgAgArMgAkmd4CggAgAsYgAlEeDE6gAgAxAgAldeYIJgAgA1TgAlieeJE
					gAgA2SgAlieeJEgAgA2SgAlieeJEgAgA2SgAlieeJEgAgA2SgAlieeJEgAgA2SgAlieeJEgAgA2SgAlieeJEgAgA2SgAlieeJEgAgA2SgAlieeJEgAgA2SgA
					lieeJEgAgA2SgAlieeJEgAgA2SgAldeYINgAgA1YgAlKeHFkgAgAx/gAk2d4DigAgAukgAkxd2DLgAgAt3gAkxd2DLgAgAt3gAkxd2DLgAgAt3]],
				Head = [[
					gAlwdE/fgAgAlmgAlrdC/YgAgAmLgAlgdA/FgAgAnkgAlVc++vgAgAo2gAlRc9+ogAgApOgAlfdA/EgAgBnngAmMdg//gAgAgpgAmseP/ZgcfSZ7gAmyec+n
					fbgxWzgAmyec+1gAgAXfgAmyec/AgjfNYMgAmyec+nfbgxWzgAmyec+1gAgAXfgAmyec/AgjfNYMgAmyec+nfbgxWzgAmyec+1gAgAXfgAmyec/AgjfNYMgA
					myec+nfbgxWzgAmyec+1gAgAXfgAmteQ/XgcfSZygAmVdp/9f1gaetgAl3dJ/rgAgAkhgAlwdE/fgAgAlmgAlwdE/fgAgAlmgAlwdE/fgAgAlm]],
				Jaw = [[
					gAkhdA/8gAgAh0gAkddC/4gAgAilgAkRdG/sgAgAkZgAkHdL/ZgAgAmHgAkEdM/TgAgAmngAkRdH/qgAgBkogAlDdF//gAgAgCgAl0dX/3ghfVdWgAmGda/n
					fUgsbQgAmDdc/vgAgAb9gAmBde/zgqfScsgAmGda/nfUgsbQgAmDdc/vgAgAb9gAmBde/zgqfScsgAmGda/nfUgsbQgAmDdc/vgAgAb9gAmBde/zgqfScsgA
					mGda/nfUgsbQgAmDdc/vgAgAb9gAl1dY/3ghfVdTgAlPdF/9f1gaexgAkpdA/9gAgAhXgAkhdA/8gAgAh0gAkhdA/8gAgAh0gAkhdA/8gAgAh0]],
				["UpperLegF.L"] = [[
					eXiOfDyNfGgA6SeXiNfGyQfEf/6QeXiJfOyrfBf859eXiFfVzZe/f75beXiEfYzpe+f65OeXiIfPyyfBf854eXiXe9zmfKgF5ReXimex1ifUgN3peXiqev1Z
					fVgN3xeXiqev1ZfVgN3xeXiqev1ZfVgN3xeXiqev1ZfVgN3xeXiqev1ZfVgN3xeXiqev1ZfVgN3xeXiqev1ZfVgN3xeXiqev1ZfVgN3xeXiqev1ZfVgN3xeX
					iqev1ZfVgN3xeXiqev1ZfVgN3xeXimex1gfUgN3qeXiae5sofFfu9YeXiQfBtdfCfv9AeXiOfDyKfGgA6UeXiOfDyNfGgA6SeXiOfDyNfGgA6S]],
				["LowerLegF.L"] = [[
					eVhcfW7NgAgAw0eVhbfZ70gAgCvzeVhWff8/f/gHtieUhSfj90f9gKrkeUhRfl+Cf9gKrBeUhWff9Hf/gHtReVhjfK5Rf9f3zneWhxe21nf2fo3leWh1e11e
					f3fo3teWh1e11ef3fo3teWh1e11ef3fo3teWh1e11ef3fo3teWh1e11ef3fo3teWh1e11ef3fo3teWh1e11ef3fo3teWh1e11ef3fo3teWh1e11ef3fo3teW
					h1e11ef3fo3teWh1e11ef3fo3teWhxe21lf2fo3neUh0fe9UgJgNszeUhnfk98gGgQrReVhcfW7QgAgAwweVhcfW7NgAgAw0eVhcfW7NgAgAw0]],
				["FootF.L"] = [[
					eVgyfA/dgAgAl0eVgyfA/dgAgAl0eVgyfA/dgAgAl0eVgyfA/df/gAl0eVgyfA/df/gAl0eVgyfA/dgAgAl0eVg2e+/df7gBl0eVhCe6+9fygAoDeVhGe5+w
					fzf/o1eVhGe5+wfzf/o1eVhGe5+wfzf/o1eVhGe5+wfzf/o1eVhGe5+wfzf/o1eVhGe5+wfzf/o1eVhGe5+wfzf/o1eVhGe5+wfzf/o1eVhGe5+wfzf/o1eV
					hGe5+wfzf/o1eVhGe5+wfzf/o1eVhCe6/FfygBnieVhRe+/dgMf+l0eVhIfA/dgJf+l0eVgyfA/dgAgAl0eVgyfA/dgAgAl0eVgyfA/dgAgAl0]],
				["UpperLegF.R"] = [[
					hpiOfDyNg6gA6ShpiNfGyQg8gB6QhpiJfOyrg/gE59hpiFfVzZhBgF5bhpiEfYzphCgG5OhpiIfPyyg/gE54hpiXe9zmg2f75Rhpimex1igsfz3phpiqev1Z
					grfz3xhpiqev1Zgrfz3xhpiqev1Zgrfz3xhpiqev1Zgrfz3xhpiqev1Zgrfz3xhpiqev1Zgrfz3xhpiqev1Zgrfz3xhpiqev1Zgrfz3xhpiqev1Zgrfz3xhp
					iqev1Zgrfz3xhpiqev1Zgrfz3xhpimex1hgsfz3qhpiae5u+g6gK8QhpiQfBvIg9gL8LhpiOfDyLg6gA6UhpiOfDyNg6gA6ShpiOfDyNg6gA6S]],
				["LowerLegF.R"] = [[
					hrhcfW7NgAgAw0hrhbfZ70gAf+vzhrhWff8/gBf5tihshSfj90gDf2rkhshRfl+CgDf2rBhshWff9HgBf5tRhrhjfK5RgDgJznhqhxe21ngKgY3lhqh1e11e
					gJgY3thqh1e11egJgY3thqh1e11egJgY3thqh1e11egJgY3thqh1e11egJgY3thqh1e11egJgY3thqh1e11egJgY3thqh1e11egJgY3thqh1e11egJgY3thq
					h1e11egJgY3thqh1e11egJgY3thqhxe21mgKgY3mhshufX8Df5f6vYhshkff9Cf7f1tchrhcfW7PgAgAwyhrhcfW7NgAgAw0hrhcfW7NgAgAw0]],
				["FootF.R"] = [[
					hrgyfA/dgAgAl0hrgyfA/dgAgAl0hrgyfA/dgAgAl0hrgyfA/dgBgAl0hrgyfA/dgBgAl0hrgyfA/dgAgAl0hrg2e+/dgFf/l0hrhCe6+9gOgAoDhrhGe5+w
					gNgBo1hrhGe5+wgNgBo1hrhGe5+wgNgBo1hrhGe5+wgNgBo1hrhGe5+wgNgBo1hrhGe5+wgNgBo1hrhGe5+wgNgBo1hrhGe5+wgNgBo1hrhGe5+wgNgBo1hr
					hGe5+wgNgBo1hrhGe5+wgNgBo1hrhCe6/CgOgAnxhrhGe+/df4gBl0hrhAfA/df5gBl0hrgyfA/dgAgAl0hrgyfA/dgAgAl0hrgyfA/dgAgAl0]],
				Tail1 = [[
					gAjDhskFgAgA/ugAjDhuj4gAgA/wgAjCh0jbgAgA/zgAjBh5i+gAgA/2gAjAh7i2gAgA/3gAjCh1jYgAgA/0gAjChqlUfmgC/igAjChlnMgQgA/LgAjChknp
					g+f//DgAjChknpfNgB/DgAjChknpfcgB/DgAjChknphFf//DgAjChknpgAgA/EgAjChknpe7gB/DgAjChknpgkf//DgAjChknpgzf//DgAjChknpfCgB/DgA
					jChknpfugA/EgAjChknphHf//CgAjChlnOfwgA/KgAjDholvfjgC/egAjDhrkXgEgA/sgAjDhskFgAgA/ugAjDhskFgAgA/ugAjDhskFgAgA/u]],
				Tail2 = [[
					gAi6iRksgAgA/pgAi6iTkXgAgA/sgAi6iZjlgAgA/ygAi6ifi2gAgA/3gAi6igiogAgA/4gAi6iajhgBgA/zf/i2iOmdfQgF/UgBiyiHpLf6f/+pgCiwiGp1
					iFf8+Xf+iwiGp2fCgE+bf/iwiGp1ebgC+ZgCiwiGp1hyf7+ZgAiwiGp2gqgB+bf+iwiGp1d5gF+XgBiwiGp2gcf9+bgCiwiGp1h5f9+Yf+iwiGp1elgF+af/
					iwiGp2e2gB+agDiwiGp1iBf7+Yf/ixiHpPgGgB+of/i1iMnGfDgG/LgAi5iQlGgFf//lgAi6iRksgAgA/pgAi6iRksgAgA/pgAi6iRksgAgA/p]],
				Tail3 = [[
					gAivi1kVgAgA/sgAivi4j3gAgA/wgAixi+iygAgA/3gAizjEhvgAgA/8gAi0jGhcgAgA/9gAixi/irgCgA/4f9inixmpfIgG/SgAidinqOfGf8+TgHiaikrD
					i5f794f8iaikrFfjgJ+Af7iaikrDdWgA95gGiaikrEh1f399gBiaikrEhugF99f5iaikrDdSgH95gCiaikrFfsf4+AgGiaikrDi4f994f7iaikrFe0gK9/f9
					iaikrEdvf+97gHiaikrEiXf397gAicinqSg7gE+Rf9iliungeqgH/EgAiti0k3gCgA/ngAivi1kVgAgA/sgAivi1kVgAgA/sgAivi1kVgAgA/s]],
				Tail4 = [[
					gAikjZg2gAgA/+gAimjcgQgAgA//gAirjje1gAgA/+gAivjqdggAgA/5gAiwjsdHgAgA/3gAirjketgCgA/9f7iYjTjvfQgB/wf+iGjFoQeKfr+2gNiCjApV
					jHgJ+cf7iCjBpWgggX+lf1iCjBpVcofr+agKiCjBpWhQf0+kgFiCjBpVivgb+efziCjApVdWf++fgBiCjBpWepfm+kgMiCjApVjXgQ+af4iCjBpWfngS+lf4
					iCjBpVc2fn+bgMiCjApWiBf7+igCiFjFoVh4gV+1f6iUjQk1ejf//lgAiijYhgf9gA/9gAikjZg2gAgA/+gAikjZg2gAgA/+gAikjZg2gAgA/+]],
				Tail5 = [[
					gAiij/b2gAgA/ugAimkCbIgAgA/ngAitkJZcgAgA/TgAi1kPX2gAgA+7gAi3kRXYgAgA+zgAiukKZRgDgA/Rf6iPj4fTflgA/+f6hzjmkydgfL/hgUhtjfmH
					irgR/Sf9hsjhmHhdg5/WfthtjfmHclfR/NgNhsjgmGgVff/ZgMhtjgmHjRhA/NfthtjfmHd/gA/Vf+hsjhmHdyfA/TgUhtjfmHjKgh/Pf3hsjgmGgmgv/Zfw
					htjgmHcifH/MgRhtjgmGhNfv/YgGhyjlk5ihg2/gf2iIj0gnexf3/9gAiej+cpf4f//0gAiij/b2gAgA/ugAiij/b2gAgA/ugAiij/b2gAgA/u]],
				["UpperLegB.L"] = [[
					eaiMhD7WekgAwieaiLhG7qeif/wBeaiKhM8Uegf8u0eaiIhS81edf6txeaiIhU8+edf5tfeaiJhN8Zeff8uqeaiNg/6yeogCxceaiPg35WewgHzeeaiQg149
					eygIz+eaiQg149eygIz+eaiQg149eygIz+eaiQg149eygIz+eaiQg149eygIz+eaiQg149eygIz+eaiQg149eygIz+eaiQg149eygIz+eaiQg149eygIz+ea
					iQg149eygIz+eaiQg149eygIz+eaiPg35UewgHzgeaiNg96ZeqgDyCeaiMhC7MelgAwyeaiMhD7WekgAwieaiMhD7WekgAwieaiMhD7WekgAwi]],
				["LowerLegB.L"] = [[
					eXhcgqw0gAgA7NeXhdgrxFgAgB7DeXhegux0f/gC6keXhfgwypf+gD5/eXhfgxy6f+gE5zeXhegux8f/gC6feXhcgqwkgAf+7XeXhcgpwYf+f77feYhcgpwb
					f9f67ceYhcgpwbf9f67ceYhcgpwbf9f67ceYhcgpwbf9f67ceYhcgpwbf9f67ceYhcgpwbf9f67ceYhcgpwbf9f67ceYhcgpwbf9f67ceYhcgpwbf9f67ceY
					hcgpwbf9f67ceYhcgpwbf9f67ceXhcgpwYf+f67feXhcgpwbgAf97deXhcgqwvgAgA7ReXhcgqw0gAgA7NeXhcgqw0gAgA7NeXhcgqw0gAgA7N]],
				["UpperLegB.R"] = [[
					hmiMhD7WhcgAwihmiLhG7qhegBwBhmiKhM8UhggEu0hmiIhS81hjgGtxhmiIhU8+hjgHtfhmiJhN8ZhhgEuqhmiNg/6yhYf+xchmiPg35WhQf5zehmiQg149
					hOf4z+hmiQg149hOf4z+hmiQg149hOf4z+hmiQg149hOf4z+hmiQg149hOf4z+hmiQg149hOf4z+hmiQg149hOf4z+hmiQg149hOf4z+hmiQg149hOf4z+hm
					iQg149hOf4z+hmiQg149hOf4z+hmiPg35UhQf5zghmiNg96ZhWf9yChmiMhC7MhbgAwyhmiMhD7WhcgAwihmiMhD7WhcgAwihmiMhD7WhcgAwi]],
				["LowerLegB.R"] = [[
					hphcgqw0gAgA7NhphdgrxFgAf/7Dhphegux0gBf+6khphfgwypgCf95/hphfgxy6gCf85zhphegux8gBf+6fhphcgqwkgAgC7XhphcgpwYgCgF7fhohcgpwb
					gDgG7chohcgpwbgDgG7chohcgpwbgDgG7chohcgpwbgDgG7chohcgpwbgDgG7chohcgpwbgDgG7chohcgpwbgDgG7chohcgpwbgDgG7chohcgpwbgDgG7cho
					hcgpwbgDgG7chohcgpwbgDgG7chphcgpwYgCgG7fhphcgpwbgAgD7dhphcgqwvgAgA7Rhphcgqw0gAgA7Nhphcgqw0gAgA7Nhphcgqw0gAgA7N]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAjOhDAPgAgAjtgAjPhHAZgAgAk4gAjThOA3gAgAnUgAjVhSBRgAgAo2gAjVhSBSgAgAo5gAjVhSBSgAgAo5gAjVhSBSgAgAo5gAjVhSBSgAgAo5gAjVhSBS
					gAgAo5gAjghSBSgAgAo5gAjkhSBSgAgAo5gAjghSBSgAgAo5gAjVhSBSgAgAo5gAjVhSBSgAgAo5gAjVhSBSgAgAo5gAjVhSBSgAgAo5gAjVhSBSgAgAo5gA
					jVhRBMgAgAojgAjShMAvgAgAmxgAjPhGAXgAgAkpgAjOhDAPgAgAjt]],
				Spine1 = [[
					gAjWghAPgAgAjtgAjaglAbgAgAlEgAjjguBAgAgAn4gAjog0BggAgAppgAjog1BhgAgAptgAjog1BhgAgAptgAjog1BhgAgAptgAjog1BhgAgAptgAjog1Bh
					gAgAptgAjzg1BhgAgAptgAj3g1BhgAgAptgAjzg1BhgAgAptgAjog1BhgAgAptgAjog1BhgAgAptgAjog1BhgAgAptgAjog1BhgAgAptgAjog1BhgAgAptgA
					jngzBagAgApTgAjhgsA2gAgAnQgAjZgkAYgAgAkzgAjWghAPgAgAjt]],
				Spine2 = [[
					gAjef/gAABgAgAgAjlgEgAADedgAgAjzgPgAAYbMgAgAj8gXgAAxZJgAgAj8gYgAAyZFgAgAj8gYgAAyZFgAgAj8gYgAAyZFgAgAj8gYgAAyZFgAgAj8gYgA
					AyZFgAgAkHgYgAAyZFgAgAkLgYgAAyZFgAgAkHgYgAAyZFgAgAj8gYgAAyZFgAgAj8gYgAAyZFgAgAj8gYgAAyZFgAgAj8gYgAAyZFgAgAj8gYgAAyZFgAgA
					j6gWgAArZigAgAjwgMgAASb7gAgAjkgDgAADewgAgAjef/gAABgAgA]],
				Spine3 = [[
					gAjefggAABgAgAgAjoflgAAEeRgAgAj9fxgAAeaogAgAkJf7gAA9YVgAgAkKf8gAA+YRgAgAkKf8gAA+YRgAgAkKf8gAA+YRgAgAkKf8gAA+YRgAgAkKf8gA
					A+YRgAgAkUf8gAA+YRgAgAkZf8gAA+YRgAgAkUf8gAA+YRgAgAkKf8gAA+YRgAgAkKf8gAA+YRgAgAkKf8gAA+YRgAgAkKf8gAA+YRgAgAkKf8gAA+YRgAgA
					kHf5gAA2YxgAgAj4fugAAWbbgAgAjmfkgAADengAgAjefggAABgAgA]],
				Neck1 = [[
					gAjefACMgAgArlgAjrfGCngAgAsngAkHfUDngAgAuvgAkYfgEWgAgAwEgAkYfgEXgAgAwGgAkYfgEXgAgAwGgAkYfgEXgAgAwGgAkYfgEXgAgAwGgAkYfgEX
					gAgAwGgAkjfgEXgAgAwGgAknfgEXgAgAwGgAkjfgEXgAgAwGgAkYfgEXgAgAwGgAkYfgEXgAgAwGgAkYfgEXgAgAwGgAkYfgEXgAgAwGgAkYfgEXgAgAwGgA
					kVfdEMgAgAv0gAkBfQDYgAgAuRgAjpfEChgAgAsagAjefACMgAgArl]],
				Neck2 = [[
					gAkGeVDkgAgAupgAkWedDzgAgAvFgAk3eyETgAgAv/gAlLfCEpgAgAwkgAlMfDEqgAgAwlgAlMfDEqgAgAwlgAlMfDEqgAgAwlgAlMfDEqgAgAwlgAlMfDEq
					gAgAwlgAlWfDEqgAgAwlgAlbfDEqgAgAwlgAlWfDEqgAgAwlgAlMfDEqgAgAwlgAlMfDEqgAgAwlgAlMfDEqgAgAwlgAlMfDEqgAgAwlgAlMfDEqgAgAwlgA
					lHe/ElgAgAwdgAkwetEMgAgAvygAkTebDwgAgAu/gAkGeVDkgAgAup]],
				Neck3 = [[
					gAkxd2DLgAgAt3gAlDd/DIgAgAtwgAlmeXDAgAgAtggAl7epC8gAgAtXgAl7eqC8gAgAtWgAl7eqC8gAgAtWgAl7eqC8gAgAtWgAl7eqC8gAgAtWgAl7eqC8
					gAgAtWgAmGeqC8gAgAtWgAmKeqC8gAgAtWgAmGeqC8gAgAtWgAl7eqC8gAgAtWgAl7eqC8gAgAtWgAl7eqC8gAgAtWgAl7eqC8gAgAtWgAl7eqC8gAgAtWgA
					l3emC9gAgAtZgAleeRDCgAgAtkgAk/d9DIgAgAtxgAkxd2DLgAgAt3]],
				Head = [[
					gAlwdE/fgAgAlmgAmBdN/cgcgFl1gAmjdk/SiLgVmVgAm3d1/IjIgcmpgAm4d2/Oh9gSmrgAm4d2/SgAgAmsgAm4d2/OeDfumrgAm4d2/Ic2fjmqgAm4d2/I
					c2fjmqgAnCd2/OeDfumrgAnHd2/SgAgAmsgAnCd2/Oh9gSmrgAm4d2/IjKgdmqgAm4d2/IjKgdmqgAm4d2/Oh9gSmrgAm4d2/SgAgAmsgAm4d2/OeDfumrgA
					mzdy/KdEflmlgAmcde/UeKfumOgAl9dL/dfqf8lygAlwdE/fgAgAlm]],
				Jaw = [[
					gAkhdA/8gAgAh0gCkydK/zgcgDjdgLlVdk/LiLgYm3gPlqd3+jjFgro+gKlqd4+nh7gbpEgAlpd4+rgAgApFf2lqd4+neFflpEfwlrd4+hc5fUpCfwlrd4+h
					c5fUpCf2l0d4+neFflpEgAl4d4+rgAgApFgKl0d4+nh7gbpEgQlrd4+hjHgspCgQlrd4+hjHgspCgKlqd4+nh7gbpEgAlpd4+rgAgApFf2lqd4+neFflpEfx
					lmdz+rdGfZokf3lNde/WeKfumGf+kvdI/1fqf+jIgAkhdA/8gAgAh0]],
				["UpperLegF.L"] = [[
					eXiOfDyNfGgA6SeXice/vZfFf08BeXi7e8rQfJfe97eXjQe9t5fLfa8zeXjRe9ylfJfm6BeXjRe90tfJfs4XeXjRe9ylfJfm6BeXjRe9t6fLfZ8yeXjRe9qH
					fOfR+VeXjbe9rAfOfT+BeXjge9vkfKfe77eXjbe9ztfJfp5LeXjRe90cfJfs4leXjRe9xKfKfi6+eXjRe9sVfMfW9geXjRe9pzfPfQ+beXjRe9sVfMfW9geX
					jMe8w3fJfj7KeXi0e8yQfHfx6QeXiZfAxofGf66reXiOfDyNfGgA6S]],
				["LowerLegF.L"] = [[
					eVhcfW7NgAgAw0eUhvfc8tgHgIuGeUiYfk+egLgPpveUimfe/TgJgRmoeUiefO+6gHgMoQeUicfF+dgFgGpyeUiefO+6gHgMoQeUinfe/UgIgRmgeUixfn/T
					gHgPmleUi5fl/VgHgQmdeUiyfZ/PgJgQm5eUinfJ+sgGgJpAeUicfG+hgFgHpkeUigfT/GgIgOngeUirfi/WgIgRmYeUiyfo/SgGgPmoeUirfi/WgIgRmYeU
					icfU+8gIgOoIeUiCfP9kgFgHsMeVhofV8JgDgDvNeVhcfW7NgAgAw0]],
				["FootF.L"] = [[
					eVgyfA/dgAgAl0eVhJe//wgIf/j0eVh8e9//gQgAfpeViTey/3gPgBdPeViHel/3gMgBdKeViAef/3gHgBdKeViHel/3gMgBdKeViUey/3gPgBdKeViee8/3
					gNgBdKeVime6/3gOgBdKeVieeu/3gPgBdKeViOei/3gKgBdKeViBef/3gIgBdKeViLep/3gOgBdKeViYe3/3gPgBdKeViee9/3gMgBdKeViYe3/3gPgBdKeV
					iFer/6gNgBdreVhget//gHgAgjeVhAe7/tgEgAkNeVgyfA/dgAgAl0]],
				["UpperLegF.R"] = [[
					hpiOfDyNg6gA6Shpice/xjg6gH6vhpi7e8yqg4gR5+hpjQe9xHg2ge7AhpjRe9sVg0gq9ghpjRe9pzgxgw+bhpjRe9sVg0gq9ghpjRe9xKg2ge6+hpjRe90c
					g3gU4lhpjbe9ztg3gX5Lhpjge9vkg2gi77hpjbe9rAgygt+BhpjRe9qHgygv+VhpjRe9t6g1gn8yhpjRe9ylg3ga6BhpjRe90tg3gU4XhpjRe9ylg3ga6Bhp
					jMe8tyg2gk82hpi0e8r7g5gd9qhpiZfAv4g7gK7whpiOfDyNg6gA6S]],
				["LowerLegF.R"] = [[
					hrhcfW7NgAgAw0hrhrfV8Vf9f8u2hsiIfN93f6f5rehsigfT/Ff4fynmhsirfi/Wf4fvmYhsiyfo/Sf6fxmohsirfi/Wf4fvmYhsigfT/Gf4fynghsicfG+h
					f7f5pkhsinfJ+sf6f3pAhsiyfZ/Pf3fwm5hsi5fl/Vf5fwmdhsixfn/Tf5fxmlhsinfe/Uf4fvmghsiefO+6f5f0oQhsicfF+df7f6pyhsiefO+6f5f0oQhs
					iife/Jf3fwnRhsiPfj+Kf1fyqrhshrfb8ff6f5ukhrhcfW7NgAgAw0]],
				["FootF.R"] = [[
					hrgyfA/dgAgAl0hrhEe6/wf8gBj0hrhpeq//f4gAfphriKep/3fyf/dPhriYe3/3fxf/dKhriee9/3f0f/dKhriYe3/3fxf/dKhriLep/3fyf/dKhriBef/3
					f4f/dKhriOei/3f2f/dKhrieeu/3fxf/dKhrime6/3fyf/dKhriee8/3fzf/dKhriUey/3fxf/dKhriHel/3f0f/dKhriAef/3f5f/dKhriHel/3f0f/dKhr
					iNez/6fxf/drhrhxe+//fwgAgjhrhFe//tf5gBkNhrgyfA/dgAgAl0]],
				Tail1 = [[
					gAjDhskFgAgA/ugAjChulEg6f7/kgAi/hznFjTgB/BgAi+h1oahigG+1gAi+h1obdEf0+ugAi+h1oWbAfr+egAi+h1obdEf0+ugAi+h1ochjgG+0gAi+h1oX
					kwgU+ggAjJh1oZkDgR+mgAjNh1odgAgA+2gAjJh1oZb9fv+mgAi+h1oXbQfs+ggAi+h1ocedf6+0gAi+h1obi8gM+ugAi+h1oWlAgV+egAi+h1obi8gM+ugA
					i+h1oKejf7+5gAjAhympdNgD/KgAjChuk4fSgE/ngAjDhskFgAgA/u]],
				Tail2 = [[
					gAi6iRksgAgA/pgCi2iSlfhcf3/fgIiviUm/mtf6+fgEiriWoGk7gK+jf5iriVoLcIfx+rf1iriUn2Wlfk9jf5iriVoAYuft+GgEiriWoPg7gG+5gLiriUn7
					oVga92gJi2iVn4o4gY9tgAi6iWoOiJgD+2f3i2iVoDZkfr+Sf1iriUn0Wafl9ff8iriWoIbCf1+igHiriVoLj4gP+rgLiriUn2pbgc9jgHiriVoAnSgT+Gf9
					isiWoAfJf7+9f6ixiUmsbEgK+5f+i3iSlUeagM/ggAi6iRksgAgA/p]],
				Tail3 = [[
					gAivi1kVgAgA/sgFipi2k8hgf4/kgXifizl6pif/99gPiZi1mrpbgX91fwiYi1nEdYfo/FfgiaivmaTmfN8xfpiZizmdT9fb87gGiYi3nFeOgI/Jgeiaiwmp
					qFgu9ngdikiwmStagu8WgFini2m8l+gJ+pfoikizm5ZSfb+gfgiaivmRSefN8SfxiYi1mtWgfo9zgQiYi1nEiogY/Fggiaivmasagz8xgXiZizmdsDgl87f7
					iZi3m5hqf4/Mfuihi1l1aAgF+4f7iqi2k0digQ/igAivi1kVgAgA/s]],
				Tail4 = [[
					gAikjZg2gAgA/+gJiejahShGgD/8gsiSjQh+rOhS93gkiKjRiUt4iA8qfqiIjXi2gpfk/2fFiNjGiXSsdc84fPiMjLiJP/de7fgCiHjYixaCfh/Tg0iMjMim
					pmiD+Vg6iYjGiFwliz7IgTiXjWijqlhW+DfZiUjSiybPes/efDiOjEiKQVdN7qfciKjRiUSAd98mgWiIjXi2fXgc/2g7iNjGiXtUik84gxiMjLiJwBii7ff+
					iJjZipllgb/YfhiUjVh8aOfW/Zf1ifjZhMc2f+/0gAikjZg2gAgA/+]],
				Tail5 = [[
					gAiij/b2gAgA/ugLibkAcGgRgG/whFiPjscwrOjS9mhCiHjodFw/lQ6bfriBj8dIlIgr/ceoiLjfdHUNbQ9NeuiKjddFN5aB5hf0iBj7dHVida9+hKiHjqdI
					myjQ+9hbiXjXdFxjmH54gqiSjzdGukkM8BfNiOj2dIfGeo/0eiiNjYdGQkaS7Re+iHjodFO4ar6VgViBj8dIa4fV/chYiLjfdHrzkw9NhSiKjddFyHl/5hgL
					iDj8dBp0iX+NfTiQj5cjbzeo/ffuicj/cEcgfa/jgAiij/b2gAgA/u]],
				["UpperLegB.L"] = [[
					eaiMhD7WekgAwieaiNhC64epgBxSeaiTg/5Ye2gHzceaiXg92/fHgQ2PeaiXg92sfIgR2ieaiXg92sfIgR2ieaiXg92sfIgR2ieaiXg92sfIgR2ieaiXg92s
					fIgR2ieaihg92sfIgR2ieaimg92sfIgR2ieaihg92sfIgR2ieaiXg92sfIgR2ieaiXg92sfIgR2ieaiXg92sfIgR2ieaiXg92sfIgR2ieaiXg92sfIgR2iea
					iWg930fBgN1VeaiRg/5zezgFy3eaiNhC6+eogBxIeaiMhD7WekgAwi]],
				["LowerLegB.L"] = [[
					eXhcgqw0gAgA7NeXhdgsxLf/f+6/eYhfgxyuf7f458eYhhg71gfxfw3seYhhg811fwfv3YeYhhg811fwfv3YeYhhg811fwfv3YeYhhg811fwfv3YeYhhg811
					fwfv3YeYhsg811fwfv3YeYhwg811fwfv3YeYhsg811fwfv3YeYhhg811fwfv3YeYhhg811fwfv3YeYhhg811fwfv3YeYhhg811fwfv3YeYhhg811fwfv3YeY
					hhg30if1fz4ieYhegvyPf8f56SeXhdgrxFf/f+7DeXhcgqw0gAgA7N]],
				["FootB.L"] = [[
					eXgyhA/ZgAgAmJeXgyhA/Zf+gAmJeXgyhA/Zf3gCmJeXgyhA/ZfrgEmIeXgyhA/ZfpgEmIeXgyhA/ZfpgEmIeXgyhA/ZfpgEmIeXgyhA/ZfpgEmIeXgyhA/Z
					fpgEmIeXg8hA/ZfpgEmIeXhBhA/ZfpgEmIeXg8hA/ZfpgEmIeXgyhA/ZfpgEmIeXgyhA/ZfpgEmIeXgyhA/ZfpgEmIeXgyhA/ZfpgEmIeXgyhA/ZfpgEmIeX
					gyhA/ZfvgDmIeXgyhA/Zf5gBmJeXgyhA/Zf/gAmJeXgyhA/ZgAgAmJ]],
				["UpperLegB.R"] = [[
					hmiMhD7WhcgAwihmiNhC64hXf/xShmiTg/5YhKf5zchmiXg92/g5fw2PhmiXg92sg4fv2ihmiXg92sg4fv2ihmiXg92sg4fv2ihmiXg92sg4fv2ihmiXg92s
					g4fv2ihmihg92sg4fv2ihmimg92sg4fv2ihmihg92sg4fv2ihmiXg92sg4fv2ihmiXg92sg4fv2ihmiXg92sg4fv2ihmiXg92sg4fv2ihmiXg92sg4fv2ihm
					iWg930g/fz1VhmiRg/5zhNf7y3hmiNhC6+hYf/xIhmiMhD7WhcgAwi]],
				["LowerLegB.R"] = [[
					hphcgqw0gAgA7NhphdgsxLgBgC6/hohfgxyugFgI58hohhg71ggPgQ3shohhg811gQgR3Yhohhg811gQgR3Yhohhg811gQgR3Yhohhg811gQgR3Yhohhg811
					gQgR3Yhohsg811gQgR3Yhohwg811gQgR3Yhohsg811gQgR3Yhohhg811gQgR3Yhohhg811gQgR3Yhohhg811gQgR3Yhohhg811gQgR3Yhohhg811gQgR3Yho
					hhg30igLgN4ihohegvyPgEgH6ShphdgrxFgBgC7Dhphcgqw0gAgA7N]],
				["FootB.R"] = [[
					hpgyhA/ZgAgAmJhpgyhA/ZgCgAmJhpgyhA/ZgJf+mJhpgyhA/ZgVf8mIhpgyhA/ZgXf8mIhpgyhA/ZgXf8mIhpgyhA/ZgXf8mIhpgyhA/ZgXf8mIhpgyhA/Z
					gXf8mIhpg8hA/ZgXf8mIhphBhA/ZgXf8mIhpg8hA/ZgXf8mIhpgyhA/ZgXf8mIhpgyhA/ZgXf8mIhpgyhA/ZgXf8mIhpgyhA/ZgXf8mIhpgyhA/ZgXf8mIhp
					gyhA/ZgRf9mIhpgyhA/ZgHf/mJhpgyhA/ZgBgAmJhpgyhA/ZgAgAmJ]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAjOhDAPgAgAjtgAjOhRAWgAgAkmgAjOhcAegAgAlXgAjOhbAdgAgAlQgAjOhWAagAgAk+gAjOhRAYf6e3kogAjOhNAWf2ebkWgAjOhLATf7fKkNgAjOhKAS
					gAgAkJgAjPhHARf1gKj9gAjfhEAWdcgTjwgAj8hDBCY8g1jngAkXhDCwTnhdjagAknhDFNO8h/jIgAkuhDHUMAiVi4gAkwhDIBLLibizgAkuhDHaL5iWi4gA
					kthDG4MkiRi7gAkuhDHWL+iVi4gAkwhDIALMibizgAkwhDICLKicizgAkwhDICLKicizgAkwhDICLKicizgAkwhDICLKicizgAkwhDICLKiciz]],
				Spine1 = [[
					gAjWghAPgAgAjtgAjYgvAWgAgAkmgAjZg7AegAgAlXgAjZg5AdgAgAlQgAjZg1AagAgAk+gCjYgwAYf6e3kogDjXgrAWf2ebkWgCjXgpATf7fKkNgAjXgoAS
					gAgAkJgAjYglARf1gKj9f/jngiAWdbgNjwf8kDghBCY6gkjrf6kdghCyTjhBjmf5kqghFQO4hcjff4kwghHZL8hujYf4kxghIGLHhzjWf4kwghHeL1hvjYf4
					kvghG8MghqjZf4kwghHaL6hujYf4kxghIELIhzjWf4kxghIGLGhzjWf4kxghIGLGhzjWf4kxghIGLGhzjWf4kxghIGLGhzjWf4kxghIGLGhzjW]],
				Spine2 = [[
					gAjef/gAABgAgAgAjigNgAACfHgAgAjlgagAAEeVgAgAjlgYgAADecgAgAjjgTgAADeugAgFjigOf+ADfEe3gHjhgJf+AEfXebgEjggHf/ACfgfKgAjggGgA
					ABfkgAf/jggDgMABfwgIf+jwgAilAIf7f0f5kLf/nHA1f5fff1kjf/sfCkfpfJfykvf/xKFDfSe4fwkzf/0HHMfAexfwk0f/08H5e6evfwkzf/0OHRe/exfx
					kyf/zjGvfEeyfwkzf/0JHNfAexfwk0f/07H4e6evfwk0f/09H5e6evfwk0f/09H5e6evfwk0f/09H5e6evfwk0f/09H5e6evfwk0f/09H5e6ev]],
				Spine3 = [[
					gAjefggAABgAgAgAjjfugAACfHgAgAjof7gAAEeVgAgAjof5gAADecgAgAjmf0gAADeugAgHjkfvf+ADfEe3gKjifqf+AEfXebgFjhfof/ACfgfKgAjhfngA
					ABfkgAf/jhfkgMABfwgIf+jwfhilAIf7fuf6kLfgnHA1f1fPf2kkfgseClfdetfzkxfgxJFFe8eVfxk2fg0FHOegeJfxk3fg06H7eXeHfxk2fg0MHUefeJfx
					k1fgzhGxemeLfxk2fg0HHPegeJfxk3fg05H6eXeHfxk3fg07H8eXeHfxk3fg07H8eXeHfxk3fg07H8eXeHfxk3fg07H8eXeHfxk3fg07H8eXeH]],
				Neck1 = [[
					gAjefACMgAgArlgAjlfPC4gAgAtOgAjsfcDkgAgAuogAjrfaDdgAgAubgAjofVDNgAgAt7gJjmfQC8fle8tTgNjjfLCufbeiswgHjifJClfsfNshgAjifICh
					gAgAsZf/jhfECYf4gMsCf+jwfBCTdjg0rkf8kMfAC3ZPiNrIf4kmfBEfUIjzqff1k1fBGzPqlLpsfyk6fBI1M1mBpEfxk8fBJfMCmRo3fyk7fBI6MvmDpCfz
					k6fBIZNYl3pMfyk7fBI2M0mCpDfxk8fBJeMEmQo3fxk8fBJgMCmRo2fxk8fBJgMCmRo2fxk8fBJgMCmRo2fxk8fBJgMCmRo2fxk8fBJgMCmRo2]],
				Neck2 = [[
					gAkGeVDkgAgAupgAkSeoE5gAgAw+gAkce5GNgAgAy6gAkae3GAgAgAyogAkXewFhgAgAx8gMkSepE+fdfAxEgRkOejEifQenwUgJkNegETfmfQv+gAkMeeEM
					gAgAv0f+kKeaD6f6gOvSf4kXeWDpduhNulfskweUECZsjOtzfelCeUFZU3lfsqfTlHeUHaQmnWrRfOlFeTJMN5ocqLfNlEeTJyNHovp0fOlFeTJRNyoeqIfP
					lGeUI0OaoPqZfOlFeTJNN3ocqKfNlEeTJxNIovp1fNlEeTJzNHovp0fNlEeTJzNHovp0fNlEeTJzNHovp0fNlEeTJzNHovp0fNlEeTJzNHovp0]],
				Neck3 = [[
					gAkxd2DLgAgAt3gAlCeQE5gAgAw/gAlPepGsgAgAzjgAlNelGagAgAzLgAlJedFwgAgAySgOlDeSFAfcfAxIgUk+eKEbfQenwHgLk7eFEHfnfQvpgAk6eDD/
					gAgAvcf9k4d9Dnf6gOuvfxlCd3DPdwhStwfZlWd0DhZxjYstfAlfdyEwU/lprReulYdxGoQvnapjemlOdwIUOBoYoPellKdwI3NPoon1emlNdwIYN6oaoMeo
					lQdwH9OioMogemlOdwIUN/oYoOellKdwI2NQonn1ellKdwI4NOoon0ellKdwI4NOoon0ellKdwI4NOoon0ellKdwI4NOoon0ellKdwI4NOoon0]],
				Head = [[
					gAlwdE/fgAgAlmgAmKdu//gAgAgkgAmceV/wgAgAcJgAmaeP/1gBgAczgAmTeB/8gAgAeXgRmLdw/8efgogRgYmDdj/2d1g+h3gNl/db/2e0gjiugAl9dY/1
					gAgAjGf8l5dP/tgZf5kOfnmAdE/XingClue+mLc/+anHgVm5eUmGc78bsThAn9d6ltc45vwqh/o4dwlVc23hzUi2pcdvlNc12z0DjJpmdwlUc23bzai4pddy
					lac23/y0iqpVdwlUc23gzVi3pcdvlNc1200CjIpldvlNc12y0DjJpmdvlNc12y0DjJpmdvlNc12y0DjJpmdvlNc12y0DjJpmdvlNc12y0DjJpm]],
				Jaw = [[
					gAkhdA/8gAgAh0gAlAdS//gAgAfcgAlddm/4gAgAdWgAlZdj/6gBgAdqgAlOdb/8gAgAeZgLlCdT/8eggrfRgPk4dN/5d4hGf/gIkzdJ/9e3gogbgAkwdI//
					gAgAgof+krdE/9gZf3hNfzkydB/ximfyiofglEdB+2nHfzklfMlPdC8usVggmyfAlLdD50wrh2oqe8lEdE3YzRjHpxe7lBdF2mz+jjqDe8lDdE3SzXjKpze8
					lFdE35yyi2pke8lEdE3XzTjIpxe7lBdF2nz+jiqDe7lBdF2lz/jjqDe7lBdF2lz/jjqDe7lBdF2lz/jjqDe7lBdF2lz/jjqDe7lBdF2lz/jjqD]],
				["UpperLegF.L"] = [[
					eXiOfDyNfGgA6SeXiVfNzpfGf95PeXicfW02fGf64PeXibfV0rfGf64ZeXiZfR0QfGf74wehiWfGzteKgm5IekiUfAzOdzg35deeiSfDzBeZgd5qeXiSfIy7
					fGf+5xeXiQfGylfTgF6BekiQfCx3gSiU6bfAiXe+w0iOmf6Wfpike6vYkNri5OgRi1e2t4lswC3RgrjEe0s0mey61cgyjKezsgmrzu01gsjFe0symgzA1Xgm
					jBe0tCmVyW11grjEe0s0mfy71bgyjKezsgmrzt02gyjKezsgmrzu00gyjKezsgmrzu00gyjKezsgmrzu00gyjKezsgmrzu00gyjKezsgmrzu00]],
				["LowerLegF.L"] = [[
					eVhcfW7NgAgAw0eVhifa8HgAgAvReVhnfe80gAgAt4eVhmfd8ugAgAuGeVhkfc8egAgAuledhifT8IfZg+vMeghhfP71fLhWvsebhffS7ufkguv8eVhffY7q
					gAgAwDeVhefY7dgOgAwaephffW7AiChow9fRhqfV6ElgklxHgGiAfV4ZpdoPwdg2icfU2TsyrjvJhSi0fU0mu0trt3hai8fT0DvYuStbhTi1fU0iu5twt0hN
					ivfU08uctRuJhTi1fU0lu1ttt3hai8fT0EvYuStchai9fT0DvZuTtbhai9fT0DvZuTtbhai9fT0DvZuTtbhai9fT0DvZuTtbhai9fT0DvZuTtb]],
				["FootF.L"] = [[
					eVgyfA/dgAgAl0eVg6fA/vgAgAkDeVhCfA/5gAgAifeVhBfA/4gAgAiueVg+fA/0gAgAjSefg7e5/ufzhIj9ejg4e2/ofuhkkiecg2e7/nf2g1k0eVg2fA/n
					gAgAk8eWg0fB/igNf7lWewg1fB/UiegymBflhDfD+fmyiRmggnhifF8trzkPmghgiLfG6RwHmImCh/itfH4OyxnYldiIi4fI3jzhnvlQiBiufH4Jy3nblch6
					imfH4pyRnIlmiAitfH4NyznZldiHi4fI3kzgnvlQiIi4fI3jzinwlPiIi4fI3jzinwlPiIi4fI3jzinwlPiIi4fI3jzinwlPiIi4fI3jzinwlP]],
				["UpperLegF.R"] = [[
					hpiOfDyNg6gA6ShpiVfNzpg6gD5PhpicfW02g6gG4PhpibfU0rg6gF4ZhpiZfR0Qg6gF4whyiVfVztf+gt5Mh1iTfVzOfng85jhviSfOzBgOgh5thpiSfIy7
					g6gC5xhoiTfFylhHgG6BhziyfFx3iHiS6Xh9jxfIwzkFmY6Kh6k6fMvWmMrT48hplxfQtynzvr28hWmPfTsqouye1HhPmXfUsUo+zQ0ghVmQfTsnowyk1Dha
					mJfSs4ojx81ghVmPfTspouyf1GhPmXfUsUo9zP0hhPmXfUsTo+zR0ghPmXfUsTo+zR0ghPmXfUsTo+zR0ghPmXfUsTo+zR0ghPmXfUsTo+zR0g]],
				["LowerLegF.R"] = [[
					hrhcfW7NgAgAw0hrhifa8HgAgAvRhrhnfe80gAgAt4hrhmfd8ugAgAuGhrhkfc8egAgAulhzhifi8IfZg+vMh2hgfk71fLhWvshxhffe7ufkguv8hrhffY7q
					gAgAwDhshgfW7dgOgAwah9iBfZ7DiChnw3iTjGfe6Pljkhw2ickZfl4rpnoEwCiSldfr2qtFrOumiBmEfw1AvOtPtQh7mOfx0ev1tzsziAmFfw08vTtTtMiF
					l9fv1Wu0s2tiiBmEfw0/vPtQtPh7mOfx0ev0tyszh7mPfx0dv1t0syh7mPfx0dv1t0syh7mPfx0dv1t0syh7mPfx0dv1t0syh7mPfx0dv1t0sy]],
				["FootF.R"] = [[
					hrgyfA/dgAgAl0hrg6fA/vgAgAkDhrhCfA/5gAgAifhrhBfA/4gAgAiuhrg+fA/0gAgAjSh1g6fI/ufzhIj9h4g3fL/ofuhkkihyg2fG/nf2g1k0hrg2fA/n
					gAgAk8hsg3fA/igNf7lViEhXfE/Viegxl6imigfL+jmziNmMi9j8fU80r4kCl/i7lMfb6awQlulYiul9fh4Yy/m0kviomKfi3tzwnIkgitl+fh4SzFm2ktix
					lzfg4zydmmk4itl9fh4XzAm0kuiomKfi3uzvnHkginmLfi3tzxnIkginmLfi3tzxnIkginmLfi3tzxnIkginmLfi3tzxnIkginmLfi3tzxnIkg]],
				Tail1 = [[
					gAjDhskFgAgA/ugAjBh4k+gAgA/mgAi/iDlvgAgA/egAi/iClogBgA/fgAjAh+lWgAgA/if9jBh5lAeHgM/if8jCh1ktdYgS/if+jChzklemgK/ogAjChykh
					gAgA/qgAjEhvkVgRgK/sgCjVhtkJgdij/ngFjyhsj/hRnA+7gIkQhsjqiOsT9OgKkihsjKjDw76zgKkshsitjjz14tgKkuhsikjs0q4BgKkshsisjkz84ngK
					kqhsizjdzR5JgKkshsitjjz24rgKkuhsikjs0o4CgKkuhsikjs0q4AgKkuhsikjs0q4AgKkuhsikjs0q4AgKkuhsikjs0q4AgKkuhsikjs0q4A]],
				Tail2 = [[
					gAi6iRksgAgA/pgAi1idlkgAgA/ggAiyinmVgAgA/WgAiyilmOgBgA/YgAiziil9gAgA/bf5i1idlmdWgU/Yf2i2iZlScWge/Vf7i3iXlLeDgR/ggAi3iXlI
					gAgA/lgBi6iUk8gYgJ/mgEjLiRkxgoih/hgKjqiRklhwm7+2gQkKiQkHjGsJ9JgUkgiQjYkOwt6vgVksiQiuk6zk4rgVkviQiglG0Y3/gVksiQisk7zr4mgV
					kqiQi3kyzB5HgVksiQiuk6zm4qgVkviQiglF0X4AgVkviQiglG0Z3/gVkviQiglG0Z3/gVkviQiglG0Z3/gVkviQiglG0Z3/gVkviQiglG0Z3/]],
				Tail3 = [[
					gAivi1kVgAgA/sgAiojAlNgAgA/kgAijjKl/gAgA/bgAikjJl3gBgA/cgAimjFlmgAgA/ffziojAlOcmgX/Yfuiqi8k6bTgj/Qf2iri7k0dfgT/hgAiri7kx
					gAgA/ogCiui4klgegI/qgGjAi2kcgvig/kgQjgi1kPiCm5+4gakEi0jrjlsF9Lggkei0iyk4wm6xgikui0h+lqzb4sgikzi0htl30O4Bgikvi0h8lrzi4ngi
					kri0iJlhy45Igikui0h+lqzd4rgikzi0htl30N4Cgikzi0htl30P4Bgikzi0htl30P4Bgikzi0htl30P4Bgikzi0htl30P4Bgikzi0htl30P4B]],
				Tail4 = [[
					gAikjZg2gAgA/+gAicjkhvgAgA/8gAiVjtihgAgA/5gAiWjsiZgCgA/5gAiYjpiIgAgA/7fricjjhxb0f//qfjiejeheaOgC/bfwigjfhWc6gC/0gAigjfhS
					gAgA/9gDijjchGgkgL/9gIi2jag/glik/3gXjYjZg2honE/Jglj/jYgYi4sX9XgtkfjYfjj6w962gvkzjXezkfz04rgvk4jXejko0n3+gvkzjXexkgz64mgv
					kvjXe+kYzR5JgvkzjXezkfz14qgvk4jXekko0m3/gvk4jXejko0o3+gvk4jXejko0o3+gvk4jXejko0o3+gvk4jXejko0o3+gvk4jXejko0o3+]],
				Tail5 = [[
					gAiij/b2gAgA/ugAiYkKcvgAgA/0gAiPkTdhgAgA/5gAiQkRdZgCgA/4gAiTkOdIgAgA/3fhiYkHc0bIfO/cfVibkBclZRe//EfpickEcYcYfe/kgAidkFcT
					gAgA/xgFihkCcHgogS/vgKi0kAcCgTip/ogbjXj/cAg3nR+4gskBj+bthjsu8/g0klj9bHiExZ6Ug1k7j8aiiV0S4Ag1lCj7aWiY1G3Qg1k8j8ahiV0Z37g2
					k3j8aqiSzv4gg1k8j8aiiV0U3/g1lCj7aWiY1E3Rg1lCj7aWiY1G3Qg1lCj7aWiY1G3Qg1lCj7aWiY1G3Qg1lCj7aWiY1G3Qg1lCj7aWiY1G3Q]],
				["UpperLegB.L"] = [[
					eaiMhD7WekgAwieaiMhN8Oekf7u/eaiMhV87ekf2tmeaiMhU80elf3tzeaiMhR8lekf5uTeaiMhG8Pd+g5u2eaiMhA79dwhTvVeaiMhD72eIgrvoeaiMhI7y
					ekf9vyebiMhH7oezf9wFemiOhE7ugzhRv6fBiUhD7vk2jTu0foighD6+p4lYtAgRiuhD5Yuem2rFgri8hD30xenkprgzjBhD3RyVnvpQgsi9hD3wxlnmpogm
					i5hD4Kw5ncp9gsi8hD3zxfnlprgzjBhD3SyUnvpRgzjBhD3RyWnvpQgzjBhD3RyWnvpQgzjBhD3RyWnvpQgzjBhD3RyWnvpQgzjBhD3RyWnvpQ]],
				["LowerLegB.L"] = [[
					eXhcgqw0gAgA7NeXhfgvyUgAgA6PeXhjgzzkgAgA5TeXhigzzYgAgA5ceXhhgxy8gAgA5yeahggoyYfCgn6Keahfgjx4eqg16eeZhegnxqfSgc6qeXhegtxk
					gAgA6veYhdgsxRgOgF67erhggpxLhYiL63fShrgmxQj8l75+gFiAgiw7nLqO4Gg0ibgfwCqNt01thQiygevHsPv/zvhYi6gduxs1wmzHhRizgdvEsUwEzqhL
					itgevUr2vl0JhQiygevGsQwBzuhYi5gduys0wlzIhYi6gduxs2wmzGhYi6gduxs2wmzGhYi6gduxs2wmzGhYi6gduxs2wmzGhYi6gduxs2wmzG]],
				["FootB.L"] = [[
					eXgyhA/ZgAgAmJeXgzg//sgAgAkYeXg1g//3gAgAi0eXg1g//2gAgAjDeXg0g//ygAgAjneYgzg4/rfyhIkSeZgzg1/lfthjk3eYgzg6/kf2g1lJeXgyg//j
					gAgAlReZgyhA/fgOf5lneyg1g9/YiigeloflhDg4+ynBhJk+glhhgz9MsYhrj8hdiIgt60xFh5i+h9iogq4v0Dh4iUiFizgp4D05h2iIh+iqgq4q0Kh4iTh3
					iigr5Mzfh5ich9ipgq4u0Fh4iUiFizgp4E04h2iJiFizgp4D06h2iIiFizgp4D06h2iIiFizgp4D06h2iIiFizgp4D06h2iIiFizgp4D06h2iI]],
				["UpperLegB.R"] = [[
					hmiMhD7WhcgAwihmiMhN8OhcgFu/hmiMhV87hcgKtmhmiMhU80hcgJtzhmiMhR8lhcgHuThmiLhV8Pg2hEu9hmiLhU79gohavehmiMhO72hAgxvthmiMhI7y
					hcgDvyhniOhF7mhrgAwFhwiuhE7ZjqhVwDh5jthD64nnjhvMh3kzhD5gsYl3tnhnlnhD3bwnnrr1hWmEhD1kzUorqehQmMhD090Go8qDhVmFhD1fzbotqaha
					l/hD19yzogqvhWmEhD1jzWosqdhQmMhD0+0Fo7qDhQmMhD080Go8qChQmMhD080Go8qChQmMhD080Go8qChQmMhD080Go8qChQmMhD080Go8qC]],
				["LowerLegB.R"] = [[
					hphcgqw0gAgA7NhphfgvyUgAgA6PhphjgzzkgAgA5ThphigyzYgAgA5chphhgxy8gAgA5yhqhfg3yYfCgn6Khrheg4x4eqg16ehqhegyxqfSgc6qhphegtxk
					gAgA6vhqhggrxQgOgF67h5iBgqxFhYiM67iPjFgnxAj4l+6JiYkWglwgnAqW4ZiPlYgjvgp3uE2Gh/l+ghugrwwW0Lh5mJghuLsTw/zkh+l/ghuer1wc0GiC
					l3ghuurZv70lh+l+ghugrxwY0Kh5mIghuLsTw+zlh4mJghuKsUxAzjh4mJghuKsUxAzjh4mJghuKsUxAzjh4mJghuKsUxAzjh4mJghuKsUxAzj]],
				["FootB.R"] = [[
					hpgyhA/ZgAgAmJhpgzg//sgAgAkYhpg1g//3gAgAi0hpg1g//2gAgAjDhpg0g//ygAgAjnhpgzhH/rfyhIkShpgyhK/lfthjk3hpgyhF/kf2g1lJhpgyg//j
					gAgAlRhrg1g+/fgOf5loiAhXg+/Xiigelviiieg6+vnBhNlSi4j3g29HsWh5kdi3lFgz6vxBiUjoirl1gw4qz/iejDilmCgv3+01igi5iql3gw4l0GifjCiu
					lsgx5GzbidjLiql1gw4p0BiejDilmCgv3/0zigi5ilmCgv3+01igi4ilmCgv3+01igi4ilmCgv3+01igi4ilmCgv3+01igi4ilmCgv3+01igi4]],
			},
		},
	},
}
