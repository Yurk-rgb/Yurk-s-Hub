HWN HUB V1.10
-- Serviços
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

----------------------------------------------------------
------------------🔔 Animação de Execução ---------------
----------------------------------------------------------
local introGui = Instance.new("ScreenGui", game.CoreGui)
introGui.Name = "HWN_HUB_Intro"

local intro = Instance.new("TextLabel", introGui)
intro.Size = UDim2.new(0, 500, 0, 100)
intro.Position = UDim2.new(0.5, -250, 0.4, -50)
intro.BackgroundTransparency = 1
intro.Text = "⚡ HWN HUB ⚡"
intro.TextColor3 = Color3.new(1, 1, 1)
intro.Font = Enum.Font.SourceSansBold
intro.TextScaled = true
intro.TextStrokeTransparency = 0.5

-- Animação
intro.TextTransparency = 1
intro.TextStrokeTransparency = 1
for i = 1, 20 do
	intro.TextTransparency = 1 - (i/20)
	intro.TextStrokeTransparency = 1 - (i/20)
	wait(0.03)
end
wait(2)
for i = 1, 20 do
	intro.TextTransparency = (i/20)
	intro.TextStrokeTransparency = (i/20)
	wait(0.03)
end
introGui:Destroy()

----------------------------------------------------------
------------------🔔 Notificação Roblox ------------------
----------------------------------------------------------
StarterGui:SetCore("SendNotification", {
	Title = "HWN HUB 🚀";
	Text = "Script executado com sucesso!";
	Duration = 5;
})

----------------------------------------------------------
----------------------- GUI Principal --------------------
----------------------------------------------------------
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HWN_HUB"

-- Botão de abrir/fechar
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.5, -20)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.Text = "+"
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 24
toggleButton.BorderSizePixel = 0
toggleButton.UICorner = Instance.new("UICorner", toggleButton)

-- Frame Principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 450)
frame.Position = UDim2.new(0, 60, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "⚡ HWN HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

-- Tabs
local tab = "Main"

local function createTabButton(text, posX)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 100, 0, 25)
    btn.Position = UDim2.new(0, posX, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(function()
        tab = text
        refreshUI()
    end)
end

createTabButton("Main", 10)
createTabButton("Config", 115)

-- Layout Dinâmico
local buttonY = 60
local scrolling = nil

local function clearUI()
    for _,v in ipairs(frame:GetChildren()) do
        if v:IsA("TextButton") and v.Position.Y.Offset >= 60 then
            v:Destroy()
        end
        if v:IsA("ScrollingFrame") then
            v:Destroy()
        end
    end
    buttonY = 60
end

local function createButton(text, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, buttonY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Text = text
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
    buttonY = buttonY + 35
    return btn
end

----------------------------------------------------------
------------------------ Funções -------------------------
----------------------------------------------------------
local espActive = true
local flying = false
local noclip = false

-- ESP
local function createESP(player)
    if player == LocalPlayer then return end
    local function setup()
        local char = player.Character or player.CharacterAdded:Wait()
        local head = char:WaitForChild("Head", 5)
        if head and not head:FindFirstChild("ESP") then
            local esp = Instance.new("BillboardGui", head)
            esp.Name = "ESP"
            esp.Adornee = head
            esp.Size = UDim2.new(0, 100, 0, 40)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextStrokeTransparency = 0
            label.Text = player.Name
            label.Font = Enum.Font.SourceSansBold
            label.TextScaled = true
            if not espActive then esp.Enabled = false end
        end
    end
    setup()
    player.CharacterAdded:Connect(setup)
end

local function toggleESP(state)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local esp = head:FindFirstChild("ESP")
                if esp then esp.Enabled = state end
            end
        end
    end
end

-- TP
local function teleportTo(player)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        hrp.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    end
end

-- Kill
local function killPlayer(target)
    if target and target.Character and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.Health = 0
    end
end

-- Player List
local function refreshPlayers()
    scrolling:ClearAllChildren()
    local y = 0
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton", scrolling)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Position = UDim2.new(0, 5, 0, y)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Text = player.Name .. " | TP / KILL"
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 18
            btn.MouseButton1Click:Connect(function()
                teleportTo(player)
            end)
            btn.MouseButton2Click:Connect(function()
                killPlayer(player)
            end)
            y = y + 35
        end
    end
    scrolling.CanvasSize = UDim2.new(0, 0, 0, y)
end

----------------------------------------------------------
---------------------- UI REFRESH ------------------------
----------------------------------------------------------
function refreshUI()
    clearUI()

    if tab == "Main" then
        createButton("ESP: ON/OFF", function()
            espActive = not espActive
            toggleESP(espActive)
        end)

        createButton("Fly ON/OFF", function()
            flying = not flying
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            if flying then
                local bodyGyro = Instance.new("BodyGyro", hrp)
                local bodyVel = Instance.new("BodyVelocity", hrp)
                bodyGyro.P = 9e4
                bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bodyGyro.CFrame = hrp.CFrame
                bodyVel.Velocity = Vector3.new(0, 0, 0)
                bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

                RunService.RenderStepped:Connect(function()
                    if not flying then
                        bodyGyro:Destroy()
                        bodyVel:Destroy()
                        return
                    end
                    local moveDirection = Vector3.zero
                    if UIS:IsKeyDown(Enum.KeyCode.W) then moveDirection += hrp.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then moveDirection -= hrp.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then moveDirection -= hrp.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then moveDirection += hrp.CFrame.RightVector end
                    bodyGyro.CFrame = hrp.CFrame
                    bodyVel.Velocity = moveDirection * 50
                end)
            end
        end)

        createButton("Set Speed", function()
            LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(50)
        end)

        createButton("Noclip ON/OFF", function()
            noclip = not noclip
            RunService.Stepped:Connect(function()
                if noclip and LocalPlayer.Character then
                    for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end)

        -- Player List
        scrolling = Instance.new("ScrollingFrame", frame)
        scrolling.Size = UDim2.new(1, -20, 0, 180)
        scrolling.Position = UDim2.new(0, 10, 0, buttonY)
        scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
        scrolling.ScrollBarThickness = 6
        scrolling.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        buttonY = buttonY + 190

        refreshPlayers()
        Players.PlayerAdded:Connect(refreshPlayers)
        Players.PlayerRemoving:Connect(refreshPlayers)

    elseif tab == "Config" then
        createButton("Server Hop", function()
            local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"))
            for _,v in pairs(servers.data) do
                if v.playing < v.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
                    break
                end
            end
        end)

        createButton("Anti Kick", function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            local old = mt.__namecall
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" then
                    return warn("Kick attempt blocked!")
                end
                return old(self, ...)
            end)
        end)

        createButton("Anti AFK", function()
            for _,v in pairs(getconnections(LocalPlayer.Idled)) do
                v:Disable()
            end
            warn("Anti-AFK activated")
        end)
    end
end

-- Toggle Menu
toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    toggleButton.Text = frame.Visible and "-" or "+"
end)

-- ESP Inicial
for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
end
Players.PlayerAdded:Connect(createESP)

refreshUI()
