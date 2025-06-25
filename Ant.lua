-- File gabungan Fluent UI + Expedition Antarctica Script
--!strict
-- Fluent UI + Expedition Antarctica Trainer Script
-- By: ChatGPT - Gabungan full UI stylish dan modern

-- >>> 1. Load Fluent UI Library
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/obiiyeuem1.lua"))()

-- >>> 2. Data dan State Player
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local speedValue = 16
local jumpValue = 50
local antiStormEnabled = false
local godConnections = {}

-- >>> 3. Fluent UI Init
local window = Fluent:CreateWindow({
    Title = "❄️ Zone Expedition Trainer",
    SubTitle = "with Fluent UI",
    TabWidth = 120,
    Size = UDim2.fromOffset(500, 400),
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local mainTab = window:AddTab({ Title = "Main", Icon = "snowflake" })

local section = mainTab:AddSection("Controls")

-- >>> 4. Speed & Jump Input
section:AddInput("Speed", function(value)
    local num = tonumber(value)
    if num then
        speedValue = num
        if humanoid then humanoid.WalkSpeed = speedValue end
    end
end).Input.Text = tostring(speedValue)

section:AddInput("Jump", function(value)
    local num = tonumber(value)
    if num then
        jumpValue = num
        if humanoid then humanoid.JumpPower = jumpValue end
    end
end).Input.Text = tostring(jumpValue)

-- >>> 5. Anti Storm Toggle
section:AddToggle("☁ Anti Badai", false, function(state)
    antiStormEnabled = state
end)

-- >>> 6. God Mode Toggle
local function enableGodMode()
    if not humanoid then return end
    humanoid.BreakJointsOnDeath = false
    table.insert(godConnections, humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end))
    table.insert(godConnections, humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Freefall or
           newState == Enum.HumanoidStateType.FallingDown or
           newState == Enum.HumanoidStateType.Physics or
           newState == Enum.HumanoidStateType.Ragdoll then
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            humanoid.PlatformStand = false
        elseif newState == Enum.HumanoidStateType.Dead then
            task.wait()
            humanoid.Health = humanoid.MaxHealth
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end))
    table.insert(godConnections, humanoid.Died:Connect(function()
        humanoid.Health = humanoid.MaxHealth
        humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end))
end

local function disableGodMode()
    for _, con in ipairs(godConnections) do
        con:Disconnect()
    end
    table.clear(godConnections)
end

section:AddToggle("🛡️ God Mode", false, function(state)
    if state then enableGodMode() else disableGodMode() end
end)

-- >>> 7. Reset Button
section:AddButton("🔄 Reset Speed & Jump", function()
    speedValue = 16
    jumpValue = 50
    if humanoid then
        humanoid.WalkSpeed = speedValue
        humanoid.JumpPower = jumpValue
    end
end)

-- >>> 8. FPS Display
local fps = 0
local frameCount = 0
local lastTime = tick()
local RunService = game:GetService("RunService")

local fpsLabel = Fluent.Elements.Paragraph:New("FPS: 0", section.Container)

RunService.RenderStepped:Connect(function()
    frameCount += 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frameCount
        frameCount = 0
        lastTime = now
        if fpsLabel then
            fpsLabel:SetTitle("FPS: " .. tostring(fps))
        end
    end
end)

-- >>> 9. Anti Storm Loop
coroutine.wrap(function()
    while true do
        task.wait(1)
        if antiStormEnabled then
            local Lighting = game:GetService("Lighting")
            local cam = workspace.CurrentCamera
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") then
                    v.Enabled = false
                end
            end
            for _, v in pairs(cam:GetChildren()) do
                if v:IsA("BlurEffect") then
                    v.Enabled = false
                end
            end
        end
    end
end)()

-- >>> 10. Reapply on Respawn
player.CharacterAdded:Connect(function(newChar)
    disableGodMode()
    char = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    task.wait(0.3)
    humanoid.WalkSpeed = speedValue
    humanoid.JumpPower = jumpValue
    enableGodMode()
end)