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
					gAj3hTALgDgZjJgAj4hTALgEgajJgAj4hTALgEgbjJgAj5hTALgEgajJgAj5hTALgDgZjJgAj6hTALgDgYjJgAj6hTALgDgVjJgAj6hTALgDgTjJgAj7hTAL
					gCgQjJgAj7hTALgCgMjKgAj7hTALgBgIjKgAj7hTALgBgEjKgAj7hTALgAgAjKgAj6hTALf/f8jKgAj6hTALf/f4jKgAj6hTALf+f0jKgAj5hTALf+fwjJgA
					j5hTALf9ftjJgAj4hTALf9frjJgAj4hTALf9fojJgAj3hTALf9fnjJgAj2hTALf8fmjJgAj2hTALf8fljJgAj1hTALf8fmjJgAj1hTALf9fnjJgAj0hTALf9
					fojJgAj0hTALf9frjJgAj0hTALf9ftjJgAjzhTALf+fwjJgAjzhTALf+f0jKgAjzhTALf/f4jKgAjzhTALf/f8jKgAjzhTALgAgAjKgAj0hTALgBgEjKgAj0
					hTALgBgIjKgAj0hTALgCgMjKgAj1hTALgCgQjJgAj1hTALgDgTjJgAj2hTALgDgVjJgAj2hTALgDgYjJ]],
				Spine1 = [[
					f/j/gpALgDgZjJf/kAgpAMgEgajPf/kBgpAMgEgbjUf/kBgpANgEgajaf/kCgpANgEgZjef/kCgpAOgDgYjjf/kDgpAOgDgVjmf/kDgpAOgDgTjpf/kDgpAP
					gCgQjrf/kDgpAPgCgMjtgAkDgpAPgBgIjtgAkDgpAPgBgEjtgAkDgpAPgAgAjrgAkDgpAOf/f8jpgAkDgpAOf/f4jmgBkCgpAOf+f0jjgBkCgpANf+fwjegB
					kBgpANf9ftjagBkBgpAMf9frjUgBkAgpAMf9fojPgBj/gpALf9fnjJgBj/gpALf9fmjEgBj+gpAKf9fli+gBj+gpAKf9fmi5gBj9gpAJf9fni1gBj9gpAJf9
					foiwgBj8gpAIf9fqitgBj8gpAIf+ftiqgBj8gpAIf+fwiogBj8gpAIf/f0imgAj8gpAIf/f4imgAj8gpAIgAf8imgAj8gpAIgAgAiogAj8gpAIgAgEiqgAj8
					gpAIgBgIitf/j9gpAJgBgMiwf/j9gpAJgCgQi1f/j+gpAJgCgTi5f/j+gpAKgDgVi/f/j/gpALgDgYjE]],
				Spine2 = [[
					f+kIf+/6gBfniKf+kJf+/7gBfmh+f+kKf+/8gBflh0f+kKf+/8gAfmhpf+kLf+/9gAfnhgf+kMf+/9gAfohXf+kMf+/9gAfqhQf+kNf+/+gAfthKf/kNf+/+
					gAfwhGf/kNf+/+gAf0hDf/kNf+/+gAf4hCgAkNf+/+gAf8hDgAkNf+/+gAgAhGgAkNf+/+gAgEhKgBkMf+/9gAgIhQgBkMf+/9gAgMhXgBkLf+/9gAgQhggC
					kKf+/8gAgThpgCkKf+/8gAgWh0gCkJf+/7f/gYh+gCkIf+/6f/gZiKgCkHf+/5f/gaiVgCkGf+/5f/gbiggCkGf+/4f/gaiqgCkFf+/3f/gZizgCkEf+/2f/
					gYi8gCkEf+/2f/gWjDgCkDf+/1f/gTjJgBkDf+/1f/gQjNgBkDf+/0f/gMjQgBkDf+/0f/gIjRgAkDf+/0gAgEjQgAkDf+/1gAgAjNgAkDf+/1gAf8jJf/kE
					f+/2gBf4jDf/kEf+/2gBf0i8f/kFf+/3gBfwi0f+kGf+/4gBftiqf+kGf+/5gBfqigf+kHf+/5gBfoiV]],
				Spine3 = [[
					f9kDfX/6gBfniKf9kEfX/7gBfmh5f9kFfX/8gAflhpf9kGfX/9gAfmhZf9kIfX/9gAfnhLf9kJfX/+gAfog+f9kJfX/+gAfqgzf+kKfX/+gAftgqf+kKfX//
					gAfwgkf/kLfX//gAf0ggf/kLfX//gAf4gff/kLfX//gAf8gggAkKfX//gAgAgkgBkKfX//gAgEgqgBkJfX/+gAgIgzgBkJfX/+gAgMg+gCkIfX/+gAgQhLgC
					kGfX/9gAgThZgDkFfX/8gAgWhpgDkEfX/7f/gYh5gDkDfX/6f/gZiKgDkCfX/5f/gaiagDkAfX/4f/gbirgDj/fX/2f/gai6gDj+fX/1f+gZjIgDj9fY/0f+
					gYjVgDj8fY/zf+gWjggCj8fY/yf/gTjpgCj7fY/xf/gQjvgBj7fY/wf/gMjzgBj7fY/wf/gIj0gBj7fY/xgAgEjzgAj7fY/xgAgAjvf/j8fY/ygAf8jpf/j8
					fY/zgBf4jgf/j9fX/0gBf0jVf+j+fX/1gBfwjIf+j/fX/2gBfti6f9kAfX/4gBfqirf9kCfX/5gBfoia]],
				Neck1 = [[
					f8j+exAYgKhDkqf8kAexAagLhMk1f8kBexAcgMhUlAf8kDexAegNhZlKf8kFexAfgNhclTf8kGexAhgMhelcf9kHexAigMhcljf9kIexAjgLhZlpf+kJexAk
					gKhTltf+kKexAkgJhLlvf/kKexAkgHhClwf/kKexAjgGg2lwgAkJexAigEgqltgBkIexAhgCgclpgBkHexAggBgOljgCkGexAff/f/lcgCkFexAdf9fxlUgD
					kDexAcf7filKgDkBexAbf5fVlAgEkAexAZf3fIk1gEj+exAYf2e9kqgEj8exAXf0e0kfgEj6exAVfzeskUgEj4exAUfyenkKgEj3exATfyekkAgEj1eyASfx
					ejj4gDj0eyARfxekjxgDjzeyAQfyeojrgCjyeyAQfyetjmgCjyeyAPf0e1jkgBjyeyAPf1e/jjgBjyeyAOf3fKjkgAjyeyAOf5fXjnf/jzeyAPf7fkjrf/j0
					eyAPf+fyjxf+j1eyAQgAgBj4f+j3exARgDgQkAf9j4exATgFgekKf9j6exAUgHgrkUf8j8exAWgJg4kf]],
				Neck2 = [[
					f4kRdxBggehppff3kUdxBjgjh7pkf2kWdxBlgmiJppf2kZdxBogoiUpuf2kbdxBqgpicpyf2kddxBrgpifp2f3kedyBtgpifp6f3kgdyBtgnibp9f4khdyBt
					gkiTp/f5khdyBtghiHqAf7kidyBsgdh4qBf8khdyBrgYhmqBf9khdyBpgThSqAf/kgdxBogNg7p+gAkedxBmgHgjp8gCkddxBlgBgKp4gDkbdxBkf7fxp0gF
					kZdxBjf0fYpvgGkWdxBifufBpqgHkUdxBhfoerplgIkRdxBgfieXpfgJkOdxBgfdeGpagKkMdwBffYd4pUgKkKdwBefUdtpPgKkHdwBdfSdmpKgKkFdwBcfQ
					dipGgJkEdwBbfQdjpDgJkCdwBafRdnpAgIkBdwBZfTdvo+gHkBdwBYfXd7o9gFkAdwBXfbeKo9gEkBdwBWfheco+gDkBdwBVfnewo/gBkCdwBVfvfGpBgAkE
					dwBVf2fepEf+kFdwBWf+f2pIf9kHdwBXgFgPpMf7kKdwBZgMgnpQf6kMdwBbgTg/pVf5kOdwBegZhVpa]],
				Neck3 = [[
					fzkwdEBygqiRqOfxkzdFB0gwirqOfwk1dFB2g1jBqNfvk4dGB4g4jRqNfvk6dGB5g6jdqMfvk8dGB6g6jkqMfvk+dHB6g5jkqMfwlAdHB5g3jfqMfylBdHB4
					g0jVqMfzlCdHB2gwjFqNf1lCdHB1gqiwqNf3lCdHBygkiXqOf6lBdGBxgdh7qOf8lAdGBvgVhbqPf/k+dGBugMg5qPgBk8dFBtgEgVqQgEk6dFBtf6fxqQgH
					k4dFBufxfOqQgJk1dFBvfoesqPgLkzdFBwffeMqPgNkwdEByfWdvqOgPktdEB0fPdVqOgQkqdEB2fIdAqNgRkndEB4fCcwqNgRkldEB5e+clqMgRkjdEB6e8
					cgqMgRkhdEB6e7cfqMgQkgdEB5e8clqMgOkedDB4e/cvqNgNkedDB3fEc/qNgLkedDB1fKdTqOgJkedDBzfSdsqOgGkedDBxfbeIqPgEkgdDBvflenqPgBkh
					dDBufwfIqPf+kjdDBtf7frqQf8kldDBtgGgPqQf5kndDBugQgyqQf3kqdEBvgahUqPf1ktdEBwgih0qP]],
				Head = [[
					folmb+/pgkc4jefllpb+/kg0cWjhfilsb//ghDb5jjfglucA/dhRbkjlfelxcA/ahcbVjnfelzcB/YhmbNjpfel1cB/XhtbNjrffl2cB/YhxbVjtfhl3cB/a
					hybjjufkl4cB/dhwb5jwfol4cA/ghrcVjyfsl4cA/khjc3jzfwl3b//ohZdej0f1l2b//rhMeJj0f6l1b+/ug+e3jzgAlzb+/wgufmjygFlxb+/xgdgXjwgK
					lvb+/wgMhHjtgPlsb9/uf8h1jogUlpb+/sfrihjkgYlmb+/pfcjIjegbljb+/lfOjqjYgelhb+/ifCkHjSggleb+/fe3kdjMghlcb+/deuksjHgilab+/cen
					k0jDghlYb+/dejk0i/gglWb+/eegkti8gelVb+/gefkei7gblUb9/jehkIi7gYlUb9/nekjsi8gUlUb8/qeqjKi+gPlVb8/ueyiijBgKlWb8/xe7h3jEgFlY
					b7/zfHhJjIgAlZb7/0fUgZjMf7lcb8/0fjfojQf2leb8/zfye4jUfxlhb8/wgDeKjYfsljb9/tgTdfjb]],
				Jaw = [[
					fmkDbs/vgec3icfjkGbt/qgtcUilfhkJbu/mg8b4isffkLbv/ihKbii0ffkObv/ehWbTi6ffkQbw/chgbLjAfgkSbw/bhnbLjGfikTbw/chsbTjLfkkUbw/d
					htbhjPfnkVbw/ghsb3jRfrkVbw/khncTjTfvkVbw/ohgc1jUf0kUbv/shWdcjUf5kTbv/vhKeHjSf+kSbu/yg8e1jOgDkQbu/0gtfmjJgJkObt/1gegWjDgO
					kMbt/1gOhHi7gSkJbt/0f/h1ixgWkGbs/yfwihingakDbs/vfijJicgdkBbs/sfWjsiRggj+br/pfMkJiGghj8br/mfCkgh7gij5bq/ke7kvhxgij3bq/je1
					k4hoghj1bp/jexk4hhggj0bp/keukxhbgdjzbo/netkihYgajybo/qeukMhWgWjybn/tewjwhXgSjybn/xe0jOhZgNjzbn/1e6imhdgIj0bn/4fBh6higCj1
					bn/6fKhMhpf9j3bo/7fVgbhxf3j5bo/7fifqh5fyj7bp/6fve5iCfuj+bq/3f+eKiLfpkBbr/zgOdfiU]],
				["UpperLegF.L"] = [[
					d6ihe7xGfmgI7Cd6ije5xOfpgJ69d6ile4xWfqgK64d6ine2xffqgK6yd6ioe1xpfpgK6rd7iqezxzfngK6ld7ireyx8fkgK6ed7isexyEfhgJ6Zd8itewyK
					fdgI6Vd8itevyMfYgH6Ud9iteuyKfTgF6Vd+iteuyEfNgD6Zd+iteux6fGgB6fd/iseuxsfAf+6oeAireuxde6f86yeAipevxMezf569eBioevw7etf27HeB
					imewwqeofz7ReCilexwcejfx7aeCijezwPeefu7heCihe0wFebfs7meCife2v+eYfq7qeCiee3v6eXfp7teCice5v5eXfo7teCibe6v6eXfo7teCiZe8v9eZ
					fo7reCiYe9wCebfp7oeBiXe+wIeffr7leBiXe/wOejfs7heAiWfAwVeofu7eeAiWfBwbeufx7ad/iWfBwhe0f07Xd+iXfBwme7f27Vd+iXfBwqfCf57Sd9iY
					fBwufIf87Qd9iZfAwxfPf/7Od8ibe/w0fVgB7Nd8ice+w4fagE7Ld7iee9w8ffgF7Id7ige8xBfjgH7F]],
				["LowerLegF.L"] = [[
					d5hofW9CgzgPtad5hqfU8ug1gOuDd5hrfS8Zg1gMutd5htfP8DgzgLvWd5hufN7tgxgKv+d6hvfL7XgtgIwkd6hwfJ7CgpgHxFd6hxfI6wgjgFxid6hyfG6h
					gdgCx5d7hyfF6WgWgAyJd7hyfF6QgPf/yRd7hyfF6QgIf9yRd7hyfF6WgBf8yJd8hyfG6gf5f7x5d8hxfI6vfyf7xkd8hwfJ7Afrf7xId8hvfL7Ufkf8wpd8
					hufN7pfef9wGd8htfP7+fZf+vgd8hsfR8TfUgAu5d8hqfT8ofQgCuQd8hpfV87fNgDtod8hnfX9NfLgFtBd8hmfY9efLgHsbd8hkfa9sfMgJr3d8hjfb95fP
					gLrXd7hifc+DfSgMq7d7hhfd+MfYgNqjd7hgfe+TfegOqQd7hffe+XflgPqDd7hffe+aftgQp8d7hffe+af2gRp6d6hffe+Zf/gRp/d6hffe+VgIgRqKd6hg
					fd+PgQgRqad6hhfd+IgYgRqwd6hifc9+gggRrKd6hkfa9ygngRrpd6hlfZ9kgsgQsMd5hnfX9UgwgPsy]],
				["FootF.L"] = [[
					d7g+ex/cg0f2l0d7g+ex/cg1f2l0d7g+ex/cg1f2l0d7g+ex/cg0f2l0d7g+ex/cgxf3l0d7g+ex/cgtf4l0d7g+ex/dgof5l0d7g+ex/dgjf6l0d7g+ex/d
					gcf7l0d7g+ex/dgWf8l0d7g+ex/dgOf9l0d7g+ex/dgHf/l0d7g+ex/dgAgAl0d7g+ex/df5gBl0d7g+ex/dfygDl0d7g+ex/dfrgEl0d7g+ex/dfkgFl0d7
					g+ex/dffgGl0d7g+ex/dfZgHl0d7g+ex/dfVgIl0d7g+ex/cfRgJl0d7g+ex/cfPgJl0d7g+ex/cfOgJl0d7g+ex/cfNgJl0d7g+ex/cfPgJl0d7g+ex/cfR
					gJl0d7g+ex/dfVgIl0d7g+ex/dfagHl0d7g+ex/dfhgGl0d7g+ex/dfogEl0d7g+ex/dfwgDl0d7g+ex/df5gBl0d7g+ex/dgCgAl0d7g+ex/dgLf+l0d7g+
					ex/dgTf8l0d7g+ex/dgbf7l0d7g+ex/dgif6l0d7g+ex/dgpf4l0d7g+ex/cguf4l0d7g+ex/cgyf3l0]],
				["UpperLegF.R"] = [[
					h+ihe0wFhlgU7mh9ijeywMhlgT7ih9ilexwWhlgS7ch9imevwjhjgQ7Vh+ioeuwxhhgO7Mh+ipetxBhegM7Dh+iresxQhagK65h/isesxfhVgI6wh/isesxr
					hQgG6oiAitesx1hLgE6iiAitesx6hFgC6eiBitetx8g/gB6eiCiteux6g6f/6fiCisevx1g0f+6jiDirewxugvf86oiEiqeyxmgqf76tiEioezxdglf66ziF
					ine1xWghf564iFile3xPgef568iFije5xKgbf46/iGihe7xGgaf47CiGige8xEgZf37DiGiee+xDgZf47EiGice/xDgaf47EiFibfBxDgcf57EiFiafCxDgf
					f67EiFiYfDxCgjf87EiEiYfDxBgof+7FiEiXfDw+gtgA7GiDiXfDw6gzgC7JiDiWfDw1g5gF7MiCiWfCwug/gH7QiCiXfBwmhFgK7ViBiXfAwehLgM7ZiAiY
					e/wVhRgO7eiAiZe9wOhWgQ7ih/ibe7wHhagS7mh/ice6wDhegT7oh+iee4wBhhgU7ph+ife2wBhkgU7p]],
				["LowerLegF.R"] = [[
					iEhqfT8ogwf+uQiDhsfR8SgxgBu8iDhtfP77gxgDvmiDhvfM7jgwgGwOiDhwfK7NgugIw0iDhxfI63grgJxWiDhxfH6kgngLxziDhyfF6VgigLyKiDhyfE6K
					gcgLyaiEhzfE6EgVgKyiiEhzfE6EgPgJyiiEhyfE6KgHgHyaiFhyfF6Wf/gEyJiFhxfH6mf4gCxxiFhxfJ66fwf/xSiGhwfL7Qfof8wviGhufN7ofhf6wHiG
					htfP8Afbf3vdiGhsfR8XfVf1uyiHhqfU8tfQfzuGiHhofW9CfNfxtaiHhnfX9VfLfwsviHhlfZ9mfKfvsHiHhjfb90fLfuriiHhifc+BfNftrBiHhhfd+LfQ
					ftqkiHhgfe+UfVfsqNiGhffe+afafsp7iGheff+dfhfspviGheff+ffoftpqiGheff+ffwftpqiGheff+df5fupyiGhffe+ZgBfvp/iFhgfe+SgKfwqTiFhh
					fd+JgSfyqsiFhifc9+gZfzrKiFhkfa9xggf1rsiEhlfZ9igmf3sSiEhnfX9Qgqf5s7iEhpfV89guf8tl]],
				["FootF.R"] = [[
					iFg+ex/cgvf3l0iFg+ex/cgwf3l0iFg+ex/cgwf3l0iFg+ex/cgvf3l0iFg+ex/cguf4l0iFg+ex/dgrf4l0iFg+ex/dgnf5l0iFg+ex/dgif6l0iFg+ex/d
					gdf7l0iFg+ex/dgXf8l0iFg+ex/dgQf9l0iFg+ex/dgIf/l0iFg+ex/dgAgAl0iFg+ex/df4gBl0iFg+ex/dfwgDl0iFg+ex/dfogEl0iFg+ex/dfhgGl0iF
					g+ex/dfagHl0iFg+ex/cfUgIl0iFg+ex/cfPgJl0iFg+ex/cfMgKl0iFg+ex/cfJgKl0iFg+ex/cfIgKl0iFg+ex/cfIgKl0iFg+ex/cfKgKl0iFg+ex/cfN
					gJl0iFg+ex/cfSgJl0iFg+ex/dfXgIl0iFg+ex/dfegGl0iFg+ex/dflgFl0iFg+ex/dftgDl0iFg+ex/df2gCl0iFg+ex/df+gAl0iFg+ex/dgHf/l0iFg+
					ex/dgPf9l0iFg+ex/dgXf8l0iFg+ex/dgdf7l0iFg+ex/dgjf5l0iFg+ex/dgof5l0iFg+ex/cgsf4l0]],
				Oiseau = [[
					bzqRgnfzCGghrUbzqRgsf3CGgXrVbzqRgwf7CGgNrVbzqSg0f+CBgDrKb0qSg4gBB1f6qnb0qSg7gDBifypwb0qSg9gFBNfqonb0qSg+gFA3flnRb0qSg/gF
					Ajfglzb0qSg/gEAUfdkUb0qSg+gDAKfci7b0qSg9gCAEfdhtb0qSg7gBACfggwb0qSg4gAABfkgIb0qSg1gAABfqf4b0qSgxgBABfxf0b0qSgtgBABf6fwb0
					qRgogBABgDftb1qRgkgBABgOfqb1qRgfgBABgZfob1qQgagAABgkfnb1qQgVgAACgvfmb1qPgRf/ACg6gBb1qPgNf5AMhEjEb1qOgKfvAvhMmqb1qOgHfyAb
					hVk4b1qNgFfsArhbmTb1qNgDfvAehilIb1qNgCf8AEhog8b1qNgCgAAEhqf4b1qMgDgAAEhrf4b0qNgEgAAEhqf8b0qNgGgAAEhogAb0qNgJgAADhjgEb0qO
					gMgAADhegIbzqOgQgAADhWgMbzqPgVgAADhOgQbzqPgZgAAChEgTbzqQgegAACg6gWbzqQgjgAACgvgY]],
				Arbre1 = [[
					gim/hYOJazgU6Bgim/hZOHalgs58gim/haOGaYhC54ginAhbOGaMhT51ginAhcOIaEhc50ginAhdOKaAhf50ginBheOOaBhZ53ginBheOTaFhM58ginBhfOZ
					aOg46DginBhfOfaZgf6KginBhfOmalgE6SginBhgOsawfp6YginBhfOxa6fQ6dginBhfO1bBe86gginBhfO2bEev6gginAheO0bCep6fginAheOva9es6bgi
					nAhdOoa0e36VginAhcOfanfJ6Ngim/hbOUaYff6Dgim/haOJaJf554gim/hZN+Z5gS5tgim+hYNzZsgq5igim+hXNrZig85Zgim+hWNkZchJ5Sgim9hVNgZb
					hP5Ogim9hUNeZghN5Ogim9hUNfZphD5Rgim9hTNhZ2g05Xgim9hTNmaGgf5egim9hTNsaXgI5ngim9hTNzapfw5vgim9hTN6a4fb53gim9hTOAbGfK5+gim9
					hTOGbPfA6Dgim9hUOJbVe+6Hgim+hVOMbWfD6Jgim+hVOMbTfQ6Jgim+hWOMbLfj6Hgim+hXOKbAf66F]],
				Arbre2 = [[
					fcnIgDOPahgw6BfbnJgEOXawgX6KfbnJgFOfa/f96SfcnKgGOlbNfl6ZfcnLgHOqbXfR6dfcnLgIOsbefD6gfcnMgIOtbfe86gfcnMgJOsbce96ffcnNgJOp
					bUfG6cfdnNgJOkbHfV6XfdnNgJOga3fo6RfdnNgJObalf/6LfdnNgJOXaSgV6EfenMgIOTaAgq59fenMgHORZxg653fenLgGOPZmhF5zfenLgFOOZghJ5wff
					nKgEOOZfhF5wffnJgDOOZjg75xffnJgCOOZrgq50ffnIgBOOZ3gV54ffnHgAOOaEf957ffnGf/ONaSfl59ffnFf+OMagfP5+ffnFf9OJare95+ffnEf8OFa0
					ey59ffnDf8N/a5eu56ffnDf7N5a6ez52ffnDf7Nya4fA5xfenCf7NsayfT5sfenCf7Nmapfr5mfenDf7NiaegG5hfdnDf7NgaTgh5dfdnDf8NgaJg65afdnD
					f9NjaBhO5ZfcnEf9NnZ8hc5bfcnFf+NtZ8hi5ffcnFf/N1Z/hg5lfcnGgAN9aHhW5ufcnHgCOGaThG53]],
				Tail1 = [[
					gBjpiIjagZf8/zgBjqiIjagrf6/zgBjriIjag7f4/ygBjriIjahKf1/ygBjsiIjahYf0/xgBjsiIjahjfy/xgBjsiIjahrfx/xgBjtiIjahxfw/wgBjtiIja
					h0fv/wgBjtiIjah1fv/wgAjtiIjahyfw/wgAjtiIjahtfw/wgAjtiIjahlfy/xgAjtiIjahafz/xgAjsiIjahOf1/yf/jsiIjag/f3/yf/jsiIjagvf5/zf/
					jriIjagdf8/zf/jriIjagLf+/zf/jqiIjaf5gB/zf/jpiIjafngE/zf/jpiIjafVgG/zf/joiIjafFgI/yf/joiIjae2gL/yf/jniIjaeogM/xf/jniIjaed
					gO/xf/jmiIjaeVgP/xf/jmiIjaePgQ/wf/jmiIjaeMgR/wf/jmiIjaeLgR/wgAjliIjaeOgQ/wgAjmiIjaeTgQ/wgAjmiIjaebgO/xgAjmiIjaemgN/xgAjm
					iIjaeygL/ygBjniIjafBgJ/ygBjniIjafRgH/zgBjoiIjafjgE/zgBjoiIjaf1gC/zgBjpiIjagHf//z]],
				Tail2 = [[
					gCjgi0iCfmgF/7gDjgi0iCgHgB/7gEjhi0iCgof9/6gFjhi0iChHf5/6gFjii0iChlf1/4gFjii0iCiBfy/3gGjji0iBiZfv/1gGjji0iBitfs/zgGjji0iB
					i9fq/ygGjji0iBjJfp/xgFjki0iBjQfo/wgFjji0iBjRfn/wgEjji0iBjNfn/wgEjji0iBjFfo/xgDjji0iBi3fp/zgCjii0iBilfr/0gBjii0iBiPfu/2gA
					jhi0iCh1fx/3f/jhi0iChZf0/5f+jgi0iCg6f4/6f+jgi0iCgaf7/7f9jfi0iCf5f//7f8jei0iCfYgD/6f7jei0iCe5gH/6f7jdi0iCebgL/4f7jdi0iCd/
					gO/3f6jdi0iBdngR/1f6jci0iBdTgU/zf6jci0iBdDgW/yf6jci0iBc3gX/xf7jci0iBcwgY/wf7jci0iBcvgZ/wf8jci0iBczgZ/wf8jci0iBc7gY/xf9jd
					i0iBdJgX/zf+jdi0iBdbgV/0f/jdi0iBdxgS/2gAjei0iCeLgP/3gBjei0iCengM/5gCjfi0iCfGgI/6]],
				Tail3 = [[
					gBjajhg8eNgR/7gEjbjhg8e4gN/9gGjbjhg8fkgI/+gIjcjhg8gSgE/+gKjcjhg8g/f//9gLjdjhg8hqf6/7gMjdjgg8iTf1/5gNjdjgg7i4fx/2gOjejgg7
					jYft/zgOjejgg7j0fp/vgOjejgg7kJfm/tgOjejgg7kXfk/rgNjejgg6kffi/qgMjdjgg6kgfh/qgLjdjgg7kafh/qgJjdjgg7kNfi/sgIjcjhg7j5fj/vgF
					jcjhg7jffl/ygDjbjhg7jAfo/1gBjbjhg8ibfr/4f/jajhg8hzfv/7f8jZjhg8hIfz/9f6jZjhg8gcf4/+f4jYjhg8fuf8/+f2jYjhg8fBgB/9f1jXjhg8eW
					gG/7f0jXjgg8dtgL/5fzjWjgg7dIgP/2fyjWjgg7cogT/zfyjWjgg7cMgX/vfyjWjgg7b3ga/tfyjWjgg7bpgc/rfzjWjgg6bhge/qf0jWjgg6bggf/qf1jX
					jgg7bmgf/qf3jXjgg7bzge/sf4jYjhg7cHgd/vf7jYjhg7chgb/yf9jZjhg7dAgY/1f/jZjhg8dlgV/4]],
				Tail4 = [[
					f8jXkOcychgI/ogAjYkOcydOgK/tgEjYkOcyeAgL/xgJjZkOcye1gL/zgMjakOcyfsgM/0gQjakOcygjgM/0gTjakNcyhagM/zgWjbkNcyiOgL/wgYjbkMcy
					i/gL/sgZjbkMcyjqgK/ngajbkMcykQgJ/igajbkMcykwgH/egajbkMczlIgG/agZjbkMczlXgE/YgXjakMczlfgC/WgVjakMczldgA/WgSjZkNczlUf+/YgP
					jZkNczlCf8/bgMjYkOcykof7/fgIjYkOcykHf5/kgEjXkOcyjff4/ogAjXkOcyiyf2/tf8jWkOcyiAf1/xf3jWkOcyhLf1/zf0jVkOcygUf0/0fwjVkOcyfd
					f0/0ftjUkNcyemf0/zfqjUkNcydyf1/wfojUkMcydBf1/sfnjTkMcycWf2/nfmjTkMcybwf3/ifmjTkMcybQf5/efmjTkMcza4f6/afnjUkMczapf8/YfpjU
					kMczahf+/WfrjUkMczajgA/WfujVkNczasgC/YfxjVkNcza+gE/bf0jWkOcybYgF/ff4jXkOcyb5gH/k]],
				Tail5 = [[
					fyjgk6VmbGfI91f4jhk6VkbsfT97f/jik7VjcYff+AgFjik7VidKfr+GgLjjk7VheBf5+KgRjjk6Vge8gG+MgXjjk6Vgf3gU+Ngcjkk5Vgg0gh+Nggjkk4Vh
					hugt+Kgjjkk3Viimg4+Ggmjkk3VjjahB+Bgojkk2VkkIhJ97gojkk2VmkwhQ92gojkk2VnlQhU9xgnjjk2VolohW9tgkjjk2Vpl3hW9qghjik3Vpl9hU9pgd
					jik3Vpl6hQ9qgZjhk4VolthK9sgTjhk5VnlYhC9wgOjgk6Vmk6g491gIjgk6VkkUgt97gBjfk7Vjjogh+Af7jfk7Vii2gV+Gf1jek7Vhh/gH+Kfvjek6VghE
					f6+Mfpjdk6VggJfs+Nfkjdk5VgfMff+Nfgjdk4VheSfT+Kfdjck3VidafI+Gfajck3Vjcme/+BfYjck2Vkb4e397fYjck2VmbQew92fYjdk2Vnawes9xfZjd
					k2VoaYeq9tfcjdk2VpaJeq9qffjek3VpaDes9pfjjek3VpaGew9qfnjfk4VoaTe29sftjgk5Vnaoe+9w]],
				["UpperLegB.L"] = [[
					eBinhZ8GesfnvPeBinhZ8CeufnvWeBiohZ79evfnveeBiphZ75evfovneBiphZ70evfqvveBiqhZ7wevfrv3eBiqhZ7reufuv+eBiqhY7oetfwwFeBiqhY7k
					esfzwLeBirhY7heqf2wQeBirhX7feof6wTeBirhX7demf9wWeBiqhW7cejgBwXeBiqhW7cehgEwXeBiqhV7deegHwWeBiphV7eecgKwTeBiphU7geZgNwQeB
					iohU7jeXgPwMeBiohT7leVgRwGeBinhT7peUgTwBeBinhT7seSgUv6eBimhT7weRgUvzeBilhT70eRgUvseBilhT74eQgTvleBikhT78eRgSveeBikhT8AeR
					gQvWeBikhT8EeSgOvQeBijhU8IeTgLvJeBijhU8LeUgIvDeBijhV8OeWgFu+eBijhV8QeYgCu6eBijhW8Seaf+u3eBijhW8Tecf7u1eBijhX8Ueef3u0eBik
					hX8Uegf0u0eBikhY8Tejfxu2eBilhY8Selfuu4eBilhY8Qenfru8eBimhZ8NepfqvCeBimhZ8KerfovI]],
				["LowerLegB.L"] = [[
					d9hvg1wogYf37Ud+hwg2wzgYf27Od+hwg2w8gYf27Id+hwg3xEgXf27Dd+hwg3xLgWf26/d+hxg3xRgUf267d+hxg4xUgSf365d+hxg4xWgPf464d+hxg4xW
					gMf564d+hxg4xUgJf765d+hxg3xQgGf968d+hwg3xKgCf/7Ad+hwg3xCf/gB7Ed/hwg2w5f7gD7Kd/hwg1wvf4gF7Qd/hvg1wkf1gG7Xd/hvg0wYfygI7ed/
					hvgzwMfvgK7md/hugzv/ftgL7td/hugyvzfsgM70d/htgxvofqgN76d/htgxvdfqgN8Ad/htgwvUfqgN8Fd/hsgwvMfrgN8Jd/hsgwvFfsgN8Nd/hsgvvAft
					gM8Qd/hsgvu9fwgL8Rd/hsgvu8fygK8Sd/hsgvu9f1gJ8Rd/hsgvvAf5gH8Qd+hsgwvEf8gG8Od+hsgwvKgAgE8Ld+htgwvSgDgD8Gd+htgxvagHgB8Cd+ht
					gxvkgLf/78d+hugyvvgOf+72d+hugyv6gRf87wd+hugzwGgTf77pd+hvg0wSgVf57id+hvg0wdgXf47b]],
				["UpperLegB.R"] = [[
					h/inhT7shufsv6h/inhT7nhufrwDh/iohT7jhtfqwLh/iohT7ehtfqwSh/iphT7bhsfrwYh/iphT7Yhqfswdh/iqhT7Whpftwhh/iqhU7Vhnfvwjh/iqhU7U
					hlfywkh/iqhV7Vhjf1wjh/irhV7Xhhf4wgh/irhW7Zhff8wdh/iqhW7chdf/wXh/iqhX7hhbgDwQh/iqhX7lhZgHwJh/iqhY7qhXgLwAh/iphY7whWgOv2h/
					iphY72hVgRvsh/iohZ77hUgUvih/inhZ8BhUgXvYh/inhZ8GhUgZvPh/imhZ8LhUgavGh/imhZ8PhUgbu9h/ilhZ8ThVgbu2h/ilhZ8WhWgbuwh/ikhZ8YhX
					gaurh/ikhZ8ahZgYuoh/ijhY8bhbgWunh/ijhY8bhcgTunh/ijhY8ahegQuoh/ijhX8YhggNurh/ijhX8WhigJuvh/ijhW8ThkgFu1h/ijhW8PhmgCu7h/ik
					hV8Lhof+vDh/ikhV8Hhpf6vMh/ikhU8Chrf3vVh/ilhU78hsfzveh/ilhT73htfxvnh/imhT7yhtfuvx]],
				["LowerLegB.R"] = [[
					iBhtgxvogWfz76iBhugyvwgXfz71iBhugyv5gXfz7wiBhugzwDgXfz7riBhvgzwMgXf07liBhvg0wWgWf07giBhvg1wfgUf17aiBhvg1wngSf37ViBhwg1wv
					gPf47QiBhwg2w2gMf67MiBhwg2w7gJf87JiBhwg2xAgFf97GiChwg3xCgBf/7EiChwg3xEf+gB7EiChwg3xDf6gD7EiChwg2xCf2gF7FiChwg2w/fzgG7GiC
					hwg2w7fvgH7JiChwg2w2fsgI7MiChwg1wvfqgJ7QiDhvg1wofogJ7UiDhvg1whfngJ7ZiDhvg0wZfmgJ7eiDhvg0wQfmgJ7jiDhugzwHfngI7oiDhugzv/fo
					gH7tiDhugyv2fpgG7yiChugyvufsgF73iChtgxvnfugD77iChtgxvgfxgC7/iChtgxvaf1gA8CiChtgwvVf5f/8FiChtgwvSf9f98GiChtgwvPgAf88IiCht
					gwvPgEf68IiBhtgwvPgIf58IiBhtgwvSgMf38GiBhtgwvVgPf28EiBhtgxvagRf18CiBhtgxvhgUf07+]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAjwhTAPfLgGjtgAjxhTAPfRgejsgAj0hTAQfdgyjsgAj4hTAQfthBjsgAj6hTAQf/hHjtgAj6hTAQgRhFjtgAj4hTAQgig6jugAj0hTAQgugpjugAjxhTAQ
					g1gSjugAjwhTAPg1f6jtgAjxhTAPgvfijsgAj0hTAQgjfOjsgAj4hTAQgTe/jsgAj6hTAQgBe5jtgAj6hTAQfve7jtgAj4hTAQfefGjugAj0hTAQfSfXjugA
					jxhTAQfLfuju]],
				Spine1 = [[
					f/j6gpAPflgDjtf+j7gpAPfpgSjsf+j+gpAPfvgfjsf9kCgpAPf3gojsf9kEgpAPgAgsjtf9kFgpAPgKgrjtf+kCgpAPgSgljuf+j/gpAPgYgajuf/j7gpAP
					gbgMjugBj6gpAPgbf9jtgCj7gpAPgXfujsgCj+gpAPgRfhjsgDkCgpAPgJfYjsgDkEgpAPgAfUjtgDkFgpAPf2fVjtgCkCgpAPfufbjugCj/gpAPfofmjugB
					j7gpAPflf0ju]],
				Spine2 = [[
					f/kEf+/8gAgAhmf+kFf+/8gAf6hmf8kIf//8gBf1hnf7kMf//8gBfxhnf7kOf//8gBfuhmf7kPf//8gBfuhmf8kMf//8gBfxhlf+kJf//8gBf1hlf/kFf+/8
					gAf6hlgBkEf+/8gAgAhmgCkFf+/8gAgGhmgEkIf//8f/gLhngFkMf//8f/gPhngFkOf//8f/gShmgFkPf//8f/gShmgEkMf//8f/gPhlgCkJf//8f/gLhlgB
					kFf+/8gAgGhl]],
				Spine3 = [[
					f/kAfY/8flf/hmf9kBfY/8fngChmf8kFfY/8frgFhnf7kIfY/8fygHhnf6kLfY/8f7gJhmf7kLfY/8gEgJhmf8kIfY/8gNgIhlf9kFfY/8gUgHhlf/kCfY/8
					gZgEhlgBkAfY/8gbgBhmgDkBfY/8gZf+hmgEkFfY/8gVf7hngFkIfY/8gOf5hngGkLfY/8gFf3hmgFkLfY/8f8f3hmgEkIfY/8fzf4hlgDkFfY/8fsf5hlgB
					kCfY/8fnf8hl]],
				Neck1 = [[
					f/j8exAVgbf8kef9j9exAUgXfwkTf8kBexAUgRfmkVf7kEexAWgJffkif7kHexAZgAfck1f7kHexAbf3felEf8kFexAcfvfjlJf9kBexAbfpfslBf/j+exAY
					flf4kwgBj8exAVflgEkegDj9exAUfpgQkTgEkBexAUfvgakVgFkEexAWf3ghkigFkHexAZgAgkk1gFkHexAbgJgilEgEkFexAcgRgdlJgDkBexAbgXgUlBgB
					j+exAYgbgIkw]],
				Neck2 = [[
					gAkPdxBNgaf5omf/kPdwBHgTfloSf+kTdwBIgJfUoVf9kXdxBQf/fIovf9kbdxBaf0fDpSf9kcdxBjfsfGpvf+kadxBmflfQp4f+kWdxBhfiffppf/kSdxBX
					fifzpJgAkPdxBNfmgHomgBkPdwBHftgboSgCkTdwBIf3gsoVgDkXdxBQgBg4ovgDkbdxBagMg9pSgDkcdxBjgUg6pvgCkadxBmgbgwp4gCkWdxBhgeghppgB
					kSdxBXgegNpJ]],
				Neck3 = [[
					gAkrdCBNgaf5oogAkqdCBFgQfcoKgAkudCBHgEfDoPgAk0dDBSf4eyo1gAk5dEBjfueqpqgAk7dGBxfletqVgAk6dGB1fge6qigAk1dFBtfefPqMgAkvdEBc
					fgfqpcgAkrdCBNfmgHoogAkqdCBFfwgkoKgAkudCBHf8g9oPgAk0dDBSgIhOo1gAk5dEBjgShWpqgAk7dGBxgbhTqVgAk6dGB1gghGqigAk1dFBtgigxqMgA
					kvdEBcgggWpc]],
				Head = [[
					gClab1/ZgYgDmKgElXbz/SgKgrmpgFlbb0/Wf6hQmPgHljb3/hfrhqlKgHltb7/sfeh3j4gGlyb//yfVhzjAgFlycA/zfShhi9gDlrb9/vfUhGjwgBlib5/l
					fcgklBf+lab1/Zfof9mKf8lXbz/Sf2fVmpf7lbb0/WgGewmPf5ljb3/hgVeWlKf5ltb7/sgieJj4f6lyb//ygreNjAf7lycA/zguefi9f9lrb9/vgse6jwf/
					lib5/lgkfclB]],
				Jaw = [[
					gEj1b0/zgYgBjegFjyb1/vgNgqj9gGj2bz/xgBhQjkgHj/bv/2f0hsiegHkJbs/6foh5hLgFkQbq/7ffh2gTgDkQbq/8fahlgQgAkIbt/8fahJhDf+j+bx/5
					ffgniVf8j1b0/zfof/jef7jyb1/vfzfWj9f6j2bz/xf/ewjkf5j/bv/2gMeUief5kJbs/6gYeHhLf7kQbq/7gheKgTf9kQbq/8gmebgQgAkIbt/8gme3hDgC
					j+bx/5ghfZiV]],
				["UpperLegF.L"] = [[
					d7ije0pGfFgA+qd6ike0q0fCgO+Gd5ine0uffEgZ8gd4ipe0yKfJgg6Ud5irez1XfOgl3yd6iqez2UfNgj25d8imez0rfHgW4Zd+iie0zBfBgF5teAiee0xj
					e7f06ueCice0wee4fk7ZeDiee1v6e1fZ7ueEihe1v2ezfU7weFime2wJezfU7leEiqe2wbe2fZ7aeDire2wRe7fg7heBiqe1vefCfp7/d/ine1uQfKfz8od9
					ike1qofKf3+K]],
				["LowerLegF.L"] = [[
					d4iBfp88g8gttld2h8fl+ehPhIpmd2h0fZ/GhMhTnTd3hufK+4g6hKoOd4hse69qgjg0r7d5hre18kgUgiuXd6hoe+9FgPgYtUd7hlfG9hgDgLsUd8hkfN9u
					fyf7r0d9hlfS9ofgfrsDd+hnfV9LfSfctFd/hrfV8ZfNfSusd/hvfU7WfPfNwjd/hyfT6PfWfMyRd+h0fU5XfhfTzed9h0fX46fwfh0Ed8h1fb4pgCfy0Zd6
					h9fm60gegOxb]],
				["FootF.L"] = [[
					d7hWfF/jhDf1lKd7hce3/khdfxk/d7hben/jhefxlBd7hTea/ihJf0lQd7hFeS/fgrf4lnd7g+eU/dgaf7l0d7g+eZ/dgTf9l0d7g+ef/dgFf/l0d7g+ek/d
					fxgDl0d7g+eq/dfdgHl0d7g+ev/cfNgJl0d7g+e1/cfGgLl0d7g+e6/cfIgKl0d7g+fA/cfPgJl0d7g+fG/dfagHl0d7g+fL/dfrgEl0d7g+fR/df/gAl0d7
					hKfP/gggf7lf]],
				["UpperLegF.R"] = [[
					h+ice0wehIgc7Zh9iee1v6hLgn7uh8ihe1v2hNgs7wh7ime2wJhNgs7lh8iqe2wbhKgn7ah9ire2wRhFgg7hh/iqe1veg+gX7/iBine1uQg2gN8oiDike1qo
					g2gJ+KiFije0pGg7gA+qiGike0q0g+fy+GiHine0ufg8fn8giIipe0yKg3fg6UiHirez1Xgyfb3yiGiqez2Ugzfd25iEimez0rg5fq4ZiCiie0zBg/f75tiA
					iee0xjhFgM6u]],
				["LowerLegF.R"] = [[
					iDhlfS9ogggVsDiChnfV9LgugktFiBhrfV8ZgzguusiBhvfU7WgxgzwjiBhyfT6Pgqg0yRiCh0fU5XgfgtzeiDh0fX46gQgf0EiEh1fb4pf+gO0ZiGh9fm60
					fifyxbiIiBfp88fEfTtliKh8fl+eexe4pmiKh0fZ/Ge0etnTiJhufK+4fGe2oOiIhse69qfdfMr7iHhre18kfsfeuXiGhoe+9FfxfotUiFhlfG9hf9f1sUiE
					hkfN9ugOgFr0]],
				["FootF.R"] = [[
					iFg+eq/dgjf5l0iFg+ev/cgzf3l0iFg+e1/cg6f1l0iFg+e6/cg4f2l0iFg+fA/cgxf3l0iFg+fG/dgmf5l0iFg+fL/dgVf8l0iFg+fR/dgBgAl0iFhKfP/g
					fggFlfiFhWfF/je9gLlKiFhce3/kejgPk/iFhben/jeigPlBiFhTea/ie3gMlQiFhFeS/ffVgIlniFg+eU/dfmgFl0iFg+eZ/dftgDl0iFg+ef/df7gBl0iF
					g+ek/dgPf9l0]],
				Oiseau = [[
					fLmUirgA//gAgAfLmVirgA//f/f6fKmZirgA//f/f1fKmcirgA//f/fxfKmfirgA//gAfufKmfisgA//gAfufLmcirgA//gBfxfMmZirgA//gBf1fMmVirgA
					//gBf6fNmUirgA//gAgAfNmViqgA//f/gGfOmZiqgA//f/gLfOmciqgA//f/gPfOmfiqgA//gAgSfOmfiqgA//gAgSfNmciqgA//gBgPfNmZiqgA//gBgLfM
					mViqgA//gBgG]],
				Arbre1 = [[
					gcm4hgO4aufh6fgdm6hfOzayf56dgdm9hfOta0gR6ZgfnAhfOmaygn6UggnChfOgaug46PginChfObaohD6Kgkm/hfOWaghF6Fgmm7hfOTaZg/6Cgnm4hgOS
					aSgy6Agnm3hgOUaNge6Agnm4hgOXaJgH6Cgmm7hhOdaIfv6Gglm/hhOlaJfZ6LgjnChiOtaNfI6RginChiO1aTe96WggnAhhO6aZe66bgem9hhO8ahfA6fgd
					m6hhO8aofO6g]],
				Arbre2 = [[
					fYnDgJOaaIgk6DfWnEgKOfaVgq6JfWnHgKOnaggx6RfXnLgLOuargw6YfYnOgLOza6gi6efanOgLO0bMgF6ifdnMgLOybdfg6kffnJgKOuboe86ifhnGgKOq
					bnem6ffjnEgJOobXek6afknGgJOma6e26VflnJgIOmaWfX6OfknMgIOmZ0f76HfjnOgIOkZbgY6AfhnOgIOiZRgo57fenLgIOeZWgr55fcnHgIOaZlgm57fZ
					nEgJOYZ3gi5+]],
				Tail1 = [[
					gBjhiHkmg8gt/ogCjiiHkWgqgt/rgDjliHkNgTgn/tgEjpiHkRf6gc/tgEjriHkffigO/rgDjriHkxfNf+/ogDjpiHk+e+fv/lgCjliHlAe3fi/kgAjiiHk3
					e5fY/mf/jhiHkmfEfT/of+jiiHkWfWfT/rf9jliHkNftfZ/tf8jpiHkRgGfk/tf8jriHkfgefy/rf9jriHkxgzgC/of9jpiHk+hCgR/lf+jliHlAhJge/kgA
					jiiHk3hHgo/m]],
				Tail2 = [[
					gEjUizkGibgi/ogEjWizjlhogm/vgEjZizjNgogl/0gDjdizjKfkge/1gCjeizjcekgU/xgBjeiyj7dugI/qgAjbiykZdKf8/jf+jXiykoc7fx/gf9jUiykg
					dFfm/if8jUizkGdlfe/of8jWizjleYfa/vf8jZizjNfYfb/0f9jdizjKgcfi/1f+jeizjchcfs/xf/jeiyj7iSf4/qgAjbiykZi2gE/jgCjXiykojFgP/ggD
					jUiykgi7ga/i]],
				Tail3 = [[
					gLjIjej/kTgU/cgJjMjfjVjOgZ/pgGjQjfithwgc/0gCjUjfiagFgZ/5f+jVjfimeagS/2f7jTjejLc7gK/rf4jOjdj3b0gB/ef2jKjdkVbMf6/Vf1jIjdkZ
					bKfz/Uf1jIjej/btfs/cf3jMjfjVcyfn/pf6jQjfiteQfk/0f+jUjfiaf7fn/5gCjVjfimhmfu/2gFjTjejLjFf2/rgIjOjdj3kMf//egKjKjdkVk0gG/VgL
					jIjdkZk2gN/U]],
				Tail4 = [[
					gXi9kIg4mJgv/YgSjCkKgMlFgr/lgLjJkMfYjZgk/zgDjNkMe0hUgX/8f6jNkMexfFgF/9fyjKkKfRc9fx/1fsjEkIgFbNfg/ofoi+kHgzaBfV/afni8kHhI
					ZjfR/Tfpi9kIg4Z3fR/YfujCkKgMa7fV/lf1jJkMfYcnfc/zf9jNkMe0esfp/8gGjNkMexg7f7/9gOjKkKfRjDgP/1gUjEkIgFkzgg/ogYi+kHgzl/gr/agZ
					i8kHhImdgv/T]],
				Tail5 = [[
					goi7kzafnXiU+jggjCk2Z7mpiD+ogVjLk4ZDlHhl+wgGjQk6YQi+g7+4f3jRk5X7gegI+8fqjMk2YNd7fR+8fejEkzY/boef+3fXi8kxZ4Z3d7+ufVi5kxae
					Y0dp+lfYi7kzafYpds+jfgjCk2Z7ZXd9+ofrjLk4ZDa5eb+wf6jQk6YQdCfF+4gJjRk5X7fif4+8gWjMk2YNiFgv+8gijEkzY/kYhh+3gpi8kxZ4mJiF+ugr
					i5kxaenMiX+l]],
				["UpperLegB.L"] = [[
					eGiZhT+aeHfcpveGibhW+OeWfLqTeFifhZ9zeofArheEilhb9Ke5e9tEeCiphc8dfHfBuieBirhc76fPfJvleAirhb7mfOfTwJd+iphZ7WfHfiwjd+inhW69
					e+f2xMd9imhT6Qe2gNyPd+inhQ5Neugkzpd+iphO32eog51QeAirhM3dechF1reBirhL5keGhCzHeCiphL7tdzg2vzeEilhM9pdjgirweFifhO+xdggIoYeG
					ibhQ+/dufvno]],
				["LowerLegB.L"] = [[
					eBhzgdy4fgfS50eAhzgiyof7fP5/d/hzgoyxgUfR55d+hzgvzGgofW5pd9h0g1zRg3fb5gd8hzg5y6hCfm5yd7hxg7x1hHf06id7hvg6wRhGgG7hd7hrg6ur
					g+gV8ad7hog8tdgugg9Ad8hnhAs7gZgm9Qd9hnhGtFgBgp9Md+hphGr7fsgr9reAhsg4oGfdgl+8eBhwgpmefNgO/UeCh3gbn5e+fs++eDh+gUrwe8fS9ueC
					h8gWvwfLfN70]],
				["FootB.L"] = [[
					d+g+gu/YfMgKmId+g+g0/ZfggGmId+g+g5/Zf0gCmId+g+g//ZgHf/mJd+g+hE/ZgWf8mId+g+hK/Zgkf5mId+g+hQ/Ygxf2mId+g+hV/Yg7f1mId+g+hb/Y
					g9f0mId+g+hg/Yg3f1mId+g+hm/Zgqf4mId+g+hr/ZgZf7mId+hChv/bgKf+mAd+hQhp/ff7gBlnd+hahc/ifegGlWd+hdhM/ie9gLlRd+hYg9/gevgOlad+
					hMgy/de4gNlu]],
				["UpperLegB.R"] = [[
					iDimhT6QhKfzyPiCinhQ5NhSfczpiCiphO32hYfH1QiAirhM3dhke71rh/irhL5kh6e+zHh+iphL7tiNfKvzh8ilhM9pidferwh7ifhO+xigf4oYh6ibhQ+/
					iSgRnoh6iZhT+ah5gkpvh6ibhW+Ohqg1qTh7ifhZ9zhYhArhh8ilhb9KhHhDtEh+iphc8dg5g/uih/irhc76gxg3vliAirhb7mgygtwJiCiphZ7Wg5gewjiC
					inhW69hCgKxM]],
				["LowerLegB.R"] = [[
					iFhog8tdfSfg9AiEhnhAs7fnfa9QiDhnhGtFf/fX9MiChphGr7gUfV9riAhsg4oGgjfb+8h/hwgpmegzfy/Uh+h3gbn5hCgU++h9h+gUrwhEgu9uh+h8gWvw
					g1gz70h/hzgdy4gggu50iAhzgiyogFgx5/iBhzgoyxfsgv55iChzgvzGfYgq5piDh0g1zRfJgl5giEhzg5y6e+ga5yiFhxg7x1e5gM6iiFhvg6wRe6f67hiF
					hrg6urfCfr8a]],
				["FootB.R"] = [[
					iCg+hg/YfJgLmIiCg+hm/ZfWgImIiCg+hr/ZfngFmIiChChv/bf2gCmAiChQhp/fgFf/lniChahc/igif6lWiChdhM/ihDf1lRiChYg9/ghRfylaiChMgy/d
					hIfzluiCg+gu/Yg0f2mIiCg+g0/Zggf6mIiCg+g5/ZgMf+mIiCg+g//Zf5gBmJiCg+hE/ZfqgEmIiCg+hK/ZfcgHmIiCg+hQ/YfPgKmIiCg+hV/YfFgLmIiC
					g+hb/YfDgMmI]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAjwhTALgAgAjGgAjphTAKgDgVi5gAjkhTANgEgijbgAjohTARgEgij9gAjvhTAPgCgVjwgAjwhTALgAgAjGgAjphTAKf9fri5gAjkhTANf8fejbgAjohTAR
					f8fej9gAjvhTAPf+frjw]],
				Spine1 = [[
					gAj4gpANgAgAjef/jxgoAJgDgVi0f/jugpAKgEgijBf/jzgpAQgDgijyf/j5gpASgDgVkEgAj4gpANgAgAjegBjxgoAJf9fri0gBjugpAKf8fejBgBjzgpAQ
					f9fejygBj5gpASf9frkE]],
				Spine2 = [[
					gAkCf+/9gAgAhef+j5f+/4gBfrikf9j2f+/3gCfeitf9j9f//8gCfehtf+kEf//+gBfrg8gAkCf+/9gAgAhegCj5f+/4f/gVikgDj2f+/3f+giitgDj9f//8
					f+gihtgCkEf//+f/gVg8]],
				Spine3 = [[
					gAj+fX/+gAgAhGf9jzfX/4gBfripf8jvfY/1gDfejHf8j5fY/7gDfeh4f9kCfY/+gAfrgogAj+fX/+gAgAhGgDjzfX/4f/gVipgEjvfY/1f9gijHgEj5fY/7
					f9gih4gDkCfY/+gAgVgo]],
				Neck1 = [[
					gAj8exAqgAgAmWf9jsexASgEgVkGf7joeyALgEgijEf7j0eyAXgEgiksf9kAexAvgEgVmtgAj8exAqgAgAmWgDjsexASf8frkGgFjoeyALf8fejEgFj0eyAX
					f8feksgDkAexAvf8frmt]],
				Neck2 = [[
					gAkWdzCQgAgArwf7j+dwBSgHgUo5f4j1dwA4gIghnWf4kIdxBagJghpTf7kcd0CXgIgTsAgAkWdzCQgAgArwgFj+dwBSf5fso5gIj1dwA4f4ffnWgIkIdxBa
					f3ffpTgFkcd0CXf4ftsA]],
				Neck3 = [[
					gAk7dLC0gAgAtGf6kadCBfgHgUpkf3kNc/A6gJghnff3kmdEBkgKggp0f7lCdNC5gJgTtPgAk7dLC0gAgAtGgGkadCBff5fspkgJkNc/A6f3ffnfgJkmdEBk
					f2fgp0gFlCdNC5f3fttP]],
				Head = [[
					gAl+cP/+gAgAguf5lOb4/wgBfrj4f0k2bv/fgFfellf1lab7/zgEfejff5mFcS//gAfrgegAl+cP/+gAgAgugHlOb4/wf/gVj4gMk2bv/ff7gillgLlab7/z
					f8gijfgHmFcS//gAgVge]],
				Jaw = [[
					gAkgbtADgAgAhTf5jrbpAKf/gVc8f0jSbqAhf7giaXf0j4bpAKf8gidFf5kobuADgBgVhYgAkgbtADgAgAhTgHjrbpAKgBfrc8gMjSbqAhgFfeaXgMj4bpAK
					gEfedFgHkobuADf/frhY]],
				["UpperLegF.L"] = [[
					d+ifexm3fHfz/Od7iQe9kjfYf6/qd5iMfCtbfrgO9Cd5iYe7xqfrgL6rd7ikex0PfbgB4xd+ifex24e8f72VeCiQe3ygeYfg6CeDiMe5uKeLfR8neEiYeyrU
					eWfg93eCikess2exf79R]],
				["LowerLegF.L"] = [[
					d7iFfq5cgPgBzZd5h/f5+hhDgepgd5hcfr/0heg6dOd5hefT/8hQg0e/d5hme+/egpgdlsd7hgev+Rf5gDqVd7hVfM/RfNgMmud8haff+1ewgOoad9hufh7s
					fDgDwAd9h1fX1sfhfv3g]],
				["FootF.L"] = [[
					d7hPfb/igOf+lXd7hffL/lhIf1k7d7hme0/lh8ftkud7hhec/lhnfwk3d7hSeK/jgwf4lQd7g+eD/df6gBl0d7g+eZ/cfOgJl0d7g+ev/beygOlzd7g+fF/c
					fGgLl0d7g+fb/dfdgGl0]],
				["UpperLegF.R"] = [[
					iCifex24hEgF2Vh+iQe3yghogg6Ch9iMe5uKh1gv8nh8iYeyrUhqgg93h+ikess2hPgF9RiCifexm3g5gN/OiFiQe9kjgogG/qiHiMfCtbgVfy9CiHiYe7xq
					gVf16riFikex0Pglf/4x]],
				["LowerLegF.R"] = [[
					iFhgev+RgHf9qViFhVfM/Rgzf0muiEhaff+1hQfyoaiDhufh7sg9f9wAiDh1fX1sgfgR3giFiFfq5cfxf/zZiHh/f5+he9fipgiHhcfr/0eifGdOiHhefT/8
					ewfMe/iHhme+/efXfjls]],
				["FootF.R"] = [[
					iFg+eD/dgGf/l0iFg+eZ/cgyf3l0iFg+ev/bhOfylziFg+fF/cg6f1l0iFg+fb/dgjf6l0iFhPfb/ifygClXiFhffL/le4gLk7iFhme0/leEgTkuiFhhec/l
					eZgQk3iFhSeK/jfQgIlQ]],
				Oiseau = [[
					fMmQirgA//gIgAfOmTiigA/+fCfrfPmSihf//9e5fefPmOirf///f5fefOmNiygA/+gqfrfMmQirgA//gIgAfKmTifgA/+fCgVfJmSiegB/9e5gifJmOiogB
					//f5gifKmNivgA/+gqgV]],
				Arbre1 = [[
					gim3hdOwbOet6fgimyhUN/bCf059gimuhWN6ang75zgimwhgOXaFhl5+gim2hkOgZuht5+gim3hdOFZrhW5sgimyhWNvZ6gf5igimuhZOLaUfV57gimwhiPC
					azeY6kgim2hlPXbKeI60]],
				Arbre2 = [[
					fdnBgGN+aTgZ5zfcm5f+Nxahgv5sfbm2gCOSasgt6Ffbm8gLPBbPfq6rfcnDgOPKbzeY60fdnBgGOjbieR6Yffm5f9N+abfl51fgm2f/OEZXg85ofgm8gJOe
					ZHhK51ffnDgNOdZsgn5+]],
				Tail1 = [[
					gAjjiIlxgAgA/dgBjdiIkSfrgD/tgCjWiHkafegF/rgCjYiHl+fegB/bgBjgiHm0frf//QgAjjiIlxgAgA/df/jdiIkSgVf9/tf+jWiHkagif7/rf+jYiHl+
					gif//bf/jgiHm0gVgB/Q]],
				Tail2 = [[
					gAjSiynNgef//KgAjRi0krfegE/pgAjKizjwergL/vgAjHixlueXgG/bgAjNiwn2esf/+/gAjSiynNfigB/KgAjRi0krgif8/pgAjKizjwhVf1/vgAjHixlu
					hpf6/bgAjNiwn2hUgB+/]],
				Tail3 = [[
					gBi+jbo6hVgB+sf/jDjfmAfwgF/bf9i/jfjyeRgO/uf8i3jblWdbgH/bf8i3jYogdlf++vf/i+jbo6erf/+sgBjDjfmAgQf7/bgDi/jfjyhvfy/ugEi3jblW
					ilf5/bgEi3jYogibgC+v]],
				Tail4 = [[
					gFimkBnOiYgV/Ef+izkJktgdgL/pf4i0kLhaeUgG/6f1iokGh7c1fz/xf2igj/lhclfj/Uf7imkBnOdofr/EgCizkJktfjf1/pgIi0kLhahsf6/6gLiokGh7
					jLgN/xgKigj/lhjbgd/U]],
				Tail5 = [[
					gMiSkqhnjQhQ/wf/ilk1gFhWgq/9fziwk4cYe1f//wfsijkyboczfJ/hfsiRkoe2cDek/sf0iSkqhncwew/wgBilk1gFeqfW/9gNiwk4cYhLgB/wgUijkybo
					jNg3/hgUiRkoe2j9hc/s]],
				["UpperLegB.L"] = [[
					eBighW+Decf3q2eBiZha+Yedfdp4eCiUhZ9zeefQrheCiYhW7qemfZwAeBifhW4aexfx0peBighW5kebf/zLeBiZhV8Bd+gHvTeCiUhR+cdogEpieCiYhO/l
					dqf5kkeBifhR/Xd/fzl/]],
				["LowerLegB.L"] = [[
					d/h2gj3Mf0gD2Cd9hzgkymgVgD6Cd8hogotRgrf79Gd8heg1pzgrfw+cd9hehLpigXfu+id9hghElIgSf6/kd+higxgvgKf9/+d/hvgaigf4f2/5eAiFgOq9
					fof9+Dd/iHgTyEfqgK6Z]],
				["FootB.L"] = [[
					d+g+gg/Zf4gCmJd+g+g2/ZgSf8mId+g+hN/Zgff6mId+g+hj/ZgZf7mId+g+h5/ZgIf+mJd+hPh5/fgLf+lrd+hfhp/kgGf/lNd+hmhR/mfygClAd+hhg5/k
					frgDlJd+hSgn/gf1gClk]],
				["UpperLegB.R"] = [[
					h/ighW5khlgBzLh/iZhV8BiCf5vTh+iUhR+ciYf8pih+iYhO/liWgHkkh/ifhR/XiBgNl/h/ighW+DhkgJq2h/iZha+Yhjgjp4h+iUhZ9zhigwrhh+iYhW7q
					hagnwAh/ifhW4ahPgP0p]],
				["LowerLegB.R"] = [[
					iDhghElIfugG/kiChigxgvf2gD/+iBhvgaiggIgK/5iAiFgOq9gYgD+DiBiHgTyEgWf26ZiBh2gj3MgMf92CiDhzgkymfrf96CiEhogotRfVgF9GiEheg1pz
					fVgQ+ciDhehLpifpgS+i]],
				["FootB.R"] = [[
					iChPh5/ff1gClriChfhp/kf6gBlNiChmhR/mgOf+lAiChhg5/kgVf9lJiChSgn/ggLf+lkiCg+gg/ZgIf+mJiCg+g2/ZfugEmIiCg+hN/ZfhgGmIiCg+hj/Z
					fngFmIiCg+h5/Zf4gCmJ]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAj6hTAPgAgAjtgAj5hVAOgAgAjpgAj3haANgAgAjdgAj1hhALgAgAjOgAjyhnAKgAgAjAgAjxhqAJgAgAi4gAjyhfALgAgAjFgAjzg6APgAgAjrgAjyg0AU
					gAgAkZgAjyg0AegAgAlXgAjyg0AagAgAlAgAjzg1AUgAgAkUgAj0g6ARgAgAkCgAj2hDARgAgAj/gAj4hLAQgAgAj4gAj6hSAPgAgAjxgAj6hTAPgAgAjtgA
					j6hTAPgAgAjtgAj6hTAPgAgAjt]],
				Spine1 = [[
					gAkEgpAPgAgAjtgAkDgrAOgAgAjmgAkBgwAMgAgAjSgAj9g2AJgAgAi5gAj6g8AHgAgAiigAj5g/AGgAgAiVgAj6g0AIgAgAiqgAj9gQAOgAgAjqgAj+gLAU
					gAgAkZgAkBgLAegAgAlXgAkAgLAagAgAlAgAj+gLAUgAgAkUgAj/gQARgAgAkCgAkBgYARgAgAj/gAkDghAQgAgAj4gAkEgnAPgAgAjxgAkEgpAPgAgAjtgA
					kEgpAPgAgAjtgAkEgpAPgAgAjt]],
				Spine2 = [[
					gAkOf+/8gAgAhmgAkNgA/8gAgAhwgAkKgF/6gAgAiMgAkFgL/3gAgAivgAkBgR/0gAgAjPgAj/gU/zgAgAjhgAkBgJ/2gAgAjDgAkHfl/8gAgAhqgAkKfh/+
					gAgAg6gAkPfi//gAgAf7gAkNfi//gAgAgSgAkKfh/+gAgAg+gAkKfm/9gAgAhRgAkLfu/9gAgAhUgAkNf3/9gAgAhbgAkOf9/9gAgAhigAkOf+/8gAgAhmgA
					kOf+/8gAgAhmgAkOf+/8gAgAhm]],
				Spine3 = [[
					gAkKfY/8gAgAhmgAkJfa/8gAgAhzgAkEff/5gAgAiWgAj/fl/2gAgAjEgAj5fr/xgAgAjtgAj3fu/ugAgAkEgAj6fj/zgAgAjegAkDe//8gAgAhrgAkIe6/+
					gAgAg6gAkPe7//gAgAf7gAkNe7//gAgAgSgAkIe7/+gAgAg+gAkHe//9gAgAhRgAkIfH/9gAgAhUgAkKfQ/9gAgAhbgAkKfW/9gAgAhigAkKfY/8gAgAhmgA
					kKfY/8gAgAhmgAkKfY/8gAgAhm]],
				Neck1 = [[
					gAkGexAVgAgAkcgAkEezATgAgAkNgAj/e4AOgAgAjmgAj3e/AJgAgAi0gAjxfFAFgAgAiGgAjtfJAEgAgAhtgAjye9AHgAgAiXgAj/eYAUgAgAkXgAkGeTAn
					gAgAmJgAkQeVBLgAgAoigAkMeUA9gAgAnqgAkFeUAlgAgAl+gAkEeZAdgAgAlRgAkFehAcgAgAlJgAkGepAZgAgAk3gAkHewAWgAgAklgAkGexAVgAgAkcgA
					kGexAVgAgAkcgAkGexAVgAgAkc]],
				Neck2 = [[
					gAkZdwBLgAgAoigAkWdyBHgAgAoTgAkOd3A8gAgAnpgAkDd9AwgAgAmygAj5eCAmgAgAmBgAj0eGAggAgAllgAj7d7ApgAgAmTgAkRdXBKgAgAodgAkfdVCC
					gAgArLgAkydbDogAgAuxgAkrdYC/gAgAtegAkedVB8gAgAq6gAkZdZBkgAgAp0gAkadhBggAgApogAkadpBYgAgApNgAkadvBPgAgAoxgAkZdwBLgAgAojgA
					kZdwBLgAgAoigAkZdwBLgAgAoi]],
				Neck3 = [[
					gAk1dCBLgAgAoigAkxdDBHgAgAoRgAkndHA7gAgAnkgAkZdMAtgAgAmogAkNdQAjgAgAlygAkHdTAdgAgAlUgAkQdJAmgAgAmGgAktcpBKgAgAocgAlCcsCa
					gAgAsJgAlec8E4gAgAw8gAlVc1D4gAgAvPgAlAcsCRgAgArxgAk5ctBugAgAqTgAk5c1BogAgAqCgAk4c8BcgAgApdgAk2dBBRgAgAo3gAk1dCBLgAgAojgA
					k1dCBLgAgAoigAk1dCBLgAgAoi]],
				Head = [[
					gAljb1/fgAgAlmgAleb1/cgAgAl5gAlQb3/SgAgAmrgAk+b5/DgAgAnsgAktb8+0gAgAolgAkkb++rgAgApFgAkyb1+6gAgAoQgAlbbb/egAgAltgAmCbs//
					gPfWf+gAmvcU+8g9eoYDgAmgcE/jgpe3a7gAl+bq/+gNfagkgAlwbm/3gGfri5gAlvbs/0gEfujUgAlrby/tgCf1kNgAlmb1/lgBf8lHgAljb1/ggAgAllgA
					ljb1/fgAgAlmgAljb1/fgAgAlm]],
				Jaw = [[
					gAj/bw/8gAgAhzgAj5bz/6gAgAiKgAjsb5/1gAgAjJgAjacC/rgAgAkagAjKcL/ggAgAligAjBcQ/ZgAgAmLgAjOcC/lgAgAlIgAj2bX/7gAgAh8gAklbF/6
					gNfWeAgAlxbG/Gg/epYqgAlUbC/ggoe2amgAkgbG/8gKfaeZgAkObQ//gEfrf9gAkMbZ//gDfugQgAkHbk/+gBf1g2gAkCbt/9gAf8hegAj/bw/8gAgAhygA
					j/bw/8gAgAhzgAj/bw/8gAgAhz]],
				["UpperLegF.L"] = [[
					d+iqe0x+fDgA6cd+ioe3x6fCf/6fd+iifAyDe/f86Zd+ibfLyze7f553d+iVfVz3e3f35Dd+iSfa0me1f24cd+iWfLyse1ft57d+ijebule8fk8cd+ipeSzY
					fCf+5bd+izeO2MfIgJ3Bd+iveP0yfFgE4Td+ioeTzQfCf+5id+ineawNe/fy7jd+ioeit5e/fp8yd+iperu9fAfy8Qd+iqeyxzfDf/6kd+iqe0x+fDgA6cd+
					iqe0x+fDgA6cd+iqe0x+fDgA6c]],
				["LowerLegF.L"] = [[
					d7hvfM7agAgAwfd7htfP7+gAgCvhd7hnfX9Nf/gItEd7hffe+Wf9gNqHd6hYfj/Df6gRnrd6hUfl/Vf4gSmad6haff/wf5gZj6d6hvfA/tf8gbkNd7hsej8V
					f/gBu2d8h0eQ5Kf4fwzwd8hxeZ6vf8f4xkd7hsel8bf/gCuqd6hwe4+TgCgPqPd6h3fJ/BgBgVn1d6h1fP94gEgOrbd7hwfK7pgAgBwFd7hvfM7agAgAwfd7
					hvfM7agAgAwfd7hvfM7agAgAwf]],
				["FootF.L"] = [[
					d7g+ex/dgAgAl0d7g+ex/dgBgAl0d7g+ex/dgBgAl0d7g+ex/df/gAl0d7g+ex/df9gBl0d7g+ex/df7gBl0d7hNep/df9gBl0d7hheK/dgBgAl0d7g+eD/d
					f/gAl0d7g+eD/df2gCl0d7g+eD/df7gBl0d7g+eE/df/gAl0d7hOeM/dgEf/l0d7hdeY/dgFf/l0d7hQel/dgGf/l0d7g/ev/dgBgAl0d7g+ex/dgAgAl0d7
					g+ex/dgAgAl0d7g+ex/dgAgAl0]],
				["UpperLegF.R"] = [[
					iCiqe0x+g9gA6ciCioe3nbg4gJ/GiCiifAwmhAgG7ViCibfLpLhAgS+oiCiVfVushGgR8ZiCiSfazFhLgN5piCiWfLyshLgT57iCijebulhEgc8ciCipeSzY
					g+gC5biCizeO2Mg4f33BiCiveP0yg7f84TiCioeTzQg+gC5iiCineawNhBgO7jiCioeit5hBgX8yiCiperu9hAgO8QiCiqeyxzg9gB6kiCiqe0x+g9gA6ciC
					iqe0x+g9gA6ciCiqe0x+g9gA6c]],
				["LowerLegF.R"] = [[
					iFhvfM7agAgAwfiFiLfw4kfzgB0giFhqfd9Lf/f2tHiGh5f/9Of4fwtAiGhif5/BgBfpnziGhVfs/agGfrmDiGhaff/wgHfnj6iGhvfA/tgEflkNiFhsej8V
					gBf/u2iEh0eQ5KgIgQzwiEhxeZ6vgEgIxkiFhsel8bgBf+uqiGhwe4+Tf+fxqPiGh3fJ/Bf/frn1iGh1fP94f8fyrbiFhwfK7pgAf/wFiFhvfM7agAgAwfiF
					hvfM7agAgAwfiFhvfM7agAgAwf]],
				["FootF.R"] = [[
					iFg+ex/dgAgAl0iFhUfm/dfzgCl0iFhAe4/df9gBl0iFhPfa/df1gCl0iFhHfI/df9gBl0iFhBe4/dgDf/l0iFhNep/dgDf/l0iFhheK/df/gAl0iFg+eD/d
					gBgAl0iFg+eD/dgKf+l0iFg+eD/dgFf/l0iFg+eE/dgBgAl0iFhOeM/df8gBl0iFhdeY/df7gBl0iFhQel/df6gBl0iFg/ev/df/gAl0iFg+ex/dgAgAl0iF
					g+ex/dgAgAl0iFg+ex/dgAgAl0]],
				Oiseau = [[
					fMmeirgAABgAgAfMmfirgAABgKgZfMmgisf+ADgmhdfMmhitgAAChJgAfMmiitgNAUhpb8fMmjiugSAbh6bQfMmgiogAADhegAfMmYiRf/AYgEk0fMmSiTgH
					AZfUk0fMmMicgAAEeVgAfMmPiZfzAaetbMfMmTiTf6AZfZbMfMmWiVgAABfrgAfMmYidgDAYfuk0fMmbikgCAYf1k0fMmdipgAABf8gAfMmeirgAAJgAdLfM
					meirgAACgAfJfMmeirgAABgAgA]],
				Arbre1 = [[
					ginChgOmaegA6QginBhhOdaXgM6JginAhiOMaWgS59gim9hkONbDfG6Ggim7hlN7bFfF56gim6hmNLZvhi5Dgim7hfNWZch85Egim7hGOva4fU6bgim5hKPw
					bqd47Hgim3hWP/aeft7Igim4hSPMZKhr6Sgim5hKO7aCgl6Ygim7hLPXbgeL65gim9hTPMbPep6wgim/haOaZqhQ57ginBhfOQZdhm5vginChgOtatfm6Ygi
					nChgOsarfp6XginChgOmaegA6Q]],
				Arbre2 = [[
					fdnOgJOmaegA6QfdnMgKOiajf56PfdnJgLOSakf66FfdnFgMNuZ/g+5ifdnBgONbZ+hG5Ufdm/gONwbCfL5yfdnBgIOIbPev6EfdnHfvOaaIgk6EfdnJf0Ox
					Zdhb6GfdnMgBP/aeft7IfdnLf8QJbeeM7WfdnJfzPQa0fW6vfdnJf1OhZmhU5+fdnLf8OkZ0g+6FfdnMgDPBbFe76ofdnNgIPAbPer6pfdnOgJOgaRgV6Kfd
					nOgJOhaTgS6LfdnOgJOmaegA6Q]],
				Tail1 = [[
					gAjriHkogAgA/qgAjqiJksgAgA/pgAjpiOk4gAgA/ngAjniVlHgAgA/lgAjliblUgAgA/igAjkiflcgAgA/hgAjkiTlQgAgA/jgAjkhukgf1gC/rgAjhhnkZ
					fTgH/rgAjehmk6gAgA/ngAjfhnkjhEf2/pgAjhhoj2hofu/tgAjjhujkhbfw/wgAjmh2jrggf6/xgAjoh/j6fpgE/wgAjqiFkNfggF/tgAjriHkff1gC/rgA
					jriHkogAgA/qgAjriHkogAgA/q]],
				Tail2 = [[
					gAjeizj7gAgA/wgAjdi1kIgAgA/ugAjbi6krgAgA/pgAjYjAlYgAgA/igAjWjGmBgAgA/bgAjVjJmXgAgA/WgAjWi/lygAgA/dgAjXiZjufsgD/xf+jUiTix
					ePgP/0gAjQiSi0fCgK/2gDjSiSidhMf5/4gEjWiUhwiyfn/0gEjZiahejEfh/zgBjbiihuhuft/5f/jdiriTf7f//6f/jeixjBfRgG/1gAjeizjofrgD/ygA
					jeizj7gAgA/wgAjeizj7gAgA/w]],
				Tail3 = [[
					gAjTjfjggAgA/zgAjRjhj2gAgA/wgAjOjlkwgAgA/ogAjJjrl7gAgA/cgAjFjwm+gAgA/OgAjDjznkgAgA/FgAjFjpmmgAgA/Tf/jNjGjNfngD/1f5jMjAhb
					dOgW/1f9jIi+g/ddgZ/3gGjLi/gpgVgJ/+gMjRjBf7jBfu/2gNjVjGfpkTfa/sgGjWjPgDjMfe/1f/jWjYg+gxf1/9f9jWjeiGfYgE/6f/jUjfjEfmgD/1gA
					jTjfjfgAgA/zgAjTjfjggAgA/z]],
				Tail4 = [[
					gAjJkLgAgAgA//gAjGkNgfgAgA//gAjAkRhxgAgA/8gAi5kWjcgAgA/zgAiykak7gAgA/ngAiukclwgAgA/egAizkTkYgAgA/sf+jEjyfnfogA//fxjIjsdB
					cogB/rf2jFjrcHb3gN/egHjJjtbxexgZ/rgVjRjtbFiQgT/hgZjWjya0krgA/OgPjWj8bWkYfy/WgBjUkFclh3f0/wf7jQkLeHf0f9/7f9jLkMfafngA//gA
					jJkLgAgAgA//gAjJkLgAgAgA//]],
				Tail5 = [[
					gAjJk5ZPgAgA/RgAjFk6Z2gAgA/ZgAi7k+begAgA/qgAivlCdngAgA/5gAiklFfigAgA//gAielGgogAgA//gAink+e2gAgA/+f8jFkgYxfwf8/KfojRkYVh
					czfN+CfqjQkWUSa+fG9UgEjVkYT6dFgA9egbjfkYTQgng29UgmjkkbTDj2hM8+gcjjkmTsktg59IgGjdkxVHivgW99f6jVk4W8gagA+rf8jNk5Yhfvf8/GgA
					jJk5ZPgAgA/RgAjJk5ZPgAgA/R]],
				["UpperLegB.L"] = [[
					eBiqhT7WekgAwieBiphW7mejf/wHeBinhc8Neff8vAeBikhj85ecf5toeBiihq9aeZf3seeBihhu9qeYf1r3eBiihi9JeZf3tGeBijg650elgCy2eBiigx4x
					epgE0MeBiigs4DeugF1DeBiigu4VesgE0ueBiigy46epgE0BeBikg55lengCzJeBimhB6SelgByLeBiohK65ekgAxQeBiphR7QekgAwseBiqhT7WekgAwjeB
					iqhT7WekgAwieBiqhT7WekgAwi]],
				["LowerLegB.L"] = [[
					d+hvg0wfgAgA7ad+hvg1wmgAgB7Wd+hwg2xBgAgC7Fd+hxg5xuf/gE6od+hzg8ygf+gF6Gd+hzg+y/f9gG5vd+hwg2w+gBgF7Hd+hkgmrvgHf99wd+hhgkqz
					gHf7+Hd+hhgjqpgGf5+Kd+hhgjqrgHf6+Kd+higkq7gHf7+Ed+hkgmrxgGf89vd+hogqtKgFf+9Kd+hsgvuygDf/8Xd+hugzwFgBgA7qd+hvg0wfgAgA7ad+
					hvg0wfgAgA7ad+hvg0wfgAgA7a]],
				["UpperLegB.R"] = [[
					h/iqhT7WhcgAwih/iphW7mhdgBwHh/inhc8NhhgEvAh/ikhj85hkgHtoh/iihq9ahngJseh/ihhu9qhogLr3h/iihi9JhngJtGh/ijg650hbf+y2h/iigx4x
					hXf80Mh/iigs4DhSf71Dh/iigu4VhUf80uh/iigy46hXf80Bh/ikg55lhZf+zJh/imhB6Shbf/yLh/iohK65hcgAxQh/iphR7QhcgAwsh/iqhT7WhcgAwjh/
					iqhT7WhcgAwih/iqhT7WhcgAwi]],
				["LowerLegB.R"] = [[
					iChvg0wfgAgA7aiChvg1wmgAf/7WiChwg2xBgAf+7FiChxg5xugBf86oiChzg8yggCf76GiChzg+y/gDf65viChwg2w+f/f77HiChkgmrvf5gD9wiChhgkqz
					f5gF+HiChhgjqpf6gH+KiChhgjqrf5gG+KiChigkq7f5gF+EiChkgmrxf6gE9viChogqtKf7gC9KiChsgvuyf9gB8XiChugzwFf/gA7qiChvg0wfgAgA7aiC
					hvg0wfgAgA7aiChvg0wfgAgA7a]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAj6hTAPgAgAjtgAj5hWAOgAgAjpgAj4hdANgAgAjfgAj2hkAMgAgAjVgAj1hmAMgAgAjTgAj3heANgAgAjfgAj7hSAUgAgAkZgAj+hNAegAgAlZgAj/hMAh
					gAgAlpgAj/hMAhgAgAlpgAj/hMAhgAgAlpgAj/hMAhgAgAlpgAj/hMAhgAgAlpgAj/hMAhgAgAlpgAj/hMAhgAgAlpgAj/hMAhgAgAlpgAj/hMAhgAgAlpgA
					j/hMAhgAgAlpgAj/hMAhgAgAlpgAj+hNAegAgAlagAj8hQAWgAgAkmgAj6hTAQgAgAj3gAj6hTAPgAgAjtgAj6hTAPgAgAjtgAj6hTAPgAgAjt]],
				Spine1 = [[
					gAkEgpAPgAgAjtgAkDgsAOgAgAjmgAkBgzAMgAgAjVgAj/g5ALgAgAjGgAj+g7AKgAgAjBgAkBg0AMgAgAjVgAkHgoAWgAgAklgAkNgjAkgAgAl3gAkOgjAo
					gAgAmMgAkOgjAogAgAmMgAkOgjAogAgAmMgAkOgjAogAgAmMgAkOgjAogAgAmMgAkOgjAogAgAmMgAkOgjAogAgAmMgAkOgjAogAgAmMgAkOgjAogAgAmMgA
					kOgjAogAgAmMgAkOgjAogAgAmMgAkNgjAkgAgAl5gAkJgmAZgAgAk3gAkFgoAQgAgAj5gAkEgpAPgAgAjtgAkEgpAPgAgAjtgAkEgpAPgAgAjt]],
				Spine2 = [[
					gAkOf+/8gAgAhmgAkNgB/8gAgAhwgAkKgI/7gAgAiHgAkHgO/5gAgAidgAkHgQ/4gAgAikgAkKgJ/6gAgAiJgAkUf+//gAgAgigAkcf7/+gAgAe7gAkef6/9
					gAgAeigAkef6/9gAgAeigAkef6/9gAgAeigAkef6/9gAgAeigAkef6/9gAgAeigAkef6/9gAgAeigAkef6/9gAgAeigAkef6/9gAgAeigAkef6/9gAgAeigA
					kef6/9gAgAeigAkef6/9gAgAeigAkcf7/+gAgAe5gAkWf8//gAgAgLgAkPf+/9gAgAhXgAkOf+/8gAgAhmgAkOf+/8gAgAhmgAkOf+/8gAgAhm]],
				Spine3 = [[
					gAkKfY/8gAgAhmgAkJfb/8gAgAhzgAkFfi/6gAgAiRgAkBfo/4gAgAitgAkAfq/3gAgAi1gAkFfj/6gAgAiTgAkSfX//gAgAgWgAkffU/9gAgAecgAkifU/7
					gAgAd+gAkifU/7gAgAd+gAkifU/7gAgAd+gAkifU/7gAgAd+gAkifU/7gAgAd+gAkifU/7gAgAd+gAkifU/7gAgAd+gAkifU/7gAgAd+gAkifU/7gAgAd+gA
					kifU/7gAgAd+gAkifU/7gAgAd+gAkffU/8gAgAeagAkVfW//gAgAf7gAkMfX/9gAgAhUgAkKfY/8gAgAhmgAkKfY/8gAgAhmgAkKfY/8gAgAhm]],
				Neck1 = [[
					gAkGexAVgAgAkcgAkEe0ASgAgAkKgAj/e7ANgAgAjfgAj7fCAJgAgAi2gAj6fEAIgAgAiqgAj/e8ANgAgAjcgAkRexArgAgAmcgAkjeuBbgAgApagAknetBq
					gAgAqJgAknetBqgAgAqJgAknetBqgAgAqJgAknetBqgAgAqJgAknetBqgAgAqJgAknetBqgAgAqJgAknetBqgAgAqJgAknetBqgAgAqJgAknetBqgAgAqJgA
					knetBqgAgAqJgAknetBqgAgAqJgAkjeuBdgAgApdgAkVevA0gAgAnHgAkJexAZgAgAk4gAkGexAVgAgAkcgAkGexAVgAgAkcgAkGexAVgAgAkc]],
				Neck2 = [[
					gAkZdwBLgAgAoigAkWdzBFgAgAoLgAkOd5A3gAgAnUgAkHd/AsgAgAmggAkFeBAogAgAmQgAkNd6A2gAgAnRgAksdzCDgAgArNgAlId2DygAgAvDgAlPd3ET
					gAgAv/gAlPd3ETgAgAv/gAlPd3ETgAgAv/gAlPd3ETgAgAv/gAlPd3ETgAgAv/gAlPd3ETgAgAv/gAlPd3ETgAgAv/gAlPd3ETgAgAv/gAlPd3ETgAgAv/gA
					lPd3ETgAgAv/gAlPd3ETgAgAv/gAlJd2D0gAgAvIgAkzdyCZgAgAsFgAkddxBWgAgApJgAkZdwBLgAgAoigAkZdwBLgAgAoigAkZdwBLgAgAoi]],
				Neck3 = [[
					gAk1dCBLgAgAoigAkwdEBEgAgAoGgAkmdJAzgAgAnCgAkcdOAlgAgAmBgAkZdPAigAgAltgAkldKAygAgAm+gAlPdKCVgAgAr8gAl1dYEwgAgAwvgAl+dcFf
					gAgAx4gAl+dcFfgAgAx4gAl+dcFfgAgAx4gAl+dcFfgAgAx4gAl+dcFfgAgAx4gAl+dcFfgAgAx4gAl+dcFfgAgAx4gAl+dcFfgAgAx4gAl+dcFfgAgAx4gA
					l+dcFfgAgAx4gAl+dcFfgAgAx4gAl2dYEzgAgAw1gAlYdLCzgAgAtCgAk7dDBZgAgApTgAk1dCBLgAgAoigAk1dCBLgAgAoigAk1dCBLgAgAoi]],
				Head = [[
					gAljb1/fgAgAlmgAlcb2/YgAgAmMgAlNb4/FgAgAnkgAk9b6+vgAgAo2gAk5b7+ogAgApPgAlMb4/EgAgBnngAmOcJ//gAgAgqgAnGcv/ZgcfSZ8gAnSc7+o
					fbgxWzgAnSc7+1gAgAXggAnSc7/AgjfNYNgAnSc7+ofbgxWzgAnSc7+1gAgAXggAnSc7/AgjfNYNgAnSc7+ofbgxWzgAnSc7+1gAgAXggAnSc7/AgjfNYNgA
					nSc7+ofbgxWzgAnSc7+1gAgAXggAnHcw/XgcfSZzgAmbcP/9f1gaetgAltb5/qgAgAkhgAljb1/fgAgAlmgAljb1/fgAgAlmgAljb1/fgAgAlm]],
				Jaw = [[
					gAj/bw/8gAgAhzgAj4b1/4gAgAikgAjpcA/sgAgAkZgAjacK/agAgAmGgAjWcO/TgAgAmmgAjocB/qgAgBkngAkwbm//gAgAgBgAl+bo/3ghfVdWgAmabn/n
					fUgsbPgAmWbq/vgAgAb9gAmSbt/zgqfScrgAmabn/nfUgsbPgAmWbq/vgAgAb9gAmSbt/zgqfScrgAmabn/nfUgsbPgAmWbq/vgAgAb9gAmSbt/zgqfScrgA
					mabn/nfUgsbPgAmWbq/vgAgAb9gAmAbp/3ghfVdSgAlCbh/9f1gaewgAkJbt/9gAgAhWgAj/bw/8gAgAhzgAj/bw/8gAgAhzgAj/bw/8gAgAhz]],
				["UpperLegF.L"] = [[
					d+iqe0x+fDgA6cd+ioe4yDfCf/6Zd+ijfCyke/f86Bd+iffLzYe8f65bd+idfOzre7f65Nd+ijfDyse+f858d+i1etzTfIgF5fd+jHee1efSgO3sd+jMeb1V
					fTgO31d+jMeb1VfTgO31d+jMeb1VfTgO31d+jMeb1VfTgO31d+jMeb1VfTgO31d+jMeb1VfTgO31d+jMeb1VfTgO31d+jMeb1VfTgO31d+jMeb1VfTgO31d+
					jMeb1VfTgO31d+jMeb1VfTgO31d+jIee1cfSgN3ud+i5eosQfDft9id+iseytLfAfu9Id+iqe0x7fDgA6ed+iqe0x+fDgA6cd+iqe0x+fDgA6c]],
				["LowerLegF.L"] = [[
					d7hvfM7agAgAwfd7htfP8BgAgCvbd7hnfX9Mf/gHtEd7hifc+Cf9gKrBd7hgfd+Pf8gLqdd7hnfX9Uf+gHsyd8h4e+5gf+f3zUd9iIel1if2fm3pd9iNei1Z
					f3fm3yd9iNei1Zf3fm3yd9iNei1Zf3fm3yd9iNei1Zf3fm3yd9iNei1Zf3fm3yd9iNei1Zf3fm3yd9iNei1Zf3fm3yd9iNei1Zf3fm3yd9iNei1Zf3fm3yd9
					iNei1Zf3fm3yd9iNei1Zf3fm3yd9iJel1gf2fm3rd6iMfV9dgJgNsdd6h9fc+HgFgQqzd7hvfM7dgAgAwbd7hvfM7agAgAwfd7hvfM7agAgAwf]],
				["FootF.L"] = [[
					d7g+ex/dgAgAl0d7g+ex/dgAgAl0d7g+ex/dgAgAl0d7g+ex/df/gAl0d7g+ex/df+gAl0d7g+ex/dgAgAl0d7hCeu/df8gBl0d7hReq+/fygAn8d8hWeo+x
					fzf/oud8hWeo+xfzf/oud8hWeo+xfzf/oud8hWeo+xfzf/oud8hWeo+xfzf/oud8hWeo+xfzf/oud8hWeo+xfzf/oud8hWeo+xfzf/oud8hWeo+xfzf/oud8
					hWeo+xfzf/oud8hWeo+xfzf/oud7hReq/HfxgBnbd7hkeu/dgLf+l0d7hZex/dgIf/l0d7g+ex/dgAgAl0d7g+ex/dgAgAl0d7g+ex/dgAgAl0]],
				["UpperLegF.R"] = [[
					iCiqe0x+g9gA6ciCioe4yDg+gB6ZiCijfCykhBgE6BiCiffLzYhEgG5biCidfOzrhFgG5NiCijfDyshCgE58iCi1etzTg4f75fiCjHee1egufy3siCjMeb1V
					gtfy31iCjMeb1Vgtfy31iCjMeb1Vgtfy31iCjMeb1Vgtfy31iCjMeb1Vgtfy31iCjMeb1Vgtfy31iCjMeb1Vgtfy31iCjMeb1Vgtfy31iCjMeb1Vgtfy31iC
					jMeb1Vgtfy31iCjMeb1Vgtfy31iCjIee1dgufy3uiCi5eoupg7gK8biCiseyu3g/gL8UiCiqe0x8g9gA6diCiqe0x+g9gA6ciCiqe0x+g9gA6c]],
				["LowerLegF.R"] = [[
					iFhvfM7agAgAwfiFhtfP8BgAf+vbiFhnfX9MgBf5tEiFhifc+CgDf2rBiFhgfd+PgEf1qdiFhnfX9UgCf5syiEh4e+5ggCgJzUiDiIel1igKga3piDiNei1Z
					gJga3yiDiNei1ZgJga3yiDiNei1ZgJga3yiDiNei1ZgJga3yiDiNei1ZgJga3yiDiNei1ZgJga3yiDiNei1ZgJga3yiDiNei1ZgJga3yiDiNei1ZgJga3yiD
					iNei1ZgJga3yiDiNei1ZgJga3yiDiJek1hgKga3riFiGfN8Nf5f7vGiFh4fW9Nf7f1tCiFhvfM7cgAgAwciFhvfM7agAgAwfiFhvfM7agAgAwf]],
				["FootF.R"] = [[
					iFg+ex/dgAgAl0iFg+ex/dgAgAl0iFg+ex/dgAgAl0iFg+ex/dgBgAl0iFg+ex/dgCgAl0iFg+ex/dgAgAl0iFhCeu/dgEf/l0iFhReq+/gOgAn8iEhWeo+x
					gNgBouiEhWeo+xgNgBouiEhWeo+xgNgBouiEhWeo+xgNgBouiEhWeo+xgNgBouiEhWeo+xgNgBouiEhWeo+xgNgBouiEhWeo+xgNgBouiEhWeo+xgNgBouiE
					hWeo+xgNgBouiEhWeo+xgNgBouiFhReq/EgPgAnqiFhXeu/df4gBl0iFhPex/df5gBl0iFg+ex/dgAgAl0iFg+ex/dgAgAl0iFg+ex/dgAgAl0]],
				Oiseau = [[
					fMmeirgAABgAgAfMmfisgAABgKgMfMmgivf/ACghhAfMmgiyf9AEg3hefMmhizgAACg+gAfMmgiwgDALgjc6fMmYizf1Ade9a0fMmOi8frAYdXcFfMmLi/gA
					AKc8gAfMmLi/gYAac9j7fMmLi/giApc/lifMmLi/gYAac9j7fMmLi/gAAKc8gAfMmLi/foAac9cFfMmLi/feApc/aefMmLi/foAac9cFfMmLi/gAAKc8gAfM
					mLi/gYAac9j7fMmLi/giApc/lifMmNi9gVAYdVj7fMmWi1gAADelgAfMmdisf/AJfxdSfMmeirgAAFgAd8fMmeirgAABgAfmfMmeirgAABgAgA]],
				Arbre1 = [[
					ginChgOmaegA6QginBhiOfabgG6LginAhlONaSgY59gim/hpOFaegH56gim+hqOTbDfE6KginAhmOqbQeq6bginBhpPUaef26uginBh0P+ZShR60ginAh3QP
					ZRhN6/ginAh3Qtaffk7iginAh3RPbpd379ginAh3RPbpd379ginAh3Qtaffk7iginAh3QPZRhN6/ginAh3QPZRhN6/ginAh3Qtaffk7iginAh3RPbpd379gi
					nAh3RPbpd379ginAh3Qtaffk7iginBh0P/ZShR61ginChrPJZahY6VginChiOwaef+6XginChgOxa2fW6cginChgOpalf06UginChgOmaegA6Q]],
				Arbre2 = [[
					fdnOgJOmaegA6QfdnMgLOhagf96OfdnKgOOWanf06IfdnHgSOFaegH56fdnGgTN1Z/g95nfdnJgPOAZzhL5rfdnSgTPUaef26ufdnYggQ1bZeR7ufdnagjRI
					baeO74fdnagjQtaffk7ifdnagjQVZhg47GfdnagjQVZhg47GfdnagjQtaffk7ifdnagjRIbaeO74fdnagjRIbaeO74fdnagjQtaffk7ifdnagjQVZhg47Gfd
					nagjQVZhg47GfdnagjQtaffk7ifdnZggQ3bZeQ7vfdnUgVP8bSeg7NfdnPgLOwaef+6XfdnOgJOdaKgh6GfdnOgJOjaYgJ6NfdnOgJOmaegA6Q]],
				Tail1 = [[
					gAjriHkogAgA/qgAjqiKkbgAgA/rgAjpiRj9gAgA/vgAjoiYjhgAgA/zgAjniajZgAgA/zgAjpiSj7gAgA/wgAjqiFl2fmgD/cgAjph+nugQf//DgAjph9oL
					g+f++6gAjph9oLfOgC+6gAjph9oLfcgB+7gAjph9oLhFf++6gAjph9oLgAgA+7gAjph9oLe7gC+6gAjph9oLgkf/+7gAjph9oLgyf++6gAjph9oLfCgC+6gA
					jph9oLfugB+7gAjph9oLhHf++6gAjph+nwfwgB/CgAjqiDmSfjgD/XgAjqiGk5gEf//ngAjriHkogAgA/qgAjriHkogAgA/qgAjriHkogAgA/q]],
				Tail2 = [[
					gAjeizj7gAgA/wgAjei2jmgAgA/ygAjei9i0gAgA/3gAjejEiFgAgA/7gAjejGh3gAgA/8gAjei+iwgBgA/3f/jZivltfQgE/egBjUinocf6f++3gDjTilpG
					iFf/+mf+jTilpGfCgD+pf+jTilpGebf/+ogDjTilpGhyf++ngAjTilpHgqgC+qf9jTilpGd5gB+mgCjTilpHgcf9+qgCjTilpGh5gA+nf9jTilpGelgD+of/
					jTilpGe2f/+pgDjTilpGiBf++mf/jUimofgGgC+2f/jYitmWfDgE/VgAjdiykVgFf//sgAjeizj7gAgA/wgAjeizj7gAgA/wgAjeizj7gAgA/w]],
				Tail3 = [[
					gAjTjfjggAgA/zgAjTjijCgAgA/2gAjWjqh8gAgA/7gAjYjxg6gAgA/+gAjZjzgmgAgA//gAjWjrh2gCgA/8f9jJjal1fIgF/cgAi9jOpbfGf6+jgIi6jKqR
					i5gA+Kf7i6jLqTfjgJ+Sf6i6jLqRdWf8+LgIi6jKqSh1f6+PgCi6jLqShugI+Pf3i6jKqRdSgC+LgDi6jLqTftf3+SgHi6jKqRi4gC+Kf6i6jLqSe0gI+Rf8
					i6jLqSdvf6+NgJi6jKqRiXf7+NgAi9jOpfg7gG+if8jHjWmreqgF/QgAjRjekCgCgA/vgAjTjfjggAgA/zgAjTjfjggAgA/zgAjTjfjggAgA/z]],
				Tail4 = [[
					gAjJkLgAgAgA//gAjLkPfagAgA//gAjQkXeAgAgA/7gAjVkfcrgAgA/0gAjXkhcSgAgA/xgAjRkYd3gCgA/6f6i5kEi6fQgA/2f+ijjznceKfo/DgQiejuoh
					jHgO+rf6iejvoigggY+0fziejuohcpfl+pgNiejuoihQf2+zgHiejvoiiugg+tfwiejuoidWf6+ugCiejvoieqfj+zgPiejuohjXgV+pf2iejuoifngS+1f2
					iejuohc2fi+qgPiejuoiiBf++xgCijjznhh3gY/Cf4i0kAj/ejf9/tgAjFkKgqf9gA//gAjJkLgAgAgA//gAjJkLgAgAgA//gAjJkLgAgAgA//]],
				Tail5 = [[
					gAjJk5ZPgAgA/RgAjNk8YigAgA/GgAjWlEW3gAgA+qgAjflLVUgAgA+JgAjhlNU3gAgA9/gAjXlFWtgDgB+nf4ixkxcqflf+/0f5iPkciKdle+/zgZiHkUjg
					ipgf/rf8iHkWjfhYhB/wfqiHkUjgcpe//mgQiHkVjfgXfh/ygOiHkVjgjLhR/nfpiHkUjfeAf1/vf+iHkWjfd3e1/tgYiHkUjgjHgy/of2iHkVjfgigy/yft
					iHkUjhcoe1/mgUiHkVjfhOf1/xgIiOkbiRichD/zf0ipksd+eyfw/5gAjDk3aBf4f+/bgAjJk5ZPgAgA/RgAjJk5ZPgAgA/RgAjJk5ZPgAgA/R]],
				["UpperLegB.L"] = [[
					eBiqhT7WekgAwieBiphX7qeif/wAeBinhe8Uegf8uzeBimhm82edf6tveBilho8/edf5tceBinhf8aeff8uoeBirhO6yeogCxceBiuhE5XewgGzdeBivhC4+
					eygHz9eBivhC4+eygHz9eBivhC4+eygHz9eBivhC4+eygHz9eBivhC4+eygHz9eBivhC4+eygHz9eBivhC4+eygHz9eBivhC4+eygHz9eBivhC4+eygHz9eB
					ivhC4+eygHz9eBivhC4+eygHz9eBiuhE5VewgGzgeBishL6ZeqgDyCeBiqhS7MelgAwyeBiqhT7WekgAwieBiqhT7WekgAwieBiqhT7WekgAwi]],
				["LowerLegB.L"] = [[
					d+hvg0wfgAgA7ad+hwg1wwgAgB7Qd+hxg4xhf/gC6xd+hyg8yYf+gD6Ld+hzg9yqf9gE5/d+hxg5xpf/gC6rd+hvg0wOgAf+7kd/hugzwCf+f77rd/hugzwG
					f9f67pd/hugzwGf9f67pd/hugzwGf9f67pd/hugzwGf9f67pd/hugzwGf9f67pd/hugzwGf9f67pd/hugzwGf9f67pd/hugzwGf9f67pd/hugzwGf9f67pd/
					hugzwGf9f67pd/hugzwGf9f67pd/hugzwCf+f67rd+hugzwFgAf97qd+hvg0wZgAgA7ed+hvg0wfgAgA7ad+hvg0wfgAgA7ad+hvg0wfgAgA7a]],
				["UpperLegB.R"] = [[
					h/iqhT7WhcgAwih/iphX7qhegBwAh/inhe8UhggEuzh/imhm82hjgGtvh/ilho8/hjgHtch/inhf8ahhgEuoh/irhO6yhYf+xch/iuhE5XhQf6zdh/ivhC4+
					hOf5z9h/ivhC4+hOf5z9h/ivhC4+hOf5z9h/ivhC4+hOf5z9h/ivhC4+hOf5z9h/ivhC4+hOf5z9h/ivhC4+hOf5z9h/ivhC4+hOf5z9h/ivhC4+hOf5z9h/
					ivhC4+hOf5z9h/ivhC4+hOf5z9h/iuhE5VhQf6zgh/ishL6ZhWf9yCh/iqhS7MhbgAwyh/iqhT7WhcgAwih/iqhT7WhcgAwih/iqhT7WhcgAwi]],
				["LowerLegB.R"] = [[
					iChvg0wfgAgA7aiChwg1wwgAf/7QiChxg4xhgBf+6xiChyg8yYgCf96LiChzg9yqgDf85/iChxg5xpgBf+6riChvg0wOgAgC7kiBhugzwCgCgF7riBhugzwG
					gDgG7piBhugzwGgDgG7piBhugzwGgDgG7piBhugzwGgDgG7piBhugzwGgDgG7piBhugzwGgDgG7piBhugzwGgDgG7piBhugzwGgDgG7piBhugzwGgDgG7piB
					hugzwGgDgG7piBhugzwGgDgG7piBhugzwCgCgG7riChugzwFgAgD7qiChvg0wZgAgA7eiChvg0wfgAgA7aiChvg0wfgAgA7aiChvg0wfgAgA7a]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAj6hTAPgAgAjtgAj8hXAZgAgAk4gAkAhgA3gAgAnUgAkDhmBRgAgAo2gAkDhmBSgAgAo5gAkDhmBSgAgAo5gAkDhmBSgAgAo5gAkDhmBSgAgAo5gAkDhmBS
					gAgAo5gAkQhmBSgAgAo5gAkWhmBSgAgAo5gAkQhmBSgAgAo5gAkDhmBSgAgAo5gAkDhmBSgAgAo5gAkDhmBSgAgAo5gAkDhmBSgAgAo5gAkDhmBSgAgAo5gA
					kDhlBMgAgAojgAj/heAvgAgAmxgAj8hXAXgAgAkpgAj6hTAPgAgAjt]],
				Spine1 = [[
					gAkEgpAPgAgAjtgAkJguAbgAgAlEgAkUg5BAgAgAn4gAkahBBggAgAppgAkbhBBhgAgAptgAkbhBBhgAgAptgAkbhBBhgAgAptgAkbhBBhgAgAptgAkbhBBh
					gAgAptgAkohBBhgAgAptgAkthBBhgAgAptgAkohBBhgAgAptgAkbhBBhgAgAptgAkbhBBhgAgAptgAkbhBBhgAgAptgAkbhBBhgAgAptgAkbhBBhgAgAptgA
					kZg/BagAgApTgAkSg3A2gAgAnQgAkIgtAYgAgAkzgAkEgpAPgAgAjt]],
				Spine2 = [[
					gAkOf+/8gAgAhmgAkXgE//gAgAgDgAkpgT/1gAgAcygAkzgd/jgAgAatgAk0gd/igAgAapgAk0gd/igAgAapgAk0gd/igAgAapgAk0gd/igAgAapgAk0gd/i
					gAgAapgAlBgd/igAgAapgAlGgd/igAgAapgAlBgd/igAgAapgAk0gd/igAgAapgAk0gd/igAgAapgAk0gd/igAgAapgAk0gd/igAgAapgAk0gd/igAgAapgA
					kxgb/ngAgAbHgAklgP/5gAgAdggAkVgD//gAgAgWgAkOf+/8gAgAhm]],
				Spine3 = [[
					gAkKfY/8gAgAhmgAkXfe//gAgAf3gAkwft/xgAgAcNgAlAf4/ZgAgAZ5gAlBf5/YgAgAZ0gAlBf5/YgAgAZ0gAlBf5/YgAgAZ0gAlBf5/YgAgAZ0gAlBf5/Y
					gAgAZ0gAlOf5/YgAgAZ0gAlTf5/YgAgAZ0gAlOf5/YgAgAZ0gAlBf5/YgAgAZ0gAlBf5/YgAgAZ0gAlBf5/YgAgAZ0gAlBf5/YgAgAZ0gAlBf5/YgAgAZ0gA
					k9f2/fgAgAaVgAkrfp/2gAgAdBgAkUfc//gAgAgNgAkKfY/8gAgAhm]],
				Neck1 = [[
					gAkGexAVgAgAkcgAkXe3AggAgAligAk6fHA/gAgAn2gAlPfUBZgAgApTgAlPfVBagAgApWgAlPfVBagAgApWgAlPfVBagAgApWgAlPfVBagAgApWgAlPfVBa
					gAgApWgAlcfVBagAgApWgAlifVBagAgApWgAlcfVBagAgApWgAlPfVBagAgApWgAlPfVBagAgApWgAlPfVBagAgApWgAlPfVBagAgApWgAlPfVBagAgApWgA
					lLfSBUgAgApBgAkyfDA4gAgAnVgAkUe2AegAgAlVgAkGexAVgAgAkc]],
				Neck2 = [[
					gAkZdwBLgAgAoigAkud4BUgAgApBgAlaeMBogAgAqBgAl0ecB2gAgAqpgAl1edB2gAgAqrgAl1edB2gAgAqrgAl1edB2gAgAqrgAl1edB2gAgAqrgAl1edB2
					gAgAqrgAmCedB2gAgAqrgAmHedB2gAgAqrgAmCedB2gAgAqrgAl1edB2gAgAqrgAl1edB2gAgAqrgAl1edB2gAgAqrgAl1edB2gAgAqrgAl1edB2gAgAqrgA
					lveZBzgAgAqigAlQeHBjgAgApzgAkqd2BSgAgAo7gAkZdwBLgAgAoi]],
				Neck3 = [[
					gAk1dCBLgAgAoigAlLdKBJgAgAobgAl6dgBFgAgAoLgAmWdyBCgAgAoAgAmXdzBCgAgAoAgAmXdzBCgAgAoAgAmXdzBCgAgAoAgAmXdzBCgAgAoAgAmXdzBC
					gAgAoAgAmkdzBCgAgAoAgAmpdzBCgAgAoAgAmkdzBCgAgAoAgAmXdzBCgAgAoAgAmXdzBCgAgAoAgAmXdzBCgAgAoAgAmXdzBCgAgAoAgAmXdzBCgAgAoAgA
					mRdvBDgAgAoCgAlwdbBGgAgAoOgAlHdIBKgAgAocgAk1dCBLgAgAoi]],
				Head = [[
					gAljb1/fgAgAlmgAl5b9/cgcgFl2gAmmcS/RiLgVmWgAnCck/IjIgcmqgAnCck/Oh9gSmsgAnCck/SgAgAmsgAnCck/OeDfumsgAnCck/Ic2fjmqgAnCck/I
					c2fjmqgAnQck/OeDfumsgAnVck/SgAgAmsgAnQck/Oh9gSmsgAnCck/IjKgdmqgAnCck/IjKgdmqgAnCck/Oh9gSmsgAnCck/SgAgAmsgAnCck/OeDfumsgA
					m8cg/KdEflmmgAmccN/UeKftmPgAl1b7/dfqf8lzgAljb1/fgAgAlm]],
				Jaw = [[
					gAj/bw/8gAgAhzgDkVb5/zgcgDjcgOlDcS/LiLgYm2gUlfcm+jjFgro9gMlfcn+nh7gbpDgAlecn+rgAgApEf0lfcn+neFflpDfslgcn+hc5fUpCfslgcn+h
					c5fUpCf0lscn+neFflpDgAlxcn+rgAgApEgMlscn+nh7gbpDgUlgcn+hjHgspCgUlgcn+hjHgspCgMlfcn+nh7gbpDgAlecn+rgAgApEf0lfcn+neFflpDft
					laci+rdGfZokf0k5cM/WeKfumGf+kQb4/1fqf+jHgAj/bw/8gAgAhz]],
				["UpperLegF.L"] = [[
					d+iqe0x+fDgA6cd+i7ewvHfEf08Ld+jherq1fIfd+Fd+j7estrfLfY85d+j8esyjfIfl6Dd+j8es0ufHfs4Wd+j8esyjfIfl6Dd+j8esttfLfY84d+j8espr
					fPfO+ed+kJesqofOfR+Jd+kPesvcfKfd8Ad+kJesztfHfp5Md+j8es0dfHfr4ld+j8esxFfIfh7Bd+j8essDfNfU9nd+j8espVfQfN+ld+j8essDfNfU9nd+
					j2eswwfIfj7Od+jYesyHfFfx6Wd+i3exxafEf661d+iqe0x+fDgA6c]],
				["LowerLegF.L"] = [[
					d7hvfM7agAgAwfd7iGfT85gGgItvd6i5fc+mgJgOpUd6jLfU/bgGgQl+d7jBfB/EgGgLnpd7i+e2+ogFgGpPd7jBfB/EgGgLnpd6jLfU/cgGgQl2d7jYfg/a
					gDgNmCd6jifd/cgEgOl3d6jZfO/YgHgQmOd7jMe7+3gFgJobd7i+e4+sgFgHpBd6jDfH/PgHgOm3d6jQfZ/egFgPlwd7jZfg/ZgDgMmHd6jQfZ/egFgPlwd6
					i+fI/GgHgNnhd7idfC9xgFgHrud7h+fK8VgDgDu2d7hvfM7agAgAwf]],
				["FootF.L"] = [[
					d7g+ex/dgAgAl0d7hbev/wgIf/j0d7iaet//gOgAfpd7i2eg/3gNgBdPd7ineP/3gLgBdKd7ifeI/3gHgBdKd7ineP/3gLgBdKd7i3eg/3gNgBdKd7jDes/3
					gIgBdKd7jOep/3gKgBdKd7jEea/3gNgBdKd7iweL/3gJgBdKd7igeJ/3gHgBdKd7iseU/3gMgBdKd7i8el/3gLgBdKd7jEet/3gIgBdKd7i8el/3gLgBdKd7
					ikeW/6gMgBdrd7h3eZ//gHgAgjd7hQeq/tgDgAkNd7g+ex/dgAgAl0]],
				["UpperLegF.R"] = [[
					iCiqe0x+g9gA6ciCi7ewxVg8gH63iCjheryjg6gR6CiCj7esxCg4gf7DiCj8essDgzgs9niCj8espVgwgz+liCj8essDgzgs9niCj8esxFg4gf7BiCj8es0d
					g5gV4liCkJesztg5gX5MiCkPesvcg2gj8AiCkJesqogygv+JiCj8esprgxgy+eiCj8esttg1go84iCj8esyjg4gb6DiCj8es0ug5gU4WiCj8esyjg4gb6DiC
					j2estjg2gm89iCjYesrhg5ge91iCi3exvmg8gK76iCiqe0x+g9gA6c]],
				["LowerLegF.R"] = [[
					iFhvfM7agAgAwfiFiBfK8if9f8udiFimfA+Df7f5q+iGjCfH/Of5fym9iGjQfZ/ef7fxlwiFjZfg/Zf9f0mHiGjQfZ/ef7fxlwiGjDfH/Pf5fym3iFi+e4+s
					f7f5pBiFjMe7+3f7f3obiGjZfO/Yf5fwmOiGjifd/cf8fyl3iFjYfg/af9fzmCiGjLfU/cf6fwl2iFjBfB/Ef6f1npiFi+e2+of7f6pPiFjBfB/Ef6f1npiG
					jGfU/Sf5fwmqiGiufa+Sf2fzqRiFiCfS8qf7f5uNiFhvfM7agAgAwf]],
				["FootF.R"] = [[
					iFg+ex/dgAgAl0iFhUep/wf8gAj0iFiCeV//f5gAfpiFireV/3f0f/dPiFi8el/3f1f/dKiFjEet/3f4f/dKiFi8el/3f1f/dKiFiseU/3f0f/dKiFigeJ/3
					f5f/dKiFiweL/3f3f/dKiFjEea/3fzf/dKiFjOep/3f2f/dKiFjDes/3f4f/dKiFi3eg/3fzf/dKiFineP/3f1f/dKiFifeI/3f5f/dKiFineP/3f1f/dKiF
					iveh/6fzf/driFiMeu//fygAgjiFhVew/tf5gBkNiFg+ex/dgAgAl0]],
				Oiseau = [[
					fMmeirgAABgAgAfMmWi+gBADedgTfMl/jigNAabNhUfMluj2gMAxZJg2fMluj2feA3ZGdmfMluj2e4BMZLa8fMluj2fTA8ZHczfMluj2gYA0ZGhsfMluj2hJ
					BNZLlKfMl7j2g+BFZJkZfMmAj2gAAyZFgAfMl7j2fCBFZJbnfMluj2e3BNZLa2fMluj2foA0ZGeUfMluj2gtA8ZHjNfMluj2hNBQZMlbfMluj2gtA8ZHjNfM
					lyjyftAtZjekfMmFjafqAZb8dYfMmXi6f+ADewfWfMmeirgAABgAgA]],
				Arbre1 = [[
					ginChgOmaegA6QginBh1PsaZf568gim8igSIaTfi8Qgim2i6UDbCec9Ngim2i7UZbrdr9Zgim2i7T7ake89Ggim2i7TWZCgk8igim2i7TkZof98xgim2i7UT
					bfd59WginDi7UjcCdP9eginIi7T7ake89GginDi7TWZCgk8igim2i7TkZof98xgim2i7UTbfd59Wgim2i7UjcCdP9egim2i7T7ake89Ggim2i7TWZCgk8igi
					m3i1TPZxf58qgim+iXR1a7e18MginChxPlapfi67ginChgOmaegA6Q]],
				Arbre2 = [[
					fdnOgJOmaegA6QfdnVgfPwaifq7AfdnfhPSSasfD8ZfdnhhuTuaMfX89fdnhhvTkZqf78yfdnhhvT7ake89GfdnhhvUbbwdl9afdnhhvUObTeH9TfdnhhvTo
					Z0fx82fdnuhvTdZWgQ8qfdn0hvT7ake89GfdnuhvUbbwdl9afdnhhvUObTeH9TfdnhhvToZ0fx82fdnhhvTdZWgQ8qfdnhhvT7ake89GfdnhhvUbbwdl9afd
					nhhoTzbLeT9IfdndhFRhaKf076fdnTgbPcaVgC6xfdnOgJOmaegA6Q]],
				Tail1 = [[
					gAjriHkogAgA/qgAjpiKlmg5f6/fgAjmiPnnjTf9+5gAjkiSo8higE+rgAjkiSo8dDf3+kgAjkiSo4bAfx+UgAjkiSo8dDf3+kgAjkiSo+hjgF+qgAjkiSo4
					kwgO+XgAjxiSo6kDgM+dgAj2iSo/gAgA+tgAjxiSo6b9f0+dgAjkiSo4bQfy+XgAjkiSo+edf7+qgAjkiSo8i9gJ+kgAjkiSo4lAgP+UgAjkiSo8i9gJ+kgA
					jkiRosejf9+wgAjmiOnLdNgG/DgAjpiJlafSgF/hgAjriHkogAgA/q]],
				Tail2 = [[
					gAjeizj7gAgA/wgCjZi1kuhcf5/ngJjRi2mPmtgE+pgEjMi4nXk7gS+vf4jMi3nbcIfr+3fyjMi2nIWmfW9uf4jMi3nRYufi+SgEjLi4nfg7gI/FgNjMi2nN
					oUgn+CgLjZi3nKo3gm94gAjei4neiJgG/Cf1jZi3nUZlfh+efzjMi2nHWbfW9rf8jLi4nZbCft+ugIjMi3nbj4gV+3gOjMi2nIpagq9ugIjMi3nRnSge+Sf8
					jMi4nQfJf6/Jf4jSi2l8bEgD/Cf+jai0kkeagJ/ogAjeizj7gAgA/w]],
				Tail3 = [[
					gAjTjfjggAgA/zgGjMjgkHhgf6/sgbjAjclHpigP+GgSi4jel5pagm9/fti3jfmPdZfk/QfZi6jXlqToe487fki4jblsT/fH9FgHi3jgmQeOgF/Ugki5jZl3
					qEg/9ygjjGjZljtYhE8ggGjJjgmIl+gT+0fjjFjcmGZTfQ+rfZi6jXliSge38cfui3jel6WhfY99gTi3jfmPingc/Qgni6jXlqsYhI87gci4jblssBg59Ff6
					i4jhmFhqf7/XfrjCjelBaAf7/Bf6jNjgj/digM/pgAjTjfjggAgA/z]],
				Tail4 = [[
					gAjJkLgAgAgA//gLjAkMgchGgF/+g1iyj/hLrLhl96griokBhkt1iX8tfmimkIiBgqfl/6e5isj0hnSwdG87fEirj5haQDdD7igCilkKh8aDfX/Xg/irj6hz
					piiT+ZhFi6jzhXwgjO7LgWi5kHhxqiho+HfQi1kCh9bRek/ie3itjyhcQacy7tfUiokBhkSEdm8pgaimkIiBfWgb/6hHisj0hntQi687g8irj5hav9i97if+
					inkKh0lkgk/cfai0kGhHaPfM/cfzjCkLgWc2f5/1gAjJkLgAgAgA//]],
				Tail5 = [[
					gAjJk5ZPgAgA/RgOi/k5ZfgRgI/UhTixkiaUq6kN9OhPinkda5wfmp6Gfnigk1ailDhG/GeWiskSasUpaS83edirkQa+OdYj5Mfxigk0apVycj9ohZiokfak
					mfj0+nhui7kJa9w/nj5jgzi1kqayuLlY7sfDiwktagfOek/eeQiukJa2RGZC68exinkda6PYZR6AgZigk1aia9e6/GhqiskSasrXlu83hjirkQa+xjnd5MgO
					ijk1aipljK93fKiykxZ9b7eS/GfqjBk4ZeckfI/HgAjJk5ZPgAgA/R]],
				["UpperLegB.L"] = [[
					eBiqhT7WekgAwieBishS65epgBxReBiyhO5de1gGzVeBi3hM3bfEgO1xeBi3hM3SfFgO17eBi3hM3SfFgO17eBi3hM3SfFgO17eBi3hM3SfFgO17eBi3hM3S
					fFgO17eBjFhM3SfFgO17eBjKhM3SfFgO17eBjFhM3SfFgO17eBi3hM3SfFgO17eBi3hM3SfFgO17eBi3hM3SfFgO17eBi3hM3SfFgO17eBi3hM3SfFgO17eB
					i2hM4DfAgL1EeBixhP53eygFyyeBishS6/eogBxHeBiqhT7WekgAwi]],
				["LowerLegB.L"] = [[
					d+hvg0wfgAgA7ad+hwg2w3f/f+7Md/hyg8ydf7f46Id/h1hH0+fzfx4Jd/h1hI1Kfyfx3/d/h1hI1Kfyfx3/d/h1hI1Kfyfx3/d/h1hI1Kfyfx3/d/h1hI1K
					fyfx3/d/iChI1Kfyfx3/d/iIhI1Kfyfx3/d/iChI1Kfyfx3/d/h1hI1Kfyfx3/d/h1hI1Kfyfx3/d/h1hI1Kfyfx3/d/h1hI1Kfyfx3/d/h1hI1Kfyfx3/d/
					h0hD0Nf1fz4zd/hyg6x+f8f66ed+hwg2wxgAf+7Pd+hvg0wfgAgA7a]],
				["FootB.L"] = [[
					d+g+hP/ZgAgAmJd+g+hP/Zf+gAmJd+g+hP/Zf3gCmJd+g+hP/ZfsgEmId+g+hP/ZfsgEmJd+g+hP/ZfsgEmJd+g+hP/ZfsgEmJd+g+hP/ZfsgEmJd+g+hP/Z
					fsgEmJd+hLhP/ZfsgEmJd+hQhP/ZfsgEmJd+hLhP/ZfsgEmJd+g+hP/ZfsgEmJd+g+hP/ZfsgEmJd+g+hP/ZfsgEmJd+g+hP/ZfsgEmJd+g+hP/ZfsgEmJd+
					g+hP/ZfwgDmId+g+hP/Zf5gBmJd+g+hP/Zf/gAmJd+g+hP/ZgAgAmJ]],
				["UpperLegB.R"] = [[
					h/iqhT7WhcgAwih/ishS65hXf/xRh/iyhO5dhLf6zVh/i3hM3bg8fy1xh/i3hM3Sg7fy17h/i3hM3Sg7fy17h/i3hM3Sg7fy17h/i3hM3Sg7fy17h/i3hM3S
					g7fy17h/jFhM3Sg7fy17h/jKhM3Sg7fy17h/jFhM3Sg7fy17h/i3hM3Sg7fy17h/i3hM3Sg7fy17h/i3hM3Sg7fy17h/i3hM3Sg7fy17h/i3hM3Sg7fy17h/
					i2hM4DhAf11Eh/ixhP53hOf7yyh/ishS6/hYf/xHh/iqhT7WhcgAwi]],
				["LowerLegB.R"] = [[
					iChvg0wfgAgA7aiChwg2w3gBgC7MiBhyg8ydgFgI6IiBh1hH0+gNgP4JiBh1hI1KgOgP3/iBh1hI1KgOgP3/iBh1hI1KgOgP3/iBh1hI1KgOgP3/iBh1hI1K
					gOgP3/iBiChI1KgOgP3/iBiIhI1KgOgP3/iBiChI1KgOgP3/iBh1hI1KgOgP3/iBh1hI1KgOgP3/iBh1hI1KgOgP3/iBh1hI1KgOgP3/iBh1hI1KgOgP3/iB
					h0hD0NgLgN4ziBhyg6x+gEgG6eiChwg2wxgAgC7PiChvg0wfgAgA7a]],
				["FootB.R"] = [[
					iCg+hP/ZgAgAmJiCg+hP/ZgCgAmJiCg+hP/ZgJf+mJiCg+hP/ZgUf8mIiCg+hP/ZgUf8mJiCg+hP/ZgUf8mJiCg+hP/ZgUf8mJiCg+hP/ZgUf8mJiCg+hP/Z
					gUf8mJiChLhP/ZgUf8mJiChQhP/ZgUf8mJiChLhP/ZgUf8mJiCg+hP/ZgUf8mJiCg+hP/ZgUf8mJiCg+hP/ZgUf8mJiCg+hP/ZgUf8mJiCg+hP/ZgUf8mJiC
					g+hP/ZgQf9mIiCg+hP/ZgHf/mJiCg+hP/ZgBgAmJiCg+hP/ZgAgAmJ]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAj6hTAPgAgAjtgAj6hkAWgAgAkmgAj6hyAegAgAlXgAj6hwAdgAgAlQgAj6hrAagAgAk+gAj6hlAYf6e3kogAj6hfAWf2ebkWgAj6hdATf7fKkNgAj6hcAS
					gAgAkJgAj8hYARf1gKj9gAkQhUAWdcgTjwgAk0hTBCY8g1jngAlVhTCwTnhdjagAlphTFNO8h/jIgAlyhTHUMAiVi4gAl0hTIBLLibizgAlyhTHaL5iWi4gA
					lwhTG4MkiRi7gAlyhTHWL+iVi4gAl0hTIALMibizgAl0hTICLKicizgAl0hTICLKicizgAl0hTICLKicizgAl0hTICLKicizgAl0hTICLKiciz]],
				Spine1 = [[
					gAkEgpAPgAgAjtgAkGg6AWgAgAkmgAkIhJAegAgAlXgAkIhHAdgAgAlQgAkHhBAagAgAk+gDkHg7AYf6e3kogEkGg1AWf2ebkWgCkFgzATf7fKkNgAkFgxAS
					gAgAkJgAkGguARf1gKj9f+kagqAWdbgNjwf8k9gpBCY6gkjrf5lcgpCyTjhBjmf3ltgpFQO4hcjff2l0gpHZL8hujYf2l2gpIGLHhzjWf2l0gpHeL1hvjYf2
					lzgpG8MghqjZf2l0gpHaL6hujYf2l2gpIELIhzjWf2l2gpIGLGhzjWf2l2gpIGLGhzjWf2l2gpIGLGhzjWf2l2gpIGLGhzjWf2l2gpIGLGhzjW]],
				Spine2 = [[
					gAkOf+/8gAgAhmgAkTgQ//gAgAgtgAkXgg//gAgAf7gAkWge//gAgAgCgAkVgY//gAgAgUgGkTgR/9f6hJgqgIkRgM/8f5hlg9gEkRgJ/9f8g2hGgAkQgH/+
					gAgAhKf/kRgD/9gMf5hWf9kkgA/2ikgUhhf4lGf+/JnFg3hcfylkf+9bsbhfhGfvlzf+69xFh+goftl4f/420CiPgPfsl5f/4J03iUgHftl4f/4w0IiQgOft
					l3f/5SzeiMgUftl4f/400DiPgPfsl5f/4K02iTgHfsl5f/4I03iUgHfsl5f/4I03iUgHfsl5f/4I03iUgHfsl5f/4I03iUgHfsl5f/4I03iUgH]],
				Spine3 = [[
					gAkKfY/8gAgAhmgAkRfp//gAgAgtgAkXf5//gAgAf7gAkWf3//gAgAgCgAkUfx//gAgAgUgJkRfr/9f6hJgqgMkPfl/8f5hlg9gHkOfi/9f8g2hGgAkOfh/+
					gAgAhKf/kOfd/9gMf5hWf+kgfZ/2ikgahgf7lDfY/JnEhIhYf3ljfY9asZh7g7fzl0fY69xCiigSfxl7fY41z+i3fvfxl9fY4I0yi8fkfxl7fY4v0Ei3ftfy
					l6fY5Rzaizf2fxl7fY40z/i3fvfxl9fY4J0xi8fkfxl9fY4H0zi8fjfxl9fY4H0zi8fjfxl9fY4H0zi8fjfxl9fY4H0zi8fjfxl9fY4H0zi8fj]],
				Neck1 = [[
					gAkGexAVgAgAkcgAkPfDAogAgAmNgAkXfSA+gAgAnugAkWfQA6gAgAnggAkTfKAygAgAm9gMkQfEAqf2e3mSgQkNe/AkfyecltgJkLe7Agf4fKlcgAkLe6Ad
					gAgAlUf/kLe2AZf1gKk7f/kdeyAcdcgPkdf+lAexBGY6gmkKf8ljeyC0Tkg+j6f5l3eyFQO6hSjqf2mAeyHXL+hejgf1mCeyIELJhhjdf2mAeyHdL3hfjgf3
					l+eyG7Mihcjif2mAeyHYL8hejgf2mCeyIDLKhhjdf1mCeyIELIhhjdf1mCeyIELIhhjdf1mCeyIELIhhjdf1mCeyIELIhhjdf1mCeyIELIhhjd]],
				Neck2 = [[
					gAkZdwBLgAgAoigAkpeECAgAgArFgAk3eXC5gAgAtQgAk1eUCwgAgAs8gAkweNCbgAgAsLgQkqeGCEfqe6rNgWkleAByfjefqYgMkid8BofxfMp/gAkhd6Bk
					gAgAp0f+kfd2BYf3gMpQf9kvdyBRdigtogf4lRdwB0ZKh3n0fylwdwDXT+jHm+fsmBdwFoPbkDmCfomHdwHmMjkllUfnmJdwIQLvktlGfomIdwHrMckmlSfp
					mGdwHMNGkeldfomIdwHnMhkllTfnmJdwIPLwktlGfnmJdwIQLuktlFfnmJdwIQLuktlFfnmJdwIQLuktlFfnmJdwIQLuktlFfnmJdwIQLuktlF]],
				Neck3 = [[
					gAk1dCBLgAgAoigAlMdbCUgAgAr7gAlgdzDogAgAuwgAlddwDagAgAuWgAlWdnC8gAgAtWgTlNddCafoe7sFgblGdVCAfhegq/gOlCdQBzfwfMqegAlAdOBt
					gAgAqPf9k9dJBdf3gNpff4lLdDBRdkg3odfslodBBuZRiOnefgmBdADMUKjnmRfWmLdAFWPrklk7fSmMdAHOM0lDj6fQmMdAH2MAlKjnfRmMdAHTMtlEj4fS
					mMdAG1NXk+kHfSmMdAHPMylEj6fRmMdAH1MBlKjnfQmMdAH3L/lKjmfQmMdAH3L/lKjmfQmMdAH3L/lKjmfQmMdAH3L/lKjmfQmMdAH3L/lKjm]],
				Head = [[
					gAljb1/fgAgAlmgAmKca//gAgAglgAmpdA/wgAgAcKgAmlc6/1gBgAczgAmacs/8gAgAeYgYmMcd/8efgogRgimAcR/2d1g+h3gSl6cK/2e0gjiugAl3cH/1
					gAgAjHf8lwb//tgZf5kOfwl4b2/XingClufYmOby+anHgVm5fAmabw8bsThAn9ezmVbu5vwqh/o5eumMbt3hzUi2pceumJbt2z0DjJpmeumLbt3bzai5peev
					mObt3+y0irpWeumMbt3fzVi3pdeumJbt200CjIpmeumJbt2y0DjJpmeumJbt2y0DjJpmeumJbt2y0DjJpmeumJbt2y0DjJpmeumJbt2y0DjJpm]],
				Jaw = [[
					gAj/bw/8gAgAhzgAksb3//gAgAfbgAlZcE/4gAgAdWgAlScB/5gBgAdpgAlCb8/8gAgAeZgRkvb4/8eggrfQgXkgb1/5d4hGf+gMkYbz/9e3gogbgAkVby//
					gAgAgnf+kMbx/9gZf3hNgAkVby/ximfyingDkzb1+2nHfykkgIlUb58usVggmxgMlqb950wrh1oqgPl2b/3ZzRjHpwgPl6cA2mz/jiqDgPl3cA3SzXjKpzgO
					l0b/35yyi1pjgPl2b/3XzTjHpxgPl6cA2nz+jiqCgPl6cA2lz/jjqDgPl6cA2lz/jjqDgPl6cA2lz/jjqDgPl6cA2lz/jjqDgPl6cA2lz/jjqD]],
				["UpperLegF.L"] = [[
					d+iqe0x+fDgA6cd+izfBzbfEf95Zd+i7fM0pfEf64bd+i6fK0dfEf64kd+i3fG0CfEf747eKi0e4zfeHgm5TePixexzAdwg25neHive1yzeXgd51d+iue6yt
					fDf+58d+ise5yXfRgF6MeOitezxpgPiV6lexi1euwmiImg6ffkjFepvLkFrl5WgWjbelttlhwG3Yg2jveisqmSy+1ig/j2ehsWmfzy07g3jweisnmUzE1egw
					jreis3mJya17g3jveispmSy/1hg/j2ehsWmezx08g/j2ehsVmfzy06g/j2ehsVmfzy06g/j2ehsVmfzy06g/j2ehsVmfzy06g/j2ehsVmfzy06]],
				["LowerLegF.L"] = [[
					d7hvfM7agAgAwfd7h2fR8TgAgAu7d7h9fW8/gAgAtid7h8fV85gAgAtvd7h5fU8pgAgAuPeGh3fI8Ufag/u1eKh0fD8BfMhXvWeDhzfI76fkguvmd7hyfO73
					gAgAvud8hxfO7qgOgAwEeUhzfM7NiDhmwofGiAfL6RljkgwygHicfK4mpkoHwKhBi+fJ2es8rYu4hljcfI0xu/tgtnhujmfI0OvkuGtLhmjdfI0svEtktkhe
					jWfI1HumtGt5hljcfI0wvAthtmhujmfI0PvjuFtMhujmfI0NvkuHtLhujmfI0NvkuHtLhujmfI0NvkuHtLhujmfI0NvkuHtLhujmfI0NvkuHtL]],
				["FootF.L"] = [[
					d7g+ex/dgAgAl0d7hIex/vgAgAkDd7hSey/5gAgAifd7hQey/4gAgAiud7hNey/0gAgAjSeIhJeo/ufzhIj9eMhFel/ofuhkkieEhDer/nf2g1k0d7hDex/n
					gAgAk8d8hAez/igNf7lWedhCey/UiegymBfdhTe0+fmyiRmgguh5e28trzkPmghyiqe36RwHmImCiajTe44OyxnYldikjhe53jzhnvlQibjVe44Jy3nblciS
					jLe44pyRnIlmiajUe44NyznZldijjhe53kzgnvlQikjhe53jzinwlPikjhe53jzinwlPikjhe53jzinwlPikjhe53jzinwlPikjhe53jzinwlP]],
				["UpperLegF.R"] = [[
					iCiqe0x+g9gA6ciCizfBzbg8gD5ZiCi7fM0pg8gG4biCi6fK0dg9gG4kiCi3fG0Cg8gF47iNizfLzfgAgt5XiRiwfLzAfpg75tiKivfCyzgQgg54iCiue6yt
					g9gC58iBive3yXhKgG6LiOjWe4xoiIiT6gibkle7wkkEmZ6TiYl/fAvHmHrW5FiDnEfFtkntvv3EhrnqfIsdomyi1Phjn0fJsHo1zV0ohqnrfIsaooyo1Khx
					njfIsrobyA1ohrnqfIscomyk1OhjnzfJsHo0zU0ohjn0fJsHo1zV0nhjn0fJsHo1zV0nhjn0fJsHo1zV0nhjn0fJsHo1zV0nhjn0fJsHo1zV0n]],
				["LowerLegF.R"] = [[
					iFhvfM7agAgAwfiFh2fR8TgAgAu7iFh9fW8/gAgAtiiFh8fV85gAgAtviFh5fU8pgAgAuPiOh2fb8Ufag/u1iShzfd8BfMhXvWiMhzfW76fkguvmiFhyfO73
					gAgAvuiFh0fM7qgOgAwEiaidfQ7RiDhlwii1jzfW6clmkdwhjAlZfe44ptn8vuizmsfm22tNrEuUiendfr1KvZtDs/iWnqft0ov/tnsiidnefr1GvdtHs7ij
					nUfq1hu+sqtRiendfr1JvatEs+iXnqft0ov/tmsjiWnqft0nwAtnsiiWnqft0nwAtnsiiWnqft0nwAtnsiiWnqft0nwAtnsiiWnqft0nwAtnsi]],
				["FootF.R"] = [[
					iFg+ex/dgAgAl0iFhIex/vgAgAkDiFhSey/5gAgAifiFhQey/4gAgAiuiFhNey/0gAgAjSiQhIe7/ufzhIj9iVhEe//ofuhkkiiNhDe5/nf2g1k0iFhDex/n
					gAgAk8iGhEew/igNf7lVijhse2/Viegxl6jMjGe++jmziNmMjmk3fI80r4kCl/jkmZfS6awQlulYjSnVfY4Yy/m0kvjLnlfa3tzwnIkgjSnXfZ4SzFm2ktjX
					nJfX4zydmmk4jSnVfY4XzAm0kujLnlfa3uzvnHkgjLnmfa3tzxnIkgjLnmfa3tzxnIkgjLnmfa3tzxnIkgjLnmfa3tzxnIkgjLnmfa3tzxnIkg]],
				Oiseau = [[
					fMmeirgAABgAgAfMmZjEgCADfHhLfMmUjagPAYeWkefMmVjXgdBaehpLfMmXjPgkDYe3uOfGmZjBghFTfOxlfEmbi3gaHNfg0MfImbi2gWIxfo1+fMmci3gU
					JZfs2nfLmeiygUJef92texmpish4JVhx2aeGmviplHJmk81sdgmcinpFKlok0NdQl0imspMJroyRdSlTilu8NlthwrdUlJikvlOEuCwKdSlRikvBNptlwndR
					lailufNRtKxAdSlSilu9NmtiwqdUlJikvlODuBwLdUlIikvmOEuDwKdUlIikvmOEuDwKdUlIikvmOEuDwKdUlIikvmOEuDwKdUlIikvmOEuDwK]],
				Arbre1 = [[
					ginChgOmaegA6QginBh8PWahfy6wgim/iUQEapfd7Ngim/iQQDa2fM7OginAiIP6bCe67LghnAh/PwaReB64ghnBh3PnaCdm6tghnBhxPfard76yginBhuPZ
					bYeZ65ggnDhoPQbYeq60gBnahiPgZ7gj6ufHn2hhQiXfkS6VeHn3hhSXUvou5LdZnahhUgShsq3bdDm6hiWMRNvL12c/mvhiWuQ3v51VdDm5hiWQRKvR1ydH
					nBhiV2Rdus2MdDm6hiWNRNvN11c/mvhiWtQ3v41Wc/mvhiWuQ3v61Vc/mvhiWuQ3v61Vc/mvhiWuQ3v61Vc/mvhiWuQ3v61Vc/mvhiWuQ3v61V]],
				Arbre2 = [[
					fdnOgJOmaegA6QfdnRgmPUacf66ufdnUg/P7aVf77EfdnUg7PxaMgL68fdnTgyPeaAge6tfjnSglPGY9gH6OflnRgbOzYggG55fhnQgYOrZCgo59fdnQgXOq
					ZthH6GfanQgROiZuhY6Be8nbgLO6YPjO5seGnkgJQLVvmx47dRnQgISSS9q73WcymkgIUtQvuh1Qcql+gIWlPdwxzfcqlxgHXLPIxZy6cql8gIWqPaw2zacr
					mGgIWNPswVz3cql9gIWmPdwyzecqlygHXKPIxYy7cqlxgHXLPHxay6cqlxgHXLPHxay6cqlxgHXLPHxay6cqlxgHXLPHxay6cqlxgHXLPHxay6]],
				Tail1 = [[
					gAjriHkogAgA/qgAjoiXlggAgA/ggAjlikmRgAgA/XgAjmiimKgBgA/ZgAjnidl5gAgA/cf8joiXlieHgO/cf7jpiSlQdZgV/cf9jpiQlIemgM/jgAjpiPlE
					gAgA/lgBjriLk4gRgK/ngCkAiIksggii/igHkmiHkhhZm/+3gLlLiHkKicsQ9KgOljiHjnjWw36vgPlviHjIj5zx4pgPlyiHi+kD0l39gPlviHjHj6z44kgP
					lsiHjPjyzN5GgPlviHjIj5zy4ogPlyiHi/kD0k3+gPlyiHi+kD0m39gPlyiHi+kD0m39gPlyiHi+kD0m39gPlyiHi+kD0m39gPlyiHi+kD0m39]],
				Tail2 = [[
					gAjeizj7gAgA/wgAjYjBkzgAgA/ogAjUjOllgAgA/ggAjUjMldgBgA/hgAjWjIlMgAgA/kf3jYjCk1dWgQ/gf0jai8kicVgY/df5jbi7kaeCgN/ngAjbi6kX
					gAgA/sgBjei3kLgYgJ/tgFjzi0kAgkii/ogNkaizj1hmm++8gWlCiyjaizsO9Pgblfiyivj0wz60gdlviyiIkbzs4vgdlziyh7km0g4DgdlviyiGkdzy4pgd
					lsiyiQkUzI5LgdlviyiHkczt4tgdlziyh7km0f4Egdlziyh7km0g4Cgdlziyh7km0g4Cgdlziyh7km0g4Cgdlziyh7km0g4Cgdlziyh7km0g4C]],
				Tail3 = [[
					gAjTjfjggAgA/zgAjLjtkYgAgA/sgAjEj5lKgAgA/kgAjFj3lDgBgA/lgAjHjzkxgAgA/ofwjKjskaclgS/gfqjNjnkGbSgb/Xf0jOjmj/degP/pgAjPjmj8
					gAgA/vgDjSjjjwgegJ/xgHjojgjngqih/rgUkRjfjbh2m8+/ghk9jei7jRsL9QgplejeiFkcwu61grlyjehVlJzk4vgrl4jehFlV0Y4DgrlzjehTlLzr4qgq
					lujehflBzB5LgrlyjehUlJzm4ugrl3jehFlV0W4Egrl4jehFlV0Y4Dgrl4jehFlV0Y4Dgrl4jehFlV0Y4Dgrl4jehFlV0Y4Dgrl4jehFlV0Y4D]],
				Tail4 = [[
					gAjJkLgAgAgA//gAi+kZg5gAgA/+gAi2kkhrgAgA/8gAi3kihkgCgA/9gAi6kehSgAgA/9fmi+kXg7b0f4/tfdjBkRgpaPf5/dftjDkSggc6f9/1gAjEkSgc
					gAgA//gEjHkPgQgkgM//gKjekMgJghil/4gbkIkLgChcnG/Kgtk5kKfmijsc9Xg2lgkJe2jdxD60g4l4kJeKj9z74pg4l/kId7kG0v37g4l5kJeIj+0C4jg4
					lzkJeTj3zY5Gg4l4kJeKj+z84og4l/kId7kF0t38g4l/kId7kG0v37g4l/kId7kG0v37g4l/kId7kG0v37g4l/kId7kG0v37g4l/kId7kG0v37]],
				Tail5 = [[
					gAjJk5ZPgAgA/RgAi8lGaHgAgA/cgAixlRa4gAgA/lgAizlPaxgCgB/jgAi2lMafgAgA/gfbi8lDaObNe0/EfMjAk7aBZYeb+rfkjBk+ZxccfL/KgAjCk/Zr
					gAgA/XgGjHk8ZfgngV/UgMjek5ZbgFiq/MgfkJk4ZdgRnU+cgzk8k3ZUgfsz8ig9lok2Y8goxg50g+mDk0Ykgp0a3eg9mLk0Ycgo1N2tg+mEk0Yjgp0g3Yg+
					l+k1Ypgpz33+g+mDk0Ykgp0b3dg9mLk0Ycgo1M2ug9mLk0Ycgo1O2sg9mLk0Ycgo1O2sg9mLk0Ycgo1O2sg9mLk0Ycgo1O2sg9mLk0Ycgo1O2s]],
				["UpperLegB.L"] = [[
					eBiqhT7WekgAwieBiqhf8Oekf7u/eBiqhq87ekf2tmeBiqho80elf3tzeBiqhl8lekf5uTeCiqhX8Pd+g5u2eCiqhQ79dwhTvVeCiqhT72eIgrvoeBiqhZ7y
					ekf9vyeCiqhY7oezf9wFeQishU7ugzhRv6exi0hT7vk2jTu0fijDhT6+p4lYtAgTjUhT5Yuem2rFg0jmhT30xenkprg+jshT3RyVnvpQg1jmhT3wxlnmpogu
					jihT4Kw5ncp9g1jmhT3zxfnlprg+jshT3SyUnvpRg+jshT3RyWnvpQg+jshT3RyWnvpQg+jshT3RyWnvpQg+jshT3RyWnvpQg+jshT3RyWnvpQ]],
				["LowerLegB.L"] = [[
					d+hvg0wfgAgA7ad+hzg6x/gAgA6dd+h3g/zQgAgA5jd+h3g/zEgAgA5sd+h1g9yogAgA6AeBh0gxyDfBgm6ZeChygsxjepg06seAhxgxxVfSgc64d+hxg3xP
					gAgA69eAhwg3w7gOgG7JeWhzgzw2hXiM7EfGiBgvw8j3l+6MgFicgrwonDqT4Ug+i9gnvxqCt815hijZglu3sDwJz7hrjigkuisowwzShjjagku0sHwOz2hb
					jTglvErqvu0VhijZglu2sEwKz6hrjigkujsnwvzThrjigkuisowwzShrjigkuisowwzShrjigkuisowwzShrjigkuisowwzShrjigkuisowwzS]],
				["FootB.L"] = [[
					d+g+hP/ZgAgAmJd+g/hP/sgAgAkYd+hBhP/3gAgAi0d+hBhP/2gAgAjDd+hAhP/ygAgAjnd/hAhF/rfyhIkSeAg/hC/lfthjk3d/g/hI/kf2g1lJd+g+hP/j
					gAgAlReBg+hQ/fgOf5lneehChL/YiigelofchThG+ynBhJk+grh4g/9MsYhrj8hvimg560xFh5i+iWjOg14v0Dh4iUigjbgz4D05h2iIiXjPg04q0Kh4iTiP
					jFg15Mzfh5iciWjOg04u0Fh4iUigjagz4E04h2iJigjbgz4D06h2iIigjbgz4D06h2iIigjbgz4D06h2iIigjbgz4D06h2iIigjbgz4D06h2iI]],
				["UpperLegB.R"] = [[
					h/iqhT7WhcgAwih/iqhf8OhcgFu/h/iqhq87hcgKtmh/iqho80hcgJtzh/iqhl8lhcgHuTh+iphp8Pg2hEu9h+iphp79gohaveh+iqhh72hAgxvth/iqhZ7y
					hcgDvyh/ithW7mhrgAwFiKjVhU7ZjqhVwDiVkihT64nnjhvMiSl4hT5gsYl3tnh+m6hT3bwnnrr1hpndhT1kzUorqehhnmhT090Go8qDhonehT1fzbotqaht
					nXhT19yzogqvhpndhT1jzWosqdhhnmhT0+0Fo7qDhhnnhT080Go8qChhnnhT080Go8qChhnnhT080Go8qChhnnhT080Go8qChhnnhT080Go8qC]],
				["LowerLegB.R"] = [[
					iChvg0wfgAgA7aiChzg6x/gAgA6diCh3g/zQgAgA5jiCh3g/zEgAgA5siCh1g9yogAgA6AiEhzhEyDfBgm6ZiEhxhFxjepg06siDhxg/xVfSgc64iChxg3xP
					gAgA69iDhzg1w7gOgG7JiWidgzwwhWiN7IiwjxgxwrjzmB6Wi7lVguwMm3qb4mivmmgrvOpsuM2SibnWgpuQrjwg0XiUnigot7sGxJzvianXgpuOrowl0Sig
					nNgpuerMwE0wibnWgpuQrkwh0WiUnigot8sFxIzwiUnjgot7sGxJzuiUnjgot7sGxJzuiUnjgot7sGxJzuiUnjgot7sGxJzuiUnjgot7sGxJzu]],
				["FootB.R"] = [[
					iCg+hP/ZgAgAmJiCg/hP/sgAgAkYiChBhP/3gAgAi0iChBhP/2gAgAjDiChAhP/ygAgAjniCg/hY/rfyhIkSiCg+hc/lfthjk3iCg+hW/kf2g1lJiCg+hP/j
					gAgAlRiEhBhN/fgOf5loiehrhN/XiigelvjGjDhI+vnBhNlSjgkxhE9HsWh5kdjemQg/6vxBiUjojPnLg84qz/iejDjInbg73+01igi5jOnNg84l0GifjCjT
					nAg95GzbidjLjOnLg84p0BiejDjInbg73/0zigi5jInbg73+01igi4jInbg73+01igi4jInbg73+01igi4jInbg73+01igi4jInbg73+01igi4]],
			},
		},
	},
}
