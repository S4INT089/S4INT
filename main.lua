--// S4INT HUB V1
--// MAIN.LUA

--====================================================
-- SERVICES
--====================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

--====================================================
-- PLAYER
--====================================================

local player = Players.LocalPlayer

if player.PlayerGui:FindFirstChild("S4INT") then
return
end

--====================================================
-- THEME
--====================================================

local Theme = {}

Theme.Background = Color3.fromRGB(10,10,10)
Theme.Secondary = Color3.fromRGB(20,20,20)
Theme.Primary = Color3.fromRGB(170,0,255)
Theme.Accent = Color3.fromRGB(0,170,255)
Theme.Success = Color3.fromRGB(0,255,120)
Theme.Danger = Color3.fromRGB(255,70,70)
Theme.Text = Color3.new(1,1,1)
Theme.Off = Color3.fromRGB(50,50,50)

--====================================================
-- KEY SYSTEM
--====================================================

local ValidKeys = {

```
["S4INT202"] = true,
["X9K2P1Q8"] = true,
["A7M4L9Q2"] = true
```

}

--====================================================
-- GUI
--====================================================

local gui = Instance.new("ScreenGui")
gui.Name = "S4INT"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

--====================================================
-- BLUR
--====================================================

local oldBlur = Lighting:FindFirstChild("S4INTBlur")

if oldBlur then
oldBlur:Destroy()
end

local blur = Instance.new("BlurEffect")
blur.Name = "S4INTBlur"
blur.Size = 12
blur.Parent = Lighting

--====================================================
-- KEY WINDOW
--====================================================

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0,420,0,220)
keyFrame.Position = UDim2.new(0.5,-210,0.5,-110)
keyFrame.BackgroundColor3 = Theme.Background
keyFrame.BorderSizePixel = 0
keyFrame.Parent = gui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0,20)
keyCorner.Parent = keyFrame

local keyStroke = Instance.new("UIStroke")
keyStroke.Thickness = 2
keyStroke.Color = Theme.Primary
keyStroke.Parent = keyFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,60)
title.BackgroundTransparency = 1
title.Text = "S4INT HUB"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Theme.Text
title.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0,50)
keyBox.Position = UDim2.new(0.1,0,0.35,0)
keyBox.PlaceholderText = "ENTER KEY"
keyBox.Text = ""
keyBox.Font = Enum.Font.GothamBold
keyBox.TextScaled = true
keyBox.TextColor3 = Theme.Text
keyBox.BackgroundColor3 = Theme.Secondary
keyBox.BorderSizePixel = 0
keyBox.Parent = keyFrame

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0,14)
keyBoxCorner.Parent = keyBox

local verify = Instance.new("TextButton")
verify.Size = UDim2.new(0.8,0,0,50)
verify.Position = UDim2.new(0.1,0,0.67,0)
verify.Text = "VERIFY"
verify.Font = Enum.Font.GothamBlack
verify.TextScaled = true
verify.TextColor3 = Theme.Text
verify.BackgroundColor3 = Theme.Primary
verify.BorderSizePixel = 0
verify.Parent = keyFrame

local verifyCorner = Instance.new("UICorner")
verifyCorner.CornerRadius = UDim.new(0,14)
verifyCorner.Parent = verify

--====================================================
-- MAIN UI
--====================================================

local main = Instance.new("Frame")
main.Size = UDim2.new(0,780,0,520)
main.Position = UDim2.new(0.5,-390,0.5,-260)
main.BackgroundColor3 = Theme.Background
main.Visible = false
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,22)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Parent = main

--====================================================
-- RGB BORDER
--====================================================

task.spawn(function()

```
while gui.Parent do

    for i = 0,1,0.01 do

        mainStroke.Color = Color3.fromHSV(i,1,1)

        task.wait()

    end
end
```

end)

--====================================================
-- TOPBAR
--====================================================

local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1,0,0,55)
topbar.BackgroundTransparency = 1
topbar.Parent = main

local topText = Instance.new("TextLabel")
topText.Size = UDim2.new(1,0,1,0)
topText.BackgroundTransparency = 1
topText.Text = "S4INT HUB"
topText.Font = Enum.Font.GothamBlack
topText.TextScaled = true
topText.TextColor3 = Theme.Text
topText.Parent = topbar

--====================================================
-- SIDEBAR
--====================================================

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,180,1,-70)
sidebar.Position = UDim2.new(0,10,0,60)
sidebar.BackgroundColor3 = Theme.Secondary
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0,18)
sideCorner.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0,10)
sideLayout.Parent = sidebar

--====================================================
-- CONTENT
--====================================================

local content = Instance.new("Frame")
content.Size = UDim2.new(1,-210,1,-80)
content.Position = UDim2.new(0,200,0,70)
content.BackgroundTransparency = 1
content.Parent = main

--====================================================
-- PAGE SYSTEM
--====================================================

local pages = {}

local function CreatePage(name)

```
local page = Instance.new("ScrollingFrame")

page.Name = name
page.Size = UDim2.new(1,0,1,0)
page.BackgroundTransparency = 1
page.ScrollBarThickness = 4
page.CanvasSize = UDim2.new(0,0,0,0)
page.Visible = false
page.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,12)
layout.Parent = page

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

    page.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 20)

end)

pages[name] = page

return page
```

end

local function CreateTab(name)

```
local button = Instance.new("TextButton")

button.Size = UDim2.new(1,-20,0,45)
button.Position = UDim2.new(0,10,0,0)

button.BackgroundColor3 = Theme.Off
button.Text = name

button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.TextColor3 = Theme.Text

button.BorderSizePixel = 0
button.Parent = sidebar

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,14)
c.Parent = button

local page = CreatePage(name)

button.MouseButton1Click:Connect(function()

    for _,v in pairs(content:GetChildren()) do

        if v:IsA("ScrollingFrame") then
            v.Visible = false
        end
    end

    for _,b in pairs(sidebar:GetChildren()) do

        if b:IsA("TextButton") then
            b.BackgroundColor3 = Theme.Off
        end
    end

    button.BackgroundColor3 = Theme.Primary
    page.Visible = true

end)

return page
```

end

--====================================================
-- COMPONENTS
--====================================================

local function CreateButton(parent,text,color,callback)

```
local button = Instance.new("TextButton")

button.Size = UDim2.new(1,-10,0,50)
button.BackgroundColor3 = color

button.Text = text
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.TextColor3 = Theme.Text

button.BorderSizePixel = 0
button.Parent = parent

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,16)
c.Parent = button

button.MouseButton1Click:Connect(callback)

return button
```

end

--====================================================
-- TABS
--====================================================

local playerTab = CreateTab("PLAYER")
local visualsTab = CreateTab("VISUALS")
local settingsTab = CreateTab("SETTINGS")

playerTab.Visible = true

--====================================================
-- PLAYER TAB
--====================================================

CreateButton(playerTab,"SET WALKSPEED 32",Theme.Accent,function()

```
local char = player.Character

if char then

    local hum = char:FindFirstChild("Humanoid")

    if hum then
        hum.WalkSpeed = 32
    end
end
```

end)

CreateButton(playerTab,"SET JUMPPOWER 100",Theme.Primary,function()

```
local char = player.Character

if char then

    local hum = char:FindFirstChild("Humanoid")

    if hum then
        hum.JumpPower = 100
    end
end
```

end)

--====================================================
-- VISUALS TAB
--====================================================

local fullbright = false

CreateButton(visualsTab,"TOGGLE FULLBRIGHT",Theme.Success,function()

```
fullbright = not fullbright

if fullbright then

    Lighting.Brightness = 5
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000

else

    Lighting.Brightness = 2
    Lighting.ClockTime = 12

end
```

end)

--====================================================
-- SETTINGS TAB
--====================================================

CreateButton(settingsTab,"DESTROY UI",Theme.Danger,function()

```
if blur then
    blur:Destroy()
end

gui:Destroy()
```

end)

--====================================================
-- VERIFY BUTTON
--====================================================

verify.MouseButton1Click:Connect(function()

```
local key = keyBox.Text

if ValidKeys[key] then

    keyFrame.Visible = false
    main.Visible = true

else

    verify.Text = "INVALID KEY"

    task.wait(1)

    verify.Text = "VERIFY"

end
```

end)

--====================================================
-- DRAG SYSTEM
--====================================================

local dragging
local dragInput
local dragStart
local startPos

main.InputBegan:Connect(function(input)

```
if input.UserInputType == Enum.UserInputType.MouseButton1 then

    dragging = true
    dragStart = input.Position
    startPos = main.Position

    input.Changed:Connect(function()

        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end

    end)
end
```

end)

main.InputChanged:Connect(function(input)

```
if input.UserInputType == Enum.UserInputType.MouseMovement then
    dragInput = input
end
```

end)

UIS.InputChanged:Connect(function(input)

```
if input == dragInput and dragging then

    local delta = input.Position - dragStart

    main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end
```

end)

print("S4INT HUB LOADED")
