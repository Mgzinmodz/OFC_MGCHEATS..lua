-- MGZMODZ | UI COMPLETO

local player = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MGZMODZ"
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 420, 0, 320)
main.Position = UDim2.new(0.5, -210, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(20,20,30)
main.Parent = gui
main.Active = true
main.Draggable = true

-- TÍTULO
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(15,15,25)
title.Text = "MGZMODZ"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = main

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(1,0,1,-60)
content.Position = UDim2.new(0,0,0,60)
content.BackgroundTransparency = 1
content.Parent = main

-- LIMPAR
local function clear()
	for _,v in pairs(content:GetChildren()) do
		v:Destroy()
	end
end

-- CRIAR BOTÃO
local function createButton(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9,0,0,30)
	btn.Position = UDim2.new(0.05,0,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = content
end

-- ABAS
local function createTab(name, posX, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.25,0,0,30)
	btn.Position = UDim2.new(posX,0,0,30)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(30,30,40)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 13
	btn.Parent = main
	
	btn.MouseButton1Click:Connect(callback)
end

-- AIMBOT
local function showAimbot()
	clear()
	local y = 5
	createButton("Ativar Aimbot", y); y+=35
	createButton("Mostrar FOV", y); y+=35
	createButton("Linha de Mira", y); y+=35
	createButton("Silent Aim", y); y+=35
	createButton("Team Check", y); y+=35
	createButton("No Recoil", y)
end

-- VISUAL
local function showVisual()
	clear()
	local y = 5
	createButton("ESP Ativar", y); y+=35
	createButton("ESP Nome", y); y+=35
	createButton("ESP Box", y); y+=35
	createButton("ESP Linha", y); y+=35
	createButton("ESP Vida", y); y+=35
	createButton("ESP Esqueleto", y)
end

-- MISC
local function showMisc()
	clear()
	local y = 5
	createButton("Speed", y); y+=35
	createButton("Fly", y); y+=35
	createButton("Spin", y); y+=35
	createButton("Teleport", y); y+=35
	createButton("Auto Farm", y); y+=35
	createButton("Anti AFK", y)
end

-- MAIN
local function showMain()
	clear()
	local y = 5
	createButton("Invisível", y); y+=35
	createButton("X-Ray", y); y+=35
	createButton("Full Bright", y); y+=35
	createButton("Remove Fog", y); y+=35
	createButton("FPS Boost", y); y+=35
	createButton("Reset GUI", y)
end

-- CRIAR ABAS
createTab("Aimbot", 0, showAimbot)
createTab("Visual", 0.25, showVisual)
createTab("Misc", 0.5, showMisc)
createTab("Main", 0.75, showMain)

-- INICIAL
showAimbot()
