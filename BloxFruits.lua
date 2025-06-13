-- Yurk's Hub - Blox Fruits Script (versão corrigida)

-- Referências básicas e checagens
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BloxFruitRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BloxFruitRemote")
local ServerHandler = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ServerHandler")

local UIS = UserInputService

-- Função para Teleportar para um player pelo nome
local function TeleportToPlayer(playerName)
    local target = Players:FindFirstChild(playerName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 3)
        print("Teleportado para "..playerName)
    else
        warn("Jogador não encontrado ou personagem inválido.")
    end
end

-- Função Auto Farm (exemplo básico)
local AutoFarmEnabled = false

function AutoFarm()
    if not AutoFarmEnabled then return end
    -- Aqui você deve colocar a lógica do farm do Blox Fruits, que pode variar bastante.
    -- Exemplo: Teleportar para um mob, atacar, esperar a morte, repetir.
    -- Importante: Cuidado com event handlers do jogo, evite bans.
end

-- Exemplo básico de ativação/desativação
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.P then
        AutoFarmEnabled = not AutoFarmEnabled
        print("AutoFarm:", AutoFarmEnabled and "Ativado" or "Desativado")
        if AutoFarmEnabled then
            -- Começa o AutoFarm em loop (thread)
            spawn(function()
                while AutoFarmEnabled do
                    AutoFarm()
                    wait(1)
                end
            end)
        end
    end
end)

-- Função para usar Haki (exemplo)
local function UseBusoHaki()
    BloxFruitRemote:FireServer("Buso")
end

-- Função para Teleportar para uma posição
local function TeleportToPosition(position)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- Interface Simples (exemplo)
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0, 20, 0, 20)
Frame.Size = UDim2.new(0, 150, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

local ToggleAutoFarm = Instance.new("TextButton", Frame)
ToggleAutoFarm.Size = UDim2.new(1, -10, 0, 40)
ToggleAutoFarm.Position = UDim2.new(0, 5, 0, 5)
ToggleAutoFarm.Text = "Toggle AutoFarm"
ToggleAutoFarm.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleAutoFarm.TextColor3 = Color3.new(1, 1, 1)
ToggleAutoFarm.BorderSizePixel = 0

ToggleAutoFarm.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    ToggleAutoFarm.Text = AutoFarmEnabled and "AutoFarm: ON" or "AutoFarm: OFF"
end)

-- Função para Teleportar para player escolhido via Interface
local PlayerList = Instance.new("ScrollingFrame", Frame)
PlayerList.Position = UDim2.new(0, 5, 0, 50)
PlayerList.Size = UDim2.new(1, -10, 0, 140)
PlayerList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlayerList.BorderSizePixel = 0
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)

local UIListLayout = Instance.new("UIListLayout", PlayerList)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local function RefreshPlayerList()
    PlayerList:ClearAllChildren()
    for i, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton", PlayerList)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = player.Name
            btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BorderSizePixel = 0

            btn.MouseButton1Click:Connect(function()
                TeleportToPlayer(player.Name)
            end)
        end
    end
    wait()
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

RefreshPlayerList()
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)

print("Yurk's Hub Blox Fruits Script carregado.")
