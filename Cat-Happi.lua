for i,v in next, workspace:GetDescendants() do
    pcall(function()
        v.Transparency = 1
    end)
end
for i,v in next, getnilinstances() do
    pcall(function()
        v.Transparency = 1
        for i1,v1 in next, v:GetDescendants() do
            v1.Transparency = 1
        end
    end)
end
a = workspace
a.DescendantAdded:Connect(function(v)
    pcall(function()
        v.Transparency = 1
    end)
end)
wait(.3)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
local fpsLabel = Instance.new("TextLabel")
local pingLabel = Instance.new("TextLabel")
local toggleButton = Instance.new("TextButton")

local isVisible = true

screenGui.Parent = game.CoreGui
screenGui.DisplayOrder = 100

-- FPS Label
fpsLabel.Parent = screenGui
fpsLabel.Size = UDim2.new(0, 300, 0, 30)
fpsLabel.Position = UDim2.new(0, 72, 0, 56)
fpsLabel.Font = Enum.Font.FredokaOne
fpsLabel.TextScaled = true
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextStrokeTransparency = 0.3
fpsLabel.TextColor3 = Color3.new(1, 1, 1)

-- Ping Label (Chỉ hiển thị số, không có hình tròn)
pingLabel.Parent = screenGui
pingLabel.Size = UDim2.new(0, 443, 0, 29)
pingLabel.Position = UDim2.new(0, 50, 0, 80)
pingLabel.Font = Enum.Font.FredokaOne
pingLabel.TextScaled = true
pingLabel.BackgroundTransparency = 1
pingLabel.TextStrokeTransparency = 0.3
pingLabel.TextColor3 = Color3.new(1, 1, 1)

-- Toggle Button
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.Text = "ON"
toggleButton.TextScaled = true
toggleButton.AutoButtonColor = true
toggleButton.BorderSizePixel = 0
toggleButton.BackgroundTransparency = 0.2

toggleButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    fpsLabel.Visible = isVisible
    pingLabel.Visible = isVisible
    toggleButton.Text = isVisible and "ON" or "OFF"
end)

local function getFpsIcon(fps)
    if fps >= 15 then
        return "🟢"
    elseif fps >= 9 then
        return "🔵"
    elseif fps >= 4 then
        return "🔴"
    else
        return "⚫"
    end
end

local function rainbowColor()
    local hue = 0
    while true do
        hue = hue + 0.01
        if hue > 1 then hue = 0 end
        fpsLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        pingLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        RunService.RenderStepped:Wait()
    end
end

local frameCount = 0
local lastUpdate = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()

    if now - lastUpdate >= 1 then
        local fps = frameCount / (now - lastUpdate)
        frameCount = 0
        lastUpdate = now

        local userName = LocalPlayer.Name
        local hiddenName = string.rep("*", 4) .. string.sub(userName, 5)
        local ping = Stats.Network and Stats.Network.ServerStatsItem and Stats.Network.ServerStatsItem["Data Ping"] and Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 0

        local fpsIcon = getFpsIcon(math.floor(fps))
        fpsLabel.Text = string.format("%s, FPS: %d %s", hiddenName, math.floor(fps), fpsIcon)
        pingLabel.Text = string.format("🎮 Ping: %dms", math.floor(ping)) -- ❌ Không có hình tròn
    end
end)

spawn(rainbowColor)

