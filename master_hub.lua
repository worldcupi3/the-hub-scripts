-- [[ THE HUB | UNIFIED SECTOR MATRIX ALL-IN-ONE v6.5 MASTER RELEASE ]]
print("[The Hub]: Initializing Unified Structural Mechanics Core...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ====================================================================
-- 🔒 MASTER SECURITY ANTI-LEAK GATEWAY LAYER
-- ====================================================================
local approved_ea_profiles = {
    ["okowewhat"] = true, -- Your master profile is the exclusive active owner
    ["Realistic678"] = true
}

if not approved_ea_profiles[LocalPlayer.Name] then
    LocalPlayer:Kick("\n[The Hub - Security Alert]\n\nYou don't have the early access role yet!")
    return
end

print("[The Hub EA]: Security verified. Welcome back Master, " .. LocalPlayer.Name)

-- ====================================================================
-- 🎨 GRAPHICAL INTERFACE GENERATOR FUNCTION ARRAYS
-- ====================================================================
local function createUIElement(className, properties)
    local instance = Instance.new(className)
    for prop, val in pairs(properties) do instance[prop] = val end
    return instance
end

local coreGui = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
local screenGui = createUIElement("ScreenGui", {
    Name = "TheHub_UnifiedMatrix_v65",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = coreGui
})

local mainFrame = createUIElement("Frame", {
    Name = "MainPanel",
    Parent = screenGui,
    BackgroundColor3 = Color3.fromRGB(15, 15, 15),
    BorderColor3 = Color3.fromRGB(50, 50, 50),
    BorderSizePixel = 2,
    Position = UDim2.new(0.2, 0, 0.15, 0),
    Size = UDim2.new(0, 360, 0, 480),
    Active = true,
    Draggable = true
})

createUIElement("TextLabel", {
    Name = "TitleBar",
    Parent = mainFrame,
    Text = "THE HUB | CORE COMMAND v6.5",
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.SourceSansBold
})

-- Core Global State Allocation Arrays
local toggles = {
    Aimbot = false, Curve = false, Pokers = false, Dribble = false,
    Nero = false, GroundShots = false, Reach = false, GK = false, AutoJuggle = false
}

local function buildToggle(name, label, yPos)
    local btn = createUIElement("TextButton", {
        Parent = mainFrame,
        Text = label .. " [OFF]",
        Size = UDim2.new(1, -30, 0, 34),
        Position = UDim2.new(0, 15, 0, yPos),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 14,
        Font = Enum.Font.SourceSansSemibold
    })
    
    btn.MouseButton1Click:Connect(function()
        toggles[name] = not toggles[name]
        if toggles[name] then
            btn.BackgroundColor3 = Color3.fromRGB(0, 150, 75)
            btn.Text = label .. " [ON]"
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.Text = label .. " [OFF]"
        end
    end)
end

-- Render individual layout switch buttons perfectly inside container boundaries
buildToggle("Aimbot", "🎯 Target Aimbot Core", 55)
buildToggle("Curve", "🌀 Curve Shot Mechanics", 95)
buildToggle("Pokers", "👟 Sneaky Pokers Tackle", 135)
buildToggle("Dribble", "🧲 Ball Glue Dribble", 175)
buildToggle("Nero", "🌈 Auto Nero Rainbow Flick", 215)
buildToggle("GroundShots", "☄️ Low Ground Shots Force", 255)
buildToggle("Reach", "🛰️ Invisible 40-Stud Reach", 295)
buildToggle("GK", "🧤 Predictive Goalkeeper Wall", 335)
buildToggle("AutoJuggle", "⚽ Stable Auto Juggle Loop", 375)

-- ====================================================================
-- 🛰️ PHYSICAL OBJECT SCANNING ENGINES
-- ====================================================================
local function getActiveFootball()
    for _, obj in pairs(workspace:GetDescendants()) do
        local lowerName = obj.Name:lower()
        if lowerName:match("ball") or lowerName:match("hitbox") or lowerName:match("body") or lowerName:match("football") then
            if obj:IsA("BasePart") and not obj.Anchored and obj.CanCollide == true then
                return obj
            elseif obj:IsA("Model") then
                local center = obj:FindFirstChild("body") or obj:FindFirstChild("hitbox") or obj:FindFirstChildOfClass("BasePart")
                if center and not center.Anchored then return center end
            end
        end
    end
    return nil
end

local executingTrick = false
_G.DefendingTargetNet = "GoalA"
_G.EnemyTargetNet = "GoalB"

local function triggerHalftimeSideSwap()
    _G.DefendingTargetNet, _G.EnemyTargetNet = _G.EnemyTargetNet, _G.DefendingTargetNet
    print("[The Hub]: Synchronization swap complete. Defending net targeted:", _G.DefendingTargetNet)
end

local function triggerBringBallToFeet()
    local ball = getActiveFootball()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if ball and hrp then
        if ball.Size.X > 5 then ball.Size = Vector3.new(4, 4, 4) end
        ball.CFrame = hrp.CFrame * CFrame.new(0, -1, -2.5)
        ball.AssemblyLinearVelocity = Vector3.zero
        print("[The Hub]: Ball locked cleanly at your feet.")
    end
end

-- ==========================================
-- 📱 MOBILE DYNAMIC INTERFACE INJECTION HOOK
-- ==========================================
if UserInputService.TouchEnabled or not UserInputService.KeyboardEnabled then
    print("[The Hub]: Mobile touch input verified. Deploying hotpad overlay container...")
    
    local mobileBox = createUIElement("Frame", {
        Name = "MobileOverlay", Parent = screenGui, Size = UDim2.new(0, 110, 0, 165),
        Position = UDim2.new(0, 10, 0.35, 0), BackgroundTransparency = 1
    })
    
    local closePad = createUIElement("TextButton", {
        Parent = mobileBox, Text = "Toggle Menu", Size = UDim2.new(1, 0, 0, 48),
        Position = UDim2.new(0, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13, Font = Enum.Font.SourceSansBold
    })
    closePad.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
    
    local pullPad = createUIElement("TextButton", {
        Parent = mobileBox, Text = "Bring Ball [B]", Size = UDim2.new(1, 0, 0, 48),
        Position = UDim2.new(0, 0, 0, 55), BackgroundColor3 = Color3.fromRGB(0, 120, 210),
        TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13, Font = Enum.Font.SourceSansBold
    })
    pullPad.MouseButton1Click:Connect(triggerBringBallToFeet)
    
    local swapPad = createUIElement("TextButton", {
        Parent = mobileBox, Text = "Swap Side [M]", Size = UDim2.new(1, 0, 0, 48),
        Position = UDim2.new(0, 0, 0, 110), BackgroundColor3 = Color3.fromRGB(160, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13, Font = Enum.Font.SourceSansBold
    })
    swapPad.MouseButton1Click:Connect(triggerHalftimeSideSwap)
end

-- ==========================================
-- 💻 PC HARDWARE INPUT BACKWARDS LINKAGES
-- ==========================================
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    elseif input.KeyCode == Enum.KeyCode.M then
        triggerHalftimeSideSwap()
    elseif input.KeyCode == Enum.KeyCode.B then
        triggerBringBallToFeet()
    end
end)

-- ==========================================
-- 🛰️ MASTER FRAME CALCULATION RESOLVER LOOP
-- ==========================================
RunService.PreSimulation:Connect(function()
    local ball = getActiveFootball()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if ball and hrp then
        local distance = (ball.Position - hrp.Position).Magnitude
        
        -- [[ MODULE 1: INVISIBLE 40-STUD HITBOX REACH EXPANDER ]]
        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg")
        if toggles.Reach and rightLeg then
            rightLeg.Size = Vector3.new(40, 6, 40)
            rightLeg.CanCollide = false
            rightLeg.CanTouch = true
            rightLeg.Transparency = 1
        elseif rightLeg and rightLeg.Size.X > 5 then
            rightLeg.Size = Vector3.new(2, 2, 1)
        end
        
        -- [[ MODULE 2: KINETIC TARGET MULTI-AXIS AIMBOT ]]
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
        
        -- [[ MODULE 3: Turf Low Ground Shots Override ]]
        if toggles.GroundShots and distance <= 7 and not toggles.Aimbot then
            local heading = hrp.CFrame.LookVector
            ball.AssemblyLinearVelocity = Vector3.new(heading.X * 132, -5, heading.Z * 132)
        end
        
        -- [[ MODULE 4: SNEAKY POKERS TACKLE STEALER ]]
        if toggles.Pokers and distance < 12 and distance > 4 and not executingTrick then
            ball.CFrame = hrp.CFrame + Vector3.new(0, -1, 3)
            ball.AssemblyLinearVelocity = hrp.CFrame.LookVector * 82
        end
        
        -- [[ MODULE 5: BALL GLUE PROXIMITY DRIBBLE ]]
        if toggles.Dribble and distance < 15 and not toggles.Reach and not executingTrick and not toggles.AutoJuggle then
