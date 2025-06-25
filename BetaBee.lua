-- UI Atlas v1.0 Style (Manual UI, Tabbed Layout)
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AtlasUI"
gui.ResetOnSpawn = false

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 750, 0, 500)
main.Position = UDim2.new(0.5, -375, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- TopBar
local topBar = Instance.new("Frame", main)
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(35, 60, 115)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Atlas v1.0"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton", topBar)
close.Size = UDim2.new(0, 40, 1, 0)
close.Position = UDim2.new(1, -40, 0, 0)
close.Text = "✕"
close.BackgroundTransparency = 1
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.SourceSansBold
close.TextSize = 20

local minimize = Instance.new("TextButton", topBar)
minimize.Size = UDim2.new(0, 40, 1, 0)
minimize.Position = UDim2.new(1, -80, 0, 0)
minimize.Text = "–"
minimize.BackgroundTransparency = 1
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 20

-- Left Tab Bar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 140, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

-- Tabs list
local tabNames = {
    {"AFK / Farming", "🟢"},
    {"Combat", "🔴"},
    {"Teleport", "🧭"},
    {"Settings", "⚙️"},
    {"Misc", "💎"},
    {"Token", "🔘"},
    {"GUI", "🎨"},
}

local contentFrames = {}
local selectedTab

local function createTab(index, name, icon)
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Position = UDim2.new(0, 0, 0, (index - 1) * 40)
    button.Text = icon .. "  " .. name
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.BorderSizePixel = 0
    button.AutoButtonColor = true

    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0, 140, 0, 40)
    content.Size = UDim2.new(1, -140, 1, -40)
    content.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    content.Visible = false

    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "This is the [" .. name .. "] tab.\nInsert features here later."
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 20
    label.TextWrapped = true
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.BackgroundTransparency = 1

    contentFrames[name] = content

    button.MouseButton1Click:Connect(function()
        if selectedTab then
            selectedTab.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            contentFrames[selectedTab.Name].Visible = false
        end
        button.BackgroundColor3 = Color3.fromRGB(45, 80, 150)
        content.Visible = true
        selectedTab = button
        selectedTab.Name = name
    end)

    -- Auto select first tab
    if index == 1 then
        button:MouseButton1Click()
    end
end

-- Create all tabs
for i, t in ipairs(tabNames) do
    createTab(i, unpack(t))
end

-- Close & Minimize logic
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, v in ipairs(main:GetChildren()) do
        if v ~= topBar and v ~= sidebar then
            v.Visible = not minimized
        end
    end
end)