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
					gAhxgZAHgAgAicgAhxgZAIfigpibgAhygZAJfHhOiagAhygZALexhriXgAhygZAMekh+iWgAhygZANefiFiVgAhygZAMekh+iWgAhygZALexhriXgAhygZAJ
					fHhOiagAhxgZAIfigpibgAhxgZAHgAgAicgAhwgZAIgefXibgAhwgZAJg5eyiagAhvgZALhPeViXgAhvgZAMhceCiWgAhvgZANhhd7iVgAhvgZAMhceCiWgA
					hvgZAJhDekiMgAhtgZAFgcfYhvgAhrgZADgEf6hQgAhqgZACgAgAhDgAhrgZACgAgAhDgAhrgZACgAgAhDgAhsgZACgAgAhDgAhsgZACgAgAhDgAhsgZACgA
					gAhDgAhsgZACgAgAhDgAhsgZACgAgAhDgAhrgZACgAgAhDgAhrgZACgAgAhDgAhqgZACgAgAhFgAhsgZADgIf1hbgAhugZAGglfMh8gAhvgZAKhKeaiTgAhv
					gZAMhceCiWgAhvgZANhhd7iVgAhvgZAMhceCiWgAhvgZALhPeViXgAhwgZAJg5eyiagAhwgZAIgefXib]],
				Spine1 = [[
					gAhzgJA0gAgAnFf/h0gJA2flgdnNf/h0gJA4fNg3nTf+h0gJA7e6hMnXf+h1gJA8euhZnaf+h1gJA9eqhenbf+h1gJA8euhZnaf+h0gJA7e6hMnXf/h0gJA4
					fNg3nTf/h0gJA2flgdnNgAhzgJA0gAgAnFgBhzgJAygcfjm9gBhygJAyg1fJm0gChygJAxhJe1mtgChxgJAxhXeomogChxgJAxhbekmngChxgJAxhXeomogB
					hxgJAsg/fAmagBhugJAjgbfklwgAhsgJAbgEf8lFgAhrgJAZgAgAk5gAhsgJAagAgAlBgAhsgJAcgAgAlJgAhtgJAcgAgAlOgAhtgJAdgAgAlSgAhtgJAdgA
					gAlTgAhtgJAdgAgAlSgAhtgJAcgAgAlOgAhsgJAcgAgAlJgAhsgJAagAgAlBgAhsgJAagAgAk8gAhtgJAegIf4lXgBhvgJAngjfcmFgChxgJAvhFe5mmgChx
					gJAxhXeomogChxgJAxhbekmngChxgJAxhXeomogChygJAxhJe1mtgBhygJAyg1fJm0gBhzgJAygcfjm9]],
				Spine2 = [[
					gAiBftCEgAgArQf+iCftCKfjgRrff9iCftCQfLggrtf7iCftCVe3gtr3f7iDftCYerg1r+f6iDftCZeng3sAf7iDftCYerg1r+f7iCftCVe3gtr3f9iCftCQ
					fLggrtf+iCftCKfjgRrfgAiBftCEgAgArQgCiAftB+gefvrAgDh/ftB6g5fgqygEh/fsB3hQfVqmgFh+fsB1hefNqfgGh+fsB0hjfLqcgFh+fsB1hefNqfgE
					h9fsBthFfbqLgCh5fsBagefwpVgAh2frBLgFf9ohgAh1frBIgAgAoVgAh2frBMgAgAolgAh2frBQgAgAozgAh3frBTgAgAo/gAh3frBVgAgApGgAh3frBWgA
					gApJgAh3frBVgAgApGgAh3frBTgAgAo/gAh2frBQgAgAozgAh2frBMgAgAolgAh1frBJgAgAoagAh3frBSgJf7o5gCh7fsBkgmfrpygEh+fsBzhMfXqcgFh+
					fsB1hefNqfgGh+fsB0hjfLqcgFh+fsB1hefNqfgEh/fsB3hQfVqmgDh/ftB6g5fgqygCiAftB+gefvrA]],
				Neck1 = [[
					gAiMfgFMgAgAxbf+iNfgFVfogXxpf8iOfgFefTgrx1f6iOfhFlfDg7x+f5iPfhFpe5hGyEf5iPfhFre1hJyGf5iPfhFpe5hGyEf6iOfhFlfDg7x+f8iOfgFe
					fTgrx1f+iNfgFVfogXxpgAiMfgFMgAgAxbgCiLffFDgZfpxNgEiKffE7gxfVxAgGiJffE2hEfFw1gHiJffEyhRe6wugHiJffExhWe3wsgHiJffEyhRe6wugF
					iHffEXhIffwDgCiDfdDYhIgiuOgAh/fcCkhYhWsWgAh+fcCUhkhmrtgAh/fcCahjhnr8gAh/fcCghjhnsKgAiAfdClhihosVgAiBfdCohihoscgAiBfdCphh
					hosegAiBfdCohihoscgAiAfdClhihosVgAh/fcCghjhnsKgAh/fcCahjhnr8gAh+fcCYhhhkr2gBiBfdC3hNhItGgDiFfeD1hAgLvHgFiJffEqhGfOwjgHiJ
					ffEyhRe6wugHiJffExhWe3wsgHiJffEyhRe6wugGiJffE2hEfFw1gEiKffE7gxfVxAgCiLffFDgZfpxN]],
				Neck2 = [[
					gAipfTG7gAgAz3f9iqfUHGfqgZ0Ef6irfUHQfXgv0Pf4isfVHYfJhB0Xf2isfVHdfAhM0cf2isfWHee8hQ0ef2isfVHdfAhM0cf4isfVHYfJhB0Xf6irfUHQ
					fXgv0Pf9iqfUHGfqgZ0EgAipfTG7gAgAz3gDiofSGxgXfnzqgGinfRGpgtfQzdgIimfRGig/e+zTgKilfRGehKezzMgKilfRGdhOevzKgKilfRGehKezzMgH
					ijfPFzhXfsyTgCicfKEWiLhbv2f/iVfGDNjSiwtPf+iTfFC4j2jMsRf+iVfGC/j0jOsgf+iWfGDFjzjQstf+iXfGDKjyjRs4f+iXfHDjjwjTtvf+iYfHD8jw
					jUuhf+iXfHD7jwjUuff+iXfGD2jxjTuVf+iWfGDLjzjQs7f+iVfGC/j0jOsgf+iUfFC9jvjIsdgAiYfIDniziXuQgDigfME/hsgzxBgIilfQGQhHfQy8gKil
					fRGehKezzMgKilfRGdhOevzKgKilfRGehKezzMgIimfRGig/e+zTgGinfRGpgtfQzdgDiofSGxgXfnzq]],
				Head = [[
					gAjFfMAFgAgAh8f8jGfOAHergsh9f4jHfPANdfhTh9f1jHfQAUcjhzh+f0jIfQAab9iHh/fzjIfRAcbwiOh/f0jIfQAab9iHh/f1jHfQAUcjhzh+f4jHfPAN
					dfhTh9f8jGfOAHergsh9gAjFfMAFgAgAh8gEjDfLAHhWfUh9gIjCfKANikesh9gLjBfJAVjjeNh+gNjAfJAbkLd5h/gNjAfJAdkYdyh/gNjAfJAbkLd5h/gJ
					i9fFAOjhfqfwgCi1e8A2jTjPabf9ire0CvkFmDVXf8ioeyDxkrm9Tgf8ipezDrknm/Tvf8irezDlkknBT8f8ise0DhkhnDUHf8iue2CnklnaW2f8ive3B/kn
					ntZkf8ive3CAkontZif8iue2CEkqnqZOf8ire0DTkmnIUtf8ipezDrknm/Tvf8ioeyDlkim1T2f+ive3B6jklPXMgEi5fAAYi/h6cxgKi/fIAQjhewhKgNjA
					fJAbkLd5h/gNjAfJAdkYdyh/gNjAfJAbkLd5h/gLjBfJAVjjeNh+gIjCfKANikesh9gEjDfLAHhWfUh9]],
				Jaw = [[
					gAjIeh/8gAgAhqf6jJei/5hafeh1f1jJej/ziqfBh9fwjKek/sjqeqiDfujKel/mkSeciHftjKel/jkgeXiIfujKel/mkSeciHfwjKek/sjqeqiDf1jJej/z
					iqfBh9f6jJei/5hafeh1gAjIeh/8gAgAhqgGjGeg/6elgihqgLjFef/0dThBhogQjDee/tcShZhmgSjCee/nbohohlgTjCee/kbZhuhlgSjCee/nbohohlgJ
					i6eZ/kcef9j0f3ileV+VdGcbpDfqiReX74coZit4fmiLeZ6pcJYlvmfmiNea6scQYhvhfmiPea6ucWYfvdfmiQea6wcaYcvafliYeX79cbYFs4flifeV87cb
					XxqRflifeV87caXxqSflideV82cXX0qhfmiReZ7GcVYYuvfmiNea6scQYhvhfmiMeZ64cRYtvSfuiYeW86dDaasJf9iveW/EdQdxmxgNjAec/rcXg2ibgSjC
					ee/nbohohlgTjCee/kbZhuhlgSjCee/nbohohlgQjDee/tcShZhmgLjFef/0dThBhogGjGeg/6elgihq]],
				Crest = [[
					gAlAeoLVgAgA4afwlBeqLMfJh84NfilAerLKedjg39fXk/etLJeIkg3wfQk+evLFeMk13pfNk+evK/ejkk3ofQk+evK6fDj33ufXk/etK6fii733filAerK/
					f3h74CfwlBeqLJf/g84OgAlAeoLVgAgA4agQk+enLigAfD4kgfk7enLvgIeD4rgqk5enL8gadA4ugyk2enMIg1cA4ug0k2enMRhTbR4sgyk2enMThqbA4pgj
					kveRKZiicl3MgJkRdiGuklf3zDf0jmdCEGoNdmtFftjVc6DdoQhcrwftjYc8EGnJlpsuftjcc9DYofgircftjec/DYofgorcfxj0dKFXm5l7vMf3kHdZGKot
					iOwkf3kGdZF+qeebvRf2kDdXGLoNjMwtfujidAD7n9i4syftjYc8DWpKdeqkfujYc8DkoEhdsIf5j4dNFVlGkFwZgRkhd2IHjTfW1Agok2efLUg5dT4Ogyk2
					enMIg1cA4ug0k2enMRhTbR4sgyk2enMThqbA4pgqk5enMLhvbX4mgfk7enL6hdca4lgQk+enLlg2eD4i]],
				["UpperArm.L"] = [[
					fYiLfT0DMpfNvrfWiKfT0tNCe8vSfUiKfU1ONZexvAfSiKfU1jNretu3fRiKfV1sN2eyu5fRiKfV1mN4e/vFfRiKfV1UNzfTvZfSiKfU01Nmfrv0fUiKfU0N
					NUgGwTfWiKfTzeM+gfwzfYiLfTysMpgzxRfaiLfSx9MUhBxrfciLfSxWMChHx9fdiLfSw7L0hGyHfeiLfSwwLqg/yGffiLfSw3Llgyx7feiLfSxOLmghxnfd
					iIfRzzMAfUvLfaiBfQ4HNQcto5fYh7fQ6RO2aChofYh6fQ6bPpYteDfYh7fQ6YP0YVdcfYh8fQ6VP9YDc/fYh9fQ6TQCX5cvfYh9fQ6gPPZrfnfYh9fQ6XOn
					bsiufYh9fQ6UOjb/jLfYh9fQ6QOfcPjkfYh8fQ6gPQZqflfYh7fQ6gPRZnfgfYh6fQ6ePBaOgtfYh9fQ5cN/cLmEfaiEfR13Mqe4tDfdiKfSxvL4gxxbfeiL
					fSwwLqg/yGffiLfSw3Llgyx7feiLfSxOLmghxnfdiLfSxyLugNxMfciLfSygL8f4wsfaiLfSzSMRfiwL]],
				["LowerArm.L"] = [[
					fEh4fDAcgAgAlLfDh4fDAmfhgMmDfBh4fDAsfGgXmcfAh4fDArexgfmWe/h3fDAlejgilve/h3fDAaedghkse/h3fEAOeggbjUfAh2fEAGetgThufBh2fFAC
					fCgLgFfDh2fFADffgEeifEh2fGAJgAgAdRfGh2fGAOgif+cYfHh3fHAShBf+b+fIh3fHAThbf9cEfJh3fGAPhrf6crfJh3fGAJhwf2dufJh4fFAFhqfyfHfJ
					h2fAAogXfPmJfLh4e3G2dueczkfNh/ezShbnd28mfOiEe0Y+a5de+rfOiGe1Z1a8dY+3fOiIe1aPbAdR+8fOiKe2aIbEdK+7fOiEe0WPa1dn97fOh+ezSGao
					eH8PfOh8ezQ4aqeD7mfOh7ezPvard/68fOiDezTQbHdG8yfOiCezSybLc/8kfOh/ezQ1bPdI7nfMh4e0Iqced11efKh0e8BSe3exoxfJh2fFAGhDfueGfJh3
					fGAPhrf6crfJh3fGAJhwf2dufJh4fFAFhqfyfHfJh4fFAEhZfvgufHh4fEAIg/fxiYfGh4fDARghf2j6]],
				["UpperArm.R"] = [[
					goiLfT0DzXgzvrgmiNfT0GzthcvIgkiPfT0F0Ah7utgiiQfT0A0PiNucghiRfTz30ZiSuaghiSfTzs0diKulghiRfTze0bh1u9giiQfTzQ0ShUvegkiPfTzC
					0DgswFgmiNfTy2zvf9wtgoiLfTyszXfNxRgqiIfTymy/ehxvgsiGfTylypd8yEguiEfTypyYdkyPgviCfTyyyNdcyPgviCfTy/yKdlyGgviCfTzPyOd9x0gt
					iCfS1PyRfzvcgqh/fR4sx6jKpHgph7fQ6WxCmAhsgoh6fQ6bwXnTeDgoh7fQ6YwMnrdcgoh8fQ6VwDn9c/goh9fQ6Tv+oHcvgoh9fQ6gwxmVfngoh9fQ6XxZ
					kUiugoh9fQ6UxdkBjLgoh9fQ6Qxhjxjkgoh8fQ6gwwmWflgoh7fQ6gwvmZfggoh6fQ6ew/lygtgph9fQ5mxxj1mJgriBfS2pyTgwtPgtiDfTzWyWeDxkgviC
					fTyyyNdcyPgviCfTy/yKdlyGgviCfTzPyOd9x0guiEfTzfyaejxZgsiGfTzuyrfRw4gqiIfTz6zBgDwS]],
				["LowerArm.R"] = [[
					g8h4fDAcgAgAlLg6h8fCAmfhgMmDg4h/fBAsfGgXmcg3iCfBArexgfmWg2iDfBAlejgilvg2iDfBAaedghksg2iCfCAOeggbjUg3iAfDAGetgThug4h9fEAC
					fCgLgFg6h6fFADffgEeig8h2fGAJgAgAdRg9hyfHAOgif+cYg+hvfIAShBf+b+g/hsfIAThbf9cEhAhrfIAPhrf6crhAhqfIAJhwf2duhAhrfHAFhqfyfHg+
					hufCArh6f5mLg5h0e4G7i+gxzng0h+ezSjkbiA8ngyiEe0Y+lHii+rgyiGe1Z1lEio+3gyiIe1aPlAiv+8gyiKe2aIk8i2+7gyiEe0WPlLiZ97gyh+ezSGlY
					h58Pgyh8ezQ4lWh97mgyh7ezPvlViB68gyiDezTQk5i68ygyiCezSyk1jB8kgyh/ezQ1kxi47ng1h3e0Isjth71fg7hve9BXiYgno1g/hsfHAHhogAeHhAhr
					fIAPhrf6crhAhqfIAJhwf2duhAhrfHAFhqfyfHg/htfGAEhZfvgug/hxfFAIg/fxiYg9h0fEARghf2j6]],
				Tail1 = [[
					gAhwgvgpgAgA//gBhwgvgWh6gg/7gChxgvgCjng+/xgChxgvfwk8hW/lgDhygvfjlzhm/agDhygvffmFhs/WgDhygvfjlzhm/agChxgvfwk8hW/lgChxgvgC
					jng+/xgBhwgvgWh6gg/7gAhwgvgpgAgA//f/hvgvg3eGfi/6f+hvgvhBcYfK/wf+hvgvhGbAe3/jf9hvgvhIaJet/Zf9hvgvhIZ2ep/Vf9hvgvhIaJet/Zf+
					hugvg8befE/pf/htgvgXbafy/qgAhsgvftbsgN/sgAhrgvfPgAgA/+gAhsgvfAkufv/ogAhsgvexljfv/egAhtgvekh0f7/6gAhtgvedckgJ/xgAhtgvecaL
					gO/agAhtgvedckgJ/xgAhtgvekh0f7/6gAhsgvexljfv/egAhsgvfAkufv/ogAhsgvfSgAgA/+gAhsgvf3cDgG/vf/htgvgkbtfl/sf+hvgvhCbLe8/lf9hv
					gvhIaJet/Zf9hvgvhIZ2ep/Vf9hvgvhIaJet/Zf+hvgvhGbAe3/jf+hvgvhBcYfK/wf/hvgvg3eGfi/6]],
				Tail2 = [[
					gAhvhNhLdJgH/1gEhwhNgvgIgj/+gIhxhMgLjGg+/0gLhyhLfllthV/cgNhzhLfDnvhl+/gOhzhLetpAhs+ngNhzhLekpbho+fgLhyhLeqo9ha+pgIhxhMe8
					nnhC/CgEhwhNfXligj/fgAhvhNf0i3gB/3f8huhNgRf4fh//f4hthMgoc6fH/0f0hthLg7aPe2/bfzhthLhJYKev++fyhthLhTW3ew+mfzhthLhcWce4+ef2
					hthMheYefR/Df3hshMhAYggB/Ff4hshMgVWjgq+jgAhthNfybTgY/ogJhuhMfWkufs/ogKhvhLe6qHfV+UgDhvhNednTff/Gf6hwhMeEeXf9/5f1hwhLd1W1
					gW+kf6hwhMdtW1ga+jgDhvhNdpeYgL/3gKhvhLd1nUf0/EgJhuhMeJqIfp+SgAhthNeekrf1/nf4hshMfPcigA/yf3hthMgJabfi/ff1hthLg3aKe7/bfzht
					hLhJYKev++fyhthLhTW3ew+mfzhthLhcWce4+ef0hthLhiW8fF+of4hthMhjYUfX/Af8huhNhcacft/e]],
				Tail3 = [[
					f7hthqf4ZBfz/OgFhvhrfhcOgb/wgOhxhpe9f1hD/9gWh0hneQjbhl/ugbh2hldimph//Igeh3hkc6pJiN+ageh3hjcfqwiO91gbh1hlcUrWiD9ngWh0hncY
					q5hs90gPhxhpcnpZhK+XgFhvhqc+m+gg/Ef7hthrdZjzfy/qfyhshpd0gNfG/5fqhshnePckej/ufkhshlepZTeM/MfhhrhjfCWveE+ifhhrhjfZVFeI+Afo
					hqhmfpXKeu+tfphqhmfbYefp/FfnhrhlfBUggL91f3hthpelV3gK+TgRhvhoeDgAf8/7gchwhjdqqJfw+QgRhyhndLr1fq9lf3hzhqcgj7fp/jflh0hkcCYl
					fv+3fph0hlbyTmf89LgAh0hqbaYlgO+xgXhyhmbRj7ge/Zgbhxhjbkr1gh9YgJhwhpbwqEgU+EfyhuhpcUhDf3/wfthshodSclfL/rfqhshneKcGel/qfkhs
					hlepZTeM/MfhhrhjfCWveE+ifhhrhjfZVFeI+AfkhrhkftUfeX9zfqhrhmf7U/ev+AfxhrhpgAWifO+j]],
				Tail4 = [[
					fuhtiFcuWCeb+Lf+hviHclYcfW+4gOhziHcMbogW/dgch3iEbmfRhV/pgnh7iAa7i+iK/Xguh9h8aSmWix+tgwh+h6ZxpDjG94guh9h6Zbq2jJ9Mgph7h9ZR
					rni685gfh4iBZRrUic9DgSh1iFZXp8hv9ngChyiHZhnlg1+YfyhwiHZukbf1/DfkhviEaAgye1/ZfYhviAaXdCd+/SfRhuh8a0ZndW+zfOhth6bVW3dA+JfY
					hsh/brYFdw+mfbhsiBbka4fN/QfThth7bcW/fU+WflhwiBbhUOe19YgRhyiGa/ahfL/Gguh0h6amljgK/Cglh3h8akr0gt9Of+h6iGZ/olgX+OfYh7h9ZOeI
					fb/NfUh7h5Y/VVe49Ufzh8iDYpVTfV9Ogeh7iBYEeBgj+6gvh5h4YFochp9ygah3iAYQrrhr8tf0h1iGYbmGgl+efnhyiFZIhCfY/OfjhviEZ5gGew/YfYhv
					iAaXdCd+/SfRhuh8a0ZndW+zfOhth6bVW3dA+JfQhth6b3VCc99nfWhsh9cUURdM9ZfhhsiBcoUndt9n]],
				["UpperLeg.L"] = [[
					fThKgK7fctf7wCfUhJgL7+c0fTvLfUhIgN8Xc5euuafVhIgO8qc8eQtxfVhHgP81c+d8tXfWhHgP85c/d2tOfVhHgP81c+d8tXfVhIgO8qc8eQtxfUhIgN8X
					c5euuafUhJgL7+c0fTvLfThKgK7fctf7wCfShLgI6+cmggw3fShMgG6ecehAxmfRhNgF6DcYhZyKfRhNgF5xcUhoyifRhNgE5qcShtyqfRhNgF5xcUhoyifS
					hLgG6pcVhIxSfShHgK8BcSgRu/fThDgM87cNfntIfThCgN9JcKffsnfThDgN9FcMfgswfThDgN9CcNfhs4fThEgN8/cOfis/fThEgN89cPfjtDfThEgN89cP
					fjtEfThEgN89cPfjtDfThEgN8/cOfis/fThDgN9CcNfhs4fThDgN9FcMfgswfThDgN9GcLffstfThEgM8rcQfwtrfShIgJ7lcWggvyfShMgG6RcXhTx1fRhN
					gF5xcUhoyifRhNgE5qcShtyqfRhNgF5xcUhoyifRhNgF6DcYhZyKfShMgG6ecehAxmfShLgI6+cmggw3]],
				["LowerLeg.L"] = [[
					fPgvf6rzg/gC9ufPgvf6r4hLfq9rfPgwf7sBhXfS9nfPgwf7sLhge+9hfPgwf7sThmew9dfPgwf7sWhoer9bfPgwf7sThmew9dfPgwf7sLhge+9hfPgwf7sB
					hXfS9nfPgvf6r4hLfq9rfPgvf6rzg/gC9ufQgvf6rzg0gY9ufQgvf6r3grgq9sfQgvf6r9gkg39qfQgwf6sCggg+9nfQgwf6sEgehB9nfQgwf6sCggg+9nfQ
					guf5rVgpgz95fPgtf4qUg7ge+RfPgsf4p1hJgP+afPgsf4p0hMgN+bfPgsf4qAhMgN+XfPgtf4qKhLgM+UfPgtf4qShKgM+RfPgtf4qYhKgM+PfPgtf4qahK
					gM+OfPgtf4qYhKgM+PfPgtf4qShKgM+RfPgtf4qKhLgM+UfPgsf4qAhMgN+XfPgsf4p2hMgN+afPgsf4qDhGgR+WfPguf5qug1gi+IfQgvf6rugmg19wfQgw
					f6sCggg+9nfQgwf6sEgehB9nfQgwf6sCggg+9nfQgvf6r9gkg39qfQgvf6r3grgq9sfQgvf6rzg0gY9u]],
				["Foot.L"] = [[
					fRgagQ9EgEf+tXfRgagQ9EgIf8tXfRgagQ9EgLf7tXfRgagQ9EgOf6tXfRgagQ9EgPf5tXfRgagQ9EgPf5tXfRgagQ9EgPf5tXfRgagQ9EgOf6tXfRgagQ9E
					gLf7tXfRgagQ9EgIf8tXfRgagQ9EgEf+tXfRgagQ9EgAgAtXfRgagQ9Ef+gBtXfRgagQ9Ef7gCtXfRgagQ9Ef6gDtXfRgagQ9Ef5gDtXfRgagQ9Ef6gDtXfR
					gagQ9Ef+gBtXfRgagQ9EgJf8tXfRgagQ9EgSf4tXfRgagQ9EgUf3tXfRgagQ9EgTf3tXfRgagQ9EgSf3tXfRgagQ9EgSf4tXfRgagQ9EgRf4tXfRgagQ9EgR
					f4tXfRgagQ9EgRf4tXfRgagQ9EgSf4tXfRgagQ9EgSf3tXfRgagQ9EgTf3tXfRgagQ9EgUf3tXfRgagQ9EgQf5tXfRgagQ9EgFf+tXfRgagQ9Ef8gCtXfRga
					gQ9Ef6gDtXfRgagQ9Ef5gDtXfRgagQ9Ef6gDtXfRgagQ9Ef7gCtXfRgagQ9Ef+gBtXfRgagQ9EgAgAtX]],
				["Toe.L"] = [[
					fRgPgG/8gDf9htfRgPgG/8gGf6htfRgPgG/8gJf3htfRgPgG/8gKf1htfRgPgG/8gLf0htfRgPgG/8gMf0htfRgPgG/8gLf0htfRgPgG/8gKf1htfRgPgG/8
					gJf3htfRgPgG/8gGf6htfRgPgG/8gDf9htfRgPgG/8gAgAhtfRgPgG/8f+gChtfRgPgG/8f8gEhtfRgPgG/8f7gFhtfRgPgG/8f7gGhtfRgPgG/8f7gFhtfR
					gPgG/8f/gBhtfRgPgG/8gHf5htfRgPgG/8gOfyhtfRgPgG/8gPfwhtfRgPgG/8gPfxhtfRgPgG/8gOfxhtfRgPgG/8gOfyhtfRgPgG/8gNfyhtfRgPgG/8gN
					fyhtfRgPgG/8gNfyhtfRgPgG/8gOfyhtfRgPgG/8gOfxhtfRgPgG/8gPfxhtfRgPgG/8gPfwhtfRgPgG/8gMf0htfRgPgG/8gEf8htfRgPgG/8f9gDhtfRgP
					gG/8f7gFhtfRgPgG/8f7gGhtfRgPgG/8f7gFhtfRgPgG/8f8gEhtfRgPgG/8f+gChtfRgPgG/8gAgAht]],
				["UpperLeg.R"] = [[
					gthKgK7fjTgFwCguhMgI6xjXfdxLguhOgG6Djbe7yNgvhPgF5bjdegzDgvhQgF4/jfeOzmgvhQgE40jgeIzygvhQgF4/jfeOzmgvhPgF5bjdegzDguhOgG6D
					jbe7yNguhMgI6xjXfdxLgthKgK7fjTgFwCgshIgL8IjQgwu4gshGgN8pjPhYt0grhFgO9AjPh3s9grhEgP9PjQiLsZgqhEgP9TjRiSsMgrhEgP9PjQiLsZgr
					hEgO9EjWhrs2gshEgN89jkg+tEgthDgN9Djygls1gthCgN9Jj2ghsngthDgN9Fj0ggswgthDgN9Cjzgfs4gthEgN8/jyges/gthEgN89jxgdtDgthEgN89jx
					gdtEgthEgN89jxgdtDgthEgN8/jyges/gthDgN9Cjzgfs4gthDgN9Fj0ggswgthDgN9Gj1ghstgthEgN87jtgntIgshFgN83jehGtTgrhFgO9CjShzs6grhE
					gP9PjQiLsZgqhEgP9TjRiSsMgrhEgP9PjQiLsZgrhFgO9AjPh3s9gshGgN8pjPhYt0gshIgL8IjQgwu4]],
				["LowerLeg.R"] = [[
					gxgvf6rzfBf+9ugwgwf7sQfOfp9igwgxf8szfYfZ9Tgwgxf8tTfgfN9Fgwgyf9tsfnfH85gwgyf9t0fpfF81gwgyf9tsfnfH85gwgxf8tTfgfN9Fgwgxf8sz
					fYfZ9Tgwgwf7sQfOfp9igxgvf6rzfBf+9ugxgvf6reezgV91gxguf6rSemgs95gxguf5rOechB95gxguf5rOeWhO94gxguf5rOeUhT94gxguf5rOeWhO94gx
					guf5q+efg0+Agxgtf4qZergO+Ogxgsf4p4eyf4+Zgxgsf4p0e0fz+bgxgsf4qAe0fz+Xgxgtf4qKe1f0+Ugxgtf4qSe2f0+Rgxgtf4qYe2f0+Pgxgtf4qae2
					f0+Ogxgtf4qYe2f0+Pgxgtf4qSe2f0+Rgxgtf4qKe1f0+Ugxgsf4qAe0fz+Xgxgsf4p2e0fz+agxgtf4qGeyf8+Vgxguf5qrepgY+Igxguf5rIedg898gxgu
					f5rOeWhO94gxguf5rOeUhT94gxguf5rOeWhO94gxguf5rOechB95gxguf6rSemgs95gxgvf6reezgV91]],
				["Foot.R"] = [[
					gvgagQ9Ef8gCtXgvgagQ9EgCf/tXgvgagQ9EgGf9tXgvgagQ9EgLf7tXgvgagQ9EgPf5tXgvgagQ9EgQf5tXgvgagQ9EgPf5tXgvgagQ9EgLf7tXgvgagQ9E
					gGf9tXgvgagQ9EgCf/tXgvgagQ9Ef8gCtXgvgagQ9Ef2gFtXgvgagQ9EfxgHtXgvgagQ9EfugItXgvgagQ9EfsgJtXgvgagQ9EfsgJtXgvgagQ9EfsgJtXgv
					gagQ9EfsgJtXgvgagQ9EfsgJtXgvgagQ9EfsgJtXgvgagQ9EfsgJtXgvgagQ9EftgJtXgvgagQ9EfugJtXgvgagQ9EfugItXgvgagQ9EfvgItXgvgagQ9Efv
					gItXgvgagQ9EfvgItXgvgagQ9EfugItXgvgagQ9EfugJtXgvgagQ9EftgJtXgvgagQ9EfsgJtXgvgagQ9EftgJtXgvgagQ9EftgJtXgvgagQ9EftgJtXgvga
					gQ9EfsgJtXgvgagQ9EfsgJtXgvgagQ9EfsgJtXgvgagQ9EfugItXgvgagQ9EfxgHtXgvgagQ9Ef2gFtX]],
				["Toe.R"] = [[
					gvgPgG/8f9gDhtgvgPgG/8gBf/htgvgPgG/8gFf7htgvgPgG/8gIf4htgvgPgG/8gLf0htgvgPgG/8gMfzhtgvgPgG/8gLf0htgvgPgG/8gIf4htgvgPgG/8
					gFf7htgvgPgG/8gBf/htgvgPgG/8f9gDhtgvgPgG/8f4gIhtgvgPgG/8f1gMhtgvgPgG/8fygOhtgvgPgG/8fxgQhtgvgPgG/8fxgQhtgvgPgG/8fxgQhtgv
					gPgG/8fxgQhtgvgPgG/8fxgQhtgvgPgG/8fxgQhtgvgPgG/8fxgQhtgvgPgG/8fxgPhtgvgPgG/8fygPhtgvgPgG/8fygOhtgvgPgG/8fzgOhtgvgPgG/8fz
					gOhtgvgPgG/8fzgOhtgvgPgG/8fygOhtgvgPgG/8fygPhtgvgPgG/8fxgPhtgvgPgG/8fxgQhtgvgPgG/8fygPhtgvgPgG/8fygPhtgvgPgG/8fygPhtgvgP
					gG/8fxgQhtgvgPgG/8fxgQhtgvgPgG/8fxgQhtgvgPgG/8fygOhtgvgPgG/8f1gMhtgvgPgG/8f4gIht]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAhmgZACe5gKgfgAhogZADfHhCgdgAhtgZAFffhwgdgAhwgZAGf9iKgegAhxgZAGgbiMgggAhvgZAFg0h2ghgAhqgZAEhFhLgigAhngZADhJgUgggAhngZAD
					hBfZgegAhqgZAEguelgdgAhvgZAFgSeBgdgAhxgZAGf0dygfgAhwgZAGfYd8ghgAhtgZAFfCedgigAhogZADe3fPgh]],
				Spine1 = [[
					gAhngJAZe7gTkwf/hpgJAafLg1k4f+htgJAeflhNlMf+hxgJAhgEhYlff+hygJAighhTlkf+hvgJAgg4hAlZf/hrgJAchGgilEgAhngJAZhIf/kzgBhngJAZ
					g+fbkygBhrgJAcgpe+lBgChvgJAggMeslWgChygJAifteplkgChxgJAhfSe1lhgChtgJAee/fOlPgBhpgJAbe3fvk6]],
				Spine2 = [[
					f/hwfrBOe+gbomf9hyfrBSfJgno3f8h3frBeffgspef7h8frBpf8goqCf7h9fsBsgXgcqMf9h6frBkgugNp0f+h1frBYg9f8pKgAhxfrBPhDfsorgChxfrBP
					g+feoqgEh0frBXgtfVpJgFh6frBkgTfVpzgFh9fsBsf2fdqLgEh8frBpfdfrqDgDh3frBefJf7pfgBhyfrBSe/gMo3]],
				Neck1 = [[
					f+h5fcD/fGgqvYf8h7fcDyfTgyvBf7iBfdETfqgyv9f7iGfeFQgGgoxhf7iHfeGCgfgUyrf9iEfdGEgwf+ysf+h+fdFTg5frxkgBh6fcEVg8fcwAgDh5fcDy
					g1fSvCgFh+fdD9gjfNvWgFiEfdEwgIfSwugFiHfeFtftfhyNgEiGfeGKfYf3y2gDiBfdFwfLgMyQgAh7fcEyfEgdwy]],
				Neck2 = [[
					f8iUfLF6fLgwyef6iVfLF8fZg3ygf5icfNGZfwg0zJf6ijfRHAgKgnz8f7ilfUHXgggS0Yf9iifTHNgvf70MgAibfQGpg4fnzegDiVfMGFg4fWytgFiUfKF3
					gvfLyZgGiYfMGIgcfJyxgHigfPGtgDfRzkgGilfTHPfrfj0PgEikfUHWfXf50XgBiffSG9fLgPz4f/iYfOGVfHgizE]],
				Head = [[
					f6iufCAFe6gNhvf4iwfBAGfAf2h8f4i3fFAHfTfhiVf5i+fLAJfvfRipf7jBfOAJgNfIisf+i+fOAIgmfKiagCi2fJAGg5fWiBgEiwfDAFhFfphwgHiufBAF
					hFf/hzgIizfDAGg4gViIgIi7fIAIgggoihgGjAfNAJgCg1itgDjAfPAJfmg4ilgAi6fMAHfPgxiOf9izfGAGfAgih3]],
				Jaw = [[
					f6ixeW/1hHf+i/f5izeW/2g+gTiyf5i7ea/4gogliff7jDef/3gJgyiwf+jGej/2fqg1i2gBjCei/3fSgviugDi5ed/2fBghitgFiyeY/1e5gNi9gHixeV/1
					e8f3i7gHi3eX/3fMfjimgGjAed/3fnfUiogEjGei/2gHfMi1gBjFej/2gjfNi0f+i+eg/3g4fWilf8i1ea/2hEfoi3]],
				Crest = [[
					fxkpecKrfXg730fxkredLCeYhj4Df0kzekLteFhc4nf5k7esMTepgc5Kf/k+ewMbfufA5SgFk6etMCgvd544gKkyelLUhMds4RgOkqeeKxg8ee32gPkpecKw
					gTfv36gOkvegLVfzgz4ZgKk4eoMEf2hL4/gEk9evMcgagz5Tf+k9evMPhAgJ5If4k2eqLlhHf04lf0kuehK6gfgJ4D]],
				["UpperArm.L"] = [[
					fWhyfQuwN9mB1FfUh1fRvPN8lX04fSh8fSwcNojy0BfSiDfSx1NMhxyqfSiFfSzAMyf4xHfUiDfSzxMdegvxfWh9fR0JMNdwu1fYh5fQ0TMBdiuVfbh4fP0V
					L7dsuMfch9fP0OL8eOudfdiCfPz3MFfMvNfdiFfQzGMUgowcfciCfQx4MribyAfbh8fQwbNKkQzhfYh1fQvNNqll0m]],
				["LowerArm.L"] = [[
					fEhZfO+9hHgJn/fChcfO/ZhCf2mCfAhkfM/5gufjiYe/hsfJ/6gOfbd9e+hyfF/ZftfhZ5e/hyfC+sfSfyXAfBhue/+NfDgHVhfEhqe9+Je+gYVVfGhqe9+c
					fDgkWQfJhte9+/fSgpYHfKhxe+/kfngoa5fLhxfB/8gAgkecfKhsfF/5gZghiUfJhkfJ/dgugdlvfHhcfM/Ag/gXn1]],
				["UpperArm.R"] = [[
					gnh4fP0V0DicuOgkh6fP0T0FiGuRgjh/fP0F0AhXuwgiiEfQziz0gKvxgjiEfQyizhegxNgkiAfQxKzGcpyygmh4fQvwylbA0IgphzfQu3yKaE07grhzfQu4
					yBaM1Egth4fRvyyNbW0iguiAfSxJymdOzZguiFfTyezBfPx4gtiFfSzczZg5wZgriAfRz/zsh8vPgph6fQ0Qz6iaui]],
				["LowerArm.R"] = [[
					g7hpe9BwfAgfqVg4hre9BUfJgno8g2hve+Aufcgpmng2hxfAANfzgmjbg2hvfDABgNgifog3hofHATgkgfb3g4hgfLA0g3gbZAg6hafNBGhEgRX1g9hafOA4
					hHgAYwg/hffNAVg6fsbphBhofKACgffdf0hChwfHATf9fckMhBhyfEA+fefpnvhAhwfBBnfJf8p7g9hse+B5e/gQqu]],
				Tail1 = [[
					gAhogvd0hThD/3gBhqgvc5gzhA/0gChvgvcmgMgw/zgDhygvdHfjgX/2gDhzgveHe/f9/6gDhxgve6elfk/8gChsgvfAeafP/7gBhpgveUeifB/5f/hpgvdU
					e8e9/1f+hsgvcpfgfH/zf9hxgvcxgJfc/0f9hzgvdmgvf2/5f9hygvelhPgQ/7f+hugvfEhjgn/7f/hqgvevhkg5/6]],
				Tail2 = [[
					gChshNdnj+gx/pgDhwhMbyibg3/mgDh1hMapgfgu/hgCh4hMa8eggZ/jgBh3hMcfcxgA/ogAhzhNeRbjft/of/huhNfFbFfg/mf+hshNeabgfV/of9huhMcr
					cvfL/of9hyhMbDehfM/jf+h3hMamghfb/hf+h4hMbnibf0/mf/h1hNdbj7gK/pgBhwhNe2kzga/mgChshNe7k0gl/m]],
				Tail3 = [[
					gKhxhpb4nNgz+4gHh4hpZmlSgv+4gDh/hoXhifgk+vf/iBhoXBfTgJ+sf7h9hpYbcPfm+2f4h2hpa0ZyfM+8f2hwhpcnYYfF+3f2hvhpcnYTfL+2f4h0hpa0
					ZnfP+5f7h8hoYccCfV+0f/iBhoXBfGfn+sgDiAhpXhiSgI+wgHh6hpZmlGgq+6gJhyhpb5nFg6+6gKhvhpc3n2g5+2]],
				Tail4 = [[
					gWh5iDYop5hz9dgQiEiCWmochQ9XgHiOiBUBligs9If+iRiBSkhuf98+f1iLiDTKdqe/9MftiAiDVeZ9eG9ifoh2iDX9XPdu9nfoh1iDY9WDd99gfsh+iDXz
					Woef9bf0iJiCVRY3fC9Qf9iRiBTEcUfp9BgHiPiCSmgVgh9CgQiFiDULkShg9YgWh6iDW0nkiL9ngYh1iDYupliO9j]],
				["UpperLeg.L"] = [[
					fWg7gP2Rcfgt2sfVg9gR33cZfs0/fThDgT6wcPemxFfShIgV+BcIdJp7fRhKgV/Xcdbpi3fQhJgU/hc9bhf2fQhFgS/qc9cmgAfQhCgP/pckeKilfRhBgN/S
					b+fUlOfShEgL+mbcgSoKfUhHgJ9ObNhNsDfVhJgI7pbLhvvQfWhHgJ6YbQh3xXfXhCgK5Tbehqy/fWg9gM38b4hQ0y]],
				["LowerLeg.L"] = [[
					fSgcgPg0fwfi/+fQgfgNdAg1fP/1fNgngGdAiHfV/xfKg2f8iejngE/sfIhGf3q9k2hR9ofHhKf2xCk5iH6ifJhGfz0Qj5iI4WfMg9fx1ciahq3jfOg4fvzm
					hChU5PfQg1fvv/f8hA7sfSgyfztZfDgt9CfUgvf4rTeggf94fUgqf8oleXgQ+xfUgkgBlGenf9/jfTgegIh/fIfu/6]],
				["Foot.L"] = [[
					fRgagt9Ce7ggtXfRgkgr8hf7gCuffRgtgk8GhLfXvPfRgygZ7yieeovnfRgzgN7njmd+vnfRgwgC7tj6d1vXfRgpf58HjMeUu1fRggf08uhyfJt8fRgaf39E
					gcfztXfRgaf/9DfZgStXfRgagG9BekgqtWfRgagO9AeDg5tVfRgagW8/d4g/tVfRgage8/eBg7tVfRgagm9BeZgvtW]],
				["Toe.L"] = [[
					fRgPgk/7fMg3htfRgYgi/2f9gEi9fRgggc/vg3e/j0fRglgR/lhyd0kRfRgmgF/bimcykVfRgjf6/ai1cjkDfRgdfw/miWdRjafRgUfq/1hWeiiYfRgPft/8
					gVfqhtfRgPf1/8figfhtfRgPf9/6e6hJhtfRgPgF/3ehhjhtfRgPgM/3eYhthtfRgPgU/3efhlhtfRgPgc/5eyhSht]],
				["UpperLeg.R"] = [[
					gwhBgO/ajqhCkvgvhCgM/CkWgPmcgthGgK9+kufOqHgshIgJ8ak2eetzgqhIgI69kzeKwbgqhEgJ52kqeOyLgpg/gL4qkXeiz2gqg7gO3Ij2fB1vgrg8gQ27
					jjf02BgshAgT5Jjsg2zagthGgU8gj2iEt2gvhKgV++jyjul/gwhKgU/ejQkog3gwhHgT/li/kDfngwhDgR/tjOiphA]],
				["LowerLeg.R"] = [[
					gzg4fw1keYep3hgxg2fvxsfie16ogvgzfxujgjfL8egtgwf1sXhRfa9egsgtf6qEhofo+Ugsgnf/m5hjf5/NgtghgEjZhKgL/ygugdgLhFglgY/9gvgdgPei
					fvgq/8gygigKcaekgy/vg0gugBfAdKgZ/2g3g/f5mxbrfW+9g5hJf3uaa9eN8Dg4hJf1y9bhdz5Rg2hCfy1Dc1eF3z]],
				["Foot.R"] = [[
					gvgafz9DfAgetXgvgaf79EgHf9tXgvgagD9ChEfhtXgvgagK9AhvfNtWgvgagS8/iFfDtVgvgaga8/iGfCtVgvgagi9Ah1fKtWgvgagp9ChWfYtWgvgggt8x
					gnftt+gvgpgo8SfegSu7gvgwgf77eMhBvegvgzgT7rc7hwvqgvgygH7ncHiMvhgvgtf974cWh/vIgvgkf18adfhSuc]],
				["Toe.R"] = [[
					gvgPfp/7fPgzhtgvgPfx/8gFf6htgvgPf5/7g0fKhtgvgPgB/4hVenhtgvgPgI/3hleWhtgvgPgQ/3hmeVhtgvgPgY/4hZejhtgvgPgg/6hBe7htgvgUgj/5
					gdfgiYgvgdgf/zfngdjcgvgjgX/qeshnkFgvgmgM/fdyiwkWgvglf//ZdMjekPgvggf0/fdVjNjygvgYft/ueIiIi8]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAhvgZ/+gAgAhMgAhfgZ/8fye2hMgAhjgZ/7fseXhMgAhygZ/8fye2hMgAhvgZ/+gAgAhMgAhfgZ/8gOhKhMgAhjgZ/7gUhphMgAhygZ/8gOhKhM]],
				Spine1 = [[
					gAhugJAQgAgAjzf/hegJAMgYhIjCf+hhgJAOgihljNf/hxgJASgahHj+gAhugJAQgAgAjzgBhegJAMfoe4jCgChhgJAOfeebjNgBhxgJASfme5j+]],
				Spine2 = [[
					gAh1fqBIgAgAoXf9hkfqAyghhEm3f7hofqA4gvhgnNf9h5fqBQgkhCosgAh1fqBIgAgAoXgDhkfqAyffe8m3gFhofqA4fRegnNgDh5fqBQfce+os]],
				Neck1 = [[
					gAh+fbFYgAgAxvf8hrfbD0gyg5vFf6hvfbELhIhPvrf8iCfcFyg4gzySgAh+fbFYgAgAxvgEhrfbD0fOfHvFgGhvfbELe4exvrgEiCfcFyfIfNyS]],
				Neck2 = [[
					gAibfPH4gAgA1Af7iGfJF/g5gyykf5iLfLGahShFzHf8igfRIWg+gr1ggAibfPH4gAgA1AgFiGfJF/fHfOykgHiLfLGaeue7zHgEigfRIWfCfV1g]],
				Head = [[
					gAi3fLARgAgAj7f7igfAAHgVgjiZf5imfDAJgfgwiuf8i8fOAUgbghkRgAi3fLARgAgAj7gFigfAAHfrfdiZgHimfDAJfhfQiugEi8fOAUflffkR]],
				Jaw = [[
					gAi/eh/4gAgAirf5ikeU/Uf2fZmff3ireX/efvfJlpf7jFek/7fsfah1gAi/eh/4gAgAirgHikeU/UgKgnmfgJireX/egRg3lpgFjFek/7gUgmh1]],
				Crest = [[
					gAk2e3MGgAgA5Cf8kdefLwe+iC4qf6kjekMvg5gJ5hf+k7e8NNibeR5tgAk2e3MGgAgA5CgEkdefLudvhw4kgGkjekMvfHf35hgCk7e8NPhGeK50]],
				["UpperArm.L"] = [[
					fYh6fPrSONnq20fThnfSoHQUpq43fRhrfTo8QUo443fTh/fSsHOsmd3IfYh6fPrSONnq20fdhlfMnpOsqo3gffhqfLoXOFqU27fdh9fNr6NRnt1t]],
				["LowerArm.L"] = [[
					fEhifTAOgAgAjlfAhRfeADgPhKe9e+hWfeAEgYhof/e/hnfWAYgbhHkmfEhifTAOgAgAjlfJhPfVADfxe2e9fMhTfSAEfoeYf/fKhlfOAYfle5km]],
				["UpperArm.R"] = [[
					goh6fPrSxzYW20gjhlfMnpxUVY3gghhqfLoXx7Vs27gjh9fNr6yvYT1tgoh6fPrSxzYW20gthnfSoHvsWW43gvhrfTo8vsXI43gth/fSsHxUZj3I]],
				["LowerArm.R"] = [[
					g8hifTAOgAgAjlg3hPfVADgPhKe9g0hTfSAEgYhof/g2hlfOAYgbhHkmg8hifTAOgAgAjlhAhRfeADfxe2e9hChWfeAEfoeYf/hBhnfWAYfle5km]],
				Tail1 = [[
					gAhzgvezg4f1/9gChjgvdDgef8/2gChngvdUfygC/4gCh2gvfFfPgK/+gAhzgvezfIgL/9f+hjgvdDfigE/2f+hngvdUgOf+/4f+h2gvfFgxf2/+]],
				Tail2 = [[
					gCh1hMg9itfg/3gDhphMd9hHf0/6gChshMc+e2gJ/0gAh4hMf/dQgY/3f+h1hMg9dTgg/3f9hphMd9e5gM/6f+hshMc+hKf3/0gAh4hMf/iwfo/3]],
				Tail3 = [[
					gHhzhqgqkwfj/ogFhthqd6i1fq/ygAhxhpbLfOgD/nf7h4hqd7cEgK/rf5hzhqgqbQgd/of7hthqd6dLgW/ygAhxhpbLgyf9/ngFh4hqd7j8f2/r]],
				Tail4 = [[
					gPhyiGdxmHgS/UgKhwiHclk6f9/bf+h6iGZBgzgB/Nf0h8iGaNcNft/OfxhyiGdxZ5fu/Uf2hwiHclbGgD/bgCh6iGZBfNf//NgMh8iGaNjzgT/O]],
				["UpperLeg.L"] = [[
					fThGgTz7c8gx41fSg3gWsdcPc/9EfRg7gXFQjypAulfShKgWAPitiOevfThGgTASjXf/dsfUg1gQAflVggfGfVg4gOGpkheSNHfUhIgQR4iPdwDf]],
				["LowerLeg.L"] = [[
					fPgngZbYhFfs/ofJghgrFlmte5wsfGhUgKG6YNeMN3fNhIf3EZdAfVQJfShBf0AHfdgQdnfTg0fwQ4g9gCD2fSgbgFf2gff4ABfSgvgiZGgjfyAy]],
				["Foot.L"] = [[
					fRgwg28PgUf1vBfRg7gd1jxrWDsIfRg6gA62nkbwvEfRgufo8Mikequ1fSg9fW/Tfkf2mlfRgagB9BeVgxtWfRgagj9Ce5ghtXfRgjg+8Be1gpvY]],
				["Toe.L"] = [[
					fRgkgu/ygPfvjjfRgugW4gsxQPjVfRguf4+hleZRkGfRgifg/rh5dzjZfSg3fI/hfigBalfRgPf3/5evhVhtfRgPga/7fKg5htfRgWg2/tfKhCj+]],
				["UpperLeg.R"] = [[
					gthGgT/ujXf/iUgsg1gQ/hlVggg6grg4gO5XkheSy5gshIgQuIiPdw8hgthGgTz7jEfP41gug3gWsdjxjB9Egvg7gXFQcOXAulguhKgWAPdTdyev]],
				["LowerLeg.R"] = [[
					guhBf0/5fdgQiZgtg0fwvIg9gC8KgugbgFgKgff4//gugvgim6gjfy/OgxgngZbYe7gU/og3ghgrFlZThHwsg6hUgKG6nzh0N3gzhIf3EZjAgrQJ]],
				["Foot.R"] = [[
					gug9fW/TgcgKmlgvgagB9BhrfPtWgvgagj9ChHfftXgvgjg+8BhLfXvYgvgwg28PfsgLvBgvg7gd1jOVp9sIgvg6gA62YckQvEgvgufo8MdchWu1]],
				["Toe.R"] = [[
					gug3fIAffigBlbgvgPf3AHevhVeTgvgPgaAFfKg5eTgvgWg2ATfKhCcCgvgkguAOgPfvcdgvgugWHgsxQPcrgvguf4BfleZRb6gvgifgAVh5dzcn]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAhygZAHgAgAicgAhvgcAJgAgAi0gAhmgiAPgAgAjugAhdgpAXgAgAksgAhZgtAcgAgAlMgAh2gGABgAgAgrgAiEftAFgAgAd/gAiEftAFgAgAd/gAiEftAF
					gAgAd/gAiDfwAEgAgAeSgAh+f7ABgAgAfcgAh4gKACgAgAg+gAh0gWAGgAgAiJgAhygZAHgAgAicgAhygZAHgAgAicgAhygZAHgAgAic]],
				Spine1 = [[
					gAh1gJA0gAgAnFgAhygMA3gAgAnTgAhqgTA/gAgAn2gAhigaBJgAgAoagAhegeBOgAgAotgAh2f2AggAgAligAiCfdANgAgAjggAiCfdANgAgAjggAiCfdAN
					gAgAjggAiBfgAPgAgAjwgAh+frAXgAgAksgAh5f7AkgAgAl7gAh2gGAwgAgAm2gAh1gJA0gAgAnFgAh1gJA0gAgAnFgAh1gJA0gAgAnF]],
				Spine2 = [[
					gAiDftCEgAgArQgAiAfwCFgAgArUgAh5f3CKgAgArfgAhyf/COgAgArrgAhugDCRgAgArxgAiBfYBmgAgAp7gAiJe+BMgAgAomgAiJe+BMgAgAomgAiJe+BM
					gAgAomgAiJfBBQgAgAoygAiHfNBdgAgApfgAiFfdBwgAgAqZgAiDfpCAgAgArFgAiDftCEgAgArQgAiDftCEgAgArQgAiDftCEgAgArQ]],
				Neck1 = [[
					gAiOfgFMgAgAxbgAiLfjFmgAgAyDgAiFfqGrgAgAzigAh+fyH6gAgA1DgAh6f2ImgAgA1zgAiLfKEAgAgAvdgAiSevCJgAgAregAiSevCJgAgAregAiSevCJ
					gAgAregAiSeyCUgAgAr5gAiRe/DAgAgAtggAiPfPEDgAgAvjgAiOfcE8gAgAxDgAiOfgFMgAgAxbgAiOfgFMgAgAxbgAiOfgFMgAgAxb]],
				Neck2 = [[
					gAirfTG7gAgAz3gAipfXHmgAgA0rgAijfiJVgAgA2kgAidfuLVgAgA4agAiaf0McgAgA5UgAime5FXgAgAxtgAineYCpgAgAssgAineYCpgAgAssgAineYCp
					gAgAssgAioebC4gAgAtNgAipeqD2gAgAvLgAiqe/FUgAgAxogAirfPGlgAgAzbgAirfTG7gAgAz3gAirfTG7gAgAz3gAirfTG7gAgAz3]],
				Head = [[
					gAjGfMAFgAgAh8gAjFfTANgAgAjbgAjAfiAzgAgAnDgAi5fzB5gAgAqzgAi1f7CpgAgAssgAjAeuACgAgAhCgAi8eEAYgAgAbRgAi8eEAYgAgAbRgAi8eEAY
					gAgAbRgAi9eJAUgAgAbtgAjAebAIgAgAddgAjEe0ABgAgAfvgAjGfHADgAgAhggAjGfMAFgAgAh8gAjGfMAFgAgAh8gAjGfMAFgAgAh8]],
				Jaw = [[
					gAjJeh/8gAgAhqgAjMen/+gAgAg5gAjQe6/+gAgAe6gAjTfP/zgAgAcjgAjTfc/rgAgAbfgAjBeC8OgAgAvEgAitdb8+gAgAtkgAitdb+dgAgApxgAitdb+J
					gAgAqtgAivdf+1gAgAoigAi3dw/ZgAgAmHgAjBeI/wgAgAj3gAjIec/7gAgAiHgAjJeh/8gAgAhqgAjJeh/8gAgAhqgAjJeh/8gAgAhq]],
				Crest = [[
					gAlCeoKqgAgA30gAlDe6MUejhj5HgAlAfnQKfBg47wgAk1gWTphFfQ9egAkrguUoh2e990gAk5eDJ/gAgA3NgAkecxGme/h3zUgAkecxHLfahL0IgAkecxHL
					gme10IgAkhc4G3hDeKzrgAktdWHigAgA0mgAk5d/Jjevht2sgAlAegLjfMhC4kgAlCeoL6g1e/42gAlCeoLKhZeZ4LgAlCeoKqgAgA30]],
				["UpperArm.L"] = [[
					fYiMfTzYMogAwffYiKfWz+MQeTvMfYiDfd1CL+Z8r9fYh9fl1jMwVQojfYh5fp1kNnS2m1fYiJe919MlaargfYiOej2fNFb0r6fYiOej2fNFb0r6fYiOej2f
					NFb0r6fYiOem2UNBcFsPfYiOey1lM1dLtffYiNfD0hMrenvEfYiMfQzoMofuwNfYiMfTzYMogAwffYiMfTzYMogAwffYiMfTzYMogAwf]],
				["LowerArm.L"] = [[
					fEh5fEADgAgAhPfDh5fFAZgwf/k1fBh7fJDBilgFtTfAh+fSIUkggY1Be/h/fYL8lfgn4SfDiAeoAshWgZmafEiDeNADgAgAecfEiDeNADgAgAecfEiDeNAD
					gAgAecfEiCeRADgAgAeofEh/efABgAgAfXfEh8eyABgAgAgUfEh5fAACgAgAhDfEh5fEADgAgAhPfEh5fEADgAgAhPfEh5fEADgAgAhP]],
				["UpperArm.R"] = [[
					goiMfTzYzYgAwfgoiKfWz+zwhtvMgoiDfd1C0CmEr9goh9fl1jzQqwojgoh5fp1kyZtKm1goiJe919zblmrggoiOej2fy7kMr6goiOej2fy7kMr6goiOej2f
					y7kMr6goiOem2Uy/j7sPgoiOey1lzLi1tfgoiNfD0hzVhZvEgoiMfQzozYgSwNgoiMfTzYzYgAwfgoiMfTzYzYgAwfgoiMfTzYzYgAwf]],
				["LowerArm.R"] = [[
					g8h5fEADgAgAhPg9h5fFAZfQgBk1g/h7fJDBdbf7tThAh+fSIUbgfo1BhBh/fYL8ahfZ4Sg9iAeoAseqfnmag8iDeNADgAgAecg8iDeNADgAgAecg8iDeNAD
					gAgAecg8iCeRADgAgAeog8h/efABgAgAfXg8h8eyABgAgAgUg8h5fAACgAgAhDg8h5fEADgAgAhPg8h5fEADgAgAhPg8h5fEADgAgAhP]],
				Tail1 = [[
					gAhygvgpgAgA//gAhugygogAgA//gAhkg4glgAgA//gAhZg/gigAgA//gAhUhDgggAgA//gAh3gcdcgAgA/4gAiJgCcMfOgI/wgAiJgCdcfVgF/4gAiJgCdc
					grf7/4gAiIgFd0hlf1/4gAiCgRfKhXf6/8gAh5ghgfgPgA//gAhzgshIfqgA/+gAhygvg1f4gA/+gAhygvgpgAgA//gAhygvgpgAgA//]],
				Tail2 = [[
					gAhwhNgggAgA//gAhshQgGgAgA//gAhjhWfFgAgA/+gAhZhdeAgAgA/7gAhThhddgAgA/4gAh8g5b5gAgA/uf/iRgfcDebgQ/tf/iOggejepgK/7gBiOggej
					hXf2/7gDiMgjfBjKfr/0gDiDgvgjiuf1/3gAh5g+hqgff//8f/hxhKhxfUgA/7gAhwhNg4fwgA/+gAhwhNgggAgA//gAhwhNgggAgA//]],
				Tail3 = [[
					gAhvhreYgAgA/8gAhshtdlgAgA/5gAhkh0bogAgA/sgAhch7ZjgAgA/VgAhYh+YfgAgA/GgAiEhWYagAgA/Ef8iYg8Z+dogO/Uf8iRg9dsd+gG/2gEiRg9ds
					iCf6/2gJiOhAeSkwf1/lgIiChMf+kFgB/ugBh1hcg2gugC/+f+huhogce/f8/+f/huhre9fof//+gAhvhreYgAgA/8gAhvhreYgAgA/8]],
				Tail4 = [[
					gAhyiIaxgAgA/jgAhxiLZmgAgA/WgAhtiRWwgAgA+ngAhoiWT0gAgA9kgAhliYSUgAgA86gAiRhwTngAgA9ff3ijhXWec1f7+Xf4iVhabWdTf1/igIiVhabW
					itgL/igSiRhccGmSgf/HgPiChpd7lXgp/dgDh0h6eig8gK/8f8htiFdleqfw/3f/hwiIbhfgf7/rgAhyiIaxgAgA/jgAhyiIaxgAgA/j]],
				["UpperLeg.L"] = [[
					fThMgK7MczgAwifThJgL8Dcmfyu/fThBgQ9vcNfQrJfTg5gV+/b3ermqfTg1gX/abueVj+fThOf724dagt2MfThbfpy/d/hL5pfThbfpy/d/hL5pfThbfpy/
					d/hL5pfThafrzLd+hK5gfThVfz0Fd8hF4zfThQf/3Xddgs1sfThNgH6kc6gIxjfThMgK7MczgAwifThMgK7MczgAwifThMgK7MczgAwi]],
				["LowerLeg.L"] = [[
					fQgwf7sgg7gA9bfPgvf6rqhCgF9xfPgtf4qahOgQ+OfPgtf4qZhUgZ+OfPguf5rEhUgd9+fQguf5rTgofv96fRg9fysVgTfj9hfRg9fysVgTfj9hfRg9fysV
					gTfj9hfRg8fzsigTfk9bfRg3f6tmgUfk89fQgxf8tOglfu9IfQgwf7sbg4f99efQgwf7sgg7gA9bfQgwf7sgg7gA9bfQgwf7sgg7gA9b]],
				["Foot.L"] = [[
					fRgagQ9EgAgAtXfRgagQ9EgIf8tXfRgagQ9EgWf2tXfRgagQ9DgefytXfRgagQ9DgefytXfRgagQ9EfrgKtXfRgngH6tfbgZxlfRgngH6tfbgZxlfRgngH6t
					fbgZxlfRgmgI7DfagYxDfRgggN8QfYgVu/fRgagQ9EfogLtXfRgagQ9Ef8gCtXfRgagQ9EgAgAtXfRgagQ9EgAgAtXfRgagQ9EgAgAtX]],
				["Toe.L"] = [[
					fRgPgG/8gAgAhtfRgPgG/8gGf6htfRgPgG/8gQfvhtfRgPgG/8gWfphtfRgPgG/8gXfohtfRgPgG/8fwgRhtfRgagB/UfmglmgfRgagB/UfmglmgfRgagB/U
					fmglmgfRgYgC/cflgkl3fRgTgF/yfigjjhfRgPgG/8fugThtfRgPgG/8f9gDhtfRgPgG/8gAgAhtfRgPgG/8gAgAhtfRgPgG/8gAgAht]],
				["UpperLeg.R"] = [[
					gthMgK7MjNgAwigthJgL8DjagOu/gthBgQ9vjzgwrJgtg5gV+/kJhVmqgtg1gX/akShrj+gthOf7+bkMg/o6gthbfp/KknitbIgthbfp/KknitbIgthbfp/K
					knitbIgthafr/WkmikcZgthVfz/jkdh0iLgthQf/+Kj+g2p3gthNgH78jYgLvNgthMgK7MjNgAwigthMgK7MjNgAwigthMgK7MjNgAwi]],
				["LowerLeg.R"] = [[
					gwgwf7sgfFgA9bgxgvf6rqe+f79xgxgtf4qaeyfw+Ogxgtf4qZesfn+Ogxguf5rEesfj9+gxg9fgqSevfq+RgxhlfL07fAfa4LgxhlfL07fAfa4LgxhlfL07
					fAfa4LgxhhfNzve9fZ5JgxhSfVvae1fc8Agxg+flsLe0fr9jgxgzf2sKfAf79kgwgwf7sgfFgA9bgwgwf7sgfFgA9bgwgwf7sgfFgA9b]],
				["Foot.R"] = [[
					gvgagQ9EgAgAtXgvgagQ9Ef4gEtXgvgagQ9EfqgKtXgvgagQ9DfigOtXgvgagQ9DfigOtXgvgrf4+/fggIn8gvhHfQ/Ifrf7YqgvhHfQ/Ifrf7YqgvhHfQ/I
					frf7YqgvhEfU/cfmf7aHgvg4fl/+fegBgxgvgpf7+xfogHowgvgdgM9Zf6gDspgvgagQ9EgAgAtXgvgagQ9EgAgAtXgvgagQ9EgAgAtX]],
				["Toe.R"] = [[
					gvgPgG/8gAgAhtgvgPgG/8f6gGhtgvgPgG/8fwgRhtgvgPgG/8fqgXhtgvgPgG/8fpgYhtgvgkfr/uflgTb9gvhNfC6OfqgDNsgvhNfC6OfqgDNsgvhNfC6O
					fqgDNsgvhJfG7DfmgFO8gvg4fW+AfhgNU7gvghfu/0fsgPcygvgTgC/+f7gFg6gvgPgG/8gAgAhtgvgPgG/8gAgAhtgvgPgG/8gAgAht]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhygZAHgAgAicgAhwgZAFgAgAiCgAhrgZACgAgAhGgAhmgZABgAgAgVgAhngZABgAgAgegAhxgZAJgAgAi2gAh3gZAZgAgAk4gAh3gZAcgAgAlNgAh3gZAc
					gAgAlNgAh3gZAcgAgAlNgAh3gZAcgAgAlNgAh3gZAcgAgAlNgAh3gZAcgAgAlNgAh3gZAcgAgAlNgAh3gZAcgAgAlNgAh3gZAcgAgAlNgAh3gZAcgAgAlNgA
					h3gZAcgAgAlKgAh1gZATgAgAkMgAhzgZAJgAgAi4gAhygZAHgAgAicgAhygZAHgAgAicgAhygZAHgAgAic]],
				Spine1 = [[
					gAh1gJA0gAgAnFgAhygJAsgAgAmigAhsgJAdgAgAlQgAhmgJATgAgAkOgAhngJAVgAgAkagAh0gJA8gAgAnpgAh7gKBwgAgAqYgAh8gKB6gAgAq1gAh8gKB6
					gAgAq1gAh8gKB6gAgAq1gAh8gKB6gAgAq1gAh8gKB6gAgAq1gAh8gKB6gAgAq1gAh8gKB6gAgAq1gAh8gKB6gAgAq1gAh8gKB6gAgAq1gAh8gKB6gAgAq1gA
					h8gKB4gAgAqwgAh6gKBdgAgApegAh2gJA9gAgAnsgAh1gJA0gAgAnFgAh1gJA0gAgAnFgAh1gJA0gAgAnF]],
				Spine2 = [[
					gAiDftCEgAgArQgAh/fsB0gAgAqkgAh2frBUgAgApAgAhvfqA9gAgAnugAhwfrBBgAgAn9gAiCftCVgAgAr8gAiPfxD5gAgAvRgAiRfxEMgAgAvzgAiRfxEM
					gAgAvzgAiRfxEMgAgAvzgAiRfxEMgAgAvzgAiRfxEMgAgAvzgAiRfxEMgAgAvzgAiRfxEMgAgAvzgAiRfxEMgAgAvzgAiRfxEMgAgAvzgAiRfxEMgAgAvzgA
					iQfxEJgAgAvtgAiMfvDUgAgAuKgAiFftCWgAgAr/gAiDftCEgAgArQgAiDftCEgAgArQgAiDftCEgAgArQ]],
				Neck1 = [[
					gAiOfgFMgAgAxbgAiJffEXgAgAwGgAh/fdCxgAgAs+gAh3fbBugAgAqUgAh4fcB5gAgAqzgAiOfhFogAgAyGgAidfnJ3gAgA3FgAiffpKngAgA3ygAiffpKn
					gAgA3ygAiffpKngAgA3ygAiffpKngAgA3ygAiffpKngAgA3ygAiffpKngAgA3ygAiffpKngAgA3ygAiffpKngAgA3ygAiffpKngAgA3ygAiffpKngAgA3ygA
					iffoKfgAgA3qgAiZflIagAgA1ngAiRfhF7gAgAyhgAiOfgFMgAgAxbgAiOfgFMgAgAxbgAiOfgFMgAgAxb]],
				Neck2 = [[
					gAirfTG7gAgAz3gAilfPFsgAgAyMgAiXfHDUgAgAuJgAiKfCB2gAgAqpgAiMfDCFgAgArSgAisfVHmgAgA0rgAi9fpOFgAgA6ggAi/fsPPgAgA7PgAi/fsPP
					gAgA7PgAi/fsPPgAgA7PgAi/fsPPgAgA7PgAi/fsPPgAgA7PgAi/fsPPgAgA7PgAi/fsPPgAgA7PgAi/fsPPgAgA7PgAi/fsPPgAgA7PgAi/fsPPgAgA7PgA
					i/frPCgAgA7HgAi5fiL4gAgA43gAivfWIEgAgA1NgAirfTG7gAgAz3gAirfTG7gAgAz3gAirfTG7gAgAz3]],
				Head = [[
					gAjGfMAFgAgAh8gAi/fFACgAgAe8gAite2A/gAgAYNgAicesCygAgATAgAifeuCZgAgAT6gAjIfRAPgAfpjrgAjXfzESgXfJv8gAjYf5EgfPhxwNgAjYf5FM
					gPfgxcgAjYf5Fhgresx3gAjYf5EifShowSgAjYf5FBgAgAxLgAjYf5Fog0ebyAgAjYf5EnfahWwcgAjYf5E3fxggw6gAjYf5Frg5eSyEgAjYf5Eufkg+wqgA
					jYf4Ejflg9wZgAjUfoCmgWe1sggAjLfTAVgAgGkcgAjGfMAFgAgAh8gAjGfMAFgAgAh8gAjGfMAFgAgAh8]],
				Jaw = [[
					gAjJeh/8gAgAhqgAi6ea/mgAgAk+gAiWeR9lgAgAsLgAh6eR6vgAgAxjgAh/eQ7UgAgAwpgBjPem/of6gWk0gDj8fb/8fSgmesf7j9fi/7hke3f+gBj/fl/9
					fjgTejgEj/fm/5ewgzeCf7j9fi/8hce9f5gAj/fk/+gAgAe4gFkAfn/3egg9d3f8j9fi/9hNfJfuf/j+fj/+gdfsfMgFkAfn/2eXhCdxf9j+fj/+g3fZfef9
					j9fh/+g1fZfhgDjyfI/9fQg+fNgAjUep/9gBf7hRgAjJeh/8gAgAhqgAjJeh/8gAgAhqgAjJeh/8gAgAhq]],
				Crest = [[
					gAlCeoKfgAgA3rgAkyeKIrewht1ygAj9dRFHe9ijxGgAjFcyCzfthfs+gAjQc3DQgLfPt/gBlGe6NJhdd55tgCk/hAX/h/eL+2f8k+hHXnhbhi+zgBk2hQZI
					eZf9/MgDkzhTaVc7fg/Vf8k9hIZnezie/OgAk4hOa2gAgA/kgEkyhUbnhXdn/kf9k8hJYsjHgV+/f/k6hMYhhngB/DgEkyhVZweseY/Tf+k7hKY0eBh5/Df+
					k9hIZaeFh9/LgDlLgaVresfZ+PgAlKfCOFhGe96dgAlCeoLihxd54bgAlCeoK0haeb34gAlCeoKfgAgA3r]],
				["UpperArm.L"] = [[
					fYiMfTzYMogAwffYiHfSzjMof0wTfYh8fQz5MofZv3fYhyfP0LMpfDvgfYh0fP0IMpfGvkfYiNfU0iLqZksGfYiffbz7OIPqmSfYiifcziPaNjlHfYiifczi
					PaNjlHfYiifcziPaNjlHfYiifcziPaNjlHfYiifcziPaNjlHfYiifcziPaNjlHfYiifcziPaNjlHfYiifcziPaNjlHfYiifcziPaNjlHfYiifcziPaNjlHfY
					ihfczmPLN5lTfYiafY0bMUUNo6fYiQfUz/L5dMujfYiMfTzYMogAwffYiMfTzYMogAwffYiMfTzYMogAwf]],
				["LowerArm.L"] = [[
					fEh5fEADgAgAhPfEh0fDADgAgAhjfEhpfAAGgAgAiPfEhge/AJgAgAi0fEhie/AIgAgAiufBiGfACKjRgVrBe9ipfOLIoIic2te9iufTN8pFjL4le9iufTN8
					pFjL4le9iufTN8pFjL4le9iufTN8pFjL4le9iufTN8pFjL4le9iufTN8pFjL4le9iufTN8pFjL4le9iufTN8pFjL4le9iufTN8pFjL4le9iufTN8pFjL4le9
					itfSNdo7jD4Te+idfGGMmAhNx4fDiCfCAkhigClufEh5fEADgAgAhPfEh5fEADgAgAhPfEh5fEADgAgAhP]],
				["UpperArm.R"] = [[
					goiMfTzYzYgAwfgoiHfSzjzYgMwTgoh8fQz5zYgnv3gohyfP0LzXg9vggoh0fP0IzXg6vkgoiNfU0i0WmcsGgoiffbz7x4wWmSgoiifcziwmydlHgoiifczi
					wmydlHgoiifcziwmydlHgoiifcziwmydlHgoiifcziwmydlHgoiifcziwmydlHgoiifcziwmydlHgoiifcziwmydlHgoiifcziwmydlHgoiifcziwmydlHgo
					ihfczmw1yHlTgoiafY0bzsrzo6goiQfUz/0Hi0ujgoiMfTzYzYgAwfgoiMfTzYzYgAwfgoiMfTzYzYgAwf]],
				["LowerArm.R"] = [[
					g8h5fEADgAgAhPg8h0fDADgAgAhjg8hpfAAGgAgAiPg8hge/AJgAgAi0g8hie/AIgAgAiug/iGfACKcvfrrBhDipfOLIX4dk2thDiufTN8W7c14lhDiufTN8
					W7c14lhDiufTN8W7c14lhDiufTN8W7c14lhDiufTN8W7c14lhDiufTN8W7c14lhDiufTN8W7c14lhDiufTN8W7c14lhDiufTN8W7c14lhDiufTN8W7c14lhD
					itfSNdXFc94ThCidfGGMaAezx4g9iCfCAkeef+lug8h5fEADgAgAhPg8h5fEADgAgAhPg8h5fEADgAgAhP]],
				Tail1 = [[
					gAhygvgpgAgA//gAhwgvgigAgA//gAhsgvgTgAgA//gAhogvgHgAgA//gAhpgvgJgAgA//gAhwgvgmfxgA//gAhygvg4fagA/+gAhzgvg7hQf//9gAhzgvg7
					fpgA/+gAhzgvg7fDgB/9gAhzgvg7hJf//9gAhzgvg7gAgA/+gAhzgvg7e3gB/9gAhzgvg7g9f//9gAhzgvg7gXgA/+gAhzgvg7ewgB/9gAhzgvg7grgA/+gA
					hzgvg6grgA/+gAhygvg0fOgB/+gAhygvgsgEgA//gAhygvgpgAgA//gAhygvgpgAgA//gAhygvgpgAgA//]],
				Tail2 = [[
					gAhwhNgggAgA//gAhvhNgtgAgA//gAhrhNhLgAgA/+gAhohNhjgAgA/9gAhphNhfgAgA/9gAhuhNgBf7gA//f/hxhNeieUgD/6gChxhMeRh1gD/5f/hxhMeR
					gaf6/8f+hxhMeRd1gC/3gChxhMeRhZgE/6gAhxhMeRhBf6/7f+hxhMeRdxgB/3gChxhMeRg2gF/7gBhxhMeRhif7/6f+hxhMeRd5f//4gBhxhMeRgOgG/8gB
					hxhMeUh5f8/5f/hxhNfGe2f//9gAhwhNgJf8gA//gAhwhNgggAgA//gAhwhNgggAgA//gAhwhNgggAgA//]],
				Tail3 = [[
					gAhvhreYgAgA/8gAhthre6gAgA/+gAhphrgFgAgA//gAhlhrhCgAgA/+gAhmhrg3gAgA/+f/huhrdegVgA/4f8h0hqaQdof4/YgGh0hqZshQgX/VgAh0hqZs
					hrf2/Uf6h0hqZsdYfx/QgFh0hqZsghgW/WgCh0hqZsiNf8/Sf6h0hqZsdqft/RgDh0hqZsfwgT/XgEh0hqZsikgD/Qf6h0hqZseIfq/TgCh0hqZsfAgP/WgF
					h0hqZyiqgJ/Rf8hyhqbafNf2/pgAhwhrdpfvgA/5gAhvhreYgAgA/8gAhvhreYgAgA/8gAhvhreYgAgA/8]],
				Tail4 = [[
					gAhyiIaxgAgA/jgAhviIbmgAgA/rgAhpiIddgAgA/5gAhjiIe+gAgA/+gAhkiIetgAgA/9gAhziIZcgqgF/Tf3h+iGUpd+fc91gIiAiFT1f7gr9lgDiAiFT1
					iYgI9ff2iAiFT1eHfP9hgGiAiFT1fNgh9kgGiAiFT1ikgW9ef2iAiFT1erfN9jgDiAiFT1ejgV9jgIiAiFT1iigi9ef2iAiFT1fWfP9kgAiAiFT1eAgH9hgK
					h/iFT+iRgq9jf7h7iHWVgBfv+ff/h1iIZpfof9/WgAhyiIaxgAgA/jgAhyiIaxgAgA/jgAhyiIaxgAgA/j]],
				["UpperLeg.L"] = [[
					fThMgK7MczgAwifThJgL73cmf1vVfThDgN9GcLfgsvfTg+gP94b4fPqofTg/gP9wb7fSrAfThLgJ7Ncyf+wgfThTgE4Adngm1AfThUgD3Sdxgt1zfThUgD3S
					dxgt1zfThUgD3Sdxgt1zfThUgD3Sdxgt1zfThUgD3Sdxgt1zfThUgD3Sdxgt1zfThUgD3Sdxgt1zfThUgD3Sdxgt1zfThUgD3Sdxgt1zfThUgD3Sdxgt1zfT
					hUgD3advgs1qfThRgG5IdWgaznfThNgJ6wc7gGxRfThMgK7MczgAwifThMgK7MczgAwifThMgK7MczgAwi]],
				["LowerLeg.L"] = [[
					fQgwf7sgg7gA9bfPgvf6rkhBgF9zfPgsf4p4hMgN+ZfPgrf3o5hSgR+sfPgrf3pDhRgR+qfQgvf6ryg9gA9ufRg0gAvSggfu8GfRg1gBwAgafq7sfRg1gBwA
					gafq7sfRg1gBwAgafq7sfRg1gBwAgafq7sfRg1gBwAgafq7sfRg1gBwAgafq7sfRg1gBwAgafq7sfRg1gBwAgafq7sfRg1gBwAgafq7sfRg1gBwAgafq7sfR
					g1gBv4gcfr7xfQgzf+uLgqf08qfQgxf8s0g4f99TfQgwf7sgg7gA9bfQgwf7sgg7gA9bfQgwf7sgg7gA9b]],
				["Foot.L"] = [[
					fRgagQ9EgAgAtXfRgagQ9EgHf9tXfRgagQ9EgUf3tXfRgagQ9Egbf0tXfRgagQ9Egaf0tXfRgagQ9EgCf/tXfRgagQ9DfigOtXfRgagQ9DfcgRtXfRgagQ9D
					fcgRtXfRgagQ9DfcgRtXfRgagQ9DfcgRtXfRgagQ9DfcgRtXfRgagQ9DfcgRtXfRgagQ9DfcgRtXfRgagQ9DfcgRtXfRgagQ9DfcgRtXfRgagQ9DfcgRtXfR
					gagQ9DfdgQtXfRgagQ9EftgJtXfRgagQ9Ef8gCtXfRgagQ9EgAgAtXfRgagQ9EgAgAtXfRgagQ9EgAgAtX]],
				["Toe.L"] = [[
					fRgPgG/8gAgAhtfRgPgG/8gFf6htfRgPgG/8gPfwhtfRgPgG/8gUfrhtfRgPgG/8gUfshtfRgPgG/8gCf+htfRgPgG/8fpgYhtfRgPgG/8fkgdhtfRgPgG/8
					fkgdhtfRgPgG/8fkgdhtfRgPgG/8fkgdhtfRgPgG/8fkgdhtfRgPgG/8fkgdhtfRgPgG/8fkgdhtfRgPgG/8fkgdhtfRgPgG/8fkgdhtfRgPgG/8fkgdhtfR
					gPgG/8flgchtfRgPgG/8fxgPhtfRgPgG/8f9gDhtfRgPgG/8gAgAhtfRgPgG/8gAgAhtfRgPgG/8gAgAht]],
				["UpperLeg.R"] = [[
					gthMgK7MjNgAwigthJgL73jagLvVgthDgN9Gj1ggsvgtg+gP94kIgxqogtg/gP9wkFgurAgthLgJ7NjOgCwggthTgE4AiZfa1AgthUgD3SiPfT1zgthUgD3S
					iPfT1zgthUgD3SiPfT1zgthUgD3SiPfT1zgthUgD3SiPfT1zgthUgD3SiPfT1zgthUgD3SiPfT1zgthUgD3SiPfT1zgthUgD3SiPfT1zgthUgD3SiPfT1zgt
					hUgD3aiRfU1qgthRgG5IiqfmzngthNgJ6wjFf6xRgthMgK7MjNgAwigthMgK7MjNgAwigthMgK7MjNgAwi]],
				["LowerLeg.R"] = [[
					gwgwf7sgfFgA9bgxgvf6rke/f79zgxgsf4p4e0fz+Zgxgrf3o5eufv+sgxgrf3pDevfv+qgwgvf6ryfDgA9ugvg0gAvSfggS8Ggvg1gBwAfmgW7sgvg1gBwA
					fmgW7sgvg1gBwAfmgW7sgvg1gBwAfmgW7sgvg1gBwAfmgW7sgvg1gBwAfmgW7sgvg1gBwAfmgW7sgvg1gBwAfmgW7sgvg1gBwAfmgW7sgvg1gBwAfmgW7sgv
					g1gBv4fkgV7xgwgzf+uLfWgM8qgwgxf8s0fIgD9Tgwgwf7sgfFgA9bgwgwf7sgfFgA9bgwgwf7sgfFgA9b]],
				["Foot.R"] = [[
					gvgagQ9EgAgAtXgvgagQ9Ef5gDtXgvgagQ9EfsgJtXgvgagQ9EflgMtXgvgagQ9EfmgMtXgvgagQ9Ef+gBtXgvgagQ9DgefytXgvgagQ9DgkfvtXgvgagQ9D
					gkfvtXgvgagQ9DgkfvtXgvgagQ9DgkfvtXgvgagQ9DgkfvtXgvgagQ9DgkfvtXgvgagQ9DgkfvtXgvgagQ9DgkfvtXgvgagQ9DgkfvtXgvgagQ9DgkfvtXgv
					gagQ9DgjfwtXgvgagQ9EgTf3tXgvgagQ9EgEf+tXgvgagQ9EgAgAtXgvgagQ9EgAgAtXgvgagQ9EgAgAtX]],
				["Toe.R"] = [[
					gvgPgG/8gAgAhtgvgPgG/8f7gGhtgvgPgG/8fxgQhtgvgPgG/8fsgVhtgvgPgG/8fsgUhtgvgPgG/8f+gChtgvgPgG/8gXfohtgvgPgG/8gcfjhtgvgPgG/8
					gcfjhtgvgPgG/8gcfjhtgvgPgG/8gcfjhtgvgPgG/8gcfjhtgvgPgG/8gcfjhtgvgPgG/8gcfjhtgvgPgG/8gcfjhtgvgPgG/8gcfjhtgvgPgG/8gcfjhtgv
					gPgG/8gbfkhtgvgPgG/8gPfxhtgvgPgG/8gDf9htgvgPgG/8gAgAhtgvgPgG/8gAgAhtgvgPgG/8gAgAht]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAhygZAHgAgAicgAhwgZAGgEgriOgAhhgZAEgNhlgxgAiGgZAOgFhmjNgAikgZAYgAg/kugAivgZAcgAgAlNgAikgZAYgAfBkugAiGgZAOf7eajNgAhhgZAE
					fzebgwgAhogZAEf5fBhbgAhmgZADgAgAhPgAiUgZASgCg/j/gAirgZAdf/hmlCgAitgZAef/hmlIgAiagZAUgBg/kRgAhxgZAFgAgAh+gAhmgZADf5fBhPgA
					hygZAJf4eaiagAhygZAIf6e0icgAhygZAHf/fwicgAhygZAHgAgAic]],
				Spine1 = [[
					gAh1gJA0gAgAnFf/hygJAwgKgqmxf+hhgJAZgZhjknf+iJgJBFgVhkoAf/ipgKBogLg+p9gAi0gKB0gAgAqkgBipgKBof1fCp9gCiJgJBFfrecoAgChhgJAZ
					fnedkmgBhpgJAhfxfDllgAhngJAdgAgAlTf/iYgKBVgMg+pCf+iwgKBxgRhkqVf+iygKB0gRhlqdf/ifgKBcgLg+pZgAhzgJAqgAgAmVgBhngJAefxfDlTgC
					h0gJA2fpednCgBh1gJA1fve1nFgAh1gJA0f9fxnFgAh1gJA0gAgAnF]],
				Spine2 = [[
					gAiCftCEgAgArQf+h/fsB7gPgpq2f8hqfrBFgkhfoDf8iYfuChgjhgsTf9i8fwDkgUg8umgAjIfxD7gAgAvUgDi8fwDkfsfEumgEiYfuChfdegsTgEhqfrBF
					fcehoCgDh0frBbfqfFpUgAhxfrBTgAgAo9f9iqfvDCgVg7tif8jDfxD0ghhhvCf8jGfxD5ghhhvLf9iwfvDPgVg7t9gAh/fsBtgAgAqQgDhxfrBUfqfFo9gE
					iCftCFfcehrLgDiDftCFfle4rPgBiDftCEf6fxrQgAiDftCEgAgArQ]],
				Neck1 = [[
					gAiOfgFMgAgAxbf+iKffEzgXglw0f6hzfcCmgxhZsff6ikfiGRg4hVy7f9jJfmI5glgz2GgAjWfoJzgAgA3BgDjJfmI5fbfN2GgGikfiGRfIery7gGhzfcCm
					fPensegEh9fdDgfgfKuegAh6fdDNgAgAt7f9i3fkHmgkg00pf6jRfnJfg8hT2qf7jUfoJrg8hT22f9i+flIGgkg01OgAiKfeEPgAgAv5gEh6fdDOfgfKt7gG
					iNfgFKfJeqxVgEiOfgFNfWfAxbgBiOfgFMf3fzxbgAiOfgFMgAgAxb]],
				Neck2 = [[
					gAirfTG7gAgAz3f9infRGfgbgizSf4iKfGD5g6hUvMf5jDfYIJhAhP1Qf8jpflLEgpgw4KgAj2fpMCgAgA4/gEjpflLEfXfQ4KgHjDfYIJfAex1QgIiKfGD4
					fGesvKgFiXfLE+fbfNxFgAiTfJEogAgAwjf8jWffJogogw21f6jxfoLthDhN4qf6j0fpL5hDhN41f8jdfhKLgpgw3XgAilfOF2gAgAybgFiTfJEpfbfNwjgH
					iqfTG5fBewzwgFirfTG8fRfEz2gBirfTG7f2f0z3gAirfTG7gAgAz3]],
				Head = [[
					gAjGfMAFgAgAh8f9jCfJAMefgvizf3ihe3AUcciMezf5jffVA1cihUmIf8kFfpBtd7ghqBgAkRfvCCgAgArMgEkFfpBtiFffqBgHjffVA1jeesmIgJihe3AU
					jkd0exgFixe+AIiNezg2gAise8ABgAgAgKf8jyffBKd4gqoKf6kNftCHcrgwq2f6kPfuCMcrgurGf8j6fjBXd5gno5gAjAfFAHgAgAiYgFise8AHiNewgOgI
					jGfMAijgedkOgGjGfNAXipezjtgBjGfMAIgjfviggAjGfMAFgAgAh8]],
				Jaw = [[
					gAjJeh/8gAgAhqf7jHee/RhrfvmjfyibeM9DkHfRsuf0jses/QjugDltf5kdfE/3iIgShxgAksfN//gAgAgjgHkdfE/3d4fuhxgMjses/QcSf9ltgOibeM9C
					b5gvswgIiweT9+dhgUq4gAiqeQ91gAgArkf5kFe4/siOgKjsf2knfK/zjYgig2f2kqfM/zjXgjglf5kPe9/yiMgNi8gAjEeZ+jgAgApdgIiqeR9wdggXrdgN
					jOei+1cLgKnmgJjOei/RdHgWmGgCjLeh/0fagLjMgAjJeh/8gAgAhq]],
				Crest = [[
					gAlCeoKVgAgA3hfvk+esLndmjj4RfWkPd9KAdbms2FfblcfTQEd9kM7VfrmBgGTMglgu9TgAmMgWTci0eM9OgVmBgGRdixdH8NgllcfTNugzdT6GgqkPd9Ip
					fHeh1ygZkoeSLCe+fv4JgAkjeKK/gAgA4HfqlxftRKhJgS8UffmFgRSmg4hM9AffmHgVSLfAiT8vfrl3f3QbdUjC7pgAk8ekLxd0ih4jgakieLK0fafJ38gm
					lBe7Och2bm6TgdlDe3NejEa75ZgGlDetLSiCdc4JgAlCeoKVgAgA3h]],
				["UpperArm.L"] = [[
					fYiMfTzYMogAwffViIfUy2LGXRsbfRhvfUyNMbRfp4fRijfZz+SPLTiefUjKfc0BPuN1lNfYjYfbzOMbR8oefcjLfX09PRPDkDffikfR13R+NYg/ffhufMzw
					LuTeoEfch6fOxdJpWvrhfYh3fQzQMdR4obfUi3fa0aTALHhVfRjTffzzQKNOlPfRjVffypM+RKpofUi+faz6PVOOlrfYiHfS0xQwNUjLfch3fOzuMQSfn2ff
					iMfPyYKGVvqCfdiMfQ0rL2VFoXfZiMfS0SLqcIthfYiMfTzYMogAwf]],
				["LowerArm.L"] = [[
					fEh5fEADgAgAhOe7iFfDD4mEgvt8e1h1fHEgogkYtRe2iyfUGGlNoUwAe4jWfTIDnUlfzHe9jffMJToMhM09fCjXfKH0mWj3zlfFiyfHFbjulnwffGh0e6EH
					m3hxt+fDh6e8FjnuevwLe9h+fCEsnmjTuce5jGfVGpkon/xLe2jefXIcnimHzVe1jcfTJOpBid0be4jJfRHnnblVyke9iVfIErk8mpuafDh9e+ElnFifuqfG
					iOe9GmnZexx7fFiPe9DclXhGtUfDiAe/ATiCgHjwfEh5fEADgAgAhP]],
				["UpperArm.R"] = [[
					goiMfTzYzYgAwfgliIfR1XzJsFnYghhufMzw0RsjoDghikfRyx1erEpWgkjLfX09wvw9kDgojYfb1Arz1CfkgsjKfc0BwSyLlNgvijfZxr0Ws1rfgvhvfUyM
					zluhp5gth6fT0Evuy2kQgoh3fQzQzjuIobgki3fVy/0xsSo/ghjUfX1Swmw1jXghjXfX16sCz7e4gki/fV02xJwlkhgoiHfSxf1uqfrqgth3fTyxzVuvo/gv
					iMfXz4uh0LjQgtiMfWz0zescp2gpiMfTz20PjpuYgoiMfTzYzYgAwf]],
				["LowerArm.R"] = [[
					g8h5fEADgAgAhOg9iNe+B+bddaptg6h0e6EIZJePt/g6ioe/HSYmg8y4g+jXfKH0ZqcJzlhDjofXHkcSYny5hIjWfTIDYsahzHhLinfMHSW4eZyDhLh1fHEg
					XgbotQhIiHfLEeaZYstahDh+fCEsYactucg9i8fEIDYSgHzwg6jgfKIFaCcj0Fg7jnfQHLc+Z/zBg+jKfIHYZjcTzBhDiJfBGCXugPwvhIh+fGE1X6b6uNhK
					iZfRFgahX4vAhIiPfGDmZqcxs4g/h/fCA3d3fvm/g8h5fEADgAgAhP]],
				Tail1 = [[
					gAhygvgpgAgA//gBhwgvgokaf3/rgChigvgon1fB+/gCiEgvgcjqgI/xgBiggvgLdFfm/2gAiqgvgFZde3/Sf/iggvgLbJfV/nf+iEgvgcgfgB//f+higvgo
					kufa/of/hogvgokafo/rgAhmgvgpgAgA//gBiRgvgUbmfn/rgCingvgHbTfQ/ogCipgvgGfif7//gBiXgvgRk4gh/ngAhxgvgkmpfs/Sf/hmgvgpi8fu/2f+
					hxgvgpcWgF/xf+hygvgoaEgI/bgAhygvgpeagC/8gAhygvgpgAgA//]],
				Tail2 = [[
					gAhwhNgggAgA//gJhuhMgtlsf0/egQhhhJiItreR8ygJiDhMfUpEgT+qf8ighMdTdWfW/wf0irhKcnUkd09mf2ighLdSVBek94f/iDhNfVeNgB/7gGhhhMiK
					oXe8+ygHhnhMhfq4fN+CgAhlhNhskGfy/rf5iRhMeUZyfS/Vf6inhLc3VUeY98gBiohMcwaDfg/QgKiXhLd8kng4/lgMhwhKgzrtff9wgEhlhMhrpOfT+lf3
					hwhMgiengC/9fzhwhLgfXUgJ+yf9hwhNggcvgD/0gAhwhNgggAgA//]],
				Tail3 = [[
					gAhvhreYgAgA/8gUhthoe0kAgE/tgnhchch4w1ep7GgZiEhlcgvKhb76f3ilhpYohvfH/EfhiyhgXmTkb378fjimhiY6Pxcy6cf7iEhqcWYofm+6gVhchlhv
					n+fB+6gahkhjglvlf277gIhihqg0qZgO+PfuiUhnadcXen/RfnithiYCSbcl7of3iuhoX1T1eV8YgTibhoZ0gNhU/XgghuhgfQtQgM9HgUhihlg7u/f48Qf0
					hvhqedkQgO/qfkhvhkecXofl+1f3hvhqeZbdfx/ogAhvhreYgAgA/8]],
				Tail4 = [[
					gAhyiIaxgAgA/jgbhviEbZgEf0/qhBhXhpgJwXfj7fgxiLh1Y/y/kE4cf7iyiETKoTf78GfPjChwRzXOZX6dfLi0htUDN6Zj2nfuiLiEYaSidw76gkhZh/fi
					jxem/vgzhjhyecwxhY7KgahhiBe3v0iL7sfoifiCVbiYem+EfTi9hxSZUAZ15nfji9h5SeP/bp3xgTimiDUtZggu9Ng3hwh0cHqvhG93gthgh2fFxzho6gf8
					hyiGbKqlhx9vfVhyh+a1a8fK/JfuhyiGa1bKfN/LgAhyiIaxgAgA/j]],
				["UpperLeg.L"] = [[
					fThMgK7MczgAwifShJgM8FdAfPvAfSg5gS+qcddRn8fShfgM7Ld/ezwufSiAgH+jeYgUpVfTiLgD+JdbggqXfUiAgC+GcSgmqKfVhggD5DcJhkzdfVg4gJ9O
					a5g5r7fUhAgJ8tblgbtYfTg+gN9hb+fVrofShvgJ43eNf20DfSiGgI+ifEgNpefSiJgI+gfFgNpmfSh1gI33eegE1PfThKgL8jcWfot+fUg+gK8/begXsufV
					hLgF6Qb4hZxwfUhMgG6ccIhExjfThMgJ7DcqgOwvfThMgK7MczgAwi]],
				["LowerLeg.L"] = [[
					fQgwf7sgg7gA9bfOgwf7sGhxf99kfLgrf3pGjcgk+efNhEf+uTiefg8gfShuft+hhxfTpZfSh4fr+OgXfhqdfThufp+Re8fuqRfShCf7sufLgW9VfSgifzkR
					fXf7/sfRgof1nfgGgL/GfPgpf2n+hSgO+9fQhRgCwghcfV7XfRh1fu+aikfJpifRh3fu+YiifJpqfQhWgExrhRfM6nfPgyf4puhKgJ+dfRgnf1mygHgJ/QfS
					gvf5rVfPgW96fSgvf6rufqgQ9wfQgwf7sVgqgD9gfQgwf7sgg7gA9b]],
				["Foot.L"] = [[
					fRgagQ9EgAgAtXfRgagQ9DgufrtXfRgagQ89iZe6tUfRgsgQ8RhNfXu6fRhdfUxtk3Y75OfRhmfTx0gde+6jfShbfRuxa1oz6efRgsgQ8Qelgwu6fRgagQ9C
					ergntWfRgagQ9DfXgTtXfRgagQ9Egbf0tXfRg2gQ75gTf1vqfRhkfWynl2YV4KfRhlfWyylpYq4MfRg7gQ7ugIf7v9fRgggQ8ygQf4t9fRgagQ9DfYgStXfR
					gagQ9CepgotWfRgagQ9De+getXfRgagQ9EfygGtXfRgagQ9EgAgAtX]],
				["Toe.L"] = [[
					fRgPgG/8gAgAhtfRgPgG/7gjfchtfRgPgG/1h0eHhtfRgfgI/xg5e+jcfRhPfZ5wh6Xow6fRhYfY6WgDe4yGfRhPfY3fecqFzKfRgfgI/xe9hOjcfRgPgG/6
					e/hEhtfRgPgG/8fhgghtfRgPgG/8gUfrhtfRgpgI/tgOfvkRfRhVfZ6NinWuvmfRhXfZ6YiiXGvjfRgugJ/qgGf5kmfRgVgH/5gMfziXfRgPgG/8figghtfR
					gPgG/6e+hFhtfRgPgG/7fOg1htfRgPgG/8f2gLhtfRgPgG/8gAgAht]],
				["UpperLeg.R"] = [[
					gthMgK7MjNgAwigshJgI7WjwfhwLgrg4gJ9OlHfHr8grhggD5Dj3eczdgsiAgC+GjufaqKgtiLgD+JilfgqXguiAgH+jhofspVguhfgM7LiBhNwugug5gS+r
					jjivn6guhAgP9qjbhmrXgtg+gN9hkCgrrogshwgD3Ai8el1/griIf/9xkUfRq2griKf/9vkSfQq+gsh2gD+TjzffphgthKgL8jjqgYt+gug+gP97jjhuqlgu
					hLgO8EiVhevHguhMgN70ihhFvkgthMgK7VjEgOwVgthMgK7MjNgAwi]],
				["LowerLeg.R"] = [[
					gwgwf7sgfFgA9bgvguf5rCfvf1+BgugjfzkTgpgF/sguhCf7sug1fq9Vgthufp+RhEgSqRguh4fr+Ofpgfqdguhuft+hePgtpZgzhEf+uTdigg8gg1grf3pF
					ckfc+egzgsf4pvdlfw+Ygxgpf2n+eufy+9guhRgCwWgef77fgth0fn9/h6gIq9gth2fn98h5gIrGgthkfp+fhIgUpngxgyf4pue2f3+dgzgrf3pOdhfs+hgz
					gyf9tkdVgT82gygxf9tYdygP8+gxgwf7sre0gD9Wgwgwf7sgfFgA9b]],
				["Foot.R"] = [[
					gvgagQ9EgAgAtXgvgagQ9DghfxtXgvgagQ9ChVfZtWgvgsgQ8QhbfQu6guhbfRuxlLXN6egvhmfTx0fjhC6jgvhdfUxtbJnF5OgvgsgQ8Rezgpu6gvgagQ89
					dnhGtUgvgagQ9CengptWgvgagQ9EflgMtXgvg2gQ73hOfUvpguhhfQt9nAUA5NguhjfQubmjVG5kgvhTfQrCpiNq1xgvgggQ8yfwgIt9gvgagQ9BehgstWgv
					gagQ9BelgqtWgvgagQ9De9gftXgvgagQ9EfygGtXgvgagQ9EgAgAtX]],
				["Toe.R"] = [[
					gvgPgG/8gAgAhtgvgPgG/8gZfmhtgvgPgG/6hBe8htgvgfgI/xhDeyjcgvhPfY3fhkV7zKgvhYfY6Wf9hIyGgvhPfZ5weGoYw6gvgfgI/xfHhCjcgvgPgG/1
					eMh6htgvgPgG/6e8hHhtgvgPgG/8fsgVhtgvgpgI/rg4e6kRgvhUfY2RiGSRyTgvhWfY21iETdycgvhHfZySiGLcwLgvgVgH/5f0gNiXgvgPgG/5e4hLhtgv
					gPgG/6e7hJhtgvgPgG/7fNg2htgvgPgG/8f2gLhtgvgPgG/8gAgAht]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhygZAHgAgAicgAhygoAVgAgAkdgAhygxAigAgAlwgAhygvAegAgFlagAhygqAYgAflkvgAhygkAVf9d/kAgAhyghAQf7eTjhgAhyggANf/frjagAhygdAK
					gBgOjEgAh3gaALh6f4ingAh+gZAxmefgiZgAh7gZChsKfEiQgAhsgZFFxGesiEgAhdgZHJz+eeh6gAhbgZHd0Xech4gAhigZGgzJeih9gAhkgZGUy6ejh+gA
					hcgZHR0Jedh5gAhagZHk0gech4gAhagZHk0gech4gAhagZHk0gech4gAhagZHk0gech4gAhagZHk0gech4]],
				Spine1 = [[
					gAh1gJA0gAgAnFgAh3gYBVgAgApDgAh4giBugAgAqTgAh4ggBngBgFp+gAh3gbBaf8flpUgCh2gVBRfqeAomgCh2gRBHfseVoIgAh2gQBDf8fsoCgAh1gOA9
					gEgOnsgAh6gLA6h3fnnPgBiAgJBdmVekm8gCh9gJDLr5dTmjgChtgJFrwucNl/gChegJHszibklhgChbgJIAz7bfldgChjgJHEyubwlrgChkgJG4yfbzltgC
					hdgJH0ztbilfgChagJIH0DbdlbgChagJIH0DbdlbgChagJIH0DbdlbgChagJIH0DbdlbgChagJIH0Dbdlb]],
				Spine2 = [[
					gAiDftCEgAgArQgAiIf+C1gAgAtIgAiLgJDZgAgAuUgAiKgGDPgBgFuAgBiJgAC9f4fmtZgGiHf6CufZeFssgFiFf2CgfdeZsQgBiFf1Cbf5fssKf/iEfyCS
					gFgNr1gCiIfuCLh2ffragGiNftCumPeLrHgLiGftEdruciqvgPhzftHAwcbDqLgQhhftJDzLaJptgQheftJXzjaBppgPhnftIayZaap3gPhoftIPyKafp5gQ
					hgftJLzVaGpsgQhdftJezrZ/pngQhdftJezrZ/pngQhdftJezrZ/pngQhdftJezrZ/pngQhdftJezrZ/pn]],
				Neck1 = [[
					gAiOfgFMgAgAxbgAiVfyH1gAgA08gAiZf/JxgAgA3AgAiYf7JPgDgE2egCiWf1IPfxfp1agHiTfvHQe5eU0KgGiSfqGlfEelzWgBiRfpGZf1fvzKf/iQflF8
					gIgLyjgDiTfhFVhie3xjgLiXfgFWlOcMwdgTiPfgGYp6ZGu2gYh5fgIGuFWos3gahkfgJiwkVVragbhhfgJxw6VKrMgahrfgJFv2Vsr2gahtfgI9vpVzr+gb
					hjfgJowtVQrUgbhgfgJ2xCVGrHgbhgfgJ2xCVGrHgbhgfgJ2xCVGrHgbhgfgJ2xCVGrHgbhgfgJ2xCVGrH]],
				Neck2 = [[
					gAirfTG7gAgAz3gAi0fuJ5gAgA3HgAi5gAMBgAgA4+gAi4f7LcgDgE4ggCi1fyKWfvfr3igIiyfoJPeveb2YgHiwfiIge8er1ogBiwfgISfzfw1df/iufbHy
					gJgL05gHiwfVHFhSeiz9gWixfSG6kVbHyugniifRHkoRXHwsgyiEfQIurzT/uEg1hpfPJvt9SWsHg1hlfPJ5uQSJr0g0hyfPJbtUSzstg0h0fPJVtJS8s4g1
					hofPJzuFSRr/g2hkfPJ9uWSFrtg2hkfPJ9uWSFrtg2hkfPJ9uWSFrtg2hkfPJ9uWSFrtg2hkfPJ9uWSFrt]],
				Head = [[
					gAjGfMAFgAgAh8gAjQfvBSgAgAo8gAjUgGC4gAgAtNgAjTgACZf7gDsGgCjRf0Bmgdfsp5gJjPfoBDiPeSnigIjMffAqh8ecl1gBjMfdAegYftlUf/jKfXAS
					fwgOkHgKjLfPAJh2fNiFghjKfKAvmQdhf+g6i1fICkrlcCdbhKiOfGFMv+bfaqhPhufFHOyYbmYzhQhpfFHiytboYihOh4fGGmxtbhZXhOh7fGGaxgbgZhhP
					hsfFHXyhbnYshQhnfFHpy0bqYchQhnfFHpy0bqYchQhnfFHpy0bqYchQhnfFHpy0bqYchQhnfFHpy0bqYc]],
				Jaw = [[
					gAjJeh/8gAgAhqgAjmfJ//gAgAfogAj0fo/8gAgAeVf/jwff/9gGf/ergDjpfP/+fegLfWgPjgfA/3dbhJf7gNjZe2/5dzhKgdgCjYez/+flgPgsf+jTes/+
					gSf1hDgMjPej/1eEgiiegnjGef+0ZbhZlShAipef8LT2hWo8hLh7ef4cPagIsRhLhXeg1kNJe0uLhLhSeg1IM2emubhMhieg2dNxfPtohMhleg2tN9fXtehL
					hVeg1YNBeuuShKhQeh0+MweguhhKhQeh0+MweguhhKhQeh0+MweguhhKhQeh0+MweguhhKhQeh0+Mweguh]],
				Crest = [[
					gAlCeoLVgAgA4agAlPgDROgAgA8XgAlIg9VZgAgA+Lf/lLguURf/gG9wgGlPgQSHgFfd8zgdlNfyQCgUdN7lgalMfbOigNdi6rgFlMfTOCgCfh6df9lJfENC
					f/gV5wgalGesLegteH4chWk1ebKXiiZx2kiUj+eRJylJU5zfi2iteIJmnyRWvri9hweDJrpiPrs7i9hneCJspyPeshi8iDeEJopAQItwi8iIeFJoo3QQuAi9
					hseDJrpoPmswi9hkeCJtp3PasYi9hkeCJtp3PasYi9hkeCJtp3PasYi9hkeCJtp3PasYi9hkeCJtp3PasY]],
				["UpperArm.L"] = [[
					fYiMfTzYMogAwffYiVfl2OM/cPsafYiafy3mNnZ4phfXiZfv3RNdacqWfaiWfn2kM6b/rifhiTfd1sL6eWsGffiRfZ1BL7fCtUfZiQfb02MjeZuafXiPfZ0V
					MxetvcfbiXfVyRL0fQwxflimfUuhKZeOygf1irfVqAJpbu0IgFiefWmCJ/Yt1MgQiNfXjwKqWg1hgRiKfXjcKxWL1jgNiSfXkZKbXL1dgMiUfXkmKXXX1bgR
					iLfXjnKtWX1igSiIfXjVK0WE1jgSiIfXjVK0WE1jgSiIfXjVK0WE1jgSiIfXjVK0WE1jgSiIfXjVK0WE1j]],
				["LowerArm.L"] = [[
					fEh5fEADgAgAhPfEiJfRA5gAgAnbfEiTfbCEgAgArRfEiQfYBtgBgFqRfHiLfRBHf9floRfQiGfHAqf0d/mEfOiBfFAZf4eTklfGiAfIATf/frkNfDh9fJAL
					gBgOjJfFiFfHAFhjgIhbfLiYfKAelTgsgLfXikfQBtqDh7fqfmigfWDmuSjafxfyiUfaFLw1kagMf0iSfaFaxMkkgRfuiYfYErwGkHgCftiZfYEiv4kCgAfz
					iTfaFRw/kegOf0iRfaFgxUkngTf0iRfaFgxUkngTf0iRfaFgxUkngTf0iRfaFgxUkngTf0iRfaFgxUkngT]],
				["UpperArm.R"] = [[
					goiMfTzYzYgAwfgoiVfl2OzBjxsagoiafy3myZmIphgoiZfu3RynldqQgqiWfp2iytkksDgxiSfn1jyJkOujgwiRfh08yajGvYgqiQfc01zJiBuzgniPfY0W
					zdhBvLgriNfU0jyEejwggviGfS18uoZ2xCguhyfR3Ep+USv9gohVfQ3ClsPetsghg+fP2gjIMwrrggg7fP2aixMZrXgjhFfP2tj3NisUgkhHfP2wkFNwsfgh
					g9fP2ei+Mmrjggg6fP2XipMRrQggg6fP2XipMRrQggg6fP2XipMRrQggg6fP2XipMRrQggg6fP2XipMRrQ]],
				["LowerArm.R"] = [[
					g8h5fEADgAgAhPg8iJfRA5gAgAnbg8iTfbCEgAgArRg7iRfXBtgBgFqRg+iLfUBHf9floRhGiEfWAqf0d/mEhFiBfRAZf4eTklg9iAfLATf/frkNg6h9fHAL
					gCgOjJg7h3fGAIiRgFhag1hqfGA9nqgRgDgnhVfJDXuMgqfAgVg8fMGzzjhLeDgJgrfPJd2fhmddgIgofPJ223hqdYgNgwfOIo1qhedogOgyfOIZ1ahbdsgJ
					gqfPJn2phodbgHgnfPJ/3AhsdWgHgnfPJ/3AhsdWgHgnfPJ/3AhsdWgHgnfPJ/3AhsdWgHgnfPJ/3AhsdW]],
				Tail1 = [[
					gAhygvgpgAgA//gAhvg+irgAgA/4gAhthHj+gAgA/vgAhthEjogJgB/yf/huhAi9fQf9/2f9hvg6iNcef5/uf+hwg3hudCf9/zgAhwg2hnfcgA/8gAhxg0hR
					gZf//9gAh2gwg4f0eG/7gAh9gvgvfOZi/Uf/h6gvglegT39jf/hsgvgNd3O96+f/hdgvf3dhMG47f/hbgvfzdeLu4mf/higvf+dnM75kf/hjgvgAdpNK5vf/
					hcgvf1dgL84yf/hagvfyddLl4ff/hagvfyddLl4ff/hagvfyddLl4ff/hagvfyddLl4ff/hagvfyddLl4f]],
				Tail2 = [[
					gAhwhNgggAgA//gAhqhbiigAgA/5gAhmhkj1gAgA/wgAhnhhjfgMgB/zf+hphdi0e8f8/2f3hrhXiDa+f1/hf4hthUhlbwf7/qf+hthUhefMf//8gBhuhRhI
					gjf//9f/h1hOgzfqeG/7f+h8hNguenZj/Sf8h6hNgcdST79ff8huhNfwcKPF64f8hghNfHbiMT4yf8hehNfBbdL74ef8hlhNfUbtNG5cf8hmhNfYbwNV5nf8
					hfhNfEbgMJ4pf8hdhNe+bbLz4Wf8hdhNe+bbLz4Wf8hdhNe+bbLz4Wf8hdhNe+bbLz4Wf8hdhNe+bbLz4W]],
				Tail3 = [[
					gAhvhreYgAgA/8gAhlh4gagAgA//gAhfiAhugAgA/8gBhgh+hYgQgC/9f8hkh6gseof1/9fthohzf+ZgfW/Ufwhqhxffahfi/gf9hrhxfWe9f7/9gChshvfA
					gugD/9f/hzhsevfneF/6f7h7hrexeZZd/Pf3h8hqeec1Tx9Wf2hyhqdpbgO86lf2hnhpc3axMO4Yf2hlhpcvarL34Df2hqhpdHa+NA5Ef2hshpdMbCNO5Qf2
					hmhpc0avME4Pf3hkhpcsapLv37f3hkhpcsapLv37f3hkhpcsapLv37f3hkhpcsapLv37f3hkhpcsapLv37]],
				Tail4 = [[
					gAhyiIaxgAgA/jgAhkiWcygAgA/1gAhbieeFgAgA/7gBheicdvgTgF/6f5hiiYdEeVfm/zfihoiOcdYLeT+xfmhriNb8ZYer/Af7hsiPbvevfw/rgDhuiNbZ
					g4gK/pf+h2iKbMfreB/kf5h+iIbWegZO+4fziAiHbLdATX81fxh6iGaXbsOf5zfzhxiFZka/Ly3ZfzhviFZba5Lb3Cfyh0iFZ1bMMj4Jfyh1iFZ5bPMx4Xfz
					hwiFZga9Lo3QfzhviFZYa4LT26fzhviFZYa4LT26fzhviFZYa4LT26fzhviFZYa4LT26fzhviFZYa4LT26]],
				["UpperLeg.L"] = [[
					fThMgK7MczgAwifThOgU87c1fotRfThQga92c3fZrEfThPgZ9nc5fZrrfThOgU9Jcnf8swfVhOgM8hbxhbtyfVhNgK8Ib7hPunfThNgN8EcpgGu+fThMgN7x
					c6fsvlfPhWgL7VbMe9v4fHhsgK6sXOcxu7fFh/gK5LSLaYs6fKiFgK22NvYuqufQiBgK07LIX+pOfSiAgK0oKyX4pAfOiDgK1iL5YKprfOiDgK1sMHYOpzfR
					iBgK0zK/X8pIfSiAgK0hKqX3o8fSiAgK0hKqX3o8fSiAgK0hKqX3o8fSiAgK0hKqX3o8fSiAgK0hKqX3o8]],
				["LowerLeg.L"] = [[
					fQgwf7sgg7gA9bfQg3f/v2g7gH7xfQg8gCx3g6gL6hfPg6gCxWg/gI63fRg4f/wSghgS7hfUg2f4vGfDg38LfTg0f4uTfXgu8mfQgzf8uHgogL8sfPgyf9tj
					hIf889fIg8f7stgNeP9Te6hWf5r/eeZ/9Aexhwf3rHcbUo7he0h+f1p/awP75Qe6iAf0pKZ1NK3Ye8h/fzpCZuMy3Fe4iAf0paaGN93+e3iAf0pfaLOM4Ie7
					h/f0pGZyNA3Qe8h/fzo/ZrMq2/e8h/fzo/ZrMq2/e8h/fzo/ZrMq2/e8h/fzo/ZrMq2/e8h/fzo/ZrMq2/]],
				["Foot.L"] = [[
					fRgagQ9EgAgAtXfRgdgO+agAgAp6fRgggO/EgAgAnmfRgfgO+6gCf7oOfSgdgN+kf0gZpafTgcgJ+GfJh1qqfTgcgK9zfShjrgfRgbgO9wf3gTrvfRgbgQ9h
					gFfzsVfHgmgQ9QeRfNszezhCgO82aCdesNekhhgN7jUpbkqxeih0gL5ZP4aMpKeoh6gL3mNDZhoEeph6gL3UMqZcn6emh5gL4KN3ZtoZelh4gL4UOGZwofeo
					h6gL3eM4ZfoAeph6gL3NMiZan3eph6gL3NMiZan3eph6gL3NMiZan3eph6gL3NMiZan3eph6gL3NMiZan3]],
				["Toe.L"] = [[
					fRgPgG/8gAgAhtfRgUgC/7gAgAd/fRgZgB/sgAgAbnfRgXgB/xgAf7cPfSgVgB/4f+gbdefVgTf+/5f4iBe0fUgSf//8f6htftfSgRgE//f/gVf8fRgQgG//
					gAfygkfGgbgF/6eGf5hGevg4gE/UZhf3guedhZgC9kT0gEf2eahwgA6/O3gjfKefh4f/46L/g+ezegh4f/4lLnhCewedh2f/5kM0g1e5ech2f/5vNEgze7ef
					h4f/4xL1hAeyegh5f/4eLehEewegh5f/4eLehEewegh5f/4eLehEewegh5f/4eLehEewegh5f/4eLehEew]],
				["UpperLeg.R"] = [[
					gthMgK7MjNgAwigthOgU87jLgYtRgthQga92jJgnrEgthPgY9njMgfrqguhOgW9Ji8gys2gvhNgX8hiIiAuMgvhMgU8JiThpu9gthNgP8EjCgdvCgthMgM7x
					jTf7vigohMgK73hkfJvogahIgK8cdYdUuKgFhAgK8UXwbtrofwgzgK7DSha+pLfkgpgK5sPVa4nqfigngK5eO5a5ndfngsgK6JQRa4oGfogtgK6RQia4oPfj
					gogK5mPJa4nlfigngK5ZOva5nYfigngK5ZOva5nYfigngK5ZOva5nYfigngK5ZOva5nYfigngK5ZOva5nY]],
				["LowerLeg.R"] = [[
					gwgwf7sgfFgA9bgwg3f/v2fFf57xgwg8gCx3fGf16hgwg6gBxWfKf063gxg3gBwSesgD7gg0g0gEvGdOgs8EgzgzgCuTdhgm8ggxgzf+uHeygF8rgwgyf8tj
					fSf48+gogxf6sgeXeP9WgTgwf3rUcuaA9If3guf0p3a8Un7wfggofxoSZpP25kfUgifwnNZCNC3vfTghfvnDY9Mq3cfYgkfwnhZNN24UfZglfwnnZQOF4efT
					gifwnIZAM43nfSghfvm/Y8Mh3WfSghfvm/Y8Mh3WfSghfvm/Y8Mh3WfSghfvm/Y8Mh3WfSghfvm/Y8Mh3W]],
				["Foot.R"] = [[
					gvgagQ9EgAgAtXgvgdgO+agAgAp6gvgggO/EgAgAnmgvgfgO+6gCf7oOgvgdgQ+kf0gZpagwgbgV+GfJh1qqgwgbgU9zfShjrggvgbgQ9wf3gTrvgvgbgP9h
					gFfzsUgkgcgP9VeRfOsngJgegN9FZ/dmrofpghgL78UfcBprfPgigJ54PkbHntfCgggI4FMqa0mdfBgfgI3zMQazmSfGghgI4qNga4m1fHghgI40Nva5m8fC
					gggI3+MfazmYfAgfgI3tMHaymOfAgfgI3tMHaymOfAgfgI3tMHaymOfAgfgI3tMHaymOfAgfgI3tMHaymO]],
				["Toe.R"] = [[
					gvgPgG/8gAgAhtgvgUgC/7gAgAd/gvgZgB/sgAgAbngvgXgB/xgAf7cPgvgVgD/4f+gbdegxgSgJ/5f4iBe0gxgRgJ/8f6htftgvgRgF//f/gVf8gugQgE//
					gAfygkgjgRgF/7eGf6g6gFgVgC/VZhf/gFfigaf/9jT0gjesfHgef965O7hhdoe7gef74xMHiUdIe6gef74cLuicdEe+gef85cM6iEdQe/gef85nNJh/dTe6
					gef74oL8iYdGe5gef74VLmifdCe5gef74VLmifdCe5gef74VLmifdCe5gef74VLmifdCe5gef74VLmifdC]],
			},
		},
	},
}
