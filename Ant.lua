--// GUI LIBRARY (Minimalist UI)
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/linhook/linhub/main/ui/linxlib.lua"))()
local window = library:CreateWindow("Expedition Hub")
local tab = window:CreateTab("Main")

--// Character
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

--// Layout Manager
local posY = 10
local function nextY(step)
    local curr = posY
    posY = posY + step
    return curr
end

--// Create Input Fields
local function createInput(label, yPos, defaultText)
    local input = Instance.new("TextBox")
    input.Parent = tab
    input.PlaceholderText = label
    input.Text = defaultText
    input.Position = UDim2.new(0, 10, 0, yPos)
    input.Size = UDim2.new(0, 200, 0, 30)
    input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    input.TextColor3 = Color3.fromRGB(0, 0, 0)
    input.ClearTextOnFocus = false
    return input
end

--// Create Toggle Button
local function createToggleButton(name, yPos, textOn, textOff, callback)
    local button = Instance.new("TextButton")
    button.Parent = tab
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.Size = UDim2.new(0, 200, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = textOff
    local toggled = false

    button.MouseButton1Click:Connect(function()
        toggled = not toggled
        button.Text = toggled and textOn or textOff
        callback(toggled)
    end)
    return button
end

--// Speed & Jump Input
local speedBox = createInput("Speed:", nextY(40), "16")
local jumpBox = createInput("Jump:", nextY(40), "50")

--// Speed & Jump Apply Loop
spawn(function()
    while wait(0.5) do
        if tonumber(speedBox.Text) then humanoid.WalkSpeed = tonumber(speedBox.Text) end
        if tonumber(jumpBox.Text) then humanoid.JumpPower = tonumber(jumpBox.Text) end
    end
end)

--// Anti Storm
createToggleButton("AntiStorm", nextY(40), "☁ Anti Badai: ON", "☁ Anti Badai: OFF", function(state)
    local storm = workspace:FindFirstChild("Storm")
    if storm then storm:Destroy() end
end)

--// God Mode
createToggleButton("GodMode", nextY(40), "🛡️ God Mode: ON", "🛡️ God Mode: OFF", function(state)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, not state)
end)

--// Fly Feature
createToggleButton("Fly", nextY(40), "🛫 Fly: ON", "🛫 Fly: OFF", function(state)
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local cam = workspace.CurrentCamera
    local flying = state
    local speed = 50
    local bodyGyro, bodyVel

    if flying then
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = char.HumanoidRootPart.CFrame
        bodyGyro.Parent = char.HumanoidRootPart

        bodyVel = Instance.new("BodyVelocity")
        bodyVel.velocity = Vector3.new(0, 0.1, 0)
        bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVel.Parent = char.HumanoidRootPart

        local flyingConn
        flyingConn = RunService.RenderStepped:Connect(function()
            if not flying then flyingConn:Disconnect() return end
            local moveVec = Vector3.new()
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec += cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then moveVec += cam.CFrame.UpVector end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveVec -= cam.CFrame.UpVector end

            bodyVel.velocity = moveVec.Unit * speed
            bodyGyro.cframe = cam.CFrame
        end)
    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVel then bodyVel:Destroy() end
    end
end)

--// Reset Button
local resetBtn = Instance.new("TextButton")
resetBtn.Parent = tab
resetBtn.Position = UDim2.new(0, 10, 0, nextY(40))
resetBtn.Size = UDim2.new(0, 200, 0, 30)
resetBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.Text = "🔄 Reset Speed/Jump"
resetBtn.MouseButton1Click:Connect(function()
    speedBox.Text = "16"
    jumpBox.Text = "50"
end)