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
					gAhXgAACgAgAg6gAhZgAACgAgIg6gAhagAACgAgRg6gAhbgAACgBgYg6gAhcgAACgBgfg6gAhcgAACgBgmg6gAhcgAACgBgrg6gAhbgAACgBgwg6gAhagAAC
					gBgzg6gAhZgAADgCg1g6gAhXgAADgCg2g6gAhWgAAPgHjog6gAhUgAB/gUrCg3gAhTgAHGgl0DgugAhTgAOzgx69gfgAhSgAVng3+PgTgAhTgAYNg5/AgOgA
					hTgAYGg3+/gPgAhYgAX/gM+9gagAhZgAX3gM+7gbgAhYgAXvgr+5gTgAhZgAXmg2+2gQgAhegAXfgM+1gcgAhfgAXXgM+zgcgAhdgAXQgr+wgUgAhcgAXKg4
					+ugQgAhcgAXFg4+tgQgAhbgAWJg4+bgSgAhagARSg08YgbgAhZgAKKgr3WgogAhXgAD9gcvWgzgAhWgAAwgMmxg5gAhUgAACgBgzg6gAhTgAACf/fQg6gAhT
					gAACf/fVg6gAhSgAACf/fag6gAhTgAACf/fhg6gAhTgAACf/fog6gAhUgAACgAfvg6gAhWgAACgAf4g6]],
				Spine2 = [[
					gAhZflACgAgEgxgAhaflACgAgNgxgAhcflACgAgVgwf/hdflACgBgdgwf/hdflACgBgkgwf/heflACgBgqgxf/hdflACgBgvgyf/hdflACgBgzgyf/hcflAC
					gBg2gzf/haflACgBg3g1f/hZflACgBg3g2f6hXfmAPgGjpg3fvhWfsCAgUrCg2fmhVf6HGgl0DgufohUgLOzgz69ggfwhUgVVmg6+PgUfzhUgXYLg9/AgQfz
					hVgXYDg9++gRfzhYgXX8gT+9gcfzhagXX0gU+6gdfzhagXXrg0+4gVfyhagXXihA+1gTfyhegXXbgW+0gffyhfgXXTgW+ygffyhegXXMg1+vgXfyhegXXGhB
					+tgTfyhdgWXBhB+rgTfwhdgWWGg/+ZgVfqhcgPRPg68XgeflhagCKIgv3UgsfqhZfyD8gevUg3f1hXfoAwgNmwg8f/hWflACgBgyg8gBhVflACf/fQg6gBhU
					flACf/fVg5gBhUflACf/fcg3gBhUflACf/fjg2gBhVflACf/fqg0gAhWflACgAfzgzgAhXflACgAf7gy]],
				Spine3 = [[
					gAhafLADgAgHhQf/hcfLADgBgPhPf/hdfLADgBgXhPf/hefLADgBgfhQf+hffLADgCgmhRf+hffLADgCgshSf+hffLADgCgxhTf9hefLADgCg0hVf9hdfLAE
					gCg2hXf9hcfLAEgCg3hZf9hafLAEgCg3hcf0hZfMAQgLjohefdhXfXCBghrBhbfMhWf1HGg+0BhOfQhWgWOyhW66g3ffhWgqVkhi+MgifnhWgvYJhn+9gafm
					hXgvYBhn+7gbfmhZgvX6g++7gnfmhaguXyg/+5goflhbguXphe+1ghflhcguXghq+ygeflhfguXZg/+ygqfkhgguXSg/+wgrfkhggtXLhd+tgifkhggtXFhp
					+rgefjhfgtXAhn+pgefhhfgrWGhk+XghfUhdgfRQhc8VgwfLhcgDKJhK3ThFfThafjD+gvvUhXfqhZfPAygUmxhef9hXfLAEgCg0hegChWfLAEf+fShbgChW
					fLADf+fXhZgChVfLADf/fehXgChWfLADf/flhVgBhWfLADf/fthTgBhXfLADgAf1hRgAhZfLADgAf+hQ]],
				Spine4 = [[
					gAhcewADgAgIhUf/heewADgBgQhUf+hfewADgBgYhUf+hgewADgBgghVf9hhewADgCgmhWf9hhewADgCgshYf8hhewAEgCgwhaf8hgewAEgCg0hcf8hfewAE
					gDg2hff8heewAEgDg3hif8hdewAEgDg2hlfuhbeyARgMjnhnfMhafDCBglq/hkeyhZfvHGhEz/hVe4hYgiOxhe65g8fPhYg/Vjhs+LglfahZhGYIhx+8gdfa
					hZhGYAhw+7gefZhbhGX5hH+6gqfYhchGXxhI+4grfYhehFXohn+0gjfXhfhFXfhy+yghfXhhhFXZhH+ygtfWhihEXShH+wgtfWhihEXLhk+sgkfVhihDXFhv
					+qggfVhihDXAht+pggfRhhhBWGhq+Xgje/hgguRQhh8VgyewhfgFKKhN3UhJe9hdfVD+gyvVhbffhbe3AygVmyhif8haewAEgDg1hhgEhZewAEf+fThfgDhY
					ewADf+fZhcgDhYewADf/ffhagChYewADf/fnhYgChYewADf/fuhWgBhZewADgAf3hVgAhbewADgAf/hU]],
				Head = [[
					gAheeWgAABgSgIf/hgeWgAABgSgnf+hheWgAACgShEf9hieWgAADgRhgf8hjeWgAAFgQh6f8hjeWgAAGgMiRf7hjeWgBAIfVikf7hjeWgFANd/izf6hieWgH
					ARdVi9f6hheWgHASdSjDf6hfeWgIASdPjEfoheeYf3ApdMloe7hdevfKCrdRsceYhcfpeQHzds0tefhbgtdjPNeY7Ee+hbhUdMVrfB+IfNhchedFYJfR+3fN
					hchddKYBfQ+1fMhdhdfHX4fa+7fLhehdfHXwfZ+5fKhghcdpXpfQ+xfKhihbdIXhfM+sfJhjhbfHXYfX+yfIhkhbfIXRfX+wfIhlhadsXMfO+pfHhlhadHXG
					fK+lfHhlhadJXCfK+kfBhkhWdNWFfG+Rephjg9dbRBes8HeWhhgHd4JqeG2temhgfHejDcdmuHfUheeffRAidWlAf7hceWfwAKdTeygFhbeWf7AMd8dVgEha
					eWf+AHfTdlgEhaeWgAAFgKd6gDhaeWgAAEgOeTgChbeWgAADgQeugBhceWgAACgRfLgAhdeWgAABgSfp]],
				Jaw = [[
					f/hUeB/9gAf4hkf+hWeB/8gBfZhkf8hXeB/7gDe8hkf7hYeB/6gEeghjf6hZeB/5gEeGhhf5hZeB/4gFdvhef4haeB/4gIdcgmf3hceA/3gMdOfQf3hbeA/0
					gOdEemf2haeA/0gPc+ejf2hZeA/zgPc8egfhhYeE/dgGaYeceshXeg9bfqTjeceChWfm4SfFLQeqeMhVg2w3eoE4fDexhVhlqXeZByfbfDhWhxn4eUBDflfC
					hWhwoAeZBFfkfBhUhvoJgWBFfvfBhWhvoRgVBHfue/hahvoZe3BKfle+hchuoheXBOfie+hahtopgVBNfte9hchtowgWBPfte8hehto2e6BSfle7hghso7eW
					BVfhe7hfhspAeYBXfhe0hehop9ebBpffeXhdhJvBejD0fSeAhbgH2aeyJPfAeVhae58pfHR2evfNhYeK/jfea/emf8hWeA/7fthNekgIhUeA/3f0irfOgHhR
					eB/5f4iagkgGhQeB/5f7iGhcgFhQeB/6f8hthggEhQeB/7f9hShhgChReB/8f+g1hjgBhTeB/8f/gXhk]],
				["Cheek.L"] = [[
					fWhddhfzJegN2tfUhfdifzJ0gN3CfRhgdjfzKKgN3XfPhidkf0KegM3qfNhidmf1KygL37fMhjdnf3LDgI4KfLhldqggLRfi4WfKhoduhfLfeo4dfKhodxh+
					LpeM4ifJhndxiALueK4lfJhmdxiDLveI4meyhld8h5Nzd76Kd+hkethVUDde9idlhkgLgadhdI/weJhjhlfanQdI/BfDhkiQetuAdU8nfchkiZeewRda7Yfb
					hliYehwKdd7cfahfiXfzwIe97nfZhgiXfzwAe87rfXhniXe3v2dz7rfWhriXejvtdZ7tfVhliWf0vre773fUhmiWf1vke777fThsiWe7vcd076fRhuiWejvV
					dX76fRhtiWelvRdZ79fIhtiSeruZdZ8aeahrh4fHpSdQ+edphqgwf2gQdK/3dqhofMgrVydS+LefhneBhXNSdm5yfVhldmhvIod61qfkhidghZHnef0mfkhd
					ddgfHwff02fihZdcf5H9gI1GfghZdcf2INgK1Yfehaddf1IggL1sfbhbdef0IzgM2BfZhcdffzJIgN2X]],
				["Cheek.R"] = [[
					gohddgfz2tfz2igmhfdffz3Cfz2Mgjhgdefz3Xfz12ghhhddf03qf01igfhidcf137f11Ogdhjdbf44Kf309gbhmddge4Wgg0vgbhpdghY4dhf0hgahqdih0
					4ih+0Xgahpdih24liA0Sgahodih44miD0Rf/hndgiF6Kh5yNe3hmdyii9ihVr9dyhle6i4/wgaifdlhkgci4/BfaYweChkheis8netSAeUhkhxim7YeePveT
					hlhxij7cehP2eThhhvhD7nfzP4eShihuhE7rfzQAeRhohuiN7re3QKePhrhtin7tejQTePhnhrhF73f0QVeOhohrhF77f1QceNhshqiM76e7QkeMhuhqip76
					ejQreMhthpin79elQveGhthiin8aerRndthrg0iw+efHWudohpffi2/3f2fwebhneLiu+LgrqOfthldnia5yhXyugnhjdsiG1qhv3Yg1hhduhh0mhZ4Zg0hc
					dqgh02gf4QgzhZdmf41Gf54DgxhZdlf21Yf23zgvhadkf11sf13ggthbdjf02Bf03Ngrhcdhfz2Xfz24]],
				["FinF1.L"] = [[
					eqhQe3pTIPe0zQephSe3oVH7eKzRephTe4nWHmdyzNeohUe5mcHRdtzGeohVe5lsG/d7y/enhVe6lMGweay4enhVe6k/GmfHyxenhUe7lHGgf7yoemhTe7lj
					GhgyyfemhSe7mSGnhnyWemhRe7nOG1iUyNechPfMogI1iH0PePhOgAp2OrgA5BemhNhEqHYBcV9DfhhMhtopiKYl90gWhMhvmZpfWL8NgphMhqk7sNVW7Igo
					hNhqkJscVT7JgnhNhqjwswVx7PgmhOhqiusrWL7iglhRhrhUsVWl78gkhThrgVr+XR8WgjhThrgYrwYW8wgjhUhsgGrWZM9IgihVhsfsq2Zy9cghhWhsf2qd
					aW9tghhWhsgfqJax94gahVhuhfpBa++Pf1hUhxjSjxbV/Qe8hThblibJcg+7eUhRggngR2ep7qeThPfgosK7hM2ZenhOe7pWHijJyGeuhNeyqFHLjuxDethM
					ezqzHrjkxYethMezrRIHjIxxeshMe0rbIcicyNeshMe1rRImhlynerhOe1q1Ingny7eqhPe2qKIffqzJ]],
				["FinF2.L"] = [[
					eNhHeuojMvgP4EeMhLevnZMZfC4JeLhOewmHMAeB4IeLhQewk0LndU4CeKhSexjpLQc934eKhSexivK7c+3teKhRexiMKodV3jeKhPexiDKZeB3aeKhMexiX
					KQe93UeLhJexjFKPgD3PeLhFexkIKahN3MeAhCfGllM2h248d1g/gGncTyg+8meVg9hZo0eGeV+pfhg8iHowoca69Jgjg7iGnnvZYO52g6g8h+msx1XC4Fg6
					g+h/mFyCWw3/g6g/h+llyXXI4Ag6hCh/kUyYXa4Wg5hIiBihyJXr43g5hMiCg+x4YY5Zg4hNiCgQxsZt55g3hPiDfQxSav6Zg1hSiEeMwxbd6zg0hTiFdywU
					cO7KgzhSiFeAv8c47egqhQiIetu2dM8Kf7hNiOgLp1dO+UeyhJh2iNhMdq/zd7hGgwkRXUfE+ed3hCfglyPZhO6seNg/ewmwLOjS3IeWg9emnzKyka2NeWg7
					eno3Lhk32ZeVg7eoprMMk62peUg8epqLMtki29eSg+erqTNBjy3TeRhAesqENHiv3nePhEetpeNAhh34]],
				["FinF1.R"] = [[
					hWhQe2pT32hKzKhVhSe1oW4Uhvy+hVhTe1nZ4ziFythUhUe0mg5QiIyahThVezlx5qh4yHhThVezlQ6AhYx1hThVezlB6QgrxkhShUeylH6Zf1xVhShTeylg
					6ce7xIhShSeymM6WeEw8hShReynG6IdTw0hDhPelnz7KcCuegShOeQng9aZon1fKhNeclw+FW7eaeZhMfRjG79VCVaePhMgFhB42UVPoeRhMgYgv3oUSN7eR
					hNgXhj3+UqOMeRhRgWiB4gV1OPeRhSgViy4uWvOKeRhSgUjs4uXZOAeRhTgUkM4xYWNueQhXgSj647Z7NUeQhYgSjw46a1M+eQhXgRjp4zbGMveQhWgQjK4u
					bTMgeQhWgQib4qbVMUePhVgJhx5HbEM5eShUfkh87wapRKexhTevjJ+jaRZLfwhReQlN+6abjDgwhPeZnb8dbVrshShOeypL5Vcaw3hZhNe6qQ4BcwyMhZhM
					e6q83lc5yYhZhMe5rX3PdSynhYhMe5rf3Cd5y4hYhMe4rT3AeqzGhXhOe4q23JfizPhWhPe3qJ3cgZzQ]],
				["FinF2.R"] = [[
					hyhHetojzXfv3/hyhLesnaz6g436hyhOermJ0fh33thxhQeqk41Dij3chwhSepjw1ki73JhwhSeni32Ci720hvhRemiT2cik2ihuhPeliJ2wh42ThthMelib
					29g72IhshJekjF2/fy2ChrhFekkE21el1/hZhCeTlB4Tc8z9gdg/d3lC71adt3fEg9eCjh+WXwkseFg8fAg89/V7bZd2g7f/ez8CVMVHd3g8gVeY7IU7TSd2
					g+gTfJ7XU/Tqd1hEgQf373WET1d1hHgPg78IW8Txd0hJgOiI8NXtTmdzhMgMjF8VY+TTdzhSgLjd8ibFS2dyhUgKjz8hchSddyhUgKkE8adTSIdyhTgKj58U
					eARzdyhSgKjY8QedRedyhQgCit8mefSAd5hNfUiM+eeRWqejhJeViM/0dqfKf0hGdzjG+Vc7pLhChCeEkx6Kcgxdhqg/elml15cZ2Fhyg9ewoA0Kb93Khxg7
					ewpDzibh3Ohxg7ewp2zAbc3Whxg8ewqTyobx3ghxg+evqYyfcc3shyhAevqGyldZ33hyhEeupey5ei3+]],
				Tail1 = [[
					gAhXgAgOf6gA//gAhZgAgKgEgA//gAhagAgHgOgA//gAhbgAgCgXgA//gAhcgAf+gggA//gAhcgAf6gogA//gAhcgAf2gvgA/+gAhbgAfzg1gA/+gAhagAfv
					g6gA/+gAhZgAfsg9gB/+gAhXgAfqg/gB/+gAhWgAfojygD/wgAhUgAforMgJ99gAhTgAfs0MgR4zgAhTgAfy7EgWxDgAhSgAf4+TgYqPgAhTgAf6/EgYnpgA
					hTgAf7/CgYnxgAhYgAgG+/hAn5gAhZgAgH+8g9oCgAhYgAgA+7gboMgAhZgAf++4gMoWgAhegAgK+1gyofgAhfgAgM+zguoogAhdgAgE+xgLoxgAhcgAgC+u
					f6o5gAhcgAgD+sf3pAgAhbgAgE+afzp8gAhagAgI8Wfxu1gAhZgAgO3Rfy19gAhXgAgTvOf18IgAhWgAgYmnf7/TgAhUgAgZgogA/+gAhTgAgafFgB/+gAhT
					gAgafJgB/+gAhSgAgafPgB/+gAhTgAgYfWgB/+gAhTgAgXfegA//gAhUgAgUfngA//gAhWgAgRfwgA//]],
				Tail2 = [[
					gAhXgeg1fpgA/+gAhZgeguf1gA/+gAhagegmgAgA//gBhbgegdgMgA//gBhcgegTgXgA//gBhcgegJgigA//gBhcgef+gsgA//gChcgef0g1gA/+gChbgefq
					g8gB/+gChZgefghCgB/+gChYgefYhHgB/9gHhWgdfQj8gG/vgUhVgXfNrYgT94gehUgGfS0Xgm4qgbhTfzfe7Lg2w1gShTfofr+Yg+p+gOhTflfw/HhBnXgO
					hUflfx/FhBnfgOhaflf8/BhpnogPhbfmf9+/hlnxgPhZfmf2++hAn8gPhZfmf1+8guoHgPhffmgC+4hRoSgQhgfmgE+1hIodgQhdfmf/+zgfoogQhcfmf++w
					gIozgQhcfmgA+tf+o8gShbfogE+af1p8gZhafvgK8Vfsu3gehYf+gW3Nfp2AgZhXgRgkvHft8MgMhVgcgvmdf2/UgBhUgeg3gcf//+f+hTgeg8e3gC/9f+hS
					gehAe5gC/9f/hSgehCe+gC/9f/hSgehCfEgC/9f/hTgehBfMgB/9f/hUgeg/fVgB/+gAhVgeg6ffgB/+]],
				Tail3 = [[
					f/hVg9hvfQgB/7gAhXg9hpfbgB/8gAhZg9hgfngA/9gBhag9hUf0gA/9gChbg9hHgBgA/+gChcg9g4gOf//+gDhcg9gngbgA/+gDhcg8gVgngA//gEhbg8gD
					gygA/+gEhag8fxg7gB/+gEhZg8ffhEgB/+gPhYg7fOj9gG/vgohXgtfCrcgX92g7hWgMfC0dgz4kg2hVflfP7RhOwqgkhVfQfg+bhhpvgchVfKfm/JhqnFgc
					hWfKfl/IhxnKgchdfLfu/DidnRgdhefLfu/BicnZgehbfLfn/Bh5njgehbfLfm/AhonugfhhfMfz+7iJn6gfhifMf2+4h+oGgghefMfx+3hRoTgghcfNfx+1
					g2ofghhcfNf1+yglorgkhbfPf6+egUpugyhZfef/8agDutg8hXf9gK3Sf117gzhVghgdvKfw8KgYhUg3gxmcf2/UgChSg8hCgXf//+f8hRg8hQeugC/8f8hQ
					g8hcetgD/7f9hQg8hmeugD/7f9hQg8hueygD/7f9hRg8hye3gC/6f+hSg8h0e+gC/7f/hUg9hzfGgC/7]],
				Tail4 = [[
					f+hShbige3gB/3f/hUhbige/gB/4gAhWhbicfJgA/4gBhYhbiUfUgA/5gChZhbiJfhf//6gDhahbh5fuf//7gDhbhbhmf7f//8gEhbhbhRgJf//9gFhbhbg5
					gWf//+gGhbhbgggjgA/+gGhahbgGgvgA/+gWhZhYfrjtgD/xg8hZhEfTrRgR97hZhYgRfH0Ygu4ohRhYfYfM7QhSwsg2hYe3fa+bhxpsgphZevff/JiGm9gp
					haevfc/IiYm9gqhhewfi/DjOnAgrhiewff/BjWnEgrhfewfX/Ci7nJgsheexfT/BiwnRgthleyfe+7jWncguhmeyfg+5jPnngvhheyfb+6iknygwheezfb+5
					iIn/gwhdezfg+3h2oMg1hbe2fi+lhgpRhLhZfMfe8lhFuUhbhXf7fd3igm1phMhUgyfqvcgN8AgkhShTgCmtgA/SgDhQhbgcgjgA//f6hOhag2e1gC/9f6hN
					hahOevgC/8f6hNhahjergC/7f7hNhah3eqgD/6f7hNhaiGeqgC/5f8hPhbiTesgC/4f9hQhbibexgC/4]],
				Tail5 = [[
					f8hNh4iZergA/4f9hPh5imeugA/3f+hRh5iveyf//2f/hTh5iye5f//2gBhVh5ivfBf+/2gChXh5iofKf+/3gDhYh5iafWf+/5gFhZh5iIfif+/6gGhah5hy
					fvf+/8gHhah5hXf8f//9gHhah5g6gJgA/+gdhah2gZjKf+/1hQhahbf4qzgE+Hh3hagXff0Dgc47hshbfKfX7EhDxAhHhceefd+Whrp9g1hdeUff/GiNnIg2
					heeUfX/FisnCg3hneVfa+/jxm/g3hpeWfU+8kHm9g4hkeWfI++j5m8g5hjeWfB+9j7m+g7hseXfI+1ktnDg8hseYfG+zkwnJg9hmeYe/+2kOnQg+hieYe++3
					j5nag/hgeZfA+2jsnlhGheede/+mjZophjhbe6em8ui3tth5hYf4eJ33iF1HhlhVhCd/v6hK7pgxhShvePnOgb/HgEhPh5euhDgE/8f3hNh5fRfRgA/+f3hL
					h5f0fGgB/+f4hKh4gWe9gB/+f4hJh4g2e2gB/9f5hJh4hVewgB/8f6hKh4hvesgB/6f7hMh4iGergB/5]],
				["FinB1.L"] = [[
					euhPghjiOmiE6heuhRghkSO7jA6ievhSgilHPZjv6mevhTgjl7P9kM6tevhUgjmpQmkV64evhUgknMRNkI7HewhUgknjRujl7YewhTglnqSGiw7oewhSglnk
					SShu71ewhRglnPSRgm79ewhPglmvSGff8Ae4hOgyl7UReB9GfXhMhOkWbFcO/FgPhLhXiBk4bL/LhAhKg8f4uPbX8RhVhKgYez0OcN4ehYhKgKe62Ac52+hY
					hLgKfq1wdT3ThXhPgLhI1jd83hhXhRgLiQ1Wd43ohXhQgMjE1JdR3qhXhRgNkD1Bct3ihXhVgOlg1Gcl3KhXhWgOmN1Nb+2yhXhVgPmN1VbC2ehXhUgQmD1k
					aW2IhXhUgQlr12Z411hVhTgVlI1fZr2QhKhSgwlJxxaN5cgmhRhPlgqSbQ9afvhPhXlwgbce/RfDhOhAltXPdb+HewhMgllVRWd072ethLgdkqPndn6+ethK
					gdj5PQdf62ethKgejQO8ds6wethKgeiyOreO6sethLgfikOffA6oeuhMgfinOaf+6leuhOggi9ObhB6j]],
				["FinB2.L"] = [[
					eUhIgshpQigt78eVhHgtihQ4iK7/eWhGgujhRbjh8CeXhGgwkiSGkn8EeZhFgxleS1lV8IeahFgymQTiln8PeahFgzm0UIla8ZeahEg0nHUikw8neahEg0nH
					Uvjt82eahEg1mzUuiY9DeZhEg1mNUhg79MejhFhGlUWzfA+KfNhFhpjldyc2/jgXhGhzg6nlbs+xhYhHhPeXwncF7AhyhHgec92KdT2uh1hIgLcx3ueO1Ih1
					hIgNdT3des1jh1hLgNeu3QfZ17h1hLgOgC3GfX2Hh0hIgQhQ3Aev2KhzhHgQiy29eL2ChzhJgQk13AeH1nhyhJgQmL3Fde1IhxhGgQm03Kcd0rhxhFgQnN3U
					br0OhxhFgQnN3ibHz1hwhEgXm13Oa30RhjhEg6mrz1bk3yg2hEhlmesxc18bfvhEhzl8jId//NezhFhXlMZ2ee+7eXhFg1kZTxeK9KeShGgqjfR8dS8ZeShH
					gqigRkck8OeShHgqhoRNcS8EeShIgqhAQ3cc78eShIgqgqQmdC73eShIgrgqQbeA73eThIgrhAQZfR75]],
				["FinB1.R"] = [[
					hShPghjixad86hhShRggkQxTc+6ZhShSgflDxDcM6UhThTgfl1wrbr6UhThUgemgwPbe6ZhThUgenCvzbo6jhThUgdnZvbcH6whThTgdnivMc669hThSgdne
					vGd67HhThRgcnNvKfC7OhThPgcmwvXgK7PhXhOgNmOx/gn5thUhMfklw34gF0ggxhLe3lJ9bfEraf7hKeokR/oeKg/fUhKe0jS+/dvZIfHhKe8ic+QdyWLfI
					hLe8hn+Qd0V/fIhTe7gf+SeKV3fJhUe7fj+QdkV6fJhRe7e3+KcQWEfKhRe6eN+DbIWYfLhZe6dh+HayW5fLhae5dT+GZ3XefMhWe5df+AYqYGfMhUe5d5+B
					X/YufMhUe4eg+JXzZTfRhTe1fk+dX4alfshSeqhx/CYdf3gbhReskY+BaNoThIhPfNmF6GdDxNhYhOf8mQ0df/3yhThMgdlbwBh77FhQhLglkivIim7thQhK
					gkjyvmis7ihRhKgkjKwEib7YhRhKgjiuwgh47NhRhLgjiiw4hE7ChRhMgiinxLgF63hShOghi9xXfA6s]],
				["FinB2.R"] = [[
					hshIgshpvefT78hshHgrigvWd073hshGgrjdvCcc7zhrhGgqkbulbS7vhqhFgqlTuCag7thqhFgqmDtgaL7whqhFgqmltEaU74hqhEgqm4sya88DhqhEgqm7
					ssb98QhrhEgqmrsxdS8bhshEgqmKs/ex8jhyhFgWlavxfy7ThwhFffkx2HgG2nhFhGehka8cgCt+f9hHeKkP/ff1jrfHhHeZkE/cfwbte2hIekjt+6f+Yne2
					hJekjC+6gLYVe2hQekh7+8gkYHe3hQejgz+/f6YHe4hKejft/AecYTe6hHejek+9dDYpe7hOeidX+8cZZOe9hOeicl+1bIZ6e/hIeicP+oZialfAhFeicN+g
					YgbRfBhFehcj+gYBb4fHhEeddf+sX1dNfrhEeQfz+3X/iggohEeUiv9NZWq3hhhEfBk64mcGzdh1hFf/lXyafQ5mhthFgqkftrho8hhphGg0jWsui49BhqhH
					gziWtPji80hrhHgyhgtwjy8mhrhIgxg5uRjm8ZhshIgwgmuvi/8OhshIgugovIiA8HhthIgthAvZgw8B]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Spine1 = [[
					gAhagAACgAgFgvgAhcgAABgAgIgogAhbgAABgAgJglgAhXgAABgAgJglgAhUgAABgAgHgpgAhSgAACgAgEgwgAhUgAACgAgBg5gAhYgAACgAf9hCgAhcgAAC
					gAf6hKgAhcgAADgAf3hOgAhZgAADgAf3hQgAhVgAACgAf4hOgAhTgAACgAf6hIgAhTgAACgAf+hAgAhWgAACgAgBg3]],
				Spine2 = [[
					gAhbflABgAgLgggAhdflABgAgPgYgAhcflABgAgQgWgAhYflABgAgOgagAhVflABgAgKgkgAhUflACgAgEgygAhWflACgAf9hBgAhaflADgAf3hPgAhdflAD
					gAfzhZgAheflADf/fxhegAhbflADf/fxhdgAhXflADgAf0hWgAhVflACgAf5hKgAhVflACgAgAg8gAhYflABgAgGgt]],
				Spine3 = [[
					gAhcfLACgBgQg6f/hefLACgBgTg0f/hcfLACgBgSg1f/hZfLACgBgPg9gAhWfLACgAgIhMgAhVfLADgAgBhdgAhYfLAEgAf5hvgAhcfLAFf/fzh/gBhgfLAG
					f/fuiIgBhgfLAGf/ftiLgBhefLAFf/fviGgBhafLAFf/f0h7gAhWfLAEgAf7hrgAhWfLADgAgDhYgAhZfLACgAgKhH]],
				Spine4 = [[
					f/heewACgBgSg9f/hfewACgBgUg4f/heewACgBgSg7f/hbewACgBgOhGf/hYewADgAgHhWgAhXewAEgAf/hpgAhaewAFgAf3h7gBhfewAGf/fxiKgBhjewAG
					f/ftiSgBhkewAGf/ftiTgBhhewAGf/fwiMgBhdewAFf/f2h+gAhZewAEgAf9htgAhZewADgAgFhagAhbewACgBgNhJ]],
				Head = [[
					f/hfeVgAABglgQf+hheVgAABgmgQf+hfeVgAABgggNf/hceVgAABgUgIf/haeVgAABgFgBgAhaeWgAABf1f7gAheeWgAABfnf1gBhjeWgAABfdfxgBhneWgA
					ABfafwgChoeWgAABfcfygBhleWgAABfmf2gBhgeWgAABfzf8gBhceWgAABgDgCgAhbeWgAABgSgIf/hdeVgAABgfgN]],
				Jaw = [[
					f+hVeB/2gBfwi+f+hWeB/2gBfxi/f+hVeB/3gBfzi5f/hSeB/4gBf4itf/hQeB/5gAf/iegAhReB/6gAgFiOgBhUeB/7f/gLiAgBhaeB/8f/gPh2gCheeB/8
					f/gQhzgChfeB/8f/gOh2gChceB/7f/gKh/gBhWeB/6gAgEiMgAhSeB/5gAf+icgAhReB/4gBf4irf/hSeB/3gBfzi3]],
				["Cheek.L"] = [[
					fVhddhfmJkgb2yfVhfdhflJkgb2yfVhedhfqJigX2wfVhbdhfyJegO2tfWhadgf9JZgE2ofXhbdggIJVf42kfYhfdggSJRfu2gfZhldggZJOfn2dfZhpdggb
					JOfl2cfZhqdggZJPfn2dfZhmdggTJRft2gfYhhdggJJVf32kfXhcdhf+JagC2pfXhadhfzJfgN2tfWhbdhfqJigW2x]],
				["Cheek.R"] = [[
					gnhddgfl2yfm2cgnhfdgfl2yfl2cgnhedgfp2wfq2egnhbdgfy2tfy2igohadgf82of92ngphbdhgI2kgI2rgqhfdhgS2ggS2vgrhldhgZ2dgZ2ygrhpdhgb
					2cgb2ygrhqdhgZ2dgZ2xgrhmdhgT2ggT2vgqhhdhgJ2kgJ2rgphcdgf+2pf+2mgohadgfz2tfz2hgnhbdgfq2xfq2e]],
				["FinF1.L"] = [[
					ephSe3pdJobE0OephUe4mQIUZJzYephSe4jIHKYlyeephPe4ggGVZWx3ephMe3e4FvbMxleqhLe3emFRduxXeqhOe2f2E4gfw8erhTe1ifEvjDwRerhXe1mE
					FNlDvkerhYe1p0GbmSvRerhVe1s8INmnvrerhRe1u1J+l3w1erhNe2vRLIkAyaeqhNe2uULZhNzyeqhPe3sRKyd+0d]],
				["FinF2.L"] = [[
					eLhNezq/OneD4beLhWeym/NCaS4IeMhaexikL3Xn3PeNhZevegLEWa2JeOhVesbkKWWx1MeOhQeqaXJbYe0neOhNeobMIWbN0beQhLend9Hkep0feThJemiE
					Hvic0leXhFemmnJNmC0leag/enqqLvor0meag6eptmOepr06eXg3esvMQaov1weSg6evvTQ8mF27eOhCeyt4QJiQ39]],
				["FinF1.R"] = [[
					hVhSe2pg2mk2z+hVhUe1mX3+mxzDhVhSe1jP5InYyGhVhPe1gm57mqxhhVhMe2e76bk1xVhWhLe2en6ziTxRhWhOe3f27FfhxBhWhTe3ih7Ic+wghXhXe3mI
					6mbCv7hXhYe3p75WZ3vphXhVe3tC3kZlwBhXhRe3u612aUxFhWhNe3vT0wcGyihWhNe2uU0ne0zzhWhPe2sS1Wh+0V]],
				["FinF2.R"] = [[
					hzhNewrAxqh14OhzhWevnFzUln32hyhaetit0goX28hxhZesep1Ppn13hxhVeqbq12pS0/hyhQepaZ2qnj0ihyhNepbM3nky0fhxhLepd84RhW0shvhJepiG
					4Adm05hrhFeqmt2faF07hpg/eqqyz9Xf04hog6esttxSWf1Hhqg3euvPvdXX12hug6evvTvDZ727hxhCewt3v/dr34]],
				Tail1 = [[
					gAhagAgLf7gA//gAhcgAf0gFgA//gAhbgAffgOgA//gAhXgAfQgUgA/+gAhUgAfJgXgA/+gAhSgAfMgWgA/+gAhUgAfYgRgA//gAhYgAfqgJgA//gAhcgAgA
					gAgA//gAhcgAgXf2gA//gAhZgAgpfugA//gAhVgAg0fqgA/+gAhTgAg2fpgA/+gAhTgAgvfsgA/+gAhWgAggfygA//]],
				Tail2 = [[
					gAhagehJfhgB/9gAhdgeghfygA//gAhcgefzgFgA//gBhZgefIgYgA/+gBhVgeemgngB/9gBhUgeeUgugB/8gBhWgeeUgugB/8gAhZgeeogmgB/9gAhcgefK
					gXgB/+gAhbgef2gEgA//f/hYgegjfxgA//f/hUgehLfggA/9f/hRgehlfVgB/8f/hSgehufRgB/7gAhVgehkfVgB/8]],
				Tail3 = [[
					f/hYg8ine5gD/3gAhcg9h8fLgC/7gBhcg9g7fngB/+gBhag8fwgHgB//gChYg8eogmgB/9gChXg8dvg+gB/5gChZg8dQhMgC/2gBhcg8dOhMgD/2gBhdg9ds
					hAgD/5gAhcg9ejgogC/8f/hXg9fqgJgB//f+hSg8g1fpgB/+f+hOg8h3fNgB/7f+hOg8ike6gC/3f+hSg8i1eygD/1]],
				Tail4 = [[
					f9hThaj6eRgE/tf+hYhbjmeZgF/vgAhbhbipezgE/3gChbhbhNfbgD/9gDhbhbfhgJgC//gEhbhad6g1gC/6gEhehacohYgD/ygEhhhab6hsgE/rgDhihab3
					htgG/rgBhehbcghcgF/xf/hYhbdvg6gE/5f+hQhbfVgOgC/+f9hLhahBfggB/+f8hKhaife3gB/3f8hNhajhebgD/w]],
				Tail5 = [[
					f6hLh4kEd9gC/qf7hRh4kldvgE/lf+hWh5kLd6gF/pgAhZh5i8ecgF/0gDhbh5hFfPgE/9gFhfh4e5gLgE/+gHhkh4cyhFgE/zgHhph3bHhzgH/kgGhph4aL
					iMgJ/YgEhlh4aHiOgL/XgBhch5a8h3gL/if+hRh5chhMgI/xf8hJh5elgTgF/9f6hFh4gyfXgC/+f5hGh4iueigB/1]],
				["FinB1.L"] = [[
					euhSghf4Muir5YeuhVghirNQly5HeuhTgilmOrn/5EeuhQgioAQro35aeuhMghphSooK6NeuhLghqMT8l27NeuhMghqGUViU77euhQggpST1eR8CeuhTggnw
					Sual7heuhTgglhRbX96weuhQggi2QQWy6HeuhMgggPPUXJ50euhKggeQOhY55xeuhLggdZNubu5xeuhOghd9NAfJ5p]],
				["FinB2.L"] = [[
					eShQgpdaOFe/6WeUhKgqgjOvj96oeYhDgsj7QloW6eecg8gum8THrM6Jeeg3gwpPVer66Lefg2gxqrW3qZ6yecg6gxrHXCm97xeZhCgxqWWPiR8keWhLgwoW
					VCdM8ueUhRgwlUT5Yq8MeUhVgvhwS/Vd7MeVhVgueWSIUD6LeUhUgsbyRFUi5heThTgqarPyWv5beShSgpbROmaX5z]],
				["FinB1.R"] = [[
					hShSggf3zadV5ShShVggioy8aN4+hShTgglixjX+46hShQggn7vjXE5ShShMggpetkXy6HhShLggqKsLaH7JhShMghqGrsds77hShQghpSsFhx8EhShTghnt
					tGle7nhShTghlcuWoG64hShQghixvhpQ6QhShMghgKweo358hShKgheNxVnG53hShLghdYyOkS5zhShOghd9zCg35n]],
				["FinB2.R"] = [[
					hvhQgodbyDhB6QhthKgpghxecC6fhphDgqj2vqXo6Vhlg8gsm1tHUw6Chig3gupJquUC6Ghig2gwqopQVk6whkg6gxrHo/ZC7xhnhCgxqXprdx8mhphLgyoV
					qzi48zhrhRgxlQr4nZ8ShrhVgxhqsxqk7ThrhVgveQtqr86ShrhUgtbuuyrd5mhthTgraqwKpQ5dhuhSgpbSxclp5y]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Spine1 = [[
					gAhhgAABgAgKgjgAhogAABgAgPgXgAhhgAABgAgMgfgAhbgAACgAgBg3gAhhgAADgAf2hRgAhogAADf/fxhegAhhgAADf/f0hWgAhbgAACgAf/g+]],
				Spine2 = [[
					gAhiflABgAgVgJgAhoflABgAgZgAgAhiflABgAgOgagAhcflACgAf7hGgAhjflAEf/frhsgAhqflAEf/fnh1gAhjflADf/fyhbgAhcflACgAgFgv]],
				Spine3 = [[
					f/hifLABgBgcgef/hofLABgBgbggf/hjfLACgAgKhHgAhefLAFf/f0h8gBhmfLAHf+fkihgBhtfLAHf+fliegBhmfLAFf/f2h4gAhdfLACgAgMhC]],
				Spine4 = [[
					f+hjewABgBgdghf+hpewACgBgagqf/hkewADgAgHhWgAhhewAGf/fwiLgChqexAIf+fjiqgChxexAIf+fmihgBhpewAEf/f5h2gAhfewACgBgQhB]],
				Head = [[
					f+hkeVgAACg+gaf+hqeVgBABgqgQf/hneVgAABf9f9gBhleWgAACfSfrgChveWgAACfCfmgCh1eWgBABfWfwgBhseWgAABgDgDf/hheVgAACgugV]],
				Jaw = [[
					f9hZeC/lgEfmlBf9hgeB/pgDfwktf/hdeB/vgAgDkAgBhceB/0f+gVjWgDhmeB/1f9gajGgDhseB/zf+gQjagBhieB/ugBf9kHf/hWeB/ogDfsky]],
				["Cheek.L"] = [[
					fThhdhfUJsgs25fUhodhfjJkge2zfWhndggDJWf+2lfZhndgghJKff2YfbhydggsJHfU2Ufah4dggeJNfj2cfYhsdhf+JbgD2qfVhedhffJogh22]],
				["Cheek.R"] = [[
					glhhdffU25fU2Ugmhodgfi2zfj2cgohndggC2lgD2qgrhndhgh2Ygh22gthydigs2Ugs25gsh4digd2cge2zgqhsdhf92qf+2lgnhedfff22ff2Y]],
				["FinF1.L"] = [[
					ephYe5oxNMXu25ephee5hpJ3TozbephYe4cSICWiykeqhUe2cVGsd1zFerhde0jHF1lRxWeshle0sdJBpVv5erhde1xDOWoTyweqhUe3u6P1hG3M]],
				["FinF2.L"] = [[
					eKhVe9sYSobZ54eNhse6iMPFS13oeQhqezYyN+Rn08eNhcetWULOXK0eeRhSepdiILgg1MedhMeqpBL8qX0yeghBevwSUTth08eUg+e5xoW1m14H]],
				["FinF1.R"] = [[
					hVhYe1o9zSoG2ghUhee1h82msUy5hVhYe1ca4PphyPhWhUe3cV5OiKzNhXhde4jP5zazx5hXhle4ss2mW+wdhXhde3xKxZX8zAhWhUe2u6wSe13H]],
				["FinF2.R"] = [[
					hzhVe5set6kW5mhwhse1ihxgtH3OhuhqewY+yUug0shzhceuWR0soz0lhyhSeudj3Yfc1shnhMeupRzjV21QhjhBeywerbSt1Ghsg+e3xmpSZG4F]],
				Tail1 = [[
					gAhhgAgWf3gB//gAhogAfWgSgA/+gAhhgAeugjgB/9gAhbgAe3gfgB/9gAhhgAfqgJgB//gAhogAgqfugA/+gAhhgAhSfdgB/9gAhbgAhJfhgB/9]],
				Tail2 = [[
					gAhggeiGfHgD/6gBhpgegWf3gB//gBhkgeeZgsgB/8gBhdgedZhIgD/3gAhiged6g5gD/6f/hmgefqgJgB//f/hfgehnfUgB/8f/hYgeine4gD/3]],
				Tail3 = [[
					f+hdg8kPeMgH/qgAhog9ite2gG/2gChng8flgMgC//gDhig8cthagD/ygChmg8bxh0gH/qgAhng9dThKgG/2f+hcg8gbf0gC//f9hTg8jTemgD/y]],
				Tail4 = [[
					f7hVhZlPdsgI/ef+hjhalbdngM/cgDhnhbiXe8gJ/4gGhohadzg4gF/5gFhuhZaeiTgJ/bgChshaaSiYgO/Yf9hbhbdVhEgK/3f6hNhah5fIgE/7]],
				Tail5 = [[
					f2hLh2jgeMgH/vf6hZh3mmc5gL/JgBhjh4lbdZgR/agHhsh3grfcgO/+gKh4h1bGh0gM/jgGh3h2YCjHgU+0f/hgh4ZMimgY/Jf5hKh4d6gkgP/6]],
				["FinB1.L"] = [[
					euhagid3OTjv6SevhhgilEQorR5LevhagipsWZsP6OeuhSghqpZgk19EeuhYggphX9Zd8ueuhegflNUbSU5+euhYggevSESy5ieuhSgha9QIZ36n]],
				["FinB2.L"] = [[
					eThZgtapPFev6lebhPgxjFSYre6ZenhEg1pvZ6wm40emg/g2tMc2qt67edhLg1r/Z9d889eYhgg0lFXKSb7HeahlgycAVrOl4ceXhgguXHSRTe4e]],
				["FinB1.R"] = [[
					hShaggd0x9cT6HhShhggk5vwUq48hShaggpjp7Tq6GhShSghqomibK9DhShYghpdnymp8zhRhegilArMtw6JhRhYgheltptN5thShSgha9v2mI6o]],
				["FinB2.R"] = [[
					huhZgraqxLhU6bhmhPgui6uBUf6MhahEgzpjmYPT4vhag/g1tLjNVS67hihLg3r+lxiL9Bhnhgg3k4octq7Phlhlg0bzqCxY4khphggvXGttsh4f]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Spine1 = [[
					gAhXgAACgAgAg6gAhZgEACgAgAhBgAhcgOADgAgAhRgAhhgZADgAgAhjgAhjggAEgAgAhugAhegCADgAgAhPgAhTe2ABgAgAgFgAhTe2ABgAgAgFgAhTe2AB
					gAgAgFgAhTe6ABgAgAgHgAhUfLABgAgAgUgAhWfkABgAgAgmgAhXf5ACgAgAg1gAhXgAACgAgAg6gAhXgAACgAgAg6gAhXgAACgAgAg6]],
				Spine2 = [[
					gAhZflACgAgAg6gAhafpACgAgAhHgAhefzAEgAgAhngAhjf+AGgAgAiLgAhmgFAHgAgAiigAhgfoADgAgAhjgAhTecACgAgAfPgAhTecACgAgAfPgAhTecAC
					gAgAfPgAhUefABgAgAfUgAhVewABgAgAftgAhXfJABgAgAgSgAhYfeACgAgAgwgAhZflACgAgAg6gAhZflACgAgAg6gAhZflACgAgAg6]],
				Spine3 = [[
					gAhafLADgAgAhfgAhcfPAEgAgAhygAhhfYAHgAgAiigAhnfkAMgAgAjYgAhqfrAQgAgAj7gAhjfNAHgAgAicgAhSeBACgAgAe/gAhSeBACgAgAe/gAhSeBAC
					gAgAe/gAhSeEACgAgAfGgAhUeWABgAgAfsgAhXevABgAgAgjgAhafEADgAgAhQgAhafLADgAgAhfgAhafLADgAgAhfgAhafLADgAgAhf]],
				Spine4 = [[
					gAhdewAEgAgAhmgAhfe0AFgAgAh/gAhle+AKgAgAi+gAhsfJASgAgAkGgAhxfRAYgAgAk1gAhnezAJgAgAi3gAhQdmAEgAgAeQgAhQdmAEgAgAeQgAhQdmAE
					gAgAeQgAhRdqAEgAgAeZgAhUd7ACgAgAfMgAhYeUABgAgAgVgAhcepADgAgAhSgAhdewAEgAgAhmgAhdewAEgAgAhmgAhdewAEgAgAhm]],
				Head = [[
					gAhfeWgAABgAgAgAhjeagAACfBgAgAhqekgAANcjgAgAhzewgAAoZxgAgAh5e4gABDX+gAgAhreYgAAOcagAgAhNdMf5AumqghgAhNdMfvAvmphQgAhNdMgR
					AvmpeugAhOdPgbAumXd7gAhTdggAAYkzgAgAhZd5f4AKiihqgAheeOf/ACgpgmgAhfeWgAABgAf0gAhfeWgAABgAgAgAhfeWgAABgAgA]],
				Jaw = [[
					gAhWeB/9gAgAhSgAhaeF/7gAgAiDgAhleO/2gAgAjDgAhyeZ/7gAgAh+gAh6eh/xgAgAjwgAhmeC96gAgArWf/g8c9+jf8fepef+g8c993f8evragCg8c9+R
					gIhUqPgDg9dA/AgWiGnmgAhDdQ/agAgAmEf+hMdn/uf8eWjzf/hTd6/7gBfah7gAhWeB/9gAgMhSgAhWeB/9gAgAhSgAhWeB/9gAgAhS]],
				["Cheek.L"] = [[
					fXhfdggAJZgA2nfXhmdmgsJZfU2nfXh1d0icJhdk2ffXiFeFkaJ0bm2MfXiPePlsKHaU15fXh3dniiJide2efVg4cdbOKQko2ffTg5cebHKykh2/fcg3cYbg
					I/k51Nfeg4cZb0Ibkz0pfXhDcucnJpjZ2XfShRdJeHKqht3sfVhcdbfjJ0gc3CfYhfdggAJQgA2ffXhfdggAJYgA2nfXhfdggAJZgA2n]],
				["Cheek.R"] = [[
					gphfdggA2ngA2ngphmdmgs2ngs2ngph1d0ic2fic2fgpiFeFka2Mka2MgpiPePls15ls15gph3dnii2eii2egng3cabY2fbO1wglg3cYbf2/bH1Ogtg5cebH
					1Nbg3Bgwg8cjbN0pb03lgphDcucn2Xcn2XgjhQdBeT3seH1WgnhcdYfk3Cfj2MgqhfdhgA2fgA2wgphfdggA2ngA2ogphfdggA2ngA2n]],
				["FinF1.L"] = [[
					eqhRe2nhG8gAyaeqhTe6m2GXfdx2eqhYfEk+FEeLwaeqhffOilD7c8uyeqhjfWg5DYcRtxeqhae4lQFkeGxIeqhGduqyPXlS4ieqhGduqyPXlS4ieqhGduqy
					PXlS4ieqhHdxqvO8lB4UeqhJeCqXMtjn3CeqhNebpUJyhx09eqhQevoCHngazEeqhRe2nhG8gAyaeqhRe2nhG8gAyaeqhRe2nhG8gAya]],
				["FinF2.L"] = [[
					eOhIesltLBgA3deOhMeulMKZfS2/ePhWe1jsI9dj1ueQhie9hsHpbx0OeShpfDgPG/avzOeOhXerj8Jldl2WeVgxd1oWUem/7yeVgxd1qkVyoa7JeVgxd1qq
					V1od7HeUgyd3qrVXoO6/eRg3eEqgSzm26TePg/eXpQPGkc5JeOhGemnWMLh537eOhIesmGLIgc3deOhIesluLBgA3deOhIesltLBgA3d]],
				["FinF1.R"] = [[
					hWhRe2nh5EgAyahWhTe6m25pgjx2hWhYfEk+68h1wahWhffOil8FjEuyhWhjfWg58ojvtxhWhae4lQ6ch6xIhWhGduqywpau4ihWhGduqywpau4ihWhGduqy
					wpau4ihWhHdxqvxEa/4UhWhJeCqXzTcZ3ChWhNebpU2OeP09hWhQevoC4ZfmzEhWhRe2nh5EgAyahWhRe2nh5EgAyahWhRe2nh5EgAya]],
				["FinF2.R"] = [[
					hyhIeslt0/gA3dhyhMeulM1ngu2/hxhWe1js3Did1uhwhie9hs4XkP0OhuhpfDgP5BlRzOhyhXerj82bib2Whrgxd1oWriZB7yhrgxd1qkqOXm7Jhrgxd1qq
					qLXj7Hhsgyd3qrqpXy6/hvg3eEqgtNZK6Thxg/eXpQw6bk5JhyhGemnWz1eH37hyhIesmG04fk3dhyhIeslu0/gA3dhyhIeslt0/gA3d]],
				Tail1 = [[
					gAhXgAgAgAgA//gAhZgEf6gAgA//gAhcgOfqgAgA//gAhhgZfYgAgA//gAhjggfMgAgA/+gAhegCfRgAgA/+gAhTe2fufWgA/+gAhTe2hVe6f9/8gAhTe2hZ
					hJgD/8gAhTe6hbiqgI/2gAhUfLhliXgI/3gAhWfkhbgdgB/9gAhXf5g7fRf//+gAhXgAgUfngA//gAhXgAgAgAgA//gAhXgAgAgAgA//]],
				Tail2 = [[
					gAhXgegAgAgA//gAhZgiftgAgA//gAhdgse+gAgA/+gAhig3eHgAgA/7gAhlg+dkgAgA/5gAhfggeNgAgA/8f/hUfVgSeSgB/8f+hRfUjebMfo/bgChRfUjn
					gOf3/ygFhRfXjplPgP/WgEhRfpjvmpge/EgBhTgCjKjBgQ/sf/hVgXh7fRgA/7f/hXgegofJf//+gAhXgegAf/gA//gAhXgegAgAgA//]],
				Tail3 = [[
					gAhXg9gAgAgA//gAhZhAfhgAgA//gAhfhKeRgAgA/8gAhlhVc3gAgA/1gAhphcb9gAgA/vgAhjg/dKgAgA/3f7hTfzg2dYgB/3f1hKfxlfVie79tgDhKfylw
					bvfC/KgPhKfzl0lPf3/BgRhLgElyq4g19ggHhNgfkznrg0+rf9hSg1i6g4gL/2f+hWg9g8e+gA/9gAhXg9gBf/gA//gAhXg9gAgAgA//]],
				Tail4 = [[
					gAhXhbf2gAgA//gAhahffKgAgA/+gAhihodbgAgA/4gAhrhzbegAgA/qgAhxh5aMgAgA/dgAhohcb9gAgA/vf3hSgRhPdYgD/3fihBgHnLQheQ7Af6g/gNnY
					UbdZ8ygYg/gOnqgzeY/AgkhBgZnpsWgi8ggVhFg5mLslhg8uf/hMhTjukLgk/ff8hUhbhGfagB/9gAhXhbf3f/gA//gAhXhbf2gAgA//]],
				Tail5 = [[
					gAhYh5fTgAgA/+gAhch9eagAgA/8gAhniGcMgAgA/wgAh0iQZrgAgA/XgAh8iWYEgAgA+/gAhwh6aXgAgA/ffyhPguhPexgK/8fJg4gUofO7ed5oflg1ggoN
					Nmbf4bgZgxgpocYTbc9ig5g1gro8pAer9Vgrg7hMnKvNh17KgHhFhvkFoFhN+qf7hSh5g3gkgG/+gAhYh5fTf/gA//gAhYh5fTgAgA/+]],
				["FinB1.L"] = [[
					euhPghkpPygA7LeuhQglkNPGfO60euhTgui7NgdV5yeuhXg5hKL8bX4ceuhZhAf3LFaM3feuhVgjjJOPda6SeuhNfXlyY/m694euhNfXlyY/m694euhNfXly
					Y/m694euhNfbl1Ylmm92euhNfsl9WSk59feuhOgFlpTGih8neuhPgak9Qlgn7leuhPghkpPygA7LeuhPghkpPygA7LeuhPghkpPygA7L]],
				["FinB2.L"] = [[
					eUhIgujbSDgA8leThLgxjERYfK8ReShSg3h+PydG7WeRhbg/gbONa76FeRhhhEfQNWZm5KeShTguiLQkdP7yekhAfxknbfoG+RekhAfxmacYqL9bekhAfxmf
					cbqQ9YejhAfzmib+p/9aefhAgCmmZhoY9deZhDgXl1V+lc9TeVhGgokiTHiV81eUhIgujsSHgi8leUhIgujbSDgA8leUhIgujbSDgA8l]],
				["FinB1.R"] = [[
					hShPghkpwOgA7LhShQglkNw6gy60hShTgui7ygir5yhShXg5hK0Ekp4chShZhAf307l03fhShVgjjJxxim6ShShNfXlynBZG94hShNfXlynBZG94hShNfXly
					nBZG94hShNfbl1nbZa92hShNfsl9pubH9fhShOgFlps6df8nhShPgak9vbfZ7lhShPghkpwOgA7LhShPghkpwOgA7LhShPghkpwOgA7L]],
				["FinB2.R"] = [[
					hshIgujbt9gA8lhthLgxjEuog28RhuhSg3h+wOi67Whvhbg/gbxzlF6FhvhhhEfQyqma5KhuhTguiLvcix7yhchAfxknkhX6+RhchAfxmajoV19bhchAfxmf
					jlVw9YhdhAfzmikCWB9ahhhAgCmmmfXo9dhnhDgXl1qCak9ThrhGgokis5dr81hshIgujst5fe8lhshIgujbt9gA8lhshIgujbt9gA8l]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAhXgAACgAgAg6gAhWgAACgAgAg0gAhSgAABgAgAglgAhQgAABgAgAgZgAhQgAABgAgAgbgAhegAACgAgAhKgAhtgAAFgAgAh5gAhwgAAFgAgAiCgAhwgAAF
					gAgAiCgAhwgAAFgAgAiCgAhwgAAFgAgAiCgAhwgAAFgAgAiCgAhwgAAFgAgAiCgAhwgAAFgAgAiCgAhwgAAFgAgAiCgAhwgAAFgAgAiCgAhwgAAFgAgAiCgA
					hvgAAFgAgAiAgAhngAAEgAgAhngAhbgAACgAgAhGgAhXgAACgAgAg6gAhXgAACgAgAg6gAhXgAACgAgAg6]],
				Spine2 = [[
					gAhZflACgAgAg6gAhXflABgAgAgtgAhTflABgAgAgPgAhQflABgAgAf3gAhRflABgAgAf7gAhgflADgAgAhZgAhwfmAJgAgAi4gAhzfmALgAgAjJgAhzfmAL
					gAgAjJgAhzfmALgAgAjJgAhzfmALgAgAjJgAhzfmALgAgAjJgAhzfmALgAgAjJgAhzfmALgAgAjJgAhzfmALgAgAjJgAhzfmALgAgAjJgAhzfmALgAgAjJgA
					hzfmALgAgAjGgAhpflAGgAgAiUgAhdflADgAgAhRgAhZflACgAgAg6gAhZflACgAgAg6gAhZflACgAgAg6]],
				Spine3 = [[
					gAhafLADgAgAhfgAhYfLACgAgAhLgAhUfLABgAgAgegAhQfLABgAgAf6gAhRfLABgAgAgAgAhifLAGgAgAiOgAh1fLAVgAgAkbgAh4fLAYgAgAk1gAh4fLAY
					gAgAk1gAh4fLAYgAgAk1gAh4fLAYgAgAk1gAh4fLAYgAgAk1gAh4fLAYgAgAk1gAh4fLAYgAgAk1gAh4fLAYgAgAk1gAh4fLAYgAgAk1gAh4fLAYgAgAk1gA
					h4fLAYgAgAkwgAhtfLAOgAgAjmgAhffLAFgAgAiBgAhafLADgAgAhfgAhafLADgAgAhfgAhafLADgAgAhf]],
				Spine4 = [[
					gAhdewAEgAgAhmgAhaewACgAgAhLgAhUewABgAgAgPgAhQewABgAgAffgAhRewABgAgAfngAhmewAIgAgAijgAh8eyAfgAgAlfgAiAeyAmgAgAmCgAiAeyAm
					gAgAmCgAiAeyAmgAgAmCgAiAeyAmgAgAmCgAiAeyAmgAgAmCgAiAeyAmgAgAmCgAiAeyAmgAgAmCgAiAeyAmgAgAmCgAiAeyAmgAgAmCgAiAeyAmgAgAmCgA
					iAeyAlgAgAl8gAhzexAUgAgAkZgAhiewAGgAgAiTgAhdewAEgAgAhmgAhdewAEgAgAhmgAhdewAEgAgAhm]],
				Head = [[
					gAhfeWgAABgAgAgAhceVgAACg8gAgAhVeVgAAKjDgAgAhPeVgAAYkvgAgAhQeVgAAVkcgAgAhqeWf/AEeNfpgAiFeYfyBAYNfGgAiKeZgcA5Y0h5gAiKeZf3
					BMXbfegAiKeZflBYW7elgAiKeZgaA6YuhvgAiKeZgABHXugAgAiKeZffBcWxeTgAiKeZgWA8YjhcgAiKeZgJBCYCgigAiKeZfcBeWreKgAiKeZgQA+YUhCgA
					iJeZgQA8YehAgAh7eXfxAmaEezgAhmeWgAADevgGgAhfeWgAABgAgAgAhfeWgAABgAgAgAhfeWgAABgAgA]],
				Jaw = [[
					gAhWeB/9gAgAhSgAhReC/5gAgAihgAhHeD/jgAgAlUgAhAeF/FgAgAnjgAhBeE/LgAgAnKgAhieB/mf6gWlBgBiGeC/PfZgtm0f+iKeD+khUelpNgBiMeD/A
					fngZn3gCiNeD/Ge8hBnWf+iLeD+nhNetpIgAiMeC+7gAgAoKgCiNeD/IethOnLf+iLeC+rhBe7o+f/iMeC+2gZfnoegCiNeD/IemhVnFf/iLeC+wgvfPovf/
					iKeC+zgtfPomgCh5eB/lfZhDk9gAheeB/5gBf7ibgAhWeB/9gAgAhSgAhWeB/9gAgAhSgAhWeB/9gAgAhS]],
				["Cheek.L"] = [[
					fXhfdggAJZgA2nfXhZdifWJZgq2nfXhMdmd2JfiK2hfXhBdpcpJpjX2XfXhDdoc3JnjJ2ZfYhwdjhRJLet2VfaifdolXJcaV1SfRifdulZLWbO3VfZimdql+
					J2Z11afcipdqmIJWZS0qfRigdulcLPbJ3NfXildrl3KKaJ12fdiqdpmLJMZH0afSihdtlhLDa+2/fVijdslvKfad2SfeirdpmMJHZB0SfUiidtlnKyaw2rfU
					ihdslgKwa22rfbiPdjkDI9bp1XfXhqdhg6JefH2qfXhfdggAJZgA2nfXhfdggAJZgA2nfXhfdggAJZgA2n]],
				["Cheek.R"] = [[
					gphfdggA2ngA2ngphZdifW2nfW2ngphMdmd22hd22hgphBdpcp2Xcp2XgphDdoc32Zc32ZgqhvdlhT2VhR21gsiddslr1SlX2kgiikdlky3VlZ0qgrildtmL
					1al+2Kguildwmu0qmI2qgjikdmk33Nlc0xgpildrl312l312gvildxm50amL20gkikdnlC2/lh09gnildplj2Slv1hgvildxm/0SmM25glikdolQ2rln1Ogl
					ijdnlK2rlg1QgtiNdpkX1XkD3Dgphrdhg52qg62igphfdggA2ngA2ngphfdggA2ngA2ngphfdggA2ngA2n]],
				["FinF1.L"] = [[
					eqhRe2nhG8gAyaeqhOe2oMHqgmzEeqhJe3pgJciC0feqhFe3qYLDjT1leqhGe3qOKwjE1ZeqhZe2mHGTehx+eqhue2gmEQa2vCeqhye2dPEbZIuZeqhye2fH
					ELaEukeqhye2f0EGabuneqhye2dWEaZLuaeqhye2etENZ2uieqhye2gDEFaiuoeqhye2dlEXZTuceqhye2eSERZpugeqhye2gLEFamuoeqhye2d5EUZdueeq
					hxe2eHEUZjuieqhme2jIEtcYv/eqhWe2mQGMe2xzeqhRe2nhG8gAyaeqhRe2nhG8gAyaeqhRe2nhG8gAya]],
				["FinF2.L"] = [[
					eOhIesltLBgA3deOhEetmOLzgx4AePg7exnJNtil5HeRgze1nsPZkH56eQg1e0nmPFj15xeNhVerj6KTdZ3BeRh2emeXIYXIzmeTiAembQI4UnyUeSh9emc5
					IcVzy0eRh7emdgITWQy/eTiAembXI2UsyXeSh9emciIiViyueRh7emdtIRWazCeTh/embjIyU1ybeSh+emcKInVRyneRh7emd0IQWfzEeTh/emb1ItVBygeS
					h+emcDIsVNypePhpeng9IqZy08eOhReqkYKMeL26eOhIesltLBgA3deOhIesltLBgA3deOhIesltLBgA3d]],
				["FinF1.R"] = [[
					hWhRe2nh5EgAyahWhOe2oM4WfazEhWhJe3pg2kd+0fhWhFe3qY09ct1lhWhGe3qO1Qc81ZhWhZe2mH5thfx+hWhue2gm7wlKvChWhye2dP7lm4uZhWhye2fH
					71l8ukhWhye2f076llunhWhye2dW7mm1uahWhye2et7zmKuihWhye2gD77leuohWhye2dl7pmtuchWhye2eS7vmXughWhye2gL77lauohWhye2d57smjuehW
					hxe2eH7smduihWhme2jI7Tjov/hWhWe2mQ50hKxzhWhRe2nh5EgAyahWhRe2nh5EgAyahWhRe2nh5EgAya]],
				["FinF2.R"] = [[
					hyhIeslt0/gA3dhyhEetmO0NfP4Ahxg7exnJyTdb5Hhvgze1nswnb556hwg1e0nmw7cL5xhzhVerj61tin3Bhvh2emeX3oo4zmhtiAembQ3IrZyUhuh9emc5
					3kqNy0hvh7emdg3tpwy/htiAembX3KrUyXhuh9emci3eqeyuhvh7emdt3vpmzChth/embj3OrLybhuh+emcK3Zqvynhvh7emd03wphzEhth/emb13Tq/yghu
					h+emcD3Uqzyphxhpeng93WmO08hyhReqkY10h126hyhIeslt0/gA3dhyhIeslt0/gA3dhyhIeslt0/gA3d]],
				Tail1 = [[
					gAhXgAgAgAgA//gAhWgAgHgAgA//gAhSgAgWgAgA//gAhQgAgigAgA//gAhQgAgggAgA//gAhegAflftgA//gAhtgAeigzf+/8gAhwgAeVhqf6/5gAhwgAeV
					gef+/8gAhwgAeVevgE/7gAhwgAeVefgF/6gAhwgAeVgAgA/8gAhwgAeVhhf7/6gAhwgAeVhRf8/7gAhwgAeVfigC/8gAhwgAeVeWgG/5gAhwgAeVfGgD/7gA
					hvgAeXg5f9/8gAhngAe8hDf+/9gAhbgAfvgFgA//gAhXgAgAgAgA//gAhXgAgAgAgA//gAhXgAgAgAgA//]],
				Tail2 = [[
					gAhXgegAgAgA//gAhWgegUgAgA//gAhSgehBgAgA/+gAhPgehlgAgA/8gAhPgehfgAgA/9f/hegee6fLgB/9gChwgecGgugC/vgDhzgebkjIf3/hgBhzgebj
					hyf1/of+hzgebjeXgB/of9hzgebkc3gL/hgAhzgebjfCgJ/qgDhzgebjiVf8/mgChzgebki6f0/jf/hzgebjgFf6/rf9hzgebkdKgH/jf+hzgebjdjgM/lgC
					hygebpgzgD/rgChpgedMh+f8/zgAhcgefTgSgA/+gAhXgegAgAgA//gAhXgegAgAgA//gAhXgegAgAgA//]],
				Tail3 = [[
					gAhXg9gAgAgA//gAhVg9ghgAgA//gAhQg9hsgAgA/8gAhMg8ipgAgA/4gAhMg8iegAgA/5f+hgg8ePeogC/6gDh3g7ZrfzgR/XgJh7g7Y1j1f9+8gEh7g7Y1
					jbfn+/f7h7g7Y0fAfu/Kf3h7g7Y1bxgK+4f+h7g7Y0dega/EgHh7g7Y0iJgM/GgIh7g7Y1kUfw+4f/h7g7Y0hcfn/If4h7g7Y1c4f7/Bf6h7g7Y1b+gV+6gD
					h7g7Y9fygW/NgGhug8bcicf//kgBhdg9e3gjf//9gAhXg9gAgAgA//gAhXg9gAgAgA//gAhXg9gAgAgA//]],
				Tail4 = [[
					gAhXhbf2gAgA//gAhUhbglgAgA//gAhNhbiOgAgA/6gAhHhajjgAgA/ygAhIhajTgAgA/0f7hkhadbeRgB/1gCiDhXXLeagp+sgQiIhVWBjjgZ+LgLiIhWWB
					kwfh+Bf5iJhWWBgZfM+YfviIhVWBblf1+Ef5iJhWWBb8gq+HgLiJhWWBhDgu+XgQiIhVWBk7f89/gCiJhWWBjEfP+OfyiIhVWBdnfb+SfyiIhVWBa+gS9+gD
					iIhXWNePgz+ZgKh3hYZkiQgK/QgChfhbeRgxf//7gAhXhbf2gAgA//gAhXhbf2gAgA//gAhXhbf2gAgA//]],
				Tail5 = [[
					gAhYh5fTgAgA/+gAhTh5gOgAgA//gAhIh5iVgAgA/6gAhAh4kCgAgA/vgAhBh4jvgAgA/xf4hph4cNePf9/tf/iThxUXdEg79ogWiahtS9iYhN9FgTiahtS8
					lSfz8uf6ibhvS9iCeo9GfoiahsS9cZfE89fyiahtS8a/gm8xgNibhuS9fchc9KgZiahsS9kkgm81gIiahuS9kWfE83fuiahtS9fDeo9KfpiahsS8a4fz8wf/
					iZhvTMcvhK9GgOiDh0XVhggg+wgDhih5dRg3gB/3gAhYh5fTgAgA/+gAhYh5fTgAgA/+gAhYh5fTgAgA/+]],
				["FinB1.L"] = [[
					euhPghkpPygA7LeuhOghlDQng17keuhLghlySlix8UeuhIghmKURkZ8yeuhJghmHT9kG8teuhVghjvPMeK65euhjggf1MdY74UeuhlggdYMdWM3Meuhlggeu
					MOXv3teuhlggfPMKYU33euhlggdeMcWS3PeuhlggebMRXZ3meuhlggfZMJYh37euhlggdoMaWe3TeuhlggeIMUXD3feuhlggffMIYn38euhlggd3MXWu3Zeu
					hlggeBMZW53feuhdgghqNKbK5VeuhTghj0O/ee6xeuhPghkpPygA7LeuhPghkpPygA7LeuhPghkpPygA7L]],
				["FinB2.L"] = [[
					eUhIgujbSDgA8leWhFgvjxS4g686eZg/gykUU0i+9gecg7g1kkWeks91ebg8g0kiWLkY9yeThRgtiNRcdE8PeShrgoeRO8Vz5AeVh0gncAPJSp3VeThxgndM
					OzUN4GeThvgndoOtUz4WeVh0gncEPISv3YeUhygnc7O4T237eThvgndyOrU/4beVh0gncOPFS73feUhygncqO8Tg3xeThvgnd3OqVG4eeUhzgncaPBTM3neU
					hygnclPCTa3xeShggpgHPgY66eeThOgtihRRd58MeUhIgujbSDgA8leUhIgujbSDgA8leUhIgujbSDgA8l]],
				["FinB1.R"] = [[
					hShPghkpwOgA7LhShOghlDvZfL7khShLghlytbdP8UhShIghmKrvbn8yhShJghmHsDb68thShVghjvw0h265hShjggf1zjnF4UhShlggdYzjp03MhShlggeu
					zyoR3thShlggfPz2ns33hShlggdezkpu3PhShlggebzvon3mhShlggfZz3nf37hShlggdozmpi3ThShlggeIzso93fhShlggffz4nZ38hShlggd3zppS3ZhS
					hlggeBznpH3fhShdgghqy2k25VhShTghj0xBhi6xhShPghkpwOgA7LhShPghkpwOgA7LhShPghkpwOgA7L]],
				["FinB2.R"] = [[
					hshIgujbt9gA8lhqhFgvjxtIfG86hng/gykUrMdC9ghkg7g1kkpibU91hlg8g0kip1bo9yhthRgtiNuki88PhuhrgoeRxEqN5Ahrh0gncAw3tX3VhthxgndM
					xNrz4GhthvgndoxTrN4Whrh0gncEw4tR3Yhshygnc7xIsK37hthvgndyxVrB4bhrh0gncOw7tF3fhshygncqxEsg3xhthvgnd3xWq64ehshzgncaw/s03nhs
					hygnclw+sm3xhuhggpgHwgnG6ehthOgtihuviH8MhshIgujbt9gA8lhshIgujbt9gA8lhshIgujbt9gA8l]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Spine1 = [[
					gAhXgAACgAgAg6gAhXgAABgAgJgmgAhXgAABgAgNgcgAhsgAABgAgJgmgAh/gAACgAgBg4gAiPgAACgAf5hLgAiagAADf/fzhYgAiggAADf/fzhZgAiggAAD
					gAf3hOgAiagAACgAf/g8gAiPgAABgAgHgqgAh/gAABgAgNgdgAhsgAABgAgNgcgAhXgAABgAgJgmgAhXgAACgAgBg4gAhXgAACgAf5hLgAhXgAADf/fzhYgA
					hXgAADf/fzhZgAhXgAACgAf5hLgAhXgAACgAgAg7gAhXgAACgAgAg6]],
				Spine2 = [[
					gAhZflACgAgAg6gAhYflABgAgQgWgAhYflABgAgUgMgAhtflABgAgKgjgAiBflACgAf8hEgAiRflADf/fwhhgAidflAEf/fqhvgAijflAEf/fshpgAiiflAD
					gAf2hRgAicflACgAgEgxgAiQflABgAgQgUgAiAflABgAgXgGgAhtflABgAgUgMgAhYflABgAgKgjgAhZflACgAf8hEgAhZflADf/fwhhgAhaflAEf/fqhvgA
					haflAEf/fshpgAhZflACgAf4hNgAhZflACgAgBg4gAhZflACgAgAg6]],
				Spine3 = [[
					gAhafLADgAgAhff/hZfLACgBgTgzf/hYfLACgBgVgugAhufLADgAgHhPgAiCfLAEf/f2h3gBiTfLAHf/fpiVgBiffLAHf+flifgBilfLAGf/friRgAikfLAE
					gAf5hwgAidfLACgAgKhIf/iRfLACgBgXgqf/iAfLABgBgbgff/htfLACgBgVgugAhZfLADgAgHhPgAhbfLAEf/f2h3gBhcfLAHf/fpiVgBhcfLAHf+flifgB
					hcfLAGf/friRgAhbfLAEgAf6htgAhafLADgAgDhZgAhafLADgAgAhf]],
				Spine4 = [[
					gAhdewAEgAgAhmf/haewACgBgUg4f/haewACgBgUg3f/hwewADgAgEhcgAiFewAFf/fziFgBiXewAIf/fmiigCikexAIf+fkiogBipewAHf/fsiVgBinewAE
					gAf8hwgAifewACgBgNhHf/iSewACgBgagqf+iBewACgBgcgkf/huewACgBgUg3f/hbewADgAgEhcgAheewAFf/fziFgBhgewAIf/fmiigChhexAIf+fkiogB
					hgewAHf/fsiVgBheewAEgAf9hugAhdewADgAgEhdgAhdewAEgAgAhm]],
				Head = [[
					gAhfeWgAABgAgAf+hceVgAABgkgPf+hbeVgAABgdgLf/hyeVgAABf8f9gBiJeWgAABfcfwgCiceWgAACfJfpgCioeWgAACfMfrgCiteWgAABfjf1gBiqeWgA
					ABgEgDf/iheVgAABgkgQf+iTeVgAACg3gXf+iCeVgAACg0gVf+hweVgAABgdgLf/heeVgAABf8f9gBhheWgAABfcfwgChkeWgAACfJfpgChleWgAACfMfrgC
					hkeWgAABfjf1gBhheWgAABgEgDgAhfeWgAABgKgFgAhfeWgAABgAgA]],
				Jaw = [[
					gAhWeB/9gAgAhSf+hReB/FgDfynjf+hReB+agEf2p8f/hpeB+kf/gDpcgBiAeB+tf7gPo9gCiTeB+yf5gWosgDifeB+xf6gUovgCikeB+rf9gLpEgBigeB+h
					gBf9plf/iWeB+XgFfxqDf+iIeB+SgHfqqUf9h3eB+SgHfsqSf+hleB+agEf2p8f/hUeB+kf/gDpcgBhYeB+tf7gPo9gChbeB+yf5gWosgDhceB+xf6gUovgC
					hbeB+rf9gLpEgBhXeB+9gBf+oDgAhVeB/xgBf7jzgAhWeB/9gAgAhS]],
				["Cheek.L"] = [[
					fXhfdlgAJZgA2nfVhadofnJjgZ2xfVhadnfsJhgV2vfWhzdjgDJWf92lfZiLdigaJNfm2cfaiedkgnJJfa2XfaiqdnglJKfc2YfaiudngVJRfs2ffYiqdjf9
					JbgD2qfWifdjfmJkga2zfUiQdmfaJpgn23fUh/dofcJogl22fVhudnfsJhgV2vfWhedjgDJWf92lfZhjdigaJNfm2cfahmdkgnJJfa2XfahndnglJKfc2Yfa
					hldngVJRfs2ffYhhdjf+JagD2pfXhfdif5JcgH2rfXhfdlgAJZgA2n]],
				["Cheek.R"] = [[
					gphfdlgA2ngA2ngnhadnfn2xfn2dgmhadmfr2vfs2fgohzdjgD2lgD2qgqiLdjga2cga2zgsiedmgm2Xgn23gsiqdpgk2Ygl22griudngU2fgV2vgqiqdjf9
					2qf92lgnifdhfm2zfm2cgmiQdkfZ23fa2Xgmh/dnfb22fc2Ygmhudmfr2vfs2fgohedjgD2lgD2qgqhjdjga2cga2zgshmdmgm2Xgn23gshndpgk2Ygl22gr
					hldngU2fgV2vgphhdjf92pf+2mgphfdif52rf52kgphfdlgA2ngA2n]],
				["FinF1.L"] = [[
					eqhRe2nhG8gAyaephPe4hxGPbRyRephOe4ebFOfnxaephke3m4GGkfw4eqh5e2sIJKhtyveriLe1n2IVZoy/eriXe0gOGPX6xIeride0fOE7eXw7eribe1nN
					F2j+weeqiTe3r+JQh3y8epiGe4nBIaaZzpeph1e5fLGPZPxrephje4ebFOfnxaephPe3m4GGkfw4eqhRe2sIJKhtyverhTe1n2IVZoy/erhUe0gOGPX6xIer
					hUe0fOE7eXw7erhSe2nTGDjRw5eqhRe2o1HgghykeqhRe2nhG8gAya]],
				["FinF2.L"] = [[
					eOhIesltLBgA3deMhUeugDKuZO25eNhQesaXI/az02eRhWerj/Jcjy2AeRhpessROKlY27eNiLeupTM/b83peRijere4K/VN1ieQigenbbI2Zp0oeSiOeokc
					JJjU1seRiDeusEOTlg3HeLiGeyoWNPcg4ReNiBevdiK8WU16eNhlesaXI/az02eRhBerj/Jcjy2AeRhBessROKlY27eNhTeupTM/b83peRhgere4K/VN1ieQ
					hXenbbI2Zp0oeRhFeoksJgiw2FePhGesnmLxhm3ieOhIesltLBgA3d]],
				["FinF1.R"] = [[
					hWhRe2nh5EgAyahVhPe1h26Dktx4hVhOe1ec7Igbw4hVhke2m16EbdwohWh5e3sJ2xeXy1hXiLe3nv3YmfzXhXiXe4gE5ZoGxshXide4fN6vhoxdhXibe3nP
					6AcHwuhWiTe2r921eGy3hViGe1nH36lfzRhVh1e1fV6KmyxHhVhje1ec7Igbw4hVhPe2m16EbdwohWhRe3sJ2xeXy1hXhTe3nv3YmfzXhXhUe4gE5ZoGxshX
					hUe4fN6vhoxdhWhSe3nV51cyxGhWhRe2o14hfeyihWhRe2nh5EgAya]],
				["FinF2.R"] = [[
					hyhIeslt0/gA3dhyhUergK1pmy2khwhQenae3blU0ZhuhWepj92ycM1yhvhpetsSxwar2/h1iLeypPyokN38hzijewep0iqx1/hzigerbU2wmR1FhviOeqke
					2pcv16hviDetsDxzad3ChziGevoZzKjX3+hviBeqdw1ipv1chwhlenae3blU0ZhuhBepj92ycM1yhvhBetsSxwar2/h1hTeypPyokN38hzhgewep0iqx1/hz
					hXerbU2wmR1FhwhFeqku2VdT2QhxhGesnl0Qea3hhyhIeslt0/gA3d]],
				Tail1 = [[
					gAhXgAgAgAgA//gAhXgAfpgKgA//gAhXgAe6gegB/+gAhsgAexgigB/9gAh/gAfFgZgB/+gAiPgAfwgHgA//gAiagAghfygA//gAiggAhGfigB/+gAiggAhP
					fegB/9gAiagAg7fngB/+gAiPgAgQf5gA//gAh/gAffgOgA//gAhsgAe6gegB/+gAhXgAexgigB/9gAhXgAfFgZgB/+gAhXgAfwgHgA//gAhXgAghfygA//gA
					hXgAhGfigB/+gAhXgAhAfkgB/+gAhXgAgRf5gA//gAhXgAgAgAgA//]],
				Tail2 = [[
					gAhXgegAgAgA//gAhYgegKf8gA//gBhZgeeugjgB/9gBhugedsg/gC/5gBiBgedjhDgD/4gAiPgeeWgtgC/8gAiZgefxgGgB//f/iegehSfdgB/9f/iegeiU
					fBgC/5f/iZgeide9gD/4gAiPgehqfTgC/8gAiAgegPf6gB//gBhugeeugjgB/9gBhagedsg/gC/5gBhZgedjhDgD/4gAhYgeeWgtgC/8gAhWgefxgGgB//f/
					hVgehSfdgB/9f/hVgeh4fNgB/7gAhXgegsftgA/+gAhXgegAgAgA//]],
				Tail3 = [[
					gAhXg9gAgAgA//gAhYg9hefYgC/8gChcg8fpgKgB//gDhzg8dThKgC/2gDiFg8b/hugF/sgCiTg8cNhogG/ugAiag9d4g6gE/6f+icg8gXf2gB//f9iag8it
					e2gC/2f9iUg8kBeSgF/sf+iLg8jzeYgG/ugAiAg9iIfGgE/6gChxg8fpgKgB//gDheg8dThKgC/2gDheg8b/hugF/sgChbg8cNhogG/ugAhXg9d4g6gE/6f+
					hTg8gXf2gB//f+hSg8iNfEgB/5f/hVg9hJfhgA/9gAhXg9gAgAgA//]],
				Tail4 = [[
					gAhXhbf2gAgA//f/hVhbjOekgE/zgChchbh0fKgG/7gFh4haeKgvgD/7gGiNhZbKiBgG/jgFiahaZ9iigL/UgBiehba/iFgL/hf+ibhbd4g2gG/6f7iUhahj
					fRgD/8f6iMhZkjd/gF/mf7iEhalvdegJ/Xf/h8hbktd7gK/kgChxhbh0fKgG/7gFhjhaeKgvgD/7gGhlhZbKiBgG/jgFhihaZ9iigL/UgBhbhba/iFgL/hf+
					hShbd4g2gG/6f8hOhahOfagC/9f+hThbhMfbgA/9gAhXhbf2gAgA//]],
				Tail5 = [[
					gAhYh5fTgAgA/+f8hPh4kidwgF/lgBhZh5kndvgM/kgGh7h4gUflgJ//gKiWh2bphlgI/pgJilh1Yai9gP+7gFinh3XzjOgV+wf/ifh5aAiQgT/Vf6iRh4eR
					gbgK/8f2iEh2i9ebgE/0f3h6h2mOdDgG/Pf7hzh3m1cygM/FgBhuh5kndvgM/kgGhnh4gUflgJ//gKhuh2bphlgI/pgJhth1Yai9gP+7gFhkh3XzjOgV+wf/
					hWh5aAiQgT/Vf7hLh4edgWgH/8f9hRh5gVfjgA//gAhYh5fTgAgA/+]],
				["FinB1.L"] = [[
					euhPghkpPygA7LeuhQgileP3jr60evhQginzS3fq8GeuhlgijgQ2XO6ieuh3ghdpOuX65keuiGggfZNCf05weuiRgfmkPek46IeuiXgfopShfY7seuiXggkG
					QzW96VeuiSghdtOtX45jeuiHghe+NOgI53evh4gil4P8lR6hevhlginzS3fq8GeuhQgijgQ2XO6ieuhPghdpOuX65keuhPggfZNCf05weuhOgfmkPek46Ieu
					hOgfopShfY7seuhPggkLQnYr6weuhPghiwPMdp6+euhPghkpPygA7L]],
				["FinB2.L"] = [[
					eUhIgujbSDgA8leWhEgvkhSPk+8FeZhEgyopVfjj8veVhngxjUTXXp7+eViDgtblRVUL5eeRiHgpdPO0cr6oeWiCgrluR4mz7SeYiKgupdVCjW8VeUiZgvj8
					TTXb7zeViegtbpRVUJ5deSiJgrcyO9c+6teXhqgvlBSanI7neZhYgyopVfjj8veVhSgxjUTXXp7+eVhbgtblRVUL5eeRhQgpdPO0cr6oeWg/grluR4mz7SeY
					hBgupdVCjW8VeUhPgvjzTHZE8LeThNguhRRfch8QeUhIgujbSDgA8l]],
				["FinB1.R"] = [[
					hShPghkpwOgA7LhShQgglcwYcS6rhShQggnztggP77hShlggjlvYow6ahSh3ghdqxUoG5jhSiGghfZyygM54hRiRghmowNbN6VhRiXgiootIgv72hSiXghkB
					u/pF6dhSiSghdtxRoI5khSiHgge+y+f45vhSh4ggl0wZaq6UhShlggnztggP77hShQggjlvYow6ahShPghdqxUoG5jhShPghfZyygM54hRhOghmowNbN6VhR
					hOgiootIgv72hShPghkHvNnX62hShPghiww0iX6+hShPghkpwOgA7L]],
				["FinB2.R"] = [[
					hshIgujbt9gA8lhrhEgtkfuBa/79hohEgwomq4cW8mhshngwjZs4oV73hriDgtbmusr15dhuiHgqdOxAjU6whpiCgtlztzZR7dhniKgxpgqncy8dhriZgxj3
					seon76hriegtboupr35ehviJgpczxPjD6lhqhqgsk7t7Y07chohYgwomq4cW8mhshSgwjZs4oV73hrhbgtbmusr15dhuhQgqdOxAjU6whpg/gtlztzZR7dhn
					hBgxpgqncy8dhrhPgxjwstm+8RhthNguhRuhjf8RhshIgujbt9gA8l]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAhXgAACgAgAg6gAhXgPAIgAgAingAhXgYAPgAgAjsgAhXgWANgAgFjZgAhXgRAJgBfli2gAhXgMAKgCd/iOgAhXgIAIfheTh2gAhZgHAXbtfshwgAhrgFCB
					U8gWhRgAiNgBGSNAgeg2gAi5gANDGQgvgjgAjmgAUjCKg3gVgAkMgAadAhg6gKgAkigAdJAKg6gFgAklgAdRAJg6gFgAkbgAdfAIg6gFgAkWgAd3AGg6gEgA
					kegAeUAFg6gDgAkmgAezADg6gCgAkmgAfSACg6gBgAkmgAfqACg6gBgAkmgAf6ACg6gAgAkmgAgAACg6gA]],
				Spine2 = [[
					gAhZflACgAgAg6gAhcf1AIgAgAingAhdf+APgAgAjsgAhdf8ANgAgFjZgBhcf3AJgBfli2gDhbfxAKgCd/iOgDhafuAIfheTh2gAhcftAXbtfshwf/htfqCB
					U8gWhRf/iOfnGSNAgeg2f/i5flNDGQgvgjf/jlflUjCKg3gVf/kKfladAhg6gKgAkgfldJAKg6gFgAkjfldRAJg6gFgAkZfldfAIg6gFgAkUfld3AGg6gEgA
					kdfleUAFg6gDgAkkflezADg6gCgAkkflfSACg6gBgAkkflfqACg6gBgAkkflf6ACg6gAgAkkflgAACg6gA]],
				Spine3 = [[
					gAhafLADgAgAhfgAhgfaALgAgAjLgAhkfkATgAgAkRgAhjfiARgAgFj+gBhhfcANgAfljagHhffXANf/d/izgGhefTAKffeUibgAhffSAZbtfxiUf9hufPCD
					U8gjh0f9iOfMGUNBg0hUf9i4fLNEGRhNg5f+jkfLUjCLhZgif/kJfLadAihegRf/kffLdJALhfgJf/kifLdRALhfgIgAkYfLdgAKhfgHgAkTfLd3AIhfgGgA
					kbfLeUAGhfgFgAkjfLezAFhfgEgAkjfLfSAEhfgCgAkjfLfqADhfgBgAkjfLf6ADhfgAgAkjfLgAADhfgA]],
				Spine4 = [[
					gAhdewAEgAgAhmgAhlfAAMgAgAjSgAhrfLAUgAgAkXgAhpfIASgAgFkFgChmfCAOgAfljhgKhje9AOf/d/i6gIhie5ALfeeUiigAhje4Aabtfyibf8hxe1CE
					U8glh6f7iPexGUNBg4hZf7i3ewNEGShSg8f8jiewUjCLhfglf+kGewadAjhkgSf/kcewdJAMhmgJf/kfewdRALhmgJf/kVewdgAKhmgIf/kQewd3AIhmgHf/
					kZeweUAGhmgFgAkgewe0AFhmgEgAkgewfSAEhmgCgAkgewfqAEhmgBgAkgewf6AEhmgAgAkgewgAAEhmgA]],
				Head = [[
					gAhfeWgAABgAgAgAhremgAAUbngAgAhyexgAA1Y1gAf/hweugBArZkgLgDhseof8AbbBfDgNhoejfyAhcmbegLhmefgXAWdlcMgAhnedkRAYd2fWf6h0earF
					CBfKgff4iQeXzAGSgTfqf4i3eW5vNDgye8f7jgeW90UkgseNf9kEeW/aaegbdnf/kaeW/vdJgQdSf/kdeW/wdSgPdPf/kTeW/ydggNdYf/kOeW/0d3gLdcf/
					kWeW/1eUgJdUf/keeW/2e0gHdOgAkeeW/3fSgEdOgAkeeW/3fqgCdOgAkeeW/3f6gAdOgAkeeW/3gAgAdO]],
				Jaw = [[
					gAhWeB/9gAgAhSgAhneQ/7gAgAh9gAhyea/5gAgAiZf/hveX/6gEf2iRgEhpeS/6fug7iDgThjeO/nfDkbhxgQhfeK/uf4j1hkgDhgeI/qkKhKhkf/hteF96
					rEguibgCiNeD5iy2icjJgDi6eCyp5UkujfgDjpeCrH87nbi2gCkQeDlT+CpghrgBkneDit+Dqmg9gBkqeDil+Aqvg7gBkgeDiY+LqTg0gBkaeDiC+SqFgrgB
					kjeDhm+LqegkgAkreDhI+Fq0gagAkreDgs+Gq1gQgAkreDgV+Gq1gHgAkreDgF+Gq1gCgAkreDgA+Gq1gA]],
				["Cheek.L"] = [[
					fXhfdggAJZgA2nfXh4d2jGJmc62afXiGeIlEJ9a82DfWiCeEkkJ+be2Sfdh7d5jfJAcb1qf0h0dqiQGjdczEfvhtdlh+G7ejztfahjdnkjJLhg15fYhbdmoc
					LJnP1jfuhpdhtONktqx8gJiRdhxpR2ywspgdjJdh0mWp1km0gmj9dh16aZ2giOgokbdh2RcE2ngGgokfdh2ScI2nf+gpkVdh2VcY2nf6gpkRdh2Ycr2nftgp
					kbdh2ac62nfTgpkkdh2cdM2me4gpkldh2fdh2kejgpkmdh2hdy2jeRgpkndh2id+2ieGgpkndh2ieC2ieC]],
				["Cheek.R"] = [[
					gphfdggA2ngA2ngph4d2jG2ajG2agpiGeIlE2DlE2DgoiCeDki2Skk2Cgvh6d+jl1qjf3AhChweBikzEiQ5dg/hud4hdzth+5Fgph5dseg15kj21gWiQdlYx
					1joc03gGi3diSWx8tOycfwjfdhNQspxpuKfgkAdhKcm00mpXfZkZdhJgiO16lnfYkqdhJZgG2Rj8fYktdhJZf+2Sj4fYkidhJZf62VjofXkbdhJZft2YjVfX
					kjdhJZfT2ajGfXkqdhJae42ci0fXkpdhJcej2fiffXkodhJdeR2hiOfXkndhJeeG2iiCfXkndhJeeC2ih+]],
				["FinF1.L"] = [[
					eqhRe2nhG8gAyaeqhZfFlHGVcNyAeqhefPjfGXZyxveqhcfNj7GXabx3eshafFkyGEbuxme0hYe3lsFSdUwbezhTe1mrFqehwzewhAe6pzHWgvx2fCgwe6vS
					KolfxZftg6e31LQhrCumgghpe24/YOvQqShEiye26KfnxjljhTj0e25rlByUh0hWkZe25GnayagFhWkde25Dnjyaf+hWkUe25Cnnyaf7hWkRe249n2yafxhW
					kce240oTyZfbhWkme24qowyYfFhWkpe24hpIyXe0hWkre24apayWemhWkse24VpnyVedhWkte24UpryVeZ]],
				["FinF2.L"] = [[
					eOhIesltLBgA3deNhZe6kIKpbx3EeNhkfFjCKzZF2veNhhfDjUKyZy24ePhce6j7KWbN2teZhWepkkJOc41weXhPenlRJkeR2HeWg0evn0LNhK2/exgYevsD
					Nvmx2VftgdeswrR5tPzRgyhSesz8XVyTurhgioes1ech1Wpuhwj3es1vgV2ul0hykhes1qh+3GkGhykles1qiC3HkBhykces1oiR3Kjxhykaes1mik3Njdhy
					kmes1kiz3PjNhxkxes1ijE3Si7hxk1es1fjY3Uilhwk3es1cjo3WiThwk5es1ajz3XiHhwk6es1aj33XiD]],
				["FinF1.R"] = [[
					hWhRe2nh5EgAyahWhZfFlH5rjzyAhWhefPjf5pmOxvhWhcfMj75vllxvhYhZfJkw5ckXyShfhWfNll4YjNzrhdhXfIl04iinzghWhtfAi85wkWyOhFife7dx
					6DnPw8ggjee4Xg4sq3u9ftkNe2RK1juXrhfFkle2MTxOwwnoexkve2Jmtgx1kketk4e2IprxyIjNesk6e2InrtyIjKeskve2IercyKi9eskoe2IUrIyNiter
					kue2INq4yPiherkze2IFqlyRiSeqkwe2H7qOyTiBeqkue2Hzp8yUhzeqkte2HupvyVhqeqkte2HspryVhn]],
				["FinF2.R"] = [[
					hyhIeslt0/gA3dhzhZe6kI1XkP3EhzhkfFjC1Nm72vhzhhfCjV1VmO2xh1hbfAj31Ck13Sh9hUfGkYz0jd4fh7hUfAkg0Di24Whzhxe2iE1VlP3KhfitexdW
					1jpd1ggwj2euXhz8uqyafvkqesRzwezdtHe4k/esNurx2XnFedlEesLsnv3WiTeVlJesLDlz3dgGeVlLesLBls3df+eUk/esLAlo3df6eTk4esK8lc3dfseT
					k+esK2lD3cfReSlCesKxkq3be1eRk/esKskW3aefeQk8esKpkG3ZeNeQk6esKnj73YeBeQk6esKmj33Xd9]],
				Tail1 = [[
					gAhXgAgAgAgA//gAhXgPhsgAgA/8gAhXgYiygAgA/3gAhXgWifgIgB/5gAhXgRh7fUf9/7gAhXgMhUcuf3/ygAhXgIg9dOga/2gAhZgHg3fYkS/rgAhrgFgR
					gIrF+AgAiNgBf3fxzA5vgAi5gAfsfl5wy9gAjmgAfufS92rdgAkMgAf1fD/fljgAkigAf6e6/2i3gAklgAf6e5/2ivgAkbgAf7e9/4ihgAkWgAf8e+/5iJgA
					kegAf8e7/7hsgAkmgAf9e5/8hNgAkmgAf+e5/9gugAkmgAf/e5/+gWgAkmgAgAe5/+gGgAkmgAgAe5/+gA]],
				Tail2 = [[
					gAhXgegAgAgA//gAhUgthsgAgA/8gAhSg2iygAgA/3gAhTg0ifgLgB/5f/hUgvh7fCf8/6f6hVgphUbef0/pf7hVgmg+cLgY/vf/hXglg4fLkR/rgAhqgjgH
					gOrF+Af/iNggfofmzA5uf/i5gefYfK5wy9f/jlgefdek91rdf/kKgefqeF/cljgAkggefzd1/yi3gAkjgef0dy/ziugAkZgef1d5/0iggAkUgef3d9/2iJgA
					kcgef5d3/4hsgAkkgef7dx/5hMgAkkgef9dx/5gugAkkgef+dx/6gWgAkkgegAdx/6gGgAkkgegAdx/6gA]],
				Tail3 = [[
					gAhXg9gAgAgA//gAhRhLhsgAgA/8gAhNhUiygAgA/3gBhOhSifgOgB/5f9hQhNh7exf7/6fxhShGhTaOfx/bf0hUhDg+bHgW/mf+hVhEg5e+kR/rgBhqhBf+
					gUrF+Af+iNg+fZfczA5uf9i4g9fEeu5uy8f9jjg8fLd29yrcf+kGg8fgdI/Ylif/kcg8ftcv/si2f/kfg8fucs/siuf/kVg8fwc2/vigf/kQg8fzc7/xiJf/
					kYg8f1cy/yhsgAkgg8f4cq/yhMgAkgg8f7cq/zgugAkgg8f+cq/0gWgAkgg8f/cq/0gGgAkgg8gAcq/0gA]],
				Tail4 = [[
					gAhXhbf2gAgA//gAhOhphigAgA/9gAhIhyiogAgA/4gBhJhwiVgRgB/5f7hMhrhxegf6/6fnhQhihJY/fr/MfqhShgg1aEgS/bf8hThigxewkQ/rgBhrhffr
					gWrF+Af9iNhcfCfLy/5tf6i3hbeqeL5sy7f6jghae2c/9traf8kBhafTcC/Qlgf+kWhafmbg/ii2f+kZhafnbc/iitf+kPhafqbq/miff+kKhafubw/oiIf/
					kShafxbk/ohrf/kZhaf1ba/ohMf/kZhaf5bZ/pgugAkZhaf9bZ/qgWgAkZhaf/bZ/qgGgAkZhagAbZ/qgA]],
				Tail5 = [[
					gAhYh5fTgAgA/+gAhLiHg/gAgA/+gAhDiQiEgAgA/7gChFiOhygUgC/8f4hJiJhOePf3/6fahOh+gmXxff+5ffhQh8gTZBgI/Of6hSiAgPeekO/rgChrh+fB
					gQrG9/f7iOh6eWesy95rf2i2h5eBdU5ny3f2jbh4eYbw9krWf6j6h3fCai/Blef8kNh3fdZ5/Ri0f8kQh3feZz/Rirf9kHh3fiaE/Vief9kCh3fnaM/YiHf+
					kKh3fsZ9/Xhqf+kRh3fxZw/WhLf/kRh3f3Zw/XgugAkRh3f8Zw/XgVgAkRh3f/Zw/YgGgAkRh3gAZw/YgA]],
				["FinB1.L"] = [[
					euhPghkpPygA7LeuhMgvj4Phbi6xeuhKg3jVPvYt6WeuhKg1jePtZd6hethMgujzPLa76derhNghkLN1cp5xerhLgfkmOLeK6Gezg6glmiP2hk6xfHgvgkp4
					SHoY5vfwg8ghtlVzwW1ngghtghwDax2ivMhCi2ghw4fi56oMhQj3ghwnjB7DirhSkbghwQkk7LgHhSkfghwOkq7Lf+hSkWghwNkt7Lf5hSkTghwKk27LfphS
					keghwFlJ7KfKhSkoghv+lc7JephSkqghv5lr7HeQhSksghv1l37Gd7hSkughvyl/7FdthSkughvxmC7Edo]],
				["FinB2.L"] = [[
					eUhIgujbSDgA8leThKg8jDR8bf8NeUhLhFixSOYo7xeUhLhDi1SMZY78eShLg7jCRma277eOhLgrjSQIci7XeQhGgpjkQceF7peagugxlLSAhr8Pe3gZgxn0
					TxoZ7Pfwghguq1WYwJ3ggxhYgutCZ82Tx4hcitguuIdW6Br1hqj5guuXf37snFhskiguuVg88Jk/hsknguuVg/8Kk6hskeguuVhJ8NklhskbguuThW8RkNhs
					knguuThf8Uj6hrkyguuRhr8Xjjhrk1guuQh48ajJhqk4guuOiD8cizhqk5guuNiK8dikhqk6guuNiN8eif]],
				["FinB1.R"] = [[
					hShPghkpwOgA7LhShMgvj4wfke6xhShKg3jVwRnT6WhShKg1jfwbmj6bhRhLgzjuwGlG66hNhMg2j6uvjm75hOhPgxj7vBi+70hQhlgqiEwalz6xhEiZgmei
					wzqb5HggjZgjaXv0v92EfwkKghWPtx1NxAfJkjghTKq84vrQe2kvghRcoh6Vmvexk4ghQ1nZ6wkvexk7ghQ0nW6xkqewkwghQvnL60kXewkpghQom+64kAev
					kvghQkm067jtevk0ghQfmo69jYevkyghQYmZ7Ai/eukwghQUmN7DiqeukvghQQmF7EiceukughQPmC7EiY]],
				["FinB2.R"] = [[
					hshIgujbt9gA8lhthKg8jDuEkh8NhshLhFixtynY7xhthLhCi3t9mp73hrhKhBi9tplJ8UhmhIhGi/sRjk9LhnhLhBi9sli+9Hhrhng4hWt7mC8IhcilgzeE
					uMrX6QgvjvgwaHtAxz2bfxklguWWqp3sv/e9k7guTvne7QonejlCguSdky8ci0eblIguSEjf8lgIeblLguSDja8lf+eak/guSCjY8lf5eZk3guSAjQ8lfoeZ
					k9guR9i/8kfHeYlCguR5iv8jeleXk/guR3ih8heKeWk8guR1iW8gd0eWk7guR0iP8edmeWk6guRziN8edh]],
			},
		},
	},
}
