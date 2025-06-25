-- Andromeda Bee Swarm Script - Modern UI Framework with Icons -- Improved layout, icons, and visuals for a cleaner modern style (Atlas inspired)

-- UI Icons (Unicode or Text) local TabIcons = { ["AFK / Auto Farm"] = "🌾", ["Combat"] = "⚔️", ["Teleport"] = "📍", ["Settings & Config"] = "⚙️", ["Miscellaneous / Extras"] = "🧪", ["Token / Rare / Priority Management"] = "🧩", ["GUI & Visual Customization"] = "🎨" }

-- Create UI Elements local ScreenGui = Instance.new("ScreenGui") local MainFrame = Instance.new("Frame") local TopBar = Instance.new("Frame") local Title = Instance.new("TextLabel") local CloseButton = Instance.new("TextButton") local MinimizeButton = Instance.new("TextButton") local Tabs = Instance.new("Frame") local ContentFrame = Instance.new("Frame")

-- Parent UI ScreenGui.Name = "AndromedaUI" ScreenGui.ResetOnSpawn = false ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame MainFrame.Name = "MainFrame" MainFrame.Parent = ScreenGui MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45) MainFrame.BackgroundTransparency = 0.1 MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0) MainFrame.Size = UDim2.new(0, 540, 0, 420) MainFrame.BorderSizePixel = 0 MainFrame.Active = true MainFrame.Draggable = true

-- Top Bar TopBar.Name = "TopBar" TopBar.Parent = MainFrame TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60) TopBar.Size = UDim2.new(1, 0, 0, 40) TopBar.BorderSizePixel = 0

-- Title Title.Name = "Title" Title.Parent = TopBar Title.Text = "🛰️ ANDROMEDA MODZ" Title.Font = Enum.Font.GothamBold Title.TextColor3 = Color3.fromRGB(255, 255, 255) Title.TextSize = 20 Title.Position = UDim2.new(0, 10, 0, 0) Title.Size = UDim2.new(0.6, 0, 1, 0) Title.BackgroundTransparency = 1

-- Close Button CloseButton.Name = "CloseButton" CloseButton.Parent = TopBar CloseButton.Text = "✖" CloseButton.Font = Enum.Font.GothamBold CloseButton.TextColor3 = Color3.fromRGB(255, 85, 85) CloseButton.TextSize = 20 CloseButton.Size = UDim2.new(0, 40, 1, 0) CloseButton.Position = UDim2.new(1, -40, 0, 0) CloseButton.BackgroundTransparency = 1

-- Minimize Button MinimizeButton.Name = "MinimizeButton" MinimizeButton.Parent = TopBar MinimizeButton.Text = "🗕" MinimizeButton.Font = Enum.Font.GothamBold MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200) MinimizeButton.TextSize = 20 MinimizeButton.Size = UDim2.new(0, 40, 1, 0) MinimizeButton.Position = UDim2.new(1, -80, 0, 0) MinimizeButton.BackgroundTransparency = 1

-- Tabs Frame Tabs.Name = "Tabs" Tabs.Parent = MainFrame Tabs.Position = UDim2.new(0, 0, 0, 40) Tabs.Size = UDim2.new(1, 0, 0, 40) Tabs.BackgroundColor3 = Color3.fromRGB(40, 40, 55) Tabs.BorderSizePixel = 0

-- Content Area ContentFrame.Name = "ContentFrame" ContentFrame.Parent = MainFrame ContentFrame.Position = UDim2.new(0, 0, 0, 80) ContentFrame.Size = UDim2.new(1, 0, 1, -80) ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35) ContentFrame.BorderSizePixel = 0

-- Logic for toggling visibility local isMinimized = false MinimizeButton.MouseButton1Click:Connect(function() isMinimized = not isMinimized ContentFrame.Visible = not isMinimized Tabs.Visible = not isMinimized end)

CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)