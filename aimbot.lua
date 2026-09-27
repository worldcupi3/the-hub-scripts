-- [[ THE HUB | OFFICIAL STANDALONE AIMBOT ENGINE ]]
print("[The Hub]: Initializing Kinetic Target Aimbot Core...")

-- Global Core Synchronization Toggles
_G.TargetAimbotActive = true
_G.TargetGoalSide = "GoalB" -- Set this to the ENEMY goal name ("GoalA" or "GoalB")
_G.AimbotPower = 145        -- Velocity power scale for shots
_G.ActivationRadius = 7     -- Distance from player to ball to trigger the shot override

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getActiveBall()
    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:match("ball") or name:match("hitbox") or name:match("body") or name:match("football") then
            if obj:IsA("BasePart") and not obj.Anchored and obj.CanCollide == true then
                return obj
            elseif obj:IsA("Model") then
                local centerPart = obj:FindFirstChild("body") or obj:FindFirstChild("hitbox") or obj:FindFirstChildOfClass("BasePart")
                if centerPart and not centerPart.Anchored then return centerPart end
            end
        end
    end
    return nil
end

-- ==========================================
-- 🎮 PHYSICAL HARDWARE HOTKEY INPUTS
-- ==========================================

-- [K] Key: Toggle Aimbot State
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.K then
        _G.TargetAimbotActive = not _G.TargetAimbotActive
        print("-> [The Hub] Target Aimbot State:", _G.TargetAimbotActive)
    end
end)

-- [M] Key: Halftime Side-Swap Core (Fills enemy target target goal side)
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.M then
        _G.TargetGoalSide = (_G.TargetGoalSide == "GoalA") and "GoalB" or "GoalA"
        print("-> [The Hub] Halftime Swap! Active enemy target net:", _G.TargetGoalSide)
    end
end)

-- ==========================================
-- 🛰️ LIVE KINETIC VELOCITY OVERWRITE HOOK
-- ==========================================
task.spawn(function()
    while true do
        RunService.PreSimulation:Wait()
        if _G.TargetAimbotActive then
            pcall(function()
                local ball = getActiveBall()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local enemyNet = workspace:FindFirstChild(_G.TargetGoalSide)
                
                if ball and hrp and enemyNet then
                    local distanceToBall = (ball.Position - hrp.Position).Magnitude
                    
                    -- Intercepts ball physics whenever you get close enough to "touch" or kick it
                    if distanceToBall <= _G.ActivationRadius then
                        -- Calculates the absolute directional vector from the ball to the enemy net center
                        local netTargetPosition = enemyNet.Position + Vector3.new(0, 3, 0) -- Targets the center height of the net
                        local targetDirection = (netTargetPosition - ball.Position).Unit
                        
                        -- Force overwrite on velocity to steer it exactly into the target goal slot
                        ball.AssemblyLinearVelocity = (targetDirection * _G.AimbotPower)
                    end
                end
            end)
        end
    end
end)

print("[The Hub]: Aimbot Engine Matrix Successfully Online.");
