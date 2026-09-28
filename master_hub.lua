-- [[ THE HUB | ALL-IN-ONE MULTI-FILE ROUTER MATRIX v7.0 ]]
print("[The Hub]: Connecting expanded modular repository clusters...")

local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Cloud Configuration Loader Function
local base_repo_url = "https://githubusercontent.com"
local function pullFile(name)
    local success, text = pcall(function() return game:HttpGet(base_repo_url .. name) end)
    if success and text then
        local func = loadstring(text)
        if func then task.spawn(func) end
    else
        warn("[The Hub Error]: Failed to fetch file branch: " .. name)
    end
end

-- LOADS ALL FIVE SEPARATE CODEFILES ACROSS THE CLOUD AT ONCE
pullFile("aimbot.lua")
pullFile("goalkeeper.lua")
pullFile("skills.lua")
pullFile("curve_poker.lua")
pullFile("shots_reach.lua")

-- Graphical Interface Controller Wrapper
local function build(className, properties)
    local inst = Instance.new(className)
    for p, v in pairs(properties) do inst[p] = v end
    return inst
end

local screenGui = build("ScreenGui", { Name = "TheHub_UnifiedMatrix", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui") })
local frame = build("Frame", { Parent = screenGui, BackgroundColor3 = Color3.fromRGB(20,20,20), BorderColor3 = Color3.fromRGB(50,50,50), Size = UDim2.new(0,340,0,440), Position = UDim2.new(0.2,0,0.2,0), Active = true, Draggable = true })
build("TextLabel", { Parent = frame, Text = "THE HUB COMMAND VAULT v7.0", Size = UDim2.new(1,0,0,40), BackgroundColor3 = Color3.fromRGB(30,30,30), TextColor3 = Color3.fromRGB(255,255,255), TextSize = 16, Font = Enum.Font.SourceSansBold })

local function addToggle(label, y, callback)
    local active = false
    local btn = build("TextButton", { Parent = frame, Text = label .. " [OFF]", Size = UDim2.new(1,-30,0,32), Position = UDim2.new(0,15,0,y), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.fromRGB(240,240,240), TextSize = 14, Font = Enum.Font.SourceSansSemibold })
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0,140,0) or Color3.fromRGB(40,40,40)
        btn.Text = label .. (active and " [ON]" or " [OFF]")
        callback(active)
    end)
end

-- Renders your full multi-file menu grid smoothly
addToggle("🎯 Target Aimbot Core", 55, function(val) _G.AimbotActive = val end)
addToggle("🌀 Curve Aimbot Shot", 95, function(val) _G.CurveAimbotActive = val end)
addToggle("👟 Sneaky Poker Dribble", 135, function(val) _G.SneakyDribbleActive = val end)
addToggle("☄️ Low Ground Shots Force", 175, function(val) _G.GroundShotsActive = val end)
addToggle("🛰️ Ground Shots Reach", 215, function(val) _G.GroundReachActive = val end)
addToggle("🧤 Predictive Goalkeeper Wall", 255, function(val) _G.GKActive = val end)
addToggle("🌈 Auto Nero Rainbow Flick", 295, function(val) _G.NeroActive = val end)
addToggle("⚽ Stable Auto Juggle Loop", 335, function(val) _G.AutoJuggle = val val end)

local function pullBall()
    local b = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Football") or workspace:FindFirstChild("Hitbox")
    local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if b and h and b:IsA("BasePart") then b.CFrame = h.CFrame * CFrame.new(0,-1,-2.5) b.AssemblyLinearVelocity = Vector3.zero end
end

UserInputService.InputBegan:Connect(function(i, chat)
    if chat then return end
    if i.KeyCode == Enum.KeyCode.Insert then frame.Visible = not frame.Visible
    elseif i.KeyCode == Enum.KeyCode.B then pullBall()
    elseif i.KeyCode == Enum.KeyCode.M then _G.DefendingTargetNet, _G.EnemyTargetNet = _G.EnemyTargetNet, _G.DefendingTargetNet end
end)
print("[The Hub]: Router updated to version 7.0 successfully.")
