# Delta Cheat Menu for Mobile

Fly, High Jump, Invisible
## Executors
- Delta
- Arceus X

  -- Mirac Mobile Menu  

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local cam = workspace.CurrentCamera

-- STATES
local flying = false
local highJump = false
local invis = false

local oldJump = hum.JumpPower
local gyro, vel, flyConn

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,180)
frame.Position = UDim2.new(0.05,0,0.35,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true

local function btn(text,y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1,0,0,45)
    b.Position = UDim2.new(0,0,0,y)
    b.Text = text
    b.TextScaled = true
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    return b
end

local flyBtn = btn("FLY: OFF", 0)
local jumpBtn = btn("HIGHJUMP: OFF", 50)
local invisBtn = btn("INVIS: OFF", 100)
local closeBtn = btn("CLOSE", 150)
closeBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)

-- FLY (MOBILE)
local function startFly()
    flying = true
    gyro = Instance.new("BodyGyro", hrp)
    gyro.P = 9e4
    gyro.MaxTorque = Vector3.new(9e9,9e9,9e9)

    vel = Instance.new("BodyVelocity", hrp)
    vel.MaxForce = Vector3.new(9e9,9e9,9e9)

    flyConn = RunService.RenderStepped:Connect(function()
        if not flying then return end
        gyro.CFrame = cam.CFrame
        vel.Velocity = hum.MoveDirection * 80 + Vector3.new(0,30,0)
    end)
end

local function stopFly()
    flying = false
    if flyConn then flyConn:Disconnect() end
    if gyro then gyro:Destroy() end
    if vel then vel:Destroy() end
end

flyBtn.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
        flyBtn.Text = "FLY: OFF"
    else
        startFly()
        flyBtn.Text = "FLY: ON"
    end
end)

-- HIGH JUMP
jumpBtn.MouseButton1Click:Connect(function()
    if highJump then
        hum.JumpPower = oldJump
        highJump = false
        jumpBtn.Text = "HIGHJUMP: OFF"
    else
        hum.JumpPower = 150
        highJump = true
        jumpBtn.Text = "HIGHJUMP: ON"
    end
end)

-- INVISIBLE
invisBtn.MouseButton1Click:Connect(function()
    invis = not invis
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = invis and 1 or 0
        end
    end
    invisBtn.Text = invis and "INVIS: ON" or "INVIS: OFF"
end)

-- CLOSE
closeBtn.MouseButton1Click:Connect(function()
    stopFly()
    hum.JumpPower = oldJump
    gui:Destroy()
end)
