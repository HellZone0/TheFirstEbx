-- Andromeda Bee Swarm Script - Modern UI Framework
-- Inspired by AI MODZ layout (multi-tab, toggleable, mobile-friendly)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create UI Elements
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AndromedaUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundTransparency = 0.1
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 2

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BorderSizePixel = 0

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

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
Tabs.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
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
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
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
    TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    TabButton.Size = UDim2.new(1/#tabs, 0, 1, 0)
    TabButton.AutoButtonColor = true

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = TabButton

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

-- Default tab
switchTab("AFK / Farm")

-- Minimize/Close Logic
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentFrame.Visible = not isMinimized
    Tabs.Visible = not isMinimized
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)