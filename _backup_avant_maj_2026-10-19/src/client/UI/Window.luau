--!strict
-- Fenêtre modale « page de carnet » : fond assombri, panneau parchemin, titre, bouton fermer (44 px),
-- et une zone de contenu. Chaque fenêtre a son Maid : tout est libéré à la fermeture.

local Kit = require(script.Parent.Kit)
local Theme = require(script.Parent.Theme)

local Window = {}

export type Window = {
	holder: Frame,
	content: Frame,
	maid: Kit.Maid,
	setTitle: (text: string) -> (),
	close: () -> (),
	closed: boolean,
}

export type Options = {
	aspect: number?, -- largeur / hauteur du panneau
	height: number?, -- part de la hauteur de l'écran
	onClose: (() -> ())?,
	zIndex: number?,
}

-- Ouvre une fenêtre dans `root` (le cadre racine mis à l'échelle de l'écran).
function Window.open(root: Instance, title: string, opts: Options?): Window
	local o: Options = opts or {}
	local maid = Kit.maid()
	local z = o.zIndex or 1

	local overlay = Kit.new("TextButton", {
		Name = "WindowOverlay",
		AutoButtonColor = false,
		Text = "",
		BackgroundColor3 = Theme.Black,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = z,
		Parent = root,
	})
	maid:add(overlay)
	Kit.tween(overlay, 0.2, { BackgroundTransparency = 0.45 })

	local holder, body = Kit.panel(overlay, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.97, o.height or 0.92),
	}, nil, 0.04)
	Kit.aspect(holder, o.aspect or 1.75, true)
	Kit.limit(holder, nil, Vector2.new(980, 560))
	local pop = Kit.new("UIScale", { Scale = 0.9, Parent = holder })
	Kit.tween(pop, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)

	local titleLabel = Kit.title(body, title, {
		Position = UDim2.fromScale(0.03, 0.02),
		Size = UDim2.fromScale(0.75, 0.12),
		TextXAlignment = Enum.TextXAlignment.Left,
	}, 34)

	-- Trait de séparation « encre ».
	Kit.new("Frame", {
		BackgroundColor3 = Theme.InkSoft,
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.03, 0.15),
		Size = UDim2.new(0.94, 0, 0, 2),
		Parent = body,
	})

	local content = Kit.new("Frame", {
		Name = "Content",
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.025, 0.18),
		Size = UDim2.fromScale(0.95, 0.79),
		Parent = body,
	})

	local win: Window = {
		holder = holder,
		content = content,
		maid = maid,
		closed = false,
		setTitle = function(text: string)
			titleLabel.Text = text
		end,
		close = function() end,
	}

	win.close = function()
		if win.closed then
			return
		end
		win.closed = true
		if o.onClose then
			o.onClose()
		end
		-- Sortie animée (0,18 s) puis libération de tout ce que l'écran a branché.
		Kit.tween(overlay, 0.18, { BackgroundTransparency = 1 })
		Kit.tween(pop, 0.18, { Scale = 0.9 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		task.delay(0.18, function()
			maid:clean()
		end)
	end

	local closeHolder = Kit.new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(0.985, 0.015),
		Size = UDim2.fromScale(0.13, 0.13),
		Parent = body,
	})
	Kit.aspect(closeHolder, 1, true)
	Kit.button(closeHolder, "X", { color = Theme.Lava, maid = maid, onClick = win.close, maxText = 30 })

	return win
end

export type DialogButton = { text: string, color: Color3?, onClick: (() -> ())? }

-- Petite boîte de confirmation par-dessus tout. Chaque bouton ferme la boîte puis appelle son action.
function Window.dialog(root: Instance, title: string, message: string, buttons: { DialogButton }): Window
	local win = Window.open(root, title, { aspect = 1.6, height = 0.62, zIndex = 20 })
	Kit.label(win.content, message, {
		Size = UDim2.fromScale(1, 0.62),
		TextColor3 = Theme.Ink,
		Font = Theme.BodyFont,
	}, 24)
	local row = Kit.new("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 0.7),
		Size = UDim2.fromScale(1, 0.28),
		Parent = win.content,
	})
	Kit.list(row, true, 0.04, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
	for i, b in buttons do
		local slot = Kit.new("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Size = UDim2.fromScale(math.min(0.45, 0.9 / #buttons), 1),
			Parent = row,
		})
		Kit.button(slot, b.text, {
			color = b.color,
			maid = win.maid,
			onClick = function()
				win.close()
				if b.onClick then
					b.onClick()
				end
			end,
		})
	end
	return win
end

return Window
