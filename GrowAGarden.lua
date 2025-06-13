-- Yurk's Hub - Grow a Garden (Universal Mobile Version)
-- Compatível com Delta, Hydrogen, Codex, Vega Mobile, etc
-- UI estilo Synapse X adaptado para mobile
-- Funcionalidades: Auto Farm, Teleporte, Anti Kick, Anti AFK

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Criar UI (estilo Synapse Dark Mode)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YurksHubGrowAGarden"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BorderSizePixel = 0
mainFrame.Size = UDim2.new(0, 350, 0, 450)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = ScreenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Título
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "Yurk's Hub - Grow a Garden"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextStrokeTransparency = 0.75
title.BorderSizePixel = 0

-- Container de botões
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Parent = mainFrame
buttonsFrame.Size = UDim2.new(1, -20, 1, -70)
buttonsFrame.Position = UDim2.new(0, 10, 0, 60)
buttonsFrame.BackgroundTransparency = 1

local function createButton(text, positionY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, positionY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 20
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = true
    btn.Parent = buttonsFrame

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    return btn
end

-- Variáveis controle
local autoFarmEnabled = false
local antiKickEnabled = false
local antiAfkEnabled = false

-- Função Auto Farm (exemplo simplificado)
local function autoFarm()
    while autoFarmEnabled do
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            wait(1)
        else
            local hrp = LocalPlayer.Character.HumanoidRootPart
            -- Exemplo: Teleportar para a árvore da fruta (exemplo)
            local tree = workspace:FindFirstChild("FruitTree")
            if tree and tree:FindFirstChild("Fruit") then
                hrp.CFrame = tree.Fruit.CFrame * CFrame.new(0, 3, 0)
            end
        end
        wait(2)
    end
end

-- Função Anti Kick (simples)
local function antiKick()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        if antiAfkEnabled then
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

-- Função Teleporte para fruta (exemplo)
local function teleportToFruit()
    local tree = workspace:FindFirstChild("FruitTree")
    if tree and tree:FindFirstChild("Fruit") then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = tree.Fruit.CFrame * CFrame.new(0, 3, 0)
        end
    else
        warn("Fruta não encontrada no workspace")
    end
end

-- Criar botões e ligar funções
local btnAutoFarm = createButton("Auto Farm: OFF", 0)
btnAutoFarm.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    btnAutoFarm.Text = "Auto Farm: " .. (autoFarmEnabled and "ON" or "OFF")
    if autoFarmEnabled then
        spawn(autoFarm)
    end
end)

local btnTeleportFruit = createButton("Teleportar para Fruta", 50)
btnTeleportFruit.MouseButton1Click:Connect(teleportToFruit)

local btnAntiKick = createButton("Anti Kick: OFF", 100)
btnAntiKick.MouseButton1Click:Connect(function()
    antiKickEnabled = not antiKickEnabled
    antiAfkEnabled = antiKickEnabled -- Usando o mesmo para simplificar
    btnAntiKick.Text = "Anti Kick: " .. (antiKickEnabled and "ON" or "OFF")
    if antiKickEnabled then
        antiKick()
    end
end)

local btnClose = createButton("Fechar Executor", 390)
btnClose.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
btnClose.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Aviso para mobile (se quiser pode remover)
if UserInputService.TouchEnabled then
    print("Executando no dispositivo mobile. Interface adaptada para toque.")
end

print("Yurk's Hub - Grow a Garden Universal carregado!")
