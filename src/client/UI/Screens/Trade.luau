--!strict
-- Échange : liste des joueurs du serveur avec « Proposer » (TradeRequest). Verrouillé si l'attribut
-- TradingAllowed est faux ou avant Economy.Social.tradeUnlockRolls lancers.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local Controllers = script.Parent.Parent.Parent.Controllers
local NotificationController = require(Controllers.NotificationController)
local TradeController = require(Controllers.TradeController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "🤝 Échange", aspect = 1.6 }

function Screen.build(win: Window.Window)
	local locked = TradeController:LockedReason()
	if locked then
		Kit.title(win.content, "🔒", { Size = UDim2.fromScale(1, 0.4) }, 60)
		Kit.label(win.content, locked, { Position = UDim2.fromScale(0, 0.45), Size = UDim2.fromScale(1, 0.3) }, 26)
		return
	end

	Kit.label(win.content, "Choisis un joueur du serveur pour lui proposer un échange.", {
		Size = UDim2.fromScale(1, 0.14),
		TextColor3 = Theme.InkSoft,
	}, 20)
	local list = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.16), Size = UDim2.fromScale(1, 0.84) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.02, 0), PaddingRight = UDim.new(0.02, 0), Parent = list })

	local rowMaid = Kit.maid()
	win.maid:add(rowMaid)
	local sent: { [number]: boolean } = {}

	local function render()
		rowMaid:clean()
		local others = {}
		for _, player in Players:GetPlayers() do
			if player ~= Players.LocalPlayer then
				table.insert(others, player)
			end
		end
		if #others == 0 then
			rowMaid:add(Kit.label(list, "Personne d'autre sur ce serveur pour l'instant.", {
				Size = UDim2.new(1, 0, 0, 60),
				TextColor3 = Theme.InkSoft,
			}, 20))
			return
		end
		for i, player in others do
			local row = Kit.row(
				list,
				{ { text = player.DisplayName, width = 0.7, font = Theme.TitleFont } },
				i,
				50,
				if i % 2 == 0 then Theme.ParchmentDark else nil
			)
			rowMaid:add(row)
			Kit.stagger(row, i)
			local holder = Kit.new("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.72, 0.04),
				Size = UDim2.fromScale(0.27, 0.92),
				Parent = row,
			})
			Kit.button(holder, if sent[player.UserId] then "Envoyé ✔" else "Proposer", {
				color = if sent[player.UserId] then Theme.Stone else Theme.Leaf,
				maid = rowMaid,
				maxText = 20,
				onClick = function()
					if sent[player.UserId] then
						return
					end
					sent[player.UserId] = true
					Remotes.TradeRequest:FireServer(player.UserId)
					NotificationController:Toast(`Proposition envoyée à {player.DisplayName}.`, "info")
					render()
				end,
			})
		end
	end
	win.maid:add(Players.PlayerAdded:Connect(render))
	win.maid:add(Players.PlayerRemoving:Connect(function()
		task.defer(render)
	end))
	render()
end

return Screen
