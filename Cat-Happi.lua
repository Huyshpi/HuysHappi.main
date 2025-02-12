for i, v in next, workspace:GetDescendants() do
    pcall(function()
        if v:IsA("BasePart") then
            v.Transparency = 1
        elseif v:IsA("Sound") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v:Destroy()
        end
    end)
end

for i, v in next, getnilinstances() do
    pcall(function()
        if v:IsA("BasePart") then
            v.Transparency = 1
        elseif v:IsA("Sound") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v:Destroy()
        end

        for i1, v1 in next, v:GetDescendants() do
            pcall(function()
                if v1:IsA("BasePart") then
                    v1.Transparency = 1
                elseif v1:IsA("Sound") then
                    v1:Destroy()
                elseif v1:IsA("ParticleEmitter") or v1:IsA("Trail") then
                    v1:Destroy()
                end
            end)
        end
    end)
end

workspace.DescendantAdded:Connect(function(v)
    pcall(function()
        if v:IsA("BasePart") then
            v.Transparency = 1
        elseif v:IsA("Sound") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v:Destroy()
        end
    end)
end)

wait(0.3)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
local textLabel = Instance.new("TextLabel")

screenGui.Parent = game.CoreGui
screenGui.DisplayOrder = 100

textLabel.Parent = screenGui
textLabel.Size = UDim2.new(0, 300, 0, 35) -- Kích thước nhỏ gọn
textLabel.Position = UDim2.new(0, 50, 0, 60) -- Điều chỉnh để nằm bên trái
textLabel.Font = Enum.Font.FredokaOne
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1 -- Nền trong suốt
textLabel.TextStrokeTransparency = 0 -- Viền chữ rõ ràng hơn
textLabel.TextColor3 = Color3.new(1, 1, 1) -- Màu chữ trắng

local function rainbowColor()
     local HuysHappi = 0
    while true do
        HuysHappi = HuysHappi + 0.01
        if HuysHappi > 1 then HuysHappi = 0 end
        textLabel.TextColor3 = Color3.fromHSV(HuysHappi, 1, 1) -- Màu chữ đổi liên tục
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

        -- Hiển thị tên tài khoản Roblox kèm FPS
        local userName = LocalPlayer.Name
        textLabel.Text = string.format("%s, FPS: %d", userName, math.floor(fps))
    end
end)

spawn(rainbowColor)
