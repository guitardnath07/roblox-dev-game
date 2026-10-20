--!strict
-- Popup « Pendant ton absence, tes dinos ont gagné X Fossiles ». Affichage seul : le serveur a déjà crédité.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Odds = require(ReplicatedStorage.Shared.Odds)
local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local function formatDuration(seconds: number): string
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor(seconds % 3600 / 60)
	return if hours > 0 then `{hours} h {minutes} min` else `{minutes} min`
end

local function show(coins: number, seconds: number)
	local gui = Instance.new("ScreenGui")
	gui.Name = "OfflineEarnings"
	gui.ResetOnSpawn = false
	gui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets

	local panel = Instance.new("Frame")
	panel.AnchorPoint = Vector2.new(0.5, 0.5)
	panel.Position = UDim2.fromScale(0.5, 0.45)
	panel.Size = UDim2.fromScale(0.4, 0.3)
	panel.BackgroundColor3 = Color3.fromHex("#F3E5C0")
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 2
	ratio.Parent = panel
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.08, 0)
	corner.Parent = panel
	panel.Parent = gui

	local text = Instance.new("TextLabel")
	text.BackgroundTransparency = 1
	text.Position = UDim2.fromScale(0.06, 0.08)
	text.Size = UDim2.fromScale(0.88, 0.55)
	text.Font = Enum.Font.FredokaOne
	text.TextScaled = true
	text.TextColor3 = Color3.fromHex("#4A3B28")
	text.Text =
		`Pendant ton absence ({formatDuration(seconds)}), tes dinos ont gagné {Odds.formatBig(coins)} Fossiles !`
	text.Parent = panel

	local ok = Instance.new("TextButton")
	ok.AnchorPoint = Vector2.new(0.5, 1)
	ok.Position = UDim2.fromScale(0.5, 0.92)
	ok.Size = UDim2.fromScale(0.4, 0.25)
	ok.BackgroundColor3 = Color3.fromHex("#F4A93B")
	ok.Font = Enum.Font.FredokaOne
	ok.Text = "Super !"
	ok.TextScaled = true
	ok.TextColor3 = Color3.new(1, 1, 1)
	local minSize = Instance.new("UISizeConstraint")
	minSize.MinSize = Vector2.new(88, 44)
	minSize.Parent = ok
	local okCorner = Instance.new("UICorner")
	okCorner.CornerRadius = UDim.new(0.25, 0)
	okCorner.Parent = ok
	ok.Parent = panel
	ok.Activated:Once(function()
		gui:Destroy()
	end)

	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local OfflineEarningsController = {}

function OfflineEarningsController:Init()
	Remotes.OfflineEarnings.OnClientEvent:Connect(show)
end

return OfflineEarningsController
