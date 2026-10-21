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
					gAjHgiAOgAgAjkgAjIgiAOgBgIjkgAjIgiAOgCgQjkgAjJgiAOgDgYjkgAjJgiAOgEgfjkgAjKgiAOgEgmjkgAjJgiAOgFgrjkgAjJgiAOgFgvjkgAjJgiAO
					gFgwjkgAjJgiAOgFgwjkgAjJgiAOgFgwjkgAjJgiAOgFgwjkgAjFgiAOgGgzjkf8jFgiAPf6fIjkf8jEgiAPgJhOjkf/jBgiAOf6fPjkgAjEgiAOgEgfjkgA
					jFgiAOgDgYjkgAjFgiAOgCgQjkgAjGgiAOgBgIjkfGjHgiAOgAgAjkfGjIgiAOf/f4jkfGjIgiAOf+fwjkfGjJgiAOf9fojkfGjJgiAOf8fhjkfGjKgiAOf8
					fajkfGjJgiAOf7fVjkfGjJgiAOf7fRjkfGjIgiAOf6fNjkgAjIgiAOf6fLjkgAjHgiAOf6fLjkgAjGgiAOf6fLjkgAjHgiAOgAgAjkgAjHgiAOgAgAjkgAjH
					giAOgAgAjkgAjEgiAOf8fajkgAjEgiAOf8fhjkgAjFgiAOf9fojkgAjFgiAOf+fwjkgAjGgiAOf/f4jk]],
				Spine1 = [[
					gAjNgGAjgAgAlygAjOgGAkgCgIl7gAjPgGAmgDgQmCf/jPgGAngFgYmIf/jQgGAogGgfmLf/jQgGAogHglmNf/jQgGAogIgrmLf/jPgGAngJgvmIf/jPgGAn
					gJgwmHf/jPgGAngJgwmHf/jPgGAngJgwmHf/jPgGAngJgwmHf/jMgGAhgJgyljf+jLgGAgf2fJldf6jLgGAggNhNlZgAjIgGAff4fPlYf/jLgGAfgFgflZf/
					jLgGAfgEgYldgAjMgGAggDgQljgAjNgGAhgBgIlqfGjNgGAjgAgAlyfGjOgGAkf+f4l7fGjPgGAmf9fwmCfHjPgGAnf7fomIfHjQgGAof6fhmLfHjQgGAof5
					fbmNfHjQgGAof4fVmLfHjPgGAnf3fRmIfHjPgGAmf2fOmCgBjOgGAlf2fMl6gBjNgGAjf2fLlygBjNgGAif3fMlqgAjNgGAjgAgAlygAjNgGAjgAgAlygAjN
					gGAjgAgAlygBjLgGAef6fblYgBjLgGAff7fhlZgBjLgGAff8foldgAjMgGAgf9fwljgAjNgGAhf/f4lq]],
				Spine2 = [[
					gAjifQBBgAgAn9f/jjfQBGgCgIoNf/jkfQBJgEgQocf+jlfQBNgHgXonf9jmfQBPgJgeouf9jmfQBQgKgkoxf9jmfQBPgMgqouf8jlfQBNgNguonf8jlfQBN
					gNgvolf8jlfQBNgNgvolf8jlfQBNgNgvolf8jlfQBNgNgvolf8jgfPA6gMgynfgBjffPA4fzfJnTf2jefPA3gShMnLgDjbfPA1f1fPnJf9jefPA2gHgfnMf+
					jffPA3gGgYnTf/jgfPA6gEgQnff/jhfPA9gCgIntfGjifQBBgAgAn9fHjjfQBGf+f4oNfHjkfQBJf8fwocfIjlfQBNf5fponfIjmfQBPf3fioufJjmfQBQf2
					fcoxfJjmfQBPf0fWoufKjlfQBNfzfSonfKjkfQBKfzfPocgEjjfQBGfyfNoNgEjifQBCfzfMn9gEjhfQA+fzfNntgAjifQBBgAgAn9gAjifQBBgAgAn9gAji
					fQBBgAgAn9gDjefPA1f4fbnJgDjefPA2f5fhnMgCjffPA3f6fonTgBjgfPA6f8fwnfgBjhfPA9f+f4nt]],
				Neck1 = [[
					gAjwe2EogAgAwif/jye2EqgEgHwnf+jze3EtgJgOwrf9j1e3EvgNgVwuf9j1e3ExgRgbwwf8j2e3ExgUggwxf7j1e3ExgXglwwf7j1e3EwgZgpwuf7j0e3Ev
					gZgpwtf7j0e3EvgZgpwtf7j0e3EvgZgpwtf7j0e3EvgZgpwtf7jte1EjgagswZgCjse1DqfmfOuzf0jre1EtgphDwpgEjoe1EsfmfVwof9jre1EfgQgbwTf9
					jse1EggMgVwWf+jte1EigIgOwZf/jve1ElgEgHwdfGjwe2EogAgAwifHjye2Eqf8f5wnfIjze3Etf3fywrfIj1e3EvfzfrwufJj1e3ExfvflwwfKj2e3Exfs
					fgwxfKj1e3ExfpfbwwfLj1e3EwfnfXwufLjze3EuflfVwrgGjye2ErflfTwmgGjwe2EofkfSwigGjve2ElflfTwdgAjwe2EogAgAwigAjwe2EogAgAwigAjw
					e2EogAgAwigEjre1EfftffwSgDjre1EffwflwTgDjse1Egf0frwWgCjte1Eif4fywZgBjve1Elf8f5wd]],
				Neck2 = [[
					gAkhecG/gAgAz8f/kjedHDgFgH0Af+kledHGgKgN0Ef9kmeeHJgPgT0Hf8kneeHKgUgY0Jf7kneeHLgYgd0Kf6kneeHKgbgi0Jf6kmeeHJgegl0Hf6kmeeHI
					gegm0Gf6kmeeHIgegm0Gf6kmeeHIgegm0Gf6kmeeHIgegm0Gf5keebG5gggozzgEkaeVF0fgfSyWfykcecHGgxg90CgFkZebHFfhfZ0Cf8kceaG1gTgZzvf9
					kdeaG3gPgTzxf+keebG5gKgNz0f/kfebG8gFgHz4fGkhecG/gAgAz8fHkjedHDf7f50AfIkledHGf2fz0EfJkmeeHJfxft0HfKkneeHKfsfo0JfLkneeHLfo
					fj0KfMkneeHKflfe0JfMkmeeHJfifb0HfNkledHGfgfY0EgHkjedHDfffX0AgHkhecHAfffWz8gHkfebG8fffXz3gAkhecG/gAgAz8gAkhecG/gAgAz8gAkh
					ecG/gAgAz8gFkbeaG1fpfizugEkceaG1ftfnzvgDkdeaG3fxftzxgCkeebG5f2fzz0gBkfebG8f7f5z4]],
				Head = [[
					gAlOeSALgRiyhZf/lQeTAMgQi4hmf+lSeTANgOi6h3f9lTeUAOgNi3iKf8lUeVAPgLividf7lUeVAPgKikivf6lUeVAPgJiUi9f5lTeUAPgIiAjGf5lTeUAP
					gIh8jHf5lTeUAPgIh8jHf5lTeUAPgIh8jHf5lTeUAPgIh8jHf5lLeQAHgBf8iigFlFeFAWjIeTdKfxlKeSAheflKhsgGlGeRBLj+YxiFf7lJePAGf0eQhcf9
					lKePAHfyd6hTf+lLeQAIfwdohPf/lNeRAKfvdZhRfGlOeSALfvdOhZfHlQeTAMfwdIhmfIlSeTANfydGh3fJlTeUAOfzdJiKfKlUeVAPf1dRidfLlUeVAPf2
					dcivfMlUeVAPf3dsi9fNlTeUAPf4eAjGfNlSeUAOf5eWjKgHlQeTAMf6evjHgIlOeSALf7fLi/gIlNeRAJf9fniygAlOeSAGgAgAiNgAlOeSAGgAgAiNgAlO
					eSAGgAgAiNgFlIePAGgJhYhqgFlJePAGgMhwhcgDlKePAHgOiGhTgClLeQAIgQiYhPgBlNeRAKgRinhR]],
				Jaw = [[
					f1lVdU/PgadQmSf0lYdV/OgedKmWfylbdW/OghdJmUfylddX/QgjdMmNfxlfdY/TgkdUmCfxlhdY/WgidglzfxlhdY/bgfdvljfylhdX/fgaeClTfylhdX/f
					gZeGlQfylhdX/fgZeGlQfylhdX/fgZeGlQfylhdX/fgZeGlQf5lWdS/pf+gEkugLk7dI61ccgFxCfdlRdX/HimbTlJgilMda8sZTkzrggClQdR/efzhwlfgF
					lQdR/ZfxiGlvgHlRdS/VftiYl+gJlTdT/SfqimmKfRlVdU/PfmiwmSfSlYdV/Ofii2mWfTlbdW/Offi3mUfUlddX/Qfdi0mNfVlfdY/TfcismCfVlhdY/Wfe
					iglzfVlhdY/bfhiRljfUlhdX/ffmh+lTfTlgdX/ifsholEgMledW/mfyhQk3gLlcdV/of4g1kvgJlZdT/pf9gZksgAlZdU/+gAgAhGgAlZdU/+gAgAhGgAlZ
					dU/+gAgAhGgAlQdR/igKeolOf+lQdR/egNeQlff7lQdR/ZgPd6lvf5lRdS/VgTdol+f3lTdT/SgWdamK]],
				["UpperArm.L"] = [[
					fFjhef01MnfNukfEjjef1LMsequKfDjleg1ZMxePt3fCjmeg1hM1d/tvfBjneh1hM4d6tzfAjneh1ZM6eAuDe/jnei1KM8eRude/jmei01M9esu/e+jmei0x
					M9eyvGe+jmei0xM9eyvGe+jmei0xM9eyvGe+jmei0xM9eyvGe+jdehy7NFhHxffIjceb1PMQfStfe3jaejxpNjiZzIfKjXeb2cMidirnfBjaegzLM5g/xAfC
					jbegzjMzgmwffCjdefz/MugJv4fEjfef0bMqfqvOeLjhef01MnfNukeMjjee1LMle1t/eNjlee1bMjemtjeOjmee1kMhegtSePjned1kMeektNePjned1dMa
					eztVeQjned1OMWfLtoeRjmec04MRfquFeRjlec0dMOgNunfMjjec0AMMgyvLfMjheczjMMhUvtfMjfeczJMNhwwLfFjhefqtLmS9x8fFjhefqtLmS9x8fFjh
					efqtLmS9x8fKjaecy2MWh9wqfJjaeczJMYhlwafIjbedziMbhEwCfHjdedz/MegdvkfGjfee0bMif1vD]],
				["LowerArm.L"] = [[
					emjDeA5EzuidgRekjGd/5Fzpi6ffejjJd/5FzmjEfFeijLd/5Gzni6fFehjMeA5HzqicffegjMeB5GzxhtgQefjLeD5Cz3gyhTeejIeE45z8fvigeejIeF42
					z8fhiweejIeF42z8fhiweejIeF42z8fhiweejIeF42z8fhiweei4eM33zycJm5eri/d540zxgnj/eXizeV3bzwa+ntetjBd15AztjKgoehi3eJ4jz6eUksei
					i5eH4yz6fZjheji8eE49z4ghiTeki/eC5Cz0hkhLdsjDeA5EzuidgRdtjGd+5DzpjHfpdujJd85CznjefZdwjLd75BzojgfjdxjMd75BzrjNgGdyjMd75Bzv
					ipg/dzjLd74+zyh2iIdzjId844zzg5jbd0jFd94uzwf6kveujCd/4gzqe+l8eui+eA4SzjeLm7eui7eC4HzddonleQjoed9poZYhbzeQjoed9poZYhbzeQjo
					ed9poZYhbzeri2eE4XzpeSmbeqi3eE4lzwfElTepi5eD4yz1f/j/eoi8eB48z2g7ioeni/eA5CzzhxhW]],
				["UpperArm.R"] = [[
					g7jhef01zZgzukg6jjee1LzbhLt/g5jlee1bzdhatjg4jmee1kzfhgtSg3jned1kzihctNg2jned1dzmhNtVg2jned1Ozqg1tog1jmec04zvgWuFg1jmec0z
					zvgPuLg1jmec0zzvgPuLg1jmec0zzvgPuLg1jmec0zzvgPuLg1jdecy2zxd8whg/jcei12y6i6tagujaea2ozliarDhAjXehwvyicczrg3jaeczJzoebwag4
					jbedzizle8wCg5jdedz/zifjvkg6jfee0bzegLvDgBjhef01zZgzukgCjjef1LzUhWuKgDjleg1ZzPhxt3gEjmeg1hzLiBtvgFjneh1hzIiGtzgGjneh1ZzG
					iAuDgHjnei1KzEhvudgHjmei01zDhUu/gIjlei0czCg0vlhCjjei0BzAgQwLhCjheizly+fuwuhCjfeizNy8fQxLg7jhefqt0atDx8g7jhefqt0atDx8g7jh
					efqt0atDx8hAjaegy6zCewxYg/jaegzLzHfBxAg+jbegzjzNfawfg+jdefz/zSf3v4g8jfef0bzWgWvO]],
				["LowerArm.R"] = [[
					hajDeA5EMSdjgRhZjGd+5DMXc5fphYjJd85CMZcifZhWjLd75BMYcgfjhVjMd75BMVczgGhUjMd75BMRdXg/hTjLd74+MOeKiIhTjId844MNfHjbhTjId842
					MOfTjshTjId842MOfTjshTjId842MOfTjshTjId842MOfTjshTi4eD4CMmiqn4hgjDeA4/MHfuhmhKjFdy49MTcuhLhgiueW3SMdlJohhWi3eE4lMQg8lThX
					i5eD4yMLgBj/hYi8eB48MKfFiohZi/eA5CMNePhWggjDeA5EMSdjgRgijGd/5FMXdGffgjjJd/5FMac8fFgkjLd/5GMZdGfFgljMeA5HMWdkffgmjMeB5GMP
					eTgQgnjLeD5CMJfOhTgojIeE45MEgRiggojFeG4rMDhVjwhijCeI4bMEiTk7hii+eK4KMIjGl5hii7eL39MMjomkhwjoed9pXnnfbzhwjoed9pXnnfbzhwjo
					ed9pXnnfbzhgi2eL4SMJiolshfi3eJ4jMGhskshei5eH4yMGgnjhhdi8eE49MIffiThci/eC5CMMechL]],
				Tail1 = [[
					gAjKhCeIgAgA/8gAjLhCdngygE/5gBjMhCdKhjgJ/0gBjMhCcyiRgP/vgBjNhCcki8gU/qgBjNhCcfjigZ/mgBjNhCclkCgc/jgCjMhCc0kcgd/hgCjMhCc4
					khgd/ggCjMhCc4khgd/ggCjMhCc4khgd/ggCjMhCc4khgd/ggCjJhCfIkxgI/nf6jIhCffi2gD/3f/jIhCfukmgD/qf9jEhCf0iMgB/6gBjIhCfui9gC/2gB
					jIhCffiSgC/6gBjJhCfHhjgD/8gAjJhCeqgygC/9fGjKhCeIgAgA/8fGjLhCdnfOf8/5fFjMhCdKedf3/0fFjMhCcydvfx/vfFjNhCckdEfs/qfFjNhCcfce
					fn/mfFjNhCclb+fk/jfEjMhCc0bkfj/hfEjMhCdMbRfl/gf+jLhCdpbFfo/hf+jKhCeKbAft/if+jJhCerbEfz/lgAjKhCeIgAgA/8gAjKhCeIgAgA/8gAjK
					hCeIgAgA/8f/jIhCf0cdf//yf/jIhCfudDf+/2f/jIhCffduf+/6f/jJhCfHedf9/8gAjJhCeqfOf+/9]],
				Tail2 = [[
					gAjPhqeib2f0/rgCjRhqeGctf8/wgEjThqdkdqgE/0gGjUhpc9ergL/0gIjVhpcXftgS/ygKjVhob0gwgZ/tgLjVhobZhygf/mgMjUhobHixgl/fgMjUhobF
					i9gm/dgMjUhobFi9gm/dgMjUhobFi9gm/dgMjUhobFi9gm/dgNjLhocamOg0/KgCjKhqc/k7gq/dgKjIhpdpnKg0/FgDjFhqeJlQgp/fgIjIhqelmagp/TgG
					jJhqe2mEgj/YgEjLhqe7lkgc/egCjNhqe0k7gU/lfGjPhqeikKgM/rfEjRhqeGjTgE/wfCjThqdkiWf8/0fAjUhpc9hVf1/0e+jVhpcXgTfu/ye8jVhob0fQ
					fn/te7jVhobZeOfh/me6jUhobHdPfb/fe5jThobCcVfX/YfyjRhobIbgfS/SfyjPhobbazfP/OfyjNhob3aOfN/LgAjPhqc8gAgA/2gAjPhqc8gAgA/2gAjP
					hqc8gAgA/2f2jIhpeLZafS/Pf4jIhqelZmfX/Tf6jJhqe2Z8fd/Yf8jLhqe7acfk/ef+jNhqe0bFfs/l]],
				TailCube1 = [[
					ftjbi6hlb2gN/rf0jci6g5c+gP/1f4jhi6gIeMgR/8f/jmi5fWfcgT/+gGjqi4engugU/8gNjti3eCh+gV/3gUjvi2dpjKgV/vgajvi1dekSgU/mgbjvi0de
					kfgT/kgbjvi0dekfgT/kgbjvi0dekfgT/kgbjvi0dekfgT/kgsjgiyf5n1gE/BgWjVi3grmbgD/VgtjQiyhZohf8+zgejVi3h/mdgB/RgqjSi0iXnZf5/Cgl
					jSi2ihm1f4/JgjjTi2icmFf2/UgbjVi4iHlMf0/ffbjZi5hlkKfz/rfVjdi6g5jCfx/1fOjhi6gIh0fv/8fHjmi5fWgkft/+e/jqi4enfSfs/8e5jti3eCeC
					fr/3exjxi2dpc2fr/vesjvi1debufs/menjuizdkatfu/dfcjsizd5Z1fx/UfZjpiyebZHf1/MfWjkiyfHYjf4/GgCjhi7gAgAgA//gBjfi7gAgAgA//gCjg
					i7gAgAgA//fVjUi0h+YOgF+9fYjSi1iXYngH/CfbjSi2ihZLgI/JfgjTi3icZ7gK/UfljVi4iHa0gM/f]],
				TailCube2 = [[
					ffjgj3iEatgP/efnjmj3hKcDgP/ufxjrj3gIdegR/5f9jzj3fFe+gT/9gJj6j1eIgggV/7gUj/jzdXiAgX/0gfkCjxc2jegZ/pgqkDjucpk1gZ/cgrkDjucp
					lGgZ/ZgrkDjucplGgZ/ZgrkDjucplGgZ/ZgrkDjucplGgZ/ZhJjrjpf4pSgE+ngpjhjzg7oAgB+9hIjXjqh3qHf3+Sg1jVjxiooFf8+1hEjUjtjIo/fz+ig+
					jVjwjVoWfx+tg8jUjwjNnhfx+7gvjXj0iymffx/Nfrjdj2iElTfx/efgjkj3hKj9fx/ufVjrj3gIiifv/5fJjzj3fFhCft/9e9j6j1eIfgfr/7ezkBjzdXeA
					fp/0emkEjwc2cifn/peckDjucpbLfn/ceTkCjscyZ7fp/PfFj/jqdOY1fs/De/j5jpd8X7fw+4e6jyjpe3XNf2+vgCjqj4gAgAgA//f/jqj4gAgAgA//gCjs
					j4gAgAgA//e4jXjrioWngL+de7jUjtjIXBgN+ifBjTjvjVXqgP+tfIjUjxjNYfgP+7fRjXj0iyZhgP/N]],
				TailCube3 = [[
					fOjSkui3ZFgT/GfajYkvh1acgT/cfojjkxgob8gU/uf5jukxfXdigX/4gLj5kweJfNga/7gckBktdHg6ge/2gskGkqcYikgh/rg7kIkmb/kKgj/dg+kIklb9
					kegj/ag+kIklb9kegj/ag+kIklb9kegj/ag+kIklb9kegj/ahqjjkZfap4gN+bhFjRklgro0gH+vhrjLkYh3rHf798hWi+kei4pSf++ehjjAkbjmqUfx+Eha
					jAkfj+p0fu+MhXjBkgj+pEft+ahGjGknjmoGft+vf+jOkri3m7ft/GfujYkvh1lkft/cfejjkxgokEfs/ufNjukxfXiefp/4e7j5kweJgzfm/7eskDktdHfG
					fi/2eakHkqcYdcff/reLkIkmb/b2fd/dd9kGkicAaWfd/OeskBkfcaZAff/Aeij5kcdLX1fk+zebjvkaeNW3fr+mgBjkkzgAgAgA//f+jkkzgAgAgA//gDjj
					kzgAgAgA//eYjGkZi4VbgK+DedjBkbjmVsgP+Eeli/kfj+WMgS+MeujBkij+W8gT+ae6jGknjmX6gT+v]],
				TailCube4 = [[
					e4jVlgjoX2gZ+tfIjflkiqZCga/Gfajulmhbaagb/dfxj9lmgDb7ge/ugIkMlkeqdjgj/3gekXlgdZfQgo/3g0kflbcag9gt/xhIkilVbxipgx/lhMkilUbs
					i+gx/jhMkilUbsi+gx/jhMkilUbsi+gx/jhMkilUbsi+gx/jiJjylEeqpSgd+lhnjclRgBodgS+2iNjYlEharBgF+Ah4i6lIiopcgE+diGjClHjmqtf097h4
					jBlPkOqcfu98h4jClOkcp6fr+FhhjGlYkPpJfo+WgVjRlejooKfn+tgBjeljiqm+fm/Gfsjulmhblmfl/dfVj9lmgDkFfi/ue+kMlkeqidfd/3eokZlgdZgw
					fY/3eTkelccafDfT/xd+kilVbxdXfP/ldskglQbjbwfN/YeWkalMbxaPfO/LeJkPlIcaY4fS++d+kClGdaXsfa+xgCjylpgAgAgA//f/jvlpgAgAgA//gDjv
					lpgAgAgA//d1jKlFioVRgD+Bd7jClIjmVTgM97eEi/lMkOVkgS98eQjAlRkcWGgV+FefjGlYkPW3gY+W]],
				TailCube5 = [[
					ehjBmKkHXpgf+mezjRmPjVYlgh+8fJjhmUiOZugj/Sfkj1mXg5bAgn/lgAkImWfecbgr/xgckYmTeGd8gx/3g3kjmOc7fhg4/1hQkomHcEhGg9/thVkomGb8
					hag+/rhVkomGb8hag+/rhVkomGb8hag+/rhVkomGb8hag+/riljvlvd6nzgt+8h8jNl/fOnHge/LivjOlpgpp3gS+biVitlvh/odgK+yikiwlsjIp9f4+PiU
					isl0j+p6fv+KiUislykcpnfo+Lh7iyl+kfpGfj+Vgti+mGkHoXfh+mgWjOmOjVnbff+8f9jhmUiOmSfd/Sfij1mXg5lAfZ/lfGkImWfejlfV/xeqkZmTeGiE
					fP/3eRkkmOc7gffI/1d2komHcEe6fD/tdeknmBbmdXe//jeEkgl7bkb4e+/ZdzkTl2b+agfB/PdlkClycyZRfI/GgDjrmbgAgAgA//gBjnmbgAgAgA//gBjm
					mbgAgAgA//dWi6lqh/WPf7+ZdciwlsjIWDgI+Pdmiqlwj+WGgR+Kd0irl2kcWZgY+LeFiyl+kfW6gd+V]],
				TailCube6 = [[
					eLjBm0kFYmgn+2efjVm7jkZVgq/Ee3jmnAisaPgr/WfWj+nDhjbSgt/mf1kVnDgQcdgx/ygWkpm/e8dtg2/4g1k3m5dvfBg8/4hSk/mxcwgXhD/zhYk/mwcm
					gohE/yhYk/mwcmgohE/yhYk/mwcmgohE/yhYk/mwcmgohE/yi6kBmWdemPg6/QiKjdmrellego/ejIjZmQf5oPgc+6iritmZhLm2gP/Oi/izmUiXocf8+xix
					ismajUoffu+qixirmZj9oVfk+oiViwmmkOn+fd+shFi9mwkFnafZ+2gsjQm5jkmrfW/EgPjmnAislxfV/Wfwj+nDhjkufT/mfQkVnDgQjjfP/yevkqnAe8iT
					fK/4eVk4m5dvg/fE/4d0k/mxcwfpe9/zdYk/mqcHeUe4/sd6k4mjb3dCe1/kdkkqmecBb1e2/cdTkXmZclave8/WgDj2nKgAgAgA//f/jxnKgAgAgA//gCj0
					nKgAgAgA//c7jAmRhLX1f0+5dAiymTiXXkgE+xdKirmXjUXhgS+qdYiqmdj9Xrgc+odriwmmkOYCgj+s]],
				["UpperLeg.L"] = [[
					e6iAgO7ceDf6wUe6iBgO7ZeJf0wae6iBgP7WeQfvwfe6iCgP7VeWfpwie6iCgQ7Vebfkwie6iDgQ7Xeefewfe5iCgR7behfZwYe5iCgR7iejfUwNe5iCgR7j
					ejfTwLe5iCgR7jejfTwLe5iCgR7jejfTwLe5iCgR7jejfTwLe5h+gR8GecfIvLe4h+gK7MeEg5wte1h9gT8afMe7uqe6h6gK7wdrgjvue6h9gQ8EePfYvOe6
					h+gP79eMfgvbe6h+gP70eJfovse6h/gO7peGfxv/eAiAgO7ceDf6wUeAiBgN7PeAgEwqeBiBgM7Cd9gMw+eBiCgM63d6gVxPeBiCgL6ud2gcxceBiDgL6pdz
					gixkeBiCgL6mdvgmxneBiCgK6odsgpxkeBiBgK6sdpgrxee7iBgK6ydngsxUe7iAgK66dlgrxHe7h/gK7Cdkgpw6e6iAgO7ceDf6wUe6iAgO7ceDf6wUe6iA
					gO7ceDf6wUe7h9gL7ddpgYwQe7h9gL7gdtgSwLe7h+gM7hdygMwKe7h+gM7gd3gGwLe6h/gN7fd9gAwP]],
				["LowerLeg.L"] = [[
					e4hbf6tMhDgD9Ie3hcf6thhLgA8+e3hdf7t0hTf980e3hdf8uEhaf68se3hef8uRhhf38me2hef9uXhof18ie2hef9uZhuf08he2hef9uVhzfz8ie2hef9uU
					h0fz8je2hef9uUh0fz8je2hef9uUh0fz8je2hef9uUh0fz8je1hcf6tWh7f59Ae3hZf3sBgzg/9neyhcf7tajBgh84e4hXf1q9gigj+De2hbf5s3hnf+9Pe2
					hbf5s4hfgA9Qe3hbf5s8hWgB9Oe3hbf5tDhNgC9Ld9hbf6tMhDgD9Id+hcf6tVg5gE9Ed+hcf6tegwgG9Ad+hcf6tkgngI89d/hcf7tngfgJ88d/hcf6tmgY
					gL89d/hcf6tggTgN9Ad/hcf6tVgPgO9Fd/hbf5tIgMgP9Le6hbf5s4gLgQ9Se6haf4sogLgR9Ze6haf4sYgMgR9fe4hbf6tMhDgD9Ie4hbf6tMhDgD9Ie4hb
					f6tMhDgD9Ie5hZf3sBgdgO9pe5hZf3sIgkgN9me4haf4sUgrgL9he4haf4skgzgI9ae4hbf5s3g7gG9R]],
				["Foot.L"] = [[
					e6g5gY8VgDf+u2e6g5gY8VgKf7u2e6g5gY8VgQf4u2e6g5gY8VgWf0u2e6g5gY8Vgcfxu2e6g5gY8Vghfvu2e6g5gY8Vgmfsu2e6g5gY8Vgrfqu2e6g5gY8V
					gsfpu2e6g5gY8Vgsfpu2e6g5gY8Vgsfpu2e6g5gY8Vgsfpu2e6g5gY8Ugzflu2e6g5gY8Vf+gBu2e6g5gY8Rh2fCu0e6g5gY8VfsgLu2e6g5gY8Vgjfuu2e6
					g5gY8Vgcfyu2e6g5gY8VgUf2u2e6g5gY8VgMf6u2eAg5gY8VgDf+u2eAg5gY8Vf7gDu2eAg5gY8VfzgHu2eAg5gY8VfrgLu2eAg5gY8VflgOu2eAg5gY8Vff
					gRu2eAg5gY8VfagUu2eAg5gY8VfXgVu2eAg5gY8VfVgXu2e6g5gY8VfUgXu2e6g5gY8VfUgXu2e6g5gY8VfVgWu2e6g5gY8VgDf+u2e6g5gY8VgDf+u2e6g5
					gY8VgDf+u2e6g5gY8VfkgOu2e6g5gY8VfqgMu2e6g5gY8VfwgIu2e6g5gY8Vf2gFu2e6g5gY8Vf9gCu2]],
				["Toe.L"] = [[
					e6gogM/8gCf9hte6gogM/8gHf3hte6gogM/8gLfyhte6gogM/8gPfshte6gogM/8gTfnhte6gogM/8gXfihte6gogM/8gbfehte6gogM/8gefahte6gogM/7
					gefZhte6gogM/7gefZhte6gogM/7gefZhte6gogM/7gefZhte6gogM/7gjfThte6gogM/8f/gChte6gogM/4hReXhte6gogM/8fygShte6gogM/8gYfhhte6
					gogM/8gTfnhte6gogM/8gOfuhte6gogM/8gIf2hteAgogM/8gCf9hteAgogM/8f8gFhteAgogM/8f3gMhteAgogM/8fygShteAgogM/8ftgYhteAgogM/8fp
					gdhteAgogM/8fmgihteAgogM/8fkglhteAgogM/8fignhte6gogM/7fignhte6gogM/7fignhte6gogM/8fjgmhte6gogM/8gCf9hte6gogM/8gCf9hte6go
					gM/8gCf9hte6gogM/8ftgZhte6gogM/8fxgUhte6gogM/8f1gOhte6gogM/8f5gJhte6gogM/8f+gDht]],
				["UpperLeg.R"] = [[
					hGiAgO7ch9gGwUhGiBgN7PiAf8wqhFiBgM7CiDf0w+hFiCgM63iGfrxPhFiCgL6uiKfkxchFiDgL6piNfexkhFiCgL6miRfaxnhFiCgK6oiUfXxkhFiCgK6o
					iUfWxjhFiCgK6oiUfWxjhFiCgK6oiUfWxjhFiCgK6oiUfWxjhFh+gK7KicfawthDh+gR8LiHhMu9hAh9gI67jPfSw9hFh6gR8oh8hFuGhFh9gL7giTfuwLhF
					h+gM7hiOf0wKhFh+gM7giJf6wLhGh/gN7fiDgAwPgMiAgO7ch9gGwUgMiBgO7Zh3gMwagMiBgP7WhwgRwfgMiCgP7VhqgXwigMiCgQ7VhlgcwigMiDgQ7Xhi
					giwfgMiCgR7bhfgnwYgNiCgR7ihdgswNgNiBgR7phdgwwAhHiBgR7yheg0vyhHiAgR76hfg2vjhHh/gR8Bhig4vWhGiAgO7ch9gGwUhGiAgO7ch9gGwUhGiA
					gO7ch9gGwUhGh9gQ8JhuguvGhGh9gQ8EhxgovOhGh+gP79h0ggvbhGh+gP70h3gYvshGh/gO7ph6gPv/]],
				["LowerLeg.R"] = [[
					hIhbf6tMe9f99IhIhcf6tVfHf89EhIhcf6tefQf69AhHhcf6tkfZf489hHhcf7tnfhf388hHhcf6tmfof189hHhcf6tgftfz9AhHhcf6tVfxfy9FhHhcf6tT
					fyfx9GhHhcf6tTfyfx9GhHhcf6tTfyfx9GhHhcf6tTfyfx9GhHhZf3sMfxfv9lhIhcf6tXeog29BhDhYf2rpg1gT9yhKhZf4sPeQgS9ghHhZf3sIfcfz9mhI
					haf4sUfVf19hhIhaf4skfNf49ahIhbf5s3fFf69RgOhbf6tMe9f99IgPhcf6the1gA8+gPhdf7t0etgD80gPhdf8uEemgG8sgPhef8uRefgJ8mgQhef9uXeY
					gL8igQhef9uZeSgM8hgQhef9uVeNgN8igQhef8uNeJgN8mhKhdf8uBeGgM8shLhdf7tzeEgL8zhLhcf7tleEgJ85hIhbf6tMe9f99IhIhbf6tMe9f99IhIhb
					f6tMe9f99IhKhbf5s6eSgD9OhKhbf5s3eZgC9PhKhbf5s4ehgA9QhJhbf5s8eqf/9OhJhbf5tDezf+9L]],
				["Foot.R"] = [[
					hGg5gY8Vf9gCu2hGg5gY8VgFf9u2hGg5gY8VgNf5u2hGg5gY8VgVf1u2hGg5gY8Vgbfyu2hGg5gY8Vghfvu2hGg5gY8Vgmfsu2hGg5gY8Vgpfru2hGg5gY8V
					gpfqu2hGg5gY8Vgpfqu2hGg5gY8Vgpfqu2hGg5gY8Vgpfqu2hGg5gY8Vgofru2hGg5gY8VfygHu2hGg5gY8ShofJu0hGg5gY8VfYgVu2hGg5gY8VgWf0u2hG
					g5gY8VgQf4u2hGg5gY8VgKf7u2hGg5gY8VgDf+u2gMg5gY8Vf9gCu2gMg5gY8Vf2gFu2gMg5gY8VfwgIu2gMg5gY8VfqgMu2gMg5gY8VfkgPu2gMg5gY8Vff
					gRu2gMg5gY8VfagUu2gMg5gY8VfVgWu2gMg5gY8VfRgYu2hGg5gY8VfPgau2hGg5gY8UfNgbu2hGg5gY8UfMgbu2hGg5gY8Vf9gCu2hGg5gY8Vf9gCu2hGg5
					gY8Vf9gCu2hGg5gY8VfYgVu2hGg5gY8VfdgSu2hGg5gY8VfkgOu2hGg5gY8VfsgKu2hGg5gY8Vf0gGu2]],
				["Toe.R"] = [[
					hGgogM/8f+gDhthGgogM/8gEf7hthGgogM/8gJf0hthGgogM/8gOfuhthGgogM/8gTfohthGgogM/8gXfjhthGgogM/8gafehthGgogM/8gcfbhthGgogM/8
					gdfbhthGgogM/8gdfbhthGgogM/8gdfbhthGgogM/8gdfbhthGgogM/8gcfchthGgogM/8f3gMhthGgogM/5hIejhthGgogM/8fkgkhthGgogM/8gPfshthG
					gogM/8gLfyhthGgogM/8gHf3hthGgogM/8gCf9htgMgogM/8f+gDhtgMgogM/8f5gJhtgMgogM/8f1gOhtgMgogM/8fxgUhtgMgogM/8ftgZhtgMgogM/8fp
					gehtgMgogM/8flgihtgMgogM/8figmhtgMgogM/7fggqhthGgogM/7fegshthGgogM/7fdguhthGgogM/7fcguhthGgogM/8f+gDhthGgogM/8f+gDhthGgo
					gM/8f+gDhthGgogM/8fkgkhthGgogM/8fogfhthGgogM/8ftgZhthGgogM/8fygShthGgogM/8f4gKht]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAi3giAGevgOhygAi6giAGe/hAhwgAjAgiAHfahnhwgAjGgiAIf7h9hxgAjHgiAIgeh9hzgAjDgiAIg7hnh0gAi9giAHhOg/h1gAi4giAGhUgNhzgAi4giAG
					hLfYhxgAi9giAHg1eqhwgAjDgiAIgWeLhwgAjHgiAIfzeBhygAjGgiAIfTeMh0gAjAgiAHe6erh1gAi6giAGetfZh0]],
				Spine1 = [[
					f/i6gFAQewgSjnf+i9gFARe+gvjuf9jDgFATfYhDkDf8jJgFAVf5hLkWf9jKgFAWgbhGkcf9jHgFAVg4g1kQf+jAgFAShLgbj7gAi7gFAQhSf9jqgBi7gFAQ
					hLffjogDjAgFASg2fGj4gDjGgFAUgYe3kNgEjKgFAWf2e2kbgDjJgFAWfWfBkYgCjDgFATe9fXkGgBi9gFARewfzjx]],
				Spine2 = [[
					f+jHfNAgexgXlZf7jKfNAje6gelqf5jSfNAqfRggmTf4jZfOAxfwgbm4f5jafOAzgQgRnBf7jWfOAugtgEmof9jOfNAmhDf5l+gAjIfNAhhOfulegEjIfNAh
					hMflldgGjOfNAmg8fgl9gIjVfOAughfimogIjafOAzgAfpnBgGjZfOAxfgf1m4gEjSfNAqfHgCmUgBjLfNAje2gNlr]],
				Neck1 = [[
					f9jRexDne8guurf6jUexDdfGgxuYf4jdeyD7fcgsvSf3jlezExf5gfwxf4jnezFdgVgKx1f7jiezFdgsfzx0f+jZeyExg8fhwvgBjSexD6hEfWvQgFjSexDd
					hBfQuXgHjYeyDngwfQutgJjhezEVgWfZwBgIjnezFLf4frxagHjlezFjffgCx/gEjeeyFLfLgXxYgAjVexEUe/glv+]],
				Neck2 = [[
					f5j+eRGGfDg3ytf2kBeQGIfOg5yxf1kLeUGlfjgxzZf2kWeaHLf9gg0Kf5kaeeHggWgI0kf9kVeeHVgqfv0WgBkKeZGyg4fbzqgFkAeTGQg+fNy7gJj+eQGD
					g5fHyqgLkGeSGUgofJzCgLkReXG5gQfWzzgJkaedHZf2fs0bgFkZefHfffgF0igBkQebHGfOgc0Cf9kFeWGffEgtzR]],
				Head = [[
					f1kqeCAHevgPiMfzkteCAIe1fyibfyk4eIAKfKfYizf1lEeRALfpfEjEf5lIeWAMgKe6jEf+lDeVAKgpe9iygEk3eNAIhAfMiagJkseFAHhOfkiMgMkqeBAI
					hQf/iRgOkyeEAJhCgbingNk+eMALgngzi9gJlHeUAMgGhCjHgElGeWALfmhGi8f/k9eRAJfLg9ilf6kxeJAIe3gpiR]],
				Jaw = [[
					f0k0dE/ehSgFlifzk4dE/YhEghmIf0lEdK/Zgpg1mCf4lRdT/igHhAlUf9lVdZ/qfmhCkcgDlPdX/tfKg5kAgHlCdQ/re2gmkRgLk2dH/jetgKlGgNk0dD/a
					ezfsl5gNk9dH/XfIfUmLgKlLdP/dfofElugFlVdX/mgKe+k3gAlTdZ/sgpfBkJf7lJdU/thBfPkDf3k7dL/ohQfnkp]],
				["UpperArm.L"] = [[
					fDi5edwDOCl/0KfAi9eewhN8lXz5e9jIeexoNkj0y7e8jTeey6NFhzxce8jXeez9Mof6vze+jTee0mMRehuafBjLed05MAdvtefFjEec1AL2dctAfIjDec1B
					Lydjs7fLjKec08L3eBtQfNjSec0qMEe8uFfNjWec0BMYgYvafMjTecy8MziOxDfKjIecxnNTkGynfHi+edwfNylgzu]],
				["LowerArm.L"] = [[
					eniNeW2F0BauqWekiReV2v0SbvowegieeQ3z0cdxl2editeJ4u0KgXiXedi2eD5Nzei6fOeei3d+5Vysk3dCegiyd75WyJl+b/ekitd55ax+mOb+eoitd55g
					yKlvcyerixd55jyokkeSeui2d75ZzPi0gcevi2d/48zygljLeuiteF4F0DeNmJetifeN3C0BcJoweriSeT2Oz7a4qU]],
				["UpperArm.R"] = [[
					g5jDec1B0Nijs6g2jGec0/0MiRtCg0jOeb010DhltmgzjVec0ZzzgausgzjVeczizcevwNg1jOecySy+c0x3g4jDecw/ydbHzPg7i6edwKyEaH0Cg/i6edwL
					x+aM0HhCjCeexByObUzfhEjOeeySysdLyOhEjWeezezKfMwnhDjWee0Uzkg3vEhAjPed0yz4h9t4g9jHed0+0GietM]],
				["LowerArm.R"] = [[
					haisd5GjyBmEjuhWiud5GeyXlPikhTi0d6Ggy7jwguhRi3d9GzzihveQhRiyeCHdz9fYbVhSimeJIc0EdGYdhUiYeQJcz9bYWThXiOeVJ9z8apVehaiOeWJr
					0JbFWQheiXeSIw0acpYlhiimeMHt0XfCb5hjizeGG/z2hrfUhji4eAGtzEj+iBhhi1d9GryYlhjoheivd6GpyBmMkI]],
				Tail1 = [[
					gAi+hCaniZha/agBjBhCY2gahO/JgDjHhCYTebgq/AgEjNhCZUcvgE/HgEjOhCbPbkft/UgEjKhCczbIfb/cgDjDhCc9bhfE/hgBi+hCbncwer/ff/i/hCZp
					eleo/Sf+jEhCYYgnfC/Df9jKhCYoiffq/Cf8jOhCaPj7gJ/Of8jMhCcJkwgc/Zf9jHhCdFkygv/ff+jAhCcbj9hK/h]],
				Tail2 = [[
					gFjLhnaKo7hJ+IgCjShmXgmPg1+Mf/jZhlVHihgZ9+f8jdhlUiebfq90f5jahmWMame198f4jShnZBXpeV+Cf4jLhnbGWHeX9+f6jKhnbBWTes+Cf9jOhmY7
					YQfB+NgAjWhlWLbjfX+GgDjchlUifif893gFjchmVHjlgx92gIjWhnXknChf+AgIjOhnaRpVhu+AgIjKhobWqChg9/]],
				TailCube1 = [[
					gyjuikdEpAgS+jggj7imZpnJgQ+hgKkQiiW/kJf4+af1kWihW2gdfQ+ofekKijZYcpe5/GfQj1ilc7ZXfG/IfKjoimfCXOfh+vfMjmimeXWqfv+jfaj2imba
					Xwfu+kfokJiiYFaPf5+dgBkVihWidpgc+dgVkTiiX2hfg/+4gqkCijbMlHhE/MgzjvimeSn5gs+8g2jlimfDpRgV+m]],
				TailCube2 = [[
					hUkFjTdunigR/Ag7kbjVZbmcgc+ogZk6jOWEkVf9+Gf4lAjPV3hhfA+SfUkvjVZBeZeg/Je2kNjZdcbee9/jeqj2jagHZWfr/Seqj3jYfUYaf3/Ee+kSjXbp
					Y3fm+4fTkzjNXdahft+Vf4lAjNVgdBgh+EgZk6jSXGgChX+sg8kejZbRjJhY/dhQkAjbfKlugq/dhYjzjZgKnTgJ/J]],
				TailCube3 = [[
					hykIkGeylXgP/ghOktkJZ6kjgy/EgolVj/VpjBgb+Hf+ldkBU2hBfN99fLlBkMYGezeZ+7elkNkSdQcte1/reSjukPgybMfy/nePjxkMgbalgA/heokekMcf
					a8fc/Ye+lJj/XfcKfQ+lftlej/Utd8gJ93gYlTkHWCgFhW+XhGkqkRaqiThi/ahlj8kRfbkKgr/thyjrkNhIlQf+/i]],
				TailCube4 = [[
					iGkZk3f3jrgM/xhblMk1a7ifhH/egwmBkiV7g8hI+UgDmKkiUNfQf29ufKllk2W+dqen+keekjlEcbcXex/jeCj5lDgybvfz/sd9j9k/hPb9gI/teYk1k8dp
					c3fV/vexlwklYMeRes+8fmmLkeUhf6fa92gWl9krVEhkg5+AhLlKk+ZljDhg/KhykLlFe+kDgv/tiEj0lBhkkRf4/q]],
				TailCube5 = [[
					iTkQloghjZgH/zhmlUlmcEhZhQ/sgymZlOWzfPhv+lgAmnlMUOdOgq9mfFl4lmWHbnfH+FePkkl2bSaqey/Kd0julzgIarfq/idwjxlvhebxgK/reKkxlten
					dkfW/3epl+lWZTfseV/PfnmnlJVAhzep99gamYlXUnjqgL9qhWlYluYfk+hR+qh/kGl2d/leg2/ciRjnlwhWk5f8/l]],
				TailCube6 = [[
					igkamVggktgJ/phqlrmQc4h4hJ/wgum8lvX5e3h6+3f4nPllU3cChO9se7mcmDV3Zzfr9sd/k+mbaSYie4+jdlj6mffEYnfa/Gdkj5mdhCaIf//beDk/mafD
					cqfc/zepmfl6aWfoeW/cftnOlkV9ineQ+Ngjm/lwU1lMfj9hhil3mQXzm/g6+GiOkYmgc3nng++5ifjvmdgimzgN/Q]],
				["UpperLeg.L"] = [[
					fAhpgW3Edbgc2Be/hsga4/dafnzze9h0gd7/dZepvOe6h8ge+zdedLnxe4iAge/meBbphje2h+gd/perbkfce1h5ga/zexcugKe0h1gX/weaeVjGe2h0gT/Z
					d1fYlve4h4gQ+wdTgOoYe6h8gO9cc8hCsFe9h+gN79cwhfvJe/h6gO62crhkxAfAhzgQ59cvhXyWfBhsgT4wc+g+0B]],
				["LowerLeg.L"] = [[
					e8g/gUiSfTfX/5e6hEgQe8gKfD/9e2hSgGfkhafJ/8exhpf6lSjKf9/Zesh9f2s2kzhZ83eqiAf1yGlKie5wesh5fx0+kbin3newhtfu2KjHiI2xezhmfs0m
					h4hy4We2hjfsxYgwhc6ze6hffwvAfvhA8Pe8hbf2s9fAgp9Oe+hVf8qOengR+Se+hMgCmuejf3/Pe+hDgKjle0fk/x]],
				["Foot.L"] = [[
					e6g5hC8Secg1u1e6hHg+7ufQgbv7e6hTg07Ugcfvwpe6hagl7Bh6ezw/e6hcgU61jUd6w+e6hXgD66j0dowte6hOf27TjWeBwOe6hAfv77iOeyvZe6g5f08U
					hCfdu1e6g5f/8Vf+gBu2e6g5gK8UfBghu1e6g5gV8SeWg4u0e6g5gg8Qd9hFu0e6g5gr8Qd2hIuze6g5g28ReAhDu0]],
				["Toe.L"] = [[
					e6gog2/5e7hahte6g2g0/2fggti9e6hBgq/wgSfljxe6hIgc/ohPeHkNe6hJgL/diJcukRe6hFf6/bifcQkAe6g8fs/kiOczjZe6gvfk/zhhd9iYe6gofo/7
					gufFhte6gofz/8f/gChte6gof+/7fVg4hte6gogJ/5e3hfhte6gogV/3emh1hte6gogg/2egh7hte6gogr/3eohyht]],
				["UpperLeg.R"] = [[
					hLh0gV/dh1g3lchKh2gS/KiegPmzhHh6gP+Ki6fWqOhEh+gN8rjLestxhCh9gN7WjUecwMhAh3gO6ajUehxrg/hvgR5ajLe0zIg/hqgU39i1fT0/hAhqgY36
					ilf+1GhChwgb6Xing2x5hFh4ge9liniBruhHh/ge/aiVjtkKhJiAge/nhmkmgDhLh8gc/uhNj9fghMh3gZ/1hYighW]],
				["LowerLeg.R"] = [[
					hOhmfu2YdmeP2qhMhkfsy6eseX5uhIhhfuwGfyey7nhFhdfzuAgrfM8vhDhYf5rthPfj9vhChRf+ohhdf8+zhChHgFlBhXgU/khDhAgPiog+gj/3hFhBgTgN
					gUg1/+hIhKgMepfSg+/8hMhdf/h1dygk/2hRh1f3pNb7fX+WhViAf2v0a2d+7QhVh9fzzybHdX4hhShzfw1ucMdl3C]],
				["Foot.R"] = [[
					hGg5fu8Secg0u1hGg5f58VfggRu2hGg5gE8Vgifuu2hGg5gQ8ThXfTu1hGg5gb8Rh5fBu0hGg5gm8QiJe4uzhGg5gx8QiHe5uzhGg5g88Sh0fDu0hGhAhB7/
					hNfWvbhGhOg67ggNf4wVhGhXgt7Je3guw3hGhcgc66dVhsxBhGhagL61cTiVw3hGhTf87EcUiQwghGhHfy7mdKhpv2]],
				["Toe.R"] = [[
					hGgofj/5e7hZhthGgofu/8fqgchthGgof5/8gXfihthGgogE/6g8ezhthGgogP/4hTeUhthGgoga/2heeGhthGgogl/2heeHhthGgogw/4hQeZhthGgvg2/3
					g0e5iYhGg8gw/zgJf0jahGhFgk/tfQhIkChGhJgT/jeRiqkRhGhIgC/adnjqkLhGhBfz/edljljvhGg2fo/seGiri8]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAjDgiABgAgAgLgAisgiACgQhKgLgAixgiAEgXhpgLgAjIgiACgQhKgLgAjDgiABgAgAgLgAisgiACfwe2gLgAixgiAEfpeXgLgAjIgiACfwe2gL]],
				Spine1 = [[
					gAjDgFAIgAgAiuf+isgFAGgUhJh8f9ixgFAIgehniHf+jIgFALgXhIi4gAjDgFAIgAgAiugCisgFAGfse3h8gDixgFAIfieZiHgCjIgFALfpe4i4]],
				Spine2 = [[
					gAjNfMAcgAgAlOf6izfMAQgYhIjsf3i5fMAUgkhlkBf6jTfMAhgdhGljgAjNfMAcgAgAlOgGizfMAQfoe4jsgJi5fMAUfcebkBgGjTfMAhfje6lj]],
				Neck1 = [[
					gAjXewE7gAgAxCf4i6evDcgwg7uVf1jBewDxhFhSu8f4jdexFUg2g1xmgAjXewE7gAgAxCgIi6evDcfQfFuVgLjBewDxe7euu8gIjdexFUfKfLxm]],
				Neck2 = [[
					gAkIeYIFgAgA1Pf2jneOGLg5gyy1fyjueRGmhRhGzXf3kQebIkg+gr1vgAkIeYIFgAgA1PgKjneOGLfHfOy1gOjueRGmeve6zXgJkQebIkfCfV1v]],
				Head = [[
					gAk2eTAUgAgAkaf2kTeAAKgVgii3fykbeEAMgfgwjNf4k+eXAYgbghkvgAk2eTAUgAgAkagKkTeAAKfrfei3gOkbeEAMfhfQjNgIk+eXAYflffkv]],
				Jaw = [[
					gAlJdX/0gAgAjVf0kfdC/bf1fZl+fvkpdH/qftfKkif2lSdc/7fsfah5gAlJdX/0gAgAjVgMkfdC/bgLgnl+gRkpdH/qgTg2kigKlSdc/7gUgmh5]],
				["UpperArm.L"] = [[
					fFjDecspOHnj2Ee7imehpkQMph4Ue3itejqYQMou4Re7jLegtcOlmU2VfFjDecspOHnj2EfPikeZpGOoqk29fTireXpyOBqR2VfOjJeYtONOnn06]],
				["LowerArm.L"] = [[
					emiYef5Cz0hmhWedh+ez4rzzdzkNeZiFez44zxeEjHecigej5SzjhVf2emiYef5Cz0hmhWevh7em4dz1fqlqe0iBeh4gz5gslKewieeW40z6jJhP]],
				["UpperArm.R"] = [[
					g7jDecspx5Yd2EgxikeZpGxYVc29gtireXpyx/Vv2VgyjJeYtOyyYZ06g7jDecspx5Yd2EhFimehpkv0Wf4UhJitejqYv0XS4RhFjLegtcxbZs2V]],
				["LowerArm.R"] = [[
					haiYef5CMMeahWhRh7em4dMLgWlqhMiBeh4gMHfUlKhQieeW40MGc3hPhaiYef5CMMeahWhjh+ez4rMNiNkNhniFez44MPh8jHhkigej5SMderf2]],
				Tail1 = [[
					gAjNhBeThxfu/5gCi2hBa0fxgB/kgDi7hBbYd5gJ/lgCjShBe3dTgf/2gAjNhBeTePgS/5f+i2hBa0gPf//kf9i7hBbYiHf3/lf+jShBe3itfh/2]],
				Tail2 = [[
					gEjRhogtl0fj/cgCjDhndujMfk/vf+jGhnayergG/if8jVhodza9gH/gf8jRhogtaMgd/cf+jDhnduc0gc/vgCjGhnayhVf6/igEjVhodzlDf5/g]],
				TailCube1 = [[
					gojUi0julwfA/PgSjQi2ftkufd/of4jhi0d0g7gE/5fijii1h6clgw/vfYjPizjuaQhA/PfujQi2ftbSgj/ogFjoizd0fFf8/5gejii1h6jbfQ/v]],
				TailCube2 = [[
					hDjTjukUkOev/Zgljbjxe0k0fm/mf+j4jvdLiigB/wfUjljziwe1g7/1fEjMjvkUbyhR/Zfbjbjxe0bMga/mf+kBjudLdef//wgsjljziwhLfF/1]],
				TailCube3 = [[
					hXi+khlQh+eX/dg2jYkpedjWfs/xgFj/kpcHirgG/pfRjTkqjCgghE/0e8i1kklQeChp/dfKjYkpedcqgU/xfvkHkmcHdVf6/pgvjTkqjCfge8/0]],
				TailCube4 = [[
					hhi4lYmNgOeF/UhBjqldeyhIfy/8gRkalYbFhQgT/lfSjWliisgthF/2eyiqlZmNfyh7/Ue/jqldeye4gO/8fnkhlXbFewft/lgujWliisfTe7/2]],
				TailCube5 = [[
					hjibmCm1f6eC/MhFjmmPfrfXf3/+gXkomIadfEgo/ffVjGmSh1fUg9/6e3iUmGm1gGh+/Me7jmmPfrgpgJ/+fekpmJadg8fY/fgrjGmSh1gsfD/6]],
				TailCube6 = [[
					hoiRmxm6hLeU/KhDjym+gzfBf6/9gRlFmvagdSg8/YfTjMnCgydGgu/1e1iMm2m6e1hs/Ke9jym+gzg/gG/9fdlBmyagiufE/YgtjMnCgyi6fS/1]],
				["UpperLeg.L"] = [[
					e6h5gd1eeDgd3oe5hjgi1ue+fM3ce5hpgk6neyW1Q3e5h/gi/1fIeFiRe6h5gd+AelghrAe8hhgY/zcjfefle9hmgW6hc6hexje8h9gYrre4iE9s]],
				["LowerLeg.L"] = [[
					e3hQghdThBf7/3e2g6glLDjrhq31emiLgUGUXdc3PQe0h6f5D0cXfWRWe6hef9CCe5gaU6e7hifuPAgYfsE6e8hAgGdsgffmAHe7hhg2UXgcfqCO]],
				["Foot.L"] = [[
					e6hYhO7cgNf4wce6hngr6WmNcGwme6hmgA53oGa7wPe6hVff7VjKeIwNe6hAfa8/gNf6tie6g5gC8Ue1gou1e6g5gz8Ueygpu1e6hChY5Yezgzzb]],
				["Toe.L"] = [[
					e6hGhEAYf7gOkze6hVgiA5dCmug8e6hUf3Bvawn/cAe6hDfVAad6jBcpe6gxfNABf3gLfxe6gof3AGg0e9eTe6gogoAEgwe2hFe6guhTAfgPellT]],
				["UpperLeg.R"] = [[
					hGh5gd+AhbffrAhEhhgY/zjdgiflhDhmgW6hjGeixjhEh9gYrrhId89shGh5gd1eh9fj3ohHhjgi1uhCg03chHhpgk6nhOpLQ3hHh/gi/1g4h7iR]],
				["LowerLeg.R"] = [[
					hGhef99+e5garGhFhifuxAgYfs7GhEhAgGiUgffm/5hFhhg2rpgcfq9yhJhQghdTe/gF/3hKg6glLDcVeW31haiLgUGUojjJPQhMh6f5D0jpgqRW]],
				["Foot.R"] = [[
					hGhAfa8/fzgGtihGg5gC8UhLfYu1hGg5gz8UhOfXu1hGhChY5YhNfNzbhGhYhO7cfzgIwchGhngr6WZzj6wmhGhmgA53X6lFwPhGhVff7Vc2h4wN]],
				["Toe.R"] = [[
					hGgxfN//f3gLgPhGgof3/6g0e9hthGgogo/8gwe2e7hGguhT/hgPelathGhGhE/of7gObNhGhVgi/HdCmufEhGhUf3+Rawn/kAhGhDfV/md6jBjX]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAjKgiAOgAgAjkgAjEgnARgAgAj8gAi2gxAZgAgAk2gAiog8AjgAgAl0gAighCApgAgAmUgAjNgDAEgAgAhzgAjifbACgAgAfHgAjifbACgAgAfHgAjifbAC
					gAgAfHgAjhfgABgAgAfagAjafzABgAgAglgAjSgLAFgAgAiHgAjLgdAMgAgAjRgAjKgiAOgAgAjkgAjKgiAOgAgAjkgAjKgiAOgAgAjk]],
				Spine1 = [[
					gAjQgGAjgAgAlygAjLgKAlgAgAmBgAi/gVAsgAgAmjgAiyghA0gAgAnIgAisgnA5gAgAnbgAjQfmATgAgAkOgAjhe+AGgAgAiMgAjhe+AGgAgAiMgAjhe+AG
					gAgAiMgAjgfDAHgAgAicgAjbfVAMgAgAjYgAjWfuAWgAgAkngAjRgBAggAgAljgAjQgGAjgAgAlygAjQgGAjgAgAlygAjQgGAjgAgAly]],
				Spine2 = [[
					gAjlfQBBgAgAn9gAjhfUBDgAgAoCgAjWfgBGgAgAoNgAjMftBJgAgAoZgAjGf0BKgAgAoggAjfeuAtgAgAmmgAjpeFAdgAgAlPgAjpeFAdgAgAlPgAjpeFAd
					gAgAlPgAjpeKAfgAgAlagAjoedAngAgAmIgAjme2A0gAgAnEgAjlfKA+gAgAnygAjlfQBBgAgAn9gAjlfQBBgAgAn9gAjlfQBBgAgAn9]],
				Neck1 = [[
					gAjze2EogAgAwigAjve7FBgAgAxLgAjlfHGDgAgAysgAjafUHPgAgA0PgAjVfaH5gAgA1BgAjreTDggAgAuhgAjydpBygAgAqfgAjydpBygAgAqfgAjydpBy
					gAgAqfgAjyduB8gAgAq6gAjzeBClgAgAsigAjzecDjgAgAungAjzewEZgAgAwJgAjze2EogAgAwigAjze2EogAgAwigAjze2EogAgAwi]],
				Neck2 = [[
					gAkkecG/gAgAz8gAkhejHqgAgA0wgAkae1JagAgA2ogAkRfILagAgA4egAkMfTMhgAgA5YgAkYdzFbgAgAxygAkVc9CsgAgAsygAkVc9CsgAgAsygAkVc9Cs
					gAgAsygAkWdDC6gAgAtTgAkbdbD5gAgAvRgAkgd7FYgAgAxugAkjeVGpgAgAzggAkkecG/gAgAz8gAkkecG/gAgAz8gAkkecG/gAgAz8]],
				Head = [[
					gAlReSAGgAgAiNgAlPecAPgAgAjsgAlIe1A3gAgAnTgAk+fQB/gAgArCgAk5ffCwgAgAs7gAlDdhADgAgAhTgAk3ceAVgAgAbhgAk3ceAVgAgAbhgAk3ceAV
					gAgAbhgAk5clARgAgAb+gAlBdCAGgAgAdtgAlLdqABgAgAgAgAlQeJAEgAgAhwgAlReSAGgAgAiNgAlReSAGgAgAiNgAlReSAGgAgAiN]],
				Jaw = [[
					gAlbdU/+gAgAhGgAlfdf//gAgAgUgAlld+/8gAgAeVgAloei/vgAgAb+gAloe2/lgAgAa7gAlKci8fgAgAujgAknbh9NgAgAtCgAknbh+ogAgApOgAknbh+V
					gAgAqLgAkrbo++gAgAn/gAk6cD/ggAgAlkgAlMcr/0gAgAjSgAlYdL/9gAgAhigAlbdU/+gAgAhGgAlbdU/+gAgAhGgAlbdU/+gAgAhG]],
				["UpperArm.L"] = [[
					fFjjef0OMmgAvafFjfej0vMMeVuEfFjWev1mL3aAqufFjMe814MkVVnPfFjGfD1yNXS7lgfFjad92gMgacqPfFjfdV3FNDbzqrfFjfdV3FNDbzqrfFjfdV3F
					NDbzqrfFjfdZ27M/cFrAfFjhds2QMzdLsTfFjieF1RMpent7fFjjeZ0cMmfuvHfFjjef0OMmgAvafFjjef0OMmgAvafFjjef0OMmgAva]],
				["LowerArm.L"] = [[
					emjDeC42z4gAjXekjFeD5hzKiKgiehjKeK5xwVnKZieejReY36ryrlSpedjTei2Ko4tZPdejjNdW52yniwfAemjOct4dzzeRlhemjOct4dzzeRlhemjOct4d
					zzeRlhemjNcy4fzzeZlXemjKdI4mz2e2kzemjGdl4vz3fbkEemjEd840z4f5jgemjDeC42z4gAjXemjDeC42z4gAjXemjDeC42z4gAjX]],
				["UpperArm.R"] = [[
					g7jjef0OzagAvag7jfej0vz0hruEg7jWev1m0JmAqug7jMe814zcqrnPg7jGfD1yyptFlgg7jad92gzglkqPg7jfdV3Fy9kNqrg7jfdV3Fy9kNqrg7jfdV3F
					y9kNqrg7jfdZ27zBj7rAg7jhds2QzNi1sTg7jieF1RzXhZt7g7jjeZ0czagSvHg7jjef0OzagAvag7jjef0OzagAvag7jjef0OzagAva]],
				["LowerArm.R"] = [[
					hajDeC42MIgAjXhcjFeD5hM2d2gihfjKeK5xPrY2ZihijReY36UOUbSphjjTei2KXISnPdhdjNdW52NZdQfAhajOct4dMNhvlhhajOct4dMNhvlhhajOct4d
					MNhvlhhajNcy4fMNhnlXhajKdI4mMKhKkzhajGdl4vMJglkEhajEd840MIgHjghajDeC42MIgAjXhajDeC42MIgAjXhajDeC42MIgAjX]],
				Tail1 = [[
					gAjNhCeIgAgA/8gAjGhHdugAgA/6gAi3hScugAgA/0gAinhdbqgAgA/sgAiehjbGgAgA/ngAjUgjZjgAgA/VgAjuf5ZueagI/UgAjuf5cMepgA/vgAjuf5cM
					hXgA/vgAjsf+crjMgC/qgAjjgSeMiugK/0gAjYgrfSgegD/+gAjPg+fafVf8/+gAjNhCehfwf//9gAjNhCeIgAgA/8gAjNhCeIgAgA/8]],
				Tail2 = [[
					gAjRhqc8gAgA/2gAjMhubwgAgA/tgAi/h5Y3gAgA/LgAixiDV3gAgA+VgAiqiJUVgAgA9ygAjjhHVpgAgA+Rf8j+geYkc1gJ+9f9j4ggdgdSf6/xgDj4ggdg
					iugG/xgIj0gleOmTgU/UgHjog5gElZgi/hgBjahSgug9gI/+f+jRhlfxeqf0/9f/jQhqdsfgf9/5gAjRhqc8gAgA/2gAjRhqc8gAgA/2]],
				TailCube1 = [[
					gGjpi7gAgAgA//gCjfi+dthqgA/3gAjljCcIiNft/rgAjljEZ3hRfq/Xf6jijFWzfjgI+of9kTiJXreHgZ+1fsklhlcQayg2/VfvkHhwhZcZgQ/wgUkKhvfw
					jnf8/ygikDhygnoYf9+3gijqiGkBnTf++4gGjYilkOhbgE/rf8jUi4hxdWfv/1f9jfi7gidSf7/3gAjji7hHeWgE/7gGjpi7gAgAgA//]],
				TailCube2 = [[
					gLj2j4gqeegC/8gLjvj5cvh2gC/xgJj+j7bsj+fj/cgFkGj5a8jZfI/Zf6kQjxXBgqfy+sfxk9i3Wodege+efYk9ibcUY0hF+7fhkMitigaYgW/ZgkkYirfh
					i5f+/2hAkRipfmpZgT+kg+jli+kcpYgH+QgMjSjjlLjPgO/ZfzjVj2hIdoft/4fyjnj5ftb1fy/tf6jpj5h8cIgF/sgLj2j4gqeegC/8]],
				TailCube3 = [[
					gLjwkzhtcQgH/ugMj4kzcTgegM/xgXkGkzawkWfo/QgSkQkxbolNeu/Pf2kokmX3itfH+zfnlUjtV0eagJ+Se+lBjQbuYAhB+qfNj7jhjdYWgb+3g0kYjjf+
					g6f//+hekKjbelo2gm+thejPjqkOqjgX96gXi4kWmOlagY+6fojNkuhJfWfx/9fjjgkxenb8fp/sfsjbkwiKajgC/cgLjwkzhtcQgH/u]],
				TailCube4 = [[
					gBj2lpiwakgN/ZgMkNlmcjeRgd/wglkjlgZqjJf8/Mgkkqlfbqlweq/JgAlLlQY/kjed+1fnl/kRVngZfe+Qeklbj6arYxgq+sezj8kTj5XZgc+jg3khkZg8
					exgC/9h1kckLd+nBg1/IiAjOkWjcqMgl+IgqiwlKm/mxge+efnjalmhzhkf0/5fWjylkdqdifg/zfZjglkhuadf8/dgBj2lpiwakgN/Z]],
				TailCube5 = [[
					f0jjmXjaaSgT/SgLkPmZdacegw/rgvkvmRY3hAgZ/Kg2kvmOa+kue5/OgSlVl/Z9lNeI+7fkmTlBWGiVey+TeNljknZnatgJ+5eajok7jqYAgd+wgtkQlKiC
					dngF/1iJkVk7eCk3g9/iiei9k7iaoegr+vg+iVlwnNmlgZ+dfvjOmWi3jGfz/tfOjymWdQfxfW/3fIjTmSgxb5f5/tf0jjmXjaaSgT/S]],
				TailCube6 = [[
					fpjlnGjZblgc/ggFkjnFehcDg7/sgxlOm1YrfHg0/HhElIm1Z3iqfU/RghlvmkaWkTeQ/Jfmm6lfXDjJea+gd/l/lKY+cyfq/CeDjplki0Z3gh/RglkTl5i3
					eFgK/ziSkslmevjlg+/wi2jCllhgmTgt/UhRiLmbmylAgF+3f5jQnFj6jFft/mfOkFnCdhhafM/2e8jdnAfqeHf4/7fpjlnGjZblgc/g]],
				["UpperLeg.L"] = [[
					e6iDgO7BeJgAxBe6h+gQ8Jd9fyvFe6hxgX+JdofSqae6hlge/edZetk8e6hegi/ydVeVhne6iEf21/eogm3Le6iZfbvbfZhH8Ae6iZfbvbfZhH8Ae6iZfbvb
					fZhH8Ae6iXfevqfYhG73e6iRfswyfVhF7Ne6iJf92Bewgp3Ke6iEgK6ReOgHyKe6iDgO7BeJgAxBe6iDgO7BeJgAxBe6iDgO7BeJgAxB]],
				["LowerLeg.L"] = [[
					e4hdf7t+hAgA8xe3hbf5s9hGgH9Oe3hYf2rkhRgX9ze2hYf2rvhZgn9ue2haf4srhdgv9Ve5hbf4svgtfv9Ve6h1fxvWgTfd8Ee6h1fxvWgTfd8Ee6h1fxvW
					gTfd8Ee6hzf0vmgUfd77e6hrf+wugVfe7Re5hgf/vRgqfs8Ge4hdf7t6g9f88ze4hdf7t+hAgA8xe4hdf7t+hAgA8xe4hdf7t+hAgA8x]],
				["Foot.L"] = [[
					e6g5gY8VgAgAu2e6g5gY8VgHf9u2e6g5gY8VgTf2u2e6g5gY8Vgdfxu2e6g5gY8Vggfvu2e6g5gY8VftgKu2e6hPgK19flgd3Qe6hPgK19flgd3Qe6hPgK19
					flgd3Qe6hMgM2kfkgd2qe6hCgT5Tfegazle6g5gY8VfpgMu2e6g5gY8Vf9gCu2e6g5gY8VgAgAu2e6g5gY8VgAgAu2e6g5gY8VgAgAu2]],
				["Toe.L"] = [[
					e6gogM/8gAgAhte6gogM/+gFf6hMe6gogM//gMfuf6e6gogM/9gRfleie6gogM/6gTfhd1e6gogM/hf3gTame6g6gL/4f/goije6g6gL/4f/goije6g6gL/4
					f/goije6g4gM/5f9goiWe6gvgO/+f0gpgye6gogM/9fygWege6gogM/+f+gDhDe6gogM/8gAgAhte6gogM/8gAgAhte6gogM/8gAgAht]],
				["UpperLeg.R"] = [[
					hGiDgO7Bh3gAxBhGh+gQ8JiDgOvFhGhxgX+JiYguqahGhlge/einhTk8hGhegi/yirhrhnhGiEf2/HirhMm2hGiZfb+uiijLYEhGiZfb+uiijLYEhGiZfb+u
					iijLYEhGiXfe/AimjAZLhGiRfs/yiuiKfLhGiJf9+tifg+oihGiEgK8BiCgMvThGiDgO7Bh3gAxBhGiDgO7Bh3gAxBhGiDgO7Bh3gAxB]],
				["LowerLeg.R"] = [[
					hIhdf7t+fAgA8xhJhbf5s9e6f59OhJhYf2rkevfp9zhKhYf2rvenfZ9uhKhaf4srejfR9VhKhzfRr+ehff9ohMite34Gd/e306hMite34Gd/e306hMite34G
					d/e306hMipe528eEe52MhLiTfCyGeUfJ6ThKh0fZtyeofk81hJhhf0tie6f689hIhdf7t+fAgA8xhIhdf7t+fAgA8xhIhdf7t+fAgA8x]],
				["Foot.R"] = [[
					hGg5gY8VgAgAu2hGg5gY8Vf5gDu2hGg5gY8VftgKu2hGg5gY8VfjgPu2hGg5gY8VfggRu2hGhTfy+wfWgMoxhGiAex+OeufkVohGiAex+OeufkVohGiAex+O
					eufkVohGh7e4+tevfpXJhGhpfT/9e8f+fQhGhQf2+dfhgKpwhGg+gR8tf6gDuHhGg5gY8VgAgAu2hGg5gY8VgAgAu2hGg5gY8VgAgAu2]],
				["Toe.R"] = [[
					hGgogM/8gAgAhthGgogM/+f7gGhMhGgogM//f0gSf6hGgogM/9fvgbeihGgogM/6ftgfd1hGhIfg9wfmgjUThGiMehvfewgiEDhGiMehvfewgiEDhGiMehvf
					ewgiEDhGiGemxaezgkFNhGhqe+5TfJgnMehGhEfl/NfqgZZBhGgugE//f8gGgOhGgogM/8gAgAhthGgogM/8gAgAhthGgogM/8gAgAht]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAjKgiAOgAgAjkgAjGgiALgAgAjKgAi9giAGgAgAiOgAi2giADgAgAhdgAi3giAEgAgAhmgAjHgiARgAgAj+gAjQgiAlgAgAl/gAjRgiApgAgAmVgAjRgiAp
					gAgAmVgAjRgiApgAgAmVgAjRgiApgAgAmVgAjRgiApgAgAmVgAjRgiApgAgAmVgAjRgiApgAgAmVgAjRgiApgAgAmVgAjRgiApgAgAmVgAjRgiApgAgAmVgA
					jRgiApgAgAmRgAjOgiAdgAgAlUgAjLgiARgAgAkAgAjKgiAOgAgAjkgAjKgiAOgAgAjkgAjKgiAOgAgAjk]],
				Spine1 = [[
					gAjQgGAjgAgAlygAjLgGAdgAgAlOgAjBgFARgAgAj9gAi5gFAJgAgAi6gAi6gFALgAgAjGgAjOgGAqgAgAmWgAjbgHBWgAgApIgAjdgHBfgAgAplgAjdgHBf
					gAgAplgAjdgHBfgAgAplgAjdgHBfgAgAplgAjdgHBfgAgAplgAjdgHBfgAgAplgAjdgHBfgAgAplgAjdgHBfgAgAplgAjdgHBfgAgAplgAjdgHBfgAgAplgA
					jcgHBdgAgApggAjYgHBFgAgAoMgAjSgGAqgAgAmZgAjQgGAjgAgAlygAjQgGAjgAgAlygAjQgGAjgAgAly]],
				Spine2 = [[
					gAjlfQBBgAgAn9gAjefPA2gAgAnQgAjPfNAhgAgAlpgAjDfMAUgAgAkVgAjFfMAWgAgAkkgAjlfRBOgAgAorgAj7fXCagAgAsJgAj+fYCpgAgAstgAj+fYCp
					gAgAstgAj+fYCpgAgAstgAj+fYCpgAgAstgAj+fYCpgAgAstgAj+fYCpgAgAstgAj+fYCpgAgAstgAj+fYCpgAgAstgAj+fYCpgAgAstgAj+fYCpgAgAstgA
					j9fYCngAgAsngAj1fUB9gAgAq/gAjpfRBPgAgAougAjlfQBBgAgAn9gAjlfQBBgAgAn9gAjlfQBBgAgAn9]],
				Neck1 = [[
					gAjze2EogAgAwigAjre0D2gAgAvLgAjZexCWgAgAsAgAjLewBagAgApUgAjOewBjgAgApzgAj0e3FCgAgAxNgAkPfCJHgAgA2VgAkTfEJ1gAgA3DgAkTfEJ1
					gAgA3DgAkTfEJ1gAgA3DgAkTfEJ1gAgA3DgAkTfEJ1gAgA3DgAkTfEJ1gAgA3DgAkTfEJ1gAgA3DgAkTfEJ1gAgA3DgAkTfEJ1gAgA3DgAkTfEJ1gAgA3DgA
					kTfDJtgAgA28gAkIe+HtgAgA00gAj4e4FVgAgAxpgAjze2EogAgAwigAjze2EogAgAwigAjze2EogAgAwi]],
				Neck2 = [[
					gAkkecG/gAgAz8gAkZeWFwgAgAyRgAkAeKDXgAgAuPgAjqeCB4gAgAqvgAjueDCHgAgArYgAknegHqgAgA0wgAlHfAOLgAgA6jgAlLfGPUgAgA7TgAlLfGPU
					gAgA7TgAlLfGPUgAgA7TgAlLfGPUgAgA7TgAlLfGPUgAgA7TgAlLfGPUgAgA7TgAlLfGPUgAgA7TgAlLfGPUgAgA7TgAlLfGPUgAgA7TgAlLfGPUgAgA7TgA
					lKfFPIgAgA7LgAk+e1L9gAgA47gAkreiIIgAgA1SgAkkecG/gAgAz8gAkkecG/gAgAz8gAkkecG/gAgAz8]],
				Head = [[
					gAlReSAGgAgAiNgAlFeGACgAgAfMgAklduA7gAgAYdgAkHdeCrgAgATPgAkNdgCTgAgAUJgAlUeZARgAfpj7gAlyfSEagXfJwKgAl0fbEofQhywbgAl0fbFV
					gPfgxqgAl0fbFqgqesyFgAl0fbEqfThowggAl0fbFKgAgAxZgAl0fbFxgzebyNgAl0fbEvfahXwqgAl0fbE/fxggxIgAl0fbF1g4eSySgAl0fbE2flg+w4gA
					l0fZEsfmg9wngAlse/CsgVe1svgAlZedAXgAgGksgAlReSAGgAgAiNgAlReSAGgAgAiNgAlReSAGgAgAiN]],
				Jaw = [[
					gAlbdU/+gAgAhGgAlDdH/sgAgAkagAkKc19ygAgArpgAjacy7DgAgAxFgAjjcy7ngAgAwKgBlldc/tf7gWkQgEmpe0/7fTgneHf5mse//7hje2fagCmufE/7
					fjgUd/gGmvfG/2exg0ddf5mse//7hbe8fUgAmufD/8gAgAeTgHmvfH/0ehg+dTf6msfA/8hMfIfJf+mtfB/9gdfrengHmvfH/zeYhDdNf8mtfB/9g3fYe6f8
					mse+/9g1fYe9gFmaeW/8fRg/eogAltdh//gBf7gtgAlbdU/+gAgAhGgAlbdU/+gAgAhGgAlbdU/+gAgAhG]],
				["UpperArm.L"] = [[
					fFjjef0OMmgAvafFjbee0YMmf0vNfFjHed0tMmfZuwfFi3ed09MnfCuZfFi5ed07MnfGucfFjmef1HLhZpq3fFkHen0DNxPxk/fFkMepzjO/Npj0fFkMepzj
					O/Npj0fFkMepzjO/Npj0fFkMepzjO/Npj0fFkMepzjO/Npj0fFkMepzjO/Npj0fFkMepzjO/Npj0fFkMepzjO/Npj0fFkMepzjO/Npj0fFkMepzjO/Npj0fF
					kLeozpOxN/kAfFj9ek0xMEUUnnfFjqeg0tL0dOtYfFjjef0OMmgAvafFjjef0OMmgAvafFjjef0OMmgAva]],
				["LowerArm.L"] = [[
					emjDeC42z4gAjXemi7eB44z4gMjHemiod+48z3goikemiZd94+z2g/iIemicd94+z2g8iMegjcd76jwUlcbPeakbeQ4KnkqoPleZkkeY20lOrKNReZkkeY20
					lOrKNReZkkeY20lOrKNReZkkeY20lOrKNReZkkeY20lOrKNReZkkeY20lOrKNReZkkeY20lOrKNReZkkeY20lOrKNReZkkeY20lOrKNReZkkeY20lOrKNReZ
					kjeX3DlnrGNpeckFeD6Cr+ovUyejjTd+5/yeikfxemjDeC42z4gAjXemjDeC42z4gAjXemjDeC42z4gAjX]],
				["UpperArm.R"] = [[
					g7jjef0OzagAvag7jbee0YzagMvNg7jHed0tzagnuwg7i3ed09zZg+uZg7i5ed07zZg6ucg7jmef1H0fmXq3g7kHen0DyPwPk/g7kMepzjxByXj0g7kMepzj
					xByXj0g7kMepzjxByXj0g7kMepzjxByXj0g7kMepzjxByXj0g7kMepzjxByXj0g7kMepzjxByXj0g7kMepzjxByXj0g7kMepzjxByXj0g7kMepzjxByXj0g7
					kLeozpxPyBkAg7j9ek0xz8rsnng7jqeg0t0MiytYg7jjef0OzagAvag7jjef0OzagAvag7jjef0OzagAva]],
				["LowerArm.R"] = [[
					hajDeC42MIgAjXhai7eB44MIf0jHhaiod+48MJfYikhaiZd94+MKfBiIhaicd94+MKfEiMhgjcd76jPsakbPhmkbeQ4KYcVYPlhnkkeY20ayU2NRhnkkeY20
					ayU2NRhnkkeY20ayU2NRhnkkeY20ayU2NRhnkkeY20ayU2NRhnkkeY20ayU2NRhnkkeY20ayU2NRhnkkeY20ayU2NRhnkkeY20ayU2NRhnkkeY20ayU2NRhn
					kjeX3DaZU6NphkkFeD6CUCXRUyhdjTd+5/NidcfxhajDeC42MIgAjXhajDeC42MIgAjXhajDeC42MIgAjX]],
				Tail1 = [[
					gAjNhCeIgAgA/8gAjKhCeWgAgA/8gAjDhCe0gAgA/+gAi9hCfMgAgA/+gAi+hCfIgAgA/+gAjKhDdqfjf//5gAjPhDcMe0gA/vgAjPhDb7iff+/ogAjPhDb6
					fTgB/ugAjPhDb7eHgB/rgAjPhDb7iSf+/pgAjPhDb6gAgA/ugAjPhDb7dugC/pgAjPhDb7h5f//rgAjPhDb6gtf//ugAjPhDb7dhgC/ogAjPhDb6hXf//sgA
					jPhDb9hVf//tgAjOhDcvecf//ygAjNhDdygHgA/6gAjNhCeIgAgA/8gAjNhCeIgAgA/8gAjNhCeIgAgA/8]],
				Tail2 = [[
					gAjRhqc8gAgA/2gAjOhqdxgAgA/6gAjGhqfpgAgA//gAi/hqhKgAgA/+gAjBhqg5gAgA/+f/jPhqblgXgA/rf9jYhpWtdcf8+ggGjZhpV5hWgm+Uf+jZhpV5
					hzfj+Sf7jZhpV4dLfy+NgGjZhpV5gkgp+VgAjZhpV4iXfs+Qf6jZhpV4defo+PgFjZhpV5fvgo+WgCjZhpV4iwf3+Of6jZhpV4d/ff+RgDjZhpV5e7gk+UgD
					jZhpWBi2gD+Qf8jWhpYcfJfv/EgAjThqbzfuf//tgAjRhqc8gAgA/2gAjRhqc8gAgA/2gAjRhqc8gAgA/2]],
				TailCube1 = [[
					gKjsi7gAgAgA//f/jci7f0hNgE/+gBjMi8h3iBgO/3gAi8i8khiMgR/mgAi+i8lChsgK/jgBjoi5fQg/f7/9fokEirZGc1gQ/EgPkRimXzfug1+6gIkMipYg
					fmf3/GfukMioZqbNgp++gHkMipZ3feg3/YgCkMiqY1iVfe/FfwkKiqX2epfj+5gBkOioYAhxgP+7gPkMioZLk2fD+3fxkMipZ8fkfV/Zf9kMipZbfngi/TgV
					kRilYYiPf9+/gAkCixaXddf+/Yf/jqi5ejdhgE/3gAjji7g2d+gD/6gAjji7hBezgC/9gKjsi7gAgAgA//]],
				TailCube2 = [[
					gRj7j4gqeegC/8gEjtj5fRgzgF/+gCjKj7gwi2gY/2gJi0j6kIj/gl/dgHi1j6lzj5ga/OgFj1j2gSi6fy/2feksjcZKd0gC/LgIk3jYW3feg4+ogGkxjcXp
					ePgJ+1fcktjaZ9ZMhH+pgEktjfbBdZhY/dgOkzjbZdg1fz/Tfvk3jXXUeQfo+vgOk4jXW7ilgI+kgikujZY4moev+cfwktjeayhue3/ff7kujeabhggF/dgY
					k5jWYcjNft+6ftkmjjZZdPf7/Lf1j6j1drcIgC/qf4jqj4hGb3gC/tf7jqj5iHcpgF/vgRj7j4gqeegC/8]],
				TailCube3 = [[
					gVj3kzhtcQgH/ugLjtkzfafAgI/+gMjKk0fziDgb/7gXiekujOkbgx/ggUiZksl9lagq+9gPjskvhXlDfo/jfMk9kSZ3f2fm/ZgGlRkMWXgxgg+fgAlIkRWl
					eagD+hfDk6kOZlYKhN+Uf6k3kYb2bihy/WgclCkTafeqgT/ffrlTkKXbcigI+ogTlMkPWBh0gZ+Vg6k/kMYBnGe2+If3k4kXbCjQem/ZgAk7kXbfjofl/dgp
					lUkHZKlNfG+zfekvkdY7ekfo/Kfnj7kuclcTf5/lfpjfkwgra1f7/kfvjakwi2atgF/bgVj3kzhtcQgH/u]],
				TailCube4 = [[
					gNj9lqiwakgN/Zf/kGlngKczgQ/1gKjTlrfZgCgb/+gmihlkiIjPgw/vgniSlgleldgw/Cggj1ljiFmRfi/TfNlZlCa9h1fJ/hgRmBksWii3f0+bf7lxk3Vt
					gAfk+Seqlak0YpYsg3+QfqlQlGcAa4h5/RgSlYlEbkdAgs/ifnl3k0YLacg3+ggTl/ktVqf5hB+QhRljkwW8mBfW+EgDlUlGajjVeo/UgNlWlGcNk1fT/Yg+
					l2kuaQnIeb+nfYlZlEZJgtfI/OfbkTlfbrd9fp/ofYjplkfubafz/qfdjelli+aDgD/SgNj9lqiwakgN/Z]],
				TailCube5 = [[
					gCjomZjaaSgT/Sf+j+mbhQbYgZ/ogPjNmefrd6gf/6gwiTmUhThFgp/8g4h7mKkij/gn/agzjmmQiIl7fg/XfXlbl1cBire6/ngSmRlfXUkmfK+bf7mKljVa
					iIe3+FeTlolfXjafgP+WfalUl3babyhs/VgNlll1cOcvgz/lffmNliZRZHhc+egQmUldV/d5hu+Qhkl3lbWEj/gE+JgOldl3Zih5e8/Qgclal2cQkffV/chR
					mGlbbTn6eA+kfglel5Z/ifer/SfVkZmRbVgLfW/pfKjjmUeodTfs/2fLjNmRiba/gD/ggCjomZjaaSgT/S]],
				TailCube6 = [[
					f6jqnJjZblgc/gfqkKnGiRbigj/lgPjZnMgic1gl/0gzianDhBfHgj/9hDh5m4jehygX/whEjrm9hgkMfe/rfflvmfclh6e+/vgXmrmGYYlDe2+ogCmvmAVy
					jneT+DeEmJl/Wwclfk+bfMlsmeaUdyhV/YgAl9mdcMeCgp/sfImnmDaOZSho+sgNm7l6W2c6iK+bhumbl4VziHgt+PgUl6mcYZfvfZ/Egplwmfboiwfm/khk
					mfl/b1nKd++1fhl2mibGi7ee/cfWkxm6bshvfG/ofCjynBd0fffl/6e9jRm/hadCgH/0f6jqnJjZblgc/g]],
				["UpperLeg.L"] = [[
					e6iDgO7BeJgAxBe6h+gP78d9f0vbe6h1gU9idofasCe6htgX+fdZfFpQe6hugW+WdcfJpwe6iBgM7FeHf/w7e6iNgD1Ze/gz3we6iPgCzmfOg/5Qe6iPgCzm
					fOg/5Qe6iPgCzmfOg/5Qe6iPgCzmfOg/5Qe6iPgCzmfOg/5Qe6iPgCzmfOg/5Qe6iPgCzmfOg/5Qe6iPgCzmfOg/5Qe6iPgCzmfOg/5Qe6iPgCzmfOg/5Qe6
					iPgCznfOg/5Pe6iKgG36eogg1Ne6iEgM6aePgHx+e6iDgO7BeJgAxBe6iDgO7BeJgAxBe6iDgO7BeJgAxB]],
				["LowerLeg.L"] = [[
					e4hdf7t+hAgA8xe3hbf5tAhGgG9Ne3hYf2rdhSgS91e2hWf0qyhbga+Fe2hWf1q3hagZ+De4hbf5tIhAgB9Ke6hkgHyFgffp6Ye6hngMzigWfk5Ve6hngMzi
					gWfk5Ve6hngMzigWfk5Ve6hngMzigWfk5Ve6hngMzigWfk5Ve6hngMzigWfk5Ve6hngMzigWfk5Ve6hngMzigWfk5Ve6hngMzigWfk5Ve6hngMzigWfk5Ve6
					hmgMzjgWfj5Ue5hhgBv/gsfy7te4hef8uRg8f98ne4hdf7t+hAgA8xe4hdf7t+hAgA8xe4hdf7t+hAgA8x]],
				["Foot.L"] = [[
					e6g5gY8VgAgAu2e6g5gY8VgHf8u2e6g5gY8VgUf2u2e6g5gY8Vgdfxu2e6g5gY8Vgbfyu2e6g5gY8VgBgAu2e6g5gY8VffgRu2e6g6gY8BfXgWvbe6g6gY8B
					fXgWvbe6g6gY8BfXgWvbe6g6gY8BfXgWvbe6g6gY8BfXgWvbe6g6gY8BfXgWvbe6g6gY8BfXgWvbe6g6gY8BfXgWvbe6g6gY8BfXgWvbe6g6gY8BfXgWvbe6
					g6gY8GfXgWvRe6g5gY8VfsgKu2e6g5gY8Vf8gCu2e6g5gY8VgAgAu2e6g5gY8VgAgAu2e6g5gY8VgAgAu2]],
				["Toe.L"] = [[
					e6gogM/8gAgAhte6gogM/8gFf6hte6gogM/8gOfuhte6gogM/8gUfmhte6gogM/8gTfohte6gogM/8gBf/hte6gogM/8fpgdhte6gpgN/5fkgliXe6gpgN/5
					fkgliXe6gpgN/5fkgliXe6gpgN/5fkgliXe6gpgN/5fkgliXe6gpgN/5fkgliXe6gpgN/5fkgliXe6gpgN/5fkgliXe6gpgN/5fkgliXe6gpgN/5fkgliXe6
					gpgN/6fkgliMe6gogM/8fygShte6gogM/8f9gEhte6gogM/8gAgAhte6gogM/8gAgAhte6gogM/8gAgAht]],
				["UpperLeg.R"] = [[
					hGiDgO7Bh3gAxBhGh+gP78iDgMvbhGh1gU9iiYgmsChGhtgX+fing7pQhGhugW+Wikg3pwhGiBgM7Fh5gBw7hGiNgD1ZhBfN3whGiPgCzmgyfB5QhGiPgCzm
					gyfB5QhGiPgCzmgyfB5QhGiPgCzmgyfB5QhGiPgCzmgyfB5QhGiPgCzmgyfB5QhGiPgCzmgyfB5QhGiPgCzmgyfB5QhGiPgCzmgyfB5QhGiPgCzmgyfB5QhG
					iPgCzngyfB5PhGiKgG36hYfg1NhGiEgM6ahxf5x+hGiDgO7Bh3gAxBhGiDgO7Bh3gAxBhGiDgO7Bh3gAxB]],
				["LowerLeg.R"] = [[
					hIhdf7t+fAgA8xhJhbf5tAe6f69NhJhYf2rdeufu91hKhWf0qyelfm+FhKhWf1q3emfn+DhIhbf5tIfAf/9KhGhkgHyFfhgX6YhGhngMzifqgc5VhGhngMzi
					fqgc5VhGhngMzifqgc5VhGhngMzifqgc5VhGhngMzifqgc5VhGhngMzifqgc5VhGhngMzifqgc5VhGhngMzifqgc5VhGhngMzifqgc5VhGhngMzifqgc5VhG
					hmgMzjfqgd5UhHhhgBv/fUgO7thIhef8uRfEgD8nhIhdf7t+fAgA8xhIhdf7t+fAgA8xhIhdf7t+fAgA8x]],
				["Foot.R"] = [[
					hGg5gY8VgAgAu2hGg5gY8Vf5gEu2hGg5gY8VfsgKu2hGg5gY8VfjgPu2hGg5gY8VflgOu2hGg5gY8Vf/gAu2hGg5gY8Vghfvu2hGg6gY8BgpfqvbhGg6gY8B
					gpfqvbhGg6gY8BgpfqvbhGg6gY8BgpfqvbhGg6gY8BgpfqvbhGg6gY8BgpfqvbhGg6gY8BgpfqvbhGg6gY8BgpfqvbhGg6gY8BgpfqvbhGg6gY8BgpfqvbhG
					g6gY8GgpfqvRhGg5gY8VgUf2u2hGg5gY8VgEf+u2hGg5gY8VgAgAu2hGg5gY8VgAgAu2hGg5gY8VgAgAu2]],
				["Toe.R"] = [[
					hGgogM/8gAgAhthGgogM/8f7gGhthGgogM/8fygShthGgogM/8fsgahthGgogM/8ftgYhthGgogM/8f/gBhthGgogM/8gXfjhthGgpgN/5gcfbiXhGgpgN/5
					gcfbiXhGgpgN/5gcfbiXhGgpgN/5gcfbiXhGgpgN/5gcfbiXhGgpgN/5gcfbiXhGgpgN/5gcfbiXhGgpgN/5gcfbiXhGgpgN/5gcfbiXhGgpgN/5gcfbiXhG
					gpgN/6gcfbiMhGgogM/8gOfuhthGgogM/8gDf8hthGgogM/8gAgAhthGgogM/8gAgAhthGgogM/8gAgAht]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAjJgiAOgAgAjkgAjGgiANgFgrjWgAitgiAHgRhlh5gAjlgiAWgJhmkVgAkRgiAkgDg/l1gAkhgiApgAgAmVgAkRgiAkf9fBl1gAjlgiAWf3eakVgAitgiAH
					fvebh5gAi4giAIf3fCijgAi1giAHgAgAiXgAj6giAcgEg/lHgAkbgiAqgDhmmJgAkegiArgDhmmPgAkDgiAfgDg/lZgAjGgiALgAgAjHgAi1giAIf3fCiXgA
					jJgiAQf1ebjigAjKgiAPf3e0jkgAjKgiAOf+fwjkgAjKgiAOgAgAjk]],
				Spine1 = [[
					gAjQgGAjgAgAlyf/jMgGAggIgrlef9ixgFAOgVhkjTf9jtgGAxgRhlmuf+kcgHBPgIg+osgAksgHBagAgApUgCkcgHBPf4fCosgDjtgGAxfvebmugDiwgFAO
					frecjSgCi9gGAUf0fCkSgAi5gFARgAgAkAf+kEgHA/gJg+nwf9kmgHBYgNhlpFf9kpgHBagMhlpNf+kNgHBFgJg+oIgAjMgGAagAgAlCgCi5gFASfzfCkAgD
					jPgGAlfueclvgCjQgGAkfye1lygAjQgGAjf9fxlygAjQgGAjgAgAly]],
				Spine2 = [[
					gAjlfQBBgAgAn9f8jffPA7gLgqnif4i9fNAZgZhjkrf4kEfSBXgYhjpDf7k6fWCKgOg9rdgAlMfXCcgAgAsMgFk6fWCKfyfDrdgIkEfSBXfoedpDgIi8fNAZ
					fnedkqgFjMfOAmfwfDl+gAjIfNAhgAgAlmf7kffUBwgOg9qVf4lFfXCXgWhjr6f4lJfXCbgWhjsEf7kpfUB5gOg9qxgAjefOAxgAgAm7gFjIfNAifwfDlmgI
					jkfQBDfnedn5gGjlfQBDfte2n9gBjlfQBBf8fxn9gAjlfQBBgAgAn9]],
				Neck1 = [[
					gAjze2EogAgAwif7jte1EQgWglv6f1jFexCNguhbrhf1kUe5Fqg1hXyEf5lOfAILgjg01UgAlhfCJDgAgA2RgHlOfAILfdfM1UgLkUe5FqfLepyEgLjFexCM
					fSelrfgHjXeyDCfifJthgAjSeyCxgAgAs9f5kxe8G7gig1z1f1lafCIwg5hV16f1lefCI7g5hU2Gf5k8e+HZgig10bgAjqe0DvgAgAu+gHjSeyCyfifJs9gL
					jye2EmfLepwbgIjze2EpfYe/whgCjze2Eof4fzwigAjze2EogAgAwi]],
				Neck2 = [[
					gAkkecG/gAgAz8f6kdeZGjgbgizXfxjqeID8g6hUvRfzlIelIOhAhP1Vf5mFe6LJgpgw4OgAmYfBMHgAgA5DgHmFe6LJfXfQ4OgNlIelIOfAex1VgPjqeID7
					fGesvQgJkCePFCfbfNxKgAj7eMEsgAgAwpf4lnevJtgpgw26f0mRe/LyhDhM4uf0mVfAL/hDhM45f4lyezKQgpgw3cgAkYeVF6gAgAyggJj7eNEtfbfNwogN
					kjecG9fBewz1gKkkecHBfQfEz7gCkkecG/f2f0z8gAkkecG/gAgAz8]],
				Head = [[
					gAlReSAGgAgAiNf6lJeNANefgwjDfvkRdvATcdiOfDfyl2egA4cihWmYf5mzfBByd7giqRgAnGfLCIgAgArcgHmzfBByiFfeqRgOl2egA4jeeqmYgRkRdvAU
					jjdyfBgKkrd7AIiMeyhGgAkkd3ABgAgAgaf4mVexBOd5groaf0m/fICMcrgxrGf1nCfKCScsgvrVf4mhe3Bbd6gopIgAlEeFAIgAgAiogKkkd3AIiMevgegO
					lQeSAkjfebkegLlReSAZipexj9gClReSAJgjfuixgAlReSAGgAgAiN]],
				Jaw = [[
					gAlbdU/+gAgAhGf2lXdP/Yhqftl/fnkOcx9RkGfMsNfqmPdn/Wjuf/lJf0naeQ/5iIgPhMgAnxed//gAgAf+gMnaeQ/5d4fxhMgWmPdn/WcSgBlJgZkOcx9R
					b6g0sOgPkxc9+KdhgXqWgAknc4+BgAgArCfzm2d7/wiOgIjIftnoeZ/zjYgegRftnsec/zjXgfgBfznEeD/1iMgLiYgAlQdI+ugAgAo6gPknc599dggaq7gX
					lidW++cMgPnCgRlhdW/XdIgZljgElddU/4fagLingAlbdU/+gAgAhG]],
				["UpperArm.L"] = [[
					fFjjef0OMmgAvae/jdehzZK2XZrMe4iyejyhMBRoooe4kGenz0RzLVhMe9lDep0DPUN6j5fFlZeozgMESFnMfNlEei0+O8PIiufSkHeb1tRqNZfrfSiweY0D
					LdTomxfNjEeax/JYW9qUfFi/edzhMHSBnIe9klen0MSmLIgCe4lQetzzPvNSj8e4lUeuy8MkRSoXe9kxeoz+O7OTkXfFjZee0tQYNYh3fNi/eaz/L9SpmjfS
					jieZy0J2V9oyfPjjea1CLpVNnEfHjjee09LlcMsVfFjjef0OMmgAva]],
				["LowerArm.L"] = [[
					emjDeC42z4gAjXeVjZeA7WtOmmYbeKi/eL8MrbjEWjeMkiee5MtkiNR3eQlbeY5fqbmEQ5ealneM5aocqcR9ejlceL5KrGnwRnepkjeK46uykxTSeqi8d37o
					smluXtekjGd47bqspWXreajNeB7qr4kwWTeRlCef4ktqjSRGeLlnee5VqHluQSeKlheW54oApCRkeQlHeV50qll1Reeaj0eN59uZigUVekjNd77fsPllWqeq
					jod36pqVqfWLeojrd37JuEmBYwekjRd66PyOhOhQemjDeC42z4gAjX]],
				["UpperArm.R"] = [[
					g7jjef0OzagAvag2jdec1pzXr/mDguiweY0D0jsZmwgukHebzK1vq3oEgzlEei0+xEw4iug7lZeo0tsL1DeRhDlDep0DwsyGj5hIkGenyG0vsrqPhIixejyh
					z/uXoohDjFeh0CwJyyi9g7i/edzhz5t/nIgzkmefzV1EsGntgulSei1Sw5wwiBgulWei1osWz8dlgzkxeg05xdwfjMg7jZeex+2CqSqchDi/ehzCztumnthI
					jielzxu90Ih9hFjjej0KzysVokg9jjef0j0VjltOg7jjef0OzagAva]],
				["LowerArm.R"] = [[
					hajDeC42MIgAjXhdjnd57QQTdUa2hWi9d37oTbaRXshWkPd56PWDVJVKhdlceL5KU6YQRnhml3eh3jSQbEQChwlbeY5fVlZ8Q5h2kOeN7JXDX3ULh2i/eL8M
					Ulc9WkhvjeeR6YR7evUshmjNeB7qUIbQWThckxeA58WpVRT4hXlreK4zU0XlRchYl1eX3dRrZ1Q3hdlIeJ5fUvYgSMhmjed/7dV5XLWihwjOeI71UfcFV9h0
					j+ea5sSVeVS0hwjreG7hShcCXvhhjPd+6TOIc6elhajDeC42MIgAjX]],
				Tail1 = [[
					gAjNhCeIgAgA/8gBjJhCeaoFgU+6gDi0hCf1tzep81gDjmhCdBlpg0/VgCkQhDbDZed++2gAkehDawTzbe8wf+kQhDbIXqdZ+Yf9jmhCc+ihgX/vf9i0hCf1
					q4e7+Ef+i9hCfMpsfp+egAi7hCfWgAgA//gCj7hDcJWjd2+PgDkZhCa1Vsca9ngDkchCaZdnfJ/ZgCkDhDbvoeiN+egAjLhCemtAgQ9Mf+i7hCfXm1fo/Pf9
					jMhCeMaUfs/bf+jNhCePVefZ+JgAjNhCeJdDf1/zgAjNhCeIgAgA/8]],
				Tail2 = [[
					gAjRhqc8gAgA/2gVjOhldmkwgN/igiizhbiLzveD5AgRjuhnapxwiy57fzkdhlVGiYeJ96fnkuhdT9SWYI5GfrkdhjV0NcaF3PgDjuhpaMXXfQ+PgWizhgh0
					p/eJ+SgVi/hjgZy1gC53gAi8hqghsngv9ZfskFhiXkbvdI+bftkohgUdQcZF4ff+kqhnUMRVcZ5mgVkOhjWufpiS+hgejOhdeZv9gq7qgPi8hmg2yJgH6Vfv
					jRhndEligj/XfljRhhdFWGfD+Qf4jRhpc/ahfe/XgAjRhqc8gAgA/2]],
				TailCube1 = [[
					gIjqi7gAgAgA//gsjcizfmmDf+/ahximhukV1Ic63bhYkOiCdnzqge5IgClSiiZIjYdf+9fAlwh6WbRqZe6IeulThsXKMHbj3BfZkGiqchVUgD98hHipiilJ
					nscv+dhjjAh8jqxmdi6Wg2i9iojVsnfh9NfdkximZmc2dO/De9lrhtWtRtZu6UfJlliAXbSzde7ugQk+inaphOiA/chijfiKhDv9fI7shei7h+iaxCez68gQ
					jfixfcjdgF/ze1jjiignUEgQ9qfdjji1hCZNgO/PgIjqi7gAgAgA//]],
				TailCube2 = [[
					gNj4j4gqeegC/8hDjtjse8lxgG/civibh0jr1/dy21iSkhiPdl1NgU31gSl0jUaVlZc2+3ekmliSXTSyZS6+d9l5hoWuMabF3AevkfjTbjUUfy9chkidjZk7
					lwcb+4idi5iUkZvqcx7Whmi9jSj6rMfJ9sfYlXjZY7codN+5efmhiBWCS1Y96eejmOibXnUlc78ggSlcjebjjbhh/diXjsithpxPe064iWi5iYh3xSfL61gd
					jyjteYiYgL/3eKjrjPgoSNgN82fDjqjuiEXGgd+pgNj4j4gqeegC/8]],
				TailCube3 = [[
					gOjykzhucQgH/uhajtkhe9kEgK/tjliFh1i31pec3VjMkhiWdG1zgt3Ogml/kKbKnIcX+meAnIiuYuUdZF8FdMmZhnXANral4BeHkpj8akU1fV9eh0iCkKkM
					lBcZ/GjKieivkyt8cO8JiQinj2k2pDek+QfPltkOYza+dm+qd4nDicVDSmYs55d+mnjCXGVYcg8ngellkWcHlThJ/SjIjhjMikzBeT5ijKiuiyh6ytfR53go
					jtkndUi7gQ/vddjhjzgDRef58geljakeitVUgj+BgOjykzhtcQgH/u]],
				TailCube4 = [[
					gFj5lpixakgN/ZhikFlWfoh3gM/7kdiHh6iQ0Res4nkAk2iYcV1Khf3rhBmYk0bOnpcS+ddtnxjQaDVwZC84conBh0X7PSaU5admlMkbaAWne099iGh/k/jQ
					l8ct/Fj2iWjQkttdcJ8YiqickklynXeE+ifHmOk6ZRY0eQ+Ydhn1ioUIRPZD40dmnQjeWFUxcW8Bgul/lFcGl1hF/Mj+jjjaje0Tdx4Yj/i4jCid0ce/4dgx
					j+lacqkygM/dcxjukTfGSOfc82eCjelJiuUzgg91gFj5lpiwakgN/Z]],
				TailCube5 = [[
					f5jlmYjaaSgT/Shvj+mHgsgVgN/+lMh3iDiKyiei58kyk6iebmzjiX40hYmclhaemscl+mdWoIj2atV3ZM9FcCnbiIZFQUad6bdLlalEaGYsea+iiVhrlric
					n/dL+wkXh9jtkRuecm8AjCiHlLmZnDd3+ee5mglnaMXVe3+Nc5oSi6TrPlZ43vdInqj+U+TIck65hAmEl0bfkwhT/SkrjQjoj/0edY4HkwiqjHjS1jeZ3Xg8
					j/mMcqm7f9/DcKjqkzeJUGe/9ndhjOltiFVzgY+Pf5jlmYjaaSgT/S]],
				TailCube6 = [[
					fvjmnHjZblgc/ghrkMm2hwgWgM/8l5h7iSipxbeG6olalTimbPxzjB5+hum0mFZPkwdH+xdDoqkUacUrZa8pbon7igZ9QJa+6pc4l2lmazZ6eT+7iuhumViA
					qEdj+Nk+h4kJjlwZdb7HjViAl3meoSeI+Kehm6mHbMXTfK+ZcnpBi3T6Ogav3TcxoRkMUPRbdA5whMmdmcajinhs/XlYjJj2j4zddO48lfiqjKkD1fdr3PhR
					kZmxdToMfq+zbrj7lTdmWHeq+TdFjTmThCX0gQ+6fvjmnHjZblgc/g]],
				["UpperLeg.L"] = [[
					e6iDgO7BeJgAxBe5h/gS8IeXfOvHe5hlgc/Nd7c/l+e5iegR63fRe0xUe5jNgI0nf8gX4ee6jegCz6fOg/5Ae8jPf/zfeehm5Re9ifgD4bdZhj0ce9hjgO+G
					cig0qOe8hwgO9RdEgXske6htgT+HddfPqde5i1gL3Ufhf+15e5jXgJ00gZf+4Se5jagJ0ygZf+4Ue5i+gK0yf9gX4Ue6h/gQ85dvfltie8hsgP9pc/gTrqe9
					iCgH6CdMhYyVe8iDgI6NdchDyIe7iDgM63eAgOxPe6iDgO7BeJgAxB]],
				["LowerLeg.L"] = [[
					e4hdf7t+hAgA8xe2hcf7tfh0f789ewhWf2rFjngr9ye1h5gAvgiffY73e6ikgP0ghJe94ge6i2gLz2gXfj5Fe7imgKzdfogH5Ye7h2f8uJfVgf8re8hKftmH
					fbgQ/Ze6hSfxo/gKgW+te2hTfyplhYgX+fe4iMgIyYhcfM6Ie5iugQ0shlen4Te5ixgP0qhlen4Ve6iVgQ0rhLe94We3hff1rBhOgN+Ae6hQfwoXgLgW+4e7
					hbf5s1fXge9Se7hcf6tPfxgX9He4hdf7tzgvgF82e4hdf7t+hAgA8x]],
				["Foot.L"] = [[
					e6g5gY8VgAgAu2e6g5gY8Vgtfou2e6g5gY8Pibevuze6hSgY7ehOfSwVe6h3gX5/gJf8yqe6iJgV5BfggZz6e6h6gW5be1g1zXe6hSgY7deng1wVe6g5gY8T
					ergsu1e6g5gY8VfWgWu2e6g5gY8Vgafyu2e6hhgY7FgWfyxBe6iBgX5qgkfqzFe6iEgX5igkfpzQe6hogY6ygIf7xee6hBgY8BgOf4vbe6g5gY8VfXgWu2e6
					g5gY8Tepguu1e6g5gY8Ue+gju1e6g5gY8VfygHu2e6g5gY8VgAgAu2]],
				["Toe.L"] = [[
					e6gogM/8gAgAhte6gogM/7gffYhte6gogM/1hrd2hte6hAgO/xg0e1jbe6hkgR/ZgGf4mKe6h1gR/Dfuglnse6hmgQ/LfShPnBe6hAgO/xfFhVjae6gogM/6
					fGhLhte6gogM/8fjgmhte6gogM/8gSfphte6hOgP/tgOfrkNe6htgR/SgXfdmre6hwgR/PgXfdm5e6hVgQ/ogFf5kve6gwgN/5gKfziXe6gogM/8fkglhte6
					gogM/6fEhOhte6gogM/7fSg7hte6gogM/8f2gMhte6gogM/8gAgAht]],
				["UpperLeg.R"] = [[
					hGiDgO7Bh3gAxBhFh/gM7XiZfiwYhDhkgO+GjefMqQhDifgD4bined0chEjPf/zfhiea5RhGjegCz6gyfB5AhHjNgI0ngEfp4ehHiegR63gvhMxUhHhlgc/O
					iFjBl7hHhwgW+Jh/htqZhGhtgT+HijgxqdhEi2gDzrhkeb5IhDjZf8zEh9eC5ihDjdf7zDh9eC5jhEi/gBzmhjeb5MhGh/gQ85iRgbtihHhtgX+diGh3pXhH
					iCgV79g/hdvchHiDgT7rhLhFv+hGiDgP7LhugOwzhGiDgO7Bh3gAxB]],
				["LowerLeg.R"] = [[
					hIhdf7t+fAgA8xhHhaf4scfpfx9ehEhKftmJglfw/ZhFh2f8uJgrfh8rhFimgKzdgYf55YhGi2gLz2fpgd5FhGikgP0ge3hD4ghLh5gAvgdhgo73hQhWf2rF
					cYfU9yhNhXf2rQdgfu91hKhTfypleofp+fhFiOgMzqgZf65PhEixgHzFg0fj5qhEi1gHzDg0fj5rhFiXgLzlgZf55ShJhff1rBeyfz+AhNhWf1q2dafo9+hM
					hff/u+dTgc8JhLhff+uzdvgW8RhJhdf8uIewgF8rhIhdf7t+fAgA8x]],
				["Foot.R"] = [[
					hGg5gY8VgAgAu2hGg5gY8Vghfuu2hGg5gY8ThUfUu1hGhSgY7dhZfLwVhGh6gW5bhLfLzXhGiJgV5Bggfnz6hGh3gX5/f3gEyqhGhSgY7eeyguwVhGg5gY8P
					dlhRuzhGg5gY8Teoguu1hGg5gY8VfmgOu2hGhhgY67hOfPxNhFiFgV4whje40LhFiJgU4nhje40WhGhrgX6RhMfNyNhGhBgY8BfygIvbhGg5gY8Teigxu1hG
					g5gY8Tekgwu1hGg5gY8Ue8gju1hGg5gY8VfygHu2hGg5gY8VgAgAu2]],
				["Toe.R"] = [[
					hGgogM/8gAgAhthGgogM/8gXfihthGgogM/6g6e1hthGhAgO/xg7erjahGhmgQ/LguexnBhGh1gR/DgSfbnshGhkgR/Zf6gImKhGhAgO/xfMhLjbhGgogM/1
					eViKhthGgogM/6fDhPhthGgogM/8fugXhthGhPgP/pgyezkchGhxgQ+5g8eWoDhGh1gQ+2g8eVoQhGhXgQ/dgweylohGgwgN/5f2gNiXhGgogM/5e/hUhthG
					gogM/5fBhShthGgogM/7fRg8hthGgogM/8f2gMhthGgogM/8gAgAht]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAjKgiAOgAgAjkgAjKg6AggAgAllgAjKhJAxgAgAm3gAjKhFAsgAgFmhgAjKg9Akf/fll3gAjKg0Agf4d/lIgAjKgvAaf4eTkpgAjKgtAWf+frkigAjKgpAT
					gCgOkMgAjSgkATh5f0jvgAjfgiA4mcfSjggAjdgiCnsIepjTgAjIgiFLxDeGjBgAiygiHOz6dxiygAiugiHi0TduiwgAi5giGlzFd3i3gAi7giGay2d5i4gA
					iwgiHX0FdwixgAitgiHq0cdtivgAitgiHq0cdtivgAitgiHq0cdtivgAitgiHq0cdtivgAitgiHq0cdtiv]],
				Spine1 = [[
					gAjQgGAjgAgAlygAjUgeA+gAgAnxgAjWguBUgAgApCgAjVgqBOgAgFotgBjUgiBDf9floDgEjTgZA8fveAnVgDjSgTAzfweUm2gBjSgRAvf9fsmvgAjRgNAq
					gDgOmZgBjZgIAoh4fsl9gDjlgGBNmYe1lrgFjigGC7sAdzlWgGjLgGFdw3c5k5gGizgGHfztcYkhgGivgGHz0FcTkdgGi7gGG2y5cikogGi9gGGrypckkqgG
					iygGHnz3cWkfgGiugGH60OcSkcgGiugGH60OcSkcgGiugGH60OcSkcgGiugGH60OcSkcgGiugGH60OcSkc]],
				Spine2 = [[
					gAjlfQBBgAgAn9gAjvfrBmgAgAp6gAj1f+CBgAgArJgAjzf5B6gBgFq0gCjwfvBsf7flqLgKjtfmBhfmeBpdgJjqffBXfpeWpAgCjqfdBSf7fso5f/jofYBM
					gEgOokgDjufSBIh5fsoIgLj4fQBsmZe3n5gTjwfQDesBd0ntgZjUfQGDw4c2nbgai4fQIJzscQnLgbizfQId0FcKnJgajBfQHfy4cbnQgajDfQHTypcenSgb
					i2fQIRz3cOnLgbixfQIk0NcJnIgbixfQIk0NcJnIgbixfQIk0NcJnIgbixfQIk0NcJnIgbixfQIk0NcJnI]],
				Neck1 = [[
					gAjze2EogAgAwigAkAfTHJgAgA0IgAkIfnJBgAgA2Qf/kGfiIggDgE1tgDkCfYHifyfp0mgOj9fOGme8eSzVgMj6fGF9fHejyfgCj5fEFxf1fuyTf/j3e/FW
					gIgMxrgFj9e4Exhle7wqgQkFe2E0lWcYvjgcj7e2F6qJZbuAgkjce2HsuZXHsEgoi9e2JLw6V4qqgoi4e2JaxQVuqcgnjHe2ItwLWOrFgnjKe2Ikv+WVrNgo
					i7e2JRxEV0qkgoi3e2JfxYVrqXgoi3e2JfxYVrqXgoi3e2JfxYVrqXgoi3e2JfxYVrqXgoi3e2JfxYVrqX]],
				Neck2 = [[
					gAkkecG/gAgAz8gAk2fIJ9gAgA3LgAlAflMGgAgA5Cf/k9feLhgDgE4kgDk5fOKafvfr3mgQkze/JUeueb2dgOkue0Ike8er1tgDktexIXfzfw1if+kqepH2
					gJgL0+gLkuefHJhRei0CgjkxeaG+kUbGy0g+kceYHnoPXGwxhPjueXIxrxT9uIhUjFeWJyt6SUsLhVi/eWJ8uNSGr4hTjSeWJdtSSxsyhTjWeWJXtGS5s8hV
					jCeWJ2uCSOsDhVi8eWJ/uTSCryhVi8eWJ/uTSCryhVi8eWJ/uTSCryhVi8eWJ/uTSCryhVi8eWJ/uTSCry]],
				Head = [[
					gAlReSAGgAgAiNgAllfKBXgAgApLgAltfwC/gAgAtcf/lrfmCff7gDsWgDlnfSBrgdfrqIgRlhe+BHiOeRnygPldewAth7ebmFgDlbesAggYfslkf+lYejAU
					fwgOkXgQlaeVAKh2fMiVg2laeOAvmPdegOhek6eLCjrjb8drh3j/eIFJv7bXa4h/jMeGHLyWbcZAiAjFeGHeyqbfYvh9jceGGixqbYZkh9jheHGXxdbXZuiA
					jJeGHTyfbdY5iAjCeGHlyxbgYpiAjCeGHlyxbgYpiAjCeGHlyxbgYpiAjCeGHlyxbgYpiAjCeGHlyxbgYp]],
				Jaw = [[
					gAlbdU/+gAgAhGgAmIeX/+gAgAfEgAmefI/6gAgAdwf/mZe7/7gGf/eGgFmOeh/9fegMexgal/eI/3ddhMfXgWl1d3/5d1hMf5gElydy//flgPgHf9lqdn//
					gSf1gegUlldX/3eEgkh6hAladQ+6ZdhhkvhrktdO8VT3hkoch+jldP4qPbgbr1h/itdP10NIfJtyh+ildQ1YM1e7uDh/i/dP2sNwfktPh/jDdP28N8frtEh/
					iqdQ1oNAfDt5h+iidQ1OMve2uJh+iidQ1OMve2uJh+iidQ1OMve2uJh+iidQ1OMve2uJh+iidQ1OMve2uJ]],
				["UpperArm.L"] = [[
					fFjjef0OMmgAvafFj0e621M9cOrLfFj+fN4DNlZ3oPfEj7fI3xNbacpFfIj2e93JM5cAqTfWjxeu2WL9eZq6fTjteo1vL8fEsJfHjreq1lMieatQfDjoeo1G
					MuesuUfIj1eizILvfTvsfSkPegvbKMeXxhfmkbeiq7JQb+zPf8kNekm7JaZB0ZgLj2elkmJ9W10ygOjyelkSKEWg00gHj+eklRJwXg0sgGkAekleJtXs0qgM
					j0elkeKAWs0zgOjwelkLKGWZ00gOjwelkLKGWZ00gOjwelkLKGWZ00gOjwelkLKGWZ00gOjwelkLKGWZ00]],
				["LowerArm.L"] = [[
					emjDeC42z4gAjXemjheU5Bzfj3eeemj1ej4oy3mSbVeljwef4xzDlmcHeqjmeV48zXkveDe7jbeF48zekmgze4jTeC4/znjahyepjReI5CzwiHhOejjMeI5A
					z2hBhveljXeG5zyqf0jGeoj3eL7pvleHjke0kPeV9irUcPi7fIkOef+snEaohjfYkBel/FkRZzgVfaj+em/Ij3ZtgJfTkGej/AlGaCgufRkHej++lWaGg1fZ
					kAem/GkGZwgQfbj9em/IjuZqgEfbj9em/IjuZqgEfbj9em/IjuZqgEfbj9em/IjuZqgEfbj9em/IjuZqgE]],
				["UpperArm.R"] = [[
					g7jjef0OzagAvag7j0e621zDjyrLg7j+fN4DybmJoPg7j7fI3xypleo/g/j2fA3Hywklq0hMjve92OyQkRtXhJjse01qygjJuNg+jret1kzLiBtqg6joem1H
					zehBuCg9jmeg1ayCenvcg/jged23ubaFwDg6jIeb3/pjUrvIgviiea36lDP/tBgliDeZ3ViXNUrIgjh+eZ3OiAM9q1goiMeZ3jjJOFrvgpiPeZ3mjYOTr6gk
					iBeZ3SiNNLrAgjh8eZ3Mh3M2qugjh8eZ3Mh3M2qugjh8eZ3Mh3M2qugjh8eZ3Mh3M2qugjh8eZ3Mh3M2qu]],
				["LowerArm.R"] = [[
					hajDeC42MIgAjXhajheU5BMhcJeehaj1ej4oNJZubVhajwee4xM9aTcNhfjleZ4/Mnb8dhhvjZec5FMRekeThrjSeV5EMJfPfrhejReM5DMMeag1hYjMeG4/
					MLepiAhXjCeE3ZKcfijUhJixeGzPG2fekggtiXeLtLDYe5lYgOh5eRnGBeeSmGf6hjeVjKA7d3mif4hgeVimA5dzmlgAhqeUkUBCd/magChseTkqBEeBmXf5
					hieVi7A6d1mjf3hfeWiZA4dxmnf3hfeWiZA4dxmnf3hfeWiZA4dxmnf3hfeWiZA4dxmnf3hfeWiZA4dxmn]],
				Tail1 = [[
					gAjNhCeIgAgA/8gAjJhagKgAgA//gAjGhphegAgA/9gAjHhlhIgMgC/+f/jIhdgce8f3/+f8jKhVfua/fd/lf9jLhPfPbyfn/sf/jLhOfGfMf7/+gAjMhKew
					gjgC/9gAjVhFecfzeF/5gBjihCeafFZf/RgCjfhCeQeMTy9dgDjKhCdwdbO660gDizhCdSdAMH4ugDivhCdNc8Lv4ZgDi6hCdbdHM65YgDi8hCdedJNJ5jgD
					ixhCdPc+L94lgDithCdLc7Lm4SgDithCdLc7Lm4SgDithCdLc7Lm4SgDithCdLc7Lm4SgDithCdLc7Lm4S]],
				Tail2 = [[
					gAjRhqc8gAgA/2gAjIiCe9gAgA/+gAjCiRgRgAgA//gBjEiNf7gUgE//f8jHiFfQeUfu/7fwjKh7ekYFe2+8fyjNh1eEZTfI/Nf9jNh2d6euf2/5gCjPhxdk
					g4gG/4gAjZhsdXfieD/0gAjmhqdeeCZX/IgAjlhqdJcJTq9HgBjShpcIagO86NgCi8hpbKZnMV36gCi5hpbAZgL/3kgBjEhpbeZ3NE4ogBjGhpbkZ8NS40gC
					i7hpbGZkMM3xgCi4hpa8ZeL33cgCi4hpa8ZeL33cgCi4hpa8ZeL33cgCi4hpa8ZeL33cgCi4hpa8ZeL33c]],
				TailCube1 = [[
					gDjli7gAgAgA//gAjQjUhBhNgH/9gAjEjjifiBgR/1gCjHjfjSihgN/uf0jNjXjaf+gA/zfJjVjCiIYnfy/DfPjZi/geYpfn/If4jbjHf3dCf0/2gGjdjCgU
					erf9/9f/jpi9hJdReJ/zf6j3i7hNcCZs/Ffzj9i4f8a+UF9Qf2jyi1ecabPU6qf7jkixeCZ1Mv4sf7jhixe3ZGMo4ef5jpiyfsYxN55Wf4jqizeyYVOD5Uf9
					jiiyckXlMy35f9jfiybZW/Mc3Mf8jgiwbqWIMu3If8jgiwcmVkNE3Vf8jgiwdPWENB3lf+jfiydOXkMl30]],
				TailCube2 = [[
					gEjxj4gqeegC/8gFjYkSgegzgH/+gGjDkihYi2gb/1gMjEkdi6kUgd/kf0jKkWkNiMgM/oetjYj7jKafgF/We0jjj3gjZofp/VfrjmkDe4c0ft/zgBjnkAfb
					dSf3/3f1jvj7hRbKeH/ifuj/j4h1ZuZ1+sfqkMj0f+ZWUP8/fxkHjwdxaXPP6kf4j6jsdrbKMh4yfzj3jrfravMi40ftj9jshmaHOE5xftkCjrgtZSOO5uf3
					kEjndOYTMt4Kf6kGjjaiXcMM2+f0kGjiaMVqMp2ifwkFjibiT6Nb2ofvkCjkcvT3Np2+f4j8jqcxWDM83d]],
				TailCube3 = [[
					gBjokyhtcQgH/ugIjQlMgmfAgG/+gRi5lagbiCgd/6gciylTh/kwgo/kf8i0lLkYjvgX/deZjFkvkNcpga/iebjZkrhRbsfx/rfgjjk9eaeKfp/5f3jhk6eU
					defx/2fjjkkxgxaKd//YfUj2kriKXuZ7+OfQkOkpgGW9Uk8effkVklc8Y0Pb6NfnkKkicdbHMb4kfekCkgfPbqMZ44fRkCkgiobROM6AfRkLkeizadOf6Cfi
					kZkZfCZeMt4pfmkmkQbBYuL33PffkqkLZhWeMR2YfTknkIaoTaNa2JfQkhkKcJSDON2TfekWkXcNT0Nn22]],
				TailCube4 = [[
					f1jvloiwakgN/ZgDjdmDhXcygI/zgVjDmQgBgBgb//gri5mIg6jlgr/xgIiymBj5jygc/heNjDllk5d5go/ieMjhlgiXduf7/0fcj3lxeogXfh/9fvj0luda
					fIfq/3fRjwllf4ayd2/fe8kAldiKXDZ7+Be7khlYgaVEU778fckulXcZWpP55vfwkilUa6Z2Mm4JfgkQlWdqbcMR4pfLkIlXiRblOH6DfIkTlVkEbFOu6Jfg
					kslOhIabM24/ftlFk/ckaOLn3tfjlPk0Z5YOLu2rfMlQktaTUYM+2NfBlJkub3RhOW2AfUk6lAb9SBOT2T]],
				TailCube5 = [[
					fmjemWjaaSgT/Sf7jRm0icbYgO/jgXi8nDgTd5gc/6g3ium4gEhagq/9gUiemvi7iTgU/xeIitmSk9digl/geGjQmQjZengD/xfbjymkfdiNfZ/5fsj0mhdE
					hXfg/0e/jqmUe5cvdv/ueej4mFh0YEZ2+UeZknl+g4UmVK71fFlBmAcjU9Qc5bfik4mAZ0YHND3ufSkdmFbraVMT4Le0kHmFgoa7N352etkNmAj7axOs6FfK
					kzl7ieagNE5EfdlWlseWbGLk4DfWlrldbDaELR3Ge2lxlNapWZMU2seilplHcASfOA2Xe1lXlccRRdOo2R]],
				TailCube6 = [[
					fYjfnEjZblgc/gfsjXnhjcbggY/fgSjGnxhKc0gh/zg6i6nnfyfcgp/+gbihneh1gGgI/8eAipnBkZbzgO/aeCjRnAkAd3gA/qfgj8nSgkirfS/3fxkInMda
					i8fU/ve4j5nBeNe+do/1eLkCmwhPaQZz+0eCk6mjhVVvVN8Se5lfmkdbUkQy5kfolVmmZyWzNg3nfZkzmvaPZDMi3ueykTmzefZyNp5ZelkRmvieZqOY5zfE
					k7mqigZkNI44fflmmZfgaxLt4KfemCmGcUbBLG3ae3mPlybZYgLy3LeYmLlncdUkNa3Genl5l8c+SYOf22]],
				["UpperLeg.L"] = [[
					e6iDgO7BeJgAxBe6iGgc80eKfytxe6iIgm9xeLfprle6iIgk9ieNfnsKe7iHgc9Cd7gHtRe9iGgQ8ZdEhiuXe9iFgO7/dPhUvLe7iEgT77d+gLvee6iDgT7n
					eQfvwDeyiUgP7Qcie9wWeki6gO60YjcuvaedjcgO5kTdaTtaeijpgO3dO6YmrOesjngO1rMOX0pvetjlgO1ZL3XupieojogO2PNAYBqMenjpgO2ZNPYFqUes
					jmgO1kMEXxpqeujlgO1TLuXspdeujlgO1TLuXspdeujlgO1TLuXspdeujlgO1TLuXspdeujlgO1TLuXspd]],
				["LowerLeg.L"] = [[
					e4hdf7t+hAgA8xe4hlgCxNg/gH68e4hsgHzLg/gM5le4hqgGyqhDgJ59e5hngBxpgmgU6re+hkf4wffLg97Ze8hif3vufdgz72e5hhf9vigtgM79e3hff+u/
					hMf88Perhwf7uKgMeS8oeTiaf4tcePaH8XeDjGf1sgb7U368eEjefzrSaBQQ4veOjjfxqXY9Ni26ePjifxqOY0NK2oeKjifyqpZQOU3feJjifyquZWOj3peO
					jjfxqTY5NY2zeQjifxqLYxNC2ieQjifxqLYxNC2ieQjifxqLYxNC2ieQjifxqLYxNC2ieQjifxqLYxNC2i]],
				["Foot.L"] = [[
					e6g5gY8VgAgAu2e6g8gV93gAgArde6hAgU+pgAgApMe6g/gV+dgCf8pze7g9gT+DfzgYq+e9g8gN9gfDhysMe8g6gP9KfNhgtCe7g6gV9Hf2gStQe6g5gY82
					gGfzt1eqhMgX8keUfHuSeIh4gW8LaLdLtsdtirgU69U5a/sKdnjOgS45QMZXqddujZgR3JNaYjpSdvjagR24NCYdpGdrjXgR3tOOYxpodqjWgR32OdY2pvdu
					jZgR3CNQYgpNdwjagR2xM5YbpDdwjagR2xM5YbpDdwjagR2xM5YbpDdwjagR2xM5YbpDdwjagR2xM5YbpD]],
				["Toe.L"] = [[
					e6gogM/8gAgAhte6gugG/7gAgAd/e6g1gD/sgAgAbne6gzgE/xgAf7cPe7gwgE/4f+gbdee/gtf//5f4iBe0e+grgC/8f6htfte7gqgI//f/gVf8e6gpgL//
					gAfygkeog8gL/6eGf5hGeBhqgJ/UZhf3gudiihgG9kT0gEf2dajHgE6/O3gjfKdgjWgC46L/g+ezdijXgC4lLnhCewddjTgD5kM0g1e5ddjRgD5vNEgze7dh
					jXgC4xL1hAeydijYgC4eLehEewdijYgC4eLehEewdijYgC4eLehEewdijYgC4eLehEewdijYgC4eLehEew]],
				["UpperLeg.R"] = [[
					hGiDgO7Bh3gAxBhGiGgc80h2gOtxhGiIgm9xh1gXrlhGiIgj9ih4gQsKhGiGgg9ChngntUhIiEgi8Zgxh4umhIiEgd7/g8hjvYhGiEgW77hsgYvhhFiDgR7n
					h+f4wCg9iEgP7ngPfEwHgkiCgO8CcGdIuof/h6gO7uWkbWsBfdhrgO6TRdaepdfKhfgO42OWaTn2fHhcgO4nN7aTnofPhjgO5VPQaUoUfRhkgO5dPhaVodfJ
					hegO4wOLaTnwfGhcgO4hNxaTnjfGhcgO4hNxaTnjfGhcgO4hNxaTnjfGhcgO4hNxaTnjfGhcgO4hNxaTnj]],
				["LowerLeg.R"] = [[
					hIhdf7t+fAgA8xhIhlgCxNfBf568hIhsgHzLfBf05lhIhqgFyqfGfz59hJhngFxpeogD6phNhigKwfdMgy7QhMhhgHvudegr7vhJhhgAvieugF77hIhff8u+
					fNf38Qg7hgf6t9eNeR8rgZhif2swcWaI8gfshifxrOaTU17NfGhdfuphYyQK5FezhXfsoVYCNY3UewhWfroKX8NA3Ce4hZfsosYPOM34e6hafsoyYTOb4Cey
					hWfroQYANO3MewhVfroGX6M428ewhVfroGX6M428ewhVfroGX6M428ewhVfroGX6M428ewhVfroGX6M428]],
				["Foot.R"] = [[
					hGg5gY8VgAgAu2hGg8gV93gAgArdhGhAgU+pgAgApMhGg/gU+dgCf8pzhGg8gX+DfzgYq+hHg6gf9gfDhysMhHg5ge9KfNhgtChGg6gY9Hf2gStQhFg5gW82
					gGfzt1g0g8gW8peUfIuHgIhDgU8daHdStHfShMgR7aUtbbrGeohSgP5cP2aRpCeUhTgO3uM8Z1nseShSgN3dMjZyngeahTgO4RNyZ8oGebhTgO4bOCZ+oNeT
					hTgO3nMyZznneRhSgN3WMaZxnceRhSgN3WMaZxnceRhSgN3WMaZxnceRhSgN3WMaZxnceRhSgN3WMaZxnc]],
				["Toe.R"] = [[
					hGgogM/8gAgAhthGgugG/7gAgAd/hGg1gD/sgAgAbnhGgzgD/xgAf7cPhHgvgH/4f+gbdehJgrgQ/5f4iBe0hIgqgQ/8f6htfthGgqgL//f/gVf8hFgpgJ//
					gAfygkgygsgK/7eGf6g6gCg1gH/VZhf/gFfIhCgD9jT0gjesedhNf/65O7hhdoeJhQf94xMHiUdIeGhQf94cLuicdEeOhQf+5cM6iEdQeQhPf+5nNJh/dTeI
					hQf94oL8iYdGeFhQf94VLmifdCeFhQf94VLmifdCeFhQf94VLmifdCeFhQf94VLmifdCeFhQf94VLmifdC]],
			},
		},
	},
}
