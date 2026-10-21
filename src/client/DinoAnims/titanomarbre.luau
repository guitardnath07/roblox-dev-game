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
					gAjzhLANgAgAjZgAjzhLANgAgAjZgAj0hLANgAgAjZgAj0hLANgAgAjZgAj1hLAOgAgAjpgAj4hLAUgAgAkZgAj6hLAagAgAk/gAj7hLAbgAgAlDgAj7hLAb
					gAgAlDgAj7hLAbgAgAlDgAj7hLAbgAgAlDgAj7hLAbgAgAlDgAj6hLAbgAgAlDgAj6hLAbgAgAlDgAj6hLAbgAgAlDgAj6hLAbgAgAlDgAj6hLAbgAgAlDgA
					j6hLAbgAgAlDgAj6hLAZgAgAk4gAj7hLAWgAgAkogAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgA
					gAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj7hLAVgAgAkggAj6hLAVgAgAkggAj6hLAVgAgAkggAj6
					hLAVgAgAkegAj4hLATgAgAkNgAj2hLAPgAgAjygAj0hLANgAgAjdgAjzhLANgAgAjZgAjzhLANgAgAjZ]],
				Spine1 = [[
					gAj8gjANgAgAjZgAj8gjANgAgAjagAj8gjANgAgAjagAj8gjANgAgAjagAj+gjAOgAgAjqgAkDgkAVgAgAkagAkHgkAagAgAlBgAkIgkAbgAgAlFgAkIgkAb
					gAgAlEgAkHgkAbgAgAlEgAkHgkAbgAgAlDgAkHgkAbgAgAlDgAkHgkAbgAgAlCgAkHgkAagAgAlCgAkHgkAagAgAlCgAkHgkAagAgAlCgAkHgkAagAgAlCgA
					kHgkAagAgAlCgAkHgkAZgAgAk3gAkGgkAWgAgAkngAkGgkAVgAgAkggAkGgkAVgAgAkggAkGgkAVgAgAkhgAkGgkAWgAgAkhgAkGgkAWgAgAkigAkGgkAWgA
					gAkigAkGgkAWgAgAkigAkGgkAWgAgAkhgAkGgkAVgAgAkhgAkGgkAVgAgAkggAkGgkAVgAgAkggAkGgkAVgAgAkggAkGgkAVgAgAkfgAkGgkAVgAgAkfgAkG
					gkAVgAgAkdgAkDgjASgAgAkLgAj/gjAPgAgAjwgAj9gjANgAgAjcgAj8gjAMgAgAjYgAj8gjAMgAgAjZ]],
				Spine2 = [[
					gAkFf7//gAgAgcgAkFf7//gAgAgbgAkFf7//gAgAgagAkFf7//gAgAgZgAkHf7//gAgAgJgAkOf8//gAgAfZgAkUf9/+gAgAeygAkUf9/9gAgAeugAkUf9/9
					gAgAevgAkUf9/9gAgAewgAkUf9/9gAgAexgAkUf9/+gAgAeygAkUf9/+gAgAezgAkUf9/+gAgAezgAkUf9/+gAgAe0gAkUf9/+gAgAe0gAkUf9/+gAgAe0gA
					kUf9/+gAgAe0gAkTf9/+gAgAe+gAkSf8/+gAgAfOgAkSf8//gAgAfVgAkSf8//gAgAfUgAkSf8/+gAgAfTgAkSf8/+gAgAfSgAkSf8/+gAgAfRgAkSf8/+gA
					gAfRgAkSf8/+gAgAfRgAkSf8/+gAgAfSgAkSf8/+gAgAfTgAkSf8//gAgAfUgAkSf8//gAgAfVgAkRf8//gAgAfWgAkRf8//gAgAfWgAkRf8//gAgAfXgAkR
					f8//gAgAfZgAkOf8//gAgAfrgAkJf7//gAgAgGgAkFf7//gAgAgbgAkFf7//gAgAgegAkFf7//gAgAgd]],
				Spine3 = [[
					gAkEfX//gAgAgcgAkEfX//gAgAgagAkEfX//gAgAgZgAkEfX//gAgAgYgAkHfX//gAgAgIgAkQfY//gAgAfXgAkXfZ/9gAgAewgAkXfZ/9gAgAetgAkXfZ/9
					gAgAeugAkXfZ/9gAgAevgAkXfZ/9gAgAexgAkXfZ/+gAgAeygAkXfZ/+gAgAe0gAkXfZ/+gAgAe1gAkXfZ/+gAgAe1gAkXfZ/+gAgAe2gAkXfZ/+gAgAe1gA
					kXfZ/+gAgAe1gAkWfZ/+gAgAe/gAkUfY/+gAgAfOgAkTfY//gAgAfVgAkTfY//gAgAfTgAkTfY/+gAgAfSgAkTfY/+gAgAfRgAkTfY/+gAgAfQgAkTfY/+gA
					gAfQgAkTfY/+gAgAfQgAkTfY/+gAgAfRgAkTfY/+gAgAfSgAkTfY//gAgAfTgAkTfY//gAgAfVgAkTfY//gAgAfWgAkTfY//gAgAfXgAkTfY//gAgAfYgAkS
					fY//gAgAfbgAkPfY//gAgAftgAkJfX//gAgAgIgAkEfX//gAgAgcgAkEfX//gAgAgfgAkEfX//gAgAgd]],
				Neck1 = [[
					gAkDezC/gAgAtdgAkDezC/gAgAtegAkDezDAgAgAtfgAkDezDAgAgAtggAkHezDLgAgAt2gAkRe0DrgAgAu3gAkZe1EHgAgAvqgAkae1EKgAgAvvgAkae1EJ
					gAgAvugAkae1EJgAgAvtgAkae1EIgAgAvsgAkae1EHgAgAvqgAkae1EHgAgAvpgAkZe1EGgAgAvogAkZe1EGgAgAvogAkZe1EGgAgAvogAkZe1EGgAgAvogA
					kZe1EFgBgDvmgAkYe1DagkhcuQgAkWe1CphrjhsEgAkVe0CZiTkcrAgAkVe0CZiTkcrBgAkVe0CaiTkdrCgAkVe0CaiTkdrDgAkVe0CaiTkdrEgAkVe0CaiT
					kdrEgAkVe0CaiTkdrEgAkVe0CaiTkdrDgAkVe0CaiTkdrCgAkVe0CZiTkcrBgAkVe0CZiTkcrAgAkUe0CYiTkcq+gAkUe0CYiUkcq9gAkUe0CXiUkcq8gAkU
					e0CXiQkVq/gAkPe0CbhnjRrogAkIezCpguhlslgAkDezC6gHgQtRgAkDezC+gAgAtagAkDezC+gAgAtb]],
				Neck2 = [[
					gAlUduGggAgAzTgAlUduGhgAgAzUgAlVduGhgAgAzVgAlVduGigAgAzWgAladxG2gAgAzwgAlpd4HzgAgA06gAl0d+IngAgA10gAl1d+IsgAgA16gAl1d+Is
					gAgA15gAl1d+IrgAgA14gAl1d+IqgAgA13gAl1d+IpgAgA12gAl0d+IogAgA11gAl0d+IngAgA10gAl0d+IngAgA10gAl0d+ImgAgA1zgAl0d+IngAgA10gA
					l0d9IjgDgF1wf5ltd1G2hjiszhfvlhdrFFkWmavbfqladnEpl0n+tUfqlbdnEql0n/tWfqlbdnErl0n/tXfqlbdnErlzn/tYfqlbdoErlzn/tYfqlbdoErlz
					n/tYfqlbdoErlzn/tYfqlbdnErlzn/tYfqlbdnErl0n/tXfqlbdnEql0n/tWfqladnEpl0n+tUfqladnEpl1n+tTfqladnEol1n+tSfqladnEol1n+tRfqlZ
					dnEnlsnytbfwlYdoEvkKl7vFf4lWdqFZh6i5xaf/lUdtGRgTgey/gAlUduGegAgAzRgAlUduGfgAgAzS]],
				Neck3 = [[
					gAm3dSHZgAgA0cgAm3dSHagAgA0dgAm3dTHbgAgA0egAm3dTHcgAgA0fgAm9dYH2gAgA09gAnOdpJIgAgA2XgAnbd3KOgAgA3bgAncd4KVgAgA3hgAncd4KU
					gAgA3ggAnbd4KTgAgA3fgAnbd3KSgAgA3egAnbd3KRgAgA3dgAnbd3KQgAgA3cgAnad3KPgAgA3cgAnad2KOgAgA3bgAnad2KOgAgA3bgAnad2KOgAgA3bgA
					nad2KJgEgI3WfynQddHkiQkD0Ifam5c8FimSplt1fOmtcxFeoWr0qffOmtcxFfoVr1qgfOmtcxFfoVr1qifOmucyFgoVr1qifOmucyFgoUr2qjfOmucyFgoU
					r2qjfOmucyFgoUr2qjfOmucyFgoVr1qifOmtcxFfoVr1qifOmtcxFfoVr1qgfOmtcxFeoWr0qffOmscxFeoWr0qefOmscxFdoXr0qdfOmscwFdoXrzqcfPms
					cxFZoKrjqufcmvc2FGmCo5tjfvmzdCFtiykYxdf9m2dPHCgbgtz+gAm2dSHYgAgA0agAm2dSHYgAgA0b]],
				Head = [[
					gAoVdBACgAgAg0gAoVdBACgAgAg1gAoWdBACgAgAg2gAoWdCACgAgAg3gAocdLAEgAgAh3gAoudnAZgAgAk3gAo6d+A2gAgAnQgAo7eAA6gAgAnggAo7eAA6
					gAgAnfgAo7d/A5gAgAndgAo7d/A5gAgAncgAo7d+A5gAgAnagAo6d+A4gAgAnZgAo6d+A4gAgAnYgAo6d9A4gAgAnXgAo6d9A4gAgAnXgAo6d9A4gAgAnXf/
					o6d8A1f9gMnMfooudMAre0mMhTe6oJcRE7eHvQYqejn0cAIreQy+VOejn0cAIrePy+VPejn0cAIqeOy+VQejn1cBIqeNy+VRejn1cBIqeNy+VRejn1cBIqeN
					y9VRejn1cBIqeNy+VRejn1cBIqeNy+VRejn0cAIqeOy+VQejn0cAIrePy+VPejn0cAIreQy+VOejnzb/IseRy+VNejnzb/IseRy+VMejnyb/IteSy+VLemnz
					b/ITeSylVYe+n+cHEqeYuWXzfjoMcfBCe+nAcPf8oTc6ACf0hHgBgAoVdAACgAgAgxgAoVdAACgAgAgy]],
				Jaw = [[
					gAnZcdABgAgAgHgAnZcdABgAgAgIgAnZcdABgAgAgKgAnacdABgAgAgLgAnicjACgAgAhKgAn9c0ASgAgAkLgAoRdFAtgAgAmlgAoTdGAwgAgAm0gAoTdGAw
					gAgAmzgAoSdGAvgAgAmygAoSdFAvgAgAmwgAoSdFAvgAgAmvgAoSdFAvgAgAmugAoRdEAugAgAmsgAoRdEAugAgAmsgAoRdEAugAgAmsgAoRdEAugAgAmsf/
					oQdDAsf9gMmgffnycnAqermKgoe0nDcYFGdyvNYEemmxcYI7d1y7UuemmycYI6d0y7UvemmycZI6d0y7UwemmycZI5dzy7UwemmzcZI5dzy7UxemmzcZI5dy
					y7UxemmzcZI5dzy7UxemmycZI5dzy7UwemmycZI6d0y7UwemmycYI6d0y7UvemmxcYI7d1y7UuemmxcYI7d2y7UsemmxcYI8d3y7UremmwcXI8d4y7Urenmx
					cXIid4yjU3e6m4cQE2eDuTXNfcnHcPBIe0m+bkf6nVcZADfyhGfUgAnYccABgAgAgEgAnYccABgAgAgF]],
				["UpperLegF.L"] = [[
					eQipe7uXe/f08keQipe7uXe/f08keQipe7uXe/f08keQipe6uXfAf08keQite5t3e/fw80eQi3e2tCe/fl9MeQi/e0tVe+fb9DeQjAeztce+fZ9AeQjAe0te
					e+fZ8/eQjAe0tge+fZ8+eQjAe0tie+fZ89eQi/e0tke+fZ88eQi/e0tme+fZ87eQi/e0tne+fZ87eQi/e0toe+fZ86eQi/e0tpe+fZ86eQi/e0toe+fZ86eQ
					i/e0tle+fZ88eQi+e1tOe/fl9HeQi7e2vDfCf28NeQi6e2w4fEf+7KeQi7e2w6fEf+7JeQi7e2w7fEf+7IeQi7e2w8fFf/7IeQi7e2w8fFf/7HeQi7e2w9fF
					f/7HeQi7e2w8fFf/7HeQi7e2w8fFf/7IeQi7e2w7fEf+7IeQi7e2w6fEf+7JeQi6e2w4fEf+7KeQi6e2w3fEf+7KeQi6e2w2fEf+7LeQi6e2w1fEf+7MeQi5
					e2wvfEf+7PeQi1e4v+fCf77teQiue5vBfBf38OeQiqe7ude/f08heQipe7uXe/f08keQipe7uXe/f08k]],
				["LowerLegF.L"] = [[
					eNh5fe+BgBgQrCeNh5fe+AgBgQrGeNh5fe9/gBgQrJeNh6fe9+gBgQrLeNh+fe+cgBgSp2eMiLfe/gf9gZlheMiSfa/8f2gdhheMiTfa/+f2gehBeMiSfa/+
					f1geg+eMiSfa/+f1geg6eMiSfa/+f1geg1eMiSfa/+f1gegweMiSfa/+f1gegseMiRfa/+f1gegpeMiRfa/+f1gegmeMiRfa/+f1gegmeMiRfa/+f1gegmeM
					iRfa/+f1geg0eMiRfc/df9gYlyeNiKfX9bgDgLsieNiFfQ7vgBgDv7eNiFfQ7tgBgDv/eNiFfQ7rgBgCwDeNiFfQ7pgBgCwFeNiFfQ7ogBgCwHeNiFfQ7ogB
					gCwIeNiFfQ7ogBgCwHeNiFfQ7pgBgCwFeNiFfQ7rgBgCwDeNiFfQ7tgBgDv/eNiFfQ7vgBgDv7eNiFfQ7xgBgDv4eNiFfR7zgBgDv0eNiFfR71gBgDvyeNiE
					fR76gBgEvneNiCfV8mgCgHuVeNh9fb9cgCgMsgeNh5fe9/gBgQrKeNh5ff+EgBgQq8eNh5fe+CgBgQq/]],
				["FootF.L"] = [[
					eNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNheey+cf/gAp2eNh4er/Df8gBnueNiNek/ef3gClseNiPek/hf3gCldeNiPek/h
					f2gCldeNiPek/hf2gCldeNiPek/hf2gCldeNiPek/hf2gCldeNiPek/hf2gCldeNiPek/hf2gCldeNiPek/hf2gCldeNiPek/hf2gCldeNiPek/hf2gCldeN
					iPek/gf2gClheNh+ep/Kf9gBnOeNhjex+igCf/pheNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgA
					gAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhW
					e1+PgAgAqdeNhWe1+PgBgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+Pf/gAqdeNhWe1+Pf/gAqd]],
				["UpperLegF.R"] = [[
					hwipe7uXhBgM8khwipe7uXhBgM8khwipe7uXhBgM8khwipe6uXhAgM8khwite5ushAgK8Zhwi3e2wHg8gE7nhwi/e0x2g5f+6ihwjAezyEg5f+6YhwjAe0yC
					g5f+6ahwjAe0yAg5f+6bhwjAe0x+g5f+6chwi/e0x8g5f+6ehwi/e0x6g6f+6fhwi/e0x5g6f+6ghwi/e0x4g6f+6hhwi/e0x4g6f+6hhwi/e0x4g6f+6hhw
					i/e0x4g6f+6ghwi+e1xjg6gA6vhwi7e2xEg7gB7Chwi6e2w4g8gC7Khwi7e2w6g8gC7Jhwi7e2w7g8gC7Ihwi7e2w8g7gB7Ihwi7e2w8g7gB7Hhwi7e2w9g7
					gB7Hhwi7e2w8g7gB7Hhwi7e2w8g7gB7Ihwi7e2w7g8gC7Ihwi7e2w6g8gC7Jhwi6e2w4g8gC7Khwi6e2w3g8gC7Khwi6e2w2g8gC7Lhwi6e2w1g8gC7Mhwi5
					e2wvg8gC7Phwi1e4v+g+gF7thwiue5vBg/gJ8Ohwiqe7udhBgM8hhwipe7uXhBgM8khwipe7uXhBgM8k]],
				["LowerLegF.R"] = [[
					hzh5fe+Bf/fwrChzh5fe+Af/fwrGhzh5fe9/f/fwrJhzh6fe9+f/fwrLhzh8fc9mf+fzsHhziDfT8Pf+f6vBhyiIfK6rgBgDxqhyiIfJ6egBgEx8hyiIfJ6h
					gBgDx5hyiIfJ6jgBgDx1hyiIfK6mgBgDxxhyiIfK6pgBgDxthyiIfK6sgBgDxphyiIfK6ugBgCxmhyiIfK6vgBgCxkhyiIfK6vgBgCxjhyiIfK6vgBgCxkhy
					iIfK6ugBgCxlhziHfM7EgAgBxDhziGfP7jgAf+wQhziFfQ7vf/f9v7hziFfQ7tf/f9v/hziFfQ7rf/f+wDhziFfQ7pf/f+wFhziFfQ7of/f+wHhziFfQ7of/
					f+wIhziFfQ7of/f+wHhziFfQ7pf/f+wFhziFfQ7rf/f+wDhziFfQ7tf/f9v/hziFfQ7vf/f9v7hziFfQ7xf/f9v4hziFfR7zf/f9v0hziFfR71f/f9vyhziE
					fR76f/f8vnhziCfV8mf+f5uVhzh9fb9cf+f0sghzh5fe9/f/fwrKhzh5ff+Ef/fwq8hzh5fe+Cf/fwq/]],
				Tail1 = [[
					gAjth+gTgAgA//gAjth+gTgAgA//gAjth+gTgAgA//gAjth+gTgAgA//gAjuh+gzgSf+/+gAjuh+iThKf5/4gAjvh9jhh4f0/vgAjvh9jph8f0/ugAjvh9jp
					h8f0/ugAjvh9jph8f0/ugAjvh9jph8f0/ugAjvh9jph8f0/ugAjvh9jph8f0/ugAjvh9jph8f0/ugAjvh9jph8f0/ugAjvh9jph8f0/ugAjvh9jph8f0/ugA
					jvh9joh6f0/ugAjvh9jegqf8/ygAjwh9jNetgJ/zgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdy
					gQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjxh9jFdygQ/wgAjw
					h9jBd2gQ/xgAjwh+iVeZgL/3gAjuh+hRfPgF/9gAjth+gdf4gB//gAjth+gTgAgA//gAjth+gTgAgA//]],
				Tail2 = [[
					gAjsjDfJgAgA/+gAjsjDfJgAgA/+gAjsjDfJgAgA/+gAjsjDfJgAgA/+gBjqjDf4gtf6/+gFjkjCiJi5fo/ygIjgjAj7kpfb/ZgIjgjAkHk1fa/WgIjfjAkH
					k1fa/WgIjfjAkHk1fa/WgIjfjAkHk1fa/WgIjfjAkHk1fa/WgIjfjAkHk1fa/WgIjfjAkHk1fa/WgIjfjAkHk1fa/WgIjfjAkHk1fa/WgIjfjAkHk1fa/WgI
					jfjAkHkvfa/XgDjhjBj/hpfy/sf7jijBjtcygc/nf3jjjBjjaggy/Tf3jjjBjjaggy/Tf3jkjBjjaggy/Tf3jkjBjjaggy/Tf3jkjBjjaggy/Tf3jkjBjjag
					gy/Tf3jkjBjjaggy/Tf3jkjBjjaggy/Tf3jkjBjjaggy/Tf3jjjBjjaggy/Tf3jjjBjjaggy/Tf3jjjBjjaggy/Tf3jjjBjjaggy/Tf3jjjBjjaggy/Tf3jj
					jBjcapgx/Vf5jmjCiXcAgk/pf9jpjDgseGgR/7f/jrjDfZftgD//gAjsjDfJgAgA/+gAjsjDfJgAgA/+]],
				Tail3 = [[
					gAjvkIaPgAgA/egAjwkIaPgAgA/egAjwkIaPgAgA/egAjwkIaPgAgA/egEjrkIbNhSf8/mgRjbkFeOlOfy/ggbjPkAgnoXfu+3gcjOj/g3orfu+xgcjOj/g3
					orfu+xgcjOj/g3orfu+xgcjOj/g3orfu+xgcjOj/g3orfu+xgcjNj/g3orfu+xgcjNj/g3orfu+xgcjNj/g3orfu+xgcjNj/g3orfu+xgcjNj/g3orfu+xgc
					jOkAg2ogfu+1gKjPkDgvi+f5/2ftjSkDgdaLgR/dfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWI
					gf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfgjUkAgUWIgf+bfhjU
					kAgKWXgf+gfojbkEerYxgY/If1jmkHcWcjgM/mf+jukIakfdgC/hgAjvkIaPgAgA/egAjvkIaPgAgA/e]],
				Tail4 = [[
					gAkIlIV/gAgA+YgAkIlIV/gAgA+YgAkIlIV/gAgA+YgAkIlIV/gAgA+YgKj/lJXLh/gB+rgnjjlFa8oEgO+ig+jMk7d/sygh9QhAjKk6eTtQgj9EhAjKk6eT
					tQgj9EhAjKk6eTtQgj9EhAjKk6eTtQgj9EhAjKk6eTtQgj9EhAjKk6eTtQgj9EhAjKk6eTtQgj9EhAjKk6eTtQgj9EhAjKk6eTtQgj9EhAjKk6eTtQgj9Eg/
					jKk6eTtAgi9LgWjMlGeCkngL/mfUjQlDd1XBfw+ne4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/
					fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke4jSk3d2Q/fp8Ke5jT
					k4dqRVfq8VfKjglBbsU5fz9sfmj1lIYqapf8+rf8kFlJWafKgA+ggAkIlIV/gAgA+YgAkIlIV/gAgA+Y]],
				Tail5 = [[
					gAkwl/RCgAgA8RgAkwl/RCgAgA8RgAkxl/RCgAgA8RgAkxl/RCgAgA8RgSkjmCSYi0gS8zhIj3l+XBrThb8ghwjVlpa8xjij6JhzjRlmbWyJir5yhzjRlmbW
					yJir5yhzjRlmbWyJir5yhzjRlmbWyJir5yhzjRlmbWyJir5yhzjRlmbWyJir5yhzjRlmbWyJir5yhzjRlmbWyJir5yhzjRlmbWyJir5yhzjRlmbWyJir5yhx
					jRlobUx0io6BgqjVmHacmgg7+zewjal7afTdeU82d/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLo
					dX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4Cd/jbldbLLodX4CeCjd
					lfa7MCdb4VeejylyYPQmeK64fQkTmCUPYdfN8wf4ksmARgezf58fgAkwl/RCgAgA8RgAkwl/RCgAgA8R]],
				["UpperLegB.L"] = [[
					eQiwhR8ZeTf5upeQiwhR8YeUf5uqeQiwhR8YeUf5uqeQixhR8YeUf5ureQiyhQ8LeVf6vDeQi1hN7hebf9wOeQi3hK66ehgAxPeQi3hK62ehgAxVeQi3hK62
					ehgAxVeQi3hK63ehgAxUeQi3hK63ehgAxTeQi3hK64ehgAxSeQi3hK64ehgAxReQi3hK65ehgAxReQi3hK65ehgAxQeQi3hK65ehgAxQeQi3hK65ehgAxQeQ
					i3hK65ehgAxQeQi3hL69eggAxLeQi3hM7CeggAxCeQi3hM7EefgAw+eQi3hM7EefgAw/eQi3hM7DefgAxAeQi3hM7DeggAxAeQi3hM7DeggAxBeQi3hM7Deg
					gAxBeQi3hM7DeggAxBeQi3hM7DeggAxAeQi3hM7DefgAxAeQi3hM7EefgAw/eQi3hM7EefgAw+eQi3hM7FefgAw9eQi3hM7GefgAw8eQi3hM7GefgAw8eQi3
					hM7JefgAw3eQi1hO7gecf+wReQizhP8AeXf7vYeQixhR8WeUf5uueQiwhR8aeTf5uneQiwhR8ZeTf5uo]],
				["LowerLegB.L"] = [[
					eNiCgwvkgDgF78eNiCgwvlgDgF78eNiCgwvmgDgF77eNiCgwvmgDgF77eNiCgwvrgDgE75eNiDgxv9gCgC7ueNiDgywVgAgA7geNiEgywXgAf/7feNiEgywW
					gAf/7feNiDgywVgAf/7geNiDgywUgAf/7heNiDgywTgAgA7heNiDgywSgAgA7ieNiDgywSgAgA7ieNiDgywRgAgA7ieNiDgywRgBgA7jeNiDgywRgAgA7ieN
					iDgywSgAgA7ieNiEgzwZgAgA7eeNiEgzwkgAgA7XeNiEgzwpgAgA7UeNiEgzwqgAgA7TeNiEg0wrgAgA7TeNiEg0wsf/gA7SeNiEg0wtf/gA7SeNiEg0wtf/
					gA7SeNiEg0wtf/gA7SeNiEg0wsf/gA7SeNiEg0wrgAgA7TeNiEgzwqgAgA7TeNiEgzwpgAgA7UeNiEgzwogAgB7UeNiEgzwogAgB7VeNiEgzwngAgB7VeNiE
					gzwkgAgB7XeNiDgywQgBgC7jeNiDgxv1gCgE7zeNiCgwvlgDgF78eNiCgwvjgDgF79eNiCgwvjgDgF79]],
				["UpperLegB.R"] = [[
					hwiwhR8ZhtgHuphwiwhR8YhsgHuqhwiwhR8YhsgHuqhwixhR8YhsgHurhwiyhQ8LhrgGvDhwi1hN7hhlgDwOhwi3hK66hfgAxPhwi3hK62hfgAxVhwi3hK62
					hfgAxVhwi3hK63hfgAxUhwi3hK63hfgAxThwi3hK64hfgAxShwi3hK64hfgAxRhwi3hK65hfgAxRhwi3hK65hfgAxQhwi3hK65hfgAxQhwi3hK65hfgAxQhw
					i3hK65hfgAxQhwi3hL69hggAxLhwi3hM7ChggAxChwi3hM7EhhgAw+hwi3hM7EhhgAw/hwi3hM7DhhgAxAhwi3hM7DhggAxAhwi3hM7DhggAxBhwi3hM7Dhg
					gAxBhwi3hM7DhggAxBhwi3hM7DhggAxAhwi3hM7DhhgAxAhwi3hM7EhhgAw/hwi3hM7EhhgAw+hwi3hM7FhhgAw9hwi3hM7GhhgAw8hwi3hM7GhhgAw8hwi3
					hM7JhhgAw3hwi1hO7ghkgCwRhwizhP8AhpgFvYhwixhR8WhsgHuuhwiwhR8ahtgHunhwiwhR8ZhtgHuo]],
				["LowerLegB.R"] = [[
					hziCgwvkf9f778hziCgwvlf9f778hziCgwvmf9f777hziCgwvmf9f777hziCgwvrf9f875hziDgxv9f+f+7uhziDgywVgAgA7ghziEgywXgAgB7fhziEgywW
					gAgB7fhziDgywVgAgB7ghziDgywUgAgB7hhziDgywTgAgA7hhziDgywSgAgA7ihziDgywSgAgA7ihziDgywRgAgA7ihziDgywRf/gA7jhziDgywRgAgA7ihz
					iDgywSgAgA7ihziEgzwZgAgA7ehziEgzwkgAgA7XhziEgzwpgAgA7UhziEgzwqgAgA7ThziEg0wrgAgA7ThziEg0wsgBgA7ShziEg0wtgBgA7ShziEg0wtgB
					gA7ShziEg0wtgBgA7ShziEg0wsgBgA7ShziEg0wrgAgA7ThziEgzwqgAgA7ThziEgzwpgAgA7UhziEgzwogAf/7UhziEgzwogAf/7VhziEgzwngAf/7VhziE
					gzwkgAf/7XhziDgywQf/f+7jhziDgxv1f+f87zhziCgwvlf9f778hziCgwvjf9f779hziCgwvjf9f779]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAjxhLAZfLgIkygAjyhLAZfSggkxgAj1hLAZfeg0kxgAj5hLAZfvhBkxgAj7hLAZgBhHkxgAj7hLAZgUhEkygAj5hLAZgkg5kygAj1hLAZgvgnkygAjyhLAZ
					g1gRkygAjxhLAZg1f4kygAjyhLAZgufgkxgAj1hLAZgifMkxgAj5hLAZgRe/kxgAj7hLAZf/e5kxgAj7hLAZfse8kygAj5hLAZfcfHkygAj1hLAZfRfZkygA
					jyhLAZfLfvky]],
				Spine1 = [[
					f/j9gkAYfmgEkyf+j/gkAYfpgTkxf+kCgkAYfwgfkxf9kFgkAYf5gokxf9kHgkAYgCgskxf9kHgkAYgLgrkyf+kFgkAYgTgkkyf/kCgkAYgZgZkygAj/gkAY
					gbgLkygBj9gkAYgaf8kygCj/gkAYgXftkxgCkCgkAYgQfhkxgDkFgkAYgHfYkxgDkHgkAYf+fUkxgDkHgkAYf1fVkygCkFgkAYftfckygBkCgkAYfnfnkygA
					j/gkAYflf1ky]],
				Spine2 = [[
					f/kKf8ACgAgAg9f+kLf8ACgAgGg9f8kOf8ACgAgLg9f8kRf9ACgAgPg9f7kTf9ACgBgSg9f8kTf9ACgBgSg+f9kRf9ACgAgPg+f+kOf8ACgAgLg+f/kLf8AC
					gAgGg+gBkKf8ACgAgAg9gCkLf8ACgAf6g9gEkOf8ACgAf1g9gEkRf9ACgAfxg9gFkTf9ACf/fug9gEkTf9ACf/fug+gDkRf9ACgAfxg+gCkOf8ACgAf1g+gB
					kLf8ACgAf6g+]],
				Spine3 = [[
					f/kMfZACgbf/g9f9kNfZACgZf8g9f8kQfZACgUf6g9f7kTfZACgNf4g9f7kVfZACgEf3g9f7kWfZACf7f3g+f8kTfZACfyf5g+f9kQfZACfrf7g+f/kNfZAC
					fnf+g+gBkMfZACflgBg9gDkNfZACfngEg9gEkQfZACfsgGg9gFkTfZACfzgIg9gFkVfZACf8gJg9gFkWfZACgFgJg+gEkTfZACgOgHg+gDkQfZACgVgFg+gB
					kNfZACgZgCg+]],
				Neck1 = [[
					f/kOe1CxgYf1s+f+kPe1CtgSfrs0f8kSe1CtgJfjs1f7kVe1CzgAfetCf7kYe1C6f2fetTf7kYe1DBfufithf8kWe1DDfofptlf+kSe1DAfkf0tef/kPe1C4
					fkf/tPgBkOe1CxfogLs+gCkPe1CtfugVs0gEkSe1Ctf3gds1gFkVe1CzgAgitCgFkYe1C6gKgitTgFkYe1DBgSgethgEkWe1DDgYgXtlgCkSe1DAgcgMtegB
					kPe1C4gcgBtP]],
				Neck2 = [[
					gBlddtFGgXfyxTgAlddtE7gKfhxBf/lgdtE9f8fTxEf/lkduFLfufLxaf+lodvFgfjfJx5f+lpdxFxfcfOySf9lndxF3fYfayaf+lkdwFtfafqyNf+lfdvFa
					fgf8xxf/lddtFGfpgOxTgAlddtE7f2gfxBgBlgdtE9gEgtxEgBlkduFLgSg1xagClodvFggdg3x5gClpdxFxgkgyySgDlndxF3gogmyagClkdwFtgmgWyNgC
					lfdvFagggExx]],
				Neck3 = [[
					gEm6dDE2gXfyw5gDm5dAEmgFfZwegDm9dBEpfzfFwjgCnCdEE+fje3xEgBnHdJFdfWeyxygAnJdNF3fPe3yYf+nIdOF+fNfFykf9nDdMFwfSfbyQf9m+dIFT
					fbf0xnf8m6dDE2fpgOw5f9m5dAEmf7gnwef9m9dBEpgNg7wjf+nCdEE+gdhJxEf/nHdJFdgqhOxygAnJdNF3gxhJyYgCnIdOF+gzg7ykgDnDdMFwguglyQgD
					m+dIFTglgMxn]],
				Head = [[
					gGoQcY/lgYgClDgHoOcT/ggLgrligHoScU/jf9hQlIgGoZcb/sfuhrkCgFogcl/0fih4iwgCokct/4fZh0h4gAojcv/5fVhjh1f+oecr/2fXhHiof8oWci/v
					fdglj6f6oQcY/lfof+lDf5oOcT/gf1fVlif5oScU/jgDewlIf6oZcb/sgSeVkCf7ogcl/0geeIiwf+okct/4gneMh4gAojcv/5gredh1gCoecr/2gpe5iogE
					oWci/vgjfbj6]],
				Jaw = [[
					gHnLcN/ygYgBjhgJnIcJ/ugNgqkBgJnMcJ/wgAhQjngInUcL/2fzhsihgGndcP/6foh5hOgDnicT/7ffh2gXgAnhcW/8fahlgTf9nbcU/8fahJhGf6nScR/5
					ffgmiYf5nLcN/yfof/jhf3nIcJ/ufzfWkBf3nMcJ/wgAewjnf4nUcL/2gNeUihf6ndcP/6gYeHhOf9nicT/7gheKgXgAnhcW/8gmebgTgDnbcU/8gme3hGgG
					nScR/5ghfaiY]],
				["UpperLegF.L"] = [[
					eNi3e1orfIgB+xeMi4e1qFfFgO+WeLi6e0tgfHgZ8+eLi9e0xHfLgf7AeLi+e00TfQgj4teMi9e01QfOgh35eOi6e0zwfIgU5JeQi2e0yLfCgF6TeSiye0wy
					e9f07NeUixe1vxe5fl7zeViye1vSe2fa8EeWi1e2vUe1fV8DeWi6e2vse1fW72eWi9e2wBe5fb7qeUi+e2v5e+fi7veTi9e2vIfEfq8LeRi6e1t9fMf08xeP
					i4e1qWfNf4+Q]],
				["LowerLegF.L"] = [[
					eKiXfo8pg8gruMeJiUfk+KhOhEqjeIiMfb+1hNhPoVeJiHfO+rg7hHo+eKiDfA9jgkg0sOeLiCe78igWgjubeMiAfC87gPgXtqeNh+fJ9SgCgKs3eOh9fP9d
					fwf6sfePh+fT9VfefqsweQiAfV84fRfctueRiDfW8HfNfTvPeRiHfV7GfPfOw+eRiJfU6CfXfOyjeQiLfU5OfifVzqePiLfX40fxfj0MeOiLfa4lgDfz0eeM
					iTfk6ogegOxu]],
				["FootF.L"] = [[
					eNhsfH+Zg1fvp6eNhye6+chGfqpxeNhxes+bhEfqpzeNhpeg+Ygzfvp/eNhdeZ+Sgdf2qSeNhWeb+OgRf6qdeNhWeg+PgLf8qdeNhWek+PgBgAqdeNhWep+P
					fygFqdeNhWeu+OfigKqdeNhWez+OfYgOqdeNhWe4+OfUgPqdeNhWe9+OfYgOqdeNhWfC+OffgMqdeNhWfH+OfogIqdeNhWfM+Pf1gEqdeNhWfQ+PgEf/qdeN
					hhfP+Ugbf3qM]],
				["UpperLegF.R"] = [[
					hsixe1vxhHgb7zhriye1vShKgm8Ehqi1e2vUhLgr8Dhqi6e2vshLgq72hqi9e2wBhHgl7qhsi+e2v5hCge7vhti9e2vIg8gW8Lhvi6e1t9g0gM8xhxi4e1qW
					gzgI+Qhzi3e1org4f/+xh0i4e1qFg7fy+Wh1i6e0tgg5fn8+h1i9e0xHg1fh7Ah1i+e00Tgwfd4th0i9e01Qgyff35hyi6e0zwg4fs5Jhwi2e0yLg+f76Thu
					iye0wyhDgM7N]],
				["LowerLegF.R"] = [[
					hxh+fT9VgigWswhwiAfV84gvgktuhviDfW8HgzgtvPhviHfV7Ggxgyw+hviJfU6CgpgyyjhwiLfU5OgegrzqhxiLfX40gPgd0MhyiLfa4lf9gN0eh0iTfk6o
					fifyxuh2iXfo8pfEfVuMh3iUfk+Keye8qjh4iMfb+1ezexoVh3iHfO+rfFe5o+h2iDfA9jfcfMsOh1iCe78ifqfdubh0iAfC87fxfptqhzh+fJ9Sf+f2s3hy
					h9fP9dgQgGsf]],
				["FootF.R"] = [[
					hzhWeu+Ogef2qdhzhWez+OgofyqdhzhWe4+OgsfxqdhzhWe9+OgofyqdhzhWfC+Oghf0qdhzhWfH+OgYf4qdhzhWfM+PgLf8qdhzhWfQ+Pf8gBqdhzhhfP+U
					flgJqMhzhsfH+ZfLgRp6hzhye6+ce6gWpxhzhxes+be8gWpzhzhpeg+YfNgRp/hzhdeZ+SfjgKqShzhWeb+OfvgGqdhzhWeg+Pf1gEqdhzhWek+Pf/gAqdhz
					hWep+PgOf7qd]],
				Tail1 = [[
					gBjnh9jog7gv/wgCjoh9jXgpgu/zgDjrh9jPgSgn/0gDjuh9jSf5gc/0gEjwh9jgfhgN/ygDjwh9jyfNf9/wgDjuh9j/e+ft/ugCjrh9kCe4fg/tgBjoh9j5
					e6fW/uf/jnh9jofFfR/wf+joh9jXfXfS/zf9jrh9jPfufZ/0f9juh9jSgHfk/0f8jwh9jggffz/yf9jwh9jygzgD/wf9juh9j/hCgT/uf+jrh9kChIgg/tf/
					joh9j5hGgq/u]],
				Tail2 = [[
					gFjXjAknicgf/jgFjZjBkGhpgk/rgEjdjBjugpgk/wgDjgjBjrflgf/xgCjhjAj9ekgV/tgAjgjAkcdvgK/mf+jdjAk6dKf//ff9jZjAlJc7f0/bf8jXjAlB
					dEfq/df7jXjAkndkfh/jf7jZjBkGeXfc/rf8jdjBjufXfc/wf9jgjBjrgbfh/xf+jhjAj9hcfr/tgAjgjAkciRf2/mgCjdjAk6i2gB/fgDjZjAlJjFgM/bgE
					jXjAlBi8gW/d]],
				Tail3 = [[
					gQjEkCh/kRgl/ogMjIkDhTjMgm/zgHjNkEgrhugj/7gBjQkEgYgEga//f8jQkDgkeZgM/8f2jNkChJc7f9/0fyjIkBh2b0fw/qfwjEkAiVbNfm/ifvjCkBiZ
					bLff/ifwjEkCh/bvfb/of0jIkDhTc0fa/zf5jNkEgreSfd/7f/jQkEgYf8fm//gEjQkDgkhnf0/8gKjNkChJjFgD/0gOjIkBh2kMgQ/qgQjEkAiVkzga/igR
					jCkBiZk1gh/i]],
				Tail4 = [[
					gii8lDf7mHg6/YgajDlGfPlDg1/kgPjKlIeajYgq/xgCjPlId2hTga/4f1jOlHdzfFgE/5fpjIlFeUc+fr/zfgjAlCfHbOfX/nfbi6lBf3aCfK/afai4lBgL
					ZlfE/Ufei8lDf7Z5fG/YfmjDlGfPa9fL/kfxjKlIeacofW/xf+jPlId2etfm/4gLjOlHdzg7f8/5gXjIlFeUjCgV/zggjAlCfHkygp/ngli6lBf3l+g2/agm
					i4lBgLmbg8/U]],
				Tail5 = [[
					g7i9mDcznhhx+4gvjHmHcPmyhj/AgdjRmLbYlOhM/MgHjYmMamjCgt/YfxjXmLaRgegG/efcjQmIajd4fb/cfMjFmEbUbie0/TfCi7mAcMZueY/Ge/i4mAcy
					YqeM+6fFi9mDczYfeP+4fRjHmHcPZOed/AfjjRmLbYaye0/Mf5jYmMamc+fT/YgPjXmLaRfif6/egkjQmIajiIgl/cg0jFmEbUkehM/Tg+i7mAcMmSho/GhB
					i4mAcynWh0+6]],
				["UpperLegB.L"] = [[
					eUiohL+VeBffp8eUiqhO+JePfMqieTiuhQ9rehfAr0eSizhS8+eze8tdeRi3hT8NfCe/vBeQi5hT7nfJfHwHePi4hS7RfIfRwseOi3hQ7BfBffxFeNi1hO6n
					e5fyxteNi0hL54exgJyxeNi1hJ4ueqgh0QeOi3hG3Memg41+ePi4hE2yeahE2YeQi5hE5NeChBzkeRi3hE7hdug2wIeSizhE9jdegkr/eTiuhG+udagMofeU
					iqhJ+9dnfynt]],
				["LowerLegB.L"] = [[
					eQiHgdybfgfW6IePiGghyOf6fS6SeOiHgnyagUfT6KeNiHgtyygofW54eMiIgzzCg2fa5seMiHg3yvhAfj56eLiGg4xuhGfw6neKiDg4wNhGgB7jeKiAg4ur
					g9gQ8aeLh+g5tkgugb89eMh9g9tKgZgi9JeNh+hDthgBgm8/eOh/hDscfsgq9dePiBg1oYfggm+3eQiFgommfQgS/SeRiLgbnyfAfy/AeRiRgVrce8fY92eR
					iPgWvVfKfS8D]],
				["FootB.L"] = [[
					eNhWgv+IfWgPqueNhWgz+IfsgHqueNhWg4+JgDf/queNhWg9+IgWf4queNhWhC+IgkfzqueNhWhH+IgwfvqueNhWhM+Ig5fsqueNhWhR+Ig+fqqueNhWhW+I
					g8frqueNhWhb+IgyfuqueNhWhf+Ighf0queNhWhk+JgNf8queNhahn+Lf8gBqoeNhnhi+SfvgGqUeNhwhX+WfZgNqGeNhyhJ+Xe/gVqBeNhug8+Ue1gZqIeN
					hkgy+PfBgWqZ]],
				["UpperLegB.R"] = [[
					hzi0hL54hPf3yxhzi1hJ4uhWff0Qhyi3hG3MhafI1+hxi4hE2yhme82Yhwi5hE5Nh+e/zkhvi3hE7hiSfKwIhuizhE9jiifcr/htiuhG+uimf0ofhsiqhJ+9
					iZgOnthsiohL+Vh/ghp8hsiqhO+Jhxg0qihtiuhQ9rhfhAr0huizhS8+hNhEtdhvi3hT8Ng+hBvBhwi5hT7ng3g5wHhxi4hS7Rg4gvwshyi3hQ7Bg/ghxFhz
					i1hO6nhHgOxt]],
				["LowerLegB.R"] = [[
					h1h+g5tkfSfl89h0h9g9tKfnfe9Jhzh+hDthf/fa8/hyh/hDscgUfW9dhxiBg1oYggfa+3hwiFgommgwfu/ShviLgbnyhAgO/AhviRgVrchEgo92hviPgWvV
					g2gu8DhwiHgdybgggq6IhxiGghyOgGgu6ShyiHgnyafsgt6KhziHgtyyfYgq54h0iIgzzCfKgm5sh0iHg3yvfAgd56h1iGg4xue6gQ6nh2iDg4wNe6f/7jh2
					iAg4urfDfw8a]],
				["FootB.R"] = [[
					hzhWhb+IfOgSquhzhWhf+IffgMquhzhWhk+JfzgEquhzhahn+LgEf/qohzhnhi+SgRf6qUhzhwhX+WgnfzqGhzhyhJ+XhBfrqBhzhug8+UhLfnqIhzhkgy+P
					g/fqqZhzhWgv+IgqfxquhzhWgz+IgUf5quhzhWg4+Jf9gBquhzhWg9+IfqgIquhzhWhC+IfcgNquhzhWhH+IfQgRquhzhWhM+IfHgUquhzhWhR+IfCgWquhz
					hWhW+IfEgVqu]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAjxhLATgAgAkLgAjrhLARgEgVj+gAjnhLAWgFgikggAjqhLAbgFgilCgAjwhLAZgDgVk1gAjxhLATgAgAkLgAjrhLARf8frj+gAjnhLAWf7fekggAjqhLAb
					f7felCgAjwhLAZf9frk1]],
				Spine1 = [[
					gAj8gjAWgAgAkif/j1gjAQgEgVj5f/jygkASgFgikGf/j3gkAZgFgik2f/j9gkAcgDgVlIgAj8gjAWgAgAkigBj1gjAQf8frj5gBjygkASf7fekGgBj3gkAZ
					f7fek2gBj9gkAcf9frlI]],
				Spine2 = [[
					gAkIf8ACgAgAhFf+j/f7ABgBgVf/f9j9f8ABgAgif2f9kDf9ACgAgig3f+kKf9AEgBgVhngAkIf8ACgAgAhFgCj/f7ABf/frf/gDj9f8ABgAfef2gDkDf9AC
					gAfeg3gCkKf9AEf/frhn]],
				Spine3 = [[
					gAkKfYADgAgAhdf+j/fXABgBgVf6f8j8fYACgAgifcf8kFfZACgAgigrf+kNfZAFgBgVh7gAkKfYADgAgAhdgCj/fXABf/frf6gEj8fYACgAfefcgEkFfZAC
					gAfegrgCkNfZAFf/frh7]],
				Neck1 = [[
					gAkNe0DmgAgAusf9j/e0CngJgTsof7j7e0COgNgfrqf7kGe1C3gOgftLf9kSe1DxgKgTvBgAkNe0DmgAgAusgDj/e0Cnf3ftsogFj7e0COfzfhrqgFkGe1C3
					fyfhtLgDkSe1Dxf2ftvB]],
				Neck2 = [[
					gAlkd3HCgAgA0Af7lMdqFRgMgRxjf4lDdmEbgSgdwMf5lWdvFggTgcx6f8lqd6HNgNgQ0NgAlkd3HCgAgA0AgFlMdqFRf0fvxjgIlDdmEbfufjwMgHlWdvFg
					ftfkx6gElqd6HNfzfw0N]],
				Neck3 = [[
					gAnIdgHpgAgA0uf7mqdCFYgNgRxuf3mdc0EPgRgdv4f3m1dJFhgTgcx8f7nOdlHwgOgQ02gAnIdgHpgAgA0ugFmqdCFYfzfvxugJmdc0EPfvfjv4gJm1dJFh
					ftfkx8gFnOdlHwfyfw02]],
				Head = [[
					gAondRABgAgAgaf6oDccAJf/gVdQf1nvcDAVf8gibjf2oPclAHf9gidpf7otdXACgAgVgqgAondRABgAgAgagGoDccAJgBfrdQgLnvcDAVgEfebjgKoPclAH
					gDfedpgFotdXACgAfrgq]],
				Jaw = [[
					gAnpcuADgAgAhQf6nAcHALf/gVc5f1mqb1Aif7giaUf1nMcOAKf8gidCf6nwczADgBgVhVgAnpcuADgAgAhQgGnAcHALgBfrc5gLmqb1AigFfeaUgLnMcOAK
					gEfedCgGnwczADf/frhV]],
				["UpperLegF.L"] = [[
					eQizeynBfJf1/MeNile8j+faf8/veMihfArLfrgO9+eLise6wVftgL7geNi4eyzgfdgC5WeQizey1/e+f73NeTile3xfebfh6veVihe5tOeNfT9EeVisezq7
					eYfi+BeUi4eusxezf89U]],
				["LowerLegF.L"] = [[
					eNiafn46gNf/0EeLiXf293hBgYrZeLh6ft/8hfgxgleLh4fX/8hQguhDeMh+fC/RgpgamueNh4e1+Pf6gFqdeNhvfP/GfNgMnceOh0fg+kexgOpXePiGfg7W
					fEgDwkePiMfW1dfgfv3u]],
				["FootF.L"] = [[
					eNhkfc+WgMf8qHeNhyfN+cg8ftpxeNh4e3+ehifhpneNh0eh+chSfmpteNhoeQ+XgnfzqCeNhWeK+Pf6gCqdeNhWee+OfNgSqdeNhWez+NeygbqdeNhWfH+O
					fHgUqdeNhWfc+OfjgKqd]],
				["UpperLegF.R"] = [[
					hwizey1/hCgF3Nhtile3xfhlgf6vhrihe5tOhzgt9Ehrisezq7hoge+Bhsi4eusxhNgE9UhwizeynBg3gL/Mhzile8j+gmgE/vh0ihfArLgVfy9+h1ise6wV
					gTf17ghzi4eyzggjf+5W]],
				["LowerLegF.R"] = [[
					hzh4e1+PgGf7qdhzhvfP/Ggzf0nchyh0fg+khPfypXhxiGfg7Wg8f9wkhxiMfW1dgggR3uhziafn46fzgB0Eh1iXf293e/forZh1h6ft/8ehfPglh1h4fX/8
					ewfShDh0h+fC/RfXfmmu]],
				["FootF.R"] = [[
					hzhWeK+PgGf+qdhzhWee+OgzfuqdhzhWez+NhOflqdhzhWfH+Og5fsqdhzhWfc+Ogdf2qdhzhkfc+Wf0gEqHhzhyfN+cfEgTpxhzh4e3+eeegfpnhzh0eh+c
					eugapthzhoeQ+XfZgNqC]],
				Tail1 = [[
					gAjoh+kzgAgA/ogBjjh+jTfrgC/0gCjdh9jbfegE/zgCjeh9lAfegA/mgBjmh9l2frf+/cgAjoh+kzgAgA/of/jjh+jTgVf+/0f+jdh9jbgif8/zf+jeh9lA
					gigA/mf/jmh9l2gVgC/c]],
				Tail2 = [[
					gAjUjAnugef//CgAjVjBlMfegF/kf/jOjBkRergM/rf/jJi/mPeXgH/VgAjNi+oWesgB+2gAjUjAnufigB/CgAjVjBlMgif7/kgBjOjBkRhVf0/rgBjJi/mP
					hpf5/VgAjNi+oWhUf/+2]],
				Tail3 = [[
					gCi0j8m7hVgH/Nf9i/kDj/fwgE/vf6i8kDhweQgH/5f5ivj+jVdbf9/tf6iqj5mhdlf0/Of+i0j8m7erf5/NgDi/kDj/gQf8/vgGi8kDhwhwf5/5gHivj+jV
					ilgD/tgGiqj5mhibgM/O]],
				Tail4 = [[
					gIiXk6mSiYga/Rf8iulFjvgcgM/xfyi0lHgceUgC/8fuihlAg+c2ft/0fwiPk3klcmfd/ef4iXk6mSdofm/RgEiulFjvfkf0/xgOi0lHgchsf+/8gSihlAg+
					jKgT/0gQiPk3kljagj/e]],
				Tail5 = [[
					gSh9l5j/jWhA/jf+iemIiehYgk/3friymLexe2gF/8fgidmDeAcwfY/wfhh8l3hOb8e3/sfuh9l5j/cqfA/jgCiemIieeofc/3gViymLexhKf7/8ggidmDeA
					jQgo/wgfh8l3hOkEhJ/s]],
				["UpperLegB.L"] = [[
					eQiuhO+DeVf0q1eQiohR+XeVfYp7eQijhQ9seVfNrxeQimhO7UegfYwkeQithN3mevfz1keQiuhO43eYgA0DeQiohM7pd4gIv8eQijhJ+UdggEp5eQinhG/j
					dif2kseQithJ/Vd3fvmE]],
				["LowerLegB.L"] = [[
					eOiKgi28f1gF2SeMiHgjyUgWgE6OeMh9gntCgsf69NeMh0gzpxgqfu+deNh0hIp4gUfs+beNh2hClqgRf6/feNh3gwhVgKf//9eOiCgai8f5f6/2ePiWgQrJ
					fpgB9/eOiYgUyGfrgN6Y]],
				["FootB.L"] = [[
					eNhWgg+Jf4gDqueNhWg1+IgVf4queNhWhJ+IglfzqueNhWhe+Iggf1queNhWhy+JgMf8queNhkhy+QgOf7qYeNhyhj+YgKf9qCeNh4hO+bf3gDp4eNh0g3+Z
					fsgHp/eNhogm+SfygFqT]],
				["UpperLegB.R"] = [[
					hwiuhO43hogA0DhwiohM7piIf4v8hwijhJ+Uigf8p5hwinhG/jiegKkshwithJ/ViJgRmEhwiuhO+DhrgMq1hwiohR+Xhrgop7hwijhQ9shrgzrxhwimhO7U
					hggowkhwithN3mhRgN1k]],
				["LowerLegB.R"] = [[
					hzh2hClqfvgG/fhzh3gwhVf2gB/9hyiCgai8gHgG/2hxiWgQrJgXf/9/hyiYgUyGgVfz6YhyiKgi28gLf72Sh0iHgjyUfqf86Oh0h9gntCfUgG9Nh0h0gzpx
					fWgS+dhzh0hIp4fsgU+b]],
				["FootB.R"] = [[
					hzhkhy+QfygFqYhzhyhj+Yf2gDqChzh4hO+bgJf9p4hzh0g3+ZgUf5p/hzhogm+SgOf7qThzhWgg+JgIf9quhzhWg1+IfrgIquhzhWhJ+IfbgNquhzhWhe+I
					fggLquhzhWhy+Jf0gEqu]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAj7hLAYgAgAkygAj7hNAagAgAlCgAj8hTAigAgAlvgAj+hbAvgAgAmugAkAhkA+gAgAnwgAkChrBMgAgAongAkDhuBVgAgApFgAkChpBJgAgAoagAj6hLAY
					gAgAkygAjthDAPgAgAjwgAj0hIAVgAgAkcgAj4hLAYgAgAkygAj5hLAYgAgAkygAj5hLAYgAgAkygAj6hLAYgAgAkygAj6hLAYgAgAkygAj7hLAYgAgAkygA
					j7hLAYgAgAkygAj7hLAYgAgAky]],
				Spine1 = [[
					gAkHgkAYgAgAkygAkIgmAbgAgAlGgAkLgsAlgAgAl+gAkPg1A2gAgAnNgAkUg/BKgAgAofgAkXhHBegAgApjgAkZhMBqgAgAqIgAkXhFBZgAgApTgAkHgkAY
					gAgAkygAj3gbAIgAgAiqgAj/ghAQgAgAj7gAkEgkAWgAgAkngAkFgkAXgAgAkogAkFgkAXgAgAkrgAkGgkAXgAgAkugAkGgkAYgAgAkwgAkHgkAYgAgAkygA
					kHgkAYgAgAkygAkHgkAYgAgAky]],
				Spine2 = [[
					gAkTf8ACgAgAg9gAkVf/ADgAgAhWgAkagGAHgAgAiagAkhgQAQgAgAj6gAkpgcAfgAgAlfgAkvglAwgAgAmygAkygrA6gAgAnggAkugjArgAgAmegAkTf8AC
					gAgAg9gAj+fyAGgAgAdugAkJf5ABgAgAfkgAkQf8ABgAgAgogAkRf8ABgAgAgqgAkRf8ACgAgAgwgAkSf8ACgAgAg2gAkTf8ACgAgAg7gAkTf8ACgAgAg9gA
					kTf8ACgAgAg9gAkTf8ACgAgAg9]],
				Spine3 = [[
					gAkVfZACgAgAg9gAkYfbADgAgAhagAkffjAIgAgAiqgAkqfuAUgAgAkZgAk1f6AogAgAmPgAk+gFA+gAgAnvgAlDgLBMgAgAokgAk8gCA4gAgAnYgAkVfZAC
					gAgAg8gAj4fPAMgAgAcogAkIfVACgAgAfCgAkSfYABgAgAgdgAkSfYABgAgAghgAkTfZABgAgAgpgAkUfZACgAgAgygAkVfZACgAgAg6gAkVfZACgAgAg9gA
					kVfZACgAgAg9gAkVfZACgAgAg9]],
				Neck1 = [[
					gAkXe1CwgAgAs8gAkbe3C5gAgAtRgAkle/DUgAgAuJgAk0fLD9gAgAvYgAlDfZEsgAgAwpgAlPflFVgAgAxqgAlVfsFtgAgAyOgAlMfiFLgAgAxbgAkXe1Cv
					gAgAs5gAjxesA8gAgAnogAkGexBxgAgAqcgAkTe1CbgAgAsLgAkTe1CdgAgAsRgAkUe1CigAgAscgAkWe1CogAgAsrgAkXe1CtgAgAs2gAkXe1CwgAgAs8gA
					kXe1CwgAgAs8gAkXe1CwgAgAs8]],
				Neck2 = [[
					gAlmdtFEgAgAxPgAlrdyFNgAgAxdgAl6d+FmgAgAyDgAmOeSGLgAgAy3gAmheoG0gAgAzugAmxe8HXgAgA0agAm5fHHsgAgA0ygAmte3HPgAgA0PgAlmdtFB
					gAgAxLgAkidNB/gAgArEgAlIddDXgAgAuPgAledpEdgAgAwQgAlfdpEhgAgAwXgAlhdqEqgAgAwmgAljdsE1gAgAw5gAlldtE/gAgAxIgAlmdtFEgAgAxPgA
					lmdtFEgAgAxPgAlmdtFEgAgAxP]],
				Neck3 = [[
					gAnDdCEzgAgAw0gAnJdIE4gAgAw9gAnZdZFHgAgAxVgAnvdzFegAgAx3gAoFePF2gAgAyagAoVeoGKgAgAy2gAoee3GWgAgAzGgAoReiGFgAgAyvgAnCdCEv
					gAgAwvgAllb/BbgAgApYgAmZcgC1gAgAtGgAm3c3ECgAgAvhgAm5c5EHgAgAvrgAm8c7ETgAgAv/gAm/c+EhgAgAwXgAnCdBEtgAgAwrgAnDdCEzgAgAw0gA
					nDdCEzgAgAw0gAnDdCEzgAgAw0]],
				Head = [[
					gAoZcX/rgAgAkfgAofce/rgAgAkdgAoxcy/sgAgAkXgApIdO/tgAgAkPgApfdv/ugAgAkHgApxeL/vgAgAkAgAp6eb/vgAgAj8gApteE/vgAgAkCgAoYcW/q
					gAgAkngAmbaw9CgAgAtagAnhbg+ngAgApTgAoJcF/XgAgAmTgAoLcH/agAgAmGgAoPcL/fgAgAlqgAoTcQ/kgAgAlIgAoXcV/pgAgAktgAoZcX/rgAgAkfgA
					oZcX/rgAgAkfgAoZcX/rgAgAkf]],
				Jaw = [[
					gAnUcJ/8gAgAh2gAnacQ/6gAgAiJgAnscj/2gAgAi8gAoDc//ugAgAkEgAobdf/jgAgAlPgAosd7/YgAgAmOgAo1eL/RgAgAmwgAood0/bgAgAl/gAnTcI/7
					gAgAiGgAlZbK6MgAgAyXgAmbbn+CgAgAq/gAnDb+/igAgAlVgAnFb//ngAgAk8gAnJcC/ugAgAkGgAnOcF/1gAgAjGgAnScI/6gAgAiQgAnUcJ/8gAgAh3gA
					nUcJ/8gAgAh2gAnUcJ/8gAgAh2]],
				["UpperLegF.L"] = [[
					eQi9e1xYfFgA61eQjBe1w7fFf97IeQjMe2wBfFf37reQjce4vefGfu7/eQjte7vwfHfm71eQj9fAwnfIfh7UeQkFfCxVfJfe63eQj5e/wJfIfg7meQi9e1tj
					fCfx89eQiafEuUe3fv8leQite8vJe/f38KeQi4e3wqfDf97SeQi5e3wvfEf97QeQi6e3w5fEf+7JeQi7e2xGfFf/7BeQi8e1xSfFgA65eQi9e1xYfFgA62eQ
					i9e1xYfFgA61eQi9e1xYfFgA61]],
				["LowerLegF.L"] = [[
					eNiHfN7NgAgAw0eNiLfP7sgBgCwBeNiYfT8xgEgGt/eNipfX98gFgKrReNi6fa+4gFgOoXeNjIfb/cgDgPl3eNjPfb/rgCgQkdeNjFfc/hgDgRleeNiPfb9/
					gDgPrJeMhqfn/Zf7gbmGeNh7fd9zgAgPrpeNiDfT8JgBgFvOeNiEfS8DgBgEvZeNiFfR71gBgDvxeNiGfP7kgAgCwOeNiGfO7VgAgBwoeNiHfN7OgAgAw0eN
					iHfN7NgAgAw0eNiHfN7NgAgAw0]],
				["FootF.L"] = [[
					eNhWe1+PgAgAqdeNhce0+TgBgAqReNhtey+fgDf/pteNiFeu+vgFf/o2eNifer/AgEf/n4eNi0eo/NgDf/nAeNjAen/UgCf/mgeNizeo/MgDf/nEeNhsey+d
					gCf/pweNhWe1+Pf4gDqdeNhWe1+Pf/gAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeN
					hWe1+PgAgAqdeNhWe1+PgAgAqd]],
				["UpperLegF.R"] = [[
					hwi9e1xYg7gA61hwjBe1w7g7gD7IhwjMe2wBg7gJ7rhwjce4veg6gS7/hwjte7vwg5ga71hwj9fAwng4gf7UhwkFfCxVg3gi63hwj5e/wJg4gg7mhwi9e1tj
					g+gP89hwiafEuUhJgR8lhwite8vJhBgJ8Khwi4e3wqg9gD7Shwi5e3wvg8gD7Qhwi6e3w5g8gC7Jhwi7e2xGg7gB7Bhwi8e1xSg7gA65hwi9e1xYg7gA62hw
					i9e1xYg7gA61hwi9e1xYg7gA61]],
				["LowerLegF.R"] = [[
					hziHfN7NgAgAw0hziLfP7sf/f+wBhziYfT8xf8f6t/hzipfX98f7f2rRhzi6fa+4f7fyoXhzjIfb/cf9fxl3hzjPfb/rf+fwkdhzjFfc/hf9fvlehziPfb9/
					f9fxrJh0hqfn/ZgFflmGhzh7fd9zgAfxrphziDfT8Jf/f7vOhziEfS8Df/f8vZhziFfR71f/f9vxhziGfP7kgAf+wOhziGfO7VgAf/wohziHfN7OgAgAw0hz
					iHfN7NgAgAw0hziHfN7NgAgAw0]],
				["FootF.R"] = [[
					hzhWe1+PgAgAqdhzhce0+Tf/gAqRhzhtey+ff9gBpthziFeu+vf7gBo2hzifer/Af8gBn4hzi0eo/Nf9gBnAhzjAen/Uf+gBmghzizeo/Mf9gBnEhzhsey+d
					f+gBpwhzhWe1+PgIf9qdhzhWe1+PgBgAqdhzhWe1+PgAgAqdhzhWe1+PgAgAqdhzhWe1+PgAgAqdhzhWe1+PgAgAqdhzhWe1+PgAgAqdhzhWe1+PgAgAqdhz
					hWe1+PgAgAqdhzhWe1+PgAgAqd]],
				Tail1 = [[
					gAjwh9jpgAgA/ygAjwh/jxgAgA/xgAjviEkIgAgA/ugAjuiLkogAgA/qgAjsiTlKgAgA/kgAjsiZllgAgA/ggAjricl1gAgA/dgAjsiXlfgAgA/hgAjwh9jq
					gBgA/ygAjmh2kPgAgA/tgAjqh7kEffgD/ugAjuh9j3f0gB/wgAjuh9j2gAgA/wgAjuh9jygIf//xgAjvh9jugEgA/xgAjwh9jrgAgA/xgAjwh9jpgAgA/ygA
					jwh9jpgAgA/ygAjwh9jpgAgA/y]],
				Tail2 = [[
					gAjgjAkcgAgA/rgAjfjCkcgAgA/rgAjdjHkcgAgA/rgAjajOkcgAgA/rgAjXjUkcgAgA/rgAjUjZkcgAgA/rgAjSjckcgAgA/rgAjUjYkcgAgA/rgAjgjBke
					gCgA/rgAjUi4mpgqf9/Sf+jZi+lnfQgG/ff/jdjAk4fmgD/ngAjdjAk1f5gB/ogBjejAkugMf+/pgAjfjAkmgJf//qgAjgjAkfgBgA/rgAjgjAkcgAgA/rgA
					jgjAkcgAgA/rgAjgjAkcgAgA/r]],
				Tail3 = [[
					gAjNkDhegAgA/9gAjMkFhVgAgA/9gAjKkJg/gAgA/+gAjHkQgfgAgA//gAjEkWf9gAgA//gAjBkcfggAgA//gAi/kffRgAgA/+gAjCkafngAgA//gAjNkDhg
					gDgA/9gDi4j3lThugE/gf7jBj+jafYgD/zf9jIkCiIfbgB/6gAjJkCiDftgB/7gBjKkCh5gKgA/7gBjLkDhtgNf//8gAjNkDhjgDgA/9gAjNkDhegAgA/9gA
					jNkDhegAgA/9gAjNkDhegAgA/9]],
				Tail4 = [[
					gAjHlHfCgAgA/+gAjHlJeygAgA/9gAjGlOeEgAgA/7gAjFlUdEgAgA/2gAjElbcAgAgA/vgAjDlgbJgAgA/ngAjDljaqgAgA/igAjDlfbWgAgA/pgAjGlHfF
					gDgA/+gKihk4khiwgU/jf4iylBhvf0gE/8f7i/lGf7fYf///f+jAlGf0fhf///gCjClGfngDgA//gCjElHfWgOgA//gAjGlHfJgEgA/+gAjHlHfCgAgA/+gA
					jHlHfCgAgA/+gAjHlHfCgAgA/+]],
				Tail5 = [[
					gAjLmLbmgAgA/sgAjMmNbOgAgA/ogAjOmSaKgAgA/dgAjRmYYsgAgA/JgAjVmdXJgAgA+vgAjYmhV5gAgA+WgAjZmkVMgAgA+HgAjXmhWMgAgA+cgBjKmLbq
					gCgA/sgWiOl4ivjWgt/sf3irmFfDgYgN/+f4i/mKctfef8/0f8jBmLclfaf6/zgCjEmLcUf6f//xgDjHmLcAgMgC/vgBjKmLbvgFgB/tgAjLmLbngAgA/sgA
					jLmLbmgAgA/sgAjLmLbmgAgA/s]],
				["UpperLegB.L"] = [[
					eQi3hL6+eggAxIeQi4hM6+ehgAxIeQi5hP68ekgAxMeQi8hT6xepgCxeeQi+hX6UevgFyJeQjBha5Ze5gLzaeQjChc4UfBgS0xeQjAhZ5ue2gJy+eQi3hL7A
					eggAxGeQiqhH8QeQf3u6eQixhK7zeXf6vweQi1hL7Vedf9wkeQi1hL7Sedf+woeQi2hL7Neef+wweQi2hL7Geff/w7eQi3hL7BeggAxEeQi3hL6+eggAxIeQ
					i3hL6+eggAxIeQi3hL6+eggAxI]],
				["LowerLegB.L"] = [[
					eNiEgzwfgAgA7aeNiEg0wxgAgA7PeOiGg3xnf+f/6teOiHg8y8f8f85xeOiJhC0of4f54ceOiKhL2ofxf02nePiKhT4Sfrfv00eOiKhJ2Cfzf23MeNiEgzwc
					gAgA7ceNh7gnsagKgD9feNiAgsudgGgC8ieNiDgxv1gCgB7zeNiDgxv5gCgB7weNiDgxwDgBgB7reNiDgywPgBgA7keNiEgzwagAgA7deNiEgzwegAgA7beN
					iEgzwfgAgA7aeNiEgzwfgAgA7a]],
				["FootB.L"] = [[
					eNhWhL+JgAgAqueNhWhL+JgAgAqueNhWhL+Jf+gBqueNhWhL+Jf7gCqueNhWhL+Jf2gDqueNhWhL+IfvgGqueNhXhL+FfngJq4eNhWhL+IfxgFqueNhWhL+J
					gAgAqueNhWhL+JgKf9queNhWhL+JgGf+queNhWhL+JgCf/queNhWhL+JgCf/queNhWhL+JgBf/queNhWhL+JgBgAqueNhWhL+JgAgAqueNhWhL+JgAgAqueN
					hWhL+JgAgAqueNhWhL+JgAgAqu]],
				["UpperLegB.R"] = [[
					hwi3hL6+hggAxIhwi4hM6+hfgAxIhwi5hP68hcgAxMhwi8hT6xhXf+xehwi+hX6UhRf7yJhwjBha5ZhHf1zahwjChc4Ug/fu0xhwjAhZ5uhKf3y+hwi3hL7A
					hggAxGhwiqhH8QhwgJu6hwixhK7zhpgGvwhwi1hL7VhjgDwkhwi1hL7ShjgCwohwi2hL7NhigCwwhwi2hL7GhhgBw7hwi3hL7BhggAxEhwi3hL6+hggAxIhw
					i3hL6+hggAxIhwi3hL6+hggAxI]],
				["LowerLegB.R"] = [[
					hziEgzwfgAgA7ahziEg0wxgAgA7PhyiGg3xngCgB6thyiHg8y8gEgE5xhyiJhC0ogIgH4chyiKhL2ogPgM2nhxiKhT4SgVgR00hyiKhJ2CgNgK3MhziEgzwc
					gAgA7chzh7gnsaf2f99fhziAgsudf6f+8ihziDgxv1f+f/7zhziDgxv5f+f/7whziDgxwDf/f/7rhziDgywPf/gA7khziEgzwagAgA7dhziEgzwegAgA7bhz
					iEgzwfgAgA7ahziEgzwfgAgA7a]],
				["FootB.R"] = [[
					hzhWhL+JgAgAquhzhWhL+JgAgAquhzhWhL+JgCf/quhzhWhL+JgFf+quhzhWhL+JgKf9quhzhWhL+IgRf6quhzhXhL+FgZf3q4hzhWhL+IgPf7quhzhWhL+J
					gAgAquhzhWhL+Jf2gDquhzhWhL+Jf6gCquhzhWhL+Jf+gBquhzhWhL+Jf+gBquhzhWhL+Jf/gBquhzhWhL+Jf/gAquhzhWhL+JgAgAquhzhWhL+JgAgAquhz
					hWhL+JgAgAquhzhWhL+JgAgAqu]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAj7hLAYgAgAkygAj6hOAXgAgAktgAj4hUAWgAgAkkgAj3haAVgAgAkagAj2hcAUgAgAkXgAj4hVAWgAgAkjgAj8hKAfgAgAldgAj+hFArgAgAmdgAj/hEAu
					gAgAmtgAj/hEAugAgAmtgAj/hEAugAgAmtgAj/hEAugAgAmtgAj/hEAugAgAmtgAj/hEAugAgAmtgAj/hEAugAgAmtgAj/hEAugAgAmtgAj/hEAugAgAmtgA
					j/hEAugAgAmtgAj/hEAugAgAmtgAj+hFArgAgAmegAj9hIAhgAgAlrgAj7hLAZgAgAk7gAj7hLAYgAgAkygAj7hLAYgAgAkygAj7hLAYgAgAky]],
				Spine1 = [[
					gAkHgkAYgAgAkygAkGgmAXgAgAkrgAkEgtAVgAgAkagAkCgzASgAgAkKgAkBg1ASgAgAkGgAkEguAUgAgAkZgAkKgjAhgAgAlpgAkPgfAxgAgAm7gAkQgeA2
					gAgAnQgAkQgeA2gAgAnQgAkQgeA2gAgAnQgAkQgeA2gAgAnQgAkQgeA2gAgAnQgAkQgeA2gAgAnQgAkQgeA2gAgAnQgAkQgeA2gAgAnQgAkQgeA2gAgAnQgA
					kQgeA2gAgAnQgAkQgeA2gAgAnQgAkPgfAygAgAm9gAkLghAkgAgAl7gAkHgjAagAgAk+gAkHgkAYgAgAkygAkHgkAYgAgAkygAkHgkAYgAgAky]],
				Spine2 = [[
					gAkTf8ACgAgAg9gAkSf/ACgAgAgzgAkPgFABgAgAgcgAkNgLABgAgAgGgAkMgNABgAgAf/gAkPgGABgAgAgagAkYf8AFgAgAiBgAkgf6AOgAgAjogAkif5AR
					gAgAkBgAkif5ARgAgAkBgAkif5ARgAgAkBgAkif5ARgAgAkBgAkif5ARgAgAkBgAkif5ARgAgAkBgAkif5ARgAgAkBgAkif5ARgAgAkBgAkif5ARgAgAkBgA
					kif5ARgAgAkBgAkif5ARgAgAkBgAkgf6AOgAgAjqgAkaf7AHgAgAiYgAkUf8ACgAgAhMgAkTf8ACgAgAg9gAkTf8ACgAgAg9gAkTf8ACgAgAg9]],
				Spine3 = [[
					gAkVfZACgAgAg9gAkUfbACgAgAgxgAkQfhABgAgAgTgAkNfnABgAgAf2gAkMfpABgAgAfugAkQfiABgAgAgQgAkdfZAGgAgAiNgAkofXASgAgAkGgAkrfXAW
					gAgAklgAkrfXAWgAgAklgAkrfXAWgAgAklgAkrfXAWgAgAklgAkrfXAWgAgAklgAkrfXAWgAgAklgAkrfXAWgAgAklgAkrfXAWgAgAklgAkrfXAWgAgAklgA
					krfXAWgAgAklgAkrfXAWgAgAklgAkofXASgAgAkJgAkffXAIgAgAipgAkXfYADgAgAhPgAkVfZACgAgAg9gAkVfZACgAgAg9gAkVfZACgAgAg9]],
				Neck1 = [[
					gAkXe1CwgAgAs8gAkVe3CpgAgAsrgAkRe9CYgAgAsDgAkNfDCJgAgArdgAkLfFCEgAgArSgAkQe+CXgAgAsBgAkhe1DogAgAuxgAkxe0FLgAgAxagAk1e0Fm
					gAgAyDgAk1e0FmgAgAyDgAk1e0FmgAgAyDgAk1e0FmgAgAyDgAk1e0FmgAgAyDgAk1e0FmgAgAyDgAk1e0FmgAgAyDgAk1e0FmgAgAyDgAk1e0FmgAgAyDgA
					k1e0FmgAgAyDgAk1e0FmgAgAyDgAkxe0FNgAgAxegAkle0D9gAgAvYgAkae1C8gAgAtWgAkXe1CwgAgAs8gAkXe1CwgAgAs8gAkXe1CwgAgAs8]],
				Neck2 = [[
					gAlmdtFEgAgAxPgAljduE3gAgAw7gAlbdxEagAgAwKgAlUd0D/gAgAvcgAlRd1D3gAgAvOgAladyEYgAgAwHgAl5d4GrgAgAzigAmSeJJegAgA2tgAmYeOKP
					gAgA3cgAmYeOKPgAgA3cgAmYeOKPgAgA3cgAmYeOKPgAgA3cgAmYeOKPgAgA3cgAmYeOKPgAgA3cgAmYeOKPgAgA3cgAmYeOKPgAgA3cgAmYeOKPgAgA3cgA
					mYeOKPgAgA3cgAmYeOKPgAgA3cgAmTeJJigAgA2wgAl/d7HQgAgA0RgAlqdvFZgAgAxwgAlmdtFEgAgAxPgAlmdtFEgAgAxPgAlmdtFEgAgAxP]],
				Neck3 = [[
					gAnDdCEzgAgAw0gAm/dBEjgAgAwbgAm0c/EAgAgAvegAmqc9DhgAgAujgAmnc9DYgAgAuSgAm0dAD+gAgAvbgAncdeG2gAgAzxgAn5eKKhgAgA3sgAn+eVLi
					gAgA4lgAn+eVLigAgA4lgAn+eVLigAgA4lgAn+eVLigAgA4lgAn+eVLigAgA4lgAn+eVLigAgA4lgAn+eVLigAgA4lgAn+eVLigAgA4lgAn+eVLigAgA4lgA
					n+eVLigAgA4lgAn+eVLigAgA4lgAn5eKKmgAgA3xgAnjdnHmgAgA0rgAnJdIFOgAgAxfgAnDdCEzgAgAw0gAnDdCEzgAgAw0gAnDdCEzgAgAw0]],
				Head = [[
					gAoZcX/rgAgAkfgAoTcU/lgAgAlFgAoGcM/VgAgAmdgAn4cF/CgAgAnxgAn0cD+8gAgAoJgAoFcM/UgAgBmhgAo5dI//gAgAfhgApYeT/KgafRY1gApden+S
					fdgzVvgApden+hgAgAWagApden+tghfMXHgApden+SfdgzVvgApden+hgAgAWagApden+tghfMXHgApden+SfdgzVvgApden+hgAgAWagApden+tghfMXHgA
					pden+SfdgzVvgApden+hgAgAWagApZeU/IgbfRYsgApCdX/5f2gbdlgAohch/zgAgAjagAoZcX/rgAgAkfgAoZcX/rgAgAkfgAoZcX/rgAgAkf]],
				Jaw = [[
					gAnUcJ/8gAgAh2gAnOcI/4gAgAingAnAcG/rgAgAkcgAmycF/ZgAgAmJgAmucF/SgAgAmpgAm/cH/pgAgBkqgAn8cl//gAgAgEf/ovda/3ghfVdZgBo/dn/o
					fUgsbSgAo9do/vgAgAcAf/o6dq/zgqfScugBo/dn/ofUgsbSgAo9do/vgAgAcAf/o6dq/zgqfScugBo/dn/ofUgsbSgAo9do/vgAgAcAf/o6dq/zgqfScugB
					o/dn/ofUgsbSgAo9do/vgAgAcAf/owdb/3ghfVdWgAoJct/9f1gaezgAndcO/9gAgAhZgAnUcJ/8gAgAh2gAnUcJ/8gAgAh2gAnUcJ/8gAgAh2]],
				["UpperLegF.L"] = [[
					eQi9e1xYfFgA61eQi7e4xafEf/60eQi3fBxyfBf86keQizfJyee+f66GeQixfMyue9f657eQi2fCx5fBf86geQjIeuy3fJgE51eQjZei1afTgO3weQjdeg1T
					fUgN32eQjdeg1TfUgN32eQjdeg1TfUgN32eQjdeg1TfUgN32eQjdeg1TfUgN32eQjdeg1TfUgN32eQjdeg1TfUgN32eQjdeg1TfUgN32eQjdeg1TfUgN32eQ
					jdeg1TfUgN32eQjdeg1TfUgN32eQjZei1YfTgN3yeQjLerr3fFfu9seQi/ezshfDfv9beQi9e1xVfFgA63eQi9e1xYfFgA61eQi9e1xYfFgA61]],
				["LowerLegF.L"] = [[
					eNiHfN7NgAgAw0eNiFfR70gAgCvzeNiAfY9Af/gHtgeNh6fd93f9gKrdeNh5ff+Ff9gLq5eNh/fZ9If/gHtNeOiPfA5af+f4zcePidep1ff2fo3sePiien1Y
					f3fo3zePiien1Yf3fo3zePiien1Yf3fo3zePiien1Yf3fo3zePiien1Yf3fo3zePiien1Yf3fo3zePiien1Yf3fo3zePiien1Yf3fo3zePiien1Yf3fo3zeP
					iien1Yf3fo3zePiien1Yf3fo3zePieep1df2fn3ueNiifW9MgIgLtGeNiUfc9zgFgPrneNiHfN7PgAgAwxeNiHfN7NgAgAw0eNiHfN7NgAgAw0]],
				["FootF.L"] = [[
					eNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+Pf+gBqdeNhWe1+Pf8gBqdeNhWe1+Pf8gBqdeNhWe1+Pf+gBqdeNhaey+Pf/gAqdeOhneu9mf4gAsJeOhset9V
					f5f+sxeOhset9Vf5f+sxeOhset9Vf5f+sxeOhset9Vf5f+sxeOhset9Vf5f+sxeOhset9Vf5f+sxeOhset9Vf5f+sxeOhset9Vf5f+sxeOhset9Vf5f+sxeO
					hset9Vf5f+sxeOhset9Vf5f+sxeOhoeu9wf4gArveNh6ey+PgGf+qdeNhwe0+PgDf/qdeNhWe1+PgAgAqdeNhWe1+PgAgAqdeNhWe1+PgAgAqd]],
				["UpperLegF.R"] = [[
					hwi9e1xYg7gA61hwi7e4xag8gB60hwi3fBxyg/gE6khwizfJyehCgG6GhwixfMyuhDgG57hwi2fCx5g/gE6ghwjIeuy3g3f851hwjZei1agtfy3whwjdeg1T
					gsfz32hwjdeg1Tgsfz32hwjdeg1Tgsfz32hwjdeg1Tgsfz32hwjdeg1Tgsfz32hwjdeg1Tgsfz32hwjdeg1Tgsfz32hwjdeg1Tgsfz32hwjdeg1Tgsfz32hw
					jdeg1Tgsfz32hwjdeg1Tgsfz32hwjZei1Zgtfz3xhwjLeruTg5gJ8mhwi/ezuSg9gK8nhwi9e1xWg7gA63hwi9e1xYg7gA61hwi9e1xYg7gA61]],
				["LowerLegF.R"] = [[
					hziHfN7NgAgAw0hziFfR70gAf+vzhziAfY9AgBf5tghzh6fd93gDf2rdhzh5ff+FgDf1q5hzh/fZ9IgBf5tNhyiPfA5agCgIzchxidep1fgKgY3shxiien1Y
					gJgY3zhxiien1YgJgY3zhxiien1YgJgY3zhxiien1YgJgY3zhxiien1YgJgY3zhxiien1YgJgY3zhxiien1YgJgY3zhxiien1YgJgY3zhxiien1YgJgY3zhx
					iien1YgJgY3zhxiien1YgJgY3zhxieeo1egKgZ3thzicfO79f6f8vihziQfX87f8f2tqhziHfN7PgAgAwyhziHfN7NgAgAw0hziHfN7NgAgAw0]],
				["FootF.R"] = [[
					hzhWe1+PgAgAqdhzhWe1+PgAgAqdhzhWe1+PgCf/qdhzhWe1+PgEf/qdhzhWe1+PgEf/qdhzhWe1+PgCf/qdhzhaey+PgBgAqdhyhneu9mgIgAsJhyhset9V
					gHgCsxhyhset9VgHgCsxhyhset9VgHgCsxhyhset9VgHgCsxhyhset9VgHgCsxhyhset9VgHgCsxhyhset9VgHgCsxhyhset9VgHgCsxhyhset9VgHgCsxhy
					hset9VgHgCsxhyhset9VgHgCsxhyhoeu9sgIgAr7hzhuey+Pf7gCqdhzhme0+Pf9gBqdhzhWe1+PgAgAqdhzhWe1+PgAgAqdhzhWe1+PgAgAqd]],
				Tail1 = [[
					gAjwh9jpgAgA/ygAjviAjdgAgA/zgAjuiHi/gAgA/2gAjtiNiigAgA/5gAjtiPiagAgA/5gAjuiIi8gAgA/2gAjvh7k4fmgC/ngAjuh2mwgQgA/RgAjuh0nO
					g+gA/JgAjuh0nOfNgA/KgAjuh0nOfcgA/KgAjuh0nOhFgA/JgAjuh0nOgAgA/KgAjuh0nOe7gA/JgAjuh0nOgkgA/KgAjuh0nOgzgA/KgAjuh0nOfCgA/JgA
					juh0nOfugA/KgAjuh0nOhHgA/JgAjuh2mzfwgA/QgAjvh5lUfjgC/igAjwh9j7gEgA/wgAjwh9jpgAgA/ygAjwh9jpgAgA/ygAjwh9jpgAgA/y]],
				Tail2 = [[
					gAjgjAkcgAgA/rgAjhjDkHgAgA/ugAjhjKjVgAgA/0gAjijRimgAgA/4gAjjjTiYgAgA/5gAjhjLjRgBgA/0f+jai9mNfQgF/XgBjSi0o8f6f/+tgEjQiypm
					iFf9+cf9jQiypmfCgE+gf+jQiypmebgB+egFjQiypmhyf8+dgAjQiypmgqgB+gf7jQiypld5gE+cgCjQiypngcf9+ggDjQiypmh5f++df8jQiypmelgE+ff/
					jQiypme2gA+fgFjQiypmiBf8+df/jSi0o/gGgC+sf+jYi6m2fDgF/PgAjfjAk2gFf//ngAjgjAkcgAgA/rgAjgjAkcgAgA/rgAjgjAkcgAgA/r]],
				Tail3 = [[
					gAjNkDhegAgA/9gAjPkGhAgAgA/+gAjTkOf6gAgA//gAjXkVe3gAgA/+gAjYkXekgAgA/9gAjTkPfzgCgA//f7jAj9j0fIgB/wgBitjvndfGf3/GgNiojqoV
					i5gM+wf5iojroWfigH+4f3iojroVdXfx+xgMiojqoVh1gB+1gDiojroVhtgO+1fziojqoVdSf3+xgEiojroWftf2+4gLiojqoVi3gO+wf2iojroWe0gD+3f6
					iojroVdwfx+zgNiojqoViXgF+zf/isjunhg6gJ/Ff6i8j5kreqgA/ngBjKkBiAgCgA/7gAjNkDhegAgA/9gAjNkDhegAgA/9gAjNkDhegAgA/9]],
				Tail4 = [[
					gAjHlHfCgAgA/+gAjLlLecgAgA/9gAjUlTdCgAgA/2gAjclZbtgAgA/sgAjelbbUgAgA/pgAjUlUc5gCgA/1f3iwlAh8fQf//7f9iOksmfeLfl/RgZiGklnm
					jHgU+6f3iGkmnmgfgZ/EfsiGklnmcpff+5gTiGklnmhQf4/DgKiGkmnmitgl+9foiGklnmdWf0+9gDiGkmnmerfh/CgXiGklnmjWgc+5fxiGkmnmfmgR/Efw
					iGklnmc3fc+6gXiGklnmiBgC/AgDiNkrmlh2gc/Qf0iok6jCejf6/0gBjClFfsf9gA//gAjHlHfCgAgA/+gAjHlHfCgAgA/+gAjHlHfCgAgA/+]],
				Tail5 = [[
					gAjLmLbmgAgA/sgAjRmPa4gAgA/lgAjgmWZMgAgA/QgAjumbXmgAgA+3gAjymdXJgAgA+vgAjhmXZCgDgA/Of0inmDfDflgA/+f1hzlqkidhfK/jgmhnlgl3
					irgS/Vf5hmljl3hdg6/Zfehnlgl3clfQ/QgYhmlil3gVff/cgWhnlhl3jQhB/Qfchnlgl3d/f//Yf9hmljl3dye//Wglhnlgl3jKgj/Sfwhmlil3glgv/cfj
					hnlhl4cjfF/Pgfhnlhl3hNfw/bgLhylpkpihg3/ifuibl9gXexf2/9gBjDmKcZf4f//ygAjLmLbmgAgA/sgAjLmLbmgAgA/sgAjLmLbmgAgA/s]],
				["UpperLegB.L"] = [[
					eQi3hL6+eggAxIeQi3hO7Veef+wjeQi1hV8Febf7vOeQizhc8reYf4uEeQizhe81eXf4tveQi1hW8Leaf7vDeQi5hH6XekgCyEeQi7g+4veugI0PeQi8g84T
					exgJ0xeQi8g84TexgJ0xeQi8g84TexgJ0xeQi8g84TexgJ0xeQi8g84TexgJ0xeQi8g84TexgJ0xeQi8g84TexgJ0xeQi8g84TexgJ0xeQi8g84TexgJ0xeQ
					i8g84TexgJ0xeQi8g84TexgJ0xeQi7g+4tevgI0SeQi5hE56engEyteQi4hK60ehgBxYeQi3hL6+eggAxIeQi3hL6+eggAxIeQi3hL6+eggAxI]],
				["LowerLegB.L"] = [[
					eNiEgzwfgAgA7aeNiEg0wugAgB7ReNiFg2xbgAgD61eNiHg5yOf/gE6SeNiHg6yff+gF6HeNiFg2xigAgD6weOiDgywVgAf+7geOiEgywXf8f67feOiEgzwg
					f7f57aeOiEgzwgf7f57aeOiEgzwgf7f57aeOiEgzwgf7f57aeOiEgzwgf7f57aeOiEgzwgf7f57aeOiEgzwgf7f57aeOiEgzwgf7f57aeOiEgzwgf7f57aeO
					iEgzwgf7f57aeOiEgzwgf7f57aeOiEgywYf8f67feOiDgywPf/f97keNiEgzwbgAf/7deNiEgzwfgAgA7aeNiEgzwfgAgA7aeNiEgzwfgAgA7a]],
				["UpperLegB.R"] = [[
					hwi3hL6+hggAxIhwi3hO7VhigCwjhwi1hV8FhlgFvOhwizhc8rhogIuEhwizhe81hpgItvhwi1hW8LhmgFvDhwi5hH6Xhcf+yEhwi7g+4vhSf40Phwi8g84T
					hPf30xhwi8g84ThPf30xhwi8g84ThPf30xhwi8g84ThPf30xhwi8g84ThPf30xhwi8g84ThPf30xhwi8g84ThPf30xhwi8g84ThPf30xhwi8g84ThPf30xhw
					i8g84ThPf30xhwi8g84ThPf30xhwi7g+4thRf40Shwi5hE56hZf8ythwi4hK60hff/xYhwi3hL6+hggAxIhwi3hL6+hggAxIhwi3hL6+hggAxI]],
				["LowerLegB.R"] = [[
					hziEgzwfgAgA7ahziEg0wugAf/7RhziFg2xbgAf961hziHg5yOgBf86ShziHg6yfgCf76HhziFg2xigAf96whyiDgywVgAgC7ghyiEgywXgEgG7fhyiEgzwg
					gFgH7ahyiEgzwggFgH7ahyiEgzwggFgH7ahyiEgzwggFgH7ahyiEgzwggFgH7ahyiEgzwggFgH7ahyiEgzwggFgH7ahyiEgzwggFgH7ahyiEgzwggFgH7ahy
					iEgzwggFgH7ahyiEgzwggFgH7ahyiEgywYgEgG7fhyiDgywPgBgD7khziEgzwbgAgB7dhziEgzwfgAgA7ahziEgzwfgAgA7ahziEgzwfgAgA7a]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAj7hLAYgAgAkygAj8hPAlgAgAl8gAkBhXBIgAgAoXgAkDhcBlgAgAp4gAkDhcBmgAgAp8gAkDhcBmgAgAp8gAkDhcBmgAgAp8gAkDhcBmgAgAp8gAkDhcBm
					gAgAp8gAkPhcBmgAgAp8gAkUhcBmgAgAp8gAkPhcBmgAgAp8gAkDhcBmgAgAp8gAkDhcBmgAgAp8gAkDhcBmgAgAp8gAkDhcBmgAgAp8gAkDhcBmgAgAp8gA
					kDhbBfgAgApmgAkAhVA/gAgAn1gAj8hOAigAgAltgAj7hLAYgAgAky]],
				Spine1 = [[
					gAkHgkAYgAgAkygAkMgpAngAgAmIgAkVgzBSgAgAo7gAkbg7B2gAgAqrgAkcg7B3gAgAqugAkcg7B3gAgAqugAkcg7B3gAgAqugAkcg7B3gAgAqugAkcg7B3
					gAgAqugAkog7B3gAgAqugAktg7B3gAgAqugAkog7B3gAgAqugAkcg7B3gAgAqugAkcg7B3gAgAqugAkcg7B3gAgAqugAkcg7B3gAgAqugAkcg7B3gAgAqugA
					kag5BvgAgAqVgAkTgxBHgAgAoTgAkLgoAkgAgAl3gAkHgkAYgAgAky]],
				Spine2 = [[
					gAkTf8ACgAgAg9gAkbgCAHgAgAiggAkrgRAigAgAlwgAk1gbA/gAgAnzgAk2gbBAgAgAn3gAk2gbBAgAgAn3gAk2gbBAgAgAn3gAk2gbBAgAgAn3gAk2gbBA
					gAgAn3gAlCgbBAgAgAn3gAlHgbBAgAgAn3gAlCgbBAgAgAn3gAk2gbBAgAgAn3gAk2gbBAgAgAn3gAk2gbBAgAgAn3gAk2gbBAgAgAn3gAk2gbBAgAgAn3gA
					kzgZA5gAgAnagAkogNAagAgAlCgAkZgBAGgAgAiNgAkTf8ACgAgAg9]],
				Spine3 = [[
					gAkVfZACgAgAg9gAkhffAIgAgAisgAk4fvApgAgAmUgAlGf7BMgAgAomgAlHf8BOgAgAoqgAlHf8BOgAgAoqgAlHf8BOgAgAoqgAlHf8BOgAgAoqgAlHf8BO
					gAgAoqgAlTf8BOgAgAoqgAlYf8BOgAgAoqgAlTf8BOgAgAoqgAlHf8BOgAgAoqgAlHf8BOgAgAoqgAlHf8BOgAgAoqgAlHf8BOgAgAoqgAlHf8BOgAgAoqgA
					lEf5BFgAgAoKgAkzfrAggAgAlhgAkefeAHgAgAiXgAkVfZACgAgAg9]],
				Neck1 = [[
					gAkXe1CwgAgAs8gAkne8DOgAgAt9gAlGfOEVgAgAwCgAlZfdFHgAgAxUgAlZfdFJgAgAxXgAlZfdFJgAgAxXgAlZfdFJgAgAxXgAlZfdFJgAgAxXgAlZfdFJ
					gAgAxXgAllfdFJgAgAxXgAlqfdFJgAgAxXgAllfdFJgAgAxXgAlZfdFJgAgAxXgAlZfdFJgAgAxXgAlZfdFJgAgAxXgAlZfdFJgAgAxXgAlZfdFJgAgAxXgA
					lVfaE9gAgAxFgAk/fKEEgAgAvlgAkke6DIgAgAtwgAkXe1CwgAgAs8]],
				Neck2 = [[
					gAlmdtFEgAgAxPgAl6d6FVgAgAxqgAmieZF7gAgAyhgAm6ewGUgAgAzEgAm6exGVgAgAzFgAm6exGVgAgAzFgAm6exGVgAgAzFgAm6exGVgAgAzFgAm6exGV
					gAgAzFgAnGexGVgAgAzFgAnMexGVgAgAzFgAnGexGVgAgAzFgAm6exGVgAgAzFgAm6exGVgAgAzFgAm6exGVgAgAzFgAm6exGVgAgAzFgAm6exGVgAgAzFgA
					m1esGPgAgAy9gAmaeSFygAgAyVgAl2d3FSgAgAxlgAlmdtFEgAgAxP]],
				Neck3 = [[
					gAnDdCEzgAgAw0gAnZdSEvgAgAwtgAoDd3EmgAgAwfgAoceTEggAgAwWgAoceUEggAgAwWgAoceUEggAgAwWgAoceUEggAgAwWgAoceUEggAgAwWgAoceUEg
					gAgAwWgAopeUEggAgAwWgAoueUEggAgAwWgAopeUEggAgAwWgAoceUEggAgAwWgAoceUEggAgAwWgAoceUEggAgAwWgAoceUEggAgAwWgAoceUEggAgAwWgA
					oXeNEhgAgAwYgAn6duEogAgAwigAnUdPEvgAgAwvgAnDdCEzgAgAw0]],
				Head = [[
					gAoZcX/rgAgAkfgAoucm/ogcgEkvgApYdK/eiMgQlPgApwdl/WjIgVljgApxdm/ch9gNllgApxdm/ggAgAllgApxdm/ceDfzllgApxdm/Wc2frlkgApxdm/W
					c2frlkgAp9dm/ceDfzllgAqCdm/ggAgAllgAp9dm/ch9gNllgApxdm/WjKgVlkgApxdm/WjKgVlkgApxdm/ch9gNllgApxdm/ggAgAllgApxdm/ceDfzllgA
					psdg/YdDfslfgApPdC/heJfylIgAoqcj/pfqf9ksgAoZcX/rgAgAkf]],
				Jaw = [[
					gAnUcJ/8gAgAh2gCnpcZ/zgcgDjfgJoTc//KiLgYm5gOosdb+ijFgspAgIosdc+mh7gbpGgAordc+qgAgApHf4osdc+meFflpGfyosdc+gc5fUpEfyosdc+g
					c5fUpEf4o4dc+meFflpGgAo8dc+qgAgApHgIo4dc+mh7gbpGgOosdc+gjHgspEgOosdc+gjHgspEgIosdc+mh7gbpGgAordc+qgAgApHf4osdc+meFflpGfz
					ondW+qdGfZonf4oKc2/VeKfumJf+nlcW/1fqf+jKgAnUcJ/8gAgAh2]],
				["UpperLegF.L"] = [[
					eQi9e1xYfFgA61eQjNeyuvfGf18YeQjxewq6fKff+DeQkJezuAfMfb8veQkKezyxfJfn55eQkKez07fJft4MeQkKezyxfJfn55eQkKezuDfMfa8ueQkKezqK
					fQfR+UeQkWezrFfPfT9/eQkbezvufLff72eQkWezz6fJfq5BeQkKez0qfJft4aeQkKezxVfKfj63eQkKezscfNfW9deQkKezp1fQfQ+beQkKezscfNfW9deQ
					kEeyw9fJfk7HeQjpewyAfHfy6beQjKeyw+fGf77GeQi9e1xYfFgA61]],
				["LowerLegF.L"] = [[
					eNiHfN7NgAgAw0eNicfU8qgGgHuNeNjLfe+ggIgNpneNjafX/ZgFgPmIeNjRfF/BgFgKn1eNjPe7+lgDgFpZeNjRfF/BgFgKn1eNjbfX/bgFgPmAeNjmfi/a
					gCgMmCeNjvfg/cgDgNl6eNjofR/WgFgOmaeNjcfA+0gEgIomeNjPe8+pgDgFpLeNjTfL/NgFgNnDeNjffc/cgEgPl3eNjnfj/ZgCgMmGeNjffc/cgEgPl3eN
					jPfM/CgGgMnueNixfG9qgEgGr/eNiUfM8JgCgDvNeNiHfN7NgAgAw0]],
				["FootF.L"] = [[
					eNhWe1+PgAgAqdeNhxez+0gFf/oleNirex/ugJf/kDeNjGel/+gIgAhEeNi3eV/+gHgAg+eNiweO/+gEgAg+eNi3eV/+gHgAg+eNjHel/+gIgAg+eNjSew/+
					gFgAg+eNjbet/+gGgAg+eNjSef/+gIgAg+eNjAeR/+gFgAg+eNixeP/+gEgAg+eNi8ea/+gIgAg+eNjLep/+gHgAg+eNjSex/+gEgAg+eNjLep/+gHgAg+eN
					i1ec/8gIgAhoeNiLef/lgEf/lGeNhnev+tgCf/o9eNhWe1+PgAgAqd]],
				["UpperLegF.R"] = [[
					hwi9e1xYg7gA61hwjNeyw7g6gH7Ihwjxewyhg5gQ6EhwkJezxSg2gd66hwkKezscgzgq9dhwkKezp1gwgw+bhwkKezscgzgq9dhwkKezxVg2gd63hwkKez0q
					g3gT4ahwkWezz6g3gW5Bhwkbezvug1gh72hwkWezrFgxgt9/hwkKezqKgwgv+UhwkKezuDg0gm8uhwkKezyxg3gZ55hwkKez07g3gT4MhwkKezyxg3gZ55hw
					kEeyt0g1gk81hwjpewrfg4gc91hwjKeyvMg7gJ8Jhwi9e1xYg7gA61]],
				["LowerLegF.R"] = [[
					hziHfN7NgAgAw0hziXfM8Wf9f9u1hzi5fE99f8f6rNhzjTfL/Lf7f0nJhzjffc/cf8fxl3hzjnfj/Zf+f0mGhzjffc/cf8fxl3hzjTfL/Nf7fznDhzjPe8+p
					f9f7pLhzjcfA+0f8f4omhzjofR/Wf7fymahzjvfg/cf9fzl6hzjmfi/af+f0mChzjbfX/bf7fxmAhzjRfF/Bf7f2n1hzjPe7+lf9f7pZhzjRfF/Bf7f2n1hz
					jWfX/Qf6fym2hzjBfc+Kf3f0qqhziYfT8bf7f6uqhziHfN7NgAgAw0]],
				["FootF.R"] = [[
					hzhWe1+PgAgAqdhzhret+0f+gBolhziVeb/uf7gBkDhzi7ea/+f4gAhEhzjLep/+f5gAg+hzjSex/+f8gAg+hzjLep/+f5gAg+hzi8ea/+f4gAg+hzixeP/+
					f8gAg+hzjAeR/+f7gAg+hzjSef/+f4gAg+hzjbet/+f6gAg+hzjSew/+f7gAg+hzjHel/+f4gAg+hzi3eV/+f5gAg+hziweO/+f8gAg+hzi3eV/+f5gAg+hz
					i/em/8f4gAhohzifey/lf3gBlGhzhsez+tf8gBo9hzhWe1+PgAgAqd]],
				Tail1 = [[
					gAjwh9jpgAgA/ygAjuiAkog6f8/pgAjriFmqjTgE/HgAjpiIn/higH+8gAjpiIoAdEfx+1gAjpiIn8bBfn+lgAjpiIoAdEfx+1gAjpiIoBhjgI+7gAjpiIn8
					kwgY+ngAj1iIn+kDgU+tgAj6iIoCgAgA+9gAj1iIn+b9fs+tgAjpiIn8bQfo+ngAjpiIoBedf4+7gAjpiIoAi8gP+1gAjpiIn8k/gZ+lgAjpiIoAi8gP+1gA
					jpiInvekf6/AgAjriEmNdNgA/QgAjuiAkcfSgE/rgAjwh9jpgAgA/y]],
				Tail2 = [[
					gAjgjAkcgAgA/rgEjajClPhcf3/hgOjPjDmvmtf9+jgHjHjEn3k7gN+nf0jIjDn8cIfw+vfrjIjBnnWmff9nf0jIjDnxYufq+KgHjHjEn/g7gH+9gUjIjCns
					oVge96gRjUjCnpo3gd9xgAjYjFn+iJgE+6fvjUjCn0Zlfn+WfsjIjCnmWafg9jf5jHjEn5bCfy+mgMjIjDn8j4gQ+vgVjIjBnnpagh9ngMjIjDnxnSgW+Kf6
					jJjEnwfJf7/Bf0jRjDmdbEgI+8f9jbjClFeagL/igAjgjAkcgAgA/r]],
				Tail3 = [[
					gAjNkDhegAgA/9gKjEkDiFhhgA/4gpizj8jMpgg2+Xgbinj+j+pWhN+Ufjinj+kPdbfa/mfFirjzjzTueG9OfWioj5j1UEeW9YgLimkBkQeOf+/qg2iqj1j9
					p+ho+Gg1i2j1jutSh78zgJi3kAkKl8gr/JfUi0j6kIZXe1+/fFirjzjtSmeA8vflinj+kAWkey+Sgdinj+kPilgm/mg7irjzjzsSh69Ogqioj5j1r8hq9Yf2
					iokBkEhqgC/sfgi2j/jCaBfj/Rf2jGkDh9digC/1gAjNkDhegAgA/9]],
				Tail4 = [[
					gAjHlHfCgAgA/+gQi7lHfehGgH/+hQinkzgRrIh797hCiZk0gstwiy8vfYiVk/hDgqfm/9eUifkhguS2cs89emickpglQJck7kgDiUlCg/aEfL/ahfickrg4
					pdim+chpirkggjwZju7Ngiimk+g2qfh8+Je4ikk2hAbUea/leRigkdgmQgcU7ve+iYk0gtSJdL8rgoiVk/hDfWga/9hsifkhgutKjU89haickpglv3jc7kf9
					iXlDg3ljgv/ffGiqk+gKaRfB/dfsi+lGfYc2fz/1gAjHlHfCgAgA/+]],
				Tail5 = [[
					gAjLmLbmgAgA/sgVi9mLb2gRgH/uh9iplnchrMjY9kh3iblfc4w8lZ6afbiRmDc4lHgu/adhiilOc4UQbK9MdrihlLc4N8Z45ffqiQmCc4VjdU99iGicljc4
					mxjU+7ilixlAc4xgmQ52hNimlzc4uikT8Aekihl3c4fHeo/ydXillBc4QnaK7QeIiblfc4O7ai6TgliRmDc4a5fS/aifiilOc4rwk29MiVihlLc4yEmI5fgV
					iUmDcypzic+Meuiql+cTbzem/dfejAmJb0chfZ/hgAjLmLbmgAgA/s]],
				["UpperLegB.L"] = [[
					eQi3hL6+eggAxIeQi5hK6gelgCx2eQi/hI47e1gI0AeQjDhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2J
					fJgT3EeQjQhG2JfJgT3EeQjVhG2JfJgT3EeQjQhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2JfJgT3EeQjEhG2JfJgT3EeQ
					jChH24fEgQ2WeQi+hI5ZewgGzaeQi5hK6nekgBxteQi3hL6+eggAxI]],
				["LowerLegB.L"] = [[
					eNiEgzwfgAgA7aeOiFg1w+f/f+7HeOiHg7y2f5f352ePiKhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2G
					ftfu3IePiXhJ2Gftfu3IePichJ2Gftfu3IePiXhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2Gftfu3IePiLhJ2Gftfu3IeP
					iJhF1Ufwfw33eOiHg5ySf7f56PeOiEg0w3f/f+7MeNiEgzwfgAgA7a]],
				["FootB.L"] = [[
					eNhWhL+JgAgAqueNhWhL+Jf+gBqueNhWhL+Jf3gDqueNhXhL+FfogIq4eNhXhL+EfpgIq6eNhXhL+EfpgIq6eNhXhL+EfpgIq6eNhXhL+EfpgIq6eNhXhL+E
					fpgIq6eNhjhL+EfpgIq6eNhohL+EfpgIq6eNhjhL+EfpgIq6eNhXhL+EfpgIq6eNhXhL+EfpgIq6eNhXhL+EfpgIq6eNhXhL+EfpgIq6eNhXhL+EfpgIq6eN
					hWhL+IfsgHqueNhWhL+Jf5gDqueNhWhL+Jf/gBqueNhWhL+JgAgAqu]],
				["UpperLegB.R"] = [[
					hwi3hL6+hggAxIhwi5hK6ghbf+x2hwi/hI47hLf40AhwjDhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2J
					g3ft3EhwjQhG2Jg3ft3EhwjVhG2Jg3ft3EhwjQhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2Jg3ft3EhwjEhG2Jg3ft3Ehw
					jChH24g8fw2Whwi+hI5ZhQf6zahwi5hK6nhcf/xthwi3hL6+hggAxI]],
				["LowerLegB.R"] = [[
					hziEgzwfgAgA7ahyiFg1w+gBgC7HhyiHg7y2gHgJ52hxiKhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2G
					gTgS3IhxiXhJ2GgTgS3IhxichJ2GgTgS3IhxiXhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2GgTgS3IhxiLhJ2GgTgS3Ihx
					iJhF1UgQgQ33hyiHg5ySgFgH6PhyiEg0w3gBgC7MhziEgzwfgAgA7a]],
				["FootB.R"] = [[
					hzhWhL+JgAgAquhzhWhL+JgCf/quhzhWhL+JgJf9quhzhXhL+FgYf4q4hzhXhL+EgXf4q6hzhXhL+EgXf4q6hzhXhL+EgXf4q6hzhXhL+EgXf4q6hzhXhL+E
					gXf4q6hzhjhL+EgXf4q6hzhohL+EgXf4q6hzhjhL+EgXf4q6hzhXhL+EgXf4q6hzhXhL+EgXf4q6hzhXhL+EgXf4q6hzhXhL+EgXf4q6hzhXhL+EgXf4q6hz
					hWhL+IgUf5quhzhWhL+JgHf9quhzhWhL+JgBf/quhzhWhL+JgAgAqu]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAj7hLAYgAgAkygAkChaAhgAgAlqgAkJhoArgAgAmbgAkIhmApgAgAmUgAkGhhAmgAgAmCgAkDhbAjf3e3ltgAkAhWAhfzeclagAj/hUAef5fKlSgAj+hTAc
					gAgAlOgAj/hPAaf1gLlBgAkahMAfddgYk0gAlGhLBLY+hEkqgAlVhLC4Tqh3kZgAk4hLFVPBikkCgAkShLHbMGjAjtgAkGhLIILRjIjngAkRhLHhL/jBjtgA
					kahLG/Mqi7jygAkShLHdMEjBjtgAkGhLIHLSjIjngAkGhLIILQjJjngAkGhLIILQjJjngAkGhLIILQjJjngAkGhLIILQjJjngAkGhLIILQjJjn]],
				Spine1 = [[
					gAkHgkAYgAgAkygAkRg0AhgAgAlqgAkZhCArgAgAmbgAkYhAApgAgAmUgAkVg7AmgAgAmCgDkRg1Ajf3e3ltgEkOgwAhfzeclagCkMgtAef5fKlSgAkMgsAc
					gAgAlOgAkMgoAaf1gKlCf+kmglAfdcgSk1f7lRgkBLY8g0kuf3legkC6Tmhcklf1k9gkFYO8iBkYf0kVgkHhMAiZkNf0kIgkIOLLigkJf0kTgkHmL5iakNf0
					kegkHEMkiUkQf0kVgkHiL/iZkNf0kIgkINLMigkKf0kIgkIOLLigkJf0kIgkIOLLigkJf0kIgkIOLLigkJf0kIgkIOLLigkJf0kIgkIOLLigkJ]],
				Spine2 = [[
					gAkTf8ACgAgAg9gAkfgNAEgAgAh2gAkpgcAIgAgAiogAkogaAHgAgAihgAkkgVAGgAgAiPgGkfgOAGgAe3h5gIkcgJAGf/ebhmgEkagGAEf/fKhegAkZgFAD
					gAgAhaf/kZgBADf0gIhNf8kzf+AJdbf5hCf2lcf8A2Y4fthDfvlnf8CmTgfhhQfrlEf8FFO0fZhhfpkZf8HOL3fXhwfokMf8H7LCfXh0fpkYf8HULwfXhwfp
					kif8GxMbfYhtfpkZf8HPL2fXhwfokMf8H6LDfXh0fokLf8H8LBfXh0fokLf8H8LBfXh0fokLf8H8LBfXh0fokLf8H8LBfXh0fokLf8H8LBfXh0]],
				Spine3 = [[
					gAkVfZACgAgAg9gAkjfqAEgAgAh2gAkvf5AIgAgAiogAktf2AHgAgAihgAkpfxAGgAgAiPgIkkfrAGgAe3h5gLkfflAGf/ebhmgGkdfiAEf/fKhegAkcfhAD
					gAgAhaf/kbfdADf0gIhNf8k1faAJdbfzhCf2lefZA2Y4fdhHfvlqfZCnTgfFhcfqlHfZFHO0e2h4fnkdfZHSL4ewiQfnkQfZH/LDeviXfnkcfZHXLxewiRfo
					kmfZG1McexiLfnkdfZHTL2ewiQfnkQfZH+LEeviXfnkPfZIALCeviXfnkPfZIALCeviXfnkPfZIALCeviXfnkPfZIALCeviXfnkPfZIALCeviX]],
				Neck1 = [[
					gAkXe1CwgAgAs8gAknfGDhgAgAujgAk1fVERgAgAv7gAkzfTEJgAgAvugAkufND4gAgAvPgLkofHDlfie9uogPkjfCDVfXejuGgIkge/DMfqfOt3gAkfe9DI
					gAgAtwf+kee6C9f4gNtZf9k3e2C3dmg7s7f3lhe1DaZWigsdfwlue1E/UUkWrwfqlMe1HSP6l7q2fmkje1JRNIm6qHflkVe2J7MWnLp4fmkhe1JWNCm8qGfn
					kse1I2NqmuqRfmkje1JSNHm6qHflkWe2J6MXnLp5flkVe2J7MWnMp4flkVe2J7MWnMp4flkVe2J7MWnMp4flkVe2J7MWnMp4flkVe2J7MWnMp4]],
				Neck2 = [[
					gAlmdtFEgAgAxPgAl9eIGmgAgAzbgAmRegIFgAgA1PgAmOecH3gAgA0/gAmHeTHUgAgA0WgQl/eJGsfXfDzigWl3eBGMfIesy0gMlzd8F7fifTyfgAlyd6Fz
					gAgAyWf9lvd0Fef7gOx3fxmFduFJd2haxLfXmodsFdaBjzwXe7mldrGsVbmgvGenlwdrIlRXowtieek4dqKQOwqGsReckmdqKzOBqer3eek2dqKUOqqJsOef
					lEdqJ5PQp2sieek3dqKROvqHsQeckmdqKyOCqdr4eckldqK0OAqer3eckldqK0OAqer3eckldqK0OAqer3eckldqK0OAqer3eckldqK0OAqer3]],
				Neck3 = [[
					gAnDdCEzgAgAw0gAngdtG1gAgAzvgAn3eTI4gAgA2HgAn0eOIkgAgA1xgAnseAH1gAgA08gSnidvG9fWfEz4gZnZdiGRfHesy8gOnUdaF7fifTyggAnSdXFx
					gAgAyTf7nOdOFVf7gPxpfinhdDE2d6hgwtevn6c+FBaKkBvpd6nkc7GFVpmyuEdWmWc4HyRmo+sLdHlKc2JTO/qOqsdFkyc2J0OQqjqOdHlHc2JXO5qRqodK
					lac3I/Pgp/q/dHlKc2JUO+qPqrdFkzc2J0ORqjqOdFkyc2J1OPqjqNdFkyc2J1OPqjqNdFkyc2J1OPqjqNdFkyc2J1OPqjqNdFkyc2J1OPqjqN]],
				Head = [[
					gAoZcX/rgAgAkfgAo+dW//gAgAfcgApXeP/mgAgAbCgApTeH/sgBgAbsgApLdy/3gAgAdQgUo/da/8ehgsfJgco0dG/5d3hDgvgPovc7/7e1glhmgAosc2/7
					gAgAh/f6omco/1gZf5jGfTo2cY/jinf8kneJpFcP+pnHgFl0c+obcJ8ssUgkm9cNm1cD6CwuhZn+b6lXb/31zaiLonb3k6b+3H0Jiboyb5lUb/3vzgiNoob9
					lrcA4Ty5iAofb6lWb/30zbiLonb3k6b+3I0Iiboyb3k5b+3H0Kicoyb3k5b+3H0Kicoyb3k5b+3H0Kicoyb3k5b+3H0Kicoyb3k5b+3H0Kicoy]],
				Jaw = [[
					gAnUcJ/8gAgAh2gAoAcz//gAgAfegAomdd/4gAgAdZgAogdW/6gBgAdsgAoTdH/9gAgAecgQoDc1/8eggrfTgWn1cn/5d4hGgBgMnucg/9e3gogegAnqcd//
					gAgAgqf7njcU/9gZf3hQfenxcK/ximfyiqenoGcG+2nHfzkndvnpcE8usVghm0dLmVcC50wrh3osc+lFcC3YzRjJpyc8kscB2lz+jkqFc+lCcC3RzXjMp1dA
					lWcC34yyi3plc+lFcC3WzSjJpzc8ktcB2mz9jjqEc8kscB2kz/jkqFc8kscB2kz/jkqFc8kscB2kz/jkqFc8kscB2kz/jkqFc8kscB2kz/jkqF]],
				["UpperLegF.L"] = [[
					eQi9e1xYfFgA61eQjNfBy2fGf951eQjbfM0GfGf644eQjZfKz6fGf65BeQjUfGzefGf75XebjOe6y6eIgk5uegjJezybdxg16CeYjGe2yOeYgc6PeQjFe7yH
					fFf+6WeQjDe5xxfSgF6ledjMe0xCgOiW6+e5jfevv/iBml62fjjferumj2rs5rgNjCentKlMwO3qgoikelsJl5zH10gvicekr2mEz81MgpijelsHl6zO1vgi
					iqelsWlwyk2NgoikelsJl5zJ1zgvicekr3mEz61Ngvicekr2mEz81Lgvicekr2mEz81Lgvicekr2mEz81Lgvicekr2mEz81Lgvicekr2mEz81L]],
				["LowerLegF.L"] = [[
					eNiHfN7NgAgAw0eNiUfT8HgAgAvReNihfY80gAgAt4eNiffY8ugAgAuGeNibfW8egAgAuleXiWfL8IfZg+vMebiRfH71fLhWvseUiOfL7ufkguv8eNiNfQ7q
					gAgAwDeOiLfQ7dgOgAwaeiiXfN7AiChow9fMivfN6ElgklxHgDi5fM4ZpdoPwdg0infM2TsyrjvJhSiSfL0mu0trt3haiMfL0DvYuStbhTiSfL0iu5twt0hM
					iXfL08uctRuJhSiSfL0lu1ttt3hZiNfL0EvYuStchaiMfL0DvZuTtbhaiMfL0DvZuTtbhaiMfL0DvZuTtbhaiMfL0DvZuTtbhaiMfL0DvZuTtb]],
				["FootF.L"] = [[
					eNhWe1+PgAgAqdeNhne1+xgAgAoweNh3e2/KgAgAnPeNh0e2/GgAgAneeNhue2++gAgAoAeZhoeu+xfohFoqedhier+mffhgpOeWhfev+ifugzpfeNhee1+g
					gAgApneOhbe2+YgOf9qAerhme2+DiVhJqpfjiCe49LmXjRq/gpiWe67arCl9quhkiTe85EvAoep6iFiKe93IxdqHpCiOiHe+2gyJqlouiHiJe93DxjqKo/h/
					iMe93iw/pypOiGiKe93HxeqIpBiOiHe+2hyIqkouiOiHe+2gyJqlotiOiHe+2gyJqlotiOiHe+2gyJqlotiOiHe+2gyJqlotiOiHe+2gyJqlot]],
				["UpperLegF.R"] = [[
					hwi9e1xYg7gA61hwjNfBy2g6gD51hwjbfM0Gg6gG44hwjZfKz6g7gF5BhwjUfGzeg6gF5Xh6jNfKy6f9gr5yh+jIfJybflg56Ih3jGfCyOgNgf6ShwjFe7yH
					g7gC6WhvjFe3xxhIgH6lh5jwe4xCiDiV65iClAe6v+j5me6qh+l/e/ukl1rd5ahrmKfDtEnUv53YhVl8fGsAoJyt1hhOl2fHrroXzg05hUl8fGr9oLy01cha
					mAfFsNoAyK16hVl8fGr/oKyv1ghOl2fHrroXzf06hOl2fHrqoYzh05hOl2fHrqoYzh05hOl2fHrqoYzh05hOl2fHrqoYzh05hOl2fHrqoYzh05]],
				["LowerLegF.R"] = [[
					hziHfN7NgAgAw0hziUfT8HgAgAvRhzihfY80gAgAt4hyiffX8ugAgAuGhzibfW8egAgAulh8iVfc8IfZg+vMh/iQfd71fLhWvsh5iOfX7ufkguv8hziNfQ7q
					gAgAwDhziOfO7dgOgAwaiEi7fR7DiChnw3ibkRfX6Pljkhw2ijlcfe4rpnoEwCiXl0fl2qtFrOumiElwfp1AvOtPtQh9ltfr0ev1tzsziDlwfp08vTtTtMiI
					lyfo1Wu0s2tiiElwfp0/vPtQtPh9ltfr0ev0tyszh9ltfr0dv1t0syh9ltfr0dv1t0syh9ltfr0dv1t0syh9ltfr0dv1t0syh9ltfr0dv1t0sy]],
				["FootF.R"] = [[
					hzhWe1+PgAgAqdhzhne1+xgAgAowhzh3e2/KgAgAnPhyh0e2/GgAgAnehzhue2++gAgAoAh9hne++xfohFoqiBhhfB+mffhgpOh7hfe7+ifugzpfhzhee1+g
					gAgApnhzhee0+YgOf9qAiNiLe5+GiVhIqiixjlfA9SmZjNqtjIk6fK7mrJlxqPjGlhfS5TvNoFpSi3lofY3ZxwploVixlofa2xydqAoAi2lofY3Ux2pooTi7
					lnfX3yxRpToii3lofY3YxxpmoUixlofa2yycqAoBiwlofa2wyeqAoAiwlofa2wyeqAoAiwlofa2wyeqAoAiwlofa2wyeqAoAiwlofa2wyeqAoA]],
				Tail1 = [[
					gAjwh9jpgAgA/ygAj1iMkigAgA/qgAj5iZlTgAgA/jgAj4iXlMgBgA/kgAj3iSk6gAgA/nf8j1iMkkeGgK/mf7jziIkRdYgQ/mf9jziGkJemgJ/sgAjyiFkF
					gAgA/ugBj0iBj5gRgK/wgCkPh+jugbij/qgFk8h9jkhLnB+/gIlOh9jQiDsV9RgKkzh9iyi0w961gLkQh9iYjSz44vgLkFh9iPja0t4DgLkPh9iXjTz/4pgK
					kYh9idjMzU5LgLkQh9iXjSz54ugLkFh9iPja0s4EgLkFh9iPja0t4CgLkFh9iPja0t4CgLkFh9iPja0t4CgLkFh9iPja0t4CgLkFh9iPja0t4C]],
				Tail2 = [[
					gAjgjAkcgAgA/rgAjhjOlUgAgA/jgAjijamGgAgA/agAjijYl+gBgA/bgAjijUltgAgA/ef0jhjOlWdWgT/bfwjhjJlDcWgc/Yf3jhjIk7eDgQ/jgAjhjHk4
					gAgA/ngCjjjEksgYgJ/pgFkAjBkhgnih/kgNkujAkWhtm8+4gVlEjAj5i/sL9LgakwjAjLkGwv6xgckRjAiikwzn4sgckHjAiUk70b4BgckQjAigkxzt4ngc
					kYjAiqkozE5IgckRjAihkwzo4rgckHjAiUk70a4CgckHjAiUk80b4AgckHjAiUk80b4AgckHjAiUk80b4AgckHjAiUk80b4AgckHjAiUk80b4A]],
				Tail3 = [[
					gAjNkDhegAgA/9gAjLkPiXgAgA/5gAjJkajJgAgA/1gAjJkYjBgBgA/2gAjKkVivgAgA/3fpjLkOiZclgE/tfhjMkJiFbRgI/kfvjMkJh+degF/1gAjMkJh6
					gAgA/7gDjPkGhugdgL/8gJjtkEhlggik/2gYkekChdhanD/Jgnk6kChDifsW9YgwktkCgXjYw+66gykVkBfwj5z34xgykNkBfjkB0r4FgykUkBfuj6z94sgy
					kbkBf4jzzT5OgykVkBfvj5z44wgykNkBfjkB0q4GgykNkBfikB0r4EgykNkBfikB0r4EgykNkBfikB0r4EgykNkBfikB0r4EgykNkBfikB0r4E]],
				Tail4 = [[
					gAjHlHfCgAgA/+gAjBlTf7gAgA//gAi7ldgtgAgA//gAi8lcgmgCgA//gAi+lYgUgAgA//fbjBlRf+b1fw/tfNjDlKfsaPft/dfkjDlMfjc6f3/1gAjElNfe
					gAgA//gFjHlLfSgjgN/+gMjmlIfLgcim/3gfkZlHfGhOnJ/Jgzk6lGeuiLsg9Vg9k0lFeCi8xJ6xg/kglEdajX0C4lg+kalDdNjd0232g+kglEdZjX0J4fg/
					kllEdjjSzf5Cg/kglEdajX0E4jg+kalDdNjd0133g+kalDdNjd0332g+kalDdNjd0332g+kalDdNjd0332g+kalDdNjd0332g+kalDdNjd0332]],
				Tail5 = [[
					gAjLmLbmgAgA/sgAjBmYcfgAgA/zgAi4mhdRgAgA/3gAi6mgdJgCgA/3gAi9mcc4gAgA/1fJjBmTckbIfL/ae1jEmKcVZSe7/CfXjFmPcIcYfc/igAjGmScC
					gAgA/vgIjLmPb3gogS/tgNjqmMbygSip/mgkkemLbwg0nS+2g5lDmJbehcsu89hDlCmHa6h8xa6RhDkymGaWiL0T3+hBksmFaKiO1H3NhCkxmGaViL0a34hD
					k2mGaeiIzw4dhDkymGaWiL0V38hBksmFaKiO1G3OhBksmFaKiO1H3NhBksmFaKiO1H3NhBksmFaKiO1H3NhBksmFaKiO1H3NhBksmFaKiO1H3N]],
				["UpperLegB.L"] = [[
					eQi3hL6+eggAxIeQi/hX75egf7vmeQjGhh8nehf2uOeQjFhf8hehf2ubeQjChc8Qegf4u7eRjAhP76d5g4vdeRi9hI7ndqhSv8eQi8hM7feDgrwOeQi7hR7c
					egf9wYeRi6hP7Revf9wredjGhM7XgthUwge5jZhL7bkujcvafjjWhL6tptlntlgOi2hL5LuRnLrngriXhL3pxQn+qLgziOhL3HyHoKpwgsiWhL3kxXn/qIgl
					idhL3+wrn1qegriXhL3oxRn+qLgziOhL3HyGoJpwgziOhL3GyHoKpvgziOhL3GyHoKpvgziOhL3GyHoKpvgziOhL3GyHoKpvgziOhL3GyHoKpv]],
				["LowerLegB.L"] = [[
					eNiEgzwfgAgA7aeNiOg5x/gAgA6deNiZg+zQgAgA5jeNiXg9zEgAgA5seNiTg7yogAgA6AeQiQgxyDfBgm6ZeRiMgsxjepg06sePiKgwxVfSgc64eNiJg2xP
					gAgA69ePiIg1w7gOgG7JeiiUgxw2hXiM7EfLirguw8j3l+6MgCi0gqwonDqT4Ug0ihgnvxqCt815hTiMglu3sDwJz7hciGgkuisowwzShUiLglu0sHwOz2hN
					iQglvErqvu0VhUiMglu2sEwKz6hciGgkujsnwvzThciFgkuisowwzShciFgkuisowwzShciFgkuisowwzShciFgkuisowwzShciFgkuisowwzS]],
				["FootB.L"] = [[
					eNhWhL+JgAgAqueNhehM+sgAgApCeNhnhN/GgAgAnheNhlhM/CgAgAnveNhihM+5gAgAoSeOhfhE+sfnhFo8eOhchA+gfehfpfeOhbhF+dfugzpxeNhahL+b
					gAgAp4ePhZhM+UgOf7qOephmhI+Nicg1qOfgiBhD9tmyiKpfgliSg98Sr/jfoPhhiMg36FwnkZm6iEiBg04Izjk1l9iNh/gy3e0Zk7lriFiBgz4Dzqk2l7h+
					iEg04jy/kwmKiEiBgz4Hzlk1l9iNh/gy3f0Yk7lsiNh/gy3e0Zk7lriNh/gy3e0Zk7lriNh/gy3e0Zk7lriNh/gy3e0Zk7lriNh/gy3e0Zk7lr]],
				["UpperLegB.R"] = [[
					hwi3hL6+hggAxIhwi/hX75hggFvmhwjGhh8nhfgKuOhwjFhf8hhggJubhwjChc8QhggIu7hvi/hf76g4hDvkhvi8hf7ngphZwFhwi7hY7fhDgxwThwi7hR7c
					hggDwYhwi9hN7PhvgAwrh5jqhM7CjshYwpiCk6hL6hnljqvxh+l3hL5LsTmHuLhsmBhL3IwfoBsWhZlyhL1TzLpFq9hSlrhL0sz8pWqhhYlxhL1OzRpHq5hd
					l2hL1syqo4rPhZlyhL1SzMpFq8hSlshL0sz7pWqhhSlrhL0rz8pWqghSlrhL0rz8pWqghSlrhL0rz8pWqghSlrhL0rz8pWqghSlrhL0rz8pWqg]],
				["LowerLegB.R"] = [[
					hziEgzwfgAgA7ahziOg5x/gAgA6dhziZg+zQgAgA5jhziXg9zEgAgA5shziTg7yogAgA6Ah0iPhByDfBgm6Zh1iLhDxjepg06sh0iKg8xVfSgc64hziJg2xP
					gAgA69h0iKgzw7gOgG7JiEi4gywwhWiN7IiakOgvwrjzmB6WijlXgtwMm3qb4miYlvgqvOpsuM2SiGlrgpuQrjwg0Xh/logot7sGxJzviFlrgpuOrowl0SiK
					ltgpuerMwE0wiGlrgpuQrkwh0Wh/logot8sFxIzwh/logot7sGxJzuh/logot7sGxJzuh/logot7sGxJzuh/logot7sGxJzuh/logot7sGxJzu]],
				["FootB.R"] = [[
					hzhWhL+JgAgAquhzhehM+sgAgApChzhnhN/GgAgAnhhzhlhM/CgAgAnvhzhihM+5gAgAoShzhehU+sfnhFo8hyhbhX+gfehfpfhzhahS+dfugzpxhzhahL+b
					gAgAp4h0hchK+TgOf7qPiLiKhJ+Kicg2qViujkhG9nmwiPpyjFk2hB8Ir7jtoujDlbg956wfk0nji2lhg638zZlamriwlhg63S0Olkmai1lhg633zglcmpi5
					lhg74Xy2lTm3i2lhg637zblbmriwlhg63T0Nlkmbiwlhg63S0Plkmaiwlhg63S0Plkmaiwlhg63S0Plkmaiwlhg63S0Plkmaiwlhg63S0Plkma]],
			},
		},
	},
}
