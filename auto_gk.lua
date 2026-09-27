-- [[ THE HUB | OFFICIAL STANDALONE PREDICTIVE GK ENGINE ]]
print("[The Hub]: Initializing Real-Time Trajectory Projection Core...")

-- Global Core Synchronization Toggles
_G.PerfectGK = true          -- Active by default to guard your net immediately
_G.DefendingGoalSide = "GoalA" -- CHANGE TO "GoalA" OR "GoalB" BASED ON YOUR TEAM SIDE
_G.DefensiveReachRadius = 38 -- Repulsion bubble range to clear out near-post shots

local executingTrick = false 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

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

-- [B] Key: Instant Pull and Drop to Feet
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
                ball.AssemblyLinearVelocity = Vector3.zero
                print("[The Hub]: Ball dropped cleanly at your feet.")
            end
        end)
    end
end)

-- [G] Key: Toggle Perfect Predictive GK Wall
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.G then
        _G.PerfectGK = not _G.PerfectGK
        print("-> [The Hub] Perfect GK Wall State:", _G.PerfectGK)
    end
end)

-- [M] Key: Halftime Side-Swap Core
UserInputService.InputBegan:Connect(function(input, chatActive)
    if chatActive then return end
    if input.KeyCode == Enum.KeyCode.M then
        _G.DefendingGoalSide = (_G.DefendingGoalSide == "GoalA") and "GoalB" or "GoalA"
        print("-> [The Hub] Halftime Swap! Active defending target:", _G.DefendingGoalSide)
    end
end)

-- ==========================================
-- 🛰️ LIVE PHYSICS INTERCEPTION DAEMON
-- ==========================================

task.spawn(function()
    while true do
        RunService.PreSimulation:Wait()
        if _G.PerfectGK then
            pcall(function()
                local ball = getActiveBall()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local net = workspace:FindFirstChild(_G.DefendingGoalSide)
                
                if ball and hrp and net then
                    local ballToGoalDist = (ball.Position - net.Position).Magnitude
                    
                    if ballToGoalDist < 125 then
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        
                        -- Extracting live physics vectors from the server layer
                        local currentPos = ball.Position
                        local currentVel = ball.AssemblyLinearVelocity
                        
                        local interceptX = currentPos.X
                        local interceptY = currentPos.Y
                        
                        -- Run continuous trajectory look-ahead loop if the ball is moving fast
                        if currentVel.Magnitude > 5 then
                            local virtualPos = currentPos
                            local virtualVel = currentVel
                            local timeStep = 0.033 
                            
                            local gravityForce = Vector3.new(0, -28, 0) 
                            local airResistance = 0.985 
                            
                            -- Step path forward across 45 frames to anticipate curves and chips
                            for i = 1, 45 do
                                if (net.Position.Z > 0 and virtualPos.Z >= net.Position.Z) or (net.Position.Z < 0 and virtualPos.Z <= net.Position.Z) then
                                    interceptX = virtualPos.X
                                    interceptY = virtualPos.Y
                                    break
                                end
                                virtualVel = (virtualVel + (gravityForce * timeStep)) * airResistance
                                virtualPos = virtualPos + (virtualVel * timeStep)
                            end
                            
                            -- Clamp positioning safely between the inner post dimensions
                            interceptX = math.clamp(interceptX, net.Position.X - 22, net.Position.X + 22)
                            interceptY = math.clamp(interceptY, net.Position.Y - 1, net.Position.Y + 9) -- Intercepts crossbars perfectly
                        else
                            -- Stationary floor tracking if ball loses rolling velocity
                            interceptX = math.clamp(currentPos.X, net.Position.X - 22, net.Position.X + 22)
                            interceptY = math.clamp(currentPos.Y, net.Position.Y - 1, net.Position.Y + 6)
                        end
                        
                        -- Instant client alignment frame update
                        hrp.CFrame = CFrame.new(interceptX, interceptY, net.Position.Z + (net.Position.Z > 0 and -1.5 or 1.5))
                        
                        -- Repulsion Deflection Vector: Automatically clears the shot out of danger zone
                        if (ball.Position - hrp.Position).Magnitude < _G.DefensiveReachRadius then
                            ball.AssemblyLinearVelocity = (net.CFrame.LookVector * -155) + Vector3.new(0, 24, 0)
                        end
                    else
                        -- Idle: Return cleanly to center post when ball is away
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        hrp.CFrame = CFrame.new(net.Position.X, net.Position.Y + 1, net.Position.Z + (net.Position.Z > 0 and -1.5 or 1.5))
                    end
                end
            end)
        end
    end
end)

print("[The Hub]: Standalone Goalkeeper Engine Matrix Successfully Online.");
