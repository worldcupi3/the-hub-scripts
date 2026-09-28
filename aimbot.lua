-- [[ THE HUB | UPGRADED KINETIC AIMBOT & HIGH-VOLLEY BANGER ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.AimbotActive = false
_G.CurveActive = false
_G.EnemyTargetNet = "GoalB"

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
    
    if ball and hrp and _G.AimbotActive then
        local distance = (ball.Position - hrp.Position).Magnitude
        if distance <= 7 then
            local enemyNet = workspace:FindFirstChild(_G.EnemyTargetNet)
            if enemyNet then
                local vectorBase = (enemyNet.Position - ball.Position).Unit
                local targetPower = 145 -- Standard shot power
                
                -- [[ 🔥 HIGH-VOLLEY BANGER CORE DETECTOR 🔥 ]]
                -- If ball is floating high in the air from a Nero lob, blast it with massive top-shelf force!
                if ball.Position.Y > 5.5 then
                    targetPower = 185 
                    vectorBase = ((enemyNet.Position + Vector3.new(0, 4.2, 0)) - ball.Position).Unit
                end
                
                if _G.CurveActive then 
                    vectorBase = vectorBase + Camera.CFrame.RightVector * 0.28 
                end
                
                ball.AssemblyLinearVelocity = vectorBase * targetPower
            end
        end
    end
end)
print("[The Hub]: Aimbot & Volley Banger module fully upgraded.")
