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
					gAiYgiDYgAgAuRgAiZgiDdgDgFubgAiagiDigGgJukgAiagiDlgIgOurgAibgiDogLgSuwgAibgiDogNgWuxgAibgiDogPgZuvgAiagiDlgQgburgAiagiDi
					gRgdukgAiZgiDdgSgeubgAiagiDdgQgbubgAidgiDqgMgUu1gAiggiECgGgMvggAijgiEcgCgEwOgAilgiEwgAgAwwgAilgiE4gAgAw8gAilgiE5gAgAw+gA
					imgiE8gAgAxCgAimgiFAgAgAxJgAingiFFgAgAxSgAiogiFLgAgAxbgAipgiFRgAgAxkgAiogiFQgAf/xjgAingiE7f+f9xBgAimgiEef9f6wRgAimgiEKf8
					f5vvgAimgiEFf8f4vngAimgiEDf7f4vigAilgiD/f7f3vbgAikgiD6f7f3vSgAijgiD1f7f3vJgAiigiDwf7f3u/gAiigiDrf7f3u2gAifgiDjf5f1ungAib
					giDXf2fwuPgAiXgiDMf0ftt5gAiVgiDJf1futzgAiWgiDLf3fyt3gAiWgiDPf6f3t+gAiXgiDTf9f7uH]],
				Spine = [[
					gAjEgAEggAgAwVgAjGgBErgDgFwogAjHgBE1gGgJw5gAjIgCE+gJgNxGf/jIgCFDgMgRxOf/jIgCFFgPgVxRf/jIgCFDgRgXxOf/jIgCE+gTgaxGf/jHgBE2
					gUgcw4f/jGgBErgVgdwof/jGgBEmgSgawgf/jKgCE3gNgTw7gAjPgEFagHgLxxgAjUgHGFgDgEyvgAjXgJGogAgAzegAjXgJG3gAgAzxgAjXgKG5gAgAz0gA
					jYgKG/gAgAz8gAjZgKHJgAgA0IgAjagLHWgAgA0YgAjbgLHkgAgA0pgAjcgMHygAgA05gAjbgMH2f/f/0+gAjZgKHQf+f90RgAjXgHGYf9f7zJgAjWgFFvf8
					f6yRgAjVgFFmf7f5yDgAjVgFFgf7f4x6gAjUgEFXf6f4xtgAjTgEFMf6f3xcgAjSgDFAf6f3xKgAjQgDE1f6f3w3gAjPgCEqf6f4wmgAjMgBEdf5f1wRgBjH
					gAENf1fxv1gBjCf/EBfzfuvfgBjAf/D+f0fvvagAjBf/EDf3fzvigAjCgAELf6f3vwgAjDgAEUf9f7wC]],
				Neck1 = [[
					gAjxfoFigcgkx8gAjzfpFqgggqyIf/j1frFygjgvyTf/j2fsF4gmgzybf/j3fsF8gog1yhf/j3ftF9gpg2yjf/j3fsF8gpg2yhf+j2fsF4gog0ybf+j1frFy
					gmgxyTf+jzfpFqgjgtyIf+j0fpFogcgjyFf/j4fsGBgRgWyqf/j/fxG1gIgKzvgAkFf3H1gCgD08gAkIf7IpgAgA13gAkJf9JCgAgA2QgAkJf+JEgAgA2TgA
					kKf+JJgAgA2XgAkLgAJQgAgA2fgAkMgBJZgAgA2ogAkNgDJkgAgA2zgAkPgEJugAgA29gAkOgEJuf9f729gAkLgAIzf5fz2BgAkIf4Hdf1fv0hgAkGfzGgf0
					fvzUgAkFfyGUf0fwzDgAkEfxGQf1fwy+gAkDfwGJf1fxy1gBkCfvGCf2fyyqgBkAftF5f3f0yegBj+fsFxf4f2ySgBj9frFpf6f4yHgBj5fpFgf6f4x6gBjz
					fmFUf6f5xogBjufkFKf+f+xZgBjsfjFIgEgGxWgBjtfkFMgLgOxcgBjuflFSgRgWxlgAjwfmFZgXgdxw]],
				Neck2 = [[
					f/kUfaF0g3hIyTf/kWfcF4g8hPyZf/kYfeF8hAhVyff/kZffGAhChYyjf+kafgGChDhZylf+kafgGChChYymf+kafgGBhAhVymf+kZffF/g8hPyjf+kYfeF8
					g3hHyff+kWfcF4gwg+yaf+kXfbF4gkgtybf/kbfgGagVgazLf/kjfoHdgIgK0ggAkqfxIvgCgC19gAktf5J1gAgA3EgAkuf8KXgAgA3jgAkuf9KZgAgA3lgA
					kvf+KbgAgA3ngAkwf/KfgAgA3rgAkxgBKkgAgA3vgAkzgDKpgAgA30gAk0gFKvgAgA35gAkzgGKqf8f330gAkwf+Jbfzfq2qgAktfyHqfufk0vgBkqfpGbft
					flzMgBkpfnGMfufmy4gBkofmGKfvfoy1gBknflGHfwfqyxgBklfjGDfyftysgBkjfhF+f0fwymgBkhffF6f3f0yggBkgfdF2f6f4yagBkcfbFxf8f7yTgBkV
					fXFrgAgByLgBkQfVFmgJgNyEgBkOfUFmgVgcyCgBkPfVFogfgoyEgAkQfWFrgog0yJgAkSfYFvgwg/yO]],
				Neck3 = [[
					f/kufQGHhThsyqf+kwfTGIhZh1yqf+kyfVGIhch7yqf+kzfWGIheh+ypf9k0fXGIhdh+ypf9k1fYGIhbh6yqf9k0fXGIhWh0yqf9kzfWGHhQhqyqf9kyfVGG
					hIhdyrf9kwfTGFg+hOysf+kxfSGIgsg4yyf+k2fYGzgYgezrf/k+fjIGgJgK1PgAlFfwJsgCgB27gAlJf6LFgAgA4MgAlKf+LwgAgA4xgAlKf/LygAgA4ygA
					lLgALygAgA4ygAlMgCLygAgA4ygAlNgELygAgA4ygAlOgGLygAgA4ygAlQgJLygAgA4ygAlPgJLof6fz4qgAlMf+KEfufg3RgBlIftH3fnfY0+gBlFfhGVfm
					fazEgBlDffGEfnfdytgBlDfeGEfpffytgBlBfcGEfrfjytgBk/faGEfufoytgBk+fYGEfyftytgBk8fWGDf1fyytgBk6fUGDf6f4ytgBk2fRGDf9f9ytgBkw
					fOGDgFgIytgBkqfLGEgVgdytgBkofKGEgmgyysgAkpfLGFg0hDysgAkqfMGGhAhTyrf/ksfOGGhKhgyr]],
				Head = [[
					f+lJfIAHfJiLg5f9lLfKAJe8iXhAf9lMfMAKeyiehJf8lOfNALepihhTf8lPfOAMejihhff8lPfPAMegichqf8lPfOAMefiThzf8lOfNALehiHh7f8lMfMAK
					elh4h/f8lLfKAJerhmh/f9lLfKAIe7hIiKf+lRfRAWfUgjkbf/lafgBLfrgIoigAlhfxCyf6f/tCgAllf+EkgAgAwdgAllgEFggAgAx6gAlmgFFcgAgAx0gA
					lmgGFYgAgAxugAlngHFVgAgAxpgAlogJFUgAgAxogAlqgMFVgAgAxpgAlrgOFYgAgAxugAlqgOFNgFf2xdgBlof/DHgQfktugBlkfqA6gafWnegBlffZAIge
					fSihgBlefWAFgefUhtgBldfVAFgefXh1gBlcfTAFgdfch6gBlafRAFgbfhh7gBlYfPAFgYfnh5gBlWfNAEgVfuh0gBlUfLAEgSf1hsgBlRfIADgTf8higBlK
					fFADgVgJhXgBlEfCADgRgjhMgAlCfBADgEg/hCgAlDfCAEf1hWg7f/lFfEAFflhqg3f+lHfGAGfXh8g2]],
				Jaw = [[
					f3lceh/phMd/kEf2leek/mhbd3kOf1lgem/lhodykUf1lieo/khydwkVf0ljep/kh4dzkRf0lkeq/mh7d4kIf0lkep/oh6eBj8f1ljeo/qh1eMjuf2lien/t
					hueZjef3lhel/whkeqjPf5liek/0hQfEi3f8ltew/+gyflgyf+l9fG/1gWf7c4gAmKfj/VgFgCZkgAmQf7/EgAgAYWgAmRgF/BgAgAYMgAmRgF+ygAgAXVgA
					mSgG+KgAgAVWgAmTgI9ogAgAT8gAmUgK9xgAgAUTgAmVgM+bgAgAWJgAmWgP/BgAgAYOgBmWgO/Nf4gIY8gCmSf0/jfpgXavgDmFfO/9fegkfBgEl2e1/zfa
					gojXgElzew/ufagmkEgDlzev/wfbgjj1gDlxeu/yfegfjkgDlwes/0fhgajUgClueq/1fkgVjFgClsen/1fogOjKgClqel/0ftgIjSgBllei/zftgCjcgBlf
					ef/yfsf0jngAlYeb/wf1fbjyf+lWeb/ugGfBj8f8lXeb/tgYetkDf6lYed/rgrebkHf5laef/qg8eMkH]],
				Crest = [[
					fznke+WAhwhj+TfxnmfBWEh2hz+TfvnofFWQh6h/+VftnpfIWhh7iI+afsnqfLW3h5iN+hfsnqfNXQh0iN+ofsnqfOXphtiK+wfsnpfOYAhjiE+3ftnofNYS
					hXh7+9funmfLYehIhv/BfynnfMYugxhX/Hf3nrfpaxgUg1/jf8nogfefgBgW/9f/nXhXisf9gF/4gAm/h+l9gAgA/bgAmxiMnPgAgA/KgAmyiNm4gAgA/PgA
					m0iNmggAgA/UgAm1iOmMgAgA/YgAm3iQl/gAgA/bgAm4iTl5gAgA/cgAm4iWl8gAgA/bgAm7iUltf4f4/egCnZhrh/frfn/7gEn2gfcMfhfZ/wgGn7ffX+fe
					fV+9gGn6fUXhfgfV+1gGn5fUX4fifX+7gGn4fTYMfmfa/AgGn2fRYZfrfd/EgFn0fPYefwfi/FgEnyfMYcf1fm/FgEnwfIYRf7fs/CgEnsfEYAgBft++gEnm
					e/XqgPfu+4gDnge6XRgmf7+xgAnee4W4g9gQ+pf9nfe4WhhNgm+hf5nge5WQhbg8+af2nie7WEhnhR+V]],
				["Humerus.L"] = [[
					e/jyfrcHGcZrxue/jzftcFGlZRxxe/j1fucDGtY5x0e/j2fwcBG1Ymx3e+j3fxb/G7Ybx6e+j3fxb+G+YXx9e+j3fxb9G/YbyAe+j2fxb8G+YoyDe+j1fwb9
					G6Y7yFe+j0fub7G2ZTyJe+j0fuaxHTZgyie+j4fwYsImZSzae/j/f1WmKjY70ne/kEf6VRMjYu11e/kIf+U4NwYm2oe/kIgAVFN7Yc2ze/kJgBVGN+YY20e/
					kJgBVJOEYO23e/kKgCVNONX927e/kLgEVSOZXp2/e/kNgGVYOnXT3Ee/kOgHVgO0W83Je/kNgHWGONWc2ve/kLgCVvNXVv1kfAkIf7VMMcWR0ufAkGf2YMKN
					ag1YfAkFf0UWMCXG0OfAkEf0S/M0V8zmfAkDfzXbKNap1HfAkCfxV8KtZl0rfAkAfwSXMlWYzKfAj+fuV1KbaZ0kfAj9ftXOJxcN06fAj6frT7KoYQy/fAj0
					foYEIAaOyufAjuflbDGea1x5fAjsflcOGBa9xjfAjtfmcNGGaxxmfAjufncLGMaexpfAjwfpcJGTaGxs]],
				["Forearm.L"] = [[
					dgklfIf4VyZr9pdhkpfLgGV7ZU9ndhksfOgTWDZA9ldikvfRgcWLYw9kdikxfTgiWRYl9jdikyfUgjWWYh9jdhkxfUggWZYl9ldgkvfTgZWZYv9odgktfSgN
					WYY+9sdfkpfQf8WUZQ9udgktfSd9VDYv9Fdlk7fcaiSqX17XdslLfsXQQLXs5CdylYf+VXOOYR3Hd2legLU5NOYq2Nd2legPVGNLYi2Od3legPVHNNYe2Pd3
					lfgRVJNTYU2Sd4lhgUVNNcYD2Wd5ljgXVSNpXu2ad7llgbVXN3XY2gd8lmgfVeOGXA2md7llgdWOPAWP3Td+lmgPWYQfVB33d9ljf+WEQnVL34dilFfwYPOY
					Z24yd9lhfvVFQJV03beJlofuT+Q3Uc2tdklFfqXdOWZ14gdtlOfoWMO2Yj4BeKljfkTRQmUx2TdqlIfhV9OiZU37dgk4fgW/N4bV4Ud7lRfXU5QPWT3mdnkz
					fMZfRnYd6xdhkffBdfUIZ/8+dfkYe+fMVXay9tdfkae/fTVdan9tdgkdfCfdVjaX9sdgkhfFfqVqaC9r]],
				["WingFinger1.L"] = [[
					cfk0gho8nZlF9Ycgk3glpVnUk69Tchk6goprnRkv9Pcik8grp9nPkm9Kcik9guqJnPkf9Hcik+gvqNnSkc9Gcik9gvqKnWkc9Gcik8gvp/ndkg9Hchk6gtpv
					nlkm9Jcgk4grpXnpkp9QcelMgmnKkuiA+wcflzgeiad+dV/uclmYgVchV4Z59hcrmrgQYaPeY35UctmxgSW/MVYx2actmxgXXGMHYn2NctmygYXHMJYi2Ocv
					mzgbXJMOYX2Qcxm2gfXMMXYG2Tczm4gkXRMiXx2Xc2m7gqXVMvXZ2bc5m9gwXdNAXB2jc5m7g4Y+PPWk4kdEm9g2a1SpWa68dEm7gkbKT6W+7ycNmHgPbaTa
					aJ8cdFm8gOaATgXe7iddnJgMZcTgWn7IcRmLgGayTMaS8RcjmdgCaLTIZi79dfnHf9YxTHXJ68cemWf4ZxS6aR77cJl7f2aBS2bs8NdBmsf1a7VTZI86celx
					gFg5cudl/ucZk+gQl+kejD+9cckpgUnunklp9kcckrgWn6nklk9icdktgZoNnhlb9gcdkwgdojndlR9c]],
				["WingFinger2.L"] = [[
					dXkEhxtloYhp7rdXkEh0t9oUhe7hdYkFh2uSoQhU7YdYkFh4uioOhL7QdZkFh6utoOhF7LdZkFh7uxoQhB7IdakFh7uuoUhB7JdakFh7ujobhD7MdakFh6uT
					ojhI7SdZkFh5t8olhK7ddAkfiEr8lIfC9OcQlkiJnPdjbb+ubqm7hphBU4ZE9Kbdnug2ccOTYu5Ybdn7gbawLKY52lbdn7gfa2K8Yv2Xbdn8gga3K9Yr2Xbf
					n+gka5LCYf2YbioBgpa8LJYN2ZbmoEgwa/LTX22bbqoIg4bDLeXd2cbuoLhBbLLtXE2ibvoChfc2N7Wb4YcCn2h3fVRFWS6kcGnvhtf3SVWw7ZbGmzhWeQTA
					Yf8McGn2hSeuR6XV7WcioIhPe0RbXF7AbKm6hKd7SpY38GbenShFeDSLYs71cioJg7ebQ+X67AbXnLg5dqSAZc76a/mrg2dLSVaS8NcHnbhEggTrZI8tcHlt
					hvl8cOb6+7c7kahyq2k+gG9rdVkBhpsaoliK8IdVkChqsmokiE8DdVkChss3ohh979dWkDhvtNodhz70]],
				["WingFinger3.L"] = [[
					eIi9ijyLpzeo4ZeIi7ikygptef4LeIi6ily0ppeX39eIi5imzDpmeQ3yeIi5inzMpleK3qeIi4inzQpneG3meJi5inzMpreF3neKi5iozCpxeG3teLi6ioyz
					p5eI32eKi8ipyep7eJ4GdbjZjHwymFcl6Ub6k7jisUd3aD81apnEi1lxUrYn8aaKoZhbgpN2Yv5TaIovglepKpZF2vaIowgnetKaY82faIoxgoeuKcY32eaL
					ozgtewKfYr2eaOo3gzezKlYY2eaTo7g7e2KtYB2daYpAhFe6K2Xn2cadpEhQfBLDXM2fafoziBg5NSWd4Ga1oWiwkJQXWl57a9oJitk8RoXC6raBnPiYg8TC
					Wy7ua9oViPj0RPXp62bXooiJkxQfYP6caEnYiLhASlXb7uaVnwiDiER5YB7gbVophzkuQGZb6jaOnqh1hsRxYx7qZ3nKh0gQSTY28AbBnoiLmlTMZz74brlM
					jKrQciav9RdYjbi6vzmFdn7CeJjBigxGqCfD5GeJjAihxRqBe+4/eJi/iixhp9e440eJi+ijx1p4ew4o]],
				["Humerus.R"] = [[
					hBjyfrcH5kmVxuhAjzfscI5imwxohAj1ftcJ5fnJxjhAj2fucK5dndxdhAj3fucL5dnpxZhAj3fucM5enuxVg/j3ftcN5hnqxTg/j2ftcO5mnexRg/j1frcP
					5snLxRg/jzfqcO5xmzxSg/j0fqbC5SmnxxhAj4ftY333m3y3hAj/fzWs1unM0VhAkEf5VTzjnW1vhBkIf+U4yQna2nhBkIgAVFyFnk2zhBkJgBVGyCno20hB
					kJgBVJx8ny23hBkKgCVNxzoD27hBkLgEVSxnoX2/hBkNgGVYxZot3EhBkOgHVgxMpE3JhBkNgHWGxypj2whBkKgDVtylqO1ohBkIf8VJzcpq02hBkGf3YK1o
					lc1ihBkFf2URzzo00ZhBkEf1S5zBp8zyhBkDf0XY1llS1VhBkCfzV41FmU05hBkAfxSQzOpfzXhBj/fvVx1Xlh0yhBj9fuXL2Bju1IhBj6fsT01InnzQhCj0
					fqX73plqzJhCjufoa45HlGychCjsfocE5nlAyEhBjtfocF5olNyAhBjufpcG5olhx6hBjwfqcG5nl5x0]],
				["Forearm.R"] = [[
					igklfIf4qOmV9piekpfJgJqQmr9kidksfLgYqRm/9eickvfMgkqTnO9aibkxfNgtqVnY9WibkxfMgwqYnb9UibkxfLguqdnX9UibkvfKgoqhnN9VibksfHgd
					qmm99XickpfFgMqtmr9ZibksfIeNr3nQ8wiYk6fVavt+oR7EiTlLfpXXwKob41iNlYf9VZx5nz3BiKlegKU6yznX2MiKlegPVGy1ne2OiJlegPVHyzni2PiJ
					lfgRVJytns2SiIlhgUVNykn92WiHljgXVSyXoS2aiFllgbVXyJoo2giElmgfVex6pA2miFllgdWNw/pw3UiDlmgQWWvcq837iDljf/WAvQqw3+iflFfzYMxc
					mG46iElhfxU/vqqG3jh4lofwT3u7rd22idlFftXZxamF4riVlOfrWHw6nX4Mh3lkfnTJvLrH2diXlIflV4xOmm4Gihk4fjW8x4km4giHlRfaUwvdpl3yick0
					fRZUt5ne7BijkgfIdVrPmC9OikkZfEfEqClS95ijkafEfMqFlc93iikdfFfYqJlr9zihkhfGfnqLl/9u]],
				["WingFinger1.R"] = [[
					jhk0gho8Yna79Yjhk3gipTY2bC9Wjgk5gjpoZDbJ9Tjfk7gkp4ZObP9Rjfk9glqCZWbS9Qjek9gkqFZbbS9Qjfk9gjqBZdbP9Sjfk7ghp1ZcbJ9Ujgk5gepk
					ZXbB9Yjhk3gcpLZWa+9fjjlLgYnFcOdt+4jhlzgUieiwil/rjbmYgPcmqgmK9YjVmrgOYcwpnM5PjTmxgSW/zrnP2ajTmxgXXGz5nZ2NjTmygYXHz3ne2OjR
					mzgbXJzynp2QjPm2gfXMzpn62TjNm4gkXRzeoP2XjKm7gqXVzRon2bjHm9gwXdzAo/2jjHm7g5Y9wvpb4li8m9g3aztRpl6/i8m7gmbHr8pA73jzmHgTbXsZ
					l18ii8m8gRZ8sRoe7piknJgPZXsPpW7PjvmLgLaushlq8ZjemdgHaGsmmb8FiinHgAYqsmoz7FjjmWf9Zts0ls8Dj3l7f7Z9s4kR8Vi/msf6a1qWm29Cjjly
					gNg1itif/xjnk/gbmDa4dK+3jkkqgen3X3al9bjkksgeoBYAao9bjjkugeoRYLat9bjikxgfolYZaz9a]],
				["WingFinger2.R"] = [[
					ipkEhxtlXoeX7riqkEhyt8X2ed7kiqkEhzuQYCeh7eiqkFhzuhYNel7YirkFhzurYVem7VirkFhzuuYael7VirkFhyurYcei7XiskFhwugYaed7ciskEhvuP
					YVeW7jitkEhtt3YVeT7vjHkeh4r9bwgi9Xj1ljh+nWjKkY+qkYm7hihHrgm79Bkjnug0cex1nU5Skjn7gbaw03nH2lkjn7gfa21EnR2Xkjn8gga31DnV2Xkh
					n+gka50+nh2YkeoBgpa803nz2ZkaoEgwa/0toK2bkWoIg4bD0ioj2ckSoLhBbL0To82ikRoBhfc1yEpl4Zj+n2h5fTu1pu6nj5nvhwf0thpP7fk5mzhaeMsy
					ng8Sj5n2hWept3oq7ejeoIhTevuVo77Jk1m6hRd3tFnI8PkhnShLd+tinT7+jdoJhAeVuwoF7KkonLg/dmttmj8DlAmrg9dHtZlt8Vj4nbhLgar+m582j1lt
					h4l3jOkR+/jBkbh6q2aagO9kiokChvseW5eK79iokChvspXBeM77ipkDhws5XMeO73ipkDhwtOXaeS7y]],
				["WingFinger3.R"] = [[
					h4i9ijyLWNhY4Zh5i7ijyhWbha4Oh7i6ijy0Wnhb4Dh9i5iizEWxhc37h+i4iizOW5hb32h+i4ihzRW9hZ31h/i4ihzOW+hW34h/i5igzEW8hS4Ah+i6igy1
					W3hM4Kh/i8igyfW3hK4bivjYi8w3ati16gkPk6jWscizlp8ylbnEisl3rsnV8Ql2oZhXgryRnR5Ol4ovglep1Ym82ul4owgnet1mnE2fl4oxgoeu1knJ2el1
					ozgtew1hnV2elyo3gzez1bno2elto7g7e21Tn/2dlopAhFe61KoZ2cljpEhQfB09o02flhoyiCg4ytpj4HlKoWiykIvjpb5/lCoJixk5uNpA6xl9nPieg4sx
					pP71lBoViVjwuioZ6+knooiOksvRn06ml6nYiSg6tJom72lpnxiKh+t1oB7pkpoqh5kpvomo6tlwnqh9hmt9nR70mHnKh8gLtbnL8Ik8npiTmgsemT8CkOlN
					jUrJi9lh9UihjcjBvwZYi065hxjBilxGVghX44hzjAilxRVohW40h0i/ikxhVzhW4th2i+ikx1WAhX4k]],
				Tail1 = [[
					gAiYgiihgAgA/5gAiZgiisgRf9/4gAiagii2ghf7/3gAiagii+gwf5/2gAibgijDg+f3/1gAibgijFhLf1/0gAibgijDhWfz/0gAiagii+hefy/0gAiagii2
					hlfw/0gAiZgiishofv/1gAiagiithmfw/1gAidgijJhdfy/zgAiggij6hRf2/ugAijgikvhEf5/ngAilgilVg6f8/igAilgilkgyf8/fgAilgilmgqf9/fgA
					imgilrggf+/egAimgilzgWf//dgAingil8gLf//bgAiogimHgAgA/ZgAipgimSf1gB/XgAiogimQfpgB/XgAingilpfcgC/fgAimgikyfQgF/ngAimgikLfG
					gH/tgAimgikBe+gI/ugAimgij8e3gJ/ugAilgij0eygK/vgAikgijqewgL/wgAijgijfevgL/xgAiigijUewgL/ygAiigijKezgL/zgAifgii5e0gM/1gAib
					giiee0gN/3gAiXgiiHe4gN/5gAiVgih/fCgL/6gAiWgiiEfQgJ/6gAiWgiiMffgG/6gAiXgiiWfvgD/5]],
				Fire1 = [[
					gAiQhpZ5iHgO/VgBiQhpYchkgI/DgCiQhpXngggH+3gDiQhpXvfcgH+5gEiQhpYze2gB/JgFiQhpabfEf5/fgGiQhpcBgEf4/vgHiQhpc9hfgE/zgHiQhpc2
					i4gU/tgHiQhpbtjvgc/egHiQhpaGjtga/OgGiRhpY5iwgX/EgGiRhoYphPgT/GgFiRhnZdfugK/UgEiQhnbEeyf7/lgDiPhmc6esfv/0gDiPhmekfYfx/9gC
					iPhmfqgggE//gCiPhmfzhmgb/8gBiQhme8iOgl/5gAiQhmdeiFge/0f/iQhlcAhIgL/uf+iPhla+fqf5/lf+iQhmaXeKfs/bf9iUhnahdKfk/Yf8iWhobidB
					fi/if7iXhodAdsfo/wf7iXhod7e3f7/5f7iXhodygEgO/6f6iXhocog1gT/zf6iWhpa1g1gH/jf6iWhpZEgEf4/Of7iWhpX7e0fw+7f7iVhpXrdhfu+yf7iT
					hpYRctft+3f7iQhpZgcwft/Jf8iPhqa/dufy/gf9iPhqcDfPgA/vf+iPhqcLgygO/wf/iPhpbVh2gU/l]],
				Fire2 = [[
					gJipioYKj0g5+xgIivimVbjugw98gEiyikS+iSgb9IgBiyikRzgHgE8qgAiuimSVeMft83gBinipUWdVfY9qgGihirXLd8fS+qgNidisZvfyfl/XgTidirbA
					iOgN/hgXiiipadkWg2/MgWipinYZlYhL+lgSivilV5k3hI97gKiwilT+i9gy9egDisimTagZgN9Zf/ilioUceJfi9xf+icipWudCfB+dgAiViqZrdVe6/OgE
					iRircce3fW/xgIiQiqd9g+gM/6gKiUipdpizg//xgJibipbsjshU/dgEihinY3jNhB/Af9ilimWLhcgR+af2ioimURe8fd9vfxirinT9cpe39bfwipioVcba
					ek90fyikirYMbqen+rf2igisawdNfI/af7igisb+fbf8/uf+ilirbVhcgm/nf+isipZEiigw/Hf7izinV/iQga+Sf2i4ikTQgpf19Vfxi3ijRweUfT8lftiz
					ikR4cKe88bfuirinTjbHez9CfyikiqWQboe6+If5igisY5difV/FgBigisaWgIgB/fgGijiqaEiego/V]],
				Fire3 = [[
					gXjKjiWwjxhE+XgVjajZUJk3hd9RgMjljRQ3kQhQ71gBjojOORiLgj6if5jjjRNXfkfo5/f4jWjaOYdie16jf/jFjkQ9c5ed8BgMi3jrUOd8eq9pgciyjrW8
					gWfb+rgoi5jnX+jLgf+zgrjJjfXAlUhb+MgjjYjZUpl+h69PgVjgjVR1k3hu8NgFjejVPxiZg17cf4jTjaPRfifj7QfzjDjhQhdTeb70f2iwjoTScbd39DgA
					igjtW1dKeG+dgMiZjuZ2fNfF/XgWifjsbJhsga/kgXitjpaQjohf/OgQi/jkXhkSh1+fgCjNjdT7jVhQ9afzjXjYQkhCf97/fmjbjWO2eLem65ffjUjbPab0
					do67fhjFjkR+a1dS8Jfri2jrVSbids9uf4ixjuX9doew+2gDi5jsY4gTf//MgIjJjmXpifg4+xgDjcjdUqjahE9sf5jqjTRFirgj8KfsjujMONgffj6kfhjp
					jMM+dteg5jfdjcjTNubedz5wfijMjfQNaudp7Nfwi+joTibxeE9FgBi3jsWXeRfA+cgQi8jpXmhTgJ+1]],
				["UpperLeg.L"] = [[
					fPh9gb6rZLfHwRfPh+gb6kZWfIwhfPh/gb6dZhfJwwfPh/gb6XZrfKw8fPiAgb6UZyfJxEfPiAgc6UZ2fHxGfPiAgc6WZ3fDxCfPiAgc6bZ0e9w5fPh/gc6i
					Zve3wsfPh+gd6qZoewwcfPh/gd6jZse5wqfPiCgb6DaCfUxkfPiGga5Jaqf+zDfPiJgY3Zbvg+1YfPiMgX2scHhR2LfPiMgW2qcJhR2OfPiMgW2pcJhR2OfP
					iMgW2pcKhR2PfPiNgW2ncMhR2QfPiOgW2mcNhR2SfPiPgV2kcPhR2UfPiQgV2jcRhR2WfPiQgV2jcQhR2WfQiNgW2ncIhU2QfQiMgX2vb/hZ2GfQiMgY20b6
					hc1/fQiMgY21b3hd1+fQiLgY22b2he19fQiLgZ23b0he18fQiKgZ28bwhc11fQiJgZ4BbEg50hfQiIgZ4fawgpz5fQiHga4zaigdzcfQiEga5baCgHydfQiA
					gb6PZTfpxCfQh7gb6yYwfRv6fQh6gb69YmfHvhfQh6gb67YsfFvofQh7gb63Y1fFvyfQh8gb6xY/fGwB]],
				["LowerLeg.L"] = [[
					fAhNgAxYg0g061fBhOgBxqg0gt6qfBhOgCx7g0gm6efBhOgCyJg0gg6VfBhOgDyTg2gb6OfBhPgDyZg5gZ6KfBhPgDyZg9gZ6KfBhOgDyUhCgb6NfAhOgDyL
					hIge6TfAhOgCyAhOgj6afAhOgDyMhGgh6SfChPgFy2gsgQ51fEhQgJ0DgDf047fIhRgS2TfAfD25fJhTgV27ese12QfJhTgU24ese12SfJhTgU24ese12SfJ
					hUgU23ete12TfJhVgU22eue12VfJhVgU20eve12XfJhXgU2yexe12ZfJhYgU2weye12afJhXgU2wexe12afJhVgU22ere42UfJhUgV2+ele82MfJhTgV3Eeh
					e/2FfJhTgV3GegfA2EfJhTgV3GeefA2DfJhSgW3IedfA2CfJhRgV3FedfC2FfHhRgP1pfEfi3ifGhRgN0/fVfx4IfFhRgL0ifhf74hfEhQgHzgf2gQ5WfChO
					gCx/gRgu6cfBhMf+w2glhD7KfAhMf9wgguhJ7XfAhMf+wqgwhF7SfAhMf+w3gyhB7KfAhNf/xGgzg77A]],
				["Foot.L"] = [[
					fEgigT/OhEfxm3fEgigT/OhBfym3fEgigT/Og+fym3fEgigT/Og8fzm3fEgigT/Og7fzm3fEgigT/Og8fzm3fEgigT/OhAfym3fEgigT/OhFfxm3fEgigT/O
					hMfvm3fEgigT/OhUfum3fEgigT/OhLfvm3fEgigT/Pguf2m3fEgigT/Pf9gBm3fEgigT/OesgSm3fEgkgT/EeUgVndfEgkgT/DeVgUnhfEglgT/CeVgUnlfE
					glgT/AeWgTnufEgmgT+8eXgSn9fEgngT+3eYgQoPfEgogT+yeagPoifEgpgT+tebgNo1fEgogT+weagOopfEgmgT+7eVgSoBfEglgT/BeRgVnpfEglgT/BeP
					gVnlfEgkgT/CeOgWngfEgkgT/FeNgXnXfEgjgT/IeMgYnJfEgigT/MeNgZm2fEgigT/Oe+gOm3fEgigT/PfUgKm3fEgigT/PfjgGm3fEgigT/Pf/gAm3fEgi
					gT/Pgkf4m3fEgigT/Og+fym3fEgigT/OhJfwm3fEgigT/OhKfwm3fEgigT/OhJfwm3fEgigT/OhHfwm3]],
				["UpperLeg.R"] = [[
					gxh9gb6rm1g5wRgwh+gb6hmwgvwjgwh/ga6Xmsglw1gwh/ga6PmpgcxDgwiAgZ6JmogVxNgwiAgZ6GmpgRxRgwiAgZ6HmsgPxPgwh/gZ6KmygPxHgwh/gZ6R
					m6gSw6gwh+gZ6YnBgWwqgwh/ga6Tm6gUw3gwiCgZ52mbgHxtgwiGgY5AlnfuzJgwiJgX3UkXe81cgxiMgX2sj5eu2LgxiMgW2qj3ev2OgxiMgW2pj3ev2Ogx
					iMgW2pj2ev2PgxiNgW2nj0ev2QgxiOgW2mjzev2SgxiPgV2kjxev2UgxiQgV2jjvev2WgxiQgV2kjvew2VgxiNgW2rjzex2OgxiMgY20j4ew2DgxiMgZ27j8
					eu17gxiMgZ29j8eu15gxiLgZ2+j9eu13gxiLga3Aj+ev12gxiKga3Cj/ev1zgxiJga4HksfV0egxiIga4llBfmz2gxiHgb45lQfxzZgxiEgb5iltgMyZgxiA
					gc6YmWg1w7gxh8gd68m2hVvygxh6gd7GnChdvagxh6gd7CnBhWvigxh7gc68m+hOvugxh8gc60m6hEv/]],
				["LowerLeg.R"] = [[
					hAhNgAxYfMfM61g/hNgAxifWfQ6vg/hOgBxrfgfT6pg+hOgBxzfpfV6kg+hOgBx3fwfW6hg+hOgBx3f0fW6hg+hOgBxyf3fU6lg+hOgBxpf3fQ6rg+hNgAxc
					f1fM6zg+hNf/xOfyfH68g+hNgAxffzfL6xg9hPgDyYf9fe6Lg8hQgIz1gTgA5Gg4hRgS2QhIg427g3hTgV26hVhK2Qg3hTgU24hUhL2Sg3hTgU24hUhL2Sg3
					hUgU23hThL2Tg3hVgU22hShL2Vg3hVgU20hRhL2Xg3hXgU2yhPhL2Zg3hYgU2whOhL2ag3hXgU2xhOhM2ag3hVgU25hPhN2Sg3hUgV3DhShM2Hg3hTgW3KhT
					hL2Ag3hTgW3MhThL1+g3hTgW3NhThM18g3hSgW3PhThM16g3hRgW3RhVhN14g5hRgQ12grgq3Wg7hRgN1Mgagb39g7hRgM0vgOgQ4Wg9hQgIzxf0f75Jg/hP
					gDyafNfe6JhBhNgAxZexfJ6zhBhNf/xCerfB7ChBhNf/xDexfC7BhAhNf/xIe5fF6/hAhNf/xPfDfI67]],
				["Foot.R"] = [[
					g8gigT/Oe8gPm3g8gigT/PfGgNm3g8gigT/PfQgLm3g8gigT/PfYgJm3g8gigT/PffgHm3g8gigT/PfjgGm3g8gigT/PfkgGm3g8gigT/PfigHm3g8gigT/P
					ffgHm3g8gigT/PfagIm3g8gigT/PfdgIm3g8gigT/PfugEm3g8gigT/PgRf8m3g8gigT/NhYftm3g8gkgT/Ehsfrndg8gkgT/Dhrfsnhg8glgT/Chrfsnlg8
					glgT/Ahqftnug8gmgT+8hpfun9g8gngT+3hofwoPg8gogT+yhmfxoig8gpgT+thlfzo1g8gogT+whlfyoog8gmgT+7hofvoAg8glgT/Bhqftnpg8glgT/Chq
					fsnlg8gkgT/Dhrfsnhg8gkgT/FhrfrnYg8gjgT/IhsfqnKg8gigT/Mhtfom4g8gigT/Pg5fzm3g8gigT/Pgif4m3g8gigT/PgTf8m3g8gigT/PfzgDm3g8gi
					gT/OfFgNm3g8gigT/NeigVm3g8gigT/NeZgXm3g8gigT/NeggVm3g8gigT/NeogTm3g8gigT/OexgRm3]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAiLgiDVhMh5t/gAiPgiDTgIiVt7gAiYgiDTfCiXt5gAiggiDVeHh/t7gAiigiDYdihRt/gAicgiDZdXgVuDgAiTgiDYdqfWuEgAiMgiDWeXeduBgAiMgiDU
					fVd2t9gAiTgiDTgcdnt5gAicgiDUhddyt5gAiigiDXiPeVt9gAiggiDYinfLuBgAiYgiDZijgLuEgAiPgiDXiDhIuD]],
				Spine = [[
					f8i3gAEJhSh1vkf5i6gAELguh/vof3jDgAEXgDh0v/f3jLgAEkfXhWwYf4jNgAErewgqwkf7jIgAEmeYf1waf+i/gAEZeSfBwBgCi4gAEMegeZvqgGi3gAEJ
					e+eDvjgIi+gAEQfneEvygJjHgAEegUeZwMgJjNgAEpg+e/whgHjLgAEqhefwwigDjDgAEghuglwPgAi7gAEShphVv0]],
				Neck1 = [[
					f5jiflFChYhwxDf1jmflE9g8h3w9fyjvfmFNgXhpxZfyj4foFpfuhLyEf0j6foF9fHgiyif5j1fnF8eofxyff+jrfmFneZfBx+gEjkflFMeeecxTgKjjflE9
					e1eKw7gNjqfmFDfWeOxHgOj0fnFbf9elxvgNj6foF1gmfJyXgKj5foGAhKf2ylgFjwfnFzhigoyRf/jnfmFZhnhUxn]],
				Neck2 = [[
					f3kEfVFMhZhvxSfykHfVFAhEhwxBfwkRfXFUglhexkfwkbfaF8gCg+yhfykefcGffbgWzRf3kYfbGje4fozVf+kOfZGFeje7yqgGkFfWFceheaxsgMkFfVFC
					eweNxDgQkMfWFGfLeXxNgRkWfZFnfsexyCgPkdfbGQgSfVy+gMkcfcGlg3gAzZgFkTfaGXhVgvzEf+kJfXFwhhhYyL]],
				Neck3 = [[
					f2kdfKFWhahuxifwkgfKFDhLhqxGfukrfMFbg0hSxufuk1fRGRgVgxy+fxk4fUHCfwgKz/f3kzfUHLfJfg0Jf+kofQGlese2zVgGkffLFtejeYyEgNkefJFH
					eseRxLgRklfLFKfAegxTgSkwfPF0fae+yVgRk4fTGtf9fizkgMk3fUHNgkgL0MgGkufSG9hHg2z2f+kjfOGJhbhbyt]],
				Head = [[
					f1k3e/AIgViNhcfvk6e+AHg3h/hEftlEfCAGhRhehQfulQfJAHhdgyh4fxlUfOAJhXf+ihf2lOfOAKhBfGiwf+lDfIAKgheUicgHk5fBAJf9d2hxgPk3e+AH
					fZd3hMgSk+e/AGe7eQhGgTlKfFAHene3higRlTfMAIejfniOgNlSfPAKeygditgGlJfMAKfOhVirf9k+fFAJfxh+iI]],
				Jaw = [[
					fwlMeZ/1f7dxiJfrlOeX/0fYd7ihfrlZec/1e6eaiaftllej/3eqfCiZfylrep/6epf2h5f6lmeq/8e4gxhPgDlaek/7fThohJgMlPec/3f0iJhzgTlLeX/0
					gXiNiZgVlSeZ/1g4h3ifgUlfef/2hPhTiegQlpen/4hYgliLgKlqeq/7hRfthjgClhen/8g8eyhAf4lUeg/5gdeEhd]],
				Crest = [[
					f2nTe6XSiNgY+sf2nVe1W7iKf0+mf4nge6XGhzfR+qf7nrfIXshNe3+2f+nvfTYTgaet/BgBnqfWYjfeew/FgEnffNYQeke++/gInVfAXmd8fY+ygKnTe2XD
					dxf5+ogJnae2W8eAge+ngGnmfBXXefg++wgDnufOYBfLhQ+8gBntfWYfgDhT/Ef+nlfTYdhAhK/Df6nafHX8hzg2+5]],
				["Humerus.L"] = [[
					e5jkfxZkTUiu8he1jlfxZSTLiM8ceyjsfwZXSuhi8SeyjzfuZoSDg+8De0j1frZ1RQgu7se4jwfmZ0Qdg17Pe+jofiZmPzhS6zfEjifgZbPdh66gfJjkffZh
					Pbig6dfMjtfhZ9Psi86sfOj5flakQMjJ7FfMkAfpbCQ3jM7jfJj+ftbGRrjL8AfFj1fvavSejI8Ve/jqfxaITFjB8g]],
				["Forearm.L"] = [[
					dlkFg2cAdknu+sdhkJg0b2dXnK+yddkRgwcAcymo+3dakYgrcQb9mQ+4dYkZgjcUbCmJ+ydZkTgacDaLmU+kdckJgQbjZkmt+SdgkCgLbGZTnP+CdkkAgKbB
					ZWn194dokGgQbZZqoW93drkOgYcDaKos9+dtkUgicqa2o0+IdtkTgrc8btow+UdskNgyc0cmoi+edpkHg1cZdSoM+m]],
				["WingFinger1.L"] = [[
					dOkbige7r0pZ8MdJkhieezroot8edBkniafsq4o68vc5ksiUg9pwps83cykriKhnopqe87ctklh+hIn6qt9EcrkdhzfqnoqU9TcskXhreDnrpt9bcwkWhrdL
					n5pn9Vc2kZhydioMqX9Cc9kdh9e6ohrn8idEkgiKgfo9sp7/dLkfiVhWpos27pdPkcidhEqisF7qdRkaigf9rYqu76]],
				["WingFinger2.L"] = [[
					eTk6jviOsxlk8ueNk+juiJsek58+eDk+jujIr0lL9Gd4k6jtkeq7mG9Gdrk0jnlNp/nB9HdhkwjekzpQnW9VdakwjTjbo0m/9wdZkzjLh1oqmZ+Edck4jJg8
					ozmR+Gdkk6jPhPpOm/9zduk5jaigp1oO9Nd7k1jmj9qhpM8geHkxjukurSpT8DeQkxjykYsDob8EeUk0jyjQsnm98Y]],
				["WingFinger3.L"] = [[
					fdk7kzlsuGhs8GfWk9kzlrtthD8UfKk4k1mttLhc8Ve7kuk2oEshig8Nerkkkyo2ryjk8LedkiktohrFj/8feSkokmnQqhjp9GeOkzkglwqLjC9oeRk9kek4
					qPi49xebk/kjlFqyjj9eerk6krmLrpku8xe9kykxncsjlq76fOksk1oEtXls7Wfaktk2ntt9ks7Vffkzk1mouOjH7t]],
				["Humerus.R"] = [[
					g5jiffZbwndy6cg1jofgZtwedQ6jgzjzfjaRwGc863gzj9fna1vgc07Ug1kAfrbIuwc17yg5j7fua+t7c28Mg+jwfwactMc68chEjmfxZ0sxdG8hhJjjfxZY
					sudh8fhNjofwZStBeJ8YhOjwfvZftmey8MhNj1fsZwuWfN75hKjzfpZ2vKfR7ehFjsfkZuv6e+7Ag/jkfhZfwbeb6n]],
				["Forearm.R"] = [[
					iekAgKbAmuYe98iakDgMbKmhX693iWkKgUbtmHXd96iUkSgdcYlhXO+DiTkUgnc3kvXN+OiTkQgvc7j2XW+ZiVkKg0cojBXo+iiZkFg2cLihYC+pidkGg1b4
					ifYk+vihkNgyb5i5ZI+1ilkVgucIjoZm+5inkZgncUkhZ2+2inkWgfcOlbZ0+rimkOgVb0mLZh+biikFgNbTmoZD+J]],
				["WingFinger1.R"] = [[
					jSkWhqdeYOWc9ajNkXhtdMX+WI9NjGkbh3eIXqVC8zi/kfiDfuXTTz8Qi4kgiQhDWwTJ7xizkdiZhWV8Tc7nivkbifgkVBUk7xiwkaihfYUVWA8Di0keifeu
					UNXE8Vi7kkicfJUsXT8njDkqiXgVVqWv80jKksiQhaW1V485jRkoiFhhXyVV8+jVkhh4geYSVc9MjVkahue0YYWB9Z]],
				["WingFinger2.R"] = [[
					imk1jJhQXUZx+Hihk5jLg7XBZe9/iXk6jVhyWfYb9iiLk3jgjRV1XO82h/kzjqkdVHWo8Oh0kxjxkrUVXC8Bhtkyjyj3ToYS8Nhsk3jxiqTRZz8jhwk8juiC
					TVa582h3k+juiiT0bF9DiCk8juj0Unaa9HiPk3jqk+VkZa9FibkyjjlKWbYu9MijkvjZkMXBYx9iinkxjPilXTZV98]],
				["WingFinger3.R"] = [[
					hxk5kelMV3dJ9whrk/kgk1Vjc59rhek+kmljU0b59KhMk2kum2T6av8Vg6kukzn3TCaN7jgrkrk2oASUat7Rgjkvk2nNR3cF7gghk3k0mFR0dr76gmk9kyli
					SFex8Pgwk8k0mFSje48Xg9kzk2nZTJeF8ShNkok0olT3c78Khckikwo1UlcI8Shpkkkqn+VOcH8yhxkukjmeVtcr9Z]],
				Tail1 = [[
					gAiLgiiPjQfb/vgAiPgihiiYgy/2gAiYgihXhEh8/4gAiggih0fmiw/0gAiigiimeQjI/rgAicgijMdNjB/kgAiTgijNcmiX/jgAiMgiiocihP/qgAiMgih2
					dIf5/zgAiTgihXeQen/4gAicgihhfrdn/3gAiigiiNhHdA/wgAiggii9iUc3/ngAiYgijSjLdQ/igAiPgii+jheK/m]],
				Fire1 = [[
					gOiDhoXdlFgm+ZgLiLhpVPhQhq+DgFiVhqWLdniP+Rf+ibhqZgb8iS++f5iYhpc/cfih/jf0iQhoeTeBi3/wfxiGhncpfGiN/ufxiChoZKfBgZ/PfziGhpWA
					eBe1+Tf4iQhpVJdFeJ94f+iZhqXMdWdk+igFibhpa8fdc//cgKiVhoeBiydR/sgNiLhneRl0eX/XgPiDhnbam5fi+5]],
				Fire2 = [[
					giimifU+oAho85gNi2iePwjAh67Uf4i8igPFczhl66fsi0imTBZDhA8YfpikiqY/ZUhC+efriWirdAcfiF/lftiUiqcZf9in/rfsifimXshvhL+0ftivifR7
					hCe18sfvi8idOueidh6xf3i9ijP7cfc97QgEiwiqU7dDcV9pgWicira5gscj/YgmiRindtljeU/YgsiWiibKoxgb+Y]],
				Fire3 = [[
					g/jTjLU4plif8UgUjyi9Nyl2iu5ffpj4i9Kae5hK3ifQjljNMhZBfS4YfNjAjiSdXJer7jfciijtYmZof4+dfrikjtateVhg/efyjBjgXeiShh+tfzjljJRC
					jpfu8Cfwj6i5Lnh0dr4efwj5jDKaefcV3Qf+jdjdN4c0be5xgbixjsUfetbf9eg+iZjmaFjidU/HhPiqjZaWoQgQ+Y]],
				["UpperLeg.L"] = [[
					fPhwgj4UZ5deztfRhxgi5jYLdDxWfTh3gh6zW6dDuofUh9gf8QWBc5qvfVh/gc9VVmcomnfVh6gZ9zVmcmj3fUhygX99V0dGjrfShugV9sWReRmofQhygV8z
					WxfeqZfOh8gW7hXpgYuAfNiIgY4ZaTiVzxfMiPga3PbuiT1cfLiNgd2lcphr2VfMiEgg4ZbGfI0FfNh4gi47aJdpzB]],
				["LowerLeg.L"] = [[
					e6g9gWpRjmfI+Ze5hCgMkIjye1/ee7hOgBi6jHef/re+hff0lZiFec/bfChtfpp+g8ew+WfFhxfjuffzfd8hfGhpfgxue1gc6mfFhafi0CeLhe41fEhRfo0j
					eMiH4WfChRfz0jetiO4YfHhRgL3weDge1WfIhXgV3ievfn1ofHhVgc2xfie42be+hNgUxjiLf86qe6hEgSsojpf79K]],
				["Foot.L"] = [[
					fEgig8/Hi6fXm1fEg2g4+mjOfGosfEhFgu+QiffLqDfEhPgg+Ehcffq0fEhRgP+Cgcf2q/fEhLf/+NfpgIqifEg+fy+ifIgRpffEgsfs+/fBgQn2fEgifw/P
					fYgJm3fEgif7/Pf4gCm3fEgigG/NeggVm3fEgogR+zesgNojfEgmgb+/fHgJn6fEgigm/Mh4fmm2fEgigx/FjOfTm1]],
				["UpperLeg.R"] = [[
					gvhvgV9IpRgzpYgxh2gV8So8gKr/gziCgX6bnce8wZg0iNgZ3kkzdf08g0iQgc27jzd/15g0iJge3Pj4fg1og0h9gh41lfhyzVgyhzgi4wmFilzKgwhvgj4/
					nDi3ydguhzgi6Iogi9wHgsh6gg7ipljAszgrh/gd84qQjPomgrh9gb9oqcjck+gsh2gY96qUjPjZgthwgW96qBiakv]],
				["LowerLeg.R"] = [[
					g7hRfm1XiIeR3pg9hRfs0Rhgdt4mg9hRf81ehSeP3ng4hVgR38hvgH1Kg5hXgY3Kg1gv2Cg8hRga02fSgv4PhEhJgSu8c5f88HhGhAgTqscNgc96hHg+gRmO
					cKg+/IhGhHgHjBcghX/ohDhWf6jwdYhl/nhAhnfunkefhd/Ag8hxfmsWfpg89fg6hvfhwRgugF7ig6hifgy6hjfB5v]],
				["Foot.R"] = [[
					g8gifr/OhEfxm3g8gif1/PgRf8m3g8gigA/PgUf8m3g8gmgL+8hnfsn8g8gogW+zhDf3okg8gigh/PftgEm3g8gigr/IdPgnm1g8gig2/Ecvgum1g8gsg7+1
					cwg1n0g8g+g0+adFg6pcg8hLgn+JeCgsqhg8hRgX+CfFgVq/g8hPgH+Gf/gAq1g8hFf4+WgqfyqFg8g2fu+wg+fuov]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAkvgi//gAgAgSgAk1gi//gAgAf9gAlBgi/+gAgAfLgAlOgi/8gAgAeYgAlTgi/7gAgAeDgAlOgi/8gAgAeYgAlBgi/+gAgAfLgAk1gi//gAgAf9]],
				Spine = [[
					gAkufqAJgAgAi5gAk1fqAKgAgAi+gAlEfqALgAgAjLgAlTfrAMgAgAjXgAlZfrANgAgAjdgAlTfrAMgAgAjXgAlEfqALgAgAjLgAk1fqAKgAgAi+]],
				Neck1 = [[
					gAk4e4A/gAgAn1gAk+e4BCgAgAn/gAlOe4BIgAgAoXgAlee4BPgAgAowgAlke5BSgAgAo6gAlee4BPgAgAowgAlOe4BIgAgAoXgAk+e4BCgAgAn/]],
				Neck2 = [[
					gAlJeXCDgAgArOgAlQeXCJgAgArdgAlheYCWgAgAsAgAlyeZClgAgAsjgAl4eZCrgAgAsxgAlyeZClgAgAsjgAlheYCWgAgAsAgAlQeXCJgAgArd]],
				Neck3 = [[
					gAlceCDfgAgAuegAljeDDogAgAuxgAl0eEEAgAgAvegAmGeFEZgAgAwJgAmNeGEkgAgAwbgAmGeFEZgAgAwJgAl0eEEAgAgAvegAljeDDogAgAux]],
				Head = [[
					gAlydyADgAgAhXgAl6dzADgAgAhXgAmMd1ADgAgAhXgAmed4ADgAgAhXgAmld5ADgAgAhXgAmed4ADgAgAhXgAmMd1ADgAgAhXgAl6dzADgAgAhX]],
				Jaw = [[
					gAmHdL/2gAgAjEgAmOdM/2gAgAjEgAmgdP/2gAgAjEgAmzdS/2gAgAjEgAm6dT/2gAgAjEgAmzdS/2gAgAjEgAmgdP/2gAgAjEgAmOdM/2gAgAjE]],
				Crest = [[
					gAoOdsX0gAgA+7gAoWdtYQgAgA/CgAoodvYDgAgA+/gAo6dyXWgAgA+zgApBdzWjgAgA+kgAo6dyWIgAgA+bgAoodvWUgAgA+fgAoWdtXBgAgA+t]],
				["Humerus.L"] = [[
					e/k6e5IBOSd0rXe/lBe6KMNvfWune/lRe6N5OZlby3e/lge6SJP4sP0he/lne6T7P5vqzTe/lge6RAOZuSw3e/lRe6LeNtort2e/lBe6IAOShurZ]],
				["Forearm.L"] = [[
					eel/dmI4NigpsIeHmKd4L5M4jGvmdgmHeeP4Nzn/zLdQl0fHSxPNsg0PdRljfSSzOlt8yvdOlhe1PdM2rivzdglseEKyMtmwsdeJl3dmIONuiMq5]],
				["WingFinger1.L"] = [[
					dqm6cWK7MciYt0c5nBc/PnMSmxx5b4mreMUhOCrT0/bimAfTWKPmt51jbhlkfZT4OLtGzqbjlpeZPULqoyv8cMmKdAK+Laj2r6dTmmcRJJMkhNrB]],
				["WingFinger2.L"] = [[
					cmnubTNdLDiGvVbWnkcgT6MRob0aaLmzeYaZPttp3PZ6l9fyb6Rwvq3oZ0llfjX8PHt417Z+l8dyRsK3n8xkbHmub0MuJuhysTcfnXa+K8KufarP]],
				["WingFinger3.L"] = [[
					bfodaeQCJ7hewtZznzcbYbNep426YymhfCgcTZvt42YrlkgrhqVxxE4/YWlZgDb9RDuY4BYfmNdXT/KNmqy9aKnVauOjIBfNr8bzoIZzM0I8dKqu]],
				["Humerus.R"] = [[
					hBk6e5IBxuiMrXhBlBe6KMyRgqunhBlRe6N5xnaly3hBlge6SJwITx0hhBlne6T7wHQWzThBlge6RAxnRuw3hBlRe6LeyTXVt2hBlBe6IAxueSrZ]],
				["Forearm.R"] = [[
					hil/dmI4yefXsIh5mKd4L5zIc6vmigmHeeP4yNYBzLiwl0fHSxwzTg0PivljfSSzxbSEyviylhe1PdzKUevziglseEKyzTZQsdh3l3dmIOySd0q5]],
				["WingFinger1.R"] = [[
					iWm6cWK7zkdot0jHnBc/PnzuZPx5kImreMUhx+Ut0/kemAfTWKwaSH1jkflkfZT4x1S6zqkdlpeZPU0WXOv8j0mKdAK+0mcKr6itmmcRJJzcezrB]],
				["WingFinger2.R"] = [[
					janubTNd09d6vVkqnkcgT6zvXl0al1mzeYaZwTSX3PmGl9fyb6uQQW3omMllfjX8w5SI17mCl8dyRs1JYExkk5mub0Mu2SeOsTjhnXa+K81SgmrP]],
				["WingFinger3.R"] = [[
					khodaeQC2FeiwtmNnzcbYbyiWI26nOmhfCgcsnQT42nVlkgrhqqPO84/nqlZgDb9u9Ro4BnhmNdXT/1zZWy9l2nVauOj3/gzr8kNoIZzM03Ei2qu]],
				Tail1 = [[
					gAkvgiS3gAgA9KgAk1giUUgAgA9ygAlBgiWGgAgA+agAlOgiXIgAgA+vgAlTgiWzgAgA+ogAlOgiVTgAgA+JgAlBgiTjgAgA9egAk1giSjgAgA9B]],
				Fire1 = [[
					gAlnhPO/iCfd7AgAlohVLwire64mgAluhaK+eFg34AgAl2hdQddLgn70gAl9hcSriFfu9AgAl9hYMlite/5QgAl3hSJBeLhB2JgAlthOMadThC5H]],
				Fire2 = [[
					gJmkhtOjg8fh6ygMmqhhLAmCeb3Uf3mxhjF0e9f8yVf0mwiALSZzgk3kgJmwiISNg/fp82gMm+hpLymFeo3/f3m6hPEXe9gCwDf0mvheH8Z9hg0I]],
				Fire3 = [[
					gNnjiILRdnfS4OgjnqhmLdnFed3bf1nxhMDxiPe4u0ffnxiGF7Y0fFxCgNnlizOndue+6vgjn+hyMPnIes4Ff1n2gtCniIetsYffnuhQDoYwgMs3]],
				["UpperLeg.L"] = [[
					fPkag04maZgNzrfPkfg04zaZgJzafPkrgy5RaZgAyzfPk2gx5uaZf3yLfPk7gx56aZfzx6fPk2gx5uaZf3yLfPkrgy5RaZgAyzfPkfg04zaZgJza]],
				["LowerLeg.L"] = [[
					fEjkgmgbgAgA//fEjpglgwgAgA/+fEj2ghhjgAgA/9fEkCgdiVgAgA/6fEkIgciqgAgA/4fEkCgdiVgAgA/6fEj2ghhjgAgA/9fEjpglgwgAgA/+]],
				["Foot.L"] = [[
					fEjjhV+LgAgAqofEjnhU+SgAgAqUfEjxhQ+hgAgApkfEj8hM+wgAgAozfEkAhK+2gAgAoffEj8hM+wgAgAozfEjxhQ+hgAgApkfEjnhU+SgAgAqU]],
				["UpperLeg.R"] = [[
					gxkag04mlnfzzrgxkfg04zlnf3zagxkrgy5RlngAyzgxk2gx5ulngJyLgxk7gx56lngNx6gxk2gx5ulngJyLgxkrgy5RlngAyzgxkfg04zlnf3za]],
				["LowerLeg.R"] = [[
					g8jkgmgbgAgA//g8jpglgwgAgA/+g8j2ghhjgAgA/9g8kCgdiVgAgA/6g8kIgciqgAgA/4g8kCgdiVgAgA/6g8j2ghhjgAgA/9g8jpglgwgAgA/+]],
				["Foot.R"] = [[
					g8jjhV+LgAgAqog8jnhU+SgAgAqUg8jxhQ+hgAgApkg8j8hM+wgAgAozg8kAhK+2gAgAofg8j8hM+wgAgAozg8jxhQ+hgAgApkg8jnhU+SgAgAqU]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAifgiECgAgAvggAiegmEOgAgAv2gAiagvEugAgAwtgAiXg6FVgAgAxqgAiUhBFvgAgAyRgAiYgmEqgAgAwngAiffgCkgAgAsggAiffgCkgAgAsggAiffgCk
					gAgAsggAiffjCngAgAsogAiffyC8gAgAtXgAifgJDcgAgAuYgAifgbD4gAgAvOgAifgiECgAgAvggAifgiECgAgAvggAifgiECgAgAvg]],
				Spine = [[
					gAjOgEFPgAgAxggAjOgJFjgAgAx+gAjMgWGXgAgAzHgAjKgkHWgAgA0YgAjIguIBgAgA1KgAjJgMGTgAgAzDgAjHe5DEgAgAtngAjHe5DEgAgAtngAjHe5DE
					gAgAtngAjIe8DJgAgAtygAjJfODngAgAuvgAjMfoEWgAgAwEgAjOf9FAgAgAxJgAjOgEFPgAgAxggAjOgEFPgAgAxggAjOgEFPgAgAxg]],
				Neck1 = [[
					gAj9fwGDgAgAytgAj9f2GigAgAzXgAj9gHH2gAgA0+gAj8gbJdgAgA2rgAj7gnKkgAgA3vgAj6f9H9gAgA1FgAjveYDSgAgAuFgAjveYDSgAgAuFgAjveYDS
					gAgAuFgAjwecDZgAgAuSgAjzexD/gAgAvbgAj5fOE6gAgAxAgAj8fnFwgAgAySgAj9fwGDgAgAytgAj9fwGDgAgAytgAj9fwGDgAgAyt]],
				Neck2 = [[
					gAkhfkGDgAgAytgAkhfsGtgAgAzkgAkigCIdgAgA1qgAkhgbKqgAgA31gAkggrMOgAgA5IgAkff4IvgAgA19gAkMeCC5gAgAtPgAkMeCC5gAgAtPgAkMeCC5
					gAgAtPgAkNeGDAgAgAtfgAkTedDqgAgAu1gAkae+EugAgAwtgAkffaFtgAgAyNgAkhfkGDgAgAytgAkhfkGDgAgAytgAkhfkGDgAgAyt]],
				Neck3 = [[
					gAk7fbGDgAgAytgAk8flG3gAgAzxgAk+gAJGgAgA2UgAk9geL8gAgA46gAk7gyN9gAgA6agAk7f3JkgAgA2ygAkhdvChgAgAsZgAkhdvChgAgAsZgAkhdvCh
					gAgAsZgAkjd0CpgAgAsrgAkqeNDXgAgAuPgAkzexEjgAgAwagAk5fRFqgAgAyJgAk7fbGDgAgAytgAk7fbGDgAgAytgAk7fbGDgAgAyt]],
				Head = [[
					gAlWfSADgAgAhXgAlXffAKgAgAjBgAlaf/A1gAgAnMgAlYgkCQgAgArwgAlVg8DjgAgAungAlXf3BAgAgAn4gAk1dcBDgAgAX9gAk1dcBDgAgAX9gAk1dcBD
					gAgAX9gAk3dhA8gAgAYXgAlAd8AfgAgAakgAlLekAGgAgAdxgAlTfHABgAgAgdgAlWfSADgAgAhXgAlWfSADgAgAhXgAlWfSADgAgAhX]],
				Jaw = [[
					gAlqes/9gAgAhZgAlwe7/+gAgAgygAl7fj/+gAgAe2gAmAgT/sgAgAbpgAl/gz/rgAgAbggAl5fc/KgAgAnQgAkxcw9ogAgAsDgAkxcw9HgAgAtPgAkxcw9Y
					gAgAsqgAk0c1+PgAgAqbgAlDdR+8gAgAoIgAlXd6/mgAgAk+gAlmef/6gAgAiTgAlqes/9gAgAhZgAlqes/9gAgAhZgAlqes/9gAgAhZ]],
				Crest = [[
					gAnyfNXMgAgA+wgAnzfpYngAgA/IgAntgycRgAgA/xgAnWiAgfgAgA//gAm/ivjQgAgA/0gAnogwcngAgA/zgAmzcAPDgAgA7IgAmzcAQcgAgA78gAmzcAQg
					gAgA7+gAm3cIQ3gAgA8LgAnLc2S1gAgA9KgAnid8VagAgA+MgAnve4XRgAgA+xgAnyfNXfgAgA+1gAnyfNXMgAgA+wgAnyfNXMgAgA+w]],
				["Humerus.L"] = [[
					e/j9fzbVOwhM6ge/j9f5bIObfq6Re/j9gKacN8b45fe/j7geZTOCX44Se/j6gqYXOcVg3Xe/j6gAZjNXau4oe/jwebZ+Ptna50e/jwebZbRbnx6me/jwebZa
					Rgny6oe/jwefZeRdni6re/j0ezZ2RLmI6/e/j5fRafQhj+7Ke/j8fqbDPwiE7Be/j9fzbSPEhS6se/j9fzbVOwhM6ge/j9fzbVOwhM6g]],
				["Forearm.L"] = [[
					dZkUgddSThl38udZkbghdESTjy8gdektgscCP2eh7SdrlAg9aGONY446d2lLhKYZNzVn27dhkzgbanOLcT5vdYj3fKbHVZri7ddej9fUa0XTrp8Bdej+fUa0
					XYrp8Cdej/fYa6XTrb8IdekFfsbfW0qL8jddkMgHcXV1oS88dckTgcdFUumm9DdakVggdTT4l784dZkUgddSThl48vdZkUgddSThl38u]],
				["WingFinger1.L"] = [[
					cHkVhpgjbkpV+RcCkihmgaZFm2+ecAlJhgfNTngK9fcTl8hgcVPSYv6BcsmahlZqNqUi2scBlgg/dJQNcy7ecMj6gbdqeUuR8fcckHgtfOgYvG8McdkHgufT
					gdvI8LcckIgxfcgVu98RcbkNhEgOfluB8wcXkRhdg/eMsX9ccQkVhuhPcyql9/cKkWhtg3b5pm+OcHkVhpgjbkpV+RcHkVhpgjbkpV+R]],
				["WingFinger2.L"] = [[
					brkJjSlSc1ns+bbVkVjJlCZ+le+haylOisjZTsfQ9Ua8mqiPf3OpYB5qbjnliCcwMuTy2Lanl7h1g8P6cE7Wb7kDiHiygTsc9WcckNiamZjSs/8VcdkNibmj
					jZtA8ScckNiemujPs38VcZkKiynjiTsF8jcOkGjJn3gbqs9Hb+kGjYnQegpD9ybxkIjXmAdRoB+QbskJjSlSc1nt+bbrkJjSlSc1ns+b]],
				["WingFinger3.L"] = [[
					bgjlkvp9e8mL9va3jxkhpnbtkS95Zqk8jwnjUfej81ZlnGi4jYOlXW5LaXoiibf1MRS+1iZQmDinktQObb7CcEj0jpn6jSqc9Ac+jyj0tdncqi6AdAjyj0ts
					nnqg52c/jwj4t3nbqb51c4jlkKuumVp852chjakhuoj9pB6scCjZkytNhWnp8FbrjgkzrHfmml9Rbhjlkvp+e8mM9vbgjlkvp9e8mL9v]],
				["Humerus.R"] = [[
					hBj9fzbVxQe06ghBj9f5bIxlgW6RhBj9gKacyEkI5fhBj7geZTx+oI4ShBj6gqYXxkqg3XhBj6gAZjyplS4ohBjwebZ+wTYm50hBjwebZbulYP6mhBjwebZa
					ugYO6ohBjwefZeujYe6rhBj0ezZ2u1Z46/hBj5fRafvfcC7KhBj8fqbDwQd87BhBj9fzbSw8eu6shBj9fzbVxQe06ghBj9fzbVxQe06g]],
				["Forearm.R"] = [[
					inkUgddSsfaJ8uinkbghdEttcO8giiktgscCwKhf7SiVlAg9aGxznI46iKlLhKYZyNqZ27ifkzgbanx1jt5vioj3fKbHqnUe7diij9fUa0otUX8Biij+fUa0
					ooUX8Ciij/fYa6otUl8IiikFfsbfpMV18jijkMgHcXqLXu88ikkTgcdFrSZa9DimkVggdTsIaF84inkUgddSsfaI8vinkUgddSsfaJ8u]],
				["WingFinger1.R"] = [[
					j5kVhpgjkcWr+Rj+kihmgam7ZK+ekAlJhgfNsZf29fjtl8hgcVwunR6BjUmahlZqyWre2sj/lgg/dJvzjO7ej0j6gbdqhsRv8fjkkHgtfOfoQ68MjjkHgufT
					fjQ48LjkkIgxfcfrRD8RjlkNhEgOgbR/8wjpkRhdg/h0Tp9cjwkVhuhPjOVb9/j2kWhtg3kHWa+Oj5kVhpgjkcWr+Rj5kVhpgjkcWr+R]],
				["WingFinger2.R"] = [[
					kVkJjSlSjLYU+bkrkVjJlCmCai+hlOlOisjZsUgw9UlEmqiPf3xXn/5qkdnliCcwzSsO2LlZl7h1g8wGj87WkFkDiHiyftTk9WjkkNiamZcuTB8VjjkNibmj
					cnTA8SjkkNiemucxTJ8VjnkKiynjdtT78jjykGjJn3flVU9HkCkGjYnQhgW99ykPkIjXmAivX/+QkUkJjSlSjLYT+bkVkJjSlSjLYU+b]],
				["WingFinger3.R"] = [[
					kgjlkvp9hEZ19vlJjxkhpnkTbu95mWk8jwnjrhhd81mbnGi4jYxboq5Llpoiibf1zvtC1imwmDinktvykl7Cj8j0jpn6cuVk9AjCjyj0tdYkVe6AjAjyj0ts
					YZVg52jBjwj4t3YlVl51jIjlkKuuZrWE52jfjakhuocDW/6sj+jZkytNeqYX8FkVjgkzrHgaZb9Rkfjlkvp+hEZ09vkgjlkvp9hEZ19v]],
				Tail1 = [[
					gAifgij6gAgA/wgAiegmkHgAgA/ugAiagvkmgAgA/qgAiXg6lKgAgA/kgAiUhBlhgAgA/ggAiYgmkIgAgA/ugAiffghIgAgA/+gAiffgivgAgA/4gAiffgiz
					gAgA/3gAiffji8gAgA/2gAiffyjsgAgA/xgAifgJkYgAgA/sgAifgbklgAgA/qgAifgikOgAgA/tgAifgij6gAgA/wgAifgij6gAgA/w]],
				Fire1 = [[
					gAiRhobRihgY/igAiOhsYUgAgA/DgAiJh1aAdefu/UgAiCh/edeefn/6gAh+iGgChgge/9gAiIhsbfjQgh/ggAidgoSBgAgA8xgAiWgnWGaggH96gAiWgneZ
					ctfL/xgAiVgqg/jJhF/zgAiSg5bFkogq/QgAiPhPXOgAgA+wgAiOhhZydMfu/QgAiPhodheefq/2gAiRhoebhigZ/6gAiRhobRihgY/i]],
				Fire2 = [[
					gKilipZ+khhQ/EgAiuioTfiJgV9Xf2iii0S+cyfC9Bf6iJjDZbcDee/BgGh+jKepgxgI/9gNicisbClzhp/BgAjThSM2kqfj5Mfqi9haMbZEeb4RfyidhqYX
					Xgc19tgOiRhtikhzf4/1gTinh3cPoMiK+ngAiziJSFjHgU8of0ioifSccce88uf6iairYhcAel+zgGiXisdCgxgF/2gKilipZ+khhQ/E]],
				Fire3 = [[
					gci+jmZEkehY+4gIjfjXRrkghV8NfrjVjgNrekex6Jfrilj/SobDdD8egKiEkOaietet/dgkixjpbBlzhp/BgRkThiN4p9gc4ZfYj+hlGtdDcRy+fUi/icO+
					V7Ze4RgViGiweRd6ca/rgzi4ixd5oTht+xgLjoiyRQmihl7lfpjcjJNCebek5qfri5jmRza+dM8EgKikjvY9epex/Jgci+jmZEkehY+4]],
				["UpperLeg.L"] = [[
					fPiFgZ5RaZgAyzfPiEgc5waPfyyFfPiBgk6xZ+fVwafPh+gt7rZ1e6uxfPh8gz8JZ1eut1fPh+gb6jZrfHwpfPiEfdv8c6h87ffPiEfdv8c6h87ffPiEfdv8
					c6h87ffPiEffwOc3h77UfPiEftx2cnhx6RfPiEgC2za0gl10fPiFgT4zaagFzafPiFgZ5RaZgAyzfPiFgZ5RaZgAyzfPiFgZ5RaZgAyz]],
				["LowerLeg.L"] = [[
					fEhQgHzmgAgA5SfDhQgIzpgIgH5QfChQgJ0FgUgU45fChRgN1AgYge4HfChRgQ1ygXgh3bfBhOgBxogygc6rfJhSf4wHepfC7lfJhSf4wHepfC7lfJhSf4wH
					epfC7lfJhSf6wZeofB7bfJhPgCyBeke96XfEhMf+w1f8fu7NfEhPgEysgEf/59fEhQgHzmgAgA5SfEhQgHzmgAgA5SfEhQgHzmgAgA5S]],
				["Foot.L"] = [[
					fEgigT/PgAgAm3fEgigT/PgKf+m3fEgigT/Pgbf6m3fEgigT/Pgjf4m3fEgigT/Pgjf4m3fEgigT/Pg4f0m3fFgpgP+aeWgNpzfFgpgP+aeWgNpzfFgpgP+a
					eWgNpzfEgogQ+jeVgOpXfEgjgT/HeSgXnQfEgigT/Pf0gDm3fEgigT/PgDf/m3fEgigT/PgAgAm3fEgigT/PgAgAm3fEgigT/PgAgAm3]],
				["UpperLeg.R"] = [[
					gxiFgZ5RlngAyzgxiEgc5wlxgOyFgxiBgk6xmCgrwagxh+gt7rmLhGuxgxh8gz8JmLhSt1gxh+gb6jmVg5wpgxiEfdv8jGeE7fgxiEfdv8jGeE7fgxiEfdv8
					jGeE7fgxiEffwOjJeF7UgxiEftx2jZeP6RgxiEgC2zlMfb10gxiFgT4zlmf7zagxiFgZ5RlngAyzgxiFgZ5RlngAyzgxiFgZ5RlngAyz]],
				["LowerLeg.R"] = [[
					g8hQgHzmgAgA5Sg9hQgIzpf4f55Qg+hQgJ0Ffsfs45g+hRgN1Afofi4Hg+hRgQ1yfpff3bg/hOgBxofOfk6rg3hSf4wHhXg+7lg3hSf4wHhXg+7lg3hSf4wH
					hXg+7lg3hSf6wZhYg/7bg3hPgCyBhchD6Xg8hMf+w1gEgS7Ng8hPgEysf8gB59g8hQgHzmgAgA5Sg8hQgHzmgAgA5Sg8hQgHzmgAgA5S]],
				["Foot.R"] = [[
					g8gigT/PgAgAm3g8gigT/Pf2gCm3g8gigT/PflgGm3g8gigT/PfdgIm3g8gigT/PfdgIm3g8gigT/PfIgMm3g7gpgP+ahqfzpzg7gpgP+ahqfzpzg7gpgP+a
					hqfzpzg8gogQ+jhrfypXg8gjgT/HhufpnQg8gigT/PgMf9m3g8gigT/Pf9gBm3g8gigT/PgAgAm3g8gigT/PgAgAm3g8gigT/PgAgAm3]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAifgiECgAgAvggAicgiDvgAgAu9gAiTgiDGgAgAttgAiMgiCogAgAsqgAiNgiCtgAgAs2gAiegiEMgAgAvygAiqgiFkgAgAyAgAirgiFzgAgAyWgAirgiFz
					gAgAyWgAirgiFzgAgAyWgAirgiFzgAgAyWgAirgiFzgAgAyWgAirgiFzgAgAyWgAirgiFzgAgAyWgAirgiFzgAgAyWgAirgiFzgAgAyWgAirgiFzgAgAyWgA
					irgiFxgAgAySgAingiFHgAgAxUgAihgiESgAgAv+gAifgiECgAgAvggAifgiECgAgAvggAifgiECgAgAvg]],
				Spine = [[
					gAjOgEFPgAgAxggAjJgDEygAgAwzgAi+f/D2gAgAvMgAi0f8DKgAgAt1gAi2f8DSgAgAuEgAjOgFFlgAgAyBgAjdgOH5gAgA1BgAjfgPITgAgA1fgAjfgPIT
					gAgA1fgAjfgPITgAgA1fgAjfgPITgAgA1fgAjfgPITgAgA1fgAjfgPITgAgA1fgAjfgPITgAgA1fgAjfgPITgAgA1fgAjfgPITgAgA1fgAjfgPITgAgA1fgA
					jfgPIPgAgA1agAjZgLHGgAgA0EgAjRgGFrgAgAyKgAjOgEFPgAgAxggAjOgEFPgAgAxggAjOgEFPgAgAxg]],
				Neck1 = [[
					gAj9fwGDgAgAytgAj3fsFagAgAxxgAjpfiEEgAgAvkgAjcfcDGgAgAttgAjefdDRgAgAuCgAj+fzGlgAgAzbgAkQgHKJgAgA3XgAkSgKKygAgA38gAkSgKKy
					gAgA38gAkSgKKygAgA38gAkSgKKygAgA38gAkSgKKygAgA38gAkSgKKygAgA38gAkSgKKygAgA38gAkSgKKygAgA38gAkSgKKygAgA38gAkSgKKygAgA38gA
					kSgJKrgAgA32gAkLgAI6gAgA2IgAkBf0GugAgAzmgAj9fwGDgAgAytgAj9fwGDgAgAytgAj9fwGDgAgAyt]],
				Neck2 = [[
					gAkhfkGDgAgAytgAkafdFPgAgAxggAkIfPDlgAgAurgAj5fECdgAgAsQgAj8fGCpgAgAssgAkifpGxgAgAzpgAk1gJLggAgA4jgAk3gOMXgAgA5QgAk3gOMX
					gAgA5QgAk3gOMXgAgA5QgAk3gOMXgAgA5QgAk3gOMXgAgA5QgAk3gOMXgAgA5QgAk3gOMXgAgA5QgAk3gOMXgAgA5QgAk3gOMXgAgA5QgAk3gOMXgAgA5QgA
					k3gNMOgAgA5IgAkxf+J0gAgA3DgAklfqG7gAgAz2gAkhfkGDgAgAytgAkhfkGDgAgAytgAkhfkGDgAgAyt]],
				Neck3 = [[
					gAk7fbGDgAgAytgAkzfSFEgAgAxPgAkfe/DIgAgAtwgAkNewB5gAgAqxgAkQezCFgAgArUgAk9fiG8gAgAz4gAlRgOM6gAgA5qgAlSgVOBgAgA6dgAlSgVOB
					gAgA6dgAlSgVOBgAgA6dgAlSgVOBgAgA6dgAlSgVOBgAgA6dgAlSgVOBgAgA6dgAlSgVOBgAgA6dgAlSgVOBgAgA6dgAlSgVOBgAgA6dgAlSgVOBgAgA6dgA
					lSgUN1gAgA6VgAlNf/KxgAgA37gAlAfkHIgAgA0GgAk7fbGDgAgAytgAk7fbGDgAgAytgAk7fbGDgAgAyt]],
				Head = [[
					gAlWfSADgAgAhXgAlNfGACgAgAe3gAk1etAvgAgAZTgAkeebCAgAgAU6gAkjeeBvgAgAVrgAlYfcAOgBftjlgAlrgWDxgUfRvAgAlsgfD7fWhhvOgAlsgfEm
					gNflwegAlsgfE4gle4w6gAlsgfD9fZhZvTgAlsgfEbgAgAwNgAlsgfE/gtepxDgAlsgfECffhKvdgAlsgfERfzgbv8gAlsgfFCgxeixIgAlsgfEJfog1vrgA
					lsgeD/fpg0vagAlogDCPgTfArpgAlcfeAPgAgFjxgAlWfSADgAgAhXgAlWfSADgAgAhXgAlWfSADgAgAhX]],
				Jaw = [[
					gAlqes/9gAgAhZgAlbee/tgAgAkMgAk0eC+RgAgAqWgAkSdx8OgAgAvDgAkYd08pgAgAuPgBlye5/tf7gTkQgCmWgO/+fZghfZf8mXgY/8hVfBg0gBmYgc/+
					fngRfZgDmYgd/8e8gse4f8mXgY/8hPfGgvgAmXgb//gAgAfugEmYge/7eug1etf9mXgZ/9hBfQgkf/mXga//gZfvgCgEmXge/6eng5enf+mXgZ/+gvfegUf+
					mXgX/+gufegWgCmQfx/+fYg1fpgAl2e7/+gBf7hLgAlqes/9gAgAhZgAlqes/9gAgAhZgAlqes/9gAgAhZ]],
				Crest = [[
					gAnyfNXMgAgA+wgAnmeoU0gAgA9+gAm6dcPvgAgA7jgAmIcoL/gAgA49gAmRcwMogAgA5dgAnzfraDfuf6/bgAnSiLnIfYfh/Lf/nRiXmZhRhF/TgAnGifo0
					fpfs+wgAnCiipsfDfK+df/nQiXmjhKg//RgAnIidoSgAgA+5gBnAijp+e3e/+XgAnPiYm2g9g1/OgAnLibnwgXgU/CgBm/ijqHexe6+TgAnNianQgsgm/JgA
					nPiWm7grgl/OgAnnhejNfHfc/0gAn3fwZwgEgC/XgAnyfNXMgAgA+wgAnyfNXMgAgA+wgAnyfNXMgAgA+w]],
				["Humerus.L"] = [[
					e/j9fzX0M5gA4Ue/j3fvX6Nlg642e/jpflX4Pai159e/jdfeXkRMkM6ve/jffgXoQ3j96ne/j+f2XuNcd34me/kPgJWhNlX129e/kRgNWQN6W02ue/kRgNWQ
					N6W02ue/kRgNWQN6W02ue/kRgNWQN6W02ue/kRgNWQN6W02ue/kRgNWQN6W02ue/kRgNWQN6W02ue/kRgNWQN6W02ue/kRgNWQN6W02ue/kRgNWQN6W02ue/
					kRgMWTN2W/2xe/kLgDXANGZ/3ae/kBf3XqMzed4Ie/j9fzX0M5gA4Ue/j9fzX0M5gA4Ue/j9fzX0M5gA4U]],
				["Forearm.L"] = [[
					dYkqgEYEMJgA3ydYkggGYhMshS4WdbkOgLZYOUj85hdgkBgPZ6QAl06ZdfkDgPZ1Pslg6Pdek0gLX+Mod84EdzlhgcV0NiWz2Od4lnggVcOAVr18d4lnggVc
					OAVr18d4lnggVcOAVr18d4lnggVcOAVr18d4lnggVcOAVr18d4lnggVcOAVr18d4lnggVcOAVr18d4lnggVcOAVr18d4lnggVcOAVr18d4lnggVcOAVr18d3
					lmggVgN7V31/dplTgTWhMyZP2wdbk0gHXtMHeQ3ldYkqgEYEMJgA3ydYkqgEYEMJgA3ydYkqgEYEMJgA3y]],
				["WingFinger1.L"] = [[
					bxlTgQaQLmgA39bwlDgYbJMIhr4ibzkjgtdGN4lF5sb8kQg/enPvnZ6gb6kTg8eWPZnB6Xb8lmgbaEMAd04Jcum3gqWkNhVE1vc6nCgxWCOKTu1Uc6nCgxWC
					OKTu1Uc6nCgxWCOKTu1Uc6nCgxWCOKTu1Uc6nCgxWCOKTu1Uc6nCgxWCOKTu1Uc6nCgxWCOKTu1Uc6nCgxWCOKTu1Uc6nCgxWCOKTu1Uc6nCgxWCOKTu1Uc4
					nBgwWHODT81ZcYmegeXoMfX+2hb4lmgRZnLkd83rbxlTgQaQLmgA39bxlTgQaQLmgA39bxlTgQaQLmgA39]],
				["WingFinger2.L"] = [[
					aJlwgdeKLYgA4YaGlVgsfVMIh44/aMkfhSh8Odln6Faej+hzj/Q1oC6saakDhtjoQYnp6maYmOgrd1Lldo4abuoOg7ZKMsTv1ScDofhFXlOIRC0OcDofhFYT
					NeSA0ncDofhFYkNPSY0vcDofhFXoOGRG0QcDofhFYINnRy0hcDofhFYpNLSg0ycDofhFXuOARN0TcDofhFX+NxRk0ccDofhFYsNISk0zcDofhFX1N5RY0Xb/
					ochDX9NxRo0ebInograxLmXP2baUmQgddMLKdn3/aJlwgdeKLYgA4YaJlwgdeKLYgA4YaJlwgdeKLYgA4Y]],
				["WingFinger3.L"] = [[
					Ynl5guiBL0gA4uYklRhDjeM5iJ5VY1kCh5mtQEmT6KZVjRinpRTLo46WZOjZifo0Smof6VY3mig9hlLxdc4maupZhNbnMQSL0kbVp0hdYuOfN/yabNpxhaaW
					NLQCzhbKpvhZa9MuQ1z5bUp0hdY0OZOHyfbPpxhbZ+NcPkzTbKpuhZbKMlRF0AbTp0hcZBOPOXyobQpyhbZnNvPHzDbJpuhZbRMhRO0EbSpzhcZSOAOsy1bN
					pwhaZdN2O/zAZ4oig4d4LMWZ2NYzmngqguLTdN4OYnl5guiBL0gA4uYnl5guiBL0gA4uYnl5guiBL0gA4u]],
				["Humerus.R"] = [[
					hBj9fzX0zHgA4UhBj3fvX6ybfG42hBjpflX4wmdL59hBjdfeXku0b06vhBjffgXovJcD6nhBj+f2XuykiJ4mhBkPgJWhyboL29hBkRgNWQyGpM2uhBkRgNWQ
					yGpM2uhBkRgNWQyGpM2uhBkRgNWQyGpM2uhBkRgNWQyGpM2uhBkRgNWQyGpM2uhBkRgNWQyGpM2uhBkRgNWQyGpM2uhBkRgNWQyGpM2uhBkRgNWQyGpM2uhB
					kRgMWTyKpB2xhBkLgDXAy6mB3ahBkBf3XqzNhj4IhBj9fzX0zHgA4UhBj9fzX0zHgA4UhBj9fzX0zHgA4U]],
				["Forearm.R"] = [[
					iokqgEYEz3gA3yiokggGYhzUeu4WilkOgLZYxscE5higkBgPZ6wAaM6ZihkDgPZ1wUag6Piik0gLX+zYiE4EiNlhgcV0yepN2OiIlnggVcyAqV18iIlnggVc
					yAqV18iIlnggVcyAqV18iIlnggVcyAqV18iIlnggVcyAqV18iIlnggVcyAqV18iIlnggVcyAqV18iIlnggVcyAqV18iIlnggVcyAqV18iIlnggVcyAqV18iJ
					lmggVgyFqJ1/iXlTgTWhzOmx2wilk0gHXtz5hw3liokqgEYEz3gA3yiokqgEYEz3gA3yiokqgEYEz3gA3y]],
				["WingFinger1.R"] = [[
					kPlTgQaQ0agA39kQlDgYbJz4eV4ikNkjgtdGyIa75skEkQg/enwRYn6gkGkTg8eWwnY/6XkElmgbaE0AiM4JjSm3gqWkyfq81vjGnCgxWCx2sS1UjGnCgxWC
					x2sS1UjGnCgxWCx2sS1UjGnCgxWCx2sS1UjGnCgxWCx2sS1UjGnCgxWCx2sS1UjGnCgxWCx2sS1UjGnCgxWCx2sS1UjGnCgxWCx2sS1UjGnCgxWCx2sS1UjI
					nBgwWHx9sE1ZjomegeXozhoC2hkIlmgRZn0ciE3rkPlTgQaQ0agA39kPlTgQaQ0agA39kPlTgQaQ0agA39]],
				["WingFinger2.R"] = [[
					l3lwgdeK0ogA4Yl6lVgsfVz4eI4/l0kfhSh8xjaZ6Flij+hzj/vLX+6slmkDhtjovoYX6mlomOgrd10biY4akSoOg7ZKzUsR1Sj9ofhFXlx4u+0Oj9ofhFYT
					yiuA0nj9ofhFYkyxto0vj9ofhFXox6u60Qj9ofhFYIyZuO0hj9ofhFYpy1tg0yj9ofhFXuyAuz0Tj9ofhFX+yPuc0cj9ofhFYsy4tc0zj9ofhFX1yHuo0XkB
					ochDX9yPuY0ek4nograx0aox2blsmQgddM02iZ3/l3lwgdeK0ogA4Yl3lwgdeK0ogA4Yl3lwgdeK0ogA4Y]],
				["WingFinger3.R"] = [[
					nZl5guiB0MgA4unclRhDjezHd35VnLkCh5mtv8Zt6KmrjRinpRs1XI6WmyjZifo0taXh6VnJmig9hl0Pik4mlSpZhNbnzwt10kkrp0hdYuxhyByakzpxhaaW
					y1v+zhk2pvhZa9zSvLz5ksp0hdY0xnx5yfkxpxhbZ+ykwczTk2puhZbKzbu70Aktp0hcZBxxxpyokwpyhbZnyRw5zDk3puhZbRzfuy0EkupzhcZSyAxUy1kz
					pwhaZdyKxBzAmIoig4d400pn2NnNmngqgu0tiz4OnZl5guiB0MgA4unZl5guiB0MgA4unZl5guiB0MgA4u]],
				Tail1 = [[
					gAifgij6gAgA/wgAicgijFgAgA/1gAiTgihNgAgA/+gAiMgifsgAgA//gAiNgif9gAgA//gAiegiipfzgC/4gAiqgijbfegF/zgAirgijWhGf2/zgAirgijX
					fsgD/0gAirgijXfLgI/zgAirgijXhAf3/zgAirgijXgAgA/0gAirgijXfAgJ/zgAirgijXg1f4/zgAirgijXgUf9/0gAirgijWe6gK/zgAirgijXgmf7/zgA
					irgijXglf7/zgAingijkfUgG/ygAihgij1gDgA/wgAifgij6gAgA/wgAifgij6gAgA/wgAifgij6gAgA/w]],
				Fire1 = [[
					gAiRhobTkngs/TgAiRhpVCgkf++DgAiQhqURb0gW9dgAiQhqY2b+fu+6gAiQhqdWg0gL/3f/iVhpdTkbhA/jf+idhpXkimf++vgFifhpU3e5ge99f/ifhpZF
					a0fk+zf8ifhpfVdUff/3gEifhpgSkLg9/tgAifhpawkngn/Nf8ifhpVTfmfr+JgEifhpWScngS+SgBifhpcbcWfS/kf7ifhpgvfsgV/+gDifhpeClNhI/fgD
					ifhpXhjrgO+nf9iahpVDdLf597gAiThoZibLfk+9gAiRhof4eLfd/7gAiRhog0jJhE/zgAiRhobTkngs/T]],
				Fire2 = [[
					gTilincboJiN+pgCi8idQZk0gP7gfvi+iZLvbgfF4UfwiuilR2XpeY7ZgDibitcIdtey/pgRihiqfbl/hn/YgIjAijWGnThO9ggAjLicNfhGgC6Efqi8ijQN
					YRd86ofxiiisa5ZEdU+sgWieirhfjagQ/xgTi1inb5oMiE+lf6jKieQoj6f07xf2jGifNZcSfQ5vfyiuiqVDYLdi86f6icitfkcwek/ygYioipgKmwhu/OgR
					jBiiWGoWhh9NfyjFicNrfmfC6MftiuikQkYmeA69f4iRisbXZ7dU+8gNiOiriCiZgY/1gTilincboJiN+p]],
				Fire3 = [[
					gzi2jheFoQhx+zgTj2i+RCo+hh6xfjkBikHMfed50FfUjjjFKEXQb01Kf6isjvVqZwcI9Xgqiljqe7kIf0/tgjjojTYNpjiJ9cgDkMizLal5gn3wfTj2i+JP
					ahb11YfWi5jmSeWyaN63gliYjtd0gGdl/0gzjIjgdioSho+wgJkDjARNoGhJ7KfrkGizIjgNed1sfYjbjWMlYCbB3nfsiejwZAZJbR+Fg0ipjnfok7f4/mgw
					jqjQYQqliX9FfzkGizLjkgfh4LfWjnjBJga0cA1xfhinjpSyXnaZ7UgYiFjuedfIdi/2gzi2jheFoQhx+z]],
				["UpperLeg.L"] = [[
					fPiFgZ5RaZgAyzfPiBga6GZuffxafPh4gc7RYjeou6fPhwge75XweCtKfPhxge7zX5eJtdfPiEgY5baTf4ykfPiRgU2ecWhP2cfPiTgU2bcZhO2gfPiTgU2b
					cZhO2gfPiTgU2bcZhO2gfPiTgU2bcZhO2gfPiTgU2bcZhO2gfPiTgU2bcZhO2gfPiTgU2bcZhO2gfPiTgU2bcZhO2gfPiTgU2bcZhO2gfPiTgU2bcZhO2gfP
					iTgU2bcZhP2ffPiOgW2mcOhQ2TfPiHgY4pa3gWzvfPiFgZ5RaZgAyzfPiFgZ5RaZgAyzfPiFgZ5RaZgAyz]],
				["LowerLeg.L"] = [[
					fEhQgHzmgAgA5SfChOgDyRgfgd6Qe/hLf8wOhMhN7he9hJf5vDhmhs8Je+hJf6vPhihm8DfDhQgGzLgJgD5nfJhZgU2re1e02gfKhagT2ne3e02kfKhagT2n
					e3e02kfKhagT2ne3e02kfKhagT2ne3e02kfKhagT2ne3e02kfKhagT2ne3e02kfKhagT2ne3e02kfKhagT2ne3e02kfKhagT2ne3e02kfKhagT2ne3e02kfJ
					hagT2oe3e02jfJhVgU2zeve02XfFhRgL0dfqfr4lfEhQgHzmgAgA5SfEhQgHzmgAgA5SfEhQgHzmgAgA5S]],
				["Foot.L"] = [[
					fEgigT/PgAgAm3fEgigT/Pgnf3m3fEgigT/Nhmfqm3fEgigT/LiLfim2fEgigT/LiFfjm2fEgigT/PgJf+m3fEgqgT+nedgLpIfFgsgT+eeggIpofFgsgT+e
					eggIpofFgsgT+eeggIpofFgsgT+eeggIpofFgsgT+eeggIpofFgsgT+eeggIpofFgsgT+eeggIpofFgsgT+eeggIpofFgsgT+eeggIpofFgsgT+eeggIpofF
					grgT+feggJpjfEgmgT+6eYgRoGfEgigT/PfkgGm3fEgigT/PgAgAm3fEgigT/PgAgAm3fEgigT/PgAgAm3]],
				["UpperLeg.R"] = [[
					gxiFgZ5RlngAyzgxiBga6GmSghxagxh4gc7RndhYu6gxhwge75oQh+tKgxhxge7zoHh3tdgxiEgY5bltgIykgxiRgU2ejqex2cgxiTgU2bjney2ggxiTgU2b
					jney2ggxiTgU2bjney2ggxiTgU2bjney2ggxiTgU2bjney2ggxiTgU2bjney2ggxiTgU2bjney2ggxiTgU2bjney2ggxiTgU2bjney2ggxiTgU2bjney2ggx
					iTgU2bjnex2fgxiOgW2mjyew2TgxiHgY4plJfqzvgxiFgZ5RlngAyzgxiFgZ5RlngAyzgxiFgZ5RlngAyz]],
				["LowerLeg.R"] = [[
					g8hQgHzmgAgA5Sg+hOgDyRfhfj6QhBhLf8wOe0ez7hhDhJf5vDeaeU8JhChJf6vPeeea8Dg9hQgGzLf3f95ng3hZgU2rhLhM2gg2hagT2nhJhM2kg2hagT2n
					hJhM2kg2hagT2nhJhM2kg2hagT2nhJhM2kg2hagT2nhJhM2kg2hagT2nhJhM2kg2hagT2nhJhM2kg2hagT2nhJhM2kg2hagT2nhJhM2kg2hagT2nhJhM2kg3
					hagT2ohJhM2jg3hVgU2zhRhM2Xg7hRgL0dgWgV4lg8hQgHzmgAgA5Sg8hQgHzmgAgA5Sg8hQgHzmgAgA5S]],
				["Foot.R"] = [[
					g8gigT/PgAgAm3g8gigT/PfZgJm3g8gigT/NeagWm3g8gigT/Ld1gem2g8gigT/Ld7gdm2g8gigT/Pf3gCm3g8gqgT+nhjf1pIg7gsgT+ehgf4pog7gsgT+e
					hgf4pog7gsgT+ehgf4pog7gsgT+ehgf4pog7gsgT+ehgf4pog7gsgT+ehgf4pog7gsgT+ehgf4pog7gsgT+ehgf4pog7gsgT+ehgf4pog7gsgT+ehgf4pog7
					grgT+fhgf3pjg8gmgT+6hofvoGg8gigT/Pgcf6m3g8gigT/PgAgAm3g8gigT/PgAgAm3g8gigT/PgAgAm3]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAifgiECgAgAvggAicgiD8gcgzvUgAiIgiDUhIhzt/gAi+giEQhBh3vxgAjwgiEtgmhLwogAkGgiE4gAgAw8gAj8giE0fbe1wzgAjWgiEhfBeHwOgAiOgiDh
					e6eMuZgAiJgiDUfUe5uEgAiOgiDdgAgAubgAjWgiEegnhLwPgAj8giE2g8h6wxgAkGgiE7g8h6w6gAjwgiEtgmhLwogAi+giEMgAgAvzgAiIgiDSfUe5uBgA
					icgiD/e9eKvSgAifgiEEfLegvfgAifgiECf0frvggAifgiECgAgAvg]],
				Spine = [[
					gAjOgEFPgAgAxgf+jLgEFIgggwxUf8i0gAEahQhuwDf8jugGFehJhyxwf+khgIGAgrhIylgAk3gJGLgAgAy4gCkugJGHfVe4yvgEkGgHFxe5eMyMgEi7gBEp
					exeRwcgCi1gAEafPe8wIgAi7gBElgAgAwef+kGgHFvgshHyNf8kugJGJhFh1ytf8k3gKGPhEh1y1f+khgIGAgrhIylgAjugFFbgAgAxygCi0gAEYfOe8wEgE
					jLgEFLe1ePxSgDjOgFFRfEekxfgBjOgEFPfzfsxggAjOgEFPgAgAxg]],
				Neck1 = [[
					gAj9fwGDgAgAytf9j6fvF4gigvycf5jgfnEyhThswqf5kdfyGchPhuzGf8lSf4HUgwhF0TgAlof6HqgAgA0vgElef5HhfQe70igHk2f1G7eyeRzvgHjofpFI
					eueUxNgEjhfnEyfNe9wwgAjofpFEgAgAxQf8k2f1G4gwhFzwf5lef5HjhNhw0hf5lof6HthNhw0sf8lSf4HUgwhF0TgAkdfyGYgAgAzJgEjgfmEvfNe9wrgH
					j6fvF7eweSyagFj9fwGGfAenyrgBj9fwGDfyftytgAj9fwGDgAgAyt]],
				Neck2 = [[
					gAkhfkGDgAgAytf8kdfiF1gigvyXf4kBfWEZhQhuwBf4lBfoGkhQhuzRf7l2fxHygxhE03gAmNf0IRgAgA1cgFmDfzIEfPe81LgIlaftHOeweS0HgIkKfaE2
					eweSwwgFkDfWEbfPe8wJgAkKfZEygAgAwzf7lafsHMgxhE0If4mDfzIGhQhu1Jf4mNf0IUhQhu1Zf7l2fxHygxhE03gAlBfnGggAgAzUgFkBfWEXfPe8wCgI
					kdfjF4exeSyVgHkhfkGGfAenyrgBkhfkGDfyftytgAkhfkGDgAgAyt]],
				Neck3 = [[
					gAk7fbGDgAgAytf8k3fZFxgigvySf2kafIEChNhwvXf3lcfgGshQhtzcf7mSftIRgzhD1ZgAmpfxI5gAgA2HgFmffvIofNe91zgJl2fnHheveT0egKkjfNEk
					eyeRwTgGkbfIEEfQe7vigAkjfNEggAgAwVf6l2fnHfgyhD0gf3mffwIqhThs1xf3mpfyI8hThr2Ef7mSftIRgzhD1ZgAlcfgGogAgAzfgGkafID/fQe7vZgJ
					k3fZF0exeSyQgIk7fcGGfAenyrgCk7fbGDfyftytgAk7fbGDgAgAyt]],
				Head = [[
					gAlWfSADgAgAhXf7lRfPAFedhAg5f0kxe5Abcaiuduf2l3fZAZcaiKijf6mtfqAgdzhKk6gAnFfwAjgAgAlxgGm7ftAliMe5lcgKmRfiAhjkeAj4gLk8fAAW
					jndaeygHkze6AOiPeVdugAk7e/ADgAgAehf6mRfiAWdyhPjvf3m7fuAwcehzlkf3nFfwA1cfhwl+f6mtfqAgdzhKk6gAl3fYAGgAgAiVgHkxe5APiPeUdkgL
					lRfQAVjndrhGgJlWfTAPi8eKhhgClWfSADgpfmhYgAlWfSADgAgAhX]],
				Jaw = [[
					gAlqes/9gAgAhZf3lkeo/Chwfdnjfqk7eQ87kUers6fsmNe1+lkHfNoYf0nKfJ/TidfrmIgAnjfR/jgAgAlTgMnYfO/ZdkgTlmgTmqfA+7b+gqnGgVlJeY9W
					bvhNr8gNk+eQ9GdVg0s+gAlJeW9igAgAsSf0mre//DigfmnSftnXfP/Rj8fhlbfunifS/Wj6fklBf0nKfJ/TidfrmIgAmOe0+ygAgAosgNk8eP9CdVg1tIgU
					lkeq+Kb0g9pxgQlqet+zcqg5n5gElqes/wfUgTjvgAlqes/9gAgAhZ]],
				Crest = [[
					gAnyfNXMgAgA+wfsnsfFVXgYhz+HfNnDeUSqhRkV8ufSoPfhZshFkD/FflpFgHczgkib/ugApcgVbhgAgA/rgbpRgQZJfzdj/Jgsoof3Ycfab9+0gynQekWE
					ehb0+FggnIeSVxe8db+LgAnUeeUfgAgA92fkorf0XegUih+ufVpOgSaHgbj8/MfWpYgZdGgtj3/nflpFgHczgkib/ugAoTfcYHgAgA/AggnGeQRufSdT8fgv
					npfKVyfHbz+AgmnvfQYafEcr+4gInxfNXxf0fS+6gAnyfNXMgAgA+w]],
				["Humerus.L"] = [[
					e/j9fzbGQoht7ke9j6f1TlP9W229e6jhfyPqP3V9z3e6kdf+VbNzZV3Je8lRgAXxMvZ83Ze/lof9UlOEVe1cfDlff3RxQCRZyxfGk3fwSzOKStyzfGjofkVX
					KkY90BfDjhfkWOKabE05e/jpfsStNMXI0Ve8k2f9QVRQTDzze6ldgFRuQ8UZ1Ze6lngGWZOGYl3ke8lRgAXxMvZ83Ze/kdf1TtNpWO09fDjgfkP+OqTDxQfG
					j6fpSLNuTUyWfFj9fsXNLnZu2JfAj9fxaNOrfU6Qe/j9fzbGQoht7k]],
				["Forearm.L"] = [[
					dgkWgqcGa/lp+1eElagLU3XHUG6DeXlNfvQKWBQp05dslugNUmUZU+5OdjmWgQWsTWV85/eFnIgKU2UtRE3aevnOgDTWWfMv0Cejmif0UEUhOB0od4k5fWVA
					QmUO27dqkmfZVPQZWb36eFlJfnSyTaSJ2UeomlgIReXsOJ0meXnIgXSUXmPv2Xdsm3gcVqU3Uf5rdjmWgQWsTWV85/eFl+f6T4UGRj27evlPfaRbUnNxyrej
					llfmTYT7Oa0NdtlFfwXFSRWw54ddkigZanXjhA+XdgkWgqcGa/lp+1]],
				["WingFinger1.L"] = [[
					c5kqiRe8pVng9pdvmwhOcmcLWC99efm3gSWcYBRP5fdInJhDYmZ2TY7xcwnmhKZ0ZvT48QdvomhCabYRRL6se7otg7aaWpO14seeoFgoaiV4Pm47dHmXf3ZC
					VmS76Xcvl/f6YTWXUD6+dvmwgOYDW+R76Fe7oHg6YmYUPs5XefoohOZBZiQg6UdIoNhZZwaYTI8DcwnmhKZ0ZvT48QdvnggqZVXqRg6ce7m4f/X/U/P24Bee
					nLgTZsVVP94vcymTglbeZAWV9VcjlEhyeAjpiF/pc5kqiRe8pVng9p]],
				["WingFinger2.L"] = [[
					dyk/jrg9p/kO+FddnOi2hoaIUx9UeRoEhea6VBQ95gc3oFicaTZMRG63caocimamZ1RJ7HdVpeicdpWlP453eeptiPfkS3Pd4Bd7pFh5fAS7Ps4McgnbhDbE
					U+Q65fcLnEhHZaWTRY56dVn3hdbUVLQz5jerpJiPdzUiP+5GeRpliodeWkP854c3pCi3bbZ0Q17FcaocimamZ1RJ7HdVogh/ckV7QS5veeoHhEdLRSQ232d7
					oRhgeMSZQJ4JcPm+iEdiYlUG8pc7lTjcfyj3fL/vdyk/jrg9p/kO+F]],
				["WingFinger3.L"] = [[
					eulCk8i5q6g997c4nRkTnPY5UN79dpo+ilgKS2RT5Lcko3jxbvY4Ox5ocJpKj9a0aKOT5ectqIjuhEVcO140dhqZjSlmQIRS23dAp0i7kIQ0Qj3Lb3oViLc3
					UtO04SbtoBiQaAWgOj4Vctovime1T8P34zd6p4jZkARyRV4SdpqQj5iqUXQE5CckpskPc0ZmOf5ycJpKj9a0aKOT5ectpQjNgCUvPS41dhpAh9jTOvS83UdA
					pEifjWQTRE3TbrndjcfYYfR27rdTlUk9hYkVcT/ceulCk8i5q6g997]],
				["Humerus.R"] = [[
					hBj9fzbGvYeT7kg+j6fuUIxWp12Bg6jgfhRXy2r2xtg6keftWW1EoF0hg9lSf1YK1Em41thBlof9Ulx8qi1chElegBQvuftQ0HhGk2gBRSvTrT1GhGjpf1UU
					ygly2nhEjifvVrzvkT2jhBjpfsSty0o40Vg9k2fzRYwQuSyeg6lff0TMxltqzEg6lpf1XO0uo805g9lSf1YK1Em41thBkdf1TtyXpy09hEjhfvO0vvrwyghG
					j6f6Qlvrqy0lhFj9f6Wlx5lT4NhCj9f0aMwtgj6phBj9fzbGvYeT7k]],
				["Forearm.R"] = [[
					igkWgqcGlBaX+1h5lZf9VkqXsg5ghdlLfUSes4xBzniIlvfnWIu1sh3ciWmYf3Xdurq94zh7nIgKU2rTu83ahYnMgQR5n9yB05hpmhgOR4ovwG2FiUk7f8TY
					sJqd4pidkpfyUXtio35Ch7lJfnSysmt32UhRmmf6S9p6zFzxhdnKf8UfrHyO03iIm7f2XHuStI31iWmYf3Xdurq94zh7l+f6T4r6ud27hYlQfoP5ptxJzYhp
					lmgBRIpSvz1mialFgRWJq3oP7Nikkiggaonwe4+jigkWgqcGlBaX+1]],
				["WingFinger1.R"] = [[
					jHkqiRe8WrYg9piWmwg+dLliqI9thim0f4YkrZvj4bi5nKgRaUpwtl6rjRnpgoayohsy7kiRomhCabnvu16shFoshHZHnXwe5ghhoDhCYfmyvX6Ki4mbgpXQ
					mxsU7YjQmCgcXRnWrh7liRmwgOYDpCuF6FhFoHgvZ6ptw+4khiorg0bCpzwn5Ci5oSgobbpMt+65jRnpgoayohsy7kiRnggqZVoWug6chFm5gKWno9vq4shh
					nMgtXmnTvI55jJmThRadjzpI96jZlEh8eDbod4/jjHkqiRe8WrYg9p]],
				["WingFinger2.R"] = [[
					iOk/jrg9WBby+FiznOijiRnirG89iFoBg9dGuVvP4CjgoHhjcTqSvn5sj1ofiAbyoWvc6airpeicdppbwI53hVprieeUrJwR5IhvpEiZc9pxv450jJngh8ZA
					nhuk6kjmnIhuYKnguQ6girn3hdbUq1vN5jhipKiAfEtewR4AiFpoiHfgsvwl4NjgpHh+dYpowB50j1ofiAbyoWvc6airogh/ckqFvu5vhVoIhTb0stvF42hv
					oSiAcFqTvi5tjWm+i1cRkUrk9Ri8lTjlfxbag0/piOk/jrg9WBby+F]],
				["WingFinger3.R"] = [[
					hSlCk8i5VGfD97jinRj7n6orrW7hjAo5h4iRwXuN3bkJo5iweCqdxu4akTpOjTcPn4yQ4yjTqIjuhEqkxL40iGqXjqkgt7u94NiXpyjpiKr9vs5FjcoajLag
					n9w45Zj3oFi7YhncxH45jTovime1sEwJ4zifp6jBlIwLuZ2+jAqUjMkmu4vw3FkJpzjPfDptyJ4ekTpOjTcPn4yQ4yjTpQjNgCrRwu41iGpCiUiEvVtg4iiX
					pFjNhTsfvS5JjnndkTd3kguB8UiglUlFhSa9jv/VhSlCk8i5VGfD97]],
				Tail1 = [[
					gAifgij6gAgA/wgAicgijrjEfn/ogAiIgiiNlue//YgAi+gikOjTfo/igAjwgilNfBgF/jgAkGgilhcHgS/RgAj8gilXcagR/VgAjWgikxfGgG/ngAiOgiis
					hlfw/1gAiJgiiUh1fs/2gAiOgiitgAgA/4gAjWgikweKgL/lgAj8gilZeagI/fgAkGgiljg6f8/fgAjwgilLjmft/XgAi+gikNj4fk/egAiIgiiPg+f1/5gA
					icgijrctgb/mgAifgij3bUgl/ZgAifgij6ewgK/ugAifgij6gAgA/w]],
				Fire1 = [[
					gAiRhobTkngs/TgOiPhnVbi7g/+CgZiAhlWThDhR+cgPiuhnfHgjfZ/+f8jbhniWhthD/2fvjwhkc5gwgK/1fwjnhlXFcqer+gf8jDhnYoaffd+ogHiFhpdm
					eyfX/3gIiBhpfikmgp/pgAiFhpaHkogh/Gf4jDhnWbeRfW+df5jnhmZRZ3fI+pgEjwhmgfeLfM/7gQjchlicmQhF/QgRiuhmbvoYhW+jgEiBhpUBg9gR9pfx
					iPhnXqYMfC93friRhle+YjfG/Ff6iRhohCheg//7gAiRhobTkngs/T]],
				Fire2 = [[
					gTilincboJiN+pgYi5icQKmnhn68gcioidNSfFhp54gRiyirZIcCd4+6gDjSiqjNgigF/0fyj9ind0kQh//kfkkMidRrg6ea8ifmjiigPbZddw6egCiPisXx
					aQdw+SgciEiqgTjWfu/0gTieimbRoOh5+ffyjqifRCiYfT8KfhkDigQAY+dO6pf8juiqalZ2dE+xgqjSijjLlGf//bgyjBiedCrziw9dgIiwiaO3k1gY6kfT
					ixiaOwXbcs5UfNiWiiZkUccM83gBiMish5gQgE/7gTilincboJiN+p]],
				Fire3 = [[
					gzi2jheEoQhx+zgsj0i4Qbq6i55jgVjoiyHkhmhN0jgDjPjnQDaJb/6zgGjEjtfDdOc3/sgDkHjpfhkXhw/pfrlCjGRolVf98FfUkei6JhdBcT2QftiyjjPC
					Yfbd5pgqiCjtb6fwdM/mgzizjec6oUhd+sf8kijEREmzgw7cfOk/i7KDcqbu2oflkHjmRgYZab66hAjFjjephwdZ/zhgjRjPenr7iH9lgYjti0PFpRhe5ee+
					jvitJIbRar1Meji1jPRSTpYH4UgCiEjwdyc0c9/mgzi2jheFoQhx+z]],
				["UpperLeg.L"] = [[
					fPiFgZ5RaZgAyzfPiCgc6Jade4xifPhtgi8UY1bysWfPikgf5VcPeyzIfPjWgb3PdFgg1yfPjsgW2pcPhX2PfQjjgT2GbSiO2ifRi8gR1yalit2ofRhzgV69
					XPgSu1fQhtgY7pXLfMtcfPhzgb7jYUeTuNfPi8gc3Vc/gf1rfPjigd3gdsf+1lfPjsgd3eduf+1nfPjWgb3PdFgg1yfPikgY4tazgUzpfQhsgY7tXGfItPfR
					iCgT5IYqhTyWfRiFgU4nZVhWzRfQiFgY5JaKgSy5fPiFgZ5RaZgAyz]],
				["LowerLeg.L"] = [[
					fEhQgHzlgAgA5SfBhPgFzChMf+5se4hKf8vuj9he7ifDhugP1hhcep3lfJidgX3XfveF1xfKi0gV23eye72UfKiqgT2bdxfv2tfKiDgS2MdCgN22fDhGf0tQ
					fche9EfBhFfzstgghf9Ue+hJf5u9hihP8NfJiDgX3dfreE1qfJipgY3jgZdk1gfJizgY3hgadk1jfJidgX3XfveF1xfFhugK0bfsfu4ofBhEfyshgjhg9ZfG
					hNgAxReghG63fGhPgEysefgv56fEhQgHzZfrgK5cfEhQgHzmgAgA5S]],
				["Foot.L"] = [[
					fEgigT/PgAgAm3fEgigT/OhBfym3fEgigT++kIfGmzfEhAgT+2gvfzoafEhvgU9vfKgGrxfFiFgT9LekgUtCfFh7gT9Sd2gmsrfEhVgT+NdYgvqLfEgigT/P
					gMf9m3fEgigT/OhJfwm3fEgigT/Mh6flm2fEhUgT+Xe/gOqBfFh7gU9ffpf4sZfFiEgU9Sftf1s3fEhvgU9vfKgGrxfEhAgT+3fngHoafEgigT/OhMfvm3fE
					gigT/PfMgLm3fEgigT/OfBgOm3fEgigT/PfzgDm3fEgigT/PgAgAm3]],
				["UpperLeg.R"] = [[
					gxiFgZ5RlngAyzgwiCgX5mmpfsx/gvhsgV7dpTgEthgvikgS3xmgeE0TgwjWgT2Ikwdz2ggxjsgW2pjxep2Pgxjigb3Ni4fg11gxi7ge3picgD1agxh0gi76
					mijptugxhugg8LnhjYsugxhzgb7jnshtuNgwi8gU2Lk3d12bgvjjgQ1vlSdR2tgvjtgQ1ulPdQ2ugwjWgT2Ikwdz2ggxikgY4tlNfszpgxhtgg8Onnjcshgx
					iCgg6bkxiDxRgxiFge5wkfhSyZgxiFga5YlYgSytgxiFgZ5RlngAyz]],
				["LowerLeg.R"] = [[
					g8hQgHzlgAgA5Sg8hOgCx9gafW6eg9hDfxrygSeh9sg4htgHzfiLfT5Qg2iegT2diRgR2rg2i0gV23hOhF2Ug3iqgX3UgPh710g3iDgY3uftid1VhHhMf/wv
					cdfC7BhGhJf6vHc4ek7/hChJf5u9eeex8Ng2iDgT2hiWgT2mg2irgS2Hi2fw28g2i0gR2Gi0fv29g2iegT2diRgR2rg7hugK0bgUgS4ohHhJf6u9c1eg8DhA
					hQgJzydxgh5Cg+hRgL0kejgy4cg9hQgIzzfrgK5Ig8hQgHzmgAgA5S]],
				["Foot.R"] = [[
					g8gigT/PgAgAm3g8gigT/PgEf/m3g8gigT/PfkgGm3g8hAgT+0hofkoZg7hvgT9liMfar9g7iFgT9LhcfstCg7h7gU9dgyf9scg8hUgT+Ygof6qBg8gigT/D
					cegym0g8gigT/Ecngwm1g8gigT/MeGgbm2g8hVgT+QiQfZqHg7h8gT9NimfPsxg7iGgT8/ilfPtRg7hvgT9liMfar9g8hAgT+3gZf5oag8gigT/Dcigxm0g8
					gigT/MeTgYm2g8gigT/OfFgNm3g8gigT/PfzgDm3g8gigT/PgAgAm3]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAifgiECgAgAvggAifg4FQgAgAxigAifhGGHgAgAyygAifhDF4gCgFydgAifg7Fcf1fnx0gAifgzFBfIeLxEgAifguEtfPefwlgAifgsEmf3fuwfgAifgpEY
					gHgNwIgAifgfDVgFgJuKgAiegTBrgUgYqJgAicgFAagtgnk6gAibf4ADhKguf6gAiafwAOhdgucugAiafvAShggtcRgAiafyAJhXgudqgAiafzAIhWgud7gA
					iafvAQhegucigAiZfuAThhgtcHgAiZfuAThhgtcHgAiZfuAThhgtcHgAiZfuAThhgtcHgAiZfuAThhgtcH]],
				Spine = [[
					gAjOgEFPgAgAxggAjSgiGmgAgAzcgAjUg1HjgAgA0ogAjUgwHTgCgE0UgBjTgmG0fzfoztgEjRgcGWe/eQy/gDjRgUF/fIejyigBjQgSF4f1fuycgAjQgNFo
					gIgMyGgAjLf+EcgGgIwOf/i/fmCfgWgXsVf+itfQA2gwgknNf+iafBAIhNgoiPf9iOe6AFhggnfDf9iNe5AGhjgmemf9iSe8ADhbgof/f9iTe8ADhZgogRf9
					iOe5AFhigne3f9iMe5AGhkgmecf9iMe5AGhkgmecf9iMe5AGhkgmecf9iMe5AGhkgmecf9iMe5AGhkgmec]],
				Neck1 = [[
					gAj9fwGDgAgAytgAkEgVIBgAgA1LgAkHgtJagAgA2pgAkGgmJCgDgE2RgBkFgaIUfxfp1ggGkDgNHne4eU0mgFkBgEHIfDem0CgBkBgBG+f0fvz6f/kAf7Go
					gIgMzegAj4flFfgDgEx5f+jkfCDygMgIvEf9jDeiCJgbgIref8iieOBCgqgAn+f7iLeGAig0f2lrf7iIeGAfg1f1lWf7iSeIAqgxf5mXf7iUeJAtgwf6mjf7
					iKeGAhg0f2lif7iHeFAdg1f0lPf7iHeFAdg1f0lPf7iHeFAdg1f0lPf7iHeFAdg1f0lPf7iHeFAdg1f0lP]],
				Neck2 = [[
					gAkhfkGDgAgAytgAkpgQIjgAgA1wgAksgtKWgAgA3jgAkrglJ3gDgE3FgCkqgWI8fxfp2KgIkngHIBe2eW1EgGklf8HZfCen0XgBklf5HNf0fv0Nf/kkfxGy
					gIgMzqf/kafXFygAgAyVf+kCeuEkgBf6wbf9jceGDXgEftuPf8izdtCagFfasHf8iYdkB4gEfKqtf8iVdjBzgEfIqgf8igdmCBgFfPrIf8ijdnCEgFfRrQf8
					iXdjB2gEfJqof8iTdiBygDfHqcf8iTdiBygDfHqcf8iTdiBygDfHqcf8iTdiBygDfHqcf8iTdiBygDfHqc]],
				Neck3 = [[
					gAk7fbGDgAgAytgAlFgOJGgAgA2VgAlIgvLVgAgA4agAlHgmKugDgE34gClFgVJkfwfq2zgIlDgDIbe0eX1hgHlBf3HqfAeo0rgBlAfzHcf0fv0ff/k/fqG7
					gIgLz3f/k1fNGGf9f8yxf/kbegFaf2fsxxf+jzd2E2ftfUw4f9jHdZEWfge2wAf9iqdOECfUegvcf9imdNEAfSedvXf9izdREIfYenvnf9i1dSEKfZepvqf9
					iodNEBfTefvaf9ikdMD/fRecvVf9ikdMD/fRecvVf9ikdMD/fRecvVf9ikdMD/fRecvVf9ikdMD/fRecvV]],
				Head = [[
					gAlWfSADgAgAhXgAlggNBIgAgAoYgAljg0CpgAgAsrgAljgpCLf7gDrkgClhgVBagefspVgJlfgBA7iTeVm+gIlcfyAjh/eelQgClcfuAYgYftkvf/lafkAO
					fvgOjigAlPfEAHfUfsiQf/k1eWANdue4iQf+kMdpAibtdpi4f+jfdMBAZ1cTjQf/jCc/BaYobXjYf/i9c+BfYcbOjZf/jKdCBSY/bpjWf/jNdDBQZGbujWf/
					jAc/BcYjbTjZf/i8c9BgYYbLjZf/i8c9BgYYbLjZf/i8c9BgYYbLjZf/i8c9BgYYbLjZf/i8c9BgYYbLjZ]],
				Jaw = [[
					gAlqes/9gAgAhZgAmDfz//gAgAfXgAmMgl/7gAgAeDf/mKgY/8gGf/eZgDmGf+/+fegLfEgRl/fk/3dahKfqgOl5fS/5dzhLgMgDl4fN//flgPgbf+lzfB/+
					gTf1gxf/lmef/8gpgZhdf/lLdx/ziGhciSf+kkdF/cjxjJjPf/j4co+4lGlFkRgAjbcc+Yl3mdk+gAjXcb+Sl+mqlEf/jkcf+ilpmCkwf/jncg+llll7ksgA
					jacc+Vl6mjlAgAjWcb+RmAmvlGgAjWcb+RmAmvlGgAjWcb+RmAmvlGgAjWcb+RmAmvlGgAjWcb+RmAmvlG]],
				Crest = [[
					gAnyfNXMgAgA+wgAnwhLeLgAgA/8gAnbiXivgAgA/3f/niiEhigBgG/9gGnshcfLf2fd/+genxgycyfJdS/sgbn0gTbCfLdp/ggFn1gJaff2fj/gf8n1fzZT
					gHgU/Rf5nrfHX0ffgj+6fpnPeYXSeKhw+rfWmidvXRcPjJ+YfFlwdRXJaOkS94e6lOdCXBY0k89ce5lJdAW/YnlC9Xe9lYdGXEZPkw9le+lbdHXEZXks9ne5
					lMdBXAYvk/9ae4lHdAW/YilE9Ve4lHdAW/YilE9Ve4lHdAW/YilE9Ve4lHdAW/YilE9Ve4lHdAW/YilE9V]],
				["Humerus.L"] = [[
					e/j9fzX0M5gA4Ue/kDgXXDNJbO3we/kGgvWZNzYY3Re/kFgpWpNmZN3dfBkEgbWoNMaC3XfGkDgIV/MmZq2ffFkBgAWVMcbO25fAkBgDXQMydS34e/j/f/Xx
					M9ey4Ue/j4foW7M5ge3/e+jlfHU8NKi73Me9jIenSbN3lf15e8ipeSQLO3nu0fe7iUeKO0PrpCzee7iReJOnPypNzUe7iaeMPNPbopzye7iceNPVPWoiz3e7
					iTeJOuPupGzae7iQeIOjP1pRzRe7iQeIOjP1pRzRe7iQeIOjP1pRzRe7iQeIOjP1pRzRe7iQeIOjP1pRzR]],
				["Forearm.L"] = [[
					dYkqgEYEMJgA3ydmlHgoXKMYbQ3LdylWhDWbNDYb2rdulSg8WrM2ZQ24dslOgqWtMbaF2xdzlQgPWDL3Zu14dslHgIWdLtbS2Tdgk7gRXbMCdT3UdakxgRX+
					MMey3xdYkmf2XRMGgm3ddWkSfPVlMWjZ2udUj0enTZNGmY1ldTjTeLRdOOo/0XdSi+d+QRPKqhzhdSi7d9QHPTqvzZdSjEeCQnO3qFzxdSjGeDQuOyp9z2dS
					i9d+QNPNqnzedSi6d8QDPWqzzWdSi6d8QDPWqzzWdSi6d8QDPWqzzWdSi6d8QDPWqzzWdSi6d8QDPWqzzW]],
				["WingFinger1.L"] = [[
					bxlTgQaQLmgA39cMmIgzZRLjbS3LckmlhQYcMCYd2mccmchJYvL4ZS20cWmVgzYyLhaJ2vchmbgRYGK6Z313cTmKgKYjK2ba2VcAlygaZlLUdV3Zb2lggdaK
					Lley34bxlQf/ZlLhgx3sbtk3fSYKL1j83ObqkVemWVMwnZ2dbnjxeIUqOJqZ1obmjad6TpPSsI1EbmjXd4TfPdsX0/bnjhd+T8O7ro1Pbnjjd/UCO1re1Sbm
					jZd5TlPXsO1CbmjWd4TcPhsc09bmjWd4TcPhsc09bmjWd4TcPhsc09bmjWd4TcPhsc09bmjWd4TcPhsc09]],
				["WingFinger2.L"] = [[
					aJlwgdeKLYgA4Yatm+g9dHK0bY3VbQnqhccOK9Yl2mbEndhUciK6ZZ22a8nSg8cmKoaS22bJncgRb5J8aI2Ba1nDgLcYKEbo2lacmegjddKzdb3raPmDgpeE
					LPez4OaJlugKdnLUg+4QaClNfbchL4kj4MZ+klewbCNOod39Z8j+eVZqPIrw3rZ7jmeLYzQptl3eZ7jjeKYrQ3t13cZ7jteOZDQLtE3iZ7jveOZIQCs63jZ7
					jleKYwQvts3dZ7jieJYpQ8t73bZ7jieJYpQ8t73bZ7jieJYpQ8t73bZ7jieJYpQ8t73bZ7jieJYpQ8t73b]],
				["WingFinger3.L"] = [[
					Ynl5guiBL0gA4uZPnehIhBKubi3cZ4oZhngGKiYy2lZqoIhfgbKlZk23Zgn5hEggKZaf27ZuoHgTfyJoad2LZXnmgPgRJ8b52yY7m0guhXK8di36YtmRg4h8
					Lje14fYml1gZhpL0hM4vYglMfug4M0lL5DYekdfKfyO1pf5RYfj0e6ewRhs85ZYhjfe3eGTjux5bYijce3eAT3vA5bYgjle3eSS7uQ5bYgjme3eWSwuH5aYh
					jee3eDTru35bYijbe3d+T+vF5bYijbe3d+T+vF5bYijbe3d+T+vF5bYijbe3d+T+vF5bYijbe3d+T+vF5b]],
				["Humerus.R"] = [[
					hBj9fzX0zHgA4UhBkDgXXDy3ky3whBkGgvWZyNno3RhAkFgpWpygm43XhCkEgeWkyPln34hGkBgYVjwlku41hFkAgOWDxHji44hCkAgFXPyvih4RhAj/f9Xy
					zYhW4DhAj4fnW8zXfn3yg/jkfDVFzndJ2mg+jDehS5znaT02g8ifeNRIzIXizFg8iIeFQIykVxx8g7iFeFQAyeVhxyg8iPeHQbywWTySg8iReHQgy0WcyYg8
					iHeFQFyiVrx4g7iEeEP9ycVcxug7iEeEP9ycVcxug7iEeEP9ycVcxug7iEeEP9ycVcxug7iEeEP9ycVcxu]],
				["Forearm.R"] = [[
					iokqgEYEz3gA3yialHgoXKzokw3LiOlWhDWby9nl2riSlSg7WszRm12yiXlMgyWpzAlk3TiWlMg0VoxZkq4ViclFgoWLx6jf4Yihk6gYXZzgig3uilkxgMX/
					0IhW3finkmfzXS0Jfe3QiokOfFVs0acr2HipjneXT20VZY0dipi6d8SZzrWOy2ipiddyRly8UOx1ipiZdyRey1T9xripimd0R0zMU0yIipiod1R4zQU/yOip
					ibdyRiy5UHxxipiXdxRcyyT2xoipiXdxRcyyT2xoipiXdxRcyyT2xoipiXdxRcyyT2xoipiXdxRcyyT2xo]],
				["WingFinger1.R"] = [[
					kPlTgQaQ0agA39j0mIgzZR0dku3LjcmlhQYcz+nj2mjkmdhHYw0Omy2tjsmThAYuz6lk3TjomVhKXtyTky4bjzmGg9YSyvjm4fkClxgkZj0Oig3zkKlggVaK
					0whU3mkOlQf5Zm0ufS3fkSkxfCYS06cC2mkVj/eNWv0mYN1RkXjIdvVizkUm0BkYikdmU3yjSYzOkYifdmUyyYSEzHkYivdoVDy4TCzdkYiydoVHy+TOzhkY
					iidmU1yeSQzLkYiedmUwyUR9zEkYiedmUwyUR9zEkYiedmUwyUR9zEkYiedmUwyUR9zEkYiedmUwyUR9zE]],
				["WingFinger2.R"] = [[
					l3lwgdeK0ogA4YlTm+g9dH1Mko3VkwnqhccO1Dnb2mk7ndhRcj1Nmq2wlGnPhNcj0ylh3bk/nThhbhzMk/4tlPm9hScIzdjx4zllmdgxdc0vif4GlwmDgfeE
					1GhQ37l3ltgCdo08fC4Dl+lFfGcn02bT3kmCkHeNbY0BW32wmEjFdzaYyVS41/mFicdwZ1wzQg1hmEiXdwZwwjQM1cmFiodvZ/xSRM1qmFisdwaCxbRZ1smE
					iadwZzwsQY1fmEiVdwZuweQF1bmEiVdwZuweQF1bmEiVdwZuweQF1bmEiVdwZuweQF1bmEiVdwZuweQF1b]],
				["WingFinger3.R"] = [[
					nZl5guiB0MgA4umxnehIhB1Ske3cmIoZhngG1enO2lmVoIhbgc1imd2wmin1hagd0/lb3hmXn7h5fazblK44mrnehpgBzhj75CnGmzhAhV0lid4VnTmSgrh9
					0yhK4Nnal0gPhp0bey4inhlBfSg8z4ai4cnkj4efgByRVl4GniivePfOvpRV3uneiDeVextdO+3dndh+eXettHOq3bnfiQeSe5uJPp3ingiTeRe8uWP13kne
					iBeWevtUO13cndh8eYestAOj3andh8eYestAOj3andh8eYestAOj3andh8eYestAOj3andh8eYestAOj3a]],
				Tail1 = [[
					gAifgij6gAgA/wgAifg4mQgAgA/YgAifhGnvgAgA/CgAifhDnWgFgA/IgAifg7mkflgB/TgAifgzlud/gI/agAifgulKeTgJ/hgAifgslCfrgC/lgAifgpko
					gOf//qgAifgfipgBgA/4gAiegTe3gAgA/+gAicgFaQgAgA/egAibf4WEgAgA+agAiafwTfgAgA9cgAiafvTIgAgA9SgAiafyUPgAgA9wgAiafzUdgAgA91gA
					iafvTVgAgA9YgAiZfuTAgAgA9OgAiZfuTAgAgA9OgAiZfuTAgAgA9OgAiZfuTAgAgA9OgAiZfuTAgAgA9O]],
				Fire1 = [[
					gAiRhobRi8gc/ggAiGh8ashNgK/hgAiAiHbWeqfz/ngAiCiEctdOfe/sf+iFh+e9dRfS/2f3iJh3gRdsfs/5f5iLhzfhgCgW//f/iMhydQiJgf/zgBiOhuaZ
					hsgP/cgAiWhnXYfpgA+zgAimhaUkeTgH91gAi4hHSDeUgR8ugAjHgxPjfZgK7bgAjPggNdgmfz6DgAjRgdMahIfl5QgAjNglMZg1fs5QgAjNgmMDgGf+4/gA
					jQgfLOfggO4UgAjRgcLdfYgR4ggAjRgcL8fqgJ46gAjRgcMJgFf+5EgAjRgcL/gZf249gAjRgcLpgaf14q]],
				Fire2 = [[
					gMilipadlQhd/CgFidi8XGkFhH+bf6iUjJUzgJfz99f1iQjGVIcYel91fziKjBYya4d5+qftiIi7c8bkeY/ff5iNi3eVfkgG/8gHiYi0cKjghN/igIiliuXg
					j6hD+kf/i5ihSXhKgH86f5jTiNOyeJfx65f5juhxNEc2gE5lf9kEhRMGd1gQ48gDkQg2LNf9f94TgFkTguKfhmfl3ngEkPg2J9h3fk3GgAkPg2I3g5fx2Ef+
					kTgpHufogG00f9kUgoH+e8gS1Ff+kUgrIwfEgP19gAkTgsJUfvgE2jgCkUgrJYgcf42ngCkUgpI/gzfy2N]],
				Fire3 = [[
					ghi9jlaElPhh+9gUjCj0WimFiV92f7jBj8RtjBg28cfoi8j5PTeTeT7Lfgipj7Rqaxcd74fbiVj7WyZzcS9xf3iUj7aqdnel/agWioj1aoi4g8/ZgXjIjnWY
					k+hz+DgDjujNP3jNgz7bfzkRipKuftfn33fukuiEIcc5fd1af2lGhfH+cnf601gDlThBIEejgA1LgLlWg0IQg+fw1agLlTg5IDiMfu1FgElTgyGuhvfyzhf9
					lXgfFMgVf6xbf5lYgfFEfGgGxPf7lYgnFuevgJyMf/lYgsGcfOgFzNgDlYgrGzgGf+ztgFlYgnGqg0f4zg]],
				["UpperLeg.L"] = [[
					fPiFgZ5RaZgAyzfPiGgr6laaflw4fPiIg37XabfUvmfPiHg17KaefVv9fQiHgt6waIf2whfRiHgh6PZIhNw7fRiGge58ZWhFxdfQiGgh56aMgDx1fPiFgf5s
					ahftyRfPiEga5Aaef8zLfPiCgV34akf80kfPiEgS2eagf02FfPiJgM1DaQfw3ZfPiNgH0GZ/fx4KfPiOgHz9Z9fy4QfPiMgJ0YaFfx38fPiLgJ0daGfw33fP
					iNgH0CZ+fx4NfPiOgGz6Z8fy4TfPiOgGz6Z8fy4TfPiOgGz6Z8fy4TfPiOgGz6Z8fy4TfPiOgGz6Z8fy4T]],
				["LowerLeg.L"] = [[
					fEhQgHzmgAgA5SfEhVgS1agAgA3xfEhZga2hgAgA2ufEhYgY2OgEf93AfEhWgS1pfpgP3jfIhUgI0+eVhJ4EfHhTgH0jeng/4dfEhSgL0efvgM4lfDhRgL0K
					gLf442fDhOgJy3gIf552fDhMgMwbgTfn7cfBhNgPtUgZfK9Ee/hSgQqQgTer+Re+hXgPoRgJeZ+3e+hYgPn+gIeW+8e+hVgQo3gNee+te/hVgQpCgOeg+pe+
					hXgPoJgJeX+5e+hYgPn4gHeV+9e+hYgPn4gHeV+9e+hYgPn4gHeV+9e+hYgPn4gHeV+9e+hYgPn4gHeV+9]],
				["Foot.L"] = [[
					fEgigT/PgAgAm3fEgmgX/qgAgAkifEgqga/2gAgAjBfEgoga/zgCf7jbfEgngW/tf4gakNfGgmgP/hfdh9lCfGgkgP/cfkhplnfEgkgU/ef7gUlwfEgjgV/Z
					gDfymKfEghgY/QgBf2m1fDgigi/Hf8fhnbfBgpgu++fmfKn7e/g1g2+1fFfBoZe9g/g4+vesfDose9hBg4+ueofEove+g8g4+xezfCome+g7g3+ye2fBole9
					hAg4+veqfDote9hCg5+uenfEowe9hCg5+uenfEowe9hCg5+uenfEowe9hCg5+uenfEowe9hCg5+uenfEow]],
				["UpperLeg.R"] = [[
					gxiFgZ5RlngAyzgxiGgr6llmgbw4gxiIg37XllgsvmgwiHg07Klpgkv7gxiHgv6xlUgzwrgxiFgu6SkUh2xogxiFgo5+kjhiyDgxiGgj56lagdx9gwiFge5r
					lwf9yMgwiEgZ5AltfzzHgwiBgT38lxfK0agwiAgN2qloeW10gwiCgI1ZlQdo3EgviEgE0kk6dP32gviEgD0ck3dL39gviDgF00lCdW3ngviDgG05lDdY3jgv
					iEgE0hk5dN35gviEgD0ak2dK3/gviEgD0ak2dK3/gviEgD0ak2dK3/gviEgD0ak2dK3/gviEgD0ak2dK3/]],
				["LowerLeg.R"] = [[
					g8hQgHzmgAgA5Sg8hVgS1agAgA3xg8hZga2hgAgA2ug8hYgX2OgEf93Ag9hVgV1pfpgP3jg/hTgY0+eVhJ4Eg/hSgU0jeng/4dg9hSgO0efvgM4lg8hRgK0K
					gLf442g8hOgIy3gIf552g7hKgIwbgTfn7cg5hIgKtUgZfK9Eg3hJgLqQgTer+Rg2hLgLoRgJeZ+3g2hMgLn+gIeW+8g2hLgLo3gNee+tg3hLgLpCgOeg+pg2
					hMgLoJgJeX+5g2hMgLn4gHeV+9g2hMgLn4gHeV+9g2hMgLn4gHeV+9g2hMgLn4gHeV+9g2hMgLn4gHeV+9]],
				["Foot.R"] = [[
					g8gigT/PgAgAm3g8gmgX/qgAgAkig8gqga/2gAgAjBg8gpgZ/zgCf7jbg9gmgZ/tf4gakNg+gkge/hfdh9lCg+gjgc/cfkhplng9gkgW/ef7gUlwg8gjgT/Z
					gDfymKg8ghgX/QgBf2m1g7ghge/Hf8fhnbg5glgo++fmfKn7g3gtgw+1fFfBoZg1g0g0+vesfDosg1g1g0+ueofEovg2gygz+xezfComg2gxgz+ye2fBolg1
					g0g0+veqfDotg1g2g1+uenfEowg1g2g1+uenfEowg1g2g1+uenfEowg1g2g1+uenfEowg1g2g1+uenfEow]],
			},
		},
	},
}
