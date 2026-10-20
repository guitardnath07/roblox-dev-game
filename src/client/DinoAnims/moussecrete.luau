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
					gAiKgWAEgAgAhmgAiKgWAEfhgohlgAiKgWAGfFhMhkgAiLgWAIevhphhgAiLgWAJegh8hggAiLgWAKebiChfgAiLgWAJegh8hggAiLgWAIevhphhgAiKgWAG
					fFhMhkgAiKgWAEfhgohlgAiKgWAEgAgAhmgAiJgWAEgffYhlgAiJgWAGg7e0hkgAiIgWAIhReXhhgAiIgWAJhgeEhggAiIgWAKhld+hfgAiIgWAJhgeEhggA
					iHgWAGhFemhWgAiFgWACgdfZg5gAiEgWABgEf6gagAiDgWABgAgAgNgAiEgWABgAgAgNgAiEgWABgAgAgNgAiEgWABgAgAgNgAiFgWABgAgAgNgAiFgWABgA
					gAgNgAiFgWABgAgAgNgAiEgWABgAgAgNgAiEgWABgAgAgNgAiEgWABgAgAgNgAiDgWABgAgAgPgAiEgWABgIf1glgAiGgWADgmfNhGgAiIgWAHhNechdgAiI
					gWAJhgeEhggAiIgWAKhld+hfgAiIgWAJhgeEhggAiIgWAIhReXhhgAiJgWAGg7e0hkgAiJgWAEgffYhl]],
				Spine1 = [[
					gAiMgCAZgAgAk4f/iMgCAafjgblAf+iMgCAdfJgzlGf+iNgCAee1hHlKf+iNgDAgeohUlNf9iNgDAgekhYlOf+iNgDAgeohUlNf+iNgCAee1hHlKf+iMgCAd
					fJgzlGf/iMgCAafjgblAgAiMgCAZgAgAk4gBiLgCAYgeflkvgCiLgCAYg5fNkngCiKgCAYhOe6kggCiKgDAYhdeukbgDiKgDAZhheqkZgCiKgDAYhdeukbgC
					iJgCAVhDfEkMgBiHgCAOgdfmjhgAiEgCAJgEf8i3gAiDgCAIgAgAiqgAiEgCAJgAgAiygAiEgCAJgAgAi6gAiFgCAKgAgAjAgAiFgCAKgAgAjDgAiFgCAKgA
					gAjFgAiFgCAKgAgAjDgAiFgCAKgAgAjAgAiEgCAJgAgAi6gAiEgCAJgAgAiygAiEgCAIgAgAitgAiFgCALgIf5jJgBiIgCARglffj3gCiKgCAXhKe+kYgCiK
					gDAYhdeukbgDiKgDAZhheqkZgCiKgDAYhdeukbgCiKgCAYhOe6kggCiLgCAYg5fNkngBiLgCAYgeflkv]],
				Spine2 = [[
					gAiXfdBCgAgAoBf+iYfdBHfigOoRf8iZfdBLfHgaoff7iZfdBPezgloqf6iZfdBSemgroxf5iZfdBTeiguozf6iZfdBSemgroxf7iZfdBPezgloqf8iZfdBL
					fHgaoff+iYfdBHfigOoRgAiXfdBCgAgAoBgCiXfdA/gffynxgEiWfdA8g8fnnigFiVfdA6hUfdnWgGiUfdA5hjfXnPgGiUfdA5hofVnMgGiUfdA5hjfXnPgE
					iTfcAzhIfim7gCiPfcAmgffzmDgAiLfbAcgFf+lNgAiKfbAagAgAlBgAiLfbAdgAgAlSgAiMfbAggAgAlggAiMfbAigAgAlsgAiMfbAjgAgAlzgAiNfbAjgA
					gAl2gAiMfbAjgAgAlzgAiMfbAigAgAlsgAiMfbAggAgAlggAiLfbAdgAgAlSgAiKfbAbgAgAlGgBiNfbAhgJf8lmgCiRfcAsgofvmhgFiUfcA3hPffnMgGiU
					fdA5hjfXnPgGiUfdA5hofVnMgGiUfdA5hjfXnPgFiVfdA6hUfdnWgEiWfdA8g8fnnigCiXfdA/gffynx]],
				Neck1 = [[
					gAihfLFMgAgAxbf+iifLFVfogXxpf7ijfLFefTgrx1f6ikfMFlfDg7x+f4ikfMFpe5hGyEf4ikfMFre1hJyGf4ikfMFpe5hGyEf6ikfMFlfDg7x+f7ijfLFe
					fTgrx1f+iifLFVfogXxpgAihfLFMgAgAxbgCigfKFDgZfpxNgFiffKE7gxfVxAgGiefKE2hEfFw1gHidfKEyhRe6wugIidfKExhWe3wsgHidfKEyhRe6wugF
					icfKEXhIffwDgCiXfJDYhIgiuOgAiSfICkhYhWsWgAiQfICUhkhmrtgAiRfICahjhnr8gAiSfICghjhnsKgAiTfIClhihosVgAiUfICohihoscgAiUfICphh
					hosegAiUfICohihoscgAiTfIClhihosVgAiSfICghjhnsKgAiRfICahjhnr8gAiRfICYhhhkr2gBiUfIC3hNhItGgDiZfJD1hAgLvHgGidfKEqhGfOwjgHid
					fKEyhRe6wugIidfKExhWe3wsgHidfKEyhRe6wugGiefKE2hEfFw1gFiffKE7gxfVxAgCigfKFDgZfpxN]],
				Neck2 = [[
					gAjFe7IBgAgA1Lf8jGe8INfrga1Xf5jHe9IXfagx1hf2jIe9IffMhE1pf1jIe+IlfEhP1uf0jJe+InfBhT1wf1jIe+IlfEhP1uf2jIe9IffMhE1pf5jHe9IX
					fagx1hf8jGe8INfrga1XgAjFe7IBgAgA1LgEjEe6H3gWfm0+gHjCe5HtgqfO0ygKjBe5Hmg7e70ogLjAe5HihGev0igMjAe4HghKer0ggLjAe5HihGev0igI
					i+e2G0hVfozrgCi2exFOiQhTxTf/iuetD8jbikuwf+irerDlkAi/tzf+itesDsj/jBuBf+iuesDzj9jCuPf+ivetD4j8jEuZf+iwetEVj7jGvPf+iwetExj7
					jHwAf+iwetEvj7jHv+f+ivetEpj8jGv0f+iuesD6j9jDudf+itesDsj/jBuBf+isesDqj5i7t/f/ixeuEai7iNvwgEi6ezF7hvgtycgJjAe4HThFfM0SgLjA
					e5HihGev0igMjAe4HghKer0ggLjAe5HihGev0igKjBe5Hmg7e70ogHjCe5HtgqfO0ygEjEe6H3gWfm0+]],
				Head = [[
					gAjle3AFgAgAh6f7jme4AHergsh6f3jne6ANdehTh7f0joe7AUcjhzh8fyjoe7Aab9iHh9fxjoe8AcbwiNh9fyjoe7Aab9iHh9f0joe7AUcjhzh8f3jne6AN
					dehTh7f7jme4AHergsh6gAjle3AFgAgAh6gFjje2AHhWfUh6gJjie0ANiketh7gMjhe0AVjjeNh8gPjgezAbkLd5h9gPjfezAdkZdyh9gPjgezAbkLd5h9gK
					jdeuAOjhfqfugDjTekA3jTjPaZf9jIebCwkFmEVUf8jEeYDykqm9Tef8jGeZDskmm/Ttf8jIeaDmkjnBT6f8jJeaDikhnDUFf8jLecCokknaWzf8jMeeCAkn
					nuZif8jMeeCAkontZgf8jLedCEkpnrZLf8jIeaDUklnIUrf8jGeZDskmm/Ttf8jFeYDmkim1T0f+jNeeB7jklPXKgFjYepAYi/h6cvgMjfeyAQjiewhHgPjg
					ezAbkLd5h9gPjfezAdkZdyh9gPjgezAbkLd5h9gMjhe0AVjjeNh8gJjie0ANiketh7gFjje2AHhWfUh6]],
				Jaw = [[
					gAjoeT/8gAgAhrf6jpeU/5haffh2f0jqeW/zirfBh+fwjqeX/rjqeqiEftjreY/lkSeciIfsjreY/jkgeXiJftjreY/lkSeciIfwjqeX/rjqeqiEf0jqeW/z
					irfBh+f6jpeU/5haffh2gAjoeT/8gAgAhrgGjmeS/6elgihrgMjkeR/0dThBhqgRjjeQ/tcShZhogTjieQ/mbohohmgUjheP/kbZhuhmgTjieQ/mbohohmgK
					jaeL/kcef9j2f6jGeD+VdGcapEfuizeC74coZit5fqiteD6pcKYlvnfqiveE6rcQYhvifqixeF6ucWYevefqizeF6wcbYcvbfqi5eD79cbYEs5fqjAeC87cb
					XwqTfqi/eC87caXxqTfqi+eB82cXX0qifqizeE7GcVYYuwfqiveE6rcQYhvifqiueD64cRYtvTfxi6eC85dDaasKf/jQeG/DdQdxmzgOjgeO/rcXg2idgTji
					eQ/mbohohmgUjheP/kbZhuhmgTjieQ/mbohohmgRjjeQ/tcShZhogMjkeR/0dThBhqgGjmeS/6elgihr]],
				Crest = [[
					gAlEefLVgAgA4afylFehLMfJh84NfmlFeiLKedjg39fclFekLJeIkg3wfWlEelLFeMk13pfUlEemK/ejkk3ofWlEelK6fDj33ufclFekK6fii733fmlFeiK/
					f3h74CfylFehLJf/g84OgAlEefLVgAgA4agOlDeeLigAfD4kgalAedLvgIeD4rgkk9edL8gadA4ugrk7edMIg1cA4ugtk7edMRhTbR4sgrk7edMThqbA4pgf
					k2eKKZiicl3MgKkcdiGuklf3zDf4j5dFEGoNdmtFfyjqc9DdoQhcrwfyjuc/EGnJlpsufyjxdBDYofgircfyjzdCDYofgorcf2kEdMFXm5l7vMf6kSdZGKot
					iOwkf6kSdYF+qeebvRf6kPdWGLoNjMwtf0j1dDD7n9i4syfyjuc/DWpKdeqkfzjtc/DkoEhdsIf8kHdPFVlGkFwZgQkqdzIHjTfW1Agik7eWLUg5dT4Ogrk7
					edMIg1cA4ugtk7edMRhTbR4sgrk7edMThqbA4pgkk9edMLhvbX4mgalAedL6hdca4lgOlDeeLlg2eD4i]],
				["UpperArm.L"] = [[
					fdice/3kP0fVuUfbice/4KQQfHt0fZicfA4mQpe9tefXicfA44Q9e6tTfWicfA4/RKe9tUfWicfA46RNfItifWicfA4pRHfat6fXicfA4OQ5fvuafZicfA3r
					QlgFvAfbice/3BQNgavnfdice/2UP0grwNffice+1qPbg1wsfhibe+1HPGg6xDfjibe+0vO0g4xPfkibe+0mOogxxOfkibe+0sOjgmxCfkibe+1COlgZwqfi
					iYe+3YPJfjt3ffiRe97CQidzm8fdiKe98dR+cBfNfdiJe98QSlbHbefdiKe98JSsayazfdiLe98DSyakaUfdiMe97/S1acaEfdiNe98eSUb6dJfdiNe98nR7
					diggfdiNe98mR4dxg+fdiMe98lR2d/hafdiLe98eSUb5dGfdiKe98dSVb2dBfdiJe98jSKcUeTfeiNe98CRUdnj9fgiUe+5KP+farifjiae+1fO8gpwcfkib
					e+0mOogxxOfkibe+0sOjgmxCfkibe+1COlgZwqfjibe+1jOvgJwJfhibe+2NPAf4vjffice+25PYfmu6]],
				["LowerArm.L"] = [[
					fKiDenqV+AjvhYfIiDenp5+Ekkg7fHiEempg+Jk7gpfFiEempL+Qk0glfFiDemo8+akQgufEiDeno0+jjRhGfFiCeooz+ph/hofGiBepo4+pggiQfHiAeppE
					+he9i4fIiAerpV+TdfjcfKh/espr+AcRj3fLh/etqE9ubZkJfNh+etqe9ga9kQfOh+euq39YbBkOfOh/etrL9XblkEfPh/etrY9dckjzfOh/esrc9md6jcfP
					iAelqv9sk4hxfSiFeanm5CyRd2fViQeXi1u87najfXiYeZgXpH+AZrfXibeagKoS+PZofXidebgGn4+WZqfXieebgMn8+WZyfXiXeYhFrt9JaCfXiOeWiAvq
					7RagfXiNeWiWwy6pa3fXiLeWiqx06AbPfXiWeYiLuW8GbKfXiVeYiXuv76bXfXiReXi8wj64btfUiHeXmD3v0cdsfQh/egpX9lnqhXfOh+erqy9udBj1fOh/
					etrL9XblkEfPh/etrY9dckjzfOh/esrc9md6jcfOiAerrW9wfei/fNiBeprH94hEidfMiCeoqw99iih6]],
				["UpperArm.R"] = [[
					gjice/3kwMgruUghiee/3pwmhNtsgeige/3pw8hmtOgdiie/3lxOh1s8gciie/3dxZh5s6gbije/3TxehytHgciie/3Hxbhhtigdiie/26xQhHuIgeige/2s
					w+glu0ghiee/2fwnf+vigjice/2UwMfVwNgliZe/2MvxevwwgniXe/2JvYeQxIgpiVe/2LvEd7xVgqiUe/2Su3d0xWgqiTe/2euzd7xKgqiUe/2uu4eQw0go
					iTe/4ku4ftuFgliPe+7guiiKnHgjiKe98ht5kCfPgjiJe98Qtbk5begjiKe98JtUlOazgjiLe98DtOlcaUgjiMe97/tLlkaEgjiNe98etskGdJgjiNe98nuF
					iegggjiNe98muIiPg+gjiMe98luKiBhagjiLe98etskHdGgjiKe98dtrkKdBgjiJe98jt2jseTgkiMe98LuaiakAgmiRe+5zu4gUrrgoiUe/21vAeTwkgqiU
					e/2Su3d0xWgqiTe/2euzd7xKgqiUe/2uu4eQw0gpiVe/2+vGewwUgniXe/3OvafYvsgliZe/3bvygCvA]],
				["LowerArm.R"] = [[
					g2iDenqVCAcRhYg0iHemq1CSbbhPgziKelrPCgbBhQgxiNelrjCnbHhZgwiOelrvCnbshpgwiOelryChcth9gwiMemrpCXeCiUgxiKenrWCOfkitgziHeoq5
					CHhIjIg0iDeqqUCCikjhg2h/esprCAjvj3g3h7etpEB8kikIg5h4euojB3k4kQg5h1evoLBvkwkOg6hzevoABlkLkBg6hzevoDBbjNjpg6h0euoTBVh6jJg3
					h4emoiBlbKhAgyiCebm6GwN3dFgriQeXiyREEbaZgpiYeZgXW5CAZrgpibeagKXuBxZogpidebgGYIBqZqgpieebgMYEBqZygpiXeYhFUTC3aCgpiOeWiAQW
					EvaggpiNeWiWPOFXa3gpiLeWiqOMGAbPgpiWeYiLRqD6bKgpiVeYiXRREGbXgpiReXi8PdFIbtgtiGeYl4IOLmddg0h6ehoLCDYXg0g5h1etoPBcizjqg6hz
					evoABlkLkBg6hzevoDBbjNjpg6h0euoTBVh6jJg6h3esotBVgcimg5h6erpOBee6iFg4h+eppyBtddhq]],
				Tail1 = [[
					gAiIgshRgAgA/9gBiJgsg+h6gd/6gCiJgsgqjog5/xgCiKgsgYk+hQ/kgDiKgsgLl1hf/bgDiKgsgGmHhk/XgDiKgsgLl1hf/bgCiKgsgYk+hQ/kgCiJgsgq
					jog5/xgBiJgsg+h6gd/6gAiIgshRgAgA/9f/iIgshfeFfl/5f+iIgshpcXfO/uf+iHgshta/e+/if9iHgshvaHe0/Xf9iHgshvZ0ex/Uf9iHgshvaHe0/Xf+
					iHgshkbdfK/nf/iFgsg/baf3/pgAiEgsgUbtgT/sgAiEgsf4gAgA//gAiEgsfnkufp/ogAiFgsfZlifo/ggAiFgsfMh0f5/7gAiFgsfFckgN/ygAiGgsfDaM
					gV/cgAiFgsfFckgN/ygAiFgsfMh0f5/7gAiFgsfZlifo/ggAiEgsfnkufp/ogAiEgsf6gAgA//gAiFgsgfcDgL/vf/iGgshLbsfq/rf+iHgshqbKfC/kf9iH
					gshvaHe0/Xf9iHgshvZ0ex/Uf9iHgshvaHe0/Xf+iHgshta/e+/if+iIgshpcXfO/uf/iIgshfeFfl/5]],
				Tail2 = [[
					gAiGhKi2dKgQ/vgFiHhKiagKgi/5gJiIhKh2jJg0/xgMiKhJhPlxhC/bgOiKhIgsn0hL+/gOiLhIgUpFhN+pgOiKhIgLpghI+hgMiKhJgRpBg7+rgJiIhKgl
					nqgo/DgFiHhKhBljgQ/fgAiGhKhgi3f3/1f7iFhKh8f3fh/7f3iFhKiTc3fR/vf0iEhJilaMfK/VfyiEhIixYHfK+3fyiEhIi7W0fP+ffyiEhIjDWZfZ+Wf1
					iEhJjGYcfq+7f3iDhJioYhgb+/f4iDhJh8WmhK+fgAiEhLhdbUgo/mgJiFhJhBksfc/ogKiGhJggqEez+VgDiHhKgGnRfH/Jf5iHhKfveXgD/8f1iHhJfdW3
					g1+pf5iHhKfUW4g5+pgDiHhKfVeZgQ/8gKiGhJfenTfc/IgJiFhJfvqGfH+VgAiEhLgJkqfl/pf4iEhKg6cigM/yf3iEhJhzaaf1/cf1iEhJigaGfP/VfyiE
					hIixYHfK+3fyiEhIi7W0fP+ffyiEhIjDWZfZ+Wf0iEhJjJW6fk+gf3iFhKjMYSfx+4f7iFhKjGacgA/W]],
				Tail3 = [[
					f7iBhoiyZCgc/GgFiDhoifcSgx/qgPiFhnh8f7hD/6gWiIhlhOjkhQ/vgciKhjgcmzhX/OgfiLhifxpUhW+kgfiLhifSq6hO+CgciKhjfGrfg/91gXiIhlfK
					rAgr+BgPiFhnfdpegS+jgFiDhof4m/f2/Of7iBhogWjxfb/wfxiAhngzgIfF/9fpiAhlhNcde3/wfkiAhihjZKe1/Mfhh/hhh4Wme8+gfhh/hhiMU9fK97fn
					h+hkigXEfj+nfph+hkiUYdgW/Afnh/hihzUlhQ9zf3iBhohaV7hH+TgSiDhmhCgAf8/+gdiEhhgfqEe0+VgRiGhmf9rwej9uf2iIhofdj4fS/vfkiIhie7Yl
					gb/GfpiIhjehTphG9cgAiIhpeTYog7/EgYiHhkeOj9gH/sgbiFhieUr1fb9rgJiEhoekqDfY+VfyiChnfThBfx/9fsiBhmgQchff/yfqiAhlhHb/e8/sfkiA
					hihjZKe1/Mfhh/hhh4Wme8+gfhh/hhiMU9fK97fkh/hiieUZfd9sfph/hkiuU6fx94fxh/hmi2WggH+a]],
				Tail4 = [[
					fuh7iDg6V6f0+Wf+h+iGg3YbgZ/EgPiBiGgjbtg8/rgdiGiDgAfdha/9gpiJh/fTjQhv/xgwiMh7ekmrh3/MgyiNh5d8pZh0+dgwiMh5dhrLhn91gqiKh8dU
					r6hS9iggiGiAdVrig39tgSiDiEdgqFgW+QgCiBiGdxnofy+/fyh/iGeEkXfO/nfih+iCeYgnev/6fXh9h+eucyeZ/wfQh9h6fGZTeP/OfNh8h4fiWieS+gfX
					h6h9f7X2e3+6fbh6h/f6a0f7/kfTh7h5fqW/gk+sflh+iAfnULgd9ugSiBiFfUadf8/fgviDh6e7lhfZ/fgmiFh8eprzfF9sf+iIiGeNojfL+xfXiKh9dleE
					fs/1fTiKh5dGVSgX+AfziLiEcvVTg099gfiKiBcZeGg0/ugwiIh4cRolge+lgbiGiAcSrzgD9gf0iDiGcsmHfv/OfmiAiEdfg8fP/3fih+iCeSf7ew/6fXh9
					h+eucyeZ/wfQh9h6fGZTeP/OfNh8h4fiWieS+gfPh7h4f+Uuef95fVh6h7gaUAe29ofgh6h/gvUafS9z]],
				["UpperLeg.L"] = [[
					fXhagG7hduf8wJfYhZgI78d2fYvbfZhYgJ8Sd9e2uxfZhYgL8ieBecuPfahXgL8seEeLt6fahXgM8veFeFtyfahXgL8seEeLt6fZhYgL8ieBecuPfZhYgJ8S
					d9e2uxfYhZgI78d2fYvbfXhagG7hduf8wJfWhbgF7Edlgew3fVhbgD6pddg8xgfVhcgC6RdWhTyAfUhcgC6CdRhhyUfUhdgB59dPhmybfUhcgC6CdRhhyUfV
					hagE64dVhExHfWhWgH8OdYgRu1fXhTgK9GdWfrtAfXhSgL9UdUfksffXhTgL9QdWflspfXhTgL9NdXfmsyfXhUgL9KdXfms5fXhUgL9IdYfns9fXhUgL9HdY
					fns/fXhUgL9IdYfns9fXhUgL9KdXfms5fXhTgL9NdXfmsyfXhTgL9QdWflspfXhSgK9SdVfkslfWhUgJ82dYfztkfWhYgG7xdZgfvpfVhbgD6gdVhNxrfUhc
					gC6CdRhhyUfUhdgB59dPhmybfUhcgC6CdRhhyUfVhcgC6RdWhTyAfVhbgD6pddg8xgfWhbgF7Edlgew3]],
				["LowerLeg.L"] = [[
					fUg9f2tUgugB9FfUg9f2tXg2fl9DfVg9f2tdg9fK8/fVg+f3tjhDez87fVg+f3tphHej84fVg+f3trhIee83fVg+f3tphHej84fVg+f3tjhDez87fVg9f2td
					g9fK8/fUg9f2tXg2fl9DfUg9f2tUgugB9FfUg9f2tUgogc9FfUg9f2tXgjgy9DfUg9f2tbgfhC9BfUg9f2tegdhM8/fUg9f2tggchP8+fUg9f2tegdhM8/fU
					g8f1s/ghg89NfUg7f0sTgsgg9hfUg7f0sCg2gN9ofUg7f0sDg4gK9ofUg7f0sLg4gK9kfUg7f0sSg3gJ9hfUg7f0sYg3gJ9ffUg7f0scg3gJ9dfUg7f0sdg3
					gJ9dfUg7f0scg3gJ9dfUg7f0sYg3gJ9ffUg7f0sSg3gJ9hfUg7f0sLg4gK9kfUg7f0sEg4gK9nfUg7f0sJg0gQ9lfUg8f1skgogm9afUg9f2tQgghA9GfUg9
					f2tegdhM8/fUg9f2tggchP8+fUg9f2tegdhM8/fUg9f2tbgfhC9BfUg9f2tXgjgy9DfUg9f2tUgogc9F]],
				["Foot.L"] = [[
					fWgegR7qgCf/wDfWgegR7qgHf8wDfWgegR7qgLf5wDfWgegR7qgPf3wDfWgegR7qgRf2wDfWgegR7qgSf2wDfWgegR7qgRf2wDfWgegR7qgPf3wDfWgegR7q
					gLf5wDfWgegR7qgHf8wDfWgegR7qgCf/wDfWgegR7qf+gBwDfWgegR7qf7gDwDfWgegR7qf5gEwDfWgegR7qf3gFwDfWgegR7qf3gFwDfWgegR7qf3gFwDfW
					gegR7qf6gDwDfWgegR7qgCf/wDfWgegR7qgJf7wDfWgegR7qgLf6wDfWgegR7qgLf6wDfWgegR7qgKf6wDfWgegR7qgKf6wDfWgegR7qgKf6wDfWgegR7qgK
					f6wDfWgegR7qgKf6wDfWgegR7qgKf6wDfWgegR7qgKf6wDfWgegR7qgLf6wDfWgegR7qgLf6wDfWgegR7qgIf8wDfWgegR7qf/gBwDfWgegR7qf5gEwDfWge
					gR7qf3gFwDfWgegR7qf3gFwDfWgegR7qf3gFwDfWgegR7qf5gEwDfWgegR7qf7gDwDfWgegR7qf+gBwD]],
				["Toe.L"] = [[
					fWgOgH/7gBf+iIfWgOgH/6gEf6iIfWgOgH/6gHf1iIfWgOgH/6gJfyiIfWgOgH/6gLfwiIfWgOgH/6gLfviIfWgOgH/6gLfwiIfWgOgH/6gJfyiIfWgOgH/6
					gHf1iIfWgOgH/6gEf6iIfWgOgH/7gBf+iIfWgOgH/7f/gCiIfWgOgH/6f9gFiIfWgOgH/6f7gHiIfWgOgH/6f7gIiIfWgOgH/6f6gJiIfWgOgH/6f7gIiIfW
					gOgH/6f8gGiIfWgOgH/7gBf+iIfWgOgH/6gGf3iIfWgOgH/6gHf1iIfWgOgH/6gHf2iIfWgOgH/6gHf2iIfWgOgH/6gGf2iIfWgOgH/6gGf2iIfWgOgH/6gG
					f3iIfWgOgH/6gGf2iIfWgOgH/6gGf2iIfWgOgH/6gHf2iIfWgOgH/6gHf2iIfWgOgH/6gHf1iIfWgOgH/6gFf5iIfWgOgH/7f/gBiIfWgOgH/6f8gHiIfWgO
					gH/6f7gIiIfWgOgH/6f6gJiIfWgOgH/6f7gIiIfWgOgH/6f7gHiIfWgOgH/6f9gFiIfWgOgH/7f/gCiI]],
				["UpperLeg.R"] = [[
					gphagG7hiSgEwJgqhcgF63iYfgxMgrhdgD6NiefAyKgrhfgC5nijeoy8gshggC5NimeXzcgshggB5EineRzogshggC5NimeXzcgrhfgC5nijeoy8grhdgD6N
					iefAyKgqhcgF63iYfgxMgphagG7hiSgEwJgohYgI8GiMgrvGgnhWgJ8liJhNuKgnhVgL87iHhptZgmhUgL9IiHh6s5gmhUgM9NiGh/svgmhUgL9IiHh6s5gn
					hVgL9BiNhetNgohUgK9Cicg2tLgphTgK9OiogfsvgphSgL9UisgcsfgphTgL9QiqgbspgphTgL9NipgasygphUgL9Kipgas5gphUgL9IiogZs9gphUgL9Hio
					gZs/gphUgL9IiogZs9gphUgL9Kipgas5gphTgL9NipgasygphTgL9QiqgbspgphSgK9SirgcslgphTgK9EikghtFgohVgK86iWg9tegnhVgL89iJhltUgmhU
					gL9IiHh6s5gmhUgM9NiGh/svgmhUgL9IiHh6s5gnhVgL87iHhptZgnhWgJ8liJhNuKgohYgI8GiMgrvG]],
				["LowerLeg.R"] = [[
					gsg9f2tUfSf/9Fgsg+f3tqfZfl86gsg+f4uEfefR8ugsg/f5ucfifC8hgsg/f5uufme58YgshAf5u0fne38Vgsg/f5uufme58Ygsg/f5ucfifC8hgsg+f4uE
					fefR8ugsg+f3tqfZfl86gsg9f2tUfSf/9Fgsg9f2tEfJga9Mgsg8f1s6fBg19Pgrg8f1s1e7hN9Qgrg8f1s0e4hc9Qgrg8f1s0e3hi9Qgrg8f1s0e4hc9Qgs
					g8f1sre8hA9Vgsg7f0sVfDgW9ggsg7f0sDfHf79ngsg7f0sDfIf29ogsg7f0sLfIf29kgsg7f0sSfJf39hgsg7f0sYfJf39fgsg7f0scfJf39dgsg7f0sdfJ
					f39dgsg7f0scfJf39dgsg7f0sYfJf39fgsg7f0sSfJf39hgsg7f0sLfIf29kgsg7f0sEfIf29ngsg7f0sMfHgA9kgsg8f0shfCgf9bgrg8f1sye7hI9Sgrg8
					f1s0e4hc9Qgrg8f1s0e3hi9Qgrg8f1s0e4hc9Qgrg8f1s1e7hN9Qgsg8f1s6fBg19Pgsg9f2tEfJga9M]],
				["Foot.R"] = [[
					gqgegR7qf+gBwDgqgegR7qgDf+wDgqgegR7qgGf8wDgqgegR7qgJf7wDgqgegR7qgMf5wDgqgegR7qgNf5wDgqgegR7qgMf5wDgqgegR7qgJf7wDgqgegR7q
					gGf8wDgqgegR7qgDf+wDgqgegR7qf+gBwDgqgegR7qf4gFwDgqgegR7qfzgHwDgqgegR7qfvgKwDgqgegR7qftgLwDgqgegR7qftgLwDgqgegR7qftgLwDgq
					gegR7qfvgKwDgqgegR7qfzgIwDgqgegR7qf1gHwDgqgegR7qf1gGwDgqgegR7qf1gGwDgqgegR7qf2gGwDgqgegR7qf2gGwDgqgegR7qf2gGwDgqgegR7qf2
					gGwDgqgegR7qf2gGwDgqgegR7qf2gGwDgqgegR7qf2gGwDgqgegR7qf1gGwDgqgegR7qf1gGwDgqgegR7qf1gGwDgqgegR7qfygIwDgqgegR7qfvgKwDgqge
					gR7qftgLwDgqgegR7qftgLwDgqgegR7qftgLwDgqgegR7qfvgKwDgqgegR7qfzgHwDgqgegR7qf4gFwD]],
				["Toe.R"] = [[
					gqgOgH/7f/gCiIgqgOgH/7gCf9iIgqgOgH/6gEf6iIgqgOgH/6gGf3iIgqgOgH/6gHf1iIgqgOgH/6gIf0iIgqgOgH/6gHf1iIgqgOgH/6gGf3iIgqgOgH/6
					gEf6iIgqgOgH/7gCf9iIgqgOgH/7f/gCiIgqgOgH/6f7gIiIgqgOgH/6f4gMiIgqgOgH/6f1gQiIgqgOgH/6f0gSiIgqgOgH/6f0gTiIgqgOgH/6f0gSiIgq
					gOgH/6f1gQiIgqgOgH/6f3gNiIgqgOgH/6f5gLiIgqgOgH/6f5gLiIgqgOgH/6f5gKiIgqgOgH/6f5gKiIgqgOgH/6f6gKiIgqgOgH/6f6gKiIgqgOgH/6f6
					gJiIgqgOgH/6f6gKiIgqgOgH/6f6gKiIgqgOgH/6f5gKiIgqgOgH/6f5gKiIgqgOgH/6f5gLiIgqgOgH/6f5gLiIgqgOgH/6f3gNiIgqgOgH/6f1gQiIgqgO
					gH/6f0gSiIgqgOgH/6f0gTiIgqgOgH/6f0gSiIgqgOgH/6f1gQiIgqgOgH/6f4gMiIgqgOgH/6f7gIiI]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAh/gW/+hHf4gXgAiBgW/9g6e/gZgAiFgW/8gkeRgZgAiJgW/6gHd3gYgAiKgW/6fpd0gWgAiIgW/7fPeJgVgAiDgW/8e9ezgVgAiAgW/9e3fqgWgAiAgW/9
					e+glgYgAiDgW/8fQhagZgAiIgW/7fqh/gZgAiKgW/6gIiOgXgAiJgW/6gliFgWgAiFgW/8g7hkgVgAiBgW/9hHgzgV]],
				Spine1 = [[
					gAh/gCAJe6gOihf/iBgCAJfIgxipf+iFgCALfghLi9f9iJgCAOf9hYjQf9iKgCAOgbhVjWf+iHgCANg0hEjKf+iDgCAKhDgni1gAh/gCAJhIgEikgBh/gCAJ
					hBfgijgCiDgCAKgufBiygCiHgCANgSetjIgDiKgCAOfzeojVgDiJgCAOfYeyjSgCiFgCAMfDfJjAgBiBgCAKe5fqir]],
				Spine2 = [[
					f/iFfbAee8gUlTf9iHfbAhfFghlkf7iMfcAofbgomMf6iRfcAwf3gnmyf6iSfcAygUgfm7f7iPfcAtgsgSmif9iKfbAlg9gDl4gAiGfbAfhFfzlXgCiFfbAf
					hBfllXgEiJfbAlgxfal3gGiPfcAtgXfXmhgGiSfcAyf6fcm7gFiRfcAwfffomygEiMfcApfKf2mOgCiHfbAhe+gFll]],
				Neck1 = [[
					f+iMfID/fGgqvYf8iOfIDyfTgyvBf6iUfJETfqgyv9f5iZfJFQgGgoxhf6ibfJGCgfgUyrf7iXfJGEgwf+ysf9iRfIFTg5frxkgAiMfIEVg8fcwAgDiMfIDy
					g1fSvCgFiRfID9gjfNvWgHiXfJEwgIfSwugHibfJFtftfhyNgGiafJGKfYf3y2gEiUfJFwfLgMyQgBiOfIEyfEgdwy]],
				Neck2 = [[
					f8itezG8fOgzz1f5iueyG9fcg5z4f4i2e1Hdfzg10ff4i9e6IGgMgm1Qf6jAe9IfghgQ1rf8i8e9IUgvf51ff/i1e5Hug2fk0zgCiue0HHg2fT0EgFiteyG4
					gsfJzxgIiyezHKgZfI0IgIi6e3HygBfR04gHi/e8IWfpfk1igFi/e9IefXf81qgCi5e7IDfMgS1Lf/ixe2HZfJgl0a]],
				Head = [[
					f6jMerAFe6gMhtf3jOerAGfAf2h5f2jVevAHfTfhiSf3jde2AIfvfRinf6jge6AJgNfIipf9jce5AIgmfKiYgBjVe0AGg5fWh/gFjNeuAFhFfphugIjMerAF
					hFf/hxgJjRetAGg4gViFgJjZezAIgggoiegHjfe5AJgCg1irgEjfe7AIfmg4iigBjZe3AHfPgxiLf9jRewAGfAgih0]],
				Jaw = [[
					f5jOeI/1hHf+jAf4jQeH/2g+gTizf3jZeM/4gogligf5jheS/3gJgyixf8jkeX/2fqg1i4f/jgeW/2fSgvivgDjYeQ/2fBghiugFjQeK/1e5gNi/gIjOeH/1
					e8f3i8gJjUeJ/3fMfjingIjeeP/3fnfTipgGjkeV/2gHfMi2gCjjeX/2gjfNi1f/jceT/3g4fXinf8jTeN/1hEfoi4]],
				Crest = [[
					fzkreSKrfXg730fykteTLCeYhj4Dfzk1eaLteFhc4nf3k9eiMTepgc5Kf9lAenMbfufA5SgCk8ekMCgvd544gIk0edLUhMds4RgMkseVKxg8ee32gOkreSKw
					gTfv36gOkweWLVfzgz4ZgLk6eeMEf2hL4/gGlAelMcgagz5TgAk/enMPhAgJ5If7k4ehLlhHf04lf2kweYK6gfgJ4D]],
				["UpperArm.L"] = [[
					fciCe9yaRJlH06fZiEe+y6RHkh0mfXiLe/0HQ0jIzdfWiSe/1fQXhYxvfWiVe/2oP6fxv5fYiSe+3WPiepuVfaiMe+3tPQeDtTfdiHe932PDd6swfgiHe933
					O+eGspfiiLe83xPCels/fkiRe83bPOfbt3fkiUe92tPggpvVfjiSe91hP5iKxNfhiMe90GQYjszBffiFe9y4Q2kz0W]],
				["LowerArm.L"] = [[
					fLhee6n39SXflmfIhhe5oP9yZOkvfFhqe1pB+UcijWfDhzewp6+Wgnh1fCh5erqo91kdgmfDh6enrF9HnRf3fFh2ekrU8nowfpfIhzeirZ8gpAf2fMhyeirV
					8xoNgVfPh1eirH9RmdhDfRh5ekqu91j2h9fSh5enqI+MggjEfShzespY+Ic3kPfQhqeyom9sZqlOfOhhe3oB9RXrlv]],
				["UpperArm.R"] = [[
					giiHe933xBiCsqgfiJe831xBhtswgdiOe83ow5hDtWgciTe93IwqgBuigciUe92KwUeowPgeiPe900v4dEyJggiIe9zbvYbszxgjiCe9yiu+a80vgliCe+yj
					u1bF03goiIe+zdvBcH0HgqiPe/00vadvypgqiUe/2Hv4fewzgpiUe/3CwSg3vDgniPe+3kwohutwgliJe93zw4iEs+]],
				["LowerArm.R"] = [[
					g2hyeirYDaXSgEgzh0eirPDAYkgqgwh3ejq8Ccawhegvh5elqcB9dxifguh2eqpxBzhVjqgvhvevo/CEk3kxgxhle1oRCjniljgzhfe5n4Czoqlwg2hfe6n/
					Chn4lQg6hle3omB7lSkFg8hvezpeBmhdilg+h3etqTB3dYhKg+h6epq5CiZ/gKg8h4elrODMX1fsg5h0ejrXDgW+ft]],
				Tail1 = [[
					gAiBgsechUhB/6gBiDgsdhg0g//3gCiHgsdOgNgv/3gDiLgsdwfkgY/6gDiMgseve/f+/8gDiJgsfiekfm/9gCiEgsfoeZfR/8gBiBgse8ehfC/7f/iBgsd8
					e7e+/4f+iFgsdRfffH/2f9iJgsdZgIfc/4f9iMgseOgvf1/7f9iLgsfNhQgO/9f+iHgsfshjgl/8f/iCgsfXhlg3/7]],
				Tail2 = [[
					gCiEhKfSkAgj/ugDiHhKdciegu/ygDiMhKcTghgt/xgCiPhKcnehge/xgBiOhKeKcxgL/xgAiKhKf7bif8/rf/iFhKgvbEfx/mf+iDhKgEbefk/qf9iFhKeW
					csfW/xf9iKhKcueffR/xf+iOhKcRgffZ/wf+iPhKdSiafs/yf/iMhKfGj8f9/vgBiHhKghk0gJ/ngCiEhKglk2gV/n]],
				Tail3 = [[
					gKiFhoeynQgH/IgHiMhocglVgP/WgDiThoabihgV/Zf/iVhoZ7fUgO/Zf7iShobVcNf8/af3iKhoduZvfx/Sf1iEhnfgYUfz/Df1iDhofgYQf5/Cf3iIhodu
					Zkf2/Qf7iQhobVcAft/Zf/iVhoZ7fEft/ZgDiUhoaaiSf7/agHiOhocglJgL/YgKiGhneynJgQ/KgLiDhnfwn5gK/A]],
				Tail4 = [[
					gXiIiDcwqDga+MgRiTiEavoigE+YgIieiEYJlkf7+gf+ihiEWrhsfu+jf0iaiEXTdifU+rfsiOiDZoZwe8+sfniFiCcHXAe9+bfniEiCdGV3fW+MfriNiEb7
					Wgfz+RfziZiEZZYzgB+df9ihiEXMcTgK+hgHifiEWugZgd+ngQiViEYVkdg5+ugXiJiDa+nzhH+mgZiDiCc3pyg5+S]],
				["UpperLeg.L"] = [[
					fahLgN2admgo2sfZhNgP4udhfo0KfYhTgR7vdVenvofWhYgS+pdFdOoRfVhagS/idObjhIfThYgR/gd0bMeafThVgP/td+cYfQfThSgN/wdteJilfUhRgL/Z
					dLfalbfVhUgJ+zcsgYn+fXhXgH9kcchRrofZhZgH8EcXhxu0fahXgH60cch4w/fbhSgI5vcqhpyofbhNgK4YdChN0d]],
				["LowerLeg.L"] = [[
					fXgqgNkvfaft/ofVgtgIhMgVfQ/9fSg3gAhAhcfJ/7fPhIf2lYi4fl/ZfLhYfysjkVgn9GfKhcfyx6kshp6CfMhXfv0zj0h438fPhMft2AiYhh3DfShGfs0p
					hChS4YfVhEfsxpf6hH6qfXhBfvvUfAg78DfZg9f0tXedgy9BfZg5f5rBeRgl9+fagyf+oLecgT+4fZgsgElse3f//d]],
				["Foot.L"] = [[
					fWgeg07pe3gqwDfWgqgx7SftgMwsfWg0go7AgufjxIfWg6gc6yh6exxVfWg8gN6pjEeAxUfWg4f/6sjedxxIfWgwf06/i2eOw2fWgkfu7bhofCwXfWgefy7q
					gZfxwDfWgef87qfZgXwDfWgegF7oemg0wCfWgegO7meHhGwBfWgegY7md8hNwBfWgegh7meEhIwBfWgegq7neZg8wC]],
				["Toe.L"] = [[
					fWgOgq/5fShGiHfWgZgo/3f0gTi2fWgjgg/zgcfSjYfWgpgU/shKeEjqfWgqgF/kh3c3jsfWgmf3/hiIcdjhfWgefs/qhxdJjIfWgTfl/1hBebigfWgOfp/6
					gQfoiIfWgOfy/6fngmiIfWgOf7/4fHhXiHfWgOgF/2ezh1iHfWgOgO/1esh/iHfWgOgY/1exh4iHfWgOgh/3e+hjiH]],
				["UpperLeg.R"] = [[
					gthRgM/difg8lHgrhSgK/LjGgImcgqhVgI+QjefJpxgohYgH8zjoebtWgmhYgH7ZjoeJwBglhUgI6SjeeNx0glhPgJ5IjLejzfgmhMgL3fitfF1igmhMgO3f
					icf41kgohQgQ6Jikg4yPgphVgS9Wi0iBsQgrhZgS/Wi8jrkSgshagS/gifk3fNgthXgQ/liCkWefgthTgO/yiIixgo]],
				["LowerLeg.R"] = [[
					gvhHft2ReZev24gthFfrzFfjez5pgqhCftwZglfA7cgog/fxuWhVfK8jgng7f2sRhsfU9fgmg2f7pohsfk+dgngvgBm0hYf3/OgogrgIk9g3gK/lgqgrgLin
					gKgj/4gsgxgEglfKg3/9gvg/f6imd5gv/zgzhRfzo9cWf++fg2hcfyvlbUez7hg2hafxznbpeJ40gzhSfu1kc4eR3X]],
				["Foot.R"] = [[
					gqgefu7pfEgjwDgqgef37qgIf7wDgqgegA7phDfZwDgqgegK7nhsfBwCgqgegT7miBe1wBgqgegc7miCe0wBgqgegm7nhze9wBgqgegv7ohYfNwCgqgkgz7d
					gwfkwZgqgwgt7Jf1gHw8gqg4gi65eug1xQgqg8gU6tdfhpxWgqg6gG6pcmiNxPgqg0f560cviFxAgqgqfx7MduhZwo]],
				["Toe.R"] = [[
					gqgOfk/5fag6iHgqgOft/6gFf4iIgqgOf3/5grfAiHgqgOgA/3hFeYiHgqgOgJ/1hSeEiHgqgOgT/1hTeDiHgqgOgc/2hJeRiHgqgOgm/4g4eriHgqgTgq/4
					gefRihgqgegl/1f5gMjJgqgmga/wfOhUjjgqgqgN/oeeiljtgqgpf+/hd7jfjogqgjfx/ld/jUjWgqgZfo/weliRi2]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAiIgW/7gAgAiCgAh4gW/5f0e1iCgAh8gW/4fveWiCgAiLgW/5f0e1iCgAiIgW/7gAgAiCgAh4gW/5gMhLiCgAh8gW/4gRhqiCgAiLgW/5gMhLiC]],
				Spine1 = [[
					gAiFgCADgAgAhkf/h2gDADgThJgzf+h5gDAFgbhog+f/iIgDAFgVhJhvgAiFgCADgAgAhkgBh2gDADfte3gzgCh5gDAFfleYg+gBiIgDAFfre3hv]],
				Spine2 = [[
					gAiJfbAbgAgAlEf8h4fbAPgZhHjif6h8fbATglhlj4f8iNfbAggdhGlZgAiJfbAbgAgAlEgEh4fbAPfne5jigGh8fbATfbebj4gEiNfbAgfje6lZ]],
				Neck1 = [[
					gAiPfIFYgAgAxvf6h8fHD0gyg5vFf4iBfHELhIhPvrf6iUfIFyg4gzySgAiPfIFYgAgAxvgGh8fHD0fOfHvFgIiBfHELe4exvrgGiUfIFyfIfNyS]],
				Neck2 = [[
					gAize4JCgAgA2Qf5idexHAg7gvz7f3iiezHdhVhB0cf6i4e6JihAgo2ugAize4JCgAgA2QgHidexHAfFfRz7gJiiezHdere/0cgGi4e6JifAfY2u]],
				Head = [[
					gAjTe3AQgAgAj5f5i8eqAHgVgjiWf3jCetAJgfgwisf7jYe7ATgbghkOgAjTe3AQgAgAj5gHi8eqAHfrfdiWgJjCetAJfhfQisgFjYe7ATflffkO]],
				Jaw = [[
					gAjbeU/4gAgAisf4jAeH/Uf2fZmgf1jGeK/efvfJlrf6jgeY/7fsfah2gAjbeU/4gAgAisgIjAeH/UgKgnmggLjGeK/egRg3lrgGjgeY/7gUgmh2]],
				Crest = [[
					gAk1esMGgAgA5Cf6kceVLwe+iC4qf4kieaMvg5gJ5hf8k6exNNibeR5tgAk1esMGgAgA5CgGkceVLudvhw4kgIkieaMvfHf35hgEk6exNPhGeK50]],
				["UpperArm.L"] = [[
					fdiIe9vERHma3GfXh0fArwTAn35lfUh5fBsmTDnH5bfXiNfAv4RnlK3MfdiIe9vERHma3Gfkhze7rYRZpH4cfmh3e6sHQ1o83zfkiMe7vsQPmr2A]],
				["LowerArm.L"] = [[
					fKhlfCqQ+KiOh5fEhVfQqC+MdeiPfChZfPqQ+OeShefDhrfEqq+Bi0ggfKhlfCqQ+KiOh5fQhTfIps+HePkdfThXfEpq+JfYklfRhpe8p7+Fjlin]],
				["UpperArm.R"] = [[
					gjiIe9vEu5Zm3Ggchze7rYunW54cgah3e6sHvLXE3zgciMe7vsvxZV2AgjiIe9vEu5Zm3Ggph0fArwtAYJ5lgsh5fBsms9Y55bgpiNfAv4uZa23M]],
				["LowerArm.R"] = [[
					g2hlfCqQB2dyh5gwhTfIpsB5hxkdgthXfEpqB3goklgvhpe8p7B7cbing2hlfCqQB2dyh5g8hVfQqCB0iiiPg+hZfPqQByhuheg9hrfEqqB/dMgg]],
				Tail1 = [[
					gAiLgsfbg4f0/+gCh8gsdrgef7/5gCh/gsd9fygC/7gCiPgsftfPgL/+gAiLgsfbfIgM/+f+h8gsdrfigF/5f+h/gsd9gOf+/7f+iPgsftgxf1/+]],
				Tail2 = [[
					gCiMhKipirfX/wgDiAhKfohGfx/+gCiDhKeqe2gN/8gAiPhKhqdSgh/1f+iMhKipdVgp/wf9iAhKfoe6gP/+f+iDhKeqhKfz/8gAiPhKhqiuff/1]],
				Tail3 = [[
					gHiHhojmksfH/bgFiBhog4iyfZ/2gAiGhoeJfPgH/7f7iMhog5cGgh/vf5iHhojmbUg5/bf7iBhog4dOgn/2gAiGhoeJgxf5/7gFiMhog5j6ff/v]],
				Tail4 = [[
					gPiAiEiHmFfc/VgKh/iGg8k3fR/mf+iJiGdYgyf6/3f0iKiGejcNgP/ufxiAiEiHZ7gk/Vf2h/iGg8bJgv/mgCiJiGdYfOgG/3gMiKiGejjzfx/u]],
				["UpperLeg.L"] = [[
					fXhWgS0/d1gi4CfWhHgV8lcyett9fVhLgW5hdmW5PMfWhagV/2eXdjgafXhWgS9weJgjrlfYhFgP/wcSf2hJfZhJgN6ZcvhmxtfYhYgPrdewiG9x]],
				["LowerLeg.L"] = [[
					fUg1gWeuguf1/9fQgtgAWCiYgN+TfJhogM5rm8hnxtfQhZf07Ui+gswXfWg/f59xggfprsfXhDftxMfIgR69fYgqgBkqfRgi/ofXhCgnrbfZgc94]],
				["Foot.L"] = [[
					fWg4g+7GgHf8xAfWhFgg6xiHepxVfWhEf96HmTb8w4fWg2fg7Cigedw2fWgjfb8Vf6gAu2fWgef/7oeqgywCfWgego7peygtwCfWgnhF4Le5gx05]],
				["Toe.L"] = [[
					fWgng2/1gEf5jOfWg0gZ/rhSd2jrfWgzf1+5j2ZkjjfWgkfY/thjdgjHfWgUfQ/+f6gDgvfWgOf1/4fJhTiHfWgOge/5fOhLiHfWgUhD+8fWhLoA]],
				["UpperLeg.R"] = [[
					gphWgS9wh3fdrlgohFgP/wjugKhJgnhJgN6ZjReaxtgohYgPrdhQd69xgphWgS0/iLfe4CgqhHgV8ljOhTt9grhLgW5hiapHPMgqhagV/2hpidga]],
				["LowerLeg.R"] = [[
					gqg/f59xfggXrsgphDftxMg4fv69gogqgBkqgvfe/ogphCgnrbgnfk94gsg1gWeufSgL/9gwgtgAWCdofz+Tg3hogM5rZEeZxtgwhZf07UdCfUwX]],
				["Foot.R"] = [[
					gqgjfb8VgGgAu2gqgef/7ohWfOwCgqgego7phOfTwCgqgnhF4LhHfP05gqg4g+7Gf5gExAgqhFgg6xd5hXxVgqhEf96HZtkEw4gqg2fg7Cdghjw2]],
				["Toe.R"] = [[
					gqgUfQ/+gGf9gvgqgOf1/4g3etiHgqgOge/5gye1iHgqgUhD+8gqe1oAgqgng2/1f8gHjOgqg0gZ/reuiKjrgqgzf1+5cKmcjjgqgkfY/tedigjH]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAiLgWAEgAgAhmgAiIgZAFgAgAh+gAh/gfAJgAgAi4gAh2gmAQgAgAj2gAhygqAUgAgAkXgAiOgDABgAgAf1gAidfrAJgAgAdIgAidfrAJgAgAdIgAidfrAJ
					gAgAdIgAibftAIgAgAdcgAiXf5ADgAgAemgAiRgIABgAgAgIgAiMgTADgAgAhTgAiLgWAEgAgAhmgAiLgWAEgAgAhmgAiLgWAEgAgAhm]],
				Spine1 = [[
					gAiNgCAZgAgAk4gAiKgFAbgAgAlGgAiDgMAhgAgAlpgAh7gTAogAgAmOgAh3gXAsgAgAmhgAiOfvAMgAgAjTgAiZfXADgAgAhRgAiZfXADgAgAhRgAiZfXAD
					gAgAhRgAiYfaADgAgAhggAiVflAHgAgAidgAiRf0APgAgAjsgAiOf/AXgAgAkogAiNgCAZgAgAk4gAiNgCAZgAgAk4gAiNgCAZgAgAk4]],
				Spine2 = [[
					gAiZfdBCgAgAoBgAiXffBEgAgAoGgAiRfnBHgAgAoRgAiKfuBKgAgAodgAiHfyBMgAgAokgAiWfIAugAgAmqgAicevAdgAgAlTgAicevAdgAgAlTgAicevAd
					gAgAlTgAiceyAfgAgAlfgAibe+AogAgAmNgAiafNA1gAgAnIgAiZfZA/gAgAn2gAiZfdBCgAgAoBgAiZfdBCgAgAoBgAiZfdBCgAgAoB]],
				Neck1 = [[
					gAijfLFMgAgAxbgAihfOFmgAgAyDgAibfVGrgAgAzigAiVfdH6gAgA1DgAiSfhImgAgA1zgAife2EAgAgAvdgAijecCJgAgAregAijecCJgAgAregAijecCJ
					gAgAregAijefCUgAgAr5gAijerDAgAgAtggAije7EDgAgAvjgAijfHE8gAgAxDgAijfLFMgAgAxbgAijfLFMgAgAxbgAijfLFMgAgAxb]],
				Neck2 = [[
					gAjHe7IBgAgA1LgAjFe/IugAgA18gAjBfLKkgAgA3vgAi8fYMqgAgA5fgAi5feN0gAgA6UgAjAehGWgAgAzGgAi9d/DXgAgAuPgAi9d/DXgAgAuPgAi9d/DX
					gAgAuPgAi+eDDngAgAuvgAjBeSEsgAgAwqgAjEemGTgAgAzCgAjGe3HqgAgA0wgAjHe7IBgAgA1LgAjHe7IBgAgA1LgAjHe7IBgAgA1L]],
				Head = [[
					gAjne3AFgAgAh6gAjle+ANgAgAjZgAjhfOAzgAgAnBgAjafgB4gAgAqwgAjXfpCogAgAsqgAjfeYACgAgAhAgAjXdsAYgAgAbOgAjXdsAYgAgAbOgAjXdsAY
					gAgAbOgAjYdwAUgAgAbrgAjdeDAIgAgAdagAjjedABgAgAftgAjmexADgAgAhdgAjne3AFgAgAh6gAjne3AFgAgAh6gAjne3AFgAgAh6]],
				Jaw = [[
					gAjpeT/8gAgAhrgAjrea/+gAgAg6gAjvet/+gAgAe7gAjwfD/zgAgAckgAjwfQ/rgAgAbhgAjfd08NgAgAvFgAjLdK89gAgAtlgAjLdK+dgAgApygAjLdK+I
					gAgAqvgAjNdO+0gAgAojgAjWdg/ZgAgAmJgAjhd5/wgAgAj4gAjoeO/6gAgAiIgAjpeT/8gAgAhrgAjpeT/8gAgAhrgAjpeT/8gAgAhr]],
				Crest = [[
					gAlGefKqgAgA30gAlGevMUejhj5HgAlDfWQKfBg47wgAk4f/TphFfQ9egAkvgUUoh2e990gAk8d6J/gAgA3NgAkkcvGme/h3zUgAkkcvHLfahL0IgAkkcvHL
					gme10IgAknc2G3hDeKzrgAkydSHigAgA0mgAk+d4Jjevht2sgAlFeXLjfMhC4kgAlGefL6g1e/42gAlGefLKhZeZ4LgAlGefKqgAgA30]],
				["UpperArm.L"] = [[
					fdide/29PzgAvRfdibfC3jPVeitvfdiWfJ4fOwasp5fdiQfR4vPHWcl4fdiMfV4lPuUOj1fdiYeq5RPfbMpafdibeR5uQLcfp8fdibeR5uQLcfp8fdibeR5u
					QLcfp8fdibeU5lQIcuqUfdiceg48P+dprwfdidev4AP1e2tlfdide83MPzfxu8fdide/29PzgAvRfdide/29PzgAvRfdide/29PzgAvR]],
				["LowerArm.L"] = [[
					fKiCepqF+PgAipfJiEeprB90jWhefGiKersu7ErPebfDiReztn1yydbLfCiUe5tuyM1hZkfIiMeLrn9bkrgifKiMdyp0+IdXjgfKiMdyp0+IdXjgfKiMdyp0
					+IdXjgfKiLd2p1+JdjjdfKiIeDp6+MePjOfKiFeWqA+PfIi7fKiDelqE+Pf1isfKiCepqF+PgAipfKiCepqF+PgAipfKiCepqF+PgAip]],
				["UpperArm.R"] = [[
					gjide/29wNgAvRgjibfC3jwrhetvgjiWfJ4fxQlUp5gjiQfR4vw5pkl4gjiMfV4lwSryj1gjiYeq5Rwhk0pagjibeR5uv1jhp8gjibeR5uv1jhp8gjibeR5u
					v1jhp8gjibeU5lv4jSqUgjiceg48wCiXrwgjidev4AwLhKtlgjide83MwNgPu8gjide/29wNgAvRgjide/29wNgAvRgjide/29wNgAvR]],
				["LowerArm.R"] = [[
					g2iCepqFBxgAipg3iEeprBCMcqheg6iKersuE8Uxebg9iReztnKONjbLg+iUe5tuN0KfZkg4iMeLrnClbVgig2iMdyp0B4ipjgg2iMdyp0B4ipjgg2iMdyp0
					B4ipjgg2iLd2p1B3idjdg2iIeDp6B0hxjOg2iFeWqABxg4i7g2iDelqEBxgLisg2iCepqFBxgAipg2iCepqFBxgAipg2iCepqFBxgAip]],
				Tail1 = [[
					gAiKgshRgAgA/9gAiGgvhQgAgA/9gAh8g1hNgAgA/+gAhyg8hKgAgA/+gAhtg/hIgAgA/+gAiQgZeFgAgA/7gAiigAc0fOgJ/0gAiigAeEfVgG/7gAiigAeE
					grf6/7gAiggDechlfz/6gAiagPfzhXf5/9gAiSgehHgPf//+gAiMgphwfqgB/8gAiKgshdf4gA/9gAiKgshRgAgA/9gAiKgshRgAgA/9]],
				Tail2 = [[
					gAiIhKiMgAgA/6gAiEhNhxgAgA/8gAh6hUgxgAgA/+gAhwhafsgAgA//gAhrhefIgAgA/+gAiTg3dkgAgA/5f+iogeduecgV/3f/ilgegPeqgP/9gBilgegP
					hWfx/9gDijghgtjJfg/0gDiagtiOitfs/zgAiQg8jVgff+/0f/iIhHjcfVgC/zgAiHhKikfwgB/4gAiIhKiMgAgA/6gAiIhKiMgAgA/6]],
				Tail3 = [[
					gAiDhphXgAgA/9gAiAhrgkgAgA//gAh5hyemgAgA/9gAhxh5cggAgA/zgAhsh8bagAgA/qgAiYhVbVgAgA/pf7isg8c6dqgc/wf8ilg8grd/gT/6gEilg8gr
					iBft/6gJihg/hPktfY/ngIiWhLi7kEfp/mgBiJhaj1guf+/wf+iChljae/gC/yf/iChph8fogB/7gAiDhphXgAgA/9gAiDhphXgAgA/9]],
				Tail4 = [[
					gAiBiHfKgAgA/+gAh/iKd+gAgA/7gAh7iQbDgAgA/mgAh3iWYAgAgA++gAh1iZWcgAgA+hgAihhyXygAgA+6f3iyhZawc2gX/Zf4ijhbfvdTgN/4gIijhbfv
					itfz/4gSifhcgbmSfn/XgPiQhoiSlaf5/cgDiCh3i8g9gB/1f8h7iDiAepf8/5f/h/iHf7fgf///gAiBiHfKgAgA/+gAiBiHfKgAgA/+]],
				["UpperLeg.L"] = [[
					fXhbgG7NdzgAwsfXhYgI8Cdqf2vPfXhRgM9odYffrwfXhKgQ+2dJfHn6fXhGgS/UdCe5lufXhdf53peLgd1dfXhqfowifIhJ7WfXhqfowifIhJ7WfXhqfowi
					fIhJ7WfXhpfqwvfIhI7OfXhlfyxnfFhG6rfXhgf831eOge1QfXhcgE6pd3gGxkfXhbgG7NdzgAwsfXhbgG7NdzgAwsfXhbgG7NdzgAws]],
				["LowerLeg.L"] = [[
					fUg+f3t2gsgA81fUg9f2tKgwgD9JfUg7f0sDg3gL9nfTg6fzrrg8gR9xfTg6fzr1g9gT9tfVg8f1s7ghf29QfWhNf4wegGfl7bfWhNf4wegGfl7bfWhNf4we
					gGfl7bfWhMf5wrgGfl7TfWhHf/xjgGfl6vfVg/f5ucggf18ifUg+f3t0gqf+82fUg+f3t2gsgA81fUg+f3t2gsgA81fUg+f3t2gsgA81]],
				["Foot.L"] = [[
					fWgegR7qgAgAwDfWgegR7qgEf+wDfWgegR7qgLf6wDfWgegR7qgPf3wDfWgegR7qgQf3wDfWgegR7qf2gGwDfWgpgL4HfjgU1BfWgpgL4HfjgU1BfWgpgL4H
					fjgU1BfWgngM4mfigU0cfWghgP6pffgUxsfWgegR7qf0gHwDfWgegR7qf+gBwDfWgegR7qgAgAwDfWgegR7qgAgAwDfWgegR7qgAgAwD]],
				["Toe.L"] = [[
					fWgOgH/7gAgAiIfWgOgH/7gCf8iIfWgOgH/6gHf2iIfWgOgH/6gKfyiIfWgOgH/6gKfwiIfWgOgH/6f6gKiIfWgWgI+7fvgeoJfWgWgI+7fvgeoJfWgWgI+7
					fvgeoJfWgVgI/HfugfnafWgPgI/ufrghkDfWgOgH/6f5gLiIfWgOgH/7f/gCiIfWgOgH/7gAgAiIfWgOgH/7gAgAiIfWgOgH/7gAgAiI]],
				["UpperLeg.R"] = [[
					gphbgG7NiNgAwsgphYgI8CiWgKvPgphRgM9oioghrwgphKgQ+2i3g5n6gphGgS/Ui+hHlugphdf5+ii7gzpCgphqfo/kjQiNctgphqfo/kjQiNctgphqfo/k
					jQiNctgphpfq/sjQiEd7gphlfy/pjJhcjLgphgf8+MixgrqMgphcgE79iWgJvXgphbgG7NiNgAwsgphbgG7NiNgAwsgphbgG7NiNgAws]],
				["LowerLeg.R"] = [[
					gsg+f3t2fUgA81gsg9f2tKfQf99Jgsg7f0sDfJf19ngtg6fzrrfEfv9xgtg6fzr1fDft9tgthMfdsafDfw9dgthyfIz/e8fb48gthyfIz/e8fb48gthyfIz/
					e8fb48gthufKzHe9fc5ogthffSwCe/fk7qgshMfittfGfx85gshBfytmfQf988gsg+f3t2fUgA81gsg+f3t2fUgA81gsg+f3t2fUgA81]],
				["Foot.R"] = [[
					gqgegR7qgAgAwDgqgegR7qf8gCwDgqgegR7qf1gGwDgqgegR7qfxgJwDgqgegR7qfwgJwDgqguf59KfugItKgqhKfR/9fcgChVgqhKfR/9fcgChVgqhKfR/9
					fcgChVgqhHfV/1fdgDjFgqg8fm+uflgIo5gqgtf889fygHtlgqghgM75f9gCvqgqgegR7qgAgAwDgqgegR7qgAgAwDgqgegR7qgAgAwD]],
				["Toe.R"] = [[
					gqgOgH/7gAgAiIgqgOgH/7f+gEiIgqgOgH/6f5gKiIgqgOgH/6f2gOiIgqgOgH/6f2gQiIgqggfs/+fzgQe3gqhIe+9OfggRTBgqhIe+9OfggRTBgqhIe+9O
					fggRTBgqhDfC95figSUpgqgxfW/ffrgTaWgqgefv/+f2gMfVgqgRgC/8f+gDhqgqgOgH/7gAgAiIgqgOgH/7gAgAiIgqgOgH/7gAgAiI]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiLgWAEgAgAhmgAiJgWACgAgAhLgAiDgWABgAgAgPgAh/gWABgAgAffgAiAgWABgAgAfngAiKgWAFgAgAh/gAiPgWARgAgAkCgAiQgWAUgAgAkYgAiQgWAU
					gAgAkYgAiQgWAUgAgAkYgAiQgWAUgAgAkYgAiQgWAUgAgAkYgAiQgWAUgAgAkYgAiQgWAUgAgAkYgAiQgWAUgAgAkYgAiQgWAUgAgAkYgAiQgWAUgAgAkYgA
					iQgWAUgAgAkUgAiOgWAMgAgAjWgAiMgWAFgAgAiCgAiLgWAEgAgAhmgAiLgWAEgAgAhmgAiLgWAEgAgAhm]],
				Spine1 = [[
					gAiNgCAZgAgAk4gAiKgCAUgAgAkUgAiEgCAKgAgAjCgAh+gCAFgAgAh/gAh/gCAGgAgAiLgAiMgCAfgAgAlcgAiUgDBGgAgAoPgAiVgDBOgAgAosgAiVgDBO
					gAgAosgAiVgDBOgAgAosgAiVgDBOgAgAosgAiVgDBOgAgAosgAiVgDBOgAgAosgAiVgDBOgAgAosgAiVgDBOgAgAosgAiVgDBOgAgAosgAiVgDBOgAgAosgA
					iVgDBNgAgAongAiSgDA3gAgAnTgAiOgCAfgAgAlfgAiNgCAZgAgAk4gAiNgCAZgAgAk4gAiNgCAZgAgAk4]],
				Spine2 = [[
					gAiZfdBCgAgAoBgAiVfcA3gAgAnUgAiLfbAigAgAltgAiDfbAUgAgAkZgAiFfbAXgAgAkogAiZfdBPgAgAowgAiofhCcgAgAsNgAiqfhCrgAgAsxgAiqfhCr
					gAgAsxgAiqfhCrgAgAsxgAiqfhCrgAgAsxgAiqfhCrgAgAsxgAiqfhCrgAgAsxgAiqfhCrgAgAsxgAiqfhCrgAgAsxgAiqfhCrgAgAsxgAiqfhCrgAgAsxgA
					iqfhCpgAgAsrgAikffB/gAgArDgAicfdBQgAgAoygAiZfdBCgAgAoBgAiZfdBCgAgAoBgAiZfdBCgAgAoB]],
				Neck1 = [[
					gAijfLFMgAgAxbgAiefKEXgAgAwGgAiSfICxgAgAs+gAiJfHBugAgAqUgAiLfHB5gAgAqzgAikfMFogAgAyGgAi2fSJ3gAgA3FgAi5fTKngAgA3ygAi5fTKn
					gAgA3ygAi5fTKngAgA3ygAi5fTKngAgA3ygAi5fTKngAgA3ygAi5fTKngAgA3ygAi5fTKngAgA3ygAi5fTKngAgA3ygAi5fTKngAgA3ygAi5fTKngAgA3ygA
					i5fTKfgAgA3qgAixfQIagAgA1ngAinfMF7gAgAyhgAijfLFMgAgAxbgAijfLFMgAgAxbgAijfLFMgAgAxb]],
				Neck2 = [[
					gAjHe7IBgAgA1LgAjAe3GtgAgAzkgAiveuEHgAgAvqgAiheoCdgAgAsPgAijepCugAgAs3gAjJe+IvgAgA19gAjefUPigAgA7bgAjgfXQtgAgA8GgAjgfXQt
					gAgA8GgAjgfXQtgAgA8GgAjgfXQtgAgA8GgAjgfXQtgAgA8GgAjgfXQtgAgA8GgAjgfXQtgAgA8GgAjgfXQtgAgA8GgAjgfXQtgAgA8GgAjgfXQtgAgA8GgA
					jgfXQhgAgA7/gAjYfMNOgAgA55gAjMe/JOgAgA2dgAjHe7IBgAgA1LgAjHe7IBgAgA1LgAjHe7IBgAgA1L]],
				Head = [[
					gAjne3AFgAgAh6gAjfeuACgAgAe5gAjLedA/gAgAYLgAi3eSCzgAgAS+gAi7eUCagAgAT3gAjpe8AOgAfpjpgAj6fjERgXfJv6gAj7fpEefOhxwLgAj7fpFL
					gQfgxagAj7fpFfgresx1gAj7fpEhfShowQgAj7fpFAgAgAxJgAj7fpFmg0ebx+gAj7fpElfZhWwagAj7fpE1fxggw4gAj7fpFqg5eSyCgAj7fpEsfkg+wogA
					j7foEiflg9wXgAj3fWClgWe1segAjse+AUgAgGkZgAjne3AFgAgAh6gAjne3AFgAgAh6gAjne3AFgAgAh6]],
				Jaw = [[
					gAjpeT/8gAgAhrgAjbeL/mgAgAk/gAi4d+9kgAgAsMgAicd76vgAgAxkgAihd77TgAgAwqgBjveY/nf6gWk2gCkYfP/8fSgmetf8kZfW/7hke3gAgBkbfZ/9
					fjgTelgDkbfa/5ewgzeDf8kZfW/8hce9f6gAkbfY/+gAgAe5gEkbfa/3egg9d4f9kafX/9hNfJfvf/kafY/+gdfsfNgEkcfb/2eXhCdzf+kafX/+g3fZfgf+
					kZfV/+g1fZfigDkPe8/9fQg+fOgAj0ec/9gBf7hTgAjpeT/8gAgAhrgAjpeT/8gAgAhrgAjpeT/8gAgAhr]],
				Crest = [[
					gAlGefKfgAgA3rgAk4eFIrewht1ygAkLdTFHe9ijxGgAjbc2Czfthfs+gAjkc6DQgLfPt/gBlKeuNJhdd55tgBlHggX/h/eL+2f9lGgoXnhbhi+zgBlAgvZI
					eZf9/MgCk+gxaVc7fg/Vf9lGgpZnezie/OgAlCgta2gAgA/kgDk9gybnhXdn/kf+lFgpYsjHgV+/f/lDgsYhhngB/DgDk9gyZweseY/Tf+lEgqY0eBh5/Df+
					lFgoZaeFh9/LgClQgAVresfZ+PgAlOe2OFhGe96dgAlGefLihxd54bgAlGefK0haeb34gAlGefKfgAgA3r]],
				["UpperArm.L"] = [[
					fdide/29PzgAvRfdiYe+3HPzf2vDfdiLe93cPzffuifdiBe93sP0fNuHfdiDe93pP0fPuLfdiffA4DOWaUqCfdi0fF28PvRDjBfdi3fG2WQwPBhlfdi3fG2W
					QwPBhlfdi3fG2WQwPBhlfdi3fG2WQwPBhlfdi3fG2WQwPBhlfdi3fG2WQwPBhlfdi3fG2WQwPBhlfdi3fG2WQwPBhlfdi3fG2WQwPBhlfdi3fG2WQwPBhlfd
					i3fG2dQkPWh0fdiufD3wOdVXmMfdiifA3lO4dis9fdide/29PzgAvRfdide/29PzgAvRfdide/29PzgAvR]],
				["LowerArm.L"] = [[
					fKiCepqF+PgAipfKh9eoqH+PgTiifKhyemqK+Og9iUfKhoelqN+NhgiIfKhqelqN+NhbiKfFiUeitb7no6e9e/jCewwPyPzLYTe+jJe1wavb0uWte+jJe1wa
					vb0uWte+jJe1wavb0uWte+jJe1wavb0uWte+jJe1wavb0uWte+jJe1wavb0uWte+jJe1wavb0uWte+jJe1wavb0uWte+jJe1wavb0uWte+jJe1wavb0uWte+
					jIe0wZv60fW+fBixenvX3SvAbgfHiNemrz9bkHhGfKiCepqF+PgAipfKiCepqF+PgAipfKiCepqF+PgAip]],
				["UpperArm.R"] = [[
					gjide/29wNgAvRgjiYe+3HwNgKvDgjiLe93cwNghuigjiBe93swMgzuHgjiDe93pwMgxuLgjiffA4DxqlsqCgji0fF28wRu9jBgji3fG2WvQw/hlgji3fG2W
					vQw/hlgji3fG2WvQw/hlgji3fG2WvQw/hlgji3fG2WvQw/hlgji3fG2WvQw/hlgji3fG2WvQw/hlgji3fG2WvQw/hlgji3fG2WvQw/hlgji3fG2WvQw/hlgj
					i3fG2dvcwqh0gjiufD3wxjqpmMgjiifA3lxIies9gjide/29wNgAvRgjide/29wNgAvRgjide/29wNgAvR]],
				["LowerArm.R"] = [[
					g2iCepqFBxgAipg2h9eoqHBxftiig2hyemqKByfDiUg2hoelqNBzegiIg2hqelqNBzeliKg7iUeitbEZXGe9hBjCewwPNxM1YThCjJe1waQlLSWthCjJe1wa
					QlLSWthCjJe1waQlLSWthCjJe1waQlLSWthCjJe1waQlLSWthCjJe1waQlLSWthCjJe1waQlLSWthCjJe1waQlLSWthCjJe1waQlLSWthCjJe1waQlLSWthC
					jIe0wZQGLhW+g/ixenvXIuRAbgg5iNemrzClb5hGg2iCepqFBxgAipg2iCepqFBxgAipg2iCepqFBxgAip]],
				Tail1 = [[
					gAiKgshRgAgA/9gAiIgshKgAgA/+gAiEgsg7gAgA/+gAiBgsgvgAgA/+gAiBgsgxgAgA/+gAiIgshOfxgB/9gAiLgshhfagB/8gAiLgshjhQf+/7gAiLgshj
					fpgB/8gAiLgshjfDgC/8gAiLgshjhJf+/7gAiLgshjgAgA/9gAiLgshje3gC/7gAiLgshjg9f+/8gAiLgshjgXf//8gAiLgshjewgC/7gAiLgshjgrf//8gA
					iLgshigrf//8gAiLgshcfOgC/8gAiKgshUgEgA/9gAiKgshRgAgA/9gAiKgshRgAgA/9gAiKgshRgAgA/9]],
				Tail2 = [[
					gAiIhKiMgAgA/6gAiGhLiZgAgA/5gAiChLi3gAgA/3gAh/hLjPgAgA/1gAiAhLjLgAgA/1gAiGhKhtf7gA/8f/iIhKgOeUgJ/8gCiIhKf9h1f8/8f/iIhKf9
					gaf5//f+iIhKf8d2gK/6gCiIhKf9hZf//9gAiIhKf9hAf3/+f+iIhKf8dygI/6gCiIhKf9g2gC/+gBiIhKf9hif2/9f+iIhKf8d5gG/7gBiIhKf9gPgF//gB
					iIhKf/h4f2/7f/iIhKgxe2gD/9gAiIhKh1f8gA/8gAiIhKiMgAgA/6gAiIhKiMgAgA/6gAiIhKiMgAgA/6]],
				Tail3 = [[
					gAiDhphXgAgA/9gAiBhph5gAgA/7gAh9hpjDgAgA/2gAh5hokAgAgA/vgAh6hoj1gAgA/wf/iChpgcgVf+//f8iIhodNdogG/xgGiIhocphSgP/ygAiIhoco
					hpfs/xf6iIhocodXgB/tgFiIhocpgjgT/zgCiIhocoiMfv/vf6iIhocodpf7/ugDiIhocpfygV/zgEiIhocoijf0/tf6iIhocoeHf2/wgCiIhocpfCgV/zgF
					iIhocuiqf5/tf8iGhpeYfMf7/8gAiEhpgofvgB//gAiDhphXgAgA/9gAiDhphXgAgA/9gAiDhphXgAgA/9]],
				Tail4 = [[
					gAiBiHfKgAgA/+gAh+iHgAgAgA//gAh3iGh4gAgA/7gAhyiGjZgAgA/zgAhziGjHgAgA/1gAiCiHdzgqf//6f3iNiGY3d6fu/HgIiPiGYCgBgr++gDiOiGYB
					iYfz+4f1iOiFYBeBfg+6gGiOiGYBfSgo+9gGiOiGYAilf/+3f1iOiFYBelfZ+8gDiOiGYBemgh+8gIiOiGYAilgL+3f2iOiGYBfQfV+9gAiOiGYBeCgY+6gK
					iOiGYKiVgW+7f7iJiHaof/fv/if/iDiHeBfogA/7gAiBiHfKgAgA/+gAiBiHfKgAgA/+gAiBiHfKgAgA/+]],
				["UpperLeg.L"] = [[
					fXhbgG7NdzgAwsfXhZgI78dpf3vafXhTgK9RdVfksnfXhOgN+HdHfVqXfXhPgM9/dJfYqxfXhagF7Ndyf/wqfXhjf/3gecgi1pfXhkf+2melgo2lfXhkf+2m
					elgo2lfXhkf+2melgo2lfXhkf+2melgo2lfXhkf+2melgo2lfXhkf+2melgo2lfXhkf+2melgo2lfXhkf+2melgo2lfXhkf+2melgo2lfXhkf+2melgo2lfX
					hkf+2xejgn2afXhggB43eOgX0DfXhdgF6td5gFxffXhbgG7NdzgAwsfXhbgG7NdzgAwsfXhbgG7NdzgAws]],
				["LowerLeg.L"] = [[
					fUg+f3t2gsgA81fUg9f2tLgwgD9JfUg7f0sFg4gK9nfTg6fzrig9gO90fTg6fzrng8gN9yfUg9f2tSgtgA9GfVhCf8wDgZfz7qfVhDf+wvgUfx7QfVhDf+wv
					gUfx7QfVhDf+wvgUfx7QfVhDf+wvgUfx7QfVhDf+wvgUfx7QfVhDf+wvgUfx7QfVhDf+wvgUfx7QfVhDf+wvgUfx7QfVhDf+wvgUfx7QfVhDf+wvgUfx7QfV
					hCf+wmgVfx7VfVhAf6vGgff48MfUg+f4uDgqf+8ufUg+f3t2gsgA81fUg+f3t2gsgA81fUg+f3t2gsgA81]],
				["Foot.L"] = [[
					fWgegR7qgAgAwDfWgegR7qgEf+wDfWgegR7qgLf6wDfWgegR7qgPf3wDfWgegR7qgPf4wDfWgegR7qgAgAwDfWgegR7qfugKwDfWgegR7qfqgNwDfWgegR7q
					fqgNwDfWgegR7qfqgNwDfWgegR7qfqgNwDfWgegR7qfqgNwDfWgegR7qfqgNwDfWgegR7qfqgNwDfWgegR7qfqgNwDfWgegR7qfqgNwDfWgegR7qfqgNwDfW
					gegR7qfrgMwDfWgegR7qf0gHwDfWgegR7qf+gBwDfWgegR7qgAgAwDfWgegR7qgAgAwDfWgegR7qgAgAwD]],
				["Toe.L"] = [[
					fWgOgH/7gAgAiIfWgOgH/7gCf8iIfWgOgH/6gHf2iIfWgOgH/6gKfxiIfWgOgH/6gJfyiIfWgOgH/7gAgAiIfWgOgH/6f1gRiIfWgOgH/6fygViIfWgOgH/6
					fygViIfWgOgH/6fygViIfWgOgH/6fygViIfWgOgH/6fygViIfWgOgH/6fygViIfWgOgH/6fygViIfWgOgH/6fygViIfWgOgH/6fygViIfWgOgH/6fygViIfW
					gOgH/6fygUiIfWgOgH/6f4gLiIfWgOgH/7f+gCiIfWgOgH/7gAgAiIfWgOgH/7gAgAiIfWgOgH/7gAgAiI]],
				["UpperLeg.R"] = [[
					gphbgG7NiNgAwsgphZgI78iXgJvagphTgK9RirgcsngphOgN+Hi5grqXgphPgM9/i3goqxgphagF7NiOgBwqgphjf/3ghkfe1pgphkf+2mhbfY2lgphkf+2m
					hbfY2lgphkf+2mhbfY2lgphkf+2mhbfY2lgphkf+2mhbfY2lgphkf+2mhbfY2lgphkf+2mhbfY2lgphkf+2mhbfY2lgphkf+2mhbfY2lgphkf+2mhbfY2lgp
					hkf+2xhdfZ2agphggB43hyfp0DgphdgF6tiHf7xfgphbgG7NiNgAwsgphbgG7NiNgAwsgphbgG7NiNgAws]],
				["LowerLeg.R"] = [[
					gsg+f3t2fUgA81gsg9f2tLfQf99Jgsg7f0sFfIf29ngtg6fzrifDfy90gtg6fzrnfEfz9ygsg9f2tSfTgA9GgrhCf8wDfngN7qgrhDf+wvfsgP7QgrhDf+wv
					fsgP7QgrhDf+wvfsgP7QgrhDf+wvfsgP7QgrhDf+wvfsgP7QgrhDf+wvfsgP7QgrhDf+wvfsgP7QgrhDf+wvfsgP7QgrhDf+wvfsgP7QgrhDf+wvfsgP7Qgr
					hCf+wmfrgP7VgrhAf6vGfhgI8Mgsg+f4uDfWgC8ugsg+f3t2fUgA81gsg+f3t2fUgA81gsg+f3t2fUgA81]],
				["Foot.R"] = [[
					gqgegR7qgAgAwDgqgegR7qf8gCwDgqgegR7qf1gGwDgqgegR7qfxgJwDgqgegR7qfxgIwDgqgegR7qgAgAwDgqgegR7qgSf2wDgqgegR7qgWfzwDgqgegR7q
					gWfzwDgqgegR7qgWfzwDgqgegR7qgWfzwDgqgegR7qgWfzwDgqgegR7qgWfzwDgqgegR7qgWfzwDgqgegR7qgWfzwDgqgegR7qgWfzwDgqgegR7qgWfzwDgq
					gegR7qgVf0wDgqgegR7qgMf5wDgqgegR7qgCf/wDgqgegR7qgAgAwDgqgegR7qgAgAwDgqgegR7qgAgAwD]],
				["Toe.R"] = [[
					gqgOgH/7gAgAiIgqgOgH/7f+gEiIgqgOgH/6f5gKiIgqgOgH/6f2gPiIgqgOgH/6f3gOiIgqgOgH/7gAgAiIgqgOgH/6gLfviIgqgOgH/6gOfriIgqgOgH/6
					gOfriIgqgOgH/6gOfriIgqgOgH/6gOfriIgqgOgH/6gOfriIgqgOgH/6gOfriIgqgOgH/6gOfriIgqgOgH/6gOfriIgqgOgH/6gOfriIgqgOgH/6gOfriIgq
					gOgH/6gOfsiIgqgOgH/6gIf1iIgqgOgH/7gCf+iIgqgOgH/7gAgAiIgqgOgH/7gAgAiIgqgOgH/7gAgAiI]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiLgWAEgAgAhmgAiJgWADgCgrhYgAh6gWAEgKhlf7gAiegWAJgDhmiXgAi8gWARf/g/j4gAjHgWAUgAgAkYgAi8gWARgBfBj4gAiegWAJf9eaiXgAh6gWAE
					f2ebf6gAiAgWACf7fBglgAh/gWABgAgAgZgAitgWAMgAg/jJgAjDgWAVf9hmkMgAjFgWAWf8hmkSgAizgWAOgAg/jbgAiKgWACgAgAhIgAh/gWACf6fBgZgA
					iLgWAGf7eahkgAiLgWAFf8e0hmgAiLgWAEf/fwhmgAiLgWAEgAgAhm]],
				Spine1 = [[
					gAiNgCAZgAgAk4f/iLgCAWgHgrkjf+h6gCAJgShkiYf+ihgDAmgOhll0f/jBgDBAgGg/nzgAjMgDBJgAgAobgBjBgDBAf6fBnzgCihgDAmfyebl0gCh5gCAJ
					fueciXgBiBgCANf1fCjXgAh/gCAKgAgAjFf/ixgDAxgHg/m2f+jIgDBIgKhloMf+jKgDBKgKhloUf/i3gDA3gHg/nOgAiLgCASgAgAkHgBh/gCALf1fCjFgC
					iNgCAbfwebk1gBiNgCAaf0e0k4gAiNgCAZf+fwk4gAiNgCAZgAgAk4]],
				Spine2 = [[
					gAiZfdBCgAgAoBf+iWfcA8gLgqnmf6h/fbAagahjkvf6ivfeBZgYhjpIf8jUfgCLgOg9rhgAjgfhCdgAgAsQgEjUfgCLfyfDrhgGivfeBZfoedpIgGh/fbAa
					fmedkugEiJfcAnfwfDmCgAiHfbAhgAgAlqf8jBffBxgPg9qZf6jcfhCZgWhjr+f6jefhCcgWhjsIf8jIffB7gOg9q1gAiVfcAygAgAm/gEiHfcAifwfDlqgG
					iZfdBEfmedn9gEiZfdBEfte2oBgBiZfdBDf8fxoBgAiZfdBCgAgAoB]],
				Neck1 = [[
					gAijfLFMgAgAxbf9iffKEzgXglw0f4iFfICmgxhZsff5i6fNGRg4hVy7f7jhfRI5glgz2GgAjvfSJzgAgA3BgFjhfRI5fbfN2GgHi6fNGRfIery7gIiFfICm
					fPensegFiRfJDgfgfKuegAiOfIDNgAgAt7f7jOfPHmgkg00pf5jqfSJfg8hT2qf5jtfTJrg8hT22f7jVfQIGgkg01OgAiefKEPgAgAv5gFiOfIDOfgfKt7gI
					iifLFKfJeqxVgGijfLFNfWfAxbgBijfLFMf3fzxbgAijfLFMgAgAxb]],
				Neck2 = [[
					gAjHe7IBgAgA1Lf8jCe5Hjgdgh0nf2iietEwg+hRwqf3jgfBJUhEhM2ff7kJfPMYgsgt5PgAkWfUNZgAgA6BgFkJfPMYfUfT5PgJjgfBJUe8e02fgKihetEv
					fCevwpgGixeyF7fYfPyggAisewFjgAgAx/f7j0fIK4grgu4Af4kRfSNDhHhJ5tf4kUfTNQhHhJ53f7j8fLLdgrgu4fgAjAe2G4gAgAzygGisewFkfZfPx/gJ
					jGe7H/e9e01EgHjHe7ICfNfH1KgBjHe7IBf2f01LgAjHe7IBgAgA1L]],
				Head = [[
					gAjne3AFgAgAh6f8jiezALefgviwf1i+eeAUcciMewf3kAfBA1cihUmGf7kofXBsd7ghp/gAk0feCCgAgArKgFkofXBsiFffp/gJkAfBA1jeesmGgLi+eeAU
					jkd0eugHjPenAIiNezgzgAjKekABgAgAgHf7kUfMBJd4gqoHf4kwfcCGcrgvq0f5kyfdCMcrgtrEf7kcfQBWd5gno2gAjfeuAGgAgAiVgHjKekAHiNewgMgK
					jme3AhjgedkLgHjne3AXiqezjqgBjne3AHgkfviegAjne3AFgAgAh6]],
				Jaw = [[
					gAjpeT/8gAgAhsf6jmeQ/Rhrfvmkfxi5d79DkHfRsvfzkLef/QjugDluf5k8e5/3iIgShygAlLfC//gAgAgkgHk8e5/3d4fuhygNkLef/QcSf9lugPi5d79C
					b5gvsxgJjPeD9+dhgUq5gAjJeA90gAgArlf4kkes/siOgKjuf1lFe//zjYgig3f1lIfB/zjXgjgmf5ktex/xiLgNi9gAjjeK+jgAgApfgJjJeB9wdggXrfgO
					jteU+1cLgKnngKjteU/RdHgWmIgCjreT/0fagLjNgAjpeT/8gAgAhr]],
				Crest = [[
					gAlGefKVgAgA3hfylCehLndmjj4RfckUd2KAdbms2FfhlgfDQEd9kM7VfumGfxTMglgu9TgAmRgATci0eM9OgSmGfxRdixdH8NgflgfDNugzdT6GgkkUd2Ip
					fHeh1ygWkreJLCe+fv4JgAkmeCK/gAgA4Hftl0fbRKhJgS8UfkmLf7Smg4hM9AfkmNf+SLfAiT8vful7fkQbdUjC7pgAk/eZLxd0ih4jgWkleDK0fafJ38gg
					lFeuOch2bm6TgZlHeqNejEa75ZgFlHeiLSiCdc4JgAlGefKVgAgA3h]],
				["UpperArm.L"] = [[
					fdide/29PzgAvRfZiZfA2jNZYAqOfUh+fB1sOGSfm/fVi1fE2RTWM5ekfYjefG2zRKPRhqfdjtfF2lONTJlkfijffC3pQ4Qrgmfmi2e94ATdPNdOfmh9e63H
					NtUxlVfiiKe71TLuXrpbfdiGe92mOQTFlgfYjKfE2hUIM0dXfVjnfJ2iRhOnhnfVjqfJ2DOpSKmpfYjSfF2xQyPniLfdiYe+3QSLO9fgfjiGe73COJTzk/fm
					ide82DMKW3nufkide83/OGWWlxfeide+32Okcqrzfdide/29PzgAvR]],
				["LowerArm.L"] = [[
					fKiCepqF+PgAipe9iTemvy5RrWdZe0iFerxs4OpXaCe1jLe5uN4OrGVbe4jve1v/1kuyW2e/j1etwwzxx1aMfGjwetvQ18v0YUfJjLestJ5FsgX8fKiDeewb
					44q/cXfGiHegxH3Et/eYe/iPelw84Rq6ase5jge6tn35sZVVe1j4e5wE1NuzWKe0jxe0xdzrw2ZJe4jhezwL16uSXOe/iretuT5cqFXpfGiOehwi4erabafL
					ieefwp2PvtdtfKigefvM56qtdUfIiMeisK9diLhpfKiCepqF+PgAip]],
				["UpperArm.R"] = [[
					gjide/29wNgAvRgfiZe94gw9qvkjgah9e63HyTrPlUgai2e92Xzdp4m5gejffC3pvIvVgmgjjtfF20qszLbggojefG2zu2wvhqgri1fE1XyksBo2gsh+fB1s
					x7thnAgoiKfA2tuYxVgngjiGe92mxws7lggejKfA2fy1rEmXgajofC35u8vIf6gajrfC3qqvx9a6gejSfB3nveu/hIgjiYe+1SzvpnpYgoiHfA2KxotomBgs
					idfD2VtVynfbgpidfC3NxcrbnFgkide/3dxWjPstgjide/29wNgAvR]],
				["LowerArm.R"] = [[
					g2iCepqFBxgAipg5ifegufEdZLdNg2iEeewbHIVAcWg1i5ehwhKXPedEg6jwetvQKEQMYUhBkEe8sqIsRsVThIjve1v/KcROW2hMi4eux+KrRNa2hMiFerxs
					HyWqaChHicevu4GkXJXThBiPelw8HvVGasg6jPelwoLFO6b7g2j6esu4KNPjYig3kDe2sLIPRGWog6jiervbJtQsYrhBiXekxgJdR2dKhIiPepxUH8VnZ+hL
					ixe2ukHYV2V9hHigeov8GYWebZg7iLelsZC+a0gcg2iCepqFBxgAip]],
				Tail1 = [[
					gAiKgshRgAgA/9gBiIgshQkafx/qgCh7gshOnze3++gCicgshEjqgD/wgBi4gsgzdFfq/2gAjCgsgsZbe//Sf/i4gsgzbIfb/mf+icgshEgfgA/+f+h7gshQ
					ktfU/nf/iBgshQkZfj/qgAh/gshRgAgA/9gBipgsg8bmft/qgCi+gsgvbSfV/ogCjAgsgufif8/+gBivgsg5k5gb/mgAiJgshLmpfk/Rf/h/gshRi7fq/1f+
					iKgshQcWgK/wf+iKgshQaEgP/agAiKgshReagE/7gAiKgshRgAgA/9]],
				Tail2 = [[
					gAiIhKiMgAgA/6gJiGhJiXlrfh/ZgQh4hHjotkdj8pgJiahKg8pFf0+qf8i2hKe+dUff/2f0jBhHeLUdeb9vf1i3hJe3U9fJ9/f/iahKhBeOgH/7gHh4hJjy
					oTef+ogHh+hJjEq0ep96gAh9hLjXkFfk/jf5iohJf+Zxfn/Xf5i9hJecVPe9+EgBi/hKeaaCf0/YgLithJfnkqgo/pgMiHhIiXrqe49rgEh9hKjSpLe0+cf3
					iHhKiNengH/4fziIhIiGXVgm+tf9iIhKiLcvgO/wgAiIhKiMgAgA/6]],
				Tail3 = [[
					gAiDhphXgAgA/9gUiBhmhykAfs/sgnhwhZkZwpdF6zgaiYhjfIvOgA8Hf3i4hobjhpe9/nffjFheaPTPdD8mfii5hgbZPieU6/f7iYhpfPYogS/HgVhwhjkn
					n2eS+ngah4hgjMvgeZ7wgIh2hnjoqYfQ+CftiohldZcQe9/pfmjAhgapSKd38Qf2jChmagTufe9BgTiuhmcwgVhS/zghiCheh9tNe99DgVh2hjjju6ee8Cf0
					iDhohakQf1/rfkiDhihUXogX+2f2iDhohWbdgM/ogAiDhphXgAgA/9]],
				Tail4 = [[
					gAiBiHfLgAgA/+gbh+iDfygCf0//hBhmhmj7wJdT7NgziZh0cbzXha5Kf6jBiFXKoNey9mfLjRhxVlWZao8KfIjChtXSNMcH4CfuiZiEcVSWfo8sgjhnh8j6
					jieF/fgzhxhwiMwzfD7Hgahvh/isv9f+7mfmitiCZqiKeS/PfQjLhxWDTRbi7PfhjMh6V3Pjd55ZgUi0iEY1Zrhn+fg3h+hygRqyfn+Hgthvhzivx3fK6Yf8
					iAiFfTqugT+IfUiBh8fLa3f3/kfuiBiFfLbGf4/mgAiBiHfKgAgA/+]],
				["UpperLeg.L"] = [[
					fXhbgG7NdzgAwsfWhZgJ8EeBfRvNfVhJgQ+wdkddoDfVhvgI66e4eyxNfWiPgC0XfvgW4rfXibf+z1fBg+5EfYiQf9zgeShl5PfYhvgA5JdGhhzffYhIgH96
					cXg9qrfYhQgH9Gc1ggs5fXhOgK9xdLfcrVfWh/gE4bfAfv0ofViWgD0hgMf94ifViYgD0fgMf94kfWiFgE3SfOf717fXhagI8sddfst6fYhOgI9bcxgcsHfY
					hbgC6ec6hZxofYhbgD6ndJhDxgfXhbgG7FdqgOw3fXhbgG7NdzgAws]],
				["LowerLeg.L"] = [[
					fUg+f3t2gsgA81fTg9f3thhcf189fPg5fzrdi5gG9ufShRf6vEiIfV8IfWhugJ0Rg2fB4ufWh6gGzxgHfn5JfXhwgGzffYgL5XfXhPf4uBfIgk8vfYgzfuof
					fIgW+1fWg3fxqaf1gW+QfTg4fxqwg7gL+HfUhef/w4hRfW7IfWh1gJ0ahSeq4kfWh3gJ0YhSer4mfVhkgCx5hJfQ6ffUhAfzr1g1gH9tfWg2fwp+f1gV+ZfX
					g9f2tCfJgj9MfXg9f2tUfhga9FfVg+f3tvgdgF84fUg+f3t2gsgA81]],
				["Foot.L"] = [[
					fWgegR7qgAgAwDfWgegR7qgpfowDfWgegR7mh7e5wBfWgvgR7HhMfQw7fWhGgR6ZgKf5yFfWhTgQ5ifigUzRfWhIgQ5/e5gwynfWgvgR7Gesg0w7fWgegR7o
					ergxwCfWgegR7qfSgbwDfWgegR7qgOf4wDfWg5gR63gefsxXfWhNgQ6DgkfnyjfWhPgQ57gkfnyufWg+gR6vgYfwxjfWgkgR7egIf7wYfWgegR7qfSgbwDfW
					gegR7oesgxwCfWgegR7pfBglwDfWgegR7qfzgIwDfWgegR7qgAgAwD]],
				["Toe.L"] = [[
					fWgOgH/7gAgAiIfWgOgH/6gafZiIfWgOgH/2hOeKiHfWgegI/zgvezjJfWg0gK/rgGf2kffWhAgK/bfuggl8fWg2gK/ifVhLlJfWgegI/zfMhUjJfWgOgH/4
					fKhSiHfWgOgH/6fjgsiIfWgOgH/6gJfyiIfWgogJ/xgSfhjqfWg7gK/lgVfalEfWg9gK/igVfalSfWgsgJ/wgOfnj3fWgTgI/5gFf4igfWgOgH/6fjgsiIfW
					gOgH/4fLhRiHfWgOgH/5fYg9iHfWgOgH/6f4gNiIfWgOgH/7gAgAiI]],
				["UpperLeg.R"] = [[
					gphbgG7NiNgAwsgphZgF7fisfgwIgohIgH96jpfDqugohvgA5Ji6efzfgoiQf9zghueb5Pgpibf+z1g/fC5EgqiPgC0XgRfq4rgrhvgI66hIhOxNgrhJgQ+x
					icikoBgqhQgM9wiUhfrbgphOgK9xi1gkrVgoh/f/2uiKes2YgoiXf7zMiJeC5bgoiZf7zLiIeC5cgoiFf+0Zh2ef4hgphagI8sijgUt6gqhOgN+Ciahmqmgr
					hbgL76hZhdvggqhbgJ7shkhFv6gqhbgH7UiFgOwhgphbgG7NiNgAws]],
				["LowerLeg.R"] = [[
					gsg+f3t2fUgA81grg8f1szf8fw9Ugogzfuohg4fp+0gphPf4uBg4fc8vgphwgGzfgof15Xgqh6gGzxf5gZ5JgqhugJ0RfKg/4uguhRf6vEd4gr8Igxg5fzrd
					dHf69ugvg6fzr3eBgB9pgtg4fxqwfFf1+Hgphef/w5gefw7Kgph3gEzMhDff5kgph6gEzLhCff5lgphlgEy6gmf05zgshAfzr1fLf59tgvg6fzrid9f+9xgv
					g/f5uidtgh8Zgug/f5ubeHga8fgsg+f4t+fEgF8xgsg+f3t2fUgA81]],
				["Foot.R"] = [[
					gqgegR7qgAgAwDgqgegR7qgifswDgqgegR7ohVfPwCgqgvgR7GhUfMw7gqhIgQ5/hHfQyngqhTgQ5igefszRgqhGgR6Zf2gHyFgqgvgR7He0gww7gqgegR7m
					eFhHwBgqgegR7pe4gqwDgqgegR7qfygIwDgqg5gR62g/fYxXgqhQgP5Zhfe/zYgqhSgP5Qhfe/zjgqg+gR6uhGfSxigqgkgR7ef4gFwYgqgegR7pe1gswDgq
					gegR7oepgywCgqgegR7pfAglwDgqgegR7qfzgIwDgqgegR7qgAgAwD]],
				["Toe.R"] = [[
					gqgOgH/7gAgAiIgqgOgH/6gWffiIgqgOgH/4g2euiHgqgegI/zg0esjJgqg2gK/igre1lJgqhAgK/bgSfgl8gqg0gK/rf6gKkfgqgegI/zfRhNjJgqgOgH/2
					exh2iHgqgOgH/5fShFiHgqgOgH/6f3gOiIgqgogJ/wgmfAjqgqg+gK/Wg4ebmHgqhAgK/Tg4ebmUgqgsgJ/ugqe4j3gqgTgI/5f7gIiggqgOgH/5fQhIiHgq
					gOgH/4fIhUiHgqgOgH/5fXg+iHgqgOgH/6f4gNiIgqgOgH/7gAgAiI]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiLgWAEgAgAhmgAiLglAOgAgAjngAiLguAZgAgAk6gAiLgsAWgAgFkkgAiLgnAQgBflj5gAiLgiAPgAd/jLgAiLgeALf+eTirgAiLgdAIgAfrikgAiLgbAG
					gBgOiOgAiNgXAIh6f8hxgAiLgWAumefrhkgAh+gWCesLfZhegAhlgWFCxIfJhWgAhQgWHG0AfAhPgAhNgWHb0Ze/hOgAhXgWGdzLfDhSgAhZgWGRy8fEhSgA
					hPgWHP0LfAhPgAhMgWHi0ie+hOgAhMgWHi0ie+hOgAhMgWHi0ie+hOgAhMgWHi0ie+hOgAhMgWHi0ie+hO]],
				Spine1 = [[
					gAiNgCAZgAgAk4gAiQgRAxgAgAm4gAiRgbBEgAgAoJgAiRgYA/gAgFnzgBiQgTA1f+flnJgDiPgOAvfzd/mbgCiOgKAofzeUl8gAiOgJAjf9frl1gAiOgHAf
					gDgOlfgAiPgEAeh5fvlCgBiNgCBDmafBkxgBh/gCCysDeJkggChmgCFUw9dZkHgChRgCHXzzc9jzgChNgCHr0Mc5jwgChYgCGuy+dFj5gChagCGjyvdHj7gC
					hPgCHfz+c7jygChMgCHy0Uc4jvgChMgCHy0Uc4jvgChMgCHy0Uc4jvgChMgCHy0Uc4jvgChMgCHy0Uc4jv]],
				Spine2 = [[
					gAiZfdBCgAgAoBgAigftBngAgAp+gAilf4CDgAgArNgAikf2B7gBgFq4gCihfwBtf7flqPgHiffqBifmeBpigGidfmBYfoeWpEgBidfkBTf7fso9f/ibfiBN
					gEgOoogCibfeBJh5fsoMgGiYfdBtmZe2n9gKiHfdDfsBdynxgNhrfdGEw4c0negOhTfdIKzscNnPgOhQfdIe0EcInMgNhbfdHgy4cZnUgNhdfdHUypccnVgO
					hSfdISz2cLnOgOhOfdIl0NcGnLgOhOfdIl0NcGnLgOhOfdIl0NcGnLgOhOfdIl0NcGnLgOhOfdIl0NcGnL]],
				Neck1 = [[
					gAijfLFMgAgAxbgAisfdH1gAgA08gAiyfpJxgAgA3AgAixfmJPgDgE2egCiuffIPfxfp1agKiqfZHQe5eU0KgIiofVGlfEelzWgCiofTGZf1fvzKf/imfQF8
					gIgLyjgDilfMFVhie3xjgJihfLFWlOcMwdgQiPfLGYp6ZGu2gVhxfLIGuFWos3gXhXfLJiwkVVragXhTfLJxw6VKrMgWhffLJFv2Vsr2gWhifLI9vpVzr+gX
					hWfLJowtVQrUgXhSfLJ2xCVGrHgXhSfLJ2xCVGrHgXhSfLJ2xCVGrHgXhSfLJ2xCVGrHgXhSfLJ2xCVGrH]],
				Neck2 = [[
					gAjHe7IBgAgA1LgAjTfXLKgAgA4QgAjZfqNYgAgA6AgAjYflMxgDgE5kgCjVfbLofufs4qgLjRfRKeeqeg3kgJjOfKJse3ev22gCjNfIJefyfx2sf/jLfDI8
					gKgK2KgHjJe9ILhNee1QgXjBe5H8kEa50Cgpine4IfnxWsx+g0h+e3JgrJTYvSg4hde2KatNRotRg4hYe2KktfRas+g3hoe3KIsmSHt5g3hre3KDsbSQuEg4
					hbe2KetURitJg4hWe2KntlRVs3g4hWe2KntlRVs3g4hWe2KntlRVs3g4hWe2KntlRVs3g4hWe2KntlRVs3]],
				Head = [[
					gAjne3AFgAgAh6gAjzfcBSgAgAo5gAj4f1C3gAgAtLgAj3fuCYf7gDsEgCj0fhBlgdfsp2gLjxfUBCiPeSnggKjufLAph8eclzgCjtfIAdgYftlSf/jrfCAS
					fwgOkEgLjpe5AJh2fNiCgkjee0AvmQdif8g/i9eyCkrlcDdZhQiLewFMv+bgaohWhjeuHPyZbnYxhXhdeuHjytbqYghVhwevGmxtbjZVhUhzevGbxgbiZfhW
					hheuHXyhboYqhXhbeuHqy0brYahXhbeuHqy0brYahXhbeuHqy0brYahXhbeuHqy0brYahXhbeuHqy0brYa]],
				Jaw = [[
					gAjpeT/8gAgAhrgAkFe9//gAgAfqgAkSfc/8gAgAeWf/kPfT/9gGf/esgDkIfD/+fegLfXgQj/e0/3dbhJf8gOj5ep/5dzhKgegDj3em/+flgPgtf+jzef/+
					gSf1hEgNjseV/1eEgiiggpjceR+0ZbhZlThEizeQ8KT2hVo9hSh7eP4cPagHsShThReQ1jNJezuMhThKeQ1HM3eluchTheeQ2cNxfOtphThieQ2sN9fWtfhT
					hOeQ1XNBetuThThIeQ09MweguihThIeQ09MweguihThIeQ09MweguihThIeQ09MweguihThIeQ09Mwegui]],
				Crest = [[
					gAlGefLVgAgA4agAlTfwROgAgA8XgAlPgjVZgAgA+Lf/lRgVURf/gG9wgFlTf7SHgFfd8zgalRfgQCgUdN7lgXlPfMOigNdi6rgElPfFOCgCfh6df9lNe3NC
					f/gV5wgXlHeiLegteH4chNkyeUKXiiZx2kiEj3eLJylJU5zfikileDJmnyRWvrishnd+JrpiPrs7ished+JspyPeshirh6eAJopAQItwiqiAeAJoo3QQuAis
					hkd+JrpoPmswishbd+Jtp3PasYishbd+Jtp3PasYishbd+Jtp3PasYishbd+Jtp3PasYishbd+Jtp3PasY]],
				["UpperArm.L"] = [[
					fdide/29PzgAvRfdiofQ5fQHc2qhfdivfc6nQoa4nPfditfZ6WQgbVoKffiqfS5yQBcvpmfoimfJ5BPIfDqkfnikfF4cPJfjr5ffijfG4SPueus5fcihfE31
					P7e3t/ffikfB2BOzfRvkfmiqfAyqM5eCxffzikfBufLabSzKgBiPfCqsLBYC0IgKh5fDocLOVs0WgLh2fDoILSVW0WgHiAfCpGLIWa0UgGiCfCpSLHWn0TgK
					h4fDoULPVj0WgLh0fDoBLTVO0WgLh0fDoBLTVO0WgLh0fDoBLTVO0WgLh0fDoBLTVO0WgLh0fDoBLTVO0W]],
				["LowerArm.L"] = [[
					fKiCepqF+PgAipfKiYeyqa9ql4gofKime7qZ8spkfUfJiie5qb9AokfmfNibeyqY9em1gwfZiTeqqP9tlPi/fWiOeoqP96jujLfMiMesqR+Fi7h/fIiJesqP
					+Nhvh0fJiLesrj9vgAiafKiUewu18OeTiFfPiWe3y25rdCgzfaiLe/2O2tcWfBfih9fD4I0icPdtfkh6fE4Z0NcQdgfgiCfC3l1McPeGffiDfB3b1YcPeOfj
					h7fD4P0ZcPdnfkh5fE4e0FcQdbfkh5fE4e0FcQdbfkh5fE4e0FcQdbfkh5fE4e0FcQdbfkh5fE4e0FcQdb]],
				["UpperArm.R"] = [[
					gjide/29wNgAvRgjiofQ5fv5jKqhgjivfc6nvYlInPgjitfZ6XvlkjoFgliqfU5wvoj6qCguilfR46vGj9sngsijfM4YvVi9tnglijfI4Sv/hwtOgiihfE32
					wRgztwglicfA36upepvWgniOe+4wqraTwQgkhze95BlhVAvrgehQe84Ig9QUt8gZg1e73DeVNmsRgYgxe723d+NPsAgag+e83afFOYszgbhAe83gfTOns9gY
					g0e72+eLNcsKgYgwe72zd2NGr6gYgwe72zd2NGr6gYgwe72zd2NGr6gYgwe72zd2NGr6gYgwe72zd2NGr6]],
				["LowerArm.R"] = [[
					g2iCepqFBxgAipg2iYeyqaCWaIgog2ime7qZDUWcfUg1iie4qaDBXYfvg5ibe1qcCfZdf8hEiSe3qcCCcEfKhCiNe0qWB2dXf9g4iMeuqTB4dShYg1iJerqN
					B1eIiPgzh+ern8BJfmiugphretieATgSjdgWhQeybdAogckKgCg1e2VQCRgjk0f2gie6RnD7gmlQf1gfe6RIENgnlUf6goe5SqDZgmlHf7gpe4S+DQgllFf2
					ghe6RaEDgnlRf0gee6Q9ETgnlVf0gee6Q9ETgnlVf0gee6Q9ETgnlVf0gee6Q9ETgnlVf0gee6Q9ETgnlV]],
				Tail1 = [[
					gAiKgshRgAgA/9gAiHg6jTgAgA/0gAiFhDklgAgA/qgAiGhBkPgJgA/tf/iHg8jkfQf+/yf9iIg3i1cef+/qf+iIg0iWdCgB/xgAiJgziPfcgA/6gAiJgwh5
					gZf//7gAiLgthgfyeG/5gAiKgshXfGZk/Sf/h9gshKeQT59if/hlgsgvdiPA6+f/hQgsgWdIMK47f/hNgsgSdFLx4mf/hXgsgedPM+5kf/hZgsggdSNN5vf/
					hPgsgVdHL/4yf/hMgsgRdDLp4ff/hMgsgRdDLp4ff/hMgsgRdDLp4ff/hMgsgRdDLp4ff/hMgsgRdDLp4f]],
				Tail2 = [[
					gAiIhKiMgAgA/6gAiBhYkNgAgA/tgAh9hglfgAgA/hgAh+helKgMgA/kf+iAhakfe7gA/qf3iDhUjta9gG/Xf4iEhRjPbxgJ/if+iEhRjJfMgC/0gBiGhPiz
					gjf+/3f/iIhMiefkeI/1f9iIhKiXeRZp/Nf7h8hKh/cqUF9bf6hmhKhKbRPU62f6hThKgbagMk4zf6hQhKgTaZMM4ff6hZhKgqauNX5cf6hbhKguayNl5nf6
					hShKgYadMa4qf6hPhKgQaXME4Yf6hPhKgQaXME4Yf6hPhKgQaXME4Yf6hPhKgQaXME4Yf6hPhKgQaXME4Y]],
				Tail3 = [[
					gAiDhphXgAgA/9gAh5h1jZgAgA/zgAhzh9ksgAgA/pgBh0h7kWgQgB/sf8h4h3jrenf9/wfth8hwi4Zef9/Lfwh+huibaggD/bf9h+hviVe9gB/4gCiAhth/
					guf+/7f+iEhqhufceH/4f5iEhohsdyZp/Of0h7hohObtUH9XfxhphngIZ7Pc6sfyhZhnfJY9Mz4kfyhWhne/Y1Mc4QfxhehnfdZONj5OfxhfhnfjZUNx5afy
					hYhnfFY5Mp4cfyhVhne7YyMU4IfyhVhne7YyMU4IfyhVhne7YyMU4IfyhVhne7YyMU4IfyhVhne7YyMU4I]],
				Tail4 = [[
					gAiBiHfKgAgA/+gAhziThMgAgA/+gAhqiaiggAgA/5gBhsiYiKgUgC/6f5hxiVheeTf1/6fhh2iMguYBfZ+9fmh5iKgQZQfm/Rf7h6iNgIetf7/9gDh8iLfy
					g4gC/+f9iBiIflfZeF/7f0iCiGfpdlZg/Ofsh8iFfMbST59OfohviDd+ZUPP6VfohiiCc2YQMq4EfohgiCcrYHMV3ufohmiDdNYjNZ4xfohniDdUYpNn4+fo
					hhiCcxYMMh37fphfiCcmYEMN3mfphfiCcmYEMN3mfphfiCcmYEMN3mfphfiCcmYEMN3mfphfiCcmYEMN3m]],
				["UpperLeg.L"] = [[
					fXhbgG7NdzgAwsfXhegP89d0fwtbfXhggV94d1flrOfXhfgT9pd4fkr0fXhegP9KdmgEs6fZhegI8icvhht/fZhdgH8Jc6hTu0fXhdgK8FdogKvIfWhcgK7y
					d6fvvufRhigH7acLe9wBfHhwgG66YMcyvFfBh5gG5kTFaZtFfDh3gG3ZOjYvq6fJhugG1kL4YApcfJhtgG1SLhX6pOfHhxgG2JMqYMp4fGhygG2TM4YQqAfJ
					hugG1cLuX9pWfKhsgG1LLZX4pJfKhsgG1LLZX4pJfKhsgG1LLZX4pJfKhsgG1LLZX4pJfKhsgG1LLZX4pJ]],
				["LowerLeg.L"] = [[
					fUg+f3t2gsgA81fUhFf5xGgsgF7BfUhKf8zFgsgI5rfUhJf7ykgwgF6CfVhGf5xigTgR6wfZhEf0wYe3g77cfYhCf0vnfKgx75fVhBf3vbgagL8BfUhAf4u3
					g5f78UfLhGf3uBf5eS8se6hXf1tRd+aH8bethofysSbsU27AeshufwrBZ1QO4zexhsfvqFYzNg2+eyhrfvp8YqNJ2sevhtfvqXZFOT3jevhtfwqcZLOh3tex
					hrfvqBYvNW22eyhrfvp4YnNA2leyhrfvp4YnNA2leyhrfvp4YnNA2leyhrfvp4YnNA2leyhrfvp4YnNA2l]],
				["Foot.L"] = [[
					fWgegR7qgAgAwDfWgggL9WgAgAsvfWgjgH+NgAgAqgfWgigI+AgDf8rGfWghgJ9jfygYsQfYgggH89e+hvtdfXgfgJ8lfJheuRfWgfgN8hf2gSugfWgegP8O
					gHfzvEfJgmgQ76eXfDvgevg6gP7kaTc7u5eZhRgO6aVHahtUeShggM4bQgYsrheVhkgM2uNwXwqReWhkgM2dNYXpqFeThjgM3ROjYBqpeThjgM3aOxYFqweV
					hkgM2nNlXtqMeWhkgM2XNPXmqBeWhkgM2XNPXmqBeWhkgM2XNPXmqBeWhkgM2XNPXmqBeWhkgM2XNPXmqB]],
				["Toe.L"] = [[
					fWgOgH/7gAgAiIfWgSf+/8gAgAeZfWgXf4/vgAgAcBfWgWf6/0gAf7cpfXgTf7/6f+gbd4fZgRf7/6f2iBfOfYgQf+/8f4htgHfWgPgC//f/gVgWfWgOgF/+
					gAfyg/fHgWgG/5eGf4hhepgrgE/TZhfxhHeOhGgC9kT0f6gOeEhagA7AO3gUfgeHhhf/47L/gtfIeIhhf/4mLmgxfFeFhff/5kM0glfOeFhff/5wNDgjfQeH
					hhf/4yL0gvfGeIhhf/4fLdgzfEeIhhf/4fLdgzfEeIhhf/4fLdgzfEeIhhf/4fLdgzfEeIhhf/4fLdgzfE]],
				["UpperLeg.R"] = [[
					gphbgG7NiNgAwsgphegP89iMgQtbgphggV94iLgbrOgphfgT9piOgUrzgqhegR9Kh9gqs+grhdgS8jhIh6uRgrhcgP8KhThlvDgqhcgL8FiCgZvLgphcgI7y
					iUf5vsgjhZgH7zgkfGvxgThPgG8QcadOuTf8g/gG79W1bhrtfmgsgG6kRsaupMfagegG5IOjamnnfZgcgG45OIamnZfegigG5mPeamoFffgjgG5uPvanoNfa
					gdgG5COYamnhfYgbgG4zN+amnVfYgbgG4zN+amnVfYgbgG4zN+amnVfYgbgG4zN+amnVfYgbgG4zN+amnV]],
				["LowerLeg.R"] = [[
					gsg+f3t2fUgA81gshFf5xGfUf77BgshKf8zFfUf45rgshJf7ykfZf26DgthGf7xie7gG6vgwhCf/wXdfgz7XgvhBf9vmdxgs71gshBf5vbfBgG8AgrhAf3u3
					fgf48Ugig8f2t3eheR8vgLg1fzsscraH8kftgsfvrOaoUz7QfVghfspkZHQH5IfJgXfrobYWNV3WfHgWfroRYQM93EfMgafroxYjOI36fNgbfro4YnOX4EfI
					gXfroXYUNL3OfHgVfroNYOM029fHgVfroNYOM029fHgVfroNYOM029fHgVfroNYOM029fHgVfroNYOM029]],
				["Foot.R"] = [[
					gqgegR7qgAgAwDgqgggL9WgAgAsvgqgjgH+NgAgAqggqgigI+AgDf8rGgqgggL9jfygYsQgrgfgR89e+hvtdgrgegS8lfJheuRgqgegP8hf2gSuggqgegO8O
					gHfzvEgdgdgP8AeWfDvVf9gagO73aPdCuUfXgYgM66U6a8sSe7gWgK5CQHZkqIeugTgJ3XNPZAotetgSgJ3GM1Y9ogexgUgK35OEZKpIeygVgK4DOUZMpQeu
					gTgJ3QNEY/ooesgSgJ3AMtY7ocesgSgJ3AMtY7ocesgSgJ3AMtY7ocesgSgJ3AMtY7ocesgSgJ3AMtY7oc]],
				["Toe.R"] = [[
					gqgOgH/7gAgAiIgqgSf+/8gAgAeZgqgXf4/vgAgAcBgqgWf5/0gAf7cpgrgTf+/6f+gbd4gtgQgF/6f2iBfOgsgPgH/8f4htgHgrgPgD//f/gVgWgqgOgE/+
					gAfyg/gbgNgF/6eGf5hVf3gMgD/UZhf6gffNgOf/9jT0gZfEevgRf867O6hSd+eigQf74zMFiEdceggQf74eLsiLdYelgRf75eM5h0dlemgRf75qNIhwdoeh
					gQf74rL6iHdaeggQf64XLkiOdXeggQf64XLkiOdXeggQf64XLkiOdXeggQf64XLkiOdXeggQf64XLkiOdX]],
			},
		},
	},
}
