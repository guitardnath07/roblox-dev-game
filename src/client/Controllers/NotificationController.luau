--!strict
-- Petites notifications (bas à droite) et bannière d'annonce des tirages très rares (haut de l'écran).
-- Affichage seul : les textes viennent du serveur.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Rarities = require(ReplicatedStorage.Shared.Config.Rarities)
local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local TOAST_SECONDS = 3
local BANNER_SECONDS = 6

local gui: ScreenGui
local toastList: Frame

local function label(parent: Instance, text: string, color: Color3): TextLabel
	local l = Instance.new("TextLabel")
	l.BackgroundColor3 = Color3.fromHex("#2B2118")
	l.BackgroundTransparency = 0.15
	l.TextColor3 = color
	l.Font = Enum.Font.GothamBold
	l.TextScaled = true
	l.Text = text
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.3, 0)
	corner.Parent = l
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0.04, 0)
	padding.PaddingRight = UDim.new(0.04, 0)
	padding.Parent = l
	l.Parent = parent
	return l
end

local function toast(text: string, kind: string?)
	local color = if kind == "error" then Color3.fromHex("#FF8A80") else Color3.new(1, 1, 1)
	-- Au plus 5 notifications à la fois : la plus ancienne part (Auto-Lancer + Masquer en envoie beaucoup).
	local shown = {}
	for _, child in toastList:GetChildren() do
		if child:IsA("TextLabel") then
			table.insert(shown, child)
		end
	end
	if #shown >= 5 then
		shown[1]:Destroy()
	end
	local l = label(toastList, text, color)
	l.LayoutOrder = os.clock() * 1000 // 1
	l.Size = UDim2.fromScale(1, 0.18)
	task.delay(TOAST_SECONDS, function()
		l:Destroy()
	end)
end

local function banner(text: string, rarityId: string)
	local rarity = (Rarities :: any)[rarityId]
	local l = label(gui, text, if rarity then rarity.color else Color3.new(1, 1, 1))
	l.AnchorPoint = Vector2.new(0.5, 0)
	l.Position = UDim2.fromScale(0.5, -0.15)
	l.Size = UDim2.fromScale(0.6, 0.08)
	TweenService:Create(l, TweenInfo.new(0.4, Enum.EasingStyle.Back), { Position = UDim2.fromScale(0.5, 0.02) }):Play()
	task.delay(BANNER_SECONDS, function()
		l:Destroy()
	end)
end

local NotificationController = {}

function NotificationController:Init()
	gui = Instance.new("ScreenGui")
	gui.Name = "Notifications"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 10
	gui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets

	toastList = Instance.new("Frame")
	toastList.BackgroundTransparency = 1
	-- En haut à droite, sous le bouton Réglages : ne recouvre ni la grappe LANCER ni le rail de gauche.
	toastList.AnchorPoint = Vector2.new(1, 0)
	toastList.Position = UDim2.fromScale(0.99, 0.2)
	toastList.Size = UDim2.fromScale(0.3, 0.3)
	local layout = Instance.new("UIListLayout")
	layout.VerticalAlignment = Enum.VerticalAlignment.Top
	layout.Padding = UDim.new(0.02, 0)
	layout.Parent = toastList
	toastList.Parent = gui

	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	Remotes.Notify.OnClientEvent:Connect(toast)
	Remotes.Announcement.OnClientEvent:Connect(banner)
end

-- Pour les autres contrôleurs (ex. « Masquer » : petite notification au lieu de la carte).
function NotificationController:Toast(text: string, kind: string?)
	toast(text, kind)
end

return NotificationController
