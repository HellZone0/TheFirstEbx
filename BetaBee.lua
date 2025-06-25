
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- UI Base
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AndromedaUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 2
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Parent = MainFrame
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 1

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.Text = "☄️ ANDROMEDA MODZ"
Title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close & Minimize Buttons
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.Text = "✕"
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 20
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundTransparency = 1

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.Text = "–"
MinimizeButton.Font = Enum.Font.Gotham
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 28
MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
MinimizeButton.BackgroundTransparency = 1

-- Tabs Frame
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Parent = MainFrame
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.Size = UDim2.new(1, 0, 0, 40)
Tabs.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
Tabs.BorderSizePixel = 0

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.FillDirection = Enum.FillDirection.Horizontal
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Parent = Tabs

-- Content Area
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 0, 0, 80)
ContentFrame.Size = UDim2.new(1, 0, 1, -80)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
ContentFrame.BackgroundTransparency = 0.15
ContentFrame.BorderSizePixel = 0

-- Tab List
local tabs = {
    {Name = "AFK / Farm", Icon = "🌾"},
    {Name = "Combat", Icon = "⚔️"},
    {Name = "Teleport", Icon = "🧭"},
    {Name = "Settings", Icon = "⚙️"},
    {Name = "Misc", Icon = "💎"},
    {Name = "Tokens", Icon = "🔘"},
    {Name = "GUI", Icon = "🎨"},
}

-- Tab switching
local function switchTab(tabName)
    for _, frame in pairs(ContentFrame:GetChildren()) do
        if frame:IsA("Frame") then
            frame.Visible = frame.Name == tabName
        end
    end
end

-- Buat tombol dan konten tab
local TabFrames = {}
for _, tab in ipairs(tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = Tabs
    TabButton.Text = tab.Icon .. "\n" .. tab.Name
    TabButton.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TabButton.TextSize = 12
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    TabButton.Size = UDim2.new(1 / #tabs, 0, 1, 0)
    TabButton.TextWrapped = true
    TabButton.TextYAlignment = Enum.TextYAlignment.Center
    TabButton.BackgroundTransparency = 0.15
    TabButton.AutoButtonColor = true
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 8)

    local Content = Instance.new("Frame")
    Content.Name = tab.Name
    Content.Parent = ContentFrame
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Visible = false
    TabFrames[tab.Name] = Content

    TabButton.MouseButton1Click:Connect(function()
        switchTab(tab.Name)
    end)
end

switchTab("AFK / Farm")

-- Minimize
local isMinimized = false
local originalSize = MainFrame.Size
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Tabs.Visible = not isMinimized
    ContentFrame.Visible = not isMinimized
    MainFrame:TweenSize(
        isMinimized and UDim2.new(0, 520, 0, 40) or originalSize,
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.25,
        true
    )
end)

-- Close
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Fitur Toggle Function
local function createToggle(parent, labelText, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 35)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 100, 1, 0)
    ToggleButton.Position = UDim2.new(1, -100, 0, 0)
    ToggleButton.Text = "OFF"
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 14
    ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Parent = ToggleFrame
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -110, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = labelText
    Label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Label.TextSize = 14
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local toggled = false
    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        ToggleButton.Text = toggled and "ON" or "OFF"
        ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(100, 40, 40)
        if callback then callback(toggled) end
    end)
end

-- Cheats - AFK / Farm
local AFKTab = TabFrames["AFK / Farm"]
createToggle(AFKTab, "Auto Farm", function(state) print("Auto Farm:", state) end)
createToggle(AFKTab, "Auto Collect Tokens", function(state) print("Auto Token:", state) end)
createToggle(AFKTab, "Auto Sprinkler", function(state) print("Auto Sprinkler:", state) end)
createToggle(AFKTab, "Auto Dispenser", function(state) print("Auto Dispenser:", state) end)
createToggle(AFKTab, "Auto Planter", function(state) print("Auto Planter:", state) end)

print("✅ Andromeda UI Loaded")