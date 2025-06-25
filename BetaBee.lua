
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Clear old UI if needed
local existing = PlayerGui:FindFirstChild("AndromedaUI")
if existing then existing:Destroy() end

-- Main UI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AndromedaUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 400)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1

-- TopBar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 2

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "🛰 ANDROMEDA MODZ"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.ZIndex = 3

local CloseButton = Instance.new("TextButton", TopBar)
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.ZIndex = 3

local MinimizeButton = Instance.new("TextButton", TopBar)
MinimizeButton.Text = "–"
MinimizeButton.Size = UDim2.new(0, 40, 1, 0)
MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Font = Enum.Font.Gotham
MinimizeButton.TextSize = 20
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.ZIndex = 3

-- Tabs
local Tabs = Instance.new("Frame", MainFrame)
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, 0, 0, 40)
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Tabs.BorderSizePixel = 0
Tabs.ZIndex = 2

-- Content Area
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -80)
ContentFrame.Position = UDim2.new(0, 0, 0, 80)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
ContentFrame.BackgroundTransparency = 0.1
ContentFrame.BorderSizePixel = 0
ContentFrame.ZIndex = 2
ContentFrame.ClipsDescendants = true

-- Enable mouse input
MainFrame.Selectable = true
MainFrame.Active = true
TopBar.Selectable = true
TopBar.Active = true
Tabs.Selectable = true
Tabs.Active = true
ContentFrame.Selectable = true
ContentFrame.Active = true

-- Minimize logic
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	ContentFrame.Visible = not minimized
	Tabs.Visible = not minimized
end)

-- Close logic
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)