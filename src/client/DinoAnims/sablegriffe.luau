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
					gAiugVABgAgAgjgAi0gVABgAgAgjgAi3gVABgAgAgjgAi3gVABgAgAgjgAi0gVABgAgAgjgAiugVABgAgAgjgAi0gVABgAgAgjgAi3gVABgAgAgjgAi3gVAB
					gAgAgjgAi0gVABgOgEgXgAiugVABgAgAf+gAi0gVACfAfxfugAi3gVAEeWfifvgAi3gVAEeUfSfwgAi0gVADe6fEfvgAiugVACf4e5ftgAi0gVADg3e1frgA
					i3gVAEhfe7fqgAi3gVAEhgfLfrgAi0gVACg8fjftgAiugVABgAgAftgAi0gVACfEgdftgAi3gVAEegg1frgAi3gVAEehhFfqgAi0gVADfJhLfrgAiugVACgI
					hHftgAi0gVADhGg8fvgAi3gVAEhsgufwgAi3gVAEhqgefvgAi0gVACg3gNf2gAiugVABgAgAgIgAi0gVABf3f+gbgAi3gVABgAgAgjgAi3gVABgAgAgjgAi0
					gVABgAgAgjgAiugVABgAgAgjgAi0gVABgAgAgjgAi3gVABgAgAgjgAi3gVABgAgAgjgAi0gVABgAgAgj]],
				Spine1 = [[
					gAivgAARgAgAkBgAi0gAARgAgAkBgAi3gAARgAgAkBgAi3gAARgAgAkBgAi0gAARgAgAkBgAivgAARgAgAkBgAi0gAARgAgAkBgAi3gAARgAgAkBgAi3gAAR
					gAgAkBgAi0gAAPgRgLjugAiugAAKgAgAjEgAizgAAKe1fPirgBi2gAAOeEeqitgBi3gAAPeBeaiugBizgAAMereiirgBiugAAJfxe6iogCizgAAJg6fZiogB
					i2gAALhof1ipgBi2gAALhrgEipgBizgAAJhDgGipgAiugAAIgAgAiof/izgAAJe9f6ipf/i2gAALeVf8ipf/i2gAALeYgLipf+izgAAJfGgniof/iugAAJgP
					hGiof/izgAAMhVheirf/i3gAAPh/hmiuf/i2gAAOh8hWitgAizgAALhBgqi3gAivgAAMgAgAjVgAi0gAAQf1f5j0gAi3gAARgAgAkBgAi3gAARgAgAkBgAi0
					gAARgAgAkBgAivgAARgAgAkBgAi0gAARgAgAkBgAi3gAARgAgAkBgAi3gAARgAgAkBgAi0gAARgAgAkB]],
				Spine2 = [[
					gAi6fYA5gAgAnagAi/fYA5gAgAnagAjCfYA5gAgAnagAjCfYA5gAgAnagAi/fYA5gAgAnagAi6fYA5gAgAnagAi/fYA5gAgAnagAjCfYA5gAgAnagAjCfYA5
					gAgAnagAi+fXAzgVgSm/gAi2fXAmgAgAmFgCi6fXAkeievljgEi+fXArdld2lmgFi+fXAtdgdnlmgFi6fXAneUeCljgEi1fXAhfre8lfgDi6fXAhhFf8lggC
					i9fXAkh/grligBi9fXAliDg6ljgBi6fXAihSgolhgAi1fXAfgAgAlff/i6fXAieufYlhf/i9fXAld9fGljf+i9fXAkeBfVlif9i6fXAhe7gElgf8i1fXAhgV
					hElff7i6fXAnhsh+ljf7i+fXAtigiZlmf8i+fXAribiKlmf+i7fXAmhRhGlzgAi3fXArgAgAmdgAi+fYA1fyf0nIgAjCfYA5gAgAnagAjCfYA5gAgAnagAi/
					fYA5gAgAnagAi6fYA5gAgAnagAi/fYA5gAgAnagAjCfYA5gAgAnagAjCfYA5gAgAnagAi/fYA5gAgAna]],
				Neck1 = [[
					gAjDfFEmgAgAwfgAjIfFEmgAgAwfgAjLfFEmgAgAwfgAjLfFEmgAgAwfgAjIfFEmgAgAwfgAjDfFEmgAgAwfgAjIfFEmgAgAwfgAjLfFEmgAgAwfgAjLfFEm
					gAgAwff/jHfEEggZgLwVgAi+fDETgAgAv/gDjCfDEQeMfTvygGjFfDEYc/eyvzgHjFfDEac2elvzgHjCfDETdweuvxgGi8fDEMfVfHvwgEjBfDEMhAflvxgC
					jEfDEQiGf+vygBjFfDERiPgKvygAjBfDENhbgKvxgAi8fDELgAgAvxgAjBfDENelf2vxf/jFfDERdxf2vyf+jEfDEQd6gCvyf8jBfDEMfAgbvxf6i8fDEMgr
					g5vwf5jCfDETiQhSvxf5jFfDEajKhbvzf6jFfDEYjBhOvzf9jDfDEShjgnv4gAjAfEEYgAgAwIgAjHfEEifvf5wYgAjLfFEmgAgAwfgAjLfFEmgAgAwfgAjI
					fFEmgAgAwfgAjDfFEmgAgAwfgAjIfFEmgAgAwfgAjLfFEmgAgAwfgAjLfFEmgAgAwfgAjIfFEmgAgAwf]],
				Neck2 = [[
					gAjpewGIgAgAyzgAjuewGIgAgAyzgAjyewGIgAgAyzgAjyewGIgAgAyzgAjuewGIgAgAyzgAjpewGIgAgAyzgAjuewGIgAgAyzgAjyewGIgAgAyzgAjyewGI
					gAgAyzf/jtevGBgagJypgAjkeuFygAgAyUgDjnetFueJfeyIgFjqetF2c5fDyIgGjretF4cve3yIgHjnetFxdpe7yHgHjhetFqfRfKyGgGjmetFqg9ffyHgF
					jpetFviFfyyIgDjpetFviQf+yIgCjmetFrhbgCyHgAjhetFpgAgAyHf+jmetFrelf+yHf9jpetFvdwgCyIf7jpetFvd7gOyIf6jmetFqfDghyHf5jhetFqgv
					g2yGf5jnetFxiXhFyHf6jretF4jRhJyIf7jqetF2jHg9yIf+joetFxhmgeyOgAjleuF4gAgAydgAjtewGDfvf6ysgAjyewGIgAgAyzgAjyewGIgAgAyzgAju
					ewGIgAgAyzgAjpewGIgAgAyzgAjuewGIgAgAyzgAjyewGIgAgAyzgAjyewGIgAgAyzgAjuewGIgAgAyz]],
				Head = [[
					gAkMel//gAgAgQgAkRel//f9fqgDgAkUel/+f6fUfwgAkUel/+f4fAfXgAkRel/8f3ese7gAkMel/6f3ebeggAkRel/4f3eNeHgAkUel/2f3eBdzgAkUel/1
					f4d4dngAkPek/4fld9eZgAkGeh/+f6fUgQgBkIeg/5hKhihWgDkMeg/zh6iohTgEkMeh/xh7i4hSgGkJeg/2hPiShXgHkDeg/8gGhHhcgIkIeg/8e8f1hbgI
					kLeg/5eNe7hYgGkLeg/4eMerhXgDkIeg/7e4fIhagAkDeg/9gAgAhcf9kIeg/7hIg4haf6kLeg/4h0hVhXf4kLeg/5hzhFhYf4kIeg/8hEgLhbf5kDeg/8f6
					e5hcf6kJeg/2exduhXf8kMeh/xeFdIhSf9kMeg/zeGdYhTf/kKeh/8fDe/g1gAkHei/+gJhHfhgAkQek/4gViGeVgAkUel/3gLiHeHgAkUel/5gLh/eggAkR
					el/7gMhze7gAkMel/8gMhkfXgAkRel/9gLhTfwgAkUel/+gJhAgDgAkUel/+gGgsgQgAkRel//gDgWgU]],
				Jaw = [[
					gAkGeE/tgAgAkNf/kLeE/qgAfqkhf/kPeE/pgBfUkrf+kQeE/ogDe/kqf9kNeE/pgGeskef9kJeE/rgJebkHf8kPeE/ugLeNjpf8kTeE/xgMeBjHf8kTeE/0
					gNd5iif7kNeD/zf3d7ivf/j/eA/tf/fUkNgFkAeA/fg+hqlSgJkEeB/Zhki2lOgLkEeB/YhjjGlNgLkAeA/cg8iblSgKj6eA/hf9hHlYgHj/d//he9ftlXgF
					kDeA/eeXetlTgDkDeA/eeYedlTgBkAeA/gfAe/lWgAj6d//igAgAlYf/kAeA/ghAhBlWf9kDeA/ehohjlTf7kDeA/ehphTlTf5j/d//hhDgTlXf2j6eA/hgD
					e5lYf1kAeA/cfEdllSf1kEeB/Yedc6lNf3kEeB/ZecdKlOf8kCeA/lfLe4k3gCkDeB/ygAhHjegFkNeD/1gFiIiSgEkSeE/2f6iIiEgEkSeE/1f8h/idgEkN
					eE/zf+h0i4gDkHeE/yf/hljUgDkMeE/wgAhUjtgCkOeE/ugBhBkAgBkOeE/tgBgskNgBkLeE/tgBgWkR]],
				["UpperArm.L"] = [[
					fdixe364QvX4hafdi2e364QvX4hafdi5e364QvX4hafdi5e364QvX4hafdi2e364QvX4hafdixe364QvX4hafdi2e364QvX4hafdi5e364QvX4hafdi5e364
					QvX4hafci0e46pQbXyh4fdire36yQaYiijfjire07YRTYghPfoitez7ZSgWke+fpitey7fSjWxe2foirez7lRXZGg5fkioe17CQSZxiiffive46KPZYoi2fc
					i1e65jO4XzjEfbi1e65eO4XmjLfbiwe559PZYBjKfdioe36vQRY1jDffire27LRQX8hkfgite168STVhflfeite162SRVVfsfbire368RNXXh6fXioe66aQR
					X5jkfTixe95gPbW1jxfSi2e+49O8WSj0fTi2e+5DO7WfjufYixe657PmXgjLfdise360QfYWiOfei0e268QzX/hYfdi5e364QvX4hafdi5e364QvX4hafdi2
					e364QvX4hafdixe364QvX4hafdi2e364QvX4hafdi5e364QvX4hafdi5e364QvX4hafdi2e364QvX4ha]],
				["LowerArm.L"] = [[
					fQi1efRQUFM7xUfQi7efRQUFM7xUfQi+efRQUFM7xUfQi+efRQUFM7xUfQi7efRQUFM7xUfQi1efRQUFM7xUfQi7efRQUFM7xUfQi+efRQUFM7xUfQi+efRQ
					UFM7xUfOi5egQuUINIxGfQitefQiTSNcwrfXivecPIQMPSucfbi2ebMpNNS1rBfci2ebMxNHSsq5fciveaPjP0O9uHfYipecQ7SUNOv/fSiyefPvTjNNvzfO
					i4eiO+UbNQvufMi4ejO1UlNXv0fNizehPTT+NhwDfQiqefQOS8NswYfSivedOsQfPqurfRi1efL/NtTqrofPi1egL3N0T0rvfNivegORQ2QBu8fIiqeiPjTl
					OLwvfDi0emOgU0OJwgfBi6eoN9ViOEwUfDi6enOGVYN9wPfJi0ejPPUVNrwcfQiwefQvTgNTw2fRi5eeQ5TfNPw7fQi+efRQUFM7xUfQi+efRQUFM7xUfQi7
					efRQUFM7xUfQi1efRQUFM7xUfQi7efRQUFM7xUfQi+efRQUFM7xUfQi+efRQUFM7xUfQi7efRQUFM7xU]],
				["UpperArm.R"] = [[
					gjixe364vRoIhagji2e364vRoIhagji5e364vRoIhagji5e364vRoIhagji2e364vRoIhagjixe364vRoIhagji2e364vRoIhagji5e364vRoIhagji5e364
					vRoIhagiize26+vLn+hXgjire36yvmneijgpiwe75wwlokjcgti2e+5DxFphjugui2e+49xEpuj0gtixe95gwlpLjxgpioe66avvoHjkglire368uzoph6gi
					ite162tvqrfsggite168ttqfflghire27LuwoEhkgjioe36vvvnLjDgliwe559wnn/jKgli1e65exIoajLgki1e65jxIoNjEghive46KwnnYi2gcioe17Cvu
					mPiigYirez7lupm6g5gXitey7ftdpPe2gYitez7Ztgpce+geise17TuznlhQgjise360vhnqiOgki1e36uveoMhugji5e364vRoIhagji5e364vRoIhagji2
					e364vRoIhagjixe364vRoIhagji2e364vRoIhagji5e364vRoIhagji5e364vRoIhagji2e364vRoIha]],
				["LowerArm.R"] = [[
					gwi1efRQr7zFxUgwi7efRQr7zFxUgwi+efRQr7zFxUgwi+efRQr7zFxUgwi7efRQr7zFxUgwi1efRQr7zFxUgwi7efRQr7zFxUgwi+efRQr7zFxUgwi+efRQ
					r7zFxUgvi4eeQus1ymwtgwitefQisuykwrg4izekO7royNwSg9i6enOGqoyDwPg/i6eoN9qex8wUg9i0emOgrMx3wgg4iqeiPjsbx1wvgzivegORvKv/u8gx
					i1egL3yMsMrvgvi1efL/yTsWroguivedOsvhwWurgwiqefQOtEyUwYgzizehPTsCyfwDg0i4ejO1rbypv0gyi4eiO+rlywvuguiyefPvsdyzvzgoipecQ7ts
					yyv/gkiveaPjwMxDuHgki2ebMxy5tUq5gli2ebMpyztLrBgqixecPYvTxFu3gwiwefQvsgytw2gxi5efQ6r5y9xKgwi+efRQr7zFxUgwi+efRQr7zFxUgwi7
					efRQr7zFxUgwi1efRQr7zFxUgwi7efRQr7zFxUgwi+efRQr7zFxUgwi+efRQr7zFxUgwi7efRQr7zFxU]],
				Tail1 = [[
					gAiugvgSgAgA//gAizgvhEgNf//+gAi2gvhjgaf9/8gAi2gvhjgnf7/8gAizgvhEgyf7/9gAiugvgSg8f7/+gAizgvhEhFf5/9gAi2gvhjhMf3/7gAi2gvhj
					hRf2/7gAi0gvg5hHfq/9gAivgvfthVf4/9gAi1gvgLiQgs/5f/i4gvgliuhN/2f/i4gvgmiahQ/3f+i1gvgMhUg1/9f+ivgvfcf1gB//f+i1gvgMecfO/8f+
					i4gvgmdmew/3f/i4gvgndpev/3f/i1gvgMekfM/8gAivgvfcgAgA//gBi1gvgMhcg0/8gBi4gvgniXhR/3gCi4gvgmiahQ/3gCi1gvgMhkgy/8gCivgvfcgL
					f///gCi1gvgMesfL/9gBi4gvgmdmew/3gBi4gvgldSez/2gAi0gvgTd4fb/6gAivgvf3ergI/9gAizgvg9e1gR/9gAi2gvhjevgK/7gAi2gvhje0gJ/7gAiz
					gvhEe7gH/9gAiugvgSfEgF/+gAizgvhEfOgF/9gAi2gvhjfZgF/8gAi2gvhjfmgD/8gAizgvhEfzgB/+]],
				Tail2 = [[
					gAiuhSgffQgE/+gAixhSiDfogB/7gBizhSjBgCf+/2gBizhSjBgbf7/2gCixhSiDg0f5/6gCithSgfhMf6/9gCixhSiDhhf0/4gDizhSjBh0fw/ygDizhSjB
					iEfu/xgCiyhSh4hpfl/5gDiwhSf6hpf1/8gEi0hShHjhge/xgFi3hRh7lQgz/fgEi3hSh6lqgx/agBi0hShFkjgb/pf+ixhSfpiRfw/6f7i0hShNfnfI/9f5
					i3hSiEdge3/zf6i3hSiCcve9/vf8i0hShJdlfW/3gAixhSfpfogD//gEi0hShKiFgs/5gGi3hSh/kAg+/qgHi3hSh+kig6/mgFi0hShHjcgi/ygCixhSfphE
					f4/+f/i0hShKeKfS/6f8i3hSh+btfE/of7i3hRh6aifP/cf8i0hShNbTfx/nf9ivhSgEdAgT/2f9ixhSh8dpga/1f9izhSjBdegU/vf9izhSjBdggU/wf+ix
					hSiDdmgR/1f+ithSgedwgM/6f+ixhSiDd+gO/3f/izhSjBePgN/zf/izhSjBeigK/0gAixhSiDe4gH/6]],
				Tail3 = [[
					f+ish1f+eAgJ/7gAith0iVeegF/3gBith0jye/gA/wgCith0jyfif8/wgDith0iVgFf7/6gFish0f+gpf9//gGish0iVhLf0/4gGith0jyhqfu/ugHithzjy
					iIfr/sgGiuh0iKhffk/4gGiwh0fZg1f7/+gMiyhzhajHge/zgQizhyiomMgn/RgQizhyiin4gf+5gLiyhzhQnjgK/EgDixh0fJlWff/hf6iyh0hjh/e+/4f0
					izhzi4ese3/0fyizhziycyfB/sf3iyh0hac9fb/zf/ixh1fIfAgG/9gIiyh0hbiJgr/4gPizhzislJgz/cgRizhyinmrgq/KgNiyhzhTmFgT/YgEixh0fJje
					fr/yf7iyh0hefmfM/8fzizhzivbufL/kfvizhyimZNfd/JfyixhzhcZaf8/Rf3ivh0fjbmgX/rf4ith0iOc0ge/wf4ithzjxcpga/lf4ithzjxchgZ/kf5is
					h0iUcfgV/tf5ish0f+cigP/zf6ish0iVcrgS/uf7ith0jxc6gS/nf8ith0jxdNgP/pf9ith0iVdkgL/0]],
				Tail4 = [[
					f6itiXfFcsgJ/zf8iniWiOdJgE/yf/ikiVkJdqf9/ogBikiVkJeOf5/rgEiniWiOe2f6/5gGitiXfEfggB/+gIiniWiNgJf0/6gKikiVkJgyfq/tgMikiVkJ
					hbfo/sgJipiWiCgsfl/6gIixiXeffLgD/8gTiviVhVhKgi/8geiuiSjClQgi/aghiuiQi5oVga+wgbiviShHpSgI+mgOiziVeSn8fe+8f+iuiWhgkte8/lfw
					itiVjVgwe5/yfritiVjNdxfE/vfwiviWhTc5fa/zf9iziXePeWgH/5gNiviWhVhogs/6gaitiTjDlcgw/XgfiuiSi7oGgm+zgaiwiUhJojgR+zgMiziWeRmi
					fk/Rf6iviXhciffJ/2fpitiUjLdpfP/vfhiuiRi/Zvfi/OfkiuiShUY1f8/JftiwiVera8gR/jfyioiViHcqge/vfxikiUkJcjgc/hfxikiUkJcOgb/ffxin
					iViOb+gU/qfyisiWfFb1gL/tfziniViOb0gR/of0ikiVkJb6gS/df2ikiVkJcFgO/ef4iniWiOcVgK/t]],
				Tail5 = [[
					fziui5dsb0f//of2iji4hncHf7/tf6ici3kBchfz/if9ici3kBc/fv/mgBiji5hmdjfy/2gFivi6dreKgA/2gIiji4hme1fu/7gLici2kAfgfg/ugPibi2kA
					gNfe/vgLiki5hafhfg/9gGi0i5dHdQgD/vgVisi4gxeXga/8gpiniyi8ixgV/ugyioitiym4gU/HguitiughpNgU+ogfi2izc+pLfy+fgIiri3g+myfJ/Pfy
					ili3jRi7fH/rfmimi2jHfUfN/0fqisi4gsdbfY/3f5i3i5c2d6gD/xgRisi5gvgsgr/+gminizi8kxgt/fgwioivizoVgp+wgritixgip/gg+Ygai3i2c+pJ
					fz+gf/iri5g6lwfX/cfkimi1jHgwfh/1fTioiwi5b8ft/mfVisixguZxf2/Xfiizi2dSbRgD/hfqiki3hfdNgc/1fqibi1kBdNgg/nfpibi1kBctge/kfoij
					i2hncQgQ/ufpiui3dsb6f//pfqiji3hnbrgL/qfsici1kBbkgO/bfuici1kBbjgJ/bfwiji3hnbngC/p]],
				["UpperLeg.L"] = [[
					fWh2gH8Jerf0vKfWh7gH8Jerf0vKfWh/gH8Jerf0vKfWh/gH8Jerf0vKfWh7gH8Jerf0vKfWh2gH8Jerf0vKfWh7gH8Jerf0vKfWh/gH8Jerf0vKfWh/gH8J
					erf0vKfVh8gI8KewfuvHfWh2gJ8bepfxunfah4gK8yeSgKt3fch6gJ82eBgjtrfdh6gI8xd5gyt0fbh4gI8ld8g2uNfXh1gH8ReFgzu1fUh9gH74eTgtvkfS
					iCgI7negglwEfRiCgI7qeogYwAfTh9gJ8CeqgEvWfWh2gK8ieofwuZfZh4gM89emfgthfbh6gN9NenfSs+fbh6gN9QeufDs1fYh4gN9Ge7e0tLfVh2gN8vfL
					ett9fSh+gN8RfYe0u6fQiDgM76fdfBvmfQiDgM74fUfOvqfTh9gK8Le+fgvHfWh2gJ8WeqfyuxfXh7gI8Penf3u9fWh/gH8Jerf0vKfWh/gH8Jerf0vKfWh7
					gH8Jerf0vKfWh2gH8Jerf0vKfWh7gH8Jerf0vKfWh/gH8Jerf0vKfWh/gH8Jerf0vKfWh7gH8Jerf0vK]],
				["LowerLeg.L"] = [[
					fUhRfvtwgqgF84fUhWfvtwgqgF84fUhZfvtwgqgF84fUhZfvtwgqgF84fUhWfvtwgqgF84fUhRfvtwgqgF84fUhWfvtwgqgF84fUhZfvtwgqgF84fUhZfvtw
					gqgF84fThXfvt+g7gK8xfUhRfvt9grgG8xfYhVfutcfffs9BfbhXfttBelfa9LfchXfss5eUfg9OfahUfttFeuf79KfXhQfutifigf8+fThXfwuHgZg78sfR
					hbfxukhAhG8cfQhbfyurhQhA8YfRhYfxuchHgr8hfUhSfwuEgsgH8ufWhWfvtygNfc83fYhZfvttgAe+84fXhZfvt1gRe480fUhXfwuJg/fN8qfRhTfyumh3
					fu8ZfOhZf0vFiigK8GfNhdf1vYizgb76fNhcf0vRijgh7/fQhYfyumhpgY8afUhRfvt5grgG8zfUhWfvtsgfgC86fUhZfvtwgqgF84fUhZfvtwgqgF84fUhW
					fvtwgqgF84fUhRfvtwgqgF84fUhWfvtwgqgF84fUhZfvtwgqgF84fUhZfvtwgqgF84fUhWfvtwgqgF84]],
				["Foot.L"] = [[
					fWglgS60gFf9xbfWgqgS60gFf9xbfWgtgS60gFf9xbfWgtgS60gFf9xbfWgqgS60gFf9xbfWglgS60gFf9xbfWgqgS60gFf9xbfWgtgS60gFf9xbfWgtgS60
					gFf9xbfWgqgS60gTf0xbfWglgS60gGf8xbfWgqgS6zfHglxbfWgtgS6xeYhExZfWgtgS6weJhNxZfWgqgS6yedhAxafWglgS6zfHglxbfWgqgS60f0gIxbfW
					gtgS60gUfzxbfWgtgS60gifqxbfWgqgS60gbfuxbfWglgS60gGf8xbfWgqgS60fvgLxbfWgtgS60flgRxbfWgtgS60f0gIxbfWgqgS60gZfwxbfWglgS6zhG
					fSxbfWgqgS6xhpe8xZfWgtgS6wh3ezxZfWgtgS6xhpe8xZfWgqgS6zg5fbxbfWglgS60gGf8xbfWgqgS60f8gCxbfWgtgS60gFf9xbfWgtgS60gFf9xbfWgq
					gS60gFf9xbfWglgS60gFf9xbfWgqgS60gFf9xbfWgtgS60gFf9xbfWgtgS60gFf9xbfWgqgS60gFf9xb]],
				["Toe.L"] = [[
					fWgNgI/8gDf7hmfWgSgI/8gDf7hmfWgWgI/8gDf7hmfWgWgI/8gDf7hmfWgSgI/8gDf7hmfWgNgI/8gDf7hmfWgSgI/8gDf7hmfWgWgI/8gDf7hmfWgWgI/8
					gDf7hmfWgSgI/8gKfshmfWgNgI/8gDf6hmfWgSgI/7fig8hmfWgWgI/5fIhvhmfWgWgI/4fAh+hmfWgSgI/5fLhphmfWgNgI/7fhg9hmfWgSgI/8f5gNhmfW
					gWgI/8gLfqhmfWgWgI/8gSfchmfWgSgI/8gPfjhmfWgNgI/8gDf5hmfWgSgI/8f3gShmfWgWgI/8fygdhmfWgWgI/8f5gNhmfWgSgI/8gOflhmfWgNgI/7gm
					e1hmfWgSgI/5g5eQhmfWgWgI/4hAeChmfWgWgI/5g5eQhmfWgSgI/7gffDhmfWgNgI/8gDf6hmfWgSgI/8f+gEhmfWgWgI/8gDf7hmfWgWgI/8gDf7hmfWgS
					gI/8gDf7hmfWgNgI/8gDf7hmfWgSgI/8gDf7hmfWgWgI/8gDf7hmfWgWgI/8gDf7hmfWgSgI/8gDf7hm]],
				["UpperLeg.R"] = [[
					gqh2gH8JhVgMvKgqh7gH8JhVgMvKgqh/gH8JhVgMvKgqh/gH8JhVgMvKgqh7gH8JhVgMvKgqh2gH8JhVgMvKgqh7gH8JhVgMvKgqh/gH8JhVgMvKgqh/gH8J
					hVgMvKgph7gI8ThbgIu3gqh2gJ8bhXgPunguh9gL8KhAgjvIgwiDgM74gsgyvqgwiDgM76gjg/vmguh+gN8RgohMu6grh2gN8vg1hTt9goh4gN9GhFhMtLgl
					h6gN9QhSg9s1glh6gN9NhZgus+gnh4gM89haggthgqh2gK8ihYgQuZgth9gJ8ChWf8vWgviCgI7qhYfowAguiCgI7nhgfbwEgsh9gH74htfTvkgph1gH8Rh7
					fNu1glh4gI8liEfKuNgjh6gI8xiHfOt0gkh6gJ82h/fdtrgnh5gJ8shrf5uCgqh2gJ8WhWgOuxgrh8gI8KhRgQvIgqh/gH8JhVgMvKgqh/gH8JhVgMvKgqh7
					gH8JhVgMvKgqh2gH8JhVgMvKgqh7gH8JhVgMvKgqh/gH8JhVgMvKgqh/gH8JhVgMvKgqh7gH8JhVgMvK]],
				["LowerLeg.R"] = [[
					gshRfvtwfWf784gshWfvtwfWf784gshZfvtwfWf784gshZfvtwfWf784gshWfvtwfWf784gshRfvtwfWf784gshWfvtwfWf784gshZfvtwfWf784gshZfvtw
					fWf784grhWfutqfmgA87gshRfvt9fVf68xgwhYfyuweNfl8Vgzhcf0vRddff7/gzhdf1vYdNfl76gyhZf0vFdef28GgvhTfyumeJgS8ZgshXfwuJfBgz8qgp
					hZfvt1fvhI80gohZfvttgAhC84gqhWfvtyfzgk83gshSfwuEfUf58ugvhYfxuce5fV8hgwhbfyurewfA8YgvhbfxukfAe68cgthXfwuHfnfF8sgphQfutige
					fh8+gmhUfttFhSgF9KgkhXfss5hsgg9OglhXfttBhbgm9LgphVfutegWgQ9AgshRfvt5fVf68zgthWfvt5fLf48zgshZfvtwfWf784gshZfvtwfWf784gshW
					fvtwfWf784gshRfvtwfWf784gshWfvtwfWf784gshZfvtwfWf784gshZfvtwfWf784gshWfvtwfWf784]],
				["Foot.R"] = [[
					gqglgS60f7gDxbgqgqgS60f7gDxbgqgtgS60f7gDxbgqgtgS60f7gDxbgqgqgS60f7gDxbgqglgS60f7gDxbgqgqgS60f7gDxbgqgtgS60f7gDxbgqgtgS60
					f7gDxbgqgqgS60gIf7xbgqglgS60f6gExbgqgqgS6ze/gqxbgqgtgS6xeXhExZgqgtgS6weJhNxZgqgqgS6xeXhExZgqglgS6ze6guxbgqgqgS60fngQxbgq
					gtgS60gMf4xbgqgtgS60gbfvxbgqgqgS60gRf1xbgqglgS60f6gExbgqgqgS60flgSxbgqgtgS60fegWxbgqgtgS60fsgNxbgqgqgS60gMf4xbgqglgS6zg5
					fbxbgqgqgS6yhjfAxagqgtgS6wh3ezxZgqgtgS6xhoe8xZgqgqgS60gwfhxbgqglgS60f6gExbgqgqgS60fygJxbgqgtgS60f7gDxbgqgtgS60f7gDxbgqgq
					gS60f7gDxbgqglgS60f7gDxbgqgqgS60f7gDxbgqgtgS60f7gDxbgqgtgS60f7gDxbgqgqgS60f7gDxb]],
				["Toe.R"] = [[
					gqgNgI/8f9gFhmgqgSgI/8f9gFhmgqgWgI/8f9gFhmgqgWgI/8f9gFhmgqgSgI/8f9gFhmgqgNgI/8f9gFhmgqgSgI/8f9gFhmgqgWgI/8f9gFhmgqgWgI/8
					f9gFhmgqgSgI/8gFf3hmgqgNgI/8f9gGhmgqgSgI/7fdhFhmgqgWgI/5fHhwhmgqgWgI/4fAh+hmgqgSgI/5fHhwhmgqgNgI/7fahLhmgqgSgI/8fygbhmgq
					gWgI/8gHfzhmgqgWgI/8gOfjhmgqgSgI/8gJfuhmgqgNgI/8f9gHhmgqgSgI/8fxgdhmgqgWgI/8fugkhmgqgWgI/8f1gWhmgqgSgI/8gHfzhmgqgNgI/7gf
					fDhmgqgSgI/5g1eXhmgqgWgI/4hAeChmgqgWgI/5g4eRhmgqgSgI/8gafNhmgqgNgI/8f9gGhmgqgSgI/8f4gPhmgqgWgI/8f9gFhmgqgWgI/8f9gFhmgqgS
					gI/8f9gFhmgqgNgI/8f9gFhmgqgSgI/8f9gFhmgqgWgI/8f9gFhmgqgWgI/8f9gFhmgqgSgI/8f9gFhm]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAingV/+hHf4gTgAipgV/9g6e/gVgAitgV/8gjeRgVgAiygV/6gHd3gUgAizgV/6fpd0gSgAiwgV/7fPeJgRgAirgV/8e9ezgQgAingV/+e3fqgSgAingV/9
					e+glgUgAirgV/8fQhagVgAiwgV/7frh/gVgAizgV/6gJiOgTgAiygV/6gliEgRgAitgV/8g7hkgQgAipgV/9hHgygR]],
				Spine1 = [[
					gAimgAAKe6gPixf/iogAALfIgxi5f+itgAANfghLjNf9ixgAAPf+hYjgf9iygAAQgchVjmf+ivgAAOg0hDjaf+irgAAMhEgnjFgAingAAKhIgEi0gBingAAK
					hAffizgCiqgAAMgtfAjCgDivgAAOgRetjYgDiygAAQfzeojlgDixgAAPfXeyjigCitgAANfDfKjQgBiogAALe5fqi7]],
				Spine2 = [[
					f/itfXAke8gVlxf8iwfXAnfGgimCf7i1fXAvfcgpmqf6i6fYA3f4gnnPf6i8fYA5gVgenZf7i4fYAzgtgRnAf9izfXArg9gCmWgAiufXAlhFfyl1gCiufXAk
					hBfkl1gFiyfXAqgwfamUgGi4fYAzgXfXm/gGi8fYA5f5fdnYgGi7fYA3fffonQgEi2fXAvfKf3mrgCiwfXAne+gGmD]],
				Neck1 = [[
					f+i1fDD/fGgqvYf8i3fDDyfTgyvBf6i+fEETfqgyv9f5jEfEFQgGgoxhf5jFfFGCgfgUyrf7jCfEGEgwf+ysf9i7fDFTg5frxkgAi2fDEVg8fcwAgDi1fDDy
					g1fSvCgGi6fED9gjfNvWgHjBfEEwgIfSwugHjFfFFtftfhyNgGjEfEGKfYf3y2gEi+fEFwfLgMyQgBi4fDEyfEgdwy]],
				Neck2 = [[
					f8jZesFyfLgwySf5jberF0fZg3yVf3jjeuGRfwg0y+f4jrezG3gJgnzxf5jue3HOgggS0Nf8jqe2HEgwf80Bf/jieyGhg4fnzTgDjbetF9g4fXyhgGjZerFv
					gvfMyOgIjfesF/gdfJymgJjoexGkgEfRzYgIjue1HGfrfj0EgFjte3HNfXf50MgCjne1G0fLgPzsf/jeewGNfHgiy4]],
				Head = [[
					f5j7efAGe6gNh/f2j9efAHfAf2iMf1kGekAIfTfhilf3kOerAKfvfRi5f6kSewAKgMfIi7f9kOevAJgmfKiqgBkFepAHg5fViRgFj9eiAGhEfoiAgIj7eeAG
					hFf+iDgKkBehAHg4gUiYgKkKenAJgggoiwgIkReuAKgCg1i9gFkQewAKfmg4i1gBkKesAIfQgyief9kBelAHfAgiiG]],
				Jaw = [[
					f5j6d+/0hHf+jGf3j8d+/2g+gUi5f3kFeC/4gogmimf4kPeJ/2gJgyi3f7kSeO/1fqg1i+f/kOeN/2fRgvi1gCkEeH/2fBghi0gGj8eA/0e5gNjFgIj6d9/1
					e8f3jCgJkAd//3fMfjitgJkKeG/3fnfTivgGkReN/2gHfMi8gDkReP/1gjfNi7f/kJeL/3g4fXitf8j/eE/1hEfoi+]],
				["UpperArm.L"] = [[
					fdife4xxQYmX0kfaiie4yXQTlq0MfXipe4zzP3j+y2fWiwe41dPThywwfWize420OzfsuXfXiwe43tOdeIsPfZiqe44LOOdPqufcike34YOFc7p6ffike34Z
					OBdIpzfiipe24QODdxqZfkive230OMe6rvflize226Ocgktxfkiwe21fO3ikwKfiipe2zxPckhyYfgiie3yUQCl7z8]],
				["LowerArm.L"] = [[
					fRiFe1zM12YjrEfOiIe00B2ZaApOfLiRew1W24c6l6fIibes2d2sgph6fIiien2611kVePfJiiek220wnNbnfLieei2pz/o5aUfOiaeh2mzzpWaQfSiaeg2w
					0MoqbPfVideg2+09m8dIfXiheh3A10kSf2fYihek2l2bg9jLfYibep1n2fddmpfWiReu0V2HagphfUiJezzV1wYvrI]],
				["UpperArm.R"] = [[
					gjike34ax+jCpxgfime24Wx/inqAgdise24Fx5hvq+gciye23bxtgVsrgciye22QxYeeu9gdite20ow3cbxVgfile3y+wQaszRgiige3x6vwZu0Yglife4x7
					vnZ30ggoile4zAv5bGzogqite40pwbdHx3grize42Mw+fUvjgqiye43UxZhLtPgoite43/xsiarZgmime34Tx3i/qP]],
				["LowerArm.R"] = [[
					gwiZehJWz8pJlYgtibegJI0in7j8gqifehI+1ZlthngoiiejJJ2LirejgoifemJ22hfLbEgpiWerLC2Vb3XzgriNexMQ15ZcVfgtiGe0M31uYcUsgwiGe1Mg
					2FZFVpg0iMezLW2sbTYTg3iWeuKC24eucEg4ifepJP2VijgCg4iiemJF1Rl6jPg2igejJR0ToNlNg0iceiJaz0pRl3]],
				Tail1 = [[
					gAiogvevhFhC/7gCiqgveAg3g+/5gDiugvdxgggu/5gEizgveLgFgW/8gEi0gve/fof7/+gDixgvfofOfi/+gCisgvfte9fN/9gBiogvfJe4fB/8f/iogveV
					fBe+/6f+isgvdzfUfJ/5f9ixgvd5ftfd/6f8i0gvekgJf4/9f9izgvfXglgS/+f9iugvfwg8gp/+f/iqgvffhHg6/9]],
				Tail2 = [[
					gCiqhSexjCgx/0gDiuhSdRh5g2/zgEizhRcbgdgw/xgEi3hScye+gd/zgDi2hSeIdpgG/2gBixhSfjcsfy/0gAishSgIcUfi/xf+iqhSfdcmfU/zf9ishSeA
					dffL/0f8ixhScte0fL/yf8i1hRccgTfZ/yf9i3hSdYhvfv/1f+i0hSe5i5gF/1f/ivhSf/jlgX/ygBirhSf8jpgl/x]],
				Tail3 = [[
					gJith0edljgd/dgHi0hzcZj4gl/igFi7hzaxhjgl/hgBi+hzaqfAgY/hf+i6h0cHcogD/kf6izh0eMayfy/gf4ish0fhZ1fq/Yf3irh0fNZ+fm/Zf4iwh0dd
					bMff/hf6i4hzbddPfZ/if9i9hzaffufg/ggAi8h0bOiPfz/jgEi2h0dKkZgH/jgHivh0fBl1gT/cgJirh0flmQgY/X]],
				Tail4 = [[
					gVixiUd0oHgT+3gPi8iUbomYgQ/CgIjGiUZWjlgR/Ff/jJiUYegMgG/Ff2jCiUZmcyfw/Lfvi2iUb+Z4fd/IfritiUeCYBfc+6fqitiUeZXjfo+0fui2iUc2
					Ymfv+9f0jCiUaZa7fv/Ff9jJiUYqeFfz/FgFjHiUYzhjgE/IgNi8iUaukxgb/LgTixiUdJnNgm/CgWisiUeeoage+0]],
				Tail5 = [[
					gmi1iyceqMgl+HgdjFizano6gK+PgPjUizYAmGf9+Xf/jZizWZiTfu+bfwjQi0W0eHfT+lfii/izZBaNe3+qfaiyiybjXQez+bfZixixctV2fL+Jfei9iybv
					WQfq+KfqjOizZSYWf9+Uf5jYizW/bugJ+ZgJjWizWVfyge+fgXjIi0Xxj7g8+pgii3iyaXnchP+kgoiwixcYprhE+Q]],
				["UpperLeg.L"] = [[
					fahrgL1Meugh37fZhtgN4Fezfj1BfXhzgP7PewepwrfVh5gQ+Reldjp9fUh7gQ/mencPi6fSh5gP/te/b4f1fSh1gO/0fIc8gvfShxgL/oe4emkafThxgJ/E
					eYfynbfUh0gH+bd6gppnfWh4gF9KdphZs2fYh5gF7pdihzvzfah3gF6Tdoh3x9fbhygG5Gd3hmzpfbhtgI3jePhG1j]],
				["LowerLeg.L"] = [[
					fYg+gQnbfZf2/HfVhBgHjUgNfV/zfShLf7iVhNfI/3fNheftlaiifc/bfJhzflrrj5gX9hfHh6fkxGkRhV6qfJhzfi0Rjehl4cfNhlfg16iHhQ3LfRhdfh0/
					g2hG4GfUhafiyVfyhE6MfXhXfnwRe9hA7gfZhTfuugedg88dfahOf1sbeUgz9afahHf8qBefgj+VfahAgEn/e5gO+9]],
				["Foot.L"] = [[
					fWglhD6zfAgpxbfWg1g+6jfwgLx2fWhDgz6VgrfjyJfWhLgh6LhvezyRfWhNgN6EiseHyQfWhIf66Hi+d8yIfWg9fr6ViYeYx8fWgtfj6phTfJxofWglfp60
					gNf3xbfWglf160fTgdxbfWglgC6yeng6xafWglgP6weMhLxZfWglgc6weEhQxZfWglgp6xeOhKxZfWglg26yekg8xa]],
				["Toe.L"] = [[
					fWgNg4/7fehEhmfWgdg1/7f4gRiGfWgrgp/4gWfRidfWgzgY/zg5eFiqfWg1gF/thYdBisfWgwfx/rhicuikfWglfi/xhQdaiSfWgWfZ/5gsemh3fWgNfe/8
					gHfyhmfWgNfr/8fogwhmfWgNf4/6fQhfhmfWgNgF/4fCh7hmfWgNgS/3e9iEhmfWgNge/4fCh6hmfWgNgr/6fPhihm]],
				["UpperLeg.R"] = [[
					guhxgK/JhUgknKgshygI+1h5fzoTgrh2gG93iQe9rMgph5gF8aiceXuagnh5gF68iceJw+gmh1gG5tiSePy0glhvgH4Zh+eo0jgmhrgJ2ghifM2rgnhsgM2q
					hOf+2jgohwgO5mhNg6zHgqh2gQ83hVh3tmgsh6gQ/NhejImKgth6gQ/shOkJgxguh3gP/wg5juf4guhzgM/0g+iRiQ]],
				["LowerLeg.R"] = [[
					gwhdfi2eene+2sgthcfhzmfte65QgqhYfkxPgre/67gohVfrvZhWfC8AgmhQfythhqfI87glhKf4rPhpfU95gmhDgAo5hVfn+sgng/gKndg3f9/Ggpg/gMlB
					gOgb/mgshFgBiYfVg1/4gwhUfzjUeLgz/wg1hqfooYcvgK+sg5h5flurbwfG8Gg5h4fjy8cBed5bg1htfh1PdLej3u]],
				["Foot.R"] = [[
					gqglfi60fTgdxbgqglfv60gRf1xbgqglf86zhFfTxbgqglgJ6xhpe8xZgqglgW6wh6exxZgqglgi6wh5exxZgqglgv6xhoe8xZgqglg86zhOfNxagqgthC6r
					gpflxpgqg9g56cf0gIyBgqhIgq6Qe0g1yOgqhNgX6HdvhlySgqhLgE6EdDiEyMgqhDfy6MdPh6yDgqg1fm6feIhRxz]],
				["Toe.R"] = [[
					gqgNfY/8fogwhmgqgNfl/8gJfuhmgqgNfx/7gle2hmgqgNf+/5g5eQhmgqgNgL/3hCd+hmgqgNgY/3hBd/hmgqgNgl/5g4eRhmgqgNgy/6gqethmgqgWg3/7
					gWfUh3gqglgw/6f6gNiTgqgwgh/2fZhUilgqg1gP/we2igisgqgzf7/refjRipgqgrfp/uekjCicgqgdfd/1fBiCiF]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAiwgV/7gAgAh+gAifgV/6f0e1h+gAijgV/4fueWh+gAi0gV/6f0e1h+gAiwgV/7gAgAh+gAifgV/6gMhLh+gAijgV/4gShqh+gAi0gV/6gMhLh+]],
				Spine1 = [[
					gAitgAAEgAgAh0f+icgAADgThJhDf+iggAAFgchnhOf+ixgAAGgWhJh/gAitgAAEgAgAh0gCicgAADfte3hDgCiggAAFfkeZhOgCixgAAGfqe3h/]],
				Spine2 = [[
					gAiyfXAggAgAlif8iffXATgahHkAf6ijfXAXgmhkkWf8i2fXAlgehFl3gAiyfXAggAgAligEiffXATfme5kAgGijfXAXfaeckWgEi2fXAlfie7l3]],
				Neck1 = [[
					gAi5fDFYgAgAxvf6ikfCD0gyg5vFf4ipfCELhIhPvrf6i+fDFyg4gzySgAi5fDFYgAgAxvgGikfCD0fOfHvFgIipfCELe4exvrgGi+fDFyfIfNyS]],
				Neck2 = [[
					gAjheyHugAgA01f5jIeqF2g4gzyYf2jOesGRhRhGy7f6jme0IMg+gs1VgAjheyHugAgA01gHjIeqF2fIfNyYgKjOesGReve6y7gGjme0IMfCfU1V]],
				Head = [[
					gAkFetATgAgAkLf5jqeeAIgVgiipf2jwehALgfgwi+f6kKewAWgbghkggAkFetATgAgAkLgHjqeeAIfrfeipgKjwehALfhfQi+gGkKewAWflffkg]],
				Jaw = [[
					gAkIeL/3gAgAiyf3jqd9/Tf2fZmmf0jxeA/dfvfJlxf5kOeP/7fsfah8gAkIeL/3gAgAiygJjqd9/TgKgnmmgMjxeA/dgRg3lxgHkOeP/7gUgmh8]],
				["UpperArm.L"] = [[
					fdile3tmQ0oT3OfWiQe7pqTUqP5xfTiVe8qtTPpb5ofWire6uoROm/3Sfdile3tmQ0oT3OfkiPe2pHRqrV4ofniTe1p/Q9rE3+fkiqe1uVP1oa2C]],
				["LowerArm.L"] = [[
					fQiNe92v2UiygifKh7fJ2c2beDjofHh/fJ2r2YelibfJiSe+3C1/i1e4fQiNe92v2UiygifWh6fC2J2efvlRfZh9e/2L2jg9kufXiRe32a2Ykdgb]],
				["UpperArm.R"] = [[
					gjile3tmvMXt3OgciPe2pHuWUr4ogZiTe1p/vDU83+gciqe1uVwLXm2Cgjile3tmvMXt3OgqiQe7pqssVx5xgtiVe8qtsxWl5ogqire6uouyZB3S]],
				["LowerArm.R"] = [[
					gwiNe92vJsdOgigqh6fC2JJigRlRgnh9e/2LJdfDkugpiRe32aJobjgbgwiNe92vJsdOgig2h7fJ2cJlh9jog5h/fJ2rJohbibg3iSe+3CKBdLe4]],
				Tail1 = [[
					gAi0gvfMgtf3/+gCijgvdzgnf6/6gDimgveBgKf+/7gCi3gvfbfngF//gAi0gvfMfTgJ/+f+ijgvdzfZgG/6f9imgveBf2gC/7f+i3gvfbgZf7//]],
				Tail2 = [[
					gCi1hShOiDfl/5gDinhRepg6f1/8gDirhReEfOgH/7gBi5hSgpd/gV/6f+i1hShOd9gb/5f9inhRepfGgL/8f9irhReEgyf5/7f/i5hSgpiBfr/6]],
				Tail3 = [[
					gGizh0iZjsfV/rgFiqh0fgh+fo/7gBivh0djfGgI/4f9i3h0gccvga/0f6izh0iZcUgr/rf7iqh0fgeCgY/7f/ivh0djg6f4/4gDi3h0gcjRfm/0]],
				Tail4 = [[
					gOitiVimlLfU/dgKiriWgbjifZ/yf/i0iWdPf0gB/3f2i2iWfacLgU/wfyitiVima1gs/df2iriWgbcegn/ygBi0iWdPgMf//3gKi2iWfaj1fs/w]],
				Tail5 = [[
					gZioi2hmmHfl/XgRiqi4gxlKfW/jf/i6i4dKhNf4/1fui3i3d+cfgJ/ufnioi2hmZ5gb/Xfviqi4gxa2gq/jgBi6i4dKezgI/1gSi3i3d+jhf3/u]],
				["UpperLeg.L"] = [[
					fWh2gQ0be4gU4mfVhmgT9leIelr7fUhqgV7QejY0Q9fVh7gT/5fhdxg3fWh2gQ9ffKgWsXfXhkgN/ndygXkSfYhogM5seAhiy4fXh5gNrwfJhp9s]],
				["LowerLeg.L"] = [[
					fUhKgZgggif7/+fPhHfzaah+gF/bfFiPgA3tlwha0pfPh4fn6si2grxZfWhWfx9dgmfwsefYhYfixUfOgY64fYg9f/nBfMgx/MfXhagurrfkgm9x]],
				["Foot.L"] = [[
					fWhIhR6agBf/yDfWhbgo6Lhge9yTfWhZf351kjc1yCfWhFfQ6WiOefx8fWgtfK7vgLf6v7fWglf66ze3gvxafWglgy6zeygzxafWg0hY2MfJgw3A]],
				["Toe.L"] = [[
					fWgwhI/6gAf/iWfWhCgf/1gxeWiqfWhBfu/ZiVa/infWgtfH/zhKdliRfWgXe8//gGf1f1fWgNfv/7fZhNhmfWgNgn/6fWhThmfWgahY+wfphFov]],
				["UpperLeg.R"] = [[
					gqh2gQ9fg2fqsXgphkgN/niOfpkSgohogM5siAeey4gph5gNrwg3eX9sgqh2gQ0bhIfs4mgrhmgT9lh4hbr7gshqgV7QhdnMQ9grh7gT/5gfiPg3]],
				["LowerLeg.R"] = [[
					gqhWfx9dfagQsegohYfixUgyfo64gog9f/nBg0fP/Mgphagurrgcfa9xgshKgZggfegF/+gxhHfzaaeCf7/bg7iPgA3taQem0pgxh4fn6sdKfVxZ]],
				["Foot.R"] = [[
					gqgtfK7vf1gGv7gqglf66zhJfRxagqglgy6zhOfNxagqg0hY2Mg3fQ3AgqhIhR6af/gByDgqhbgo6LeghDyTgqhZf351bdjLyCgqhFfQ6Wdyhhx8]],
				["Toe.R"] = [[
					gqgXe8ABgGf1gLgqgNfvAFfZhNeagqgNgnAGfWhTeagqgahYBQfphFXRgqgwhIAGgAf/dqgqhCgfALgxeWdWgqhBfuAniVa/dZgqgtfHANhKdldv]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAi0gVAEgAgAhqgAiwgYAFgAgAiCgAingfAKgAgAi9gAidgnAQgAgAj7gAiYgrAVgAgAkbgAi3gAABgAgAf5gAjHflAJgAgAdNgAjHflAJgAgAdNgAjHflAJ
					gAgAdNgAjGfoAHgAgAdggAjBf1ADgAgAeqgAi6gFABgAgAgMgAi1gSADgAgAhXgAi0gVAEgAgAhqgAi0gVAEgAgAhqgAi0gVAEgAgAhq]],
				Spine1 = [[
					gAi2gAAbgAgAlIgAizgDAegAgAlWgAirgKAkgAgAl5gAiigSArgAgAmdgAiegWAvgAgAmxgAi3frAOgAgAjjgAjDfQADgAgAhhgAjDfQADgAgAhhgAjDfQAD
					gAgAhhgAjCfTAEgAgAhxgAi/fgAIgAgAitgAi6fwARgAgAj8gAi3f9AZgAgAk5gAi2gAAbgAgAlIgAi2gAAbgAgAlIgAi2gAAbgAgAlI]],
				Spine2 = [[
					gAjDfZBKgAgAofgAjAfcBMgAgAokgAi6fkBPgAgAovgAizfsBSgAgAo7gAivfxBUgAgApBgAjAfCA0gAgAnIgAjHenAjgAgAlxgAjHenAjgAgAlxgAjHenAj
					gAgAlxgAjHeqAlgAgAl9gAjGe3AugAgAmrgAjEfIA8gAgAnmgAjDfVBHgAgAoTgAjDfZBKgAgAofgAjDfZBKgAgAofgAjDfZBKgAgAof]],
				Neck1 = [[
					gAjOfGFMgAgAxbgAjLfJFmgAgAyDgAjFfRGrgAgAzigAi+faH6gAgA1DgAi6ffImgAgA1zgAjKevEAgAgAvdgAjPeTCJgAgAregAjPeTCJgAgAregAjPeTCJ
					gAgAregAjPeWCUgAgAr5gAjPejDAgAgAtggAjOe1EDgAgAvjgAjOfDE8gAgAxDgAjOfGFMgAgAxbgAjOfGFMgAgAxbgAjOfGFMgAgAxb]],
				Neck2 = [[
					gAj1e1GzgAgAzsgAj0e6HcgAgA0ggAjvfGJLgAgA2agAjpfULKgAgA4RgAjlfcMRgAgA5LgAjueYFPgAgAxhgAjsdzCjgAgAsfgAjsdzCjgAgAsfgAjsdzCj
					gAgAsfgAjtd3CygAgAtAgAjweHDvgAgAu+gAjzeeFMgAgAxcgAj1ewGdgAgAzPgAj1e1GzgAgAzsgAj1e1GzgAgAzsgAj1e1GzgAgAzs]],
				Head = [[
					gAkYesAGgAgAiMgAkXezAPgAgAjrgAkTfGA3gAgAnTgAkMfaB+gAgArCgAkIfkCvgAgAs7gAkPeJADgAgAhSgAkGdZAVgAgAbhgAkGdZAVgAgAbhgAkGdZAV
					gAgAbhgAkHdfARgAgAb9gAkOdzAGgAgAdtgAkUePABgAgAf/gAkYemAEgAgAhwgAkYesAGgAgAiMgAkYesAGgAgAiMgAkYesAGgAgAiM]],
				Jaw = [[
					gAkXeL/8gAgAhxgAkZeS/+gAgAhAgAkcem/+gAgAfBgAkde9/0gAgAcqgAkdfK/sgAgAbngAkMdo8LgAgAvKgAj3c787gAgAtqgAj3c7+bgAgAp4gAj3c7+G
					gAgAq0gAj6dA+zgAgAopgAkDdT/YgAgAmPgAkOdv/vgAgAj+gAkWeF/6gAgAiOgAkXeL/8gAgAhxgAkXeL/8gAgAhxgAkXeL/8gAgAhx]],
				["UpperArm.L"] = [[
					fdi8e33EOtgAt3fdi6e63GOtf9tzfdi0fC3LOtf3trfditfL3QOtfwtifdipfP3TOtfttdfdi3ei3bOtfjtQfdi7eH5/PYbPm+fdi7eH6KPgazmSfdi7eH6K
					PgazmSfdi7eK6NPiatmIfdi7eW6DPbbFmvfdi8en5YPDcio9fdi8e04POyearrfdi8e33OOtfztlfdi8e33EOtgAt3fdi8e33EOtgAt3]],
				["LowerArm.L"] = [[
					fQirem2g2ggAjWfQioep2g2ggDjSfQiiew2h2ggMjKfQice52i2fgUjBfQiYe92j2fgZi9fQimeP2v2SjCgRfQi1dvxXu3w5RUfQi3dvwWtsx2QMfQi3dvwW
					tsx2QMfQi3dywQtmx7QGfQi2d+xrvOwkRtfQizeQ01zEr9W4fQiuef2o11lddyfQirel2l2fgsiqfQirem2g2ggAjWfQirem2g2ggAjW]],
				["UpperArm.R"] = [[
					gji8e33ExTgAt3gji6e63GxTgDtzgji0fC3LxTgJtrgjitfL3QxTgQtigjipfP3TxTgTtdgji3ei3bxTgdtQgji7eH5/wokxm+gji7eH6KwglNmSgji7eH6K
					wglNmSgji7eK6NwelTmIgji7eW6Dwlk7mvgji8en5Yw9jeo9gji8e04PxOhmrrgji8e33OxTgNtlgji8e33ExTgAt3gji8e33ExTgAt3]],
				["LowerArm.R"] = [[
					gwirem2gJggAjWgwioep2gJgf9jSgwiiew2hJgf0jKgwice52iJhfsjBgwiYe92jJhfni9gwimeP2vJuc+gRgwi1dvxXRJPHRUgwi3dvwWSUOKQMgwi3dvwW
					SUOKQMgwi3dywQSaOFQGgwi2d+xrQyPcRtgwizeQ01M8UDW4gwiuef2oKLajdygwirel2lJhfUiqgwirem2gJggAjWgwirem2gJggAjW]],
				Tail1 = [[
					gAiygvhZgAgA/9gAitgyhdgAgA/9gAiig5hmgAgA/8gAiXhBhwgAgA/8gAiRhEh1gAgA/8gAi4gaefgAgA/9gAjMf/c8fYgH/1gAjMf/d8fegF/6gAjMf/d8
					gif7/6gAjKgCeThRf1/6gAjDgPfnhGf5/+gAi6ggg+gMf//+gAizgshufvgB/8gAiygvhjf6gA/9gAiygvhZgAgA/9gAiygvhZgAgA/9]],
				Tail2 = [[
					gAivhShmgAgA/8gAiqhVhWgAgA/9gAifhcgugAgA/+gAiThjgDgAgA//gAiNhnftgAgA//gAi7g9djgAgA/5f/jTghdJewgP/1f/jRghfJe7gL/9gBjRghfJ
					hFf1/9gDjOgkflihfo/4gCjEgxhCiLfx/5gAi4hCiOgYf+/6f/iwhPijfdgB/4gAiuhSh5fzgB/7gAivhShmgAgA/8gAivhShmgAgA/8]],
				Tail3 = [[
					gAirh0hFgAgA/+gAinh3ghgAgA//gAidh+fIgAgA/+gAiTiGdpgAgA/5gAiOiJc4gAgA/1gAjBhfb6gAgA/uf8jZhDcoeIgV/wf8jShEfpeZgP/8gEjShEfp
					hnfx/8gIjPhHgJjyfg/wgHjChUhvjQft/xgBizhkixglf+/3f+iqhxiqfMgB/3f/iqh0hjftgB/9gAirh0hFgAgA/+gAirh0hFgAgA/+]],
				Tail4 = [[
					gAipiXgMgAgA//gAimiafUgAgA//gAifihdJgAgA/3gAiYioa3gAgA/kgAiVirZrgAgA/XgAjJiAZ5gAgA/Zf4jghkbwdfgY/mf5jThmfwd2gQ/6gHjThmfw
					iKfw/6gQjOhogWlCff/lgOi+h1iEkVfv/ogCitiGi7gxf//2f8ikiTiZe6gA/4f/iniXgzfmgA/+gAipiXgMgAgA//gAipiXgMgAgA//]],
				Tail5 = [[
					gAioi5eygAgA/+gAioi8dmgAgA/5gAiljDargAgA/igAijjJXogAgA+4gAiijLWEgAgA+agAjWihXbgAgA+0fyjpiFaYc2gV/Vf0jUiIfXdTgM/3gMjUiIfX
					itf0/3gbjOiJgDmTfo/XgXi6iWh6laf6/egEinioikg9gC/3f6ifi1hoepf8/7f+ili5fjfgf///gAioi5eygAgA/+gAioi5eygAgA/+]],
				["UpperLeg.L"] = [[
					fWh9gE6qe3gAxpfWh5gF7ceyf6wafWhxgJ89eofuthfWhpgO+LegfhqgfWhkgQ+sedfbo5fWh/f13sfDgP1efWiNfjxYflgp62fWiNfjxYflgp62fWiNfjxY
					flgp62fWiMflxjflgp6vfWiHfuySfkgo6PfWiBf53sfGgQ1efWh9gB6Ke6gDyYfWh9gE6qe3gAxpfWh9gE6qe3gAxpfWh9gE6qe3gAxp]],
				["LowerLeg.L"] = [[
					fUhTfyuygkgA8XfUhSfwuJgmgD8sfUhPfss/grgI9OfThNfrsTgugN9hfThNfqsKgvgQ9lfVhSfwuOgdf58qfWhkf2xTgNfs66fWhkf2xTgNfs66fWhkf2xT
					gNfs66fWhjf3xegNfs6zfWhdf9yNgOft6TfVhVf0vggcf47+fUhTfyu0gjf/8WfUhTfyuygkgA8XfUhTfyuygkgA8XfUhTfyuygkgA8X]],
				["Foot.L"] = [[
					fWglgS60gAgAxbfWglgS60gCf/xbfWglgS60gFf9xbfWglgS60gIf7xbfWglgS60gJf6xbfWglgS60f7gDxbfWgxgN4MfygM07fWgxgN4MfygM07fWgxgN4M
					fygM07fWgvgO4kfygM0ffWgogR6EfwgLyjfWglgS60f6gExbfWglgS60f/gBxbfWglgS60gAgAxbfWglgS60gAgAxbfWglgS60gAgAxb]],
				["Toe.L"] = [[
					fWgNgI/8gAgAhmfWgNgI/8gBf+hmfWgNgI/8gDf6hmfWgNgI/8gEf4hmfWgNgI/8gFf2hmfWgNgI/8f9gFhmfWgXgJ/bf6gRl8fWgXgJ/bf6gRl8fWgXgJ/b
					f6gRl8fWgVgJ/if6gRlYfWgQgJ/2f4gSi8fWgNgI/8f9gGhmfWgNgI/8gAgBhmfWgNgI/8gAgAhmfWgNgI/8gAgAhmfWgNgI/8gAgAhm]],
				["UpperLeg.R"] = [[
					gqh9gE6qhJgAxpgqh5gF7chOgGwagqhxgJ89hYgSthgqhpgO+LhggfqggqhkgQ+shjglo5gqh/f195hjgfrRgqiNfj/4h0hThbgqiNfj/4h0hThbgqiNfj/4
					h0hThbgqiMfl/0hzhNiegqiHfu/Ohsg1mtgqiBf59ghdgZsQgqh9gB7XhNgFwhgqh9gE6qhJgAxpgqh9gE6qhJgAxpgqh9gE6qhJgAxp]],
				["LowerLeg.R"] = [[
					gshTfyuyfcgA8XgshSfwuJfaf98sgshPfss/fVf49OgthNfrsTfSfz9hgthNfqsKfRfw9lgthhfTtIfPfz9KguiJe3xxfBfh6kguiJe3xxfBfh6kguiJe3xx
					fBfh6kguiFe5xNfCfj68gth1fFvYfIfr8CgthifZuPfRf18pgshWfsuhfaf+8ggshTfyuyfcgA8XgshTfyuyfcgA8XgshTfyuyfcgA8X]],
				["Foot.R"] = [[
					gqglgS60gAgAxbgqglgS60f+gBxbgqglgS60f7gDxbgqglgS60f4gFxbgqglgS60f3gGxbgqg3f476f0gHvogqhVfM+4ffgJoWgqhVfM+4ffgJoWgqhVfM+4
					ffgJoWgqhSfR+hfigJpkgqhFfj9KfsgJtJgqg1f77xf2gFv5gqgogO6/f+gBxLgqglgS60gAgAxbgqglgS60gAgAxbgqglgS60gAgAxb]],
				["Toe.R"] = [[
					gqgNgI/8gAgAhmgqgNgI/8f/gChmgqgNgI/8f9gGhmgqgNgI/8f8gIhmgqgNgI/8f7gKhmgqghfr//f5gMfggqhIe2+5fogYXtgqhIe2+5fogYXtgqhIe2+5
					fogYXtgqhDe8/MfrgXY8gqgyfS/0fzgScugqgefu//f7gKfygqgRgD/9f/gChSgqgNgI/8gAgAhmgqgNgI/8gAgAhmgqgNgI/8gAgAhm]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAi0gVAEgAgAhqgAixgVADgAgAhQgAirgVABgAgAgUgAimgVABgAgAfjgAingVABgAgAfsgAiygVAFgAgAiEgAi4gVASgAgAkGgAi5gVAVgAgAkcgAi5gVAV
					gAgAkcgAi5gVAVgAgAkcgAi5gVAVgAgAkcgAi5gVAVgAgAkcgAi5gVAVgAgAkcgAi5gVAVgAgAkcgAi5gVAVgAgAkcgAi5gVAVgAgAkcgAi5gVAVgAgAkcgA
					i5gVAUgAgAkYgAi3gVANgAgAjbgAi1gVAFgAgAiGgAi0gVAEgAgAhqgAi0gVAEgAgAhqgAi0gVAEgAgAhq]],
				Spine1 = [[
					gAi2gAAbgAgAlIgAizgAAWgAgAkkgAisgAAMgAgAjSgAimgAAGgAgAiPgAingAAHgAgAibgAi1gAAigAgAlsgAi+gBBKgAgAoegAi/gBBSgAgAo8gAi/gBBS
					gAgAo8gAi/gBBSgAgAo8gAi/gBBSgAgAo8gAi/gBBSgAgAo8gAi/gBBSgAgAo8gAi/gBBSgAgAo8gAi/gBBSgAgAo8gAi/gBBSgAgAo8gAi/gBBSgAgAo8gA
					i/gBBRgAgAo3gAi8gAA7gAgAnjgAi3gAAigAgAlvgAi2gAAbgAgAlIgAi2gAAbgAgAlIgAi2gAAbgAgAlI]],
				Spine2 = [[
					gAjDfZBKgAgAofgAi+fYA+gAgAnygAi0fXAogAgAmLgAisfXAZgAgAk3gAitfXAbgAgAlGgAjDfZBYgAgApNgAjTfdCogAgAspgAjVfeC4gAgAtNgAjVfeC4
					gAgAtNgAjVfeC4gAgAtNgAjVfeC4gAgAtNgAjVfeC4gAgAtNgAjVfeC4gAgAtNgAjVfeC4gAgAtNgAjVfeC4gAgAtNgAjVfeC4gAgAtNgAjVfeC4gAgAtNgA
					jVfdC1gAgAtHgAjPfbCKgAgArggAjGfZBYgAgApQgAjDfZBKgAgAofgAjDfZBKgAgAofgAjDfZBKgAgAof]],
				Neck1 = [[
					gAjOfGFMgAgAxbgAjJfFEXgAgAwGgAi8fDCxgAgAs+gAiyfCBugAgAqUgAi0fCB5gAgAqzgAjPfHFogAgAyGgAjifOJ3gAgA3FgAjlfQKngAgA3ygAjlfQKn
					gAgA3ygAjlfQKngAgA3ygAjlfQKngAgA3ygAjlfQKngAgA3ygAjlfQKngAgA3ygAjlfQKngAgA3ygAjlfQKngAgA3ygAjlfQKngAgA3ygAjlfQKngAgA3ygA
					jlfPKfgAgA3qgAjdfMIagAgA1ngAjSfHF7gAgAyhgAjOfGFMgAgAxbgAjOfGFMgAgAxbgAjOfGFMgAgAxb]],
				Neck2 = [[
					gAj1e1GzgAgAzsgAjuewFkgAgAyAgAjcemDOgAgAt9gAjMegBxgAgAqcgAjPehCAgAgArFgAj3e4HdgAgA0ggAkOfQN6gAgA6YgAkQfUPDgAgA7IgAkQfUPD
					gAgA7IgAkQfUPDgAgA7IgAkQfUPDgAgA7IgAkQfUPDgAgA7IgAkQfUPDgAgA7IgAkQfUPDgAgA7IgAkQfUPDgAgA7IgAkQfUPDgAgA7IgAkQfUPDgAgA7IgA
					kQfTO2gAgA7AgAkIfILtgAgA4ugAj7e5H6gAgA1CgAj1e1GzgAgAzsgAj1e1GzgAgAzsgAj1e1GzgAgAzs]],
				Head = [[
					gAkYesAGgAgAiMgAkQejACgAgAfLgAj5eQA7gAgAYdgAjjeECrgAgATOgAjneGCTgAgAUIgAkbexARgAfpj7gAkvfdEagXfJwJgAkxfkEofPhywbgAkxfkFV
					gPfgxpgAkxfkFqgqesyEgAkxfkEqfThowggAkxfkFKgAgAxZgAkxfkFxgzebyNgAkxfkEvfahXwqgAkxfkE/fxggxIgAkxfkF0g4eSyRgAkxfkE2flg+w3gA
					kwfjErfmg9wmgAkrfPCsgVe1svgAkee0AXgAgGkrgAkYesAGgAgAiMgAkYesAGgAgAiMgAkYesAGgAgAiM]],
				Jaw = [[
					gAkXeL/8gAgAhxgAkIeC/lgAgAlFgAjld19igAgAsSgAjHdx6rgAgAxpgAjMdy7QgAgAwvgBkeeQ/mf6gWk7gClJfI/9fSgmezf8lLfQ/7hke4gGgBlNfS/9
					fjgTergDlNfT/5ewgyeJf8lLfQ/8hce+gAgAlMfR/+gAgAe/gElNfT/4egg8d+f9lLfQ/9hNfJf1f/lMfR/+gdfsfTgElNfT/3eXhBd4f+lLfQ/+g3fZflf+
					lLfP/+g2fZfogDk/e0/9fQg+fUgAkieT/9gBf7hYgAkXeL/8gAgAhxgAkXeL/8gAgAhxgAkXeL/8gAgAhx]],
				["UpperArm.L"] = [[
					fdi8e33EOtgAt3fdi2e33VOtfqtafdipe335Ove6sXfdiee44VOyeSrgfdige44QOyeZrpfdi+e44NNpZFnNfdjWe72IQsOvfKfdjZe81PSTMjdkfdjZe81P
					STMjdkfdjZe81PSTMjdkfdjZe81PSTMjdkfdjZe81PSTMjdkfdjZe81PSTMjdkfdjZe81PSTMjdkfdjZe81PSTMjdkfdjZe81PSTMjdkfdjZe81PSTMjdkfd
					jZe81ZSAM5d0fdjPe53dOaTji2fdjBe43vN1dFrBfdi8e33EOtgAt3fdi8e33EOtgAt3fdi8e33EOtgAt3]],
				["LowerArm.L"] = [[
					fQirem2g2ggAjWfQimel2j2fgci5fQiaek2q2dhbh6fQiQej2u2YiPhGfQiSej2t2ZiGhOfNi8eh4KyYoCZ5fJjlev0Nm0vANefIjre1yTjoviLLfIjre1yT
					joviLLfIjre1yTjoviLLfIjre1yTjoviLLfIjre1yTjoviLLfIjre1yTjoviLLfIjre1yTjoviLLfIjre1yTjoviLLfIjre1yTjoviLLfIjre1yTjoviLLfI
					jqe0ypkLveLifKjXem3Ds0sjS9fOi2ej3y1DjtfRfQirem2g2ggAjWfQirem2g2ggAjWfQirem2g2ggAjW]],
				["UpperArm.R"] = [[
					gji8e33ExTgAt3gji2e33VxTgWtagjipe335xRhGsXgjiee44VxOhurggjige44QxOhnrpgji+e44NyXm7nNgjjWe72IvUxRfKgjjZe81PttzddkgjjZe81P
					ttzddkgjjZe81PttzddkgjjZe81PttzddkgjjZe81PttzddkgjjZe81PttzddkgjjZe81PttzddkgjjZe81PttzddkgjjZe81PttzddkgjjZe81Pttzddkgj
					jZe81ZuAzHd0gjjPe53dxmsdi2gjjBe43vyLi7rBgji8e33ExTgAt3gji8e33ExTgAt3gji8e33ExTgAt3]],
				["LowerArm.R"] = [[
					gwirem2gJggAjWgwimel2jJhfki5gwiaek2qJjelh6gwiQej2uJodxhGgwiSej2tJnd6hOgzi8eh4KNoX+Z5g3jlev0NZMRANeg4jre1yTcYQeLLg4jre1yT
					cYQeLLg4jre1yTcYQeLLg4jre1yTcYQeLLg4jre1yTcYQeLLg4jre1yTcYQeLLg4jre1yTcYQeLLg4jre1yTcYQeLLg4jre1yTcYQeLLg4jre1yTcYQeLLg4
					jqe0ypb1QiLig2jXem3DTMTdS9gyi2ej3yK9cTfRgwirem2gJggAjWgwirem2gJggAjWgwirem2gJggAjW]],
				Tail1 = [[
					gAiygvhZgAgA/9gAiwgvhOgAgA/9gAirgvg2gAgA/+gAiogvgjgAgA//gAiogvgmgAgA//gAivgvhcf0gA/9gAiygviFfhgB/6gAiygviLhAf//5gAiygviL
					fugA/6gAiygviLfPgB/6gAiygviLg6f//5gAiygviLgAgA/6gAiygviLfGgB/5gAiygviLgxf//6gAiygviLgSgA/6gAiygviLfAgB/5gAiygviLgjf//6gA
					iygviKgif//6gAiygvh5fYgB/7gAiygvhhgDgA/9gAiygvhZgAgA/9gAiygvhZgAgA/9gAiygvhZgAgA/9]],
				Tail2 = [[
					gAivhShmgAgA/8gAithShrgAgA/8gAiphSh3gAgA/8gAinhSiBgAgA/7gAinhSh/gAgA/7gAishShSf4gA/9f/iuhRghergE/9gCiuhRgXhof//8f/iuhRgX
					gLf9//f+iuhRgXePgE/8gCiuhRgXhTgA/9gAiuhRgXgsf8/+f+iuhRgXeJgD/7gCiuhRgXg3gB/+gBiuhRgXhJf8/+f+iuhRgXeMgC/8gBiuhRgXgXgC//gB
					iuhRgZhff8/9f/iuhRg0e/gC/9gAiuhShaf+gA/9gAivhShmgAgA/8gAivhShmgAgA/8gAivhShmgAgA/8]],
				Tail3 = [[
					gAirh0hFgAgA/+gAiph0hbgAgA/9gAilh0iKgAgA/6gAiih0ixgAgA/3gAijh0iqgAgA/4f/iph0gbgKf///f8ithzePd6gE/3gGithzd2higI/4gAithzd2
					hHf1/5f7ithzd2djgB/0gFithzd2g8gK/5gBithzd2hsf3/3f6ithzd2drf+/1gEithzd2gQgL/6gDithzd2iHf5/2f6ithzd2d/f7/2gCithzd2fkgL/6gE
					ithzd6iVf8/1f8ish0fDfCf+/9gAirh0glf1gB//gAirh0hFgAgA/+gAirh0hFgAgA/+gAirh0hFgAgA/+]],
				Tail4 = [[
					gAipiXgMgAgA//gAimiXgxgAgA/+gAihiXiFgAgA/7gAiciWjJgAgA/1gAidiWi9gAgA/2gAioiXfLgff//+f4iwiWbmdpf7/mgJixiVa+gygZ/lgCixiWa+
					iCfy/hf1ixiVa+difz/fgHixiWa+gCgZ/lgFixiWa+idf4/ff1ixiVa+d8fu/hgEixiWa+fRgX/lgIixiVa+irf//ef2ixiVa+ehfq/jgBixiWa+ekgT/jgJ
					ixiVbEiogG/gf6iuiWc4fgf2/1gAiqiXfXfrgA/+gAipiXgMgAgA//gAipiXgMgAgA//gAipiXgMgAgA//]],
				Tail5 = [[
					gAioi5eygAgA/+gAili5fngAgA//gAici5hfgAgA/9gAiVi4jBgAgA/2gAiXi4ivgAgA/3gBiqi5dbgtgA/4fzi6i2YgeCfo/CgKi8i2Xqfwgq+4gHi8i2Xp
					icf7+yfwi8i2XqeOfa+0gHi8i2XqfDgk+3gKi8i2XpikgI+xfxi8i2Xqe1fV+2gCi8i3Xqeagc+1gNi8i2XpiggU+xfzi8i2XqfhfU+3f+i8i2Xpd6gR+zgP
					i8i2XyiMgd+1f5i1i4aQgJfv/df/iri5dpfnf//5gAioi5eygAgA/+gAioi5eygAgA/+gAioi5eygAgA/+]],
				["UpperLeg.L"] = [[
					fWh9gE6qe3gAxpfWh5gF7Xeyf6whfWhzgI8qenfvuIfWhtgL9geefmsQfWhugK9XegfnslfWh7gC6se3gAxmfWiEf73GfPgW2IfWiGf62LfUga3DfWiGf62L
					fUga3DfWiGf62LfUga3DfWiGf62LfUga3DfWiGf62LfUga3DfWiGf62LfUga3DfWiGf62LfUga3DfWiGf62LfUga3DfWiGf62LfUga3DfWiGf62LfUga3DfW
					iFf62WfTgZ24fWiCf+4bfHgP0pfWh+gC6Me7gDyWfWh9gE6qe3gAxpfWh9gE6qe3gAxpfWh9gE6qe3gAxp]],
				["LowerLeg.L"] = [[
					fUhTfyuygkgA8XfUhSfwuLgngC8rfUhPfttJgsgH9KfThOfrskgxgL9afThOfssqgwgK9XfUhSfwuUgkgA8mfVhYf5w5gWf47KfVhZf8xkgTf26vfVhZf8xk
					gTf26vfVhZf8xkgTf26vfVhZf8xkgTf26vfVhZf8xkgTf26vfVhZf8xkgTf26vfVhZf8xkgTf26vfVhZf8xkgTf26vfVhZf8xkgTf26vfVhZf8xkgTf26vfV
					hZf7xcgUf260fVhWf2v/gbf67tfUhUfzu/gif/8QfUhTfyuygkgA8XfUhTfyuygkgA8XfUhTfyuygkgA8X]],
				["UpperLeg.R"] = [[
					gqh9gE6qhJgAxpgqh5gF7XhOgGwhgqhzgI8qhZgRuIgqhtgL9ghigasQgqhugK9XhggZslgqh7gC6shJgAxmgqiEf73Ggxfq2IgqiGf62Lgsfm3DgqiGf62L
					gsfm3DgqiGf62Lgsfm3DgqiGf62Lgsfm3DgqiGf62Lgsfm3DgqiGf62Lgsfm3DgqiGf62Lgsfm3DgqiGf62Lgsfm3DgqiGf62Lgsfm3DgqiGf62Lgsfm3Dgq
					iFf62Wgtfn24gqiCf+4bg5fx0pgqh+gC6MhFf9yWgqh9gE6qhJgAxpgqh9gE6qhJgAxpgqh9gE6qhJgAxp]],
				["LowerLeg.R"] = [[
					gshTfyuyfcgA8XgshSfwuLfZf+8rgshPfttJfUf59KgthOfrskfPf19agthOfssqfQf29XgshSfwuUfcgA8mgrhYf5w5fqgI7KgrhZf8xkftgK6vgrhZf8xk
					ftgK6vgrhZf8xkftgK6vgrhZf8xkftgK6vgrhZf8xkftgK6vgrhZf8xkftgK6vgrhZf8xkftgK6vgrhZf8xkftgK6vgrhZf8xkftgK6vgrhZf8xkftgK6vgr
					hZf7xcfsgK60grhWf2v/flgG7tgshUfzu/fegB8QgshTfyuyfcgA8XgshTfyuyfcgA8XgshTfyuyfcgA8X]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAi0gVAEgAgAhqgAixgVAEgDgrhcgAiggVAEgLhlf/gAjJgVAJgDhmibgAjqgVASf/g/j8gAj1gVAVgAgAkcgAjqgVASgBfBj8gAjJgVAJf9eaibgAiggVAE
					f1ebf+gAiogVACf7fBgpgAimgVABgAgAgdgAjZgVAMgAg/jNgAjxgVAWf9hmkQgAj0gVAXf9hmkWgAjfgVAOgAg/jggAiygVACgAgAhMgAimgVACf6fBgdgA
					izgVAGf7eahogAi0gVAFf8e0hqgAi0gVAEf/fwhqgAi0gVAEgAgAhq]],
				Spine1 = [[
					gAi2gAAbgAgAlIf/izgAAZgHgrkzf+iggAAKgThkiof+jMgAApgOhlmEf/jvgBBEgHg/oDgAj7gBBOgAgAorgBjvgBBEf5fBoDgCjMgAApfyebmEgCiggAAK
					ftecingBipgAAPf1fCjngAimgAAMgAgAjVf/jdgAA1gIg+nGf+j3gBBMgLhlobf+j5gBBOgKhlojf/jkgAA7gIg/negAi0gAAUgAgAkXgBimgAANf1fCjVgC
					i2gAAdfweblFgCi2gAAdf0e1lIgAi2gAAbf9fwlIgAi2gAAbgAgAlI]],
				Spine2 = [[
					gAjDfZBKgAgAoff9i/fYBEgMgqoEf6infXAfgbhilNf6jbfaBigahjplf8kDfcCWgPg9r9gAkRfdCpgAgAssgEkDfcCWfxfDr9gGjbfaBifmedplgGinfXAf
					fleelMgEiyfYAtfvfDmggAivfXAngAgAmIf8jvfbB7gPg9q2f6kMfdCkgYhjsaf6kPfdCogYhjskf8j3fbCFgPg9rSgAi/fYA5gAgAndgEivfXAofvfDmIgG
					jDfZBMfleeoagFjDfZBMfse2ofgBjDfZBKf8fxofgAjDfZBKgAgAof]],
				Neck1 = [[
					gAjOfGFMgAgAxbf9jKfGEzgXglw0f4iufDCmgxhZsff4jnfIGRg4hVy7f7kSfNI5glgz2GgAkgfPJzgAgA3BgFkSfNI5fbfN2GgIjnfIGRfIery7gIiufDCm
					fPensegFi7fEDgfgfKuegAi3fDDNgAgAt7f7j9fLHmgkg00pf4kbfOJfg8hT2qf4kefPJrg8hT22f7kFfLIGgkg01OgAjJfFEPgAgAv5gFi3fEDOfgfKt7gI
					jNfGFKfJeqxVgGjOfGFNfWfAxbgBjOfGFMf3fzxbgAjOfGFMgAgAxb]],
				Neck2 = [[
					gAj1e1GygAgAzsf8jweyGXgagjzHf1jNelDzg5hUu/f3kRe8IAg/hQ1Ff7k9fLK5gpgw4BgAlMfQL3gAgA42gFk9fLK5fXfQ4BgJkRe8IAfBew1FgLjNelDy
					fHeru+gGjderE3fbfNw5gAjZepEhgAgAwXf7knfDJegogx2rf4lGfPLihDhN4hf4lJfQLuhDhN4sf7kwfGKBgogw3NgAjuevFugAgAyPgGjZepEifcfMwXgK
					j1e1GxfBewzlgHj1e1G0fRfEzrgBj1e1Gzf2f0zsgAj1e1GzgAgAzs]],
				Head = [[
					gAkYesAGgAgAiMf7kTeoANefgwjCf0jreRATcdiOfCf2k0e3A4cihWmYf7lhfQByd7giqQgAlvfYCIgAgArbgFlhfQByiFfeqQgKk0e3A4jeeqmYgMjreRAU
					jjdyfAgHj+ebAIiMeyhGgAj5eXABgAgAgZf6lLfEBOd5groZf4lqfVCMcrgxrFf4ltfXCScsgvrVf6lUfIBbd6gopIgAkQeiAIgAgAiogHj5eYAIiMevgegK
					kYesAkjfebkdgIkYesAZipeyj8gCkYesAJgjfuiwgAkYesAGgAgAiM]],
				Jaw = [[
					gAkXeL/8gAgAhxf6kUeH/Phrfwmqfxjjdx9AkHfSs0fzk8eX/PjugEl0f5lwey/3iIgSh4gAmBe7//gAgAgqgHlwey/3d4fuh4gNk8eX/PcSf8l0gPjjdx8/
					b5gus2gJj6d598dhgUq/gAj0d29ygAgArrf4lXek/riOgLj0f1l7e4/yjYgig9f1l+e6/zjWgkgsf5lheq/xiLgOjDgAkQeB+hgAgApkgJj0d39udggWrkgO
					kbeL+0cLgJntgKkbeL/PdHgVmNgCkZeL/0fagLjTgAkXeL/8gAgAhx]],
				["UpperArm.L"] = [[
					fdi8e33EOtgAt3fZi4e52rM2WdnKfUiae81WO7PjiTfUjXe8z1WdJ9YxfXkEe91gSsModJfdkUe72JOWRViafjkFe42hStN/cLfmjXe114XHMEXwfmiZe13C
					O/Rygyfjine11kLlV3mOfdije32QPZQKg4fXjte7z5XdJ+XufUkNe/1HTAMAdHfUkRe/1iOnQWjffXj2e81kSRM7dpfdi2e31XVWLrZufjije12xPbQ2gafm
					i8e02KMNVDkhfki8e135OhUChzfei8e34HNqbzpXfdi8e33EOtgAt3]],
				["LowerArm.L"] = [[
					fQirem2g2ggAjWfGi5el4yumqOWce+inev5TtDmxTFfAjqe90yv5mZOvfDkWe212rUqBOMfJkfes2FoWuuQOfPkXev1TsLrfPAfTjrey0HxbogQbfUimek4Y
					uipGUYfQireh4ZriteVVfJixep4ftloWS/fDkBe+z+v4nfONe/kfe51uq3pvNne+kbex2xn0tdPzfCkHe02QrjpwOsfJjKe01kxKmSRBfPixem4MuBpETYfU
					jCeg3Zq9ulUBfTjGeh4XwHo/WifPi0eg4F0+h4gxfQirem2g2ggAjW]],
				["UpperArm.R"] = [[
					gji8e33ExTgAt3gfi4e24JwKtYgCgaiae13CxAuPgxgajXe12VzWrsjsgdkFe42htTyBcLgjkUe7z+nA13WIgpkEe91gtUzYdJgsjXe81Kyxt1lqgsiae81W
					xGwciUgpioe606rf0pargjije32Qwnv2g4gdjue32Tyts4jKgakPe42xtAxybhgakSe40/mx0wVsgdj2e32mtuxtcrgji2e31Zz7rbmLgpike61uwowihXgs
					i8e70GqX1sZjgqi8e628xTtujGgki8e43tyVj7qfgji8e33ExTgAt3]],
				["LowerArm.R"] = [[
					gwirem2gJggAjWgxjEek4hNabIYwgsimek4XReW6UXgsjfeh26VlRCTIgxkXev1TT1UhPAg3kne/yqQMW3Nig9kWe212UsV/OMhCjfes4PWzTcSGhCinev5T
					S8ZQTGg9i7e22NPKa5RLg3ixep4fSbXqS/gwj3el2nWYRFR9gtkheu02TvT5O7gukle6yZPbV3OfgxkIet1sTlUyPfg3i8ek4eVPS8URg+ixet4xS5YZSmhA
					jPe71ZP3aPPhg+jGep49QqY3VWg0izej4HLqbOdtgwirem2gJggAjW]],
				Tail1 = [[
					gAiygvhZgAgA/9gBivgvhWjrfz/wgDihgvhCmlfG/RgDjFgvhYjQgB/zgCjkgvhfd2fz/4gAjvgvhfatfV/gf+jkgvheb5fm/sf9jFgvhZgEgA/9f9ihgvhD
					jefh/yf+ingvhMjVfq/ygAimgvhKgAgA/+gCjUgvhccqf1/ygDjrguhfcifm/xgDjtguhgf8gA/9gCjagvhdkHgS/sgAixgvhPlVfp/hf+imgvhJiKfx/5f9
					ixgvhYcxgJ/zf+iygvhYbBgO/kgAiygvhZergE/7gAiygvhZgAgA/9]],
				Tail2 = [[
					gAivhShmgAgA/8gJishRhtlJfr/hgQiehPihrheR9sgKjChRgxnMf+/Kf9jhhRffdVfp/3f1jshPe8WSew+cf2jhhQfbXJfQ+uf+jChSg0e7gC/9gFifhRil
					m8fA/GgGilhRiKoifI+vgAijhSiUisfx/yf6jRhRgIaifs/hf7johQfJXcfM+zgCjqhRfHb9f2/ugKjXhQf5kogf/pgLiuhQhtpzfR+ZgDijhSiSm+fR/If2
					iuhRhnd5gH/4fzivhQhjYZgY/Cf9ivhShmdWgI/1gAivhShmgAgA/8]],
				Tail3 = [[
					gAirh0hFgAgA/+gUiphyhYkvfv/ngniYhojSvDd179gZjAhwfdsLgF9lf3jihzc0flfW/0fhjvhrb1T/d59RfjjihtctSRes8rf7jAh0fibVgH/pgTiZhwjZ
					n9ex+xgXighviatGe49EgGieh0iunSfi/BfvjRhxeKbKfV/kfpjqhucKT0ei9Sf6jshycEW3fo+ZgUjXhxdsiYg5/zgfiqhshgsSfP9fgSiehxirsCe99gfy
					irhzhIhgf9/7fjirhvhDXngS+2f3irh0hFcIgI/vgAirh0hFgAgA/+]],
				Tail4 = [[
					gAipiXgMgAgA//geimiTgqiif2/4hDiQh7juwZdr7HgxjCiId6wrgj7Nf2jpiVZ5kAfB/IfKj5iDYmUXcj8pfJjqiCZ4Ovdu6HfxjBiVd6WWgB+bgjiRiNjy
					mQen/HgxiaiFiWv3e+7qgViYiSiwsYfo9XfkjViSb5eae0/qfSjziFZCSmdY8Efnj0iOY3SQfE79gZjciTbNd8hU/ig4iniEg9sPfd9igpiYiJiwv5fC7nf1
					ioiVgQmlf+/TfSipiMgMY3gD/LfvipiVgMbXgC/pgAipiXgMgAgA//]],
				Tail5 = [[
					gAioi5eygAgA/+gjiki1fafJfy/+hhiGiKjlvYdl7uhQjGiYcIzfhn5Bf/j1i0WzpSe/9Le1kKiZVPXdax8aerj4iOW+NZcB4EfdjGixb/Rjfc8PgwiIisji
					iSeN/qhOiViWh3wSfT7dgtiSiqiYwdgM7VfhjeizZSjced/De5kCiYVuUGbo7gfOkCihVjPadz5LgVjni0YeYjhb+JhQikidf5pqfu+fhHiSiaibxrfb6jgD
					ioi1e9rkgd9zfDioisezb2f2/sflioi2ezbQf0/ngAioi5eygAgA/+]],
				["UpperLeg.L"] = [[
					fWh9gE6qe3gAxpfVh6gG7cfKfVwafUhogO+IfAd5qffUiSgF6Qf5eyyPfVi1f+0WgPf84rfWjCf6z8figl5AfXi2f5zve0hO5IfYiSf944eDhaz9fYhngF9e
					dyhHsLfXhwgF8meIgouMfWhtgI9MehfptAfVijgB32f2fl1UfUi9f/0cgrfi4lfUi/f/0bgrfi4nfViqgA2of/fu2nfWh7gF8Herf0vMfXhtgF87eGgmthfY
					h8gA6Id+hWyTfXh9gA6NeNhByPfWh9gD6kevgNxxfWh9gE6qe3gAxp]],
				["LowerLeg.L"] = [[
					fUhTfyuygkgA8XfShSfxuahPfx8ifOhNfrsLiif19efRhof2vvh6fP7xfViJgH0Qg6fJ4vfWiWgEz4gNfw5EfXiLgEzsfggW5NfYhnfzvGfIgt8MfYhIfmqU
					fFgk+QfWhMfpr4ftgc9sfThMfqsAgvgJ9pfUh3f8xhhKfW6vfViRgH0VhVey4ofViTgH0UhUey4pfUh9gAyhhEfR6DfUhVfttBgqgF9NfWhLforgfugc92fY
					hSfwuNfHgs8ofXhTfxubfegh8ifVhTfyutgVgH8afUhTfyuygkgA8X]],
				["Foot.L"] = [[
					fWglgS60gAgAxbfWglgS60glfoxbfWglgS6xhqe7xZfWg4gS6ahLfNyAfWhSgS5ygafuy7fWhfgR5HfxgMzzfWhUgS5ffHgpzSfWg4gS6aexg2yAfWglgS6y
					eug1xafWglgS60fRgfxbfWglgS60gJf6xbfWhDgS6OgkfnyTfWhZgS5ggzfbzSfWhcgS5agzfbzafWhIgS6JggfqybfWgrgS6rgFf9xpfWglgS60fRgexbfW
					glgS6zewg0xafWglgS6zfEgnxbfWglgS60fzgIxbfWglgS60gAgAxb]],
				["Toe.L"] = [[
					fWgNgI/8gAgAhmfWgNgI/8gUfYhmfWgNgI/5g5ePhmfWgfgJ/4gneuiTfWg5gK/zgNfjjafWhGgL/rf5gSkgfWg7gL/vfkhAj4fWgfgJ/4fXhWiTfWgNgI/6
					fUhXhmfWgNgI/8fngyhmfWgNgI/8gFf3hmfWgqgJ/3gSfZiqfWhAgL/vgafGj2fWhDgL/ugafGkBfWgvgK/3gQfdizfWgTgI/8gCf7h2fWgNgI/8fngyhmfW
					gNgI/6fVhVhmfWgNgI/7fghAhmfWgNgI/8f5gNhmfWgNgI/8gAgAhm]],
				["UpperLeg.R"] = [[
					gqh9gE6qhJgAxpgph6gC7AhkffxFgohngF9diOe5sNgoiSf944h9emz9gpi2f5zvhMey5IgqjCf6z8gefb5Agri1f+0WfxgE4rgsiSgF6QgHhOyPgshogO+J
					hAiHqdgrhwgK9GhAhPtMgqhtgI9MhfgXtAgpikf82bhZe62vgoi+f3zfhneZ5RgojBf2zehneY5Sgpirf7z1hNey5Dgqh7gF8HhVgMvMgrhugK9ZhEhUsggs
					h8gI7OgShZwvgrh9gH7CgfhCxEgqh9gE6vhAgOxigqh9gE6qhJgAxp]],
				["LowerLeg.R"] = [[
					gshTfyuyfcgA8XgqhRfvt8gDft8zgohIfmqVg7fc+QgohnfzvGg4fT8MgpiLgEzsggfq5NgqiWgEz4fzgQ5EgriJgH0QfGg34vgvhof2vveGgx7xgyhNfrsK
					degL9egvhOfss0eSgL9QgthMfqsAfRf39pgqh3f8xqgcfo6rgpiTgCzcg6fT5YgpiVgCzbg6fT5Zgph/gFzxggfq5JgshVfttBfWf79NgwhOfrsgeQgJ9Zgv
					hUf0vNd9gr8EguhUfzvKeVgg8HgshUfyu3fOgH8UgshTfyuyfcgA8X]],
				["Foot.R"] = [[
					gqglgS60gAgAxbgqglgS60ghfqxbgqglgS6yhSfLxagqg4gS6ahPfKyAgqhUgS5fg5fXzSgqhfgR5HgPf0zzgqhSgS5yfmgSy7gqg4gS6ae1gzyAgqglgS6x
					eWhFxZgqglgS6zfBgpxbgqglgS60f3gGxbgqhDgS6Og2fbyTgqhcgR5ChRfEz2gqhfgR47hRfDz/gqhIgS6Gg5fYyegqgrgS6rf7gDxpgqglgS6ze/gqxbgq
					glgS6yeug2xagqglgS6zfDgoxbgqglgS60fzgIxbgqglgS60gAgAxb]],
				["Toe.R"] = [[
					gqgNgI/8gAgAhmgqgNgI/8gSfchmgqgNgI/6gsephmgqgfgJ/4gpeqiTgqg7gL/vgcfAj4gqhGgL/rgHfukggqg5gK/zfzgdjagqgfgJ/4fZhSiTgqgNgI/5
					fHhxhmgqgNgI/7fehDhmgqgNgI/8f7gJhmgqgqgJ/3gcfFiqgqhDgL/ngoejkmgqhFgL/mgnejkwgqgwgK/2gdfAi3gqgTgI/8f+gFh2gqgNgI/7fdhFhmgq
					gNgI/6fUhYhmgqgNgI/7ffhBhmgqgNgI/8f5gNhmgqgNgI/8gAgAhm]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAi0gVAEgAgAhqgAi0glAPgAgAjsgAi0gvAagAgAk+gAi0gsAXgAgFkpgAi0gnARgBflj+gAi0ghAQgAd/jPgAi0geALf+eTiwgAi0gdAIgAfriogAi0gaAG
					gBgOiSgAi0gWAIh6f7h1gAiugVAumefqhogAibgVCesLfYhigAh8gVFCxIfHhagAhhgVHG0Ae9hTgAhdgVHb0Ze8hSgAhqgVGdzLfAhVgAhsgVGSy8fBhWgA
					hggVHP0Le9hSgAhcgVHi0ie8hRgAhcgVHi0ie8hRgAhcgVHi0ie8hRgAhcgVHi0ie8hRgAhcgVHi0ie8hR]],
				Spine1 = [[
					gAi2gAAbgAgAlIgAi5gQA0gAgAnHgAi6gbBJgAgAoYgAi6gYBDgAgFoDgBi5gTA5f+flnZgDi4gNAyfyd/mrgCi3gJArfyeUmMgAi3gIAmf9frmFgAi3gFAi
					gDgOlvgAi2gBAhh5fulSgBiwgABFmZe+lBgCicgAC0sCeDkvgCh9gAFWw7dQkVgChigAHZzxczkAgChegAHt0Kcvj8gChqgAGwy9c7kGgChtgAGlyuc+kIgC
					hggAHhz8cxj+gChcgAH00Tctj7gChcgAH00Tctj7gChcgAH00Tctj7gChcgAH00Tctj7gChcgAH00Tctj7]],
				Spine2 = [[
					gAjDfZBKgAgAofgAjLfrBxgAgAqbgAjPf3COgAgArpgAjOf0CGgBgFrVgCjMfuB3f7flqsgIjJfnBrfkeCp/gGjHfjBhfneWphgBjHfhBcf7fspaf/jFfeBV
					gEgOpFgCjEfaBRh4fqopgGi8fZB1mYewoagLimfZDmr/dnoMgOiCfZGMw1ckn3gPhlfZIRzob6nlgPhgfZIl0Ab1njgPhufZHny0cHnrgPhxfZHcylcKnsgP
					hjfZIZzyb4nkgPhffZIs0JbznigPhffZIs0JbznigPhffZIs0JbznigPhffZIs0JbznigPhffZIs0Jbzni]],
				Neck1 = [[
					gAjOfGFMgAgAxbgAjYfaH1gAgA08gAjefnJxgAgA3AgAjcfkJPgDgE2egCjZfdIPfxfp1agKjWfWHQe5eU0KgIjTfRGlfEelzWgCjTfQGZf1fvzKf/jRfMF8
					gIgLyjgDjPfIFVhie3xjgKjHfGFWlOcMwdgSiufGGYp6ZGu2gXiIfGIGuFWos3gZhpfGJiwkVVragZhkfGJxw6VKrMgZhzfGJFv2Vsr2gZh1fGI9vpVzr+gZ
					hnfGJowtVQrUgahifGJ2xCVGrHgahifGJ2xCVGrHgahifGJ2xCVGrHgahifGJ2xCVGrHgahifGJ2xCVGrH]],
				Neck2 = [[
					gAj1e1GzgAgAzsgAkCfUJvgAgA29gAkJfpL2gAgA41gAkHfjLRgDgE4XgCkEfYKLfvfr3YgMkAfOJGeveb2OgKj9fGIWe8er1egCj8fDIJfzfw1Tf/j6e+Hp
					gJgL0ugIj2e3G8hSejzygajqezGykXbJyjgtjIeyHcoUXLwhg5iXewIor5UEt5g9hwewJquDSdr9g+hqewJ0uWSQrqg9h8ewJVtaS5sjg8h/ewJPtPTCsug+
					htewJuuLSXr1g+hnewJ4ucSLrjg+hnewJ4ucSLrjg+hnewJ4ucSLrjg+hnewJ4ucSLrjg+hnewJ4ucSLrj]],
				Head = [[
					gAkYesAGgAgAiMgAknfVBXgAgApLgAksfwC+gAgAtcgAkrfpCff7gDsVgCkofbBqgdfrqIgMkkfNBHiOeRnygLkhfCAth7ebmFgCkge/AggYfslkf/kde4AU
					fwgOkWgMkZeuAKh2fMiVgokKepAvmPdegOhGjgemCjrjb8dqhZikekFJv7bXa3hfh1ejHLyWbdZAhfhueiHfyqbfYuhdiEejGjxqbYZjhdiIejGXxdbYZthf
					hyejHTyfbeY4hfhreiHmyybgYohfhreiHmyybgYohfhreiHmyybgYohfhreiHmyybgYohfhreiHmyybgYo]],
				Jaw = [[
					gAkXeL/8gAgAhxgAk0e3//gAgAfvgAlCfX/9gAgAecf/k+fO/+gGf/eygDk3e9/+fegLfdgQkuet/3dbhJgCgOkoei/5dzhJgkgDkmee/+flgPgzf+kheX/+
					gSf1hKgNkYeN/0eEgiimgrkEeI+zZbhYlZhIjUeH8JT1hTpDhWiUeH4aPagEsWhYhjeH1hNJevuQhYhceH1FM3ehughYhyeH2aNxfLtthYh2eH2qN9fTtjhY
					hgeH1VNBepuXhYhZeH07MxecumhYhZeH07MxecumhYhZeH07MxecumhYhZeH07MxecumhYhZeH07Mxecum]],
				["UpperArm.L"] = [[
					fdi8e33EOtgAt3fdjIfJ5UPCcppHfdjQfV6RPmail3fdjOfS6DPcbCmxffjKfL5lO+cgoLfpjGfB46OJe4pFfnjDe94ZOIfcqbffjCe/4ROpeorefcjAe932
					O1ezslfejCe52FNtfWuKfijFe4ysLweWwKfsi7e5ucKOb3x+f4ihe6qjJxYyzHgAiJe7oOJ8WizegCiFe7n6J/WNzff+iRe7o6J2XOzZf9iTe7pGJ1XbzYgB
					iHe7oGJ9WZzegCiDe7nzKAWFzfgCiDe7nzKAWFzfgCiDe7nzKAWFzfgCiDe7nzKAWFzfgCiDe7nzKAWFzf]],
				["LowerArm.L"] = [[
					fQirem2g2ggAjWfQi/ey2u2EkYe5fQjMe92Z1WnHcEfPjJe62h1kmWcwfTjCez2p16lSelffi7eq2n2Dk2hTfci2en2p2NjkiJfSi0eq2t2YiVhdfOixeq2q
					2ehMh1fPixeo3l1Zf2jFfPi2er5xyjeGjZfTiyew8JuhcSimfcife19xqba0hHfkiLe5+fnraHf2fmiIe5+knSaCfpfiiSe4+TogaTgPfhiUe3+QovaXgXfl
					iKe5+hnhaFfwfmiHe5+mnJaAfkfmiHe5+mnJaAfkfmiHe5+mnJaAfkfmiHe5+mnJaAfkfmiHe5+mnJaAfk]],
				["UpperArm.R"] = [[
					gji8e33ExTgAt3gjjIfJ5Uw+jXpHgjjQfV6Rwalel3gjjOfS6Dwnk3msgmjKfN5iwtkJopgvjFfK4zwRkIrRgtjDfF4VwfjEsQgljCfA4QxGh2r0gijAe833
					xWg3sVgji5e44Gvteut7gjipe25Prqaju3geiKe15zmUVduXgWhie05JhhQ7sugPhFe04KeuOSrIgOhAe03/eVN8q4gRhOe04ffhPDrpgShQe04lfwPRrygP
					hDe04GejOJrBgOg+e038eNN0qygOg+e038eNN0qygOg+e038eNN0qygOg+e038eNN0qygOg+e038eNN0qy]],
				["LowerArm.R"] = [[
					gwirem2gJggAjWgwi/ey2uJ8boe5gwjMe92ZKqY5cEgwjJe62hKcZjc3gzjBe22tKDbVd/g+i6e22xJreBedg8i1ey2vJie2fwgyi0es2uJleIhAgvixeo2p
					JkegiJguimen03H/fhjUgliReowVE3fnkcgUhyerp7CFfKlUgChPeujqA1ermCf3g3ewfrAueVmef2gzewfHAweSmif6g/evg2AtecmVf7hBevhMAteemTf2
					g2ewfcAveUmff1gyewe7AxeRmjf1gyewe7AxeRmjf1gyewe7AxeRmjf1gyewe7AxeRmjf1gyewe7AxeRmj]],
				Tail1 = [[
					gAiygvhZgAgA/9gAiug/jbgAgA/zgAishIktgAgA/pgAithGkYgIgA/sf/iuhBjtfUf//xf9ivg7i9cxf//sf9iwg4iedSgC/xf/iwg3iXffgA/5gAixg0iB
					gXf//7gAixgxhnf0eG/5f/isgvhdfNZj/Sf+iZgvhSedT49if+h7gvg6d1O+6+f+hhgvgldeMH47f+hdgvghdaLv4mf+hpgvgsdkM85kf+hrgvgtdmNL5vf+
					hfgvgjdcL94yf+hbgvggdZLm4ff+hbgvggdZLm4ff+hbgvggdZLm4ff+hbgvggdZLm4ff+hbgvggdZLm4f]],
				Tail2 = [[
					gAivhShmgAgA/8gAinhhjngAgA/ygAiihqk6gAgA/ngAijhnkkgLgA/qf+imhjj5fEf//vf2iphcjJbkgA/hf3iqhZircRgE/qf+irhZikfSgB/4gBishWiO
					gff+/6f/iuhTh3fqeH/4f9iqhShwepZm/Qf6iYhShddYT+9ff5h8hSgzcSPI66f5hjhRgObrMV42f5hghRgIbmL94if5hrhRgab2NJ5ff5hthSgdb6NY5rf5
					hihRgLbpML4uf5hehRgGblL14bf5hehRgGblL14bf5hehRgGblL14bf5hehRgGblL14bf5hehRgGblL14b]],
				Tail3 = [[
					gAirh0hFgAgA/+gAifiCjHgAgA/1gAiYiLkagAgA/sgBiaiIkEgOgB/uf8idiEjZezf9/yfsiih9ioaXf6/Yfvilh6iKbQgA/kf9ilh7iDfGgA/6gCinh5ht
					gof//8f+iqh1hafjeH/5f5imh0hVeOZm/Qf0iXh0g+ckUA9cfxh+hzgGbJPO6zfxhphzfUaWMg4tfxhlhzfMaPMI4YfxhwhzfkakNS5XfxhyhzfoaoNg5ifx
					hnhzfQaTMW4kfxhkhzfJaNMA4RfxhkhzfJaNMA4RfxhkhzfJaNMA4RfxhkhzfJaNMA4RfxhkhzfJaNMA4R]],
				Tail4 = [[
					gAipiXgMgAgA//gAiYikiOgAgA/6gAiOisjhgAgA/zgBiRiqjLgRgB/1f5iWimigejf6/3fgicidhuZLft/NfligibhQaQf2/cf7ihidhKe6f+/8gDikibg0
					gwgA/+f9iniYgkfeeG/7f1ikiWgjd5Zk/QfsiYiVgIb6T+9WfoiEiUfFaMPQ6nfphxiTeHZQMm4cfphuiTd9ZIMP4Gfoh3iUebZhNW5Hfoh5iUehZmNk5Tfp
					hwiTeDZNMc4TfphtiTd6ZGMH3/fphtiTd6ZGMH3/fphtiTd6ZGMH3/fphtiTd6ZGMH3/fphtiTd6ZGMH3/]],
				Tail5 = [[
					gAioi5eygAgA/+gAiUjHg0gAgA/+gAiHjOiIgAgA/7gCiKjMhxgUgD/8f2iRjIhGeTf0/7fSiZi8gXYBfT++fZidi7f4ZRfh/Rf4iejAfwetf6/9gFiii+fa
					g4gD/+f8imi7fNfbeE/6fwiki5fSdqZe/Ofkibi3e1bbT19NffiMi0dqZhPJ6Sfgh9izckYfMi4Afgh7iycZYWMN3pffiCizc7YxNS4tffiDizdBY3Nf46fg
					h8iycfYbMZ32fhh6iycVYTMF3hfhh6iycVYTMF3hfhh6iycVYTMF3hfhh6iycVYTMF3hfhh6iycVYTMF3h]],
				["UpperLeg.L"] = [[
					fWh9gE6qe3gAxpfWh/gN8he4f4ucfWiBgT9he5fysRfWiBgR9Re7fws2fWiAgN8wepgNt9fYh/gF8FdwhlvEfYh+gE7rd7hWv3fWh+gH7mesgNwIfWh9gH7R
					e/fxwsfQiCgE68dSe7w/fDiMgE6pZVcowDe7iRgE5jUQaGuDe8iKgE3nPrYUr2fBh/gE17M9XeqWfCh8gE1qMlXYqIe/iDgE2dNvXtqye/iEgE2nN+Xxq7fB
					h+gE10MzXcqQfCh8gE1kMdXWqDfCh8gE1kMdXWqDfCh8gE1kMdXWqDfCh8gE1kMdXWqDfCh8gE1kMdXWqD]],
				["LowerLeg.L"] = [[
					fUhTfyuygkgA8XfUhbfyx+gjgE6dfUhifzz6gjgH5CfUhgfzzagogE5bfVhdfxyagLgR6KfZhaftxQewg+65fYhXftwgfDg07YfVhXfxwVgRgL7gfUhVfyvy
					gwf670fJhafxu8fteT8OeyhpfuuKdpaN7/egh4frtHbNVB6mebh9forwZNQd4cefh5fmqvYGNx2pegh4fmqlX8Na2Xeeh7fnrDYaOj3Nedh7fnrJYgOx3Xeg
					h5fmqrYCNn2iehh4fmqiX5NS2Rehh4fmqiX5NS2Rehh4fmqiX5NS2Rehh4fmqiX5NS2Rehh4fmqiX5NS2R]],
				["Foot.L"] = [[
					fWglgS60gAgAxbfWgmgH8qgAgAuNfWgqgA9pgAgAsBfWgpgC9ZgDf8smfWgngE85fxgXtvfYgmgE8Pe5hsu5fXglgI70fEhbvsfWglgM7wf1gRv6fWglgP7b
					gHf0wefFgsgR7Geae9w5eig/gQ6xadcpwQeChXgO5sVaZ+uod1hpgM3zQ4X6svd2hugL2LOMW2rZd3hugL17N0WtrNd1htgM2sO+XJr0d1htgM21PMXOr7d2
					hugL2EOCWyrUd3hugL11NsWqrId3hugL11NsWqrId3hugL11NsWqrId3hugL11NsWqrId3hugL11NsWqrI]],
				["Toe.L"] = [[
					fWgNgI/8gAgAhmfWgSf3/6gAgAd4fWgYft/rgAgAbgfWgWfw/wgAf7cIfXgTf0/4f+gbdXfZgRf2/5f4iBetfYgPf6/8f6htfmfWgPf///f/gVf0fWgOgD//
					gAfygdfDgVgF/6eGf6g/eZgpgE/UZhf4gndyhHgB9kT0gHfvdhhff+6/O3gmfDdhhqf846MAhCeudihqf84lLnhHerdghnf95jM1g5ezdghmf95vNEg3e1di
					hqf84xL1hEesdihrf84eLehIeqdihrf84eLehIeqdihrf84eLehIeqdihrf84eLehIeqdihrf84eLehIeq]],
				["UpperLeg.R"] = [[
					gqh9gE6qhJgAxpgqh/gN8hhIgIucgqiBgT9hhHgOsRgqiBgR9RhKgIs2grh/gP8wg5ggt/gsh+gQ8FgAhyvNgsh+gN7rgMhfv/gqh+gJ7mg9gVwKgqh9gG7R
					hQf2wrgjh4gE7PfifAwwgRhrgE7lbdc8vQf3hWgE7MWAa/smfgg+gE5uQ+Z+p9fTgtgE4QN7ZuoSfSgqgE4BNgZtoDfXgygE4vO0ZwoxfYgzgE43PEZyo6fS
					grgE4KNwZtoLfRgpgE37NXZtn+fRgpgE37NXZtn+fRgpgE37NXZtn+fRgpgE37NXZtn+fRgpgE37NXZtn+]],
				["LowerLeg.R"] = [[
					gshTfyuyfcgA8Xgshbfyx+fdf86dgshifzz6fdf55Cgshgfyzafhf45bgthcfzyafEgI6JgwhZf4xQdpg460gwhXf3wgd8gw7UgthXfzwVfKgH7fgrhVfxvy
					fpf470gghQfwuzemeT8RgDhHfstqcnaM8Ifgg8fnsKaZU963fFgwfjqdYtQU4ye5glfgpRX2Nk3Ce3gjfgpGXvNM2we8gofhpoYFOX3le9gpfhpvYKOl3ve4
					gkfgpMXzNZ27e3gifgpCXtND2qe3gifgpCXtND2qe3gifgpCXtND2qe3gifgpCXtND2qe3gifgpCXtND2q]],
				["Foot.R"] = [[
					gqglgS60gAgAxbgqgmgH8qgAgAuNgqgqgA9pgAgAsBgqgpgB9ZgDf8smgqgngG85fxgXtvgrglgP8Pe5hsu5grglgR70fEhbvsgqglgO7wf1gRv6gqglgO7b
					gHf0wdgZgigQ7NeZe+wufwgfgP7GaZcwvtfAgfgM6QVLaZtnefgggJ4fQdYyrYeRgegI25NnYEp4ePgdgI2pNOX/pqeVgfgI3aOcYQqVeWgfgI3jOrYUqdeQ
					gegI2zNcYCpyePgdgI2jNFX9plePgdgI2jNFX9plePgdgI2jNFX9plePgdgI2jNFX9plePgdgI2jNFX9pl]],
				["Toe.R"] = [[
					gqgNgI/8gAgAhmgqgSf3/6gAgAd4gqgYft/rgAgAbggqgXfw/wgAf7cIgrgTf2/4f+gbdXgtgQgA/5f4iBetgsgPgD/8f6htfmgqgPgB//f/gVf0gqgOgC//
					gAfygdgWgLgF/7eGf7gzfngKgC/VZhgAf+exgQf99iT0gleleNgXf565O7hkdid/gaf24wMHiZdCd9gaf24bLvihc+eCgZf35bM7iIdKeDgZf35nNKiEdNd+
					gaf24oL9icdAd9gaf24ULmikc9d9gaf24ULmikc9d9gaf24ULmikc9d9gaf24ULmikc9d9gaf24ULmikc9]],
			},
		},
	},
}
