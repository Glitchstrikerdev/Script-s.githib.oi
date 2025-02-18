--// ShadowByte Loader

-- Load the core game list
local coreURL = "https://yourhost.com/gamelist.lua" -- Replace with your core game list URL

local function notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

local success, coreScript = pcall(function()
    return game:HttpGet(coreURL, true)
end)

if success and coreScript then
    local loadCore = loadstring(coreScript)
    if loadCore then
        notify("ShadowByte", "Loading Game List...", 2)
        loadCore()
    else
        notify("ShadowByte", "Failed to load core script.", 5)
    end
else
    notify("ShadowByte", "Error fetching core game list.", 5)
end
