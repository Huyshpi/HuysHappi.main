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

local screenGui = Instance.new("ScreenGui")
local fpsLabel = Instance.new("TextLabel")
local pingLabel = Instance.new("TextLabel")

screenGui.Parent = game.CoreGui
screenGui.DisplayOrder = 100

-- FPS & Username Label
fpsLabel.Parent = screenGui
fpsLabel.Size = UDim2.new(0, 300, 0, 30)
fpsLabel.Position = UDim2.new(0, 70, 0, 63) -- Điều chỉnh vị trí
fpsLabel.Font = Enum.Font.FredokaOne
fpsLabel.TextScaled = true
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextStrokeTransparency = 0
fpsLabel.TextColor3 = Color3.new(1, 1, 1)

-- Ping Label (Có thể chỉnh vị trí riêng)
pingLabel.Parent = screenGui
pingLabel.Size = UDim2.new(0, 443, 0, 29)
pingLabel.Position = UDim2.new(0, 50, 0, 83) -- Điều chỉnh vị trí Ping tại đây
pingLabel.Font = Enum.Font.FredokaOne
pingLabel.TextScaled = true
pingLabel.BackgroundTransparency = 1
pingLabel.TextStrokeTransparency = 0
pingLabel.TextColor3 = Color3.new(1, 1, 1)

local function rainbowColor()
    local HuysHappi = 0
    while true do
        HuysHappi = HuysHappi + 0.01
        if HuysHappi > 1 then HuysHappi = 0 end
        fpsLabel.TextColor3 = Color3.fromHSV(HuysHappi, 1, 1)
        pingLabel.TextColor3 = Color3.fromHSV(HuysHappi, 1, 1) -- Ping cũng đổi màu
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

        -- Ẩn 4 ký tự đầu tiên của tên tài khoản
        local userName = LocalPlayer.Name
        local hiddenName = string.rep("*", 4) .. string.sub(userName, 5)

        -- Lấy giá trị Ping
        local ping = Stats.Network and Stats.Network.ServerStatsItem and Stats.Network.ServerStatsItem["Data Ping"] and Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 0

        -- Cập nhật văn bản
        fpsLabel.Text = string.format("%s,🚀 FPS: %d", hiddenName, math.floor(fps))
        pingLabel.Text = string.format("🎮 Ping: %dms", math.floor(ping))
    end
end)

spawn(rainbowColor)
