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
					gAidgkACgAgAg1gAidgkACgBgGg1gAiegkACgBgLg1gAiegkACgCgQg1gAifgkACgCgVg1gAifgkACgDgZg1gAifgkACgDgdg1gAiegkACgEggg1gAiegkAC
					gEgig1gAidgkACgEgjg1gAidgkACgEgjgzgAicgkACgEgjgfgAicgkABgEgigRgAibgkABgEgggRgAibgkABgEgdgRgAibgkABgDgZgRgAibgkABgDgVgRgA
					ibgkABgCgQgSgAicgkABgBgLgZgAicgkABgBgGgmgAidgkACgAgAgygAidgkACf/f6g1gAiegkACf/f1g1gAiegkACf+fwg1gAifgkACf+frg1gAidgkAEf+
					fnhxgAibgkALf/fjjLgAiagkAMf/fgjVgAiagkAMf/fejVgAiZgkAMf/fdjVgAiZgkAMf/fcjVgAiYgkAMf/fdjVgAiYgkAMf/fejVgAiXgkAMf/fgjVgAiX
					gkAMf/fjjVgAiXgkALf/fnjIgAiZgkAFf+friFgAibgkACf+fwhDgAicgkACf/f1g1gAicgkACf/f6g1]],
				Spine1 = [[
					gAiegKASgAgAkGgAifgKATgBgFkPgAifgKAUgCgLkWgAiggKAVgEgQkcf/iggKAVgFgUkgf/iggKAWgGgZkhf/iggKAWgHgckgf/iggKAVgHgfkcf/ifgKAU
					gIghkWf/ifgKATgIgikPf/iegKASgIgjkEf/idgKAOgIgijof/icgKAMgIghjTf/icgKAMgHgfjNf/ibgKALgGgcjKf/ibgKALgGgZjIf/ibgKALgFgUjKgA
					icgKALgEgQjOgAicgKANgCgLjbgAidgKAPgBgFjvgAiegKARgAgAkDgAifgKATf/f7kPgAifgKAUf+f1kWgAiggKAVf8fwkcgBiggKAVf7fskggBiggKAif7
					fnlvgBiggKA7f7fknkgBiggLA+f6fhnugBifgLA8f6ffnogBifgLA7f6fdnhgBiegLA5f6fdnZgBidgLA3f6fdnRgBidgLA1f7fenKgBicgLA0f7fhnEgBic
					gLAzf8fjnAgBicgKAvf8fnmtgBicgKAef8frlXgAidgKARf9fwkDgAidgKAQf+f1j3gAiegKARf/f7j+]],
				Spine2 = [[
					gAirfaA5gAgAnagAisfaA8gCgFnqf/itfaBAgEgKn4f/itfaBDgFgPoEf/iufaBFgHgUoLf+iufaBGgJgYoOf+iufaBFgKgboLf+itfaBDgLgeoEf+itfaBA
					gLggn4f+isfaA9gLghnqf9irfaA4gLginXf+iofZAwgLghm0f+imfZAqgLggmYf+imfZAogKgemMf+ilfZAmgJgbmFf+ilfZAmgIgYmCf/ilfZAmgGgUmFf/
					imfZAogFgPmNf/infZAsgDgKmfgAipfaAxgCgFm7gAirfaA4gAgAnWgAisfaA8f+f7nqgBitfaBAf8f2n4gBitfaBDf7fxoEgBiufaBFf5fsoLgCiyfcBif4
					foptgCi3feCUf3flr4gCi3ffCYf2fisCgCi2feCTf2fgr3gCi1feCOf1ferpgCi0feCIf2ferZgCizfeCCf2ferKgCizfeB9f3ffq8gCiyfeB5f3fhqxgCix
					feB2f4fkqqgCiwfdBuf5foqSgBitfbBOf6fsoqgBipfaA0f7fwnFgBipfaAyf9f1m7gAiqfaA1f+f7nK]],
				Neck1 = [[
					gAi2fDD2gAgAvLf/i4fED4gDgFvPf/i5fED7gGgJvUf/i6fED9gJgNvXf+i6fED+gMgRvZf+i7fEEGgOgVvof9i6fEEYgRgYwIf9i6fEErgTgawmf9i5fEEx
					gUgbwwf9i4fEEugVgcwsf9i2fDEqgVgdwlf9izfDEdgVgcwPf9iwfCEUgUgbwAf9ivfCESgTgZv8f9iufCEQgRgXv6f+iufCEQgPgUv5f+iufCEQgNgRv6f/
					ivfCERgKgNv7f/ixfCEDgGgJvjf/izfDD5gDgFvRgAi2fDEBgAgAvfgBi4fEEFf9f7vngBi5fEEIf6f3vrgBi6fEEKf3fzvvgCi6fEELf0fvvxgCjAfHFrfx
					fsyJgDjIfMHwfufp02gDjJfNH8ftfn1EgDjIfMH6fsfl1BgDjHfMH2frfk0+gDjFfLHzfrfj05gDjEfLHvfrfk01gDjDfKHsfsfl0xgDjCfKHpftfm0vgDjB
					fKHofvfp0tgCjAfJHVfxfs0XgCi6fGF2f0fvyagBi0fDELf3fzvxgBi0fDDxf6f3vBgBi1fDDzf9f7vG]],
				Neck2 = [[
					gAjaesGJgAgAy1f/jbesGNgEgEy5f/jdetGPgHgIy9f+jeetGSgLgMzBf+jfetGTgOgQzDf9jfeuGdgRgTzQf9jgevG0gUgVztf9jgewHKgWgX0Jf8jfexHR
					gYgY0Sf8jeewHOgZgZ0Of8jcewHJgfgh0If8jYeuG8hRhfzyf8jVetG0hyiGzhf9jUesGxhxiFzef9jTesGwhviDzcf9jTesGvhtiAzcf+jTesGvhqh9zdf+
					jUesGwhmh5zef/jVesGdhRhfzJf/jXerGPgrgyy6gAjaetGXgJgKzIgBjcetGcf8f8zPgBjdeuGgf5f4zTgCjeeuGif1f0zWgCjfeuGjfyfwzYgDjoe4Ipfu
					fu12gDjzfGLkfrfs4ngDjzfHL3fpfq42gDjyfGL0fnfp4zgDjxfGLwfmfo4wgEjwfFLsfmfn4tgDjufELofmfo4pgDjtfELkfnfp4mgDjsfDLhfpfq4kgDjs
					fDLffrfs4igDjqfBLEfufu4MgCjie3I9fxfx2LgCjZetGnf1f0zdgBjXerGDf5f4ysgBjYerGGf8f8yx]],
				Head = [[
					gAj9ehABgAgAgif/j+ehABgBgGgnf/kAeiACgBgLgsf+kBeiACgCgQgwf+kCejACgCgVgzf9kCekADgDgZhTf9kDemAHgFgdief8kEepAOgGgfjnf8kDepAS
					gHghkCf8kCepARgHgjj9f8kAeoARgeg7j1f7j8elAmjcj+jBf7j5ekBGlYl4iJf7j4ejBFlYl1iGf8j3ejBFlYlyiEf8j3ejBElXluiEf8j3ejBDlXlqiFf9
					j4ejBBlTlkiGf+j4ehApkVkUhbf/j6egAMiWiPg7gAj9eiADgigghUgBj/ejADf/f6hdgBkBekADf/f1higCkCekAEf+fwhmgCkCelAEf9frhpgDkNe1Ajf8
					fLlugDkXfMCBgKeWq/gDkXfOBrfugRqLgDkWfOBgflhDplgDkVfNB3f6fOqsgDkUfMCOgQd2regDkSfLB0f6fOqhgDkRfKBafnhDpRgDkQfKBifvgRpvgDkQ
					fJCCgMeQrCgCkOfGBvgHekqPgCkHe2Aif6gLlugCj8ekAEf/f4hmgBj6efABf/f1gXgBj7egABf/f6gc]],
				Jaw = [[
					gAkAdv/QgAgAm1f/kCdw/PgBf6m7f+kEdw/NgBf1nAf9kFdx/NgCfwnEf9kGdx/MgDfrnGf8kIdz/CgEfnnwf7kNd2+ngGfkpQf7kRd5+IgIfhquf7kRd697
					gJffrRf6kQd599gJferNf5kNd499gAe+rKfxkId39Texa5rufrkEd28dd7YUsRfskDd28cd5YXsUfskCd18bd4YasWftkBd18cd3YdsXftkCd18dd2YhsWfu
					kCd18id0YpsQfykAdy9ndnaZqdf4j/dw+seadLoaf+kDdx++fpfYn/gBkGdy++f/gGoAgCkHdz+9f+gLoFgDkJdz+8f9gQoJgDkJd0+7f8gVoLgFkgeI/Ofv
					gym4gIk4eo/XfAhWmGgCk2eo/EgYf7nngAk0em+7g6fVoGgFk1eo/QfqgumzgKk2ep/ZerhtlxgGkyem/QfrgumzgAkuei+7g5fUoGgCkuej/EgXf6nngIkx
					el/Ue7hZmQgHkueg/WfMhMmLgCkaeI/MgKf4nHgCkDdz/Hf/gIncgCj9du/Nf/gLnAgBj+du/Pf/gGm7]],
				Cloud = [[
					gAohd1IbgAgA1nf/old3IfgQgP1rf/ood5Iiggge1uf+oqd6Ilgwgs1xf9osd7Iog+g51yf9oueGI+hKhF2Jf9oweeJ0hThR2+f+ove2KqhZha3vf+ote/K/
					hehh4Bf+oqe8K7hihk39gEone5K3iEho33gzodegKzmUh53BhOoQeGKuo/h72ChOoOeFKpo5h12BhOoMeEKloxhs2AhOoMeEKhonhi2BhPoMeFKeobhX2DhP
					oOeGKaoLhL2GhAoTd9Jlmdgt13gjocd5I2jbgT1ygIokeEI9gugB2LgBooeIJDfwfx2SgBoqeKJHfgfi2VgCoteMJKfRfT2YgCoueNJNfDfG2ZgCo4frMSfQ
					eC5GgAoihmQ8gPce8Af+oqhZQKeIfu7uf+othNPydThE7bf/ohhgQlfAd077gAoWhsRggebe8Jf/odhZQbe/d071f+omhCPgdUhF7Qf/oghJPxeIfv7fgBoT
					hfRAgVcU8AgBoYhNQNgHc77pgBopfqMSezf75KgCogeLJKfNfi2YgCobdxIUfffi1fgBoedyIXfvfx1j]],
				["UpperArm.L"] = [[
					fIiqev5DOza3oifHisev5MO6adoHfHitew5SPAaJnzfGivew5VPEZ8nofGiwew5UPFZ3nofFiwex5QPEZ6n0fFiwex5KPAaEoJfEivex5AO7aVonfEiuex41
					O2aqpJfEisex4oOwbCpufEiqex4TOobnqifEimex3AOVdqtRfEijew19OQfFvAfEiiew12OPfQvKfFihew11OOfTvKfFihew16OMfQvAfGihew2GOLfFutfG
					iiev2XOKezuQfHikev3HONd4s9fHinev4IOacbq5fIiqev46OtbJo8fJisev5OO4amoBfJitev5XO8abnnfKiveu5cO+aXnXfKiveu5eO+aZnTfLi3ew5aPK
					XkkwfLjDez4yQUTUhNfMjDe04qQSTGhLfMjCez4oQATdhrfMjBez4lPtT1iNfMi/ez4hPbUMiufMi9ey4dPMUfjLfMi8ey4ZPBUtjifMi7ey4WO7U1jwfLi6
					ey4VO7U0jzfLi4ex4aOzVXkQfKivev4oOTYgm2fKineu4kOYbhpafJineu4sOjbwpjfJioev44OqbTpC]],
				["LowerArm.L"] = [[
					e5ijeYL6NTTaqie4imeYMHNnTDrBe3ioeZMMNzS5rSe3iqeZMJN1S8rUe2ireZL/NsTOrIe1ireaLuNbTrqte1iqeaLYNEUTqHe0ioebLCMpVCpae0imebKt
					MPV0ope0ikebKbL3Wkn5e0igecKILdXbnAe0iXeeJiKhZ7kbe0iSehJVKEbiiwe1iQehJVKEbgiwe1iPegJYKIbNi/e1iPegJcKPaqjde2iQefJkKaZ8kHe3
					iReeJvKqZFk4e3iVecKKLNXhmae4iceaK6MJVbofe5iieYLvNGTtqNe5imeYMMNjS8q7e6ioeXMWNqSsrHe7ipeXMYNoSqrDe8iqeXMSNcS1qxe6i5eZMvQC
					RBtJe5jMegOFUZPGwxe5jNehNxUVPWwqe5jLegNMTrP3wBe5jJefMpTGQWvYe5jGeeMLSoQxuze5jEeeL2STRFuYe5jCedLrSKROuIe5jAedLqSNRMuHe5i/
					edLzSbQ/uUe4i8ecL1SGRAuEe5iteZLPPMSorae7ifeYLEMmUqo6e6ieeYLVMdUkpFe5igeYLpM5T7p4]],
				["UpperArm.R"] = [[
					g4iqev5DxNlJoig3isev5OxIlaoBg3itev5XxEllnng2iveu5cxClpnXg2iveu5exClnnTg1iweu5cxFldnag1iveu5WxKlNnrg0iueu5OxRk4oFg0itet5C
					xZkfomg0iset41xgkGpIg0iqet4gxqjhp8g0imet3JyChgsqg0ijet2DyKgJuag0ihet17yJgBung1ihet15yIgCuqg1iget1/yHgLukg2ihet2KyEgcuWg2
					iheu2ayBg1t+g3ikeu3Kx6h3sxg3ineu4Kxpjdqzg4iqev46xTk3o8g5isev5MxGljoHg5itew5SxAl3nzg6ivew5Vw8mEnog6iwew5Uw7mJnog7i4ey5Mwv
					pElKg7jDe34cvntYhrg8jDe34Svntqhsg8jCe34Pv4tXiOg8jAe34MwKtBiyg8i/e24JwasqjVg8i9e24FwosWjyg8i8e24DwzsFkIg8i6e14Bw5r7kTg7i6
					e14Cw7r3kUg7i4e04KxErPksg6ivey4exkoAnNg6ioew4exhk5prg5inev4nxYkhpug5ioev42xTk2pI]],
				["LowerArm.R"] = [[
					hHijeYL6ytsmqihHimeYMMydtEq7hGioeXMWyWtUrHhFipeXMYyYtWrDhEiqeXMSyktLqxhEiqeWMEy4szqRhDipeWLxzRsQpnhDioeWLczsrlo1hDimeWLH
					0Hq3oAhDijeWK00eqKnOhCigeXKg02pUmUhDiXeZJ21um1jthDiRecJk2HlNiDhDiQecJk2GlMiFhEiPecJm2ClbiZhEiPedJp16l4i8hFiPecJw1umgjrhF
					iRecJ51enQkkhGiVebKR05oumNhHiceZK+z7qsoYhHiieYLvy6sTqNhIimeYMHyZs9rBhJioeZMMyNtHrShJiqeZMJyLtErUhKireZL/yUsyrIhMi5ecMXvo
					uhthhPjMekNorLwYxHhPjNelNTrMwDxDhQjLelMsr1vfwdhQjIekMJsbu9v2hQjGekLss6ugvThQjDejLYtQuMu4hQjBeiLOtauEunhPjAeiLPtauJukhPi/
					eiLatOuauuhOi8egLftmufubhMitecK9wls9rwhKifeaK4zQrCpMhJieeZLMzcrOpShIiheZLkzDr+p+]],
				Tail1 = [[
					gAihhAdSgAgA/4gAiihAdHgRgA/3gAiihAc9ghgA/1gAijhAc1gxgB/0gBijhAcwg/gB/zgBijhAcuhMgB/zgBijhAcwhXgB/zgBijhAc1hfgB/zgBiihAc9
					hmgB/zgBiihAdHhqgA/0gBihhAdPhrgA/1gBihhAdGhqf+/0gBihhAdDhmf9/0gBighAdLhff9/1gBighAdQhXf9/2gBighAdShMf9/2gBighAdQg/f+/2gA
					ighAdLgxf+/2gAighAdKghf//3gAihhAdOgRgA/3gAihhAdOgAgA/3gAiihAdHfvgA/3gAiihAc9ffgA/1gAijhAc1fPf//0f/ijhAcwfBf//zf/ighBdWer
					f7/2f/ibhBeUePfz/5f/iahBegexf3/7f/iZhBeoe8f4/8f/iZhBeyeRf0/6f/iYhBe9dyfx/5f/iYhBfIeRf1/7f/iXhBfSe8f6/9f/iXhBfaexf5/9f/iW
					hBffeNf2/7f/iXhBfXedf4/8f/ibhBepfMf+/8gAifhAd3fSgA/6gAighAdnffgA/5gAighAddfvgA/4]],
				Tail2 = [[
					gAiphvcufef//0gBiqhvcZf5gA/ygCirhvcEgUgB/vgDishvbxgugC/sgDishvbihIgE/qgEithvbZhggF/ngFishubWh1gG/mgFishubZiHgH/lgGirhvbj
					iXgH/lgGiqhvbyiigH/ngGiphvcCipgG/ogGiphvcDitgD/ogGiphucLisgB/pgFiphvceingA/sgFiohvctidf//ugEiohvc2iQf//wgDiohvc5iAf//xgD
					iphvc2hsf//ygCiphvczhVgA/zgBiphvcyg9gA/0gAiphvcqgigA/0f/iqhvcZgHgA/yf+irhvcEfsf//vf9ishvbxfSf+/sf9ishvbie4f8/qf7iohvbteV
					f2/qf6ighvcIdRfl/of7iehwcOeFfs/tf8iehwcYeufy/wf6idhvcndqfo/uf4ibhvc6cZfe/of6iahwdPc2fk/tf8iZhwdjeMfw/2f7iYhwd2eKfx/3f6iY
					hweFc8fo/yf7iZhweLc6fr/yf9ifhwd3eLf5/3f9ilhvdeeaf+/2f+inhvdQerf//2f/iohvdBfDf//1]],
				Tail3 = [[
					f+izidWvekfr+lgBi1idWVfEfz+egDi3idV6fnf7+WgFi4icVegJgE+NgHi5icVGgsgN+EgJi6icUzhNgW98gKi6ibUnhsge91gLi5ibUjiJgm9ygMi4ibUo
					iigs9ygNi2icU1i4gx91gOi1icVHjJg195gOi1icVNjWg096gNi1icVcjdgz9/gNizicV3jegy+IgMiyicWQjagw+RgLixicWjjRgt+YgJixidWvjCgp+dgI
					iyidWzivgk+ggGiyidW1iXgg+jgEiyidW1h7gb+lgCizidWrhcgV+kf/i1idWVg8gN+ef9i3idV6gZgF+Wf7i4icVef3f8+Nf5i5icVGfUfz+Ef3i0icUzev
					fj97fyiridUpdHe29vf2ipidUjdvfG9xf4ioidUme4ff93fzinidU0d4fE94fuilicVLb6eX9xfxiiidVkb1eb96f3igieV8dffE+Pf2ifieWWd4fN+afxie
					ieWycTeq+YfyieieXIbmeh+Yf4ilieXRdBfK+nf5isieXVdafZ+rf6ividXQdqfe+rf8ixidXDeFfk+p]],
				Tail4 = [[
					f7jLjBYnddfj/Bf+jOjBYPd/fq+9gCjRjAXxelfx+4gFjUi/XQfNf5+wgIjWi9Wvf2gC+ngLjXi9WSgfgL+egOjXi8V7hIgU+VgQjXi8Vthugc+PgSjVi8Vo
					iSgk+LgUjTi8Vuizgr+KgVjRi9V7jPgw+LgWjRi9WAjmgy+KgWjQi9WSj4gy+OgVjNi+WykDgz+WgUjLi/XTkIgy+fgTjKjAXwkGgw+ogRjJjAYHj+gt+vgO
					jKjBYWjwgq+1gMjKjBYhjcgm+6gIjKjBYojCgi++gFjLjBYkijgd/AgCjOjBYPiBgW+9f+jRjAXxhbgP+4f7jUi/XQgzgH+wf4jWi9WvgKf++nf0jRi9V/fp
					fw+YfsjIi9VNdhe/9/fxjHi9U7dnfH95f2jFi+U0fJfj99fvjDi+U7ehfN99fljBi9VNcAeZ9zfoi+i+VmbHeR9zfxi7jBV/cxe6+Mfxi4jCWedtfL+cfoi2
					jBXBcCeo+afni2jBXmajeU+Vfwi8jDYQb1e9+vfyjDjCY0cZfS+9f0jGjCY9clfX/Af4jIjCY3c+fd/C]],
				Tail5 = [[
					f2jZjesFcvhg9af7jdjdr3dMhU9jf/jhjbrgdthH9vgEjkjarDeSg399gIjnjYqie6gm+LgMjpjXqBfkgV+YgQjqjWpigOgD+igTjqjVpJg4fx+pgWjpjVo5
					hhfg+sgZjnjVoziHfP+rgbjkjWo1iqfA+ngcjkjWoxjIew+lgdjjjWo8jhei+egcjfjYpaj1eY+SgcjcjZp7kDeQ+GgajajbqckKeL95gYjZjcq6kLeI9ugV
					jZjcrSkFeJ9mgSjZjdrpj6eN9fgOjZjer7joeV9agKjajesBjReg9bgFjdjdr3i0es9jgBjhjbrgiTe59vf8jkjarDhufJ99f4jnjYqihGfa+LfzjkjXpbgr
					fc+jfojdjVoCeYgC+7ftjcjVnhd3ga/Bf1jbjWnSfbf5/JfsjYjWnOfPfs/JffjVjVnQcmgb+9ffjSjWnabAhL+sfrjOjan2cVg/+yftjKjcoYdrgh+yfijI
					jbo4cPg2+ffejHjbpbaPhq9+fpjLjeqnbNhv9vfsjRjfrrb+ht9dfujUjfsDcFhv9UfyjWjesJcXhp9V]],
				Tail6 = [[
					fwi+j5TNcEea9Af1jCj5THcYel9Bf7jGj4S3cyey89gAjLj4SgdRfB82gGjPj3SDd0fR8sgLjSj2Rjebfj8fgQjUj2RFfFf18RgVjVj2QpfvgH8EgZjUj2QU
					gbgZ74gdjSj2QHhFgr7vggjPj3QBhug87pgijPj2P2iUhJ7fgkjNj3P6i3hV7dgkjJj3QQjVhg7mgkjFj4Qtjuhp7zgijBj4RLkBhv8Aggi/j5RqkNhy8Ogd
					i/j5SGkUhy8bgZi+j5SikShw8pgVi9j5S7kKhs82gQi+j5TKj8hl8/gLjCj5THjohb9BgFjGj4S3jOhO89gAjLj4Sgivg/82f6jPj3SDiMgv8sf0jOj4QwiD
					gg8CfkjKj3PFgVfU7IfojKj4OhfDe+6wfzjJj6OLgMfq6jfqjHj6OBgwfj6cfXjEj3OAeyeN6WfUjAj3OJcndW6Lfji7j8ORc8d96Xfoi3j9OheUes6tfZiy
					j7O/dneC66fSiwj5Pwbcc/7Affiyj7RFbWdj7zfki2j6SZb0eI8lfni4j6S8bveM81fri6j6TJb2eS88]],
				["UpperLeg.L"] = [[
					e/hegS9Vd9fXske/hfgS9TeCfTsqe/hfgS9ReGfPsue+hggT9QeKfLsye+hggT9QeNfHsye+hggT9ReQfDswe+hggT9TeSe/sse+hggU9WeTe7ske+hfgU9a
					eUe4sbe+hfgU9eeTe1sQe+hegU9keSeysBe+hdgV9yePerrce+hcgW98eNenrCe+hcgW9+eLeoq8e+hcgW9/eIeqq5e+hbgV9+eGeuq7e+hcgV99eEeyrAe+
					hcgV95eBe4rJe/hcgU9xeAfBrfe/hdgT9kd+fMsAe/hegS9Xd9fWsge/hegR9Pd7fes0e/hfgR9Id5fltCe/hfgR9Dd2frtOe/hggQ8+d0fxtXe/hggM8ed1
					f/ube/hfgH7md6gRwDfAhfgG7ed5gVwPfAhfgG7gd3gWwMfAhegG7jd1gXwGfAhegG7nd0gWv/fAhdgG7sdzgVv3fAhcgG7xdzgTvvfAhcgG71d0gQvne/hc
					gG75d1gNvge/hbgH8Fd2gGvKe/hcgL8wdzf2t2e/hcgQ9Tdyfmsoe/hdgR9Zd1ffsce/hdgR9Xd5fbsg]],
				["LowerLeg.L"] = [[
					e7hDf3rciIgW9ze7hDf4rtiOgV9se7hEf5r8iVgT9le7hEf5sJibgS9fe7hEf5sTihgR9be7hFf5saimgR9Ye6hFf6scirgR9We6hFf6saivgS9We6hEf5sV
					iygT9Ye6hEf5sNi1gU9be6hEf5sGi3gW9ee6hEf5sMi7ga9be6hEf5sOi9gc9ae6hEf5sEi7gd9ee6hEf5r8i3ge9ie6hDf5r2iyge9le6hDf4rzisge9ne6
					hDf4rximgd9oe7hDf4rridgb9re7hDf4rjiSgY9ve7hDf4reiJgW9ye8hDf4rhiAgV9xe8hDf4rkh4gU9we8hDf4rnhxgT9we9hDf4rnhrgT9we9hBf2qqhf
					gS+Ie+g/f0pehSgQ+he+g+f0pQhOgR+me+g+fzpFhMgR+pe+g9fzo4hLgS+te+g9fzorhLgT+xe+g8fzoehMgU+0e+g8fyoThOgU+3e+g8fyoLhQgV+5e9g8
					fyoHhUgV+6e9g8fyoRhagV+3e9g+f0pPhmgX+le8hBf2qfhzgY+Ke8hCf3q8h7gY+Ae8hCf3rLiBgX95]],
				["Foot.L"] = [[
					fBgogV8NgYfzvGfBgogV8NgefwvGfBgogV8MgjftvGfBgogV8MgofrvGfBgogV8MgtfovGfBgogV8MgxfmvGfBgogV8Mg1fjvFfBgogV8Mg5fhvFfBgogV8M
					g8fgvFfBgogV8Mg/fevFfBgogV8MhBfdvFfBgogV8LhFfbvFfBgogV8LhHfavFfBgogV8LhFfbvFfBgogV8MhCfcvFfBgogV8Mg+ffvFfBgogV8Mg5fhvFfB
					gogV8MgzflvGfBgogV8MgrfpvGfBgogV8MgifuvGfBgogV8NgZfzvGfBgogV8NgRf3vGfBgogV8NgKf6vGfBgogV8NgEf+vGfBgogV8Nf/gBvGfBgogV8Nf1
					gGvGfBgogV8NfqgMvGfBgogV8NfngOvGfBgogV8NflgOvGfBgogV8NflgPvGfBgogV8NflgPvGfBgogV8NfmgOvGfBgogV8NfogNvGfBgogV8NfqgMvGfBgo
					gV8NfugKvGfBgogV8NfygHvGfBgogV8Nf8gCvGfBgogV8NgHf8vGfBgogV8NgOf5vGfBgogV8NgTf2vG]],
				["Toe.L"] = [[
					fBgYgL/9gQfqhgfBgYgL/8gUflhgfBgYgL/8gXfghgfBgYgL/8gbfchgfBgYgL/8gefXhgfBgYgL/8ghfThgfBgYgL/8gkfPhgfBgYgL/8gmfMhgfBgYgL/8
					gpfJhgfBgYgL/8gqfHhgfBgYgL/7gsfFhgfBgYgL/7gufBhgfBgYgL/7gwe/hgfBgYgL/7gvfBhgfBgYgL/7gtfDhgfBgYgL/8gqfHhgfBgYgL/8gmfMhgfB
					gYgL/8gifRhgfBgYgL/8gdfZhgfBgYgL/8gXfhhgfBgYgL/9gRfphgfBgYgL/9gMfwhgfBgYgL/9gHf2hgfBgYgL/9gDf8hgfBgYgL/9f/gBhgfBgYgL/9f5
					gKhgfBgYgL/9fxgUhgfBgYgL/9fvgXhgfBgYgL/9fugZhgfBgYgL/9fugZhgfBgYgL/9fugZhgfBgYgL/9fugYhgfBgYgL/9fwgWhgfBgYgL/9fxgUhgfBgY
					gL/9f0gRhgfBgYgL/9f3gMhgfBgYgL/9f+gDhgfBgYgL/9gFf5hgfBgYgL/9gJfzhgfBgYgL/9gNfvhg]],
				["UpperLeg.R"] = [[
					hBhegS9ViDgpskhBhegR9PiFgis0hBhfgR9IiHgbtChBhfgR9DiKgVtOhBhggQ8+iMgPtXhBhggQ88iOgLtdhBhggQ87iRgItfhAhfgQ87iTgFtdhAhfgP8+
					iVgEtYhAhegP9BiXgEtQhAhegQ9HiYgGtDhAhdgR9YiagMsbhAhcgS9kicgSr9hAhbgS9oibgVr0hBhbgS9riagZrthBhbgS9tiYgdrohBhbgT9uiVghrlhB
					hcgT9uiSglrmhBhcgT9piOgorzhBhdgS9giIgpsKhBhegS9XiDgqsghBhfgS9Th+gtsqhBhfgS9Rh6gxsuhChggT9Qh2g1syhChggT9Qhzg5syhChggQ84ht
					gztohChfgK8NhmgmvAhChfgK8KhkgovEhChegK8Phjgru8hChegK8UhkgtuyhChdgK8YhkgvuphChdgK8chmgwuihChcgK8fhngwuchChcgK8hhpguuZhChb
					gK8hhrgsuYhChbgK8nhugruMhChcgO9Hh1g0tGhChcgS9hh7g8sIhBhdgS9ih+g4sHhBhdgS9ciAgxsV]],
				["LowerLeg.R"] = [[
					hFhDf3rcd4fq9zhEhDf4rheAfr9xhEhDf4rkeIfs9whEhDf4rnePft9whDhDf4rneVft9whDhDf4rkebft9yhDhDf3rfefft90hDhDf3rWejfs93hDhCf3rM
					elfr97hDhCf3rBemfr+AhDhCf2q3emfq+DhDhCf2q6eifo+ChDhCf2q8effm+BhDhCf2q3ebfl+ChDhCf2q2eXfl+DhEhCf2q5eSfl+BhEhCf3rAeMfk9/hE
					hCf3rKeGfl96hEhCf3rReBfm93hEhDf3rWd8fo91hFhDf4red3fq9yhFhDf4rtdyfr9shFhEf5r8drft9lhFhEf5sJdlfu9fhFhEf5sTdffv9bhFhDf4rZdj
					fx9yhFhAf1qIdtf0+QhFhAf1p8drf0+UhFg/f1p1dof0+WhFg/f1pqdmfy+ZhFg/f0pfdkfx+dhFg+f0pSdkfw+hhFg+f0pGdlfu+khFg9f0o8dnft+ohFg9
					fzo0dqft+qhFg9fzo6dsfs+ohFg/f1p5dnfp+VhFhCf3rDdjfn96hFhCf3rUdofo90hFhDf3rYdwfp90]],
				["Foot.R"] = [[
					g/gogV8NfogNvGg/gogV8NfvgJvGg/gogV8Nf2gGvGg/gogV8Nf8gCvGg/gogV8NgBf/vGg/gogV8NgGf9vGg/gogV8NgKf7vGg/gogV8NgNf5vGg/gogV8N
					gPf4vGg/gogV8NgQf4vGg/gogV8NgPf4vGg/gogV8NgMf6vGg/gogV8NgIf8vGg/gogV8NgFf9vGg/gogV8NgBf/vGg/gogV8Nf9gCvGg/gogV8Nf4gEvGg/
					gogV8NfzgHvGg/gogV8NfvgJvGg/gogV8NfrgLvGg/gogV8NfngNvGg/gogV8NfigQvGg/gogV8MfdgTvGg/gogV8MfYgVvGg/gogV8MfTgYvGg/gogV8MfW
					gWvGg/gogV8MfegSvGg/gogV8MfcgTvGg/gogV8MfZgVvGg/gogV8MfXgWvGg/gogV8MfWgXvGg/gogV8MfVgXvGg/gogV8MfVgXvGg/gogV8MfXgWvGg/go
					gV8MfZgVvGg/gogV8MfbgUvGg/gogV8MfXgWvGg/gogV8MfUgXvGg/gogV8MfZgVvGg/gogV8NfggRvG]],
				["Toe.R"] = [[
					g/gYgL/9fwgWhgg/gYgL/9f0gQhgg/gYgL/9f5gKhgg/gYgL/9f9gEhgg/gYgL/9gBf/hgg/gYgL/9gEf6hgg/gYgL/9gHf3hgg/gYgL/9gJf0hgg/gYgL/9
					gKfzhgg/gYgL/9gKfyhgg/gYgL/9gKfyhgg/gYgL/9gIf1hgg/gYgL/9gGf4hgg/gYgL/9gEf7hgg/gYgL/9gBf/hgg/gYgL/9f+gDhgg/gYgL/9f7gHhgg/
					gYgL/9f3gMhgg/gYgL/9f0gQhgg/gYgL/9fygThgg/gYgL/9fvgXhgg/gYgL/8fsgbhgg/gYgL/8fpgghgg/gYgL/8flgkhgg/gYgL/8figphgg/gYgL/8fk
					gmhgg/gYgL/8fpgfhgg/gYgL/8foghhgg/gYgL/8fmgjhgg/gYgL/8fkglhgg/gYgL/8fjgnhgg/gYgL/8fjgnhgg/gYgL/8fjgnhgg/gYgL/8fkgmhgg/gY
					gL/8fmgjhgg/gYgL/8fngihgg/gYgL/8fkglhgg/gYgL/8fjgohgg/gYgL/8fmgjhgg/gYgL/8frgdhg]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAiZgkAFeOgNg8gAiagkAFecgug6gAidgkAEe7hIg6gAiggkAEfmhVg7gAihgkAEgVhTg9gAifgkAEhBhEg+gAicgkAFhhgog+gAiZgkAFhxgFg9gAiZgkAF
					htfig7gAicgkAFhWfEg6gAifgkAEgxewg6gAihgkAEgDeqg8gAiggkAEfUezg+gAidgkAEetfJg+gAiagkAFeUfpg+]],
				Spine1 = [[
					gAiagKATeQgXjzf/ibgKATecgij7f+ifgKAVe6gokPf+iigKAWfkgmkif+ijgKAXgTgdkof+ihgKAWg+gPkbf/idgKAUhef/kGgAiagKAThvfwj1gBiagKAT
					hsfjj1gCidgKAUhXfakEgCiggKAWgyfYkagCijgKAXgFfekngCiigKAWfXfqkjgBifgKAVewf5kRgAicgKATeXgIj8]],
				Spine2 = [[
					f+imfaAxeTghmsf9infaA1eZgXm+f8isfaA9eygJnmf8iwfaBFfZf4oLf9ixfaBHgFfnoTf+iufaBBgxfcn6gAiqfaA4hUfYnPgBimfaAyhpfbmwgDimfaAy
					htfkmwgEipfaA5hcfwnRgEiufaBCg8f/n7gEixfaBHgRgRoTgDiwfaBFfkgfoKgBisfaA9e8gnnlf/iofaA1efgnm9]],
				Neck1 = [[
					f9iwfDD7egg+vOf7iyfDD3ejgxvHf7i3fEESe4gev6f8i8fEE9fYgExDf9i9fFFbf9fnxzf/i6fEFWgifOxqgBi1fDEyhDe/wvgDixfDEJhae+vngEiwfDD1
					hhfHvCgFi0fDEBhUfXvagFi6fEEng5fuwfgEi9fFFPgVgKxhgCi8fEFefwgnx2gAi4fEFHfNg7xRf+iyfDEcewhDwJ]],
				Neck2 = [[
					f4jUerGeeqhMzLf4jWerGjesg/zTf5jceuG/e9gpz5f7jjeyHgfZgK0jf+jle0Hwf6fo02gCjiezHjgcfK0mgFjbewHDg7e4z9gHjVesGlhQeyzVgIjUerGd
					hXe5zLgIjZesGvhNfLzkgHjgewHQg2fm0QgEjlezHrgXgI0xgAjke0Htf1go0yf9jeeyHUfUhB0Tf6jXeuGye5hNzn]],
				Head = [[
					f0j2ehALePgSihf0j5ehAMeWfli1f2kAemAOexe8jLf6kHesAPfZedjUf/kJevAOgHeQjKgEkGetAMgzeXi0gIj+eoALhXewiggLj4ejAKhtfYicgMj3ehAL
					hwgFiqgLj8ejANhfgxjBgIkEepAOg8hVjSgEkJeuAPgQhsjRf/kIevANfihvjAf6kCerALe6hfipf2j7elAKecg9ic]],
				Jaw = [[
					fzkAdx/khygIk4f1kDdx/fhfg1lYf5kLd2/gg7hXlUf+kTd8/mgNhpkvgEkVd//sfghskAgJkQd9/ue5hdjogNkId4/tebg9j1gNkBdy/neNgQkggMkBdw/h
					eVfglMgJkHdz/fexe4lbgFkQd5/ifceelEf/kVd+/pgKeUkWf5kTd//ug1eajvf1kMd7/uhYexjqfzkEd1/qhufZkJ]],
				Cloud = [[
					fTodeaJ5eJiF29fWokegKGd/hP3MfgoteqKUecf93dfxoyezKdfIet3lgDowe0KXfpd93egVooesKGf4d53NgjofehJ0f+eZ2/groceaJwgMfD29gsofecJ7
					gtfi3IgmooelKNhZfz3XgYowevKZh9gC3ggGoye0KYiCgc3efzosexKKhZhE3TfjojenJ7gPhx3FfYodedJ1e/iO27]],
				["UpperArm.L"] = [[
					fGidevzCPhklzMfFigevzWPTkMyyfEinev0FO2jDxyfFiveu05OThjwdfGizeu1cNwgKvLfHiyeu1qNSfJuQfJiueu1oM9ehtzfKiqeu1jMzeMtrfLiqev1i
					M2eFtvfMitev1nNGeOuAfMiyew1pNieuukfLizex1cOEftvjfKivex05OnhJw0fIioew0GPHivyEfHigewzWPckCy8]],
				["LowerArm.L"] = [[
					e5iEep0R3QbonRe4iIen0s3WcsmSe3iRek1c3TelkWe2ibeh2N26g2iEe2ihef2y2Ri5gFe3iied3M1lkUeze4ifec3f1Ek8ePe5ibec3t01k4eOe6ibed3z
					05kTeke7ifee3r1PjUfPe7iieg3V1zh7gTe7ihei2u2bgLh3e7ibek1726eRjze6iRem1D3Jcnlue6iIeo0a3NbonC]],
				["UpperArm.R"] = [[
					g1ipeu1hzNh5tsg0irev1kzEh5t2g0iwew1pythmuPg1izew1lyNg3vAg2iyex1OxqfowKg3isex0hxIeExeg4ikewzswtcjykg5ieewzHwfbmzJg6ieevzH
					wkbgzEg7ijevzrw6cUyWg8isev0gxbdsxIg7iyeu1Nx/fMvyg6izeu1myggauqg4iweu1qy5hOt+g3ireu1lzKhrtt]],
				["LowerArm.R"] = [[
					hGibedIP01kqhqhFidedIQ1Cj3hJhFigefIe1giqgThFiiehI92IhFe/hFifejJq2tfOdMhFiWelKh3EdYbNhGiMenLU3McBZhhGiFepLv3ObgYthHiFeoLm
					3TcCZGhJiMemK93WdjanhKiWejKK3JftczhKifegJf2nh7fAhJiieeJA16jtgqhIigecIq1SkuhkhHidecIZ06k/h1]],
				Tail1 = [[
					gAichAczgyhz/xgBiehAcMgZhp/ugCihhAcAf9hM/ugCikhAcWfigi/xgCilhAdAfMfz/1gCijhAdie9fH/3gCifhAdle5ek/2gBidhAdIfEeQ/zgAidhAce
					faeP/vf/ifhAcCf1ej/tf+ijhAcIgRfH/vf+ilhAcqgqf1/zf+ikhAdUg9gk/3f+ihhAdohHhM/3f/iehAdahDho/0]],
				Tail2 = [[
					gCimhvbriQh2/kgBiphuadhChr/cgBithuZ0frhM/XgBivhuaMebge/agAiuhvbVdbfs/if/iqhvcec0fA/nf/imhvc4cvef/of+ilhvcQdSeM/mf+inhubC
					eVeM/gf/irhuaBfpei/Zf/iuhuZ4g+fK/XgAivhuatiHf8/egAishvb9i8gr/lgBiohvczjThS/ogCilhvcrjEhs/o]],
				Tail3 = [[
					gHizicVWjzir9zgEi5ibTqiEiI9Xf/i/iaSegDhM89f8jAiaSkeGgA89f5i7ibT4cdez9Xf2i1icVjbXd39zf2iwicWfbBdV+Af3ixicWCbldO98f6i2ibUg
					dAdj9mf/i8iaS8e8eT9IgCjAiaSWg+fZ85gGi+ibTGiygo9IgJi4icUvkLhu9mgKiyicWLk7id98gKiwicWck0iy+B]],
				Tail4 = [[
					gPjPi9W7mGi097gGjZi5U4kHiR9of+jgi2TFhchV9Mf3jhi2SrepgE9Dfxjai5T6cGew9VfsjQi9WBaIds9ufrjKi+XmZHdI98fujLi+XkZUdE9/f1jUi7V+
					aydb9zf+jdi3T3dLeK9agFjii2Sqf+fS9EgMjei4THisgn9JgSjVi7U8k/h29igVjMi+W+mhiq93gUjJi+X0m9i+9/]],
				Tail5 = [[
					gZjhjVptodd39NgNjujQn8mkeY+PgAj4jMl3jlfQ/Pf1j5jLk3gBgI/nfrjxjPlrccg2/RfjjkjUnuZahc+TffjbjXpmXhh99QfjjcjXqGXJiN88ftjnjTo9
					YVh89rf6j0jOm2a1hN+ygGj6jLlJeKgT/hgQj2jNlDhzfg/igajqjSmolMe3+1ggjejWoxnueT9uggjajXqDo4d489]],
				Tail6 = [[
					gqjKjwRxo7lO6ugbjbjwQGnvkK6UgIjqjvNslKij5mf1jujxMKhxgh5BfjjjjzMbeMeO5LfUjRj0OWa6cI55fOjEjyQuYYay6ifRjEjwR7XHai6xfdjSjwRI
					XebP6kfujjjvO4Zacl5+gCjujwMvcfeb5QgVjqjyMDgCgo5Agljaj0NPjhi55ggwjJjzPlmfkr6RgyjCjxRkocle6t]],
				["UpperLeg.L"] = [[
					fGhTgS2Rdkgx20fFhVgU35dmgL1IfChagW6rdsfYxge/hggX+Gd2d/qce8hjgX/keVcBi6e6hkgW/sfBbwgie4hjgU/yfHdDh7e4higS/de3evlie5hhgP+3
					effloRe7higO+WeAf9p5e9hjgM9cdogbsSfAhjgM8WdVgyujfDhfgM7QdHg8wefFhagO5/dDg/yZfGhVgQ4VdLg70j]],
				["LowerLeg.L"] = [[
					fDgtgSiLfIfa/5fBgwgPeFf2fV/7e+g4gGdDhFfl/1e5hJf5hTjCgi/0ezhdfzpulSiE98ewhjfxv8mAjM65exhffvzdlbjH4ne1hVfu1akaiV3Pe3hPfv0e
					jfh64Qe5hMfvxZijhn6re8hJfyuqhjhE8Ye/hEf2r9glge9qfBg9f7o8fyf8+tfDg2gBlvfOfj/dfEgwgJjJe/fZ/0]],
				["Foot.L"] = [[
					fBgog78HdqhQvDfBg0g37oeYg8wAfBg/gu7TfogPwqfBhGgh7EhWfKw/fBhHgR63jKeAw9fBhDgD65j8dkwsfBg6f37Pjnd2wQfBgufx7yiwedvifBgof18J
					h1fBvEfBgof/8Mg6fhvFfBgogJ8Nf8gCvGfBgogT8MfDghvFfBgogd8KeTg6vEfBgogn8HdxhNvDfBgogx8GdihVvC]],
				["Toe.L"] = [[
					fBgYgx/2ebiJhffBglgu/1e8hjikfBgvgm/0fwgYjTfBg1gZ/vg2erjsfBg2gK/jiAc2jwfBgyf7/digcGjgfBgqfu/kiVcgi9fBgffn/xh1dbiEfBgYfr/4
					hPeVhffBgYf1/8gnfLhgfBgYf//9f+gDhgfBgYgJ/8fXg4hgfBgYgT/5e3hjhffBgYgd/2egiDhffBgYgn/1eWiRhf]],
				["UpperLeg.R"] = [[
					hIhhgR+8hPgdoChGhigO+qhxgRo7hEhjgN98iMfzrEhBhjgM86iifYtdg+hhgM7zizfIvig8hcgN6qi8fBxag6hXgO5Ni7fCzcg6hTgR3WiqfK1sg7hTgT2+
					icfh2Ig8hXgV5IiXgNzqg/hdgW8ciPhOubhChigX/Kh/jEmNhFhkgW/phSkZhFhHhkgV/wg4jtg5hIhigT/thAiHjg]],
				["LowerLeg.R"] = [[
					hJhPfw2IcJeJ2thIhOfuy5c+eM5khFhLfwv/d9eq7mhChGfztVe9fQ9DhAhBf4qgf2f0+Ng+g6f9nVgigS/Ig9gygFkTg9gk/rg9gugOiZg/gn/4g+gugRf1
					glgq/+hAgzgMdEfngn/2hEg/gAeYeCgC/4hKhUf0ldbyev/NhPhifytQaIdO8YhQhifwx9aNcu5nhNhafu0kbDdO31]],
				["Foot.R"] = [[
					g/gofw8HdxhNvDg/gof68LeogvvFg/gogE8NflgOvGg/gogO8MghfuvGg/gogY8LhWfSvFg/gogi8IiAe8vDg/gogs8GiaeuvCg/gog28GidesvCg/gug672
					iDe3vkg/g6g07dhEfYwYg/hDgo7LfkgSw3g/hHgZ69dthdxAg/hGgK61cRiWw2g/g/f87CcJiXwgg/g0fz7fcxh4v7]],
				["Toe.R"] = [[
					g/gYfm/2egiDhfg/gYfw/6fFhQhgg/gYf6/9fugZhgg/gYgE/8gWfihgg/gYgO/6g6exhgg/gYgY/4hWeLhfg/gYgi/1hnd0hfg/gYgs/1hqdxhfg/gfgw/1
					hXeGiEg/gqgr/1gse+i+g/gygg/yfugcjig/g2gR/pejiTjxg/g1gC/edpjujqg/gvf0/gdijzjRg/glfq/qd5jFij]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAiegk//gAgAghgAiRgk/9f0e1ghgAiUgk/8fveWghgAihgk/9f0e1ghgAiegk//gAgAghgAiRgk/9gMhLghgAiUgk/8gRhqghgAihgk/9gMhLgh]],
				Spine1 = [[
					gAidgKAKgAgAjEf+iQgKAIgShKiTf9iTgKAKgahoief+iggKANgUhJjPgAidgKAKgAgAjEgCiQgKAIfue2iTgDiTgKAKfmeYiegCiggKANfse3jP]],
				Spine2 = [[
					gAinfZAugAgAmrf7iXfZAdgZhIlKf4iafZAigkhllgf7iqfZA0gdhGnBgAinfZAugAgAmrgFiXfZAdfne4lKgIiafZAifceblggFiqfZA0fje6nB]],
				Neck1 = [[
					gAixfCFMgAgAxcf5iffBDqgug8uxf2ijfCEAhDhUvYf5i1fDFmg1g2yAgAixfCFMgAgAxcgHiffBDqfSfEuxgKijfCEAe9esvYgHi1fDFmfLfKyA]],
				Neck2 = [[
					gAjYexIigAgA1vf4jCepGkg3g0zXf0jHerHBhQhHz5f5jdezJCg9gt2OgAjYexIigAgA1vgIjCepGkfJfMzXgMjHerHBewe5z5gHjdezJCfDfT2O]],
				Head = [[
					gAj9euAYgAgAkzf3jlefAMgUgjjRf0jreiAPgegxjmf5kBeyAcgagilIgAj9euAYgAgAkzgJjlefAMfsfdjRgMjreiAPfifPjmgHkBeyAcfmfelI]],
				Jaw = [[
					gAkNd//4gAgAinf2jxdv/jf2fZlQfyj4dz/wfufJjzf4kTeD/9ftfahKgAkNd//4gAgAingKjxdv/jgKgnlQgOj4dz/wgSg3jzgIkTeD/9gTgmhK]],
				Cloud = [[
					gAoifRLjeuhF4if8oXemKXgmgN3jf8oSevKoiGfK3sgAocfZLygqgI4xgAoifRLjeuhF4igEoXemKXfafz3jgEoSevKqgZen3ygAocfZLyfWf44x]],
				["UpperArm.L"] = [[
					fIikeuwYOxlD0zfAiRezuAQNmX3Le8iWe1unQVlo3EfAipezw9PSj31BfIikeuwYOxlD0zfRiPerttOvnp14fUiUepuPOTnh1PfRioerw1OBlWzs]],
				["LowerArm.L"] = [[
					e5iMer2p2hhKhWewh5e22a2fdtjHeth+e42k2ed8iMewiSew232Wg5f8e5iMer2p2hhKhWfCh4es2P2ffZkxfFh8ep2Q2igUkifCiQel2d2likhk]],
				["UpperArm.R"] = [[
					g4ikeuwYxPa90zgviPerttxRYX14gsiUepuPxtYf1Pgvioerw1x/aqzsg4ikeuwYxPa90zhAiRezuAvzZp3LhEiWe1unvraY3EhAipezw9wucJ1B]],
				["LowerArm.R"] = [[
					hHiMer2pJfe2hWg+h4es2PJhgnkxg7h8ep2QJefskig+iQel2dJbdchkhHiMer2pJfe2hWhQh5e22aJhiTjHhTh+e42kJiiEiMhQiSew23JqfHf8]],
				Tail1 = [[
					gAikhAdIgmf9/2gCiXhAb+gtf+/ugDiahAcJgaf//wgCinhAdUf4gB/4gAikhAdIfagD/2f+iXhAb+fTgC/uf9iahAcJfmgB/wf+inhAdUgIf//4]],
				Tail2 = [[
					gCithudvhrf6/3gEijhubhg2f+/qgEilhubLfhgA/ngCivhudYefgB/2f+ithudveVgG/3f8ijhubhfKgC/qf8ilhubLgfgA/nf+ivhudYhhf//2]],
				Tail3 = [[
					gHi0idYri+gf+/gHiwibV/higQ+VgDizibUqfMf195f9i3idXTdWfb+qf5i0idYrdCfh+/f5iwibV/eefw+Vf9izibUqg0gL95gDi3idXTiqgl+q]],
				Tail4 = [[
					gOjHjDbQkVgl/VgKjKi+YrisgS/BgBjQi7WKfcf6+bf3jOjCYtckfX+8fyjHjDbQbrfb/Vf2jKi+YrdUfu/Bf/jQi7WKgkgG+bgJjOjCYtjcgp+8]],
				Tail5 = [[
					gXjRjhutk4dj74gQjYjatOjjeB82gAjjjWqIgOf4+Wfwjcjerscnhh9ifpjRjhutbIid74fwjYjatOcdh/82gAjjjWqIfygI+WgQjcjersjZef9i]],
				Tail6 = [[
					geiwj2WWlviI94gVi6jzVvlJhk90gAjMj1SOhage81fqjBj6S0c6ex89fiiwj2WWaRd494fri6jzVva3ec90gAjMj1SOemfi81gWjBj6S0jGhP89]],
				["UpperLeg.L"] = [[
					e/hegX0Gejg041e9hRgc37gMgJ1Pe9hVge7ifnVbToe9higc/2fqdGf1e/hegX+EfKgtq4fBhQgS/vc6fHiYfChSgQ5edOhkzFfBhggSqqfLia+D]],
				["LowerLeg.L"] = [[
					e9g5gfb5hagF/se+gsgXOVjijF6QeohugM23reklyqe2hif37Klrhiv2fAhFf697iqfdq+e+hKftvlg5go77fBgugGidgDgZ/5fBhIgwqnf/gH+L]],
				["Foot.L"] = [[
					fBhDhG7bgBf/wefBhRgm6vkWdRwzfBhQgA5Np+ZwvzfBhBfi7GkodQwIfBgrfb8qhQffuJfBgogC8MfUgYvGfBgogu8LeqguvFfBgvhP5femhFzQ]],
				["Toe.L"] = [[
					fBgzg9AdgAgBlPfBhBgeAed/kuhefBhAf4CdZsp7clfBgwfZAndBkedGfBgdfQADfGhAfjfBgYf4AEgefYegfBgYgkAFgzethTfBgdhKAogKePl+]],
				["UpperLeg.R"] = [[
					hBhegX+Eg2fTq4g/hQgS/vjGg5iYg+hSgQ5eiyeczFg/hggSqqg1dm+DhBhegX0GhdfM41hDhRgc37f0f31PhDhVge7igZqlTohDhigc/2gWi6f1]],
				["LowerLeg.R"] = [[
					hAhFf697dWgjq+hChKftvlfHfY77g/gugGidf9fn/5g/hIgwqngBf5+LhDg5gfb5emf7/shCgsgXOVcec76QhYhugM23UibbyqhKhif37KaVeev2]],
				["Foot.R"] = [[
					g/grfb8qewghuJg/gogC8MgsfovGg/gogu8LhWfSvFg/gvhP5fhae7zQg/hDhG7bf/gBweg/hRgm6vbqivwzg/hQgA5NWCmQvzg/hBfi7GbYiwwI]],
				["Toe.R"] = [[
					g/gdfQ/9fGhAgdg/gYf4/8gefYhgg/gYgk/7gzetetg/gdhK/YgKePaCg/gzg9/jgAgBaxg/hBge/id/kueig/hAf49jZsp7jbg/gwfZ/ZdBkei6]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAilgkAGgAgAiOgAihgnAIgAgAimgAiWgvANgAgAjhgAiLg4AVgAgAkegAiFg9AagAgAk/gAijgLABgAgAgdgAixfsAGgAgAdxgAixfsAGgAgAdxgAixfsAG
					gAgAdxgAiwfvAFgAgAeEgAitf+ACgAgAfPgAipgRACgAgAgwgAimggAFgAgAh7gAilgkAGgAgAiOgAilgkAGgAgAiOgAilgkAGgAgAiO]],
				Spine1 = [[
					gAipgKAfgAgAlfgAilgOAigAgAltgAicgWAogAgAmPgAiSggAwgAgAm0gAiMglA0gAgAnHgAikfxAQgAgAj6gAitfSAFgAgAh4gAitfSAFgAgAh4gAitfSAF
					gAgAh4gAitfWAGgAgAiIgAisfkAKgAgAjEgAiqf4AUgAgAkTgAipgGAdgAgAlPgAipgKAfgAgAlfgAipgKAfgAgAlfgAipgKAfgAgAlf]],
				Spine2 = [[
					gAi5fbBPgAgAowgAi2ffBQgAgAo1gAivfoBUgAgApAgAimfyBXgAgApMgAiif4BZgAgApSgAiwfBA4gAgAnZgAizehAmgAgAmCgAizehAmgAgAmCgAizehAm
					gAgAmCgAizekAogAgAmOgAi1ezAygAgAm8gAi3fIBAgAgAn3gAi5fXBMgAgAolgAi5fbBPgAgAowgAi5fbBPgAgAowgAi5fbBPgAgAow]],
				Neck1 = [[
					gAjHfGEigAgAwYgAjEfKE7gAgAxBgAi8fTF8gAgAyjgAi0fdHHgAgA0GgAiwfjHxgAgA04gAi7erDbgAgAuXgAi8eJBugAgAqUgAi8eJBugAgAqUgAi8eJBu
					gAgAqUgAi9eNB4gAgAqvgAjAedCggAgAsYgAjDexDegAgAudgAjGfCETgAgAv/gAjHfGEigAgAwYgAjHfGEigAgAwYgAjHfGEigAgAwY]],
				Neck2 = [[
					gAjseyG/gAgAz8gAjqe3HqgAgA0wgAjlfFJagAgA2ogAjefULagAgA4egAjafcMhgAgA5YgAjeeRFbgAgAxygAjWdnCsgAgAsygAjWdnCsgAgAsygAjWdnCs
					gAgAsygAjYdsC6gAgAtTgAjed/D5gAgAvRgAjmeYFYgAgAxugAjresGpgAgAzggAjseyG/gAgAz8gAjseyG/gAgAz8gAjseyG/gAgAz8]],
				Head = [[
					gAkQepAFgAgAh7gAkOexANgAgAjagAkJfFAzgAgAnCgAkCfbB5gAgAqygAj+fmCogAgAsrgAkAeDACgAgAhBgAjxdPAYgAgAbQgAjxdPAYgAgAbQgAjxdPAY
					gAgAbQgAj0dUAUgAgAbsgAj9drAIgAgAdcgAkIeKABgAgAfugAkOejADgAgAhfgAkQepAFgAgAh7gAkQepAFgAgAh7gAkQepAFgAgAh7]],
				Jaw = [[
					gAkYd5/8gAgAhlgAkbeB/+gAgAg4gAkgeZ/+gAgAfBgAkje2/1gAgAcxgAkjfF/tgAgAbzgAkFdS7xgAgAv4gAjkcf80gAgAt5gAjkcf+cgAgApzgAjkcf+G
					gAgAq1gAjock+1gAgAohgAj3c6/agAgAmDgAkJdY/xgAgAjygAkVdy/7gAgAiCgAkYd5/8gAgAhlgAkYd5/8gAgAhlgAkYd5/8gAgAhl]],
				Cloud = [[
					gAo3eXJafDg92mgAo+e7KefsgS3pgAosgTNVg4fX58gAoBhnQog9ff8BgAnniQSbfogL89gAomdgIxfFg+19gAn/bCFLfygWxbgAn8bEFMgmfGxagAnzbIFM
					gmfGxagAn3bWFbfxgWxzgAoUcHGefMhFzNgAoxdOH4fvgU1AgAo6eIJFgwfO2SgAozeXJZgxfP2ngAoweXJZftgT2ngAo3eXJafDg92m]],
				["UpperArm.L"] = [[
					fIi8ex1kOCgAvXfIi6e011NlexuVfIiye+2RM1blr2fIirfI2VMpYCpQfIinfN2PM0WJn9fIiveW26NdcXr4fIiud23VOMdvshfIiud23VOMdvshfIiud23V
					OMdvshfIivd63OOKd5stfIizeJ2yOHeftefIi4ed2LODfQucfIi8es1sOCf2vLfIi8ex1kOCgAvXfIi8ex1kOCgAvXfIi8ex1kOCgAvX]],
				["LowerArm.L"] = [[
					e5iqeh2j2jgAife4ipej3M19hvgre2ioeq4Hz0l2cKe0ioe04EwnpyXfezine63pulrmVLe3ikeC3o1eh9f/e5ihdj2Q2eeCkde5ihdj2Q2eeCkde5ihdj2Q
					2eeCkde5ihdn2R2eeLkUe5ikd22X2hesj0e5ineM2e2ifXjJe5iped2i2jf4ioe5iqeh2j2jgAife5iqeh2j2jgAife5iqeh2j2jgAif]],
				["UpperArm.R"] = [[
					g4i8ex1kx+gAvXg4i6e011ybhPuVg4iye+2RzLkbr2g4irfI2VzXn+pQg4infN2PzMp3n9g4iveW26yjjpr4g4iud23Vx0iRshg4iud23Vx0iRshg4iud23V
					x0iRshg4ivd63Ox2iHstg4izeJ2yx5hhteg4i4ed2Lx9gwucg4i8es1sx+gKvLg4i8ex1kx+gAvXg4i8ex1kx+gAvXg4i8ex1kx+gAvX]],
				["LowerArm.R"] = [[
					hHiqeh2jJdgAifhIipej3MKDeRgrhKioeq4HMMaKcKhMioe04EPZWOXfhNine63pRbUaVLhJikeC3oKieDf/hHihdj2QJih+kdhHihdj2QJih+kdhHihdj2Q
					Jih+kdhHihdn2RJih1kUhHikd22XJfhUj0hHineM2eJegpjJhHiped2iJdgIiohHiqeh2jJdgAifhHiqeh2jJdgAifhHiqeh2jJdgAif]],
				Tail1 = [[
					gAinhBergAgA/9gAihhEeygAgA/+gAiVhNfEgAgA/+gAiIhVfWgAgA//gAiBhafggAgA//gAiogob9gAgA/vgAi6gHaPfegD/dgAi6gHbEfjgC/mgAi6gHbE
					gdf+/mgAi5gLbahEf8/pgAi0gacsg6f//zgAitgueFgKgA/7gAiog9e5fyf//+gAinhBezf7gA/+gAinhBergAgA/9gAinhBergAgA/9]],
				Tail2 = [[
					gAiqhwdygAgA/6gAilhzdogAgA/5gAiYh8dRgAgA/3gAiKiEc4gAgA/1gAiDiJcrgAgA/0gAi0hVaJgAgA/cf+jLgzZXe8gF/Rf/jJg0bAfGgD/lgBjJg0bA
					g6f9/lgDjGg4bbiIf8/lgDi9hIc0h0gB/ygAizhdeEgUgB/7f/irhsehfjf+/9gAiqhweCf1f//7gAiqhwdygAgA/6gAiqhwdygAgA/6]],
				Tail3 = [[
					gAixieXPgAgA+xgAisiiW2gAgA+pgAigiqV4gAgA+WgAiTizU3gAgA9/gAiMi3UWgAgA9ygAjFiCS5gAgA9Lf7jeheTDebfy9Nf8jXhhVYeqfy+JgEjXhhVY
					hWgO+JgJjUhlV4jIgj+LgIjHh2XUiqgl+qgBi4iMYXgegI/Df+ivibYdfWf0/Ff/iwifXmfwf7+3gAixieXPgAgA+xgAixieXPgAgA+x]],
				Tail4 = [[
					gAjIjEYmgAgA/HgAjEjHX8gAgA+9gAi6jNWWgAgA+ggAiwjUUsgAgA97gAiqjXT2gAgA9lgAjmifTUgAgA9Xf4j+h8UXd5fz9uf5jziDXieNfy+ygHjziDXi
					hzgO+ygRjuiHYHkMgj+tgPjeibZsjlgo/JgDjNizalgogJ/hf8jEjCaWfIfy/ef/jGjEZFfrf7/OgAjIjEYmgAgA/HgAjIjEYmgAgA/H]],
				Tail5 = [[
					gAjXjhr2gAgA9ugAjUjjq+gAgA+DgAjNjooygAgA+wgAjFjsmbgAgA/VgAjBjulLgAgA/kgAj9i1llgAgA/gf0kUiTnkdthU++f1kDierkeAhE9vgLkDierk
					iAe89vgZj9iisAkrdk9LgVjqi4tpkFeF8lgEjYjRufgvfs8gf7jPjgt9e9ga8xf+jUjiscfngK9egAjXjhr2gAgA9ugAjXjhr2gAgA9u]],
				Tail6 = [[
					gAi8j9SygAgA9IgAi6kBRtgAgA8ngAi4kJPJgAgA7MgAi1kQMlgAgA5agAi0kULUgAgA4ZgAjwjaMagAgA5SfvkCi2O8c9fH64fyjoi7TWdbfL9QgOjoi7TW
					ilg19Qghjhi9UMl+iA9DgcjMjQV3lDh792gFi4joWUg4gY+ef5iwj4Vbexfc+Kf9i3j9Tffjfy9bgAi8j9SygAgA9IgAi8j9SygAgA9I]],
				["UpperLeg.L"] = [[
					e/hogM7QeWgAwqe/hkgO8JeOfzvGe/hbgT91d+fUrVe/hRgZ/Gd1exnDe/hMgb/jdzebkie/hkf74befgZ0me/hvfmvMfshX8He/hvfmvMfshX8He/hvfmvM
					fshX8He/hvfovffshX79e/hsfyzRfQhE5ge/hqf/4dengc0ke/hogK6xeZgFxbe/hogM7QeWgAwqe/hogM7QeWgAwqe/hogM7QeWgAwq]],
				["LowerLeg.L"] = [[
					e9hGf7tPhxgA9Ee8hFf5sZh2gJ9be8hCf3rFiBgg98e7hBf2q0iNg6+Ae6hCf3rOiThJ92e9g/f0pehkf0+hfAhQf7vFg5fK8LfAhQf7vFg5fK8LfAhQf7vF
					g5fK8LfAhPf9vYg6fK8Be/hIf9uJhLfX8qe9hFf5sThjfv9fe9hGf6s6hvf99Oe9hGf7tPhxgA9Ee9hGf7tPhxgA9Ee9hGf7tPhxgA9E]],
				["Foot.L"] = [[
					fBgogV8NgAgAvGfBgogV8NgGf9vGfBgogV8NgUf1vGfBgogV8MgifuvGfBgogV8MgqfqvGfBgogV8Nf2gFvGfBgugR5ffWgqzUfBgugR5ffWgqzUfBgugR5f
					fWgqzUfBgsgS6KfTgnyYfBgogV8MfZgVvGfBgogV8NfygIvGfBgogV8Nf+gBvGfBgogV8NgAgAvGfBgogV8NgAgAvGfBgogV8NgAgAvG]],
				["Toe.L"] = [[
					fBgYgL/9gAgAhgfBgYgL/+gEf6g+fBgYgL//gNftfsfBgYgL/8gUffeVfBgYgL/5gXfXdnfBgYgL/ff7gLaYfBgcgM/0f+g8cxfBgcgM/0f+g8cxfBgcgM/0
					f+g8cxfBgbgM/wf5g7cRfBgYgL/lftgpa+fBgYgL/8f4gOeSfBgYgL/+f+gCg2fBgYgL/9gAgAhgfBgYgL/9gAgAhgfBgYgL/9gAgAhg]],
				["UpperLeg.R"] = [[
					hBhogM7QhqgAwqhBhkgO8JhygNvGhBhbgT91iCgsrVhBhRgZ/GiLhPnDhBhMgb/jiNhlkihBhkf74bhhfn0mhBhvfmvMgUep8HhBhvfmvMgUep8HhBhvfmvM
					gUep8HhBhvfovfgUep79hBhsfyzRgwe85ghBhqf/4dhZfk0khBhogK6xhnf7xbhBhogM7QhqgAwqhBhogM7QhqgAwqhBhogM7QhqgAwq]],
				["LowerLeg.R"] = [[
					hDhGf7tPePgA9EhEhFf5sZeKf39bhEhCf3rFd/fg98hFhBf2q0dzfG+AhGhCf3rOdte392hDg/f0peecgM+hhAhQf7vFfHg28LhAhQf7vFfHg28LhAhQf7vF
					fHg28LhAhPf9vYfGg28BhBhIf9uJe1gp8qhDhFf5sTedgR9fhDhGf6s6eRgD9OhDhGf7tPePgA9EhDhGf7tPePgA9EhDhGf7tPePgA9E]],
				["Foot.R"] = [[
					g/gogV8NgAgAvGg/gogV8Nf6gDvGg/gogV8NfsgLvGg/gogV8MfegSvGg/gogV8MfWgWvGg/gogV8NgKf7vGg/gugR5fgqfWzUg/gugR5fgqfWzUg/gugR5f
					gqfWzUg/gsgS6KgtfZyYg/gogV8MgnfrvGg/gogV8NgOf4vGg/gogV8NgCf/vGg/gogV8NgAgAvGg/gogV8NgAgAvGg/gogV8NgAgAvG]],
				["Toe.R"] = [[
					g/gYgL/9gAgAhgg/gYgL/+f8gGg+g/gYgL//fzgTfsg/gYgL/8fsgheVg/gYgL/5fpgpdng/gYgL/fgFf1aYg/gcgM/0gCfEcxg/gcgM/0gCfEcxg/gcgM/0
					gCfEcxg/gbgM/wgHfFcRg/gYgL/lgTfXa+g/gYgL/8gIfyeSg/gYgL/+gCf+g2g/gYgL/9gAgAhgg/gYgL/9gAgAhgg/gYgL/9gAgAhg]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAilgkAGgAgAiOgAiigkAEgAgAh0gAibgkACgAgAg4gAiWgkABgAgAgHgAiXgkABgAgAgQgAijgkAIgAgAiogAiqgkAXgAgAkqgAirgkAagAgAlAgAirgkAa
					gAgAlAgAirgkAagAgAlAgAirgkAagAgAlAgAirgkAagAgAlAgAirgkAagAgAlAgAirgkAagAgAlAgAirgkAagAgAlAgAirgkAagAgAlAgAirgkAagAgAlAgA
					irgkAagAgAk8gAipgkARgAgAj+gAimgkAIgAgAiqgAilgkAGgAgAiOgAilgkAGgAgAiOgAilgkAGgAgAiO]],
				Spine1 = [[
					gAipgKAfgAgAlfgAilgKAZgAgAk7gAicgKAOgAgAjpgAiWgKAIgAgAimgAiXgKAJgAgAiygAingKAmgAgAmDgAiygLBQgAgAo1gAizgLBZgAgApSgAizgLBZ
					gAgApSgAizgLBZgAgApSgAizgLBZgAgApSgAizgLBZgAgApSgAizgLBZgAgApSgAizgLBZgAgApSgAizgLBZgAgApSgAizgLBZgAgApSgAizgLBZgAgApSgA
					izgLBYgAgApNgAivgLBAgAgAn5gAiqgKAmgAgAmFgAipgKAfgAgAlfgAipgKAfgAgAlfgAipgKAfgAgAlf]],
				Spine2 = [[
					gAi5fbBPgAgAowgAi0fbBDgAgAoDgAiofZArgAgAmdgAiefZAcgAgAlJgAigfZAegAgAlYgAi6fcBdgAgApegAjMfhCvgAgAs5gAjPfiC/gAgAtdgAjPfiC/
					gAgAtdgAjPfiC/gAgAtdgAjPfiC/gAgAtdgAjPfiC/gAgAtdgAjPfiC/gAgAtdgAjPfiC/gAgAtdgAjPfiC/gAgAtdgAjPfiC/gAgAtdgAjPfiC/gAgAtdgA
					jOfiC8gAgAtXgAjHffCQgAgArwgAi9fcBegAgAphgAi5fbBPgAgAowgAi5fbBPgAgAowgAi5fbBPgAgAow]],
				Neck1 = [[
					gAjHfGEigAgAwYgAjAfFDxgAgAvBgAiyfCCSgAgAr1gAimfBBWgAgApJgAiofBBggAgApogAjIfHE8gAgAxEgAjffQI/gAgA2NgAjifSJtgAgA28gAjifSJt
					gAgA28gAjifSJtgAgA28gAjifSJtgAgA28gAjifSJtgAgA28gAjifSJtgAgA28gAjifSJtgAgA28gAjifSJtgAgA28gAjifSJtgAgA28gAjifSJtgAgA28gA
					jhfRJlgAgA20gAjYfNHmgAgA0rgAjLfHFOgAgAxggAjHfGEigAgAwYgAjHfGEigAgAwYgAjHfGEigAgAwY]],
				Neck2 = [[
					gAjseyG/gAgAz8gAjketFwgAgAyRgAjPejDXgAgAuPgAi9edB4gAgAqvgAjAeeCHgAgArYgAjve1HqgAgA0wgAkKfOOLgAgA6jgAkNfTPUgAgA7TgAkNfTPU
					gAgA7TgAkNfTPUgAgA7TgAkNfTPUgAgA7TgAkNfTPUgAgA7TgAkNfTPUgAgA7TgAkNfTPUgAgA7TgAkNfTPUgAgA7TgAkNfTPUgAgA7TgAkNfTPUgAgA7TgA
					kMfSPIgAgA7LgAkCfGL9gAgA47gAjye2IIgAgA1SgAjseyG/gAgAz8gAjseyG/gAgAz8gAjseyG/gAgAz8]],
				Head = [[
					gAkQepAFgAgAh7gAkGegACgAgAe6gAjseNA/gAgAYMgAjUeBCygAgAS/gAjZeDCagAgAT5gAkTevAPgAfpjqgAkrfcERgXfJv7gAktfjEffPhxwMgAktfjFM
					gQfgxbgAktfjFggresx2gAktfjEhfShowRgAktfjFBgAgAxKgAktfjFng0ebx/gAktfjEmfahWwbgAktfjE2fxggw5gAktfjFrg5eSyDgAktfjEtfkg+wpgA
					ktfiEjflg9wYgAkmfNClgWe1sfgAkXeyAVgAgGkagAkQepAFgAgAh7gAkQepAFgAgAh7gAkQepAFgAgAh7]],
				Jaw = [[
					gAkYd5/8gAgAhlgAkFdv/ngAgAk5gAjXdh9ngAgAsHgAixde6ygAgAxfgAi3de7WgAgAwlgBkgd//lf6gWlHgDlXfF/+fRgkflf6lZfN/6hme7hBgClbfR//
					figSfmgFlcfT/8evgwfEf7lZfN/7hefAg7gAlbfQ//gAgAf6gFlcfT/7eeg5e5f7lafO/8hPfMgwf+lafP//geftgOgGlcfT/6eVg+e0f9lafO/+g5fbghf9
					lZfM/+g3fbgigElLet/9fPg9f1gAkmeD/9gBf7hYgAkYd5/8gAgAhlgAkYd5/8gAgAhlgAkYd5/8gAgAhl]],
				Cloud = [[
					gAo3eXJbelhb2lgAoudVHYfKhB0YgAndbNDngIfwuvgAlzZ/BjgheZpogAmBaTB3gpeMqjgAove8KqgZfL30gBnmi0Vye6fZ+Sf+nnjFWSexib+WgBnYjdXe
					eOf7+ygCnSjoYAfXep+7f+nujQWLhzhS+XgAnZjUXNh8fd+sgCnFjXYQg2d9+9f+nfjBWagLhg+ef/najLW7eihB+ogCnKjjYLdrem+5f/npjXWpfhhQ+jf/
					ntjSWShHgv+cgBoah8SXhOeF82gAo3fNLQhWe+4SgAoreXJZgNfz2ngAoueXJafEg82mgAo3eXJbelhb2l]],
				["UpperArm.L"] = [[
					fIi8ex1kOCgAvXfIi1ew1kOCgAvXfIikev1kOCgAvXfIiXeu1kOCgAvXfIiZeu1kOCgAvWfIi/ex13MdbIr1fIjbe40xMzSpmufIjfe60SNZQwlufIjfe60S
					NZQwlufIjfe60SNZQwlufIjfe60SNZQwlufIjfe60SNZQwlufIjfe60SNZQwlufIjfe60SNZQwlufIjfe60SNZQwlufIjfe60SNZQwlufIjfe60SNZQwlufI
					jee60XNSREl5fIjSe21fMMWio7fIjCey1zNJdztsfIi8ex1kOCgAvXfIi8ex1kOCgAvXfIi8ex1kOCgAvX]],
				["LowerArm.L"] = [[
					e5iqeh2j2jgAife5ijeh2j2jgAife5iSef2j2jgAife5iFef2j2jgAife5iHef2j2jgBife1i2ee4tzlkkdHexjhep5Iscp7UOexjoes4uqjqsSVexjoes4u
					qjqsSVexjoes4uqjqsSVexjoes4uqjqsSVexjoes4uqjqsSVexjoes4uqjqsSVexjoes4uqjqsSVexjoes4uqjqsSVexjoes4uqjqsSVexjoes4uqjqsSVex
					jnes4zq3qkSpezjSej5ZwAn3YOe3i0eg3v1UiOgCe5iqeh2j2jgAife5iqeh2j2jgAife5iqeh2j2jgAif]],
				["UpperArm.R"] = [[
					g4i8ex1kx+gAvXg4i1ew1kx+gAvXg4ikev1kx+gAvXg4iXeu1kx+gAvXg4iZeu1kx+gAvWg4i/ex13zjk4r1g4jbe40xzNtXmug4jfe60SynvQlug4jfe60S
					ynvQlug4jfe60SynvQlug4jfe60SynvQlug4jfe60SynvQlug4jfe60SynvQlug4jfe60SynvQlug4jfe60SynvQlug4jfe60SynvQlug4jfe60SynvQlug4
					jee60Xyuu8l5g4jSe21fz0peo7g4jCey1zy3iNtsg4i8ex1kx+gAvXg4i8ex1kx+gAvXg4i8ex1kx+gAvX]],
				["LowerArm.R"] = [[
					hHiqeh2jJdgAifhHijeh2jJdgAifhHiSef2jJdgAifhHiFef2jJdgAifhHiHef2jJdf/ifhLi2ee4tMbbcdHhPjhep5ITkWFUOhPjoes4uVdVUSVhPjoes4u
					VdVUSVhPjoes4uVdVUSVhPjoes4uVdVUSVhPjoes4uVdVUSVhPjoes4uVdVUSVhPjoes4uVdVUSVhPjoes4uVdVUSVhPjoes4uVdVUSVhPjoes4uVdVUSVhP
					jnes4zVJVcSphNjSej5ZQAYJYOhJi0eg3vKsdygChHiqeh2jJdgAifhHiqeh2jJdgAifhHiqeh2jJdgAif]],
				Tail1 = [[
					gAinhBergAgA/9gAikhBedgAgA/9gAifhAd/gAgA/7gAibhAdngAgA/5gAichAdsgAgA/6gAikhBeyf2gA/9gAinhBfpfnf+//gAiohBfyg1gE/+gAiohBfy
					fxf///gAiohBfyfYf9//gAiohBfygxgE/+gAiohBfygAgA//gAiohBfyfPf8/+gAiohBfygogD//gAiohBfygPgB//gAiohBfyfLf8/+gAiohBfygdgC//gA
					iohBfxgcgC//gAinhBfYfff+/+gAinhBe2gCgA/+gAinhBergAgA/9gAinhBergAgA/9gAinhBergAgA/9]],
				Tail2 = [[
					gAiqhwdygAgA/6gAiphwdygAgA/6gAilhvdygAgA/6gAiihvdygAgA/6gAiihvdygAgA/6gAiohwdmf3f//5f/iohwdSe7f6/2gCiohwdOhbgK/1f/iohwdO
					gDf//3f+iohwdOejf3/1gCiohwdOhKgJ/2gAiohwdOgfgC/3f+iohwdOebf2/1gCiohwdOg0gH/3gBiohwdOg5gF/2f+iohwdOecf1/1gBiohwdOgagE/3gB
					iohwdPhNgH/2f+iphwdbfHf6/4gAiqhwdsgAgA/6gAiqhwdygAgA/6gAiqhwdygAgA/6gAiqhwdygAgA/6]],
				Tail3 = [[
					gAixieXPgAgA+xgAivieXcgAgA+0gAisieX5gAgA+8gAioieYQgAgA/CgAipieYMgAgA/Bf/ivieWxgDgA+of8iwieVYeSff+HgHiwieVIhegj+Cf/iwieVH
					gvgJ+Ef6iwieVId7fW+AgGiwieVHhAgb+EgBiwieVHhQgU+Df5iwieVId+fV+AgEiwieVHgcgQ+EgDiwieVIhrge+Cf5iwieVIeLfX+BgCiwieVHf2gE+FgF
					iwieVLh6gl+Cf8ixieV5fEfs+VgAixifW5f5f++qgAixieXPgAgA+xgAixieXPgAgA+xgAixieXPgAgA+x]],
				Tail4 = [[
					gAjIjEYmgAgA/HgAjGjEZAgAgA/NgAjBjEZ6gAgA/agAi9jEaqgAgA/igAi+jEaigAgA/hf/jHjDX2gUgE+7f4jMjAVUd1fb+EgKjMi/U3hGgh99gBjMjAU3
					hkgP98f1jMi/U4dnfS95gIjMjAU3gbgX9+gEjMjAU4iCgb96f1jMi/U4d4fT96gFjMjAU3fugL9/gHjMjAU4iWgk95f1jMi/U4eVfX98gCjMjAU3fDf+9+gJ
					jMjAU9ibgq96f6jLjBWOfSfv+cgAjJjDYAfxf9++gAjIjEYmgAgA/HgAjIjEYmgAgA/HgAjIjEYmgAgA/H]],
				Tail5 = [[
					gAjXjhr2gAgA9ugAjUjhsbgAgA9egAjNjittgAgA86gAjIjjuvgAgA8ZgAjJjjujgAgA8fgAjXjfq2gifx+Ff0jgjZnJd1gt/GgMjijYmhglgQ/UgEjhjYmf
					iAfB/PfxjijXmfdwgk/PgIjijYmhf3gh/UgIjhjYmeiXfB/OfxjijXmgeMgU/RgEjijYmhfKgv/TgLjhjYmeiifF/NfyjijYmgewgC/TgAjhjYmgehg5/RgN
					jhjYmlicfP/Nf4jejcohfrf8+1f/jYjfrBfrgJ+BgAjXjhr2gAgA9ugAjXjhr2gAgA9ugAjXjhr2gAgA9u]],
				Tail6 = [[
					gAi8j9SygAgA9IgAi4j9TjgAgA9dgAivj7VTgAgA+JgAinj6WvgAgA+ngAipj6WfgAgA+igBi+j9RkgrgS8ifvjPj8NUebe655gNjSj8MmfYgc5bgIjSj8Mo
					iSg75VfsjSj7Mneuez5YgIjSj8MneygF5agNjSj8MoiThJ5UftjSj7MnfUe/5agDjSj8MneRft5YgRjSj7MoiHhR5VfvjSj8Mmf+fQ5bf9jSj8Mnd6fX5WgT
					jRj7MvhvhQ5cf4jJj9OxgVf368f/i/j+Rwfpf28pgAi8j9SygAgA9IgAi8j9SygAgA9IgAi8j9SygAgA9I]],
				["UpperLeg.L"] = [[
					e/hogM7QeWgAwqe/hkgO8EeNfyvQe/hcgR9fd7fTsMe/hWgU+Ydve3pre/hXgU+Pdxe8qIe/hngL7PeVgBwse/hygD2xfBg62be/hzgC1UfOhI30e/hzgC1U
					fOhI30e/hzgC1UfOhI30e/hzgC1UfOhI30e/hzgC1UfOhI30e/hzgC1UfOhI30e/hzgC1UfOhI30e/hzgC1UfOhI30e/hzgC1UfOhI30e/hzgC1UfOhI30e/
					hzgC1ofLhF3ie/hvgG4hexgn0fe/hpgL6secgJxje/hogM7QeWgAwqe/hogM7QeWgAwqe/hogM7QeWgAwq]],
				["LowerLeg.L"] = [[
					e9hGf7tPhxgA9Ee8hFf5sXh5gI9ce7hCf3q9iKgZ9+e7hAf2qUiYgo+Le7hAf2qZiWgl+Ke9hFf5sihvgC9Ye/hMgDwihNfp7We/hNgGx3hFfj6he/hNgGx3
					hFfj6he/hNgGx3hFfj6he/hNgGx3hFfj6he/hNgGx3hFfj6he/hNgGx3hFfj6he/hNgGx3hFfj6he/hNgGx3hFfj6he/hNgGx3hFfj6he/hNgGx3hFfj6he/
					hNgFxkhHfk6te+hJf/vDhYfx8Me9hHf7thhrf888e9hGf7tPhxgA9Ee9hGf7tPhxgA9Ee9hGf7tPhxgA9E]],
				["Foot.L"] = [[
					fBgogV8NgAgAvGfBgogV8NgIf8vGfBgogV8NgbfyvGfBgogV8MgqfpvGfBgogV8MgnfrvGfBgogV8Nf/gAvGfBgogV8MfcgTvGfBgogV8MfUgXvGfBgogV8M
					fUgXvGfBgogV8MfUgXvGfBgogV8MfUgXvGfBgogV8MfUgXvGfBgogV8MfUgXvGfBgogV8MfUgXvGfBgogV8MfUgXvGfBgogV8MfUgXvGfBgogV8MfUgXvGfB
					gogV8MfWgXvGfBgogV8NfngNvGfBgogV8Nf6gDvGfBgogV8NgAgAvGfBgogV8NgAgAvGfBgogV8NgAgAvG]],
				["Toe.L"] = [[
					fBgYgL/9gAgAhgfBgYgL/9gGf4hgfBgYgL/9gSfohgfBgYgL/8gcfZhgfBgYgL/8gafchgfBgYgL/9f/gBhgfBgYgL/8foghhgfBgYgL/8fjgohgfBgYgL/8
					fjgohgfBgYgL/8fjgohgfBgYgL/8fjgohgfBgYgL/8fjgohgfBgYgL/8fjgohgfBgYgL/8fjgohgfBgYgL/8fjgohgfBgYgL/8fjgohgfBgYgL/8fjgohgfB
					gYgL/8fkgnhgfBgYgL/9fvgXhgfBgYgL/9f8gFhgfBgYgL/9gAgAhgfBgYgL/9gAgAhgfBgYgL/9gAgAhg]],
				["UpperLeg.R"] = [[
					hBhogM7QhqgAwqhBhkgO8EhzgOvQhBhcgR9fiFgtsMhBhWgU+YiRhJprhBhXgU+PiPhEqIhBhngL7Phrf/wshBhygD2xg/fG2bhBhzgC1Ugye430hBhzgC1U
					gye430hBhzgC1Ugye430hBhzgC1Ugye430hBhzgC1Ugye430hBhzgC1Ugye430hBhzgC1Ugye430hBhzgC1Ugye430hBhzgC1Ugye430hBhzgC1Ugye430hB
					hzgC1og1e73ihBhvgG4hhPfZ0fhBhpgL6shkf3xjhBhogM7QhqgAwqhBhogM7QhqgAwqhBhogM7QhqgAwq]],
				["LowerLeg.R"] = [[
					hDhGf7tPePgA9EhEhFf5sXeHf49chFhCf3q9d2fn9+hFhAf2qUdofY+LhFhAf2qZdqfb+KhDhFf5sieRf+9YhBhMgDwiezgX7WhBhNgGx3e7gd6hhBhNgGx3
					e7gd6hhBhNgGx3e7gd6hhBhNgGx3e7gd6hhBhNgGx3e7gd6hhBhNgGx3e7gd6hhBhNgGx3e7gd6hhBhNgGx3e7gd6hhBhNgGx3e7gd6hhBhNgGx3e7gd6hhB
					hNgFxke5gc6thChJf/vDeogP8MhDhHf7theVgE88hDhGf7tPePgA9EhDhGf7tPePgA9EhDhGf7tPePgA9E]],
				["Foot.R"] = [[
					g/gogV8NgAgAvGg/gogV8Nf4gEvGg/gogV8NflgOvGg/gogV8MfWgXvGg/gogV8MfZgVvGg/gogV8NgBgAvGg/gogV8MgkftvGg/gogV8MgsfpvGg/gogV8M
					gsfpvGg/gogV8MgsfpvGg/gogV8MgsfpvGg/gogV8MgsfpvGg/gogV8MgsfpvGg/gogV8MgsfpvGg/gogV8MgsfpvGg/gogV8MgsfpvGg/gogV8MgsfpvGg/
					gogV8MgqfpvGg/gogV8NgZfzvGg/gogV8NgGf9vGg/gogV8NgAgAvGg/gogV8NgAgAvGg/gogV8NgAgAvG]],
				["Toe.R"] = [[
					g/gYgL/9gAgAhgg/gYgL/9f6gIhgg/gYgL/9fugYhgg/gYgL/8fkgnhgg/gYgL/8fmgkhgg/gYgL/9gBf/hgg/gYgL/8gYffhgg/gYgL/8gdfYhgg/gYgL/8
					gdfYhgg/gYgL/8gdfYhgg/gYgL/8gdfYhgg/gYgL/8gdfYhgg/gYgL/8gdfYhgg/gYgL/8gdfYhgg/gYgL/8gdfYhgg/gYgL/8gdfYhgg/gYgL/8gdfYhgg/
					gYgL/8gcfZhgg/gYgL/9gRfphgg/gYgL/9gEf7hgg/gYgL/9gAgAhgg/gYgL/9gAgAhgg/gYgL/9gAgAhg]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAilgkAGgAgAiOgAiigkAFgDgriAgAiPgkAEgMhlgjgAiygkANgFhmi/gAjLgkAWgAg/kggAjTgkAagAgAlAgAjLgkAWgAfBkggAiygkANf7eai/gAiOgkAE
					f0ebgjgAiXgkADf6fBhNgAiVgkACgAgAhBgAi/gkAQgBg/jxgAjQgkAbf/hmk0gAjRgkAcf+hmk6gAjDgkASgBg/kDgAiggkAEgAgAhwgAiVgkADf5fBhBgA
					ilgkAIf5eaiMgAilgkAHf7e0iOgAilgkAGf/fwiOgAilgkAGgAgAiO]],
				Spine1 = [[
					gAipgKAfgAgAlff/ilgKAcgIgrlKf9iPgKAMgUhki/f9i3gLAtgQhlmbf+jSgLBKgIg/oZgAjbgLBUgAgApBgCjSgLBKf4fBoZgDi3gLAtfwebmbgDiPgKAM
					fseci+gCiZgKASf0fCj+gAiWgKAPgAgAjsf+jFgLA6gJg+ndf9jXgLBSgMhloyf9jZgLBUgLhlo6f+jKgLBAgIg+n0gAijgKAXgAgAkugCiWgKAQf0fCjsgD
					iogKAhfueclbgCipgKAhfze1lfgAipgKAff9fwlfgAipgKAfgAgAlf]],
				Spine2 = [[
					gAi5fbBPgAgAowf9i1fbBIgMgqoVf5iZfZAigchilff5jLfdBngbhip2f8jrfgCdgPg9sOgAj2fhCwgAgAs9gEjrfgCdfxfDsOgHjLfdBnfleep2gHiZfZAi
					fkeelegEimfaAwfvfDmxgAiifaAqgAgAmaf8jbfeCBgQg9rGf5jyfhCrgZhjsrf5j0fhCvgZhjs0f8jhffCMgQg9rigAixfaA+gAgAnugEiifaArfvfDmagH
					i5fcBQfkeeosgFi5fcBQfre2owgBi5fbBPf8fxowgAi5fbBPgAgAow]],
				Neck1 = [[
					gAjHfGEigAgAwYf8jCfFELgWgmvwf2ihfCCJguhbrWf3jZfJFjg1hXx7f6j9fOIEgjg11MgAkIfQI7gAgA2JgGj9fOIEfdfL1MgJjZfJFjfLepx7gKihfCCI
					fSelrUgGiwfDC9fifJtXgAisfCCsgAgAszf6jsfLG0gig1zsf3kEfQIog4hV1xf3kGfQIzg5hV19f6jyfMHSgig10SgAi9fEDqgAgAu0gGisfDCtfjfIszgJ
					jGfGEhfMeowRgHjHfGEjfZe+wYgBjHfGEif4fywYgAjHfGEigAgAwY]],
				Neck2 = [[
					gAjseyG/gAgAz8f7jnevGjgbgizXf0i+eiD8g6hUvRf1kBe5IOhAhP1Vf6knfJLJgpgw4OgAkzfPMHgAgA5DgGknfJLJfXfQ4OgLkBe5IOfAex1VgMi9eiD7
					fGesvQgHjQenFCfbfNxKgAjLelEsgAgAwpf5kVfBJtgpgw26f2kvfNLyhDhM4uf2kxfOL/hDhM45f6kcfEKQgpgw3cgAjgesF6gAgAyggIjLelEtfbfNwogL
					jreyG9fBewz1gJjseyHBfQfEz7gCjseyG/f2f0z8gAjseyG/gAgAz8]],
				Head = [[
					gAkQepAFgAgAh7f7kKelAMefgvixfyjceOAUcciMexf0kme1A1cihUmHf6lMfPBtd7ghqAgAlXfXCCgAgArLgGlMfPBtiFffqAgMkme1A1jeesmHgOjceOAU
					jkd0ewgIjyeYAIiNezg1gAjseUABgAgAgIf5k6fCBJd4gqoJf2lTfUCGcrgvq1f2lVfWCMcrgurFf5lBfHBWd5gno4gAkDegAHgAgAiXgIjseVAHiNewgNgM
					kPepAijgedkNgJkQeqAXipezjsgCkQepAIgjfvifgAkQepAFgAgAh7]],
				Jaw = [[
					gAkYd4/8gAgAhmf4kUd1/Shrfvmefrjadd9FkHfQsqfuk5eI/RjugClof2lqeo/4iIgRhsgAl5ez//gAgAgegKlqeo/4d4fvhsgSk5eI/RcSf+logVjZdd9E
					b5gwsrgMj2dn+AdhgUq0gAjudj92gAgArff1lTeY/tiOgKjofwlzev/zjYghgxfwl2ey/zjXgjggf2ldee/yiMgNi3gAkMdv+lgAgApZgNjudj9ydggXrZgT
					kdd6+3cLgLnhgOkdd6/SdHgWmCgDkZd5/1fagLjHgAkYd5/8gAgAhl]],
				Cloud = [[
					gAo3eXJdeOhy2jfco9ekKIeSik3IemoAdFHYfSja0Ie0pFf0MigKh25UfWpLhMP4gjgw7ngApJhkQ/gAgA8PgqpLhMP4fdfQ7nhMpFf0Mif2eK5UhaoAdEHX
					gucm0Gg2ogdyI1h3cl1tgAoPdhIOhreI1QfVpDgeOPgFhF6le/pChdQ4dVjI74e9pKhoRSb5j271fTpZg5PGdHi762gAo6eWJsgAgA27g2oVdkIeiLcH1NhN
					oqfDLjjZa/31g5ole4K1hxc13tgMorehJyfLgd3AgAo3eXJdeOhy2j]],
				["UpperArm.L"] = [[
					fIi8ex1kOCgAvXfDi3ez0FLdZRsWe9iTe1y2LUVOrIe9jRe400O5Pgk+fBj3e702NzRQmSfIkEe50UL3UVoUfPj4e01jNRSflCfUjRet2ROYRojLfUiSeq0B
					KgXRpJfPijesyeJmZPrlfIieevzwLLVnpkfBjke41QPcPMjve9j/e+0tONQmmVe9kBe/z2MbTgpefBjse50tNeRrmxfIixew1ONlRylkfPiees0HK8WQo9fU
					i8erzWJ5YQqBfRi8et1YLeX/o8fKi8ew1zMxdOtDfIi8ex1kOCgAvX]],
				["LowerArm.L"] = [[
					e5iqeh2j2jgAifeuixeh6IxGlQbaeliUem7hvLiLabeljaes5lv+iOVmeqj/et5uuOl/U4eykIeo5ttFphV8e6kAej5cupnpV0e/jbed5UwzkzXPe/iSeW7B
					v8k0b9e6ifeZ69u7ngbyeyiged7Jvdj9aYeqjves5Iv/jZU2elkHex5ot+lsUNelkEew6Es1oGVWeqjzer5+uXlqVeeyi5eg6FwniXYMe6igeZ6+vskya2e/
					i6eY6dumo6aZe9i7eY6AxWlUbze4iwed4D1BhDhMe5iqeh2j2jgAif]],
				["UpperArm.R"] = [[
					g4i8ex1kx+gAvXgzi3eu18z1ozobgsiSeq0C1gowpIgsjRetzv1xokpSgxj4e01jyvthlCg4kEe513vtxMh1g/j3e702yNuwmShDjRe4y50pqcrchDiTe1y1
					0tqxrIg/ijez0lysuUmwg4ieevzw01qZpkgxjlex0A1Lp0o5gskBez11yrtakTgskDe02iwCwChAgxjtey1azEtFlhg4ixewyk12oBrsg/ifeyzY0krBqLhD
					i8e30oxtv2lyhAi8e10uz0pmqdg6i8ex1gzFiwtwg4i8ex1kx+gAvX]],
				["LowerArm.R"] = [[
					hHiqeh2jJdgAifhHi2ea54Nndfc+hBiTeW7BQFbLb8hBjRea6NRvWkZYhGkAej5cRXYXV0hOkRet4WQDa0T0hWj/et5uRyaBU4hbjRep68SVZQX9hbiUem7h
					Q1d1achWiqek6ZPme8YfhOiged7JQjcDaYhGjnef6CSMWgYBhBkJei5KRXXpVuhBkQem4QPqZlUwhGj0eh5rRNYtWahOivee7DRfY4ahhWigej7SQyc3Z7hb
					jFeq58P7eaWkhXi7ek6VPBcpahhMiveg4ILKdifYhHiqeh2jJdgAif]],
				Tail1 = [[
					gAinhBergAgA/9gBikhBenjLgG/zgDiThAeJlzfv/ZgDiyhBezi9gQ/1gCjIhBfIeZfu/8gAjPhBfPbpfI/qf+jIhBfIcdfZ/xf9iyhBezfyf//9f9iThAeH
					iqf4/0f+ibhAeViof+/1gAiZhAeRgAgA/8gCi9hBe/dZfq/3gDjNhAfMdZfg/3gDjOhAfNgNgD/+gCjBhBfDjkgh/xgAiihBefkdgF/pf+iZhAeRhpf+/5f9
					imhBeqdCf4/0f+inhBesbpf0/qgAinhBere3f9/8gAinhBergAgA/9]],
				Tail2 = [[
					gAiqhwdygAgA/6gLiohvd4kpgR/lgUiYhseeqGfx+UgMi2hvdTl9gs/Tf9jLhvcadmfe/sfzjShucLX1eG+of0jLhvcdYtej+6f8i2hwdQfPf7/3gFiZhueZ
					l4f7/agGighveLm9gK/LgAiehveMh6gE/4f6jAhvc3bTfP/ef7jPhvcRZIen+/gDjQhwcLdMfm/ogMjEhvctkWg5/ggNinhud7oZgZ+zgDiehveOligG/df0
					iqhvdzdmf2/0fxiqhud1ZQfi/Mf8iqhwdydxf2/1gAiqhwdygAgA/6]],
				Tail3 = [[
					gAixieXPgAgA+xgYiuicXjkrhQ+egwiciSZttXib8Rgdi+iaWkpgjI84f2jVidUOe4fL9tfdjeiWUGWFbJ7kfgjWiYUzVRbf7mf6i+ieWKc+fF+RgWidiaZH
					nXhW+VgailiZYxqzij9HgGijieYhlKhT+pftjKibVRbXeC9tfojbiYUTWSbx70f7jcidT6Zfdq8ygZjOibU3i7hp9zglitiWYHqxiy88gTijibY1pliP9lft
					ixidXRf/gA+xfeixiYXhYVd09yf2ixieXSc0fG+mgAixieXPgAgA+x]],
				Tail4 = [[
					gAjIjEYmgAgA/HgjjFi/Y/jpgw+/hPiuircRvkh77ogyjYi3Xotnjx7df0jzi9T3hrft9jfKj+itTcVMau62fKj1ivUxRoar5ufzjYjBXCZVeX97goiwi9bg
					nLgs+2gzi5i3bBuAin8NgSi3jDa3pUh++Hfjjmi8VZc9eZ9+fVj6ixT3UMbL6tfuj7i4TkVVcv7Sgejri8U1gJhF99g+jDizZur6id87gqi3i7bQtdih8hft
					jIjCYsjpg4+6fMjIi5Y0YdeN+MfujIjCYqb8fC+2gAjIjEYmgAgA/H]],
				Tail5 = [[
					gAjXjhr2gAgA9tgqjTjcsShUfV9ghqi3i7tnuCX/4BhHjqjHnqwfaI5qf3kKjUlQk1dB/Ce8kXi8jSUsgs9ve3kMi6jZOskV6VfojpjZo2VqkG8qg2i5jZvI
					kJc57thLjEjJsZuaZP41gjjCjctNsgas5xfej6jUnifge6/EfFkSi/jdS9iS86fekSjIjASEkg8SgekAjUmvdEin/BhSjQjIr2qYbW7dhBjCjOsqu3ZI4Zf0
					jWjerhnhdB8ue+jXjSroaQiT9KfmjXjerubshu9ZgAjXjhr2gAgA9u]],
				Tail6 = [[
					gAi7j9SygAgA9Igsi3j3TYevfP9Wh7iVjFYtumja7ThkjTjVS+xgo41pgCj8j3Mhpli53UejkPjZLMapYV2beVj/jKOfQXVay9fTjTjyRtSXZz4Yg7iYjuXR
					h/e6+shgiljVXPu+lZ6Vg3ijjqX8vbmi6Cfcjoj3OFkggQ6HepkIjYL+XFXy1zfBkHjfM0RYXvzTgYjwj3NsX8eM45hkizjcURoVjG8ZhXiijYYLwbmI5lgC
					i7j3T2rClB6/ezi8jtS3czej89fei8j6S7bxeF80gAi8j9SygAgA9I]],
				["UpperLeg.L"] = [[
					e/hogM7QeWgAwqe+hlgQ8QepfNu7e9hQgZ/Cegcxm4e9h2gQ7ffcewwTe9iRgI3PfxgQ1+e/ibgCzvfdhW5IfAiSgAzSesh55afBh3gD5NddhlzefBhPgM94
					cxgoq7fAhZgM9JdUgSs6e/hWgR9+dzfGq7e9iEgK5Zfafyzde9iWgJ2xgWf/2ee9iYgJ2KgdgH3Ee9iJgJ4qfif90Xe/higO86eBfhtifAhWgN9fdQgLsGfB
					hngG6QdVhayCfBhogH6ddmhFxze/hogL7GeMgOw5e/hogM7QeWgAwq]],
				["LowerLeg.L"] = [[
					e9hGf7tPhxgA9Ee7hGf7s5iqgB9Ke1hBf4qvkxhK9ve6hVf+uQjbfm8ce+hrgGxkiHfL6pfAh2gLzqg/fa5NfBhugKzQgMf75ifBhSf5slf6gV9afAg2fvl0
					gLgZ/de+g9fzomg5ga+ze7g+f0pPiPgk+ie8hfgBvniafb70e9hwgJykijez55e+hygKzHieeu5ge9hkgCwRiTfV7ce8hFf2qciAgU+Ke+g7fyoBg7gc+9fB
					hEf4sEf9gV9ofAhFf5sdgagP9de9hGf6tEhfgD9Ke9hGf7tPhxgA9E]],
				["Foot.L"] = [[
					fBgogV8NgAgAvGfBgogV8MgyflvGfBgogV8Ei1efvBfBg1gV7bhYfMwYfBhGgV6ugQf2xlfBhPgV6FfVghyhfBhHgV6heog7xzfBg1gV7bedg7wXfBgogV8L
					evgrvFfBgogV8MfWgXvGfBgogV8MgjfuvGfBg9gV7Gggfsw/fBhKgV6kgoflx0fBhLgV6hglfnx4fBhAgV68gafvxPfBgsgV77gSf2vlfBgogV8MfZgVvGfB
					gogV8Kefg0vEfBgogV8Le3gnvFfBgogV8NfxgIvGfBgogV8NgAgAvG]],
				["Toe.L"] = [[
					fBgYgL/9gAgAhgfBgYgL/8gifShgfBgYgL/zh5dbhffBglgN/0g5eri/fBg1gO/sgKfwkZfBg9gP/gfogwlgfBg2gO/mfKhbkqfBglgN/zfAhgi/fBgYgL/7
					fJhKhgfBgYgL/8fkgnhgfBgYgL/8gXfghgfBgsgN/xgUfgjsfBg5gO/pgZfWkqfBg6gP/ogWfakvfBgvgO/vgQfmj+fBgcgM/7gMfwiEfBgYgL/8fmgkhgfB
					gYgL/6e/hYhgfBgYgL/7fPhDhgfBgYgL/9f2gOhgfBgYgL/9gAgAhg]],
				["UpperLeg.R"] = [[
					hBhogM7QhqgAwqhAhlgK7fiMfjwOg/hPgM94jOfXq9g/h3gD5NijebzehAiSgAzShUeH5ahBibgCzvgjeq5IhDiRgI3PgPfw1+hDh2gQ7fgkhQwThDhQgZ/D
					hgjQm1hDhZgU+Chmh1qwhBhWgR9+iNg6q7hAiEgC3ch2el1pg/iYf8y0hzdw5tg/iaf8yzhzdw5uhAiKgB2Uhtec2zhBhigO86h/gftihDhWgV+VhqiAp2hD
					hngT8KgshevGhDhogR75g6hFvmhChogN7ZhggOwchBhogM7QhqgAwq]],
				["LowerLeg.R"] = [[
					hDhGf7tPePgA9EhChEf4r0e8fz9thAg2fvl2f1fn/cg/hSf5slgGfr9ag/hugKzQf0gF5ihAh2gLzqfBgm5NhChrgGxkd5g16phGhVf+uQclga8chLhBf4qu
					bPe19vhIhBf3q6cjfd93hFg+f0pPdxfc+ihAhff/vVfnf78Fg/h0gIy1gVfx53g/h2gHyzgVfw54hAhkgCwcfrf+7chEhFf2qceAfs+KhIhBf3qhccfV9/hH
					hIf+uUcXgS8XhGhIf9uHc2gO8ihEhHf7tad9gD8+hDhGf7tPePgA9E]],
				["Foot.R"] = [[
					g/gogV8NgAgAvGg/gogV8MglfsvGg/gogV8LhRfVvFg/g1gV7bhjfFwXg/hHgV6hhYfFxzg/hPgV6Fgrffyhg/hGgV6ufwgKxlg/g1gV7beog0wYg/gogV8E
					dLhhvBg/gogV8Kebg2vEg/gogV8MfdgSvGg/g9gV7FhLfRw/g/hOgU5whxevy2g/hQgU5mhweuzDg/hAgV67hPfOxOg/gsgV77fugKvlg/gogV8JeTg6vEg/
					gogV8Keag2vEg/gogV8Le1govFg/gogV8NfxgIvGg/gogV8NgAgAvG]],
				["Toe.R"] = [[
					g/gYgL/9gAgAhgg/gYgL/8gZfehgg/gYgL/7g3e2hgg/glgN/zhAegi/g/g2gO/mg2elkqg/g9gP/ggYfQlgg/g1gO/sf2gQkZg/glgN/0fHhVi/g/gYgL/y
					eGilhfg/gYgL/6e8hchfg/gYgL/8fpgghgg/gsgN/vgve2jsg/g8gP/XhDeGl8g/g+gP/ThCeFmMg/gvgO/tgxexj9g/gcgM/7f0gQiEg/gYgL/5e3hkhfg/
					gYgL/6e8hdhfg/gYgL/7fOhFhgg/gYgL/9f2gOhgg/gYgL/9gAgAhg]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAilgkAGgAgAiOgAilg2ATgAgAkQgAilhCAggAgAligAilg/AcgAgFlMgAilg5AWgAflkhgAilgyAUf9d/jzgAilguAPf8eTjUgAilgsALf/frjMgAilgpAJ
					gBgOi2gAirglAKh6f5iZgAizgkAwmefjiLgAiugkCgsLfKiEgAibgkFExHe0h4gAiIgkHIz/enhvgAiFgkHc0YelhtgAiOgkGfzKerhygAiQgkGTy6eshzgA
					iGgkHR0KemhugAiDgkHk0helhtgAiDgkHk0helhtgAiDgkHk0helhtgAiDgkHk0helhtgAiDgkHk0helht]],
				Spine1 = [[
					gAipgKAfgAgAlfgAisgdA6gAgAnegAiugqBPgAgAovgAitgnBJgAgFoZgBisggA+f9flnwgDirgZA3fwd/nBgDiqgVAvfxeUmjgBiqgTArf9fsmcgAiqgQAn
					gDgOmGgAivgMAlh4ftlpgBi2gKBJmZe5lXgDixgKC4sBd6lEgDidgKFaw5dEkogDiJgKHczvckkRgEiFgKHw0IcgkOgDiPgKGzy7ctkZgDiRgKGoyrcwkagD
					iHgKHkz6cjkQgEiEgKH30QcfkNgEiEgKH30QcfkNgEiEgKH30QcfkNgEiEgKH30QcfkNgEiEgKH30QcfkN]],
				Spine2 = [[
					gAi5fbBPgAgAowgAjCfxB3gAgAqsgAjIgACUgAgAr6gAjGf8CMgBgFrlgCjEf0B9f6flq9gJjAftBxfjeCqPgIi+fnBmfmeWpygBi+fmBhf7fsprf/i8fiBa
					gEgOpWgCjAfdBWh4fpo6gIjFfbB6mXesorgOi9fbDrr9dgocgSikfbGQwzcaoFgUiMfbIVzmbwnzgUiIfbIpz+bqnwgUiUfbHryyb8n4gTiWfbHgyjcAn6gU
					iLfbIdzwbtnxgUiHfbIx0GbnnvgUiHfbIx0GbnnvgUiHfbIx0GbnnvgUiHfbIx0GbnnvgUiHfbIx0Gbnnv]],
				Neck1 = [[
					gAjHfGEigAgAwYgAjSfdHCgAgAz/gAjZftI5gAgA2HgAjXfpIZgDgE1kgDjUfhHbfyfp0egMjQfZGfe9eRzMgKjNfTF2fIejyWgCjMfRFqf1fuyJf/jKfNFP
					gIgMxhgEjNfIErhle7wggNjSfGEulXcavagXjHfGF1qLZft2geirfGHnucXMr8ggiRfGJHw+V+qighiNfGJWxUV0qUggiafGIpwPWUq9gficfGIhwBWarFgg
					iPfGJNxHV6qcghiLfGJbxcVxqQghiLfGJbxcVxqQghiLfGJbxcVxqQghiLfGJbxcVxqQghiLfGJbxcVxqQ]],
				Neck2 = [[
					gAjseyG/gAgAz8gAj8fUJ9gAgA3LgAkEfrMGgAgA5Cf/kCflLhgDgE4kgDj+fZKafvfr3mgOj5fNJUeueb2dgMj1fEIke8er1tgCj0fCIXfzfw1if+jye8H2
					gJgL0+gIjze0HJhRei0CgcjzewG+kUbGy0gxjgevHnoPXGwxg+i5euIxrxT9uIhDiXetJyt6SUsLhDiSetJ8uNSGr4hCiietJdtSSxsyhBiletJXtGS5s8hD
					iVetJ2uCSOsDhDiQetJ/uTSCryhDiQetJ/uTSCryhDiQetJ/uTSCryhDiQetJ/uTSCryhDiQetJ/uTSCry]],
				Head = [[
					gAkQepAFgAgAh7gAkhfWBSgAgAo7gAkof0C3gAgAtMf/kmfsCZf7gDsFgDkifcBlgdfsp3gOkdfNBDiPeSnhgMkafCAph8ecl0gCkZe+AdgYftlTf+kWe3AS
					fwgOkGgNkXesAJh2fNiEgqkUemAvmQdhf9hKj4ekCkrlcDdahejGeiFMv+bfaphkidegHPyYbmYyhliWegHiytbpYhhjiqehGmxtbiZWhjitehGbxgbhZghl
					iaegHXyhbnYrhliUegHpy0bqYbhliUegHpy0bqYbhliUegHpy0bqYbhliUegHpy0bqYbhliUegHpy0bqYb]],
				Jaw = [[
					gAkYd5/8gAgAhlgAk9et//gAgAfkgAlOfU/8gAgAeQf/lKfK/9gGf/emgElBe1/+fegLfRgVk1ei/3dbhKf2gSkteU/5dzhKgYgEkreQ/+flgPgnf+kkeH/+
					gSf1g+gQkfd7/1eEgiiagzkUd2+1ZbhalNhUjtd18MT2hYo4hjiyd14ePagKsNhkiEd11mNJe2uIhkh9d21KM2eouYhkiSd12fNxfStlhkiWd12vN9fZtbhk
					iBd11aNBewuPhjh7d21AMwejuehjh7d21AMwejuehjh7d21AMwejuehjh7d21AMwejuehjh7d21AMwejue]],
				Cloud = [[
					gAo3eXJZgAgA2ngAozhEO7gAgA7DgAoQirS9gAgA9Nf+ociRR2f+gG8sgKothcPygIfd7kg2o1gkN0gidP6Kgwo6f5MZgadj5JgJo9frL6gFfi44f6o9fNK+
					f9gV4Ggwo8edJig2eL2riiofd5IkjCaA0tkbm+dfIQmCVXxmljkxdIIYo9SCtyl3jHc6Irq2QhrCl4i3c5IvrHQWqolzjnc+IkqSQ7r3lyjxdAIjqIRCsGl4
					jAc6Itq9Qcq3l5ixc4IwrNQSqfl5ixc4IwrNQSqfl5ixc4IwrNQSqfl5ixc4IwrNQSqfl5ixc4IwrNQSqf]],
				["UpperArm.L"] = [[
					fIi8ex1kOCgAvXfIjLfH4IOYcgq3fIjUfW5TO9aVnwfHjRfS5CO0a2opfLjNfJ4cOTcVp+fXjIe83qNZesqvfVjFe33DNZfTsCfKjDe625N+ejtGfGjBe42b
					OLexuKfLjKez0hNHfSvpfVjfeyw+LZeNxhfnjoe0soKNbpzOf8jbe1otKGYj0TgKjIe2maKfWS0ngMjEe3mGKkV90ogGjOe2nFKVW/0jgFjQe2nRKTXL0hgL
					jGe2mSKhWJ0ngNjDe3mAKmV10ogNjDe3mAKmV10ogNjDe3mAKmV10ogNjDe3mAKmV10ogNjDe3mAKmV10o]],
				["LowerArm.L"] = [[
					e5iqeh2j2jgAife5jAey2m2HkZeEe5jOe/2L1ZnIbPe4jKe82V1omXb7e8jDez2h1/lTdvfKi8em2j2Kk3gefHi2ej2n2TjlhTe7i0en2r2ciVgne3ixen2r
					2hhMg/e5i5ek3o1cf5iPe/jRen52yleOikfNjget8Qufcihzfgjaez94qWbMgXfujMe3+lnkajfIfwjJe3+qnKaee7fqjRe2+aoZatfhfojSe1+Wopaxfofv
					jLe3+nnZahfDfxjIe4+snBace3fxjIe4+snBace3fxjIe4+snBace3fxjIe4+snBace3fxjIe4+snBace3]],
				["UpperArm.R"] = [[
					g4i8ex1kx+gAvXg4jLfH4Ixojgq3g4jUfW5TxDlrnwg3jRfS5CxQlDojg7jNfM4ZxVkSqchGjHfK3iw1kJtBhEjEfD2/xEjEt8g6jDe825xvh5tdg2jBe22c
					yCg6t7g6i9ey2owfeovag8izev3zstaLwKg2iZet4insU0vZgrh2es4FjJQItdgihber3RgeNbrrgghXer3IgHNErZglhjer3jhQOMsQgmhmer3oheObsagh
					hZer3NgUNRrjgghVer3Ef/M7rSgghVer3Ef/M7rSgghVer3Ef/M7rSgghVer3Ef/M7rSgghVer3Ef/M7rS]],
				["LowerArm.R"] = [[
					hHiqeh2jJdgAifhHjAey2mJ5bneEhHjOe/2LKnY4bPhHjKe72UKZZicChLjDe22kKAbUdJhYi6e42sJreBdnhVi1ey2tJhe2e6hKi0eq2sJieIgJhFixel2p
					JgeghThGioej06H7flieg/iZejwaEyf0joguiAelqAB+fikkgZhheojvAtfMlYgKhLepfxAle7l4gIhIeqfNAne5l9gPhSepg8AkfAlvgQhUephRAkfClsgJ
					hKeqfiAme6l6gIhHeqfAAne4l/gIhHeqfAAne4l/gIhHeqfAAne4l/gIhHeqfAAne4l/gIhHeqfAAne4l/]],
				Tail1 = [[
					gAinhBergAgA/9gAijhTgtgAgA//gAighfiAgAgA/7gAihhchqgHgB/8f/iihWg/fXf7/+f8ikhPgQc/fu/2f9ilhLfxddf0/4f/ilhKfpfhf+//gAilhGfS
					gVgB/+gAishCe5gAeG/6gBi0hBexf2Zh/TgBivhBexfrTz9igBichBeqfhO269gBiIhBeifcL+45gCiFhBehfcLl4kgBiPhBelfeMz5igBiQhBelfeNC5ugB
					iHhBeifcLz4wgCiEhBehfbLc4dgCiEhBehfbLc4dgCiEhBehfbLc4dgCiEhBehfbLc4dgCiEhBehfbLc4d]],
				Tail2 = [[
					gAiqhwdygAgA/6gAihiCf0gAgA//gAibiOhHgAgA/+gAiciLgxgKgC/+f9ifiFgGfKf4/+fzijh9fXb/fh/uf1ilh5e4cofp/yf+imh5ewfXf8/9gBioh2eZ
					gcgC/8gAiwhxeCf8eF/3gBi4hwd/fmZf/QgCizhwd7fLTw9dgCighwdrezOz62gDiNhwdbenL84vgDiJhwdYelLj4bgDiThwdgeqMx5ZgDiVhwdierNA5lgD
					iLhwdaemLy4ngDiIhwdXelLb4TgDiIhwdXelLb4TgDiIhwdXelLb4TgDiIhwdXelLb4TgDiIhwdXelLb4T]],
				Tail3 = [[
					gAixieXPgAgA+xgAihiyZNgAgA/QgAiXi9afgAgA/ggBiai6aJgMgF/cf7ifi0ZffAfo/TfoilirY3bPeY+xfsipinYXb+et+xf8iqioYLfPfw/AgDisikX1
					gigK+7gBi1igXigOeF+ygBi+ifXpgiZb+KgCi6ieX5g6Tp8WgDioieYAhOOr5pgFiVieYAhbL13dgFiSieX/hdLc3HgEibieYAhXMp4IgEidieYAhWM44VgF
					iUieX/hcLq3UgFiRieX/hdLU2/gFiRieX/hdLU2/gFiRieX/hdLU2/gFiRieX/hdLU2/gFiRieX/hdLU2/]],
				Tail4 = [[
					gAjIjEYmgAgA/HgAi0jZalgAgA/hgAimjmb4gAgA/ugBiqjjbigOgF/rf4ixjca3eyfn/jfci5jQaQaNeU+4fii9jNZvbGeq+9f6i+jOZifEfw/UgEjCjLZN
					gpgK/QgDjMjGY8gCeD/IgHjTjEZDf0ZU+ggMjMjFZKfiTd8ngSi4jFY8fSOd5ygVijjEYqfKLo3hgWifjEYnfJLP3LgUipjEYwfMMc4OgUirjEYyfMMr4bgV
					ihjEYpfKLd3YgWiejEYmfJLH3DgWiejEYmfJLH3DgWiejEYmfJLH3DgWiejEYmfJLH3DgWiejEYmfJLH3D]],
				Tail5 = [[
					gAjXjhr2gAgA9ugAi+j4ttgAgA86gAiukFu4gAgA8UgCizkCukgRf78ef2i7j7t8elgd8wfRjEjss+ZWiS8YfZjKjpsoabiA8yf4jLjssve8gZ9VgFjPjosb
					gufu9egDjZjjsLezeb9hgKjhjir7bnaz85gRjZjiq0XpWX7RgYjEjiozURSo5FgdivjhnESZQh3ageirjhmySJQP3Kgci2jhnnS7RH37gbi3jhnxTFRT4Fge
					itjhm9SSQZ3TgeiqjhmsSEQI3EgeiqjhmsSEQI3EgeiqjhmsSEQI3EgeiqjhmsSEQI3EgeiqjhmsSEQI3E]],
				Tail6 = [[
					gAi8j9SygAgA9IgAigkRUqgAgA96gAiOkcV5gAgA+WgCiTkZVkgRgK+PfzickTU8egfM9+fFinkEUnY4cV8zfOitkCUEZ8dA85f2iukHTse2fc9fgHizkDTX
					gzgY9Xf/i+j/TMgMd/9Pf7jIj9ThgTZE8of3jJj7T4gYTA6lf4i/j4T5gZN73cf8iyj2TwgaLI06f9iwj2TugbKw0gf7i3j3TzgZL61sf7i4j3T0gZMJ17f9
					ixj2TvgaK+0vf9ivj2TtgbKo0Xf9ivj2TtgbKo0Xf9ivj2TtgbKo0Xf9ivj2TtgbKo0Xf9ivj2TtgbKo0X]],
				["UpperLeg.L"] = [[
					e/hogM7QeWgAwqe/hrgX9AeXf0tZe/hugf97eYfsrLe/htgd9sebfqrye/hsgX9OeJgJs5fChrgN8mdThkt/fChqgL8NddhWu0e/hpgQ8JeMgMvHe+hpgQ71
					edfwvse4h2gN7fcue+v/esiVgM7FYuc0vEenixgM51TladtFeti8gM3uO/Y0q7e2i6gM19MSYFpde4i5gM1rL6YApQezi8gM2hNEYSp5eyi8gM2rNSYVqBe3
					i6gM11MHYDpYe4i5gM1kLxX+pLe4i5gM1kLxX+pLe4i5gM1kLxX+pLe4i5gM1kLxX+pLe4i5gM1kLxX+pL]],
				["LowerLeg.L"] = [[
					e9hGf7tPhxgA9Ee9hPf/whhwgN7Ve9hVgCyhhvgV6Be9hTgByAh0gR6Ye+hQf9w9hXga7FfDhNf2vyf6g/7zfChLf2vAgNg08Pe+hKf7u1hegP8Te8hJf9uQ
					h9f+8keyhWf6tehAeR88edh4f4s4fJaD8qeQidf1sHc6Uv7NeTiyfzrEbEQE49eci3fyqQaBNV3Gedi2fxqJZ4M920eYi2fyqgaUOI3reYi2fyqlaaOW32ec
					i3fyqNZ+NL2+eei2fxqGZ1M12teei2fxqGZ1M12teei2fxqGZ1M12teei2fxqGZ1M12teei2fxqGZ1M12t]],
				["Foot.L"] = [[
					fBgogV8NgAgAvGfBgrgR9xgAgArufBgvgP+jgAgApdfBgugQ+XgCf8qEfBgsgP98fzgYrPfEgqgK9ZfChysdfDgpgN9DfMhgtSfBgpgS9Af2gStgfBgogV8u
					gGfzuFeyg3gV8beUfGuieVhbgT8DaMdIt7d/iGgS62U8a5sad7ijgQ4zQQZOqreBitgP3ENeYZpfeDitgP2zNGYSpTd/iqgP3nOSYnp2d+iqgP3xOhYsp8eC
					itgP29NUYWpaeDiugP2sM9YQpPeDiugP2sM9YQpPeDiugP2sM9YQpPeDiugP2sM9YQpPeDiugP2sM9YQpP]],
				["Toe.L"] = [[
					fBgYgL/9gAgAhgfBgegE/6gAgAdyfBglgA/qgAgAbZfBgjgB/vgAf7cCfCgggB/3f+gbdQfFgdf+/5f5iBemfEgbgB/8f6htfgfBgbgG//f/gVfufAgagK//
					gAfygXexgogK/7eGf6g5ePhOgI/UZhf5ggd1h8gG9kT0gJfpdvidgD6/O3gqe+d1iqgC45MAhGepd2irgC4lLnhLemdyingC5jM1g9eudyimgD5vNEg7ewd1
					iqgC4xL1hIeod3irgC4dLehMeld3irgC4dLehMeld3irgC4dLehMeld3irgC4dLehMeld3irgC4dLehMel]],
				["UpperLeg.R"] = [[
					hBhogM7QhqgAwqhBhrgX9AhpgMtZhBhugf97hogUrLhBhtgc9shrgOrxhChsgb9Ohagls8hEhqgd8mglh3uNhDhpgZ8Ngwhju/hChpgT8JhfgXvJhBhpgP71
					hwf3vrg5hngN71gBfFvwgkhhgM8Mb2dLuQgDhVgM7zWTbdrpfkhGgM6URNappGfSg7gM41OHahngfQg5gM4lNrahnSfYg/gM5UPAahn+fZhAgM5cPRahoGfR
					g6gM4uN7ahnafPg5gM4gNiahnNfPg5gM4gNiahnNfPg5gM4gNiahnNfPg5gM4gNiahnNfPg5gM4gNiahnN]],
				["LowerLeg.R"] = [[
					hDhGf7tPePgA9EhDhPf/wheQfz7VhDhVgCyheRfr6BhDhTgByAeVfr6ZhEhQgBw9d3f87ChIhMgGvycagq7lhHhKgEvAcsgl8DhEhKf+u1d8gC8RhDhJf7uQ
					ecf28mg4hGf6tLdfeQ8/gZhEf2r4bwaG8zfxhAfyqPZ4Ux7efQg6fvoeYjQE5Ve+g0ftnRX6NS3je8gzftnGX1M53RfDg3ftnoYFOF4HfFg3ftnuYIOU4Re9
					g0ftnMX4NH3be7gzfsnCX0Mx3Ke7gzfsnCX0Mx3Ke7gzfsnCX0Mx3Ke7gzfsnCX0Mx3Ke7gzfsnCX0Mx3K]],
				["Foot.R"] = [[
					g/gogV8NgAgAvGg/grgR9xgAgArug/gvgP+jgAgApdg/gugP+XgCf8qEhAgrgS98fzgYrPhBgpga9ZfChysdhBgoga9DfMhgtShAgpgV9Af2gStgg/gogT8u
					gGfzuFgwgogU8heUfHuXgKgrgS8VaJdPtXfbgvgP7UUvbVrWe2gzgN5XP5aIpQekgzgM3qNAZqn5eigzgM3YMnZnntepgzgM4NN2ZxoTergzgM4WOFZ0obej
					gzgM3iM1Zpn0eigzgM3SMeZmnpeigzgM3SMeZmnpeigzgM3SMeZmnpeigzgM3SMeZmnpeigzgM3SMeZmnp]],
				["Toe.R"] = [[
					g/gYgL/9gAgAhgg/gegE/6gAgAdyg/glgA/qgAgAbZg/gjgB/vgAf7cChAgfgF/3f+gbdQhDgcgO/5f5iBemhCgagO/8f6htfghAgagJ//f/gVfug/gagI//
					gAfygXgugagJ/7eGf7gtgEgegG/VZhgCf3fSgmgC9iT1goefesguf/64O7hoddeagxf94wMIidc9eYgxf94bLvilc5eegwf+5aM7iMdFeggwf+5mNKiHdIeZ
					gxf94nL9igc7eXgxf94TLnioc4eXgxf94TLnioc4eXgxf94TLnioc4eXgxf94TLnioc4eXgxf94TLnioc4]],
			},
		},
	},
}
