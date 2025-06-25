-- Andromeda Hub UI
-- Versi UI Atlas modern dengan tab sesuai permintaan user

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AndromedaUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 580, 0, 420)
mainFrame.Position = UDim2.new(0.5, -290, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

local tabNames = {
    {"🟢", "Farm"},
    {"🔴", "Combat"},
    {"🧭", "Teleport"},
    {"⚙️", "Settings"},
    {"🧩", "Misc"},
    {"💾", "Config"},
    {"🧬", "Tokens"},
}

local tabs = {}
local tabButtons = {}

local tabButtonFrame = Instance.new("Frame")
tabButtonFrame.Size = UDim2.new(0, 120, 1, 0)
tabButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tabButtonFrame.BorderSizePixel = 0
tabButtonFrame.Parent = mainFrame

local tabList = Instance.new("UIListLayout")
tabList.FillDirection = Enum.FillDirection.Vertical
tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Padding = UDim.new(0, 6)
tabList.Parent = tabButtonFrame

for i, data in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -10, 0, 36)
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabBtn.Text = data[1] .. " " .. data[2]
    tabBtn.Font = Enum.Font.GothamSemibold
    tabBtn.TextSize = 14
    tabBtn.AutoButtonColor = true
    tabBtn.Parent = tabButtonFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tabBtn

    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, -130, 1, -20)
    tabFrame.Position = UDim2.new(0, 130, 0, 10)
    tabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabFrame.BorderSizePixel = 0
    tabFrame.Visible = (i == 1)
    tabFrame.ScrollBarThickness = 6
    tabFrame.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = tabFrame

    tabButtons[i] = tabBtn
    tabs[i] = tabFrame

    tabBtn.MouseButton1Click:Connect(function()
        for j, f in ipairs(tabs) do
            f.Visible = false
            tabButtons[j].BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        tabFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
end

-- === Contoh: Menambahkan elemen UI ke Tab Farm === --
local farmTab = tabs[1]

local sectionTitle = Instance.new("TextLabel")
sectionTitle.Size = UDim2.new(1, -20, 0, 24)
sectionTitle.BackgroundTransparency = 1
sectionTitle.Text = "Auto Farm Settings"
sectionTitle.Font = Enum.Font.GothamBold
sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
sectionTitle.TextSize = 16
sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
sectionTitle.Parent = farmTab

local autoFarmToggle = Instance.new("TextButton")
autoFarmToggle.Size = UDim2.new(0, 180, 0, 32)
autoFarmToggle.Text = "Auto Farm: OFF"
autoFarmToggle.Font = Enum.Font.GothamSemibold
autoFarmToggle.TextSize = 14
autoFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoFarmToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
autoFarmToggle.Parent = farmTab

local uic = Instance.new("UICorner")
uic.CornerRadius = UDim.new(0, 6)
uic.Parent = autoFarmToggle

local enabled = false
autoFarmToggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    autoFarmToggle.Text = enabled and "Auto Farm: ON" or "Auto Farm: OFF"
    autoFarmToggle.BackgroundColor3 = enabled and Color3.fromRGB(80, 120, 60) or Color3.fromRGB(50, 50, 50)
end)