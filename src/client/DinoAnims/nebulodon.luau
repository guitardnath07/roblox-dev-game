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
				Spine1 = [[
					gAiSgAAEgAgAhygAiVgAAEgBgLhwgAiYgAAEgCgWhygAiagAAFgDggh3gAibgAAFgDgqh/gAicgAAGgEgyiJgAibgAAHgEg6iUgAiagAAIgEhAifgAiYgAAJ
					gEhEipgAiVgAAKgEhGiwgAiSgAAKgEhHi1gAiPgAAKgEhGi3gAiNgAAKgEhEi1gAiLgAAKgEhAiwgAiJgAAJgEg6ipgAiJgAAIgDgyifgAiJgAAHgDgqiUgA
					iLgAAGgDggiJgAiNgAAFgCgWh/gAiPgAAEgBgLh3gAiSgAAEgAgAhygAiVgAAEf/f1hwgAiYgAAEf+fqhygAiagAAFf9fgh3gAibgAAFf9fWh/gAicgAAGf8
					fOiJgAibgAAHf8fGiUgAiagAAIf8fAifgAiYgAAJf8e8ipgAiVgAAKf8e6iwgAiSgAAKf8e5i1gAiPgAAKf8e6i3gAiNgAAKf8e8i1gAiLgAAKf8fAiwgAiJ
					gAAJf8fGipgAiJgAAIf9fOifgAiJgAAHf9fWiUgAiLgAAGf9fgiJgAiNgAAFf+fqh/gAiPgAAEf/f1h3]],
				Spine2 = [[
					gAiae/AngAgAmKf/ice/AngDgLmIf/ife/AngFgWmKf+iie/ApgHggmPf9ike/AqgJgpmXf9ile/AsgLgxmgf8ile/AvgMg5mrf8ike/AxgNg+m2f8ije/A0
					gNhDnAf8ihfAA2gOhFnHf7iefAA3gOhGnMf8ibfAA3gOhFnOf8iYfAA3gNhDnMf8iWfAA1gMg+nHf8iUe/AzgLg5nAf9iTe/AxgKgxm2f9iTe/AvgJgpmrf+
					iTe/AsgHggmgf/iVe/AqgFgWmXf/iXe/AogCgLmPgAiae/AngAgAmKgBice/Anf9f1mIgBife/Anf7fqmKgCiie/Apf5fgmPgDike/Aqf3fXmXgDile/Asf1
					fPmggEile/Avf0fHmrgEike/AxfzfCm2gEije/A0fze9nAgEihfAA2fye7nHgFiefAA3fye6nMgEibfAA3fye7nOgEiYfAA3fze9nMgEiWfAA1f0fCnHgEiU
					e/Azf1fHnAgDiTe/Axf2fPm2gDiTe/Avf3fXmrgCiTe/Asf5fgmggBiVe/Aqf7fqmXgBiXe/Aof+f1mP]],
				Spine3 = [[
					gAiyeDB0gAgAqlf/i1eDB0gIgVqkf9i4eDB1gQgpqmf8i6eEB4gXg8qtf7i9eEB8gehOq2f6i+eECBgkherCf5i/eFCHgphsrPf4i/eFCNgsh3rdf4i+eGCS
					gvh/rqf3i8eGCXgxiEr1f3i6eGCbgxiGr+f3i3eGCdgxiEsEf4i0eGCegvh/sGf4iyeGCdgth3sFf5iveGCbgphssCf6iueFCYglher8f7iteFCUgfhOr1f8
					iteECQgYg8rtf9iueECQgRgprtf/iveECRgJgVrzgAiyeDCSgAgAr0gBi1eDCRf3fsrygDi4eDCSfufYrygEi6eECTfmfEr1gFi9eECWffezr6gGi+eECZfZ
					ejsAgHi/eFCdfUeVsHgIi/eFCgfReKsOgIi+eGCjfOeCsTgJi8eGCjfOd8sQgJi6eGCefOd6sFgJi3eGCafQd7r7gIi0eGCXfSeAr2gIiyeGCTfVeIrtgHiv
					eGCOfYeTrjgGiueFCJfdehrXgFiteFCDfjexrKgEiteEB+fpfDq9gDiueEB6fwfXqzgBiveEB2f4frqq]],
				Spine4 = [[
					gAjadRDlfrfcuqf+jddRDjf6f4unf7jgdRDkgKgUuof5jjdSDngagvutf3jmdTDsgohKu1f1jodUD0g2hivAf0jpdVD8hCh5vNfyjqdWEGhMiMvbfxjqdXEP
					hUicvofxjpdYEXhbipv1fxjndYEfhfixwAfxjkdZEkhhi0wIfyjhdZEnhhizwOfyjfdYEphfitwRf0jcdYEohbijwSf1jadXEmhViVwRf3jZdWEihMiDwOf5
					jZdVEfhBhvwMf7jZdVEkg0hYwWf+jbdVEugmg+wqgAjedVEygVgkwzgCjhdVEygEgJwzgFjjdVEzfzfuw1gHjmdVE2fifUw5gJjpdWE6fSe6w9gLjrdXE/fE
					ehxCgMjsdXFEe3eLxHgNjsdYFIetd4xLgOjsdZFLekdoxNgPjqdZFGefdbxCgPjndZE4eddSwqgPjkdYEteddNwXgPjhdYEneedOwOgOjddXEgehdTwCgMjb
					dWEXelddv1gLjYdVENetdqvmgJjXdUEDe2d8vXgHjWdTD5fBeQvIgFjXdSDxfNeou7gCjYdSDqfbfBux]],
				Spine5 = [[
					gBkPcrFMe+eoxWf+kScrFGfTfGxQf6kVcrFEfpflxOf3kYcsFFf/gExRf0kbcuFJgWgkxWfxkecvFQgrhDxffvkgcxFZg/hhxpftkhc0FjhSh8x1frkic2Fu
					hiiUyBfqkhc3F5hvipyMfqkfc5GCh7i6yWfqkdc6GKiDjFyffrkbc6GRiIjMymfskYc6GUiLjNyrfukVc5GWiKjJyufwkTc4GXiGjBywfykSc3GVh/izyyf1
					kSc2GUh0iiyzf4kTc2GghmiMzIf8kWc3G2hUh0zof/kYc4HBhAhZz5gCkbc3HCgpg9z+gFkec4HFgSgg0DgIkhc4HKf5gB0JgLkkc5HQfhfj0QgOkmc7HXfK
					fF0WgQknc8Hde1eo0bgSkoc9HjeieN0fgTknc+HneSd10hgUklc+HeeFdf0SgVkhc8HGd9dNzwgWkdc6Gzd3c/zWgVkac5Gsdyc4zLgUkWc4Gidxc2y9gTkT
					c2GWdyc5yugRkQc0GJd3dBydgOkOcyF6d/dOyMgLkNcwFseLdfx7gIkMcuFfeZd1xsgFkNcsFUeqeNxf]],
				Spine6 = [[
					gElLcRD5egdrvAf/lNcQDxexeHu2f7lQcQDrfEenuxf3lUcRDpfYfJuwfzlXcTDpftftuzfvlacVDsgDgRu5fslccYDygXg1vBfplecbD5grhYvLfnlfceEB
					g9h5vWfmlechEJhNiYvgflldcjEShciyvpfllbclEZhpjIvxfmlZcmEghzjZv3fnlWcmEkh7jkv8fplUcmEoiAjqwAfrlSclEqiCjpwDfulRckEqiAjjwGfx
					lQciErh8jYwKf1lSckE7h0jHwpf5lVcnFWhoiyxZf9lYcpFlhYiax0gBlbcpFnhGh+x8gElecqFsgxhgyGgIlhcrFxgag/yRgLlkcsF4gDgdycgOlmcuF/fs
					f6yngRlocwGHfWfWywgUlocyGOfBe0y4gWloczGUeueTy8gXllcyGKefd0ypgZlhctFueUdXx9galdcqFaeLc/xbgalZcoFVeBcuxPgZlVcmFOd6cixAgXlR
					cjFDd2ccwugVlOcfE3d1ccwagTlLcbEqd4chwFgQlKcYEcd9csvxgMlJcVEPeGc8vegIlJcSEDeRdRvN]],
				Head = [[
					gJmBbtATckdlgVgEmDbrAOc4eUf1f+mGbrAKdPfGfif5mJbrAHdqf7fefzmNbtAFeHgwfofumQbwAFenhkgBfqmTb0AIfJiWgkfmmVb3AMfsjEhPfimWb7AT
					gQjth8fgmWb/Abg0kOipfemVcCAjhYkpjQfdmUcFArh6k7jvfdmRcGAyiZlFkDfemPcHA1i1lIkLfgmNcHA3jMlEkIfimLcGA1jdk5j6fmmKcFAxjokojjfp
					mKcEArjrkQjLfumMcHApivj3kJfzmRcOAyhMjZl8f4mVcRA1gYiwmof8mYcRAvgQh/magBmbcSArgIhKmWgFmfcUArgAgUmdgKmicWAvf5fdmvgOmkcZA3fz
					ennLgSmmccBCfudzntgVmnceBQfodDoUgYmmcgBgfjcZo5gbmjcdBdfXbzoegemecWBIexbVm0ggmZcQA/d+bBlsghmVcOBDdea2lpggmQcLBDdCazlagfmM
					cGBAcra5k9gdmIcCA6cabGkUgbmFb9AycPbajjgXmCb4ApcLb0itgTmBbzAhcNcUh1gOmBbvAZcWc6hB]],
				Jaw = [[
					gVl+aqc6/gcVi2gMl9aodH/hbziFgDl+andY/ibghQf6mBaods/kbcgYfxmFaqeC/nbmfgfomKateb/qb+eofgmPawe2/tchdyfZmUa1fT/udMdAfTmYa5fy
					/td6cTfOmca+gR/qeobtfLmebCgx/nfQbPfJmebFhR/jfwa4fImebHhv/fgEaqfJmdbIiK/cgNajfLmabIih/bgJalfPmYbGi0/bf7atfTmVbFjB/cfka9fY
					mTbDjG/ffLbUfemZbGiO/pgJb1flmlbOgw/uh8cgfsmrbSf3/3gsdPf0mtbRfl/pbweDf8mwbSfv/rbre3gEm0bUf9/6iJfsgMm4bWgC/9e1gkgUm8bagU/q
					brhYgbnAbegF/zimiOghnDbigA/jkWi+gnnFblgA/Zk+jpgsnBbif6/YkikQgxm1bZfY/fi3kzg0msbSeo/fhulNg1mobQeJ/bhrlcg1mjbNdt/Zhcligzmd
					bIdW/Yg/lggxmWbCdD/ZgWlVgtmQa8c2/bfklDgpmKa3cv/detkpgjmEaxct/ed1kJgcmAatcx/fdBji]],
				["FinF1.L"] = [[
					e4iIeYmjHBejyze2iLeZljG1d5y0e1iOeZklGpdayxe0iReajxGfdIyseziTebjMGWdFyneziUebi4GPdPyieyiVeci6GLdlyfexiVecjQGIeGybexiUecj6
					GJesyYexiSedkyGOfVyUewiPedl0GZf8yQexiMedm4GogfyNexiKecn2G7g7yNexiHecoqHQhOySeyiFecpMHjhUyaeziDebpcHxhOyleziDeapXH4g7yye0
					iDeao+H1gdy7e1iEeZoVHqf3zAe2iGeYngHYfNy+e4iIeYmjHBejyze5iLeXllGod+yje6iOeWkqGQdhyOe7iReVj4F6dRx4e8iTeVjUFndOxje9iUeUjCFX
					dZxQe+iVeUjCFLdww/e+iVeTjWFCeSwye/iUeTj9E/e7wne/iSeTkxFBfnwfe/iQeSlvFKgTwbe/iNeTmwFag7wbe/iKeTnuFwhawhe+iHeTohGJhuwte+iF
					eTpFGih0xAe9iDeUpWG4hrxYe8iDeVpUHIhUxxe7iDeVo9HQgwyKe6iEeWoWHQgDyee5iGeXnhHLfTys]],
				["FinF2.L"] = [[
					doh6d+nFMif34YdmiDd/l6MRen4bdliLeAkqL/db4YdkiReBjdLvcb4PdjiWeBiaLhbt4FdiiXeBhpLWbV36diiXeBhPLMbT3zdhiTeAhQLEbn3vdhiNeAhs
					K+cQ3wdiiGd/ifK+dJ3zdjh+d/jlLFeO33dlh2d/k1LVfZ37dmhud/mGLtgj39dohod/nRMMhk3/dphjd/oOMsiW4BdqhheAo4NHiy4FdqhieApMNai34Ldp
					hleBpJNfij4TdphqeAowNWh54Zdohyd/oCNAg+4bdoh6d+nFMif34YdpiDd8l8MAer4NdqiLd5kvLedj38dsiRd3jlK/ck3mduiVd0imKjb13OdwiXdyh4KM
					bb23dxiXdvhgJ4bY2ldyiTduhgJobr2Zd0iOdsh6JccV2Td1iHdripJYdR2Sd2h/dqjpJdeb2Wd4h2drk0Jufr2cd5hvdsmAKKg62kd5hodtnHKuh+2td5hk
					dvoDLWix25d3hidyotL9jN3Id1hid0pEMbjP3Zdyhld3pEMui23sduhqd6ouM1iG3/drhyd8oCMwhE4O]],
				["FinF1.R"] = [[
					hIiIeYmj4/hdyzhHiLeXll5YiCyjhGiOeWkq5wifyOhFiReVj46Givx4hEiTeVjU6ZiyxjhDiUeUjC6pinxQhCiVeUjC61iQw/hCiVeTjW6+huwyhBiUeTj9
					7BhFwnhBiSeTkx6/gZwfhBiQeSlv62ftwbhBiNeTmw6mfFwbhBiKeTnu6QemwhhCiHeToh53eSwthCiFeTpF5eeMxAhDiDeUpW5IeVxYhEiDeVpU44esxxhF
					iDeVo94wfQyKhGiEeWoW4wf9yehHiGeXnh41gtyshIiIeYmj4/hdyzhKiLeZlj5LiHy0hLiOeZkl5XimyxhMiReajx5hi4yshNiTebjM5qi7ynhNiUebi45x
					ixyihOiVeci651ibyfhPiVecjQ54h6ybhPiUecj653hUyYhPiSedky5ygryUhQiPedl05ngEyQhPiMedm45YfhyNhPiKecn25FfFyNhPiHecoq4weyyShOiF
					ecpM4desyahNiDebpc4PeyylhNiDeapX4IfFyyhMiDeao+4Lfjy7hLiEeZoV4WgJzAhKiGeYng4ogzy+]],
				["FinF2.R"] = [[
					iYh6d+nFzegJ4YiXiDd8l80AhV4NiWiLd5kv0iid38iUiRd3jl1Bjc3miSiVd0im1dkL3OiQiXdyh410kl23iPiXdvhg2Iko2liOiTduhg2YkV2ZiMiOdsh6
					2kjr2TiLiHdrip2oiv2SiKh/dqjp2jhl2WiIh2drk02SgV2ciHhvdsmA12fG2kiHhodtnH1SeC2tiHhkdvoD0qdP25iJhidyot0Dcz3IiLhid0pEzlcx3ZiO
					hld3pEzSdK3siShqd6ouzLd63/iVhyd8oCzQe84OiYh6d+nFzegJ4YiaiDd/l6zvhZ4bibiLeAkq0Bil4YiciReBjd0Rjl4PidiWeBia0fkT4FieiXeBhp0q
					kr36ieiXeBhP00kt3zifiTeAhQ08kZ3vifiNeAhs1Cjw3wieiGd/if1Ci33zidh+d/jl07hy33ibh2d/k10rgn37iahud/mG0Tfd39iYhod/nRz0ec3/iXhj
					d/oOzUdq4BiWhheAo4y5dO4FiWhieApMymdJ4LiXhleBpJyhdd4TiXhqeAowyqeH4ZiYhyd/oCzAfC4b]],
				Tail1 = [[
					gAiSgAfegAgA//gAiVgAfMgcgA/+gAiYgAe/g3gA/9gAiagAe4hRgB/8gAibgAe4hpgC/7gAicgAfAh+gD/6gAibgAfNiQgE/5gAiagAfgifgE/5gAiYgAf2
					iqgE/4gAiVgAgMiwgE/3gAiSgAgiiygD/3gAiPgAg0iwgC/3gAiNgAhBiqgA/3gAiLgAhIiff//4gAiJgAhIiQf+/5gAiJgAhAh+f9/6gAiJgAgzhpf9/8gA
					iLgAgghRf+/9gAiNgAgKg3f//+gAiPgAf0gcf///gAiSgAfegAgA//gAiVgAfMfkgA/+gAiYgAe/fJgA/9gAiagAe4evf//8gAibgAe4eXf+/7gAicgAfAeC
					f9/6gAibgAfNdwf8/5gAiagAfgdhf8/5gAiYgAf2dWf8/4gAiVgAgMdQf8/3gAiSgAgidOf9/3gAiPgAg0dQf+/3gAiNgAhBdWgA/3gAiLgAhIdhgB/4gAiJ
					gAhIdwgC/5gAiJgAhAeCgD/6gAiJgAgzeXgD/8gAiLgAggevgC/9gAiNgAgKfJgB/+gAiPgAf0fkgB//]],
				Tail2 = [[
					gAiUgpf+eSgE/8gBiXgpfcfCgD/+gCibgpe/fzgC/+gDidgpengkgC/9gEiegpeZhVgE/7gFifgpeUiDgF/4gGiegpeaiugH/1gGibgpeqjVgJ/ygHiYgpfD
					j3gK/vgHiVgpfhkSgK/sgHiRgpgCkngJ/qgHiNgpgkk0gI/ngHiKgphBk6gF/mgGiIgphYk4gC/lgGiGgphnkvf//mgFiGgphrkef8/ogEiHgphlkGf7/sgD
					iJgphWjof6/wgCiMgpg9jEf6/1gBiQgpgfibf7/5gAiUgpf+huf8/8f/iXgpfcg+f9/+f+ibgpe/gNf+/+f9idgpenfcf+/9f8iegpeZerf8/7f7ifgpeUd9
					f7/4f6iegpeadSf5/1f6ibgpeqcrf3/yf5iYgpfDcJf2/vf5iVgpfhbuf2/sf5iRgpgCbZf3/qf5iNgpgkbMf4/nf5iKgphBbGf7/mf6iIgphYbIf+/lf6iG
					gphnbRgB/mf7iGgphrbigE/of8iHgphlb6gF/sf9iJgphWcYgG/wf+iMgpg9c8gG/1f/iQgpgfdlgF/5]],
				Tail3 = [[
					f8iUhTfxa9gC/lf/iZhTfJbxgD/sgCidhTefcsgF/ygFihhSd5dsgH/1gIijhSdaewgJ/3gKijhSdFf1gM/2gNiihSc8g7gQ/1gPifhRdAh/gT/ygRibhRdR
					jBgX/ugSiWhRdtj9gZ/qgTiRhReRkzgb/lgTiMhQe6lhgb/fgTiHhQfjmHga/ZgTiEhQgJmjgX/UgSiChQgom1gT/PgRiChRg9m8gP/NgPiDhRhGm4gL/OgN
					iGhShCmqgH/RgKiKhSgxmRgD/XgHiPhSgVlugA/egEiUhTfxlDf+/lgBiZhTfJkPf9/sf+idhTefjUf7/yf7ihhSd5iUf5/1f4ijhSdahQf3/3f2ijhSdFgL
					f0/2fziihSc8fFfw/1fxifhRdAeBft/yfvibhRdRc/fp/ufuiWhRdtcDfn/qftiRhReRbNfl/lftiMhQe6affl/fftiHhQfjZ5fm/ZftiEhQgJZdfp/UfuiC
					hQgoZLft/PfviChRg9ZEfx/NfxiDhRhGZIf1/OfziGhShCZWf5/Rf2iKhSgxZvf9/Xf5iPhSgVaSgA/e]],
				Tail4 = [[
					fviUh6fvX0f1+7f0ibh7fJYPf7/Bf5ihh7edY2gA/Jf/imh7dwZpgG/RgEiph7dFamgK/ZgKiqh7cibrgP/ggPiqh6cIc3gT/mgUinh6b7eJgX/rgYiih5b9
					fega/ugcich5cMgzge/wgfiWh4coiIgg/vghiPh3dOjZgj/rgjiJh3d6kkgk/lgjiEh2eologl/dgjiBh2fTmjgk/Tgih/h2f3nTgi/JggiAh3gRn4gf/Agd
					iDh3gdoQgb+5gaiIh4gbocgW+2gWiOh5gLobgQ+3gRiUh6fvoMgL+7gMibh7fJnxgF/BgHihh7ednKgA/JgBimh7dwmXf6/Rf8iph7dFlaf2/Zf2iqh7cikV
					fx/gfxiqh6cIjJft/mfsinh6b7h3fp/rfoiih5b9gifm/ufkich5cMfNfi/wfhiWh4cod4fg/vffiPh3dOcnfd/rfdiJh3d6bcfc/lfdiEh2eoaYfb/dfdiB
					h2fTZdfc/Tfeh/h2f3Ytfe/JfgiAh3gRYIfh/AfjiDh3gdXwfl+5fmiIh4gbXkfq+2fqiOh5gLXlfw+3]],
				Tail5 = [[
					faiVieexXOff+ufgidifeZW5fk+nfniligd2Wzfq+jfvisihdMW6fx+if3ixihcgXPf5+kf/iziib2Xyf/+ogHiziibRYhgF+vgPixiia2ZdgJ+4gXisiham
					aigN/DgeimihakbxgP/PglieigavdIgR/bgqiWifbHejgT/lgviOiebpgBgV/sgyiIidcShfgY/vg0iDicc/i7gc/tg0iAibdrkRgf/ng0iAibeQlggi/dgy
					iCibesmmgk/RgviHice8nhgl/EgriNide+oQgk+4gmiVieexoygh+uggidifeZpHgc+ngZiligd2pNgW+jgRisihdMpGgP+igJixihcgoxgH+kgBiziib2oO
					gB+of5iziibRnff7+vfxixiia2mjf3+4fpisihamlefz/DfiimihakkPfx/Pfbieigavi4fv/bfWiWifbHhdft/lfRiOiebpf/fr/sfOiIidcSehfo/vfMiD
					icc/dFfk/tfMiAibdrbvfh/nfMiAibeQagfe/dfOiCibesZafc/RfRiHice8Yffb/EfViNide+Xwfc+4]],
				["FinB1.L"] = [[
					e4iKgxhJONci6Ue4iNgxhGOKdO6Ye5iQgyhWOLeF6de5iSgzh4ORfC6ie6iTgzioOef96oe6iTg0jgOwgz6se6iSg0kbPHhe6xe7iQg1lRPih562e7iNg1l+
					P+iD68e7iKg1mdQXh67Fe7iHg1msQrhe7Oe7iEg1mqQ3gx7Xe7iBg1mXQ6f57ee7h/g0l2Q1e67he6h+g0lKQnd87fe6h+g0kWQSdE7Xe6h/gzjfP4cZ7Le5
					iBgziqPdb/68e5iEgyh8PAb36te4iHgxhbOlcE6ge4iKgxhJONci6Ue3iNgwhIN3dQ6Le3iQgvhaNneJ6Ee2iSguh7NcfH5+e2iTgtipNZgG54e1iTgtjeNd
					g/50e1iSgskVNoht5xe1iQgslJN5iN5xe1iNgrlzONia51e0iKgrmSOhiS58e0iHgrmiOzh36Ge0iEgrmjPAhK6Re1iCgrmVPHgQ6ae1iAgrl4PIfP6he1h/
					gslPPEeM6ke1h/gtkeO8dR6je2h/gtjoOyci6fe2iBguiyOncF6ae3iEgviDOcb76We3iHgwheOTcF6U]],
				["FinB2.L"] = [[
					dziPhNhFPQaz6udziQhNg2PJbN6vd0iQhOhBPIb+62d0iNhPhkPOdB7Bd2iJhQibPeeQ7Od3iDhRjhP2fl7Yd5h9hSktQXg17fd8h3hUl5Q9h67id+hxhVm7
					Rjit7jd/hshWnvSFjH7keAhphXoRSfjH7nd/hohXodSsis7td+hohYoTSuh471d9hqhYnySigy78d7huhYm+SNfg8Ad5h0hXl7RxeL7+d4h6hWkwRQc770d3
					iBhUjjQvb47ld1iHhSieQNbJ7Rd0iMhPhoPtax6+dziPhNhFPQaz6udxiQhKg6O2bO6kdwiQhIhHOjcB6fdwiNhGhrOYdG6fdviJhFihOXeY6hdwiDhDjjOh
					fx6jdxh9hDkqO1hG6kdyh3hDlwPRiQ6jd0hxhDmtPvjI6id0hthDnfQNjm6jd1hqhEoAQkjn6nd0hohFoOQzjM6ud0hphGoIQ4iX65dzhrhHnsQ0hO7Ddyhv
					hJm+Qpf37Ldxh0hKmAQZed7Odxh6hLk3QIdI7MdyiBhLjsP3cA7FdyiHhMilPobN67dyiMhMhsPaaz6z]],
				["FinB1.R"] = [[
					hIiKgxhJxzje6UhJiNgwhIyJiw6LhJiQgvhayZh36EhKiSguh7ykg55+hKiTgtipynf654hLiTgtjeyjfB50hLiSgskVyYeT5xhLiQgslJyHdz5xhLiNgrlz
					xzdm51hMiKgrmSxfdu58hMiHgrmixNeJ6GhMiEgrmjxAe26RhLiCgrmVw5fw6ahLiAgrl4w4gx6hhLh/gslPw8h06khLh/gtkexEiv6jhKh/gtjoxOje6fhK
					iBguiyxZj76ahJiEgviDxkkF6WhJiHgwhextj76UhIiKgxhJxzje6UhIiNgxhGx2iy6YhHiQgyhWx1h76dhHiSgzh4xvg+6ihGiTgzioxigD6ohGiTg0jgxQ
					fN6shGiSg0kbw5ei6xhFiQg1lRweeH62hFiNg1l+wCd968hFiKg1mdvpeG7FhFiHg1msvVei7OhFiEg1mqvJfP7XhFiBg1mXvGgH7ehFh/g0l2vLhG7hhGh+
					g0lKvZiE7fhGh+g0kWvui87XhGh/gzjfwIjn7LhHiBgziqwjkB68hHiEgyh8xAkJ6thIiHgxhbxbj86g]],
				["FinB2.R"] = [[
					iNiPhNhFwwlN6uiPiQhKg6xKky6kiQiQhIhHxdj/6fiQiNhGhrxoi66fiRiJhFihxpho6hiQiDhDjjxfgP6jiPh9hDkqxLe66kiOh3hDlwwvdw6jiMhxhDmt
					wRc46iiMhthDnfvzca6jiLhqhEoAvccZ6niMhohFoOvNc06uiMhphGoIvIdp65iNhrhHnsvMey7DiOhvhJm+vXgJ7LiPh0hKmAvnhj7OiPh6hLk3v4i47MiO
					iBhLjswJkA7FiOiHhMilwYkz67iOiMhMhswmlN6ziNiPhNhFwwlN6uiNiQhNg2w3kz6viMiQhOhBw4kC62iMiNhPhkwyi/7BiKiJhQibwihw7OiJiDhRjhwK
					gb7YiHh9hSktvpfL7fiEh3hUl5vDeG7iiChxhVm7uddT7jiBhshWnvt7c57kiAhphXoRthc57niBhohXodtUdU7tiChohYoTtSeI71iDhqhYnytefO78iFhu
					hYm+tzgg8AiHh0hXl7uPh17+iIh6hWkwuwjF70iJiBhUjjvRkI7liLiHhSievzk37RiMiMhPhowTlP6+]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Spine1 = [[
					gAiYgAALgAgAjJgAicgAAJgBgWivgAiZgAAIgDgoimgAiSgAAKgDgzi0gAiLgAAMgCg1jQgAiJgAAPgBgujogAiNgAAPgBgfjrgAiUgAAMgAgLjYgAibgAAK
					f/f1i7gAibgAAIf+fhingAiWgAAJf9fSiqgAiOgAALf9fLjCgAiJgAAOf+fNjegAiKgAAPf/fYjsgAiQgAAOf/fqjj]],
				Spine2 = [[
					gAilfAA6gAgAngf/ine/A0gEgVnGf9ike/AygIgnm9f9iefAA2gKgynLf9iYfAA8gKg0nnf9iXfABCgIgun9f+icfABCgFgfoAf/iifAA9gCgLnugBinfAA3
					f+f1nRgCime/Azf6fhm+gDihe/Azf3fTnBgDibfAA5f2fMnYgDiXfABAf3fOn0gDiZfABDf5fZoCgBiffABAf8frn5]],
				Spine3 = [[
					gAjCeHCKgAgArgf9jDeGCCgTg3rKf7i/eFCEgjhkrJf6i6eGCPgtiArif6i2eHCgguiGsKf6i2eICtgoh1stf8i7eICxgbhPs6f/jAeHCqgKgcsvgBjDeGCf
					f2fksUgEjBeFCXfieyr8gGi9eGCWfVeMr0gGi4eGCafRd6r8gGi2eICffWd/sJgFi4eICefgebsLgDi9eICWfvfJr7]],
				Spine4 = [[
					gAjtdXD5fjfKvPf7jtdVDqgLgau0f2jpdVDrgzhmuwfzjldXD+hRifvKfzjjdaEbhgi+v2f1jlddE1hei8wif4jqddFBhOiZw9f9jvdbE9gwhbw/gDjxdZEx
					gHgPwxgIjudXEnfcfBwfgLjpdXEme2d+wUgNjkdZErehdQwUgNjjdaEteddAwVgKjldbElepdSwLgFjqdaERfBeDvx]],
				Spine5 = [[
					gCkkczFeepeFxuf5kicwFCfefaxLfykfcwE7gag1w/ftkcc0FMhQiHxRfrkcc6Fuh2jDx5fukfc/GSiHjdylfzkldBGoiCjRzFf6kqc/GshnihzUgCkrc7Gk
					g4hWzVgKkoc5Gef8f+zQgQkic4Gge/enzPgUkec6GpeQdfzPgUkcc8Gtd2cxzLgRkec8Ghdycoy6gKkic4GEeEdGyY]],
				Spine6 = [[
					gGlgcbEJeQdEvVf6lecUDnezePulfwlacTDXfkftuOfolXcZDdgZhPuYfllZcjD1hHiku5fnldcrEUhmjeviftlkcwEqh0jywDf2lpcuEyhujcwXgAlqcqEw
					hUihwggKlncnEugnhMwpgSlhcnE0fwfrw3gXldcpFCe9eNxEgZlbcrFMeXdDxHgWldcqFGeCcaw0gQlgcjEtd/cbwL]],
				Head = [[
					gNmYb4AWfjcnjHf+mTbuANfiddiOfwmObsAGfnevhzflmMbyAFfwgPh+femPb+ALf5hsinfemVcKAVgBi3jZfjmdcRAegIjjj/ftmjcRAhgOjnkUf6mkcMAe
					gOjEkcgHmhcJAagHh/kjgTmccJAYf8gkkygbmYcNAcfxfDlEggmXcQAhfrdtlKgemYcOAkfpcwk3gYmZcFAgfmcXkH]],
				Jaw = [[
					gbmfa2f+/yfFjbgJmXarf3/1eLilf2mQaofy/4dvhUfkmOaufu/7d7fzfXmUa7fs/6ekeVfSmdbIfq/2fWdKfVmobQfs/yf+cefemvbQfw/ygTcZftmxbLf1
					/1gac8f/mubHf3/7gheBgQmqbHf3/+gvfdgfmnbLf5/9hCg+gpmnbPf+/4hJiVgsmnbNgD/0g2jSgnmlbEgD/ygGjq]],
				["FinF1.L"] = [[
					e4iXeXoRH3cvzAe1iYeZlnHUbczBe0iVeajRG2avyweyiPebhrGfanyceyiLebhEGJbHyKeziLebheFxcQx2e0iPeaiuFZd/xbe2iVeYknFQgFw6e5iYeWm2
					FiiHwee7iXeVpIGQjlwQe8iSeUrEHKkKwUe9iNeUsYH8juwpe9iLeUs0IaiaxOe8iNeVsPIhgjx8e6iSeWqpIUeiyn]],
				["FinF2.L"] = [[
					dniKeAqQNsft4JdkiZeDnIM6c04cdjiheEj0MQaV4NdjiheDhEL0Yk3pdkiceBfVLaXz3DdliXd9e0K1YL2odniQd4fhKEZw2adsiIdzhQJccY2Wdzh8dvjv
					Jcfq2Xd7hvdumjKQi52VeBhjdupTLolW2NeDhcdvrlNFmj2Gd/hddxtEOImX2Md3hmd1tcOik72qduh3d7sfOVik3a]],
				["FinF1.R"] = [[
					hIiXeXoR4JjRzAhGiYeWlt5FkdyfhEiVeVjc54lKxxhDiPeUh56alVxJhDiLeUhP6xk5wxhEiLeUhj7BjwwohFiPeViu7Jh/wmhHiVeWkm68f5wnhKiYeYm5
					6Sd9wwhMiXeapP5PcsxChNiSebrR4FcWxahOiNebsn3Jc5x3hOiKebtA2qeLyXhMiMeasV2uf3y1hLiSeZqp3RhrzH]],
				["FinF2.R"] = [[
					iZiKeAqQyUgT4JiXiZd9nLzojD4CiTihd5kC0slj3biQihd0hZ1Wnb2miOiddxfs1xoU17iPiYdwfG2Ln91oiRiRdvfq2nmV1uiRiIdwhS2zjo2GiQh8dzjv
					2UgY2miOhvd3mp1DdT2/iMhjd6pjzVbE3HiMhbd9r9xuaB3CiOhcd/tbwtaO3BiThleAtswibh3TiXh3eBslxKdr3y]],
				Tail1 = [[
					gAiYgAg2eXf9/8gAicgAgbfxgA//gAiZgAgShNgB/9gAiSgAggicgC/5gAiLgAg9jQgG/0gAiJgAhUjfgJ/xgAiNgAhXjJgJ/zgAiUgAhEiQgF/5gAibgAgn
					g9gB/+gAibgAgUfhgA//gAiWgAgXeJf//7gAiOgAgudGf8/2gAiJgAhKckf4/ygAiKgAhZcnf3/ygAiQgAhQdQf5/2]],
				Tail2 = [[
					f8iWgpg1arf3/if/ibgpgbc3f9/1gDiZgpgSfngA//gGiRgpggicgC/5gIiJgpg8k0gJ/ngJiFgohTmXgR/UgIiJgphWmzgT/OgGiSgphDmGgN/YgCiZgpgn
					kVgF/sf/ibgpgUhzgB/8f7iVgpgXe9f//+f5iNgpgucTf7/xf3iGgohJaSfz/df3iGgohXZSft/Pf5iNgphOZafv/R]],
				Tail3 = [[
					fuiUhQf2WDfb+Zf3iahSfcX9fp+9gCiYhTfTbSf0/ogNiQhSfhfff+/+gViGhQf9jygP/xgZiChOgUnXgi/IgZiGhOgXppgu+fgViPhPgEqSgq+SgOiYhRfo
					pNge+ogDiahTfVmigR/Tf4iUhTfXisgH/3fviLhRfueVf6/8fpiDhPgLaTfn/efmiDhOgYXUfW+xfoiKhPgQV1fS+U]],
				Tail4 = [[
					fWiVhyfESue49Efjibh2esS+fE9Lf2iah6egVZfS+IgLiRh7erZtfi/VgeiHh4fGfPf8/+gsiChzfek6gf/mgxiGhwfipng++fgviPhwfRslhK9YgkiZh0e3
					tchD8/gUich5eksFg19kf/iWh7ejoqgn+wfriLh6e3jogT/wfaiDh2fTd4fz/6fRiDhxfjYkfP/GfPiKhwfbUqe594]],
				Tail5 = [[
					e2iYiNdsSzeQ8/fEifiSdcQaeJ7wfcieiadTQjeO70f7iVihdYTOec9KgciJiidqYLe8+6g4iDibd9esf0/5hJiIiSeCleg0/chMiSiNd2rIhj94hEidiPdj
					uth28PgxigiWdWv2h17mgViaiedUubhs8Yf0iOiidgqkhX+EfViFifd0ktgr/ke+iEiWeBd4fs/2e0iNiPd9Xgex+v]],
				["FinB1.L"] = [[
					e4iMgwgeOKZ250e5iRgygKN2b26Ae6iPgzg8NueO6Le6iHgzivN1gj6Le6h+gzlCOPih6Ae6h7gznKO7kA5xe5h/gxojPwk25ve4iHgwpAQgk16De3iPgvos
					Q7j16ke2iRgun7Q3h46+e1iMgtm+QafQ7Ce1iDgsl6P1cd6ue1h8gskoPVaI6Qe2h8gsjJO7Yy54e3iDguhnOjYu5v]],
				["FinB2.L"] = [[
					d0iahMfsPQWy5pd0ibhMe/OvYI5vd0iQhNfvOcae6Jd1h7hNh0Okdc6od5hlhMkqPMgr6zd+hWhLneQQjw6jeChThLpkRimL6KeEhahMqtStnd6AeChlhOq/
					TWnS6Qd9huhOqnTMln6vd3hyhNptSYis7Idzh0hLoSRYfA7Mdxh5hLmUQmbS66dyiDhLj8QIYX6adziQhMhiPvW057]],
				["FinB1.R"] = [[
					hIiMgwgex2mK50hJiRgugPytkL5nhKiPgthAzThx5chLiHgsirzdfX5QhLh/gsk2zGdT5DhLh7gsm6yRby4/hKh/gtoWxEa+5PhJiIgvo8vybG54hIiPgxov
					uycQ6uhHiRgyn/uTeX7bhGiLgzm9uWhD7thGiCgzlwuwjy7ihGh8gzkZvVmA7EhGh8gyi6wDnP6jhHiDgxhfw6nR6H]],
				["FinB2.R"] = [[
					iMiahMfswwpO5piPichGfJx0n65WiSiQhBf8yklk5ciSh8g/h6ywih5uiPhmg+kkyNfL55iJhXg/nPw+cB51iDhUhDpVvSZn5uh+hbhJqntlYd53h9hlhQrF
					sXY16Zh+huhWqzr/at7HiBhyhZp1sYdv7uiEhzhaoQtLhY77iGh4hYmIuCk77qiIiChWjsu1ns7CiJiPhRhYvtpL6R]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Spine1 = [[
					gAiif4AWgAgAkigAisf4ARgAgAj8gAivf4APgAgAjtgAisf4ARgAgAj8gAiif4AWgAgAkigAiZf4AbgAgAlHgAiWf4AegAgAlXgAiZf4AbgAgAlH]],
				Spine2 = [[
					gAi1e5BRgAgAo2gAi8e4BHgAgAoRgAi+e4BDgAgAoCgAi8e4BHgAgAoRgAi1e5BRgAgAo2gAiue6BcgAgApagAire6BggAgAppgAiue6BcgAgApa]],
				Spine3 = [[
					gAjXeDCdgAgAsQgAjceBCTgOgxr1gAjeeACVgVhEr4gAjceBCigPgwsagAjXeDC0gAgAtFgAjSeFDBfzfPtfgAjQeGC/fve7tbgAjSeFCwf0fPs6]],
				Spine4 = [[
					gAkEdVD/frfUvaf9kIdSDtgUgxu5f9kKdSD2gzhwvDf+kJdUERg0huv1gAkHdYEwgVgswvgCkDdbFEfsfPxPgDkBdcE/fQeOxCgDkBdaEifQeQwS]],
				Spine5 = [[
					gCk7cyFLe/ebxUf7k9ctEqf8gJwmf4lAcuExg8hxwpf5lCczFXhYiXxff+lBc6GFg+hnypgEk+dAGkgAf5zZgIk8dAGjfEePzRgHk7c6F/eqdoya]],
				Spine6 = [[
					gFl3cYDfeudmuPf7l4cPC5fUfNtNf0l6cQC0gVhRtBf0l+cZDShHiotzf7l/cmD+hKievKgFl+cvEfgig5wRgLl7cvEmfmexwcgMl4clENe3davk]],
				Head = [[
					gLmsbxAVfodTjhf9mpbkAIfofBiVfvmrbkAHf4hTiIfsmxbxASgIi2jCf1m2cCAdgPiukigDm3cPAkgMhBlxgPm1cQAmgDetl9gTmwcDAif1dLlB]],
				Jaw = [[
					gXm1augE/1eYivgBmtagfz/2dLhCfqmuahfq/0c+evfgm4avfr/yd5dLfpnDbBfy/3fZdSf+nJbOgB/+goe+gUnIbPgQ/9g0hRgfm/bCgS/3f4i1]],
				["FinF1.L"] = [[
					e4ireQpLIwaGzFe4iwePiNHIW8xze4iyePd0GHYFw5e4iwePe1FCcMwue4ireQlDEqguvze4ileQsbGvjiuxe4ijeQwMJnjevve4ileQuyKRftyN]],
				["FinF2.L"] = [[
					dlikd9tDOret3edrjPd9kJMaW13Mdyjad0cTLvTh1DdujEdra1KJVp0Sdxiadkg5Icb11NeBh4dhqEKfj31EeHhsdmwJPLoi0Kd1h6dyxYQ/mS1W]],
				["FinF1.R"] = [[
					hIireQpL3Ql6zFhIiwePiN44pExzhIiyePd055n7w5hIiwePe16+j0wuhIireQlD7WfSvzhIileQsb5RceuxhIijeQwM2ZcivvhIileQuy1vgTyN]],
				["FinF2.R"] = [[
					ibikd9tDxVhT3eiVjPd9kJzmpL3MiOjad0cT0Rsf1DiSjEdra113qX0SiPiadkg53kkL1Nh/h4dhqE1hcJ1Eh5hsdmwJw1Xe0KiLh6dyxYvBZu1W]],
				Tail1 = [[
					gAiif4jWeef9/xgAisf4iwgEgA/3gAivf4ighogB/2gAisf4iwiPgC/ygAiif4jWhigD/xgAiZf4j8f8gA/vgAiWf4kLeYf6/rgAiZf4j7dxf4/r]],
				Tail2 = [[
					f8iaggkabKfx/UgAikghj3d3f5/rgEipghjnh2f+/ugGikggj1kugG/agEiaggkak2gP/UgAiPgglCiJgM/hf8iLgglReLf8/gf6iPgglAbSfv/P]],
				Tail3 = [[
					fwiPhGkeX0fV+mf7ibhJj7ZffY/EgJighJjufAfq/wgSibhHj9lJgI/VgQiPhGkeoMgr+mgFiChHlEmfg3+5f3h9hHlYg+ga/hfuiDhFlHa4fs/K]],
				Tail4 = [[
					fbiEhpktXKfQ+XfqiRhtkFVUeq92gGiWhxj3Zmeu/FgfiRhtkKhzfe/qgliEhpkto2gw+XgWh2hrlMqohv9rf6hwhulemVhn+1fhh2hrlUeMgd/f]],
				Tail5 = [[
					fFh5iKkQa3gN/SfQiIiMjuUYeR9hf2iNiWjWUmdW9lgjiGiVjibbd1/Yg7h5iKkQlJfz/SgwhriJkzrjiK9XgKhjiRk5rQjQ9XfdhoiRkskgiW/P]],
				["FinB1.L"] = [[
					e4iSgmevOsV+47e4idgnfaM0b45Qe4ihgnkMMhi342e4idgnpVO8nK4Xe4iSgmrqRsmQ5Xe4iHgmq9SfgA61e4iDglncRmYS6ee4iHgmiUQQUU5K]],
				["FinB2.L"] = [[
					d7iwhFdGQLRl3ldxirg8dVNnWK4HdziKg4jPNEfY5keFhqg6qCQsoV44eNhag/uKUmq539eDhchEu4Uuln5Xd4h2hKqrSobo6rd6iahLi8ReTa5Z]],
				["FinB1.R"] = [[
					hIiSgmevxUqC47hIidgnfazMkI5QhIihgnkMzfdJ42hIidgnpVxEY24XhIiSgmrquUZw5XhIiHgmq9thgA61hIiDglncuanu6ehIiHgmiUvwrs5K]],
				["FinB2.R"] = [[
					iFiwhFdGv1ub3liPirg8dVyZp24HiNiKg4jPy8go5kh7hqg6qCvUXr44hzhag/uKraVH39h9hchEu4rSaZ5XiIh2hKqrtYkY6riGiahLi8uism5Z]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Spine1 = [[
					gAiXgAAGgAgAiUgAiYgDAGgAgAiUgAibgKAGgAgAiUgAiegSAGgAgAiUgAihgXAGgAgAiUgAifgDAGgAgAiUgAiefQAGgAgAiUgAiefQAGgAgAiUgAiefQAG
					gAgAiUgAidfQAGgAgAiUgAicfaAGgAgAiUgAiafrAGgAgAiUgAiYf7AGgAgAiUgAiXgAAGgAgAiUgAiXgAAGgAgAiUgAiXgAAGgAgAiU]],
				Spine2 = [[
					gAihe/AugAgAmrgAiifCAugAgAmrgAilfJAugAgAmrgAiofRAugAgAmrgAiqfXAugAgAmrgAiofCAugAgAmrgAinePAugAgAmrgAinePAugAgAmrgAinePAu
					gAgAmrgAinePAugAgAmrgAimeZAugAgAmrgAijerAugAgAmrgAihe6AugAgAmrgAihe/AugAgAmrgAihe/AugAgAmrgAihe/AugAgAmr]],
				Spine3 = [[
					gAi7eFCKgAgArggAi8eHCQgAgArwgAi/ePCggAgAsXgAjCeXCzgAgAtDgAjEecDAgAgAtggAjCeIChgAgAsbgAjBdUBmgAgAp7gAjBdUBmgAgAp7gAjBdUBm
					gAgAp7gAjBdVBmgAgAp8gAjAdfBtgAgAqRgAi+dwB6gAgAq1gAi7d/CGgAgArVgAi7eFCKgAgArggAi7eFCKgAgArggAi7eFCKgAgArg]],
				Spine4 = [[
					gAjmdVEOgAgAv2gAjodZEegAgAwSgAjsdiFLgAgAxagAjydsGBgAgAyqgAj1dzGngAgAzcgAjwdbFPgAgAxhgAjncgCtgAgAs2gAjncgCtgAgAs2gAjncgCt
					gAgAs2gAjnchCugAgAs5gAjncsDBgAgAthgAjmc/DigAgAulgAjmdPECgAgAvhgAjmdVEOgAgAv2gAjmdVEOgAgAv2gAjmdVEOgAgAv2]],
				Spine5 = [[
					gAkec0F+gAgAymgAkhc5GcgAgAzOgAkodHHrgAgA0xgAkwdXJNgAgA2cgAk0diKQgAgA3dgAksdBHzgAgA07gAkXb0DZgAgAuSgAkXb0DZgAgAuSgAkXb0DZ
					gAgAuSgAkXb1DagAgAuWgAkZcCD5gAgAvRgAkbcYEygAgAw0gAkdctFqgAgAyJgAkec0F+gAgAymgAkec0F+gAgAymgAkec0F+gAgAym]],
				Spine6 = [[
					gAlcceEcgAgAwOgAlgcnE/gAgAxHgAlpc9GfgAgAzSgAlxdWIagAgA1mgAl2dnJygAgA3AgAltc3GpgAgAzfgAlLbNBqgAgAqJgAlLbNBqgAgAqJgAlLbNBq
					gAgAqJgAlMbOBsgAgAqOgAlQbeCKgAgArhgAlWb7DGgAgAttgAlbcVEEgAgAvmgAlcceEcgAgAwOgAlcceEcgAgAwOgAlcceEcgAgAwO]],
				Head = [[
					gAmVb/AKgAgAi8gAmbcLAUgAgAkXgAmocrBBgAgAn8gAmzdQCTgAgAr3gAm3dpDagAgAuVgAmscmBGgAgAoNgAlzaYAugnheZggAlzaYAtgYg6ZggAlzaYAt
					fofGZggAlzaaAtfaejZogAl8auAVgAgAbigAmJbSADgJgqe6gAmSbzAFgBgHh6gAmVb/AKgAgAi8gAmVb/AKgAgAi8gAmVb/AKgAgAi8]],
				Jaw = [[
					gAmca7gAABgAgAgAmobIgAABgJgAgAnDbtgAABfpgAgAndcbgAAKdFgAgAnqc8gAAHdpgAgAnJbpgAA0nGgAf5lTZdfnB6qvhjf8lTZdf1Cys/g+gElTZdgQ
					BxqZfDgHlUZegdBbpOeggAljZugAA4nXgAf9l+aPf7ASkCgrgAmUavgAAChCgHgAmca7gAABgAgAgAmca7gAABgAgAgAmca7gAABgAgA]],
				["FinF1.L"] = [[
					e4iReXnHGngAyGe4iSeamfGHftxoe4iVehkyE+fDwZe4iYeqitD5efu8e4iaevhRDUeOt+e4iYebjlFBeKwse4iXdnm/Kiep2ne4iXdnm/Kiep2ne4iXdnm/
					Kiep2ne4iXdom/Keeq2ke4iWdynCJme81se4iTeDnGILfb0He4iReSnHG/f2yoe4iReXnHGngAyGe4iReXnHGngAyGe4iReXnHGngAyG]],
				["FinF2.L"] = [[
					dsh7d5mELlgA33dsiAd5ljLAfi3fduiMd5kIJped2cdxiYd6iVIRdY1Jd1igd7hEHfcx0QdsiXd1jKJydU2pdmiCdnl9Qhe27UdmiCdnl9Qhe27UdmiCdnl9
					Qhe27UdmiCdol9Qce37SdmiAdrmAPYfG6pdoh+dxmDNmfg5ddqh8d3mEMFf44Sdsh7d5mELlgA33dsh7d5mELlgA33dsh7d5mELlgA33]],
				["FinF1.R"] = [[
					hIiReXnH5ZgAyGhIiSeamf55gTxohIiVehky7Cg9wZhIiYeqit8Hhhu8hIiaevhR8shyt+hIiYebjl6/h2wshIiXdnm/1ehX2nhIiXdnm/1ehX2nhIiXdnm/
					1ehX2nhIiXdom/1ihW2khIiWdynC2ahE1shIiTeDnG31gl0HhIiReSnH5BgKyohIiReXnH5ZgAyGhIiReXnH5ZgAyGhIiReXnH5ZgAyG]],
				["FinF2.R"] = [[
					iUh7d5mE0bgA33iUiAd5lj1Age3fiSiMd5kI2Xhj2ciPiYd6iV3vio1JiLigd7hE4hjP0QiUiXd1jK2Ois2piaiCdnl9vfhK7UiaiCdnl9vfhK7UiaiCdnl9
					vfhK7UiaiCdol9vkhJ7SiaiAdrmAwog66piYh+dxmDyagg5diWh8d3mEz7gI4SiUh7d5mE0bgA33iUh7d5mE0bgA33iUh7d5mE0bgA33]],
				Tail1 = [[
					gAiXgAe5gAgA/+gAiYgDeygAgA/+gAibgKeigAgA/9gAiegSeQgAgA/8gAihgXeFgAgA/7gAifgDeXgAgA/8gAiefQe5iqf6/3gAiefQe5hpf8/7gAiefQe5
					eXgE/7gAidfQe5dZgG/3gAicfae5gAgA/+gAiafre5hIf9/8gAiYf7e5gLgA/+gAiXgAe5gAgA/+gAiXgAe5gAgA/+gAiXgAe5gAgA/+]],
				Tail2 = [[
					gAiagpdxgAgA/6gAibgsdlgAgA/5gAifgzdFgAgA/2gAijg7chgAgA/zgAilhBcKgAgA/wgAijgscufbgE/0gHigf5dyk7f2/igEigf5dylVfv/df8igf5dx
					eXgA/3f5igf5dzZxgQ/TgAifgEdxeNgI/3gDidgVdxiHf8/2gAibgkdxglf+/6gAiagpdxgAgA/6gAiagpdxgAgA/6gAiagpdxgAgA/6]],
				Tail3 = [[
					gAighSbrgAgA/sgAiihVbYgAgA/qgAimhcapgAgA/igAishkZ0gAgA/YgAivhpZRgAgA/Rf/ishVaHePgK/ZgTimggbtk7gL/UgSimggbzp9fw+Hf4imgibs
					hUfr/rfpimgfbxW8gD+Yf7ilgsbuaggS/OgIijg9briHgF/ogCihhNbrhHf+/rgAighSbrgAgA/sgAighSbrgAgA/sgAighSbrgAgA/s]],
				Tail4 = [[
					gAirh6ZtgAgA/XgAiuh9ZVgAgA/SgAi0iDYXgAgA/EgAi8iKXRgAgA+xgAjAiPWkgAgA+kf6i6h7XsczgP+uggixhGZzhVgx/WgqiwhAaEtTgF8ff7ixhJZ6
					nGfT+lfTiwhAZ5W9ff+EftivhSZ8WGgU9zgOiuhlZugkgV/XgFish1ZuhggB/VgAirh6ZtgAgA/XgAirh6ZtgAgA/XgAirh6ZtgAgA/X]],
				Tail5 = [[
					gAi7ihXKgAgA+vgAi+ijWsgAgA+mgAjHioVhgAgA+OgAjRitUMgAgA9ugAjYixTWgAgA9YfyjPieUvbvgF9ogjjBhsXlaahT+UhJi+hYXwtQhK75gNjAhsX+
					tnfc7ze9i/hgXcbHee+ZfVi+hwXuTAfu8BgPi+iLXPdngk+qgJi8ibXLhfgI+tgAi7ihXKgAgA+vgAi7ihXKgAgA+vgAi7ihXKgAgA+v]],
				["FinB1.L"] = [[
					e4iNgwkiPAgA6te4iPgzkeO/f56te4iRg6kSO8fn6te4iVhCkGO5fT6te4iXhIj9O3fG6se4iVgzkLPffU7Ee4iUgAkhRZfn8Ge4iUgAkhRZfn8Ge4iUgAkh
					RZfn8Ge4iUgBkhRXfn8Fe4iTgLkiQ3fs70e4iQgckiQAf17Ve4iOgrkiPQf964e4iNgwkiPAgA6te4iNgwkiPAgA6te4iNgwkiPAgA6t]],
				["FinB2.L"] = [[
					d1h8hOlQQXgA7ad1h+hRlMQWf57ad1iChYlBQTfn7ad1iHhgk1QPfS7Zd0iKhlkuQMfF7Zd2iGhUk6Q3fS7vd7iCgolOS0fj8qd7iCgolOS0fj8qd7iCgolO
					S0fj8qd7iCgplOSyfj8qd6iBgxlPSRfp8ad4h/g+lPRZf07+d2h9hKlQQof97jd1h8hOlQQXgA7ad1h8hOlQQXgA7ad1h8hOlQQXgA7a]],
				["FinB1.R"] = [[
					hIiNgwkixAgA6thIiPgzkexBgH6thIiRg6kSxEgZ6thIiVhCkGxHgt6thIiXhIj9xJg66shIiVgzkLwhgs7EhIiUgAkhungZ8GhIiUgAkhungZ8GhIiUgAkh
					ungZ8GhIiUgBkhupgZ8FhIiTgLkivJgU70hIiQgckiwAgL7VhIiOgrkiwwgD64hIiNgwkixAgA6thIiNgwkixAgA6thIiNgwkixAgA6t]],
				["FinB2.R"] = [[
					iLh8hOlQvpgA7aiLh+hRlMvqgH7aiLiChYlBvtgZ7aiLiHhgk1vxgu7ZiMiKhlkuv0g77ZiKiGhUk6vJgu7viFiCgolOtMgd8qiFiCgolOtMgd8qiFiCgolO
					tMgd8qiFiCgplOtOgd8qiGiBgxlPtvgX8aiIh/g+lPungM7+iKh9hKlQvYgD7jiLh8hOlQvpgA7aiLh8hOlQvpgA7aiLh8hOlQvpgA7a]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAiXgAAGgAgAiUgAiXgAAGgAgAiUgAiXgAAGgAgAiUgAiXgAAGgAgAiUgAiXgAAGgAgAiUgAiagAAGgAgAiUgAiegAAGgAgAiUgAifgAAGgAgAiUgAifgAAG
					gAgAiUgAifgAAGgAgAiUgAifgAAGgAgAiUgAifgAAGgAgAiUgAifgAAGgAgAiUgAifgAAGgAgAiUgAifgAAGgAgAiUgAifgAAGgAgAiUgAifgAAGgAgAiUgA
					ifgAAGgAgAiUgAicgAAGgAgAiUgAiYgAAGgAgAiUgAiXgAAGgAgAiUgAiXgAAGgAgAiUgAiXgAAGgAgAiU]],
				Spine2 = [[
					gAihe/AugAgAmrgAihe/AugAgAmrgAihe/AugAgAmrgAihe/AugAgAmrgAihe/AugAgAmrgAije/AugAgAmrgAioe/AugAgAmrgAipe/AugAgAmrgAipe/Au
					gAgAmrgAipe/AugAgAmrgAipe/AugAgAmrgAipe/AugAgAmrgAipe/AugAgAmrgAipe/AugAgAmrgAipe/AugAgAmrgAipe/AugAgAmrgAipe/AugAgAmrgA
					ioe/AugAgAmrgAime/AugAgAmrgAiie/AugAgAmrgAihe/AugAgAmrgAihe/AugAgAmrgAihe/AugAgAmr]],
				Spine3 = [[
					gAi7eFCKgAgArggAi7eFCIgAgArbgAi7eFCEgAgArRgAi7eFCBgAgArIgAi7eFCBgAgArKgAi9eFCYgAgAsEgAjCeFC3gAgAtMgAjDeFC+gAgAtbgAjDeFC+
					gAgAtbgAjDeFC+gAgAtbgAjDeFC+gAgAtbgAjDeFC+gAgAtbgAjDeFC+gAgAtbgAjDeFC+gAgAtbgAjDeFC+gAgAtbgAjDeFC+gAgAtbgAjDeFC+gAgAtbgA
					jDeFC9gAgAtZgAjAeFCqgAgAsugAi8eFCSgAgAr0gAi7eFCKgAgArggAi7eFCKgAgArggAi7eFCKgAgArg]],
				Spine4 = [[
					gAjmdVEOgAgAv2gAjmdVEJgAgAvtgAjldUD+gAgAvZgAjldUD1gAgAvJgAjldUD3gAgAvMgAjqdXE1gAgAw4gAjydaGOgAgAy7gAj0dbGhgAgAzVgAj0dbGh
					gAgAzVgAj0dbGhgAgAzVgAj0dbGhgAgAzVgAj0dbGhgAgAzVgAj0dbGhgAgAzVgAj0dbGhgAgAzVgAj0dbGhgAgAzVgAj0dbGhgAgAzVgAj0dbGhgAgAzVgA
					jzdbGegAgAzRgAjvdZFngAgAyFgAjodWEjgAgAwagAjmdVEOgAgAv2gAjmdVEOgAgAv2gAjmdVEOgAgAv2]],
				Spine5 = [[
					gAkec0F+gAgAymgAkdczF2gAgAyZgAkccxFigAgAx+gAkbcwFTgAgAxngAkbcwFWgAgAxrgAklc6HEgAgA0CgAkwdHJjgAgA2ygAkzdJKGgAgA3UgAkzdJKG
					gAgA3UgAkzdJKGgAgA3UgAkzdJKGgAgA3UgAkzdJKGgAgA3UgAkzdJKGgAgA3UgAkzdJKGgAgA3UgAkzdJKGgAgA3UgAkzdJKGgAgA3UgAkzdJKGgAgA3UgA
					kydJKAgAgA3OgAksdBIegAgA1qgAkic3GkgAgAzZgAkec0F+gAgAymgAkec0F+gAgAymgAkec0F+gAgAym]],
				Spine6 = [[
					gAlcceEcgAgAwOgAlbcdESgAgAv9gAlZcZD8gAgAvWgAlXcWDqgAgAu1gAlYcXDugAgAu7gAllcsFvgAgAyQgAlydII3gAgA2FgAl0dNJlgAgA2zgAl0dNJl
					gAgA2zgAl0dNJlgAgA2zgAl0dNJlgAgA2zgAl0dNJlgAgA2zgAl0dNJlgAgA2zgAl0dNJlgAgA2zgAl0dNJlgAgA2zgAl0dNJlgAgA2zgAl0dNJlgAgA2zgA
					l0dMJdgAgA2sgAltc8HegAgA0igAlhcmFIgAgAxWgAlcceEcgAgAwOgAlcceEcgAgAwOgAlcceEcgAgAwO]],
				Head = [[
					gAmVb/AKgAgAi8gAmUb8AGgAgAiUgAmQb2ACgAgAg6gAmNbxABgAgAfxgAmObyABgAgAf/gAmicVAogAftmMgAmzdEC5gMfPtOgAm2dPDAfmhntZgAm2dPDb
					gIfjuXgAm2dPDogXezutgAm2dPDBfohetdgAm2dPDUgAgAuKgAm2dPDtgdeju0gAm2dPDEfshOtlgAm2dPDOf4gdt8gAm2dPDvgfebu4gAm2dPDJfxg4twgA
					m1dNDCfyg3tigAmtcwB3gKe+qqgAmdcLAYgAgFkvgAmVb/AKgAgAi8gAmVb/AKgAgAi8gAmVb/AKgAgAi8]],
				Jaw = [[
					gAmca7gAABgAgAgAmYa4gAACg1gAgAmOaygAAIitgAgAmGatgAATkOgAgAmIaugAARj9gAgBm2bUf7AGiJftgDnicTfdAJiyfbf5nlcehOAYkchIgCnochfp
					ANjZfsgFnpcjfCAMi/fMf6nlcfhHAXkYhCgAnochgAAOjogAgGnpcje1AMi3fBf7nmcfg8AVkQg3f+nncggWAQj3gUgHnqckevAMize8f8nmcfgrASkEgnf8
					nlcdgpASj/gngEnTb4fdAFhxfHgAmrbIgBABgngFgAmca7gAABgAgAgAmca7gAABgAgAgAmca7gAABgAgA]],
				["FinF1.L"] = [[
					e4iReXnHGngAyGe4iReXm9Gzfyybe4iReXmlHQfTzKe4iReXmTHpe4zue4iReXmWHke9zne4iTeXkdFAeywhe4iYeXgICseaste4iZeXcrCjdcrwe4iZeXep
					CZeOr6e4iZeXfYCYehr8e4iZeXczCidfrxe4iZeXeNCbeDr4e4iZeXfnCYenr9e4iZeXdCChdlrye4iZeXdxCdd4r2e4iZeXfvCXeqr9e4iZeXdXCfdtr0e4
					iZeXdlChdur8e4iWeXisDiezuSe4iSeXl1FqfaxLe4iReXnHGngAyGe4iReXnHGngAyGe4iReXnHGngAyG]],
				["FinF2.L"] = [[
					dsh7d5mELlgA33drh8d7l8L3fx4Idoh/eAlpMffO4sdniBeDlbNBex5IdniAeDldM7e25DdtiNdwjTJmda2cd6ifdeexGeapydeAisdbbkGSYsw/d+ikdbdT
					GDZ2xcd9ihdbd8F/aRxmeAirdbbrGRYxxBd+imdbc6GGZlxWd9igdbeJF+aaxod/iqdbb5GPY6xFd/iodbciGJZVxQd9igdbeQF+afxqd/ipdbcLGMZGxKd+
					ipdbcZGQZMxVd0iVdlhVHmcP0SdsiEd0kvKaew3Fdsh7d5mELlgA33dsh7d5mELlgA33dsh7d5mELlgA33]],
				["FinF1.R"] = [[
					hIiReXnH5ZgAyGhIiReXm95NgOybhIiReXml4wgtzKhIiReXmT4XhIzuhIiReXmW4chDznhIiTeXkd7AhOwhhIiYeXgI9UhmsthIiZeXcr9dikrwhIiZeXep
					9nhyr6hIiZeXfY9ohfr8hIiZeXcz9eihrxhIiZeXeN9lh9r4hIiZeXfn9ohZr9hIiZeXdC9fibryhIiZeXdx9jiIr2hIiZeXfv9phWr9hIiZeXdX9hiTr0hI
					iZeXdl9fiSr8hIiWeXis8ehNuShIiSeXl16WgmxLhIiReXnH5ZgAyGhIiReXnH5ZgAyGhIiReXnH5ZgAyG]],
				["FinF2.R"] = [[
					iUh7d5mE0bgA33iVh8d7l80JgP4IiYh/eAlpzhgy4siZiBeDlby/hP5IiZiAeDldzFhK5DiTiNdwjT2aim2ciGifdeex5ilXydiAisdbbk5unUw/iCikdbdT
					59mKxciDihdbd86BlvxmiAirdbbr5vnPxBiCimdbc656mbxWiDigdbeJ6ClmxoiBiqdbb55xnGxFiBiodbci53mrxQiDigdbeQ6ClhxqiBipdbcL50m6xKiC
					ipdbcZ5wm0xViMiVdlhV4ajx0SiUiEd0kv1mhQ3FiUh7d5mE0bgA33iUh7d5mE0bgA33iUh7d5mE0bgA33]],
				Tail1 = [[
					gAiXgAe5gAgA/+gAiXgAe5gAgA/+gAiXgAe5gAgA/+gAiXgAe5gAgA/+gAiXgAe5gAgA/+gAiagAeVftgB/8gAiegAdbgzf8/4gAifgAdOhqf3/0gAifgAdO
					gef9/3gAifgAdOevgH/2gAifgAdOefgI/1gAifgAdOgAgA/3gAifgAdOhhf4/1gAifgAdOhRf5/2gAifgAdOfigD/3gAifgAdOeWgJ/0gAifgAdOfGgF/2gA
					ifgAdQg5f7/3gAicgAd1hDf7/5gAiYgAeogFgA/9gAiXgAe5gAgA/+gAiXgAe5gAgA/+gAiXgAe5gAgA/+]],
				Tail2 = [[
					gAiagpdxgAgA/6gAiagpdxgAgA/6gAiagpdxgAgA/6gAiagpdxgAgA/6gAiagpdxgAgA/6f/iegpcpfLgE/zgCilgpa2gugB/kgEimgpadjHfw/WgBimgpad
					hyfx/df9imgpadeXgE/df8imgpadc3gS/WgAimgpadfCgL/fgEimgpadiVf3/agDimgpadi6ft/Xf/imgpadgFf6/gf8imgpaddKgN/Yf+imgpaddkgR/agC
					imgpahgzgB/ggDiigpbrh+f4/ogAicgpdQgSf//3gAiagpdxgAgA/6gAiagpdxgAgA/6gAiagpdxgAgA/6]],
				Tail3 = [[
					gAighSbrgAgA/sgAighSbrgAgA/sgAighSbrgAgA/sgAighSbrgAgA/sgAighSbrgAgA/sf9inhSaAeogD/ZgEiyhQXXfzgS+zgMi0hPWzj1f8+ZgGi0hQWz
					jbfm+cf5i1hPWyfAfu+nf0i0hPW0bxgL+Wf9i1hQWydegb+hgKi0hPWyiJgL+jgLi0hPW0kUfv+Vf/i1hQWyhcfm+mf0i0hPWzc4f8+ef3i0hPWzb/gW+XgE
					i0hQW4fygW+qgIithRYkicf//BgBijhSa5gjf//kgAighSbrgAgA/sgAighSbrgAgA/sgAighSbrgAgA/s]],
				Tail4 = [[
					gAirh6ZtgAgA/XgAirh6ZtgAgA/XgAirh6ZtgAgA/XgAirh6ZtgAgA/XgAirh6ZtgAgA/Xf6i2h4XieSgA+zgDjIhzUHeZgp9pgWjLhwTZjjge9LgPjLhxTa
					kwfm9Bf2jLhyTXgafN9YfpjLhwTabmfv9Ef3jLhyTZb7gl9HgPjLhxTXhCgw9XgWjLhwTak7gC8/gDjLhyTZjFfS9OftjLhxTYdnfY9SftjLhwTaa9gM8+gE
					jLhyTgeOgx9YgOjAh1VqiQgR+LgCiwh5Ysgxf//IgAirh6ZtgAgA/XgAirh6ZtgAgA/XgAirh6ZtgAgA/X]],
				Tail5 = [[
					gAi7ihXKgAgA+vgAi7ihXKgAgA+vgAi7ihXKgAgA+vgAi7ihXKgAgA+vgAi7ihXKgAgA+vf1jLibUgeQf19zf/jkiRQedBg17zgejpiMPniUhV7VgajpiMPp
					lSgE6+f4jpiOPniGeu7XffjpiLPocce57OftjpiNPpa9gW7BgRjpiOPmfYha7bghjoiLPpkhg07GgLjpiOPpkZfS7HfojpiNPnfIel7afhjoiLPpa5fj7Af+
					joiPPxcshA7WgTjZiVSQhegs82gEjDieV6g2gD+WgAi7ihXKgAgA+vgAi7ihXKgAgA+vgAi7ihXKgAgA+v]],
				["FinB1.L"] = [[
					e4iNgwkiPAgA6te4iNgwkiPAgA6te4iNgwkiPAgA6te4iNgwkiPAgA6te4iNgwkiPAgA6te4iQgwkVO8fs6te4iVgwkBO3fM6te4iWgwj8O2fE6se4iWgwj8
					O2fE6se4iWgwj8O2fE6se4iWgwj8O2fE6se4iWgwj8O2fE6se4iWgwj8O2fE6se4iWgwj8O2fE6se4iWgwj8O2fE6se4iWgwj8O2fE6se4iWgwj8O2fE6se4
					iVgwj9O3fG6se4iTgwkKO6fa6te4iPgwkcO+f36te4iNgwkiPAgA6te4iNgwkiPAgA6te4iNgwkiPAgA6t]],
				["FinB2.L"] = [[
					d1h8hOlQQXgA7ad1h8hOlQQXgA7ad1h8hOlQQXgA7ad1h8hOlQQXgA7ad1h8hOlQQXgA7ad1iAhOlEQTfr7ad0iHhOkxQNfK7Zd0iJhOksQMfD7Zd0iJhOks
					QMfD7Zd0iJhOksQMfD7Zd0iJhOksQMfD7Zd0iJhOksQMfD7Zd0iJhOksQMfD7Zd0iJhOksQMfD7Zd0iJhOksQMfD7Zd0iJhOksQMfD7Zd0iJhOksQMfD7Zd0
					iIhOktQMfE7Zd1iEhOk5QQfZ7Zd1h+hOlKQVf27ad1h8hOlQQXgA7ad1h8hOlQQXgA7ad1h8hOlQQXgA7a]],
				["FinB1.R"] = [[
					hIiNgwkixAgA6thIiNgwkixAgA6thIiNgwkixAgA6thIiNgwkixAgA6thIiNgwkixAgA6thIiQgwkVxEgU6thIiVgwkBxJg06thIiWgwj8xKg86shIiWgwj8
					xKg86shIiWgwj8xKg86shIiWgwj8xKg86shIiWgwj8xKg86shIiWgwj8xKg86shIiWgwj8xKg86shIiWgwj8xKg86shIiWgwj8xKg86shIiWgwj8xKg86shI
					iVgwj9xJg66shIiTgwkKxGgm6thIiPgwkcxCgJ6thIiNgwkixAgA6thIiNgwkixAgA6thIiNgwkixAgA6t]],
				["FinB2.R"] = [[
					iLh8hOlQvpgA7aiLh8hOlQvpgA7aiLh8hOlQvpgA7aiLh8hOlQvpgA7aiLh8hOlQvpgA7aiLiAhOlEvtgV7aiMiHhOkxvzg27ZiMiJhOksv0g97ZiMiJhOks
					v0g97ZiMiJhOksv0g97ZiMiJhOksv0g97ZiMiJhOksv0g97ZiMiJhOksv0g97ZiMiJhOksv0g97ZiMiJhOksv0g97ZiMiJhOksv0g97ZiMiJhOksv0g97ZiM
					iIhOktv0g87ZiLiEhOk5vwgn7ZiLh+hOlKvrgK7aiLh8hOlQvpgA7aiLh8hOlQvpgA7aiLh8hOlQvpgA7a]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Spine1 = [[
					gAiWgAAGgAgAiUgAiWgAAGgAgAiUgAiWgAAGgAgAiUgAiwgAAGgAgHiUgAjUgAAVgSj0iTgAjlgACfg4sIiJgAjegAJcho2khogAjAgAWYiN+bgtgAiWgAmg
					iR/PfigAiWgA0bhx4gehgAingA8lhCuLd8gAjOgA/fgYlJdugAjkgA/5gCgbdsgAjhgA/6gAgAdsgAjIgA/6gAgAdsgAifgA/6gAgAdsgAiWgA/6gAgAdsgA
					iWgA/6gAgAdsgAiWgA/6gAgAdsgAiWgA/6gAgAdsgAiWgA/6gAgAds]],
				Spine2 = [[
					gAife/AugAgAmrgAife/AugAgAmrgAife/AugAgAmrgAi6e/AugBgHmrfxjefBA8gzjvmofSjvfSDEiir5mLe/jngAJ4ku2IkufbjKg1WkmX91iBgaifg7mY
					mi+oephAifgM0ClI4Cbug0ixfZ8Ci+t5aBgVjYfD+4hFlDZagCjte//SgGgbZVgAjre//SgAgAZVgAjRe//SgAgAZVgAioe//SgAgAZVgAife//SgAgAZVgA
					ife//SgAgAZVgAife//SgAgAZVgAife//SgAgAZVgAife//SgAgAZV]],
				Spine3 = [[
					gAi5eFCKgAgArggAi5eFCMgVg2rkgAi5eFCbgzh+sAf/jUeFCpg4iDsgfjj4eIDIiEkrsyepkJeoFBk/rGsHeFkCgAKfoxz0phe5jkhlVSrr7akkgxi5hxkG
					r69XeWh5i5gWyIpO3qY8hijLe16xlFtRVwgnjyeL9mhajmUfgDkIeF9mfXecUAgAkFeF9XfLeDTggAjreF9OfeezTEgAjCeF9MgAgAS6gAi5eF9OgihNTEgA
					i5eF9Xg1h9TggAi5eF9pgphmUGgAi5eF91gJgWUegAi5eF92gAgAUg]],
				Spine4 = [[
					gAjkdVEOgAgAv2f9jkdVEQgdgyv3f6jmdXEuhui+wVf5kCdZFViOjvxIfVkodfGVj6mDxreLk5eKIZnqq8w9dakxf8M3snxotsebkSiGVWwm4InNg+jmidh6
					xO63esinjlgjvNtq23W5iIj2eY4WnptVSEgzkddd7kh7jWQPf+k0dX7VegdaPqf6kzdY6rd2cXO4f8kbda6OePdEOAgAjyda6AfXe3NagEjpda6AgxhENagG
					jndY6Oh3i4OAgFjmdW68hyi8PGgBjkdV7sgfg2QAgAjkdV7ygAgAQK]],
				Spine5 = [[
					gAkcc0F+gAgAymf7kdc0GDgAgAysfzkfc5GfiBiyy/fxk9c+HdjTkkzufKlkdKJElrnS0Td7l3d9LuqErazgdFlvf7P6vowVv7eJlPiVWm0K1QoyhBkhi4gn
					1G4BfLjEkegvsXxU1rV+ikkueH1pqRtzP6g7lWc95mjBkMNhf5luc55jeQdkNAfylvc+4kcxbhMRf3lYdD3pczbgLLf+kwdF3GeGdKKJgFkmdF27gOf1JtgL
					kkdC3GiSijKJgLkgc74LizjhLigDkdc15tg7hRNCgAkcc06CgAgANa]],
				Spine6 = [[
					gAlaceEcgAgAwOf7lbcfEufQevwpfvlecmE4hIhzw0frl9cxFyi4k2xcfDmldEHyljo4yGd2m4d8LXp9tyxjdDmwf8QfvSyfuZeGmRiXXXzh2fn4hBlijBgp
					0R4vfNjQleg2rwww25XDi1ltd/1dqbv1RthBmUcp6fjzmLPlf1mtcm7KfHekPLftmvcx6PdMbQOkfymZc75GcpaFNYf7lxdC4VdebGL/gElodD4DfXd6LBgM
					lmc+4DhohdLBgPlhcw5DipjpMogFlcch7BhBhqPAgAlace7kgAgAPy]],
				Head = [[
					gAmUb/AKgAgAi8f+mVcCAbeQenkhfrmZcJApduiIlefhm6caBKf/lkmYe1nkc3CyjVqanDdon4d7GcmVwxm7c6nxgBMYoO3DmOeBnSifU6pQ8Ik1hBmijOgm
					pd+eiJjfmdhCuHn47ieKjOmpd35Qjryla4hOnPcP+oe/nKaUfynncJ/ZdEeYa2fjnrca+4eWahZ7fnnXcr+OgvZYX6fymxc298iPa2WPf/mpc6+Ih1eEVkgM
					mnc1+MgHh2VngUmgch+je5kNXjgJmXcF/ofnh9bogAmUb//2gAgAdE]],
				Jaw = [[
					gAmaa7gAABgAgAgEmja/hUAYkLeMfhmpbIi5AslvhNfKnObdh8A3ktlNeOn+cGgfCJjhq7cyoZdif4FniXx7cBoWgJgRLbg+4edbn2jJhET7fU9mhFnEkJhs
					f0dz/3kSm4hliJt4c28kkLm+dkjA5ecEythsnfbVjc+taumXfsn4bHiM/PZ+defNn/bdfq/EbBaSfLnybzdB/KdIaCfbnSb/cI/eezb8f2nNcCdo/3fWe0gU
					nLb9gj/7fShxgmm9bmiU/re6jrgRmjbDgu/6fGh3gAmaa7gA//gAgA]],
				["FinF1.L"] = [[
					e4iPeXnHGngAyGe4iPeXfOF3ZvxUe4iPeXcDFMb3wee3iqeYkXFUhCxDehjOesocJxe71XeDjffpgbP0Yq6meXjYhIWqZVcu9rf/i6h/a3noih+ihsiPhDgJ
					2Dbi2vh0iPfMag+BZgnDgniheHaN+qkianfdjIeGiz7/pgUGe6jeeWj57CkMP5e4jbeXbp6we9PDe4jBeXXf4ogENde4iYeXc05FmpNke4iPeXkS5to7Pve4
					iPeXj960kJPie4iPeXbG6ifJO1e4iPeXYf5MgBNxe4iPeXY55ZgAN6]],
				["FinF2.L"] = [[
					dsh6d5mELlgA33duisd7fLLBXU2hdxisdzZQKNV70CdsiZd0iSJtfH2zdRi0ejqTQYiE53c7jxgSkaW/Za9pd8kJiHUkgTaB9RgjjXjGUXshjZ61i/h+hHer
					60d8xSidh1eGcI+NWQfDgIizc7YJ8OhDTNeqj5dYh13lsyOrd1j7dvmn2EqKMRdtjKdzdu2Yg4JRdsind8WCymcvIMdoiqeCZbznkbIAd5jBd8j30fsULGdx
					isdzmw1zqFL+dth9d0c/2CgtJCdsh5d6Y0z9fEIFdsh6d5Z80bgAIJ]],
				["FinF1.R"] = [[
					hIiPeXnH5ZgAyGhIiPeXfO6JmRxUhIiPeXcD60kJwehIiqeXkW60e8w3gujOeJod6qfDvffqjfeDle+Nk7nieXjYe4jS9rpWZVeJi6gsiw3zlBLafniPh9eG
					rKb9CXhaiPhaanefZbBNh/ihf6gGRuYpEWhmjIe0lrJRX5LzhLjeeZkBFab7PLhIjbeXbpFQhDPDhIjBeXXfHYf8NdhIiYeXc0G7ZXNkhIiPeXkSGTXFPvhI
					iPeXj9FMb3PihIiPeXbGFeg3O1hIiPeXYfG0f/NxhIiPeXY5GngAN6]],
				["FinF2.R"] = [[
					iUh6d5mE0bgA33iSisd7fL0/os2hiPisdzZQ1zqF0CiSiZdyiS2dg42qhxi0dcph1Ubk1bgUjxc8nx7Qhmuwd8kJd5l/9RrcgTc6jXgink5rpeRReyh+i8gZ
					xtdlFehnh1ipXGmZacCejAizgtcEZGZHBziqj5eulzPKUeIEiSj7d2m4KeWBLsiTjKdzduJofIJRiUind8WCNajRIMiYiqeCZbMZblIAiHjBd8j3LhTsLGiP
					isdzmwKNV7L+iTh9d0c/J+fTJCiUh5d6Y0MDg8IFiUh6d5Z8LlgAIJ]],
				Tail1 = [[
					gAiWgAe5gAgA/+gAiWgAe5iggG/4gAiWgAe5kPgJ/sgAiwgAeKhfgG/5gAjUgAdJhMgH/1gAjlgAcyn4g1+0gAjegAdo0miB4SgAjAgAfa+ziOoTgAiWgAgY
					+KhDVagAiWgAg02GgxI6gAingAhcuMguDYgAjOgAimoqgvBVgAjkgAjQkpgfAigAjhgAjOhYgJANgAjIgAigdZfzAOgAifgAhXbjf0AXgAiWgAhHdYf6AJgA
					iWgAhHhYgDAEgAiWgAhHjcgIAOgAiWgAhHhBgCADgAiWgAhHgAgAAC]],
				Tail2 = [[
					gAiYgpdxgAgA/6gGiYgpdyjzgL/sgLiYgod0ohgT+wgEi1gpcVkugL/bgDjcgpaUgogO/egTjugkZoj6ho/EgojmgHbTxEj/6WgVjGfde0+VkcpDfmiYfggv
					89iGSmfXiYgChmyqhiGHffisgZi4sLhbCmfrjVgjlKqYhdCOf0jsgnmao2g8B9f8jqgomXkmgSBAgHjOgok/c3fmAkgLiigoisXvfoBOgHiYgpiNZZf0Ayf8
					iYgpiPgjgGAGf3iYgoiOl5gPApf9iYgpiPiRgFALgAiYgpiPgAgAAG]],
				Tail3 = [[
					gAiehSbrgAgA/sgQiehRbsjlgb/fggiehLb2rwg19dgQi+hQZpo6ge+DgFjqhPWliPgM+fgcj/hJVnhSiT+JhLj2gXYRsimR7sgqjSe7eA8ynirkfHiefFhn
					8RkARrewiegPjPvAiuEEfDi0g2lLodidBsfSjjhBojp4iqC7ffj9hHqSr4h3ENfxj6hNqQovgkDAgPjbhPoYejfLBLggiphLk7VgfDCNgXiehOkMVIfaCOf7
					iehSkUdsgJAZfoiehPkRmvgoBCf4iehSkUjcgOAggAiehSkVgAgAAU]],
				Tail4 = [[
					gAiph6ZtgAgA/XgZiph4Zwh6gr/Tg8iphoaEtMhi8fgljOhvXTs5g978gKkChxTMllgC8xgekYhpRxgsif8ihjkNgvVaoNoB77hEjlehdQ6JqRvDenipeuih
					8dlwSzePipglk4sPjnDFevjChXnRj5jNBRe9j5hdronPj/DYfGkWhctxtCjIGbfdkShotmsnhDF9gSjwhzrdiFetCPg5i2hqm/VVeVCugxiphtl5RvezEBgB
					iph6mKZlgDBSfYiphzmMl0hDBMfviph5mQkOgbA7gAiph6mTgAgAAp]],
				Tail5 = [[
					gAi5ihXKgAgA+vgei5ieXRfJg0+whZi4iAXusgin8JhCjjiFUrvniE5bgXkgiLPupugF5xgck5iCNiiLiM57hvkrhJR5k8pT6thij/eTcE2ZtEyUeJi5eVjl
					9CoCV4dzi4hBnMrIklDQenjVh7p3fjjnBzewkXh3u6i4lYEYevk1hoxcr6lKIjfEkwh1w+vLiPJpgLkLiRutmhecEahRjIiGpmXVdVC4hRi3iDoDP/dqFngR
					i4idoZVVfhDDfKi5iWorjQhhBbfki5ieoykagxBlgAi5iho2gAgABR]],
				["FinB1.L"] = [[
					e4iMgwkiPAgA6te4iMgwgVNWdV52e4iMgwkkOhhj6We4imgxlRQhc/7UfFjLhAe/SqU863fujchVXuY3XR8xgwjUhIcGkbef/ahXi3gCi3z2cH4ngviMe3cA
					94bcptfeiMewXR9zm4cleuiefke66Ur/SYesjFgXhD27kDKFe2jagubdx1eZF5e4jYgwauvli/Eve4i+gwfswdrHG7e4iVgwkVxirOIHe4iMgwhszFj1Gre4
					iMgwbcxfedFqe4iMgwa3v2iaEze4iMgwcuw9jKFRe4iMgwbexAgAFT]],
				["FinB2.L"] = [[
					d1h6hOlQQXgA7adxiShIf4OOay6Fd1h2hLl7QPi67Cd4iYhUoySchM7leSjkhxhKTsVx7qfbkIiOVuZiUd7QhFjliOY4kscl+pidihgSkj1BbP3Mhch+d9fa
					9vXKnxfGilduWy96knbTd4jKfJeH4vvWS4djjWgVhZ2JnyKUdzjFhIaIwIdBFLd3jKhTXOtqeyEed7jYhTdpviqCGAeCjBhLlIwVumJQdyidhFioyWndHCd1
					h2hLaFvxdGE+d3h9hSX6t/e+Ead0iHhPbovni2Eld1h6hOawvpgAEm]],
				["FinB1.R"] = [[
					hIiMgwkixAgA6thIiMgwgVyqir52hIiMgwkkxfed6WhJimgwlTvri+7OhSjLgehpzVrA28hVjcfvgQ5TsCvcgwjUe4hh/aj6kbfhi3evf6+ZbLXSeqiMfxh3
					3iaOLNfDiMg/oVovYpDUgFiehXo4a5X4C0g1jFhFiSRQcgD7hHjagybaO4hfFbhIjYgwauQbdBEvhIi+gwfsPjU5G7hIiVgwkVOeUyIHhIiMgwhsM7cLGrhI
					iMgwbcOhhjFqhIiMgwa3QKdmEzhIiMgwcuPDc2FRhIiMgwbePAgAFT]],
				["FinB2.R"] = [[
					iLh6hOlQvpgA7aiPiShIf4xylO6FiLh2hLl7vxdG7CiJiYhSoxtwew7fiVjkgyjjyhpr39iPkIfdg03wvcu1hFjldyjb+pnIkse6ihdzfB+iZfZIdhh+fqdB
					4LXqNBeWilh0mMqCXxDcgRjKiSrEbeVNEYhwjWhvjzR7ZEEZiIjFhPaDQmi1EwiJjKhTXOSWhOEeiFjYhTdpQeV+GAh+jBhLlIPrRaJQiOidhFioNqYjHCiL
					h2hLaFQPi6E+iJh9hSX6SBhCEaiMiHhPboQZdKEliLh6hOawQXgAEm]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAiVgAAGgAgAiUgAiVgMAGgAgAiUgAiVgTAGgAgAiUgAiVgRAGgAgEiUgAiVgNAGf/friUgAiVgJAJf5efiUgAiVgGAIf6eviUgAiZgGAHfofyiUgAi/gEAY
					b0geiRgAj+gBCCVFgziLgAkxgAFlOIhTh6gAkOgAJiJXhphogAjXgALfHlhxhfgAjkgALgHkhxhfgAjogALgHkhxhfgAjWgALgHkhxhfgAjWgALgHkhxhfgA
					jWgALgHkhxhfgAjWgALgHkhxhfgAjWgALgHkhxhfgAjWgALgHkhxhfgAjWgALgHkhxhfgAjWgALgHkhxhf]],
				Spine2 = [[
					gAife/AugAgAmrgAiffLAugAgAmrgAiffSAugAgAmrgAiffQAugBgEmrgBiffMAuf8fsmrgGiffJAwfsehmrgFiffGAwfvewmrgBiifFAufmf2mrf9jIfDA/
					b6hDmmf6kFfACnVSiTmRf3k0e/GGOfjvlif3kOe/J+Jzkvktf3jVe/L4IDlHkTf3jje/L5IClHkTf3jme/L5IClHkTf3jVe/L5IClHkTf3jVe/L5IClHkTf3
					jVe/L5IClHkTf3jVe/L5IClHkTf3jVe/L5IClHkTf3jVe/L5IClHkTf3jVe/L5IClHkTf3jVe/L5IClHkT]],
				Spine3 = [[
					gAi5eFCKgAgArggAi5eQCegAgAsSgAi5eYCsgAgAsygAi5eWCogBgDsqgCi5eSChf4ftsZgMi5eOCcfbemsGgKi5eLCWfie0r6gBi9eKCUflf6r4f1jheICg
					cHhprofpkZeGEDVnjgrCffk+eFHjO6ldqMfckOeFLhKXm4pXfdjReFNdIsnco+fdjeeFNfIrndo+fdjieFNfIrndo+fdjQeFNfIrndo+fdjQeFNfIrndo+fd
					jQeFNfIrndo+fdjQeFNfIrndo+fdjQeFNfIrndo+fdjQeFNfIrndo+fdjQeFNfIrndo+fdjQeFNfIrndo+]],
				Spine4 = [[
					gAjkdVEOgAgAv2gAjmdjFGgAgAxSgAjodsFsgAgAyMf/jodqFigCgDx9gDjndlFOf1fvxfgQjmdhE7fMeuw9gOjlddEtfWe6wngBjpdcEofkf/wifqkLdZEt
					cZiLwJfOk7dWGKWBklvUe4lSdVJxPcnBuUexkTdVN7LFoztdexjQdVP/JhphtDexjddVQAJgpitDexjhdVQAJgpitDexjPdVQAJgpitDexjPdVQAJgpitDex
					jPdVQAJgpitDexjPdVQAJgpitDexjPdVQAJgpitDexjPdVQAJgpitDexjPdVQAJgpitDexjPdVQAJgpitD]],
				Spine5 = [[
					gAkcc0F+gAgAymgAkidIHigAgA0mgAkldVIngAgA10f/kkdSIUgDgD1ggEkjdLHxfzfw03gTkhdEHNfDe10JgQkfc/G0fOfAzrgAkjc9GtfkgCzkfblDc6Gq
					cnigzDesloc2IBWQlLyEeGlrc0L2PsnxxCd5kbc1QWLeprwOd4jPc1SlKCqcv2d4jcc1SmKBqdv1d4jgc1SmKBqdv1d4jOc1SmKBqdv1d4jOc1SmKBqdv1d4
					jOc1SmKBqdv1d4jOc1SmKBqdv1d4jOc1SmKBqdv1d4jOc1SmKBqdv1d4jOc1SmKBqdv1d4jOc1SmKBqdv1]],
				Spine6 = [[
					gAlaceEcgAgAwOgAlic9GTgAgAzDgAlmdQHqgAgA0wf/lldLHSgCgD0TgEljdBGlf0fwzbgUlhc3F5fIexybgRlfcvFbfTe8xwf/lictFTfkgAxmfKl/coFO
					cZiKw+eFmZchGrVmj4wFdPmHcgK5OolWvuc7kichP6KRmivyc6jNciSYI2nEv2c6jaciSZI1nEv2c6jeciSZI1nEv2c6jMciSZI1nEv2c6jMciSZI1nEv2c6
					jMciSZI1nEv2c6jMciSZI1nEv2c6jMciSZI1nEv2c6jMciSZI1nEv2c6jMciSZI1nEv2c6jMciSZI1nEv2]],
				Head = [[
					gAmUb/AKgAgAi8gAmhcqBGgAgAoRgAmndGCMgAgArkf/mmc+B3gBgHqtgEmjcwBUf8fYo/gWmfchA9fudAnGgTmbcWAqfxdel0f+mecTAgfmfllge7m5cMAn
					b1gkkgdjnIcDCSU6eYjxcdmmcBGbOGbmlUcCkwcFLGJ+Z9oCb/jUcHNXIrZgpdb+jhcHNYIrZgpeb+jkcHNYIrZgpeb+jTcHNYIrZgpeb+jTcHNYIrZgpeb+
					jTcHNYIrZgpeb+jTcHNYIrZgpeb+jTcHNYIrZgpeb+jTcHNYIrZgpeb+jTcHNYIrZgpeb+jTcHNYIrZgpe]],
				Jaw = [[
					gAmaa7gAABgAgAgAm+bsgAABfqgAgAnQcQgAABfcgAf/nMcGgCABfggHgHnCb0f5ACfnfYgim2bjfoAKfudBgemubWfyAIf0def/mwbRgVABf1fhe4nFbJkO
					ATgMf8donUbAqrCEhLckclnAbDwbF4gtXmcBlZbOzNJqemTpb3kAbUz4LSdOSLb3kObVz4LTdOSKb3kRbVz4LTdOSKb3kAbVz4LTdOSKb3kAbVz4LTdOSKb3
					kAbVz4LTdOSKb3kAbVz4LTdOSKb3kAbVz4LTdOSKb3kAbVz4LTdOSKb3kAbVz4LTdOSKb3kAbVz4LTdOSK]],
				["FinF1.L"] = [[
					e4iPeXnHGngAyGe4iPejkqGDeSyBe4iPerjEF0dMx4e3iPepjfF5dex+e6iPejkWF0eFxvfCiPealRFVe6wzfAiPeYl1FlfUxCe5iRecmQGQfbx5e7imecpr
					Hkh2yJfNjKeYvNKemExEfrjreX0IO+qKu/gHjGeX3yUmtnr8gTiReX5KYGvLp4gTieeX5LYJvMp3gTiieX5LYJvMp3gTiQeX5LYJvMp3gTiQeX5LYJvMp3gT
					iQeX5LYJvMp3gTiQeX5LYJvMp3gTiQeX5LYJvMp3gTiQeX5LYJvMp3gTiQeX5LYJvMp3gTiQeX5LYJvMp3]],
				["FinF2.L"] = [[
					dsh6d5mELlgA33dpiIeFkGLGdv3wdpiSeMi0K5cS3kdoiPeLjJK/cq3rdsiKeDj2K0dd3hd3iFd0knKFed2yd1iBd0lDKXe/2/dtiBd8lYLNfO3sd0iBd+oH
					Mcic32efiKd6sjOzoA2ffjidd5weSftYzxgmh9d5y3WGxFwqhFhUd5zrX2yivChFhhd5zsX3yjvBhFhld5zsX3yjvBhFhTd5zsX3yjvBhFhTd5zsX3yjvBhF
					hTd5zsX3yjvBhFhTd5zsX3yjvBhFhTd5zsX3yjvBhFhTd5zsX3yjvBhFhTd5zsX3yjvBhFhTd5zsX3yjvB]],
				["FinF1.R"] = [[
					hIiPeXnH5ZgAyGhIiPejkq59huyBhIiPerjE6Mi0x4hIiPeojg6Lihx4hKiPemkT51iAyQhSiPeolJ4+hmzQhRiPeklx4/hKzGhKiUeelq5ohFyRhHjMeai7
					6Ti3xvg7kneYdx6SmVw9ghlyeXXs5BqIvAgGlXeXUa3ssDthf6kfeXT53bsWtPf6kteXT43bsWtPf6kweXT43bsWtPf6kfeXT43bsWtPf6kfeXT43bsWtPf6
					kfeXT43bsWtPf6kfeXT43bsWtPf6kfeXT43bsWtPf6kfeXT43bsWtPf6kfeXT43bsWtPf6kfeXT43bsWtP]],
				["FinF2.R"] = [[
					iUh6d5mE0bgA33iXiIeFkG06iR3wiXiSeMi01Hju3kiXiPeKjK1HjV3miaiKeJjy0uio37ijiFeRkczqh/4wigiBeMk9zvhb4piZiIeBk50jhZ3/iVjPd7is
					1Qjz3diDlJd6ei1QoX2WhRmwd5Zl0UtXzxgkmgd5V8yxwzw9gUlqd5Ulx/yAvrgUl3d5Ukx+yAvqgUl7d5Ukx+yAvqgUlpd5Ukx+yAvqgUlpd5Ukx+yAvqgU
					lpd5Ukx+yAvqgUlpd5Ukx+yAvqgUlpd5Ukx+yAvqgUlpd5Ukx+yAvqgUlpd5Ukx+yAvqgUlpd5Ukx+yAvq]],
				Tail1 = [[
					gAiVgAfKgAgA/+gAiVgMfKgAgA/+gAiVgTfKgAgA/+gAiVgRfKgGgA/+gAiVgNfKfef//+gAiVgJfLdef8/4gAiVgGfLd4f8/6gAiZgGfLfmgX/+gAi/gEfJ
					gHkO/sgAj+gBfWfWq8+DgAkxgAf2evx56fgAkOgAgceZ2p2hgAjXgAgveS4b0lgAjkgAgweS4c0kgAjogAgweS4c0kgAjWgAgweS4c0kgAjWgAgweS4c0kgA
					jWgAgweS4c0kgAjWgAgweS4c0kgAjWgAgweS4c0kgAjWgAgweS4c0kgAjWgAgweS4c0kgAjWgAgweS4c0k]],
				Tail2 = [[
					gAiXgpeVgAgA/8gAiXg1eVgAgA/8gAiXg9eVgAgA/8gAiXg7eVgJgA/8f/iXg3eVfQf+/8f5iXgyeVcef4/wf7iXgveVdCf5/zf/ibgveVfbgW/8gAjBgteT
					gEkO/qf+j/gqetesq7+Af9kvgpfsdfx06cf+kKgpg4cy2i2df/jSgphfcl4R0gf/jggphfcl4S0ff/jjgphfcl4S0ff/jSgphfcl4S0ff/jSgphfcl4S0ff/
					jSgphfcl4S0ff/jSgphfcl4S0ff/jSgphfcl4S0ff/jSgphfcl4S0ff/jSgphfcl4S0ff/jSgphfcl4S0f]],
				Tail3 = [[
					gAichTcggAgA/zgAichecggAgA/zgAichmcggAgA/zgBichkcggLgB/zf9ichgcgfDf7/yfwichachbffq/efzichYchcMfu/kf9ifhYcgfPgU/ygAjGhWcf
					f4kO/hf5kBhUdIdsq194f3kshSetbrxn6Vf6kDhSgoaf2M2Xf8jJhShlaI330bf8jWhRhmaI340af8jahRhmaI340af8jIhRhmaI340af8jIhRhmaI340af8
					jIhRhmaI340af8jIhRhmaI340af8jIhRhmaI340af8jIhRhmaI340af8jIhRhmaI340af8jIhRhmaI340a]],
				Tail4 = [[
					gAilh7a0gAgA/kgAiliHa0gAgA/kgAiliOa0gAgA/kgBiliMa0gOgB/kf6iliIa0e1f4/ifliliBa3agfb/Ffpilh/a2bYfg/Of7ioiBa0fEgR/jf+jPh/az
					ftkN/SfxkGh8brcvqr9qfskph6d2Z9xS6Jfxj4h5gdYU1s2Nf1i7h4hxX13R0Sf1jIh4hyX13S0Rf1jMh4hyX13S0Rf1i6h4hyX13S0Rf1i6h4hyX13S0Rf1
					i6h4hyX13S0Rf1i6h4hyX13S0Rf1i6h4hyX13S0Rf1i6h4hyX13S0Rf1i6h4hyX13S0Rf1i6h4hyX13S0R]],
				Tail5 = [[
					gAiyiiYggAgA/GgAiyiuYggAgA/GgAiyi2YggAgA/GgCiyi0YhgQgD/Gf3iyivYheofy/EfXiyimYnZke/+bfeiyilYlalfJ+of5i2ioYhe4gM/Ff8jcimYh
					fekL+0fmkNijZpbmqZ9QfckligcfX8wt50fkjqidf3Vx022AfripichjVI2S0Jfri2ichkVI2T0Ifri6ichkVI2T0IfrioichkVI2T0IfrioichkVI2T0Ifr
					ioichkVI2T0IfrioichkVI2T0IfrioichkVI2T0IfrioichkVI2T0IfrioichkVI2T0IfrioichkVI2T0I]],
				["FinB1.L"] = [[
					e4iMgwkiPAgA6te4iMg8i5Opdd6me4iMhDh1Ogb26Ye4iMhCiHOlcR6fe3iMg8isOWdJ6YeziMgyjWNeeL5ye0iMgxjtNvey5+e3iOg1j+OqfH6ke9ijg1mP
					Psiv6qfPjIgxp+Rgo95LfujqgwtSUeu+2HgKjGgwvxYM0FxogWiRgwwuah2YulgWifgwwvaj2aujgWiigwwvaj2aujgWiRgwwvaj2aujgWiRgwwvaj2aujgW
					iRgwwvaj2aujgWiRgwwvaj2aujgWiRgwwvaj2aujgWiRgwwvaj2aujgWiRgwwvaj2aujgWiRgwwvaj2auj]],
				["FinB2.L"] = [[
					d1h6hOlQQXgA7adziHhZjvP8dZ7SdziPhhiwPvbv7EdziNhfjAP1cL7LdyiJhYjjPndE7FdtiEhJkKOveK6jduiBhJkfPCey6udziBhRkuP/fG7ReAiEhTmz
					RIi07WeniQhPqLTCpL51fmimhOtHV/vX2tgkiHhOu3Y2zozIhBhchOvdaO1SxRhBhphOvdaP1TxQhBhthOvdaP1TxQhBhbhOvdaP1TxQhBhbhOvdaP1TxQhB
					hbhOvdaP1TxQhBhbhOvdaP1TxQhBhbhOvdaP1TxQhBhbhOvdaP1TxQhBhbhOvdaP1TxQhBhbhOvdaP1TxQ]],
				["FinB1.R"] = [[
					hIiMgwkixAgA6thIiMg8i5xXij6mhIiMhDh1xgkK6YhJiMhBiIxhjv6bhHiMg/ipxIi76uhDiMhAjKwBiI7bhEiMg8jmwJhh7WhIiRg3jkxChj6zhJjJgzhv
					xqkR6Sg+klgxeSxipW5BgklwgwaPwou92JgJlXgwYEvtxyz8f9kggwXuviyOzif9ktgwXuviyOzif9kxgwXuviyOzif9kfgwXuviyOzif9kfgwXuviyOzif9
					kfgwXuviyOzif9kfgwXuviyOzif9kfgwXuviyOzif9kfgwXuviyOzif9kfgwXuviyOzif9kfgwXuviyOzi]],
				["FinB2.R"] = [[
					iLh6hOlQvpgA7aiNiHhZjvwEin7SiNiPhhiwwRkR7EiNiNhejBwRj17HiLiJhejfv2jA7aiFiEhkj+uriO8EiFiBhfkYuyhl7/iLiHhVkWvthm7fiOjNhQiq
					wbkX6+h7lDhPfcwgpm5qhNmnhOblv5vW2tgimXhOYuuzzSzegTlhhOXpuO0rx/gTluhOXpuO0sx/gTlyhOXpuO0sx/gTlghOXpuO0sx/gTlghOXpuO0sx/gT
					lghOXpuO0sx/gTlghOXpuO0sx/gTlghOXpuO0sx/gTlghOXpuO0sx/gTlghOXpuO0sx/gTlghOXpuO0sx/]],
			},
		},
	},
}
