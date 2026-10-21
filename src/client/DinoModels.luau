--!strict
-- Dinos 3D construits AU RUNTIME sur le client, à partir des données générées depuis Blender :
--   DinoMeshes/<id> (sommets, triangles, slots de couleur, os, skinning), DinoAnims/<id> (clips échantillonnés),
--   Config/DinoLooks (couleurs). Aucun import FBX ni upload Roblox (option « Allow Mesh / Image APIs »).
-- Os : AddBone/SetBoneCFrame ne fixent que la POSE DE LIAISON (doc API) ; l'animation passe par des instances
-- Bone (une par os, même nom) sous la MeshPart, dont on écrit le CFrame relatif au parent.
-- Tout est en pcall : si quelque chose échoue, create() renvoie nil et l'appelant garde son cube.

local AssetService = game:GetService("AssetService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Config = ReplicatedStorage.Shared.Config
local Dinos = require(Config.Dinos)
local Mutations = require(Config.Mutations)
local Rarities = require(Config.Rarities)

local looksModule = Config:FindFirstChild("DinoLooks")
local Looks: { [string]: any } = if looksModule then (require :: any)(looksModule) else {}
local meshFolder = script.Parent:FindFirstChild("DinoMeshes")
local animFolder = script.Parent:FindFirstChild("DinoAnims")

local MAX_DISTANCE = 150 -- au-delà, les dinos du monde ne sont plus animés
local TICK = 1 / 30 -- mise à jour des os à 30 Hz max
local FADE = 0.2 -- fondu enchaîné entre deux clips (s)
local RAINBOW_STEPS = 12
local FLAT_SHADING = true -- une normale par face : rendu à facettes « plaques de jouet » (style choisi le 21/10/2026)
local EYE_WHITE = Color3.new(1, 1, 1)
local PUPIL = Color3.fromHex("#1A1A1A")
local MOUTH = Color3.fromHex("#9C2D4F") -- intérieur de bouche (slot 8), rose foncé du style chibi
local TONGUE = Color3.fromHex("#F06292") -- langue (slot 9)

type Clip = { loop: boolean, fps: number, frames: number, locals: { { CFrame } } } -- locals[image][os]
type Data = {
	raw: any,
	center: Vector3,
	size: Vector3,
	names: { string },
	parents: { number },
	bind: { CFrame }, -- pose de liaison, espace modèle recentré
	rest: { CFrame }, -- pose de liaison, relative au parent
	clips: { [string]: Clip },
}
type Rig = { data: Data, bones: { Bone } }
type Player = {
	rig: Rig,
	clip: Clip,
	t: number,
	prev: Clip?,
	prevT: number,
	fade: number,
	speed: number,
	thenClip: string?,
	seen: boolean,
	inViewport: boolean,
}

export type PlayOptions = {
	thenClip: string?, -- clip enchaîné quand un clip non bouclé se termine (ex. « Idle »)
	speed: number?,
}

local dinoById: { [string]: Dinos.Dino } = {}
for _, dino in Dinos do
	dinoById[dino.id] = dino
end

local parsed: { [string]: Data | false } = {}
-- shortcut: un EditableMesh par (dino, peau) gardé toute la session (≤ 28×6), à libérer si la mémoire mobile coince.
local meshes: { [string]: EditableMesh } = {}
local rigs: { [Model]: Rig } = setmetatable({}, { __mode = "k" }) :: any
local active: { [Model]: Player } = {}
local connection: RBXScriptConnection? = nil

local function cframeAt(t: { number }, i: number): CFrame
	return CFrame.new(
		t[i],
		t[i + 1],
		t[i + 2],
		t[i + 3],
		t[i + 4],
		t[i + 5],
		t[i + 6],
		t[i + 7],
		t[i + 8],
		t[i + 9],
		t[i + 10],
		t[i + 11]
	)
end

-- Format « dd64 » (blender/scripts/export_luau.py) : w caractères base64 par valeur, poids fort d'abord,
-- valeurs signées décalées de 64^w / 2.
local LUT: { [number]: number } = {}
for i, byte in { string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", 1, 64) } do
	LUT[byte] = i - 1
end
local function decode(s: string, w: number, signed: boolean, scale: number): { number }
	s = string.gsub(s, "%s", "")
	assert(#s % w == 0, "chaîne dd64 tronquée")
	local out, half = table.create(#s // w), if signed then 64 ^ w / 2 else 0
	for i = 1, #s, w do
		local v = 0
		for j = i, i + w - 1 do
			v = v * 64 + assert(LUT[string.byte(s, j)], "caractère dd64 invalide")
		end
		table.insert(out, (v - half) * scale)
	end
	return out
end

local function find(list: { any }, id: string?): any
	for _, row in list do
		if row.id == id then
			return row
		end
	end
	return nil
end

-- Lit et précalcule les données d'un dino (une seule fois). nil si absentes ou invalides.
local function load(dinoId: string): Data?
	local cached = parsed[dinoId]
	if cached ~= nil then
		return cached or nil
	end
	local module = meshFolder and meshFolder:FindFirstChild(dinoId)
	if not module then
		return nil -- pas encore exporté : pas mis en cache, le fichier peut arriver via Rojo
	end
	local ok, result = pcall(function(): Data
		local source = (require :: any)(module)
		assert(source.version == 2 and source.encoding == "dd64", "version de maillage inconnue")
		local raw = {
			positions = decode(source.positions, 2, true, 0.01),
			triangles = decode(source.triangles, 3, false, 1),
			slots = decode(source.slots, 1, false, 1),
			skinBones = decode(source.skinBones, 1, false, 1),
			skinWeights = decode(source.skinWeights, 1, false, 1 / 63),
		}
		assert(#raw.positions == source.vertexCount * 3 and #raw.skinBones == source.vertexCount * 4, "sommets")
		assert(#raw.slots == source.triangleCount and #raw.triangles == source.triangleCount * 3, "triangles")
		local p = raw.positions
		local lo, hi = Vector3.one * math.huge, -Vector3.one * math.huge
		for i = 1, #p, 3 do
			local v = Vector3.new(p[i], p[i + 1], p[i + 2])
			lo, hi = lo:Min(v), hi:Max(v)
		end
		local center = (lo + hi) / 2
		-- Recentré sur la boîte : la MeshPart a son origine au centre, quel que soit le comportement du moteur.
		local shift = CFrame.new(-center)

		local names, parents, bind, rest = {}, {}, {}, {}
		for i, bone in source.bones do
			names[i], parents[i] = bone.name, bone.parent
			bind[i] = shift * cframeAt(bone.cf, 1)
			rest[i] = if bone.parent > 0 then bind[bone.parent]:Inverse() * bind[i] else bind[i]
		end

		local clips: { [string]: Clip } = {}
		local animModule = animFolder and animFolder:FindFirstChild(dinoId)
		if animModule then
			local anims = (require :: any)(animModule)
			for clipName, clip in anims.clips do
				-- Par os : 7 valeurs par image, x y z (×0,01) puis quaternion (×1/2047), pose en espace modèle.
				local tracks: { [number]: { number } } = {}
				for i, name in names do
					local encoded = clip.bones[name]
					if encoded then
						tracks[i] = decode(encoded, 2, true, 1)
						assert(#tracks[i] == clip.frames * 7, `piste {clipName}.{name}`)
					end
				end
				local locals = table.create(clip.frames)
				for f = 1, clip.frames do
					local posed, frame = {}, {}
					local k = (f - 1) * 7
					for i in names do
						local track = tracks[i]
						local parent = parents[i]
						posed[i] = if track
							then shift * CFrame.new(
								track[k + 1] * 0.01,
								track[k + 2] * 0.01,
								track[k + 3] * 0.01,
								track[k + 4] / 2047,
								track[k + 5] / 2047,
								track[k + 6] / 2047,
								track[k + 7] / 2047
							)
							elseif parent > 0 then posed[parent] * rest[i]
							else bind[i]
						frame[i] = if parent > 0 then posed[parent]:Inverse() * posed[i] else posed[i]
					end
					locals[f] = frame
				end
				clips[clipName] = {
					loop = clip.loop == true,
					fps = clip.fps or anims.fps or 15,
					frames = clip.frames,
					locals = locals,
				}
			end
		end
		return {
			raw = raw,
			center = center,
			size = hi - lo,
			names = names,
			parents = parents,
			bind = bind,
			rest = rest,
			clips = clips,
		}
	end)
	if not ok then
		warn(`[DinoModels] données invalides pour {dinoId} : {result}`)
	end
	parsed[dinoId] = if ok then result else false
	return if ok then result else nil
end

local function brighter(color: Color3): Color3
	local h, s = color:ToHSV()
	return Color3.fromHSV(h, s * 0.75, 1)
end

-- EditableMesh skinné et colorié (couleurs par face selon le slot), partagé par toutes les copies (dino, peau).
local function meshFor(dinoId: string, data: Data, skinId: string): EditableMesh
	local key = `{dinoId}|{skinId}`
	local cached = meshes[key]
	if cached then
		return cached
	end
	local raw = data.raw
	local mesh = AssetService:CreateEditableMesh()
	assert(mesh, "budget mémoire EditableMesh épuisé")

	local p, c = raw.positions, data.center
	local verts = table.create(#p // 3)
	for i = 1, #p, 3 do
		table.insert(verts, mesh:AddVertex(Vector3.new(p[i] - c.X, p[i + 1] - c.Y, p[i + 2] - c.Z)))
	end

	local boneIds = {}
	for i, name in data.names do
		local parent = data.parents[i]
		boneIds[i] = mesh:AddBone({
			Name = name,
			ParentId = if parent > 0 then boneIds[parent] else nil,
			CFrame = data.bind[i],
			Virtual = false, -- obligatoire (« Missing bone Virtual value » sinon)
		})
	end
	local skinBones, skinWeights = raw.skinBones, raw.skinWeights
	for v, id in verts do
		local ids, weights = {}, {}
		for k = (v - 1) * 4 + 1, v * 4 do
			if skinBones[k] > 0 and skinWeights[k] > 0 then
				table.insert(ids, boneIds[skinBones[k]])
				table.insert(weights, skinWeights[k])
			end
		end
		if #ids > 0 then
			mesh:SetVertexBones(id, ids)
			mesh:SetVertexBoneWeights(id, weights)
		end
	end

	-- Couleurs : DinoLooks, sinon dérivées de la rareté. La mutation de peau recolore le slot principal.
	local dino = dinoById[dinoId]
	local look = (Looks[dinoId] or {}).colors or {}
	local function hex(value: string?, default: Color3): Color3
		return if value then Color3.fromHex(value) else default
	end
	local main = hex(look.main, if dino then Rarities[dino.rarity].color else Color3.new(0.6, 0.6, 0.6))
	local skin = find(Mutations.Skins, skinId)
	if skin and skin.color then
		main = Color3.fromHex(skin.color)
	end
	local accent = hex(look.accent, main:Lerp(Color3.new(), 0.35))
	local slotColors = {
		main,
		hex(look.belly, main:Lerp(Color3.new(1, 1, 1), 0.45)),
		accent,
		EYE_WHITE,
		PUPIL,
		brighter(hex(look.glow, accent)),
		hex(look.back, main:Lerp(Color3.new(), 0.25)),
		MOUTH,
		TONGUE,
	}
	local colorIds = {}
	for slot, color in slotColors do
		colorIds[slot] = mesh:AddColor(color, 1)
	end
	local rainbowIds: { number }? = nil
	if skinId == "rainbow" then
		rainbowIds = {}
		for k = 0, RAINBOW_STEPS - 1 do
			table.insert(rainbowIds :: { number }, mesh:AddColor(Color3.fromHSV(k / RAINBOW_STEPS, 0.75, 1), 1))
		end
	end

	local t, slots = raw.triangles, raw.slots
	for f = 1, #slots do
		local a = t[f * 3 - 2]
		local face = mesh:AddTriangle(verts[a], verts[t[f * 3 - 1]], verts[t[f * 3]])
		local color = colorIds[slots[f]] or colorIds[1]
		if rainbowIds and slots[f] == 1 then
			-- Bandes de couleur le long du corps (axe Z, de la tête à la queue).
			local along = (p[a * 3] - c.Z) / math.max(data.size.Z, 0.01) + 0.5
			color = rainbowIds[math.clamp(math.floor(along * RAINBOW_STEPS), 0, RAINBOW_STEPS - 1) + 1]
		end
		mesh:SetFaceColors(face, { color, color, color })
		if FLAT_SHADING then
			-- Triangles anti-horaires vus de l'extérieur : (b - a) x (c - a) pointe vers l'extérieur.
			local b, d = t[f * 3 - 1], t[f * 3]
			local pa = Vector3.new(p[a * 3 - 2], p[a * 3 - 1], p[a * 3])
			local n = (Vector3.new(p[b * 3 - 2], p[b * 3 - 1], p[b * 3]) - pa):Cross(
				Vector3.new(p[d * 3 - 2], p[d * 3 - 1], p[d * 3]) - pa
			)
			if n.Magnitude > 1e-9 then
				local normal = mesh:AddNormal(n.Unit)
				mesh:SetFaceNormals(face, { normal, normal, normal })
			end
		end
	end
	meshes[key] = mesh
	return mesh
end

local DinoModels = {}

-- Vrai si le maillage généré de ce dino est disponible.
function DinoModels.has(dinoId: string): boolean
	return load(dinoId) ~= nil
end

-- Modèle 3D (pivot aux pieds, ancré, sans collision). Cède la main (CreateMeshPartAsync). nil = garder le repli.
function DinoModels.create(dinoId: string, size: string?, skin: string?): Model?
	local data = load(dinoId)
	if not data then
		return nil
	end
	local ok, result = pcall(function(): Model
		local mesh = meshFor(dinoId, data, skin or Mutations.defaultId)
		local part = AssetService:CreateMeshPartAsync(Content.fromObject(mesh))
		part.Name = "Body"
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Color = Color3.new(1, 1, 1) -- les couleurs viennent des sommets
		part.Material = Enum.Material.SmoothPlastic
		part.CFrame = CFrame.new(data.center)
		part.PivotOffset = CFrame.new(-data.center) -- pivot aux pieds (origine Blender)

		local bones = {}
		for i, name in data.names do
			local bone = Instance.new("Bone")
			bone.Name = name
			bone.CFrame = data.rest[i]
			local parent = data.parents[i]
			bone.Parent = if parent > 0 then bones[parent] else part
			bones[i] = bone
		end

		local model = Instance.new("Model")
		model.Name = "Dino"
		part.Parent = model
		model.PrimaryPart = part
		model:SetAttribute("DinoId", dinoId)
		local sizeRow = find(Mutations.Sizes, size)
		if sizeRow and sizeRow.modelScale ~= 1 then
			model:ScaleTo(sizeRow.modelScale)
		end
		rigs[model] = { data = data, bones = bones }
		return model
	end)
	if not ok then
		warn(`[DinoModels] création impossible pour {dinoId}, cube de repli : {result}`)
		parsed[dinoId] = false -- plus de tentative (ni d'EditableMesh perdu) pour ce dino cette session
		return nil
	end
	return result
end

local function sample(clip: Clip, t: number, bone: number): CFrame
	local x = t * clip.fps
	local f0 = math.floor(x)
	local alpha = x - f0
	local n = clip.frames
	local f1
	if clip.loop then
		f0 %= n
		f1 = (f0 + 1) % n
	else
		f0 = math.clamp(f0, 0, n - 1)
		f1 = math.min(f0 + 1, n - 1)
	end
	return clip.locals[f0 + 1][bone]:Lerp(clip.locals[f1 + 1][bone], alpha)
end

local function step(dt: number)
	local camera = Workspace.CurrentCamera
	local eye = if camera then camera.CFrame.Position else Vector3.zero
	for model, player in active do
		if not model:IsDescendantOf(game) then
			if player.seen then
				active[model] = nil -- détruit ou retiré : on oublie (pas de fuite)
			end
			continue
		end
		if not player.seen then
			player.seen = true
			player.inViewport = model:FindFirstAncestorWhichIsA("ViewportFrame") ~= nil
		end
		player.t += dt * player.speed
		player.prevT += dt * player.speed
		player.fade = math.min(player.fade + dt / FADE, 1)

		local clip = player.clip
		if not clip.loop and player.t * clip.fps >= clip.frames - 1 and player.thenClip then
			DinoModels.play(model, player.thenClip)
			continue
		end
		local primary = model.PrimaryPart
		if not player.inViewport and primary and (primary.Position - eye).Magnitude > MAX_DISTANCE then
			continue
		end

		local scale = model:GetScale()
		local prev = if player.fade < 1 then player.prev else nil
		for i, bone in player.rig.bones do
			local cf = sample(clip, player.t, i)
			if prev then
				cf = sample(prev, player.prevT, i):Lerp(cf, player.fade)
			end
			bone.CFrame = if scale == 1 then cf else cf.Rotation + cf.Position * scale
		end
	end
	if next(active) == nil and connection then
		connection:Disconnect()
		connection = nil
	end
end

-- Joue un clip (Idle, Walk, Run, Attack, Roar, Celebrate, Death) avec fondu depuis le clip en cours.
-- Les modèles sortis du jeu sont oubliés automatiquement ; stop() pour arrêter explicitement.
function DinoModels.play(model: Model, clipName: string, opts: PlayOptions?)
	local rig = rigs[model]
	local clip = rig and rig.data.clips[clipName]
	if not rig or not clip then
		return
	end
	local o: PlayOptions = opts or {}
	local current = active[model]
	active[model] = {
		rig = rig,
		clip = clip,
		t = 0,
		prev = if current then current.clip else nil,
		prevT = if current then current.t else 0,
		fade = if current then 0 else 1,
		speed = o.speed or 1,
		thenClip = o.thenClip,
		seen = if current then current.seen else false,
		inViewport = if current then current.inViewport else false,
	}
	if not connection then
		local acc = 0
		connection = RunService.Heartbeat:Connect(function(dt)
			acc += dt
			if acc >= TICK then
				step(acc)
				acc = 0
			end
		end)
	end
end

function DinoModels.stop(model: Model)
	active[model] = nil
end

return DinoModels
