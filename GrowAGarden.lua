-- Criando GUI base
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YurksHubGrowAGarden"
ScreenGui.Parent = game.CoreGui

-- Frame principal (menu)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

-- Botão fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 30)
CloseButton.Position = UDim2.new(1, -45, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 22
CloseButton.Text = "X"
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Texto para inserir nome do jogador
local PlayerNameBox = Instance.new("TextBox")
PlayerNameBox.Size = UDim2.new(0, 250, 0, 40)
PlayerNameBox.Position = UDim2.new(0, 20, 0, 60)
PlayerNameBox.PlaceholderText = "Digite o nome do jogador"
PlayerNameBox.Text = ""
PlayerNameBox.ClearTextOnFocus = false
PlayerNameBox.TextColor3 = Color3.new(1,1,1)
PlayerNameBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
PlayerNameBox.Parent = MainFrame

local UICornerBox = Instance.new("UICorner")
UICornerBox.CornerRadius = UDim.new(0, 6)
UICornerBox.Parent = PlayerNameBox

-- Botão para roubar a melhor fruta
local StealButton = Instance.new("TextButton")
StealButton.Size = UDim2.new(0, 250, 0, 40)
StealButton.Position = UDim2.new(0, 20, 0, 120)
StealButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
StealButton.TextColor3 = Color3.new(1,1,1)
StealButton.Font = Enum.Font.SourceSansBold
StealButton.TextSize = 22
StealButton.Text = "Roubar Melhor Fruta"
StealButton.Parent = MainFrame

local UICornerSteal = Instance.new("UICorner")
UICornerSteal.CornerRadius = UDim.new(0, 6)
UICornerSteal.Parent = StealButton

-- Função para roubar a melhor fruta do jogador pelo nome
local function StealBestFruit(targetName)
    local Players = game:GetService("Players")
    local targetPlayer = Players:FindFirstChild(targetName)
    if not targetPlayer then
        warn("Jogador não encontrado: " .. targetName)
        return
    end

    local targetInventory = targetPlayer:FindFirstChild("Inventory")
    if not targetInventory then
        warn("Inventário do jogador não encontrado")
        return
    end

    -- Supondo que frutas estejam dentro do inventário como filhos (exemplo)
    -- Defina critérios para "melhor fruta" (exemplo: a com maior "Value" ou "Level")
    local bestFruit = nil
    local bestValue = -math.huge

    for _, fruit in pairs(targetInventory:GetChildren()) do
        -- Supondo que cada fruta tenha um atributo "Value" numerico
        local val = fruit:FindFirstChild("Value")
        if val and val.Value > bestValue then
            bestValue = val.Value
            bestFruit = fruit
        end
    end

    if bestFruit then
        -- Mover a fruta para seu inventário (jogador local)
        local localPlayer = Players.LocalPlayer
        local localInventory = localPlayer:FindFirstChild("Inventory")
        if not localInventory then
            warn("Seu inventário não foi encontrado")
            return
        end

        bestFruit.Parent = localInventory
        print("Melhor fruta roubada: " .. bestFruit.Name)
    else
        warn("Nenhuma fruta encontrada no inventário do jogador")
    end
end

-- Conectar botão ao evento
StealButton.MouseButton1Click:Connect(function()
    local playerName = PlayerNameBox.Text
    if playerName == "" then
        warn("Por favor, digite um nome válido")
        return
    end
    StealBestFruit(playerName)
end)

-- Botão abrir/fechar script (círculo preto com imagem)
local OpenButton = Instance.new("ImageButton")
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenButton.BorderSizePixel = 0
OpenButton.Parent = ScreenGui

local UICornerOpen = Instance.new("UICorner")
UICornerOpen.CornerRadius = UDim.new(1, 0) -- círculo
UICornerOpen.Parent = OpenButton

-- URL da imagem do Delta Executor (exemplo)
OpenButton.Image = "https://cdn.discordapp.com/attachments/1104802387586364506/1137260448874999960/Delta_Executor_Logo.png"

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
