--✅ Exclusivo Yurk's Executor
getgenv().executor = "YURK_V1"

if getgenv().executor ~= "YURK_V1" then
    warn("❌ Esse script só funciona com o Yurk's Executor.")
    return
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "YurksHub"
ScreenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0.5, -150, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Draggable = true

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🌟 Yurk's Hub"
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)

local toggleBtn = Instance.new("TextButton", ScreenGui)
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -100)
toggleBtn.Text = "⚙️"
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 255)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

toggleBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

local function AutoFarm()
    task.spawn(function()
        while true do
            task.wait(1)
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") and v.Enabled then
                    pcall(function()
                        fireproximityprompt(v)
                    end)
                end
            end
        end
    end)
end

local function TeleportTo(areaName)
    local target = workspace:FindFirstChild(areaName)
    local char = game.Players.LocalPlayer.Character
    if target and target:FindFirstChild("HumanoidRootPart") and char then
        char:MoveTo(target.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
    end
end

local function AntiKick()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" then
            warn("🚫 Kick bloqueado.")
            return
        end
        return old(self, ...)
    end)
end

local function AntiAFK()
    for _, v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
        v:Disable()
    end
    print("✅ Anti-AFK ativado")
end

local function createButton(name, posY, func)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 260, 0, 35)
    btn.Position = UDim2.new(0, 20, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(func)
end

createButton("🌱 Ativar AutoFarm", 60, AutoFarm)
createButton("🛡️ Ativar Anti-Kick", 105, AntiKick)
createButton("😴 Ativar Anti-AFK", 150, AntiAFK)
createButton("📍 TP: Mercado", 195, function() TeleportTo("Market") end)
createButton("📍 TP: Fazenda", 240, function() TeleportTo("Farm") end)

local credits = Instance.new("TextLabel", frame)
credits.Size = UDim2.new(1, 0, 0, 30)
credits.Position = UDim2.new(0, 0, 1, -30)
credits.Text = "🔐 Script exclusivo - Yurk's Hub"
credits.TextColor3 = Color3.fromRGB(180, 180, 180)
credits.Font = Enum.Font.Gotham
credits.TextSize = 12
credits.BackgroundTransparency = 1
