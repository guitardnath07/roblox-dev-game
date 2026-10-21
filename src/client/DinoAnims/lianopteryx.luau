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
					gAhjgWDggAgAuhf+hkgWDgglfzuhf9hlgWDihIfouhf7hlgWDjhjfhuhf7hkgWDkh2feuhf6hjgWDlh/fguhf7higWDlh8fouif7hhgWDkhvf1uif9hhgWDj
					hZgGuif+higWDhg8gZuigAhjgWDhgcguuhgChkgWDhf6hBuggDhlgWDhfbhRufgFhlgWDifChduegFhkgWDiewhiudgGhjgWDjeohhudgFhigWDjeqhYuegF
					hhgWDie2hJufgDhhgWDhfKg0uggChigWDgfjgbuhgAhjgWDggAgAuhf+hkgWDggdfluhf9hlgWDhg2fMugf7hlgWDihKe3uff7hkgWDjhWeouef6hjgWDjhY
					efudf7higWDihQeeudf7hhgWDig+ejuef9hhgWDhglevuff+higWDhgGe/uggAhjgWDhfkfSuhgChkgWDhfEfnuigDhlgWDjenf6uigFhlgWDkeRgLuigFhk
					gWDleEgYuigGhjgWDleBgguhgFhigWDkeKgiuhgFhhgWDjedgfuhgDhhgWDie4gYuhgChigWDgfbgNuh]],
				Spine = [[
					gAiAgBEpgAgAwkf/iBgBEpgSf9wkf/iCgBEqgjf7wlf+iCgBEqgxf7wlf9iBgBErg8f8wmf9iAgBEshCgAwnf9h/gBEshDgGwnf9h+gBEsg/gOwnf+h/gBEr
					g3gXwmf+h/gBEqgsgiwlf/iAgBEpgfgswkgAiBgBEpgRg1wigAiCgBEogEg8whgBiCgBEof4hAwggBiBgBEofvhBwggBiAgBEofqg+wggBh/gBEofog3whgB
					h+gBEofrgtwigBh+gBEpfwggwjgAh/gBEpf3gQwkgAiAgBEpgAgAwkgAiBgBEpgJfwwkf/iCgBEpgQfgwjf/iCgBEogVfTwif/iBgBEogYfJwhf/iAgBEogW
					fCwgf/h/gBEogRe/wgf/h+gBEogIfAwggAh+gBEof8fEwhgAh/gBEpfvfLwigBiAgBEpfhfUwkgCiCgBEqfUfewlgCiCgBErfJfpwmgDiCgBEsfBfywngDiB
					gBEse9f6wngDiAgBEse+gAwngDh/gBErfEgEwmgCh+gBEqfPgFwlgBh+gBEqfdgFwlgBh/gBEpfugDwk]],
				Neck1 = [[
					gAiefxFbgAgAxygAiffxFXgSf9xsf/igfxFUgjf6xnf/igfxFSgxf5xjf/iffxFQg8f6xhf+iefxFQhBf+xhf+idfxFRhDgExif+icfxFTg/gMxlf+icfxFV
					g4gVxof+idfxFYg1gpxtf+iefxFcg6hLxxf+iffxFhg/hsx0f/igfxFkg5h+x4f/igfxFmguiCx7f/iffxFogliEx9f/iefxFoggiBx/f/idfxFogeh7x/gA
					icfxFmgghwx9gAicfxFjgkhjx6gAidfxFggrhTx2gAiefxFcgzhCxxgAiffxFXgsgexsgAigfxFTgPfgxmgAigfxFQfvekxegBiffxFPfieHxZgBiefxFOfg
					eBxXgBidfxFPfbd+xYgBicfxFRfSd/xbgBicfxFUfHeDxhgCidfxFZe6eKxogCiefxFeeseUxwgCiffxFkegeex4gCigfxFpeVepx/gCigfxFseWe9yEgCif
					fxFsekfdyIgCiefxFre3f6yIgBidfxFqfFgHyHgBicfxFnfPgIyDgBicfxFjfdgGx+gAidfxFffugEx4]],
				Neck2 = [[
					gAi1foFbgAgAxygAi2foFTgSf9xmgAi2foFMgjf6xbgAi2foFHgxf6xTgAi1foFEg8f7xOf/i0foFDhCf/xNf/izfoFFhDgExPf/izfoFIg/gMxVf+izfoFO
					g4gWxdf+i0foFVg8gzxnf+i1foFehUhsxwf9i2foFphqikx3f9i2foFxhsi/x+f9i2foF2hhjEyGf9i1foF5hYjGyLf9i0foF6hTjDyNf9izfoF5hRi9yMf+
					izfoF1hSiyyIf+izfoFvhXilyCf/i0foFoheiVx5f/i1foFghmiExugAi2foFVhRhMxlgBi2foFLgPfgxagCi2fnFIfLd2xLgDi1fnFGevdGxBgDi0fnFFet
					dAw+gDizfnFHeoc9w/gDiyfnFLefc+xGgDiyfoFSeTdCxQgDizfoFbeHdJxdgDi1foFkd5dSxsgCi2foFudtddx6gCi3foF3djdoyHgCi3fpF8dreFySgBi2
					fpF7eLe8yagBi1fpF5ewfxycgAi0fpF3fFgIyZgAizfoFyfPgIyTgAizfoFrfdgHyKgAi0foFjfugEx/]],
				Neck3 = [[
					gAjGfhFbgAgAxygAjGfhFPgSf9xggAjHfgFEgjf6xQgAjHfgE9gxf6xDgAjGfgE4g8f8w7gAjFfgE3hCf/w5gAjEfgE5hDgFw8f/jDfgE+g/gNxEf/jDfgFG
					g4gWxRf+jEfhFRhEg9xgf9jGfhFhhtiNxuf8jHfhF0iWjcx4f7jHfiGBifkByDf7jHfiGJiUkGyOf7jHfiGOiLkIyWf7jFfiGPiGkFyZf7jEfiGNiEj/yXf8
					jEfiGHiFj0yRf9jEfiF+iKjnyHf+jEfhFziQjWx5f+jGfhFniZjFxqgAjGfhFVh1h7xdgCjHfgFDgPfgxOgEjHfgFBendJw3gFjGfgFBd8cGwngFjEfgFAd6
					cAwigFjDfgFCd1b9wlgFjDfgFJdsb9wugFjDfgFTdhcBw9gFjEfhFfdUcIxQgEjGfhFtdHcRxmgDjHfiF8c7cbx7gDjIfiGJcxcmyOgCjIfiGOdAdNyfgBjH
					fjGMdyecysgAjGfiGIepfoyvgAjFfiGEfFgIysgAjEfiF9fPgJyjgAjEfiFzfdgHyVgAjFfhFnfugEyF]],
				Head = [[
					gAjWfa//gAgAgngAjXfZ/+fvf4g1gBjYfZ/+fgfxg9gBjXfY/+fUfpg9gBjWfY/9fMfjg1gBjVfY/+fJfdgngAjUfY/+fLfYgVgAjUfY/+fRfTf/f/jUfZ/+
					fdfQfof+jVfZ/7fWePfTf8jWfa/se1b5fIf6jYfb/SeWZkfKf5jYfc/EeUYofOf5jYfc/GejYqfQf5jYfd/HesYufYf5jXfd/JexY0flf5jWfd/LewY7f2f6
					jVfc/MeoZEgJf7jVfc/OecZOgcf8jVfb/PeMZZguf9jWfa/Pd5Zjg9f/jXfZ/neObkg+gCjXfY/+fhgSg/gGjXfY/kg8k9hTgHjWfY/Khhm7hdgIjVfY/Jhg
					nChRgIjUfY/IhjnJg/gIjTfY/HhqnPgogHjUfZ/Gh1nTgNgHjVfa/EiCnWfzgGjWfa/DiPnWfbgFjYfb/CicnVfHgEjZfc/BionSe7gDjZfd/PiemSexgBjY
					fd/rh4j5eugAjXfd/6hMhee5f/jWfd/9g2gafNf/jVfc/+gtgVfkf/jVfc//ghgOf8gAjWfb//gRgHgT]],
				Jaw = [[
					gAjffA/fgAgAlngAjfe//Yfxf2mLgBjfe+/TfjfrmmgBjfe+/PfZfim1gAjfe+/OfSfZm4gAjee+/QfQfTmtgAjde+/VfTfOmYf/jde+/bfbfMl4f+jee//i
					fmfKlTf7jgfA/mfpeKkqf2jhfC/bffbwkHfxjjfE/BfYZZkFfvjkfF+0fgYdkGfujkfF+0ftYhkIfujjfG+1f3YmkRfujhfG+0f6YtkefvjgfF+0f3Y0kvfw
					jffF+yfvY8lCfxjefE+xfhZElVfyjefD+vfQZMlnf0jffC+te8ZTl2f5jffA/Ae/bVmQgDjfe+/SffgMmogNjfe/+ygBlDnGgSjdfA+UgLnGnVgSjdfA+VgI
					nMnNgSjcfA+YgLnUm3gSjcfA+dgTnamWgSjdfB+kghngltgRjffC+qgxnllAgQjifD+whEnnkSgPjkfE+yhRnoj/gNjlfF+zhcnnjzgLjlfF/DhdmljsgGjk
					fE/ehPkIjsgBjjfE/sg8hpj6f/jhfD/sgxgjkOf/jffD/pgpgbklf/jffC/mgegTk9gAjffB/igQgKlU]],
				Crest = [[
					gAk9fKXegAgA+1gCk+fIXOgMfy+wgEk+fGXKgXfl+vgFk+fGXRghfb+xgGk9fGXkgpfU+1gGk8fHX/gvfS+9gFk7fJYigzfV/FgEk7fMZHg2fc/OgCk7fPZs
					g3fn/WgBk9fRaMh3ft/ZgBk+fTaikRfr/OgBk/fTaompfq+1f/lAfTaknkf1+mf+lAfUabnfgE+mf8k/fUaHnZgQ+jf8k+fTZsnTgW+gf8k9fRZLnLgX+af9
					k8fOYpnEgS+Uf/k8fMYHm9gH+NgBk8fJXqm3f3+HgEk8fGXUmyfk+CgGk9fGXLkvfY+YgGk+fGXIf2fe+ugFk9fDXCa+ft+SgFk7fCXJY6f096gFk6fDXjY0
					f1+AgFk6fEYEYsf6+HgEk6fHYrYlgE+PgBk6fKZTYfgR+Xf/k8fNZ5Yagg+df8k9fQaYYXgu+if6k/fSauYVg8+lf3lAfUa3YWhH+nf2lAfWa3ZXhJ+2f3lA
					fYapb0hB/Pf5k/fXaMeUg2/Zf6k+fVZofagu/Vf7k9fTZBfhgn/Nf8k8fQYbfqgc/Ef+k9fNX5f1gP+8]],
				["Humerus.L"] = [[
					fYicfzcXGjZhx5fXief0cKGoZXx5fXiff0b7GvZQx+fXigf0brG6ZMyIfWiff0bcHIZNyXfWief1bOHXZSyqfWidf1bEHmZcy+fWicf1a9H0ZqzTfWicf1a7
					IAZ7zmfWicf1a8IIaMz2fWidf1bDIMac0BfWidf1bMIMap0GfWidf1bZIHax0GfXicf1bnH+a0z/fXibf1b2HyaxzzfXiaf1cFHkapzifXiZf1cQHUadzOfX
					iZf0cZHFaOy3fXiZf0cdG4Z+ygfYibf0ccGsZvyLfYicfzcXGjZhx5fYiefzcOGeZWxsfYiffzcDGcZPxkfYigfyb1GeZMxifYiffyboGjZMxmfYiefybdGq
					ZSxvfYidfxbUGyZbx7fZicfxbQG6ZnyKfZibfxbPHBZ1yZfZicfxbTHHaDymfZicfxbbHKaRyxfZidfxbmHLaby4fZidfxb0HJaiy6faicfycCHFaky5fZib
					fycPG/aiyzfZiafycbG4acyqfZiZfycjGxaTyefZiZfycnGqaHySfYiZfzcmGlZ6yHfYibfzchGjZtx+]],
				["Forearm.L"] = [[
					edi8ffgDV+Zp9tedi/ffgBWHZZ9sedjBfgf3WLZK9qecjCfhfkWLY99necjCfjfLWFY09iecjBfletV9Yx9debjAfmeOVxY09Zeai/fodxVlY99Ueai+fpdZ
					VYZL9ReZi9fqdIVMZc9PeZi8fqc/VEZu9PeYi8frc/VAZ+9ReYi7fqdIVAaM9VeYi5fqdZVGaU9aeYi4fodxVPaY9geZi2fneNVaaY9meZi2flesVnaU9sea
					i2fkfKVyaM9vebi3fifkV7aC9xeci5fgf4V/Z29wedi8ffgDV+Zp9tedi+fegFV4Zb9neejAfdf8VsZN9gefjBfdfrVdZB9YefjBfdfTVKY59PefjAfde3U2
					Y29Fefi/fdeaUgY488efi+feeAUMZA80eei9ffdrT6ZM8ueei8ffdcTrZb8qedi7fgdXTjZr8qedi7fgdZTgZ68seci6fgdkTlaH8yeci5fgd1TwaQ86eci4
					fgeLUBaV9Deci2fgelUXaW9Oeci1ffe/UvaT9Xeci2fffYVGaN9geci3ffftVdaD9meci5fff8VvZ39r]],
				["WingFinger1.L"] = [[
					d2jEgVo9nglb9Sd2jHgWpCn7k09Qd3jKgXo9oFkF9Wd3jNgYotn/jS9jd3jPgZoTnpih91d2jQganxnFh4+Kd1jQgbnKmXhb+fd0jRgcmjlkhO+ydzjRgcmC
					kxhS/BdyjRgclpkDhl/MdxjRgdlcjgiF/QdxjQgclcjMit/PdwjOgclpjIjY/JdwjLgcl/jVkE+/dwjIgcmdjwkr+wdxjFgbm/kXlN+edyjCganilFln+Kdz
					jBgZoCl0l292d0jAgXodmhl59kd1jCgWoynGlw9Yd2jEgVo9nglb9Sd2jHgTo/nsk59Ud2jKgSo2nokQ9ed2jMgRojnTjh9vd2jOgQoGmwi0+Ed2jPgPnimA
					iN+bd1jQgPm7lHhy+wd0jQgOmVkKhm/CdzjQgOl1jQhr/PdyjQgOleieh+/XdxjQgOlUh5ie/ZdwjPgOlWhmjG/WdvjNgOlkhmjx/PdvjLgPl7h5kc/EdwjH
					gQmZidlD+1dxjEgRm7jPlk+kdxjCgSndkKl6+QdzjAgSn9lHmG98d0jAgToZmDmF9qd1jCgUovm3l29b]],
				["WingFinger2.L"] = [[
					eViqhBtnofiB7meXishBtrozhW7heXivhCtko1gl7leWixhEtVolf17yeUizhHs7oFfI8HeRi1hKsbnZem8geOi4hNr2mmeR87eKi6hQrRlweM9VeGi8hSqx
					k9eY9qeCi9hUqakSey97eAi9hUqOj1fX+Ed+i9hVqPjngB+Fd+i6hUqcjrgt+Ad/i3hTqzkAhW90eCizhSrQkjh59ieFiuhQrxlRiV9MeJirhNsSmEin8yeN
					iohKsxm3iu8ZeRinhHtKnliq8BeUiohEtdoJib7weViqhBtnofiB7meWisg/tpolhe7meWivg/thoZg17veUixg/tQn8gK8BeRizhAs1nQfk8ZeNi1hBsUmY
					fF80eJi3hDrwlZe09PeEi5hErMkaey9neAi7hFqujgfA97d8i8hGqYixfb+Id5i8hHqPiSgA+Od4i7hHqRiGgq+Nd4i5hHqfiOhV+Hd6i2hHq2iph996d9ix
					hHrTjVie9peBithHrykOi29TeGiqhGsSlNjE86eLiohFswmNjF8gePinhDtJnJi68IeTiohCtcn7ij70]],
				["WingFinger3.L"] = [[
					eziCheyJp+fT4Ye0iDhdyMqJel4PeziGheyHqBd14TewiIhhx5podI4iesiKhmxjpBch48eniNhrxGoQcF5dehiQhxwknZb46BeaiUh3wBmjb76meUiXh7vj
					lzcN7FePiah/vNlNct7deMibiAvBk2dV7seKiaiBvBkxeB7xeLiYiAvMk9es7reOiUh+vhlZfS7ceTiPh6v8mDfw7EeZiKh2wbm1gF6legiFhxw5nsgQ6Den
					iChsxWoggQ5gesiAhmxtpNgF5AewiAhhx+ptfw4neziCheyJp+fT4YeziDhcyMp9ev4VexiGhcyGppeJ4eetiIhdx4pEdk4zeniKhhxioSdF5RehiNhlxFnV
					cv51eZiQhpwkmVcn6aeRiUhtwDlWcu69eKiXhwvmkfdE7aeFiZhyvSj1dl7veBiah0vHjdeO77eAiZh0vJjYe579eBiWh0vVjofj72eFiShzvpkLgH7leLiN
					hxwDk9gi7OeSiIhuwgl5gy6webiEhrw9m7g26NejiBhnxYn7gu5qeqiAhjxuo0ga5IeviAhgx/phf74s]],
				["Vine.L"] = [[
					d1iygU5xlMZpxFd1i1gV5ZlIZOxgd1i4gW5Ck5Yrx3d1i7gY4tkgYCyId1i9gZ4dj/XXySd0i+gb4SjcWvyUdzi/gc4Pi6WNyNdyi/ge4TidV3x/dxi/gf4f
					iHVtxsdwjAgf4yh7VwxVdwi/gg5Ih5V+w9dvi+gg5giBWVwldvi9gg54iSWzwQdvi6gf6MirXUv+dwi3ge6ajIX3vydwizgd6jjpYYvudxixgb6lkKY2vxdy
					ivga6gknZPv8dzivgY6Vk+ZhwPd0iwgW6ElLZqwod1iygU5xlMZpxFd1i1gT5clAZcxjd1i4gS5IkoZGx+d1i6gR42kGYpyTd0i8gQ4ojdYIygd0i9gQ4hiy
					Xqykdzi+gQ4iiKXSyddyi+gQ4qhpXDyOdwi/gQ45hSW/x5dvi/gQ5PhGXGxgdvi+gR5nhGXXxEdui9gR6AhSXuwpdui7gR6WhnYKwSdui5gS6oiDYnv/dvi2
					gS6zilZCvzdwizgT64jKZavvdxiwgT61jwZtvzdyiugT6rkTZ6v/dziugT6ckwZ+wSd0iwgU6IlDZ5wq]],
				["Humerus.R"] = [[
					goicfzbP4VlqzZgoidfzbj4illzQgoidfzb54wllzCgnicfycP5Alnyxgnibfycj5Pltyegniafycz5el2yLgniZfyc+5rl/x3gmiZfydC50mJxngniZfxc/
					57mTxZgniafxc159mcxRgnicfxcl56mjxPgniefxcS50moxTgniffxb85qmqxcgniffxbn5dmpxqgoiffxbU5Omlx7goiefybF4/meyPgoidfya84xmVyjgo
					icfya44lmKy1goicfza64cl+zFgoicfzbC4XlzzSgoicfzbP4VlqzZgoidf0be4Xljzcgpidf0bw4clgzbgpicf0cB4jlgzWgpibf1cQ4sljzOgpiaf1cc40
					lpzEgpiZf1ck47lyy5gpiZf1cl5Al8ywgqiZf1ch5CmHyogqibf1cY5CmRykgqidf1cK4+mbyjgqief1b443miylgqigf1bm4ummyrgqigf1bU4kmny0gqig
					f1bE4amky+gqief1a44RmdzJgqidf0aw4KmTzTgpicf0av4HmIzagpicf0a04Hl8zegpicf0a/4Mlyze]],
				["Forearm.R"] = [[
					hli8fldLrtmU89hli7fkdgrtmH9Chli6fjd8rnl89Jhki5fhedrdlz9Qhki4ffe/rRlt9Xhji2fefgrFlq9ehji1fcf8q6lq9ihii2fbgQqylv9khii3faga
					qul39jhhi5fagaqvmE9hhhi7fagPq0mT9chhi+faf6q8mk9VhhjAfbferHm09NhhjBfce9rTnA9FhhjBfdeargnI88hijAffd6rrnK81hii/fgdgr0nG8whj
					i+fidMr6m98uhki9fjdCr7mw8whli8fkdCr3mi81hli8fldLrtmU89hmi7fmdbrdmG9Ihmi7fmdzrJl79Uhni5fmeOqyly9ghni4flesqZls9shni2flfIqB
					lq91hni2flfhpsls98hni2fkf0pcly+Bhmi3fkf/pRl8+Chmi5fkgApNmK+Ahmi8fkf3pQmb98hmi/fkfmpZmr91hljBflfMpom79thljCfmeup6nG9jhljC
					fmeOqPnM9ZhljBfndwqlnN9PhljAfndXq6nH9Ghli+fndFrNm98/hli9fnc9rdmw88hli8fmc/romi87]],
				["WingFinger1.R"] = [[
					iPjQgVlYdTdu/ViQjOgUlxdPc0/LiQjLgTmSc7b3+8iPjIgSm4cda7+oiPjEgSndb2aG+QiOjAgRn/bNZb95iNi+gQoaakZA9kiMi9gPouaAY49ViLi9gOo5
					ZlZD9PiLjAgOo7ZUZi9SiLjDgNozZQaT9diKjIgNohZabQ9viLjMgOoGZwcT+FiLjQgOnjaRdV+ciLjSgPm7a5eO+wiMjTgPmTble3/CiMjTgQlwcQfO/PiN
					jTgRlWc0fQ/XiOjTgSlJdNe+/biPjSgUlJdYed/biPjQgVlYdTdu/ViPjOgWlyc+c5/KiPjMgYmUcccA+5iPjIgZm7bvbJ+jiOjFgania7aZ+KiNjBgboGaG
					Z19viMi/gbokZUZf9YiMi+gbo7YqZa9FiLi+gcpJYJZo88iKjBgcpNX1aI88iKjEgcpHXwa49FiKjJgco1X7bz9XiKjNgcoZYTcz9uiKjQgbn0Y5dw+HiLjT
					gbnKZpel+fiLjUgamfaefK+0iMjUgZl5bUfc/FiNjUgYlccFfb/RiOjTgXlMctfG/YiPjSgWlLdIeg/Z]],
				["WingFinger2.R"] = [[
					iEi9hOqPc9gV+JiDi6hMqoctfc9/iBi2hKrKcOei9th+ixhIrubkdr9Vh6ishGsSazc886h2iohDsyaBcZ8ehzilhBtMZScF8Fhwijg+teYscC7zhuikg9to
					YTcS7phtimg8tqYIc07phtipg8tjYNdl7zhuitg8tSYieg8Fhxiyg+s4ZFff8dh0i2hAsWZzgb82h3i6hDrwanhM9Ph7i8hFrIbbhu9lh+i+hIqmcKh994iB
					jAhKqMcuh6+FiDjAhLp/dFhl+NiEi/hNqAdKhC+PiEi9hOqPc9gV+JiCi6hOqocefj99h/i2hOrJbwew9qh7iyhOrua5eB9Qh3ithNsSZ8dZ8yhyiphMszY/
					c98ThuimhKtOYIcw72hrikhItiXccy7ghpilhHtvW+dG7ShoinhHtyWwdp7PhoiqhHtrW0eZ7XhpiuhItbXKfS7phsiyhJtBXvgN8Chvi2hLseYghD8ehyi6
					hNr2Zahv87h2i9hOrNaXiL9Wh6i/hPqpbQiV9th+jAhQqOcCiM9+iBjAhQqAcmhx+JiDi/hPqBc6hI+N]],
				["WingFinger3.R"] = [[
					h6iah6vEb2iP70h3iWh3vcbchY7mhziRh0v7azgi7PhsiMhwwdZ/fy6xhliGhrw9ZFfK6NheiChmxaYNeu5phYh+hhxxXbeh5JhTh9hdyBW1el4vhQh9hayL
					Wee54hhQh+hZyNWafd4fhRiBhZyJWpgM4ohViFhcx7XJhD48haiJhfxlX3h85YhgiOhkxIYviv54hniThpwkZrjZ6ahuiXhuv/aljz65hziahyvebWj87Vh4
					idh2vFb6j07ph7idh4u4cNjd72h8idh6u4cLi576h6iah6vEb2iP70h2iXh5vbbPhh7khwiSh4v5aYg17LhoiNh1waZYgO6qhgiHhxw5YUfw6DhYiDhtxWXT
					fd5bhRiAhpxtWbfY42hMh+hlx/Vvfi4YhJh+hiyJVVf64FhIh/hhyNVOgf3/hJiChiyJVchO4HhNiFhkx8V7iD4ahSiJhoxmWri344hYiOhsxHXmjl5bhfiS
					hxwkYnkI6BhniXh2v/Zokb6mhtiah5vdaikd7Hhzidh7vEbSkN7gh3idh8u3bxju7xh6idh8u3b9jC74]],
				["Vine.R"] = [[
					iRi/gY4ac5mYzbiRi9gX4DcnmYz0iRi6gW33cXmgz9iQi2gU33cJmvz1iPiygT4Cb+nEzeiOivgS4Xb2ndy5iNisgQ4ybyn3yJiMirgP5RbzoQxSiLirgO5x
					b7olwZiLiugN6QcLoyvkiLiygN6rcio2u3iLi2gN7Bc+oxuaiMi6gO7PdcohuOiNi+gP7Ud3oLuWiNjAgQ7OeLnwuyiOjCgR6/eUnUvdiPjCgT6meSm6wSiQ
					jCgU6FeFmmxMiQjBgV5hdwmZyEiRjAgX47dWmUy1iRi/gY4ac5mYzbiRi9gZ4AcemlzyiQi6ga3vcFm6z6iQi3gb3qbvnVzyiPizgb3wbdn2zaiNivgc4AbQ
					oay0iMitgc4XbJo+yDiMisgc4zbIpfxKiLisgb5RbPp6wPiLivgc5wbfqMvXiLizgc6Mb3qSuoiLi3gc6kcUqMuJiLi7gc62czp6t9iMi/gc6+dQpeuFiNjB
					gc69dmo7uiiOjCgc6xdzoVvPiPjDgc6bd1nwwIiPjCgb5+dtnPxEiQjBga5bdfm0x/iRjAgZ45dNmiyz]],
				Tail1 = [[
					gAhjgWhlefgM/6f+hkgWhjfDe//7f9hlgWhkfud5/4f7hlgWhngcdA/zf7hkgWhshJcZ/uf6hjgWhwhxcJ/qf7higWhyiQcR/pf7hhgWhyilcw/rf9hhgWhu
					itdi/vf+higWhpioek/zgAhjgWhliWfu/3gChkgWhjh5g6/4gDhlgWhjhVh//3gFhlgWhngri4/0gFhkgWhsgBje/wgGhjgWhwfaju/ugFhigWhye6jm/ugF
					hhgWhxeijI/wgDhhgWhueWiW/0gChigWhpeVhV/4gAhjgWhlefgM/6f+hkgWhjezfB/6f9hlgWhkfOd9/4f7hlgWhnfsdF/0f7hkgWhsgKch/wf6hjgWhwgm
					cS/uf7higWhyg6cb/uf7hhgWhxhGc7/xf9hhgWhuhIdu/2f+higWhpg/ew/6gAhjgWhlgsf7/8gChkgWhjgQhG/7gDhlgWhkfviL/4gFhlgWhnfMjD/ygFhk
					gWhserjo/tgGhjgWhwePj3/qgFhigWhyd7jt/qgFhhgWhydyjN/tgDhhgWhud1ia/xgChigWhpeEhX/3]],
				Tail2 = [[
					f6hchagDcRgR/xf6hehbf7dAel/0f7hehbf4eDdC/yf9hehbf6fUbx/sf/hchbgAgqa7/lgBhbhagKh+al/dgDhZhagRjIaw/ZgGhYhagVkDbc/ZgIhZhagT
					knck/egJhahagMkzeC/kgKhchagDkkfr/qgKhehaf8j9hX/tgJhfhbf5jAi6/tgIhehbf8h0kK/qgGhdhbgEghlA/mgEhbhbgNfNlW/igChahbgUeClK/gf/
					hZhagXdFkf/if9hZhagVccjX/nf7hbhagNcKh6/sf6hchagDcRgR/xf5hehbf8cvem/yf5hehbf4didE/wf5hehbf7ejb0/rf6hdhbgDfra//mf8hbhbgNgz
					aq/if+hahbgVhya2/hf/hZhbgYikbj/kgBhZhbgVjCcs/rgChbhbgOjKeJ/xgDhchbgDi6fz/2gDhehbf7iUhe/3gDhehbf3hbjB/0gChehbf5gVkR/tgBhc
					hbgAfKlG/kf/hbhagKeClb/df+hZhagSdDlP/bf8hZhagWcVki/df7hZhagUb7jZ/jf6hahagNb5h7/q]],
				Tail3 = [[
					fphciefEajgO/gfthfiee2a+eE/gfzhgifepb6cG/df6hfigejdRah/XgBhcigele6Ze/RgJhZifevgsZE/MgQhWiee8icZW/LgWhVidfIkAaQ/NgbhWicfP
					lPbv/QgehYicfNmBdo/UgehcicfEmRfw/Wgbhfide4l+h6/WgWhgieetlJj3/TgQhfifepj3ld/QgJhdigesiQmf/NgBhaige2gfm5/Nf6hXiffDeumo/Qfz
					hWiefOdHlt/VfuhWiefSb0kP/bfqhZidfOa8iW/ffphciefEajgO/gfrhfiee2aueF/efuhgiferbZcH/Zfzhfifencgaj/Tf5hdigerd7Zg/Of/haige2fh
					ZH/NgFhXiffEhGZY/RgKhWiffPihaT/XgOhXiefUjqby/fgQhZiefPkYds/mgPhciffDkof0/pgNheife0kWh+/ngJhfigenjkj7/hgDheigehiYlg/Zf9hc
					ifekg6mi/Rf3hZifevfUm8/MfxhWiee9dwmq/MfthVidfKcXlv/QfphWidfQbTkQ/WfohZidfOariW/c]],
				["UpperLeg.L"] = [[
					fhhRgS6dZYfRwtffhUgS6CaIfzxnfdhVgS5oa1gWycfbhWgS5YbVgvy5fahWgS5dbggxy1fZhVgS5xbXgeyXfahUgT6JbEgCxwfbhTgT6cavfjxNfchSgT6o
					aafJw0ffhRgT6raIe1wmfhhRgT6pZ5elwjfjhRgT7WY4duu0fmhRgT70YAdKtUfohQgT8HXPczsEfphPgT8RWncnrJfphOgT8WWQclqofphNgT8WWOcrqnfo
					hNgT8RWlc7rNfmhNgS8CXRdXsbfkhPgS7fYMeGuQfhhRgS6dZYfRwtffhUgR5+Z9gAxqfdhVgR5gaegtyffbhWgR5OazhPy8fahWgQ5Qazhay4fahVgQ5iaj
					hSycfahUgQ53aLhAx4fbhSgQ6IZygrxXfdhSgQ6RZbgYxBffhRgQ6TZIgJw4fihRgQ6OY5f9w4fkhRgQ68X/fNvRfmhRgQ7aXOest5fohQgQ7uWjeUsvfphP
					gR76WBeCr3fqhOgR8BVvd1rTfphNgR8GVzdurLfohNgR8FWPdurlfmhNgR76XBd5sofkhPgR7bYDeWuV]],
				["LowerLeg.L"] = [[
					fYgxgBxvgrgr6nfXgygDy0g/hD51fWgzgFzzhNhO5EfWgzgH0ZhbhV4kfVgzgH0Xhxhk4jfUgzgGz3iLh446fTgygEzOidiF5XfTgygDyriiiE5xfUgygCyW
					iYhv6CfVgygCyQh+hJ6LfXgygCyUhbga6MfXg1f+wjhbgB7VfYg4f7vFhNfT8LfZg6f5t1g6ee8yfag6f4s4gqdy9Mfag6f3sQghdc9cfag5f2sEgidn9hfa
					g4f3scgteT9afZg2f5teg5fS8/fYg0f8vNg+gO8IfYgxgBxvgrgr6nfXgygDypgwhJ59fXgzgFzegyhd5VfWgzgGz6g1hu4+fWgzgFzvhAiE5EfVgygEzHhO
					ic5gfUgygCyWhWiq6CfVgxgBxshSio6ffWgxgAxRg/iS60fXgxf/xIghhr69fZgxf/xLf7g86+fag0f8vTf1gU8Gfbg2f5tvflfa84fcg4f3sefWee9afdg4
					f2rifNds9vfdg4f1rBfPdV95fcg4f1rCffdg96fbg2f2rrf5eP9ufZg1f4s/gXfS9OfYgzf7vAgtgQ8P]],
				["Foot.L"] = [[
					fagVgN/Pg5fzm3fagVgN/OhVftm3fagVgN/Nhlfqm3fagVgN/Mh1fmm2fagVgN/KiPfhm2fagVgN/Iiufam1fagVgN/GjEfVm1fagVgN/FjIfUm1fagVgN/H
					i1fYm1fagVgN/KiPfhm2fagVgN/Nhbfsm3fagagN+/hQfsnzfagegN+zgyfyonfagigN+ogOf8pNfagkgN+hfxgFpkfagkgN+ffigKpsfagkgN+hfmgIpkfa
					gigN+of+gBpNfagegN+zggf3onfagagN/Ag8fxn0fagVgN/Pg5fzm3fagVgN/OhLfwm3fagVgN/OhVftm3fagVgN/Nhgfrm3fagVgN/Mhzfnm2fagVgN/LiK
					fim2fagVgN/KiXffm2fagVgN/KiTfgm2fagVgN/Mh5flm2fagVgN/OhNfvm3fagVgN/PgWf7m3fagagN/Bf/gAn0fagegN+zfZgLonfagigN+ne1gXpNfagk
					gN+febggpkfagkgN+ceVgiprfagkgN+femgcpkfagigN+ofOgPpNfagegN+zgCgAonfagagN/Bgvf0n0]],
				["UpperLeg.R"] = [[
					gfhRgS6dmogvwtgchRgR7InqhbvEgahRgR7koih1trgYhQgR71pTiEskgXhPgR7+p6iKrwgWhOgR8BqRiLrTgXhNgR8CqSiGrSgYhMgQ7+p7h6rygahNgQ7w
					pPhks3gchPgQ7OoUhBujgehRgQ6OnHgDw4ghhUgQ5zmffexxgjhVgQ5Yl5e6yiglhWgQ5Ildehy+gmhWgQ5NlVeey5gmhVgQ5ildeuycgmhUgQ56ltfJx3gl
					hTgR6Nl/fnxVgjhSgR6amQgDw8ghhRgR6emdgbwwgfhRgS6dmogvwtgchRgS7Mnhhqu/gahRgS7toRiVtggYhQgT8Co8i1sOgXhPgT8PpejMrPgXhOgT8Wpw
					jbqogXhNgT8ZptjiqhgYhNgT8WpRjerBgahNgT8JofjLsNgdhPgT7ondijuEgfhRgT6pmHhbwjghhUgT6MlbguxigkhWgT5vkzgByZglhWgT5ckafgy4gmhW
					gT5fkXfXy1gnhVgS5xkpfiyXgmhUgS6HlEf2xxglhTgS6YlggLxPgjhSgS6hl7gdw4ghhRgS6imTgowt]],
				["LowerLeg.R"] = [[
					gogxgBxvfVfV6ngog0f9v0fgf07zgmg3f6uMf4gp8qglg4f4szgShj9Rgkg5f2rtgmiT9rgjg4f1rBgxir95gkg3f1q2guig9+gkg2f1rUgghy93gmg0f3sh
					gNgu9bgngzf6udf/fq8igngxf/xLgFfE6+gogygCyMf2em6RgpgzgEzIfreT5lgqgzgFzrfdeG5JgqgzgFzofJd25KgrgygEzHeydk5ggsgygCyeegdb58gs
					gxgBx8eadh6VgrgxgBxoejd66kgqgxgAxme4ej6qgogxgBxvfVfV6ngog1f9wBfQf37rgng3f7unfWgr8cgmg5f5tgffhj89gmg6f3ssfjiP9Sgmg6f3sQff
					ik9cgmg6f3sRfRiX9cgng4f4sze6hr9Pgog2f6t9ejgt8vgpg0f9vxeXf47ygpgygCyUelfm6MgqgzgEzRebfP5egqgzgG0JeYfD4xgqgzgH0oeTe44Xgrgz
					gH0feGej4dgsgzgGz3d1eI46gsgygEzGdtd15dgsgygCycdxdz59gsgxgBx/eGeF6UgqgxgBxxepeo6i]],
				["Foot.R"] = [[
					gmgVgN/PfHgNm3gmgagN/BffgIn0gmgegN+zgJf+ongmgigN+og2fwpNgmgkgN+fhZfkpkgmgkgN+chrfeprgmgkgN+fhmfgpkgmgigN+nhJfqpNgmgegN+z
					gef4ongmgagN/Bf2gDn0gmgVgN/PfqgFm3gmgVgN/PfPgLm3gmgVgN/Oe9gPm3gmgVgN/OergTm3gmgVgN/MeSgYm2gmgVgN/Ld2gem2gmgVgN/Jdigjm2gm
					gVgN/Jdggjm2gmgVgN/Kdygfm2gmgVgN/NeXgXm3gmgVgN/PfHgNm3gmgagN/BfSgMn0gmgegN+zfsgGongmgigN+ogIf+pNgmgkgN+hgbf3pkgmgkgN+fge
					f2psgmgkgN+hgOf8pkgmgigN+ofqgGpNgmgegN+yfAgSongmgagN+/eggYnzgmgVgN/NelgUm3gmgVgN/MeTgYm2gmgVgN/MeKgam2gmgVgN/LeBgcm2gmgV
					gN/Kdsghm2gmgVgN/IdSgmm1gmgVgN/GdCgqm1gmgVgN/HdFgpm1gmgVgN/Jdegjm2gmgVgN/MeMgZm2]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAhZgWDVhMh5t/gAhcgWDTgIiVt7gAhigWDTfCiXt5gAhngWDVeHh/t7gAhpgWDYdihRt/gAhlgWDZdXgVuDgAhfgWDYdqfWuEgAhagWDWeXeduBgAhagWDU
					fVd2t9gAhfgWDTgcdnt5gAhlgWDUhddyt5gAhpgWDXiPeVt9gAhngWDYinfLuBgAhigWDZijgLuEgAhcgWDXiDhIuD]],
				Spine = [[
					f9h2gAEJhSh1vkf7h4gAELguh/vof6h+gAEXgDh0v/f6iDgAEkfXhWwYf7iFgAErewgqwkf9iBgAEmeYf1waf/h7gAEZeSfBwBgCh3gAEMegeZvqgEh3gAEJ
					e+eDvjgFh7gAEQfneEvygGiBgAEegUeZwMgGiFgAEpg+e/whgEiEgAEqhefwwigCh+gAEghuglwPgAh5gAEShphVv0]],
				Neck1 = [[
					f7iTfuFChYhwxDf4iVfvE9g8h3w9f3ibfvFNgXhpxZf3ihfwFpfuhLyEf4iifwF9fHgiyif7iffwF8eofxyff/iZfvFneZfBx+gDiUfvFMeeecxTgGiTfuE9
					e1eKw7gIiYfvFDfWeOxHgJiefwFbf9elxvgIiifwF1gmfJyXgGihfwGAhKf2ylgDicfwFzhigoyRf/iWfvFZhnhUxn]],
				Neck2 = [[
					f6ipfkFMhZhvxSf3irfkFAhEhwxBf1ixflFUglhexkf1i3fnF8gCg+yhf3i5foGffbgWzRf6i2foGje4fozVf/ivfmGFeje7yqgEiqflFceheaxsgIipfkFC
					eweNxDgKiuflFGfLeXxNgLi1fmFnfsexyCgKi5foGQgSfVy+gIi4foGlg3gAzZgEizfnGXhVgvzEf/isflFwhhhYyL]],
				Neck3 = [[
					f5i5fdFWhahuxif2i7fcFDhLhqxGf0jCfeFbg0hSxuf0jJfhGRgVgxy+f2jLfjHCfwgKz/f6jHfjHLfJfg0Jf/jBfgGlese2zVgEi7feFtejeYyEgJi6fcFH
					eseRxLgLi+fdFKfAegxTgMjGfgF0fae+yVgLjLfjGtf9fizkgIjKfjHNgkgL0MgEjEfiG9hHg2z2f+i9ffGJhbhbyt]],
				Head = [[
					f5jKfVAIgViNhYf1jMfVAHg3h/hBfzjTfXAGhRhehMf0jafcAHhdgyh0f2jdffAJhXf/idf6jZffAKhCfGitf/jSfcAKgheUiZgFjMfXAJf9d2hugKjKfVAH
					fad3hIgMjPfWAGe7eQhCgNjXfaAGene3hegLjcfeAIejfniKgIjcfgAKeygdipgEjWfeAKfOhVinf+jOfZAJfxh+iE]],
				Jaw = [[
					f1jWe9/3f5dxhsfyjXe8/2fWd8iEfyjee+/3e5ebh+f0jmfD/5epfDh8f3jqfH/7epf3hcf8jnfH/9e5gygzgCjffE/7fUhogsgIjYe//5f2iJhXgNjVe8/2
					gZiNh8gOjae8/3g6h3iDgNjjfB/4hRhSiBgLjpfG/6hZgkhvgHjpfI/8hRfshHgBjjfG/8g6exgjf7jbfB/6gbeEhA]],
				Crest = [[
					f6kyfSaNiOgL/Yf5k0fPZ2iIfn/Uf7k6fSaBhufG/Xf9lCfbaohGew/ff/lEfjbQgSeq/mgBlBflbgfXez/pgDk6ffbMeefH/lgFk0fWaid5fk/cgHkyfPZ+
					dxgH/VgGk3fQZ3eDgq/VgEk+fWaSelhG/bgClEfga+fThV/jgAlDflbcgLhT/of+k+fjbahHhE/nf8k2fba4h4gr/h]],
				["Humerus.L"] = [[
					fUiSf2ZrTbit8mfRiSf2ZZTSiL8hfPiXf1ZeS0hh8XfPicf0ZvSJg98IfQidfyZ9RWgt7xfTiafwZ7Qjg17UfXiUftZuP5hS64fbiRfrZiPjh56lfeiSfrZo
					Piig6jfgiYfsaEPzi86xfhiffvarQSjJ7KfgikfxbJQ+jL7ofeijf0bNRyjK8Efbidf1a2SljH8afXiWf2aPTLjA8l]],
				["Forearm.L"] = [[
					egimghb7dvnx+redioggbydinN+yebiugeb8c9mr+3eZiygacLcImT+4eYizgWcQbNmM+yeZivgQb+aWmX+keaipgKbeZvmw+TedikgHbBZdnS+DegijgGa8
					Zhn395eiingKbUZ1oZ94ekisgPb+aVov9+eliwgVclbBo3+Ielivgbc3b4oz+Uelirgfcvcxom+eejinghcVddoQ+l]],
				["WingFinger1.L"] = [[
					eTi0hhewsIpp79ePi3hgeor8o98QeLi8hdfhrMpL8ieGi+hZgwqEp+8reCi+hUhZo8qv8vd/i6hMg5oNq+85d+i1hFfcn8qj9Id/ixhBd1oBp89QeBiwhAc9
					oPp19JeFiyhFdUohql81eJi2hLero1r38VeOi4hTgQpPs67yeRi3hahIp5tH7beUi1hfg3q0sW7ceVizhhfxrrq+7r]],
				["WingFinger2.L"] = [[
					e6jGiMiEtFl18ie2jIiLh/szlK8yewjJiLi9sJld88epjIiKkSrPmY89eijFiHlBqSnT8+ecjCiBkmpjno9NeYjBh6jNpInQ9neYjCh1hopAmp97eajEh0gv
					pJmg98efjGh4hCpknO9peljHh/iSqJoe9DesjFiGjvq0pe8VezjDiLkgrkpl74e5jCiOkLsVot75e7jDiOjEs6nO8M]],
				["WingFinger3.L"] = [[
					fljIiylcuiiL75fgjJiylcuKhi8IfZjHizmdtnh78KfRjCiznzs7jB8CfHi9ixojsLkF8Be/i7iuoNrfkf8We5i+ipm8q8kI89e3jDillcqojf9ee5jJikkk
					qtjU9ne/jLinkwrPj/9TfIjJisl2sDlM8lfTjEiwnHs8mJ7tfcjBiznwtumM7JfjjBi0nauWlN7IfmjEizmXuojn7f]],
				["Vine.L"] = [[
					egiohktoyHay19ecirhjsgwfZv3leXivhhtyuWXP3eeSiyhdwqs4VF1deNixhYzgsaVLzReKiuhR0qs+Xmy6eJiphLzFuTaq0peLimhHvnvMcq3MeOilhHsz
					usc+5MeSiohLsktnbf5seXirhRujtQY24LebithYxIt3W01Sefishey4u+Wxy6eiiqhiyrwiYWygeiiohkwayBaGz3]],
				["Humerus.R"] = [[
					gkiQfrZiwgdy6ighiUfsZ0wYdQ6ogficftaYv/c869gfiifwa8vZc17ZghikfzbPupc173gjihf0bFt0c38QgniZf2ajtFc78ggriTf2Z7sqdI8mguiRf2Zf
					sndj8kgwiVf2ZZs7eK8cgxiaf1Zmtgez8QgxidfzZ3uQfO7+guicfxZ+vEfS7jgriXfuZ1v0e/7GgniSfsZmwVeb6t]],
				["Forearm.R"] = [[
					hhijgGa7mjYb99hfilgIbEmXX393hdiqgMbol9Xb96hbiugScTlXXL+DhbiwgYcyklXK+Ohbiugdc2jrXT+Zhcipggcji2Xk+ihfimghcHiWX/+ohhinghb0
					iUYh+uhkirgfb1iuZF+1hmiwgccEjcZj+5hoizgYcQkWZz+2hoixgTcKlQZx+shnisgNbvmAZe+chkimgIbOmdZA+K]],
				["WingFinger1.R"] = [[
					iAiwhAdQX5WO9Oh9ixhCc+XoV69Bh5i0hId6XVU08nh1i3hPfgXATj8Dhwi4hXg0WfS47khti2hdhIVrTL7Zhri0hggXUuUT7jhsizhhfMUCVv70hvi1hhej
					T5W08Hhzi5hfe+UYXD8Zh4i9hcgKVXWe8nh8i/hXhNWiVn8tiAi8hQhTXfVE8ziCi4hJgQX/VL9AiCizhCemYDVy9O]],
				["WingFinger2.R"] = [[
					hnjDh0hDW+Zi9+hkjGh1gvWrZP91hejHh7hlWLYL9YhXjGiDjDViW98rhQjEiJkQU1WW8DhKjCiNkeUDWw71hGjCiOjrTWYA8BhFjEiNifS9Zi8XhIjHiMh5
					TBao8rhNjJiLiYTfa084hTjJiLjpUTaI89hajGiJkyVRZH88hhjDiEk9WIYc9DhmjBh+j/WtYf9ZhojBh4iYW+ZF9z]],
				["WingFinger3.R"] = [[
					hIjGikk4VZct9mhEjKilkhVFcd9hg9jKiplPUYbc8/gzjHiumhTgaQ8IgojDiynjSqZs7XggjBi0ntR8aM7EgbjCi0m7Rebk7SgajGiyl1RYdM7tgdjJiylT
					RoeS8CgjjJiyl2SGeZ8KgrjFiznJSudl8Gg0i/izoSTdca8Ag9i7iwohUMbn8JhEi8irnqU0bn8phIjAinmKVQcN9Q]],
				["Vine.R"] = [[
					h0ilhHt9Q6i+4VhwimhJsVR4jj5rhsiphOtYSuly5MhnishUv3SioY2zhjithbyMRppfz6hfirhgzDQTokycheiphjxvOomtzBhfiohku8NtlY05hiiphksw
					Oilh26hmithis3Qnna3zhsixhfvHShqC2ohxiyhbyMTfrO0Ph0iwhV0ZTcp1yzh3irhO0OSam0zlh2inhJxcRHkJ16]],
				Tail1 = [[
					gAhZgWhBjRfj/zgAhcgWgUiWg3/5gAhigWgJg/h+/6gAhngWgmffiv/3gAhpgWhZeJjE/wgAhlgWh/dGi6/qgAhfgWiAcgiO/qgAhagWhbcfhH/vgAhagWgo
					dIfy/2gAhfgWgJeTej/6gAhlgWgTfxdm/5gAhpgWg/hOdD/0gAhngWhvicc9/tgAhigWiFjRdY/pgAhcgWhxjleT/s]],
				Tail2 = [[
					gOhVhaf/lJfe/kgKhbhaeljhg3/wgEhihbd4hNiA/1f+hlhbeVewiv/zf5hihafqcljC/qf0hbhZg9bCi7/dfyhVhZhZaQiU/WfxhThZgqaahO/df0hXhafQ
					bkf1/rf5hehbeGdleh/zf/hkhbd9gCdl/1gFhkhbe8iZdE/vgKhfhagYkSc+/jgNhYhZhUlddU/YgPhUhZhKlzeL/Y]],
				Tail3 = [[
					gkhVibfznVfW/IgZhhidd3lcgv/cgJhrifccigh7/of4hrifcffJin/rfqhiied+cEi3/jfghVibf6Zuiv/PfahNiZhAYYiQ++fahQiagjYPhS/Afhhbice2
					Zdf9/SfvhniedBb8eo/jgAhsigcRfLdr/rgQhoifdGiedO/pgchcice+lOdK/agkhQiagonGdd/FgnhNiZg+n2eL+8]],
				["UpperLeg.L"] = [[
					fhhIgX4TZ5dezvfihIgW5hYMdExZfjhNgV6yW8dEurfkhRgU8QWDc6qyflhSgS9VVocpmqflhPgR90Vocnj5fkhKgP99V1dHjtfjhHgO9sWReRmofihJgO80
					WxfdqXfghQgO7iXogXt9ffhYgQ4kaKiNzhffhcgR3QbuiT1bffhbgT2lcphr2WffhVgV4bbEfG0DfghNgW47aJdpzC]],
				["LowerLeg.L"] = [[
					fTgmgOpPjlfH+ZfTgqgIkHjxe1/efUgygBi7jGeg/rfWg9f4laiFed/bfZhGfxqAg8ey+WfahJftuhfzff8gfbhEfrxxe1gd6kfag6fs0FeKhe4yfagzfx0m
					eMiH4UfZgzf30jetiP4Yfbg0gG3heLgm1mfcg3gO3jevfn1nfcg2gS2xfie42cfWgxgNxdiOf+6ufTgrgLskjqf79M]],
				["Foot.L"] = [[
					fagVgn/Hi6fXm1fagigl+mjNfGosfagsge+QiffLqDfagygV+Ehcffq0fag0gK+Cgdf1q/fagwf/+NfqgIqifagnf3+ifIgRpffagbfz+/fAgQn2fagVf2/P
					fYgJm3fagVf9/Pf5gCm3fagVgE/OergTm3fagZgL+0esgOoffagXgS/AfHgJn1fagVgZ/Mh6flm2fagVgg/FjPfTm1]],
				["UpperLeg.R"] = [[
					gehHgO9JpQgzpYgfhMgO8To8gKr8gghUgP6dnee+wUghhbgQ3lkzdf07ghhcgS27jzd/15ghhYgU3Wj+fm1gghhRgV41lfhzzUgghKgW4vmEilzMgfhIgX49
					nDi2yggdhKgW6Gofi8wLgchPgV7hpki/s2gbhSgT83qPjPopgbhRgR9oqbjblBgchMgQ96qTjOjcgchIgP96qAiakw]],
				["LowerLeg.R"] = [[
					gmg0fv1aiJeR3mgngzfz0Shgds4lgng0f91chReN3pgkg2gL38hvgH1Jgkg3gQ3Kg1gv2CgngzgQ0qfLgp4ZgsgugLu3c4f78JgtgogMqpcNgc97gtgngLmN
					cKg//IgtgtgEjBcghX/ogrg3f8jxdYhk/ngphCf0nmefhc/AgmhIfvsYfpg79eglhHfswUgugE7gglg/fry9hjfB5s]],
				["Foot.R"] = [[
					gmgVfy/OhFfxm3gmgVf5/PgRf8m3gmgVgA/PgTf8m3gmgXgI+9hnfsn4gmgZgO+0hDf2ofgmgVgV/PflgGm3gmgVgc/HdOgnm1gmgVgj/Ecvgum1gmgbgm+1
					cwg1n0gmgngi+adFg6pcgmgwga+JeCgsqhgmg0gP+CfFgWq/gmgygE+Gf+gBq1gmgsf7+WgqfyqFgmgif0+wg+fuov]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAjFgW//gAgAgSgAjJgW//gAgAf9gAjRgW/+gAgAfLgAjZgW/8gAgAeYgAjcgW/7gAgAeDgAjZgW/8gAgAeYgAjRgW/+gAgAfLgAjJgW//gAgAf9]],
				Spine = [[
					gAjFfyAJgAgAi5gAjJfyAKgAgAi+gAjTfyALgAgAjLgAjdfyAMgAgAjXgAjhfyANgAgAjdgAjdfyAMgAgAjXgAjTfyALgAgAjLgAjJfyAKgAgAi+]],
				Neck1 = [[
					gAjLfRA/gAgAn1gAjPfRBCgAgAn/gAjZfRBIgAgAoXgAjkfRBPgAgAowgAjofRBSgAgAo6gAjkfRBPgAgAowgAjZfRBIgAgAoXgAjPfRBCgAgAn/]],
				Neck2 = [[
					gAjWe7CDgAgArOgAjbe7CJgAgArdgAjle8CWgAgAsAgAjwe8ClgAgAsjgAj1e9CrgAgAsxgAjwe8ClgAgAsjgAjle8CWgAgAsAgAjbe7CJgAgArd]],
				Neck3 = [[
					gAjieuDfgAgAuegAjneuDogAgAuxgAjyevEAgAgAvegAj+ewEZgAgAwJgAkCewEkgAgAwbgAj+ewEZgAgAwJgAjyevEAgAgAvegAjneuDogAgAux]],
				Head = [[
					gAjxejADgAgAhTgAj2ejADgAgAhTgAkCelADgAgAhTgAkNenADgAgAhTgAkSeoADgAgAhTgAkNenADgAgAhTgAkCelADgAgAhTgAj2ejADgAgAhT]],
				Jaw = [[
					gAj8eK/4gAgAingAkBeK/4gAgAingAkNeM/4gAgAingAkZeO/4gAgAingAkeeP/4gAgAingAkZeO/4gAgAingAkNeM/4gAgAingAkBeK/4gAgAin]],
				Crest = [[
					gAlZefawgAgA/jgAleegbNgAgA/ogAlqehbAgAgA/mgAl1ejaSgAgA/egAl6ekZegAgA/UgAl1ejZCgAgA/OgAlqehZOgAgA/RgAleegZ8gAgA/a]],
				["Humerus.L"] = [[
					fYjLfTIGOSdxrhfYjPfTKRNwfTuwfYjafUN+OdlZzAfYjkfUSMP+sN0pfYjofUT9QAvpzcfYjkfURCOfuRxAfYjafULhNwopuAfYjPfTIEOThrrj]],
				["Forearm.L"] = [[
					fDj2egI1NqgisOe1j9erL1NAjBvredj8fDPyN8n8zQeTjwfdSpPVse0SeTjmfjSrOtt6yyeSjlfRPVM+rev3ecjrezKtM0mqsie2jxegIKN1iFq+]],
				["WingFinger1.L"] = [[
					ekkadxKrMxiHt7eGkfeKPTMmmlyAdekSe5UJOVrO1FdRj5fkVwP4t11ndRjnfoTfOctAzvdRjrfAO/L8olwDdrj+eKKtLtjksCeWkOduI8M3g6rI]],
				["WingFinger2.L"] = [[
					d/k4dMNOLVh1vfdPkzd5TlMjoR0jcikYfAaAP9tn3VcXj4f1bfR/vq3tcUjqftXjPXtz2Bcaj3erRYLInvxtdEkTdgMgJ+hfsed6krc/KxLAfFra]],
				["WingFinger3.L"] = [[
					dXlVcuPqKWhEw6cXk+d2X2N2pt3FbvkPfYfxTrvw49bqjsgWg/WBxL5Ebejlf/bTRXuU4IbkkCebTfKkmWzKcjkrc4OPIZetsLdhlIcVMkJVcoq9]],
				["Vine.L"] = [[
					eZkfd+pWUcfa8Ud+kgeapgatg4+EddkQfLmsiKie/HdVj4f1iklbkm/FdUjpf5g7idlf/adPjtfSiMb1jU/edjkCeZkjVigI94eLkVd7nNSoep8H]],
				["Humerus.R"] = [[
					gojLfTIGxuiPrhgojPfTKRyQgtuwgojafUN+xjanzAgojkfUSMwCTz0pgojofUT9wAQXzcgojkfURCxhRvxAgojafULhyQXXuAgojPfTIExteVrj]],
				["Forearm.R"] = [[
					g9j2egI1yWfesOhLj9erL1zAc/vrhjj8fDPyyEYEzQhtjwfdSpwrTi0ShtjmfjSrxTSGyyhujlfRPVzCUiv3hkjrezKtzMZWsihKjxegIKyLd7q+]],
				["WingFinger1.R"] = [[
					hckadxKrzPd5t7h6kfeKPTzaZbyAiikSe5UJxrUy1Fivj5fkVwwISL1nivjnfoTfxkTAzvivjrfAO/0EXbwDiVj+eKKt0TccsChqkOduI8zJfGrI]],
				["WingFinger2.R"] = [[
					iBk4dMNO0reLvfixkzd5TlzdXv0jjekYfAaAwDSZ3Vjpj4f1bfuBQW3tjsjqftXjwpSN2Bjmj3erRY04YRxti8kTdgMg2CehseiGkrc/Kx1Ag7ra]],
				["WingFinger3.R"] = [[
					iplVcuPq1qe8w6jpk+d2X2yKWT3FkRkPfYfxsVQQ49kWjsgWg/p/O15Ekijlf/bTupRs4IkckCebTf1cZqzKjdkrc4OP3nhTsLiflIcVMk2rjYq9]],
				["Vine.R"] = [[
					hnkfd+pWrkgm8UiCkgeapglTfI+EijkQfLmsd2di/Hirj4f1ikalba/Fisjpf5g7djah/aixjtfSiMkLcs/eidkCeZkjqef494h1kVd7nNtYhX8H]],
				Tail1 = [[
					gAjFgWRxgAgA8pgAjJgWTMgAgA9UgAjRgWU8gAgA+BgAjZgWV+gAgA+YgAjcgWVpgAgA+RgAjZgWUKgAgA9ugAjRgWScgAgA8+gAjJgWRdgAgA8f]],
				Tail2 = [[
					gAj8hAPDgAgA7IgAj7hFRIgAgA8UgAj9hLT/gAgA9pgAkChOV7gAgA+XgAkHhNVtgAgA+SgAkIhITdgAgA9bgAkGhCQngAgA8DgAkAg/O1gAgA6/]],
				Tail3 = [[
					gAk6heM5gAgA5qgAk0hsO9gAgA7EgAkuh8SmgAgA9CgAkriFVsgAgA+SgAkxiDWQgAgA+egAk6h4T5gAgA9ngAlAhnQMgAgA7zgAk/hcNYgAgA6A]],
				["UpperLeg.L"] = [[
					fhi3gi4maZgNzrfhi6gi4zaZgJzafhjCgh5RaZgAyzfhjKgg5uaZf3yLfhjNgg56aZfzx6fhjKgg5uaZf3yLfhjCgh5RaZgAyzfhi6gi4zaZgJza]],
				["LowerLeg.L"] = [[
					faiUgZgbgAgA//faiXgYgwgAgA/+faifgVhjgAgA/9faiogTiVgAgA/6fairgSiqgAgA/4faiogTiVgAgA/6faifgVhjgAgA/9faiXgYgwgAgA/+]],
				["Foot.L"] = [[
					faiTg4+LgAgAqofaiWg3+SgAgAqUfaicg0+hgAgApkfaijgx+wgAgAozfaimgw+2gAgAoffaijgx+wgAgAozfaicg0+hgAgApkfaiWg3+SgAgAqU]],
				["UpperLeg.R"] = [[
					gfi3gi4mlnfzzrgfi6gi4zlnf3zagfjCgh5RlngAyzgfjKgg5ulngJyLgfjNgg56lngNx6gfjKgg5ulngJyLgfjCgh5RlngAyzgfi6gi4zlnf3za]],
				["LowerLeg.R"] = [[
					gmiUgZgbgAgA//gmiXgYgwgAgA/+gmifgVhjgAgA/9gmiogTiVgAgA/6gmirgSiqgAgA/4gmiogTiVgAgA/6gmifgVhjgAgA/9gmiXgYgwgAgA/+]],
				["Foot.R"] = [[
					gmiTg4+LgAgAqogmiWg3+SgAgAqUgmicg0+hgAgApkgmijgx+wgAgAozgmimgw+2gAgAofgmijgx+wgAgAozgmicg0+hgAgApkgmiWg3+SgAgAqU]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAhngWECgAgAvggAhmgZEOgAgAv2gAhkgfEugAgAwtgAhhgmFVgAgAxqgAhfgrFvgAgAyRgAhigZEvgAgAwugAhnfrCygAgAtBgAhnfrCygAgAtBgAhnfrCy
					gAgAtBgAhnftC1gAgAtIgAhnf3DHgAgAtugAhngGDigAgAulgAhngSD5gAgAvRgAhngWECgAgAvggAhngWECgAgAvggAhngWECgAgAvg]],
				Spine = [[
					gAiGgDFPgAgAxggAiFgGFjgAgAx+gAiEgOGXgAgAzHgAiDgYHWgAgA0YgAiBgeIBgAgA1KgAiCgIGZgAgAzKgAiCfTDTgAgAuHgAiCfTDTgAgAuHgAiCfTDT
					gAgAuHgAiCfVDYgAgAuRgAiDfgDzgAgAvGgAiEfwEdgAgAwQgAiFf+FCgAgAxMgAiGgDFPgAgAxggAiGgDFPgAgAxggAiGgDFPgAgAxg]],
				Neck1 = [[
					gAikf1GDgAgAytgAikf6GigAgAzXgAikgFH2gAgA0+gAikgRJdgAgA2rgAijgaKkgAgA3vgAijf/IEgAgA1OgAice+DngAgAuwgAice+DngAgAuwgAice+Dn
					gAgAuwgAidfADtgAgAu7gAiffNEPgAgAv5gAiifgFEgAgAxQgAikfwFzgAgAyWgAikf1GDgAgAytgAikf1GDgAgAytgAikf1GDgAgAyt]],
				Neck2 = [[
					gAi8fuGDgAgAytgAi8fzGtgAgAzkgAi8gBIdgAgA1qgAi8gSKqgAgA31gAi7gcMOgAgA5IgAi7f8I5gAgA2IgAiwewDSgAgAuFgAiwewDSgAgAuFgAiwewDS
					gAgAuFgAixezDZgAgAuSgAi0fBD/gAgAvbgAi4fWE6gAgAxAgAi7foFwgAgAySgAi8fuGDgAgAytgAi8fuGDgAgAytgAi8fuGDgAgAyt]],
				Neck3 = [[
					gAjNfoGDgAgAytgAjOfvG3gAgAzxgAjPgAJGgAgA2UgAjOgUL8gAgA46gAjNghN9gAgA6agAjNf7JwgAgA2/gAi/elC+gAgAtagAi/elC+gAgAtagAi/elC+
					gAgAtagAjAeoDFgAgAtpgAjDe3DugAgAu9gAjIfOExgAgAwxgAjMfhFugAgAyOgAjNfoGDgAgAytgAjNfoGDgAgAytgAjNfoGDgAgAyt]],
				Head = [[
					gAjefiADgAgAhTgAjffqAKgAgAi+gAjhf/A0gAgAnIgAjggYCPgAgArtgAjegnDhgAgAujgAjff8BGgAgAoOgAjNeZArgAgAZigAjNeZArgAgAZigAjNeZAr
					gAgAZigAjOecAngAgAZ3gAjSetAUgAgAbsgAjZfGAEgAgAeWgAjdfbABgAgAgkgAjefiADgAgAhTgAjefiADgAgAhTgAjefiADgAgAhT]],
				Jaw = [[
					gAjqfJ/+gAgAg8gAjtfT//gAgAgVgAj1fs/8gAgAeZgAj4gL/ogAgAbNgAj4gg/mgAgAbEgAj0fq/VgAgAmagAjLd++XgAgAqDgAjLd+97gAgArSgAjLd++J
					gAgAqsgAjNeB+2gAgAoegAjVeS/UgAgAmhgAjfer/wgAgAj5gAjnfB/8gAgAhsgAjqfJ/+gAgAg8gAjqfJ/+gAgAg8gAjqfJ/+gAgAg8]],
				Crest = [[
					gAlGfeaHgAgA/cgAlHfxbkgAgA/rgAlDghfRgAgA/+gAk0hVjfgAgA/zgAkkh0mOgAgA/YgAk/gkgCgAgA//gAkndlTMgAgA9UgAkndlUrgAgA96gAkndlUv
					gAgA98gAkpdqVEgAgA+EgAkzeGWygAgA+ogAk+evY7gAgA/MgAlEfSaXgAgA/fgAlGfeabgAgA/ggAlGfeaHgAgA/cgAlGfeaHgAgA/c]],
				["Humerus.L"] = [[
					fYijf3bcO2hM6lfYiif8bQOgfq6WfYiigGalOBb55kfYihgTZcOFX44WfYiggbYgOeVg3cfYiggAZzNdap4vfYibfAahPsnI6AfYibfAZ+Rang6yfYibfAZ9
					Rfnh60fYibfDaARcnS64fYidfQaSRNl77JfYigfiaxQnj37RfYiifybOP2iC7HfYijf3baPKhS6xfYijf3bcO2hM6lfYijf3bcO2hM6l]],
				["Forearm.L"] = [[
					eYiwgSdNTrl68yeZi0gVc/Sdj18keci/gcb/QAej7XejjLgnaFOWY55BeqjSgvYZN8Vn3DedjDgSasOWcP53eYiffebfVWrY7keciifkbNXQri8IeciifkbN
					XVri8JecijfnbSXRrU8OecinfzbwW2qG8oebirgEceV8oR9AeaivgRdDU3mo9GeZiwgUdNUCl+87eZiwgSdNTrl68yeYiwgSdNTrl68y]],
				["WingFinger1.L"] = [[
					doixhAgPb5pi+Qdli5g+gHZbnC+gdjjRg7e9T/gT9odvjvg9cLPrYz6Rd+kBhAZkODUh2+dkjegodDQmcz7sdrifgPd0eYub8bd1ingafYgZvT8Fd1ingbfd
					gevV8Ed1ingdflgXvL8Kd0irgpgRfsuO8pdxiug4g3eask9XdtixhDg+dFqz99dqiyhDgkcOp0+NdoixhAgQb5pj+QdoixhAgPb5pi+Q]],
				["WingFinger2.L"] = [[
					dZish7k/dJn7+ddNizh2kwaUlr+mc5jUhnjKUDfZ9gc/kJhYfuPBYE57dWkrhScrNGTw2eczjthIg3QScE7kdiikhLi/gYsp9Pd1iphXmljTtU8Jd2iqhXmv
					jbtU8Fd1iqham4jRtM8Id0iphmnniZsY8Zdtiph1nwgoq99Cdkiqh+nAexpT9xddirh+ludloQ+SdZish7lAdJn7+ddZish7k/dJn7+d]],
				["WingFinger3.L"] = [[
					dUiYiwpgfVml90c8ifippKcIkp+DcRjKiPnKU+ey9IcOkZhxjHPHXa5lcrlNhifrM0S61/cCjyhlkeQwbe7ZdniaiDn7jcq68zeJiaiKtengrM5seKiaiKtt
					nqrL5ieKiZiMt3nfrF5ieGiUiYunmcqk5od5iQinuXkKpk6ndniRiyszhqoI8IdaiWizqqf+nA9VdUiYiwphfWml90dUiYiwpgfVml90]],
				["Vine.L"] = [[
					dyikhIzop3eZ3NdsirhG0gn0ea3PdljAhD2Bh2cz26dpjfhC4mbHaUzBd0jzhF6FXscPwIdijOgw3Rgogv17d4iYgZpyt3jf65eCifgiqtr8eh7oeDifgjv8
					sHaJ4QeDigglyQuCcA12eBihgxwRu5fQ3Kd9ijhAvnsxfR40d4ikhKyFqjdn4Ed0ilhKzzp5dp2+dyikhIzxp4eW3EdyikhIzop3eZ3N]],
				["Humerus.R"] = [[
					goijf3bcxKe06lgoiif8bQxggW6WgoiigGalx/kH5kgoihgTZcx7oI4WgoiggbYgxiqg3cgoiggAZzyjlX4vgoibfAahwUY46AgoibfAZ+umYg6ygoibfAZ9
					uhYf60goibfDaAukYu64goidfQaSuzaF7JgoigfiaxvZcJ7RgoiifybOwKd+7Hgoijf3baw2eu6xgoijf3bcxKe06lgoijf3bcxKe06l]],
				["Forearm.R"] = [[
					hoiwgSdNsVaG8yhni0gVc/tjcL8khki/gcb/wAhd7XhdjLgnaFxqnH5BhWjSgvYZyEqZ3DhjjDgSasxqjx53hoiffebfqqUo7khkiifkbNowUe8IhkiifkbN
					orUe8JhkijfnbSovUs8OhkinfzbwpKV68ohlirgEceqEXv9AhmivgRdDrJZY9GhniwgUdNr+aC87hniwgSdNsVaG8yhoiwgSdNsVaG8y]],
				["WingFinger1.R"] = [[
					iYixhAgPkHWe+Qibi5g+gHmlY++gidjRg7e9sBft9oiRjvg9cLwVnN6RiCkBhAZkx9rf2+icjegodDvajN7siVifgPd0hoRl8biLingafYfnQt8FiLingbfd
					fiQr8EiLingdflfpQ18KiMirgpgRgURy8piPiug4g3hmTc9XiTixhDg+i7VN99iWiyhDgkjyWM+NiYixhAgQkHWd+QiYixhAgPkHWe+Q]],
				["WingFinger2.R"] = [[
					inish7k/i3YF+dizizh2kwlsaV+mjHjUhnjKr9gn9gjBkJhYfuw/n857iqkrhScry6sQ2ejNjthIg3vuj87kieikhLi/foTX9PiLiphXmlctSs8JiKiqhXmv
					clSs8FiLiqham4cvS08IiMiphmnndnTo8ZiTiph1nwfYVD9Ciciqh+nAhPWt9xijirh+luibXw+Sinish7lAi3YF+dinish7k/i3YF+d]],
				["WingFinger3.R"] = [[
					isiYiwpggrZb90jEifippKj4bX+DjvjKiPnKrChO9IjykZhxjHw5om5ljVlNhifrzMtG1/j+jyhlkevQki7ZiZiaiDn7ckVG8zh3iaiKteYgU05sh2iaiKtt
					YWU15ih2iZiMt3YhU75ih6iUiYunZkVc5oiHiQinuXb2Wc6niZiRiyszeWX48IimiWizqqgCZA9VisiYiwphgqZb90isiYiwpggrZb90]],
				["Vine.R"] = [[
					iOikhIzoWJhn3NiUirhG0gYMhm3PibjAhD2BeKjN26iXjfhC4mk5lszBiMjzhF6FoUjxwIiejOgw3RfYfR17iIiYgZpySJch65h+ifgiqtUEhf7oh9ifgjv8
					T5l34Qh9igglyQR+kA12h/ihgxwRRHgw3KiDijhAvnTPgv40iIikhKyFVdiZ4EiMilhKzzWHiX2+iOikhIzxWIhq3EiOikhIzoWJhn3N]],
				Tail1 = [[
					gAhngWisgAgA/4gAhmgZi5gAgA/3gAhkgfjZgAgA/0gAhhgmj8gAgA/vgAhfgrkUgAgA/sgAhigZjDgAgA/2gAhnfrgegAgA//gAhnfriFgAgA/7gAhnfriJ
					gAgA/6gAhnftiRgAgA/6gAhnf3i4gAgA/3gAhngGjYgAgA/0gAhngSjbgAgA/zgAhngWjAgAgA/2gAhngWitgAgA/4gAhngWisgAgA/4]],
				Tail2 = [[
					gAhbhahLgAgA/+gAhahchLgAgA/+gAhVhihLgAgA/+gAhQhphLgAgA/+gAhNhthLgAgA/+gAhVhcgegAgA//gAhlgwfggAgA//gAhegvitgAgA/4gAhegvi2
					gAgA/3gAhdgxi9gAgA/2gAhbg7jigAgA/ygAhYhJjlgAgA/ygAhYhVi6gAgA/3gAhahahzgAgA/8gAhbhahLgAgA/+gAhbhahLgAgA/+]],
				Tail3 = [[
					gAhWifgKgAgA//gAhVihf+gAgA//gAhQinfegAgA//gAhLiue6gAgA/+gAhIiyeigAgA/9gAhTiheagAgA/8gAhnh1fDgAgA/+gAhShzj3gAgA/wgAhRhzkE
					gAgA/ugAhQh1kLgAgA/tgAhLh+ktgAgA/pgAhJiMkUgAgA/sgAhMiZi5gAgA/3gAhSiehGgAgA/+gAhWifgLgAgA//gAhWifgKgAgA//]],
				["UpperLeg.L"] = [[
					fhhWgQ5RaZgAyzfhhVgS5waPfyyFfhhTgY6xZ+fVwafhhRge7rZ1e6uxfhhQgi8JZ1eut1fhhRgR6iZtfIwtfhhVfov3c9h57jfhhVfov3c9h57jfhhVfov3
					c9h57jfhhVfqwJc6h37YfhhVfzxxcphv6VfhhVgB2va4gl16fhhVgN4yabgFzbfhhWgQ5RaZgAyzfhhWgQ5RaZgAyzfhhWgQ5RaZgAyz]],
				["LowerLeg.L"] = [[
					fagzgFzmgAgA5SfZgzgFzpgIgH5QfZgzgG0FgUgU45fYg0gI1AgYge4HfYg0gK1ygXgh3bfYgxgAxogxgb6sfdg1f6wBere/7pfdg1f6wBere/7pfdg1f6wB
					ere/7pfdg0f8wTeqe/7efdgygBx9eme76afagxf/w3f7fr7MfZgygDysgEf+59fagzgFzmgAgA5SfagzgFzmgAgA5SfagzgFzmgAgA5S]],
				["Foot.L"] = [[
					fagVgN/PgAgAm3fagVgN/PgKf+m3fagVgN/Pgbf6m3fagVgN/Pgjf4m3fagVgN/Pgjf4m3fagVgN/Pg3f0m3fagagK+VeXgMqBfagagK+VeXgMqBfagagK+V
					eXgMqBfagZgK+feWgNpjfagWgM/FeTgWnYfagVgN/PfygDm3fagVgN/PgDf/m3fagVgN/PgAgAm3fagVgN/PgAgAm3fagVgN/PgAgAm3]],
				["UpperLeg.R"] = [[
					gfhWgQ5RlngAyzgfhVgS5wlxgOyFgfhTgY6xmCgrwagfhRge7rmLhGuxgfhQgi8JmLhSt1gfhRgR6imTg4wtgfhVfov3jDeH7jgfhVfov3jDeH7jgfhVfov3
					jDeH7jgfhVfqwJjGeJ7YgfhVfzxxjXeR6VgfhVgB2vlIfb16gfhVgN4yllf7zbgfhWgQ5RlngAyzgfhWgQ5RlngAyzgfhWgQ5RlngAyz]],
				["LowerLeg.R"] = [[
					gmgzgFzmgAgA5SgngzgFzpf4f55QgngzgG0Ffsfs45gog0gI1Afofi4Hgog0gK1yfpff3bgogxgAxofPfl6sgjg1f6wBhVhB7pgjg1f6wBhVhB7pgjg1f6wB
					hVhB7pgjg0f8wThWhB7egjgygBx9hahF6agmgxf/w3gFgV7MgngygDysf8gC59gmgzgFzmgAgA5SgmgzgFzmgAgA5SgmgzgFzmgAgA5S]],
				["Foot.R"] = [[
					gmgVgN/PgAgAm3gmgVgN/Pf2gCm3gmgVgN/PflgGm3gmgVgN/PfdgIm3gmgVgN/PfdgIm3gmgVgN/PfJgMm3gmgagK+Vhpf0qBgmgagK+Vhpf0qBgmgagK+V
					hpf0qBgmgZgK+fhqfzpjgmgWgM/FhtfqnYgmgVgN/PgOf9m3gmgVgN/Pf9gBm3gmgVgN/PgAgAm3gmgVgN/PgAgAm3gmgVgN/PgAgAm3]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhngWECgAgAvggAhkgWDvgAgAu9gAhfgWDGgAgAttgAhagWCogAgAsqgAhbgWCtgAgAs2gAhmgWEMgAgAvygAhugWFkgAgAyAgAhvgWFzgAgAyWgAhvgWFz
					gAgAyWgAhvgWFzgAgAyWgAhvgWFzgAgAyWgAhvgWFzgAgAyWgAhvgWFzgAgAyWgAhvgWFzgAgAyWgAhvgWFzgAgAyWgAhvgWFzgAgAyWgAhvgWFzgAgAyWgA
					hugWFxgAgAySgAhsgWFHgAgAxUgAhogWESgAgAv+gAhngWECgAgAvggAhngWECgAgAvggAhngWECgAgAvg]],
				Spine = [[
					gAiGgDFPgAgAxggAiCgCEygAgAwzgAh7f/D2gAgAvMgAh0f9DKgAgAt1gAh2f+DSgAgAuEgAiFgEFlgAgAyBgAiPgJH5gAgA1BgAiRgKITgAgA1fgAiRgKIT
					gAgA1fgAiRgKITgAgA1fgAiRgKITgAgA1fgAiRgKITgAgA1fgAiRgKITgAgA1fgAiRgKITgAgA1fgAiRgKITgAgA1fgAiRgKITgAgA1fgAiRgKITgAgA1fgA
					iQgKIPgAgA1agAiNgHHGgAgA0EgAiHgEFrgAgAyKgAiGgDFPgAgAxggAiGgDFPgAgAxggAiGgDFPgAgAxg]],
				Neck1 = [[
					gAikf1GDgAgAytgAigfzFagAgAxxgAiXftEEgAgAvkgAiPfoDGgAgAttgAiQfpDRgAgAuCgAilf3GlgAgAzbgAixgEKJgAgA3XgAiygGKygAgA38gAiygGKy
					gAgA38gAiygGKygAgA38gAiygGKygAgA38gAiygGKygAgA38gAiygGKygAgA38gAiygGKygAgA38gAiygGKygAgA38gAiygGKygAgA38gAiygGKygAgA38gA
					iygGKrgAgA32gAiugAI6gAgA2IgAinf4GugAgAzmgAikf1GDgAgAytgAikf1GDgAgAytgAikf1GDgAgAyt]],
				Neck2 = [[
					gAi8fuGDgAgAytgAi3fpFPgAgAxggAisfgDlgAgAurgAiifZCdgAgAsQgAijfaCpgAgAssgAi8fxGxgAgAzpgAjJgGLggAgA4jgAjKgJMXgAgA5QgAjKgJMX
					gAgA5QgAjKgJMXgAgA5QgAjKgJMXgAgA5QgAjKgJMXgAgA5QgAjKgJMXgAgA5QgAjKgJMXgAgA5QgAjKgJMXgAgA5QgAjKgJMXgAgA5QgAjKgJMXgAgA5QgA
					jKgJMOgAgA5IgAjGf/J0gAgA3DgAi+fyG7gAgAz2gAi8fuGDgAgAytgAi8fuGDgAgAytgAi8fuGDgAgAyt]],
				Neck3 = [[
					gAjNfoGDgAgAytgAjIfiFEgAgAxPgAi6fVDIgAgAtwgAiufMB5gAgAqxgAixfNCFgAgArUgAjOfsG8gAgAz4gAjbgJM6gAgA5qgAjcgOOBgAgA6dgAjcgOOB
					gAgA6dgAjcgOOBgAgA6dgAjcgOOBgAgA6dgAjcgOOBgAgA6dgAjcgOOBgAgA6dgAjcgOOBgAgA6dgAjcgOOBgAgA6dgAjcgOOBgAgA6dgAjcgOOBgAgA6dgA
					jcgNN1gAgA6VgAjYgAKxgAgA37gAjQfuHIgAgA0GgAjNfoGDgAgAytgAjNfoGDgAgAytgAjNfoGDgAgAyt]],
				Head = [[
					gAjefiADgAgAhTgAjYfaACgAgAe0gAjJfKAvgAgAZPgAi6e+CBgAgAU3gAi9fABwgAgAVogAjgfoAOgBftjhgAjsgODvgUfRu8gAjtgVD5fVhhvLgAjtgVEk
					gNflwbgAjtgVE2gle4w3gAjtgVD7fZhZvQgAjtgVEZgAgAwKgAjtgVE9gteqxAgAjtgVEAffhKvagAjtgVEPfzgbv4gAjtgVFAgxeixFgAjtgVEHfog1vogA
					jtgUD9fpg0vXgAjqgCCNgTfArmgAjifqAPgAgFjtgAjefiADgAgAhTgAjefiADgAgAhTgAjefiADgAgAhT]],
				Jaw = [[
					gAjqfJ/+gAgAg8gAjgfA/xgAgAjvgAjHeu+agAgAp6gAiwek8cgAgAupgAi0em82gAgAt2gAjufR/wf7gTj0gBkHgI/9faghe8f9kIgO/8hUfAgYgBkIgR/+
					fngRe9gCkIgS/7e9gtebf+kIgO/9hOfFgSgAkIgQ/+gAgAfRgCkIgS/6evg2eQf+kIgP/9hBfPgHf/kIgQ//gYfuflgDkIgS/5eng6eKf/kIgP/+gvfef4f/
					kIgO/+gtfdf5gCkDf1/9fYg2fMgAjxfT/+gBf7gugAjqfJ/+gAgAg8gAjqfJ/+gAgAg8gAjqfJ/+gAgAg8]],
				Crest = [[
					gAlGfeaHgAgA/cgAk+fGXrgAgA+5gAkieUSagAgA89gAkAdxObgAgA6ugAkHd3PHgAgA7KgAlHfzdBftf8/2gAkxhdqBfVfk+XgAkwhkpThXg9+kgAkphqrq
					fnfu9ygAkmhssge+fQ9agAkvhkpdhQg4+hgAkqhprJgAgA9/gAklhssyexfH9SgAkvhlpvhCgv+cgAkshnqogZgS+LgAkkhts7eqfC9OgAkthmqJgvgi+UgA
					kvhkp1gvgg+bgAk/g+mLfEfi/XgAlJf2cugFgB/0gAlGfeaHgAgA/cgAlGfeaHgAgA/cgAlGfeaHgAgA/c]],
				["Humerus.L"] = [[
					fYijf3X7M+gA4afYiff1YCNqg648fYiVfvX/Pgi06DfYiNfrXqRTkL61fYiPfrXvQ9j86tfYijf5X2Ngd34tfYiugGWqNoX03DfYiwgIWZN9W020fYiwgIWZ
					N9W020fYiwgIWZN9W020fYiwgIWZN9W020fYiwgIWZN9W020fYiwgIWZN9W020fYiwgIWZN9W020fYiwgIWZN9W020fYiwgIWZN9W020fYiwgIWZN9W020fY
					ivgHWcN5W+22fYirgBXINJZ+3gfYilf6XyM3ed4PfYijf3X7M+gA4afYijf3X7M+gA4afYijf3X7M+gA4a]],
				["Forearm.L"] = [[
					eYi9gDYAMSgA34eYi4gEYcM2hS4ceaisgHZTOej95medikgJZ0QKl26decilgJZvP2lh6UecjEgHX7Myd84LeojggRVzNsWy2VerjkgUVcOKVq2DerjkgUVc
					OKVq2DerjkgUVcOKVq2DerjkgUVcOKVq2DerjkgUVcOKVq2DerjkgUVcOKVq2DerjkgUVcOKVq2DerjkgUVcOKVq2DerjkgUVcOKVq2DerjkgUVcOKVq2Der
					jkgUVgOFV22GeijXgMWfM7ZO23eajEgEXqMReQ3seYi9gDYAMSgA34eYi9gDYAMSgA34eYi9gDYAMSgA34]],
				["WingFinger1.L"] = [[
					dbjWgLZ/L8gA4LdajMgPa2Mehs4vdci5gccyOMlJ53dhitgmeRQDnf6pdgivgleAPsnG6hdhjigRZ0MXd04Yd/kUgbWdN7VB2AeGkbgfV8OkTq1leGkbgfV8
					OkTq1leGkbgfV8OkTq1leGkbgfV8OkTq1leGkbgfV8OkTq1leGkbgfV8OkTq1leGkbgfV8OkTq1leGkbgfV8OkTq1leGkbgfV8OkTq1leGkbgfV8OkTq1leF
					kageWCOdT41pdykFgUXeM4X72ydfjjgLZXL7d836dbjWgLZ/L8gA4LdbjWgLZ/L8gA4LdbjWgLZ/L8gA4L]],
				["WingFinger2.L"] = [[
					chjogTd6LtgA4ocfjYgcfDMch55Ocji4gyhnOvlr6RctikhFjqRHoJ63crinhBjTQqnw6xcqj5gcdnL7do4qdclFgmZFNFTq1jdolOgsXkOhQ80fdolOgsYQ
					N3R704dolOgsYhNoST1BdolOgsXnOfRA0hdolOgsYGOARt0zdolOgsYmNjSa1DdolOgsXsOZRI0kdolOgsX8OKRf0tdolOgsYpNhSf1FdolOgsXzOSRS0odm
					lNgrX7OKRj0vdGkugcapL+XM2tcnj6gTc+Lgdm4PchjogTd6LtgA4ochjogTd6LtgA4ochjogTd6LtgA4o]],
				["WingFinger3.L"] = [[
					bpjugehlMQgA5HbojWgqjANUiL5sbxiohJmLQbmc6ecEiMhjotTfpH6mcAiQhfoQS6os6nbzkFgnhMMQdb5Ac4lwgybeM1SC0+dOl/g7YtPGN0yydKl9g5aR
					NwP3z7dJl8g5a3NTQr0TdOl/g7YzPAN8y3dLl9g6Z6OCPZzsdIl8g5bENKQ80adOl/g7Y/O1OLzAdMl+g6ZkOVO8zcdIl8g5bKNGRF0edNl+g6ZQOmOhzNdK
					l8g5ZaOcO0zYcZlQgldoLuWS2obxkIgcgVLydL4nbpjugehlMQgA5HbpjugehlMQgA5HbpjugehlMQgA5H]],
				["Vine.L"] = [[
					dZjJgWzkgXip5KdZi/gbv2hYiL7rdfisgot8ivhL8pdoihgyvJjyfB76dmijgxyzjZdQ5hdejUgc33chdP01d0kIgi4ZXLcjyZd7kPgm2dXucj08d7kPgmzZ
					YxbJ35d7kPgmxHYFY342d7kPgmxfWSXG3Ud7kPgm0TVIWx0Md7kPgm3SVKYcxfd7kPgm4cV3bFxRd7kPgm3RXMckzzd7kPgm0cYkby3Ed7kPgmxpYhZn4zd6
					kOgmxBW/Xv4Ldpj3gczPXlZZ3NdbjVgW1/bdcs2jdZjJgW3ieHfS1ldZjJgW2ufbhr2ddZjJgWzkgXip5K]],
				["Humerus.R"] = [[
					goijf3X7zCgA4agoiff1YCyWfG48goiVfvX/wgdM6DgoiNfrXqutb161goiPfrXvvDcE6tgoijf5X2ygiJ4tgoiugGWqyYoM3DgoiwgIWZyDpM20goiwgIWZ
					yDpM20goiwgIWZyDpM20goiwgIWZyDpM20goiwgIWZyDpM20goiwgIWZyDpM20goiwgIWZyDpM20goiwgIWZyDpM20goiwgIWZyDpM20goiwgIWZyDpM20go
					ivgHWcyHpC22goirgBXIy3mC3ggoilf6XyzJhj4Pgoijf3X7zCgA4agoijf3X7zCgA4agoijf3X7zCgA4a]],
				["Forearm.R"] = [[
					hoi9gDYAzugA34hoi4gEYczKeu4chmisgHZTxicD5mhjikgJZ0v2aK6dhkilgJZvwKaf6UhkjEgHX7zOiE4LhYjggRVzyUpO2VhVjkgUVcx2qW2DhVjkgUVc
					x2qW2DhVjkgUVcx2qW2DhVjkgUVcx2qW2DhVjkgUVcx2qW2DhVjkgUVcx2qW2DhVjkgUVcx2qW2DhVjkgUVcx2qW2DhVjkgUVcx2qW2DhVjkgUVcx2qW2DhV
					jkgUVgx7qK2GhejXgMWfzFmy23hmjEgEXqzvhw3shoi9gDYAzugA34hoi9gDYAzugA34hoi9gDYAzugA34]],
				["WingFinger1.R"] = [[
					iljWgLZ/0EgA4LimjMgPa2zieU4viki5gccyx0a353ifitgmeRv9Yh6pigivgleAwUY66hifjigRZ0zpiM4YiBkUgbWdyFq/2Ah6kbgfV8xcsW1lh6kbgfV8
					xcsW1lh6kbgfV8xcsW1lh6kbgfV8xcsW1lh6kbgfV8xcsW1lh6kbgfV8xcsW1lh6kbgfV8xcsW1lh6kbgfV8xcsW1lh6kbgfV8xcsW1lh6kbgfV8xcsW1lh7
					kageWCxjsI1piOkFgUXezIoF2yihjjgLZX0FiE36iljWgLZ/0EgA4LiljWgLZ/0EgA4LiljWgLZ/0EgA4L]],
				["WingFinger2.R"] = [[
					jfjogTd60TgA4ojhjYgcfDzkeH5Ojdi4gyhnxRaV6RjTikhFjqu5X363jVinhBjTvWYQ6xjWj5gcdn0FiY4qiklFgmZFy7sW1jiYlOgsXkxfvE0fiYlOgsYQ
					yJuF04iYlOgsYhyYtt1BiYlOgsXnxhvA0hiYlOgsYGyAuT0ziYlOgsYmydtm1DiYlOgsXsxnu40kiYlOgsX8x2uh0tiYlOgsYpyfth1FiYlOgsXzxuuu0oia
					lNgrX7x2ud0vi6kugcap0Co02tjZj6gTc+0gia4PjfjogTd60TgA4ojfjogTd60TgA4ojfjogTd60TgA4o]],
				["WingFinger3.R"] = [[
					kXjugehlzwgA5HkYjWgqjAysd15skPiohJmLvlZk6ej8iMhjotshW56mkAiQhfoQtGXU6nkNkFgnhMzwil5AjIlwgybezLt+0+iyl/g7Ytw6yMyyi2l9g5aR
					yQwJz7i3l8g5a3ytvV0Tiyl/g7YzxAyEy3i1l9g6Z6x+wnzsi4l8g5bEy2vE0aiyl/g7Y/xLx1zAi0l+g6ZkxrxEzci4l8g5bKy6u70eizl+g6ZQxaxfzNi2
					l8g5ZaxkxMzYjnlQgldo0Spu2okPkIgcgV0Oi14nkXjugehlzwgA5HkXjugehlzwgA5HkXjugehlzwgA5H]],
				["Vine.R"] = [[
					injJgWzkfpdX5Kini/gbv2eod17rihisgot8dRe18piYihgyvJcOg/76iaijgxyzcniw5hiijUgc33jfix01iMkIgi4Zo1jdyZiFkPgm2doSjd08iFkPgmzZ
					nPk335iFkPgmxHn7nJ42iFkPgmxfpuo63UiFkPgm0Tq4pP0MiFkPgm3Sq2nkxfiFkPgm4cqJk7xRiFkPgm3Ro0jczziFkPgm0cnckO3EiFkPgmxpnfmZ4ziG
					kOgmxBpBoR4LiXj3gczPobmn3NiljVgW1/kjjU2jinjJgW3ih5gu1linjJgW2ugleV2dinjJgWzkfpdX5K]],
				Tail1 = [[
					gAhngWisgAgA/4gAhkgWh3gAgA/8gAhfgWf/gAgA//gAhagWeegAgA/9gAhbgWevgAgA/9gAhmgWhbfzgC/9gAhugWiNfegD/6gAhvgWiJhGf5/5gAhvgWiJ
					fsgC/6gAhvgWiJfKgF/6gAhvgWiJhBf5/5gAhvgWiJgAgA/6gAhvgWiJe/gH/5gAhvgWiJg2f7/6gAhvgWiJgUf+/6gAhvgWiJe6gH/5gAhvgWiJgmf8/6gA
					hugWiKgmf8/6gAhsgWiWfUgE/5gAhogWingDgA/4gAhngWisgAgA/4gAhngWisgAgA/4gAhngWisgAgA/4]],
				Tail2 = [[
					gAhbhahLgAgA/+gAhchbgIgAgA//gAhfhbdygAgA/6gAhhhbb5gAgA/ugAhghbcOgAgA/xf/hghbeUfmgC/8f+hkhadQe9gD/2gFhlhactiMf4/vf/hlhbct
					fYgC/0f8hlhacteVgG/xgEhlhactiBf5/wgAhlhbctgAgA/0f8hlhactd/gH/wgEhlhacthrf6/xgBhlhbctgof+/0f7hlhactd0gI/vgDhlhacthNf8/zgD
					hlhaczhLf8/zf9hihaeWengE/6gAhdhagegGgA//gAhbhahLgAgA/+gAhbhahLgAgA/+gAhbhahLgAgA/+]],
				Tail3 = [[
					gAhWifgKgAgA//gAhcige6gAgA/+gAhoifcHgAgA/wgAhyieZ3gAgA/ZgAhxieaQgAgA/ef9hnifbvfZgC/sf5hwieY4ecgC/JgOhzidX5jQf7+xf8hzieX4
					fFgB+7f1hzieX4dhgE+2gNhzidX4i/f8+zgAhzieX4gAgA+8fzhzidX4dBgE+zgLhzieX4iff8+2gEhzieX4g7f/+7fyhzidX5cwgF+xgIhzieX4hyf9+5gI
					hzieYDhvf++8f3hpifa6d7gC/ggBhbife2gKgA/+gAhWifgKgAgA//gAhWifgKgAgA//gAhWifgKgAgA//]],
				["UpperLeg.L"] = [[
					fhhWgQ5RaZgAyzfhhTgR6GZuffxafhhNgT7RYjeou6fhhIgU75XweCtKfhhJgU7zX5eJtdfhhVgQ5baTf4ykfhhegN2ecWhP2cfhhfgN2bcZhO2gfhhfgN2b
					cZhO2gfhhfgN2bcZhO2gfhhfgN2bcZhO2gfhhfgN2bcZhO2gfhhfgN2bcZhO2gfhhfgN2bcZhO2gfhhfgN2bcZhO2gfhhfgN2bcZhO2gfhhfgN2bcZhO2gfh
					hfgN2bcZhP2ffhhbgO2mcOhQ2TfhhXgQ4pa3gWzvfhhWgQ5RaZgAyzfhhWgQ5RaZgAyzfhhWgQ5RaZgAyz]],
				["LowerLeg.L"] = [[
					fagzgFzmgAgA5SfYgygCyRgfgd6QfWgwf+wOhMhN7hfVguf7vDhmhs8JfVgvf8vPhihm8DfZgzgEzLgJgD5nfdg5gN2re1e02gfdg6gN2ne3e02kfdg6gN2n
					e3e02kfdg6gN2ne3e02kfdg6gN2ne3e02kfdg6gN2ne3e02kfdg6gN2ne3e02kfdg6gN2ne3e02kfdg6gN2ne3e02kfdg6gN2ne3e02kfdg6gN2ne3e02kfd
					g6gN2oe3e02jfdg2gN2zeve02XfagzgH0dfqfr4lfagzgFzmgAgA5SfagzgFzmgAgA5SfagzgFzmgAgA5S]],
				["Foot.L"] = [[
					fagVgN/PgAgAm3fagVgN/Pgnf3m3fagVgN/Nhmfqm3fagVgN/LiLfim2fagVgN/LiFfjm2fagVgN/PgJf+m3fagagN+nedgLpIfagbgN+eeggIpofagbgN+e
					eggIpofagbgN+eeggIpofagbgN+eeggIpofagbgN+eeggIpofagbgN+eeggIpofagbgN+eeggIpofagbgN+eeggIpofagbgN+eeggIpofagbgN+eeggIpofa
					gbgN+feggJpjfagYgN+6eYgRoGfagVgN/PfkgGm3fagVgN/PgAgAm3fagVgN/PgAgAm3fagVgN/PgAgAm3]],
				["UpperLeg.R"] = [[
					gfhWgQ5RlngAyzgfhTgR6GmSghxagfhNgT7RndhYu6gfhIgU75oQh+tKgfhJgU7zoHh3tdgfhVgQ5bltgIykgfhegN2ejqex2cgfhfgN2bjney2ggfhfgN2b
					jney2ggfhfgN2bjney2ggfhfgN2bjney2ggfhfgN2bjney2ggfhfgN2bjney2ggfhfgN2bjney2ggfhfgN2bjney2ggfhfgN2bjney2ggfhfgN2bjney2ggf
					hfgN2bjnex2fgfhbgO2mjyew2TgfhXgQ4plJfqzvgfhWgQ5RlngAyzgfhWgQ5RlngAyzgfhWgQ5RlngAyz]],
				["LowerLeg.R"] = [[
					gmgzgFzmgAgA5SgogygCyRfhfj6Qgqgwf+wOe0ez7hgrguf7vDeaeU8Jgrgvf8vPeeea8DgngzgEzLf3f95ngjg5gN2rhLhM2ggjg6gN2nhJhM2kgjg6gN2n
					hJhM2kgjg6gN2nhJhM2kgjg6gN2nhJhM2kgjg6gN2nhJhM2kgjg6gN2nhJhM2kgjg6gN2nhJhM2kgjg6gN2nhJhM2kgjg6gN2nhJhM2kgjg6gN2nhJhM2kgj
					g6gN2ohJhM2jgjg2gN2zhRhM2XgmgzgH0dgWgV4lgmgzgFzmgAgA5SgmgzgFzmgAgA5SgmgzgFzmgAgA5S]],
				["Foot.R"] = [[
					gmgVgN/PgAgAm3gmgVgN/PfZgJm3gmgVgN/NeagWm3gmgVgN/Ld1gem2gmgVgN/Ld7gdm2gmgVgN/Pf3gCm3gmgagN+nhjf1pIgmgbgN+ehgf4pogmgbgN+e
					hgf4pogmgbgN+ehgf4pogmgbgN+ehgf4pogmgbgN+ehgf4pogmgbgN+ehgf4pogmgbgN+ehgf4pogmgbgN+ehgf4pogmgbgN+ehgf4pogmgbgN+ehgf4pogm
					gbgN+fhgf3pjgmgYgN+6hofvoGgmgVgN/Pgcf6m3gmgVgN/PgAgAm3gmgVgN/PgAgAm3gmgVgN/PgAgAm3]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAhngWECgAgAvggAhlgWD8gcgzvUgAhXgWDUhIhzt/gAh7gWEQhBh3vxgAicgWEtgmhLwogAiqgWE4gAgAw8gAikgWE0fbe1wzgAiKgWEhfBeHwOgAhcgWDh
					e6eMuZgAhYgWDUfUe5uEgAhcgWDdgAgAubgAiKgWEegnhLwPgAikgWE2g8h6wxgAiqgWE7g8h6w6gAicgWEtgmhLwogAh7gWEMgAgAvzgAhXgWDSfUe5uBgA
					hlgWD/e9eKvSgAhngWEEfLegvfgAhngWECf0frvggAhngWECgAgAvg]],
				Spine = [[
					gAiGgDFPgAgAxgf/iDgDFIgggwxUf9h0gAEahQhuwDf9iagEFehJhyxwf+i8gGGAgrhIylgAjKgGGLgAgAy4gCjEgGGHfVe4yvgDiqgFFxe5eMyMgDh5gBEp
					exeRwcgCh1gAEafPe8wIgAh5gBElgAgAwef+iqgFFvgshHyNf9jEgGGJhFh1ytf9jKgGGPhEh1y1f+i8gGGAgrhIylgAiagEFbgAgAxygCh0gAEYfOe8wEgD
					iDgDFLe1ePxSgCiGgDFRfEekxfgAiGgDFPfzfsxggAiGgDFPgAgAxg]],
				Neck1 = [[
					gAikf1GDgAgAytf+iif1F4gigvycf8iRfvEyhThswqf8i5f3GchPhuzGf9jcf7HUgwhF0TgAjqf8HqgAgA0vgDjkf7HhfQe70igEjKf5G7eyeRzvgEiXfxFI
					eueUxNgDiSfwEyfNe9wwgAiXfxFEgAgAxQf9jKf5G4gwhFzwf8jkf8HjhNhw0hf8jqf8HthNhw0sf9jcf7HUgwhF0TgAi5f3GYgAgAzJgDiRfvEvfNe9wrgE
					iif1F7eweSyagEikf2GGfAenyrgBikf1GDfyftytgAikf1GDgAgAyt]],
				Neck2 = [[
					gAi8fuGDgAgAytf+i5fsF1gigvyXf7infkEZhQhuwBf7jRfwGkhQhuzRf9jzf2HygxhE03gAkCf4IRgAgA1cgDj8f3IEfPe81LgFjhfzHOeweS0HgFitfnE2
					eweSwwgDioflEbfPe8wJgAitfnEygAgAwzf9jhfzHMgxhE0If7j8f3IGhQhu1Jf7kCf4IUhQhu1Zf9jzf2HygxhE03gAjRfwGggAgAzUgDinfkEXfPe8wCgF
					i5ftF4exeSyVgEi8fuGGfAenyrgBi8fuGDfyftytgAi8fuGDgAgAyt]],
				Neck3 = [[
					gAjNfoGDgAgAytf9jKfmFxgigvySf6i3fbEChNhwvXf6jifrGshQhtzcf8kFfzIRgzhD1ZgAkVf2I5gAgA2HgEkOf1IofNe91zgGjzfwHheveT0egGi9ffEk
					eyeRwTgEi4fcEEfQe7vigAi9feEggAgAwVf8jzfvHfgyhD0gf6kOf1IqhThs1xf6kVf3I8hThr2Ef8kFfzIRgzhD1ZgAjifrGogAgAzfgEi3fbD/fQe7vZgG
					jKfnF0exeSyQgFjNfoGGfAenyrgBjNfoGDfyftytgAjNfoGDgAgAyt]],
				Head = [[
					gAjefiADgAgAhTf9jbfgAFedhAg2f4jGfSAbcZitdrf5j0fnAZcaiJigf8kYfxAfdzhKk3gAknf1AigAgAltgEkgf0AkiMe5lYgGkFfsAhjleBj0gHjNfWAW
					jndbeugFjHfSAOiPeVdqgAjNfWADgAgAeef8kFfsAVdyhPjsf6kgf0Avcehylgf6knf2A0cfhvl6f8kYfxAfdzhKk3gAj0fmAGgAgAiRgFjGfRAPiPeUdggH
					jbfgAVjndshCgGjefiAPi8eKhdgBjefiADgpfnhUgAjefiADgAgAhT]],
				Jaw = [[
					gAjqfJ/+gAgAg8f6jmfH/IhwfbnIfyjLe39GkSensgfzkBfP+tkGfJn8f5kofc/YidfolsgAk5fh/ngAgAk3gHkxff/edkgWlKgMkUfW/Bb+gumqgNjUe89g
					bwhRrhgIjNe39SdWg2skgAjUe79tgAgAr3f4kUfV/Jigfjm2f0kxff/Wj7fek/f0k4fh/aj5fgklf5kofc/YidfolsgAkBfO+6gAgAoQgIjLe39OdWg3sugN
					jmfI+Sb1hBpWgKjpfK+6crg8ndgCjqfJ/0fUgTjTgAjqfJ/+gAgAg8]],
				Crest = [[
					gAlGfeaHgAgA/cfylCfZYPgjhx++fekoe5VbhqkM92filZfscphdj7/iful9gFfygyiX/5gAmMgOehgAgA/9gSmFgLcGfkdl/qgdlqf6bYfCcC/YghkwfEY7
					eIb/+4gVkre4Ypetdi/AgAkzfAXWgAgA+zfulrf4aagjie/ZfkmDgNdEgzj4/nfkmJgRgFhEjy/vful9gFfygyiX/5gAlcfpbEgAgA/mgVkpe2UdfCdY9tgf
					lAfdYpeub6+1gZlEfhbWexcx/dgGlGfeaufvfT/igAlGfeaHgAgA/c]],
				["Humerus.L"] = [[
					fYijf3bOQuht7pfWigf5TtP/W13DfUiQf3PzP4V7z+fUi3f+VkN2ZU3PfVjZgAX6MyZ83ffYjof+UuOGVd1ifajif6R6QCRXy2fcjIf2S8OKSsy5fciUfuVg
					KmY+0IfaiQfuWWKdbF1AfYiVfzS1NOXH0cfVjHf+QeRQTAz5fUjhgDR3Q9UX1efUjogDWiOJYl3qfVjZgAX6MyZ83ffYi3f5T2NrWN1DfaiPfuQGOqTCxXfc
					igfxSUNuTTycfbijfzXVLqZu2PfYijf2aVOxfU6VfYijf3bOQuht7p]],
				["Forearm.L"] = [[
					edixgacCbKls+2ezjbgHU5XSUG6He+jTf1QNWLQm0+ekjpgIUnUkU95TeekDgKWtThV96EezkjgGU5U4RE3gfNkmgCTbWpMt0HfGkKf5UHUrOA0uerjGfmVB
					QwUN3Ceji6foVPQjWa4BezjQfxS0TkSI2afJkMgFRiX2OH0re+kjgOSYXwPt2cekkYgRVrVCUf5weekDgKWtThV96Eezjzf8T7URRi3BfNjUfoRfUxNvyxfG
					jifwTbUFOZ0UeljOf2XFScWw5+ebi5gPakXuhC+ZedixgacCbKls+2]],
				["WingFinger1.L"] = [[
					eGi9hYewprnw9demkOgwcjcnWM+DfDkSgLWbYfRQ5peOkfgpYkaUTd75eAkzgtZxaMT+8ZenlbgpabYuRQ63fUlfglacXFO545fDlFgYaiWUPq5JeOj/f7Y/
					WDS+6jeAjvf9YPW0UG7JenkOgJYCXbR+6QfUlGgkYnYxPw5ifDlcgwZCZ/Ql6eeOlMg3Zva2TP8LeAkzgtZxaMT+8ZenkugaZUYHRl6nfUkSf/X/VbP34OfD
					kfgMZsVxQA49eBj9gXbZZdWd9dd5jNhFd1kDiU/keGi9hYewprnw9d]],
				["WingFinger2.L"] = [[
					enjLiKgzqVkd97eekfhqhkajU79ee9k8g2a6VdQ+5seHlAhbaTZqRJ7Ad1lRhiamaSRM7PeZl6hcdpXBP86EfFmChUfkTRPh4RexlohGfATWPv4cd6kkgmbD
					VaQ85rdtkWgoZZWwRZ6FeZk1g1bUVnQ05vfNlrhUdzU9QB5Ue9l9hjdfXAQA6EeHlphsbbaSQ57Od1lRhiamaSRM7PeZlQhKckWXQV58fFk+gndKRsQ34Hex
					lFg3eLSzQL4ZdwkVhMdfZBUM8yeIjWiAfpkRfY/senjLiKgzqVkd97]],
				["WingFinger3.L"] = [[
					fKjNi3iorahX9veKkgignFZfUe8QenlchggCTeRX5hd9lciMbtZkO052dtlriUa0a3OV5peDmRiLhBWFO85Jekmah7leQrRZ3VeQmChtkBRZQp3ndklEhQc0
					VYO04lddk4hTZ+XMOi4keDlUhgevUlP55IeymEh/j5SXRc4tenmViSilU/QM5Zd9mAifcyaSOj6AdtlriUa0a3OV5peDlrh4f+VYPX5KekldhIjIPSS/3weQ
					lihdjOQ4RJ3vddkmh/fRZKR976eXjXi3hHk7co/afKjNi3iorahY9v]],
				["Vine.L"] = [[
					eRiwhdzMvtbBzledkCg5w3faR53Oe1kNgWsjVKM2zheFkTgy1nXuQ5wGd3kmg16EZ0W4u5eZlSgw2qYtVtyufElbgrwrXSOpzLezk/gewgUQN8w7eCj0gC2q
					VBUXv8d2jjgF5SX1ZqwpeZkFgS04XzWa0sfGlCgtu3YoNo0Qe1lWg5ubXIL3yLeFk/g/2RYWQkvMd3kmg16EZ0W4u5eZkkgi13YSWBzpfEkPgGusVmPm0vez
					kagSv7TqOWxed6jvge3gZjTkwkd/i+hM4imxWiw7eRiwhdzNvtbBzl]],
				["Humerus.R"] = [[
					goijf3bOvSeT7pgnigf0URxUp22HgkiPfsRfy2r3xzgki3f0Wf1CoE0ngmjaf5YT1Bm31zgojof+Uux6qj1igrjhgAQ4uftS0NgsjHgARbvSrV1MgsiVf4Uc
					ydlz2tgriRf1VzzskT2pgoiVfzS1yyo50cgmjIf3RiwRuUykgkjif4TVxktrzKgkjpf5XW0so80/gmjaf5YT1Bm31zgoi3f5T2yVpz1DgriQf1O9vvryymgs
					igf8Quvqq00sgrijf8Wtx1lT4Tgpijf4aUwogk6ugoijf3bOvSeT7p]],
				["Forearm.R"] = [[
					hjixgacCk2aU+2hLjbf+VmqMsg5lg6jRflShsuxDzuhVjqfxWJuqsi3ihdkEf7Xeuhq945hNkjgGU5rIu83gg3kmgKR9nzyD09hCkJgJR7olwI2KhcjIf+TZ
					r+qf4uhii8f4UXtXo45HhNjQfxS0sct42agzkMf9TBpwzHz3g6kkf+Uiq9yP09hVkbf6XIuItI37hdkEf7Xeuhq945hNjzf8T7rvue3Bg3jVfxP8pjxMzehC
					jigBRMpHv11rhgjOgLWJqsoP7Rhli5gUalnke1+lhjixgacCk2aU+2]],
				["WingFinger1.R"] = [[
					h6i9hYewWVYQ9dhckOgmdHlFp+91g9kQf7Ykq9vh4ohykggLaSpUtg63iAk1gYavoEss7vhZlbgpabnSuw63gslegsZIm6wa5rg9lEgpYfmUvT6UhykBgZXO
					mTsQ7giAjygRXOm4rd7thZkOgJYColuC6QgslGgdZ8pRw74yg9leggbDpXwi5QhylPgYbZovt47FiAk1gYavoEss7vhZkugaZUn5ub6ngskTgGWnogvp43g9
					kfgcXnm1vF6Dh7j9gyaYjWpA9/iFjNhMd5bPdp/eh6i9hYewWVYQ9d]],
				["WingFinger2.R"] = [[
					hZjLiKgzVrbj97hrkfheiNnHq99HhPk6gjdEt6vN4SiGlBg5cTp2vk55iTlThKbyn5vZ6lhnl6hcdpo/wE6EgzmBhdeUquwN5XhDlnhac9pVv06Bh5knhIZA
					nEuj6siLkYhAYJnDuP6ohnk1g1bUqZvM5vg7lrhLfEtFwO4QhPl/hPfgsVwh4diGlshKdYpNv96BiTlThKbyn5vZ6lhnlQhKckppvr58gzk/gwbzsSvE5EhD
					lGhLcFp3vf55iBkVhqcPj2re9XhzjWiFfobAgn/lhZjLiKgzVrbj97]],
				["WingFinger3.R"] = [[
					g2jNi3ioUmep9viFkgiRnuoGrF72hwlahFiJvyuK32icldhmeApyxs4tijlth6cPnMyN5Bh9mRiLhBp7xE5JhOmZiJkZtWu14nhZmAiIiErWvm5ciDlHh2ad
					nRw35miTk6hsYgmvxI5Eh9lUhgevrbwH5IhcmFhxlAvouT3chwmXh3kguTvq3hicmEh5fCpDyF4xijlth6cPnMyN5Bh9lrh4f+qowp5KhOlfhWh7uwtc47hZ
					lih3hNr3vN5giJkmifdwj0t48ehijXi8hCaWja/Sg2jNi3ioUmeo9v]],
				["Vine.R"] = [[
					hviwhdzMQTk/zlhnkCguxoh5tI3KhNkLgBvHtJxFyLh+kUgR3aqasKu0iKkngf6snknEuShnlSgw2qnTqTyug6lag1vRnAyhz9hLk+gyuEpTz+ydh7j2gj00
					pBusxIiJjmgc4nnAoixNhnkFgS04oNpm0sg8lDgjwSpExMzghNlYglw2rYyTwmh+lDge4Ap5slt1iKkngf6snknEuShnkkgi13nup/zpg6kQgQtOozxv1XhL
					kagmtbp9zpy7iCjvg72Ckou6xKh+i+hS4TY2qCwwhviwhdzNQTk/zl]],
				Tail1 = [[
					gAhngWisgAgA/4gAhlgWiejFfu/vgAhXgWhAlwfN/cgAh7gWjBjUfw/rgAicgWkAfBgD/ugAiqgWkUcHgI/dgAikgWkLcagJ/ggAiKgWjjfFgD/ygAhcgWhf
					hlf0/6gAhYgWhGh1fw/6gAhcgWhfgAgA/9gAiKgWjjeKgH/vgAikgWkMeagE/rgAiqgWkWg7f+/rgAicgWj+jmf2/igAh7gWjAj5fu/ngAhXgWhBg+f3/9gA
					hlgWiecsgT/ugAhngWirbTgZ/hgAhngWisevgH/2gAhngWisgAgA/4]],
				Tail2 = [[
					gAhbhahLgAgA/+gNhahZg8kYf0/rgYhThXfhpifK+hgOhuhYhfl+f2/Zf8iKhZieeSgA/2fwiXhXiwYof5/AfxiShXinZBf7/Hf8h7hZiCemgB/5gHhVhbf9
					kbfr/rgIhThbfklpfh/fgAhVhbf9hqf4/8f4h7hZiBcSgC/tf5iShYipakf8/agEiXhYi1eQf+/0gPiLhXidkVgB/mgQhuhYhenYf0/GgEhThbfgkYfn/rfy
					hahZg9dLgI/2fshbhXhJZBgQ/Mf7hbhahLdqgF/4gAhbhahLgAgA/+]],
				Tail3 = [[
					gAhWifgKgAgA//gghWibf8kjf9/qhAhTiPenspfS9WgnhoiYgepggD+jf0iAidhefQf+/8fRiMiThvWPfj+afTiHiVhlVSfj+Gf2hyiehBchf7/ygahVide+
					l2fw/bgghVibenpUff+kgHhVife9kqfz/ofohzichBcCf6/ufiiHiYhnXWfp+wf8iLichzapfw/fgiiAiZhdjXgI/ygvhoiVgepygD+dgXhVideioNfi+4fm
					hWidf8fQgB/+fPhWiVgKX4gD+8fxhWiegKclgB/zgAhWifgKgAgA//]],
				["UpperLeg.L"] = [[
					fhhWgQ5RaZgAyzfhhTgS6Jade4xifhhGgW8TY1bysYfhhqgU5UcPeyzJfhiLgR3OdFgg1zfhiZgP2pcPhX2PfiiTgM2HbSiO2hfih6gL10alit2nfihKgO6+
					XPgRuzfihGgQ7pXLfMtafhhKgS7jYUeTuNfhh5gS3Uc/gf1sfhiSgT3fdsf+1mfhiZgT3dduf+1ofhiLgR3OdFgg1zfhhqgQ4tazgUzpfihFgQ7uXGfItOfi
					hTgN5JYqhTyUfihWgN4oZVhWzQfhhWgQ5JaKgSy5fhhWgQ5RaZgAyz]],
				["LowerLeg.L"] = [[
					fagzgFzlgAgA5SfYgzgEzBhMf+5sfSgvf9vrj+he7kfZhHgK1fhdeq3nfdhlgP3WfveF1yfdh0gN23eye72UfehugM2cdxfv2sfehVgM2NdCgO21fZgsf4tS
					fchf9DfXgsf3svgghf9TfWguf7u9hihP8NfdhUgP3dfreE1rfdhtgQ3igZdk1hfdh0gQ3ggadk1kfdhlgP3WfveF1yfahGgH0bfsfu4ofXgrf3sjgihg9Yfb
					gxgAxTeghG62fbgygDyuefgv55fagzgEzZfrgK5cfagzgFzmgAgA5S]],
				["Foot.L"] = [[
					fagVgN/PgAgAm3fagVgN/OhBfym3fagVgN++kJfGmzfagogN+2gvfzoafahHgN9vfKgGrxfahVgN9LekgUtCfahPgM9Sd1gmsqfag2gM+NdYgvqLfagVgN/P
					gMf9m3fagVgN/OhJfwm3fagVgN/Mh6flm2fag2gN+Xe/gOqBfahPgN9ffpf4sZfahVgN9Sftf1s3fahHgN9vfKgGrxfagogN+3fngHoafagVgN/OhMfvm3fa
					gVgN/PfMgLm3fagVgN/OfBgOm3fagVgN/PfzgDm3fagVgN/PgAgAm3]],
				["UpperLeg.R"] = [[
					gfhWgQ5RlngAyzgehTgP5mmpfsx/gehFgO7epTgFtfgehqgM3ymheE0RgeiLgM2Jkwdz2fgfiZgP2pjxep2PgfiTgR3Mi4fg12gfh5gU3oicgD1bgfhKgW75
					mijptwgfhHgV8KnhjXsvgfhKgS7jnshtuNgeh6gN2Mk3d12ageiTgL1wlSdR2sgeiagL1vlQdQ2tgeiLgM2Jkwdz2fgfhqgQ4tlNfszpgfhGgV8Onnjcsigf
					hUgV6akxiDxSgfhWgU5vkfhSyagfhWgR5YlYgSytgfhWgQ5RlngAyz]],
				["LowerLeg.R"] = [[
					gmgzgFzlgAgA5SgngygBx9gafW6dgngqf2r1gTeg9rgkhGgFzhiLfS5PgihmgM2diRgR2qgjh0gN23hOhF2UgjhugP3TgPh711gjhUgQ3sftid1Wgtgwf/ws
					cdfD7Cgtguf8vFc4ek8Agqguf7u9eeex8NgjhVgN2hiWgT2lgihugM2Ii2fw27gih1gL2Hi0fv28gihmgM2diRgR2qgmhGgH0bgUgS4ogtguf8u7c1eh8Egp
					gzgFzwdxgh5DgogzgH0ieigy4egngzgFzyfrgK5IgmgzgFzmgAgA5S]],
				["Foot.R"] = [[
					gmgVgN/PgAgAm3gmgVgN/PgEf/m3gmgVgN/PfkgGm3gmgogN+0hofkoZgmhHgN9liMfar9gmhVgN9LhcfstCgmhPgN9dgyf9scgmg2gN+Ygof6qBgmgVgN/D
					cegym0gmgVgN/Dcngwm1gmgVgN/MeGgbm2gmg2gN+QiQfZqHgmhQgM9NimfPswgmhWgM8/ilfPtQgmhHgN9liMfar9gmgogN+3gZf5oagmgVgN/Dcigxm0gm
					gVgN/MeTgYm2gmgVgN/OfFgNm3gmgVgN/PfzgDm3gmgVgN/PgAgAm3]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAhngWECgAgAvggAhnglFQgAgAxigAhnguGHgAgAyygAhngsF4gCgFydgAhngnFcf1fnx0gAhnghFBfIeLxEgAhngeEtfPefwlgAhngdEmf3fuwfgAhngbEY
					gHgNwIgAhmgUDVgFgJuKgAhlgMBrgUgYqJgAhjgDAagtgnk6gAhhf7ADhKguf6gAhgf1AOhdgucugAhgf1AShggtcRgAhhf3AJhXgudqgAhhf4AIhWgud7gA
					hgf1AQhegucigAhgf0AThhgtcHgAhgf0AThhgtcHgAhgf0AThhgtcHgAhgf0AThhgtcHgAhgf0AThhgtcH]],
				Spine = [[
					gAiGgDFPgAgAxggAiIgWGmgAgAzcgAiJgjHjgAgA0ogAiJgfHTgCgE0UgBiIgZG0fzfoztgCiIgSGWe/eQy/gCiHgNF/fIejyigAiHgMF4f1fuycgAiGgJFo
					gIgMyGgAiDf+EcgGgIwOf/h7fvCfgWgXsVf/hufhA2gwgknNf+hhfXAIhNgoiPf+hZfSAFhggnfDf+hYfRAGhjgmemf+hbfTADhbgof/f+hcfUADhZgogRf+
					hZfSAFhigne3f+hXfRAGhkgmecf+hXfRAGhkgmecf+hXfRAGhkgmecf+hXfRAGhkgmecf+hXfRAGhkgmec]],
				Neck1 = [[
					gAikf1GDgAgAytgAipgNIBgAgA1LgAirgdJagAgA2pgAiqgZJCgDgE2RgBipgRIUfxfp1ggEiogIHne4eU0mgDingCHIfDem0CgBingBG+f0fvz6gAimf9Go
					gIgMzegAigfuFfgDgEx5f/iTfYDygMgIvEf+h9fDCJgbgIref9hme1BCgqgAn+f9hXewAig0f2lrf9hVewAfg1f1lWf9hbeyAqgxf5mXf9hdeyAtgwf6mjf9
					hWewAhg0f2lif9hUewAdg1f0lPf9hUewAdg1f0lPf9hUewAdg1f0lPf9hUewAdg1f0lPf9hUewAdg1f0lP]],
				Neck2 = [[
					gAi8fuGDgAgAytgAjBgKIjgAgA1wgAjDgdKWgAgA3jgAjCgYJ3gDgE3FgBjBgPI8fxfp2KgFjAgEIBe2eW1EgEi/f9HZfCen0XgBi+f7HNf0fv0Nf/i9f2Gy
					gIgMzqgAi3flFygAgAyVf/infKEkgBf6wbf+iNewDXgEftuPf9hyegCagFfasHf9hgeaB4gEfKqtf9hdeZBzgEfIqgf9hlebCBgFfPrIf9hnecCEgFfRrQf9
					heeZB2gEfJqof9hceZBygDfHqcf9hceZBygDfHqcf9hceZBygDfHqcf9hceZBygDfHqcf9hceZBygDfHqc]],
				Neck3 = [[
					gAjNfoGDgAgAytgAjTgJJGgAgA2VgAjVgfLVgAgA4agAjVgZKugDgE34gBjUgOJkfwfq2zgGjSgCIbe0eX1hgFjRf6HqfAeo0rgBjQf4Hcf0fv0ff/jPfyG7
					gIgLz3gAjIffGGf9f8yxf/i3fBFaf2fsxxf+icelE2ftfUw4f+h/eTEWfge2wAf+hreMECfUegvcf+hoeLEAfSedvXf+hxeNEIfYenvnf+hzeOEKfZepvqf+
					hqeLEBfTefvaf+hneKD/fRecvVf+hneKD/fRecvVf+hneKD/fRecvVf+hneKD/fRecvVf+hneKD/fRecvV]],
				Head = [[
					gAjefiADgAgAhTgAjlgJBHgAgAoUgAjngiCngAgAsogAjngbCKf7gDrggBjmgOBZgefspRgGjkgAA6iTeVm6gFjjf3Ajh/eelNgBjif0AXgYftksf/jhfuAN
					fvgOjegAjafZAGfUfsiMf/jIe6AMdue3iMf/isedAhbudoi0f/iOeKBAZ2cSjMf/h7eCBaYobWjVf/h4eBBeYdbNjWf/iAeEBSY/bojTf/iCeFBPZGbtjSf/
					h5eBBcYjbSjVf/h3eBBgYZbKjWf/h3eBBgYZbKjWf/h3eBBgYZbKjWf/h3eBBgYZbKjWf/h3eBBgYZbKjW]],
				Jaw = [[
					gAjqfJ/+gAgAg8gAj6f3/+gAgAe6gAkAgX/5gAgAdngAj/gO/7gGf/d9gCj8f+/9fegMeogLj3ft/2dbhNfNgJj0fi/5d0hNfvgCjzfe//flgPf+f/jwfW//
					gTf1gUgAjmfB/9gqgYhBf/jVei/1iHhah1gAi6eG/fjzjGizgAiddz+7lLlAj1gBiKdr+cl9mYkigBiHdq+XmEmlkpgAiPdt+mlul9kVgAiRdt+plql2kRgB
					iJdr+amAmdklgBiGdq+VmGmqkrgBiGdq+VmGmqkrgBiGdq+VmGmqkrgBiGdq+VmGmqkrgBiGdq+VmGmqkr]],
				Crest = [[
					gAlGfeaHgAgA/cgAlFgyhMgAgA/+gAk3hklugAgA/ef/k8hXkigCgG/qgElCg9iMfzfe/6gUlGghfxe5dY/3gSlHgNeBe9dv/1gDlIgHdefzfk/4f+lIf4cR
					gJgU/xf7lBfbawfjgm/jfxkve8aNeVh7/XfkkQehaKcjjf/EfYjveOZ/apkz+lfRjYeEZ0ZUlm+JfQjVeDZzZHlt+FfTjfeHZ4ZulX+SfUjheHZ5Z1lT+VfR
					jWeDZ0ZPlp+HfQjTeCZyZDlw+DfQjTeCZyZDlw+DfQjTeCZyZDlw+DfQjTeCZyZDlw+DfQjTeCZyZDlw+D]],
				["Humerus.L"] = [[
					fYijf3X7M+gA4afYimgPXLNNbO32fYiogfWiN2YX3XfXiogbWxNpZM3jfYingRWxNPaC3dfcimgFWHMpZp2lfbilgAWeMgbO3AfYilgCXYM3dR3+fXikf/X5
					NCey4afXiffxXCM+gd4FfXiSfbVDNPi63TfWh+fHSgN8le2BfVhqe6QQO8ns0nfVhce0O3Pwo/znfVhae0OrP3pLzdfVhge2PRPgonz6fVhhe2PZPbog0AfV
					hbe0OyPzpEzjfVhZe0OnP6pPzafVhZe0OnP6pPzafVhZe0OnP6pPzafVhZe0OnP6pPzafVhZe0OnP6pPza]],
				["Forearm.L"] = [[
					eYi9gDYAMSgA34egjPgaXHMibP3TeojZgrWZNMYa2zeljXgnWqM/ZP2/ekjUgbWrMlaF25epjWgKWBMAZt2AekjQgFWaL2bR2bedjIgLXYMMdT3beZjCgLX7
					MWey34eYi7f6XNMQgm3keXitfhVfMfjY20eViZfHTTNPmW1qeViEe2RWOXo90beUh2euQKPSqezkeUh0etP/PbqrzceUh6ewQgPAqCz1eUh7exQnO7p6z6eU
					h1euQGPWqkzheUhzetP8PfqwzZeUhzetP8PfqwzZeUhzetP8PfqwzZeUhzetP8PfqwzZeUhzetP8PfqwzZ]],
				["WingFinger1.L"] = [[
					dbjWgLZ/L8gA4Ldqj3ghZDL7bR3bd5kJg0YSMaYc23d0kDgvYjMQZQ3Edxj/giYlL5aH3Ad3kDgMX6LRZ02Idvj4gHYVLNbX2mdjjpgRZWLrdV3oddjegTZ6
					L7ey4HdajVgAZTL3gw36dYjEfjX2MKj63adWiufHV+NEnW2ldUiWe0UTOdqU1udUiIesTQPlsC1IdTiGerTHPwsR1CdUiMeuTkPOri1TdUiNevTqPIrZ1XdU
					iHerTMPqsI1FdTiFeqTEP0sW1AdTiFeqTEP0sW1AdTiFeqTEP0sW1AdTiFeqTEP0sW1AdTiFeqTEP0sW1A]],
				["WingFinger2.L"] = [[
					chjogTd6LtgA4oc2kVgoc7LJbX3ndLkvg8cFLUYj25dEkog3cYLQZX3Jc/khgocbK+aQ3IdHkngObuKSaF2Uc7kZgKcMKZbm23cskDgYdPLIda38ckjzgbd1
					Lkez4fchjmgHdWLog94gcdjSfqcNMMki4acai4fNasNgob4HcYife8ZSPart3ycYiQe1YaQ6ti3icYiOe0YSRIty3gcYiVe3YrQctB3ncYiWe3YvQUs33pcY
					iPe1YXRAtp3hcYiNe0YPRNt43fcYiNe0YPRNt43fcYiNe0YPRNt43fcYiNe0YPRNt43fcYiNe0YPRNt43f]],
				["WingFinger3.L"] = [[
					bpjugehlMQgA5HcBkogwgrLNbf33cZlLhDf0LCYt3BcRlAg/gILFZh3TcLk4gugLK4ac3XcTlAgQfdKGaX2ncGktgNf7Kab13Ob1kQgfg+LZdh4Ubtj8glhi
					MAe145bpjrgRhMMQhM5HbljSf1gWNOlL5Xbji1fdfMPMpf5gbkibfReHR2s85ibliNfOdcT3uy5hbliMfOdWULvB5gbkiRfPdpTQuR5hbkiSfPdsTEuH5hbl
					iNfOdZT/u45gbliLfOdTUSvG5gbliLfOdTUSvG5gbliLfOdTUSvG5gbliLfOdTUSvG5gbliLfOdTUSvG5g]],
				["Vine.L"] = [[
					dZjJgWzkfvh35Pdkjpgqynb5ed5pdwj8g8yNZBa241dsj2g4zQYfaa3xdpjygr1PYfbL2Mdvj2gV2aX1cx1EdojrgR2RZ/e52Idejcgc05c+gJ4CdajRgdy3
					eagf5xdYjIgMwneYgX7SdXi6fyuhefgT8edWinfYskfKgb9adViUfGqdgdgt+OdViIe9oehrhA+ydViGe8ndiKhT/AdViLfAnkh3hd+/dViMfAnYhhhW/EdV
					iHe9mlhhhJ/QdViFe8mohihD/PdViFe8mzhnhE/MdViFe8mzhrhG/MdViFe8mvhshH/NdViFe8muhshH/N]],
				["Humerus.R"] = [[
					goijf3X7zCgA4agoimgPXLyzky32goiogfWiyKnp3XgoiogaWyydm43dgpingTWsyMln3+gsilgPVrwhkv47grikgIWLxCjj4+gpikgDXXyrih4Xgoikf+X5
					zUhW4JgoiffwXDzSfn35gniRfZVLzidJ2ugnh7fDS+ziaU0+gmhke2RMzDXjzOglhUeyQMyfVzyFglhSexQDyZVjx7glhZezQeyrWUybglhaezQkyvWeyhgl
					hTexQIydVsyBglhRexQAyXVdx3glhRexQAyXVdx3glhRexQAyXVdx3glhRexQAyXVdx3glhRexQAyXVdx3]],
				["Forearm.R"] = [[
					hoi9gDYAzugA34hgjPgaXHzekx3ThYjZgrWZy0nm2zhbjXgmWrzHm125hejTggWny3ll3bhejTghVmxOkr4bhhjOgaWIxwjg4ehkjIgPXWzXig30hmjCgIX7
					z/hW3mhoi7f4XO0Afe3XhoirfbVn0Rcs2NhpiRe+Tw0MZa0jhph1esSSziWRy7hphienRey0USx5hphfemRXytUAxvhphneoRszEU3yNhphpeoRxzIVCyShp
					hhemRbyxUKx1hpheemRUyqT5xshpheemRUyqT5xshpheemRUyqT5xshpheemRUyqT5xshpheemRUyqT5xs]],
				["WingFinger1.R"] = [[
					iljWgLZ/0EgA4LiWj3ghZD0Fkv3biHkJg0YSzmnk23iMkEguYkz2m02+iRj+gpYhzill3jiOj/gvXgx6kz4piVj2gnYEyWjn4tiejpgYZUz3ih4CiijfgOZ6
					0ahU31iljUf8ZU0ZfT3tiojAfaX90mcF2yipihe4WZ0TYR1birh+elVJzTUs0HirhnefUeyTSezTirhkefUYyISKzLirhuehUqyoTHziirhvehUuytTTznir
					hlefUbyOSWzQirhjefUWyESDzJirhjefUWyESDzJirhjefUWyESDzJirhjefUWyESDzJirhjefUWyESDzJ]],
				["WingFinger2.R"] = [[
					jfjogTd60TgA4ojKkVgoc703kp3ni1kvg8cF0snd25i8kog1cZ03ms3CjCkggycY0blj3ti+kig9bVy0lB48jIkVg0b7zGjy5DjVkCggdO0Zig4XjbjzgVd1
					0yhQ4MjfjmgDdX0ofD4TjjjNfdcT0jbU3xjmine5bBzwW627jnh+enZ/yFS72HjohkelZawkQk1mjohgelZVwVQP1ijohrelZlxDRP1wjohuelZoxMRc1zjo
					hielZYweQb1kjohfelZUwPQI1gjohfelZUwPQI1gjohfelZUwPQI1gjohfelZUwPQI1gjohfelZUwPQI1g]],
				["WingFinger3.R"] = [[
					kXjugehlzwgA5Hj/kogwgr0zkh33jnlLhDf00+nT3BjvlBg8gI1Cmh3Mj2k2g7gH0gle38jwk5hMfEy5lM5Rj7kphCfqzBj95akLkPgqg80Hie4vkTj8gdhi
					0WhL4nkYjrgLhM0Aey46kcjMflgazgaj4xkeiffEfax9Vm4Wkdhye4ekvYRW34kbhXe6eFtNO93jkbhUe7eBs4Op3gkchfe5eOt5Pp3pkchhe5eRuFP13rkb
					hWe7eEtEO13ikbhSe8eAswOi3fkbhSe8eAswOi3fkbhSe8eAswOi3fkbhSe8eAswOi3fkbhSe8eAswOi3f]],
				["Vine.R"] = [[
					injJgWzkgReJ5PicjpgqynkHhj5piQj8g8yNm/lK41iUj2g2zSnqli3uiYjwgz1Jm1lS2aiUjyg618lJlu1+iajpgy2FjdjS2qiijbgi05ihgP4FimjRgZy3
					h+fR5wiojIgJwnh5fd7Ripi2fouhiLe/8airiafJskhsd69Tirh7e3qWgJcq+FirhnexoPenby+lirhkexnKeJbb+yirhteynUerbi+yirhveznKfGbs+3ir
					hmexmXe8bo/BirhjexmZe1bp/Birhjexmkevbo++irhjexmjeqbm++irhjexmfeqbl++irhjexmeeqbl+/]],
				Tail1 = [[
					gAhngWisgAgA/4gAhngllDgAgA/lgAhngumjgAgA/UgAhngsmJgFgA/ZgAhngnlYflgA/igAhnghkhd/gD/mgAhngej9eTgF/sgAhngdj0frgB/wgAhngbja
					gOf//zgAhmgUh5gBgA/7gAhlgMfRgAgA/+gAhjgDcJgAgA/wgAhhf7ZQgAgA/RgAhgf1XcgAgA+0gAhgf1XMgAgA+wgAhhf3X+gAgA+9gAhhf4YIgAgA/AgA
					hgf1XVgAgA+ygAhgf0XGgAgA+ugAhgf0XGgAgA+ugAhgf0XGgAgA+ugAhgf0XGgAgA+ugAhgf0XGgAgA+u]],
				Tail2 = [[
					gAhbhahLgAgA/+gAhRhmjigAgA/ygAhLhtlDgAgA/lgAhNhskpgFgA/pf+hQhoj3flf//wf3hUhjjAd/f9/yf5hWhgiceTgA/2f/hXhgiTfrgA/6gBhYheh5
					gOgA/7gAhehZhYf4gB/9gAhohRhLfigI/9gAh0hGhLfKga/9gAh+g6hLe6gz/8gAiEgxhLe0hH/7gAiFgvhLezhK/7gAiCgzhLe1hB/7gAiCg0hLe2g//7gA
					iEgwhLe0hI/7gAiFgvhLezhL/7gAiFgvhLezhL/7gAiFgvhLezhL/7gAiFgvhLezhL/7gAiFgvhLezhL/7]],
				Tail3 = [[
					gAhWifgKgAgA//gAhCiqiigAgA/5gAg2ivkDgAgA/vgBg5iujpgFgB/yf8g/iri3flf+/3fvhHimiAd/f5/3fxhLikhceTf8/6f9hNikhTfrf//9gChQijg5
					gOgA/+gAhYiehqfvgB/8f+hjiWkjfEgP/pf8hviLogeXg2+yf7h5h+sEd/hp9hf7h/h1uPd7iO8ff7iAh0ujd7iT8Uf7h9h4tmd7iD8zf7h9h5tbd8h/85f7
					h/h1uXd7iQ8af7iAhzupd7iV8Rf7iAhzupd7iV8Rf7iAhzupd7iV8Rf7iAhzupd7iV8Rf7iAhzupd7iV8R]],
				["UpperLeg.L"] = [[
					fhhWgQ5RaZgAyzfhhXgc6laaflw4fhhXgk7XabfUvmfhhXgi7KaefVv9fhhXgd6waIf2whfihXgW6PZIhNw7fihWgU58ZWhFxdfhhWgV56aMgDx1fhhWgU5s
					ahftyRfhhVgR5Aaef8zLfhhTgO34akf80kfhhTgL2eagf02FfhhWgI1DaQfw3ZfhhYgF0GZ/fx4KfhhYgEz9Z9fy4QfhhXgG0YaFfx38fhhXgG0daGfw33fh
					hYgF0CZ+fx4NfhhYgEz6Z8fy4TfhhYgEz6Z8fy4TfhhYgEz6Z8fy4TfhhYgEz6Z8fy4TfhhYgEz6Z8fy4T]],
				["LowerLeg.L"] = [[
					fagzgFzmgAgA5Sfag2gM1agAgA3xfag5gR2hgAgA2ufZg4gQ2OgEf93Afag3gM1pfpgP3jfcg2gG0+eVhJ4Efcg1gF0jeng/4dfag0gH0efvgM4lfZg0gH0K
					gLf442fZgygGy3gIf552fZgvgIwbgTfn7cfYgvgKtUgZfK9EfXgygLqQgTer+RfWg1gKoRgJeZ+3fWg1gKn+gIeW+8fWg0gKo3gNee+tfWg0gKpCgOeg+pfW
					g1gKoJgJeX+5fWg1gKn4gHeV+9fWg1gKn4gHeV+9fWg1gKn4gHeV+9fWg1gKn4gHeV+9fWg1gKn4gHeV+9]],
				["Foot.L"] = [[
					fagVgN/PgAgAm3fagXgP/qgAgAkifagagR/2gAgAjBfZgZgR/zgCf7jbfagYgP/tf4gakNfbgXgK/hfdh9lCfbgWgK/cfkhplnfagWgN/ef7gUlwfZgWgO/Z
					gDfymKfZgUgQ/QgBf2m1fZgUgW/Hf8fhnbfYgYge++fmfKn7fWgfgj+1fFfBoZfVglgl+vesfDosfVgmgl+ueofEovfWgjgk+xezfComfWgjgk+ye2fBolfV
					gmgl+veqfDotfVgngl+uenfEowfVgngl+uenfEowfVgngl+uenfEowfVgngl+uenfEowfVgngl+uenfEow]],
				["UpperLeg.R"] = [[
					gfhWgQ5RlngAyzgfhXgc6llmgbw4gfhXgk7XllgsvmgfhXgi7Klpgkv7gfhXgf6xlUgzwrgfhWge6SkUh2xogfhWga5+kjhiyDgfhWgX56lagdx9gfhWgU5r
					lwf9yMgfhUgQ5AltfzzHgfhSgM38lxfK0agehRgJ2qloeW10gehRgF1ZlQdo3EgehSgD0kk6dP32gehSgC0ck3dL39gehSgD00lCdW3ngehSgE05lDdY3jge
					hSgD0hk5dN35gehSgC0ak2dK3/gehSgC0ak2dK3/gehSgC0ak2dK3/gehSgC0ak2dK3/gehSgC0ak2dK3/]],
				["LowerLeg.R"] = [[
					gmgzgFzmgAgA5Sgmg2gM1agAgA3xgmg5gR2hgAgA2ugmg4gP2OgEf93Agng2gO1pfpgP3jgog1gP0+eVhJ4Egog0gN0jeng/4dgng0gJ0efvgM4lgmg0gG0K
					gLf442gmgygFy3gIf552gmgugFwbgTfn7cglgsgGtUgZfK9EgjgsgHqQgTer+RgigtgHoRgJeZ+3gigugHn+gIeW+8gjgtgHo3gNee+tgjgtgHpCgOeg+pgi
					gtgHoJgJeX+5gigugHn4gHeV+9gigugHn4gHeV+9gigugHn4gHeV+9gigugHn4gHeV+9gigugHn4gHeV+9]],
				["Foot.R"] = [[
					gmgVgN/PgAgAm3gmgXgP/qgAgAkigmgagR/2gAgAjBgmgZgQ/zgCf7jbgngYgR/tf4gakNgngWgT/hfdh9lCgngWgS/cfkhplngngWgO/ef7gUlwgmgWgN/Z
					gDfymKgmgUgP/QgBf2m1gmgTgU/Hf8fhnbglgVga++fmfKn7gjgagg+1fFfBoZgigegi+vesfDosgigfgi+ueofEovgigdgh+xezfComgigcgh+ye2fBolgi
					gegi+veqfDotgigfgi+uenfEowgigfgi+uenfEowgigfgi+uenfEowgigfgi+uenfEowgigfgi+uenfEow]],
			},
		},
	},
}
