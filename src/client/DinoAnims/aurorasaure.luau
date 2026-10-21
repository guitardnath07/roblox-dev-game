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
					gAiNggDQgAgAuBgAiNggDVgAgAuLgAiOggDZgAgAuUgAiPggDdgAgAubgAiPggDfgAgAuggAiPggDggAgAuhgAiPggDfgAgAuggAiPggDdgAgAubgAiOggDe
					f4fzudgAiNggDpfgfJuxgAiNggDyfMenu9gAiMggDtfLelu1gAiLggDlfPeuumgAiMggDjfYe9ukgAiOggDsfhfLu3gAiRggD5fofWvPgAiSggD/frfbvbgA
					iTggECfrfbvggAiTggEGfrfavngAiUggELfsfavvgAiVggEQfsfav5gAiWggEWfsfawDgAiXggEbfsfawLgAiXggEffsfawSgAiYggEhfsfawWgAiYggEifs
					fawYgAiYggEhfsfawWgAiXggEcfsfawOgAiUggENfsfav0gAiRggD2fufgvKgAiOggDef1fuucgAiMggDNf9f7t8gAiLggDHgAgAtugAiKggDEgAgAtngAiK
					ggDBgAgAtjgAiKggDBgAgAthgAiKggDBgAgAtjgAiKggDEgAgAtngAiLggDHgAgAtugAiMggDLgAgAt3]],
				Spine = [[
					gAi2gAEXgAgAwFgAi3gAEigAgAwYgAi4gBEsgAgAwpgAi5gBE0gAgAw3gAi5gBE6gAgAw/gAi6gBE8gAgAxCgAi5gBE6gAgAw/gAi5gBE0gAgAw3gAi4gBEy
					f3fzwygCi4gCE5fbfMw8gDi4gDE8fGerw/gDi3gCEyfFepwtgDi1gCEjfKeywXgCi2gBEdfUe/wNgCi5gCElfefNwbgBi9gDEyfmfYwxgBi+gEE6fpfcw/gB
					i/gEE/fpfcxIgBjAgFFIfpfcxVgBjBgFFTfpfcxmgBjCgFFffpfcx4gBjDgGFrfpfcyKgBjEgGF3fpfcybgBjFgHGAfpfcyngBjFgHGGfpfcywgBjGgHGIfp
					fcyzgBjFgHGGfpfcywgBjEgHF+fpfcykgBjBgFFofpfcyFgBi9gDFHfrfixUgBi4gBEmf0fvwfgAi1f/EOf8f7v2gAizf/ECgAgAvhgAizf/D6gAgAvTgAiy
					f+D1gAgAvKgAiyf+D0gAgAvHgAiyf+D1gAgAvKgAizf/D6gAgAvTgAizf/ECgAgAvhgAi1f/EMgAgAvy]],
				Neck1 = [[
					gAjgfoFbgAgAxygAjhfpFjgAgAx+gAjjfqFqgAgAyJgAjkfrFwgAgAySgAjlfsF0gAgAyYgAjlfsF2gAgAyZgAjlfsF0gAgAyYgAjkfrFwgAgAySgBjjfrF0
					foftyXgDjkftGOefewy1gFjjfuGidmd/zGgFjifsGbdid9y8gEjgfrGMdweLyqgEjgfqF9eJefyZgDjkfrFzele0yQgCjofuFwe6fEyOgCjqfvFxfBfKyQgC
					jrfwF1fBfKyWgCjsfxF7fCfJyegCjtfyGDfCfJypgCjvfzGLfCfJy1gCjwf1GUfCfIzBgCjyf2GcfDfIzLgCjzf3GifDfIzUgCjzf4GmfDfIzZgCj0f4GofD
					fIzbgCjzf4GmfDfIzZgCjyf3GhfDfIzTgCjuf0GXfCfJzEgCjpfvGEfKfSyrgBjjfqFrfffmyKgAjefnFWf2f5xsgAjcflFLgAgAxbgAjbfkFGgAgAxSgAja
					fkFCgAgAxMgAjafkFBgAgAxKgAjafkFCgAgAxMgAjbfkFGgAgAxSgAjcflFLgAgAxbgAjefmFSgAgAxm]],
				Neck2 = [[
					gAkAfaFvgAgAyQgAkCfcFzgAgAyWgAkEfeF3gAgAybgAkFffF6gAgAyggAkGfgF8gAgAyigAkGfgF8gAgAyjgAkGfgF8gAgAyigAkFffF6gAgAyggBkEffGF
					fafmyvgDkFfiGzdmeUzegFkFfkHccKdQz8gFkDfiHacDdOz4gFkBfgHKcadizqgEkBfeGwdCd+zTgDkEffGTdueay1gDkJfhF9ePevycgCkLfjF2ebe3yTgC
					kLfkF4ebe2yWgCkNflF7ece2yagCkOfnF/ece1yggCkQfpGDede1ymgCkSfrGHede0ysgCkTfsGLeeezyxgCkUfuGOeeezy1gCkVfvGQefeyy4gCkVfvGRef
					eyy5gCkVfvGQefeyy4gCkUftGPeeezy2gCkQfqGQede0y4gCkKfkGNepfBy1gBkDfeGAfMfdymgAj/fZFwfxf2ySgAj8fXFngAgAyEgAj7fWFkgAgAyAgAj6
					fVFigAgAx9gAj6fVFhgAgAx8gAj6fVFigAgAx9gAj7fWFkgAgAyAgAj8fXFngAgAyEgAj+fZFrgAgAyK]],
				Neck3 = [[
					gAkZfRGDgAgAytgAkbfTGDgAgAytgAkcfVGDgAgAytgAkefXGDgAgAytgAkffXGDgAgAytgAkffYGDgAgAytgAkffXGDgAgAytgAkefXGDgAgAytgBkdfXGX
					fMffzFgDkefcHbctd30GgFkfffIcavcj0sgFkdfdIgamch0ugEkbfaIObFc60mgEkafXHob7dd0KgDkefXG1c3eAzYgDkhfZGLdkeaypgCkjfaF7d1ekyWgC
					kkfbF7d1ejyWgCklfcF7d2eiyWgCknfeF7d3ehyWgCkpfgF7d4egyWgCkrfiF7d4efyWgCksfkF7d5eeyWgCktfmF7d6eeyWgCkufnF7d6edyWgCkufnF7d6
					edyWgCkufnF7d6edyWgCktflF9d6eeyZgCkpfiGLd3egyrgCkjfcGWeJexy+gBkcfVGVe5fTzBgAkXfQGLfrfzy3gAkVfOGDgAgAytgAkTfMGDgAgAytgAkS
					fLGDgAgAytgAkSfLGDgAgAytgAkSfLGDgAgAytgAkTfMGDgAgAytgAkVfOGDgAgAytgAkXfPGDgAgAyt]],
				Head = [[
					gAkyfJACgAgAgzgAk0fLACgAgAgzgAk1fNACgAgAgzgAk3fOACgAgAgzgAk3fPACgAgAgzgAk4fQACgAgAgzgAk3fPACgAgAgzgAk3fOACgAgAgzgBk2fQAF
					fDejhBgCk4fWA1cVaChXgDk5fbCCabWZhRgDk3fZCIaSWMhRgDk1fWBwatXKhVgDk0fSBObJY8hVgDk3fRA0bRa3hNgCk6fQAsbPbphCgCk8fRAxbNbJg6gC
					k9fSA3bOaig2gCk+fTA3bPaig2gClAfVAxbQbIg5gClCfXAobQcFg/gClDfZAibRdDhFgClFfbAebSdphIgClGfdAebTdphIgClHfeAhbTdChFgClHfeAobU
					cEg/gClHfeAwbVbGg5gClGfdA1baajg2gClCfaAub2a4g+gCk8fUAbc3cNhHgBk1fOAJeXeChEgAkwfIACfmfcg5gAkufFACgAgAgzgAksfEACgAgAgzgAkr
					fDACgAgAgzgAkrfDACgAgAgzgAkrfDACgAgAgzgAksfEACgAgAgzgAkufFACgAgAgzgAkwfHACgAgAgz]],
				Jaw = [[
					gAlBel/xgAgAjsgAlDen/vgAgAkCgAlEep/sgAgAkWgAlGeq/qgAgAkmgAlHer/ogAgAkwgAlHes/ogAgAkzgAlHer/ogAgAkwgAlGeq/qgAgAkmgDlGes/r
					gthlkIgMlKe1/CivmejXgTlMe992kLqTi9gTlKe79wkSqhi8gRlHe2+JkApgi7gOlGex+pjvnujVgKlIeu+7jxl5kSgIlLet+5j0lOlOgJlMeu+vjrlxlpgK
					lNev+ojimWlsgKlPex+ojhmWlsgJlQey+vjolxlqgHlSe0+5j1k1lmgFlTe2+8j+j7l3gDlVe4+9kEjYmIgDlWe5+6kBjamXgFlXe6+0j2kBmkgHlXe7+rjm
					k9mrgJlXe7+ijXl5msgKlWe6+gjMmYmegKlSe3+yi+l5lsgHlMex/RiakTkogElFeq/qhViMjvgBlAek/xgUgojngAk9eh/xgAgAjsgAk7eg/xgAgAjsgAk7
					ef/xgAgAjsgAk6ef/xgAgAjsgAk7ef/xgAgAjsgAk7eg/xgAgAjsgAk9eh/xgAgAjsgAk/ej/xgAgAjs]],
				Crest = [[
					gAnLe9bugAgA/tgAnNe/brgAgA/sgAnPfAbugAgA/tgAnQfCb2gAgA/ugAnRfDcBgAgA/vgAnRfDcQgAgA/xgAnRfDchgAgA/zgAnQfCcxgAgA/1f5nQfFdO
					edgy/0flnPfKd1Zpi+/IfZnLfGd/V1kf97fYnJfDeCVoko92fanIfDeBWpkT+OfcnIfCd1YckC+vfbnLfBdfaVkG/HfanOfBdFbFkM/MfanQe/ctaikG/Ffb
					nRe/cbZ6j9+8fbnSfAcMZ4j5+7fanUfDcDacj8/AfZnVfHcAbYkE/IfYnXfMcCcVkN/PfYnYfPcHc7kT/UfYnafQcPc8kS/VfZnafQcXcYkN/SfanbfOchbc
					kF/NfbnbfMcsahj+/FfdnafKc7aBj4/CfgnXfJdPabjh/LfnnTfIdib4is/gfznOfDdld3ha/zf9nKe9dcfZgW/4gAnHe5dTgAgA/4gAnGe3dMgAgA/3gAnF
					e2dAgAgA/2gAnFe2cxgAgA/1gAnFe2chgAgA/zgAnGe3cQgAgA/xgAnHe5cBgAgA/vgAnJe7b2gAgA/u]],
				["Ribbon1.L"] = [[
					f2oNiskZeIf1/of2oQitjgeEf5/vf2oRivixd3f//zf2oQixiRdkgG/0f2oOiziEdMgN/zf2oLi0iLcygU/wf2oHi1ikcXgY/rf2oCi1jOb+gZ/kfWn6i3kY
					aWhZ/Jd5nkiol5WMkj9hc6nPiEm0TMnB7oc2nLiAnqTTnU7YdFnPiJobUdmy7zdenXiYpGWYmA8fd4njikpxYnlc9DeAntimqFaAlS9Sd4n0igppaJld9bdw
					n4ibopZ/li9sdvn9icnaaNlZ+Gd3oCiimEa1lH+jeDoGirksbnk0+9eQoJi0jacPkq/PeYoKi5iUcVkp/WeZoKi7hhbvkv/UeRoIi5hGafk5/HeFoEi0hFY5
					lF+wd5n/ithhXYlR+Ud0n6ipidWblZ98d+n1irj8WklB95ecnyiylcX2j1+NfHnxi1mbZoiA+nfpnxixm+a/gd+0f2nxitnjbqf2+yf2nxiroCb+fx+tf2nz
					iqoPcWft+sf2n3ipoJcyfs+xf2n7ipnxdNft+6f2oAipnIdlfu/Ff2oFipmTd4fv/Sf2oJiqlXeEfy/e]],
				["Ribbon2.L"] = [[
					fvn8jprxfXfB9ufvoCjrqQfhfD+SfuoGjuowfbfL+wftoHjwncfIfY/GfroGjxmcepfr/TfqoCjyl4eAgA/Yfon9jylydSgV/Wfnn1jxmMcjgm/MfBnojxnV
					aoh++ndYnJjYo9Wfls8pcTmtiqqKTooq6TcSmmikroTwpF5mckmoivtMU6of5ldDmwjCuxWxnc5ydjm7jRwiY/mZ5sdxnFjVx+atlx5SdpnMjQyVbklx5Ldg
					nUjNxucIl05tdfndjRwjc5lh6pdnnnjau4d4k77zd1nxjms0e3kR8+eDn5jwqgfijz9+eLn/j3oLfijr+teJoBj5mEerj3/Jd8oAj1kadCkR/Qdqn7jtjXa6
					ky/Cdan0jjjEY0lX+jdSnrjcjrXSl49/ddngjelkW7l49leAnZjmn+X1k39fewnXjqp8ZQi99gfXnWjnrVaRhP9VflnUjkspavgf86fnnTjht5bDgP8YfonU
					jgu1bkf+8AfqnXjfvXcPfu7zfrndjgvdc/fg72ftnkjhvGdwfU8HfunsjjuUecfK8jfvn0jmtLfAfE9H]],
				["Ribbon3.L"] = [[
					frnQkXzTfleO5dfrnbkexzgFeB6gfrnkkkwFgUd/7kfpnqkpuUgReJ8ifmntksssf+ed9VfinrktrXfbe694fenmktqgesfd+LfandkrqMd1gC+PeunKkmqv
					b2h59yc8mikCr1XxmU72b2l+jKsrU3p05Wb4lyjAuMUyqg4NcOlyjKwFVtqB3oczl3jcyFXNo73OdamAjo0ZY/ns2VdtmIjp2nafmv04dpmPjk36bpmZzzdg
					mYjk4OcymGzudgmkjt37eGlZ0ddomyj+2+ffkU11d3nCkR1XgzjJ3meGnSkizIhyiP5feNngkuwciFh37TeHnpk0tnhciD81dzntkyq8f3ir98dZnrkposdp
					jg+fdAnkkcnIbRkb+gc0nXkRmpZWlU+HdAnFkQn6Yjly9idmm3kWqRY/lN9AebmwkYslZ6jk8jfDmskTuVaciC7/fTmmkMv9ahha7JfVmhkGxraihN6EfYmg
					kCzLa2g45EfcmikA0Wbcgd4QfgmnkB1GcOf+3wfjmvkE1XdIfd3ofnm5kJ1JeDe+36fpnEkQ0ce5ej4i]],
				["Ribbon1.R"] = [[
					gKoNiskZh4gL/ogKoQitjgh8gH/vgKoRivixiJgB/zgKoQixiRicf6/0gKoOiziEi0fz/zgKoLi0iLjOfs/wgKoHi1ikjpfo/rgKoCi1jOkCfn/kfqn7i5kK
					jAgy/keKnoivk/fDkP/TdInViPlWb2m++edFnRiLmGbznh+NdUnUiTm9crnO+MdvndignyeSmp+QeJnoiqokf9mS+LeSnzirpBgRmO+DeKn5imowfEmX+FeB
					n+iin8dumW+PeBoCiim3dBmK+feIoHiolndDl1+zeVoLiwkTdrlf/IeioOi3jBeilM/YeqoQi8h3fRk8/ieroPi+g9fmks/oejoNi9gafhka/reXoJi5gSfM
					kL/teLoFizgne8kE/teGoAivhcfIkG/reQn6ixi6gAj//meun1i3kmhfjR/dfanzi3l+jEh1/Of9nyixm3kEgj++gKnxitnjkWgK+ygKnxiroCkCgP+tgKnz
					iqoPjqgT+sgKn3ipoJjOgU+xgKn7ipnxizgT+6gKoAipnIibgS/FgKoFipmTiIgR/SgKoJiqlXh8gO/e]],
				["Ribbon2.R"] = [[
					gRn8jprxgpg/9ugRoCjrqQgfg9+SgSoGjuowglg1+wgToHjwncg4go/GgVoGjxmchXgV/TgWoCjyl4iAgA/YgYn9jylyiufr/WgZn1jxmMjdfa/Mf2nrj1nK
					i8gd/CeJnUjsoPfwkK+oc9m9jJo9dTnQ9uc6m2jEqPdvn99KdOm3jMrye5nx8rdvm+jYtXgsnK8KeQnIjhvGilms7SeanRjhwmi9m26UeNnYjdxKhjnh54d/
					nejZwyfuoE6Bd7nmjbv2eWoL6geBnvjjucdnn77UePn5jtsndene8UeeoCj2qddtnA9UeooIj8oKeAml+KeqoLj+l9eJmL+weioLj9kIeClr/JeUoIj5i5d5
					lG/YeHoCjzicd/ki/geDn6jvi9erkF/keRnujwkxgKjp/be2nkj0nQiKix+9fnndjxpij7hP+QgNnXjprOk8f49jgbnUjksplRfh86gZnTjht5k9fx8YgYnU
					jgu1kcgC8AgWnXjfvXjxgS7zgVndjgvdjBgg72gTnkjhvGiQgs8HgSnsjjuUhkg28jgRn0jmtLhAg89H]],
				["Ribbon3.R"] = [[
					gVnQkXzTgbhy5dgVnbkexzf7h/6ggVnkkkwFfsiB7kgXnqkpuUfvh38igantksssgChj9VgenrktrXglhG94ginmktqghUgj+LgmndkrqMiLf++PgCnPkuqn
					h/gz+GeNm1kkrVffkg9kc7maj+r6dqni8oc8mPj2tTeln+78dVmMj6vHgJnj7Kd9mPkCw+iVmp6MelmXkDzAkvl24neymdj91Elsl/2nejmij32cktnI1JeP
					mnj225jAoW0geFmwj82whdpE0heHm8kI2EgRpR1OeRnKkY0yfcpH2iefnZkny5e6o14Peonokzwbegon6Bennzk5tneCoa7oedn6k6qwdeoE87eOn7k3oRc/
					ne91eBn3kymjc5mo+cd/ntkul/dklo+0eUncktnRfRke+0fBnJktpvhmi6+Sf4m5kksRjpg39TgfmukXuQk5fL8NgtmmkMv9lfem7JgrmhkGxrleez6Egomg
					kCzLlKfI5EgkmikA0Wkkfj4QggmnkB1GjygC3wgdmvkE1Xi4gj3ogZm5kJ1Jh9hC36gXnEkQ0chHhd4i]],
				["Humerus.L"] = [[
					fGjdfrb9GYZ5xsfGjffscKGcZoxvfGjgftcVGgZYxxfGjhfucdGkZLxzfGjifvcjGmZDx0fGjifvclGnZAx0fGjifvcjGmZDx0fGjhfucdGkZLxzfHjhftcf
					GaZOxmfJjhfscyGCZBxBfLjgfrc9FuY6wifLjffpcyFpZKwefKjdfochFpZhwjfKjdfpatGeZnxZfJjhfrXJI2ZuzNfIjlfuUNLraQ06fIjnfvTNM+aj1nfI
					jofwTQNCaX1qfIjpfxTUNKaG1ufIjqfyTZNTZw1zfIjsf0TfNeZY15fIjtf1TmNqZA1/fIjvf2TrN1Yr2EfIjwf3TwN9Ya2IfIjwf4TzODYP2LfIjxf4T0OF
					YL2MfIjwf4TzODYP2LfIjvf3UANmYW19fIjsf0VdLkYX04fIjmfwYBI9YszXfHjgfsamHDZcyHfGjcfqbyGTaHxmfGjafobmGQabxnfGjZfnbdGOaoxkfGjY
					fnbYGMawxjfGjYfnbWGLazxifGjYfnbYGMawxjfGjZfnbdGOaoxkfGjafobmGQabxnfGjcfqbxGUaLxp]],
				["Forearm.L"] = [[
					dtkNfJfoVvZx9pdtkPfMf8VzZq9pdtkRfOgOV3Zj9pdtkTfPgdV6Ze9pdtkUfQgmV8Zb9pdtkUfRgqV9Za9pdtkUfQgmV8Zb9pdtkTfPgdV6Ze9pdukSfNgc
					VrZh9kdxkSfIgyVBZh9Ud1kSfEg+UeZh9Hd1kPfBgrUYZo9Gd0kNe/gQUcZw9Kd0kTfFdfTFYw8Pd4kjfVX/QCYI5Vd+kxflUMNTZt2OeBk3fsTSMOat1CeB
					k4fuTVMTai1FeCk6fwTYMaaQ1JeDk8fzTdMkZ61OeFk/f2TjMuZh1UeGlBf5ToM6ZJ1aeHlDf8TtNFY01feIlFf/TxNNYj1jeJlGgAT0NTYY1meJlGgBT0NV
					YU1neJlGgAT0NTYY1meHlEf9UBNfYU12eAk6fwVyO5Xe3hd3kpffZhRSXQ6OdwkWfPdgT9Yl8ldtkLfHfUVjZ19ldtkIfFfBVnZ+9odtkGfDeyVkaD9ndtkF
					fCepViaH9ndtkFfCelVhaI9ndtkFfCepViaH9ndtkGfDeyVkaD9ndtkIfFfBVnZ+9odtkKfHfTVrZ49p]],
				["WingFinger1.L"] = [[
					cvkcgcopnclG9ccvkdgfo9nZlL9WcvkdghpQnWlP9RcvkegjpenTlT9McvkeglpnnRlV9JcvkeglprnRlW9IcvkeglpnnRlV9JcvkegjpenTlT9McukdggpW
					nGlX9RcukcgYpZmYlr9XcvkbgRpVl0l49dcvkbgOpCl1l09kcvkagNormDlq9qctk0gLl/iBh6/Tcylmf9eOXvcK+nc4l/fqXhOTbQ4zc5mDfkVwK+bq1Yc6
					mFfmViLKbG1Wc8mHfpVVLbaa1Uc+mLfuVILuZp1SdBmPfzU+MDY51RdDmSf4U4MWYO1RdGmVf9U1MnXt1SdImYgBU2MyXY1VdJmZgDU7M2XR1YdJmagEVDMy
					XY1bdJmZgDVOMmXu1fdHmWgCV8NKYH2ec/mJgIZsR7Yn7CczlmgSghaVbz/Mctk3gZmVi5hi/McvkcgZoTnSk99ncvkbgXoCnjk89ncvkbgVn0nlk49rcvka
					gUnqnnk29ucvkagUnnnnk19vcvkagUnqnnk29ucvkbgVn0nlk49rcvkbgXoCnjk89ncvkcgaoVnglB9i]],
				["WingFinger2.L"] = [[
					djjxhotVobhm7ydjjwhqtooahs7pdjjvhrt5oZhx7gdjjuhsuGoYh17adjjuhtuPoXh47VdjjuhtuSoXh57UdjjuhtuPoXh47VdjjuhsuGoYh17adijuhquB
					oLh87gdejshkuHniiW7mdbjsheuInAip7tdbjshdt2m/il73dcjuhctgnKiZ8Ac8kQhoq/iZfW98cBl3hUjCXCbG+Kbpm5gDbpNUbQ5JbpnAfdZjJ+b816bs
					nFfgZVKGbY12bxnLfkZGKRar1yb2nSfqY4KeZ41ub8nZfxYtKtZH1qcCnff4YlK8Ya1ncGnkf/YhLJX41mcJnogEYhLSXh1mcLnpgHYmLWXa1ocKnpgIYvLT
					Xi1rcInngHY7LLX41wcDnhgNZvLzYO2tb9nAg+d9QtYQ67cQlohxlWZqaZ+YdBkRh0rPjNe19wdhjzhmtBoNhf8Adjjzhlswodhb8Ddjj0hjsioehX8Kdjj0
					hjsZoehU8Odjj0hisWoehT8Pdjj0hjsZoehU8Odjj0hjsioehX8Kdjjzhlswodhb8DdjjyhmtBochg77]],
				["WingFinger3.L"] = [[
					eRiwiYx/p5ej4geRiuiYyPp6eq4TeRisiYyfp7ew4IeRiriYyqp7e13+eRiqiZyyp8e434eRiqiZy1p8e632eRiqiZyyp8e434eRiriYyqp7e13+ePiriXyn
					pwe+4GeKipiSywpNff4OeFioiOyzowf44WeFiqiOykoufz4jeGisiPyQo0fl4vdHjUiuwGjgdT7SbNlvihoHXQae9KaXndgdf9NIbX5aaWnqfadfJscO2eab
					nyfddRJvbp2Yain8fjdCJ0a72RapoGfqc0J7aI2KayoRfycoKFZV2Da5oaf7cfKPYo1+bAohgDcbKYYE16bEolgJcbKfXt14bFongNcgKiXm15bEomgOcpKh
					Xt18bAoigMc2KcYE2Ba4oXgZdwLKYY27a1nfhwigQTYK6obnlRjCqdZ3Zg84dQjUi5wRkOcr7BePiziYxuppee4xeRi0iXxep3eW43eRi2iXxSp2eS4/eRi3
					iXxKp1eO5FeRi3iWxHp1eN5HeRi3iXxKp1eO5FeRi2iXxSp2eS4/eRi0iXxep3eW43eRiziXxup4ed4s]],
				["Humerus.R"] = [[
					g6jdfrb95omHxsg6jffscK5kmYxvg6jgftcV5gmoxxg6jhfucd5cm1xzg6jifvcj5am9x0g6jifvcl5ZnAx0g6jifvcj5am9x0g6jhfucd5cm1xzg7jhfvcW
					5Umvx+g9jhfzcR42m1ylg+jhf2cK4em0zEg+jff1b+4hmjzDg+jefzby4tmPy4g9jefxaH4GmDzRg9jhfyWu19lz0ig8jlfzT7zVlN11g8jnf0S/yHk72Zg8
					jof1TByDlG2bg8jpf2TFx7lX2fg8jqf3TKxylt2lg8jsf4TQxnmF2qg8jtf6TVxcmc2wg8juf7TbxRmx21g8jvf8TfxInC24g8jwf9TixCnM27g8jwf9TjxA
					nQ28g8jwf9TixCnM27g8jvf8TuxfnH2ug8jrf5VLzjnL1ug8jmf0Xv2VnC0Lg7jgfuab4kmeyog6jcfqbv5ml4xwg6jafobm5wllxng6jZfnbd5ylYxkg6jY
					fnbY50lQxjg6jYfnbW51lNxig6jYfnbY50lQxjg6jZfnbd5ylYxkg6jafobm5wllxng6jcfqbx5sl1xp]],
				["Forearm.R"] = [[
					iTkNfJfoqRmP9piTkPfMf8qNmW9piTkRfOgOqJmd9piTkTfPgdqGmi9piTkUfQgmqEml9piTkUfRgqqDmm9piTkUfQgmqEml9piTkTfPgdqGmi9piVkSfRgV
					p4mh9uiYkTfagVpJmo97iakTfhgRojmq+GiakRfff9olmk+HiakOfbfno0mb+EiXkUfcc4qtnM9HiPkkfmXguand6OiHkxfyT5xplw3EiDk3f3TFy4kx12iD
					k4f4THy0k814iCk6f7TKyslO18iAk8f9TOyjlj2Bh/k+gBTTyYl72Hh+lBgETYyNmT2Nh8lDgHTdyCmo2Sh7lEgJThx6m52Wh7lFgKTjx0nE2Yh6lGgLTkxy
					nH2Zh7lFgKTjx0nE2Yh9lDgHTwxnnJ2oiEk6f7VdwHoE4PiNkpfoZMtxoi6uiTkXfVdVrcnb80iUkLfIfRqSmM9piTkIfFfBqZmC9oiTkGfDeyqcl99niTkF
					fCepqel59niTkFfCelqfl49niTkFfCepqel59niTkGfDeyqcl99niTkIfFfBqZmC9oiTkKfHfTqVmI9p]],
				["WingFinger1.R"] = [[
					jRkcgcopYka69cjRkdgfo9Yna19WjRkdghpQYqax9RjRkegjpeYtat9MjRkeglpnYvar9JjRkeglprYvaq9IjRkeglpnYvar9JjRkegjpeYtat9MjRkdgmpc
					Yea09KjQkdgypwX1bC87jPkdg7p5XTbN8wjPkdg5pnXNbT81jQkcg0pNXSbW9AjSk2grmIboeu/EjQlngWd+mbj0/CjMl/f9XTwhkY5mjLmDf1Vk0Hj72PjK
					mFf3VWz7kd2MjImHf6VHzrlJ2KjGmLf+U5zYl42IjDmOgDUtzEmn2GjAmSgIUmyxnR2Gi+mVgMUiygny2Gi8mXgQUiyWoH2Ii6mYgSUnySoO2Li6mZgTUwyW
					oG2Pi6mYgSU8yhnx2Ti8mWgSVqx6na3QjDmJgYZas8nG7mjNlnghgXkkkQ/YjSk4ghmXceep/IjRkdgcoWYjbI9kjRkbgXoCYdbE9njRkbgVn0YbbI9rjRka
					gUnqYZbK9ujRkagUnnYZbL9vjRkagUnqYZbK9ujRkbgVn0YbbI9rjRkbgXoCYdbE9njRkcgaoVYga/9i]],
				["WingFinger2.R"] = [[
					idjxhotVXlea7yidjwhqtoXmeU7pidjvhrt5XneP7gidjuhsuGXoeL7aidjuhtuPXpeI7VidjuhtuSXpeH7UidjuhtuPXpeI7VidjuhsuGXoeL7aicjvhvuD
					XbeU7YiYjuh3uRW0eo7FiUjth+uWWTe564iUjuh9uEWQe/7AiVjwh5ttWXfC7Pi1kSiFq6bYhq9qj2l5hyitnKlK+okYm6gdbaxgkl5/kcnBf0ZY1Gjy20kY
					nFf3ZJ0+kW2vkTnLf7Y400lC2rkOnSgBYp0nlz2mkInZgHYc0Ymk2ikCnfgOYT0JnP2fj9njgUYOz9nx2dj6nngZYOz0oH2dj4nogcYTzwoO2fj5nogdYczz
					oH2jj7nmgcYpz7nx2okAnggiZdzQne3ikAm/hUdquLno7jjqloiClJlRl1+li7kSh8rOcMhd9riejzhotCXoen79idjzhlswXjel8Didj0hjsiXiep8Kidj0
					hjsZXies8Oidj0hisWXiet8Pidj0hjsZXies8Oidj0hjsiXiep8KidjzhlswXjel8DidjyhmtBXkeg77]],
				["WingFinger3.R"] = [[
					hviwiYx/WHhd4ghviuiYyPWGhW4ThvisiYyfWFhQ4IhviriYyqWFhL3+hviqiZyyWEhI34hviqiZy1WEhG32hviqiZyyWEhI34hviriYyqWFhL3+htiriaym
					V6hW39hniqigyuVXhw3mhiipilyvU7iH3WhiirilyfU6iO3hhjiuijyMVCiR30igjWjJv3agkE67kglwjEnvnCmF9nlnneg+fuxrkq6Qlunqf4dV1Xjr3Ylp
					nyf7dF1UkP3Slin8gAc11Pk83MlaoGgHcl1Ilu3FlSoQgOcY0/mf29lKoZgWcO02nM23lDofgecJ0tnv2zk/ojgjcI0moF2yk9olgncN0joN2yk/okgocX0k
					oG22lDoggnck0pnv27lJoWg0dfz4ne3zlEneiLiMukn77RkMlRjVqNlIm59FipjUjAwNbQjt66hwiziaxuWOhq4thvi0iXxeWJhq43hvi2iXxSWKhu4/hvi3
					iXxKWLhy5Fhvi3iWxHWLhz5Hhvi3iXxKWLhy5Fhvi2iXxSWKhu4/hvi0iXxeWJhq43hviziXxuWIhj4s]],
				Tail1 = [[
					gAiNggiPgAgA/6gAiNggiPgOf+/6gAiOggiPgbf8/6gAiPggiPgof6/6gAiPggiPg0f5/5gAiPggiPg/f3/5gAiPggiPhIf2/5gAiPggiPhPf0/4gAiOggia
					hEf2/4gAiNggi6gYf9/2gAiNggjUfygC/0gAiMggjVfvgD/0gAiLggjPf2gC/1gAiMggjTgBgA/0gAiOggjtgLf+/xgAiRggkKgPf+/ugAiSggkWgKf//sgA
					iTggkWf+gA/sgAiTggkWfxgC/sgAiUggkWfjgD/sgAiVggkWfVgF/sgAiWggkWfHgG/rgAiXggkWe6gG/rgAiXggkWetgH/qgAiYggkWehgH/qgAiYggkWeW
					gI/pgAiYggkWeNgJ/pgAiXggkSeGgK/pgAiUggj7eBgN/rgAiRggjWeEgQ/wgAiOggiteTgS/1gAiMggiUejgR/3gAiLggiPetgQ/4gAiKggiPeygQ/4gAiK
					ggiPe5gP/5gAiKggiPfCgN/5gAiKggiPfNgL/5gAiKggiPfYgI/6gAiLggiPflgF/6gAiMggiPfygD/6]],
				["TailRib1.L"] = [[
					fyiGhjg8Xig0+0fziHhjhKYVgn/Cf0iHhkhfY6gZ/Kf1iIhkh6ZOgK/Nf2iIhkiYZQf8/Lf2iJhki3ZAfy/Ff3iIhkjTYjfs+7f3iIhkjrX6fs+uf3iHhkkF
					W8fx+af0iEhjkrVff592fxiBhik/UPgD9UfxiAhikzTngO9GfyiAhjkWTWga9DfyiAhjkATKgg9BfziBhjj1S6gf87fziChijeS/gd9AfziDhii6Togh9Wfy
					iDhiiXUngn9yfxiEhiiCVugr+OfwiEhhh9W2gr+lfviFhhiGX1gm+2fuiGhhieYkgZ/AfuiHhhjBY9gI/DftiIhgjsY+fz+/fsiIhgkcYkfg+yfriIhglMXy
					fS+efriIhgl5WufL+CfqiIhgmYVcfQ9gfqiHhgmPUHfn9CfqiGhgliTLgH8xfriFhhkmSwgl8vfsiEhij5Sjg58wftiEhijeSVhD8sftiDhijBSShK8ufuiD
					hiigSghO83fuiDhiiAS/hP9IfviDhihiTshO9dfwiDhjhLUlhL91fwiEhjg8VlhG+NfxiFhjg3Wmg++j]],
				["TailRib2.L"] = [[
					fbiDiKjCYRhK+3feiDiMjBZ4gw/PfgiDiMjRbRgU/efiiDiNjwcUf4/jfjiCiNkcc7fd/hfjiBiMlQdDfH/afiiAiMmIcse5/Nfhh+iLm+b6e0+7feh8iJn4
					aje9+gfYh4iFo7YifV9yfTh0iBpmWlfy9BfRh0iApoVMgN8hfRh0iApQUKgo8PfRh1iAo9TKhA74fRh3h/oxR7hX7UfSh5iAoIRDhr7CfTh6iBm9RPh27cfU
					h8iDlrSVh38TfWh9iFknT9hy9OfXh/iHj1V8hm+FfZh/iIjcYFhT+xfah/iJjcaJg7/Pfah/iJj3b4gd/ffZh9iIkrdFf8/gfXh8iHlydnfc/XfVh7iFnGdb
					fB/EfSh5iDofciey+nfOh3iApva9ey+BfLh3h9qSYvfL9ZfJh3h9qCWqf185fJh4h9pUVMgf8ofKh5h+ovUKhA8ZfKh6h+oYTMhb8DfKh6h+n2Sehy72fLh7
					h/nISIiC72fNh8iAmSSOiJ8GfPh+iClZSxiJ8ifRh/iEkjTviC9IfUiBiHj2VDh09wfYiCiJjUWnhh+X]],
				["TailRib1.R"] = [[
					gOiGhjg8oefM+0gPiHhjhKoGfV+7gQiHhjhgn7fg+9gQiIhjh7oBfr+6gRiIhiiaoVf1+ygSiIhii6o4f6+mgTiIhijXpmf7+VgTiIhijvqbf2+AgSiHhikI
					rEf09ugPiEhjksrNf99mgNiBhjk/rYgD9egNiAhjkyr6f59TgNiAhjkWsXfq9LgOiAhjkAs4fg9AgPiBhij1tafd8ygPiChijetcff80gOiDhii6sqfd9PgO
					iDhiiXrUfZ90gNiEhiiDp1fX+XgMiEhih+oTfX+1gLiFhiiIm4fe/KgKiGhiigltfr/YgJiHhjjCk4f//egIiHhjjskfgX/dgIiIhjkakigv/WgHiIhjlJk/
					hE/KgGiIhjl1l0hS+4gGiHhjmUm8hU+jgFiGhjmLoKhF+SgGiGhkldpQgp+IgHiFhkkiqIgK+AgIiFhkj0qzfx93gIiEhkjarTfi9vgJiEhki9rgfY9sgJiD
					hkidrefP9wgKiDhkh9rPfJ94gKiDhkhhq0fE+DgLiEhkhKqPfC+RgMiEhkg8pnfC+egNiFhjg3pAfG+r]],
				["TailRib2.R"] = [[
					gliDiKjCnve2+3gliDiLjBmjfK/KgliDiLjRllfi/VgmiCiKjxk7f5/YgoiCiJkekrgN/VgqiBiIlUk3gb/Kgsh/iGmNlegh+5gvh+iFnEmcge+hgwh8iDn9
					ndgX+Egth3iDo8oKgb9ngrh0iDpmpCgX9Jgsh0iCpnqWf+8tgth0iBpQrlff8Wgvh1iAo9s4e/73gxh3h+owuYei7Kgxh5h+oHvXeN6zgvh6iAm8vCeG7Tgs
					h8iDlstneJ8Vgnh9iHkprneS9Zgjh+iJj5pNeg+Wgeh/iLjfmne0/Fgah/iNjgkHfN/hgXh+iNj6h8fu/sgVh9iNkrgVgT/pgUh8iNlufcg7/dgVh6iMm+fU
					hg/LgXh4iKoVf9h9+1gZh3iJpjhYiM+bgch3iIqIjhiB+Egfh4iHp6lzhf90gih5iHpPnvgx9ogkh6iGoqpSgG9Xgmh7iFoWqjfk9Bgnh7iFn1rcfH80gnh8
					iFnHr+ew8xgnh9iGmSsGef86gnh+iHlZrzeW9MgniAiIkkrJeU9mgmiBiJj2qKeZ+DgliCiKjUo/el+f]],
				TailRibC1 = [[
					gAiEhpiIgAgA/6gBiEhpiAgOf+/7gCiFhpiIgbf8/6gDiGhpiigof6/4gEiGhpjJg0f3/0gEiGhpj7g+f0/vgFiGhpkxhGfw/ngGiGhplohNfs/egFiEhpmj
					hDft/TgCiBhpnpgXf5/Ef/h/hoobfzgE+3f/h+hoolfwgF+0f/h9hooWf2gD+4gAh+hooOgBgA+6gBh+hooTgLf9+5gBh/hnn8gPf8+/gBiAhnm3gJf+/PgA
					iAhnlgf+gA/gf/iBhnkRfxgC/tf+iBhnjTfjgC/0f9iChniqfVgC/3f8iDhnicfHgC/4f7iEhniqe6gC/3f6iFhnjSetgE/yf5iFhnkRehgH/qf5iFhnlgeX
					gM/ef4iFhnm2eOgS/Mf3iFhnoHeIgZ+4f3iEhnoveEgg+tf3iDhoooeJgl+vf4iDhooDeXgk+6f5iChpnlengg/Cf6iChpnYewge/Gf6iBhpm/e1gc/Mf7iB
					hpmYe8gY/Vf8iBhplofEgU/ef8iBhpkxfOgP/nf9iBhpj7fZgK/vf+iChpjJflgG/1f/iDhpiifygD/5]],
				TailRibC2 = [[
					gAh+iUg5gAgA/+gCh/iUf/gOf///gDh/iUfggcf+//gFh/iUfggof+/+gGh+iUf/g0f8/+gHh8iTg5g/f6/9gIh5iSiKhIf2/5gJh3iRjohOfx/wgHhziRlV
					hDfv/hgDhtiPnRgXf5/Jf/hpiOo5fzgE+uf+hniNpyfwgG+df/hoiOqJf3gE+VgAhoiOqngBgA+LgBhpiNrZgKf895gChqiOragOf695gBhtiPp+gJf9+ZgA
					hxiQntf+gB/Df+h1iRlRfxgC/jf9h5iSi7fjgC/2f7h7iSg6fVgA/+f6h9iSfcfHf9/+f4h9iSere6f6/8f3h8iReretf4/8f1h5iRfcehf5/8f0h2iPg6eW
					f8/7fzhziOi6eNgD/zfzhviMlNeGgO/gfyhtiMnLeDga/HfzhsiNoQeIgj+2f0htiOoleYgm+xf2huiPozepgk+uf3huiQpMeygi+nf4hviQpMe3gh+nf4hw
					iRoue+gd+wf5hyiSn2fGgY/Af6h0iSmofPgS/Sf8h3iTlLfZgM/kf9h5iUjoflgH/yf+h8iUiKfygD/6]],
				["UpperLeg.L"] = [[
					fUhzga63Y9e9v1fUh0ga6wZFfDwGfUh1ga6oZNfIwWfUh1gZ6iZTfNwifUh2gZ6eZXfQwqfUh2gZ6dZYfRwtfUh2gZ6eZXfQwqfUh1gZ6iZTfNwifUh1gZ6j
					ZGfWwcfUh0gW6YYpf6wifVhzgU6PYSgYwlfVhygU6XYJgVwVfVhxgV6jYHgHwAfVhygW6kYTf8wDfUh1gW6SYxf8wufUh4gW53ZTgExlfUh5gW5nZkgKyDfU
					h6gW5hZogNyNfUh6gV5YZwgTydfUh7gV5LZ5gayxfUh8gV46aFgjzKfUh9gV4oaSgtzlfUh+gU4Uafg30BfUh/gU4Carg/0afUh/gU30a0hG0sfUh/gU3ua3
					hJ0zfUh/gU30a0hG0sfUh+gU4Makg70MfUh8gV5DZ/gey9fUh4gX56ZZf8xjfUh0gY6lY/fYwWfUhyga69Yze9vofUhxgb7FYvezvWfUhxgb7KYpevvLfUhw
					gb7NYmesvDfUhwgb7OYlervBfUhwgb7NYmesvDfUhxgb7KYpevvLfUhxgb7FYvezvWfUhyga6/Y2e4vl]],
				["LowerLeg.L"] = [[
					fFhHf/xDg7g97CfFhHgAxQg3g366fGhIgAxcgygy6zfGhIgBxmgvgv6sfGhIgBxtgsgs6ofGhIgBxvgrgr6nfGhIgBxtgsgs6ofGhIgBxmgvgv6sfGhHf/xP
					gkg167fHhGf9wcf8hC7bfIhFf7vxfdhM7zfIhFf7vgfehQ79fIhFf6vafrhR8AfHhFf7vxf4hM70fHhHf+wqf7g+7SfIhIgBxqf3gs6qfIhJgCyLfxgi6UfJ
					hJgDyVfugf6NfJhJgEykfpgb6DfJhKgFy4figV50fKhKgGzRfZgO5ifKhKgHzsfPgG5MfLhLgJ0JfFf+41fLhLgK0ke8f24efMhLgM04e0fw4NfMhLgM1Aex
					fu4GfMhLgM04e0fw4NfLhLgK0WfBf64rfJhKgFzEfegS5sfIhIgBx1gAgo6jfGhHf/xDghg57DfFhHf+wxg6hC7NfFhHf+wshDhG7QfEhGf+wkhGhK7UfEhG
					f9wfhIhM7XfEhGf9wdhJhN7YfEhGf9wfhIhM7XfEhGf+wkhGhK7UfFhHf+wshDhG7QfFhHf+w2hAhC7K]],
				["Foot.L"] = [[
					fJgfgS/OhPfvm3fJgfgS/OhIfwm3fJgfgS/OhCfxm3fJgfgS/Og+fym3fJgfgS/Og6fzm3fJgfgS/Pg5fzm3fJgfgS/Og6fzm3fJgfgS/Og+fym3fJgfgS/P
					g3f0m3fJgfgS/Pgbf6m3fJgfgS/PgEf/m3fJgfgS/PgHf/m3fJgfgS/PgTf8m3fJgfgS/Pgcf6m3fJgfgS/PgYf7m3fJgfgS/PgMf9m3fJgfgS/PgDf/m3fJ
					gfgS/Pf/gAm3fJgfgS/Pf4gCm3fJgfgS/PfwgEm3fJgfgS/PflgGm3fJgfgS/PfYgJm3fJgfgS/PfMgLm3fJgfgS/OfAgOm3fJgfgS/Oe3gQm3fJgfgS/Oe0
					gRm3fJgfgS/Oe3gQm3fJgfgS/PfGgNm3fJgfgS/PfqgFm3fJgfgS/PgSf8m3fJgfgS/Pg3f0m3fJgfgS/OhQfum3fJgfgS/Nhbfsm3fJgfgS/Nhffrm3fJgf
					gS/Nhhfrm3fJgfgS/Nhifqm3fJgfgS/Nhhfrm3fJgfgS/Nhffrm3fJgfgS/Nhbfsm3fJgfgS/OhVftm3]],
				["UpperLeg.R"] = [[
					gshzga63nDhDv1gsh0ga6wm7g9wGgsh1ga6omzg4wWgsh1gZ6imtgzwigsh2gZ6empgwwqgsh2gZ6dmogvwtgsh2gZ6empgwwqgsh1gZ6imtgzwigsh1ga6r
					mohEwWgth0gc65mNhxwFgth0gd7Fl5iXvygthzgd7MmAifvigthygd7RmOidvVgthygd7KmUiLvhgth1gb6ymIhqwSgth4ga6Tl0hJxOgth5ga6Blog6xtgt
					h6gZ58lkg2x3gth6gZ5zlcgwyGgth7gZ5nlSgpyagth8gZ5ZlGggyygth9gY5Ik5gVzLgth+gY42ksgLzlgth/gY4mkggBz9gth/gY4akXf60Ogth/gY4VkU
					f40Ugth/gY4akXf60Ogth+gY4vkmgGzwgth8gZ5glMglylgth4ga6Pl7g/xSgsh0ga6vmohMwNgshygb6/nGhNvlgshxgb7FnRhNvWgshxgb7KnXhRvLgshw
					gb7NnahUvDgshwgb7OnbhVvBgshwgb7NnahUvDgshxgb7KnXhRvLgshxgb7FnRhNvWgshyga6/nKhIvl]],
				["LowerLeg.R"] = [[
					g7hHf/xDfFfD7Cg7hHgAxQfJfJ66g6hIgAxcfOfO6zg6hIgBxmfRfR6sg6hIgBxtfUfU6og6hIgBxvfVfV6ng6hIgBxtfUfU6og6hIgBxmfRfR6sg7hIgBxl
					e/fU6tg8hIgBxzeOfi6hg9hIgCx7dlfs6Yg+hIgCxxdefm6eg+hIgBxjdjfc6og9hIgBxhd2fa6rg8hIgCx8eVfm6bg6hJgEyke0f26Bg5hKgFy8fDf/5wg5
					hKgFzEfGgC5qg5hKgGzSfMgI5hg4hKgHzkfTgP5Tg4hKgIz6fcgY5Cg3hLgJ0Tfmgh4ug3hLgL0sfxgr4Yg2hLgM1Ef6g04Eg2hLgN1VgCg630g1hLgN1cgF
					g93ug2hLgN1VgCg630g2hLgL03f1gv4Pg4hKgHzufXgT5Lg6hJgDyhe/fy6Eg7hIgAxie4fT6ug7hHf/w7e7fB7Hg7hHf+wse9e67Qg8hGf+wke6e27Ug8hG
					f9wfe4e07Xg8hGf9wde3ez7Yg8hGf9wfe4e07Xg8hGf+wke6e27Ug7hHf+wse9e67Qg7hHf+w2fAe+7K]],
				["Foot.R"] = [[
					g3gfgS/OexgRm3g3gfgS/Oe4gQm3g3gfgS/Oe+gPm3g3gfgS/OfCgOm3g3gfgS/OfGgNm3g3gfgS/PfHgNm3g3gfgS/OfGgNm3g3gfgS/OfCgOm3g3gfgS/O
					e0gRm3g3gfgS/MeQgZm2g3gfgS/Kdxggm2g3gfgS/Kdoghm2g3gfgS/Kdngim2g3gfgS/Ld3gem2g3gfgS/NeXgXm3g3gfgS/Oe6gPm3g3gfgS/PfKgMm3g3
					gfgS/PfPgLm3g3gfgS/PfWgJm3g3gfgS/PfggHm3g3gfgS/PfrgFm3g3gfgS/Pf4gCm3g3gfgS/PgGf/m3g3gfgS/PgTf8m3g3gfgS/Pgcf6m3g3gfgS/Pgf
					f5m3g3gfgS/Pgcf6m3g3gfgS/PgMf9m3g3gfgS/PflgGm3g3gfgS/OfBgOm3g3gfgS/OetgSm3g3gfgS/NengUm3g3gfgS/NelgUm3g3gfgS/NehgVm3g3gf
					gS/NefgVm3g3gfgS/NeegWm3g3gfgS/NefgVm3g3gfgS/NehgVm3g3gfgS/NelgUm3g3gfgS/OergTm3]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAiCggDVhMh5t/gAiFggDTgIiVt7gAiOggDTfCiXt5gAiWggDVeHh/t7gAiXggDYdihRt/gAiSggDZdXgVuDgAiJggDYdqfWuEgAiCggDWeXeduBgAiCggDU
					fVd2t9gAiJggDTgcdnt5gAiSggDUhddyt5gAiXggDXiPeVt9gAiWggDYinfLuBgAiOggDZijgLuEgAiFggDXiDhIuD]],
				Spine = [[
					f8irgAEJhSh1vkf5iugAELguh/vof4i2gAEXgDh0v/f4i+gAEkfXhWwYf5jAgAErewgqwkf7i7gAEmeYf1waf/iygAEZeSfBwBgCisgAEMegeZvqgFirgAEJ
					e+eDvjgIiygAEQfneEvygJi6gAEegUeZwMgIjAgAEpg+e/whgGi+gAEqhefwwigDi3gAEghuglwPgAiugAEShphVv0]],
				Neck1 = [[
					f5jUfnFChYhwxDf1jXfnE9g8h3w9fzjgfoFNgXhpxZfzjofpFpfuhLyEf1jrfpF9fHgiyif5jmfpF8eofxyff/jcfoFneZfBx+gEjVfnFMeeecxTgJjVfnE9
					e1eKw7gMjbfnFDfWeOxHgNjlfpFbf9elxvgMjqfpF1gmfJyXgJjpfpGAhKf2ylgEjhfoFzhigoyRf/jYfnFZhnhUxn]],
				Neck2 = [[
					f4jzfYFMhZhvxSfzj3fYFAhEhwxBfwkAfaFUglhexkfxkJfcF8gCg+yhfzkMfeGffbgWzRf4kHfdGje4fozVf+j9fbGFeje7yqgFj1fZFceheaxsgLj0fYFC
					eweNxDgPj7fZFGfLeXxNgQkFfbFnfsexyCgOkLfdGQgSfVy+gLkKfeGlg3gAzZgFkCfcGXhVgvzEf+j4faFwhhhYyL]],
				Neck3 = [[
					f2kLfNFWhahuxifxkOfNFDhLhqxGfvkYfQFbg0hSxufvkifUGRgVgxy+fyklfXHCfwgKz/f3kgfWHLfJfg0Jf+kWfTGlese2zVgGkNfPFtejeYyEgMkMfNFH
					eseRxLgQkTfOFKfAegxTgRkdfSF0fae+yVgQkkfWGtf9fizkgMkjfXHNgkgL0MgFkbfVG9hHg2z2f+kRfRGJhbhbyt]],
				Head = [[
					f1kjfDAHgTiOg5fwkmfCAGg1iAghfukwfGAFhPhfgsfvk7fMAFhcgzhUfyk+fRAHhXgAh9f3k5fRAIhCfHiNf/kvfMAIgjeUh5gHkmfFAHf/d2hOgOkkfCAG
					fcd2gpgRkrfDAGe9ePgigSk2fJAFeoe2g+gQk+fPAGekflhqgMk9fSAHexgciJgFk1fPAIfMhUiHf9kqfIAHfvh+hk]],
				Jaw = [[
					fxkzef/3f4dxhqfsk1ee/2fWd8iCfsk/ei/3e5ebh8fulLep/5epfEh6fzlQeu/7epf3haf6lMeu/9e5gygxgDlBep/7fVhogqgMk2ei/5f2iJhVgSkyee/2
					gZiNh6gUk5ef/3g6h2iBgTlGel/4hRhSh/gQlPes/6hZgkhtgKlPev/8hRfshFgClHes/8g6exgif5k7el/6gbeEg+]],
				Crest = [[
					f2m9e3cmiPgA/uf2m/eycPiGfd/sf4nJe4cahpe+/uf8nUfEdCg/er/zf/nYfQdqgMep/4gBnTfSd6fRe3/5gFnJfKdmeafP/2gJm/e9c8d4fu/xgLm9ezcX
					dygR/tgJnEe0cQeHgz/tgGnPe9cserhN/xgDnXfLdYfZhY/2gAnXfSd3gRhS/5f9nOfPd0hMg+/4f5nEfEdSh7gi/0]],
				["Ribbon1.L"] = [[
					gPnyioiogufa/3gNn5iigcfBfm/+gKoAiphrcyfe/ygDoCi4lbbLew/If5n9jFpRa/eR+Kfun1jHqtb7eq91fknvi9oxc1fY+mffnvitkrcxf6/ffen1ihhN
					bugs/rfhn8iigzaZhu/cfmoBiujwZxiD/Ffun/i/n+aphX+ef5n3jIqsc4gf9/gFnwjFqNfZf7+UgMnui3m0g7fi/P]],
				["Ribbon2.L"] = [[
					gRnnjnori3dt+kgJn4jijQgxer/yf9n6jnjAdOfz/ufwnujxoAZ/f3+Yflnbj3uvZAfG7gfdnOj3y0a2ey5UfXnOjyx8dme/6XfSndjpsbe8fK9cfOnvjflo
					eAf3/bfLn4jeigbrhn/jfPnwjolWZji++ufbnfjzsBZRib8xfunPj5xvbngh6QgCnKj4zEfWez5pgPnTjxvbiUd072]],
				["Ribbon3.L"] = [[
					ganFkdw3jmbP6hgMnqkgpCiWcZ+Yfynuklluepeu/bfZnQklpaaXgZ+DfLmpkWxNX3gl5tfJmTkH3gZJf20mfNmTkJ49c2e7zufNmvkV1AfseI4DfGnZkatH
					f3eS9Ie7ntkbmtdogR/Me4nakfnCati1+ofGmykbttZDjk71fhmVkP1ZaMhn3Af9mNkK5Bd1ehzwgTmdkT3UhtcG1f]],
				["Ribbon1.R"] = [[
					ginximirjrfx/qghn4iggik+ey/kgdn/inh8mEd//SgXoAi3l5mAeN+0gNn7jFprkXfH+KgBnzjIq4h1f1+Bf3nui/oyfqgT+wfynvivkoe9gl/ofyn1ikhJ
					gAgh/9f0n9ikgoiGgZ/6f5oCiwjXkLg2/hgBoAi/nhlHhl+ogMn5jIqZkoho92gYnxjDqJjjg++Hggnui1m1jDgW/G]],
				["Ribbon2.R"] = [[
					gwnnjjo4hRgo+tg0n1jcjXjGfW/qg0n2jijNlidi/Qgsnojuogm7dD96gcnWj3vSl3ee7cgHnLj5zCikgc5kf2nNj1x0e9hy6ffundjssNdDiY9Vfynxjjlf
					d6h7/Yf9n7jjiYg8gt/4gKn1jslAkkgB/RgWnlj1rdm5gg9EggnTj3xUmXhK6HgmnMj1zCjuhI5agsnUjuvohdg773]],
				["Ribbon3.R"] = [[
					g2nFkZxTf3iA61hAnokapThDg8+lhJnokdl5j4eY/KhDnGkfp1mace9jgtmhkVx1mydJ5hgRmOkL34kMf804f2mRkN41gHi2z+fnmvkZ0kdAkk34frnbkfsv
					cokc8zgBnxkimifTif/NgcnikmmwjkgS/Egwm7kftJnSfW8Pg3mbkN01n/fv27g1mQkG46lHgozagzmekP3phehh1c]],
				["Humerus.L"] = [[
					fAjSfyZkTUiu8he8jUfyZSTLiM8ce6jafxZXSuhi8Se6jhfvZoSDg+8De7jjfsZ1RQgu7se/jefoZ0Qdg17PfFjWflZmPzhS6zfKjRfiZbPdh66gfPjSfiZh
					Pbig6dfSjbfkZ9Psi86sfTjmfnakQMjJ7FfSjtfrbCQ3jM7jfPjrfubGRrjL8AfLjjfwavSejI8VfFjYfyaITFjB8g]],
				["Forearm.L"] = [[
					dxjxgycAdknu+sdtj2gxb2dXnK+ydpj9gtcAcymo+3dnkEgpcQb9mQ+4dlkEghcUbCmJ+ydmj/gZcDaLmU+kdoj2gQbjZkmt+SdsjvgLbGZTnP+CdwjugLbB
					ZWn194d0jzgPbZZqoW93d2j6gXcDaKos9+d4j/ghcqa2o0+Id4j/gpc8btow+Ud3j5gvc0cmoi+ed1jzgycZdSoM+m]],
				["WingFinger1.L"] = [[
					dbkHiXe5r1pd8KdWkMiVewrpox8cdPkSiRfqq5o+8tdIkWiLg6pxpw81dBkViChkoqqi85c8kQh3hFn7qx9Cc6kJhsfnnpqX9Sc8kDhmeAntpx9Zc/kBhldI
					n7pr9TdFkEhsdfoOqa9AdLkIh2e3oirr8gdSkLiCgco+st79dYkKiMhTpps57ndckHiUhCqjsJ7odekFiXf7raqy74]],
				["WingFinger2.L"] = [[
					ebkjjgiNszlm8seWknjfiIsgk789eNkojfjHr2lN9FeCkkjdkdq9mI9Fd2kfjYlMqBnD9GdskbjQkypSnY9UdmkbjGjZo2nB9vdlkdi+h0osmb+Ddokhi9g6
					o1mT+FdvkkjChNpQnB9yd5kijNifp3oP9MeFkfjXj7qjpO8feQkbjfksrTpV8CeZkbjjkWsFod8DedkejjjOspm+8X]],
				["WingFinger3.L"] = [[
					fgklkflsuMhp8DfZknkelst0hB8RfOkikgmttSha8SfBkZkhoFsoif8KeykQkeo2r5jj8IekkOkZoirNj+8deakTkTnRqojn9EeWkekNlxqSjA9leZkmkLk5
					qWi29vejkpkPlFq5jg9cexkkkXmLrwks8ufCkckdncsqlo73fSkXkhoEtelq7SfdkXkintuEkq7SfikekhmouVjF7q]],
				["Humerus.R"] = [[
					gzjRfiZbwndy6cgvjWfjZtwedQ6jgtjhflaRwGc863gtjqfpa1vgc07UgvjtftbIuwc17ygzjofva+t7c28Mg4jdfxactMc68cg9jVfyZ0sxdG8hhCjSfyZY
					sudh8fhFjXfxZStBeJ8YhHjefwZftmey8MhGjjfuZwuWfN75hDjhfqZ2vKfR7eg+jafmZuv6e+7Ag4jTfjZfwbeb6n]],
				["Forearm.R"] = [[
					iSjtgKbAmuYe98iOjvgMbKmhX693iLj2gTbtmHXd96iJj9gccYlhXO+DiIkAglc3kvXN+OiIj8gsc7j2XW+ZiKj2gxcojBXo+iiNjygzcLihYC+piRjzgyb4
					ifYk+viVj5gvb5i5ZI+1iYkBgrcIjoZm+5iakFglcUkhZ2+2ibkCgdcOlbZ0+riZj6gUb0mLZh+biWjygNbTmoZD+J]],
				["WingFinger1.R"] = [[
					jDkChldbYNWY9Yi+kChodJX8WE9Li4kGhweFXoU/8xixkKh8fsXSTv8OirkLiHhAWvTF7vilkJiQhUV7TY7liikGiWgiVAUg7vijkGiXfVUUV88BinkJiWes
					UMXA8TitkPiTfHUrXP8li0kViOgTVpWr8yi7kWiHhXW0V083jBkTh9heXxVR89jFkMhygbYRVY9KjFkFhoexYXV99X]],
				["WingFinger2.R"] = [[
					iakfi9hOXSZv+HiVkji/g6W/Zd9+iMkjjHhxWdYZ9hiBkhjSjPV0XM81h1kdjbkcVFWm8NhrkbjhkqUTXA7/hlkcjjj2TnYQ8MhjkhjhipTPZy8ihnkljfiB
					TTa381hukojfihTybD9Ch4kmjfjzUlaY9GiEkhjbk8ViZY9EiPkcjVlJWZYt9LiXkajLkLW/Yv9hibkcjCikXRZT97]],
				["WingFinger3.R"] = [[
					hpkjkLlNVvdL9thjkpkNk2Vcc79phXknkTlkUtb79IhHkgkam2Tyax8Sg2kZkfn3S7aO7ggokWkhoASNav7OggkakhnNRwcH7cgekhkfmFRtdt73gjknkelj
					R/ez8MgskmkfmGSce68Tg4kekhnaTCeH8OhHkUkgolTwc88HhVkOkco1UecJ8PhikQkWn+VHcJ8vhpkYkQmfVlct9X]],
				Tail1 = [[
					gAiCggiPjQfb/vgAiFgghiiYgy/2gAiOgghXhEh8/4gAiWggh0fmiw/0gAiXggimeQjI/rgAiSggjMdNjB/kgAiJggjNcmiX/jgAiCggiocihP/qgAiCggh2
					dIf5/zgAiJgghXeQen/4gAiSgghhfrdn/3gAiXggiNhHdA/wgAiWggi9iUc3/ngAiOggjSjLdQ/igAiFggi+jheK/m]],
				["TailRib1.L"] = [[
					gAh7hlg7dTgC/3f8iBhliWb9ge/pf3iJhkkUX9hm+nfxiOhjlmTgjG8vfsiMhhlIQmj07TfoiEhfjVQYjo7eflh8heheSrjB85fkh5hegxVxhz+Pfmh+hgha
					XZf7+xfriIhiiqWoea+bfxiRhjjfUmd99nf3iThkjLTTeB9Hf8iNhkh8UNeF9nf/iEhkgxXcek+ygBh8hkgZbUfd/o]],
				["TailRib2.L"] = [[
					f4h4iShzgQgD/8fxh6iQjxhffm/ufih8iKnedigV/AfSh8iAqsW1iq8mfIh6h3q1RAkz5qfDh3h2n5OylU5OfDh0h8kDROkZ7vfJh1iDhwW8ib+ifPh6iHih
					bzfs/nfRiCiHlfcPdb/LfSiJiEoWYkc/90fViNiDpEUBeA8LfciKiFnMSIfD75foiDiLkUUtfp9nf0h7iQiKasgH/e]],
				["TailRib1.R"] = [[
					gbh6hfg9pIfG+ogYiChhiBovg9+sgSiNhjjMqXh8+CgMiThkjfsRiB9RgHiRhkioslh+9OgCiJhkhSqahx+LgAh/hkgdmjhA/Sf/h6hlgjjVgN/0gBh9hlhh
					i9fz/0gGiFhljUl2fF/RgMiMhklJqXdo9vgSiOhilluQca73gWiIhgkUv4cN7Lgah/heiUutcp8Hgch5heg8rudf9p]],
				["TailRib2.R"] = [[
					g0h3iFhwmPe6/Tgwh+iHj3jXhn/iguiGiGnFlQjD+mgtiMiDpEp2in88goiMiDoYtcha7wgfiHiIlwtKgo8lgSh+iOjEoigH+rgJh5iRhtiMf1/3gKh5iRif
					edgO/2gWh7iOlgf8gS/ggnh9iFpVlteo+Cgzh7h7rOsZcH6/g7h5h1powrav5Ag+h1h4l7wkbB6Pg6h0h/iksHce9S]],
				TailRibC1 = [[
					gPh4hogijSfm/0gLiAhpiRiZgu/0gFiJhplrhUhy/af/iOhpofgMix+uf5iMhoo3e6jb+if0iEhnmmdjjT/Cfxh7hnjIcliW/kfxh3hngwcehC/xfzh7hohF
					dIf1/2f4iFhpj5eJew/rf+iNhpnTfQdt/DgEiOhppCgbc1+hgKiIhooAhyci+ugNh/hnk4jCdG/VgPh4hnhrjmeU/s]],
				TailRibC2 = [[
					gYh3iScljTgB/ogSh6iTdiiQhE/zgJh6iSjGhKh4/wgBh4iPpcgRix+cf5h1iNsUfUjh9TfwhyiOqId8jk+EfphyiQkHcqid/dfnh1iReKcZgv/ufrh5iTcX
					dLfZ/pfyh6iTf7eUei/6f7h6iQmefTds/PgDh3iNrfgLc09sgMhziOr2hVcV9dgUhxiPnaiyc3+1gZhziRg1jpea/u]],
				["UpperLeg.L"] = [[
					fThpgg4TZ5dezvfVhpgg5hYMdExZfXhvgf6yW8dEurfYh1gd8QWDc6qyfZh3ga9VVocpmqfZhygY90Vocnj5fYhrgW99V1dHjtfWhngU9sWReRmofUhqgU80
					WxfdqXfTh0gV7iXogXt9fRh/gW4kaKiNzhfQiGgZ3QbuiT1bfQiEgb2lcphr2WfQh7ge4bbEfG0DfRhvgf47aJdpzC]],
				["LowerLeg.L"] = [[
					fAg4gUpPjlfH+Ze/g9gLkHjxe1/efBhJgBi7jGeg/rfEhYf0laiFed/bfHhmfqqAg8ey+WfKhpfluhfzff8gfLhifixxe1gd6kfKhUfk0FeKhe4yfJhLfq0m
					eMiH4UfHhLf00jetiP4YfLhLgJ3heLgm1mfMhQgU3jevfn1nfMhOga2xfie42cfEhIgSxdiOf+6ufAg/gQskjqf79M]],
				["Foot.L"] = [[
					fJgfg4/Hi6fXm1fJgxg1+mjNfGosfJhAgr+QiffLqDfJhJge+Ehcffq0fJhLgO+Cgdf1q/fJhGf/+NfqgIqifJg5fz+ifIgRpffJgpft+/fAgQn2fJgffx/P
					fYgJm3fJgff7/Pf5gCm3fJgfgF/OergTm3fJgkgQ+0esgOoffJgiga/AfHgJn1fJgfgk/Mh6flm2fJgfgu/FjPfTm1]],
				["UpperLeg.R"] = [[
					grhngU9JpQgzpYgthugU8To8gKr8guh5gV6dnee+wUgviDgX3lkzdf07gwiGga27jzd/15gwiAgd3Wj+fm1ggvh1gf41lfhzzUguhrgg4vmEilzMgshogg49
					nDi2yggqhsgg6Gofi8wLgohyge7hpki/s2gnh3gc83qPjPopgnh1gZ9oqbjblBgohugX96qTjOjcgphogV96qAiakw]],
				["LowerLeg.R"] = [[
					g2hLfo1aiJeR3mg4hLfu0Shgds4lg4hLf81chReN3pg0hOgQ38hvgH1Jg0hQgX3Kg1gv2Cg4hLgX0qfLgp4Zg/hEgQu3c4f78JhBg7gSqpcNgc97hBg6gQmN
					cKg//IhBhCgGjBcghX/og+hQf7jxdYhk/ng6hgfvnmefhc/Ag3hpfnsYfpg79eg2hnfjwUgugE7gg2hcfiy9hjfB5s]],
				["Foot.R"] = [[
					g3gffs/OhFfxm3g3gff2/PgRf8m3g3gfgA/PgTf8m3g3gigL+9hnfsn4g3gkgV+0hDf2ofg3gfgf/PflgGm3g3gfgp/HdOgnm1g3gfgz/Ecvgum1g3gpg3+1
					cwg1n0g3g5gx+adFg6pcg3hGgl+JeCgsqhg3hLgW+CfFgWq/g3hJgG+Gf+gBq1g3hAf5+WgqfyqFg3gxfv+wg+fuov]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAkcgg//gAgAgSgAkhgg//gAgAf9gAktgg/+gAgAfLgAk5gg/8gAgAeYgAk+gg/7gAgAeDgAk5gg/8gAgAeYgAktgg/+gAgAfLgAkhgg//gAgAf9]],
				Spine = [[
					gAkcfsAJgAgAi5gAkhfsAKgAgAi+gAkwfsALgAgAjLgAk+fsAMgAgAjXgAlEfsANgAgAjdgAk+fsAMgAgAjXgAkwfsALgAgAjLgAkhfsAKgAgAi+]],
				Neck1 = [[
					gAkke8A/gAgAn1gAkqe8BCgAgAn/gAk5e8BIgAgAoXgAlIe9BPgAgAowgAlOe9BSgAgAo6gAlIe9BPgAgAowgAk5e8BIgAgAoXgAkqe8BCgAgAn/]],
				Neck2 = [[
					gAk1edCDgAgArOgAk7eeCJgAgArdgAlLeeCWgAgAsAgAlbefClgAgAsjgAlhefCrgAgAsxgAlbefClgAgAsjgAlLeeCWgAgAsAgAk7eeCJgAgArd]],
				Neck3 = [[
					gAlGeKDfgAgAuegAlNeKDogAgAuxgAldeLEAgAgAvegAlueNEZgAgAwJgAl0eNEkgAgAwbgAlueNEZgAgAwJgAldeLEAgAgAvegAlNeKDogAgAux]],
				Head = [[
					gAlbd6ACgAgAgzgAlid7ACgAgAgzgAlzd9ACgAgAgzgAmEeAACgAgAgzgAmLeBACgAgAgzgAmEeAACgAgAgzgAlzd9ACgAgAgzgAlid7ACgAgAgz]],
				Jaw = [[
					gAlqdW/4gAgAilgAlydX/4gAgAilgAmDdZ/4gAgAilgAmUdc/4gAgAilgAmbdd/4gAgAilgAmUdc/4gAgAilgAmDdZ/4gAgAilgAlydX/4gAgAil]],
				Crest = [[
					gAn1dudKgAgA/3gAn8dudngAgA/5gAoNdxdagAgA/4gAoedzcsgAgA/0gAold1b3gAgA/ugAoedzbbgAgA/qgAoNdxbngAgA/sgAn8ducWgAgA/y]],
				["Ribbon1.L"] = [[
					f2ohhirbdxfZ9yf2ohhkkYfofi/rf2o1hmgUb6gz/tf2pRhmnKZ5gF+lf2plhkqMdwfe+Pf2pkhhiLfmfk/6f2pQhfehb9hB/rf2o0hgm0Z5gJ+p]],
				["Ribbon2.L"] = [[
					ftn2iR0/c7en35f1oQihsSibdz9Wfmo0ijggdagb/4ffo2ibqBXxhm9Mfto+iWz/c4ev4vf1pcigqPiRdo+IfmpWidetdcgk/2ffoaiVptXyhs9T]],
				["Ribbon3.L"] = [[
					fgm4iY6Kahe+xif6nijO1pi7bW25fcoxjikGfjeJ/qfDoQjGqDXciz9AfgoBij5baffNymf6o1jT0BimbJ4VfcpbjciTfceL/2fDn1jBpvXei59H]],
				["Ribbon1.R"] = [[
					gKohhirbiPgn9ygKohhkkYgYge/rgKo1hmgUkGfN/tgKpRhmnKmHf7+lgKplhkqMiQgi+PgKpkhhiLgagc/6gKpQhfehkDe//rgKo0hgm0mHf3+p]],
				["Ribbon2.R"] = [[
					gTn2iR0/jFhZ35gLoQihsSdliN9Wgao0ijggimfl/4gho2ibqBoPea9MgTo+iWz/jIhR4vgLpcigqPdviY+IgapWidetikfc/2ghoaiVptoOeU9T]],
				["Ribbon3.R"] = [[
					ggm4iY6KlfhCxigGnijO1pdFkq25gkoxjikGgdh3/qg9oQjGqDokdN9AggoBij5blhgzymgGo1jT0Bdak34VgkpbjciTgkh1/2g9n1jBpvoidH9H]],
				["Humerus.L"] = [[
					fGklfAIBOSd0rXfGkrfAKMNvfWunfGk6fAN5OZlby3fGlJfBSJP4sP0hfGlPfBT7P5vqzTfGlJfBRAOZuSw3fGk6fALeNtort2fGkrfAIAOShurZ]],
				["Forearm.L"] = [[
					enlmdxI4NigpsIeRlweCL5M4jGvmdsltemP4Nzn/zLdelbfNSxPNsg0PdelLfXSzOlt8yvdblJe8PdM2rivzdslUeNKyMtmwsdeTledxIONuiMq5]],
				["WingFinger1.L"] = [[
					d2mdcnK3MgiWtzdHmkdNPjMVmvx4cKmPeVUcOErT0+b2lnfYWFPot51ib1lMfeT0OMtFzpb2lRehPQLsowv7cdlwdNK6Ldj0r5dgmLchJGMnhLrA]],
				["WingFinger2.L"] = [[
					c3nOboNbLEiFvWbsnEcwT4MToa0bammXehaXPutp3QaVlkf1b3Ryvq3paQlNfnX5PJt317aZljd9RqK5n7xlbdmScHMtJvhwsUcwm4bUK7KwfYrQ]],
				["WingFinger3.L"] = [[
					b1n6a3QFJ+hbwzaQnTcsYdNjp23AZTmGfIgbTgvs46ZMlNgqhqV4xD5DY4lDgEb9RJuW4GZBlzdkUBKQmozDalm2bGOmICfKsCcHnmaOM4I9dHq1]],
				["Humerus.R"] = [[
					g6klfAIBxuiMrXg6krfAKMyRgqung6k6fAN5xnaly3g6lJfBSJwITx0hg6lPfBT7wHQWzTg6lJfBRAxnRuw3g6k6fALeyTXVt2g6krfAIAxueSrZ]],
				["Forearm.R"] = [[
					hZlmdxI4yefXsIhvlweCL5zIc6vmiUltemP4yNYBzLiilbfNSxwzTg0PiilLfXSzxbSEyvillJe8PdzKUevziUlUeNKyzTZQsdhtledxIOySd0q5]],
				["WingFinger1.R"] = [[
					iKmdcnK3zgdqtzi5mkdNPjzrZRx4j2mPeVUcx8Ut0+kKlnfYWFwYSH1ikLlMfeT0x0S7zpkKlRehPQ0UXQv7jjlwdNK60jcMr5igmLchJGzZe1rA]],
				["WingFinger2.R"] = [[
					jJnOboNb08d7vWkUnEcwT4ztXm0blamXehaXwSSX3Qlrlkf1b3uOQW3plwlNfnX5w3SJ17lnljd9Rq1HYFxlkjmScHMt2ReQsUjQm4bUK71QgorQ]],
				["WingFinger3.R"] = [[
					kLn6a3QF2CelwzlwnTcsYdydWK3AmtmGfIgbsgQU46m0lNgqhqqIO95DnIlDgEb9u3Rq4Gm/lzdkUB1wZYzDlbm2bGOm3+g2sCj5nmaOM43Di5q1]],
				Tail1 = [[
					gAkcggS3gAgA9KgAkhggUUgAgA9ygAktggWGgAgA+agAk5ggXIgAgA+vgAk+ggWzgAgA+ogAk5ggVTgAgA+JgAktggTjgAgA9egAkhggSjgAgA9B]],
				["TailRib1.L"] = [[
					fylRhLSlVBnu5wfylRhQSLbxjI8XfylXhVYYZbhl+UfylfhYbdSvlz8KfyllhXWFUHmO7SfylmhTTHbri/8zfylghNV1ZliI9kfylXhKXOTxnw7I]],
				["TailRib2.L"] = [[
					fQlohdXrTArY5nfklzhrSLdnjB8lfflrh5aWf9dz/afPlkh0iAUjlR9VfQl3hvbHRopk6efkmFhwTIdhi89Cffl5huXtfxd0+0fPljhjdhVfm99S]],
				["TailRib1.R"] = [[
					gOlRhLSlq/YS5wgOlRhQSLkPc48XgOlXhVYYmleb+UgOlfhYbdtRaN8KgOllhXWFr5Zy7SgOlmhTTHkVdB8zgOlghNV1mbd49kgOlXhKXOsPYQ7I]],
				["TailRib2.R"] = [[
					gwlohdXrtAUo5ngclzhrSLiZc/8lghlrh5aWgDiN/agxlkh0iArdav9Vgwl3hvbHuYWc6egcmFhwTIifdE9Cghl5huXtgPiM+0gxljhjdhqhZD9S]],
				TailRibC1 = [[
					gAlVhQVOgAgA+HgAlUhVRDgAgA8SgAlahbYigAgA/GgAlhheftgAgA//gAlnhdZRgAgA/RgAlohYR/gAgA8wgAljhSV8gAgA+XgAlahPa1gAgA/k]],
				TailRibC2 = [[
					gAlwhxZpgAgA/WgAl4htNqgAgA6NgAltiBTegAgA9bgAliiJi7gAgA/2gAl5iEdzgAgA/6gAmLhzOigAgA6ygAl9h1RBgAgA8RgAloh4eDgAgA/7]],
				["UpperLeg.L"] = [[
					fUkJgx4maZgNzrfUkNgw4zaZgJzafUkYgv5RaZgAyzfUkjgu5uaZf3yLfUkogu56aZfzx6fUkjgu5uaZf3yLfUkYgv5RaZgAyzfUkNgw4zaZgJza]],
				["LowerLeg.L"] = [[
					fJjWgkgbgAgA//fJjagigwgAgA/+fJjmgfhjgAgA/9fJjygbiVgAgA/6fJj3gaiqgAgA/4fJjygbiVgAgA/6fJjmgfhjgAgA/9fJjagigwgAgA/+]],
				["Foot.L"] = [[
					fJjUhQ+LgAgAqofJjYhP+SgAgAqUfJjihL+hgAgApkfJjshH+wgAgAozfJjwhG+2gAgAoffJjshH+wgAgAozfJjihL+hgAgApkfJjYhP+SgAgAqU]],
				["UpperLeg.R"] = [[
					gskJgx4mlnfzzrgskNgw4zlnf3zagskYgv5RlngAyzgskjgu5ulngJyLgskogu56lngNx6gskjgu5ulngJyLgskYgv5RlngAyzgskNgw4zlnf3za]],
				["LowerLeg.R"] = [[
					g3jWgkgbgAgA//g3jagigwgAgA/+g3jmgfhjgAgA/9g3jygbiVgAgA/6g3j3gaiqgAgA/4g3jygbiVgAgA/6g3jmgfhjgAgA/9g3jagigwgAgA/+]],
				["Foot.R"] = [[
					g3jUhQ+LgAgAqog3jYhP+SgAgAqUg3jihL+hgAgApkg3jshH+wgAgAozg3jwhG+2gAgAofg3jshH+wgAgAozg3jihL+hgAgApkg3jYhP+SgAgAqU]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAiVggECgAgAvggAiUgjEOgAgAv2gAiQgsEugAgAwtgAiNg3FVgAgAxqgAiKg9FvgAgAyRgAiOgjEvgAgAwugAiVfiCygAgAtBgAiVfiCygAgAtBgAiVfiCy
					gAgAtBgAiVfkC1gAgAtIgAiVfzDHgAgAtugAiVgIDigAgAulgAiVgaD5gAgAvRgAiVggECgAgAvggAiVggECgAgAvggAiVggECgAgAvg]],
				Spine = [[
					gAjBgEFPgAgAxggAjBgJFjgAgAx+gAi/gVGXgAgAzHgAi9giHWgAgA0YgAi7grIBgAgA1KgAi8gMGZgAgAzKgAi8e/DTgAgAuHgAi8e/DTgAgAuHgAi8e/DT
					gAgAuHgAi8fCDYgAgAuRgAi9fSDzgAgAvGgAi/fqEdgAgAwQgAjBf9FCgAgAxMgAjBgEFPgAgAxggAjBgEFPgAgAxggAjBgEFPgAgAxg]],
				Neck1 = [[
					gAjtfxGDgAgAytgAjtf3GigAgAzXgAjtgHH2gAgA0+gAjsgZJdgAgA2rgAjrglKkgAgA3vgAjrf+IGgAgA1QgAjiehDtgAgAu6gAjiehDtgAgAu6gAjiehDt
					gAgAu6gAjjelDzgAgAvFgAjme3EUgAgAwAgAjqfSFGgAgAxTgAjsfpF0gAgAyXgAjtfxGDgAgAytgAjtfxGDgAgAytgAjtfxGDgAgAyt]],
				Neck2 = [[
					gAkPfmGDgAgAytgAkPfuGtgAgAzkgAkQgCIdgAgA1qgAkPgZKqgAgA31gAkOgpMOgAgA5IgAkOf6I9gAgA2MgAj/eNDdgAgAuagAj/eNDdgAgAuagAj/eNDd
					gAgAuagAkAeRDjgAgAungAkEemEHgAgAvqgAkJfEE/gAgAxIgAkNfdFygAgAyUgAkPfmGDgAgAytgAkPfmGDgAgAytgAkPfmGDgAgAyt]],
				Neck3 = [[
					gAkofdGDgAgAytgAkpfnG3gAgAzxgAkqgAJGgAgA2UgAkpgcL8gAgA46gAkngvN9gAgA6agAkof5J3gAgA3FgAkUd+DNgAgAt6gAkUd+DNgAgAt6gAkUd+DN
					gAgAt6gAkVeCDUgAgAuIgAkaeYD7gAgAvUgAkhe5E4gAgAw9gAkmfUFwgAgAyRgAkofdGDgAgAytgAkofdGDgAgAytgAkofdGDgAgAyt]],
				Head = [[
					gAlAfVACgAgAgzgAlCfhAHgAgAiegAlEf/AugAgAmpgAlDgiCDgAgArPgAlAg4DTgAgAuHgAlCf6BCgAgAoAgAkodtAkgAgAaJgAkodtAkgAgAaJgAkodtAk
					gAgAaJgAkqdyAggAgAabgAkweKARgAgAcAgAk5etAEgAgAeRgAk/fLABgAgAgKgAlAfVACgAgAgzgAlAfVACgAgAgzgAlAfVACgAgAgz]],
				Jaw = [[
					gAlQex/+gAgAg6gAlVe///gAgAgTgAlffj/8gAgAeXgAllgP/ogAgAbLgAllgt/mgAgAbCgAlffg/ZgAgAmHgAkodG+tgAgAo9gAkodG+UgAgAqNgAkodG+h
					gAgApngAkqdL/HgAgAnagAk0dj/egAgAltgAlCeH/zgAgAjcgAlMem/9gAgAhjgAlQex/+gAgAg6gAlQex/+gAgAg6gAlQex/+gAgAg6]],
				Crest = [[
					gAnafJchgAgA/zgAncfkd+gAgA/7gAnYgrhsgAgA/8gAnDh3l5gAgA/cgAmtilolgAgA+0gAnRgyivgAgA/4gAmwckWggAgA+jgAmwckYDgAgA+/gAmwckYI
					gAgA/AgAmycqYagAgA/EgAm/dQZ6gAgA/agAnOeJbugAgA/tgAnYe4c4gAgA/1gAnafJc1gAgA/1gAnafJchgAgA/zgAnafJchgAgA/z]],
				["Ribbon1.L"] = [[
					f2oQi7lLdwf2/ff2n8jakjdGgA/if2m+khoobrft+gf2lplev0blem7af2ktl5z1dyep4+f2mnknrLfPfd99f2o8fwaWdogt/Yf2onf9d3bChh/ff2omf9jf
					a8gl/Yf2olgGlEdaf6/ef2ocg2ikemf0/2f2oQh4hVdRgQ/2f2oIisj8brgX/cf2oLi8m1b1f8++f2oQi7nIdGfx/Df2oQi7lLdwf2/f]],
				["Ribbon2.L"] = [[
					ftn8j3sCexfS9nfrnqkXpJeWfr+nfmmdlVribygL9ifkk0l80FaKe/4MfsjwmI6UdeeGx6fzl+lXzBhWef5pftpSgrdnfnfN/4fiovg5eybMiN/hfjoYg5oh
					ZUh1+CfsoRhCuLc3fl8gfxoSh1qqgFeo+IfroLi2lfe4fl/ffmn4jnm9b3gz+8fmnxj0sCbHgf9Ofrn0jzuVdBfp8cftn8j3sCexfS9n]],
				["Ribbon3.L"] = [[
					fonPkky7fFev5wfknHlMvGflez8LfWlymDu1c5gH8LfQj4mG2WZef918fgi1lw9ob5eBrKfzlAlq6Rhmc9x7frpchqkog/cl/dfPoyh2ghcdhT/wfMn3hqqm
					Y1jU9Ifgnfho0YbdgS4PfvnqinzGgGdf5jfnn1jyr4gTeI9pfWndkfqbc8gl+FfVnEkevtbBhS7ZfgnBkYz9ckgC4xfonPkky7fFev5w]],
				["Ribbon1.R"] = [[
					gKoQi7lLiQgK/fgKn8jakji6gA/igKm+khookVgT+ggKlplev0kbha7agKktl5z1iOhX4+gKmnknrLgxgj99gKo8fwaWiYfT/YgKonf9d3k+ef/fgKomf9jf
					lEfb/YgKolgGlEimgG/egKocg2ikhagM/2gKoQh4hVivfw/2gKoIisj8kVfp/cgKoLi8m1kLgE++gKoQi7nIi6gP/DgKoQi7lLiQgK/f]],
				["Ribbon2.R"] = [[
					gTn8j3sChPgu9ngVnqkXpJhqgV+ngamdlVrikOf19igck0l80Fl2hB4MgUjwmI6Uiih6x6gNl+lXzBeqhh5pgTpSgrdngZgz/4geovg5eyk0dz/hgdoYg5oh
					mseL+CgUoRhCuLjJgb8ggPoSh1qqf7hY+IgVoLi2lfhIgb/fgan4jnm9kJfN+8ganxj0sCk5fh9OgVn0jzuVi/gX8cgTn8j3sChPgu9n]],
				["Ribbon3.R"] = [[
					gYnPkky7g7hR5wgcnHlMvGgbhN8LgqlymDu1jHf58Lgwj4mG2WmigD18ggi1lw9okHh/rKgNlAlq6ReajDx7gVpchqkofBjb/dgxoyh2ghjjet/wg0n3hqqm
					nLcs9Iggnfho0Ykjfu4PgRnqinzGf6ih5jgZn1jyr4fth49pgqndkfqbjEfb+FgrnEkevtk/eu7ZggnBkYz9jcf+4xgYnPkky7g7hR5w]],
				["Humerus.L"] = [[
					fGjrf0bVOwhM6gfGjrf6bIObfq6RfGjqgJacN8b45ffGjpgbZTOCX44SfGjognYXOcVg3XfGjogAZqNZap4qfGjgekabPknI56fGjgekZ5RTnh6tfGjgekZ3
					RXni6vfGjgeoZ6RVnS6yfGjje6aLRGl87DfGjnfVaqQgj47MfGjqfsbGPwiC7CfGjrf0bSPEhS6sfGjrf0bVOwhM6gfGjrf0bVOwhM6g]],
				["Forearm.L"] = [[
					dlkAgcdSThl38udmkHgfdESTjy8gdrkXgpcCP2eh7Sd2kpg5aGONY446eBkzhFYZNzVn27dtkdgbauOMcO5xdljmfQblVMrW7idqjrfabUXGrf8HdrjrfbbT
					XLrg8IdrjsfebYXHrS8Ndrjyfwb2WsqD8mdqj5gIcjVyoO8+doj/gadIUtml9DdmkAgedTT4l784dlkAgcdSThl48vdlkAgcdSThl38u]],
				["WingFinger1.L"] = [[
					cZkBhjgebmpY+QcUkNhfgVZGm4+ecSkyhafJTqgM9fcklhhacRPVYw6Dc8l+heZnNuUi2ucTlHg9dMQRcv7gcejlgdeGeFuS8fcsjxgufqgIvJ8Lctjxgvfu
					gNvL8Kctjygyf2gGvA8Qcsj3hDghfbuD8ucnj8hZhHeIsZ9achkAhnhOcyqo9+cbkChngzb7pp+OcZkBhjgfbmpY+QcZkBhjgebmpY+Q]],
				["WingFinger2.L"] = [[
					b/j2jElQc3nu+cbqkCi7lAaAlf+ibJk3ihjXTvfR9VbTmNiFf2OsYB5sb4nEh5cwMxTx2Na/lghvhCP9cA7XcNjriBjRgHsd9ScsjziUm3jFtE8Nctj0iUnA
					jMtF8KctjziYnKjDs88Ncqjyipn4iLsJ8ccfjxi9oBgYqt9DcRjyjLnRehpE9xcEj1jJl/dToC+Qb/j2jFlQc3nu+bb/j2jElQc3nu+c]],
				["WingFinger3.L"] = [[
					b1jVkbp/fEmL9vbOjgkNppb1kS96aIkmjgnnUmej83aDmmisjdOqXX5Nayn8iRf7MVS+1lZvlnidk5QVbX7DcVjajcoajOqf82dMjXjmt5nYqq5udOjXjnuH
					njqp5kdNjWjquSnYqj5kdGjOj5vCmUqB5ocxjHkPuzkBpD6lcUjJketQhdnq8Db+jQkerIfuml9Qb1jVkbp/fEmL9vb1jVkbp/fEmL9v]],
				["Humerus.R"] = [[
					g6jrf0bVxQe06gg6jrf6bIxlgW6Rg6jqgJacyEkI5fg6jpgbZTx+oI4Sg6jognYXxkqg3Xg6jogAZqynlX4qg6jgekabwcY456g6jgekZ5utYf6tg6jgekZ3
					upYe6vg6jgeoZ6urYu6yg6jje6aLu6aE7Dg6jnfVaqvgcI7Mg6jqfsbGwQd+7Cg6jrf0bSw8eu6sg6jrf0bVxQe06gg6jrf0bVxQe06g]],
				["Forearm.R"] = [[
					ibkAgcdSsfaJ8uiakHgfdEttcO8giVkXgpcCwKhf7SiKkpg5aGxznI46h/kzhFYZyNqZ27iTkdgbaux0jy5xibjmfQblq0Uq7iiWjrfabUo6Uh8HiVjrfbbT
					o1Ug8IiVjsfebYo5Uu8NiVjyfwb2pUV98miWj5gIcjqOXy8+iYj/gadIrTZb9DiakAgedTsIaF84ibkAgcdSsfaI8vibkAgcdSsfaJ8u]],
				["WingFinger1.R"] = [[
					jnkBhjgekaWo+QjskNhfgVm6ZI+ejukyhafJsWf09fjclhhacRwrnQ6DjEl+heZnySre2ujtlHg9dMvvjR7gjijlgdeGh7Ru8fjUjxgufqf4Q38LjTjxgvfu
					fzQ18KjTjygyf2f6RA8QjUj3hDghglR98ujZj8hZhHh4Tn9ajfkAhnhOjOVY9+jlkChngzkFWX+OjnkBhjgfkaWo+QjnkBhjgekaWo+Q]],
				["WingFinger2.R"] = [[
					kBj2jElQjJYS+ckWkCi7lAmAah+ik3k3ihjXsRgv9VktmNiFf2xUn/5skInEh5cwzPsP2NlBlghvhCwDkA7XjzjriBjRf5Tj9SjUjziUm3c7S88NjTj0iUnA
					c0S78KjTjziYnKc9TE8NjWjyipn4d1T38cjhjxi9oBfoVT9DjvjyjLnRhfW89xj8j1jJl/itX++QkBj2jFlQjJYS+bkBj2jElQjJYS+c]],
				["WingFinger3.R"] = [[
					kLjVkbp/g8Z19vkyjgkNppkLbu96l4kmjgnnrahd83l9mmisjdxWop5NlOn8iRf7zrtC1lmRlnidk5vrkp7DjrjajcoacyVh82i0jXjmt5YoVW5uiyjXjnuH
					YdVX5kizjWjquSYoVd5ki6jOj5vCZsV/5ojPjHkPuzb/W96ljsjJketQejYW8DkCjQkerIgSZb9QkLjVkbp/g8Z19vkLjVkbp/g8Z19v]],
				Tail1 = [[
					gAiVggj6gAgA/wgAiUgjkHgAgA/ugAiQgskmgAgA/qgAiNg3lKgAgA/kgAiKg9lhgAgA/ggAiOgjkRgAgA/tgAiVfihsgAgA/8gAiVfijSgAgA/0gAiVfijX
					gAgA/0gAiVfkjegAgA/zgAiVfzkGgAgA/ugAiVgIklgAgA/qgAiVgakpgAgA/pgAiVggkOgAgA/tgAiVggj6gAgA/wgAiVggj6gAgA/w]],
				["TailRib1.L"] = [[
					fyiHhii9XEgQ+kfyiFhmkNX8fs+qfyiAhumKV9fS9vfyh6h4mVS4fp8efyh2h+kDTlgD9Nfyh/hlh2Ysgq/FfyiQglhzagfy/dfyiKgkmFV9fU9wfyiJgklG
					R7gg8QfyiJgniKTng29ZfyiGg1iNYFgg+6fyiEhKkrY5fd+1fyiEhcmMV9fR9ufyiGhilHT3f99JfyiHhijVUygX9xfyiHhii9XEgQ+k]],
				["TailRib2.L"] = [[
					fah/iIlaX/gh+ffch6iMmjbKff+7fXhwiPp9Zme39sfRhqiSrjThf/7GfShricoARUhP7Pfeh5iOjCY3ha/AfjiMhQi3gBfP/2fXh6hGqNbSea96fPh8g+rA
					SZhC6wfSiChGmORbiL7sfciAhdj3YhhD+2feh4hxmjc+fT/KfXh0h9qAZme29rfTh5iApwUvgJ8TfVh+iEnCUYg788fah/iIlaX/gh+f]],
				["TailRib1.R"] = [[
					gOiHhii9o8fw+kgOiFhmkNoEgU+qgOiAhumKqDgu9vgOh6h4mVtIgX8egOh2h+kDsbf99NgOh/hlh2nUfW/FgOiQglhzlggO/dgOiKgkmFqDgs9wgOiJgklG
					uFfg8QgOiJgniKsZfK9ZgOiGg1iNn7fg+6gOiEhKkrnHgj+1gOiEhcmMqDgv9ugOiGhilHsJgD9JgOiHhijVrOfp9xgOiHhii9o8fw+k]],
				["TailRib2.R"] = [[
					gmh/iIlaoBff+fgkh6iMmjk2gh+7gphwiPp9mahJ9sgvhqiSrjsfgB7GguhricoAusex7Pgih5iOjCnJem/AgdiMhQi3f/gx/2gph6hGqNkuhm96gxh8g+rA
					tne+6wguiChGmOuld17sgkiAhdj3nfe9+2gih4hxmjjCgt/Kgph0h9qAmahK9rgth5iApwrRf38Tgrh+iEnCrofF88gmh/iIlaoBff+f]],
				TailRibC1 = [[
					gAiEhokigAgA/qgAiChrlVgAgA/igAh9h0orgAgA+ygAh2h9q2gAgA+GgAhyiDoAgAgA++gAh8hriPgAgA/6gAiOgrhSgAgA/9gAiHgqoogAgA+zgAiHgqqL
					gAgA+VgAiGgtl/gAgA/bgAiDg7jDgAgA/2gAiBhPlNgAgA/kgAiBhhotgAgA+ygAiDhno6gAgA+ugAiEhombgAgA/VgAiEhokigAgA/q]],
				TailRibC2 = [[
					gAh4iRjjgAgA/ygAh0iUixgAgA/3gAhmiZnfgAgA/GgAhbietIgAgA9LgAhdipq8gAgA+EgAh2iWgXgAgA//gAiLhWb5gAgA/ugAhxhPmygAgA/QgAhthNtV
					gAgA9FgAh2hVo/gAgA+tgAh7hlhggAgA/9gAhzh4hmgAgA/8gAhqiGnhgAgA/GgAhsiMqXgAgA+RgAhziQntgAgA/DgAh4iRjjgAgA/y]],
				["UpperLeg.L"] = [[
					fUh8gY5RaZgAyzfUh7ga5waPfyyFfUh4gi6xZ+fVwafUh1gr7rZ1e6uxfUhzgw8JZ1eut1fUh2gZ6iZtfIwtfUh7fev3c9h57jfUh7fev3c9h57jfUh7fev3
					c9h57jfUh7fgwJc6h37YfUh7fuxxcphv6VfUh8gC2va4gl16fUh8gS4yabgFzbfUh8gY5RaZgAyzfUh8gY5RaZgAyzfUh8gY5RaZgAyz]],
				["LowerLeg.L"] = [[
					fJhKgHzmgAgA5SfIhKgHzpgIgH5QfHhLgJ0FgUgU45fHhLgM1AgYge4HfHhLgP1ygXgh3bfGhIgBxogxgb6sfOhNf4wBere/7pfOhNf4wBere/7pfOhNf4wB
					ere/7pfOhMf6wTeqe/7efOhJgBx9eme76afJhHf+w3f7fr7MfJhJgEysgEf+59fJhKgHzmgAgA5SfJhKgHzmgAgA5SfJhKgHzmgAgA5S]],
				["Foot.L"] = [[
					fJgfgS/PgAgAm3fJgfgS/PgKf+m3fJgfgS/Pgbf6m3fJgfgS/Pgjf4m3fJgfgS/Pgjf4m3fJgfgS/Pg3f0m3fKgmgO+VeXgMqBfKgmgO+VeXgMqBfKgmgO+V
					eXgMqBfJglgP+feWgNpjfJghgR/FeTgWnYfJgfgS/PfygDm3fJgfgS/PgDf/m3fJgfgS/PgAgAm3fJgfgS/PgAgAm3fJgfgS/PgAgAm3]],
				["UpperLeg.R"] = [[
					gsh8gY5RlngAyzgsh7ga5wlxgOyFgsh4gi6xmCgrwagsh1gr7rmLhGuxgshzgw8JmLhSt1gsh2gZ6imTg4wtgsh7fev3jDeH7jgsh7fev3jDeH7jgsh7fev3
					jDeH7jgsh7fgwJjGeJ7Ygsh7fuxxjXeR6Vgsh8gC2vlIfb16gsh8gS4yllf7zbgsh8gY5RlngAyzgsh8gY5RlngAyzgsh8gY5RlngAyz]],
				["LowerLeg.R"] = [[
					g3hKgHzmgAgA5Sg4hKgHzpf4f55Qg5hLgJ0Ffsfs45g5hLgM1Afofi4Hg5hLgP1yfpff3bg6hIgBxofPfl6sgyhNf4wBhVhB7pgyhNf4wBhVhB7pgyhNf4wB
					hVhB7pgyhMf6wThWhB7egyhJgBx9hahF6ag3hHf+w3gFgV7Mg3hJgEysf8gC59g3hKgHzmgAgA5Sg3hKgHzmgAgA5Sg3hKgHzmgAgA5S]],
				["Foot.R"] = [[
					g3gfgS/PgAgAm3g3gfgS/Pf2gCm3g3gfgS/PflgGm3g3gfgS/PfdgIm3g3gfgS/PfdgIm3g3gfgS/PfJgMm3g2gmgO+Vhpf0qBg2gmgO+Vhpf0qBg2gmgO+V
					hpf0qBg3glgP+fhqfzpjg3ghgR/FhtfqnYg3gfgS/PgOf9m3g3gfgS/Pf9gBm3g3gfgS/PgAgAm3g3gfgS/PgAgAm3g3gfgS/PgAgAm3]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiVggECgAgAvggAiRggDvgAgAu9gAiJggDGgAgAttgAiDggCogAgAsqgAiEggCtgAgAs2gAiUggEMgAgAvygAifggFkgAgAyAgAigggFzgAgAyWgAigggFz
					gAgAyWgAigggFzgAgAyWgAigggFzgAgAyWgAigggFzgAgAyWgAigggFzgAgAyWgAigggFzgAgAyWgAigggFzgAgAyWgAigggFzgAgAyWgAigggFzgAgAyWgA
					igggFxgAgAySgAicggFHgAgAxUgAiXggESgAgAv+gAiVggECgAgAvggAiVggECgAgAvggAiVggECgAgAvg]],
				Spine = [[
					gAjBgEFPgAgAxggAi8gCEygAgAwzgAiyf/D2gAgAvMgAiof8DKgAgAt1gAiqf8DSgAgAuEgAjBgFFlgAgAyBgAjPgNH5gAgA1BgAjRgOITgAgA1fgAjRgOIT
					gAgA1fgAjRgOITgAgA1fgAjRgOITgAgA1fgAjRgOITgAgA1fgAjRgOITgAgA1fgAjRgOITgAgA1fgAjRgOITgAgA1fgAjRgOITgAgA1fgAjRgOITgAgA1fgA
					jRgOIPgAgA1agAjLgKHGgAgA0EgAjEgGFrgAgAyKgAjBgEFPgAgAxggAjBgEFPgAgAxggAjBgEFPgAgAxg]],
				Neck1 = [[
					gAjtfxGDgAgAytgAjoftFagAgAxxgAjafkEEgAgAvkgAjOfeDGgAgAttgAjQffDRgAgAuCgAjufzGlgAgAzbgAj/gGKJgAgA3XgAkBgJKygAgA38gAkBgJKy
					gAgA38gAkBgJKygAgA38gAkBgJKygAgA38gAkBgJKygAgA38gAkBgJKygAgA38gAkBgJKygAgA38gAkBgJKygAgA38gAkBgJKygAgA38gAkBgJKygAgA38gA
					kBgJKrgAgA32gAj7gAI6gAgA2IgAjxf0GugAgAzmgAjtfxGDgAgAytgAjtfxGDgAgAytgAjtfxGDgAgAyt]],
				Neck2 = [[
					gAkPfmGDgAgAytgAkIffFPgAgAxggAj4fSDlgAgAurgAjpfICdgAgAsQgAjsfJCpgAgAssgAkPfqGxgAgAzpgAkigILggAgA4jgAkkgNMXgAgA5QgAkkgNMX
					gAgA5QgAkkgNMXgAgA5QgAkkgNMXgAgA5QgAkkgNMXgAgA5QgAkkgNMXgAgA5QgAkkgNMXgAgA5QgAkkgNMXgAgA5QgAkkgNMXgAgA5QgAkkgNMXgAgA5QgA
					kkgNMOgAgA5IgAkef+J0gAgA3DgAkTfsG7gAgAz2gAkPfmGDgAgAytgAkPfmGDgAgAytgAkPfmGDgAgAyt]],
				Neck3 = [[
					gAkofdGDgAgAytgAkgfVFEgAgAxPgAkNfDDIgAgAtwgAj8e1B5gAgAqxgAj/e3CFgAgArUgAkpfkG8gAgAz4gAk8gNM6gAgA5qgAk9gUOBgAgA6dgAk9gUOB
					gAgA6dgAk9gUOBgAgA6dgAk9gUOBgAgA6dgAk9gUOBgAgA6dgAk9gUOBgAgA6dgAk9gUOBgAgA6dgAk9gUOBgAgA6dgAk9gUOBgAgA6dgAk9gUOBgAgA6dgA
					k9gTN1gAgA6VgAk4f/KxgAgA37gAksfmHIgAgA0GgAkofdGDgAgAytgAkofdGDgAgAytgAkofdGDgAgAyt]],
				Head = [[
					gAlAfVACgAgAgzgAk4fKAEgAgAeUgAkheyA2gAgAYwgAkMehCNgAgAUZgAkQekB6gAgAVJgAlCfeAKgBftjBgAlVgVDggVfSuggAlWgeDqfUhguvgAlWgeET
					gOflv/gAlWgeEmgme5wcgAlWgeDsfXhZu0gAlWgeEJgAgAvugAlWgeEsgueqwlgAlWgeDxfehJu+gAlWgeEAfzgbvcgAlWgeEvgzejwqgAlWgeD3fng0vMgA
					lWgcDufogzu7gAlSgDCCgUfArIgAlGfgALgAgFjNgAlAfVACgAgAgzgAlAfVACgAgAgzgAlAfVACgAgAgz]],
				Jaw = [[
					gAlQex/+gAgAg6gAlBek/xgAgAjtgAkdeL+bgAgAp5gAj9d98dgAgAuogAkDd/82gAgAt0gBlXe8/xf7gTjygCl6gK/9faghe6f8l7gU/8hUfAgWgBl8gX/+
					fngRe7gDl8gY/7e9gteZf9l7gU/9hOfFgQgAl8gW/+gAgAfPgDl8gZ/6evg2eOf9l7gU/9hBfPgFf/l8gV//gYfufjgEl8gZ/5eng6eJf+l8gV/+gvfef2f+
					l7gS/+gtfdf3gCl0fw/9fYg2fKgAlae///gBf7gtgAlQex/+gAgAg6gAlQex/+gAgAg6gAlQex/+gAgAg6]],
				Crest = [[
					gAnafJchgAgA/zgAnOemaDgAgA/bgAmiddUpgAgA95gAlvcrQggAgA7+gAl5czROgAgA8XgAncfnfcftf9//gBm/iEsTfTfo9hf/m+iPrmhbg29xgAmziYt4
					fmfw80gBmvibute7fW8Yf/m9iQrvhUgy9ugAm2iWtZgAgA9DgBmuicu9etfN8Pf/m8iRsBhFgq9ngAm4iUs4gagQ9RgBmticvGemfI8Kf/m6iSsagyge9ef/
					m8iPsHgxgd9mgBnThXoifCfn+0gAngfrfJgFgB/+gAnafJchgAgA/zgAnafJchgAgA/zgAnafJchgAgA/z]],
				["Ribbon1.L"] = [[
					f2oQi7lKfyfg/kf2ooiMeEetf+/6f2pGgWXNcuhp+if2pCeuVpbJjI9tf2pEfBbPaWiX/CfynljetObVfH8vfrkQkz3ydzej1OgOkXlG0ehlfx4hfvjykyyf
					fIfJ6Ffkjmkpw3cUeS64gMkUlFvZcYfL7yf2j5k30XaadO33fgjjkm4uadcizNgJkPlD36fIeR1Kf9kBk82tgJfV2hfejhkk00eZe44NgEkJlAvOfBfj8HgD
					kPlAu5cffJ8FfnlUkrutZDeV7ff3ntjjq0aVfV9jf2oQi7rAcZfY90f2oQi7prezfg+df2oQi7lKfyfg/k]],
				["Ribbon2.L"] = [[
					f1n8j3uciEdx8YfxowjMjGhed+/vfopnhLX3eUgd+4fgpmfdVebYkB9lffpVf6eRY+kj+0fgm2kGz3Y/fa4EfhjRkr9vdydyrXgTjYlR7Vj1ekwHfri2lH3g
					ijfO1hfUiulEyke5eo5/f+jfllvHctfz8Affi/k/1PYTdw2ifIiqkW7nX3cMtbgBjQk79aeMcysBf8jBk79Khueas8fWiiku6chlfUx7f/jTliyCiLfa6Vf1
					jbliu5dqfk8NfMkjlKu8XyfQ7DfinGkQu1Xzgc7IfonnjqzQaefV47fxnrjv0BfBeT43f1n8j3uciEdx8Y]],
				["Ribbon3.L"] = [[
					f4nIkd3qhxbq1Af2okkKsIiya/9CfhqHiCcWfvdc/rfKqLgNV6cUio+BfDpYgzeTZKlt+rfJl7kO2KWvg91GfVinj8/dbyc/irgVigky/HjmcFlKfvh2lB8/
					k1dmsZfNhylZ3QiKds1vfyiqmHwhfCfJ7XfDiFlA1EYZeZ2xeth/ju75Vkc5rQfzilkO/BbgcDlCf5iSkQ/tg8ciiJfYhnkW+5jVeGnVgFiYl53mlUdk0yfs
					immGxcgfek6xevjxllu+Yvfa7UfHmTksvZWuh96ZfVmsj426YDgs02fqmtj86tdEdxxOf4nIkd3qhxbq1A]],
				["Ribbon1.R"] = [[
					gKoQi7lKgOgg/kgKooiMeEhTgC/6gKpGgWXNjSeX+igKpCeuVpk3c49tgKpEfBbPlqdp/CgFnljftOkGhE80f+kPkz3zgohX1UgikYlE0hhrg74egDjxkyyf
					gAgg6Gf3jlkqw/hcgl7EggkVlDvGmZiC7ZgKj5k30Xlmiy33fzjhkn46ikjFzrgckRlC33jZh709gRkCk72tgyg12gfxjfkl0yefgC4RgXkKk/vLiohP8BgX
					kPk/uwlHhm74f6lTksu3k7hV73gLntjjq0l0gp9igKoQi7rAjngo90gKoQi7prhNgg+dgKoQi7lKgOgg/k]],
				["Ribbon2.R"] = [[
					gLn8j3ucd8iP8YgPowjMjGeiiC/vgYpnhLX3hsfj+4ggpmfdVekob/9lghpVf6eRnCbd+0gWm2kHz4mgg64MgEjQks9tguitrhgpjalP7mfchBwJgEi1lI3b
					chgo1gf9islGyieygX6Dg5jjliuzmDhc7qghi/k/1PntiQ2igDilkZ7+lMkBuEgrjTk59XkPikrsgVjCk79OfNhas7ftigkv6HbJgcx0gijVlhyHfihM6Vgr
					jdlhuyj8hL8EgOkglNvMmNgc7dghnGkQu1oWfh7FgYnnjqzQligr47gPnrjv0Bg/ht43gLn8j3ucd8iP8Y]],
				["Ribbon3.R"] = [[
					gInIkd3qePkW1AgKokkKsIdOlB9CgfqHiCcWgRik/rg2qLgNV6jsdY+Bg9pYgzeTm2aT+rgsl7kQ2Nozfa1RgPilj+/fi6j5i7griikw/ffTiWlDf8h2lC80
					aQiksYf6hvla28bZhy1vhRixmCwbj0h+7Hg9iFlA1Ennhn2xgah2jz8enkjhr9g6ipkL+1mriykkgZiTkQ/yf3i/iEfjhmkX+VZji2nSgkiZl435ceim00g7
					iqmDxfhMiC6rgkjslrvNlPgS7qg8mTkrvYpad/6Wgrmsj426n9fU02gWmtj86ti8iPxOgInIkd3qePkW1A]],
				["Humerus.L"] = [[
					fGjrf0X0M6gA4UfGjlfwX6Nlg642fGjYfnX4Pai159fGjMfhXkRMkM6vfGjOfiXoQ3j96nfGjrf2XuNcd34mfGj8gIWhNlX129fGj+gLWQN6W02ufGj+gLWQ
					N6W02ufGj+gLWQN6W02ufGj+gLWQN6W02ufGj+gLWQN6W02ufGj+gLWQN6W02ufGj+gLWQN6W02ufGj+gLWQN6W02ufGj+gLWQN6W02ufGj+gLWQN6W02ufG
					j9gLWTN2W/2xfGj3gCXANGZ/3afGjuf3XqMzed4IfGjrf0X0M6gA4UfGjrf0X0M6gA4UfGjrf0X0M6gA4U]],
				["Forearm.L"] = [[
					dlkUgEYEMJgA3ydlkLgGYhMshS4Wdnj6gLZYOUj85hdsjugPZ6QAl06ZdrjwgOZ1Pslg6PdqkegLX+Mod84Ed+lIgZV0NiWz2OeDlOgeVcOAVr18eDlOgeVc
					OAVr18eDlOgeVcOAVr18eDlOgeVcOAVr18eDlOgeVcOAVr18eDlOgeVcOAVr18eDlOgeVcOAVr18eDlOgeVcOAVr18eDlOgeVcOAVr18eDlOgeVcOAVr18eC
					lNgdVgN7V31/d1k7gRWhMyZP2wdokegGXtMHeQ3ldlkUgEYEMJgA3ydlkUgEYEMJgA3ydlkUgEYEMJgA3y]],
				["WingFinger1.L"] = [[
					cEk7gPaMLogA3+cDksgXbEMLhr4jcGkOgrdCN6lG5tcOj8g8eiPxna6gcMj/g5eRPanC6YcOlNgZZ/MDd04Kc9magnWhNlVE1xdImkgtV/OOTu1WdImkgtV/
					OOTu1WdImkgtV/OOTu1WdImkgtV/OOTu1WdImkgtV/OOTu1WdImkgtV/OOTu1WdImkgtV/OOTu1WdImkgtV/OOTu1WdImkgtV/OOTu1WdImkgtV/OOTu1WdG
					migsWEOHT81acomCgcXkMiX92jcLlNgQZiLnd83scEk7gPaMLogA3+cEk7gPaMLogA3+cEk7gPaMLogA3+]],
				["WingFinger2.L"] = [[
					ajlXgceILagA4Zagk9gpfTMKh45AamkLhNh6Oeln6Ga3jshtj9Q3oC6tazjxhnjmQanp6naxlzgodzLndo4ccCnrg3ZJMvTu1TcVn6hAXlOLRB0QcVn6hAYS
					NhSA0ocVn6hAYjNSSX0xcVn6hAXoOIRF0RcVn6hAYINqRy0jcVn6hAYpNNSf0zcVn6hAXuODRN0UcVn6hAX+NzRk0ecVn6hAYsNKSj01cVn6hAX1N8RX0ZcS
					n3g+X9NzRo0gbfnHgoawLpXP2daul0gbdLLMdn4AajlXgceILagA4ZajlXgceILagA4ZajlXgceILagA4Z]],
				["WingFinger3.L"] = [[
					ZIlfgriFL6gA4zZGk6g/jhM/iJ5ZZVjwhymwQLmU6OZzjDidpSTSo56YZtjKiWo2Stof6YZYmFg5hpL3dc4qbHowhIbtMTSK0nbrpJhWY1OhN+ydbkpGhUac
					NNQAzlbhpEhTbEMxQzz8bqpJhWY7ObOGyiblpHhVaFNfPizWbhpEhTbRMoRE0EbqpJhWZIOROVyrbnpHhVZuNxPFzGbgpDhTbYMjRN0HbopIhWZZOCOry3bj
					pFhTZkN4O+zDaUn9g1d9LQWY2RZUmKgogzLYdM4SZIlfgriFL6gA4zZIlfgriFL6gA4zZIlfgriFL6gA4z]],
				["Humerus.R"] = [[
					g6jrf0X0zGgA4Ug6jlfwX6ybfG42g6jYfnX4wmdL59g6jMfhXku0b06vg6jOfiXovJcD6ng6jrf2XuykiJ4mg6j8gIWhyboL29g6j+gLWQyGpM2ug6j+gLWQ
					yGpM2ug6j+gLWQyGpM2ug6j+gLWQyGpM2ug6j+gLWQyGpM2ug6j+gLWQyGpM2ug6j+gLWQyGpM2ug6j+gLWQyGpM2ug6j+gLWQyGpM2ug6j+gLWQyGpM2ug6
					j9gLWTyKpB2xg6j3gCXAy6mB3ag6juf3XqzNhj4Ig6jrf0X0zGgA4Ug6jrf0X0zGgA4Ug6jrf0X0zGgA4U]],
				["Forearm.R"] = [[
					ibkUgEYEz3gA3yibkLgGYhzUeu4WiZj6gLZYxscE5hiUjugPZ6wAaM6ZiVjwgOZ1wUag6PiWkegLX+zYiE4EiClIgZV0yepN2Oh9lOgeVcyAqV18h9lOgeVc
					yAqV18h9lOgeVcyAqV18h9lOgeVcyAqV18h9lOgeVcyAqV18h9lOgeVcyAqV18h9lOgeVcyAqV18h9lOgeVcyAqV18h9lOgeVcyAqV18h9lOgeVcyAqV18h+
					lNgdVgyFqJ1/iLk7gRWhzOmx2wiYkegGXtz5hw3libkUgEYEz3gA3yibkUgEYEz3gA3yibkUgEYEz3gA3y]],
				["WingFinger1.R"] = [[
					j8k7gPaM0YgA3+j9ksgXbEz1eV4jj6kOgrdCyGa65tjyj8g8eiwPYm6gj0j/g5eRwmY+6YjylNgZZ/z9iM4KjDmagnWhybq81xi4mkgtV/xysS1Wi4mkgtV/
					xysS1Wi4mkgtV/xysS1Wi4mkgtV/xysS1Wi4mkgtV/xysS1Wi4mkgtV/xysS1Wi4mkgtV/xysS1Wi4mkgtV/xysS1Wi4mkgtV/xysS1Wi4mkgtV/xysS1Wi6
					migsWEx5sE1ajYmCgcXkzeoD2jj1lNgQZi0ZiE3sj8k7gPaM0YgA3+j8k7gPaM0YgA3+j8k7gPaM0YgA3+]],
				["WingFinger2.R"] = [[
					ldlXgceI0mgA4Zlgk9gpfTz2eI5AlakLhNh6xiaZ6GlJjshtj9vJX+6tlNjxhnjmvmYX6nlPlzgodz0ZiY4cj+nrg3ZJzRsS1Tjrn6hAXlx1u/0Qjrn6hAYS
					yfuA0ojrn6hAYjyutp0xjrn6hAXox4u70Rjrn6hAYIyWuO0jjrn6hAYpyzth0zjrn6hAXux9uz0Ujrn6hAX+yNuc0ejrn6hAYsy2td01jrn6hAX1yEup0Zju
					n3g+X9yNuY0gkhnHgoaw0Xox2dlSl0gbdL00iZ4AldlXgceI0mgA4ZldlXgceI0mgA4ZldlXgceI0mgA4Z]],
				["WingFinger3.R"] = [[
					m4lfgriF0GgA4zm6k6g/jhzBd35Zmrjwhymwv1Zs6OmNjDidpSsuXH6YmTjKiWo2tTXh6YmomFg5hp0Jik4qk5owhIbtztt20nkVpJhWY1xfyCydkcpGhUac
					yzwAzlkfpEhTbEzPvNz8kWpJhWY7xlx6yikbpHhVaFyhwezWkfpEhTbRzYu80EkWpJhWZIxvxryrkZpHhVZuyPw7zGkgpDhTbYzduz0HkYpIhWZZx+xVy3kd
					pFhTZkyIxCzDlsn9g1d90wpo2RmsmKgogz0oi04Sm4lfgriF0GgA4zm4lfgriF0GgA4zm4lfgriF0GgA4z]],
				Tail1 = [[
					gAiVggj6gAgA/wgAiRggjFgAgA/1gAiJgghNgAgA/+gAiDggfsgAgA//gAiEggf9gAgA//gAiUggipfzgC/4gAifggjbfegF/zgAigggjWhGf2/zgAigggjX
					fsgD/0gAigggjXfLgI/zgAigggjXhAf3/zgAigggjXgAgA/0gAigggjXfAgJ/zgAigggjXg1f4/zgAigggjXgUf9/0gAigggjWe6gK/zgAigggjXgmf7/zgA
					igggjXglf7/zgAicggjkfUgG/ygAiXggj1gDgA/wgAiVggj6gAgA/wgAiVggj6gAgA/wgAiVggj6gAgA/w]],
				["TailRib1.L"] = [[
					fyiHhig1ZehB/SfyiHhjh5b4gD/qfyiHhkizaDfP/TfyiHhkjbVogV+EfyiHhkjdRvh48XfxiLhjjRQXhW7rfwiThihISshL9Cf3iUhjgHZEhO/NfxiUhihY
					bNgg/mfviUhikAaUfQ/Nf2iUhjmWYNeo+VfyiUhjm4Svf98SfuiUhik4PmhC7Af2iUhjh7SqhB8/fziUhjgJWphR+kfuiUhigtZng7/Uf1iUhjjCcVfd/of1
					iUhjltZWeo+vfviPhinOTgfo8ifyiJhimLQ4gb7gfyiHhijXQ/gy8CfyiHhihAUrhC94fyiHhig1ZehB/S]],
				["TailRib2.L"] = [[
					fgiEiMhdZUiD/LfniCiPh8gpgR/7fhh/iNkghceH/lfXh9iGn4bkeo+qfPh7h+qDTxhy7vfLiBh6pdOgjN42fOiOiAlFPHjU6efkiTiNheXdif+sfjiQiOhU
					eahC/6ffiKiLk/hSe8/jfhiEiIp3fMdf+UfRiDh8s7WPfj7lfHiHh1rWO7ij4bfTiOiBmyPLjE6LfaiTiJiVT7i29ZfciSiLg1bIht/jfqiMiPjciZfb/tfi
					iFiKoSgzds+zfPh+h9slYae+8ZfOh6h4syRchJ5bfNh+h7o2OIiz42fUiDiEkDRQi378fgiEiMhdZUiD/L]],
				["TailRib1.R"] = [[
					gOiHhig1mie//SgOiHhjh5kIf9/qgOiHhkizl9gx/TgOiHhkjbqYfr+EgOiHhkjduReI8XgNiLhjjRvTeu74gMiThjhKsWe69dgSiUhigDpEet+pgNiUhjhY
					kLfj/rgKiUhjj8kDhC/egSiUhimcpsg69ygOiUhjm4tRgD8SgKiUhjk5urfW7/gRiUhih5u2e18QgPiUhigIp9et+YgJiUhjgwkNfN/sgQiUhijDk3gZ/egQ
					iUhilxnyhI+egLiQhjnMrRgu9DgOiJhimLvOfk7dgOiHhijXvBfO8CgOiHhihArVe+94gOiHhig1mie//S]],
				["TailRib2.R"] = [[
					ggiEiMhdmsd9/LgZiCiPh8fXfv/7gfh/iNkgekh5/lgph9iGn4kchY+qgxh7h+qDsPeO7vgziCh7pfxMc85EgsiPiDlLwBc57CgriTiIhVqpdX+BgYiQiPhW
					g9fB/7gWiKiOk7dEhY/cgsiEiDqAiuh0+NgviDh8s7pxgd7lguiHh8rcvheP5dg2iOh7mpyLcj5PgqiTiHiSspdG9JgViSiPg8isec/0geiMiNjdezga/xgm
					iFiHoYgWh9+0goh+iBsgmXhn8tgzh6h4syupe05Ygzh+h7o2x4dN42gsiDiEkDuwdJ78ggiEiMhdmsd9/L]],
				TailRibC1 = [[
					gAiEhogogAgA//gAiEhpgYgAgA//gAiFhqitgAgA/4gAiFhqmFgAgA/agAiFhqoigAgA+1f/iJhppOf0gF+of+iQholQffgH/jgFiShog1hHf8/9f/iShof+
					fsgB//f8iShojMfKgH/0gFiShooNg+ft+6gAiShorfgAgA93f7iShoq8fEgY+DgEiShom5g0fz/OgBiShoiBgUf+/7f7iShofxe5gC/+gDiShohwgmf9/8gD
					iShomkglf3/Tf9iNhoq9fWgQ+DgAiGhosBgDf/9pgAiEhopDgAgA+rgAiEhokEgAgA/ugAiEhogogAgA//]],
				TailRibC2 = [[
					gAiDiTeWgAgA/8gAiDiUaYgAgA/fgAh+iUc1gAgA/1gAh1iSkLgAgA/ugAhviPregAgA93f/hxiNuhf1gH8gf8iCiRpSfggL+ngIiQiTgShHf9/+f+iSiUa3
					fsf9/kf6iJiTcyfKf8/0gHh8iOkuhAf0/ngAh1iIs5gAgA9Rf5h2iJvufJgi72gGiAiPrzgxfq9ugCiMiTjNgUf9/1f4iTiTb8e6f5/tgEiNiTbTgmgE/ogE
					iAiQhugmf9/8f7hxiJqxfWgQ+HgAhoiHv8gDf+7vgAhtiMuUgAgA8mgAh5iSm0gAgA/QgAiDiTeWgAgA/8]],
				["UpperLeg.L"] = [[
					fUh8gY5RaZgAyzfUh4gY6GZuffxafUhvgb7RYjeou6fUhpgd75XweCtKfUhqgc7zX5eJtdfUh7gX5baTf4ykfUiIgT2ecWhP2cfUiJgT2bcZhO2gfUiJgT2b
					cZhO2gfUiJgT2bcZhO2gfUiJgT2bcZhO2gfUiJgT2bcZhO2gfUiJgT2bcZhO2gfUiJgT2bcZhO2gfUiJgT2bcZhO2gfUiJgT2bcZhO2gfUiJgT2bcZhO2gfU
					iJgT2bcZhP2ffUiEgU2mcOhQ2TfUh+gX4pa3gWzvfUh8gY5RaZgAyzfUh8gY5RaZgAyzfUh8gY5RaZgAyz]],
				["LowerLeg.L"] = [[
					fJhKgHzmgAgA5SfHhJgDyRgfgd6QfEhGf9wOhMhN7hfDhEf5vDhmhs8JfDhEf6vPhihm8DfIhKgGzLgJgD5nfOhSgS2re1e02gfOhUgS2ne3e02kfOhUgS2n
					e3e02kfOhUgS2ne3e02kfOhUgS2ne3e02kfOhUgS2ne3e02kfOhUgS2ne3e02kfOhUgS2ne3e02kfOhUgS2ne3e02kfOhUgS2ne3e02kfOhUgS2ne3e02kfO
					hUgS2oe3e02jfOhPgT2zeve02XfKhLgK0dfqfr4lfJhKgHzmgAgA5SfJhKgHzmgAgA5SfJhKgHzmgAgA5S]],
				["Foot.L"] = [[
					fJgfgS/PgAgAm3fJgfgS/Pgnf3m3fJgfgS/Nhmfqm3fJgfgS/LiLfim2fJgfgS/LiFfjm2fJgfgS/PgJf+m3fJgmgS+nedgLpIfKgogS+eeggIpofKgogS+e
					eggIpofKgogS+eeggIpofKgogS+eeggIpofKgogS+eeggIpofKgogS+eeggIpofKgogS+eeggIpofKgogS+eeggIpofKgogS+eeggIpofKgogS+eeggIpofK
					gogS+feggJpjfJgjgS+6eYgRoGfJgfgS/PfkgGm3fJgfgS/PgAgAm3fJgfgS/PgAgAm3fJgfgS/PgAgAm3]],
				["UpperLeg.R"] = [[
					gsh8gY5RlngAyzgsh4gY6GmSghxagshvgb7RndhYu6gshpgd75oQh+tKgshqgc7zoHh3tdgsh7gX5bltgIykgsiIgT2ejqex2cgsiJgT2bjney2ggsiJgT2b
					jney2ggsiJgT2bjney2ggsiJgT2bjney2ggsiJgT2bjney2ggsiJgT2bjney2ggsiJgT2bjney2ggsiJgT2bjney2ggsiJgT2bjney2ggsiJgT2bjney2ggs
					iJgT2bjnex2fgsiEgU2mjyew2Tgsh+gX4plJfqzvgsh8gY5RlngAyzgsh8gY5RlngAyzgsh8gY5RlngAyz]],
				["LowerLeg.R"] = [[
					g3hKgHzmgAgA5Sg5hJgDyRfhfj6Qg8hGf9wOe0ez7hg9hEf5vDeaeU8Jg9hEf6vPeeea8Dg4hKgGzLf3f95ngyhSgS2rhLhM2ggyhUgS2nhJhM2kgyhUgS2n
					hJhM2kgyhUgS2nhJhM2kgyhUgS2nhJhM2kgyhUgS2nhJhM2kgyhUgS2nhJhM2kgyhUgS2nhJhM2kgyhUgS2nhJhM2kgyhUgS2nhJhM2kgyhUgS2nhJhM2kgy
					hUgS2ohJhM2jgyhPgT2zhRhM2Xg2hLgK0dgWgV4lg3hKgHzmgAgA5Sg3hKgHzmgAgA5Sg3hKgHzmgAgA5S]],
				["Foot.R"] = [[
					g3gfgS/PgAgAm3g3gfgS/PfZgJm3g3gfgS/NeagWm3g3gfgS/Ld1gem2g3gfgS/Ld7gdm2g3gfgS/Pf3gCm3g3gmgS+nhjf1pIg2gogS+ehgf4pog2gogS+e
					hgf4pog2gogS+ehgf4pog2gogS+ehgf4pog2gogS+ehgf4pog2gogS+ehgf4pog2gogS+ehgf4pog2gogS+ehgf4pog2gogS+ehgf4pog2gogS+ehgf4pog2
					gogS+fhgf3pjg3gjgS+6hofvoGg3gfgS/Pgcf6m3g3gfgS/PgAgAm3g3gfgS/PgAgAm3g3gfgS/PgAgAm3]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiVggECgAgAvggAiSggD8gcgzvUgAh/ggDUhIhzt/gAiyggEQhBh3vxgAjhggEtgmhLwogAj1ggE4gAgAw8gAjsggE0fbe1wzgAjIggEhfBeHwOgAiFggDh
					e6eMuZgAiAggDUfUe5uEgAiFggDdgAgAubgAjIggEegnhLwPgAjsggE2g8h6wxgAj1ggE7g8h6w6gAjhggEtgmhLwogAiyggEMgAgAvzgAh/ggDSfUe5uBgA
					iSggD/e9eKvSgAiVggEEfLegvfgAiVggECf0frvggAiVggECgAgAvg]],
				Spine = [[
					gAjBgEFPgAgAxgf+i+gEFIgggwxUf8iogAEahQhuwDf8jfgFFehJhyxwf+kPgIGAgrhIylgAkkgJGLgAgAy4gCkbgJGHfVe4yvgEj2gHFxe5eMyMgEivgBEp
					exeRwcgCipgAEafPe8wIgAivgBElgAgAwef+j2gHFvgshHyNf8kbgJGJhFh1ytf8kkgJGPhEh1y1f+kPgIGAgrhIylgAjfgFFbgAgAxygCiogAEYfOe8wEgE
					i+gEFLe1ePxSgDjBgEFRfEekxfgBjBgEFPfzfsxggAjBgEFPgAgAxg]],
				Neck1 = [[
					gAjtfxGDgAgAytf9jqfwF4gigvycf6jSfoEyhThswqf6kLfzGchPhuzGf8k9f4HUgwhF0TgAlSf6HqgAgA0vgElJf5HhfQe70igGkjf2G7eyeRzvgGjafrFI
					eueUxNgEjTfoEyfNe9wwgAjafqFEgAgAxQf8kjf2G4gwhFzwf6lJf6HjhNhw0hf6lSf7HthNhw0sf8k9f4HUgwhF0TgAkLfzGYgAgAzJgEjSfoEvfNe9wrgG
					jqfwF7eweSyagFjtfxGGfAenyrgBjtfxGDfyftytgAjtfxGDgAgAyt]],
				Neck2 = [[
					gAkPfmGDgAgAytf9kLfkF1gigvyXf4jxfYEZhQhuwBf4ktfpGkhQhuzRf7lffyHygxhE03gAl1f1IRgAgA1cgFlrfzIEfPe81LgIlFfuHOeweS0HgIj5fcE2
					eweSwwgFjyfZEbfPe8wJgAj5fcEygAgAwzf7lFfuHMgxhE0If5lrf0IGhQhu1Jf5l1f1IUhQhu1Zf7lffyHygxhE03gAktfpGggAgAzUgFjxfYEXfPe8wCgI
					kLfkF4exeSyVgGkPfmGGfAenyrgBkPfmGDfyftytgAkPfmGDgAgAyt]],
				Neck3 = [[
					gAkofdGDgAgAytf8kkfbFxgigvySf3kIfLEChNhwvXf3lGfiGshQhtzcf7l5fuIRgzhD1ZgAmPfyI5gAgA2HgFmFfwIofNe91zgIlffpHheveT0egJkRfQEk
					eyeRwTgGkJfMEEfQe7vigAkRfQEggAgAwVf7lffoHfgyhD0gf4mFfxIqhThs1xf4mPfzI8hThr2Ef7l5fuIRgzhD1ZgAlGfiGogAgAzfgGkIfLD/fQe7vZgJ
					kkfcF0exeSyQgHkofeGGfAenyrgCkofdGDfyftytgAkofdGDgAgAyt]],
				Head = [[
					gAlAfVACgAgAgzf8k8fSAFecg+gWf1kee9AecXiqdLf2lgfbAXcYiGiAf6mTfrAadyhHkXgAmpfxAcgAgAlOgFmffuAfiNe7k5gJl4fkAdjneEjVgLkofEAY
					jqdeePgHkfe+ARiReXdKgAkofDAFgAgAd+f6l4fkASdxhNjMf3mffvAqcchvlBf3mpfxAucdhslbf6mTfrAadyhHkXgAlgfbAEgAgAhxgHkee9ASiReXdAgK
					k8fTAUjqdvgigIlAfWAOi+eNg9gClAfVACgpfng0gAlAfVACgAgAgz]],
				Jaw = [[
					gAlQex/+gAgAg6f4lKeu/JhwfbnGftkkeY9HkSensefulxe5+tkGfJn7f2mpfL/ZidfolqgAnBfS/ogAgAk1gKm3fQ/edkgWlIgRmMfD/Bb+gumogTkwef9h
					bwhRrggMkmeY9TdWg3sjgAkwed9ugAgAr1f1mMfC/Jigfjm0fvm3fQ/Wj7fdk9fwnBfU/bj5fgkjf2mpfL/ZidfolqgAlxe4+6gAgAoOgMkkeX9PdWg3ssgS
					lKev+Tb1hBpUgPlPey+7crg9ncgDlQex/0fUgTjRgAlQex/+gAgAg6]],
				Crest = [[
					gAnafJchgAgA/zfsnUfCangrhu/efOmteSXuh+kD+kfSn1fdfDhvj0/sfloqgCiNg+iS/0gApAgPg8gAgA/+gao1gKegfZdo/3gsoOfydxevcH/pgxm5eibS
					d1cI/VgfmxeQbBeidp/egAm9ecZtgAgA/XfkoQfvczgvib/ufWozgMfehFj0/vfWo7gTiehWjs/pfloqgCiNg+iS/0gAn6fYdegAgA/5gfmveOWve2dd+fgv
					nRfGbAeacB/TgmnXfMdwehc4/ugInafJdHfsfU/2gAnafJchgAgA/z]],
				["Ribbon1.L"] = [[
					f2oQi7lJgWfa/kfoonischeriF/tfRophpc+c0l1/JfioFjUsJdCh89YftoIj3w8gBgl7If2oykGpdgafe+jgJpPkAgJdId0/ygUo1jmhbYQdc+5gQoHiLnS
					WedR9igFoAh6qObieF96f2odiBiVgSfZ/5fipBjiewewip/1fco7kEkmbjkR/DfmoWkIvNcwhW77ftoIj3w8gBgl7If2ohjNmGgXfb/ZgQo6hbYUcreN+0gX
					oiiverYDd6+4gJn+jApxXZdM9Ff7oHi9sVdYe49Yf2oQi7lJgWfa/k]],
				["Ribbon2.L"] = [[
					f3n8j3vDi8dW78fio0jqefhkgC/6fDozimbscxm0+yfanYkAwkaRij6pfunOkT5zfnejy2f3oNk7yyjSdx5mf+pPk/ilf+cP/qf1oykegAYWeQ/Afqnvi5rI
					TSfb7Kfynbir0raGeI3mf3oTjAshisdG9LfdpGkigqh0gz/7fNonk/jRbSlN/CfdngkpzSZ6hr4ufunOkT5zfnejy2f3oJkIv5jBdc7egFpZiSavfBb//Sf5
					oqjndPYPet+4fmnejqtiUHe96afvnajp2ZcOeG2cf3n8j3vEi8dW78]],
				["Ribbon3.L"] = [[
					f9nGka4siYawzgfoo6kpltj0cI/AezpBjibMeBlN/IfMmfkawrYukL5+fpmSkA9scvdnrMf9nQlO7JjFbIv6f8pFl+qDh1ZL9ifXo0lWgHZ6c0/Pe+nLjWqu
					SEhU6sfbmfix5yXNfQwvf9nljr23h6ak1nfkpDlhntkec++ke9oXl7i5c5j8/dfOmjk2zUYMjI4EfpmSkA9scvdnrMf9nRkn5Riia0ywgEpujOiif+Yl/Bfb
					o2kfdVZqdJ/He9mzkCtKSugw58ffmcjo7NZPefvVf9nGka4siYawzg]],
				["Ribbon1.R"] = [[
					gKoQi7lJfqgm/kf7ooircSi4hR/nfkothlbWoJhg+jf1oKjSq0pEjk8fgAoLj2wtj0ij65gKoykGpdfmgi+jgcpMkBgdhZdh/3gmowjni9kNbX/OgioDiPon
					imdd+mgYn9h8qcfqfJ+OgKodiBiVfugn/5f1pEjhebi/iH/vfvo/kDjHnni1+yf5oakGt5ojkR7MgAoLj2wtj0ij65gKohjNmGfpgl/Zgjo4hdYqgvc4++gq
					oeiygQjxay/Vgcn6jCq3jgeV91gOoGi9sZhcgO9dgKoQi7lJfqgm/k]],
				["Ribbon2.R"] = [[
					gJn8j3vDdEiq78gGo4joeqgNjM/zgCpBiaZ8n3gu+Zgannj5uYsdh15qgSnUkR5glHi6yZgJoNk7yycuiP5mgipKlBiYeOfN/2g1oikkhokcaa/JgqnhjEtW
					lOcj8YgWnWiv07gbhH4KgJoTjAshdUi69LgBpLkfg4gPj2/vgNo2k7hsnkiB++gdnwklxKsEi73+gSnUkR5glHi6yZgJoJkIv5c/ik7egppUiWafeDfS/cg5
					objwe8j7Z1/IgnnRjxvVmSdg7QgUnZjp2eiWhh2mgJn8j3vEdEiq78]],
				["Ribbon3.R"] = [[
					gDnGka4sdolQzggGo9knmRenmj+pgfpYjOaBmnic+ohFm8kMt8t5gG5Ognmbj98+oIihqjgDnQlO7Jc7k4v6gapAmApWbZi4+GhFoZlhhOi5bw/jg2mvjrtk
					mkaw7ugamXi46ejYhfxlgDnljr23eGlc1ngCpIlfodeknA+Bgroxlzhzl8jY/NhHnBkuwstshX3kgnmbj98+oIihqjgDnRkn5RdelMywgipqjShpcIjj/ghJ
					ockuefigbT/gg4mbkPvbnxbz6mgfmajq7alThivigDnGka4sdolQzg]],
				["Humerus.L"] = [[
					fGjrf0bCNxhR5yfDjnf2W6P/b/52fBjQfzUQRabN5efBkIf9dyPAkS6qfCk5gAg9N2mv5cfGlPf9a0OWeG6GfKlGf3VkQ4Vd39fMkgfxXFOiYq4LfMjWfmcB
					L1k34BfKjQfneGMhoc32fGjXftYgOQfs5hfCkgf9UWSnWz49fBlFgEW2R9Zy6hfBlOgFe5O1jk6ufCk5gAg9N2mv5cfGkJf1ZvOSe153fKjPfmTPP6XA2zfM
					jnfrWROTZQ33fLjrfucEMIit4nfHjrfybENehQ5kfGjrf0bCNxhR5y]],
				["Forearm.L"] = [[
					djkBgUcbMoiS5Gd1kmgaYtOOdz5ed/kdgUUUQkbT5BdgkGgrcKOyib6kdkkbglgLNXld5adolyghcFNCfG5ceVmcgbW1OtXT3weClogLXGNxYr3ndjjWf4aq
					Lii031dmi3gBdbL7nJ3tdokAgKZzNCgz4/eTl2gmVyQfYl49d/mKg0W3RHZy6EdglIgydROsht6tdkkbglgLNXld5adokvgWbBNBf45QeVkqf5UhN8ZE2ueC
					kwgBWTNiZT3Tdjj0gDarMAgr4YdjkAgQaPNIgA5LdjkBgUcbMoiS5G]],
				["WingFinger1.L"] = [[
					b9kKgtfVMSi35BcblUg3dEM0f85bc7logwW9PTbw5YcAkShUcTPCgZ63cDkFhHgXNvjh6BcGmKg9e7Mafq5QdRnng2asMWZl30c3mvggZrMcZY3mb8jkgGbE
					Lqg04LcAimgWduMElN4XcGkdgicqMdhb5EdTnChIZ0ONal5Rc7nOheZhPzaH6KcAlQhcdbPCfs6/cDkFhHgXNvjh6BcGlJgwd4Mage5MdRl5gEYWLzbk3Lc3
					l4gQY4MPaC3Xb+kLgUbEMMeq4lcBkegpakNVd+5Ub9kKgtfVMSi35B]],
				["WingFinger2.L"] = [[
					abkChFikMwh+5Wa7ljhRi5Mphq5PbumkhOcqN8dM6Camkkh9fePGfK7Ialj2hqh1Obg66pakmRhWiNMpew5Vb7oZhJgOK7bp3qbknmgxfLK6bd3maaj5gUeW
					LogA4madidgsfWMdir5Kakkog5f6Mngg5bcBn0hnfhM2cN5VbuoCiHfROTba6PamlfiHgmPJed7Ialj2hqh1Obg66paklShJhJMnfk5ab7mugNd3Kmdw3kbk
					mxgeeYKxcK3kafkpgmeWMBdz41amlBhEcPNebV5YabkChFikMwh+5W]],
				["WingFinger3.L"] = [[
					ZDjvhelnNsg85mZjlQhpo1ODj94pabm9hui5OGfJ6VZSkqimifPody7RZQjriOi2PMdu6+ZKmLhulUNXdu5WagophVmILAeb3SaKn7g9lGK5eO3bY/kAglhg
					MFfB49ZEiWhDglM5fh5pZKknhSjBNPfa5uapoEiBlpM/eg5DaboUirlgORdY56ZSlhiwjnPudH7JZQjriOi2PMdu6+ZKlOhhkRNSeg5iagnAgVjyK9gh3yaK
					nGgpkUK2e83lZFk4g6hiMWcy4/ZUlihgdhN0YL5AZDjvhelnNsg85m]],
				["Humerus.R"] = [[
					g6jrf0bCyPev5yg3jnfvXKxekg45g0jPfkVMx/l83Zg0kJfudM0YcI4Mg2k6f2gS0LZY37g6lPf9a0xqh66Gg+lFgBU2tNpf5Mg/kggAWUuLl86Vg/jYf1cg
					wya66hg+jRfweoxeXp5bg6jXftYgxwgU5hg2kgf0VFvWqP3vg0lGf1XkxUnt4Wg0lQf1eN0hc+4Sg2k6f2gS0LZY37g6kJf1ZvxuhL53g+jQfwSauFoI39g/
					jnf6VbuYld5/g/jrf6cZxHc56ng7jrf1bGx8ep5/g6jrf0bCyPev5y]],
				["Forearm.R"] = [[
					idkBgUcbzYdu5GiKklgKY3zNim4bh+kafyVQyxl321idkHgAb10leM4EiakdgMfm0qau32iYlyghcFy+g65chtmagtWSvXnv5KiBlmgtWVvBl753igjZgja4
					xGcw6Wici6gbd2yEY45ViYkAgKZzy+fN4/hrl3gUWXxeoW3kh+mNgSXlyFns3yidlMgIc10pfC4NiakdgMfm0qau32iYkvgWbBy/gI5QhtksgKT1wEmL4EiB
					kxgjVevNla5iigj0glaxxRew6YiekAgXaPySf35midkBgUcbzYdu5G]],
				["WingFinger1.R"] = [[
					kDkKgtfVzudJ5BjmlTgddG0ngN4TjJlif7X10ClE3BkEkTgPcP0XgL4YkAkIgdf80Vcp4ej6mKg9e7zmgW5QitnkhSaVxsly5ZjFmshVY/wUlk6BkAjphKbA
					w7ey6pj9irhAd/x3a158j6kdgicqzjel5EivnEgsaNzymB3tjJnTgpaJzbnB3ukElYgXdQ0WhB4hkAkIgdf80Vcp4ej6lJgwd4zmfi5Mitl8ggX1yLkA4tjF
					l5hFYHwglB5xj+kLhLa8xDgz6kj+keg1ahyFh65vkDkKgtfVzudJ5B]],
				["WingFinger2.R"] = [[
					llkChFikzQeC5WlJligsi00xeK4GkcmcgEdU1Yi43dlmkmgffi0Xg/4qljj7gxhpzufI5IlcmRhWiNzXhQ5Vj/oVhzgCzFkM5VkSnih8evxykP6OlakAhyeJ
					w8gB7Flbijhlfaxbdg6slckog5f6zZfg5bkFn2g9fv1Lj83qkcoJg9fq0/k/3nlmlpgpgk0Th14pljj7gxhpzufI5IlclShJhJzZgc5aj/myg3dgzaiR5NkS
					myhpd2x7jo6KlYkphyeHxMiA61lYlBhUcIx7km5zllkChFikzQeC5W]],
				["WingFinger3.R"] = [[
					m9jvhelnyUfE5mmjlPg5onzUbi3ll2mzgNjP1LgG3wnBksgxitz3h943m8jxhHi6y/iO5fm2mLhulUypiS5WlXokiOmJy/h547lln2ifk+xyiR6BmukJiahK
					wehb7XmwieiLgYw9gv7Hm2knhSjByxgm5ulgoHhIlq1ChJ3al2oehKll1EiN3UnBltg7jvzwix4um8jxhHi6y/iO5fm2lOhhkRyuhg5ilXnGhOjozFf/5bll
					nIiKkGx2hr6Lmrk4iYhLw2jX69mplihzdVxmnx5am9jvhelnyUfE5m]],
				Tail1 = [[
					gAiVggj6gAgA/wgAiSggjrjEfn/ogAh/ggiNlue//YgAiyggkOjTfo/igAjhgglNfBgF/jgAj1gglhcHgS/RgAjsgglXcagR/VgAjIggkxfGgG/ngAiFggis
					hlfw/1gAiAggiUh1fs/2gAiFggitgAgA/4gAjIggkweKgL/lgAjsgglZeagI/fgAj1ggljg6f8/fgAjhgglLjmft/XgAiyggkNj4fk/egAh/ggiPg+f1/5gA
					iSggjrctgb/mgAiVggj3bUgl/ZgAiVggj6ewgK/ugAiVggj6gAgA/w]],
				["TailRib1.L"] = [[
					fyiHhigSaJhS/bf/iFhkjnfqex/wgLh4hkl5bYdi/AgAijhjmxSufy8TfujNhginRHgd8MfjjhhbhtWTgz+bfkjZhcleZHfR+vfui3hgosVOep8zf5h8hkla
					ROg171f6h5hkgETxhj9hfyh8hjfFaMhg/afri3hfk0a0fO/MfsjYhfpSUoek8Yf2jghhn4Qofn66gBjNhii1VUga+BgDijhjgxeAhN/5f2h4hkiQdifJ/zfl
					iFhenyTBfn8LffiHhbmSMEhi4KftiHhhhdQ5hE8JfyiHhigSaJhS/b]],
				["TailRib2.L"] = [[
					fiiGiNgbZtij/Qf+h7iQjznCe3+9f9hpiMqJiYbX95ffiSh9t8SpgM5gfJjGh5myMvjA4cfIjciAhsV0iE+NfQjKiClpgefy/ffSiih9tKced984fVhuh8ss
					RUho5Yfah3iFkxPVkG6kfih+iOfPZziz/QfciqiIk/iNfm/hfOjCh5txb4eH8hfRjOh0u4Qsgk30fljFiFnXQgiS65f9igiQhEdiid/yfvhyiRibk8e6/ffE
					hyh3sSaNfC88e1h3hitKMqjv1ffHiCh6lwMqj14hfiiGiNgbZtij/Q]],
				["TailRib1.R"] = [[
					gOiHhigSl3eu/bgaiFhejymbgc/Gglh3hamkvHfE7Zgbijhemny4e848gKjNhiittIfl9Df9jghiiGiDe4/1f/jYhilTfxhT/hgKi3hioopGhx9YgUh8hhla
					xbeb6OgVh4hhgCvjeI75gOh8hjfFl0eg/agGi3hjkvhihI/lgHjYhipNobiG9YgSjhhgnyw8gH5/gcjOhciexKfi64gdijhdgcpqez+egSh4hiiUkZgh/mgA
					iFhkngm5iE+Qf6iHhjmdsBgY87gJiHhjhis1fD9QgOiHhigSl3eu/b]],
				["TailRib2.R"] = [[
					geiGiNgbmTdd/Qgsh7iHj8fCgU/uhJhmhvrCoBfn88hFiShotjyadD2MgsjGh/nDxsdT5jgDjaiPiZikdp/tf/jJiNlcYbg0+lgjihiCtCh2it9Cg8hthxsk
					xCc83yg8h2h5kdzkbF4bgeh+iOfPmNdN/QgLipiOk5aJgy/DgfjCiBtjhKi+8zg5jPhuuuwvev26hFjHhvmZ1Pco2zg4ihiCgcqGdh+QgehyiOidc/gv/vgU
					hyiIrzfujl9hgZh3iAtrsOgS6NgqiCiCmCxWcp5+geiGiNgbmTdd/Q]],
				TailRibC1 = [[
					gAiEhofkgAgA//gOiChnh+jFfx/ygah1hkoylYdz+NgPighmtOjDes88f8jKhmnsfCgK/CfvjdhjhOcHfw/ufwjVhkjrcagF/kf8i0hnrVfIgS95gHh6hor2
					hbfT9rgIh2hpk1hzfi/kgAh6hpeWgAgA/8f4i0hmjDeKgF/yf5jVhlr7eegd9pgEjdhmufg3fr8ggQjKhknpjkfb+2gRighlf5j5gG/wgEh2hpghg/f4/+fx
					iChmqRc4hH+HfriEhls2bsh786f6iEhombexgQ/UgAiEhofkgAgA//]],
				TailRibC2 = [[
					gAiFiTc8gAgA/2gWh9iRaajDgg/WgmheiHmSlieQ+0gVh/iCx+iyeM6Qf5i2iMs4fEgV9RfkjaiOencJfb/ufmjLiNcHcffO/jf6iXiHo2fHgN+ugKhciIwv
					hSfE7NgNhpiSqKhsfP+SgAh+iUbvgAgA/tfziriRbdeMfp/nf1i3iFpeecgV+hgGi6h/zJgyfi5ngZi2iKs0jae19GgcigiPdTj4ga/ogHh0iUY9g/gH/Mfq
					hoiInxcyg3+2fihkiAxmcFio6Tf3hziPrre1ge9wgAiFiTc9gAgA/2]],
				["UpperLeg.L"] = [[
					fUh8gY5RaZgAyzfTh5ga6Jade4xifThmgg8TY1bysYfTiZgd5UcPeyzJfTjIgZ3OdFgg1zfUjdgV2pcPhX2PfVjUgS2HbSiO2hfViwgQ10alit2nfVhrgU6+
					XPgRuzfVhmgW7pXLfMtafUhrgZ7jYUeTuNfTivga3Uc/gf1sfTjUgb3fdsf+1mfTjdgb3dduf+1ofTjIgZ3OdFgg1zfUiZgX4tazgUzpfVhlgX7uXGfItOfV
					h5gS5JYqhTyUfVh8gT4oZVhWzQfUh8gW5JaKgSy5fUh8gY5RaZgAyz]],
				["LowerLeg.L"] = [[
					fJhKgHzlgAgA5SfGhKgFzBhMf+5se9hEf8vrj+he7kfIhngO1fhdeq3nfOiTgV3WfveF1yfOiogT23eye72UfPifgS2cdxfv2sfPh7gR2NdCgO21fIhBf1tS
					fchf9DfGhAf0svgghf9TfDhEf5u9hihP8NfOh6gW3dfreE1rfOiegW3igZdk1hfOingW3ggadk1kfOiTgV3WfveF1yfKhmgK0bfsfu4ofGg/fzsjgihg9YfL
					hIgAxTeghG62fLhJgEyuefgv55fJhKgGzZfrgK5cfJhKgHzmgAgA5S]],
				["Foot.L"] = [[
					fJgfgS/PgAgAm3fJgfgS/OhBfym3fJgfgS++kJfGmzfJg7gS+2gvfzoafJhngS9vfKgGrxfKh8gS9LekgUtCfKhzgS9Sd1gmsqfJhPgS+NdYgvqLfJgfgS/P
					gMf9m3fJgfgS/OhJfwm3fJgfgS/Mh6flm2fJhOgS+Xe/gOqBfJhygT9ffpf4sZfKh7gT9Sftf1s3fJhngS9vfKgGrxfJg7gS+3fngHoafJgfgS/OhMfvm3fJ
					gfgS/PfMgLm3fJgfgS/OfBgOm3fJgfgS/PfzgDm3fJgfgS/PgAgAm3]],
				["UpperLeg.R"] = [[
					gsh8gY5RlngAyzgsh5gV5mmpfsx/grhlgU7epTgFtfgriZgR3ymheE0RgrjJgS2Jkwdz2fgsjdgV2pjxep2PgtjUgZ3Mi4fg12gtivgc3oicgD1bgthsgf75
					mijptwgthmge8KnhjXsvgshrgZ7jnshtuNgriwgT2Mk3d12agrjVgP1wlSdR2sgrjegP1vlQdQ2tgrjJgS2Jkwdz2fgsiZgX4tlNfszpgthmge8Onnjcsigt
					h5ge6akxiDxSgth8gc5vkfhSyagsh8gZ5YlYgSytgsh8gY5RlngAyz]],
				["LowerLeg.R"] = [[
					g3hKgHzlgAgA5Sg3hIgCx9gafW6dg4g+fyr1gTeg9rg0hmgHzhiLfS5PgyiTgS2diRgR2qgyiogT23hOhF2UgyifgV3TgPh711gzh6gX3sftid1WhBhGf/ws
					cdfD7ChBhDf6vFc4ek8Ag9hEf5u9eeex8Ngyh7gS2hiWgT2lgxifgR2Ii2fw27gxipgQ2Hi0fv28gyiTgS2diRgR2qg2hmgK0bgUgS4ohBhDf6u7c1eh8Eg7
					hKgIzwdxgh5Dg5hLgK0ieigy4eg4hKgIzyfrgK5Ig3hKgHzmgAgA5S]],
				["Foot.R"] = [[
					g3gfgS/PgAgAm3g3gfgS/PgEf/m3g3gfgS/PfkgGm3g3g7gS+0hofkoZg3hngS9liMfar9g2h8gS9LhcfstCg2hzgT9dgyf9scg3hOgS+Ygof6qBg3gfgS/D
					cegym0g3gfgS/Dcngwm1g3gfgS/MeGgbm2g3hPgS+QiQfZqHg2hzgS9NimfPswg2h9gS8/ilfPtQg3hngS9liMfar9g3g7gS+3gZf5oag3gfgS/Dcigxm0g3
					gfgS/MeTgYm2g3gfgS/OfFgNm3g3gfgS/PfzgDm3g3gfgS/PgAgAm3]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiVggECgAgAvggAiVg1FQgAgAxigAiVhCGHgAgAyygAiVg/F4gCgFydgAiVg4Fcf1fnx0gAiVgwFBfIeLxEgAiVgrEtfPefwlgAiVgqEmf3fuwfgAiVgmEY
					gHgNwIgAiUgdDVgFgJuKgAiTgSBrgUgYqJgAiSgFAagtgnk6gAiRf5ADhKguf6gAiQfxAOhdgucugAiQfwAShggtcRgAiQfzAJhXgudqgAiQf0AIhWgud7gA
					iQfwAQhegucigAiQfvAThhgtcHgAiQfvAThhgtcHgAiQfvAThhgtcHgAiQfvAThhgtcHgAiQfvAThhgtcH]],
				Spine = [[
					gAjBgEFPgAgAxggAjFggGmgAgAzcgAjHgyHjgAgA0ogAjGgtHTgCgE0UgBjFgkG0fzfoztgDjEgaGWe/eQy/gDjDgTF/fIejyigBjDgRF4f1fuycgAjCgNFo
					gIgMyGgAi+f+EcgGgIwOf/izfoCfgWgXsVf+iifTA2gwgknNf+iQfEAIhNgoiPf9iFe+AFhggnfDf9iEe9AGhjgmemf9iIfAADhbgof/f9iJfAADhZgogRf9
					iEe+AFhigne3f9iDe9AGhkgmecf9iDe9AGhkgmecf9iDe9AGhkgmecf9iDe9AGhkgmecf9iDe9AGhkgmec]],
				Neck1 = [[
					gAjtfxGDgAgAytgAjzgTIBgAgA1LgAj2gqJagAgA2pgAj1gkJCgDgE2RgBj0gYIUfxfp1ggGjygMHne4eU0mgFjxgEHIfDem0CgBjxgBG+f0fvz6f/jvf7Go
					gIgMzegAjofmFfgDgEx5f/jVfGDygMgIvEf9i3eoCJgbgIref8iXeVBCgqgAn+f7iCeOAig0f2lrf7h/eNAfg1f1lWf7iIePAqgxf5mXf8iKeQAtgwf6mjf7
					iBeNAhg0f2lif7h+eNAdg1f0lPf7h+eNAdg1f0lPf7h+eNAdg1f0lPf7h+eNAdg1f0lPf7h+eNAdg1f0lP]],
				Neck2 = [[
					gAkPfmGDgAgAytgAkWgPIjgAgA1wgAkZgqKWgAgA3jgAkYgjJ3gDgE3FgCkXgVI8fxfp2KgHkVgGIBe2eW1EgGkTf8HZfCen0XgBkTf5HNf0fv0Nf/kRfyGy
					gIgMzqf/kJfZFygAgAyVf/jyezEkgBf6wbf9jOeODXgEftuPf8iod2CagFfasHf8iPdtB4gEfKqtf8iLdsBzgEfIqgf8iWdvCBgFfPrIf8iYdwCEgFfRrQf8
					iNdsB2gEfJqof8iKdsBygDfHqcf8iKdsBygDfHqcf8iKdsBygDfHqcf8iKdsBygDfHqcf8iKdsBygDfHqc]],
				Neck3 = [[
					gAkofdGDgAgAytgAkwgNJGgAgA2VgAkzgsLVgAgA4agAkzgkKugDgE34gCkxgUJkfwfq2zgIkvgDIbe0eX1hgHktf3HqfAeo0rgBksf0Hcf0fv0ff/krfsG7
					gIgLz3f/khfQGGf9f8yxf/kJemFaf2fsxxf+jjd+E2ftfUw4f9i6djEWfge2wAf9ifdZECfUegvcf9ibdXEAfSedvXf9indbEIfYenvnf9iqdcEKfZepvqf9
					iddYEBfTefvaf9iadXD/fRecvVf9iadXD/fRecvVf9iadXD/fRecvVf9iadXD/fRecvVf9iadXD/fRecvV]],
				Head = [[
					gAlAfVACgAgAgzgAlLgMA/gAgAn1gAlNgxCbgAgAsKgAlNgnB/f7gDrCgClLgUBQgefsozgJlJgBAziVeXmbgHlHfzAeiAegktgBlGfvATgZftkMf/lEfmAK
					fvgNi+gAk6fIAEfUfshsf/khecAKdwe1hsf/j7dyAfbwdkiUf/jRdWA9Z6cMitf/i1dLBXYtbPi2f/ixdJBbYibGi3f/i+dOBPZEbhi0f/jAdOBMZKbmizf/
					i0dKBZYobLi3f/iwdJBdYebCi3f/iwdJBdYebCi3f/iwdJBdYebCi3f/iwdJBdYebCi3f/iwdJBdYebCi3]],
				Jaw = [[
					gAlQex/+gAgAg6gAlofy/+gAgAe4gAlwgg/5gAgAdlf/lvgU/7gGf/d7gDlqf8/9fegMemgPljfk/2dbhNfLgNlefU/5d0hNftgCldfP//flgPf8f+lYfE//
					gTf1gSgAlLel/9gqgYg/f/kzd5/1iHhah0gAkOdQ/fjzjGixgBjlc1+8lLlAjzgCjKcq+cl9mYkhgCjGco+XmEmlkngBjScs+mlvl9kTgBjUct+plrl1kPgC
					jIcp+amAmdkjgCjFco+VmGmpkqgCjFco+VmGmpkqgCjFco+VmGmpkqgCjFco+VmGmpkqgCjFco+VmGmpkq]],
				Crest = [[
					gAnafJchgAgA/zgAnahDjngAgA/ygAnIiOoGgAgA+8f/nOh6m6gCgG/PgGnYhUkmfxff/pgenbgriMesde/ygandgNgceyd0/5gFnfgDf5fxfl//f8nefuer
					gLgT/9f5nUfEdKfmgo/2fqm6eXcmefiD/tfXmQdxcic1jv/bfHlhdVcVbClM+9e9lAdHcIZwmG+ie8k8dGcGZkmO+dfAlKdLcMaJl1+qfBlNdMcNaQlw+te8
					k/dHcHZrmJ+ge7k6dFcFZgmQ+ce7k6dFcFZgmQ+ce7k6dFcFZgmQ+ce7k6dFcFZgmQ+ce7k6dFcFZgmQ+c]],
				["Ribbon1.L"] = [[
					f2oQi7lLe9fp/jf2mjk1o0ePfk+sf2lPlmsKcifQ9Yf2lmlbs3bIfG83f3mSlCtyajeb8Tf9m9kftpZ8dJ8Jf+nZkEsHbudv9Nf4nhj7pdeMfM+ff1nyjllh
					eagA/efooAi4ixcsg5/sfGnsiIjVaziu/ReYm9hdlqZfko+ddqmIg4nQZGma9sdNlkginMZNnn9ddJlegfl+Zanr9wdWlvgoknZfnD+KdYlygqj2Y5m/+JdL
					lhghkBX8no9vdHlcgek4Xwn49fdHlcgelvYFn49bdHlcgemCYhn29fdHlcgeltYzny9odHlcgelBYxnv9x]],
				["Ribbon2.L"] = [[
					fyn8j3tggveY88fvmBlrtvgue483fokimSuLeEfZ8mfjk4mEuTa6fx8KfhlilmxAY+fM6KfjmPlDziYJd33/frmukv0HbLd64Ufwm9kwxefXef6vfvndkhrm
					gWfH9zfcn0j1meeQge/RezndjDmGbejG+6eCmjiTpcZlli9XdWlohrs5ZpnU7oc7lDhWuGa7oR7Cc2lChVs7b6oF71dBlYhgqncAnR9BdBldhiopbBnU9gcx
					lLhWoKZmoR9HctlChSpSZEow8gcwlAhSq5Zboy8Acxk/hSr5aMoo70cylAhTr1a2oa8CcxlDhUq3bAoQ8g]],
				["Ribbon3.L"] = [[
					fynLkg16gwc/3GfwlQmT0vigdO4Efgjwm4ycgZed6FfRkGmnwQcPfv7SfJkrl8yjYtgJ5BfGlXlM2cWpfT0xfXlyk55PZxetymfrmDlJ4ffJd00dfvmylQzC
					hadr5kfVnbkwsTf8fN9heknEj8pydBir+Mdxl8jDsXaimH8WdMk1iRwpaXoU5Zc4kOh6zUcLo+3kc1kRh+zPd7oP4Hc8ktiQxGeanH6Cc2k5iWuXdfnL7jci
					kniJs1b1od7vcfkaiBtba7pS7CclkSh9vObCpg6AcqkPh8w2b2pS5OcskRh+xYcyo15KcqkXiCwsdQod5z]],
				["Ribbon1.R"] = [[
					gKoQi7lLhDgX/jgKmjk1o0hxgc+sgKlPlmsKjegw9YgKlmlbs1k+hE83gLmRlCt8ktgx8ZgQm6khuOhxfN8mgRnXkFsZgbfH9egLngj8pfhHgK+igInzjllf
					iDgg/cf8oAi4ipiugf/wfZnuiJizjFh3/qeqnBhgkiiekM/Sd8mPg9lyg7mj+wddlsgol0fIn9+bdZlmglk2eFoA+idml2gujmeMnK+6dpl5gwiuekmx/Hdb
					lpgnilernL/CdXllgkjSfBnf+6dXllgkkJfInv+wdXllgkkke3n5+pdXllgkkZecn5+pdXllgkjyeInx+v]],
				["Ribbon2.R"] = [[
					gOn8j3tgfRho88gRmBlrtvfShI83gYkimSuLh8gn8mgdk4mEuRlNgZ8KgdlglnxOmMgG6PgVmHlH0Wi3fl4hgRmpky0XgOgN4qgQm8kwxdfyhF6ygRndkhrn
					gNhT9ygHn2j2mahUg//TfmnkjHlqi1hq/Ue2mxidoUjhjt+deEl5h5rSi8mg9EdglVhksnhTor8EdWlShir5fipM8Pdjlnhsp3etoX9Pdmluhvnzexnr+CdZ
					lehmm/fNnv+PdXlXhjn1gGn1+BdYlUhipXgqoI9fdXlShhqeggoh9AdWlShiqnf2ox84dUlUhip0fJoy9J]],
				["Ribbon3.R"] = [[
					gOnLkg16fQjB3GgQlQmT0vdgiy4Eggjwm4ycfnhj6FgwkGmnwPj5ga7Sgxkol9yymafN5EgdlIlS3kkGe51OgSlqk+5shVgmzAgRmClK4df7iB0hgTmylQzF
					fPil5igNndkxsRf7iT9dfynOkCpdh3iS+afHmTjSrcjhjZ9eeYlTiovMkNlz7OdykqiQxyjgoW5AdikoiQyIhupn4fdolBigwYgFpV52dolPintsfboy7idc
					lDigr8fsok8adfk6ibsSgyoK8YdkkyiXt7hzoJ7kdkktiUvjiEoj6idhksiTwPhipF5+dbkwiWvvgopb6M]],
				["Humerus.L"] = [[
					fGjrf0X0M6gA4UfGjwgWXDNJbO3wfGjzgsWZNzYY3RfGjygmWpNmZN3dfHjxgZWoNMaC3XfMjwgHV/MmZq2ffLjugAWVMcbO25fHjugDXQMydS34fFjtf/Xx
					M9ey4UfFjmfqW7M5ge3/fFjUfLU8NKi73MfDi5euSbN3lf15fCicebQLO3nu0ffCiJeTO0PrpCzefCiHeSOnPypNzUfCiPeVPNPbopzyfCiReWPVPWoiz3fC
					iIeTOuPupGzafCiGeSOjP1pRzRfCiGeSOjP1pRzRfCiGeSOjP1pRzRfCiGeSOjP1pRzRfCiGeSOjP1pRzR]],
				["Forearm.L"] = [[
					dlkUgEYEMJgA3ydxkvglXKMYbQ3Ld9k+g+WbNDYb2rd5k6g4WrM2ZQ24d3k2gnWtMbaF2xd+k5gOWDL3Zu14d3kwgHWdLtbS2TdskkgQXbMCdT3UdnkbgPX+
					MMey3xdlkRf3XRMGgm3ddjj+fSVlMWjZ2udhjieuTZNGmY1ldgjEeURdOOo/0XdfixeJQRPKqhzhdfiueHQHPTqvzZdfi2eMQnO3qFzxdfi4eNQuOyp9z2df
					iveIQNPNqnzedfiteHQDPWqzzWdfiteHQDPWqzzWdfiteHQDPWqzzWdfiteHQDPWqzzWdfiteHQDPWqzzW]],
				["WingFinger1.L"] = [[
					cEk7gPaMLogA3+cdltgvZNLmbS3Nc0mIhLYZMFYd2ncsmAhEYrL7ZS21cnl5gwYuLkaJ2xcxl/gQYDK9Z315cklvgJYfK5bZ2XcRlYgYZgLXdV3acIlHgbaG
					Loey35cEk5f/ZgLjgx3tcAkhfWYGL3j83Pb9kBetWQMynZ2cb7jgeRUmOLqY1ob6jLeFTkPUsH1Db6jIeDTbPfsW0+b6jReIT3O9rn1Ob6jTeJT9O3re1Rb6
					jKeETgPZsN1Bb6jHeDTXPjsb08b6jHeDTXPjsb08b6jHeDTXPjsb08b6jHeDTXPjsb08b6jHeDTXPjsb08]],
				["WingFinger2.L"] = [[
					ajlXgceILagA4ZbFmfg5dGK2bY3XbmnIhWcNK/Yl2obbm8hPchK8ZZ24bTmyg4clKqaS24bfm7gRb4J+aI2DbNmkgLcXKGbo2ma1mBghdcK1db3saplogneC
					LRez4QajlUgJdmLWg+4Sadk2fecfL6kj4OaZkQe2bANPod3+aXjseeZoPKrv3saWjXeUYxQqtl3eaWjUeTYpQ5t13caWjdeWZBQMtE3iaWjfeXZGQEs63jaW
					jWeUYtQwts3daWjTeTYmQ+t63baWjTeTYmQ+t63baWjTeTYmQ+t63baWjTeTYmQ+t63baWjTeTYmQ+t63b]],
				["WingFinger3.L"] = [[
					ZIlfgriFL6gA4zZum9hDhGKzbi3gaUn0hggMKmYx2paInkhZghKqZk27Z+nWhAglKeaf2/aLnjgSf3Jsad2PZ2nEgOgWKBb523ZbmWgrhbLBdi3+ZOl1g1iB
					Lpe14kZIlbgYhtL6hM4zZCk1fwg7M6lL5IZAkJfOf0O8pf5VZBjkfAexRos75dZDjQe9eGTquv5fZDjNe9eAT9u+5fZCjVe9eSTCuP5fZCjXe9eWS3uF5fZD
					jPe9eDTyu25fZDjNe9d9UEvD5gZDjNe9d9UEvD5gZDjNe9d9UEvD5gZDjNe9d9UEvD5gZDjNe9d9UEvD5g]],
				["Humerus.R"] = [[
					g6jrf0X0zGgA4Ug6jwgWXDy3ky3wg6jzgsWZyNno3Rg6jygmWpygm43Xg7jxgcWkyPln34g/jugWVjwlku41g+jtgMWDxHji44g7jtgFXPyvih4Rg5jtf9Xy
					zYhW4Dg6jmfpW8zXfn3yg5jTfIVFzndJ2mg3i0epS5znaT02g2iUeWRIzIXizFg1h+ePQIykVxx8g1h7ePQAyeVhxyg2iFeRQbywWTySg2iHeRQgy0WcyYg1
					h9ePQFyiVrx4g1h6eOP9ycVcxug1h6eOP9ycVcxug1h6eOP9ycVcxug1h6eOP9ycVcxug1h6eOP9ycVcxu]],
				["Forearm.R"] = [[
					ibkUgEYEz3gA3yiPkvglXKzokw3LiDk+g+Wby9nl2riHk6g3WszRm12yiLk1gvWpzAlk3TiLk1gwVoxZkq4ViQkuglWLx6jf4YiVkkgWXZzgig3uiYkbgLX/
					0IhW3fiakRf0XS0Jfe3Qicj7fJVs0acr2HicjWegT20VZY0diciteGSZzrWOy2idiSd9Rly8UOx1idiOd9Rey1T9xridiad/R0zMU0yIidiceAR4zQU/yOid
					iRd9Riy5UHxxidiNd8RcyyT2xoidiNd8RcyyT2xoidiNd8RcyyT2xoidiNd8RcyyT2xoidiNd8RcyyT2xo]],
				["WingFinger1.R"] = [[
					j8k7gPaM0YgA3+jjltgvZN0aku3NjMmIhLYZz7nj2njUmBhCYs0Lmy2vjbl3g8Yqz3lk3UjYl5hFXpyQky4cjilsg5YOysjm4gjwlXgiZf0Lig30j3lHgUaG
					0thU3nj7k4f6Zh0sfS3gj/kbfHYN04cD2mkCjteVWq0kYN1RkEi6d6VdzjUn0AkFiZdyUyyiSZzNkFiVdyUtyXSFzGkEijd0U/y3TCzckEimd0VCy9TOzgkF
					iXdyUwydSQzKkFiTdyUryTR+zDkFiTdyUryTR+zDkFiTdyUryTR+zDkFiTdyUryTR+zDkFiTdyUryTR+zD]],
				["WingFinger2.R"] = [[
					ldlXgceI0mgA4Zk7mfg5dG1Kko3XkanIhWcN1Bnb2oklm9hMci1Lmq2xkvmvhIci0wlh3dkomzhbbgzKk/4uk3mfhNcHzbjy41lMmAgudb0tif4IlWlogdeD
					1EhQ39ldlUgCdm06fC4EljkufKcl00bT3llnj1eWbWz/W42xlpi4d9aWyTS42AlpiSd7ZywxQh1hlpiNd7ZtwiQM1dlpidd6Z8xRRM1qlpigd6Z/xZRZ1tlp
					iQd7ZwwrQY1flpiLd7ZswcQF1blpiLd7ZswcQF1blpiLd7ZswcQF1blpiLd7ZswcQF1blpiLd7ZswcQF1b]],
				["WingFinger3.R"] = [[
					m4lfgriF0GgA4zmSm9hDhG1Nke3glsn0hggM1anP2pl4nlhVgh1dmd20mEnThVgi07lb3ll6nYhxffzWlL48mMm+higGzcj85GmlmVg8ha0gid4Zmyl2gpiB
					0thK4Rm5lagPht0Vey4mm/krfWg/zyai4hnBjnemgCyLVl4LnAijeYfOvjRW3zm9h7edewtXO/3im8h2efestBOr3fm+iGeae5uDPq3nm+iKeae8uPP23om8
					h5eeevtOO23gm8h0egers5Ok3em8h0egers5Ok3em8h0egers5Ok3em8h0egers5Ok3em8h0egers5Ok3e]],
				Tail1 = [[
					gAiVggj6gAgA/wgAiVg1mQgAgA/YgAiVhCnvgAgA/CgAiVg/nWgFgA/IgAiVg4mkflgB/TgAiVgwlud/gI/agAiVgrlKeTgJ/hgAiVgqlCfrgC/lgAiVgmko
					gOf//qgAiUgdipgBgA/4gAiTgSe3gAgA/+gAiSgFaQgAgA/egAiRf5WEgAgA+agAiQfxTfgAgA9cgAiQfwTIgAgA9SgAiQfzUPgAgA9wgAiQf0UdgAgA91gA
					iQfwTVgAgA9YgAiQfvTAgAgA9OgAiQfvTAgAgA9OgAiQfvTAgAgA9OgAiQfvTAgAgA9OgAiQfvTAgAgA9O]],
				["TailRib1.L"] = [[
					fyiHhihsYfgr/Cfyh9h0lYaPfe/Afyh3h/owZGeS97fyh5h9pjV9eJ8xfwh8h2oYSme77yfqiAhul0Qhf07YfriChqjpSmgP80fxiChrjEWzgU+efziEhoji
					ZOf9/EfyiMhhjFYnf0++fyibhVgoWmg6+jfyishDceU9jP9ofyi7guXwU8lY8WfyjCgeULWNmF7ZfyjDgcTFXolZ7hfyjAgjUNYXkU8afyjAgkVDYTj98xfy
					jDgdUpXtkj8XfyjEgbUpW+lP8BfyjEgbUeWmlr7vfyjEgbUBWwlu7mfyjEgbTlXTlc7ofyjEgbTcX2lB70]],
				["TailRib2.L"] = [[
					feiCiKjCYwhW++fihvicmVeCf2/Tfehhiiq9e1ed9/fXhiiZttatd88VfOhpiOtyUXfJ6ZfEhyiDq3PmhD5NfJh4iHnQQwhg7HfYh6iQlKWZhB+Dfgh6iQk+
					bmgK/SfeiEiJlKc4fT/afZiYh7kCaifu/QfUiyhlg8XFiU+nfSjKhKcXVdlf9efUjag2YBWHmy8jfXjfg0V2X7lt8rfajbg/WWZtjv9mfbjZhCXRaeio+KfZ
					jcg5XXZ8i7+DfWjcg2X8Ysj/90fVjbg1YEXslD9bfVjcg0XdXdli9GfXjeg0WmYBlQ9DfYjfg0WCY9ke9O]],
				["TailRib1.R"] = [[
					gOiHhihsnhfV/CgOh9h0lYlxgi/AgOh3h/owm6hu97gOh5h8pjqNh28ugMh8h3oasohM8IgFh/hyl+r2gh9GgHiChtjwqQf6+EgMiChrjFolfu+qgPiEhojh
					nOgB+9gOiMhhjFnbgM+9gOibhVgopafG+jgOishDcerDcx9ogOi7guXwrEao8WgOjCgeULpzZ77ZgOjDgcTFoYan7hgOjAgjUNnpbs8agOjAgkVDntcD8xgO
					jDgdUpoTbd8XgOjEgbUppCax8BgOjEgbUepaaV7vgOjEgbUBpQaS7mgOjEgbTlotak7ogOjEgbTcoKa/70]],
				["TailRib2.R"] = [[
					giiCiKjCnQeq++gehvicmVh+gK/Tgihhiiq9hLhj9/gqhiiZttldiC8UgthoiQt0q4hG6tgkhwiQrJs9f+7Cgih4iQngsPfD8kgkh6iRlMpAfD+Pgjh6iPk+
					k2fy/OgiiEiJlKjKgs/agniYh7kClegS/Qgsiyhlg8o7ds+ngujKhKcXqjah9egsjag2YBp5ZO8jgpjfg0V2oFaT8rgmjbg/WWmTcR9mgljZhCXRlidY+Kgn
					jcg5XXmEdF+Dgqjcg2X8nUcB90grjbg1YEoUa99bgrjcg0Xdojae9Ggpjeg0Wmn/aw9Dgojfg0WCnDbi9O]],
				TailRibC1 = [[
					gAiEhoiOgAgA/6gAh6h5lAgAgA/mgAhziEpegAgA+jgAh1iBsWgFf/9gf+h4h8s9flgH9Pf3h8h1qzeCgd+Df4h/hxnOeUgQ/Hf/h/hwkkfrgC/qgBiBhtj3
					gOf//wgAiKhmjygBgA/xgAiahbijgAgA/5gAithJfUgAgA//gAi9gzajgAgA/hgAjGgjWOgAgA+dgAjHghUWgAgA9ygAjDgoVBgAgA+DgAjDgpV5gAgA+WgA
					jGgiV3gAgA+VgAjHggWSgAgA+egAjHggWVgAgA+fgAjHggVxgAgA+TgAjHggVCgAgA+DgAjHggUkgAgA94]],
				TailRibC2 = [[
					gAh+iTgdgAgA//gAhsijgjgAgA//gAhbiolRgAgA/jgBhWigq+gFf/+Df9hYiZuwfmgI8YfyhhiWuIeGgs8of0hsiYpmeWgY+ef+hziakGfrgB/ugCh3iXg2
					gOgA/+gAh/iRgRgBgA//gAiTiGgqgAgA//gAivh1fxgAgA//gAjMhccYgAgA/ygAjfhGXvgAgA+5gAjkhBUdgAgA91gAjfhJTxgAgA9jgAjdhMUIgAgA9tgA
					jghFUlgAgA94gAjghDV9gAgA+XgAjghDWwgAgA+ogAjihCWUgAgA+fgAjjhBVIgAgA+FgAjkhAT9gAgA9o]],
				["UpperLeg.L"] = [[
					fUh8gY5RaZgAyzfUh9gp6laaflw4fUh/g07XabfUvmfUh+gx7KaefVv9fUh+gq6waIf2whfVh+gg6PZIhNw7fVh9gc58ZWhFxdfUh9gf56aMgDx1fUh8gd5s
					ahftyRfUh7gY5Aaef8zLfUh6gU34akf80kfTh7gQ2eagf02FfTiAgL1DaQfw3ZfTiEgH0GZ/fx4KfTiEgGz9Z9fy4QfTiCgI0YaFfx38fTiCgJ0daGfw33fT
					iEgH0CZ+fx4NfTiEgGz6Z8fy4TfTiEgGz6Z8fy4TfTiEgGz6Z8fy4TfTiEgGz6Z8fy4TfTiEgGz6Z8fy4T]],
				["LowerLeg.L"] = [[
					fJhKgHzmgAgA5SfJhPgR1agAgA3xfJhSgY2hgAgA2ufJhRgW2OgEf93AfJhQgR1pfpgP3jfMhOgI0+eVhJ4EfMhNgH0jeng/4dfJhMgL0efvgM4lfIhLgL0K
					gLf442fIhJgJy3gIf552fIhGgLwbgTfn7cfGhHgOtUgZfK9EfFhMgPqQgTer+RfDhRgOoRgJeZ+3fDhSgOn+gIeW+8fEhPgPo3gNee+tfEhPgPpCgOeg+pfD
					hRgOoJgJeX+5fDhSgOn4gHeV+9fDhSgOn4gHeV+9fDhSgOn4gHeV+9fDhSgOn4gHeV+9fDhSgOn4gHeV+9]],
				["Foot.L"] = [[
					fJgfgS/PgAgAm3fJgjgW/qgAgAkifJgmgY/2gAgAjBfJglgY/zgCf7jbfJgkgV/tf4gakNfLgigO/hfdh9lCfKghgO/cfkhplnfJghgT/ef7gUlwfIgggU/Z
					gDfymKfIgfgW/QgBf2m1fIgfgg/Hf8fhnbfGgmgr++fmfKn7fEgxgy+1fFfBoZfDg7g1+vesfDosfCg8g1+ueofEovfDg4g0+xezfComfDg3g0+ye2fBolfD
					g7g1+veqfDotfCg9g1+uenfEowfCg9g1+uenfEowfCg9g1+uenfEowfCg9g1+uenfEowfCg9g1+uenfEow]],
				["UpperLeg.R"] = [[
					gsh8gY5RlngAyzgsh9gp6llmgbw4gsh/g07Xllgsvmgsh+gx7Klpgkv7gsh+gt6xlUgzwrgth8gr6SkUh2xogth8gm5+kjhiyDgsh9gh56lagdx9gsh8gc5r
					lwf9yMgsh7gX5AltfzzHgsh5gS38lxfK0agsh4gN2qloeW10grh5gH1ZlQdo3Egrh7gE0kk6dP32grh7gD0ck3dL39grh6gF00lCdW3ngrh6gF05lDdY3jgr
					h7gE0hk5dN35grh8gD0ak2dK3/grh8gD0ak2dK3/grh8gD0ak2dK3/grh8gD0ak2dK3/grh8gD0ak2dK3/]],
				["LowerLeg.R"] = [[
					g3hKgHzmgAgA5Sg3hPgR1agAgA3xg3hSgY2hgAgA2ug3hRgW2OgEf93Ag4hPgU1pfpgP3jg6hNgW0+eVhJ4Eg6hMgS0jeng/4dg4hMgN0efvgM4lg3hLgJ0K
					gLf442g3hJgIy3gIf552g2hFgIwbgTfn7cg1hDgJtUgZfK9EgzhEgKqQgTer+RgyhGgLoRgJeZ+3gxhHgLn+gIeW+8gyhGgLo3gNee+tgyhFgLpCgOeg+pgx
					hGgLoJgJeX+5gxhHgLn4gHeV+9gxhHgLn4gHeV+9gxhHgLn4gHeV+9gxhHgLn4gHeV+9gxhHgLn4gHeV+9]],
				["Foot.R"] = [[
					g3gfgS/PgAgAm3g3gjgW/qgAgAkig3gmgY/2gAgAjBg3glgX/zgCf7jbg4gjgY/tf4gakNg5ghgc/hfdh9lCg4ggga/cfkhplng4ghgV/ef7gUlwg3gggS/Z
					gDfymKg3gegV/QgBf2m1g2gegd/Hf8fhnbg1gigm++fmfKn7gygpgt+1fFfBoZgxgwgx+vesfDosgwgxgx+ueofEovgxgugw+xezfComgxgtgw+ye2fBolgx
					gxgx+veqfDotgwgygy+uenfEowgwgygy+uenfEowgwgygy+uenfEowgwgygy+uenfEowgwgygy+uenfEow]],
			},
		},
	},
}
