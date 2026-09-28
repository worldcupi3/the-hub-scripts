-- [[ THE HUB | SHOTS, REACH, AND HIGH-LOB NERO MATRIX ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

_G.ReachActive = false
_G.NeroActive = false
_G.SneakyDribbleActive = false
_G.GroundShotsActive = false
local executingTrick = false

local function getBall()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():match("ball") or obj.Name:lower():match("hitbox") or obj.Name:lower():match("football") then
            if obj:IsA("BasePart") and not obj.Anchored then return obj end
        end
    end
    return nil
end

RunService.PreSimulation:Connect(function()
    local ball = getBall()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if ball and hrp then
        local distance = (ball.Position - hrp.Position).Magnitude
        
        -- Proximity Invisible Reach
        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg")
        if _G.ReachActive and rightLeg then
            rightLeg.Size = Vector3.new(45, 5, 45) rightLeg.CanCollide = false rightLeg.CanTouch = true rightLeg.Transparency = 1
        elseif rightLeg and rightLeg.Size.X > 5 then
            rightLeg.Size = Vector3.new(2, 2, 1)
        end
        
        -- [[ 🔥 FIXED HIGH-LOB AUTO NERO RAINBOW FLICK 🔥 ]]
        if _G.NeroActive and distance < 5 and ball.AssemblyLinearVelocity.Y < 5 and not executingTrick then
            executingTrick = true
            hrp.AssemblyLinearVelocity = Vector3.zero
            ball.AssemblyLinearVelocity = Vector3.zero
            ball.CFrame = hrp.CFrame * CFrame.new(0, -1.2, -1.8)
            ball.AssemblyLinearVelocity = Vector3.new(0, 78, 0) -- Pure upward launch thrust
            
            task.delay(0.08, function()
                pcall(function()
                    if ball and hrp then
                        local heading = hrp.CFrame.LookVector
                        ball.AssemblyLinearVelocity = Vector3.new(heading.X * 42, 45, heading.Z * 42)
                    end
                end)
            end)
            task.delay(0.45, function() executingTrick = false end)
        end
        
        -- Sneaky Proximity Dribble Magnet
        if _G.SneakyDribbleActive and distance < 14 and not _G.ReachActive then
            ball.CFrame = hrp.CFrame * CFrame.new(0, -2, -2.8)
            ball.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity
        end
        
        -- Turf Low Ground Shots Override
        if _G.GroundShotsActive and distance <= 7 and not _G.NeroActive then
            local heading = hrp.CFrame.LookVector
            ball.AssemblyLinearVelocity = Vector3.new(heading.X * 135, -8, heading.Z * 135)
        end
    end
end)
print("[The Hub]: Expanded skills and high-lob matrix successfully mapped.")
