--!strict
-- Échanges : popup d'invitation (TradeInvite → TradeRespond), suivi de l'état envoyé par le serveur
-- (TradeState) et ouverture / fermeture de la fenêtre d'échange. Le serveur valide tout.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Economy = require(ReplicatedStorage.Shared.Config.Economy)
local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local Types = require(ReplicatedStorage.Shared.Types)

local DataController = require(script.Parent.DataController)
local NotificationController = require(script.Parent.NotificationController)
local UIController = require(script.Parent.UIController)

local Theme = require(script.Parent.Parent.UI.Theme)

local state: Types.TradeState? = nil
local listeners: { (Types.TradeState?) -> () } = {}
local inviteWindow: { close: () -> () }? = nil -- invitation affichée (fermée dès qu'un échange démarre ou après 20 s)

local TradeController = {}

function TradeController:Get(): Types.TradeState?
	return state
end

function TradeController:OnState(fn: (Types.TradeState?) -> ()): () -> ()
	table.insert(listeners, fn)
	return function()
		local i = table.find(listeners, fn)
		if i then
			table.remove(listeners, i)
		end
	end
end

-- Raison pour laquelle le joueur local ne peut pas échanger (nil = il peut).
function TradeController:LockedReason(): string?
	if Players.LocalPlayer:GetAttribute("TradingAllowed") == false then
		return "L'échange n'est pas disponible dans ton pays."
	end
	local data: Types.ProfileData = DataController:Get()
	local need = Economy.Social.tradeUnlockRolls
	if data.TotalRolls < need then
		return `Débloqué après {need} lancers ({data.TotalRolls} / {need}).`
	end
	return nil
end

function TradeController:Start()
	DataController:Get()

	Remotes.TradeInvite.OnClientEvent:Connect(function(fromUserId: number, fromName: string)
		if inviteWindow then
			inviteWindow.close()
		end
		local dialog = UIController:Dialog("Proposition d'échange", `{fromName} veut échanger avec toi.`, {
			{
				text = "Refuser",
				color = Theme.Stone,
				onClick = function()
					Remotes.TradeRespond:FireServer(fromUserId, false)
				end,
			},
			{
				text = "Accepter",
				color = Theme.Leaf,
				onClick = function()
					Remotes.TradeRespond:FireServer(fromUserId, true)
				end,
			},
		})
		inviteWindow = dialog
		task.delay(20, function()
			if inviteWindow == dialog then
				dialog.close()
				inviteWindow = nil
			end
		end)
	end)

	Remotes.TradeState.OnClientEvent:Connect(function(newState: Types.TradeState?, reason: string?)
		state = newState
		if inviteWindow then
			inviteWindow.close()
			inviteWindow = nil
		end
		if newState and UIController:Current() ~= "TradeWindow" then
			UIController:Open("TradeWindow")
		end
		for _, fn in listeners do
			task.spawn(fn, newState)
		end
		if not newState then
			if UIController:Current() == "TradeWindow" then
				UIController:CloseWindow()
			end
			if reason then
				NotificationController:Toast(reason, "info")
			end
		end
	end)
end

return TradeController
