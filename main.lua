local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Infinite Realm - Ink Game",
    Footer = "v1.0.0 - BETA",
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true
})

local Tab1 = Window:AddTab("Tab 1", "box")

-- — LEFT GROUP now "Exploits" —
local LeftGroup1 = Tab1:AddLeftGroupbox("Exploits")

local tugSpam = false
local noclipEnabled = false

LeftGroup1:AddToggle("Auto Tug of War", {
    Text = "Auto Tug of War",
    Default = false,
    Tooltip = "Spams the QTE remote every 0.1s",
    Callback = function(state)
        tugSpam = state
    end,
})

LeftGroup1:AddButton({
    Text = "Finish Red Light, Green Light",
    Func = function()
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(-43.84, 1025.06, 136.77)
    end,
})

LeftGroup1:AddButton({
    Text = "Finish Glass Game",
    Func = function()
        local char = lp.Character or lp.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        hrp.CFrame = CFrame.new(-212.0, 521.0, -1534.9)
    end,
})

LeftGroup1:AddToggle("Noclip", {
    Text = "Noclip",
    Default = false,
    Tooltip = "Disable collisions with objects",
    Callback = function(state)
        noclipEnabled = state
    end,
})

-- — RIGHT GROUP now "Player" —
local RightGroup1 = Tab1:AddRightGroupbox("Player")

local walkSpeedVal = 16
local tpWalkSpeedVal = 0.3
local jumpPowerVal = 50
local fovVal = 70
local tpwalking = false
local InfiniteJumpEnabled = false

local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:FindFirstChildWhichIsA("Humanoid")

lp.CharacterAdded:Connect(function(newChar)
    char = newChar
    hum = char:WaitForChild("Humanoid")
end)

RunService.Heartbeat:Connect(function()
    if char and hum then
        hum.WalkSpeed = walkSpeedVal
        hum.JumpPower = jumpPowerVal
        if tpwalking and hum.MoveDirection.Magnitude > 0 then
            hum.PlatformStand = false
            char:TranslateBy(hum.MoveDirection * tpWalkSpeedVal)
        end
        if noclipEnabled then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
    workspace.CurrentCamera.FieldOfView = fovVal
end)

RightGroup1:AddSlider("WalkSpeed", {
    Text = "WalkSpeed",
    Default = walkSpeedVal,
    Min = 16,
    Max = 250,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        walkSpeedVal = value
    end,
})

RightGroup1:AddSlider("TpWalkSpeed", {
    Text = "TpWalkSpeed",
    Default = tpWalkSpeedVal,
    Min = 0.1,
    Max = 2,
    Rounding = 2,
    Compact = false,
    Callback = function(value)
        tpWalkSpeedVal = value
    end,
})

RightGroup1:AddSlider("JumpPower", {
    Text = "JumpPower",
    Default = jumpPowerVal,
    Min = 50,
    Max = 300,
    Rounding = 1,
    Compact = false,
    Callback = function(value)
        jumpPowerVal = value
    end,
})

RightGroup1:AddSlider("FOV", {
    Text = "FOV",
    Default = fovVal,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        fovVal = value
    end,
})

RightGroup1:AddToggle("Enable TpWalk", {
    Text = "Enable TpWalk",
    Default = false,
    Tooltip = "Enables TP-style walking that bypasses stun.",
    Callback = function(state)
        tpwalking = state
    end,
})

RightGroup1:AddToggle("Infinite Jump", {
    Text = "Infinite Jump",
    Default = false,
    Tooltip = "Jump infinitely by holding or spamming jump.",
    Callback = function(state)
        InfiniteJumpEnabled = state
    end,
})

UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local char = lp.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

task.spawn(function()
    while true do
        if tugSpam then
            local args = {
                [1] = {
                    QTEGood = true
                }
            }

            pcall(function()
                ReplicatedStorage:WaitForChild("Remotes", 9e9):WaitForChild("TemporaryReachedBindable", 9e9):FireServer(unpack(args))
            end)
        end
        task.wait(0.1)
    end
end)
