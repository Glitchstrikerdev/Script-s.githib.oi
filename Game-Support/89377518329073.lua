   local CurrentVersion = "🌟 • Shadowbyte v1  | [Bee king Simulator] 👑"
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    -- Create Main Window
    local Window = Rayfield:CreateWindow({
        Name = CurrentVersion,
        LoadingTitle = "Loading.. shadowbyte",
        LoadingSubtitle = "By Shadow Team ",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "BeeKingSimulatorConfigs",
            FileName = "BeeMasterSimulator"
        },
        Discord = { Enabled = true, Invite = "PwbtqEDT", RememberJoins = true }
    })

    -- ===================== TABS ===================== --
    -- Home Tab
    local homeTab = Window:CreateTab("Home", "🏠")
    homeTab:CreateSection("Welcome to Shadowbyte!")
    homeTab:CreateParagraph({
        Title = "🌟 About",
        Content = "Shadowbyte enhances your Bee Master Simulator experience with powerful and easy-to-use features."
    })

    -- Main Tab
    local mainTab = Window:CreateTab("🌟 Main", nil)
    mainTab:CreateSection("Farm Features")

    -- Egg Selection & Auto Hatch
    local Eggs = { ["Spawn Hive Egg"] = "631f4d8de6bb46b7b8ec92a9738fd4b02" }
    local selectedEgg, isAutoHatching = nil, false

    -- Egg Selection Dropdown
    mainTab:CreateDropdown({
        Name = "Select Egg",
        Options = {"Spawn Hive Egg"},
        Flag = "EggDropdown",
        Callback = function(option)
            selectedEgg = Eggs[option]
            Rayfield:Notify({ Title = "Egg Selected", Content = "You selected: " .. option, Duration = 3 })
        end
    })

    -- Auto Hatch Toggle
    mainTab:CreateToggle({
        Name = "Auto Hatch",
        Flag = "AutoHatchToggle",
        Callback = function(value)
            isAutoHatching = value
            Rayfield:Notify({ Title = "Auto Hatch", Content = isAutoHatching and "Enabled" or "Disabled", Duration = 3 })
            while isAutoHatching do
                if selectedEgg then
                    local args = { selectedEgg, "open1", {} }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Hatch"):WaitForChild("EggHatch"):InvokeServer(unpack(args))
                end
                task.wait(0.5)
            end
        end
    })

    -- Machine Controls Section
    mainTab:CreateSection("Machine Controls")
    local machines = {
        { "Open Golden Machine", "Shiny" },
        { "Open Rainbow Machine", "Rainbow" },
        { "Open Combine Machine", "Combine" }
    }

    for _, machine in ipairs(machines) do
        mainTab:CreateButton({
            Name = machine[1],
            Callback = function()
                game:GetService("Players").LocalPlayer.PlayerGui[machine[2]].Enabled = true
                Rayfield:Notify({ Title = machine[1], Content = machine[1] .. " is now opening.", Duration = 3 })
            end
        })
    end

    -- Other Features Section
    mainTab:CreateSection("Other Features")
    local features = {
        { "Open Upgrades", "Upgrades" },
        { "Open Staff Shop", "StaffShop" },
        { "Open Index", "Index" }
    }

    for _, feature in ipairs(features) do
        mainTab:CreateButton({
            Name = feature[1],
            Callback = function()
                game:GetService("Players").LocalPlayer.PlayerGui[feature[2]].Enabled = true
                Rayfield:Notify({ Title = feature[1], Content = "Opening " .. feature[1] .. ".", Duration = 3 })
            end
        })
    end

    -- ===================== MISC TAB ===================== --
    local miscTab = Window:CreateTab("Miscellaneous", "🖇️")
    miscTab:CreateSection("Player Tweaks")

    -- Speed and Jump Sliders
    miscTab:CreateSlider({
        Name = "Speed Power",
        Range = {16, 100},
        Increment = 1,
        Suffix = "Speed",
        CurrentValue = 16,
        Flag = "SpeedSlider",
        Callback = function(value)
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
            end
        end
    })

    miscTab:CreateSlider({
        Name = "Jump Power",
        Range = {50, 300},
        Increment = 10,
        Suffix = "Power",
        CurrentValue = 50,
        Flag = "JumpSlider",
        Callback = function(value)
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
            end
        end
    })

    -- Anti Staff Detection Section
    miscTab:CreateSection("Anti Staff")
    miscTab:CreateDropdown({
        Name = "Staff Warning/Leave",
        Options = {"Warning", "Leave"},
        CurrentOption = "Warning",
        Flag = "StaffWarningDropdown",
        Callback = function(option)
            game.Players.PlayerAdded:Connect(function(player)
                local groupId, staffGroupId = 35554847, 7
                if player:GetRankInGroup(groupId) > 0 then
                    if option == "Leave" then
                        game.Players.LocalPlayer:Kick("Staff detected. Leaving server.")
                    else
                        Rayfield:Notify({ Title = "Staff Detected!", Content = "Staff member joined: " .. player.Name, Duration = 5 })
                    end
                end
            end)
        end
    })

    -- ===================== COMMUNITY TAB ===================== --
    local communityTab = Window:CreateTab("Community", "🎉")
    communityTab:CreateSection("Join Us")
    communityTab:CreateParagraph({
        Title = "Join the Shadowbyte Community!",
        Content = "Click below to copy our Discord link to your clipboard."
    })
    communityTab:CreateButton({
        Name = "Copy Discord Link",
        Callback = function()
            setclipboard("https://discord.gg/5pwj8HQb")
            Rayfield:Notify({ Title = "Link Copied!", Content = "Discord link copied to clipboard.", Duration = 3 })
        end
    })

    -- ===================== SETTINGS TAB ===================== --
    local settingsTab = Window:CreateTab("Settings", "⚙️")
    settingsTab:CreateSection("Configuration Settings")

    -- Toggle Configuration Saving
    settingsTab:CreateToggle({
        Name = "Enable Configuration Saving",
        CurrentValue = true,
        Flag = "ConfigSaving",
        Callback = function(state)
            Rayfield:Notify({ Title = "Configuration", Content = "Config Saving: " .. tostring(state), Duration = 3 })
        end
    })

   -- Save Settings Button
    settingsTab:CreateButton({
        Name = "Save Settings",
        Callback = function()
            Rayfield:SaveConfiguration()
            Rayfield:Notify({ Title = "Success", Content = "Settings Saved!", Duration = 3 })
        end
    })

    -- Load Configurations
    local success, err = pcall(function()
        Rayfield:LoadConfiguration()
    end)

    if not success then
        warn("⚠️ Failed to load configuration: " .. err)
    end

    -- ===================== SCRIPT NOTIFICATIONS ===================== --
    Rayfield:Notify({
        Title = "Script Loaded",
        Content = "Welcome to Shadowbyte 🌟 [for Bee king Simulator!] 👑",
        Duration = 5
    })
