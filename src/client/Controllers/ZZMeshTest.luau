--!strict
-- TEST TEMPORAIRE (à supprimer) : vrai chronoraptor en jeu.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local DinoModels = require(script.Parent.Parent.DinoModels)

local MODE = "perf"

local Test = {}
function Test:Start()
	local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart") :: BasePart
	task.wait(4)
	print(`[meshtest] mode {MODE} has={DinoModels.has("chronoraptor")}`)
	if MODE == "world" then
		local t0 = os.clock()
		local model = DinoModels.create("chronoraptor")
		print(`[meshtest] create {math.round((os.clock() - t0) * 1000)} ms`)
		if not model then
			return
		end
		local feet = hrp.Position + hrp.CFrame.LookVector * 10 - Vector3.new(0, 3, 0)
		model:PivotTo(CFrame.lookAt(feet, Vector3.new(hrp.Position.X, feet.Y, hrp.Position.Z)))
		model.Parent = Workspace
		DinoModels.play(model, "Idle")
		print(`[meshtest] feet {feet} look {model:GetPivot().LookVector} size {(model.PrimaryPart :: BasePart).Size}`)
		for _ = 1, 10 do
			task.wait(4)
			DinoModels.play(model, "Roar", { thenClip = "Idle" })
		end
	elseif MODE == "arena" then
		require(script.Parent.Parent.UI.RollReveal).play({
			uuid = "t",
			dinoId = "chronoraptor",
			size = "normal",
			skin = "normal",
			clover = 1,
			oneInDisplayed = 400000,
			isNewInIndex = true,
		})
	elseif MODE == "plot" then
		local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
		Remotes.DevGrantDino:FireServer("chronoraptor", 3)
		task.wait(1)
		Remotes.EquipBest:FireServer()
		task.wait(2)
		for _, m in (Workspace:FindFirstChild("ClientDinos") :: Folder):GetChildren() do
			print(`[meshtest] socle dino {(m :: Model):GetPivot().Position} look {(m :: Model):GetPivot().LookVector}`)
		end
		task.wait(8)
		require(script.Parent.UIController):Open("Encyclopedia")
		print(`[meshtest] Index ouvert : {require(script.Parent.UIController):Current()}`)
	elseif MODE == "perf" then
		local models = {}
		for i = 1, 30 do
			local model = DinoModels.create("chronoraptor", "normal", if i % 3 == 0 then "jade" else "normal")
			if model then
				model:PivotTo(hrp.CFrame * CFrame.new((i % 6 - 2.5) * 6, -3, -12 - (i // 6) * 6))
				model.Parent = Workspace
				DinoModels.play(model, if i % 2 == 0 then "Idle" else "Run")
				table.insert(models, model)
			end
		end
		print(`[meshtest] {#models} chronoraptors`)
		task.wait(1)
		local frames, worst, total = 0, 0, 0
		local conn = RunService.Heartbeat:Connect(function(dt)
			frames += 1
			total += dt
			worst = math.max(worst, dt)
		end)
		task.wait(5)
		conn:Disconnect()
		print(`[meshtest] perf 30 : {math.round(frames / total)} FPS moyens, pire frame {math.round(worst * 1000)} ms`)
		-- Coût Lua pur de la mise à jour des os : 30 dinos × 30 os.
		local t = os.clock()
		for _ = 1, 30 do
			for _, m in models do
				for _, b in m:GetDescendants() do
					if b:IsA("Bone") then
						b.CFrame = b.CFrame
					end
				end
			end
		end
		print(`[meshtest] écriture os (30 dinos) : {math.round((os.clock() - t) / 30 * 1000 * 100) / 100} ms par tick`)
	end
end
return Test
