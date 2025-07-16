-- main.lua
-- v1.0 (update checks from GitHub)

local VERSION = "1.0"
local SCRIPT_URL = "https://raw.githubusercontent.com/Mrzarate0/MyPethub/main/main.lua"
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- fetch remote script to parse version
local function fetchLatestVersion()
    local raw = game:HttpGet(SCRIPT_URL)
    local v = raw:match("local VERSION%s*=%s*\"([%d%.]+)\"")
    return v or "?"
end

-- create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PetLevelGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- version label
local versionLabel = Instance.new("TextLabel", gui)
versionLabel.Text = "v" .. VERSION
versionLabel.Size = UDim2.new(0, 100, 0, 30)
versionLabel.Position = UDim2.new(0, 100, 0, 50)

-- update-version button
local updateBtn = Instance.new("TextButton", gui)
updateBtn.Size = UDim2.new(0, 200, 0, 50)
updateBtn.Position = UDim2.new(0, 100, 0, 100)
updateBtn.Text = "Check for Updates"

updateBtn.MouseButton1Click:Connect(function()
    local latest = fetchLatestVersion()
    versionLabel.Text = "v" .. latest
    if latest ~= VERSION then
        updateBtn.Text = "Reload to v" .. latest
    else
        updateBtn.Text = "Up-to-date!"
    end
end)

-- reload button
local reloadBtn = Instance.new("TextButton", gui)
reloadBtn.Size = UDim2.new(0, 200, 0, 50)
reloadBtn.Position = UDim2.new(0, 100, 0, 160)
reloadBtn.Text = "Reload Script"
reloadBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet(SCRIPT_URL, true))()
    gui:Destroy()
end)

-- existing pet-leveling code here...
-- (omitted for brevity; keep your levelPet and toggle logic)

print("✅ Pet Level Script v" .. VERSION .. " Loaded")
