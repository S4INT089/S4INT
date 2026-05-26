
fpsLabel.TextScaled = true
fpsLabel.TextColor3 = Color3.fromRGB(0,255,120)
fpsLabel.Parent = frame

local holder = Instance.new("ScrollingFrame")
holder.Size = UDim2.new(1,-20,1,-90)
holder.Position = UDim2.new(0,10,0,80)
holder.CanvasSize = UDim2.new(0,0,0,1800)
holder.ScrollBarThickness = 4
holder.BackgroundTransparency = 1
holder.BorderSizePixel = 0
holder.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,14)
layout.Parent = holder

--====================================================
-- FUNCTIONS
--====================================================

local function createButton(text,color)

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1,0,0,55)
	button.BackgroundColor3 = color
	button.Text = text
	button.Font = Enum.Font.GothamBold
	button.TextScaled = true
	button.TextColor3 = Color3.new(1,1,1)
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Parent = holder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,18)
	corner.Parent = button

	button.MouseEnter:Connect(function()
		TweenService:Create(button,TweenInfo.new(0.15),{
			BackgroundTransparency = 0.15
		}):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(button,TweenInfo.new(0.15),{
			BackgroundTransparency = 0
		}):Play()
	end)

	return button
end

local function createBox(text)

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1,0,0,50)
	box.BackgroundColor3 = Color3.fromRGB(18,18,18)
	box.PlaceholderText = text
	box.Text = ""
	box.Font = Enum.Font.Gotham
	box.TextScaled = true
	box.TextColor3 = Color3.new(1,1,1)
	box.Parent = holder

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,18)
	corner.Parent = box

	return box
end

--====================================================
-- FPS COUNTER
--====================================================

local frames = 0
local last = tick()

RunService.RenderStepped:Connect(function()
	frames += 1

	if tick() - last >= 1 then
		fpsLabel.Text = "FPS: "..frames
		frames = 0
		last = tick()
	end
end)

--====================================================
-- WALKSPEED
--====================================================

local speedBox = createBox("ENTER WALKSPEED")
local speedBtn = createButton("SET WALKSPEED", Color3.fromRGB(0,120,255))

speedBtn.MouseButton1Click:Connect(function()
	local n = tonumber(speedBox.Text)
	if n then
		humanoid.WalkSpeed = n
	end
end)

--====================================================
-- JUMPPOWER
--====================================================

local jumpBox = createBox("ENTER JUMPPOWER")
local jumpBtn = createButton("SET JUMPPOWER", Color3.fromRGB(170,0,255))

jumpBtn.MouseButton1Click:Connect(function()
	local n = tonumber(jumpBox.Text)
	if n then
		humanoid.JumpPower = n
	end
end)

--====================================================
-- NOCLIP
--====================================================

local noclip = false
local noclipBtn = createButton("NOCLIP : OFF", Color3.fromRGB(50,50,50))

noclipBtn.MouseButton1Click:Connect(function()
	
	noclip = not noclip

	if noclip then
		noclipBtn.Text = "NOCLIP : ON"
		noclipBtn.BackgroundColor3 = Color3.fromRGB(0,255,120)
	else
		noclipBtn.Text = "NOCLIP : OFF"
		noclipBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	end
end)

RunService.Stepped:Connect(function()
	if noclip and character then
		for _,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

--====================================================
-- FLY
--====================================================

local flying = false
local flySpeed = 80

local flyBtn = createButton("FLY : OFF", Color3.fromRGB(50,50,50))
local flyBox = createBox("ENTER FLY SPEED")

local bv
local bg

flyBtn.MouseButton1Click:Connect(function()

	flying = not flying

	local root = character:WaitForChild("HumanoidRootPart")

	if flying then

		flyBtn.Text = "FLY : ON"
		flyBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)

		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(999999,999999,999999)
		bv.Parent = root

		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(999999,999999,999999)
		bg.Parent = root

		humanoid.PlatformStand = true

	else

		flyBtn.Text = "FLY : OFF"
		flyBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)

		if bv then bv:Destroy() end
		if bg then bg:Destroy() end

		humanoid.PlatformStand = false
	end
end)

RunService.RenderStepped:Connect(function()

	if flying and bv and bg then

		local cam = workspace.CurrentCamera
		local move = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then
			move += cam.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.S) then
			move -= cam.CFrame.LookVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.A) then
			move -= cam.CFrame.RightVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.D) then
			move += cam.CFrame.RightVector
		end

		if UIS:IsKeyDown(Enum.KeyCode.Space) then
			move += Vector3.new(0,1,0)
		end

		local newSpeed = tonumber(flyBox.Text)

		if newSpeed then
			flySpeed = newSpeed
		end

		bv.Velocity = move * flySpeed
		bg.CFrame = cam.CFrame
	end
end)

--====================================================
-- SPINBOT
--====================================================

local spin = false
local spinSpeed = 50

local spinBtn = createButton("SPINBOT : OFF", Color3.fromRGB(50,50,50))
local spinBox = createBox("ENTER SPIN SPEED")

spinBtn.MouseButton1Click:Connect(function()

	spin = not spin

	if spin then
		spinBtn.Text = "SPINBOT : ON"
		spinBtn.BackgroundColor3 = Color3.fromRGB(255,0,120)
	else
		spinBtn.Text = "SPINBOT : OFF"
		spinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	end
end)

RunService.RenderStepped:Connect(function()

	if spin and character then

		local root = character:FindFirstChild("HumanoidRootPart")

		if root then

			local newSpin = tonumber(spinBox.Text)

			if newSpin then
				spinSpeed = newSpin
			end

			root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
		end
	end
end)

--====================================================
-- GUI TOGGLE
--====================================================

local visible = true

UIS.InputBegan:Connect(function(input,gpe)
	if gpe then return end

	if input.KeyCode == Enum.KeyCode.RightControl then
		visible = not visible
		frame.Visible = visible
	end
end)
--====================================================
-- ESP
--====================================================

local esp = false

local espBtn = createButton("ESP : OFF", Color3.fromRGB(50,50,50))

espBtn.MouseButton1Click:Connect(function()

	esp = not esp

	if esp then

		espBtn.Text = "ESP : ON"
		espBtn.BackgroundColor3 = Color3.fromRGB(170,0,255)

		for _,plr in pairs(Players:GetPlayers()) do

			if plr ~= player and plr.Character then

				if not plr.Character:FindFirstChild("Highlight") then

					local hl = Instance.new("Highlight")
					hl.FillColor = Color3.fromRGB(170,0,255)
					hl.OutlineColor = Color3.new(1,1,1)
					hl.Parent = plr.Character
				end
			end
		end

	else

		espBtn.Text = "ESP : OFF"
		espBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)

		for _,plr in pairs(Players:GetPlayers()) do

			if plr.Character then

				local hl = plr.Character:FindFirstChild("Highlight")

				if hl then
					hl:Destroy()
				end
			end
		end
	end
end)
print("NICKS UNIVERSAL GUI V7 LOADED")
--====================================================
-- RESET BUTTON
--====================================================

local resetBtn = createButton("RESET ALL", Color3.fromRGB(120,0,0))

resetBtn.MouseButton1Click:Connect(function()

	-- RESET WALKSPEED
	humanoid.WalkSpeed = 16

	-- RESET JUMPPOWER
	humanoid.JumpPower = 50

	-- RESET FLY
	flying = false

	if bv then
		bv:Destroy()
	end

	if bg then
		bg:Destroy()
	end

	humanoid.PlatformStand = false

	-- RESET BUTTON COLORS
	flyBtn.Text = "FLY : OFF"
	flyBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)

	-- RESET ESP
	esp = false

	if espBtn then
		espBtn.Text = "ESP : OFF"
		espBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	end

	for _,plr in pairs(Players:GetPlayers()) do

		if plr ~= player and plr.Character then

			local hl = plr.Character:FindFirstChild("Highlight")

			if hl then
				hl:Destroy()
			end
		end
	end
end)


--====================================================
-- INFINITE JUMP
--====================================================

local infJump = false

local infJumpBtn = createButton("INFINITE JUMP : OFF", Color3.fromRGB(50,50,50))

infJumpBtn.MouseButton1Click:Connect(function()

	infJump = not infJump

	if infJump then

		infJumpBtn.Text = "INFINITE JUMP : ON"
		infJumpBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)

	else

		infJumpBtn.Text = "INFINITE JUMP : OFF"
		infJumpBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)

	end
end)

UIS.JumpRequest:Connect(function()

	if infJump then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)


--====================================================
-- NOTIFICATION
--====================================================

local notification = Instance.new("TextLabel")
notification.Size = UDim2.new(0,320,0,50)
notification.Position = UDim2.new(1,-340,1,-70)
notification.BackgroundColor3 = Color3.fromRGB(15,15,15)
notification.Text = "NICKS GUI LOADED SUCCESSFULLY"
notification.Font = Enum.Font.GothamBold
notification.TextScaled = true
notification.TextColor3 = Color3.new(1,1,1)
notification.BorderSizePixel = 0
notification.Parent = gui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0,16)
notifCorner.Parent = notification

local notifStroke = Instance.new("UIStroke")
notifStroke.Color = Color3.fromRGB(170,0,255)
notifStroke.Thickness = 2
notifStroke.Parent = notification

TweenService:Create(notification,TweenInfo.new(0.5),{
	Position = UDim2.new(1,-340,1,-120)
}):Play()

task.delay(4,function()

	TweenService:Create(notification,TweenInfo.new(0.5),{
		Position = UDim2.new(1,400,1,-120)
	}):Play()

end)

--====================================================
-- RAINBOW BORDER
--====================================================

task.spawn(function()

	while true do

		for i = 0,1,0.01 do

			if stroke then
				stroke.Color = Color3.fromHSV(i,1,1)
			end

			RunService.RenderStepped:Wait()

		end
	end
end)
--====================================================
-- CLICK TELEPORT
--====================================================

local clickTP = false

local clickTPBtn = createButton("CLICK TP : OFF", Color3.fromRGB(50,50,50))

clickTPBtn.MouseButton1Click:Connect(function()

	clickTP = not clickTP

	if clickTP then

		clickTPBtn.Text = "CLICK TP : ON"
		clickTPBtn.BackgroundColor3 = Color3.fromRGB(0,255,120)

	else

		clickTPBtn.Text = "CLICK TP : OFF"
		clickTPBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)

	end
end)

local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()

	if clickTP then

		local root = character:FindFirstChild("HumanoidRootPart")

		if root then
			root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,5,0))
		end
	end
end)

--====================================================
-- INTRO ANIMATION
--====================================================

local intro = Instance.new("TextLabel")
intro.Size = UDim2.new(1,0,1,0)
intro.BackgroundColor3 = Color3.fromRGB(0,0,0)
intro.Text = "NICKS UNIVERSAL GUI"
intro.Font = Enum.Font.GothamBlack
intro.TextScaled = true
intro.TextColor3 = Color3.new(1,1,1)
intro.Parent = gui

TweenService:Create(intro,TweenInfo.new(2),{
	TextTransparency = 1,
	BackgroundTransparency = 1
}):Play()

task.delay(2,function()
	intro:Destroy()
end)

--====================================================
-- SCRIPT HUB
--====================================================

local scriptHubTitle = Instance.new("TextLabel")
scriptHubTitle.Size = UDim2.new(1,0,0,45)
scriptHubTitle.BackgroundTransparency = 1
scriptHubTitle.Text = "SCRIPT HUB"
scriptHubTitle.Font = Enum.Font.GothamBlack
scriptHubTitle.TextScaled = true
scriptHubTitle.TextColor3 = Color3.fromRGB(170,0,255)
scriptHubTitle.Parent = holder

local fakeScript1 = createButton("BLOX FRUITS SCRIPT", Color3.fromRGB(25,25,25))
local fakeScript2 = createButton("MM2 SCRIPT", Color3.fromRGB(25,25,25))
local fakeScript3 = createButton("ARSENAL SCRIPT", Color3.fromRGB(25,25,25))

fakeScript1.MouseButton1Click:Connect(function()
	print("Blox Fruits Script Loaded")
end)

fakeScript2.MouseButton1Click:Connect(function()
	print("MM2 Script Loaded")
end)

fakeScript3.MouseButton1Click:Connect(function()
	print("Arsenal Script Loaded")
end)

--====================================================
-- AIMLOCK
--====================================================

local aimlock = false

local aimBtn = createButton("AIMLOCK : OFF", Color3.fromRGB(50,50,50))

aimBtn.MouseButton1Click:Connect(function()

	aimlock = not aimlock

	if aimlock then

		aimBtn.Text = "AIMLOCK : ON"
		aimBtn.BackgroundColor3 = Color3.fromRGB(255,0,120)

	else

		aimBtn.Text = "AIMLOCK : OFF"
		aimBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)

	end
end)

RunService.RenderStepped:Connect(function()

	if aimlock then

		local closestPlayer = nil
		local shortestDistance = math.huge

		for _,plr in pairs(Players:GetPlayers()) do

			if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then

				local distance = (plr.Character.Head.Position - character.Head.Position).Magnitude

				if distance < shortestDistance then

					shortestDistance = distance
					closestPlayer = plr

				end
			end
		end

		if closestPlayer and closestPlayer.Character then

			workspace.CurrentCamera.CFrame = CFrame.new(
				workspace.CurrentCamera.CFrame.Position,
				closestPlayer.Character.Head.Position
			)

		end
	end
end)

--====================================================
-- SILENT AIM
--====================================================

local silentAim = false

local silentBtn = createButton("SILENT AIM : OFF", Color3.fromRGB(50,50,50))

silentBtn.MouseButton1Click:Connect(function()

	silentAim = not silentAim

	if silentAim then

		silentBtn.Text = "SILENT AIM : ON"
		silentBtn.BackgroundColor3 = Color3.fromRGB(255,120,0)

	else

		silentBtn.Text = "SILENT AIM : OFF"
		silentBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)

	end
end)

print("PREMIUM FEATURES LOADED")
