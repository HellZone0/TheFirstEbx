

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Buat UI
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
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundTransparency = 0
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 2

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

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
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close
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

-- Tombol Minimize
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
ContentFrame.BackgroundTransparency = 0.05
ContentFrame.BorderSizePixel = 0

-- Tabs Setup
local tabs = {
    {Name = "AFK / Farm", Icon = "🌾"},
    {Name = "Combat", Icon = "⚔️"},
    {Name = "Teleport", Icon = "🧭"},
    {Name = "Settings", Icon = "⚙️"},
    {Name = "Misc", Icon = "💎"},
    {Name = "Tokens", Icon = "🔘"},
    {Name = "GUI", Icon = "🎨"},
}

local function switchTab(tabName)
    for _, frame in pairs(ContentFrame:GetChildren()) do
        if frame:IsA("Frame") then
            frame.Visible = frame.Name == tabName
        end
    end
end

for _, tab in ipairs(tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = Tabs
    TabButton.Text = tab.Icon .. "\n" .. tab.Name
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 12
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    TabButton.Size = UDim2.new(1/#tabs, 0, 1, 0)
    TabButton.TextWrapped = true
    TabButton.TextYAlignment = Enum.TextYAlignment.Center
    TabButton.TextXAlignment = Enum.TextXAlignment.Center
    TabButton.AutoButtonColor = true
    TabButton.BackgroundTransparency = 0.1

    local Corner = Instance.new("UICorner", TabButton)
    Corner.CornerRadius = UDim.new(0, 8)

    local Content = Instance.new("Frame")
    Content.Name = tab.Name
    Content.Parent = ContentFrame
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        switchTab(tab.Name)
    end)
end

-- Tampilkan default tab
switchTab("AFK / Farm")

-- Minimize/Close logic
local isMinimized = false
local originalSize = MainFrame.Size
local originalPosition = MainFrame.Position

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized

    if isMinimized then
        ContentFrame.Visible = false
        Tabs.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    else
        ContentFrame.Visible = true
        Tabs.Visible = true
        MainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
