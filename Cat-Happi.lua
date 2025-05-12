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
local Stats = game:GetService("Stats")

-- GUI cha
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 100
screenGui.Parent = game.CoreGui

-- ⚙️ Cài đặt chung cho từng Label
local function createLabel(text, size, position)
    local label = Instance.new("TextLabel")
    label.Parent = screenGui
    label.Size = size
    label.Position = position
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0.3
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = text
    return label
end

-- 🟢 Tạo từng Label riêng biệt
local fpsLabel = createLabel("FPS: ?", UDim2.new(0, 308, 0, 31), UDim2.new(0.5, -230, 0, 16)) 
local dividerLabel = createLabel("|", UDim2.new(0, 86, 0, 33), UDim2.new(0.5, -40, 0, 14)) 
local pingLabel = createLabel("Ping: ?", UDim2.new(0, 208, 0, 31), UDim2.new(0.5, 10, 0, 16)) 

-- Tạo nút toggle với hình con mèo
local toggleButton = Instance.new("ImageButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 700, 0, 10)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://119806198049474"
toggleButton.BorderSizePixel = 0

-- Hình cho trạng thái BẬT và TẮT
local catImageOn = "rbxassetid://119806198049474"
local catImageOff = "rbxassetid://119806198049474"

-- Chuyển đổi trạng thái BẬT/TẮT
local isVisible = true
toggleButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    fpsLabel.Visible = isVisible
    dividerLabel.Visible = isVisible
    pingLabel.Visible = isVisible
    toggleButton.Image = isVisible and catImageOn or catImageOff
end)

-- Hiệu ứng cầu vồng cho cả FPS và Ping
local function rainbowColor()
    local hue = 0
    while true do
        hue = hue + 0.005
        if hue > 1 then hue = 0 end
        local color = Color3.fromHSV(hue, 1, 1)
        fpsLabel.TextColor3 = color
        pingLabel.TextColor3 = color -- Áp dụng cho Ping
        RunService.RenderStepped:Wait()
    end
end

-- Cập nhật chỉ số
local frameCount = 0
local lastUpdate = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()

    if now - lastUpdate >= 1 then
        local fps = frameCount / (now - lastUpdate)
        frameCount = 0
        lastUpdate = now

        local ping = Stats.Network and Stats.Network.ServerStatsItem and Stats.Network.ServerStatsItem["Data Ping"] and Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 0

        fpsLabel.Text = string.format("FPS: %d", math.floor(fps))
        pingLabel.Text = string.format("Ping: %d ms", math.floor(ping))
    end
end)

-- Bắt đầu hiệu ứng cầu vồng
spawn(rainbowColor)
