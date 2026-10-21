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
					gAiag5AQgAgAj6gAiag5AQgAgAj6gAibg5AQgAgAj6gAibg5AQgAgAj6gAibg5AQgAgAj6gAibg5AQgAgAj6gAibg5AQgAgAj3gAiZg5APgAgAjxgAiYg5AO
					gAgAjogAiWg5ANgAgAjggAiVg5ANgAgAjagAiUg5AMgAgAjXgAiVg5AMgAgAjXgAiXg5AMgAgAjXgAiYg5AMgAgAjXgAiYg5AMgAgAjXgAiWg5AMgAgAjXgA
					iUg5AMgAgAjXgAiVg5AMgAgAjXgAiWg5AMgAgAjXgAiYg5AMgAgAjXgAiYg5AMgAgAjXgAiWg5AMgAgAjXgAiVg5AMgAgAjXgAiVg5AMgAgAjXgAiWg5AMgA
					gAjXgAiYg5AMgAgAjXgAiYg5AMgAgAjXgAiWg5AMgAgAjXgAiVg5AMgAgAjXgAiWg5ANgAgAjhgAieg5AVgAgAkbgAieg5AVgAgAkagAicg5ATgAgAkPgAib
					g5ASgAgAkGgAiag5ASgAgAkEgAiag5ARgAgAkDgAiag5ARgAgAkAgAiag5ARgAgAj9gAiag5AQgAgAj7]],
				Spine1 = [[
					gAihgcAQgAgAj6gAiigcARgAgAj+gAiigcARgAgAkCgAiigcASgAgAkGgAiigcASgAgAkIgAiigcASgAgAkIgAiigcASgAgAkDgAiggcAQgAgAj5gAiegcAP
					gAgAjtgAicgcANgAgAjhgAibgcANgAgAjagAibgcAMgAgAjXgAibgcANgAgAjegAidgcAPgAgAjzgAiegcARgAgAkCgAiegcARgAgAj9gAicgcAOgAgAjogA
					ibgcAMgAgAjYgAibgcANgAgAjcgAidgcAPgAgAjwgAiegcARgAgAkBgAiegcARgAgAj/gAicgcAPgAgAjrgAibgcANgAgAjZgAibgcANgAgAjagAicgcAPgA
					gAjtgAiegcARgAgAkAgAiegcARgAgAkAgAidgcAPgAgAjugAibgcANgAgAjbgAicgcANgAgAjhgAimgcAUgAgAkXgAimgcATgAgAkSgAikgcARgAgAkDgAii
					gcAQgAgAj4gAiigcAQgAgAj2gAiigcAQgAgAj1gAihgcAQgAgAj1gAihgcAQgAgAj1gAihgcAQgAgAj3]],
				Spine2 = [[
					gAipf//4gAgAipgAipf//5gAgAiggAipf//5gAgAiYgAiqf//6gAgAiSgAiqf//6gAgAiOgAiqf//6gAgAiMgAipf//6gAgAiTgAinf//5gAgAihgAilf//3
					gAgAiygAijf//2gAgAjBgAihf//1gAgAjJgAihf//1gAgAjMgAiif//2gAgAi+gAikf//6gAgAiUgAimf//8gAgAh1gAilf//7gAgAh/gAijf//4gAgAipgA
					ihf//1gAgAjKgAihf//2gAgAjCgAikf//5gAgAiagAimf//8gAgAh3gAilf//7gAgAh8gAijf//5gAgAijgAihf//1gAgAjHgAihf//1gAgAjGgAijf//5gA
					gAiggAilf//7gAgAh6gAimf//7gAgAh4gAijf//5gAgAidgAihf//2gAgAjEgAijf//2gAgAjCgAiuf//6gAgAiQgAiuf//5gAgAiagAirf//4gAgAirgAip
					f//3gAgAi4gAipf//2gAgAi7gAipf//2gAgAi7gAiof//3gAgAi6gAiof//3gAgAi3gAiof//3gAgAix]],
				Spine3 = [[
					gAikfi/4gAgAipgAikfi/5gAgAicgAilfi/6gAgAiQgAimfi/7gAgAiGgAimfi/7gAgAiAgAimfi/7gAgAh+gAilfi/7gAgAiHgAijfi/5gAgAiZgAigfi/4
					gAgAiugAidfi/2gAgAjAgAicfi/1gAgAjJgAibfi/1gAgAjMgAicfi/3gAgAi3gAigfi/8gAgAh4gAiifi/+gAgAhJgAiifi/9gAgAhZgAiefi/5gAgAiXgA
					ibfi/1gAgAjJgAicfi/2gAgAi9gAiffi/7gAgAiBgAiifi/+gAgAhMgAiifi/9gAgAhTgAiefi/6gAgAiOgAibfi/2gAgAjFgAibfi/2gAgAjDgAiffi/6gA
					gAiKgAiifi/9gAgAhRgAiifi/+gAgAhOgAiffi/7gAgAiFgAicfi/2gAgAjAgAidfi/2gAgAjCgAiqfi/6gAgAiVgAipfi/5gAgAiigAimfi/3gAgAi3gAik
					fi/1gAgAjGgAikfi/1gAgAjJgAijfi/1gAgAjJgAijfi/1gAgAjFgAijfi/2gAgAi/gAijfi/3gAgAi1]],
				Neck1 = [[
					gAiffFAXgAgAkpgAigfFAXgAgAkugAihfFAYgAgAkzgAiifFAZgAgAk2gAiifFAZgAgAk4gAiifFAZgAgAk5gAihfFAXgAgAkqgAiefFASgAgAkJgAibfFAN
					gAgAjegAiYfFAJgAgAi1gAiWfFAHgAgAiXgAiVfFAGgAgAiKgAiXfFAHgAgAifgAicfFANgAgAjegAigfEATgAgAkMgAiffFARgAgAj9gAiafFAKgAgAi/gA
					iVfFAGgAgAiNgAiWfFAHgAgAiYgAicfFAMgAgAjVgAigfEASgAgAkJgAiffFARgAgAkDgAiafFALgAgAjIgAiWfFAGgAgAiRgAiWfFAGgAgAiTgAibfFALgA
					gAjMgAigfFASgAgAkFgAigfFASgAgAkHgAibfFAMgAgAjRgAiWfFAGgAgAiWgAiYfFAJgAgAi2gAimfFAtf9fWmmgAilfGAsf8fSmegAihfFAif/f2lugAie
					fFAcgBgKlIgAiefGAbgCgPlDgAiefFAagBgIk9gAidfFAYgAf9k0gAiefFAXf/f8ksgAiefFAWgAf/ko]],
				Neck2 = [[
					gAiteVA4gAgAnWgAiveVA3gAgAnTgAiweVA2gAgAnQgAixeVA2gAgAnOgAixeVA1gAgAnMgAiyeVA1gAgAnLgAiweVAwgAgAm2gAireUAngAgAmGgAimeUAb
					gAgAlHgAiheUASgAgAkHgAideTAMgAgAjUgAiceTAKgAgAi9gAifeTAMgAgAjSgAineTATgAgAkRgAiteUAagAgAk/gAireUAYgAgAkwgAijeTAPgAgAjygA
					iceTAKgAgAjAgAieeTALgAgAjLgAimeTASgAgAkIgAiteUAagAgAk8gAiseUAYgAgAk1gAikeTAQgAgAj7gAideTAKgAgAjEgAideTALgAgAjGgAileTARgA
					gAj/gAiseUAZgAgAk4gAiteUAZgAgAk6gAileTASgAgAkEgAideTALgAgAjJgAiheUASgAgAkKgCi6eXB8fyeuq1gCi5eXB7fwemqzgAizeWBhf8ftprgAiu
					eWBPgEgUovf/iueWBNgHgeongAiteWBJgDgPobgAiseVBEf/f7oHgAiseVA+f+f4nxgAiseVA6gAf+nf]],
				Neck3 = [[
					gAi8d4A4gAgAnWgAi9d4A1gAgAnLgAi+d4AzgAgAnBgAi/d4AxgAgAm5gAjAd4AwgAgAm0gAjAd4AvgAgAmxgAi9d3ApgAgAmVgAi3d2AegAgAlWgAiwd1AR
					gAgAkBgAipd0AIgAgAipgAikd0ADgAgAhigAiidzACgAgAhBgAild0ADgAgAhVgAiwd0AGgAgAiVgAi3d1AKgAgAjDgAi1d1AJgAgAizgAird0AEgAgAh1gA
					iidzACgAgAhEgAikd0ADgAgAhPgAiud0AGgAgAiMgAi3d1AKgAgAjAgAi2d1AJgAgAi5gAisd0AFgAgAh+gAijdzACgAgAhHgAijd0ACgAgAhJgAitd0AFgA
					gAiDgAi2d1AKgAgAi8gAi3d1AKgAgAi+gAiud0AFgAgAiHgAikd0ACgAgAhMgAipd0AJgAgAiwgEjPd/CkfreFsXgFjNd/Cmfod5sagBjGd8B8f6fkq6f/i/
					d6BggHgeppf+i+d6BegKgupff/i9d6BYgFgWpNgAi8d5BOf+f4otgAi7d5BEf9fzoJgAi7d4A8f/f9nq]],
				Head = [[
					gAjPdS/sgAgAkagAjQdR/qgBf4klgAjRdR/ogCfwkwgAjRdR/ngDfok4gAjSdR/mgEfhk9gAjSdR/lgFfalAgAjOdQ/fgLfZlogAjGdO/Ngafem/gAi7dL+w
					gtfmoygAiwdK+KhBfuqngAiodJ9nhRfzsBgAildI9VhYf0srgAipdJ9fhZf1sVgAi2dK97hZf5rOgAjAdL+OhZf7qagAi8dK+IhZf6qrgAivdJ9thZf3rxgA
					ildI9XhZf0sogAiodJ9chZf1scgAi0dJ93hZf4rYgAi/dL+NhZf7qdgAi+dL+KhZf7qlgAixdJ9xhZf3rngAimdI9YhZf1skgAimdJ9ZhZf1sigAiydJ9zhZ
					f4rigAi+dL+LhZf7qigAi+dL+MhZf7qfgAizdJ91hZf4rdgAindJ9bhZf1sfgAiwdK+NhNgDqdgJjudh/vfgisdEgJjsdh/ufci3dDgCjhdb/9fuhKfZf+jY
					dX/9f6gMhUf9jXdX/9f+f2hjf+jVdW/7f8gIh9gBjTdV/4f6ggipgBjRdT/zf7gdjagAjPdS/vf+gLkD]],
				Jaw = [[
					gAiidD/4gAgAitgAijdD/3gBf4i5gAijdE/2gBfvjDgAikdE/1gCfojLgAikdE/0gCfhjRf/ikdE/0gDfajUgAigdF/vgJfZj8gBiXdH/igYfdlUgCiMdK/L
					grfknJgDiBdO+rhAfro/gEh6dR+NhQfuqbgEh3dT9+hYfvrGgEh7dS96hYfyrPgEiHdQ9xhZf6rngEiQdO9qhZf/r4gEiNdP9thZf+rygEiBdR92hZf2rbgE
					h3dT99hYfwrJgEh5dS97hYfxrNgEiFdQ9zhZf5rkgEiQdO9rhZf/r3gEiOdP9shZf+r1gEiDdR91hZf3rfgEh4dT98hYfwrKgEh4dT98hYfxrLgEiEdQ90hZ
					f4rggEiPdP9shZf/r2gEiPdP9rhZf/r2gEiEdQ9zhZf4rigEh5dT98hYfxrMgDiBdO+nhNgApOgNjMdA/0fbireCgNjKdA/yfXi2d2gDi7c//9fvhKfUf+iv
					dA//f6gMghf8itdA//f9f3gqf+irdB/+f9gIg7gBiodB/9f7gghZgBikdC/7f9gdh8gAiidD/5f/gLia]],
				["Lid.L"] = [[
					fSj/cwF0OugAmLfSkAcvFxOvgOmFfSkAcvFtOlhClJfRkBcvFrOmhNlGfRkBcvFtO0gul+fRkBcvFsO1g1l+fQj7csFoOmh2kmfQjvcmFxONj/hdfPjecfGg
					OGmtdSfPjNcZH5OdpUZKfOi/cWJYPDrOWGfOi5cVKMPasDUvfOi+cVKFPRr3U+fOjPcYJrO2rOVzfOjccbJaOiqwWafOjXcaJgOpq6WNfOjHcXJ4PDrjVZfO
					i6cVKMPZsCUwfOi9cVKHPUr7U5fOjNcYJvO5rUVsfOjbcbJbOkqyWYfOjZcaJeOmq3WSfOjJcXJ0O/rdVgfOi7cVKKPXsAUzfOi7cVKJPWr+U1fOjLcXJyO9
					raVkfOjacaJdOlq1WUfOjacaJcOlq0WWfOjMcXJwO7rXVofOi8cVKIPVr9U3fPjNcZIDOSpJYyfgkqdRK1RCWMv9fhkpdQKUQoWjvFfXkadGICP0aVsafQkO
					c+HAPgcrqsfPkMc+G2PfdOqefRkKc7GqPQdbptfUkHc3GYO9d2odfUkDczGGOyernUfTkAcxF5Oufjmi]],
				["Lid.R"] = [[
					guj/cwF0xSgAmLgukAcuFxxUgAl8gtkActFsxhfZk3gtkAcsFrxifaksgtkBcsFuxZgGlcgtkBcrFtxagJlVgsj8coFgxefNj6gsjwcjFVxZdCg2grjhccFq
					w5aIc4gqjScWGpv9XPZAgqjFcSH1u8VGWLgqjAcRIguaUJU8gqjFcRIYuiUTVMgqjXcVH/u9U2WFgqjjcYHvvQVQWvgqjfcXH0vKVHWhgqjOcTILuwUkVpgq
					jBcRIfuaUJU9gqjEcRIbufUPVHgqjUcUIDu6UxV9gqjicXHwvPVPWtgqjgcXHyvMVLWngqjRcTIIu0UpVxgqjCcRIeucULVAgqjCcRIdudUMVCgqjScUIGu2
					UsV1gqjhcXHxvNVMWpgqjicXHwvOVNWrgqjTcUIEu4UuV5gqjDcRIcueUOVEgqjTcXGqvzW4ZFg6kmdgKOtHleyog7kkdgJ1tnkwx/gykZdNH/vtjstqgskO
					dAHDwhi/q5grkMc9G7wsi/qVgtkKc8GtwwiWp2gwkHc6GYw2hUpAgwkDc2GGxDgkn0gvkAcyF5xOgKmu]],
				["UpperLegF.L"] = [[
					fGh0fFz2amgA4gfGh1fF0HapgF4SfGh2fE0aatgJ4DfGh2fE0savgO30fGh3fD06axgR3ofGh3fD0/aygS3kfGh2fE0bavgJ4DfGhzfEzlapf74ufGhwfFy2
					aift5QfGhtfGyVabfi5nfGhrfGyCaYfa5zfGhqfHx7aWfX54fGhsfGyDadfb50fGhxfDywawfr5YfGh1fAzta9f74sfGh0fBzUa5f14/fGhufEyVanfj5pfG
					hqfGx8aXfY54fGhrfGyAabfa51fGhwfDynatfp5efGh1fBzna8f64wfGh0fBzca6f344fGhvfEycapfl5lfGhqfGx9aZfY53fGhrfGx+aZfZ52fGhvfDyfar
					fm5jfGh0fBzga7f441fGh1fBzka7f54zfGhwfDyjasfo5gfGhrfGx/aafZ52fGhsfGyVabfh5nfGh7fF2paygv1+fGh5fF2uatgv14fGh2fG0yakgQ3tfGhz
					fHz8aegC4ZfGhzfHz1adgA4ffGhyfHzwadf+4jfGhyfHzraef94nfGhyfGzoaff84pfGhzfGzraif94n]],
				["LowerLegF.L"] = [[
					e4g+fP7RdRgAwfe4g/fN6ydSf1xSe5hAfL6QdSfpyEe5hBfK5wdSfeyxe5hBfI5YdQfWzRe5hBfI5QdQfTzbe5hAfL6HdUfmyRe4g+fP7YdWgCwUe2g8fT8d
					dUgcuWe2g6fW9MdRgwsxe1g4fX9mdNg8rxe1g4fY9vdMhArZe1g5fW9YdSg0sWe3g9fR76dfgMvbe4hAfL6OdiflyJe4g/fN64dif0xKe2g7fU8udaght2e1
					g4fY9rdNg+rke1g5fX9fdQg4sEe3g9fS8KdegSu+e4hAfM6Xdifox8e4hAfN6qdifuxge2g8fT8gdbgbuSe1g4fX9ndOg8rue1g4fX9ldPg7r1e3g8fT8Zdc
					gYuhe4hAfM6jdifsxre4hAfM6ddifqx0e3g8fS8RddgVuve1g4fX9idQg6r8e2g6fW9OdQgxsre7hEfB3Fc+eq15e7hDfC3Kc6ep1ze5hAfM6UdJfrx+e4g+
					fQ7jdMgHwAe3g+fQ7udMgLvte3g9fR7zdMgNvke3g9fR72dNgOvfe3g9fR70dOgNvke3g+fQ7odQgJv4]],
				["FootF.L"] = [[
					e1gie//UgAgAmje1gie//Uf/gAmje1gie//Uf8gBmje1gie//Uf5gBmje1gie//Uf2gCmje1gie//Uf1gCmje1gie//Uf9gBmje1gie//UgFf/mje1gie//U
					gIf+mje1gie//UgHf/mje1gie//UgFf/mje1gie//UgEf/mje1gie//UgJf+mje1gie//UgQf9mje1gie//UgLf+mje1gie//UgOf9mje1gie//UgOf9mje1
					gie//UgFf/mje1gie//UgIf+mje1gie//UgPf9mje1gie//UgMf9mje1gie//UgNf9mje1gie//UgPf9mje1gie//UgGf/mje1gie//UgGf/mje1gie//UgP
					f9mje1gie//UgNf9mje1gie//UgMf9mje1gie//UgPf9mje1gie//UgHf/mje1gie//UgGf/mje1gkfA/HfXf9nZe1gje//OfUgEm8e1gie//Uf0gDmje1gi
					e//Uf8gBmje1gie//Uf8gBmje1gie//Uf9gBmje1gie//Uf+gAmje1gie//Uf/gAmje1gie//UgAgAmj]],
				["UpperLegF.R"] = [[
					g6h0fFz2lagA4gg6h1fF0HlXf74Sg6h2fE0alTf34Dg6h2fE0slRfy30g6h3fD06lPfv3og6h3fD0/lOfu3kg6h2fE0blRf34Dg6hzfEzllXgF4ug6hwfFy2
					legT5Qg6htfGyVllge5ng6hrfGyClogm5zg6hqfHx7lqgp54g6hsfGyDljgl50g6hxfDywlQgV5Yg6h1fAztlDgF4sg6h0fBzUlHgL4/g6hufEyVlZgd5pg6
					hqfGx8lpgo54g6hrfGyAllgm51g6hwfDynlTgX5eg6h1fBznlEgG4wg6h0fBzclGgJ44g6hvfEyclXgb5lg6hqfGx9lngo53g6hrfGx+lngn52g6hvfDyflV
					ga5jg6h0fBzglFgI41g6h1fBzklFgH4zg6hwfDyjlUgY5gg6hrfGx/lmgn52g6hsfGyVllgf5ng6h7fF2plOfR1+g6h5fF2ulTfR14g6h2fG0ylcfw3tg6hz
					fHz8lif+4Zg6hzfHz1ljgA4fg6hyfHzwljgC4jg6hyfHzrligD4ng6hyfGzolhgE4pg6hzfGzrlegD4n]],
				["LowerLegF.R"] = [[
					hIg+fP7RivgAwfhIg/fN6yiugLxShHhAfL6QiugXyEhHhBfK5wiugiyxhHhBfI5YiwgqzRhHhBfI5QiwgtzbhHhAfL6HisgayRhIg+fP7Yiqf+wUhKg8fT8d
					isfkuWhKg6fW9MivfQsxhLg4fX9mizfErxhLg4fY9vi0fArZhLg5fW9YiufMsWhJg9fR76ihf0vbhIhAfL6OiegbyJhIg/fN64iegMxKhKg7fU8uimfft2hL
					g4fY9rizfCrkhLg5fX9fiwfIsEhJg9fS8Kiifuu+hIhAfM6XiegYx8hIhAfN6qiegSxghKg8fT8gilfluShLg4fX9niyfEruhLg4fX9lixfFr1hJg8fT8Zik
					fouhhIhAfM6jiegUxrhIhAfM6diegWx0hJg8fS8RijfruvhLg4fX9iiwfGr8hKg6fW9OiwfPsrhFhEfB3FjChW15hFhDfC3KjGhX1zhHhAfM6Ui3gVx+hIg+
					fQ7ji0f5wAhJg+fQ7ui0f1vthJg9fR7zi0fzvkhJg9fR72izfyvfhJg9fR70iyfzvkhJg+fQ7oiwf3v4]],
				["FootF.R"] = [[
					hLgie//UgAgAmjhLgie//UgBgAmjhLgie//UgEf/mjhLgie//UgHf/mjhLgie//UgKf+mjhLgie//UgLf+mjhLgie//UgDf/mjhLgie//Uf7gBmjhLgie//U
					f4gCmjhLgie//Uf5gBmjhLgie//Uf7gBmjhLgie//Uf8gBmjhLgie//Uf3gCmjhLgie//UfwgDmjhLgie//Uf1gCmjhLgie//UfygDmjhLgie//UfygDmjhL
					gie//Uf7gBmjhLgie//Uf4gCmjhLgie//UfxgDmjhLgie//Uf0gDmjhLgie//UfzgDmjhLgie//UfxgDmjhLgie//Uf6gBmjhLgie//Uf6gBmjhLgie//Ufx
					gDmjhLgie//UfzgDmjhLgie//Uf0gDmjhLgie//UfxgDmjhLgie//Uf5gBmjhLgie//Uf6gBmjhLgkfA/HgpgDnZhLgje//Ogsf8m8hLgie//UgMf9mjhLgi
					e//UgEf/mjhLgie//UgEf/mjhLgie//UgDf/mjhLgie//UgCgAmjhLgie//UgBgAmjhLgie//UgAgAmj]],
				Tail1 = [[
					gAiQhijsgAgA/xgAiRhijsgOf+/xgAiRhijsgbf9/xgAiRhijsgof7/xgAiShijsg0f6/xgAiShijsg/f5/wgAiRhijphCf4/xgAiQhijjg6f5/ygAiPhija
					gqf7/zgAiNhijSgXf9/0gAiMhijLgHf//1gAiMhijJgAgA/1gAiNhijIgAgA/1gAiPhijIgAgA/1gAiQhijIgAgA/1gAiPhijIgAgA/1gAiOhijIgAgA/1gA
					iMhijIgAgA/1gAiNhijIgAgA/1gAiOhijIgAgA/1gAiQhijIgAgA/1gAiQhijIgAgA/1gAiOhijIgAgA/1gAiMhijIgAgA/1gAiMhijIgAgA/1gAiOhijIgA
					gA/1gAiQhijIgAgA/1gAiQhijIgAgA/1gAiOhijIgAgA/1gAiMhijIgAgA/1gAiNhijbfjgE/zgAiThik/dkgU/ggAiThik7esgK/lgAiRhikffdgE/qgAiQ
					hikJfbgE/tgAiQhikGfXgF/ugAiQhikCfMgG/ugAiQhij7fLgG/vgAiQhijzfcgE/wgAiQhijufwgC/x]],
				Tail2 = [[
					gAiJiAmCfWgI/agAiKiAmCfwgD/agBiKiAmCgLf+/agBiKiAmCglf5/agCiKiAmCg/f0/ZgCiLiAmChWfv/YgCiKiAl/hjft/YgCiJiAl4hefu/agBiIiAlw
					hIfy/cgBiHiAlogpf4/fgAiGiAligOf9/ggAiGiAlfgAgA/hgAiHiAlfgAgA/hgAiJiAlfgAgA/hgAiKiAlfgAgA/hgAiJiAlfgAgA/hgAiIiAlfgAgA/hgA
					iGiAlfgAgA/hgAiGiAlfgAgA/hgAiIiAlfgAgA/hgAiKiAlfgAgA/hgAiKiAlfgAgA/hgAiIiAlfgAgA/hgAiGiAlfgAgA/hgAiGiAlfgAgA/hgAiIiAlfgA
					gA/hgAiKiAlfgAgA/hgAiKiAlfgAgA/hgAiIiAlfgAgA/hgAiGiAlfgAgA/hf/iHiAl4fJgL/bf7iKh/oBbQg9+lf+iJh/n9dXgi+3f/iJh/nTexgP/Hf/iJ
					iAmvengR/Pf/iIiAmqeZgU/Pf+iIiAmjd9gZ/Pf+iJiAmYd3ga/Rf/iJiAmNeTgV/VgAiJiAmFe5gO/Y]],
				Tail3 = [[
					f/h+icnWeNgb/FgAh+icnWevgT/HgBh/icnWfTgL/IgCh/icnWf4gC/IgDh/icnWgef5/IgEh/icnWhDfw/HgFh/icnThdfq/HgEh+icnNhjfo/IgDh9idnF
					hSfs/LgCh8idm9gyf0/NgBh8idm2gSf8/PgAh8idm0gBgA/QgAh8idmzgAgA/QgAh+idmzgAgA/QgAh/idmzgAgA/QgAh/idmzgAgA/QgAh9idmzgAgA/QgA
					h8idmzgAgA/QgAh8idmzgAgA/QgAh+idmzgAgA/QgAh/idmzgAgA/QgAh/idmzgAgA/QgAh9idmzgAgA/QgAh8idmzgAgA/QgAh8idmzgAgA/QgAh+idmzgA
					gA/QgAh/idmzgAgA/QgAh/idmzgAgA/QgAh+idmzgAgA/QgAh8idmzgAgA/Qf+h8idnUe0gT/Hfzh7iYp+ZYhq9nf5h7iZp8cWg6+Lf9h7ibpEeSgb+of8h8
					iboTd5gg+0f8h8iboMdbgn+zf7h8iboCcogz+xf7h9icnzcWg3+zf8h9icnkc3gv+6f+h+icnZdogk/B]],
				Tail4 = [[
					f8hwi4mgc1gq/Kf+hxi4mgdZgj/NgAhxi4mheCga/QgChxi4mietgR/SgEhxi4mifbgI/UgGhxi4migJf+/UgHhxi4mfgzf1/UgHhxi4mYhKfw/UgGhwi5mQ
					hHfw/WgDhvi5mIgwf1/ZgBhvi5mCgSf8/agAhvi5l/gBgA/bgAhvi5l/gAgA/bgAhxi5l/gAgA/bgAhzi5l/gAgA/bgAhyi5l/gAgA/bgAhwi5l/gAgA/bgA
					hvi5l/gAgA/bgAhvi5l/gAgA/bgAhxi5l/gAgA/bgAhzi5l/gAgA/bgAhyi5l/gAgA/bgAhxi5l/gAgA/bgAhvi5l/gAgA/bgAhvi5l/gAgA/bgAhxi5l/gA
					gA/bgAhyi5l/gAgA/bgAhyi5l/gAgA/bgAhxi5l/gAgA/bgAhvi5l/gAgA/bf8hui4mnejgV/Qfohoiup3X/h19Tfzhoixp2b2g++If6hqi0oueQga+uf5hs
					i2nwdjgi+7f3hti2nncugs+5f1hti2nZbdg9+xf0hui2nFa5hE+wf2hvi3mybZg9+6f5hwi4mkcPgy/E]],
				Tail5 = [[
					f2hkjUkYbjgo/Xf5hkjUkYcDgj/cf8hljUkZcpge/ggAhljUkadUgY/kgDhljUkaeEgR/ogGhljUkae2gK/qgJhljUkYftgD/sgJhkjUkRgXf9/tgIhkjVkJ
					gqf6/tgFhkjWkBgjf7/vgChkjWj6gPf+/wgAhkjWj3gBgA/wgAhkjWj3gAgA/wgAhmjWj3gAgA/wgAhnjWj3gAgA/wgAhnjWj3gAgA/wgAhljWj3gAgA/wgA
					hkjWj3gAgA/wgAhkjWj3gAgA/wgAhmjWj3gAgA/wgAhnjWj3gAgA/wgAhnjWj3gAgA/wgAhljWj3gAgA/wgAhkjWj3gAgA/wgAhkjWj3gAgA/wgAhljWj3gA
					gA/wgAhnjWj3gAgA/wgAhnjWj3gAgA/wgAhmjWj3gAgA/wgAhkjWj3gAgA/wf5hhjUkoeYgR/nfbhWjDomXMhi9ffshWjJoib+gy+jf3hajPnIe4gQ/Kf0he
					jRl8dzgW/WfyhejRlwckgh/RfthfjQlfawgw/EfrhgjQlHZzg4+9fuhijSkvaNg0/GfzhjjTkebCgs/R]],
				["UpperLegB.L"] = [[
					fGh0g+3oZkgA0kfGh0g+3jZogD0sfGh0g+3dZsgF00fGh0g+3YZvgH06fGh1g+3VZxgJ0+fGh1g+3VZygJ0/fGh0g+3gZpgE0vfGhzg+32ZZf70RfGhxg+4N
					ZHfyzvfGhvg/4fY4fqzTfGhug/4qYuflzBfGhug/4vYpfjy5fGhvg/4qYufmzCfGhwg/4ZY9fwzdfGhyg/4KZJf4z0fGhxg/4PZFf1zsfGhvg/4iY1frzPfG
					hug/4uYqfky7fGhug/4rYtfly/fGhwg/4bY7fvzZfGhyg/4LZIf3zyfGhxg/4NZGf2zvfGhwg/4fY3fszTfGhug/4tYrfky8fGhug/4tYrfly9fGhwg/4eY4
					ftzVfGhxg/4MZHf3zwfGhyg/4MZHf3zxfGhwg/4dY6fuzXfGhug/4sYsfly+fGhvg/4fY3fqzTfGh3g81ga7gv3HfGh3g818argl2qfGh1g93BaAgN1YfGh0
					g93eZrgC0yfGh0g93iZogA0tfGh0g93lZmf/0pfGhzg93pZjf+0jfGhzg+3sZhf+0gfGhzg+3sZhf+0g]],
				["LowerLegB.L"] = [[
					e4g+g0xfeQgA6ue4g/g1xveKf+6je4g/g1x+eFf76Ze4g/g2yKeBf56Re4g/g2ySd+f46Le4g/g2yUd9f46Je4g/g1x4eHf96de3g+gzxCeagG7Ce3g9gxwH
					eugQ7ne2g8gwvVe/gX8De2g8gvu1fJgc8Ve2g7guuofNge8ce2g8gvu6fHgc8Se3g9gxv2ezgW7xe3g+gywkejgQ7Ue3g9gywUepgS7ee2g8gwvYe9gZ8Ce2
					g7guurfMgd8ae2g8gvu1fJgd8Ve2g9gwvte2gX72e3g+gywhekgR7We3g9gywaengS7be2g8gwvge6gY79e2g7guuufLgd8Ye2g7guuwfKgd8Xe2g8gwvke5
					gY77e3g9gywdemgR7Ze3g+gywfelgR7Ye2g9gwvpe4gX74e2g8gvuyfJgd8We2g8gvvSfAgX8Fe7hBg/1xcifE3Ke6hAg909c5fQ39e5g/g3yvdzfu51e4g/
					g1xueLf76ke4g/g0xleOf96qe4g+g0xeeRf+6ve4g+g0xXeTgA60e4g+g0xSeVgB63e4g+g0xVeUgB61]],
				["FootB.L"] = [[
					e1gihB/UgAgAmje1gihB/Uf7gBmje1gihB/Uf2gCmje1gihB/UfxgDmje1gihB/UfugEmje1gihB/UfugEmje1gihB/Uf4gCmje1gihB/UgLf+mje1gihB/T
					gef6mje1gihB/Tguf2mje1gihB/Tg3f0mje1gihB/Tg7f0mje1gihB/Tg2f1mje1gihB/Tglf4mje1gihB/UgWf7mje1gihB/Tgbf6mje1gihB/Tguf2mje1
					gihB/Tg6f0mje1gihB/Tg4f0mje1gihB/Tgnf4mje1gihB/TgXf7mje1gihB/Tgaf7mje1gihB/Tgrf3mje1gihB/Tg6f0mje1gihB/Tg5f0mje1gihB/Tgq
					f3mje1gihB/TgZf7mje1gihB/TgYf7mje1gihB/Tgpf3mje1gihB/Tg4f0mje1gihB/Tgvf2mje1gihB/PeNgXmqe1gihB/SelgTmje1gihB/TfhgGmje1gi
					hB/Uf6gBmje1gihB/Uf9gBmje1gihB/UgAgAmje1gihB/UgCgAmje1gihB/UgEf/mje1gihB/UgEf/mj]],
				["UpperLegB.R"] = [[
					g6h0g+3omcgA0kg6h0g+3jmYf90sg6h0g+3dmUf700g6h0g+3YmRf506g6h1g+3VmPf30+g6h1g+3VmOf30/g6h0g+3gmXf80vg6hzg+32mngF0Rg6hxg+4N
					m5gOzvg6hvg/4fnIgWzTg6hug/4qnSgbzBg6hug/4vnXgdy5g6hvg/4qnSgazCg6hwg/4ZnDgQzdg6hyg/4Km3gIz0g6hxg/4Pm7gLzsg6hvg/4inLgVzPg6
					hug/4unWgcy7g6hug/4rnTgby/g6hwg/4bnFgRzZg6hyg/4Lm4gJzyg6hxg/4Nm6gKzvg6hwg/4fnJgUzTg6hug/4tnVgcy8g6hug/4tnVgby9g6hwg/4enI
					gTzVg6hxg/4Mm5gJzwg6hyg/4Mm5gJzxg6hwg/4dnGgSzXg6hug/4snUgby+g6hvg/4fnJgWzTg6h3g81glFfR3Hg6h3g818lVfb2qg6h1g93BmAfz1Yg6h0
					g93emVf+0yg6h0g93imYgA0tg6h0g93lmagB0pg6hzg93pmdgC0jg6hzg+3smfgC0gg6hzg+3smfgC0g]],
				["LowerLegB.R"] = [[
					hIg+g0xfhwgA6uhIg/g1xvh2gC6jhIg/g1x+h7gF6ZhIg/g2yKh/gH6RhIg/g2ySiCgI6LhIg/g2yUiDgI6JhIg/g1x4h5gD6dhJg+gzxChmf67ChJg9gxwH
					hSfw7nhKg8gwvVhBfp8DhKg8gvu1g3fk8VhKg7guuogzfi8chKg8gvu6g5fk8ShJg9gxv2hNfq7xhJg+gywkhdfw7UhJg9gywUhXfu7ehKg8gwvYhDfn8ChK
					g7guurg0fj8ahKg8gvu1g3fj8VhKg9gwvthKfp72hJg+gywhhcfv7WhJg9gywahZfu7bhKg8gwvghGfo79hKg7guuug1fj8YhKg7guuwg2fj8XhKg8gwvkhH
					fo77hJg9gywdhafv7ZhJg+gywfhbfv7YhKg9gwvphIfp74hKg8gvuyg3fj8WhKg8gvvShAfp8FhFhBg/1xjeg83KhGhAg909jHgw39hHg/g3yviNgS51hIg/
					g1xuh1gF6khIg/g0xlhygD6qhIg+g0xehvgC6vhIg+g0xXhtgA60hIg+g0xShrf/63hIg+g0xVhsf/61]],
				["FootB.R"] = [[
					hLgihB/UgAgAmjhLgihB/UgFf/mjhLgihB/UgKf+mjhLgihB/UgPf9mjhLgihB/UgSf8mjhLgihB/UgSf8mjhLgihB/UgIf+mjhLgihB/Uf1gCmjhLgihB/T
					figGmjhLgihB/TfSgKmjhLgihB/TfJgMmjhLgihB/TfFgMmjhLgihB/TfKgLmjhLgihB/TfbgImjhLgihB/UfqgFmjhLgihB/TflgGmjhLgihB/TfSgKmjhL
					gihB/TfGgMmjhLgihB/TfIgMmjhLgihB/TfZgImjhLgihB/TfpgFmjhLgihB/TfmgFmjhLgihB/TfVgJmjhLgihB/TfGgMmjhLgihB/TfHgMmjhLgihB/TfW
					gJmjhLgihB/TfngFmjhLgihB/TfogFmjhLgihB/TfXgJmjhLgihB/TfIgMmjhLgihB/TfRgKmjhLgihB/PhzfpmqhLgihB/ShbftmjhLgihB/Tgff6mjhLgi
					hB/UgGf/mjhLgihB/UgDf/mjhLgihB/UgAgAmjhLgihB/Uf+gAmjhLgihB/Uf8gBmjhLgihB/Uf8gBmj]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 18,
			bones = {
				Hips = [[
					gAiUg5ARfLgHj6gAiVg5ARfRgej5gAiXg5ARfdgzj5gAiZg5ARfthBj5gAiag5ASf/hHj6gAiag5ASgShFj6gAiZg5ASgig6j7gAiXg5ARgugpj7gAiVg5AR
					g1gSj7gAiUg5ARg1f5j6gAiVg5ARgvfij5gAiXg5ARgjfNj5gAiZg5ARgTe/j5gAiag5ASgBe5j6gAiag5ASfue7j6gAiZg5ASfefGj7gAiXg5ARfSfXj7gA
					iVg5ARfLfuj7]],
				Spine1 = [[
					gAibgcARflgDj6f/icgcAQfpgSj6f+iegcARfvgfj5f+iggcARf3goj5f+iigcARgBgsj6f+iigcARgKgrj6f+iggcARgSglj7f/iegcARgYgaj7gAicgcAR
					gbgMj7gAibgcARgbf9j6gBicgcAQgXfuj6gCiegcARgRfhj5gCiggcARgJfYj5gCiigcARf/fUj6gCiigcARf2fVj6gCiggcARfufbj7gBiegcARfofmj7gA
					icgcARflf0j7]],
				Spine2 = [[
					f/iif//4gAgAipf+ijf//4gBf6ipf9ilf//4gBf1iqf9inf//4gBfxiqf9ipf//4gBfuipf9ipf//4gBfuipf9inf//4gBfxiof+ilf//4gBf1iof/ijf//4
					gBf6iogBiif//4gAgAipgCijf//4f/gGipgDilf//4f/gLiqgDinf//4f/gPiqgDipf//4f/gSipgDipf//4f/gSipgDinf//4f/gPiogCilf//4f/gLiogB
					ijf//4f/gGio]],
				Spine3 = [[
					f/idfi/4flf+ipf+iefi/4fngBipf9igfi/4frgEiqf8iifi/4fygHipf8ikfi/4f7gIipf8ikfi/4gEgJipf9ijfi/4gNgJiof+igfi/4gUgHiof/iefi/4
					gZgFiogBidfi/4gbgCipgCiefi/4gZf/ipgDigfi/4gVf8iqgEiifi/4gOf5ipgEikfi/4gFf4ipgEikfi/4f8f3ipgDijfi/4fzf3iogCigfi/4fsf5iogB
					iefi/4fnf7io]],
				Neck1 = [[
					f/iZfFAXgbf8krf+iZfFAWgXfwkhf9ibfFAWgRfmkif9iefFAYgJffkvf8iffFAbgAfclCf9iffFAdf3felRf9iefFAefvfklWf+icfFAdfpftlOf/iZfFAa
					flf4k9gBiZfFAXflgEkrgCiZfFAWfpgQkhgDibfFAWfvgakigDiefFAYf3ghkvgEiffFAbgAgklCgDiffFAdgJgilRgDiefFAegRgclWgCicfFAdgXgTlOgB
					iZfFAagbgIk9]],
				Neck2 = [[
					gAineVA5gaf6naf/ineVA0gUfmnGf/ipeVA1gLfUnJf+iseVA8gBfInjf+iveVBFf3fDoHf+iweWBNfufFokf/iueWBPfnfPotf/iseWBLfjfeoegAipeVBC
					fjfxn9gAineVA5fmgGnagBineVA0fsganGgBipeVA1f1gsnJgCiseVA8f/g4njgCiveVBFgJg9oHgCiweWBNgSg7okgBiueWBPgZgxotgBiseWBLgdgioegA
					ipeVBCgdgPn9]],
				Neck3 = [[
					gAi2d4A5gaf6ncgAi1d4AygRfdm+gAi3d4A0gHfEnDgAi7d5A+f7exnpgAi/d5BMfxepofgAjAd6BZfoespKgAi/d6Bcfie4pYgAi8d6BVfgfOpBgAi4d5BH
					fhfpoQgAi2d4A5fmgGncgAi1d4Ayfvgjm+gAi3d4A0f5g8nDgAi7d5A+gFhPnpgAi/d5BMgPhXofgAjAd6BZgYhUpKgAi/d6BcgehIpYgAi8d6BVgggypBgA
					i4d5BHgfgXoQ]],
				Head = [[
					gBjJdS/mgYgCk9gCjIdR/hgLgrlcgDjKdR/kf9hQlDgDjPdS/sfvhrj9gDjVdU/0fih4irgDjYdW/4fZh0hzgCjYdX/5fVhjhwgBjUdW/3fXhHijgAjOdU/w
					fdglj0f/jJdS/mfof+k9f+jIdR/hf1fVlcf9jKdR/kgDewlDf9jPdS/sgReVj9f9jVdU/0geeIirf9jYdW/4gneMhzf+jYdX/5gredhwf/jUdW/3gpe5ijgA
					jOdU/wgjfbj0]],
				Jaw = [[
					gCicdF/wgYgBj1gDiadF/sgNgqkUgEicdE/ugAhQj6gFiidD/0fyhsi0gFipdB/5fmh5higEiudB/7fdh2gqgDitdB/8fZhkgngBiodC/7fahJhagAihdE/3
					ffgmirf+icdF/wfof/j1f9iadF/sfzfWkUf8icdE/ugAewj6f7iidD/0gOeUi0f7ipdB/5gaeHhif8iudB/7gjeKgqf9itdB/8gnecgnf/iodC/7gme3hagA
					ihdE/3ghfair]],
				["Lid.L"] = [[
					fSj3cuF6OagZlufUj1cqFxOZgHk+fXj4cqFxOZfXk9fZkBctF6OceXlnfakJczGIOkddmifakOc4GQOuc/nRfZkOc5GNO2dKncfYkJc2F+O7d7nDfVkBcyFs
					O+fEmUfTj5cuFgPBgOltfQj2ctFfPEhDlqfNj5cxFpPEhWmTfMkAc3F9PChKndfLkHc+GWO+gronfLkMdCGpO4gNpTfMkLdCGsOwf/pNfNkGc9GgOmgEoVfP
					j+c1GMOegTnA]],
				["Lid.R"] = [[
					gtj5cuFgw/fyltgwj2ctFfw8e9lqgzj5cxFpw8eqmTg0kAc3F9w+e2ndg1kHc+GWxCfVong1kMdCGpxIfzpTg0kLdCGsxQgBpNgzkGc9Ggxaf8oVgxj+c1GM
					xiftnAguj3cuF6xmfnlugsj1cqFxxnf5k+gpj4cqFxxngpk9gnkBctF6xkhplngmkJczGIxcijmigmkOc4GQxSjBnRgnkOc5GNxKi2ncgokJc2F+xFiFnDgr
					kBcyFsxCg8mU]],
				["UpperLegF.L"] = [[
					fEhvfFsobAez88fDhvfFuvamev72fDhxfFx5aNfD52fChzfF0xaCfo3lfCh0fF3caEgZ07fDh0fF41aLg1zTfEhyfF26aMgV1jfFhvfF1aaLf53DfHhtfF0K
					aMfg4JfIhsfFzMaOfO47fJhtfFykaSfG5afKhvfGyTaYfJ5nfKhxfGyVagfT5ofKhzfGyYaqfg5ofJh0fGyFa1fq54fIhzfGxNbDfv6gfHhxfGwCbRfy7RfG
					hwfFtMbQfO8v]],
				["LowerLegF.L"] = [[
					ezhIfp97eOhorBexhDfi/Nd7ibmSewg/fW/edoikkheyg+fK/GdYh+mue2g+e99XdFgssWe5g/e26+c2flw6e3g8fA8hdBgMuLe2g5fH9RdAgcsje2g4fN9m
					c5gerte3g4fR9jcwgVr0e3g6fU9GcrgEs4e4g8fV8Pctfuure5g/fW7BczfYwze6hAfW5tc8fFywe6hBfX4xdIfB0Be5hCfb4ddafM0be5hCff4bdxff0he2
					hHfo7feNgmwQ]],
				["FootF.L"] = [[
					e1gyfQ+uhAfto0e1g2fE+lgqfzpWe1g2e3+ngTf6pQe1gwes+0gKf9oje1gnem/Jf5gCnUe1gien/TfhgGmje1gies/UfzgDmje1giew/Uf0gCmje1gie1/U
					ftgEmje1gie5/TfjgGmje1gie+/TfdgHmje1gifC/TfbgImje1gifH/TfdgHmje1gifL/TfhgGmje1gifQ/UfqgFmje1gifU/Uf8gBmje1gifZ/UgVf8mje1
					gqfY/Bg+fxnu]],
				["UpperLegF.R"] = [[
					g4hsfFzMlygy47g3htfFyklug65ag2hvfGyTlog35ng2hxfGyVlggt5og2hzfGyYlWgg5og3h0fGyFlLgW54g4hzfGxNk9gR6gg5hxfGwCkvgO7Rg6hwfFtM
					kwgy8vg8hvfFsolAhN88g9hvfFuvlahR72g9hxfFx5lzg952g+hzfF0xl+gY3lg+h0fF3cl8fn07g9h0fF41l1fLzTg8hyfF26l0fr1jg7hvfF1al1gH3Dg5
					htfF0Kl0gg4J]],
				["LowerLegF.R"] = [[
					hJg4fR9jjQfrr0hJg6fU9GjVf8s4hIg8fV8PjTgSurhHg/fW7BjNgowzhGhAfW5tjEg7ywhGhBfX4xi4g/0BhHhCfb4dimg00bhHhCff4biPgh0hhKhHfo7f
					hzfawQhNhIfp97hyeYrBhPhDfi/NiFdlmShQg/fW/eiYdckhhOg+fK/GioeCmuhKg+e99Xi7fUsWhHg/e26+jKgbw6hJg8fA8hi/f0uLhKg5fH9RjAfksjhK
					g4fN9mjHfirt]],
				["FootF.R"] = [[
					hLgie5/Tgdf6mjhLgie+/Tgjf5mjhLgifC/Tglf4mjhLgifH/Tgjf5mjhLgifL/Tgff6mjhLgifQ/UgWf7mjhLgifU/UgEf/mjhLgifZ/UfrgEmjhLgqfY/B
					fCgPnuhLgyfQ+ufAgTo0hLg2fE+lfWgNpWhLg2e3+nftgGpQhLgwes+0f2gDojhLgnem/JgHf+nUhLgien/Tgff6mjhLgies/UgNf9mjhLgiew/UgMf+mjhL
					gie1/UgTf8mj]],
				Tail1 = [[
					gBiKhijqg7gv/wgBiLhijagpgu/ygCiNhijRgSgn/0gDiPhijVf5gc/0gDiRhijjfhgN/ygDiRhij1fNf9/wgCiPhikCe+ft/ugBiNhikFe4fg/tgBiLhij7
					e6fW/uf/iKhijqfFfR/wf/iLhijafXfS/yf+iNhijRfufZ/0f9iPhijVgHfk/0f9iRhijjgffz/yf9iRhij1gzgD/wf+iPhikChCgT/uf/iNhikFhIgg/tf/
					iLhij7hGgq/u]],
				Tail2 = [[
					gCiDiAmMidgX/SgDiFiAlshqgf/bgDiHiAlVgrgi/igDiJiAlRfngg/jgCiKiAljemga/egBiJiAmCdvgS/VgAiHiAmgdKgI/Mf/iFiAmuc7f+/If+iDiAmm
					dDfz/Kf+iDiAmMdjfp/Sf9iFiAlseWfh/bf9iHiAlVfVfe/if9iJiAlRgZfg/jf+iKiAljhafm/ef/iJiAmCiRfu/VgAiHiAmgi2f4/MgBiFiAmujFgC/IgC
					iDiAmmi9gN/K]],
				Tail3 = [[
					gHh4icnzkTfy+ugGh6idnKjPgA/AgEh9idmkhzgO/QgCh/idmSgIgY/Xf/h/idmdedgf/Sf9h+icnAc+gh/Ef7h7ibnrb2gi+xf5h5iboIbOgf+kf5h3iboL
					bLgZ+if5h4icnzbtgO+uf6h6idnKcxgA/Af8h9idmkeNfy/Qf+h/idmSf4fo/XgBh/idmdhjfh/SgDh+icnAjCff/EgFh7ibnrkKfe+xgHh5iboIkyfh+kgH
					h3iboLk1fn+i]],
				Tail4 = [[
					gPhpi2nRmKfd+igMhsi4molHfo+4gIhwi5l4jcf3/QgChzi6lXhXgG/gf9hzi5lUfHgR/if4hxi3lyc+gZ/Ufzhti2mibNgg+8fxhpi1nNaAgk+lfwhoi1nf
					Zigm+afxhpi2nRZ2gj+if0hsi4moa5gY+4f4hwi5l4ckgJ/Qf+hzi6lXepf6/ggDhzi5lUg5fv/igIhxi3lyjCfn/UgNhti2mikzfg+8gPhpi1nNmAfc+lgQ
					hoi1nfmefa+a]],
				Tail5 = [[
					gahcjPlWntfp+lgWhgjSk2m8fo+2gOhljVkElWfu/RgFhpjXjXjGf2/qf7hpjWjFgff+/1fyhmjUjWdzgC/vfrhhjQkCbYgF/ZfmhcjOk1ZhgK+9fkhajOlW
					YdgR+nfmhcjPlWYTgX+lfqhgjSk2ZEgY+2fyhljVkEaqgS/Rf7hpjXjXc6gK/qgFhpjWjFfhgC/1gOhmjUjWiNf+/vgVhhjQkCkof7/ZgahcjOk1mff2+9gc
					hajOlWnjfv+n]],
				["UpperLegB.L"] = [[
					fIhqg+7QX7e0uofIhrg/7AYPenvPfIhuhA6gYvenwUfIhxhB5zZVeyxpfHhzhC5CZ4fBy7fGh0hC4aaLfMz0fGh0hB4CaJfS0RfFhyhA3sZ9fZ0ofEhxg/3I
					Z2fp1OfEhwg+2QZ6gC2KfEhxg809aPgk3dfFhyg7yjbKhU5kfFh0g6yGa+hc53fGh0g61RY7gp20fGhzg63dXngD0EfHhxg65jWpfYw0fIhug77HWVext6fI
					hrg87uW0egs+]],
				["LowerLegB.L"] = [[
					e4hAgdzKd+gL5ie3hAghyuecgD55e3hAgmy6erf35xe3hAgszcesfo5Xe4hAgxz2eofb5De4hAg1zhevfa5Te3g/g2yPfGfo6Re2g+g3wdfff67be1g8g4u4
					fqgH8Ue2g7g7uCffgM8ve3g7hBuXe1gH8ke6g+hLxFdQfw66e6hAhMwCdOf67ie2g/g7orfggc+ye0hAgulpgVgU/fe0hDghmHgVgH/Ze1hGgZp2fsgM+be3
					hGgXuse1gZ8Z]],
				["FootB.L"] = [[
					e1gigm/Uf7gBmje1gigr/UgOf9mje1gigv/UgUf8mje1gig0/UgPf9mje1gig4/UgFf/mje1gig9/UgKf+mje1gihB/Tghf5mje1gihG/Tg7f0mje1gihK/S
					hIfxmje1gihP/Tg/fzmje1gihT/Tgbf6mje1gihY/TfCgNmje1glhb/MfDgOnBe1guhW+3g+fvoWe1g1hL+nhifjpKe1g3g/+jhefjpYe1gzgy+shDfso+e1
					gsgp++glf2n/]],
				["UpperLegB.R"] = [[
					g8hwg+2QmGf+2Kg8hxg809lxfc3dg7hyg7yjk2es5kg7h0g6yGlCek53g6h0g61RnFfX20g6hzg63doZf90Eg5hxg65jpXgow0g4hug77HprhPt6g4hrg87u
					pMhgs+g4hqg+7QoFhMuog4hrg/7AnxhZvPg4huhA6gnRhZwUg4hxhB5zmrhOxpg5hzhC5CmIg/y7g6h0hC4al1g0z0g6h0hB4Cl3gu0Rg7hyhA3smDgn0og8
					hxg/3ImKgX1O]],
				["LowerLegB.R"] = [[
					hKg7g7uCghf08vhJg7hBuXhLf58khGg+hLxFiwgQ66hGhAhMwCiygG7ihKg/g7orggfk+yhMhAgulpfrfs/fhMhDghmHfrf5/ZhLhGgZp2gUf0+bhJhGgXus
					hLfn8ZhIhAgdzKiCf15ihJhAghyuhkf955hJhAgmy6hVgJ5xhJhAgszchUgY5XhIhAgxz2hYgl5DhIhAg1zhhRgm5ThJg/g2yPg6gY6RhKg+g3wdghgG7bhL
					g8g4u4gWf58U]],
				["FootB.R"] = [[
					hLgihP/TfBgNmjhLgihT/TflgGmjhLgihY/Tg+fzmjhLglhb/Mg9fynBhLguhW+3fCgRoWhLg1hL+neegdpKhLg3g/+jeigdpYhLgzgy+se9gUo+hLgsgp++
					fbgKn/hLgigm/UgFf/mjhLgigr/UfygDmjhLgigv/UfsgEmjhLgig0/UfxgDmjhLgig4/Uf7gBmjhLgig9/Uf2gCmjhLgihB/TffgHmjhLgihG/TfFgMmjhL
					gihK/Se4gPmj]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 10,
			bones = {
				Hips = [[
					gAikg5AIgAgAilgAiag5AGgEgViSgAiTg5ALgFgijFgAiYg5AQgEgij3gAiig5AOgDgVjkgAikg5AIgAgAilgAiag5AGf8friSgAiTg5ALf7fejFgAiYg5AQ
					f8fej3gAiig5AOf9frjk]],
				Spine1 = [[
					gAiogbAKgAgAi9f/ifgbAGgEgViNf/iZgcAIgFgiiqf/ifgcAPgEgijsf/ipgcAQgDgVj4gAiogbAKgAgAi9gBifgbAGf8friNgBiZgcAIf7feiqgBifgcAP
					f8fejsgBipgcAQf9frj4]],
				Spine2 = [[
					gAiuf+/1gAgAjPf/ijf+/rgBfrkbf+ief+/sgDfekTf+imf//1gDfejCf/iwf//5gBfriYgAiuf+/1gAgAjPgBijf+/rf/gVkbgCief+/sf9gikTgCimf//1
					f9gijCgBiwf//5f/gViY]],
				Spine3 = [[
					gAiofh/3gAgAi3f+ibfi/rgBfrkgf9iWfi/ogDfektf9ihfi/0gDfejOf+isfi/7gBfriEgAiofh/3gAgAi3gCibfi/rf/gVkggDiWfi/of9giktgDihfi/0
					f9gijOgCisfi/7f/gViE]],
				Neck1 = [[
					gAijfFAkgAgAl2f+iTfGANgEgVjff8iOfGAJgFgiiuf8ibfFAXgFgiknf+iofFAsgFgUmigAijfFAkgAgAl2gCiTfGANf8frjfgEiOfGAJf7feiugEibfFAX
					f7fekngCiofFAsf7fsmi]],
				Neck2 = [[
					gAi1eWBmgAgAp7f9ideUAxgHgUm6f7iWeUAhgIghlmf7ipeVBAgIghn2f9i8eXBygHgUqfgAi1eWBmgAgAp7gDideUAxf5fsm6gFiWeUAhf4fflmgFipeVBA
					f4ffn2gDi8eXByf5fsqf]],
				Neck3 = [[
					gAjId8CFgAgArSf8ird3A8gHgUnmf6ihd2AigIghlvf6i5d5BIgJghoXf8jQd9CQgIgTrvgAjId8CFgAgArSgEird3A8f5fsnmgGihd2Aif4fflvgGi5d5BI
					f3ffoXgEjQd9CQf4ftrv]],
				Head = [[
					gAjkdb//gAgAgPf7i/dR/zgAfrjgf4ixdO/mgDfek8f4jOdU/4gDfeilf8jude//f/frfqgAjkdb//gAgAgPgFi/dR/zgAgVjggIixdO/mf9gik8gIjOdU/4
					f9giilgEjude//gBgVfq]],
				Jaw = [[
					gAi9dBABgAgAgOf7iTdAATf/gVbyf4iDdBAtf7giZef4ijdAAOf8giccf7jHdDACgBgVgogAi9dBABgAgAgOgFiTdAATgBfrbygIiDdBAtgFfeZegIijdAAO
					gEfeccgFjHdDACf/frgo]],
				["Lid.L"] = [[
					fSkcdHG2O3dwpjfNjxczF+O0fxnGfJjgcsFtO1gumBfKkCc5GMO4fcn9fNkmdMG/PBdsqLfSkcdHG2O3dwpjfXjxcxGBOofQmwfbjgcpFuOmf3ldfbkCc2GP
					OnelnZfXkmdLHDOzdMp0]],
				["Lid.R"] = [[
					gukcdHG2xJiQpjgpjxcxGBxYgwmwgljgcpFuxagJldglkCc2GPxZhbnZgpkmdLHDxNi0p0gukcdHG2xJiQpjgzjxczF+xMgPnGg3jgcsFtxLfSmBg2kCc5GM
					xIgkn9gzkmdMG/w/iUqL]],
				["UpperLegF.L"] = [[
					fGh3fFtBbsf686fEhofMp2bEeN9+fChjfOxiZrdm55fChwfJ1eaBep26fEh9fE7AaCgYwFfGh3fF7AZkgjv4fJhnfJ2rYufa1WfKhjfKxwZBe05qfKhwfFv9
					aSfv7IfJh9fCxNbsg16n]],
				["LowerLegF.L"] = [[
					e4hOfp2YeHfa2xeyhIf2+/dsiGnTesgzff++chjuZ0ewg7fL/xc/iMfpe6hNep7gcyexv+e9hIep7jcXe8vze2gzfD+abigoo1e0gyfa+mbihjoDe5hBfe5z
					czgBype+hKfYxkdSeb6j]],
				["FootF.L"] = [[
					e1gufp+5gpf1oQe1g6fZ+egZf4pte1g+fC+Od8gtqPe1g7eq+afQgPp5e1gxeZ+xfdgHove3gseY+oe7fgpIe1gien/ReVgWmje1gie9/RebgVmje1gifT/T
					fggHmje3gtfk9ufMfLrw]],
				["UpperLegF.R"] = [[
					g6h3fF7Amcfdv4g3hnfJ2rnSgm1Wg2hjfKxwm/hM5qg2hwfFv9lugR7Ig3h9fCxNkUfL6ng6h3fFtBkUgG86g8hofMp2k8hz9+g+hjfOximVia55g+hwfJ1e
					l/hX26g8h9fE7Al+fowF]],
				["LowerLegF.R"] = [[
					hDhIep7jjphEvzhKgzfD+akefYo1hMgyfa+mkeedoDhHhBfe5zjNf/yphChKfYxkiuhl6jhIhOfp2Yh5gm2xhOhIf2+/iUd6nThUgzff++jfcSZ0hQg7fL/x
					jBd0fphGhNep7gjOhPv+]],
				["FootF.R"] = [[
					hJgseY+ohFggpIhLgien/RhrfqmjhLgie9/RhlfrmjhLgifT/Tggf5mjhJgtfk9ug0g1rwhLgufp+5fXgLoQhLg6fZ+efngIpthLg+fC+OiEfTqPhLg7eq+a
					gwfxp5hLgxeZ+xgjf5ov]],
				Tail1 = [[
					gAidhjkIgAgA/ugBiVhjihfrgD/5gBiMhii6fegF/2gBiPhikwfegA/ogBiahilgfrf+/ggAidhjkIgAgA/uf/iVhjihgVf9/5f/iMhii6gif7/2f/iPhikw
					gigA/of/iahilggVgC/g]],
				Tail2 = [[
					gAiViAolgef9+0gAiQiBl+fegH/bgAiGiBlUesgS/hgAiGh/nheYgN/DgAiPh/phesgG+ggAiViAolfigD+0gAiQiBl+gif5/bgAiGiBlUhUfu/hgAiGh/nh
					hofz/DgAiPh/phhUf6+g]],
				Tail3 = [[
					gBiGibr6hVf19qf/iFiepAfxgH+sf+h8ienFeUgd/Jf9h4iao3ddgd+of+h+iYr0dmgS9of/iGibr6ergL9qgBiFiepAgPf5+sgCh8ienFhsfj/JgDh4iao3
					ijfj+ogCh+iYr0iafu9o]],
				Tail4 = [[
					gDhwixswiZfy9Pf/h0i4qSgegE+Sf7hvi5nWeYgd/Ff5hni0oGc3gf+yf6hpiurcckgT9rf9hwixswdngO9PgBh0i4qSfif8+SgFhvi5nWhofj/FgHhni0oG
					jJfh+ygGhpiurcjcft9r]],
				Tail5 = [[
					gHhajGryjff/9igAhhjQqThfgI+Qf4hhjVm/e6ga/MfzhYjPmdctgV/Kf0hUjFpdbygE+Rf5hajGrychgB9igAhhjQqTehf4+QgIhhjVm/hGfm/MgNhYjPmd
					jTfr/KgMhUjFpdkOf8+R]],
				["UpperLegB.L"] = [[
					fGh+hB6ZZjg4w3fGh1hD5BZ3goy9fGhthC5YYqfByAfGhyhA1Oadfy3SfGh8hAw3cNgz66fGh+hBwQb0hB7NfGh0hA2LX8fz1mfGhtg+5eV7ezwffGhyg88C
					WHeRrsfGh8g97MYVf2vA]],
				["LowerLegB.L"] = [[
					e9hMgo6zbufjw8e7hAgy5Yb6fIzBe1g8gtvUfjgY8Fe4g8hDvQetfP8Fe9hKhXxBdae968e8hNhawcc+fK7QezhAg7jehKf5/yexhBgkhEiLft/5e0hQgTrO
					gAg/98e5hPge3/cZgS02]],
				["FootB.L"] = [[
					e4gwga+RdtfxqEe1gjgp/IdsgZnAe1gig+/ShMfwmje1gihU/Uf5gCmje3guhk9beqfbsee2gxho+WecgKp+e1g6ha+aiCfWpse1g+hD+Ki3fCqOe1g7gr+Y
					hufcp4e1gwgZ+yeqgYon]],
				["UpperLegB.R"] = [[
					g6h+hBwQkMe/7Ng6h0hA2LoEgN1mg6htg+5eqFhNwfg6hyg88Cp5hvrsg6h8g97MnrgKvAg6h+hB6ZmdfIw3g6h1hD5BmJfYy9g6hthC5YnWg/yAg6hyhA1O
					ljgO3Sg6h8hAw3jzfN66]],
				["LowerLegB.R"] = [[
					hEhNhawcjCg27QhNhAg7jee2gH/yhPhBgkhEd1gT/5hMhQgTrOgAfB98hHhPge3/jnfu02hDhMgo6zkSgdw8hFhAgy5YkGg4zBhLg8gtvUgdfo8FhIg8hDvQ
					hTgx8FhDhKhXxBimhD68]],
				["FootB.R"] = [[
					hKgxho+Whkf2p+hLg6ha+ad+gqpshLg+hD+KdJg+qOhLg7gr+YeSgkp4hLgwgZ+yhWfoonhIgwga+RiTgPqEhLgjgp/IiUfnnAhLgig+/Se0gQmjhLgihU/U
					gHf+mjhJguhk9bhWglse]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 19,
			bones = {
				Hips = [[
					gAiag5AQgAgAj6gAiag5AQf7f0j6gAiZg5ARfsfSj6gAiXg5ATfYelj7gAiWg5AWfFd6j8gAiVg5AZe4ddj9gAiVg5AZe4ddj9gAiZg5ARgLgbj6gAiag5Ad
					hWjLj/gAiag5AihljvkBgAiag5AihljvkBgAiag5AihljukBgAiag5AehZjTj/gAiag5AYhBiaj9gAiag5ATgkhVj7gAiag5ARgMgcj6gAiag5AQgAgBj6gA
					iag5AQgAgAj6gAiag5AQgAgAj6]],
				Spine1 = [[
					gAihgcAQgAgAj6gAihgcAQf6fwj6gBiggcARfqfEj6gCiegcAUfVeJj7gEidgcAZfAdQj9gEicgcAeeycqj+gEicgcAeeycqj+f/iggcARgMgjj6f6iigdAk
					hdkHkAf6iigdAshtk1kCf6iigdAshtk1kCf6iigdAshtk0kCf6iigdAmhhkRkAf8ihgcAchHjHj9f+ihgcAUgnhvj7f/ihgcARgNgkj6gAihgcAQgAgBj6gA
					ihgcAQgAgAj6gAihgcAQgAgAj6]],
				Spine2 = [[
					gAipf//4gAgAipgBiof//4gCgVipgDinf//3gIhOiogGimf//ygQiaimgIikgA/sgXjjijgKikgA/mgckUiggKikgA/mgckUigf+inf//4f8fUipfzipgB/d
					fgawidfxiqgB/SfaZ1iYfxiqgB/SfaZ1iYfxiqgB/TfaZ3iYfzipgB/bffajicf2ipgA/ofncBiif7ipf//zfydyinf+ipf//4f7fRipgAipf//4gAf/ipgA
					ipf//4gAgAipgAipf//4gAgAip]],
				Spine3 = [[
					gAikfi/4gAgAipgBijfi/4gCgZipgFiifi/2gHhciogKihfj/wgNi2imgPigfk/ngUkNiigSiffk/egYlHifgSiffk/egYlGiff9iifi/3f9fMipfqilfl/S
					flZ1iafmimfm/EfhYwiUfmimfm/EfhYwiUfmimfm/EfhYxiVfpilfm/PfkZliZfvikfk/ifrbUigf3ikfj/xf0dZimf9ikfi/3f8fJipgAikfi/4gAf+ipgA
					ikfi/4gAgAipgAikfi/4gAgAip]],
				Neck1 = [[
					gAiffFAXgAgAkpgCiefFAWf7f1kkgIidfFAVftfXkWgPicfGAUfceukFgXibfIAUfPeGj1gbibfJAVfHdrjqgbibfJAVfHdrjqf8iefFAVgPgykaffihfKAr
					hjkEkufZiifNAyh0kykwfZiifNAyh0kykwfZiifMAyh0kxkwfdihfLAshnkPkvfnigfIAihLjGksfyiffGAagqhukqf7iffFAXgOgkkpgAiffFAXgAgBkpgA
					iffFAXgAgAkpgAiffFAXgAgAkp]],
				Neck2 = [[
					gAiteVA4gAgAnWgDiteVA1f9gCnMgKireVAvf2gHmxgTipeWAofwgNmNgcineXAhfvgQlqgiimeYAefxgSlUgiimeYAefxgSlUf5ireVAxgTgym4fTiwecA/
					heiGnZfLixefBChuidnafLixefBChuidnafLixefBChuidnafRiwedBAhhiLnZfdiveZA8hHhlnYftiueWA5gng4nXf6iteVA4gNgSnWgAiteVA4gAgBnWgA
					iteVA4gAgAnWgAiteVA4gAgAnW]],
				Neck3 = [[
					gAi8d4A4gAgAnWgDi7d4A0gAgPnHgJi4d4AsgCg1megTi1d4AjgLhnlmgcizd5AdgaiVkxgiixd6AbgoizkOgiixd6AbgoizkOf4i5d4AugSgymofPi/d/A5
					hCgQnXfHjAeCA6hOgSnXfHjAeCA6hOgSnXfHjAeCA6hNgSnXfOi/eAA5hFgQnXfbi+d8A5gygMnXfri8d5A4gcgHnWf5i8d4A4gJgCnWgAi8d4A4gAgAnWgA
					i8d4A4gAgAnWgAi8d4A4gAgAnW]],
				Head = [[
					gAjPdS/sgAgAkagCjOdR/pgIfgkpgHjJdQ/fgZeLlTgOjEdQ/LgmcXmJgWi/dQ+wgoaom6gai8dR+bgkZenZgai8dR+bgkZenZf2jKdQ/jgqe1lGfPjSdZ/p
					g0hEkffHjTdc/og9hQkhfHjTdc/og9hQkhfHjTdc/og9hQkhfOjSdZ/pg2hHkffbjRdW/qgng0kdfrjQdT/rgWgdkbf5jPdS/rgHgJkagAjPdS/sgAgAkagA
					jPdS/sgAgAkagAjPdS/sgAgAka]],
				Jaw = [[
					gAiidD/6gAgAiJgCigdD/4gGfgijgGicdE/ugTeJjpgMiWdH/XgecWlGgSiRdK+3gjaombgWiNdN+dgjZenRgWiNdN+dgjZenRf2iddE/ngqe1ktfTildL/T
					gvhHmdfLimdO/Ig2hVnOfLimdO/Ig2hVnOfLimdO/Ig2hVnNfRildL/RgxhKmofeikdH/hgmg1laftijdE/vgWgcj9f6iidD/3gIgJivgAiidD/6gAgAiLgA
					iidD/6gAgAiJgAiidD/6gAgAiJ]],
				["Lid.L"] = [[
					fSj/cwF0OugAmLfTj9cwF1O4gPmtfVj3cxF2Pfg1oFfZjxc0FxQnhmpxfejrc4FnR+iSrLfijoc7FdS/ixr5fijoc7FeTBitr9fEj4cwGxQXdkrqehj/c0Hf
					PTbtrJeYkAc2HlPGbqrDeYkAc2HlPGbqrDeZkAc2HlPHbqrDefkAc0HgPQbsrIesj/cyHWPjbyrQe9j/cwHKP7b5rafLj/cvG4QGcRrKfSj/cwGUPmdrpZfS
					j/cwF7O9fTnLfSj/cwF0OugAmL]],
				["Lid.R"] = [[
					guj/cwF0xSgAmLgvj9ctFyxPgomKgwj4cmF2xOiRmGgzjwcfGOxbkYl+g1jocZG2x2mOlzg2jjcXHYyQnSlkg2jjcXHayPnVlpgfj6cpGmvxkwqUf8kFc5GV
					ujjgr1f0kGc8GOuWjbr3f0kGc8GOuWjbr3f0kGc8GOuXjbr3f6kFc6GTugjfr2gIkDc2Geu0jnrygZkBcyGrvLjxrsgnkAcwGuvnjorRguj/cwGTwaiVpZgu
					j/cwF7xDgtnLguj/cwF0xSgAmL]],
				["UpperLegF.L"] = [[
					fGh0fFz2amgA4gfIhzfEzdaIf54tfPhxfAygY2fq5GfYhve8xoXJfc5Lfhhue5xwVbfm4afnhte3x+UOf13sfnhte3x+UOf13sfBhzfI0JbkgE4denh5fg6H
					iphHyQeih6fm6Yj8hExpeih6fm6Yj8hExpeih6fm6Xj6hExqemh5fh6Li8hHyHeth3fZ5mgyhGzIe4h1fP2Td1gj20fBh0fI0ibogL4IfGh0fFz3aogA4ffG
					h0fFz2amgA4gfGh0fFz2amgA4g]],
				["LowerLegF.L"] = [[
					e4g+fP7RdRgAwfe4g/fP7Jctf+wme7g/fN6gbKfzxPe+g/fJ46ZGfTy1fEg/fC1yXUeE1qfIg+e8zQWXdI3ffIg+e8zQWXdI3fe2g9fS8JeggTvHevhFfN56
					kcf4yOethIfQ6Hlof8xmethIfQ6Hlof8xmethIfQ6Hlmf8xneuhGfO5+ktf5yFeyhCfJ5hitfszGe0g+fQ73g3gOvse2g+fQ7uehgKv4e4g+fP7TdUgAwee4
					g+fP7RdRgAwfe4g+fP7RdRgAwf]],
				["FootF.L"] = [[
					e1gie//UgAgAmje1gie//TfcgHmje1gie//Pd6gcmie1gie//Bbwg5mfe1gie/+pZkhWmae2gje/+IYFhXnIe2gje/+IYGhXnIe1gie//ShQfvmje0gnfB+J
					m7eioDezgqfD9noHeWo1ezgqfD9noHeWo1ezgqfD9ooGeWo0e0gnfC+BnNefoPe1gifA+zlNe5mze1gie//HjhfRmge1gie//ShPfvmje1gie//UgCgAmje1
					gie//UgAgAmje1gie//UgAgAmj]],
				["UpperLegF.R"] = [[
					g6h0fFz2lagA4gg8hzfH0Bk9f+4dhChzfL0qjrf04JhKhyfQ1wh7fj3YhQhyfX3BgOfR2NhUhyfb3/fCfG1HhUhyfb3/fCfG1Ig1hyfCy8magQ4+gShye1xS
					skfz30gKhzezwXtift37gKhzezwXtift37gKhzezwYthft37gQhye0xEsyfy32gchye4ylrFf13kgqhye9zDomgG4Og1hzfCzUmcgI4rg6h0fFz1lcgA4gg6
					h0fFz2lagA4gg6h0fFz2lagA4g]],
				["LowerLegF.R"] = [[
					hIg+fP7RivgAwfhJg+fQ7qiKf4v7hLg8fS8agnfpushNg7fU84epfftrhPg6fV81c9fZtghQg7fU8fb+fat+hQg7fU8fb+fat+hHg+fP7Ej7gDwmgyhFe7yp
					qiie3pgthIe6x2rmia3wgthIe6x2rmia3wgthIe6x4rkia3wgxhGe7ydqxie3rg4hCe8zwo9ic3ZhBhAfF3lmihR0lhGg/fN6jkAgQxZhIg/fP7QixgAwghI
					g+fP7RivgAwfhIg+fP7RivgAwf]],
				["FootF.R"] = [[
					hLgie//UgAgAmjhLgie//TfbgImjhLgie//Pd4gcmihLgie//Db8g2mghLgie/+yaShMmchLgie/+mZXhZmahLgie/+mZXhZmahLgie//ShLfwmjhFgre+8y
					pMfrqfhBgue+7tqlgEr/hBgue+7tqlgEr/hBgue+7vqjgEr8hEgre+8jpgfxq1hJgme/9/nMfOochLgie//DkCfKmghLgie//ShSfvmjhLgie//UgCgAmjhL
					gie//UgAgAmjhLgie//UgAgAmj]],
				Tail1 = [[
					gAiQhijsgAgA/xgAiQhijsfsgG/xf+iPhijse1gX/wf8iNhijtdsgu/rf7iMhhjvcmhD/kf6iLhhjxb3hS/ef6iLhhjxb3hS/egBiPhijtgXf2/xgIiQhhkL
					k7eb/SgJiQhhkxm6d5+zgJiQhhk7nRdz+rgJiQhhk7nQd0+sgIiQhhk5mveA+0gGiQhhkylgee/HgDiQhikhjnfG/dgBiQhikKhsfp/rgAiQhij3gbf9/wgA
					iQhijtgBgA/xgAiQhijsgAgA/x]],
				Tail2 = [[
					gAiJiAmCgAgA/af/iJiAmCfigK/af8iIiAmCeRgk/Xf4iGh/mDcmhH/Nf1iEh/mEa+ho+9fyiDh+mEZ5h++vfyiDh+mEZ5h++wgCiIiAmDgQf1/agRiIh9m1
					nEdl+WgViGh7n0qycc83gWiGh7oFrlcN8dgWiGh7oFrkcN8dgUiGh8oEq9ce8vgQiHh9n+pWdJ9ZgKiIh/njmfeL+WgEiIh/m8jSfM/CgBiJiAmXg9f0/VgA
					iJiAmDgDf//agAiJiAmCgAgA/a]],
				Tail3 = [[
					gAh+icnWgAgA/If+h+icnWfWgO/If5h8icnWdkg0/Cfyh7ibnVbNhl+ufsh5ianTY9iV+Qfoh3iZnRXdi090foh3iZnRXdi091gCh9icnYgHf2/Igdh6iWoX
					pvcm9Ggmh2iPpevXaz55goh1iOpvwmaZ47goh1iOpvwlaa48glh2iPpxv5au5cgfh3iTpwt6bj6vgVh5iXpYp+dA8wgKh7iboplRej+UgDh9icn1hmfn++gA
					h+icnYgFf//IgAh+icnWgAgA/I]],
				Tail4 = [[
					gAhwi4migAgA/Uf9hwi4mifGgQ/Tf1hui3mhcrg7/Ifqhsi1meZch0+lfghqiymaWaip9ufZhpiwmWUajL89fZhpiwmWUbjL89gChvi4mkf+f5/Tgshpirnx
					tDcM75g7hjibo50naM2Cg+hhiWpG2MZz0Pg+hhiWpG2LZz0Qg7hiiZpM1caF1EgzhkigpSzLa33TgkhnirpAuLcZ6/gThrizoMnteM95gFhui3nLiaff/FgA
					hwi4mkgIf+/TgAhwi4migAgA/U]],
				Tail5 = [[
					gAhkjUkbgAgA/rf7hjjUkbe0gP/qfvhijTkablg2/XffhgjPkYXWhp+cfQhdjJkUTaiX8/fGhbjEkQQ4i07ufGhbjEkQQ5i07ugChijUkdfzf6/rhAhZi8mD
					w4cn6RhUhQibnV53bLwphVhOiSnf7da+tshVhOiSng7ca+tvhThOiXnm6zbJu8hLhRiknv4mbqycg6hVi5ndy4cz4hgghbjLmgqleW9cgKhhjSlOjYfh/YgA
					hkjUkdgLf//rgAhkjUkbgAgA/r]],
				["UpperLegB.L"] = [[
					fGh0g+3oZkgA0kfGhzg93qZWgG0efHhxg73qY2gZ0TfHhvg43jYPg20MfIhtg23WXuhU0MfIhrg03KXZhq0QfIhrg03KXZhq0QfGhzg/4FZofi0EfGh3hK3j
					c0ej1XfGh3hM31dMeL1FfGh3hM31dMeL1FfGh3hL31dLeM1FfGh3hK3nc5ee1TfGh2hH4Ebkeg0jfGh1hD4AakfF0afGh0g/3yZ3fs0ffGh0g+3pZkf/0kfG
					h0g+3oZkgA0kfGh0g+3oZkgA0k]],
				["LowerLegB.L"] = [[
					e4g+g0xfeQgA6ue4g+gzw9eOgJ7Ee4g8gwvkeFgc74e4g6gtt1dygv8we5g4grsPdcg89be5g2gprOdKhC9ze5g2gprOdKhC9ze3g+gzxRe1f666e7hBhE3r
					euc51Pe7hBhF38fJcg06e7hBhF38fJcg06e7hBhF38fJch07e7hBhE3ve0cz1Le4hBg91YfVeR3ue3hAg4zefBfM5We3g/g1yHeifx6Ve4g/g0xheRgA6te4
					g+g0xfeQgA6ue4g+g0xfeQgA6u]],
				["FootB.L"] = [[
					e1gihB/UgAgAmje1gihB/UgCgAmje1gihB/UgCgAmje1gihB/Uf4gCmje1gihB/TfogFmje1gihB/TfagImje1gihB/TfagImje1gihB/Tgaf7mje1gihB/S
					e4gPmle1gihB/OfDgIm5e1gihB/OfDgIm5e1gihB/OfDgIm5e1gihB/Re6gNmpe1gihB/UgFf/mje1gihB/UgQf9mje1gihB/UgIf+mje1gihB/UgAgAmje1
					gihB/UgAgAmje1gihB/UgAgAmj]],
				["UpperLegB.R"] = [[
					g6h0g+3omcgA0kg6hzg+3zmYgM0Zg6hzhA4OmNgtz8g6hyhD4ul9hYzXg6hxhG5JltiBy0g6hxhH5aliidyeg6hxhH5aliidyeg6hyg83um7f00Tg3hwgy13
					oWdh1rg2hwgw1bopdE18g2hwgw1bopdE18g2hwgw1bopdE17g3hwgx1xobdb1ug4hxg12Zn8eJ1Vg5hyg53CnUe/08g6hzg83dmvfr0rg6h0g+3omdf/0lg6
					h0g+3omcgA0kg6h0g+3omcgA0k]],
				["LowerLegB.R"] = [[
					hIg+g0xfhwgA6uhJg/g0xfhigE6vhJg/g0xjg8gO6vhKg/g0xtgLga6phLg/g1x8fdgm6ehMg/g1yIfAgt6VhMg/g1yIfAgt6VhIg9gxwJhxfs7khFg6guty
					kLen8ihEg6gttSkqeY8rhEg6gttSkqeY8rhEg6gttSkpeZ8rhFg6gutqkSek8khGg7gvujjie78QhHg9gxvxisfX7shIg+gzw5iDfy7FhIg+g0xehwgA6vhI
					g+g0xfhwgA6uhIg+g0xfhwgA6u]],
				["FootB.R"] = [[
					hLgihB/UgAgAmjhLgihB/Uf2gCmjhLgihB/TfcgHmjhLgihB/Se7gOmjhLgihB/RebgVmjhLgihB/QeGgZmihLgihB/QeHgZmihLgihB/Uf5gBmjhLgihB/S
					hZftmjhLgihB/RhtfpmihLgihB/RhtfpmihLgihB/RhsfpmjhLgihB/RhefsmjhLgihB/ThAfzmjhLgihB/Tggf5mjhLgihB/UgJf+mjhLgihB/UgAgAmjhL
					gihB/UgAgAmjhLgihB/UgAgAmj]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiag5AQgAgAj6gAiZg7APgAgAjvgAiWg/AMgAgAjUgAiThDAKgAgAi7gAiShEAJgAgAi0gAiWhAAMgAgAjRgAibg4AWgAgAkigAidg1AggAgAlmgAidg0Aj
					gAgAl2gAidg0AjgAgAl2gAidg0AjgAgAl2gAidg0AjgAgAl2gAidg0AjgAgAl2gAidg0AjgAgAl2gAidg0AjgAgAl2gAidg0AjgAgAl2gAidg0AjgAgAl2gA
					idg0AjgAgAl2gAidg0AjgAgAl2gAidg1AhgAgAlngAibg3AYgAgAkzgAiag5ASgAgAkEgAiag5AQgAgAj6gAiag5AQgAgAj6gAiag5AQgAgAj6]],
				Spine1 = [[
					gAihgcAQgAgAj6gAiggeAOgAgAjpgAicgiAKgAgAjBgAiZgmAHgAgAicgAiYgnAGgAgAiQgAicgjAKgAgAi9gAijgbAXgAgAktgAingZAmgAgAmEgAiogYAq
					gAgAmZgAiogYAqgAgAmZgAiogYAqgAgAmZgAiogYAqgAgAmZgAiogYAqgAgAmZgAiogYAqgAgAmZgAiogYAqgAgAmZgAiogYAqgAgAmZgAiogYAqgAgAmZgA
					iogYAqgAgAmZgAiogYAqgAgAmZgAingZAmgAgAmGgAikgaAbgAgAlEgAiigcASgAgAkGgAihgcAQgAgAj6gAihgcAQgAgAj6gAihgcAQgAgAj6]],
				Spine2 = [[
					gAipf//4gAgAipgAingB/2gAgAi/gAiigF/wgAgAj1gAidgI/qgAgAkngAicgJ/ngAgAk1gAihgF/wgAgAj7gAisf//8gAgAhsgAiyf9//gAgAf+gAizf9//
					gAgAflgAizf9//gAgAflgAizf9//gAgAflgAizf9//gAgAflgAizf9//gAgAflgAizf9//gAgAflgAizf9//gAgAflgAizf9//gAgAflgAizf9//gAgAflgA
					izf9//gAgAflgAizf9//gAgAflgAiyf9//gAgAf8gAiuf+/+gAgAhOgAipf//5gAgAiagAipf//4gAgAipgAipf//4gAgAipgAipf//4gAgAip]],
				Spine3 = [[
					gAikfi/4gAgAipgAihfk/2gAgAjFgAibfo/ugAgAkHgAiVfs/lgAgAlGgAiTft/igAgAlYgAiafp/tgAgAkQgAiofi/9gAgAhhgAiyfg//gAgAffgAi0ff/+
					gAgAfBgAi0ff/+gAgAfBgAi0ff/+gAgAfBgAi0ff/+gAgAfBgAi0ff/+gAgAfBgAi0ff/+gAgAfBgAi0ff/+gAgAfBgAi0ff/+gAgAfBgAi0ff/+gAgAfBgA
					i0ff/+gAgAfBgAi0ff/+gAgAfBgAiyfg//gAgAfdgAirfh/+gAgAg+gAilfi/5gAgAiXgAikfi/4gAgAipgAikfi/4gAgAipgAikfi/4gAgAip]],
				Neck1 = [[
					gAiffFAXgAgAkpgAibfHAQgAgAj6gAiTfMAGgAgAiIgAiMfQABgAgAgdgAiJfSABgAgAf9gAiSfMAFgAgAh6gAimfFApgAgAmUgAizfCBbgAgApYgAi2fCBp
					gAgAqEgAi2fCBpgAgAqEgAi2fCBpgAgAqEgAi2fCBpgAgAqEgAi2fCBpgAgAqEgAi2fCBpgAgAqEgAi2fCBpgAgAqEgAi2fCBpgAgAqEgAi2fCBpgAgAqEgA
					i2fCBpgAgAqEgAi2fCBpgAgAqEgAizfCBcgAgApbgAiqfDA1gAgAnMgAihfFAbgAgAlEgAiffFAXgAgAkpgAiffFAXgAgAkpgAiffFAXgAgAkp]],
				Neck2 = [[
					gAiteVA4gAgAnWgAioeWApgAgAmUgAiaeaAQgAgAj2gAiNeeADgAgAhegAiJegACgAgAgygAiYebANgAgAjhgAi5eWBegAgApigAjPeZDBgAgAthgAjUeaDd
					gAgAuagAjUeaDdgAgAuagAjUeaDdgAgAuagAjUeaDdgAgAuagAjUeaDdgAgAuagAjUeaDdgAgAuagAjUeaDdgAgAuagAjUeaDdgAgAuagAjUeaDdgAgAuagA
					jUeaDdgAgAuagAjUeaDdgAgAuagAjPeZDDgAgAtmgAjAeWB3gAgAqsgAiweVBBgAgAn6gAiteVA4gAgAnWgAiteVA4gAgAnWgAiteVA4gAgAnW]],
				Neck3 = [[
					gAi8d4A4gAgAnWgAi0d4AlgAgAmBgAiid6AJgAgAizgAiQd+ABgAgAfwgAiLd/ACgAgAe2gAifd7AHgAgAiYgAjMd8BpgAgAqFgAjoeEDxgAgAvDgAjueHEY
					gAgAwIgAjueHEYgAgAwIgAjueHEYgAgAwIgAjueHEYgAgAwIgAjueHEYgAgAwIgAjueHEYgAgAwIgAjueHEYgAgAwIgAjueHEYgAgAwIgAjueHEYgAgAwIgA
					jueHEYgAgAwIgAjueHEYgAgAwIgAjoeED0gAgAvIgAjUd9CLgAgArigAjAd5BDgAgAoDgAi8d4A4gAgAnWgAi8d4A4gAgAnWgAi8d4A4gAgAnW]],
				Head = [[
					gAjPdS/sgAgAkagAjEdQ/YgAgAmMgAipdQ+RgAgAqVgAiPdT8vgAgAuEgAiIdU8MgAgAvIgAimdQ+GgAgBq1gAjldZ//gAgAgXgAkMds/TgZfQZdgAkUdx+h
					feg0WdgAkUdx+vgAgAXJgAkUdx+6ggfLX2gAkUdx+hfeg0WdgAkUdx+vgAgAXJgAkUdx+6ggfLX2gAkUdx+hfeg0WdgAkUdx+vgAgAXJgAkUdx+6ggfLX2gA
					kUdx+hfeg0WdgAkUdx+vgAgAXJgAkMds/RgZfQZVgAjxdd/6f2gbd5gAjVdT/0gAgAjYgAjPdS/sgAgAkagAjPdS/sgAgAkagAjPdS/sgAgAka]],
				Jaw = [[
					gAiidD/6gAgAiJgAiWdH/ugAgAkIgAh6dT+xgAgAovgAhidi9RgAgAs6gAhcdn8ugAgAuGgAh3dV+kgAgBpbgAi9dA/8gAgAhtf/jydE/+ghfWfZgBkCdF/4
					fTgrdhgAkAdG/8gAgAeQf/j+dH/9grfTe+gBkCdF/4fTgrdhgAkAdG/8gAgAeQf/j+dH/9grfTe+gBkCdF/4fTgrdhgAkAdG/8gAgAeQf/j+dH/9grfTe+gB
					kCdF/4fTgrdhgAkAdG/8gAgAeQf/jzdE/+gifWfXgAjNc+//f1gagAgAipdC/8gAgAh2gAiidD/6gAgAiJgAiidD/6gAgAiJgAiidD/6gAgAiJ]],
				["Lid.L"] = [[
					fSj/cwF0OugAmLfSjwcpFhOzgyk9fSjJcfFCPIiiiGfSiicbEzPnj1fufSiWcbEpPzjhf5fSjEceE+PqgQk/fSkddEIbQ1aXuUfQlFdyMVSrXwzwfUlPeAOL
					TkU70sfSlNd/NyTVWD0xfQlMd+NZTJXL01fUlPeAOLTkU70sfSlNd/NyTVWD0xfQlMd+NZTJXL01fUlPeAOLTkU70sfSlNd/NyTVWD0xfQlMd+NZTJXL01fU
					lPeAOLTkU70sfSlNd/NyTVWD0xfQlGdzMaSuXsz2fTkrdQJnRPY0v3fSkHc0GxP4cwqxfSj/cwGFPPeioOfSj/cwF3O2fmmwfSj/cwF0OugAmL]],
				["Lid.R"] = [[
					guj/cwF0xSgAmLgujwcpFhxNfOk9gujJcfFCw4deiGguiicbEzwZcLfuguiWcbEpwNcff5gujEceE+wWfvlAgukddEIbvLlpuUgslIdvMPtdpty6gwlKeDOX
					sdpa1pgulNd/Nysrp90xgslQd6NQs7qgz3gwlKeDOXsdpa1pgulNd/Nysrp90xgslQd6NQs7qgz3gwlKeDOXsdpa1pgulNd/Nysrp90xgslQd6NQs7qgz3gw
					lKeDOXsdpa1pgulNd/Nysrp90xgslJdvMVtapxzAgvkqdSJmunmbwUgukHc0GxwIjQqxguj/cwGFwxheoOguj/cwF3xKgamwguj/cwF0xSgAmL]],
				["UpperLegF.L"] = [[
					fGh0fFz2amgA4gfGhwfIzdaZfz4xfGhofQzZZ5fa4sfGhhfX0DZUfF4AfGhffZ0VZIfA3tfGhnfRzeZ0fW4nfGh6fB1Ua2gT3SfGiIe61/bfgi2yfGiMe417
					bngh23fGiMe417bngh23fGiMe417bngh23fGiMe417bngh23fGiMe417bngh23fGiMe417bngh23fGiMe417bngh23fGiMe417bngh23fGiMe417bngh23fG
					iMe417bngh23fGiMe417bngh23fGiJe61+begg2yfGh+e/waa3ez68fGh1fEwsage36tfGh0fFz0amf/4hfGh0fFz2amgA4gfGh0fFz2amgA4g]],
				["LowerLegF.L"] = [[
					e4g+fP7RdRgAwfe3g8fT8idMgcuLe0g0fa+XcwhNpdezgtfe/PcOhvldeygrff/ZcDh3kWe0gzfb+jcrhTo0e6hEfF41dRfHz9e8hRe72Xdied2se8hVe62S
					dpec2ye8hVe62Sdpec2ye8hVe62Sdpec2ye8hVe62Sdpec2ye8hVe62Sdpec2ye8hVe62Sdpec2ye8hVe62Sdpec2ye8hVe62Sdpec2ye8hVe62Sdpec2ye8
					hVe62Sdpec2ye8hVe62Sdpec2ye8hSe72Wdhea2te1hPfW98dkg3q8e0hFfa+cdPhPpWe4g/fP7VdSgBwae4g+fP7RdRgAwfe4g+fP7RdRgAwf]],
				["FootF.L"] = [[
					e1gie//UgAgAmje1gie//Uf/gAmje1gie//UfpgFmje1gie//TfEgNmje1gie//Se3gPmje1gie//TfkgGmje1gke+/UfzgDmje2gxe7+af1fXp4e3g0e6+L
					f7fMqme3g0e6+Lf7fMqme3g0e6+Lf7fMqme3g0e6+Lf7fMqme3g0e6+Lf7fMqme3g0e6+Lf7fMqme3g0e6+Lf7fMqme3g0e6+Lf7fMqme3g0e6+Lf7fMqme3
					g0e6+Lf7fMqme3g0e6+Lf7fMqme2gxe7+jf0fcpde1g6e9/Tgbf6mje1gze//UgIf+mje1gie//UgAgAmje1gie//UgAgAmje1gie//UgAgAmj]],
				["UpperLegF.R"] = [[
					g6h0fFz2lagA4gg6hwfIzdlngN4xg6hofQzZmHgm4sg6hhfX0Dmsg74Ag6hffZ0Vm4hA3tg6hnfRzemMgq4ng6h6fB1UlKft3Sg6iIe61/khfe2yg6iMe417
					kZff23g6iMe417kZff23g6iMe417kZff23g6iMe417kZff23g6iMe417kZff23g6iMe417kZff23g6iMe417kZff23g6iMe417kZff23g6iMe417kZff23g6
					iMe417kZff23g6iMe417kZff23g6iJe61/khff2yg6h+e/x9lGgp5+g6h1fExulcgt6Eg6h0fFz1lagA4hg6h0fFz2lagA4gg6h0fFz2lagA4g]],
				["LowerLegF.R"] = [[
					hIg+fP7RivgAwfhJg8fT8ii0fkuLhMg0fa+XjQezpdhNgtfe/PjyeRldhOgrff/Zj9eJkWhMgzfb+jjVeto0hGhEfF41ivg5z9hEhRe72Xiehj2shEhVe62S
					iXhk2yhEhVe62SiXhk2yhEhVe62SiXhk2yhEhVe62SiXhk2yhEhVe62SiXhk2yhEhVe62SiXhk2yhEhVe62SiXhk2yhEhVe62SiXhk2yhEhVe62SiXhk2yhE
					hVe62SiXhk2yhEhVe62SiXhk2yhEhSe72Wiehl2thKhMfR8ciWfuudhLhDfW9diofMsKhIg/fP7Tiuf/wchIg+fP7RivgAwfhIg+fP7RivgAwf]],
				["FootF.R"] = [[
					hLgie//UgAgAmjhLgie//UgBgAmjhLgie//UgXf7mjhLgie//Tg8fzmjhLgie//ShJfxmjhLgie//Tgcf6mjhLgke+/UgNf9mjhKgxe7+agLgpp4hJg0e6+L
					gFg0qmhJg0e6+LgFg0qmhJg0e6+LgFg0qmhJg0e6+LgFg0qmhJg0e6+LgFg0qmhJg0e6+LgFg0qmhJg0e6+LgFg0qmhJg0e6+LgFg0qmhJg0e6+LgFg0qmhJ
					g0e6+LgFg0qmhJg0e6+LgFg0qmhKgxe7+fgLgnpqhLgxe9/TflgGmjhLgse//UfygDmjhLgie//UgAgAmjhLgie//UgAgAmjhLgie//UgAgAmj]],
				Tail1 = [[
					gAiQhijsgAgA/xgAiQhkjYgAgA/0gAiOhoiqgAgA/4gAiMhth+gAgA/7gAiMhuhxgAgA/8gAiOhpilgAgA/4gAiPhhk3fmgC/ngAiPhcmzgQgA/QgAiOhcnQ
					g+gA/JgAiOhcnRfNgA/JgAiOhcnRfcgA/JgAiOhcnQhFgA/IgAiOhcnRgAgA/KgAiOhcnQe7gA/IgAiOhcnRgkgA/JgAiOhcnRgzgA/JgAiOhcnQfCgA/JgA
					iOhcnRfugA/JgAiOhcnQhHgA/IgAiPhcm1fwgA/QgAiPhflWfjgC/igAiQhhj+gEgA/vgAiQhijsgAgA/xgAiQhijsgAgA/xgAiQhijsgAgA/x]],
				Tail2 = [[
					gAiJiAmCgAgA/agAiJiClmgAgA/fgAiJiHkkgAgA/qgAiIiLjmgAgA/ygAiIiNjTgAgA/0gAiJiIkdgBgA/rf/iGh+nvfRgH/CgAiCh4qff6f/+OgCiBh3rH
					iEf297f/iBh3rIfDgH9+f/iBh3rIebgG99gCiBh3rIhxf298gAiBh3rIgqf/9/f+iBh3rHd5gK97gBiBh3rIgcf89/gBiBh3rHh5f498f+iBh3rIemgJ99f/
					iBh3rIe2gE9+gCiBh3rHiBf197gAiCh4qigGgB+Nf/iFh8obfDgI+2gAiJh/mcgFf//VgAiJiAmCgAgA/agAiJiAmCgAgA/agAiJiAmCgAgA/a]],
				Tail3 = [[
					gAh+icnWgAgA/IgAh/ifmygAgA/QgAiAikldgAgA/hgAiCipkMgAgA/tgAiCirj0gAgA/wgAiAillUgCgA/jf+h4iZpkfJgL+hgAhviRtFfGgC9LgFhtiOt3
					i4fp8rf9htiOt6fkgM8zf8htiOt4dXgR8tgFhtiOt5h0fr8wgBhtiOt5huf68xf6htiOt4dUgY8sgChtiOt6fsf68zgFhtiOt3i3fs8rf8htiOt6e2gR8yf9
					htiOt4dwgM8ugGhtiOt4iVfp8ugAhviQtJg7f/9Jf9h2iXqcergQ+NgAh9icn4gCf//AgAh+icnWgAgA/IgAh+icnWgAgA/IgAh+icnWgAgA/I]],
				Tail4 = [[
					gAhwi4migAgA/UgAhyi7l2gAgA/dgAh2jBkMgAgA/tgAh6jHingAgA/4gAh7jJiKgAgA/6gAh2jCkBgCf//vf8hmiypTfRgK+mf/hYiltoeIgB84gKhVihun
					jGfl8Sf8hViiuqgkgR8bf4hVihumcogS8QgIhVihuphMfm8agEhViiunixf88Uf2hVihundYgc8VgBhViiupemf28agJhVihumjWfp8Rf6hVihuqfrgW8bf6
					hVihunc0gL8SgJhVihuoh+fk8YgBhYiltth6f/82f7hjivqYelgQ+OgAhui3nLf9gA/LgAhwi4migAgA/UgAhwi4migAgA/UgAhwi4migAgA/U]],
				Tail5 = [[
					gAhkjUkbgAgA/rgAhnjYjlgAgA/ygAhujfhngAgA/8gAh0jlfvgAgA//gAh3jnfLgAgA/+gAhujghagDgA/9f7hVjMnwfmgH/Cf7hAi5s+dYf39HgPg8iyuM
					iqfj8if9g7i0uNhpge8nfyg8izuLcggN8dgKg7izuOgLfb8pgJg8izuLjagG8efyg8izuNeEgi8mf/g7izuNdmfo8kgPg8iyuMjMfq8ff6g7izuOgxgj8pf0
					g8izuLcbgE8dgMg8izuNhGfb8ogFhAi4tFiqgJ9Ef5hQjHpFexgM+pgAhgjSlNf4gB/kgAhkjUkbgAgA/rgAhkjUkbgAgA/rgAhkjUkbgAgA/r]],
				["UpperLegB.L"] = [[
					fGh0g+3oZkgA0kfGhyhA4KZRf4z3fGhwhF5MYrfmyUfGhthK5/YOfYw8fGhshM6MYGfVwjfGhvhG5UYnfkyFfGh0g73RZzf/1EfGh2g11oaugQ2+fGh2g01C
					bCgW3lfGh2g01CbCgW3lfGh2g01CbCgW3lfGh2g01CbCgW3lfGh2g01CbCgW3lfGh2g01CbCgW3lfGh2g01CbCgW3lfGh2g01CbCgW3lfGh2g01CbCgW3lfG
					h2g01CbCgW3lfGh2g01CbCgW3lfGh2g11lavgQ3BfGh1g52vaGgG1tfGh0g93gZpgB0wfGh0g+3oZkgA0kfGh0g+3oZkgA0kfGh0g+3oZkgA0k]],
				["LowerLegB.L"] = [[
					e4g+g0xfeQgA6ue3g+gzxGedgL6/e2g+gywmeugg7Ue2g+gywge1gx7Xe2g+gywie1g17We2g+gywiewgj7We4g+g0xaeRf16ye6g/g3yzdnfP5we6hAg5zi
					dTfC5Ke6hAg5zidTfC5Ke6hAg5zidTfC5Ke6hAg5zidTfC5Ke6hAg5zidTfC5Ke6hAg5zidTfC5Ke6hAg5zidTfC5Ke6hAg5zidTfC5Ke6hAg5zidTfC5Ke6
					hAg5zidTfC5Ke6hAg5zidTfC5Ke6g/g3y2dmfP5ue4g/g1x2eDfp6ee4g/g0xhePf96te4g+g0xfeQgA6ue4g+g0xfeQgA6ue4g+g0xfeQgA6u]],
				["FootB.L"] = [[
					e1gihB/UgAgAmje1gihB/UgPf9mje1gihB/Tgof4mje1gihB/Tg2f1mje1gihB/Tg5f0mje1gihB/Tgrf3mje1gihB/Uf7gBmje1gihB/TfHgMmje1gihB/S
					exgRmje1gihB/SexgRmje1gihB/SexgRmje1gihB/SexgRmje1gihB/SexgRmje1gihB/SexgRmje1gihB/SexgRmje1gihB/SexgRmje1gihB/SexgRmje1
					gihB/SexgRmje1gihB/SexgRmje1gihB/TfGgMmje1gihB/UfqgFmje1gihB/Uf9gBmje1gihB/UgAgAmje1gihB/UgAgAmje1gihB/UgAgAmj]],
				["UpperLegB.R"] = [[
					g6h0g+3omcgA0kg6hyhA4KmvgIz3g6hwhF5MnVgayUg6hthK5/nygow8g6hshM6Mn6grwjg6hvhG5UnZgcyFg6h0g73RmNgB1Eg6h2g11olSfw2+g6h2g01C
					k+fq3lg6h2g01Ck+fq3lg6h2g01Ck+fq3lg6h2g01Ck+fq3lg6h2g01Ck+fq3lg6h2g01Ck+fq3lg6h2g01Ck+fq3lg6h2g01Ck+fq3lg6h2g01Ck+fq3lg6
					h2g01Ck+fq3lg6h2g01Ck+fq3lg6h2g11llRfw3Bg6h1g52vl6f61tg6h0g93gmXf/0wg6h0g+3omcgA0kg6h0g+3omcgA0kg6h0g+3omcgA0k]],
				["LowerLegB.R"] = [[
					hIg+g0xfhwgA6uhJg+gzxGhjf16/hKg+gywmhSfg7UhKg+gywghLfP7XhKg+gywihLfL7WhKg+gywihQfd7WhIg+g0xahvgL6yhGg/g3yziZgx5whGhAg5zi
					itg+5KhGhAg5ziitg+5KhGhAg5ziitg+5KhGhAg5ziitg+5KhGhAg5ziitg+5KhGhAg5ziitg+5KhGhAg5ziitg+5KhGhAg5ziitg+5KhGhAg5ziitg+5KhG
					hAg5ziitg+5KhGhAg5ziitg+5KhGg/g3y2iagx5uhIg/g1x2h9gX6ehIg/g0xhhxgD6thIg+g0xfhwgA6uhIg+g0xfhwgA6uhIg+g0xfhwgA6u]],
				["FootB.R"] = [[
					hLgihB/UgAgAmjhLgihB/UfxgDmjhLgihB/TfYgImjhLgihB/TfKgLmjhLgihB/TfHgMmjhLgihB/TfVgJmjhLgihB/UgFf/mjhLgihB/Tg5f0mjhLgihB/S
					hPfvmjhLgihB/ShPfvmjhLgihB/ShPfvmjhLgihB/ShPfvmjhLgihB/ShPfvmjhLgihB/ShPfvmjhLgihB/ShPfvmjhLgihB/ShPfvmjhLgihB/ShPfvmjhL
					gihB/ShPfvmjhLgihB/ShPfvmjhLgihB/Tg6f0mjhLgihB/UgWf7mjhLgihB/UgDf/mjhLgihB/UgAgAmjhLgihB/UgAgAmjhLgihB/UgAgAmj]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiag5AQgAgAj6gAiZg5AQgEgdjzgAiQg5AMgKhDjFgAimg5AVgHhEkSgAi6g5AbgEgqlDgAjBg5AdgAgAlSgAi6g5Abf8fWlDgAimg5AVf5e8kSgAiQg5AM
					f2e9jEgAiUg5ANf6fWjagAiTg5AMgAgAjUgAiwg5AXgEgqkrgAi+g5AdgGhElNgAjAg5AegFhElQgAi0g5AZgEgqk0gAiag5APgAgAjrgAiTg5AMf6fWjUgA
					iag5ARf4e9j5gAiag5ARf6fNj6gAiag5AQf/f2j6gAiag5AQgAgAj6]],
				Spine1 = [[
					gAihgcAQgAgAj6f/iggcAPgEgdjvf+iWgcAIgJhDihf+iugcAWgIhEkaf/jDgdAggEgqlggAjKgdAjgAgAl2gBjDgdAgf8fWlggCiugcAWf4e8kagCiWgcAI
					f3e9ihgBibgcALf7fWjEgAiZgcAJgAgAi6f/i4gcAagFgqk/f+jIgdAjgHhEltf+jJgdAkgHhElyf/i8gcAcgEgqlMgAihgcANgAgAjfgBiZgcAKf7fWi6gC
					ihgcARf4e9j4gBihgcARf6fNj6gAihgcAQf/f2j6gAihgcAQgAgAj6]],
				Spine2 = [[
					gAipf//4gAgAipf+inf//2gCfji5f8ibf+/pgGe8klf8i3gA/6gGe8iAf+jNgB/+gEfWglgAjVgB//gAgAgIgCjNgB/+f8gqglgEi3gA/6f6hEiAgEibf+/p
					f6hEkmgCigf//wf8gqj1gAiff+/vgAgAkDf+jCgA/9gEfWhQf8jSgB/+gGe8gTf8jUgB/+gGe8gNf+jGgA/+gEfWg/gAinf//0gAgAjRgCiff+/uf8gqkCgE
					iof//3f6hEirgDipf//3f8gzipgBipf//4f/gKipgAipf//4gAgAip]],
				Spine3 = [[
					gAikfi/4gAgAipf+ihfi/2gCfji+f6iTfi/jgHe8lIf6izfj/6gGe8h4f8jMfj//gDfWgHgAjVfk//gAgAflgEjMfj//f9gqgHgGizfj/6f6hEh4gGiSfi/j
					f5hElJgEiZfi/tf8gqkKgAiXfi/rgAgAkcf8i/fj/+gDfWg8f6jSfk/+gFe8fxf6jTfk/+gFe8fqf8jEfj/+gDfWgogAihfi/zgAgAjegEiXfi/rf8gqkcgG
					ijfi/3f6hEisgEikfi/3f8gzipgBikfi/4f/gKipgAikfi/4gAgAip]],
				Neck1 = [[
					gAiffFAXgAgAkpf9icfFATgEgdkLf4iJfHADgGhEhCf4ivfGAlgLhDl2f7jMfGBKgIgpoegAjWfGBZgAgApRgFjMfGBKf4fXoegIivfGAlf1e9l2gIiJfHAD
					f6e8hBgFiSfGAHf7fWidgAiPfGAFgAgAiDf7i+fGA2gHgpnOf4jSfGBUgOhDo+f4jUfGBXgOhDpJf7jDfGA+gIgpntgAibfFANgAgAjfgFiPfGAGf8fWiDgI
					iefFAXf2e9klgGiffFAXf5fOkpgBiffFAXf+f2kpgAiffFAXgAgAkp]],
				Neck2 = [[
					gAiteVA4gAgAnWf7ipeVAvgGgcmwf1iMeUAJgJhDirf1jCeXBUgRhCo9f5jmebChgNgosXgAjyecC+gAgAtagHjmebChfzfYsXgLjCeXBUfve+o9gLiMeUAJ
					f3e9ipgHiZeUAWf5fXkggAiWeUARgAgAj/f5jUeYB5gMgoqxf1jtecC0gXhAtBf1jwecC6gXhAtPf5jbeZCIgNgorZgAimeUAkgAgAl4gHiWeUARf5fXj/gL
					iteVA4fxe+nRgIiteVA4f0fOnWgCiteVA4f+f2nWgAiteVA4gAgAnW]],
				Neck3 = [[
					gAi8d4A4gAgAnWf7i2d3AtgGgcmnfziSd1AFgHhEhjfzjTd7BcgShBpYf4j9eEDEgPgntogAkKeHDtgAgAu6gIj9eEDEfxfZtogNjTd7Bcfue/pYgNiSd1AE
					f5e8hhgIiid1AQf6fWj1gAied1ALgAgAjLf4jod/COgNgorof0kFeHDfgag/ucf0kIeHDngag/usf4jweBCigOgosagAiyd2AggAgAljgIied1AMf6fWjMgN
					i7d4A3fxe+nPgKi8d4A4f0fOnWgCi8d4A4f+f2nWgAi8d4A4gAgAnW]],
				Head = [[
					gAjPdS/sgAgAkaf5jIdQ/uhLfuj/fwiWdK+ui4e/oYfxjrdY/4infngjf3kedp/thff/cEgAkudv/igAgAargJkedp/tehgBcEgPjrdY/4dZgZgjgQiWdK+t
					dIhBoagKitdL/UeQghmPgAimdK/PgAgAm7f3kFdg/5hjf4eOfykodt/iiWgDbIfykrdu/fiVgEa2f3kPdj/2hhf7dYgAjAdO/qgAgAkkgKimdL/MeQgjm4gP
					jOdS/wdTgkiwgMjPdS/xd+gcjGgCjPdS/vflgGj/gAjPdS/sgAgAka]],
				Jaw = [[
					gAiidD/6gAgAiKf8ibdA/hhMfxlUf3hndH90i9fQrLf3jDc//sipf3jff6j+dG/8hegIfAgAkRdJ/5gAgAdngGj+dG/8eif4fAgJjDc//sdXgJjfgJhndH9z
					dDgwrNgGh+dC+neOgXpGgAh3dD+dgAgApxf6jhdB/7hjgBhLf3kLdI/2iVgQeEf3kOdJ/1iUgSdxf6jsdD/9hhgEgVgAiTdA/HgAgAndgFh4dD+beNgZpugJ
					ijc//XdRgUlqgHikdA/kd8gVkvgBiidC/2flgHjCgAiidD/6gAgAiJ]],
				["Lid.L"] = [[
					fSj/cwGVPndopdfHj2cwHBO5eGqGe4i0ciGvNwhqm/e6kadEI/ORdBtBfElUdjKZPsaFv/fSlpdvKXRGYzwwfglddkI8R6Y3vifrkpdBGgR5aVr4fujCcYEK
					RSd1lIfjjdciFEQpdfnbfSjQchFqPee8nYfEk6dTJaPSbPuge8lcdqLWPQZ8wte8lfdsLgPUZyw5fElFdZJyPcayvFfSjwcrGSPmdtpVfjjVcfE6Qndzm4fs
					kIczFrRobSqEflkHcyF1RHb0p+fWkBcwGQP7dKpsfSj/cwGVPndopd]],
				["Lid.R"] = [[
					guj/cwGVwZiYpdgjj8cuF7vkjRpegSjCcYEKuuiMlKgVkpdBGguHlrr4gglddkI8uGnJvigulpdvKXu6nNwwg8lUdjKZwUl7v/hGkadEI/xvi/tBhIi0ciGu
					yQeUm+g+jUcmGqxlgVocgujQchFqwihEnYgflDdSH6ufmNt7gXlpdsJBtMn4wFgXlsdvJLtIn/wSgflNdZITuWmkukgujwcrGSwaiTpVg+jMckGgxmf9n7hG
					j5c3INx/htrahBj8c2Hvxmh5q/gyj/cxGqwpiWp6guj/cwGVwZiYpd]],
				["UpperLegF.L"] = [[
					fGh0fFz2amgA4gfDhxfIzjbGf/42e/hffRzCbJfn5Qe/iEfH0LcMgQ4ifBihfC2icJgq2XfGire+18bYga20fLihe91jaWgP29fOiEfAzSZWfp4pfOhefJwi
					YKeP6LfLhmfIxZZKe958fGhkfLx4Z8fL50fBiSfD1Eb3gW3te+infC2wcygx2Pe+ipfC2uczgx2RfBiYfD1pb9ge3MfGhwfIyKaRfb5sfLhkfIxOZDe16BfO
					hzfCzYZKfu4hfMh0fCzjZhf04efHh0fFzxaYf94hfGh0fFz2amgA4g]],
				["LowerLegF.L"] = [[
					e4g+fP7SdRgAwfe2g8fT8meDgiuNexgqff/meqiKkQe1hOfR8DfPgYvXe5hqfA22eNep2Se8h0e/2VdceU2te+hre+2CcceE21e7hRfK5pbnfNyme0gwfd+k
					aOhxnNe1g2fZ95bphLqcezgyfc+rcyhjoWe3hcfJ5oegfizFe4hwfB3Ae1ez2Le4hyfB2+e2ez2Ne4hhfG4keZfM0ae1g9fY9vdIhBrZe1g0fb+PbfhYpUe7
					hAfM6Dbcfbx/e6g/fM6Sb6fixxe4g/fO7Gc/f7wue4g+fP7RdRgAwf]],
				["FootF.L"] = [[
					e1gie//UgAgAmje1gie//Tg2f1mje1gie//Rhrfqmje1gye/+3h8ffoMe1hJe/+RgzfsqUe1hUe/9zgCfuroe2hLe/+BfBgDq/e1gye/+4eTgdoMe1gie//L
					dEgnmhe1gie//ReigUmje1gie//UftgEmje1g8e/+phIfrpGe1hPe/+DhZfcq2e1hRe/9/hafarDe1hBe/+ihAfspee1gne//Lf/gAnIe1gie//ReYgWmje1
					gie//QeHgZmie1gie//SelgTmje1gie//UftgEmje1gie//UgAgAmj]],
				["UpperLegF.R"] = [[
					g6h0fFz2lagA4gg3hxfFy9mJgV5BgyhefJwin2hw6LgyiEfAzSmqgX4pg1ihe91jlqfx29g6ire+18kofm20g/ihfC2ij3fW2XhBiEfH0Lj0fw4ihBhefRzC
					k3gZ5Pg+hnfMyqlDgX5fg6hkfLx4mEg150g1iTe/1ul6fu2vgyioe71LmGf63Mgyiqe71KmEf63Ng1iYe+1plzfv21g6hwfIyKlvgl5sg+hkfNyklKgd5ihB
					hzfJ0dj+fr4RhAh0fI0WkVfw4Tg7h0fGz8lMf94eg6h0fFz2lagA4g]],
				["LowerLegF.R"] = [[
					hIg+fP7SivgAwfhIg9fR7zjjf1vbhMgwfd+klyeQnRhFhRfK5pkZgzymhChre+2Cjkh821hEh0e/2Vikhs2thHhqfA22hzhX2ShLhOfR8DgxfovXhPgqff/n
					hXd1kNhNgzfb+sh0efoshNgyfc+rjOedoWhDhde/2Ojxh62nhBhye+1ukBiI3DhBh0e+1sj/iI3EhDhie/2Kjsh72thLg9fY9vi4e/rZhOgxfc+/h6eUnihL
					g9fS8Pg6fivAhKg9fR78hXfrvhhJg+fP7cicf7wRhIg+fP7RivgAwf]],
				["FootF.R"] = [[
					hLgie//UgAgAmjhLgie//Tgxf2mjhLgie//Li7fZmhhLgye/+4htfjoMhKhLe/+Bg/f9q/hLhUe/9zf+gSrohLhJe/+RfNgUqUhLgye/+3eEghoMhLgie//R
					eVgWmjhLgie//Se5gPmjhLgie//UgTf8mjhLg9e/+mhPfrpOhKhSe/9qhbf/r5hKhUe/9lhZgBsFhLhCe/+YhIfzp9hLgne//LgBgAnIhLgie//Te9gOmjhL
					gie//QeKgZmihLgie//SeogSmjhLgie//UfugEmjhLgie//UgAgAmj]],
				Tail1 = [[
					gAiQhijsgAgA/xgBiPhijki7fq/pgDiJhii0lPfQ/bgDichikpibft/jgCithhmLeDgP/VgAizhhmqblgj++f+ithhmKcwga/Of9ichikqgUf+/pf9iJhii1
					jJfj/tf+iMhijLi7fn/sgAiLhijGgAgA/1gCikhhlYdEgX/ZgDixhhmfc2gZ/KgDiyhhmofsgD/SgCiohhlrjQfn/UgAiRhijokbfb/ef+iLhijFh9fv/yf9
					iQhijqdlgS/sf+iQhijqcEgd/igAiQhijse8gI/wgAiQhijsgAgA/x]],
				Tail2 = [[
					gAiJiAmCgAgA/agHiJh/l4kWfK/IgNiDh/k+pYd9+HgHiTh/nelYe8+nf+iih9pydRgm+Vf4inh8qTXyhr9Gf4iih9pmZAhY9rf+iTh/nkfxgC/FgDiDiAlG
					mQeo+7gEiGiAlZnIeh+rgAiFiAlbh3fn/ef8iah+ojbBhB+af9ilh9qEYmhb9agCimh9qbcrgi+DgIidh9pBkBfI+agIiKh/l/oPeT+RgCiFiAlWluey+/f5
					iJh/mAeKgX/Xf3iJh/l6ZvhN+yf+iJiAmBd4ga/WgAiJiAmCgAgA/a]],
				Tail3 = [[
					gAh+icnWgAgA/IgOh9ibnLkfe7+1gdh5iXl9srcq8kgRiFiYpEpQd09Lf5iQiWsWebgq9dfriUiQsvVSiz7LftiQiTrtU8im7hf9iFiapadbgh+dgOh5ibmU
					nvd9+UgQh7iamarEdN9MgDh7idmrlKes+1f0iKiXqsa1ha9rfxiTiSsXVMim7Vf8iTiVs7YshZ8TgPiMiWrWi2fA9wgXh+iXnQqydS9GgMh7ibmap2df9pf1
					h+icnVggf4/Ifrh+iZnJYohw+Pf6h+icnUc2gw++gAh+icnWgAgA/I]],
				Tail4 = [[
					gAhwi4migAgA/UgWhwi2mZjafS/JgxhsiqlBu2cg7qggh0itodtXdQ7rf3h6irszhRgc9Sfbh9ietWUVjI6cfch7iirtROjE5qf5hzizpCZvhF+Bgchti0li
					nheO+jgjhuivlYuNcz7+gMhui4lrpSd4+Afrh2itq1cdhP93fhh8igsvTDi+6Kfxh8imtLUfh06tgTh4itrmgBfS9zgohwismmr2dT82gdhuiylWtqc58Qf2
					hwi3mdkLfI/CffhwiymXYyhg+ef0hwi3meb/g1/DgAhwi4migAgA/U]],
				Tail5 = [[
					gAhkjUkbgAgA/rgdhkjRkUhPf1/rhJhhi6jIvidb7rg1hji9myw6ds6Mf6hjjAr5lRgk9OfLhmiqtAVEjB68fHhmisqxOhil4ZfuhjjLnVVbhF9RgphijNji
					ljfF/Sg6hijAjYwCdg7XgdhjjQjdtcd38vfmhjjEprfqhB+efPhmirsOSfit6JfghmiysUQ6hZ5VgShjjEqdcAfV99g8hijAk3rOeH9ggzhijEjQwedZ7Gf+
					hkjTkPohe0+hfShkjLkWaQgz/KfthkjTkYbfgo/XgAhkjUkbgAgA/r]],
				["UpperLegB.L"] = [[
					fGh0g+3oZkgA0kfGhyhA4KZifgz7fHhqhE5sYneXxffHiAhB44Zcemy9fGiTg943ZFepy3fGiag64lYwfHzHfGiTg54GYpf2ztfGiAg53tYngf0KfGhqg84r
					XxgSynfGhug94ZYZgIzPfGhtg/45YgfeyofGiJg+4tZQe2zJfHiXg+5IZKeLyffHiYg+5JZIeJycfGiNg+4wZMexzCfGh0g+4qYufhzCfGhtg94jYQgEy/fG
					hzg63CZFg51EfGh0g73KZOgs0/fGh0g93iZfgJ0qfGh0g+3oZkgA0k]],
				["LowerLegB.L"] = [[
					e4g+g0xfeQgA6ue3g+gzxHe0f57Ae0g7gtuLgZgP8re1hNgwvtf6fv73e0hhgstqgPf687e1hngqsagAgL9fe2hggrszfQge9Te3hLgtuKeagu8oe2g4gqr+
					e8hB9oe2g6gtt+eygv8ve1g7gtuGfXgh8te1hWguuyf2f58Xe0hmgstdgsfv9Be0hngstSgvfv9Fe1haguuZf/f58ke2hBguugfRga8ge2g6gstfe6gy8+e4
					g+gzwtdjgm7Ke4g+gzw+dtgc7Ae4g+g0xYeJgG6ye4g+g0xfeQgA6u]],
				["FootB.L"] = [[
					e1gihB/UgAgAmje1gihB/TgZf7mje1gihB/Qhxfomie1gyhB+5hNfsoMe1hIhB+UhhfgqEe1hRhB+Hhafgqse1hIhB+Wg6ftqFe1gyhB+6gXf6oNe1gihB/T
					g6f0mje1gihB/Tgtf3mje1gihB/ShFfymje1g8hB+phNfppGe1hOhB+Kh2fXqde1hPhB+Hh5fWqle1hBhB+hhVfmpee1gnhB/Lg8fynIe1gihB/Tg0f1mje1
					gihB/UfugEmje1gihB/UfxgDmje1gihB/Uf9gBmje1gihB/UgAgAmj]],
				["UpperLegB.R"] = [[
					g6h0g+3omcgA0kg6hyg83rm3fv0Yg6hqg84roOfuyog6iAg53tnZfh0Kg6iTg54GnXgKztg6iag64lnQg5zHg6iTg943m7hXy3g5iAhB44mkhay9g5hqhE5s
					nahpxeg6huhB5DnFhDyjg6htg/45nggiyog6iJg539nPf+z7g6iYg335njf3z4g6iZg336nkf4z2g6iNg54AnSgCz2g6h0g+4qnSgfzCg6hthC5NnPhHyTg5
					hzhC4OmAg60Ag6h0hB4DmGgr0Mg6h0g+3umYgJ0fg6h0g+3omcgA0k]],
				["LowerLegB.R"] = [[
					hIg+g0xfhwgA6uhJg9gywbhzfp7YhKg4gqr/hFe/9nhJhLgtuKhmfS8ohKhggrszgwfi9ThLhngqsagAf19fhMhhgstqfxgG87hLhNgwvtgGgR73hMg7gtuK
					fnfx8shLg8gvvKgVf18KhLg7gtuGgpff8thKhVgtt6hHfh8yhKhkgqsEg5fY9mhKhlgqr6g2fZ9rhKhZgsthg/fh8+hKhBguuggvfm8ghLg7guuvgMfx8ZhJ
					g/g1yMhBgl6ShJg/g1yFhOgc6WhIg/g0xnhpgG6qhIg+g0xfhwgA6u]],
				["FootB.R"] = [[
					hLgihB/UgAgAmjhLgihB/Uf5gCmjhLgihB/TfGgMmjhLgyhB+6fpgGoNhLhIhB+WfGgTqFhLhRhB+HemggqshLhIhB+UefggqEhLgyhB+5ezgUoMhLgihB/Q
					ePgYmihLgihB/Se1gQmjhLgihB/Se7gOmjhLg8hB+qfXgMpGhLhOhB+NfLgSqehLhPhB+KfJgTqmhLhBhB+jfRgPpehLgnhB/LfEgOnIhLgihB/SesgSmjhL
					gihB/UfsgEmjhLgihB/UfygDmjhLgihB/Uf9gBmjhLgihB/UgAgAmj]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 25,
			bones = {
				Hips = [[
					gAiag5AQgAgAj6gAiahDAYgAgAkzgAiahMAggAgAlkgAiahLAfgAgAldgAiahIAcgAgAlLgAiahEAaf5e3k1gAiahAAYf2ebkjgAiag/AVf6fKkagAiag+AU
					gAgAkWgAibg8ASf1gKkKgAiig6AXdcgUj9gAitg5BDY8g4j0gAi1g5CxTnhijmgAi1g5FOO9iGjTgAiyg5HWMBidjCgAixg5ICLMiki9gAiyg5HbL6iejCgA
					iyg5G5MliZjGgAiyg5HXL/iejCgAixg5IBLNiki9gAixg5IDLLiki9gAixg5IDLLiki9gAixg5IDLLiki9gAixg5IDLLiki9gAixg5IDLLiki9]],
				Spine1 = [[
					gAihgcAQgAgAj6gAijgnAYgAgAkzgAikgwAggAgAlkgAikgvAfgAgAldgAikgrAcgAgAlLgCijgnAaf5e3k1gDiigkAYf2ebkjgCiigiAVf6fKkagAiighAU
					gAgAkWgAiigfASf1gKkKf/ipgdAXdcgOj9f9i0gcBEY6gnj4f7i6gcCzTkhGjyf5i4gcFRO5hjjqf5izgcHaL8h2jif5iygcIHLHh8jgf5izgcHfL2h3jif5
					i0gcG9Mhhyjkf5izgcHbL7h2jif5iygcIGLIh8jgf5iygcIILHh8jgf5iygcIILHh8jgf5iygcIILHh8jgf5iygcIILHh8jgf5iygcIILHh8jg]],
				Spine2 = [[
					gAipf//4gAgAipgAisgK/8gAgAhwgAiugU/+gAgAg+gAiugT/+gAgAhFgAitgP/9gAgAhXgEisgL/7f4hJhtgGirgH/5f2hlh/gDiqgF/6f7g2iIgAiqgF/6
					gAgAiNf/iqgC/5gNf5iZf+iwgA/yijgaikf6i6f//FnDhGidf2jAf/9XsXh5iEfzi8f/67xBiihhfyi2f/40z8i5hDfyi0f/4I0xi/g5fyi2f/4v0Di6hCfy
					i3f/5RzYi1hJfyi2f/4zz+i5hDfyi0f/4J0wi/g6fyi0f/4H0yi/g5fyi0f/4H0yi/g5fyi0f/4H0yi/g5fyi0f/4H0yi/g5fyi0f/4H0yi/g5]],
				Spine3 = [[
					gAikfi/4gAgAipgAipft/8gAgAhwgAitf3/+gAgAg+gAisf1/+gAgAhFgAirfy/9gAgAhXgGipfu/7f4hJhtgJinfq/5f2hlh/gFimfo/6f7g2iIgAimfo/6
					gAgAiNf/imfl/5gNf5iZf/isfj/yijggijf9i2fi/FnBhWiZf7i9fi9XsViUh4f5i8fi67w9jGhKf3i4fi40z3jggjf3i2fi4I0sjngWf3i4fi4vz+jhghf4
					i5fi5RzTjcgrf3i4fi4zz5jhgjf3i3fi4J0qjngWf3i2fi4I0sjngWf3i2fi4I0sjngWf3i2fi4I0sjngWf3i2fi4I0sjngWf3i2fi4I0sjngW]],
				Neck1 = [[
					gAiffFAXgAgAkpgAilfQAqgAgAmagAirfaBBgAgAn7gAiqfYA9gAgAntgAiofVA1gAgAnKgIimfRAtf1e4mfgLikfNAnfxecl6gGijfLAif4fKlpgAiifKAg
					gAgAlhf/ihfIAcf1gKlJgAinfGAedcgQkqgAizfFBIY7gpkXgAi8fFC1TlhEkGf/i9fGFSO6hZj2f9i7fGHZL+hnjrf8i6fGIFLJhqjnf9i7fGHeL4hnjqf9
					i8fGG8Mihkjtf9i7fGHaL9hnjrf9i6fGIELKhqjof8i6fGIGLJhqjnf8i6fGIGLJhqjnf8i6fGIGLJhqjnf8i6fGIGLJhqjnf8i6fGIGLJhqjn]],
				Neck2 = [[
					gAiteVA4gAgAnWgAi5eiBmgAgAp7gAjDetCagAgAsIgAjCesCRgAgArzgAi+enB+gAgArCgMi6ejBqfte5qDgQi2efBafneepNgJi0ecBRfzfLo0gAizebBN
					gAgAopf+ixeYBDf2gMoEf+i1eWA+dggnnUf8jAeVBiZGhmmpf4jGeVDHT3ipl4f1jFeVFbPSjalBfyjBeVHaMZj1kYfxi/eVIFLkj7kLfyjBeVHgMSj1kWfy
					jCeVG/M8jwkgfyjBeVHcMXj1kXfxi/eVIELlj7kLfxi/eVIFLjj7kLfxi/eVIFLjj7kLfxi/eVIFLjj7kLfxi/eVIFLjj7kLfxi/eVIFLjj7kL]],
				Neck3 = [[
					gAi8d4A4gAgAnWgAjMeIB5gAgAqxgAjaeWDFgAgAtqgAjYeUC4gAgAtPgAjTePCcgAgAsOgOjNeJB+fre6q8gTjIeEBnfleep1gKjFeBBafyfMpTgAjEeABV
					gAgApEf+jBd8BHf3gNoTf8jEd5A9digxnRf2jMd3BdZMh9mTfvjPd3C+UCjKlKfqjKd3FLPgj9j5fnjDd3HGMokUi9fmjBd3HuL0kZirfnjDd3HLMikVi7fn
					jEd3GsNMkQjJfnjDd3HHMnkUi9fmjBd3HtL2kZisfmjBd3HvL0kZirfmjBd3HvL0kZirfmjBd3HvL0kZirfmjBd3HvL0kZirfmjBd3HvL0kZir]],
				Head = [[
					gAjPdS/sgAgAkagAjndm//gAgAfXgAj7d7/lgAgAa9gAj4d4/sgBgAbngAjxdw/3gAgAdLgQjpdo/7ehgsfEgWjhdh/5d3hDgqgMjddd/7e1gmhhgAjbdb/7
					gAgAh6f9jXdX/2gZf4jBf4jWdS/jinf8kiftjbdQ+qnHgElvfijYdP8tsVgim4fbjNdO6EwuhXn6fZjCdO32zaiHojfYi/dO3J0JiYoufZjCdO3xzgiKokfZ
					jEdO4Uy5h9obfZjCdO31zbiIojfYi/dO3K0IiYoufYi/dO3I0KiYoufYi/dO3I0KiYoufYi/dO3I0KiYoufYi/dO3I0KiYoufYi/dO3I0KiYou]],
				Jaw = [[
					gAiidD/6gAgAiJgAjBdK//gAgAfxgAjedW/6gAgAdsgAjZdU/7gBgAeAgAjPdP/9gAgAevgOjDdL/8eggqfmgTi5dJ/5d4hFgVgKizdH/9e2gngxgAixdG/+
					gAgAg+f+irdF/8gZf3hjf/iqdE/vinf0i9gAixdF+znHf3k6gCi3dH8psUgonFgFi3dJ5uwqiBo8gGi1dL3SzPjUqBgGi0dL2fz8jwqTgGi1dL3LzVjYqDgG
					i1dK3yywjCp0gGi1dL3QzQjVqBgGi0dL2gz7jwqSgHi0dL2ez9jxqTgHi0dL2ez9jxqTgHi0dL2ez9jxqTgHi0dL2ez9jxqTgHi0dL2ez9jxqT]],
				["Lid.L"] = [[
					fSj/cwF0OugAmLfSkgdVHHO7dSqOfSk2d6IwPea9tkfSkzd0IfPXbTtFfSksdnH4PKcHr6fokldWGgP8cIp+fykddJFuQPcgodfjkWdDF7PidooHfSkQdBGY
					OxepoOfOkJc6GUOdfdnafDj+cxHRMwg7mRetjvcuKBJki6lUefjTctOCGTk4j9efixctSeDwmdgseliXctWhCmm2bVeoiQctY2DFmWWQeliXctZIEKmHTOej
					icctYtElmNSneliXctZYEgmBSWeoiQctaSEalvSAeoiQctaVEZluSAeoiQctaVEZluSAeoiQctaVEZluSAeoiQctaVEZluSAeoiQctaVEZluSA]],
				["Lid.R"] = [[
					guj/cwF0xSgAmLgukgdVHHxFiuqOguk2d6IwwilDtkgukzd0IfwokutFguksdnH4w2j5r6hEkddaH/x/h5q7hNkRdPH3yfgjp6g/kPdGHFx8gwo7gukQdBGY
					xPhXoOgqkLc5F6xAg+nOgdkNcvEevNgxl0gAkWcnCZrPhVkUfgkTchAxmDhyitfIkBccAChCgRgle8jucYAZdhcAene6jocXBlciXLdUe8jtcYCsdhUBcRe+
					jycZC/eXTTb2e8jucYDGdqTJb/e6jocXDRcsS6cMe6jocXDRcqS5cNe6jocXDRcqS5cNe6jocXDRcqS5cNe6jocXDRcqS5cNe6jocXDRcqS5cN]],
				["UpperLegF.L"] = [[
					fGh0fFz2amgA4gfGh6fN1Mamft3WfGiAfV2Taofc2SfGh/fU2Jaofe2dfGh9fR1vanfk21fPh7fK1PZugZ3FfSh4fG0zZZgx3YfMh3fH0nZ8gX3tfGh3fJ0h
					amf238fGh1fI0Pazf/4OfOhzfFz5b9iQ4offhzfCzfeQmV4gf3h0fAyvg2rQ3WgOh3e+xwi/vn1Wgch6e9w+kRyXzfgfh8e9wukozJy3gch6e9w8kUydzagZ
					h5e9xIkCx1z4gch6e9w+kSyZzegfh8e9wukozIy4gfh8e9wukozJy3gfh8e9wukozJy3gfh8e9wukozJy3gfh8e9wukozJy3gfh8e9wukozJy3]],
				["LowerLegF.L"] = [[
					e4g+fP7RdRgAwfe4hEfR8KdSf2u8e4hKfT82dSfutje4hJfT8wdTfvtwe4hHfS8gdSfyuQfAhFfM8Lcsg0uwfDhDfK74cehPvOe+hCfM7xc2gpvie4hBfQ7u
					dSf7vue4hAfQ7idgf9wGfIg8fQ7SfUhnwnfog9fQ6vi3klwtgQhGfS5hnAoNv/gzhTfT3zqkreunhHhffT2WsytktShMhjfU13tauKs1hHhffU2Ss3tptPhD
					hcfT2psXtKtkhHhffT2VsztltRhMhjfU14tZuJs2hMhjfU13tbuLs1hMhjfU13tbuLs1hMhjfU13tbuLs1hMhjfU13tbuLs1hMhjfU13tbuLs1]],
				["FootF.L"] = [[
					e1gie//UgAgAmje1gpe//ogAgAkze1gxe+/0gAgAjPe1gwe+/zgAgAjee1gte+/vgAgAkCe+gqe6/nfxhIktfCgne4/gfrhjlSe7gme7/ff1g1lje1gle//e
					gAgAlre1gjfA/agNf7mFfKgffB/Kidg1mxfzghfD+VmuibnNglgvfG8irtkhnLhOhEfI6Hv9mgmqhlhXfK4Fymn0mChrhdfK3bzVoNlzhmhYfK4Aysn3mAhh
					hTfJ4hyGnkmLhlhXfK4Eynn1mBhrhdfK3czUoMlzhrhdfK3bzWoNlzhrhdfK3bzWoNlzhrhdfK3bzWoNlzhrhdfK3bzWoNlzhrhdfK3bzWoNlz]],
				["UpperLegF.R"] = [[
					g6h0fFz2lagA4gg6h6fN1MlagT3Wg6iAfV2TlYgk2Sg6h/fU2JlZgh2cg6h9fR1vlZgc21hCh6fS1PkhhC3ehFh4fR0zkMhN36hAh3fN0nkxgt3/g6h3fJ0h
					lagK38g5h3fH0LlogK4LhAiFfHzKmwiI4ohHilfIxdo5l54mhHjHfKvMrEqi3pg+jffNs3spuu18gzjqfOrNtdxa0WgvjtfPqttqyLzzgzjqfOrJtexg0Rg2
					jofOritUw50sgzjqfOrMtdxb0VgwjtfPqutpyKzzgvjtfPqttqyMzygvjtfPqttqyMzygvjtfPqttqyMzygvjtfPqttqyMzygvjtfPqttqyMzy]],
				["LowerLegF.R"] = [[
					hIg+fP7RivgAwfhIhEfR8KiugKu8hIhKfT82iugStjhIhJfT8wiugRtwhIhHfS8giugOuQhQhEfX8LiIhJu9hThCfY74h6hdvfhOhCfU7xiSg0vrhIhBfQ7u
					iugFvuhIhBfP7gi9gCwEhXhUfS66kwhlwkhqh8fW5toOkawnh1itfc3ssKn4v4hxjUfh1RvcrAuihmjrflzXxatBtRhijxfmywx9tls1hmjsflzSxftFtOhp
					jnfkzwxCsotjhmjrflzWxbtCtQhijxfmyxx9tks2hijxfmyvx+tms1hijxfmyvx+tms1hijxfmyvx+tms1hijxfmyvx+tms1hijxfmyvx+tms1]],
				["FootF.R"] = [[
					hLgie//UgAgAmjhLgpe//ogAgAkzhLgxe+/0gAgAjPhLgwe+/zgAgAjehLgte+/vgAgAkChUgpfE/nfxhIkthXgnfH/gfrhjlShSgmfD/ff1g1ljhLgle//e
					gAgAlrhMgle//agNf7mFhfg3fD/Lidg1mph6hjfI+amwiXm6iOibfP8qrykUmriPjLfW6RwHmGmAiGjpfa4Qy0nQlUiBjxfb3mzlnmlEiFjqfa4Ly6nTlSiI
					jjfZ4ryTnCldiFjpfa4Py2nRlTiBjxfb3nzknllEiBjxfb3lzlnmlEiBjxfb3lzlnmlEiBjxfb3lzlnmlEiBjxfb3lzlnmlEiBjxfb3lzlnmlE]],
				Tail1 = [[
					gAiQhijsgAgA/xgAiOhsklgAgA/qgAiMh0lWgAgA/igAiMhzlPgBgA/jgAiNhwk9gAgA/mf9iOhskneGgL/mf8iPhpkUdYgQ/lf+iPhnkMemgJ/rgAiPhnkI
					gAgA/ugAiQhlj8gRgK/vgCiYhijwgbij/qgEikhijnhLnB++gHiuhijTiFsV9RgJixhii1i2w961gJiwhiiajUz44vgKivhiiRjc0s4CgJiwhiiZjVz+4pgJ
					iwhiigjOzU5LgJiwhiiajUz54tgKivhiiRjc0r4DgKivhiiRjc0t4CgKivhiiRjc0t4CgKivhiiRjc0t4CgKivhiiRjc0t4CgKivhiiRjc0t4C]],
				Tail2 = [[
					gAiJiAmCgAgA/agAiFiJm6gAgA/PgAiCiRnrgAgA/DgAiDiQnjgBgA/FgAiEiNnSgAgA/Jf5iFiJm7dXgb/Hf3iHiGmocXgo/Ff7iHiFmheEgW/QgAiHiFme
					gAgA/VgBiJiDmSgYgI/XgDiRiBmHgvif/SgIieiAl5iDm2+ngNiqiAlXjnsA88gQiviAkhk8wg6kgRiwiAjxlvzW4igRiwiAjhl90J33gRiwiAjvlxzc4dgR
					iwiAj7llyz49gRiwiAjxlvzX4hgRiwiAjil90I34gRiwiAjhl90K33gRiwiAjhl90K33gRiwiAjhl90K33gRiwiAjhl90K33gRiwiAjhl90K33]],
				Tail3 = [[
					gAh+icnWgAgA/IgAh4iloOgAgA+6gAh0iso+gAgA+tgAh0iro3gBgA+vgAh2ipomgAgA+0f1h4iloNcpgs+ufwh6ihn5bYhA+pf4h7ihn0dhgj+6gAh7ihny
					gAgA/CgCh9ifnmgfgF/EgFiFidncg+ib/AgOiUicnMismr+VgXijicmekurr8sgditiclWmdwD6YgeixickVnfyz4ZgeiyickAnxzk3wgeixickTniy54Uge
					iwickjnTyR40geixickVngy04YgeiyickBnxzj3wgeiyickAnyzl3vgeiyickAnyzl3vgeiyickAnyzl3vgeiyickAnyzl3vgeiyickAnyzl3v]],
				Tail4 = [[
					gAhwi4migAgA/UgAhpjAnagAgA/HgAhjjGoKgAgA+7gAhkjFoDgCgA+9gAhmjDnygAgA/Cfvhpi/nYb4gv+2fohri7nDaVhE+qfzhsi8m/c9gl/EgAhti8m+
					gAgA/OgDhvi6myglgF/QgIh4i4mphCib/LgWiIi4mZi3mq+fgkibi3lnlCrq81gsiqi2kWm3v/6fguizi2jOn8ys4ggui2i2i2oPzd32gui0i2jLn/yz4bgu
					iyi2jenvyL47guizi2jOn9yu4fgui2i2i3oOzc33gui2i2i2oPze31gui2i2i2oPze31gui2i2i2oPze31gui2i2i2oPze31gui2i2i2oPze31]],
				Tail5 = [[
					gAhkjUkbgAgA/rgAhbjblTgAgA/jgAhUjhmEgAgA/agAhVjgl9gCgA/bgAhYjelsgAgA/efohbjZlSbGgi/KfehejVk8ZPgz+3fuhfjXk5cXgd/ZgAhgjYk3
					gAgA/ngEhijWkrgrgG/pgLhrjVkkg/ie/jgeh+jTkWixmy+1gxiVjSjjk3r29Gg7iqjRiRmnwO6rg9i4jQhHnoy84mg9i7jQgun5zt37g9i4jQhEnqzC4hg9
					i1jRhXncyb5Cg9i4jQhGnpy94lg9i7jQgvn5zs38g9i8jQgun5zt36g9i8jQgun5zt36g9i8jQgun5zt36g9i8jQgun5zt36g9i8jQgun5zt36]],
				["UpperLegB.L"] = [[
					fGh0g+3oZkgA0kfGhzhG4vZkfpzOfGhzhN5qZmfVx/fGhzhM5hZmfYyLfGhzhJ5NZlffynfGh0hC4yY1gey6fGh0g+4aYjg6zQfGhzg/4RZBgbzpfGhzhC4M
					Zkf1z6fHhzhA4BZyf60MfNhyg+4gbhhf0Afdhxg+5bfNkAy+fzhxg+52j/mrxLgKhwg+5XokouvLgahxg+4jrsp2trgehyg+4OsnqJtNgahxg+4grzp5tngX
					hxg+4vrFppt/gahxg+4irup3tqgehyg+4PsmqJtOgehyg+4OsoqJtNgehyg+4OsoqJtNgehyg+4OsoqJtNgehyg+4OsoqJtNgehyg+4OsoqJtN]],
				["LowerLegB.L"] = [[
					e4g+g0xfeQgA6ue4hAg2y9eQf65te4hBg40MeRf04we4hBg40AeRf145e4hAg3zleQf35Pe4hAgxzBdTgi5le5hAgvyic8gz54e4g/gyyVdjga6Ge4g/g1yO
					eQf96Oe5g+g1x8eegD6cfHg8gyx/fsiH6Xfmg8gvySiYlw5fgOhDgryNl0p73qgxhOgnxgpFta1UhGhZglwsrSvhzbhLhdgkwYr7wGyzhGhaglwprXvlzWhC
					hXglw4q2vHz0hGhZglwrrTvizZhLhdgkwZr6wFy0hLhdgkwYr8wGyzhLhdgkwYr8wGyzhLhdgkwYr8wGyzhLhdgkwYr8wGyzhLhdgkwYr8wGyz]],
				["FootB.L"] = [[
					e1gihB/UgAgAmje1gihA/ogAgAkze1gig//0gAgAjPe1gig//zgAgAjee1gig//vgAgAkCe1gig6/nfxhIkte1gig4/gfrhjlSe1gig8/ff1g1lje1ghhA/e
					gAgAlre2ghhB/agOf6mCfJgfg+/TiiggmDfwggg5+unAhPlYghgsg09IsWh1kVhLg/gv6yxDiHjUhjhQgr4t0BiJiphphWgq4C03iIidhkhRgr4o0IiJiohf
					hMgs5JzdiJiyhjhQgr4s0DiJiphphWgq4D02iIidhphWgq4B04iIidhphWgq4B04iIidhphWgq4B04iIidhphWgq4B04iIidhphWgq4B04iIid]],
				["UpperLegB.R"] = [[
					g6h0g+3omcgA0kg6hzhG4vmcgXzOg6hzhN5qmagrx/g6hzhM5hmbgoyLg6hzhJ5Nmbghyng5hzhK4ylshOzYg5hzhJ4alahbz5g6hzhF4Rl5g1z+g6hzhC4M
					mcgLz6g6h1g/37mrgI0Jg/iFg+3XoWhv0HhFikg+2SrsknzNhEjEg+0Yvon0xag7jZg+x7zBqYvQgyjig+v51Ir2tjgujlg+vP1usPtBgxjjg+v01Nr6tfg0
					jhg+wU0urlt6gyjig+v41Jr3tigujkg+vQ1tsPtCgujlg+vP1usQtBgujlg+vP1usQtBgujlg+vP1usQtBgujlg+vP1usQtBgujlg+vP1usQtB]],
				["LowerLegB.R"] = [[
					hIg+g0xfhwgA6uhIhAg2y9hwgG5thIhBg40MhvgM4whIhBg40AhwgL45hIhAg3zlhwgJ5PhJg/g8zBgygv5thJg/g9yigbg86DhJg/g5yVhDgh6MhIg/g1yO
					hwgD6OhJhAg0x6h+gH6bhWhTgzxnjLiK6bhph7gwxQlvl55phziqguwbo3qN35hvjRgrvGrst31mhljmgpt6thwHzshhjsgptguCwvzEhljngpt3tlwMznho
					jigquKtKvs0Fhljmgpt5tiwIzrhijsgpthuCwuzFhhjsgptguDwvzEhhjsgptguDwvzEhhjsgptguDwvzEhhjsgptguDwvzEhhjsgptguDwvzE]],
				["FootB.R"] = [[
					hLgihB/UgAgAmjhLgihA/ogAgAkzhLgig//0gAgAjPhLgig//zgAgAjehLgig//vgAgAkChLghhF/nfxhIkthKghhH/gfrhjlShLghhE/ff1g1ljhLghhA/e
					gAgAlrhNgjhA/agOf6mCheg3g//SiiggmKh4hhg8+qm/hTlsiKiYg49DsUiDk2iMjGg06sw/iij/iEjjgy4oz9ivjYiAjqgx380yiyjNiDjkgy4i0EiwjXiG
					jdgy5EzYitjgiEjjgy4mz+ivjYiAjqgx390xiyjNiAjrgx370ziyjNiAjrgx370ziyjNiAjrgx370ziyjNiAjrgx370ziyjNiAjrgx370ziyjN]],
			},
		},
	},
}
