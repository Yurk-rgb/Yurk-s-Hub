-- Yurk's Executor v1 - Blox Fruits | UI estilo Synapse + script funcional básico
-- Compatível com a maioria dos executores Roblox (PC e mobile)

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ===== UI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YurksExecutor"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Main frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- UI Corner rounding
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "Yurk's Executor v1 - Blox Fruits"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Tabs container
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0, 120, 1, -35)
TabsFrame.Position = UDim2.new(0, 0, 0, 35)
TabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainFrame

local UICornerTabs = Instance.new("UICorner")
UICornerTabs.CornerRadius = UDim.new(0, 10)
UICornerTabs.Parent = TabsFrame

-- Pages container
local PagesFrame = Instance.new("Frame")
PagesFrame.Name = "PagesFrame"
PagesFrame.Size = UDim2.new(1, -120, 1, -35)
PagesFrame.Position = UDim2.new(0, 120, 0, 35)
PagesFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PagesFrame.BorderSizePixel = 0
PagesFrame.Parent = MainFrame

local UICornerPages = Instance.new("UICorner")
UICornerPages.CornerRadius = UDim.new(0, 10)
UICornerPages.Parent = PagesFrame

-- Tab Buttons
local tabs = {"Auto Farm", "Boss Farm", "Stats", "Misc"}

local buttons = {}
local pages = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName.."Btn"
    btn.Text = tabName
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, (i-1)*50)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.Parent = TabsFrame
    buttons[tabName] = btn

    -- Page frame
    local page = Instance.new("Frame")
    page.Name = tabName.."Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (i == 1) -- only first visible by default
    page.Parent = PagesFrame
    pages[tabName] = page
end

-- Tab switch function
local function selectTab(tabName)
    for tn, page in pairs(pages) do
        page.Visible = (tn == tabName)
    end
    for tn, btn in pairs(buttons) do
        if tn == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
            btn.TextColor3 = Color3.fromRGB(255,255,255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
end

for tabName, btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        selectTab(tabName)
    end)
end

-- ===== Auto Farm Tab =====
local AutoFarmPage = pages["Auto Farm"]

local AutoFarmToggle = Instance.new("TextButton")
AutoFarmToggle.Size = UDim2.new(0, 150, 0, 40)
AutoFarmToggle.Position = UDim2.new(0, 20, 0, 20)
AutoFarmToggle.Text = "Toggle Auto Farm"
AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 70)
AutoFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmToggle.Font = Enum.Font.GothamBold
AutoFarmToggle.TextSize = 16
AutoFarmToggle.Parent = AutoFarmPage

local AutoFarmStatus = Instance.new("TextLabel")
AutoFarmStatus.Size = UDim2.new(0, 150, 0, 30)
AutoFarmStatus.Position = UDim2.new(0, 20, 0, 70)
AutoFarmStatus.BackgroundTransparency = 1
AutoFarmStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
AutoFarmStatus.Font = Enum.Font.Gotham
AutoFarmStatus.TextSize = 14
AutoFarmStatus.Text = "Status: OFF"
AutoFarmStatus.Parent = AutoFarmPage

local AutoFarmEnabled = false

AutoFarmToggle.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    AutoFarmStatus.Text = "Status: "..(AutoFarmEnabled and "ON" or "OFF")
end)

-- ===== Boss Farm Tab =====
local BossFarmPage = pages["Boss Farm"]

local BossFarmToggle = Instance.new("TextButton")
BossFarmToggle.Size = UDim2.new(0, 150, 0, 40)
BossFarmToggle.Position = UDim2.new(0, 20, 0, 20)
BossFarmToggle.Text = "Toggle Boss Farm"
BossFarmToggle.BackgroundColor3 = Color3.fromRGB(130, 70, 70)
BossFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
BossFarmToggle.Font = Enum.Font.GothamBold
BossFarmToggle.TextSize = 16
BossFarmToggle.Parent = BossFarmPage

local BossFarmStatus = Instance.new("TextLabel")
BossFarmStatus.Size = UDim2.new(0, 150, 0, 30)
BossFarmStatus.Position = UDim2.new(0, 20, 0, 70)
BossFarmStatus.BackgroundTransparency = 1
BossFarmStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
BossFarmStatus.Font = Enum.Font.Gotham
BossFarmStatus.TextSize = 14
BossFarmStatus.Text = "Status: OFF"
BossFarmStatus.Parent = BossFarmPage

local BossFarmEnabled = false

BossFarmToggle.MouseButton1Click:Connect(function()
    BossFarmEnabled = not BossFarmEnabled
    BossFarmStatus.Text = "Status: "..(BossFarmEnabled and "ON" or "OFF")
end)

-- ===== Stats Tab =====
local StatsPage = pages["Stats"]

local AutoStatsToggle = Instance.new("TextButton")
AutoStatsToggle.Size = UDim2.new(0, 150, 0, 40)
AutoStatsToggle.Position = UDim2.new(0, 20, 0, 20)
AutoStatsToggle.Text = "Toggle Auto Stats"
AutoStatsToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 130)
AutoStatsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoStatsToggle.Font = Enum.Font.GothamBold
AutoStatsToggle.TextSize = 16
AutoStatsToggle.Parent = StatsPage

local AutoStatsStatus = Instance.new("TextLabel")
AutoStatsStatus.Size = UDim2.new(0, 150, 0, 30)
AutoStatsStatus.Position = UDim2.new(0, 20, 0, 70)
AutoStatsStatus.BackgroundTransparency = 1
AutoStatsStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
AutoStatsStatus.Font = Enum.Font.Gotham
AutoStatsStatus.TextSize = 14
AutoStatsStatus.Text = "Status: OFF"
AutoStatsStatus.Parent = StatsPage

local AutoStatsEnabled = false

AutoStatsToggle.MouseButton1Click:Connect(function()
    AutoStatsEnabled = not AutoStatsEnabled
    AutoStatsStatus.Text = "Status: "..(AutoStatsEnabled and "ON" or "OFF")
end)

-- Stats choice dropdown (simplified with buttons)
local statNames = {"Melee", "Defense", "Sword", "Gun", "Energy"}
local selectedStat = statNames[1]

local StatLabel = Instance.new("TextLabel")
StatLabel.Size = UDim2.new(0, 200, 0, 25)
StatLabel.Position = UDim2.new(0, 20, 0, 110)
StatLabel.BackgroundTransparency = 1
StatLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
StatLabel.Font = Enum.Font.Gotham
StatLabel.TextSize = 16
StatLabel.Text = "Stat to upgrade: "..selectedStat
StatLabel.Parent = StatsPage

local StatButtons = {}

for i, statName in ipairs(statNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 30)
    btn.Position = UDim2.new(0, 20 + (i-1)*85, 0, 140)
    btn.Text = statName
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = StatsPage

    btn.MouseButton1Click:Connect(function()
        selectedStat = statName
        StatLabel.Text = "Stat to upgrade: "..selectedStat
        for _, b in pairs(StatButtons) do
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            b.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        btn.BackgroundColor3 = Color3.fromRGB(70, 130, 70)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    table.insert(StatButtons, btn)
end
-- Highlight first stat button by default
StatButtons[1].BackgroundColor3 = Color3.fromRGB(70, 130, 70)
StatButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)

-- ===== Misc Tab =====
local MiscPage = pages["Misc"]

local TeleportBox = Instance.new("TextBox")
TeleportBox.Size = UDim2.new(0, 200, 0, 30)
TeleportBox.Position = UDim2.new(0, 20, 0, 20)
TeleportBox.PlaceholderText = "Teleport to (x,y,z)"
TeleportBox.ClearTextOnFocus = false
TeleportBox.Text = ""
TeleportBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
TeleportBox.TextColor3 = Color3.fromRGB(220,220,220)
TeleportBox.Font = Enum.Font.Gotham
TeleportBox.TextSize = 16
TeleportBox.Parent = MiscPage

local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0, 100, 0, 30)
TeleportButton.Position = UDim2.new(0, 230, 0, 20)
TeleportButton.Text = "Teleport"
TeleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 130)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.TextSize = 16
TeleportButton.Parent = MiscPage

TeleportButton.MouseButton1Click:Connect(function()
    local txt = TeleportBox.Text
    local x,y,z = txt:match("([%-%.%d]+),%s*([%-%.%d]+),%s*([%-%.%d]+)")
    if x and y and z then
        local pos = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(pos)
        end
    else
        TeleportBox.Text = "Formato: x,y,z"
    end
end)

-- Anti-AFK
local function antiAFK()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end
antiAFK()

-- Anti-Kick (basic)
local mt = getrawmetatable and getrawmetatable(game) or nil
if mt then
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "Kick" then
            return
        end
        return oldNamecall(self, unpack(args))
    end)
    setreadonly(mt, true)
end

-- ===== Script Logic =====

local RunAutoFarm
local RunBossFarm
local RunAutoStats

-- Helper to find nearest mob (basic)
local function getNearestEnemy()
    local character = LocalPlayer.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local closestDist = math.huge
    local closestEnemy = nil

    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local mobHRP = mob:FindFirstChild("HumanoidRootPart")
            if mobHRP then
                local dist = (mobHRP.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestEnemy = mob
                end
            end
        end
    end
    return closestEnemy, closestDist
end

-- Auto Farm function (basic attack + walk to enemy)
local function autoFarmLoop()
    while AutoFarmEnabled do
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if humanoid and hrp then
            local enemy = getNearestEnemy()
            if enemy then
                local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
                if enemyHRP then
                    -- Walk closer
                    humanoid:MoveTo(enemyHRP.Position - (enemyHRP.CFrame.LookVector * 5))
                    humanoid.MoveToFinished:Wait()

                    -- Attack (simulate key press)
                    -- NOTE: This depends on your executor and game, so here is a generic touch
                    -- For many executors, you can fire the tool's activate:
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end

                    wait(1)
                end
            else
                wait(1)
            end
        else
            wait(1)
        end
        RunService.Heartbeat:Wait()
    end
end

-- Boss Farm (teleport to boss and attack basic)
local function bossFarmLoop()
    while BossFarmEnabled do
        local character = LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local boss = workspace:FindFirstChild("Boss") or workspace:FindFirstChild("Bosses")
            local bossHRP = boss and boss:FindFirstChild("HumanoidRootPart")
            if bossHRP then
                hrp.CFrame = bossHRP.CFrame * CFrame.new(0, 5, 5)
                wait(0.5)
                local tool = character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            else
                wait(3)
            end
        else
            wait(1)
        end
        RunService.Heartbeat:Wait()
    end
end

-- Auto Stats (simple upgrade)
local function autoStatsLoop()
    while AutoStatsEnabled do
        local statRemote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteFunction") or game:GetService("ReplicatedStorage"):FindFirstChild("PointsHandler")
        if not statRemote then
            wait(2)
            continue
        end

        -- Attempt to invoke upgrade stat - might error depending on remote names
        local success, err = pcall(function()
            statRemote:InvokeServer(selectedStat, 1)
        end)

        wait(1)
    end
end

-- Thread runners
spawn(function()
    while true do
        if AutoFarmEnabled then autoFarmLoop() else RunService.Heartbeat:Wait() end
    end
end)

spawn(function()
    while true do
        if BossFarmEnabled then bossFarmLoop() else RunService.Heartbeat:Wait() end
    end
end)

spawn(function()
    while true do
        if AutoStatsEnabled then autoStatsLoop() else RunService.Heartbeat:Wait() end
    end
