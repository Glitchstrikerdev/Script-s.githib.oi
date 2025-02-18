--// Script Version and Info
local CurrentVersion = "🌟 Shadowbyte - Pet Simulator 99 | v1.0 🌌"

--// Rayfield UI Setup (for better interface)
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("Failed to load Rayfield UI!")
    return
end

--// Create Window
local Window = Rayfield:CreateWindow({
    Name = CurrentVersion,
    LoadingTitle = "Loading...",
    LoadingSubtitle = "By Shadowbyte",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PetSim99Config",
        FileName = "PetSim99Settings"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

--// Tabs for Various Functions
local MainTab = Window:CreateTab("🐾 Main", 4483362458)
local EggTab = Window:CreateTab("🥚 Eggs", 4483362458)
local QuestTab = Window:CreateTab("🗺️ Quests", 4483362458)
local EventTab = Window:CreateTab("🎉 Events", 4483362458)
local TeleportTab = Window:CreateTab("🚀 Teleports", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
local FlyTab = Window:CreateTab("🕊️ Fly", 4483362458)

--// Toggle Variables
local toggles = {
    AutoFarm = false,
    AutoHatch = false,
    AutoRebirth = false,
    AutoClaimRewards = false,
    AutoCollectItems = false,
    AutoUseUltimate = false,
    AutoTeleport = false,
    AutoBuyAreas = false,
    AutoUseBuffs = false,
    AutoUpgradePotions = false
}

--// Safe Event Firing Function
local function safeFire(event, ...)
    if event and typeof(event) == "Instance" and event:IsA("RemoteEvent") then
        event:FireServer(...)
    end
end

--// Auto Farm - Collect Loot, Coins, and Items
MainTab:CreateToggle({
    Name = "🔄 Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        toggles.AutoFarm = Value
        task.spawn(function()
            while toggles.AutoFarm do
                -- Example: Auto collect coins and loot
                local lootbags = game:GetService("Workspace").Lootbags:GetChildren()
                for _, loot in pairs(lootbags) do
                    if loot:IsA("Part") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = loot.CFrame
                    end
                end
                task.wait(1)
            end
        end)
    end
})

--// Auto Hatch Eggs
EggTab:CreateToggle({
    Name = "Auto Hatch Eggs",
    CurrentValue = false,
    Flag = "AutoHatchEgg",
    Callback = function(Value)
        toggles.AutoHatch = Value
        task.spawn(function()
            while toggles.AutoHatch do
                safeFire(game:GetService("ReplicatedStorage").Events.HatchEgg)
                task.wait(5)
            end
        end)
    end
})

--// Auto Use Ultimate Ability
MainTab:CreateToggle({
    Name = "Auto Use Ultimate",
    CurrentValue = false,
    Flag = "AutoUseUltimate",
    Callback = function(Value)
        toggles.AutoUseUltimate = Value
        task.spawn(function()
            while toggles.AutoUseUltimate do
                safeFire(game:GetService("ReplicatedStorage").Events.UseUltimate)
                task.wait(5)
            end
        end)
    end
})

--// Auto Rebirth
MainTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "AutoRebirth",
    Callback = function(Value)
        toggles.AutoRebirth = Value
        task.spawn(function()
            while toggles.AutoRebirth do
                local rebirthButton = game:GetService("Workspace"):FindFirstChild("RebirthButton")
                if rebirthButton then
                    fireclickdetector(rebirthButton)
                end
                task.wait(10)
            end
        end)
    end
})

--// Auto Teleport to Best Area
TeleportTab:CreateToggle({
    Name = "Auto Teleport to Best Area",
    CurrentValue = false,
    Flag = "AutoTeleport",
    Callback = function(Value)
        toggles.AutoTeleport = Value
        task.spawn(function()
            while toggles.AutoTeleport do
                -- Teleport to the best area
                safeFire(game:GetService("ReplicatedStorage").Events.Teleport, "BestArea")
                task.wait(5)
            end
        end)
    end
})

--// Miscellaneous Options (Speed, Buffs, etc.)
MiscTab:CreateToggle({
    Name = "Auto Use Buffs",
    CurrentValue = false,
    Flag = "AutoUseBuffs",
    Callback = function(Value)
        toggles.AutoUseBuffs = Value
        task.spawn(function()
            while toggles.AutoUseBuffs do
                -- Example: Use buffs or potions
                safeFire(game:GetService("ReplicatedStorage").Events.UseBuff)
                task.wait(10)
            end
        end)
    end
})

--// Fly Mode
FlyTab:CreateToggle({
    Name = "Fly Mode",
    CurrentValue = false,
    Flag = "FlyMode",
    Callback = function(Value)
        if Value then
            -- Enable fly
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(Enum.HumanoidStateType.Physics)
            -- Adjust flying logic as needed
        end
    end
})

--// Success Notification
Rayfield:Notify({
    Title = "Shadowbyte - PetSim99",
    Content = "Script Loaded Successfully!",
    Duration = 5
})

--// Event Functions

-- Auto Open Event Chests
EventTab:CreateToggle({
    Name = "Auto Open Event Chests",
    CurrentValue = false,
    Flag = "AutoOpenEventChest",
    Callback = function(Value)
        toggles.AutoOpenEventChest = Value
        task.spawn(function()
            while toggles.AutoOpenEventChest do
                local eventChest = game:GetService("Workspace"):FindFirstChild("EventChest")
                if eventChest then
                    fireclickdetector(eventChest)
                end
                task.wait(10)
            end
        end)
    end
})

-- Auto Buy Event Items (Merchants, Vending Machines)
EventTab:CreateToggle({
    Name = "Auto Buy Event Items",
    CurrentValue = false,
    Flag = "AutoBuyEventItems",
    Callback = function(Value)
        toggles.AutoBuyEventItems = Value
        task.spawn(function()
            while toggles.AutoBuyEventItems do
                -- Example: Auto-buy items from vending machines or merchants
                local merchant = game:GetService("Workspace"):FindFirstChild("EventMerchant")
                if merchant then
                    fireclickdetector(merchant)
                end
                task.wait(5)
            end
        end)
    end
})

--// End of Script
