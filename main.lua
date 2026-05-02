-- MGZ MODS | UI BASE (ESBOÇO)

local player = game.Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MGZ_MODS"
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 300)
main.Position = UDim2.new(0.5, -200, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(25,25,35)
main.Parent = gui
main.Active = true
main.Draggable = true

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(15,15,25)
title.Text = "MGZ MODS"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
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

-- FUNÇÃO CRIAR TEXTO
local function createLabel(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,0,30)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(200,200,200)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.Parent = content
end

-- ABAS
local function createTab(name, posX, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.25,0,0,30)
    btn.Position = UDim2.new(posX,0,0,30)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(35,35,45)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Parent = main
    
    btn.MouseButton1Click:Connect(callback)
end

-- CONTEÚDOS
local function showAimbot()
    clear()
    createLabel("Aimbot Settings (em breve)")
end

local function showVisual()
    clear()
    createLabel("Visual / ESP (em breve)")
end

local function showMisc()
    clear()
    createLabel("Misc Settings (em breve)")
end

local function showMain()
    clear()
    createLabel("Main Settings (em breve)")
end

-- CRIAR ABAS
createTab("Aimbot", 0, showAimbot)
createTab("Visual", 0.25, showVisual)
createTab("Misc", 0.5, showMisc)
createTab("Main", 0.75, showMain)

-- INICIAL
showAimbot()
