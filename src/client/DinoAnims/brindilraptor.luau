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
					gAhugYAHgAgAicgAhugYAHgAgGicgAhugYAHgBgLicgAhvgYAHgBgQicgAhvgYAHgCgVicgAhvgYAHgCgZicgAhvgYAHgCgdicgAhvgYAHgCggicgAhugYAH
					gDgiicgAhugYAHgDgjicgAhugYAHgDgkicgAhtgYAHgDgjicgAhtgYAHgDgiicgAhsgYAHgCggicgAhsgYAHgCgdicgAhsgYAHgCgZicgAhsgYAHgCgVicgA
					hsgYAHgBgQicgAhtgYAHgBgLicgAhtgYAHgAgGicgAhugYAHgAgAicgAhugYAHgAf6icgAhugYAHf/f1icgAhvgYAHf/fwicgAhvgYAHf+fricgAhvgYAHf+
					fnicgAhvgYAHf+fjicgAhvgYAHf+fgicgAhugYAHf9feicgAhugYAHf9fdicgAhugYAHf9fcicgAhtgYAHf9fdicgAhtgYAHf9feicgAhsgYAHf+fgicgAhs
					gYAHf+fjicgAhsgYAHf+fnicgAhsgYAHf+fricgAhsgYAHf/fwicgAhtgYAHf/f1icgAhtgYAHgAf6ic]],
				Spine1 = [[
					gAhwgJAvgAgAmugAhwgJAwgBgFm2gAhxgJAygCgLm+gAhxgJAzgEgQnDgAhxgJA0gFgUnHgAhxgJA1gGgZnIgAhxgJA0gGgcnHgAhxgJA0gHgfnDf/hxgJAy
					gHghm9f/hwgJAxgIgim2f/hwgJAvgIgjmuf/hvgJAtgHgjmmf/hvgJAsgHghmfgAhvgJArgGgfmZgAhugJAqgGgcmVgAhugJApgFgZmUgAhugJAqgEgVmVgA
					hvgJAqgDgQmZgAhvgJArgCgLmfgAhvgJAtgBgFmmgAhwgJAvgAgAmugAhwgJAwf/f7m2gAhxgJAyf+f1m+gAhxgJAzf8fwnDgAhxgJA0f7fsnHgAhxgJA1f6
					fnnIgAhxgJA0f6fknHgAhxgJA0f5fhnDgBhxgJAyf5ffm9gBhwgJAxf4fem2gBhwgJAvf4fdmugBhvgJAtf5fdmmgBhvgJAsf5ffmfgAhvgJArf6fhmZgAhu
					gJAqf6fkmVgAhugJApf7fnmUgAhugJAqf8frmVgAhvgJAqf9fwmZgAhvgJArf+f1mfgAhvgJAtf/f7mm]],
				Spine2 = [[
					gAh8ftB3gAgAqtgAh9ftB9gCgFq8gAh+ftCCgEgKrKf/h+ftCGgGgPrWf/h/fuCJgIgUrdf/h/fuCKgJgYrff/h/fuCJgKgbrdf/h+fuCGgLgerVf/h+ftCC
					gMggrKf/h9ftB9gMghq8f+h8ftB3gMgiqtf/h8ftBygMghqdf/h7ftBtgLggqPf/h7ftBpgKgeqEf/h6ftBngJgbp9f/h6ftBmgIgYp6f/h6ftBngHgUp9f/
					h7ftBpgFgPqEgAh7ftBtgEgKqPgAh8ftBygCgFqdgAh8ftB3gAgAqtgAh9ftB9f+f7q8gAh+ftCCf8f2rKgBh+ftCGf6fxrWgBh/fuCJf4fsrdgBh/fuCKf3
					forfgBh/fuCJf2flrdgBh+fuCGf1firVgBh+ftCCf0fgrKgBh9ftB9f0ffq8gCh8ftB3f0feqtgBh8ftByf0ffqdgBh7ftBtf1fgqPgBh7ftBpf2fiqEgBh6
					ftBnf3flp9gBh6ftBmf4fop6gBh6ftBnf5fsp9gBh7ftBpf7fxqEgAh7ftBtf8f2qPgAh8ftByf+f7qd]],
				Neck1 = [[
					gAiHfhFMgAgAxbgAiHfhFPgDgFxgf/iIfhFRgGgJxkf/iJfhFUgJgOxnf/iJfiFCgLgSxMf/iJfiExgNgWwwf+iJfiFPgQgYxhf+iJfhFOgRgbxff+iIfhE1
					gSgdw3f+iHfhEqgSgewmf+iHfhFGgTgexSf+iGfgFDgTgexOf+iFfgEqgSgdwlf+iEfgEggQgbwVf+iEfgE9gPgYxEf/iEfgFCgOgVxMf/iEfgFCgLgSxNf/
					iEfgFEgJgOxPf/iFfgFGgGgJxTgAiGfgFJgfgvxWgAiHfhFQhPh5xZgAiHfhFVheiRxcgBiIfhFXhaiNxggBiJfhFZhXiJxkgBiJfiFahUiFxmgBiJfiFahS
					iBxngCiJfiFZhJhzxngCiJfhFUgBgDxogCiIfhFXepd5xhgCiHfhFYeMdNxagCiHfhFVeLdNxVgCiGfgFSeLdNxRgCiFfgFPeMdOxNgCiEfgFNeNdQxJgCiE
					fgFLeSdZxIgBiEfgFGe4eSxKgBiEfgFDfmfYxNgBiEfgFEf3fyxPgBiFfgFGf6f3xTgAiGfgFJf9f7xX]],
				Neck2 = [[
					gAijfUG7gAgAz3gAikfVG/gDgEz7f/ilfVHCgHgJz/f/ilfVHEgKgN0Cf/ilfVGwgNgRzof+ilfUGcgPgUzPf+imfVHAgSgXz8f+ilfVG+gUgZz6f+ikfUGh
					gVgbzVf+ijfTGVgVgczFf+ijfUG1gWgczvf+iifUGygWgczqf+igfSGVgUgbzEf+iffRGJgTgay1f+igfTGrgSgXzhf+igfTGwgQgUzpf/igfTGxgNgRzpf/
					igfTGygKgNzsf/ihfTG1gHgJzvf/iifUG7hJhbzxf+ijfUHPjFj5zof+ikfVHbjukvzkf/ilfVHejqkrzpf/ilfVHfjmknztf/imfWHgjjkkzvf/imfWHgjg
					khzwgAimfWHbjMkHzzgCilfVHFgbgk0CgEilfVHUdAcMzwgEikfVHib5ayzfgFijfUHeb4ayzbgFiifUHbb3azzXgEihfUHYb3a1zTgEigfTHVb4a3zQgEig
					fTHRcDbFzRgDigfTG9dec2zfgCigfTGyfPfDzpgBigfTGyf2fzzsgBihfTG1f5f3zvgAiifUG4f9f8zz]],
				Head = [[
					gAi9fOAFgAgAh4gAi+fOAFgAgGh+f/i/fPAFgBgLiDf/jAfPAGgBgQiHf+jAfOACgAgVfXf+i/fMALf9gZczf+jAfPADgBgdhVf+jAfPADgBgghTf9i+fMAG
					f+gid3f9i9fLANf8gjcnf9i9fNACgBgkhEf9i8fNACgBgjg/f9i6fKAHf9gidif+i5fJAPf8ggcTf+i6fMACgBgdgzf+i6fMAEgBgZhnf+i6fMAEgBgVhnf/
					i7fMAEgBgQhqf/i7fNAEgBgLhuf+i8fNAQgrjXhvf8i9fOBfh2pShaf8i+fPCLiNrRhPf8i/fQCJiLrMhUf9jAfQCIiJrHhZf9jAfQCGiIrDhbf9jBfQCFiH
					q/hcf+jAfQBwh+qGhigBjAfPAJgahxiFgGi/fPBSeZXYhpgHi+fPCadyUJhNgHi9fPCadwUJhHgHi8fOCZduUKhCgHi7fOCZdsUMg+gHi7fNCYdrUOg6gGi6
					fNCMdvUrg7gFi6fMA6ejYwhVgCi6fMAIfod/hmgBi7fMAEf/fwhqgBi7fNAEf/f1hugAi8fNAEgAf6hz]],
				Jaw = [[
					gAjAek/ggAgAlhf/jBek/fgBf6lmf/jDel/fgCf1lrf+jDel/egDfwlvf+i8ek+sgGfspCf9i1ej9qgJfpr+f9jCel/RgGfkmvf8jBel/RgHfhmsf8i2ej+N
					gLfgqif8iyei9vgNffryf8i+ej/UgHfdmef8i9ej/TgHfdmkf8iyeh+NgLfgqif8iteg9rgMfir6f9i6eh/RgGfkmvf9i8ei/dgFfnlyf+i8ei/dgEfrlxf+
					i9ei/egDfwlvf/i+ej/fgCf1lrf1i/ek/TgHcllnfljAer+CgVWjlqfgjBev9SghUjl0fhjCew9TglUol4fhjDew9UgoUtl8fijEew9WgqUxl/fijEew9Xgq
					U1l/fljEeu9sglVul9f9jDel/agCeMlvgcjCer+NfgoxlxgkjBex9DfYsDlzgkjAew9EfesDlugki/ew9DfgsDlzgki+ev9DfisCl4gki9ev9DfksAl7gji9
					et9Ofmrjl9gXi8en+kfwnZl3gIi8ei/Zf6iElygCi9ei/ef9gQlvgBi+ej/ff+gLlrgBi/ej/ff/gGlm]],
				Crest = [[
					gAkKfcR9gAgA8vgAkLfdSCf3gg8xf/kMfeSHfwg58zf/kMffSLfvhG80f/kOfQQuf3hI8Ff+kMfCPYgEg87Uf+kNfbRwgQgh8of+kNfaRtghgE8nf9kMfHP4
					gtfq7nf9kKe/PNg0fX7Nf+kKfYRgg+fQ8ff+kJfXRbg6fW8df9kIfDPmgsfq7cf9kGe8O8gfgG7Df+kHfVRSgQgh8Zf+kHfZRugBg58nf/kHfZRvf1hH8nf/
					kIfZRxfwhH8of/kIfaR0fxg58qgDkJfaR9jDhh8igKkKfWSOo/i97RgLkLfVSRrFjM6fgMkLfWSOrKi26egMkMfWSNrLiq6egMkNfXSPrFir6igMkNfXSVq7
					i56ngMkNfYSZp6i97CgEkMfeSLhrgr8yf5kMfZSMXbdv7df3kLfUSMUNc96Kf4kKfTSFUJdF6Ff4kJfSSDUMdA6Ff3kIfSSFUVcw6If3kHfRSLUicZ6Of3kH
					fRSRVKcH6ff6kHfWSCZTdB71f/kHfZRzeheY8kgBkIfZRxgQe58ogBkIfaR0gPfH8qgAkJfbR4gJfg8s]],
				["UpperArm.L"] = [[
					fciFfU1rNmeZulfciGfV15NreCuRfbiHfV2GNvdtuAfbiIfV2QNzdctyfbiIfW2WN2dQtqfaiJfW2YN4dKtpfaiIfW2VN5dKtvfaiIfW2PN6dRt7faiHfW2E
					N5dduNfaiGfW13N4duuifaiFfV1pN3eBu5faiEfV1aN2eUvPfaiDfV1MN0envifaiCfV1BNze2vxfaiCfV06NxfBv5faiBfU03NvfGv6fbiCfU06NtfGv1fb
					iCfU1CNrfAvofbiDfU1NNpe2vVfciEfU1bNoeou+fciFfU1rNmeZulfciGfU16NmeKuLfdiHfU2INld8tzfdiIfU2SNldytgfdiIfU2ZNkdttSfeiJfU2cNj
					dttMfeiIfU2aNhdztOfeiIfU2TNed9tXfeiHfT2JNceMtmfeiGfT18NZeet6feiFfT1sNWexuQfeiEfT1dNVfEumfeiDfT1ONUfUu7feiCfS1DNUfgvMfeiC
					fS07NVfnvYfeiBfT05NWfnvdfdiCfT07NZfhvcfdiCfT1CNbfWvVfdiDfT1ONffFvIfciEfU1cNiewu4]],
				["LowerArm.L"] = [[
					fMh2fFgABHXugAfMh4fFf+BQXOgFfLh5fFf9BYWygLfLh6fFf7BfWbgPfLh7fFf6BkWMgUfKh7fGf4BlWHgYfKh7fGf3BkWMgcfKh6fGf2BfWbgefKh5fGf2
					BYWyghfJh4fGf2BQXOgifJh2fHf3BHXugjfKh1fHf3A/YOgifKhzfHf4A4YrghfKhyfHf5AyZCgffKhxfHf6AvZRgcfKhxfHf7AuZWgZfLhxfHf8AvZRgVfL
					hyfGf8AyZCgQfLhzfGf9A3YrgLfMh1fFf/A+YOgFfMh2fFgABHXugAfNh4fEgCBQXOf7fNh5fEgDBYWyf1fOh6fEgFBfWbfxfOh7fDgGBkWMfsfOh7fDgIBl
					WHfofPh7fDgJBkWMfkfPh6fDgKBfWbfifPh5fDgKBYWyfffPh4fDgKBQXOfefPh2fDgJBHXufdfPh1fDgJA/YOfefPhzfEgIA4YrfffPhyfEgHAyZCfhfPhx
					fEgGAvZRfkfOhxfFgFAuZWfnfOhxfFgEAvZRfrfOhyfFgEAyZCfwfNhzfFgDA3Yrf1fNh1fFgBA+YOf7]],
				["UpperArm.R"] = [[
					gkiFfU2Xx9sjmlgkiGfU2hxus1mGgjiHfU2qxhtElrgjiIfU2xxWtQlVgjiIfU3KwTucjmgiiJfU3ZvVvZiHgiiIfU3Aw/tlkmgiiIfU2+xItakxgiiHfT3S
					wLudjQgiiGfT3VwAunjAgiiFfT2tx0sgl1giiEfT2lyDsLmQgiiDfT29xOtRk5giiCfS3BxBtiklgiiCfS2QyirinLgiiBfT2EyyrKnsgjiCfT2EyurRnrgj
					iCfT2HynrfnhgjiDfT2LybrynRgkiEfU2RyNsKm8gkiFfU2Xx9sjmlgkiGfV2dxss9mNgliHfV2hxdtUl3gliIfV2jxRtnlmgliIfW2kxJt0lcgmiJfW2jxF
					t6lagmiIfW2hxHt5lggmiIfW2dxOtylvgmiHfW2XxZtkmEgmiGfW2QxmtSmdgmiFfV2Jx1s8m5gmiEfV2ByEsmnUgmiDfV16yRsRnrgmiCfV11ybsAn9gmiC
					fV1yyirzoIgmiBfU1yylrtoKgliCfU11ykruoDgliCfU17yfr1n0gliDfU2DyWsBnegkiEfU2NyKsSnD]],
				["LowerArm.R"] = [[
					g5iJfEat4/zLhrg4iLfEaz4ozqhtg4iMfEa44T0Ghvg3iNfEa94C0bhvg3iQfFbV330piZg3iSfGbv300ui7g2iPfEbM330qh1g2iOfEbM4D0ehwg2iPfEbk
					4V0Jicg2iPfEbs4rzuimg2iKfCbH5BzRhcg2iIfCbE5YyyhVg2iJfCbW5tyWiEg2iJfDbb58x/iTg2iEfCa76FxxhNg2iDfCa16IxrhBg3iEfCaz6FxwhGg3
					iEfCax57x9hNg4iGfDaw5ryThWg4iHfDau5Wyuhgg5iJfEat4/zLhrg5iLfFas4ozoh2g5iMfGaq4S0Ch/g6iNfGao4A0WiIg6iOfHam300jiOg7iPfHak3w
					0miSg7iOfHah3z0hiUg7iNfHae3/0TiTg7iMfHac4Qz+iRg7iLfHaZ4mzjiMg7iJfGaY49zFiHg7iHfGaW5UyniAg7iGfFaW5pyLh6g7iEfFaW54x1h0g7iE
					fFaX6Cxnhvg7iDfEaZ6Gxjhrg6iEfEac6Dxphog6iEfEaf55x4hng6iGfEaj5qyPhog5iHfEao5Wyshp]],
				Tail1 = [[
					gAhugrfPgAgA/+gAhugrfCgagB/+gAhugre2gzgC/9gAhvgreshLgD/8gAhvgremhggE/7gAhvgrekh0gF/6gBhvgremiFgG/5gBhvgresiSgG/4gBhugre2
					icgG/4gBhugrfCiigF/4gBhugrfPikgE/4gBhtgrfciigD/4gBhtgrfoicgC/5gBhsgrfyiSgB/6gBhsgrf4iFgB/7gAhsgrf6h0gA/8gAhsgrf4hhgA/9gA
					hsgrfyhLgB/+gAhtgrfogzgB/+gAhtgrfcg+gB/+gAhugrfPhogD/8gAhugrfChngD/7gAhugre2hOgD/8gAhvgresg2gC/9gAhvgremgggB/9gAhvgrekgM
					gB/9f/hvgremfyf//9f/hvgreseHf7/6f/hugre2cKf3/vf/hugrfCbef3/pf/hugrfPbcf5/pf/htgrfcbef7/qf/htgrfobkf9/rf/hsgrfybuf+/sf/hs
					grf4cAf//vgAhsgrf6c/f//2gAhsgrf4eNgA/8gAhsgrfye1f//+gAhtgrfofNf//+gAhtgrfcfmgA//]],
				Tail2 = [[
					gAhwhWeFe3f8/6gBhxhWdtfif//5gChyhWdUgOgC/4gDhyhWc9g5gG/1gEhzhWcrhjgK/xgFhzhWceiLgO/ugGhzhWcZivgS/qgHhyhWccjOgV/ogHhyhWcm
					jpgX/mgHhxhWc3j+gY/lgIhwhWdMkMgY/lgHhvhWdkkVgX/mgHhuhWd9kWgV/ogHhthWeUkQgT/qgGhshWemkEgR/sgFhshWezjygP/vgEhshWe4jZgN/ygD
					hthWe1i7gL/1gChuhWeriYgJ/4gDhvhWebi7gL/0gEhwhWeGkYgR/ogEhxhWdukdgS/mgDhyhWdVjygQ/pgChyhWc+jHgO/sgBhzhWcridgL/ugAhzhWceh1
					gJ/vf/hzhWcZg+gE/xf6hyhWcbdkfw/sf1hyhVcpZkfY/JfzhxhUc7YHfR+1fzhwhUdQX4fS+0fzhvhUdpXwfU+0fzhuhUeBXvfY+1f0hthVeXX0fb+4f1hs
					hVepYJfg++f3hshVe0Z3fo/Xf7hshWe4cCfx/uf9hthWe1dFf1/1f+huhWerdof3/4f/hvhWebeOf5/5]],
				Tail3 = [[
					f9h1iBd0dAfv/xgAh3iBdYdzf1/zgDh5iBc4eqf6/zgGh7iBcYfjgB/ygJh8iAb5gdgI/ugLh9iAbfhWgP/pgNh9h/bNiMgW/jgPh8h/bFjAgd/dgRh7h/bG
					jugj/ZgSh5h/bSkWgn/VgTh3h/bnk4gq/TgTh1h/cClSgs/SgThzh/cilkgs/TgShyh/dCltgr/VgRhwiAdhltgp/YgQhwiAd7lkgm/bgOhviAeNlTgi/fgL
					hwiBeVk5ge/kgJhxiBeUkXga/pgLhziBeJlage/egQh1h/d4nzgp+8gQh3h/deoIgq+1gNh5iAc9nSgl+/gKh7iAccmagh/IgIh8iAb8lhgd/PgFh9iAbikp
					gZ/VgBh9iAbOjVgR/df0h8iAbEeLfs/jfkh7h8bNYIe8+nffh5h6bdV2ep99feh3h6bzVWel91feh1h6cPU9ek9wfehzh6cuUsel9tfehyh6dOUjep9tfghw
					h7dsUwev91fnhwh+eAW9fD+mfwhviAeOZ2fZ/Vf1hwiBeVbHfi/kf3hxiBeUbpfm/pf6hziBeIcRfq/t]],
				Tail4 = [[
					f1h7isc1bGfU/cf6h+iscgb2fd/hf/iBircDcsfn/kgFiEirbgdnfx/lgKiHiqa8emf8/jgPiJipaZfogH/fgTiKipZ8gqgS/ZgXiJioZmhrge/TgbiIinZb
					ipgo/MgdiGinZbjjgy/GggiDinZmkXg6/BghiAinZ7lEhB++ghh9inaYlphG+9ghh6ina7mGhJ++ggh3iobfmYhK/Ageh1ipcBmhhJ/Cgch1ipcfmghG/GgY
					h1iqc0mVhB/LgUh2irdAmAg7/RgZh4ipdEnuhH+4glh7ildDrJhe9zglh+ilcxr3he9fggiBimcSrEhU9wgbiEinbuqMhK+AgWiHiobIpPhC+OgRiJioakoQ
					g7+agKiJipaDmpgv+tfviJipZmf4fx/VfQiIigZmX2ef+OfFiGibZwUyd69OfDiDiaZ+UCdt89fCiAiaaVTZdk8vfCh9iaa0S2de8lfCh6iabXScdc8ffEh3
					ibb5Scdh8kfQh2iicPU8eE9ufgh1iochYXeu+2foh1iqc0Zre//Lfsh2irdAaAfF/Rfwh4irdAaffM/W]],
				Tail5 = [[
					foiEjUbsZ2e0/EfviIjVbkaXe//Kf3iMjVbRbBfK/Of+iRjUa2byfY/SgGiVjTaWcrfl/TgOiYjSZ0dpf0/TgViajRZSergC/QgbiajQY1fvgQ/LghiajOYf
					gzge/FgmiYjOYSh2gs+/gqiVjNYQi2g5+5guiRjNYZjxhE+0gwiMjNYrkmhO+xgxiIjOZGlUhX+wgxiEjOZml5hd+wgviBjPaImVhg+xgth+jQaqmohh+zgp
					h+jRbHmwhg+2gkh+jSbdmthb+6gtiAjPbzpNh3+ShAiEjGcKtvik8hhDiIjDcKu9il75g8iMjGb1uZiT8Lg1iQjIbYtsiD8dgtiUjKa1s5h18wgmiXjLaPr/
					hp9DgbiZjOZnqUhY9kfviajRY2iNgE/Ge8iajCYqYTeS+HeriYi4YtUldd83eniUi2YxTrdI8eeliRi1Y+S3c28IejiMi0ZVSIcn71eiiIi0ZzRfcb7mekiE
					i2aTRTca7me0iBjCagUGdK9CfMh/jNavX/eK+dfXh+jRbHZQeg+2fch+jSbdZTel+6fhiAjTbqZfer+/]],
				["UpperLeg.L"] = [[
					fXhIgJ7mdhf8v/fXhIgK7jdmf5wFfXhJgK7gdqf1wKfXhJgK7edufxwOfXhJgK7edyfuwPfXhKgK7fd1fqwNfXhJgL7id3fnwJfXhJgL7md4fkwCfXhJgL7s
					d4fhv4fXhIgL7yd3ffvtfXhIgL74d2fdvifXhHgL79d0fcvYfXhHgL8BdyfcvQfXhHgL8EdwfdvLfXhGgL8FdtffvJfXhGgK8EdrfivKfXhGgK8BdpfmvPfX
					hHgK78dnfrvYfXhHgK72dlfxvjfXhHgK7udjf2vxfXhIgJ7mdhf8v/fXhIgJ7ddfgCwOfXhJgJ7VdegIwcfYhJgJ7NdcgNwofYhJgJ7IdZgSwwfYhKgI7EdX
					gWw1fYhJgI7DdVgZw3fYhJgI7EdSgbw0fYhJgI7IdQgcwufYhIgI7NdOgcwmfYhIgI7SdNgbwdfYhHgI7YdMgawTfYhHgI7edLgYwJfYhHgI7jdMgWwAfYhG
					gI7ndNgTv5fYhGgI7qdPgPv1fYhGgJ7rdRgMvzfYhHgJ7sdVgIvzfXhHgJ7rdYgEv2fXhHgJ7oddgAv6]],
				["LowerLeg.L"] = [[
					fVguf6sFgggB9nfVguf7sXglgA9gfVgvf7sngqf+9ZfVgvf7s0gvf99TfUgvf8s9g0f79PfUgvf8tCg4f69MfUgvf8tDg8f59MfUgvf8s+hAf59OfUgvf7s2
					hDf59SfUgvf7srhFf59WfUguf7sehGf69cfUguf7sQhGf79ifUguf6sEhGf79nfUguf6r5hEf89rfUgtf6rxhBf99vfUgtf6rsg9f+9wfUgtf6rrg4f+9xfU
					gtf6rtgzf/9wfVgtf6rzgtgA9ufVguf6r7gmgA9rfVguf6sFgggB9nfVguf7sPgZgC9jfVguf7sYgTgD9ffVguf7sfgNgE9dfVgvf7sjgHgF9bfWgvf7sigD
					gG9bfWguf7sef/gH9dfWguf7sVf8gH9hfWguf6sKf6gI9lfWguf6r8f6gI9rfWgtf6ruf6gI9xfWgtf5rgf7gI92fWgtf5rUf9gI96fWgtf5rMgAgI9+fWgs
					f5rIgDgH9/fVgtf5rIgHgG9/fVgtf5rNgLgG99fVgtf5rXgQgF96fVgtf6rkgVgE90fVguf6r0gagC9u]],
				["Foot.L"] = [[
					fWgZgQ81gDf/t3fWgZgQ81gHf9t3fWgZgQ81gLf7t3fWgZgQ81gPf5t3fWgZgQ81gSf3t3fWgZgQ81gWf1t3fWgZgQ81gZf0t3fWgZgQ81gcfyt3fWgZgQ81
					gffxt3fWgZgQ81ghfwt3fWgZgQ81gifwt3fWgZgQ81gjfvt3fWgZgQ81gifwt3fWgZgQ81ghfwt3fWgZgQ81gffxt3fWgZgQ81gcfzt3fWgZgQ81gYf1t3fW
					gZgQ81gTf3t3fWgZgQ81gOf5t3fWgZgQ81gIf8t3fWgZgQ81gDf/t3fWgZgQ81f9gBt3fWgZgQ81f3gEt3fWgZgQ81fygHt3fWgZgQ81fugJt3fWgZgQ81fq
					gKt3fWgZgQ81fngMt3fWgZgQ81flgNt3fWgZgQ81fkgOt3fWgZgQ81fjgOt3fWgZgQ81fjgOt3fWgZgQ81fkgNt3fWgZgQ81fmgMt3fWgZgQ81fogLt3fWgZ
					gQ81frgKt3fWgZgQ81fvgIt3fWgZgQ81fygHt3fWgZgQ81f2gFt3fWgZgQ81f6gDt3fWgZgQ81f+gBt3]],
				["Toe.L"] = [[
					fWgNgG/8gCf+htfWgNgG/8gFf6htfWgNgG/8gIf3htfWgNgG/8gLf0htfWgNgG/8gOfxhtfWgNgG/8gQfuhtfWgNgG/8gTfrhtfWgNgG/8gVfphtfWgNgG/8
					gXfmhtfWgNgG/8gYflhtfWgNgG/8gZfkhtfWgNgG/8gafjhtfWgNgG/8gZfkhtfWgNgG/8gYflhtfWgNgG/8gXfnhtfWgNgG/8gUfphtfWgNgG/8gRfshtfW
					gNgG/8gOfwhtfWgNgG/8gKf1htfWgNgG/8gGf5htfWgNgG/8gCf+htfWgNgG/8f+gDhtfWgNgG/8f6gHhtfWgNgG/8f2gLhtfWgNgG/8fzgPhtfWgNgG/8fw
					gShtfWgNgG/8fugVhtfWgNgG/8fsgWhtfWgNgG/8frgXhtfWgNgG/8frgYhtfWgNgG/8frgYhtfWgNgG/8fsgXhtfWgNgG/8ftgVhtfWgNgG/8fvgUhtfWgN
					gG/8fxgRhtfWgNgG/8fzgOhtfWgNgG/8f2gLhtfWgNgG/8f5gIhtfWgNgG/8f8gFhtfWgNgG/8f/gBht]],
				["UpperLeg.R"] = [[
					gphIgJ7mifgEv/gphIgJ7dihf+wOgphJgJ7Viif4wcgohJgJ7NikfzwogohJgJ7IinfuwwgohKgI7Eipfqw1gohJgI7Dirfnw3gohJgI7Eiuflw0gohJgI7I
					iwfkwugohIgI7NiyfkwmgohIgI7SizflwdgohHgI7Yi0fmwTgohHgI7ei1fowJgohHgI7ji0fqwAgohGgI7nizftv5gohGgI7qixfxv1gohGgJ7rivf0vzgo
					hHgJ7sirf4vzgphHgJ7riof8v2gphHgJ7oijgAv6gphIgJ7mifgEv/gphIgK7jiagHwFgphJgK7giWgLwKgphJgK7eiSgPwOgphJgK7eiOgSwPgphKgK7fiL
					gWwNgphJgL7iiJgZwJgphJgL7miIgcwCgphJgL7siIgfv4gphIgL7yiJghvtgphIgL74iKgjvigphHgL79iMgkvYgphHgL8BiOgkvQgphHgL8EiQgjvLgphG
					gL8FiTghvJgphGgK8EiVgevKgphGgK8BiXgavPgphHgK78iZgVvYgphHgK72ibgPvjgphHgK7uidgKvx]],
				["LowerLeg.R"] = [[
					grguf6sFfgf/9ngrguf7sPfnf+9jgrguf7sYftf99fgrguf7sffzf89dgrgvf7sjf5f79bgqgvf7sif9f69bgqguf7segBf59dgqguf7sVgEf59hgqguf6sK
					gGf49lgqguf6r8gGf49rgqgtf6rugGf49xgqgtf5rggFf492gqgtf5rUgDf496gqgtf5rMgAf49+gqgsf5rIf9f59/grgtf5rIf5f69/grgtf5rNf1f699gr
					gtf5rXfwf796grgtf6rkfrf890grguf6r0fmf+9ugrguf6sFfgf/9ngrguf7sXfbgA9ggrgvf7snfWgC9Zgrgvf7s0fRgD9Tgsgvf8s9fMgF9Pgsgvf8tCfI
					gG9Mgsgvf8tDfEgH9Mgsgvf8s+fAgH9Ogsgvf7s2e9gH9Sgsgvf7sre7gH9Wgsguf7see6gG9cgsguf7sQe6gF9igsguf6sEe6gF9ngsguf6r5e8gE9rgsgt
					f6rxe/gD9vgsgtf6rsfDgC9wgsgtf6rrfIgC9xgsgtf6rtfNgB9wgrgtf6rzfTgA9ugrguf6r7fagA9r]],
				["Foot.R"] = [[
					gqgZgQ81f9gBt3gqgZgQ81gDf/t3gqgZgQ81gJf8t3gqgZgQ81gOf5t3gqgZgQ81gSf3t3gqgZgQ81gWf2t3gqgZgQ81gZf0t3gqgZgQ81gbfzt3gqgZgQ81
					gcfyt3gqgZgQ81gdfyt3gqgZgQ81gdfyt3gqgZgQ81gcfzt3gqgZgQ81gaf0t3gqgZgQ81gYf1t3gqgZgQ81gVf2t3gqgZgQ81gRf4t3gqgZgQ81gOf5t3gq
					gZgQ81gKf7t3gqgZgQ81gGf9t3gqgZgQ81gCf/t3gqgZgQ81f9gBt3gqgZgQ81f5gDt3gqgZgQ81f1gFt3gqgZgQ81fxgHt3gqgZgQ81fugJt3gqgZgQ81fq
					gLt3gqgZgQ81fngMt3gqgZgQ81fkgOt3gqgZgQ81fhgPt3gqgZgQ81ffgQt3gqgZgQ81fegQt3gqgZgQ81fdgRt3gqgZgQ81fegQt3gqgZgQ81ffgQt3gqgZ
					gQ81fhgPt3gqgZgQ81fkgNt3gqgZgQ81fogLt3gqgZgQ81ftgJt3gqgZgQ81fygHt3gqgZgQ81f4gEt3]],
				["Toe.R"] = [[
					gqgNgG/8f+gChtgqgNgG/8gCf9htgqgNgG/8gGf5htgqgNgG/8gKf1htgqgNgG/8gNfxhtgqgNgG/8gQfuhtgqgNgG/8gSfrhtgqgNgG/8gUfqhtgqgNgG/8
					gVfphtgqgNgG/8gVfohtgqgNgG/8gVfohtgqgNgG/8gUfphtgqgNgG/8gTfrhtgqgNgG/8gRfshtgqgNgG/8gPfvhtgqgNgG/8gNfyhtgqgNgG/8gKf1htgq
					gNgG/8gHf4htgqgNgG/8gEf7htgqgNgG/8gBf/htgqgNgG/8f+gChtgqgNgG/8f7gGhtgqgNgG/8f4gJhtgqgNgG/8f1gMhtgqgNgG/8fygPhtgqgNgG/8fw
					gShtgqgNgG/8ftgVhtgqgNgG/8frgXhtgqgNgG/8fpgahtgqgNgG/8fogbhtgqgNgG/8fngchtgqgNgG/8fmgdhtgqgNgG/8fngchtgqgNgG/8fogbhtgqgN
					gG/8fpgZhtgqgNgG/8fsgXhtgqgNgG/8fvgUhtgqgNgG/8fygQhtgqgNgG/8f2gLhtgqgNgG/8f6gHht]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAhjgYACe5gKgfgAhlgYADfHhCgdgAhpgYAFffhwgdgAhtgYAGf9iKgegAhugYAGgbiMgggAhsgYAFg0h2ghgAhngYAEhFhLgigAhkgYADhJgUgggAhkgYAD
					hBfZgegAhngYAEguelgdgAhsgYAFgSeBgdgAhugYAGf0dygfgAhtgYAGfYd8ghgAhpgYAFfCedgigAhlgYADe3fPgh]],
				Spine1 = [[
					gAhkgJAWe7gSkYf/hmgJAXfKg0kgf+hqgJAafkhNk0f+hugJAdgDhYlHf+hvgJAegghTlNf+hsgJAcg4hAlBf/hogJAZhGgjksgAhkgJAWhIgAkbgBhkgJAW
					g/fckagBhogJAYgqe+kpgChsgJAcgNesk/gChvgJAefueplMgChugJAefTe1lJgBhqgJAafAfNk3gBhmgJAXe4fuki]],
				Spine2 = [[
					f/hsfsBEe+gaoCf9hufsBIfJgmoTf8hzfsBTffgro6f7h3fsBdf7gopff8h4fsBggXgdpof9h2fsBZgugOpQf+hxfsBNg9f9omgAhtfsBFhDftoHgChtfsBF
					g+ffoGgEhwfsBNgufWolgEh1fsBZgUfWpPgFh4fsBgf3fdpogEh3fsBefdfrpggDhzfsBTfKf6o8gBhufsBIe+gLoT]],
				Neck1 = [[
					f+h0fdD/fGgqvYf8h2feDyfTgyvBf7h7feETfqgyv9f7iAffFQgGgoxhf7iCffGCgfgUyrf9h/ffGEgwf+ysf+h5feFTg5frxkgBh1fdEVg8fcwAgDh0fdDy
					g1fSvCgEh5feD9gjfNvWgFh+ffEwgIfSwugFiCffFtftfhyNgEiBffGKfYf3y2gDh8feFwfLgMyQgBh2feEyfEgdwy]],
				Neck2 = [[
					f8iOfNF6fLgwyef6iQfMF8fZg3ygf5iWfPGZfwg0zJf6idfTHAgKgnz8f7iffVHXgggS0Yf9icfVHNgvf70MgAiVfSGpg4fnzegCiPfOGFg4fWytgFiOfMF3
					gvfLyZgGiSfNGIgcfJyxgGiafRGtgDfRzkgGiffUHPfrfj0PgEiefVHWfXf50XgBiZfTG9fLgPz4f/iSfQGVfHgizE]],
				Head = [[
					f7iofEAFe6gMhrf5ipfDAGfAf2h4f4iwfHAHfTfhiRf5i3fNAIfvfRilf8i6fQAJgNfIiof+i2fPAIgmfKiWgBiwfLAGg5fWh9gEipfFAFhFfphsgHiofDAF
					hFf/hvgIisfFAGg4gViEgIi0fKAIgggoidgGi5fPAJgCg1ipgDi5fQAIfmg4ihgAizfNAHfPgxiKf9isfIAFfAghhz]],
				Jaw = [[
					f6iqeZ/1hHf+i9f5iseZ/2g+gTiwf5i0ed/4goglidf7i8ei/3gJgxiuf+i/em/2fqg1i1gBi7el/3fSgvisgDizeg/3fBgiirgFireb/1e5gNi7gHiqeZ/1
					e8f3i5gHiweb/4fMfjikgGi5eg/4fnfUimgEi+el/2gHfMizgBi9em/2gjfNiyf+i3ej/3g3fWikf8ivee/2hEfoi1]],
				Crest = [[
					f1j0fRRJfnhD8Uf0j2fSRyeyh/8jf0j9fXS0e5hI9Gf3kDfeTIfmfJ9Rf8kGfiSef+eO87gBkDfgRwflfE8ogFj8fZRzfSgF8qgJj2fTSSf2fo85gMj0fQSW
					g2eT83gMj5fUR8hUeO8pgKkAfbR1gzf58rgGkFfgSfgHhk89gCkFfhTFgOhh9Of9kAfdSsgrgT9Ff5j5fWRqgjf88l]],
				["UpperArm.L"] = [[
					fbhufSvpO4lx1QfYhwfSwJO2lI1CfXh3fTxWOijm0HfWh9fUyxOHhqypfXiAfUz9Nsf2xBfYh9fT0tNWeivofah4fS1GNFd1uqfchzfR1QM4douJffhzfR1S
					MzdzuBfhh3fR1LM1eUuTfih9fR00M+fQvFfih/fR0CNOgowZfhh9fRy0NmiWyCffh3fRxVOFkGznfdhxfRwHOklX0x]],
				["LowerArm.L"] = [[
					fMhXfQe6+oW1gMfKhafQe9/JYxf4fIhifOfR/xcaflfHhqfLfw/+g0fbfHhufIgS/nk5fgfIhufFgt/An1fwfJhqfDg9+lpVgEfMhmfChD+hpggWfOhmfBg+
					+zolgifRhpfBgw/RmsgnfShtfCgb/vj5gnfShufFgB//gWgkfShpfIfo/ycegifQhifMfT/OZEgffPhafPfC+rW/gZ]],
				["UpperArm.R"] = [[
					gihzfR1SzLiVuCggh1fR1PzNh/uHgfh6fR1CzHhRuogeh+fR0fy7gIvrgfh/fRzeynejxMggh6fRyFyLcwy3gih0fRwqxrbM0RgkhufRvwxQaU1GgnhufSvx
					xHab1PgohzfTwsxSbj0pgph6fUyExrdXzbgph/fUzayHfTx1gph/fU0Yygg5wSgnh7fT08yzh5vFglh1fS1NzCiVuX]],
				["LowerArm.R"] = [[
					gzhmfBhBBYW1gdgwhnfBg4A/YQglgvhrfCgmAfamgnguhufEgOAGdzglguhsfGf1AEhmgjgvhmfKfdAelWghgwhefNfKBGoMgdgyhYfQe9BcpXgTg1hYfQe6
					BLodgDg3hefPfFAhllfug5hmfNffAEhafeg5htfKgCAKdDfcg5hvfHghAtZefng4hsfEg2BQXQf6g1hofChBBgWcgO]],
				Tail1 = [[
					gAhmgrclhAhG/xgBhngqb2gyhC/sgChsgqbngdgw/rgChwgqcCgEgW/vgDhwgqc1fpf5/1gChugqdefRfe/4gChpgqdjfBfJ/3gBhmgrc/e9e8/0f/hmgqcM
					fFe6/uf+hpgqbqfXfG/rf+hugqbwfvfc/sf9hwgqcagKf4/yf+hvgqdNgkgV/3f+hsgqdmg5gt/4f/hngqdVhDg//2]],
				Tail2 = [[
					gChvhVa2i7hJ/agDhzhUZWhxhF/OgDh4hUYggXgz/FgCh6hUY3e6gV/KgCh5hVaMdpfz/XgAh1hVbncwfX/gf/hwhVcLcZfF/if+huhVbhcte6/ff9hwhVaE
					dne3/Uf9h1hUYze7fC/If9h5hUYigYfb/Gf+h6hVZdhwf8/Qf/h3hVa9i3gc/dgAhyhVcDjhgz/igChvhVcAjihC/h]],
				Tail3 = [[
					gKh9h9aJlchO+9gHiFh8YGjwhH+wgDiLh7Wfhdgz+ff/iNh8WXe9gP+ff7iJh9Xzcpfl+vf4iBh+Z4a3fE+9f2h7h/bNZ8e0/Bf2h7h+a5aFex+/f4iBh9ZJ
					bTe1+3f7iIh7XKdWfB+nf/iNh7WNfzfe+cgDiMh8W7iQgG+mgGiFh+Y2kVgu+3gKh9h+atlvhG/AgLh6h+bRmJhO/A]],
				Tail4 = [[
					gXiNikY/n9hl+IgQiaihWzmRhR99gGikifUijfg09pf9imifTrgLgI9hfzieiiUxc3fQ9xfriRikXHaDeg+HfmiIilZMYNeM+NfmiJikZkXueT+LfsiTiiYA
					Yuel+Ef1igigVkbCe89zf/imieT3eJff9igIijigT/hhgT9ngRiYijV4kphL99gYiLilYTnChu+MgaiHilZooOhz+M]],
				Tail5 = [[
					grigjFX4p+iJ9NgfiyjCWBoxhi9DgOjBi+TbmCg58xf9jFi+R1iUgF8lfsi7jCSOeQfB8zfdipjGUZacd/9NfTibjHW7Xjde9YfSiajGYGWGdo9RfaiojEXJ
					WaeK9Jfpi7jAUtYcey87f6jFi9Sbbwff8pgMjBi/Rwfugb8pgciyjETJjvhi9BgpigjHVunKiX9VgviYjHXxpZii9V]],
				["UpperLeg.L"] = [[
					fag6gO2ddQgg2nfZg8gR4GdRfk02fYhBgT6/dPenw6fXhGgU+OdOddpxfVhIgU/kdicQimfVhHgT/sd9cNfdfUhDgR/zd6dQfqfUhAgP/xdferiXfVg/gN/b
					c5fvlFfXhCgL+wcZgnoAfYhFgJ9ZcHhYr6fZhHgJ72cChzvIfahFgJ6mcGh2xPfbhAgK5icUhmy2fbg7gM4LcthI0p]],
				["LowerLeg.L"] = [[
					fXgbgOhVfVfm/9fVgegMdjgVfO/4fTgmgFdehhfP/2fQg1f7iti7f2/vfOhEf3q/kHg89vfNhIf2xFkLhw6qfPhEfz0VjMh04bfSg7fx1jhwha3ifUg2fwzy
					gahH5HfWgzfwwSfVg37gfYgwfztxeggp81fZgtf4rueAgg9sfZgpf8pDd4gT+nfZgjgBlmeJgA/cfYgegHiherfx/3]],
				["Foot.L"] = [[
					fWgZgs80e6ght2fWgjgq8UfzgHu5fWgrgj76g8fevlfWgwgY7oiMewv7fWgxgN7ejReHv8fWgugB7ljjd/vsfWgnf579i1edvNfWgef08hhgfQuZfWgZf381
					gOf5t3fWgZf/80fNgYt2fWgZgG8yecgwt1fWgZgO8wd/g+t1fWgZgV8wd1hDt0fWgZgd8wd+g/t1fWgZgl8yeXgzt1]],
				["Toe.L"] = [[
					fWgNgj/7fNg6htfWgWgh/3f3gLi3fWgegb/wgrfKjqfWgjgR/ohieAkFfWgkgF/fiSdAkJfWghf6/figcyj4fWgbfw/qiCdfjSfWgSfr/3hGeuiUfWgNfu/8
					gKf1htfWgNf1/7fagqhtfWgNf9/5e2hThtfWgNgE/3ehhrhtfWgNgM/2eZhzhtfWgNgU/3eghshtfWgNgb/5eyhXht]],
				["UpperLeg.R"] = [[
					grg/gO/iixgnkngqhAgL/LjZf2mSgphEgK+Jjye+p+gnhGgJ8nj9eXtqgmhGgJ7Lj9eJwTglhDgJ6Fj0eRyDglg9gL46jheoztgmg6gN3WjDfL1ogmg6gQ3J
					ivf+16gog+gS5Ziwg6zQgphEgT8tizh7tsgqhHgU/LirjPlzgrhIgT/qiOj9ghgshFgS/viBjXfOgshBgQ/1iSiEgu]],
				["LowerLeg.R"] = [[
					gtg3fx1tfAe13cgrg1fwx8gKfB6dgpgyfxu6hIfR8Rgogvf2sxhzfc9Rgngsf6qgiHfm+Jgngmf/nYiCf2/EgngggEj6hogJ/tgogcgLhnhBgV/7gqgcgOfE
					gMgo/+gsghgJc8fHg2/0gugtgAfZd0gj/6gxg9f4m4cZfo/CgzhHf2ucbtek8LgyhHf1zBcPeJ5YgwhAfy1JdheX30]],
				["Foot.R"] = [[
					gqgZfz80fOgYt2gqgZf781gUf2t3gqgZgC8zhOfbt2gqgZgK8xh1fIt1gqgZgS8wiJe+t0gqgZgZ8wiIe+t0gqgZgh8xh4fGt1gqgZgo8zhYfWt2gqgegs8j
					grfquagqgngn8GfqgMvSgqguge7wecg5vzgqgxgT7idOhnv+gqgwgH7fcdiDv2gqgrf97vcth2vfgqgjf28OdzhKu2]],
				["Toe.R"] = [[
					gqgNfq/7fbgphtgqgNfx/8gPfvhtgqgNf5/6g5fAhtgqgNgB/4hXefhtgqgNgI/2hlePhtgqgNgQ/2hlePhtgqgNgX/4hYedhtgqgNgf/6hBe3htgqgSgj/5
					ggfbiVgqgbgf/0fwgTjTgqghgW/se6hbj6gqgkgL/jeEijkKgqgjf//edhjQkDgqgef1/jdri+jogqgWft/xeah7i2]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAhsgY/+gAgAhMgAhcgY/8fye2hMgAhggY/7fseXhMgAhvgY/8fye2hMgAhsgY/+gAgAhMgAhcgY/8gOhKhMgAhggY/7gUhphMgAhvgY/8gOhKhM]],
				Spine1 = [[
					gAhqgJANgAgAjcf/hbgJAKgXhIirf+hfgJAMghhmi2f/hugJAPgZhHjngAhqgJANgAgAjcgBhbgJAKfpe4irgChfgJAMffeai2gBhugJAPfne5jn]],
				Spine2 = [[
					gAhxfrA/gAgAnzf9hgfrAqgfhFmTf7hkfrAwgthhmof9h1frBGgjhDoIgAhxfrA/gAgAnzgDhgfrAqfhe7mTgFhkfrAwfTefmogDh1frBGfde9oI]],
				Neck1 = [[
					gAh5fdFYgAgAxvf8hnfcD0gyg5vFf6hrfcELhIhPvrf8h9fdFyg4gzySgAh5fdFYgAgAxvgEhnfcD0fOfHvFgGhrfcELe4exvrgEh9fdFyfIfNyS]],
				Neck2 = [[
					gAiVfRH4gAgA1Af7iAfLF/g5gyykf5iFfMGahShFzHf8iafTIWg+gr1ggAiVfRH4gAgA1AgFiAfLF/fHfOykgHiFfMGaeue7zHgEiafTIWfCfV1g]],
				Head = [[
					gAiwfNAQgAgAj3f7iafCAHgVgjiVf5iffFAJgfgwiqf8i1fQATgbghkNgAiwfNAQgAgAj3gFiafCAHfrfdiVgHiffFAJfhfQiqgEi1fQATflffkN]],
				Jaw = [[
					gAi4ek/4gAgAipf5ieeY/Uf2fZmdf3ikeb/efvfJlof7i+en/7fsfahzgAi4ek/4gAgAipgHieeY/UgKgnmdgJikeb/egRg3logFi+en/7gUgmhz]],
				Crest = [[
					gAj6flSvgAgA9Hf9jmfSTHf9hZ9Pf8jrfWSqh7d+88f+j/fpTYf1hQ9XgAj6flUzgAgA99gDjmfSRrgIen8kgEjrfWSqeFiC88gCj/fpU2gHew99]],
				["UpperArm.L"] = [[
					fch1fRsLPCnT3GfXhifTo8RGpJ5QfVhnfUpyRHoY5NfXh6fUtBPimG3Xfch1fRsLPCnT3GfhhhfOogPdqM39fjhlfNpOO3p63Xfhh4fPs0OHna2A]],
				["LowerArm.L"] = [[
					fMhgfVgAAHdqgAfIhPfef0AIiRhLfGhUfffsAFhPhpfHhlfXfnAOcohIfMhgfVgAAHdqgAfRhOfXgMAIiRe1fThRfUgUAFhPeXfShjfQgZAOcoe4]],
				["UpperArm.R"] = [[
					gkh1fRsLw+Yt3GgfhhfOogwjV039gdhlfNpOxJWG3Xgfh4fPs0x5Ym2Agkh1fRsLw+Yt3GgphifTo8u6W35QgrhnfUpyu5Xo5Ngph6fUtBweZ63X]],
				["LowerArm.R"] = [[
					g0hgfVgA/5iWgAgvhOfXgM/4dve1gthRfUgU/7exeXguhjfQgZ/yjYe4g0hgfVgA/5iWgAg4hPfef0/4dvhLg6hUfffs/7exhpg5hlfXfn/yjYhI]],
				Tail1 = [[
					gAhwgqdCgtf6/2gBhhgqbpgnf8/sgChkgqb3gKf//ugBhzgqdQfngE/3gAhwgqdCfTgG/2f/hhgqbpfZgE/sf+hkgqb3f2gB/uf/hzgqdQgZf8/3]],
				Tail2 = [[
					gCh4hVdQiFf1/zgDhshUasg7f8/igChvhUaIfNgB/cgAh6hVcsd+gF/wf+h4hVdQd7gL/zf9hshUasfFgE/if+hvhUaIgzf//cgAh6hVcsiCf7/w]],
				Tail3 = [[
					gIh/h/eBjvf2/tgGh7h9bIiAf6/jgAh/h9ZMfFgA/Pf7iDh/cDctf9/kf4h/h/eBcRgK/tf6h7h9bIeAgG/jgAh/h9ZMg7gA/PgFiDh/cDjTgD/k]],
				Tail4 = [[
					gSiEipdnlOgJ/egLiIimbbjlf9/df+iRikYQf0f//CfyiOioabcLft/RfuiEipdnayf3/ef1iIimbbcbgD/dgCiRikYQgMgB/CgOiOioabj1gT/R]],
				Tail5 = [[
					ggiLjScvmGgi/OgViUjPb6lMgJ/Tf9iljLYShNgE/BfoidjQZHcgfn/CfgiLjScvZ6fe/OfriUjPb6a0f3/TgDiljLYSezf8/BgYidjQZHjggZ/C]],
				["UpperLeg.L"] = [[
					fXhEgS0Ndqgg4rfWg1gVuidFdX8OfWg5gWFNirnUvpfWhIgVAJh4hye5fXhEgSAOiqgCdqfZg0gPATkMfyfLfZg3gOGSjmeWNafZhGgPRrh5eLDi]],
				["LowerLeg.L"] = [[
					fUgmgYbwgpfv/sfPgdgmGYlAfOyefNhTgKGiZqemNyfThGf3EadvfhQAfXg/f0AHgLgNdlfZgyfxQjhrgSEDfYgagFfShCf2ADfXgughY9gufmA0]],
				["Foot.L"] = [[
					fWgug18DgPf4vYfWg5gc4js2YluLfWg4f/6/mYcVvhfWgsfo8CiKe1vNfWg7fX/QfTf5mxfWgZgB8xeEg7t1fWgZgi8zeugnt2fWghg87vfFgiv5]],
				["Toe.L"] = [[
					fWghgt/zgLfyjafWgsgV8GpAUOjpfWgrf4+4kfaKj9fWgffg/uhjeGjRfWg0fJ/dfUgLaPfWgNf4/3elhmhtfWgNgZ/6fEhEhtfWgUg1/ufWg2kA]],
				["UpperLeg.R"] = [[
					gphEgS/yiqgCiWgng0gP/tkMfyg1gng3gO5ujmeWymgnhGgPuVh5eL8egphEgS0NiWfg4rgqg1gVuii7ip8Ogqg5gWFNdVYsvpgqhIgVAJeIeOe5]],
				["LowerLeg.R"] = [[
					gpg/f0/5gLgNibgngyfxvdhrgS79gogagFguhCf2/9gpgughnDgufm/MgsgmgYbwfXgR/sgxgdgmGYbAgyyegzhTgKGimWhaNygthGf3EaiRgfQA]],
				["Foot.R"] = [[
					gqg7fX/QgtgHmxgqgZgB8xh8fFt1gqgZgi8zhSfZt2gqghg87vg7fev5gqgug18DfxgIvYgqg5gc4jTKnbuLgqg4f/6/Zojrvhgqgsfo8Cd2hLvN]],
				["Toe.R"] = [[
					gqg0fJAjfUgLlxgqgNf4AJelhmeTgqgNgZAGfEhEeTgqgUg1ASfWg2cAgqghgtANgLfycmgqgsgVD6pAUOcXgqgrf4BIkfaKcDgqgffgAShjeGcv]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAhvgYAHgAgAicgAhsgbAJgAgAi0gAhjghAPgAgAjugAhbgoAXgAgAksgAhWgsAcgAgAlMgAhygFABgAgAgrgAiAftAFgAgAd/gAiAftAFgAgAd/gAiAftAF
					gAgAd/gAh/fwAEgAgAeSgAh7f7ABgAgAfcgAh1gKACgAgAg+gAhwgVAGgAgAiJgAhvgYAHgAgAicgAhvgYAHgAgAicgAhvgYAHgAgAic]],
				Spine1 = [[
					gAhxgJAvgAgAmugAhugMAygAgAm8gAhngSA6gAgAnfgAhfgZBDgAgAoDgAhbgdBIgAgAoWgAhzf2AcgAgAlKgAh+feALgAgAjJgAh+feALgAgAjJgAh+feAL
					gAgAjJgAh9fhAMgAgAjYgAh6fsAUgAgAkVgAh2f7AggAgAljgAhygGArgAgAmfgAhxgJAvgAgAmugAhxgJAvgAgAmugAhxgJAvgAgAmu]],
				Spine2 = [[
					gAh+ftB3gAgAqtgAh7fwB5gAgAqxgAh1f3B9gAgAq8gAhuf/CBgAgArIgAhqgDCDgAgArOgAh9fZBbgAgApYgAiEfABDgAgAoCgAiEfABDgAgAoCgAiEfABD
					gAgAoCgAiEfDBGgAgAoOgAiCfPBSgAgAo7gAiAfeBkgAgAp1gAh+fqBzgAgAqigAh+ftB3gAgAqtgAh+ftB3gAgAqtgAh+ftB3gAgAqt]],
				Neck1 = [[
					gAiIfhFMgAgAxbgAiGfkFmgAgAyDgAh/frGrgAgAzigAh5fzH6gAgA1DgAh1f3ImgAgA1zgAiGfMEAgAgAvdgAiMeyCJgAgAregAiMeyCJgAgAregAiMeyCJ
					gAgAregAiMe1CUgAgAr5gAiLfBDAgAgAtggAiKfREDgAgAvjgAiIfdE8gAgAxDgAiIfhFMgAgAxbgAiIfhFMgAgAxbgAiIfhFMgAgAxb]],
				Neck2 = [[
					gAikfUG7gAgAz3gAiifYHmgAgA0rgAidfjJVgAgA2kgAiXfuLVgAgA4agAiUf0McgAgA5UgAige7FXgAgAxtgAihebCpgAgAssgAihebCpgAgAssgAihebCp
					gAgAssgAihefC4gAgAtNgAiietD2gAgAvLgAikfBFUgAgAxogAikfQGlgAgAzbgAikfUG7gAgAz3gAikfUG7gAgAz3gAikfUG7gAgAz3]],
				Head = [[
					gAi/fOAFgAgAh4gAi9fUAMgAgAjXgAi4fjAygAgAm/gAiyfzB4gAgAqvgAiuf7CngAgAsogAi5exACgAgAg+gAi1eIAYgAgAbNgAi1eIAYgAgAbNgAi1eIAY
					gAgAbNgAi2eNAUgAgAbpgAi5eeAIgAgAdZgAi9e2ABgAgAfrgAi/fJADgAgAhcgAi/fOAFgAgAh4gAi/fOAFgAgAh4gAi/fOAFgAgAh4]],
				Jaw = [[
					gAjCek/8gAgAhogAjEeq/+gAgAg3gAjJe8/+gAgAe4gAjLfR/zgAgAchgAjMfd/qgAgAbegAi5eG8PgAgAvCgAimdh8/gAgAtigAimdh+egAgApvgAimdh+J
					gAgAqsgAiodk+1gAgAoggAiwd1/agAgAmGgAi6eM/wgAgAj1gAjAef/7gAgAiFgAjCek/8gAgAhogAjCek/8gAgAhogAjCek/8gAgAho]],
				Crest = [[
					gAkMfcRFgAgA8TgAkIfpTDfGho9MgAj9gJXhfXg9+0gAjrgobVgwfI/ogAjgg3cRhWeu/ugAkGe6QSgAgA73gAkAd2MFfihz49gAkAd2M7fwhI5pgAkAd2M7
					gQe45pgAkCd8McggeN5PgAkHeWNRgAgA57gAkLe5PxfShu7ggAkMfVSRfihD83gAkMfcSrgfe99DgAkMfcRtg1eW8jgAkMfcRFgAgA8T]],
				["UpperArm.L"] = [[
					fciHfU0UNigAwafciEfX07NIeXvDfch+fe2AMyaJrpfch3fm2fNdVkoEfch0fq2eOQTNmPfciDe/25NaaorLfciIem3ZN+cArofciIem3ZN+cArofciIem3Z
					N+cArofciIep3ON6cRr9fciIe12gNvdUtRfciHfF1cNleru6fciHfR0jNifvwHfciHfU0UNigAwafciHfU0UNigAwafciHfU0UNigAwa]],
				["LowerArm.L"] = [[
					fMh1fIgAABgAgAfMh1fIfQAPcZgBfKh3fNdbCiT1gLfIh4fVbhHhL7gjfHh4faaiLBIgg0fLh7eterAeazgdfMh+eTgAAJiygAfMh+eTgAAJiygAfMh+eTgA
					AJiygAfMh9eXgAAIimgAfMh7ekgAAFh4gAfMh4e2gAACg7gAfMh2fEgAABgMgAfMh1fIgAABgAgAfMh1fIgAABgAgAfMh1fIgAABgAgA]],
				["UpperArm.R"] = [[
					gkiHfU0UyegAwagkiEfX07y4hpvDgkh+fe2AzOl3rpgkh3fm2fyjqcoEgkh0fq2exwszmPgkiDe/25ymlYrLgkiIem3ZyCkArogkiIem3ZyCkArogkiIem3Z
					yCkArogkiIep3OyGjvr9gkiIe12gyRistRgkiHfF1cybhVu6gkiHfR0jyegRwHgkiHfU0UyegAwagkiHfU0UyegAwagkiHfU0UyegAwa]],
				["LowerArm.R"] = [[
					g0h1fIgA//gAgAg0h1fIfQ/xjngBg2h3fNdb9esLgLg4h4fVbh4f0Fgjg5h4faai0/3gg0g1h7eter/ilNgdg0h+eTgA/3dOgAg0h+eTgA/3dOgAg0h+eTgA
					/3dOgAg0h9eXgA/4dagAg0h7ekgA/7eIgAg0h4e2gA/+fFgAg0h2fEgA//f0gAg0h1fIgA//gAgAg0h1fIgA//gAgAg0h1fIgA//gAgA]],
				Tail1 = [[
					gAhvgrfPgAgA/+gAhrgtfTgAgA/+gAhig0fcgAgA//gAhYg6fmgAgA//gAhTg+frgAgA//gAh0gYcVgAgA/xgAiFf/azfYgF/jgAiFf/byfdgD/tgAiFf/by
					gjf9/tgAiEgCcKhRf6/ugAh+gNddhGf+/3gAh2gce0gMgA/+gAhxgofkfvf///gAhvgrfZf6gA//gAhvgrfPgAgA/+gAhvgrfPgAgA/+]],
				Tail2 = [[
					gAhxhWdogAgA/5gAhthZdYgAgA/4gAhkhfcwgAgA/0gAhZhmcGgAgA/wgAhUhpbwgAgA/tgAh+hCZngAgA/Wf+iTgoZNevgF/Pf/iRgpbMe6gC/mgBiRgpbM
					hGf+/mgDiOgsboijf8/lgDiFg4dFiMgD/ygBh6hIeQgYgC/8f/hyhTelfdf9/9gAhxhWd7fzf//7gAhxhWdogAgA/5gAhxhWdogAgA/5]],
				Tail3 = [[
					gAh4iBcrgAgA/0gAh0iEcHgAgA/wgAhsiKavgAgA/jgAhkiQZRgAgA/RgAhfiTYhgAgA/GgAiPhqXlgAgA+3f7ilhQYTeGgE+/f8iehSbPeYgA/mgEiehSbP
					hogA/mgKiahVbxj0gC/egJiNhjdXjRgK/tgCh+hzeWglgD/8f+h2h/eQfMf6/7f/h2iBdIftf+/3gAh4iBcrgAgA/0gAh4iBcrgAgA/0]],
				Tail4 = [[
					gAiBisbJgAgA/ngAh/iuaSgAgA/egAh6izYKgAgA/BgAh2i4V9gAgA+XgAhzi6U0gAgA9+gAiliQVBgAgA+Df2i6h2W1ddf++if3iqh8aud1f6/egJiqh8au
					iLgG/egVilh+bXlDgS/PgSiUiNdEkUgb/jgDiDied3gwgH/6f8h6iqdWe7f1/3f+h+isbwfmf8/tgAiBisbJgAgA/ngAiBisbJgAgA/n]],
				Tail5 = [[
					gAiOjVZ4gAgA/ZgAiOjXYugAgA/JgAiPjZV5gAgA+WgAiQjbS/gAgA9OgAiQjbRggAgA8hgAjBixSygAgA9IfvjSiZVoc1f1+Ffxi5ikaddTfx/ZgPi5ikad
					itgP/ZgiiyimbOmRgn+/gdici2dClXgv/ZgFiJjJdog8gL/4f5iCjVcserfu/yf9iKjWaofgf6/igAiOjVZ4gAgA/ZgAiOjVZ4gAgA/Z]],
				["UpperLeg.L"] = [[
					fXhKgJ7SdmgAwhfXhHgL8Ldcf2u8fXg/gP94dJffrDfXg4gU/Jc4fFmhfXg0gX/kcwe2j0fXhLf729eDgf2MfXhYfpzJecg05kfXhYfpzJecg05kfXhYfpzJ
					ecg05kfXhXfrzVebgz5bfXhTf00Peagw4ufXhOf/3ZeFge1vfXhKgH6pdrgGxjfXhKgJ7SdmgAwhfXhKgJ7SdmgAwhfXhKgJ7SdmgAwh]],
				["LowerLeg.L"] = [[
					fVgvf7sygdgA9UfVguf6r9gigD9rfVgsf4qugqgI+IfUgsf4qtgtgK+IfUgtf5rXgsgL95fVgtf6rngRf29zfWg7fyscgCfw9efWg7fyscgCfw9efWg7fysc
					gCfw9efWg6fzsqgCfw9YfWg1f6tsgDfw86fVgwf8thgOf28/fVgvf7stgbf+9XfVgvf7sygdgA9UfVgvf7sygdgA9UfVgvf7sygdgA9U]],
				["Foot.L"] = [[
					fWgZgQ81gAgAt3fWgZgQ81gFf+t3fWgZgQ81gNf6t3fWgZgQ81gRf4t3fWgZgQ81gQf4t3fWgZgQ81fzgGt3fWgmgH6YfogQyFfWgmgH6YfogQyFfWgmgH6Y
					fogQyFfWgkgI6vfogQxjfWgegN79fngOvifWgZgQ81fwgIt3fWgZgQ81f+gBt3fWgZgQ81gAgAt3fWgZgQ81gAgAt3fWgZgQ81gAgAt3]],
				["Toe.L"] = [[
					fWgNgG/8gAgAhtfWgNgG/8gEf8htfWgNgG/8gKf1htfWgNgG/8gMfyhtfWgNgG/8gMfzhtfWgNgG/8f2gLhtfWgYgB/TfwgYmjfWgYgB/TfwgYmjfWgYgB/T
					fwgYmjfWgWgC/bfwgYl7fWgRgF/yfugXjmfWgNgG/8f0gNhtfWgNgG/8f+gChtfWgNgG/8gAgAhtfWgNgG/8gAgAhtfWgNgG/8gAgAht]],
				["UpperLeg.R"] = [[
					gphKgJ7SiagAwhgphHgL8LikgKu8gpg/gP94i3ghrDgpg4gU/JjIg7mhgpg0gX/kjQhKj0gphLf7+mjKgpoygphYfp/XjihrbCgphYfp/XjihrbCgphYfp/X
					jihrbCgphXfr/ijhhmcUgphTf0/ujYhKiFgphOf/+Ti/gjpygphKgH8DijgHvLgphKgJ7SiagAwhgphKgJ7SiagAwhgphKgJ7SiagAwh]],
				["LowerLeg.R"] = [[
					grgvf7syfjgA9Ugrguf6r9fef99rgrgsf4qufWf4+Igsgsf4qtfTf2+Igsgtf5rXfUf195grg8fhqmfXf1+LgrhifN06f2fx4NgrhifN06f2fx4NgrhifN06
					f2fx4NgrhefOzxfxfw5JgrhPfWvkfifu78grg9fmscfbf09egrgxf3scfgf99egrgvf7syfjgA9Ugrgvf7syfjgA9Ugrgvf7syfjgA9U]],
				["Foot.R"] = [[
					gqgZgQ81gAgAt3gqgZgQ81f7gCt3gqgZgQ81fzgGt3gqgZgQ81fvgIt3gqgZgQ81fwgIt3gqgpf4+ufwgFo5gqhEfR/XgGgBZvgqhEfR/XgGgBZvgqhEfR/X
					gGgBZvgqhBfV/pgCgAbSgqg2fm/7f2gBiGgqgnf7+gf0gEpogqgcgL9Jf9gCtMgqgZgQ81gAgAt3gqgZgQ81gAgAt3gqgZgQ81gAgAt3]],
				["Toe.R"] = [[
					gqgNgG/8gAgAhtgqgNgG/8f8gEhtgqgNgG/8f2gLhtgqgNgG/8f0gOhtgqgNgG/8f0gNhtgqghfs/yfzgKcagqhKfD6jgGf/OKgqhKfD6jgGf/OKgqhKfD6j
					gGf/OKgqhGfH7ZgCf/Pfgqg0fX+Rf3gFVqgqgffv/3f2gIdLgqgRgC/+f9gDg+gqgNgG/8gAgAhtgqgNgG/8gAgAhtgqgNgG/8gAgAht]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhvgYAHgAgAicgAhtgYAFgAgAiCgAhngYACgAgAhGgAhjgYABgAgAgVgAhkgYABgAgAgegAhugYAJgAgAi2gAhzgYAZgAgAk4gAh0gYAcgAgAlNgAh0gYAc
					gAgAlNgAh0gYAcgAgAlNgAh0gYAcgAgAlNgAh0gYAcgAgAlNgAh0gYAcgAgAlNgAh0gYAcgAgAlNgAh0gYAcgAgAlNgAh0gYAcgAgAlNgAh0gYAcgAgAlNgA
					h0gYAcgAgAlKgAhygYATgAgAkMgAhwgYAJgAgAi4gAhvgYAHgAgAicgAhvgYAHgAgAicgAhvgYAHgAgAic]],
				Spine1 = [[
					gAhxgJAvgAgAmugAhvgJAngAgAmKgAhpgJAZgAgAk5gAhkgJAQgAgAj3gAhkgJARgAgAkDgAhwgJA3gAgAnSgAh4gKBogAgAqCgAh5gKBygAgAqfgAh5gKBy
					gAgAqfgAh5gKBygAgAqfgAh5gKBygAgAqfgAh5gKBygAgAqfgAh5gKBygAgAqfgAh5gKBygAgAqfgAh5gKBygAgAqfgAh5gKBygAgAqfgAh5gKBygAgAqfgA
					h5gKBwgAgAqagAh2gJBWgAgApHgAhzgJA3gAgAnVgAhxgJAvgAgAmugAhxgJAvgAgAmugAhxgJAvgAgAmu]],
				Spine2 = [[
					gAh+ftB3gAgAqtgAh6ftBogAgAqBgAhyfsBKgAgAocgAhrfrA1gAgAnKgAhsfrA4gAgAnYgAh+fuCHgAgAragAiKfxDngAgAuwgAiMfyD6gAgAvSgAiMfyD6
					gAgAvSgAiMfyD6gAgAvSgAiMfyD6gAgAvSgAiMfyD6gAgAvSgAiMfyD6gAgAvSgAiMfyD6gAgAvSgAiMfyD6gAgAvSgAiMfyD6gAgAvSgAiMfyD6gAgAvSgA
					iLfyD3gAgAvMgAiHfwDEgAgAtogAiAfuCIgAgArcgAh+ftB3gAgAqtgAh+ftB3gAgAqtgAh+ftB3gAgAqt]],
				Neck1 = [[
					gAiIfhFMgAgAxbgAiEfgEXgAgAwGgAh6feCxgAgAs+gAhyfdBugAgAqUgAhzfdB5gAgAqzgAiJfiFogAgAyGgAiXfoJ3gAgA3FgAiZfpKngAgA3ygAiZfpKn
					gAgA3ygAiZfpKngAgA3ygAiZfpKngAgA3ygAiZfpKngAgA3ygAiZfpKngAgA3ygAiZfpKngAgA3ygAiZfpKngAgA3ygAiZfpKngAgA3ygAiZfpKngAgA3ygA
					iZfpKfgAgA3qgAiTfmIagAgA1ngAiLfiF7gAgAyhgAiIfhFMgAgAxbgAiIfhFMgAgAxbgAiIfhFMgAgAxb]],
				Neck2 = [[
					gAikfUG7gAgAz3gAiffRFsgAgAyMgAiRfJDUgAgAuJgAiFfEB2gAgAqpgAiHfFCFgAgArSgAilfXHmgAgA0rgAi2fpOFgAgA6ggAi4fsPPgAgA7PgAi4fsPP
					gAgA7PgAi4fsPPgAgA7PgAi4fsPPgAgA7PgAi4fsPPgAgA7PgAi4fsPPgAgA7PgAi4fsPPgAgA7PgAi4fsPPgAgA7PgAi4fsPPgAgA7PgAi4fsPPgAgA7PgA
					i4fsPCgAgA7HgAiyfjL4gAgA43gAiofYIEgAgA1NgAikfUG7gAgAz3gAikfUG7gAgAz3gAikfUG7gAgAz3]],
				Head = [[
					gAi/fOAFgAgAh4gAi4fHACgAgAe4gAime5BAgAgAYKgAiWevCzgAgAS8gAiZexCbgAgAT2gAjAfSAOgAfpjngAjPfzEQgXfJv4gAjQf4EefOhxwKgAjQf4FK
					gQfgxZgAjQf4Fegresx0gAjQf4EgfShowPgAjQf4E/gAgAxIgAjQf4Flg0ebx9gAjQf4ElfZhWwZgAjQf4E1fxggw3gAjQf4Fpg5eSyBgAjQf4Esfkg9wngA
					jQf4Ehflg9wVgAjNfpCkgWe1sdgAjDfUAUgAgGkYgAi/fOAFgAgAh4gAi/fOAFgAgAh4gAi/fOAFgAgAh4]],
				Jaw = [[
					gAjCek/8gAgAhogAized/mgAgAk8gAiReU9mgAgAsJgAh1eU6wgAgAxigAh6eU7VgAgAwogBjIeo/of6gWkygCjzfc/8fSgmeqf7j0fi/7hke3f8gBj2fl/9
					fjgTeigEj2fn/5ewgzeAf7j0fi/8hce9f3gAj2fl/+gAgAe2gFj3fn/3egg9d1f8j0fj/9hNfJfsf/j1fk/+gdfsfKgFj3fn/2eXhCdvf9j1fj/+g3fZfcf9
					j0fi/+g1fZffgDjpfK/9fQg+fLgAjNer/9gBf7hPgAjCek/8gAgAhogAjCek/8gAgAhogAjCek/8gAgAho]],
				Crest = [[
					gAkMfcQ1gAgA8KgAkGfGOpfShw6zgAjteYKIfpid3NgAjNd4G8gFhXz1gAjUd9Hpf/fT0ugAkLfoUEgxd19lf/jzg5fvhSd5/5gCjyg/fShshM/6gAjrhCg4
					ekgR/8f/jphCiLdIgI/ygCjyg/hjfnik/2gAjthBi5gAgA/3f+johDjkgjde/rgBjxg/ggi4fu/2gAjuhAgQhcft/9f+johDhgeaet/5gBjwhAgmeviL/4gB
					jxg+hUe0iN/3f/j/gkdjeofr/3gAkNfuVPgve2+FgAkMfcSKhFdx8ugAkMfcRPg4eU8UgAkMfcQ1gAgA8K]],
				["UpperArm.L"] = [[
					fciHfU0UNigAwafciCfT0eNif0wNfch3fS01NjfavwfchtfR1HNjfFvYfchvfR1ENjfIvcfciIfV1hMdZwryfciZfb02OpQBlnfcicfd0bP3N7kXfcicfd0b
					P3N7kXfcicfd0bP3N7kXfcicfd0bP3N7kXfcicfd0bP3N7kXfcicfd0bP3N7kXfcicfd0bP3N7kXfcicfd0bP3N7kXfcicfd0bP3N7kXfcicfd0bP3N7kXfc
					ibfc0gPpORkkfciUfZ1ZM+UgoafciKfV09MwdRuXfciHfU0UNigAwafciHfU0UNigAwafciHfU0UNigAwa]],
				["LowerArm.L"] = [[
					fMh1fIgAABgAgAfMhxfGgAABfsgAfMhmfEgAACe/gAfMhefDgAAEebgAfMhffDgAADeggAfJiBfEcwBwWJgdfGihfQX/KRKHivfFimfUXDNBIIjifFimfUXD
					NBIIjifFimfUXDNBIIjifFimfUXDNBIIjifFimfUXDNBIIjifFimfUXDNBIIjifFimfUXDNBIIjifFimfUXDNBIIjifFimfUXDNBIIjifFimfUXDNBIIjifF
					ilfTXNMjIcjZfHiWfJaDFiPJhcfLh9fGeeAYbggGfMh1fIgAABgAgAfMh1fIgAABgAgAfMh1fIgAABgAgA]],
				["UpperArm.R"] = [[
					gkiHfU0UyegAwagkiCfT0eyegMwNgkh3fS01ydgmvwgkhtfR1Hydg7vYgkhvfR1Eydg4vcgkiIfV1hzjmQrygkiZfb02xXv/lngkicfd0bwJyFkXgkicfd0b
					wJyFkXgkicfd0bwJyFkXgkicfd0bwJyFkXgkicfd0bwJyFkXgkicfd0bwJyFkXgkicfd0bwJyFkXgkicfd0bwJyFkXgkicfd0bwJyFkXgkicfd0bwJyFkXgk
					ibfc0gwXxvkkgkiUfZ1ZzCrgoagkiKfV09zQivuXgkiHfU0UyegAwagkiHfU0UyegAwagkiHfU0UyegAwa]],
				["LowerArm.R"] = [[
					g0h1fIgA//gAgAg0hxfGgA//gUgAg0hmfEgA/+hBgAg0hefDgA/8hlgAg0hffDgA/9hggAg3iBfEcw+Qp3gdg6ihfQX/1v15ivg7imfUXDy/34jig7imfUXD
					y/34jig7imfUXDy/34jig7imfUXDy/34jig7imfUXDy/34jig7imfUXDy/34jig7imfUXDy/34jig7imfUXDy/34jig7imfUXDy/34jig7imfUXDy/34jig7
					ilfTXNzd3kjZg5iWfJaD6ew3hcg1h9fGee/okggGg0h1fIgA//gAgAg0h1fIgA//gAgAg0h1fIgA//gAgA]],
				Tail1 = [[
					gAhvgrfPgAgA/+gAhtgrfEgAgA/+gAhpgresgAgA/9gAhmgqeZgAgA/8gAhmgrecgAgA/9gAhtgrfSf0gA/+gAhwgqf7fif///gAhxgqgBhAgD/+gAhxgqgB
					fuf///gAhxgqgBfPf+/+gAhxgqgBg6gD/+gAhxgqgBgAgA//gAhxgqgBfGf9/+gAhxgqgBgxgC/+gAhxgqgBgSgB//gAhxgqgBfAf9/+gAhxgqgBgjgC//gA
					hxgqgAgigC//gAhwgrfufYf+//gAhvgrfXgDgA//gAhvgrfPgAgA/+gAhvgrfPgAgA/+gAhvgrfPgAgA/+]],
				Tail2 = [[
					gAhxhWdogAgA/5gAhwhWdtgAgA/6gAhthWd5gAgA/7gAhqhWeDgAgA/7gAhqhWeBgAgA/7gAhvhWdUf4f//4f/hxhWcjerf5/xgDhxhWcahngM/vf/hxhWca
					gLf+/yf+hxhWcaeQf2/vgChxhWcahSgK/wgAhxhWcagsgC/yf+hxhWcaeJf0/vgChxhWcag3gI/xgBhxhWcahJgF/xf9hxhWcaeNf0/vgBhxhWcagXgF/ygB
					hxhWcbhfgI/wf+hxhWc2e/f6/0gAhxhWdbf+gA/4gAhxhWdogAgA/5gAhxhWdogAgA/5gAhxhWdogAgA/5]],
				Tail3 = [[
					gAh4iBcrgAgA/0gAh2iBdAgAgA/2gAhyiBdwgAgA/6gAhviBeXgAgA/8gAhwiBeQgAgA/8f/h2iBcBgKgA/vf7h6iAZ4d7fx/VgHh6iAZfhggV/SgAh6iAZf
					hIf//Tf5h6iAZfdkfr/OgGh6iAZfg6gS/TgCh6iAZfhsgG/Rf5h6iAZfdtfp/PgEh6iAZfgPgN/UgEh6iAZfiHgM/Pf4h6iAZfeBfp/QgCh6iAZffigH/UgF
					h6iAZjiVgR/Pf8h5iBaqfDf1/hgAh4iBcLf1f//wgAh4iBcrgAgA/0gAh4iBcrgAgA/0gAh4iBcrgAgA/0]],
				Tail4 = [[
					gAiBisbJgAgA/ngAh+isbugAgA/tgAh4isdCgAgA/2gAh0iseGgAgA/7gAh1isd6gAgA/7gAiBiraKgfgE/cf2iKioWrdsfj+ggLiMioWEgugg+ZgDiMioWE
					iCgH+VfziMinWEdmfa+TgIiMioWEf+gZ+agGiMioWEicgR+TfziMinWEeBfZ+VgFiMioWEfOgP+ZgJiMioWEipga+SfziMinWEemfb+XgBiMioWEeigE+XgL
					iLioWLilgh+Vf5iIiqX6fifx+8gAiCiraVfsf9/egAiBisbJgAgA/ngAiBisbJgAgA/ngAiBisbJgAgA/n]],
				Tail5 = [[
					gAiOjVZ4gAgA/ZgAiKjWatgAgA/jgAiAjXcjgAgA/zgAh5jXeFgAgA/7gAh6jXdzgAgA/6gBiRjUYjgsgH/GfwijjMT0eIfV9ggMiljLTAfqgn9OgIiljLTA
					ibgT9IftiljKTAeWfJ9LgIiljLTAe+ga9NgMiljLTAihgh9HfuiljKTAe8fK9MgDiljLTAeXgM9LgQiljKTAibgs9HfwiljKTAfofQ9Of9iljLTAd5f89JgS
					iljKTJiGgy9Nf4idjQVegMfx+Nf/iSjUYxfof8/KgAiOjVZ4gAgA/ZgAiOjVZ4gAgA/ZgAiOjVZ4gAgA/Z]],
				["UpperLeg.L"] = [[
					fXhKgJ7SdmgAwhfXhHgK7/dcf5vSfXhBgN9QdIfrsofXg8gO+Ec5fgqefXg9gO97c7fiq3fXhIgI7Udlf+wefXhQgE3+eNgZ1HfXhRgD3NeVge18fXhRgD3N
					eVge18fXhRgD3NeVge18fXhRgD3NeVge18fXhRgD3NeVge18fXhRgD3NeVge18fXhRgD3NeVge18fXhRgD3NeVge18fXhRgD3NeVge18fXhRgD3NeVge18fX
					hRgD3WeTgd1zfXhOgF5KeAgRzqfXhLgI61dsgExRfXhKgJ7SdmgAwhfXhKgJ7SdmgAwhfXhKgJ7SdmgAwh]],
				["LowerLeg.L"] = [[
					fVgvf7sygdgA9UfVguf6r2ghgD9tfVgrf4qMgngH+UfUgqf3pQgqgI+nfVgqf3pZgqgI+kfVguf6sEgfgA9nfWgygAvlgLf078fWgzgBwVgHfx7gfWgzgBwV
					gHfx7gfWgzgBwVgHfx7gfWgzgBwVgHfx7gfWgzgBwVgHfx7gfWgzgBwVgHfx7gfWgzgBwVgHfx7gfWgzgBwVgHfx7gfWgzgBwVgHfx7gfWgzgBwVgHfx7gfW
					gzgBwMgIfx7lfVgxf+udgSf48ifVgvf8tFgbf+9MfVgvf7sygdgA9UfVgvf7sygdgA9UfVgvf7sygdgA9U]],
				["Foot.L"] = [[
					fWgZgQ81gAgAt3fWgZgQ81gEf+t3fWgZgQ81gLf7t3fWgZgQ81gOf5t3fWgZgQ81gOf5t3fWgZgQ81gCf/t3fWgZgQ81ftgJt3fWgZgQ81fogLt3fWgZgQ81
					fogLt3fWgZgQ81fogLt3fWgZgQ81fogLt3fWgZgQ81fogLt3fWgZgQ81fogLt3fWgZgQ81fogLt3fWgZgQ81fogLt3fWgZgQ81fogLt3fWgZgQ81fogLt3fW
					gZgQ81fpgLt3fWgZgQ81f0gGt3fWgZgQ81f+gBt3fWgZgQ81gAgAt3fWgZgQ81gAgAt3fWgZgQ81gAgAt3]],
				["Toe.L"] = [[
					fWgNgG/8gAgAhtfWgNgG/8gDf8htfWgNgG/8gIf3htfWgNgG/8gLf0htfWgNgG/8gKf0htfWgNgG/8gBf/htfWgNgG/8fygQhtfWgNgG/8fvgUhtfWgNgG/8
					fvgUhtfWgNgG/8fvgUhtfWgNgG/8fvgUhtfWgNgG/8fvgUhtfWgNgG/8fvgUhtfWgNgG/8fvgUhtfWgNgG/8fvgUhtfWgNgG/8fvgUhtfWgNgG/8fvgUhtfW
					gNgG/8fvgThtfWgNgG/8f3gKhtfWgNgG/8f+gChtfWgNgG/8gAgAhtfWgNgG/8gAgAhtfWgNgG/8gAgAht]],
				["UpperLeg.R"] = [[
					gphKgJ7SiagAwhgphHgK7/ikgHvSgphBgN9Qi4gVsogpg8gO+EjHggqegpg9gO97jFgeq3gphIgI7UibgCwegphQgE3+hzfn1HgphRgD3Nhrfi18gphRgD3N
					hrfi18gphRgD3Nhrfi18gphRgD3Nhrfi18gphRgD3Nhrfi18gphRgD3Nhrfi18gphRgD3Nhrfi18gphRgD3Nhrfi18gphRgD3Nhrfi18gphRgD3Nhrfi18gp
					hRgD3Whtfj1zgphOgF5KiAfvzqgphLgI61iUf8xRgphKgJ7SiagAwhgphKgJ7SiagAwhgphKgJ7SiagAwh]],
				["LowerLeg.R"] = [[
					grgvf7syfjgA9Ugrguf6r2fff99tgrgrf4qMfZf5+Ugsgqf3pQfWf4+ngrgqf3pZfWf4+kgrguf6sEfhgA9ngqgygAvlf1gM78gqgzgBwVf5gP7ggqgzgBwV
					f5gP7ggqgzgBwVf5gP7ggqgzgBwVf5gP7ggqgzgBwVf5gP7ggqgzgBwVf5gP7ggqgzgBwVf5gP7ggqgzgBwVf5gP7ggqgzgBwVf5gP7ggqgzgBwVf5gP7ggq
					gzgBwMf4gP7lgrgxf+udfugI8igrgvf8tFflgC9Mgrgvf7syfjgA9Ugrgvf7syfjgA9Ugrgvf7syfjgA9U]],
				["Foot.R"] = [[
					gqgZgQ81gAgAt3gqgZgQ81f8gCt3gqgZgQ81f1gFt3gqgZgQ81fygHt3gqgZgQ81fygHt3gqgZgQ81f+gBt3gqgZgQ81gTf3t3gqgZgQ81gYf1t3gqgZgQ81
					gYf1t3gqgZgQ81gYf1t3gqgZgQ81gYf1t3gqgZgQ81gYf1t3gqgZgQ81gYf1t3gqgZgQ81gYf1t3gqgZgQ81gYf1t3gqgZgQ81gYf1t3gqgZgQ81gYf1t3gq
					gZgQ81gXf1t3gqgZgQ81gMf6t3gqgZgQ81gCf/t3gqgZgQ81gAgAt3gqgZgQ81gAgAt3gqgZgQ81gAgAt3]],
				["Toe.R"] = [[
					gqgNgG/8gAgAhtgqgNgG/8f9gEhtgqgNgG/8f4gJhtgqgNgG/8f1gMhtgqgNgG/8f2gMhtgqgNgG/8f/gBhtgqgNgG/8gOfwhtgqgNgG/8gRfshtgqgNgG/8
					gRfshtgqgNgG/8gRfshtgqgNgG/8gRfshtgqgNgG/8gRfshtgqgNgG/8gRfshtgqgNgG/8gRfshtgqgNgG/8gRfshtgqgNgG/8gRfshtgqgNgG/8gRfshtgq
					gNgG/8gRfthtgqgNgG/8gJf2htgqgNgG/8gCf+htgqgNgG/8gAgAhtgqgNgG/8gAgAhtgqgNgG/8gAgAht]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAhvgYAHgAgAicgAhtgYAGgEgriOgAhegYAEgNhlgxgAiCgYAOgFhmjNgAifgYAYgAg/kugAiqgYAcgAgAlNgAifgYAYgAfBkugAiCgYAOf7eajNgAhegYAE
					fzebgwgAhlgYAEf5fBhbgAhjgYADgAgAhPgAiQgYASgCg/j/gAimgYAdf/hmlCgAiogYAef/hmlIgAiWgYAUgBg/kRgAhugYAFgAgAh+gAhjgYADf5fBhPgA
					hvgYAJf4eaiagAhvgYAIf6e0icgAhvgYAHf/fwicgAhvgYAHgAgAic]],
				Spine1 = [[
					gAhxgJAvgAgAmuf/hvgJArgJgrmaf+hfgJAWgYhjkPf+iFgJA/gUhknpf/ikgKBggKg+pngAivgKBsgAgAqOgBikgKBgf2fCpngCiFgJA/fsecnpgChegJAW
					foedkPgBhmgJAdfyfDlOgAhkgJAagAgAk8f/iUgJBPgLg+orf+irgKBqgQhlp/f+itgKBtgPhlqHf/iagJBVgLg+pCgAhwgJAlgAgAl+gBhkgJAbfyfDk8gC
					hxgJAxfrecmrgBhxgJAwfwe1mugAhxgJAvf9fxmugAhxgJAvgAgAmu]],
				Spine2 = [[
					gAh+ftB3gAgAqtf+h7ftBugPgpqSf8hnfsA8gihgnff8iTfuCTghhgrxf9i1fxDTgTg8uFgAjBfxDpgAgAuzgDi1fxDTftfEuFgEiTfuCTffegrxgEhnfsA8
					feegnegDhwfsBQfrfFowgAhtfsBJgAgAoZf9ikfvCzgUg8tAf8i9fxDjgfhhuhf8i/fxDngfhhuqf9iqfwC/gUg8tbgAh7ftBhgAgApsgDhtfsBKfrfFoZgE
					h+ftB4feegqogDh+ftB4fme4qsgBh+ftB3f7fxqtgAh+ftB3gAgAqt]],
				Neck1 = [[
					gAiIfhFMgAgAxbf+iFfgEzgXglw0f6hufdCmgxhZsff7iefjGRg4hVy7f9jCfnI5glgz2GgAjOfoJzgAgA3BgDjCfnI5fbfN2GgFiefjGRfIery7gGhufdCm
					fPensegDh4feDgfgfKuegAh1feDNgAgAt7f9iwflHmgkg00pf7jKfoJfg8hT2qf7jMfoJrg8hT22f9i3flIGgkg01OgAiEffEPgAgAv5gDh1feDOfgfKt7gG
					iIfhFKfJeqxVgEiIfhFNfWfAxbgBiIfhFMf3fzxbgAiIfhFMgAgAxb]],
				Neck2 = [[
					gAikfUG7gAgAz3f9igfSGfgbgizSf4iEfID5g6hUvMf5i7faIJhAhP1Qf8jhflLEgpgw4KgAjtfpMCgAgA4/gEjhflLEfXfQ4KgHi7faIJfAex1QgIiEfID4
					fGesvKgEiRfME+fbfNxFgAiNfLEogAgAwjf8jOfgJogogw21f6jpfoLthDhN4qf6jrfpL5hDhN41f8jVfiKLgpgw3XgAiffQF2gAgAybgFiNfLEpfbfNwjgH
					ikfUG5fBewzwgFikfUG8fRfEz2gBikfUG7f2f0z3gAikfUG7gAgAz3]],
				Head = [[
					gAi/fOAFgAgAh4f9i7fLALefgvivf3ibe5AUcciMevf5jWfWA0chhUmEf8j8fpBsd7ghp9gAkIfvCBgAgArJgEj8fpBsiFffp9gHjWfWA0jfesmEgJibe5AU
					jkd0etgFiqfBAIiNezgygAime+ABgAgAgGf8jqfgBJd4gqoGf6kDftCFcrgvqzf6kGfvCLcrgtrCf8jxfkBWd5gno1gAi5fHAGgAgAiUgFime+AHiNexgKgH
					i+fOAhjgedkKgGi/fOAXiqezjpgBi/fOAHgkfvicgAi/fOAFgAgAh4]],
				Jaw = [[
					gAjCek/8gAgAhof7jAeh/RhrfvmhfyiVeP9EkHfRssf0jkeu/QjugDlrf6kTfG/3iIgShvgAkifO//gAgAghgGkTfG/3d4fuhvgMjkeu/QcSf9lrgOiVeP9D
					b5gwsugIiqeW9/dhgUq2gAikeU91gAgArif5j8e6/tiOgKjrf2kcfL/zjYghg0f2kffN/zjXgjgjf5kFe//yiMgNi6gAi9ec+kgAgApcgIikeU9xdggXrcgM
					jHel+2cLgKnkgJjGel/RdHgWmEgCjDek/1fagLjKgAjCek/8gAgAho]],
				Crest = [[
					gAkMfcQtgAgA8Gf2kGfdSIewjp8kfmjne5QBfVmp65fqkbf4XSfJkb+cf0k3gba1gig0/jgAlAgma/h6d+/egMk3gbYwhxcx+8gWkbf4UqgOdD9wgajne5Ot
					e9eT61gPj3fKRpfHfl8kgAjzfDRmgAgA8jfzkqgLYmg6gW/Gftk7gjaIgxhV/aftk8glZmfdim/OfzkvgRXneWjW+pgAkFfXSZevif80gPjzfERYfVfA8bgX
					kGfnVdgobb92gRkJflUPheay9QgEkLffRyhIda8hgAkMfcQtgAgA8G]],
				["UpperArm.L"] = [[
					fciHfU0UNigAwafZiDfVz4LyXcsEfVhqfVzOM+RtpUfVidfa0wSoLuhmfYjDfc06QNONkcfcjQfc0OM/SOn6fgjEfY10PyPejUfjidfT2mScN4gKfjhpfO0v
					MVTynjfgh1fQyiKRW8rMfchyfS0QNBSLn3fYiwfa1JTaLkgbfWjLff0rQoNlkdfWjOffzqNhRZpCfYi3fb0zP0Okk7fciCfT1lRONwiYfghyfQ0tM1S0nTfj
					iGfRzbKuWAppfhiHfS1qMhVZn5fdiHfU1QMgcQtTfciHfU0UNigAwa]],
				["LowerArm.L"] = [[
					fMh1fIgAABgAgAfEh/fGZ+DXTKg+e+hvfKXrEBT0kse/ipfVbIFgRAogfBjNfTY6HVN1lxfGjWfOX3IgL8hhfLjOfMZ0HFNYkGfOiqfJcgE0QjlwfOhue+ZO
					DmTHiCfLh0fAYPE8Q2fCfGh3fEYiEKSnjmfBi9fVbsGAP0oKe+jVfXYuHtNmmZe+jSfUXFIdMeizfBjBfSYyG6OZlnfGiNfKbVEJSqm1fLh3fBZBEDSaixfO
					iHfAYkF7PEfDfNiIfAasC9TyhTfMh8fDd+AMdegMfMh1fIgAABgAgA]],
				["UpperArm.R"] = [[
					gkiHfU0UyegAwaghiDfS2Tyfrvm2gdhpfO0vzrsOnigdidfTzz03qyo6ggjEfY10wOwijUgkjQfc1rrb0ieogojDfc06vzxzkcgridfayvzysqq/grhqfVzO
					zDuSpVgoh1fU06vRydjegkhyfS0Qy/t1n3ggiwfW0A0Lr/oggdjMfY2IwFwYiogdjPfY2krnzYd/ggi4fX1uwnwKjzgkiCfTyk1HqTrSgohyfUzxyyueoZgr
					iGfY0suGzxiagpiHfX0zy2sMpVgliHfV01zZjiuLgkiHfU0UyegAwa]],
				["LowerArm.R"] = [[
					g0h1fIgA//gAgAg1iGfBbj+Yoiixgyhue+ZO8Zs6iCgyigfCYk5bx7fWg1jOfMZ047yokGg6jefXck5Kx8nig/jNfTY64ryLlxhCiffOW95axGh+hChvfKXr
					7/sLksg/iAfMar8CsWnig6h3fEYi72tZjmg1i0fHYS4sy0gMgyjXfMaK4szJjrgzjdfRdN5iyDmIg1jBfKZt5VyEj8g6iCfFXu6mvugFg/h4fIYE7ttKkahB
					iSfSa17Dt+oVg/iIfJZz84ryjeg3h7fFd3/ZlygWg0h1fIgA//gAgA]],
				Tail1 = [[
					gAhvgrfPgAgA/+gBhtgrfMjrgD/xgChggqe7mofi/RgCiBgrfPjPgP/0gBidgqfVd3fp/6gAingqfXaxe+/if/idgqfVb8fV/tf+iBgrfPgEgA/+f+hggqe6
					jffw/yf/hmgrfCjWf5/zgAhkgre/gAgA/+gBiOgrfTcrfm/zgCijgqfWckfX/ygCilgqfWf8f///gBiUgqfUkFgk/tgAhugrfGlVgA/if/hkgrfAiKf6/5f+
					hvgrfPcwf7/0f/hvgrfPbAf4/lgAhvgrfPerf+/9gAhvgrfPgAgA/+]],
				Tail2 = [[
					gAhxhWdogAgA/5gLhvhVdylJgU/fgThihSe0rpft9xgLiDhVc6nIg3/Bf7ifhVbidZfU/kfyiphUbMWhdk+Ef0ifhUbnXTeK+af+iDhWc2e8f5/0gIhjhVes
					nBf3/LgIhohVeVolgN+xgAhnhWeWisgG/1f4iQhVcOanfB/Sf5ilhVbVXmeJ+dgCinhWbMcAfW/XgMiWhVb+kihE/ZgOhxhUd7p0gf+XgFhnhWeanBgI/Lf1
					hxhVdpd5f2/1fxhxhUdsYafc+/f8hxhWdodWfz/ygAhxhWdogAgA/5]],
				Tail3 = [[
					gAh4iBcrgAgA/0gYh1h+dBkugZ/fgxhlhyfavNf78JgdiMh7bZsDhw9Of1irh/YefrfT/Ffbi3h1X2UZcQ8bfeish4YzSlc078f7iLiBbLbXfe/Rgahmh8fI
					oDf4+8gehth6eZtIgs9HgHhriBebnSgj/Hfqibh9Z2bTer/Afkiyh4YLUJc38ff3i0h+X6XAeX9kgYihh9ZViPhN/Lgoh3h3dbsRg79agXhrh9emsEgo9lfw
					h3iAcuhggL/yfdh4h6czXqfI+sf1h4iActcJfm/lgAh4iBcrgAgA/0]],
				Tail4 = [[
					gAiBisbJgAgA/nglh+inboiigQ/lhVhmiKfZwkgT7Xg6iZiZZpwYjL6jf0i/ilVEkHfq9yfBjOiQULVDax7IfAjAiQV2PTbC41fviYioZJWeeg9ugvhoiie1
					mZfn/Ug/hyiXd+v1he7sgahwineFsShl9cfeisijW9enel+nfJjJiTUtTLbT6ofijJidUjSkc66fgdizikWTdwg/+YhGh+iVcTsKhY9Ug2hviceXv2hi7tf0
					iAiqbUmghA+9fIiBifbRY8e7+0friBiqbNbafT/SgAiBisbJgAgA/n]],
				Tail5 = [[
					gAiOjVZ4gAgA/ZgsiJjQagfLfq/gh8hoiefRvkf/78heisiqYUzBkm4Hf/jajFSapVgb7aetjvilQ/YXZh6aehjdibTYOOZN2ZfYirjIXsRzdO7ShAhrjKen
					iiek/1hkh4itdnwMh07bg5h2jGeJwOiu7XfcjDjIUmjofA9pewjnilRnU6Z25mfGjniuRzP9bS3RgWjMjHT7YbgR8ohkiJizbNplhO+Hhbh1iyeUxjiK6mgE
					iNjQaYrXiP9Se2iOjEZ8b6fN/IffiOjRZ9bVfG/DgAiOjVZ4gAgA/Z]],
				["UpperLeg.L"] = [[
					fXhKgJ7SdmgAwhfXhHgM8Ld2fTu/fWg3gR+1dgdqn0fWhdgM7KeveywzfWh8gH+je+gJpafXiHgD+LeAgUqbfYh9gC+Kc4gaqMfZhdgE5Mc1hczafZg2gJ9i
					b8hGrkfYg+gJ87cigktMfXg8gM9tc9fjrefWhsgI4xe1fr0OfWiDgI+hfpgCpkfWiFgH+ffqgCpsfWhygI+ve6gIoyfXhIgK8sdQfwt3fYg8gK9OcdgisgfZ
					hJgF6bcphWxqfZhKgG6mc5hBxefYhKgJ7KddgOwufXhKgJ7SdmgAwh]],
				["LowerLeg.L"] = [[
					fVgvf7sygdgA9UfUguf7sWhQf69ffRgpf3pSixgV+ffThCf+ugiBff8cfWhrfu+hhTfcpffXh1fr+Nf7fqqgfXhqfq+Qeff4qSfXhAf8tDezgb9LfYgifzk5
					evf1/lfXgnf1n7fhgG+/fUgof2oWgsgG+4fVhOgCwyhFfa7NfWhxfv+biGfSpofWhzfv+YiFfSpwfWhifu+thVfdo3fVgwf4qCgngE+XfXgmf1nRfhgD/JfY
					gtf6rsezgY9wfXguf6sEfNgS9nfVgvf7sogNgE9ZfVgvf7sygdgA9U]],
				["Foot.L"] = [[
					fWgZgQ81gAgAt3fWgZgQ80grfrt2fWgZgQ8wiIe/t0fWgqgQ8EhPfVvRfWhafVxOj7Z75+fWhifUxRf1f767fWhYfSuIaep36YfWgqgQ8EeqgvvRfWgZgQ8y
					edgvt1fWgZgQ80fOgYt2fWgZgQ81gQf5t3fWg0gQ7ugcfwv9fWhgfWyFlJY344fWhifWyQk9ZL44fWhSfVwKlMXl5yfWgfgQ8kgKf7uZfWgZgQ80fNgYt2fW
					gZgQ8zepgqt2fWgZgQ80e/gft2fWgZgQ81fygHt3fWgZgQ81gAgAt3]],
				["Toe.L"] = [[
					fWgNgG/8gAgAhtfWgNgG/8ggfchtfWgNgG/3hkePhtfWgdgH/yg5e6jTfWhMfb54hSY4xXfWhVfa6Tf0gAyOfWhMfa3LesrOy7fWgdgH/yfChNjTfWgNgG/5
					e3hShtfWgNgG/7fbgphtfWgNgG/8gLfzhtfWgngI/ugUfmkFfWhSfb6QiAXcwBfWhUfb6ah9Xyv9fWhFfb41hjWPxlfWgTgH/6gHf3iTfWgNgG/7fbgqhtfW
					gNgG/6fAhIhtfWgNgG/7fQg2htfWgNgG/8f2gLhtfWgNgG/8gAgAht]],
				["UpperLeg.R"] = [[
					gphKgJ7SiagAwhgohHgI7fi7fgwGgng3gJ9hkEe6rmgnhdgE5MjLekzagoh9gC+KjIfmqMgpiHgD+LiAfsqbgqh8gH+jhCf3pagqhdgM7KhRhOwzgqg3gS+1
					igiWnygqg+gO9zidhXrRgpg8gM9tjDgdregohsgD2/iZe12FgniEgA92jvfdq2gniGf/90jufcq+gohzgD+XjNfqpjgphIgK8siwgQt3gqg8gP+Fijhdqfgq
					hJgO8GhghavKgqhKgM73hthCvmgphKgK7aiRgOwVgphKgJ7SiagAwh]],
				["LowerLeg.R"] = [[
					grgvf7syfjgA9Ugqgtf5rXgOf295gogifzk7hQgL/lgphAf8tDhNfl9Lgphqfq+QhhgIqSgph1fr+NgFgWqggqhrfu+hetgkpfgthCf+ugd/gh8cgvgpf3pR
					dOfr+fgugrf4p+eLf6+Vgsgof2oWfUf6+4gphOgCwrgxfz7Sgohxfo9+iUf+q8gohzfo97iTf+rFgphhfq+dhmgKppgrgwf4qCfZf8+Xgugqf3pfeIf3+fgu
					gwf9tvd1gW8zgtgwf9tleRgR86grgvf8s8fSgE9Pgrgvf7syfjgA9U]],
				["Foot.R"] = [[
					gqgZgQ81gAgAt3gqgZgQ81gjfvt3gqgZgQ8yhjfRt1gqgqgQ8EhWfRvRgqhYfSuIliWJ6YgqhifUxRgLgF67gqhafVxOcFmF5+gqgqgQ8EexgrvRgqgZgQ8w
					d4hBt0gqgZgQ8zexgmt2gqgZgQ81fwgHt3gqg0gQ7thDfav9gqhefRtjm6Tv5VgqhffSuAmfUy5rgqhQfRqopRNa14gqgfgQ8kf2gFuZgqgZgQ8zetgot2gq
					gZgQ8zemgrt2gqgZgQ80e9ggt2gqgZgQ81fygHt3gqgZgQ81gAgAt3]],
				["Toe.R"] = [[
					gqgNgG/8gAgAhtgqgNgG/8gafjhtgqgNgG/5hJeuhtgqgdgH/yg+ezjTgqhMfa3LhUUyy7gqhVfa6TgMgAyOgqhMfb54eunIxXgqgdgH/yfHhGjTgqgNgG/3
					ebhxhtgqgNgG/6fGhBhtgqgNgG/8f1gNhtgqgngI/tgvfDkFgqhRfa2PhqSCyLgqhTfa2zhrTKyUgqhEfbyOhZLRwHgqgTgH/6f5gJiTgqgNgG/6fDhEhtgq
					gNgG/6e9hLhtgqgNgG/7fPg3htgqgNgG/8f2gLhtgqgNgG/8gAgAht]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhvgYAHgAgAicgAhvgmAVgAgAkdgAhvgwAigAgAlwgAhvgtAegAgFlagAhvgoAYgAflkvgAhvgjAVf9d/kAgAhvggAQf7eTjhgAhvgfANf/frjagAhvgdAK
					gBgOjEgAh0gZALh6f4ingAh7gYAxmefgiZgAh4gYChsKfEiQgAhqgYFFxGesiEgAhcgYHJz+eeh6gAhagYHd0Xech4gAhhgYGgzJeih9gAhigYGUy6ejh+gA
					hbgYHR0Jedh5gAhZgYHk0gech4gAhZgYHk0gech4gAhZgYHk0gech4gAhZgYHk0gech4gAhZgYHk0gech4]],
				Spine1 = [[
					gAhxgJAvgAgAmugAhzgYBOgAgAosgAh1ghBmgAgAp8gAh0gfBggBgFpngAh0gaBTf8flo+gChzgVBKfreAoQgChygRBBfteVnygAhygQA9f8fsnrgAhygNA3
					gDgOnVgAh2gKA1h4fom4gBh9gJBYmWepmlgCh6gJDGr7dcmOgChrgJFnwxcZlrgChcgJHozlbzlPgChagJH8z+btlLgChhgJG/yxb+lYgChjgJG0yicBlagC
					hbgJHwzwbwlOgChZgJID0GbrlKgChZgJID0GbrlKgChZgJID0GbrlKgChZgJID0GbrlKgChZgJID0GbrlK]],
				Spine2 = [[
					gAh+ftB3gAgAqtgAiDf+CmgAgAsmgAiHgJDJgAgAtygAiGgGC/gBgFtegBiEgACuf5fms2gFiCf6CffbeEsKgFiBf2CSffeYrtgBiBf1CNf6fsrnf/iAfyCF
					gFgNrSgCiDfvB+h3fhq3gGiIftChmReSqlgKiDftERrycvqOgNhxftG1wibWptgPhfftI4zSagpTgPhcftJMzpaYpOgOhlftIPyfawpbgOhmftIDyQa0pdgP
					heftJAzcadpRgPhbftJTzyaWpNgPhbftJTzyaWpNgPhbftJTzyaWpNgPhbftJTzyaWpNgPhbftJTzyaWpN]],
				Neck1 = [[
					gAiIfhFMgAgAxbgAiPfzH1gAgA08gAiTf+JxgAgA3AgAiSf7JPgDgE2egBiQf1IPfxfp1agHiNfvHQe5eU0KgGiMfrGlfEelzWgBiLfpGZf1fvzKf/iKfmF8
					gIgLyjgDiNfiFVhie3xjgKiSfhFWlOcMwdgRiKfhGYp6ZGu2gWh2fhIGuFWos3gYhjfhJiwkVVragYhffhJxw6VKrMgYhpfhJFv2Vsr2gYhrfhI9vpVzr+gY
					hhfhJowtVQrUgYhefhJ2xCVGrHgYhefhJ2xCVGrHgYhefhJ2xCVGrHgYhefhJ2xCVGrHgYhefhJ2xCVGrH]],
				Neck2 = [[
					gAikfUG7gAgAz3gAitfuJ5gAgA3HgAiygAMBgAgA4+gAixf7LcgDgE4ggCivfyKWfvfr3igIisfpJPeveb2YgHiqfiIge8er1ogBipfgISfzfw1df/infcHy
					gJgL05gGiqfWHFhSeiz9gVirfTG6kVbHyuglidfSHkoRXHwsgviBfRIurzT/uEgyhnfRJvt9SWsHgyhjfRJ5uQSJr0gxhvfRJbtUSzstgxhyfRJVtJS8s4gy
					hmfRJzuFSRr/gyhifRJ9uWSFrtgyhifRJ9uWSFrtgyhifRJ9uWSFrtgyhifRJ9uWSFrtgyhifRJ9uWSFrt]],
				Head = [[
					gAi/fOAFgAgAh4gAjJfvBRgAgAo4gAjNgFC2gAgAtKgAjMgACYf7gDsDgCjKf0Bkgdfsp1gJjHfoBCiPeSnegHjFfgAph8eclxgBjEfeAdgYftlQf/jCfYAS
					fwgOkDgKjEfQAJh2fNiBggjDfMAvmQdif6g4ivfKCkrlcEdYhGiKfIFMv+bhanhLhsfHHPyZboYwhMhnfHHjytbrYfhKh1fHGnxtbjZThKh4fHGbxgbjZehL
					hqfHHYyibpYphMhlfHHqy0bsYZhMhlfHHqy0bsYZhMhlfHHqy0bsYZhMhlfHHqy0bsYZhMhlfHHqy0bsYZ]],
				Jaw = [[
					gAjCek/8gAgAhogAjefK//gAgAfmgAjrfo/8gAgAeTgAjofg/9gGf/epgDjhfR/+fegLfUgOjYfC/3dbhJf5gMjSe4/5dzhKgbgCjQe1/+flgPgqf+jLeu/+
					gSf1hBgMjHem/1eEgiicgljAei+1ZbhalQg9ijei8LT2hXo6hHh4ei4dPagJsPhHhWej1lNJe1uKhHhQej1JM2enuahIhgej2eNxfQtnhIhjej2uN9fYtdhH
					hTej1ZNBevuRhHhPej0/MweiughHhPej0/MweiughHhPej0/MweiughHhPej0/MweiughHhPej0/Mweiug]],
				Crest = [[
					gAkMfcR9gAgA8vgAkIgdYogAgA/IgAj8hDdIgAgA/3f/kAg5b7gAgG/ugDkGgmZmf8fd/VgQkJgRXTfndN+pgPkLgBVnfmdj+JgDkMf8VFf7fi+Ef+kNfwT8
					gEgU9ogSkQffSGgOeA8vg9kLfTQkg7ZW7MhsjpfKPQiQT+4WiLivfCOIj8P50siWiBe8NhlON1yAiXh5e8NclbNlxniTiPe+Nsk1OZy1iSiTe+NvkuOkzEiW
					h9e8NflUNux2iXh3e7NblfNgxeiXh3e7NblfNgxeiXh3e7NblfNgxeiXh3e7NblfNgxeiXh3e7NblfNgxe]],
				["UpperArm.L"] = [[
					fciHfU0UNigAwafciPfm3IN5casJfciUfy4dOfaKpJfciTfv4JOVatqAfeiQfo3dNzcNrQfliOfe2mM0eir8fjiLfa18M1fLtLfdiLfc1xNdefuQfbiJfa1Q
					NrewvTffiQfWzQMrfQwsfoiffVvmLJeIyef2ijfWrKKNbi0GgFiXfXnPKYYb1GgPiGfYk+K7WK1ZgQiEfYkrLCV11ZgMiMfYloKuW21VgLiNfYl0KrXD1UgP
					iFfYk2K+WB1ZgQiDfYkkLEVt1agQiDfYkkLEVt1agQiDfYkkLEVt1agQiDfYkkLEVt1agQiDfYkkLEVt1a]],
				["LowerArm.L"] = [[
					fMh1fIgAABgAgAfMiEfUgAAoZygAfMiOfegABqV5gAfMiLfbf/BVW6gFfPiGfUgCA0Y7flfXiBfLgHAdbKd/fVh9fJgEAPcpeTfOh8fMgBAKdBfrfLh6fMf/
					AFeGgOfNiBfKedADf0gLfSiSfNavAfhDg5fdidfSWCBvhgiTfriXfXR3DohVj9f1iMfaPWFLg2lEf2iJfbPAFbgwlOfyiQfZQFEshBkvfxiRfZQSEjhEkpf1
					iLfaPNFSg0lIf3iJfbO4FhgulRf3iJfbO4FhgulRf3iJfbO4FhgulRf3iJfbO4FhgulRf3iJfbO4FhgulR]],
				["UpperArm.R"] = [[
					gkiHfU0UyegAwagkiPfm3IyHjmsJgkiUfy4dxhl2pJgkiTfv4JxwlNp6gmiQfp3bx0kYrwgsiNfn2exQkJuRgriLfi13xhjDvJgliLfd1wyPh8uogjiJfZ1R
					yjg9vCgmiIfV1bxGejwcgqiCfT2pthZ7xDgphwfS3gowUYwGgkhWfR3OkbPlt8gehBfR2ih3M1sAgdg9fR2ahgMertgghHfR2yimNnsogghJfR22i0N2szge
					g/fR2fhtMrr4gdg8fR2XhZMWrmgdg8fR2XhZMWrmgdg8fR2XhZMWrmgdg8fR2XhZMWrmgdg8fR2XhZMWrm]],
				["LowerArm.R"] = [[
					g0h1fIgA//gAgAg0iEfUgA/YmOgAg0iOfegA+WqHgAgziLfbgB+rpGf7g2iGfXf+/MnFgbg+iAfYf5/jk2iBg8h9fUf8/xjXhtg1h8fOf//2i/gVgzh6fKgB
					/7h6fygzh0fJiR/6gMf2guhqfKnp/Ce2fcgihYfMuK8ld5ezgThBfPzf5HdFeFgJgxfR2a2ccmdjgHgufR2y2CcidegMg2fQ1l3RcvdtgNg3fQ1W3gcydwgI
					gwfR2k2RckdhgHgtfR2615cgdcgHgtfR2615cgdcgHgtfR2615cgdcgHgtfR2615cgdcgHgtfR2615cgdc]],
				Tail1 = [[
					gAhvgrfPgAgA/+gAhtg5hRgAgA/9gAhrhCikgAgA/4gAhsg/iOgIgB/6gAhsg7hjfUf8/8f+htg2g0cyfx/0f+hugygVdSf2/3gAhugxgNfff+//gAhugvf3
					gXgA//gAh0gsfdf8eG/7gAh7grfWfpZh/UgAh4grfSfSTz9jgAhqgrfFe+O36+gAhcgre5e0L/46gAhagre3eyLm4lgAhhgre9e3M05jgAhigre+e4NE5ugA
					hbgre4ezL14xgAhZgre2eyLe4egAhZgre2eyLe4egAhZgre2eyLe4egAhZgre2eyLe4egAhZgre2eyLe4e]],
				Tail2 = [[
					gAhxhWdogAgA/5gAhphkfqgAgA//gAhkhtg9gAgA/+gAhmhqgngLgC//f+hohmf8fEf3/+f1hrhgfNbmfd/rf3hthdeucSfm/vf+hthdemfTf7/8gBhvhaeP
					gfgC/8gAh1hXd5f5eF/3f/h9hWd3fdZe/Pf/h7hWdye5Tv9cf/huhWdeeaOz6zf/hghWdJeKL94sf/hehWdFeILk4Xf/hlhWdPeOMx5Wf/hmhWdRePNA5if/
					hfhWdHeJLy4jf/hdhWdEeHLb4Pf/hdhWdEeHLb4Pf/hdhWdEeHLb4Pf/hdhWdEeHLb4Pf/hdhWdEeHLb4P]],
				Tail3 = [[
					gAh4iBcrgAgA/0gAhqiQetgAgA/9gAhiiYgAgAgA//gBhkiWfqgOgD//f7hoiRe/e0fz/9fphtiKeSabfJ/cfthxiHdybTfW/jf8hxiIdpfHf4/5gDh0iGdT
					gngE/3gAh7iCdAf0eE/yf/iDiBdBfIZa/Jf+iBiBc6eQTp9Sf/h2iBcadfOu6jgAhpiAb7dFL64YgBhniAb1dCLh4CgAhuiBcFdMMt5DgAhviBcIdPM85PgA
					hpiAb5dELv4PgBhniAb0dBLZ36gBhniAb0dBLZ36gBhniAb0dBLZ36gBhniAb0dBLZ36gBhniAb0dBLZ36]],
				Tail4 = [[
					gAiBisbJgAgA/ngAhui7dKgAgA/3gAhijEeegAgA/9gBhljBeIgQgE/7f4hri9ddelfr/2fahyizczZUeo/Ffgh3iwcTaWe8/Qf6h4izcHe7fz/vgEh7ixbx
					gvgI/sgAiDitbhfyeC/nf+iLisboe7ZT+9f9iLisbgd2Te9Af/iCira6c6Oj6IgBh3iqaTcZLx31gCh1iqaMcVLZ3fgAh7iqafciMk4jgAh8iqajclMy4wgC
					h2iqaQcYLn3sgCh0iqaKcULR3XgCh0iqaKcULR3XgCh0iqaKcULR3XgCh0iqaKcULR3XgCh0iqaKcULR3X]],
				Tail5 = [[
					gAiOjVZ4gAgA/ZgAh1jmb4gAgA/ugAhmjvdLgAgA/3gChqjtc1gTgG/1f0hyjncLeWfj/tfJh8jZblYOeF+pfRiBjYbEZbef+4f3iCjda1evfu/igGiGjbag
					g3gL/ggAiPjXaTfueA/af+iXjWafesZL+vf9iYjVaXdXTR8rf/iSjTZpcMOW5ngEiJjRY6bkLn3MgFiHjRYybfLQ20gCiMjSZJbvMZ38gCiNjSZObyMn4KgE
					iIjRY3biLd3CgFiGjRYwbdLI2rgFiGjRYwbdLI2rgFiGjRYwbdLI2rgFiGjRYwbdLI2rgFiGjRYwbdLI2r]],
				["UpperLeg.L"] = [[
					fXhKgJ7SdmgAwhfXhMgT9BdnfutPfXhNgZ97dpfjrCfXhNgY9tdrfirofYhMgT9OdZgDsvfahMgM8ncjhgtzfZhLgK8OcuhTuofYhLgN8KdbgJu9fXhKgN73
					dtfuvjfThUgK7eb+e+v2fMhogJ68X+czu6fJh6gJ5jS4acs7fNh/gJ3VOWY0qwfTh8gJ1fLsYFpSfUh7gJ1NLVYApEfRh9gJ2EMdYRpufQh+gJ2PMsYVp2fT
					h7gJ1XLiYDpMfUh6gJ1GLNX+o/fUh6gJ1GLNX+o/fUh6gJ1GLNX+o/fUh6gJ1GLNX+o/fUh6gJ1GLNX+o/]],
				["LowerLeg.L"] = [[
					fVgvf7sygdgA9UfVg1f/wGgdgD7pfVg6gCyIgdgG6XfVg5gCxmghgD6tfWg2f/wjgEgP7YfZg0f5vXemg18BfYgyf5ule5gt8cfWgyf8uZgKgK8kfVgxf9t0
					gqf782fOg6f7s9fueQ9MfAhSf5sLd9aB85e2hrf3rMb4Ur7ce4h4f1p+aNP/5Le9h5f0pFZTNP3Ue+h5f0o8ZLM33Ce7h6f0pXZjOC36e7h5f0pbZoOR4Ee+
					h5f0pBZPNF3Me/h5f0o5ZIMv27e/h5f0o5ZIMv27e/h5f0o5ZIMv27e/h5f0o5ZIMv27e/h5f0o5ZIMv27]],
				["Foot.L"] = [[
					fWgZgQ81gAgAt3fWgbgO+PgAgAqafWgegN+8gAgAoIfWgdgN+xgCf8ovfWgcgN+af0gZp7fYgbgJ96fHh0rLfXgagK9mfQhisAfWgagO9jf3gTsPfWgZgQ9T
					gGfzs0fMgkgP9CeSfLtSe4g+gO8oaFdYsteohcgM7XUubYrOemhvgL5PP+Z6pmeqh0gK3dNKZNoeerh1gK3LMyZHoUeohzgL4BN+ZZo0eohzgL4LONZdo6er
					h0gK3VNAZKoaesh1gK3FMpZFoQesh1gK3FMpZFoQesh1gK3FMpZFoQesh1gK3FMpZFoQesh1gK3FMpZFoQ]],
				["Toe.L"] = [[
					fWgNgG/8gAgAhtfWgSgC/7gAgAd/fWgXgA/sgAgAbnfWgVgB/xgAf7cPfWgTgA/4f+gbdefZgRf+/5f4iBe0fYgQgA/8f6htftfWgPgD//f/gVf8fVgOgF//
					gAfygkfKgZgF/6eGf5hGezg0gE/UZhf3guehhUgC9kT0gEf2edhqgA6/O3gjfKehhyf/46L/g+ezeihzf/4lLnhCewefhxf/5kM0g1e5efhwf/5vNEgze7eh
					hzf/4xL1hAeyeihzf/4eLehEeweihzf/4eLehEeweihzf/4eLehEeweihzf/4eLehEeweihzf/4eLehEew]],
				["UpperLeg.R"] = [[
					gphKgJ7SiagAwhgphMgT9BiZgStPgphNgZ97iXgdrCgphNgX9tiagWrogphMgV9OiKgsszgqhLgW8nhVh8uHgqhKgT8Ohhhmu5gphKgP8KiPgavAgohKgM73
					ihf5vhgkhKgK75gxfHvngWhIgJ8XcldRuIgChBgJ8GW/bnrkfvg2gJ6uR1a2pDfkgsgJ5SOsawngfjgrgJ5DOQawnTfngvgJ5wPmawn9fogwgJ54P3awoGfj
					grgJ5MOgawnafigqgJ49OGaxnOfigqgJ49OGaxnOfigqgJ49OGaxnOfigqgJ49OGaxnOfigqgJ49OGaxnO]],
				["LowerLeg.R"] = [[
					grgvf7syfjgA9Ugrg1f/wGfjf97pgrg6gCyIfjf66Xgrg5gBxmfof56tgsg2gBwjfKgH7XgvgzgEvXdsgw79gugygCukd/gp8Zgsgyf+uZfQgH8kgrgxf8t0
					fwf582gjgwf6s0e0eP9PgPgxf3rsdHaA9Bf1gwf0qTbQUo7qfggsfyoxZ5P35efVgmfwnuZONE3pfTglfwnkZJMr3XfYgofxoCZaN44OfZgpfxoIZdOH4YfU
					gmfwnpZMM53hfTglfwngZHMj3QfTglfwngZHMj3QfTglfwngZHMj3QfTglfwngZHMj3QfTglfwngZHMj3Q]],
				["Foot.R"] = [[
					gqgZgQ81gAgAt3gqgbgO+PgAgAqagqgegN+8gAgAoIgqgdgN+xgCf8ovgrgbgP+af0gZp7gsgagU96fHh0rLgrgZgT9mfQhisAgqgagQ9jf3gTsPgqgZgP9T
					gGfzs0gggbgP9HeSfMtHgGgegN85aBdgsHfmgigL7yUjb0qJfOgkgJ5vPqa1oJfDgjgI3+Mvafm3fBgjgI3sMWadmsfGgkgI4iNlaknQfHgkgI4sN1amnWfC
					gjgI33MlaemyfBgjgI3mMNadmofBgjgI3mMNadmofBgjgI3mMNadmofBgjgI3mMNadmofBgjgI3mMNadmo]],
				["Toe.R"] = [[
					gqgNgG/8gAgAhtgqgSgC/7gAgAd/gqgXgA/sgAgAbngqgVgA/xgAf7cPgrgTgD/4f+gbdegtgQgI/5f4iBe0gsgPgI/8f6htftgrgPgF//f/gVf8gqgOgE//
					gAfygkgegPgF/7eGf6g6gCgUgC/VZhf/gFfggcf/9jT0gjesfGghf965O7hhdoe7ghf74xMHiUdIe6ghf74cLuicdEe+ghf85cM6iEdQe/ghf85nNJh/dTe6
					ghf74oL8iYdGe5ghf74VLmifdCe5ghf74VLmifdCe5ghf74VLmifdCe5ghf74VLmifdCe5ghf74VLmifdC]],
			},
		},
	},
}
