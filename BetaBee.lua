-- Bee Swarm Simulator Script UI (Atlas Style)
-- UI Only - Functionality akan ditambahkan kemudian

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "Bee Swarm Hub | Atlas UI", 
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BeeSwarmHub"
})

-- 🟢 AFK / Auto Farm
local afkTab = Window:MakeTab({
    Name = "🟢 AFK / Auto Farm",
    Icon = "rbxassetid://12345678",
    PremiumOnly = false
})

afkTab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Dig",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Sprinkler",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Farm Bubbles / Flames / Coconuts",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Farm Fuzzy Bombs",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Farm Under Balloons / Clouds",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Convert Honey",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Dispensers",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Boosters",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Planters",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Sprouts",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Auto Puffshroom",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Teleport to Rare",
    Default = false,
    Callback = function(value) end
})
afkTab:AddToggle({
    Name = "Honey Storm",
    Default = false,
    Callback = function(value) end
})