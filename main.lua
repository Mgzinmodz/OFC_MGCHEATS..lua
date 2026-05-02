-- =================================================================
-- MGHUB - FIXED VERSION (STABLE)
-- =================================================================

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- STATES
local autofarm = false
local autoChest = false
local espFruit = false

-- SAFE GET CHARACTER
local function getChar()
    local c = LP.Character or LP.CharacterAdded:Wait()
    return c, c:FindFirstChild("HumanoidRootPart"), c:FindFirstChild("Humanoid")
end

-- ================= GUI =================
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0,140,0,40)
btn.Position = UDim2.new(0.02,0,0.1,0)
btn.Text = "|MGHUB| - X"
btn.BackgroundColor3 = Color3.fromRGB(20,25,45)
btn.TextColor3 = Color3.new(1,1,1)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,250)
frame.Position = UDim2.new(0.02,0,0.2,0)
frame.Visible = false
frame.BackgroundColor3 = Color3.fromRGB(15,15,25)

btn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- ================= TOGGLE =================
local function createToggle(text, posY, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9,0,0,35)
    b.Position = UDim2.new(0.05,0,0,posY)
    b.Text = text.." ❌"
    b.BackgroundColor3 = Color3.fromRGB(30,30,50)

    local state = false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = text..(state and " ✅" or " ❌")
        callback(state)
    end)
end

-- ================= AUTOFARM =================
createToggle("Autofarm", 20, function(state)
    autofarm = state

    task.spawn(function()
        while autofarm do
            task.wait(0.4)

            local char, hrp, hum = getChar()
            if not hrp or hum.Health <= 0 then continue end

            local closest, dist = nil, math.huge

            for _,v in pairs(workspace.Enemies:GetChildren()) do
                local h = v:FindFirstChild("Humanoid")
                local root = v:FindFirstChild("HumanoidRootPart")

                if h and root and h.Health > 0 then
                    local d = (hrp.Position - root.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = root
                    end
                end
            end

            if closest then
                hrp.CFrame = closest.CFrame * CFrame.new(0,0,3)

                -- ataque simples (click simulado)
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
            end
        end
    end)
end)

-- ================= AUTO CHEST =================
createToggle("Auto Chest", 70, function(state)
    autoChest = state

    task.spawn(function()
        while autoChest do
            task.wait(2)

            local char, hrp = getChar()
            if not hrp then continue end

            for _,v in pairs(workspace:GetDescendants()) do
                if v.Name:lower():find("chest") and v:IsA("BasePart") then
                    hrp.CFrame = v.CFrame + Vector3.new(0,2,0)
                    task.wait(0.5)
                end
            end
        end
    end)
end)

-- ================= ESP FRUIT =================
local espList = {}

createToggle("ESP Fruit", 120, function(state)
    espFruit = state

    if not state then
        for _,v in pairs(espList) do
            v:Destroy()
        end
        espList = {}
        return
    end

    task.spawn(function()
        while espFruit do
            task.wait(1)

            for _,obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                    if obj.Name:lower():find("fruit") and not espList[obj] then

                        local bill = Instance.new("BillboardGui")
                        bill.Size = UDim2.new(0,100,0,40)
                        bill.Adornee = obj.Handle
                        bill.AlwaysOnTop = true

                        local txt = Instance.new("TextLabel", bill)
                        txt.Size = UDim2.new(1,0,1,0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "🍎 "..obj.Name
                        txt.TextColor3 = Color3.new(1,0.5,0)

                        bill.Parent = gui
                        espList[obj] = bill
                    end
                end
            end
        end
    end)
end)

-- ================= ANTI FALL =================
task.spawn(function()
    while task.wait(1) do
        local char, hrp = getChar()
        if hrp and hrp.Position.Y < -10 then
            hrp.CFrame = CFrame.new(0,50,0)
        end
    end
end)

print("MGHUB FIXED LOADED")
