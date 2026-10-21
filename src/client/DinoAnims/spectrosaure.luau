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
					gAiugADTgAgAuGgAiwgADYgEgHuQgAiygADcgIgOuZgAizgADggMgVuggAi0gADigPgbulgAi1gADjgSghumgAi0gADigVgmukgAizgADggXgquggAiygADd
					gZgsuZgAiwgADYgaguuQgAiugADTgbguuGgAirgADOgbgut8fXipgADShjimtvfXiogADOhiijtogAingADEgWgltogAingADDgUggtmgAingADEgQgbtogA
					iogADGgNgVtsgAipgADKgIgOtzgAirgADOgEgHt8gAisgADDgAgAtmgAisgACkf7f5shgAitgACgf3fysXgAivgACjfzfssfgAiwgAClfvfmsjgAiwgACmfr
					fgslgAiwgACmfofcsjgAivgACkfmfYsegAitgAChfkfWsXgAirgACjfjfUscgAirgACtfjfTs0gAiqgAC8fkfTtUgAipgADGfmfUtrgAiogADHfnfXtsgAin
					gADEfqfbtogAingADDfsfgtmgAingADEfwfltogAiogADGfzfrtsgAipgADKf4fytzgAirgADOf8f5t8]],
				Spine = [[
					gAjPfmEpgAgAwkgAjRfnE0gFgHw3gAjTfnE/gKgOxIf/jVfnFIgOgUxVf/jWfnFNgSgaxdf/jXfnFPgWgfxgf/jWfnFNgZgjxdf/jVfnFIgcgnxVf/jTfnE/
					gdgqxHf/jRfnE1gegrw2f/jPfmEpgfgswkf/jMfmEegegrwRfTjKfmEbhwiev7fTjIfmEThuicvuf/jHflEHgZgjvpf/jHflEFgWgfvmf/jHflEHgSgavpf/
					jIflEMgOgUvygAjKfmETgKgOwAgAjMfmEdgFgHwRgAjNflEJgAgAvugAjKfjDOf7f5t8gAjLfjDGf2fzttgBjNfjDNfyfst7gBjOfjDSftfnuEgBjOfjDTfq
					fhuHgBjOfjDSfmfduEgBjNfjDOfkfZt7gBjLfjDHfifXtsgBjKfjDJfhfVtygBjJfjDdfhfVuagBjKflD4fhfVvNgBjKflEMfjfWvxgBjIflEMfkfZvygBjH
					flEHfnfdvpgBjHflEFfqfhvmgBjHflEHfufmvpgBjIflEMfyfsvygAjKfmETf2fywAgAjMfmEdf7f5wR]],
				Neck1 = [[
					gAjzfTFpgigtyFgAj2fVFxgog2yRf/j4fWF5gtg9ycf/j6fWF/gyhDylf/j8fXGEg0hHyqf/j8fXGFg2hJysf+j8fXGEg3hJyqf+j6fWGAg2hIykf+j4fWF5
					g0hEycf+j2fVFygxg/yRf+jzfTFpgsg5yFf+jwfSFggngxx5fQjufSFgh5iXxqfQjrfRFZhyiNxif+jqfQFPgQgTxgf+jqfQFOgHgIxef/jqfQFPf+f9xgf/
					jrfQFTf1fyxmf/jtfRFZftfnxvgAjwfSFgflfcx5gAjwfQE+flffxFgAjqfKDof1fzuwgBjrfJDZf2fzuTgBjtfJDefxftudgBjufKDhftfnujgCjvfKDifp
					fiulgCjufKDhfmfdujgCjtfJDefjfaudgCjrfJDafhfYuTgCjpfJDifefUukgCjqfLECfafRvggCjsfOEtfbfSwpgCjtfQFNfgfYxdgCjrfQFTfofixmgCjq
					fQFPfwftxggCjqfQFOf5f4xegBjqfQFPgCgDxggBjrfQFTgLgOxmgBjtfRFZgTgZxvgAjwfSFggbgkx5]],
				Neck2 = [[
					f/kOfJF4hEhayYf/kRfKF9hLhlydf/kUfMGBhRhtyif+kWfNGFhUhyymf+kYfOGHhWh1ypf+kYfOGIhVh0yqf+kYfOGHhThwypf9kWfNGEhPhqynf9kUfMGB
					hJhgyjf9kRfKF8hBhVyef9kOfJF3g4hHyYf9kLfHFygtg4yTfOkJfHF1h8iVyJfOkHfGFwhviDyGf+kFfEFpgFgEyHf+kFfEFof3fzyGf/kFfEFpfpfhyHf/
					kHfFFrfcfQyJgAkJfGFvfPfByNgAkLfHFzfFeyySgAkKfDFEfKe+xMgBkCe5DYfvftuRgBkCe3DDf2fztngBkEe4DGfyfstrgCkGe5DHfufmtugCkHe5DIfq
					fhtvgCkGe5DIfnfdtugDkEe4DGfkfZtrgDkCe3DEfifXtmgDkBe4DSfdfSuDgDkDe8D8fWfMvUgDkGfBE0fXfNw0gCkIfEFgfffZx5gCkHfFFrftfqyKgCkF
					fEFpf7f8yHgCkFfEFogJgNyGgBkFfEFpgXgfyHgBkHfFFrgkgwyJgAkJfGFvgxg/yNgAkLfHFzg7hOyS]],
				Neck3 = [[
					f/kjfBGJhmiHypf+kmfDGKhviUyof+kpfFGLh0idyof9krfGGLh3iiynf9ktfHGLh3iiynf9ktfHGLh0ifynf9ktfHGKhviXyof9krfGGJhoiMypf9kpfFGI
					heh8yqf9kmfDGHhShqyqf9kjfBGGhEhVyrf9kgfAGFgzg+ysfNkee/GLh/iSyofNkbe+GJhth5ypf+kae8GDf7f1ytf/kZe8GEfnfdytf/kae8GEfUfFysgA
					kbe9GFfCevyrgAkde+GHeyebyrgBkgfAGIeleIyqgBkee6FKevedxSgBkUerDJfpfntygBkTepCvf3fys5gCkWeqCvfyfss5gCkXerCvfufms5gCkYerCvfr
					fhs5gDkXerCvfofcs5gDkWeqCvflfYs5gDkTepCvfjfWs5gDkTeqDCfbfPthgDkWewD2fSfGvIgDkae3E7fSfIw+gDkce8FzfffZyVgCkbe9GDfyfyytgCka
					e8GDgFgLytgBkZe8GEgZgjytgBkae8GEgsg7ysgAkbe9GFg+hRyrgAkde+GHhOhlyrf/kgfAGIhbh4yq]],
				Head = [[
					f+k4e6AMehithLf9k7e8AOeMi8hOf9k+e+ARd5jHhQf8lAe/ASdqjNhSf8lCfAATdfjOhTf8lCfAAUdYjKhTf7lCfAATdWjBhTf7lAe/ARdZizhRf8k+e+AP
					dfihhPf8k7e8ANdqiKhNf8k4e6AKd4hxhKf9k1e5AHeKhUhIfMkze4ANevjDhMfMkwe3AKfGikhJf+kve1ADfKf2hCf/kue1ADfjfWhCgAkve1ADf8e3hDgA
					kwe2AFgWeZhEgBkye3AHgvd/hGgCk1e5AJhIdnhJgCkzexAGg/d9gbgBkledADgKfdergBkkeaAEf+fweQgCkmebAEf9foeQgCknecAEf8fheQgDkoecAEf7
					faeQgDknecAFf7fVeQgEkmebAFf6fReQgEkkeaAFf5fNeQgEkkecACgFfDfqgEkoejADgpeyfUgEkuetAGhRevepgDkxe1AHhafNh4gCkwe2AHhMftiCgCkv
					e1ACg1gHfdgBkue1ADgdgqhCgAkve1AEgFhJhcgAkwe2AFfqhnhEf/kye3AHfRiBhGf+k1e5AJe4iZhJ]],
				Jaw = [[
					f3lJed/th0dhi7f2lMef/piNdWjOf1lOeg/lijdPjff0lQei/hi0dNjtfzlSej/fjAdPj2fzlSej/fjGdUj5fzlSei/gjHddj2f0lQei/ijBdqjuf0lOeg/m
					i3d5jgf1lLee/qioeMjPf3lIec/viVeii9f4lFeb/xiAe8jAfFlDeb/shpdJi6fHlBeZ/vhPdli+f+k/eX/1g0gRjFgAk/eX/1gXgujGgCk/eX/0f6hJjFgE
					lBeY/zfdhjjDgGlDeZ/xfBh6jBgHlGeb/veliOi+gHlBeS/TeohzmKgCkxd98zfpgct6gCkud57yf7gQv2gDkxd67qf4gXwEgDkyd77lf1gewMgEkzd77jfz
					gjwPgFkyd77lfxgpwMgFkxd67qfwgtwEgFkud57yfwgwv2gGkxd88/fjg2tegHk1eE9Ge7g3tOgHk5eN9JeXgutFgGlDeX/teegij8gElCeZ/0eygHjHgCk8
					eV+jfPfqpcgAk/eX/jfsfRlOf+lAeX/2gFe3itf8lBeY/zgjedjDf6lDeZ/xg/eGjBf5lGeb/vhbdyi+]],
				Crest = [[
					fwm6e4LCg8i839ftm9e6LEg5jW37fqm/e9LJg0jr39fonBe+LRgvj54CfmnCe/LbgqkC4JflnDfALngkkE4TfknCe/Lzgej/4eflnBe+L9gXj04ofmm/e8MG
					gQji4yfom9e6MMgHjM46fqm6e4MOf+iw4/ftm3e1MMf0iR5BfAm1e2MShgi849fEmze0MHhWiX45f3mxewL0fVgi4zf7mxewLofNf64pgAmxexLcfHfS4fgE
					mzeyLSfDer4UgIm1ezLJfBeG4KgMm4e2LEfBdj4CgLm1eoK1fKd634gDmmeFKdfsfi3ogBmjd/Kafyf33mgCmmeAKgfrfz3rgDmneAKpflfv3zgDmoeBK0fg
					fs39gDmneALBfbfq4IgEmmeALNfXfo4TgEmjd/LZfUfn4cgGmleMMcfSfX5SgLmqeRL0fcew4xgPmueWKzf0eO34gPmze3M2gTea5kgMmze6Mwgje55hgImw
					ejKngofd3xgFmxewLogzgG4pgBmye0Lwg6gt4vf8mzeyLSg9hV4Uf4m1ezLJg/h64Kf0m4e2LEg/id4C]],
				["Humerus.L"] = [[
					fRjxfWcjGaZixvfRj0fXccGlZFxzfRj2fZcVGwYrx2fQj4facPG6YXx6fQj5fbcLHCYKx+fQj6fbcIHGYGyDfQj5fbcIHIYLyHfQj4fbcJHHYZyMfQj2facM
					HEYuyRfPj0fZcQG/ZJyVfPjxfYcWG5ZmyZfPjufXcbGzaEyceijsfdb+IFao0JeijqfccDIAa80JfQjofVcoGkbBycfQjofUcqGgbGyYfQjofUcrGdbByTfQ
					jpfUcrGbazyLfRjrfVcpGaadyDfRjufVcmGZaBx5fRjufTY1HZaCyLfSjofMQyLQa4ySfSjpfLPIMgawyMfSjrfLPLMkaYyLfTjsfLPNMkaIyJfTjtfLPPMi
					aByGfTjsfLPRMdaDyCfTjrfKPRMUaOx9fTjofJPSMKaix4fTjnfKQdLJatx2fTjofMTzJDaox1fTjqfPYQHFafxpfTjqfRb4GBagxWfTjpfRc8FyavxSfTjo
					fRc9Fza+xYfTjnfRc8F1bDxdfTjofRc6F5a+xhfSjpfSc2F/awxlfSjrfTcxGHabxpfSjufUcrGQaAxs]],
				["Forearm.L"] = [[
					eIkXe8gXV1Zg9neIkce+giV/ZE9leJkhfBgtWKYr9ieJkkfDg0WUYX9geJkmfFg4WdYK9feJknfGg5WkYG9geIkmfHg1WoYK9jeIkkfGguWqYW9neHkhfFgk
					WqYp9seGkdfEgYWpZB9xeFkYfCgLWmZc93eEkTfAf+WjZ498dUkQfQfVYnaG+jdTkMfPfNYjaa+leDkIe8fjWXax+DeDkHe7fiWSa2+CeEkIe6fmWMay9/eE
					kKe6ftWGam97eFkOe6f5WAaT92eHkSe7gHV6Z79veNkde6a6SlYH7eeekqeyQsMzaAzlelkuexPKL3bDxmemkxeyPML7arxlenkzeyPOL8abxjeok0eyPQL6
					aUxgeokzexPSL0aWxceokxewPTLsaixXenkueuPULia1xReikpetQYMBaKymeZkiewUBN7Yk2TeQkYeyZxRFYX6heLkPeyeqUGZ29AeJkKexf8VDas9leIkH
					exf0VHa59oeIkHeyfxVLa99reHkHezfyVRa49seHkKe0f3VZaq9seHkOe2gAVhaW9seIkSe5gLVqZ89q]],
				["WingFinger1.L"] = [[
					dWkgf/pKn/kJ9TdXklgCpgoJjk9OdYkpgFp1oPjH9JdZksgIqHoSi29DdZkugKqUoSix8/dakvgMqcoOi589dakugMqdoHjN88dZksgMqYn/jq89dYkpgLqN
					n4kP8+dXklgJp+nxk38/dWkhgIpsnule8/dVkdgGpYntmB8+cvkbgbpkpqlm8acvkXgapUpul28bdUkTgBonn3mv9BdTkSf/ofn8mn9EdTkTf/ocoAmT9IdU
					kVf+ogoDl29MdUkYf+opoElT9QdVkcf+o4oDkt9SdWlFfsjEgGdz/xdwluejTSN9aJ2Yd4lweTREKubcyDd7l0eVRFKwbEyBd9l2eWRHKwa0x+d+l3eVRJKu
					atx7d+l2eURKKpawx3d9lzeSRMKha8xyd7lvePRNKYbQxud0lseYSyMYaj00dllke3YtTCaQ7vdWlGfbhjcyen/wdTkhfvnYkXlB+adUkTfyoemenO9SdTkR
					fyoSmrnO9SdTkRfzoNm5nC9UdTkSf0oOnImp9VdTkUf2oWnYmH9XdUkXf5ojnmle9XdVkcf7o1n0kz9W]],
				["WingFinger2.L"] = [[
					eBj7g5tjo1g+7leCj9g7t3o5gY7beDkAg9uLo8f77QeEkBg/ubo9fp7HeEkChAuno8fl7AeFkDhBuvo6ft69eEkChCuwo3gC69eEkBhCuso0gg7AeEkAhCui
					oyhG7FeDj9hCuUoyhu7LeDj7hBuDoziW7QeCj5hAtwo3i47Vdkj4hQtuqwiL6vdjj2hOteq1ia6zeBjzg9tApHjk7ieBjzg8s4pKjb7meBjzg7s2pKjH7qeB
					j1g6s6pIip7seBj2g5tDpDiG7seBj5g5tSo9hh7pdWk2g8nufyb4+xc7msenW0MuaW3JdGmqd5UOJhb6zCdKmvd7UQJhbjy+dMmzd8USJgbTy6dNm0d8UTJd
					bMy2dNmyd6UVJZbQyydMmvd3UWJSbdyudJmpdzUXJLbyyrc+mpeQWOLMa71oczmQflc3SBZ/79dGk/grmScldJ/DdukBg1sClUia9Ed7jzgys/n0kQ72d8jy
					gyszoAkP74d8jygystoLkA76d9jzgzstoWjl76d+j0g0s0ogjB75d/j2g1tAooiW71eAj4g3tQovhp7u]],
				["WingFinger3.L"] = [[
					enjFhdx9p/eT4denjGheyPp9du4NenjHhfyhp7dS3+enjHhfyvp5dB3xenjIhgy6p4c93oenjIhhzBp4dG3keojIhizCp5db3leojIhiy+p7d53repjHhjy1
					qAee3zeqjHhjynqGfF39erjGhkyXqPfr4HerjFhkyEqYgM4ReSjGhux2sFfL3oeTjFhuxosNfY3vetjEhjxWqtgz4petjEhixPqugp4tesjEhhxOqrgU4wer
					jEhgxSqkf44weqjEhfxdqZfX4teojFhexrqNe04mdQkTh/smgIah85cBncevafMLam35cOnYdmXdI6cR0EcTnfdoXfI4b6z+cWnjdpXhI2bqz5cXnkdoXiIy
					blz0cXnidmXkIubpzxcVnediXlIpb2zucRnXdeXmIjcMzscEnYeNZwKpbS2fb8mqgShNRyaA8Ac0kkhurLdHcL9leJjQhmwrmxgR6cejjDhbxcpkhs5AekjD
					hbxQpvho5EeljDhcxKp4hX5GemjDhcxKp+g75EenjDhcxRqBgW5AenjEhdxcqBfr43enjFhdxrqAe+4s]],
				["Humerus.R"] = [[
					gvjxfWcj5mmexvguj0fXch5km8xlguj2fXce5inYxcguj4fYcd5hnuxUguj5fYcc5hn8xNgtj6fYcd5koCxHgtj5fXcg5on9xEgtj4fXcj5unwxBgtj2fWcn
					51nbxBgtjzfVcs58m/xCgtjxfTcx6DmhxFgtjufSc26ImCxJf+jrfMdd7WltvYf+jpfLdf7YlWvegtjofRc96NlCxYgtjnfRc86Lk9xdgtjofRc66HlCxhgu
					jpfSc26BlQxlgujrfTcx55llxpgujufUcr5wmAxsgvjufTY14nl+yLgvjofNQt0llCydgvjpfMO/zKlDyegwjrfNO9y8lUymgwjtfOO8yyleysgwjtfPO6ys
					lfywgwjtfPO4yqlZyygwjrfOO3ytlKyzgxjpfOO2yzk0yxgxjofOQBzykqy1gxjpfRTW16k5y9gxjqfTX138lOy3gxjrfVbf5ElYylgwjqfVcl5YlMyegwjo
					fVco5ck/ycgwjofUcq5gk6yYgwjofUcr5jk/yTgwjpfUcr5llNyLgvjrfVcp5mljyDgvjufVcm5nl/x5]],
				["Forearm.R"] = [[
					h4kXe8gXqLmg9nh3kce8gmqQm69fh1kge9g1qUnT9Yh0kke+hAqYnm9Rhzkme+hIqdny9Mhzkne+hMqin19Jhzkme9hLqonx9Ihzkke7hGqunk9Khzkge5g9
					q0nQ9Nh0kce3gxq5m39Rh1kXe1gjq9mb9Wh2kSe0gUq/mA9chDkMejgktAla8uhEkIeigYs/lG8yh4kHexf0q5lH9oh4kHeyfxq1lD9rh5kHezfyqvlI9sh5
					kKe0f3qnlW9sh5kOe2gAqflq9sh4kSe5gLqWmE9qhzkde6a6tbn57ehikqe0QnzCl6zvhdkve0PBzzkvx5hckye2O/zmlAyBhck0e4O9zclKyHhck1e5O7zW
					lMyMhck0e5O6zUlFyOhdkze4O5zXk2yOhfkve3O4zdkhyNhjkre3P7y3lOzihtkke7TgwznA3Jh2kae+ZTtgne7Nh8kQe+eTqdmP9ih9kLe9fppklc+Ch9kI
					e8fjpplP+Dh9kHe7fipulK+Ch8kIe6fmp0lO9/h8kKe6ftp6la97h7kOe6f5qAlt92h5kSe7gHqGmF9v]],
				["WingFinger1.R"] = [[
					iqkgf/pKYBb39Tipklf/peYGcW9SiokpgApxYOct9RioksgAqCYZc59PinkugAqOYnc59Oinkvf/qUY2cs9Pinkuf+qTZHcU9Qioksf8qLZWbz9Siokpf6p+
					ZkbM9Uipkkf4psZtaj9Viqkgf2pXZyZ79Virkbf0pCZxZZ9UiBkVfboLbrYO9niCkRfan6bhYB9nitkRfyoSZVYy9SitkRfzoNZHY+9UitkSf0oOY4ZX9Vit
					kUf2oWYoZ59XiskXf5ojYaai9Xirkcf7o1YMbN9WiqlFfsjEf6iN/xiRlvemTNx2lz2hiKlweYQ709kYyYiIl1ebQ40xkqyfiHl4eeQ20nk1yliHl5efQ00h
					k3yqiIl4efQz0fkwysiKl1eeQy0hkiytiMlxecQy0mkMytiSlvemSVybk+1vielnfHYUrdll8UiqlIfshdhnhr/3itkjgAnpaLbg+LiskVgCo0YOZV8/iskT
					gBonYJZR9BitkSf/ofYEZZ9EitkTf/ocYAZt9IiskVf+ogX9aK9MiskYf+opX8at9Qirkcf+o4X9bT9S]],
				["WingFinger2.R"] = [[
					h/j7g5tjXLfC7lh/j9g5t3XVfg7fh/j/g5uKXgf17Zh/kBg5ubXsf/7UiAkCg4unX4f97RiAkCg4uuYFfu7RiBkCg3uvYRfU7UiCkBg2uoYbex7ZiDj/g1uc
					YjeI7fiDj9g0uMYmdd7liEj6gzt4Ylc17riEj3gytjYgcT7vhijzgfs4aPa28PhijygfsnaEar8TiEjygyszYAbx74iEjygystX1cA76iDjzgzstXqcb76iC
					j0g0s0Xgc/75iBj2g1tAXYdq71iAj4g3tQXReX7uiqk2g8nugOkI+xjGmteqWwzFln3Si9mrd/UG2Jj9zYi6mxeEUD1/kRzei5m1eHUB12kdzji4m2eJT/1x
					kgzni6m1eJT+1vkazri8myeIT91vkLzti/mseFT91yj1zujHmtekVxzmky2njLmUf6ccsfmE8mizlBg9mHh4jZ/KiLkChDsKZVeV8xh/j1g+tNW+cf7eh/jz
					g9tAW5cc7ih/jzg8s4W2cl7mh/jzg7s2W2c57qh/j1g6s6W4dX7sh/j2g5tDW9d67sh/j5g5tSXDef7p]],
				["WingFinger3.R"] = [[
					hZjFhdx9WBht4dhbjGhdyQWPiI4ThcjHhcyjWdia4IhejHhbyzWqih4AhfjIhay/W1ic37hgjIhazGW/iL37hgjIhazHXGhv3/hhjHhazCXKhL4HhhjHhay3
					XKgi4RhgjGhaynXGf44chgjFhayUW+fS4nhfjEhax/W0ey4xhBjDhNxeYRdE5fhAjChNxNYFc85mhcjDhbxQWReY5EhbjDhcxKWIep5GhajDhcxKWCfF5EhZ
					jDhcxRV/fq5AhZjEhdxcV/gV43hZjFhdxrWAhC4siwkTh/smf4lf85j/ncezabzola4Cj1nadtXV2wjq0bjynhdzXT2nj/0fjvnld3XQ2gkM0kjvnnd5XP2b
					kQ0ojwnmd6XN2YkK0sjznid4XN2Xj70vj4nbd2XN2Zjl0ykBndenZU0Ikn3fj9mugsgyswmS8pi/kniCq9hckl9rhsjRhywtYBgs6FhTjEhjxiVXfP4ihTjE
					hjxWVTfN4phTjEhixPVSfX4thUjEhhxOVVfs4whVjEhgxSVcgI4whWjEhfxdVngp4thYjFhexrVzhM4m]],
				Tail1 = [[
					gAiugAxxgAgA6mgAiwgAx9gcfr6egAiygAyNg1fX6SgAizgAyghKfH6DgAi0gAyzhZe650gAi1gAzGhgez5lgAi0gAzWhgex5ZgAizgAzihae15QgAiygAzp
					hNe+5MgAiwgAzqg8fM5NgAiugAzlgofc5SgAirgAzZgUfu5bfXipgAzGhreg5kfXiogAy0haev5zgAingAyifjgZ6EgAingAyOfcgf6SgAingAx9fagg6dgA
					iogAxxfdgd6lgAipgAxrfmgV6qgAirgAxrfygL6qgAisgAxIgAgA7BgAisgAvwgbfq71gAitgAvvg3fS71gAivgAwOhJfB7igAiwgAwvhTe27NgAiwgAxRhS
					e063gAiwgAxxhIe76kgAivgAyKg0fM6UgAitgAybgafl6JgAirgAypf6gG5/gAirgAy4fagm50gAiqgAzCfCg75rgAipgAzCezhG5qgAiogAy0ephO5zgAin
					gAygeihS6BgAingAyMeihR6PgAingAx8eqhJ6bgAiogAxwe4g76kgAipgAxqfMgq6pgAirgAxrflgW6q]],
				Tail2 = [[
					gAiGgRv+ezg87rgAiIgQwAftgS7sgBiJgPwMgqfm7lgBiKgOwghke97WgBiLgNw5iWeZ7BgBiLgMxWi6d96pgBiKgLx0jOds6RgBiJgLySjQdn58gBiIgKys
					jBdv5sgBiGgLy/iieD5jgAiEgLzKh3ei5hgAiCgLzKhEfJ5lfYiAgMy8h5eW5pfYh/gNyrhGfB57gAh+gOyQeuhF6Nf/h+gPxweLhh6gf/h/gQxOd2hy60f/
					iAgRwvdvh27GgAiCgRwWd4ht7XgAiEgRwFePhZ7kgAiFgSvKemhJ8HgBiHgWtIfRgt9JgBiIgWs3gjfs9SgBiJgVtXh0er8+gBiJgTuDi3dz8ggBiJgSu4jn
					dL78gBiIgQvyj9c27XgBiGgPwsj5c261gAiEgPxgjadN6agAiDgOyPiceC6GgAiBgNyyhKfL53f/iBgNzAf8gM5uf/iAgMy9fCg65vf/h/gNypeThe55f/h+
					gOyNdsh96If/h+gPxsdRiS6af/h/gQxKdFiZ6uf/iAgQwsdJiT7Cf/iCgRwUddiA7UgAiEgRwEeChi7j]],
				Tail3 = [[
					f+hggmt8cRiv8bgAhigmtvdWh+8sgChjgktueuhD82gDhkgit4gRgD80gEhkgguLh1fD8mgFhkgdumjReK8OgFhigbvHkadb7vgEhhgZvrlKc77PgEhfgXwR
					lccs6zgDhcgXw1lQcw6fgChagXxUkndG6VgBhYgYxrjldt6UfahXgZxtj/dK6MfZhWgbxsiieJ6ef+hVgdxdfVgm6zf+hWgfw8d+hl7Bf9hXgiwSc3iZ7Qf9
					hZgkvlcGi87gf9hcglu6bujM7zf+hegmuVbyjH8Hf+hhgqtCbpjW8sgAhmgzqabrjz9sgChogzpudaih+QgEhogxp9fsgw+ZgGhngtqeiDfA+JgGhlgprPkO
					dd9jgGhiglsMl9cQ8ugFhfgitRnFbe73gEhcgfuangbL7IgChagcvrm2bp6rgBhYgaw4lGc46hgAhXgZxni+eU6ff+hWgZx2hIfh6hf+hWgbxwfqgg6mf9hV
					gdxaeShd6vf8hWgfw4dDiT66f8hXghwOcFi+7If8hZgjvhbfjY7Zf8hcglu3bTje7uf9hegmuUbkjQ8E]],
			},
		},
		Walk = {
			loop = true,
			fps = 15,
			frames = 15,
			bones = {
				Hips = [[
					gAi8gAC0gAgAtGgAjBgAC1gTgftGgAjCgAC1gjg4tFgAjAgAC2gthItFgAi6gAC2gvhLtFgAi1gAC2gphBtFgAi1gAC1gcgstFgAi5gAC0gKgQtGgAi+gAC0
					f2fwtGgAjCgAC1fkfUtFgAjCgAC2fXe/tFgAi9gAC2fRe1tFgAi3gAC2fTe4tFgAi1gAC1fdfItFgAi2gAC1ftfhtG]],
				Spine = [[
					gAjbfkD7gAgAvUf/jgfkD0gVgdvHf+jifkD5gng1vOf+jffkEGgzhEvlf+jZfkEUg3hGv8f+jVfkEYgwg9wEf/jUfkEQgggpv4gAjYfkEBgLgPvggAjefkD2
					f1fxvLgBjifkD1fhfWvIgCjhfkD/fSfCvZgCjcfkEOfKe6vygCjXfkEXfMe9wDgCjUfkEVfXfMwBgBjWfkEJfqfjvt]],
				Neck1 = [[
					gAj9fOE2gAgAw6f/kCfNErgRgVwnf9kEfOEygfgmwyf9kCfPFIgpgvxUf9j9fQFegtgvx1f9j4fQFlgogpyAf+j3fPFZgagcxuf/j7fOFBgJgKxLgBkAfOEu
					f3f1wtgCkEfOEsfofiwpgDkDfOE8fbfVxCgDj/fPFUfUfQxmgDj6fQFkfVfTx+gCj3fQFhfefdx7gBj5fPFNfufsxe]],
				Neck2 = [[
					gAkYfBFEgAgAxPf+kcfAE0gLgNw2f9kefBE+gUgXxGf8kdfDFbgcgcxyf8kYfFF5gggbyef9kUfFGDgdgXysf+kTfEFygTgQyVf/kVfCFSgGgGxmgBkafAE5
					f6f5w+gCkefAE2fwftw5gEkefCFLfnflxagEkbfEFrfhfkyKgEkWfFGCfhfnyqgDkTfFF+fofsylgCkUfDFjf0f0x+]],
				Neck3 = [[
					gAkse4FRgAgAxkf+kwe2E+gFgGxGf9kye3FKgJgJxZf8kxe6FvgPgJyQf8kte9GVgTgHzFf9kpe+GjgRgFzXf+kne8GNgLgEy6f/kqe5FkgDgCyAgBkue3FE
					f9f9xPgDkye2FAf5f4xJgEkye4Faf0f2xygEkve8GEfuf4ytgEkre+Ghftf6zUgDkoe+Gcfxf7zOgCkoe7F5f5f8yf]],
				Head = [[
					gAlAevACgAgAgyf+lEetABgBgHgOf9lHeuABgDgNgkf8lGeyAEgIgQhmf8lCe3AIgMgQiof9k+e4AKgMgOi/f+k9e2AHgHgKibf/k+exADgBgEhUgBlCetAB
					f/f8gZgDlGetABf+f2gSgElHewACf7fxhCgElEe1AGf1fwiLgDlAe4AKfzfxi7gDk9e3AJf2f0i0gCk9e0AFf8f5h5]],
				Jaw = [[
					gAlQeQ/0gAgAjWf+lTeN/wgAf5j6f8lWeP/yf/fzjjf8lXeV/5f6fviif8lVea/9f2fvhff9lSec/+f2fxhJf+lPeZ/8f6f2htf/lPeT/3f/f8i0gBlReO/x
					gAgEjugDlVeO/wgAgLj2gElXeS/1gDgPjGgElXeY/7gIgSh9gElUec/9gLgRhNgDlQeb/9gIgNhUgClPeW/6gDgHiP]],
				Crest = [[
					gAnDeoLPgAgA4Vf+nGehKzgGgE39f9nJelLEgMgG4Mf9nJeyL3gRgF42f+nFe/MrgUgB5ff+nAfDM9gSgA5sf/m/e8MggMgB5Xf/nBevLpgEgB4qgBnFejK8
					f9f+4EgDnIeiK2f3f63/gDnJerLbfxf64fgDnHe5MTftf95NgCnCfDM6fsgA5qgCm/fBM0fxf/5mgBnAe2MGf4f+5C]],
				["Humerus.L"] = [[
					fRj7fRYrQ4h67JfQkAfSYCRehT7VfPkDfUXxR9gp7ifOkAfVX4SRgF7ufOj7fWYKSWfz72fPj3fWYcSJf870fQj2fUYlRugj7ofRj5fSYoRKhc7UfSj+fPYx
					QmiX6+fTkBfOZHQFjF6sfUkBfNZpPrjd6ifVj9fOaKPdjg6hfUj4fPaZPfjS6nfUj1fPaJPxi66xfTj2fQZfQRid6+]],
				["Forearm.L"] = [[
					eJkYf4ahXDlr9reLkif6aGXpk696eMkof9aCYGkM+IeOkmgBaSYWjp+UeOkhgDapYYja+aeNkbgDa3YKjo+XeMkXf/a0XykS+LeKkXf6anXTlM93eIkZf1ae
					WzmJ9geIkYfyamWUm89MeHkUfwa/V4nc8/eHkNfwbcVnnl87eHkIfybuVmnb9AeHkHf0bmV4nA9MeIkOf2bHWamZ9c]],
				["WingFinger1.L"] = [[
					dYkrg6dUgknK/Dddk5g9c+hJmD/PdhlAhCdxhZl0/Wdkk+hGfNhVmM/Wdlk3hJgYhGmt/QdjkwhIgfg7nA/MdfkrhEfeg1nB/Mdakrg9d9gtnC/IdWkqg2c5
					gYnb+9dTkngyc7f7od+sdQkggwd9fcp4+WdPkWgwfRfErC+AdQkQgxf+e9rU96dRkRg0fofPqf+NdUkbg3eef2o3+t]],
				["WingFinger2.L"] = [[
					dYk5iKf+hMk2/mdflJiNgihqjz/tdmlMiSiqh8jr/ndqlEiXk+iCkI/Rdrk3ibl/h9kq/BdokuialBh0k4/KdjkviVithokx/edck1iOgihWkt/ndUk6iHf6
					hBlM/jdOk2iChKgzmd/TdKkpiAjYgvoH+wdKkYiBlCgupY+KdLkOiDlEgmpl+FdNkSiFjeggoi+odRkjiIhRgumq/Q]],
				["WingFinger3.L"] = [[
					ddk6jVifiOin/tdnlHjYkHiwhr/kdwlBjcnxjRhx+0d2kujerAjmiZ9ud4kdjgrxjqi79Yd0kZjhpojajA+Kdskkjfl4i6iq/Mdik0jZi9iZid/qdZk7jRi1
					iJjC/pdTkyjMleiYkk/GdSkajKo8i/mf94dUkDjIq4jZn282dUj4jKqLjHn/9GdTkDjPnQiams+VdWkdjTj6iBki/X]],
				["Humerus.R"] = [[
					gvj7fRYrvIeG7JgtkAfPY6vrdQ61gskCfOZXwJcs6mgrj/fOZ7wecf6hgrj6fOaVwkcm6jgsj2fPaVwac56sgtj1fQZ2wAdU64guj5fQZFvcd07Egvj+fRYU
					u1eZ7PgxkCfTX3uRfC7bgxkCfUXyt3fr7ogyj+fWYAtqgH7zgyj5fWYUtugM72gxj2fVYhuDf07wgwj3fTYmujfC7f]],
				["Forearm.R"] = [[
					h3kYf4aho9aV9rh4kZfzafpdZb9Vh5kXfxawp7Yy9Eh5kRfwbOqSYd88h5kKfxboqcYd89h5kHfzbtqTYx9Gh5kKf1bZp4ZS9Uh4kTf3a0pSZ99kh2kef5aR
					opat9zh0kmf8aBoHbe+Bhzkof/aInwcI+OhykkgCaennci+YhykegDayntci+ahzkYgBa3oBcG+Sh1kXf9auodbS+B]],
				["WingFinger1.R"] = [[
					iokrg6dUfcY2/Diskpg0cxf2YJ+1ivkkgwdXgVW3+iiwkbgvepgyVe+KixkSgwfvhCUs96iwkPgzf8g9U++BitkVg1fHgfWR+diqkjg4d1fzYC+6imkyg7dA
					fHZg/Kihk9g/dPesaL/TidlAhEedenaD/Xibk7hIf4ezZj/TickzhJglfBZH/OifkthHgGfIY+/MijkrhBetfOZA/L]],
				["WingFinger2.R"] = [[
					iok5iKf+e0bK/mivk6iEgVfIaR/di0kwiBiQfQYu/Ei2kgiBkXfRXK+bi2kRiClSfVWX+Ci0kOiEkcfeWz+UixkZiHiXfcYX++iskuiJgbfFaT/diklCiLgA
					ekbz/ridlMiPhdeLcY/siYlJiVj5eAcJ/diVk9iZlteAbm/GiWkyiblveHbM/CiaktiYj9eSbK/UihkyiShgegbT/k]],
				["WingFinger3.R"] = [[
					ijk6jVifdydZ/tirk5jPj5d0cT/diuknjLnRdWae+iitkOjJqNcwYu9Qisj7jJq3crX68yisj7jMo6dPYg9qiskPjRlfd3aX+7inksjUi2d8ch/mielDjWi8
					dieA/siUlGjal1c/eZ/RiMk4jdpmcjd9+QiJkkjfrxcVdT9ZiKkZjgrBccc+9qiQkdjgn0c1dJ+uiZksjckKdXdh/g]],
				Tail1 = [[
					gAi8gAuZgAgA8kgAjBgAuYhAfE8igAjCgAuWh1eS8fgAjAgAuTiWd08bgAi6gAuTiddt8bgAi1gAuUiJeA8dgAi1gAuXhdep8hgAi5gAuZghfh8kgAi+gAuZ
					ffgf8kgAjCgAuXejhX8hgAjCgAuUd3iA8dgAi9gAuTdjiT8bgAi3gAuTdqiM8bgAi1gAuWeLhu8fgAi2gAuYfAg88i]],
				Tail2 = [[
					gAiZgaofeeiP+ugBiegaoigOgq+0gCiggaofh8e++xgDidgZoYjUde+lgDiXgZoSkHca+agDiTgaoQkNb++WgCiSgaoUjlcO+cgBiWgaobiVdH+of/icgaoh
					grei+yf+ifgaoie5gM+0f9ifgaocdUh1+rf9iagZoVcNjI+ff9iVgZoQbwj6+Xf+iSgaoRcCkA+Yf/iUgaoYc/ja+i]],
				Tail3 = [[
					f+iCg/gQb8ls/NgCiIg/ged6k0/jgHiJg+gngRjG/1gKiGg+gkimg1/3gLiBg9gYkdeb/ogLh8g9gLlhcU/SgIh8g+gElpa2/EgFiAg+gKkzaQ/GgAiFg/gX
					jJap/Yf7iJg/gkg8b9/tf4iJg+gnejeA/4f1iEg+gfcagZ/yf1h+g9gRa6is/df2h7g+gGaTkh/Jf5h9g+gGarll/C]],
			},
		},
		Run = {
			loop = true,
			fps = 15,
			frames = 8,
			bones = {
				Hips = [[
					gAkggA/+gAgAgwgAkkgA//gAgAgbgAkugA//gAgAfpgAk4gA/+gAgAe2gAk8gA/9gAgAehgAk4gA/+gAgAe2gAkugA//gAgAfpgAkkgA//gAgAgb]],
				Spine = [[
					gAkefWAJgAgAi5gAkjfWAKgAgAi+gAkvfWALgAgAjLgAk7fWAMgAgAjXgAlAfWANgAgAjdgAk7fWAMgAgAjXgAkvfWALgAgAjLgAkjfWAKgAgAi+]],
				Neck1 = [[
					gAkleuA/gAgAn1gAkqeuBCgAgAn/gAk3euBIgAgAoXgAlDeuBPgAgAowgAlIeuBSgAgAo6gAlDeuBPgAgAowgAk3euBIgAgAoXgAkqeuBCgAgAn/]],
				Neck2 = [[
					gAkzeUCDgAgArOgAk5eUCJgAgArdgAlGeVCWgAgAsAgAlTeVClgAgAsjgAlYeVCrgAgAsxgAlTeVClgAgAsjgAlGeVCWgAgAsAgAk5eUCJgAgArd]],
				Neck3 = [[
					gAlCeDDfgAgAuegAlHeEDogAgAuxgAlVeFEAgAgAvegAljeGEZgAgAwJgAloeGEkgAgAwbgAljeGEZgAgAwJgAlVeFEAgAgAvegAlHeEDogAgAux]],
				Head = [[
					gAlUd2ACgAgAhDgAlad3ACgAgAhDgAlod5ACgAgAhDgAl2d7ACgAgAhDgAl8d8ACgAgAhDgAl2d7ACgAgAhDgAlod5ACgAgAhDgAlad3ACgAgAhD]],
				Jaw = [[
					gAlkdY/5gAgAihgAlqdZ/5gAgAihgAl4da/5gAgAihgAmGdd/5gAgAihgAmMdd/5gAgAihgAmGdd/5gAgAihgAl4da/5gAgAihgAlqdZ/5gAgAih]],
				Crest = [[
					gAnWdxL8gAgA46gAncdyMSgAgA5MgAnrd0MIgAgA5EgAn5d2LkgAgA4ngAn/d3K8gAgA4EgAn5d2KmgAgA3xgAnrd0KwgAgA36gAncdyLTgAgA4Y]],
				["Humerus.L"] = [[
					fRkmexINOId5rifRkrexKaNmfZuxfRk3exOJOVldzCfRlEexSZP4sP0sfRlJeyULP8vqzffRlEexRPOauUxDfRk3exLsNpovuDfRkrexIMOJhyrl]],
				["Forearm.L"] = [[
					e3lbdyJCNcgrsRelljd/MEMzjIvveIlhedQENyoAzUd8lSe9S9POsg0Yd9lFfFS/Ont8y5d6lEevPoM2rkv9eHlNeJK8MqmzsnenlUdyIYNoiPrD]],
				["WingFinger1.L"] = [[
					ePmHc2LHMYiZuAdpmNdVP1MSmxyFc5l8eRUvOGrS1KcplbfHWXPst31ucplGfLUFOPtGz2cplKeaPhLqozwJdIljdWLJLWj4sHd9l5cyJVMehPrO]],
				["WingFinger2.L"] = [[
					dbmucFNXLKh/vZcfmmc/TxMZoX0ebomBebaPPzto3RbblZffbvR2vq3qbXlHfUXxPOt219bdlYd/RkK+n3xocTl+ceMoJ0hqsYdVmdb1K3K1fRrU]],
				["WingFinger3.L"] = [[
					cmnSbdPkKOhOwobVmzc8X1Nmpz22all1e6f1TXvz4yaglHgKhFVtxN46aRk/fsbWRFuZ36aWlldqTcKZmey4bmmcbqOIIUe3r4c1nDa9McJSczqr]],
				["Humerus.R"] = [[
					gvkmexINx4iHrigvkrexKayagnuxgvk3exOJxrajzCgvlEexSZwITx0sgvlJeyULwEQWzfgvlEexRPxmRsxDgvk3exLsyXXRuDgvkrexIMx3eOrl]],
				["Forearm.R"] = [[
					hJlbdyJCykfVsRhbljd/MEzNc4vvh4lhedQEyOYAzUiElSe9S9wyTg0YiDlFfFS/xZSEy5iGlEevPozKUcv9h5lNeJK8zWZNsnhZlUdyIYyYdxrD]],
				["WingFinger1.R"] = [[
					hxmHc2LHzodnuAiXmNdVP1zuZPyFjHl8eRUvx6Uu1KjXlbfHWXwUSJ1ujXlGfLUFxxS6z2jXlKeaPh0WXNwJi4ljdWLJ0qcIsHiDl5cyJVziexrO]],
				["WingFinger2.R"] = [[
					ilmucFNX02eBvZjhmmc/TxznXp0ekYmBebaPwNSY3RkllZffbvuKQW3qkplHfUXxwySK19kjlYd/Rk1CYJxojtl+ceMo2MeWsYirmdb1K31LgvrU]],
				["WingFinger3.R"] = [[
					janSbdPk1yeywokrmzc8X1yaWN22lbl1e6f1spQN4ylglHgKhFqTOz46lvk/fsbWu7Rn36lqlldqTc1nZiy4kamcbqOI3shJr4jLnDa9Mc2ujNqr]],
				Tail1 = [[
					gAkggAcPgAgA/xgAkkgAckgPec/xgAkugAdXgYdz/zgAk4gAeJgUed/5gAk8gAedgAgA/9gAk4gAeJfshj/5gAkugAdXfoiN/zgAkkgAckfxhk/x]],
				Tail2 = [[
					gAkqgqUZgEhz9wgBktgqTNgue79SgCk1grShg/cx80gBk9grSsgpcf83gAlAgrTof5eN9cf/k9grUzfPhD98f+k1grVifGjW+Cf/ktgqVXfcjr98]],
				Tail3 = [[
					f+lHhKPIf8j565gElNhIM1hThF5jgIlVhGJ0iNd721gHldhHH1hqcJ0igClfhJHyf4cZ0lf8lZhLJseSew20f5lPhNMsd9iO5Uf6lIhMPEevkd6v]],
			},
		},
		Attack = {
			loop = false,
			fps = 15,
			frames = 16,
			bones = {
				Hips = [[
					gAiugADzgAgAvGgAiugDD/gAgAvcgAiugLEfgAgAwTgAiugTFFgAgAxRgAiugZFegAgAx4gAiwgDEbgAgAwNgAi5fLCYgAgAsEgAi5fLCYgAgAsEgAi5fLCY
					gAgAsEgAi5fOCcgAgAsNgAi2faCwgAgAs7gAiyfsDOgAgAt+gAivf7DqgAgAu0gAiugADzgAgAvGgAiugADzgAgAvGgAiugADzgAgAvG]],
				Spine = [[
					gAjRfpFPgAgAxggAjRftFjgAgAx+gAjSf2GXgAgAzHgAjUgCHWgAgA0YgAjVgJIBgAgA1KgAjVfvGOgAgAy7gAjXetC1gAgAtHgAjXetC1gAgAtHgAjXetC1
					gAgAtHgAjWewC6gAgAtTgAjVe+DbgAgAuYgAjTfSEPgAgAv4gAjRfjE+gAgAxHgAjRfpFPgAgAxggAjRfpFPgAgAxggAjRfpFPgAgAxg]],
				Neck1 = [[
					gAj2fYGDgAgAytgAj3feGigAgAzXgAj5frH2gAgA0+gAj8f6JdgAgA2rgAj9gEKkgAgA3vgAj8fiH5gAgA1BgAj1eSDIgAgAtwgAj1eSDIgAgAtwgAj1eSDI
					gAgAtwgAj1eVDPgAgAt+gAj2emD3gAgAvMgAj2e9E2gAgAw5gAj2fSFvgAgAyQgAj2fYGDgAgAytgAj2fYGDgAgAytgAj2fYGDgAgAyt]],
				Neck2 = [[
					gAkSfPGDgAgAytgAkTfWGtgAgAzkgAkXfnIdgAgA1qgAkZf6KqgAgA31gAkagHMOgAgA5IgAkZfeItgAgA17gAkMeAC0gAgAtEgAkMeAC0gAgAtEgAkMeAC0
					gAgAtEgAkMeDC7gAgAtVgAkOeVDngAgAuugAkRewEsgAgAwpgAkSfHFsgAgAyMgAkSfPGDgAgAytgAkSfPGDgAgAytgAkSfPGDgAgAyt]],
				Neck3 = [[
					gAknfIGDgAgAytgAkpfQG3gAgAzxgAktflJGgAgA2UgAkvf9L8gAgA46gAkwgMN9gAgA6agAkvfdJkgAgA2ygAkcdxChgAgAsZgAkcdxChgAgAsZgAkcdxCh
					gAgAsZgAkdd1CpgAgAsrgAkgeJDXgAgAuPgAkkemEjgAgAwagAkme/FqgAgAyJgAknfIGDgAgAytgAknfIGDgAgAytgAknfIGDgAgAyt]],
				Head = [[
					gAk8fBACgAgAhDgAk+fLAIgAgAitgAlDfkAxgAgAm4gAlFgBCJgAgArdgAlEgUDagAgAuVgAlGfdA9gAgAnsgAksdhA/gAgAYMgAksdhA/gAgAYMgAksdhA/
					gAgAYMgAktdlA5gAgAYkgAkyd7AegAgAapgAk4ecAGgAgAdqgAk7e3ABgAgAgMgAk8fBACgAgAhDgAk8fBACgAgAhDgAk8fBACgAgAhD]],
				Jaw = [[
					gAlMej/+gAgAg2gAlSeu//gAgAgPgAldfO/8gAgAeTgAllf0/ngAgAbHgAlmgN/mgAgAa+gAlhfI/TgAgAmmgAkqc/+CgAgArBgAkqc/9jgAgAsPgAkqc/9y
					gAgArqgAksdD+kgAgApagAk1dZ/KgAgAnNgAlBd7/tgAgAkOgAlKeY/8gAgAhtgAlMej/+gAgAg2gAlMej/+gAgAg2gAlMej/+gAgAg2]],
				Crest = [[
					gAm/e8LcgAgA4ggAnBfUMlgAgA5agAm+gPPqgAgA7ggAmuhPTbgAgA9agAmdh1WBgAgA+ZgAm/gOQFgAgA7vgAmZcYFzgAgAyVgAmZcYGwgAgAzogAmZcYGy
					gAgAzsgAmbcfHCgAgAz/gAmpdEIYgAgA1kgAm3d8KNgAgA3agAm9esLjgAgA4mgAm/e8LrgAgA4sgAm/e8LcgAgA4ggAm/e8LcgAgA4g]],
				["Humerus.L"] = [[
					fRj0fbdKOaje6VfRj1fgc0OBhp6NfRj3ftbsNedI5jfRj5f8aBNrYX4WfRj6gGYsORVj3XfRj5fka9MvcU4xfRj0eVdpQos/4wfRj0eVcxSRtf5VfRj0eVcu
					SVtg5XfRj0eYctSMtI5ffRj0eocpRfq/6FfRj0fAcxQZnr6pfRj0fUc9Pbku6xfRj0fbdFOujk6hfRj0fbdKOaje6VfRj0fbdKOaje6V]],
				["Forearm.L"] = [[
					eBj2f8fcNOlH5YeAj+f+evMwjI5UeDkTgGc0MMeK42eNkqgUaWMpYz3weYk3geYmNiVm2yeDkbf4bpLqc+4HeLjcfDgXQSuY33ePjifKfkR7uz4nePjifLfi
					R/u04peOjjfNfgR0uc4weLjofafWQ5sY5VeGjufsfUPhpK51eDj0f7fVOUmS55eCj2f9fZNilM5leBj2f8fcNOlH5YeBj2f8fcNOlH5Y]],
				["WingFinger1.L"] = [[
					cyjogWjWNNmV44cvj5gViSMhkK47czkmgYfeLpeh4odIlXglcGMIYR3hdflygxZ2NQUg2Yc1k2gFdwLOcz3/dOi1fvkxRnvi3gdVjBf+lqTywm3zdVjCf/lt
					T4wo30dTjDgAlrTnwU36dKjMgIlhSQuc4ac/jYgTlAQLrQ47c3jlgbkPOcoH5HczjpgZjmNhmo5AcyjogWjWNOmW44cyjogWjWNNmV44]],
				["WingFinger2.L"] = [[
					brjIgtn4ObnQ4fbjjjgpmqNXk94objktgojWLse64dcCl+g1fWLmYA3ScomrhFcpMhTy1+bmlKgRhQLFc039ckh/gcpcUcwO3Lc1iMgzr8Xwxw2Uc2iMg0sD
					X6xz2RcziNg0sDXlxi2WchiXg3r/VxwA2ycJiog5rMSytD3hb2i9g5pwQLpt4JbtjHgzocO1ny4bbrjIgtn4ObnQ4fbrjIgtn4ObnQ4f]],
				["WingFinger3.L"] = [[
					a0iZhCsHQlog3zali+g7qzPFmF4Jaakkg0nIMcff4Ra+mYhDigLlXw3EbvnYhWfWMQS/1haclPgbkoLhc537cThEhGtkYWxB2Kc5hPhfxRdby0zFc7hQhgxb
					doy2y8c2hQhfxddQyszBcbhXhdxjbFxpzfbxhohYwrXGvM03bMiEhRu2TTrx2ba5iVhIs+RPpV3ca0iZhCsIQlog3za0iZhCsHQlog3z]],
				["Humerus.R"] = [[
					gvj0fbdKxmci6Vgvj1fgc0x/eX6Ngvj3ftbsyii45jgvj5f8aByVnp4Wgvj6gGYsxvqd3Xgvj5fka9zRjs4xgvj0eVdpvYTB4wgvj0eVcxtvSh5Vgvj0eVcu
					trSg5Xgvj0eYctt0S45fgvj0eocpuhVB6Fgvj0fAcxvnYV6pgvj0fUc9wlbS6xgvj0fbdFxScc6hgvj0fbdKxmci6Vgvj0fbdKxmci6V]],
				["Forearm.R"] = [[
					h/j2f8fcyya55YiAj+f+evzQc45Uh9kTgGc0z0h242hzkqgUaWzXnN3whok3geYmyeqa2yh9kbf4bp0WjC4Hh1jcfDgXvuRo33hxjifKfkuFRN4nhxjifLfi
					uBRM4phyjjfNfguMRk4wh1jofafWvHTo5Vh6jufsfUwfW251h9j0f7fVxsZu55h+j2f9fZyea05lh/j2f8fcyya55Yh/j2f8fcyya55Y]],
				["WingFinger1.R"] = [[
					jOjogWjWyzZr44jRj5gViSzfb247jNkmgYfe0Xhf4oi4lXglcGz4nv3hihlygxZ2ywrg2YjLk2gFdw0yjN3/iyi1fvkxuZQe3girjBf+lqsOPa3zirjCf/lt
					sIPY30itjDgAlrsZPs36i2jMgIlhtwRk4ajBjYgTlAv1Uw47jJjlgbkPxkX55HjNjpgZjmyfZY5AjOjogWjWyyZq44jOjogWjWyzZr44]],
				["WingFinger2.R"] = [[
					kVjIgtn4xlYw4fkdjjgpmqypbD4okdktgojW0UhG4dj+l+g1fW0aoA3SjYmrhFcpzfsO1+kalKgRhQ07jM39jch/gcpcrkPy3LjLiMgzr8oQOQ2UjKiMg0sD
					oGON2RjNiNg0sDobOe2WjfiXg3r/qPQA2yj3iog5rMtOS93hkKi9g5pwv1WT4JkTjHgzocxLYO4bkVjIgtn4xlYw4fkVjIgtn4xlYw4f]],
				["WingFinger3.R"] = [[
					lMiZhCsHvbXg3zlbi+g7qzw7Z74Jlmkkg0nIzkgh4RlCmYhDig0boQ3EkRnYhWfWzwtB1hlklPgbko0fjH37jthEhGtknqO/2KjHhPhfxRilNMzFjFhQhgxb
					iYNKy8jKhQhfxdiwNUzBjlhXhdxjk7OXzfkPhohYwro6Q003k0iEhRu2stUP2blHiVhIs+uxWr3clMiZhCsIvbXg3zlMiZhCsHvbXg3z]],
				Tail1 = [[
					gAiugAzlgAgA5TgAiugDzug/fQ5KgAiugL0GhWfB41gAiugT0jgzfb4ggAiugZ01fugN4RgAiwgDzLe3g65kgAi5fLuYe9hN8igAi5fLuZfjgh8kgAi5fLuZ
					gdff8kgAi5fOunhEe08agAi2fav5hBe+7ugAiyfsxsgRfx6pgAivf7zGfPgn5pgAiugAzjeshB5RgAiugAzkfBgx5SgAiugAzlgAgA5T]],
				Tail2 = [[
					gAiEgLyifNgl6DgBiEgNyhhUfG6CgBiDgUydileQ58gBiDgbyfiJel5/gAiDgfyjgQfy6Ef/iHgPwpeRhO7Pf/iWflqld0iT+BgAiWflqnemhl+GgAiWflqp
					gTf1+KgBiVfnq+h0eM98gBiRfws6iQd39HgAiKf9vrhNe+72f/iFgHx1fNgl6if/iEgLyedohs59f/iEgLyedohs59gAiEgLyifNgl6D]],
				Tail3 = [[
					f/hbgZwxd0hX7IgChbgbwpgzfj7TgEhaghwHjSeH7YgDhagpvljmd77ogAhaguvZhee/7/f9hggjtSeZgz9Df7h7gHl3c6iu/Lf9h7gHl4dXir/OgBh7gHl9
					fkg3/agEh5gImbiEef/PgEhwgNpCjWdR+YgChlgTs0ileC9If+hdgYv3f/f+7yf8hbgZwvdPht7Ef9hbgZwqcTiS69f/hbgZwxd0hX7I]],
			},
		},
		Roar = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiugADzgAgAvGgAiqgADhgAgAujgAikgAC6gAgAtRgAiegACcgAgAsOgAifgAChgAgAsagAitgAD9gAgAvYgAi2gAFUgAgAxngAi3gAFigAgAx9gAi3gAFi
					gAgAx9gAi3gAFigAgAx9gAi3gAFigAgAx9gAi3gAFigAgAx9gAi3gAFigAgAx9gAi3gAFigAgAx9gAi3gAFigAgAx9gAi3gAFigAgAx9gAi3gAFigAgAx9gA
					i3gAFggAgAx6gAizgAE3gAgAw7gAivgAEDgAgAvkgAiugADzgAgAvGgAiugADzgAgAvGgAiugADzgAgAvG]],
				Spine = [[
					gAjRfpFPgAgAxggAjNfnEygAgAwzgAjDfkD2gAgAvMgAi8fiDKgAgAt1gAi9fjDSgAgAuEgAjQfpFlgAgAyBgAjcfvH5gAgA1BgAjefwITgAgA1fgAjefwIT
					gAgA1fgAjefwITgAgA1fgAjefwITgAgA1fgAjefwITgAgA1fgAjefwITgAgA1fgAjefwITgAgA1fgAjefwITgAgA1fgAjefwITgAgA1fgAjefwITgAgA1fgA
					jefwIPgAgA1agAjZftHGgAgA0EgAjTfqFrgAgAyKgAjRfpFPgAgAxggAjRfpFPgAgAxggAjRfpFPgAgAxg]],
				Neck1 = [[
					gAj2fYGDgAgAytgAjxfVFagAgAxxgAjlfOEEgAgAvkgAjcfJDGgAgAttgAjdfKDRgAgAuCgAj2faGlgAgAzbgAkFfqKJgAgA3XgAkGfsKygAgA38gAkGfsKy
					gAgA38gAkGfsKygAgA38gAkGfsKygAgA38gAkGfsKygAgA38gAkGfsKygAgA38gAkGfsKygAgA38gAkGfsKygAgA38gAkGfsKygAgA38gAkGfsKygAgA38gA
					kGfsKrgAgA32gAkBflI6gAgA2IgAj5fbGugAgAzmgAj2fYGDgAgAytgAj2fYGDgAgAytgAj2fYGDgAgAyt]],
				Neck2 = [[
					gAkSfPGDgAgAytgAkMfKFPgAgAxggAj/e+DlgAgAurgAjye2CdgAgAsQgAj1e3CpgAgAssgAkTfTGxgAgAzpgAkifsLggAgA4jgAkkfwMXgAgA5QgAkkfwMX
					gAgA5QgAkkfwMXgAgA5QgAkkfwMXgAgA5QgAkkfwMXgAgA5QgAkkfwMXgAgA5QgAkkfwMXgAgA5QgAkkfwMXgAgA5QgAkkfwMXgAgA5QgAkkfwMXgAgA5QgA
					kkfvMOgAgA5IgAkefkJ0gAgA3DgAkVfUG7gAgAz2gAkSfPGDgAgAytgAkSfPGDgAgAytgAkSfPGDgAgAyt]],
				Neck3 = [[
					gAknfIGDgAgAytgAkhfBFEgAgAxPgAkReyDIgAgAtwgAkCemB5gAgAqxgAkFeoCFgAgArUgAkofNG8gAgAz4gAk4fwM6gAgA5qgAk5f1OBgAgA6dgAk5f1OB
					gAgA6dgAk5f1OBgAgA6dgAk5f1OBgAgA6dgAk5f1OBgAgA6dgAk5f1OBgAgA6dgAk5f1OBgAgA6dgAk5f1OBgAgA6dgAk5f1OBgAgA6dgAk5f1OBgAgA6dgA
					k5f1N1gAgA6VgAk1fkKxgAgA37gAkrfPHIgAgA0GgAknfIGDgAgAytgAknfIGDgAgAytgAknfIGDgAgAyt]],
				Head = [[
					gAk8fBACgAgAhDgAk1e4ADgAgAejgAkiekAzgAgAY/gAkQeVCHgAgAUngAkTeYB1gAgAVYgAk+fIAMgBftjRgAlNf2DngUfRuugAlOf+DxfVhhu8gAlOf+Eb
					gOflwNgAlOf+Eugme4wpgAlOf+D0fYhZvCgAlOf+ERgAgAv8gAlOf+E0gueqwygAlOf+D4fehKvMgAlOf+EHfzgbvqgAlOf+E4gyeiw3gAlOf+D/fng0vZgA
					lOf8D1fog0vIgAlLfnCHgUfArWgAlBfKANgAgFjdgAk8fBACgAgAhDgAk8fBACgAgAhDgAk8fBACgAgAhD]],
				Jaw = [[
					gAlMej/+gAgAg2gAlAeX/ygAgAjqgAkheB+cgAgAp1gAkGd08egAgAukgAkLd284gAgAtwgBlSes/xf7gTjugClvfw/9faghe2f9lwf4/8hUfAgSgBlwf7/9
					fngRe3gClwf8/7e9gteVf9lwf4/9hOfFgMgAlwf6/+gAgAfLgDlwf8/5evg2eKf+lwf4/9hBfPgBf/lwf5//gYfuffgDlwf9/5eog7eFf+lwf5/+gvfdfyf+
					lwf3/+gtfdfzgClqfZ/9fYg2fGgAlVev//gBf7gpgAlMej/+gAgAg2gAlMej/+gAgAg2gAlMej/+gAgAg2]],
				Crest = [[
					gAm/e8LcgAgA4ggAm1efJlgAgA20gAmSdgF8gAgAyjgAloc1DkgAgAupgAlwc8D9gAgAvXgAnAfWNxfyfz6SgAmjhZZ0fofT/YgAmihiZGguhg/MgAmZhpbi
					fzfl/rgAmVhrcdfee2/xgAmhhiZQgqhY/OgAmbhna/gAgA/mgAmUhscwfYen/ygAmghjZigjhJ/TgAmdhmacgNgb/ggAmThsc6fUef/zgAmfhkZ8gZg0/ZgA
					mhhiZogZgz/VgAm1g0V+fbfI+XgAnDfZNhgDgD6HgAm/e8LcgAgA4ggAm/e8LcgAgA4ggAm/e8LcgAgA4g]],
				["Humerus.L"] = [[
					fRj0fbYHM2gA4YfRjvfYYONig646fRjkfRYLPYiz6CfRjafMX2RLkJ61fRjcfMX7Q1j76sfRj0fdYBNXd34pfRkCfsWzNdX12+fRkEfuWiNyW02vfRkEfuWi
					NyW02vfRkEfuWiNyW02vfRkEfuWiNyW02vfRkEfuWiNyW02vfRkEfuWiNyW02vfRkEfuWiNyW02vfRkEfuWiNyW02vfRkEfuWiNyW02vfRkEfuWiNyW02vfR
					kDfuWlNuW/2yfRj+fnXSM/Z/3cfRj2feX9Mved4LfRj0fbYHM2gA4YfRj0fbYHM2gA4YfRj0fbYHM2gA4Y]],
				["Forearm.L"] = [[
					eCkUfpYSMHgA31eCkNfqYvMrhR4ZeEj+fuZnOVj75leIj1fyaIQBly6deHj2fxaDPtle6UeGkcfuYNMmd84HeWlAf6WCNdWz2QealFf9VqN6Vr19ealFf9Vq
					N6Vr19ealFf9VqN6Vr19ealFf9VqN6Vr19ealFf9VqN6Vr19ealFf9VqN6Vr19ealFf9VqN6Vr19ealFf9VqN6Vr19ealFf9VqN6Vr19ealFf9VqN6Vr19eZ
					lEf9VuN1V22AeOk0fzWvMtZP2yeEkdfqX8MFeQ3oeCkUfpYSMHgA31eCkUfpYSMHgA31eCkUfpYSMHgA31]],
				["WingFinger1.L"] = [[
					c0kzfyahLngA4Cczkmf4baMLhr4nc1kOgIdXN8lE5yc9j/gWe3P2nX6lc7kBgUemPfm/6cc8lCf6aVMAd04NdhmAgFW1NcVE1ydqmJgKWTOETt1XdqmJgKWT
					OETt1XdqmJgKWTOETt1XdqmJgKWTOETt1XdqmJgKWTOETt1XdqmJgKWTOETt1XdqmJgKWTOETt1XdqmJgKWTOETt1XdqmJgKWTOETt1XdqmJgKWTOETt1Xdo
					mIgJWYN9T71bdQltf8X5MbX92lc5lCfzZ4Lkd83wc0kzfyahLngA4Cc0kzfyahLngA4Cc0kzfyahLngA4C]],
				["WingFinger2.L"] = [[
					bmlIf8eDLggA4ebkkzgIfNMRh45FbpkKglhzOklp6Kb3jxg+j2Q8oF6xb0j1g6jfQfns6rbwlegHdvLudo4hcwnBgSZIM2Tt1ZdAnNgZXlOTRA0VdAnNgZYR
					NpR+0udAnNgZYiNZSW02dAnNgZXoOQRD0XdAnNgZYHNyRw0odAnNgZYoNVSd05dAnNgZXtOLRL0adAnNgZX+N7Ri0jdAnNgZYrNSSi06dAnNgZX0ODRV0ec9
					nLgYX8N7Rm0lcUmjgGatLwXO2ibulgf8dGLTdm4GbmlIf8eDLggA4ebmlIf8eDLggA4ebmlIf8eDLggA4e]],
				["WingFinger3.L"] = [[
					aclPgJhdL/gA46abkwgZi5NCiL5gaoj1hDmIQHma6TbAjQhmosTKpE6ea7jWhgoPSlop6eaolugVhCL/db4zcBn5ggbOMqSF0zceoNgsYaO9N5yocYoKgqZ/
					NnP8zwcWoJgpamNJQv0IcdoNgsYgO4OBytcZoLgqZoN5PezhcVoJgpayNARA0QccoNgrYsOtOQy2caoMgrZSOMPAzScVoJgpa5M7RJ0TccoMgrY9OeOmzDcY
					oKgpZIOTO5zObYnPgRdaLhWV2callxgHgMLidL4aaclPgJhdL/gA46aclPgJhdL/gA46aclPgJhdL/gA46]],
				["Humerus.R"] = [[
					gvj0fbYHzKgA4YgvjvfYYOyefG46gvjkfRYLwodN6CgvjafMX2u1b361gvjcfMX7vLcF6sgvj0fdYBypiJ4pgvkCfsWzyjoL2+gvkEfuWiyOpM2vgvkEfuWi
					yOpM2vgvkEfuWiyOpM2vgvkEfuWiyOpM2vgvkEfuWiyOpM2vgvkEfuWiyOpM2vgvkEfuWiyOpM2vgvkEfuWiyOpM2vgvkEfuWiyOpM2vgvkEfuWiyOpM2vgv
					kDfuWlySpB2ygvj+fnXSzBmB3cgvj2feX9zRhj4Lgvj0fbYHzKgA4Ygvj0fbYHzKgA4Ygvj0fbYHzKgA4Y]],
				["Forearm.R"] = [[
					h+kUfpYSz5gA31h+kNfqYvzVev4Zh8j+fuZnxrcF5lh4j1fyaIv/aO6dh5j2fxaDwTai6Uh6kcfuYNzaiE4HhqlAf6WCyjpN2QhmlFf9VqyGqV19hmlFf9Vq
					yGqV19hmlFf9VqyGqV19hmlFf9VqyGqV19hmlFf9VqyGqV19hmlFf9VqyGqV19hmlFf9VqyGqV19hmlFf9VqyGqV19hmlFf9VqyGqV19hmlFf9VqyGqV19hn
					lEf9VuyLqK2Ahyk0fzWvzTmx2yh8kdfqX8z7hw3oh+kUfpYSz5gA31h+kUfpYSz5gA31h+kUfpYSz5gA31]],
				["WingFinger1.R"] = [[
					jMkzfyah0ZgA4CjNkmf4baz1eV4njLkOgIdXyEa85yjDj/gWe3wKYp6ljFkBgUemwhZB6cjElCf6aV0AiM4NifmAgFW1ykq81yiWmJgKWTx8sT1XiWmJgKWT
					x8sT1XiWmJgKWTx8sT1XiWmJgKWTx8sT1XiWmJgKWTx8sT1XiWmJgKWTx8sT1XiWmJgKWTx8sT1XiWmJgKWTx8sT1XiWmJgKWTx8sT1XiWmJgKWTx8sT1XiY
					mIgJWYyDsF1biwltf8X5zloD2ljHlCfzZ40ciE3wjMkzfyah0ZgA4CjMkzfyah0ZgA4CjMkzfyah0ZgA4C]],
				["WingFinger2.R"] = [[
					kalIf8eD0ggA4ekckzgIfNzveI5FkXkKglhzxcaX6KkJjxg+j2vEX76xkMj1g6jfvhYU6rkQlegHdv0SiY4hjQnBgSZIzKsT1ZjAnNgZXlxtvA0VjAnNgZYR
					yXuC0ujAnNgZYiyntq02jAnNgZXoxwu90XjAnNgZYHyOuQ0ojAnNgZYoyrtj05jAnNgZXtx1u10ajAnNgZX+yFue0jjAnNgZYryute06jAnNgZX0x9ur0ejD
					nLgYX8yFua0ljsmjgGat0Qoy2ikSlgf8dG0tia4GkalIf8eD0ggA4ekalIf8eD0ggA4ekalIf8eD0ggA4e]],
				["WingFinger3.R"] = [[
					lklPgJhd0BgA46llkwgZi5y+d15glYj1hDmIv5Zm6TlAjQhmoss2W86elFjWhgoPtbXX6elYlugVhC0Bil4zj/n5ggbOzWt70zjioNgsYaxDyHyojooKgqZ/
					yZwEzwjqoJgpamy3vR0IjjoNgsYgxIx/ytjnoLgqZoyHwizhjroJgpayzAvA0QjkoNgrYsxTxwy2jmoMgrZSx0xAzSjroJgpa5zFu30TjkoMgrY9xixazDjo
					oKgpZIxtxHzOkonPgRda0fpr2clblxgHgM0ei14alklPgJhd0BgA46lklPgJhd0BgA46lklPgJhd0BgA46]],
				Tail1 = [[
					gAiugAy6gAgA5zgAiqgAyogmfi5/gAikgAyBgwfW6agAiegAxkgZfo6ugAifgAx1fzgN6kgAitgA0Pe4g44vgAi2gA1IeFhK36gAi3gA0hfVgX4igAi3gA0t
					hSfU4WgAi3gA10iReo3QgAi3gA3Ghre32CgAi3gA3rgAgA1hgAi3gA3GeVhJ2CgAi3gA10dvhY3QgAi3gA0teugs4WgAi3gA0hgrfp4igAi3gA1YiHey3rgA
					i3gA2qiAer2dgAizgA2agefq20gAivgA0rfegb4ZgAiugAzqfOgn5NgAiugAzJfZgd5ogAiugAy6gAgA5z]],
				Tail2 = [[
					gAiEgNxVfFgr63gBiCgOw3gxfe7KgBh7gQwgh3ei7TgAh2gRwnhpel7QgAh3gQxYgYft63f/iCgJ0JeFhd4vf+iLgF0UazjO38f/iMgIyacCiT5wgBiMgHx9
					gof26egCiMgDzTk3dm48gBiMf+1vlrc92kgAiMf83zisej1Kf/iMf+3ud+hb1Vf+iMgD1darjU24f/iMgHy9bCi55HgBiMgIx5e9gu6fgCiMgEyrjueP5pgB
					iLgA02lyc93YgAiIgB1/jBeL2+gAiEgH0ffygN4kf/iEgLzIeXhO5jf/iEgMyEeChb6SgAiEgNxVfFgr63]],
				Tail3 = [[
					f/hdgfvbdGh77zgChbghuffpgW8hgDhVgkt9iYec8pgChQgluXjadj8RgAhQgivyiMee7sf+hYgRzgfLgw5Vf5hggLzuYfkg3nf6hkgVwRW8lS5egDhkgXu8
					cVie78gIhigMv1ksef7XgGhhf+yVp8cK39gChhf31rojcu1rf+hhf53hhdf+1of6hhgF1XZlj62mf5hjgSxTWfli4jgAhkgYvGZ8js7TgHhjgRvVh8fw8AgH
					hhgDxVovcp5NgDhdgCzpnaco35gAhagPzUh3fE5af+hagXyIeehD6Sf9hcgcwwcniP68f/hdgfvbdGh77z]],
			},
		},
		Celebrate = {
			loop = false,
			fps = 15,
			frames = 21,
			bones = {
				Hips = [[
					gAiugADzgAgAvGgAirgADtgcgzu5gAibgADHhGh0tkgAjGgAEBg/h4vXgAjtgAEeglhMwOgAj/gAEogAgAwigAj3gAEkfce0wZgAjZgAESfDeHv0gAiggADU
					e7eLt/gAicgADHfVe4tpgAiggADQgAgAuBgAjZgAEPgmhLv1gAj3gAEng6h7wYgAj/gAEsg6h7wggAjtgAEeglhMwOgAjGgAD9gAgAvZgAibgADFfVe4tlgA
					irgADxe/eJu3gAiugAD2fMefvEgAiugADzf1frvGgAiugADzgAgAvG]],
				Spine = [[
					gAjRfpFPgAgAxgf/jOfoFIgggwxUf9i7flEahQhuwDf9jqfqFehJhyxwf+kSfsGAgrhIylgAkkfsGLgAgAy4gCkcfsGHfVe4yvgDj9frFxe5eMyMgDjBfmEp
					exeRwcgCi8flEafPe8wIgAjBfmElgAgAwef+j9frFvgshHyNf9kcfsGJhFh1ytf9kkftGPhEh1y1f+kSfsGAgrhIylgAjqfpFbgAgAxygCi7flEYfOe8wEgD
					jOfoFLe1ePxSgDjRfpFRfEekxfgBjRfpFPfzfsxggAjRfpFPgAgAxg]],
				Neck1 = [[
					gAj2fYGDgAgAytf+jzfXF4gigvycf7jffREyhThswqf7kPfaGchPhuzGf9k5ffHUgwhF0TgAlLfgHqgAgA0vgDlDffHhfQe70igFkjfdG7eyeRzvgFjlfTFI
					eueUxNgDjgfREyfNe9wwgAjlfTFEgAgAxQf9kjfcG4gwhFzwf7lDfgHjhNhw0hf7lLfgHthNhw0sf9k5ffHUgwhF0TgAkPfaGYgAgAzJgDjffREvfNe9wrgF
					jzfYF7eweSyagEj2fZGGfAenyrgBj2fYGDfyftytgAj2fYGDgAgAyt]],
				Neck2 = [[
					gAkSfPGDgAgAytf9kPfOF1gigvyXf5j5fEEZhQhuwBf6ksfSGkhQhuzRf8lWfZHygxhE03gAlofbIRgAgA1cgElgfaIEfPe81LgGlAfWHOeweS0HgHkAfHE2
					eweSwwgEj6fEEbfPe8wJgAkAfHEygAgAwzf8lAfVHMgxhE0If6lgfbIGhQhu1Jf6lofcIUhQhu1Zf8lWfZHygxhE03gAksfRGggAgAzUgEj5fEEXfPe8wCgH
					kPfOF4exeSyVgFkSfPGGfAenyrgBkSfPGDfyftytgAkSfPGDgAgAyt]],
				Neck3 = [[
					gAknfIGDgAgAytf9kkfGFxgigvySf4kMe5EChNhwvXf5lBfMGshQhtzcf8lsfWIRgzhD1ZgAl+fZI5gAgA2HgEl2fYIofNe91zgHlVfRHheveT0egIkUe9Ek
					eyeRwTgFkNe5EEfQe7vigAkUe9EggAgAwVf8lVfRHfgyhD0gf5l2fYIqhThs1xf5l+faI8hThr2Ef8lsfWIRgzhD1ZgAlBfLGogAgAzfgFkMe5D/fQe7vZgH
					kkfGF0exeSyQgGknfIGGfAenyrgBknfIGDfyftytgAknfIGDgAgAyt]],
				Head = [[
					gAk8fBACgAgAhDf8k4e+AFecg/glf3kfetAccYirdaf4lWfGAYcZiHiPf7mCfTAddzhIkmgAmUfYAfgAgAldgFmMfWAiiNe6lIgIlrfNAfjmeDjkgJknezAX
					jodceegGkgeuAQiQeWdagAkneyAEgAgAeNf7lrfNATdyhOjbf5mMfWAtcdhxlQf5mUfZAxcehulqf7mCfTAddzhIkmgAlWfGAFgAgAiBgGkfetAQiQeWdQgI
					k4e/AUjodugygHk8fBAOi9eMhNgBk8fBADgpfnhDgAk8fBACgAgAhD]],
				Jaw = [[
					gAlMej/+gAgAg2f5lIeg/JhwfbnCfvkneN9IkSensbfwloeq+ukGfIn3f3mYe5/ZidfolmgAmse//ogAgAkxgJmje9/fdkgWlEgPl/ey/Cb+gumkgRkxeT9i
					bwhSrcgLkpeN9UdWg3sfgAkyeR9vgAgAryf2l/ey/Kigfjmwfxmje+/Xj7fdk5fxmsfB/bj5fgkff3mYe5/ZidfolmgAloeo+7gAgAoLgLkneM9QdWg4sogQ
					lHeh+Ub1hCpRgNlMek+8crg9nYgDlMej/0fUgTjNgAlMej/+gAgAg2]],
				Crest = [[
					gAm/e8LbgAgA4ffvm6e2KCfnhz3LfWmaeOIIfZke0zfanVfNNmfVkI50fqoBfsQKfiic7rgAoTf3PBgAgA7HgWoKfzNDg0ds5qglnpffMkhGcE5EgpmkecKr
					gWbl3bgamdeNKXgGdO3ZgAmneWJWgAgA2lfpnsfdLtfQib4mfdoIf1N7eyjx6FfdoPf7QefEj07sfqoBfsQKfiic7rgAnZfJMMgAgA5HgambeLHXgddP0Ngn
					m3e6Kdg5bz3Pggm8e/Mgggcl5HgHm+e8L6gIfR44gAm/e8LcgAgA4g]],
				["Humerus.L"] = [[
					fRj0fbbaQmhq7nfPjxfcT2PzW13AfNjdfaP6PsV9z7fNkNfjVtNsZV3LfOk2fkYEMpZ83afRlIfiU2N6Ve1efVlBfeSAP2RayyfXkhfZTDN+Svy0fXjifQVp
					KcZA0DfVjdfQWgKTbH08fRjjfVS+NCXJ0YfOkgfiQkRDTDz1fNlAfoR+QxUZ1bfNlIfpWsN/Yl3lfOk2fkYEMpZ83afRkNfcT+NfWP0/fVjcfQQNOeTFxTfX
					jxfUSbNiTWyYfWj0fWXfLhZw2LfSj0faagOofS6SfRj0fbbaQmhq7n]],
				["Forearm.L"] = [[
					eIkFgGcTbBli+5ejk5fuVEXAUB6EexkwfYQWV3Qm07eQlKfvUzUSU65PeKlpfxW6TQV56AejmRfsVCUlRB3afEmVfnThWVMs0Be6lzfcUPUYN/0neakffFVN
					QfUM28ePkRfIVdQTWa38ejktfSS/TSSH2Ve+l1frRpXiOG0mexmRf2SgXcPr2YeQmEf6V3UwUc5seKlpfxW6TQV56AejlWfgUFT+Rg28fEkxfIRmUdNwyre6
					lDfSTjTxOZ0NeRkpfZXTSMWt55eFkOf4a0Xjg6+ZeIkFgGcTbBli+5]],
				["WingFinger1.L"] = [[
					drkThUfEpcnS9reSl6ghc2cJV598e2l/fzWrX7RI5fd0mOgYY2ZyTQ7xdimmgdaEZrTw8QeSnYgXasYMRE6qfMnegSarWjOw4qe2m9gDayVyPh45d0lmffZS
					ViS26XdilTfhYjWTT96/eSl6fwYUW4R16FfMm/gRY1YOPm5Ve2naggZQZcQZ6Sd0nEgoaAaUTB8CdimmgdaEZrTw8QeSmggFZlXlRa6bfMmAfkYQU4Py4Ae2
					mQf0Z9VPP44tdklkgCbuY+WN9Udakng8eMjth5/qdrkThUfEpcnS9r]],
				["WingFinger2.L"] = [[
					eXkiiXg5qIkU+BeFmPhvhmaTU19Yerm4gsa6VMQ+5ldnm6hbaTZYRH67dRnNhiamaBRK7Kd+oBhbdpWxP658e1oNhRfkTBPf4HebnthAfATGPt4TdWmZgYbD
					VJQ75kdGmGgbZZWfRZ5/d+mugrbUVXQz5oe/nwhRdzUtP/5MeroGhkdeWvP+59dnnrhvbbaAQ27JdRnNhiamaBRK7Kd+nPhFckWHQT51e1m7gZdKRdQ339eb
					nDgteMSjQK4QdKmDhIdhYwUJ8tdskxiLfvkCfR/ueXkiiXg5qIkU+B]],
				["WingFinger3.L"] = [[
					fEkljTilrFhd93dpmSi0m3ZNUe8OeOnjhifyTPRZ5cdZnfibbcZXO65zdFnvikaiaqOd5odgogiYgvV3O+5GeIotiDlOQcRW3OdvoPhyjwRLQo3gc4nDhOci
					VLO54hcwm0hSZsXAOp4gdgnYhieeUXP95DeaoTiJjoSJRc4neOomihiUUwQN5VdZoKixchaEOp5+dFnvikaiaqOd5odgnziAfsVKPa5GeInlhDi4PES+3odv
					nphdi9QqRI3ocwmaiLfBY6SC73d/kyjUhAkmcu/efEkljTilrFhd93]],
				["Humerus.R"] = [[
					gvj0fbbavaeW7ngsjxfXUZxfp12DgpjcfORmzBrzxvgpkNfWWo1MoC0igrk2fdYd1Km21tgvlIfiU2yGqi1egylAflQ+ustR0JgzkgflRiverU1IgzjjfcUm
					ynlx2qgyjefYV9z2kS2mgvjjfVS+y+o30YgrkhfbRnwduRyfgplBfcTcxwtozFgplJfcXg02o606grk2fdYd1Km21tgvkNfcT+yhpx0/gyjdfXPDv7rvyjgz
					jxfgQ1v2qy0ogyj0fgW3x/lT4Qgwj0fcafwwgl6rgvj0fbbavaeW7n]],
				["Forearm.R"] = [[
					h4kFgGcTk/ae+5hbk5fjVxqesk5hhGkufESptBxDznhmlLfSWVu7sj3chxlrfeXruxq/4zhdmRfsVCrbu/3ahCmUfxSEoHyF05hPlyfwSDo5wK2GhwkifiTl
					sQqh4rh2kTfbUltno65EhdktfSS/sut52Vg8l2fhTHqEzHzwhGmTfiUqrRyQ02hmmHfdXUuZtK30hxlrfeXruxq/4zhdlWfgUFsCug28hCkyfSQDp3xLzZhP
					lDflRUpbv21nh0kpfyWWq8oU7Oh7kOf+a2nwe++lh4kFgGcTk/ae+5]],
				["WingFinger1.R"] = [[
					iVkThUfEWkYu9rhxl6gUdbljqQ9rhKl9ffY1rfvn4aiMmPfyalp1tq6qiemogDbCoks57jhunYgXasn0u86qg0ndgbZWndwk5ehKm8gXYum4ve6JiMlpgEXg
					m1sb7YielWf7Xhnaro7lhul6fwYUpIuL6Fg0nAgJaLpzxD4ihKncgMbTp4ws5AiMnIgDbspQuD63iemogDbCoks57jhumggFZlobum6bg0mBftW2pEvv4shK
					mQgHX2nZvO55iYlkgjasj1pS96ijknhEePbkeF/kiVkThUfEWkYu9r]],
				["WingFinger2.R"] = [[
					hpkiiXg5V4bs+BiImPhgiPnXrC9Bhlm2gTdFuKvO4Jiqm7gwcTqHvm5xi6nPhFbyoKvb6fiCoBhbdppPwG58hBoLhceUq+wP5OhVnshZc9pmv256iZmchDZA
					nVuj6nivmJg4YJnUuP6jiCmugrbUqpvN5ohLnxhGfEtUwQ4HhloJhLfgslwj4UiqnvhEdYpdwA56i6nPhFbyoKvb6fiCnPhFckp5vt51hBm8gkb0sivE47hV
					nEhGcFqHvh5yijmDhucQkHri9UiNkxiSftbPgv/ohpkiiXg5V4bs+B]],
				["WingFinger3.R"] = [[
					g8kljTilU7ej93iqmSiinhoYrH7ziRnghAh4wAuK3vjInghqdup/xo4qjQnyiEb9nZyH4/igogiYgvqJxC5GhmosiVkItku24ihyoOiVhzrkvl5YinnHh/aM
					neww5ji7m3hyYOm7xA5BignYhieerpwD5Dh4oUh3kwv2uV3ViRoph/kPuhvr3bjIoPiBewpQyB4ujQnyiEb9nZyH4/ignziAfsq2wm5GhmnnhVhru+tb40hy
					nph/g8sFvL5aiumai0dhkEty8eh3kyjZg8arjU/Wg8kljTilU7ej93]],
				Tail1 = [[
					gAiugAyAgAgA6cgAirgAy1igeH5qgAibgAzZiidm5NgAjGgA1Dglfh4EgAjtgA0IfQgh42gAj/gAzWgAgA5egAj3gA0Sgxff4ugAjZgA1cfbge3ugAiggAzw
					dciY47gAicgAxrdSiQ6bgAiggAw/gAgA7HgAjZgAzqi5d+4/gAj3gA1zixd33JgAj/gA2Cgmfj3LgAjtgA0IfQgh42gAjGgAyRgAgA6QgAibgAxugtfb6ngA
					irgA0ofcgf4bgAiugA0tdpiB4MgAiugAzCd7hj5lgAiugAyAgAgA6c]],
				Tail2 = [[
					gAiFgQvpd2hl7xgCiCgNwOkOdU7HgBhxgLyUlqbc5NgAibgG1ig9fO3of/jDgJzlcYik46gAjVgMxEdxhe67gBjNgIx0ibem6bgAiugE0qirec4Of/h2gK0S
					d3iI4jf9h0gQw+ankg6MgAh5gTukd6hr8WgDivgKxFkqdR6ggBjMgC0umFcB3QgAjUgC2fg/fR2tf/jDgJzlcYik46gAiegPv7d1hk7ngBhzgRvGiReX8EgA
					iAgHz1ineW46f/iDgH1OeFhy3zf+iEgMyYbJjr5dgAiFgQvpd2hl7x]],
				Tail3 = [[
					f9hggmtRZfku7+gIhcggs1jZem9EgGhIgXvJp7Z35pgBhwgK0pkudW31f8iZgTzLarjm4yf9iugeutZQkY7QgEilgYudhZfl8ggCiDgLxwm8cz5ff+hLgSzo
					hdf+5Of4hMghwgZClp55f9hWgssMZrk98dgJiHgbtyjzej8lgGihgGxnqfa44BgBiogD1nk0dj29f8iZgTzLarjm4yf9h4gktkZckp71gEhPgorjhWfd9ygC
					hWgRw4m1ck6Ef+hYgL0khxfx4bf5hbgZx7Zfkw5Pf9hggmtRZfku7+]],
			},
		},
		Death = {
			loop = false,
			fps = 15,
			frames = 23,
			bones = {
				Hips = [[
					gAiugADzgAgAvGgAiugSFAgAgAxJgAiugdF2gAgAyagAiugaFngCgFyFgAiugUFLf1fnxagAiugOExfKeLwqgAiugKEefQeewMgAiugIEXf3ftwFgAitgFEJ
					gGgNvugAirf+DIgFgJtvgAijf0BhgUgYpsgAiafpAWgtgokcgAiRffADhJgvfbgAiMfYAShdgvcQgAiLfXAWhfgvbzgAiNfaALhXgvdMgAiOfbAKhVgvddgA
					iLfYAThegvcEgAiLfXAXhggvbpgAiLfXAXhggvbpgAiLfXAXhggvbpgAiLfXAXhggvbpgAiLfXAXhggvbp]],
				Spine = [[
					gAjRfpFPgAgAxggAjUgAGmgAgAzcgAjVgPHjgAgA0ogAjVgLHTgCgE0UgBjUgDG0fzfoztgDjTf7GWe/eQy/gCjSf1F/fIejyigAjSf0F4f1fuycgAjSfwFo
					gIgMyGgAjLfjEcgGgIwOf/i8fSCfgWgXsVf/imfBA2gwgknNf+iQe1AIhNgoiPf+iCewAFhggnfDf+iAevAGhjgmemf+iGexADhbgof/f+iHexADhZgogRf+
					iBevAFhigne3f+h/evAGhkgmecf+h/evAGhkgmecf+h/evAGhkgmecf+h/evAGhkgmecf+h/evAGhkgmec]],
				Neck1 = [[
					gAj2fYGDgAgAytgAj7f1IBgAgA1LgAj9gIJagAgA2pgAj9gDJCgDgE2RgBj7f5IUfxfp1ggFj6fvHne4eU0mgEj5foHIfDem0CgBj4fmG+f0fvz6f/j4fhGo
					gIgMzegAjvfQFfgDgEx5f/jZe1DygMgIvEf+i3ecCJgbgIref9iVeNBCgqgAn+f8iAeHAig0f2lrf8h8eGAfg1f1lWf8iGeIAqgxf5mXf8iIeJAtgwf6mjf8
					h+eHAhg0f2lif8h7eGAdg1f0lPf8h7eGAdg1f0lPf8h7eGAdg1f0lPf8h7eGAdg1f0lPf8h7eGAdg1f0lP]],
				Neck2 = [[
					gAkSfPGDgAgAytgAkYfxIjgAgA1wgAkbgIKWgAgA3jgAkagCJ3gDgE3FgBkZf2I8fxfp2KgGkXfqIBe2eW1EgFkWfiHZfCen0XgBkVffHNf0fv0Nf/kUfZGy
					gIgMzqgAkKfFFygAgAyVf/jxelEkgBf6wbf+jLeGDXgEftuPf9ikdzCagFfasHf9iKdrB4gEfKqtf8iGdqBzgEfIqgf9iRdtCBgFfPrIf9iUduCEgFfRrQf8
					iIdrB2gEfJqof8iFdqBygDfHqcf8iFdqBygDfHqcf8iFdqBygDfHqcf8iFdqBygDfHqcf8iFdqBygDfHqc]],
				Neck3 = [[
					gAknfIGDgAgAytgAkufwJGgAgA2VgAkxgKLVgAgA4agAkwgDKugDgE34gBkvf1Jkfwfq2zgHktfnIbe0eX1hgGkrfeHqfAeo0rgBkrfbHcf0fv0ff/kqfUG7
					gIgLz3gAkfe9GGf9f8yxf/kFeaFaf2fsxxf+jdd5E2ftfUw4f+izdjEWfge2wAf+iYdaECfUegvcf+iUdZEAfSedvXf+igdcEIfYenvnf+iiddEKfZepvqf+
					iWdaEBfTefvaf+iTdZD/fRecvVf+iTdZD/fRecvVf+iTdZD/fRecvVf+iTdZD/fRecvVf+iTdZD/fRecvV]],
				Head = [[
					gAk8fBACgAgAhDgAlEfvBDgAgAoEgAlHgOChgAgAsZgAlGgGCEf7gDrRgBlFf2BUgefspCgHlDflA2iUeWmqgGlBfaAgiAefk9gBlBfXAVgYftkbf/k/fPAL
					fvgNjOgAk0e2AFfUfsh7f/kZeSALdve2h8f/jxdvAgbvdmikf/jGdYA+Z4cPi8f/irdOBYYrbSjFf/indNBdYfbJjGf/izdRBQZCbljDf/i1dSBOZIbqjCf/
					ipdOBaYmbOjFf/ildNBeYcbGjGf/ildNBeYcbGjGf/ildNBeYcbGjGf/ildNBeYcbGjGf/ildNBeYcbGjG]],
				Jaw = [[
					gAlMej/+gAgAg2gAlgfb/+gAgAe0gAlngC/5gAgAdhgAlmf3/6gGf/d3gDlifj/9fegMeigNlcfP/2dbhNfHgLlYfB/5d0hNfpgClXe9//flgPf4f+lTez//
					gSf1gPgAlGeZ/+gqgYg7f/krd0/1iIhahwf/kEdS/fj0jFitf/jac8+8lMk/jvgAi/cz+dl+mXkdgAi7cy+YmFmkkkgAjHc1+nlwl8kPgAjJc2+qlrl1kLgA
					i9cy+bmBmckggAi6cx+WmHmokmgAi6cx+WmHmokmgAi6cx+WmHmokmgAi6cx+WmHmokmgAi6cx+WmHmokm]],
				Crest = [[
					gAm/e8LcgAgA4ggAm8gjRVgAgA8bgAmrhhVigAgA+Of/mxhRUZf/gG9zgFm6gxSPgGfc83gZm+gPQKgUdL7pgWnAf2OpgNdh6wgEnBfuOJgCfh6if9nBfcNJ
					f/gW51f6m3e5L8fUgT45ftmbeULkdng34efdlvd0LqbShW4MfOlAddLwY+hj3sfFkgdRL0Xbhm3OfEkbdQL0XNhm3JfIkpdULzX5hm3YfJksdVLyYChl3afF
					kedRL0XVhm3MfEkadPL1XIhm3IfEkadPL1XIhm3IfEkadPL1XIhm3IfEkadPL1XIhm3IfEkadPL1XIhm3I]],
				["Humerus.L"] = [[
					fRj0fbYHM2gA4YfRj4f3XWNDbO3yfRj6gKWsNrYY3SfRj6gFW7NfZN3ffSj5f6W7NFaD3ZfWj4frWRMfZq2hfWj3flWoMWbP28fSj2fnXjMtdS37fRj1fkYE
					M5ey4XfRjtfTXOM1ge4DfQjYe5VPNHi73SfPi5ehStN0lg2CfOiaeSQcO1nv0pfOiFeMPDPopCzqfOiCeLO3PwpOzgfOiLeNPdPYoqz9fOiNeOPlPUoj0CfO
					iEeLO+PrpHzmfOiBeLOzPzpSzdfOiBeLOzPzpSzdfOiBeLOzPzpSzdfOiBeLOzPzpSzdfOiBeLOzPzpSzd]],
				["Forearm.L"] = [[
					eCkUfpYSMHgA31eMkrgEXYMVbQ3OeVk3gZWpM+Yb2teSk0gUW6MxZP26eQkwgGW7MXaG2zeWkyfxWRLyZv17eRkrfrWrLpbT2WeIkhfzXpL/dT3XeDkafyYN
					MKey30eCkPfeXfMEgm3heAj5fAVzMVjZ20d/jaeiTnNFmZ1sd+i6eNRqOOo/0gd9ileEQdPJqhzqd9iieDQSPTqvzid9ireHQzO3qFz7d9iteHQ6Oyp9z/d9
					ikeEQYPNqnznd9iheDQOPWqzzgd9iheDQOPWqzzgd9iheDQOPWqzzgd9iheDQOPWqzzgd9iheDQOPWqzzg]],
				["WingFinger1.L"] = [[
					c0kzfyahLngA4CdHlbgMZiLibS3PdZlygjYuL/Yd2pdTlrgdZAL2ZS23dPlmgNZDLfaJ2zdXlqfzYYK3Z417dNldftY0K1ba2ac+lKf6Z2LUdW3dc3k9f7ac
					Lmey39c0kuflZ2Ligx3ycwkUfDYbL3j83WcujyeiWkMznZ2mcsjQeMU5ONqY1zcri6eCT2PWsG1Qcri3eBTtPhsV1LcsjAeEUKO/rm1bcsjCeFUPO5rd1ecr
					i5eBTyPbsM1Ocri2eATpPlsa1Jcri2eATpPlsa1Jcri2eATpPlsa1Jcri2eATpPlsa1Jcri2eATpPlsa1J]],
				["WingFinger2.L"] = [[
					bmlIf8eDLggA4ecAmDgVdCK8bY3ccamkgscKLGYk2ucRmagmceLDZY2+cLmSgUciKxaR2+cVmaf0b1KFaH2JcGmHfvcTKNbn2sbzlqgBdXK7db3ybqlWgGd+
					LYez4VbllDfudgLcg+4WbhkkfLcZMAki4Sbej+era5NVod4BbcjZeXZgPPru3ubbjDePYpQvtk3gbbjAePYhQ+t03dbcjJeRY5QStD3kbcjLeSY+QJs53lbb
					jCePYlQ2tr3fbbi/eOYeRDt53dbbi/eOYeRDt53dbbi/eOYeRDt53dbbi/eOYeRDt53dbbi/eOYeRDt53d]],
				["WingFinger3.L"] = [[
					aclPgJhdL/gA46a6mbgdggK9bf3qbYnIg1fnKzYu20bOm7gvf7K2Zh3GbHmwgbf/Kpac3KbRm6f2fRJ4aY2ZbAmhfyfwKLb13Aarl7gKg0LJdh4HahlhgShZ
					Lve14saclJf6hEL/hM45aXkkfagSM8lM5KaWj4e/fLO6ph5SaXjTezeJRjtA5VaYi+ewdfTku25VaZi7ewdZT3vF5VaYjEexdrS8uV5VaYjGexdvSxuL5VaY
					i9ewddTsu95VaZi6ewdXT+vL5VaZi6ewdXT+vL5VaZi6ewdXT+vL5VaZi6ewdXT+vL5VaZi6ewdXT+vL5V]],
				["Humerus.R"] = [[
					gvj0fbYHzKgA4Ygvj4f3XWy9ky3ygvj6gKWsyVno3Sguj6gFW8yom43Zgwj5f8W2yWln36gzj3f3V1wskv44gyj2fvWWxMjj47gvj2fpXiy0ih4Uguj1fjYF
					zchW4GgujtfSXPzbfm33gujXe3VXzqdI2sgsi1edTLzpaR0+griTeORZzKXgzQgrh8eIQYymVvyHgrh5eIQQyfVfx9griDeKQryyWRydgriFeKQwy1Wayjgr
					h7eIQVyjVoyDgrh4eIQNydVax5grh4eIQNydVax5grh4eIQNydVax5grh4eIQNydVax5grh4eIQNydVax5]],
				["Forearm.R"] = [[
					h+kUfpYSz5gA31h0krgEXYzrkw3Ohrk3gZWpzCnl2thuk0gTW6zVm120hxkvgMW3zElk3WhxkvgNV3xdkr4Yh1kpgEWZx9jg4bh6khf4Xozjig3xh8kafvYN
					0KhW3ih+kPfcXg0Lfe3Uh/j2e5V60bcq2Nh/jQeXUE0VZX0kh/ineCSlzqWNy/h/iMd7Rxy8UNx+h/iId6Rqy0T7x1h/iUd9SAzLUzyRh/iWd9SEzPU+yXh/
					iLd7Ruy4UGx6h/iHd6RoyxT1xyh/iHd6RoyxT1xyh/iHd6RoyxT1xyh/iHd6RoyxT1xyh/iHd6RoyxT1xy]],
				["WingFinger1.R"] = [[
					jMkzfyah0ZgA4Ci5lbgMZi0eku3PinlygjYu0Bnj2pislsgcZB0Rmy2wiylkgWY/z8lk3XiwllgeX+yVkz4fi4lagUYjywjn4kjDlKgBZ10Oig34jIk9f2ac
					0vhU3rjMkufhZ30tfR3ljPkQe4Yi04cC2tjRjiePW/0jYM1ajSixd5VwzgUm0MjTiRdzVEyeSYzajTiNdyU+yTSEzTjTibd0VRy0TBzpjTidd0VUy6TNztjT
					iQdzVCyaSQzXjTiLdyU8yPR9zQjTiLdyU8yPR9zQjTiLdyU8yPR9zQjTiLdyU8yPR9zQjTiLdyU8yPR9zQ]],
				["WingFinger2.R"] = [[
					kalIf8eD0ggA4ekAmDgVdC1Eko3cjmmkgscK06nc2ujumbgkcf1Emr23j3mQghce0pli3jjxmTgwbczClA4zj9mCglcDzUjy46kNlpgMdW0mig4NkWlWf+d+
					0+hQ4CkblCfodh00fC4Jkfkee7cf0ubT3pkijneRbOz6W521kkivd9aOyOS52DkkiLd7ZqwtQi1jkkiGd7ZlwdQN1fkkiVd7Z0xMRN1skkiYd7Z3xVRa1vkk
					iJd7ZowmQZ1hkkiFd7ZjwYQG1dkkiFd7ZjwYQG1dkkiFd7ZjwYQG1dkkiFd7ZjwYQG1dkkiFd7ZjwYQG1d]],
				["WingFinger3.R"] = [[
					lklPgJhd0BgA46lGmbgdgg1Dkh3qkonIg1fn1NnS20kym7gsf81Rmg2/k7mtgsf80vld3vkzmxhDe5zJlK5FlCmbg3ffzRj75OlVl6gYgz0Yie4ilflhgIhZ
					0mhL4alllIfzhF0Rey4slqkcfFgWzxai4ilrjdeefZyPVl4IlqieeSenvqRU3rlnh5eXeKtgO63Xlnh0eYeGtKOm3UloiEeVeTuLPm3dloiHeUeVuYPz3eln
					h3eYeJtXOy3VlmhzeZeFtDOf3TlmhzeZeFtDOf3TlmhzeZeFtDOf3TlmhzeZeFtDOf3TlmhzeZeFtDOf3T]],
				Tail1 = [[
					gAiugAzlgAgA5TgAiugS1ZgAgA3ygAiugd2ggAgA2vgAiuga2OgEf93BgAiugU1pfpgP3jgAiugO0+eVhJ4FgAiugK0jeng/4dgAiugI0dfvgM4lgAitgF0J
					gLf442gAirf+ywgRfx56gAijf0wDgxfK7pgAiafpskhMeL9VgAiRffpKhSdJ+fgAiMfYm8hNce/AgAiLfXmnhLcY/EgAiNfanmhPcr+3gAiOfbnyhQcv+1gA
					iLfYmzhMcc/CgAiLfXmghLcW/FgAiLfXmghLcW/FgAiLfXmghLcW/FgAiLfXmghLcW/FgAiLfXmghLcW/F]],
				Tail2 = [[
					gAiEgLyjgAgA6EgAiDgW0bgAgA4ngAiCgd1kgAgA3ogAiCgc1RgEf+35gAiCgY0rfogO4af/iDgUz+eShF45f/iDgRzjelg85RgAiDgQzdfvgL5ZgAiDgOzI
					gMf45pgAiBgMyFgbfr6YgBh+gJwVhQeu7cgBh7gHuNh+dP8dgBh5gDsLiMbs9MgBh5f/q4iGas9igBh5f/qsiEaj9lgBh5gBrQiJa/9cgBh5gBrXiJbE9agB
					h5f/qziFao9jgBh5f/qoiDag9mgBh5f/qoiDag9mgBh5f/qoiDag9mgBh5f/qoiDag9mgBh5f/qoiDag9m]],
				Tail3 = [[
					gAhbgZw0gAgA7NgAhYgeyygAgA55gAhXgh0AgAgA4+gAhXghzrgFf+5Of/hYgfzDfogM5sf9hZgdyUeOg+6Jf9hZgcx3ehg26ff/hZgcxxfugK6mgAhagbxb
					gMf560gBhZgbwvgnfm7QgChYgev8h0eZ7ogChYghvHi5cd70gChaghuXjSaf72gBhdggt7jOZO7zgBhdggt4jMZD7ygChcghuDjRZm70gChcghuGjRZt71gB
					hdggt6jNZK7zgBheggt2jLY/7ygBheggt2jLY/7ygBheggt2jLY/7ygBheggt2jLY/7ygBheggt2jLY/7y]],
			},
		},
	},
}
