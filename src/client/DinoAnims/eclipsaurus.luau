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
					gAikgjAIgAgAingAikgjAIgAgAiogAilgjAIgAgAirgAilgjAJgAgAiwgAimgjAJgAgAi2gAimgjAKgAgAi8gAimgjAKgAgAjDgAilgjALgAgAjJgAilgjAL
					gAgAjNgAikgjAMgAgAjQgAikgjAMgAgAjRgAijgjAMgAgAjRgAiigjAMgAgAjRgAiigjAMgAgAjRgAihgjAMgAgAjRgAihgjAMgAgAjRgAihgjAMgAgAjRgA
					iigjAMgAgAjRgAiigjAMgAgAjRgAijgjAMgAgAjRgAikgjAMgAgAjRgAikgjAMgAgAjRgAilgjAMgAgAjRgAilgjAMgAgAjRgAimgjAMgAgAjRgAimgjAMgA
					gAjQgAimgjALgAgAjNgAilgjALgAgAjJgAilgjAKgAgAjDgAikgjAKgAgAi8gAikgjAJgAgAi2gAijgjAJgAgAiwgAiigjAIgAgAirgAiigjAIgAgAiogAih
					gjAIgAgAingAihgjAIgAgAingAihgjAIgAgAingAiigjAIgAgAingAiigjAIgAgAingAijgjAIgAgAin]],
				Spine1 = [[
					gAingNAzgAgAnAgAiogNA1gAgAnJgAipgNA4gAgAnWgAipgNA7gAgAnjgAiqgNA+gAgAnwgAiqgNBBgAgAn8gAiqgNBEgAgAoGgAiqgNBFgAgAoMgAipgNBG
					gAgAoOgAipgNBFgAgAoLgAiogNBDgAgAoFgAingNBBgAgAn9gAingNA/gAgAn2gAimgNA+gAgAnwgAimgNA9gAgAnsgAimgNA9gAgAnrgAimgNA9gAgAnsgA
					imgNA+gAgAnwgAingNA/gAgAn2gAingNBBgAgAn9gAiogNBDgAgAoFgAipgNBFgAgAoNgAiqgNBHgAgAoUgAiqgNBJgAgAoagAiqgNBKgAgAoegAiqgNBKgA
					gAodgAiqgNBIgAgAoXgAiqgNBFgAgAoMgAipgNBBgAgAn8gAiogNA9gAgAnqgAiogNA4gAgAnYgAingNA0gAgAnGgAimgNAxgAgAm3gAilgNAugAgAmsgAil
					gNAtgAgAmngAilgNAtgAgAmlgAilgNAtgAgAmngAilgNAugAgAmqgAimgNAvgAgAmwgAingNAxgAgAm4]],
				Spine2 = [[
					gAi6flB/gAgArEgAi7flCGgAgArWgAi9flCOgAgArrgAi+fmCXgAgAsAgAi/fmCfgAgAsUgAi/fmCmgAgAslgAjAfmCrgAgAswgAjAfnCtgAgAs2gAjAfnCt
					gAgAs2gAi/fnCqgAgAsugAi+fmCkgAgAshgAi9fmCegAgAsSgAi8fmCYgAgAsEgAi7fmCUgAgAr5gAi7fmCRgAgArygAi7fmCQgAgArwgAi7fmCRgAgArygA
					i7fmCUgAgAr5gAi8fmCYgAgAsEgAi9fmCegAgAsSgAi+fmCkgAgAshgAi/fnCrgAgAsxgAjAfnCxgAgAs+gAjBfnC2gAgAtJgAjBfnC5gAgAtQgAjBfnC5gA
					gAtQgAjBfnC1gAgAtHgAjAfnCtgAgAs2gAi/fmCjgAgAsfgAi9fmCYgAgAsCgAi8flCMgAgArlgAi6flCBgAgArIgAi5flB4gAgAqwgAi4flBygAgAqegAi3
					fkBugAgAqUgAi3fkBugAgAqSgAi3fkBugAgAqUgAi4fkBxgAgAqcgAi4flB1gAgAqngAi5flB6gAgAq1]],
				Neck1 = [[
					gAjKfTE2gAgAw6gAjLfTE7gAgAxCgAjNfUFFgAgAxRgAjOfVFSgAgAxmgAjPfVFigAgAx+gAjQfWFzgAgAyWgAjRfWGDgAgAytgAjRfXGRgAgAzAgAjRfXGb
					gAgAzNgAjQfWGggAgAzTgAjPfWGfgAgAzTgAjOfWGcgAgAzOgAjMfVGZgAgAzKgAjMfVGXgAgAzHgAjLfVGVgAgAzFgAjLfVGVgAgAzEgAjLfVGVgAgAzFgA
					jMfVGXgAgAzHgAjMfVGZgAgAzKgAjOfWGcgAgAzOgAjPfWGfgAgAzTgAjQfXGjgAgAzXgAjRfXGmgAgAzbgAjSfXGogAgAzegAjTfYGqgAgAzggAjTfYGngA
					gAzdgAjSfXGfgAgAzSgAjRfXGRgAgAzAgAjQfWF/gAgAyngAjOfVFsgAgAyMgAjLfUFZgAgAxwgAjJfTFIgAgAxVgAjIfSE6gAgAxAgAjGfSExgAgAwxgAjF
					fSEtgAgAwrgAjFfSEtgAgAwqgAjFfSEtgAgAwrgAjGfSEugAgAwtgAjHfSExgAgAwxgAjIfTEzgAgAw1]],
				Neck2 = [[
					gAj4e8LxgAgA4ygAj6e9L6gAgA45gAj8e+MMgAgA5HgAj+fAMkgAgA5agAkAfCNBgAgA5vgAkCfENggAgA6GgAkDfGN+gAgA6bgAkDfHOYgAgA6sgAkDfIOr
					gAgA65gAkCfIO2gAgA6/gAkBfIO2gAgA7AgAkAfHOxgAgA69gAj/fHOtgAgA66gAj+fGOqgKgL64gAj9fGOogjgo62gAj9fGOohBhK60gAj9fGOqhXhk6zgA
					j+fGOthehs60gAj/fHOwhdhs62gAkAfHO0hdhs65gAkBfIO5hdhs67gAkDfJO9hdht6+gAkEfJPChcht7BgAkFfKPFhcht7DgAkFfKPHhWhm7FgAkFfKPBhA
					hL7EgAkFfJOxgjgo68gAkDfHOYgKgL6sgAkBfFN5gAgA6XgAj+fCNWgAgA5/gAj8fAMzgAgA5lgAj5e+MUgAgA5NgAj3e8L7gAgA46gAj1e6LrgAgA4sgAj0
					e6LkgAgA4ngAj0e6LjgAgA4mgAj0e6LkgAgA4ngAj1e6LmgAgA4ogAj2e7LpgAgA4rgAj3e7LtgAgA4u]],
				Head = [[
					gAkofGAMgAgAjXgAkqfHAOgAgAjogAkrfKATgAgAkMgAktfNAagAgAlAgAkufQAlgAgAmAgAkvfUAzgAgAnEgAkwfYBDgAgAoFgAkwfaBTgAgAo+gAkvfcBg
					gAgAppgAkufdBogAgAqDgAktfdBqgAgAqIgAksfcBogAgAqCgAkrfbBngAgAp+gAkqfaBmgHgnp6gAkpfaBpgYiLp0gBkpfZBygskCprgBkpfaB+g7lcpigB
					kqfaCDg/l1phgBkrfbCEg+l1plgBksfbCFg9l1ppgBktfcCHg8l1pugBkufdCJg7l1p0gBkwfeCKg6l1p4gBkwffCLg6l1p8gBkxffCIg1ldqCgBkxffB6gp
					kDqCgAkxfdBmgXiLpsgAkwfaBUgHgno+gAkufWBCgAgAn/gAktfSAxgAgAm3gAkqfNAigAgAlvgAkofJAXgAgAktgAkmfGAQgAgAj3gAklfEAMgAgAjUgAkk
					fDALgAgAjHgAkkfDALgAgAjGgAkkfDALgAgAjHgAkkfDALgAgAjJgAklfEALgAgAjNgAknfFAMgAgAjS]],
				Jaw = [[
					gAkyd9/6gAgAiJgAk1d//7gAgAh5gAk5eB/9gAgAhUgAk+eF//gAgAgfgAlEeK//gAgAffgAlKeQ/8gAgAeagAlPeV/4gAgAdWgAlSea/ygAgAcbgAlVed/t
					gAgAbvgAlVef/pgAgAbUgAlVef/ogAgAbPgAlTee/pgAgAbVgAlSec/qgAgAbaf+lQec/rgAfZbpf3lPec/rgDdzcKfwlPed/kgKb6czfqlOef/ZgTagdTfo
					lPeg/VgWaHdafolQeg/VgXaHdWfolReh/UgXaHdRfolTej/UgYaHdMfolVek/TgZaHdGfolWel/TgaaHdBfolXem/SgbaHc+fqlYem/WgYagcyfwlYej/hgO
					b6cbf3lWef/sgDdzcSf+lSea/zgAfZcngAlNeU/4gAgAddgAlGeN/9gAgAemgAk/eH//gAgAfwgAk4eC/+gAgAgzgAkyd+/8gAgAhpgAkud7/6gAgAiNgAks
					d6/5gAgAiagAksd6/5gAgAibgAksd6/5gAgAiagAktd6/5gAgAiXgAkud7/6gAgAiTgAkwd8/6gAgAiO]],
				Ring = [[
					gAl/hSAhgAgAlogAl/hVAkfsgBl4gAl7hbArfYgCmbgAl1hiA3fEgBnPgAlthqBHewf/oNgAlkhxBbecf7pQgAlah4BxeIf2qPgAlQh9CGd0fxrHgAlJiACX
					dhfrrwgAlDiBCidNfmsIgAlBiBCmc6fisMgAlBiACmcmfgsGgAlBh/CmcSfesBgGlAh+CncHgBsBgWlBh8CscMhhsJgplCh4C4cXjTsRg3lEh0DGcakpsXg6
					lEhzDNcNk9scg6lFh0DSb5k6sig6lFh1DXbkk2spg6lFh2DdbQkyswg6lGh3Dja8kts3g6lGh4Dpaokps+g6lHh5DuaUkltDg3lGh7DwZ6kItFgplGh+DmZR
					ivsygWlJiADVYhg/sAgGlQh9DEX1fqq6gAlZh2C0XWfUpygAljhuCkXCfootgAlshmCXWuf8nngAlzhdCOWbgQmngAl5hVCJWIghl0gAl8hQCJV2gulSgAl9
					hOCNVjgzlEgAl9hOCUVQg1lCgAl9hOCbU+g2lCgAl+hPCiUrg3lDgAl+hQCqUYg3lFgAl/hRCyUFg2lJ]],
				["UpperArm.L"] = [[
					fLjFfB1MNVS2nOfLjHfB1VNkSgm1fLjJfB1dN3SImYfLjLfC1mOKRvl7fLjNfD1tOdRYlffLjOfD1zOtRGlIfLjPfE13O4Q5k4fLjPfE14O9QzkwfLjPfE14
					O7Q1kzfLjOfE11OzQ+k+fLjNfD1xOmRNlRfLjLfD1rOXRflofLjKfD1lOJRwl8fLjIfC1hN/R9mMfLjIfC1eN4SGmWfLjHfC1dN2SJmafLjIfC1eN4SGmWfL
					jIfC1hN/R9mMfLjKfD1lOJRwl8fLjLfD1rOXRflofLjNfD1xOmRNlRfLjOfE12O1Q7k7fLjQfE16PEQskmfLjRfF1+PPQfkWfLjSfF2APWQXkMfLjSfF2APX
					QXkLfLjRfE19POQgkYfLjPfE14O9QzkwfLjNfD1wOlROlSfLjLfC1mOLRul6fLjIfB1aNwSRmjfLjFfB1NNXSznLfLjDfA1CNCTRnsfLjBfA05M0TnoEfLjA
					fA00MsTzoRfLjAe/0yMqT2oVfLjAfA00MsTzoRfLjBfA03MyTqoHfLjCfA09M7Tbn4fLjEfA1FNHTKnk]],
				["LowerArm.L"] = [[
					epjNepJ/SbU9vQepjQepKLShU5vjepjTeqKbSqUyv6epjWerKtS0UowTepjYesK/S/UcwsepjaetLQTKUQxBepjceuLdTUUFxRepjceuLmTcT8xbepjceuLp
					ThT1xdepjbeuLmTiTxxYepjZetLeTfTxxLepjWetLTTaTzw8epjUesLJTWT1wuepjSerLCTST2wjepjRerK9TQT3wcepjRerK8TPT3wZepjRerK9TQT3wcep
					jSerLCTST2wjepjUesLJTWT1wuepjWetLTTaTzw8epjZetLeTfTxxLepjbeuLpTkTwxbepjdevLzToTuxoepjfewL7TrTtxzepjgewMBTtTsx6epjgewMATs
					Tux5epjfevL3TmTzxvepjceuLmTcT8xbepjZetLQTPUHw/epjVesK4TBUVweepjReqKfSyUiv7epjNepKISkUvvaepjKeoJ2SZU6u9epjHenJpSRVBuoepjG
					enJjSNVEudepjFenJiSMVEubepjGenJjSNVEudepjHenJnSPVDulepjJeoJuSTVBuxepjLeoJ2SXU/u/]],
				["UpperArm.R"] = [[
					g1jFfB1MyrtKnOg1jHfB1Vyctgm1g1jJfB1dyJt4mYg1jLfC1mx2uRl7g1jNfD1txjuolfg1jOfD1zxTu6lIg1jPfE13xIvHk4g1jPfE14xDvNkwg1jPfE14
					xFvLkzg1jOfE11xNvCk+g1jNfD1xxauzlRg1jLfD1rxpuhlog1jKfD1lx3uQl8g1jIfC1hyBuDmMg1jIfC1eyIt6mWg1jHfC1dyKt3mag1jIfC1eyIt6mWg1
					jIfC1hyBuDmMg1jKfD1lx3uQl8g1jLfD1rxpuhlog1jNfD1xxauzlRg1jOfE12xLvFk7g1jQfE16w8vUkmg1jRfF1+wxvhkWg1jSfF2AwqvpkMg1jSfF2Awp
					vpkLg1jRfE19wyvgkYg1jPfE14xDvNkwg1jNfD1wxbuylSg1jLfC1mx1uSl6g1jIfB1ayQtvmjg1jFfB1NyptNnLg1jDfA1Cy+svnsg1jBfA05zMsZoEg1jA
					fA00zUsNoRg1jAe/0yzWsKoVg1jAfA00zUsNoRg1jBfA03zOsWoHg1jCfA09zFsln4g1jEfA1Fy5s2nk]],
				["LowerArm.R"] = [[
					hXjNepJ/tlrDvQhXjQepKLtfrHvjhXjTeqKbtWrOv6hXjWerKttMrYwThXjYesK/tBrkwshXjaetLQs2rwxBhXjceuLdssr7xRhXjceuLmsksExbhXjceuLp
					sfsLxdhXjbeuLmsesPxYhXjZetLeshsPxLhXjWetLTsmsNw8hXjUesLJsqsLwuhXjSerLCsusKwjhXjRerK9swsJwchXjRerK8sxsJwZhXjRerK9swsJwchX
					jSerLCsusKwjhXjUesLJsqsLwuhXjWetLTsmsNw8hXjZetLeshsPxLhXjbeuLpscsQxbhXjdevLzsYsSxohXjfewL7sVsTxzhXjgewMBsTsUx6hXjgewMAsU
					sSx5hXjfevL3sasNxvhXjceuLmsksExbhXjZetLQsxr5w/hXjVesK4s/rrwehXjReqKftOrev7hXjNepKItcrRvahXjKeoJ2tnrGu9hXjHenJptvq/uohXjG
					enJjtzq8udhXjFenJit0q8ubhXjGenJjtzq8udhXjHenJntxq9ulhXjJeoJuttq/uxhXjLeoJ2tprBu/]],
				Tail1 = [[
					gAijhDfsgAgA//gAikhDfhgUgB//gAikhDfagogB/+gAilhDfag6gC/+gAilhDfehMgD/9gAilhDfohbgE/9gAilhDf2hogE/8gAikhDgHhygF/8gAijhDgZ
					h6gE/7gAijhDgqh/gE/7gAiihDg5iAgD/6gAihhDhHh/gC/6gAihhDhSh6gB/6gAighDhchzgB/6gAighDhihogA/6gAighDhkhbgA/7gAighDhihMgA/7gA
					ighDhcg6gA/8gAihhDhTgogA/9gAihhDhHgUgA/+gAiihDg5gAgA/+gAijhDgsfsf//+gAijhDggfYf//+gAikhDgXfGf+/+gAikhDgRe0f9/+gAikhDgNel
					f8/9gAikhDgJeYf7/8gAikhDgHeOf7/8gAikhDgGeGf8/7gAijhDgGeBf8/7gAijhDgHd/f9/7gAiihDgJeBf+/7gAiihDgNeGf//7gAihhDgReNgA/8gAih
					hDgVeYgA/8gAihhDgXelgA/9gAihhDgVe0gA/9gAihhDgPfGgA/+gAiihDgFfYgA//gAijhDf6fsgA//]],
				Tail2 = [[
					gAikiBfBe3f8/9gBimiBerfdf+/9gCiniBeagDgB/8gEiniBeQgpgD/7gFiniBeMhPgG/6gGimiBeRhygJ/5gGiliBediSgM/3gHikiBevivgP/2gHiiiBfF
					jIgR/0gIigiBfdjbgS/zgIieiBf2jpgS/ygIidiBgOjygR/xgHiciBgnj0gQ/wgHiaiBg9jxgP/wgGiaiBhQjogO/wgGiaiBhdjZgM/xgFiaiBhijEgL/zgE
					iaiBhgirgJ/2gCiciBhWiNgI/4gBidiBhFhsgH/7gAieiBgwhJgF/9f/igiBgYgjgD//f+ihiBf/f9gA//f8iiiBfofXf9/+f7ijiBfVexf6/9f6ijiBfGeO
					f3/7f6ikiBe5duf0/4f5ikiBevdRfx/2f5ijiBepc4fv/zf4ijiBepclfv/xf4iiiBetcXfv/wf4iiiBe2cOfv/vf5ihiBfCcMfx/vf5igiBfRcPfy/wf6ig
					iBfhcYf0/yf6igiBfucnf1/zf7igiBfzc8f3/2f8igiBfxdVf4/4f+iiiBfndyf5/6f/ijiBfWeTf7/8]],
				Tail3 = [[
					f8iojAe2dAfx/1f/irjAeeduf1/3gDitjAeJeff5/5gGiui/d4fTf9/6gJiui/dtgIgC/6gMiti/dqg9gH/5gPiri/duhxgN/3gSipi+d5ihgS/0gUimi+eL
					jNgX/xgViii+egj1gc/ugWifi+e4kWgf/rgWici+fUkwgi/ogWiZi9f0lDgk/lgWiXi9gUlOgk/jgUiVi+gzlQgj/igTiUi+hNlLgi/igRiUi+hfk+gg/kgO
					iVi+hokogd/ngLiWi/hnkMga/rgIiZi/hcjpgX/wgEibjAhIjAgU/1gBiejAgsiSgQ/5f9ihjAgNhggM/9f6ikjAfsgsgH/+f3imjAfNf3gB/+f0ini/evfD
					f7/8fxioi/eSePf1/5fuipi+d5dffu/0fsipi+dnczfo/vfrioi+dccMfj/pfqioi+dabqfg/lfqimi+dhbQfd/ifqili+dxa9fc/gfqiji+eHayfd/gfsii
					i+ejavfe/hftihi+e8a0fh/jfvihi/fPbCfj/lfyihi/fYbXfm/pf1iji/fWb0fq/tf4iljAfLcXft/x]],
				Tail4 = [[
					fwitj9eobFfd/kf2ixj9eXbvfj/qf9i0j9eHcgfp/vgDi2j9d4dXfv/zgKi3j9dteSf1/3gQi2j9dmfQf8/5gWi0j8djgPgC/5gbixj8dmhOgJ/4ggitj7du
					iKgR/1gkioj6d6jDgZ/xgnikj6eJj3gh/sgpifj5eeklgo/ngqiaj5e7lLgu/igqiWj5felpgz/egpiSj5gCl+g2/agniQj5glmKg4/YgkiOj5hCmNg4/Wgg
					iPj6hYmFg2/XgbiQj7hkl1g0/agWiTj8hllbgw/egQiXj9hbk5gr/kgKicj+hGkPgm/rgDihj+gpjegg/yf9ilj+gHiogZ/4f2ipj+fihtgS/8fwisj9e7gv
					gK/9fqivj9eQfxgB/8flixj8dmeyf3/4fgiyj7dBd2ft/xfcizj6clc9fj/qfZiyj5cUcKfa/ifXiwj5cRbcfT/bfWiuj4caa1fN/WfWirj5cwaXfK/TfXio
					j5dQaBfI/SfZilj5dzZ1fI/Tfcikj6eQZyfK/Ufgikj7emZ5fN/Xflimj8eyaKfS/afqipj8ezajfX/f]],
				Tail5 = [[
					fdizk4dkZ1e//Rfmi4k5dgaQfH/Xfvi8k6dda1fP/df5i/k6dabifX/kgDjAk7dXcXff/qgNjAk6dVdSfm/wgXi+k6dUeRft/1ggi6k5dTfTf1/3goi2k4dU
					gWf+/4gwixk3dWhZgI/2g2irk2dYiZgU/yg6ilk1dgjVgg/tg+ifk0dzkLgr/og/iZkzeNk6g2/jhAiTkzeulig//eg+iOkzfRmBhG/Zg8iLkzfzmWhM/Vg3
					iKk0gRmihO/SgyiLk1gnmjhP/SgriOk3g0mbhN/TgjiSk4g3mJhK/XgaiYk6gvlthF/cgRiek7gdlJg+/jgHilk8gCkcg2/rf9irk8fijngt/xfziwk8e6it
					gk/2fpi2k7eJhugY/4fgi6k5dTgtgL/3fYi+k4cffrf9/yfRjAk2bxepfu/rfLjAk0bOdpfg/ifGi/kza5cufT/ZfDi8kya0b4fH/SfBi4kybAbIe+/MfBiz
					kybbage3/KfCiukzb+aAez/JfFirk0cgZqex/IfJiqk1c9Zdex/JfOirk2dUZbe0/KfViuk3dhZje4/N]],
				["UpperLeg.L"] = [[
					fEhtgN7acvf8wLfEhugN7Tcxf+wXfEhugN7Lczf/wkfEhvgN7Ec1gBwxfEhvgM69c3gCw8fEhwgM63c5gDxFfEhwgM60c5gDxLfEhvgL6zc5gDxMfEhvgL60
					c5gCxKfEhvgL64c4gBxEfEhugL6+c2gAw6fEhtgL7Ec0f+wwfEhsgL7Jcyf9wnfEhsgL7Ocxf8wffEhsgL7Qcwf7wbfEhsgL7Rcwf7wZfEhsgL7Qcwf7wbfE
					hsgL7Ocxf8wffEhsgL7Jcyf9wnfEhtgL7Ec0f+wwfEhugL6+c2gAw6fEhvgL63c4gBxFfEhvgL6xc6gDxOfEhwgL6sc7gExWfEhwgL6pc8gFxbfEhwgL6pc8
					gFxcfEhwgL6sc7gExXfEhvgL6zc5gDxMfEhvgM67c3gBw+fEhugM7Gc0f/wtfEhtgM7Qcxf9wbfEhsgN7acuf7wKfEhsgN7icsf6v8fEhrgN7ocqf4vxfEhr
					gN7rcpf4vrfEhrgN7scpf3vqfEhrgN7rcpf4vrfEhrgN7pcqf4vwfEhrgN7lcrf5v3fEhsgN7gctf7wA]],
				["LowerLeg.L"] = [[
					fAhHf4slgfgB9afAhHf4sygegA9UfAhHf4s+gdgA9PfAhIf5tHgcf/9LfAhIf5tNgcf/9IfAhIf5tPgbf+9HfAhIf5tMgbf+9JfAhIf5tGgcf+9MfAhHf4s7
					gcf+9QfAhHf4svgdf+9WfAhGf3shgef+9cfAhGf3sTgff+9hfAhFf2sHggf/9nfAhFf2r9ghf/9qfAhFf2r3ghf/9tfAhFf2r1ghf/9ufAhFf2r3ghf/9tfA
					hFf2r9ghf/9qfAhFf2sHggf/9nfAhGf3sTgff+9hfAhGf3shgef+9cfAhHf4sugdf+9WfAhHf4s7gcf99QfAhIf5tFgbf99MfAhIf5tMgbf99JfAhIf5tOgb
					f99IfAhIf5tMgbf99JfAhIf5tGgcf+9MfAhHf4s8gdf+9QfAhHf4swgef/9VfAhGf3sjgfgA9bfAhGf3sWgggA9gfAhGf3sLghgB9lfAhFf2sDgigB9ofAhF
					f2r9gigB9qfAhFf2r7gigC9rfAhFf2r9gigB9qfAhFf2sDgigB9ofAhGf3sMghgB9kfAhGf3sYgggB9f]],
				["UpperLeg.R"] = [[
					g8htgN7ajRgEwLg8hugN7TjPgCwXg8hugN7LjNgBwkg8hvgN7EjLf/wxg8hvgM69jJf+w8g8hwgM63jHf9xFg8hwgM60jHf9xLg8hvgL6zjHf9xMg8hvgL60
					jHf+xKg8hvgL64jIf/xEg8hugL6+jKgAw6g8htgL7EjMgCwwg8hsgL7JjOgDwng8hsgL7OjPgEwfg8hsgL7QjQgFwbg8hsgL7RjQgFwZg8hsgL7QjQgFwbg8
					hsgL7OjPgEwfg8hsgL7JjOgDwng8htgL7EjMgCwwg8hugL6+jKgAw6g8hvgL63jIf/xFg8hvgL6xjGf9xOg8hwgL6sjFf8xWg8hwgL6pjEf7xbg8hwgL6pjE
					f7xcg8hwgL6sjFf8xXg8hvgL6zjHf9xMg8hvgM67jJf/w+g8hugM7GjMgBwtg8htgM7QjPgDwbg8hsgN7ajSgFwKg8hsgN7ijUgGv8g8hrgN7ojWgIvxg8hr
					gN7rjXgIvrg8hrgN7sjXgJvqg8hrgN7rjXgIvrg8hrgN7pjWgIvwg8hrgN7ljVgHv3g8hsgN7gjTgFwA]],
				["LowerLeg.R"] = [[
					hAhHf4slfhf/9ahAhHf4syfigA9UhAhHf4s+fjgA9PhAhIf5tHfkgB9LhAhIf5tNfkgB9IhAhIf5tPflgC9HhAhIf5tMflgC9JhAhIf5tGfkgC9MhAhHf4s7
					fkgC9QhAhHf4svfjgC9WhAhGf3shfigC9chAhGf3sTfhgC9hhAhFf2sHfggB9nhAhFf2r9ffgB9qhAhFf2r3ffgB9thAhFf2r1ffgB9uhAhFf2r3ffgB9thA
					hFf2r9ffgB9qhAhFf2sHfggB9nhAhGf3sTfhgC9hhAhGf3shfigC9chAhHf4sufjgC9WhAhHf4s7fkgD9QhAhIf5tFflgD9MhAhIf5tMflgD9JhAhIf5tOfl
					gD9IhAhIf5tMflgD9JhAhIf5tGfkgC9MhAhHf4s8fjgC9QhAhHf4swfigB9VhAhGf3sjfhgA9bhAhGf3sWfggA9ghAhGf3sLfff/9lhAhFf2sDfef/9ohAhF
					f2r9fef/9qhAhFf2r7fef+9rhAhFf2r9fef/9qhAhFf2sDfef/9ohAhGf3sMfff/9khAhGf3sYfgf/9f]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAiVgjACe5gKgfgAiXgjADfHhCgdgAiegjAFffhwgdgAijgjAGf9iKgegAilgjAGgbiMgggAihgjAFg0h2ghgAiagjAEhFhLgigAiVgjADhJgUgggAiVgjAD
					hBfZgegAiagjAEguelgdgAihgjAFgSeBgdgAilgjAGf0dygfgAijgjAGfYd8ghgAiegjAFfCedgigAiXgjADe3fPgh]],
				Spine1 = [[
					gAiVgNAWe7gSkYf/iYgNAXfKg0kgf+iegNAafkhNk0f9ikgNAdgDhYlHf9ilgNAegghTlNf9iigNAcg4hAlBf+ibgNAZhGgjksgAiWgNAWhIgAkbgBiWgNAW
					g/fckagCibgNAYgqe+kpgDihgNAcgNesk/gDilgNAefueplMgDikgNAefTe1lJgCiegNAafAfNk3gBiYgNAXe4fuki]],
				Spine2 = [[
					f/ihfiBEe+gaoCf8ikfiBIfJgmoTf6irfjBTffgro6f5iyfjBdf7gopff6i0fjBggXgdpof7ivfjBZgugOpQf9iofiBNg9f9omgAiifiBFhDftoHgDiifiBF
					g+ffoGgFiofiBNgufWolgHivfjBZgUfWpPgHi0fjBgf3fdpogGiyfjBefdfrpggEisfjBTfKf6o8gBilfiBIe+gLoT]],
				Neck1 = [[
					f+itfNDXfEgnuLf7iwfODLfRgwt0f5i4fPDpfogxuxf4i/fQEigEgowYf5jBfQFRgegVxjf7i8fPFSgwgAxlf+i0fOElg6ftwbgBiufNDrg+ffu0gEiufODL
					g3fUt1gGi0fODVglfPuJgIi8fPEEgKfSvkgHjBfQE+fufhxFgGjAfQFZfYf1xvgEi4fPFAfKgKxHgBiwfOEHfDgbvn]],
				Neck2 = [[
					f6jWeuJyfVg52/f4jZetJ0fkg93Bf2jjexKZf6g23kf3jte3LJgRgk4Pf5jxe7LkgjgM4mf8jse6LYgufz4cgAjie1Ksgyfd31gEjZewKAgvfM3MgHjWetJu
					gkfE27gJjdeuKDgRfF3PgKjoe0Kxf6fS36gIjwe5Lbfmfn4egFjwe7LjfXgB4lgCjoe4LEfPgZ4Lf+jdeyKUfOgs3f]],
				Head = [[
					f3kHevAEe6gMhcf1kJevAFfAf1hpf0kTe1AGfTfhiCf2kde+AHfvfRiWf6khfEAHgNfIiYf+kcfDAHgnfKiHgDkSe7AFg6fWhugHkJeyAEhFfphdgKkHeuAE
					hFf/hggMkOexAFg4gVh1gLkZe5AHgfgoiNgIkgfCAHgBg1iagEkgfEAHflg4iSf/kYe/AGfPgxh7f7kNe2AFfAghhj]],
				Jaw = [[
					f2kIdm/1hHf+i9f1kLdm/2g+gTiwf2kXds/4goglidf6kid1/3gJgxivf+kmd7/2fqg1i1gCkgd5/3fSgvitgGkVdy/3fBgiirgJkKdp/1e5gNi8gKkIdl/1
					e8f3i5gKkQdo/3fMfjilgIkddw/4fnfUingEkmd5/2gHfMi0gAkkd7/2gjfNizf8kbd2/3g3fWikf5kPdt/2hEfoi2]],
				Ring = [[
					fxlugxAQe7gRjtfslvgxARe/f6j6fsl2g6AUfRfkkSfvl9hFAXfsfSkmf0mBhLAXgJfIkpf8l+hIAVgjfIkYgEl4g+ASg3fSj/gMlwg0AQhDfkjugSlugwAQ
					hFf7jxgUlyg1ATg5gRkFgTl6g/AWgigmkegPmAhJAYgFg0kqgImAhLAXfpg6kigAl7hDAUfSg0kLf4l0g4ARfCglj0]],
				["UpperArm.L"] = [[
					fJiie9vrOvlz1HfGile+wLOtlK04fEive/xYOZjoz9fDi4fAyyN9hrygfEi8fAz8Nif2w4fGi4e/0sNNeivefJiwe91FM7d1ugfMiqe81OMvdouAfPiqe71Q
					Mqdzt3fSive71JMseUuJfTi3e80yM1fPu7fTi7e80CNFgowPfSi4e8y0NdiXx4fQive8xXN8kHzdfNime8wJOblZ0n]],
				["LowerArm.L"] = [[
					ezh+e61W2aZmk9eviCe51p2uaxjVesiNe22H28dIgheqiZey2X2ugKdSeqiget2Q2GjIaferigeo1+1YlZYoeuiael1x07mrX0exiVei1x01nAX4e1iVeh19
					1GmfYqe4iZei2P1llMaBe6ifek2f2JjNb9e7ifen2l2mgpebe6iYes2Y2vd3hJe4iNey172kbajje2iCe31e2XZ3k/]],
				["UpperArm.R"] = [[
					gzipe81QzViWt4gvise71OzWiAt9gti0e71AzQhSuegsi6e80ezEgIvhgti7e8zeyweixCgvi0e8yGyUcvytgyiqe8wsx0bK0Hg1ije8vzxZaS08g4ije9v0
					xQaZ1Fg7iqe+wuxbbi0gg9i0e/yFx1dWzRg9i7fAzayRfTxrg7i7e/0Xypg5wIg5i0e+07y9h5u7g2ise91LzLiVuN]],
				["LowerArm.R"] = [[
					hNiUeiKK07m2n0hJiXehJ61Ul8mwhHiceiJo13kSlGhFigelJc2ah+i3hFideqJf2tfQgOhHiTevJ12rcjdlhJiHe1KV2cafblhMh/e5Kq2WZja1hPh/e6Kj
					2jaAbrhTiHe4KI23b0d+hViTe0Jv25enhHhWidevJq2chskOhWiheqJ51ukXmlhUidemKK1HmKn6hRiXejKR01m9oQ]],
				Tail1 = [[
					gAiZhDcvhBhG/ygCibhDcBgzhB/tgDihhDbxgdgw/sgEinhCcMgEgW/wgEiohCc/fpf5/2gEikhDdofQff/5gDiehDdtfAfJ/4gBiZhDdJe9e8/1f/iZhDcW
					fFe7/wf9iehDb0fXfG/sf8ilhCb6fvfc/uf8iohCckgKf4/zf8inhCdXgkgV/4f9ihhDdwg5gt/5f+ibhDdfhDg+/3]],
				Tail2 = [[
					gDiliAbVi8hG/fgEirh/Z1hzhD/UgFiyh/Y/gYgz/MgEi2h/ZWe7gW/RgDi0iAardpf1/dgBiuiAcGcvfb/lf/iniAcrcYfI/mf9ikiAcAcse9/jf8ioh/ak
					dme6/af7iuh/ZSe6fD/Pf7i1h/ZBgXfb/Nf8i2h/Z8hwf7/Xf+ixiAbci4gZ/igAiqiAcijhgw/mgCiliAcfjjg+/l]],
				Tail3 = [[
					gOi4i7amldhJ/CgKjDi5YjjxhD+3gFjNi3W8hegx+ogAjPi4W0e+gQ+of6jJi6YRcpfo+2f1i9i8aWa2fJ/Dfxi0i8bqZ7e6/Ffxi0i7bWaEe3/Efzi9i6Zn
					bSe5++f4jIi4XndVfE+vf9jPi3Wrfyfe+mgDjNi5XZiQgE+ugJjDi7ZUkWgq++gNi4i8bLlwhB/FgPizi8bumKhI/F]],
				Tail4 = [[
					gijNjyaDoBhT+XgYjfjvX2mThC+RgKjvjsVljhgt+Cf8jyjsUtgLgI97fujmjwV0c1fX+JfijTjzYLaAet+ZfbjGj0aQYJee+bfbjHjzaoXrem+YfijWjwZE
					Yre1+VfvjojtWna/fH+Kf9jyjrU6eIfk98gLjtjuVChigQ+AgZjdjyW7kshA+TgjjLj0ZXnFhe+cgmjEjzasoShg+Z]],
				Tail5 = [[
					g/jkkkY3qChz9eguj+kgW/o0hP9YgWkVkbUZmEgs9Lf8kbkbSyiUgA9CfjkMkhTMeNfF9PfNjxkmVXaYeL9le/jcknX6Xedw9qe9jcklZFWCd99hfIjwkjYH
					WXef9bfdkLkdVrYafC9Sf3kbkaTYbvfo9FgRkWkdSufvgc9Ggpj/kkUIjyha9bg8jlknWtnPiI9qhEjZkmYwpeiO9m]],
				["UpperLeg.L"] = [[
					fIhXgV2gcggm2dfHhbgY4RcXfn0hfFhigb7JcJemwafDhqgd+Ob+dSpSfChtgd/acRb6iXfAhrgc/icxbyfcfAhlgZ/rcyc3fyfAhhgW/pcceZikfChggS/S
					b5fhlRfDhkgP+nbagcoEfGhpgN9RbNhTr6fIhrgN7vbMhyvFfJhogN6hbSh3xJfKhhgP5hbghoysfJhagS4Ob5hL0d]],
				["LowerLeg.L"] = [[
					fDgsgUiHfafi/6fAgwgRedgcfH/8e8g8gGehhnfE/5e5hSf5jui6fq/oe2hofzrtj/g09fe1htfxxjj+ht6Ze3hnfu0qi+h04Le7hafq11hihc3Se+hSfp0I
					gShL41fBhOfpwvfRg77PfEhKfuuRefgu8lfGhGf0sQeBgk9efGhAf7pod7gW+bfGg3gBmSeOgC/UfFgvgKjSexfv/z]],
				["Foot.L"] = [[
					fBgmhC80e/gft2fBg0g+8Uf6gDu5fBhAgz76hAfcvlfBhIgk7oiKewv7fBhJgS7fjKeLv8fBhFgC7mjXeFvtfBg7f07/ioelvOfBgtft8ihUfWuZfBgmfy81
					gHf9t3fBgmf980fLgat2fBgmgJ8yecgwt1fBgmgU8xeAg9t1fBgmgf8wd4hBt0fBgmgr8xeDg8t1fBgmg28yecgwt1]],
				["Toe.L"] = [[
					fBgUg0/7fQg2htfBgigx/3f7gGi3fBgugo/wgufGjqfBg1gZ/ohheBkFfBg2gI/giNdHkJfBgyf2/hiYc8j5fBgofo/rh4drjSfBgbfg/3g9e5iUfBgUfk/8
					gFf6htfBgUfw/7fZgshtfBgUf7/5e2hThtfBgUgG/3eihqhtfBgUgS/3echxhtfBgUgd/3ejhohtfBgUgo/5e2hTht]],
				["UpperLeg.R"] = [[
					g/hggU/Yjwg1k2g+higR/CkZgDmag7hmgO+AkufGp/g5hqgN8fk1eatpg4hqgN7FkyeJwPg3hlgO6BkoePx7g2hdgQ47kVelzig3hYgT3aj1fH1cg4hYgX3R
					jkf61qg6hega5kjwg5y1g8hmgc80j+iBtLg+hsgd/Fj9jflbg/hsgc/gjdkWgahAhoga/mjKjxfShAhjgY/tjXiag4]],
				["LowerLeg.R"] = [[
					hDhTfq2AfLey3LhAhQfoyWgQe86Lg9hMfrvYhKfM8Bg7hIfxtRhzfX9Dg6hDf4rDiFfi98g6g8f+oAh+f0+6g7gzgFkphigJ/ng8gsgPiZg7gY/4g/gtgTf5
					gFgu/+hCg1gMd7fAg//5hFhGf/gddwgv/5hJhff0nxcefz+1hLhtfyvBb3eq76hKhrfvzZcdeK5HhHhhfs1cdueV3l]],
				["Foot.R"] = [[
					g/gmfs81fYgTt3g/gmf481gZf0t3g/gmgD8zhPfat2g/gmgO8xh0fIt1g/gmga8wiGe/t0g/gmgl8wiFfAt0g/gmgw8xhyfJt1g/gmg88zhTfYt2g/gthB8j
					glftuag/g7g58GfkgPvSg/hFgs7weag6vzg/hJgb7idThkv+g/hIgK7gcnh9v2g/hAf67wc6hvvgg/g0fw8Pd/hEu2]],
				["Toe.R"] = [[
					g/gUff/8fjghhtg/gUfq/8gSfshtg/gUf1/6g6e/htg/gUgB/4hWeghtg/gUgM/3hjeRhtg/gUgX/3hieShtg/gUgj/4hUehhtg/gUgu/6g9e7htg/gbg0/5
					gbfhiVg/gogt/0fsgZjTg/gygh/se4hdj6g/g2gQ/keHifkKg/g1f//fdojHkEg/gufv/ld0iyjog/gifj/yejhwi2]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAihgj/+gAgAhMgAiLgj/8fye2hMgAiQgj/7fseXhMgAimgj/8fye2hMgAihgj/+gAgAhMgAiLgj/8gOhKhMgAiQgj/7gUhphMgAimgj/8gOhKhM]],
				Spine1 = [[
					gAifgNANgAgAjcf+iJgNAKgXhIirf+iOgNAMghhmi2f+ikgNAPgZhHjngAifgNANgAgAjcgCiJgNAKfpe4irgCiOgNAMffeai2gCikgNAPfne5jn]],
				Spine2 = [[
					gAipfhA/gAgAnzf7iQfhAqgfhFmTf5iWfhAwgthhmof7iufiBGgjhDoIgAipfhA/gAgAnzgFiQfhAqfhe7mTgHiWfhAwfTefmogFiufiBGfde9oI]],
				Neck1 = [[
					gAi0fNEqgAgAwmf6iZfLDNgvg7t4f3iffMDihFhSuef6i6fNFCg2g1xKgAi0fNEqgAgAwmgGiZfLDNfRfFt4gJiffMDie7euuegGi6fNFCfKfLxK]],
				Neck2 = [[
					gAjie0MMgAgA5Hf4jCerJ4hBgn3Ef1jKetKZhdg13hf5jpe3MvhFgf5ggAjie0MMgAgA5HgIjCerJ4e/fZ3EgLjKetKZejfL3hgHjpe3Mve7fh5g]],
				Head = [[
					gAkRfAAOgAgAjof5jzetAGgUgjiGf3j6exAIgfgxibf7kYfEARgbghj+gAkRfAAOgAgAjogHjzetAGfsfdiGgJj6exAIfhfPibgFkYfEARflffj+]],
				Jaw = [[
					gAkcd3/4gAgAiqf3j3dk/Uf2fZmefzkAdo/efvfJlof5kkd8/7fsfahzgAkcd3/4gAgAiqgJj3dk/UgKgnmegNkAdo/egRg3logHkkd8/7gUgmhz]],
				Ring = [[
					gAlmhOAkgAgAl4gAlVgyAUgXghkWgAlZg4AYgiguksgClphUAogdgfmNgAlmhOAkgAgAl4gAlVgyAUfpffkWgAlZg4AYfefSksf+lphUAofjfhmN]],
				["UpperArm.L"] = [[
					fLise7sPO6nX29fEiRe/pBQ9pO5HfBiXfBp2Q+oc5FfEizfAtEPZmJ3OfLise7sPO6nX29fTiPe3olPWqR30fWiVe2pTOvp/3OfTixe4s3N/nd12]],
				["LowerArm.L"] = [[
					eyiKfBJnJfeWjZerhyfQJPJsibg9eph4fRJLJyiBiBeriRfFJeJ5eZk5eyiKfBJnJfeWjZe5hwfFJgJTgyfTe8h1fBJoJKfvfte6iPe6KBJOc2jU]],
				["UpperArm.R"] = [[
					g1ise7sPxGYp29gtiPe3olwqVv30gqiVe2pTxRWB3Ogtixe4s3yBYj12g1ise7sPxGYp29g8iRe/pBvDWy5Hg/iXfBp2vCXk5Fg8izfAtEwnZ33O]],
				["LowerArm.R"] = [[
					hOiKfBJn2hhqjZhHhwfFJg2tfOfThEh1fBJo22gRfthGiPe6KB2yjKjUhOiKfBJn2hhqjZhVhyfQJP2Udlg9hXh4fRJL2Od/iBhViRfFJe2Hhnk5]],
				Tail1 = [[
					gAiohCdMgtf6/3gCiShCbzgnf8/tgDiXhCcBgKf//vgCithCdbfngE/4gAiohCdMfTgG/3f+iShCbzfZgE/tf9iXhCcBf2gB/vf+ithCdbgZf8/4]],
				Tail2 = [[
					gDiziAdwiFfz/2gFiih+bMg7f8/ngEimh/anfNgC/hgBi3iAdLd+gH/zf9iziAdwd7gN/2f7iih+bMfFgE/nf8imh/angzf+/hf/i3iAdLiCf5/z]],
				Tail3 = [[
					gLi7i9efjvfz/vgIi1i6bmiAf4/ngBi7i5ZpfFgB/Vf5jCi9cictgA/of1i7i9efcRgN/vf4i1i6bmeAgI/nf/i7i5Zpg7f//VgHjCi9cijTgA/o]],
				Tail4 = [[
					gZjBj6eulOf9/igQjGj2chjlf1/mf9jTjzZWf0f//SfsjPj5bhcKf2/cfnjBj6euaygD/ifwjGj2chcbgL/mgDjTjzZWgMgB/SgUjPj5bhj2gK/c]],
				Tail5 = [[
					gujGk1dymHgV/UgejTkxc9lMf+/af9jtksZVhNgC/QfdjgkzaKcffu/QfSjGk1dyZ5fr/UfijTkxc9a0gC/agDjtksZVezf+/QgjjgkzaKjhgS/Q]],
				["UpperLeg.L"] = [[
					fEhmgb0Zc1go4cfDhRgfyWbbcx5mfDhXgh6gb/YqQKfDhsgf/xdHd/hVfEhmgb/sccf9ijfGhPgW/iasf7g6fHhUgV5ybehsyTfGhqgWuddqiE8X]],
				["LowerLeg.L"] = [[
					e/g7gicegvfp/ye0gqgsJgllez2Ae3h9gPGGbMfFN5e9hpfzEUeGfhQIfEhffvAIgjgSdYfGhNfqQHhvgOETfEgqgGeZg8f2AEfDhGgwYxg0fqA3]],
				["Foot.L"] = [[
					fBhFhO8DgUf1vYfBhVgq5tqWaCu1fBhUf/7VktdTvufBhCfc8EhwfDvOfDhYfC/Oe5f4m2fBgmgB8xeCg9t1fBgmgz8ze0glt2fBgyhZ7rfAglwA]],
				["Toe.L"] = [[
					fBgyhD/zgOfujafBhCgf9bnQWhj0fBhBf0/RjTbskAfBgwfQ/whQedjRfChPeu/de7gUaUfBgUfz/3ejhohtfBgUgl/6fIg/htfBgfhO/tfTg7kI]],
				["UpperLeg.R"] = [[
					g8hmgb/sjkgDijg6hPgW/ilUgFg6g5hUgV5ykieUyTg6hqgWudiWd88Xg8hmgb0ZjLfY4cg9hRgfyWkljP5mg9hXgh6gkBnWQKg9hsgf/xi5iBhV]],
				["LowerLeg.R"] = [[
					g8hffv/4gjgSiog6hNfqv5hvgO7tg8gqgGhng8f2/8g9hGgwnPg0fq/JhBg7gicefRgX/yhMgqgsJgabhN2AhJh9gPGGk0g7N5hDhpfzEUh6gfQI]],
				["Foot.R"] = [[
					g9hYfC/OhHgIm2g/gmgB8xh+fDt1g/gmgz8zhMfbt2g/gyhZ7rhAfbwAg/hFhO8DfsgLvYg/hVgq5tVql+u1g/hUf/7VbTitvug/hCfc8EeQg9vO]],
				["Toe.R"] = [[
					g+hPeuAje7gUlsg/gUfzAJejhoeTg/gUglAGfIg/eTg/gfhOATfTg7b4g/gyhDANgOfucmg/hCgfClnQWhcMg/hBf0AvjTbscAg/gwfQAQhQedcv]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAimgjAHgAgAicgAihgnAJgAgAi0gAiVgxAPgAgAjugAiIg7AXgAgAksgAiBhAAcgAgAlMgAirgIABgAgAgrgAi/flAFgAgAd/gAi/flAFgAgAd/gAi/flAF
					gAgAd/gAi9fpAEgAgAeSgAi3f5ABgAgAfcgAiugPACgAgAg+gAiogfAGgAgAiJgAimgjAHgAgAicgAimgjAHgAgAicgAimgjAHgAgAic]],
				Spine1 = [[
					gAipgNAvgAgAmugAilgRAygAgAm8gAiagbA6gAgAnfgAiPglBDgAgAoDgAiJgrBIgAgAoWgAisfxAcgAgAlKgAi8fOALgAgAjJgAi8fOALgAgAjJgAi8fOAL
					gAgAjJgAi7fSAMgAgAjYgAi2fjAUgAgAkVgAiwf4AggAgAljgAirgJArgAgAmfgAipgNAvgAgAmugAipgNAvgAgAmugAipgNAvgAgAmu]],
				Spine2 = [[
					gAi8flB3gAgAqtgAi4fpB5gAgAqxgAiufzB9gAgAq8gAikf+CBgAgArIgAifgECDgAgArOgAi6fHBbgAgApYgAjFeiBDgAgAoCgAjFeiBDgAgAoCgAjFeiBD
					gAgAoCgAjEenBGgAgAoOgAjCe4BSgAgAo7gAi/fOBkgAgAp1gAi8fgBzgAgAqigAi8flB3gAgAqtgAi8flB3gAgAqtgAi8flB3gAgAqt]],
				Neck1 = [[
					gAjKfSEegAgAwSgAjHfWE3gAgAw7gAi+fhF4gAgAydgAi0fsHDgAgA0AgAivfyHsgAgA0ygAjHezDYgAgAuQgAjQeOBsgAgAqNgAjQeOBsgAgAqNgAjQeOBs
					gAgAqNgAjQeSB1gAgAqogAjPekCdgAgAsRgAjNe7DagAgAuWgAjLfNEQgAgAv5gAjKfSEegAgAwSgAjKfSEegAgAwSgAjKfSEegAgAwS]],
				Neck2 = [[
					gAj4e5LDgAgA4KgAj2e/L2gAgA41gAjvfPN6gAgA6YgAjnfhQOgAgA70gAjifqRegAgA8ggAjxeUJHgAgA2VgAjwdkFggAgAx7gAjwdkFggAgAx7gAjwdkFg
					gAgAx7gAjxdpF1gAgAyYgAj0d/HJgAgA0IgAj2ecJDgAgA2RgAj4ezKogAgA3zgAj4e5LDgAgA4KgAj4e5LDgAgA4KgAj4e5LDgAgA4K]],
				Head = [[
					gAkofAAEgAgAhpgAklfJALgAgAjIgAkcfhAvgAgAmwgAkQf6BzgAgAqggAkKgHChgAgAsagAkheTACgAgAgvgAkddSAbgAgAa+gAkddSAbgAgAa+gAkddSAb
					gAgAa+gAkedZAWgAgAbagAkjd1AJgAgAdKgAkneaABgAgAfcgAkoe4ACgAgAhMgAkofAAEgAgAhpgAkofAAEgAgAhpgAkofAAEgAgAhp]],
				Jaw = [[
					gAkqd3/8gAgAhpgAkueB/+gAgAg4gAk1ec/+gAgAe4gAk5e9/zgAgAchgAk6fQ/qgAgAbegAkfdK8PgAgAvDgAkBcO8/gAgAtjgAkBcO+egAgApvgAkBcO+J
					gAgAqsgAkEcV+1gAgAohgAkRcu/ZgAgAmGgAkfdS/wgAgAj1gAkodv/7gAgAiGgAkqd3/8gAgAhpgAkqd3/8gAgAhpgAkqd3/8gAgAhp]],
				Ring = [[
					gAmOhCAQgAgAj6gAl/hVAffLgElYgAlTh9BWeVf8o9gAkgifCtdhfmsmgAkEisDpcvfQuZgAmOgPAbb4goi/gAmvegAibRhodQgAmvegArafh6dRgAmvegA1
					ZuiLdSgAmuerA/Y6iVdvgAmpfWBHYAiKfcgAmegOBYXFhvhpgAmSg4BxWNhWjTgAmOhCCFVahTjsgAmOhCCXUohajpgAmOhCCrT3hgjn]],
				["UpperArm.L"] = [[
					fLjGfA0UNZgAwQfLjCfE06M/eXu5fLi5fP18MpaIrgfLiwfa2ZNUVhn7fLirfg2YOHTKmHfLjBei21NRamrCfLjJd93WN1b+refLjJd93WN1b+refLjJd93W
					N1b+refLjJeB3LNxcPr0fLjIeS2eNldStHfLjHep1bNceruwfLjGe70jNZfvv9fLjGfA0UNZgAwQfLjGfA0UNZgAwQfLjGfA0UNZgAwQ]],
				["LowerArm.L"] = [[
					eyiqerJbJbgAhvexiresJPKGdbkSeuiueyKCNBXZqUerixe+MpR6R9v5eqiyfGOmVFPsyTewi0eEJGKtcllseyi4deJXJgh+fweyi4deJXJgh+fweyi4deJX
					Jgh+fweyi3djJWJfh2f5eyi0d2JXJdhVgaeyiveRJYJbgphFeyiremJaJbgIhmeyiqerJbJbgAhveyiqerJbJbgAhveyiqerJbJbgAhv]],
				["UpperArm.R"] = [[
					g1jGfA0UyngAwQg1jCfE06zBhpu5g1i5fP18zXl4rgg1iwfa2Zysqfn7g1irfg2Yx5s2mHg1jBei21yvlarCg1jJd93WyLkCreg1jJd93WyLkCreg1jJd93W
					yLkCreg1jJeB3LyPjxr0g1jIeS2eybiutHg1jHep1bykhVuwg1jGe70jyngRv9g1jGfA0UyngAwQg1jGfA0UyngAwQg1jGfA0UyngAwQ]],
				["LowerArm.R"] = [[
					hOiqerJb2lgAhvhPiresJP16ilkShSiueyKCy/onqUhVixe+MpuGuDv5hWiyfGOmq7wUyThQi0eEJG1TjblshOi4deJX2geCfwhOi4deJX2geCfwhOi4deJX
					2geCfwhOi3djJW2heKf5hOi0d2JX2jergahOiveRJY2lfXhFhOiremJa2lf4hmhOiqerJb2lgAhvhOiqerJb2lgAhvhOiqerJb2lgAhv]],
				Tail1 = [[
					gAimhDfZgAgA//gAighHfdgAgA//gAiShQfmgAgA//gAiEhafwgAgA//gAh8hff1gAgA//gAiugncfgAgA/zgAjIgDa9fYgF/lgAjIgDb8fdgD/ugAjIgDb8
					gjf9/ugAjFgHcUhRf6/wgAi9gYdnhGf9/4gAixgue+gMgA/+gAiog/fufvf///gAimhDfjf6gA//gAimhDfZgAgA//gAimhDfZgAgA//]],
				Tail2 = [[
					gAioiBeHgAgA/7gAiiiFd3gAgA/6gAiUiPdPgAgA/3gAiFiYclgAgA/zgAh9idcPgAgA/xgAi8hkaGgAgA/cf+jbg+ZsevgH/Vf+jXg/bre6gD/rgCjXg/br
					hGf9/rgFjUhEcIijf6/pgEjGhWdkiMgA/0gBi1hsewgYgB/9f/iph9fEfdf+/+gAioiBebfzf//8gAioiBeHgAgA/7gAioiBeHgAgA/7]],
				Tail3 = [[
					gAiwjAdJgAgA/3gAirjDclgAgA/zgAifjMbNgAgA/ogAiSjVZvgAgA/XgAiLjaY/gAgA/NgAjSieYCgAgA+/f5jzh4YweGgG/Gf6joh7bueYgC/qgGjoh7bu
					hof+/qgPjjiAcQj0f+/igNjPiTd1jRgH/wgCi6ire1glgD/9f9iti8evfMf7/9f/iujAdnftf+/5gAiwjAdJgAgA/3gAiwjAdJgAgA/3]],
				Tail4 = [[
					gAi7j9cQgAgA/xgAi4kAbZgAgA/qgAixkIZQgAgA/RgAiqkPXBgAgA+tgAimkTV4gAgA+WgAjxjVWFgAgA+afxkPivX5ddgE+1fzj5i3b1d1f//pgNj5i3b1
					iLgB/pgejxi7cdlEgH/YgZjYjQeLkVgR/pgEi/jpe/gxgF/9f6iyj6ede7f3/7f+i3j9c3fmf9/1gAi7j9cQgAgA/xgAi7j9cQgAgA/x]],
				Tail5 = [[
					gAjJk6a7gAgA/lgAjKk8ZwgAgA/YgAjLlBW6gAgA+qgAjMlET+gAgA9ogAjMlFSegAgA8/gAkVkITwgAgA9jfoktjlWoc1f8+bfrkJjzbhdTf3/jgVkJjzbh
					itgJ/jgxj/j1cQmSgZ/JgqjfkMeGlYgk/egHjDknesg8gJ/8f1i4k4dweqfx/4f8jDk7bsfgf7/sgAjJk6a7gAgA/lgAjJk6a7gAgA/l]],
				["UpperLeg.L"] = [[
					fEhvgO7MczgAwifEhrgQ8Fcmfzu8fEhggX9ycMfUrBfEhVgd/Bb1e0mgfEhPgh/bbrehj1fEhyf428dZgn2JfEiEffzXd3hC5WfEiEffzXd3hC5WfEiEffzX
					d3hC5WfEiDfizid3hB5OfEh9fu0Zd1g84ifEh1f+3Udcgn1wfEhwgL6kc6gHxjfEhvgO7MczgAwifEhvgO7MczgAwifEhvgO7MczgAwi]],
				["LowerLeg.L"] = [[
					fAhIf5tSgcgA9GfAhGf3sfgigD9ce/hEf1rVgsgI96e/hEf1rWgvgJ95e/hFf2r+gugI9qfBhGf2sHgNf09mfChafqswf8fu9VfChafqswf8fu9VfChafqsw
					f8fu9VfChYfts9f8fu9PfChRf2t9f9fu8yfBhJf7uAgJf08xfAhIf5tNgaf+9IfAhIf5tSgcgA9GfAhIf5tSgcgA9GfAhIf5tSgcgA9G]],
				["Foot.L"] = [[
					fBgmgX81gAgAt3fBgmgX81gGf9t3fBgmgX81gQf4t3fBgmgX81gTf3t3fBgmgX81gRf4t3fBgmgX81fwgHt3fBg4gJ6ZfkgTyDfBg4gJ6ZfkgTyDfBg4gJ6Z
					fkgTyDfBg2gL6wfjgTxifBgugS78figRvkfBgmgX81ftgJt3fBgmgX81f9gBt3fBgmgX81gAgAt3fBgmgX81gAgAt3fBgmgX81gAgAt3]],
				["Toe.L"] = [[
					fBgUgJ/8gAgAhtfBgUgJ/8gFf7htfBgUgJ/8gMfzhtfBgUgJ/8gOfwhtfBgUgJ/8gNfyhtfBgUgJ/8f1gNhtfBgkgB/UftgdmhfBgkgB/UftgdmhfBgkgB/U
					ftgdmhfBgigC/cftgcl6fBgbgH/xfrgbjofBgUgJ/8fygQhtfBgUgJ/8f+gChtfBgUgJ/8gAgAhtfBgUgJ/8gAgAhtfBgUgJ/8gAgAht]],
				["UpperLeg.R"] = [[
					g8hvgO7MjNgAwig8hrgQ8FjagNu8g8hggX9yj0gsrBg8hVgd/BkLhMmgg8hPgh/bkVhfj1g8hyf4+ekMg0owg8iEff/PkuiDbYg8iEff/PkuiDbYg8iEff/P
					kuiDbYg8iDfi/Zksh9cog8h9fu/jkghciRg8h1f++Lj+gsp0g8hwgL79jYgJvMg8hvgO7MjNgAwig8hvgO7MjNgAwig8hvgO7MjNgAwi]],
				["LowerLeg.R"] = [[
					hAhIf5tSfkgA9GhAhGf3sffef99chBhEf1rVfUf496hBhEf1rWfRf395hBhFf2r+fSf49qhBhbfTrOfXf098g/iSe106gGfx4Ng/iSe106gGfx4Ng/iSe106
					gGfx4Ng/iNe3z1f/fw5GhAh3fCv5fofs7whBhcfas+fbfy9PhAhMfys9fgf99PhAhIf5tSfkgA9GhAhIf5tSfkgA9GhAhIf5tSfkgA9G]],
				["Foot.R"] = [[
					g/gmgX81gAgAt3g/gmgX81f6gDt3g/gmgX81fwgIt3g/gmgX81ftgJt3g/gmgX81fvgIt3g/g9f1+ufvgFo5g/hle7/XgQgDZvg/hle7/XgQgDZvg/hle7/X
					gQgDZvg/hgfB/pgLgCbSg/hQfZ/7f5gAiGg/g6f5+gfzgEpog/gqgR9Jf8gCtMg/gmgX81gAgAt3g/gmgX81gAgAt3g/gmgX81gAgAt3]],
				["Toe.R"] = [[
					g/gUgJ/8gAgAhtg/gUgJ/8f7gFhtg/gUgJ/8f0gNhtg/gUgJ/8fygQhtg/gUgJ/8fzgOhtg/gxfi/yfygLcag/hten6jgQf9OKg/hten6jgQf9OKg/hten6j
					gQf9OKg/hnes7ZgLf9Pfg/hNfE+Rf5gDVqg/gufn/3f2gJdLg/gZgC/+f9gDg+g/gUgJ/8gAgAhtg/gUgJ/8gAgAhtg/gUgJ/8gAgAht]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAimgjAHgAgAicgAiigjAFgAgAiCgAibgjACgAgAhGgAiVgjABgAgAgVgAiWgjABgAgAgegAikgjAJgAgAi2gAisgjAZgAgAk4gAitgjAcgAgAlNgAitgjAc
					gAgAlNgAitgjAcgAgAlNgAitgjAcgAgAlNgAitgjAcgAgAlNgAitgjAcgAgAlNgAitgjAcgAgAlNgAitgjAcgAgAlNgAitgjAcgAgAlNgAitgjAcgAgAlNgA
					itgjAcgAgAlKgAiqgjATgAgAkMgAingjAJgAgAi4gAimgjAHgAgAicgAimgjAHgAgAicgAimgjAHgAgAic]],
				Spine1 = [[
					gAipgNAvgAgAmugAilgNAngAgAmKgAicgNAZgAgAk5gAiVgNAQgAgAj3gAiWgNARgAgAkDgAiogNA3gAgAnSgAizgOBogAgAqCgAi0gOBygAgAqfgAi0gOBy
					gAgAqfgAi0gOBygAgAqfgAi0gOBygAgAqfgAi0gOBygAgAqfgAi0gOBygAgAqfgAi0gOBygAgAqfgAi0gOBygAgAqfgAi0gOBygAgAqfgAi0gOBygAgAqfgA
					i0gOBwgAgAqagAiwgOBWgAgApHgAirgNA3gAgAnVgAipgNAvgAgAmugAipgNAvgAgAmugAipgNAvgAgAmu]],
				Spine2 = [[
					gAi8flB3gAgAqtgAi2fkBogAgAqBgAiqfiBKgAgAocgAigfiA1gAgAnKgAihfiA4gAgAnYgAi7flCHgAgAragAjNfqDngAgAuwgAjQfrD6gAgAvSgAjQfrD6
					gAgAvSgAjQfrD6gAgAvSgAjQfrD6gAgAvSgAjQfrD6gAgAvSgAjQfrD6gAgAvSgAjQfrD6gAgAvSgAjQfrD6gAgAvSgAjQfrD6gAgAvSgAjQfrD6gAgAvSgA
					jPfrD3gAgAvMgAjIfoDEgAgAtogAi/flCIgAgArcgAi8flB3gAgAqtgAi8flB3gAgAqtgAi8flB3gAgAqt]],
				Neck1 = [[
					gAjKfSEegAgAwSgAjEfRDtgAgAu7gAi2fOCPgAgArugAiqfMBUgAgApCgAisfNBegAgAphgAjLfUE4gAgAw9gAjhfdI6gAgA2IgAjjfeJogAgA22gAjjfeJo
					gAgA22gAjjfeJogAgA22gAjjfeJogAgA22gAjjfeJogAgA22gAjjfeJogAgA22gAjjfeJogAgA22gAjjfeJogAgA22gAjjfeJogAgA22gAjjfeJogAgA22gA
					jjfeJggAgA2vgAjbfZHhgAgA0lgAjPfUFKgAgAxagAjKfSEegAgAwSgAjKfSEegAgAwSgAjKfSEegAgAwS]],
				Neck2 = [[
					gAj4e5LDgAgA4KgAjvezJhgAgA2wgAjZeoGcgAgAzOgAjGegEVgAgAwDgAjKeiEsgAgAwpgAj6e9L3gAgA42gAkVfaTUgAgA9XgAkYffUlgAgA94gAkYffUl
					gAgA94gAkYffUlgAgA94gAkYffUlgAgA94gAkYffUlgAgA94gAkYffUlgAgA94gAkYffUlgAgA94gAkYffUlgAgA94gAkYffUlgAgA94gAkYffUlgAgA94gA
					kXffUXgAgA9zgAkOfQQ1gAgA8KgAj+e+MagAgA5SgAj4e5LDgAgA4KgAj4e5LDgAgA4KgAj4e5LDgAgA4K]],
				Head = [[
					gAkofAAEgAgAhpgAkge0ADgAgAeogAkIeaBDgAgAX7gAjweIC6gAgASugAj1eLCggAgATogAkqfHANgAfpjYgAk4f8EJgYfKvrgAk4gEEWfOhxv8gAk4gEFC
					gQfhxMgAk4gEFWgsesxngAk4gEEYfRhowCgAk4gEE3gAgAw7gAk4gEFdg1ecxwgAk4gEEdfZhWwMgAk4gEEtfxggwqgAk4gEFhg6eTx0gAk4gEEkfjg9wZgA
					k4gCEZflg8wIgAk3frCegWe1sPgAktfLASgAgGkIgAkofAAEgAgAhpgAkofAAEgAgAhpgAkofAAEgAgAhp]],
				Jaw = [[
					gAkqd3/8gAgAhpgAkUds/mgAgAk9gAjfdd9lgAgAsKgAi2dd6wgAgAxigAi9dc7VgAgAwogCk0d+/of6gWkzgEl0fR/8fSgmeqf3l0fa/7hke3f9gDl4fg/9
					fjgTeigHl5fi/5ewgzeAf4l0fb/8hce9f3gAl3fe/+gAgAe2gIl5fj/3egg9d2f5l1fb/9hNfJfsf9l2fd/+gdfsfKgJl5fj/2eXhCdwf7l2fc/+g3fZfdf7
					l1fa/+g1fZfggGlme0/9fQg+fMgAk7eC/9gBf7hQgAkqd3/8gAgAhpgAkqd3/8gAgAhpgAkqd3/8gAgAhp]],
				Ring = [[
					gAmOhCAQgAgAj6gAmcghADe5gQg6gAmnfKApd7g9aKgAmWeACNdMh8U5gAmaeNCBcLieV3f9mBhUBAaUgClef4kOicF0Z5c5xDgQkLiiGpX8fExuf8j8ieHR
					X4cEyKf0j4icHrXUasyGgOkKiiHmU9duxVgAj/ifIGUqbbxYfyj2ibInUhZLxPgMkIiiI1SJcPwvgEkDigJTRka3wgfwj2iaJwRyX3wIgJkGihKSPiarv4gI
					kJihKqOnaevUf2k0iQIyNha5qzgBl+hbHnL9g9lBgAmOhCIBLOiki9gAmOhCIxKYiqi3gAmOhCJjJjixix]],
				["UpperArm.L"] = [[
					fLjGfA0UNZgAwQfLi/e/0eNZf0wDfLive900NZfavmfLihe81GNafFvOfLike81DNafIvSfLjHfB1dMTZvrofLjhfK0vOgP+lhfLjlfL0SPuN4kRfLjlfL0S
					PuN4kRfLjlfL0SPuN4kRfLjlfL0SPuN4kRfLjlfL0SPuN4kRfLjlfL0SPuN4kRfLjlfL0SPuN4kRfLjlfL0SPuN4kRfLjlfL0SPuN4kRfLjlfL0SPuN4kRfL
					jkfL0YPgOOkefLjafG1TM1UeoRfLjLfB07MndRuNfLjGfA0UNZgAwQfLjGfA0UNZgAwQfLjGfA0UNZgAwQ]],
				["LowerArm.L"] = [[
					eyiqerJbJbgAhveyikeqJcJbfyh9eyiUemJfJbfSideyiIekJiJce4i2eyiKelJhJde8izeti9elI4M+ZMo7eojve3MMWeSDykenj2e+NkZHRK0Yenj2e+Nk
					ZHRK0Yenj2e+NkZHRK0Yenj2e+NkZHRK0Yenj2e+NkZHRK0Yenj2e+NkZHRK0Yenj2e+NkZHRK0Yenj2e+NkZHRK0Yenj2e+NkZHRK0Yenj2e+NkZHRK0Yen
					j1e9NVYqRS0GeqjdetKBRmUyuXewi3eoI1Kwczk9eyiqerJbJbgAhveyiqerJbJbgAhveyiqerJbJbgAhv]],
				["UpperArm.R"] = [[
					g1jGfA0UyngAwQg1i/e/0eyngMwDg1ive900yngmvmg1ihe81Gymg7vOg1ike81Dymg4vSg1jHfB1dztmRrog1jhfK0vxgwClhg1jlfL0SwSyIkRg1jlfL0S
					wSyIkRg1jlfL0SwSyIkRg1jlfL0SwSyIkRg1jlfL0SwSyIkRg1jlfL0SwSyIkRg1jlfL0SwSyIkRg1jlfL0SwSyIkRg1jlfL0SwSyIkRg1jlfL0SwSyIkRg1
					jkfL0Ywgxykeg1jafG1TzLrioRg1jLfB07zZivuNg1jGfA0UyngAwQg1jGfA0UyngAwQg1jGfA0UyngAwQ]],
				["LowerArm.R"] = [[
					hOiqerJb2lgAhvhOikeqJc2lgOh9hOiUemJf2lguidhOiIekJi2khIi2hOiKelJh2jhEizhTi9elI4zCm0o7hYjve3MMpit9ykhZj2e+Nkm5u20YhZj2e+Nk
					m5u20YhZj2e+Nkm5u20YhZj2e+Nkm5u20YhZj2e+Nkm5u20YhZj2e+Nkm5u20YhZj2e+Nkm5u20YhZj2e+Nkm5u20YhZj2e+Nkm5u20YhZj2e+Nkm5u20YhZ
					j1e9NVnWuu0GhWjdetKBuarOuXhQi3eoI11QjNk9hOiqerJb2lgAhvhOiqerJb2lgAhvhOiqerJb2lgAhv]],
				Tail1 = [[
					gAimhDfZgAgA//gAijhDfOgAgA/+gAidhDe2gAgA/+gAiZhDejgAgA/9gAiZhDemgAgA/9gAijhDfcf0gA//gAinhDgFfif///gAinhCgLhAgD/+gAinhCgL
					fuf///gAinhCgLfPf+/+gAinhCgLg6gD/+gAinhCgLgAgA//gAinhCgLfGf9/+gAinhCgLgxgC/+gAinhCgLgSgB//gAinhCgLfAf9/+gAinhCgLgjgC//gA
					inhDgKgigB//gAinhDf5fYf///gAimhDfhgDgA//gAimhDfZgAgA//gAimhDfZgAgA//gAimhDfZgAgA//]],
				Tail2 = [[
					gAioiBeHgAgA/7gAimiBeNgAgA/8gAiiiBeZgAgA/8gAieiBeigAgA/9gAifiBehgAgA/9f/iliBd0f4f//6f+iniBdDerf6/0gEiniBc5hngK/zf/iniBc5
					gLf+/1f9iniBc5eQf4/ygEiniBc5hSgJ/0gAiniBc5gsgB/1f8iniBc5eJf2/ygDiniBc5g3gH/1gBiniBc5hJgE/0f8iniBc5eMf2/ygCiniBc5gXgF/1gC
					iniBc7hfgG/zf+iniBdWe/f7/3gAioiBd7f+gA/7gAioiBeHgAgA/7gAioiBeHgAgA/7gAioiBeHgAgA/7]],
				Tail3 = [[
					gAiwjAdJgAgA/3gAitjAdfgAgA/5gAioi/ePgAgA/8gAiki/e2gAgA/+gAili/evgAgA/9f/iui/cggKgA/zf5iyi+aWd7fz/agKizi+Z9hhgU/YgAizi+Z9
					hIf+/Zf2izi+Z9dkfu/UgJizi+Z9g6gR/ZgDizi+Z9hsgE/Xf1izi+Z9dsfs/VgGizi+Z9gPgN/agGizi+Z9iHgK/Vf1izi+Z9eBfr/WgDizi+Z9figI/agI
					izi+aBiVgO/Vf6iyi/bIfDf2/mgAiwi/cpf1f//0gAiwjAdJgAgA/3gAiwjAdJgAgA/3gAiwjAdJgAgA/3]],
				Tail4 = [[
					gAi7j9cQgAgA/xgAi3j9c1gAgA/1gAivj+eJgAgA/8gAipj+fNgAgA/+gAiqj+fBgAgA/+f/i7j8bQgfgC/ofxjIj4Xwdrfp+0gQjKj4XIgvgf+ugEjKj4XI
					iCgC+qftjKj3XJdlfg+ogMjKj4XIf+gZ+vgJjKj4XJicgM+pftjKj3XJeAfe+qgHjKj4XIfOgR+ugOjKj4XJiqgU+nfujKj3XIelfe+sgCjKj4XIeigI+sgR
					jKj4XPimgb+pf2jEj6ZAfhfy/Nf/i9j9bcfsf+/qgAi7j9cQgAgA/xgAi7j9cQgAgA/xgAi7j9cQgAgA/x]],
				Tail5 = [[
					gAjJk6a7gAgA/lgAjDk7bwgAgA/tgAi2k8dogAgA/5gAisk8fJgAgA/+gAiuk8e3gAgA/+gBjOk4ZmgtgG/VfpjnkuUzeGfZ95gSjrktT/frgo9pgMjrktT/
					ibgO9jfljrkrT/eUfN9lgLjrktT/e/gd9ogSjrksT/iigb9ifmjrksT/e6fN9ngEjrktT/eXgP9mgXjrksT/icgn9ifpjrksT/fnfR9of8jrktT/d5gB9kga
					jrksUIiHgt9nf0jfkzWfgLfx+if+jPk5Z0fof8/YgAjJk6a7gAgA/lgAjJk6a7gAgA/lgAjJk6a7gAgA/l]],
				["UpperLeg.L"] = [[
					fEhvgO7MczgAwifEhrgP75cmf3vSfEhigS9KcLflskfEhbgV9+b3fXqYfEhcgV91b7fZqxfEhtgM7Pcyf+wefEh5gG31dogg1NfEh6gF3Cdzgn2FfEh6gF3C
					dzgn2FfEh6gF3Cdzgn2FfEh6gF3Cdzgn2FfEh6gF3Cdzgn2FfEh6gF3Cdzgn2FfEh6gF3Cdzgn2FfEh6gF3Cdzgn2FfEh6gF3Cdzgn2FfEh6gF3Cdzgn2FfE
					h6gF3Ldxgm17fEh2gI5DdWgWzufEhxgM6vc7gFxSfEhvgO7MczgAwifEhvgO7MczgAwifEhvgO7MczgAwi]],
				["LowerLeg.L"] = [[
					fAhIf5tSgcgA9GfAhGf3sZghgD9fe/hDf0q1gpgI+Ge/hAfyp8grgJ+Ze/hBfyqEgrgJ+WfAhHf4smgfgA9ZfBhNgAwCgGfw7rfBhOgCwygAfs7OfBhOgCwy
					gAfs7OfBhOgCwygAfs7OfBhOgCwygAfs7OfBhOgCwygAfs7OfBhOgCwygAfs7OfBhOgCwygAfs7OfBhOgCwygAfs7OfBhOgCwygAfs7OfBhOgCwygAfs7OfB
					hOgCwpgCft7UfBhLf9u7gPf18TfAhJf6tlgaf+89fAhIf5tSgcgA9GfAhIf5tSgcgA9GfAhIf5tSgcgA9G]],
				["Foot.L"] = [[
					fBgmgX81gAgAt3fBgmgX81gFf+t3fBgmgX81gNf6t3fBgmgX81gQf4t3fBgmgX81gQf5t3fBgmgX81gCf/t3fBgmgX81fpgLt3fBgmgX81fjgOt3fBgmgX81
					fjgOt3fBgmgX81fjgOt3fBgmgX81fjgOt3fBgmgX81fjgOt3fBgmgX81fjgOt3fBgmgX81fjgOt3fBgmgX81fjgOt3fBgmgX81fjgOt3fBgmgX81fjgOt3fB
					gmgX81fkgOt3fBgmgX81fxgHt3fBgmgX81f9gBt3fBgmgX81gAgAt3fBgmgX81gAgAt3fBgmgX81gAgAt3]],
				["Toe.L"] = [[
					fBgUgJ/8gAgAhtfBgUgJ/8gEf8htfBgUgJ/8gKf1htfBgUgJ/8gMfzhtfBgUgJ/8gLfzhtfBgUgJ/8gCf+htfBgUgJ/8fvgThtfBgUgJ/8fqgYhtfBgUgJ/8
					fqgYhtfBgUgJ/8fqgYhtfBgUgJ/8fqgYhtfBgUgJ/8fqgYhtfBgUgJ/8fqgYhtfBgUgJ/8fqgYhtfBgUgJ/8fqgYhtfBgUgJ/8fqgYhtfBgUgJ/8fqgYhtfB
					gUgJ/8frgXhtfBgUgJ/8f1gMhtfBgUgJ/8f+gChtfBgUgJ/8gAgAhtfBgUgJ/8gAgAhtfBgUgJ/8gAgAht]],
				["UpperLeg.R"] = [[
					g8hvgO7MjNgAwig8hrgP75jagJvSg8higS9Kj1gbskg8hbgV9+kJgpqYg8hcgV91kFgnqxg8htgM7PjOgCweg8h5gG31iYfg1Ng8h6gF3CiNfZ2Fg8h6gF3C
					iNfZ2Fg8h6gF3CiNfZ2Fg8h6gF3CiNfZ2Fg8h6gF3CiNfZ2Fg8h6gF3CiNfZ2Fg8h6gF3CiNfZ2Fg8h6gF3CiNfZ2Fg8h6gF3CiNfZ2Fg8h6gF3CiNfZ2Fg8
					h6gF3LiPfa17g8h2gI5Diqfqzug8hxgM6vjFf7xSg8hvgO7MjNgAwig8hvgO7MjNgAwig8hvgO7MjNgAwi]],
				["LowerLeg.R"] = [[
					hAhIf5tSfkgA9GhAhGf3sZfff99fhBhDf0q1fXf4+GhBhAfyp8fVf3+ZhBhBfyqEfVf3+WhAhHf4smfhgA9Zg/hNgAwCf6gQ7rg/hOgCwygAgU7Og/hOgCwy
					gAgU7Og/hOgCwygAgU7Og/hOgCwygAgU7Og/hOgCwygAgU7Og/hOgCwygAgU7Og/hOgCwygAgU7Og/hOgCwygAgU7Og/hOgCwygAgU7Og/hOgCwygAgU7Og/
					hOgCwpf+gT7Ug/hLf9u7fxgL8ThAhJf6tlfmgC89hAhIf5tSfkgA9GhAhIf5tSfkgA9GhAhIf5tSfkgA9G]],
				["Foot.R"] = [[
					g/gmgX81gAgAt3g/gmgX81f7gCt3g/gmgX81fzgGt3g/gmgX81fwgIt3g/gmgX81fwgHt3g/gmgX81f+gBt3g/gmgX81gXf1t3g/gmgX81gdfyt3g/gmgX81
					gdfyt3g/gmgX81gdfyt3g/gmgX81gdfyt3g/gmgX81gdfyt3g/gmgX81gdfyt3g/gmgX81gdfyt3g/gmgX81gdfyt3g/gmgX81gdfyt3g/gmgX81gdfyt3g/
					gmgX81gcfyt3g/gmgX81gPf5t3g/gmgX81gDf/t3g/gmgX81gAgAt3g/gmgX81gAgAt3g/gmgX81gAgAt3]],
				["Toe.R"] = [[
					g/gUgJ/8gAgAhtg/gUgJ/8f8gEhtg/gUgJ/8f2gLhtg/gUgJ/8f0gNhtg/gUgJ/8f1gNhtg/gUgJ/8f+gChtg/gUgJ/8gRfthtg/gUgJ/8gWfohtg/gUgJ/8
					gWfohtg/gUgJ/8gWfohtg/gUgJ/8gWfohtg/gUgJ/8gWfohtg/gUgJ/8gWfohtg/gUgJ/8gWfohtg/gUgJ/8gWfohtg/gUgJ/8gWfohtg/gUgJ/8gWfohtg/
					gUgJ/8gVfphtg/gUgJ/8gLf0htg/gUgJ/8gCf+htg/gUgJ/8gAgAhtg/gUgJ/8gAgAhtg/gUgJ/8gAgAht]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAimgjAHgAgAicgAijgjAGgEgriOgAiNgjAEgNhlgxgAjBgjAOgFhmjNgAjtgjAYgAg/kugAj8gjAcgAgAlNgAjtgjAYgAfBkugAjBgjAOf7eajNgAiNgjAE
					fzebgwgAiWgjAEf5fBhbgAiUgjADgAgAhPgAjWgjASgCg/j/gAj2gjAdf/hmlCgAj5gjAef/hmlIgAjfgjAUgBg/kRgAikgjAFgAgAh+gAiUgjADf5fBhPgA
					ilgjAJf4eaiagAimgjAIf6e0icgAimgjAHf/fwicgAimgjAHgAgAic]],
				Spine1 = [[
					gAipgNAvgAgAmuf/imgNArgJgrmaf+iOgNAWgYhjkPf+jGgNA/gUhknpf/jzgOBggKg+pngAkDgOBsgAgAqOgBjzgOBgf2fCpngCjGgNA/fsecnpgCiOgNAW
					foedkPgBiZgNAdfyfDlOgAiVgNAagAgAk8f/jcgOBPgLg+orf+j9gOBqgQhlp/f+kAgOBtgPhlqHf/jlgOBVgLg+pCgAingNAlgAgAl+gBiVgNAbfyfDk8gC
					ipgNAxfrecmrgCipgNAwfwe1mugAipgNAvf9fxmugAipgNAvgAgAmu]],
				Spine2 = [[
					gAi8flB3gAgAqtf9i3fkBugPgpqSf6iafiA8gihgnff6jafmCTghhgrxf8kNfpDTgTg8uFgAkefrDpgAgAuzgEkNfpDTftfEuFgGjafmCTffegrxgGiZfiA8
					feegnegEinfjBQfrfFowgAijfjBJgAgAoZf8jzfoCzgUg8tAf6kYfqDjgfhhuhf6kbfrDngfhhuqf8j9foC/gUg8tbgAi3fkBhgAgApsgEijfjBKfrfFoZgG
					i7flB4feegqogFi8flB4fme4qsgBi8flB3f7fxqtgAi8flB3gAgAqt]],
				Neck1 = [[
					gAjKfSEegAgAwSf9jGfREHgWgmvpf4ikfNCGguhbrPf4jqfVFfg1hXx0f7kffbH/gig11GgAkxfdI1gAgA2EgFkffbH/fefL1GgIjqfVFffLepx0gIikfNCG
					fSelrNgFizfPC6fifItQgAivfOCpgAgAssf7kFfYGvgig1zmf4krfdIjg4hV1sf4kufdIug4hV14f7kPfZHOgig10MgAjFfQDmgAgAutgFivfOCqfjfIssgI
					jKfSEdfMeowLgGjKfSEffZe+wRgBjKfSEef4fywSgAjKfSEegAgAwS]],
				Neck2 = [[
					gAj4e5LDgAgA4Kf7jye2Kgghgd3rf0jHemHNhIhI0If2kbfBMghOhC5Tf6lTfUP6gxgn7ogAlmfbRBgAgA8QgGlTfUP6fPfZ7ogKkbfBMgeye+5TgMjGemHL
					e4e40HgHjbetInfSfV1zgAjVeqILgAgA1Wf6k3fLOQgxgo6mf3lffZQohQg/8Af3lifaQ2hQg/8If6lCfPO5gxgo7AgAjweyJugAgA28gHjVerIMfTfU1VgL
					j3e5LAeze94EgIj4e5LEfGfO4JgCj4e5LDf0f24KgAj4e5LDgAgA4K]],
				Head = [[
					gAkofAAEgAgAhpf8kje7AKeeguiff0j2ecAVcbiKegf3lKfOAxchhSl1f7l9fsBnd7ggpvgAmOf2B8gAgAq6gFl9fsBniFfgpvgJlKfOAxjfeul1gMj2ecAV
					jld2eegHkLepAIiNe0gjgAkFelABgAgAf2f7lkfeBFd4gpn3f5mIfzCAcqguqkf5mLf1CGcrgsq0f7lufjBRd5gmomgAkge0AFgAgAiFgHkFelAHiOeyf7gK
					kofAAfjhefj7gHkofAAViqe0jagCkofAAGgkfviNgAkofAAEgAgAhp]],
				Jaw = [[
					gAkqd3/8gAgAhpf4kody/RhrfvmhfsjpdV9EkHfRstfvleeI/QjugDlsf3mjet/3iIgShvgAm4e6//gAgAghgJmjet/3d4fuhvgRleeI/QcSf9lsgUjodU9D
					b5gvsugMkIdg9/dhgUq3gAj/dc91gAgArjf2mCeb/siOgKjrfymwe2/zjYgig0fym1e5/zjXgjgkf3mPei/yiMgNi7gAkkdq+kgAgApcgMj/dc9xdggXrcgS
					kzd4+2cLgKnkgNkyd4/RdHgWmFgDktd3/1fagLjLgAkqd3/8gAgAhp]],
				Ring = [[
					gAmOhCAQgAgAj6f3mBhDApcDhEkxfolzgJBTXyjeg+fumJhnC+VThan+f3mViQEfUSfSrVgAmZibFBT9d4sCgJmViQEpTeddqhgSmJhnD5STehmggYlygJEE
					QliKfsgOl5glGTNKiOhogAl5gbJcJwkBhgf2mPh9OAGdesmufxmWiXRnEscVnjfxmWiaTtDlb0m1f2mSiFUTCxdilFgAmCg5T4CojOhqgOl4gcT5Czk5f5gT
					l4hQVHB9hJglgPl/hNYUBBh5gMgDmKhGc7AWjUgMgAmOhCgAAQj6gA]],
				["UpperArm.L"] = [[
					fLjGfA0UNZgAwQfHjBfCz0LpXbr7fCidfCzIM0RspNfCjnfI0nSgLqhhfFkffL0xQEOKkWfLkyfK0HM2SNnzfRkffF1sPpPajOfVjne92dSUNzgFfWibe30o
					MMTxnbfSise6ydKIW8rDfLioe90JM4SJnvfFkDfI0/TRLggXfCkqfP0iQfNikYfCkufQzjNXRYo7fFkNfK0rPrOik1fLi/e+1dRGNsiTfSine60mMtSynLfW
					jFe7zWKlWApgfTjGe81kMYVXnxfNjGe/1OMXcQtKfLjGfA0UNZgAwQ]],
				["LowerArm.L"] = [[
					eyiqerJbJbgAhveli7epIOQFXSrUecilevHCSYaQtcedj7fAKqRNbKyCehkve9KjT6W3yQeok7e1KwVPSdwgevkweyLDTAVaxZezj8euLLPlY+wce0ijeeH3
					Q2X+sFewisehIPSVUNrfeoixenHzRzYrtfehkYfBLeRJaGymedk7fCKtUWXHy1eck2e9KJV1TtxDehkde6KJTsXJxweojSewJwQAbJvweviweiIERWX+tEe0
					jIegJRSyS+stezjJegIZPUYBrHexi1ekIPK+ePjqeyiqerJbJbgAhv]],
				["UpperArm.R"] = [[
					g1jGfA0UyngAwQgwjAe92Nynrxmugqibe30pzzsQnagrjne9zt1AqzoygvkffF1swXwmjOg1kyfK1hri0nekg7kffL0xv8x2kWg+jnfIypz7sqq4g+icfCzH
					zMuTpOg7itfB0yvaygjYg1ioe90JzIt3nvgvkDfCz60UsAoYgrksfF2AwNwciigrkwfF2aruzed6gvkOfD1mwvwOjtg1i/e+ye1QqTrJg7iofAzqy7ufoSg+
					jFfG0juPz0iVg8jGfE0ty/sOpNg2jGfB0yzijjuCg1jGfA0UyngAwQ]],
				["LowerArm.R"] = [[
					hOiqerJb2lgAhvhRjGeiH4yKkUpohMijeeH3vJoDsFhMjsejJxsvthtkhRkweyLDtAqmxZhYlIfDMyu7nizWhfkve9KjsGpJyQhkjre0ImrcrLu1hkikevHB
					tolvtbhfi/ezJIvojsvjhYixenHzuNnVtfhRkKepKJr+tkuwhMk9exLftHrPxchNlHe7M+vuolydhRkeewKptOqUw6hYjAenIPs7rfsmhgixetHjtumnt6hj
					jZe8KBvAkRxOhgjJetH4v0mNsVhTizeoIp0pj9mChOiqerJb2lgAhv]],
				Tail1 = [[
					gAimhDfZgAgA//gBijhDfWjrgC/xgDiQhDfFmofg/SgDjAhDfZjPgO/0gCjohDffd3fq/6gAj2hCfhaxe//if+johDffb8fW/uf9jAhDfZgEgA//f9iQhDfE
					jffv/yf+iZhDfMjWf4/zgAiWhDfKgAgA/+gCjThDfdcrfo/zgDjxhCfgckfY/ygDj0hCfgf8f///gCjbhDfekGgj/ugAilhDfQlVf+/if+iWhDfKiKf5/6f9
					ilhDfZcwf8/0f+imhDfZbAf6/mgAimhDfZerf+/9gAimhDfZgAgA//]],
				Tail2 = [[
					gAioiBeHgAgA/7gQimiAeRlJgP/hgciTh8fRrofi9ygQjCiAdZnJgw/Ef6jqiBcBdYfX/ofsj5h+bpWfdt+Jfujqh/cFXReS+ef9jCiBdWe8f6/3gKiTiAfL
					nAfw/NgLiciAezolgE+zgAiZiBe2isgE/2f1jViActamfH/Wf2jzh/bzXkeR+hgDj2iBbrcAfa/cgSjdh/cdkjg//cgVioh+eZp1gV+ZgGiZiBe5nBgB/Mfw
					ioiAeJd5f4/3fqioh+eLYZfj/Bf6ioiBeIdWf2/0gAioiBeHgAgA/7]],
				Tail3 = [[
					gAiwjAdKgAgA/3gjisi7dfkugU/ihHiViqf1vNft8JgrjNi3b1sEhl9Sfwj6i8Y7frfU/MfKkLivYRUVcb8ifPj7iyZOSidB8Df5jMi/bpbWfi/WgliWi4fl
					oCfw+9grigi1e0tJgg9JgKiei/e5nSgc/Ifhjji5aTbSew/GfXkFizYmUGdD8mf0kHi7YXW+eg9rgjjsi6ZziQhL/Sg5iuiwd3sSgv9dghiei5fCsEgc9mfo
					ivi+dMhggJ/1fOiwi1dQXpfQ+vfwiwi+dLcJfq/ogAiwjAdJgAgA/3]],
				Tail4 = [[
					gAi7j9cQgAgA/xg1i2j2cviigK/uh7iVjMgXwkft7XhVjejialweim6wfvkVj1WHkGfh+JelksjVVIU3bK7hejkXjVWuPJbn5Lfnjdj4aMWbe198hEiYjvf8
					mYfZ/Whailjfe8v3g77vgmijj3fHsVhJ9ffQj5jxYCekeo+6ewkjjaVpTBbw7AfUkkjpVeSedY64gqkEjzXYdyhE+thli3jcdVsNg99bhNiijmfVv5g/7vfu
					i6j7camigy/Geui7jqcWY6fK++fhi7j6cTbZfd/bgAi7j9cQgAgA/x]],
				Tail5 = [[
					gAjJk6a8gAgA/lg/jDkybjfLfs/qiziTjpgNvjfd79iJj1j8ZIzKj94Xf/k5klTVpVgI72eGlXj2R4YJZy65d0k9jmUIOAZz2zfFj0knYnRuds7jhciXkofr
					ifef/2iQirj+eiwQhR7fhSinkjfEwUiL7afMkXkoVljme4+AeLlMj2SeUuaO6EerlLkDSlPzb03vghkkkoU4Ycgh9BiRjCkHcNpng5+QiDimkFfNxnhk6pgG
					jIkzbXrbh29deUjJkha+b5fW/UfQjJk0a/bTfQ/PgAjJk6a7gAgA/l]],
				["UpperLeg.L"] = [[
					fEhvgO7MczgAwifEhrgR8FdAfRvAfDhUga+ucZddnwfDiLgR7Ed/ezw4fDi5gK+eeQgMpjfEjJgF+FdUgZqifGi6gD+CcLggqUfHiLgF5GcJhgzafHhTgO9g
					a6g+rPfGhegO84blgetCfEhbgS9ob9fbrVfDihgM4nePfz0XfDjCgL+de7gGptfDjGgL+be8gGp0fDiqgL+qeKgLo9fEhtgP8ocWfrtzfGhbgO9LbegbsUfH
					hugI6Vb4hXxofGhvgJ6gcIhCxdfFhvgN7EcqgOwufEhvgO7MczgAwi]],
				["LowerLeg.L"] = [[
					fAhIf5tSgcgA9Ge+hHf4s3hQf69Qe5hBfzqDiwgR+Pe9hkf+u9h+fd8NfCiffl+fhCfWpofDiufi+LfsflqnfEifff+MeSfyqafEhhf6thexgb89fEg2ftl1
					e0f2/bfCg9fwoqflgI+ze/g+fxpFgugG+qfAh2gExNg/fW68fCipfn+Zh1fMpxfCisfn+Xh0fMp4fCiSfm+qhDfWpCe/hKf0qqgpgF+KfCg8fvoCflgF+9fE
					hGf3sNezga9ifDhHf4slfNgT9ZfAhIf5tIgMgE9LfAhIf5tSgcgA9G]],
				["Foot.L"] = [[
					fBgmgX81gAgAt3fBgmgX80grfrt2fBgmgX8wiHe/t0fBg+gX8EhOfWvRfBiFfAyHiybs53fCiRe+x6fggP6ffCiDe8vSbdnU6wfBg+gX8EeogwvRfBgmgX8z
					eigtt2fBgmgX80fSgWt2fBgmgX81gSf3t3fBhNgX7ugXfzv9fBiOfCy9kGaZ40fBiRfCzFj/al4yfBh6fAxYjbaj6FfBgugX8kgMf6uZfBgmgX80fRgXt2fB
					gmgX8zeqgpt2fBgmgX80e/gft2fBgmgX81fygGt3fBgmgX81gAgAt3]],
				["Toe.L"] = [[
					fBgUgJ/8gAgAhtfBgUgJ/8ggfchtfBgUgJ/3hjeRhtfBgsgL/yg4e7jTfBhxfI6rg7a9w6fBh9fH6ufogaxkfBhwfH4Zenofy0fBgsgL/yfBhOjTfBgUgJ/5
					e6hOhtfBgUgJ/7fegmhtfBgUgJ/8gNfxhtfBg6gM/ugQfrkFfBh5fI7ChoZQvnfBh8fI7JhmZevifBhlfI6EhEZqxZfBgcgK/6gJf2iTfBgUgJ/7fdgnhtfB
					gUgJ/6fBhHhtfBgUgJ/7fQg2htfBgUgJ/8f2gLhtfBgUgJ/8gAgAht]],
				["UpperLeg.R"] = [[
					g8hvgO7MjNgAwig7hrgM7ajwfhwEg5hTgO9flGfCrRg5iLgF5Gj3egzag6i6gD+Cj1fgqUg8jJgF+Fisfnqig9i5gK+ehwf0pjg9iLgR7EiBhNw4g9hUga+u
					joijntg9hfgV9ujchgrOg8hbgS9okDglrVg6iigF+WkAfppRg5jEf/9ukafXq9g5jIf/9skZfWrEg6irgE+Oj7flptg8htgP8ojqgVtzg9hcgW9/jlhnqag9
					hugU8AiVhbvOg9hvgS7xihhDvqg8hvgP7UjEgOwWg8hvgO7MjNgAwi]],
				["LowerLeg.R"] = [[
					hAhIf5tSfkgA9Gg/hFf2r6gNf19sg8g2ftl3hMgJ/bg8hhf6thhPfl89g8ifff+MhugOqag9iufi+LgUgbqng+iffl+fe+gqpohDhkf+u9eCgj8NhHhBfzqC
					dQfv+QhEhCf0qpeLf7+HhBg+fxpFfSf6+qg8iJfg+hh4gSpYg8iofd96ihgErDg8irfd93ifgDrLg8iRfg+Zh0gQpzhBhKf0qqfXf7+KhEhBfzqMeHf4+RhE
					hKf8uOd3gY8khDhKf7uEeTgT8rhBhIf6tcfTgE9BhAhIf5tSfkgA9G]],
				["Foot.R"] = [[
					g/gmgX81gAgAt3g/gmgX81gifwt3g/gmgX8zhefTt2g/g+gX8EhYfQvRg+iDe8vSkjYs6wg+iRe+x6ggfx6fg/iFfAyHdOkU53g/g+gX8EeygqvRg/gmgX8w
					d5hBt0g/gmgX8zewgmt2g/gmgX81fugJt3g/hwe6rTosO429g+iLe7u1l4Wg6Dg+iNe7vLlnXL6Jg/h3e7tgmZUY5yg/gugX8kf0gGuZg/gmgX8zesgot2g/
					gmgX8zemgrt2g/gmgX80e+ggt2g/gmgX81fygHt3g/gmgX81gAgAt3]],
				["Toe.R"] = [[
					g/gUgJ/8gAgAhtg/gUgJ/8gZfkhtg/gUgJ/5hFeyhtg/gsgL/yg/eyjTg/hwfH4ZhZXhy0g/h9fH6ugYfmxkg/hxfI6rfFlDw6g/gsgL/yfIhFjTg/gUgJ/3
					edhwhtg/gUgJ/6fFhChtg/gUgJ/8fzgPhtg/hffIzQhcM3w2g/h4fG3thyU+yWg/h6fG4DhyVsyTg/hlfH2YhbS0yng/gcgK/6f3gKiTg/gUgJ/6fChFhtg/
					gUgJ/6e+hKhtg/gUgJ/7fPg3htg/gUgJ/8f2gLhtg/gUgJ/8gAgAht]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAimgjAHgAgAicgAimg4AVgAgAkdgAimhGAigAgAlwgAimhCAegAgFlagAimg7AYgAflkvgAimg0AVf9d/kAgAimgvAQf7eTjhgAimgtANf/frjagAimgqAK
					gBgOjEgAitglALh6f4ingAi1gjAxmefgiZgAivgjChsKfEiQgAiagjFFxGesiEgAiEgjHJz+eeh6gAiAgjHd0Xech4gAiLgjGgzJeih9gAiNgjGUy6ejh+gA
					iCgjHR0Jedh5gAh/gjHk0gech4gAh/gjHk0gech4gAh/gjHk0gech4gAh/gjHk0gech4gAh/gjHk0gech4]],
				Spine1 = [[
					gAipgNAvgAgAmugAisgjBOgAgAosgAiugxBmgAgAp8gAitgtBggBgFpngBisgmBTf8flo+gDirgeBKfreAoQgCirgZBBfteVnygAirgXA9f8fsnrgAiqgUA3
					gDgOnVgAiwgPA1h4fom4gBi4gNBYmWepmlgCiygNDGr7dcmOgDibgNFnwxcZlrgDiEgNHozlbzlPgDiBgNH8z+btlLgDiMgNG/yxb+lYgDiOgNG0yicBlagD
					iDgNHwzwbwlOgDh/gNID0GbrlKgDh/gNID0GbrlKgDh/gNID0GbrlKgDh/gNID0GbrlKgDh/gNID0GbrlK]],
				Spine2 = [[
					gAi8flB3gAgAqtgAjDf9CmgAgAsmgAjIgNDJgAgAtygAjHgIC/gBgFtegCjEgACuf5fms2gIjCf4CffbeEsKgHjAfyCSffeYrtgBi/fwCNf6fsrnf/i+fsCF
					gFgNrSgDjDfnB+h3fhq3gJjJflChmReSqlgPi/flERrycvqOgUijflG1wibWptgViIflI4zSagpTgViEflJMzpaYpOgViRflIPyfawpbgViTflIDyQa0pdgV
					iHflJAzcadpRgViCflJTzyaWpNgViCflJTzyaWpNgViCflJTzyaWpNgViCflJTzyaWpNgViCflJTzyaWpN]],
				Neck1 = [[
					gAjKfSEegAgAwSgAjUfsG9gAgAz6gAjbf+I0gAgA2CgAjZf5IUgDgE1fgCjWfwHWfyfp0YgKjSfnGbe9eRzGgJjQfhFyfIejyQgCjPffFmf1fuyDf/jOfaFL
					gIgMxbgEjSfUEnhle7wagOjXfSErlYcbvTgZjKfSFyqNZhtwggirfSHlueXPr2gjiNfSJFxAWCqcgkiJfSJUxWV5qPgjiXfSImwRWYq4giiZfSIewDWeq/gj
					iLfSJLxJV+qXgkiHfSJZxeV1qKgkiHfSJZxeV1qKgkiHfSJZxeV1qKgkiHfSJZxeV1qKgkiHfSJZxeV1qK]],
				Neck2 = [[
					gAj4e5LDgAgA4KgAkHfhOkgAgA60gAkPf7Q/gAgA8QgAkNf0QVgEgD75gDkJfmPFfrfu7JgNkEfYNyedes6OgLkBfPM7ete55ngCkAfMMrfwfz5ff/j9fFMF
					gLgJ5BgKkAe8LNg/eV4OggkAe3K0jWaZ3Dg5joe2LFmeVv07hIi7e0LvpYSAyIhNiVezMXrLQAwBhNiOezMerbPvvthMihe0MKqpQkwrhLike0MHqfQvw3hN
					iSezMarSP5v5hNiMezMgrhPqvmhNiMezMgrhPqvmhNiMezMgrhPqvmhNiMezMgrhPqvmhNiMezMgrhPqvm]],
				Head = [[
					gAkofAAEgAgAhpgAk0f0BNgAgAopgAk3gWCwgAgAs8gAk2gNCSf7gDr0gCk1f8BggdfspmgLkyfpA+iQeUnQgKkvfcAmh8edligCkvfZAbgYftlBf/ktfQAQ
					fwgOj0gPkvfDAIh3fOhygzkse8AvmSdlfrhakMe5CmrncJdKhzjSe1FPwAbpaah8ihezHTybbxYkh8iaezHnyvb0YUh6ixe0GqxvbsZHh5i1e0GexibrZRh8
					ieezHbykbyYdh9iXezHuy2b1YOh9iXezHuy2b1YOh9iXezHuy2b1YOh9iXezHuy2b1YOh9iXezHuy2b1YO]],
				Jaw = [[
					gAkqd3/8gAgAhpgAlVez//gAgAfngAlpfh/8gAgAeUf/llfU/9gGf/eqgElae8/+fegLfUgUlMem/3dbhJf6gSlDeW/5dzhKgcgDlAeR/+flgPgrf+k5eH/+
					gSf1hBgTkyd6/1eEgiidg7kjd0+1ZbhalRhij1dz8LT2hWo7hyiwd04dPagJsQhyh7d21kNJe0uKhxhzd21IM2emuahziLd12dNxfQtnhziQd12tN9fXtdhx
					h3d21ZNBeuuRhxhwd20/Mwehughxhwd20/Mwehughxhwd20/Mwehughxhwd20/Mwehughxhwd20/Mwehug]],
				Ring = [[
					gAmOhCAQgAgAj6gAlYiWB5gAgAq0gAksi7DvgAgAu/gAk4izDMf7gEt6gBlPifCQgcfqrvgIlkiHBkiIeKpcgIlzh0BEh1eVnwgCl3huA2gWfrnQf/mAhfAm
					fxgPmDgWmUhHAVhzfGkChOmcgzAymGdJh6iWl8giCdrUbVfQjSk3gPE6vqagcUjwj5gCG1yFaeaWj0jvgAHIyZafaEjokNgGGPxZaca8jmkSgHGExMacbGjy
					j1gBG9yNaeaOj1jrf/HOygagZ9j1jrf/HOygagZ9j1jrf/HOygagZ9j1jrf/HOygagZ9j1jrf/HOygagZ9]],
				["UpperArm.L"] = [[
					fLjGfA0UNZgAwQfLjSfa3FNvcYr/fLjafr4aOWaIpAfLjYfm4FOMaqp2fOjUfc3bNqcLrHfYjQfO2kMrehrxfWjNfI16MsfKtBfNjMfL1vNUeeuGfKjKfI1P
					NhevvJfPjUfDzPMifQwifbjofCvlK/eKyVfwjtfDrIKEbmz9gFjafEnNKOYh0/gTjBfFk7KxWR1TgVi9fGknK4V71UgPjKfFllKlW91PgOjMfFlxKhXJ1NgU
					jAfFkzK0WI1TgWi8fGkgK6V01UgWi8fGkgK6V01UgWi8fGkgK6V01UgWi8fGkgK6V01UgWi8fGkgK6V01U]],
				["LowerArm.L"] = [[
					eyiqerJbJbgAhveyjBe8KMJ2bnmGeyjQfKLIKlY3oyeyjMfGK1KXZpoJe2jEe9KZJ8atmYfDi8evKEJibKjtfAi3esJzJccci5e1i1exJsJfdrjnewixexJj
					Jfe0jPezi6evIXKjf6h/e5jTezF+NhhFhmfHjie7DhRziKiNfbjbfDB6WKi9jZfqjKfIBRZGjRkbfsjHfJBMZhjTklfljQfHBbYOjMkGfkjRfGBeX+jLkBfr
					jJfJBPZRjSkfftjFfJBLZrjTkpftjFfJBLZrjTkpftjFfJBLZrjTkpftjFfJBLZrjTkpftjFfJBLZrjTkp]],
				["UpperArm.R"] = [[
					g1jGfA0UyngAwQg1jSfa3FyRjor/g1jafr4axql4pAg0jYfm4Gx4lPpxg3jUff3Yx9karmhBjPfb2cxakKuIg/jMfU12xqjEvAg3jMfN1vyYh9uegzjKfH1Q
					ysg9u4g4jHfB1bxPekwSg8i+e+2rtqZ8w5g6ije93lo4Ubv8gyh7e83VkhPptzgqhbe72rh8M6r4gohWe72jhlMjrkgshle726irNssfgthoe72+i5N6sqgp
					hZe72nhyMwrwgohUe72ghdMbrdgohUe72ghdMbrdgohUe72ghdMbrdgohUe72ghdMbrdgohUe72ghdMbrd]],
				["LowerArm.R"] = [[
					hOiqerJb2lgAhvhOjBe8KM2KkZmGhOjQfKLI1bnJoyhNjMfGK21qmeoChRjEfBKW1+ksm/hdi7fDJ62GiAmkhbi1e9Ju2ThLlThQi1e0Jr2dh4kEhMixevJl
					2khgi7hMioetLF4IgIhwhEiXevPb7VfLgegvh7ezVt+PemfOgXhae3b4/mePd8gIhCe6fy/zeIdFgFg+e7gW/yeHc9gMhJe5eo/zeJdVgOhLe5eT/yeKdagH
					hAe6gB/zeHdBgFg9e7gi/xeHc6gFg9e7gi/xeHc6gFg9e7gi/xeHc6gFg9e7gi/xeHc6gFg9e7gi/xeHc6]],
				Tail1 = [[
					gAimhDfZgAgA//gAiihYhbgAgA/9gAifhkiugAgA/4gAighhiYgIgB/5f/ihhahtfUf8/8f8ijhTg+cyfy/0f9ikhOgfdSf3/3f/ikhNgXfff+//gAilhJgB
					gXgA//gAishFfnf7eG/7gAi1hDfgfnZh/UgAivhDfbfOT09jgAiahDfOe5O36+gAiEhDfBetMA46gAiAhDe/esLn4lgAiLhDfFexM15jgAiNhDfGeyNE5vgA
					iChDfAetL14xgAh/hDe+erLe4egAh/hDe+erLe4egAh/hDe+erLe4egAh/hDe+erLe4egAh/hDe+erLe4e]],
				Tail2 = [[
					gAioiBeHgAgA/7gAiciWgJgAgA//gAiViihdgAgA/9gBiXifhHgLgC/+f8ibiYgbfEf4/+fvifiQftbmfh/rfyiiiLfOcSfq/wf9ijiLfFfTf8/+gCiliIev
					gfgC/9gAiuiDeZf3eF/5f/i3iBeWfWZf/Rf+iziBePetTw9ef+ifiBd4eJO161f+iKiBdhd2L/4uf/iGiBdedzLm4Zf+iRiBdpd7Mz5Yf+iTiBdrd9NC5kf/
					iIiBdgd1L04mf/iFiBdcdyLd4Sf/iFiBdcdyLd4Sf/iFiBdcdyLd4Sf/iFiBdcdyLd4Sf/iFiBdcdyLd4S]],
				Tail3 = [[
					gAiwjAdJgAgA/3gAicjUfLgAgA/+gAiPjggfgAgA//gBiSjdgJgOgD//f5iZjXfde0f0/9feihjMewabfO/dfkiljIeQbSfb/lf7imjKeHfGf5/7gEiqjGdx
					gngE/6gAi0jBdefyeE/1f+i+jAdffCZb/Mf8i7i/dWeETr9Vf8iqi/c0dPOw6nf+iXi+cScyL94bf+iTi+cNcuLk4Gf9idi+cdc6Mw5Hf9ifi/cgc8M/5Tf+
					iVi+cQcxLy4Sf+iSi+cLctLc3+f+iSi+cLctLc3+f+iSi+cLctLc3+f+iSi+cLctLc3+f+iSi+cLctLc3+]],
				Tail4 = [[
					gAi7j9cQgAgA/xgAifkTeSgAgA/8gAiNkfflgAgA//gCiSkcfPgRgE/+f0ibkVekekfu/7fJimkHd4ZRe3/LfSiskEdZaUfI/Xf3itkIdOe6f2/2gGiykEc4
					gwgG/1f/i+j/cofteD/wf8jIj9ctetZW/Ff5jHj8chdaTk9Jf6i6j7b1cTOq6Tf+iqj6bIbsL64Bf+inj6bBbnLi3rf8ivj6bXb3Ms4uf8iwj6bab6M747f+
					ioj6bFbqLw34f+imj6a+bmLa3jf+imj6a+bmLa3jf+imj6a+bmLa3jf+imj6a+bmLa3jf+imj6a+bmLa3j]],
				Tail5 = [[
					gAjJk6a7gAgA/lgAimlRc8gAgA/2gAiPldeQgAgA/8gDiVlad6gTgF/6fvihlTdPeVfn/0ewivk/cnYKeW+ye8i3k9cGZYet/Bfzi4lFb5evfw/sgJi+lBbj
					g4gJ/qf/jLk8bXfqeB/lf6jWk6bgeeZO+5f1jYk5bUc8TX82f3jPk2agbnOe50f9jCkzZsa5Lx3af+jAkzZjazLb3Cf7jHk0Z9bFMi4Kf6jIk0aCbJMx4Xf9
					jCkzZoa2Lo3Qf+i/kzZgaxLT26f+i/kzZgaxLT26f+i/kzZgaxLT26f+i/kzZgaxLT26f+i/kzZgaxLT26]],
				["UpperLeg.L"] = [[
					fEhvgO7MczgAwifEhygc87c1fotRfEh1gl92c3fZrEfEh0gj9nc5fZrrfFhzgc9Jcnf8swfIhygR8hbxhbtyfHhxgP8Ib7hPunfFhwgT8EcpgGu+fEhwgT7x
					c6fsvle+h9gP7VbMe9v4e0iagO6sXOcxu7eviygO5LSLaYs6e1i4gO22NvYuque+iygO07LIX+pOe/iwgO0oKyX4pAe7i1gO1iL5YKpre6i1gO1sMHYOpze+
					ixgO0zK/X8pIfAiwgO0hKqX3o8fAiwgO0hKqX3o8fAiwgO0hKqX3o8fAiwgO0hKqX3o8fAiwgO0hKqX3o8]],
				["LowerLeg.L"] = [[
					fAhIf5tSgcgA9GfAhRf/wlgcgD7XfAhYgDykgcgF6CfAhWgCyDgggD6afBhTf+xBgDgP7FfGhQf2v1emg37wfFhNf1vEe5gu8MfBhMf6u4gJgK8Ue/hKf8uU
					gpf78me1hYf5tcfreQ8+ehh6f2sqd1aE8seTidfzrqbrUw7PeWivfwqZZ7QG5AeeiwfupeY+NX3KegivfupVY1M/24ebiwfvpwZPOK3veaiwfvp1ZUOZ36ef
					iwfupaY6NN3DehivfupSYzM32yehivfupSYzM32yehivfupSYzM32yehivfupSYzM32yehivfupSYzM32y]],
				["Foot.L"] = [[
					fBgmgX81gAgAt3fBgpgU+PgAgAqafBgtgS+8gAgAoIfBgsgT+xgCf8ovfCgqgS+af0gZp7fEgogN96fHh0rLfDgngP9mfQhisAfBgngU9jf3gTsPfBgmgX9T
					gGfzs0eyg2gW9CeSfLtSeUhbgU8oaFdYstd9iFgS7XUubYrOd5iggR5PP+Z6pmeAiogQ3dNKZNoeeCiogP3LMyZHoUd9imgQ4BN+ZZo0d9imgQ4LONZdo6eB
					iogP3VNAZKoaeCiogP3FMpZFoQeCiogP3FMpZFoQeCiogP3FMpZFoQeCiogP3FMpZFoQeCiogP3FMpZFoQ]],
				["Toe.L"] = [[
					fBgUgJ/8gAgAhtfBgbgC/7gAgAd/fBgif//sgAgAbnfBgggA/xgAf7cPfCgdgA/4f+gbdefGgaf8/5f4iBe0fFgYf//8f6htftfCgXgF//f/gVf8fBgWgI//
					gAfygkewglgI/6eGf5hGeOhMgG/UZhf3gudyh6gD9kT0gEf2dsiagA6/O3gjfKdyilf/46L/g+ezd0imf+4lLnhCewdwijf/5kM0g1e5dviif/5vNEgze7dz
					ilf+4xL1hAeyd0imf+4eLehEewd0imf+4eLehEewd0imf+4eLehEewd0imf+4eLehEewd0imf+4eLehEew]],
				["UpperLeg.R"] = [[
					g8hvgO7MjNgAwig8hygc87jLgYtRg8h1gl92jJgnrEg7h0gi9njMgfrqg8hygf9Ji8gys2g+hxgg8hiIiAuMg+hwgc8JiThpu9g8hwgW8EjCgdvCg7hwgR7x
					jTf7vig1hvgP73hkfJvoghhrgO8cdYdUuKgDhfgO8UXwbtrofohNgO7DSha+pLfXg+gO5sPVa4nqfVg7gO5eO5a5ndfchCgO6JQRa4oGfdhEgO6RQia4oPfW
					g9gO5mPJa4nlfUg6gO5ZOva5nYfUg6gO5ZOva5nYfUg6gO5ZOva5nYfUg6gO5ZOva5nYfUg6gO5ZOva5nY]],
				["LowerLeg.R"] = [[
					hAhIf5tSfkgA9GhAhRf/wlfkf97XhAhYgDykfkf76ChAhWgCyDfpf56ahBhSgBxBfLgH7FhFhOgGv1dugy7shEhMgDvEeAgr8JhBhMf9u4fRgH8Ug/hKf6uU
					fwf58ng1hJf4tUezeQ9BgXhJfzsMdCaD80fxhFfvqybFUs7efRg9frpOZoP+5UfBg0fpoIY6NL3ge/gyfpn+Y0My3OfFg3fpodZHN/4EfHg4fqojZKOO4OfA
					gzfpoEY4NB3Ye+gyfon6YyMq3He+gyfon6YyMq3He+gyfon6YyMq3He+gyfon6YyMq3He+gyfon6YyMq3H]],
				["Foot.R"] = [[
					g/gmgX81gAgAt3g/gpgU+PgAgAqag/gtgS+8gAgAoIg/gsgS+xgCf8ovhAgpgV+af0gZp7hBgngc96fHh0rLhAgmgc9mfQhisAg/gmgX9jf3gTsPg/gmgV9T
					gGfzs0gvgngV9HeSfMtHgJgrgT85aBdgsHfagwgQ7yUjb0qJe2gxgN5vPqa1oJekgvgM3+Mvafm3eigugM3sMWadmsepgwgM4iNlaknQeqgwgM4sN1amnWej
					gvgM33MlaemyeigugM3mMNadmoeigugM3mMNadmoeigugM3mMNadmoeigugM3mMNadmoeigugM3mMNadmo]],
				["Toe.R"] = [[
					g/gUgJ/8gAgAhtg/gbgC/7gAgAd/g/gif//sgAgAbng/gggA/xgAf7cPhAgcgD/4f+gbdehDgYgM/5f4iBe0hCgXgM/8f6htfthAgXgH//f/gVf8g+gWgG//
					gAfygkgtgXgH/7eGf6g6gDgdgE/VZhf/gFfQgmf/9jT0gjeseqgsf765O7hhdoeZgsf54xMHiUdIeXgsf54cLuicdEedgtf65cM6iEdQefgtf65nNJh/dTeY
					gsf54oL8iYdGeWgsf54VLmifdCeWgsf54VLmifdCeWgsf54VLmifdCeWgsf54VLmifdCeWgsf54VLmifdC]],
			},
		},
	},
}
