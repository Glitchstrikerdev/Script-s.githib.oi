--// Script Version
local CurrentVersion = "🌟 ShadowByte v1 🌌 | Pet GO 🐾"

-- Load Rayfield UI
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("Failed to load Rayfield UI!")
    return
end

--// Create UI Window
local Window = Rayfield:CreateWindow({
    Name = CurrentVersion,
    LoadingTitle = "Loading...",
    LoadingSubtitle = "By ShadowByte",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PetGOConfig",
        FileName = "PetGOSettings"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

--// Tabs
local MainTab = Window:CreateTab("🐾 Main", 4483362458)
local EggTab = Window:CreateTab("🥚 Egg", 4483362458)
local OtherTab = Window:CreateTab("⚙️ Other", 4483362458)
local TeleportTab = Window:CreateTab("🚀 Teleports", 4483362458)

--// Variables
local toggles = {
    AutoFarm = false,
    AutoHatchSingle = false,
    AutoHatchTriple = false,
    AutoEquipBest = false,
    AutoSpinWheel = false,
    AutoClaimRewards = false,
    AutoClaimEventEgg = false
}

--// Safe Event Function
local function safeFire(event, ...)
    if event and typeof(event) == "Instance" and event:IsA("RemoteEvent") then
        event:FireServer(...)
    end
end

--// Auto-Farm Collectibles
MainTab:CreateToggle({
    Name = "🔄 Auto-Farm Collectibles",
    CurrentValue = false,
    Flag = "AutoFarmCollectibles",
    Callback = function(Value)
        toggles.AutoFarm = Value
        task.spawn(function()
            while toggles.AutoFarm do
                for _, v in pairs(game:GetService("Workspace").Collectibles:GetChildren()) do
                    if v:IsA("Part") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.2)
                    end
                end
                task.wait(1)
            end
        end)
    end
})

--// Auto-Hatch Egg
local selectedEgg = "BasicEgg"
EggTab:CreateDropdown({
    Name = "🥚 Select Egg",
    Options = {"BasicEgg", "RareEgg", "LegendaryEgg"},
    CurrentOption = "BasicEgg",
    Callback = function(Option)
        selectedEgg = Option
    end
})

EggTab:CreateToggle({
    Name = "🎮 Auto Single Hatch",
    CurrentValue = false,
    Flag = "AutoSingleHatch",
    Callback = function(Value)
        toggles.AutoHatchSingle = Value
        task.spawn(function()
            while toggles.AutoHatchSingle do
                safeFire(game:GetService("ReplicatedStorage").Events.HatchEgg, selectedEgg, 1)
                task.wait(3)
            end
        end)
    end
})

EggTab:CreateToggle({
    Name = "🎮 Auto Triple Hatch",
    CurrentValue = false,
    Flag = "AutoTripleHatch",
    Callback = function(Value)
        toggles.AutoHatchTriple = Value
        task.spawn(function()
            while toggles.AutoHatchTriple do
                safeFire(game:GetService("ReplicatedStorage").Events.HatchEgg, selectedEgg, 3)
                task.wait(3)
            end
        end)
    end
})

--// Auto Equip Best Pets
EggTab:CreateToggle({
    Name = "🦄 Auto Equip Best Pets",
    CurrentValue = false,
    Flag = "AutoEquipBestPets",
    Callback = function(Value)
        if Value then
            safeFire(game:GetService("ReplicatedStorage").Events.EquipBestPets)
        end
    end
})

--// Auto Spin Wheel
OtherTab:CreateToggle({
    Name = "🎡 Auto Spin Wheel",
    CurrentValue = false,
    Flag = "AutoSpinWheel",
    Callback = function(Value)
        toggles.AutoSpinWheel = Value
        task.spawn(function()
            while toggles.AutoSpinWheel do
                safeFire(game:GetService("ReplicatedStorage").Events.SpinWheel)
                task.wait(5)
            end
        end)
    end
})

--// Auto Claim Rewards
OtherTab:CreateToggle({
    Name = "🎁 Auto Claim Daily Rewards",
    CurrentValue = false,
    Flag = "AutoClaimRewards",
    Callback = function(Value)
        toggles.AutoClaimRewards = Value
        task.spawn(function()
            while toggles.AutoClaimRewards do
                safeFire(game:GetService("ReplicatedStorage").Events.ClaimReward)
                task.wait(3)
            end
        end)
    end
})

--// Auto Claim Event Egg
OtherTab:CreateToggle({
    Name = "🐣 Auto Claim Event Egg",
    CurrentValue = false,
    Flag = "AutoClaimEventEgg",
    Callback = function(Value)
        toggles.AutoClaimEventEgg = Value
        task.spawn(function()
            while toggles.AutoClaimEventEgg do
                safeFire(game:GetService("ReplicatedStorage").Events.ClaimEventEgg)
                task.wait(3)
            end
        end)
    end
})

--// Teleports
local teleportLocations = {
    ["Spawn"] = CFrame.new(0, 5, 0),
    ["Shop"] = CFrame.new(100, 5, 100),
    ["VIP Area"] = CFrame.new(200, 5, 200),
    ["Event Area"] = CFrame.new(300, 5, 300)
}

TeleportTab:CreateDropdown({
    Name = "🌍 Select Teleport Location",
    Options = {"Spawn", "Shop", "VIP Area", "Event Area"},
    CurrentOption = "Spawn",
    Callback = function(Option)
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = teleportLocations[Option]
        end
    end
})

--// UI Toggle Key
Rayfield:CreateToggleKey(Enum.KeyCode.RightShift)

--// Success Notification
Rayfield:Notify({
    Title = "ShadowByte v1",
    Content = "✅ Script Loaded Successfully!",
    Duration = 5
})
