-- Expedition Antarctica Stylish UI Script (Full Fixed)
-- By Dyntzy (Modded by ChatGPT)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")

-- GUI Container
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "ExpeditionUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.Size = UDim2.new(0, 220, 0, 400)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- FPS Display
local fpsLabel = Instance.new("TextLabel", mainFrame)
fpsLabel.Size = UDim2.new(1, 0, 0, 30)
fpsLabel.Position = UDim2.new(0, 0, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 16
fpsLabel.Text = "FPS: 0"

-- FPS Counter
task.spawn(function()
	local fps = 0
	local last = tick()
	RunService.RenderStepped:Connect(function()
		fps += 1
		if tick() - last >= 1 then
			fpsLabel.Text = "FPS: " .. fps
			fps = 0
			last = tick()
		end
	end)
end)

-- Function to create labels and inputs
local function createInput(labelText, posY, defaultValue)
	local label = Instance.new("TextLabel", mainFrame)
	label.Size = UDim2.new(0, 100, 0, 30)
	label.Position = UDim2.new(0, 10, 0, posY)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = labelText
	label.Font = Enum.Font.Code
	label.TextSize = 14

	local box = Instance.new("TextBox", mainFrame)
	box.Size = UDim2.new(0, 80, 0, 30)
	box.Position = UDim2.new(0, 120, 0, posY)
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.Text = tostring(defaultValue)
	box.Font = Enum.Font.Code
	box.TextSize = 14

	return box
end

-- Function to create toggle buttons
local function createToggleButton(name, posY, onText, offText, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Code
	btn.TextSize = 14
	btn.Text = offText

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and onText or offText
		callback(state)
	end)

	return btn
end

-- State Variables
local antiStormEnabled = false
local flyEnabled = false
local godConnection
local flyHeight = 50

-- Posisi awal Y untuk elemen GUI
local nextY = 40
local spacing = 40

-- Input Boxes
local speedBox = createInput("Speed:", nextY, "16")
nextY += spacing
local jumpBox = createInput("Jump:", nextY, "50")
nextY += spacing
local flyBox = createInput("Fly Y:", nextY, "50")
nextY += spacing

-- Anti Badai
createToggleButton("AntiStorm", nextY, "☁ Anti Badai: ON", "☁ Anti Badai: OFF", function(state)
	antiStormEnabled = state
end)
nextY += spacing

-- God Mode
createToggleButton("GodMode", nextY, "🛡️ God Mode: ON", "🛡️ God Mode: OFF", function(state)
	if state then
		godConnection = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if humanoid.Health < humanoid.MaxHealth then
				humanoid.Health = humanoid.MaxHealth
			end
		end)
	else
		if godConnection then godConnection:Disconnect() end
	end
end)
nextY += spacing

-- Fly Aman (Bypass Kick)
local function createSafeFly(char, flyY)
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local alignPos = Instance.new("AlignPosition", root)
	local alignOri = Instance.new("AlignOrientation", root)
	local att0 = Instance.new("Attachment", root)
	local att1 = Instance.new("Attachment", workspace.Terrain)

	alignPos.Attachment0 = att0
	alignPos.Attachment1 = att1
	alignPos.RigidityEnabled = false
	alignPos.MaxForce = 999999
	alignPos.Responsiveness = 200

	alignOri.Attachment0 = att0
	alignOri.Attachment1 = att1
	alignOri.RigidityEnabled = false
	alignOri.MaxTorque = 999999
	alignOri.Responsiveness = 200

	local renderConn
	renderConn = RunService.RenderStepped:Connect(function()
		if not flyEnabled then
			renderConn:Disconnect()
			alignPos:Destroy()
			alignOri:Destroy()
			att0:Destroy()
			att1:Destroy()
			return
		end
		att1.WorldPosition = root.Position + Vector3.new(0, flyY, 0)
		att1.WorldOrientation = Vector3.new(0, 0, 0)
	end)
end

-- Fly Toggle
createToggleButton("FlyToggle", nextY, "✈️ Fly: ON", "✈️ Fly: OFF", function(state)
	flyEnabled = state
	if state then
		local val = tonumber(flyBox.Text)
		flyHeight = val or 50
		createSafeFly(char, flyHeight)
	end
end)
nextY += spacing

-- Reset Button
local resetBtn = Instance.new("TextButton", mainFrame)
resetBtn.Size = UDim2.new(1, -20, 0, 30)
resetBtn.Position = UDim2.new(0, 10, 0, nextY)
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetBtn.TextColor3 = Color3.new(1, 1, 1)
resetBtn.Font = Enum.Font.Code
resetBtn.TextSize = 14
resetBtn.Text = "🔄 Reset Karakter"
resetBtn.MouseButton1Click:Connect(function()
	player:LoadCharacter()
end)

-- Apply Settings Loop
RunService.RenderStepped:Connect(function()
	local speed = tonumber(speedBox.Text) or 16
	local jump = tonumber(jumpBox.Text) or 50
	humanoid.WalkSpeed = speed
	humanoid.JumpPower = jump

	if antiStormEnabled then
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") then
				v.Enabled = false
			end
		end
	end
end)

-- Toggle GUI dengan RightCtrl
local guiVisible = true
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightControl then
		guiVisible = not guiVisible
		mainFrame.Visible = guiVisible
	end
end)