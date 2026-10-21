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
					gAh3gAAFgAgAiIgAh4gAAFgAgAiIgAh4gAAFgAgAiIgAh5gAAFgAgAiIgAh5gAAFgAgAiIgAh4gAAFgAgAiIgAh3gAAFgAgAiIgAh2gAAFgAgAiIgAh1gAAF
					gAgAiIgAh1gAAFgAgAiIgAh0gAAFgAgAiIgAh1gAAFgAgAiIgAh1gAAFgAgAiIgAh2gAAFgAgAiIgAh3gAAFgAgAiIgAh6gAAFgAgAiIgAh9gAAIgHhtiHgA
					iAgABNgjoWiDgAiCgAF7hOyahvgAiCgAQkh378hCgAiCgAgAiI/7gAgAiBgAvch378e+gAh/gA6FhOyaeRgAh9gA+zgjoWd9gAh7gA/4gHhtd5gAh5gA/7gA
					gAd4gAh3gA/7gAgAd4gAh3gA/7gAgAd4gAh4gA/7gAgAd4gAh5gA/7gAgAd4gAh5gA/7gAgAd4gAh5gA/7gAgAd4gAh4gA/7gAgAd4gAh3gA/7gAgAd4gAh2
					gA/7gAgAd4gAh1gA/7gAgAd4gAh0gA/7gAgAd4gAh0gA/7gAgAd4gAh1gA/7gAgAd4gAh2gA/7gAgAd4]],
				Spine2 = [[
					gAh8fUAGgCgZiOgAh+fUAGgCgeiOgAh+fUAGgCgjiOgAh/fUAGgDgmiOgAh/fUAGgDgpiOgAh+fUAGgDgqiOgAh9fUAGgDgriOgAh8fUAGgDgqiOgAh7fUAG
					gDgpiOgAh6fUAGgDgmiOgAh6fUAGgCgjiOgAh6fUAGgCgeiOgAh7fUAGgCgZiOgAh8fUAGgBgTiOgAh9fUAGgBgNiOgAiAfUAGgAgHiOf7iDfUAJgIhtiOfq
					iGfaBLgloQiJfWiIfxF0hRyPh1fbiIgXQTh87yhGgAiIgsfniO/6gCgliHgXvBh98Ke9gqiFfx5whUy2eNgWiDfa+pgoo7d4gFiBfU/1gKiWdygAh/fU/6gD
					gqdygAh9fU/6gDgrdygAh9fU/6gDgqdygAh+fU/6gDgpdygAh/fU/6gDgmdygAh/fU/6gCgjdygAh/fU/6gCgedygAh+fU/6gCgZdygAh9fU/6gBgTdygAh8
					fU/6gBgNdygAh7fU/6gAgHdygAh6fU/6gAgAdygAh6fU/6gAf5dygAh7fU/6f/fzdygAh7fU/6f/ftdy]],
				Spine3 = [[
					f/iDeoAZgKhBkzf/iEeoAagLhIkzf/iEeoAagMhNkzf+iFeoAagMhQkzf+iFeoAagMhRkzf+iEeoAagMhQkzf+iDeoAagMhNkzf+iCeoAagLhIkzf+iBeoAZ
					gKhBkzf+iBeoAZgJg5kzf/iAeoAZgHgvkzf/iBeoAZgGglkzf/iBeoAYgEgZk0f/iCeoAYgCgNk0f/iDeoAYgAgAk0gAiGeoAYf+fzk0f3iKeoAagNhTkzfU
					iMe0BVhLnukqetiOfiFwirxoj/e1iOguP8kJ7Picf/iOhYe/kz/ngKhKiNgwuTkS8Nd1hTiLfk5Ii7zNcMguiJe1+LhcpebbgLiHep/fgdi9bOgCiFeo/mgM
					hQbNgCiDeo/mgMhNbNgCiDeo/mgLhIbNgCiEeo/ngKhBbNgCiFeo/ngJg5bNgBiFeo/ngHgvbNgBiFeo/ngGglbNgBiEeo/ogEgZbMgBiDeo/ogCgNbMgBiC
					eo/ogAgAbMgAiBeo/of+fzbMgAiAeo/of8fnbMgAiAeo/nf6fbbNf/iBeo/nf5fRbNf/iCeo/nf3fHbN]],
				Spine4 = [[
					f8iQd+AbgQhpkzf8iRd+AbgRhukzf7iSd+AbgRhvkzf7iSd+AbgRhukzf7iSd+AbgQhpkzf7iRd+AbgPhjkzf7iRd+AagOhakzf7iPd+AagMhOkzf8iOd+AZ
					gKhBkzf8iOd+AZgIgykzf9iOd+AZgFgikzf9iOd9AYgDgRk0f+iOd9AYgAgAk0f/iPd9AYf9fvk0f/iRd9AZf7fekzgAiTd9AZf4fOkzfziXd+AZgHgrkzfA
					iZeOBMhFnFkseGibfSFYimxEkDeQichDPYkG65iif8ibiCeXkz/lgQhsiahJtykV8ed6h8iZfZ4zi/zocPhGiXeS+Chgp6bcgTiUd//cggjVbOgFiSd+/lgP
					hjbNgFiQd+/mgOhabNgFiQd+/mgMhObNgEiRd+/ngKhBbNgEiSd+/ngIgybNgDiSd+/ngFgibNgDiSd9/ogDgRbMgCiRd9/ogAgAbMgBiQd9/of9fvbMgBiP
					d9/nf7febNgAiOd9/nf4fObNf/iOd9/nf2e/bNf+iOd9/mf0eybNf9iOd+/mfyembNf9iPd+/lfxedbN]],
				Head = [[
					f4iddT/8gBeVgNf3iedT/8gBeRgNf3ifdT/8gBeQgNf2ifdT/8gBeRgNf2ifdT/8gBeVgNf3ifdT/9gBecgNf3iedT/9gBelgNf4iddT/9gBexgNf5icdT/+
					gAe+gNf6ibdT/+gAfNgNf7ibdT//gAfdgNf8ibdT//gAfugNf+icdT//gAgAgNf/iddT//gAgSgNgBiedT//gAgjgNgCigdT/+gcgzf4fxikdU/9hIfXfSet
					indo/IhcY8ecdfiofA66hCO7dcdqiphWw5fyFCc0f4ipith4eJAQdJiNinhjSVdBDSeZimimfPHKc4MHf3hfikdwBydeV4gxgciidVAReQckg7gJigdTAFe+
					eagjgJiedTADftelgBgIiddTADgBexfzgHiedTACgAe+fzgGifdTACgAfNfzgFifdTABgAfdfzgEifdTABgAfufzgCiedTABgAgAfzgBiddTABgAgSfzf/ic
					dTABgAgjfzf+ibdTACgAgzfzf8ibdTACgAhCfzf7ibdTADf/hPfzf6ibdTADf/hbfzf5icdTADf/hkfz]],
				Jaw = [[
					fsiGbhgDAEg2hrfriHbhgEAFhOhvfqiIbhgFAGhhhwfqiIbhgGAHhqhvfqiIbhgFAGhohrfriIbhgEAFhbhkftiHbggDAEhGhbfviGbggCADg2hPfxiFbggC
					ADg2hCf0iEbggBACg2gzf3iEbggBACg2gjf6iEbggAACg2gSf+iFbggAACg2gAgBiGbggAACg2fugFiHbgf/AChGfdgJiMbfgaADhGfMfuiUbfhJADgtgmd8
					iab+hxA2f3m/b2ifeMhvFBejxCb/ihiHgoPBdW6+foiikhexeFdL/yjnihivdltpeI8xkZiee4dR42fXz9ioiZcUdr+PgLqLg3iUbkeV/wgTjfgWiObgfA/7
					f7hngTiIbgfv/9fZhbgRiGbggC/9fChPgPiHbggD/8erhCgMiIbggD/8ebgzgJiIbggC/8eVgjgGiIbggB/8ebgSgCiHbggA/9ergAf/iGbgf//+fCfuf7iF
					bgf//+fKfdf4iEbgf//+fKfNf1iEbgf+/9fKe+fyiEbgf+/9fKexfviEbgf+/8fKelftiFbgf9/8fKec]],
				["FinF1.L"] = [[
					eohgePqhNre13/enhhePqRNmef4BenhheQqCNieM4CenhieQp1Ned84DenhieQpuNcdy4EenhheQprNcdv4FenhgeQptNedy4FenhfeQp1Nhd74GenheeQqB
					NmeK4GenhdeQqQNsed4FenhdeQqhNyey4EenhdePqyN4fI4CeoheePrAN9fc4AeohfeOrMOAft39ephgeOrTN/f435ephjeNq9NKe43YeehmeXqENEcr3gd7
					hpfHn/RBZd6Ud2hrgqj6ZpWp9qfKhriGeVmPWF9uhVhrh1ZNzYYq3ZiRhqf3Wc8PdNrRhThoeJWN+Uhidif0hmdvXJ7WkPSoe6hkeBXt3QlFMUethieJXR1N
					kOKGethgeJWf0CiiJGethgeJWGzehrIseshheJV7zWhdIqeshieJVszNhLIneshieKVdzBg3IkeshieKVNy1gkIherhheLU/yogTIderhgeLU0ydgGIZeqhf
					eMUtyUf/IWeqheeMUqyOf+ISephdeNUtyKgDIOephdeNU0yKgPIKepheeOVAyMggIHeoheeOVOyQg0IE]],
				["FinF2.L"] = [[
					dYg3eanCUteq9DdWg6ebm4UseQ9EdVg9ecmuUqd49EdUg/edmmUpdm9EdUhAedmhUpda9EdTg/edmfUpdW9EdUg+edmhUrda9FdUg8edmmUtdl9GdVg5edmt
					Uwd39GdWg3edm3UzeO9HdXg0ecnCU2eo9HdZgyebnMU4fB9GdagxeanWU5fZ9FdbgxeZndU4fs9DdcgxeYniU1f59BdZg5eUniUDeu8rdJhIegnOUTcZ8qcs
					hVfvllZPZV+CdOhhh6h1itW2+efuhpjachu0Ww6kiuhuiFXx5aZ5whjOhve0Vr+Ke8iVhDhscwWX8GjcUqeshmc4YL2Kl7LIdhhcdwZdwjmVGMdUhQeHZmuJ
					lHEhdXhCeNZatAjJDtdZg9ePZUsfiJDadag8eQZNsah4DYdbg7eQZFsShhDVdbg5eRY7sJhJDTdcg2eRYyr/gxDQddg0eSYpr1gcDNddgxeTYirrgLDLdegv
					eUYerjgBDJddgueVYdrcf+DGddgueWYerXgEDEdcgveXYjrTgRDCdbgxeYYqrSgkDAdZgzeZYzrSg8C+]],
				["FinF1.R"] = [[
					hVhgeLqjy6g63ihUhheKqTzHhN3dhUhheKqFzShe3ZhUhieJp6zbhs3WhUhieJpzzgh13UhThheJpwzjh43ShThgeJpzzih03ShThfeJp6zehr3UhUheeJqF
					zWhd3WhUhdeJqUzNhL3ZhUhdeKqjzBg33chUhdeKqzy1gk3fhVheeLrByogT3jhVhfeLrMydgG3nhWhgeMrTyUf/3qhWhjeMq+zAhE3QhKhmeEqY1WiP1VgR
					hpdxqM6HhsvUeyhreHqJ+BflkVdxhrfypX8rcUWBeohrhxm/z9Y1JGgwhqiHjAmXWgCSiIhoguegZLWNCXiGhmfMazQHXrGChlhkeaYjL4ZxJIhZhieQXdLu
					bcJQhZhgeQWmM9dFIRhZhgeQWLNhd7H6hZhheQV/NmeKH6hZhieQVwNsedH7hZhieQVfNyeyH8hZhiePVON4fIH+hYhhePVAN9fcIAhYhgeOU0OAftIDhXhf
					eOUtN/f4IHhXheeNUqN8f+IKhXhdeNUtN2f9IOhWhdeMU0Nsf2IShWheeMU/NgfpIWhVheeLVNNTfZIa]],
				["FinF2.R"] = [[
					ilg3eSnEsBhL8ximg6eRm7sLhj8uing9eRmysUh58ring/eQmrsciK8oinhAePmnshiV8ming/ePmmsjiZ8ling+ePmnsiiV8ling8ePmssfiJ8mimg5eQmz
					sah48oilg3eQm7sShh8rilg0eRnFsJhJ8tikgyeRnOr/gx8wijgxeSnXr1gc8zijgxeTnerrgL81iigxeUnirjgB83img5eRnjsJhO8miehId7nkusi17Phb
					hVdAoL03i/2pfIhhcwpO7phetHc4hpespu+aeOe/dOhuh9oY5zaGQHgKhvjZk3u3W1FqiuhsiAgXiTVxByjWhmf1clYiWzCfi/hcejadTaYyEDiyhQeVZ0TA
					aoD9iuhCebZjUMclDMisg9edZaUtdlC6irg8edZTUwd3C6iqg7edZJUzeOC5ipg5ecY+U2eoC5ing2ebY0U4fBC6img0eaYqU5fZC7ilgxeZYjU4fsC9ikgv
					eYYeU1f5C/ijgueXYdUxf+DCijgueWYeUpf8DEijgveVYjUgfyDGikgxeUYpUWfiDJilgzeTYyULfNDM]],
				Tail1 = [[
					gAh3gAd8fFf8/6gAh4gAd8fQf9/6gAh4gAd8fcf+/6gAh5gAd8fof+/7gAh5gAd8f1f//7gAh4gAd8gDgA/7gAh3gAd8gQgB/7gAh2gAd8gdgC/7gAh1gAd8
					gpgD/6gAh1gAd8g0gD/6gAh0gAd8g+gE/6gAh1gAd8hHgF/6gAh1gAd8hNgF/5gAh2gAd8hSgF/5gAh3gAd8hVgF/5gAh6gAd8hVgG/5gAh9gAd9jBgM/ygA
					iAgAeCpkgo+dgAiCgAeXzWhQ5ZgAiCgAfE8ch2uggAiCgAgE/6iEfFgAiBgAhD7khyP6gAh/gAhtx8hKFmgAh9gAiAn/ghBGgAh7gAiEhjgGAIgAh5gAiEgD
					gAAFgAh3gAiEgQgBAFgAh3gAiEgdgCAFgAh4gAiEgpgDAGgAh5gAiEg0gDAGgAh5gAiEg+gEAGgAh5gAiEhHgFAGgAh4gAiEhNgFAHgAh3gAiEhSgFAHgAh2
					gAiEhVgFAHgAh1gAiEhVgGAHgAh0gAiEhUgFAHgAh0gAiEhQgFAHgAh1gAiEhLgFAHgAh2gAiEhEgEAG]],
				Tail2 = [[
					f9h+g6cDdGfw/nf9h/g6cDdTfx/of+iAg6cDdlfz/pf/iAg6cDd6f1/rf/iAg6cDeTf4/sgAiAg6cDeuf6/ugBh/g6cDfLf9/vgCh+g6cCfqgA/vgCh9g6cC
					gJgD/vgDh8g6cDgogG/vgEh8g6cDhGgI/ugEh8g6cDhigL/tgEh9g6cDh8gN/rgFh+g6cDiTgP/qgFh/g6cDimgQ/ogFiCg6cDi1gS/ngLiFg5cFksgg/Zgh
					iIgwcRrQhU9sg4iJgPc80wih4BgviKfeeV9Ijmsof9iKfGgQ/nj9dGfNiJfjiH6YjWOWfKiHgVjWwRiHEwfkiFgzj3mRg4A5f6iDg6j9f/gFARgAiBg6j9eu
					f6ASf/h/g6j9fLf9ARf+h/g6j+fqgAARf+iAg6j+gJgDARf9iAg6j9gogGARf8iAg6j9hGgIASf8iAg6j9higLATf8iAg6j9h8gNAVf7h/g6j9iTgPAWf7h9
					g6j9imgQAYf7h9g6j9i1gSAZf7h8g6j9jAgSAaf7h8g6j9jFgSAaf8h8g6j9jGgSAaf8h9g6j9jDgSAa]],
				Tail3 = [[
					fyiMhyYvbHfL+wf0iOhyYvbEfM+wf1iOhyYvbKfO+xf3iPhyYvbXfS+zf5iPhzYubrfW+2f8iOhzYucGfc+5f+iNhzYtcnfi+9gAiMhzYsdOfq/BgDiLhzYs
					d5fx/EgFiKhzYreof6/HgHiKhzYrfYgC/IgKiKhyYrgKgK/IgLiLhyYrg7gS/IgNiMhyYrhrga/GgOiNhyYsiZgh/DgPiQhyYsjCgn+/gciThvYwlQhF+shH
					iWhaZKsBio8uhwiYgYah1bk22mhYiYe3dN9OmxqvfyiYeOg1+wnRbHeZiXfOkO4il+M0eYiVgwmYtyjkEFfOiThnnNjlhNBEf6iRhznTdVfvA+gEiPhznScG
					fcBHgCiNhznTcnfiBDgAiNhznUdOfqA/f9iOhznUd5fxA8f7iPhznVeof6A5f5iPhznVfYgCA4f2iPhynVgKgKA4f1iOhynVg7gSA4fziNhynVhrgaA6fyiM
					hynUiZghA9fxiLhynUjCgnBBfxiKhynTjngsBFfwiKhynSkFgwBJfxiLhynSkegzBMfxiLhynRkvg0BO]],
				Tail4 = [[
					fiinikU1a2ee9ffjioikU3aUeY9ZflioikU5Z7eU9VfnipilU6ZreU9SfqipilU6ZleW9RfuioimU6Zpea9SfyinimU5Z3eh9Vf3iminU4aPeq9Zf8ilinU3
					awe29fgAilinU1bYfD9mgFikinUzcJfS9tgKilinUxc/fi9zgOilinUvd7fy93gTimimUue6gD96gWinimUuf6gV97gZiqilUug7gl96gtiuihUzjghb9uhs
					iwh/Vbqjj98AiliygaXj0Knf2Hh6iyePb08EqfqZfiiydchi9frLa2dmixfBm02+o9M0dvivhRqDr8lCEifCitiarKhjhRCGgEirimrKbKe8CcgSipimrGZp
					eaCugOinimrHZ3ehCrgJininrIaPeqCngEioinrJawe2ChgAipinrLbYfDCaf7ipinrNcJfSCTf2ipinrPc/fiCNfyioinrRd7fyCJftinimrSe6gDCGfqim
					imrSf6gVCFfnililrSg7glCGfkikilrRh6g1CJfjikikrQi2hDCOfiilikrOjuhPCUfhimikrMkfhaCa]],
				Tail5 = [[
					fSjNjNRndUeh8afSjOjNRqcReP8SfSjPjMRtbUd/8KfUjPjMRwafdz8BfXjPjNRzZzdq75fbjPjNR2ZRdl7yfgjOjOR5Y5dj7tfljNjPR6Ysdm7qfrjMjQR7
					Yrds7rfyjLjRR6Y0d17uf5jLjSR4ZJeC7zgAjLjSR2ZpeT77gIjMjSRzaTel8DgPjNjSRwbGe68MgVjOjSRscAfR8UgcjRjRRpdCfp8bg3jUjMRofqg08kiJ
					jXigSNmxkL7vjRjZgeUrwzo+3EiXjZdtaD5ttLsZfSjZczhf8auZdUc6jYe6of29rtPDdPjWhvs2sammGTe+jUjHuViBhmDhgTjSjQuTbTebD1gljQjNuKZR
					dlEOggjOjOuHY5djETgbjNjPuGYsdmEWgVjOjQuFYrdsEVgOjPjRuGY0d1ESgHjQjSuIZJeCENgAjPjSuKZpeTEFf4jPjSuNaTelD9fxjOjSuQbGe6D0frjN
					jSuUcAfRDsfkjMjRuXdCfpDlffjLjQuZeIgCDgfajLjQuafRgbDdfWjMjPubgbgzDefUjMjOuahlhKDh]],
				["FinB1.L"] = [[
					e7hQhNqDT8ey72e7hRhNp4Tzea70e7hShNpvTreF7ze7hShNpnTldz7ye7hShNpiTido7xe7hShNphTgdl7xe7hRhNpiTido7xe7hQhNpnTldz7ye7hPhNpv
					TreF7ze7hOhNp4Tzea70e7hOhNqDT8ey72e7hOhNqNUEfK72e7hPhNqXUMfg73e7hQhNqeUTfx73e7hRhNqiUXf873e7hUhNq3T3fl7hfDhXhUrMUdeU7mfr
					hahlqsZkbS9EgxhbhboLjDXV9ihmhcgSjGvBUY5jhFhcezcp5TUdvdfkhaecXT9qX4hbeghZfZUv7TczUJedhXgfUo1Vg8LFezhVhFVbv6jIGje7hThNV9tw
					jSFIe7hRhNWTs2ioEfe7hRhNWZsbiNEOe7hShNWRsVh7ENe7hShNWIsNhmEMe7hShNV9sEhOEKe7hShNVzr8g2EKe7hShNVpr0ggEJe7hRhNVirtgPEJe7hP
					hNVerpgEEJe7hPhNVcrogAEJe7hOhNVerpgEEJe7hOhNVirtgPEJe7hOhNVpr0ggEJe7hPhNVzr8g2EK]],
				["FinB2.L"] = [[
					eQgwhtpHU0ew8heQgyhto+UseY8gePg0hto1UmeC8feOg1htouUgdw8deOg2htopUddl8ceOg1htooUbdh8ceOg0htopUddl8ceOgzhtouUgdw8dePgxhto1
					UmeC8feQgvhto+UseY8geQguhtpHU0ew8heRgthtpRU8fJ8ieSgshtpaVDff8jeTgthtpgVJfx8jeTgthtplVNf88jeSgwhrp6Utfl8Peag0hzqSVWeV8TfO
					g4iRp1ambe9ng0g7iQndkOXw9siQg9gziowLVD5Mh6g+eicj6JVQulfxg/dmXl99YngPd9g+etVU7DdWS9dmg8gXVX0qhQKEd+g6hXWOvCjSFueKg3hoWys1
					jXEZeNg0hsXLr7isDzeOgzhtXSrgiQDjePgzhtXLrah+DheQgzhtXCrUhoDgeQgyhtW5rMhQDfeRgxhtWvrEg3DeeSgvhtWmq9ghDdeTgthtWgq3gPDdeTgs
					htWbqzgEDdeTgrhtWaqygADdeTgqhtWbqzgEDdeTgrhtWgq3gPDdeSgshtWmq9ghDdeRguhtWvrEg3De]],
				["FinB1.R"] = [[
					hFhQhNqDsEhO72hFhRhNp4sNhm70hFhShNpvsVh77zhFhShNpnsbiN7yhFhShNpiseiY7xhFhShNphsgib7xhFhRhNpiseiY7xhFhQhNpnsbiN7yhFhPhNpv
					sVh77zhFhOhNp4sNhm70hFhOhNqDsEhO72hFhOhNqNr8g272hFhPhNqXr0gg73hFhQhNqertgP73hFhRhNqirpgE73hFhUhNq3sJgb7hhNhXhFrUubgf6Nhj
					hagfrn0Per12hghbfZq66zbNsxgchcecoN9oXMfIe7hcezjX5TUdQjeahagSdwulUTGJfPhZhbZNiBWeCTgVhXhlWqYKZcDLg9hVhUV0S6bwE/hFhThNV9SQ
					cuFIhFhRhNWTTKdYEfhFhRhNWZTldzEOhFhShNWRTreFENhFhShNWITzeaEMhFhShNV9T8eyEKhFhShNVzUEfKEKhFhShNVpUMfgEJhFhRhNViUTfxEJhFhP
					hNVeUXf8EJhFhPhNVcUYgAEJhFhOhNVeUXf8EJhFhOhNViUTfxEJhFhOhNVpUMfgEJhFhPhNVzUEfKEK]],
				["FinB2.R"] = [[
					hwgwhtpHrMhQ8hhwgyhto+rUho8ghxg0hto1rah+8fhyg1htourgiQ8dhyg2htoprjib8chyg1htoorlif8chyg0htoprjib8chygzhtourgiQ8dhxgxhto1
					rah+8fhwgvhto+rUho8ghwguhtpHrMhQ8hhvgthtpRrEg38ihugshtpaq9gh8jhtgthtpgq3gP8jhtgthtplqzgE8jhugwhrp6rTgb8Ph8g0haqatogk7AiX
					g4gbqyzoe821iDg7exqR6kbvt7gQg9don498X8gTeGg+eijd6JVQRbdvg/g2eOvvU7GhfPg+iTZ6jPW0CKg4g8iSXdZQZiCohtg6hxWoT3btERh2g3hoWyTL
					cpEZhzg0hsXLUFdUDzhygzhtXSUgdwDjhxgzhtXLUmeCDhhwgzhtXCUseYDghwgyhtW5U0ewDfhvgxhtWvU8fJDehugvhtWmVDffDdhtgthtWgVJfxDdhtgs
					htWbVNf8DdhtgrhtWaVOgADdhtgqhtWbVNf8DdhtgrhtWgVJfxDdhugshtWmVDffDdhvguhtWvU8fJDe]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Spine1 = [[
					gAh3gAAFgAgAiIgAh7gAAGgCgdiIgAh8gAAGgEg1iIgAh6gAAHgEhEiHgAh4gAAHgFhHiHgAh8gAAGgEg+iIgAh8gAAGgDgqiIgAh5gAAGgBgPiIgAh5gAAG
					f/fxiIgAh8gAAGf9fWiIgAh8gAAGf8fCiIgAh4gAAHf7e5iHgAh6gAAHf8e8iHgAh8gAAGf8fLiIgAh7gAAGf+fjiI]],
				Spine2 = [[
					gAh8fUAGf/fviOf/iBfUAGgAf5iOf+iCfUAGgAgEiOf9iAfUAGgBgOiOf9h+fUAGgCgWiOf9iBfUAGgCgaiOf+iCfUAGgCgZiOf/h/fUAGgBgUiOgBh/fUAG
					gBgMiOgCiCfUAGgAgBiOgDiBfUAGf/f3iOgDh+fUAGf/ftiOgDiAfUAGf+fniOgCiCfUAGf+fmiOgBiBfUAGf+fpiO]],
				Spine3 = [[
					gBiDeoAZf5fQkzf/iHeoAZf4fLkzf+iIeoAZf5fPkzf8iGeoAZf7fckzf8iEeoAYf9fuk0f8iIeoAYgBgEk0f9iIeoAYgEgZk0f+iFeoAZgGgqkzgAiFeoAZ
					gIgzkzgCiIeoAZgIg0kzgDiIeoAZgHgrkzgEiEeoAYgEgbk0gEiGeoAYgBgHk0gDiIeoAYf+fxk0gCiHeoAZf7fekz]],
				Spine4 = [[
					gDiQd+AafyemkzgBiUd+AbfweYkzgAiWd+Abfxeckzf+iTd+Aaf0exkzf9iRd+AZf5fUkzf8iVd+AYgAf/k0f8iVd+AZgGgqkzf9iSd9AagMhNkzf+iSd+Ab
					gPhkkzgAiVd+AbgQhpkzgBiVd+AagOhckzgDiRd+AZgKg/kzgEiTd+AYgEgXk0gEiWd+AYf9frk0gEiUd+AZf3fDkz]],
				Head = [[
					gGiddT/9f+hbgigGihdT/6f9iHgxgEijdT/5f9iagogBigdT/6f/iUgNf/iedT/8gBh0fzf8iidT/+gBg/fqf6ijdT//gAgAf4f5ifdT/+gBfBgVf6ifdT/7
					gDeNgsf7ijdT/5gDdsgvf9iidT/5gCdlgcgAiedT/7gAd5f/gDigdT/9f/elfsgFijdT//gAfgfvgGihdT//gAgggG]],
				Jaw = [[
					gRiEbhgE/7ekhbgViGbigH/4eViGgViJbigH/3eeiagSiJbhgF/4e5iUgMiKbggD/7fThzgDiPbfgB/+fcg/f6iObfgA/+fOgAfyiHbgf+/9exfBftiFbhf6
					/5eaeNfriIbif4/3eXdsfsiJbif6/3eqdmfxiJbhf8/6fHd5f4iNbgf+/9fbelgBiPbff//+fXfggKiLbggB/+fAgg]],
				["FinF1.L"] = [[
					erhgeLrJShd76sephkeMqFRYb/6TenhleNpAPqa35eemhjeOoENtay4aelhhePnjL1bt3QelhlePnvKXdW2FemhlePosJifU1CenhieOqQJhhO0RephieOrK
					J3iD0HerhleNrNKahw0tethleMrSLkhJ12euhheLrVNLgV3PeuhjeLrVPAfe4neuhleLrRQues5ueshkeLrMR/eK6b]],
				["FinF2.L"] = [[
					dngwewnbaJeo+hddg/evmkZFbt+PdVhMeqlpXUZm9ldPhReik1VIYp8xdMhReXkZS5ZC7/dNhQeMkiQ9an7VdRhHeDlXPtdE61dZg4d9msPXf76fdegyd7nb
					PnhX6adfg1d/neQWhK62dgg1eGnhR0gx7qdhgxeQnjT1gO8mdjgzebnjWDfp9cdlg1elngYFfI+Ddng0esndZiex+a]],
				["FinF1.R"] = [[
					hYhgeOrJ2Md70EhWhkeNrL18eE0VhUhleMrP1Fei1OhThjeMrUzrfQ2ihShheLrWx7gH39hShleLrTwGg85NhThleLrOukhn6IhUhieLrKtpiA6nhWhieMqn
					t+jI6khYhleNpivckt57hahleOogxUlU49hbhheOnvzRk431hbhjePnj0/jj2qhbhlePoI2Jhs1ihZhkePpb2lfu0m]],
				["FinF2.R"] = [[
					iigwd7nbwceo6Yihg0d8ncwIet6kigg1eCnfvAfB7OiggzeLnitPfg8IiegxeWnjrEgE9Dicg1ehnio5go9yiag1epnfnGhF+QiZgyevncmDhW+fieg4ewnA
					mSi6+cinhGetmHnvlf98iuhPemlOpwnD9LizhRedkjsBnV8Xi0hSeRkYuJmU7piyhNeHk3vykQ7EirhAd/l+wmhi6p]],
				Tail1 = [[
					gAh3gAd8hUgF/5gAh7gAd8g7gE/6gAh8gAd8gXgC/7gAh6gAd8fwf//7gAh4gAd8fLf9/6gAh8gAd8ewf7/5gAh8gAd8eif6/5gAh5gAd8elf6/5gAh5gAd8
					e3f7/5gAh8gAd8fWf9/6gAh8gAd8f8gA/7gAh4gAd8gjgC/6gAh6gAd8hEgE/6gAh8gAd8hZgG/5gAh7gAd8hegG/5]],
				Tail2 = [[
					gFh+g6cEkNgY/dgDiCg6cDjMgS/lgBiEg6cDhngJ/tf/iCg6cCfwf+/vf9h/g6cDd8f0/rf7iDg6cEcffs/jf7iEg6cEbpfn/cf7iBg6cEbjfn/bf8iBg6cE
					cOfr/hf+iEg6cDdjfz/pgAiDg6cDfUf9/vgCh/g6cDhMgH/ugEiCg6cDi2gR/ngFiEg6cEkBgX/fgFiCg6cFkgga/b]],
				Tail3 = [[
					gUiMhxY2nwhS+LgPiRhyY0m8hG+XgHiShzYvk7gv+wf+iQhzYriCgP/Ef2iOhyYreyfs/HfviRhxYubvfN+2friShwYzZee3+dfriPhwY2YVeu+MfuiPhxY2
					Yfey+Pf1iShyYyZ8fE+jf9iShzYtccfg+8gGiOhzYrflgC/IgOiQhyYsi0gk/AgTiShxYwlhg/+pgViRhwY1nRhP+S]],
				Tail4 = [[
					guimifVPqJi08OgmirihVSqmiy8FgYisikVKpSiS8igFiqinU7mXha9TfyioinUwiSgQ93fhisikUwdxfD92fVisigU6ZreC9RfRipieVJWvdX8gfVipifVS
					VadJ8EfgisijVPV2da8PfxisimVDYAeH86gFioinU0blfK9ogYiqilUuf/gX97gmisiiU0kZhg9nguirifVCn+iX84]],
				Tail5 = [[
					hLjNjASPpyj565hFjRjCSnsRkc59gzjSjIStsukR50gZjQjPScrGjZ6jf5jPjSR/nih67sfajSjPRqijgE8efDjTjIRrdDeM8Ze2jPjCSAYKcq7ee3jPjASd
					Uvbw6WfDjSjEStTQbk5xfZjSjMSnT2cG6Ff3jOjRSOWedS7HgXjRjSRza2e/8LgzjTjMRngOg58jhFjRjFR0liip8A]],
				["FinB1.L"] = [[
					e7hQhNqYPSiB5Je9hUhPqbQEht5pe/hWhQqhRmhF6ifAhUhRqkTqgS7jfAhRhSqjV7fb8dfAhVhRqfX/er9He+hWhQqaZceK9ee8hShOqXaAd99me6hShMqJ
					ZKc79Ze4hWhKpqXHbR8ye2hVhJpEUpag79e2hRhIodSMaw7Fe2hUhIoHQLb96Se3hWhJoSO6d25pe5hUhLpGOlf/5P]],
				["FinB2.L"] = [[
					eKgshcpbP+h15+eNgxhhpeQyhj6deSgyhopjSXg/7TeXgwhvpmUfgQ8Qedgth2plWzfe9Gehgxh6phY6ez9rekgyh8pdaZeV9/ekgvh7paa+eJ+Gedgxh4pC
					aDcx97eTg5hzoSX4ac9SeKg+htnkVVZG8XeDg+hmm+S0ZA7ad/hBhgmxQuaL6pd/hBhcnHPbcV6KeDg5haoEPJfD58]],
				["FinB1.R"] = [[
					hFhQhNqYmGiB9khHhUhLp6nykA9IhJhWhJpYqHlP8YhKhUhIowsnlg7hhKhRhIoPu5kw6qhKhVhJoHwljK58hIhWhKonxZhG5ahGhShMptxNe+5JhEhShOqZ
					wceH5VhChWhQqevRel6DhAhVhRqjtbfU7DhAhRhSqkrNgK8ChAhUhRqhpAg+80hBhWhQqcnNho9UhDhUhPqYmKh/9j]],
				["FinB2.R"] = [[
					hegsh6pblIh1+Fhog1h2oqm+kg9qhyg8hwn7pYmY82h6g/hqnPr9nH74iAg/hjm0uUmk7AiBhChdm3wDk36Xh/g9hanhw3iX6Bh6gzhbouwlfj57h0gvhepc
					vueS6Jhxgyhkpguhet62hsgxhsplsofY7yhmgthzpmqXgJ8thhgwh4pjoGg59bhdgyh7pfmQhe93hcgxh7pblNh0+E]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Spine1 = [[
					gAiAgAAIgAgAimgAiTf7AKgAgAi8gAibf4AJgAgAi0gAiTf7AGgAgAiRgAiAgAAEgAgAhpgAiAgAADgAgAhTgAiAgAADgAgAhbgAiAgAAFgAgAh+]],
				Spine2 = [[
					gAiHfUAIgAgAisgAibfPAKgAgAjCgAijfNAJgAgAi6gAiafPAHgAgAiYgAiFfUAEgAgAhwgAiEfUADgAgAhZgAiEfUADgAgAhigAiGfUAFgAgAiE]],
				Spine3 = [[
					gAiPeoAXgAgAkrgAikejAYgAgAkzgAirehAZgAgAk6gAigejAagAgAk+gAiKeoAZgAgAk8gAiIenAYgAgAk0gAiIenAXgAgAktgAiLeoAXgAgAkp]],
				Spine4 = [[
					gAicd+ASgAgAkFgAixd5ARgAgAj+gAi4d2AUgAgAkVgAiud4AagAgAk/gAiXd9AggAgAligAiVd9AhgAgAlpgAiVd9AdgAgAlSgAiYd9AXgAgAko]],
				Head = [[
					gAindT/7gAgAiHgAi8dO/5gAgAibgAjEdM/9gAgAhcgAi7dO//gAgAfvgAimdT/8gAgAeUgAikdT/7gAgAeAgAikdT/+gAgAe/gAildT//gAgAgs]],
				Jaw = [[
					gAiCbjgA/jaxgAgAiVbfgA/gaegAgAilbagA/qbcgAgAiobagA/3dIgAgAidbegA/9ejgAgAidbegA/+e3gAgAiWbegA/7d4gAgAiKbggA/wcMgA]],
				["FinF1.L"] = [[
					ephteMrUVLcu7sepiCeGozREX25nepiJeEmCLgYn2neph9eHmTHvd8zwephmeNqpIEjfyBephjeOqnJniz0CephkeOq1N3gZ4BephoeNq/S3d267]],
				["FinF2.L"] = [[
					dug7e7nudHd4+1dZhwesluZKWZ9LdPiMeOjUS5U16wdShwdyjcNuaE5Vdkg1dum5NKiX4zdfgyd8mvPQh66Vddg1eZm7UrgQ9Gdng5e0nRajej+p]],
				["FinF1.R"] = [[
					hXhteMrUq1jS7shXiCeGozu8oK5nhXiJeEmC0gnZ2nhXh9eHmT4RiEzwhXhmeNqp38chyBhXhjeOqn2ZdN0ChXhkeOq1yJfn4BhXhoeNq/tJiK67]],
				["FinF2.R"] = [[
					iSg7e7nui5iI+1inhweslum2pn9LixiMeOjUtHrL6wiuhwdyjcySl85Vicg1dum5y2dp4zihgyd8mvwweG6Vijg1eZm7rVfw9GiZg5e0nRldhd+p]],
				Tail1 = [[
					gAiAgAd2gAgA/6gAiTf7dBhMf//1gAibf4cahrf8/vgAiTf7cXhMf9/wgAiAgAc6gAgA/1gAiAgAdve0gA/4gAiAgAeXeVf9/6gAiAgAeae0f+/7]],
				Tail2 = [[
					gAiIg6cNfBf+/wgEieg0aIhcgF/agGiogxYjjBgB+9gEihg0YYi1f8+8gAiMg6Zsg/f9/Wf8iIg6bxekf7/rf6iGg6dYc/f1/vf8iGg6dkdLf1/x]],
				Tail3 = [[
					f8iWhzZrdcfv/QgJizhqWmgrgP+kgRjDhkT7jfgc9agOi7hmTHkRgR89gEiihvUiikgB9wf2iYhyXgfWfw+1fviQhzaWcgfe/SfxiPhzbRbvfZ/V]],
				Tail4 = [[
					fzitioWyb8fJ+WgMjUibTOfKgK9UgcjriNPoi4g+7UgcjmiMN/k5g/59gMjJiaO7kGgc6vf0i2ikSGg5fv8zfjikioV7dIfE+NfiigipX9bGew+i]],
				Tail5 = [[
					fmjNjXUfbFei9ZgIj/jDREdhfy8LgjkfioM3hahO5kgpkdifKbkcht3IgYj+iyKok7hF3Qf4jkjJNXikf+53fajIjWRkene88ffSi9jaUtbgeT9i]],
				["FinB1.L"] = [[
					e7hYhMnmO0cJ5me7hphFqMNphI4He7hxhDq5PGht40e7hshHqsTVgW7We7hchOqBYeem9Ze7hehPpfbUdm+Ge7hdhOoyYhZ49Ne7hbhNnmTNY67a]],
				["FinB2.L"] = [[
					eChIhfmTPUaJ55eGhIhOpQOQgi48eKhNhQp+Pzhi5qeRhIhkpuUJgU8Eeeg5h5pDZaeu98eng8h/oicTdz+heahDh9nNZTY39leKhMhxl2T1W17g]],
				["FinB1.R"] = [[
					hFhYhMnmxMj35mhFhphFqMyXe44HhFhxhDq5w6eT40hFhshHqssrfq7WhFhchOqBniha9ZhFhehPpfksia+GhFhdhOoynfmI9NhFhbhNnmsznG7a]],
				["FinB2.R"] = [[
					h+hIhfmTwsl355h6hIhOpQxwfe48h2hNhQp+wNee5qhvhIhkpur3fs8Ehig5h5pDmmhS98hZg8h/oijtiN+hhmhDh9nNmtnJ9lh2hMhxl2sLpL7g]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Spine1 = [[
					gAh8gAAFgAgAiIgAh+gDAFgAgAiIgAiDgMAFgAgAiIgAiIgWAFgAgAiIgAiLgcAFgAgAiIgAiMgEAFgAgAiIgAiTfGAFgAgAiIgAiTfGAFgAgAiIgAiTfGAF
					gAgAiIgAiTfHAFgAgAiIgAiOfTAFgAgAiIgAiGfnAFgAgAiIgAh/f6AFgAgAiIgAh8gAAFgAgAiIgAh8gAAFgAgAiIgAh8gAAFgAgAiI]],
				Spine2 = [[
					gAiCfUAGgAgAiOgAiEfXAGgAgAiOgAiJfgAGgAgAiOgAiOfqAGgAgAiOgAiRfwAGgAgAiOgAiSfYAGgAgAiOgAiZeaAGgAgAiOgAiZeaAGgAgAiOgAiZeaAG
					gAgAiOgAiZebAGgAgAiOgAiUenAGgAgAiOgAiMe7AGgAgAiOgAiFfOAGgAgAiOgAiCfUAGgAgAiOgAiCfUAGgAgAiOgAiCfUAGgAgAiO]],
				Spine3 = [[
					gAiIeoAYgAgAk0gAiKerAbgAgAlEgAiPe0AigAgAlugAiUe+ArgAgAmdgAiXfEAygAgAm8gAiYesAjgAgAlygAifduALgAgAjJgAifduALgAgAjJgAifduAL
					gAgAjJgAifdvALgAgAjLgAiad7ANgAgAjggAiSePASgAgAkGgAiLeiAXgAgAkogAiIeoAYgAgAk0gAiIeoAYgAgAk0gAiIeoAYgAgAk0]],
				Spine4 = [[
					gAiWd9AYgAgAk0gAiYeBAegAgAlVgAieeKAtgAgAmogAileVBDgAgAoFgAiqecBUgAgApCgAioeCAvgAgAmwgAiodDADgAgAhegAiodDADgAgAhegAiodDAD
					gAgAhegAiodDADgAgAhhgAikdPAGgAgAiNgAiedkANgAgAjZgAiYd3AVgAgAkcgAiWd9AYgAgAk0gAiWd9AYgAgAk0gAiWd9AYgAgAk0]],
				Head = [[
					gAijdT//gAgAgNgAindX/+gAgAfPgAiwdi/0gAgAcwgAi7du/agAgAZ+gAjCd2/BgAgAYLgAi6da/ohPgNbYgAiscW/fk7eNiHgAiscW/hk9eziBgAiscW/i
					lDgwhtgAiscX/hlAhVhmgAiqcj/tj7f3hggAinc5/5iIfTg+gAikdM//gjf5gZgAijdT//gAgAgNgAijdT//gAgAgNgAijdT//gAgAgN]],
				Jaw = [[
					gAiMbggAABgAgAgAiXbjgAABgmgAgAizbsgAADhQgAgAjSb7gAABgAgAgAjmcGgAADhbgAgCjGblhFA9nmfWf8iHank/AojWhngAiIamlEA7lngogOiNamlB
					AiilfIgSiOanlBAehZetgGiKayj6AShTgKf+iKbHiIAHgwgugAiLbZgjABgMgHgAiMbggAABgAgAgAiMbggAABgAgAgAiMbggAABgAgA]],
				["FinF1.L"] = [[
					ephleNrWN3gA3yephneQq4NKfp3cephseZplLdey2iephxein3Jsd91beph0epmoIpdg0reph1eQosLXdl2teph8dTrISvd26zeph8dTrISvd26zeph8dTrI
					Svd26zeph8dUrJSrd36xeph3dgrNRoeU6Oephvd0rTP3fF5LephoeGrVOXfx4KephleNrWN3gA3yephleNrWN3gA3yephleNrWN3gA3y]],
				["FinF2.L"] = [[
					ddg2eWnjUqgA88dag7eXnRT9fc8udVhKeYmYSNeE8FdShbealHQWcm7NdRhmebkLPObt6kdThbeSlzSVcq8IdmhNd4nbaZek+kdmhNd4nbaZek+kdmhNd4nb
					aZek+kdmhMd5nbaUel+kdjhId/neZIe4+Udgg/eKniXEfZ9xdeg4eTnjVRf29Lddg2eWnjUqgA88ddg2eWnjUqgA88ddg2eWnjUqgA88]],
				["FinF1.R"] = [[
					hXhleNrWyJgA3yhXhneQq4y2gX3chXhseZpl0jhO2ihXhxein32UiD1bhXh0epmo3Xig0rhXh1eQos0pib2thXh8dTrItRiK6zhXh8dTrItRiK6zhXh8dTrI
					tRiK6zhXh8dUrJtViJ6xhXh3dgrNuYhs6OhXhvd0rTwJg75LhXhoeGrVxpgP4KhXhleNrWyJgA3yhXhleNrWyJgA3yhXhleNrWyJgA3y]],
				["FinF2.R"] = [[
					ijg2eWnjrWgA88img7eXnRsDgk8uirhKeYmYtzh88FiuhbealHvqja7NivhmebkLwykT6kithbeSlztrjW8IiahNd4nblnhc+kiahNd4nblnhc+kiahNd4nb
					lnhc+kiahMd5nblshb+kidhId/nem4hI+Uigg/eKnio8gn9xiig4eTnjqvgK9Lijg2eWnjrWgA88ijg2eWnjrWgA88ijg2eWnjrWgA88]],
				Tail1 = [[
					gAh8gAdqgAgA/6gAh+gDdkgAgA/5gAiDgMdUgAgA/4gAiIgWdCgAgA/2gAiLgcc2gAgA/1gAiMgEdIgAgA/3gAiTfGdriqgB/ygAiTfGdqhpgA/3gAiTfGdq
					eXgA/3gAiTfHdrdYf//zgAiOfTdqgAgA/6gAiGfndqhIgA/4gAh/f6dqgLgA/5gAh8gAdqgAgA/6gAh8gAdqgAgA/6gAh8gAdqgAgA/6]],
				Tail2 = [[
					gAiFg6bfgAgA/rgAiHg9bTgAgA/pgAiNhGazgAgA/kgAiThPaQgAgA/egAiXhWZ5gAgA/ZgAiWg+acfbgB/ggKicgAbik7gM/SgGicgAbilVgI/Of6icgAbf
					eXf4/of2icgAbjZwf0/DgAiXgNbfeNgA/ngEiPghbgiHgF/mgBiHg0bfglgB/qgAiFg6bfgAgA/rgAiFg6bfgAgA/rgAiFg6bfgAgA/r]],
				Tail3 = [[
					gAiVhyX2gAgA+7gAiYh1XkgAgA+3gAifh9W2gAgA+pgAiniGWDgAgA+ZgAitiMVhgAgA+Of+iqh0WWePf8+cgbisg1X8k4gx+kgZisg1YLp6g99Yf0isg4X4
					hWf2+6fgisg0YHXAe99pf6inhFX9ahfn+egMifhZX3iFgV+3gDiYhsX3hGgH+6gAiVhyX2gAgA+7gAiVhyX2gAgA+7gAiVhyX2gAgA+7]],
				Tail4 = [[
					gAiyilTqgAgA9ggAi2ioTTgAgA9XgAi/iuSZgAgA89gAjKi1RYgAgA8dgAjRi6QvgAgA8Hf4jMikRzc0fm8fgsjJhlTwhKhA9gg5jHhdUltBis6wf5jJhrUB
					nGgt8yfDjIheUGXOdu8RfnjEh1UMWOeW8BgTi8iMTrgfgc9ggHi1ifTrhegT9egAiyilTqgAgA9ggAiyilTqgAgA9ggAiyilTqgAgA9g]],
				Tail5 = [[
					gAjcjOQSgAgA73gAjhjQP3gAgA7ngAjtjUOzgAgA6+gAj6jXNogAgA6MgAkCjaM5gAgA5pfuj7jGOMb2fG6OgujyiPQzaRf+7jhejvh2RhsnkN5PgQjxiPRw
					tYim5MepjwiAQpbmdZ7lfJjriUReTacu5WgUjmi1QYdjgA7zgLjejIQThbge71gAjcjOQSgAgA73gAjcjOQSgAgA73gAjcjOQSgAgA73]],
				["FinB1.L"] = [[
					e7hWhNqkUYgA73e7hYhQqhUWf573e7hchZqZUPfm73e7hhhjqQUHfR73e7hlhpqKUCfE72e7hlhRqUUxfK8Ge7htgTqhW3fF8xe7htgTqhW3fF8xe7htgTqh
					W3fF8xe7htgUqiW1fG8xe7hoggqiWUfS8me7hgg0qkVbfn8Se7hYhHqkUpf67+e7hWhNqkUYgA73e7hWhNqkUYgA73e7hWhNqkUYgA73]],
				["FinB2.L"] = [[
					eTgyhtpmVOgA8jeTg0hxpjVMf58jeSg6h5pcVGfm8jeShAiDpUU/fQ8ieRhEiJpOU6fC8ieThDhzpYVpfK8xeahJg6pkXwfK9YeahJg6pkXwfK9YeahJg6pk
					XwfK9YeZhJg6pkXufL9XeYhEhFplXMfW9OeWg8hXpmWTfp87eUg1hopmVgf68peTgyhtpmVOgA8jeTgyhtpmVOgA8jeTgyhtpmVOgA8j]],
				["FinB1.R"] = [[
					hFhWhNqkrogA73hFhYhQqhrqgH73hFhchZqZrxga73hFhhhjqQr5gv73hFhlhpqKr+g872hFhlhRqUrPg28GhFhtgTqhpJg78xhFhtgTqhpJg78xhFhtgTqh
					pJg78xhFhtgUqipLg68xhFhoggqipsgu8mhFhgg0qkqlgZ8ShFhYhHqkrXgG7+hFhWhNqkrogA73hFhWhNqkrogA73hFhWhNqkrogA73]],
				["FinB2.R"] = [[
					htgyhtpmqygA8jhtg0hxpjq0gH8jhug6h5pcq6ga8jhuhAiDpUrBgw8ihvhEiJpOrGg+8ihthDhzpYqXg28xhmhJg6pkoQg29YhmhJg6pkoQg29YhmhJg6pk
					oQg29YhnhJg6pkoSg19XhohEhFplo0gq9Ohqg8hXpmptgX87hsg1hopmqggG8phtgyhtpmqygA8jhtgyhtpmqygA8jhtgyhtpmqygA8j]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAh5gAAFgAgAiIgAh5gAAFgAgAiIgAh5gAAFgAgAiIgAh5gAAFgAgAiIgAh5gAAFgAgAiIgAh8gAAFgAgAiIgAiBgAAFgAgAiIgAiCgAAFgAgAiIgAiCgAAF
					gAgAiIgAiCgAAFgAgAiIgAiCgAAFgAgAiIgAiCgAAFgAgAiIgAiCgAAFgAgAiIgAiCgAAFgAgAiIgAiCgAAFgAgAiIgAiCgAAFgAgAiIgAiCgAAFgAgAiIgA
					iCgAAFgAgAiIgAh/gAAFgAgAiIgAh6gAAFgAgAiIgAh5gAAFgAgAiIgAh5gAAFgAgAiIgAh5gAAFgAgAiI]],
				Spine2 = [[
					gAh+fUAGgAgAiOgAh+fUAGgAgAiOgAh+fUAGgAgAiOgAh+fUAGgAgAiOgAh+fUAGgAgAiOgAiCfUAGgAgAiOgAiHfUAGgAgAiOgAiIfUAGgAgAiOgAiIfUAG
					gAgAiOgAiIfUAGgAgAiOgAiIfUAGgAgAiOgAiIfUAGgAgAiOgAiIfUAGgAgAiOgAiIfUAGgAgAiOgAiIfUAGgAgAiOgAiIfUAGgAgAiOgAiIfUAGgAgAiOgA
					iIfUAGgAgAiOgAiEfUAGgAgAiOgAiAfUAGgAgAiOgAh+fUAGgAgAiOgAh+fUAGgAgAiOgAh+fUAGgAgAiO]],
				Spine3 = [[
					gAiFeoAYgAgAk0gAiFeoAagAgAk9gAiFeoAdgAgAlUgAiFeoAggAgAlmgAiFeoAggAgAljgAiIeoAqgAgAmZgAiNeoBJgAgAoagAiOeoBSgAgAo5gAiOeoBS
					gAgAo5gAiOeoBSgAgAo5gAiOeoBSgAgAo5gAiOeoBSgAgAo5gAiOeoBSgAgAo5gAiOeoBSgAgAo5gAiOeoBSgAgAo5gAiOeoBSgAgAo5gAiOeoBSgAgAo5gA
					iOeoBQgAgAo0gAiLeoA5gAgAnZgAiGeoAfgAgAldgAiFeoAYgAgAk0gAiFeoAYgAgAk0gAiFeoAYgAgAk0]],
				Spine4 = [[
					gAiSd9AYgAgAk0gAiSd+AbgAgAlHgAiTd+AjgAgAl0gAiUd+AqgAgAmXgAiUd+ApgAgAmRgAiZd/BBgAgAn+gAikeCCUgAgAr4gAimeCCtgAgAs1gAimeCCt
					gAgAs1gAimeCCtgAgAs1gAimeCCtgAgAs1gAimeCCtgAgAs1gAimeCCtgAgAs1gAimeCCtgAgAs1gAimeCCtgAgAs1gAimeCCtgAgAs1gAimeCCtgAgAs1gA
					imeCCogAgAsrgAifeABmgAgAp8gAiVd+AngAgAmHgAiSd9AYgAgAk0gAiSd9AYgAgAk0gAiSd9AYgAgAk0]],
				Head = [[
					gAifdT//gAgAgNgAigdT//gAgAfmgAijdU/8gAgAeMgAildV/2gAgAdDgAildV/3gAgAdPgAivdY/nf9gTbJgAjCdh+HfugwVQgAjHdk9/gmedVAgAjHdk9p
					f0gcUAgAjHdk9efghKTpgAjHdk9+gjelU8gAjHdk9vgAgAUOgAjHdk9afZhZThgAjHdk98gde1U0gAjHdk90gLfkUcgAjHdk9YfVhhTegAjHdk95gVfKUpgA
					jGdk9+gUfLU3gAi5dc+9fuhBYCgAimdV/8gAf7eUgAifdT//gAgAgNgAifdT//gAgAgNgAifdT//gAgAgN]],
				Jaw = [[
					gAiIbggAABgAgAgAiObfgAABflgAgAibbfgAADepgAgAilbggAAFd5gAgAikbfgAAFeBgAgCi9bjf6ABgWfugGj7b6fdAHiTfcf0kAb+hPATj5hHgDkIcCfp
					AJi1ftgJkKcEfBAJicfNf1kBb/hJASj0hBgAkGcBgAAKjEgAgLkKcFe0AJiTfCf3kCb/g9AQjsg2f9kFcAgXAMjTgUgMkLcFeuAJiPe9f5kDcAgsAOjhgmf6
					kBb+gqAOjcgmgIjebtfcAEhafHf/icbggBABghgFgAiIbggAABgAgAgAiIbggAABgAgAgAiIbggAABgAgA]],
				["FinF1.L"] = [[
					ephheNrWN3gA3yephheNrOOGft4BephheNq+OpfA4hephheNqxPHeb45ephheNqzPBei40ephleNpWLdec2nephqeNlkHjdlztephreNihGmb4y0ephreNkN
					G0dJzDephreNk1G7dnzHephreNioGmb9y1ephreNj1Gwc3zAephreNlCG+dxzIephreNi1GocHy3ephreNjdGtcly9ephreNlJG/d2zJephreNjHGqcVy6ep
					hreNjVGwcXzBephoeNnzJMeY09ephjeNqZMffR3HephheNrWN3gA3yephheNrWN3gA3yephheNrWN3gA3y]],
				["FinF2.L"] = [[
					ddgyeWnjUqgA88ddgzeYnfU/fu9Fdcg1ednVVvfE9Ydcg3egnOWXeh9mdcg2egnPWPen9jdVhFeNl6SGcz8BdShhd4iuNgZI5BdTh1d0gVMmWZ3idShqd0ho
					MqX/4IdThld0iGMtYl4UdTh1d0gaMmWg3ldShsd0hVMpXo4AdThkd0iQMuYy4YdThzd0gkMmWs3qdShvd0hDMnXS34dThjd0iVMvY54adThxd0gyMnW93wdS
					hwd0g9MvXH36dThReAkkPXbS6hdYg7eRmyTMee8eddgyeWnjUqgA88ddgyeWnjUqgA88ddgyeWnjUqgA88]],
				["FinF1.R"] = [[
					hXhheNrWyJgA3yhXhheNrOx6gT4BhXhheNq+xXhA4hhXhheNqxw5hl45hXhheNqzw/he40hXhleNpW0jhk2nhXhqeNlk4dibzthXhreNih5akIy0hXhreNkN
					5Mi3zDhXhreNk15FiZzHhXhreNio5akDy1hXhreNj15QjJzAhXhreNlC5CiPzIhXhreNi15Yj5y3hXhreNjd5Tjby9hXhreNlJ5BiKzJhXhreNjH5Wjry6hX
					hreNjV5QjpzBhXhoeNnz20ho09hXhjeNqZzhgv3HhXhheNrWyJgA3yhXhheNrWyJgA3yhXhheNrWyJgA3y]],
				["FinF2.R"] = [[
					ijgyeWnjrWgA88ijgzeYnfrBgS9Fikg1ednVqRg89Yikg3egnOpphf9mikg2egnPpxhZ9jirhFeNl6t6jN8Biuhhd4iuygm45Bith1d0gVzapn3iiuhqd0ho
					zWoB4Iithld0iGzTnb4Uith1d0gazapg3liuhsd0hVzXoY4Aithkd0iQzSnO4Yithzd0gkzapU3qiuhvd0hDzZou34ithjd0iVzRnH4aithxd0gyzZpD3wiu
					hwd0g9zRo536ithReAkkwpku6hiog7eRmys0hi8eijgyeWnjrWgA88ijgyeWnjrWgA88ijgyeWnjrWgA88]],
				Tail1 = [[
					gAh5gAdqgAgA/6gAh5gAdqgAgA/6gAh5gAdqgAgA/6gAh5gAdqgAgA/6gAh5gAdqgAgA/6gAh8gAdGftgA/2gAiBgAcNgzf+/wgAiCgAcAhqf7/sgAiCgAb/
					gef//vgAiCgAcAevgE/tgAiCgAcAefgF/tgAiCgAb/gAgA/vgAiCgAcAhhf7/tgAiCgAcAhRf8/tgAiCgAb/figB/vgAiCgAcAeWgF/sgAiCgAcAfGgD/ugA
					iCgAcCg5f9/ugAh/gAcnhDf+/ygAh6gAdZgFgA/4gAh5gAdqgAgA/6gAh5gAdqgAgA/6gAh5gAdqgAgA/6]],
				Tail2 = [[
					gAiBg6bfgAgA/rgAiBg6bfgAgA/rgAiBg6bfgAgA/rgAiBg6bfgAgA/rgAiBg6bfgAgA/qf/iGg6aYfLgA/egDiPg5YmgtgE/HgGiRg5YOjIf++4gCiRg5YN
					hyf5++f7iRg5YNeXf9+/f6iRg5YOc3gE+3gAiRg5YNfBgG/AgGiRg5YOiWgC+8gFiRg5YOi7f7+5f+iRg5YNgGf6/Bf6iRg5YOdKgA+5f9iRg5YOdjgG+7gD
					iQg5YRgzgF/CgEiLg5Zah+gB/PgAiEg6a+gSgA/lgAiBg6bfgAgA/rgAiBg6bfgAgA/rgAiBg6bfgAgA/r]],
				Tail3 = [[
					gAiRhyX2gAgA+7gAiRhyX2gAgA+7gAiRhyX2gAgA+7gAiRhyX2gAgA+7gAiRhyX2gAgA+7f8ibhwWPepf5+bgFiphtTsfxgR9hgRishrTLj0ga9DgIishsTL
					jcgB9Gf2ishsTIfDfn9RfvishrTMbxfq9Af8ishsTJdcgH9LgOishrTJiHgc9NgPishrTMkUgQ8/f/ishsTIhffy9QfwishrTKc6fk9If0ishsTMb+f39CgG
					ishsTOfvgU9UgLiihuU3ibgS94gBiWhxXGgjgD+ugAiRhyX2gAgA+7gAiRhyX2gAgA+7gAiRhyX2gAgA+7]],
				Tail4 = [[
					gAiuilTqgAgA9ggAiuilTqgAgA9ggAiuilTqgAgA9ggAiuilTqgAgA9ggAiuilTqgAgA9gf3i9igRoeUfq8hgEjTiWOheTgU6ugdjXiRN5jZhK6IgUjXiSN8
					kvgj5+fzjYiTN1gkfT6UfijXiRN7bue46Bf0jXiTN6b5fx6EgUjXiTN1g3g86TgdjXiRN9k1hA58gEjYiUN4jKf66LfmjXiSN3dye66OfnjXiSN9bBfM57gF
					jXiUN9eHgZ6WgTjJiaP6iKgt7jgDi1ijSsgwgJ9FgAiuilTqgAgA9ggAiuilTqgAgA9ggAiuilTqgAgA9g]],
				Tail5 = [[
					gAjYjOQSgAgA73gAjYjOQSgAgA73gAjYjOQSgAgA73gAjYjOQSgAgA73gAjYjOQSgAgA73fyjsjDN7eWfc6Vf+kIiuKec6gH3cglkOilJvh9h12zghkNilJ2
					lIhS2df2kOioJuiVfQ21fXkNikJxcyeG2sfokOimJ2bBfL2ggVkOinJtfEhO24gpkNikJ0kNh22lgOkOioJzkcgU2mfikOimJtfeea24fakNikJ2bJeY2ff+
					kNipJ4cjgO22gYj8i3L9hRhB44gFjijJPKg0gQ7LgAjYjOQSgAgA73gAjYjOQSgAgA73gAjYjOQSgAgA73]],
				["FinB1.L"] = [[
					e7hShNqkUYgA73e7hShNqkUYgA73e7hShNqkUYgA73e7hShNqkUYgA73e7hShNqkUYgA73e7hVhNqbUQfr73e7hbhNqNUEfJ72e7hchNqKUBfC72e7hchNqK
					UBfC72e7hchNqKUBfC72e7hchNqKUBfC72e7hchNqKUBfC72e7hchNqKUBfC72e7hchNqKUBfC72e7hchNqKUBfC72e7hchNqKUBfC72e7hchNqKUBfC72e7
					hbhNqKUCfD72e7hYhNqUUKfZ73e7hUhNqgUVf273e7hShNqkUYgA73e7hShNqkUYgA73e7hShNqkUYgA73]],
				["FinB2.L"] = [[
					eTguhtpmVOgA8jeTguhtpmVOgA8jeTguhtpmVOgA8jeTguhtpmVOgA8jeTguhtpmVOgA8jeTgyhtpeVHfr8jeRg5htpRU8fI8ieRg7htpOU5fA8ieRg7htpO
					U5fA8ieRg7htpOU5fA8ieRg7htpOU5fA8ieRg7htpOU5fA8ieRg7htpOU5fA8ieRg7htpOU5fA8ieRg7htpOU5fA8ieRg7htpOU5fA8ieRg7htpOU5fA8ieR
					g6htpOU6fC8ieSg2htpXVBfY8ieTgwhtpiVLf28jeTguhtpmVOgA8jeTguhtpmVOgA8jeTguhtpmVOgA8j]],
				["FinB1.R"] = [[
					hFhShNqkrogA73hFhShNqkrogA73hFhShNqkrogA73hFhShNqkrogA73hFhShNqkrogA73hFhVhNqbrwgV73hFhbhNqNr8g372hFhchNqKr/g+72hFhchNqK
					r/g+72hFhchNqKr/g+72hFhchNqKr/g+72hFhchNqKr/g+72hFhchNqKr/g+72hFhchNqKr/g+72hFhchNqKr/g+72hFhchNqKr/g+72hFhchNqKr/g+72hF
					hbhNqKr+g972hFhYhNqUr2gn73hFhUhNqgrrgK73hFhShNqkrogA73hFhShNqkrogA73hFhShNqkrogA73]],
				["FinB2.R"] = [[
					htguhtpmqygA8jhtguhtpmqygA8jhtguhtpmqygA8jhtguhtpmqygA8jhtguhtpmqygA8jhtgyhtpeq5gV8jhvg5htpRrEg48ihvg7htpOrHhA8ihvg7htpO
					rHhA8ihvg7htpOrHhA8ihvg7htpOrHhA8ihvg7htpOrHhA8ihvg7htpOrHhA8ihvg7htpOrHhA8ihvg7htpOrHhA8ihvg7htpOrHhA8ihvg7htpOrHhA8ihv
					g6htpOrGg+8ihug2htpXq/go8ihtgwhtpiq1gK8jhtguhtpmqygA8jhtguhtpmqygA8jhtguhtpmqygA8j]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Spine1 = [[
					gAh3gAAFgAgAiIgAh3gAAFgAgAiIgAh3gAAFgAgAiIgAiWgAAGgAgHiIgAjCgAAUgQj0iHgAjWgACfg0sIh9gAjNgAJchg2khggAiqgAWYiB+bgpgAh3gAmg
					iF/QfkgAh3gA0cho4hepgAiMgA8mg8uLeHgAi7gA/ggWlJd6gAjUgA/6gCgbd4gAjRgA/7gAgAd4gAizgA/7gAgAd4gAiBgA/7gAgAd4gAh3gA/7gAgAd4gA
					h3gA/7gAgAd4gAh3gA/7gAgAd4gAh3gA/7gAgAd4gAh3gA/7gAgAd4]],
				Spine2 = [[
					gAh8fUAGgAgAiOgAh8fUAGgAgAiOgAh8fUAGgAgAiOgAicfUAGgAgHiOf2jIfVAVgRj0iNfhjcfhCfg2sIiDfUjTgAJchk2khkfniwgkWYiH+bgrgSh8gomg
					iL/Pfjgrh8gI0bht4helgjiSfl8mg/uLeBgOjAfW/fgXlJd0gBjafU/6gCgbdygAjXfU/6gAgAdygAi4fU/6gAgAdygAiHfU/6gAgAdygAh8fU/6gAgAdygA
					h8fU/6gAgAdygAh8fU/6gAgAdygAh8fU/6gAgAdygAh8fU/6gAgAdy]],
				Spine3 = [[
					gAiDeoAYgAgAk0gAiDeoAlgAgAl9gAiDeoArgAgAmdf/iieoArgBgHmdfrjOeqA5gxjvmafCjifBDCidr6l+eojZgAJ2kk2KkkfNi2hIWjmK93h9gjiDhRmY
					mU+reshXiDgQ0Ek94Eb4hGiYfL8Ei3t6aOgcjHes+7hDlDZogCjgeo/VgGgbZjgAjdeo/VgAgAZjgAi/eo/VgAgAZjgAiNeo/VgAgAZjgAiDeo/VgAgAZjgA
					iDeo/VgAgAZjgAiDeo/ZgAgAZ3gAiDeo/jgAgAavgAiDeo/ogAgAbM]],
				Spine4 = [[
					gAiQd9AYgAgAk0gAiTd/A0gAgAnFgAiUd/BDgAgAoFf/i0d/BDgCgHoFfhjfeDBSg+jsoCelj0ekDYjFrxnfd/jrgAKIlu14lue2jHhpWrnt9gicgziUh2mT
					n7+TeXh/iUgXz0mN3xa1hniqey7vjmtvYwgpjYeG+jhTk/YBgDjyd/+8gHgbX7gAjvd/+9gAgAX7gAjQd/+9gAgAX7gAifd/+9gAgAX7gAiUd/+9gAgAX7gA
					iUd/+9gAgAX7gAiTd//GgAgAYigAiRd+/egAgAaRgAiQd9/ogAgAbM]],
				Head = [[
					gAiddTAIgAgAilgAimdWAedvfok3gAiqdYAycXfRl3f/jKdYAycZfYl4fYj1ddA0eejTmHeKkJeJC7iPr9lddYkBgAKKlw2fikegjdiJXSms9/eThDiqianF
					lA+bbQiliqge0bjF3zagiFi/ea8Liot9aug1judh+4jLlgakgFkIdY/OjuhKaMgAkFdY/OjpgvaJgAjmdY/XiQgdaIgAi1dY/cgAgAaHgAiqdY/XdwfjaIgA
					iqdY/OcXfRaJgAiodX/VcWfWaxgAihdU/tdufucfgAiddT/4gAgAdb]],
				Jaw = [[
					gAiabdgAAJdOgAgDi1biiKAHgsfPgFjAbljVAUiOeYgDjgbljWATiNeffAkLbsiUASh+izc5kfc3g2CfiEsIblkXgDgHKNjC3OdijzjrhHX/j2+th2jAkBi2
					oDi0+tkXjAgwjC1JgK3zjhjVdUg/8meAuLhdkEb1eV/QdemIgNkeblct/rdviDgFkbblcr/sdyhogDj8bld8/1dyhAgAjLblgA/6dxgAf9jAbliE/1dyfAf7
					jAbljV/sdyeYf7i5bjjc/weuenf9ilbfiQ/4hXfkgAiabdgA/3iygA]],
				["FinF1.L"] = [[
					ephgeNrWN3gA3yephgeNmGJjb11jephgeNjSILaT0Teph/eNjWH2a70EeRirekgAJdZq1ydxi/frZbPhZD5seNi2hXbwbebQ/BgEiTiQckrebW9Th9hghHZw
					4ud9zNiBhgfAZh+2hJlUgnh1d1bF+hkJY6fTijd3b57gjuQqeti9eKf05emaNwepi6eNjG5AoyOXepibeNeu4ymMMzephqeNct3+lfL0ephgeNcu31ltLtep
					hgeNcu31ltLtephgeNa+3CkzK7ephgeNWn0Gh1JCephgeNUqyJgAIO]],
				["FinF2.L"] = [[
					ddgweWnjUqgA88dPhZeHj8QiaF7FdQhseBh0PHXu50dQiJd+hwOpYT5rc6jEelenQxWe6bcujxgOX2XlVG7sd3jRiqYqkEZe+LhDibjRZiy8cH4pjUhsgvXi
					8tf6rSidhsdqYf+pj6cdf9iFcnbC6znOQ6eFiqdJdJ17mqJ4dajadygqy5p8IMdgjrd3jIySs+JZdUiyd6f0yBpXHTdRh2eAeNxFoFGQdQhseBeMw5oSGMdQ
					hseBeMw5oSGMdPhgeFc3wEm3FZdVhAeQZutKihDpddgweWYdrWgADE]],
				["FinF1.R"] = [[
					hXhgeNrWyJgA3yhXhgeNmG2dkL1jhXhgeNjS31lt0ThWh/eMjY4TlDz5g5ird7hg7EmKv0fsi/dxgN9ypkmreNi2epkw/BkQbed3iTgtlf6PeLOpffhgiMk7
					vBboEihihghqiSgVZ1AtiQh1f/gUTKZlDbh3ijeudTK0bKIshai9ePf/HCZmNEhXi6eNjGHAXOOXhXibeNeuHOZ0MzhXhqeNctICahL0hXhgeNcuILaTLthX
					hgeNcuILaTLthXhgeNa+I+bNK7hXhgeNWnL6eLJChXhgeNUqN3gAIO]],
				["FinF2.R"] = [[
					ijgweWnjrWgA88ixhZeHj8vel77FiwhseBh0w5oS50iuiJd8hzxins5kiGjEdUg61Epl2EgQjxcvh35dtftyd3jRdWmi+LnWkEckibgIni9rgiWveShsi7nv
					11cjKNhdhsjElNpBZUCgjRiFg8ivbyXrBijRiqe4faSQYyEDitjad7g7NwWGHsigjrd3jINuTCJZisiyd6f0N/WpHTivh2eAeNO7X7GQiwhseBeMPHXuGMiw
					hseBeMPHXuGMixhgeFc3P8ZJFZirhAeQZuS2dfDpijgweWYdUqgADE]],
				Tail1 = [[
					gAh3gAdqgAgA/6gAh3gAdrifgM/zgAh3gAdrkOgU/ogAiWgAc7hfgJ/zgAjCgAb7hMgK/tgAjWgAbmn2hI+rgAjNgAcs0gi04LgAiqgAfF+sjaoSgAh3gAgy
					+GiNVbgAh3gAhs2DhoI9gAiMgAijuJhRDdgAi7gAjxoohEBdgAjUgAkdkngqArgAjRgAkchXgMAXgAizgAjudZfsAWgAiBgAikbkfpAcgAh3gAiVdZf0ANgA
					h3gAiWhYgGAIgAh3gAiVjcgQASgAh3gAiWhBgFAIgAh3gAiWgAgAAG]],
				Tail2 = [[
					gAh/g6bfgAgA/rgJh/g5bhjygd/cgPh/g4bnoeg6+hgFiig5aFksgh/FgEjRg5YEgngQ+/gbjngxXbjyh6+hg4jdgJZbwulN58gdi3fOeK98mmo8fch/fTht
					8vkLSsfGh/gDjdyfi3GTfSiWgjk/sCiTC4fijJgxnSqQiMCrfwjlg2ojowhlCff7jhg4olkkgnBigJjAg4nOc5fXBAgQiLg4k5XyfCBggJh/g5kcZbfWBCf7
					h/g6khgigJAWf0h/g5kdl3gqA4f8h/g6kgiRgPAbgAh/g6khgAgAAV]],
				Tail3 = [[
					gAiPhyX2gAgA+7gWiPhwX5jgg3+vgsiPhoYTrjiQ8ugWi3htWCoyhj9DgGjthsS8iMgd9HgmkFhiSBg/ic8qhlj6gfU+rrnw6jg6jPeicn7qq+rPexiPevjW
					7lnaR+eRiPgVmnujkhEreriqhKo1oGjeCjfCjkhZsBpfj1ELfUkDhftlrkjSFqfskAhottomhoEdgUjahssEerfACbgsidhoogVsdyDCggiPhtnxVSeGC9f5
					iPhyoHdsf3BKffiPhtoAmnhcByf0iPhxoHjYgoBQgAiPhyoKgAgABF]],
				Tail4 = [[
					gAisilTqgAgA9ggiisiiTuhvhC9dhQisiNUksokG6xgxjaiUR+scjf5rgNkYiSNxlehI5sgmk0iGMbgMik5Lh/kmg8QHmepe5ShZj2eEaW3nvOuNeHiseRlE
					6xrPTjdnisgyqerTl8EneTjLh0tLjMj6DTepkOh5xCmUlVGOe2kxh1yisKlpJpfTktiFydsKjgJJgXkDiWxFiSfIFFhMi8iOsnV3cQErhCisiTrSSQcBFugB
					isiksFZseyDGfJisibsJlfiLDAfpisijsQkDhPCxgAisilsWgAgACg]],
				Tail5 = [[
					gAjWjOQSgAgA73gmjWjLQZe+gm75hyjVimRcrklc5dhQkIimPGutln2IgblPikKNpciV1TgglsiVIChmio09iBlchVMGiqqM2uh2kpd7X8yxx5w6dojWd2l0
					6ZuiW/dKjUhRtqpxnBFtePj4iawlevjaE5ehlFiO06hjl5Ikejloh42ZqZnyNOe7liiH1ruPlsOLgOk4iu0smtf/IjhnjoirwFYLbZF4hnjUipt7Q+aBIMgU
					jVjKu3VvdEFxe6jWjCvhi0iPERfdjWjLvlkHhxEbgAjWjOvugAgAEJ]],
				["FinB1.L"] = [[
					e7hQhNqkUYgA73e7hQhNpjTidq7xe7hQhNpETLcn7qe7hwhNpISwdL7ffPibhbnCUUaL8WgFiwhnhPahV09zhNinhFhmn/XG9ohliDfpgc16Wg1RghhQeea1
					9sX0m7fBhQeuXl9dbNYJeZhmf4Wf4PflNaemiUgzWjyJgnHbe5iuhLYqv2lNFue7irhNawwQosGZe7iMhNYBukkpFEe7hbhNW6tAjMEae7hQhNW8s1jZEWe7
					hQhNW8s1jZEWe7hQhNWpsnixERe7hQhNV2r/g+EKe7hQhNVcrogAEJ]],
				["FinB2.L"] = [[
					eTgshtpmVOgA8jeOgzhtoqUddm8ceMg3htoNUJch8VeMhWhsoRTrdE8MeiiLiDmOVYaF87fviyiigjbyVw+AhoiYh7g5pLXf9bidhpftgF23XT0ng/g3dua7
					+KYrl2eqg3d6YF9Xb7W+djhPfjXM3rgEMYdvh5g+XZxYg4GleBighkZbu3ldFAeDishobYvKpAFueGh6hqY0tlk0EXeMhBhtXxsDjSDveMg3htXzr3jfDreM
					g3htXzr3jfDreNg1htXhrri1DmeRgvhtWyrGg/DeeTgshtWaqygADd]],
				["FinB1.R"] = [[
					hFhQhNqkrogA73hFhQhNpjseiW7xhFhQhNpEs1jZ7qhGhwhMpKtciy7ahVibg6oNyFkA4xhniwgGoD42mYxVhNine7o69oean/f0iDeZlH+KX+bNeihQfVhf
					4eWcN0eohQg2cztCW3EdfthmhmZ6gHYsBegpiUhfXPWocaC7hDiuhPYzQ3amFThFirhNawPwXUGZhFiMhNYBRcbXFEhFhbhNW6TAc0EahFhQhNW8TLcnEWhF
					hQhNW8TLcnEWhFhQhNWpTZdPERhFhQhNV2UBfCEKhFhQhNVcUYgAEJ]],
				["FinB2.R"] = [[
					htgshtpmqygA8jhygzhtoqrjia8ch0g3htoNr3jf8Vh2hWhroSshi48GiQiLhJndxLkS5liiiyfxnm4Gm6yXhoiYeFoh9bfHpLfdhpdmk8+jY2cSdqg3fKhv
					5VXQOneAg3hfdbuLXeEwfyhPifauhSY9BShOh5iJYIXoccCYh5ighrZkR3aYEnh9ishobYQ2XAFuh6h6hqY0SbbMEXh0hBhtXxT9cuDvh0g3htXzUJchDrh0
					g3htXzUJchDrhzg1htXhUVdLDmhvgvhtWyU6fBDehtgshtWaVOgADd]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAh2gAAFgAgAiIgAh2gOAFgAgAiIgAh2gXAFgAgAiIgAh2gVAFgAgEiIgAh2gQAGf/friIgAh2gLAIf6efiHgAh2gIAHf7euiHgAh7gHAGfofyiIgAiygEAX
					bzgciFgAkLgBCBVEgvh/gAlTgAFkOIhMhwgAkagAJhJWhghfgAjFgALeHkhohXgAjVgALfHjhohXgAjZgALfHjhohXgAjEgALfHjhohXgAjEgALfHjhohXgA
					jEgALfHjhohXgAjEgALfHjhohXgAjEgALfHjhohXgAjEgALfHjhohXgAjEgALfHjhohXgAjEgALfHjhohX]],
				Spine2 = [[
					gAh8fUAGgAgAiOgAh8fiAGgAgAiOgAh8frAGgAgAiOgAh8fpAGgAgEiOgBh8fkAGf/friOgEh8ffAIf5efiOgEh8fcAIf6eviOgBiBfbAGfofyiOf+i3fYAY
					bzgdiLf8kQfVCBVEgxiFf7lVfUFkOIhQh2f6kafUJiJWhlhkf6jEfULeHlhthbf6jUfULfHkhthbf6jYfULfHkhthbf6jDfULfHkhthbf6jDfULfHkhthbf6
					jDfULfHkhthbf6jDfULfHkhthbf6jDfULfHkhthbf6jDfULfHkhthbf6jDfULfHkhthbf6jDfULfHkhthb]],
				Spine3 = [[
					gAiCeoAYgAgAk0gAiCe2AhgAgAlpgAiCe/AogAgAmLgAiCe9AmgBgEmCgCiCe4Ajf8fslwgIiCezAhfvegldgHiCewAefzevlQgBiHevAcfnf0lNf8i9esAs
					b3gxlAf4kUepCVVGhLkxf1lXeoF8OJhpksf0kaeoJ+JZiEkvf0jDeoL+HpiQkxf0jTeoL/HoiQkxf0jXeoL/HoiQkxf0jCeoL/HoiQkxf0jCeoL/HoiQkxf0
					jCeoL/HoiQkxf0jCeoL/HoiQkxf0jCeoL/HoiQkxf0jCeoL/HoiQkxf0jCeoL/HoiQkxf0jCeoL/HoiQkx]],
				Spine4 = [[
					gAiPd9AYgAgAk0gAiReMArgAgAmegAiTeWA7gAgAnigAiSeTA2gBgEnQgDiSeOAvf8fsmtgMiReKApftehmGgKiQeGAjfxewltgBiVeEAhfmf1lnf4jKeCAv
					b2gvlRfxkfd/CZVCgslBfqlfd+GHOCgmlYfnkfd+KTJUgtmEfmjGd+MXHmg0mbfmjWd+MZHlg0mcfmjad+MZHlg0mcfmjFd+MZHlg0mcfmjFd+MZHlg0mcfm
					jFd+MZHlg0mcfmjFd+MZHlg0mcfmjFd+MZHlg0mcfmjFd+MZHlg0mcfmjFd+MZHlg0mcfmjFd+MZHlg0mc]],
				Head = [[
					gAicdT//gAgAgNgAijdj/zgAgAcggAindu/cgAgAaIf/imdr/jgAf5awgDikdm/ugAgpb/gQihdg/vf/jBdUgOigdc/1f/ijeNgCildb/8gXgeebf0jYdY/s
					kOfyfJfqksdU+Bq7hwfsfglrdU6SxtkFeqfZkpdV2J2KllcvfXjQdV0I3vmDbufXjfdV0G3wmEbtfXjkdV0G3wmEbtfXjPdV0G3wmEbtfXjPdV0G3wmEbtfX
					jPdV0G3wmEbtfXjPdV0G3wmEbtfXjPdV0G3wmEbtfXjPdV0G3wmEbtfXjPdV0G3wmEbtfXjPdV0G3wmEbt]],
				Jaw = [[
					gAiFbggAABgAgAgAinbugAADhXgAgAi9b7gAAGiOgAf/i3b3gCAFh/gHgIisbwf5AEhjfYgmifbtfoALhCdAggiXbofyAIgudegFibbmgVACgpfhf3jKbjkO
					ATgugBgDkibiqyCChsdigHl7bmxBFxiJZnf6lVbs0kJqhUWCfxkHbw1pLcgkUifxkWbw1qLdgkUhfxkbbw1qLdgkUhfxkGbw1qLdgkUhfxkGbw1qLdgkUhfx
					kGbw1qLdgkUhfxkGbw1qLdgkUhfxkGbw1qLdgkUhfxkGbw1qLdgkUhfxkGbw1qLdgkUhfxkGbw1qLdgkUh]],
				["FinF1.L"] = [[
					ephfeNrWN3gA3yephfebpkM3dv3rephfekoYMUcT3fephfeiosMgcq3leshfebpVMgdh3ce1hfeQqCL+eu2yezhfeOqcMYfN2/eshieSquNUfR3oexiFeStI
					PQia3wfNjCeOwwSun+2af1j6eNzkXWtVzsgYjEeN1Hcjx4vsgmh0eN1Zfmz7s/gmiEeN1Zfoz8s9gmiIeN1Zfoz8s9gmhzeN1Zfoz8s9gmhzeN1Zfoz8s9gm
					hzeN1Zfoz8s9gmhzeN1Zfoz8s9gmhzeN1Zfoz8s9gmhzeN1Zfoz8s9gmhzeN1Zfoz8s9gmhzeN1Zfoz8s9]],
				["FinF2.L"] = [[
					ddgveWnjUqgA88dVg+ekmcUAdQ80dShJetltTobf8ldShGerl5Txb88rdXhAejmUToc78pdig7eSmySyeL8Rdig3eRnBTJez8adcg3eanLUMfE81dwhGecoq
					Vqi982evhseYq6X3ps7RgFiheWsna2wO3+hRh+eWtZdg0u0NhwhBeWtkeu2eyPhwhReWtkev2fyOhwhVeWtkev2fyOhwhAeWtkev2fyOhwhAeWtkev2fyOhw
					hAeWtkev2fyOhwhAeWtkev2fyOhwhAeWtkev2fyOhwhAeWtkev2fyOhwhAeWtkev2fyOhwhAeWtkev2fyO]],
				["FinF1.R"] = [[
					hXhfeNrWyJgA3yhXhfebpkzJiR3rhXhfekoYzsjt3fhWhfehotzmjU3hhZhfeepSzBir31hhhfegp3xyiP4lhfhfebqWxvho4ehZhmeVqSylhc34hYiyeQoR
					z2jw3YhRkxeOkR0+oV2Rg2mbeNfQ1YtUztgWlxeNcZ1Fv1xwgIkeeNb71AwOxZgIkueNb71AwOxZgIkyeNb71AwOxZgIkdeNb71AwOxZgIkdeNb71AwOxZgI
					kdeNb71AwOxZgIkdeNb71AwOxZgIkdeNb71AwOxZgIkdeNb71AwOxZgIkdeNb71AwOxZgIkdeNb71AwOxZ]],
				["FinF2.R"] = [[
					ijgveWnjrWgA88irg+ekmcsAiw80iuhJetltsYkh8lithGeql6sVkC8oiuhAeqmQrzjN85iyg7eymlqfid9Zivg3erm6qjhx9Wiqg/efm5riht8/iwideZlo
					sjkn8giqk/eXjHtSqI7Hh/nQeWf6towN3+hPm3eWdZtY0X0kg9lneWcatJ11zAg9l3eWcatJ12y/g9l7eWcatJ12y/g9lmeWcatJ12y/g9lmeWcatJ12y/g9
					lmeWcatJ12y/g9lmeWcatJ12y/g9lmeWcatJ12y/g9lmeWcatJ12y/g9lmeWcatJ12y/g9lmeWcatJ12y/]],
				Tail1 = [[
					gAh2gAd8gAgA/7gAh2gOd8gAgA/7gAh2gXd8gAgA/7gAh2gVd8gGgA/7gAh2gQd8fef+/6gAh2gLd8dff2/0gAh2gId8d4f3/2gAh7gHd8flgV/6gAiygEd7
					f9kO/pgAkLgBeMe7q6+AgAlTgAe1eDx16egAkagAfldh2k2igAjFgAf9dW4V0mgAjVgAf9dW4W0lgAjZgAf9dW4W0lgAjEgAf9dW4W0lgAjEgAf9dW4W0lgA
					jEgAf9dW4W0lgAjEgAf9dW4W0lgAjEgAf9dW4W0lgAjEgAf9dW4W0lgAjEgAf9dW4W0lgAjEgAf9dW4W0l]],
				Tail2 = [[
					gAh9g6cCgAgA/vgAh9hIcCgAgA/vgAh9hRcCgAgA/vgAh9hPcCgJgB/vf+h9hKcDfQf7/vf3h9hEcEcffn/jf4h9hBcDdDfr/mf+iChBcDfZgT/vf/i5g/cC
					fwkO/df6kQg7cjd6qz91f4lTg6dycNxm6Wf4kUg6fRbL2P2ef6i+g6gAa2390kf6jNg6gBa23+0jf6jSg6gBa23+0jf6i9g6gBa23+0jf6i9g6gBa23+0jf6
					i9g6gBa23+0jf6i9g6gBa23+0jf6i9g6gBa23+0jf6i9g6gBa23+0jf6i9g6gBa23+0jf6i9g6gBa23+0j]],
				Tail3 = [[
					gAiMhzYqgAgA/IgAiMiBYqgAgA/IgAiMiKYqgAgA/IgBiMiHYqgLgC/If7iMiDYrfEf0/HfqiMh8YubjfH+0fuiMh5YtcQfQ+6f8iRh5YrfNgN/If8jHh3Ys
					fXkL+2fvkZh0ZhcZqd9TfolShybhZkw95+fqkKhyd6X11W2RfuivhxfGXS2+0dfui/hxfGXR2/0cfujEhxfGXR2/0cfuivhxfGXR2/0cfuivhxfGXR2/0cfu
					ivhxfGXR2/0cfuivhxfGXR2/0cfuivhxfGXR2/0cfuivhxfGXR2/0cfuivhxfGXR2/0cfuivhxfGXR2/0c]],
				Tail4 = [[
					gAiminUsgAgA97gAimi1UsgAgA97gAimi+UsgAgA97gBimi8UsgNgE97f4imi3Ute4fp96fbimiuU1aueW9dfhimisUzbken9mf5iriuUtfCgF96f2jhisUw
					e5kE9pfbkrioV6atp18OfMlSimYvWrvx5NfQj7ikcFUMzw13fXibijdvTa1N0PfXiqijdwTZ1O0OfXivijdwTZ1O0OfXiaijdwTZ1O0OfXiaijdwTZ1O0OfX
					iaijdwTZ1O0OfXiaijdwTZ1O0OfXiaijdwTZ1O0OfXiaijdwTZ1O0OfXiaijdwTZ1O0OfXiaijdwTZ1O0O]],
				Tail5 = [[
					gAjNjTRhgAgA8hgAjNjhRhgAgA8hgAjNjqRhgAgA8hgCjNjoRhgPgG8hf1jNjjRieufe8ffMjNjXRxZ+di75fUjNjWRta7d78Ff2jSjaRie3f78gftkHjYRm
					ehj88Pe+lFjUTDZTpF6/eklXjRWmUSuZ4TeqjrjNayROx61Ye0iBjLc2QRzLz9e0iRjLc3QRzLz8e0iVjLc3QRzLz8e0iAjLc3QRzLz8e0iAjLc3QRzLz8e0
					iAjLc3QRzLz8e0iAjLc3QRzLz8e0iAjLc3QRzLz8e0iAjLc3QRzLz8e0iAjLc3QRzLz8e0iAjLc3QRzLz8]],
				["FinB1.L"] = [[
					e7hPhNqkUYgA73e7hPhbpaTbdW7ve7hPhkooS4bq7ie7hPhio1TEcG7ne5hPhbpRTCdF7le0hPhRpxSVeZ7Le1hPhPqASwe+7Ve7hThTqLT0fI7wfIh7hSrs
					Vri17yfkjBhOt2YmpV6RgKkEhNvRcTvo3FgnjVhNvtgS08yYgyiHhNvgih3WvNgyiXhNvgii3YvLgyichNvgii3YvLgyiHhNvgii3YvLgyiHhNvgii3YvLgy
					iHhNvgii3YvLgyiHhNvgii3YvLgyiHhNvgii3YvLgyiHhNvgii3YvLgyiHhNvgii3YvLgyiHhNvgii3YvL]],
				["FinB2.L"] = [[
					eTgrhtpmVOgA8jeNg0h7oiUXdS8beKg5iEnzT3bj8NeLg4iCn/UDcA8SeKg1h7oaT+dA8QeFgyhto3TNeT75eIgwhrpFToe68CeQgyhypPUsfG8cephQhzqo
					Wbi58dfciNhuspZFpk66gdjShtt/cdwA3phQiyhtuafW0cz7hjhyhtuagq2Lx/hjiChtuagr2Mx+hjiGhtuagr2Mx+hjhxhtuagr2Mx+hjhxhtuagr2Mx+hj
					hxhtuagr2Mx+hjhxhtuagr2Mx+hjhxhtuagr2Mx+hjhxhtuagr2Mx+hjhxhtuagr2Mx+hjhxhtuagr2Mx+]],
				["FinB1.R"] = [[
					hFhPhNqkrogA73hFhPhbpasliq7vhFhPhkootIkW7ihFhPhho2tCj47khEhPhepOsbjH71g+hPhepkrCih8Wg/hPhap5rCh18ThFhWhVp4r/hq76hOifhQoj
					tUkb7dhOkahOl1umpw6Gg9mFhNiQvjvm3GgmlfhNgKvtyj0zgakQhNfzvtzA0YgakghNfzvtzA0YgakkhNfzvtzA0YgakPhNfzvtzA0YgakPhNfzvtzA0Yga
					kPhNfzvtzA0YgakPhNfzvtzA0YgakPhNfzvtzA0YgakPhNfzvtzA0YgakPhNfzvtzA0YgakPhNfzvtzA0Y]],
				["FinB2.R"] = [[
					htgrhtpmqygA8jhzg0h7oirpiu8bh2g5iEnzsJkd8Nh1g4iBoAsEj+8Qhxg1h/oWrejL8ghngyiCoqqGii8/hngwh9o+qHh188hwg3h2o9rFhs8lh/iJhwnu
					sVki8IiDkZhulNteqA6vhtmchth6uTv/3phOmChtfPua0G0ShAk1hteLuU1iyvhAlEhteKuU1jyvhAlJhteKuU1jyvhAk0hteKuU1jyvhAk0hteKuU1jyvhA
					k0hteKuU1jyvhAk0hteKuU1jyvhAk0hteKuU1jyvhAk0hteKuU1jyvhAk0hteKuU1jyvhAk0hteKuU1jyv]],
			},
		},
	},
}
