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
					gAhvgbDfgAgAuff+hwgbDggmf2uff9hxgbDhhJftuff7hxgbDihlfouff7hwgbDjh4fmuff6hvgbDkiBfpugf7hugbDkh+fxugf7htgbDjhwf9ugf9htgbDi
					hZgMugf+hugbDhg6geuggAhvgbDggYgwufgChwgbDgf2hBuegDhxgbDgfWhPudgFhxgbDhe7hYucgFhwgbDheqhcubgGhvgbDieihaubgFhugbDiekhSucgF
					htgbDhexhDudgDhtgbDgfGgwuegChugbDffhgZufgAhvgbDfgAgAuff+hwgbDfgffnuff9hxgbDgg6fQuef7hxgbDhhPe9udf7hwgbDihceuucf6hvgbDihe
					emubf7hugbDhhWekubf7htgbDhhFeoucf9htgbDggqexudf+hugbDggKe/uegAhvgbDgfofQufgChwgbDhfGfiuggDhxgbDienf0uggFhxgbDjeQgDuggFhw
					gbDkeCgPuggGhvgbDkd/gXuggFhugbDjeIgaufgFhtgbDiebgYufgDhtgbDhe3gTufgChugbDgfagKuf]],
				Spine = [[
					gAiSgCE+gAgAxHf/iTgCE+gSf+xHf/iUgCE/gjf9xHf+iUgCFAgyf9xIf+iTgCFBg8f/xJf+iSgCFBhBgDxJf+iRgCFBhCgJxJf+iQgCFBg+gRxJf+iQgCFB
					g2gaxJf+iRgCFAgqgkxIf/iSgCE/gdgtxGf/iTgCE+gOg2xFgAiTgCE9gBg8xEgAiTgCE9f1g/xDgAiTgCE9fshAxDgAiRgCE9fng9xDgBiQgCE9fmg2xEgB
					iQgCE+fogsxFgAiQgCE+fugfxGgAiRgCE+f2gQxGgAiSgCE+gAgAxHgAiTgCE+gKfwxGgAiUgCE+gSfhxGf/iTgCE+gYfUxFf/iTgCE9gafKxEgAiRgCE9gZ
					fDxDgAiQgCE9gUfAxDgAiQgCE9gLfBxDgAiQgCE9f/fExEgBiRgCE+fyfKxFgBiSgCE/fjfTxGgCiTgCFAfWfcxIgCiUgCFBfKfmxJgCiUgCFBfCfvxJgCiT
					gCFBe+f3xJgCiSgCFBe/f9xJgCiRgCFBfEgBxJgCiQgCFAfOgDxIgBiQgCE/fdgDxHgBiRgCE+fugCxH]],
				Neck1 = [[
					gAi2fxGDgAgAytgAi3fxF/gSf9yngAi3fxF8gjf7yif/i3fxF6gxf7yef/i3fxF5g8f8ycf/i2fxF5hCgAycf/i0fxF5hDgGydf+i0fxF7g/gOygf+i0fxF+
					g3gXyjf+i1fxGBgzgryof+i2fxGFg4hNysf+i3fxGKg7huyvf+i3fxGNg1h/yyf+i3fxGPgpiEy1f+i2fxGRghiFy4f+i1fxGRgbiCy5f+i0fxGRgah7y5f/
					i0fxGPgchxy4f/i0fxGMghhky1gAi1fxGJgohUyxgAi2fxGFgxhEysgAi3fxGAgrgfyngBi3fxF7gQfgyhgBi3fxF4fyekyZgCi2fxF2fmeGyUgCi1fxF2fl
					d/ySgCi0fxF2ffd8yTgCizfxF5fWd9yWgCi0fxF9fLeBybgCi0fxGCe+eIyigCi2fxGHeweRyqgCi3fxGNejebyygCi4fxGSeYemy5gCi3fxGVeYe5y+gBi3
					fxGWelfZzCgBi2fxGVe3f3zDgBi0fxGTfEgFzBgBi0fxGQfPgGy+gAi0fxGMfdgFy5gAi1fxGIfugDyz]],
				Neck2 = [[
					gAjSfnGLgAgAy3gAjTfnGCgSf9yrgAjUfnF7gjf7yhgAjTfnF2gxf7yZgAjTfnFzg8f9yUgAjSfnFyhCgAySgAjRfnFzhCgGyVf/jQfnF3g/gOyaf/jQfnF9
					g3gXyif+jRfnGEg7g1yrf9jSfoGOhRhvy0f8jTfoGZhminy7f8jUfoGihnjCzCf7jTfoGnhbjHzJf7jTfoGqhTjIzOf7jSfoGrhNjGzQf8jRfoGqhLi/zPf8
					jQfoGmhNi1zMf9jQfoGghSinzGf+jRfoGYhZiXy9f/jSfoGQhiiHyzgAjTfnGFhOhOyqgCjTfnF6gQfgyfgDjTfnF2fPd1yRgEjSfnF0e0dEyGgFjRfnFzey
					c+yDgFjQfnF1etc7yFgFjPfnF5ekc7yLgFjQfnGBeZc/yVgEjRfnGKeMdGyigDjSfoGUd+dOywgDjTfoGfdydZy+gCjUfoGodndjzLgBjUfoGtdueBzWgBjT
					foGteNe5zdgAjSfoGrewfvzfgAjRfoGofEgGzdgAjQfoGjfPgHzXgAjQfoGcfdgGzOgAjRfoGUfugDzD]],
				Neck3 = [[
					gAjqfgGLgAgAy3gAjqffF+gSf9ylgBjrffFzgjf8yVgBjrffFrgxf7yJgBjqfeFmg8f9yBgBjpfeFkhCgBx/gAjoffFnhCgHyCgAjnffFsg/gPyKf/jnffF1
					g3gYyXf+jofgGAhCg/ylf8jqfgGRhpiQyyf6jrfhGkiPjgy8f5jrfhGyiYkFzGf5jrfhG6iMkKzRf5jqfiG/iEkMzYf5jpfiHAh+kJzbf5jofiG+h8kCzaf6
					jofhG4h+j4zUf7jofhGviDjqzKf9jpfhGkiKjay9f+jqfgGXiTjJyugAjqffGEhxh+yigDjrffFygQfgyUgFjqffFuesdGx9gHjpfeFueDcCxsgHjofeFteB
					b8xogIjnfeFvd8b5xrgHjnffF2dzb5x0gHjnffGAdob9yCgGjofgGOdbcDyVgFjqfgGddOcMyqgEjrfhGsdBcWy+gDjsfhG6c3cgzRgCjsfiHAdFdIzigAjr
					fiG+d1eYzuf/jqfiG6epfmzyf/jpfiG2fFgHzvf/jofhGvfPgHzmf/jofhGlfdgGzZf/jpfgGYfugDzJ]],
				Head = [[
					gAkBfYABgAgAgLgBkCfXABgRgIf8gBkCfWABgfgRf1gCkCfWACgrgZf1gCkBfVACgzggf8gCkAfVACg2gmgKgBj/fWACgzgrgdgAj+fWADgsgvgzf/j/fXAD
					ghgyhJf9kAfYAHglhzhef7kBfZAWg/kLhpf4kCfaAwhXmghmf2kDfbA+hWnchjf2kDfbA8hInahgf1kCfcA7g+nWhYf2kBfcA4g6nPhLf2kAfcA2g8nIg7f3
					kAfbA0hDm/gof5kAfbAyhQm2gUf6kAfaAxhhmsgCf8kBfZAwh0mjfzf/kCfXAYhlkhfzgEkCfWABggfwfzgIkBfWAbfSbAfegKkAfVA0e0ZBfUgLj/fVA2e1
					Y6ffgLj+fVA3eyYzfxgLj+fWA5erYtgJgKj+fXA7egYogjgJj/fYA9eUYlg9gHkBfZA/eGYkhWgGkDfaBAd5YkhpgEkEfbBBduYnh1gCkEfcAzd0Zoh/gAkD
					fcAYeUcCiDf+kCfcAIe4efh5f+kBfcAEfMfjhlf+kAfbADfUfphOf+kAfaACfgfwg2f/kAfZABfvf4ge]],
				Jaw = [[
					gAkLez/4gAgAijgBkLey/1fwf2jHgBkLex/yfjfsjigBkLew/wfYfjjygBkKew/vfRfbj1gBkJew/wfPfUjqgAkJew/zfSfQjUf/kJex/2fZfNi1f+kLey/5
					fkfLiOf6kMez/5fmeKhmfykOe2/rfXbxhDfqkQe4/RfNZahEfnkQe6/EfTYehGfmkQe7/FfhYihJfmkPe7/GfqYnhRfmkNe7/HfuYthefnkMe7/IfrY1hvfo
					kLe6/IfjY9iCfqkKe5/IfVZFiVfskKe4/IfEZNiofukLe2/IewZVi3f2kLez/de3bXjPgFkLex/yffgNjkgTkKey/UgJlDkGgakIez+4gXnFkXgbkIez+4gU
					nMkPgbkHe0+5gXnTj6gbkIe0+7ggnajYgakJe2++gtnfivgYkMe3/Ag+njiBgXkOe4/BhRnlhTgVkRe6/BhenlhAgTkSe7/BhpnkgzgPkSe7/RhpmjgrgIkR
					e5/shWkGgpgBkQe4/7g/hng1f+kOe4/9gyghhJf+kMe3/8gqgahgf/kLe2/7gegSh4f/kLe0/6gQgKiQ]],
				Crest = [[
					gAlhfVYPgAgA/CgClifSX+gMfy+9gElifRX6gYfm+8gGlifQYBgifc++gHlhfQYUgrfW/CgHlgfRYwgxfU/JgGlffTZTg1fX/QgElffWZ4g3ff/YgClffZad
					g4fq/fgBlgfba+h4fz/igBlhfdbTkSf3/WgAlifdbYmpf++8f+ljfebUnkgL+uf8ljfebKnfga+uf7lifea3nYgl+sf6lhfdabnRgr+pf7lgfcZ7nKgs+kf8
					lgfZZYnDgm+ff+lgfXY3m8gb+ZgBlgfUYZm3gL+TgFlhfRYDmzf4+PgHlhfQX7kxfm+lgHlifQX4f4fd+8gGlhfNXya/fe+ggGlgfLX4Y7ff+HgHlffMYSY1
					fg+MgGlefOY0Ytfl+TgFlefRZaYmfu+agDlefUaDYff7+hgAlffXaoYZgJ+mf9lhfabIYVgY+qf5lifdbeYTgm+tf3ljfebnYTgx+uf1ljfhbnZUg2+9f2lj
					fibabxg1/Xf4lifia+eSgx/if5lhfgaZfYgt/ef6lgfeZyfggm/Xf7lgfbZLfpgb/Qf+lhfXYpf0gO/I]],
				["Humerus.L"] = [[
					faixfzcVUDkO9JfaizfzcIUPjs9Qfai0fzb8UbjN9Xfai0f0b0Uli09dfZi0f0bvUuik9hfZizf0buU1if9kfZiyf1bxU5il9lfZixf1b4U7i29lfYiwf1cC
					U6jQ9kfYixf1cPU4jw9hfYixf1ccU0kU9cfYixf1cqUvk39WfYixf1c2UqlX9QfYixf1c/Uklw9KfYiwf0dFUemA9FfZiuf0dHUZmE9CfZiuf0dEUTl+9BfZ
					itf0c9UPlt9CfaiufzcyUKlT9EfaivfzckUGky9GfaixfzcVUDkO9JfbizfycFUAjq9Kfbi0fyb3T9jJ9Lfbi0fybrT5iv9Kfci0fybjT1ie9JfciyfxbgTx
					iY9HfcixfxbhTrid9EfciwfxbnTkit9BfciwfxbxTejG89fciwfxb/TYjl85fcixfxcOTSkI80fciyfxcdTOkr8vfciyfxcsTNlK8qfcixfxc3TNlj8nfciw
					fxc+TPl08lfcivfydBTTl68mfbiufyc/Tal18qfbitfyc5Tilm8wfbiufycvTslP84fbivfycjT3kw9A]],
				["Forearm.L"] = [[
					eli5gnflSllq8eemi9gnfXSulI8oemjAgofKS2kp8xenjCgpfAS9kQ84enjCgqe7TEj/89enjBgqe6TKj69BenjAgre9TPj/9Ceni+grfFTSkP9Ceni8grfR
					TUko8/emi7grffTVlI86emi5grfvTVlr80eli4grf+TVmO8teli2grgLTTmt8leli0grgWTQnF8eeliygqgdTMnV8YeliwgqgeTIna8UeliwgpgbTCnV8Tel
					iwgpgTS7nF8UeliygogHS0ms8Xeli1gnf3StmN8beli5gnflSllq8eeli9gmfTSflI8hemjAglfDSYkp8jemjCgle2SSkQ8kemjCgkesSNkA8jemjBgjeoSI
					j78hemjAgjeqSDkA8eemi+giewR+kQ8aeli8gie8R6kp8Ueli7gifLR3lH8Oeli5gifcR2lp8Heki4giftR2mL8Aeki2gif9R4mq76eki0gjgJR7nC72ekiy
					gjgSR/nS70ekiwgjgVSDnX71ekiwgkgTSJnS75ekiwglgMSPnD8AekiyglgCSWmr8Jeli1gmf0SemM8U]],
				["WingFinger1.L"] = [[
					duiwhWgeSvkl8vdvi2hXgPS3kC84dvi7hZgCS+jj8/dwi+haf4TFjJ9Gdxi/hbfzTLi59Kdxi/hcfyTRiz9Ndyi9hcf1TWi49Pdyi6hdf9TajI9Pdyi3hdgI
					Tdjh9NdxizhegWTfkB9KdxiwhegmTgkk9Fdxitheg1TglH8/dxiphdhCTfln84dximhdhMTdmA8ydxijhchTTamQ8tdxihhbhVTVmV8pdxighbhSTPmQ8odw
					iihahKTImA8pdvilhYg+TAln8qdviqhXgvS4lI8tduiwhWgeSvkl8vdui2hVgNSokD8xdti7hUf9Sgjj8ydti+hTfvSZjL8xdtjAhSfmSTi78wdti/hRfjSO
					i28udti9hQfkSJi88rdsi7hPfrSFjM8ndsi3hPf2SCjk8jdri0hPgFSAkE8edriwhOgWSAkm8ZdrishPgnSBlI8TdsiphPg3SDln8OdsilhPhDSHl/8Kdsii
					hQhLSMmP8JdtighRhOSRmU8KdtighShMSWmP8OdtiihThFScmA8UdtilhUg6Siln8dduiqhVgtSplI8m]],
				["WingFinger2.L"] = [[
					c9iniBhPTKh19Nc+iuiDg9TRhP9Tc/i1iEgzTXgx9XdAi5iGgxTcgc9adBi7iHg4TggU9bdBi7iIhHTigY9cdCi5iJhdTkgp9bdCi1iKh3TmhE9adCixiLiT
					Tphn9XdDisiLitTsiP9UdDiniLjFTvi49PdDihiLjXTyjd9LdEiciLjhT0j79GdEiYiKjjT1kP9EdEiUiJjcTzkY9CdEiSiIjNTvkU9DdDiSiHi4TqkD9FdB
					iUiGifTjjo9IdAiYiEiDTbjF9Lc/ifiDhnTSid9Nc9iniBhPTKh19Nc8iuiAg8TBhQ9Mc8i1h+gwS5gy9Kc7i5h9gsSwgf9Gc6i8h7gxSmgY9Cc6i8h6g+Se
					ge89c5i6h5hSSWgw85c5i2h4hrSQhN80c4ixh3iGSNhx8uc4ish3iiSMia8pc4inh3i7SOjC8kc5ihh3jPSSjm8fc6ibh4jbSYkD8dc6iXh4jeSekW8cc7iT
					h5jZSkkd8fc8iRh6jLSqkY8kc8iRh7i3SwkG8sc9iTh9idS2jq80c9iYh+iCS8jG8+c9ifiAhnTDie9G]],
				["WingFinger3.L"] = [[
					cTigiohNTweu9gcUipiqg4T3eG9hcVixisgxT+dp9icWi2iug5UCdb9icXi4iwhQUFdd9jcYi3ixhyUHdv9jcYiziyieUJeO9jcZitizjNUMe49icainizj8
					UQfp9fcaigizkmUWgb9bcbiYizlHUchK9XcciRizlbUihy9UcdiLizlhUmiO9ScdiGiylYUnic9TcdiCixlCUkib9WcdiBiwkgUeiK9acbiCivj1UWhr9fcZ
					iGiujGUMhB9jcXiNisiYUCgQ9kcViWiqhuT5fd9jcTigiohNTweu9gcRiping4ToeG9bcQixilgxTfdr9VcPi2ijg5TVdf9QcOi5ihhOTLdj9LcNi4ifhvTC
					d39HcNi0ieiZS6eZ9CcMivicjIS1fF8+cMioibj2Szf484cMigibkhS1gs8zcNiYiblCS7hb8ucOiRiblYTCiC8qcPiKiblgTJid8qcQiFiclZTQip8tcSiB
					idlETVil80cSiAifkjTZiR89cTiBihj5Tchw9HcTiGiijJTfhE9QcTiNikiaTkgS9XcTiWimhvTqfe9d]],
				["Vine.L"] = [[
					d2inhZ0tqhiW14d2itha0dqBhz2Zd3ixhb0UphhI2yd3i0hc0TpDga3Ad4i1hd0aorfs3Dd4i1he0podfC26d4izhf0+oZeh2md5iwhf1WoieK2Kd5ithg1w
					o3eA1od5iqhg2IpUeC1Cd5inhg2dp4eS0dd6ikhg2rqfesz8d6ihhg2zrDfQzhd6iehf20rjf6zPd6ibhf2tr6gnzId6iZhe2fsGhSzOd5iZhd2MsIh3zgd5
					iahc11r9iTz9d4idhb1croii0jd3iiha1DrIij1Nd2inhZ0tqhiW14d1ithY0cp1h+2ed1ixhX0RpJhd29d0i1hW0Oogg33Rd0i2hV0Vn+gS3Ydzi1hU0knm
					fw3Tdzi0hT05nbfX3CdzixhS1UnffH2odziuhS1wnxfD2HdzirhS2KoOfL1idzinhS2hozfd08dzikhS2wpcf50ad0ighS24qFgbz9d0idhT24qphBzpd1ia
					hT2wrFhnzgd1iYhU2hrYiKzjd2iYhV2Mrhilzyd2iahW10rfi20Ld2idhX1brSi50td2iihY1Cq9iu1S]],
				["Humerus.R"] = [[
					gmixfzcVr9by9JglixfycSsEb49GgliyfycQsLb+9EglixfycPsScD9CgliwfycOsYcH8/gkivfycOsecJ89gkiufxcOsjcJ87gkiufxcOsncH85gkiufxcO
					srcD83gkivfxcOstb+81gkixfxcOsub480gkizfxcOstby8zgki0fxcPssbt8zgki0fxcQspbp80gkizfxcRslbm81gkiyfxcSshbk83gkixfycUsbbl86gl
					iwfycVsUbn89gliwfycWsNbq9BgliwfycWsFbu9FgmixfzcVr9by9JgmixfzcUr1b29MgmixfzcSrtb59Qgnixf0cQrlb89Tgniwf0cPreb99Wgniuf0cPrY
					b89Ygoitf0cPrTb79agoitf1cRrPb49bgoiuf1cUrNb09cgoivf1cYrMbw9cgoixf1ccrMbs9cgoizf1cgrObo9bgoi0f1cjrQbk9agni0f1clrUbh9Ygni0
					f1cmrYbg9Xgnizf0clrdbf9Ugniyf0cjrjbg9Sgmixf0cgrpbj9Qgmiwfzccrvbn9NgmiwfzcYr2bs9L]],
				["Forearm.R"] = [[
					hbi5gnfltbaW8ehbi6gmfitiab8chbi6glfftpag8Zhbi6glfdtwak8Xhbi5gkfct3an8Uhbi4gkfct8ao8Rhbi3gjfbuBao8Phbi2gjfbuFal8Nhbi3gifb
					uIah8Khbi4gifcuKac8Jhbi5gifcuKaX8Hhbi7gifcuJaR8Hhbi8gifduHaM8Hhbi8gifeuEaH8Hhbi7gjfguAaF8Jhbi6gjfit7aE8Lhbi5gkfjt2aF8Ohb
					i4glfltwaI8Rhbi4glfmtpaM8Whbi4gmfmtiaR8ahbi5gnfltbaW8ehbi6gnfktTaa8jhbi6gofjtLae8nhbi6gpfhtEah8rhbi5gpfgs+aj8uhai4gqfgs4
					aj8xhai3gqfhszai8zhai2grfjsvag80hai3grfmssad81hai4grfqsraZ81hai5grfvsraV80hai7grfzssaR8zhai7grf2suaN8xhai8grf4sxaK8vhai7
					grf5s1aI8thai6gqf4s6aH8rhai5gqf1tAaI8ohbi4gpfytGaK8mhbi4gofutMaN8jhbi4gnfptTaR8h]],
				["WingFinger1.R"] = [[
					iSiwhWgetRbb8viTixhVgbtYbg8tiTiyhUgYtgbl8qiTixhTgXtnbp8niUixhSgWttbr8kiUivhRgWtzbs8iiUiuhQgWt4bs8fiViuhPgWt8bp8diViuhPgW
					t/bl8biVivhPgWuAbg8aiViwhOgWuAba8ZiVixhPgXt/bU8YiViyhPgXt9bP8YiUiyhPgZt6bL8ZiUixhQgat2bJ8biUiwhRgbtxbI8diTivhSgdtsbJ8giT
					iuhTgetmbM8jiTiuhUgftfbR8niSivhVgftYbW8riSiwhWgetRbb8viSixhXgctJbg80iRiyhYgbtCbk84iRiyhagZs7bn87iQixhbgYs0bp8/iQiwhbgXsu
					bp9BiQivhcgYspbp9DiPiuhdgaslbm9FiPiuhdgdsibj9FiPivheghshbg9FiPiwhegmsgbc9FiPixhegqshbY9EiPiyhdgtsjbU9CiPixhdgvsmbR9AiPix
					hcgwsqbO8+iPiwhcgvsvbN88iQivhbgts1bO86iQiuhagqs7bP83iRiuhZgmtCbS81iRivhXgitJbW8y]],
				["WingFinger2.R"] = [[
					jDiniBhPs2eL9NjEioiAhKs+eS9LjEiph+hLtGeV9HjFiph9hTtOeT9DjGioh7hftWeN8+jHinh6hwteeD85jHilh5iCtld280jHilh4iVtrdn8ujIilh3il
					tvdY8qjIilh3iztxdK8mjIinh3i7tyc+8kjIioh3i+txc28jjHioh3i8tucz8kjHioh4i1tqc18njGinh5iptlc88rjGimh6iatedG8xjFilh7iJtXdU83jF
					ikh9h3tPdj89jEikh+hntHdz9DjDiliAhZs+eA9IjDiniBhPs2eL9NjCioiDhKsueS9RjBipiEhLsneV9VjAipiGhRsheT9XjAioiHhcsdeN9Yi/iniIhssZ
					eD9Yi/imiJh/sWd39Xi+imiKiTsUdq9Wi+iliLinsSdd9Ui9imiLi4sRdR9Ri9iniLjFsRdI9Pi9iniLjMsSdC9Oi9iniLjMsTdA9Ni9iniKjGsVdC9Ni+im
					iJi6sYdH9Ni+iliIipsbdQ9Oi/ikiHiUsfdb9QjAikiGh/skdo9QjBikiEhrspd19QjCiliDhbsveB9P]],
				["WingFinger3.R"] = [[
					jtigiohNsQhS9gjuihinhFsXhb9cjwiiilhLsfhc9ZjxiiijhdsnhT9Vjyigihh7svhC9Qjyieififs3gq9LjzibiejIs9gN9FjziZicjwtCfu8+j0iYibkU
					tFfR83j0iYibkwtGe38xjziYiblCtFel8ujziZiblJtEeb8tjziaiblDtBea8vjyiaickys+ej80jyiaidkWs6e187jxiaifjzs1fO9DjwiaihjMsvfr9Kjw
					iaiiilsogK9RjvicikiAsggn9XjuieimhisYhA9cjtigiohNsQhS9gjsiiiqhEsIhc9jjrijishHsBhc9mjqiiiuhXr7hT9ojpihivhyr2hD9pjoifixiVry
					gs9pjnidiyi+rugR9njmibiyjorrf29kjmiZizkProfc9fjliYizkwrmfG9bjliYizlHrke29XjliYizlRrket9VjliZizlOrlet9VjliZiyk+roe19XjmiY
					ixkirsfF9ajniYiwj9rwfb9ejoiZivjUr2f19ijpiaiuipr8gQ9kjqibisiCsCgq9kjsieiqhisJhB9i]],
				["Vine.R"] = [[
					iKinhZ0tVfdq14iLiohY0RV2dr2ciLiphXz/WPd224iMiohWz4WqeJ3LiMiohVz9XCej3TiNimhU0MXWfA3OiNilhT0kXife2/iNilhS1CXnf62miNilhS1j
					XlgQ2FiNimhS2DXbge1hiNinhS2hXNgj08iNiohS24W8gd0biNiphS3JWpgO0AiNiphS3QWWf2zuiMiphT3OWEfZzoiMinhU3CV0e6zsiMimhV2tVmecz7iL
					imhW2RVdeC0UiLimhX1wVYdw0ziLimhY1NVZdo1ViKinhZ0tVfdq14iKioha0SVqd22XiJiphb0AV4eL2wiJiphcz3WHep3AiJiohdz6WVfM3FiIinhe0HWf
					fy2/iIimhf0dWlgY2tiHilhf06Wlg72RiHilhg1bWfhX1uiHimhg19WVho1GiHinhg2dWIhu0diHiohg23V5hoz4iHiphg3LVqhVzbiHiphf3VVcg4zJiHio
					hf3UVQgUzEiHinhe3JVGftzNiIimhd20VAfGzhiIilhc2WU/ei0AiJilhb1zVDeG0miKimha1PVOdz1P]],
				Tail1 = [[
					gAhvgbkfefgO/of+hwgbkdfCfA/pf9hxgbkefsd5/mf7hxgbkhgYc//hf7hwgbklhEcY/bf6hvgbkphrcH/Xf7hugbkriLcO/Wf7htgbkrigcs/Yf9htgbkn
					iqdf/cf+hugbkjimeg/hgAhvgbkfiWfr/lgChwgbkdh7g3/ngDhxgbkehXh9/lgFhxgbkhgvi3/igFhwgbklgGje/egGhvgbkpfgju/bgFhugbkre/jn/bgF
					htgbkrenjK/dgDhtgbkoeZiY/hgChugbkjeXhX/mgAhvgbkfefgO/of+hwgbkdexfD/pf9hxgbkefLd+/mf7hxgbkhfodG/if7hwgbklgGch/ef6hvgbkpgg
					cS/bf7hugbkrg1ca/bf7htgbkrhCc6/ef9htgbkohFdt/jf+hugbkkg9ev/ogAhvgbkggsf6/qgChwgbkegShG/qgDhxgbkefyiM/mgFhxgbkhfRjE/ggFhw
					gbklewjq/bgGhvgbkpeVj5/XgFhugbkreBjw/XgFhtgbkrd3jR/agDhtgbkod4id/fgChugbkjeGha/k]],
				Tail2 = [[
					f6hchciIcRgQ/sf6hehciAdBek/wf6hehch8eEdB/vf7hehch9fVbx/pf9hdhciEgsa7/gf/hbhciMiAal/ZgBhZhbiUjKax/UgEhZhbiXkEbe/UgGhZhbiW
					kocm/YgIhahbiPkzeD/fgKhchbiHkkfs/lgKhehciAj8hY/pgKhfhch9i/i7/qgJhehciAhzkL/mgIhdhciHgflA/hgGhbhciQfMlW/cgDhahciXeAlK/bgB
					hZhciadDke/cf+hZhciYcbjW/hf8hbhciRcJh5/nf6hchciIcRgQ/sf5hehciAcwel/uf4hehch9djdD/sf4hehch/ekb0/nf5hdhciGfta//hf6hbhciQg0
					aq/cf8hahciYh0a3/bf+hZhcibilbk/egAhahciZjDcs/lgBhbhciSjLeK/sgDhchciIi6f0/ygEhdhch/iThf/0gEhehch7hajB/wgDhehch9gUkR/pgChc
					hciDfJlG/ggBhbhciMeAlb/Zf/hahbiUdClO/Vf+hZhbiYcTkh/Xf8hZhbiXb6jY/df7hbhciQb5h6/l]],
				Tail3 = [[
					fqhTidgWajgE/hfthWiegJbCd7/ifxhXiff8cBb//ff3hWiff1dbac/Zf+hUiff3fGZc/TgGhQiegBg5ZG/OgNhOidgOioZa/MgThNicgakKaY/NgYhNibgh
					lWb4/RgbhQibgfmFdz/VgchTibgWmSf8/XgbhWidgKl6iF/XgXhXiegAlCkB/VgShXief7jtlk/SgLhViff+iEmj/PgEhSifgIgSm6/Pf9hPiegVeimm/Rf2
					hNidggc9lo/VfwhOidglbskH/bfshQicgha3iM/ffqhTidgWajgE/hfrhWidgJaxd7/ffthXief+bgb//afxhXiff5cqac/Uf2hUiff9eHZc/Qf8hSifgIfu
					ZG/PgChPiegWhSZa/RgHhOiegiisaY/XgLhOidgnjyb5/fgOhQidgikdd0/mgPhTiegXkof9/pgOhWiegHkSiG/ogKhXiff6jdkB/jgGhWiff0iOlk/bgAhT
					iff2gumk/Tf6hQiegBfHm6/Of1hOidgPdjmm/NfwhNicgccNlo/QfshOicgjbMkH/WfqhQicgganiN/d]],
				["UpperLeg.L"] = [[
					fkhTgX7RZnfxvdfhhVgX68aPgOwQfehXgX6nazgpw+fchXgX6bbOg7xXfbhXgY6gbZhAxSfbhWgY6xbWg2w3fbhVgY7GbJgiwRfchUgY7Ya5gJvvfehTgY7h
					anfwvZfhhTgY7iaWfZvQfjhTgY7daGfFvSfmhTgY8FZReUtqfphSgY8fYhdwsRfrhSgY8wX2dYrGfshRgY86XUdLqNfthPgY8/XAdIpsfshOgY9AW/dPpqfr
					hOgX88XTdhqMfphPgX8tX4eArWfnhQgX8NYreutHfkhTgX7RZnfxvdfhhVgW64aFgbwSfehXgW6fafhBxBfdhXgW6RavhfxbfbhXgW6TaxhtxXfbhWgW6iam
					htw8fbhVgV61aUhjwZfdhUgV7EaAhTv6ffhTgV7LZshBvnfhhTgV7KZZgvvifkhTgV7DZJgdvofnhTgV7rYafvuHfphSgV8GXwfMs1frhSgV8ZXLexrvfthR
					gV8lWueeq4fthPgW8sWgeRqUfthOgW8xWkeMqKfrhOgW8wW9eQqjfphPgW8mXpefrjfnhQgW8JYie9tM]],
				["LowerLeg.L"] = [[
					fcgzgCx3gKgG6ifag0gEyugqgo57fZg0gGzfhHg/5VfYg0gHz7hghP48fXg0gHz6h1hd47fWg0gGziiEhq5MfWgzgFzAiLht5lfWgzgEyjiGhj57fXgzgDyS
					h3hJ6KfZgzgDyOhdgi6PfbgzgDyUg7fz6Nfcg2gAw5gtfO7Jfdg5f9vvgYed7zfeg7f7uxgCdq8Sffg8f6uAfwdC8mfgg8f5thfmcw8zfgg7f4tXfnc685ff
					g5f5tpfxdi81feg3f6ubf/ed8gfcg1f9v0gLfb7zfcgzgCx3gKgG6ifagzgEylgbgu6BfZg0gFzPgqhN5hfZg0gGzkg3hl5PfYg0gGzchAh65UfYg0gFy9hE
					iL5pfYgzgDyWhAiR6GfYgzgCxzgziH6ffZgygBxdgchu6vfbgygBxWf+hH62fdgygBxbfagZ60feg1f+v7fJfr7vfgg4f7use1ey8Xfhg5f5tsejd68zfig6
					f4s9eZdN9Efig6f3sjeac49Nfhg6f3sjendA9Pfgg4f4tDfAdn9Gffg3f6uEfeei8sfdg1f9vqf6ff75]],
				["Foot.L"] = [[
					fcgSgP/OgMf9m9fcgSgP/Ng3f0m9fcgSgP/Mhafsm9fcgSgP/Kh3flm8fcgSgP/JiQfgm8fcgSgP/Hijfcm8fcgSgP/Hiqfam7fcgSgP/Hiifcm8fcgSgP/J
					iJfim8fcgSgP/Mhffrm9fcgSgP/Ogsf2m9fcgXgP/CgQf8nufcgbgP+3fqgGoYfcgfgP+ufDgSo4fcghgP+nekgbpLfcgigP+keVghpSfcghgP+meZgfpLfc
					gfgP+tewgXo4fcgbgP+3fUgMoYfcgXgP/Cf4gCnufcgSgP/OgMf9m9fcgSgP/Ogtf2m9fcgSgP/NhJfwm9fcgSgP/Mhffrm9fcgSgP/Lhxfnm8fcgSgP/Kh8
					fkm8fcgSgP/Kh8fkm8fcgSgP/Lhsfom8fcgSgP/NhNfvm9fcgSgP/Oggf5m9fcgSgP/OfrgFm9fcgXgP/CfHgOnufcgbgP+1edgboYfcgfgP+qd3goo3fcgh
					gP+idcgxpKfcgigP+fdUg0pQfcghgP+idjgvpKfcgfgP+reHgjo3fcgbgP+2e5gToYfcgXgP/CfsgFnu]],
				["UpperLeg.R"] = [[
					gchTgX7RmZgPvdgZhTgW73nPg3t7gXhSgW8QoAhTspgVhSgW8forhkrlgThRgW8opNhtqygThPgW8spghvqUgThOgV8uphhpqRgVhOgV8qpNhaqugXhPgV8d
					onhBrxgZhQgV7+n0gctagchTgV7Dm3fjvogfhVgV6tmWfCwZghhXgV6Xl3ekxFgjhXgV6LlgeQxdglhXgV6QlXeKxYglhWgW6ilaeTw8glhVgW64lkemwYgj
					hUgW7Jlye/v3gihTgW7TmAfbvigfhTgW7VmNf2vagchTgX7RmZgPvdgZhTgX77nGhGt2gXhSgX8YnwhxsdgVhSgX8roViSrQgUhRgY83oxiqqTgThPgY8/pA
					i4psgUhOgY9Co8i9pkgVhOgY9Aoji2qBgXhPgY80n3ihrJgahQgY8Xm/h6s7gdhTgY7dl6g7vSgfhVgY7FlXgVwJgihXgY6tk3fxw6gkhXgY6fkjfWxVglhX
					gY6ikffJxSglhWgY6xkqfKw3glhVgY7Ek+fVwSgkhUgX7TlVflvygihTgX7altf1vdgfhTgX7ZmEgDvX]],
				["LowerLeg.R"] = [[
					gkgzgCx3f2f66igjg2f+wVgNgh7gghg4f8vCgqhV8Mggg6f6t8hGiK8sgfg6f4tGhbi09Bgeg6f3sjhmjI9Ngeg5f3sahli+9Sgfg4f3swhYiW9Nggg2f5tr
					hEhZ83gig0f8vOgwgX8IgjgygBxbgmfn60glgzgDyPgNfB6Rgmg0gFy+f0ek5ugng0gGzZfdeQ5Ygog0gGzXfKeA5Ygog0gFy9e8d15pgpgzgDyce2d06Bgo
					gzgCx/e5eC6WgngzgCxvfFee6jgmgzgCxufafI6ngkgzgCx3f2f66igjg2f/wff9gm7agig5f8vYgKhc8Bghg7f7uggViS8bggg8f5t3gci88rggg8f5thga
					jQ8zghg7f5thgNjH81gig6f5t7f4ig8sgjg4f7u0ffho8Tglg2f+wQfLgv7iglgzgDyUfFgN6Ngng0gFzEeufq5pgog0gHzwebfR5Hgog0gI0HeMe84zgpg0
					gI0AeBeo42gqg0gGzid8eW5MgqgzgFy7eAeO5qgpgzgDyYeOeU6EgogzgCyAeneq6XgmgzgCx3fLfO6h]],
				["Foot.R"] = [[
					gkgSgP/Of0gDm9gkgXgP/Cgaf5nugkgbgP+2hJfsoYgkgfgP+rh3feo3gkghgP+jiafSpKgkgigP+fisfMpQgkghgP+iinfOpKgkgfgP+qiMfXo3gkgbgP+1
					hifloYgkgXgP/Cg0fznugkgSgP/OgVf7m9gkgSgP/OftgEm9gkgSgP/NfKgMm9gkgSgP/MetgSm9gkgSgP/LeVgYm8gkgSgP/KeEgcm8gkgSgP/Kd+gdm8gk
					gSgP/KeHgbm8gkgSgP/MefgWm9gkgSgP/NfFgNm9gkgSgP/Of0gDm9gkgXgP/CgPf8nugkgbgP+3gwfzoYgkgfgP+thQfpo4gkghgP+mhmfipLgkgigP+khr
					ffpSgkghgP+nhdfkpLgkgfgP+ug8fvo4gkgbgP+3gRf7oYgkgXgP/CfogGnugkgSgP/OfUgKm9gkgSgP/MewgSm9gkgSgP/LeUgYm8gkgSgP/Kd9gdm8gkgS
					gP/Idqghm8gkgSgP/Hddgkm8gkgSgP/Hdcglm8gkgSgP/Idrghm8gkgSgP/LeLgam8gkgSgP/Ne7gPm9]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAhkgbC2hHh8s9gAhmgbC0gCiVs4gAhsgbC1e9iVs2gAhxgbC2eDh7s4gAhzgbC5dfhMs9gAhvgbC6dXgPtBgAhpgbC5dsfQtCgAhkgbC3eaeZs/gAhkgbC1
					fad0s6gAhpgbC0ghdos3gAhvgbC1hid1s3gAhzgbC4iSebs6gAhxgbC5ipfRs/gAhsgbC6iigRtCgAhmgbC4iAhNtB]],
				Spine = [[
					f8iEf/D7hRh2vJf6iGf/D8gsiAvNf5iLf/EHgBh0vkf5iRf+EVfVhVv+f6iSf+EbewgpwKf9iPf+EXeYf0wAf/iJf/EKeTfAvngCiEf/D+eieXvPgFiEf/D6
					fAeCvIgGiIf/EBfpeEvXgHiOf/EOgVeZvygGiSf+EZg/e/wGgFiRf+EahefxwHgCiMf+ERhtgnv0f/iGf/EDhohXva]],
				Neck1 = [[
					f6ilfpFChYhwxDf3infpE9g8h3w9f1itfqFNgXhpxZf1izfrFpfuhLyEf3i1frF9fHgiyif7ixfrF8eofxyff/irfqFneZfBx+gEimfpFMeeecxTgIilfpE9
					e1eKw7gKiqfqFDfWeOxHgLiwfqFbf9elxvgKi0frF1gmfJyXgHizfrGAhKf2ylgDiufqFzhigoyRf+iofpFZhnhUxn]],
				Neck2 = [[
					f5jAfcFShahvxdf1jCfcFGhEhwxMfzjIfeFbgmhdxufzjPfgGEgCg+yrf2jRfhGmfbgWzbf6jNfhGqe4fpzff/jHffGMeie8y0gFjBfdFjegeax2gKjAfcFI
					eveOxOgMjFfdFNfKeXxXgNjMffFufrexyMgMjQfhGXgRfVzHgJjQfhGtg3gAzjgEjKfgGfhVguzOf+jDfeF3hhhXyV]],
				Neck3 = [[
					f3jWfSFchbhuxsfzjYfSFJhMhqxQfyjffUFig0hSx5fyjmfYGYgWgxzIf1jpfbHKfwgK0Jf5jlfaHTfJfg0Sf/jefXGtese2zfgGjYfUF0eieZyOgLjXfSFO
					ereRxWgOjbfTFQe/egxdgOjjfWF7fae+yfgNjofaG0f9fiztgJjofbHVgkgL0WgEjifZHEhIg1z/f+jbfVGQhbhby3]],
				Head = [[
					f3jtfJAHgUiNhDfyjvfIAGg1iAgrfxj2fLAFhQhfg3fyj+fRAGhdgzhef0kBfWAHhXgAiHf5j9fWAIhCfHiXf/j2fRAIgieUiDgGjvfLAIf+d2hYgMjtfIAH
					fbd2gzgPjyfJAGe8ePgsgPj6fOAGeoe2hIgNkAfUAHekfmh0gKkAfWAIexgciTgEj6fUAJfNhUiRf9jyfOAIfvh+hv]],
				Jaw = [[
					fyj5el/0f8dxigfuj6ej/yfZd7i4fukBen/ze8eZiyfxkKet/1erfBiwf1kPey/4epf1iQf8kMey/7e3gwhngEkEet/6fShnhggLj7en/2fyiJiLgRj4ej/y
					gViNiwgSj9ek/zg3h4i3gRkGeq/0hOhUi1gNkNew/2hYgmijgIkOez/6hSfuh7gAkIew/7g8eyhYf4j/eq/4gfeEh0]],
				Crest = [[
					f4lNfKZ4iOgN/Uf3lPfHZhiJfp/Qf4lWfLZshufI/Tf6lefVaThGex/bf8lgfda7gTer/jf/ldffbLfXez/mgClWfZa3effG/hgGlPfPaNd6fj/YgJlNfHZp
					dxgF/RgJlSfIZieDgp/QgHlafQZ9ekhF/XgFlgfaapfShU/ggClfffbHgKhT/lf/lafdbFhGhF/kf8lSfUajh3gs/d]],
				["Humerus.L"] = [[
					fVihfxaySgmC74fSiifxaVSXlV74fQinfwaPR5ki7wfQirfvaWRNj57hfSitftadQajn7IfWiqfraaPoj06ofaikfoaOPCkb6HfeigfnaIOvlP5wfiihfmaX
					OvmC5ofkinfoa9O/mo5xfliufqbtPam76GfkizfscTQBm+6jfhiyfucdQym57DfdisfwcIRmmw7efZilfxbeSOmg7x]],
				["Forearm.L"] = [[
					eZiqgddlRZna7YeWiugcdHRNmw7ZeTi1gZc8QrmA7QeSi6gVdAP8lb69eRi6gQdEPJlO6heTi2gKc+Oblf5+eVivgEcyN6mJ5deZipgBcuNtm/5FecingBc/
					Nynx48efipgEdoOEoT5DehiugKebOgog5VeiixgQfDPFoe5xehixgWfPP0oV6Tegiugae8QloI6zedirgdeSRLn37L]],
				["WingFinger1.L"] = [[
					ddikhHglRTnz7TdZirhEf3RDnB7ZdVizg/gVQZmy7FdRi5g4haPgnF6cdPi5gviLOpnm5rdPi0gliBOAoA5IdRirgdhENqoI45dUijgYgANmoI44dYidgZfs
					NyoY46dcidgfgjOIpC47dgiegniPOmp542diiggwj4PNqf40dkigg5kjP4qg5JdjighBj4Qkp557dhihhGiPRGo56x]],
				["WingFinger2.L"] = [[
					cqiUhtl4R6oN64ckiehplLRgnf7BcfilhhlnQ3nX6ncbilhXmpQHnz5zcYihhJnXPboe49cXibg9nLO3pA4bcXiUgzmOOfpO4WcZiPgvlLOXpR4fcdiLgwk3
					Ojpf4mckiGg3luPDqE4icriBhBnYPwqy4Qcyh9hLo9QirP4Cc2h8hXppRQrH4Sc1h/hipCRwqY5IcwiIhqneSApT6L]],
				["WingFinger3.L"] = [[
					cFh1iMq7Txo/59b8iCiIqRTOoV6Lb2iHh+qrSloW5sbyiEhvrmR+o74vbwh8hesMRcpw30bvh1hQr9Q+qZ3XbthxhGrBQlqr3dbuhuhCqBQaqv3wbyhqhFpv
					Qnq638b7hjhNqiRPra3wcHhZhXsFSJsB3QcThRhhtkTFsW2zcZhPhuuPTysF27cXhVh8twUJrP30cPhjiIsXUIqF5D]],
				["Vine.L"] = [[
					dlidhMwuqGkk47dgijhJwHn0iy6XdbirhEyJl8gX5qdYiwg91Xlee93KdViwg13ql/f+0rdVirgr3nmvi60TdXijgj09nalz2RdaibgfxNnSnJ49dfiWggvD
					mLm66qdjiVglv/lald6odniXgty/mQjW4vdqiZg114oPiA1wdsiZg+3Kp8iazkdriYhG2Pq/j7z0dpiZhLzfrQk92M]],
				["Humerus.R"] = [[
					ggigfmaMxTaX5qgdijfnanxLZp5rgbirfpbVw1ZN57gbixfrcDwUZC6UgdizftccvoZE6zghiwfvcWu0ZL7Rglipfwb0uEZX7pgpijfxbHtlZt72gtihfxah
					thaT75gvikfwaQt2bF71gwipfwaSucb17qgvitfuabvMcU7WgsisfsadwAcW65goinfpaUwtb76XgkiifnaJxLbM56]],
				["Forearm.R"] = [[
					hlingAczySYm4+hiiogCdRyGX84+hgisgHeBxvXk5LheiwgNexxPXf5iheixgTfNwkXm6ChfiwgYfJvzXx6jhiisgcepvGYA7Ahliqgdd7urYW7ThpisgcdU
					uqY67Zhsixgac/vCZo7Whui4gXc9vsaV7Ihvi7gTdDwdaw6whui5gNdDxPat6QhsizgHc4x4aO5thpisgCcuyPZc5P]],
				["WingFinger1.R"] = [[
					iqifgYftyWXz45imidgcf+yFXW48iiidgihVxqWi45ififgrjIxHVw4zidigg1kYweVb47icigg9kYvxVv5fieighEjIvJWl6XihiihHhVuxXr7GiliohGgE
					uyYq7aipivhCf+vPZL7Siti3g8g2wDZI6yiwi6g0h4w9Yr6Dixi3gqiOxtYL5XiwivghhnyNX64+iuimgagfyaX543]],
				["WingFinger2.R"] = [[
					jliNgvk5xmWr4jjgiJgzlKxPWR4mjZiEg8mfwoVl4ajRh/hGoPv3U84HjMh8hRpdvGUw4FjKh9hdpfueVN4pjNiDhnoUuFWJ5qjTiOhsmnuAXS6mjZiZhrlY
					uQYO7CjfiihmlRuzYq64jkimhcmHvhYe6PjnijhQnGwQX45XjpiehDnZw4XP4ojpiXg3mxxXW34WjoiSgwlqxoWx4a]],
				["WingFinger3.R"] = [[
					kRhthDpwvjVO34kKhnhJqAvIU435j/hehSrQuVUS3ijyhUhcs4tYTx2/jphPhnuCsiTt2xjnhRh1uIr/US3SjthbiDtIr1VV4cj2hsiLrmsBWg5lkAh8iLqd
					sfXb6KkHiGiEqXtGXw6AkNiGh3rItvXb5QkPiAhnr/uTWq4QkRh4hWsMuzV53hkShzhKrjvQVb3WkThwhDqevjVT3m]],
				["Vine.R"] = [[
					ikiYgfvyZNY06AifiVgivJaXZs64ibiWgpxYaZbm55iXiYgx0kYzdh3SiViZg62xW1eB0aiUiZhC2/Vec4zWiViYhJ1BUwbb01iZiahMx9VIbD3oidighLwD
					W/cM54iiinhHw3ZSec6TiniuhBzvaegm4jiqixg52vaWg31xiriugw3+Zqes0Kiringn2jY5bh1EioieghzDYhZU3p]],
				Tail1 = [[
					gAhkgbi0jPfX/sgAhmgbiIiZgv/0gAhsgbh9hGh7/2gAhxgbiafpiw/xgAhzgbjMeUjK/ogAhvgbjydRjE/ggAhpgbjzcoib/fgAhkgbjOckhT/ngAhkgbic
					dHf8/xgAhpgbh9eOep/2gAhvgbiHfodn/1gAhzgbiyhDc//tgAhxgbjiiRc1/jgAhsgbj3jHdM/egAhmgbjkjfeG/i]],
				Tail2 = [[
					gNhYhcg8lIfU/jgKhdhdfjjigw/ygFhkhee1hRh+/4f/hnhefTe1ix/1f6hlhdgncrjJ/qf2hehch6bIjE/afzhYhbiVaVif/TfyhWhchnachZ/bf0hahdgN
					bkf+/rf4hhhefDdjem/2f+hmhee7f+dl/4gDhmhef5iUdA/xgIhihchVkMc2/igLhbhciRlYdK/UgOhWhbiGlveA/V]],
				Tail3 = [[
					gjhTicf/nVfU/IgZhgifeDldgt/dgKhpihcpihh6/qf6hqihcsfKio/sfthhifeLcFi4/kfjhUicgGZviy/PfdhNiahMYZiT+9fbhPibgvYQhV/AfhhZiefC
					ZdgA/TfuhligdNb7ep/lf+hrihcdfKdr/sgNhmigdTiddN/qgZhaidfKlNdI/bghhPiag0nFda/FglhMiahKn2eI+8]],
				["UpperLeg.L"] = [[
					fjhHge6QZtdrxAflhIgd7YYOdNuVfnhMgd8dXIdLrRfphQgb9cWedNnkfphRga+DWPdTkKfphOgY+TWSdliHfnhJgX+ZWeeNiPfmhGgW+NWzfSlGfkhIgW9j
					XJgUoefihPgW8nXxhBrqfghXgX61ZKhzv7ffhbgZ4SbSis0Gffhaga5LbNhEzHfghUgc6YaifTxOfhhMgd6wZ+eAwW]],
				["LowerLeg.L"] = [[
					fXgngNpqjBfA+VfXgsgHl/iqeW/Rfag2gAl5hods/UfdhCf5oxgadW+pfghKf1s2fSdb9LfihLfywjeWd+7QfihFfxzJdne85ffgg7fx06dOgL4Dffg1f01E
					ddhL36fdg1f60meQhx4Wfcg1gE1wfAhf3Yfdg1gR3xfQgI1Zfag1gP07g7gP4MfXgxgMwqiWgW7NfWgsgLspjMf69N]],
				["Foot.L"] = [[
					fcgSgp/JiNfhm8fcgfgn+yhufioffcgpgg+ggjf1pofcgvgX+SfWgOqRfcgxgM+NebgjqYfcgtgC+Tdygvp/fcgkf6+jdfgwpFfcgZf2+8drglnvfcgSf5/L
					eZgXm8fcgSgA/OfXgJm9fcgSgG/Of3gCm9fcgSgN/OfagIm9fcgSgU/Ng5fzm9fcgSgb/JiKfhm8fcgSgi/GivfZm7]],
				["UpperLeg.R"] = [[
					gbhHgW9wo5f9ntgdhLgW9LopfXp2gfhTgX71npemtvgghZgY5ol3dzyGghhbgZ4Ykgd20GgghXgb53lJf5yHgfhQgd6rlxhdwogehJgd6nmOiSwegchHge63
					nGirvogahKgd76oYi2s5gYhPgc8/pRi0pdgXhRga9zptixlwgXhQgZ+Npxini7gYhMgX+XppiKh3gZhHgW+XpahUjT]],
				["LowerLeg.R"] = [[
					ggg1fz14i2fR3Jgig1f20niKed4Ugkg1f+1AhWeQ4Cgkg1gK2vgxfE2egkg1gS25gGgA2Wgng0gNy0eSfp50gqgvgLuldIf08VgqgpgMq+cxgh94gpgpgKnZ
					dChS+9gogwgElgd0iA/Yglg8f9nDe/ii/FgihHf3qygLir+AgfhMfzu0hNiX8OgehJfxyAiEhm6UgfhBfw0Fipgd4w]],
				["Foot.R"] = [[
					gkgSf1/KiGfim8gkgSf8/NhGfwm9gkgSgD/OgUf8m9gkgSgK/OgNf9m9gkgSgR/OgFf/m9gkgSgY/LeYgXm8gkgSgf/Hdcglm8gkgSgm/Hdaglm8gkgZgo+9
					d6ginwgkgkgk+pe1gWpHgkgtgc+YgGf+qBgkgxgS+OhKfnqZgkgvgH+Ph8fWqQgkgpf++aibfPpmgkgff3+viffUoe]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAjNgb/9gAgAhbgAjRgb/+gAgAhHgAjZgb//gAgAgUgAjhgb//gAgAfhgAjkgb/+gAgAfNgAjhgb//gAgAfhgAjZgb//gAgAgUgAjRgb/+gAgAhH]],
				Spine = [[
					gAjJfwAHgAgAiagAjOfwAHgAgAiggAjYfwAIgAgAisgAjifwAJgAgAi5gAjmfwAKgAgAi+gAjifwAJgAgAi5gAjYfwAIgAgAisgAjOfwAHgAgAig]],
				Neck1 = [[
					gAjPfJA/gAgAn1gAjUfJBCgAgAn/gAjefJBIgAgAoXgAjpfJBPgAgAowgAjtfJBSgAgAo6gAjpfJBPgAgAowgAjefJBIgAgAoXgAjUfJBCgAgAn/]],
				Neck2 = [[
					gAjeevCHgAgArZgAjievCNgAgArogAjtevCbgAgAsLgAj5ewCqgAgAsugAj9ewCwgAgAs9gAj5ewCqgAgAsugAjtevCbgAgAsLgAjievCNgAgAro]],
				Neck3 = [[
					gAjuecDkgAgAupgAjzedDugAgAu8gAj/eeEGgAgAvogAkLefEfgAgAwUgAkQefEqgAgAwmgAkLefEfgAgAwUgAj/eeEGgAgAvogAjzedDugAgAu8]],
				Head = [[
					gAkCeOACgAgAg+gAkHePACgAgAg+gAkUeRACgAgAg+gAkgeTACgAgAg+gAkmeUACgAgAg+gAkgeTACgAgAg+gAkUeRACgAgAg+gAkHePACgAgAg+]],
				Jaw = [[
					gAkNdp/zgAgAjbgAkTdq/zgAgAjbgAkfds/zgAgAjbgAksdu/zgAgAjbgAkxdv/zgAgAjbgAksdu/zgAgAjbgAkfds/zgAgAjbgAkTdq/zgAgAjb]],
				Crest = [[
					gAliePabgAgA/ggAloeQa4gAgA/kgAl0eSargAgA/igAmBeUZ9gAgA/agAmGeVZJgAgA/PgAmBeUYtgAgA/JgAl0eSY6gAgA/MgAloeQZngAgA/W]],
				["Humerus.L"] = [[
					fajOfOHWPIdSrHfajTfOJaOje6uYfajdfOM7PBlLyjfajofORDQQsH0IfajsfOS0QIviy3fajofOP8OsuBwafajdfOKjOPoPtafajTfOHRPChLrC]],
				["Forearm.L"] = [[
					fJj9eWISORgHsFe5kFeiLKNkisvjeekEe5PAOZnwzFeRj4fUR0PssY0EeQjsfbR1PBtxyjeQjrfHOjNVrMvpeejyenKCNTmQsVe7j4eVHnObhoqz]],
				["WingFinger1.L"] = [[
					eqkmdiJ9NShztjeIksd8OcM9mYxpdbkfetTNOgrK0tdJkEfaU1P9t11NdHjxfeSlOls6zUdKj0ezOJMPoUvodpkId5J/MLjMroeakZddISNbghqv]],
				["WingFinger2.L"] = [[
					eElIc4MPLqhuurdPlEdoSgMeoRzxcakoeyY9Phtv2qcKkGfragRcv13CcGj1fhWiO/t41PcPkDeaQWLJnow4dCkhdKLkKWhQrpd/k5cqJ4Lge3ql]],
				["WingFinger3.L"] = [[
					dellcXOYKdhJvucWlQdiWpNNp62AblkgfIezSgwD4Ibaj6gJgIUwxi4SbOjxfwaRQbum3HbakPeGSQKTmax8cjk5cgNCIvenq+dplWb9LZJ2clpx]],
				["Vine.L"] = [[
					ejkodspWUcfa8UeEkseHpgatg4+Edbkee5msiKie/HdNkDfmiklbkm/FdLjxfpg7idlf/adKj1e/iMb1jU/edlkLeEkjVigI94eUkddnnNSoep8H]],
				["Humerus.R"] = [[
					gmjOfOHWw4iurHgmjTfOJaxdhGuYgmjdfOM7w/a1yjgmjofORDvwT50IgmjsfOS0v4Qey3gmjofOP8xUR/wagmjdfOKjxxXxtagmjTfOHRw+e1rC]],
				["Forearm.R"] = [[
					g3j9eWISxvf5sFhHkFeiLKycdUvjhikEe5PAxnYQzFhvj4fUR0wUTo0EhwjsfbR1w/SPyjhwjrfHOjyrU0vphijyenKCytZwsVhFj4eVHnxleYqz]],
				["WingFinger1.R"] = [[
					hWkmdiJ9yueNtjh4ksd8OczDZoxpilkfetTNxgU20ti3kEfaU1wDSL1Ni5jxfeSlxbTGzUi2j0ezOJzxXsvoiXkId5J/z1c0rohmkZddISylffqv]],
				["WingFinger2.R"] = [[
					h8lIc4MP0WeSurixlEdoSgziXvzxjmkoeyY9wfSR2qj2kGfragukQL3Cj6j1fhWixBSI1PjxkDeaQW03YYw4i+khdKLk1qewrpiBk5cqJ40ghJql]],
				["WingFinger3.R"] = [[
					iillcXOY1je3vujqlQdiWpyzWG2AkbkgfIeztgP94Ikmj6gJgIrQOe4SkyjxfwaRvlRa3HkmkPeGSQ1tZmx8jdk5cgNC3RhZq+iXlWb9LZ2Kjbpx]],
				["Vine.R"] = [[
					hdkodspWrkgm8Uh8kseHpglTfI+Eilkee5msd2di/HizkDfmikalba/Fi1jxfpg7djah/ai2j1e/iMkLcs/eibkLeEkjqef494hskddnnNtYhX8H]],
				Tail1 = [[
					gAjNgbTagAgA9agAjRgbU4gAgA9/gAjZgbWqgAgA+mgAjhgbXtgAgA+5gAjkgbXYgAgA+zgAjhgbV3gAgA+WgAjZgbUGgAgA9sgAjRgbTGgAgA9R]],
				Tail2 = [[
					gAj+hKP3gAgA7ngAj9hOR/gAgA8wgAj+hTU5gAgA+AgAkChWW2gAgA+pgAkHhVWngAgA+lgAkJhRUWgAgA9ygAkHhMRegAgA8fgAkChJPqgAgA7g]],
				Tail3 = [[
					gAk5hrNDgAgA5xgAkyh4PIgAgA7LgAkqiGSxgAgA9IgAkniOV4gAgA+WgAktiNWcgAgA+hgAk3iDUFgAgA9sgAk+h0QXgAgA75gAk+hpNigAgA6H]],
				["UpperLeg.L"] = [[
					fki7gx6TZ3gOxIfki+gx6eZ3gKw3fkjEgw64Z3gAwNfkjLgv7SZ3f2vifkjOgu7cZ3fyvQfkjLgv7SZ3f2vifkjEgw64Z3gAwNfki+gx6eZ3gKw3]],
				["LowerLeg.L"] = [[
					fciYghfMgAgA/+fcicggfhgAgA//fcijgdgTgAgA//fcirgahGgAgA/+fcivgZhbgAgA/9fcirgahGgAgA/+fcijgdgTgAgA//fcicggfhgAgA//]],
				["Foot.L"] = [[
					fciahE+JgAgAqtfcidhC+QgAgAqZfcijhA+ggAgApqfcipg9+ugAgAo5fcisg8+0gAgAolfcipg9+ugAgAo5fcijhA+ggAgApqfcidhC+QgAgAqZ]],
				["UpperLeg.R"] = [[
					gci7gx6TmJfyxIgci+gx6emJf2w3gcjEgw64mJgAwNgcjLgv7SmJgKvigcjOgu7cmJgOvQgcjLgv7SmJgKvigcjEgw64mJgAwNgci+gx6emJf2w3]],
				["LowerLeg.R"] = [[
					gkiYghfMgAgA/+gkicggfhgAgA//gkijgdgTgAgA//gkirgahGgAgA/+gkivgZhbgAgA/9gkirgahGgAgA/+gkijgdgTgAgA//gkicggfhgAgA//]],
				["Foot.R"] = [[
					gkiahE+JgAgAqtgkidhC+QgAgAqZgkijhA+ggAgApqgkipg9+ugAgAo5gkisg8+0gAgAolgkipg9+ugAgAo5gkijhA+ggAgApqgkidhC+QgAgAqZ]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAhxgbDfgAgAufgAhvgeDrgAgAu2gAhsgkEJgAgAvtgAhogrEugAgAwsgAhmgvFHgAgAxUgAhqgeDwgAgAvAgAhxfxBQgAgAoygAhxfxBQgAgAoygAhxfxBQ
					gAgAoygAhxfzBUgAgApCgAhxf9BxgAgAqbgAhxgLChgAgAsYgAhxgXDOgAgAt+gAhxgbDfgAgAufgAhxgbDfgAgAufgAhxgbDfgAgAuf]],
				Spine = [[
					gAiUgCE+gAgAxHgAiTgFFSgAgAxkgAiRgOGFgAgAyvgAiPgXHDgAgA0AgAiNgeHtgAgA0zgAiNgGFjgAgAx+gAiIfMBpgAgAqEgAiIfMBpgAgAqEgAiIfMBp
					gAgAqEgAiIfOBwgAgAqYgAiLfbCagAgAsHgAiQftDggAgAuigAiTf9ElgAgAwegAiUgCE+gAgAxHgAiUgCE+gAgAxHgAiUgCE+gAgAxH]],
				Neck1 = [[
					gAi4fxGDgAgAytgAi3f1GigAgAzXgAi3gBH2gAgA0+gAi1gPJdgAgA2rgAi0gXKkgAgA3vgAiyf3HQgAgA0RgAifesBqgAgAqIgAifesBqgAgAqIgAifesBq
					gAgAqIgAihevBzgAgAqhgAine/CogAgAsqgAiwfWEFgAgAvngAi2fqFigAgAx8gAi4fxGDgAgAytgAi4fxGDgAgAytgAi4fxGDgAgAyt]],
				Neck2 = [[
					gAjUfnGLgAgAy3gAjUftG0gAgAzugAjUf9ImgAgA1zgAjTgPK0gAgA39gAjSgaMXgAgA5QgAjQfxH/gAgA1IgAixeVBLgAgAoigAixeVBLgAgAoigAixeVBL
					gAgAoigAizeYBUgAgApAgAi9eqCMgAgArmgAjJfGD2gAgAvKgAjRffFigAgAx9gAjUfnGLgAgAy3gAjUfnGLgAgAy3gAjUfnGLgAgAy3]],
				Neck3 = [[
					gAjrfgGLgAgAy3gAjsfoG/gAgAz7gAjtf7JOgAgA2dgAjsgSMGgAgA5CgAjqghOIgAgA6hgAjofuIogAgA11gAi+d/AvgAgAmugAi+d/AvgAgAmugAi+d/Av
					gAgAmugAjAeDA3gAgAnSgAjOeYBvgAgAqWgAjee4DhgAgAuigAjofWFcgAgAx0gAjrfgGLgAgAy3gAjrfgGLgAgAy3gAjrfgGLgAgAy3]],
				Head = [[
					gAkDfYACgAgAg+gAkEfiAIgAgAiogAkGf7AwgAgAmzgAkEgXCHgAgArZgAkBgqDXgAgAuQgAkBfsAggAgAlkgAjIdpEGgAgAQXgAjIdpEGgAgAQXgAjIdpEG
					gAgAQXgAjLdtDwgAgARBgAjdeECEgAgAUxgAjyeqAggAgAacgAj/fMABgAgAfUgAkDfYACgAgAg+gAkDfYACgAgAg+gAkDfYACgAgAg+]],
				Jaw = [[
					gAkOe0/8gAgAhwgAkTe//+gAgAhJgAkefd/+gAgAfNgAkkgB/vgAgAcBgAkkgb/ugAgAb3gAkWfM+jgAgApggAitdN5ogAgAzKgAitdN40gAgA0LgAitdN5N
					gAgAzsgAiydQ6zgAgAxdgAjLdi85gAgAtvgAjueE+6gAgAoOgAkHen/zgAgAjagAkOe0/8gAgAhwgAkOe0/8gAgAhwgAkOe0/8gAgAhw]],
				Crest = [[
					gAljfZZygAgA/YgAlkftbPgAgA/ogAlfgee8gAgA/+gAlPhUjKgAgA/1gAk/h0l5gAgA/cgAldgJdVgAgA/4gAj2cUK7gAgA4EgAj2cUMLgAgA5GgAj2cUMO
					gAgA5IgAj9caM0gAgA5mgAkidBQOgAgA70gAlKeEVJgAgA+FgAlffDZJgAgA/PgAljfZaGgAgA/cgAljfZZygAgA/YgAljfZZygAgA/Y]],
				["Humerus.L"] = [[
					faizfzbuO1jq6Zfaizf3bZOgh06UfaiygCaXOIdQ5yfaiwgPYzOhYb4qfaivgYXkPPVl3tfaiuf5ZGNXcx42faicewaDR6uf4EfaicewZJTnu54hfaicewZH
					Tru64ifaidezZLTeuf4sfaijfCZkSasI5ffairfYabQ+ob6XfaixfsbSP3lF6vfaizfzbpPJjx6kfaizfzbuO1jq6ZfaizfzbuO1jq6Z]],
				["Forearm.L"] = [[
					eWi6gQeQNolU5leWjAgSdmNOjU5keZjOgabwM1eS5MejjegmZcNcY34LetjmgvXzObVo3OeajPgKaGMSde4WeciTfZdDRxv73oefiafecNTdwP4PefiafecL
					TiwQ4RefibfgcOTRv24aecijfscjR9tk5HeZiuf+dRQLp95zeYi4gOd8Oxmr6BeWi6gReNN9la5yeWi6gQeQNolU5leWi6gQeQNolU5l]],
				["WingFinger1.L"] = [[
					dRizgohvNXml5GdQjAgogsMzkW5MdVjigsd+MMep5AdqkIg4axM/YU3/d/kbhDYqOTUg24dXjrgWbwL0dS4Sdlh9gEhIS0xH3kdriKgOiCVAyF36driKgPiF
					VGyH36dpiMgQiIUxxx4BdjiUgXiZTAvt4idbiigiikQgsJ5FdVivgsiaOlok5TdSizgrh/Nqm45NdRizgohvNYml5GdRizgohvNXml5G]],
				["WingFinger2.L"] = [[
					cXidg9mgN9nW4hcSizg6lPNBlC4scWjsg7h6Lqe64lc0kqhHd7L6X/3edWlLhVbTNETx2Mcaj/ghfRLHdP4DdAhcgvmQVFxf3pdOhqhAo8Yay13DdOhqhBpD
					Yjy33BdMhrhBpIYJym3Ec/hzhCpcV7w93WctiChEpMSetu30cfiUhGoPPpp/4QcZichBnFOVn54ecXidg9mgN9nW4hcXidg9mgN9nW4h]],
				["WingFinger3.L"] = [[
					bqh8hNq8Pooe3wbgiZhIpiOQmC4GbdjqhFlsL9fa4QcBlChTg/LhXs3Gcslxhkd2MeS81mbhkIgqioLIdQ38cvg2hXq0Ymx63DdNhChrvCdszT0fdOhDhrvN
					d5zV0WdKhDhqvTdczL0Yc2hGhnvsa1yJ0icXhUhgvLWUvl1Yb8hrhatpSRr42ibuh5hSr1QPpU3abqh8hNq8Ppof3vbqh8hNq8Pooe3w]],
				["Vine.L"] = [[
					dXiqgu1JlnkW27dVi2gt1ij0jl3EdWjXgw2We6gG23dmj8g74mZ7bzzFd5kRhG6DXkcbwJdXjggb2Sfmjq2qdvh7gLnos0qY6Vd1iIgVpTrIlo79d1iJgVup
					s2hN5Wd0iKgWwZvGi42xdtiRgdu0t4mJ38djicgovwpmlr5hdcingxzimgjl4OdZiqgx1clwjo2wdXiqgu1SlrkU2ydXiqgu1JlnkW27]],
				["Humerus.R"] = [[
					gmizfzbuxLcW6Zgmizf3bZxgeM6UgmiygCaXx4iw5ygmiwgPYzxfnl4qgmivgYXkwxqb3tgmiuf5ZGypjP42gmicewaDuGRh4EgmicewZJsZRH4hgmicewZH
					sVRG4igmidezZLsiRh4sgmijfCZktmT45fgmirfYabvCXl6XgmixfsbSwJa76vgmizfzbpw3cP6kgmizfzbuxLcW6ZgmizfzbuxLcW6Z]],
				["Forearm.R"] = [[
					hqi6gQeQyYas5lhqjAgSdmyycs5khnjOgabwzLhu5MhdjegmZcyknJ4LhTjmgvXzxlqY3OhmjPgKaGzuii4WhkiTfZdDuPQF3ohhiafecNsjPx4PhhiafecL
					sePw4RhhibfgcOsvQK4ahkijfscjuDSc5Hhniuf+dRv1WD5zhoi4gOd8xPZV6Bhqi6gReNyDam5yhqi6gQeQyYas5lhqi6gQeQyYas5l]],
				["WingFinger1.R"] = [[
					ivizgohvypZb5GiwjAgogszNbq5Mirjigsd+z0hX5AiWkIg4axzBns3/iBkbhDYqxtrg24ipjrgWbw0Miu4Sibh9gEhItMO53kiViKgOiCrAN736iViKgPiF
					q6N536iXiMgQiIrPOP4BidiUgXiZtAQT4iiliigiikvgT35FirivgsiaxbXc5Tiuizgrh/yWZI5NivizgohvyoZb5GivizgohvypZb5G]],
				["WingFinger2.R"] = [[
					jpidg9mgyDYq4hjuizg6lPy/a+4sjqjsg7h60WhG4ljMkqhHd70GoB3eiqlLhVbTy8sP2Mjmj/ghfR05ix4DjAhcgvmQq7Oh3piyhqhAo8nmNL3DiyhqhBpD
					ndNJ3Bi0hrhBpIn3Na3EjBhzhCpcqFPD3WjTiChEpMtiSS30jhiUhGoPwXWB4QjnichBnFxrYH4ejpidg9mgyDYq4hjpidg9mgyDYq4h]],
				["WingFinger3.R"] = [[
					kWh8hNq8wYXi3wkgiZhIpixwZ+4GkjjqhFls0Dgm4Qj/lChTg/0foU3GjUlxhkd2zitE1mkfkIgqio04iw38jRg2hXq0naOG3DizhChrvCiUMt0fiyhDhrvN
					iHMr0Wi2hDhqvTikM10YjKhGhnvslLN30ijphUhgvLpsQb1YkEhrhatptvUI2ikSh5hSr1vxWs3akWh8hNq8wXXh3vkWh8hNq8wYXi3w]],
				["Vine.R"] = [[
					ipiqgu1JaZbq27iri2gt1icMcb3EiqjXgw2WhGf623iaj8g74mmFkNzFiHkRhG6DocjlwJipjggb2SgacW2qiRh7gLnoTMVo6ViLiIgVpTU4aY79iLiJgVup
					TKez5WiMiKgWwZQ6dI2xiTiRgdu0SIZ338idicgovwWaaV5hikingxziZgcb4Oiniqgx1caQcY2wipiqgu1SaVbs2yipiqgu1JaZbq27]],
				Tail1 = [[
					gAhxgbkggAgA/rgAhvgeksgAgA/pgAhsgklMgAgA/kgAhogrlvgAgA/egAhmgvmGgAgA/ZgAhqgekBgAgA/vgAhxfxe7gAgA/+gAhxfxgigAgA//gAhxfxgn
					gAgA//gAhxfzg4gAgA/+gAhxf9iSgAgA/6gAhxgLj7gAgA/wgAhxgXk6gAgA/ngAhxgbk0gAgA/ogAhxgbkggAgA/rgAhxgbkggAgA/r]],
				Tail2 = [[
					gAhehciIgAgA/6gAhcheiIgAgA/6gAhXhkiIgAgA/6gAhRhqiIgAgA/6gAhNhuiIgAgA/6gAhZhfgmgAgA//gAh1g0dHgAgA/3gAhvg0gVgAgA//gAhug0gd
					gAgA//gAhtg2gugAgA/+gAhnhAiGgAgA/7gAhghNjSgAgA/0gAhchYjjgAgA/ygAhdhciwgAgA/3gAhehciJgAgA/6gAhehciIgAgA/6]],
				Tail3 = [[
					gAhVifgXgAgA//gAhTihgKgAgA//gAhOinfrgAgA//gAhIitfGgAgA/+gAhEixevgAgA/9gAhWiidxgAgA/6gAiBh2b6gAgA/ugAhth4gugAgA/+gAhsh4g7
					gAgA/+gAhqh5hMgAgA/+gAheiCiggAgA/5gAhTiPjQgAgA/0gAhOiZixgAgA/3gAhRiehTgAgA/9gAhVifgXgAgA//gAhVifgXgAgA//]],
				["UpperLeg.L"] = [[
					fkhVgX64Z3gAwNfkhTgY7TZufzvcfkhQgd8MZefUtnfkhNgi8/ZTe1rsfkhLgl9aZOejqhfkhOgY8NZHfKtZfkhVf30+a6hx3jfkhVf30+a6hx3jfkhVf30+
					a6hx3jfkhVf51caxhp3GfkhUgA3faNhF06fkhUgL5fZ2gcyUfkhUgU6nZ0gFwpfkhVgX64Z3gAwNfkhVgX64Z3gAwNfkhVgX64Z3gAwN]],
				["LowerLeg.L"] = [[
					fcg0gEymgAgA6CfcgzgEyjgFgE6Dfcg0gEyugPgL58fbg0gGzRgWgS5ifbg0gHzygXgW5Ifbgxf/wlghgR7Wfdgvf7uifgfu8ffdgvf7uifgfu8ffdgvf7ui
					fgfu8ffdgvf6uaflfw8kfcgvf6udf7f58ifcgxf9v4gGgA7xfcgzgCx0gDgB6kfcg0gEymgAgA6Cfcg0gEymgAgA6Cfcg0gEymgAgA6C]],
				["Foot.L"] = [[
					fcgSgP/OgAgAm9fcgSgP/OgGf/m9fcgSgP/OgTf8m9fcgSgP/Ogbf6m9fcgSgP/Ogef5m9fcgSgP/Ogkf4m9fcgSgP/OfbgIm9fcgSgP/OfbgIm9fcgSgP/O
					fbgIm9fcgSgP/OfigHm9fcgSgP/Of4gCm9fcgSgP/OgFf/m9fcgSgP/OgDf/m9fcgSgP/OgAgAm9fcgSgP/OgAgAm9fcgSgP/OgAgAm9]],
				["UpperLeg.R"] = [[
					gchVgX64mJgAwNgchTgY7TmSgNvcgchQgd8MmigstngchNgi8/mthLrsgchLgl9amyhdqhgchOgY8Nm5g2tZgchVf30+lGeP3jgchVf30+lGeP3jgchVf30+
					lGeP3jgchVf51clPeX3GgchUgA3flze706gchUgL5fmKfkyUgchUgU6nmMf7wpgchVgX64mJgAwNgchVgX64mJgAwNgchVgX64mJgAwN]],
				["LowerLeg.R"] = [[
					gkg0gEymgAgA6CgkgzgEyjf7f86Dgkg0gEyufxf158glg0gGzRfqfu5iglg0gHzyfpfq5Iglgxf/wlfffv7Wgjgvf7uigggS8fgjgvf7uigggS8fgjgvf7ui
					gggS8fgjgvf6uagbgQ8kgkgvf6udgFgH8igkgxf9v4f6gA7xgkgzgCx0f9f/6kgkg0gEymgAgA6Cgkg0gEymgAgA6Cgkg0gEymgAgA6C]],
				["Foot.R"] = [[
					gkgSgP/OgAgAm9gkgSgP/Of6gBm9gkgSgP/OftgEm9gkgSgP/OflgGm9gkgSgP/OfigHm9gkgSgP/OfcgIm9gkgSgP/Oglf4m9gkgSgP/Oglf4m9gkgSgP/O
					glf4m9gkgSgP/Ogef5m9gkgSgP/OgIf+m9gkgSgP/Of7gBm9gkgSgP/Of9gBm9gkgSgP/OgAgAm9gkgSgP/OgAgAm9gkgSgP/OgAgAm9]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhxgbDfgAgAufgAhugbDNgAgAt8gAhpgbCogAgAsqgAhkgbCMgAgArmgAhlgbCRgAgArygAhwgbDogAgAuxgAh3gbE8gAgAxDgAh4gbFKgAgAxZgAh4gbFK
					gAgAxZgAh4gbFKgAgAxZgAh4gbFKgAgAxZgAh4gbFKgAgAxZgAh4gbFKgAgAxZgAh4gbFKgAgAxZgAh4gbFKgAgAxZgAh4gbFKgAgAxZgAh4gbFKgAgAxZgA
					h4gbFIgAgAxVgAh2gbEggAgAwWgAhygbDvgAgAu9gAhxgbDfgAgAufgAhxgbDfgAgAufgAhxgbDfgAgAuf]],
				Spine = [[
					gAiUgCE+gAgAxHgAiQgBEigAgAwZgAiIf+DogAgAuwgAiCf8C9gAgAtZgAiDf8DEgAgAtpgAiUgDFTgAgAxngAiegJHlgAgA0qgAiggKH/gAgA1IgAiggKH/
					gAgA1IgAiggKH/gAgA1IgAiggKH/gAgA1IgAiggKH/gAgA1IgAiggKH/gAgA1IgAiggKH/gAgA1IgAiggKH/gAgA1IgAiggKH/gAgA1IgAiggKH/gAgA1IgA
					iggKH7gAgA1DgAicgHGzgAgAzsgAiWgDFagAgAxxgAiUgCE+gAgAxHgAiUgCE+gAgAxHgAiUgCE+gAgAxH]],
				Neck1 = [[
					gAi4fxGDgAgAytgAizfuFagAgAxxgAipfnEEgAgAvkgAigfiDGgAgAttgAihfjDRgAgAuCgAi4fzGlgAgAzbgAjGgCKJgAgA3XgAjHgFKygAgA38gAjHgFKy
					gAgA38gAjHgFKygAgA38gAjHgFKygAgA38gAjHgFKygAgA38gAjHgFKygAgA38gAjHgFKygAgA38gAjHgFKygAgA38gAjHgFKygAgA38gAjHgFKygAgA38gA
					jHgEKrgAgA32gAjCf9I6gAgA2IgAi6f0GugAgAzmgAi4fxGDgAgAytgAi4fxGDgAgAytgAi4fxGDgAgAyt]],
				Neck2 = [[
					gAjUfnGLgAgAy3gAjPfiFVgAgAxqgAjCfXDrgAgAu2gAi3fPCigAgAsbgAi5fQCugAgAs3gAjVfrG4gAgAzzgAjjgELpgAgA4rgAjlgIMhgAgA5XgAjlgIMh
					gAgA5XgAjlgIMhgAgA5XgAjlgIMhgAgA5XgAjlgIMhgAgA5XgAjlgIMhgAgA5XgAjlgIMhgAgA5XgAjlgIMhgAgA5XgAjlgIMhgAgA5XgAjlgIMhgAgA5XgA
					jlgIMXgAgA5QgAjgf8J9gAgA3LgAjXfsHCgAgA0AgAjUfnGLgAgAy3gAjUfnGLgAgAy3gAjUfnGLgAgAy3]],
				Neck3 = [[
					gAjrfgGLgAgAy3gAjlfZFKgAgAxagAjWfJDNgAgAt8gAjIe+B9gAgAq9gAjLfACKgAgArggAjtflHDgAgA0BgAj8gJNEgAgA5xgAj9gPOLgAgA6kgAj9gPOL
					gAgA6kgAj9gPOLgAgA6kgAj9gPOLgAgA6kgAj9gPOLgAgA6kgAj9gPOLgAgA6kgAj9gPOLgAgA6kgAj9gPOLgAgA6kgAj9gPOLgAgA6kgAj9gPOLgAgA6kgA
					j9gON/gAgA6bgAj5f9K6gAgA4DgAjvfnHPgAgA0QgAjrfgGLgAgAy3gAjrfgGLgAgAy3gAjrfgGLgAgAy3]],
				Head = [[
					gAkDfYACgAgAg+gAj8fPADgAgAeegAjqe6A0gAgAY6gAjYerCJgAgAUigAjcetB3gAgAVTgAkFfgALgBftjLgAkTgQDlgVfRupgAkUgYDvfUhhu4gAkUgYEZ
					gOflwIgAkUgYErgme4wlgAkUgYDxfYhZu9gAkUgYEOgAgAv3gAkUgYExgueqwugAkUgYD2fehKvHgAkUgYEFfzgbvlgAkUgYE1gyejwygAkUgYD8fng0vVgA
					kUgXDzfog0vEgAkRgACFgUfArRgAkIfiAMgAgFjXgAkDfYACgAgAg+gAkDfYACgAgAg+gAkDfYACgAgAg+]],
				Jaw = [[
					gAkOe0/8gAgAhwgAkCeo/qgAgAkjgAjieU+JgAgAqsgAjGeJ8DgAgAvYgAjLeK8egAgAukgBkVe9/pf7gTkogCk3gC/+fZggfwf8k3gK/7hWfChMgBk5gO//
					fngRfxgDk5gP/9e8grfPf9k3gL/7hPfHhGgAk4gN//gAgAgFgDk5gP/8etg0fEf9k4gL/9hCfRg7f/k4gM//gZfvgZgEk5gP/7emg4e/f+k4gL/+gvffgsf+
					k4gJ/+guffgtgCkxfq/+fXg1gAgAkYe//9gBf7hjgAkOe0/8gAgAhwgAkOe0/8gAgAhwgAkOe0/8gAgAhw]],
				Crest = [[
					gAljfZZygAgA/YgAlbfBXXgAgA+zgAk+eMSGgAgA80gAkddnOJgAgA6igAkjdtO1gAgA6/gAlkfucsftf7/0gAlPhcptfWfk+egAlOhko/hWg++qgAlHhprW
					fofu96gAlEhrsNe/fQ9jgAlOhlpIhPg5+ngAlJhoq1gAgA+GgAlDhrseeyfG9agAlNhlpbhCgv+igAlKhnqUgYgS+SgAlDhssnerfB9WgAlMhmp1gvgi+bgA
					lNhkphgugh+igAlcg8l2fFfh/bgAlnfxcZgFgB/ygAljfZZygAgA/YgAljfZZygAgA/YgAljfZZygAgA/Y]],
				["Humerus.L"] = [[
					faizfzWwNggA4afaivfwW2OKg846faikfqWyP+i758faicflWeRvkW6pfaidfmWjRakH6ifaizf1WtOGd44vfajAgDVpOZXz3NfajCgFVZOwWy2/fajCgFVZ
					OwWy2/fajCgFVZOwWy2/fajCgFVZOwWy2/fajCgFVZOwWy2/fajCgFVZOwWy2/fajCgFVZOwWy2/fajCgFVZOwWy2/fajCgFVZOwWy2/fajCgFVZOwWy2/fa
					jCgFVcOsW93Bfai9f+WEN2Z93ofai2f2WoNcec4QfaizfzWwNggA4afaizfzWwNggA4afaizfzWwNggA4a]],
				["Forearm.L"] = [[
					eYjUf/XOMzgA4CeYjNgAXqNVhU4keajAgCYfO7kD5qedi4gFY/Qll+6eeci5gEY6QRlq6VecjagEXMNVd94Werj5gQVOOYWw2mevj9gUU5O3Vn2Uevj9gUU5
					O3Vn2Uevj9gUU5O3Vn2Uevj9gUU5O3Vn2Uevj9gUU5O3Vn2Uevj9gUU5O3Vn2Uevj9gUU5O3Vn2Uevj9gUU5O3Vn2Uevj9gUU5O3Vn2Uevj9gUU5O3Vn2Ueu
					j8gTU9OyVz2XekjvgKV3NkZM3HebjbgBW6M0eQ33eYjUf/XOMzgA4CeYjUf/XOMzgA4CeYjUf/XOMzgA4C]],
				["WingFinger1.L"] = [[
					dWjygIZBMRgA4MdVjngNZ4Mwhu4vdWjSgabyOXlQ50dcjFgldRQJnq6kdbjHgjdAPznR6cdej/gQY4Mvd14beAkzgdVrOjVA2KeIk6ghVNPPTp1veIk6ghVN
					PPTp1veIk6ghVNPPTp1veIk6ghVNPPTp1veIk6ghVNPPTp1veIk6ghVNPPTp1veIk6ghVNPPTp1veIk6ghVNPPTp1veIk6ghVNPPTp1veIk6ghVNPPTp1veH
					k5ghVSPHT310dxkjgUWoNbX625dbj/gKYbMUd739dWjygIZBMRgA4MdWjygIZBMRgA4MdWjygIZBMRgA4M]],
				["WingFinger2.L"] = [[
					cZkIgScmLlgA4YcWj2gadwMPh74+cZjUgxgYOVly6Ccji/hFieQkoV6ochjChCiHQJn66icjkagccSL5dp4eddlpgpX1NgTr1fdrlzgwWXPFQ/0ddrlzgwXB
					OXR901drlzgwXROHSU0+drlzgwWZPCRD0edrlzgwW4OhRv0wdrlzgwXXOCSc1AdrlzgwWfO8RK0hdrlzgwWuOrRh0rdrlzgwXZN/Sg1CdrlzgwWmO1RV0mdo
					lxgvWtOrRl0tdElSgeZVMPXL2lchkbgSbqLfdl4CcZkIgScmLlgA4YcZkIgScmLlgA4YcZkIgScmLlgA4Y]],
				["WingFinger3.L"] = [[
					bgkRgbgALpgA4rbej5goheMkiN5QbljIhIk0PYmi6Gb3iphjngSQpQ6UbziuhfnBRto06TbtkqgmfjLwdc4nc7mXg1ZwNCSF0wdUmmg/XCPmN9ypdPmkg+Yk
					OHP9zwdOmjg9ZJNmQv0HdUmmg/XIPgOFyudQmlg+YOObPgzhdNmjg9ZWNcRA0OdTmmg/XUPUOUy3dRmlg+X4OwPDzSdNmjg9ZcNXRJ0SdSmlg+XkPDOpzEdP
					mjg9XuO3O8zPcYl3gnb6LqWT2VbqktgaesLVdL4NbgkRgbgALpgA4rbgkRgbgALpgA4rbgkRgbgALpgA4r]],
				["Vine.L"] = [[
					dWjpgQzkgXip5KdWjegVv2hYiL7rdajKght8ivhL8pdii9gsvJjyfB76dgi/gqyzjZdQ5hddj1gX33chdP01d6kqgh4ZXLcjyZeBkxgm2dXucj08eBkxgmzZ
					YxbJ35eBkxgmxHYFY342eBkxgmxfWSXG3UeBkxgm0TVIWx0MeBkxgm3SVKYcxfeBkxgm4cV3bFxReBkxgm3RXMckzzeBkxgm0cYkby3EeBkxgmxpYhZn4zeA
					kwglxBW/Xv4LdtkZgazPXlZZ3Ndaj1gR1/bdcs2jdWjpgQ3ieHfS1ldWjpgQ2ufbhr2ddWjpgQzkgXip5K]],
				["Humerus.R"] = [[
					gmizfzWwyggA4agmivfwW2x2fE46gmikfqWywCdF58gmicflWeuRbq6pgmidfmWjumb56igmizf1Wtx6iI4vgmjAgDVpxnoN3NgmjCgFVZxQpO2/gmjCgFVZ
					xQpO2/gmjCgFVZxQpO2/gmjCgFVZxQpO2/gmjCgFVZxQpO2/gmjCgFVZxQpO2/gmjCgFVZxQpO2/gmjCgFVZxQpO2/gmjCgFVZxQpO2/gmjCgFVZxQpO2/gm
					jCgFVcxUpD3Bgmi9f+WEyKmD3ogmi2f2Woykhk4QgmizfzWwyggA4agmizfzWwyggA4agmizfzWwyggA4a]],
				["Forearm.R"] = [[
					hojUf/XOzNgA4ChojNgAXqyres4khmjAgCYfxFb95qhji4gFY/vbaC6ehki5gEY6vvaW6VhkjagEXMyriD4WhVj5gQVOxopQ2mhRj9gUU5xJqZ2UhRj9gUU5
					xJqZ2UhRj9gUU5xJqZ2UhRj9gUU5xJqZ2UhRj9gUU5xJqZ2UhRj9gUU5xJqZ2UhRj9gUU5xJqZ2UhRj9gUU5xJqZ2UhRj9gUU5xJqZ2UhRj9gUU5xJqZ2UhS
					j8gTU9xOqN2XhcjvgKV3ycm03HhljbgBW6zMhw33hojUf/XOzNgA4ChojUf/XOzNgA4ChojUf/XOzNgA4C]],
				["WingFinger1.R"] = [[
					iqjygIZBzvgA4MirjngNZ4zQeS4viqjSgabyxpaw50ikjFgldRv3YW6kiljHgjdAwNYv6ciij/gQY4zRiL4biAkzgdVrxdrA2Kh4k6ghVNwxsX1vh4k6ghVN
					wxsX1vh4k6ghVNwxsX1vh4k6ghVNwxsX1vh4k6ghVNwxsX1vh4k6ghVNwxsX1vh4k6ghVNwxsX1vh4k6ghVNwxsX1vh4k6ghVNwxsX1vh4k6ghVNwxsX1vh5
					k5ghVSw5sJ10iPkjgUWoyloG25ilj/gKYbzsiF39iqjygIZBzvgA4MiqjygIZBzvgA4MiqjygIZBzvgA4M]],
				["WingFinger2.R"] = [[
					jnkIgScm0bgA4Yjqj2gadwzxeF4+jnjUgxgYxraO6Cjdi/hFievcXr6ojfjChCiHv3YG6ijdkagccS0HiX4eijlpgpX1ygsV1fiVlzgwWXw7vB0diVlzgwXB
					xpuD01iVlzgwXRx5ts0+iVlzgwWZw+u90eiVlzgwW4xfuR0wiVlzgwXXx+tk1AiVlzgwWfxEu20hiVlzgwWuxVuf0riVlzgwXZyBtg1CiVlzgwWmxLur0miY
					lxgvWtxVub0ti8lSgeZVzxo12ljfkbgSbq0hib4CjnkIgScm0bgA4YjnkIgScm0bgA4YjnkIgScm0bgA4Y]],
				["WingFinger3.R"] = [[
					kgkRgbgA0XgA4rkij5gohezcdz5QkbjIhIk0woZe6GkJiphjngtwWw6UkNiuhfnBuTXM6TkTkqgmfj0Qik4njFmXg1Zwy+t70wismmg/XCwayDypixmkg+Yk
					x5wDzwiymjg9ZJyavR0Hismmg/XIwgx7yuiwmlg+YOxlwgzhizmjg9ZWykvA0Oitmmg/XUwsxsy3ivmlg+X4xQw9zSizmjg9Zcypu30Siumlg+Xkw9xXzEix
					mjg9XuxJxEzPjol3gnb60Wpt2VkWktgaes0ri14NkgkRgbgA0XgA4rkgkRgbgA0XgA4rkgkRgbgA0XgA4r]],
				["Vine.R"] = [[
					iqjpgQzkfpdX5KiqjegVv2eod17rimjKght8dRe18piei9gsvJcOg/76igi/gqyzcniw5hijj1gX33jfix01iGkqgh4Zo1jdyZh/kxgm2doSjd08h/kxgmzZ
					nPk335h/kxgmxHn7nJ42h/kxgmxfpuo63Uh/kxgm0Tq4pP0Mh/kxgm3Sq2nkxfh/kxgm4cqJk7xRh/kxgm3Ro0jczzh/kxgm0cnckO3Eh/kxgmxpnfmZ4ziA
					kwglxBpBoR4LiTkZgazPobmn3Nimj1gR1/kjjU2jiqjpgQ3ih5gu1liqjpgQ2ugleV2diqjpgQzkfpdX5K]],
				Tail1 = [[
					gAhxgbkggAgA/rgAhugbj4gAgA/wgAhpgbifgAgA/5gAhkgbhWgAgA/9gAhlgbhjgAgA/9gAhwgblXfzgB/igAh3gbo0fegA+wgAh4gbpZhHgB+kgAh4gbpZ
					fsgA+lgAh4gbpZfKf/+kgAh4gbpZhBgB+kgAh4gbpZgAgA+lgAh4gbpZe/f/+kgAh4gbpZg2gB+kgAh4gbpZgUgA+lgAh4gbpZe5f/+kgAh4gbpZgngB+kgA
					h4gbpTgmgA+mgAh2gbnnfTgC/EgAhygblSgDgA/jgAhxgbkggAgA/rgAhxgbkggAgA/rgAhxgbkggAgA/r]],
				Tail2 = [[
					gAhehciIgAgA/6gAhehdhhgAgA/9gAhehegHgAgA//gAhfhfe+gAgA/+gAhfhefLgAgA/+f/hahbjkfmgB/yf+hUhVn7e8f7++gEhThTotiNgN+tf/hThTou
					fYf8+xf9hThToueVf2+vgEhThTotiBgM+tgAhThTougAgA+xf8hThTotd/f0+tgDhThTouhrgK+vgBhThTougogE+xf8hThTotdzfz+tgChThTouhNgH+wgC
					hThTolhLgH+yf9hWhXmUenf9/VgAhchbjMgGgA/1gAhehciIgAgA/6gAhehciIgAgA/6gAhehciIgAgA/6]],
				Tail3 = [[
					gAhVifgXgAgA//gAhYigfvgAgA//gAheiheVgAgA/8gAhjiidMgAgA/3gAhiiidZgAgA/4f9hLidiXfZf//5f5gziPnoebfz/BgOgviMomjRgf+of8gviMoo
					fEf3+yf2gviMondgfp+tgMgviMomjAgc+qgAgviNoogAgA+zf0gviMomdAfk+qgKgviMoniggX+tgEgviMoog8gJ+yfygviMomcvfh+ogHgviMonhygR+wgH
					gwiNodhwgQ+zf3g8iVlnd7f0/bgBhPidhrgKgA/8gAhVifgXgAgA//gAhVifgXgAgA//gAhVifgXgAgA//]],
				["UpperLeg.L"] = [[
					fkhVgX64Z3gAwNfkhSgY7fZdftu/fkhMga8gYqfIsgfkhIgc9GYHeuqofkhIgc9AYNeyq9fkhUgW69Z0f7wEfkhcgS2scFhh2KfkhegR2mcKhh2RfkhegR2m
					cKhh2RfkhegR2mcKhh2RfkhegR2mcKhh2RfkhegR2mcKhh2RfkhegR2mcKhh2RfkhegR2mcKhh2RfkhegR2mcKhh2RfkhegR2mcKhh2RfkhegR2mcKhh2Rfk
					hdgR2ncJhh2QfkhagT4sbIg3zufkhWgW6faHgLw8fkhVgX64Z3gAwNfkhVgX64Z3gAwNfkhVgX64Z3gAwN]],
				["LowerLeg.L"] = [[
					fcg0gEymgAgA6CfcgzgCx4gKgM6hfbgyf/wxgYgh7Pfbgxf+wQgcgu7ifbgxf+wUgcgs7gfcgzgDyPgFgA6Sfgg2gQ27e0e62Qfgg3gQ20e3e62Xfgg3gQ20
					e3e62Xfgg3gQ20e3e62Xfgg3gQ20e3e62Xfgg3gQ20e3e62Xfgg3gQ20e3e62Xfgg3gQ20e3e62Xfgg3gQ20e3e62Xfgg3gQ20e3e62Xfgg3gQ20e3e62Xfg
					g3gQ21e2e62Wfeg1gK0zfafY4Sfcg0gFy9f6f45xfcg0gEymgAgA6Cfcg0gEymgAgA6Cfcg0gEymgAgA6C]],
				["Foot.L"] = [[
					fcgSgP/OgAgAm9fcgSgP/OgOf9m9fcgSgP/Ogkf4m9fcgSgP/Nguf2m9fcgSgP/Ogtf2m9fcgSgP/OgEf/m9fcgTgP/HedgVnQfcgUgP/AefgSnufcgUgP/A
					efgSnufcgUgP/AefgSnufcgUgP/AefgSnufcgUgP/AefgSnufcgUgP/AefgSnufcgUgP/AefgSnufcgUgP/AefgSnufcgUgP/AefgSnufcgUgP/AefgSnufc
					gUgP/BefgTnpfcgSgP/NfMgLm9fcgSgP/Of3gCm9fcgSgP/OgAgAm9fcgSgP/OgAgAm9fcgSgP/OgAgAm9]],
				["UpperLeg.R"] = [[
					gchVgX64mJgAwNgchSgY7fmjgTu/gchMga8gnWg4sggchIgc9Gn5hSqogchIgc9AnzhOq9gchUgW69mMgFwEgchcgS2sj7ef2KgchegR2mj2ef2RgchegR2m
					j2ef2RgchegR2mj2ef2RgchegR2mj2ef2RgchegR2mj2ef2RgchegR2mj2ef2RgchegR2mj2ef2RgchegR2mj2ef2RgchegR2mj2ef2RgchegR2mj2ef2Rgc
					hdgR2nj3ef2QgchagT4sk4fJzugchWgW6fl5f1w8gchVgX64mJgAwNgchVgX64mJgAwNgchVgX64mJgAwN]],
				["LowerLeg.R"] = [[
					gkg0gEymgAgA6CgkgzgCx4f2f06hglgyf/wxfoff7Pglgxf+wQfkfS7iglgxf+wUfkfU7ggkgzgDyPf7gA6Sggg2gQ27hMhG2Qggg3gQ20hJhG2Xggg3gQ20
					hJhG2Xggg3gQ20hJhG2Xggg3gQ20hJhG2Xggg3gQ20hJhG2Xggg3gQ20hJhG2Xggg3gQ20hJhG2Xggg3gQ20hJhG2Xggg3gQ20hJhG2Xggg3gQ20hJhG2Xgg
					g3gQ21hKhG2Wgig1gK0zgmgo4Sgkg0gFy9gGgI5xgkg0gEymgAgA6Cgkg0gEymgAgA6Cgkg0gEymgAgA6C]],
				["Foot.R"] = [[
					gkgSgP/OgAgAm9gkgSgP/OfygDm9gkgSgP/OfcgIm9gkgSgP/NfSgKm9gkgSgP/OfTgKm9gkgSgP/Of8gBm9gkgTgP/HhjfrnQgkgUgP/AhhfunugkgUgP/A
					hhfunugkgUgP/AhhfunugkgUgP/AhhfunugkgUgP/AhhfunugkgUgP/AhhfunugkgUgP/AhhfunugkgUgP/AhhfunugkgUgP/AhhfunugkgUgP/Ahhfunugk
					gUgP/BhhftnpgkgSgP/Ng0f1m9gkgSgP/OgJf+m9gkgSgP/OgAgAm9gkgSgP/OgAgAm9gkgSgP/OgAgAm9]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAhxgbDfgAgAufgAhvgbDagbg0uTgAhigbC1hEh2s9gAiFgbDtg8h6uwgAikgbEIgjhMvogAiygbESgAgAv9gAisgbEOfeezv0gAiUgbD9fGeFvOgAhmgbDB
					e+eJtXgAhigbC0fWe3tCgAhmgbC9gAgAtZgAiUgbD6gkhMvPgAisgbERg4h8vygAiygbEWg3h8v7gAikgbEIgjhMvogAiFgbDpgAgAuzgAhigbCzfWe3s+gA
					hvgbDdfCeHuRgAhxgbDifOeeuegAhxgbDff1frufgAhxgbDfgAgAuf]],
				Spine = [[
					gAiUgCE+gAgAxHf/iRgBE4gfgxw6f9iCf/ELhPhvvof9iogDFOhHh0xWf+jJgFFugqhJyLgAjYgGF6gAgAyfgCjRgFF1fWe3yWgDi4gEFge6eLxygDiHgAEa
					ezeQwCgCiDf/ELfQe7vugAiHf/EWgAgAwEf+i4gEFegrhIx0f9jRgGF3hDh2yUf9jYgGF9hDh2ydf+jJgFFugqhJyLgAiogDFKgAgAxZgCiCf+EJfPe7vqgD
					iRgCE7e3eOw4gDiUgCFBfFejxFgBiUgCE+fzfsxHgAiUgCE+gAgAxH]],
				Neck1 = [[
					gAi4fxGDgAgAytf+i1fwF4gigvycf6ikfqEyhThswqf6jMfzGchPhuzGf9juf3HUgwhF0TgAj9f4HqgAgA0vgDj3f4HhfQe70igGjdf1G7eyeRzvgGipfsFI
					eueUxNgDikfqEyfNe9wwgAipfsFEgAgAxQf9jdf1G4gwhFzwf6j3f4HjhNhw0hf6j9f5HthNhw0sf9juf3HUgwhF0TgAjMfyGYgAgAzJgDikfqEvfNe9wrgG
					i1fwF7eweSyagFi4fxGGfAenyrgBi4fxGDfyftytgAi4fxGDgAgAyt]],
				Neck2 = [[
					gAjUfnGLgAgAy3f9jRfmF8gigvyhf5i+fdEfhRhtwLf5jpfqGrhQhtzbf8kMfxH6gyhE1AgAkbf0IZgAgA1lgEkUfzIMfOe81UgHj6fuHWeweT0QgHjEfgE8
					eveTw7gEi/fdEhfOe8wUgAjEffE4gAgAw9f8j6fuHTgyhE0Sf5kUfzIOhRht1Sf5kbf0IchRht1if8kMfxH6gyhE1AgAjpfqGogAgAzegEi+fcEdfOe8wNgH
					jRfmF/eweSyfgGjUfoGNe/eny1gBjUfnGLfyfty3gAjUfnGLgAgAy3]],
				Neck3 = [[
					gAjrfgGLgAgAy3f9jofeF4gigvycf4jUfREIhOhvvif4kBfkGzhRhtzmf7kkfuIZgzhC1jgAkzfyJBgAgA2QgFktfwIwfMe+18gIkSfpHpeueU0ogIjbfVEq
					exeRwdgFjVfREKfQe7vsgAjbfUEmgAgAwgf7kSfpHngzhD0qf5ktfwIyhThr16f5kzfyJFhUhr2Nf7kkfuIZgzhC1jgAkBfkGwgAgAzogFjUfQEFfQe7vkgI
					jpfeF7eweSyagGjrfgGNe/eny1gBjrfgGLfyfty3gAjrfgGLgAgAy3]],
				Head = [[
					gAkDfYACgAgAg+f8kAfWAFecg/ggf2jpfEAdcYirdVf3kZfeAXcZiHiKf7k9fsAcdzhIkhgAlMfxAegAgAlYgFlFfvAhiNe6lDgIkqflAejmeDjfgKjwfJAX
					jpddeZgGjqfEAQiQeXdVgAjwfJAFgAgAeIf7kqflATdxhOjWf4lFfvAscdhwlLf4lMfxAwcdhtllf7k9fsAcdzhIkhgAkZfdAFgAgAh7gGjpfDARiQeWdKgJ
					kAfWAUjpdugtgHkDfZAOi9eMhIgCkDfYADgpfng+gAkDfYACgAgAg+]],
				Jaw = [[
					gAkOe0/8gAgAhwf5kKex+8hxfen6fvjree8xkVeutPfwkme7+fkIfQouf3lQfK/OiefsmfgAlhfQ/fgAgAlqgJlZfO/VdkgSl9gQk6fD+1b9gnndgRj1ek9N
					buhKsRgLjsee89dVgytUgAj1ej9ZgAgAsnf2k7fD+9igfonofxlZfP/Nj8fklyfxlhfS/Sj6fnlYf3lQfK/OiefsmfgAkme5+sgAgApCgLjred84dVgztdgQ
					kKey+Cb0g6qHgNkOe0+tcpg3oQgDkOe0/tfUgSkHgAkOe0/8gAgAhw]],
				Crest = [[
					gAljfZZygAgA/YfzlgfUX7gihx+5fflEexVHhokN9vfil2fncUhaj8/gfumZgCfdgxiX/5gAmogMeMgAgA/8gRmhgIbxfmdl/ngdmHf3bDfEcB/VghlNe9Yn
					eLb9+zgVlHewYUevdh+7gAlPe5XCgAgA+tfumIf1aFghif/VfkmggKcvgwj5/kflmlgPfvhBjz/vfumZgCfdgxiX/5gAl5fkavgAgA/jgVlGeuUJfEdY9lgf
					ldfXYUexb5+wgZlifcbBezcw/agFljfZaYfwfT/fgAljfZZygAgA/Y]],
				["Humerus.L"] = [[
					faizfzZ8OShY55fYiwf0V8QvcG59fVigfxTXSObT5hfVjHf6cpPZkf6wfXjpf8fxOFm85kfaj4f6ZyO9eO6Sfejyf2UxRyVh4MfgjYfyWLPWYs4afgikfpa3
					MOk54Hfeigfpc6Mwog34failfuXcO3fw5nfXjYf6TjTiW65GfVjxf/V9SxZ96pfVj4f/dxPOjy63fXjpf8fxOFm85kfajIf0YsO5e76AfeiffpSbQ0W+29fg
					iwftVXPGZQ4Dffizfva8Mlix4wfbizfyZ9N+hW5sfaizfzZ8OShY55]],
				["Forearm.L"] = [[
					eWjGgKbiNMia5XekjfgOX7O8d45verjYgJTqRabV5OeSjKgabSPXin6yeUjYgXfONzlr5qeakVgVbQNqfO5xe9kwgRWPPjXV4HevkNgGWdOkYs3+eXiof3Zw
					MGi34FeXiTf9ccMWnP36eajFgDY9Nrg45Pe6kWgXVLRWYo5PerkkghWOR8Z56UeSj3ggcaPRh769eUjYgXfONzlr5qeajmgMaMNpf/5je9jgf3T5OxZA3Cev
					jmf+VpOVZS3oeWi9f/ZzMmgv4qeWjGgIZZNxgG5ceWjGgKbiNMia5X]],
				["WingFinger1.L"] = [[
					dQjQgeeGMvjA5SdnkCgkb6NZgE5sd+kPgeV8QKb15kdQjWg5bJPqgm7EdQjMgxfIOKjw6RdXkogqdwM9fz5meQlmgmZrNIZn4Nd9lAgXYrNQZY39dPi2gCZ4
					MQg14ZdQiKgNcdMelS4hdXjcgVbdNBhh5SeQlMgxYzPAas5ld+lVhAYhQpaR6cdQkBg/cRPpf77PdQjMgxfIOKjw6RdXj7ghcsM9gm5feQkagBXTMlbh3dd9
					kagLX3NDaB3tdRjRgNZ7M2eu42dUjegbZcOCeE5kdQjQgeeGMvjA5S]],
				["WingFinger2.L"] = [[
					cRjPgwhCMuiE5bcqkQg3hXMnhw5WdPk4gybKORdV6CcXjlhVd9PRfZ7LcUjGhKgUOdhG6ucZkwg9grMve25gdbmJg1euLMbn32dKlmgkdrLObb3xcRjHgNc0
					LzgB4mcQiIgcdzMgiv5HcZjogmeYMugl5dddlwhHeANHcT5edPl6hcdxOnbl6ZcXkOhdfFPTes7PcUjGhKgUOdhG6ucZkFgyfnMtfp5gdbk/gJcWK3dt3ndK
					lCgWc4LFcI3rcVjogbc1MSd244caj4guawN5bb5bcRjPgwhCMuiE5b]],
				["WingFinger3.L"] = [[
					bZjHg/jkNOhB5obykIhHm4NTj/4tcclMhGg0N1fU6TbkjthvgaPbeF7SbejDhhgxO/d/7AbhkxhNjQNFdz5fcjmXg9kEKreS3bcTl4gtjCKneG3hbYjQgXfa
					L5fD42bXiIgqefMufo5ebhjrg1g8M9fh5rcol9hYjkMpei5LccmJh0jbN/dh6FbkkTh3hjPhdZ7QbejDhhgxO/d/7AbhkHhCiMNAel5mcjlOgOhuKngb3tcT
					lTgdiPKke03nbej2gnfbMRc14+bpkQhAbcOIYV4/bZjHg/jkNOhB5o]],
				["Vine.L"] = [[
					dTjGgk1Dktlw26dnj4gqvsgZeu72d7kGgmuhbFWZ6YdVjMg+3eidcJ1PdXjDg25qnvj1xDdZkdgv2kiqj42LeLlcgrxBboaG6Fd5k2gcxtYdYJ4TdSisgJ2u
					fhfQ2gdViDgU3mmplOz4dZjTgc0ejAjn4IeMlDg3v+dwY+6ud7lLhGxEcDV94zdVj2hE4WincQ0QdXjDg25qnvj1xDdZjxgm1oi0jw3GeLkRgIuVbEak7od5
					kRgRw4YMYZ45dTjHgT3oekdy1ZdVjUgi5wgwgSy9dTjGgk1Dktlw26]],
				["Humerus.R"] = [[
					gmizfzZ8xueo55gjiwfwWMwukd5DggiffoUSxMl+3jggjIfwcC0AcF4Vgijqf1fFz9ZS4Egmj4f6ZyxDhy6Sgpjyf8UEsSpW5WgrjXf8VatXly6cgrilfzbX
					wYau6kgpigfwdcxOXe5cgmilfuXcxJgQ5ngijYfzUSubqN39ggjyf1Wrwhnq4mggj5f1dD0Jc64egijqf1fFz9ZS4EgmjIf0YsxHhF6AgpiffvRntKoF4Cgr
					iwf3UitjlV6Egqizf3bRwqct6sgnizf0Z/xbeh6GgmizfzZ8xueo55]],
				["Forearm.R"] = [[
					hqjGgKbiy0dm5XhajfgEYFygij4vhRjWfzUlx9l63JhpjKf+a80BeH4WhpjZgGeo0Pal4IhmkVgVbQyWgy5xhGkvgcVsugnr5chVkMgcVsuLl06HhuiqgUZ/
					wfcm6hhsiUgOc4xoYs5fhmjFgDY9yVfI5PhDkXgMVwwooW36hRkmgLW8xSnr4Khpj6gDb90Fe94ihpjZgGeo0Pal4IhmjmgMaMyXgB5jhGjigDTNvMmM4ThV
					jngUU0uXlW5whti9gWZ7wpem6mhqjGgNZaxpfw52hqjGgKbiy0dm5X]],
				["WingFinger1.R"] = [[
					iwjQgeeGzRdA5SiZkCgTb70CgK4miDkLf7WzzOlH3TixjWgKbEzxgI4qiwjOgUetz7ch4vipkogqdwzDgN5mhwlkg4ZUw5lq5uiCk+g5X/velb6Riwi5gxZ2
					wTen6yiwiNgpcvxcap6FipjcgVbdy/ef5ShwlNgeZLzAmA4FiDlZgeZKynnA4HixkFgRcGzwg942iwjOgUetz7ch4vipj7ghcszDfa5fhwkcgTWzxXj947iC
					kbguXHvpk55/iujRgyZ0wYgo6xisjegjZaxYhy5+iwjQgeeGzRdA5S]],
				["WingFinger2.R"] = [[
					jvjPgwhCzSd85bjYkPgfhR0zeK4Ni2kzgDbz1Fi73gjvjmgWeA0Mg94ujwjKgjgGzrfE5Njnkwg9grzRhK5gijmGhQehy0kF5gixlkhUdPxekE6WjpjLhLco
					wwfz7DjsiMhDd4xYdU6ojnjogmeYzSfb5dillxgseP05j+31i2l/gteK0slA30jvkUgefC0Ihz4yjwjKgjgGzrfE5NjnkFgyfnzTgX5gijlCgjcAzIiM5Pix
					lChGcWxmjf6PjmjohNcnw8hz63jkj4g5apxhkd52jvjPgwhCzSd85b]],
				["WingFinger3.R"] = [[
					knjHg/jkyye/5okRkHgomp0Ebn3njtlFgIhK1egN3skojughgn0Dh842kpjHgxg0zLiJ5gkfkxhNjQy7iN5fjYmThhkFzUh35Gjkl0hri5yEiI6JkcjVhkfF
					wqhI7RkiiNhaeUxIge69kfjrg1g8zDgf5rjdl/g0jm1XhS3gjtmPg2jg1WiW3dkokbgqhpz8ix4zkpjHgxg0zLiJ5gkfkHhCiMzAhb5mjYlSgyhkzaf75Yjk
					lUhbiByIhh6PkZj2hlfGw7jG68kVkQhNbRxSnk5ZknjHg/jkyye/5o]],
				["Vine.R"] = [[
					itjGgk1DbTaQ26iaj4gZvvhLgY70iHkCgCvuoKnP5oiujNgQ3ygdgy1XirjGga5TZ3aNxqinkdgv2kdWcI2Lh0lag+wgiHnE6ZiFk0g/wkkKp+5Jiriwg32b
					dvj+2WipiGgw3/X9c5zUinjTgc0edAcZ4Ih1lEgjwekgl06aiHlOgiyMnZoB38iuj7gW4qgbgz0XirjGga5TZ3aNxqinjxgm1odMcQ3Gh0kTgbtzizm175iF
					kRg0vtkfp05sirjHg43QfIkw1biqjUgp5we0gVy8itjGgk1DbTaQ26]],
				Tail1 = [[
					gAhxgbkggAgA/rgAhvgbkRjDfj/jgAhigbiylte5/VgAiFgbkzjTfk/dgAikgblyfBgG/cgAiygbmGcIgW/KgAisgbl9cbgW/OgAiUgblWfGgH/hgAhmgbjS
					hkfu/ygAhigbi5h0fq/zgAhmgbjSgAgA/0gAiUgblWeLgN/fgAisgbl/ebgK/YgAiygbmJg6f7/YgAikgblwjlfp/QgAiFgbkzj3fg/YgAhigbi1g+f0/2gA
					hvgbkRcugf/igAhxgbkdbVgr/UgAhxgbkgewgL/pgAhxgbkggAgA/r]],
				Tail2 = [[
					gAhehciIgAgA/6gMhdhbh5kYfr/ogXhVhZgcpge3+hgNhxhaibl+fr/Vf8iMhajceSgD/wfwiZhYjsYogH+6fyiUhYjjZCgJ/Bf8h9hbi/emgE/0gGhYhdg6
					kafi/qgHhWhdghlofW/egAhYhdg7hqf1/7f5h9hbi+cSgJ/of6iUhajlakgH/UgEiZhajyeQgC/ugOiNhZjakVf5/ggQhxhaianXfl/CgEhWhegdkXff/rfz
					hdhbh6dLgN/zfthehZiFZBge/Jf7hehciIdqgK/1gAhehciIgAgA/6]],
				Tail3 = [[
					gAhVifgXgAgA//gfhVicgJkjf7/qg9hSiRezspfN9WgmhmiYgqpggA+if1h+ichqfQf//8fSiKiSh7WPfm+ZfViFiUhwVSfn+Ff2hxidhNcgf8/xgZhUiefK
					l2fu/cgfhTicezpUfb+kgHhUigfKkqfx/ofphxibhNcCf8/ufjiFiYhzXWfs+vf8iJibh/apfy/eggh+iYhqjXgG/xguhmiVgqpygA+dgWhUieeuoNff+5fn
					hVidgJfQgB/+fRhViWgWX4gG+8fxhViegXclgC/zgAhVifgXgAgA//]],
				["UpperLeg.L"] = [[
					fkhVgX65Z3gAwNfjhTgZ7haGfCvLfjhFgd9YZHciqBfjhoga7AbYegwdfjiIgX3jczgx1ZfkiXgU2+b9hp11fkiRgS2fbAif2Dflh4gR4XZhiYziflhJgV8Q
					XdgxsUfkhFgX83Xhfxq4fkhJgZ8uYfe2r2fjh4gX5kbtf1ywfjiQgY3xdbgQ1QfjiWgX3uddgQ1TfjiIgX3jczgx1ZfkhogW6iaFgKw2fkhFgX87Xdfvqqfl
					hSgT6uYZhgvxfkhVgU6ZY3hZwjfkhVgW6yZpgTwSfkhVgX64Z3gAwN]],
				["LowerLeg.L"] = [[
					fcg0gEymgAgA6CfbgzgDyag/f06JfWgxf/wbi3ga7TfbhHgI0BhyfA43fghigT3tfveK1ZfghwgR3OeyfA18fghqgQ23dwf12RffhTgI0Ddogn4zfeguf6uG
					eig18qfdguf5t6fags8yfagwf9vlgngg77fdhTgL1Xgie23yfghqgT32gZdp1MfghwgT3zgadp1QfghigT3tfveK1ZfchHgFy/f6f55vfdguf5tyfags82ff
					gygAwweNg27LfegzgCxtecgq6lfdgzgDyafqgJ6Kfcg0gEymgAgA6C]],
				["Foot.L"] = [[
					fcgSgP/OgAgAm9fcgSgP/Ngvf1m9fcgSgP/Hiofam7fcglgP+5hHftoNfcg/gP+YfBgSp+fchOgP97ehgcrMfchIgP+Dd4gqqvfcgxgP+qeLgio6fcgSgP/N
					fIgMm9fcgSgP/Of0gDm9fcgSgP/Ngxf1m9fcgxgP+uf/gAo7fchHgP+KfdgHqqfchNgP9/fhgErJfcg/gP+YfBgSp+fcglgP+6f4gCoOfcgSgP/Of0gDm9fc
					gSgP/Ne4gQm9fcgSgP/Ne/gOm9fcgSgP/OfygDm9fcgSgP/OgAgAm9]],
				["UpperLeg.R"] = [[
					gchVgX65mJgAwNgchSgV7Gm8fgvggbhFgW8uo7fgq4gbhpgS53nLeJxTgciJgS2ilDdi1/gciXgU2+kDeX11gdiQgW3gjKfP1dgdh3gZ5vjwgwymgdhKgd9A
					mbjCrfgdhGgc9RnPirqWgchJgZ8unhhKr2gch4gT4tl/ePzVgbiRgQ2Jlkc/2NgbiXgQ2Hlic/2PgciJgS2ilDdi1/gchogW6il7f2w2gdhFgc9UnTivqJgd
					hTgb7ulMh8u+gdhVga7PlHhXv6gchVgX6+l7gTwJgchVgX64mJgAwN]],
				["LowerLeg.R"] = [[
					gkg0gEymgAgA6CgjgygBxagrfk60gigtf4tKhbfR9HghhGgDx/iAfP6XgghigQ26iSgM2NgghwgR3OhOhA18gghqgT3pgPh21egjhTgM1sezhm3bgpgygBxD
					dVf367gogwf+v5d+fj7rgmgwf9vlfZfg77ghhTgJ0Whsf04ogghqgQ2li3fq2egghxgP2ji1fq2hgghigQ26iSgM2NgkhHgFy/gGgH5vgogwf+v0d9fh7ugn
					g0gFzFd7gp5lgmg0gGzfedgr5Ugkg0gEyyfrgJ55gkg0gEymgAgA6C]],
				["Foot.R"] = [[
					gkgSgP/OgAgAm9gkgSgP/OgYf7m9gkgSgP/Ng4f0m9gkglgP+4hZfooNgkhAgP+TiJfWqBgkhOgP97hffkrMgkhHgP+Jg7fwqqgkgxgP+tfngHo7gkgSgP/I
					dqghm8gkgSgP/KeDgcm8gkgSgP/NfPgLm9gkgxgP+shZfmo7gkhIgP+AiffOqygjhOgP90iefOrTgkhAgP+TiJfWqBgkglgP+6gIf+oOgkgSgP/KeBgcm8gk
					gSgP/MeigVm9gkgSgP/NfBgOm9gkgSgP/OfygDm9gkgSgP/OgAgAm9]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhxgbDfgAgAufgAhxgqEpgAgAwkgAhxgzFdgAgAx2gAhxgwFPgCgFxhgAhxgsE0f2fnw2gAhxgmEbfMeJwFgAhxgjEIfTedvmgAhxgiEBf3ftvfgAhxggD0
					gGgNvIgAhwgaC1gFgJtIgAhugSBVgTgZpCgAhrgJAQgsgpjxgAhogBAEhIgwewgAhmf7AXhcgxblgAhmf7AchegxbIgAhnf9AQhWgxchgAhnf9AOhUgxcygA
					hmf7AZhdgxbZgAhmf6Adhfgxa+gAhmf6Adhfgxa+gAhmf6Adhfgxa+gAhmf6Adhfgxa+gAhmf6Adhfgxa+]],
				Spine = [[
					gAiUgCE+gAgAxHgAiXgWGUgAgAzEgAiZgjHQgAgA0QgAiYgfHAgCgEz8gBiXgYGhfzfozUgDiWgRGEfBePymgDiWgNFufJeiyJgBiVgLFmf2fuyDgAiVgIFX
					gHgMxtgAiQf9EMgGgIv0f/iFftCUgVgXr4f/h1ffAwgwglmvf+hlfWAGhMgphwf9hbfSAGhggoekf9hZfRAHhjgoeHf+hefTAEhagpfhf+hffTADhYgpfyf9
					hafSAGhhgoeYf9hZfRAIhkgod9f9hZfRAIhkgod9f9hZfRAIhkgod9f9hZfRAIhkgod9f9hZfRAIhkgod9]],
				Neck1 = [[
					gAi4fxGDgAgAytgAi9gKIBgAgA1LgAjAgbJagAgA2pgAi/gWJCgDgE2RgBi+gOIUfxfp1ggFi8gFHne4eU0mgFi7f/HIfDem0CgBi6f9G+f0fvz6f/i5f4Go
					gIgMzegAiyfpFZgDgExwf/igfRDggLgJuif+iFe7BwgZgKqZf8hpeuAqgogGmXf8hXeqAPgxgAjuf8hVeqANgyf/jWf8hderAWgugCkgf8heerAYgtgCkvf8
					hWeqAOgxf/jkf8hUeqAMgyf+jOf8hUeqAMgyf+jOf8hUeqAMgyf+jOf8hUeqAMgyf+jOf8hUeqAMgyf+jO]],
				Neck2 = [[
					gAjUfnGLgAgAy3gAjbgGIsgAgA15gAjegbKggAgA3rgAjdgVKAgDgE3OgBjbgLJEfwfp2TgGjZgAIJe2eW1NgFjYf4HhfBen0ggBjXf2HVf0fv0Wf/jWfxG5
					gIgMz0gAjOfdFtgAgAyNf/i5e/EEf/f7vkf9iYejCfgAfzsVf8h1eTBXgAfnpLf8heeNA0f/fdnGf8hbeNAwf+fcmzf8hlePA+f/fgnuf8hnePBBgAfhn5f8
					hdeNAzf/fdm+f8haeNAvf+fbmsf8haeNAvf+fbmsf8haeNAvf+fbmsf8haeNAvf+fbmsf8haeNAvf+fbms]],
				Neck3 = [[
					gAjrfgGLgAgAy3gAjzgFJPgAgA2egAj2gdLegAgA4igAj2gXK3gDgE4AgBj0gKJtfwfq27gHjyf9Ike0eX1qgGjwf0HyfAeo01gBjwfxHkf0fv0pf/jufrHD
					gIgL0AgAjlfVF6f9f8yff/jOeyEjf0fuwaf+ipeSDRfofcuCf9iCd+CRfZfJruf9hpd3BufNe7qNf9hld2BpfLe5p/f9hwd5B4fRe/qqf9hzd5B6fSfAqyf9
					hnd3BsfMe6qHf9hkd2BofKe5p6f9hkd2BofKe5p6f9hkd2BofKe5p6f9hkd2BofKe5p6f9hkd2BofKe5p6]],
				Head = [[
					gAkDfYACgAgAg+gAkMgFBCgAgAn/gAkPghCfgAgAsUgAkOgaCCf7gDrMgCkNgLBTgefso8gIkLf7A1iVeWmlgHkJfwAfiAegk3gBkIftAUgYftkWf/kGfmAL
					fvgNjIgAj8fMADfUfthCf/jjemAIdpfDfGf+i9eDAgbceZdPf+iTdsBIZVd9bbf+h4djBrX9dxaPf+h0djBwXxdvaEf+iAdlBgYXd0amf+iCdmBdYfd1asf+
					h2djBtX4dwaKf+hzdiByXtdvaAf+hzdiByXtdvaAf+hzdiByXtdvaAf+hzdiByXtdvaAf+hzdiByXtdvaA]],
				Jaw = [[
					gAkOe0/8gAgAhwgAkmfo//gAgAfugAkwgO/9gAgAebgAkugE/9gGf/exgDkpfw/+fegLfcgOkifd/3dZhJgBgMkcfQ/4dyhJgjgCkbfM/+flgPgyf+kXfD/+
					gTf1hJgAkIeo/3gqgYipgAjqeB/biNhRlZgAjAdc+ZkLidovgBiSdG85mAjlrzgCh0c97snJkUtsgChvc97fnUkbt8gCh9c/8Em0kGtIgCh/dA8LmtkCs+gC
					hyc97mnOkXtzgChuc87bnYkduCgChuc87bnYkduCgChuc87bnYkduCgChuc87bnYkduCgChuc87bnYkduC]],
				Crest = [[
					gAljfZZygAgA/YgAljgvg2gAgA/+gAlWhilZgAgA/if/lahVkNgCgG/tgElgg6h2f0fe/7gUljgefce6dY/3gSllgJdse/du/zgDlmgCdJfzfk/3f+lmf0b7
					gJgU/uf7lcfOZofjgn/VfxlCecXMegiD+pflkXdsUzdOj+9kfajmdKSncGlz8MfUjEc7RQbam+7IfTi/c5REbUnJ69fVjOc/Rpbnmo7dfWjRdARxbrmh7jfT
					jCc6RLbYnD7DfSi9c4Q/bSnN66fSi9c4Q/bSnN66fSi9c4Q/bSnN66fSi9c4Q/bSnN66fSi9c4Q/bSnN66]],
				["Humerus.L"] = [[
					faizfzWwNggA4afai4gLWFN4bN38fai7gbVgOnYW3ffai6gXVuOYZM3rfbi5gOVsN9aA3kfgi4gBVENXZl2sffi2f8VYNMbK3Ffbi2f+WQNedQ4Bfai1f7Wv
					Nmey4bfaiufsV3Nggc4CfZidfVT4Nwi33IfYiEfBRXOblX1tfXhre1PJPanj0KfWhbexNzQMo1zFfWhZewNnQUpAy6fXhgeyOMP9odzafXhheyOTP4oWzgfW
					haexNuQPo5zAfWhYewNjQXpEy3fWhYewNjQXpEy3fWhYewNjQXpEy3fWhYewNjQXpEy3fWhYewNjQXpEy3]],
				["Forearm.L"] = [[
					eYjUf/XOMzgA4CeijogYWcNJbO3heqjygqVyN2YZ3DenjvglWBNoZO3PemjsgZWBNNaD3HesjtgIVYMoZp2PenjngDVuMdbO2peejfgIWqMwdR3neajZgHXL
					M4ey4CeYjQf1WbMwgl3reWi/faUsM/jU23eVile/SgNsmQ1meTiLeuQjOzo00ReTh5enPXPtqUzWeTh3emPNP2qizNeTh+eoPuPbp5zoeTiAepP0PWpxzteT
					h4emPTPxqazSeTh2elPJP5qmzKeTh2elPJP5qmzKeTh2elPJP5qmzKeTh2elPJP5qmzKeTh2elPJP5qmzK]],
				["WingFinger1.L"] = [[
					dWjygIZBMRgA4MdpkVghYJMYbP3hd6kog1XbM8Ya2/d0kigwXrMxZP3MdxkdgiXsMYaF3Hd4khgLXCLxZw2PdvkWgGXbLrbU2rdgkGgQYaMFdT3sdZj7gRY9
					MSey4KdWjvf8YVMMgv35dTjbfdW4Mcj43SdQi+e+VBNTnT2WdOiierTXOpqR1YdNiPeiSWPwr/0tdNiNehSNP7sO0ndNiVekSpParg06dNiWelSvPUrW0+dN
					iOeiSSP1sG0qdNiMehSKP/sU0ldNiMehSKP/sU0ldNiMehSKP/sU0ldNiMehSKP/sU0ldNiMehSKP/sU0l]],
				["WingFinger2.L"] = [[
					cZkIgScmLlgA4Ycyk4gpbnLObV3ddKlUg+axLfYg2xdClMg5bELaZV3Bc9lFgpbHLGaN2/dGlLgOabKbaA2Jc4k7gJa4Kfbh2qcmkkgXb7LHdY3vcdkUgach
					Lfez4RcZkFgEcELgg94NcUjsfja9L+kj4AcQjMfEZhNNof3kcOitexYNPCr13IcNibeqXYQgtt20cNiYepXRQut92xcNigesXoQDtL26cNiiesXsP7tB28cN
					iaeqXVQmt02zcNiXepXOQzuD2wcNiXepXOQzuD2wcNiXepXOQzuD2wcNiXepXOQzuD2wcNiXepXOQzuD2w]],
				["WingFinger3.L"] = [[
					bgkRgbgALpgA4rb9lPgwfAK0bc3gcZlzhGeGKzYq2tcQlohAebKzZd2/cJlfgvefKkaX3BcTlogQdxJ1aR2OcElTgMeQKDbv2zbvk2gefVK6de36blkggjf7
					Lce04ebgkNgNfoLnhM4nbajwfse6MclP4vbXjMfRd7OSpq4vbXirfEdAQ1tP4rbXiZfAccSzvK4obXiWfAcXTGva4nbXiefBcmSMuo4pbXigfBcqSBud4pbX
					iYfAcaS7vR4nbXiWfAcVTNvg4nbXiWfAcVTNvg4nbXiWfAcVTNvg4nbXiWfAcVTNvg4nbXiWfAcVTNvg4n]],
				["Vine.L"] = [[
					dWjpgQzkfvh35PdmkLgnynb5ed5pd1keg6yNZBa241dvkYg1zQYfaa3xdskUgo1PYfbL2MdzkYgR2aX1cx1EdrkNgM2RZ/e52Idfj9gX05c+gJ4CdZjxgYy3
					eagf5xdWjmgEwneYgX7SdTjTfnuhefgT8edRi6fJskfKgb9adQige2qdgdgt+OdPiPeuoehrhA+ydPiNetndiKhT/AdPiUewnkh3hd+/dQiVexnYhhhW/EdP
					iOeumlhhhJ/QdPiMetmohihD/PdPiMetmzhnhE/MdPiMetmzhrhG/MdPiMetmvhshH/NdPiMetmuhshH/N]],
				["Humerus.R"] = [[
					gmizfzWwyggA4agmi4gLWFyIkz38gmi7gbVgxZnq3fgmi6gXVvxum53lgni5gQVoxeln4Dgri2gLUnvzkr48gqi2gEVFwXjg4/gni1f/WOyEih4Zgli1f6Wv
					ywhX4LgliufrV4ywfp32gkicfTUAzCdP2kgjiCe+R0zFae0rgihmeyQEyqXyyzghhUeuPFyIWDxlghhReuO9yCVzxagihZevPXyTWkx8gihbevPcyWWtyDgh
					hTeuPCyGV8xgghhQeuO6yAVuxWghhQeuO6yAVuxWghhQeuO6yAVuxWghhQeuO6yAVuxWghhQeuO6yAVuxW]],
				["Forearm.R"] = [[
					hojUf/XOzNgA4ChejogYWcy3ky3hhWjygqVyyKnn3DhYjvgkWCyem33JhcjrgeV8yOlm3ohcjrgeU8wlkq4lhgjmgWVcxIjf4ohjjfgMWoyyig4AhmjZgEXL
					zdhX3xhnjQfzWczffg3fhoi8fUU0zzcx2Rhoide2S8zwZj0ghph7ekRdzKWcyzhphlefQpyeUexshphiefQiyXUNxihphregQ4ytVEyBhphtegQ8yxVOyHhp
					hkefQmybUXxohphhefQgyUUGxfhphhefQgyUUGxfhphhefQgyUUGxfhphhefQgyUUGxfhphhefQgyUUGxf]],
				["WingFinger1.R"] = [[
					iqjygIZBzvgA4MiXkVghYJzokx3hiGkog1XbzEnm2/iMkjgvXszWm13GiRkcgpXozDlm3piPkdgvWnxbkw4riXkUgmXKx5jk4vihkGgWYYzdih4Gimj7gMY9
					0DhV34ipjvf5YW0EfU3tisjXfTW/0UcJ2riuixevVb0GYX1MiwiIebUNzKUzzyixhteWTjyMSly5ixhqeVTdyCSRyxixh1eXTuygTPzKixh3eXTyymTbzPix
					hseWTgyISdy1ixhoeVTbx+SLyuixhoeVTbx+SLyuixhoeVTbx+SLyuixhoeVTbx+SLyuixhoeVTbx+SLyu]],
				["WingFinger2.R"] = [[
					jnkIgScm0bgA4YjOk4gpbn0ykr3di2lUg+ax0hng2xi+lMg3bE0tmu26jFlDgzbD0Ulk3kjBlFg+aBytk84wjMk4g0anzDju42jakkggb60aig4KjikUgUch
					02hR3+jnkEf/cE0wfE4AjsjnfVbD0xbW3Xjwi6euZ30EW72XjyiKebY7ygS61cjyhseZYbxDQg02jyhoeZYXw0QL0xjyh1eZYkxgRM1Bjyh4eZYnxpRZ1Ejy
					hqeZYZw8QX00jyhneZYVwuQD0vjyhneZYVwuQD0vjyhneZYVwuQD0vjyhneZYVwuQD0vjyhneZYVwuQD0v]],
				["WingFinger3.R"] = [[
					kgkRgbgA0XgA4rkDlPgwfA1Mkk3gjnlzhGeG1NnW2tjwlpg+eb1Uml24j4ldg8eb01lf3mjylghMdZzPlG46j/lPhCeAzbj35CkRk1gpfU0nif4Vkbkggcf7
					05hN4MkgkNgHfp0pez4akmjpfce+0Rai4Hkpi1e2eKy4Vh3ikpiAepdhwbRL29kohgerdLuVOt2mkohcesdIuAOY2ikphpeqdRvAPa2tkphseqdTvLPn2vko
					heesdKuNOk2kkohaetdHt5OR2hkohaetdHt5OR2hkohaetdHt5OR2hkohaetdHt5OR2hkohaetdHt5OR2h]],
				["Vine.R"] = [[
					iqjpgQzkgReJ5PiakLgnynkHhj5piLkeg6yNm/lK41iQkZg0zSnqli3uiVkSgv1Jm1lS2aiSkTg118lJlu1+iZkKgt2FjdjS2qiij8gd05ihgP4FinjxgUy3
					h+fR5wiqjmgBwnh5fd7RisjQfduhiLe/8aiuite6skhsd69TiviGenqWgJcq+FivhteioPenby+livhqehnKeJbb+yivh1ejnUerbi+yivh3ejnKfGbs+3iv
					hseimXe8bo/BivhpehmZe1bp/Bivhpehmkevbo++ivhpehmjeqbm++ivhpehmfeqbl++ivhpehmeeqbl+/]],
				Tail1 = [[
					gAhxgbkggAgA/rgAhxgqm1gAgA/QgAhxgzoUgAgA+5gAhxgwn7gFgA+/gAhxgsnKflgC/LgAhxgmmTd/gL/TgAhxgjlweUgL/bgAhxgilnfrgC/fgAhxgglN
					gOf+/kgAhwgajPgBgA/1gAhugSfdgAgA//gAhrgJa2gAgA/kgAhogBWogAgA+lgAhmf7UCgAgA9qgAhmf7TrgAgA9hgAhnf9UzgAgA99gAhnf9VBgAgA+CgA
					hmf7T4gAgA9mgAhmf6TjgAgA9dgAhmf6TjgAgA9dgAhmf6TjgAgA9dgAhmf6TjgAgA9dgAhmf6TjgAgA9d]],
				Tail2 = [[
					gAhehciIgAgA/6gAhVhnkfgAgA/rgAhPhtl/gAgA/bgAhQhslmgFgA/ff+hThok0flgA/nf4hXhkj+d/gB/rf5hZhijZeTgD/xf/hahhjRfrgB/0gBhbhgi2
					gOf//3gAhihchGf4gB/+gAhwhVd5figI/6gAiAhJaDfJgY/agAiOg4Whe3gv+hgAiVgsUXevhB9wgAiWgqUDeuhE9ogAiTgwU/exg89/gAiTgxVLeyg6+EgA
					iWgrUOevhC9sgAiXgpT8euhF9lgAiXgpT8euhF9lgAiXgpT8euhF9lgAiXgpT8euhF9lgAiXgpT8euhF9l]],
				Tail3 = [[
					gAhVifgXgAgA//gAhCioiugAgA/4gAg2iskPgAgA/tgBg5irj1gFgA/wf8g/ipjDflf+/1fvhGiliNd/f6/2fyhLijhoeTf9/5f9hMijhffrf//9gChPiihF
					gOgA/+gAheiffkfvgB//f+h5iYc8fDgM/1f8iZiHZ2eQgr/Vf6i0hwXBdqhW+lf5jDhdVSdYh499f5jFhaVCdWh993f6i/hjVyddhu+Kf6i9hlV8dehr+Nf5
					jEhcVLdXh697f5jFhZU9dVh/91f5jFhZU9dVh/91f5jFhZU9dVh/91f5jFhZU9dVh/91f5jFhZU9dVh/91]],
				["UpperLeg.L"] = [[
					fkhVgX64Z3gAwNfkhWgh8BZ4fjuLfkhWgn8qZ6fQs1fkhWgm8fZ8fRtNfkhWgh8JZof1tzflhWgb7sYwhSuNfkhVgZ7dY9hKuxfkhVgb7cZsgDvMfkhVga7P
					Z+frvpfkhTgY6qZ7f8wnfkhSgY5rZ/f9yHfjhTgZ4aZ5f5zwfjhXgX3HZmf51LfjhbgV2OZVf92BfjhcgV2GZTf+2IfjhagW2fZbf71xfjhagW2kZcf71tfj
					hbgV2LZUf92EfjhcgV2DZSf+2LfjhcgV2DZSf+2LfjhcgV2DZSf+2LfjhcgV2DZSf+2LfjhcgV2DZSf+2L]],
				["LowerLeg.L"] = [[
					fcg0gEymgAgA6Cfcg4gJ0egAgA4lfcg7gN1ngAgA3lfcg6gM1UgEf+32fdg4gJ0ufogO4Xffg3gE0BeShF43ffg2gDzlelg85Pfdg1gGzgfvgL5Xfcg1gGzL
					gMf45nfcgygGx1gIf66jfbgvgKvWgUfo8EfagvgQsLgcfL9kfZgygTpFgXes+pfYg2gTnDgNeZ/KfYg3gTmxgMeW/OfYg1gTnqgRef/BfYg0gTn1gSeg++fY
					g2gTm8gNeY/MfYg3gTmqgLeV/PfYg3gTmqgLeV/PfYg3gTmqgLeV/PfYg3gTmqgLeV/PfYg3gTmqgLeV/P]],
				["Foot.L"] = [[
					fcgSgP/OgAgAm9fcgVgQ/pgAgAkofcgYgQ/1gAgAjHfcgXgQ/zgCf7jhfcgWgP/sf4gakTfegVgL/gfdh9lIfegUgM/bfkhpltfcgUgP/cf7gUl2fcgTgQ/Y
					gDfymQfcgRgT/OgBf2m7fbgRgd/Gf8fhnhfagWgo+9fmfKoBfZgfgw+0fFfAoffYgngz+uesfDoyfYgogz+tepfEo0fYglgy+we0fBosfYgkgy+we2fBorfY
					gngz+terfDozfYgpgz+senfEo1fYgpgz+senfEo1fYgpgz+senfEo1fYgpgz+senfEo1fYgpgz+senfEo1]],
				["UpperLeg.R"] = [[
					gchVgX64mJgAwNgchWgh8BmIgduLgchWgn8qmGgws1gchWgm8fmKgntLgchWgj8Kl4g3t+gdhVgi7vlAiAu/gdhVgf7flOhpvbgchVgc7cl+gfvUgchVgZ7P
					mRf9vjgchTgX6qmOfywjgchRgX5vmQfHx7gchRgW4nmEeRzcgchTgV3flqdk00gchWgT2wlSdL1rgchWgT2plPdI1zgchVgU2+ladS1bgchVgU3ClcdU1Wgc
					hWgT2tlRdK1ugchWgT2mlNdH11gchWgT2mlNdH11gchWgT2mlNdH11gchWgT2mlNdH11gchWgT2mlNdH11]],
				["LowerLeg.R"] = [[
					gkg0gEymgAgA6Cgkg4gJ0egAgA4lgkg7gN1ngAgA3lgkg6gM1UgEf+32gkg4gL0ufogO4Xgng2gN0BeShF43gmg1gLzlelg85Pgkg1gHzgfvgL5Xgkg1gFzL
					gMf45ngkgygFx1gIf66jgjgugIvWgUfo8EgigsgMsLgcfL9kgggtgPpFgXes+pgfgvgRnDgNeZ/KgfgvgRmxgMeW/OgggugQnqgRef/BgggugQn1gSeg++gf
					gvgRm8gNeY/MgfgwgRmqgLeV/PgfgwgRmqgLeV/PgfgwgRmqgLeV/PgfgwgRmqgLeV/PgfgwgRmqgLeV/P]],
				["Foot.R"] = [[
					gkgSgP/OgAgAm9gkgVgQ/pgAgAkogkgYgQ/1gAgAjHgkgXgQ/zgCf7jhgkgWgR/sf4gakTglgUgU/gfdh9lIglgTgT/bfkhpltgkgUgQ/cf7gUl2gkgTgP/Y
					gDfymQgkgRgT/OgBf2m7gjgRgb/Gf8fhnhgigUgl+9fmfKoBgggagt+0fFfAofgfgggw+uesfDoygfghgx+tepfEo0gggegv+we0fBosgggegv+we2fBorgf
					ghgw+terfDozgfghgx+senfEo1gfghgx+senfEo1gfghgx+senfEo1gfghgx+senfEo1gfghgx+senfEo1]],
			},
		},
	},
}
