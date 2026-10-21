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
					gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAF
					gAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjqgAAFgAgAiGgAj1gAAJgAgAixgAkCgAAOgAgAjqgAkOgAAUgAgAkagAkSgAAXgAgAksgA
					kSgAAXgAgAksgAkSgAAXgAgAksgAkSgAAXgAgAksgAkSgAAXgAgAksgAkSgAAXgAgAksgAkSgAAXgAgAksgAkSgAAXgAgAksgAkSgAAXgAgAksgAkSgAAXgA
					gAkrgAkJgAASgAgAkHgAj5gAALgAgAjFgAjrgAAGgAgAiLgAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjn
					gAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6]],
				Spine2 = [[
					gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAF
					gAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAj1eyAFgAgAiGgAkCeyAJgAgAixgAkUezAOgAgAjqgAkje0AUgAgAkagAkpe0AXgAgAksgA
					kpe0AXgAgAksgAkpe0AXgAgAksgAkpe0AXgAgAksgAkpe0AXgAgAksgAkpe0AXgAgAksgAkpe0AXgAgAksgAkpe0AXgAgAksgAkpe0AXgAgAksgAkpe0AXgA
					gAkrgAkdezASgAgAkHgAkIeyALgAgAjFgAj2eyAGgAgAiLgAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjx
					exAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6]],
				Spine3 = [[
					gAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djAT
					gAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj/djAWgAgAkhgAkQdkAhgAgAlqgAkmdmA1gAgAnJgAk5doBIgAgAoYgAlAdpBRgAgAo2gA
					lAdpBRgAgAo2gAlAdpBRgAgAo2gAlAdpBRgAgAo2gAlAdpBRgAgAo2gAlAdpBRgAgAo2gAlAdpBRgAgAo2gAlAdpBRgAgAo2gAlAdpBRgAgAo2gAk/doBQgA
					gAo0gAkydnBAgAgAn6gAkYdlAogAgAmMgAkBdjAXgAgAkqgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6
					djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkN]],
				Spine4 = [[
					gAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAa
					gAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkVcXAfgAgAlcgAkrcaAzgAgAnCgAlIcfBWgAgApHgAlgckB5gAgAq0gAlqcmCJgAgArdgA
					lqcmCJgAgArdgAlqcmCJgAgArdgAlqcmCJgAgArdgAlqcmCJgAgArdgAlqcmCJgAgArdgAlqcmCJgAgArdgAlqcmCJgAgArdgAlqcmCJgAgArdgAlpcmCIgA
					gArbgAlXciBrgAgAqKgAk2ccA+gAgAnxgAkYcYAhgAgAlogAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkP
					cXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlA]],
				Head = [[
					gAknbMABgAgAgXgAknbMABgAgAgHgAknbMABgAgAf6gAknbMABgAgAf0gAknbMABgAgAf1gAknbMABgAgAf+gAknbMABgAgAgMgAknbMABgAgAgdgAknbMAB
					gAgAgsgAknbMACgAgAg3gAknbMACgAgAg7gAknbMACgAgAg3gAkvbNACgAgAhJgAlNbTAMgCgAjYgAl0bdA5f0f9ncgAmTbnCKfPfurggAmfbrDNepfZt2gA
					mfbrDdegfTuVgAmfbrDfeyfbubgAmfbrDkfUfrungAmfbrDrgAgAu2gAmfbrDzgrgWvEgAmfbrD6hNgovOgAmfbrD+hegxvUgAmfbrD9hbgvvTgAmebrDSg7
					gbuDgAmHbjBlgQgFp4gAlbbWAUf+gAkUgAkzbOABgAgAgrgAknbMABgAgAf3gAknbMABgAgAfzgAknbMABgAgAf3gAknbMABgAgAgCgAknbMABgAgAgRgAkn
					bMABgAgAgigAknbMACgAgAgwgAknbMACgAgAg5gAknbMACgAgAg6gAknbMACgAgAg0gAknbMABgAgAgn]],
				Jaw = [[
					gAkSZ6/9gAgAhTgAkRZ6/9gAgAhjgAkQZ7/8gAgAhwgAkPZ7/8gAgAh2gAkPZ7/8gAgAh1gAkQZ7/8gAgAhsgAkRZ6/9gAgAhegAkSZ6/+gAgAhOgAkUZ6/+
					gAgAg+gAkUZ5/+gAgAgzgAkVZ5/+gAgAgvgAkUZ5/+gAgAgzgAkeZ6//gAgAghgAlIZ///f+gAgMgAmEaK/+gLgGg/gBm4ab/3glgliogCnQam/pgyhRkfgC
					nSao/hgzhdlLgCnSao/jgphMlFgBnTap/mgXgrk4gAnUaq/pgAgAkof/nVar/rfqfVkYf+nWar/sfZezkMf+nWas/sfQehkFf+nWas/sfSelkGf/nQan/2fc
					fKi0gAmkaT/+fzf2g1gAlaaC//gCgBgCgAkfZ8/+gAgAg/gAkPZ7/8gAgAhzgAkPZ7/8gAgAh3gAkPZ7/8gAgAhzgAkQZ6/8gAgAhogAkRZ6/9gAgAhZgAkT
					Z6/+gAgAhIgAkUZ5/+gAgAg6gAkVZ5/+gAgAgxgAkVZ5/+gAgAgwgAkUZ5/+gAgAg2gAkTZ6/+gAgAhD]],
				["FinF1.L"] = [[
					c9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoC
					HQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ixcHoAHJfIydc9jGcFn1GyeWx+c9jhcDnkGXdSxXc9j5cBnUGEcaw2c9kCcBnNF9cEwqc9
					kCcBnNF9cEwqc9kCcBnNF9cEwqc9kCcBnNF9cEwqc9kCcBnNF9cEwqc9kCcBnNF9cEwqc9kCcBnNF9cEwqc9kCcBnNF9cEwqc9kCcBnNF9cEwqc9kBcBnNF+
					cGwrc9jwcCnaGLcwxDc9jPcEnwGod+xwc9izcHn+HHfCyac9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ir
					cIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWymc9ircIoCHQfWym]],
				["FinF2.L"] = [[
					aJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInW
					McfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJiAbFnYMUe74FaIifa9ncL6eH3raJjKa0neLadB3IaKjtaundLEcG2qaKj7atncK8bv2faK
					j7atncK8bv2faKj7atncK8bv2faKj7atncK8bv2faKj7atncK8bv2faKj7atncK8bv2faKj7atncK8bv2faKj7atncK8bv2faKj7atncK8bv2faKj6atncK8
					bx2gaJjfawneLMcd22aIiua6ndLudu3eaJiEbEnYMRe14CaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3
					bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4NaJh3bInWMcfK4N]],
				["FinF1.R"] = [[
					jDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC
					4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDixcHoA43g4ydjDjGcFn15Ohqx+jDjhcDnk5piuxXjDj5cBnU58jmw2jDkCcBnN6Dj8wqjD
					kCcBnN6Dj8wqjDkCcBnN6Dj8wqjDkCcBnN6Dj8wqjDkCcBnN6Dj8wqjDkCcBnN6Dj8wqjDkCcBnN6Dj8wqjDkCcBnN6Dj8wqjDkCcBnN6Dj8wqjDkBcBnN6C
					j6wrjDjwcCna51jQxDjDjPcEnw5YiCxwjDizcHn+45g+yajDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDir
					cIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqymjDircIoC4wgqym]],
				["FinF2.R"] = [[
					l3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInW
					zkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3iAbFnYzshF4Fl4ifa9nc0Gh53rl3jKa0ne0mi/3Il2jtaund08j62ql2j7atnc1EkR2fl2
					j7atnc1EkR2fl2j7atnc1EkR2fl2j7atnc1EkR2fl2j7atnc1EkR2fl2j7atnc1EkR2fl2j7atnc1EkR2fl2j7atnc1EkR2fl2j7atnc1EkR2fl2j6atnc1E
					kP2gl3jfawne00jj22l4iua6nd0SiS3el3iEbEnYzvhL4Cl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3
					bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24Nl3h3bInWzkg24N]],
				Tail1 = [[
					gAjngAfKgAgA/+gAjngAfKgOgA/+gAjngAfKgcgB/+gAjngAfKgpgB/+gAjngAfKg0gB/+gAjngAfKg/gC/9gAjngAfKhIgC/9gAjngAfKhQgC/9gAjngAfK
					hVgC/9gAjngAfKhYgC/8gAjngAfKhZgC/8gAjngAfKhYgC/8gAjqgAfWhVgD/9gAj1gAgChPgE/9gAkCgAg7hIgG/9gAkOgAhqg/gH/7gAkSgAh9g0gG/7gA
					kSgAh9gogF/7gAkSgAh9gbgD/7gAkSgAh9gOgC/7gAkSgAh9gAgA/7gAkSgAh9fyf+/7gAkSgAh9flf9/7gAkSgAh9fYf7/7gAkSgAh9fMf6/7gAkSgAh8fB
					f5/6gAkJgAhYe4f5/8gAj5gAgWexf7/9gAjrgAfcerf9/9gAjngAfKeof+/8gAjngAfKenf+/8gAjngAfKeof+/8gAjngAfKerf+/9gAjngAfKewf+/9gAjn
					gAfKe4f+/9gAjngAfKfBf+/9gAjngAfKfMf//+gAjngAfKfXf//+gAjngAfKfkf//+gAjngAfKfygA/+]],
				Tail2 = [[
					gAjshZeVfEgA/7gBjshZeVfkgB/8gCjshZeVgEgB/8gEjshZeVglgC/8gFjshYeVhEgD/7gFjshYeVhigD/6gGjshYeVh9gE/4gHjshYeViWgE/3gHjshYeV
					iqgE/1gIjshYeVi7gF/0gIjshYeVjGgF/zgIjshYeVjNgF/ygHjuhYehjPgG/ygHj0hYfMjMgK/0gGj9hYgFjDgP/2gFkEhYg1i2gS/2gFkHhYhHilgR/3gE
					kHhYhHiPgP/5gCkHhYhHh2gM/6gBkHhYhHhagJ/8gAkHhYhHg8gF/9f/kHhYhHgcgC/+f+kHhYhHf8f+/+f8kHhYhHfcf7/9f7kHhYhHe8f3/9f7kHhYhGef
					f0/7f6kChYgieDf0/7f5j3hYfgdrf2/5f5jvhYemdWf6/2f4jshYeVdFf7/0f4jshYeVc6f7/zf4jshYeVczf7/yf5jshYeVcxf8/yf5jshYeVc0f8/yf6js
					hYeVc8f8/zf7jshYeVdJf9/0f7jshYeVdbf9/2f8jshZeVdwf+/3f+jshZeVeJf//5f/jshZeVelf//6]],
				Tail3 = [[
					f7j1ixeBc8gF/yf/j1ixeBdrgG/2gDj1ixeBeegG/5gHj1ixeBfTgG/7gKj1ixeBgJgG/7gOj1iweBg/gG/6gRj1iweBhzgF/4gUj1iweBilgF/0gWj1iveB
					jSgE/wgYj1iveBj6gE/sgZj1iveBkcgD/ngZj1iveBk3gC/jgZj2iveNlKgD/hgYj5ive3lVgJ/hgXj9ivfwlXgS/igVkAivgflRgZ/jgTkBivgxlDga/lgQ
					kBiwgykugX/ogNkBiwgykRgU/sgJkBiwgyjtgQ/xgFkBiwgzjDgM/1gBkBixgziVgH/5f9kBixgzhigD/8f5kBiwgzguf+/+f2kBiwgzf4f5/+fykBiwgyfC
					f1/9fvj/iwgOeNfz/8fsj6iwfMdcf1/4fqj2iweScuf6/xfoj1iveBcGf8/sfnj1iveBbkf9/nfnj1iveBbJf+/jfnj1iveBa2f//gfoj1iveBargA/efpj1
					iveBaogB/efrj1iveBaugC/fftj1iweBa8gC/hfwj1iweBbRgD/lfzj1iweBbvgE/pf3j1ixeBcTgF/t]],
				Tail4 = [[
					fqkAkHdlZ7gS/UfykAkIdlatgT/df6kAkIdkbogT/mgDkAkJdkcrgT/ugLkAkJdkdygS/0gTkAkIdke9gR/4gbkAkHdkgKgQ/5gikAkHdkhXgO/3gokAkFdk
					ihgL/zgtkAkEdkjogJ/sgxkAkDdkkogG/jg0kAkDdklhgD/ag1kAkCdwmRgD/Sg2j/kDeam3gJ/Ng0j+kDfRnSgU/Jgyj+kDgAnhgd/Fgvj9kDgSnmgf/Egq
					j9kEgSnegd/Ggkj9kFgSnMgZ/Kgdj9kGgTmugV/RgWj9kHgUmFgQ/agOj9kIgVlTgL/jgGj9kJgVkYgF/sf9j8kJgWjWgA/0f1j9kJgWiPf6/6ftj9kIgVhE
					f1/+flj9kIfyf3fw//fej/kIeveqfv/8fYkAkGd1dffz/0fTkAkEdkcYf3/sfPkAkDdkbYf6/jfMkAkDdkaff9/afLkAkCdkZvgA/RfKkAkCdkZJgD/JfMkA
					kCdkYugG/DfOkAkCdkYegI+/fRkAkDdkYZgL++fWkAkEdkYhgN/AfckAkFdlY0gP/FfjkAkGdlZSgR/L]],
				Tail5 = [[
					fJkNlYdBWwgi+efVkNlbdBXVgl+pfikNlddBYIgo+2fwkNledBZHgp/Ff/kOlfdBaRgp/UgNkOlgdBblgo/igckOlfdBdAgn/tgpkOledAeggk/zg2kOlcdA
					gDgg/2hBkOladAhmgc/zhKkOlXc/jGgX/shSkNlVc/khgR/hhXkMlTdLl0gN/VhbkIlTd1m+gR/JhckDlTesn8ga+9hbj+lSfZotgj+xhXj8lSfqpRgl+nhS
					j8lTfqpngh+ghLj8lVfqpugd+ehCj8lXfrpngX+gg3j7lafrpRgR+ngrj7lcftosgL+ygej7lefun6gE+/gQj7lgfvm7f+/OgBj7lhfxlxf3/dfzj7lhfwke
					fw/rfkj/lhfOjCfn/1fXkGlgeLhhfg/5fKkMlddRf9fg/3e/kOladAeafk/ze2kOlXc/c6fp/seukNlVc/bffv/hepkNlTc/aMf1/UelkNlRc/ZCf7/EekkN
					lRc/YEgC+2elkNlQc/XSgI+oepkNlRc/WugP+deukNlSdAWZgU+Xe1kNlUdAWSga+Ue+kNlWdAWage+X]],
				Vortex = [[
					gAj0j4fKgAgA/+gDj0j4fPgane/GgHj0j4fdgxui8fgKj0j4fyhC0y4TgNj0j4gLhK54yxgPj0j3gmhK9isNgRj0j3g/hA/kk+gTj0j3hTgv/2ddgVj0j3hh
					gZ+YWGgVj0j3hngA7OPSgWj0j3hlfn2kJZgVj0j3hcfRwqEwgVj0j3hCe8p1BmgTj0j3gFexicAJgRj0j3e7fCa6AdgPj0j2eGfvTsCjgNj0j2d8gfNLGPgK
					j0j2eQhFHsLVgHj0j2evhjDiRjgDj0j2fVh2A9YlgAj0j2gAh9AFgAf9j0j2grh2A9nbf5j0j2hRhjDiudf2j0j2hwhFHs0rfzj0j2iEgfNL5xfxj0j2iKf1
					Ts9cfvj0j3hifHa5/iftj0j3gPevib/3frj0j3fDe7p1+afrj0j3ekfRwq7Qfqj0j3ebfn2k2nfrj0j3eZgA7Owufrj0j3efgZ+Yp6ftj0j3etgv/2ijfvj0
					j3fBhA/kbCfxj0j3fahK9iTzfzj0j4f1hK54NPf2j0j4gOhC0yHtf5j0j4gjgxuiDhf9j0j4gxganeA6]],
				["FinB1.L"] = [[
					c9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lz
					L6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9itg0l8L1ff4Gc9i1gymcLjfI3uc9jAgunELLep3Mc9jKgrnlK4eO2uc9jNgqnxKxeE2ic9
					jNgqnxKxeE2ic9jNgqnxKxeE2ic9jNgqnxKxeE2ic9jNgqnxKxeE2ic9jNgqnxKxeE2ic9jNgqnxKxeE2ic9jNgqnxKxeE2ic9jNgqnxKxeE2ic9jNgqnwKx
					eE2jc9jGgsnYK/eZ26c9i5gxmqLae+3ic9iug0mALzfc4Dc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9ir
					g1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4Nc9irg1lzL6fl4N]],
				["FinB2.L"] = [[
					ZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmP
					Mvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhyhTmYMpff4pZjh6hJm4MWfK4RZiiEg7niL+es3vZiiOgvoDLqeT3RZiiSgqoQLjeJ3GZi
					iSgqoQLjeJ3GZiiSgqoQLjeJ3GZiiSgqoQLjeJ3GZiiSgqoQLjeJ3GZiiSgqoQLjeJ3GZiiSgqoQLjeJ3GZiiSgqoQLjeJ3GZiiSgqoQLjeJ3GZiiSgqoPLj
					eK3GZiiKgzn2Lyed3dZjh9hEnHMNe/4FZkhzhSmcMnfc4mZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhx
					hWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4wZkhxhWmPMvfk4w]],
				["FinB1.R"] = [[
					jDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz
					0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDitg0l80Lgh4GjDi1gymc0dg43ujDjAgunE01hX3MjDjKgrnl1Ihy2ujDjNgqnx1Ph82ijD
					jNgqnx1Ph82ijDjNgqnx1Ph82ijDjNgqnx1Ph82ijDjNgqnx1Ph82ijDjNgqnx1Ph82ijDjNgqnx1Ph82ijDjNgqnx1Ph82ijDjNgqnx1Ph82ijDjNgqnw1P
					h82jjDjGgsnY1Bhn26jDi5gxmq0mhC3ijDiug0mA0Ngk4DjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDir
					g1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4NjDirg1lz0Ggb4N]],
				["FinB2.R"] = [[
					mchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmP
					zRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchyhTmYzXgh4pmdh6hJm4zqg24RmeiEg7ni0ChU3vmeiOgvoD0Wht3RmeiSgqoQ0dh33Gme
					iSgqoQ0dh33GmeiSgqoQ0dh33GmeiSgqoQ0dh33GmeiSgqoQ0dh33GmeiSgqoQ0dh33GmeiSgqoQ0dh33GmeiSgqoQ0dh33GmeiSgqoQ0dh33GmeiSgqoP0d
					h23GmeiKgzn20Ohj3dmdh9hEnHzzhB4FmchzhSmczZgk4mmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchx
					hWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4wmchxhWmPzRgc4w]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Spine1 = [[
					gAjkgAAFgAgAh6gAjsgAAFgCgdh6gAjugAAFgDg1h6gAjqgAAGgEhEh6gAjmgAAGgEhHh6gAjtgAAGgEg+h6gAjugAAFgDgqh6gAjogAAFgBgPh6gAjogAAF
					f/fxh6gAjugAAFf9fWh6gAjtgAAGf8fCh6gAjmgAAGf8e5h6gAjqgAAGf8e8h6gAjugAAFf9fLh6gAjsgAAFf+fjh6]],
				Spine2 = [[
					gAjtexAFf/fvh6f+j1exAFgAf5h6f8j4eyAFgAgEh6f7j0eyAFgBgOh6f7jveyAFgBgWh6f7j2eyAFgCgah6f9j3eyAFgCgZh6f/jyexAFgBgUh6gBjyexAF
					gBgMh6gDj3eyAFgAgBh6gFj2eyAFf/f3h6gFjveyAFf/fth6gFj0eyAFf/fnh6gEj4eyAFf+fmh6gCj1exAFf/fph6]],
				Spine3 = [[
					gBj3djATf6fQkNf+j/djATf5fLkNf8kBdjATf6fPkNf6j9djATf7fckNf5j5djATf+fukNf5kAdjATgBgEkNf7kBdjATgDgZkNf9j7djATgGgqkNgAj7djAT
					gHgzkNgDkBdjATgHg0kNgFkAdjATgGgrkNgHj5djATgEgckNgHj9djATgBgHkNgGkBdjATf+fxkNgEj/djATf7fekN]],
				Spine4 = [[
					gFkLcXAcfyemk/gCkTcXAdfweYk/f/kWcXAdfweck/f8kRcXAcf0exk/f6kNcXAbf5fUlAf5kUcXAagAf/lAf5kVcXAbgHgplAf6kQcXAcgMhNk/f8kQcXAd
					gQhjk/f/kVcXAdgRhpk/gCkUcXAcgOhck/gFkNcXAbgKg/lAgHkRcXAagEgXlAgHkWcXAaf9frlAgHkTcXAbf2fDlA]],
				Head = [[
					gMkkbMADgAelgCgKksbMAFgBd5fzgHkubMAHgAdlf8gCkqbMAGf+dsgXf9kmbMAFf9eNgxf5ktbMADf+fBg6f2kubMABgAgAgsf0kobMACgAg/gQf1kobMAE
					gAh0f4f3kubMAGf/iUf1f7ktbMAHgBibgIgAkmbMAGgCiHglgFkqbMAEgDhbg5gJkubMACgBggg2gLksbMABgAfgge]],
				Jaw = [[
					gTkNZ7/6f7hbhogVkTZ8/3f4iGh2gTkXZ8/2f4iahtgOkVZ7/4f6iUhTgHkTZ6/7f9hzg5f+kaZ6/9f/g/gwf2kaZ6/+gAgAg+fvkSZ7/8gDfBhbfskQZ8/5
					gGeNhyfskWZ8/2gIdsh1fvkWZ8/3gHdmhhf1kSZ7/5gFd5hEf+kXZ6/8gCelgxgGkbZ6/+gBfgg0gOkXZ6/9f/gghM]],
				["FinF1.L"] = [[
					dAiocForMLeE3ec8ivcHm+LKcO27c4iycJlXJlbP1qc1iucLkGHwbWz7c0iqcMjhGAccx9c0ixcNj6EpeHv/c2iycNlUD4f2uRc4iscMneD1hVtIc8iscKos
					EIh6s7dAiycIowElhnt2dDixcGo1FihDvmdGiqcEo5G9gTxzdGiucDo4Irffz/dFiycDo0KXex10dDivcDouLpeR3A]],
				["FinF2.L"] = [[
					aFhocVn1SbeQ71Z5iQcSmCRQbh7XZyivcBkVPbZq6QZzi6bnjANNZD4wZ6i1bIibK9Zw3IaIitari4JDbh1paaiWaWkXH3d70bath4aJmmHpggzpa3hsaGn2
					H+huzhayhyaNn5Iohd0Tanhxafn+J/g91xaahqa5oBL7gR3kaQhubYoBOJfi5TaLhyb2n9QQe56qaIhvcLn4Ryec7g]],
				["FinF1.R"] = [[
					jGiocLor76eEs3jCivcJot7ueNtRi+iycHoy7Bepupi7iucFo350fUwri6iqcEo54NgHy7i6ixcDo22dg50+i8iycDox07hh2gi+iscEosz/h43VjCiscGn1
					0Qi83TjGiycImJ1lka2YjJixcKkr3Vk201jMiqcMjs5KkNy9jMiucNjl6vixw9jLiycNkf71hAvFjJivcMmU8PfYtn]],
				["FinF2.R"] = [[
					lKhoaGn14GeQzdlKhvaIn33zeYzzlThyaVn82yex0+lghuaroA1HfY2qlshqbIoCy/gH4elzhxbon/wxg06Cl3hycCn6u5hX7Jl5hscSn2txhs7vmCh8cVm8
					uEjM7smLihcLlKvmlj64mOi3b1jmxrm05imKi4bXimz9mw38mAiza5ih2Ele2Xlwijafjg3qjV0/lciHaOlb4Ygzz+]],
				Tail1 = [[
					gAjkgAfKhUgC/9gAjsgAfKg7gC/9gAjugAfKgXgB/+gAjqgAfKfwgA/+gAjmgAfKfLf//+gAjtgAfKewf+/9gAjugAfKeif+/8gAjogAfKelf+/8gAjogAfK
					e3f+/9gAjugAfKfWf//+gAjtgAfKf8gA/+gAjmgAfKgjgB/+gAjqgAfKhEgC/9gAjugAfKhZgC/8gAjsgAfKhfgC/8]],
				Tail2 = [[
					gHjohYeVkOgE/qgFjwhYeVjMgD/ygCjzhZeVhngB/6f/jvhZeVfwf//8f7jrhYeVd8f9/4f5jyhYeVcef8/wf4jzhYeVbof7/pf4jthYeVbif7/of6jthYeV
					cOf8/uf8jzhZeVdjf+/2gAjyhZeVfTgA/8gDjrhZeVhMgC/7gGjvhYeVi3gE/0gIjzhYeVkCgF/sgIjwhYeVkhgF/o]],
				Tail3 = [[
					gejyiteCn3f9+8gXj6iveCnBf7/JgLj8iweBk+f5/if9j4ixeBiDf5/3fwj0iweBevf6/5fmj7iueBbrf8/ofgj8iteCZYf//Pfgj2iteCYOgC++flj2iueC
					YZgE/Afvj8iweCZ3gG/Vf8j7ixeBcagH/ugKj0ixeBfmgH/7gWj4iveBi3gF/zgej8iueBlngD/bghj6iteCnXgA/E]],
				Tail4 = [[
					hJj8j7dmqhf2+Hg9kEj+dmq9fs99gmkHkEdmpjfm+bgJkDkIdmmgfk/Ofpj/kIdliQfn/0fOkGkDdldlfu/ze8kHj+dlZYf4/Ne2kBj7dlWYgE+ae8kBj8dm
					VCgP99fNkGkBdmVigY+IfokGkHdmXzgc+0gHj/kJdmbhgc/lglkDkGdlgFgW/5g8kHkAdlkpgN/jhJkEj8dloUgC+y]],
				Tail5 = [[
					iAkIk/dCqhgD+Eh2kQlBdDtDfp9DhZkTlMdEtZfU85gskPlZdGrkfG9rf2kMlfdGntfC+5fBkTladFiZfI/weYkUlOdDcmfZ/qeDkNlCdCXefw+seDkNk/dC
					T9gK9feXkSlGdDSggi82e8kSlTdFTQg09LfvkMlddGWJg++RgmkQledFa1g8/ahWkVlUdEgigw/1h1kRlHdCmIgc/Q]],
				Vortex = [[
					gUjxj3fKhUgC/9gOj5j3fYhFmr/QgGj7j4fZgrtB9Nf8j3j4fLgTyy54fzjzj4e1gF3v1aftj6j3eggG7qwAfpj7j3eWgW+Xp6fqj1j3eggs/xjYfuj1j3e9
					g9/ycsf2j7j4fphA+aWJf/j6j4gYgw7sQBgJjzj4g+gQ3wKmgQj3j3hTfpyxGIgWj7j3hVfEs9CzgXj5j3hIevmnAw]],
				["FinB1.L"] = [[
					c9iog1l/HFhZzGc/ivg7mCHwhMz7dAiyg/mGJJgx1gdBiuhCmJLJgP3ddBiqhDmJNefp5VdBixhBmFPsfI60c/iyg9mBRWew7wc+isg4l/SDen8Hc8isgylZ
					RZde70c7iygtkOPmbn6xc6ixgpjFNTaq5Nc6iqgoiMK7a13Zc6iugoh3I3b/1oc6iygricHZdv0Lc8ivgwj6GxfqzQ]],
				["FinB2.L"] = [[
					Zthlf1mZHxhfz0ZrhtgImcIchR0nZohwgqmhJ4g12KZohshTmkL8gQ4CZwhoh8mjOUfn51Z8hvidmgQlfE7PaHhwixmbSQer8IaMhqi1mZS+eh8daCh6iqli
					SOdG8MZwigiRj4QUat7GZhi7htidN+ZU5cZajEhDhhLiZN3lZYjFgchZJZaX13Zci1f/iPH4cc0lZjiSfxkCHSe+z4]],
				["FinB1.R"] = [[
					jDiog1l/uChZ8FjEivgwk0vbjk7YjGiygrjpxhlA6CjGiugoilz6lZ4UjGiqgoh72Lkt2fjGixgpiC3+jM02jFiygtjF5ChTzojEisgyk65NfdzFjCisg4mA
					4seszZjBiyg9mE3pfA0pi/ixhBmI17ff2ei/iqhDmJzugE4bi/iuhCmHxYgp6JjAiyg/mDvZhG7XjBivg7mAuLhW8A]],
				["FinB2.R"] = [[
					l2hlixmZtHhf8bmIiNifkruqkM7umYiviAjIw1mJ6UmjjChYh6zRm64hmojFgvhW1mmX2smnjAgMhs3eks1Kmhilf2jC4jiV0JmYh8fxlL4nfwzwmThqf9mb
					4Aem0HmXhwgYmf27e81UmZhvg+mj1Kfd3FmVhohomky5gF4+mLhsiOmiwggr6ml+hwipmeufhK7wl1hti1matQhc8X]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Spine1 = [[
					gAj2gAAHgAgAiYgAkZf2AIgAgAivgAknfyAIgAgAimgAkZf2AFgAgAiEgAj2gAADgAgAhcgAj2gAACgAgAhGgAj2gAACgAgAhOgAj2gAAEgAgAhw]],
				Spine2 = [[
					gAkBeyAHgAgAiYgAkmeoAIgAgAivgAk0ekAIgAgAimgAkjeoAFgAgAiEgAj9exADgAgAhcgAj7exACgAgAhGgAj8exACgAgAhOgAj+exAEgAgAhw]],
				Spine3 = [[
					gAkNdkASgAgAkFgAk0daATgAgAkMgAlBdWAUgAgAkUgAktdZAUgAgAkYgAkEdiAUgAgAkVgAkAdiATgAgAkOgAkCdiASgAgAkGgAkHdjARgAgAkD]],
				Spine4 = [[
					gAkhcXATgAgAkSgAlIcOASgAgAkKgAlWcKAWgAgAkigAlCcNAcgAgAlLgAkZcWAigAgAlugAkVcWAjgAgAl1gAkWcWAfgAgAlegAkbcWAYgAgAk0]],
				Head = [[
					gAk2bL/9gAgAhjgAlcbB/8gAgAh3gAlsa+/+gAgAg4gAlcbC/+gAgAfLgAk1bM/6gAgAdvgAkxbM/4gAgAdbgAkwbL/8gAgAeagAkybL//gAgAgH]],
				Jaw = [[
					gAkXZ8/igAgAlagAk8Z0/egAgAlugAlRZu/ogAgAkwgAlJZw/2gAgAjDgAkpZ5/8gAgAhogAkoZ4/9gAgAhUgAkhZ5/6gAgAiTgAkbZ6/vgAgAkA]],
				["FinF1.L"] = [[
					c9jBcGo6NqdS4gc9jpb7k3KfY82Dc9j2b3hvGJaAxwc9jfb9i2DLextgc9iycKoYDai4rRc9itcLoYEbidtrc9ivcLofHjgiyzc9i3cIonLreX3F]],
				["FinF2.L"] = [[
					aGh/croJUKdn8fZ4j7cFj3QlXG6TaHkma5gqLUWc2baljeZ+h4G/bmzWbKhuZ4ndG0ilyFazhmaQnXIYiM0KaNhsbNngMtgb4YaCh3cSnvR1eg7k]],
				["FinF1.R"] = [[
					jDjBcGo6yWiu4gjDjpb7k31hnE2DjDj2b3hv53mAxwjDjfb9i281hPtgjDiycKoY8mdIrRjDitcLoY7ldjtrjDivcLof4dfeyzjDi3cIon0Vhp3F]],
				["FinF2.R"] = [[
					l6h/croJr2iZ8fmIj7cFj3vbo66Tl5kma5gq0spk2blbjeZ+h45BkazWk2huZ4nd5MdbyFlNhmaQnX3od00KlzhsbNngzTfl4Yl+h3cSnvuLhg7k]],
				Tail1 = [[
					gAj2gAfFgAgA/+gAkZf2eQhMf8/7gAknfydohrf4/3gAkZf2dlhMf6/4gAj2gAeIgAgA/8gAj2gAe+e0gC/9gAj2gAfmeVgB/8gAj2gAfpe0gB/9]],
				Tail2 = [[
					gAj7hZeffBgD/8gHkihOcZhcf+/wgJk0hJazjAfz/agHkmhNani0fw/agAkAhYb9g+f4/uf5j7hYeDekgB/5f3j4hYfqc+gD/2f5j4hYf2dLgC/3]],
				Tail3 = [[
					f7kDixfBdcgK/3gPk2ikb4gsgI/tgalRicZDjhf2/BgWlDigYLkQfj+ugFkWiuZtiifl/QfxkGiwc1fUf3/0fmj6ivfscegE/yfqj4iwgnbsgH/s]],
				Tail4 = [[
					fskIkIfrb3gV/ugSlNj6b+fPgZ/ugtl2jqX9jCgI+0gtltjrWAk+fl9+gUk4j/XHkDfR+dfukYkHavgyff/ifTj7kGezc+f7/0fSj1kFg2a8gL/k]],
				Tail5 = [[
					fVkKlegDa5gc/kgOljlQcadngt/sg9mhk2Xjhwgo+zhImgkuUZkwf99bgqlnlHUnk/fM9dfyk0lbYHiYfC+5fCkCldc/eUfh/ze2jwlZgSbMgE/o]],
				Vortex = [[
					gAkEj4fFgAgA/+gSk0jse1hxsK9hgalMjmfgi32c2ngSk+jrgKis9asSgAkSj3gAh4/8gAfukGj3fTha9gTvfmj8j3fHhe2kJafuj7j3f5hPsOCe]],
				["FinB1.L"] = [[
					c9i4gzhtIEcX01c9jagolfGmgGypc9jpgkmdHogszrc9jcgrmQLHgJ3Zc9i7g3lsPrfX66c9i8g4lPSWe48bc9i8g4jQQWbM7Sc9i6g2hTMBZ64L]],
				["FinB2.L"] = [[
					ZdjPgXhSIlav1GZrirfflyHMf3zVZqipftm4IVgy0XZkiag6mrL6gK3+Z4h8iVmGQkfS7VaOiBi8lpTSew8xZ4i2ipivRDaK7iZjjihngYMqYG4N]],
				["FinB1.R"] = [[
					jDi4gzht38jp01jDjagolf5af6ypjDjpgkmd4YfUzrjDjcgrmQ05f33ZjDi7g3lswVgp66jDi8g4lPtqhI8bjDi8g4jQvqk07SjDi6g2hTz/mG4L]],
				["FinB2.R"] = [[
					mjjPgXhS3blR1GmVirffly40gJzVmWipftm43rfO0Xmciag6mr0Gf23+mIh8iVmGvcgu7VlyiBi8lpsuhQ8xmIi2ipivu9l27imdjihngYzWn64N]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Spine1 = [[
					gAjygAAFgAgAh6gAj3gGAFgAgAiHgAkEgWAIgAgAimgAkSgoALgAgAjKgAkbg0ANgAgAjigAkXgHAMgAgAjYgAkdeWAOgAgAjlgAkdeWAOgAgAjlgAkdeWAO
					gAgAjlgAkceXAOgAgAjkgAkTetALgAgAjOgAkEfTAIgAgAiogAj3f0AFgAgAiGgAjygAAFgAgAh6gAjygAAFgAgAh6gAjygAAFgAgAh6]],
				Spine2 = [[
					gAj7exAFgAgAh6gAkBe4AFgAgAiHgAkQfIAIgAgAimgAkhfaALgAgAjKgAktfmANgAgAjigAkoe6AMgAgAjYgAkudIAOgAgAjlgAkudIAOgAgAjlgAkudIAO
					gAgAjlgAkudKAOgAgAjkgAkjdfALgAgAjOgAkReFAIgAgAiogAkBemAFgAgAiGgAj7exAFgAgAh6gAj7exAFgAgAh6gAj7exAFgAgAh6]],
				Spine3 = [[
					gAkFdjATgAgAkNgAkMdpAXgAgAkqgAkdd6AjgAgAlzgAkxeNA0gAgAnGgAk+eZBBgAgAn7gAk5dsAtgAgAmogAlAb7ATgAgAkNgAlAb7ATgAgAkNgAlAb7AT
					gAgAkNgAk/b9ATgAgAkNgAkzcSATgAgAkNgAkec3ATgAgAkNgAkLdYATgAgAkNgAkFdjATgAgAkNgAkFdjATgAgAkNgAkFdjATgAgAkN]],
				Spine4 = [[
					gAkZcXAagAgAlAgAkiceAigAgAltgAk5cwA6gAgAnfgAlTdGBdgAgApegAlkdUB4gAgAqwgAlZckBIgAgAoXgAlUavAMgAgAjVgAlUavAMgAgAjVgAlUavAM
					gAgAjVgAlUaxAMgAgAjXgAlHbGAPgAgAjtgAkzbrATgAgAkTgAkgcLAYgAgAk0gAkZcXAagAgAlAgAkZcXAagAgAlAgAkZcXAagAgAlA]],
				Head = [[
					gAkybMABgAgAgXgAk+bUAEgAgAh3gAldbqAhgAgAlpgAmAcEBkgAgAp1gAmWcXCjgAgAsegAmBbgBUgAgApBgAllZiANf6hVjJgAllZiAMf8g0jJgAllZiAM
					gEfMjJgAlkZjAMgGesjHgAlaZ5AHgAgAiigAlIaeAEf/gkhjgAk3bAABgAgGgqgAkybMABgAgAgXgAkybMABgAgAgXgAkybMABgAgAgX]],
				Jaw = [[
					gAkdZ6//gAgAgMgAkxaB//gAgAgFgAlkaW/+gAgAfEgAmda1/wgAgAcJgAnAbO/xgAgAcOgAmZaP/5gAgAiif5leYO/8gLesetf8leYO/+gKfNg2gEleYO/8
					f6g0eYgHldYP/3f4hUdcgAlQYl/7gAgAeAf9k4ZL/+gCfcfAgAkkZu//gAf6f4gAkdZ6//gAgAgMgAkdZ6//gAgAgMgAkdZ6//gAgAgM]],
				["FinF1.L"] = [[
					c9i2cIo5HjgAync9i+cNoZHAfkyGc9jScbm/Fweiw0c9jpcslMEjdhvYc9j4c3j6D6c8uec9jycKmQFzc9w+c9j7aYp7LrdP2cc9j7aYp7LrdP2cc9j7aYp7
					LrdP2cc9j6aap6LndR2Zc9jraxpsKrdz1rc9jTbYpUJLex0Vc9i9b8pAH9frzEc9i2cIo5HjgAync9i2cIo5HjgAync9i2cIo5HjgAyn]],
				["FinF2.L"] = [[
					aNh2bIoCMtgA4OaMiHbGnsMFfc30aOizbEmrKmeF2vaVjlbElSJJco1eabkEbFkPIUbw0oaJjoa3mUKxcY2yaCi6aYpURydu7AaCi6aYpURydu7AaCi6aYpU
					Rydu7AaCi5aZpSRudw6+aCisaipCQneL6faFiVazolOxe95haKh+bCoLNOfu4kaNh2bIoCMtgA4OaNh2bIoCMtgA4OaNh2bIoCMtgA4O]],
				["FinF1.R"] = [[
					jDi2cIo54dgAynjDi+cNoZ5AgcyGjDjScbm/6Qhew0jDjpcslM7difvYjDj4c3j68GjEuejDjycKmQ6NjDw+jDj7aYp70Vix2cjDj7aYp70Vix2cjDj7aYp7
					0Vix2cjDj6aap60Ziv2ZjDjraxps1ViN1rjDjTbYpU21hP0VjDi9b8pA4DgVzEjDi2cIo54dgAynjDi2cIo54dgAynjDi2cIo54dgAyn]],
				["FinF2.R"] = [[
					lzh2bIoCzTgA4Ol0iHbGnsz7gk30lyizbEmr1ah72vlrjlbElS23jY1ellkEbFkP3skQ0ol3joa3mU1Pjo2yl+i6aYpUuOiS7Al+i6aYpUuOiS7Al+i6aYpU
					uOiS7Al+i5aZpSuSiQ6+l+isaipCvZh16fl7iVazolxPhD5hl2h+bCoLyygS4klzh2bIoCzTgA4Olzh2bIoCzTgA4Olzh2bIoCzTgA4O]],
				Tail1 = [[
					gAjygAe5gAgA/+gAj3gGe/gAgA/+gAkEgWfPgAgA/+gAkSgofhgAgA//gAkbg0ftgAgA//gAkXgHf1gAgA//gAkdeWgkiqgD/4gAkdeWgkhpgC/8gAkdeWgk
					eXf+/8gAkceXgidYf9/4gAkTetgMgAgA//gAkEfTfmhIf//+gAj3f0fEgLgA/+gAjygAe5gAgA/+gAjygAe5gAgA/+gAjygAe5gAgA/+]],
				Tail2 = [[
					gAj4hZdxgAgA/6gAj9hfdxgAgA/6gAkIhvdxgAgA/6gAkViBdxgAgA/6gAkdiMdxgAgA/6gAkYhgeMfbgC/7gPkaftfck7gG/mgJkZfufclVgB/if3kZfufc
					eXf7/8fykZfufaZwf8/XgAkSgGfFeNgD/7gGkGgrefiHf//4gBj8hNd9glf+/6gAj4hZdxgAgA/6gAj4hZdxgAgA/6gAj4hZdxgAgA/6]],
				Tail3 = [[
					gAkFiwdLgAgA/3gAkJi3dFgAgA/2gAkUjGc1gAgA/1gAkhjYcjgAgA/zgAkpjkcXgAgA/yf9kii4dEePgK/zgqkdhCe2k7gM/lgmkdhCe0p9fz+YfukdhGe4
					hUfs/8fQkchAezW8gB+qf2kXheefahgU/egSkPiDd5iHgB/2gEkHildXhGf7/3gAkFiwdLgAgA/3gAkFiwdLgAgA/3gAkFiwdLgAgA/3]],
				Tail4 = [[
					gAkUkIccgAgA/ygAkZkOcQgAgA/xgAkmkdbwgAgA/tgAk0kvbMgAgA/ogAk9k7a1gAgA/kfzkzkOb0c0gX/jhFkjiWeMhXgu/5hbkiiJeEtSfo9Cf1kjieeN
					nEfD/IefkjiLeGW8f0+nfYkfixdxWHgw+VgekajadKglgS/3gKkWj8cohff5/xgAkUkIccgAgA/ygAkUkIccgAgA/ygAkUkIccgAgA/y]],
				Tail5 = [[
					gAkoleblgAgA/rgAkulkbSgAgA/pgAk9lzajgAgA/hgAlOmEZugAgA/XgAlamPZLgAgA/QfhlJliacbxgf/NhMktjudkajhz/YiekrjCdRtTf/8+gckrjude
					theO81dvktjUdbbAe7/eekkqj4c8TChC9EghkqkxcWdsg2/rgTkolTbwhgf7/rgAkoleblgAgA/rgAkoleblgAgA/rgAkoleblgAgA/r]],
				Vortex = [[
					gAkDj4e5gAgA/+gAkHj+fEgbtA9NgAkQkOffgl3x1ZgAkakgf2ge+bp4gAkgksgCgT/0cqgAkaj/gFgJ7tQBgpkUiKhHdiysGMgZkUiMfzeSmnAwfnkUiMfz
					huZZAwfXkUiMhHicNTGMgAkQilf6gLETQBgSkKjKe7ffAOcpgDkFjsfjfLBmp4gAkDj4fQfLIQ1ZgAkDj4e/fjTA9NgAkDj4e5gAgA/+]],
				["FinB1.L"] = [[
					c9i2g1mJMBgA4Nc9i6g7mOMAfy4Lc9jFhJmYL8fO4Fc9jShYmkL6el39c9jahimsL5eK35c9jXg2m2Meeb4Wc9jbfEneOQei5gc9jbfEneOQei5gc9jbfEne
					OQei5gc9jbfGndOOej5fc9jTfdnLNwe15Pc9jGgFmtM8fW4yc9i6gpmSMQf14Xc9i2g1mJMBgA4Nc9i2g1mJMBgA4Nc9i2g1mJMBgA4N]],
				["FinB2.L"] = [[
					Zmh0hWmkM2gA4wZmh5hbmpM0fy4uZkiIhnm1MxfP4nZjiYh1nCMuem4fZiijh+nKMseM4aZliahbnUNTec42ZviSgDn6PIej59ZviSgDn6PIej59ZviSgDn6
					PIej59ZviSgEn5PGek58ZtiMgVnnOne25uZpiBgznINyfW5TZnh3hNmtNFf145Zmh0hWmkM2gA4wZmh0hWmkM2gA4wZmh0hWmkM2gA4w]],
				["FinB1.R"] = [[
					jDi2g1mJz/gA4NjDi6g7mO0AgO4LjDjFhJmY0Egy4FjDjShYmk0Ghb39jDjahims0Hh235jDjXg2m2zihl4WjDjbfEnexwhe5gjDjbfEnexwhe5gjDjbfEne
					xwhe5gjDjbfGndxyhd5fjDjTfdnLyQhL5PjDjGgFmtzEgq4yjDi6gpmSzwgL4XjDi2g1mJz/gA4NjDi2g1mJz/gA4NjDi2g1mJz/gA4N]],
				["FinB2.R"] = [[
					mah0hWmkzKgA4wmah5hbmpzMgO4umciIhnm1zPgx4nmdiYh1nCzSha4fmeijh+nKzUh04ambiahbnUythk42mRiSgDn6w4hd59mRiSgDn6w4hd59mRiSgDn6
					w4hd59mRiSgEn5w6hc58mTiMgVnnxZhK5umXiBgznIyOgq5TmZh3hNmty7gL45mah0hWmkzKgA4wmah0hWmkzKgA4wmah0hWmkzKgA4w]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjtgAAFgAgAh6gAj3gAAFgAgAh6gAj5gAAFgAgAh6gAj5gAAF
					gAgAh6gAj5gAAFgAgAh6gAj5gAAFgAgAh6gAj5gAAFgAgAh6gAj5gAAFgAgAh6gAj5gAAFgAgAh6gAj5gAAFgAgAh6gAj5gAAFgAgAh6gAj5gAAFgAgAh6gA
					j5gAAFgAgAh6gAjzgAAFgAgAh6gAjqgAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6gAjngAAFgAgAh6]],
				Spine2 = [[
					gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAj3exAFgAgAh6gAkAexAFgAgAh6gAkDexAFgAgAh6gAkDexAF
					gAgAh6gAkDexAFgAgAh6gAkDexAFgAgAh6gAkDexAFgAgAh6gAkDexAFgAgAh6gAkDexAFgAgAh6gAkDexAFgAgAh6gAkDexAFgAgAh6gAkDexAFgAgAh6gA
					kCexAFgAgAh6gAj8exAFgAgAh6gAj0exAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6gAjxexAFgAgAh6]],
				Spine3 = [[
					gAj6djATgAgAkNgAj6djARgAgAkDgAj6djAPgAgAjtgAj6djANgAgAjbgAj6djANgAgAjegAkAdjAegAgAlagAkKdjA/gAgAn0gAkMdjBHgAgAoUgAkMdjBH
					gAgAoUgAkMdjBHgAgAoUgAkMdjBHgAgAoUgAkMdjBHgAgAoUgAkMdjBHgAgAoUgAkMdjBHgAgAoUgAkMdjBHgAgAoUgAkMdjBHgAgAoUgAkMdjBHgAgAoUgA
					kMdjBGgAgAoPgAkFdjAwgAgAm0gAj9djAZgAgAk3gAj6djATgAgAkNgAj6djATgAgAkNgAj6djATgAgAkN]],
				Spine4 = [[
					gAkPcXAagAgAlAgAkOcXAXgAgAksgAkMcWARgAgAj/gAkLcWANgAgAjbgAkLcWANgAgAjigAkacZA4gAgAnXgAkvcdCYgAgAsEgAk0cfCygAgAtAgAk0cfCy
					gAgAtAgAk0cfCygAgAtAgAk0cfCygAgAtAgAk0cfCygAgAtAgAk0cfCygAgAtAgAk0cfCygAgAtAgAk0cfCygAgAtAgAk0cfCygAgAtAgAk0cfCygAgAtAgA
					kzceCtgAgAs2gAkmcbBqgAgAqIgAkVcYApgAgAmTgAkPcXAagAgAlAgAkPcXAagAgAlAgAkPcXAagAgAlA]],
				Head = [[
					gAknbMABgAgAgXgAklbLABgAgAfvgAkgbKAEgAgAeVgAkcbJAJgAgAdMgAkdbJAIgAgAdZgAk+bSAOgCftjpgAlmblB7gQfQq1gAlubqCBfehkrBgAlubqCX
					gLfksBgAlubqCigee1sYgAlubqCCfghcrFgAlubqCRgAgArzgAlubqCmgkelsfgAlubqCEflhMrNgAlubqCMf2gcrlgAlubqCogneesjgAlubqCIftg3rYgA
					ltbpCCftg2rKgAlWbcBGgQe/oMgAkzbPAGgAgFiLgAknbMABgAgAgXgAknbMABgAgAgXgAknbMABgAgAgX]],
				Jaw = [[
					gAkSZ6//gAgAgMgAkNZ6/+gAgAg0gAkBZ7/6gAgAiOgAj3Z9/0gAgAjWgAj5Z8/1gAgAjKgCk6Z+/zf6gTjegEmIaY/SfZghmmf4mRad+vhXfDotgCmWaf/D
					fngRnsgGmYah/He8gsnTf4mRad+whQfIopgAmVaf+/gAgAn7gImYah/Jeug0nLf6mSae+zhCfSohf+mUae+7gZfvoJgImZah/Jemg4nGf7mTae+3gwffoWf7
					mQad+6guffoMgFlqaK/pfYg2klgAknZ7/9gBf7hdgAkSZ6//gAgAgMgAkSZ6//gAgAgMgAkSZ6//gAgAgM]],
				["FinF1.L"] = [[
					c9ircIo5HjgAync9ircIovHvfxy7c9ircIoYILfNznc9ircIoGIjew0Jc9ircIoJIfe10Dc9ixcImUFve2xGc9i7cIiBDFeltcc9i9cIelCudksjc9i9cIgi
					Cseassc9i9cIhQCteusuc9i9cIetCtdoskc9i9cIgGCseOsqc9i9cIhfCue1svc9i9cIe8Ctduslc9i9cIfqCseCsoc9i9cIhnCue4svc9i9cIfRCsd3snc9
					i8cIffCvd4svc9i2cIkkEHe9u8c9iucInpGgfdxuc9ircIo5HjgAync9ircIo5HjgAync9ircIo5HjgAyn]],
				["FinF2.L"] = [[
					aNhrbIoCMtgA4OaKhtbMn6M+fv4eaGhzbXnoNlfI5AaCh3bgnbOGeo5aaDh3bendOAeu5VaMiTazlZKcde23aljAaIg7G3a4zEawjfaBdwGZY6xqatjMaBfd
					GTaGyGasjFaBgGGTajyPawjeaBd3GZY/xsatjRaBfFGUZ1yAasjDaBgTGTasySavjcaBeEGYZIxwaujVaBetGVZkx6asjCaBgaGTaxyTavjZaBeWGWZVx1at
					jXaCekGbZbx/aainaZjdIPcb00aMh/a7mxLZez3eaNhrbIoCMtgA4OaNhrbIoCMtgA4OaNhrbIoCMtgA4O]],
				["FinF1.R"] = [[
					jDircIo54dgAynjDircIov4RgPy7jDircIoY31gzznjDircIoG3dhQ0JjDircIoJ3hhL0DjDixcImU6RhKxGjDi7cIiB87hbtcjDi9cIel9SicsjjDi9cIgi
					9UhmssjDi9cIhQ9ThSsujDi9cIet9TiYskjDi9cIgG9UhysqjDi9cIhf9ShLsvjDi9cIe89TiSsljDi9cIfq9Uh+sojDi9cIhn9ShIsvjDi9cIfR9UiJsnjD
					i8cIff9RiIsvjDi2cIkk75hDu8jDiucInp5ggjxujDircIo54dgAynjDircIo54dgAynjDircIo54dgAyn]],
				["FinF2.R"] = [[
					lzhrbIoCzTgA4Ol2htbMn6zCgR4el6hzbXnoybg45Al+h3bgnbx6hY5al9h3bendyAhS5Vl0iTazlZ1kii23lbjAaIg75JlIzElQjfaBdw5nnGxqlTjMaBfd
					5tl6yGlUjFaBgG5tldyPlQjeaBd35nnBxslTjRaBfF5smLyAlUjDaBgT5tlUySlRjcaBeE5om4xwlSjVaBet5rmcx6lUjCaBga5tlPyTlRjZaBeW5qmrx1lT
					jXaCek5lmlx/lminaZjd3xjl00l0h/a7mx0nhN3elzhrbIoCzTgA4OlzhrbIoCzTgA4OlzhrbIoCzTgA4O]],
				Tail1 = [[
					gAjngAe5gAgA/+gAjngAe5gAgA/+gAjngAe5gAgA/+gAjngAe5gAgA/+gAjngAe5gAgA/+gAjtgAeVftgB/8gAj3gAdbgzf8/4gAj5gAdOhqf3/0gAj5gAdO
					gef9/3gAj5gAdOevgH/2gAj5gAdOefgI/1gAj5gAdOgAgA/3gAj5gAdOhhf4/1gAj5gAdOhRf5/2gAj5gAdOfigD/3gAj5gAdOeWgJ/0gAj5gAdOfGgF/2gA
					j5gAdQg5f7/3gAjzgAd1hDf7/5gAjqgAeogFgA/9gAjngAe5gAgA/+gAjngAe5gAgA/+gAjngAe5gAgA/+]],
				Tail2 = [[
					gAjuhZdxgAgA/6gAjuhZdxgAgA/6gAjuhZdxgAgA/6gAjuhZdxgAgA/6gAjuhZdxgAgA/6f+j3hYcpfLgE/zgEkFhXa2gugB/kgJkIhXadjHfw/WgDkJhXad
					hyfx/df5kIhXadeXgE/df4kIhXadc3gS/WgAkJhXadfCgL/fgIkIhXadiVf3/agHkIhXadi6ft/Xf9kJhXadgFf6/gf3kIhXaddKgN/Yf7kIhXaddkgR/agF
					kIhXahgzgB/ggGj/hYbrh+f4/ogAjyhYdQgSf//3gAjuhZdxgAgA/6gAjuhZdxgAgA/6gAjuhZdxgAgA/6]],
				Tail3 = [[
					gAj6iwdLgAgA/3gAj6iwdLgAgA/3gAj6iwdLgAgA/3gAj6iwdLgAgA/3gAj6iwdLgAgA/3f6kJivbgepgI/pgIkhisY1f0gT/LgakmipYQj1fx+zgNkniqYQ
					jZfc+2fwkniqYPe/fx/BfmkmipYQbxgY+vf7knirYQdfgi+7gVknipYPiKgF+9gXkmipYQkSfi+vf+knirYPhbfi/AfnkmipYQc4gF+4ftkniqYQcAgj+xgJ
					kmirYVfzgX/DgRkWitaDibf4/VgCkBiwcZgjf9/ygAj6iwdLgAgA/3gAj6iwdLgAgA/3gAj6iwdLgAgA/3]],
				Tail4 = [[
					gAkKkIccgAgA/ygAkKkIccgAgA/ygAkKkIccgAgA/ygAkKkIccgAgA/ygAkKkIccgAgA/yfykikEaOeSgJ/agHlIj7Wuedgx+kgvlQj0V9jlgK+KgflQj2V9
					ktfM9/frlRj4V9gWfL+WfPlPj0V9blgI+DfslQj4V9b/g8+FghlQj3V9hGgq+WgvlPj0V9k6fn9+gGlQj5V9jAfB+NfWlQj2V9dkfl+RfXlQj1V9bAgo99gI
					lPj5WFeTg6+Wgek3j+YTiRgE+9gFkVkGbZgxf7/pgAkKkIccgAgA/ygAkKkIccgAgA/ygAkKkIccgAgA/y]],
				Tail5 = [[
					gAkdleblgAgA/rgAkdleblgAgA/rgAkdleblgAgA/rgAkdleblgAgA/rgAkdlebkgAgA/rfplBlWY0eQgF/Hf9l5lFUidLhP9thCmEk5Toifg/9Yg5mDk6Tn
					lQfU9AfumFk/Toh5ec9Ze4mEk4TncUfZ9QfWmEk8TnbEhD9DglmFk+Toflhf9dhJmDk3TnkmgL9IgYmFk+TnkPer9KfKmFk8Toe7eu9ce8mDk4Tna4gR9Cf9
					mDlATxc3he9WgqlglMWdhjgf+fgJkulbaRg2f8/dgAkdleblgAgA/rgAkdleblgAgA/rgAkdleblgAgA/r]],
				Vortex = [[
					gAj5j4e5gAgA/+gAj5j4e/getS9FgAj5j4fRg24K08gAj5j4fshF+rpAgAj5j4gKhH/pbdf7kHj3gqhl63OugMkfj1imgvxSFOgakkjzi/exkrAigHkkj0ij
					exXEBbfskkj0i8fILEIBfokkjziieGDAS6gAkkj0gAdOAJgAgYkkjzdeeGDAtGgUkkj0dEfILE3/f5kkj0ddexXE+lfmkkjzdBexkr/efykkj0dLgwxS6wgO
					kjj0fQiz6wxSgQkUj1guiT/kkngBkAj3gdhT+qXAgAj5j4gvg24KLEgAj5j4hBgetSC7gAj5j4hHgAgAAC]],
				["FinB1.L"] = [[
					c9irg1mJMBgA4Nc9irg1mJMBgA4Nc9irg1mJMBgA4Nc9irg1mJMBgA4Nc9irg1mJMBgA4Nc9ixg1l6L9fu4Nc9i7g1liL2fR4Mc9i9g1ldL0fK4Mc9i9g1ld
					L0fK4Mc9i9g1ldL0fK4Mc9i9g1ldL0fK4Mc9i9g1ldL0fK4Mc9i9g1ldL0fK4Mc9i9g1ldL0fK4Mc9i9g1ldL0fK4Mc9i9g1ldL0fK4Mc9i9g1ldL0fK4Mc9
					i8g1leL0fL4Mc9i2g1ltL5fe4Nc9iug1mCL/f34Nc9irg1mJMBgA4Nc9irg1mJMBgA4Nc9irg1mJMBgA4N]],
				["FinB2.L"] = [[
					ZmhphWmkM2gA4wZmhphWmkM2gA4wZmhphWmkM2gA4wZmhphWmkM2gA4wZmhphWmkM2gA4wZlh0hWmWMxft4wZiiGhWl+MpfP4vZiiKhWl5MofJ4vZiiKhWl5
					MofJ4vZiiKhWl5MofJ4vZiiKhWl5MofJ4vZiiKhWl5MofJ4vZiiKhWl5MofJ4vZiiKhWl5MofJ4vZiiKhWl5MofJ4vZiiKhWl5MofJ4vZiiKhWl5MofJ4vZi
					iJhWl6MofK4vZjh+hWmJMtfd4wZlhuhWmdMzf34wZmhphWmkM2gA4wZmhphWmkM2gA4wZmhphWmkM2gA4w]],
				["FinB1.R"] = [[
					jDirg1mJz/gA4NjDirg1mJz/gA4NjDirg1mJz/gA4NjDirg1mJz/gA4NjDirg1mJz/gA4NjDixg1l60DgS4NjDi7g1li0Kgv4MjDi9g1ld0Mg24MjDi9g1ld
					0Mg24MjDi9g1ld0Mg24MjDi9g1ld0Mg24MjDi9g1ld0Mg24MjDi9g1ld0Mg24MjDi9g1ld0Mg24MjDi9g1ld0Mg24MjDi9g1ld0Mg24MjDi9g1ld0Mg24MjD
					i8g1le0Mg14MjDi2g1lt0Hgi4NjDiug1mC0BgJ4NjDirg1mJz/gA4NjDirg1mJz/gA4NjDirg1mJz/gA4N]],
				["FinB2.R"] = [[
					mahphWmkzKgA4wmahphWmkzKgA4wmahphWmkzKgA4wmahphWmkzKgA4wmahphWmkzKgA4wmbh0hWmWzPgT4wmeiGhWl+zXgx4vmeiKhWl5zYg34vmeiKhWl5
					zYg34vmeiKhWl5zYg34vmeiKhWl5zYg34vmeiKhWl5zYg34vmeiKhWl5zYg34vmeiKhWl5zYg34vmeiKhWl5zYg34vmeiKhWl5zYg34vmeiKhWl5zYg34vme
					iJhWl6zYg24vmdh+hWmJzTgj4wmbhuhWmdzNgJ4wmahphWmkzKgA4wmahphWmkzKgA4wmahphWmkzKgA4w]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Spine1 = [[
					gAjkgAAFgAgAh6gAjkgAAFgAgAh6gAjkgAAFgAgAh6gAkegAAFgAgHh6gAlugAATgPj0h5gAmUgACegusIhxgAmEgAJbhW2lhWgAlCgAWYh0+cglgAjkgAmg
					h4/RfngAjkgA0che4ieygAkLgA8ng2uLeTgAlhgA/hgUlKeHgAmRgA/7gCgbeGgAmLgA/7gAgAeGgAlSgA/7gAgAeGgAj4gA/7gAgAeGgAjkgA/7gAgAeGgA
					jkgA/7gAgAeGgAjkgA/7gAgAeGgAjkgA/7gAgAeGgAjkgA/7gAgAeG]],
				Spine2 = [[
					gAjtexAFgAgAh6gAjtexAFgAgAh6gAjtexAFgAgAh6f/koexAFgAgHh6ftl4e0ATgPj0h5fJmdfICegusIhxexmNgAJbhW2lhWfTlMhAWYh0+cglgfjthImg
					h4/RfnhNjtgO0che4ieyg/kVfQ8ng2uLeTgZlre2/hgUlKeHgCmaex/7gCgbeGgAmVex/7gAgAeGgAlcex/7gAgAeGgAkBex/7gAgAeGgAjtex/7gAgAeGgA
					jtex/7gAgAeGgAjtex/7gAgAeGgAjtex/7gAgAeGgAjtex/7gAgAeG]],
				Spine3 = [[
					gAj3djATgAgAkNgAj3djAegAgAlXgAj3djAkgAgAl3f/kxdjAkgBgHl3fbmBdnAygtjwl0eSmneQC7iPr9lbdjmWgAJxkJ2PkJemlViBWhlm9/hxg/j3iQma
					lv+ye0ibj3gc0Ikg4KcQh9keeh8Lint+awgyl0dr/Cg8lFaOgEmkdj/cgFgbaJgAmedj/cgAgAaJgAlldj/cgAgAaJgAkLdj/cgAgAaJgAj3dj/cgAgAaJgA
					j3dj/cgAgAaJgAj3dj/ggAgAadgAj3dj/pgAgAbVgAj3dj/tgAgAbz]],
				Spine4 = [[
					gAkLcXAagAgAlAgAkRcYA3gAgAnRgAkTcZBHgAgAoRf+lOcZBHgCgHoRfJmecgBVg/jsoNdenDdcDbjJrvnqcZmzgAKKl212l2d7lxi9Wrn59dighckTjUmT
					oG+QeUjjkTgqzymX3vati4k7d07sjrtuYmhJmQcl+ghVk/X2gGnAcZ+5gHgbXvgAm6cZ+5gAgAXvgAmCcZ+5gAgAXvgAkncZ+5gAgAXvgAkTcZ+5gAgAXvgA
					kTcZ+5gAgAXvgAkScZ/DgAgAYWgAkNcX/cgAgAaFgAkLcX/mgAgAbA]],
				Head = [[
					gAkkbMABgAgAgXgAk0bSASedf2j0gAk7bVAldYfnlWf+l1bVAffLf/lXe5nFbdAxiQkAlIcunrcrDGklsUj5bVnagAJ6k82cipdUmZj1WYk2+Bibh3k7kSmB
					lx+2hfkmk7g2z5li4YeTjulidL8QiYuAbNhfm4bk/GeqkwaXgInnbV/bddgCaogAnibV/hfJf4apgAmpbV/fhogPaqgAlObV/aixgaaqgAk7bV/fhogPaqgA
					k7bV/hfJf4apgAk2bT/nd3fwbmgAkqbO/7fXf/eOgAkkbM//gAgAfp]],
				Jaw = [[
					gAkOZ6//gAgAgMgCkxZ9/2hggdiggElAaB/sibhGjhf/l6aB/ygzgQjhejnKaM/ce8bjjrbwnwby83e/S6kOaBnfgC1+hcJFjjcjmek5p7jmB0gUiWlAlhao
					i9Axc7l4lAhIMahZHDcLkxlncYDhhkR5c2h3m9aUAkimbzc3gHntaBAUiegrchf/nnaBAOgygXcegCmuaBAQegfVcfgElUaBAVdde3cfgClAaBAQegfVcff/
					lAaBAOgygXcef9k3Z/AOiCgvdHf/kcZ7ADgpgFe4gAkOZ6ABgAgAf0]],
				["FinF1.L"] = [[
					c9iocIo5HjgAync9iocIiWEhc+v5c9iocIfHDzcCuic7jicJfSDicmuKcIkyc9b8FDcXwWbHlYfZWJKudy1ocIlHjDaRUtf89YgRkGk7c5kefp/hkWioiWcT
					z+hs4pkXiodtdh9OjPsXhPjPbOfs/skWf+eWklbXgC+qi0XVdElUcDkO88kJTwc9lPcIn67+luT8c9kWcIjD8okGSsc9i7cIg18UjyRoc9iocIg58Nj+Rec9
					iocIg58Nj+Rec9iocIe570jbQoc9iocIZp57hZObc9iocIXH4dgANZ]],
				["FinF2.L"] = [[
					aNhobIoCMtgA4OaRi5aninJLbc1yagjYaafyIKZx0ZagkMaVf2HyaW0HZjlybkcfJsZa1rYdm9fKWDQKZt5LaImJlLY1bmdN+vhIkrn2a7reee9ZnSjYi8Z8
					40hfzMmgjYbmbW+7kKlRhOkEYQd9+fmNY1cvlHYxfO7ok8QrbBmXZ9jQ5KnKN4bMmyaHmf4PpdOkaulTaNiM4lm1M1ahjpaXgM4AmCLvagjYaagO32mPLnag
					jYaagO32mPLnaWjGaiee3RlQKvaJiKa6aB07iAIqaNhobIX+zTgAHy]],
				["FinF1.R"] = [[
					jDiocIo54dgAynjDiocIiW7fjCv5jDiocIfH8Nj+uijBjicGfT8kjat+iDkybhc7+DkgpgfclYbGaj+WoggbcIlHc9gE9YlvUtbSkGhbiw1yhfIyewiokxkF
					ofgEBcjRiojtjoZHeJBCk8jPgFjRM1dIGxkIkldTg8FtdWOCjKlUcNkVDZb+S+jDlPcIn6ECaST8jDkWcIjDDYb6SsjDi7cIg1DscORojDiocIg5DzcCRejD
					iocIg5DzcCRejDiocIe5EMclQojDiocIZpGFenObjDiocIXHHjgANZ]],
				["FinF2.R"] = [[
					lzhobIoCzTgA4Olvi5anin21kk1ylgjYaafy32mP0ZlbkMaQf54Xlqz9jslyZFeJ60nPvxfPm9YcdW89remxaImJa1iz+vnLbmYQkrhmlC6ShrOkdMjYnVmJ
					vHe8EhkhjYmbk7gacLAonzkEg5jsTQanDam+lHcNg1KtbFIrlTmXaPjcHWY8NNk0myaHmfHxWjOklSlTaNiMHbZLM1lfjpaXgMIAZ+LvlgjYaagOIKZxLnlg
					jYaagOIKZxLnlqjGaieeIvawKvl3iKa6aBLFeAIqlzhobIX+MtgAHy]],
				Tail1 = [[
					gAjkgAe5gAgA/+gAjkgAe5iggG/4gAjkgAe5kPgJ/sgAkegAeKhfgG/5gAlugAdJhMgH/1gAmUgAcyn4g1+0gAmEgAdo0miB4SgAlCgAfa+ziOoTgAjkgAgY
					+KhDVagAjkgAg02GgxI6gAkLgAhcuMguDYgAlhgAimoqgvBVgAmRgAjQkpgfAigAmLgAjOhYgJANgAlSgAigdZfzAOgAj4gAhXbjf0AXgAjkgAhHdYf6AJgA
					jkgAhHhYgDAEgAjkgAhHjcgIAOgAjkgAhHhBgCADgAjkgAhHgAgAAC]],
				Tail2 = [[
					gAjqhZdxgAgA/6gOjqhXdyjzgL/sgXjqhVd0ohgT+wgIkphYcVkugL/bgHl+hXaUgogO/egqmmhMZoj6ho/EhWmVgObTxEj/6WgslPe0e0+VkcpDfJjqe7gv
					89iGSmeojqgEhmyqhiGHe6kUg1i4sLhbCmfSlwhLlKqYhdCOfnmjhTmao2g8B9f5mdhXmXkmgSBAgOlghWk/c3fmAkgYj/hVisXvfoBOgOjqhXiNZZf0Ayf4
					jqhYiPgjgGAGftjqhWiOl5gPApf6jqhYiPiRgFALgAjqhZiPgAgAAG]],
				Tail3 = [[
					gAj2iwdLgAgA/3gjj2itdMjmgQ/qhFj2ihdPrxgS9ngik9iqbEo7gD+UgKmdiqYCiPgF+5g9nKibXDhZiP+mihm2gxZms0lr8Chblodtej9HmKrpeGj2eCg8
					8biqRndUj2ggh6vHiAD8d8kmhzjvokiDBfeemNiMnKp/iMCje6nGiXo9r9hTDwfgm/ilo3owgKCjgfl8ipm6ehfPA0hEkOihjgVefjCAgyj2ioixVHf7CDf1
					j2iwizdtgQAOfNj2ioizmxgTA3fuj2ivi0jcgDAVgAj2iwi1gAgAAJ]],
				Tail4 = [[
					gAkGkIccgAgA/yg2kGkCcfh9gg/uiBkFjgcjtRgZ85hRlXjxZvs7f28lgWnIj3Vulkfj9xhBn6jmUSg6ia9pjZnihmX3o3nS8uiUmKcyek68n+vOc/kGdPhX
					82jRSocLkFhQiXsgiiCxdQk9i9kmkKi2Awdum2jLpHnkjWCeeBn0jJrgtQiAFVe0ntjirTsqf9E5gmmhj5o2h9ehBXh7khjkkbVOfQCOhrkFjqjdRrgCDngC
					kGkGjfZmgmA3epkGj4jgl4gjAxfbkGkFjjkPgDAggAkGkIjkgAgAAO]],
				Tail5 = [[
					gAkaleblgAgA/rhBkalYbrfRg7/rjDkXkYbxswg19BiRl2kmYXvwf26xgzn9k4Thppet7zhBo2kmRXidh38Rj6oWilVzmNog8bjZmzcNes4Bpyysb9kZcXiH
					94j4VebNkWiNjFrqi9Cic8lYkPlhgEjoAtdMnpkLq4jmk7CjdIoujtt+shjcGUd4oikJtpvVgFHeganQlEqrmPdiCniyk5kllaXCelB0ixkWkekQP0f8Ewgl
					kYlWkPVXhBCKeJkZlIkSjbhDAgfEkZlYkakegJApgAkalekbgAgAAV]],
				Vortex = [[
					gAj1j4e5gAgA/+gnj1j1gkiryz5vhBj1jvjsiX+LpqgXk7j1h/hT+UWEgSmbj0jBguyoGMh0nHjVjOYIfLBMjwm0goV1N8QGNjh7lmcsC5V6Xbfjdlj1c/Dc
					prqadvcJj1gLTryWuNNxc8kkiWhcuMguDYeAmLjRnMlfOkGwe6nDjplaeWCOV0frm9jygUchBupsgol5jyccgpNf51hEkNjuepkdgM/pgoj1j0gpiyyz5ufr
					j1j3eWgp+Xp7fLj1jydFiI+RWTfwj1j3gThfy0GLgAj1j4hHgAgAAC]],
				["FinB1.L"] = [[
					c9iog1mJMBgA4Nc9iog1kcLld94Ic9iog1jrLbdD4Cc9jig2j1K/dg3sdPkyhihLMybf5JeblYivbPTcZn8Ug1lHjDdxgIb0/oi+kGhFfGvzbk7cieioeBcX
					7udBvRfvioc3bZ/pfFgcdgjPeFbt9WhoUJc2klf0bs5GhSMsc8lUgwew2tkpJ/c9lPg1hs2VnhKbc9kWg1d41zkFJDc9i7g1cS0wizIHc9iog1cV0li9H+c9
					iog1cV0li9H+c9iog1b30giZH6c9iog1aj0Mg2H0c9iog1Z3z/gAHz]],
				["FinB2.L"] = [[
					ZmhlhWmkM2gA4wZeiLhWk7MXd64rZdibhWkMMMc/4kZcjRhPkWLwdd4PZ2lMighuNjbU5pcKm3lCbyUMZL8og7lmmkeGhBbV/kmAjyi5fNwlbF65leibcKcM
					8Gchuaf3ibZUbA/keufgbCjObhbM87hdTUZckOe4bM4dhPL/Zbl3gteL2DkwJZZtmqg6hB1vnsJ3ZbkohDdV1GkLIeZciuhTbx0Ai3HkZdibhWb0z0jBHcZd
					ibhWb0z0jBHcZdiRhWbXzuidHYZih0hWaGzYg3HRZmhlhWZczKgAHQ]],
				["FinB1.R"] = [[
					jDiog1mJz/gA4NjDiog1kc0biD4IjDiog1jr0li94CjDjig0j21Lie3ijKkygFiN4okHz4iwlYedhG82n6rUg1lHc9kM/oiPgId/kGdkjS8tc5Spc4iogdiJ
					zVb0G9epioi2f7lSbTA0hMjPi7esXqbmBeioklhxcUOXdbFtjClUg6e4J5bVJZjDlPg1hsJrYfKbjDkWg1d4KNb7JDjDi7g1cSLQdNIHjDiog1cVLbdDH+jD
					iog1cVLbdDH+jDiog1b3LgdnH6jDiog1ajL0fKH0jDiog1Z3MBgAHz]],
				["FinB2.R"] = [[
					mahlhWmkzKgA4wmiiLhWk7zpiG4rmjibhWkMz0jB4kmljRhJkX0aih4HmnlMfZiy4BkJ0ilFm3cOhz8hn1sEg7lmZckr/kh6hBbQjybVjf9CccTjZdibhYiH
					0BbTHmdgibmNfpmMa3BDjAjOl/eQYkbSBTl6kOjDb1PMdTFQmil3hEeTKlbNIzmTmqg6hBKRYUJ3mlkohDdVK6b1IemkiuhTbxMAdJHkmjibhWb0MMc/Hcmj
					ibhWb0MMc/HcmjiRhWbXMSdjHYmeh0hWaGMofJHRmahlhWZcM2gAHQ]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Spine1 = [[
					gAjggAAFgAgAh6gAjggaAFgAgAh6gAjggqAFgAgAh6gAjggmAFgAgEh6gAjggdAFf/frh6gAjggUAHf6efh6gAjggOAGf7euh6gAjpgMAFfofyh6gAlOgIAW
					bzgbh4gAnzgCCAVEgrhzgAp4gAFjOHhEhlgApFgAJhJVhXhWgAndgALdHkhehPgAn7gALfHjhehPgAoDgALfHjhehPgAncgALfHjhehPgAncgALfHjhehPgA
					ncgALfHjhehPgAncgALfHjhehPgAncgALfHjhehPgAncgALfHjhehPgAncgALfHjhehPgAncgALfHjhehP]],
				Spine2 = [[
					gAjpexAFgAgAh6gAjpfLAFgAgAh6gAjpfcAFgAgAh6gAjpfXAFgAgEh6gCjpfPAFf/frh6gHjpfGAHf6efh6gGjpfAAGf7euh6gBjze+AFfofyh6f9lXe5AW
					bzgbh4f6n7e0CAVEgrhzf3p8exFjOHhEhlf3pEexJhJVhXhWf3ncexLdHkhehPf3n5exLfHjhehPf3oBexLfHjhehPf3nbexLfHjhehPf3nbexLfHjhehPf3
					nbexLfHjhehPf3nbexLfHjhehPf3nbexLfHjhehPf3nbexLfHjhehPf3nbexLfHjhehPf3nbexLfHjhehP]],
				Spine3 = [[
					gAjzdjATgAgAkNgAjzd9AbgAgAlDgAjzeNAggAgAllf/jzeJAfgBgElcgDjzeAAcf9fslKgPjzd4Abfxegk3gNjzdxAYf0evkqgCj8dvAXfnf0knf5lgdrAn
					b2gskaf0oCdlCQVFg+kNfvp/djF2OHhUkMftpEdjJ5JXhokUftnadjL4HmhzkZftn4djL5HlhzkZftoAdjL5HlhzkZftnZdjL5HlhzkZftnZdjL5HlhzkZft
					nZdjL5HlhzkZftnZdjL5HlhzkZftnZdjL5HlhzkZftnZdjL5HlhzkZftnZdjL5HlhzkZftnZdjL5HlhzkZ]],
				Spine4 = [[
					gAkHcXAagAgAlAgAkLcyAugAgAmqgAkOdDA9gAgAnuf/kNc/A5gBgEncgFkMc2Axf8fsm5gWkKctArftehmSgTkJcmAmfxewl5gDkTckAjfmf1lzfzl1cfAx
					b3gwldfooTcZCbVCgxlMfeqNcXGJOCgtlifZpNcXKWJUg1mNfXnhcYMaHng+mjfXn/cYMbHmg+mjfXoHcYMbHmg+mjfXngcYMbHmg+mjfXngcYMbHmg+mjfX
					ngcYMbHmg+mjfXngcYMbHmg+mjfXngcYMbHmg+mjfXngcYMbHmg+mjfXngcYMbHmg+mjfXngcYMbHmg+mj]],
				Head = [[
					gAkgbMABgAgAgXgAkrbqASgAgAkFgAkzb9ArgAgAmcf/kxb4AjgAgHl0gGktbuAXgAfXklgdkpbkAVf+c/jQgYkmbdANf+ddiXgDkvbaAGfofjiJfsmPbVAV
					bzgThbfcoqbOCAVDedg2fLqhbNFwOOcPh0fApfbOJ7Jva1jqe8nxbPL+IKaYkpe8oPbPL/IKaYkqe8oXbPL/IKaYkqe8nwbPL/IKaYkqe8nwbPL/IKaYkqe8
					nwbPL/IKaYkqe8nwbPL/IKaYkqe8nwbPL/IKaYkqe8nwbPL/IKaYkqe8nwbPL/IKaYkqe8nwbPL/IKaYkq]],
				Jaw = [[
					gAkKZ6//gAgAgMgAkpaV/9gAgAhigAk9aq/5gAgAiaf+k4ak/6gCf5iLgJkuaa/8f4gohugtkjaS/0fnjAhOgmkbaK/4fxiig6gGkjaG/+gVggg1fwmAaC/s
					kOgBg5fxofZ999qxiih3frqqZ/6Ow+mfiTfcp+aF2V0gqGhcfToZaI0k1lrmgsfTo3aI0j1lrmgrfTo+aI0j1lrmgrfToYaI0j1lrmgrfToYaI0j1lrmgrfT
					oYaI0j1lrmgrfToYaI0j1lrmgrfToYaI0j1lrmgrfToYaI0j1lrmgrfToYaI0j1lrmgrfToYaI0j1lrmgr]],
				["FinF1.L"] = [[
					c9ijcIo5HjgAync9ijcimiG0ePyhc9ijcyk+GedHyYc8ijculYGldZyedCijchmOGjeDyPdVijcLnHGHe9xWdRijcHnqGafXxldCipcRoEHIfbyadRjhcSq4
					IehhyreRlIcKtKJkjXyUfvmtcIuCKGkFyKg+mCcIuEKHkGyJhdkocIt+KDkCyKhdlGcIt+KDkCyKhdlNcIt+KDkCyKhdkncIt+KDkCyKhdkncIt+KDkCyKhd
					kncIt+KDkCyKhdkncIt+KDkCyKhdkncIt+KDkCyKhdkncIt+KDkCyKhdkncIt+KDkCyKhdkncIt+KDkCyK]],
				["FinF2.L"] = [[
					aNhjbIoCMtgA4OaEiGbimKMCdt4HaCidbyk7LscP37aBiXbvlQL0cn4BaKiLbel7Ltdc34alh+a5mqLDeh3Lahh2a5nFLYfD3YaPh1bOnYMRfP4DatiEbUph
					Nih74QcEjNbKrAOQj436drkobIrMOXkI33e6j8bIqxOFji39fYijbIqfN7jL4AfZjBbIqeN7jK4AfZjJbIqeN7jK4AfZiibIqeN7jK4AfZiibIqeN7jK4AfZ
					iibIqeN7jK4AfZiibIqeN7jK4AfZiibIqeN7jK4AfZiibIqeN7jK4AfZiibIqeN7jK4AfZiibIqeN7jK4A]],
				["FinF1.R"] = [[
					jDijcIo54dgAynjDijcimi5MhxyhjDijcyk+5ii5yYjCijctlZ5fimyYjIijcpmL5FiFywjaijcwm/4JhuzujWijcmnl4HhQzkjIiycXnf4yhHyxjJlGcOkV
					5wjTyLi8pDcKbo5qpNwKiBsXcIQ51MvVqjg7sIcIKAt5yLj9gaqocIH+p/ylg2gZrGcIH9p9ylg0gZrOcIH9p9ylg0gZqncIH9p9ylg0gZqncIH9p9ylg0gZ
					qncIH9p9ylg0gZqncIH9p9ylg0gZqncIH9p9ylg0gZqncIH9p9ylg0gZqncIH9p9ylg0gZqncIH9p9ylg0]],
				["FinF2.R"] = [[
					lzhjbIoCzTgA4Ol8iGbimKz+iT4Hl+idbyk70Ujx37l9iXbslQ0RjY38mDiLbtl3z0is4RmXh+cBmfyriH5EmQh2b1m+ythh49l/iGbam6zihc4VmElJbMkW
					0kkZ3tlNq5bKc/0ssb0yh9vSbITzw90nste1uLbIOAqn3/jWdwr4bIMZnN4Me/dwsVbIMYnL4Me8dwsdbIMYnL4Me8dwr2bIMYnL4Me8dwr2bIMYnL4Me8dw
					r2bIMYnL4Me8dwr2bIMYnL4Me8dwr2bIMYnL4Me8dwr2bIMYnL4Me8dwr2bIMYnL4Me8dwr2bIMYnL4Me8]],
				Tail1 = [[
					gAjggAfKgAgA/+gAjggafKgAgA/+gAjggqfKgAgA/+gAjggmfKgGgA/+gAjggdfKfef//+gAjggUfLdef8/4gAjggOfLd4f8/6gAjpgMfLfmgX/+gAlOgIfJ
					gHkO/sgAnzgCfWfWq8+DgAp4gAf2evx56fgApFgAgceZ2p2hgAndgAgveS4b0lgAn7gAgweS4c0kgAoDgAgweS4c0kgAncgAgweS4c0kgAncgAgweS4c0kgA
					ncgAgweS4c0kgAncgAgweS4c0kgAncgAgweS4c0kgAncgAgweS4c0kgAncgAgweS4c0kgAncgAgweS4c0k]],
				Tail2 = [[
					gAjkhZeVgAgA/8gAjkhyeVgAgA/8gAjkiDeVgAgA/8gBjkh/eVgJgA/8f9jkh2eVfQf+/8fyjkhseVcef4/wf0jkhmeVdCf5/zf+juhleVfbgW/8gAlThgeT
					gEkO/qf7n2hbetesq7+Af6p1hYfsdfx06cf7o8hYg4cy2i2df9nThYhfcl4R0gf9nxhYhfcl4S0ff9n5hYhfcl4S0ff9nShYhfcl4S0ff9nShYhfcl4S0ff9
					nShYhfcl4S0ff9nShYhfcl4S0ff9nShYhfcl4S0ff9nShYhfcl4S0ff9nShYhfcl4S0ff9nShYhfcl4S0f]],
				Tail3 = [[
					gAjuixeBgAgA/7gAjujLeBgAgA/7gAjujbeBgAgA/7gBjujXeBgLgA/7f5jujOeBfCf+/6ffjujCeBbef4/mfkjui8eBcMf5/sf6j3i9eBfQgW/6f/ldi5d/
					gFkO/pfyn6izeieNq79+ftpviwf9chxy6Xfyosivhrbi2b2Uf3nAiuijbR4H0Vf3ndiuijbR4I0Tf3nliuijbR4I0Tf3m/iuijbR4I0Tf3m/iuijbR4I0Tf3
					m/iuijbR4I0Tf3m/iuijbR4I0Tf3m/iuijbR4I0Tf3m/iuijbR4I0Tf3m/iuijbR4I0Tf3m/iuijbR4I0T]],
				Tail4 = [[
					gAj5kJdjgAgA/5gAj5kjdjgAgA/5gAj5kzdjgAgA/5gCj5kvdjgOgA/5f0j5kmdje1f//4fGj5kWdkaef5/afPj5kSdjbWf6/jf2kCkVdkfFgW/4f+lokRdh
					gFkO/nfmn+kLeQdrq797fdpkkHgHbexw6OfooVkEiYaN2S2FfxmjkCjgZ3350EfxnBkCjhZ3360DfxnJkCjhZ3360DfxmikCjhZ3360DfxmikCjhZ3360Dfx
					mikCjhZ3360DfxmikCjhZ3360DfxmikCjhZ3360DfxmikCjhZ3360DfxmikCjhZ3360DfxmikCjhZ3360D]],
				Tail5 = [[
					gAkGlhc9gAgA/2gAkGl6c9gAgA/2gAkGmLc9gAgA/2gDkGmHc9gQgA/2ftkGl9c9enf//0eokGlpc+Zff6/Le2kGlmc+ahf7/XfxkPltc+e7gW/0f9l1loc7
					gDkN/kfXoDlid1dGq692fJpWlcgJaXxr6Dfbn1lWi9Yz2E1zfql9lSkXYY3mzufqmblSkYYY3nztfqmjlSkYYY3nztfql8lSkYYY3nztfql8lSkYYY3nztfq
					l8lSkYYY3nztfql8lSkYYY3nztfql8lSkYYY3nztfql8lSkYYY3nztfql8lSkYYY3nztfql8lSkYYY3nzt]],
				Vortex = [[
					gAjtj4fKgAgA/+gAjtkSfNgPo/+sgAjtkifTgdxG7BgCjtkefhgs3r1ff4jtkVfJgg8Uu3fZjtkJdWgM+5n4ffjtkEd2gx/4hKf5j2kEfug5/jaygAlckAgY
					gy82SOfzn5j6fsg42ZJLfupvj3fBgztOC6fzouj3ecgmk6Acf4nCj3eNggglAFf4nfj3eOgkfiAFf4nnj3eOgmfCAFf4nBj3ePgme7AGf4nBj3eOgmfBAFf4
					nBj3eOglfIAFf4nBj3eOgmfBAFf4nBj3ePgoefAHf4nBj3eRgsdVAMf4nBj3eUgzbVAbf4nBj3eZg9YUBB]],
				["FinB1.L"] = [[
					c9ijg1mJMBgA4Nc9ijhPkOLidt4Gc9ijhgi9LTcP36c9ijhcjTLacn4Ac8ijhPj+LPdb33c5ijg3kvKgeb3Jc5ijgzlKKye+3Wc+ipg/leLpfO4CdUjhg/nx
					Muh/4PeSlIg4pqNekY30fvmtg1qYN2lT3og+mCg1qaN3lV3nhdkog1qVN1lP3ohdlGg1qVN1lP3ohdlNg1qVN1lP3ohdkng1qVN1lP3ohdkng1qVN1lP3ohd
					kng1qVN1lP3ohdkng1qVN1lP3ohdkng1qVN1lP3ohdkng1qVN1lP3ohdkng1qVN1lP3ohdkng1qVN1lP3o]],
				["FinB2.L"] = [[
					ZmhhhWmkM2gA4wZeiLhwkuMTdp4pZciniBjgMDcJ4dZdifh+j0MKci4jZbiRhrkfMAdX4aZYiChClNLQea3vZbh4hDloLke937Zih1hcl7McfN4maLh9hioE
					Njh+4ybgi+hZpiOJj94cdJkVhWpvOPkO4ZeYjqhWpTOAjn4fe2iRhWpBN3jP4je2ivhWpBN3jP4je2i3hWpBN3jP4je2iQhWpBN3jP4je2iQhWpBN3jP4je2
					iQhWpBN3jP4je2iQhWpBN3jP4je2iQhWpBN3jP4je2iQhWpBN3jP4je2iQhWpBN3jP4je2iQhWpBN3jP4j]],
				["FinB1.R"] = [[
					jDijg1mJz/gA4NjDijhPkO0eiT4GjDijhgi90tjx36jDijhajT0sjY38jCijhWj70Siq4Ri9ijhckkzOiB5Fi+ijhSlEzThc4+jEixhElA0Hhb4UjNlHg7ib
					05kV3ti8pDg3bd0br+1CiBsXg1TBwZz9tug7sIg1NyqQ3qlJgaqog1MUnD4MhGgZrGg1MUnB4MhEgZrOg1MUnB4MhEgZqng1MUnB4MhEgZqng1MUnB4MhEgZ
					qng1MUnB4MhEgZqng1MUnB4MhEgZqng1MUnB4MhEgZqng1MUnB4MhEgZqng1MUnB4MhEgZqng1MUnB4MhE]],
				["FinB2.R"] = [[
					mahhhWmkzKgA4wmiiLhwkuztiX4pmkiniBjgz9j34dmkifh7j1z8jd4emhiRh8kbzhiu40mXiCiSlCyaiF5mmXh4iFlhyehf5fmgiIhplezUhd43mtlWhai8
					0Lkg4PljrahYbzz1st1Phxv3hWTJvp1Fs/eTudhWN8pK4hjbdKr9hWMllw4ve9dJsahWMklu4ve7dJsihWMklu4ve7dJr7hWMklu4ve7dJr7hWMklu4ve7dJ
					r7hWMklu4ve7dJr7hWMklu4ve7dJr7hWMklu4ve7dJr7hWMklu4ve7dJr7hWMklu4ve7dJr7hWMklu4ve7]],
			},
		},
	},
}
