local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Ink Game",
    Footer = "v1.0.1 - BETA",
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true
})

local PlayerGroup = Window:CreateTab("Player"):CreateGroup("Exploits", "Left")
local ExploitsGroup = Window:CreateTab("Exploits"):CreateGroup("Player", "Right")

PlayerGroup:AddSlider("Walkspeed", {
    Text = "Walkspeed",
    Min = 1,
    Max = 100,
    Default = 24,
    Callback = function(val)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
})

PlayerGroup:AddSlider("TPWalkspeed", {
    Text = "TP Walk Speed",
    Min = 0.1,
    Max = 3,
    Default = 0.3,
    Callback = function(val)
        _G.tpWalkSpeed = val
    end
})

PlayerGroup:AddSlider("JumpPower", {
    Text = "Jump Power",
    Min = 10,
    Max = 200,
    Default = 50,
    Callback = function(val)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = val end
    end
})

PlayerGroup:AddSlider("FOV", {
    Text = "Field of View",
    Min = 50,
    Max = 120,
    Default = 70,
    Callback = function(val)
        game:GetService("Workspace").Camera.FieldOfView = val
    end
})

PlayerGroup:AddToggle("InfiniteJump", {
    Text = "Infinite Jump",
    Default = false,
    Callback = function(state)
        if state then
            _G.infJump = true
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if _G.infJump then
                    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:ChangeState("Jumping") end
                end
            end)
        else
            _G.infJump = false
        end
    end
})


--Exploits Group

ExploitsGroup:AddButton("Skip Red Light Green Light", function()
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-130, 530, -1500))
end)

ExploitsGroup:AddButton("Finish Glass Game", function()
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-212.0, 521.0, -1534.9))
end)

-- Expand Guards Hitbox Toggle
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local liveFolder = workspace:FindFirstChild("Live")

local guardsExpanded = false
local processedModels = {}
local TARGET_SIZE = Vector3.new(4, 4, 4)

local function isPlayerCharacter(model)
    return Players:FindFirstChild(model.Name) ~= nil
end

local function processModel(model)
    if not model or not model:IsA("Model") then return end
    if isPlayerCharacter(model) then return end
    if processedModels[model] then return end

    local head = model:FindFirstChild("Head")
    if not head or not head:IsA("BasePart") then return end

    if not model:FindFirstChild("_HeadHighlighter") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "_HeadHighlighter"
        highlight.Adornee = model
        highlight.FillColor = Color3.fromRGB(255, 80, 80)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = model
    end

    processedModels[model] = head
end

RunService.Heartbeat:Connect(function()
    if not guardsExpanded then return end
    for _, model in ipairs(liveFolder:GetChildren()) do
        processModel(model)
    end
    for model, head in pairs(processedModels) do
        if model and model.Parent and head and head.Parent then
            if head.Size ~= TARGET_SIZE then
                head.Size = TARGET_SIZE
                head.CanCollide = false
            end
        else
            processedModels[model] = nil
        end
    end
end)

ExploitsGroup:AddToggle("Expand Guards Hitbox", {
    Text = "Expand Guards Hitbox",
    Default = false,
    Callback = function(state)
        guardsExpanded = state
        if not state then
            for model, head in pairs(processedModels) do
                if head and head.Parent then
                    pcall(function()
                        head.Size = Vector3.new(1, 1, 1)
                        head.CanCollide = true
                    end)
                end
                local highlight = model:FindFirstChild("_HeadHighlighter")
                if highlight then
                    highlight:Destroy()
                end
            end
            processedModels = {}
        end
    end
})
