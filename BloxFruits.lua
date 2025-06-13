-- Yurk's Hub - Blox Fruits com Abas

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YurksHubBloxFruits"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BorderSizePixel = 0
mainFrame.Size = UDim2.new(0, 400, 0, 520)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -260)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = ScreenGui
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "Yurk's Hub - Blox Fruits"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextStrokeTransparency = 0.75

-- Aba container
local tabsFrame = Instance.new("Frame")
tabsFrame.Parent = mainFrame
tabsFrame.Size = UDim2.new(1, 0, 0, 40)
tabsFrame.Position = UDim2.new(0, 0, 0, 50)
tabsFrame.BackgroundTransparency = 1

-- Conteúdo de cada aba
local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, -20, 1, -100)
contentFrame.Position = UDim2.new(0, 10, 0, 90)
contentFrame.BackgroundTransparency = 1

-- Função para criar botões de abas
local function createTabButton(text, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 1, 0)
    btn.Position = UDim2.new(0, posX, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.AutoButtonColor = true
    btn.Parent = tabsFrame
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(70,70,70) end)
    btn.MouseLeave:Connect(function()
        if not btn.Active then
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        end
    end)
    return btn
end

-- Função para criar botões dentro das abas
local function createButton(parent, text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 20
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.AutoButtonColor = true
    btn.Parent = parent
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(70,70,70) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50,50,50) end)
    return btn
end

-- Tabelas para armazenar botões de abas e frames de conteúdo
local tabs = {}
local pages = {}

-- Criando abas
local tabNames = {"Auto Farm", "Boss Farm", "Auto Stats", "Anti Kick"}
for i, name in ipairs(tabNames) do
    local btn = createTabButton(name, (i-1)*95 + 5)
    tabs[name] = btn

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Position = UDim2.new(0,0,0,0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = contentFrame

    pages[name] = page
end

-- Função para mudar abas
local function switchTab(name)
    for n, btn in pairs(tabs) do
        btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        btn.Active = false
        pages[n].Visible = false
    end
    tabs[name].BackgroundColor3 = Color3.fromRGB(70,70,70)
    tabs[name].Active = true
    pages[name].Visible = true
end

-- Setar aba inicial
switchTab("Auto Farm")

-- Vars controle
local autoFarmEnabled = false
local autoBossEnabled = false
local autoStatsEnabled = false
local antiKickEnabled = false

local VirtualUser = game:GetService("VirtualUser")

-- Funções

-- Anti Kick / AFK
local function antiKick()
    LocalPlayer.Idled:Connect(function()
        if antiKickEnabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

-- Pega boss mais próximo
local function getNearestBoss()
    local bosses = {}
    for _, mob in pairs(workspace.Monsters:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            if mob.Name:lower():find("boss") then
                table.insert(bosses, mob)
            end
        end
    end
    if #bosses == 0 then return nil end

    table.sort(bosses, function(a,b)
        local distA = (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).magnitude
        local distB = (LocalPlayer.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).magnitude
        return distA < distB
    end)
    return bosses[1]
end

-- Pega monstro mais próximo normal
local function getNearestMonster()
    local monsters = {}
    for _, mob in pairs(workspace.Monsters:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            if not mob.Name:lower():find("boss") then
                table.insert(monsters, mob)
            end
        end
    end
    if #monsters == 0 then return nil end

    table.sort(monsters, function(a,b)
        local distA = (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).magnitude
        local distB = (LocalPlayer.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).magnitude
        return distA < distB
    end)
    return monsters[1]
end

-- Atacar mob
local function attackMob(mob)
    if not mob or not mob:FindFirstChild("HumanoidRootPart") then return end
    local args = {
        [1] = mob.HumanoidRootPart.Position,
        [2] = mob
    }
    local combatEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Melee"):WaitForChild("MeleeEvent")
    if combatEvent then
        combatEvent:FireServer(unpack(args))
    end
end

-- Auto Farm (nível)
local function autoFarm()
    while autoFarmEnabled do
        local mob = getNearestMonster()
        if mob then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
            attackMob(mob)
        else
            wait(1)
        end
        wait(0.3)
    end
end

-- Auto Farm Boss
local function autoFarmBoss()
    while autoBossEnabled do
        local boss = getNearestBoss()
        if boss then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
            attackMob(boss)
        else
            wait(1)
        end
        wait(0.3)
    end
end

-- Auto Stats
local function autoStats()
    local statRemotes = {
        Strength = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Stats"):WaitForChild("Strength"),
        Defense = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Stats"):WaitForChild("Defense"),
        Agility = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Stats"):WaitForChild("Agility"),
        Sword = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Stats"):WaitForChild("Sword"),
        Gun = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Stats"):WaitForChild("Gun"),
        Fruit = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Stats"):WaitForChild("Fruit")
    }

    while autoStatsEnabled do
        for statName, remote in pairs(statRemotes) do
            remote:FireServer()
            wait(0.2)
        end
        wait(10)
    end
end

-- Criando botões dentro das abas

-- Aba Auto Farm
local btnAutoFarm = createButton(pages["Auto Farm"], "Auto Farm: OFF", 10)
btnAutoFarm.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    btnAutoFarm.Text = "Auto Farm: " .. (autoFarmEnabled and "ON" or "OFF")
    if autoFarmEnabled then
        spawn(autoFarm)
    end
end)

-- Aba Boss Farm
local btnAutoBoss = createButton(pages["Boss Farm"], "Auto Farm Boss: OFF", 10)
btnAutoBoss.MouseButton1Click:Connect(function()
    autoBossEnabled = not autoBossEnabled
    btnAutoBoss.Text = "Auto Farm Boss: " .. (autoBossEnabled and "ON" or "OFF")
    if autoBossEnabled then
        spawn(autoFarmBoss)
    end
end)

-- Aba Auto Stats
local btnAutoStats = createButton(pages["Auto Stats"], "Auto Stats: OFF", 10)
btnAutoStats.MouseButton1Click:Connect(function()
    autoStatsEnabled = not autoStatsEnabled
    btnAutoStats.Text = "Auto Stats: " .. (autoStatsEnabled and "ON" or "OFF")
    if autoStatsEnabled then
        spawn(autoStats)
    end
end)

-- Aba Anti Kick
local btnAntiKick = createButton(pages["Anti Kick"], "Anti Kick: OFF", 10)
btnAntiKick.MouseButton1Click:Connect(function()
    antiKickEnabled = not antiKickEnabled
    btnAntiKick.Text = "Anti Kick: " .. (antiKickEnabled and "ON" or "OFF")
    if antiKickEnabled then
        antiKick()
    end
end)

-- Botão fechar (embaixo da UI)
local btnClose = Instance.new("TextButton")
btnClose.Size = UDim2.new(1, 0, 0, 40)
btnClose.Position = UDim2.new(0, 0, 1, -40)
btnClose.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
btnClose.BorderSizePixel = 0
btnClose.Text = "Fechar Executor"
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 20
btnClose.TextColor3 = Color3.fromRGB(255,255,255)
btnClose.Parent = mainFrame
btnClose.MouseEnter:Connect(function() btnClose.BackgroundColor3 = Color3.fromRGB(220,60,60) end)
btnClose.MouseLeave:Connect(function() btnClose.BackgroundColor3 = Color3.fromRGB(180,40,40) end)
btnClose.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("Yurk's Hub - Blox Fruits Script carregado!")
