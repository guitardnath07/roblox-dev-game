--!strict
-- Chef d'orchestre de l'interface : crée les calques (ScreenGui) avec UNE échelle globale pilotée par la taille
-- d'écran, construit le HUD, et ouvre une fenêtre à la fois (UIController:Open("Backpack", ...)).
--
-- Échelle : chaque calque a un cadre racine de taille 1/s avec un UIScale s. Les tailles en Scale restent donc
-- relatives à l'écran, et seuls les offsets (bordures, marges, tailles mini 44 px) grandissent avec l'écran.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local UI = script.Parent.Parent.UI
local Theme = require(UI.Theme)
local Window = require(UI.Window)

type Layer = { gui: ScreenGui, root: Frame, uiScale: UIScale }

local layers: { Layer } = {}
local current: Window.Window? = nil
local currentName: string? = nil

local UIController = {}

local function scaleFor(size: Vector2): number
	local ref = Theme.ReferenceSize
	return math.clamp(math.min(size.X / ref.X, size.Y / ref.Y), Theme.MinScale, Theme.MaxScale)
end

local function applyScale(layer: Layer)
	local s = scaleFor(layer.gui.AbsoluteSize)
	layer.uiScale.Scale = s
	layer.root.Size = UDim2.fromScale(1 / s, 1 / s)
end

-- Échelle actuelle (pour convertir des tailles absolues en tailles logiques).
function UIController:GetScale(): number
	local first = layers[1]
	return if first then first.uiScale.Scale else 1
end

-- Crée un calque plein écran. `fullscreen` = ignore les marges (fond noir des révélations).
function UIController:CreateLayer(name: string, displayOrder: number, fullscreen: boolean?): Frame
	local gui = Instance.new("ScreenGui")
	gui.Name = name
	gui.ResetOnSpawn = false
	gui.DisplayOrder = displayOrder
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	if fullscreen then
		gui.ClipToDeviceSafeArea = false
	end

	local root = Instance.new("Frame")
	root.Name = "Root"
	root.BackgroundTransparency = 1
	root.Size = UDim2.fromScale(1, 1)
	root.Parent = gui
	local uiScale = Instance.new("UIScale")
	uiScale.Parent = root

	local layer: Layer = { gui = gui, root = root, uiScale = uiScale }
	table.insert(layers, layer)
	gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		applyScale(layer)
	end)
	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	applyScale(layer)
	return root
end

local windowRoot: Frame? = nil

local function getWindowRoot(): Frame
	if not windowRoot then
		windowRoot = UIController:CreateLayer("DinoWindows", 5)
	end
	return windowRoot :: Frame
end

-- Ouvre l'écran `UI/Screens/<name>` (ferme celui déjà ouvert). Les arguments suivants sont passés à build.
function UIController:Open(name: string, ...: any)
	self:CloseWindow()
	local module = UI.Screens:FindFirstChild(name)
	if not module then
		warn(`Écran introuvable : {name}`)
		return
	end
	local screen = (require :: any)(module)
	local win = Window.open(getWindowRoot(), screen.title, {
		style = screen.style,
		accent = screen.accent,
		aspect = screen.aspect,
		onClose = function()
			if currentName == name then
				current = nil
				currentName = nil
			end
		end,
	})
	current = win
	currentName = name
	local ok, err = pcall(screen.build, win, ...)
	if not ok then
		warn(`Écran {name} : {err}`)
	end
end

-- Nom de l'écran ouvert (nil si aucun).
function UIController:Current(): string?
	return currentName
end

function UIController:CloseWindow()
	local win = current
	current = nil
	currentName = nil
	if win then
		win.close()
	end
end

-- Boîte de confirmation au-dessus de la fenêtre courante.
function UIController:Dialog(title: string, message: string, buttons: { Window.DialogButton })
	return Window.dialog(getWindowRoot(), title, message, buttons)
end

function UIController:Start()
	local DataController = require(script.Parent.DataController)
	DataController:Get()
	local Hud = require(UI.Hud)
	Hud.create(self:CreateLayer("DinoHud", 1))

	-- Studio uniquement : l'attribut « DebugOpen » (« Écran|arg1|arg2 ») ouvre un écran, pour les tests outillés.
	if RunService:IsStudio() then
		local player = Players.LocalPlayer
		player:GetAttributeChangedSignal("DebugOpen"):Connect(function()
			local value = player:GetAttribute("DebugOpen")
			if type(value) == "string" and value ~= "" then
				local parts = value:split("|")
				self:Open(table.unpack(parts))
			elseif value == "" then
				self:CloseWindow()
			end
		end)
	end
end

return UIController
