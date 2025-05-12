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
	label.Font = Enum.Font.FredokaOne  -- Giữ font FredokaOne
	label.TextScaled = true
	label.BackgroundTransparency = 1
	label.TextStrokeTransparency = 0.1  -- Giảm độ trong suốt của viền chữ
	label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Tăng độ dày viền chữ
	label.TextColor3 = Color3.new(1, 1, 1)  -- Màu chữ trắng
	label.Text = text
	return label
end

-- 🟢 Tạo từng Label riêng biệt
local fpsLabel = createLabel("FPS: ?", UDim2.new(0, 308, 0, 31), UDim2.new(0.5, -230, 0, 16)) 
local dividerLabel = createLabel("|",     UDim2.new(0, 86,  0, 33), UDim2.new(0.5, -40,  0, 14)) 
local pingLabel = createLabel("Ping: ?", UDim2.new(0, 208, 0, 31), UDim2.new(0.5, 10,   0, 16)) 

-- 🎨 Đặt màu tím đậm cho dấu |
dividerLabel.TextColor3 = Color3.fromRGB(128, 0, 255)  -- Tím đậm hơn

-- Nút toggle
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(0, 590, 0, 10) 
toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.Text = "ON"
toggleButton.TextScaled = true
toggleButton.AutoButtonColor = true
toggleButton.BorderSizePixel = 0
toggleButton.BackgroundTransparency = 0.2

-- Toggle visibility
local isVisible = true
toggleButton.MouseButton1Click:Connect(function()
	isVisible = not isVisible
	fpsLabel.Visible = isVisible
	dividerLabel.Visible = isVisible
	pingLabel.Visible = isVisible
	toggleButton.Text = isVisible and "ON" or "OFF"
end)

-- 🌈 Hiệu ứng cầu vồng chậm cho FPS và Ping
local function slowRainbowColor()
	local hue = 0
	while true do
		hue = hue + 0.0025 -- chậm hơn (giảm từ 0.01)
		if hue > 1 then hue = 0 end
		local color = Color3.fromHSV(hue, 1, 1)
		fpsLabel.TextColor3 = color
		pingLabel.TextColor3 = color
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

-- Bắt đầu hiệu ứng cầu vồng chậm
spawn(slowRainbowColor)
