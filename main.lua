-- MGZMODZ | UI PROFISSIONAL

local player = game.Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MGZMODZ_PRO"
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 450, 0, 340)
main.Position = UDim2.new(0.5, -225, 0.5, -170)
main.BackgroundColor3 = Color3.fromRGB(18,18,28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

-- SHADOW
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(60,60,90)
stroke.Thickness = 1

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(12,12,20)
title.Text = "MGZMODZ HUB"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = main

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(1,0,1,-70)
content.Position = UDim2.new(0,0,0,70)
content.BackgroundTransparency = 1
content.Parent = main

-- CLEAR
local function clear()
	for _,v in pairs(content:GetChildren()) do
		v:Destroy()
	end
end

-- TOGGLE BUTTON
local function createToggle(text, y)
	local state = false
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9,0,0,30)
	btn.Position = UDim2.new(0.05,0,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(30,30,45)
	btn.Text = text.." : OFF"
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = content
	
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = text.." : "..(state and "ON" or "OFF")
		btn.BackgroundColor3 = state and Color3.fromRGB(60,120,255) or Color3.fromRGB(30,30,45)
	end)
end

-- TAB
local function createTab(name, posX, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.25,0,0,35)
	btn.Position = UDim2.new(posX,0,0,35)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(25,25,35)
	btn.TextColor3 = Color3.fromRGB(200,200,200)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = main
	
	btn.MouseButton1Click:Connect(callback)
end

-- AIMBOT
local function showAimbot()
	clear()
	local y = 5
	createToggle("Ativar Aimbot", y); y+=35
	createToggle("Mostrar FOV", y); y+=35
	createToggle("Linha de Mira", y); y+=35
	createToggle("Silent Aim", y); y+=35
	createToggle("Team Check", y); y+=35
	createToggle("No Recoil", y)
end

-- VISUAL
local function showVisual()
	clear()
	local y = 5
	createToggle("ESP Ativar", y); y+=35
	createToggle("ESP Nome", y); y+=35
	createToggle("ESP Box", y); y+=35
	createToggle("ESP Linha", y); y+=35
	createToggle("ESP Vida", y); y+=35
	createToggle("ESP Esqueleto", y)
end

-- MISC
local function showMisc()
	clear()
	local y = 5
	createToggle("Speed", y); y+=35
	createToggle("Fly", y); y+=35
	createToggle("Spin", y); y+=35
	createToggle("Teleport", y); y+=35
	createToggle("Auto Farm", y); y+=35
	createToggle("Anti AFK", y)
end

-- MAIN
local function showMain()
	clear()
	local y = 5
	createToggle("Invisível", y); y+=35
	createToggle("X-Ray", y); y+=35
	createToggle("Full Bright", y); y+=35
	createToggle("Remove Fog", y); y+=35
	createToggle("FPS Boost", y); y+=35
	createToggle("Reset GUI", y)
end

-- CREATE TABS
createTab("Aimbot", 0, showAimbot)
createTab("Visual", 0.25, showVisual)
createTab("Misc", 0.5, showMisc)
createTab("Main", 0.75, showMain)

-- START
showAimbot()
