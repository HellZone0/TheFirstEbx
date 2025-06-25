-- ✅ Andromeda Bee Swarm UI - Modern Style with Icons and Improved Aesthetics
-- Supports: Mobile & PC | Manual Toggle | Draggable | Minimizable

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AndromedaUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.Text = "🤖 ANDROMEDA MODZ"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.BackgroundTransparency = 1

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.Text = "✕"
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 20
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundTransparency = 1

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.Text = "–"
MinimizeButton.Font = Enum.Font.Gotham
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 255)
MinimizeButton.TextSize = 28
MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
MinimizeButton.BackgroundTransparency = 1

local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Parent = MainFrame
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.Size = UDim2.new(1, 0, 0, 40)
Tabs.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Tabs.BackgroundTransparency = 0.1
Tabs.BorderSizePixel = 0

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 0, 0, 80)
ContentFrame.Size = UDim2.new(1, 0, 1, -80)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ContentFrame.BackgroundTransparency = 0.1
ContentFrame.BorderSizePixel = 0

-- Minimize and Close Functionality
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentFrame.Visible = not isMinimized
    Tabs.Visible = not isMinimized
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)