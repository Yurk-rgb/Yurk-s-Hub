-- Yurk's Executor v1 | Estilo Synapse X

-- Proteção para não duplicar
if game.CoreGui:FindFirstChild("YurkExecutor") then
    game.CoreGui:FindFirstChild("YurkExecutor"):Destroy()
end

-- Criação do Gui
local Gui = Instance.new("ScreenGui")
Gui.Name = "YurkExecutor"
Gui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = Gui

-- UICorner para deixar arredondado
local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 8)

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BorderSizePixel = 0
Title.Text = "Yurk's Executor | Synapse UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

-- Aba lateral
local SideBar = Instance.new("Frame")
SideBar.Parent = MainFrame
SideBar.Size = UDim2.new(0, 120, 1, -40)
SideBar.Position = UDim2.new(0, 0, 0, 40)
SideBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SideBar.BorderSizePixel = 0

local SideCorner = Instance.new("UICorner", SideBar)
SideCorner.CornerRadius = UDim.new(0, 8)

-- Área de conteúdo
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -120, 1, -40)
ContentFrame.Position = UDim2.new(0, 120, 0, 40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ContentFrame.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner", ContentFrame)
ContentCorner.CornerRadius = UDim.new(0, 8)

-- Função para limpar a tela antes de abrir outra aba
local function ClearContent()
    for _, v in pairs(ContentFrame:GetChildren()) do
        if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("TextLabel") then
            v:Destroy()
        end
    end
end

-- Botão Grow a Garden
local GrowButton = Instance.new("TextButton")
GrowButton.Parent = SideBar
GrowButton.Size = UDim2.new(1, -10, 0, 30)
GrowButton.Position = UDim2.new(0, 5, 0, 10)
GrowButton.Text = "Grow a Garden"
GrowButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
GrowButton.TextColor3 = Color3.new(1,1,1)
GrowButton.Font = Enum.Font.Gotham
GrowButton.TextSize = 14
GrowButton.BorderSizePixel = 0
GrowButton.MouseButton1Click:Connect(function()
    ClearContent()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Yurk-rgb/Yurk-s-Hub/main/GrowAGarden.lua"))()
end)

-- Botão Blox Fruits
local BloxButton = Instance.new("TextButton")
BloxButton.Parent = SideBar
BloxButton.Size = UDim2.new(1, -10, 0, 30)
BloxButton.Position = UDim2.new(0, 5, 0, 50)
BloxButton.Text = "Blox Fruits"
BloxButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BloxButton.TextColor3 = Color3.new(1,1,1)
BloxButton.Font = Enum.Font.Gotham
BloxButton.TextSize = 14
BloxButton.BorderSizePixel = 0
BloxButton.MouseButton1Click:Connect(function()
    ClearContent()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Yurk-rgb/Yurk-s-Hub/main/BloxFruits.lua"))()
end)

-- Botão fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.BorderSizePixel = 0
CloseButton.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

local CloseCorner = Instance.new("UICorner", CloseButton)
CloseCorner.CornerRadius = UDim.new(0, 8)
