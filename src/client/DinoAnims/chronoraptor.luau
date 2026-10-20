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
					gAj/gxACgAgAg9gAj/gxACgAgIg9gAkAgxACgAgRg9gAkBgxACgBgYg9gAkBgxACgBgfg9gAkBgxACgBgmg9gAkBgxACgBgrg9gAkBgxACgBgwg9gAkAgxAD
					gCgzg9gAj/gxADgCg1g9gAj/gxADgCg2g9gAj+gxADgCg1g9gAj9gxADgCgzg9gAj9gxACgBgwg9gAj8gxACgBgrg9gAj8gxACgBgmg9gAj8gxACgBgfg9gA
					j9gxACgBgYg9gAj9gxACgAgRg9gAj+gxACgAgIg9gAj/gxACgAgAg9gAj/gxACgAf4g9gAkAgxACgAfvg9gAkBgxACf/fog9gAkBgxACf/fhg9gAkBgxACf/
					fag9gAkBgxACf/fVg9gAkBgxACf/fQg9gAkAgxADf+fNg9gAj/gxADf+fLg9gAj/gxADf+fKg9gAj+gxADf+fLg9gAj9gxADf+fNg9gAj9gxACf/fQg9gAkA
					gxADf/fVhUgAkLgxAHgAfaiVgAkFgxAEgAfhhxgAkCgxADgAfohcgAkBgxADgAfvhTgAj/gxACgAf4hE]],
				Spine1 = [[
					gAkBgSAPgAgAjugAkBgSAQgBgIj2f/kCgSARgCgQj9f/kDgSASgDgYkDf/kDgSASgEgfkHf/kDgSASgFgmkIf/kDgSASgGgrkHf/kDgSASgGgvkDf+kCgSAS
					gHg7j9f+kBgSASgKhYj2f+kBgSASgOh0jtf+kAgSASgPh7jlf+j/gSARgOh5jef/j/gSAQgOh2jYf/j+gSAPgOhyjUf/j+gSAPgNhsjTf/j+gSAPgMhmjUf/
					j/gSAPgMhejYf/j/gSAOgIhBjegAkAgSAOgDgYjmgAkBgSAPgAgAjugAkBgSAQf/f4j2gBkCgSARf+fwj9gBkDgSASf9fokDgBkDgSASf8fhkHgBkDgSASf7
					fakIgBkDgSASf6fVkHgBkDgSASf6fRkDgCkCgSARf6fNj9gCkBgSARf6fLj2gCkBgSAQf6fLjugCkAgSAPf6fLjlgCj/gSAOf6fNjegBj/gSANf7fRjYgBkD
					gSAPf8fVjrgBkQgSAXf+fakqgBkIgSASf+fhkHgBkFgSAQf+foj3gBkDgSAQf+fwj0gAkBgSAPf/f4js]],
				Spine2 = [[
					gAkPfUAqgAgAmZf/kQfUAugCgImpf+kSfVAxgEgQm4f+kSfVA0gFgYnDf9kTfVA1gHgfnLf9kTfVA2gJglnNf8kTfVA2gKgqnLf8kSfVA0gLgvnDf7kSfVAy
					gOhCm4f5kQfVAxgZh6mof3kPfVAygkiwmXf3kOfVAwgnjAmHf3kNfVAtgni+l4f3kMfUArgni6ltf4kLfUApgmi2llf4kLfUAoglixljf5kLfUAogkiqlmf6
					kMfUApgiiiltf8kNfUAngYhxl5f+kOfUAngIgnmJgAkPfUAqgAgAmZgBkQfUAuf+f4mpgCkSfVAxf8fwm4gCkSfVA0f7fonDgDkTfVA1f5fhnLgDkTfVA2f3
					fbnNgEkTfVA2f2fWnLgEkSfVA0f1fRnDgFkSfVAxf1fOm4gFkQfVAuf1fMmpgFkPfUArf1fLmZgFkOfUAof2fMmJgFkNfUAlf3fOl6gEkMfUAjf3fRlugEkR
					fUAlf5fVl9gDkifWAyf7fam6gDkZfVArf7fhmZgCkUfVAof8fomNgCkSfUAof9fwmPgBkQfUAof+f4mQ]],
				Neck1 = [[
					gAkce3EOgAgAv3f/kee3ERgEgHv7f+kfe3ETgIgOwAf9kge3EVgMgVwDf8khe4EXgQgbwFf7khe4EXgTghwGf7khe4EXgWglwFf6kge4EWgYgpwDf5kfe3EH
					grhNvlf1kee3Dghni6uIfykce3DDijkjskfxkae3C7i3lBsAfxkYe3C5i3k/r8fykXe3C3i3k7r5fykWe3C1i2k3r3fzkWe2C0i1kyr3f0kWe2C0iyksr4f1
					kXe2C0itkjr9f4kYe2DHh4jNtNf9kae2DygohFvAgAkce3EOgAgAv3gBkee3ERf8f5v7gCkfe3ETf4fywAgDkge3EVf0frwDgEkhe4EXfwflwFgFkhe4EXft
					ffwGgFkhe4EXfqfbwFgGkge4EWfofXwDgGkfe3EUfnfUv/gGkee3ERfmfSv7gGkce3EPflfRv2gGkae2EMfmfSvxgGkYe2EJfnfUvtgGkXe2EHfpfWvqgFkd
					e2EjfrfawagFkwe4GAftffyogEkle3FLfwflxagDkge3Ewf0frwvgCkfe3Elf4fywegBkce2EUf8f5wB]],
				Neck2 = [[
					gAlTeWIUg5g/1cf/lVeWIYhBhI1gf9lXeXIbhHhP1jf8lZeXIehLhU1mf7lZeYIghOhX1of6laeYIhhPhX1of5lZeYIghNhW1of5lZeXIehKhS1mf2lWeWH/
					hlhx0/fulReRGqjKjiy7fmlLeNFokzlVwnfjlIeMFWlUl2v0fjlGeLFTlVlzvwfklFeLFRlUlwvtfllEeLFPlTlrvsfmlEeKFNlQlnvsfnlEeKFNlNlhvufo
					lFeKFOlFlZv1fwlJeNF2jTjmxwf6lQeSHWgggm0XgAlTeWIUfHfB1cgBlVeWIYe/e41ggDlXeXIbe5ex1jgElZeXIee1es1mgFlZeYIgeyep1ogGlaeYIhex
					ep1ogHlZeYIgezeq1ogHlZeXIee2eu1mgIlXeXIbe7ez1kgIlVeWIYfBe71ggIlTeWITfKfE1cgIlSeVIPfTfO1ZgIlQeVIMfefa1VgHlOeUIJfqfn1TgHlW
					eYIuf1f118gGltekKnf+gF3ygFlgedJjgMgS2ygElaeZJAgYge2OgDlYeYIygkgq1/gBlUeWIcgvg11m]],
				Head = [[
					gAmGeRAQgNj1gpf+mIeRASgMj+g2f9mKeSATgLkChGf8mLeTATgKj/hZf7mMeTATgKj2hsf6mMeUASgJjmh+f5mMeUARgJjSiMf4mLeTAPgIi3iWf1mJePAP
					gljjhHfrmCeDA/iBmycrffl5d5C2jbpzX9fcl1d1Dsj3qoWWfclzd1Dvj4qkWGfdlyd0D0j5qeV1felxdzD3j5qXVkfflwdzD6j4qPVUfglxdzD8j4qHVIfi
					lydzD3j1p5VHfsl5d7BoigmXYtf6mCeJAFgjfveLgAmGeRAQfzcLgpgCmIeRASf0cCg2gDmKeSATf1b+hGgEmLeTATf2cBhZgFmMeTATf2cKhsgGmMeUASf3
					cah+gHmMeUARf3cuiMgImLeTAPf4dJiWgImKeTAMf4dniZgImIeSAKf5eKiXgJmGeRAIf6eviPgImEeQAGf8fWiCgImCePAEf/f/hxgImBeOAEgCgnhegHmJ
					eVAMf+hPjDgFmfepBJfohzoNgFmTedAgf2iXk/gDmNeYATf/i2jJgCmLeVARgEjQiTgBmHeSAPgKjlhG]],
				Jaw = [[
					fzl+dc/ugEcLhifxmBdd/tgHcBhlfvmEde/sgKb+hjfumGde/tgMcBhcfumIdf/vgNcKhRfumJde/xgNcahCfumKde/0gLcvgxfvmJdd/2gIdJggfpmDda/w
					fucbhjfTlvdV+regZGlre+lcdZ8jdQV/qBe4lVdb7mc4VJrke5lSdb7hc3VNrze6lQdb7cc2VTsEe7lOdb7Xc1VZsVe8lOdb7Tc1Vhske+lNdb7Qc1VpsxfA
					lOdb7Wc3V4sxfVladT90d8ZfpWf6lydU/vfbgOkAgNl+dc/uf8j1higPmBdd/tf5j/hlgRmEde/sf2kChjgSmGde/tf0j/hcgSmIdf/vfzj2hRgSmJde/xfz
					jmhCgSmKde/0f1jRgxgRmJdd/2f4i3gggQmIdc/5f7iZgRgPmGdb/8f+h3gFgNmEda/9gAhRf8gLmBdZ//gBgqgJgIl+dZ//gBgBgagFl8dY/+gBfZgtgCmJ
					de/8gMeyhFf/mxd2/5g5eZhjf8mado/3gpdvhqf6mNdi/0gcdMhvf3mIdg/xgXcxhwf1mBdd/vgKcbhr]],
				ClockMin = [[
					gAj7f4gAJZgA2ngAj8f4h9JkeC2of/j8f4j2J6cG2df/j9f4lrKZaM2Jf+j9f4naLAYX1qf+j9f4pCLuWo1Df+j9f4qiMiVB0Uf9j9f4r8NbTgzef9j8f4tI
					OhR/ysf9j8f4t6QAQUyGf+j7f4uiReOrxVf+j6f4vXSpNXwKf+j6f5wSTvMRuxf+j5f5xKU7LRtRf+j5f5x+WNKXrqf/j5f5yvXmJlp7f/j5f5zbZGI7oFf/
					j5f50BasIbmJgAj6f50/cUIgkEgAj6f52FeFJCh/gAj7f42ngAJZgAgAj8f42oh+JkeDgBj8f42dj6J6cKgBj9f42Jl0KZaVgCj9f41qnpLAYmgCj9f41DpY
					LuW+gCj9f40Uq/MiVegDj9f4zesgNbUEgDj8f4yit6OXSxgDj8f4xhvNPYRkgDj7f4wawaQcQcgDj6f5vNxhRkPYgDj6f5t6yiSxOXgDj5f5sgzeUENbgCj+
					f5qy0bVsMbgCkMf5of1aX5LWgCkEf5nH11ZJK0gBkAf5lf2OaqKTgBj+f5jr2gcZJ3gAj8f5h52oeIJj]],
				ClockHour = [[
					gAj7f4gAJZgA2ngAj8f4gMJff02tf/j8f4gWJkfq2zf/j9f4geJqfh24f+j9f4gjJvfb29f+j9f4glJ0fZ3Bf+j9f4gjJ4fb3Ff9j9f4geJ7fh3If9j8f4gW
					KJfp3Wf9j8f4gMKzf039f+j7f4gALdgA4hf+j6f4f0LpgM4rf+j6f5fqLogW4qf+j5f5fhLmge4nf+j5f5fbLigk4lf/j5f5faLegl4hf/j5f5fbLZgj4df/
					j5f5fhLTge4YgAj6f5fpKtgW33gAj6f5f0J1gM3EgAj7f4gAJZgA2ngAj8f4gMJTf02hgBj8f4gWJNfq2cgBj9f4gfJIfi2WgCj9f4glJDfd2RgCj9f4gnI/
					fb2MgCj9f4glI7fd2IgDj9f4gfI4fi2FgDj8f4gXI1fq2DgDj8f4gMI0f12BgDj7f4gAIzgA2BgDj6f5f0I0gL2BgDj6f5fpI1gW2DgDj5f5fhI4ge2FgCj+
					f5frI6gT2IgCkMf5gWI+fm2MgCkEf5f/JCf/2RgBkAf5f3JHgI2WgBj+f5f5JNgH2cgAj8f5f5JTgH2h]],
				Gear2 = [[
					gAl0e5gAJZgA2nf/l2e7goJffY2tf+l4e8hOJmew2xf9l5e+hyJueL20f8l6e/iTJ3do22f8l6e/iwJ/dJ23f7l6e/jJKGcu23f7l5e+jfKMcW22f5l4e9jw
					KecA3Af2l2e7j6LKbn3jfzl0e6kBL2bO4Dfylze4kMMFa54Jfylxe3kbMHal4Dfylwe1ksMIaQ38fylve1lAMKZ33zfzlve0lZMMZc3of0lve0l1MPY+3bf1
					lwe1mVMSYd3Lf4lxe2nDL5YE2gf9lze3n6LTXx1igAl0e5oqLHXW05gBl2e7pRLRW00kgCl4e8p3LcWT0OgDl5e+qbLoV1z5gEl6e/q8L0VazlgEl6e/rZL/
					VCzTgFl6e/ryMJUtzCgFl5e+sIMTUcy0gGl4e9saMcUMyogGl2e7sqMkT+ydgGl0e5s5MtTxyUgGlze3tHM3TjyLgGlxe2tVNDTUyCgGlwe1tlNRTDx5gFl2
					e2uCNqSixkgFmIe+u4ObRnw5gEl+e6u6OiRhw7gDl5e4vGOzRQwygCl3e4vZPMQ2wjgBl1e4vqPkQewU]],
				["UpperArm.L"] = [[
					fNkFeg2FTtfgzmfMkHeg2iTzfHzIfLkJeh22T5e0yyfKkLeh3BT+enyofJkMeh3BUCeiyqfIkMei22UFeky5fHkMei2iUIeuzTfHkLei2GULe9z2fFkJej1j
					UYfG0kfAkHen09U/e61fe8kFeq0XVoeu2We7kDerz3V2e425e7kBerzgV3fI3Oe8kAerzTV1fR3Ye8j/eqzSVyfU3Xe9j+eqzeVsfP3Le+j/eqz1VlfE20e/
					kAep0UVce12UfDkBem06U3e/1efKkDei1hUGfa0cfNkFeg2FTtfgzmfPkHef2iTpfTzCfQkJef23TlfLylfRkLef3DTifKyVfSkMee3DTefPySfTkMee25TZ
					faycfUkMee2lTVfryyfUkLed2ITQf/zRfVkJed1kTNgWz2fVkHed0+TKgt0dfVkFed0YTKhC1BfVkDedz3TKhU1gfVkBeezfTMhf12fUj/eezSTPhk2DfUkF
					ee1KTQgf0UfTkaef53T0dSuGfSkPef31ThetxRfRkJef2zTgfTyofQkIef2oTkfVy4fPkFef2FTofmzk]],
				["LowerArm.L"] = [[
					exjWeSub8VjigUewjZeQuc8OkRfzevjbePud8KkkfgeujdePuf8LkbfcesjeePuf8Qj1fnerjeeRue8Yi3f/erjdeTub8ghlgjeqjbeVuU8lgHhNeojZeauJ
					8meghqekjXeht38mcwhjegjUeptj8kbRhWefjSestW8faYhgegjQeutS8baChuegjPevtV8baJhuehjOeutf8eashgehjNettt8jbphHeijOert+8nc7gmei
					jPeouO8neZgAenjRehua8kgOf+etjTeYud8diHgVexjWeSub8VjigUezjZePua8OkYgBe0jbeNuZ8Kkzf9e1jdeLuY8LkxgGe3jeeLuX8QkSgee4jeeLuX8X
					jZhDe4jdeMuW8diMhwe5jbeOuT8fgyiie5jZeQuN8dfVjUe6jXeTuH8Wd+kBe6jUeWuA8Oc1kle5jSeYt68GcDk9e5jQeat28DbqlHe4jOebt38EbvlBe4jV
					eTuR8ff+i3e4j1d9tx6Rricze3jjeHuS7xm3fJe1jbeNuY8Kk4gDe0jZeOuZ8Lkvf/ezjWeRua8Vjnga]],
				["UpperArm.R"] = [[
					gzkFeg2FsTggzmgxkHef2isXgtzCgwkJef23sbg1ylgvkLef3Dseg2yVgukMee3DsigxySgtkMee25sngmycgskMee2lsrgVyygskLed2IswgBzRgqkJed1k
					s+ffzvglkHea07tjekz/ggkFeY0RuIdt0MgfkDeYzvuTdT0jgfkBeYzWuRdI05gfj/eYzJuPdD1Gggj+eYzJuMdF1Jghj+eYzXuHdN1Agij+eYzwuDdd0ugj
					j/eZ0St8dy0UgokBeb06tcen0GgvkDee1issfvz9gzkFeg2FsTggzmg0kHeg2isNg5zIg1kJeh22sHhMyyg2kLeh3BsChZyog3kMeh3Br+heyqg4kMei22r7
					hcy5g5kMei2ir4hSzTg5kLei2Gr1hDz2g6kJei1krzgu0dg6kHej0+rxgY1Fg6kFej0arvgC1qg6kDejz6rufu2Ig6kBejzirtff2dg5j/eizVrvfV2ng5kF
					ei1Lr3gZ01g4kZej5yrljouig3kOei3zr6iAxpg2kJeh2ysChOy6g1kIeh2nsIhCzFg0kFeg2EsOgmzq]],
				["LowerArm.R"] = [[
					hPjWeSubDrcegUhNjZePuaDybogBhMjbeNuZD2bNf9hLjdeLuYD1bPgGhJjeeLuXDwbugehIjeeLuXDpcnhDhIjdeMuWDjd0hwhHjbeOuTDhfOiihFjZePuO
					DlgkjjhAjXeOuLD0hjlAg6jUeNuKEIiTmUg5jSePuIETi/m6g6jQeQuFEXjXnDg6jOeSuEEVjSm+g7jNeSuEENiymqg8jNeRuHEBh4mJg8jNeQuJD2grlcg9
					jOeOuLDtfTkohDjQePuPDmeLjLhKjTeRuWDldVhchPjWeSubDrcegUhQjZeQucDybvfzhRjbePudD2bcfghSjdePufD1blfchUjeePufDwcLfnhVjeeRueDo
					dJf/hVjdeTubDgebgjhWjbeVuUDbf5hNhWjZeYuKDbhYh5hWjXebt/DfixijhWjUeet0Dlj5jGhWjSegtrDskrjghWjQeitnDvlBjthVjOejtpDvk6jthVjV
					eauODagphqhVj1eDuHF1VAbyhUjjeMudEQZleShSjbeQueD2befYhRjZeRudD1bgfhhQjWeSucDrcggM]],
				Gear1 = [[
					gAlkgYgAJZgA2ngAllgZfvJfgR2tgAllgafeJlgj2zf/lmgafMJrg124f/lmgbe4JxhK28f/lmgbejJ3hg2/f/lmgbeMJ8h53Bf/lmgad0KCiT3Cf/llgadb
					KNiv3Gf/llgZdDKmjP3Xf/lkgYcrK+jv3lf/ljgXcRLIkN3lf/ljgXb2LMkq3ef/ligWbdLPlF3Wf/ligWbFLRle3Of/ligVauLSl23EgAligWaZLTmL26gA
					ligWaFLSme2vgAljgXZvLDmr2XgAljgXZWKrm012gAlkgYZBKfm/1hgAllgZYvKfnN1WgAllgaYcKfnc1LgBlmgaYJKhnr0/gBlmgbX0Kjn80zgBlmgbXeKn
					oO0ngBlmgbXGKtoi0bgBlmgaWtK0o40OgBllgaWTK9pP0BgBllgZV4LIpnz0gBlkgYVeLVqAzngBljgXVELjqZzbgBljgXUsLyqxzPgBligWUVMCrJzEgBlm
					gYUNMKrSzCgBlzgeUiMCrAzSgBlsgbT7Merry9gBlogZThM1sLyvgAlngZTPNHsjymgAllgYS8Nbs+yb]],
				Gear3 = [[
					gAlMhqgAJZgA2ngAlMhrgsJffU2tgBlMhshWJneo2wgBlMhsh/Jwd+2zgClMhsinJ5dU2zgClMhsjMKCcs2zgClMhsjvKMcH2xgDlMhskQKVbj2tgElMhrkv
					Kka/2ugGlMhrlJLAaa26gIlMhqlhLcZ13EgJlMhpl8LpZS2/gJlMhpmZLxYx20gJlMhom4L4YQ2mgJlMhonYMAXu2XgIlMhon6MJXL2GgIlMhooeMSWn1ygH
					lMhopDMdWC1cgFlMhppyMbVk04gClMhqqlMUVK0KgAlMhqrUMaUszmgAlMhrr8MsUKzKf/lMhsskM+Tpyuf/lMhstKNSTKySf+lMhstvNmSsx2f+lMhsuRN6
					SRxbf+lMhsuwOPR3xCf9lMhsvOOkRfwpf9lMhrvpO6RIwRf9lMhrwCPPQyv7f9lMhqwaPmQcvkf9lMhqwxP+QFvOf9lMhpxGQXPvu4f9lMhpxcQyPXuhf+lO
					hqx7RcO0t9f+lWhvyqSgN+s9f+lShsyvSuN0s2f/lPhry6TINhskf/lOhrzKTpNKsKgAlNhqzXUIMzry]],
				Tail1 = [[
					gAkChXehgAgA/9gAkDhXeQgdgC/8gBkDhXeBg6gE/6gBkEhXd1hVgG/5gBkEhXduhugI/3gBkEhXdriEgK/1gCkEhXduiXgL/0gCkEhXd2ingL/zgCkDhXeC
					iygL/zgCkDhXeRi5gK/0gCkChXehi7gJ/0gCkBhXexi5gH/1gCkAhXfAiygG/2gCkAhXfMingE/4gCj/hXfUiYgD/5gBj/hXfWiFgD/6gBj/hXfUhugC/8gB
					kAhXfMhVgC/9gBkAhXfAg6gC/9gAkBhXexgdgB/9gAkChXehgAgA/9gAkDhXeQfjf+/8f/kDhXeBfGf8/6f/kEhXd1erf6/5f/kEhXdueSf4/3f/kEhXdrd8
					f2/1f+kEhXdudpf1/0f+kEhXd2dZf1/zf+kDhXeCdOf1/zf+kDhXeRdHf2/0f+kChXehdFf3/0f+kBhXexdHf5/1f+kAhXfAdOf6/2f+kAhXfMdZf8/4f+kC
					hXgLdof+/5f/kLhXixd7gA/zf/kGhXhUeSf//6f/kEhXgZerf+/9f/kDhXf2fGf+/+gAkChXfCfjf//+]],
				Tail2 = [[
					gAkLi5fkekf//9gDkNi5fHfSgA/+gGkPi5eqgBgC/9gJkRi4eNgwgE/7gMkSi4d1hdgH/4gOkTi4dkiIgK/0gQkSi4dbiwgN/xgSkRi3dbjUgP/tgTkPi3dk
					jygR/rgUkNi3d2kKgR/pgUkLi4eOkcgQ/ogUkJi4erkngO/ogTkGi4fIkqgM/ogSkFi4fkkngJ/pgQkEi4f8kcgH/rgOkDi5gOkKgF/ugMkEi5gXjxgE/xgJ
					kFi5gXjTgD/0gGkGi5gOivgC/3gDkJi5f8iHgC/7gAkLi5fkhcgB/9f9kNi5fHgugA/+f6kPi5eqf/f+/9f3kRi4eNfQf8/7f0kSi4d1ejf5/4fykTi4dkd4
					f2/0fwkSi4dbdQfz/xfukRi3dbcsfx/tftkPi3dkcOfv/rfskNi3d2b2fv/pfskLi4eObkfw/ofskJi4erbZfy/oftkGi4fIbWf0/ofukFi4fkbZf3/pfwkB
					i5hVblf7/pfyj6i4lqb3gA/Nf0j+i5jjcPf+/kf3kBi5iSctf+/vf6kEi6hkdRf+/1f9kIi6gYd5f+/6]],
				Tail3 = [[
					f3kOkbhGcfgC/xf/kTkbgsdQgD/3gGkYkbgMeEgE/7gOkckafoe9gG/+gVkgkZfEf2gH/+gbkikYekgwgJ/8ghkikXeKhpgL/5gmkhkWd6ifgN/0gqkekWd0
					jRgP/vgtkbkWd6j+gQ/rgvkWkWeLkkgR/ngwkRkWeklEgQ/jgvkMkWfFlbgP/ggukIkWfplqgN/fgrkEkXgNlwgK/egnkCkYgtltgH/egjkCkZhGlhgF/fgd
					kDkZhWlMgD/igXkFkahckwgB/mgQkJkbhWkMf//sgJkOkbhGjhf+/xgBkTkbgsiwf9/3f6kYkbgMh8f8/7fykckafohDf6/+frkgkZfEgKf5/+flkikYekfQ
					f3/8ffkikXeKeXf1/5fakhkWd6dhfz/0fWkekWd0cvfx/vfTkbkWd6cCfw/rfRkWkWeLbcfv/nfQkRkWeka8fw/jfRkMkWfFalfx/gfSkIkWfpaWfz/ffVj5
					kXiGaRf6/ZfZjYkQoGaWgF+bfdjpkWlcagf//Cfjj0kZj/a0f+/Ufpj7kajSbQf//dfwkGkbh8b0gA/q]],
				Tail4 = [[
					fikHl7hua5gD/ifukPl8hkbdgG/of6kXl8hPcJgJ/ugHkel8gzc6gL/1gUkll7gSdxgO/6ggkql6fwergP/9grktl4fOfogR/+g1kul3eyglgS/9g9ksl1ee
					hggS/6hFkol0eTiagT/2hKkhlzeTjQgT/xhOkalzeekAgS/shQkSlyeykqgS/ohQkKlzfPlNgR/jhOkDlzfwlngP/fhKj+l0gTl5gN/chEj7l1g0mCgK/ag9
					j6l2hQmBgH/Zg0j8l4hkl2gE/agqkBl5huljgB/dgekHl7hulHf9/igSkPl8hkkjf6/ogGkXl8hPj3f3/uf5kel8gzjGf1/1fskll7gSiPfy/6fgkql6fwhV
					fx/9fVktl4fOgYfv/+fLkul3eyfbfu/9fDksl1eeegfu/6e7kol0eTdmft/2e2khlzeTcwft/xeykalzeecAfu/sewkSlyeybWfu/oewkKlzfPazfv/jeyjt
					lyiKaZf8/ae4iplgpqaLgU98e9jIltmUaAgE+yfEjclzklaAf+/FfMjnl2j5aKf9/NfWj6l5ifadf//a]],
				Hourglass = [[
					fDj9nYhua5gD/ifSkFnahkbNgF/lfjkPnbhQbogH/qf0kZncg0cKgK/vgGkjndgTcygN/1gXksncfwdggQ/5gokynbfPeRgT/7g4k1nZezfFgV/9hHk1nXef
					f7gX/9hTkynVeUgwgY/7heksnTeUhlgY/6hmkjnRefiXgX/3hskZnQezjFgW/0hvkPnQfPjugT/whwkFnPfwkSgQ/thuj8nPgTkugM/ohpj2nQg0lEgJ/lhh
					jznRhQlRgF/ihXjznThklWgD/ghLj2nVhulTgA/gg9j9nYhulHf9/igukFnahkkzf7/lgdkPnbhQkYf5/qgMkZncg0j2f2/vf6kjndgTjOfz/1fpksncfwig
					fw/5fYkynbfPhvft/7fIk1nZezg7fr/9e5k1nXefgFfp/9etkynVeUfQfo/7eiksnTeUebfo/6eakjnRefdpfp/3eUkZnQezc7fq/0eRkPnQfPcSft/weQjg
					nNiKbugB/oeXhxmqpobSgr+IeZijnBmUa9gQ+8egjAnKklawgF/OepjQnPj5aqgB/Te1jrnUifatgA/d]],
				["UpperLeg.L"] = [[
					e5isgY71e1f+vve5itgZ7ze6f3vye5iugZ7xe+fxv1e5iuga7wfDfqv3e4ivga7wfHfkv3e4ivgb7yfLffv1e4ivgb70fNfavxe4iugb73fPfWvre4iugc78
					fQfSvje4itgc8BfRfQvae4isgc8FfQfPvRe4isgc8KfPfOvJe4irgc8NfOfQvDe4iqgb8PfLfSu/e4iqgb8QfJfWu9e4iqgb8PfGfau/e4iqga8MfDfgvEe5
					iqga8IfAfnvMe5irgZ8De8fuvWe5isgZ78e4f2vie5isgY71e1f+vve5itgX7texgGv8e6iugX7metgOwIe6iugW7gepgVwSe6ivgW7belgbwae6ivgV7Yei
					ghwee6ivgV7Wefgmwge6iugV7Xedgpwfe6iugV7Zebgswbe6itgU7deZgtwUe7isgU7ieYgtwNe6isgU7meYgswEe6irgV7reZgqv8e6iqgV7webgnv1e6iu
					gT7Qeggmwre6i7gO5Heugtzwe6i0gS6ferghx4e6iwgU7GergXw9e6ivgV7VeugPwke5itgX7sexgGv+]],
				["LowerLeg.L"] = [[
					e2hxf0tugkgB85e2hxf1t5grf+8ze2hyf2uEgzf68ue1hyf2uNg6f38pe1hzf3uUhBf08me0hzf3uXhHfy8je0hzf3uZhNfw8je0hzf3uXhRfu8je0hzf3uS
					hVfu8lezhyf2uMhXft8oezhyf2uFhYfu8sezhxf1t9hYfu8wezhxf1t1hWfv80e0hxf0tuhTfx83e0hwf0tphPfz86e0hwf0tlhJf188e0hwfztkhDf389e1
					hwfztkg8f589e1hwf0tmg0f788e2hwf0tqgsf+87e2hxf0tugkgB85e3hxf0tygbgE83e3hxf1t2gTgG81e4hxf1t5gMgJ80e4hxf1t6gFgM8ze5hxf1t5f+
					gO80e5hxf0t1f5gQ82e5hxf0twf1gS84e5hwf0tofygT88e6hwfztgfwgU9Ae6hvfytYfwgU9De6hvfytQfxgU9He5hvfxtJfzgT9Ke5hufxtFf2gS9Me5hw
					f0tnf5gQ88e5h4f+v0f6gM70e4hzf4uhgDgL8ge4hyf1uBgLgJ8we4hxf1t6gSgG8ze3hxf0ttgbgE85]],
				["Foot.L"] = [[
					e5gwgp8kgBgAuZe5gwgp8kgHf8uZe5gwgp8kgNf5uZe5gwgp8kgTf2uZe5gwgp8kgZfzuZe5gwgp8kgefxuZe5gwgp8kgifvuZe5gwgp8kgmftuZe5gwgp8k
					gpfruZe5gwgp8kgrfquZe5gwgp8kgsfquZe5gwgp8kgsfquZe5gwgp8kgqfruZe5gwgp8kgofsuZe5gwgp8kglfuuZe5gwgp8kggfwuZe5gwgp8kgbfyuZe5
					gwgp8kgVf1uZe5gwgp8kgPf5uZe5gwgp8kgIf8uZe5gwgp8kgBgAuZe5gwgp8kf6gDuZe5gwgp8kfzgGuZe5gwgp8kftgKuZe5gwgp8kfngMuZe5gwgp8kfi
					gPuZe5gwgp8kfegRuZe5gwgp8kfbgTuZe5gwgp8kfYgUuZe5gwgp8kfXgVuZe5gwgp8kfXgVuZe5gwgp8kfXgUuZe5gwgp8kfZgUuZe5gwgp8kfcgSuZe5gw
					gp8kfegRuZe5gwgp8kfegRuZe5gwgp8kflgNuZe5gwgp8kfsgKuZe5gwgp8kfzgHuZe5gwgp8kf6gDuZ]],
				["Toe.L"] = [[
					e5gOgP/8gBf/h0e5gOgP/8gFf6h0e5gOgP/8gKf0h0e5gOgP/8gOfvh0e5gOgP/8gSfrh0e5gOgP/7gVfmh0e5gOgP/7gZfih0e5gOgP/7gbffh0e5gOgP/7
					gdfdh0e5gOgP/7gffbh0e5gOgP/7gffah0e5gOgP/7gffbh0e5gOgP/7gefch0e5gOgP/7gdfeh0e5gOgP/7gafgh0e5gOgP/7gXfkh0e5gOgP/8gTfph0e5
					gOgP/8gPfuh0e5gOgP/8gLfzh0e5gOgP/8gGf5h0e5gOgP/8gBf/h0e5gOgP/8f8gFh0e5gOgP/8f3gLh0e5gOgP/8fygQh0e5gOgP/8fugVh0e5gOgP/7fr
					gZh0e5gOgP/7fogdh0e5gOgP/7flggh0e5gOgP/7fkgih0e5gOgP/7fjgjh0e5gOgP/7figkh0e5gOgP/7fjgjh0e5gOgP/7fkghh0e5gOgP/7fmgfh0e5gO
					gP/7fogdh0e5gOgP/7fogdh0e5gOgP/8ftgXh0e5gOgP/8fygRh0e5gOgP/8f2gMh0e5gOgP/8f8gFh0]],
				["UpperLeg.R"] = [[
					hHisgY71hLgCvvhHitgX7thPf6v8hGiugX7mhTfywIhGiugW7ghXfrwShGivgW7bhbflwahGivgV7YheffwehGivgV7WhhfawghGiugV7XhjfXwfhGiugV7Z
					hlfUwbhGitgU7dhnfTwUhFisgU7ihofTwNhGisgU7mhofUwEhGirgV7rhnfWv8hGiqgV7whlfZv1hGiqgV7zhjfdvvhGiqgV72hhfivqhGiqgW74hdfovohG
					iqgW74hZfuvnhGirgX74hVf0vphHisgX72hQf7vrhHisgY71hLgCvvhHitgZ7zhGgJvyhHiugZ7xhCgPv1hHiuga7wg9gWv3hIivga7wg5gcv3hIivgb7yg1
					ghv1hIivgb70gzgmvxhIiugb73gxgqvrhIiugc78gwguvjhIitgc8BgvgwvahIisgc8FgwgxvRhIisgc8KgxgyvJhIirgc8NgygwvDhIiqgb8Pg1guu/hIiu
					gZ7vgyglv6hIi7gU5tglgQzBhIi0gW65gygUxThHiwgX7Yg6gTwhhHivgX7hhAgNwRhHitgY7xhGgJv1]],
				["LowerLeg.R"] = [[
					hKhxf0tufcf/85hJhxf0tyflf883hJhxf1t2ftf681hIhxf1t5f0f380hIhxf1t6f7f08zhHhxf1t5gCfy80hHhxf0t1gHfw82hHhxf0twgLfu84hHhwf0to
					gOft88hGhwfztggQfs9AhGhvfytYgQfs9DhGhvfytQgPfs9HhHhvfxtJgNft9KhHhufxtFgKfu9MhHhufxtDgGfv9NhHhufxtEgAfx9MhIhufxtIf6fz9LhI
					hvfytPfzf29HhJhvfytYfsf59DhJhwfztifkf88+hKhxf0tufcf/85hKhxf1t5fVgC8zhKhyf2uEfNgG8uhLhyf2uNfGgJ8phLhzf3uUe/gM8mhMhzf3uXe5
					gO8jhMhzf3uZezgQ8jhMhzf3uXevgS8jhMhzf3uSergS8lhNhyf2uMepgT8ohNhyf2uFeogS8shNhxf1t9eogS8whNhxf1t1eqgR80hMhxf0tuetgP83hMhy
					f2uIe0gQ8rhKh4f/wCfEgX7qhLh0f5u0fEgP8VhLhzf3uSfIgK8mhKhyf2uGfOgH8thKhxf0t0fVgC82]],
				["Foot.R"] = [[
					hHgwgp8kf/gAuZhHgwgp8kgGf9uZhHgwgp8kgNf6uZhHgwgp8kgTf2uZhHgwgp8kgZf0uZhHgwgp8kgefxuZhHgwgp8kgifvuZhHgwgp8kglftuZhHgwgp8k
					gofsuZhHgwgp8kgpfruZhHgwgp8kgpfruZhHgwgp8kgpfsuZhHgwgp8kgnfsuZhHgwgp8kgkfuuZhHgwgp8kghfwuZhHgwgp8kgcfyuZhHgwgp8kgXf0uZhH
					gwgp8kgSf3uZhHgwgp8kgMf6uZhHgwgp8kgFf9uZhHgwgp8kf/gAuZhHgwgp8kf5gEuZhHgwgp8kfzgHuZhHgwgp8kftgKuZhHgwgp8kfngNuZhHgwgp8kfi
					gPuZhHgwgp8kfegRuZhHgwgp8kfagTuZhHgwgp8kfXgVuZhHgwgp8kfVgWuZhHgwgp8kfUgWuZhHgwgp8kfUgWuZhHgwgp8kfWgVuZhHgwgp8kfYgUuZhHgw
					gp8kffgRuZhHgwgp8kfugJuZhHgwgp8kfsgKuZhHgwgp8kfvgJuZhHgwgp8kf0gGuZhHgwgp8kf5gEuZ]],
				["Toe.R"] = [[
					hHgOgP/8f/gBh0hHgOgP/8gEf7h0hHgOgP/8gJf1h0hHgOgP/8gOfwh0hHgOgP/8gSfrh0hHgOgP/7gVfnh0hHgOgP/7gYfjh0hHgOgP/7gbfgh0hHgOgP/7
					gcfeh0hHgOgP/7gdfdh0hHgOgP/7gefch0hHgOgP/7gdfdh0hHgOgP/7gcffh0hHgOgP/7gafhh0hHgOgP/7gXfkh0hHgOgP/7gUfoh0hHgOgP/8gRfsh0hH
					gOgP/8gNfxh0hHgOgP/8gIf2h0hHgOgP/8gEf7h0hHgOgP/8f/gBh0hHgOgP/8f7gGh0hHgOgP/8f2gMh0hHgOgP/4f1gSdWhHgOgP/4fxgYdWhHgOgP//fs
					gbfihHgOgP/pfugibXhHgOgP/9flghhMhHgOgP/cfsgpaMhHgOgP/7fhglh0hHgOgP/cfrgsaMhHgOgP/9figmhMhHgOgP/7figkh0hHgOgP/7fjgih0hHgO
					gP/7fogdh0hHgOgP/8fzgQh0hHgOgP/8fygRh0hHgOgP/8f0gPh0hHgOgP/8f3gKh0hHgOgP/8f7gGh0]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAjugx/9hHf6hAgAjxgx/8g8fAhBgAj4gx/7gmeShCgAj+gx/5gKd3hBgAkAgx/5fsdzg/gAj7gx/6fReIg9gAj0gx/8e/eyg9gAjvgx/9e4fpg/gAjvgx/9
					e9gkhBgAj0gx/7fOhZhCgAj7gx/6foh+hCgAkAgx/5gFiOhAgAj+gx/5giiFg+gAj4gx/7g5hlg9gAjxgx/8hGg0g+]],
				Spine1 = [[
					gAjsgSAEe6gMhWf+jvgSAFfGgvhef9j2gSAGfdhKhyf8j8gSAHf6hYiGf8j+gSAIgYhWiMf8j6gSAHgxhFiAf+jygSAFhCgqhqf/jtgSAEhIgHhZgBjtgSAE
					hCfihYgDjygSAFgwfChngEj5gSAHgVeth9gEj+gSAIf3eniLgEj8gSAHfaexiIgDj2gSAGfFfHh1gCjvgSAFe6fnhg]],
				Spine2 = [[
					f/jyfTAQe7gRjof7j1fTARfEgej6f4j9fTAWfZgmkjf2kEfUAcf1gnlIf2kGfUAdgTgglSf4kCfTAagrgUk5f7j5fTAUg9gGkOf/jzfTAQhFf3jtgDjyfTAQ
					hCfojtgHj4fTAUgzfdkNgJkBfUAZgZfZk4gKkGfUAdf8fclRgJkFfUAcfgfmlJgGj+fTAXfLfzkkgDj1fTARe+gCj7]],
				Neck1 = [[
					f+j5ezDJfEgmtvf6j9e0C9fQgvtXf3kGe0DbfngxuVf1kPe1ESgEgov9f2kRe1FAgdgWxJf4kLe1FBgwgBxKf7kCe0EVg7fuwAgAj6ezDdg+fguYgEj6ezC+
					g4fVtYgIkBe0DHgmfPttgKkLe1D1gLfSvIgLkRe1EtfvfgwqgKkPe1FHfYf1xUgHkHe0EvfKgJwtgDj9e0D3fDgavL]],
				Neck2 = [[
					f6kreLHLfOgz0Jf2kueKHNfdg50Lfzk6eOHtfzg10yfzlHeVIXgMgm1jf1lMeaIwghgQ19f5lGeZIlgvf41xf+k6eUH/g2fj1GgDkueNHXg1fT0XgIkreJHI
					grfI0FgMkzeLHagZfH0bgNlBeRIDgAfR1LgMlKeYInfpfk10gJlKeaIvfXf818gElAeXIUfNgT1ef/kzeQHpfJgm0t]],
				Head = [[
					f3ldeAAEe5gLhPfzlfd/AEfAf1hcfxlseGAFfUfgh1fyl5eQAGfwfQiJf2l+eXAHgNfIiLf7l5eVAGgnfLh6gBlseNAFg6fXhhgHlgeDAEhFfqhQgMlcd/AE
					hFgAhTgPlleCAEg4gWhogPlzeLAGgfgoiAgMl9eUAHgBg1iNgIl9eXAGflg4iFgClzeSAFfPgxhuf8lleIAEe/ghhW]],
				Jaw = [[
					f3lXdK/5hHf8iEf0ladJ/7g/gSh3fzlodP/8gpgkhkf1l3dZ/7gKgxh1f5l8dg/6fsg1h8f+l1df/7fTgxhzgDlndX/7fCgjhygHladN/6e5gPiDgLlXdI/6
					e7f5iAgNlgdL/7fLflhrgNlwdU/7fmfUhtgJl7de/7gGfMh6gFl6dh/6gifMh5gAlvdb/7g2fVhrf7lgdR/6hEfmh8]],
				ClockMin = [[
					gAjkf6e0Jhix2jf9jmf6jnJ7du2wf6jtf6oTLWYX1qf4jzf5sfNoTZzQf3j1f5v5QcPYv4f4jxf5yiTkMgsBf7jqf60lXAKpn5f+jlf62Ea/JrjggCjkf62z
					fsJmezgFjpf62Yk+KhaBgHjwf50nqOMZVigIj1f5xquxO/RugIjzf5t/yNR+OtgGjuf5p/0jVPMYgEjnf6lv19Y6Kn]],
				ClockHour = [[
					gAjkf6e0Jhix2jf9jmf6e8Jqig2uf6jtf6fMJwh125f4jzf5fTJzhH2/f3j1f5fEJygr2/f4jxf5egJvgq25f7jqf6dzJpg62wf+jlf6dUJihJ2lgCjkf6dU
					JYhK2agFjpf6dzJMg82SgHjwf5ejJDgv2OgIj1f5fKJAgx2NgIjzf5fZJDhM2PgGjuf5fPJLh32UgEjnf6e9JVig2a]],
				Gear2 = [[
					f4lQeme0Jhix2jf0lUeofhJph62yfzleetgWJwgo29f0lnewhCJ0fT3Af3lqexhZJ0eR27f7lkevhbJudq2ygAlaeqhVJldW2ngGlSenhdJbdB2agKlReniF
					JTce2KgNlZeqjMJTbu15gNljevkiJda91pgLlpexlvJuac1ggHloewmhJ/aQ1hgClfesm6KOaT1qf9lVeonJKeaT10]],
				["UpperArm.L"] = [[
					fNjbehvNUzkO5efJjfeiv0U2jt5NfEjqeixXUqii4OfCj1eizPUUhE2tfCj5ei03T6ft1BfEj1eh1+TiewzlfHjreh2kTNePyofLjjeh20S+eIyJfQjjeg21
					S2eUyEfVjqef2nS4exyZfYjzee2CTDfgzPfZj5ee07TUgj0mfYj1efzRTrhz2SfWjrefxXUGjD35fSjgegvzUhj95B]],
				["LowerArm.L"] = [[
					e1ireysF70X+mRewivexsg8RZklKeri5ertS8ucqjTenjEeiuG8rgfhOeljJeaur8HkIfcemjHeTu+7Ym1eUeoi/ePvH63oSd5esi4eNvL6wokeEeyi4eMvL
					7Bn1eqe3i+eMvE7imMfme7jFePuy8Hjug4e9jIeVuU8ggjice+jDedto8gdHkIe8i5ens28JaElke5ivevsP7yYMmY]],
				["UpperArm.R"] = [[
					gyjieg22tHh0yDgujmeg2wtKhgyKgqjvef2YtEg6yvgnj3ee1js1gBz3gnj4ee0Kshe21bgpjxefyUsIdj3Igsjlegwfrscc4igwjcehvWrUb15Vg1jceivX
					rJb95bg6jkeiwgrOc04zg9jweiyTrgeM3gg+j4ei0Hr5fq13g9j4ei1fsSg10Qg7jweh2VsphkzCg3jmeh2vs8h3yV]],
				["LowerArm.R"] = [[
					hRi3eMQ162oUhshMi6eMQ47QnIg7hHjCeNRD71lEf0hEjIeRRb8WiNeYhCjHeZSB8je1cuhDi/eiSx8WbfbGhFi0erTg77Y8Z7hJisexT67vX3ZkhOiseyTy
					8AYjaLhTizeuTJ8ia9bthXi/enST8xeidwhajHeeRl8ciZfwhbjJeWRJ7vlohOhZjDeRQ87Fnuh+hWi7eOQ36wokiF]],
				Gear1 = [[
					f5lPgJfHJgie2lf4lSgKepJ7ix28f4lZgMeNKRi13Of6lggOdrKfiz3Zf9lhgPc9Kli63YgAldgNcEKkjN3MgDlWgLbJKbjr20gGlQgKaVKOkL2WgIlQgKZ0
					J8kn12gIlVgLZnJpk/1YgHldgNZlJala1BgElhgPZjJVl/0xgBlggOZXJdmy0nf+lagMZBJznu0jf7lSgKYmKUoo0l]],
				Gear3 = [[
					f6lEhefHJgie2lf8lGhff4J4hf3Df/lLhhgpKNgO3ZgClQhihTKae33igElRhjhyKcdp3cgGlOhiiIKTcs3LgGlIhgigKCb+2wgGlEhejEJtbW2QgFlEhej9
					Jcau1sgClJhglLJVaE1JgAlOhimiJcZc0sf9lRhjnzJwY70bf7lQhiozKOYh0Xf6lLhhphKxYI0ff6lGhfqCLZXo0r]],
				Tail1 = [[
					gAj2hXbshOhI/qgCj5hXayguhD/igEkAhWaggIgw/ggFkGhWbAfigV/mgFkHhWb/fAf4/ugFkDhWczenfe/ygDj8hXc4eefJ/ygBj3hXcNene7/tf/j3hXbM
					fBe4/mf9j8hXaifkfF/gf8kDhWaqgLfd/if7kHhWbegwf5/qf7kGhWcdhOgV/xf8kAhXc8hggt/zf+j5hXcnhghA/w]],
				Tail2 = [[
					gGkQi1cBj7g+/egFkZi0aMiYg+/WgEkhizZDgdgw/NgCkki0ZXefgU/Qf/kgi1a5cxf2/af9kXi2crbkff/gf6kPi3dfbHfR/gf6kOi2czbjfG/gf6kUi0bF
					cyfA/bf7kdizZeekfH/Rf9kkizZBgjfd/Nf/kji1aBibf8/VgCkci2b1j7gX/egFkSi3dQkxgp/ggGkOi2dVkyg1/g]],
				Tail3 = [[
					gdkpkRdFnPgh/BgTk8kOazlUgh/HgFlLkMYuigge/Df4lMkNYOfTgL/Bfsk/kRZocOfv/HfikrkTcBZwfb/HfdkfkTd0YWfY++ffkikSdzYRfe+9fokykQcB
					Zlff/Ff0lFkNZocBff/FgBlOkMYOfGfq/BgOlHkPYtiSgD/Egak1kSazlIgd/JghkkkTdGnHgo/DgjkfkTeEn4gl+8]],
				Tail4 = [[
					hIk7lodjqDgK+Rgylclmbioif2+ggUl3ljY8lkfx+sf0l7lkXfhsfr+yfWllloYHdhfZ+5e9lElracZufH+2ewktlpc6W/fM+hexkwlod4V2fn+QfClLlncu
					WggC+XfdlrlkaNYzgN+of8l8ljX/cTgQ+vgclzlmXhgagd+1g4lVlqZJkegy+6hLk2lqbxn1g6+thRkrlpdqp0go+W]],
				Hourglass = [[
					iDlKm2dlnAgZ/Hhkl2m3bilUgU/Og1mgm2Y9ixga/Ff+mtm4XefzgN+1fImUm+YGc2fk+1eZlmm/adaZe/+/d7lBm6c+Y4fA/Bd3k9m2d7Yofb/DeKlem2cv
					Ztft/MeymNm2aNb4fo/Mfmmrm2X/etfo+8gdmlm7XhhugG+zhRl+nAZJkegy+6h5lQm9b0mghG/BiKk6m3dunbg0/B]],
				["UpperLeg.L"] = [[
					e/iVgj32epgY1Se9iYgn56eyfbyue7ihgq8Ze0ehune4ipgs+qezdgoue2itgs/oe+cmjPe0iqgr/yfQckg0ezikgo/2fQdihYezifgk/qe8e7kUe0ifgg/M
					ecf/m9e3ijgc+leAg0pHe6ioga9gduhgsEe9iqgZ8Rdmh3uqe/ingZ7Rdqh4wefAifgc6bd5hlx1fAiYgf5YeOhDzX]],
				["LowerLeg.L"] = [[
					e8hPgbmIfbfw/Ze4hWgRjMgSfV/0ezhogCjNhVfL/yesiFfxmuiofh/KeniffpsPjxgU9Uelinfnw3kAhD63eoiffjzsjRhQ49euiNfh1IiAhE36eziBfg0I
					gxg+41e4h9fixmfsg86se8h3fovme2g475e/hxfxt1eWg08yfBhpf5rweMgq9sfBhfgBpTeYga+ke/hUgMnIe1gF/K]],
				["Foot.L"] = [[
					e5gwho8je/ghuYe5hGhi7/fugKvfe5hYhT7kgrfnwNe5hjg87Shye7wke5hlgi7KixeUwle5hegJ7RjGeJwVe5hPf17pikeiv1e5g7fr8OhffOu9e5gwfy8k
					gWf1uZe5gwgD8kfZgUuZe5gwgT8iepgsuYe5gwgk8heNg6uXe5gwg18geCg/uXe5gwhG8geKg8uXe5gwhX8ieggwuY]],
				["Toe.L"] = [[
					e5gOhP/6fRg4h0e5gihM/2f0gQjDe5gzg+/vgdfYj4e5g9go/ohNeTkUe5g/gO/hh3dWkYe5g5f1/hiGdEkHe5grfg/qhxdojfe5gYfT/2hDesiee5gOfY/8
					gQfth0e5gOfp/7fkgih0e5gOf6/5fChLh0e5gOgL/4ethjh0e5gOgc/3emhshze5gOgt/3erhmh0e5gOg+/5e7hTh0]],
				["UpperLeg.R"] = [[
					hMifgi/ShSgYmkhKigge+9hzfnn2hIimgb+GiKe0qkhFiqgZ84iXeStdhCipgZ7uiZeGvqhAijga62iQePxKhAibgd59h9eqyjhAiVgh4shlfT0RhCiWgl41
					hSgG0IhEicgp7HhNhBw6hHilgr9phNh+r0hJisgs/UhKjAlthLisgs/vg4jkhmhNiogp/1gtjCgxhNiigm/0g4hyil]],
				["LowerLeg.R"] = [[
					hPiDfi1iesfF3mhLh/fgyzfzfD53hGh6fkwigxfG7XhCh0fsuuhdfK8WhAhtf1s2hyfQ9Pg/hkf9qjhxfd+JhAhZgGoIhbfw+6hChRgTmcg4gF/UhGhSgWkW
					gMgf/shLhegKixfPgz/2hQh2f5kjeCgu/mhXiUfspccvgH+Zhbimfouxb/fR8FhailflyfcSey5zhViXfh0jdVe14W]],
				["Foot.R"] = [[
					hHgwfp8jfJgcuYhHgwf68kgKf7uZhHgwgL8jhBffuYhHgwgc8hhofMuXhHgwgt8gh7fCuXhHgwg+8gh8fBuXhHgwhP8hhtfJuXhHgwhf8ihRfXuYhHg7hm8Q
					gsfpu/hHhPhc7xf1gGv5hHhehI7aeygvwbhHhlgv7NdrhbwnhHhjgV7Lc9h2wfhHhYf+7bdFhuwHhHhGfv76d8hJvc]],
				["Toe.R"] = [[
					hHgOfQ/7fZgvh0hHgOfh/8gHf4h0hHgOfy/6gvfIh0hHgOgD/4hKenh0hHgOgT/3hYeWhzhHgOgk/3hZeVhzhHgOg1/4hOeih0hHgOhG/6g6e6h0hHgYhP/4
					gffZiehHgrhG/zf5gKjghHg5g0/sfLhKkJhHg/gc/keciPkZhHg9gB/gd9i6kShHgzfp/leAivj2hHgifY/wekh4jC]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAj7gx/4gAgAirgAjjgx/2f1e1irgAjogx/1fxeWiqgAkBgx/2f1e1irgAj7gx/4gAgAirgAjjgx/2gLhLirgAjogx/1gPhqiqgAkBgx/2gLhLir]],
				Spine1 = [[
					gAj2gSABgAgAgZf+jegSADgQhKfof9jjgSAEgXhpfzf+j8gSADgShKgkgAj2gSABgAgAgZgCjegSADfwe2fogDjjgSAEfpeXfzgCj8gSADfue2gk]],
				Spine2 = [[
					gAj4fTANgAgAjZf5jcfTAGgVhJh3f2jjfTAJgfhmiNf5j+fTAQgahHjvgAj4fTANgAgAjZgHjcfTAGfre3h3gKjjfTAJfheaiNgHj+fTAQfme5jv]],
				Neck1 = [[
					gAj/ezEagAgAwKf3jgezDAgug8tbfzjne0DUhEhTuCf3kGe0Exg1g2wvgAj/ezEagAgAwKgJjgezDAfSfEtbgNjne0DUe8etuCgJkGe0ExfLfKwv]],
				Neck2 = [[
					gAk3eUJTgAgA2if1kReJHQg8gu0PfwkaeMHuhWhA0wf2k/eXJ0hBgn3AgAk3eUJTgAgA2igLkReJHQfEfS0PgQkaeMHueqfA0wgKk/eXJ0e/fZ3A]],
				Head = [[
					gAlqeTANgAgAjbf1lDd/AFgUgjh5fxlMeEAHgegxiOf3lyeZAQgbghjxgAlqeTANgAgAjbgLlDd/AFfsfdh5gPlMeEAHfifPiOgJlyeZAQflffjx]],
				Jaw = [[
					gAlsdd/8gAgAhwfzlAdJ/ff0fZllfulKdN/oftfKkvf1l1di/+fqfbg6gAlsdd/8gAgAhwgNlAdJ/fgMgnllgSlKdN/ogTg2kvgLl1di/+gWglg6]],
				ClockMin = [[
					gAjrf6d3JfiJ2hf8jTf7lNK2aC2pf6jYf7s0O0RXysf8jwf6zRV2LHqlgAjrf62hd3JfiJgEjTf72pl+K2azgGjYf7ysupO0TMgEjwf6ql05V2Mv]],
				ClockHour = [[
					gAjrf6d3JfiJ2hf8jTf7ctKejK3Nf6jYf7c6Kzi33kf8jwf6d/KUhy3WgAjrf6d3JfiJ2hgEjTf7c2IzjT1igGjYf7dJIcjG1NgEjwf6eOIqiB1s]],
				Gear2 = [[
					gAlWeld3JfiJ2hf3k2eddxKViA3Vfzk9effAKmgj3vf4ldeohMKQeV3XgAlWeliTJgdt2ggJk2edilIud91sgNk9efkGIncz1MgIldeomMJbam1H]],
				["UpperArm.L"] = [[
					fNjkehrbUtk37OfDjFenniWfl89Ae+jMepofWrlV86fDjselsXVbj17RfNjkehrbUtk37OfYjDegnPUjm88IfdjKefoHT/m27rfYjqeesOTslK6Y]],
				["LowerArm.L"] = [[
					exi7e9uZ8eiGhCepimfQuQ8ddciDemisfQuc8deJhLeojCfAuw8Rifflexi7e9uZ8eiGhCe6ikfEt78dehkJe+iofAt48hfqkHe7jAe1uE8ejjhk]],
				["UpperArm.R"] = [[
					gzjkehrbrTbJ7OgojDegnPrdZE8IgjjKefoHsBZK7rgojqeesOsUa26YgzjkehrbrTbJ7Og9jFenniphaE9AhCjMepofpVar86g9jselsXqlcL7R]],
				["LowerArm.R"] = [[
					hPi7e9uZDid6hChGikfEt7DjhfkJhCiofAt4DfgWkHhFjAe1uEDicdhkhPi7e9uZDid6hChXimfQuQDjikiDhaisfQucDjh3hLhYjCfAuwDvdhfl]],
				Gear1 = [[
					gAlZgEdqJgiW2gf+lAf/cMKjju3If9lFgAbdLDkf3Uf+legFbJKxk226gAlZgEaKKKl212gClAf/YuJwnI0mgDlFgAX7Jrnxz/gClegFXoKIoI0O]],
				Gear3 = [[
					gAlShZdqJgiW2ggEk9hVedKRhS3YgGlChVf6Kkfj3vgElXhah8KTdi3SgAlShZjjJrcd2Vf8k9hVk0JFb41Zf6lChVmmJMaj0vf8lXhaoaKJYh0d]],
				Tail1 = [[
					gAkHhWcrg5f5/zgDjvhWa8gef+/lgEj0hVbNfygB/ogDkNhWc9fOgH/1gAkHhWcrfHgH/zf9jvhWa8figC/lf8j0hVbNgOf//of9kNhWc9gyf5/1]],
				Tail2 = [[
					gFkbi2fWiufp/3gGkNizcWhHf4/wgDkRizbYe1gF/of+kfi2eYdPgP/1f7kbi2fWdSgX/3f6kNizcWe5gI/wf9kRizbYhLf7/ogCkfi2eYixfx/1]],
				Tail3 = [[
					gWkfkXh4kvfY/lgNkkkSfJi0fj/2f7ktkRcafOgF/xftkpkWfKcFgT/vfqkfkXh4bRgo/lfzkkkSfJdMgd/2gFktkRcagyf7/xgTkpkWfKj7ft/v]],
				Tail4 = [[
					gzkTl0i7mEfS/Rgekplzhxk1fJ/kf3lDlxeOgyf5/7fVkul2fZcNgV/wfNkTl0i7Z8gu/RfikplzhxbLg3/kgJlDlxeOfOgH/7grkul2fZjzfr/w]],
				Hourglass = [[
					hXkBnNi0iEe7/yg7kdnQhnf5e5/7f8lOnTeOd2gD/3e+kxnVfYc/gU/1epkBnNi0d8hF/yfFkdnQhngHhH/7gElOnTeOiKf9/3hCkxnVfYjBfs/1]],
				["UpperLeg.L"] = [[
					e5imgr2Ne3gT2/e3iOgw+lePeapDe3iUgz8tezaVTIe3isgw/6fjeIg/e5imgr9jfJgXsPe7iMgm/sd6ggjze8iRgk6qeEhlxhe7iqgmsRfFhr9f]],
				["LowerLeg.L"] = [[
					e2hgguf5ghf8//evhpf2cziDgH/wejjIgI21lChP1zeviofr6dixgdxwe5h0f69hglfxsUe8h7fixIfIgQ7Ae9hRgJmZfEgq/Ue6h4hXsNfigm9k]],
				["Foot.L"] = [[
					e5hgiB7tgDf+v/e5h5hH7ShkfDwme5h4gC7BkVdYwXe5hcfL7riYepv0e5g5e/8zgEf+t7e5gwgG8ieygnuYe5gwhV8jezgnuYe5g+iS6ffLggx5]],
				["Toe.L"] = [[
					e5g8hrAXf/gEkte5hUgzAFfNhpg3e5hSfuAtdFkIbxe5g3e2AVeXiMcie5gYelADf9gEeue5gOfsAGg4e9eMe5gOg8AEgxe5g/e5gWiCAtgOfEmj]],
				["UpperLeg.R"] = [[
					hHimgr9jg3fpsPhFiMgm/siGfgjzhEiRgk6qh8ebxhhFiqgmsRg7eV9fhHimgr2NhJft2/hJiOgw+lhxhmpDhJiUgz8thNlrTIhJisgw/6gdh4g/]],
				["LowerLeg.R"] = [[
					hHh0f69hfbgPsUhEh7fixIg4fw7AhDhRgJmZg8fW/UhGh4hXsNgefa9khKhgguf5ffgE//hRhpf2czd9f5/whdjIgI21a+ex1zhRiofr6ddPfjxw]],
				["Foot.R"] = [[
					hHg5e/8zf8gCt7hHgwgG8ihOfZuYhHgwhV8jhNfZuYhHg+iS6fg1fgx5hHhgiB7tf9gCv/hHh5hH7Secg9wmhHh4gC7BbriowXhHhcfL7rdohXv0]],
				["Toe.R"] = [[
					hHgYel/9f9gEhShHgOfs/6g4e9h0hHgOg8/8gxe5fBhHgWiC/TgOfEZdhHg8hr/pf/gEbThHhUgz/7fNhpfJhHhSfu/TdFkIkPhHg3e2/reXiMje]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAkBgxACgAgAg9gAj8g2ADgAgAhVgAjuhAAGgAgAiQgAjghLALgAgAjOgAjZhRAPgAgAjugAkGgTACgAgAfMgAkdfsANgAgAcggAkdfsANgAgAcggAkdfsAN
					gAgAcggAkbfwALgAgAczgAkUgDAFgAgAd+gAkKgaABgAgAffgAkDgtABgAgAgqgAkBgxACgAgAg9gAkBgxACgAgAg9gAkBgxACgAgAg9]],
				Spine1 = [[
					gAkDgSAPgAgAjugAj+gWARgAgAj8gAjzghAVgAgAkfgAjngsAbgAgAlEgAjggyAegAgAlXgAkFfzAGgAgAiJgAkWfNABgAgAgGgAkWfNABgAgAgGgAkWfNAB
					gAgAgGgAkVfRABgAgAgWgAkQfjADgAgAhSgAkJf7AHgAgAiigAkEgNANgAgAjegAkDgSAPgAgAjugAkDgSAPgAgAjugAkDgSAPgAgAju]],
				Spine2 = [[
					gAkSfUAqgAgAmZgAkOfZArgAgAmegAkEfkAugAgAmpgAj6fwAwgAgAm1gAj1f2AygAgAm8gAkNe1AagAgAlBgAkXeOAOgAgAjpgAkXeOAOgAgAjpgAkXeOAO
					gAgAjpgAkWeSAQgAgAj1gAkVekAWgAgAkjgAkTe8AfgAgAlfgAkSfPAogAgAmNgAkSfUAqgAgAmZgAkSfUAqgAgAmZgAkSfUAqgAgAmZ]],
				Neck1 = [[
					gAkee3EOgAgAv3gAkbe7EmgAgAwggAkSfGFmgAgAyDgAkIfTGvgAgAzngAkDfZHYgAgA0agAkXeWDKgAgAt0gAkeduBigAgApvgAkeduBigAgApvgAkeduBi
					gAgApvgAkedzBrgAgAqKgAkeeFCSgAgArzgAkeeeDMgAgAt6gAkeexEAgAgAvdgAkee3EOgAgAv3gAkee3EOgAgAv3gAkee3EOgAgAv3]],
				Neck2 = [[
					gAlWeWISgAgA1egAlUedJAgAgA2OgAlOevK3gAgA4AgAlHfDM/gAgA5ugAlCfNOJgAgA6igAlKdtGlgAgAzagAlDc5DigAgAumgAlDc5DigAgAumgAlDc5Di
					gAgAumgAlFc/DzgAgAvGgAlKdWE6gAgAw/gAlRd2GigAgAzWgAlVePH6gAgA1DgAlWeWISgAgA1egAlWeWISgAgA1egAlWeWISgAgA1e]],
				Head = [[
					gAmJeRADgAgAhcgAmHebAKgAgAi7gAmAe1AtgAgAmkgAl3fSBugAgAqUgAlyfgCcgAgAsOgAl7dgABgAgAgigAltccAdgAgAaxgAltccAdgAgAaxgAltccAd
					gAgAaxgAlvcjAYgAgAbNgAl4dAAKgAgAc9gAmCdoACgAgAfPgAmIeIACgAgAhAgAmJeRADgAgAhcgAmJeRADgAgAhcgAmJeRADgAgAhc]],
				Jaw = [[
					gAmEda/+gAgAgvgAmHdk//gAgAf8gAmNeA/7gAgAd5gAmQeh/qgAgAbfgAmQez/fgAgAaZgAlzcq83gAgAtygAlSbs9cgAgAshgAlSbs+wgAgAo1gAlSbs+e
					gAgApwgAlWby/EgAgAnngAlkcN/kgAgAlNgAl1cz/2gAgAi8gAmBdS/+gAgAhMgAmEda/+gAgAgvgAmEda/+gAgAgvgAmEda/+gAgAgv]],
				ClockMin = [[
					gAj9f4gAJZgA2ngAj5f9g5JafH2mgAjwgIjHJmc52agAjlgUlmKFaa17gAjgganKKjY21dgAj8faniKrYe1VgAkJe1wRQTPvvtgAkJe12ngMJZf0gAkJe1xc
					uaOkRmgAkIe5s3ynTJNZgAkFfKrxzUUPMsgAkBfipQ0pWwLXgAj+f0l/10aBKMgAj9f4i92bdDJlgAj9f4gz2nfNJZgAj9f4gA2ngAJZ]],
				ClockHour = [[
					gAj9f4gAJZgA2ngAj5f9gDJZf92ngAjwgIgMJZf02ngAjlgUgVJZfr2ngAjggagZJZfn2ngAj8fafBJag/2mgAkJe1eCJeh+2igAkJe1eCJeh+2igAkJe1eC
					Jeh+2igAkIe5eKJdh22jgAkFfKerJbhV2lgAkBfifWJZgq2ngAj+f0f4JZgI2ngAj9f4gAJZgA2ngAj9f4gAJZgA2ngAj9f4gAJZgA2n]],
				Gear2 = [[
					gAl3e5gAJZgA2ngAlze+gXJZfp2ngAlqfKhSJbeu2lgAlgfYiUJgds2ggAlbffi+JldC2bgAlweRiRJgdv2ggAl2dhlhKEaf18gAl2dhrlMlUbzbgAl2dhwI
					QJP4v3gAl2dnxuR9OSuDgAl2d9yOSmNytagAl3ebzET1M8sLgAl3ezz5VOMHqygAl3e50cWVLkprgAl3e50yXFLOo7gAl3e505XWLHoq]],
				["UpperArm.L"] = [[
					fNkIeg1QTsgA0ffNkEek2STRerzDfNj7ev4USxbNvSfNjye75uTLXYrEfNjtfC6JTyVZo1fNj/eB5DTZb7u2fNkDdc5MT/dWvafNkDdc5MT/dWvafNkDdc5M
					T/dWvafNkEdg49T9dhvxfNkFdx4BT1eNxLfNkGeJ2rTufIy6fNkHeb1jTtf00LfNkIeg1QTsgA0ffNkIeg1QTsgA0ffNkIeg1QTsgA0f]],
				["LowerArm.L"] = [[
					exjXeWuR8jgAiGevjXeUvF8CjKgdeqjZeTwP5KqncWeljeeYwPz4xZYKejjieevywW0QWKetjbdjvm7lkXfWexjcc+uC8cdhjVexjcc+uC8cdhjVexjcc+uC
					8cdhjVexjbdEuE8ddrjQexjadauI8geVi7exjYd4uN8ifMigexjXePuR8jf1iLexjXeWuR8jgAiGexjXeWuR8jgAiGexjXeWuR8jgAiG]],
				["UpperArm.R"] = [[
					gzkIeg1QsUgA0fgzkEek2SsvhVzDgzj7ev4UtPkzvSgzjye75us1oorEgzjtfC6JsOqno1gzj/eB5DsnkFu2gzkDdc5MsBiqvagzkDdc5MsBiqvagzkDdc5M
					sBiqvagzkEdg49sDifvxgzkFdx4BsLhzxLgzkGeJ2rsSg4y6gzkHeb1jsTgM0LgzkIeg1QsUgA0fgzkIeg1QsUgA0fgzkIeg1QsUgA0f]],
				["LowerArm.R"] = [[
					hPjXeWuRDdgAiGhRjXeUvFD+c2gdhWjZeTwPG2VZcWhbjeeYwPMIOnYKhdjieevyPqLwWKhTjbdjvmEbbpfWhPjcc+uCDkifjVhPjcc+uCDkifjVhPjcc+uC
					DkifjVhPjbdEuEDjiVjQhPjadauIDghri7hPjYd4uNDeg0ighPjXePuRDdgLiLhPjXeWuRDdgAiGhPjXeWuRDdgAiGhPjXeWuRDdgAiG]],
				Gear1 = [[
					gAlmgYgAJZgA2ngAligef6JZgG2ngAlWgsfrJZgV2ngAlJg7fXJZgp2ngAlChDfHJag52mgAlofwcTJsjt2UgAl4e9XmLAoa1AgAl4e9S/NgtByggAl4e9Pg
					QiwgvegAl3fDOaRyxmuOgAlzfaOsRdxUujgAltf6O1RSxLuugAlogSOsRcxUukgAlmgYOPSAxxuAgAlmgYN2ShyKtfgAlmgYNtStyTtT]],
				Gear3 = [[
					gAlOhqgAJZgA2ngAlJhwglJZfb2ngAk6h9iBJed/2igAkqiLjnJrcZ2VgAkiiSkmJ3ba2JgAlZhEjNJncz2ZgAl0gSnXKnYp1ZgAl0gSu6O/RGxBgAl0gSzv
					U9MRrDgAlxgY1HX4K5oIgAlogv1eY4KinIgAlbhO2AaxKAlPgAlRhl2ac4JmjIgAlOhq2kehJchfgAlOhq2nfnJZgZgAlOhq2ngAJZgA]],
				Tail1 = [[
					gAkEhXehgAgA/9gAj+hcefgAgA/9gAjvhmecgAgA/9gAjehxeZgAgA/8gAjVh3eYgAgA/8gAkOg4bVgAgA/pgAkrgPaFfNgF/bgAkrgPbUfUgC/ogAkrgPbU
					gsf+/ogAkogUbthmf8/qgAkegndDhXgA/0gAkRhAeXgPgB/8gAkHhTfAfqf//+gAkEhXetf4gA/9gAkEhXehgAgA/9gAkEhXehgAgA/9]],
				Tail2 = [[
					gAkOi5e4gAgA/+gAkHi+eegAgA/9gAj4jIdegAgA/5gAjojTcZgAgA/ygAjfjZb2gAgA/ugAkqiWaTgAgA/ef7lOhradebgL/df8lHhtc8epgG/0gElHhtc8
					hXf6/0gKlChzdbjLf1/ugIkwiIe8iuf+/2gBkbiigCgfgB//f+kNi1gKfVf+//f/kMi5fRfwf//+gAkOi5e4gAgA/+gAkOi5e4gAgA/+]],
				Tail3 = [[
					gAkUkbfogAgA//gAkRkfe0gAgA/+gAkIkpc2gAgA/1gAj+kzaxgAgA/jgAj5k4ZsgAgA/XgAlNjyZngAgA/WfxlwjHbMdogT/ifzlajOe8d+gM/6gNlajOe8
					iCf0/6gdlSjSfgkvfp/ogZk3johNkFf3/tgEkbkEiGgugA/6f6kMkXhre/f+/7f+kRkcgMfogA//gAkUkbfogAgA//gAkUkbfogAgA//]],
				Tail4 = [[
					gAkXl+gAgAgA//gAkYmBe0gAgA/+gAkbmJb4gAgA/ugAkemQY0gAgA/LgAkfmSXPgAgA+xgAlzlNYmgAgA/HfjmNkkblc2gc/hfnlgkvgkdTgR/3gZlgkvgk
					itfv/3g6lUkwhPmSfc/VgykvlHjGlafw/YgJkOlljyg9gA/wfzkCl5i1epf//1f7kQl+gxfggA/+gAkXl+gAgAgA//gAkXl+gAgAgA//]],
				Hourglass = [[
					gAkXnggAgAgA//gAkfnke0gAgA/+gAk0npb4gAgA/ugAlJnoY0gAgA/LgAlTnmXPgAgA+xgAmfmlYpcRg5+5fPmnmAbpZcg7+/fXldmQgkdTgR/3gpldmQgk
					itfv/3hglMmKhQmvfe/PhSkcmijHnPf8/AgPj3nFjxjbgT/lfrjxnZi1glgK/3f4kLnggxgCgB/+gAkXnggAgAgA//gAkXnggAgAgA//]],
				["UpperLeg.L"] = [[
					e5ivgY7le2gAwKe5iqga8Nezf8vDe5iegg9cesfxsbe5iSgm+eemfnpoe5iMgq+6ekfhoHe5iygD5Re+gMzle5jHfqxzfjgq6ke5jHfqxzfjgq6ke5jHfqxz
					fjgq6ke5jFftx/fjgq6ce5i+f51cfTge3ue5i2gJ5YfAgMzde5iwgV7Me4gCwze5ivgY7le2gAwKe5ivgY7le2gAwKe5ivgY7le2gAwK]],
				["LowerLeg.L"] = [[
					e3hyf2uIgjgA8se2hwfztmgkgC88e2htfvspgngG9Ye2hqftsHgqgL9me1hqftsBgrgN9pe3hufxtGgff79Me5iGgFxvgNfs6ne5iGgFxvgNfs6ne5iGgFxv
					gNfs6ne5iEgHx6gOfs6ge4h5gAwNgVfy7le3hzf3uTgef78ne3hyf2uFgif/8ue3hyf2uIgjgA8se3hyf2uIgjgA8se3hyf2uIgjgA8s]],
				["Foot.L"] = [[
					e5gwgp8kgAgAuZe5gwgp8kgCf/uZe5gwgp8kgFf9uZe5gwgp8kgIf8uZe5gwgp8kgKf7uZe5gwgp8kf8gCuZe5g6gl7JfsgNw7e5g6gl7JfsgNw7e5g6gl7J
					fsgNw7e5g3gm7ifrgMwSe5gwgp8kfygHuZe5gwgp8kf7gCuZe5gwgp8kf/gAuZe5gwgp8kgAgAuZe5gwgp8kgAgAuZe5gwgp8kgAgAuZ]],
				["Toe.L"] = [[
					e5gOgP/8gAgAh0e5gOgP/8gBf+h0e5gOgP/8gEf7h0e5gOgP/8gGf5h0e5gOgP/8gHf4h0e5gOgP/9f9gEeve5gTgS/+f2gWfIe5gTgS/+f2gWfIe5gTgS/+
					f2gWfIe5gSgR/9f1gWewe5gOgP/7f3gNeEe5gOgP//f9gEf+e5gOgP/9f/gBhce5gOgP/8gAgAh0e5gOgP/8gAgAh0e5gOgP/8gAgAh0]],
				["UpperLeg.R"] = [[
					hHivgY7lhKgAwKhHiqga8NhNgEvDhHiegg9chUgPsbhHiSgm+ehagZpohHiMgq+6hcgfoHhHiygD/GhiglnShHjHfq/ShlhnZthHjHfq/ShlhnZthHjHfq/S
					hlhnZthHjFft/ghmhha4hHi+f5/7hnhEgehHi2gJ+xhegfonhHiwgV8bhPgGuohHivgY7lhKgAwKhHivgY7lhKgAwKhHivgY7lhKgAwK]],
				["LowerLeg.R"] = [[
					hJhyf2uIfdgA8shKhwfztmfcf+88hKhtfvspfZf69YhKhqftsHfWf19mhLhqftsBfVfz9phLiTfEthfQfy8/hMjieq2nfAfg2mhMjieq2nfAfg2mhMjieq2n
					fAfg2mhMjber1nfCfh3khMi9ezxtfJfp6ohLiSfNuVfSf08mhKh4fst5fbf+80hJhyf2uIfdgA8shJhyf2uIfdgA8shJhyf2uIfdgA8s]],
				["Foot.R"] = [[
					hHgwgp8kgAgAuZhHgwgp8kf+gBuZhHgwgp8kf7gDuZhHgwgp8kf4gEuZhHgwgp8kf2gFuZhHhTf696fwgGrWhHiPeq/8fbgChmhHiPeq/8fbgChmhHiPeq/8
					fbgChmhHiJey/2fdgDi6hHhwfU/GfngGnfhHhPf/9vfzgFrxhHg3gg8yf9gBt9hHgwgp8kgAgAuZhHgwgp8kgAgAuZhHgwgp8kgAgAuZ]],
				["Toe.R"] = [[
					hHgOgP/8gAgAh0hHgOgP/8f/gCh0hHgOgP/8f8gFh0hHgOgP/8f6gHh0hHgOgP/8f5gIh0hHg3fa/if1gNaqhHiLeA6yfjgXOhhHiLeA6yfjgXOhhHiLeA6y
					fjgXOhhHiBeJ7tflgXQChHhdeu+XfugTV8hHgyfg/0f3gKcqhHgVgG/+f+gCg2hHgOgP/8gAgAh0hHgOgP/8gAgAh0hHgOgP/8gAgAh0]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAkBgxACgAgAg9gAj9gxABgAgAgjgAj1gxABgAgAfngAjugxACgAgAe2gAjvgxACgAgAe/gAj/gxADgAgAhXgAkIgxANgAgAjagAkJgxAPgAgAjvgAkJgxAP
					gAgAjvgAkJgxAPgAgAjvgAkJgxAPgAgAjvgAkJgxAPgAgAjvgAkJgxAPgAgAjvgAkJgxAPgAgAjvgAkJgxAPgAgAjvgAkJgxAPgAgAjvgAkJgxAPgAgAjvgA
					kJgxAPgAgAjsgAkGgxAIgAgAiugAkCgxADgAgAhZgAkBgxACgAgAg9gAkBgxACgAgAg9gAkBgxACgAgAg9]],
				Spine1 = [[
					gAkDgSAPgAgAjugAj+gSALgAgAjJgAj0gSAEgAgAh3gAjsgSACgAgAg0gAjtgSACgAgAhAgAkCgSATgAgAkSgAkPgSA0gAgAnGgAkQgTA7gAgAnkgAkQgTA7
					gAgAnkgAkQgTA7gAgAnkgAkQgTA7gAgAnkgAkQgTA7gAgAnkgAkQgTA7gAgAnkgAkQgTA7gAgAnkgAkQgTA7gAgAnkgAkQgTA7gAgAnkgAkQgTA7gAgAnkgA
					kQgTA6gAgAnfgAkLgSAngAgAmKgAkFgSAUgAgAkVgAkDgSAPgAgAjugAkDgSAPgAgAjugAkDgSAPgAgAju]],
				Spine2 = [[
					gAkSfUAqgAgAmZgAkLfUAhgAgAlrgAj7fTASgAgAkDgAjvfTAIgAgAivgAjxfTAKgAgAi+gAkSfVA0gAgAnIgAkqfZB2gAgAqpgAktfaCDgAgArOgAktfaCD
					gAgArOgAktfaCDgAgArOgAktfaCDgAgArOgAktfaCDgAgArOgAktfaCDgAgArOgAktfaCDgAgArOgAktfaCDgAgArOgAktfaCDgAgArOgAktfaCDgAgArOgA
					ktfaCBgAgArIgAkjfYBdgAgApdgAkWfVA1gAgAnKgAkSfUAqgAgAmZgAkSfUAqgAgAmZgAkSfUAqgAgAmZ]],
				Neck1 = [[
					gAkee3EOgAgAv3gAkWe1DfgAgAufgAkEe0CEgAgArRgAj0ezBLgAgAojgAj3ezBUgAgApCgAkge4EogAgAwigAk+fAIkgAgA1xgAlCfCJRgAgA2ggAlCfCJR
					gAgA2ggAlCfCJRgAgA2ggAlCfCJRgAgA2ggAlCfCJRgAgA2ggAlCfCJRgAgA2ggAlCfCJRgAgA2ggAlCfCJRgAgA2ggAlCfCJRgAgA2ggAlCfCJRgAgA2ggA
					lCfCJKgAgA2YgAk1e9HNgAgA0NgAkke4E5gAgAw/gAkee3EOgAgAv3gAkee3EOgAgAv3gAkee3EOgAgAv3]],
				Neck2 = [[
					gAlWeWISgAgA1egAlKePG8gAgAz4gAkueDEUgAgAwAgAkWd7CngAgAsmgAkad9C4gAgAtOgAlaeaJAgAgA2PgAl/e8P3gAgA7ngAmDfBREgAgA8SgAmDfBRE
					gAgA8SgAmDfBREgAgA8SgAmDfBREgAgA8SgAmDfBREgAgA8SgAmDfBREgAgA8SgAmDfBREgAgA8SgAmDfBREgAgA8SgAmDfBREgAgA8SgAmDfBREgAgA8SgA
					mCfAQ3gAgA8LgAl1ewNjgAgA6IgAleecJggAgA2vgAlWeWISgAgA1egAlWeWISgAgA1egAlWeWISgAgA1e]],
				Head = [[
					gAmJeRADgAgAhcgAl8eEADgAgAebgAladqBHgAgAXugAk7dYC/gAgASjgAlBdbCmgAgATcgAmMeYALgAfpjLgAmrfUECgYfKvggAmtfeEPfNhxvxgAmtfeE7
					gQfhxBgAmtfeFPgsetxcgAmtfeESfRhnv3gAmtfeEwgAgAwwgAmtfeFWg2ecxlgAmtfeEWfYhWwBgAmtfeEmfxggwfgAmtfeFZg7eTxqgAmtfeEdfjg9wOgA
					mtfdETfkg8v9gAmlfBCZgXe1sDgAmRecARgAgGj8gAmJeRADgAgAhcgAmJeRADgAgAhcgAmJeRADgAgAhc]],
				Jaw = [[
					gAmEda/+gAgAgvgAltdP/ugAgAkDgAk3dA97gAgArUgAkLc97PgAgAwxgAkTc97ygAgAv2gBmNdh/sf7gWkSgDnTew/9fSgmevf5nWe6/7hle4gLgCnZe+/9
					figTewgFnae//6ewgyeOf6nWe6/8hde+gFgAnZe9/+gAgAfEgGnafA/4efg8eDf7nXe7/9hNfKf6f+nYe8/+gdfsfYgHnafA/3eXhBd+f8nXe7/+g4fZfrf8
					nWe5/+g2fZfsgEnDeU/8fRg+e/gAmVdm//gBf7ghgAmEda/+gAgAgvgAmEda/+gAgAgvgAmEda/+gAgAgv]],
				ClockMin = [[
					gAj9f4gAJZgA2ngAj4f5gBJZf/2ngAjtf6gNJZfz2ngAjjf6gwJZfQ2ngAjlf6h1JdeL2jgAj8f4lfKEah18gAkNf3reMhUizfgAkPf3xTRbOtulgAkPf315
					aWKHlqgAkPf31ompKYZXgAkPf3tryBSVN/gAkPf3fv2ngRJZgAkPf3R6xsuGOUgAkPf3KPmI1xZ4gAkPf3KQZ01wmMgAkPf3PERAw8vAgAkPf3UoMdrYzjgA
					kOf3YFK0n71MgAkIf3XvK9oR1DgAkAf4YTKvnt1RgAj9f4bWJ4kq2IgAj9f4erJbhV2lgAj9f4gAJZgA2n]],
				ClockHour = [[
					gAj9f4gAJZgA2ngAj4f5foJZgY2ngAjtf6ezJbhN2lgAjjf6ePJdhx2jgAjlf6eoJbhY2lgAj8f4hyJdeO2jgAkNf3lTKBat1/gAkPf3ncKpYk1XgAkPf3py
					LnWO0ZgAkPf3sfNJThy3gAkPf3vRPUQvwsgAkPf3xzSDONt9gAkPf3z3VLMJq1gAkPf31TYZKtnngAkPf32JbYJ3kogAkPf32hd5JfiHgAkPf32nfsJZgUgA
					kOf32ngmJZfagAkIf32nfkJZgcgAkAf42kedJchjgAj9f42me1JahLgAj9f42nfrJZgVgAj9f42ngAJZgA]],
				Gear2 = [[
					gAl3e5gAJZgA2ngAlve0ftJZgT2ngAlcepfGJag62mgAlLehewJbhQ2lgAlOeifTJZgt2ngAl5e+ikJidc2egAmTfbmpKYZX1ogAmWfgpxLnWP0ZgAmWfgtT
					NtStyTgAmWfgxCRIO+u4gAmWfg0OV3LyqJgAmWfg2MbmJ0kagAmWfg2khoJceYgAmWfg1bnPKlYxgAmWfgzSr0MuUMgAmWfgw1vHPLQ5gAmWfguvxKRRO2gA
					mVfftkyGScN6gAmMfRuRxjRvOdgAl9e/u2xERKO8gAl3e5uHxsR5OUgAl3e5tBygS/NggAl3e5sky0TcNM]],
				["UpperArm.L"] = [[
					fNkIeg1QTsgA0ffNj+eg1dTsf40SfNjqeh15TtfnzzfNjZei2QTtfZzafNjcei2MTtfbzefNkLeg39SbatvZfNkuek5GUDSHnnfNk0el48VGQRl3fNk0el48
					VGQRl3fNk0el48VGQRl3fNk0el48VGQRl3fNk0el48VGQRl3fNk0el48VGQRl3fNk0el48VGQRl3fNk0el48VGQRl3fNk0el48VGQRl3fNk0el48VGQRl3fN
					kzel4/U6QkmJfNkkei45SrWErRfNkPeg2lS3dsyTfNkIeg1QTsgA0ffNkIeg1QTsgA0ffNkIeg1QTsgA0f]],
				["LowerArm.L"] = [[
					exjXeWuR8jgAiGexjOeVuT8jgSh9exi6eTuV8ig6hpexiqeTuX8hhbhYexiteTuX8hhWhbeojqeFxD5loZdLedkseHySwAxyVNebk3eMyBtMzKTcebk3eMyB
					tMzKTcebk3eMyBtMzKTcebk3eMyBtMzKTcebk3eMyBtMzKTcebk3eMyBtMzKTcebk3eMyBtMzKTcebk3eMyBtMzKTcebk3eMyBtMzKTcebk3eMyBtMzKTceb
					k1eLyFtqy9TvehkTeDyP1EuBY7etjkeNvy7jj4f+exjXeWuR8jgAiGexjXeWuR8jgAiGexjXeWuR8jgAiG]],
				["UpperArm.R"] = [[
					gzkIeg1QsUgA0fgzj+eg1dsUgI0Sgzjqeh15sTgZzzgzjZei2QsTgnzagzjcei2MsTglzegzkLeg39tllTvZgzkuek5Gr9t5nngzk0el48q6vvl3gzk0el48
					q6vvl3gzk0el48q6vvl3gzk0el48q6vvl3gzk0el48q6vvl3gzk0el48q6vvl3gzk0el48q6vvl3gzk0el48q6vvl3gzk0el48q6vvl3gzk0el48q6vvl3gz
					kzel4/rGvcmJgzkkei45tVp8rRgzkPeg2ltJiUyTgzkIeg1QsUgA0fgzkIeg1QsUgA0fgzkIeg1QsUgA0f]],
				["LowerArm.R"] = [[
					hPjXeWuRDdgAiGhPjOeVuTDdfuh9hPi6eTuVDefGhphPiqeTuXDfelhYhPiteTuXDfeqhbhYjqeFxDGbXndLhjkseHySQAOOVNhlk3eMyBS0M2Tchlk3eMyB
					S0M2Tchlk3eMyBS0M2Tchlk3eMyBS0M2Tchlk3eMyBS0M2Tchlk3eMyBS0M2Tchlk3eMyBS0M2Tchlk3eMyBS0M2Tchlk3eMyBS0M2Tchlk3eMyBS0M2Tchl
					k1eLyFSWNDTvhfkTeDyPK8R/Y7hTjkeNvyEdcIf+hPjXeWuRDdgAiGhPjXeWuRDdgAiGhPjXeWuRDdgAiG]],
				Gear1 = [[
					gAlmgYgAJZgA2ngAligUfbJZgl2ngAlYgMeFJeh72igAlPgGc3JnjJ2ZgAlQgHctJojT2YgAllgceyJbhO2lgAlugufiJZge2ngAlvgxdiJhie2fgAlvgxaT
					KHlt15gAlvgxWfLfph0hgAlvgxSjN0tdyMgAlvgxO/RHxBu5gAlvgxMNVFzzq7gAlvgxKaZS1mmugAlvgxJjdP2dixgAlvgxJZgh2nffgAlvgxJki32cdJgA
					lvgwJxkL2Pb1gAltgoKClY1+aogAlogcKnnW1ZYqgAlmgYLNo50zXHgAlmgYLqp40WWIgAlmgYL2qR0KVv]],
				Gear3 = [[
					gAlOhqgAJZgA2ngAlNhof5JZgH2ngAlJhhftJZgT2ngAlGhbfxJZgP2ngAlGhcgZJZfn2ngAlKhtjHJmc52agAlFh5nIKiY41egAlEh7rBMQU/zwgAlEh7vc
					PeQkwigAlEh7znUvMZrRgAlEh72Pb4JxkIgAlEh72Rj7JvcFgAlEh7zfrfMhUhgAlEh7ulxTRbOtgAlEh7o200XKLMgAlEh7jm2VcaJrgAlEh7ft2ngTJZgA
					lEh7dp2giXJggAlIh1eJ2jh3JdgAlNhteN2jhzJdgAlOhqco2XjYJpgAlOhqa22BlKJ/gAlOhqaJ12l3KK]],
				Tail1 = [[
					gAkEhXehgAgA/9gAkChXeagAgA/8gAj7hXeLgAgA/8gAj2hXd/gAgA/7gAj3hXeBgAgA/7gAkBhXeefxf//9gAkFhXewfaf+/9gAkFhXeyhPgE/8gAkFhXey
					fpf//9gAkFhXeyfDf9/9gAkFhXeyhJgE/8gAkFhXeygAgA/+gAkFhXeye3f8/8gAkFhXeyg9gD/9gAkFhXeygXgB/9gAkFhXeyexf8/8gAkFhXeygrgC/9gA
					kFhXeygrgC/9gAkFhXesfOf9/9gAkFhXejgEgA/9gAkEhXehgAgA/9gAkEhXehgAgA/9gAkEhXehgAgA/9]],
				Tail2 = [[
					gAkOi5e4gAgA/+gAkLi5fGgAgA/+gAkGi5fkgAgA//gAkDi4f8gAgA//gAkDi4f4gAgA//f/kKi5eaf7gA/8f8kNi5c7eUf+/zgIkNi5cqh0gI/wf+kNi5cq
					gbf8/0f6kNi5cqd2f7/vgHkNi5cqhZgI/ygAkNi5cqhBf+/zf5kNi5cqdyf6/vgGkNi5cqg1gI/zgCkNi5cqhigA/xf4kNi5cqd5f4/vgEkNi5cqgOgG/0gE
					kNi5cth5gC/wf7kNi5dee2f8/3gAkNi5eif8gA/9gAkOi5e4gAgA/+gAkOi5e4gAgA/+gAkOi5e4gAgA/+]],
				Tail3 = [[
					gAkUkbfogAgA//gAkRkbgJgAgA//gAkJkbhUgAgA/9gAkDkaiRgAgA/6gAkEkbiGgAgA/7f+kUkbetgVf//9fykgkZbedof+/lgTkhkZa6hRgU/jgAkhkaa6
					hqfy/iftkhkYa6dXf4/egPkhkZa6gigV/kgGkhkZa6iNf3/gfskhkYa6dpfz/fgLkhkZa6fxgU/lgMkhkZa6ikf9/efskhkYa6eHfv/hgFkhkZa6fBgS/kgQ
					khkZbAiqgC/ff0kdkacpfNf4/zgAkWkbe4fvgA/+gAkUkbfogAgA//gAkUkbfogAgA//gAkUkbfogAgA//]],
				Tail4 = [[
					gAkXl+gAgAgA//gAkQl+g1gAgA/+gAkBl9itgAgA/4gAj1l8kOgAgA/tgAj3l8j9gAgA/vgAkcl9epgqf+/9fkk7l3Zsd6fy/SgalAl2Y2gCgr/LgLlAl2Y0
					iXfv/FfdlAl0Y1eAfj/HgSlAl2Y1fTgp/KgUlAl2Y0ilf7/EfdlAl1Y1ekfc/IgJlAl3Y1engk/JgblAl1Y0imgH/EfglAl1Y1fPfX/Kf/lAl3Y1eDgb/Hgg
					k/l1Y+iWgS/Hfvkxl6bcf/fv/qf+kdl9e3fogA/+gAkXl+gAgAgA//gAkXl+gAgAgA//gAkXl+gAgAgA//]],
				Hourglass = [[
					gAkXnggAgAgA//gAkLngg1gAgA/+gAjxneitgAgA/4gAjbnbkOgAgA/tgAjfnbj9gAgA/vgEklnfepgKgA/9fXlhnQZrcngC/LgZlrnOY0iugD/DgZlrnOY0
					hmf6/IfSlrnMY0b9gC+6gNlrnPY0hxgE/HgjlrnNY0ilf7/EfWlrnNY0cGgA+7gAlrnPY0grgF/KgqlrnMY0jWf8+/fdlrnNY0cjf+++fzlrnOY0fhgG/Kgt
					lpnNY9jyf9++fvlNnZbceQf//nf8kknfe3fwgA/+gAkXnggAgAgA//gAkXnggAgAgA//gAkXnggAgAgA//]],
				["UpperLeg.L"] = [[
					e5ivgY7le2gAwKe5iqga8Keyf8vJe5ihgf9Oeqfys8e5iZgj98ekfqrLe5iagi90elfsrfe5itgW7me2gAwJe5i6gM5CfGgQz5e5i8gK4ifJgT0ge5i8gK4i
					fJgT0ge5i8gK4ifJgT0ge5i8gK4ifJgT0ge5i8gK4ifJgT0ge5i8gK4ifJgT0ge5i8gK4ifJgT0ge5i8gK4ifJgT0ge5i8gK4ifJgT0ge5i8gK4ifJgT0ge5
					i8gK4ofIgS0Ze5i3gP55fBgMyxe5ixgW7Ne5gDwye5ivgY7le2gAwKe5ivgY7le2gAwKe5ivgY7le2gAwK]],
				["LowerLeg.L"] = [[
					e3hyf2uIgjgA8se2hwf0tpglgC87e2htfws0gpgF9Te2hsfusYgsgI9fe2hsfvscgsgI9de3hwf0tqgjgA87e3h2f8vagZf78Ce4h3f+vwgYf672e4h3f+vw
					gYf672e4h3f+vwgYf672e4h3f+vwgYf672e4h3f+vwgYf672e4h3f+vwgYf672e4h3f+vwgYf672e4h3f+vwgYf672e4h3f+vwgYf672e4h3f+vwgYf672e4
					h3f9vsgYf674e3h1f5u4gcf88Ue3hzf2uQghf/8pe3hyf2uIgjgA8se3hyf2uIgjgA8se3hyf2uIgjgA8s]],
				["UpperLeg.R"] = [[
					hHivgY7lhKgAwKhHiqga8KhOgEvJhHihgf9OhWgOs8hHiZgj98hcgWrLhHiagi90hbgUrfhHitgW7mhKgAwJhHi6gM5Cg6fwz5hHi8gK4ig3ft0ghHi8gK4i
					g3ft0ghHi8gK4ig3ft0ghHi8gK4ig3ft0ghHi8gK4ig3ft0ghHi8gK4ig3ft0ghHi8gK4ig3ft0ghHi8gK4ig3ft0ghHi8gK4ig3ft0ghHi8gK4ig3ft0ghH
					i8gK4og4fu0ZhHi3gP55g/f0yxhHixgW7NhHf9wyhHivgY7lhKgAwKhHivgY7lhKgAwKhHivgY7lhKgAwK]],
				["LowerLeg.R"] = [[
					hJhyf2uIfdgA8shKhwf0tpfbf+87hKhtfws0fXf79ThKhsfusYfUf49fhKhsfvscfUf49dhJhwf0tqfdgA87hJh2f8vafngF8ChIh3f+vwfogG72hIh3f+vw
					fogG72hIh3f+vwfogG72hIh3f+vwfogG72hIh3f+vwfogG72hIh3f+vwfogG72hIh3f+vwfogG72hIh3f+vwfogG72hIh3f+vwfogG72hIh3f+vwfogG72hI
					h3f9vsfogG74hJh1f5u4fkgE8UhJhzf2uQffgB8phJhyf2uIfdgA8shJhyf2uIfdgA8shJhyf2uIfdgA8s]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAkBgxACgAgAg9gAj+gxACgCgsgvgAjlgxAEgIhmfSgAkfgxAHgBhmhvgAlPgxANf9g/jQgAlggxAPgAgAjvgAlPgxANgDfBjQgAkfgxAHf/eahvgAjlgxAE
					f4eafSgAjwgxACf8fBf8gAjtgxABgAgAfwgAk3gxAIf/g/ihgAlagxAQf7hmjkgAldgxARf6hmjqgAlAgxAKf+g/izgAj/gxABgAgAgfgAjtgxACf8fBfwgA
					kBgxAEf9eag7gAkBgxADf+e0g9gAkBgxACgAfwg9gAkBgxACgAgAg9]],
				Spine1 = [[
					gAkDgSAPgAgAjuf/j/gSANgFgrjZf9jkgSAFgOhlhNf9kjgSAZgKhlkqf+lWgSAvgEg/mqgAlogTA3gAgAnSgClWgSAvf8fBmqgDkjgSAZf2ebkqgDjkgSAF
					fyebhNgCjwgSAHf4fCiMgAjtgSAFgAgAh6f+k8gSAjgFg/ltf9lhgTA2gGhmnDf9llgTA4gGhmnLf+lGgSAngFg/mFgAkAgSAKgAgAi9gCjtgSAGf4fCh6gD
					kDgSARf0ebjrgCkDgSAQf3e0jugAkDgSAPf+fwjugAkDgSAPgAgAju]],
				Spine2 = [[
					gAkSfUAqgAgAmZf8kMfUAlgJgrl+f3jpfTANgUhkjFf3k1fWA9gThkngf6lvfZBngLg+p8gAmEfaB3gAgAqsgGlvfZBnf1fCp8gJk1fWA9ftecnggJjpfTAN
					fsecjEgGj5fTAVfzfCkYgAj0fTARgAgAkAf6lSfXBRgLg+ozf3l8faBzgRhkqaf3mAfaB2gRhkqjf6ldfYBZgLg+pPgAkMfUAegAgAlWgGj0fTASfzfCkAgJ
					kRfVAsfsecmVgHkSfVAsfxe1mZgBkSfUAqf9fxmZgAkSfUAqgAgAmZ]],
				Neck1 = [[
					gAkee3EOgAgAv2f7kYe2D4gVgmvOf0jve0B7gshcqyf0lEe5FOgzhYxaf5mDe/Hqgig10ugAmYfBIggAgA1sgHmDe/HqfefL0ugMlEe5FOfNeoxagMjve0B7
					fUekqwgIkBe0CtfjfIs0gAj8e0CdgAgAsPf5lje8Gcghg2zNf0mQfBINg3hW1Uf0mUfBIZg3hW1hf5lve9G6ghg2zzgAkWe1DYgAgAuRgIj8e0CefkfIsPgM
					kde3ENfOenvwgJkee3EPfae+v2gCkee3EOf4fyv2gAkee3EOgAgAv3]],
				Neck2 = [[
					gAlWeWISgAgA1df5lOeTH0gdgh06fvkYeCE9g/hQxAfxl/efJmhFhL2xf3nCe1Msgsgt5fgAnYe8NugAgA6QgJnCe1MsfUfT5fgPl/efJme7e12xgRkYeCE8
					fBeww+gKkxeIGKfYfQy0gAkqeGFygAgAyUf3mheqLLgsgt4QfynQe6NXhIhI58fynVe7NlhIhI6Gf3mueuLwgsgt4wgAlKeOHHgAgA0GgKkqeGFzfYfPyUgQ
					lVeWIQe8e01XgMlWeWITfNfH1dgClWeWISf1f01egAlWeWISgAgA1e]],
				Head = [[
					gAmJeRADgAgAhcf5mBeLAJeegtiSftlGdsAVcaiIeTfxmyegAvcghRlpf4nzfCBjd6gfpjgAoIfNB3gAgAqugInzfCBjiGfhpjgPmyegAvjgevlpgTlGdsAW
					jmd3eRgLlhd5AHiOe1gWgAlad0ABgAgAfpf3nTexBCd4gonrfzoBfKB8cqgsqYfzoFfMCBcrgqqof3nge4BOd5gloagAl8eDAFgAgAh4gLlad1AHiOeyfugQ
					mIeRAejhehjugMmJeRAUire2jNgCmJeRAFgkfviAgAmJeRADgAgAhc]],
				Jaw = [[
					gAmEda/+gAgAgvf3l+dV/chqfslpfpk2c49akGfJr4ftm7dq/ajuf8kzf1oKeQ/6iJgOg2gAoied//gAgAfogLoKeQ/6d3fyg2gTm7dq/acSgEkzgXk1c49Z
					b6g3r6gOlYdD+SdigZqAgAlPc/+JgAgAqtf1njd9/yiOgGiyfvoZeZ/zjZgbf7fvoeec/zjXgdfqf1nyeF/2iMgJiBgAl4dN+0gAgAolgOlPc/+FdhgbqmgU
					mKda/DcMgRmtgPmJda/bdIgblMgDmGda/5fagMiRgAmEda/+gAgAgv]],
				ClockMin = [[
					gAj9f4gAJZgA2nf+j5f5mjK3ZK2Ef6jcf7qoNWUD0ef6kef4x2UEMXtSf8lTf31gbxJMktgAlmf32ZjJJnc3gElTf31OpmMHWzgGkef4ytulPJSugGjcf7vy
					xsRiQJgDjpf6ok1rX4LqgAjmf6ht2jeTJdf8k4f4Xl0Po1Kcf6lff3RGvdwLOrf6ljf3M/qA0yUof8lDf3Knkw2tazgAj6f5JZgw2nfQgDjmf6JYac1TlIgG
					j9f5MzSGxZslgEj9f5SONCsyxmgBj9f4Y9KVm81WgAj9f4gAJZgA2n]],
				ClockHour = [[
					gAj9f4gAJZgA2nf+j5f5gRJ4ft3Gf6jcf7exKkhI3sf6kef4igKsdW3kf8lTf3k4KobB2wgAlmf3mDKNZ91zgElTf3mKJiaB1FgGkef4lHI2bS08gGjcf7il
					Icd51XgDjpf6kCJDcT1mgAjmf6kMJyb02Of8k4f4n5LkXv1yf6lff3paMsV+1ef6ljf3qBNAVU1Kf8lDf3pxMZVx07gAj6f5n9K1YD1LgDjmf6n5KFYr0qgG
					j9f5qLKlWzzZgEj9f5qpLHWIzZgBj9f4q4L+VTzugAj9f4rUMaUszm]],
				Gear2 = [[
					gAl3e5gAJZgA2nf7lxe2f9J4gC3GfzlGekerKlhO3rf0mcfCjHKxcr3ff5nYfVmoLHZK2RgAnsfcpYLbWo0lgHnYfVrfLvVCy+gMmcfCszMCUWyBgNlGeks9
					MJUdyHgIlaerwKPOQ4v2gAlUepxzSDONt9f5m6fM0jYZKNoPf1nlfa1Qc3Inj2f1npfb1fgBITgYf5nGfQ12h1IxeOgAlvey2khoJceYgIlUep3GjEKRdOgM
					l2e52xmpLZaAgJl3e52En7LhYqgCl3e51KoeLLXqgAl3e505oqLHXW]],
				["UpperArm.L"] = [[
					fNkIeg1QTsgA0ffHkBei22RwYFvWe/jUen3NSuS3roe/kuem5cXgOviafElxen5UVfQol9fNmIel4LSmTvqZfWlyeg6HU7SJlKfckvec6/XMRWhdfcjTed4h
					R3VWqafWjoed15P+XZumfNjieh4NSoTsqVfElQel50YHO4hJe/l/eq5JV6QAlye/mEeq3oTSStrQfElcel5LVKQ4mifNj+eg6DWQQqjwfWjiee4nSYUdp8fc
					kHeb29QVW4s8fYkIec5FSIXCrAfQkIef3KSic5xMfNkIeg1QTsgA0f]],
				["LowerArm.L"] = [[
					exjXeWuR8jgAiGebjneKzA28qpbReMjKeR0u1koQYNeMk4ePxK2CpRTdeTlyeMyizPtMUXedl/eJzExcwtXPeol0eAx3zwuZVqevk5d7wR3Fq/VwevjId9zl
					2dqKaTeojUeF0A0otdb4edjZeFz91wp3YpeTlbeNwh10qiTNeMmBeRyjy2tHTreNl5eTzvxOvmWVeTlceLyyzjsvUxedkEeDxf3PokVxeojYd/zm2BqdZTev
					j2d/zYz5vEbAevj3d6yg3pp+bSeujgeIwL7giDgyexjXeWuR8jgAiG]],
				["UpperArm.R"] = [[
					gzkIeg1QsUgA0fgskBee52s7pvpsgkjTed4iuIqqqZgkkvec3cvSpssFgqlyeg6HrFt3lKgzmIel6Tm+wzfNg8lxen5UqhvYl9hBkuem2ct5r7tlhBjUen3N
					tTtJrpg7joek5bqIv1k0gzjieh4NtYsUqVgqlQef3yulquragkmBeg6brBtjkggkmFeg7CnOvce1gqldef5/ratnlwgzj+eg2CvVpyuag7jiek3ytHtFqthB
					kHem5WpHw7jYg9kIek4WtBq0sAg1kIeh2ptSjHyBgzkIeg1QsUgA0f]],
				["LowerArm.R"] = [[
					hPjXeWuRDdgAiGhWjzd6yFGsZ6bthRjId9zkJjV1aShRkgd+zKMrQNaQhYl0eAx3MQRnVqhjmYeLvdKmTlS7htlyeMyiMxS0UXhzkfeS0iNPSOYSh0jKeR0u
					KbXxYNhtjseJyEI3YsVnhjjZeFz9KQWJYphYlDeBzJNZPzZDhRmEd+xeMWQ8VzhRmVeCvEKES0UKhYled/yHL8SEWFhjjseJ0SL9SjaphtjZeL0TKiWwYAh0
					kOeOxmJoXlUGhsj3eIzNIyXcZihXjfeNwSE7bJfKhPjXeWuRDdgAiG]],
				Gear1 = [[
					gAlmgYgAJZgA2nf/ljgWfjJ4gd3Gf9lHgJdYKsiq3kf+mGgee3KkhY3rf/m2gre3KHhb3QgAnHgvdYJiio2egBm2gralJWk61XgCmGgeWvKLoSzzgDlHgIST
					MqsmxZgClUgPQ2OUuVwlgAlQgNPIQ8w4vEf/mdglPqRaxevaf+nBguPAS4zAuLf+nEgvNqU00csAf/mngnL1Xb1go+gAlkgTJ3bY2JkogClQgNI0dy11h/gD
					lmgYIYeA1ZhzgClmgYIlfG1vg2gAlmgYJOfy2cgOgAlmgYJZgA2ngA]],
				Gear3 = [[
					gAlOhqgAJZgA2ngClMhpgIJ4f33GgFk8hdflKigO3tgGlphvjvK3b/3YgEmPh3neLZYQ1+gAmdh6qyMIVOz4f8mPh3ttNKS9xnf6lphvwCOiRavwf7k8hdxg
					QBQTupf9lEhj0UUlM9q0gAlBhh1fY7KhnFgEl7hz16gNItf7gGmYh50xleI/aWgGmbh5zVpYKgWBgEmDh1yQsIMgTQgAlQhnyJtgN3Sgf9lBhhxKvxPzRQf6
					lOhqusyoStPJf8lOhqtAzhT8N5f/lOhqruzjUeMwgAlOhqrUzmUsMa]],
				Tail1 = [[
					gAkEhXehgAgA/9gCkBhXehkagJ/pgEjshXekn4fj++gEkhhXeVjpgY/vgClNhXeEdHfa/ygAldhXeAZieb/Of+lNhXeFbNfA/jf8khhXeUgegD/8f8jshXei
					kwfu/mf+j2hXehkbf7/pgAjzhXehgAgA/9gCk2hXeNbofV/ogElXhXeBbXe8/kgElahXd+fif5/7gCk/hXeKk1g2/jgAkEhXeemqgI/Qf+jzhXehi9f7/0f8
					kEhXehcWf2/vf9kEhXeiaEfu/Zf/kEhXeheaf7/6gAkEhXehgAgA/9]],
				Tail2 = [[
					gAkOi5e4gAgA/+gckKi1fHlsgG/egzj0itgqtve983gakri3dxpDgw+mfxlZi3btdYfN/lfalrixbHUsdP9Zfhlai1byVHeA9tf/kri5dueNf7/3gZj1i0gn
					oafX+2gZj/i1f+q6fw+EgAj8i5gGkGf//ufolCi1cvZ1e+/Nfolki1bWVad29vgBlni5bLaFfM/DgflLi1cWkkhH/bgokNixfTrugF9wgQj8i3gIpQfw+ofm
					kNi3e6enf9/8fZkOiye7XUft+xf2kOi5e5cvf5/zgAkOi5e4gAgA/+]],
				Tail3 = [[
					gAkUkbfogAgA//g/kQkRgDkAf6/vh/jujri7wxd/7AhPk5kIdmvNg18Cfil0kVZ1hsfD/VedmMj2YsTacW8Qekl2j9Z7Pqdb6sf0k5kadjYof4/ChLjwkJi7
					n7eu+1hYj+kBhrvkfP75gZj8kYh/qZf1+MfElWkObrcUew/detmDj9ZHSTdH77femEkQY7Txez8rg6likQbCgRhT/khrkRj5gYtPfr9HhGj7kJiBu+fS8Mfd
					kUkYfskQgE/temkUkGfpXof6+3fikUkZfobdf9/qgAkUkbfogAgA//]],
				Tail4 = [[
					gAkXl+gAgAgA//hXkPlxgogCf0//jVjYkVkowEc47GiglJk9dFzZg65QftmZlvX7oLek90ddm9kwWUWQa48bdTmdkkX6NGcm4QfIlIlwdFSWf/8yh5jdldkv
					jfeA/Yirjzk0i6wxen7DhVjwlljav9fj7heulxlrafiHeP/ZdomwkyWxTKb47fedmulMWiPgeV5qg6mAluZoZuhx+qi1kOk5hDqxfV+GiXjulAjcx1es6Tf3
					kWl3gFqugB+Jd0kXlbgAa3gA/kfGkXl3gAbGgA/ngAkXl+gAgAgA//]],
				Hourglass = [[
					gAkXnggAgAgA//hXkMnTgogCf0//kmi2lCkowEc47Gj+lalVc4zZhE5OgenFm4QPoRg06kcyn7luFDcuVftQcBnPk1GeeOM4etd9lYmtDNf6SWdTiMi/m5Ao
					iAjfkvkBjglfE9hZwxi6ipjcmUEfgdv9jae9mSnGBGhoiPYRcrnrllLdpZWULjdOniloaSu2YmFRgTmjnBihmBdeAzjzkHmFe9VPgrB6jwjYljckOLhUFtg1
					kVnDf7VSf/B3dVkXm4gAlJgAAceokXnVgAk6gAAZgAkXnggAgAgAAB]],
				["UpperLeg.L"] = [[
					e5ivgY7le2gAwKe4irgc8PfJfWu/e3iSgo+gfId/pYe3jOgb7Xf0euwhe4kBgR35f4fq1Re5kTgK0Tfggn4te7kCgI2LephK2/e8jPgN6FeChbyXe8iQga91
					d4hNrTe7icgZ9HeMgstIe5iZge9qemfur6e4jngV5sfrfdzDe3kMgS3PgYfT1+e3kPgS2ygcfW2ce4jxgT5Ffwfhz2e5isga8wetf2t9e7iZga9YeLgqsfe8
					iugR7Dd/hYw6e7ivgT7JeNhCwze5ivgX7geugOwSe5ivgY7le2gAwK]],
				["LowerLeg.L"] = [[
					e3hyf2uIgjgA8se0hxf1t6hPfy8xethrfvsOigf39deyiQf7vEh+fV8Je2i8gJxxhHfW6ke5jPgY0PgNfw4xe6i8gLyIfjgX6We8iNf2uEfEgo8te+hifmp/
					e9gd+Xe6hofrrefogX93e2hpfsrwgrgH9ve1ikgAwNhRfd7je2jGgOyohhe958e2jKgRzChfe75pe1itgDwvhNfa7Oe2h2fvsmgngE9Ze6hnfqrJfogW9+e8
					hwfztafCgm9Be7hwf0tpfagd87e3hyf1uCgUgG8we3hyf2uIgjgA8s]],
				["Foot.L"] = [[
					e5gwgp8kgAgAuZe5gwgp8kglftuZe5gwgp8hhtfJuXe5hLgp8HhKfYvNe5hvgp7pgbfwwGe5h+go7VfrgNwne5hvgp7ofKgfwFe5hLgp8HeygqvMe5gwgp8i
					ergruYe5gwgp8kfQgYuZe5gwgp8kgJf8uZe5hbgp75gkfsvpe5h3gp7hgwfkwRe5h6gp7fguflwVe5hjgp7zggfuv0e5g5gp8bgFf+use5gwgp8kfQgYuZe5
					gwgp8iexgouYe5gwgp8jfFgeuYe5gwgp8kf0gGuZe5gwgp8kgAgAuZ]],
				["Toe.L"] = [[
					e5gOgP/8gAgAh0e5gOgP/7gbfgh0e5gOgP/4hOeih0e5gogR/2g0e+ive5hKgU/xgTfnjve5hYgV/sfygUkVe5hKgU/wfbgyjve5gogR/2fKhFive5gOgP/6
					fDhJh0e5gOgP/7fegph0e5gOgP/8gGf4h0e5g3gS/0gZfgjOe5hSgU/vghfTj9e5hVgU/ugffUkBe5g+gT/zgWfijbe5gXgQ/6gDf8iJe5gOgP/7fegph0e5
					gOgP/6fHhEh0e5gOgP/7fVgzh0e5gOgP/8f3gLh0e5gOgP/8gAgAh0]],
				["UpperLeg.R"] = [[
					hHivgY7lhKgAwKhGirgW70hjfdvuhEiQga90iIezrVhEjPgN6Fh+elyXhFkCgI2LhXe22/hHkTgK0TggfZ4thIkBgR35gIgW1RhJjOgb7XgMhSwhhJiRgo+h
					g4iBpWhIidgi9ng8hMr/hHiZge9qhagSr6hFjogM4phhe/0ThEkOgEzxhreY5ChEkSgEzwhqeX5DhFjygK34hee81NhHisga8whTgKt9hIiZgj93g/hQrWhJ
					iugf8HgVhbvMhJivgd79ghhDvhhHivgZ7rhBgOwBhHivgY7lhKgAwK]],
				["LowerLeg.R"] = [[
					hJhyf2uIfdgA8shHhvfytTgGfv9FhChifmqAhDfj+XhEiNf2uEg8fY8thGi8gLyIgdfp6WhHjPgY0PfzgQ4xhKi8gJxxe5gq6khOiQf7vEeCgr8JhThrfvsO
					dggJ9dhPhsfwsoeUgK9WhKhpfsrwfVf59vhGijf+v5gbfo7whFjKgUzvg7fT5JhFjOgUzug7fT5KhGisgCwmgcfo7WhKh2fvsmfZf89ZhPhrfvsXeSgI9dhP
					h0f5uud6gm8UhOh0f5uoeTgd8ZhKhyf2uOfOgG8phJhyf2uIfdgA8s]],
				["Foot.R"] = [[
					hHgwgp8kgAgAuZhHgwgp8kghfvuZhHgwgp8ihVfVuYhHhLgp8HhOfWvMhHhvgp7og2fhwFhHh+go7VgVfzwnhHhvgp7pflgQwGhHhLgp8He2govNhHgwgp8h
					eTg3uXhHgwgp8jfBgguYhHgwgp8kf3gEuZhHhbgp75gzfjvohHh5go7ShQfQwohHh9go7JhQfQw3hHhjgp7zg0fiv0hHg5gp8bf7gCushHgwgp8je+ghuYhH
					gwgp8ieugpuYhHgwgp8jfDgfuYhHgwgp8kf0gGuZhHgwgp8kgAgAuZ]],
				["Toe.R"] = [[
					hHgOgP/8gAgAh0hHgOgP/7gYfkh0hHgOgP/6g9e3h0hHgogR/2g2e7ivhHhKgU/wglfOjvhHhYgV/sgOfskVhHhKgU/xftgZjvhHgogR/2fMhCivhHgOgP/4
					eyheh0hHgOgP/6fTg3h0hHgOgP/8f6gIh0hHg3gS/0gjfRjOhHhUgV/qg2e1kYhHhXgV/ng2e0kphHg+gT/ygkfQjbhHgXgQ/6f9gEiJhHgOgP/6fRg5h0hH
					gOgP/6fGhGh0hHgOgP/7fVg0h0hHgOgP/8f3gLh0hHgOgP/8gAgAh0]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAkBgxACgAgAg9gAkBhIAKgAgAi/gAkBhXATgAgAkSgAkBhTARgAgFj8gAkBhMAMgBfljRgAkBhDAMgDd/iigAkBg+AIgAeTiDgAkBg8AFgAfrh7gAkBg4AE
					gBgOhlgAkGgzAGh6f+hIgAkMgxAsmff0g8gAkCgxCcsMfpg5gAjhgxFBxJffg0gAjFgxHF0BfagwgAjBgxHZ0afZgvgAjOgxGczMfbgxgAjQgxGQy9fcgxgA
					jDgxHO0MfZgwgAi/gxHh0jfZgvgAi/gxHh0jfZgvgAi/gxHh0jfZgvgAi/gxHh0jfZgvgAi/gxHh0jfZgv]],
				Spine1 = [[
					gAkDgSAPgAgAjugAkHgpAigAgAlugAkKg5AzgAgAnAgAkJg1AugAgFmqgBkIgtAmf/flmAgEkGgkAhf3d/lRgDkFgfAbf3eTkzgBkFgdAXf+frkrgAkEgZAU
					gCgOkVgAkIgUAUh5f0j4gBkOgSA5mcfQjpgBkDgSCosHeljcgCjigSFMxCeBjJgCjFgSHPz5dri5gCjBgSHj0Sdoi3gCjOgSGmzFdxi+gCjRgSGby1dzi/gC
					jEgSHY0Edqi4gCjAgSHr0bdni2gCjAgSHr0bdni2gCjAgSHr0bdni2gCjAgSHr0bdni2gCjAgSHr0bdni2]],
				Spine2 = [[
					gAkSfUAqgAgAmZgAkdfuBIgAgAoXgAklgABggAgApogAkjf7BZgBgFpSgCkffyBNf8flopgMkbfpBFfseAn7gKkYfjA8fueVndgCkXfgA4f8fsnWf/kVfcAz
					gDgOnAgCkXfWAwh6fymkgHkbfUBVmdfLmXgMkNfUDHsHebmQgPjofUFuxBdtmHgQjJfUHzz3dQl+gQjEfUII0PdLl9gQjSfUHKzCdYmBgQjVfUG+yzdbmCgQ
					jHfUH80BdOl+gQjCfUIP0YdKl8gQjCfUIP0YdKl8gQjCfUIP0YdKl8gQjCfUIP0YdKl8gQjCfUIP0YdKl8]],
				Neck1 = [[
					gAkee3EOgAgAv3gAkufSGqgAgAzhgAk3flIfgAgA1rf/k1fgH/gDgE1HgDkwfWHCfyfoz/gQkqfNGIe/eQysgNknfGFgfJeix2gCkmfEFVf2fuxpf+kje/E6
					gIgMxAgDkke5EXhme9v/gLkne3Eclccgu4gTkXe3FkqTZrtWgZjwe3HZumXdregcjOe3I6xKWTqGgcjJe3JKxgWKp4gbjZe3IcwaWoqggbjbe3ITwNWuqogc
					jMe3JBxTWPqAgcjHe3JPxoWGp0gcjHe3JPxoWGp0gcjHe3JPxoWGp0gcjHe3JPxoWGp0gcjHe3JPxoWGp0]],
				Neck2 = [[
					gAlWeWISgAgA1egAlsfCLdgAgA4hgAl4fgNtgAgA6Pf/l1fYNGgDgE5zgElvfIL7ftfs45gTloe5Kxeoeh31gQljeuJ+e2ew3IgDlheqJwfyfx2+f+ldejJN
					gKgK2cgKlceZIchLed1jghlZeTIMkAa20Vg6k8eRItnqWmyQhJkEeQJtq/TPvkhOjXePKltBRetihOjQePKutTRPtPhNjkePKTsbR9uKhNjoePKOsQSHuVhO
					jUePKptJRYtahPjOePKxtaRKtIhPjOePKxtaRKtIhPjOePKxtaRKtIhPjOePKxtaRKtIhPjOePKxtaRKtI]],
				Head = [[
					gAmJeRADgAgAhcgAmefLBKgAgAodgAmnfxCrgAgAswf/mlfnCNf7gDrogEmhfTBcgdfspagTmae/A7iReUnDgQmVewAkh9eelVgDmUesAZgYftk0f+mQeiAO
					fwgNjngQmOeUAIh3fPhlg1mHeMAvmTdoffhelfeJCnrpcOc+h2kYeFFRwCbvaPh/jheDHWydb4Yah/jYeDHqyxb7YKh9jyeEGtxxbzY9h8j2eEGhxkbyZHh/
					jdeDHeylb5YTh/jWeDHxy4b9YEh/jWeDHxy4b9YEh/jWeDHxy4b9YEh/jWeDHxy4b9YEh/jWeDHxy4b9YE]],
				Jaw = [[
					gAmEda/+gAgAgvgAmxeX/9gAgAetgAnIfF/4gAgAdaf/nCe5/6gGf+dwgFm3eh/8ffgMebgZmoeK/2ddhOfAgVmdd6/5d1hOfigEmbd2//fmgPfxf9mTdr//
					gRf1gIgSmJde/5eFgmhkg5l6dX+9ZehlkZhflKdW8aT4hsoIhwj9dW4yPbgnrjhxjDdX19NHfWtjhxi6dY1iM0fJt0hxjUdX21Nwfxs+hxjZdX3FN8f4s0hx
					i/dX1yM/fRtqhwi4dY1YMufEt6hwi4dY1YMufEt6hwi4dY1YMufEt6hwi4dY1YMufEt6hwi4dY1YMufEt6]],
				ClockMin = [[
					gAj9f4gAJZgA2ngAkFgPoMK7X01FgAkJgfuaOkRmxcgAkIgbyISjN0tigCkGgT0yWWLupUgHkDgL3NZ4LflJgGkBgF3sd3KshxgBkBgD2zhkJredf/kAf/2B
					kaJrbigAkCf610ldKwX6gAkIf411kaNJS6f/j9f411iMRNOCf+jdf41pf+V9Ktf9jBf41ae4ZrJIf9i8f41afkbJIwf9jJf41dhaa5I4f9jMf41aiObVIzf9
					i/f41Yhmc8Idf9i7f41WhkdmIXf9i7f41VhvdyIVf9i7f41Vh1d5IVf9i7f41Vh3d7IVf9i7f41Uh3d7IV]],
				ClockHour = [[
					gAj9f4gAJZgA2ngAkFgPhcJbek2lgAkJgfiXJgdp2ggAkIgbiHJid52lgCkGgThnJJeW2QgHkDgLhDICe01HgGkBgFgvIOfM1YgBkBgDgrJLfU2Yf/kAf/gc
					Jjfk2xgAkCf6eyJjei2sgAkIf4bfKMbW2ff/j9f4XpLuXI1hf+jdf4UaNvTYz5f9jBf4SlPSRJygf9i8f4SVPhQ1ySf9jJf4TGO0Ryy8f9jMf4TQOrR+zEf9
					i/f4SePZRAyaf9i7f4SQPnQuyNf9i7f4SQPnQuyNf9i7f4SQPnQuyNf9i7f4SQPnQuyNf9i7f4SQPnQuyN]],
				Gear2 = [[
					gAl3e5gAJZgA2ngAmFfgjZJpcn2XgAmNf6mJKPZ31xf/mLfznmKwYZ1XgDmHfmo0K2XV0kgPmCfYqNKSWxzCgNl/fOrRLDVvyxgCl+fLsCMlULzBf+l8fFsw
					NhTFywgOl8e8saNQRSxWgul5e5qZMUOHuZhSlWe5nbLWK/p/hqkVe5klK3JDlShyjhe5jAKxIVh0hzjZe5jZK3IQgohwjxe5lFLHIWhEhwj2e5l1LTIWgqhz
					jee5lQLOISe+hzjXe5lULRITeMhzjXe5lnLWIVd2hzjXe5l1LaIXdnhzjXe5l9LcIXddhzjXe5l/LdIYda]],
				["UpperArm.L"] = [[
					fNkIeg1QTsgA0ffNkae541T7dnv+fNkmfK6pUVcHsufNkifG6NUQcdtofRkde75RTwdlvHfgkWeu4HSpfjwNfdkSeo3SSvf4xefQkQeq3FTjfFyTfLkNeo2c
					T2fHzRfOkUei0dS0e/0vfTknehxLRMc62WfeksejtWQIZV3bfukWekp+QHVg3sf6j9eloEQiS63Zf8j5elnzQnSj3Vf3kFelonQYTs3hf2kHeloxQVT63jf7
					j7eln9QkSw3Yf9j3elnuQpSa3Tf9j3elnuQpSa3Tf9j3elnuQpSa3Tf9j3elnuQpSa3Tf9j3elnuQpSa3T]],
				["LowerArm.L"] = [[
					exjXeWuR8jgAiGexjxedua8AljfSexkFeluN7FpBdeexkAejuS7YoFd4e2j2eduW71mgfRfHjseSuT8FlPhtfDjleSuW8RjxiGe1jjeXuZ8ai0hCevjfeYuZ
					8ghnhCetjmeZvq71f/h2eokBehyt52eVhverkVes2T2uc/gme5kOe25NzScJe7fHj+e86yw2b6dofJj8e96/web5dbfCkEe66Vxlb8eBfBkFe66Nxzb9eIfH
					j9e863wsb5difJj7e97DwWb5dXfJj7e97DwWb5dXfJj7e97DwWb5dXfJj7e97DwWb5dXfJj7e97DwWb5dX]],
				["UpperArm.R"] = [[
					gzkIeg1QsUgA0fgzkae541sFiZv+gzkmfK6prrj5sugykjfF6Nr2jctlg3kce+5QrwjCvchFkVe74Cq7jSxxhCkRez3PrLieyxg2kQes3EsDhYyjgxkNem2d
					saglzGgykIeh14q5eU0kgwj+ee1vndZd1Rgmjled1BjPTd0WgZi6eczdfwOQyKgQiaebyFd3LRwKgPiWebx4dnK3v2gTikebyheZMHwzgUinebypejMXw+gP
					iYebyAdwLGwCgOiUebxzdiKuvvgOiUebxzdiKuvvgOiUebxzdiKuvvgOiUebxzdiKuvvgOiUebxzdiKuvv]],
				["LowerArm.R"] = [[
					hPjXeWuRDdgAiGhPjxeduaEAadfShPkFeluNE7W/dehOkAeiuREoX2eBhTj1ehuaEKZ4eghjjqemugDwcleGhfjkeiudDkdxfEhSjjeaubDkdfgehMjfeWuX
					DheMhchHjUeYsPCifniJgxjGecm9A8gSjDgQixejf/AQgbj4fziUeqZoBBgekqfjh/evVzCJgflLfhh8evVRCVgflQfniFetW6BwgflCfoiHetXPBqgfk/fi
					h+evVlCOgflOfgh7ewVGCagelSfgh7ewVGCagelSfgh7ewVGCagelSfgh7ewVGCagelSfgh7ewVGCagelS]],
				Gear1 = [[
					gAlmgYgAJZgA2ngAlpg8f3JZgJ2ngAlqhTfSJZgu2ngAlphNdoJkia2jgBlphBbsJgkH18gDlog0ZiI5lc0cgDlogsYFJlm+0OgBlogpXTK4og0ugAlngjWR
					Lwp30igMlqgbT5M7px0bgolpgYQfPjnt1RhHlJgYNOTakd2LhckMgYLBXlhT2lhjjbgYKCaoff2nhkjTgYJ0blfw2nhhjqgYJ8bDha2lhhjugYJ4bTiG2hhj
					jYgYJncyhZ2lhkjRgYJidchZ2lhkjRgYJgdthp2khkjRgYJfd4h12jhkjRgYJeeAh82ihkjRgYJeeCh+2i]],
				Gear3 = [[
					gAlOhqgAJZgA2ngAlHiLkDJwb92QgAlBifnXKnYp1ZgAlCiapVLdWp0pf+lFiPrDL7VLzgf5lIiDs+L0UWxpf6lKh8uWNCS/w+f/lLh6vPO/RDwqgBlMh0wF
					QVPsv5gJlShtwLQOOCtxgflThqu2O8Lnpyg2k4hqsmNOJ1kdhGkChqqTL3JZfPhLjWhqpFLSJ0bmhMjPhqptLkKIaPhKjjhqrfMhKFabhKjnhqsWNDKPZ3hM
					jThqr+M0KyYKhMjNhqsKM8LHXWhMjNhqshNKLSW8hMjNhqsxNVLaWrhMjNhqs7NcLfWghMjNhqs+NeLgWc]],
				Tail1 = [[
					gAkEhXehgAgA/9gAkAhvgjgAgA//gAj8h9h2gAgA/8gAj9h5hggJgB/9f/j/hyg1fQf6/+f7kBhpgGcffq/yf8kChkfndCfx/2f/kChifffcf9/+gBkDhffI
					gZgB/+gAkIhZewf8eG/6gBkPhXeqfqZg/SgCkEhXenfUTy9hgDjihXeafAO267gDjGhXeNe2L/43gDjBhXeLe1Lm4igDjPhXeRe5Mz5ggDjRhXeSe6ND5sgD
					jEhXeMe1L04ugDjAhXeKe0Ld4bgDjAhXeKe0Ld4bgDjAhXeKe0Ld4bgDjAhXeKe0Ld4bgDjAhXeKe0Ld4b]],
				Tail2 = [[
					gAkOi5e4gAgA/+gAj8jRg6gAgA/+gAjxjfiOgAgA/6gBj0jbh4gMgC/7f6j6jUhMe8f5/8fmkAjJgda/fl/lfqkEjEf+bxft/tf8kFjFf2fMf9/+gDkIjBfg
					gjgB/+gBkQi7fMfweF/7gBkYi5fJe8Zf/SgCkNi5e8d6Tz9egDjui5eZdBO661gEjTi5d3ciMH4tgFjPi5dyceLu4YgEjbi5eCcqM65XgEjdi5eFctNJ5jgF
					jRi5d1cgL84kgFjNi5dwccLm4RgFjNi5dwccLm4RgFjNi5dwccLm4RgFjNi5dwccLm4RgFjNi5dwccLm4R]],
				Tail3 = [[
					gAkUkbfogAgA//gAj3kzhqgAgA/8gAjklAi9gAgA/2gCjpk9ingQgC/4f0jyk2h8enf5/5fHj+knhLZffm/SfQkFkjgtagfw/gf3kGkngme9f9/+gGkLkjgQ
					gugB/+f/kVkef/fieG/7f7kekbf+eIZh/Rf4kYkafncXT59Yf5kAkZera2PI6pf8jqkYd0aAMc4ff9jnkYdrZ6MF4Kf7jxkYeGaPNN5Kf7jzkYeKaUNc5Wf8
					jpkYdwZ+MS4Wf9jmkYdnZ3L94Cf9jmkYdnZ3L94Cf9jmkYdnZ3L94Cf9jmkYdnZ3L94Cf9jmkYdnZ3L94C]],
				Tail4 = [[
					gAkXl+gAgAgA//gAjsmViCgAgA/7gAjRmhjVgAgA/0gEjZmei/gUgC/2frjnmXiUeTf4/3egj3mAhiYAfn+7evkBmAhEZQfx/QfwkDmJg+etf9/8gLkKmFgo
					g4gA/+f8kVmAgbfWeG/7fwkhl9gedaZk/Oflkjl6f9a+UB9PfjkYl2eqY4Pb6YfokLlydfXwM44JfpkJlydSXmMi3zfmkPl0d3YENm41flkQl0d+YKNz5Cfp
					kKlydZXsMv4AfqkIlydOXjMb3rfqkIlydOXjMb3rfqkIlydOXjMb3rfqkIlydOXjMb3rfqkIlydOXjMb3r]],
				Hourglass = [[
					gAkXnggAgAgA//gAjgn2iCgAgA/7gAi9oBjVgAgA/0gGjGn+i/gjgD/2fhjZn4iTc9fy/wdwjvnWhbSFfU8weGj7nZhBULfm9sfoj9nrg+dtf8/5gQkGnngo
					hlgB/8f4kTnif9fbeF/7fgkhnee4dvZc/NfIkvnYdGcKTm9FfDk1nOa9bTOl57fLk1nGZdbFLw3XfNk1nFZPbFLY2+fIk1nJZ6bHMk4LfHk1nKaCbIMz4ZfM
					k1nGZXbFLm3NfOk1nFZKbFLQ21fOk1nFZKbFLQ21fOk1nFZKbFLQ21fOk1nFZKbFLQ21fOk1nFZKbFLQ21]],
				["UpperLeg.L"] = [[
					e5ivgY7le2gAwKe5izgl9Re3f3s2e5i2gt+Ke4fyqne5i1gr98e6fvrOe6i0gl9eepgOsWe9izgZ84d1hotfe8ixgY8gd/hZuUe6ixgd8cesgOule5iwgd8J
					e9fxvLewi9gZ71dNfBveeejdgY7eZJc8ujeUj5gY6ST7atsmeXj+gY4OPRZLqfegj5gY2dMgYfpFeij3gY2LMIYao4edj7gY3BNUYqpgecj7gY3LNiYupoeh
					j4gY2VMWYdo/ejj3gY2FMAYYozejj3gY2FMAYYozejj3gY2FMAYYozejj3gY2FMAYYozejj3gY2FMAYYoz]],
				["LowerLeg.L"] = [[
					e3hyf2uIgjgA8se3h/f2xXgjgE63e3iKf3zUgigH5fe2iHf3y0gngE53e4iCf0xzgKgQ6le/h9ftwoeug77Se+h5fuv4fBgy7ve4h4f0vsgQgL74e2h2f3vJ
					gvf68LemiCf0uSfueS8keFipfwthdxaJ8TdsjVfssfbcU565dpjrforLZjQT4sdxjxflqNYgNl24dzjxflqEYXNO2mdujwfmqgYzOX3ddtjvfmqlY5Om3ndy
					jxflqJYcNb2xd0jxflqAYUNF2gd0jxflqAYUNF2gd0jxflqAYUNF2gd0jxflqAYUNF2gd0jxflqAYUNF2g]],
				["Foot.L"] = [[
					e5gwgp8kgAgAuZe5g0gY+DgAgAq+e5g6gN+ygAgAote5g4gQ+mgCf8pUe6g1gU+OfzgYqfe8gzgT9sfFhzrue7gygY9YfOhhske5gxgf9Uf3gSsye5gwgk9E
					gGfztXehhAgm8yeTfJt1duhtgl8ZaIdRtPdBimgi7JU0bKrvcyjPgg5EQGZnqEc3jhge3TNSY2o6c4jjge3BM6Ywovc0jcgf32OGZEpQc0jbgf4AOVZIpWc3
					jige3LNIY0o1c5jkge27MxYuorc5jkge27MxYuorc5jkge27MxYuorc5jkge27MxYuorc5jkge27MxYuor]],
				["Toe.L"] = [[
					e5gOgP/8gAgAh0e5gYf3/7gAgAeGe5gkfp/sgAgAbte5ggft/ygAf7cWe7gbfy/5f+gbdkfAgWf0/6f4iBe6e+gTf7/8f5htf0e6gSgC//f/gVgCe4gQgJ//
					gAfygredgfgM/6eGf5hNdhhPgK/UZhf1g0csiQgF9kT0gCf8cYjCgB6/O3gffPcbjbf/46L/g6e4ccjef+4mLmg+e1cZjUf/5kM0gxe/cYjSf/5vNEgvfAcc
					jcf+4yL1g7e3cdjff+4eLeg/e1cdjff+4eLeg/e1cdjff+4eLeg/e1cdjff+4eLeg/e1cdjff+4eLeg/e1]],
				["UpperLeg.R"] = [[
					hHivgY7lhKgAwKhHizgl9RhJgJs2hHi2gt+KhIgOqnhHi1gr98hLgIrNhIizgp9eg7ghsYhKixgr84gHh2tphJiwgn8ggShiuchHiwgg8cg/gWunhHiwgb8J
					hQf2vKg9isgZ8HfffGvOggikgY8YbTdQtuf4iVgY72VwbmrHfUh+gY6PQra3oke/hugY4rNnaxm+e8hsgY4bNMaymwfFhzgY5LOgaxncfGh0gY5UOwaxnke+
					htgY4kNbaym4e7hrgY4VNCaymre7hrgY4VNCaymre7hrgY4VNCaymre7hrgY4VNCaymre7hrgY4VNCaymr]],
				["LowerLeg.R"] = [[
					hJhyf2uIfdgA8shJh/f2xXfdf863hJiKf3zUfef55fhJiHf2y0fif453hLiBf4xzfFgH6khRh7f/wodpg17NhQh4f+v4d7gt7shLh4f3vsfLgH73hIh2f0vJ
					fqf48Lg4hxfzuJepeS8ngNhxfttAcwaI8cfYhxfmriaqU17Jevhqfgp5ZFQK5BechkfdowYSNZ3QeZhjfcolYMNA2+ehhmfepGYgOM30ejhmfepMYkOb3+eb
					hjfcorYPNO3IeZhjfcohYKM424eZhjfcohYKM424eZhjfcohYKM424eZhjfcohYKM424eZhjfcohYKM424]],
				["Foot.R"] = [[
					hHgwgp8kgAgAuZhHg0gY+DgAgAq+hHg6gN+ygAgAothHg4gQ+mgCf8pUhIg1gX+OfzgYqfhJgxgk9sfFhzruhIgxgn9YfOhhskhHgxgi9Uf3gSsyhHgwgi9E
					gGfztXgugwgl83eTfKtqfyg4gj8qaEdZspeshIgf7lUobnqqd6hUgb5lPwahoodkhaga32M2aInUdihbgZ3kMdaGnIdqhYga4ZNsaOntdrhYga4jN8aQn0dj
					haga3uMraHnPdhhbgZ3eMUaFnEdhhbgZ3eMUaFnEdhhbgZ3eMUaFnEdhhbgZ3eMUaFnEdhhbgZ3eMUaFnE]],
				["Toe.R"] = [[
					hHgOgP/8gAgAh0hHgYf3/7gAgAeGhHgkfp/sgAgAbthHghfs/ygAf7cWhIgaf2/5f+gbdkhMgUgG/6f4iBe6hLgSgK/8f5htf0hIgSgF//f/gVgChGgQgH//
					gAfygrgqgPgK/6eGf6hBflgbgG/UZhf+gLeXg0f/9jT0ggeydihJf566O6hddtdNhVf24yMGiQdNdLhXf24dLuiYdJdShRf35cM6iAdVdUhQf45oNJh8dYdM
					hWf24pL8iTdLdKhXf24VLlibdHdKhXf24VLlibdHdKhXf24VLlibdHdKhXf24VLlibdHdKhXf24VLlibdH]],
			},
		},
	},
}
