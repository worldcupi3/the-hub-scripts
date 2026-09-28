-- [[ MODULE: CURVE AIMBOT & POKERS DRIBBLE CORE ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.CurveAimbotActive = false
_G.SneakyDribbleActive = false
_G.EnemyTargetNet = "GoalB"

local function getBall()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():match("ball") or obj.Name:lower():match("hitbox") then
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
        
        -- Curve Aimbot Overwrite
        if _G.CurveAimbotActive and distance <= 7 then
            local enemyNet = workspace:FindFirstChild(_G.EnemyTargetNet)
            if enemyNet then
                local vectorBase = (enemyNet.Position - ball.Position).Unit
                -- Mixes side-camera vectors to generate the un-saveable curve arc
                local curveForce = vectorBase + Camera.CFrame.RightVector * 0.32
                ball.AssemblyLinearVelocity = curveForce * 150
            end
        end
        
        -- Sneaky Dribble Magnet
        if _G.SneakyDribbleActive and distance < 14 and not _G.ReachActive then
            ball.CFrame = hrp.CFrame * CFrame.new(0, -2, -2.8)
            ball.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity
        end
    end
end)
print("[The Hub]: Curve & Poker mechanics online.")
