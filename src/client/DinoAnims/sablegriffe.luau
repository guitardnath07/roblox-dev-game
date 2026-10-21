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
					gAiYgfABgAgAgjgAijgfACgEgqgjgAiqgfACgHhEgjgAiqgfACgHhEgjgAijgfACgEgqgjgAiYgfABgAgAgjgAijgfACf8fWgjgAiqgfACf5e8gjgAiqgfAC
					f5e8gjgAijgfACf8fWgjgAiYgfABgAgAgjgAijgfACgEgqgjgAiqgfACgHhEgjgAiqgfACgHhEgjgAijgfACgEgqgjgAiYgfABgAgAgjgAijgfACf8fWgjgA
					imgfACf5e8gjgAiegfACf5e8gjgAiZgfACf8fWgjgAiYgfABgAgAgjgAiYgfAEgKhfgjgAiYgfAJgSiugjgAiYgfAGgOiHgjgAiYgfACgFgxgjgAiYgfABgA
					gAgjgAiYgfACf7fMgjgAiYgfAHfwdogjgAiYgfAIfvdZgjgAiYgfADf3evgjgAiYgfABgAgAgjgAiYgfACgEgqgjgAiYgfAEgLhogjgAiYgfAJgSirgjgAiY
					gfAFgNh6gjgAiYgfABgCgQgjgAiYgfACf8fWgjgAiZgfACf5e8gjgAiegfACf5e8gjgAihgfACf8fWgj]],
				Spine1 = [[
					gAiZgKAcgAgAlNf/ikgLAggLgplif/iqgLAjgShClvf/iqgLAjgShClvf/ikgLAggLgpligAiZgKAcgAgAlNgBikgLAgf1fXligBiqgLAjfue+lvgBiqgLAj
					fue+lvgBikgLAgf1fXligAiZgKAcgAgAlNf/ikgLAggLgplif/iqgLAjgShClvf/iqgLAjgShClvf/ikgLAggLgpligAiZgKAcgAgAlNgBikgLAgf1fXligB
					ingLAifue+lngBifgLAffve+lYgBiZgLAdf2fXlOgAiZgKAcgAgAlNf+iZgLAdgNgxlNf8iZgLAegVhTlNf9iZgLAegUhNlNf/iZgLAdgLgqlNgAiZgKAcgA
					gAlNgBiZgLAdf1fWlNgDiZgLAefsewlNgDiZgLAefreulNgCiZgLAdf0fRlNgAiZgKAcgAgAlNf/iZgLAdgKgplNf+iZgLAegShIlNf9iZgLAegVhTlNf+iZ
					gLAdgOg2lNgAiZgKAcgBgDlNgBiZgLAdf2fXlNgBiZgLAefve+lOgBifgLAffve+lYgBihgLAff1fXld]],
				Spine2 = [[
					gAimfjBdgAgApff+iyfkBqgRgnqGf8i5fkBzgcg+qff8i5fkBzgcg+qff+iyfkBqgRgnqGgAimfjBdgAgApfgCiyfkBqfvfZqGgEi5fkBzfkfCqfgEi5fkBz
					fkfCqfgCiyfkBqfvfZqGgAimfjBdgAgApff+iyfkBqgRgnqGf8i5fkBzgcg+qff8i5fkBzgcg+qff+iyfkBqgRgnqGgAimfjBdgAgApfgCiyfkBqfvfZqGgE
					i1fkBuflfCqQgEisfjBkfmfBpygCinfjBdfwfZpfgAimfjBdgAgApff8infjBdgCgGpff5infkBdf/f9pff6infkBdgJgVpff9imfjBdgOgipegAimfjBdgA
					gApfgDimfjBdfzffpegGinfkBdf8f2pfgHinfkBdgAf/pfgDimfjBdf6fypfgAimfjBdgAgApff+imfjBdgQgnpef7infjBdgQgopef5infkBdf/f+pff7in
					fjBdf8f1pfgAimfjBdf8f2pfgCimfjBdfwfZpegEinfjBefmfBpfgEisfjBkfmfBpygCivfjBnfvfZp+]],
				Neck1 = [[
					gAizfREvgAgAwuf9i/fSFGgaghxSf7jHfSFVgqg1xnf7jHfSFVgqg1xnf9i/fSFGgaghxSgAizfREvgAgAwugDi/fSFGfmffxSgFjHfSFVfWfLxngFjHfSFV
					fWfLxngDi/fSFGfmffxSgAizfREvgAgAwuf9i/fSFGgaghxSf7jHfSFVgqg1xnf7jHfSFVgqg1xnf9i/fSFGgaghxSgAizfREvgAgAwugDi/fSFGfmffxSgF
					jDfSFMfWfKxbgFi5fRE7fXfKxAgDizfREwfnfewvgAizfREvgAgAwuf8izfREvgEgFwuf5izfREvf+f9wuf6izfREvgOgSwuf9izfREvgWgewugAizfREvgA
					gAwugDizfREvfrfkwugGizfREvf5f3wugHizfREvf/f/wugEizfREvf3f0wugAizfREvgAgAwuf9izfREwgZgiwuf6izfREwgagjwuf5izfREvf/f/wuf8iz
					fREvf5f3wugAizfREvf6f4wugDizfREwfnfewugFizfREwfYfJwugFi5fRE7fXfKxAgDi9fSFBfmffxK]],
				Neck2 = [[
					gAjYe+G0gAgAzuf8jlfAHPgdge0Pf6jtfCHggwgw0if6jtfCHggwgw0if8jlfAHPgdge0PgAjYe+G0gAgAzugEjlfAHPfjfi0PgGjtfCHgfQfQ0igGjtfCHg
					fQfQ0igEjlfAHPfjfi0PgAjYe+G0gAgAzuf8jlfAHPgdge0Pf6jtfCHggwgw0if6jtfCHggwgw0if8jlfAHPgdge0PgAjYe+G0gAgAzugEjlfAHPfjfi0PgG
					jpfBHWfQfQ0WgGjfe/HCfRfPz+gEjYe+G1fjfhzugAjYe+G0gAgAzuf8jYe+G0gEgFzuf5jYe+G0f+f9zuf6jYe+G0gQgRzuf8jYe+G1gZgbzugAjYe+G0gA
					gAzugEjYe+G1fofmzugGjYe+G0f4f4zugHjYe+G0f/f/zugEjYe+G0f1f1zugAjYe+G0gAgAzuf8jYe+G1gdgfzuf6jYe+G1geggzuf5jYe+G0f/f/zuf8jY
					e+G0f4f4zugAjYe+G0f5f4zugEjYe+G1fjfhzugGjYe+G2fSfOzugGjfe/HCfRfPz+gEjifAHJfjfi0H]],
				Head = [[
					gAj7e1AGgAgAiMf8kJe5ANgIgpjVf6kRe8ASgOhCkCf6kRe8ASgOhCkCf8kJe5ANgIgpjVgAj7e1AGgAgAiMgEkJe5ANf4fXjVgGkRe8ASfye+kCgGkRe8AS
					fye+kCgEkJe5ANf4fXjVgAj7e1AGgAgAiMf8kJe5ANgIgpjVf6kRe8ASgOhCkCf6kRe8ASgOhCkCf8kJe5ANgIgpjVgAj7e1AGgAgAiMgEkJe5ANf4fXjVgG
					kMe6APfye9jogGkCe3AKf0e9iwgEj8e1AGf5fXiMgAj7e1AGgAgAiMf8j8e1AGf/faiMf5j8e2AIf7ejiLf5j8e2AGgBffiLf8j7e1AGgFgfiMgAj7e1AGgA
					gAiMgEj7e1AGf7fmiMgHj8e2AHgCg8iLgHj8e2AHgEhSiLgEj7e1AGf/gSiMgAj7e1AGgAgAiMf8j7e1AGgHgpiMf6j8e2AGgFgMiLf5j8e2AIf7eniLf8j8
					e1AHf7eyiLgAj7e1AGf+fpiMgEj7e1AGf5fXiMgGj8e2AHf1e9iNgGkCe3AKf0e9iwgEkGe4ALf4fXjE]],
				Jaw = [[
					gAj+d//PgAgAm5f6kQeD/VgFfWmaf2kaeG/YgHe8mHf2kaeG/YgHe8mHf6kQeD/VgFfWmagAj+d//PgAgAm5gGkQeD/Vf7gqmagKkaeG/Yf5hEmHgKkaeG/Y
					f5hEmHgGkQeD/Vf7gqmagAj+d//PgAgAm5f6kQeD/VgFfWmaf2kaeG/YgHe8mHf2kaeG/YgHe8mHf6kQeD/VgFfWmagAj+d//PgAgAm5gGkQeD/Vf7gqmagK
					kUeE/Wf5hEmSgKkHeB/Rf4hDmpgGj+d//Pf7gqm4gAj+d//PgAgAm5f+j+d//Cf1glntf+j+d/+zfmhZogf7j+d/+/f1ggn6f6j+d//NgEfhnAgAj+d//PgA
					gAm5gFj+d//Nf9gbnDgDj+d/+6gRfHoLgCj+d/+1gXexoZgDj+d//GgGfvnggAj+d//PgAgAm5f6j+d//PgFfWm5f5j+d//Hf/fzndf+j+d/+0fnhVoegAj+
					d/+7fshMoHgBj+d//Lf7gXnIgGj+d//Pf7gqm5gKj/d//Of3hDm4gKkHeB/Rf4hDmpgGkMeC/Uf7gqmh]],
				["UpperArm.L"] = [[
					fPite/zQMuQrmxfMi7fCzRNyPHl6fJjDfDzNOdOLlWfJjDfDzNOdOLlWfMi7fCzRNyPHl6fPite/zQMuQrmxfTi6e+0ANoP7lOfWjCe90cOQPhkSfWjCe90c
					OQPhkSfTi6e+0ANoP7lOfPite/zQMuQrmxfMi7fCzRNyPHl6fJjDfDzNOdOLlWfJjDfDzNOdOLlWfMi7fCzRNyPHl6fPite/zQMuQrmxfTi6e+0ANoP7lOfW
					i+e90UN3P6ktfWi0e80BNEQwlmfTite9zmMoREmZfPite/zQMuQrmxfLiue/2sPbRAi5fJiue/5HR6SNeJfJiufA3SQFRCh3fMiufBzeNLQUmnfPite/zQMu
					QrmxfTite9zjMpRBmdfWite/zWMsQymrfWiue/zRMuQsmwfTite+zYMsQ1mofPite/zQMuQrmxfMiufBy6M1QRnIfJiufB1bOpQakgfJiue/5BRzSHeafLit
					e/4KQtRrggfPite/0eNgQ1lofTite9zmMoRFmZfWite8z0MlRUmKfWi0e80BNEQwlmfTi3e+z7NZQMlf]],
				["LowerArm.L"] = [[
					evi6euG+pCjUxcerjJezINpPkUyyeojTe3JBpYk5zkeojTe3JBpYk5zkerjJezINpPkUyyevi6euG+pCjUxce0jJetIAoYjazIe2jSesIsn7jf0He2jSesIs
					n7jf0He0jJetIAoYjazIevi6euG+pCjUxcerjJezINpPkUyyeojTe3JBpYk5zkeojTe3JBpYk5zkerjJezINpPkUyyevi6euG+pCjUxce0jJetIAoYjazIe3
					jMerIQoCjRzme3jBeqHZoQi1yfe0i6eqG6ooi1xpevi6euG+pCjUxceui7eqH2k4i30MexjAenJXhCg32jesi8erINkCir00eri6ewHIo0jwxsevi6euG+pC
					jUxce0i6erG6osi6xme2i6etG9o7jLxge2i6euG+pBjTxde0i6etG9o4jIxhevi6euG+pCjUxceri6exHEpcjyxReqi7evHlmijlzQewi/eoJRhOhA2dexi9
					eoIgiuh41dewi6esHInqjMyVe0i6eqG5ooi1xoe3i6epG4oYiixwe3jBeqHZoQi1yfe0jFesHwocjSyz]],
				["UpperArm.R"] = [[
					gxite/zQzSvVmxgti6e+0AyYwFlOgqjCe90cxwwfkSgqjCe90cxwwfkSgti6e+0AyYwFlOgxite/zQzSvVmxg0i7fCzRyOw5l6g3jDfDzNxjx1lWg3jDfDzN
					xjx1lWg0i7fCzRyOw5l6gxite/zQzSvVmxgti6e+0AyYwFlOgqjCe90cxwwfkSgqjCe90cxwwfkSgti6e+0AyYwFlOgxite/zQzSvVmxg0i7fCzRyOw5l6g3
					i+fDzGx6xclzg3i0fDy3ypwkmwg0iufBy6zKvvnIgxite/zQzSvVmxgtite/zTzTvRmtgqiufAzOzRvXmzgqite+zczVvHmkgtite9zkzXu+mcgxite/zQzS
					vVmxg0iufBztysvqmZg3iufA4MvGuggQg3iufA41uauCe2g1iufA10xQvRkEgxite/zQzSvVmxgtite9zmzYu7mZgqite9znzYu6mZgqiufAzPzRvWmygsiu
					fAzKzQvcm3gxiufAzLzQvbm3g0iufBy6zLvvnIg3iufCyszFwAnVg3i0fDy3ypwkmwg0i4fCzMycwpmM]],
				["LowerArm.R"] = [[
					hRi6euG+W+csxchMjJetIAXocmzIhKjSesIsYFch0HhKjSesIsYFch0HhMjJetIAXocmzIhRi6euG+W+csxchVjJezINWxbsyyhYjTe3JBWobHzkhYjTe3JB
					WobHzkhVjJezINWxbsyyhRi6euG+W+csxchMjJetIAXocmzIhKjSesIsYFch0HhKjSesIsYFch0HhMjJetIAXocmzIhRi6euG+W+csxchVjJezINWxbsyyhY
					jNe2IlWjbSzDhYjCe0HsWabqx6hVi6exHFWlcNxShRi6euG+W+csxchNi6etG+XCcxxehKi6euG/W8cqxchKi6esG8XMc9xjhMi6erG6XVdIxmhRi6euG+W+
					csxchVi6ewHKXdcSx3hSi+epIqdWeD1ohQi/eoJIedex2RhTi7esHkZ+cxzehRi6euG+W+csxchMi6eqG5XYdLxohKi6eqG5XZdMxohKi6euG/W9crxchNi6
					evHAW3ckxZhRi6euHAW4clxahVi6exHEWkcOxRhYi7ezHJWVb6xLhYjCe0HsWabqx6hVjGezH8Wubzyc]],
				Tail1 = [[
					gAibg8ePgAgA/8gBimg8fOh1f9/7gCisg8f1i+f9/2gCisg8f1i+f9/2gBimg8fOh1f9/7gAibg8ePgAgA/8f/img8fOeLgD/7f+isg8f1dCgD/2f+isg8f1
					dCgD/2f/img8fOeLgD/7gAibg8ePgAgA/8gBimg8fOh1f9/7gCisg8f1i+f9/2gCisg8f1i+f9/2gBimg8fOh1f9/7gAibg8ePgAgA/8f/img8fOeLgD/7f+
					iog8ffdCgE/2f+igg8evdCgF/1f/ibg8eQeLgE/5gAibg8ePgAgA/8gDibg8ePirf7/1gFibg8eQkof3/mgEibg8eQkBf4/sgBibg8ePh9f8/4gAibg8ePgA
					gA/8f/ibg8ePeAgE/4f8ibg8eQbugJ/pf7ibg8eQbfgJ/nf+ibg8ePdjgF/2gAibg8ePgAgA/8gBibg8ePh1f8/5gDibg8eQjjf5/vgFibg8eQkmf3/ngDib
					g8ePjGf6/ygAibg8ePgQf//8f/ibg8ePeLgE/5f+ibg8eQdCgG/zf+igg8evdCgF/1f/ijg8fAeLgD/7]],
				Tail2 = [[
					gAighqdRe3gA/2gGiohqfPh5f9/7gKithpgdkLgB/tgKithpgek3gF/ngGiohqfPjugF/xgAighqdRhJgA/2f6iohqfPeHgD/7f2ithpgdb1f//tf2ithpge
					bJf7/nf6iohqfPcSf7/xgAighqdRe3gA/2gGiohqfPh5f9/7gKithpgdkLgB/tgKithpgek3gF/ngGiohqfPjugF/xgAighqdRhJgA/2f6iohqfPeHgD/7f2
					iqhpfwb1gA/tf2ikhpeRbIf//kf6ighpdTcSgA/qgAighqdRe3gA/2gKighpdRiugA/wgSighndTl2f//VgPighodUl7f//UgHighpdSj1gA/pgAighqdRhJ
					gA/2f5ighpdRd9gA/zfvighodTaggB/ZfuighodUZlgB/Of3ighpdSbqgA/lgAighqdRe3gA/2gGighpdRh5gA/0gNighodSkwgA/hgSighndUmff//NgMig
					hpdTk+gA/fgBighqdRhZgA/2f6ighpdReHgA/0f2ighpdUb0gA/mf2ikhpeRbIf//kf6imhqezcSf9/w]],
				Tail3 = [[
					f9ioiXcMc/f6/ngMiqiXfHgzf1/+gWiriWg9kRf+/sgYiriVg/mGgP/ZgRiqiWfKlogV/egDioiXcMjBgG/nf0iqiXfHfNgL/+fqiriWg9bvgC/sfoiriVg/
					Z6fx/ZfviqiWfKaYfr/ef9ioiXcMc/f6/ngMiqiXfHgzf1/+gWiriWg9kRf+/sgYiriVg/mGgP/ZgRiqiWfKlogV/egDioiXcMjBgG/nf0iqiXfHfNgL/+fq
					iriWf5bugA/tfoipiVdtZ5fz/UfvioiVcQaXf0/Rf9ioiXcMc/f6/ngSioiWcLhogD/ugiiniScPl8gM/NgginiScRnKgP+9gSioiVcPlwgM/PgDioiXcMjB
					gG/nfzioiWcLfDf+/vfginiScPaaf0/RfciniRcSYXfw+1fqioiVcQZwfz/Jf9ioiXcMc/f6/ngMioiWcLgzgC/wgbioiUcOk3gK/ZgkiniRcSnugQ+0gaio
					iUcRm4gO/BgFioiXcMjQgH/mf0ioiWcLfNf+/wfqioiVcQbuf3/efoipiVdtZ5fz/UfviqiWegaYft/d]],
				Tail4 = [[
					f0izjDbAbEfp/NgOitjFe1e+ff/8giipjChRjRfp/zgpipi/hVmPgN/WghitjBe8m4go/OgMizjDbAk8gX/NfyitjFe1hCgh/8feipjChRcvgX/zfXipi/hV
					Zxfz/WffitjBe8ZIfY/Of0izjDbAbEfp/NgOitjFe1e+ff/8giipjChRjRfp/zgpipi/hVmPgN/WghitjBe8m4go/OgMizjDbAk8gX/NfyitjFe1hCgh/8fe
					irjCf3cwgP/0fXivi/c+Zwfo/Offiyi/bGZGfg+2f0izjDbAbEfp/NgXizjCa8fxf//lgziyi7a/k5gW/Ng0iyi6bEnSgi+wgiiyi/bEnBgg+0gMizjDbAk8
					gX/NfwizjDa8g6gE/kfQiyi8a/bdfr/RfHiyi5bFYOfc+ofZiyi+bFYgfd+sf0izjDbAbEfp/NgOizjDa8e8f7/kgoiyi+a+jzgS/Xg5iyi4bGn2gk+ngtiy
					i8bGoIgl+jgOizjCbAlLgY/KfyizjDa8hEgF/kfeiyjAbBcxfy/bfXivi/c+Zwfo/OffiujBeFZIfa/L]],
				Tail5 = [[
					fnjBjsZdZyfP+rgLiwjzeLdGe7/ygsiljvhJhje//6g7iljqhPlUf2/hg0iwjreUnDg0/JgZjBjsZdmOgx+rf1iwjzeLi6hF/yfUiljvhJedhB/6fFiljqhP
					asgK/hfMiwjreUY9fM/JfnjBjsZdZyfP+rgLiwjzeLdGe7/ygsiljvhJhje//6g7iljqhPlUf2/hg0iwjreUnDg0/JgZjBjsZdmOgx+rf1iwjzeLi6hF/yfU
					irjvfZefgx/8fFi4job0avfm/RfMjAjnZjY8fI+gfnjBjsZdZyfP+rgWjBjuZWd1fv/NhBjAjlZXjDgY/JhIjAjhZemRgx+rg1jAjmZgnLg5+egZjBjsZdmO
					gx+rfzjBjuZXi2gW/KfEjAjmZXdTfr/LeyjAjfZfZPfL+kfFjAjlZiYWfE+XfnjBjsZdZyfP+rgLjBjuZXdAfo/JgzjBjpZWh+gQ/OhPjAjfZfm1g2+jhDjA
					jiZkoRhB+NgdjBjsZemdgz+of1jBjuZXjAgY/JfVjAjqZaenf2/RfFi4job0avfm/RfMi0jqdPY9fL/E]],
				["UpperLeg.L"] = [[
					fHhkgQ80czfrthfHhvgS9DdIfDtEfGh2gT9LdVeqsyfGh2gT9LdVeqsyfHhvgS9DdIfDtEfHhkgQ80czfrthfIhvgN8jcdgUt/fJh1gM8XcQgsuSfJh1gM8X
					cQgsuSfIhvgN8jcdgUt/fHhkgQ80czfrthfHhvgS9DdIfDtEfGh2gT9LdVeqsyfGh2gT9LdVeqsyfHhvgS9DdIfDtEfHhkgQ80czfrthfIhvgN8jcdgUt/fJ
					hxgM8XcQgsuSfJhpgM8XcQgsuSfIhkgN8jcdgUt/fHhkgQ80czfrthfGhlgV9SdiePsgfFhlga9jeLdCrvfFhlgX9cd2dosHfGhlgS9FdLe8s/fHhkgQ80cz
					frthfIhkgN8ecYgduHfLhkgH7rblh8vTfLhkgH7ibdiJvffJhkgL8RcJg5udfHhkgQ80czfrthfHhkgS9DdIfDtEfGhlgW9VdneGsafFhlgZ9jeJdErxfFhl
					gW9Zdwd1sPfHhkgQ86c6fctWfIhkgN8jcdgUt/fJhkgM8XcQgsuSfJhpgM8XcQgsuSfIhsgN8jcdgUt/]],
				["LowerLeg.L"] = [[
					fDhCfzrOg5gI98fBhOf0rxhpgB9tfAhVf1sHiGf99ifAhVf1sHiGf99ifBhOf0rxhpgB9tfDhCfzrOg5gI98fFhMfyqsgKgP+JfGhRfxqYfugT+QfGhRfxqY
					fugT+QfFhMfyqsgKgP+JfDhCfzrOg5gI98fBhOf0rxhpgB9tfAhVf1sHiGf99ifAhVf1sHiGf99ifBhOf0rxhpgB9tfDhCfzrOg5gI98fFhMfyqsgKgP+JfG
					hOfxqYfugT+QfGhFfxqYfugT+QfFhBfyqsgKgP+JfDhCfzrOg5gI98e+hFf2seilf59We7hHf5tjkAfs8te9hGf4tBjTfy9CfAhEf0r3hxgA9qfDhCfzrOg5
					gI98fFhBfxqkf/gQ+MfKg+fvpXeRgh+ifKg9fvpMeBgk+kfGhAfxqNffgV+UfDhCfzrOg5gI98fBhDf0rxhpgB9te+hFf2sniwf39Re7hHf5thj9fs8ue9hG
					f3s1jEf09JfChDfzrbhLgG92fFhBfyqsgKgP+JfGhAfxqYfugT+QfGhFfxqYfugT+QfFhJfyqsgKgP+J]],
				["Foot.L"] = [[
					fFgjgW8ngLf7uTfFgugW8mgyfnuTfFg0gW8lhLfbuTfFg0gW8lhLfbuTfFgugW8mgyfnuTfFgjgW8ngLf7uTfFgugW8nfjgOuTfFg0gW8mfLgauTfFg0gW8m
					fLgauTfFgugW8nfjgOuTfFgjgW8ngLf7uTfFgugW8mgyfnuTfFg0gW8lhLfbuTfFg0gW8lhLfbuTfFgugW8mgyfnuTfFgjgW8ngLf7uTfFgugW8nfjgOuTfF
					gxgW8mfLgauTfFgogW8mfLgauTfFgjgW8nfjgOuTfFgjgW8ngLf7uTfFgjgW8khlfOuSfFgjgW8eixeouPfFgjgW8iiLe7uRfFgjgW8mg5fkuTfFgjgW8ngL
					f7uTfFgjgW8mfagTuTfFgjgW8id+hBuRfFgjgW8hdwhIuRfFgjgW8me/ghuTfFgjgW8ngLf7uTfFgjgW8mgyfnuTfFgjgW8khufJuSfFgjgW8fiuepuPfFgj
					gW8jh+fBuRfFgjgW8ngZfzuTfFgjgW8nfjgOuTfFgjgW8mfLgauTfFgogW8mfLgauTfFgrgW8nfjgOuT]],
				["Toe.L"] = [[
					fFgTgK/9gIf3hgfFgegK/8gkfVhgfFgkgK/7g1fAhgfFgkgK/7g1fAhgfFgegK/8gkfVhgfFgTgK/9gIf3hgfFgegK/9fsgZhgfFgkgK/8fbgthgfFgkgK/8
					fbgthgfFgegK/9fsgZhgfFgTgK/9gIf3hgfFgegK/8gkfVhgfFgkgK/7g1fAhgfFgkgK/7g1fAhgfFgegK/8gkfVhgfFgTgK/9gIf3hgfFgegK/9fsgZhgfF
					gggK/8fbgthgfFgYgK/8fbgthgfFgTgK/9fsgZhgfFgTgK/9gIf3hgfFgTgK/6hIephffFgTgK/zh+dnhffFgTgK/3hjeIhffFgTgK/8gpfPhgfFgTgK/9gI
					f3hgfFgTgK/8flghhgfFgTgK/4ejhwhffFgTgK/2eah8hffFgTgK/7fRg4hgfFgTgK/9gIf3hgfFgTgK/8gkfVhgfFgTgK/5hOehhffFgTgK/zh8dqhffFgT
					gK/4haeThffFgTgK/9gSfqhgfFgTgK/9fsgZhgfFgTgK/8fbgthgfFgYgK/8fbgthgfFgbgK/9fsgZhg]],
				["UpperLeg.R"] = [[
					g5hkgQ80jNgVthg4hvgN8jjjfst/g3h1gM8XjwfUuSg3h1gM8XjwfUuSg4hvgN8jjjfst/g5hkgQ80jNgVthg5hvgS9Di4g9tEg6h2gT9LirhWsyg6h2gT9L
					irhWsyg5hvgS9Di4g9tEg5hkgQ80jNgVthg4hvgN8jjjfst/g3h1gM8XjwfUuSg3h1gM8XjwfUuSg4hvgN8jjjfst/g5hkgQ80jNgVthg5hvgS9Di4g9tEg6
					hygT9LirhWsyg6hqgT9LirhWsyg5hlgS9Di4g9tEg5hkgQ80jNgVthg3hkgK8Kj+e6ung0hjgG7ekmdwvkg2hkgI71kSeUvFg4hkgN8gjmfmuFg5hkgQ80jN
					gVthg6hlgT9GizhHs9g7hlgY9fiBipr8g7hlgZ9ih5i3rzg6hlgU9Pilhkspg5hkgQ80jNgVthg4hkgN8jjjfst/g2hkgK8FkCexuug0hjgG7gkldyvig2hk
					gJ78kLehu8g4hkgP8ujVgGtsg5hkgS9Di4g9tEg6hlgT9LirhWsyg6hqgT9LirhWsyg5htgS9Di4g9tE]],
				["LowerLeg.R"] = [[
					g9hCfzrOfHf498g7hMfyqsf2fx+Jg6hRfxqYgSft+Qg6hRfxqYgSft+Qg7hMfyqsf2fx+Jg9hCfzrOfHf498g/hOf0rxeXf/9thAhVf1sHd6gD9ihAhVf1sH
					d6gD9ig/hOf0rxeXf/9tg9hCfzrOfHf498g7hMfyqsf2fx+Jg6hRfxqYgSft+Qg6hRfxqYgSft+Qg7hMfyqsf2fx+Jg9hCfzrOfHf498g/hOf0rxeXf/9thA
					hSf1sHd6gD9ihAhJf1sHd6gD9ig/hDf0rxeXf/9tg9hCfzrOfHf498g5g/fwqCgxfp+Xg1g9fvpHiGfb+lg3g+fwpkhcfi+fg7hBfxqmf9fw+Lg9hCfzrOfH
					f498hAhEf0r6eMgA9ohEhHf4tQcZgR85hFhHf5tdcIgT8xhBhFf1sTdqgF9cg9hCfzrOfHf498g7hBfyqsf2fx+Jg4g/fwp7g7fn+Zg1g9fvpJiDfb+lg4g+
					fwpuhOfk+dg9hCfyrBfYf1+Bg/hDf0rxeXf/9thAhEf1sHd6gD9ihAhJf1sHd6gD9ig/hMf0rxeXf/9t]],
				["Foot.R"] = [[
					g7gjgW8nf1gFuTg7gugW8ngdfyuTg7g0gW8mg1fmuTg7g0gW8mg1fmuTg7gugW8ngdfyuTg7gjgW8nf1gFuTg7gugW8mfOgZuTg7g0gW8le1gluTg7g0gW8l
					e1gluTg7gugW8mfOgZuTg7gjgW8nf1gFuTg7gugW8ngdfyuTg7g0gW8mg1fmuTg7g0gW8mg1fmuTg7gugW8ngdfyuTg7gjgW8nf1gFuTg7gugW8mfOgZuTg7
					gxgW8le1gluTg7gogW8le1gluTg7gjgW8mfOgZuTg7gjgW8nf1gFuTg7gjgW8lhOfZuTg7gjgW8hiWe1uQg7gjgW8jhyfHuSg7gjgW8ngjfuuTg7gjgW8nf1
					gFuTg7gjgW8mfEgeuTg7gjgW8gdkhOuQg7gjgW8fdWhVuPg7gjgW8leogsuSg7gjgW8nf1gFuTg7gjgW8ngdfyuTg7gjgW8lhXfVuSg7gjgW8hiUe2uQg7gj
					gW8khmfNuSg7gjgW8ngEf+uTg7gjgW8mfOgZuTg7gjgW8le1gluTg7gogW8le1gluTg7grgW8mfOgZuT]],
				["Toe.R"] = [[
					g7gTgK/9f4gJhgg7gegK/9gUfnhgg7gkgK/8glfThgg7gkgK/8glfThgg7gegK/9gUfnhgg7gTgK/9f4gJhgg7gegK/8fcgrhgg7gkgK/7fLhAhgg7gkgK/7
					fLhAhgg7gegK/8fcgrhgg7gTgK/9f4gJhgg7gegK/9gUfnhgg7gkgK/8glfThgg7gkgK/8glfThgg7gegK/9gUfnhgg7gTgK/9f4gJhgg7gegK/8fcgrhgg7
					gggK/7fLhAhgg7gYgK/7fLhAhgg7gTgK/8fcgrhgg7gTgK/9f4gJhgg7gTgK/7g4e9hgg7gTgK/2hrd/hfg7gTgK/5hRedhfg7gTgK/8gZfihgg7gTgK/9f4
					gJhgg7gTgK/8fVg0hgg7gTgK/1eRiGhfg7gTgK/0eHiThfg7gTgK/6fChMhgg7gTgK/9f4gJhgg7gTgK/9gUfnhgg7gTgK/6g+e1hgg7gTgK/2hpeBhfg7gT
					gK/6hJeohfg7gTgK/9gDf8hgg7gTgK/8fcgrhgg7gTgK/7fLhAhgg7gYgK/7fLhAhgg7gbgK/8fcgrhg]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAiQgf/+hHf3gBgAiTgf/9g6e+gDgAiYgf/8gieRgDgAidgf/6gFd3gCgAiegf/6fnd0gAgAibgf/7fOeKf/gAiVgf/8e8e0f+gAiRgf/+e3frgAgAiRgf/+
					e+gmgCgAiVgf/8fRhagDgAibgf/7fsh/gDgAiegf/6gKiOgBgAidgf/6gmiEf/gAiYgf/8g8hkf+gAiTgf/9hIgyf/]],
				Spine1 = [[
					gAiQgKAUe7gSkPf/iTgLAVfKg0kXf+iYgLAZfkhNkrf9idgLAcgChYk+f9iegLAdgghTlEf+ibgLAbg3hBk4f+iVgLAXhFgkkjgAiRgKAVhIgAkSgBiRgKAV
					g/fckRgCiVgLAXgqe+kggDibgLAagNesk2gDiegLAdfveplDgDidgLAcfTe0lAgCiYgLAZfAfNkugBiTgKAWe4fukZ]],
				Spine2 = [[
					f/ibfiBGe+gaoIf8iefjBKfJgmoZf6ikfjBVffgrpBf6iqfjBff7goplf6irfjBigXgdpuf7iofjBbgugNpWf9ihfjBPg9f9otgAicfjBHhDftoNgDicfjBH
					g+ffoNgFihfjBPgtfWosgGinfjBbgUfVpVgGirfjBif3fdpugFiqfjBgfdfrpmgEikfjBVfJf7pCgBiefjBKe+gLoa]],
				Neck1 = [[
					f+imfPDufFgpu5f7ipfPDifSgxuif5iwfQEBfpgxvef5i3fRE9gFgoxEf6i4fRFugegVyOf7i0fRFvgwf/yPf+itfQE/g6fsxHgBinfPEDg9fdvhgEinfPDi
					g2fTuigGisfQDsgkfOu3gHi0fREdgJfSwQgHi4fRFZftfhxwgGi3fRF2fYf2yZgDixfQFcfKgLxygBipfPEgfEgcwT]],
				Neck2 = [[
					f7jIe4F+fLgwyjf5jLe3F/fZg3ymf3jTe6Gdfwg0zOf4jce/HEgKgn0Bf6jffDHbgggS0df8jbfCHRgvf70RgAjSe+Gtg4fmzjgDjKe5GJg4fWyygGjIe3F7
					gvfLyfgIjOe4GLgcfJy2gJjYe9GxgDfRzpgIjffBHTfqfj0UgFjefDHafXf60cgCjXfAHBfMgQz9f/jOe7GZfHgizJ]],
				Head = [[
					f5jresAFe6gMhsf2jterAGfAf2h5f1j2ewAHfTfhiSf3kAe3AIfvfRimf6kDe8AJgNfIipf+j/e7AIgmfKiYgCj1e1AGg5fWh+gGjteuAFhFfphugJjrerAF
					hFf/hwgLjxetAGg4gViFgKj7e0AIgggoiegIkCe6AJgCg1iqgEkCe8AIfmg4iigAj6e4AHfPgxiLf8jxexAGfAgih0]],
				Jaw = [[
					f4jsd1/1hHf+i9f3jvd1/2g+gTiwf3j5d6/4goglidf5kEeB/3gJgxivf9kHeG/2fqg1i1gBkCeE/3fSgvitgEj3d+/3fBgiirgHjud3/1e5gNi8gJjsd0/1
					e8f3i5gJjzd3/3fMfjilgIj/d9/4fnfUingFkHeE/2gHfMi0gBkGeG/2gjfNizf+j9eC/3g3fWikf7jyd7/2hEfoi2]],
				["UpperArm.L"] = [[
					fOice+wIOgl20kfLife/wmOelM0VfJiofAxxOJjqzYfIiwfBzHNthsx5fIi0fB0ONSf2wPfKiwfA07M8eiu1fNipe/1SMrd1t3fQije+1bMfdntVfTije91c
					MadztNfWioe91WMceUtffXive91BMmfQuSfXize+0UM2gpvmfWiwe+zKNOiZxRfUioe+xwNtkJy4fRife+wkONlc0E]],
				["LowerArm.L"] = [[
					e6h7e6+/hHgJn5e2h/e6/ahCf2l7eziJe3/5gufjiRexiUez/6gOfbd3exibeu/YftfhZzeyibeq+qfSfyW5e1iWen+LfDgHVbe4iRel+Ge+gZVPe8iRek+a
					fEgkWKe/iVek+9fSgpYBfBiaem/jfngoayfBiaep/8gAgkeVfBiUeu/6gZghiNe/iJez/egugdlpe9h/e4/Bg/gWnv]],
				["UpperArm.R"] = [[
					gviie91czkiWtOgsile91azmiAtSgqise91OzghSt0gpiye+0uzTgHu4gpiye+zyy/ehwagrise+ydyjctyHguije+xGyCbIzjgxide+wPxnaP0ag0ide/wQ
					xeaW0jg2ijfAxIxqbfz8g4isfBycyFdUysg4izfBztyhfSxEg3izfB0oy6g5vfg1itfA1JzNh5uSgyime+1YzciVtj]],
				["LowerArm.R"] = [[
					hGiQekByfAgfqchDiTekBVfKgnpChAiYelAvfcgpmtg/ibeoAOfzgmjhg/iYesABgNgifvhAiPexASgkgfb+hCiDe2Ayg3gaZGhFh8e5BFhEgRX7hIh8e6A2
					hHgAY2hLiDe5AUg6fsbvhOiPe1ACgffdf7hPiYewAUf9fckShOicesBAfefpn1hMiZepBpfJf8qBhJiTemB7fAgQq1]],
				Tail1 = [[
					gAiUg8c/hBhG/0gCiWg8cQgzhB/vgDicg8cAgegw/ugEihg8cbgEgW/ygEiig8dOfpf5/3gDieg8d3fQff/6gCiZg8d8fAfK/5gBiUg8dZe8e9/2f/iVg8cl
					fFe7/xf+iZg8cDfXfG/uf9ifg8cJfvfc/wf8iig8czgKf4/1f8ihg8dmgkgU/5f9icg8d/g5gs/6f+iWg8duhEg+/4]],
				Tail2 = [[
					gDidhpb3i9hD/kgEihhpaXh0hB/bgEinhoZhgYgy/UgEirhpZ4e7gX/YgDiqhpbNdpf4/igBikhpcocufe/ogAifhpdNcXfM/pf+ichpcicqfA/nf9iehpbF
					dke8/gf8ikhoZze5fE/Wf8iqhoZigXfa/Uf8irhpaehwf5/df+inhpb+i4gW/mf/ihhpdEjigs/pgBidhpdBjkg6/o]],
				Tail3 = [[
					gLipiVbAlehE/GgIixiTY9jyhA+9gFi5iSXWhegw+wgBi8iTXOe+gR+vf8i3iUYqcpfr+9f4iuiVava1fN/Hf2iniVcEZ6e//Jf1imiVbwaDe8/If2itiUaA
					bRe9/Df6i2iTYAdUfG+2f9i8iTXEfyfe+tgBi7iUXyiQgC+1gGiziVZtkXgm/DgJiqiVbklwg8/JgLiliVcImLhD/I]],
				Tail4 = [[
					gZi3i+aGoBhS+YgSjFi7X6mThC+SgIjRi5Vojhgs+Df+jUi6UxgLgI99fzjMi8V3c1fX+Kfqi9i+YPZ/eu+afliyi/aTYJef+cflizi+arXqen+Zfqi+i9ZH
					Yre2+WfzjMi6Wra/fI+Lf9jUi5U9eIfk99gIjRi7VFhigQ+CgSjFi+W/kshA+UgZi3i/ZanGhd+dgcixi+awoShf+a]],
				Tail5 = [[
					gvjIjjYpqCh49agijcjgWyo0hT9TgRjujdUMmDgv9Gf+jzjcSliUgB88frjojgS/eOfE9JfbjTjkVKaZeI9gfQjDjkXsXfds9mfPjCjjY4WCd49efXjRjiX6
					WXea9XfmjmjeVdYae/9Nf4jyjcTLbvfm8/gMjvjeShfvgc9AgejejiT6jxhc9VgsjKjkWfnOiL9mgyjAjkYipdiS9j]],
				["UpperLeg.L"] = [[
					fLhYgS2BdHgx3AfKhbgV34dCft1FfIhigY6wc1erxMfGhogZ+AcmdXqPfFhrgZ/bcub2iwfEhpgY/jdMblfcfDhkgW/sdRcsf1fDhggT/rc8eSiyfFhggP/S
					cafelkfGhjgN+ob8gboSfIhngL9VbuhSr8fKhpgK70bthzvGfMhmgK6gb1h7xUfMhggM5VcHhuzEfMhagP35cihT09]],
				["LowerLeg.L"] = [[
					fHgrgUivflfu/3fEgvgPe1gmfW/9fAg5gFeQhwfS/4e8hOf2iojHfx/ue4hlfvqmkZgx92e3hsftwvkkhp61e6hmfq0Ajmhw4pe+hZfn1UiJhX3tfBhRflzw
					gzhH5IfFhNfmwafvg77cfHhIfqt4e6gw8yfJhEfxrzeago9sfKg9f4pTeSgd+jfJg1f/mReigO/VfIgugIjqfBf+/x]],
				["Foot.L"] = [[
					fFgjhC8me9giuTfFgyg+8Hf3gFvQfFg/g07vg8fev5fFhGgk7eiIewwNfFhIgS7UjOeGwNfFhDgA7ajkd7v+fFg5fz7xi4eZvifFgrfr8UhjfMuzfFgjfw8n
					gRf3uTfFgjf88mfTgXuTfFgjgI8lejgvuSfFgjgT8jeGg9uRfFgjgf8id+hBuRfFgjgr8jeIg8uRfFgjg28keggwuS]],
				["Toe.L"] = [[
					fFgTg2/7fQg6hgfFghgz/4f6gIikfFgtgp/zgpfIjTfFg0ga/rhceAjsfFg2gI/jiLc9jwfFgxf2/hibcqjhfFgofo/rh+dYi9fFgafg/4hGepiEfFgTfk/9
					gMfxhgfFgTfw/8fggnhgfFgTf8/6e+hQhgfFgTgH/4ephphffFgTgT/4ejhwhffFgTgf/4eqhohffFgTgq/6e7hThg]],
				["UpperLeg.R"] = [[
					g8hggR/ZjQg5lGg7hhgO/Dj3gFmsg5hlgL+DkMfHqGg3hpgK8kkUeatpg1hogK7IkQeGwTg0hkgL57kDeJyNg0hdgN4qjtefz+g0hYgQ3BjNe+1+g2hZgU22
					i6fw2Mg3hegX5LjEgyzeg5hlgZ8djTh7uGg7hqgZ/BjbjdmKg8hrgZ/hjCkgghg9hngX/niuj+fSg9higU/vi4iihB]],
				["LowerLeg.R"] = [[
					hAhSfm1keoe43jg9hPflyAfwe+6bg6hKfnvCgufM8Ng4hGfus1hZfV9Qg2hBf1qohtfd+Hg2g5f7n0hpfq++g3gxgEk1hQf7/mg5gsgOi7gtgJ/2g7gsgSgc
					f9gf//g+gzgLeCe4gv/5hChCf9fwdmgj/5hGhafxmicLfx/FhJhqfuuEbWeu8UhIhqfryrb1eO5lhEhgfo02dHea4C]],
				["Foot.R"] = [[
					g7gjfq8mfLgauTg7gjf28ngPf4uTg7gjgC8lhIfcuTg7gjgN8khufJuSg7gjgZ8iiAfAuRg7gjgl8iiAfAuRg7gjgx8khtfJuSg7gjg88lhSfXuTg7grhB8W
					gpfru0g7g5g676fpgNvng7hDgs7mefg5wFg7hIgb7YdThnwPg7hGgJ7VceiFwHg7g/f57jcrh6vyg7gyfu8CdwhOvN]],
				["Toe.R"] = [[
					g7gTfe/8fbgthgg7gTfq/9gLfzhgg7gTf2/7gzfChgg7gTgB/5hOehhfg7gTgN/4hbeRhfg7gTgZ/4hbeShfg7gTgk/5hOeihfg7gTgw/7g6e5hgg7gag2/6
					gcfciEg7gogv/2fwgVi+g7gxgi/ve+hbjig7g2gR/neLikjxg7g0f//gdnjWjrg7gtfv/ldvjGjRg7ghfj/yeciBij]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAibgf/8gAgAhsgAiHgf/7fze1hsgAiMgf/5fteWhsgAifgf/7fze1hsgAibgf/8gAgAhsgAiHgf/7gNhLhsgAiMgf/5gThqhsgAifgf/7gNhLhs]],
				Spine1 = [[
					gAiZgLAMgAgAjTf+iFgLAJgXhIiif+iKgLALghhmisf+idgLAOgZhIjegAiZgLAMgAgAjTgCiFgLAJfpe4iigCiKgLALffeaisgCidgLAOfne4je]],
				Spine2 = [[
					gAihfiBAgAgAn6f8iMfiAsgfhFmZf6iRfiAyguhhmvf8imfiBHgjhDoPgAihfiBAgAgAn6gEiMfiAsfhe7mZgGiRfiAyfSefmvgEimfiBHfde9oP]],
				Neck1 = [[
					gAisfOFFgAgAxRf6iVfNDkgxg6ulf4iafOD6hHhQvMf6ixfPFeg3g0x1gAisfOFFgAgAxRgGiVfNDkfPfGulgIiafOD6e5ewvMgGixfPFefJfMx1]],
				Neck2 = [[
					gAjSe9H8gAgA1Ef5i2e1GCg5gyypf2i9e3GehShFzMf6jYe/Iag+gr1kgAjSe9H8gAgA1EgHi2e1GCfHfOypgKi9e3Geeue7zMgGjYe/IafCfV1k]],
				Head = [[
					gAj2e4AQgAgAj5f5jZeqAHgVgjiWf2jgetAJgfgwisf6j8e8ATgbghkOgAj2e4AQgAgAj5gHjZeqAHfrfdiWgKjgetAJfhfQisgGj8e8ATflffkO]],
				Jaw = [[
					gAj+eC/4gAgAiqf3jcdz/Uf2fZmef0jkd3/efvfJlof5kGeG/7fsfahzgAj+eC/4gAgAiqgJjcdz/UgKgnmegMjkd3/egRg3logHkGeG/7gUgmhz]],
				["UpperArm.L"] = [[
					fPile9svOrnd2efJiMfBplQvpV4ufGiSfCqaQvoj4rfJirfBtjPJmO2vfPile9svOrnd2efXiLe6pIPKqa3ZfaiQe4p1OjqJ2yfWipe6tWNxnk1W]],
				["LowerArm.L"] = [[
					e5iFfBAPgAgAjrezhwfPADgPhKfEewh1fPAEgYhogGeyiMfFAZgchHkte5iFfBAPgAgAjrfAhtfEADfxe2fEfDhyfBAEfoeYgGfBiJe6AZfke5kt]],
				["UpperArm.R"] = [[
					gxile9svxVYj2egpiLe6pIw2Vm3ZgmiQe4p1xdV32ygqipe6tWyPYc1Wgxile9svxVYj2eg3iMfBplvRWr4ug6iSfCqavRXd4rg3irfBtjw3Zy2v]],
				["LowerArm.R"] = [[
					hHiFfBAPgAgAjrhAhtfEADgPhKfEg9hyfBAEgYhogGg/iJe6AZgchHkthHiFfBAPgAgAjrhNhwfPADfxe2fEhQh1fPAEfoeYgGhOiMfFAZfke5kt]],
				Tail1 = [[
					gAihg7dcgtf5/4gCiOg7cCgnf8/vgDiSg7cQgKf//xgCimg7dqfngE/5gAihg7dcfTgH/4f+iOg7cCfZgE/vf9iSg7cQf2gB/xf+img7dqgZf8/5]],
				Tail2 = [[
					gCiphpeSiFfx/4gEiZhobtg7f7/sgDidhobJfNgD/ngBithpdtd+gJ/2f+iphpeSd7gP/4f8iZhobtfFgF/sf9idhobJgzf9/nf/ithpdtiCf3/2]],
				Tail3 = [[
					gIiuiWe5jvfw/wgHiliUcAiAf2/rgBiriUaDfFgB/af7iziWc8ctgD/rf4iuiWe5cRgQ/wf5iliUcAeAgK/rf/iriUaDg7f//agFiziWc8jTf9/r]],
				Tail4 = [[
					gTixjDexlOf9/igMixjAcljlf1/mf/i8i+Zaf0f//Tfyi8jCblcKf2/cftixjDexaygD/if0ixjAclcbgL/mgBi8i+ZagMgB/TgOi8jCblj2gK/c]],
				Tail5 = [[
					ghi0judkmHgX/TgWi6jsculMgB/Zf+jOjoZHhNgC/NfnjIjtZ8cgft/Nffi0judkZ5fp/Tfqi6jscua0f//ZgCjOjoZHezf+/NgZjIjtZ8jggT/N]],
				["UpperLeg.L"] = [[
					fHhlgXzwdagu5BfGhTgb1Tc9eq3ofGhXgd6jcpXVQxfGhqgb/zdndlgPfHhlgX/udGgDi4fJhRgT/mbcf3iFfKhVgR5bcJhvy8fJhpgTuDeCiI8l]],
				["LowerLeg.L"] = [[
					fDg6ghcrgzfv/ze9gngfMZjqgK5Ae2h9gL4qnFhWzEe/hqfv6/i1gsw7fHhdfr/2gbfxi+fIhLfmvYe/gH8CfHgqgEiPfVgX/5fHhFgumyfegV/Q]],
				["Foot.L"] = [[
					fFhDhP73gLf6vtfFhUgq7BlWc2v9fFhTf96wmocGvwfFhAfa71icepvifGhUe8/Jfsf2nSfFgjgA8kefgxuSfFgjgz8le4gkuTfFgxhZ7Ke/gow3]],
				["Toe.L"] = [[
					fFgyhF/2gHf2jEfFhCgg/Kjna9jqfFhBf0+2kfZwjlfFgvfP/vhsdxi8fGhLeq/bfqf/aDfFgTf0/6e7hUhgfFgTgn/7fMg+hgfFgfhQ/qfVg/ka]],
				["UpperLeg.R"] = [[
					g5hlgX/ui6f9i4g3hRgT/mkkgJiFg2hVgR5bj3eRy8g3hpgTuDh+d48lg5hlgXzwimfS5Bg6hTgb1TjDhW3og6hXgd6jjXorQxg6hqgb/ziZibgP]],
				["LowerLeg.R"] = [[
					g5hdfr/2flgPi+g4hLfmvYhBf58Cg5gqgEiPgrfp/5g5hFgumygifr/Qg9g6ghcrfNgR/zhDgngfMZcWf25AhKh9gL4qY7eqzEhBhqfv6/dLfUw7]],
				["Foot.R"] = [[
					g6hUe8/JgUgKnSg7gjgA8khhfPuSg7gjgz8lhIfcuTg7gxhZ7KhBfYw3g7hDhP73f1gGvtg7hUgq7BaqjKv9g7hTf96wZYj6vwg7hAfa71dkhXvi]],
				["Toe.R"] = [[
					g6hLeqAlfqf/l9g7gTf0AGe7hUegg7gTgnAFfMg+egg7gfhQAWfVg/bmg7gyhFAKgHf2c8g7hCggA2jna9cWg7hBf0BKkfZwcbg7gvfPARhsdxdE]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAiggfAFgAgAh8gAibgjAGgAgAiUgAiRgrALgAgAjOgAiFg0ATgAgAkMgAh/g5AXgAgAktgAikgHABgAgAgLgAi2foAHgAgAdfgAi2foAHgAgAdfgAi2foAH
					gAgAdfgAi0frAGgAgAdygAiuf6ACgAgAe8gAingNABgAgAgegAihgcAEgAgAhpgAiggfAFgAgAh8gAiggfAFgAgAh8gAiggfAFgAgAh8]],
				Spine1 = [[
					gAiigLAtgAgAmlgAiegOAwgAgAmzgAiVgXA4gAgAnWgAiLggBBgAgAn6gAiFglBFgAgAoNgAikfyAagAgAlBgAizfTAKgAgAjAgAizfTAKgAgAjAgAizfTAK
					gAgAjAgAixfXAMgAgAjPgAitflATgAgAkMgAinf4AegAgAlagAijgHAqgAgAmWgAiigLAtgAgAmlgAiigLAtgAgAmlgAiigLAtgAgAml]],
				Spine2 = [[
					gAizflB5gAgAqzgAivfoB7gAgAq4gAinfyB/gAgArDgAiff7CDgAgArOgAiagBCGgAgArVgAixfLBdgAgApegAi6eqBEgAgAoJgAi6eqBEgAgAoJgAi6eqBE
					gAgAoJgAi6euBHgAgAoUgAi4e9BUgAgApBgAi1fRBmgAgAp8gAizfhB1gAgAqogAizflB5gAgAqzgAizflB5gAgAqzgAizflB5gAgAqz]],
				Neck1 = [[
					gAjBfTE5gAgAw+gAi+fXFSgAgAxmgAi2fhGWgAgAzGgAitfrHjgAgA0ogAipfwIOgAgA1ZgAi9e4DvgAgAu+gAjFeXB9gAgAq9gAjFeXB9gAgAq9gAjFeXB9
					gAgAq9gAjFebCHgAgArYgAjEeqCygAgAtAgAjCe/DygAgAvEgAjBfPEqgAgAwlgAjBfTE5gAgAw+gAjBfTE5gAgAw+gAjBfTE5gAgAw+]],
				Neck2 = [[
					gAjmfBG/gAgAz8gAjkfHHqgAgA0wgAjefVJagAgA2ogAjWfkLagAgA4egAjSfrMhgAgA5YgAjgehFbgAgAxygAjgd3CsgAgAsygAjgd3CsgAgAsygAjgd3Cs
					gAgAsygAjhd8C6gAgAtTgAjjePD5gAgAvRgAjleoFYgAgAxugAjme8GpgAgAzggAjmfBG/gAgAz8gAjmfBG/gAgAz8gAjmfBG/gAgAz8]],
				Head = [[
					gAkKe5AFgAgAh6gAkIfBANgAgAjZgAkCfVAzgAgAnBgAj6fqB4gAgAqwgAj1f1CogAgAsqgAkBeTACgAgAhAgAj7deAYgAgAbOgAj7deAYgAgAbOgAj7deAY
					gAgAbOgAj8dkAUgAgAbrgAkBd7AIgAgAdagAkHeaABgAgAftgAkJezADgAgAhdgAkKe5AFgAgAh6gAkKe5AFgAgAh6gAkKe5AFgAgAh6]],
				Jaw = [[
					gAkMeD/8gAgAhpgAkPeL/+gAgAg5gAkVeh/+gAgAe+gAkZe9/0gAgAcrgAkafM/sgAgAbqgAkAdc7/gAgAvfgAjmcs85gAgAtvgAjmcs+dgAgApzgAjmcs+H
					gAgAqygAjpcx+1gAgAoigAj0dG/ZgAgAmGgAkBdj/wgAgAj1gAkKd8/7gAgAiGgAkMeD/8gAgAhpgAkMeD/8gAgAhpgAkMeD/8gAgAhp]],
				["UpperArm.L"] = [[
					fPi9fB0lNJgAvnfPi6fF1IMveXuPfPiyfO2CMXaHq1fPiqfY2XNBVgnQfPilfd2RNzTIldfPi4em27NBajqWfPi+eG3eNlb7qzfPi+eG3eNlb7qzfPi+eG3e
					Nlb7qzfPi+eK3UNicMrIfPi+eZ2pNWdQscfPi9et1pNMepuGfPi9e90zNJfuvUfPi9fB0lNJgAvnfPi9fB0lNJgAvnfPi9fB0lNJgAvn]],
				["LowerArm.L"] = [[
					e5iletADgAgAhVe4ileuAagwf/k7e2ipezDEilgEtYezise+IYkggX1FeyiufGMBlggl4We3iueKAuhWgZmge5ixdpADgAgAeie5ixdpADgAgAeie5ixdpAD
					gAgAeie5iwdtADgAgAeue5isd+ABgAgAfde5ioeWABgAgAgae5ileoACgAgAhJe5iletADgAgAhVe5iletADgAgAhVe5iletADgAgAhV]],
				["UpperArm.R"] = [[
					gxi9fB0ly3gAvngxi6fF1IzRhpuPgxiyfO2Czpl5q1gxiqfY2Xy/qgnQgxilfd2RyNs4ldgxi4em27y/ldqWgxi+eG3eybkFqzgxi+eG3eybkFqzgxi+eG3e
					ybkFqzgxi+eK3Uyej0rIgxi+eZ2pyqiwscgxi9et1py0hXuGgxi9e90zy3gSvUgxi9fB0ly3gAvngxi9fB0ly3gAvngxi9fB0ly3gAvn]],
				["LowerArm.R"] = [[
					hHiletADgAgAhVhIileuAafQgBk7hKipezDEdbf8tYhNise+IYbgfp1FhOiufGMBagfb4WhJiueKAueqfnmghHixdpADgAgAeihHixdpADgAgAeihHixdpAD
					gAgAeihHiwdtADgAgAeuhHisd+ABgAgAfdhHioeWABgAgAgahHileoACgAgAhJhHiletADgAgAhVhHiletADgAgAhVhHiletADgAgAhV]],
				Tail1 = [[
					gAigg8fogAgA//gAibhAfsgAgA//gAiOhIf1gAgA//gAiBhQf/gAgA//gAh6hVgFgAgA//gAingkcugAgA/0gAi+gDbMfYgF/ngAi+gDcLfdgD/wgAi+gDcL
					gjf9/wgAi8gHcjhRf5/xgAi0gWd3hGf9/5gAiqgqfNgMgA/+gAiig4f9fvgA//gAigg8fyf6gA//gAigg8fogAgA//gAigg8fogAgA//]],
				Tail2 = [[
					gAihhqeqgAgA/9gAibhteZgAgA/8gAiPh2dygAgA/6gAiBh+dHgAgA/3gAh6iDcxgAgA/1gAiwhRaogAgA/if+jLgvaOevgI/cf+jJgwcNe6gF/vgCjJgwcN
					hGf7/vgEjGg0cpijf3/tgDi6hEeGiMf+/3gBishYfSgYgB/+f/iihmfnfdf+//gAighqe9fzf//+gAihhqeqgAgA/9gAihhqeqgAgA/9]],
				Tail3 = [[
					gAikiYdkgAgA/5gAigibdAgAgA/2gAiVijbngAgA/sgAiJisaJgAgA/cgAiDiwZZgAgA/TgAi/h8YcgAgA/Ff7jchaZKeGgI/Mf7jThdcIeYgD/tgFjThdcI
					hof9/tgLjPhgcqj0f7/lgJi/hxePjRgE/xgCiuiGfPglgC/+f+ijiUfJfMf7/+f/ijiYeBftf+/7gAikiYdkgAgA/5gAikiYdkgAgA/5]],
				Tail4 = [[
					gAirjFcUgAgA/xgAipjIbcgAgA/qgAiijPZUgAgA/SgAiajWXFgAgA+ugAiWjaV8gAgA+XgAjVilWJgAgA+bf1jviDX9ddgE+2f3jeiJb5d1f//pgJjeiJb5
					iLgB/pgWjZiMchlEgG/ZgTjEieePkVgR/pgDiwizfDgxgF/9f7iljCehe7f3/8f+ipjGc7fmf9/1gAirjFcUgAgA/xgAirjFcUgAgA/x]],
				Tail5 = [[
					gAi2jyatgAgA/jgAi2j0ZigAgA/VgAi0j5WsgAgA+mgAizj9TwgAgA9jgAixj/SRgAgA84gAjwjKTjgAgA9dfukFirWac1f7+Wfwjqi1bSdTf2/hgQjqi1bS
					itgK/hgkjii2cCmSgc/HgfjKjKd3lYgm/dgFizjheeg8gJ/8f4iqjwdheqfx/3f9iyjzbdfgf6/qgAi2jyatgAgA/jgAi2jyatgAgA/j]],
				["UpperLeg.L"] = [[
					fHhtgL7TdNgAwcfHhpgN8DdDf1vFfHhggT9kcvfcrxfHhWgZ+wcefBoCfHhRgc/NcXeyl4fHhvf43zdogh1PfHiAfizkeNhA5OfHiAfizkeNhA5OfHiAfizk
					eNhA5OfHh+flzveNg/5FfHh5fw0keLg74bfHhzf+4Ldqgg00fHhugI6xdRgGxTfHhtgL7TdNgAwcfHhtgL7TdNgAwcfHhtgL7TdNgAwc]],
				["LowerLeg.L"] = [[
					fDhFf2srgwgA9XfDhEf0sAg0gD9pfDhBfyq5g9gL+EfChBfxqnhCgQ+KfChBfyq4hDgT+EfEhDfzrcgjf193fFhUfts9gQfp9PfFhUfts9gQfp9PfFhUfts9
					gQfp9PfFhSfvtKgQfq9JfFhNf3uHgQfq8tfEhGf3tCgif19NfDhFf2smguf+9ZfDhFf2srgwgA9XfDhFf2srgwgA9XfDhFf2srgwgA9X]],
				["Foot.L"] = [[
					fFgjgW8ngAgAuTfFgjgW8ngFf+uTfFgjgW8ngOf5uTfFgjgW8ngUf2uTfFgjgW8ngWf1uTfFgjgW8nfzgGuTfFgxgN6xfjgTxgfFgxgN6xfjgTxgfFgxgN6x
					fjgTxgfFgvgP7EfigTxCfFgngU8IfhgRvPfFgjgW8nfxgHuTfFgjgW8nf+gBuTfFgjgW8ngAgAuTfFgjgW8ngAgAuTfFgjgW8ngAgAuT]],
				["Toe.L"] = [[
					fFgTgK/9gAgAhgfFgTgK/9gEf8hgfFgTgK/9gKf0hgfFgTgK/9gOfvhgfFgTgK/9gPfthgfFgTgK/9f3gLhgfFgegF/kftgdlLfFgegF/kftgdlLfFgegF/k
					ftgdlLfFgdgG/pfsgdknfFgWgJ/4fqgcijfFgTgK/9f1gNhgfFgTgK/9f+gChgfFgTgK/9gAgAhgfFgTgK/9gAgAhgfFgTgK/9gAgAhg]],
				["UpperLeg.R"] = [[
					g5htgL7TizgAwcg5hpgN8Di9gLvFg5hggT9kjRgkrxg5hWgZ+wjig/oCg5hRgc/NjphOl4g5hvf4+Qjlgwptg5iAfi/jkEiGdcg5iAfi/jkEiGdcg5iAfi/j
					kEiGdcg5h+fl/pkCh9etg5h5fw/ej2hXj9g5hzf+9/jagpqlg5hugI79i8gIvQg5htgL7TizgAwcg5htgL7TizgAwcg5htgL7TizgAwc]],
				["LowerLeg.R"] = [[
					g9hFf2srfQgA9Xg9hEf0sAfMf99pg9hBfyq5fDf1+Eg+hBfxqne+fw+Kg+hBfyq4e9ft+Eg+hWfUqwfAfx+Hg+iHe2yofJfi5/g+iHe2yofJfi5/g+iHe2yo
					fJfi5/g+iCe4xrfHfi6pg+hvfEuefCfm8gg+hXfasTfEfx9hg9hJfwsZfNf99eg9hFf2srfQgA9Xg9hFf2srfQgA9Xg9hFf2srfQgA9X]],
				["Foot.R"] = [[
					g7gjgW8ngAgAuTg7gjgW8nf7gCuTg7gjgW8nfygHuTg7gjgW8nfsgKuTg7gjgW8nfqgLuTg7g4f4+dfqgHpyg7hbfF/kfqf8a4g7hbfF/kfqf8a4g7hbfF/k
					fqf8a4g7hXfL/zfof9chg7hIfg/zfmgDjYg7g1f8+PfwgGqdg7gngR86f8gCtsg7gjgW8ngAgAuTg7gjgW8ngAgAuTg7gjgW8ngAgAuT]],
				["Toe.R"] = [[
					g7gTgK/9gAgAhgg7gTgK/9f8gEhgg7gTgK/9f2gMhgg7gTgK/9fygRhgg7gTgK/9fxgThgg7gsfo/zfvgPcng7hhey6zfqgGOig7hhey6zfqgGOig7hhey6z
					fqgGOig7hbe37qfpgHP8g7hEfM+dfqgNWOg7gpfs/4fzgMdUg7gXgE/+f9gDg0g7gTgK/9gAgAhgg7gTgK/9gAgAhgg7gTgK/9gAgAhg]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiggfAFgAgAh8gAidgfADgAgAhigAiWgfABgAgAgmgAiQgfABgAgAf1gAiRgfABgAgAf+gAiegfAGgAgAiWgAilgfAUgAgAkYgAimgfAXgAgAkugAimgfAX
					gAgAkugAimgfAXgAgAkugAimgfAXgAgAkugAimgfAXgAgAkugAimgfAXgAgAkugAimgfAXgAgAkugAimgfAXgAgAkugAimgfAXgAgAkugAimgfAXgAgAkugA
					ilgfAXgAgAkqgAijgfAPgAgAjsgAiggfAHgAgAiYgAiggfAFgAgAh8gAiggfAFgAgAh8gAiggfAFgAgAh8]],
				Spine1 = [[
					gAiigLAtgAgAmlgAifgLAmgAgAmBgAiWgKAYgAgAkwgAiQgKAPgAgAjugAiRgKAQgAgAj5gAihgLA1gAgAnJgAirgLBlgAgAp5gAisgLBvgAgAqWgAisgLBv
					gAgAqWgAisgLBvgAgAqWgAisgLBvgAgAqWgAisgLBvgAgAqWgAisgLBvgAgAqWgAisgLBvgAgAqWgAisgLBvgAgAqWgAisgLBvgAgAqWgAisgLBvgAgAqWgA
					isgLBtgAgAqRgAiogLBTgAgAo+gAikgLA1gAgAnMgAiigLAtgAgAmlgAiigLAtgAgAmlgAiigLAtgAgAml]],
				Spine2 = [[
					gAizflB5gAgAqzgAiufkBqgAgAqHgAijfjBLgAgAojgAiafiA2gAgAnQgAibfiA6gAgAnfgAizflCKgAgArggAjDfqDrgAgAu2gAjFfrD9gAgAvYgAjFfrD9
					gAgAvYgAjFfrD9gAgAvYgAjFfrD9gAgAvYgAjFfrD9gAgAvYgAjFfrD9gAgAvYgAjFfrD9gAgAvYgAjFfrD9gAgAvYgAjFfrD9gAgAvYgAjFfrD9gAgAvYgA
					jFfqD6gAgAvSgAi+foDHgAgAtvgAi2flCLgAgArjgAizflB5gAgAqzgAizflB5gAgAqzgAizflB5gAgAqz]],
				Neck1 = [[
					gAjBfTE5gAgAw+gAi7fSEGgAgAvogAiufQCjgAgAsegAijfOBjgAgApzgAilfOBtgAgAqRgAjCfVFUgAgAxogAjVfdJegAgA2sgAjYffKNgAgA3agAjYffKN
					gAgA3agAjYffKNgAgA3agAjYffKNgAgA3agAjYffKNgAgA3agAjYffKNgAgA3agAjYffKNgAgA3agAjYffKNgAgA3agAjYffKNgAgA3agAjYffKNgAgA3agA
					jXfeKFgAgA3SgAjQfaIDgAgA1MgAjFfVFngAgAyEgAjBfTE5gAgAw+gAjBfTE5gAgAw+gAjBfTE5gAgAw+]],
				Neck2 = [[
					gAjmfBG/gAgAz8gAjfe8FwgAgAyRgAjMezDXgAgAuPgAi8esB4gAgAqvgAi/etCHgAgArYgAjofFHqgAgA0wgAj/fdOLgAgA6jgAkBfiPUgAgA7TgAkBfiPU
					gAgA7TgAkBfiPUgAgA7TgAkBfiPUgAgA7TgAkBfiPUgAgA7TgAkBfiPUgAgA7TgAkBfiPUgAgA7TgAkBfiPUgAgA7TgAkBfiPUgAgA7TgAkBfiPUgAgA7TgA
					kBfhPIgAgA7LgAj5fVL9gAgA47gAjsfGIIgAgA1SgAjmfBG/gAgAz8gAjmfBG/gAgAz8gAjmfBG/gAgAz8]],
				Head = [[
					gAkKe5AFgAgAh6gAkBewACgAgAe5gAjpedA/gAgAYLgAjTeQCzgAgAS+gAjXeSCagAgAT3gAkMe/AOgAfpjogAkgfrERgXfJv5gAkifyEefOhxwLgAkifyFL
					gQfgxagAkifyFfgresx1gAkifyEhfShowQgAkifyFAgAgAxJgAkifyFmg0ebx+gAkifyElfZhWwagAkifyE1fxggw4gAkifyFqg5eSyCgAkifyEsfkg+wogA
					kifxEiflg9wWgAkdfdClgWe1segAkQfCAUgAgGkZgAkKe5AFgAgAh6gAkKe5AFgAgAh6gAkKe5AFgAgAh6]],
				Jaw = [[
					gAkMeD/8gAgAhpgAj4d6/mgAgAk9gAjLdv9lgAgAsKgAindv6wgAgAxigAitdv7VgAgAwogBkUeJ/mf6gWk/gDlNfM/9fSglfKf5lPfU/7hle5ghgClSfY/+
					figTfGgFlSfZ/7evgxekf6lPfU/8hde/gbgAlRfX//gAgAfagGlSfa/5efg7eZf7lPfU/9hOfKgQf+lQfW//gdfsfugHlSfa/4eWhAeUf8lQfV/+g4fagBf8
					lPfT/+g2fagDgElAe0/9fQg9figAkaeM/9gBf7hWgAkMeD/8gAgAhpgAkMeD/8gAgAhpgAkMeD/8gAgAhp]],
				["UpperArm.L"] = [[
					fPi9fB0lNJgAvnfPi2fA0vNJf0vafPine+1ENJfau9fPibe91VNKfEulfPide91SNKfHupfPi/fC1jMBZvq+fPjWfK0lOKP9k5fPjafM0FPXN2jrfPjafM0F
					PXN2jrfPjafM0FPXN2jrfPjafM0FPXN2jrfPjafM0FPXN2jrfPjafM0FPXN2jrfPjafM0FPXN2jrfPjafM0FPXN2jrfPjafM0FPXN2jrfPjafM0FPXN2jrfP
					jZfM0KPJOMj3fPjPfH1QMgUennfPjCfD1HMWdRtjfPi9fB0lNJgAvnfPi9fB0lNJgAvnfPi9fB0lNJgAvn]],
				["LowerArm.L"] = [[
					e5iletADgAgAhVe5ieerAEgAgAhpe5iQepAGgAgAiWe5iFenAJgAgAi6e5iHenAJgAgAi1e1i2eoCMjRgUrHewjke5LNoIia2xevjre/OBpGjK4pevjre/OB
					pGjK4pevjre/OBpGjK4pevjre/OBpGjK4pevjre/OBpGjK4pevjre/OBpGjK4pevjre/OBpGjK4pevjre/OBpGjK4pevjre/OBpGjK4pevjre/OBpGjK4pev
					jqe+Nio8jB4XeyjUevGQmBhMx9e3iweqAmhigCl0e5iletADgAgAhVe5iletADgAgAhVe5iletADgAgAhV]],
				["UpperArm.R"] = [[
					gxi9fB0ly3gAvngxi2fA0vy3gMvagxine+1Ey3gmu9gxibe91Vy2g8ulgxide91Sy2g5upgxi/fC1jz/mRq+gxjWfK0lx2wDk5gxjafM0FwpyKjrgxjafM0F
					wpyKjrgxjafM0FwpyKjrgxjafM0FwpyKjrgxjafM0FwpyKjrgxjafM0FwpyKjrgxjafM0FwpyKjrgxjafM0FwpyKjrgxjafM0FwpyKjrgxjafM0FwpyKjrgx
					jZfM0Kw3x0j3gxjPfH1QzgrinngxjCfD1Hzqivtjgxi9fB0ly3gAvngxi9fB0ly3gAvngxi9fB0ly3gAvn]],
				["LowerArm.R"] = [[
					hHiletADgAgAhVhHieerAEgAgAhphHiQepAGgAgAiWhHiFenAJgAgAi6hHiHenAJgAgAi1hLi2eoCMcvfsrHhQjke5LNX4dm2xhRjre/OBW6c24phRjre/OB
					W6c24phRjre/OBW6c24phRjre/OBW6c24phRjre/OBW6c24phRjre/OBW6c24phRjre/OBW6c24phRjre/OBW6c24phRjre/OBW6c24phRjre/OBW6c24phR
					jqe+NiXEc/4XhOjUevGQZ/e0x9hJiweqAmeef+l0hHiletADgAgAhVhHiletADgAgAhVhHiletADgAgAhV]],
				Tail1 = [[
					gAigg8fogAgA//gAidg8fegAgA//gAiYg8fGgAgA/+gAiUg8eygAgA/+gAiVg8e2gAgA/+gAidg8frf0gA//gAigg8gUfhf///gAihg8gahAgC/+gAihg8ga
					fuf///gAihg8gafPf+/+gAihg8gag6gC/+gAihg8gagAgA//gAihg8gafGf+/+gAihg8gagxgC/+gAihg8gagSgB//gAihg8gafAf+/+gAihg8gagjgB//gA
					ihg8gZgigB//gAigg8gIfYf///gAigg8fwgDgA//gAigg8fogAgA//gAigg8fogAgA//gAigg8fogAgA//]],
				Tail2 = [[
					gAihhqeqgAgA/9gAifhqevgAgA/9gAibhqe7gAgA/+gAiXhqfFgAgA/+gAiYhqfDgAgA/+f/iehqeWf4f//8f/ighqdlerf8/3gDifhqdbhngI/2f/ifhqdb
					gLf+/4f+ifhqdbeQf5/1gDifhqdbhSgI/3gAifhqdbgsgA/4f9ifhqdbeJf4/1gCifhqdbg3gG/4gBifhqdbhJgD/3f9ifhqdbeMf4/1gCifhqdbgXgE/4gC
					ifhqddhfgF/2f+ighqd4e/f8/5gAighqedf+gA/9gAihhqeqgAgA/9gAihhqeqgAgA/9gAihhqeqgAgA/9]],
				Tail3 = [[
					gAikiYdkgAgA/5gAiiiYd5gAgA/7gAieiYepgAgA/9gAiaiYfQgAgA/+gAibiYfJgAgA/+f/ijiYc6gKgA/1f7iniXavd6f1/fgHiniXaXhhgS/cgAiniXaX
					hIf9/ef5iniXaXdkfw/ZgGiniXaWg6gQ/egCiniXaXhsgD/cf4iniXaXdsft/ZgFiniXaWgPgN/fgEiniXaXiHgI/af4iniXaXeBft/bgDiniXaWfigI/fgG
					iniXabiVgM/af7imiXbifCf3/qgAiliYdDf1f//2gAikiYdkgAgA/5gAikiYdkgAgA/5gAikiYdkgAgA/5]],
				Tail4 = [[
					gAirjFcUgAgA/xgAiojFc5gAgA/1gAiijGeNgAgA/8gAicjFfRgAgA/+gAidjFfFgAgA/+gAirjFbUgfgC/pf1i1jCX0drfp+1gMi3jCXMgvgf+vgDi3jCXM
					iCgC+rfyi3jBXMdlfg+pgJi3jCXMf/gZ+wgHi3jCXMicgL+qfyi3jBXMd/fe+rgFi3jCXMfOgR+vgKi3jCXMiqgU+ofzi3jBXMelfe+tgBi3jCXMeigI+ugM
					i3jBXTimga+rf5izjDZDfhfy/OgAitjFbgfsf+/qgAirjFcUgAgA/xgAirjFcUgAgA/xgAirjFcUgAgA/x]],
				Tail5 = [[
					gAi2jyatgAgA/jgAixjybigAgA/rgAinjzdZgAgA/4gAiejze6gAgA/+gAigjzepgAgA/9gBi5jxZXgtgG/SfvjMjpUmeHfY90gNjPjoTxfrgn9jgIjPjpTx
					ibgP9dfsjPjoTxeUfM9ggIjPjpTxe+gc9igNjPjoTxiigd9cftjPjoTxe7fM9igDjPjpTxeXgP9hgRjPjoTxicgo9dfvjPjoTxfnfQ9jf9jPjpTxd5gA9fgT
					jPjoT6iHgu9if3jGjtWRgLfx+ef/i6jxZlfof8/VgAi2jyatgAgA/jgAi2jyatgAgA/jgAi2jyatgAgA/j]],
				["UpperLeg.L"] = [[
					fHhtgL7TdNgAwcfHhpgM76dCf4vWfHhigP9CctfntAfHhbgS9ycefarGfHhcgS9qcgfcrcfHhsgK7UdMf/wafHh2gE4jd0gd0YfHh3gD4Ad7gi1CfHh3gD4A
					d7gi1CfHh3gD4Ad7gi1CfHh3gD4Ad7gi1CfHh3gD4Ad7gi1CfHh3gD4Ad7gi1CfHh3gD4Ad7gi1CfHh3gD4Ad7gi1CfHh3gD4Ad7gi1CfHh3gD4Ad7gi1CfH
					h3gD4Gd6gh07fHhzgG5fdogUzLfHhugK66dTgFxGfHhtgL7TdNgAwcfHhtgL7TdNgAwcfHhtgL7TdNgAwc]],
				["LowerLeg.L"] = [[
					fDhFf2srgwgA9XfDhEf0r7g0gD9rfDhBfxqjg8gJ+LfCg+fwpwhAgM+dfCg/fwp4g/gM+afDhEf1sGgxgA9mfEhKf7uygdf08XfFhLf9vSgZfx8GfFhLf9vS
					gZfx8GfFhLf9vSgZfx8GfFhLf9vSgZfx8GfFhLf9vSgZfx8GfFhLf9vSgZfx8GfFhLf9vSgZfx8GfFhLf9vSgZfx8GfFhLf9vSgZfx8GfFhLf9vSgZfx8GfF
					hLf8vNgafy8JfEhIf5t+gjf38xfDhGf2s7gtf+9QfDhFf2srgwgA9XfDhFf2srgwgA9XfDhFf2srgwgA9X]],
				["Foot.L"] = [[
					fFgjgW8ngAgAuTfFgjgW8ngFf+uTfFgjgW8ngNf5uTfFgjgW8ngSf3uTfFgjgW8ngRf3uTfFgjgW8ngBf/uTfFgjgW8nfsgKuTfFgjgW8nfpgMuTfFgjgW8n
					fpgMuTfFgjgW8nfpgMuTfFgjgW8nfpgMuTfFgjgW8nfpgMuTfFgjgW8nfpgMuTfFgjgW8nfpgMuTfFgjgW8nfpgMuTfFgjgW8nfpgMuTfFgjgW8nfpgMuTfF
					gjgW8nfpgLuTfFgjgW8nfzgGuTfFgjgW8nf9gBuTfFgjgW8ngAgAuTfFgjgW8ngAgAuTfFgjgW8ngAgAuT]],
				["Toe.L"] = [[
					fFgTgK/9gAgAhgfFgTgK/9gDf8hgfFgTgK/9gJf1hgfFgTgK/9gNfxhgfFgTgK/9gMfxhgfFgTgK/9gBf/hgfFgTgK/9fygRhgfFgTgK/9fvgUhgfFgTgK/9
					fvgUhgfFgTgK/9fvgUhgfFgTgK/9fvgUhgfFgTgK/9fvgUhgfFgTgK/9fvgUhgfFgTgK/9fvgUhgfFgTgK/9fvgUhgfFgTgK/9fvgUhgfFgTgK/9fvgUhgfF
					gTgK/9fwgUhgfFgTgK/9f3gLhgfFgTgK/9f+gChgfFgTgK/9gAgAhgfFgTgK/9gAgAhgfFgTgK/9gAgAhg]],
				["UpperLeg.R"] = [[
					g5htgL7TizgAwcg5hpgM76i+gIvWg5higP9CjTgZtAg5hbgS9yjigmrGg5hcgS9qjggkrcg5hsgK7Ui0gBwag5h2gE4jiMfj0Yg5h3gD4AiFfe1Cg5h3gD4A
					iFfe1Cg5h3gD4AiFfe1Cg5h3gD4AiFfe1Cg5h3gD4AiFfe1Cg5h3gD4AiFfe1Cg5h3gD4AiFfe1Cg5h3gD4AiFfe1Cg5h3gD4AiFfe1Cg5h3gD4AiFfe1Cg5
					h3gD4GiGff07g5hzgG5fiYfszLg5hugK66itf7xGg5htgL7TizgAwcg5htgL7TizgAwcg5htgL7TizgAwc]],
				["LowerLeg.R"] = [[
					g9hFf2srfQgA9Xg9hEf0r7fMf99rg9hBfxqjfEf3+Lg+g+fwpwfAf0+dg+g/fwp4fBf0+ag9hEf1sGfPgA9mg8hKf7uyfjgM8Xg7hLf9vSfngP8Gg7hLf9vS
					fngP8Gg7hLf9vSfngP8Gg7hLf9vSfngP8Gg7hLf9vSfngP8Gg7hLf9vSfngP8Gg7hLf9vSfngP8Gg7hLf9vSfngP8Gg7hLf9vSfngP8Gg7hLf9vSfngP8Gg7
					hLf8vNfmgO8Jg8hIf5t+fdgJ8xg9hGf2s7fTgC9Qg9hFf2srfQgA9Xg9hFf2srfQgA9Xg9hFf2srfQgA9X]],
				["Foot.R"] = [[
					g7gjgW8ngAgAuTg7gjgW8nf7gCuTg7gjgW8nfzgHuTg7gjgW8nfugJuTg7gjgW8nfvgJuTg7gjgW8nf/gBuTg7gjgW8ngUf2uTg7gjgW8ngXf0uTg7gjgW8n
					gXf0uTg7gjgW8ngXf0uTg7gjgW8ngXf0uTg7gjgW8ngXf0uTg7gjgW8ngXf0uTg7gjgW8ngXf0uTg7gjgW8ngXf0uTg7gjgW8ngXf0uTg7gjgW8ngXf0uTg7
					gjgW8ngXf1uTg7gjgW8ngNf6uTg7gjgW8ngDf/uTg7gjgW8ngAgAuTg7gjgW8ngAgAuTg7gjgW8ngAgAuT]],
				["Toe.R"] = [[
					g7gTgK/9gAgAhgg7gTgK/9f9gEhgg7gTgK/9f3gLhgg7gTgK/9fzgPhgg7gTgK/9f0gPhgg7gTgK/9f/gBhgg7gTgK/9gOfvhgg7gTgK/9gRfshgg7gTgK/9
					gRfshgg7gTgK/9gRfshgg7gTgK/9gRfshgg7gTgK/9gRfshgg7gTgK/9gRfshgg7gTgK/9gRfshgg7gTgK/9gRfshgg7gTgK/9gRfshgg7gTgK/9gRfshgg7
					gTgK/9gQfshgg7gTgK/9gJf1hgg7gTgK/9gCf+hgg7gTgK/9gAgAhgg7gTgK/9gAgAhgg7gTgK/9gAgAhg]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiggfAFgAgAh8gAidgfAEgDgrhugAiJgfAEgLhlgRgAi4gfALgEhmitgAjegfAUf/g/kOgAjrgfAXgAgAkugAjegfAUgBfBkOgAi4gfALf8eaitgAiJgfAE
					f0ebgQgAiSgfADf6fBg7gAiPgfACgAgAgvgAjKgfAOgBg/jfgAjmgfAYf+hmkigAjpgfAZf+hmkogAjSgfAQgAg/jxgAiegfADgAgAhegAiPgfADf6fBgvgA
					ifgfAHf6eah6gAiggfAGf7e0h8gAiggfAFf/fwh8gAiggfAFgAgAh8]],
				Spine1 = [[
					gAiigLAtgAgAmlf/ifgLApgJgrmRf+iKgLAUgYhjkGf+i7gLA9gThknhf/jjgLBegKg+pegAjygLBpgAgAqFgBjjgLBef2fCpegCi7gLA9ftecnhgCiJgLAU
					foedkGgBiTgLAcfyfDlFgAiQgKAYgAgAkzf/jPgLBMgLg+oif+jsgLBngPhlp2f+jvgLBqgPhlp+f/jXgLBTgKg+o5gAiggLAjgAgAl1gBiQgLAZfyfDkzgC
					iigLAvfrecmigCiigLAufwe1mlgAiigLAtf9fxmlgAiigLAtgAgAml]],
				Spine2 = [[
					gAizflB5gAgAqzf9ivfkBwgPgpqZf6iUfjA+gihgnlf6jOfmCWghhgr3f8j7fpDWgUg8uLgAkKfqDsgAgAu5gEj7fpDWfsfEuLgGjOfmCWffegr3gGiUfjA+
					feegnkgEigfjBSfrfFo3gAidfjBLgAgAogf8jkfoC1gUg8tGf6kFfqDmgfhhunf6kIfqDrgfhhuwf8jtfoDCgUg8thgAivfkBjgAgApzgEidfjBMfrfFoggG
					iyflB6feegqvgEizflB7fme4qzgBizflB5f7fxqzgAizflB5gAgAqz]],
				Neck1 = [[
					gAjBfTE5gAgAw+f9i9fTEhgXglwWf4iefPCZgwhar/f5jdfWF8g3hWyff7kNfcIhgkg01sgAkdfeJZgAgA2ogFkNfcIhfcfM1sgHjdfWF8fJeqyfgIiefPCY
					fQemr9gFisfQDQfhfJt/gAiofQC+gAgAtbf7j1fZHPgjg00Of5kXfdJGg6hU2Rf5kafeJSg6hU2df7j+faHugjg00zgAi8fSD+gAgAvagFiofQC/fhfJtbgI
					jAfUE3fKeqw3gGjBfUE6fXe/w9gBjBfTE5f4fzw+gAjBfTE5gAgAw+]],
				Neck2 = [[
					gAjmfBG/gAgAz8f8jhe/GjgbgizXf2i7exD8g6hUvRf3kFfIIOhAhP1Vf7k2fYLJgpgw4OgAlGfeMHgAgA5DgFk2fYLJfXfQ4OgJkFfIIOfAex1VgKi7exD7
					fGesvQgGjNe3FCfbfNxKgAjIe1EsgAgAwpf7kefQJtgpgw26f4lAfcLyhDhM4uf4lEfdL/hDhM45f7knfTKQgpgw3cgAjfe7F6gAgAyggGjIe1EtfbfNwogJ
					jmfBG9fBewz1gHjmfCHBfQfEz7gBjmfBG/f2f0z8gAjmfBG/gAgAz8]],
				Head = [[
					gAkKe5AFgAgAh6f8kEe1ALefgviwf0jaeeAUcciMewf2kpfEA1cihUmGf7lafeBsd7ghp/gAlqfmCBgAgArKgFlafeBsiFffp/gKkpfEA1jeesmGgMjaedAU
					jkd0eugHjuenAIiNezgzgAjoekABgAgAgHf7lCfRBJd4gqoHf4lkfjCGcrgvq0f4lnflCLcrgtrDf7lLfWBWd5gno2gAkBevAGgAgAiVgHjoekAHiNewgLgK
					kJe5AhjgedkLgIkKe5AXiqezjqgCkKe5AHgkfviegAkKe5AFgAgAh6]],
				Jaw = [[
					gAkMeD/8gAgAhpf5kJd//RhrfvmhfujQdo9EkHfRstfxk4eQ/QjugDlsf4l2ev/3iIgShvgAmKe6//gAgAghgIl2ev/3d4fuhvgPk4eQ/QcSf9lsgSjQdo9D
					b5gvsugLjsdx9/dhgUq3gAjkdu91gAgArjf3lYeg/siOgKjrfzmDe2/zjYgig0fzmGe4/zjXgjgkf3lkem/yiMgNi7gAkEd5+kgAgApcgLjkdu9xdggXrcgQ
					kSeD+2cLgKnkgMkReD/RdHgWmFgCkOeD/1fagLjLgAkMeD/8gAgAhp]],
				["UpperArm.L"] = [[
					fPi9fB0lNJgAvnfLi4fDz4LUXerRfGiXfDzDMcRuolfGjafJ0USJLkg+fKkMfM0kPtOHjwfPkefL0CMfSOnKfVkNfG1ePUPXimfZjbe/2LSBNsfffZiWe50k
					L4TymxfVime8ygJ0XCqZfPihe+0DMiSKnGfKjzfJ0rS7LZf0fHkXfP0UQHNejyfHkafQzeM/RZoTfKj9fK0fPTOfkPfPi3fA1NQwNnhtfVihe80hMXSzmifZ
					i8e9zWKRWEo2fXi9e+1hMGVXnGfRi9fB1YMGcQsffPi9fB0lNJgAvn]],
				["LowerArm.L"] = [[
					e5iletADgAgAhVeti0erD6mEguuCeligexEjohkWtWemjufCGKlPoTwFepkde/IGnVlezMewkne2JXoMhL1Be3kee1H4mXj1zpe7jveyFfjvlnwke8ieehEK
					m3hwuEe3imekFmnuetwRewireqEvnnjRuieqkIfDGtkqn+xRemknfEIgnjmFzaelkje+JTpCib0gepkMe8HrnclUypewjJezEuk9moufe3irelEonGieuwe8
					jAekGqnZevyBe7jBekDflXhFtae4iuenAUiCgHj3e5iletADgAgAhV]],
				["UpperArm.R"] = [[
					gxi9fB0ly3gAvngti4e/2Iy7rzmDgniWe50k0IsPmwgnjbe/zs1UqwoHgrkNfG1ewswpimgxkefL1Lr30veBg2kMfM0kwTx5jwg6jafJyo0UsnqQg6iXfDzD
					zluRomg2imfC0jvxykizgxihe+0Dzet2nGgrj0fDz30pr+nugnkYfG1ywhwgh6gnkcfG2FsBzndWgrj+fE1ZxEwRjFgxi3fAyg1mqOqgg2iifCzkzTuenqg6
					i8fG0Sumz5hwg3i9fF0rzVsNokgyi9fC0+z0jitYgxi9fB0ly3gAvn]],
				["LowerArm.R"] = [[
					hHiletADgAgAhVhJi/elCAbcdbpzhEieehELZJeQuFhEjgemHWYng9y9hJkee1H4ZpcLzphQk0fFHncQYny+hXkde/IGYraizMhbjfe2HVW4eayIhbigexEj
					XfbqtVhWi4e2EgaYYttghQireqEvYZcvuihJj7esIHYSgJz0hFkqe0IJaBcl0JhFkye9HPc9aAzGhJkOeyHcZjcVzGhQi5epGFXugRw0hXirevE3X5b7uTha
					jPe+FjagX5vGhXjBevDpZqczs+hMiteqA5d3fvnFhHiletADgAgAhV]],
				Tail1 = [[
					gAigg8fogAgA//gBidg8fmjrgA/xgDiMg8fUmofd/SgDi2g8fojPgM/0gCjag8fud3fr/6gAjmg8fwawfC/if+jag8fub7fY/uf9i2g8fogEgA//f9iMg8fT
					jfft/yf+iUg8fbjWf2/zgAiSg8fZgAgA//gCjHg8fscrfp/0gDjig8fvcjfa/zgDjkg8fvf8f///gCjOg8ftkGgh/ugAifg8fflVf8/if+iSg8fZiKf4/6f9
					ifg8focwf+/0f+igg8fpbAf8/mgAigg8foerf//9gAigg8fogAgA//]],
				Tail2 = [[
					gAihhqeqgAgA/9gMiehpezlJgJ/jgViOhmfxrofV9zgMi3hpd6nKgo/Gf8jbhpcjdYfa/sfxjohncKWcd4+NfzjbhocmXPec+if9i3hqd4e7f8/5gHiOhpft
					nAfp/NgIiVhpfUolf7+0gAiThqfYitgB/3f4jIhpdPalfM/Zf5jjhpcUXjea+lgDjlhqcNb/ff/ggNjPhoc/kkg7/ggPighoe5p1gL+bgEiThqfanBf6/Nf0
					ighperd5f7/5fwihhoesYZfr/Cf8ihhqeqdWf5/2gAihhqeqgAgA/9]],
				Tail3 = [[
					gAikiYdkgAgA/5gaiiiUd5kvgR/kg1iOiIgMvMfg8Jggi+iScNsGhb9Vf0jliWZVfqfU/RfYj0iMYpUScl8pfbjliOZlSfdM8If6i9iXcDbWfm/ZgbiPiSf/
					oCfq+9gfiXiQfMtJgV9JgIiViXfTnSgW/JfpjRiUatbRez/KfijuiPY+UDdM8sf4jwiVYvW9eo9ygajYiUaNiRhJ/WgqijiNePsSgl9egYiViTfasFgT9nfu
					ikiWdnhggI/3fbikiQdpXofX+xf0ikiXdlcJft/qgAikiYdkgAgA/5]],
				Tail4 = [[
					gAirjFcUgAgA/xgoiojAcziigK/uhbiNihgawkfs7Xg/jJixaowfik6wf0j3jAWLkGfg+Ke8kKioVMU3bL7je7j5ioWxPIbp5MftjJjCaPWbe398gxiPi6f/
					mYfY/WhCiaive/v3g57vgciXjAfLsVhI9ffdjgi9YGekeo+7fFkDirVsTBby7BfgkFi3VhSdda65ggjpi+XbdyhE+uhKipitdYsNg89cg4iXi0fYv5g97vfy
					irjEcdmigx/GfEiri4caY6fL++fpirjDcXbZfe/cgAirjFcUgAgA/x]],
				Tail5 = [[
					gAi2jyatgAgA/jgvixjsbVfLfr/oiEiLi2gAvjfl79hmjajEY9zIkG4Uf/kSjjTIpVgM7welkqjBRsYMZu6yeYkVi1T9ODZr2tfUjZjlYaRvdm7ghDiOjlfd
					igeg/2hpiejGeVwPhY7eg9ibjhe3wTiT7afZj2jlVXjme697eqkhjBSSUwaJ59fCkhjKSbP1bt3ogZkAjlUrYcge88hqixjNb/png++OhgiajLfBxmhs6pgE
					i1jtbJrbh79bewi2jgawb5fU/Sfci2juaxbUfO/MgAi2jyatgAgA/j]],
				["UpperLeg.L"] = [[
					fHhtgL7TdNgAwbfHhqgO8FdbfRvFfGhVgW+gdAdjo1fGiGgO7QeSewwofGiugI+VeugRqGfHi9gD98dxgerCfJivgB95cqgnq4fKiGgD5dchhhzAfKhUgL9W
					bohAr5fJhegL8wcLgitdfHhbgP9dcjffr9fGiagK5VeYfqzefGi3gJ+UfYgJqNfGi6gJ+RfZgJqUfGihgJ4mekfz0ZfHhrgN8ic2fuuGfJhbgM9CcGges1fK
					hsgG6gcUhZxefJhtgH6qcjhExTfIhtgK7LdEgOwnfHhtgL7TdNgAwc]],
				["LowerLeg.L"] = [[
					fDhFf2srgwgA9XfBhFf1sWhhf49ee9g+fxpxjAgO+UfAhef6uIiQfc8nfGiTfk+ShpfUqKfGigfg9/gQfkrIfHiTfe+Be3f0q/fHhbf2syfHgd9TfIg1frmM
					fLgJ/YfFg8fuorf4gP+yfCg9fvpChAgK+rfDhuf+vyhXfa7yfFicfl+MicfJqRfFiefl+JibfJqYfDh1gBwmhQfV7UfDhIfxqcg6gG+OfFg6ftoIf4gO+8fH
					hDf0rtfJgc9wfGhEf0sCfigV9ofEhFf2sigggE9bfDhFf2srgwgA9X]],
				["Foot.L"] = [[
					fFgjgW8ngAgAuTfFgjgW8mgqfruTfFgjgW8iiCe/uRfFg5gW75hNfVvnfFh3e+ronoQI4CfFiBe9tyhAdt8wfFh0e6j9Va7+qmfFg5gW74ergwvmfFgjgW8l
					esgquSfFgjgW8mfUgWuTfFgjgW8ngSf3uTfFhGgW7jgcfvwPfFh/fAtcneSW4gfFiBfAt3nGTQ43fFhLgW7agWfzwffFgqgW8XgLf6uzfFgjgW8mfUgWuTfF
					gjgW8lesgquSfFgjgW8mfBgguTfFgjgW8nfzgHuTfFgjgW8ngAgAuT]],
				["Toe.L"] = [[
					fFgTgK/9gAgAhgfFgTgK/8gefchgfFgTgK/4hdeQhffFgngM/0g1e6i+fFhnfK0XgjOZxRfFhxfJ4Qf/df0tfFhnfJn6hp94oGfFgngM/0fGhOi+fFgTgK/7
					fEhJhgfFgTgK/8fhgmhgfFgTgK/9gNfxhgfFg0gM/xgTfljsfFhufK2NhTQfw9fFhwfK2vhURexIfFg5gN/vgPfrj/fFgagL/7gHf3iDfFgTgK/8fhgmhgfF
					gTgK/7fFhIhgfFgTgK/8fTg2hgfFgTgK/9f3gLhgfFgTgK/9gAgAhg]],
				["UpperLeg.R"] = [[
					g5htgL7TizgAwbg4hqgJ7djTffwFg2hUgL9WkYfAr7g2iGgD5djfefzAg3ivgB95jWfZq4g5i9gD98iPfirCg6iugI+VhSfvqGg6iGgO7QhuhQwog6hVgW+g
					jAidozg6hegS9ji6hcr0g5hbgP9djdghr9g3iagD33ixev1Gg2i5f+9lj8fQrfg2i8f99ij7fPrng3iigC23imeo2Lg5hrgN8ijKgSuGg6hcgT9zjBhirIg6
					htgR8Dh+hdvMg6htgP71iKhFvmg5htgM7birgOwQg5htgL7TizgAwc]],
				["LowerLeg.R"] = [[
					g9hFf2srfQgA9Xg7hDfzrff6fz92g4g1frmOg1f3/Xg5hbf2syg5fj9Tg5iTfe+BhJgMq/g6igfg9/fwgcrIg6iTfk+SeXgsqKhAhef6uIdwgk8nhDg+fxpw
					dAfy+UhBhAfxqZd6f9+Lg+g9fvpCfAf2+rg6huf9vfgdf07/g4ibfc9vh9gBrmg4idfc9th8gArug6h1gAwmgif27Vg9hIfxqcfGf6+OhBg/fxp/d3f6+UhB
					hHf4tidlga84hAhHf4tYeBgU8/g9hGf2s0fAgE9Sg9hFf2srfQgA9X]],
				["Foot.R"] = [[
					g7gjgW8ngAgAuTg7gjgW8nghfvuTg7gjgW8lhUfWuSg7g5gW74hVfQvmg7h0e6j9qmECqmg7iBe9tyfAiT8wg7h3e+roYYv44Cg7g5gW75ezgrvng7gjgW8i
					d9hBuRg7gjgW8le0gmuTg7gjgW8nfugJuTg7hGgW7ihBfawPg7h7e6mnpdHsxTg6h9e6oIonKm0ng7hLgW7ZhGfWweg7gqgW8Xf1gGuzg7gjgW8lewgouTg7
					gjgW8lepgsuSg7gjgW8me/gguTg7gjgW8nfzgHuTg7gjgW8ngAgAuT]],
				["Toe.R"] = [[
					g7gTgK/9gAgAhgg7gTgK/8gYfjhgg7gTgK/7g8e3hgg7gngM/0g6eyi+g7hnfJn6eXCIoGg7hxfJ4QgBih0tg7hnfK0XfdxnxRg7gngM/0fLhGi+g7gTgK/4
					ejhxhfg7gTgK/7fKhChgg7gTgK/9fzgPhgg7g0gM/wgsfDjsg7htfJtDe0F9tJg7hvfIvxfNI8vjg7g5gN/tgve9j+g7gagL/7f5gJiDg7gTgK/7fHhFhgg7
					gTgK/6fChLhgg7gTgK/7fSg4hgg7gTgK/9f3gLhgg7gTgK/9gAgAhg]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiggfAFgAgAh8gAiggyARgAgAj+gAigg+AdgAgAlQgAigg6AZgAgFk6gAigg0ATgAflkPgAigguARf/d/jhgAiggpANf9eTjCgAiggoAKf/fri6gAigglAI
					gBgOikgAilghAJh6f6iHgAisgfAvmefnh6gAimgfCfsLfRhzgAiSgfFDxHe9hpgAh+gfHH0AeyhhgAh7gfHc0ZexhggAiFgfGezLe1hjgAiHgfGSy7e2hkgA
					h9gfHQ0KeyhggAh6gfHj0hewhfgAh6gfHj0hewhfgAh6gfHj0hewhfgAh6gfHj0hewhfgAh6gfHj0hewhf]],
				Spine1 = [[
					gAiigLAtgAgAmlgAilgeBMgAgAojgAimgqBkgAgApzgAimgnBdgBgFpegBilggBRf8flo1gDikgZBIfseAoHgCijgVA/fteVnpgAijgUA7f8fsnigAijgQA1
					gDgOnMgAiogMAzh4fpmvgBiugLBWmWermcgCiogLDEr8dfmFgCiTgLFlwycelkgCh/gLHmznb4lIgCh7gLH6z/bzlEgCiFgLG+yzcDlRgCiHgLGzyjcGlTgC
					h9gLHvzxb2lHgCh6gLIB0IbxlDgCh6gLIB0IbxlDgCh6gLIB0IbxlDgCh6gLIB0IbxlDgCh6gLIB0IbxlD]],
				Spine2 = [[
					gAizflB5gAgAqzgAi6f6CpgAgAssgAi+gIDMgAgAt4gAi9gEDCgBgFtkgCi7f9Cwf5fms9gHi4f2CifaeEsQgGi3fwCVffeYr0gBi2fvCPf6fsrtf/i1frCH
					gFgNrZgCi5fmCBh2fhq9gIi+flCkmReRqrgOi0flETrxctqUgRiaflG3whbTpzgTiCflI6zQacpXgTh+flJOzoaUpTgSiKflIRyeaspggSiMflIFyPaxpigT
					iBflJCzbaZpWgTh9flJVzxaSpSgTh9flJVzxaSpSgTh9flJVzxaSpSgTh9flJVzxaSpSgTh9flJVzxaSpS]],
				Neck1 = [[
					gAjBfTE5gAgAw+gAjKfrHegAgA0hgAjQf6JYgAgA2ngAjOf2I2gDgE2EgCjMfuH3fxfp0/gKjIfmG6e6eTzvgIjGfgGQfGeky5gCjFfeGEf1fvytf/jEfaFo
					gIgMyGgEjHfVFChje5xFgNjLfTFElScSv/gXi/fUGIqCZRuageiifUH4uPW4sdggiHfUJWwwVnrBggiDfUJlxGVdqzggiQfUI4wBV+rdgfiSfUIwv0WFrlgg
					iFfUJcw5Vjq7ghiBfUJqxNVZqughiBfUJqxNVZqughiBfUJqxNVZqughiBfUJqxNVZqughiBfUJqxNVZqu]],
				Neck2 = [[
					gAjmfBG/gAgAz8gAjzfjJ9gAgA3LgAj6f6MGgAgA5CgAj4f0LhgDgE4kgCj1foKafvfr3mgLjxfcJUeueb2dgKjufUIke8er1tgCjtfRIXfzfw1if/jrfLH2
					gJgL0+gIjtfEHJhRei0CgcjsfAG+kUbGy0gxjXe+HnoPXGwxg+iwe9IxrxT9uIhCiNe9Jyt6SUsLhDiIe8J8uNSGr4hBiYe9JdtSSxsyhBibe9JXtGS5s8hD
					iLe9J2uCSOsDhDiGe8J/uTSCryhDiGe8J/uTSCryhDiGe8J/uTSCryhDiGe8J/uTSCryhDiGe8J/uTSCry]],
				Head = [[
					gAkKe5AFgAgAh6gAkYflBSgAgAo5gAkdgCC3gAgAtLgAkcf7CYf7gDsEgCkZfsBlgdfsp2gMkVfcBCiPeSnggKkSfRAph8eclzgCkRfOAdgYftlRf/kPfGAS
					fwgOkEgNkQe8AJh2fNiCgqkMe2AvmQdif8hKjve0CkrlcDdZhei9exFMv+bgaohkiTewHPyZbnYxhliMewHjytbqYghjigewGmxtbjZVhiikexGbxgbiZfhk
					iQewHXyhboYqhliKewHqy0brYahliKewHqy0brYahliKewHqy0brYahliKewHqy0brYahliKewHqy0brYa]],
				Jaw = [[
					gAkMeD/8gAgAhpgAkxe1//gAgAfngAlDfb/8gAgAeUf/k+fQ/9gGf/eqgEk1e9/+fegLfUgTkpeq/3dbhJf6gQkhed/5dzhKgcgDkeeZ/+flgPgrf+kYeQ/+
					gSf1hBgPkSeF/1eEgiidgxkGeA+1ZbhalRhQjfeA8LT2hWo7hdikeB4dPagJsQhdh2eC1kNJe0uKhchveC1IM2emuaheiEeC2dNxfQtnheiIeC2tN9fXtdhd
					hzeC1ZNBeuuRhchteC0/MwehughchteC0/MwehughchteC0/MwehughchteC0/MwehughchteC0/Mwehug]],
				["UpperArm.L"] = [[
					fPi9fB0lNJgAvnfPjJfY3ONgcVrUfPjQfo4dOHaDoUfPjOfk4KN9alpLfSjKfa3iNbcIqbfcjHfO2vMfegrGfajEfJ2HMffJsWfRjDfL19NEedtcfOjBfJ1e
					NReuuffTjJfEzgMRfSv5fejbfDv2KreSxvfxjffErZJsbzzbgFjNfGncJxYx0hgRi3fGlIKSWj04gTizfGk0KYWO05gOi/fGlzKGXP0zgNjBfGl/KDXb0ygS
					i2fGlAKVWa05gUiyfHktKbWG06gUiyfHktKbWG06gUiyfHktKbWG06gUiyfHktKbWG06gUiyfHktKbWG06]],
				["LowerArm.L"] = [[
					e5iletADgAgAhVe5i6e8A6gAgAnhe5jIfJCGgAgArXe5jEfGBvgBgFqXe8i9e9BIf9floXfJi2ewArf0d/mKfGiweuAaf3eTkre8iveyAUf+frkTe4ireyAM
					gBgOjPe6izewAGhjgHhhe/jIe0AelTgrgRfMjVe7BtqDh5fwfejOfDDmuTjXf3fsi/fHFLw2kXgRfui8fIFbxNkggWfnjEfGErwHkEgIfmjFfGEiv5j+gFfs
					i9fIFRxAkbgTfui7fIFgxVkjgYfui7fIFgxVkjgYfui7fIFgxVkjgYfui7fIFgxVkjgYfui7fIFgxVkjgY]],
				["UpperArm.R"] = [[
					gxi9fB0ly3gAvngxjJfY3OygjrrUgxjQfo4dx5l9oUgwjOfj4LyIlUpFgzjKfd3gyNkeq7g8jFfa2mxskOteg6jDfT2Cx8jHuWgyjCfN18yoh+t0gvjBfH1f
					y7g+uOgzi+fD1uxdemvpg3i0fA3Dt0aEwTg2iae+4Bo7Upvaguh2e930kdP7tVgmhZe93KhzNPrdglhUe83ChbM4rKgphie93ZikOAsDgphke93diyOOsOgm
					hXe83HhpNFrVglhTe82/hTMwrDglhTe82/hTMwrDglhTe82/hTMwrDglhTe82/hTMwrDglhTe82/hTMwrD]],
				["LowerArm.R"] = [[
					hHiletADgAgAhVhHi6e8A6gAgAnhhHjIfJCGgAgArXhGjFfFBvgBgFqXhKi9fBBIf9floXhVi0fCArf0d/mKhTive9Aaf3eTkrhJiue1AUf+frkThFirewAM
					gCgOjPhGiievAIiRgEhhg+iRewA9nqgQgJgrh3ezDXuMgnfGgVhYe4GyzkhHeIgHhCe6Jc2fhidigFg/e7J224hmddgLhJe6Io1qhZdtgMhLe5IZ1bhXdwgG
					hBe7Jn2phjdggEg+e7J/3AhndbgEg+e7J/3AhndbgEg+e7J/3AhndbgEg+e7J/3AhndbgEg+e7J/3Ahndb]],
				Tail1 = [[
					gAigg8fogAgA//gAichOhqgAgA/8gAiahai9gAgA/2gAiahXingIgB/4f/ibhRh8fUf8/7f8idhKhNcxfz/zf9iehGgudSf4/3f/iehFgmfff//+gAiehCgQ
					gXgA//gAilg+f3f6eG/7gAisg8fvfkZh/UgAimg8fpfIT09kgAiSg8fbexO46/gAh+g8fNekMA46gAh7g8fLeiLn4mgAiFg8fReoM15kgAiHg8fSepNF5vgA
					h9g8fMejL24ygAh6g8fKeiLf4fgAh6g8fKeiLf4fgAh6g8fKeiLf4fgAh6g8fKeiLf4fgAh6g8fKeiLf4f]],
				Tail2 = [[
					gAihhqeqgAgA/9gAiXh8gsgAgA//gAiRiHh/gAgA/7gAiTiEhpgLgB/8f9iWh+g+fEf5/9fziZh3gPblfm/rf1ichzfwcSfu/xf+ichzfofTf9/+gBiehwfR
					gfgB/+gAilhse7f1eF/6f/ithqe3fPZf/Sf+iohqevegTy9ff+iWhqeVd3O363f+iDhqd8dgMB4xf+h/hqd4ddLo4cf+iJhqeEdmM15bf+iKhqeGdoNF5mf+
					iBhqd6dfL34of+h+hqd2dcLg4Vf+h+hqd2dcLg4Vf+h+hqd2dcLg4Vf+h+hqd2dcLg4Vf+h+hqd2dcLg4V]],
				Tail3 = [[
					gAikiYdkgAgA/5gAiViqflgAgA//gAiLi1g5gAgA/+gBiOiygjgOgC//f7iTisf4e0f1/+fniZijfKaafT/efricigeqbSfe/nf8idiheifGf6/8gDigieeL
					gngD/7gAioiad5fxeE/3f9ixiYd5e8Zc/Of7itiYdud6Tt9Xf7idiXdKdBOz6pf8iMiXcmciL/4ef9iJiXcgceLn4Jf8iRiXcycqMz5Kf8iTiXc1ctNC5Wf8
					iKiXckcgL14Vf9iIiXceccLf4Bf9iIiXceccLf4Bf9iIiXceccLf4Bf9iIiXceccLf4Bf9iIiXceccLf4B]],
				Tail4 = [[
					gAirjFcUgAgA/xgAiWjYeWgAgA/8gAiJjifpgAgA//gCiMjgfTgRgE/+f3iTjaeoekfv/7fXicjOd8ZRe4/LfdigjMdcaUfJ/Xf5ihjOdSe6f2/2gFiljLc8
					gwgG/1f/iujHcsfteD/wf8i3jFcxesZW/Gf4i1jFcldZTk9Kf5iojEb4cQOr6Tf7iZjDbLbqL64Cf7iXjDbEblLj3rf6iejDbZb0Mt4vf6igjDbdb4M748f7
					iYjDbIboLw34f8iWjCbBbjLb3jf8iWjCbBbjLb3jf8iWjCbBbjLb3jf8iWjCbBbjLb3jf8iWjCbBbjLb3j]],
				Tail5 = [[
					gAi2jyatgAgA/jgAibkGcugAgA/0gAiKkQeBgAgA/7gCiOkOdrgTgF/5fziXkIdAeVfm/zfEiij4cZYLeS+wfNioj2b4ZYeq+/f2ipj7bqevfw/qgHiuj4bU
					g4gK/of/i4j0bIfreB/jf6jBjybSehZO+3f1jBjxbHdCTW80f2i4jvaUbvOc5xf6isjtZhbCLv3Xf7ipjsZZa8LY2/f5iwjtZybOMg4Hf4ixjuZ2bSMv4Vf7
					irjtZebALl3Nf7ipjsZWa7LQ23f7ipjsZWa7LQ23f7ipjsZWa7LQ23f7ipjsZWa7LQ23f7ipjsZWa7LQ23]],
				["UpperLeg.L"] = [[
					fHhtgL7TdNgAwcfHhwgX9BdOfrtKfHhygf97dQfeq8fHhygd9tdSfdrjfIhxgY9PdAgAspfKhwgO8ncKhetsfKhvgM8PcVhRuhfIhugQ8LdCgIu3fHhugQ73
					dUftvefCh6gM7dble+vxe4iUgL64Xlczu0e0iqgL5aSgads0e6iwgL3IOBY0qpfCirgL1QLZYGpLfEipgL09LCYAo9fAitgL12MJYSpne/iugL2AMXYWpvfD
					iqgL1ILPYDpFfEipgL02K6X/o4fEipgL02K6X/o4fEipgL02K6X/o4fEipgL02K6X/o4fEipgL02K6X/o4]],
				["LowerLeg.L"] = [[
					fDhFf2srgwgA9XfDhOf6wAgvgG7sfDhWf9yCgvgJ6afDhTf8xgg0gG6xfFhQf5wdgWgR7bfJhNfxvQe4g38FfIhKfxuefLgu8gfEhJf2uSgdgL8nfDhIf4tu
					g8f784e5hUf1s3gBeQ9PelhzfysIeQaA88eZiUfvrNcMUq7eebimftqDagP95MejiofrpLZlNN3VelinfrpDZeM13DegiofrpcZ2OA37efiofsphZ7OP4Fek
					iofrpIZiND3OelinfrpAZbMt28elinfrpAZbMt28elinfrpAZbMt28elinfrpAZbMt28elinfrpAZbMt28]],
				["Foot.L"] = [[
					fFgjgW8ngAgAuTfFglgR+FgAgAq5fFgqgO+zgAgAonfFgogP+ogCf8pOfGgmgP+QfzgYqZfIglgL9ufFhzrofHgkgN9afPhhsefGgkgT9Xf3gSssfFgjgV9G
					gGfztSe3gxgV81eTfJtveahUgU8caHdStJeDh8gS7LUzbNrqd/iXgQ5FQEZqp/eFifgP3UNRY6o1eHiggP3DM5Y0oreDidgP34OFZHpMeCidgP4COUZLpSeG
					ifgP3NNHY3oxeHiggP28MwYyoneHiggP28MwYyoneHiggP28MwYyoneHiggP28MwYyoneHiggP28MwYyon]],
				["Toe.L"] = [[
					fFgTgK/9gAgAhgfFgZgC/6gAgAdyfFgff9/qgAgAbZfFgdf+/vgAf7cCfGgaf//3f+gbdQfJgXf8/5f5iBemfIgWf//8f6htfgfGgVgF//f/gVfufFgUgI//
					gAfygXe1gigI/7eGf6g5eUhGgH/UZhf5ggd5hxgE9kT0gJfpdyiRgB6/O3gqe+d4icgA45MAhGepd5idf/4lLnhLemd2iagA5jM1g9eud1iZgA5vNEg7ewd5
					idf/4xL1hIeod6ief/4dLehMeld6ief/4dLehMeld6ief/4dLehMeld6ief/4dLehMeld6ief/4dLehMel]],
				["UpperLeg.R"] = [[
					g5htgL7TizgAwcg5hwgX9BiygVtKg5hygf97iwgiq8g5hygd9tizgarig5hwgb9Pijgvsug7hugc8ohvh+uDg6hugY8Ph6hou0g5hugS8Liogcu7g4hugO74
					i6f6vbgyhsgM78hKfIvhgghngL8dc+dUuDgFhagL8PXWbtrgfqhJgL67SJa+pBfbg8gL5hO/a4ngfZg6gL5SOja5nSffhAgL5+P6a4n8fhhBgL6GQLa4oEfa
					g7gL5bOza5nafYg5gL5MOZa5nOfYg5gL5MOZa5nOfYg5gL5MOZa5nOfYg5gL5MOZa5nOfYg5gL5MOZa5nO]],
				["LowerLeg.R"] = [[
					g9hFf2srfQgA9Xg9hOf6wAfRf67sg9hWf9yCfRf36ag8hUf8xgfWf26xg+hQf8wde3gE7ahChLgBvQdZgu7/hBhJf+uedsgo8bg+hJf5uSe9gF8mg8hIf2tu
					fdf485gyhGf0sseieP9RgVhFfwric3aA9EfxhBfrqGbCUo7sfTg6fooiZtP35gfEgzflndZENE3rfCgyflnTY/Mr3ZfIg1fmnxZPN44QfKg2fmn3ZTOH4afD
					gyflnYZCM53kfCgxflnPY9Mj3TfCgxflnPY9Mj3TfCgxflnPY9Mj3TfCgxflnPY9Mj3TfCgxflnPY9Mj3T]],
				["Foot.R"] = [[
					g7gjgW8ngAgAuTg7glgR+FgAgAq5g7gqgO+zgAgAong7gogP+ogCf8pOg7gmgS+QfzgYqZg8gkga9ufFhzrog8gjga9afPhhseg7gkgV9Xf3gSssg6gjgU9G
					gGfztSgsgkgU86eTfKtkgHgngS8saEdaskfagtgP7nUnbpqle4gwgM5nPvakojeogvgL33M1aMnPemgugL3lMcaKnDesgvgL4bNraSnoetgvgM4lN7aUnven
					gugL3wMqaLnKelgugL3fMTaJm/elgugL3fMTaJm/elgugL3fMTaJm/elgugL3fMTaJm/elgugL3fMTaJm/]],
				["Toe.R"] = [[
					g7gTgK/9gAgAhgg7gZgC/6gAgAdyg7gff9/qgAgAbZg7gdf+/vgAf7cCg8gagC/3f+gbdQg+gWgL/5f5iBemg9gVgM/8f6htfgg7gVgH//f/gVfug6gUgH//
					gAfygXgqgVgI/7eGf7gtgBgagE/VZhgCf3fQgjgA9iT1goefetgqf864O7hoddedgsf64wMIidc9ebgsf64bLvilc5ehgsf75aM7iMdFeigsf75mNKiHdIec
					gsf64nL9igc7eagsf64TLnioc4eagsf64TLnioc4eagsf64TLnioc4eagsf64TLnioc4eagsf64TLnioc4]],
			},
		},
	},
}
