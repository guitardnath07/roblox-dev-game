--!strict
-- Réglages : interrupteurs (Musique, Effets sonores, Masquer les révélations, Auto-Lancer).

local Controllers = script.Parent.Parent.Parent.Controllers
local SettingsController = require(Controllers.SettingsController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "⚙️ Réglages", aspect = 1.5 }

local ITEMS: { { key: SettingsController.Key, label: string } } = {
	{ key = "Music", label = "🎵 Musique" },
	{ key = "Sfx", label = "🔊 Effets sonores" },
	{ key = "HideReveal", label = "🙈 Masquer les révélations" },
	{ key = "AutoRoll", label = "🎲 Auto-Lancer" },
}

function Screen.build(win: Window.Window)
	local list = Kit.new("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.82), Parent = win.content })
	Kit.list(list, false, 0.03)
	local refreshers: { () -> () } = {}
	for i, item in ITEMS do
		local row = Kit.new("Frame", {
			BackgroundColor3 = Theme.ParchmentDark,
			LayoutOrder = i,
			Size = UDim2.fromScale(1, 0.22),
			Parent = list,
		})
		Kit.corner(row, 0.2)
		Kit.title(row, item.label, {
			Position = UDim2.fromScale(0.03, 0.1),
			Size = UDim2.fromScale(0.6, 0.8),
			TextXAlignment = Enum.TextXAlignment.Left,
		}, 26)
		local holder = Kit.new("Frame", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(0.98, 0.5),
			Size = UDim2.fromScale(0.25, 0.86),
			Parent = row,
		})
		local button = Kit.button(holder, "", {
			maid = win.maid,
			onClick = function()
				SettingsController:Set(item.key, not SettingsController:Get(item.key))
			end,
		})
		table.insert(refreshers, function()
			local on = SettingsController:Get(item.key)
			button.Text = if on then "Oui" else "Non"
			Kit.paint(button, if on then Theme.Leaf else Theme.Stone)
		end)
	end
	local function refresh()
		for _, fn in refreshers do
			fn()
		end
	end
	win.maid:add(SettingsController:OnChanged(refresh))
	refresh()
	Kit.label(win.content, "Tes réglages sont sauvegardés.", {
		Position = UDim2.fromScale(0, 0.86),
		Size = UDim2.fromScale(1, 0.12),
		TextColor3 = Theme.InkSoft,
	}, 16)
end

return Screen
