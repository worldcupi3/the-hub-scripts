-- [[ THE HUB | ALL-IN-ONE UNIVERSAL MASTER EXPLOIT SUITE v6.6 - OWNER PRIVATE ]]
print("[The Hub]: Initializing Fixed Cross-Platform Universal Physics Core...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ====================================================================
-- 🔒 AUTOMATED OWNER SECURITY BYPASS
-- ====================================================================
-- This automatically clears whichever profile you are currently logged into!
print("[The Hub EA]: Security verified. Welcome back, " .. LocalPlayer.Name)

-- ====================================================================
-- 🎨 GRAPHICAL INTERFACE DEPLOYMENT FRAMEWORK
-- ====================================================================
local function buildFrameworkElement(className, properties)
    local instance = Instance.new(className)
    for prop, val in pairs(properties) do instance[prop] = val end
    return instance
end

local coreGui = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
local screenGui = buildFrameworkElement("ScreenGui", {
    Name = "TheHub_UnifiedMatrix",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = coreGui
})

local mainFrame = buildFrameworkElement("Frame", {
    Name = "MainPanel",
    Parent = screenGui,
    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
    BorderColor3 = Color3.fromRGB(45, 45, 45),
    BorderSizePixel = 2,
    Position = UDim2.new(0.15, 0, 0.1, 0),
    Size = UDim2.new(0, 360, 0, 520),
    Active = true,
    Draggable = true
})

buildFrameworkElement("TextLabel", {
    Name = "Title",
    Parent = mainFrame,
    Text = "THE HUB | UNIVERSAL CORE v6.6",
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18,
    Font = Enum.Font.SourceSansBold
})

-- UI Toggle Configuration Tracking Layout
local toggles = {
    Aimbot = false, Curve = false, Pokers = false, Dribble = false,
    Nero = false, GroundShots = false, Reach = false, GK = false, AutoJuggle = false
}

local function addToggleSwitch(name, labelText, yOffset)
    local btn = buildFrameworkElement("TextButton", {
        Parent = mainFrame,
        Text = labelText .. " [OFF]",
        Size = UDim2.new(1, -30, 0, 35),
        Position = UDim2.new(0, 15, 0, yOffset),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        TextColor3 = Color3.fromRGB(235, 235, 235),
        TextSize = 14,
        Font = Enum.Font.SourceSansSemibold
    })
    
    btn.MouseButton1Click:Connect(function()
        toggles[name] = not toggles[name]
        if toggles[name] then
            btn.BackgroundColor3 = Color3.fromRGB(0, 140, 0)
            btn.Text = labelText .. " [ON]"
        else
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.Text = labelText .. " [OFF]"
        end
    end)
end

-- Render all toggles smoothly inside the interface dimensions
addToggleSwitch("Aimbot", "🎯 Target Aimbot Core", 50)
addToggleSwitch("Curve", "🌀 Curve Shot Mechanics", 90)
addToggleSwitch("Pokers", "👟 Sneaky Pokers Tackle", 130)
addToggleSwitch("Dribble", "🧲 Ball Glue Dribble", 170)
addToggleSwitch("Nero", "🌈 Auto Nero Rainbow Flick", 210)
addToggleSwitch("GroundShots", "☄️ Low Ground Shots Force", 250)
addToggleSwitch("Reach", "🛰️ Invisible 40-Stud Reach", 290)
addToggleSwitch("GK", "🧤 Predictive Goalkeeper Wall", 330)
addToggleSwitch("AutoJuggle", "⚽ Stable Auto Juggle Loop", 370)

-- ====================================================================
-- 🛰️ CORE GAME ENGINE OBJECT INTERCEPTOR
-- ====================================================================
local function getActiveFootball()
    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:match("ball") or name:match("hitbox") or name:match("body") or name:match("football") then
            if obj:IsA("BasePart") and not obj.Anchored then return obj end
        end
    end
    return nil
end

local executingTrick = false
_G.DefendingTargetNet = "GoalA"
_G.EnemyTargetNet = "GoalB"

-- Core Shared Mapping Operations
local function triggerHalftimeSideSwap()
    _G.DefendingTargetNet, _G.EnemyTargetNet = _G.EnemyTargetNet, _G.DefendingTargetNet
    print("[The Hub]: Side swap locked. Enemy net target:", _G.EnemyTargetNet)
end

local function triggerBringBallToFeet()
    local ball = getActiveFootball()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if ball and hrp then
        if ball.Size.X > 5 then ball.Size = Vector3.new(4, 4, 4) end
        ball.CFrame = hrp.CFrame * CFrame.new(0, -1, -2.5)
        ball.AssemblyLinearVelocity = Vector3.zero
        print("[The Hub]: Ball dropped at feet.")
    end
end

-- ==========================================
-- 📱 MOBILE DYNAMIC OVERLAY BUTTONS INTERCEPT
-- ==========================================
if UserInputService.TouchEnabled or not UserInputService.KeyboardEnabled then
    local mobileContainer = buildFrameworkElement("Frame", {
        Name = "MobileOverlay",
        Parent = screenGui,
        Size = UDim2.new(0, 100, 0, 160),
        Position = UDim2.new(0, 10, 0.35, 0),
        BackgroundTransparency = 1
    })
    
    local closeBtn = buildFrameworkElement("TextButton", {
        Parent = mobileContainer,
        Text = "Toggle Menu",
        Size = UDim2.new(1, 0, 0, 45),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.SourceSansBold
    })
    closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
    
    local pullBtn = buildFrameworkElement("TextButton", {
        Parent = mobileContainer,
        Text = "Bring Ball [B]",
        Size = UDim2.new(1, 0, 0, 45),
        Position = UDim2.new(0, 0, 0, 55),
        BackgroundColor3 = Color3.fromRGB(0, 120, 200),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.SourceSansBold
    })
    pullBtn.MouseButton1Click:Connect(triggerBringBallToFeet)
    
    local swapBtn = buildFrameworkElement("TextButton", {
        Parent = mobileContainer,
        Text = "Swap Side [M]",
        Size = UDim2.new(1, 0, 0, 45),
        Position = UDim2.new(0, 0, 0, 110),
        BackgroundColor3 = Color3.fromRGB(150, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.SourceSansBold
    })
    swapBtn.MouseButton1Click:Connect(triggerHalftimeSideSwap)
end

-- ==========================================
-- 💻 PC HARDWARE KEYBOARD ROUTING
-- ==========================================
UserInputService.InputBegan:Connect(function(input, chat)
    if chat then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    elseif input.KeyCode == Enum.KeyCode.M then
        triggerHalftimeSideSwap()
    elseif input.KeyCode == Enum.KeyCode.B then
        triggerBringBallToFeet()
    end
end)

-- ==========================================
-- 🛰️ MASTER ENGINE TICK RESOLVER
-- ==========================================
RunService.PreSimulation:Connect(function()
    local ball = getActiveFootball()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if ball and hrp then
        local distance = (ball.Position - hrp.Position).Magnitude
        
        -- [[ 1. INVISIBLE REACH REPLICATION CORE ]]
        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg")
        if toggles.Reach and rightLeg then
            rightLeg.Size = Vector3.new(40, 6, 40)
            rightLeg.CanCollide = false
            rightLeg.CanTouch = true
            rightLeg.Transparency = 1
        elseif rightLeg and rightLeg.Size.X > 5 then
            rightLeg.Size = Vector3.new(2, 2, 1)
        end
        
        -- [[ 2. TARGET AIMBOT & CURVE MATRIX ]]
        if toggles.Aimbot and distance <= 7 then
            local enemyNet = workspace:FindFirstChild(_G.EnemyTargetNet)
            if enemyNet then
                local vectorBase = (enemyNet.Position - ball.Position).Unit
                if toggles.Curve then
                    vectorBase = vectorBase + Camera.CFrame.RightVector * 0.28
                end
                ball.AssemblyLinearVelocity = vectorBase * 145
            end
        end
        
        -- [[ 3. LOW GROUND SHOTS OVERRIDE ]]
        if toggles.GroundShots and distance <= 7 and not toggles.Aimbot then
            local heading = hrp.CFrame.LookVector
            ball.AssemblyLinearVelocity = Vector3.new(heading.X * 130, -5, heading.Z * 130)
        end
        
        -- [[ 4. SNEAKY POKERS TACKLE ]]
        if toggles.Pokers and distance < 12 and distance > 4 and not executingTrick then
            ball.CFrame = hrp.CFrame + Vector3.new(0, -1, 3)
            ball.AssemblyLinearVelocity = hrp.CFrame.LookVector * 80
        end
        
        -- [[ 5. BALL GLUE DRIBBLE ]]
        if toggles.Dribble and distance < 15 and not toggles.Reach and not executingTrick and not toggles.AutoJuggle then
            ball.CFrame = hrp.CFrame * CFrame.new(0, -2, -3)
            ball.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity
        end
        
        -- [[ 6. AUTO NERO RAINBOW FLICK ]]
        if toggles.Nero and distance < 5 and ball.AssemblyLinearVelocity.Y < 5 and not executingTrick then
            executingTrick = true
            hrp.AssemblyLinearVelocity = Vector3.zero
            ball.CFrame = hrp.CFrame * CFrame.new(0, -1, -2)
