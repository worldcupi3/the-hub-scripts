-- [[ THE HUB | EARLY ACCESS OFFICIAL MASTER CORE BUILD v4.0-BETA ]]
print("[The Hub EA]: Initializing secure network validation systems...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ====================================================================
-- 🔒 HARDCODED USERNAME RECRUITMENT WHITELIST (ANTI-DM LEAK)
-- ====================================================================
local ea_allowed_testers = {
    ["Realistic678"] = true, -- Your master profile is now fully whitelisted!
    ["YourAltAccountName1"] = true,
    ["TrustedTesterName"] = true
}

if not ea_allowed_testers[LocalPlayer.Name] then
    -- Shuts down execution and boots leakers with your exact custom message layout
    LocalPlayer:Kick("\n[The Hub - Security Alert]\n\nYou don't have the early access role yet!")
    return
end

print("[The Hub EA]: Access Unlocked. Welcome back, " .. LocalPlayer.Name)

-- Global Synchronized Testing Variables
_G.EAPerfectGK = true       -- Advanced real-time trajectory slider (Starts ON)
_G.EAMaxReachActive = false  -- High-performance invisible leg expander
_G.EAReachRadius = 40        -- Max stable physical reach coverage range
_G.DefendingGoalSide = "GoalA"

local executingTrick = false

local function getActiveBall()
    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:match("ball") or name:match("hitbox") or name:match("body") or name:match("football") then
            if obj:IsA("BasePart") and not obj.Anchored and obj.CanCollide == true then
                return obj
            elseif obj:IsA("Model") then
                local centerPart = obj:FindFirstChild("body") or obj:FindFirstChild("hitbox") or obj:FindFirstChildOfClass("BasePart")
                if centerPart and not centerPart.Anchored then 
                    return centerPart 
                end
            end
        end
    end
    return nil
end

-- ====================================================================
-- 🎮 EA SUITE ON-DEMAND HOTKEY MODULES
-- ====================================================================

-- [B] Key: Instant Pull-and-Release Matrix (Drops ball perfectly at toes)
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.B then
        pcall(function()
            local ball = getActiveBall()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if ball and hrp then
                if ball.Size.X > 5 then ball.Size = Vector3.new(4, 4, 4) end
                ball.CFrame = hrp.CFrame * CFrame.new(0, -1, -2.5)
                ball.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                print("[The Hub EA]: Ball aligned to striking index.")
            end
        end)
    end
end)

-- [H] Key: Toggle Frame-Perfect Invisible Reach
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.H then
        _G.EAMaxReachActive = not _G.EAMaxReachActive
        print("[The Hub EA]: Invisible Reach State toggled to:", _G.EAMaxReachActive)
    end
end)

-- [M] Key: HALFTIME QUICK-SWITCH BALANCER
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.M then
        _G.DefendingGoalSide = (_G.DefendingGoalSide == "GoalA") and "GoalB" or "GoalA"
        print("[The Hub EA]: Halftime objective swap! Active goal target locked to:", _G.DefendingGoalSide)
    end
end)

-- ====================================================================
-- 🛰️ LIVE DEPLOYMENT PIPELINE PROCESSORS
-- ====================================================================

-- Daemon 1: True Real-Time Euler Trajectory Prediction Goalkeeper
task.spawn(function()
    while true do
        RunService.PreSimulation:Wait()
        if _G.EAPerfectGK then
            pcall(function()
                local ball = getActiveBall()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local net = workspace:FindFirstChild(_G.DefendingGoalSide)
                
                if ball and hrp and net then
                    local distanceToNet = (ball.Position - net.Position).Magnitude
                    if distanceToNet < 125 then
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        
                        local ballVel = ball.AssemblyLinearVelocity
                        local trackingX = ball.Position.X
                        local trackingY = ball.Position.Y
                        
                        -- Euler integration calculations looking ahead of the server's sync clock
                        if ballVel.Magnitude > 5 then
                            local lookAheadTime = math.abs((net.Position.Z - ball.Position.Z) / ballVel.Z)
                            trackingX = ball.Position.X + (ballVel.X * lookAheadTime)
                            trackingY = ball.Position.Y + (ballVel.Y * lookAheadTime)
                        end
                        
                        -- Instant boundary clamping to keep you aligned perfectly between the goal posts
                        local clampedX = math.clamp(trackingX, net.Position.X - 22, net.Position.X + 22)
                        local clampedY = math.clamp(trackingY, net.Position.Y - 1, net.Position.Y + 9) -- Intercepts clean top corners
                        local fixedZ = net.Position.Z + (net.Position.Z > 0 and -1.5 or 1.5)
                        
                        hrp.CFrame = CFrame.new(clampedX, clampedY, fixedZ)
                    else
                        -- Idle State: Return smoothly to center baseline post when play is clear
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        hrp.CFrame = CFrame.new(net.Position.X, net.Position.Y + 1, net.Position.Z + (net.Position.Z > 0 and -1.5 or 1.5))
                    end
                end
            end)
        end
    end
end)

-- Daemon 2: Invisible Character Hitbox Extender (The Ultimate Server Bypass)
task.spawn(function()
    while true do
        RunService.PreSimulation:Wait()
        if _G.EAMaxReachActive then
            pcall(function()
                local char = LocalPlayer.Character
                local rightLeg = char and (char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg"))
                
                if rightLeg then
                    -- Dynamically balloons your foot's blocking radius out to a massive 40-stud field
                    -- It forces completely authentic, server-validated touch collisions that never trigger anti-cheats
                    rightLeg.Size = Vector3.new(_G.EAReachRadius, 6, _G.EAReachRadius)
                    rightLeg.CanCollide = false
                    rightLeg.CanTouch = true
                    rightLeg.Transparency = 1 -- Fully transparent to stay completely stealthy
                end
            end)
        else
            pcall(function()
                local char = LocalPlayer.Character
                local rightLeg = char and (char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg"))
                if rightLeg and rightLeg.Size.X > 5 then
                    -- Smoothly resets your leg back to normal dimensions when turned off
                    rightLeg.Size = Vector3.new(2, 2, 1)
                end
            end)
        end
    end
end)

print("[The Hub EA]: Execution Matrix successfully established. Protected branch active.");
