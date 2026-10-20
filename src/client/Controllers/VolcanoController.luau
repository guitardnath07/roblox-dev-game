--!strict
-- Volcan des Défis côté client : ouvre le choix d'équipe quand le ProximityPrompt « OpensVolcano » est déclenché,
-- puis affiche le combat envoyé par le serveur : étage, badge BOSS, PV de l'ennemi et de l'équipe animés par
-- VolcanoFx (chiffres de dégâts flottants, secousse), « Continuer automatiquement » (VolcanoSetAuto),
-- « Abandonner » (VolcanoQuit), panneau de victoire / défaite. VolcanoState nil = on ferme.
-- Le combat est entièrement décidé par le serveur : le client ne fait que rejouer les coups reçus.

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Products = require(Shared.Config.Products)
local Relics = require(Shared.Config.Relics)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataController = require(script.Parent.DataController)
local UIController = require(script.Parent.UIController)

local UI = script.Parent.Parent.UI
local Kit = require(UI.Kit)
local Theme = require(UI.Theme)

type Bar = { fill: Frame, text: TextLabel, holder: Frame, max: number, left: number }

local root: Frame
local fightMaid: Kit.Maid? = nil
local enemyBar: Bar? = nil
local teamBars: { [string]: Bar } = {}
local resultPanel: Frame? = nil
local auto = false

local VolcanoController = {}

local function makeBar(parent: Instance, color: Color3, props: { [string]: any }): Bar
	local holder = Kit.new("Frame", { BackgroundColor3 = Theme.StoneDark, Parent = parent })
	for key, value in props do
		(holder :: any)[key] = value
	end
	Kit.corner(holder, 0.5)
	Kit.stroke(holder, Theme.Black, 2, 0.4)
	local fill = Kit.new("Frame", { BackgroundColor3 = color, Size = UDim2.fromScale(1, 1), Parent = holder })
	Kit.corner(fill, 0.5)
	local text = Kit.number(
		holder,
		"",
		{ TextColor3 = Theme.White, TextStrokeTransparency = 0.3, ZIndex = 3, Font = Enum.Font.GothamBold },
		18
	)
	return { fill = fill, text = text, holder = holder, max = 1, left = 1 }
end

local function setBar(bar: Bar, left: number)
	bar.left = math.max(0, left)
	local p = if bar.max > 0 then bar.left / bar.max else 0
	Kit.tween(bar.fill, 0.25, { Size = UDim2.fromScale(p, 1) })
	bar.text.Text = `{Kit.big(bar.left)} / {Kit.big(bar.max)}`
end

-- Chiffre de dégâts qui monte et s'efface au-dessus d'une barre.
local function floatNumber(bar: Bar, amount: number, color: Color3)
	local label = Kit.number(root, `-{Kit.big(amount)}`, {
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.fromOffset(90, 28),
		TextColor3 = color,
		TextStrokeTransparency = 0,
		Font = Enum.Font.GothamBlack,
		ZIndex = 10,
	}, 26)
	local scale = UIController:GetScale()
	local center = bar.holder.AbsolutePosition
		+ Vector2.new(bar.holder.AbsoluteSize.X * (0.3 + math.random() * 0.4), bar.holder.AbsoluteSize.Y) -- part du bas de la barre : reste à l'écran même tout en haut
	label.Position = UDim2.fromOffset(center.X / scale, center.Y / scale)
	Kit.tween(
		label,
		0.7,
		{ Position = label.Position - UDim2.fromOffset(0, 40), TextTransparency = 1, TextStrokeTransparency = 1 }
	)
	task.delay(0.7, function()
		label:Destroy()
	end)
end

local function shake(target: GuiObject)
	target.Rotation = 3
	Kit.tween(target, 0.25, { Rotation = 0 }, Enum.EasingStyle.Elastic)
end

local function setHudVisible(visible: boolean)
	local hud = Players.LocalPlayer.PlayerGui:FindFirstChild("DinoHud")
	if hud and hud:IsA("ScreenGui") then
		hud.Enabled = visible
	end
end

local function close()
	if fightMaid then
		fightMaid:clean()
	end
	fightMaid = nil
	enemyBar = nil
	teamBars = {}
	resultPanel = nil
	setHudVisible(true)
end

local function rewardText(rewards: any): string
	if not rewards then
		return ""
	end
	local parts = { `+{rewards.amber} 🔶`, `+{rewards.bones} 🦴` }
	local potion = rewards.potionId and Kit.find(Products.potions, rewards.potionId)
	if potion then
		table.insert(parts, `+1 {potion.displayName}`)
	end
	local relic = rewards.relicId and Kit.find(Relics.list, rewards.relicId)
	if relic then
		table.insert(parts, `RELIQUE : {relic.displayName} !`)
	end
	return table.concat(parts, "   ")
end

local function showResult(state: Types.VolcanoState)
	if not fightMaid then
		return
	end
	local won = state.phase == "won"
	local holder, body = Kit.panel(root, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.48),
		Size = UDim2.fromScale(1, 0.4),
		ZIndex = 5,
	}, Theme.Parchment, 0.08)
	Kit.aspect(holder, 2.2, true)
	fightMaid:add(holder)
	resultPanel = holder
	local stroke = body:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Color = if won then Theme.Gold else Theme.Lava
	end
	Kit.title(body, if won then `Étage {state.floor} réussi !` else `Défaite à l'étage {state.floor}`, {
		Position = UDim2.fromScale(0.05, 0.08),
		Size = UDim2.fromScale(0.9, 0.35),
		TextColor3 = if won then Theme.LeafDark else Theme.Lava,
	}, 40)
	Kit.number(
		body,
		if won then rewardText(state.rewards) else "Renforce ton équipe (Instincts, arbre, Reliques) et reviens !",
		{
			Position = UDim2.fromScale(0.05, 0.48),
			Size = UDim2.fromScale(0.9, 0.22),
			Font = Enum.Font.GothamBold,
		},
		24
	)
	Kit.label(body, if won and auto then "Étage suivant…" else "Retour au campement…", {
		Position = UDim2.fromScale(0.05, 0.74),
		Size = UDim2.fromScale(0.9, 0.18),
		TextColor3 = Theme.InkSoft,
	}, 18)
	local pop = Kit.new("UIScale", { Scale = 0.6, Parent = holder })
	Kit.tween(pop, 0.35, { Scale = 1 }, Enum.EasingStyle.Back)
end

-- Construit l'écran d'un nouvel étage.
local function buildFight(state: Types.VolcanoState)
	close()
	setHudVisible(false)
	UIController:CloseWindow()
	local maid = Kit.maid()
	fightMaid = maid
	auto = state.auto

	-- Haut : étage, BOSS, PV de l'ennemi.
	local topHolder, top = Kit.panel(root, {
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 6),
		Size = UDim2.fromScale(1, 0.22),
	}, Theme.Parchment, 0.12)
	Kit.aspect(topHolder, 4, true)
	Kit.limit(topHolder, nil, Vector2.new(700, 175))
	maid:add(topHolder)
	Kit.title(top, `🌋 Étage {state.floor}`, {
		Position = UDim2.fromScale(0.04, 0.06),
		Size = UDim2.fromScale(0.5, 0.4),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, 32)
	if state.isBoss then
		local badge = Kit.new("Frame", {
			BackgroundColor3 = Theme.Lava,
			Position = UDim2.fromScale(0.72, 0.08),
			Size = UDim2.fromScale(0.24, 0.36),
			Rotation = 4,
			Parent = top,
		})
		Kit.corner(badge, 0.4)
		Kit.stroke(badge, Theme.Gold, 2)
		Kit.title(badge, "BOSS", { TextColor3 = Theme.White, TextStrokeTransparency = 0.3 }, 26)
		maid:add(Kit.loop(badge, 0.5, { Rotation = -4 }, true, Enum.EasingStyle.Sine))
	end
	local bar = makeBar(top, Theme.Lava, { Position = UDim2.fromScale(0.04, 0.55), Size = UDim2.fromScale(0.92, 0.32) })
	bar.max = state.enemyHealth
	setBar(bar, state.enemyHealth)
	enemyBar = bar
	local intro = Kit.new("UIScale", { Scale = 0.7, Parent = topHolder })
	Kit.tween(intro, 0.35, { Scale = 1 }, Enum.EasingStyle.Back)

	-- Bas : l'équipe.
	local teamRow = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -6),
		Size = UDim2.fromScale(1, 0.24),
		Parent = root,
	})
	Kit.aspect(teamRow, 5.5, true)
	Kit.limit(teamRow, nil, Vector2.new(900, 165))
	maid:add(teamRow)
	Kit.list(teamRow, true, 0.012, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
	for i, member in state.team do
		local rarity = Kit.rarityOf(member.dinoId)
		local dino = Kit.dinoById[member.dinoId]
		local cardHolder, card =
			Kit.panel(teamRow, { LayoutOrder = i, Size = UDim2.fromScale(0.19, 1) }, Theme.Parchment, 0.1)
		local stroke = card:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = rarity.color
		end
		Kit.stagger(cardHolder, i)
		Kit.title(card, if dino then dino.displayName else "?", {
			Position = UDim2.fromScale(0.05, 0.06),
			Size = UDim2.fromScale(0.9, 0.3),
			TextColor3 = Kit.darker(rarity.color, 0.2),
		}, 18)
		Kit.number(
			card,
			`⚔️ {Kit.big(member.damage)}/s`,
			{ Position = UDim2.fromScale(0.05, 0.36), Size = UDim2.fromScale(0.9, 0.22) },
			15
		)
		local memberBar =
			makeBar(card, Theme.Leaf, { Position = UDim2.fromScale(0.05, 0.64), Size = UDim2.fromScale(0.9, 0.28) })
		memberBar.max = member.health
		setBar(memberBar, member.health)
		teamBars[member.uuid] = memberBar
	end

	-- Droite : Auto et Abandonner.
	local side = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -6, 0, 6),
		Size = UDim2.fromScale(0.2, 0.32),
		Parent = root,
	})
	Kit.limit(side, nil, Vector2.new(220, 120))
	maid:add(side)
	Kit.list(side, false, 0.06)
	local function sideButton(order: number, text: string, color: Color3): TextButton
		local holder = Kit.new(
			"Frame",
			{ BackgroundTransparency = 1, LayoutOrder = order, Size = UDim2.fromScale(1, 0.47), Parent = side }
		)
		return Kit.button(holder, text, { color = color, maxText = 18 })
	end
	local autoB = sideButton(1, "", Theme.Stone)
	local function paintAuto()
		autoB.Text = if auto then "Auto ✔" else "Continuer auto"
		Kit.paint(autoB, if auto then Theme.Leaf else Theme.Stone)
	end
	paintAuto()
	maid:add(autoB.Activated:Connect(function()
		auto = not auto
		Remotes.VolcanoSetAuto:FireServer(auto)
		paintAuto()
	end))
	local quit = sideButton(2, "Abandonner", Theme.Lava)
	maid:add(quit.Activated:Connect(function()
		Remotes.VolcanoQuit:FireServer()
	end))
end

local function onHits(hits: { any })
	if not fightMaid or type(hits) ~= "table" then
		return
	end
	for _, hit in hits do
		if type(hit) == "table" and type(hit.amount) == "number" then
			if hit.target == "enemy" then
				local bar = enemyBar
				if bar then
					setBar(bar, bar.left - hit.amount)
					floatNumber(bar, hit.amount, Theme.Gold)
					shake(bar.holder)
				end
			else
				local bar = teamBars[hit.target]
				if bar then
					setBar(bar, bar.left - hit.amount)
					floatNumber(bar, hit.amount, Theme.Lava)
					shake(bar.holder)
					if hit.killed then
						Kit.tween(bar.holder, 0.3, { BackgroundTransparency = 0.6 })
					end
				end
			end
		end
	end
end

function VolcanoController:Start()
	DataController:Get()
	root = UIController:CreateLayer("DinoVolcano", 3)

	ProximityPromptService.PromptTriggered:Connect(function(prompt: ProximityPrompt)
		if prompt:GetAttribute("OpensVolcano") and not fightMaid then
			UIController:Open("VolcanoTeam")
		end
	end)

	Remotes.VolcanoState.OnClientEvent:Connect(function(state: Types.VolcanoState?)
		if not state then
			-- Laisse le panneau de résultat visible un instant avant de fermer.
			if resultPanel then
				task.delay(2.5, function()
					if resultPanel then
						close()
					end
				end)
			else
				close()
			end
		elseif state.phase == "fighting" then
			buildFight(state)
		else
			auto = state.auto
			showResult(state)
		end
	end)

	Remotes.VolcanoFx.OnClientEvent:Connect(onHits)
end

return VolcanoController
