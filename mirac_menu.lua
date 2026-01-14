-- MIRAC SIMPLE CHEAT MENU (MOBILE)
-- Fly / High Jump / Invisible

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MiracMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.35, 0.4)
frame.Position = UDim2.fromScale(0.32, 0.3)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0,12)

local function makeButton(text, y)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.fromScale(0.8, 0.15)
	btn.Position = UDim2.fromScale(0.1, y)
	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.TextScaled = true
	Instance.new("UICorner", btn)
	return btn
end

local flyBtn = makeButton("FLY : OFF", 0.1)
local jumpBtn = makeButton("HIGH JUMP : OFF", 0.3)
local invisBtn = makeButton("INVISIBLE : OFF", 0.5)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.fromScale(0.15,0.15)
closeBtn.Position = UDim2.fromScale(0.82,0.02)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
closeBtn.TextScaled = true
Instance.new("UICorner", closeBtn)

-- FLY
local flying = false
local bv, bg

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	flyBtn.Text = flying and "FLY : ON" or "FLY : OFF"

	if flying then
		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(1e5,1e5,1e5)
		bv.Velocity = Vector3.zero

		bg = Instance.new("BodyGyro", hrp)
		bg.MaxTorque = Vector3.new(1e5,1e5,1e5)
		bg.CFrame = hrp.CFrame

		RunService.RenderStepped:Connect(function()
			if flying then
				bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
				bg.CFrame = workspace.CurrentCamera.CFrame
			end
		end)
	else
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
	end
end)

-- HIGH JUMP
local highJump = false
jumpBtn.MouseButton1Click:Connect(function()
	highJump = not highJump
	jumpBtn.Text = highJump and "HIGH JUMP : ON" or "HIGH JUMP : OFF"
	humanoid.JumpPower = highJump and 120 or 50
end)

-- INVISIBLE
local invisible = false
invisBtn.MouseButton1Click:Connect(function()
	invisible = not invisible
	invisBtn.Text = invisible and "INVISIBLE : ON" or "INVISIBLE : OFF"

	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = invisible and 1 or 0
			if v.Name ~= "HumanoidRootPart" then
				v.CanCollide = not invisible
			end
		end
	end
end)

-- CLOSE
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
