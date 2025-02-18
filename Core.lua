--// ShadowByte Game Loader

-- Game List (Add more game IDs and script URLs)
local GameList = {
    [123456789] = "https://yourhost.com/script1.lua",  -- Replace with actual game IDs and script URLs
    [987654321] = "https://yourhost.com/script2.lua"
}

-- Notification Function
local function notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

-- Main Execution
local currentGame = game.PlaceId

if GameList[currentGame] then
    notify("ShadowByte", "Supported Game Detected! Loading script...", 3)
    task.wait(1) -- Smooth execution delay
    local success, err = pcall(function()
        loadstring(game:HttpGet(GameList[currentGame], true))()
    end)

    if success then
        notify("ShadowByte", "Script Loaded Successfully!", 3)
    else
        notify("ShadowByte", "Failed to load script. Error: "..err, 5)
    end
else
    notify("ShadowByte", "Unsupported Game. No script available.", 3)
end
