-- Expedition Antarctica Modern UI Script (Redesigned)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local speedValue = 16
local jumpValue = 50
local antiStormEnabled = false
local godConnections = {}

-- UI Theme Colors
local themes = {
    Dark = {
        Background = Color3.fromRGB(20, 20, 25),
        Text = Color3.fromRGB(240, 240, 240),
        Accent = Color3.fromRGB(100, 160, 255),
        Button = Color3.fromRGB(30, 30, 40),
        ToggleOn = Color3.fromRGB(50, 150, 100)
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 240),
        Text = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(70, 120, 220),
        Button = Color3.fromRGB(220, 220, 220),
        ToggleOn = Color3.fromRGB(80, 180, 120)
    }
}
local currentTheme = themes.Dark

-- Helper UI Function
local function createUI(name, parent, props)
    local inst = Instance.new(name)
    for prop, val in pairs(props or {}) do
        inst[prop] = val
    end
    inst.Parent = parent
    return inst
end

local screenGui = createUI("ScreenGui", game.CoreGui, { Name = "EA_ModernUI", ResetOnSpawn = false })

local mainFrame = createUI("Frame", screenGui, {
    Size = UDim2.new(0, 320, 0, 280),
    Position = UDim2.new(0.05, 0, 0.3, 0),
    BackgroundColor3 = currentTheme.Background,
    BorderSizePixel = 0,
    Active = true,
    Draggable = true
})
createUI("UICorner", mainFrame, { CornerRadius = UDim.new(0, 10) })

-- Title
local title = createUI("TextLabel", mainFrame, {
    Size = UDim2.new(1, -40, 0, 30),
    Position = UDim2.new(0, 10, 0, 0),
    Text = "❄️ Zone Expedition Trainer",
    TextColor3 = currentTheme.Text,
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamSemibold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- FPS
local fpsLabel = createUI("TextLabel", mainFrame, {
    Size = UDim2.new(0, 100, 0, 20),
    Position = UDim2.new(0, 10, 0, 5),
    BackgroundTransparency = 1,
    TextColor3 = currentTheme.Accent,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    Text = "FPS: 0",
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Close & Minimize
local closeBtn = createUI("TextButton", mainFrame, {
    Size = UDim2.new(0, 24, 0, 24),
    Position = UDim2.new(1, -30, 0, 4),
    Text = "✕",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BackgroundColor3 = currentTheme.Button,
    TextColor3 = currentTheme.Text
})
createUI("UICorner", closeBtn, { CornerRadius = UDim.new(0, 5) })

local toggleBtn = createUI("TextButton", mainFrame, {
    Size = UDim2.new(0, 24, 0, 24),
    Position = UDim2.new(1, -58, 0, 4),
    Text = "–",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BackgroundColor3 = currentTheme.Button,
    TextColor3 = currentTheme.Text
})
createUI("UICorner", toggleBtn, { CornerRadius = UDim.new(0, 5) })

local contentFrame = createUI("Frame", mainFrame, {
    Position = UDim2.new(0, 0, 0, 40),
    Size = UDim2.new(1, 0, 1, -50),
    BackgroundTransparency = 1
})

local function createInput(labelText, posY, defaultText)
    local label = createUI("TextLabel", contentFrame, {
        Position = UDim2.new(0, 15, 0, posY),
        Size = UDim2.new(0, 60, 0, 25),
        Text = labelText,
        BackgroundTransparency = 1,
        TextColor3 = currentTheme.Text,
        Font = Enum.Font.Gotham,
        TextSize = 14
    })
    local box = createUI("TextBox", contentFrame, {
        Position = UDim2.new(0, 85, 0, posY),
        Size = UDim2.new(0, 200, 0, 25),
        Text = defaultText,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        BackgroundColor3 = currentTheme.Button,
        TextColor3 = currentTheme.Text,
        BorderSizePixel = 0,
        ClearTextOnFocus = true
    })
    createUI("UICorner", box, { CornerRadius = UDim.new(0, 5) })
    return box
end

local speedBox = createInput("Speed:", 10, tostring(speedValue))
local jumpBox = createInput("Jump:", 50, tostring(jumpValue))

speedBox.FocusLost:Connect(function()
    local val = tonumber(speedBox.Text)
    if val then
        speedValue = val
        humanoid.WalkSpeed = val
    end
    speedBox.Text = tostring(speedValue)
end)

jumpBox.FocusLost:Connect(function()
    local val = tonumber(jumpBox.Text)
    if val then
        jumpValue = val
        humanoid.JumpPower = val
    end
    jumpBox.Text = tostring(jumpValue)
end)

-- Theme Switcher
local themeToggle = createUI("TextButton", contentFrame, {
    Position = UDim2.new(0, 15, 0, 90),
    Size = UDim2.new(0, 270, 0, 25),
    Text = "🎨 Toggle Theme",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BackgroundColor3 = currentTheme.Button,
    TextColor3 = currentTheme.Text
})
createUI("UICorner", themeToggle, { CornerRadius = UDim.new(0, 6) })

themeToggle.MouseButton1Click:Connect(function()
    currentTheme = (currentTheme == themes.Dark) and themes.Light or themes.Dark
    mainFrame.BackgroundColor3 = currentTheme.Background
    title.TextColor3 = currentTheme.Text
    fpsLabel.TextColor3 = currentTheme.Accent
    closeBtn.BackgroundColor3 = currentTheme.Button
    toggleBtn.BackgroundColor3 = currentTheme.Button
    toggleBtn.TextColor3 = currentTheme.Text
    closeBtn.TextColor3 = currentTheme.Text
    speedBox.BackgroundColor3 = currentTheme.Button
    speedBox.TextColor3 = currentTheme.Text
    jumpBox.BackgroundColor3 = currentTheme.Button
    jumpBox.TextColor3 = currentTheme.Text
    themeToggle.BackgroundColor3 = currentTheme.Button
    themeToggle.TextColor3 = currentTheme.Text
end)

-- FPS Logic
local RunService = game:GetService("RunService")
local fps = 0
local frameCount = 0
local lastTime = tick()
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

-- Close/Minimize
local minimized = false
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)
toggleBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    toggleBtn.Text = minimized and "+" or "–"
    mainFrame.Size = minimized and UDim2.new(0, 320, 0, 50) or UDim2.new(0, 320, 0, 280)
end)

-- Key Toggle
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        screenGui.Enabled = not screenGui.Enabled
    end
end)