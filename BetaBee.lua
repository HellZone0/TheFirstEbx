-- ZONEMODDER Fish It (OrionLib Version)
-- Full Converted from Rayfield to OrionLib
-- Dibuat agar support ExeCodex

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "ZONE MODDER - Fish It",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "ZONEModderConfig"
})

-- Tabs
local FarmingTab = Window:MakeTab({Name = "Farming", Icon = "rbxassetid://4483362458", PremiumOnly = false})
local TeleportTab = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://4483362458", PremiumOnly = false})
local PlayerTab = Window:MakeTab({Name = "Player", Icon = "rbxassetid://4483362458", PremiumOnly = false})
local MiscTab = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4483362458", PremiumOnly = false})

-- Variabel Global
local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInput = game:GetService("VirtualInputManager")

local AutoFishingEnabled = false
local AutoFishingV2Enabled = false
local AutoCompleteEnabled = false
local AntiAFKEnabled = false
local AutoJumpEnabled = false
local CastingDelay = 3
local SavedPosition = nil

-- == FUNGSI UTAMA (copy dari script lama) ==
local function GetModule(path)
    local current = ReplicatedStorage
    for _, part in ipairs(path:split('.')) do
        current = current:FindFirstChild(part)
        if not current then return nil end
    end
    return current
end

local function CallRemoteAsync(remotePath, ...)
    task.spawn(function()
        local remote = GetModule(remotePath)
        if remote and remote:IsA("RemoteFunction") then
            remote:InvokeServer(...)
        elseif remote and remote:IsA("RemoteEvent") then
            remote:FireServer(...)
        end
    end)
end

local function GetInventory()
    local InventoryController = GetModule("Controllers.InventoryController")
    if InventoryController then
        return require(InventoryController).getInventory()
    end
    return {}
end

local function UseItemFromInventory(itemName)
    local inventory = GetInventory()
    for _, item in ipairs(inventory) do
        if item.name == itemName then
            local HotbarController = GetModule("Controllers.HotbarController")
            if HotbarController then
                local hotbar = require(HotbarController)
                hotbar.equipTool(item)
                return true
            end
        end
    end
    return false
end

local function BuyItem(itemType, itemName)
    if itemType == "Rod" then
        CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RF/PurchaseFishingRod", itemName)
    elseif itemType == "Bait" then
        CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RF/PurchaseBait", itemName)
    elseif itemType == "Radar" then
        CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RF/PurchaseGear", "Fishing Radar")
    elseif itemType == "DivingGear" then
        CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RF/PurchaseGear", "Diving Gear")
    end
end

-- == FUNGSI CHEAT ==
local function StartAutoFishingV1()
    if not AutoFishingEnabled then return end
    task.spawn(function()
        while AutoFishingEnabled do
            local rods = {"!!! Carbon Rod", "!!! Ice Rod", "!!! Luck Rod", "!!! Midnight Rod"}
            local rodEquipped = false
            for _, rod in ipairs(rods) do
                if UseItemFromInventory(rod) then
                    rodEquipped = true
                    break
                end
            end
            if rodEquipped then
                CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RF/ChargeFishingRod")
                task.wait(0.5)
                CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RF/CancelFishingInputs")
                CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RE/FishingCompleted")
                task.wait(CastingDelay)
            else
                BuyItem("Rod", "!!! Carbon Rod")
                task.wait(1)
            end
        end
    end)
end

local function StartAutoFishingV2()
    if not AutoFishingV2Enabled then return end
    task.spawn(function()
        while AutoFishingV2Enabled do
            local rods = {"!!! Carbon Rod", "!!! Ice Rod", "!!! Luck Rod", "!!! Midnight Rod"}
            local rodEquipped = false
            for _, rod in ipairs(rods) do
                if UseItemFromInventory(rod) then
                    rodEquipped = true
                    break
                end
            end
            if rodEquipped then
                for i = 1, 10 do
                    if not AutoFishingV2Enabled then break end
                    VirtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    task.wait(0.05)
                    VirtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    task.wait(0.05)
                end
                CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RE/FishingCompleted")
                task.wait(CastingDelay)
            else
                task.wait(1)
            end
        end
    end)
end

local function SetupAutoComplete()
    if not AutoCompleteEnabled then return end
    RunService.Heartbeat:Connect(function()
        if AutoCompleteEnabled then
            CallRemoteAsync("Packages._Index.sleitnick_net@0.2.0.net.RE/FishingCompleted")
        end
    end)
end

local function BypassFishingRadar()
    if not UseItemFromInventory("Fishing Radar") then
        BuyItem("Radar", "Fishing Radar")
        task.wait(2)
        UseItemFromInventory("Fishing Radar")
    end
end

local function BypassDivingGear()
    if not UseItemFromInventory("Diving Gear") then
        BuyItem("DivingGear", "Diving Gear")
        task.wait(2)
        UseItemFromInventory("Diving Gear")
    end
end

local function SetupAntiAFK()
    RunService.Heartbeat:Connect(function()
        if AntiAFKEnabled then
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:Move(Vector3.new(math.random(-1,1),0,math.random(-1,1)))
            end
        end
    end)
end

local function SetupAutoJump()
    RunService.Heartbeat:Connect(function()
        if AutoJumpEnabled then
            if math.random(1,20) == 1 then
                local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.Jump = true end
            end
        end
    end)
end

local function TeleportToArea(areaName)
    local AreaController = GetModule("Controllers.AreaController")
    if AreaController then
        require(AreaController).teleportToArea(areaName)
    end
end

-- == UI ORIONLIB ==

-- Farming Tab
FarmingTab:AddToggle({
    Name = "Auto Fishing V1",
    Default = false,
    Callback = function(Value)
        AutoFishingEnabled = Value
        if Value then StartAutoFishingV1() end
    end
})

FarmingTab:AddToggle({
    Name = "Auto Fishing V2 (Spam Tap)",
    Default = false,
    Callback = function(Value)
        AutoFishingV2Enabled = Value
        if Value then StartAutoFishingV2() end
    end
})

FarmingTab:AddToggle({
    Name = "Auto Complete Fishing",
    Default = false,
    Callback = function(Value)
        AutoCompleteEnabled = Value
        if Value then SetupAutoComplete() end
    end
})

FarmingTab:AddSlider({
    Name = "Casting Delay (sec)",
    Min = 1,
    Max = 10,
    Default = 3,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "sec",
    Callback = function(Value) CastingDelay = Value end
})

FarmingTab:AddButton({
    Name = "Bypass Fishing Radar",
    Callback = function() BypassFishingRadar() end
})

FarmingTab:AddButton({
    Name = "Bypass Diving Gear",
    Callback = function() BypassDivingGear() end
})

-- Teleport Tab
local areas = {"Treasure Room","Sysphus Statue","Crater Island","Kohana",
"Tropical Island","Weather Machine","Coral Reef","Enchant Room",
"Esoteric Island","Volcano","Lost Isle","Fishermand Island"}

TeleportTab:AddDropdown({
    Name = "Pilih Fishing Area",
    Default = "Treasure Room",
    Options = areas,
    Callback = function(Value) TeleportToArea(Value) end
})

TeleportTab:AddButton({
    Name = "Save Current Position",
    Callback = function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            SavedPosition = Player.Character.HumanoidRootPart.CFrame
        end
    end
})

TeleportTab:AddButton({
    Name = "Teleport to Saved Position",
    Callback = function()
        if SavedPosition and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = SavedPosition
        end
    end
})

-- Player Tab
PlayerTab:AddToggle({
    Name = "Anti AFK & Anti DC",
    Default = false,
    Callback = function(Value)
        AntiAFKEnabled = Value
        if Value then SetupAntiAFK() end
    end
})

PlayerTab:AddToggle({
    Name = "Auto Jump",
    Default = false,
    Callback = function(Value)
        AutoJumpEnabled = Value
        if Value then SetupAutoJump() end
    end
})

-- Misc Tab
MiscTab:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
})

MiscTab:AddButton({
    Name = "Destroy GUI",
    Callback = function() OrionLib:Destroy() end
})

OrionLib:Init()