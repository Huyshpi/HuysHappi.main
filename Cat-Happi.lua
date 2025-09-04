NEXUSHIDEOUT = 15 -- This Is FPS In Game(Lock FPS)(Optimize Only When AFK With Kaitun Or One Click)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/FPS%20Boost"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI
-- Tạo Screen
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.Name = "BloxFruitsStatsMonitorV2"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

-- Toggle Button
local toggleButton = Instance.new("ImageButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(1, -110, 0, 10)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://119806198049474"
toggleButton.BorderSizePixel = 0

-- Hình turn on off
local catImageOn = "rbxassetid://119806198049474"
local catImageOff = "rbxassetid://119806198049474"

-- Tạo Main Frame V2
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrameV2"
mainFrame.Size = UDim2.new(0, 380, 0, 85)
mainFrame.Position = UDim2.new(0.5, -190, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Visible = true

-- Tạo corner 
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Rainbow animation
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Thickness = 3
stroke.Transparency = 0
stroke.LineJoinMode = Enum.LineJoinMode.Round
stroke.Parent = mainFrame

-- Enhanced Rainbow border animation with smoother transitions
spawn(function()
    local colors = {
        Color3.fromRGB(255, 0, 0),     -- Red
        Color3.fromRGB(255, 128, 0),   -- Orange  
        Color3.fromRGB(255, 255, 0),   -- Yellow
        Color3.fromRGB(128, 255, 0),   -- Yellow-Green
        Color3.fromRGB(0, 255, 0),     -- Green
        Color3.fromRGB(0, 255, 128),   -- Green-Cyan
        Color3.fromRGB(0, 255, 255),   -- Cyan
        Color3.fromRGB(0, 128, 255),   -- Cyan-Blue
        Color3.fromRGB(0, 0, 255),     -- Blue
        Color3.fromRGB(128, 0, 255),   -- Blue-Purple
        Color3.fromRGB(255, 0, 255),   -- Purple
        Color3.fromRGB(255, 0, 128)    -- Purple-Red
    }
    local colorIndex = 1
    
    while wait(0.3) do
        if mainFrame.Parent then
            local colorTween = TweenService:Create(stroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Color = colors[colorIndex]
            })
            colorTween:Play()
            
            colorIndex = colorIndex + 1
            if colorIndex > #colors then
                colorIndex = 1
            end
        end
    end
end)

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -24, 1, -24)
contentFrame.Position = UDim2.new(0, 12, 0, 12)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Job ID Input Section (moved to top - was at bottom)
local jobIdFrame = Instance.new("Frame")
jobIdFrame.Name = "JobIdFrame"
jobIdFrame.Size = UDim2.new(1, 0, 0, 30)
jobIdFrame.Position = UDim2.new(0, 0, 0, 0) -- Now at top position
jobIdFrame.BackgroundTransparency = 1
jobIdFrame.Parent = contentFrame

-- Job ID Input TextBox
local jobIdInput = Instance.new("TextBox")
jobIdInput.Size = UDim2.new(1, -52, 0, 22)
jobIdInput.Position = UDim2.new(0, 2, 0, 4)
jobIdInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jobIdInput.BackgroundTransparency = 0.1
jobIdInput.BorderColor3 = Color3.fromRGB(255, 255, 255)
jobIdInput.BorderSizePixel = 1
jobIdInput.Text = "Enter Job ID to join server..."
jobIdInput.TextColor3 = Color3.fromRGB(102, 102, 102)
jobIdInput.TextScaled = true
jobIdInput.Font = Enum.Font.Code
jobIdInput.TextXAlignment = Enum.TextXAlignment.Left
jobIdInput.ClipsDescendants = true
jobIdInput.ClearTextOnFocus = false
jobIdInput.Parent = jobIdFrame

-- Copy Job ID Button
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 45, 0, 22)
copyButton.Position = UDim2.new(1, -47, 0, 4)
copyButton.BackgroundColor3 = Color3.fromRGB(108, 117, 125)
copyButton.BackgroundTransparency = 0.1
copyButton.BorderSizePixel = 0
copyButton.Text = "Copy"
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextScaled = true
copyButton.Font = Enum.Font.SourceSans
copyButton.Parent = jobIdFrame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 6)
copyCorner.Parent = copyButton

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = jobIdInput

-- Divider Line (now between Job ID and Stats)
local divider = Instance.new("Frame")
divider.Name = "Divider"
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 0, 35) -- Moved divider position
divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
divider.BackgroundTransparency = 0.8
divider.BorderSizePixel = 0
divider.Parent = contentFrame

-- Stats Row (moved to bottom - was at top)
local statsRow = Instance.new("Frame")
statsRow.Name = "StatsRow"
statsRow.Size = UDim2.new(1, 0, 0, 24)
statsRow.Position = UDim2.new(0, 0, 0, 40) -- Now at bottom position
statsRow.BackgroundTransparency = 1
statsRow.Parent = contentFrame

-- FPS Section (left side)
local fpsFrame = Instance.new("Frame")
fpsFrame.Name = "FPSFrame"
fpsFrame.Size = UDim2.new(0.33, -10, 1, 0)
fpsFrame.Position = UDim2.new(0, 0, 0, 0)
fpsFrame.BackgroundTransparency = 1
fpsFrame.Parent = statsRow

-- Status Indicator (green dot)
local statusIndicator = Instance.new("Frame")
statusIndicator.Name = "StatusIndicator"
statusIndicator.Size = UDim2.new(0, 8, 0, 8)
statusIndicator.Position = UDim2.new(0, 0, 0.5, -4)
statusIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 65)
statusIndicator.BorderSizePixel = 0
statusIndicator.Parent = fpsFrame

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(0.5, 0)
indicatorCorner.Parent = statusIndicator

-- Pulse animation for status indicator
spawn(function()
    while true do
        if statusIndicator.Parent then
            local tween1 = TweenService:Create(statusIndicator, TweenInfo.new(1), {
                BackgroundTransparency = 0.3,
                Size = UDim2.new(0, 10, 0, 10)
            })
            tween1:Play()
        end
        wait(1)
        
        if statusIndicator.Parent then
            local tween2 = TweenService:Create(statusIndicator, TweenInfo.new(1), {
                BackgroundTransparency = 0,
                Size = UDim2.new(0, 8, 0, 8)
            })
            tween2:Play()
        end
        wait(1)
    end
end)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 30, 1, 0)
fpsLabel.Position = UDim2.new(0, 12, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS"
fpsLabel.TextColor3 = Color3.fromRGB(204, 204, 204)
fpsLabel.TextScaled = true
fpsLabel.Font = Enum.Font.SourceSans
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Parent = fpsFrame

local fpsValue = Instance.new("TextLabel")
fpsValue.Size = UDim2.new(0, 30, 1, 0)
fpsValue.Position = UDim2.new(0, 50, 0, 0)
fpsValue.BackgroundTransparency = 1
fpsValue.Text = "65"
fpsValue.TextColor3 = Color3.fromRGB(0, 255, 65)
fpsValue.TextScaled = true
fpsValue.Font = Enum.Font.SourceSansBold
fpsValue.TextXAlignment = Enum.TextXAlignment.Left
fpsValue.Parent = fpsFrame

-- Player Section (center)
local playerFrame = Instance.new("Frame")
playerFrame.Name = "PlayerFrame"
playerFrame.Size = UDim2.new(0.33, -10, 1, 0)
playerFrame.Position = UDim2.new(0.33, 5, 0, 0)
playerFrame.BackgroundTransparency = 1
playerFrame.Parent = statsRow

local playerLabel = Instance.new("TextLabel")
playerLabel.Size = UDim2.new(0, 50, 1, 0)
playerLabel.Position = UDim2.new(0, 0, 0, 0)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = "Player"
playerLabel.TextColor3 = Color3.fromRGB(204, 204, 204)
playerLabel.TextScaled = true
playerLabel.Font = Enum.Font.SourceSans
playerLabel.TextXAlignment = Enum.TextXAlignment.Left
playerLabel.Parent = playerFrame

local playerValue = Instance.new("TextLabel")
playerValue.Size = UDim2.new(0, 50, 1, 0)
playerValue.Position = UDim2.new(0, 60, 0, 0)
playerValue.BackgroundTransparency = 1
playerValue.Text = "21/24"
playerValue.TextColor3 = Color3.fromRGB(55, 66, 250)
playerValue.TextScaled = true
playerValue.Font = Enum.Font.SourceSansBold
playerValue.TextXAlignment = Enum.TextXAlignment.Left
playerValue.Parent = playerFrame

-- Spam Join Section (right side)
local spamJoinFrame = Instance.new("Frame")
spamJoinFrame.Name = "SpamJoinFrame"
spamJoinFrame.Size = UDim2.new(0.34, -10, 1, 0)
spamJoinFrame.Position = UDim2.new(0.66, 10, 0, 0)
spamJoinFrame.BackgroundTransparency = 1
spamJoinFrame.Parent = statsRow

local spamJoinLabel = Instance.new("TextLabel")
spamJoinLabel.Size = UDim2.new(0, 80, 1, 0)
spamJoinLabel.Position = UDim2.new(0, 0, 0, 0)
spamJoinLabel.BackgroundTransparency = 1
spamJoinLabel.Text = "Spam Join"
spamJoinLabel.TextColor3 = Color3.fromRGB(204, 204, 204)
spamJoinLabel.TextScaled = true
spamJoinLabel.Font = Enum.Font.SourceSans
spamJoinLabel.TextXAlignment = Enum.TextXAlignment.Left
spamJoinLabel.Parent = spamJoinFrame

-- Toggle Switch Background
local toggleBackground = Instance.new("Frame")
toggleBackground.Size = UDim2.new(0, 36, 0, 20)
toggleBackground.Position = UDim2.new(0, 85, 0.5, -10)
toggleBackground.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
toggleBackground.BorderSizePixel = 0
toggleBackground.Parent = spamJoinFrame

local toggleBgCorner = Instance.new("UICorner")
toggleBgCorner.CornerRadius = UDim.new(0, 10)
toggleBgCorner.Parent = toggleBackground

-- Toggle Switch Slider
local toggleSlider = Instance.new("Frame")
toggleSlider.Size = UDim2.new(0, 16, 0, 16)
toggleSlider.Position = UDim2.new(0, 2, 0, 2)
toggleSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleSlider.BorderSizePixel = 0
toggleSlider.Parent = toggleBackground

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0.5, 0)
sliderCorner.Parent = toggleSlider

-- Toggle Button
local autoJoinToggle = Instance.new("TextButton")
autoJoinToggle.Size = UDim2.new(0, 36, 0, 20)
autoJoinToggle.Position = UDim2.new(0, 85, 0.5, -10)
autoJoinToggle.BackgroundTransparency = 1
autoJoinToggle.Text = ""
autoJoinToggle.Parent = spamJoinFrame

-- ================== MODERN NOTIFICATION SYSTEM ==================
local currentNotification = nil
local notificationContainer = Instance.new("Frame")
notificationContainer.Name = "NotificationContainer"
notificationContainer.Size = UDim2.new(0, 320, 0, 200)
notificationContainer.Position = UDim2.new(1, -340, 0, 98) -- Positioned below main frame
notificationContainer.BackgroundTransparency = 1
notificationContainer.Parent = screenGui
notificationContainer.ZIndex = 2000

-- Modern Notification Function
local function showNotification(title, message, notifType, duration)
    -- Remove existing notification
    if currentNotification and currentNotification.Parent then
        local hideOut = TweenService:Create(currentNotification, TweenInfo.new(0.2), {
            Position = UDim2.new(1, 50, 0, 0),
            BackgroundTransparency = 1
        })
        hideOut:Play()
        hideOut.Completed:Connect(function()
            if currentNotification and currentNotification.Parent then
                currentNotification:Destroy()
            end
        end)
    end
    
    -- Default values
    message = message or ""
    notifType = notifType or "success"
    duration = duration or 3000
    
    -- Create new notification
    local notification = Instance.new("Frame")
    notification.Name = "ModernNotification"
    notification.Size = UDim2.new(0, 280, 0, 60)
    notification.Position = UDim2.new(1, 300, 0, 0) -- Start off-screen
    notification.BackgroundColor3 = Color3.fromRGB(40, 167, 69) -- Default success color
    notification.BackgroundTransparency = 0.05
    notification.BorderSizePixel = 0
    notification.Parent = notificationContainer
    notification.ZIndex = 2001
    currentNotification = notification
    
    -- Color based on type
    if notifType == "error" then
        notification.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    elseif notifType == "info" then
        notification.BackgroundColor3 = Color3.fromRGB(55, 66, 250)
    elseif notifType == "warning" then
        notification.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
    end
    
    -- Rounded corners
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 12)
    notifCorner.Parent = notification
    
    -- Glassmorphism stroke
    local notifStroke = Instance.new("UIStroke")
    notifStroke.Color = Color3.fromRGB(255, 255, 255)
    notifStroke.Transparency = 0.8
    notifStroke.Thickness = 1
    notifStroke.Parent = notification
    
    -- Icon background
    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(0, 36, 0, 36)
    iconFrame.Position = UDim2.new(0, 12, 0.5, -18)
    iconFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    iconFrame.BackgroundTransparency = 0.2
    iconFrame.BorderSizePixel = 0
    iconFrame.Parent = notification
    iconFrame.ZIndex = 2002
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0.5, 0)
    iconCorner.Parent = iconFrame
    
    -- Icon text
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(1, 0, 1, 0)
    iconLabel.Position = UDim2.new(0, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = "✓" -- Default success icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.TextScaled = true
    iconLabel.Font = Enum.Font.SourceSansBold
    iconLabel.Parent = iconFrame
    iconLabel.ZIndex = 2003
    
    -- Icon based on type
    if notifType == "error" then
        iconLabel.Text = "✕"
    elseif notifType == "info" then
        iconLabel.Text = "ℹ"
    elseif notifType == "warning" then
        iconLabel.Text = "⚠"
    end
    
    -- Content frame
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(0, 200, 1, -20)
    contentArea.Position = UDim2.new(0, 60, 0, 10)
    contentArea.BackgroundTransparency = 1
    contentArea.Parent = notification
    contentArea.ZIndex = 2002
    
    -- Title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 20)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Top
    titleLabel.Parent = contentArea
    titleLabel.ZIndex = 2003
    
    -- Message label (if provided)
    local messageLabel
    if message ~= "" then
        messageLabel = Instance.new("TextLabel")
        messageLabel.Size = UDim2.new(1, 0, 0, 15)
        messageLabel.Position = UDim2.new(0, 0, 0, 22)
        messageLabel.BackgroundTransparency = 1
        messageLabel.Text = message
        messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        messageLabel.TextTransparency = 0.2
        messageLabel.TextSize = 11
        messageLabel.Font = Enum.Font.SourceSans
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.TextYAlignment = Enum.TextYAlignment.Top
        messageLabel.Parent = contentArea
        messageLabel.ZIndex = 2003
    end
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -28, 0, 8)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BackgroundTransparency = 0.8
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = notification
    closeButton.ZIndex = 2003
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0.5, 0)
    closeBtnCorner.Parent = closeButton
    
    -- Progress bar
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(1, 0, 0, 3)
    progressBar.Position = UDim2.new(0, 0, 1, -3)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressBar.BackgroundTransparency = 0.7
    progressBar.BorderSizePixel = 0
    progressBar.Parent = notification
    progressBar.ZIndex = 2002
    
    -- Slide in animation
    local slideIn = TweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -300, 0, 0)
    })
    slideIn:Play()
    
    -- Progress bar animation
    local progress = 1
    local progressTween = TweenService:Create(progressBar, TweenInfo.new(duration/1000, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 3)
    })
    progressTween:Play()
    
    -- Auto hide after duration
    local autoHide = coroutine.create(function()
        wait(duration/1000)
        if notification and notification.Parent then
            local slideOut = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 50, 0, 0),
                BackgroundTransparency = 1
            })
            slideOut:Play()
            slideOut.Completed:Connect(function()
                if notification and notification.Parent then
                    notification:Destroy()
                    if currentNotification == notification then
                        currentNotification = nil
                    end
                end
            end)
        end
    end)
    coroutine.resume(autoHide)
    
    -- Close button event
    closeButton.MouseButton1Click:Connect(function()
        if notification and notification.Parent then
            local slideOut = TweenService:Create(notification, TweenInfo.new(0.3), {
                Position = UDim2.new(1, 50, 0, 0),
                BackgroundTransparency = 1
            })
            slideOut:Play()
            slideOut.Completed:Connect(function()
                if notification and notification.Parent then
                    notification:Destroy()
                    if currentNotification == notification then
                        currentNotification = nil
                    end
                end
            end)
        end
    end)
    
    -- Hover effects
    closeButton.MouseEnter:Connect(function()
        local hoverIn = TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.6,
            Size = UDim2.new(0, 22, 0, 22)
        })
        hoverIn:Play()
    end)
    
    closeButton.MouseLeave:Connect(function()
        local hoverOut = TweenService:Create(closeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.8,
            Size = UDim2.new(0, 20, 0, 20)
        })
        hoverOut:Play()
    end)
end

-- Variables
local startTime = tick()
local autoEnabled = true
local isVisible = true
local autoJoinEnabled = false
local spamJoinJobId = ""

-- ================== FUNCTIONS ==================
-- Join server by Job ID
local function joinServerByJobId(jobId)
    local success, error = pcall(function()
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        
        showNotification("Joining Server", "Connecting to " .. string.sub(jobId, 1, 8) .. "...", "info", 2000)
        TeleportService:TeleportToPlaceInstance(PlaceId, jobId, player)
    end)
    
    if not success then
        showNotification("Join Failed", "Unable to connect - trying again...", "error", 3000)
    end
end

-- Clean and validate Job ID
local function cleanAndValidateJobId(jobId)
    if not jobId or jobId == "" then return nil end
    
    local cleanJobId = jobId:gsub("%s", ""):gsub("[^%w%-]", "")
    
    if cleanJobId and cleanJobId:match("^[%w%-]+$") and string.len(cleanJobId) >= 10 then
        return cleanJobId
    end
    
    return nil
end

-- Get current server's Job ID
local function getCurrentJobId()
    local success, jobId = pcall(function()
        return game.JobId
    end)
    
    if success and jobId and jobId ~= "" then
        return jobId
    end
    
    return nil
end

-- Copy to clipboard function
local function copyToClipboard(text)
    local success, error = pcall(function()
        if setclipboard then
            setclipboard(text)
            return true
        elseif syn and syn.write_clipboard then
            syn.write_clipboard(text)
            return true
        elseif Clipboard and Clipboard.set then
            Clipboard.set(text)
            return true
        else
            return false
        end
    end)
    
    return success
end

-- Get real FPS
local function getRealFPS()
    local fps = 0
    local lastTick = tick()
    local frames = 0
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        frames = frames + 1
        local currentTick = tick()
        
        if currentTick - lastTick >= 1 then
            fps = frames
            frames = 0
            lastTick = currentTick
        end
    end)
    
    return function()
        return fps
    end
end

local function getPlayerCount()
    return #Players:GetPlayers()
end

local function getMaxPlayers()
    return Players.MaxPlayers
end

local function updateFPSColor(fps)
    local color
    if fps >= 0 and fps <= 7 then
        color = Color3.fromRGB(255, 68, 68)
    elseif fps >= 8 and fps <= 14 then
        color = Color3.fromRGB(255, 165, 0)
    else
        color = Color3.fromRGB(0, 255, 65)
    end
    fpsValue.TextColor3 = color
end

-- Get FPS function
local getFPS = getRealFPS()

-- ================== EVENT HANDLERS ==================
-- Toggle Button Event (Improved ON/OFF Interface)
toggleButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    
    -- Smooth animation for main frame
    if isVisible then
        mainFrame.Visible = true
        local showTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -190, 0, 10),
            BackgroundTransparency = 0.1
        })
        showTween:Play()
        
        toggleButton.Image = catImageOn
        
        -- Show notification
        spawn(function()
            showNotification("Stats Monitor", "Interface is now visible", "success", 2000)
        end)
    else
        local hideTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -190, 0, -100),
            BackgroundTransparency = 1
        })
        hideTween:Play()
        
        hideTween.Completed:Connect(function()
            mainFrame.Visible = false
        end)
        
        toggleButton.Image = catImageOff
        
        spawn(function()
            showNotification("Stats Monitor", "Interface is now hidden", "info", 2000)
        end)
    end
    
    -- Button press animation
    local pressIn = TweenService:Create(toggleButton, TweenInfo.new(0.1), {
        Size = UDim2.new(0, 45, 0, 45)
    })
    pressIn:Play()
    
    pressIn.Completed:Connect(function()
        local pressOut = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 50, 0, 50)
        })
        pressOut:Play()
    end)
end)

-- Copy Button Event Handler
copyButton.MouseButton1Click:Connect(function()
    local currentJobId = getCurrentJobId()
    
    if currentJobId then
        local success = copyToClipboard(currentJobId)
        
        if success then
            -- Visual feedback on button
            local originalColor = copyButton.BackgroundColor3
            copyButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
            copyButton.Text = "✓"
            
            spawn(function()
                showNotification("Job ID Copied!", "ID: " .. string.sub(currentJobId, 1, 12) .. "... copied to clipboard", "success", 3000)
                
                wait(2)
                
                copyButton.BackgroundColor3 = originalColor
                copyButton.Text = "Copy"
            end)
        else
            spawn(function()
                showNotification("Copy Failed", "Clipboard access not supported", "error", 3000)
            end)
        end
    else
        spawn(function()
            showNotification("No Job ID", "Current server Job ID not available", "warning", 3000)
        end)
    end
end)

-- Auto Join Toggle Event
autoJoinToggle.MouseButton1Click:Connect(function()
    autoJoinEnabled = not autoJoinEnabled
    
    if autoJoinEnabled then
        -- Animation to ON state
        local colorTween = TweenService:Create(toggleBackground, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        })
        local sliderTween = TweenService:Create(toggleSlider, TweenInfo.new(0.3), {
            Position = UDim2.new(0, 18, 0, 2)
        })
        
        colorTween:Play()
        sliderTween:Play()
        
        spawn(function()
            showNotification("Spam Join Activated", "Auto-join feature is now enabled", "success", 3000)
        end)
    else
        -- Animation to OFF state
        local colorTween = TweenService:Create(toggleBackground, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        })
        local sliderTween = TweenService:Create(toggleSlider, TweenInfo.new(0.3), {
            Position = UDim2.new(0, 2, 0, 2)
        })
        
        colorTween:Play()
        sliderTween:Play()
        
        spawn(function()
            showNotification("Spam Join Deactivated", "Auto-join feature is now disabled", "warning", 3000)
        end)
    end
end)

-- Job ID Input Events
jobIdInput.Focused:Connect(function()
    if jobIdInput.Text == "Enter Job ID to join server..." then
        jobIdInput.Text = ""
        jobIdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    -- Focus border effect
    local focusTween = TweenService:Create(jobIdInput, TweenInfo.new(0.3), {
        BorderColor3 = Color3.fromRGB(0, 123, 255)
    })
    focusTween:Play()
end)

jobIdInput.FocusLost:Connect(function()
    -- Remove focus border effect
    local blurTween = TweenService:Create(jobIdInput, TweenInfo.new(0.3), {
        BorderColor3 = Color3.fromRGB(255, 255, 255)
    })
    blurTween:Play()
    
    local inputText = jobIdInput.Text
    
    if inputText == "" or inputText == "Enter Job ID to join server..." then
        jobIdInput.Text = "Enter Job ID to join server..."
        jobIdInput.TextColor3 = Color3.fromRGB(102, 102, 102)
    else
        -- Clean and validate Job ID
        local cleanJobId = cleanAndValidateJobId(inputText)
        
        if cleanJobId then
            spamJoinJobId = cleanJobId
            spawn(function()
                showNotification("Job ID Validated", "Server ID saved: " .. string.sub(cleanJobId, 1, 10) .. "...", "success", 3000)
                joinServerByJobId(cleanJobId)
            end)
        else
            spawn(function()
                showNotification("Invalid Job ID", "Please enter a valid server Job ID format", "error", 3000)
            end)
        end
        
        -- Clear text for next input
        spawn(function()
            wait(1)
            jobIdInput.Text = "Enter Job ID to join server..."
            jobIdInput.TextColor3 = Color3.fromRGB(102, 102, 102)
        end)
    end
end)

-- Update stats function
local function updateStats()
    if not autoEnabled then return end
    
    -- Update FPS
    local currentFPS = getFPS()
    fpsValue.Text = tostring(currentFPS)
    updateFPSColor(currentFPS)
    
    -- Update Players
    local currentPlayers = getPlayerCount()
    local maxPlayers = getMaxPlayers()
    local playersText = currentPlayers .. "/" .. maxPlayers
    playerValue.Text = playersText
end

-- Spam Join Loop
spawn(function()
    while true do
        if autoJoinEnabled and spamJoinJobId ~= "" then
            local cleanJobId = cleanAndValidateJobId(spamJoinJobId)
            if cleanJobId then
                spawn(function()
                    showNotification("Auto Joining", "Attempting to join " .. string.sub(cleanJobId, 1, 8) .. "...", "info", 1500)
                end)
                joinServerByJobId(cleanJobId)
            end
        end
        wait(0.5)
    end
end)

-- Main update loop
spawn(function()
    while true do
        updateStats()
        wait(1)
    end
end)

-- Clean initialization - no auto notifications
