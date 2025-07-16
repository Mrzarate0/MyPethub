-- main.lua
-- v1.0 - Grow a Garden Pet Auto Leveler Script with Version Checker, GUI, and Admin Controls

if game.PlaceId ~= 16035209787 then
    warn("This script only works in Grow a Garden!")
    return
end

local VERSION = "1.0"
local SCRIPT_URL = "https://raw.githubusercontent.com/Mrzarate0/MyPethub/main/main.lua"
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local petNameToGet = "Golden Bee"
local run = true

-- Admin Check
local ADMINS = {
    ["Mrzarate0"] = true,
    [player.Name] = true -- allows current user to be admin
}

if not ADMINS[player.Name] then
    warn("You are not authorized to run this admin script.")
    return
end

-- Fetch remote script version
local function fetchLatestVersion()
    local raw = game:HttpGet(SCRIPT_URL)
    local v = raw:match("local VERSION%s*=%s*\"([%d%.]+)\"")
    return v or "?"
end

-- Auto-level pet function
local function levelPet(petName)
    while run do
        local petsFolder = player:WaitForChild("Pets")
        local pet = petsFolder:FindFirstChild(petName)

        if not pet then
            local remote = ReplicatedStorage:FindFirstChild("HatchPet")
            if remote then
                remote:InvokeServer(petName)
            end
        else
            local levelRemote = ReplicatedStorage:FindFirstChild("LevelUpPet")
            if levelRemote then
                levelRemote:FireServer(pet)
            end
        end
        task.wait(1)
    end
end

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "PetLevelGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Version label
local versionLabel = Instance.new("TextLabel", gui)
versionLabel.Text = "v" .. VERSION
versionLabel.Size = UDim2.new(0, 100, 0, 30)
versionLabel.Position = UDim2.new(0, 100, 0, 50)
versionLabel.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)

-- Check for update button
local updateBtn = Instance.new("TextButton", gui)
updateBtn.Size = UDim2.new(0, 200, 0, 50)
updateBtn.Position = UDim2.new(0, 100, 0, 100)
updateBtn.Text = "Check for Updates"
updateBtn.BackgroundColor3 = Color3.new(0.5, 0.8, 1)

updateBtn.MouseButton1Click:Connect(function()
    local latest = fetchLatestVersion()
    versionLabel.Text = "v" .. latest
    if latest ~= VERSION then
        updateBtn.Text = "Reload to v" .. latest
    else
        updateBtn.Text = "Up-to-date!"
    end
end)

-- Reload script button
local reloadBtn = Instance.new("TextButton", gui)
reloadBtn.Size = UDim2.new(0, 200, 0, 50)
reloadBtn.Position = UDim2.new(0, 100, 0, 160)
reloadBtn.Text = "Reload Script"
reloadBtn.BackgroundColor3 = Color3.new(0.7, 1, 0.7)

reloadBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet(SCRIPT_URL, true))()
    gui:Destroy()
end)

-- Pet leveling toggle button
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 200, 0, 50)
toggleBtn.Position = UDim2.new(0, 100, 0, 220)
toggleBtn.Text = "Toggle Pet Auto-Level"
toggleBtn.BackgroundColor3 = Color3.new(1, 1, 0)

toggleBtn.MouseButton1Click:Connect(function()
    run = not run
    if run then
        levelPet(petNameToGet)
        toggleBtn.Text = "Stop Auto-Level"
    else
        toggleBtn.Text = "Start Auto-Level"
    end
end)

print("✅ Pet Level Script v" .. VERSION .. " Loaded")
