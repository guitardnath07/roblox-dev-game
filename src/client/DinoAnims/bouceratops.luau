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
					gAh1goAFgAgAiCgAh2goAFgBgEiCgAh2goAFgBgIiCgAh3goAFgCgMiCgAh3goAFgCgQiCgAh3goAFgDgTiCgAh3goAFgDgViCgAh3goAFgDgYiCgAh2goAF
					gDgZiCgAh2goAFgEgaiCgAh1goAFgEgbiCgAh1goAFgEgaiCgAh1goAFgDgZiCgAh0goAFgDgYiCgAh0goAFgDgViCgAh0goAFgDgTiCgAh0goAFgCgQiCgA
					h0goAFgCgMiCgAh1goAFgBgIiCgAh1goAFgBgEiCgAh1goAFgAgAiCgAh2goAFf/f8iCgAh2goAFf/f4iCgAh3goAFf+f0iCgAh3goAFf+fwiCgAh3goAFf9
					fth5gAh3goAEf9frhxgAh3goAEf9fohpgAh2goAEf8fnhkgAh2goADf8fmhggAh1goADf8fmhfgAh1goADf8fmhggAh1goAEf8fnhkgAh0goAEf9fohpgAh0
					goAEf9frhxgAh0goAFf9fth5gAh0goAFf+fwiCgAh0goAFf+f0iCgAh1goAFf/f4iCgAh1goAFf/f8iC]],
				Spine1 = [[
					gAh4gUAFgAgAiCgAh4gUAFgBgEiHgAh5gUAGgBgIiLgAh5gUAGgCgMiOgAh5gUAGgCgQiQgAh5gUAGgDgTiRgAh5gUAGgDgViQgAh5gUAGgDgYiOgAh5gUAG
					gDgZiLgAh4gUAGgEgaiHf/h4gUAFgEgbiCgAh4gUAFgDgah+gAh3gUAFgDgZh6gAh3gUAFgDgYh3gAh3gUAEgDgWh1gAh3gUAEgCgTh0gAh3gUAEgCgQh1gA
					h3gUAEgCgMh3gAh3gUAFgBgIh6gAh4gUAFgBgEh+gAh4gUAFgAgAiCgAh4gUAFf/f8iHgAh5gUAGf/f4iLgAh5gUAGf+f0iOgAh5gUAGf+fwiQgAh5gUAGf9
					ftiIgAh5gUAFf9frh+gAh5gUAEf8foh1gAh4gUAEf8fnhsgAh4gUAEf8fmhkgBh3gUADf8fmhfgAh3gUADf8fmhcgAh3gUADf8fnhbgAh2gUADf9fohegAh2
					gUAEf9frhjgAh2gUAEf+fthrgAh3gUAEf+fwh1gAh3gUAEf+f0h3gAh3gUAFf/f4h6gAh4gUAFf/f8h+]],
				Spine2 = [[
					gAh6gBABgAgAgfgAh7gBABgAgEgngAh7gBACgBgIgvgAh8gBACgBgMg2f/h8gBACgCgQg6f/h8gBACgCgTg7f/h8gBACgCgWg6f/h8gBACgCgYg2f/h7gBAC
					gCgZgvf/h7gBACgCgagnf/h6gBABgCgbgff/h6gBABgCgagWf/h5gBABgCgZgOf/h5gBABgCgYgHf/h5gBABgCgWgDf/h5gBABgBgTgCf/h5gBABgBgQgDgA
					h5gBABgBgMgHgAh5gBABgBgIgOgAh6gBABgAgEgWgAh6gBABgAgAgfgAh7gBABgAf8gngAh7gBACf/f4gvgAh8gBACf/f0g2gBh8gBACf+fwg6gBh8gBACf+
					ftgygBh7gBACf+fqgogBh7gBABf9fogcgBh6gBABf9fngQgBh6gBABf9fmgFgBh5gBABf9flf7gBh5gBABf9fmfzgBh4gBABf+fnfvgBh4gBABf+fofugBh4
					gBABf+fqfygBh4gBABf/ftf5gBh5gBABf/fwgDgAh5gBABf/f0gHgAh5gBABf/f4gOgAh6gBABgAf8gW]],
				Spine3 = [[
					gAh7fuABgAgAgfgAh8fuABgAgEgsgAh8fuACgBgIg4f/h9fuACgBgMhBf/h9fuACgCgQhHf/h9fuACgCgThJf/h9fuACgCgWhHf/h9fuACgCgYhBf/h8fuAC
					gCgZg4f/h8fuACgCgagsf+h7fuABgCgbgff/h6fuABgCgagRf/h6fuABgCgZgFf/h5fuABgCgYf8f/h5fuABgBgWf2f/h5fuABgBgTf0f/h5fuABgBgQf2f/
					h5fuABgBgMf8gAh6fuABgBgIgFgAh6fuABgAgEgRgAh7fuABgAgAgfgAh8fuABgAf8gsgAh8fuACf/f4g4gBh9fuACf/f0hBgBh9fuACf+fwhHgBh9fuACf+
					fthAgBh8fuACf+fqg1gBh7fuACf9fogogBh7fuABf9fngZgBh6fuABf9fmgJgCh5fuABf9flf7gBh4fuABf9fmfvgBh4fuABf+fnfmgBh4fuABf+fofjgBh4
					fuABf+fqfkgBh4fuABf/ftfqgBh5fuABf/fwf2gBh5fuABf/f0f8gAh6fuABf/f4gFgAh6fuABgAf8gR]],
				Neck1 = [[
					gAh8fbA2gAgAnQgAh9fbA4gBgEnXf/h9fbA5gCgIncf/h+fbA6gEgMnhf/h+fbA7gFgPnkf/h/fbA8f6finlf+h+fbA7f9fsnkf+h+fbA7gMgsnhf+h9fbA7
					gYhancf+h9fbA6gWhRnWf+h8fbA3gIganQf+h7fbA1f5fhnKf+h6fbA0f2fXnEf+h5fbAygBgCm/f+h5fbAzgRg9m8f/h5fbA0gYhXm7f/h5fbAzgPg4m8f/
					h5fbAyf+f3m/f/h6fbA0f6fnnEgAh7fbA1gBgDnKgAh8fbA2gAgAnQgAh9fbA4f/f8nXgBh9fbA5f+f4ncgBh+fbA6f8f0nhgBh+fbA7f7fxnkgBh+fbA2f6
					funPgCh9fbAxf6frm5gCh8fbAtf5fpmjgCh7fbApf5fomRgCh6faAmf4fnmCgCh5faAkf4fml5gCh4faAjf5fnl1gCh3faAkf5fol4gCh3faAmf5fpmBgCh3
					fbApf6frmRgBh4fbAtf7fumlgBh5fbAyf8fxm8gBh5fbAzf9f0m/gBh6fbA0f+f4nEgAh7fbA1f/f8nK]],
				Neck2 = [[
					gAiMe5CBgAgArHgAiNe5CBgCgErHf/iOe5CBgDgIrHf/iPe5CBgFgLrHf+iQe5CBgGgOrHgAiQe5CCfne0rHf/iQe5CBftfErHf9iPe5CCgYg/rHf7iOe5CH
					g4iXrFf7iNe5CFgyiFrGf9iMe5CBgLgYrHf/iLe5CCfjesrGf/iKe5CDfceYrGf+iJe5CBf7fsrHf8iJe5CDgmhirGf8iIe5CHg6iXrFf9iJe5CDgkhdrGf/
					iJe5CBf2firHgAiKe5CBfsfIrHgAiLe5CBgBgCrHgAiMe5CBgAgArHgAiNe5CBf+f8rHgBiOe5CBf9f4rHgBiPe5CBf7f1rHgCiQe5CBf6fyrHgCiOe5B0f4
					fvqkgCiNe5Bpf3fsqEgDiLe4Bgf3fqpogDiJe4BZf2fopSgDiIe4BVf2fopEgDiHe3BUf2fnpAgDiGe3BVf2fopEgDiFe3BZf2fopSgDiFe4Bgf3fqpogCiG
					e4Bpf3fsqEgCiHe4B0f4fvqkgCiJe5CBf6fyrHgBiJe5CBf7f1rHgBiKe5CBf9f4rHgAiLe5CBf+f8rH]],
				Neck3 = [[
					gAigeiClgAgAsjf/iheiCigCgEsdf/iieiCggEgHsXf+ijeiCegFgLsTf+ikeiCdgHgOsQgBikeiCgfVeGsOgBikeiCgfeedsPf7ijeiCggihTsSf3iieiCs
					hTjVsTf4iheiCshKi5sZf9igeiClgMgYsjgBifeiCtfNd2sngCieeiCxfBdZssf/idehCsfzfYszf6ideiCyg4iIs0f4iceiC6hYjXsyf7ideiCyg2iDs0gA
					idehCtfufOszgCieeiCsffepsugAifeiCogBgBspgAigeiClgAgAsjgBiheiCif+f8sdgBiieiCgf8f5sXgCijeiCef7f1sTgCikeiCdf5fysQgCiiehCKf4
					fvrggDifegB6f3fsq0gDidefBtf2fqqRgDiaeeBlf2fpp4gDiYeeBhf1foprgEiXeeBhf1fnprgDiWeeBlf1fop3gDiWeeBtf1fpqQgDiXefB5f2fqqygDiY
					efCIf3ftrbgCiaegCaf3fvsIgCidehCtf5fys2gCidehCsf6f1szgBieehCqf8f5sugBifeiCof+f8sp]],
				Head = [[
					gAjFd//7gAgAh7f/jGd+/7gAf8h9f/jHd+/7gAf4h7f+jHd+/8gAf0h2f9jId+/8gAfwhugGjId//sc8iqhegEjId//ydaiKhVf4jHd//5hWeUhLfvjHeA/a
					kJbogyfxjGeA/kjhcNgvf8jFd//+f/flg3gGjEd//pcdi+gugIjDeA/gb2jkgtgAjCd//7epg7g8f1jCeA/wikdMg9fwjCeA/XkXbhg8f2jCd//vildQhTgC
					jCd//6eqhHhkgFjDd//0d5h7hrgAjEd//8f8gAh2gAjFd//7gAgAh7gBjGd+/7gAgEh9gBjHd+/7gAgIh7gCjHd+/8gAgMh2gDjId+/8gAgQhugDjEd7/4gA
					gTipgEjAd5/zgAgWjegEi8d3/tf/gYkKgEi4d1/pf/gZkrgEi2d0/mf/gak+gFi0d0/lf/gblCgEi0d1/nf/gak3gEi1d2/rf/gZkfgEi3d3/wf/gYj6gEi6
					d5/1gAgWjKgDi+d8/6gAgTiUgDjCd//9gAgQhagCjCd//8gAgMhlgBjDd//8gAgIhvgBjEd//8gAgEh2]],
				Jaw = [[
					gAiXd1/qgAgAkmf/iYd1/ngAf8k4f/iZd1/lgBf4lFf+iad0/kgBf0lLf9iad0/kgBfwlLgAibdz/EckiJmdf/ibdz/CdEhrm9f6iadz/Nhoelmtf3ibdy+1
					k0cZmEf3iady/CkFc1l0f7iYdy/dgDfllwf/iYdx/NcEiblUgAiXdx/HbZi9lCf9iWdy/hehgvlKf6iVdz/Xi6djlCf4iWdz+/k6cHk7f7iVd0/Ui6dnlXf/
					iVd0/behg7lugBiWd0/edthsk9f/iWd1/sf8f/kTgAiXd1/qgAgAkmgBiYd1/ngAgEk4gBiZd1/lf/gIlFgCiad0/kf/gMlLgDiad0/kf/gQlLgDiWd0/Zf+
					gTmIgEiRd0/Pf9gVm6gEiNd0/Gf9gYnegEiKd0/Bf8gZnygFiHd0/Af8gan2gFiGd0/Df8gbnqgFiFd0/Kf9ganQgEiGdz/Sf9gZmpgEiIdz/cf+gYl5gEiM
					dz/lf+gWlCgDiQd0/uf/gTkKgDiVd0/0f/gQjSgCiVd0/yf/gMjlgBiWd1/wgAgIj6gBiWd1/tgAgEkR]],
				Sock = [[
					ftlYcr3ygAgA1YfslZcr3qgDf91ifrlacr3kgFf61ofqlbcs3ggIf31sfplcct3fgKf01tgdldcv3UdXhn1sgUlecw2tiHl31qfRlcc13LmakW0peklTdE3Z
					lrfA1CetlWdC21gaaR1qfnlec12+bFZ802gjlcc43jZ/eY0vgtlac53OeEj51kf+lcc02/j8l+1Ee+lUc83fmui20ceilNdE3SkOdJ1Ve+lTc42veTZp1hgB
					lYcu3MaDbV0sgPlYct3odUgV1ZftlYcs3ugCgD1dftlYcr3ygAgA1YfulZcq35f9gD1Rfvlacr4Bf7gH1Ifwlbcr4Mf5gK08fxlccs4Xf3gN0vfxlTch31f1
					gP1VfylKcX3WfzgR13fzlCcP27fxgT2Tf0k7cJ2nfwgU2nf0k3cG2cfvgU2zf0k1cF2ZfvgV21f0k2cH2gfvgU2ufzk5cL2wfwgU2ffzk/cS3HfxgT2HfylG
					ca3kfzgR1ofxlPck4Df1gP1FfwlYcw4kf3gN0ffwlYcu4Wf5gK0vfvlXct4Jf7gH0+fulYcs39f9gD1M]],
				["UpperLegF.L"] = [[
					fJhUfdyTY+e85QfIhVfdyeZHfC5LfIhVfdypZQfI5FfIhWfdyzZXfM5AfHhWfdy6ZdfQ48fHhXfdy/ZifS45fHhWfdzBZkfS45fHhWfdzAZlfR46fHhVfey9
					ZjfP48fHhVfey5ZhfM4+fHhUffy0ZdfI5AfHhTffywZYfE5CfHhSfgysZTfA5DfHhRfgyoZOe95FfHhRfgylZJe65GfHhRfgyhZFe45IfHhRfgydZCe45KfI
					hRffyZZAe35MfIhSffyWY/e45OfIhTfeyUY/e65QfJhUfdyTY+e85QfJhUfdyUY+e+5PfJhVfcyWY9fB5OfKhWfbyXY8fD5NfKhWfbyYY6fE5MfKhWfbyOY0
					e/5RfKhVfbyDYte65XfKhUfcx4Yne05cfLhTfcxuYgeu5hfLhSfdxnYaeo5kfLhRfdxiYVej5lfLhQfexgYReg5lfLhQfexhYPee5kfKhPfexjYPee5jfKhP
					fexnYSeg5hfKhQfexsYYej5ffKhRfex0Yfep5dfKhRfex6Yles5afJhSfeyBYtex5YfJhTfeyJY1e25U]],
				["LowerLegF.L"] = [[
					e6gyfn91cthcq+e6gyfm9rc6hXrde6gzfm9hdFhSr5e6gzfl9ZdPhOsPe6g0fl9UdWhMsde6g0fl9UdchMsfe6gzfl9YdghOsXe6gzfm9gdihSsDe6gzfm9r
					dihYrne5gyfn93dfhfrFe5gxfn+Edbhlqhe5gwfo+PdVhrp+e5gwfp+XdOhwpfe5gvfp+edHhzpIe5gvfp+hdBh1o7e5gvfp+hc7h1o4e5gvfp+ec2h0pBe5
					gvfp+YczhwpVe5gwfo+Pcwhrpye6gxfo+DcvhkqWe6gyfn91cthcq+e6gzfm9mcrhUrne7gzfl9XcphMsNe7g0fl9JcmhFsre7g0fk9Acig/tBe7g0fl9Gca
					hDswe7gzfl9RcRhIsUe7gzfm9dcIhPrxe7gyfn9rb+hWrKe6gxfn94b0hdqie6gwfo+Dbshjp9e6gwfp+Mbmhppee6gvfp+SbkhtpIe6gvfp+Wblhvo9e6gv
					fp+Wbqhvo+e6gvfp+TbyhtpNe6gwfo+Nb+hppne6gwfo+KcIhopye6gwfo+FcThlqGe6gxfn9+cghhqg]],
				["FootF.L"] = [[
					e6ggfS/lgQf9lIe6ggfS/kgaf8lIe6ggfS/kgkf6lIe6ggfS/kgtf5lIe6ggfS/kg0f4lIe6ggfS/kg5f3lIe6ggfS/kg+f2lIe6ggfS/khBf1lIe6ggfS/j
					hCf1lIe6ggfS/khCf1lIe6ggfS/kg/f2lIe6ggfS/kg7f2lIe6ggfS/kg2f3lIe6ggfS/kgwf4lIe6ggfS/kgpf5lIe6ggfS/kgkf6lIe6ggfS/kgef7lIe6
					ggfS/kgaf8lIe6ggfS/kgWf8lIe6ggfS/kgTf9lIe6ggfS/lgQf9lIe6ggfS/lgMf+lIe6ggfS/lgHf/lIe6ggfS/lgCgAlIe6ggfS/lf9gAlIe6ggfS/lf2
					gClIe6ggfS/kfvgDlIe6ggfS/kfngElIe6ggfS/kffgFlIe6ggfS/kfYgHlIe6ggfS/kfRgIlIe6ggfS/kfMgIlIe6ggfS/kfKgJlIe6ggfS/kfMgJlIe6gg
					fS/kfRgIlIe6ggfS/kfZgGlIe6ggfS/kfkgFlIe6ggfS/kftgDlIe6ggfS/lf4gBlIe6ggfS/lgEf/lI]],
				["UpperLegF.R"] = [[
					g3hUfdyTnChE5Qg3hUfdyUnChC5Pg3hVfcyWnDg/5Og2hWfbyXnEg95Ng2hWfbyYnGg85Mg2hWfbyWnJg95Mg2hWfbySnNg/5Og2hWfbyLnRhC5Sg1hVfbyD
					nWhG5Wg1hUfcx7nbhL5ag1hTfcx0nghP5dg1hTfdxvnkhU5fg1hSfdxsnnhX5hg2hRfdxrnohZ5hg2hRfexsnoha5gg2hRfexvnlhZ5eg2hRfex0nhhX5dg2
					hRfex6nbhU5ag3hSfeyBnThP5Yg3hTfeyJnLhK5Ug3hUfdyTnChE5Qg4hVfdyem5g+5Lg4hVfdypmwg45Fg4hWfdyzmpg05Ag5hWfdy6mjgw48g5hWfdwKma
					hZ60g5hVfewxmjhl6Zg5hUfe0UnAhR3qg5hTffvkmniO7Eg5hSfgoJl8jF+Ng5hRfgvXmxij7Hg5hQfh1Tnghm2mg5hQfhv3m6id6zg5hQfhrUmbiy9Gg5hQ
					fhw3m+h76Ng5hQfgzInJhU4mg5hRfgydm+hI5Kg4hRffyZnAhJ5Mg4hSffyWnBhI5Og4hTfeyUnBhG5Q]],
				["LowerLegF.R"] = [[
					hGgyfn91jTekq+hGgzfm9mjVesrnhFgzfl9XjXe0sNhFg0fl9Jjae7srhFg0fk9AjefBtBhFg0fk87jjfDtLhFg0fk87jofDtIhFg0fk9BjufAs6hFg0fl9K
					j0e7sihFgzfm9Wj7e1sChFgyfm9jkBeurfhGgyfn9vkHenq8hGgxfo96kLehqbhGgwfo+DkNecqBhGgwfo+JkNeZpuhGgwfo+MkJeXplhGgwfo+NkCeXpnhG
					gwfo+Kj4eYpyhGgwfo+FjtebqGhGgxfn9+jgefqghGgyfn91jTekq+hGgyfm9rjGeprdhGgzfm9hi7eur5hGgzfl9ZixeysPhGg0fl9Uiqe0sdhHg2ft9/iU
					eNqvhIg1fs+oimd+ophHgxfi/AjQePm+hJg1fw/Ri7dclehJhBf++iiRdmo8hKgzfx/gjVdKjehJgtfh/fj4d8jfhKgxfx/gjedLjVhJg4f6/Fi4dPmahJgw
					fu/RjWdglThIgufn+9jaeBnBhHgvfp+ejKeMpBhHgvfp+YjNeQpVhHgwfo+PjQeVpyhGgxfo+DjRecqW]],
				["FootF.R"] = [[
					hGggfS/lfwgDlIhGggfS/lf0gClIhGggfS/lf5gBlIhGggfS/lf+gAlIhGggfS/lgDgAlIhGggfS/lgIf/lIhGggfS/lgNf+lIhGggfS/kgSf9lIhGggfS/k
					gXf8lIhGggfS/kgcf7lIhGggfS/kghf7lIhGggfS/kglf6lIhGggfS/kgof6lIhGggfS/kgpf5lIhGggfS/kgnf6lIhGggfS/kgjf6lIhGggfS/kgcf7lIhG
					ggfS/kgTf9lIhGggfS/lgIf/lIhGggfS/lf8gBlIhGggfS/lfwgDlIhGggfS/kfmgElIhGggfS/kfcgGlIhGggfS/kfTgHlIhGggfS/kfMgIlIhGgkfX/jet
					gNlIhGgmfU/je7gLlIhGglfJ/kfogElIhGgrfW/kfIgJlIhGgyfn/ieggQlHhGgtfW/kffgFlIhGgnfG/kgRf9lIhGgrfW/kfqgElIhGgtfh/kfBgKlIhGgm
					fU/kfkgElIhGgifO/lfwgDlIhGggfS/kfigFlIhGggfS/kfmgElIhGggfS/kfqgElIhGggfS/kftgDlI]],
				Tail1 = [[
					gAh0hEirgAgA/4gAh0hEijglf6/4gAh1hEibhHf2/4gAh1hEiVhify/3gAh1hEiSh0fv/2gBh1hEiPj3fd/rgBh1hEiQkifX/lgBh1hEiUj8fc/qgBh1hEib
					i/fk/wgBh0hEijhxfv/1gBh0hEirgaf8/4gBhzhEizfDgK/2gBhzhEi6dzgX/ygBhzhEjAc0gi/rgBhyhEjDcKgp/mgBhyhEjEb6gs/kgAhyhEjDcEgq/mgA
					hzhEjAcrgj/rgAhzhEi7eWgR/0gAhzhEizfjgF/3gAh0hEirgAgA/4gAh0hEijgdf8/4gAh1hEibg2f4/4gAh1hEiVhKf1/4gAh1hEiShVf0/4f/h1hEiHhX
					fz/5f/h2hFiAhPf0/5f/h2hFh8g+f2/6f/h1hFh9glf6/7f/h1hFiBgHf//7f/h1hFiIfmgF/6f/h0hFiRfFgK/5f/h0hFicepgQ/3f/hzhFineTgT/1f/hz
					hFiyeGgV/zf/hzhEi8eEgV/ygAhyhEjEeMgT/ygAhzhEjBeegQ/0gAhzhEi7e6gL/1gAhzhEizfbgG/3]],
				Tail2 = [[
					gAhwhbkqfNgG/ogBhxhbkagRf7/rgChxhbkLhTfw/sgChyhbj/iOfo/qgDhyhbj3i8fi/ngGhyhajxm6e7+/gHhyhajxoweq+ggGhxhaj6oOew+pgFhxhakH
					m7e9+8gDhxhbkYk+fR/SgBhwhbkqijfr/jf/hvhbk7f5gI/nf+hvhblJdSgl/df8huhalSa/g+/If7huhalYZOhR+xf7huhalYYJhb+gf7huhalVX2hb+cf8
					huhalPYbhR+nf+hvhblHbogs/Rf/hvhbk6eTgQ/kgAhwhbkqfNgG/ogBhxhbkagIf8/rgBhxhbkLhDf0/sgBhyhbj/h2fs/rgBhyhbj3idfn/qgBhyhbjsi0
					fk/pgBhzhbjmi3fj/qgBhzhbjminfm/rgAhzhbjsiFfs/tf/hyhbj4hUf1/uf/hyhbkHgZgA/uf+hxhbkZfagM/rf9hwhbkredgX/nf9hwhbk8dogh/gf9hv
					hblKdAgn/bf9huhblVcpgq/Wf9huhblbcmgo/Vf+huhblUc3gj/Yf+hvhblJdagb/df/hvhbk6eOgR/j]],
				Tail3 = [[
					f/hphxl6dzgM/XgBhqhxlifMf9/ggEhrhxlMgrfw/jgGhshxk6iHfk/igHhshwkujWfb/dgPhshukloweo+ZgShshtkjr9eP9RgRhshtkusGeT9LgOhrhulB
					rJeh9hgKhqhvlapKe5+JgFhphwl2mQfa+0f/hohwmRivgA/Qf6hnhwmne9gp/Rf2hnhvm2bUhN+3fyhmhtm9YOhq+Mfxhmhtm9V8h69gfwhmhtm2Urh89Dfy
					hnhtmrUmhx9Ff4hnhvmjYqhB+bf9hohwmScqgZ/Mf/hphxl6dzgM/XgBhqhxlifEf//fgChrhxlMgbf0/kgEhshxk6hvfp/kgFhshxkui3fi/ggFhthxkhjs
					fc/cgFhuhxkckIfZ/agEhuhxkgkJfa/ZgDhthxksjufg/bgBhthxk/i7fr/df/hshxlXhzf5/ff9hrhxlxgfgJ/df7hqhwmKfFga/Yf6hphwmhdwgo/Pf5ho
					hwmzcngy/Ef4hnhwm+byg3+7f4hmhvnDbWg2+2f5hnhwm4bWgx+4f7hnhwmnbygn/Af9hohwmScoga/L]],
				Tail4 = [[
					f8hhiFkfcIf7/cgAhjiGj+dpfx/pgEhkiGjhfafr/ygIhliGjJhPfn/zgMhmiGi6i9fl/ugbhmiAi0pCfK+jgihlh8i6tifE80gghlh8jKuwfN8Ngchkh+jh
					upfc8OgWhjiBj8tOfw83gNhhiEkbqjgJ94gDhgiFk6m0gl+3f5heiElXiWhA/cfwhdiCludphW/Xfohch/l8ZPhi+qfkhch9mBVohj9nfihch7l8THhX8ofk
					hdh8luR/hC8KfuheiClbWJgb98f5hgiFlAbAgE/Mf8hhiFkfcIf7/cf/hjiGj/dhfz/pgDhkiGjhfJfu/ygGhliGjJg3fr/0gJhmiGi6iefq/wgKhniGisj0
					fq/pgLhniGipkxfr/hgKhniGixlOfu/cgIhniGjDlJfz/bgFhmiGjdkif8/egChkiGj8jegH/jf+hjiGkdiCgU/nf6hhiFk+gXgg/mf3hgiFlbeogq/ff0he
					iElydAgv/UfzhdiDl/bqgu/HfyhdiDmDaugn+9fzhdiDl1aRge+7f1heiEldaYgS/Af4hgiFlAbAgG/M]],
				Tail5 = [[
					f2hbiajCasfX/Zf9hdiciXcDfQ/pgEhfichxd1fR/3gKhhichTf1fX/9gQhiibhAh3fh/6gnhiiTg5nofY/DgzhhiKhKtEfw9LgzhgiJhnvfgO78gvhfiLiI
					wegt7VgnhdiPipwBhK7igbhbiUjJuIhn8fgNhZiYjlq4h/9zf8hXiaj/meiQ+/fthViXkXhWiV/lfghUiSkqcFiK/VfXhUiNk3XUhu+WfShUiJk6TkhF9CfS
					hViJkxRQgT7+fhhXiTkUUzfq9pfyhZiZjsZzfi/Kf2hbiajCasfX/Zf8hdiciYb7fS/ogChfichxdkfT/1gHhhichTfcfZ/9gMhiichBhYfk/8gQhjibgyjJ
					fv/0gRhkibgxkkf6/pgRhjibg+ligF/fgPhjibhXl7gQ/agMhhibh4ltgc/agHhficiek7go/ggBhdibjHjngz/of7haibjuh7g8/tf1hYiakQgBhA/sfwhW
					iZkqeFg8/kfthViXk7cUgx/YfrhUiXk/a5gf/LfrhViXkuZ+gL/DfthXiYkRZmf2/DfxhZiZjsZ2fk/L]],
				["UpperLegB.L"] = [[
					fJhUgv5CWwfsxofJhVgv5AW3fsxvfJhVgv4+W9frx1fJhWgv48XDfqx6fJhWgw47XHfpx9fJhWgw48XJfnx9fJhWgw4+XJfjx6fJhWgw5CXHfgx0fJhVgw5H
					XEfcxrfJhVgw5MW/fYxhfJhVgw5RW6fUxXfJhUgw5VW0fQxOfJhUgw5ZWvfOxGfJhTgw5bWrfNxAfJhTgw5cWofOw9fJhTgw5bWmfQw9fJhTgw5ZWmfTxBfJ
					hTgv5VWnfYxIfJhUgv5QWpfexRfJhUgv5JWtflxcfJhUgv5CWwfsxofJhVgv47W0fzx0fJhVgu40W4f6yAfJhWgu4uW6gAyJfJhWgu4qW7gFyQfJhWgu4pW5
					gKyQfJhWgu4pW2gNyNfJhWgu4sWxgPyHfJhVgu4wWsgPx/fJhVgu41WmgOx2fJhVgu46WggLxsfJhUgu4/WcgHxifJhUgu5CWYgDxbfJhTgu5FWWf+xWfJhT
					gu5HWWf5xTfJhTgu5IWYf1xTfJhTgu5HWcfxxWfJhTgu5HWffvxYfJhUgu5GWkftxcfJhUgv5FWqftxh]],
				["LowerLegB.L"] = [[
					e8g1ggvOeUgX8Fe8g1ghvjeRgV76e9g2ghv2ePgS7ve9g2giwGeNgP7le9g2giwSeNgN7ee9g2giwZeNgL7ae9g2giwaeQgK7ae9g2giwVeTgK7de8g2giwM
					eYgK7ie8g2giwAedgL7qe8g2ghvxeigL7ye8g1ghviengM77e8g1ggvUergO8De8g1ggvHetgP8Ke8g1ggu+eugQ8Pe8g1ggu4etgR8Se8g1ggu2ergS8Te8
					g1ggu4engU8Se8g1ggu9ehgV8Pe8g1ggvFebgW8Le8g1ggvOeUgX8Fe9g1ghvYeNgZ7/e9g1ghvheGga76e9g1ghvneAgb72e9g2ghvqd8gc70e9g2ghvvd2
					gf7we9g2ghvvdygi7we9g2ghvqdxgl7ze9g1ghvgdygn74e9g1ghvTd1gp8Ae9g1ggvEd5gq8Ie9g1ggu1d+gq8Re9g0gfumeEgp8Ze8g0gfuaeKgn8ge8g0
					gfuReQgl8ke8g0gfuMeVgi8ne8g0gfuMeagf8ne8g0gfuXeZge8ie8g0gfuneYgc8ae8g1ggu6eWga8Q]],
				["FootB.L"] = [[
					e6gggu/jgef7lRe6gggu/jgbf7lRe6gggu/jgYf8lRe6gggu/jgWf8lRe6gggu/jgVf8lRe6gggu/jgVf9lRe6gggu/jgWf8lRe6gggu/jgYf8lRe6gggu/j
					gbf7lRe6gggu/jgff7lRe6gggu/jgjf6lRe6gggu/jgmf6lRe6gggu/jgpf5lRe6gggu/jgrf5lRe6gggu/jgsf5lRe6gggu/jgsf5lRe6gggu/jgrf5lRe6
					gggu/jgpf5lRe6gggu/jgmf6lRe6gggu/jgif6lRe6gggu/jgef7lRe6gggu/jgZf8lRe6gggu/jgVf8lRe6gggu/jgSf9lRe6gggu/jgQf9lRe6gggu/jgN
					f+lRe6gggu/jgMf+lRe6gggu/jgNf+lRe6gggu/jgOf+lRe6gggu/jgRf9lRe6gggu/jgUf9lRe6gggu/jgXf8lRe6gggu/jgaf8lRe6gggu/jgdf7lRe6gg
					gu/jggf7lRe6gggu/jgif6lRe6gggu/jgkf6lRe6gggu/jgjf6lRe6gggu/jgif6lRe6gggu/jggf7lR]],
				["UpperLegB.R"] = [[
					g3hUgv5CpQgUxog3hVgv47pMgNx0g3hVgu40pIgGyAg3hWgu4upGgAyJg3hWgu4qpFf7yQg3hWgu4npFf4yUg3hWgu4mpHf2yUg3hWgt4npKf1yRg3hVgt4q
					pOf2yKg3hVgt4upTf4yCg3hUgt4zpYf7x5g3hUgt44pdf/xwg3hUgt48phgCxng3hTgt5ApkgGxgg3hTgu5EpmgKxag3hTgu5GpmgNxXg3hTgu5HpkgPxWg3
					hTgu5HphgRxYg3hUgu5GpcgTxcg3hUgv5FpWgTxhg3hUgv5CpQgUxog3hVgv5ApJgUxvg3hVgv4+pDgVx1g3hWgv48o9gWx6g3hWgw47o5gXx9g3hWgw49o5
					gYx7g3hWgw5Bo6gZx1g3hWgx5Fo9gbxtg3hWgx5LpBgexkg3hVgx5QpGghxZg3hVgx5WpMglxOg3hUgx5apRgpxEg3hUgx5dpWgsw9g3hUgx5fpZguw4g3hT
					gw5fpbgvw3g3hTgw5dpbguw6g3hTgw5ZpagtxBg3hTgv5VpZgoxIg3hUgv5QpXgixRg3hUgv5JpTgbxc]],
				["LowerLegB.R"] = [[
					hEg1ggvOhsfp8FhDg1ghvYhzfn7/hDg1ghvhh6fm76hDg1ghvniAfl72hDg2ghvqiEfk70hDg2ghvpiHfi70hDg1ghvjiHfh73hDg1ghvZiGfg79hDg1ggvL
					iDfe8FhDg1ggu8h/fd8NhDg1ggush7fd8WhDg0gfudh2fd8ehEg0gfuRhxfd8khEg0gfuIhtfd8phEg0gfuEhqfe8rhEg0gfuGhoff8rhEg0gfuMhmfh8nhE
					g0gfuXhnfi8ihEg0gfunhofk8ahEg1ggu6hqfm8QhEg1ggvOhsfp8FhEg1ghvjhvfr76hDg2ghv2hxfu7vhDg2giwGhzfx7lhDg2giwShzfz7ehDg2giwgh2
					fz7WhDg2gjwoh3fz7RhDg2gjwqh2fy7QhDg2gjwlh0fx7ShEg2giwchwfw7YhEg2giwOhsfu7hhEg2giv+hmft7qhEg2ghvthhft71hEg1ghvchdft7+hEg1
					ggvMhZft8HhEg1ggu/hWft8OhEg1ggu2hVfu8ThEg1ggu4hZfs8ShEg1ggu9hffr8PhEg1ggvFhlfq8L]],
				["FootB.R"] = [[
					hGgggu/jfigFlRhGgggu/jfngElRhGgggu/jfrgElRhGgggu/jfugDlRhGgggu/jfwgDlRhGgggu/jfygClRhGgggu/jfxgClRhGgggu/jfwgDlRhGgggu/j
					fugDlRhGgggu/jfrgDlRhGgggu/jfogElRhGgggu/jflgFlRhGgggu/jfigFlRhGgggu/jfggFlRhGgggu/jfegGlRhGgggu/jfdgGlRhGgggu/jfcgGlRhG
					gggu/jfdgGlRhGgggu/jfegGlRhGgggu/jfggFlRhGgggu/jfigFlRhGgggu/jflgFlRhGgggu/jfogElRhGgggu/jfqgElRhGgggu/jfrgElRhGgggu/jft
					gDlRhGgggu/jftgDlRhGgggu/jfsgDlRhGgggu/jfpgElRhGgggu/jfmgElRhGgggu/jfjgFlRhGgggu/jffgGlRhGgggu/jfbgGlRhGgggu/jfYgHlRhGgg
					gu/jfWgHlRhGgggu/jfVgHlRhGgggu/jfVgHlRhGgggu/jfXgHlRhGgggu/jfagGlRhGgggu/jfegGlR]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAhzgoAMfLgFjKgAh0goAMfQgdjJgAh2goAMfcgyjJgAh4goAMfrhAjJgAh6goAMf+hHjJgAh6goAMgQhFjKgAh4goAMghg7jKgAh2goAMgtgqjLgAh0goAM
					g1gTjKgAhzgoAMg1f7jKgAh0goAMgwfjjJgAh2goAMgkfOjJgAh4goAMgVfAjJgAh6goAMgCe5jJgAh6goAMfwe7jKgAh4goAMfffFjKgAh2goAMfTfWjLgA
					h0goAMfLftjK]],
				Spine1 = [[
					gAh3gVALflgDjKf/h4gVALfogSjJf/h6gVALfugfjJf/h8gVALf2gojJf/h9gVALgAgsjJf/h9gVALgJgrjKf/h8gVALgRgljKf/h6gVALgXgbjLgAh4gVAL
					gbgNjKgAh3gVALgbf9jKgBh4gVALgYfujJgBh6gVALgSfhjJgBh8gVALgKfYjJgBh9gVALgAfUjJgBh9gVALf3fVjKgBh8gVALfvfbjKgBh6gVALfpfljLgA
					h4gVALflfzjK]],
				Spine2 = [[
					gAh7gBAEgAgAhmf/h7gBAEgAgGhlf+h9gBAEgBgLhlf+iAgBAEgBgPhlf+iBgBAEgBgShmf+iBgBAEgBgShmf+iAgBAEgBgPhnf/h+gBAEgBgLhngAh8gBAE
					gAgGhmgAh7gBAEgAgAhmgBh7gBAEgAf6hlgCh9gBAEf/f1hlgCiAgBAEf/fxhlgCiBgBAEf/fuhmgCiBgBAEf/fuhmgCiAgBAEf/fxhngBh+gBAEf/f1hngA
					h8gBAEgAf6hm]],
				Spine3 = [[
					gAh9fuAEgbf/hmf/h9fuAEgZf8hlf+h/fuAEgUf5hlf+iCfuAEgNf4hlf9iDfuAEgEf3hmf+iDfuAEf7f3hmf+iCfuAEfyf5hnf/h/fuAEfrf7hnf/h9fuAE
					fnf+hmgAh9fuAEflgBhmgBh9fuAEfngEhlgCh/fuAEfsgHhlgCiCfuAEfzgIhlgDiDfuAEf8gJhmgCiDfuAEgFgJhmgCiCfuAEgOgHhngBh/fuAEgVgFhngB
					h9fuAEgZgChm]],
				Neck1 = [[
					gAh/fbA7gaf6nkf/h/fbA5gWfunZf+iBfbA5gPflnbf+iEfbA8gGffnof+iFfbBBf8fdn6f+iFfbBFf0ffoJf+iEfbBGfsfloNf/iBfbBEfnfvoGf/h/fbBA
					flf6n1gAh/fbA7fmgGnkgBh/fbA5fqgSnZgCiBfbA5fxgbnbgCiEfbA8f6ghnogCiFfbBBgEgjn6gCiFfbBFgMghoJgCiEfbBGgUgboNgBiBfbBEgZgRoGgB
					h/fbBAgbgGn1]],
				Neck2 = [[
					gAiQe6B2gZf3qqgAiQe6BvgRfkqVf/iSe6BwgGfTqZf/iVe6B5f7fIqyf/iXe6CGfwfErUf/iYe7CRfofHrxf/iWe7CVfifSr6f/iUe6CPfgfhrrf/iRe6CC
					fhf1rLgAiQe6B2fngJqqgAiQe6BvfvgcqVgBiSe6Bwf6gtqZgBiVe6B5gFg4qygBiXe6CGgQg8rUgBiYe7CRgYg5rxgBiWe7CVgegur6gBiUe6CPgggfrrgB
					iRe6CCgfgLrL]],
				Neck3 = [[
					gBijeiCGgZf2rWgBijehB7gNfbq4gBileiB+f/fDq9gBioeiCMfxezrigAirejChfmessVgAisekCzfeevs/gAirelC5fae9tMgAipekCufafSs2f/ilejCa
					feftsIf/ijeiCGfngKrWf/ijehB7fzglq4f/ileiB+gBg9q9f/ioeiCMgPhNrigAirejChgahUsVgAisekCzgihRs/gAirelC5gmhDtMgAipekCugmgus2gB
					ilejCagigTsI]],
				Head = [[
					gCjFd8/tgYgBkLgDjDd7/pgMgqkrgEjGd7/rf/hQkRgEjKd9/yfxhsjLgEjPeA/4flh5h5gDjSeC/6fch1hBgCjSeD/7fYhkg+gBjOeC/6fZhIhxgAjJd//1
					fegmjCf+jFd8/tfof/kLf9jDd7/pf0fWkrf8jGd7/rgBewkRf8jKd9/ygPeUjLf8jPeA/4gbeHh5f9jSeC/6gkeLhBf+jSeD/7goecg+f/jOeC/6gne4hxgA
					jJd//1gifajC]],
				Jaw = [[
					gDiWd5/lgYgClEgEiVd5/fgLgrljgEiXd4/jf9hQlKgEicd3/rfuhrkEgEiid2/zfih4iygDild2/4fZh0h6gCild3/5fVhjh3gAihd4/2fXhHiqf/ibd4/v
					fdglj7f9iWd5/lfof+lEf8iVd5/ff1fVljf8iXd4/jgDewlKf8icd3/rgSeVkEf8iid2/zgeeIiyf9ild2/4gneMh6f+ild3/5gredh3gAihd4/2gpe5iqgB
					ibd4/vgjfbj7]],
				Sock = [[
					frlKcU3xfbfQ1YfxlGcO2WfUgN24f3lLcR1OfThC35f8lXcc1BfXhr4Df+ljcr10fiiJ3Sf+lrc23Nfwie14f8lqc34df+ij0df5ljcv5EgMiSzvf0lXch40
					gahp0HfvlLcU3xglgw1YfolHcQ2Wgsfz24fjlLcU1Ogte+35felXcg1BgpeV4Dfdljcw10ged33Sfdlpc63NgQdi14felpc74dgCdd0dfhlhcx5Ef0duzvfl
					lWci40fmeX0H]],
				["UpperLegF.L"] = [[
					fHhYfbqrZrdc9XfHhZfbtuZQdN79fGhafbyDYyd05UfGhcfb1sYje92RfGhdfb6mYug+wLfHhdfb6PY+hEw2fHhbfb53Y9g4xcfIhYfb2vY6fy1WfJhWfb09
					Y9fL3GfKhVfbzqZDez4PfLhWfby1ZLet46fLhYfcyfZTe25NfLhbfcyjZdfK5NfLhdfcysZrfg5LfLhdfcyTZ4ft5hfKhcfcxFaEfr6YfJhafcvgaOfl7YfI
					hZfbriZ7eY9K]],
				["LowerLegF.L"] = [[
					e3hCf29/eKiaqte2g9fw/TdLjLlDe2g5fl/gcqjGjGe4g5fa/IchiHmJe/g9fI7Ub9fEwHfAg7fK67cIfGwzfAg5fL6jcFe0xXe8g0fX9BcagPs9e8gyfd9o
					cbglrhe8gyfh9qcYglrae8g0fk9PcbgYsee9g2fl8WcjgDube+g4fl7Dctfqwwe/g6fl5nc2fTy5e/g7fm4mdDfN0Ne+g7fp4Wdbff0le9g7ft4Ud7f30se6
					hAf17aephTwY]],
				["FootF.L"] = [[
					e6gwfh/Chtfmnie6g0fW+8guf0oHe6gzfK++gFf/oBe6gufA/Kf9gBnQe6gle7/ae7gNl7e7gje9/XfDf6mOe6ggfA/ie8gJlOe6ggfE/kfqgElIe6ggfI/l
					fxgDlIe6ggfM/kfugDlIe6ggfQ/kfugDlIe6ggfU/kfvgDlIe6ggfY/lfwgDlIe6ggfc/kfugDlIe6ggfh/lf2gClIe6ggfl/kgRf9lIe6ggfp/kg1f3lIe6
					gofo/Sh9fnmX]],
				["UpperLegF.R"] = [[
					g2hVfbzqm9hN4Pg1hWfby1m1hT46g1hYfcyfmthK5Ng1hbfcyjmjg25Ng1hdfcysmVgg5Lg1hdfcyTmIgT5hg2hcfcxFl8gV6Yg3hafcvglygb7Yg4hZfbri
					mFho9Kg5hYfbqrmVik9Xg5hZfbtumwiz79g6hafbyDnOiM5Ug6hcfb1sndhD2Rg6hdfb6mnSfCwLg5hdfb6PnCe8w2g5hbfb53nDfIxcg4hYfb2vnGgO1Wg3
					hWfb09nDg13G]],
				["LowerLegF.R"] = [[
					hEgyfh9qjofbrahEg0fk9PjlfosehDg2fl8Wjdf9ubhCg4fl7DjTgWwwhBg6fl5njKgty5hBg7fm4mi9gz0NhCg7fp4Wilgh0lhDg7ft4UiFgJ0shGhAf17a
					hXetwYhJhCf29/h2dmqthKg9fw/Ti1c1lDhKg5fl/gjWc6jGhIg5fa/Ijfd5mJhBg9fI7UkDg8wHhAg7fK67j4g6wzhAg5fL6jj7hMxXhEg0fX9Bjmfxs9hE
					gyfd9ojlfbrh]],
				["FootF.R"] = [[
					hGggfM/kgSf9lIhGggfQ/kgSf9lIhGggfU/kgRf9lIhGggfY/lgQf9lIhGggfc/kgSf9lIhGggfh/lgKf+lIhGggfl/kfvgDlIhGggfp/kfLgJlIhGgofo/S
					eDgZmXhGgwfh/CeTganihGg0fW+8fSgMoHhGgzfK++f7gBoBhGgufA/KgDf/nQhGgle7/ahFfzl7hFgje9/Xg9gGmOhGggfA/ihEf3lOhGggfE/kgWf8lIhG
					ggfI/lgPf9lI]],
				Tail1 = [[
					gAhvhEiGg5gy/5gBhwhEh1gngw/7gBhyhEhtgQgo/8gCh0hEhxf4gb/8gCh2hEh/fhgL/7gCh2hEiQfNf6/5gCh0hEiee/fq/4gBhyhEige5fc/3gAhwhEiX
					e8fT/4gAhvhEiGfHfO/5f/hwhEh1fZfQ/7f/hyhEhtfwfY/8f+h0hEhxgIfl/8f+h2hEh/gff1/7f+h2hEiQgzgG/5f+h0hEiehBgW/4f/hyhEighHgk/3gA
					hwhEiXhEgt/4]],
				Tail2 = [[
					gChshbioiZgp/ygChuhbiHhmgq/4gChwhbhvgngm/7gChyhbhrfjgd/8gBhzhbh9ejgQ/5gBhzhbiddugB/0gAhxhbi7dKfz/ugAhuhbjKc8fo/rf/hthbjC
					dGfe/tf+hshbiodnfX/yf+huhbiHeafW/4f+hwhbhvfZfa/7f+hyhbhrgdfj/8f/hzhbh9hdfw/5f/hzhbidiSf//0gAhxhbi7i2gN/ugAhuhbjKjEgY/rgB
					hthbjCi6gi/t]],
				Tail3 = [[
					gFhphxijkRgg/mgEhrhxh4jMgj/xgDhthxhQhvgh/6gBhvhxg9gEga/+f/hwhxhJeZgO/7f+hvhxhuc7gB/zf8hthxiab0f1/nf7hqhwi6bNfs/ff7hphxi9
					bLfl/ef7hphxijbvfg/mf8hrhxh4c0fd/xf9hthxhQeRff/6f/hvhxg9f8fm/+gBhwhxhJhnfy/7gChvhxhujFf//zgEhthxiakMgL/ngFhqhwi6kzgU/fgF
					hphxi9k1gb/e]],
				Tail4 = [[
					gLhliGf1mHg8/YgJhoiHfJlDg2/kgFhsiIeUjYgr/wgBhuiIdwhTga/4f9hviIdtfFgD/5f5htiHeNc+fr/yf2hpiGfBbOfW/nf0hmiGfxaCfI/af0hliGgF
					ZlfD/Uf1hliGf1Z5fE/Yf3hoiHfJa9fK/kf7hsiIeUcofV/wf/huiIdwetfm/4gDhviIdtg7f9/5gHhtiHeNjCgV/ygKhpiGfBkygq/ngMhmiGfxl+g4/agM
					hliGgFmbg9/U]],
				Tail5 = [[
					gThmibc+nhhu+5gQhpidcbmyhg/BgKhuiebjlOhK/OgDhxieaxjCgs/af8hyieadgegG/gf1hvidavd3fc/efwhricbgbhe2/VfshnibcYZteb/Hfrhlibc9
					YqeP+8fthmibc+YfeS+5fwhpidcbZOeg/Bf2huiebjaye2/Of9hxieaxc+fU/agEhyieadfif6/ggLhvidaviJgk/egQhricbgkfhK/VgUhnibcYmThl/HgV
					hlibc9nWhx+8]],
				["UpperLegB.L"] = [[
					fKhPgs71VqeWryfKhQgu7nV+eLshfKhSgv7JWjeSt8fKhVgw6bXRekvsfJhYgw5oX7e7xVfJhZgw4+YSfJybfIhYgw4iYQfOy/fIhXgv4GYFfWzffHhVgu3Y
					YCfo0VfHhVgs2QYRgG1pfHhVgr0mY5gw3afHhXgqxkaVhr6EfIhYgpweadh36yfIhZgp0kXbgv28fJhYgp3IVZf7zYfJhVgp5rTue+ukfKhSgq7hTPeEp+fK
					hQgr8OUFdwo8]],
				["LowerLegB.L"] = [[
					e+g5gS0Scyf24he+g4gVzqdXfx5Ge9g4gYzldvfs5Me9g4gdz0d5fk5Be9g5ghz6d/fc48e9g4gkzReQff5ee8g3glxrevfs6oe7g1glvlfPf777e7gzgntp
					figD87e7gygpsifbgE9be8gygusvewf/9Ue/g1g2vhdDfr70e/g4g4vAcvfu8Ee7g2gqmffff9/Ue6g4gfjGgVfW/1e7g7gUkWf/er/qe9hAgNp/erez+Ve+
					hAgNv3djfj7q]],
				["FootB.L"] = [[
					e6gggW/ifMgJlRe6gggb/jfkgFlRe6gggf/jfzgClRe6gggj/jf3gClRe6gggn/jf3gClRe6gggr/jgDf/lRe6gggv/jgff7lRe6gggz/ig6f2lRe6ggg3/i
					hHf0lRe6ggg7/ig/f1lRe6ggg//jgcf7lRe6gghD/ifFgKlRe6gjhG/ce2gOlxe6gshB/Kgvf1nNe6gzg4+7g+fwoHe6g0gt+4gYf6oWe6gxgh+/fpgGn6e6
					gqgZ/PfagIm1]],
				["UpperLegB.R"] = [[
					g5hVgs2Qnvf61pg5hVgr0mnHfQ3ag5hXgqxklreV6Eg4hYgpweljeJ6yg4hZgp0kolfR28g3hYgp3IqngFzYg3hVgp5rsShCukg2hSgq7hsxh8p+g2hQgr8O
					r7iQo8g2hPgs71qWhqryg2hQgu7nqCh1shg2hSgv7Jpdhut8g2hVgw6bovhcvsg3hYgw5ooFhFxVg3hZgw4+nug3ybg4hYgw4inwgyy/g4hXgv4Gn7gqzfg5
					hVgu3Yn+gY0V]],
				["LowerLegB.R"] = [[
					hFgygpsiglf89bhEgygusvhQgB9UhBg1g2vhi9gV70hBg4g4vAjRgS8EhFg2gqmfghgD/UhGg4gfjGfrgq/1hFg7gUkWgBhV/qhDhAgNp/hVhN+VhChAgNv3
					idgd7qhCg5gS0SjOgK4hhCg4gVzqipgP5GhDg4gYzliRgU5MhDg4gdz0iHgc5BhDg5ghz6iBgk48hDg4gkzRhwgh5ehEg3glxrhRgU6ohFg1glvlgxgF77hF
					gzgntpgef987]],
				["FootB.R"] = [[
					hGggg7/ifBgLlRhGggg//jfkgFlRhGgghD/ig7f2lRhGgjhG/chKfylxhGgshB/KfRgLnNhGgzg4+7fCgQoHhGg0gt+4fogGoWhGgxgh+/gXf6n6hGgqgZ/P
					gmf4m1hGgggW/ig0f3lRhGgggb/jgcf7lRhGgggf/jgNf+lRhGgggj/jgJf+lRhGgggn/jgJf+lRhGgggr/jf9gBlRhGgggv/jfhgFlRhGgggz/ifGgKlRhG
					ggg3/ie5gMlR]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAiDgoAEgAgAh1gAh6goADgDgVhhgAhzgoAHgEgiiUgAh4goALgDgijHgAiBgoAJgCgVi0gAiDgoAEgAgAh1gAh6goADf9frhhgAhzgoAHf8feiUgAh4goAL
					f9fejHgAiBgoAJf+fri0]],
				Spine1 = [[
					gAiFgUAGgAgAiMgAh7gUADgDgVhcf/h2gUAFgEgih6f/h7gVAKgDgii8gAiFgUALgCgVjHgAiFgUAGgAgAiMgAh7gUADf9frhcgBh2gUAFf8feh6gBh7gVAK
					f9fei8gAiFgUALf+frjH]],
				Spine2 = [[
					gAiIgBACgAgAhAf/h9gBABgCgVfzf/h4gBABgCgif7f/h/gBADgBgihNf/iJgBAFgCgVh3gAiIgBACgAgAhAgBh9gBABf+frfzgBh4gBABf+fef7gBh/gBAD
					f/fehNgBiJgBAFf+frh3]],
				Spine3 = [[
					gAiJfuADgAgAhXf/h9fuABgCgVfuf+h4fuACgBgifhf+iAfuACgBgihBf/iLfuAGgCgViKgAiJfuADgAgAhXgBh9fuABf+frfugCh4fuACf/fefhgCiAfuAC
					f/fehBgBiLfuAGf+friK]],
				Neck1 = [[
					gAiKfbBOgAgAotf+h9faAqgGgUmZf9h3fbAhgIghlof9iCfbA6gIghnff+iNfbBbgHgUpYgAiKfbBOgAgAotgCh9faAqf6fsmZgDh3fbAhf4fflogDiCfbA6
					f4ffnfgCiNfbBbf5fspY]],
				Neck2 = [[
					gAiee7C0gAgAtEf+iLe4BrgJgTqKf8iEe3BSgLggo4f8iTe6CAgMggrEf+ije8DEgJgTtngAiee7C0gAgAtEgCiLe4Brf3ftqKgEiEe3BSf1fgo4gEiTe6CA
					f0fgrEgCije8DEf3fttn]],
				Neck3 = [[
					gAi1emDwgAgAvAf9ieefCKgJgTrff7iUeeBigMggpsf8ineiCdgNgfsOf9i6epD/gLgSvcgAi1emDwgAgAvAgDieefCKf3ftrfgFiUeeBif0fgpsgEineiCd
					fzfhsOgDi6epD/f1fuvc]],
				Head = [[
					gAjfeKABgAgAgkf9jAd6AIgAgVdTf6iyd0ATf9gib2f6jKd/AEf+gieOf9jleOACgBgVhIgAjfeKABgAgAgkgDjAd6AIgAfrdTgGiyd0ATgDfeb2gGjKd/AE
					gCfeeOgDjleOACf/frhI]],
				Jaw = [[
					gAi0d5/0gAgAjPf8iSdy/VgCfrmef6iDdx/AgHffn4f6idd0/ggGfflkf8i6d7/4gBfrirgAi0d5/0gAgAjPgEiSdy/Vf+gVmegGiDdx/Af5ghn4gGidd0/g
					f6ghlkgEi6d7/4f/gVir]],
				Sock = [[
					ftl+dO17gAgA3TfolPcfxPhpgs65fkk4cNtoi3g48yfllfctwniuhH7LfpmGdY1lhdg43jftl+dO17gAgA3TfylPcfxPeXfU65f2k4cMtodJfI8yf1lfcrwn
					dSe57LfxmGdX1lejfI3j]],
				["UpperLegF.L"] = [[
					fJhifbsqavf086fHhVfgnLZ9cn+ZfGhPfixsYKbc5EfGhZfe2mYddl1NfHhlfb7zYvgZuEfJhifb7hYhgyudfKhVfe5IXgf7x4fLhPfex+X9eb5KfLhZfbvp
					ZRfj7EfKhlfZxFbPhP6m]],
				["LowerLegF.L"] = [[
					e9hHfz1ReUfg31e4hGgA+jdPicoweygxfs+Xacj7Yme2g3fa/mbwiPerfAhIfE8gcJeut9fChEfF8Qb5fDuZe/gzfQ8+a8fasle6gufn+VbMhpoye9g6fr5i
					c6gWzBfChDfnxkdEef6i]],
				["FootF.L"] = [[
					e6gsf3/NhDfxm7e6g3fo+1gqf0oge6g8fU+XbuhRpBe6g5e/+vefgbose7gzey+5fHf1oOe9gue0+0e3fQoee6gge8/heCgUlHe6ggfQ/jexgNlIe6ggfj/l
					gDgAlIe9gqfy+QfGfJqT]],
				["UpperLegF.R"] = [[
					g3hifb7hnffOudg2hVfe5IoggFx4g1hPfex+oDhl5Kg1hZfbvpmvgd7Eg2hlfZxFkxex6mg3hifbsqlRgM86g5hVfgnLmDjZ+Zg6hPfixsn2kk5Eg6hZfe2m
					njib1Ng5hlfb7znRfnuE]],
				["LowerLegF.R"] = [[
					g+hEfF8QkHg9uZhBgzfQ8+lEgmslhGgufn+Vk0eXoyhDg6fr5ijGfqzBg+hDfnxki8hh6ihDhHfz1Rhsgg31hIhGgA+jixdkowhOgxfs+XlkcFYmhKg3fa/m
					kQdxerhAhIfE8gj3hSt9]],
				["FootF.R"] = [[
					hDgue0+0hJgwoehGgge8/hh+fslHhGggfQ/jhPfzlIhGggfj/lf9gAlIhDgqfy+Qg6g3qThGgsf3/Ne9gPm7hGg3fo+1fWgMoghGg8fU+XkSevpBhGg5e/+v
					hhfloshFgzey+5g5gLoO]],
				Tail1 = [[
					gAiBhFikgAgA/4gBh5hFg9frgC/+gBhwhEhWfegD/9gBh0hEjMfef//1gBh+hEj8frf9/vgAiBhFikgAgA/4f/h5hFg9gVf+/+f/hwhEhWgif9/9f/h0hEjM
					gigB/1f/h+hEj8gVgD/v]],
				Tail2 = [[
					gAh+hblDgegA/lgAh3hbiZfegE/5gAhuhbhueqgJ/6gAhvhaj+eXgC/sgAh5hamBesf8/ZgAh+hblDfigA/lgAh3hbiZgif8/5gAhuhbhuhWf3/6gAhvhaj+
					hpf+/sgAh5hamBhUgE/Z]],
				Tail3 = [[
					gBh3hwmyhVgD/Pf/h0hyjwfwgF/xf+hshxhxeQgL/5f+hqhwjndbgB/rf+hwhvmtdlf4/Mf/h3hwmyerf9/PgBh0hyjwgQf7/xgChshxhxhwf1/5gChqhwjn
					ilf//rgChwhvmtibgI/M]],
				Tail4 = [[
					gDhtiFleiYgX/bf/hviIi1gdgL/3f8hqiIfyeUgE/8f6hliGglc1fu/1f7hniEkGclff/if9htiFledofp/bgBhviIi1fjf1/3gEhqiIfyhsf8/8gGhliGgl
					jLgS/1gFhniEkGjbgh/i]],
				Tail5 = [[
					gGhmiajdjXg6/ngAhrieh1hagh/5f5hqieeZe2gG/7f2hkicd5cvfc/vf2hiiZhBb7e8/sf6hmiajdcpfG/ngAhrieh1emff/5gHhqieeZhKf6/7gKhkicd5
					jRgk/vgKhiiZhBkFhE/s]],
				["UpperLegB.L"] = [[
					fJhigv6vX9hOvkfJhZgx5XYOg6x2fJhSgw59WbexwAfJhWgu1EY9f73BfJhgguvrbshV7hfJhigvupbThe8BfJhZgv1TV0f01lfIhRgs41SLeTukfIhWgr8T
					S3dVmifJhggs7hWef2tP]],
				["LowerLegB.L"] = [[
					fChDgc7Za0fovsfAg4gj5/a4fGx7e8g1geu5fBgN8Te9gzgwtzeffJ80fChBhAv7dFe+7kfBhEhDu6clfG8Fe5g4grgahHez/8e3g5gXeBh1c4/ue9hLgKsl
					eefb9Xe/hGgU5ia7f6yl]],
				["FootB.L"] = [[
					e9gugP+odefoo5e7ghga/WdRgWlxe6gggs/ig4f3lRe6gghA/jfwgDlRe9grhN9xelfNrle7gvhR+oeSgDpDe6g3hF+whRfpote6g8gx+mgxfxpUe6g5gb+u
					f+gAo6e6gugM/Adoglnf]],
				["UpperLegB.R"] = [[
					g3higvupktei8Bg3hZgv1TqMgM1lg4hRgs41t1htukg4hWgr8TtJirmig3hggs7hpigKtPg3higv6voDeyvkg3hZgx5XnyfGx2g3hSgw59plhPwAg3hWgu1E
					nDgF3Bg3hgguvrkUer7h]],
				["LowerLegB.R"] = [[
					g/hEhDu6jbg68FhHg4grgae5hN/8hJg5gXeBeLjI/uhDhLgKslhigl9XhBhGgU5ilFgGylg+hDgc7ZlMgYvshAg4gj5/lIg6x7hEg1geu5g/fz8ThDgzgwtz
					hhg380g+hBhAv7i7hC7k]],
				["FootB.R"] = [[
					hFgvhR+ohuf9pDhGg3hF+wevgXothGg8gx+mfPgPpUhGg5gb+ugCgAo6hGgugM/AiYfbnfhDgugP+oiigYo5hFghga/WivfqlxhGgggs/ifIgJlRhGgghA/j
					gQf9lRhDgrhN9xhbgzrl]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAh5goALgAgAjKgAh5gqAKgAgAjBgAh2gwAIgAgAipgAh0g4AGgAgAiLgAhxhAAEgAgAhwgAhwhEADgAgAhggAhxg1AEgAgAhzgAh1gEAIgAgAiogAh1f9AM
					gAgAjSgAh1f9ATgAgAkRgAh1f9AQgAgAj6gAh1f+ALgAgAjPgAh1gFAKgAgAjCgAh3gQALgAgAjIgAh4gcALgAgAjLgAh5glALgAgAjLgAh5goALgAgAjKgA
					h5goALgAgAjKgAh5goALgAgAjK]],
				Spine1 = [[
					gAh9gVALgAgAjKgAh8gXAKgAgAi+gAh6gdAHgAgAifgAh2glAEgAgAh2gAhzgsADgAgAhSgAhygxACgAgAg9gAhzgiADgAgAhYgAh4fxAIgAgAingAh5fqAM
					gAgAjSgAh6fqATgAgAkRgAh5fqAQgAgAj6gAh5frALgAgAjPgAh5fyAKgAgAjCgAh7f9ALgAgAjIgAh8gJALgAgAjLgAh9gSALgAgAjLgAh9gVALgAgAjKgA
					h9gVALgAgAjKgAh9gVALgAgAjK]],
				Spine2 = [[
					gAiBgBAEgAgAhmgAiAgEADgAgAhXgAh9gKACgAgAgwgAh5gSABgAgAf9gAh1gZACgAgAfPgAhzgdACgAgAe2gAh1gPABgAgAfagAh7feACgAgAhCgAh8fXAE
					gAgAhvgAh/fXAIgAgAitgAh+fXAHgAgAiWgAh8fYAEgAgAhrgAh9ffADgAgAhfgAh+fqADgAgAhlgAiAf2AEgAgAhogAiBf/AEgAgAhogAiBgBAEgAgAhmgA
					iBgBAEgAgAhmgAiBgBAEgAgAhm]],
				Spine3 = [[
					gAiDfuAEgAgAhmgAiBfxADgAgAhUgAh+f3ABgAgAglgAh5f/ABgAgAfogAh0gGADgAgAexgAhxgKAEgAgAeTgAh0f8ACgAgAe/gAh9fLACgAgAhBgAh/fDAE
					gAgAhvgAiCfEAIgAgAitgAiBfEAHgAgAiWgAh+fFAEgAgAhrgAh/fMADgAgAhfgAiAfXADgAgAhlgAiCfjAEgAgAhogAiDfsAEgAgAhogAiDfuAEgAgAhmgA
					iDfuAEgAgAhmgAiDfuAEgAgAhm]],
				Neck1 = [[
					gAiFfbA6gAgAnigAiDfdA0gAgAnGgAh+fjAlgAgAl9gAh4frAVgAgAkegAhzfzALgAgAjIgAhvf3AHgAgAiXgAhzfoAMgAgAjUgAh+e4AlgAgAl/gAiBewA7
					gAgAnlgAiFexBmgAgAp8gAiEexBVgAgApFgAiAexA5gAgAndgAiAe4AzgAgAnBgAiCfEA3gAgAnVgAiEfQA6gAgAnhgAiFfZA7gAgAnlgAiFfbA7gAgAnigA
					iFfbA6gAgAnigAiFfbA6gAgAni]],
				Neck2 = [[
					gAiWe6B0gAgAqmgAiTe8BogAgAqBgAiMfABLgAgAoggAiCfHAsgAgAmfgAh6fOAXgAgAkqgAh1fSAOgAgAjogAh7fEAYgAgAk1gAiMeVBEgAgAoIgAiSePB0
					gAgAqkgAiceTDVgAgAuMgAiYeRCugAgAs4gAiSeQBvgAgAqXgAiQeWBigAgApugAiTeiBsgAgAqPgAiVevB0gAgAqjgAiWe3B2gAgAqqgAiWe6B1gAgAqmgA
					iWe6B0gAgAqmgAiWe6B0gAgAqm]],
				Neck3 = [[
					gAipeiCEgAgArQgAilejBzgAgAqigAicemBNgAgAongAiPerAmgAgAmDgAiDexAPgAgAjugAh8e0AHgAgAiagAiEemAQgAgAj4gAibd6A/gAgAn2gAild3CC
					gAgArKgAi0eAEVgAgAwCgAivd9DZgAgAuTgAikd4B7gAgAq4gAiid+BogAgAqAgAileKB3gAgAqugAioeXCCgAgArMgAipegCGgAgArWgAipeiCEgAgArRgA
					ipeiCEgAgArQgAipeiCEgAgArQ]],
				Head = [[
					gAjKd8/ygAgAjogAjFd7/qgAgAkmgAi2d7/LgAgAnMgAiid8+OgAgAqegAiOd/9FgAgAtVgAiDeC8UgAgAu4gAiQd19JgAgAtLgAizdN+4gAgAoXgAjGdR/1
					gGfUjDgAjgdn/ggpedavgAjXde/4gZewdxgAjFdR/ygFfZjhgAjAdV/lgBfrlDgAjFdj/ugCfukFgAjJdw/ygBf1jigAjLd6/zgAf8jbgAjLd8/ygAgAjngA
					jKd8/ygAgAjogAjKd8/ygAgAjo]],
				Jaw = [[
					gAicd3/8gAgAh2gAiXd5/2gAgAi7gAiIeB/dgAgAlygAh2eM+lgAgApagAhmeX9bgAgAskgAheed8ogAgAuRgAhoeM9hgAgAsUgAiFdX/SgAgAmrgAiYdK/w
					gHfUjzgAi7dL/7g2ekfEgAiudJ/9ggeygzgAiWdM/vgFfZkAgAiSdU/rgBfrkggAiXdf/0gBfujWgAibdr/5gBf1iZgAidd0/8gAf8h3gAicd3/8gAgAh2gA
					icd3/8gAgAh2gAicd3/8gAgAh2]],
				Sock = [[
					ftlUcZ2ngAgA2nftlIcQ16gAgA3Tftkmb8z7gAgA5Cftj0boxIgAgA7BftjDbeudgAgA8iftimbcs6gAgA9RftjHbUslgAgA9aftkZbGpjgAgA+ifplTb0v3
					iHgi7sfjmIde5ikCiwypfll7c12djhhy2cfplPbwvbh6gd79frlBbmuphCgN8bfrlMb8yIg0gP6WfslTcO07gdgL4MftlWcY2dgKgE2yftlUcZ2pgAgA2mft
					lUcZ2ngAgA2nftlUcZ2ngAgA2n]],
				["UpperLegF.L"] = [[
					fJhdfb0vZdgA3dfJhbfe0tZPfz3bfJhWfm1WYtfc2rfJhQfw3EX8fL0ofJhLf65BXMfHx2fJhIf/6OWvfLvyfJhMfv22XLd00dfJhWe5q3ZgcW9JfJhZewvt
					Z2fP7LfJhdeux5aPf554fJhcevw+aFfo6dfJhYexvuZ0fO7KfJhYe5tXZleE8SfJhafEs7ZedK8YfJhcfQv9ZWeR63fJhdfZ0GZdf04BfJhdfb0wZdgA3dfJ
					hdfb0vZdgA3dfJhdfb0vZdgA3d]],
				["LowerLegF.L"] = [[
					e9g4fe7Ac5gAw2e8g3fh78cygUvPe7gyfm9kcSgzrne7gtfq+mbhg5oGe7gqfr+7a3gfmTe8gqfs+7ajgCmIe3gqfo/dafhygje4hAfT/FcGiZmAe7g5fB68
					d4gtxGe9g7e64idrfp0Ze8g6e95kdzgFzGe7g5fC7Fd2gww4e5g9fP9hdlhtr8e4hAfb+ycyiJnwe5g8fg+AdKhqqle9g5fe7ZdAgPwPe9g4fe7Ac5gAw3e9
					g4fe7Ac5gAw2e9g4fe7Ac5gAw2]],
				["FootF.L"] = [[
					e6ggfS/lgAgAlIe6ggfS/lgBgAlIe6ggfS/kfrgDlIe6ggfS/je6gLlIe6ggfS/heGgUlHe6ggfS/fdqgYlHe6gpfN/fdtgYlHe6g1e6/lf1gClIe6gge1/j
					hHf1lIe6gge1/kgkf6lIe6gge1/kg1f3lIe6gge2/jhGf1lIe6gqe7/jhKf0lIe6gzfC/kgff7lIe6grfK/kgvf4lIe6ggfQ/lgLf+lIe6ggfS/lgAgAlIe6
					ggfS/lgAgAlIe6ggfS/lgAgAlI]],
				["UpperLegF.R"] = [[
					g3hdfb0vmjgA3dg3hbfeo7l5ht+Gg3hWfmz1nLg44Cg3hQfwt4nFio70g3hLf60ooXiK24g3hIf/4zpKhVx+g3hMfv22o1iM0dg3hWe5q3mgjq9Jg3hZewvt
					mKgx7Lg3hdeux5lxgH54g3hcevw+l7gY6dg3hYexvumMgy7Kg3hYe5tXmbh88Sg3hafEs7mii28Yg3hcfQv9mqhv63g3hdfZ0GmjgM4Bg3hdfb0wmjgA3dg3
					hdfb0vmjgA3dg3hdfb0vmjgA3d]],
				["LowerLegF.R"] = [[
					hDg4fe7AjHgAw2hGhIf86OhQfGyQhGgzfr93jie0q3hJg1gE/Fj7dcl7hJgpf7/clIdzh1hGgofx/TlefIjphJgqfo/dlheOgjhIhAfT/Fj6dnmAhFg5fB68
					iIfTxGhDg7e64iiVgX0ZhEg6e95kiNf7zGhFg5fC7FiKfQw4hHg9fP9hibeTr8hIhAfb+yjOd3nwhHg8fg+Ai2eWqlhDg5fe7ZjAfxwPhDg4fe7AjHgAw3hD
					g4fe7AjHgAw2hDg4fe7AjHgAw2]],
				["FootF.R"] = [[
					hGggfS/lgAgAlIhGgtfy/heCgUlHhGghfW/lgDgAlIhGgqfr/lgKf+lIhGglff/ihrfvlHhGghfW/fiRfolHhGgpfN/fiTfolHhGg1e6/lgLf+lIhGgge1/j
					e5gLlIhGgge1/kfcgGlIhGgge1/kfLgJlIhGgge2/je6gLlIhGgqe7/je2gMlIhGgzfC/kfhgFlIhGgrfK/kfRgIlIhGggfQ/lf1gClIhGggfS/lgAgAlIhG
					ggfS/lgAgAlIhGggfS/lgAgAlI]],
				Tail1 = [[
					gAh1hEiIgAgA/7gAh1hHiIgAgA/7gAh0hNiIgAgA/7gAhyhViIgAgA/7gAhwhdiIgAgA/7gAhvhhiIgAgA/7gAhwhSiBgAgA/7gAhyghhgf1gB/9gAhwgZhV
					fTgE/9gAhvgZh2gAgA/8gAhvgZhfhFf6/8gAhxgagzhpf1/8gAhygignhcf2/9gAhzgtg3ggf9/+gAh0g5hQfogC/9gAh1hChqfggD/8gAh1hEh+f1gB/7gA
					h1hEiHgAgA/7gAh1hEiIgAgA/7]],
				Tail2 = [[
					gAhyhbicgAgA/5gAhyhdilgAgA/4gAhxhki9gAgA/2gAhvhsjbgAgA/zgAhthzj2gAgA/wgAhsh3kGgAgA/ugAhthpjmgAgA/ygAhwg4hwfsgC/8f/hvgwgv
					ePgM/7gAhsgvgxfCgI/9gChtgwgahMf7/9gChwgxfvizfs/3gChxg4fijFfn/1gBhyhEf8hvfx/8f/hyhQgrf7f///f/hzhYhgfRgE/8gAhzhbiKfrgC/6gA
					hyhbicgAgA/5gAhyhbicgAgA/5]],
				Tail3 = [[
					gAhvhxiDgAgA/7gAhuh0iUgAgA/6gAhsh6jDgAgA/2gAhqiCkAgAgA/vgAhoiJk2gAgA/ngAhmiNlVgAgA/igAhoh/kcgAgA/rf/huhOhQfngC/9f9huhGfa
					dOgR/3f/hrhGe+ddgV/3gDhthGeogUgJ/9gGhwhHd8jCfz/xgGhyhOdwkUfi/ngDhyhaeTjNfm/yf/hxhmfYgxf3/+f+hxhvgnfYgC/+f/hwhxhmflgC/8gA
					hvhxiCgAgA/7gAhvhxiDgAgA/7]],
				Tail4 = [[
					gAhsiIe8gAgA/+gAhriKfWgAgA//gAhoiQgdgAgA//gAhkiYh4gAgA/7gAhhifjLgAgA/1gAhfijj4gAgA/wgAhiiVimgAgA/4f/hshleDfogA/7f5huhdbb
					cof9/ef7hshcaib3gI/PgEhvhdaKewgY/bgLhzhdZgiQgW/PgMh1hkZWkrgG+8gIh0hwaBkZf5/HgAhyh9bZh3f4/mf9hwiFdBf0f9/2f/htiIeWfnf//8gA
					hsiIe8gAgA/+gAhsiIe8gAgA/+]],
				Tail5 = [[
					gAhuiebygAgA/tgAhsihcVgAgA/xgAhnindzgAgA/6gAhiiuftgAgA//gAhci1hbgAgA/9gAhZi5iYgAgA/5gAheirgsgAgA//f+hvh7a0fwf+/kf0h1hyXd
					cvfi+pf1h0hxWLa6fm+AgCh3hyVzdGgS+LgOh8hyVJgsgy+EgTh+h4VAj8g09xgOh8iEVzkxge98gDh5iSXbiwgH+sf9h0icZagaf9/Tf+hwiebDfvf9/mgA
					huiebygAgA/tgAhuiebygAgA/t]],
				["UpperLegB.L"] = [[
					fJhYgs4BXxgAzcfJhXgv4nXcf2yjfJhVg256WvfgwUfJhTg/7GWHfLt0fJhQhH7yVyfDsFfJhPhM8BVsfGrcfJhQg97NVqe8tOfJhUgKuZbZhM8LfJhTgBs4
					b6hD8+fJhTf/skcHg09JfJhTgAsrcCg59FfJhTgCtFb2hE84fJhUgKuabdhH8LfJhVgVyjZwgu5SfJhXgh2CYXgP15fJhYgq3qX3gCz8fJhYgs4BXxgAzcfJ
					hYgs4BXxgAzcfJhYgs4BXxgAzc]],
				["LowerLegB.L"] = [[
					e9g2gjwvd6gA7Me9g3gjw2d9gI7He9g3glxtdzga6je9g4gozodNgm5Ge+g5gt16cWgl3Ae+g5gx3Wbxgd1ce9g3glx7dpgu6YfBg2geupcne58OfBg4gZtF
					c+ey9AfBg4gXswdGen9KfBg4gYs4dDer9HfBg4gatSc7ey86fBg3geuqcqe18Ne+gzgetydqfM8we9g0gfuNeRfr8ne9g2giwCeDf87ne9g2gjwud6gA7Me9
					g2gjwvd6gA7Me9g2gjwvd6gA7M]],
				["FootB.L"] = [[
					e6gggu/jgAgAlRe6gggu/jgHf/lRe6gggu/jgOf+lRe6gggu/jf+gAlRe6gggu/jfZgHlRe6gggu/ie5gMlRe6gggu/jgTf9lRe7gigt/QeKgFmje8glgp+r
					eNfqo4e8gmgo+geNfkpde8gmgp+keNfnpPe8glgq+xeNfuoje7gigt/OeKgDmue6gggu/ifKgJlRe6gggu/jf8gBlRe6gggu/jgCgAlRe6gggu/jgAgAlRe6
					gggu/jgAgAlRe6gggu/jgAgAlR]],
				["UpperLegB.R"] = [[
					g3hYgs4BoPgAzcg3hXgv4nokgKyjg3hVg256pRggwUg3hTg/7Gp5g1t0g3hQhH7yqOg9sFg3hPhM8BqUg6rcg3hQg97NqWhEtOg3hUgKuZkne08Lg3hTgBs4
					kGe98+g3hTf/skj5fM9Jg3hTgAsrj+fH9Fg3hTgCtFkKe884g3hUgKuakje58Lg3hVgVyjmQfS5Sg3hXgh2Cnpfx15g3hYgq3qoJf+z8g3hYgs4BoPgAzcg3
					hYgs4BoPgAzcg3hYgs4BoPgAzc]],
				["LowerLegB.R"] = [[
					hDg2gjwviGgA7MhDg3gjw2iDf47HhDg3glxtiNfm6jhDg4gozoizfa5GhCg5gt16jqfb3AhCg5gx3WkPfj1chDg3glx7iXfS6Yg/g2geupjZhH8Og/g4gZtF
					jChO9Ag/g4gXswi6hZ9Kg/g4gYs4i9hV9Hg/g4gatSjFhO86g/g3geuqjWhL8NhCgzgetyiWg08whDg0gfuNhvgV8nhDg2giwCh9gE7nhDg2gjwuiGgA7MhD
					g2gjwviGgA7MhDg2gjwviGgA7M]],
				["FootB.R"] = [[
					hGgggu/jgAgAlRhGgggu/jf5gBlRhGgggu/jfygClRhGgggu/jgCgAlRhGgggu/jgnf5lRhGgggu/ihHf0lRhGgggu/jftgDlRhFgigt/Qh2f7mjhEglgp+r
					hzgWo4hEgmgo+ghzgcpdhEgmgp+khzgZpPhEglgq+xhzgSojhFgigt/Oh2f9muhGgggu/ig2f3lRhGgggu/jgEf/lRhGgggu/jf+gAlRhGgggu/jgAgAlRhG
					gggu/jgAgAlRhGgggu/jgAgAlR]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAh5goALgAgAjKgAh4gpAKgAgAi+gAh1guAIgAgAikgAhzgyAGgAgAiLgAhygzAFgAgAiDgAh1guAHgAgAihgAh6gnAPgAgAjygAh8gjAZgAgAk1gAh8gjAb
					gAgAlGgAh8gjAbgAgAlGgAh8gjAbgAgAlGgAh8gjAbgAgAlGgAh8gjAbgAgAlGgAh8gjAbgAgAlGgAh8gjAbgAgAlGgAh8gjAbgAgAlGgAh8gjAbgAgAlGgA
					h8gjAbgAgAlGgAh8gjAbgAgAlGgAh8gjAZgAgAk3gAh7glARgAgAkDgAh6gnAMgAgAjTgAh5goALgAgAjKgAh5goALgAgAjKgAh5goALgAgAjK]],
				Spine1 = [[
					gAh9gVALgAgAjKgAh8gWAJgAgAi5gAh4gbAGgAgAiRgAh1geAEgAgAhrgAh0ggADgAgAhggAh4gbAGgAgAiMgAh+gUARgAgAj8gAiCgRAdgAgAlUgAiCgQAh
					gAgAlpgAiCgQAhgAgAlpgAiCgQAhgAgAlpgAiCgQAhgAgAlpgAiCgQAhgAgAlpgAiCgQAhgAgAlpgAiCgQAhgAgAlpgAiCgQAhgAgAlpgAiCgQAhgAgAlpgA
					iCgQAhgAgAlpgAiCgQAhgAgAlpgAiCgRAegAgAlWgAiAgTAUgAgAkUgAh+gUAMgAgAjWgAh9gVALgAgAjKgAh9gVALgAgAjKgAh9gVALgAgAjK]],
				Spine2 = [[
					gAiBgBAEgAgAhmgAh/gDADgAgAhPgAh7gHABgAgAgagAh3gLABgAgAfngAh2gMABgAgAfYgAh7gIABgAgAgTgAiDgBAIgAgAijgAiIf+ATgAgAkQgAiJf+AX
					gAgAkpgAiJf+AXgAgAkpgAiJf+AXgAgAkpgAiJf+AXgAgAkpgAiJf+AXgAgAkpgAiJf+AXgAgAkpgAiJf+AXgAgAkpgAiJf+AXgAgAkpgAiJf+AXgAgAkpgA
					iJf+AXgAgAkpgAiJf+AXgAgAkpgAiIf+ATgAgAkSgAiFgAAKgAgAjBgAiCgBAEgAgAh1gAiBgBAEgAgAhmgAiBgBAEgAgAhmgAiBgBAEgAgAhm]],
				Spine3 = [[
					gAiDfuAEgAgAhmgAiBfwACgAgAhKgAh8f0ABgAgAgHgAh3f4ACgAgAfIgAh1f5ACgAgAe1gAh7f1ABgAgAf/gAiGfuAIgAgAiugAiNfsAXgAgAkvgAiPfsAc
					gAgAlNgAiPfsAcgAgAlNgAiPfsAcgAgAlNgAiPfsAcgAgAlNgAiPfsAcgAgAlNgAiPfsAcgAgAlNgAiPfsAcgAgAlNgAiPfsAcgAgAlNgAiPfsAcgAgAlNgA
					iPfsAcgAgAlNgAiPfsAcgAgAlNgAiNfsAYgAgAkxgAiIftAMgAgAjRgAiEfuAFgAgAh4gAiDfuAEgAgAhmgAiDfuAEgAgAhmgAiDfuAEgAgAhm]],
				Neck1 = [[
					gAiFfbA6gAgAnigAiCfdAwgAgAmzgAh8fhAbgAgAlDgAh2flAMgAgAjZgAh0fmAJgAgAi5gAh7fhAYgAgAk1gAiJfbBXgAgApKgAiTfaCagAgAsJgAiVfaCs
					gAgAs0gAiVfaCsgAgAs0gAiVfaCsgAgAs0gAiVfaCsgAgAs0gAiVfaCsgAgAs0gAiVfaCsgAgAs0gAiVfaCsgAgAs0gAiVfaCsgAgAs0gAiVfaCsgAgAs0gA
					iVfaCsgAgAs0gAiVfaCsgAgAs0gAiTfaCbgAgAsMgAiMfaBogAgAqBgAiGfbBBgAgAn8gAiFfbA6gAgAnigAiFfbA6gAgAnigAiFfbA6gAgAni]],
				Neck2 = [[
					gAiWe6B0gAgAqmgAiSe7BfgAgAplgAiHe9A1gAgAnKgAh+fAAZgAgAk1gAh7fBASgAgAkJgAiGe+AwgAgAm2gAiee8CpgAgAssgAite/EmgAgAwggAiwfAFI
					gAgAxWgAiwfAFIgAgAxWgAiwfAFIgAgAxWgAiwfAFIgAgAxWgAiwfAFIgAgAxWgAiwfAFIgAgAxWgAiwfAFIgAgAxWgAiwfAFIgAgAxWgAiwfAFIgAgAxWgA
					iwfAFIgAgAxWgAiwfAFIgAgAxWgAite/EpgAgAwkgAije8DKgAgAt0gAiYe6CBgAgArIgAiWe6B0gAgAqmgAiWe6B0gAgAqmgAiWe6B0gAgAqm]],
				Neck3 = [[
					gAipeiCEgAgArQgAijeiBngAgAp9gAiVeiAwgAgAm1gAiHejAQgAgAj0gAiDejAKgAgAi7gAiTeiArgAgAmbgAi0enDLgAgAt3gAjIexF7gAgAyhgAjMezGq
					gAgAzhgAjMezGqgAgAzhgAjMezGqgAgAzhgAjMezGqgAgAzhgAjMezGqgAgAzhgAjMezGqgAgAzhgAjMezGqgAgAzhgAjMezGqgAgAzhgAjMezGqgAgAzhgA
					jMezGqgAgAzhgAjMezGqgAgAzhgAjIexF+gAgAymgAi6epD4gAgAvPgAisejCVgAgAr7gAipeiCEgAgArQgAipeiCEgAgArQgAipeiCEgAgArQ]],
				Head = [[
					gAjKd8/ygAgAjogAjBd5/hgAgAlagAiqdz+hgAgAplgAiTdy9EgAgAtWgAiMdy8jgAgAubgAindz+WgAgBqGgAjceH//gAgAflgAj4eg/IgYfQYsgAj9em+R
					ffg1VtgAj9em+ggAgAWYgAj9em+tgefKXFgAj9em+Rffg1VtgAj9em+ggAgAWYgAj9em+tgefKXFgAj9em+Rffg1VtgAj9em+ggAgAWYgAj9em+tgefKXFgA
					j9em+Rffg1VtgAj9em+ggAgAWYgAj4eg/GgYfPYkgAjleN/2f3gbdGgAjPd+/4gAgAimgAjKd8/ygAgAjogAjKd8/ygAgAjogAjKd8/ygAgAjo]],
				Jaw = [[
					gAicd3/8gAgAh2gAiTd5/wgAgAj1gAh9eA+3gAgAocgAhreJ9ZgAgAsogAhleM82gAgAt1gAh6eB+qgAgBpJgAiwd3/8gAgAhngAjXd//+gifWfkgAjkeA/5
					fTgrdygAjieB/9gAgAeggAjgeC/9grfUfOgAjkeA/5fTgrdygAjieB/9gAgAeggAjgeC/9grfUfOgAjkeA/5fTgrdygAjieB/9gAgAeggAjgeC/9grfUfOgA
					jkeA/5fTgrdygAjieB/9gAgAeggAjYd//+gifWfjgAi8d2//f1gaf+gAihd3/8gAgAhmgAicd3/8gAgAh2gAicd3/8gAgAh2gAicd3/8gAgAh2]],
				Sock = [[
					ftlUcZ2ngAgA2nftk/cH1TgAgA33ftkFbkx7gAgA6fftjHbQucgAgA8jfti0bNtXgAgA9Eftj9bhxif9f/6wftl6dK6ggAgAx5fomhes+fhxjJo/fzmifR/S
					eccNlOftmjfL/ZgAgAmHfnmjfE/BhvjumpfzmifR/SeccNlOftmjfL/ZgAgAmHfnmjfE/BhvjumpfzmifR/SeccNlOftmjfL/ZgAgAmHfnmjfE/Bhvjumpfz
					mifR/SeccNlOftmjfL/ZgAgAmHfomheu+ihxjMozfwmLdp8BesehvTftlfck3ogAgA1kftlUcZ2ngAgA2nftlUcZ2ngAgA2nftlUcZ2ngAgA2n]],
				["UpperLegF.L"] = [[
					fJhdfb0vZdgA3dfJhafe0TZMfr3wfJhUfl0VYofK3jfJhOfr1IYBez2nfJhMft1dX0et2PfJhTfm0bYifG3cfJhhfY1sZwgP2rfJhrfS2najgt18fJhufR2i
					argr2EfJhufR2iargr2EfJhufR2iargr2EfJhufR2iargr2EfJhufR2iargr2EfJhufR2iargr2EfJhufR2iargr2EfJhufR2iargr2EfJhufR2iargr2EfJ
					hufR2iargr2EfJhufR2iargr2EfJhsfS2nahgp18fJhkfWvgZmdi7IfJhefawQZQd36ofJhdfb0rZcf+3gfJhdfb0vZdgA3dfJhdfb0vZdgA3d]],
				["LowerLegF.L"] = [[
					e9g4fe7Ac5gAw2e8g2fi8Rczghune6gxfo+EcQhPqNe5grfr+8bkhlmpe5gqfs/GbWholse6gwfo+PcJhTpme+g9fY5qc7fVy1fBhGfQ3IdDeW12fBhIfP3C
					dKeU19fBhIfP3CdKeU19fBhIfP3CdKeU19fBhIfP3CdKeU19fBhIfP3CdKeU19fBhIfP3CdKeU19fBhIfP3CdKeU19fBhIfP3CdKeU19fBhIfP3CdKeU19fB
					hIfP3CdKeU19fBhIfP3CdKeU19fBhGfP3IdBeS11e5hGfn+ndLhsoqe5g/fp+tcyh2oMe9g4fe7Fc5gCwwe9g4fe7Ac5gAw2e9g4fe7Ac5gAw2]],
				["FootF.L"] = [[
					e6ggfS/lgAgAlIe6ggfS/lgFf/lIe6ggfS/kfvgDlIe6ggfS/kfGgJlIe6ggfS/je3gMlIe6ggfS/kfqgElIe6gifQ/lf0gClIe7grfO/NfjfqnCe7gtfN/F
					fqfjnge7gtfN/Ffqfjnge7gtfN/Ffqfjnge7gtfN/Ffqfjnge7gtfN/Ffqfjnge7gtfN/Ffqfjnge7gtfN/Ffqfjnge7gtfN/Ffqfjnge7gtfN/Ffqfjnge7
					gtfN/Ffqfjnge7gtfN/Ffqfjnge7grfO/Ufhfymge6g3fP/kgxf4lIe6gxfR/kgbf8lIe6ggfS/lgBgAlIe6ggfS/lgAgAlIe6ggfS/lgAgAlI]],
				["UpperLegF.R"] = [[
					g3hdfb0vmjgA3dg3hafe0Tm0gV3wg3hUfl0VnYg23jg3hOfr1In/hN2ng3hMft1doMhT2Pg3hTfm0bneg63cg3hhfY1smQfx2rg3hrfS2nldfT18g3hufR2i
					lVfV2Eg3hufR2ilVfV2Eg3hufR2ilVfV2Eg3hufR2ilVfV2Eg3hufR2ilVfV2Eg3hufR2ilVfV2Eg3hufR2ilVfV2Eg3hufR2ilVfV2Eg3hufR2ilVfV2Eg3
					hufR2ilVfV2Eg3hufR2ilVfV2Eg3hsfS2nlefW18g3hkfWxSmYhh6Hg3hefaxlmthY51g3hdfb0tmjgB3fg3hdfb0vmjgA3dg3hdfb0vmjgA3d]],
				["LowerLegF.R"] = [[
					hDg4fe7AjHgAw2hEg2fi8RjNffunhGgxfo+EjwexqNhHgrfr+8kcebmphHgqfs/GkqeYlshGgwfo+Pj3etpmhCg9fY5qjFgry1g/hGfQ3Ii9hq12g/hIfP3C
					i2hs19g/hIfP3Ci2hs19g/hIfP3Ci2hs19g/hIfP3Ci2hs19g/hIfP3Ci2hs19g/hIfP3Ci2hs19g/hIfP3Ci2hs19g/hIfP3Ci2hs19g/hIfP3Ci2hs19g/
					hIfP3Ci2hs19g/hIfP3Ci2hs19g/hGfP3Ii+ht11hGhDfj9Vife7sfhGg9fm9ui6eqrYhDg4fe7DjHf/wyhDg4fe7AjHgAw2hDg4fe7AjHgAw2]],
				["FootF.R"] = [[
					hGggfS/lgAgAlIhGggfS/lf7gBlIhGggfS/kgRf9lIhGggfS/kg6f3lIhGggfS/jhJf0lIhGggfS/kgWf8lIhGgifQ/lgMf+lIhFgrfO/NgdgWnChFgtfN/F
					gWgdnghFgtfN/FgWgdnghFgtfN/FgWgdnghFgtfN/FgWgdnghFgtfN/FgWgdnghFgtfN/FgWgdnghFgtfN/FgWgdnghFgtfN/FgWgdnghFgtfN/FgWgdnghF
					gtfN/FgWgdnghFgtfN/FgWgdnghFgrfO/RgegSmvhGgvfP/kfEgKlIhGgqfR/kfZgGlIhGggfS/lf/gAlIhGggfS/lgAgAlIhGggfS/lgAgAlI]],
				Tail1 = [[
					gAh1hEiIgAgA/7gAh1hGh0gAgA/8gAhyhLhFgAgA/+gAhwhPgZgAgA//gAhwhQgMgAgA//gAhyhLhAgAgA/+gAh1hDjTfmgB/0gAh1hAlQgQgB/jgAh1g/lu
					g+gD/dgAh1g/lufOf+/dgAh1g/lufcf+/egAh1g/luhFgD/dgAh1g/lugAgA/egAh1g/lue7f9/dgAh1g/lugkgC/egAh1g/lugygC/dgAh1g/lufCf9/dgA
					h1g/lufuf//egAh1g/luhHgD/dgAh1hAlSfwf//jgAh1hCjzfjgA/wgAh1hEiZgEgA/5gAh1hEiIgAgA/7gAh1hEiIgAgA/7gAh1hEiIgAgA/7]],
				Tail2 = [[
					gAhyhbicgAgA/5gAhyhdiAgAgA/7gAhxhhg9gAgA/+gAhwhlf+gAgA//gAhwhnfsgAgA//gAhxhig2gBgA/+f/hwhZkLfQgC/tgAhuhVnAf6f+/NgBhthUnq
					iFgF+/f/hthUnrfCgA/Cf/hthUnrebf7/BgChthUnrhygD/AgAhthUnrgqgE/Df+hthUnqd5f7+/gBhthUnrgcf//DgBhthUnqh5gG/Af/hthUnrelf+/BgA
					hthUnre2f7/CgChthUnqiBgE+/gAhuhVnDgGgC/Nf/hwhYk4fDgB/mgAhyhai2gFgA/3gAhyhbicgAgA/5gAhyhbicgAgA/5gAhyhbicgAgA/5]],
				Tail3 = [[
					gAhvhxiDgAgA/7gAhvhzhegAgA/9gAhwh4gHgAgA//gAhwh8e1gAgA/+gAhwh9edgAgA/9gAhwh4f+gCgA//f+hqhvkVfIgC/rgAhkhqoBfGf4+9gEhihoo4
					i5gI+mf+hihoo5figH+uf9hihoo4dWf0+ngEhihoo5h1f/+rgBhihoo5htgN+rf8hihoo4dSf7+ngBhihoo5ftf2+ugEhihoo4i4gK+mf9hihoo5e0gE+tf+
					hihoo5dwfz+pgEhihoo5iXgC+pgAhkhpoFg6gI+8f+hphtlQeqgB/hgAhuhxilgCgA/4gAhvhxiDgAgA/7gAhvhxiDgAgA/7gAhvhxiDgAgA/7]],
				Tail4 = [[
					gAhsiIe8gAgA/+gAhtiKePgAgA/8gAhviOckgAgA/zgAhyiTbAgAgA/mgAhyiUaigAgA/hgAhwiPcZgCgA/yf9hkiFhyfQf//7f/hZh9mZeLfk/SgIhWh7ng
					jHgV+8f9hWh7nggfgZ/Ff5hWh7ngcqfe+6gGhWh7nghQf5/EgDhWh7ngitgm++f4hWh7ngdWf0+/gBhWh7ngerfh/EgIhWh7ngjWgc+6f7hWh7ngfmgR/Gf7
					hWh7ngc3fb+8gIhWh7ngiBgC/CgBhZh9mfh2gc/Rf8hiiDi8ejf6/0gAhqiHfmf9gA//gAhsiIe8gAgA/+gAhsiIe8gAgA/+gAhsiIe8gAgA/+]],
				Tail5 = [[
					gAhuiebygAgA/tgAhwiga9gAgA/lgAh0ilZAgAgA/NgAh5ioXMgAgA+wgAh6ipWqgAgA+mgAh1ilYzgDgA/Kf8hiicfLflgA/+f8hQiSkudhfL/igNhMiOmD
					irgR/Tf+hMiPmChdg5/Xf1hMiOmDclfR/OgIhMiPmCgVff/agHhMiPmDjRhA/Of0hMiPmCd/gA/Wf/hMiPmDdyfA/UgMhMiOmDjKgh/Qf7hMiPmCgmgv/Zf2
					hMiPmDcjfG/NgKhMiPmChNfv/ZgEhQiSk0ihg2/gf6heiZgjexf3/9gAhrieckf4f//zgAhuiebygAgA/tgAhuiebygAgA/tgAhuiebygAgA/t]],
				["UpperLegB.L"] = [[
					fJhYgs4BXxgAzcfJhXgv4pXXf0yffJhUg051WkfawVfJhRg56tV8fEubfJhRg667Vye+t4fJhUg15+WefWwCfJhYgq3mYFgA0GfJhagl1vZRgX2efJhagk1M
					Zngd3GfJhagk1MZngd3GfJhagk1MZngd3GfJhagk1MZngd3GfJhagk1MZngd3GfJhagk1MZngd3GfJhagk1MZngd3GfJhagk1MZngd3GfJhagk1MZngd3GfJ
					hagk1MZngd3GfJhagk1MZngd3GfJhagl1sZTgX2hfJhZgo2/YegK07fJhYgs34X4gBzrfJhYgs4BXxgAzcfJhYgs4BXxgAzcfJhYgs4BXxgAzc]],
				["LowerLegB.L"] = [[
					e9g2gjwvd6gA7Me9g2giwfeDgJ7We8g2giwaeKgb7Ze8g3gjwzeCgn7Je8g3gjxAd+gq7Be8g2giwbeKgd7Ye9g2giwhd/f17Ue+g3gkxeddfS6qe/g3glx7
					dPfI6Ve/g3glx7dPfI6Ve/g3glx7dPfI6Ve/g3glx7dPfI6Ve/g3glx7dPfI6Ve/g3glx7dPfI6Ve/g3glx7dPfI6Ve/g3glx7dPfI6Ve/g3glx7dPfI6Ve/
					g3glx7dPfI6Ve/g3glx7dPfI6Ve+g3gkxgdcfR6pe+g2gjw1d0fq7He9g2gjwud6f97Me9g2gjwvd6gA7Me9g2gjwvd6gA7Me9g2gjwvd6gA7M]],
				["FootB.L"] = [[
					e6gggu/jgAgAlRe6gggu/jgMf+lRe6gggu/jgcf7lRe6gggu/jgff7lRe6gggu/jgef7lRe6gggu/jgdf7lRe6gggu/jf8gBlRe6gggu/ifQgIlRe6gggu/i
					fAgLlRe6gggu/ifAgLlRe6gggu/ifAgLlRe6gggu/ifAgLlRe6gggu/ifAgLlRe6gggu/ifAgLlRe6gggu/ifAgLlRe6gggu/ifAgLlRe6gggu/ifAgLlRe6
					gggu/ifAgLlRe6gggu/ifAgLlRe6gggu/ifOgIlRe6gggu/jftgDlRe6gggu/jf+gAlRe6gggu/jgAgAlRe6gggu/jgAgAlRe6gggu/jgAgAlR]],
				["UpperLegB.R"] = [[
					g3hYgs4BoPgAzcg3hXgv4popgMyfg3hUg051pcgmwVg3hRg56tqEg8ubg3hRg667qOhCt4g3hUg15+pigqwCg3hYgq3mn7gA0Gg3hagl1vmvfp2eg3hagk1M
					mZfj3Gg3hagk1MmZfj3Gg3hagk1MmZfj3Gg3hagk1MmZfj3Gg3hagk1MmZfj3Gg3hagk1MmZfj3Gg3hagk1MmZfj3Gg3hagk1MmZfj3Gg3hagk1MmZfj3Gg3
					hagk1MmZfj3Gg3hagk1MmZfj3Gg3hagl1smtfp2hg3hZgo2/nif207g3hYgs34oIf/zrg3hYgs4BoPgAzcg3hYgs4BoPgAzcg3hYgs4BoPgAzc]],
				["LowerLegB.R"] = [[
					hDg2gjwviGgA7MhDg2giwfh9f37WhEg2giwah2fl7ZhEg3gjwzh+fZ7JhEg3gjxAiCfW7BhEg2giwbh2fj7YhDg2giwhiBgL7UhCg3gkxeijgu6qhBg3glx7
					ixg46VhBg3glx7ixg46VhBg3glx7ixg46VhBg3glx7ixg46VhBg3glx7ixg46VhBg3glx7ixg46VhBg3glx7ixg46VhBg3glx7ixg46VhBg3glx7ixg46VhB
					g3glx7ixg46VhBg3glx7ixg46VhCg3gkxgikgv6phCg2gjw1iMgW7HhDg2gjwuiGgD7MhDg2gjwviGgA7MhDg2gjwviGgA7MhDg2gjwviGgA7M]],
				["FootB.R"] = [[
					hGgggu/jgAgAlRhGgggu/jf0gClRhGgggu/jfkgFlRhGgggu/jfhgFlRhGgggu/jfigFlRhGgggu/jfjgFlRhGgggu/jgEf/lRhGgggu/igwf4lRhGgggu/i
					hAf1lRhGgggu/ihAf1lRhGgggu/ihAf1lRhGgggu/ihAf1lRhGgggu/ihAf1lRhGgggu/ihAf1lRhGgggu/ihAf1lRhGgggu/ihAf1lRhGgggu/ihAf1lRhG
					gggu/ihAf1lRhGgggu/ihAf1lRhGgggu/igyf4lRhGgggu/jgTf9lRhGgggu/jgCgAlRhGgggu/jgAgAlRhGgggu/jgAgAlRhGgggu/jgAgAlR]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAh5goALgAgAjKgAh/goAigBgdlugAh5goApgAhEmMgAiQgoA4f+hEnSgAikgoBBf+gqn6gAirgoBEgAgAoGgAikgoBBgCfWn6gAiQgoA4gCe8nSgAh5goAp
					gAe8mMgAh9goAsgAfWmggAh8goArgAgAmbgAiZgoA8f+gqnngAiogoBEf8hEoBgAiqgoBEf8hEoEgAidgoA+f+gqnugAiDgoAvgAgAmwgAh8goArgAfWmbgA
					iDgoA0gCe8m/gAiAgoAngAfNmDgAh8goASf/f2kIgAh5goALgAgAjK]],
				Spine1 = [[
					gAh9gVALgAgAjKf/iGgVAhgAgdlpf/iBgWAif/hElpf/iYgWA6f+hEnaf/itgXBIf+gqoWgAi1gXBNgAgAoogBitgXBIgCfWoWgBiYgWA6gCe8nagBiBgWAi
					gBe8logBiFgWAogBfWmLgAiEgWAmgAgAmBf/iigWBBf/gqn6f/iygXBMf9hEohf/izgXBNf9hEolf/ingWBEf/gqoFgAiLgWAsgAgAmjgBiEgWAmgBfWmBgB
					iLgWAzgCe8m/gBiIgWAngAfNmDgAiBgVASf/f2kIgAh9gVALgAgAjK]],
				Spine2 = [[
					gAiBgBAEgAgAhmf/iMgDASf/gdkCf9iHgDAPf6hEjif9ihgFAmf7hEmAf+i3gGA3f9gqnRgAi/gGA9gAgAnqgCi3gGA3gDfWnRgDihgFAmgFe8mAgDiHgDAP
					gGe8jigCiMgEAUgDfWkTgAiLgEASgAgAkFf+isgFAvf9gqmsf9i8gGA7f7hEnhf9i9gGA9f7hEnmf+iwgFAyf9gqm7gAiTgEAYgAgAk0gCiLgEASgDfWkFgD
					iTgEAggFe8lcgCiPgEAWgCfNkhgAiGgCAIgAf2ikgAiBgBAEgAgAhm]],
				Spine3 = [[
					gAiDfuAEgAgAhmf+iRfxARf/gdj9f8iMfxALf5hEi/f8iofzAof7hEmIf+i/f1A+f+gqnugAjIf1BFgAgAoNgCi/f1A+gCfWnugEiofzAogFe8mIgEiMfxAL
					gHe8i+gCiRfxARgEfWj9gAiQfxAPgAgAjsf+i0f0Azf9gqm/f8jFf1BEf8hEoBf8jGf1BFf8hEoIf+i4f0A3f9gqnRgAiZfyAWgAgAkngCiQfxAPgEfWjsgE
					iafyAggFe8lbgDiUfxAWgCfNkhgBiJfvAIgAf2ikgAiDfuAEgAgAhm]],
				Neck1 = [[
					gAiFfbA6gAgAnif+iWfeBOgDgdotf7iPfeA3gChEnQf7iwfhB4gFhEqrf9jIfkCpgEgqssgAjRfkC7gAgAtUgDjIfkCpf8fWssgFiwfhB4f7e8qrgFiPfeA3
					f+e8nPgDiWffBGf+fWoNgAiUfeBBgAgAn8f9i8fiCQgEgqruf7jOfkC1gIhEtFf7jQfkC5gIhEtNf9jBfjCZgEgqsGgAieffBTgAgAo+gDiUfeBBf+fWn8gF
					igfgBhf8e8pogEiaffBXf7fNpJgBiMfcBDf+f2oEgAiFfbA6gAgAni]],
				Neck2 = [[
					gAiWe6B0gAgAqmf9ipe+B2gFgdqpf5ige8BQgGhEouf5jHfECkgJhDsdf8jkfKDtgIgpu4gAjufMEHgAgAvrgEjkfKDtf4fXu4gHjHfECkf3e9sdgHige8BP
					f6e8otgFipe+Bhf8fWpqgAime9BbgAgApZf8jVfHDHgHgpttf5jqfLD+gNhDvYf5jsfMEEgNhDvif8jbfIDVgHgpuKgAiyfAB0gAgAqjgFime9Bcf8fWpZgH
					i2fCCBf5e8rEgGiue/B+f4fOq/gBiee7B3f9f2qugAiWe6B0gAgAqm]],
				Neck3 = [[
					gAipeiCEgAgArQf8i9emBsgFgdqOf3iweiBAgEhEnyf3jdevCWgIhDr7f7j9e5DrgIgpu2gAkIe8EMgAgAvzgFj9e5Drf4fXu2gJjdevCWf4e9r7gJiweiA/
					f8e8nxgGi6elBPf9fWovgAi3ekBKgAgAoef6jte0C+gGgqtZf3kEe7EBgNhDvcf3kGe8EHgNhDvof7jze2DOgHgpt9gAjFeoBjgAgApwgGi3ekBKf9fWoegJ
					jKeqBsf7e8qKgHjCeoByf4fOqdgBixekB+f9f2q/gAipeiCEgAgArQ]],
				Head = [[
					gAjKd8/ygAgAjof7jbd+/xhQfsjjfzjId2/XjCfKlcf0kAeK/1i7ffhIf5knec/4hvf1d/gAkzei/2gAgAc8gHknec/4eRgLd/gMkAeK/1dFghhIgNjId2/X
					c+g2ldgIjVd6/meJgfkjgAjRd4/ngAgAk3f5kUeT/8hxfwfmf1kveg/wixfydQf1kxeh/viwfzdCf5kbeW/7hwfye/gAjjd+/zgAgAjigIjRd5/keJgfk1gM
					joeC/tdBgqjBgJjheA/wdzghjJgCjSd9/zfkgHjfgAjKd8/ygAgAjo]],
				Jaw = [[
					gAicd3/8gAgAh2f+itd5/ehRfylkf8iad2+hjHfhpFf8jUd+/fi9f1k2f9j9eH/5hvgChugAkLeL//gAgAgrgDj9eH/5eRf+hugEjUd+/fdDgLk2gEiad2+g
					c5gfpFgDind4+3eGgQoNgAijd3+1gAgAoif9joeD/xhyf+jVf8kGeJ/2ixgHg/f8kJeK/3iwgIgxf9jweE/0hxf/iugAi1d5/KgAgAnOgDijd3+yeGgRoegE
					i7d7/Ic+gTmsgDi0d6/cdxgWlfgBikd4/1fkgIjFgAicd3/8gAgAh2]],
				Sock = [[
					ftlUcZ2ngAgA2nfblkcc0wkNjT3wfBk/cGyan+lX4VfDmSc/4amomdyffUnHdv9XjIkYrfftnZeA+1gAgAojgGnLdu9Xc4borfgYmYc+4aZYZjyfgalFcDyZ
					YCap4WgIlacPz7bKch4TftlTcL1ugAgA3ffTmvdW8PjgkPt/fFnOd69okhnGoofGnRd+9NkunJp3fUm4df69jtkRwRftltcc1RgAgA35gIlUcL0MbKci4FgZ
					l2ck2wY3Z60bgNlvch39ZxaJzZfzldcb4Cc6cw0oftlUcZ2ngAgA2n]],
				["UpperLegF.L"] = [[
					fJhdfb0vZdgA3dfGhufayVaAeN5dfEhnfezyZ5cw4KfEiIfazga+eZ4zfFijfX4ObfgR0afJisfU3ka8gO1CfMikfS3JZ+f31QfOiKfSxvY4da5hfOhofXvw
					YGaj6IfMhvfXwSY1cC6SfJhsfZx/ZWdc5efFiVfX4PbWgd0WfDiofY4ZcFgi0UfDiqfY2HbrfZ2tfFiafXyxayd85SfJh3fYw+Zmcd6GfMhtfXwdYvcL6LfO
					h6fT07YxfF3FfMhzfV2/ZMga1LfJhkfZ1aZcgE22fJhdfb0vZdgA3d]],
				["LowerLegF.L"] = [[
					e9g4fe7Bc5gAw2e5hMfk+qd/hkowe0hEfk/Vc7jJbUe4hlfh+rfahko6e/h+fP4neFeJ0RfBiHfP4BdgeB04fCh/fO3tcidl1De9hqfd9Kb9gIsie4hMfm++
					YKhhf8e5hRfl/Saphgjte5hLfk/Nclhrl9e/hwfQ4pd+eT0Oe+iDfQ4uerec0Me7iFfY7tfbfyv+e5h4fh+dfChRpoe4hXfl/lcJh4ixe5hPfl/Qaphjj3fA
					hXfV6Ub2e4xrfChOfQ3qb1eD1Be+g/fa6LcrfeyEe9g4fe7Ac5gAw2]],
				["FootF.L"] = [[
					e6ggfS/lgAgAlIe6g9fM/ihjfwlHe6hMfK/kgqf5lIe6hWfK/Hi4fXm2e6hjfK+pg3fspHe8hsfL98gTfYrQe7hlfK+efRf8pte6hWfK/OfKgMm4e6hMfK/K
					a8g1lEe6hKfK/geAgVlHe6hBfK/lgKf+lIe7hVfK+zgufooke7hofL+LhffQqfe6hsfK+dicfQpde6hofK+0iYfXoOe6hSfK/efmgFlve6hIfK/heBgVlHe6
					g9fK/jetgNlIe7g0fM/TeVf8mZe6gmfQ/kfpgElIe6ggfS/lgAgAlI]],
				["UpperLegF.R"] = [[
					g3hdfb0vmjgA3dg1hufW1ymvgL2cgyhofXyGn7iL5EgyiKfS0InHhY3yg0ikfSx1mXiu5pg3isfUxUlpjB6Ig7ijfXyylJiF5Tg8iIfa1Ik2g23hg8hmfe0X
					lphP3+g6hufb0hlyhD31g3hsfZx/mqik5eg0iXfTxHmgjD6DgyiqfRwpmojh6RgyisfRytmsiZ49g0icfT3LmJgG1Lg3h3fY1PmQgt3Fg6hsfbzul7hf4cg8
					h4faz9lIhX4cg7hyfayuljhr5Sg4hkfazlmVgt4fg3hdfb0vmjgA3d]],
				["LowerLegF.R"] = [[
					hDg4fe7BjHgAw2hBhKfW57jng9yXhEhHfg9yk9fMqjhBhnfX69j9g5wvhEiDfe9YjBf4sThGiMfh+niBfEpBhHiAfg+Xg3e0p9hGhjfd9NgvfXtBhIhDfj/E
					hheRnThGhKff99h0fArDhHhLfk/NjbeVl9hFh3fg+DjXffqahDiLff9tj2gCrQhCiKfZ7+jfguvHg+h3fO3wjkiY0/hDhTfZ8BivgHvMhHhJfi+wh8egochI
					hUfh+fgyelpihIhPfk+yhUeUodhFhAfh8likfXuHhDg4fe7AjHgAw2]],
				["FootF.R"] = [[
					hGggfS/lgAgAlIhGgwfM/kgwf4lIhGg2fK/ihifwlIhGhPfK/Og9fym4hGhwfK+uf4gCo6hGh9fK+fezgYplhGhwfK+odkgto4hGhPfK/Jdggjm2hGg2fK/g
					d4gWlHhGg4fK/ieagRlHhGhBfK/lf2gClIhGhmfK/BgKf+n2hGh5fK+lgvfypWhGhzfK+jgaf4pehFhcfK+sg4gAo9hGg7fK/efogElvhGg6fK/ieYgRlHhG
					hFfK/ddRgclHhGhBfM/fdugYlHhGgqfQ/kfQgIlIhGggfS/lgAgAlI]],
				Tail1 = [[
					gAh1hEiIgAgA/7gBh2hDkri9gD/ggChwhDlGlSgK/IgCiFhCm1icgH/KgBiYhCoOeCf7+2gAiehCoobjf1+ff/iYhCoMcvf3+wf+iFhCm3gUgB/Pf+hwhDlJ
					jLgG/af/hzhDlei9gI/YgAhyhDlZgAgA/igBiOhCngdDf3+9gCichCofc1f4+rgCidhCoofsf/+zgBiShCnwjRgJ+3gAh5hDl4kdgM/If/hyhDlZh+gF/ef+
					h4hCl9dkf3/Vf/h4hDk/cCf6/WgAh2hEjGe8gC/0gAh1hEiIgAgA/7]],
				Tail2 = [[
					gAhyhbicgAgA/5gFhwhZk+kbgB/SgJhphXlPpmgM+EgFh7hXnplegN+lf+iMhVp1dNf++Uf6iThUqTXnfy9Gf6iNhVpqY4fw9qf/h7hXnwfxf+/CgDhphYlY
					mZgI+4gDhshYlqnSgO+ogAhrhYlth6gD/af9iEhWoqa7f2+Xf+iQhVqGYefu9agBiShVqccpfx+DgGiHhWpHkHgD+ZgGhxhXmPoagR+OgChrhYlol2gK+8f7
					hwhXmSeIf7/Tf5hxhYlQZof6+6f+hyhajad2gG/vgAhyhbicgAgA/5]],
				Tail3 = [[
					gAhvhxiDgAgA/7gLhphtklkngF/UgWhihpkptHgb8zgNhxhpnopfgi9lf7h/hnqxeTgM+FfviGhjrPU7fu70fxiAhlqPUpfa8Gf+hxhrn6dYfx+4gLhihsk7
					oAgQ+lgNhkhrlEragf9dgDhjhtlQlUgN/Gf2h4hopLapf6+Lf0iDhkq4U5ff79f9iEhmrXYmfU89gLh7hopzjBf2+TgShphpl4rHge9agKhjhslDqKga96f4
					hnhsl6ghgC/cfwhphsk0Ybfz+tf7hthwjAcxgH/rgAhvhxiDgAgA/7]],
				Tail4 = [[
					gAhsiIe8gAgA/+gRhjiChhjegZ/wgnhdh3hxvIh+8EgZhnh5lGtfiH8ff5hxh5pFhCg3+pfhh4hvp8T+e675fih0hyocREdw66f7hmh+lYZwe0+4gWhbh+h8
					nqhA++gcheh6iFuaiC8agKhciBiJpchT+dfvhsh6nIcQf7+9fmh2hwpZS0eT7ifzh1h1pvUkdv8JgPhuh6n3gQfV/Agghhh4jKsDhp9bgXhdh9iBt4h68sf5
					hfiBizkOgq/lfmhjh/h0YrfF/Ef3hpiGf6b6fv/ugAhsiIe8gAgA/+]],
				Tail5 = [[
					gAhuiebygAgA/tgWhgiYeXhOgR/7g6hciDe/vWjk71grhiiHiwwhkS66f6hliMnNkrih+tfShsh7onUues8pfQhrh7m3O1b05xfyhfiSi0V0c/+CghhZiSe3
					lfhR/eguhciIfSvxj17kgXhZiUfKtPjL88fqhiiNk6fTgz/mfVhsh7n/Sedb7vfkhqiCoMRgbo69gPhjiOlucjd3/NgwheiIgarFii95gphbiLfNwOj57Sf/
					hbiXfroViK+zfchhiTeuaWeu/bfxhpiccybgfR/ggAhuiebygAgA/t]],
				["UpperLegB.L"] = [[
					fJhYgs4CXxgAzcfJhdgp05amge3nfJhXgq3/Yweez0fJhtgn0xbPfr32fJiCgk12aKfP2nfJiKgi1dZ3fq27fIiDggzOavg35AfIhvggzQadhc45fIhYgi12
					Ymgt2JfIhcgjzuaWhL4hfJhagl15ZigF2afJh3gl0WbKf64NfJiGgl2uZ2ej1nfJiHgl2zZxef1gfJh7gl03a1fr3sfJhhgl0Jaqgm4QfIhbgj0zZrg13cfI
					highzhadhp4rfIhfgkz6aRhg4VfJhagq23Yngb1HfJhYgs4BXxgAzc]],
				["LowerLegB.L"] = [[
					e9g2gjwud6gA7MfAg5gs1OcgeZ3ne8g2ghv2fWe17wfAhKgr1CdDdq3ze+hfgkxseNeU6ie+hngjwveDew7KfAhggozicYez5CfBhMgozmcLfT4/e+g1ghvc
					dmf476fAg5gq0FcHfD4le+g3glxydmfC6dfAhUgq0nc6d54Le9hjgiwmfAeO7Re9hlgiwWfGeP7bfAhYgozqdWeC5BfAg+gq0ecdeh4Se/g3gmyWc1fU6AfB
					g/goz3cOff4yfBg8gp0RcFfW4be+g3glx8dWfs6We9g2gjwvd6gA7M]],
				["FootB.L"] = [[
					e6gggu/jgAgAlRe6gggu/ceGgRlle6gggu/jgUf9lRe6gxgu/GeHgZnQe6hHgu+qfagLpHe6hQgu+cffgLpze6hIgu+heMgfpZe7g0gu+yeSgIofe6gggu/j
					fngElRe6gggu/deKgRlie6gggu/ifOgIlRe6g7gu+3eKgcoNe6hNgu+hf/gApke6hOgu+fgFf+pte6hAgu+0ekgZoce6glgu/XeHgWl9e6gggu/ie0gNlRe8
					gmgt+0ebfvoae7gjgu/KeSf/nAe6gggu/jfcgGlRe6gggu/jgAgAlR]],
				["UpperLegB.R"] = [[
					g3hYgs4CoPgAzcg4hdgl0Nlwez4Gg4hYgi11nZfT2Lg4hvggzQljek45g4iDggzOlRfJ5Ag3iKgi1dmJgW27g3iCgk12l2gx2ng3htgn0xkxgV32g3hXgq4A
					nRhizzg3hbgn2FmCgY2Vg3hagl15mef72ag4h5ghzalUe/42g4iIgey2lae35Qg4iKgey0lZe55Rg4h9ggzWlTfC45g3hhgl0JlWfa4Qg3hago2tmggo1kg3
					hggo0/kugH3rg3hegp1ElIfz3hg3hagr3JnUf501g3hYgs4BoPgAzc]],
				["LowerLegB.R"] = [[
					hDg2gjwuiGgA7MhAg6gq0lj6g74KhCg1ghvfibgI74g/hMgozmj1gt4/hAhggozijohN5ChChngjwvh9hQ7KhChfgkxshzhs6ihAhKgr1Ci9iW3zhEg2ghv0
					gphL7xhBg4gnyyiRhf5whCg3glxyiag+6dhAhWgozujohG45hAhmgozKjyg95UhAhngozIjyg+5VhAhagozqjnhI49hAg+gq0ejjhf4ShCg3gkxphyhS6mg/
					g9gr1Qi2iI3pg/g7gs1YjOh33ghCg3glyIibgg6PhDg2gjwviGgA7M]],
				["FootB.R"] = [[
					hGgggu/jgAgAlRhFghgu/Yh1f0l9hGgggu/jgZf8lRhFg0gu+yhuf4ofhGhIgu+hh0fhpZhGhQgu+cghf1pzhGhHgu+qgmf1pHhGgxgu/Gh5fnnQhGgggu/j
					frgDlRhGgggu/ig9f2lRhGgggu/igyf4lRhFg9gu+phwfvo/hGhNgu+Yh1ffp0hGhPgu+Xh1fdp3hFhBgu+mhxfqpKhGglgu/Xh5fql9hGgggu/jghf6lRhF
					gkgu/IhrgFnMhFgigu/Uh1f5mShGgggu/jggf7lRhGgggu/jgAgAlR]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAh5goALgAgAjKgAh5gyARgAgAkCgAh5g7AYgAgAk0gAh5g5AXgAgAktgAh5g2AVgAgAkbgAh5gyATf7e3kFgAh5gvASf4ebjygAh5gtAPf8fKjqgAh5gtAO
					gAgAjmgAh6gqANf1gKjagAiCgoASdcgQjNgAiQgoA+Y7gtjFgAibgoCsTlhPi6gAidgoFKO6hsiqgAicgoHRL9h/idgAicgoH+LIiEiYgAicgoHXL3iAicgA
					idgoG1Mih7iggAicgoHTL8h/idgAicgoH9LJiEiYgAicgoH/LIiEiYgAicgoH/LIiEiYgAicgoH/LIiEiYgAicgoH/LIiEiYgAicgoH/LIiEiY]],
				Spine1 = [[
					gAh9gVALgAgAjKgAh+gfARgAgAkCgAh/goAYgAgAk0gAh/gnAXgAgAktgAh/gkAVgAgAkbgBh+ggATf7e3kFgCh+gcASf4ebjygBh+gaAPf8fKjqgAh+gaAO
					gAgAjmgAh+gXANf1gKjaf/iGgVASdbgKjNf+iUgVA+Y6gdjIf9idgVCuTigzjFf9ifgVFMO3hJjBf8idgVHVL6hYi9f8icgVICLFhci7f8idgVHbLzhYi8f8
					iegVG4MehVi+f8idgVHWL4hYi9f8icgVIBLGhci7f8icgVIDLEhci7f8icgVIDLEhci7f8icgVIDLEhci7f8icgVIDLEhci7f8icgVIDLEhci7]],
				Spine2 = [[
					gAiBgBAEgAgAhmgAiDgMAHgAgAifgAiFgWAMgAgAjRgAiFgUALgAgAjJgAiEgRAJgAgAi4gDiDgNAJf+e3iigEiCgJAJf9ebiPgCiCgIAGf+fKiGgAiCgHAF
					gAgAiCgAiCgEAEf0gJh2f/iKgCAKdbf8hqf9iXgBA3Y4f2hrf7iggBCoTgfxh1f5ihgBFHOzfviDf5ifgBHRL2fxiPf5iegBH+LBfyiTf5ifgBHWLwfxiQf5
					ifgBG0MbfwiNf5ifgBHSL1fxiPf5iegBH9LCfyiTf5iegBH/LBfyiTf5iegBH/LBfyiTf5iegBH/LBfyiTf5iegBH/LBfyiTf5iegBH/LBfyiT]],
				Spine3 = [[
					gAiDfuAEgAgAhmgAiGf5AHgAgAifgAiJgDAMgAgAjRgAiIgBALgAgAjJgAiHf+AJgAgAi4gEiGf6AJf+e3iigGiFf2AJf9ebiPgDiFf1AGf+fKiGgAiEf0AF
					gAgAiCf/iEfxAEf0gIh2f/iMfvALdaf2hrf9iZfuA4Y3fmhvf6ijfuCpTffViBf4ikfuFKOzfLiaf3ihfuHVL2fJivf3igfuICLBfKi2f3ihfuHaLwfJiwf3
					iifuG4MbfJirf3ihfuHWL1fJivf3igfuIBLDfKi2f3igfuIDLBfKi2f3igfuIDLBfKi2f3igfuIDLBfKi2f3igfuIDLBfKi2f3igfuIDLBfKi2]],
				Neck1 = [[
					gAiFfbA6gAgAnigAiJfmBYgAgApQgAiNfwB4gAgAqvgAiMfuBzgAgAqhgAiLfrBngAgAp/gFiJfnBbfve5pVgIiIfjBSfoeeoxgEiHfiBLfzfLoggAiHfhBJ
					gAgAoZf/iHfeBCf2gLoAf/iOfcBBdegfnif9ibfbBqZAhSnKf6ilfbDVTuiMmwf4infbFvPHi9mRf2ikfcH1MNjcl6f1ijfcIhLZjklzf2ikfcH6MGjdl5f2
					ilfcHZMxjWl/f2ikfcH2MMjcl6f2ijfcIgLajklzf1ijfcIhLYjklzf1ijfcIhLYjklzf1ijfcIhLYjklzf1ijfcIhLYjklzf1ijfcIhLYjklz]],
				Neck2 = [[
					gAiWe6B0gAgAqmgAiefHC0gAgAtFgAikfTD2gAgAvLgAijfRDsgAgAu4gAihfNDTgAgAuIgIiefIC5fme8tMgLicfECjfdehsYgGiafBCXftfNsAgAiafACS
					gAgAr1f/iZe9CFf4gNrSf8ife7B6dlg4qif2ire6CZZTiUp1fvixe5D5UNj6o4fqive5GGPvlKnyfniqe5IBM5l3m8fnioe5IpMGmEmrfniqe5IGMzl5m6fo
					ire5HnNclvnHfniqe5ICM4l4m7fnioe5IoMHmDmrfnioe5IqMFmEmrfnioe5IqMFmEmrfnioe5IqMFmEmrfnioe5IqMFmEmrfnioe5IqMFmEmr]],
				Neck3 = [[
					gAipeiCEgAgArQgAi1eyDggAgAuhgAi+fCFDgAgAxPgAi9fAEzgAgAw1gAi5e6EPgAgAv4gJi1e0Dmfie9uqgNixeuDGfZejtngHiwerC2frfOtIgAiveqCv
					gAgAs5f+itemCbf4gOsLf5iyejCJdqhFrKfui7ehCgZfi0qJfji+ehD3Uikqo0fbi2egF4QJmBnRfXitegHrNWmwmHfWiqegIRMjm7lwfXitegHvNPmxmEfY
					ivegHTN4mnmWfXitegHsNUmwmGfWiqegIQMkm7lwfWiqegIRMim7lvfWiqegIRMim7lvfWiqegIRMim7lvfWiqegIRMim7lvfWiqegIRMim7lv]],
				Head = [[
					gAjKd8/ygAgAjogAjeeV/9gAgAelgAjset/dgAgAaLgAjqep/kgBgAa1gAjleg/ygAgAcYgMjfeW/5eigueRgQjZeO/5d5hHf3gJjWeK/9e2gogugAjUeI/+
					gAgAhHf+jReC/6gZf4iPfzjTd8/qinf4jwffjXd5+ynHf4k/fMjRd483sVgPmLfAi/d26Qwwg8nRe7ivd14Dzdhpn9e7iqd13W0Nh4oKe7ivd13+zjhrn/e8
					izd14hy8hfn1e7ivd14Czehpn+e7iqd13X0Mh4oJe7iqd13W0Nh4oKe7iqd13W0Nh4oKe7iqd13W0Nh4oKe7iqd13W0Nh4oKe7iqd13W0Nh4oK]],
				Jaw = [[
					gAicd3/8gAgAh2gAizeC//gAgAfegAjIeP/4gAgAdZgAjFeN/6gBgAdsgAi+eI/9gAgAecgIi1eD/8eggrfTgMitd//5d4hGgBgGipd9/9e3gogegAind8//
					gAgAgqf/ijd6/9gZf3hQf7ild4/ximfyiqfzitd4+2nHfzknftiwd58usVghm0fpird650wrh3osfoild73YzRjJpyfoijd82lz+jkqFfoikd73RzXjMp1fo
					imd734yyi3plfoild73WzSjJpzfoijd82mz9jjqEfoijd82kz/jkqFfoijd82kz/jkqFfoijd82kz/jkqFfoijd82kz/jkqFfoijd82kz/jkqF]],
				Sock = [[
					ftlUcZ2ngAgA2nftl/dh55gAgAyyftmWeo8PgAgAvBftmTed77gBgAvmftmMeE7IgAgAw9gKmCdm6CeZfqyggXl3dO5DdqfjzwgElwdB4jeufx0dftlsc84V
					gAgA0xfmlics3kgggR1ofIlWcZ2EjrjE2qePlAcOzIp6oS2JdckPcGtzwitwzQdFjPcAnO1HxXu+dEieb8iH3JyxrddGiQb7gh3jzAqWdEidb8hV3dy1qydD
					iob9iE3WyrrLdEieb8hb3dy0q1dGiQb7gj3jzAqXdGiQb7gg3jzAqWdGiQb7gg3jzAqWdGiQb7gg3jzAqWdGiQb7gg3jzAqWdGiQb7gg3jzAqW]],
				["UpperLegF.L"] = [[
					fJhdfb0vZdgA3dfJhhfk2BZdfp2QfJhlfs3FZffU1KfJhkfr27ZffX1VfJhjfo2jZefe1ufOhhfh2EYogX19fQhgfc1pYTgx2PfNhffd1eY1gW2mfJhffg1Z
					Zdf023fIhefe1HZqf+3LfPhdfb05a6iM3lfchffZ0pdZmM3ffxhifW0EgOq/2XgFhkfVzMinvQ0ZgShmfTybkGx8ykgWhofTyMkhysx9gShnfTyakJyCyggP
					hmfUymj0xby9gShmfTybkHx9yjgVhofTyMkgyrx+gWhofTyMkhytx9gWhofTyMkhytx9gWhofTyMkhytx9gWhofTyMkhytx9gWhofTyMkhytx9]],
				["LowerLegF.L"] = [[
					e9g4fe7Ac5gAw2e9g9fj76c5f1vUe9hBfn8oc6frt8e9hAfm8hc6fsuJe9g/fl8Rc5fwupfDg9fe77cSgyvIfFg8fb7ocEhNvlfBg7fd7hccgnv6e9g6fg7e
					c5f6wGe9g5fg7RdHf9wdfJg4fe7De6hpw+fhg6fe6kibkqxCgBhAff5amhoWwSgfhKff3xqErqu4gwhSff2XsRtxthg1hWff16s5uYtDgxhTff2UsXt2tdgt
					hQff2qr2tXt0gwhSff2WsTtytgg1hVff17s5uXtEg1hWff15s6uYtDg1hWff15s6uYtDg1hWff15s6uYtDg1hWff15s6uYtDg1hWff15s6uYtD]],
				["FootF.L"] = [[
					e6ggfS/lgAgAlIe6glfU/0gAgAjXe6grfW/8gAgAhze6gqfV/7gAgAiCe6gofV/4gAgAilfBgmfP/zf0hIjRfDgkfN/ufwhkj2e/gjfP/tf3g2kIe6gifT/t
					gAgAkQe7ghfT/pgNf6kqfKgffS/bifgulWfqgifT+om1iIl1gTgtfV81r5j/l4g2g9fW6ZwPlxlehKhLfX4Vy7m+k8hPhQfY3qzrnUkvhLhMfX4QzBnBk6hG
					hIfX4xyamvlDhKhLfX4Uy9m+k7hPhQfY3rzqnUkvhPhQfY3qzsnUkvhPhQfY3qzsnUkvhPhQfY3qzsnUkvhPhQfY3qzsnUkvhPhQfY3qzsnUkv]],
				["UpperLegF.R"] = [[
					g3hdfb0vmjgA3dg3hhfk2BmjgX2Qg3hlfs3Fmhgs1Kg3hkfr27migo1Ug3hjfo2jmigi1ug9hhfp2ElshI2bg/hgfn1plYhT25g7hffj1el7gw29g3hffg1Z
					mjgM23g3hffd1DmxgK3Hg8hvfdz9n+iC3nhAiPfeyGqPlq3pg9ixfgvnsiqJ2zgzjHfitDuLuN1OgpjSfkrPvBw1ztgljUfkqsvOxmzMgojSfkrKvDw7zpgr
					jQfkrmu3wV0CgojSfkrOvBw3zsgljUfkqtvOxkzMgljUfkqrvOxmzLgljUfkqrvOxmzLgljUfkqrvOxmzLgljUfkqrvOxmzLgljUfkqrvOxmzL]],
				["LowerLegF.R"] = [[
					hDg4fe7AjHgAw2hDg9fj76jHgLvUhDhBfn8ojGgVt8hDhAfm8hjHgTuJhDg/fl8RjHgQuphIg9fo77ighKvWhKg7fo7oiShev4hHg7fk7hirg0wEhDg6fg7e
					jHgGwGhDg7ff7PjWgDwbhNhNfh6mlIhmw7hahzfk5Woikew+heigfo3SsZoAwPhXjCft01vmrLu4hNjUfwy6xhtNtmhJjZfxyTyDtytKhMjVfwy1xltStihP
					jRfvzTxJs0t3hNjUfwy5xitOtlhJjZfxyUyCtytKhJjZfxySyDtztJhJjZfxySyDtztJhJjZfxySyDtztJhJjZfxySyDtztJhJjZfxySyDtztJ]],
				["FootF.R"] = [[
					hGggfS/lgAgAlIhGglfU/0gAgAjXhGgrfW/8gAgAhzhGgqfV/7gAgAiChGgofV/4gAgAilhMglfZ/zf0hIjRhOgjfa/ufwhkj2hKgjfX/tf3g2kIhGgifT/t
					gAgAkQhGgjfS/pgNf6kphUg1fU/diggtlPhohefZ+sm2iDlih0iRfe88r9jxlXhxi6fk6hwYlXk0hnjTfn4ezImZkNhjjZfp3zz6msj/hnjTfo4ZzOmckLhq
					jOfn45ymmNkVhnjTfn4dzJmakMhjjZfo30z4msj/hjjZfp3zz6mtj/hjjZfp3zz6mtj/hjjZfp3zz6mtj/hjjZfp3zz6mtj/hjjZfp3zz6mtj/]],
				Tail1 = [[
					gAh1hEiIgAgA/7gAh0hOjAgAgA/2gAhzhXjygAgA/xgAhzhWjrgBgA/xgAhzhSjZgAgA/zf+h0hPjDeGgF/yf9h0hLiwdXgI/wf+h1hKioemgF/2gAh1hJik
					gAgA/4gAh2hHiYgQgL/5gBh+hFiMgTik/0gCiNhEiFg1nE/HgDiYhEh2hesa9ZgDichEhgiAxE68gEichEhMiV0B40gEibhEhFia024IgEichEhLiV0H4vgE
					ichEhQiRzc5RgEichEhMiV0C4zgEibhEhFia004JgEibhEhFia024HgEibhEhFia024HgEibhEhFia024HgEibhEhFia024HgEibhEhFia024H]],
				Tail2 = [[
					gAhyhbicgAgA/5gAhwhkjVgAgA/0gAhthtkHgAgA/ugAhuhskAgBgA/vgAhuhpjugAgA/xf7hwhljXdVgI/sf5hwhhjEcUgN/of9hxhgi8eCgI/ygAhxhgi5
					gAgA/3gBhyheitgXgK/4gBh7hbiigdij/ygDiKhbiZhRnC/FgGiWhbiDiOsV9XgHibhbhfjCw966gHichbg+jhz34zgHichbgzjp0s4HgHichbg9jiz+4ugH
					ichbhFjbzU5QgHichbg+jhz54ygHichbg0jp0r4IgHichbgzjp0t4GgHichbgzjp0t4GgHichbgzjp0t4GgHichbgzjp0t4GgHichbgzjp0t4G]],
				Tail3 = [[
					gAhvhxiDgAgA/7gAhrh7i8gAgA/2gAhniDjtgAgA/xgAhoiCjmgBgA/ygAhph/jUgAgA/0f4hrh7i9clgI/qf0hsh3iqbRgN/hf6hth2iidegI/ygAhth2if
					gAgA/5gBhvh0iTgegK/5gCh4hyiKgjij/0gGiHhxiBhinB/HgKiVhxhlitsT9XgMichxg3jrw665gMiehxgNkQzy4xgMifhxf+kZ0m4FgMiehxgLkRz44sgM
					iehxgVkJzP5OgMiehxgMkQzz4wgMifhxf/kZ0l4GgMifhxf+kZ0m4EgMifhxf+kZ0m4EgMifhxf+kZ0m4EgMifhxf+kZ0m4EgMifhxf+kZ0m4E]],
				Tail4 = [[
					gAhsiIe8gAgA/+gAhniRf1gAgA//gAhiiZgngAgA//gAhjiYgggCgA//gAhliVgOgAgA//fzhniQf4b1fv/tfuhoiMfmaPfs/df2hpiMfcc6f2/1gAhqiMfY
					gAgA//gChriKfMgjgN/+gDh1iIfFgbim/3gJiFiHfAhNnJ/JgOiUiHeoiIsh9VgRieiHd9i5xK6xgRiiiHdWjT0D4kgRijiGdIjZ0332gRiiiHdUjU0J4egR
					ihiHdejOzf5CgRiiiHdVjT0E4jgRijiGdIjZ0133gRijiGdIjZ0331gRijiGdIjZ0331gRijiGdIjZ0331gRijiGdIjZ0331gRijiGdIjZ0331]],
				Tail5 = [[
					gAhuiebygAgA/tgAhniocrgAgA/0gAhhivddgAgA/4gAhiiudVgCgA/4gAhkirdDgAgA/2fthnimcwbIfN/cfmhpiicgZRe+/EfyhqijcUcYfd/kgAhqijcO
					gAgA/xgDhsihcDgogS/vgEh2ifb9gTip/ngKiHieb8g2nR+4gQiXiebphhsu8/gTiiidbDiCxZ6TgSioicafiS0S4AgSipicaTiW1G3PgSioicaeiT0Z36gS
					inidaniQzv4fgSioicafiS0U3+gSipicaTiW1F3RgSipicaTiW1G3PgSipicaTiW1G3PgSipicaTiW1G3PgSipicaTiW1G3PgSipicaTiW1G3P]],
				["UpperLegB.L"] = [[
					fJhYgs4BXxgAzcfJhYg15EXyfjyFfJhYg857X0fJw1fJhYg75zX0fMxBfJhYg45gXzfWxdfIhYgx5HXGgYxtfIhYgt4xW0g3yCfIhYgu4oXQgYydfJhYgx4j
					XxfxyxfJhYgv4ZX/f4zEfPhYgt5BZwhXy4fdhags6Kdijqx4fyhcgs60idmEwLgHhdgs6inNn5uUgVhfgs51qdo6s8gZhggs5jrapKshgWhfgs5zqlo8s4gS
					hfgs6Ap0outNgVhfgs51qfo6s7gZhggs5jrZpKshgZhggs5jrbpKsggZhggs5jrbpKsggZhggs5jrbpKsggZhggs5jrbpKsggZhggs5jrbpKsg]],
				["LowerLegB.L"] = [[
					e9g2gjwvd6gA7Me9g4goyOd6f56Ne9g5gszed7fy5Se9g5grzTd7fz5be9g4gqy2d7f15we+g4gjySc8ge6Ee+g3ggxyckgw6We+g3gixldMgY6le9g3glxe
					d6f86te+g3glxMeIgD66fJg2gixRfTiJ61fgg4ggxph4l25+gAg+gdxqlOqG4IgdhGgbxFoatq1ygvhOgZwWqkv0z2g0hRgZwErNwbzPgwhOgZwUqpv5zygs
					hMgawhqJva0QgvhOgZwVqlv2z1g0hRgZwFrMwazQg0hRgZwErNwbzOg0hRgZwErNwbzOg0hRgZwErNwbzOg0hRgZwErNwbzOg0hRgZwErNwbzO]],
				["FootB.L"] = [[
					e6gggu/jgAgAlRe6gfgw/zgAgAjge6gggy/7gAgAh9e6gggy/6gAgAiLe6gggx/4gAgAive6gggr/yf0hIjae6gggp/sfvhkj/e6gggs/sf3g1kRe6gfgv/s
					gAgAkZe7gfgv/ogNf5kwfKgegt/hijgZkxfoghgq+6nDg8kIgPgrgm9SsahVjJgyg5gi65xIhbiOhHhGgg4z0GhVhphMhLgf4H08hShehIhHgg4t0NhUhnhD
					hDgh5PzhhXhwhHhGgg4y0IhVhohMhLgf4I07hShehNhLgf4G08hShehNhLgf4G08hShehNhLgf4G08hShehNhLgf4G08hShehNhLgf4G08hShe]],
				["UpperLegB.R"] = [[
					g3hYgs4BoPgAzcg3hYg15EoOgdyFg3hYg857oMg3w1g3hYg75zoNgzxBg3hYg45goNgqxdg3hXg55HnhhWySg3hXg44xnQhhy2g3hYg04onug5y5g3hYgx4j
					oPgPyxg4hZgu4ToegJzAg8hqgt3mqKhry/hAiKgs2PthkayFg/irgsz+xZnewUg2jBgsxN0sp5uMgsjMgsu/2srRsigpjOgsuR3ProsBgsjMgsu52wrUsegu
					jKgsvc2UrBs4gsjMgsu+2trSshgpjOgsuS3OrosBgpjOgsuR3QrosAgpjOgsuR3QrosAgpjOgsuR3QrosAgpjOgsuR3QrosAgpjOgsuR3QrosA]],
				["LowerLegB.R"] = [[
					hDg2gjwviGgA7MhDg4goyOiGgH6NhDg5gszeiFgO5ShDg5grzTiGgN5bhDg4gqy2iFgL5whDg3gtyShHgu6OhDg3gtxygvg66khDg3gpxlhYgh6shDg3glxe
					iGgE6thEg4gkxKiUgI65hNhLgiw1jdiN65hZhxghwdl5mA6Hheidgfvmo4qa4WhXi/gduTrluK2AhNjQgctItUwd0EhJjVgcsvt0xGzchMjRgctFtYwiz/hP
					jNgctYs/wB0ehMjRgctHtVwe0DhJjVgcsvt0xFzdhJjVgcsut1xGzchJjVgcsut1xGzchJjVgcsut1xGzchJjVgcsut1xGzchJjVgcsut1xGzc]],
				["FootB.R"] = [[
					hGgggu/jgAgAlRhGgfgw/zgAgAjghGgggy/7gAgAh9hGgggy/6gAgAiLhGgggx/4gAgAivhFgfg1/yf0hIjahFgfg3/sfvhkj/hFgfgz/sf3g1kRhGgfgv/s
					gAgAkZhHghgu/ogNf5kwhTg1gt/gijgak4hmhegr+4nChBkchxiPgo9OsZhjjqhui3gm61xFh2i5hljOgk4v0Dh7iYhhjVgk4D05h8iOhljPgk4q0Kh7iXhn
					jKgl5Lzeh7ifhljOgk4u0Eh7iYhhjUgk4E03h8iPhhjVgk4C05h8iOhhjVgk4C05h8iOhhjVgk4C05h8iOhhjVgk4C05h8iOhhjVgk4C05h8iO]],
			},
		},
	},
}
