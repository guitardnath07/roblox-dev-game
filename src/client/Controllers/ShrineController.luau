--!strict
-- Sanctuaire du Renouveau côté client : le totem (prompt « OpensRebirth ») ouvre l'écran Rebirth,
-- la pierre de retour (prompt « ReturnToPlot ») demande au serveur de ramener le joueur à sa parcelle,
-- un prompt « OpensScreen = <nom> » ouvre cet écran (ex. le Comptoir de vente -> Sell), et après un rebirth le serveur demande la cinématique du Phénix (UI/RebirthCinematic).

local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local UIController = require(script.Parent.UIController)

local RebirthCinematic = require(script.Parent.Parent.UI.RebirthCinematic)

local ShrineController = {}

function ShrineController:Start()
	ProximityPromptService.PromptTriggered:Connect(function(prompt: ProximityPrompt)
		if prompt:GetAttribute("OpensRebirth") then
			UIController:Open("Rebirth")
		elseif prompt:GetAttribute("ReturnToPlot") then
			Remotes.ShrineTeleport:FireServer("Plot")
		elseif type(prompt:GetAttribute("OpensScreen")) == "string" then
			UIController:Open(prompt:GetAttribute("OpensScreen") :: string)
		end
	end)
	Remotes.RebirthCinematic.OnClientEvent:Connect(function(rebirths: number)
		RebirthCinematic.play(rebirths, function()
			UIController:CloseWindow()
		end)
	end)
end

return ShrineController
