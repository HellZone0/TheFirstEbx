-- Expedition Antarctica Modern UI (Enhanced UX Edition)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local speedValue = 16
local jumpValue = 50
local antiStormEnabled = false
local godModeEnabled = false
local godConnections = {}

-- Theme Definitions
local themes = {
    Dark = {
        Background = Color3.fromRGB(20, 20, 25),
        Text = Color3.fromRGB(240, 240, 240),
        Accent = Color3.fromRGB(100, 160, 255),
        Button = Color3.fromRGB(30, 30, 40),
        ToggleOn = Color3.fromRGB(80, 200, 140),
        ToggleOff = Color3.fromRGB(60, 60, 60)
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 240),
        Text = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(70, 120, 220),
        Button = Color3.fromRGB(220, 220, 220),
        ToggleOn = Color3.fromRGB(60, 180, 120),
        ToggleOff = Color3.fromRGB(180, 180, 180)
    }
}
local currentTheme = themes.Dark

-- Helper
local function createUI(class, parent, props)
    local inst = Instance.new(class)
    for k, v in pairs(props) do inst[k] = v end
    inst.Parent = parent
    return inst
end

local gui = createUI("ScreenGui", game.CoreGui, { Name = "EA_UI", ResetOnSpawn = false })

local main = createUI("Frame", gui, {
    Size = UDim2.fromOffset(330, 300),
    Position = UDim2.new(0.05, 0, 0.3, 0),
    BackgroundColor3 = currentTheme.Background,
    BorderSizePixel = 0,
    Active = true,
    Draggable = true
})
createUI("UICorner", main, { CornerRadius = UDim.new(0, 12) })
createUI("UIStroke", main, { Thickness = 1, Color = currentTheme.Accent })

local title = createUI("TextLabel", main, {
    Position = UDim2.new(0, 15, 0, 0),
    Size = UDim2.new(1, -60, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamSemibold,
    TextSize = 17,
    Text = "❄️ Zone Expedition Trainer",
    TextColor3 = currentTheme.Text,
    TextXAlignment = Enum.TextXAlignment.Left
})

local closeBtn = createUI("TextButton", main, {
    Position = UDim2.new(1, -35, 0, 5), Size = UDim2.new(0, 24, 0, 24),
    Text = "✕", BackgroundColor3 = currentTheme.Button, TextColor3 = currentTheme.Text,
    Font = Enum.Font.GothamBold, TextSize = 14
})
createUI("UICorner", closeBtn, { CornerRadius = UDim.new(1, 0) })

local content = createUI("Frame", main, {
    Position = UDim2.new(0, 0, 0, 35), Size = UDim2.new(1, 0, 1, -45),
    BackgroundTransparency = 1
})
createUI("UIListLayout", content, {
    SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10)
})
createUI("UIPadding", content, {
    PaddingTop = UDim.new(0, 5), PaddingLeft = UDim.new(0, 15), PaddingRight = UDim.new(0, 15)
})

-- FPS Display
local fpsLabel = createUI("TextLabel", main, {
    Position = UDim2.new(0, 15, 0, 5), Size = UDim2.new(0, 100, 0, 18),
    BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 13,
    Text = "FPS: 0", TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = currentTheme.Accent
})

-- Input Builder
local function createInputRow(labelText, defaultText, callback)
    local container = createUI("Frame", content, { Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1 })
    local label = createUI("TextLabel", container, {
        Size = UDim2.new(0.3, 0, 1, 0), BackgroundTransparency = 1,
        Text = labelText, TextColor3 = currentTheme.Text,
        Font = Enum.Font.Gotham, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left
    })
    local box = createUI("TextBox", container, {
        Position = UDim2.new(0.35, 0, 0, 0), Size = UDim2.new(0.65, 0, 1, 0),
        BackgroundColor3 = currentTheme.Button, BorderSizePixel = 0,
        Font = Enum.Font.Gotham, TextSize = 14, Text = defaultText,
        TextColor3 = currentTheme.Text, ClearTextOnFocus = true
    })
    createUI("UICorner", box, { CornerRadius = UDim.new(0, 5) })
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then
            callback(val)
        end
        box.Text = tostring(val or defaultText)
    end)
end

createInputRow("Speed", tostring(speedValue), function(val)
    speedValue = val
    if humanoid then humanoid.WalkSpeed = val end
end)

createInputRow("Jump", tostring(jumpValue), function(val)
    jumpValue = val
    if humanoid then humanoid.JumpPower = val end
end)

-- Toggle Builder
local function createToggle(label, state, callback)
    local row = createUI("Frame", content, { Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1 })
    local txt = createUI("TextLabel", row, {
        Size = UDim2.new(0.7, 0, 1, 0), BackgroundTransparency = 1,
        Text = label, TextColor3 = currentTheme.Text,
        Font = Enum.Font.Gotham, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left
    })
    local btn = createUI("TextButton", row, {
        Position = UDim2.new(0.72, 0, 0, 0), Size = UDim2.new(0.25, 0, 1, 0),
        BackgroundColor3 = state and currentTheme.ToggleOn or currentTheme.ToggleOff,
        Text = "", AutoButtonColor = false
    })
    createUI("UICorner", btn, { CornerRadius = UDim.new(1, 0) })

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and currentTheme.ToggleOn or currentTheme.ToggleOff
        callback(state)
    end)
end

-- Toggles
createToggle("☁ Anti Badai", antiStormEnabled, function(s)
    antiStormEnabled = s
end)

createToggle("🛡 God Mode", godModeEnabled, function(s)
    godModeEnabled = s
    if s then
        local hum = humanoid
        if hum then
            hum.BreakJointsOnDeath = false
            table.insert(godConnections, hum:GetPropertyChangedSignal("Health"):Connect(function()
                if hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end))
            table.insert(godConnections, hum.StateChanged:Connect(function(_, newState)
                if newState == Enum.HumanoidStateType.Freefall or
                   newState == Enum.HumanoidStateType.FallingDown or
                   newState == Enum.HumanoidStateType.Physics or
                   newState == Enum.HumanoidStateType.Ragdoll then
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    hum.PlatformStand = false
                elseif newState == Enum.HumanoidStateType.Dead then
                    task.wait()
                    hum.Health = hum.MaxHealth
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end))
            table.insert(godConnections, hum.Died:Connect(function()
                hum.Health = hum.MaxHealth
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end))
        end
    else
        for _, c in ipairs(godConnections) do c:Disconnect() end
        table.clear(godConnections)
    end
end)

-- Theme Switcher
local themeBtn = createUI("TextButton", content, {
    Size = UDim2.new(1, 0, 0, 30),
    Text = "🎨 Toggle Theme",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BackgroundColor3 = currentTheme.Button,
    TextColor3 = currentTheme.Text
})
createUI("UICorner", themeBtn, { CornerRadius = UDim.new(0, 5) })

themeBtn.MouseButton1Click:Connect(function()
    currentTheme = currentTheme == themes.Dark and themes.Light or themes.Dark
    main.BackgroundColor3 = currentTheme.Background
    title.TextColor3 = currentTheme.Text
    fpsLabel.TextColor3 = currentTheme.Accent
    closeBtn.BackgroundColor3 = currentTheme.Button
    closeBtn.TextColor3 = currentTheme.Text
    themeBtn.BackgroundColor3 = currentTheme.Button
    themeBtn.TextColor3 = currentTheme.Text
end)

-- FPS Calc
local RunService = game:GetService("RunService")
local fps, frameCount, lastTime = 0, 0, tick()
RunService.RenderStepped:Connect(function()
    frameCount += 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frameCount
        frameCount = 0
        lastTime = now
        fpsLabel.Text = "FPS: " .. tostring(fps)
    end
end)

-- Respawn Update
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    task.wait(0.3)
    humanoid.WalkSpeed = speedValue
    humanoid.JumpPower = jumpValue
end)

-- Toggle UI
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        gui.Enabled = not gui.Enabled
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)