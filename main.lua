-- main.lua
-- Grow a Garden Pet Auto Leveler Script
if game.PlaceId ~= 16035209787 then
    warn("This script only works in Grow a Garden!")
    return
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local petNameToGet = "Golden Bee"
local run = true

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

-- UI toggle
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PetLevelGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0, 100, 0, 100)
button.Text = "Toggle Pet Auto-Level"
button.BackgroundColor3 = Color3.new(1, 1, 0)
button.Parent = gui

button.MouseButton1Click:Connect(function()
    run = not run
    if run then
        levelPet(petNameToGet)
    end
end)

print("✅ Pet Level Script Loaded")
