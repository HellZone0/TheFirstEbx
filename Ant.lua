-- Expedition Antarctica Script (UI Lama, Sudah Dirapikan)
-- Versi by Zyntzy & ChatGPT

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- GUI Lama
local scrgui = Instance.new("ScreenGui", game.CoreGui)
scrgui.Name = "Zone"

local frame = Instance.new("Frame", scrgui)
frame.Position = UDim2.new(0, 30, 0, 30)
frame.Size = UDim2.new(0, 220, 0, 270)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "Expedition Script"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- Input Speed
local speedLbl = Instance.new("TextLabel", frame)
speedLbl.Text = "Speed:"
speedLbl.Position = UDim2.new(0, 10, 0, 40)
speedLbl.Size = UDim2.new(0, 50, 0, 20)
speedLbl.BackgroundTransparency = 1
speedLbl.TextColor3 = Color3.new(1,1,1)

local speedBox = Instance.new("TextBox", frame)
speedBox.Position = UDim2.new(0, 70, 0, 40)
speedBox.Size = UDim2.new(0, 130, 0, 20)
speedBox.Text = "16"
speedBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
speedBox.TextColor3 = Color3.new(1,1,1)

-- Input Jump
local jumpLbl = speedLbl:Clone()
jumpLbl.Text = "Jump:"
jumpLbl.Position = UDim2.new(0, 10, 0, 70)
jumpLbl.Parent = frame

local jumpBox = speedBox:Clone()
jumpBox.Position = UDim2.new(0, 70, 0, 70)
jumpBox.Text = "50"
jumpBox.Parent = frame

-- Fly Input
local flyLbl = speedLbl:Clone()
flyLbl.Text = "Fly Y:"
flyLbl.Position = UDim2.new(0, 10, 0, 100)
flyLbl.Parent = frame

local flyBox = speedBox:Clone()
flyBox.Position = UDim2.new(0, 70, 0, 100)
flyBox.Text = "50"
flyBox.Parent = frame

-- Buttons
local function createButton(text, posY)
	local btn = Instance.new("TextButton", frame)
	btn.Text = text
	btn.Position = UDim2.new(0, 10, 0, posY)
	btn.Size = UDim2.new(0, 200, 0, 25)
	btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 16
	return btn
end

-- Toggle Variables
local godToggle, stormToggle, flyToggle = false, false, false
local godConn

-- God Mode Button
local godBtn = createButton("God Mode: OFF", 130)
godBtn.MouseButton1Click:Connect(function()
	godToggle = not godToggle
	godBtn.Text = godToggle and "God Mode: ON" or "God Mode: OFF"
	if godToggle then
		godConn = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if humanoid.Health < humanoid.MaxHealth then
				humanoid.Health = humanoid.MaxHealth
			end
		end)
	else
		if godConn then godConn:Disconnect() end
	end
end)

-- Anti Storm Button
local stormBtn = createButton("Anti Badai: OFF", 160)
stormBtn.MouseButton1Click:Connect(function()
	stormToggle = not stormToggle
	stormBtn.Text = stormToggle and "Anti Badai: ON" or "Anti Badai: OFF"
end)

-- Fly Aman (Bypass Kick)
local function createFlyY(offset)
	local att0 = Instance.new("Attachment", rootPart)
	local att1 = Instance.new("Attachment", workspace.Terrain)
	local alignPos = Instance.new("AlignPosition", rootPart)
	local alignOri = Instance.new("AlignOrientation", rootPart)

	alignPos.Attachment0 = att0
	alignPos.Attachment1 = att1
	alignPos.Responsiveness = 200
	alignPos.MaxForce = 999999
	alignPos.RigidityEnabled = false

	alignOri.Attachment0 = att0
	alignOri.Attachment1 = att1
	alignOri.Responsiveness = 200
	alignOri.MaxTorque = 999999
	alignOri.RigidityEnabled = false

	local flyConn
	flyConn = runService.RenderStepped:Connect(function()
		if not flyToggle then
			flyConn:Disconnect()
			att0:Destroy()
			att1:Destroy()
			alignPos:Destroy()
			alignOri:Destroy()
			return
		end
		att1.WorldPosition = rootPart.Position + Vector3.new(0, offset, 0)
	end)
end

-- Fly Button
local flyBtn = createButton("Fly: OFF", 190)
flyBtn.MouseButton1Click:Connect(function()
	flyToggle = not flyToggle
	flyBtn.Text = flyToggle and "Fly: ON" or "Fly: OFF"
	if flyToggle then
		local val = tonumber(flyBox.Text) or 50
		createFlyY(val)
	end
end)

-- Reset Char Button
local resetBtn = createButton("Reset Karakter", 220)
resetBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
resetBtn.MouseButton1Click:Connect(function()
	player:LoadCharacter()
end)

-- Loop Apply Speed/Jump
runService.RenderStepped:Connect(function()
	local speed = tonumber(speedBox.Text) or 16
	local jump = tonumber(jumpBox.Text) or 50
	humanoid.WalkSpeed = speed
	humanoid.JumpPower = jump

	if stormToggle then
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") then
				v.Enabled = false
			end
		end
	end
end)

-- Hide GUI dengan RightControl
local visible = true
uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightControl then
		visible = not visible
		frame.Visible = visible
	end
end)