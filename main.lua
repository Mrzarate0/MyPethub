
-- main.lua
-- v2.0 - Grow a Garden Script for Delta Executor: Egg Mod, Pet Stats, and Fruit Weight Boost

if game.PlaceId ~= 16035209787 then
    warn("This script only works in Grow a Garden!")
    return
end

local VERSION = "2.0"
local SCRIPT_URL = "https://raw.githubusercontent.com/Mrzarate0/MyPethub/main/main.lua"
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local run = true

-- Admin Check
local ADMINS = {
    ["Mrzarate0"] = true,
    [player.Name] = true
}

if not ADMINS[player.Name] then
    warn("You are not authorized to run this admin script.")
    return
end

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "GrowAGardenGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Utility function
local function createButton(name, position, text, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 220, 0, 50)
    btn.Position = position
    btn.Text = text
    btn.BackgroundColor3 = Color3.new(1, 1, 0.7)
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Modify Egg Result
createButton("ModEgg", UDim2.new(0, 100, 0, 60), "🔁 Modify Egg Result", gui, function()
    local eggRemote = ReplicatedStorage:FindFirstChild("HatchPet")
    if eggRemote then
        eggRemote:InvokeServer("Golden Bee") -- Change the result to Golden Bee always
        print("[Egg] Forced egg to hatch Golden Bee")
    end
end)

-- Change Pet Age & Weight
createButton("ModPetStats", UDim2.new(0, 100, 0, 120), "🐣 Set Age/Weight", gui, function()
    local petFolder = player:WaitForChild("Pets")
    for _, pet in pairs(petFolder:GetChildren()) do
        if pet:FindFirstChild("Age") then pet.Age.Value = 9999 end
        if pet:FindFirstChild("Weight") then pet.Weight.Value = 9999 end
    end
    print("[Pet] All pets set to age 9999 & weight 9999")
end)

-- Grow Plant/Fruit to 8000kg+
createButton("GrowBig", UDim2.new(0, 100, 0, 180), "🌱 Grow Plant to 8000kg", gui, function()
    local fruitFolder = player:FindFirstChild("Fruits")
    if fruitFolder then
        for _, fruit in pairs(fruitFolder:GetChildren()) do
            if fruit:FindFirstChild("Weight") then
                fruit.Weight.Value = 8000
            end
        end
        print("[Fruit] All fruits set to 8000kg")
    end
end)

print("✅ Grow a Garden Script v" .. VERSION .. " Loaded")
