--!strict
-- Reliques : 5 emplacements (Config/Relics.slots), reliques possédées (profil « Relics »),
-- EquipRelic(slotId, uuid) pour équiper, EquipRelic(slotId, nil) pour retirer.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage.Shared
local Relics = require(Shared.Config.Relics)
local Remotes = require(Shared.Net.Remotes)
local Types = require(Shared.Types)

local DataController = require(script.Parent.Parent.Parent.Controllers.DataController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "💍 Reliques" }

local STAT_LABEL: { [string]: string } = {
	luckBonus = "Chance",
	coinsBonus = "Pièces",
	damageBonus = "Dégâts",
	healthBonus = "PV",
	rollSpeedBonus = "Vitesse de lancer",
}

local TIER_COLOR: { [number]: Color3 } = {
	[1] = Color3.fromHex("#4FA3D9"),
	[2] = Color3.fromHex("#9C27B0"),
	[3] = Color3.fromHex("#FF9800"),
}

local function effect(relic: Relics.Relic): string
	return `{STAT_LABEL[relic.stat] or relic.stat} +{math.floor(relic.value * 100 + 0.5)} %`
end

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()
	local selectedSlot = Relics.slots[1].id

	local slotsRow =
		Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.4), Parent = win.content })
	Kit.list(slotsRow, true, 0.012, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
	local list = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.43), Size = UDim2.fromScale(1, 0.57) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), Parent = list })

	local maid = Kit.maid()
	win.maid:add(maid)
	local animateIn = true

	local function render()
		maid:clean()
		for i, slot in Relics.slots do
			local equippedUuid = data.EquippedRelics[slot.id]
			local owned = equippedUuid and data.Relics[equippedUuid]
			local relic = owned and Kit.find(Relics.list, owned.relicId)
			local card = Kit.new("TextButton", {
				AutoButtonColor = true,
				Text = "",
				LayoutOrder = i,
				BackgroundColor3 = if slot.id == selectedSlot then Theme.Gold else Theme.Parchment,
				Size = UDim2.fromScale(0.19, 0.95),
				Parent = slotsRow,
			})
			maid:add(card)
			Kit.corner(card, 0.12)
			Kit.stroke(
				card,
				if relic then TIER_COLOR[relic.tier] or Theme.Stone else Theme.Stone,
				if relic then 3 else 2
			)
			Kit.feedback(card)
			if animateIn then
				Kit.stagger(card, i)
			end
			Kit.title(
				card,
				slot.displayName,
				{ Position = UDim2.fromScale(0.05, 0.04), Size = UDim2.fromScale(0.9, 0.22) },
				20
			)
			Kit.label(card, if relic then `{relic.displayName}\n{effect(relic)}` else "Vide", {
				Position = UDim2.fromScale(0.05, 0.28),
				Size = UDim2.fromScale(0.9, 0.36),
				TextColor3 = if relic then Theme.Ink else Theme.InkSoft,
			}, 16)
			maid:add(card.Activated:Connect(function()
				selectedSlot = slot.id
				render()
			end))
			if relic then
				local holder = Kit.new("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.08, 0.68),
					Size = UDim2.fromScale(0.84, 0.28),
					Parent = card,
				})
				Kit.button(holder, "Retirer", {
					color = Theme.Stone,
					maid = maid,
					maxText = 16,
					onClick = function()
						Remotes.EquipRelic:FireServer(slot.id, nil)
					end,
				})
			end
		end

		-- Reliques possédées pour l'emplacement choisi.
		local order = 0
		for uuid, owned in data.Relics do
			local relic = Kit.find(Relics.list, owned.relicId)
			if relic and relic.slot == selectedSlot then
				order += 1
				local equipped = data.EquippedRelics[relic.slot] == uuid
				local row = Kit.row(list, {
					{
						text = relic.displayName,
						width = 0.38,
						font = Theme.TitleFont,
						color = Kit.darker(TIER_COLOR[relic.tier] or Theme.Ink, 0.1),
					},
					{ text = `Palier {relic.tier} · {effect(relic)}`, width = 0.4, color = Theme.InkSoft },
				}, -relic.tier * 1000 + order, 48, if order % 2 == 0 then Theme.ParchmentDark else nil)
				maid:add(row)
				local holder = Kit.new("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.79, 0.04),
					Size = UDim2.fromScale(0.2, 0.92),
					Parent = row,
				})
				Kit.button(holder, if equipped then "Équipée ✔" else "Équiper", {
					color = if equipped then Theme.LeafDark else Theme.Leaf,
					maid = maid,
					maxText = 18,
					onClick = function()
						if not equipped then
							Remotes.EquipRelic:FireServer(relic.slot, uuid)
						end
					end,
				})
			end
		end
		if order == 0 then
			maid:add(
				Kit.label(
					list,
					"Aucune relique pour cet emplacement. Gagne-en au Volcan des Défis (dès l'étage 25) !",
					{
						Size = UDim2.new(1, 0, 0, 60),
						TextColor3 = Theme.InkSoft,
					},
					20
				)
			)
		end
		animateIn = false
	end

	win.maid:add(DataController:OnChanged("Relics", render))
	win.maid:add(DataController:OnChanged("EquippedRelics", render))
	render()
end

return Screen
