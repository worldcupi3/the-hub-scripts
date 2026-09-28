-- [[ MODULE: GROUND SHOTS & EXTENDED REACH MATRIX ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

_G.GroundShotsActive = false
_G.GroundReachActive = false

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
        
        -- Ground Shots Force
        if _G.GroundShotsActive and distance <= 7 then
            local heading = hrp.CFrame.LookVector
            -- Keeps the ball pinned low to the turf with negative Y force
            ball.AssemblyLinearVelocity = Vector3.new(heading.X * 135, -8, heading.Z * 135)
        end
        
        -- Ground Shots Reach Extender
        local rightLeg = char:FindFirstChild("Right Leg") or char:FindFirstChild("RightLowerLeg")
        if _G.GroundReachActive and rightLeg then
            rightLeg.Size = Vector3.new(45, 5, 45)
            rightLeg.CanCollide = false
            rightLeg.CanTouch = true
            rightLeg.Transparency = 1
        elseif rightLeg and rightLeg.Size.X > 5 then
            rightLeg.Size = Vector3.new(2, 2, 1)
        end
    end
end)
print("[The Hub]: Ground shots and reach matrices online.")
