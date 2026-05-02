-- MGZ MODS (CORRIGIDO)

local settings = {
    aimbot = false,
    showFOV = false,
    showAimLine = false,
    noRecoil = false,
    teamCheck = true,
    silentAim = false,
    fovRadius = 150,
    accuracy = 100,
    maxDistance = 300,
    targetPart = "Head",

    esp = false,
    espLine = false,
    espName = false,
    espBox = false,
    espSkeleton = false,
    espHealth = false,

    speedEnabled = false,
    speedValue = 50,

    invisible = false,
    xray = false
}

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

-- SAFE CHARACTER
local function getCharacter(plr)
    return plr.Character
end

-- ENEMIES
local function getEnemies()
    local t = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            if not settings.teamCheck or v.Team ~= player.Team then
                table.insert(t, v)
            end
        end
    end
    return t
end

-- TARGET
local function getTarget(plr)
    local char = getCharacter(plr)
    if not char then return end
    return char:FindFirstChild(settings.targetPart) or char:FindFirstChild("Head")
end

-- AIMBOT (simplificado)
local function updateAimbot()
    if not settings.aimbot then return end

    local closest, dist = nil, settings.fovRadius

    for _, plr in pairs(getEnemies()) do
        local part = getTarget(plr)
        if part then
            local pos, visible = camera:WorldToViewportPoint(part.Position)
            if visible then
                local mpos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                local d = (Vector2.new(pos.X,pos.Y) - mpos).Magnitude

                if d < dist then
                    dist = d
                    closest = part
                end
            end
        end
    end

    if closest then
        camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
    end
end

-- ESP OTIMIZADO
local drawings = {}

local function clearESP()
    for _, d in pairs(drawings) do
        pcall(function() d:Remove() end)
    end
    drawings = {}
end

local function updateESP()
    if not settings.esp then
        clearESP()
        return
    end

    clearESP()

    for _, plr in pairs(getEnemies()) do
        local char = getCharacter(plr)
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            local pos, vis = camera:WorldToViewportPoint(root.Position)

            if vis then
                if settings.espName then
                    local t = Drawing.new("Text")
                    t.Text = plr.Name
                    t.Position = Vector2.new(pos.X, pos.Y)
                    t.Size = 14
                    t.Center = true
                    t.Visible = true
                    table.insert(drawings, t)
                end
            end
        end
    end
end

-- SPEED
local function updateSpeed()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = settings.speedEnabled and settings.speedValue or 16
    end
end

-- INVIS
local function updateMain()
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = settings.invisible and 1 or 0
            end
        end
    end
end

-- LOOP
runService.RenderStepped:Connect(function()
    pcall(function()
        updateAimbot()
        updateESP()
        updateSpeed()
        updateMain()
    end)
end)
