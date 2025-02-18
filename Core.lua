--// ShadowByte Core Game List

local GameList = {
    [123456789] = "https://raw.githubusercontent.com/Glitchstrikerdev/Script-s.githib.oi/refs/heads/main/Game-Support/8737899170.lua",  -- Replace with actual game IDs and script URLs
    [987654321] = "https://yourhost.com/script2.lua"
}

local function notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

local currentGame = game.PlaceId

if GameList[currentGame] then
    notify("ShadowByte", "Supported Game Detected! Loading script...", 3)
    task.wait(1) -- Smooth delay for better execution
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
