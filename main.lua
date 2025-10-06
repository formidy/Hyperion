local HyperionUI = {}
HyperionUI.__index = HyperionUI
HyperionUI.DEBUG_MODE = false
HyperionUI.VERSION = "1.1.0"

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local ZINDEX = {
    Base = 1,
    Sidebar = 10,
    Content = 20,
    Topbar = 30,
    Controls = 40,
    Dropdown = 500,
    ColorPicker = 1000,
    Modal = 5000,
    Notification = 10000
}

local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

local ThemePresets = {
    Dark = {
        bg1 = Color3.fromRGB(17, 17, 19),
        bg2 = Color3.fromRGB(23, 23, 26),
        bg3 = Color3.fromRGB(30, 30, 34),
        bg4 = Color3.fromRGB(38, 38, 42),
        bg5 = Color3.fromRGB(45, 45, 50),
        primary = Color3.fromRGB(99, 102, 241),
        secondary = Color3.fromRGB(139, 92, 246),
        text1 = Color3.fromRGB(248, 248, 252),
        text2 = Color3.fromRGB(168, 168, 184),
        text3 = Color3.fromRGB(108, 108, 124),
        border = Color3.fromRGB(45, 45, 50),
        success = Color3.fromRGB(34, 197, 94),
        warning = Color3.fromRGB(234, 179, 8),
        error = Color3.fromRGB(239, 68, 68),
    },
    Light = {
        bg1 = Color3.fromRGB(255, 255, 255),
        bg2 = Color3.fromRGB(249, 250, 251),
        bg3 = Color3.fromRGB(243, 244, 246),
        bg4 = Color3.fromRGB(229, 231, 235),
        bg5 = Color3.fromRGB(209, 213, 219),
        primary = Color3.fromRGB(99, 102, 241),
        secondary = Color3.fromRGB(139, 92, 246),
        text1 = Color3.fromRGB(17, 24, 39),
        text2 = Color3.fromRGB(75, 85, 99),
        text3 = Color3.fromRGB(156, 163, 175),
        border = Color3.fromRGB(229, 231, 235),
        success = Color3.fromRGB(34, 197, 94),
        warning = Color3.fromRGB(234, 179, 8),
        error = Color3.fromRGB(239, 68, 68),
    },
    Midnight = {
        bg1 = Color3.fromRGB(10, 10, 15),
        bg2 = Color3.fromRGB(15, 15, 22),
        bg3 = Color3.fromRGB(20, 20, 30),
        bg4 = Color3.fromRGB(30, 30, 45),
        bg5 = Color3.fromRGB(40, 40, 60),
        primary = Color3.fromRGB(56, 189, 248),
        secondary = Color3.fromRGB(34, 211, 238),
        text1 = Color3.fromRGB(241, 245, 249),
        text2 = Color3.fromRGB(148, 163, 184),
        text3 = Color3.fromRGB(100, 116, 139),
        border = Color3.fromRGB(30, 41, 59),
        success = Color3.fromRGB(34, 197, 94),
        warning = Color3.fromRGB(251, 191, 36),
        error = Color3.fromRGB(248, 113, 113),
    },
    Purple = {
        bg1 = Color3.fromRGB(24, 17, 31),
        bg2 = Color3.fromRGB(31, 24, 40),
        bg3 = Color3.fromRGB(40, 31, 52),
        bg4 = Color3.fromRGB(52, 40, 66),
        bg5 = Color3.fromRGB(64, 50, 80),
        primary = Color3.fromRGB(168, 85, 247),
        secondary = Color3.fromRGB(217, 70, 239),
        text1 = Color3.fromRGB(250, 245, 255),
        text2 = Color3.fromRGB(196, 181, 253),
        text3 = Color3.fromRGB(147, 125, 194),
        border = Color3.fromRGB(88, 28, 135),
        success = Color3.fromRGB(134, 239, 172),
        warning = Color3.fromRGB(253, 224, 71),
        error = Color3.fromRGB(252, 165, 165),
    },
    Ocean = {
        bg1 = Color3.fromRGB(15, 23, 42),
        bg2 = Color3.fromRGB(30, 41, 59),
        bg3 = Color3.fromRGB(51, 65, 85),
        bg4 = Color3.fromRGB(71, 85, 105),
        bg5 = Color3.fromRGB(100, 116, 139),
        primary = Color3.fromRGB(14, 165, 233),
        secondary = Color3.fromRGB(6, 182, 212),
        text1 = Color3.fromRGB(248, 250, 252),
        text2 = Color3.fromRGB(203, 213, 225),
        text3 = Color3.fromRGB(148, 163, 184),
        border = Color3.fromRGB(51, 65, 85),
        success = Color3.fromRGB(16, 185, 129),
        warning = Color3.fromRGB(245, 158, 11),
        error = Color3.fromRGB(239, 68, 68),
    },
    Forest = {
        bg1 = Color3.fromRGB(20, 30, 20),
        bg2 = Color3.fromRGB(30, 45, 30),
        bg3 = Color3.fromRGB(40, 60, 40),
        bg4 = Color3.fromRGB(50, 75, 50),
        bg5 = Color3.fromRGB(60, 90, 60),
        primary = Color3.fromRGB(34, 197, 94),
        secondary = Color3.fromRGB(74, 222, 128),
        text1 = Color3.fromRGB(240, 253, 244),
        text2 = Color3.fromRGB(187, 247, 208),
        text3 = Color3.fromRGB(134, 239, 172),
        border = Color3.fromRGB(22, 101, 52),
        success = Color3.fromRGB(74, 222, 128),
        warning = Color3.fromRGB(250, 204, 21),
        error = Color3.fromRGB(248, 113, 113),
    },
    Sunset = {
        bg1 = Color3.fromRGB(30, 15, 15),
        bg2 = Color3.fromRGB(45, 25, 25),
        bg3 = Color3.fromRGB(60, 35, 35),
        bg4 = Color3.fromRGB(75, 45, 45),
        bg5 = Color3.fromRGB(90, 55, 55),
        primary = Color3.fromRGB(251, 146, 60),
        secondary = Color3.fromRGB(251, 113, 133),
        text1 = Color3.fromRGB(254, 242, 242),
        text2 = Color3.fromRGB(254, 205, 211),
        text3 = Color3.fromRGB(252, 165, 165),
        border = Color3.fromRGB(127, 29, 29),
        success = Color3.fromRGB(74, 222, 128),
        warning = Color3.fromRGB(251, 191, 36),
        error = Color3.fromRGB(248, 113, 113),
    },
    Dracula = {
        bg1 = Color3.fromRGB(40, 42, 54),
        bg2 = Color3.fromRGB(68, 71, 90),
        bg3 = Color3.fromRGB(98, 114, 164),
        bg4 = Color3.fromRGB(139, 148, 188),
        bg5 = Color3.fromRGB(189, 147, 249),
        primary = Color3.fromRGB(189, 147, 249),
        secondary = Color3.fromRGB(255, 121, 198),
        text1 = Color3.fromRGB(248, 248, 242),
        text2 = Color3.fromRGB(241, 250, 140),
        text3 = Color3.fromRGB(139, 233, 253),
        border = Color3.fromRGB(68, 71, 90),
        success = Color3.fromRGB(80, 250, 123),
        warning = Color3.fromRGB(241, 250, 140),
        error = Color3.fromRGB(255, 85, 85),
    },
    Nord = {
        bg1 = Color3.fromRGB(46, 52, 64),
        bg2 = Color3.fromRGB(59, 66, 82),
        bg3 = Color3.fromRGB(67, 76, 94),
        bg4 = Color3.fromRGB(76, 86, 106),
        bg5 = Color3.fromRGB(94, 129, 172),
        primary = Color3.fromRGB(136, 192, 208),
        secondary = Color3.fromRGB(129, 161, 193),
        text1 = Color3.fromRGB(236, 239, 244),
        text2 = Color3.fromRGB(229, 233, 240),
        text3 = Color3.fromRGB(216, 222, 233),
        border = Color3.fromRGB(76, 86, 106),
        success = Color3.fromRGB(163, 190, 140),
        warning = Color3.fromRGB(235, 203, 139),
        error = Color3.fromRGB(191, 97, 106),
    },
    Monokai = {
        bg1 = Color3.fromRGB(39, 40, 34),
        bg2 = Color3.fromRGB(49, 51, 45),
        bg3 = Color3.fromRGB(73, 72, 62),
        bg4 = Color3.fromRGB(102, 102, 93),
        bg5 = Color3.fromRGB(117, 113, 94),
        primary = Color3.fromRGB(249, 38, 114),
        secondary = Color3.fromRGB(174, 129, 255),
        text1 = Color3.fromRGB(248, 248, 240),
        text2 = Color3.fromRGB(230, 219, 116),
        text3 = Color3.fromRGB(117, 113, 94),
        border = Color3.fromRGB(73, 72, 62),
        success = Color3.fromRGB(166, 226, 46),
        warning = Color3.fromRGB(230, 219, 116),
        error = Color3.fromRGB(249, 38, 114),
    },
    Gruvbox = {
        bg1 = Color3.fromRGB(40, 40, 40),
        bg2 = Color3.fromRGB(60, 56, 54),
        bg3 = Color3.fromRGB(80, 73, 69),
        bg4 = Color3.fromRGB(102, 92, 84),
        bg5 = Color3.fromRGB(124, 111, 100),
        primary = Color3.fromRGB(251, 184, 108),
        secondary = Color3.fromRGB(254, 128, 25),
        text1 = Color3.fromRGB(251, 241, 199),
        text2 = Color3.fromRGB(235, 219, 178),
        text3 = Color3.fromRGB(213, 196, 161),
        border = Color3.fromRGB(80, 73, 69),
        success = Color3.fromRGB(184, 187, 38),
        warning = Color3.fromRGB(250, 189, 47),
        error = Color3.fromRGB(251, 73, 52),
    },
    Catppuccin = {
        bg1 = Color3.fromRGB(30, 30, 46),
        bg2 = Color3.fromRGB(36, 39, 58),
        bg3 = Color3.fromRGB(49, 50, 68),
        bg4 = Color3.fromRGB(69, 71, 90),
        bg5 = Color3.fromRGB(88, 91, 112),
        primary = Color3.fromRGB(203, 166, 247),
        secondary = Color3.fromRGB(245, 194, 231),
        text1 = Color3.fromRGB(205, 214, 244),
        text2 = Color3.fromRGB(186, 194, 222),
        text3 = Color3.fromRGB(166, 173, 200),
        border = Color3.fromRGB(69, 71, 90),
        success = Color3.fromRGB(166, 227, 161),
        warning = Color3.fromRGB(249, 226, 175),
        error = Color3.fromRGB(243, 139, 168),
    }
}

local StylePresets = {
    Modern = {
        type = "sidebar",
        sidebarWidth = 200,
        topBarHeight = 60,
        cornerRadius = 10,
        buttonHeight = 42,
        spacing = 12,
        padding = 16,
        borderWidth = 1,
        sidebarPosition = "left",
        contentPadding = 24,
        fontTitle = Enum.Font.GothamBold,
        fontBody = Enum.Font.GothamMedium,
        fontMono = Enum.Font.RobotoMono,
        mainSize = UDim2.new(0, 920, 0, 580),
        animationSpeed = 0.2,
        shadowEnabled = true
    },
    Compact = {
        type = "sidebar",
        sidebarWidth = 60,
        topBarHeight = 50,
        cornerRadius = 6,
        buttonHeight = 36,
        spacing = 8,
        padding = 12,
        borderWidth = 0,
        sidebarPosition = "left",
        contentPadding = 16,
        fontTitle = Enum.Font.GothamBold,
        fontBody = Enum.Font.Gotham,
        fontMono = Enum.Font.Code,
        mainSize = UDim2.new(0, 800, 0, 500),
        animationSpeed = 0.15,
        shadowEnabled = false
    },
    Minimal = {
        type = "topbar",
        sidebarWidth = 0,
        topBarHeight = 45,
        cornerRadius = 8,
        buttonHeight = 40,
        spacing = 10,
        padding = 14,
        borderWidth = 1,
        sidebarPosition = "none",
        contentPadding = 20,
        fontTitle = Enum.Font.GothamBold,
        fontBody = Enum.Font.Gotham,
        fontMono = Enum.Font.Code,
        mainSize = UDim2.new(0, 850, 0, 550),
        animationSpeed = 0.2,
        shadowEnabled = false
    },
    Glass = {
        type = "sidebar",
        sidebarWidth = 220,
        topBarHeight = 70,
        cornerRadius = 16,
        buttonHeight = 44,
        spacing = 14,
        padding = 18,
        borderWidth = 1,
        sidebarPosition = "left",
        contentPadding = 26,
        fontTitle = Enum.Font.GothamBold,
        fontBody = Enum.Font.GothamMedium,
        fontMono = Enum.Font.Code,
        mainSize = UDim2.new(0, 950, 0, 600),
        animationSpeed = 0.25,
        transparency = 0.1,
        shadowEnabled = true
    },
    Mobile = {
        type = "sidebar",
        sidebarWidth = 180,
        topBarHeight = 70,
        cornerRadius = 12,
        buttonHeight = 52,
        spacing = 16,
        padding = 20,
        borderWidth = 2,
        sidebarPosition = "left",
        contentPadding = 28,
        fontTitle = Enum.Font.GothamBold,
        fontBody = Enum.Font.GothamMedium,
        fontMono = Enum.Font.RobotoMono,
        mainSize = UDim2.new(0.95, 0, 0.9, 0),
        animationSpeed = 0.3,
        shadowEnabled = true,
        touchOptimized = true
    },
    Classic = {
        type = "sidebar",
        sidebarWidth = 180,
        topBarHeight = 50,
        cornerRadius = 4,
        buttonHeight = 38,
        spacing = 10,
        padding = 14,
        borderWidth = 2,
        sidebarPosition = "left",
        contentPadding = 18,
        fontTitle = Enum.Font.SourceSansBold,
        fontBody = Enum.Font.SourceSans,
        fontMono = Enum.Font.Code,
        mainSize = UDim2.new(0, 800, 0, 520),
        animationSpeed = 0.1,
        shadowEnabled = false
    },
    Flat = {
        type = "sidebar",
        sidebarWidth = 190,
        topBarHeight = 55,
        cornerRadius = 0,
        buttonHeight = 40,
        spacing = 8,
        padding = 15,
        borderWidth = 1,
        sidebarPosition = "left",
        contentPadding = 20,
        fontTitle = Enum.Font.GothamBold,
        fontBody = Enum.Font.Gotham,
        fontMono = Enum.Font.Code,
        mainSize = UDim2.new(0, 880, 0, 560),
        animationSpeed = 0.15,
        shadowEnabled = false
    },
    Neumorphic = {
        type = "sidebar",
        sidebarWidth = 210,
        topBarHeight = 65,
        cornerRadius = 20,
        buttonHeight = 46,
        spacing = 14,
        padding = 18,
        borderWidth = 0,
        sidebarPosition = "left",
        contentPadding = 24,
        fontTitle = Enum.Font.GothamBold,
        fontBody = Enum.Font.GothamMedium,
        fontMono = Enum.Font.RobotoMono,
        mainSize = UDim2.new(0, 940, 0, 590),
        animationSpeed = 0.25,
        shadowEnabled = true,
        softShadow = true
    }
}

local function debugPrint(...)
    if HyperionUI.DEBUG_MODE then
        print("[HyperionUI DEBUG]", ...)
    end
end

local function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        debugPrint("Error:", result)
    end
    return success, result
end

local function deepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = deepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
    local self = setmetatable({}, Signal)
    self.connections = {}
    return self
end

function Signal:Connect(callback)
    local connection = {
        callback = callback,
        connected = true
    }
    
    table.insert(self.connections, connection)
    
    return {
        Disconnect = function()
            connection.connected = false
            for i, conn in ipairs(self.connections) do
                if conn == connection then
                    table.remove(self.connections, i)
                    break
                end
            end
        end
    }
end

function Signal:Fire(...)
    for _, connection in ipairs(self.connections) do
        if connection.connected then
            safeCall(connection.callback, ...)
        end
    end
end

function Signal:DisconnectAll()
    for _, connection in ipairs(self.connections) do
        connection.connected = false
    end
    self.connections = {}
end

local ThemeManager = {}
ThemeManager.__index = ThemeManager

function ThemeManager.new(presetName)
    local self = setmetatable({}, ThemeManager)
    self.currentPreset = presetName or "Dark"
    self.colors = deepCopy(ThemePresets[self.currentPreset] or ThemePresets.Dark)
    self.trackedObjects = {}
    self.customColors = {}
    return self
end

function ThemeManager:SetPreset(presetName)
    if ThemePresets[presetName] then
        self.currentPreset = presetName
        self.colors = deepCopy(ThemePresets[presetName])
        for key, value in pairs(self.customColors) do
            self.colors[key] = value
        end
        self:UpdateAll()
        return true
    end
    return false
end

function ThemeManager:SetColor(colorKey, color)
    self.customColors[colorKey] = color
    self.colors[colorKey] = color
    self:UpdateAll()
    return self
end

function ThemeManager:GetColor(colorKey)
    return self.colors[colorKey]
end

function ThemeManager:CreateCustomTheme(name, colors)
    ThemePresets[name] = deepCopy(colors)
    return self
end

function ThemeManager:Track(object, property, colorKey, isGradient)
    table.insert(self.trackedObjects, {
        object = object,
        property = property,
        colorKey = colorKey,
        isGradient = isGradient or false
    })
end

function ThemeManager:UpdateAll()
    for _, data in ipairs(self.trackedObjects) do
        safeCall(function()
            if data.object and data.object.Parent then
                local color = self.colors[data.colorKey]
                if color then
                    if data.isGradient then
                        if data.object:IsA("UIGradient") then
                            data.object.Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0, self.colors.primary),
                                ColorSequenceKeypoint.new(1, self.colors.secondary)
                            }
                        end
                    else
                        data.object[data.property] = color
                    end
                end
            end
        end)
    end
end

local Component = {}
Component.__index = Component

function Component.new(parent, theme, style, window)
    local self = setmetatable({}, Component)
    self.parent = parent
    self.theme = theme
    self.style = style
    self.window = window
    self.instance = nil
    self.destroyed = false
    self.modalElements = {}
    self.enabled = true
    self.visible = true
    self.tooltip = nil
    
    self.Changed = Signal.new()
    self.Destroyed = Signal.new()
    
    return self
end

function Component:SetEnabled(enabled)
    self.enabled = enabled
    if self.instance then
        self.instance.Visible = enabled and self.visible
    end
    return self
end

function Component:SetVisible(visible)
    self.visible = visible
    if self.instance then
        self.instance.Visible = visible and self.enabled
    end
    return self
end

function Component:SetTooltip(text)
    self.tooltip = text
    return self
end

function Component:OnChange(callback)
    self.Changed:Connect(callback)
    return self
end

function Component:Destroy()
    if not self.destroyed then
        self.destroyed = true
        self.Destroyed:Fire()
        self.Changed:DisconnectAll()
        self.Destroyed:DisconnectAll()
        
        safeCall(function()
            for _, modal in ipairs(self.modalElements) do
                if modal and modal.Parent then
                    modal:Destroy()
                end
            end
            if self.instance then
                self.instance:Destroy()
            end
        end)
    end
end

local Toggle = setmetatable({}, {__index = Component})
Toggle.__index = Toggle

function Toggle.new(parent, theme, style, window, text, default, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), Toggle)
    self.text = text
    self.value = default or false
    self.callback = callback
    self:Create()
    return self
end

function Toggle:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 44, 0, 24)
    switch.Position = UDim2.new(1, -52, 0.5, -12)
    switch.BackgroundColor3 = self.value and self.theme.colors.primary or self.theme.colors.border
    switch.BorderSizePixel = 0
    switch.ZIndex = ZINDEX.Content + 1
    switch.Parent = container
    
    self.theme:Track(switch, "BackgroundColor3", self.value and "primary" or "border")
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switch
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = self.value and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    knob.BackgroundColor3 = self.theme.colors.bg1
    knob.BorderSizePixel = 0
    knob.ZIndex = ZINDEX.Content + 2
    knob.Parent = switch
    
    self.theme:Track(knob, "BackgroundColor3", "bg1")
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.ZIndex = ZINDEX.Content + 3
    button.Parent = container
    
    self.switch = switch
    self.knob = knob
    
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    if isMobile() then
        button.TouchTap:Connect(function()
            self:Toggle()
        end)
    end
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function Toggle:Toggle()
    self.value = not self.value
    
    safeCall(function()
        TweenService:Create(self.switch, TweenInfo.new(self.style.animationSpeed, Enum.EasingStyle.Quad), {
            BackgroundColor3 = self.value and self.theme.colors.primary or self.theme.colors.border
        }):Play()
        
        TweenService:Create(self.knob, TweenInfo.new(self.style.animationSpeed, Enum.EasingStyle.Quad), {
            Position = self.value and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        }):Play()
        
        if self.callback then
            self.callback(self.value)
        end
        self.Changed:Fire(self.value)
    end)
    
    return self
end

function Toggle:SetValue(value)
    if value ~= self.value then
        self:Toggle()
    end
    return self
end

function Toggle:GetValue()
    return self.value
end

local Slider = setmetatable({}, {__index = Component})
Slider.__index = Slider

function Slider.new(parent, theme, style, window, text, min, max, default, increment, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), Slider)
    self.text = text
    self.min = min
    self.max = max
    self.value = default or min
    self.increment = increment
    self.callback = callback
    self:Create()
    return self
end

function Slider:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 64)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, -24, 0, 24)
    header.Position = UDim2.new(0, 12, 0, 10)
    header.BackgroundTransparency = 1
    header.ZIndex = ZINDEX.Content
    header.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = header
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.35, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.65, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(self.value)
    valueLabel.TextColor3 = self.theme.colors.primary
    valueLabel.TextSize = 13
    valueLabel.Font = self.style.fontTitle
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.ZIndex = ZINDEX.Content
    valueLabel.Parent = header
    
    self.theme:Track(valueLabel, "TextColor3", "primary")
    self.valueLabel = valueLabel
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -24, 0, 4)
    track.Position = UDim2.new(0, 12, 1, -14)
    track.BackgroundColor3 = self.theme.colors.border
    track.BorderSizePixel = 0
    track.ZIndex = ZINDEX.Content + 1
    track.Parent = container
    
    self.theme:Track(track, "BackgroundColor3", "border")
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((self.value - self.min) / (self.max - self.min), 0, 1, 0)
    fill.BackgroundColor3 = self.theme.colors.primary
    fill.BorderSizePixel = 0
    fill.ZIndex = ZINDEX.Content + 2
    fill.Parent = track
    
    self.theme:Track(fill, "BackgroundColor3", "primary")
    self.fill = fill
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 14, 0, 14)
    thumb.Position = UDim2.new((self.value - self.min) / (self.max - self.min), -7, 0.5, -7)
    thumb.BackgroundColor3 = self.theme.colors.bg1
    thumb.BorderSizePixel = 0
    thumb.ZIndex = ZINDEX.Content + 3
    thumb.Parent = track
    
    self.theme:Track(thumb, "BackgroundColor3", "bg1")
    self.thumb = thumb
    self.track = track
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb
    
    local thumbBorder = Instance.new("UIStroke")
    thumbBorder.Color = self.theme.colors.primary
    thumbBorder.Thickness = 2
    thumbBorder.Parent = thumb
    
    self.theme:Track(thumbBorder, "Color", "primary")
    
    local dragging = false
    
    local function update(input)
        safeCall(function()
            local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local value = self.min + (self.max - self.min) * pos
            
            if self.increment then
                value = math.floor(value / self.increment + 0.5) * self.increment
            end
            
            value = math.clamp(value, self.min, self.max)
            local norm = (value - self.min) / (self.max - self.min)
            
            fill.Size = UDim2.new(norm, 0, 1, 0)
            thumb.Position = UDim2.new(norm, -7, 0.5, -7)
            valueLabel.Text = tostring(value)
            
            self.value = value
            
            if self.callback then
                self.callback(value)
            end
            self.Changed:Fire(value)
        end)
    end
    
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
            safeCall(function()
                TweenService:Create(thumb, TweenInfo.new(self.style.animationSpeed), {Size = UDim2.new(0, 18, 0, 18)}):Play()
            end)
        end
    end)
    
    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            safeCall(function()
                TweenService:Create(thumb, TweenInfo.new(self.style.animationSpeed), {Size = UDim2.new(0, 14, 0, 14)}):Play()
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        if not dragging then
            safeCall(function()
                TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
            end)
        end
    end)
end

function Slider:SetValue(value)
    value = math.clamp(value, self.min, self.max)
    if self.increment then
        value = math.floor(value / self.increment + 0.5) * self.increment
    end
    
    local norm = (value - self.min) / (self.max - self.min)
    self.value = value
    
    safeCall(function()
        self.fill.Size = UDim2.new(norm, 0, 1, 0)
        self.thumb.Position = UDim2.new(norm, -7, 0.5, -7)
        self.valueLabel.Text = tostring(value)
    end)
    
    return self
end

function Slider:GetValue()
    return self.value
end

function Slider:SetMin(min)
    self.min = min
    self:SetValue(self.value)
    return self
end

function Slider:SetMax(max)
    self.max = max
    self:SetValue(self.value)
    return self
end

local Button = setmetatable({}, {__index = Component})
Button.__index = Button

function Button.new(parent, theme, style, window, text, callback, color)
    local self = setmetatable(Component.new(parent, theme, style, window), Button)
    self.text = text
    self.callback = callback
    self.color = color
    self.Clicked = Signal.new()
    self:Create()
    return self
end

function Button:Create()
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    button.BackgroundColor3 = self.color or self.theme.colors.primary
    button.BorderSizePixel = 0
    button.Text = self.text
    button.TextColor3 = self.theme.colors.bg1
    button.TextSize = 13
    button.Font = self.style.fontTitle
    button.AutoButtonColor = false
    button.ZIndex = ZINDEX.Content
    button.Parent = self.parent
    self.instance = button
    
    if not self.color then
        self.theme:Track(button, "BackgroundColor3", "primary")
    end
    self.theme:Track(button, "TextColor3", "bg1")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        safeCall(function()
            TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(1, 0, 0, self.style.buttonHeight - 2)
            }):Play()
            task.wait(0.1)
            TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
            }):Play()
            
            if self.callback then
                self.callback()
            end
            self.Clicked:Fire()
            self.Changed:Fire()
        end)
    end)
    
    if isMobile() then
        button.TouchTap:Connect(function()
            if self.callback then
                self.callback()
            end
            self.Clicked:Fire()
            self.Changed:Fire()
        end)
    end
    
    button.MouseEnter:Connect(function()
        safeCall(function()
            local current = button.BackgroundColor3
            local hoverColor = Color3.new(
                math.min(current.R + 0.05, 1),
                math.min(current.G + 0.05, 1),
                math.min(current.B + 0.05, 1)
            )
            TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = hoverColor}):Play()
        end)
    end)
    
    button.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.color or self.theme.colors.primary}):Play()
        end)
    end)
end

function Button:SetText(text)
    self.text = text
    if self.instance then
        self.instance.Text = text
    end
    return self
end

function Button:GetText()
    return self.text
end

local Label = setmetatable({}, {__index = Component})
Label.__index = Label

function Label.new(parent, theme, style, window, text, size)
    local self = setmetatable(Component.new(parent, theme, style, window), Label)
    self.text = text
    self.textSize = size or 13
    self:Create()
    return self
end

function Label:Create()
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = self.textSize
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.ZIndex = ZINDEX.Content
    label.Parent = self.parent
    self.instance = label
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.Parent = label
end

function Label:SetText(text)
    self.text = text
    if self.instance then
        self.instance.Text = text
    end
    return self
end

function Label:SetSize(size)
    self.textSize = size
    if self.instance then
        self.instance.TextSize = size
    end
    return self
end

function Label:SetColor(color)
    if self.instance then
        self.instance.TextColor3 = color
    end
    return self
end

local Badge = setmetatable({}, {__index = Component})
Badge.__index = Badge

function Badge.new(parent, theme, style, window, text, count, color)
    local self = setmetatable(Component.new(parent, theme, style, window), Badge)
    self.text = text
    self.count = count or 0
    self.color = color or "primary"
    self:Create()
    return self
end

function Badge:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 32)
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local badge = Instance.new("Frame")
    badge.Size = UDim2.new(0, 0, 0, 24)
    badge.Position = UDim2.new(0, 12, 0.5, -12)
    badge.AutomaticSize = Enum.AutomaticSize.X
    badge.BackgroundColor3 = self.theme.colors[self.color] or self.theme.colors.primary
    badge.BorderSizePixel = 0
    badge.ZIndex = ZINDEX.Content
    badge.Parent = container
    
    self.theme:Track(badge, "BackgroundColor3", self.color)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = badge
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.Parent = badge
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = self.text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 11
    textLabel.Font = self.style.fontTitle
    textLabel.ZIndex = ZINDEX.Content
    textLabel.Parent = badge
    
    if self.count > 0 then
        local countBadge = Instance.new("Frame")
        countBadge.Size = UDim2.new(0, 20, 0, 20)
        countBadge.Position = UDim2.new(1, -10, 0, -10)
        countBadge.BackgroundColor3 = self.theme.colors.error
        countBadge.BorderSizePixel = 0
        countBadge.ZIndex = ZINDEX.Content + 1
        countBadge.Parent = badge
        self.countBadge = countBadge
        
        self.theme:Track(countBadge, "BackgroundColor3", "error")
        
        local countCorner = Instance.new("UICorner")
        countCorner.CornerRadius = UDim.new(1, 0)
        countCorner.Parent = countBadge
        
        local countStroke = Instance.new("UIStroke")
        countStroke.Color = self.theme.colors.bg1
        countStroke.Thickness = 2
        countStroke.Parent = countBadge
        
        self.theme:Track(countStroke, "Color", "bg1")
        
        local countLabel = Instance.new("TextLabel")
        countLabel.Size = UDim2.new(1, 0, 1, 0)
        countLabel.BackgroundTransparency = 1
        countLabel.Text = tostring(self.count)
        countLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        countLabel.TextSize = 10
        countLabel.Font = self.style.fontTitle
        countLabel.ZIndex = ZINDEX.Content + 1
        countLabel.Parent = countBadge
        self.countLabel = countLabel
    end
end

function Badge:SetText(text)
    self.text = text
    return self
end

function Badge:SetCount(count)
    self.count = count
    if self.countLabel then
        self.countLabel.Text = tostring(count)
        self.countBadge.Visible = count > 0
    end
    return self
end

function Badge:Increment()
    self:SetCount(self.count + 1)
    return self
end

local Card = setmetatable({}, {__index = Component})
Card.__index = Card

function Card.new(parent, theme, style, window, title, description)
    local self = setmetatable(Component.new(parent, theme, style, window), Card)
    self.title = title
    self.description = description
    self.components = {}
    self:Create()
    return self
end

function Card:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg2
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg2")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    if self.style.borderWidth > 0 then
        local stroke = Instance.new("UIStroke")
        stroke.Color = self.theme.colors.border
        stroke.Thickness = self.style.borderWidth
        stroke.Transparency = 0.5
        stroke.Parent = container
        
        self.theme:Track(stroke, "Color", "border")
    end
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, self.style.padding)
    padding.PaddingRight = UDim.new(0, self.style.padding)
    padding.PaddingTop = UDim.new(0, self.style.padding)
    padding.PaddingBottom = UDim.new(0, self.style.padding)
    padding.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = container
    
    if self.title then
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0, 24)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = self.title
        titleLabel.TextColor3 = self.theme.colors.text1
        titleLabel.TextSize = 16
        titleLabel.Font = self.style.fontTitle
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.LayoutOrder = 1
        titleLabel.ZIndex = ZINDEX.Content
        titleLabel.Parent = container
        
        self.theme:Track(titleLabel, "TextColor3", "text1")
    end
    
    if self.description then
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, 0, 0, 0)
        descLabel.AutomaticSize = Enum.AutomaticSize.Y
        descLabel.BackgroundTransparency = 1
        descLabel.Text = self.description
        descLabel.TextColor3 = self.theme.colors.text2
        descLabel.TextSize = 12
        descLabel.Font = self.style.fontBody
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextYAlignment = Enum.TextYAlignment.Top
        descLabel.TextWrapped = true
        descLabel.LayoutOrder = 2
        descLabel.ZIndex = ZINDEX.Content
        descLabel.Parent = container
        
        self.theme:Track(descLabel, "TextColor3", "text2")
    end
    
    local content = Instance.new("Frame")
    content.Name = "CardContent"
    content.Size = UDim2.new(1, 0, 0, 0)
    content.AutomaticSize = Enum.AutomaticSize.Y
    content.BackgroundTransparency = 1
    content.LayoutOrder = 3
    content.ZIndex = ZINDEX.Content
    content.Parent = container
    self.content = content
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = content
end

function Card:AddElement(element)
    if element.instance then
        element.instance.Parent = self.content
        table.insert(self.components, element)
    end
    return self
end

local Image = setmetatable({}, {__index = Component})
Image.__index = Image

function Image.new(parent, theme, style, window, imageId, size)
    local self = setmetatable(Component.new(parent, theme, style, window), Image)
    self.imageId = imageId
    self.imageSize = size or UDim2.new(0, 100, 0, 100)
    self:Create()
    return self
end

function Image:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.imageSize.Y.Offset + 20)
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = self.imageSize
    imageLabel.Position = UDim2.new(0.5, -self.imageSize.X.Offset/2, 0, 10)
    imageLabel.BackgroundColor3 = self.theme.colors.bg3
    imageLabel.BorderSizePixel = 0
    imageLabel.Image = self.imageId
    imageLabel.ScaleType = Enum.ScaleType.Fit
    imageLabel.ZIndex = ZINDEX.Content
    imageLabel.Parent = container
    self.imageLabel = imageLabel
    
    self.theme:Track(imageLabel, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = imageLabel
end

function Image:SetImage(imageId)
    self.imageId = imageId
    if self.imageLabel then
        self.imageLabel.Image = imageId
    end
    return self
end

function Image:SetSize(size)
    self.imageSize = size
    if self.imageLabel then
        self.imageLabel.Size = size
        self.instance.Size = UDim2.new(1, 0, 0, size.Y.Offset + 20)
    end
    return self
end

local StatsDisplay = setmetatable({}, {__index = Component})
StatsDisplay.__index = StatsDisplay

function StatsDisplay.new(parent, theme, style, window, columns)
    local self = setmetatable(Component.new(parent, theme, style, window), StatsDisplay)
    self.columns = columns or 2
    self.stats = {}
    self:Create()
    return self
end

function StatsDisplay:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, self.style.padding)
    padding.PaddingRight = UDim.new(0, self.style.padding)
    padding.PaddingTop = UDim.new(0, self.style.padding)
    padding.PaddingBottom = UDim.new(0, self.style.padding)
    padding.Parent = container
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(1 / self.columns, -self.style.spacing, 0, 60)
    gridLayout.CellPadding = UDim2.new(0, self.style.spacing, 0, self.style.spacing)
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Parent = container
    self.gridLayout = gridLayout
end

function StatsDisplay:AddStat(label, value, color)
    local stat = Instance.new("Frame")
    stat.BackgroundColor3 = self.theme.colors.bg2
    stat.BorderSizePixel = 0
    stat.ZIndex = ZINDEX.Content
    stat.LayoutOrder = #self.stats + 1
    stat.Parent = self.instance
    
    self.theme:Track(stat, "BackgroundColor3", "bg2")
    
    local statCorner = Instance.new("UICorner")
    statCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    statCorner.Parent = stat
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(1, -16, 0, 18)
    labelText.Position = UDim2.new(0, 8, 0, 8)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = self.theme.colors.text2
    labelText.TextSize = 11
    labelText.Font = self.style.fontBody
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.ZIndex = ZINDEX.Content
    labelText.Parent = stat
    
    self.theme:Track(labelText, "TextColor3", "text2")
    
    local valueText = Instance.new("TextLabel")
    valueText.Size = UDim2.new(1, -16, 0, 28)
    valueText.Position = UDim2.new(0, 8, 0, 26)
    valueText.BackgroundTransparency = 1
    valueText.Text = tostring(value)
    valueText.TextColor3 = color or self.theme.colors.text1
    valueText.TextSize = 20
    valueText.Font = self.style.fontTitle
    valueText.TextXAlignment = Enum.TextXAlignment.Left
    valueText.ZIndex = ZINDEX.Content
    valueText.Parent = stat
    
    if not color then
        self.theme:Track(valueText, "TextColor3", "text1")
    end
    
    table.insert(self.stats, {frame = stat, valueLabel = valueText, label = label})
    return stat
end

function StatsDisplay:UpdateStat(label, value)
    for _, stat in ipairs(self.stats) do
        if stat.label == label then
            stat.valueLabel.Text = tostring(value)
            break
        end
    end
    return self
end

local Console = setmetatable({}, {__index = Component})
Console.__index = Console

function Console.new(parent, theme, style, window, height, maxLines)
    local self = setmetatable(Component.new(parent, theme, style, window), Console)
    self.height = height or 200
    self.maxLines = maxLines or 100
    self.lines = {}
    self:Create()
    return self
end

function Console:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.height)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -16, 1, -16)
    scrollFrame.Position = UDim2.new(0, 8, 0, 8)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = self.theme.colors.text3
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.ZIndex = ZINDEX.Content
    scrollFrame.Parent = container
    self.scrollFrame = scrollFrame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = scrollFrame
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasPosition = Vector2.new(0, layout.AbsoluteContentSize.Y)
    end)
end

function Console:Log(message, color)
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, 0, 0, 0)
    line.AutomaticSize = Enum.AutomaticSize.Y
    line.BackgroundTransparency = 1
    line.Text = "[" .. os.date("%H:%M:%S") .. "] " .. message
    line.TextColor3 = color or self.theme.colors.text1
    line.TextSize = 11
    line.Font = self.style.fontMono
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.TextYAlignment = Enum.TextYAlignment.Top
    line.TextWrapped = true
    line.LayoutOrder = #self.lines + 1
    line.ZIndex = ZINDEX.Content
    line.Parent = self.scrollFrame
    
    if not color then
        self.theme:Track(line, "TextColor3", "text1")
    end
    
    table.insert(self.lines, line)
    
    if #self.lines > self.maxLines then
        self.lines[1]:Destroy()
        table.remove(self.lines, 1)
    end
    
    return self
end

function Console:Clear()
    for _, line in ipairs(self.lines) do
        line:Destroy()
    end
    self.lines = {}
    return self
end

function Console:Info(message)
    return self:Log(message, self.theme.colors.primary)
end

function Console:Success(message)
    return self:Log(message, self.theme.colors.success)
end

function Console:Warning(message)
    return self:Log(message, self.theme.colors.warning)
end

function Console:Error(message)
    return self:Log(message, self.theme.colors.error)
end

local Table = setmetatable({}, {__index = Component})
Table.__index = Table

function Table.new(parent, theme, style, window, columns)
    local self = setmetatable(Component.new(parent, theme, style, window), Table)
    self.columns = columns or {}
    self.rows = {}
    self:Create()
    return self
end

function Table:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    if #self.columns > 0 then
        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, 36)
        header.BackgroundColor3 = self.theme.colors.bg4
        header.BorderSizePixel = 0
        header.ZIndex = ZINDEX.Content
        header.Parent = container
        
        self.theme:Track(header, "BackgroundColor3", "bg4")
        
        local headerCorner = Instance.new("UICorner")
        headerCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
        headerCorner.Parent = header
        
        local headerCover = Instance.new("Frame")
        headerCover.Size = UDim2.new(1, 0, 0, self.style.cornerRadius)
        headerCover.Position = UDim2.new(0, 0, 1, -self.style.cornerRadius)
        headerCover.BackgroundColor3 = self.theme.colors.bg4
        headerCover.BorderSizePixel = 0
        headerCover.ZIndex = ZINDEX.Content
        headerCover.Parent = header
        
        self.theme:Track(headerCover, "BackgroundColor3", "bg4")
        
        local headerLayout = Instance.new("UIListLayout")
        headerLayout.FillDirection = Enum.FillDirection.Horizontal
        headerLayout.SortOrder = Enum.SortOrder.LayoutOrder
        headerLayout.Parent = header
        
        for i, column in ipairs(self.columns) do
            local headerCell = Instance.new("TextLabel")
            headerCell.Size = UDim2.new(1 / #self.columns, 0, 1, 0)
            headerCell.BackgroundTransparency = 1
            headerCell.Text = column
            headerCell.TextColor3 = self.theme.colors.text1
            headerCell.TextSize = 12
            headerCell.Font = self.style.fontTitle
            headerCell.TextXAlignment = Enum.TextXAlignment.Center
            headerCell.LayoutOrder = i
            headerCell.ZIndex = ZINDEX.Content
            headerCell.Parent = header
            
            self.theme:Track(headerCell, "TextColor3", "text1")
        end
    end
    
    local tableContainer = Instance.new("Frame")
    tableContainer.Name = "TableContainer"
    tableContainer.Size = UDim2.new(1, 0, 0, 0)
    tableContainer.Position = UDim2.new(0, 0, 0, #self.columns > 0 and 36 or 0)
    tableContainer.AutomaticSize = Enum.AutomaticSize.Y
    tableContainer.BackgroundTransparency = 1
    tableContainer.ZIndex = ZINDEX.Content
    tableContainer.Parent = container
    self.tableContainer = tableContainer
    
    local tableLayout = Instance.new("UIListLayout")
    tableLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tableLayout.Padding = UDim.new(0, 1)
    tableLayout.Parent = tableContainer
end

function Table:AddRow(data)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundColor3 = #self.rows % 2 == 0 and self.theme.colors.bg2 or self.theme.colors.bg3
    row.BorderSizePixel = 0
    row.LayoutOrder = #self.rows + 1
    row.ZIndex = ZINDEX.Content
    row.Parent = self.tableContainer
    
    self.theme:Track(row, "BackgroundColor3", #self.rows % 2 == 0 and "bg2" or "bg3")
    
    local rowLayout = Instance.new("UIListLayout")
    rowLayout.FillDirection = Enum.FillDirection.Horizontal
    rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
    rowLayout.Parent = row
    
    for i, value in ipairs(data) do
        local cell = Instance.new("TextLabel")
        cell.Size = UDim2.new(1 / #data, 0, 1, 0)
        cell.BackgroundTransparency = 1
        cell.Text = tostring(value)
        cell.TextColor3 = self.theme.colors.text1
        cell.TextSize = 11
        cell.Font = self.style.fontBody
        cell.TextXAlignment = Enum.TextXAlignment.Center
        cell.TextTruncate = Enum.TextTruncate.AtEnd
        cell.LayoutOrder = i
        cell.ZIndex = ZINDEX.Content
        cell.Parent = row
        
        self.theme:Track(cell, "TextColor3", "text1")
    end
    
    table.insert(self.rows, row)
    return row
end

function Table:Clear()
    for _, row in ipairs(self.rows) do
        row:Destroy()
    end
    self.rows = {}
    return self
end



local Paragraph = setmetatable({}, {__index = Component})
Paragraph.__index = Paragraph

function Paragraph.new(parent, theme, style, window, text)
    local self = setmetatable(Component.new(parent, theme, style, window), Paragraph)
    self.text = text
    self:Create()
    return self
end

function Paragraph:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = container
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0, 0)
    textLabel.AutomaticSize = Enum.AutomaticSize.Y
    textLabel.BackgroundTransparency = 1
    textLabel.Text = self.text
    textLabel.TextColor3 = self.theme.colors.text2
    textLabel.TextSize = 12
    textLabel.Font = self.style.fontBody
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.TextWrapped = true
    textLabel.ZIndex = ZINDEX.Content
    textLabel.Parent = container
    self.textLabel = textLabel
    
    self.theme:Track(textLabel, "TextColor3", "text2")
end

function Paragraph:SetText(text)
    self.text = text
    if self.textLabel then
        self.textLabel.Text = text
    end
    return self
end

local RadioGroup = setmetatable({}, {__index = Component})
RadioGroup.__index = RadioGroup

function RadioGroup.new(parent, theme, style, window, title, options, default, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), RadioGroup)
    self.title = title
    self.options = options or {}
    self.value = default or (options and options[1])
    self.callback = callback
    self.buttons = {}
    self:Create()
    return self
end

function RadioGroup:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.PaddingTop = UDim.new(0, 12)
    padding.PaddingBottom = UDim.new(0, 12)
    padding.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = container
    
    if self.title then
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0, 20)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = self.title
        titleLabel.TextColor3 = self.theme.colors.text1
        titleLabel.TextSize = 13
        titleLabel.Font = self.style.fontTitle
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.LayoutOrder = 0
        titleLabel.ZIndex = ZINDEX.Content
        titleLabel.Parent = container
        
        self.theme:Track(titleLabel, "TextColor3", "text1")
    end
    
    for i, option in ipairs(self.options) do
        local radioButton = Instance.new("Frame")
        radioButton.Size = UDim2.new(1, 0, 0, 32)
        radioButton.BackgroundColor3 = self.theme.colors.bg2
        radioButton.BorderSizePixel = 0
        radioButton.LayoutOrder = i
        radioButton.ZIndex = ZINDEX.Content
        radioButton.Parent = container
        
        self.theme:Track(radioButton, "BackgroundColor3", "bg2")
        
        local rbCorner = Instance.new("UICorner")
        rbCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
        rbCorner.Parent = radioButton
        
        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 18, 0, 18)
        circle.Position = UDim2.new(0, 10, 0.5, -9)
        circle.BackgroundColor3 = self.theme.colors.bg4
        circle.BorderSizePixel = 0
        circle.ZIndex = ZINDEX.Content + 1
        circle.Parent = radioButton
        
        self.theme:Track(circle, "BackgroundColor3", "bg4")
        
        local circleCorner = Instance.new("UICorner")
        circleCorner.CornerRadius = UDim.new(1, 0)
        circleCorner.Parent = circle
        
        local circleStroke = Instance.new("UIStroke")
        circleStroke.Color = self.theme.colors.border
        circleStroke.Thickness = 2
        circleStroke.Parent = circle
        
        self.theme:Track(circleStroke, "Color", "border")
        
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 10, 0, 10)
        dot.Position = UDim2.new(0.5, -5, 0.5, -5)
        dot.BackgroundColor3 = self.theme.colors.primary
        dot.BorderSizePixel = 0
        dot.Visible = option == self.value
        dot.ZIndex = ZINDEX.Content + 2
        dot.Parent = circle
        
        self.theme:Track(dot, "BackgroundColor3", "primary")
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -44, 1, 0)
        label.Position = UDim2.new(0, 36, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = option
        label.TextColor3 = self.theme.colors.text1
        label.TextSize = 12
        label.Font = self.style.fontBody
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = ZINDEX.Content
        label.Parent = radioButton
        
        self.theme:Track(label, "TextColor3", "text1")
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundTransparency = 1
        button.Text = ""
        button.ZIndex = ZINDEX.Content + 3
        button.Parent = radioButton
        
        button.MouseButton1Click:Connect(function()
            self:SetValue(option)
        end)
        
        if isMobile() then
            button.TouchTap:Connect(function()
                self:SetValue(option)
            end)
        end
        
        radioButton.MouseEnter:Connect(function()
            TweenService:Create(radioButton, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
        
        radioButton.MouseLeave:Connect(function()
            TweenService:Create(radioButton, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg2}):Play()
        end)
        
        table.insert(self.buttons, {frame = radioButton, dot = dot, option = option})
    end
end

function RadioGroup:SetValue(value)
    self.value = value
    
    for _, btn in ipairs(self.buttons) do
        btn.dot.Visible = btn.option == value
    end
    
    if self.callback then
        self.callback(value)
    end
    self.Changed:Fire(value)
    return self
end

function RadioGroup:GetValue()
    return self.value
end

local SearchBox = setmetatable({}, {__index = Component})
SearchBox.__index = SearchBox

function SearchBox.new(parent, theme, style, window, placeholder, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), SearchBox)
    self.placeholder = placeholder or "Search..."
    self.value = ""
    self.callback = callback
    self:Create()
    return self
end

function SearchBox:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local searchIcon = Instance.new("TextLabel")
    searchIcon.Size = UDim2.new(0, 36, 1, 0)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Text = "🔍"
    searchIcon.TextSize = 16
    searchIcon.ZIndex = ZINDEX.Content
    searchIcon.Parent = container
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -72, 0, 30)
    textBox.Position = UDim2.new(0, 36, 0.5, -15)
    textBox.BackgroundTransparency = 1
    textBox.PlaceholderText = self.placeholder
    textBox.PlaceholderColor3 = self.theme.colors.text3
    textBox.Text = self.value
    textBox.TextColor3 = self.theme.colors.text1
    textBox.TextSize = 13
    textBox.Font = self.style.fontBody
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = ZINDEX.Content
    textBox.Parent = container
    self.textBox = textBox
    
    self.theme:Track(textBox, "TextColor3", "text1")
    self.theme:Track(textBox, "PlaceholderColor3", "text3")
    
    local clearButton = Instance.new("TextButton")
    clearButton.Size = UDim2.new(0, 32, 0, 32)
    clearButton.Position = UDim2.new(1, -36, 0.5, -16)
    clearButton.BackgroundTransparency = 1
    clearButton.Text = "×"
    clearButton.TextColor3 = self.theme.colors.text3
    clearButton.TextSize = 18
    clearButton.Font = self.style.fontTitle
    clearButton.Visible = false
    clearButton.ZIndex = ZINDEX.Content
    clearButton.Parent = container
    self.clearButton = clearButton
    
    self.theme:Track(clearButton, "TextColor3", "text3")
    
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        self.value = textBox.Text
        clearButton.Visible = textBox.Text ~= ""
        if self.callback then
            self.callback(textBox.Text)
        end
        self.Changed:Fire(textBox.Text)
    end)
    
    clearButton.MouseButton1Click:Connect(function()
        textBox.Text = ""
    end)
    
    clearButton.MouseEnter:Connect(function()
        TweenService:Create(clearButton, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.error}):Play()
    end)
    
    clearButton.MouseLeave:Connect(function()
        TweenService:Create(clearButton, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.text3}):Play()
    end)
end

function SearchBox:SetValue(value)
    self.value = value
    if self.textBox then
        self.textBox.Text = value
    end
    return self
end

function SearchBox:GetValue()
    return self.value
end

function SearchBox:Clear()
    self:SetValue("")
    return self
end

local FileSelector = setmetatable({}, {__index = Component})
FileSelector.__index = FileSelector

function FileSelector.new(parent, theme, style, window, title, extension, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), FileSelector)
    self.title = title or "Files"
    self.extension = extension
    self.callback = callback
    self.files = {}
    self.selectedFile = nil
    self:Create()
    return self
end

function FileSelector:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 200)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 36)
    header.BackgroundColor3 = self.theme.colors.bg4
    header.BorderSizePixel = 0
    header.ZIndex = ZINDEX.Content
    header.Parent = container
    
    self.theme:Track(header, "BackgroundColor3", "bg4")
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    headerCorner.Parent = header
    
    local headerCover = Instance.new("Frame")
    headerCover.Size = UDim2.new(1, 0, 0, self.style.cornerRadius)
    headerCover.Position = UDim2.new(0, 0, 1, -self.style.cornerRadius)
    headerCover.BackgroundColor3 = self.theme.colors.bg4
    headerCover.BorderSizePixel = 0
    headerCover.ZIndex = ZINDEX.Content
    headerCover.Parent = header
    
    self.theme:Track(headerCover, "BackgroundColor3", "bg4")
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -70, 1, 0)
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.title
    titleLabel.TextColor3 = self.theme.colors.text1
    titleLabel.TextSize = 13
    titleLabel.Font = self.style.fontTitle
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = ZINDEX.Content
    titleLabel.Parent = header
    
    self.theme:Track(titleLabel, "TextColor3", "text1")
    
    local refreshButton = Instance.new("TextButton")
    refreshButton.Size = UDim2.new(0, 28, 0, 28)
    refreshButton.Position = UDim2.new(1, -32, 0.5, -14)
    refreshButton.BackgroundTransparency = 1
    refreshButton.Text = "🔄"
    refreshButton.TextSize = 14
    refreshButton.ZIndex = ZINDEX.Content
    refreshButton.Parent = header
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -16, 1, -44)
    scrollFrame.Position = UDim2.new(0, 8, 0, 40)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 4
    scrollFrame.ScrollBarImageColor3 = self.theme.colors.text3
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollFrame.ZIndex = ZINDEX.Content
    scrollFrame.Parent = container
    self.scrollFrame = scrollFrame
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = scrollFrame
    
    refreshButton.MouseButton1Click:Connect(function()
        self:Refresh()
    end)
    
    self:Refresh()
end

function FileSelector:Refresh()
    for _, file in ipairs(self.files) do
        file:Destroy()
    end
    self.files = {}
    
    local success, fileList = pcall(function()
        if listfiles then
            return listfiles()
        end
        return {}
    end)
    
    if success then
        for _, filepath in ipairs(fileList) do
            local filename = filepath:match("^.+/(.+)$") or filepath
            
            if not self.extension or filename:match(self.extension .. "$") then
                local fileFrame = Instance.new("TextButton")
                fileFrame.Size = UDim2.new(1, 0, 0, 32)
                fileFrame.BackgroundColor3 = self.theme.colors.bg2
                fileFrame.BorderSizePixel = 0
                fileFrame.Text = ""
                fileFrame.ZIndex = ZINDEX.Content
                fileFrame.Parent = self.scrollFrame
                
                self.theme:Track(fileFrame, "BackgroundColor3", "bg2")
                
                local fileCorner = Instance.new("UICorner")
                fileCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
                fileCorner.Parent = fileFrame
                
                local fileLabel = Instance.new("TextLabel")
                fileLabel.Size = UDim2.new(1, -16, 1, 0)
                fileLabel.Position = UDim2.new(0, 8, 0, 0)
                fileLabel.BackgroundTransparency = 1
                fileLabel.Text = filename
                fileLabel.TextColor3 = self.theme.colors.text1
                fileLabel.TextSize = 11
                fileLabel.Font = self.style.fontMono
                fileLabel.TextXAlignment = Enum.TextXAlignment.Left
                fileLabel.TextTruncate = Enum.TextTruncate.AtEnd
                fileLabel.ZIndex = ZINDEX.Content
                fileLabel.Parent = fileFrame
                
                self.theme:Track(fileLabel, "TextColor3", "text1")
                
                fileFrame.MouseButton1Click:Connect(function()
                    self.selectedFile = filepath
                    
                    for _, f in ipairs(self.files) do
                        TweenService:Create(f, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg2}):Play()
                    end
                    
                    TweenService:Create(fileFrame, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.primary}):Play()
                    
                    if self.callback then
                        self.callback(filepath, filename)
                    end
                    self.Changed:Fire(filepath)
                end)
                
                fileFrame.MouseEnter:Connect(function()
                    if self.selectedFile ~= filepath then
                        TweenService:Create(fileFrame, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
                    end
                end)
                
                fileFrame.MouseLeave:Connect(function()
                    if self.selectedFile ~= filepath then
                        TweenService:Create(fileFrame, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg2}):Play()
                    end
                end)
                
                table.insert(self.files, fileFrame)
            end
        end
    end
    
    return self
end

function FileSelector:GetSelected()
    return self.selectedFile
end

local DatePicker = setmetatable({}, {__index = Component})
DatePicker.__index = DatePicker

function DatePicker.new(parent, theme, style, window, text, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), DatePicker)
    self.text = text
    self.callback = callback
    self.date = os.date("*t")
    self:Create()
    return self
end

function DatePicker:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, -16, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local dateDisplay = Instance.new("TextButton")
    dateDisplay.Size = UDim2.new(0.6, -24, 0, 30)
    dateDisplay.Position = UDim2.new(0.4, 8, 0.5, -15)
    dateDisplay.BackgroundColor3 = self.theme.colors.bg4
    dateDisplay.BorderSizePixel = 0
    dateDisplay.Text = string.format("%02d/%02d/%04d", self.date.month, self.date.day, self.date.year)
    dateDisplay.TextColor3 = self.theme.colors.text1
    dateDisplay.TextSize = 12
    dateDisplay.Font = self.style.fontMono
    dateDisplay.ZIndex = ZINDEX.Content
    dateDisplay.Parent = container
    self.dateDisplay = dateDisplay
    
    self.theme:Track(dateDisplay, "BackgroundColor3", "bg4")
    self.theme:Track(dateDisplay, "TextColor3", "text1")
    
    local displayCorner = Instance.new("UICorner")
    displayCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    displayCorner.Parent = dateDisplay
    
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Size = UDim2.new(0, 280, 0, 320)
    pickerFrame.BackgroundColor3 = self.theme.colors.bg2
    pickerFrame.BorderSizePixel = 0
    pickerFrame.Visible = false
    pickerFrame.ZIndex = ZINDEX.Dropdown
    pickerFrame.Parent = self.window.gui
    self.pickerFrame = pickerFrame
    table.insert(self.modalElements, pickerFrame)
    
    self.theme:Track(pickerFrame, "BackgroundColor3", "bg2")
    
    local pickerCorner = Instance.new("UICorner")
    pickerCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    pickerCorner.Parent = pickerFrame
    
    local pickerStroke = Instance.new("UIStroke")
    pickerStroke.Color = self.theme.colors.border
    pickerStroke.Thickness = 1
    pickerStroke.Parent = pickerFrame
    
    self.theme:Track(pickerStroke, "Color", "border")
    
    local monthYear = Instance.new("Frame")
    monthYear.Size = UDim2.new(1, -32, 0, 40)
    monthYear.Position = UDim2.new(0, 16, 0, 16)
    monthYear.BackgroundTransparency = 1
    monthYear.ZIndex = ZINDEX.Dropdown
    monthYear.Parent = pickerFrame
    
    local prevMonth = Instance.new("TextButton")
    prevMonth.Size = UDim2.new(0, 30, 1, 0)
    prevMonth.BackgroundTransparency = 1
    prevMonth.Text = "<"
    prevMonth.TextColor3 = self.theme.colors.text1
    prevMonth.TextSize = 16
    prevMonth.Font = self.style.fontTitle
    prevMonth.ZIndex = ZINDEX.Dropdown
    prevMonth.Parent = monthYear
    
    local monthYearLabel = Instance.new("TextLabel")
    monthYearLabel.Size = UDim2.new(1, -60, 1, 0)
    monthYearLabel.Position = UDim2.new(0, 30, 0, 0)
    monthYearLabel.BackgroundTransparency = 1
    monthYearLabel.Text = string.format("%s %d", os.date("%B", os.time(self.date)), self.date.year)
    monthYearLabel.TextColor3 = self.theme.colors.text1
    monthYearLabel.TextSize = 14
    monthYearLabel.Font = self.style.fontTitle
    monthYearLabel.ZIndex = ZINDEX.Dropdown
    monthYearLabel.Parent = monthYear
    self.monthYearLabel = monthYearLabel
    
    self.theme:Track(monthYearLabel, "TextColor3", "text1")
    
    local nextMonth = Instance.new("TextButton")
    nextMonth.Size = UDim2.new(0, 30, 1, 0)
    nextMonth.Position = UDim2.new(1, -30, 0, 0)
    nextMonth.BackgroundTransparency = 1
    nextMonth.Text = ">"
    nextMonth.TextColor3 = self.theme.colors.text1
    nextMonth.TextSize = 16
    nextMonth.Font = self.style.fontTitle
    nextMonth.ZIndex = ZINDEX.Dropdown
    nextMonth.Parent = monthYear
    
    local daysGrid = Instance.new("Frame")
    daysGrid.Size = UDim2.new(1, -32, 1, -120)
    daysGrid.Position = UDim2.new(0, 16, 0, 72)
    daysGrid.BackgroundTransparency = 1
    daysGrid.ZIndex = ZINDEX.Dropdown
    daysGrid.Parent = pickerFrame
    self.daysGrid = daysGrid
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(1/7, -4, 0, 32)
    gridLayout.CellPadding = UDim2.new(0, 4, 0, 4)
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Parent = daysGrid
    
    local function updateCalendar()
        for _, child in ipairs(daysGrid:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        monthYearLabel.Text = string.format("%s %d", os.date("%B", os.time(self.date)), self.date.year)
        
        local firstDay = os.time({year = self.date.year, month = self.date.month, day = 1})
        local firstWeekday = tonumber(os.date("%w", firstDay))
        local daysInMonth = tonumber(os.date("%d", os.time({year = self.date.year, month = self.date.month + 1, day = 0})))
        
        for i = 1, firstWeekday do
            local spacer = Instance.new("Frame")
            spacer.BackgroundTransparency = 1
            spacer.LayoutOrder = i
            spacer.Parent = daysGrid
        end
        
        for day = 1, daysInMonth do
            local dayButton = Instance.new("TextButton")
            dayButton.BackgroundColor3 = day == self.date.day and self.theme.colors.primary or self.theme.colors.bg3
            dayButton.BorderSizePixel = 0
            dayButton.Text = tostring(day)
            dayButton.TextColor3 = day == self.date.day and Color3.fromRGB(255, 255, 255) or self.theme.colors.text1
            dayButton.TextSize = 12
            dayButton.Font = self.style.fontBody
            dayButton.LayoutOrder = firstWeekday + day
            dayButton.ZIndex = ZINDEX.Dropdown
            dayButton.Parent = daysGrid
            
            local dayCorner = Instance.new("UICorner")
            dayCorner.CornerRadius = UDim.new(0, 4)
            dayCorner.Parent = dayButton
            
            dayButton.MouseButton1Click:Connect(function()
                self.date.day = day
                dateDisplay.Text = string.format("%02d/%02d/%04d", self.date.month, self.date.day, self.date.year)
                pickerFrame.Visible = false
                if self.callback then
                    self.callback(self.date)
                end
                self.Changed:Fire(self.date)
                updateCalendar()
            end)
        end
    end
    
    prevMonth.MouseButton1Click:Connect(function()
        self.date.month = self.date.month - 1
        if self.date.month < 1 then
            self.date.month = 12
            self.date.year = self.date.year - 1
        end
        updateCalendar()
    end)
    
    nextMonth.MouseButton1Click:Connect(function()
        self.date.month = self.date.month + 1
        if self.date.month > 12 then
            self.date.month = 1
            self.date.year = self.date.year + 1
        end
        updateCalendar()
    end)
    
    dateDisplay.MouseButton1Click:Connect(function()
        pickerFrame.Visible = not pickerFrame.Visible
        if pickerFrame.Visible then
            local absPos = dateDisplay.AbsolutePosition
            local absSize = dateDisplay.AbsoluteSize
            pickerFrame.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
            updateCalendar()
        end
    end)
    
    container.MouseEnter:Connect(function()
        TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
    end)
    
    container.MouseLeave:Connect(function()
        TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
    end)
end

function DatePicker:GetDate()
    return self.date
end

function DatePicker:SetDate(year, month, day)
    self.date.year = year
    self.date.month = month
    self.date.day = day
    if self.dateDisplay then
        self.dateDisplay.Text = string.format("%02d/%02d/%04d", month, day, year)
    end
    return self
end

local RangeSlider = setmetatable({}, {__index = Component})
RangeSlider.__index = RangeSlider

function RangeSlider.new(parent, theme, style, window, text, min, max, defaultMin, defaultMax, increment, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), RangeSlider)
    self.text = text
    self.min = min
    self.max = max
    self.valueMin = defaultMin or min
    self.valueMax = defaultMax or max
    self.increment = increment
    self.callback = callback
    self:Create()
    return self
end

function RangeSlider:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 70)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, -24, 0, 24)
    header.Position = UDim2.new(0, 12, 0, 10)
    header.BackgroundTransparency = 1
    header.ZIndex = ZINDEX.Content
    header.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = header
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.5, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = string.format("%s - %s", tostring(self.valueMin), tostring(self.valueMax))
    valueLabel.TextColor3 = self.theme.colors.primary
    valueLabel.TextSize = 13
    valueLabel.Font = self.style.fontTitle
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.ZIndex = ZINDEX.Content
    valueLabel.Parent = header
    self.valueLabel = valueLabel
    
    self.theme:Track(valueLabel, "TextColor3", "primary")
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -24, 0, 4)
    track.Position = UDim2.new(0, 12, 1, -18)
    track.BackgroundColor3 = self.theme.colors.border
    track.BorderSizePixel = 0
    track.ZIndex = ZINDEX.Content + 1
    track.Parent = container
    
    self.theme:Track(track, "BackgroundColor3", "border")
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    local fillStart = (self.valueMin - self.min) / (self.max - self.min)
    local fillEnd = (self.valueMax - self.min) / (self.max - self.min)
    fill.Size = UDim2.new(fillEnd - fillStart, 0, 1, 0)
    fill.Position = UDim2.new(fillStart, 0, 0, 0)
    fill.BackgroundColor3 = self.theme.colors.primary
    fill.BorderSizePixel = 0
    fill.ZIndex = ZINDEX.Content + 2
    fill.Parent = track
    self.fill = fill
    
    self.theme:Track(fill, "BackgroundColor3", "primary")
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local thumbMin = Instance.new("Frame")
    thumbMin.Size = UDim2.new(0, 14, 0, 14)
    thumbMin.Position = UDim2.new(fillStart, -7, 0.5, -7)
    thumbMin.BackgroundColor3 = self.theme.colors.bg1
    thumbMin.BorderSizePixel = 0
    thumbMin.ZIndex = ZINDEX.Content + 3
    thumbMin.Parent = track
    self.thumbMin = thumbMin
    
    self.theme:Track(thumbMin, "BackgroundColor3", "bg1")
    
    local thumbMinCorner = Instance.new("UICorner")
    thumbMinCorner.CornerRadius = UDim.new(1, 0)
    thumbMinCorner.Parent = thumbMin
    
    local thumbMinBorder = Instance.new("UIStroke")
    thumbMinBorder.Color = self.theme.colors.primary
    thumbMinBorder.Thickness = 2
    thumbMinBorder.Parent = thumbMin
    
    self.theme:Track(thumbMinBorder, "Color", "primary")
    
    local thumbMax = Instance.new("Frame")
    thumbMax.Size = UDim2.new(0, 14, 0, 14)
    thumbMax.Position = UDim2.new(fillEnd, -7, 0.5, -7)
    thumbMax.BackgroundColor3 = self.theme.colors.bg1
    thumbMax.BorderSizePixel = 0
    thumbMax.ZIndex = ZINDEX.Content + 3
    thumbMax.Parent = track
    self.thumbMax = thumbMax
    
    self.theme:Track(thumbMax, "BackgroundColor3", "bg1")
    
    local thumbMaxCorner = Instance.new("UICorner")
    thumbMaxCorner.CornerRadius = UDim.new(1, 0)
    thumbMaxCorner.Parent = thumbMax
    
    local thumbMaxBorder = Instance.new("UIStroke")
    thumbMaxBorder.Color = self.theme.colors.primary
    thumbMaxBorder.Thickness = 2
    thumbMaxBorder.Parent = thumbMax
    
    self.theme:Track(thumbMaxBorder, "Color", "primary")
    
    self.track = track
    
    local draggingMin = false
    local draggingMax = false
    
    local function update(input, isMin)
        safeCall(function()
            local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local value = self.min + (self.max - self.min) * pos
            
            if self.increment then
                value = math.floor(value / self.increment + 0.5) * self.increment
            end
            
            value = math.clamp(value, self.min, self.max)
            
            if isMin then
                self.valueMin = math.min(value, self.valueMax)
            else
                self.valueMax = math.max(value, self.valueMin)
            end
            
            local normMin = (self.valueMin - self.min) / (self.max - self.min)
            local normMax = (self.valueMax - self.min) / (self.max - self.min)
            
            fill.Size = UDim2.new(normMax - normMin, 0, 1, 0)
            fill.Position = UDim2.new(normMin, 0, 0, 0)
            thumbMin.Position = UDim2.new(normMin, -7, 0.5, -7)
            thumbMax.Position = UDim2.new(normMax, -7, 0.5, -7)
            valueLabel.Text = string.format("%s - %s", tostring(self.valueMin), tostring(self.valueMax))
            
            if self.callback then
                self.callback(self.valueMin, self.valueMax)
            end
            self.Changed:Fire(self.valueMin, self.valueMax)
        end)
    end
    
    thumbMin.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMin = true
            TweenService:Create(thumbMin, TweenInfo.new(self.style.animationSpeed), {Size = UDim2.new(0, 18, 0, 18)}):Play()
        end
    end)
    
    thumbMin.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMin = false
            TweenService:Create(thumbMin, TweenInfo.new(self.style.animationSpeed), {Size = UDim2.new(0, 14, 0, 14)}):Play()
        end
    end)
    
    thumbMax.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMax = true
            TweenService:Create(thumbMax, TweenInfo.new(self.style.animationSpeed), {Size = UDim2.new(0, 18, 0, 18)}):Play()
        end
    end)
    
    thumbMax.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingMax = false
            TweenService:Create(thumbMax, TweenInfo.new(self.style.animationSpeed), {Size = UDim2.new(0, 14, 0, 14)}):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            if draggingMin then
                update(input, true)
            elseif draggingMax then
                update(input, false)
            end
        end
    end)
end

function RangeSlider:SetValues(minValue, maxValue)
    self.valueMin = math.clamp(minValue, self.min, self.max)
    self.valueMax = math.clamp(maxValue, self.min, self.max)
    
    local normMin = (self.valueMin - self.min) / (self.max - self.min)
    local normMax = (self.valueMax - self.min) / (self.max - self.min)
    
    safeCall(function()
        self.fill.Size = UDim2.new(normMax - normMin, 0, 1, 0)
        self.fill.Position = UDim2.new(normMin, 0, 0, 0)
        self.thumbMin.Position = UDim2.new(normMin, -7, 0.5, -7)
        self.thumbMax.Position = UDim2.new(normMax, -7, 0.5, -7)
        self.valueLabel.Text = string.format("%s - %s", tostring(self.valueMin), tostring(self.valueMax))
    end)
    
    return self
end

function RangeSlider:GetValues()
    return self.valueMin, self.valueMax
end

local Accordion = setmetatable({}, {__index = Component})
Accordion.__index = Accordion

function Accordion.new(parent, theme, style, window, title, expanded)
    local self = setmetatable(Component.new(parent, theme, style, window), Accordion)
    self.title = title
    self.expanded = expanded or false
    self.components = {}
    self.Toggled = Signal.new()
    self:Create()
    return self
end

function Accordion:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, 0, 0, 44)
    header.BackgroundColor3 = self.theme.colors.bg4
    header.BorderSizePixel = 0
    header.Text = ""
    header.AutoButtonColor = false
    header.ZIndex = ZINDEX.Content
    header.Parent = container
    self.header = header
    
    self.theme:Track(header, "BackgroundColor3", "bg4")
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    headerCorner.Parent = header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -56, 1, 0)
    titleLabel.Position = UDim2.new(0, 16, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.title
    titleLabel.TextColor3 = self.theme.colors.text1
    titleLabel.TextSize = 14
    titleLabel.Font = self.style.fontTitle
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = ZINDEX.Content
    titleLabel.Parent = header
    
    self.theme:Track(titleLabel, "TextColor3", "text1")
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 32, 1, 0)
    arrow.Position = UDim2.new(1, -40, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = self.theme.colors.text2
    arrow.TextSize = 12
    arrow.Font = self.style.fontTitle
    arrow.Rotation = self.expanded and 180 or 0
    arrow.ZIndex = ZINDEX.Content
    arrow.Parent = header
    self.arrow = arrow
    
    self.theme:Track(arrow, "TextColor3", "text2")
    
    local content = Instance.new("Frame")
    content.Name = "AccordionContent"
    content.Size = UDim2.new(1, 0, 0, 0)
    content.Position = UDim2.new(0, 0, 0, 44)
    content.AutomaticSize = Enum.AutomaticSize.Y
    content.BackgroundTransparency = 1
    content.Visible = self.expanded
    content.ClipsDescendants = true
    content.ZIndex = ZINDEX.Content
    content.Parent = container
    self.content = content
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingLeft = UDim.new(0, 16)
    contentPadding.PaddingRight = UDim.new(0, 16)
    contentPadding.PaddingTop = UDim.new(0, 12)
    contentPadding.PaddingBottom = UDim.new(0, 12)
    contentPadding.Parent = content
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = content
    
    header.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    if isMobile() then
        header.TouchTap:Connect(function()
            self:Toggle()
        end)
    end
    
    header.MouseEnter:Connect(function()
        TweenService:Create(header, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg5}):Play()
    end)
    
    header.MouseLeave:Connect(function()
        TweenService:Create(header, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
    end)
end

function Accordion:Toggle()
    self.expanded = not self.expanded
    self.content.Visible = self.expanded
    
    TweenService:Create(self.arrow, TweenInfo.new(self.style.animationSpeed), {
        Rotation = self.expanded and 180 or 0
    }):Play()
    
    self.Toggled:Fire(self.expanded)
    self.Changed:Fire(self.expanded)
    return self
end

function Accordion:Expand()
    if not self.expanded then
        self:Toggle()
    end
    return self
end

function Accordion:Collapse()
    if self.expanded then
        self:Toggle()
    end
    return self
end

function Accordion:AddElement(element)
    if element.instance then
        element.instance.Parent = self.content
        table.insert(self.components, element)
    end
    return self
end

local HorizontalLayout = setmetatable({}, {__index = Component})
HorizontalLayout.__index = HorizontalLayout

function HorizontalLayout.new(parent, theme, style, window, spacing)
    local self = setmetatable(Component.new(parent, theme, style, window), HorizontalLayout)
    self.spacing = spacing or style.spacing
    self.components = {}
    self:Create()
    return self
end

function HorizontalLayout:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, self.spacing)
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.Parent = container
    self.layout = layout
end

function HorizontalLayout:AddElement(element, size)
    if element.instance then
        element.instance.Parent = self.instance
        element.instance.Size = size or UDim2.new(0.5, -self.spacing/2, 0, element.instance.Size.Y.Offset)
        table.insert(self.components, element)
    end
    return self
end

function HorizontalLayout:SetSpacing(spacing)
    self.spacing = spacing
    if self.layout then
        self.layout.Padding = UDim.new(0, spacing)
    end
    return self
end

local Spacer = setmetatable({}, {__index = Component})
Spacer.__index = Spacer

function Spacer.new(parent, theme, style, window, height)
    local self = setmetatable(Component.new(parent, theme, style, window), Spacer)
    self.height = height or style.spacing
    self:Create()
    return self
end

function Spacer:Create()
    local spacer = Instance.new("Frame")
    spacer.Size = UDim2.new(1, 0, 0, self.height)
    spacer.BackgroundTransparency = 1
    spacer.ZIndex = ZINDEX.Content
    spacer.Parent = self.parent
    self.instance = spacer
end

function Spacer:SetHeight(height)
    self.height = height
    if self.instance then
        self.instance.Size = UDim2.new(1, 0, 0, height)
    end
    return self
end

local GridContainer = setmetatable({}, {__index = Component})
GridContainer.__index = GridContainer

function GridContainer.new(parent, theme, style, window, columns, cellSize)
    local self = setmetatable(Component.new(parent, theme, style, window), GridContainer)
    self.columns = columns or 2
    self.cellSize = cellSize or UDim2.new(0, 100, 0, 100)
    self.components = {}
    self:Create()
    return self
end

function GridContainer:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = self.cellSize
    gridLayout.CellPadding = UDim2.new(0, self.style.spacing, 0, self.style.spacing)
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Parent = container
    self.gridLayout = gridLayout
end

function GridContainer:AddElement(element)
    if element.instance then
        element.instance.Parent = self.instance
        table.insert(self.components, element)
    end
    return self
end

function GridContainer:SetColumns(columns)
    self.columns = columns
    return self
end

function GridContainer:SetCellSize(cellSize)
    self.cellSize = cellSize
    if self.gridLayout then
        self.gridLayout.CellSize = cellSize
    end
    return self
end

local ScrollContainer = setmetatable({}, {__index = Component})
ScrollContainer.__index = ScrollContainer

function ScrollContainer.new(parent, theme, style, window, height)
    local self = setmetatable(Component.new(parent, theme, style, window), ScrollContainer)
    self.height = height or 300
    self.components = {}
    self:Create()
    return self
end

function ScrollContainer:Create()
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 0, self.height)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 6
    container.ScrollBarImageColor3 = self.theme.colors.text3
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, self.style.padding)
    padding.PaddingRight = UDim.new(0, self.style.padding)
    padding.PaddingTop = UDim.new(0, self.style.padding)
    padding.PaddingBottom = UDim.new(0, self.style.padding)
    padding.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, self.style.spacing)
    layout.Parent = container
end

function ScrollContainer:AddElement(element)
    if element.instance then
        element.instance.Parent = self.instance
        table.insert(self.components, element)
    end
    return self
end

local Modal = setmetatable({}, {__index = Component})
Modal.__index = Modal

function Modal.new(window, theme, style, title, message, buttons)
    local self = setmetatable({}, Modal)
    self.window = window
    self.theme = theme
    self.style = style
    self.title = title
    self.message = message
    self.buttons = buttons or {
        {text = "OK", callback = nil, color = nil}
    }
    self.Closed = Signal.new()
    self:Create()
    return self
end

function Modal:Create()
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    overlay.ZIndex = ZINDEX.Modal
    overlay.Parent = self.window.gui
    self.overlay = overlay
    
    local modal = Instance.new("Frame")
    modal.Size = UDim2.new(0, 400, 0, 0)
    modal.Position = UDim2.new(0.5, -200, 0.5, 0)
    modal.AutomaticSize = Enum.AutomaticSize.Y
    modal.BackgroundColor3 = self.theme.colors.bg2
    modal.BorderSizePixel = 0
    modal.ZIndex = ZINDEX.Modal + 1
    modal.Parent = self.window.gui
    self.instance = modal
    
    self.theme:Track(modal, "BackgroundColor3", "bg2")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius + 2)
    corner.Parent = modal
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = self.theme.colors.border
    stroke.Thickness = 2
    stroke.Parent = modal
    
    self.theme:Track(stroke, "Color", "border")
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 24)
    padding.PaddingRight = UDim.new(0, 24)
    padding.PaddingTop = UDim.new(0, 24)
    padding.PaddingBottom = UDim.new(0, 24)
    padding.Parent = modal
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 16)
    layout.Parent = modal
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 28)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.title
    titleLabel.TextColor3 = self.theme.colors.text1
    titleLabel.TextSize = 18
    titleLabel.Font = self.style.fontTitle
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.LayoutOrder = 1
    titleLabel.ZIndex = ZINDEX.Modal + 1
    titleLabel.Parent = modal
    
    self.theme:Track(titleLabel, "TextColor3", "text1")
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, 0, 0, 0)
    messageLabel.AutomaticSize = Enum.AutomaticSize.Y
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = self.message
    messageLabel.TextColor3 = self.theme.colors.text2
    messageLabel.TextSize = 14
    messageLabel.Font = self.style.fontBody
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true
    messageLabel.LayoutOrder = 2
    messageLabel.ZIndex = ZINDEX.Modal + 1
    messageLabel.Parent = modal
    
    self.theme:Track(messageLabel, "TextColor3", "text2")
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.LayoutOrder = 3
    buttonContainer.ZIndex = ZINDEX.Modal + 1
    buttonContainer.Parent = modal
    
    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    buttonLayout.Padding = UDim.new(0, 8)
    buttonLayout.Parent = buttonContainer
    
    for i, btnData in ipairs(self.buttons) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 1, 0)
        button.BackgroundColor3 = btnData.color or self.theme.colors.primary
        button.BorderSizePixel = 0
        button.Text = btnData.text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 13
        button.Font = self.style.fontTitle
        button.AutoButtonColor = false
        button.LayoutOrder = i
        button.ZIndex = ZINDEX.Modal + 1
        button.Parent = buttonContainer
        
        if not btnData.color then
            self.theme:Track(button, "BackgroundColor3", "primary")
        end
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
        btnCorner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if btnData.callback then
                btnData.callback()
            end
            self:Close()
        end)
        
        button.MouseEnter:Connect(function()
            local hoverColor = Color3.new(
                math.min((btnData.color or self.theme.colors.primary).R + 0.05, 1),
                math.min((btnData.color or self.theme.colors.primary).G + 0.05, 1),
                math.min((btnData.color or self.theme.colors.primary).B + 0.05, 1)
            )
            TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = hoverColor}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = btnData.color or self.theme.colors.primary}):Play()
        end)
    end
    
    modal.Size = UDim2.new(0, 400, 0, 0)
    modal.Position = UDim2.new(0.5, -200, 0.5, -modal.AbsoluteSize.Y/2)
    
    TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
    TweenService:Create(modal, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 400, 0, modal.AbsoluteSize.Y)
    }):Play()
end

function Modal:Close()
    TweenService:Create(self.overlay, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
    TweenService:Create(self.instance, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 400, 0, 0)
    }):Play()
    
    task.wait(0.2)
    
    self.overlay:Destroy()
    self.instance:Destroy()
    self.Closed:Fire()
end

local ContextMenu = setmetatable({}, {__index = Component})
ContextMenu.__index = ContextMenu

function ContextMenu.new(window, theme, style, items, position)
    local self = setmetatable({}, ContextMenu)
    self.window = window
    self.theme = theme
    self.style = style
    self.items = items or {}
    self.position = position or Vector2.new(0, 0)
    self.ItemClicked = Signal.new()
    self:Create()
    return self
end

function ContextMenu:Create()
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 180, 0, 0)
    menu.Position = UDim2.new(0, self.position.X, 0, self.position.Y)
    menu.AutomaticSize = Enum.AutomaticSize.Y
    menu.BackgroundColor3 = self.theme.colors.bg2
    menu.BorderSizePixel = 0
    menu.ZIndex = ZINDEX.Modal
    menu.Parent = self.window.gui
    self.instance = menu
    
    self.theme:Track(menu, "BackgroundColor3", "bg2")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = menu
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = self.theme.colors.border
    stroke.Thickness = 1
    stroke.Parent = menu
    
    self.theme:Track(stroke, "Color", "border")
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 4)
    padding.PaddingRight = UDim.new(0, 4)
    padding.PaddingTop = UDim.new(0, 4)
    padding.PaddingBottom = UDim.new(0, 4)
    padding.Parent = menu
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = menu
    
    for i, item in ipairs(self.items) do
        if item.divider then
            local divider = Instance.new("Frame")
            divider.Size = UDim2.new(1, 0, 0, 1)
            divider.BackgroundColor3 = self.theme.colors.border
            divider.BorderSizePixel = 0
            divider.LayoutOrder = i
            divider.ZIndex = ZINDEX.Modal
            divider.Parent = menu
            
            self.theme:Track(divider, "BackgroundColor3", "border")
        else
            local menuItem = Instance.new("TextButton")
            menuItem.Size = UDim2.new(1, 0, 0, 32)
            menuItem.BackgroundColor3 = self.theme.colors.bg2
            menuItem.BorderSizePixel = 0
            menuItem.Text = ""
            menuItem.AutoButtonColor = false
            menuItem.LayoutOrder = i
            menuItem.ZIndex = ZINDEX.Modal
            menuItem.Parent = menu
            
            local itemCorner = Instance.new("UICorner")
            itemCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
            itemCorner.Parent = menuItem
            
            local itemLabel = Instance.new("TextLabel")
            itemLabel.Size = UDim2.new(1, -24, 1, 0)
            itemLabel.Position = UDim2.new(0, 12, 0, 0)
            itemLabel.BackgroundTransparency = 1
            itemLabel.Text = item.text
            itemLabel.TextColor3 = item.color or self.theme.colors.text1
            itemLabel.TextSize = 12
            itemLabel.Font = self.style.fontBody
            itemLabel.TextXAlignment = Enum.TextXAlignment.Left
            itemLabel.ZIndex = ZINDEX.Modal
            itemLabel.Parent = menuItem
            
            if not item.color then
                self.theme:Track(itemLabel, "TextColor3", "text1")
            end
            
            if item.icon then
                local icon = Instance.new("TextLabel")
                icon.Size = UDim2.new(0, 20, 1, 0)
                icon.Position = UDim2.new(1, -28, 0, 0)
                icon.BackgroundTransparency = 1
                icon.Text = item.icon
                icon.TextColor3 = self.theme.colors.text3
                icon.TextSize = 14
                icon.ZIndex = ZINDEX.Modal
                icon.Parent = menuItem
                
                self.theme:Track(icon, "TextColor3", "text3")
            end
            
            menuItem.MouseButton1Click:Connect(function()
                if item.callback then
                    item.callback()
                end
                self.ItemClicked:Fire(item.text)
                self:Close()
            end)
            
            menuItem.MouseEnter:Connect(function()
                TweenService:Create(menuItem, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
            end)
            
            menuItem.MouseLeave:Connect(function()
                TweenService:Create(menuItem, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg2}):Play()
            end)
        end
    end
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = UserInputService:GetMouseLocation()
            local menuPos = menu.AbsolutePosition
            local menuSize = menu.AbsoluteSize
            
            if mousePos.X < menuPos.X or mousePos.X > menuPos.X + menuSize.X or
               mousePos.Y < menuPos.Y or mousePos.Y > menuPos.Y + menuSize.Y then
                self:Close()
            end
        end
    end)
end

function ContextMenu:Close()
    if self.instance then
        self.instance:Destroy()
    end
end

local Tooltip = {}
Tooltip.__index = Tooltip

function Tooltip.new(window, theme, style)
    local self = setmetatable({}, Tooltip)
    self.window = window
    self.theme = theme
    self.style = style
    self.tooltip = nil
    self.connections = {}
    return self
end

function Tooltip:AttachTo(element, text, delay)
    local hoverDelay = delay or 0.5
    local hoverTimer = nil
    
    local connection1 = element.MouseEnter:Connect(function()
        hoverTimer = task.delay(hoverDelay, function()
            self:Show(text, element.AbsolutePosition, element.AbsoluteSize)
        end)
    end)
    
    local connection2 = element.MouseLeave:Connect(function()
        if hoverTimer then
            task.cancel(hoverTimer)
            hoverTimer = nil
        end
        self:Hide()
    end)
    
    table.insert(self.connections, connection1)
    table.insert(self.connections, connection2)
    
    return self
end

function Tooltip:Show(text, position, size)
    self:Hide()
    
    self.tooltip = Instance.new("Frame")
    self.tooltip.Size = UDim2.new(0, 0, 0, 32)
    self.tooltip.AutomaticSize = Enum.AutomaticSize.X
    self.tooltip.Position = UDim2.new(0, position.X + size.X/2, 0, position.Y - 40)
    self.tooltip.AnchorPoint = Vector2.new(0.5, 0)
    self.tooltip.BackgroundColor3 = self.theme.colors.bg1
    self.tooltip.BorderSizePixel = 0
    self.tooltip.ZIndex = ZINDEX.Notification
    self.tooltip.Parent = self.window.gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.tooltip
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = self.theme.colors.border
    stroke.Thickness = 1
    stroke.Parent = self.tooltip
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.Parent = self.tooltip
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 11
    label.Font = self.style.fontBody
    label.ZIndex = ZINDEX.Notification
    label.Parent = self.tooltip
end

function Tooltip:Hide()
    if self.tooltip then
        self.tooltip:Destroy()
        self.tooltip = nil
    end
end

function Tooltip:Destroy()
    self:Hide()
    for _, connection in ipairs(self.connections) do
        connection:Disconnect()
    end
    self.connections = {}
end

local LoadingSpinner = setmetatable({}, {__index = Component})
LoadingSpinner.__index = LoadingSpinner

function LoadingSpinner.new(parent, theme, style, window, text, size)
    local self = setmetatable(Component.new(parent, theme, style, window), LoadingSpinner)
    self.text = text or "Loading..."
    self.spinnerSize = size or 32
    self.spinning = false
    self:Create()
    return self
end

function LoadingSpinner:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.spinnerSize + 40)
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local spinner = Instance.new("ImageLabel")
    spinner.Size = UDim2.new(0, self.spinnerSize, 0, self.spinnerSize)
    spinner.Position = UDim2.new(0.5, -self.spinnerSize/2, 0, 10)
    spinner.BackgroundTransparency = 1
    spinner.Image = "rbxasset://textures/ui/Controls/ProgressSpinner.png"
    spinner.ImageColor3 = self.theme.colors.primary
    spinner.ZIndex = ZINDEX.Content
    spinner.Parent = container
    self.spinner = spinner
    
    self.theme:Track(spinner, "ImageColor3", "primary")
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 0, self.spinnerSize + 15)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text2
    label.TextSize = 12
    label.Font = self.style.fontBody
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    self.label = label
    
    self.theme:Track(label, "TextColor3", "text2")
end

function LoadingSpinner:Start()
    if self.spinning then return self end
    self.spinning = true
    
    task.spawn(function()
        while self.spinning and self.spinner do
            TweenService:Create(self.spinner, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Rotation = self.spinner.Rotation + 360
            }):Play()
            task.wait(1)
        end
    end)
    
    return self
end

function LoadingSpinner:Stop()
    self.spinning = false
    return self
end

function LoadingSpinner:SetText(text)
    self.text = text
    if self.label then
        self.label.Text = text
    end
    return self
end

local Stepper = setmetatable({}, {__index = Component})
Stepper.__index = Stepper

function Stepper.new(parent, theme, style, window, steps)
    local self = setmetatable(Component.new(parent, theme, style, window), Stepper)
    self.steps = steps or {}
    self.currentStep = 1
    self.StepChanged = Signal.new()
    self:Create()
    return self
end

function Stepper:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 16)
    layout.Parent = container
    
    local stepsContainer = Instance.new("Frame")
    stepsContainer.Size = UDim2.new(1, 0, 0, 60)
    stepsContainer.BackgroundTransparency = 1
    stepsContainer.LayoutOrder = 1
    stepsContainer.ZIndex = ZINDEX.Content
    stepsContainer.Parent = container
    
    local stepsLayout = Instance.new("UIListLayout")
    stepsLayout.FillDirection = Enum.FillDirection.Horizontal
    stepsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    stepsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    stepsLayout.Padding = UDim.new(0, 20)
    stepsLayout.Parent = stepsContainer
    
    self.stepElements = {}
    
    for i, step in ipairs(self.steps) do
        local stepFrame = Instance.new("Frame")
        stepFrame.Size = UDim2.new(0, 100, 1, 0)
        stepFrame.BackgroundTransparency = 1
        stepFrame.LayoutOrder = i
        stepFrame.ZIndex = ZINDEX.Content
        stepFrame.Parent = stepsContainer
        
        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 36, 0, 36)
        circle.Position = UDim2.new(0.5, -18, 0, 0)
        circle.BackgroundColor3 = i <= self.currentStep and self.theme.colors.primary or self.theme.colors.bg3
        circle.BorderSizePixel = 0
        circle.ZIndex = ZINDEX.Content
        circle.Parent = stepFrame
        
        self.theme:Track(circle, "BackgroundColor3", i <= self.currentStep and "primary" or "bg3")
        
        local circleCorner = Instance.new("UICorner")
        circleCorner.CornerRadius = UDim.new(1, 0)
        circleCorner.Parent = circle
        
        local number = Instance.new("TextLabel")
        number.Size = UDim2.new(1, 0, 1, 0)
        number.BackgroundTransparency = 1
        number.Text = i == self.currentStep and "●" or tostring(i)
        number.TextColor3 = i <= self.currentStep and Color3.fromRGB(255, 255, 255) or self.theme.colors.text3
        number.TextSize = 16
        number.Font = self.style.fontTitle
        number.ZIndex = ZINDEX.Content
        number.Parent = circle
        
        local stepLabel = Instance.new("TextLabel")
        stepLabel.Size = UDim2.new(1, 0, 0, 20)
        stepLabel.Position = UDim2.new(0, 0, 0, 40)
        stepLabel.BackgroundTransparency = 1
        stepLabel.Text = step
        stepLabel.TextColor3 = i <= self.currentStep and self.theme.colors.text1 or self.theme.colors.text3
        stepLabel.TextSize = 11
        stepLabel.Font = self.style.fontBody
        stepLabel.TextTruncate = Enum.TextTruncate.AtEnd
        stepLabel.ZIndex = ZINDEX.Content
        stepLabel.Parent = stepFrame
        
        self.theme:Track(stepLabel, "TextColor3", i <= self.currentStep and "text1" or "text3")
        
        if i < #self.steps then
            local line = Instance.new("Frame")
            line.Size = UDim2.new(0, 20, 0, 2)
            line.Position = UDim2.new(1, 0, 0, 17)
            line.BackgroundColor3 = i < self.currentStep and self.theme.colors.primary or self.theme.colors.border
            line.BorderSizePixel = 0
            line.ZIndex = ZINDEX.Content
            line.Parent = stepFrame
            
            self.theme:Track(line, "BackgroundColor3", i < self.currentStep and "primary" or "border")
        end
        
        table.insert(self.stepElements, {circle = circle, number = number, label = stepLabel})
    end
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "StepContent"
    contentFrame.Size = UDim2.new(1, 0, 0, 0)
    contentFrame.AutomaticSize = Enum.AutomaticSize.Y
    contentFrame.BackgroundTransparency = 1
    contentFrame.LayoutOrder = 2
    contentFrame.ZIndex = ZINDEX.Content
    contentFrame.Parent = container
    self.content = contentFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = contentFrame
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.LayoutOrder = 3
    buttonContainer.ZIndex = ZINDEX.Content
    buttonContainer.Parent = container
    
    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    buttonLayout.Padding = UDim.new(0, 8)
    buttonLayout.Parent = buttonContainer
    
    local prevButton = Instance.new("TextButton")
    prevButton.Size = UDim2.new(0, 100, 1, 0)
    prevButton.BackgroundColor3 = self.theme.colors.bg3
    prevButton.BorderSizePixel = 0
    prevButton.Text = "Previous"
    prevButton.TextColor3 = self.theme.colors.text1
    prevButton.TextSize = 13
    prevButton.Font = self.style.fontTitle
    prevButton.Visible = self.currentStep > 1
    prevButton.LayoutOrder = 1
    prevButton.ZIndex = ZINDEX.Content
    prevButton.Parent = buttonContainer
    self.prevButton = prevButton
    
    self.theme:Track(prevButton, "BackgroundColor3", "bg3")
    self.theme:Track(prevButton, "TextColor3", "text1")
    
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    prevCorner.Parent = prevButton
    
    local nextButton = Instance.new("TextButton")
    nextButton.Size = UDim2.new(0, 100, 1, 0)
    nextButton.BackgroundColor3 = self.theme.colors.primary
    nextButton.BorderSizePixel = 0
    nextButton.Text = self.currentStep == #self.steps and "Finish" or "Next"
    nextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    nextButton.TextSize = 13
    nextButton.Font = self.style.fontTitle
    nextButton.LayoutOrder = 2
    nextButton.ZIndex = ZINDEX.Content
    nextButton.Parent = buttonContainer
    self.nextButton = nextButton
    
    self.theme:Track(nextButton, "BackgroundColor3", "primary")
    
    local nextCorner = Instance.new("UICorner")
    nextCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    nextCorner.Parent = nextButton
    
    prevButton.MouseButton1Click:Connect(function()
        self:Previous()
    end)
    
    nextButton.MouseButton1Click:Connect(function()
        if self.currentStep == #self.steps then
            self.StepChanged:Fire(self.currentStep, "finish")
        else
            self:Next()
        end
    end)
end

function Stepper:Next()
    if self.currentStep < #self.steps then
        self.currentStep = self.currentStep + 1
        self:UpdateSteps()
        self.StepChanged:Fire(self.currentStep, "next")
    end
    return self
end

function Stepper:Previous()
    if self.currentStep > 1 then
        self.currentStep = self.currentStep - 1
        self:UpdateSteps()
        self.StepChanged:Fire(self.currentStep, "previous")
    end
    return self
end

function Stepper:UpdateSteps()
    for i, elem in ipairs(self.stepElements) do
        local isActive = i <= self.currentStep
        elem.circle.BackgroundColor3 = isActive and self.theme.colors.primary or self.theme.colors.bg3
        elem.number.Text = i == self.currentStep and "●" or tostring(i)
        elem.number.TextColor3 = isActive and Color3.fromRGB(255, 255, 255) or self.theme.colors.text3
        elem.label.TextColor3 = isActive and self.theme.colors.text1 or self.theme.colors.text3
    end
    
    self.prevButton.Visible = self.currentStep > 1
    self.nextButton.Text = self.currentStep == #self.steps and "Finish" or "Next"
end

function Stepper:GoToStep(step)
    if step >= 1 and step <= #self.steps then
        self.currentStep = step
        self:UpdateSteps()
        self.StepChanged:Fire(self.currentStep, "goto")
    end
    return self
end

local CopyButton = setmetatable({}, {__index = Component})
CopyButton.__index = CopyButton

function CopyButton.new(parent, theme, style, window, text, textToCopy)
    local self = setmetatable(Component.new(parent, theme, style, window), CopyButton)
    self.text = text
    self.textToCopy = textToCopy
    self.Copied = Signal.new()
    self:Create()
    return self
end

function CopyButton:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -100, 0, 30)
    textBox.Position = UDim2.new(0, 12, 0.5, -15)
    textBox.BackgroundColor3 = self.theme.colors.bg4
    textBox.BorderSizePixel = 0
    textBox.Text = self.textToCopy
    textBox.TextColor3 = self.theme.colors.text1
    textBox.TextSize = 12
    textBox.Font = self.style.fontMono
    textBox.ClearTextOnFocus = false
    textBox.TextEditable = false
    textBox.ZIndex = ZINDEX.Content
    textBox.Parent = container
    self.textBox = textBox
    
    self.theme:Track(textBox, "BackgroundColor3", "bg4")
    self.theme:Track(textBox, "TextColor3", "text1")
    
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    textBoxCorner.Parent = textBox
    
    local textBoxPadding = Instance.new("UIPadding")
    textBoxPadding.PaddingLeft = UDim.new(0, 10)
    textBoxPadding.PaddingRight = UDim.new(0, 10)
    textBoxPadding.Parent = textBox
    
    local copyButton = Instance.new("TextButton")
    copyButton.Size = UDim2.new(0, 80, 0, 30)
    copyButton.Position = UDim2.new(1, -92, 0.5, -15)
    copyButton.BackgroundColor3 = self.theme.colors.primary
    copyButton.BorderSizePixel = 0
    copyButton.Text = "Copy"
    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyButton.TextSize = 12
    copyButton.Font = self.style.fontTitle
    copyButton.ZIndex = ZINDEX.Content
    copyButton.Parent = container
    self.copyButton = copyButton
    
    self.theme:Track(copyButton, "BackgroundColor3", "primary")
    
    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    copyCorner.Parent = copyButton
    
    copyButton.MouseButton1Click:Connect(function()
        local success = pcall(function()
            if setclipboard then
                setclipboard(self.textToCopy)
                copyButton.Text = "Copied!"
                task.wait(1.5)
                copyButton.Text = "Copy"
                self.Copied:Fire(self.textToCopy)
            else
                copyButton.Text = "Failed"
                task.wait(1.5)
                copyButton.Text = "Copy"
            end
        end)
    end)
end

function CopyButton:SetText(text)
    self.textToCopy = text
    if self.textBox then
        self.textBox.Text = text
    end
    return self
end

local ThemePicker = setmetatable({}, {__index = Component})
ThemePicker.__index = ThemePicker

function ThemePicker.new(parent, theme, style, window, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), ThemePicker)
    self.callback = callback
    self.themes = {}
    for name, _ in pairs(ThemePresets) do
        table.insert(self.themes, name)
    end
    table.sort(self.themes)
    self:Create()
    return self
end

function ThemePicker:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = container
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "Theme Presets"
    title.TextColor3 = self.theme.colors.text1
    title.TextSize = 14
    title.Font = self.style.fontTitle
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.LayoutOrder = 1
    title.ZIndex = ZINDEX.Content
    title.Parent = container
    
    self.theme:Track(title, "TextColor3", "text1")
    
    local gridContainer = Instance.new("Frame")
    gridContainer.Size = UDim2.new(1, 0, 0, 0)
    gridContainer.AutomaticSize = Enum.AutomaticSize.Y
    gridContainer.BackgroundTransparency = 1
    gridContainer.LayoutOrder = 2
    gridContainer.ZIndex = ZINDEX.Content
    gridContainer.Parent = container
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(0.25, -9, 0, 80)
    gridLayout.CellPadding = UDim2.new(0, 12, 0, 12)
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Parent = gridContainer
    
    for i, themeName in ipairs(self.themes) do
        local themeCard = Instance.new("TextButton")
        themeCard.BackgroundColor3 = self.theme.colors.bg3
        themeCard.BorderSizePixel = 0
        themeCard.Text = ""
        themeCard.LayoutOrder = i
        themeCard.ZIndex = ZINDEX.Content
        themeCard.Parent = gridContainer
        
        self.theme:Track(themeCard, "BackgroundColor3", "bg3")
        
        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
        cardCorner.Parent = themeCard
        
        local themePreview = Instance.new("Frame")
        themePreview.Size = UDim2.new(1, -16, 0, 36)
        themePreview.Position = UDim2.new(0, 8, 0, 8)
        themePreview.BackgroundColor3 = ThemePresets[themeName].primary
        themePreview.BorderSizePixel = 0
        themePreview.ZIndex = ZINDEX.Content
        themePreview.Parent = themeCard
        
        local previewCorner = Instance.new("UICorner")
        previewCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
        previewCorner.Parent = themePreview
        
        local previewGradient = Instance.new("UIGradient")
        previewGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, ThemePresets[themeName].primary),
            ColorSequenceKeypoint.new(1, ThemePresets[themeName].secondary)
        }
        previewGradient.Rotation = 45
        previewGradient.Parent = themePreview
        
        local themeName_label = Instance.new("TextLabel")
        themeName_label.Size = UDim2.new(1, -16, 0, 24)
        themeName_label.Position = UDim2.new(0, 8, 1, -32)
        themeName_label.BackgroundTransparency = 1
        themeName_label.Text = themeName
        themeName_label.TextColor3 = self.theme.colors.text1
        themeName_label.TextSize = 12
        themeName_label.Font = self.style.fontTitle
        themeName_label.ZIndex = ZINDEX.Content
        themeName_label.Parent = themeCard
        
        self.theme:Track(themeName_label, "TextColor3", "text1")
        
        themeCard.MouseButton1Click:Connect(function()
            if self.callback then
                self.callback(themeName)
            end
            self.Changed:Fire(themeName)
        end)
        
        themeCard.MouseEnter:Connect(function()
            TweenService:Create(themeCard, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
        
        themeCard.MouseLeave:Connect(function()
            TweenService:Create(themeCard, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end
end

local ExportImport = setmetatable({}, {__index = Component})
ExportImport.__index = ExportImport

function ExportImport.new(parent, theme, style, window, config, filename)
    local self = setmetatable(Component.new(parent, theme, style, window), ExportImport)
    self.config = config
    self.filename = filename or "config.json"
    self.Exported = Signal.new()
    self.Imported = Signal.new()
    self:Create()
    return self
end

function ExportImport:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 16)
    padding.PaddingRight = UDim.new(0, 16)
    padding.PaddingTop = UDim.new(0, 16)
    padding.PaddingBottom = UDim.new(0, 16)
    padding.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 12)
    layout.Parent = container
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 24)
    title.BackgroundTransparency = 1
    title.Text = "Configuration Management"
    title.TextColor3 = self.theme.colors.text1
    title.TextSize = 14
    title.Font = self.style.fontTitle
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.LayoutOrder = 1
    title.ZIndex = ZINDEX.Content
    title.Parent = container
    
    self.theme:Track(title, "TextColor3", "text1")
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.LayoutOrder = 2
    buttonContainer.ZIndex = ZINDEX.Content
    buttonContainer.Parent = container
    
    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    buttonLayout.Padding = UDim.new(0, 8)
    buttonLayout.Parent = buttonContainer
    
    local exportButton = Instance.new("TextButton")
    exportButton.Size = UDim2.new(0.5, -4, 1, 0)
    exportButton.BackgroundColor3 = self.theme.colors.primary
    exportButton.BorderSizePixel = 0
    exportButton.Text = "Export Config"
    exportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    exportButton.TextSize = 13
    exportButton.Font = self.style.fontTitle
    exportButton.LayoutOrder = 1
    exportButton.ZIndex = ZINDEX.Content
    exportButton.Parent = buttonContainer
    
    self.theme:Track(exportButton, "BackgroundColor3", "primary")
    
    local exportCorner = Instance.new("UICorner")
    exportCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    exportCorner.Parent = exportButton
    
    local importButton = Instance.new("TextButton")
    importButton.Size = UDim2.new(0.5, -4, 1, 0)
    importButton.BackgroundColor3 = self.theme.colors.secondary
    importButton.BorderSizePixel = 0
    importButton.Text = "Import Config"
    importButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    importButton.TextSize = 13
    importButton.Font = self.style.fontTitle
    importButton.LayoutOrder = 2
    importButton.ZIndex = ZINDEX.Content
    importButton.Parent = buttonContainer
    
    self.theme:Track(importButton, "BackgroundColor3", "secondary")
    
    local importCorner = Instance.new("UICorner")
    importCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    importCorner.Parent = importButton
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = self.theme.colors.text2
    statusLabel.TextSize = 11
    statusLabel.Font = self.style.fontBody
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.LayoutOrder = 3
    statusLabel.ZIndex = ZINDEX.Content
    statusLabel.Parent = container
    self.statusLabel = statusLabel
    
    self.theme:Track(statusLabel, "TextColor3", "text2")
    
    exportButton.MouseButton1Click:Connect(function()
        self:Export()
    end)
    
    importButton.MouseButton1Click:Connect(function()
        self:Import()
    end)
end

function ExportImport:Export()
    local success = pcall(function()
        if writefile then
            local json = HttpService:JSONEncode(self.config)
            writefile(self.filename, json)
            self.statusLabel.Text = "✓ Exported to " .. self.filename
            self.statusLabel.TextColor3 = self.theme.colors.success
            self.Exported:Fire(self.filename)
        else
            self.statusLabel.Text = "✗ Export not supported"
            self.statusLabel.TextColor3 = self.theme.colors.error
        end
    end)
    
    if not success then
        self.statusLabel.Text = "✗ Export failed"
        self.statusLabel.TextColor3 = self.theme.colors.error
    end
    
    return self
end

function ExportImport:Import()
    local success, result = pcall(function()
        if readfile then
            local json = readfile(self.filename)
            local imported = HttpService:JSONDecode(json)
            
            for category, settings in pairs(imported) do
                if self.config[category] then
                    for setting, value in pairs(settings) do
                        self.config[category][setting] = value
                    end
                end
            end
            
            self.statusLabel.Text = "✓ Imported from " .. self.filename
            self.statusLabel.TextColor3 = self.theme.colors.success
            self.Imported:Fire(self.config)
            return true
        else
            self.statusLabel.Text = "✗ Import not supported"
            self.statusLabel.TextColor3 = self.theme.colors.error
            return false
        end
    end)
    
    if not success then
        self.statusLabel.Text = "✗ Import failed or file not found"
        self.statusLabel.TextColor3 = self.theme.colors.error
    end
    
    return self
end

local SearchFilter = setmetatable({}, {__index = Component})
SearchFilter.__index = SearchFilter

function SearchFilter.new(parent, theme, style, window, items, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), SearchFilter)
    self.items = items or {}
    self.filteredItems = {}
    self.callback = callback
    self:Create()
    return self
end

function SearchFilter:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 300)
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    searchBox.BackgroundColor3 = self.theme.colors.bg3
    searchBox.BorderSizePixel = 0
    searchBox.PlaceholderText = "Search..."
    searchBox.PlaceholderColor3 = self.theme.colors.text3
    searchBox.Text = ""
    searchBox.TextColor3 = self.theme.colors.text1
    searchBox.TextSize = 13
    searchBox.Font = self.style.fontBody
    searchBox.ClearTextOnFocus = false
    searchBox.ZIndex = ZINDEX.Content
    searchBox.Parent = container
    self.searchBox = searchBox
    
    self.theme:Track(searchBox, "BackgroundColor3", "bg3")
    self.theme:Track(searchBox, "TextColor3", "text1")
    self.theme:Track(searchBox, "PlaceholderColor3", "text3")
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    searchCorner.Parent = searchBox
    
    local searchPadding = Instance.new("UIPadding")
    searchPadding.PaddingLeft = UDim.new(0, 36)
    searchPadding.PaddingRight = UDim.new(0, 12)
    searchPadding.Parent = searchBox
    
    local searchIcon = Instance.new("TextLabel")
    searchIcon.Size = UDim2.new(0, 36, 1, 0)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Text = "🔍"
    searchIcon.TextSize = 16
    searchIcon.ZIndex = ZINDEX.Content
    searchIcon.Parent = searchBox
    
    local resultContainer = Instance.new("ScrollingFrame")
    resultContainer.Size = UDim2.new(1, 0, 1, -self.style.buttonHeight - 8)
    resultContainer.Position = UDim2.new(0, 0, 0, self.style.buttonHeight + 8)
    resultContainer.BackgroundColor3 = self.theme.colors.bg3
    resultContainer.BorderSizePixel = 0
    resultContainer.ScrollBarThickness = 4
    resultContainer.ScrollBarImageColor3 = self.theme.colors.text3
    resultContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    resultContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    resultContainer.ZIndex = ZINDEX.Content
    resultContainer.Parent = container
    self.resultContainer = resultContainer
    
    self.theme:Track(resultContainer, "BackgroundColor3", "bg3")
    
    local resultCorner = Instance.new("UICorner")
    resultCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    resultCorner.Parent = resultContainer
    
    local resultPadding = Instance.new("UIPadding")
    resultPadding.PaddingLeft = UDim.new(0, 8)
    resultPadding.PaddingRight = UDim.new(0, 8)
    resultPadding.PaddingTop = UDim.new(0, 8)
    resultPadding.PaddingBottom = UDim.new(0, 8)
    resultPadding.Parent = resultContainer
    
    local resultLayout = Instance.new("UIListLayout")
    resultLayout.SortOrder = Enum.SortOrder.LayoutOrder
    resultLayout.Padding = UDim.new(0, 4)
    resultLayout.Parent = resultContainer
    
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        self:Filter(searchBox.Text)
    end)
    
    self:Filter("")
end

function SearchFilter:Filter(query)
    for _, child in ipairs(self.resultContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    self.filteredItems = {}
    
    for _, item in ipairs(self.items) do
        if query == "" or item:lower():find(query:lower(), 1, true) then
            table.insert(self.filteredItems, item)
        end
    end
    
    for i, item in ipairs(self.filteredItems) do
        local itemButton = Instance.new("TextButton")
        itemButton.Size = UDim2.new(1, 0, 0, 32)
        itemButton.BackgroundColor3 = self.theme.colors.bg2
        itemButton.BorderSizePixel = 0
        itemButton.Text = ""
        itemButton.LayoutOrder = i
        itemButton.ZIndex = ZINDEX.Content
        itemButton.Parent = self.resultContainer
        
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
        itemCorner.Parent = itemButton
        
        local itemLabel = Instance.new("TextLabel")
        itemLabel.Size = UDim2.new(1, -16, 1, 0)
        itemLabel.Position = UDim2.new(0, 8, 0, 0)
        itemLabel.BackgroundTransparency = 1
        itemLabel.Text = item
        itemLabel.TextColor3 = self.theme.colors.text1
        itemLabel.TextSize = 12
        itemLabel.Font = self.style.fontBody
        itemLabel.TextXAlignment = Enum.TextXAlignment.Left
        itemLabel.ZIndex = ZINDEX.Content
        itemLabel.Parent = itemButton
        
        self.theme:Track(itemLabel, "TextColor3", "text1")
        
        itemButton.MouseButton1Click:Connect(function()
            if self.callback then
                self.callback(item)
            end
            self.Changed:Fire(item)
        end)
        
        itemButton.MouseEnter:Connect(function()
            TweenService:Create(itemButton, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
        
        itemButton.MouseLeave:Connect(function()
            TweenService:Create(itemButton, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg2}):Play()
        end)
    end
end

function SearchFilter:SetItems(items)
    self.items = items
    self:Filter(self.searchBox.Text)
    return self
end

local Pagination = setmetatable({}, {__index = Component})
Pagination.__index = Pagination

function Pagination.new(parent, theme, style, window, totalPages, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), Pagination)
    self.totalPages = totalPages or 1
    self.currentPage = 1
    self.callback = callback
    self.PageChanged = Signal.new()
    self:Create()
    return self
end

function Pagination:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 44)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(0, 0, 0, 36)
    buttonContainer.Position = UDim2.new(0.5, 0, 0.5, -18)
    buttonContainer.AutomaticSize = Enum.AutomaticSize.X
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.AnchorPoint = Vector2.new(0.5, 0)
    buttonContainer.ZIndex = ZINDEX.Content
    buttonContainer.Parent = container
    self.buttonContainer = buttonContainer
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = buttonContainer
    
    self:UpdateButtons()
end

function Pagination:UpdateButtons()
    for _, child in ipairs(self.buttonContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local prevButton = Instance.new("TextButton")
    prevButton.Size = UDim2.new(0, 36, 0, 36)
    prevButton.BackgroundColor3 = self.currentPage > 1 and self.theme.colors.bg4 or self.theme.colors.bg2
    prevButton.BorderSizePixel = 0
    prevButton.Text = "<"
    prevButton.TextColor3 = self.currentPage > 1 and self.theme.colors.text1 or self.theme.colors.text3
    prevButton.TextSize = 14
    prevButton.Font = self.style.fontTitle
    prevButton.Active = self.currentPage > 1
    prevButton.LayoutOrder = 1
    prevButton.ZIndex = ZINDEX.Content
    prevButton.Parent = self.buttonContainer
    
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    prevCorner.Parent = prevButton
    
    prevButton.MouseButton1Click:Connect(function()
        if self.currentPage > 1 then
            self:GoToPage(self.currentPage - 1)
        end
    end)
    
    local startPage = math.max(1, self.currentPage - 2)
    local endPage = math.min(self.totalPages, startPage + 4)
    startPage = math.max(1, endPage - 4)
    
    for i = startPage, endPage do
        local pageButton = Instance.new("TextButton")
        pageButton.Size = UDim2.new(0, 36, 0, 36)
        pageButton.BackgroundColor3 = i == self.currentPage and self.theme.colors.primary or self.theme.colors.bg4
        pageButton.BorderSizePixel = 0
        pageButton.Text = tostring(i)
        pageButton.TextColor3 = i == self.currentPage and Color3.fromRGB(255, 255, 255) or self.theme.colors.text1
        pageButton.TextSize = 13
        pageButton.Font = self.style.fontTitle
        pageButton.LayoutOrder = i + 1
        pageButton.ZIndex = ZINDEX.Content
        pageButton.Parent = self.buttonContainer
        
        if i ~= self.currentPage then
            self.theme:Track(pageButton, "BackgroundColor3", "bg4")
            self.theme:Track(pageButton, "TextColor3", "text1")
        else
            self.theme:Track(pageButton, "BackgroundColor3", "primary")
        end
        
        local pageCorner = Instance.new("UICorner")
        pageCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
        pageCorner.Parent = pageButton
        
        pageButton.MouseButton1Click:Connect(function()
            self:GoToPage(i)
        end)
    end
    
    local nextButton = Instance.new("TextButton")
    nextButton.Size = UDim2.new(0, 36, 0, 36)
    nextButton.BackgroundColor3 = self.currentPage < self.totalPages and self.theme.colors.bg4 or self.theme.colors.bg2
    nextButton.BorderSizePixel = 0
    nextButton.Text = ">"
    nextButton.TextColor3 = self.currentPage < self.totalPages and self.theme.colors.text1 or self.theme.colors.text3
    nextButton.TextSize = 14
    nextButton.Font = self.style.fontTitle
    nextButton.Active = self.currentPage < self.totalPages
    nextButton.LayoutOrder = endPage + 2
    nextButton.ZIndex = ZINDEX.Content
    nextButton.Parent = self.buttonContainer
    
    local nextCorner = Instance.new("UICorner")
    nextCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    nextCorner.Parent = nextButton
    
    nextButton.MouseButton1Click:Connect(function()
        if self.currentPage < self.totalPages then
            self:GoToPage(self.currentPage + 1)
        end
    end)
end

function Pagination:GoToPage(page)
    if page >= 1 and page <= self.totalPages then
        self.currentPage = page
        self:UpdateButtons()
        if self.callback then
            self.callback(page)
        end
        self.PageChanged:Fire(page)
    end
    return self
end

function Pagination:SetTotalPages(total)
    self.totalPages = total
    if self.currentPage > total then
        self.currentPage = total
    end
    self:UpdateButtons()
    return self
end

local ImageGallery = setmetatable({}, {__index = Component})
ImageGallery.__index = ImageGallery

function ImageGallery.new(parent, theme, style, window, images, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), ImageGallery)
    self.images = images or {}
    self.selectedIndex = nil
    self.callback = callback
    self.ImageSelected = Signal.new()
    self:Create()
    return self
end

function ImageGallery:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.PaddingTop = UDim.new(0, 12)
    padding.PaddingBottom = UDim.new(0, 12)
    padding.Parent = container
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(0.25, -9, 0, 120)
    gridLayout.CellPadding = UDim2.new(0, 12, 0, 12)
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Parent = container
    self.gridLayout = gridLayout
    
    for i, imageData in ipairs(self.images) do
        local imageCard = Instance.new("Frame")
        imageCard.BackgroundColor3 = self.theme.colors.bg2
        imageCard.BorderSizePixel = 0
        imageCard.LayoutOrder = i
        imageCard.ZIndex = ZINDEX.Content
        imageCard.Parent = container
        
        self.theme:Track(imageCard, "BackgroundColor3", "bg2")
        
        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
        cardCorner.Parent = imageCard
        
        local image = Instance.new("ImageLabel")
        image.Size = UDim2.new(1, -8, 1, -40)
        image.Position = UDim2.new(0, 4, 0, 4)
        image.BackgroundColor3 = self.theme.colors.bg4
        image.BorderSizePixel = 0
        image.Image = imageData.id or imageData.image or ""
        image.ScaleType = Enum.ScaleType.Fit
        image.ZIndex = ZINDEX.Content
        image.Parent = imageCard
        
        local imageCorner = Instance.new("UICorner")
        imageCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
        imageCorner.Parent = image
        
        local selectButton = Instance.new("TextButton")
        selectButton.Size = UDim2.new(1, -8, 0, 28)
        selectButton.Position = UDim2.new(0, 4, 1, -32)
        selectButton.BackgroundColor3 = self.theme.colors.primary
        selectButton.BorderSizePixel = 0
        selectButton.Text = imageData.name or "Select"
        selectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        selectButton.TextSize = 11
        selectButton.Font = self.style.fontTitle
        selectButton.ZIndex = ZINDEX.Content
        selectButton.Parent = imageCard
        
        self.theme:Track(selectButton, "BackgroundColor3", "primary")
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
        btnCorner.Parent = selectButton
        
        selectButton.MouseButton1Click:Connect(function()
            self.selectedIndex = i
            if self.callback then
                self.callback(imageData, i)
            end
            self.ImageSelected:Fire(imageData, i)
        end)
    end
end

function ImageGallery:AddImage(imageData)
    table.insert(self.images, imageData)
    return self
end

function ImageGallery:GetSelected()
    return self.selectedIndex and self.images[self.selectedIndex] or nil
end

local ImageButton = setmetatable({}, {__index = Component})
ImageButton.__index = ImageButton

function ImageButton.new(parent, theme, style, window, imageId, text, callback, clickableImage)
    local self = setmetatable(Component.new(parent, theme, style, window), ImageButton)
    self.imageId = imageId
    self.text = text or "Click"
    self.callback = callback
    self.clickableImage = clickableImage or false
    self.Clicked = Signal.new()
    self:Create()
    return self
end

function ImageButton:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = container
    
    local imageFrame = Instance.new("Frame")
    imageFrame.Size = UDim2.new(0, 200, 0, 200)
    imageFrame.BackgroundColor3 = self.theme.colors.bg3
    imageFrame.BorderSizePixel = 0
    imageFrame.LayoutOrder = 1
    imageFrame.ZIndex = ZINDEX.Content
    imageFrame.Parent = container
    
    self.theme:Track(imageFrame, "BackgroundColor3", "bg3")
    
    local imageCorner = Instance.new("UICorner")
    imageCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    imageCorner.Parent = imageFrame
    
    if self.clickableImage then
        local imageButton = Instance.new("ImageButton")
        imageButton.Size = UDim2.new(1, 0, 1, 0)
        imageButton.BackgroundTransparency = 1
        imageButton.Image = self.imageId
        imageButton.ScaleType = Enum.ScaleType.Fit
        imageButton.ZIndex = ZINDEX.Content
        imageButton.Parent = imageFrame
        self.imageElement = imageButton
        
        imageButton.MouseButton1Click:Connect(function()
            if self.callback then
                self.callback()
            end
            self.Clicked:Fire()
        end)
        
        imageButton.MouseEnter:Connect(function()
            TweenService:Create(imageFrame, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
        
        imageButton.MouseLeave:Connect(function()
            TweenService:Create(imageFrame, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    else
        local image = Instance.new("ImageLabel")
        image.Size = UDim2.new(1, 0, 1, 0)
        image.BackgroundTransparency = 1
        image.Image = self.imageId
        image.ScaleType = Enum.ScaleType.Fit
        image.ZIndex = ZINDEX.Content
        image.Parent = imageFrame
        self.imageElement = image
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 200, 0, self.style.buttonHeight)
        button.BackgroundColor3 = self.theme.colors.primary
        button.BorderSizePixel = 0
        button.Text = self.text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 13
        button.Font = self.style.fontTitle
        button.LayoutOrder = 2
        button.ZIndex = ZINDEX.Content
        button.Parent = container
        
        self.theme:Track(button, "BackgroundColor3", "primary")
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
        buttonCorner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if self.callback then
                self.callback()
            end
            self.Clicked:Fire()
        end)
    end
end

function ImageButton:SetImage(imageId)
    self.imageId = imageId
    if self.imageElement then
        self.imageElement.Image = imageId
    end
    return self
end



local Checkbox = setmetatable({}, {__index = Component})
Checkbox.__index = Checkbox

function Checkbox.new(parent, theme, style, window, text, default, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), Checkbox)
    self.text = text
    self.value = default or false
    self.callback = callback
    self:Create()
    return self
end

function Checkbox:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local checkboxFrame = Instance.new("Frame")
    checkboxFrame.Size = UDim2.new(0, 20, 0, 20)
    checkboxFrame.Position = UDim2.new(0, 12, 0.5, -10)
    checkboxFrame.BackgroundColor3 = self.theme.colors.bg4
    checkboxFrame.BorderSizePixel = 0
    checkboxFrame.ZIndex = ZINDEX.Content + 1
    checkboxFrame.Parent = container
    
    self.theme:Track(checkboxFrame, "BackgroundColor3", "bg4")
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.CornerRadius = UDim.new(0, 4)
    checkboxCorner.Parent = checkboxFrame
    
    local checkboxStroke = Instance.new("UIStroke")
    checkboxStroke.Color = self.theme.colors.border
    checkboxStroke.Thickness = 2
    checkboxStroke.Parent = checkboxFrame
    
    self.theme:Track(checkboxStroke, "Color", "border")
    
    local checkmark = Instance.new("TextLabel")
    checkmark.Size = UDim2.new(1, 0, 1, 0)
    checkmark.BackgroundTransparency = 1
    checkmark.Text = self.value and "✓" or ""
    checkmark.TextColor3 = self.theme.colors.primary
    checkmark.TextSize = 14
    checkmark.Font = Enum.Font.GothamBold
    checkmark.ZIndex = ZINDEX.Content + 2
    checkmark.Parent = checkboxFrame
    self.checkmark = checkmark
    
    self.theme:Track(checkmark, "TextColor3", "primary")
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -44, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.ZIndex = ZINDEX.Content + 3
    button.Parent = container
    
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    if isMobile() then
        button.TouchTap:Connect(function()
            self:Toggle()
        end)
    end
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
            TweenService:Create(checkboxStroke, TweenInfo.new(self.style.animationSpeed), {Color = self.theme.colors.primary}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
            TweenService:Create(checkboxStroke, TweenInfo.new(self.style.animationSpeed), {Color = self.theme.colors.border}):Play()
        end)
    end)
end

function Checkbox:Toggle()
    self.value = not self.value
    self.checkmark.Text = self.value and "✓" or ""
    if self.callback then
        self.callback(self.value)
    end
    self.Changed:Fire(self.value)
    return self
end

function Checkbox:SetValue(value)
    if value ~= self.value then
        self:Toggle()
    end
    return self
end

function Checkbox:GetValue()
    return self.value
end

local ProgressBar = setmetatable({}, {__index = Component})
ProgressBar.__index = ProgressBar

function ProgressBar.new(parent, theme, style, window, text, value, max)
    local self = setmetatable(Component.new(parent, theme, style, window), ProgressBar)
    self.text = text
    self.value = value or 0
    self.max = max or 100
    self:Create()
    return self
end

function ProgressBar:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 60)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, -24, 0, 20)
    header.Position = UDim2.new(0, 12, 0, 10)
    header.BackgroundTransparency = 1
    header.ZIndex = ZINDEX.Content
    header.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = header
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local percentage = Instance.new("TextLabel")
    percentage.Size = UDim2.new(0.3, 0, 1, 0)
    percentage.Position = UDim2.new(0.7, 0, 0, 0)
    percentage.BackgroundTransparency = 1
    percentage.Text = math.floor((self.value / self.max) * 100) .. "%"
    percentage.TextColor3 = self.theme.colors.primary
    percentage.TextSize = 13
    percentage.Font = self.style.fontTitle
    percentage.TextXAlignment = Enum.TextXAlignment.Right
    percentage.ZIndex = ZINDEX.Content
    percentage.Parent = header
    self.percentage = percentage
    
    self.theme:Track(percentage, "TextColor3", "primary")
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -24, 0, 8)
    track.Position = UDim2.new(0, 12, 1, -18)
    track.BackgroundColor3 = self.theme.colors.bg4
    track.BorderSizePixel = 0
    track.ZIndex = ZINDEX.Content
    track.Parent = container
    
    self.theme:Track(track, "BackgroundColor3", "bg4")
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(self.value / self.max, 0, 1, 0)
    fill.BackgroundColor3 = self.theme.colors.primary
    fill.BorderSizePixel = 0
    fill.ZIndex = ZINDEX.Content + 1
    fill.Parent = track
    self.fill = fill
    
    self.theme:Track(fill, "BackgroundColor3", "primary")
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
end

function ProgressBar:SetValue(value)
    self.value = math.clamp(value, 0, self.max)
    local percent = (self.value / self.max)
    
    safeCall(function()
        TweenService:Create(self.fill, TweenInfo.new(self.style.animationSpeed), {
            Size = UDim2.new(percent, 0, 1, 0)
        }):Play()
        self.percentage.Text = math.floor(percent * 100) .. "%"
    end)
    
    self.Changed:Fire(self.value)
    return self
end

function ProgressBar:GetValue()
    return self.value
end

function ProgressBar:SetMax(max)
    self.max = max
    self:SetValue(self.value)
    return self
end

function ProgressBar:Increment(amount)
    self:SetValue(self.value + (amount or 1))
    return self
end

local TabContainer = setmetatable({}, {__index = Component})
TabContainer.__index = TabContainer

function TabContainer.new(parent, theme, style, window)
    local self = setmetatable(Component.new(parent, theme, style, window), TabContainer)
    self.tabs = {}
    self.currentTab = nil
    self.TabChanged = Signal.new()
    self:Create()
    return self
end

function TabContainer:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, 0, 0, 40)
    tabBar.BackgroundColor3 = self.theme.colors.bg3
    tabBar.BorderSizePixel = 0
    tabBar.ZIndex = ZINDEX.Content
    tabBar.Parent = container
    self.tabBar = tabBar
    
    self.theme:Track(tabBar, "BackgroundColor3", "bg3")
    
    local tabBarCorner = Instance.new("UICorner")
    tabBarCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    tabBarCorner.Parent = tabBar
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 4)
    tabLayout.Parent = tabBar
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingLeft = UDim.new(0, 8)
    tabPadding.PaddingRight = UDim.new(0, 8)
    tabPadding.PaddingTop = UDim.new(0, 6)
    tabPadding.PaddingBottom = UDim.new(0, 6)
    tabPadding.Parent = tabBar
    
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 0, 0)
    tabContent.Position = UDim2.new(0, 0, 0, 48)
    tabContent.AutomaticSize = Enum.AutomaticSize.Y
    tabContent.BackgroundTransparency = 1
    tabContent.ZIndex = ZINDEX.Content
    tabContent.Parent = container
    self.tabContent = tabContent
end

function TabContainer:AddTab(name)
    local tab = {
        name = name,
        content = Instance.new("Frame"),
        button = nil,
        components = {}
    }
    
    tab.content.Name = name .. "Tab"
    tab.content.Size = UDim2.new(1, 0, 0, 0)
    tab.content.AutomaticSize = Enum.AutomaticSize.Y
    tab.content.BackgroundTransparency = 1
    tab.content.Visible = false
    tab.content.ZIndex = ZINDEX.Content
    tab.content.Parent = self.tabContent
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, self.style.spacing)
    contentLayout.Parent = tab.content
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 0, 1, 0)
    button.AutomaticSize = Enum.AutomaticSize.X
    button.BackgroundColor3 = self.theme.colors.bg4
    button.BackgroundTransparency = 0.5
    button.BorderSizePixel = 0
    button.Text = ""
    button.LayoutOrder = #self.tabs + 1
    button.ZIndex = ZINDEX.Content + 1
    button.Parent = self.tabBar
    tab.button = button
    
    self.theme:Track(button, "BackgroundColor3", "bg4")
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    buttonCorner.Parent = button
    
    local buttonPadding = Instance.new("UIPadding")
    buttonPadding.PaddingLeft = UDim.new(0, 16)
    buttonPadding.PaddingRight = UDim.new(0, 16)
    buttonPadding.Parent = button
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = self.theme.colors.text2
    label.TextSize = 12
    label.Font = self.style.fontBody
    label.ZIndex = ZINDEX.Content + 1
    label.Parent = button
    tab.label = label
    
    self.theme:Track(label, "TextColor3", "text2")
    
    button.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    
    button.MouseEnter:Connect(function()
        if self.currentTab ~= tab then
            TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 0.3}):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if self.currentTab ~= tab then
            TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 0.5}):Play()
        end
    end)
    
    table.insert(self.tabs, tab)
    
    if #self.tabs == 1 then
        self:SelectTab(tab)
    end
    
    return tab
end

function TabContainer:SelectTab(tab)
    for _, t in ipairs(self.tabs) do
        t.content.Visible = false
        TweenService:Create(t.button, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 0.5}):Play()
        TweenService:Create(t.label, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.text2}):Play()
    end
    
    tab.content.Visible = true
    TweenService:Create(tab.button, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 0}):Play()
    TweenService:Create(tab.label, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.primary}):Play()
    
    self.currentTab = tab
    self.TabChanged:Fire(tab)
    return self
end

local Toast = {}
Toast.__index = Toast

function Toast.new(gui, theme, style)
    local self = setmetatable({}, Toast)
    self.gui = gui
    self.theme = theme
    self.style = style
    self.queue = {}
    self.active = {}
    return self
end

function Toast:Show(message, duration, type)
    local toastType = type or "info"
    local color = toastType == "success" and self.theme.colors.success or
                  toastType == "error" and self.theme.colors.error or
                  toastType == "warning" and self.theme.colors.warning or
                  self.theme.colors.primary
    
    local toast = Instance.new("Frame")
    toast.Size = UDim2.new(0, 300, 0, 60)
    toast.Position = UDim2.new(1, 320, 1, -100 - (#self.active * 70))
    toast.BackgroundColor3 = self.theme.colors.bg2
    toast.BorderSizePixel = 0
    toast.ZIndex = ZINDEX.Notification
    toast.Parent = self.gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toast
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 2
    stroke.Parent = toast
    
    local icon = Instance.new("Frame")
    icon.Size = UDim2.new(0, 4, 1, 0)
    icon.BackgroundColor3 = color
    icon.BorderSizePixel = 0
    icon.ZIndex = ZINDEX.Notification + 1
    icon.Parent = toast
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = icon
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -20, 1, 0)
    messageLabel.Position = UDim2.new(0, 16, 0, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = self.theme.colors.text1
    messageLabel.TextSize = 13
    messageLabel.Font = self.style.fontBody
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.ZIndex = ZINDEX.Notification + 1
    messageLabel.Parent = toast
    
    table.insert(self.active, toast)
    
    toast:TweenPosition(
        UDim2.new(1, -320, 1, -100 - ((#self.active - 1) * 70)),
        "Out",
        "Quart",
        0.3,
        true
    )
    
    task.delay(duration or 3, function()
        toast:TweenPosition(
            UDim2.new(1, 20, toast.Position.Y.Scale, toast.Position.Y.Offset),
            "In",
            "Quart",
            0.3,
            true
        )
        
        task.wait(0.3)
        
        for i, t in ipairs(self.active) do
            if t == toast then
                table.remove(self.active, i)
                break
            end
        end
        
        toast:Destroy()
    end)
    
    return toast
end

local List = setmetatable({}, {__index = Component})
List.__index = List

function List.new(parent, theme, style, window, title)
    local self = setmetatable(Component.new(parent, theme, style, window), List)
    self.title = title
    self.items = {}
    self.ItemAdded = Signal.new()
    self.ItemRemoved = Signal.new()
    self:Create()
    return self
end

function List:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    if self.title and self.title ~= "" then
        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, 36)
        header.BackgroundColor3 = self.theme.colors.bg4
        header.BorderSizePixel = 0
        header.ZIndex = ZINDEX.Content
        header.Parent = container
        
        self.theme:Track(header, "BackgroundColor3", "bg4")
        
        local headerCorner = Instance.new("UICorner")
        headerCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
        headerCorner.Parent = header
        
        local headerCover = Instance.new("Frame")
        headerCover.Size = UDim2.new(1, 0, 0, self.style.cornerRadius)
        headerCover.Position = UDim2.new(0, 0, 1, -self.style.cornerRadius)
        headerCover.BackgroundColor3 = self.theme.colors.bg4
        headerCover.BorderSizePixel = 0
        headerCover.ZIndex = ZINDEX.Content
        headerCover.Parent = header
        
        self.theme:Track(headerCover, "BackgroundColor3", "bg4")
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -24, 1, 0)
        titleLabel.Position = UDim2.new(0, 12, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = self.title
        titleLabel.TextColor3 = self.theme.colors.text1
        titleLabel.TextSize = 14
        titleLabel.Font = self.style.fontTitle
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.ZIndex = ZINDEX.Content
        titleLabel.Parent = header
        
        self.theme:Track(titleLabel, "TextColor3", "text1")
    end
    
    local listContainer = Instance.new("Frame")
    listContainer.Name = "ListContainer"
    listContainer.Size = UDim2.new(1, 0, 0, 0)
    listContainer.Position = UDim2.new(0, 0, 0, self.title and 36 or 0)
    listContainer.AutomaticSize = Enum.AutomaticSize.Y
    listContainer.BackgroundTransparency = 1
    listContainer.ZIndex = ZINDEX.Content
    listContainer.Parent = container
    self.listContainer = listContainer
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = listContainer
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)
    layout.Parent = listContainer
end

function List:AddItem(text, onRemove)
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, 0, 0, 32)
    item.BackgroundColor3 = self.theme.colors.bg2
    item.BorderSizePixel = 0
    item.ZIndex = ZINDEX.Content
    item.LayoutOrder = #self.items + 1
    item.Parent = self.listContainer
    
    self.theme:Track(item, "BackgroundColor3", "bg2")
    
    local itemCorner = Instance.new("UICorner")
    itemCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    itemCorner.Parent = item
    
    local itemLabel = Instance.new("TextLabel")
    itemLabel.Size = UDim2.new(1, -40, 1, 0)
    itemLabel.Position = UDim2.new(0, 10, 0, 0)
    itemLabel.BackgroundTransparency = 1
    itemLabel.Text = text
    itemLabel.TextColor3 = self.theme.colors.text1
    itemLabel.TextSize = 12
    itemLabel.Font = self.style.fontBody
    itemLabel.TextXAlignment = Enum.TextXAlignment.Left
    itemLabel.TextTruncate = Enum.TextTruncate.AtEnd
    itemLabel.ZIndex = ZINDEX.Content
    itemLabel.Parent = item
    
    self.theme:Track(itemLabel, "TextColor3", "text1")
    
    local removeBtn = Instance.new("TextButton")
    removeBtn.Size = UDim2.new(0, 28, 0, 28)
    removeBtn.Position = UDim2.new(1, -30, 0.5, -14)
    removeBtn.BackgroundTransparency = 1
    removeBtn.Text = "×"
    removeBtn.TextColor3 = self.theme.colors.text3
    removeBtn.TextSize = 18
    removeBtn.Font = self.style.fontTitle
    removeBtn.ZIndex = ZINDEX.Content + 1
    removeBtn.Parent = item
    
    self.theme:Track(removeBtn, "TextColor3", "text3")
    
    removeBtn.MouseButton1Click:Connect(function()
        for i, itm in ipairs(self.items) do
            if itm == item then
                table.remove(self.items, i)
                break
            end
        end
        item:Destroy()
        if onRemove then
            onRemove(text)
        end
        self.ItemRemoved:Fire(text)
    end)
    
    removeBtn.MouseEnter:Connect(function()
        TweenService:Create(removeBtn, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.error}):Play()
    end)
    
    removeBtn.MouseLeave:Connect(function()
        TweenService:Create(removeBtn, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.text3}):Play()
    end)
    
    table.insert(self.items, item)
    self.ItemAdded:Fire(text)
    
    return item
end

function List:Clear()
    for _, item in ipairs(self.items) do
        item:Destroy()
    end
    self.items = {}
    return self
end

function List:GetItems()
    return self.items
end



local Divider = setmetatable({}, {__index = Component})
Divider.__index = Divider

function Divider.new(parent, theme, style, window, text)
    local self = setmetatable(Component.new(parent, theme, style, window), Divider)
    self.text = text or ""
    self:Create()
    return self
end

function Divider:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.text ~= "" and 30 or 1)
    container.BackgroundTransparency = 1
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    if self.text ~= "" then
        local line1 = Instance.new("Frame")
        line1.Size = UDim2.new(0.3, -10, 0, 1)
        line1.Position = UDim2.new(0, 0, 0.5, 0)
        line1.BackgroundColor3 = self.theme.colors.border
        line1.BorderSizePixel = 0
        line1.ZIndex = ZINDEX.Content
        line1.Parent = container
        
        self.theme:Track(line1, "BackgroundColor3", "border")
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.4, 0, 1, 0)
        label.Position = UDim2.new(0.3, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = self.text
        label.TextColor3 = self.theme.colors.text3
        label.TextSize = 11
        label.Font = self.style.fontBody
        label.ZIndex = ZINDEX.Content
        label.Parent = container
        
        self.theme:Track(label, "TextColor3", "text3")
        
        local line2 = Instance.new("Frame")
        line2.Size = UDim2.new(0.3, -10, 0, 1)
        line2.Position = UDim2.new(0.7, 10, 0.5, 0)
        line2.BackgroundColor3 = self.theme.colors.border
        line2.BorderSizePixel = 0
        line2.ZIndex = ZINDEX.Content
        line2.Parent = container
        
        self.theme:Track(line2, "BackgroundColor3", "border")
    else
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 1)
        line.BackgroundColor3 = self.theme.colors.border
        line.BorderSizePixel = 0
        line.ZIndex = ZINDEX.Content
        line.Parent = container
        
        self.theme:Track(line, "BackgroundColor3", "border")
    end
end

local NumberInput = setmetatable({}, {__index = Component})
NumberInput.__index = NumberInput

function NumberInput.new(parent, theme, style, window, text, default, min, max, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), NumberInput)
    self.text = text
    self.value = default or 0
    self.min = min
    self.max = max
    self.callback = callback
    self:Create()
    return self
end

function NumberInput:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -16, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local inputContainer = Instance.new("Frame")
    inputContainer.Size = UDim2.new(0.5, -24, 0, 30)
    inputContainer.Position = UDim2.new(0.5, 8, 0.5, -15)
    inputContainer.BackgroundColor3 = self.theme.colors.bg4
    inputContainer.BorderSizePixel = 0
    inputContainer.ZIndex = ZINDEX.Content
    inputContainer.Parent = container
    
    self.theme:Track(inputContainer, "BackgroundColor3", "bg4")
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    inputCorner.Parent = inputContainer
    
    local minusButton = Instance.new("TextButton")
    minusButton.Size = UDim2.new(0, 30, 1, 0)
    minusButton.BackgroundTransparency = 1
    minusButton.Text = "-"
    minusButton.TextColor3 = self.theme.colors.text1
    minusButton.TextSize = 16
    minusButton.Font = self.style.fontTitle
    minusButton.ZIndex = ZINDEX.Content + 1
    minusButton.Parent = inputContainer
    
    self.theme:Track(minusButton, "TextColor3", "text1")
    
    local numberBox = Instance.new("TextBox")
    numberBox.Size = UDim2.new(1, -60, 1, 0)
    numberBox.Position = UDim2.new(0, 30, 0, 0)
    numberBox.BackgroundTransparency = 1
    numberBox.Text = tostring(self.value)
    numberBox.TextColor3 = self.theme.colors.text1
    numberBox.TextSize = 13
    numberBox.Font = self.style.fontMono
    numberBox.ZIndex = ZINDEX.Content + 1
    numberBox.Parent = inputContainer
    self.numberBox = numberBox
    
    self.theme:Track(numberBox, "TextColor3", "text1")
    
    local plusButton = Instance.new("TextButton")
    plusButton.Size = UDim2.new(0, 30, 1, 0)
    plusButton.Position = UDim2.new(1, -30, 0, 0)
    plusButton.BackgroundTransparency = 1
    plusButton.Text = "+"
    plusButton.TextColor3 = self.theme.colors.text1
    plusButton.TextSize = 16
    plusButton.Font = self.style.fontTitle
    plusButton.ZIndex = ZINDEX.Content + 1
    plusButton.Parent = inputContainer
    
    self.theme:Track(plusButton, "TextColor3", "text1")
    
    local function updateValue(newValue)
        local num = tonumber(newValue) or self.value
        if self.min then num = math.max(num, self.min) end
        if self.max then num = math.min(num, self.max) end
        self.value = num
        numberBox.Text = tostring(num)
        if self.callback then
            self.callback(num)
        end
        self.Changed:Fire(num)
    end
    
    minusButton.MouseButton1Click:Connect(function()
        updateValue(self.value - 1)
    end)
    
    plusButton.MouseButton1Click:Connect(function()
        updateValue(self.value + 1)
    end)
    
    numberBox.FocusLost:Connect(function()
        updateValue(numberBox.Text)
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function NumberInput:SetValue(value)
    local num = tonumber(value) or self.value
    if self.min then num = math.max(num, self.min) end
    if self.max then num = math.min(num, self.max) end
    self.value = num
    if self.numberBox then
        self.numberBox.Text = tostring(num)
    end
    return self
end

function NumberInput:GetValue()
    return self.value
end

function NumberInput:SetMin(min)
    self.min = min
    self:SetValue(self.value)
    return self
end

function NumberInput:SetMax(max)
    self.max = max
    self:SetValue(self.value)
    return self
end

local Keybind = setmetatable({}, {__index = Component})
Keybind.__index = Keybind

function Keybind.new(parent, theme, style, window, text, default, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), Keybind)
    self.text = text
    self.value = default or Enum.KeyCode.Unknown
    self.callback = callback
    self.listening = false
    self:Create()
    return self
end

function Keybind:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -16, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local keyButton = Instance.new("TextButton")
    keyButton.Size = UDim2.new(0.5, -24, 0, 30)
    keyButton.Position = UDim2.new(0.5, 8, 0.5, -15)
    keyButton.BackgroundColor3 = self.theme.colors.bg4
    keyButton.BorderSizePixel = 0
    keyButton.Text = self.value.Name
    keyButton.TextColor3 = self.theme.colors.text1
    keyButton.TextSize = 12
    keyButton.Font = self.style.fontMono
    keyButton.ZIndex = ZINDEX.Content
    keyButton.Parent = container
    self.keyButton = keyButton
    
    self.theme:Track(keyButton, "BackgroundColor3", "bg4")
    self.theme:Track(keyButton, "TextColor3", "text1")
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    keyCorner.Parent = keyButton
    
    keyButton.MouseButton1Click:Connect(function()
        self.listening = true
        keyButton.Text = "..."
        TweenService:Create(keyButton, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.primary}):Play()
    end)
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if self.listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                self.value = input.KeyCode
                keyButton.Text = input.KeyCode.Name
                self.listening = false
                TweenService:Create(keyButton, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
                if self.callback then
                    self.callback(input.KeyCode)
                end
                self.Changed:Fire(input.KeyCode)
            end
        end
    end)
    
    self.Destroyed:Connect(function()
        if connection then
            connection:Disconnect()
        end
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function Keybind:SetValue(keycode)
    self.value = keycode
    if self.keyButton then
        self.keyButton.Text = keycode.Name
    end
    return self
end

function Keybind:GetValue()
    return self.value
end

local MultilineTextBox = setmetatable({}, {__index = Component})
MultilineTextBox.__index = MultilineTextBox

function MultilineTextBox.new(parent, theme, style, window, text, placeholder, lines, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), MultilineTextBox)
    self.text = text
    self.placeholder = placeholder or ""
    self.lines = lines or 4
    self.value = ""
    self.callback = callback
    self:Create()
    return self
end

function MultilineTextBox:Create()
    local height = 40 + (self.lines * 20)
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, height)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -24, 0, 20)
    label.Position = UDim2.new(0, 12, 0, 10)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -24, 0, height - 40)
    textBox.Position = UDim2.new(0, 12, 0, 30)
    textBox.BackgroundColor3 = self.theme.colors.bg4
    textBox.BorderSizePixel = 0
    textBox.PlaceholderText = self.placeholder
    textBox.PlaceholderColor3 = self.theme.colors.text3
    textBox.Text = self.value
    textBox.TextColor3 = self.theme.colors.text1
    textBox.TextSize = 12
    textBox.Font = self.style.fontMono
    textBox.ClearTextOnFocus = false
    textBox.MultiLine = true
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.TextYAlignment = Enum.TextYAlignment.Top
    textBox.ZIndex = ZINDEX.Content
    textBox.Parent = container
    self.textBox = textBox
    
    self.theme:Track(textBox, "BackgroundColor3", "bg4")
    self.theme:Track(textBox, "TextColor3", "text1")
    self.theme:Track(textBox, "PlaceholderColor3", "text3")
    
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    textBoxCorner.Parent = textBox
    
    local textBoxPadding = Instance.new("UIPadding")
    textBoxPadding.PaddingLeft = UDim.new(0, 10)
    textBoxPadding.PaddingRight = UDim.new(0, 10)
    textBoxPadding.PaddingTop = UDim.new(0, 8)
    textBoxPadding.PaddingBottom = UDim.new(0, 8)
    textBoxPadding.Parent = textBox
    
    textBox.FocusLost:Connect(function()
        safeCall(function()
            self.value = textBox.Text
            if self.callback then
                self.callback(textBox.Text)
            end
            self.Changed:Fire(textBox.Text)
        end)
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function MultilineTextBox:SetValue(value)
    self.value = value
    if self.textBox then
        self.textBox.Text = value
    end
    return self
end

function MultilineTextBox:GetValue()
    return self.value
end

local Dropdown = setmetatable({}, {__index = Component})
Dropdown.__index = Dropdown

local function safeGetColor(theme, colorName, fallback)
    local success, result = pcall(function()
        if theme and theme.colors and theme.colors[colorName] then
            return theme.colors[colorName]
        end
        return fallback or Color3.new(0.2, 0.2, 0.2)
    end)
    
    if not success then
        warn("[Dropdown] Failed to get color '" .. tostring(colorName) .. "': " .. tostring(result))
        return fallback or Color3.new(0.2, 0.2, 0.2)
    end
    
    return result
end

local function safeTween(instance, tweenInfo, properties, debugContext)
    local success, err = pcall(function()
        if not instance or not instance.Parent then
            return
        end
        
        local validProps = {}
        for prop, value in pairs(properties) do
            if value ~= nil then
                validProps[prop] = value
            else
                warn("[Dropdown] Skipping nil property '" .. tostring(prop) .. "' in " .. tostring(debugContext))
            end
        end
        
        if next(validProps) then
            local tween = TweenService:Create(instance, tweenInfo, validProps)
            tween:Play()
            return tween
        end
    end)
    
    if not success then
        warn("[Dropdown] Tween failed in " .. tostring(debugContext) .. ": " .. tostring(err))
    end
    
    return success
end

function Dropdown.new(parent, theme, style, window, text, options, default, callback)
    local success, result = pcall(function()
        local self = setmetatable(Component.new(parent, theme, style, window), Dropdown)
        self.text = text or "Dropdown"
        self.options = options or {}
        self.value = default or (options and options[1]) or "Select"
        self.callback = callback
        self.isOpen = false
        self.optionButtons = {}
        self.tweens = {}
        self:Create()
        return self
    end)
    
    if not success then
        warn("[Dropdown] Failed to create dropdown: " .. tostring(result))
        return nil
    end
    
    return result
end

function Dropdown:Create()
    safeCall(function()
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight or 40)
        container.BackgroundColor3 = safeGetColor(self.theme, "bg3", Color3.fromRGB(45, 45, 45))
        container.BorderSizePixel = 0
        container.ZIndex = ZINDEX.Content
        container.ClipsDescendants = false
        container.Parent = self.parent
        self.instance = container
        
        pcall(function()
            self.theme:Track(container, "BackgroundColor3", "bg3")
        end)
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, self.style.cornerRadius or 6)
        corner.Parent = container
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.45, -16, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = self.text
        label.TextColor3 = safeGetColor(self.theme, "text1", Color3.fromRGB(255, 255, 255))
        label.TextSize = 13
        label.Font = self.style.fontBody or Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = ZINDEX.Content
        label.Parent = container
        
        pcall(function()
            self.theme:Track(label, "TextColor3", "text1")
        end)
        
        local selected = Instance.new("TextButton")
        selected.Size = UDim2.new(0.55, -12, 0, 30)
        selected.Position = UDim2.new(0.45, 4, 0.5, -15)
        selected.BackgroundColor3 = safeGetColor(self.theme, "bg4", Color3.fromRGB(55, 55, 55))
        selected.BorderSizePixel = 0
        selected.Text = ""
        selected.AutoButtonColor = false
        selected.ZIndex = ZINDEX.Content
        selected.Parent = container
        
        pcall(function()
            self.theme:Track(selected, "BackgroundColor3", "bg4")
        end)
        
        local selectedCorner = Instance.new("UICorner")
        selectedCorner.CornerRadius = UDim.new(0, (self.style.cornerRadius or 6) - 2)
        selectedCorner.Parent = selected
        
        local selectedLabel = Instance.new("TextLabel")
        selectedLabel.Size = UDim2.new(1, -32, 1, 0)
        selectedLabel.Position = UDim2.new(0, 10, 0, 0)
        selectedLabel.BackgroundTransparency = 1
        selectedLabel.Text = self.value
        selectedLabel.TextColor3 = safeGetColor(self.theme, "text1", Color3.fromRGB(255, 255, 255))
        selectedLabel.TextSize = 12
        selectedLabel.Font = self.style.fontBody or Enum.Font.Gotham
        selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
        selectedLabel.TextTruncate = Enum.TextTruncate.AtEnd
        selectedLabel.ZIndex = ZINDEX.Content
        selectedLabel.Parent = selected
        
        pcall(function()
            self.theme:Track(selectedLabel, "TextColor3", "text1")
        end)
        self.selectedLabel = selectedLabel
        
        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 20, 1, 0)
        arrow.Position = UDim2.new(1, -20, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "▼"
        arrow.TextColor3 = safeGetColor(self.theme, "text3", Color3.fromRGB(150, 150, 150))
        arrow.TextSize = 8
        arrow.Font = self.style.fontTitle or Enum.Font.GothamBold
        arrow.ZIndex = ZINDEX.Content
        arrow.Parent = selected
        
        pcall(function()
            self.theme:Track(arrow, "TextColor3", "text3")
        end)
        self.arrow = arrow
        
        local listContainer = Instance.new("Frame")
        listContainer.BackgroundTransparency = 1
        listContainer.Size = UDim2.new(1, 0, 1, 0)
        listContainer.Position = UDim2.new(0, 0, 0, 0)
        listContainer.Visible = false
        listContainer.ZIndex = ZINDEX.Dropdown or 100
        listContainer.ClipsDescendants = false
        listContainer.Parent = self.window.gui
        self.listContainer = listContainer
        
        if self.modalElements then
            table.insert(self.modalElements, listContainer)
        end
        
        local shadow = Instance.new("Frame")
        shadow.Size = UDim2.new(0, 0, 0, 0)
        shadow.BackgroundColor3 = Color3.new(0, 0, 0)
        shadow.BackgroundTransparency = 0.7
        shadow.BorderSizePixel = 0
        shadow.ZIndex = (ZINDEX.Dropdown or 100) - 1
        shadow.Parent = listContainer
        self.shadow = shadow
        
        local shadowCorner = Instance.new("UICorner")
        shadowCorner.CornerRadius = UDim.new(0, (self.style.cornerRadius or 6) - 2)
        shadowCorner.Parent = shadow
        
        local listHeight = math.min(#self.options * 36, 180)
        
        local list = Instance.new("ScrollingFrame")
        list.Size = UDim2.new(0, 0, 0, 0)
        list.AnchorPoint = Vector2.new(0, 0)
        list.BackgroundColor3 = safeGetColor(self.theme, "bg2", Color3.fromRGB(35, 35, 35))
        list.BorderSizePixel = 0
        list.ZIndex = ZINDEX.Dropdown or 100
        list.ScrollBarThickness = 4
        list.ScrollBarImageColor3 = safeGetColor(self.theme, "text3", Color3.fromRGB(150, 150, 150))
        list.CanvasSize = UDim2.new(0, 0, 0, #self.options * 36)
        list.BackgroundTransparency = 1
        list.ClipsDescendants = true
        list.Parent = listContainer
        
        pcall(function()
            self.theme:Track(list, "BackgroundColor3", "bg2")
            self.theme:Track(list, "ScrollBarImageColor3", "text3")
        end)
        
        self.list = list
        self.listHeight = listHeight
        
        local listCorner = Instance.new("UICorner")
        listCorner.CornerRadius = UDim.new(0, (self.style.cornerRadius or 6) - 2)
        listCorner.Parent = list
        
        if (self.style.borderWidth or 0) > 0 then
            local listStroke = Instance.new("UIStroke")
            listStroke.Color = safeGetColor(self.theme, "border", Color3.fromRGB(80, 80, 80))
            listStroke.Thickness = self.style.borderWidth
            listStroke.Transparency = 1
            listStroke.Parent = list
            
            pcall(function()
                self.theme:Track(listStroke, "Color", "border")
            end)
            self.listStroke = listStroke
        end
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 0)
        listLayout.Parent = list
        
        for i, option in ipairs(self.options) do
            pcall(function()
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, 0, 0, 36)
                optBtn.BackgroundColor3 = safeGetColor(self.theme, "bg2", Color3.fromRGB(35, 35, 35))
                optBtn.BorderSizePixel = 0
                optBtn.Text = ""
                optBtn.AutoButtonColor = false
                optBtn.ZIndex = (ZINDEX.Dropdown or 100) + 1
                optBtn.BackgroundTransparency = 1
                optBtn.Parent = list
                
                local indicator = Instance.new("Frame")
                indicator.Size = UDim2.new(0, 3, 1, 0)
                indicator.Position = UDim2.new(0, 0, 0, 0)
                indicator.BackgroundColor3 = safeGetColor(self.theme, "accent", Color3.fromRGB(100, 150, 255))
                indicator.BorderSizePixel = 0
                indicator.ZIndex = (ZINDEX.Dropdown or 100) + 2
                indicator.Visible = option == self.value
                indicator.BackgroundTransparency = option == self.value and 0 or 1
                indicator.Parent = optBtn
                
                pcall(function()
                    self.theme:Track(indicator, "BackgroundColor3", "accent")
                end)
                
                local optLabel = Instance.new("TextLabel")
                optLabel.Size = UDim2.new(1, -20, 1, 0)
                optLabel.Position = UDim2.new(0, 10, 0, 0)
                optLabel.BackgroundTransparency = 1
                optLabel.Text = tostring(option)
                optLabel.TextSize = 12
                optLabel.Font = self.style.fontBody or Enum.Font.Gotham
                optLabel.TextXAlignment = Enum.TextXAlignment.Left
                optLabel.ZIndex = (ZINDEX.Dropdown or 100) + 1
                optLabel.TextTransparency = 1
                optLabel.Parent = optBtn
                
                if option == self.value then
                    optLabel.TextColor3 = safeGetColor(self.theme, "accent", Color3.fromRGB(100, 150, 255))
                    pcall(function()
                        self.theme:Track(optLabel, "TextColor3", "accent")
                    end)
                else
                    optLabel.TextColor3 = safeGetColor(self.theme, "text1", Color3.fromRGB(255, 255, 255))
                    pcall(function()
                        self.theme:Track(optLabel, "TextColor3", "text1")
                    end)
                end
                
                self.optionButtons[i] = {
                    button = optBtn,
                    label = optLabel,
                    indicator = indicator,
                    option = option
                }
                
                local function selectOption()
                    safeCall(function()
                        self.value = option
                        selectedLabel.Text = tostring(option)
                        
                        for _, opt in ipairs(self.optionButtons) do
                            pcall(function()
                                opt.indicator.Visible = opt.option == option
                                opt.indicator.BackgroundTransparency = opt.option == option and 0 or 1
                                
                                if opt.option == option then
                                    opt.label.TextColor3 = safeGetColor(self.theme, "accent", Color3.fromRGB(100, 150, 255))
                                    pcall(function()
                                        self.theme:Track(opt.label, "TextColor3", "accent")
                                    end)
                                else
                                    opt.label.TextColor3 = safeGetColor(self.theme, "text1", Color3.fromRGB(255, 255, 255))
                                    pcall(function()
                                        self.theme:Track(opt.label, "TextColor3", "text1")
                                    end)
                                end
                            end)
                        end
                        
                        self:CloseDropdown()
                        
                        if self.callback then
                            pcall(function()
                                self.callback(option)
                            end)
                        end
                        
                        if self.Changed then
                            pcall(function()
                                self.Changed:Fire(option)
                            end)
                        end
                    end)
                end
                
                optBtn.MouseButton1Click:Connect(selectOption)
                
                if isMobile and isMobile() then
                    optBtn.TouchTap:Connect(selectOption)
                end
                
                optBtn.MouseEnter:Connect(function()
                    safeCall(function()
                        safeTween(optBtn, 
                            TweenInfo.new((self.style.animationSpeed or 0.15) * 0.5), 
                            {
                                BackgroundTransparency = 0,
                                BackgroundColor3 = safeGetColor(self.theme, "bg3", Color3.fromRGB(45, 45, 45))
                            },
                            "Option hover enter"
                        )
                    end)
                end)
                
                optBtn.MouseLeave:Connect(function()
                    safeCall(function()
                        safeTween(optBtn,
                            TweenInfo.new((self.style.animationSpeed or 0.15) * 0.5),
                            {BackgroundTransparency = 1},
                            "Option hover leave"
                        )
                    end)
                end)
            end)
        end
        
        local function updateListPosition()
            safeCall(function()
                if not selected or not selected.Parent then return end
                
                local absPos = selected.AbsolutePosition
                local absSize = selected.AbsoluteSize
                
                list.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 6)
                shadow.Position = UDim2.new(0, absPos.X - 4, 0, absPos.Y + absSize.Y + 2)
            end)
        end
        
        local function toggleDropdown()
            safeCall(function()
                if self.isOpen then
                    self:CloseDropdown()
                else
                    self:OpenDropdown()
                end
            end)
        end
        
        selected.MouseButton1Click:Connect(toggleDropdown)
        
        if isMobile and isMobile() then
            selected.TouchTap:Connect(toggleDropdown)
        end
        
        selected.MouseEnter:Connect(function()
            safeCall(function()
                safeTween(selected,
                    TweenInfo.new(self.style.animationSpeed or 0.15),
                    {BackgroundColor3 = safeGetColor(self.theme, "bg5", Color3.fromRGB(65, 65, 65))},
                    "Selected button hover"
                )
            end)
        end)
        
        selected.MouseLeave:Connect(function()
            safeCall(function()
                if not self.isOpen then
                    safeTween(selected,
                        TweenInfo.new(self.style.animationSpeed or 0.15),
                        {BackgroundColor3 = safeGetColor(self.theme, "bg4", Color3.fromRGB(55, 55, 55))},
                        "Selected button leave"
                    )
                end
            end)
        end)
        
        container.MouseEnter:Connect(function()
            safeCall(function()
                safeTween(container,
                    TweenInfo.new(self.style.animationSpeed or 0.15),
                    {BackgroundColor3 = safeGetColor(self.theme, "bg4", Color3.fromRGB(55, 55, 55))},
                    "Container hover"
                )
            end)
        end)
        
        container.MouseLeave:Connect(function()
            safeCall(function()
                safeTween(container,
                    TweenInfo.new(self.style.animationSpeed or 0.15),
                    {BackgroundColor3 = safeGetColor(self.theme, "bg3", Color3.fromRGB(45, 45, 45))},
                    "Container leave"
                )
            end)
        end)
        
        self.updateListPosition = updateListPosition
        self.selected = selected
        
        pcall(function()
            UserInputService.InputBegan:Connect(function(input)
                safeCall(function()
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if not self.isOpen then return end
                        if not list or not list.Parent then return end
                        if not selected or not selected.Parent then return end
                        
                        local mousePos = UserInputService:GetMouseLocation()
                        local listPos = list.AbsolutePosition
                        local listSize = list.AbsoluteSize
                        
                        local isInList = mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and 
                                        mousePos.Y >= listPos.Y and mousePos.Y <= listPos.Y + listSize.Y
                        
                        local selectedPos = selected.AbsolutePosition
                        local selectedSize = selected.AbsoluteSize
                        
                        local isInSelected = mousePos.X >= selectedPos.X and mousePos.X <= selectedPos.X + selectedSize.X and
                                            mousePos.Y >= selectedPos.Y and mousePos.Y <= selectedPos.Y + selectedSize.Y
                        
                        if not isInList and not isInSelected then
                            self:CloseDropdown()
                        end
                    end
                end)
            end)
        end)
    end)
end

function Dropdown:OpenDropdown()
    safeCall(function()
        if not self.list or not self.list.Parent then 
            warn("[Dropdown] Cannot open - list not found")
            return 
        end
        
        self.isOpen = true
        self.updateListPosition()
        self.listContainer.Visible = true
        
        local absSize = self.selected and self.selected.AbsoluteSize or Vector2.new(200, 30)
        
        self.list.Size = UDim2.new(0, absSize.X, 0, 0)
        self.list.BackgroundTransparency = 1
        
        if self.listStroke then
            self.listStroke.Transparency = 1
        end
        
        if self.shadow then
            self.shadow.Size = UDim2.new(0, absSize.X + 8, 0, 0)
            self.shadow.BackgroundTransparency = 1
        end
        
        for _, opt in ipairs(self.optionButtons) do
            pcall(function()
                opt.button.BackgroundTransparency = 1
                opt.label.TextTransparency = 1
                opt.indicator.BackgroundTransparency = 1
            end)
        end
        
        safeTween(self.list,
            TweenInfo.new((self.style.animationSpeed or 0.15) * 1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, absSize.X, 0, self.listHeight),
                BackgroundTransparency = 0
            },
            "List expand"
        )
        
        if self.shadow then
            safeTween(self.shadow,
                TweenInfo.new((self.style.animationSpeed or 0.15) * 1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {
                    BackgroundTransparency = 0.85,
                    Size = UDim2.new(0, absSize.X + 8, 0, self.listHeight + 8)
                },
                "Shadow expand"
            )
        end
        
        if self.listStroke then
            safeTween(self.listStroke,
                TweenInfo.new((self.style.animationSpeed or 0.15) * 1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Transparency = 0.3},
                "Border fade in"
            )
        end
        
        task.spawn(function()
            for i, opt in ipairs(self.optionButtons) do
                local delay = (self.style.animationSpeed or 0.15) * 0.3 + (i - 1) * 0.02
                task.wait(delay)
                
                pcall(function()
                    if not opt or not opt.label or not opt.label.Parent then return end
                    
                    safeTween(opt.label,
                        TweenInfo.new((self.style.animationSpeed or 0.15) * 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextTransparency = 0},
                        "Option label fade " .. i
                    )
                    
                    if opt.indicator and opt.indicator.Visible then
                        safeTween(opt.indicator,
                            TweenInfo.new((self.style.animationSpeed or 0.15) * 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0},
                            "Option indicator fade " .. i
                        )
                    end
                end)
            end
        end)
        
        if self.arrow then
            safeTween(self.arrow,
                TweenInfo.new((self.style.animationSpeed or 0.15) * 1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Rotation = 180},
                "Arrow rotate open"
            )
        end
        
        if self.selected then
            safeTween(self.selected,
                TweenInfo.new(self.style.animationSpeed or 0.15),
                {BackgroundColor3 = safeGetColor(self.theme, "bg5", Color3.fromRGB(65, 65, 65))},
                "Selected button highlight"
            )
        end
    end)
end

function Dropdown:CloseDropdown()
    safeCall(function()
        if not self.list or not self.list.Parent then 
            return 
        end
        
        self.isOpen = false
        
        local absSize = self.selected and self.selected.AbsoluteSize or Vector2.new(200, 30)
        
        for i, opt in ipairs(self.optionButtons) do
            pcall(function()
                if not opt or not opt.label or not opt.label.Parent then return end
                
                safeTween(opt.label,
                    TweenInfo.new((self.style.animationSpeed or 0.15) * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                    {TextTransparency = 1},
                    "Option label hide " .. i
                )
                
                if opt.indicator then
                    safeTween(opt.indicator,
                        TweenInfo.new((self.style.animationSpeed or 0.15) * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                        {BackgroundTransparency = 1},
                        "Option indicator hide " .. i
                    )
                end
            end)
        end
        
        local collapseTween = safeTween(self.list,
            TweenInfo.new((self.style.animationSpeed or 0.15) * 1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {
                Size = UDim2.new(0, absSize.X, 0, 0),
                BackgroundTransparency = 1
            },
            "List collapse"
        )
        
        task.delay((self.style.animationSpeed or 0.15) * 1.2, function()
            safeCall(function()
                if self.listContainer and self.listContainer.Parent then
                    self.listContainer.Visible = false
                end
            end)
        end)
        
        if self.shadow then
            safeTween(self.shadow,
                TweenInfo.new((self.style.animationSpeed or 0.15) * 1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, absSize.X + 8, 0, 0)
                },
                "Shadow collapse"
            )
        end
        
        if self.listStroke then
            safeTween(self.listStroke,
                TweenInfo.new((self.style.animationSpeed or 0.15) * 1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                {Transparency = 1},
                "Border fade out"
            )
        end
        
        if self.arrow then
            safeTween(self.arrow,
                TweenInfo.new((self.style.animationSpeed or 0.15) * 1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                {Rotation = 0},
                "Arrow rotate close"
            )
        end
        
        if self.selected then
            safeTween(self.selected,
                TweenInfo.new(self.style.animationSpeed or 0.15),
                {BackgroundColor3 = safeGetColor(self.theme, "bg4", Color3.fromRGB(55, 55, 55))},
                "Selected button restore"
            )
        end
    end)
end

function Dropdown:SetValue(value)
    safeCall(function()
        for _, option in ipairs(self.options) do
            if option == value then
                self.value = value
                
                if self.selectedLabel and self.selectedLabel.Parent then
                    self.selectedLabel.Text = tostring(value)
                end
                
                for _, opt in ipairs(self.optionButtons) do
                    pcall(function()
                        if not opt or not opt.indicator then return end
                        
                        opt.indicator.Visible = opt.option == value
                        opt.indicator.BackgroundTransparency = opt.option == value and 0 or 1
                        
                        if opt.label and opt.label.Parent then
                            if opt.option == value then
                                opt.label.TextColor3 = safeGetColor(self.theme, "accent", Color3.fromRGB(100, 150, 255))
                                pcall(function()
                                    self.theme:Track(opt.label, "TextColor3", "accent")
                                end)
                            else
                                opt.label.TextColor3 = safeGetColor(self.theme, "text1", Color3.fromRGB(255, 255, 255))
                                pcall(function()
                                    self.theme:Track(opt.label, "TextColor3", "text1")
                                end)
                            end
                        end
                    end)
                end
                
                return self
            end
        end
    end)
    return self
end

function Dropdown:GetValue()
    return self.value
end

function Dropdown:SetOptions(options)
    self.options = options or {}
    return self
end

function Dropdown:GetOptions()
    return self.options
end

function Dropdown:Destroy()
    safeCall(function()
        if self.tweens then
            for _, tween in ipairs(self.tweens) do
                pcall(function()
                    tween:Cancel()
                end)
            end
        end
        
        if self.listContainer then
            pcall(function()
                self.listContainer:Destroy()
            end)
        end
        
        if self.instance then
            pcall(function()
                self.instance:Destroy()
            end)
        end
        
        if Component.Destroy then
            pcall(function()
                Component.Destroy(self)
            end)
        end
    end)
end

local ColorPicker = setmetatable({}, {__index = Component})
ColorPicker.__index = ColorPicker

function ColorPicker.new(parent, theme, style, window, text, default, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), ColorPicker)
    self.text = text
    self.value = default or Color3.fromRGB(255, 255, 255)
    self.callback = callback
    self.h, self.s, self.v = self.value:ToHSV()
    self.isOpen = false
    self.draggingHue = false
    self.draggingSV = false
    self:Create()
    return self
end

function ColorPicker:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.ClipsDescendants = false
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, -16, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local colorPreview = Instance.new("TextButton")
    colorPreview.Size = UDim2.new(0, 80, 0, 28)
    colorPreview.Position = UDim2.new(1, -92, 0.5, -14)
    colorPreview.BackgroundColor3 = self.value
    colorPreview.BorderSizePixel = 0
    colorPreview.Text = ""
    colorPreview.AutoButtonColor = false
    colorPreview.ZIndex = ZINDEX.Content
    colorPreview.Parent = container
    self.colorPreview = colorPreview
    
    local previewCorner = Instance.new("UICorner")
    previewCorner.CornerRadius = UDim.new(0, 6)
    previewCorner.Parent = colorPreview
    
    local previewStroke = Instance.new("UIStroke")
    previewStroke.Color = self.theme.colors.border
    previewStroke.Thickness = 1
    previewStroke.Parent = colorPreview
    
    self.theme:Track(previewStroke, "Color", "border")
    self.previewStroke = previewStroke
    
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Size = UDim2.new(0, 0, 0, 0)
    pickerFrame.BackgroundColor3 = self.theme.colors.bg2
    pickerFrame.BorderSizePixel = 0
    pickerFrame.Visible = false
    pickerFrame.ZIndex = ZINDEX.ColorPicker
    pickerFrame.BackgroundTransparency = 1
    pickerFrame.ClipsDescendants = true
    pickerFrame.Parent = self.window.gui
    
    self.theme:Track(pickerFrame, "BackgroundColor3", "bg2")
    self.pickerFrame = pickerFrame
    table.insert(self.modalElements, pickerFrame)
    
    local pickerCorner = Instance.new("UICorner")
    pickerCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    pickerCorner.Parent = pickerFrame
    
    local pickerStroke = Instance.new("UIStroke")
    pickerStroke.Color = self.theme.colors.border
    pickerStroke.Thickness = 1
    pickerStroke.Parent = pickerFrame
    
    self.theme:Track(pickerStroke, "Color", "border")
    
    local satValPicker = Instance.new("ImageButton")
    satValPicker.Size = UDim2.new(1, -32, 1, -120)
    satValPicker.Position = UDim2.new(0, 16, 0, 16)
    satValPicker.BackgroundColor3 = Color3.fromHSV(self.h, 1, 1)
    satValPicker.BorderSizePixel = 0
    satValPicker.AutoButtonColor = false
    satValPicker.ZIndex = ZINDEX.ColorPicker + 1
    satValPicker.Parent = pickerFrame
    self.satValPicker = satValPicker
    
    local svCorner = Instance.new("UICorner")
    svCorner.CornerRadius = UDim.new(0, 6)
    svCorner.Parent = satValPicker
    
    local whiteMask = Instance.new("Frame")
    whiteMask.Size = UDim2.new(1, 0, 1, 0)
    whiteMask.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    whiteMask.BorderSizePixel = 0
    whiteMask.ZIndex = ZINDEX.ColorPicker + 2
    whiteMask.Parent = satValPicker
    
    local whiteCorner = Instance.new("UICorner")
    whiteCorner.CornerRadius = UDim.new(0, 6)
    whiteCorner.Parent = whiteMask
    
    local whiteGradient = Instance.new("UIGradient")
    whiteGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    whiteGradient.Parent = whiteMask
    
    local blackMask = Instance.new("Frame")
    blackMask.Size = UDim2.new(1, 0, 1, 0)
    blackMask.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackMask.BorderSizePixel = 0
    blackMask.ZIndex = ZINDEX.ColorPicker + 3
    blackMask.Parent = satValPicker
    
    local blackCorner = Instance.new("UICorner")
    blackCorner.CornerRadius = UDim.new(0, 6)
    blackCorner.Parent = blackMask
    
    local blackGradient = Instance.new("UIGradient")
    blackGradient.Rotation = 90
    blackGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    blackGradient.Parent = blackMask
    
    local svCursor = Instance.new("Frame")
    svCursor.Size = UDim2.new(0, 12, 0, 12)
    svCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    svCursor.Position = UDim2.new(self.s, 0, 1 - self.v, 0)
    svCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    svCursor.BorderSizePixel = 0
    svCursor.ZIndex = ZINDEX.ColorPicker + 4
    svCursor.Parent = satValPicker
    
    local svCursorCorner = Instance.new("UICorner")
    svCursorCorner.CornerRadius = UDim.new(1, 0)
    svCursorCorner.Parent = svCursor
    
    local svCursorStroke = Instance.new("UIStroke")
    svCursorStroke.Color = Color3.fromRGB(0, 0, 0)
    svCursorStroke.Thickness = 2
    svCursorStroke.Parent = svCursor
    
    self.svCursor = svCursor
    
    local hueSlider = Instance.new("Frame")
    hueSlider.Size = UDim2.new(1, -32, 0, 24)
    hueSlider.Position = UDim2.new(0, 16, 1, -88)
    hueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueSlider.BorderSizePixel = 0
    hueSlider.ZIndex = ZINDEX.ColorPicker + 1
    hueSlider.Parent = pickerFrame
    self.hueSlider = hueSlider
    
    local hueCorner = Instance.new("UICorner")
    hueCorner.CornerRadius = UDim.new(0, 6)
    hueCorner.Parent = hueSlider
    
    local hueGradient = Instance.new("UIGradient")
    hueGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }
    hueGradient.Parent = hueSlider
    
    local hueCursor = Instance.new("Frame")
    hueCursor.Size = UDim2.new(0, 4, 1, 4)
    hueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    hueCursor.Position = UDim2.new(self.h, 0, 0.5, 0)
    hueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hueCursor.BorderSizePixel = 0
    hueCursor.ZIndex = ZINDEX.ColorPicker + 2
    hueCursor.Parent = hueSlider
    
    local hueCursorCorner = Instance.new("UICorner")
    hueCursorCorner.CornerRadius = UDim.new(0, 2)
    hueCursorCorner.Parent = hueCursor
    
    local hueCursorStroke = Instance.new("UIStroke")
    hueCursorStroke.Color = Color3.fromRGB(0, 0, 0)
    hueCursorStroke.Thickness = 1
    hueCursorStroke.Parent = hueCursor
    
    self.hueCursor = hueCursor
    
    local inputContainer = Instance.new("Frame")
    inputContainer.Size = UDim2.new(1, -32, 0, 40)
    inputContainer.Position = UDim2.new(0, 16, 1, -56)
    inputContainer.BackgroundTransparency = 1
    inputContainer.ZIndex = ZINDEX.ColorPicker + 1
    inputContainer.Parent = pickerFrame
    
    local hexLabel = Instance.new("TextLabel")
    hexLabel.Size = UDim2.new(0, 30, 0, 16)
    hexLabel.Position = UDim2.new(0, 0, 0, 0)
    hexLabel.BackgroundTransparency = 1
    hexLabel.Text = "HEX"
    hexLabel.TextColor3 = self.theme.colors.text2
    hexLabel.TextSize = 10
    hexLabel.Font = self.style.fontBody
    hexLabel.TextXAlignment = Enum.TextXAlignment.Left
    hexLabel.ZIndex = ZINDEX.ColorPicker + 1
    hexLabel.Parent = inputContainer
    
    self.theme:Track(hexLabel, "TextColor3", "text2")
    
    local hexInput = Instance.new("TextBox")
    hexInput.Size = UDim2.new(0, 90, 0, 24)
    hexInput.Position = UDim2.new(0, 0, 0, 16)
    hexInput.BackgroundColor3 = self.theme.colors.bg3
    hexInput.BorderSizePixel = 0
    hexInput.Text = self:ColorToHex(self.value)
    hexInput.TextColor3 = self.theme.colors.text1
    hexInput.TextSize = 11
    hexInput.Font = self.style.fontBody
    hexInput.ClearTextOnFocus = false
    hexInput.ZIndex = ZINDEX.ColorPicker + 1
    hexInput.Parent = inputContainer
    
    self.theme:Track(hexInput, "BackgroundColor3", "bg3")
    self.theme:Track(hexInput, "TextColor3", "text1")
    self.hexInput = hexInput
    
    local hexCorner = Instance.new("UICorner")
    hexCorner.CornerRadius = UDim.new(0, 4)
    hexCorner.Parent = hexInput
    
    local rgbContainer = Instance.new("Frame")
    rgbContainer.Size = UDim2.new(1, -100, 0, 40)
    rgbContainer.Position = UDim2.new(0, 100, 0, 0)
    rgbContainer.BackgroundTransparency = 1
    rgbContainer.ZIndex = ZINDEX.ColorPicker + 1
    rgbContainer.Parent = inputContainer
    
    local function createRGBInput(text, position, getValue, setValue)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 15, 0, 16)
        label.Position = UDim2.new(position, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = self.theme.colors.text2
        label.TextSize = 10
        label.Font = self.style.fontBody
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = ZINDEX.ColorPicker + 1
        label.Parent = rgbContainer
        
        self.theme:Track(label, "TextColor3", "text2")
        
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0, 40, 0, 24)
        input.Position = UDim2.new(position, 0, 0, 16)
        input.BackgroundColor3 = self.theme.colors.bg3
        input.BorderSizePixel = 0
        input.Text = tostring(getValue())
        input.TextColor3 = self.theme.colors.text1
        input.TextSize = 11
        input.Font = self.style.fontBody
        input.ClearTextOnFocus = false
        input.ZIndex = ZINDEX.ColorPicker + 1
        input.Parent = rgbContainer
        
        self.theme:Track(input, "BackgroundColor3", "bg3")
        self.theme:Track(input, "TextColor3", "text1")
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 4)
        inputCorner.Parent = input
        
        input.FocusLost:Connect(function()
            local value = tonumber(input.Text)
            if value then
                setValue(math.clamp(value, 0, 255))
            else
                input.Text = tostring(getValue())
            end
        end)
        
        return input
    end
    
    local r, g, b = math.floor(self.value.R * 255), math.floor(self.value.G * 255), math.floor(self.value.B * 255)
    
    self.rInput = createRGBInput("R", 0, function() return math.floor(self.value.R * 255) end, function(val)
        local _, gVal, bVal = math.floor(self.value.G * 255), math.floor(self.value.B * 255)
        self:SetValue(Color3.fromRGB(val, gVal, bVal))
    end)
    
    self.gInput = createRGBInput("G", 0.33, function() return math.floor(self.value.G * 255) end, function(val)
        local rVal, _, bVal = math.floor(self.value.R * 255), math.floor(self.value.B * 255)
        self:SetValue(Color3.fromRGB(rVal, val, bVal))
    end)
    
    self.bInput = createRGBInput("B", 0.66, function() return math.floor(self.value.B * 255) end, function(val)
        local rVal, gVal = math.floor(self.value.R * 255), math.floor(self.value.G * 255)
        self:SetValue(Color3.fromRGB(rVal, gVal, val))
    end)
    
    hexInput.FocusLost:Connect(function()
        local color = self:HexToColor(hexInput.Text)
        if color then
            self:SetValue(color)
        else
            hexInput.Text = self:ColorToHex(self.value)
        end
    end)
    
    local function updateColor(skipCallback)
        safeCall(function()
            local newColor = Color3.fromHSV(self.h, self.s, self.v)
            self.value = newColor
            colorPreview.BackgroundColor3 = newColor
            satValPicker.BackgroundColor3 = Color3.fromHSV(self.h, 1, 1)
            
            self.hexInput.Text = self:ColorToHex(newColor)
            self.rInput.Text = tostring(math.floor(newColor.R * 255))
            self.gInput.Text = tostring(math.floor(newColor.G * 255))
            self.bInput.Text = tostring(math.floor(newColor.B * 255))
            
            if not skipCallback and self.callback then
                self.callback(newColor)
            end
            self.Changed:Fire(newColor)
        end)
    end
    
    self.updateColor = updateColor
    
    local function updateHue(input)
        safeCall(function()
            local pos = math.clamp((input.Position.X - hueSlider.AbsolutePosition.X) / hueSlider.AbsoluteSize.X, 0, 1)
            self.h = pos
            hueCursor.Position = UDim2.new(pos, 0, 0.5, 0)
            updateColor()
        end)
    end
    
    local function updateSV(input)
        safeCall(function()
            local posX = math.clamp((input.Position.X - satValPicker.AbsolutePosition.X) / satValPicker.AbsoluteSize.X, 0, 1)
            local posY = math.clamp((input.Position.Y - satValPicker.AbsolutePosition.Y) / satValPicker.AbsoluteSize.Y, 0, 1)
            self.s = posX
            self.v = 1 - posY
            svCursor.Position = UDim2.new(posX, 0, posY, 0)
            updateColor()
        end)
    end
    
    satValPicker.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.draggingSV = true
            updateSV(input)
        end
    end)
    
    hueSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.draggingHue = true
            updateHue(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if self.draggingSV then
                updateSV(input)
            elseif self.draggingHue then
                updateHue(input)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.draggingSV = false
            self.draggingHue = false
        end
    end)
    
    local function updatePickerPosition()
        safeCall(function()
            local absPos = colorPreview.AbsolutePosition
            local absSize = colorPreview.AbsoluteSize
            pickerFrame.Position = UDim2.new(0, absPos.X + absSize.X - 280, 0, absPos.Y + absSize.Y + 4)
        end)
    end
    
    self.updatePickerPosition = updatePickerPosition
    
    colorPreview.MouseButton1Click:Connect(function()
        safeCall(function()
            if self.isOpen then
                self:ClosePicker()
            else
                self:OpenPicker()
            end
        end)
    end)
    
    if isMobile() then
        colorPreview.TouchTap:Connect(function()
            if self.isOpen then
                self:ClosePicker()
            else
                self:OpenPicker()
            end
        end)
    end
    
    colorPreview.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(previewStroke, TweenInfo.new(self.style.animationSpeed), {Color = self.theme.colors.primary}):Play()
        end)
    end)
    
    colorPreview.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(previewStroke, TweenInfo.new(self.style.animationSpeed), {Color = self.theme.colors.border}):Play()
        end)
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if not self.isOpen then return end
            
            local mousePos = UserInputService:GetMouseLocation()
            local pickerPos = pickerFrame.AbsolutePosition
            local pickerSize = pickerFrame.AbsoluteSize
            
            local isInPicker = mousePos.X >= pickerPos.X and mousePos.X <= pickerPos.X + pickerSize.X and 
                              mousePos.Y >= pickerPos.Y and mousePos.Y <= pickerPos.Y + pickerSize.Y
            
            local previewPos = colorPreview.AbsolutePosition
            local previewSize = colorPreview.AbsoluteSize
            
            local isInPreview = mousePos.X >= previewPos.X and mousePos.X <= previewPos.X + previewSize.X and
                               mousePos.Y >= previewPos.Y and mousePos.Y <= previewPos.Y + previewSize.Y
            
            if not isInPicker and not isInPreview then
                self:ClosePicker()
            end
        end
    end)
end

function ColorPicker:OpenPicker()
    safeCall(function()
        self.isOpen = true
        self.updatePickerPosition()
        self.pickerFrame.Visible = true
        
        TweenService:Create(self.pickerFrame, TweenInfo.new(self.style.animationSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 280, 0, 280),
            BackgroundTransparency = 0
        }):Play()
    end)
end

function ColorPicker:ClosePicker()
    safeCall(function()
        self.isOpen = false
        
        local tween = TweenService:Create(self.pickerFrame, TweenInfo.new(self.style.animationSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 280, 0, 0),
            BackgroundTransparency = 1
        })
        
        tween.Completed:Connect(function()
            self.pickerFrame.Visible = false
        end)
        
        tween:Play()
    end)
end

function ColorPicker:ColorToHex(color)
    return string.format("#%02X%02X%02X", 
        math.floor(color.R * 255),
        math.floor(color.G * 255),
        math.floor(color.B * 255)
    )
end

function ColorPicker:HexToColor(hex)
    hex = hex:gsub("#", "")
    if #hex == 6 then
        local r = tonumber(hex:sub(1, 2), 16)
        local g = tonumber(hex:sub(3, 4), 16)
        local b = tonumber(hex:sub(5, 6), 16)
        if r and g and b then
            return Color3.fromRGB(r, g, b)
        end
    end
    return nil
end

function ColorPicker:SetValue(color)
    self.value = color
    self.h, self.s, self.v = color:ToHSV()
    safeCall(function()
        self.colorPreview.BackgroundColor3 = color
        self.satValPicker.BackgroundColor3 = Color3.fromHSV(self.h, 1, 1)
        self.svCursor.Position = UDim2.new(self.s, 0, 1 - self.v, 0)
        self.hueCursor.Position = UDim2.new(self.h, 0, 0.5, 0)
        self.hexInput.Text = self:ColorToHex(color)
        self.rInput.Text = tostring(math.floor(color.R * 255))
        self.gInput.Text = tostring(math.floor(color.G * 255))
        self.bInput.Text = tostring(math.floor(color.B * 255))
    end)
    return self
end

function ColorPicker:GetValue()
    return self.value
end

local TextBox = setmetatable({}, {__index = Component})
TextBox.__index = TextBox

function TextBox.new(parent, theme, style, window, text, placeholder, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), TextBox)
    self.text = text
    self.placeholder = placeholder or ""
    self.value = ""
    self.callback = callback
    self:Create()
    return self
end

function TextBox:Create()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, self.style.buttonHeight)
    container.BackgroundColor3 = self.theme.colors.bg3
    container.BorderSizePixel = 0
    container.ZIndex = ZINDEX.Content
    container.Parent = self.parent
    self.instance = container
    
    self.theme:Track(container, "BackgroundColor3", "bg3")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.3, -16, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.text
    label.TextColor3 = self.theme.colors.text1
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = ZINDEX.Content
    label.Parent = container
    
    self.theme:Track(label, "TextColor3", "text1")
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.7, -24, 0, 30)
    textBox.Position = UDim2.new(0.3, 8, 0.5, -15)
    textBox.BackgroundColor3 = self.theme.colors.bg4
    textBox.BorderSizePixel = 0
    textBox.PlaceholderText = self.placeholder
    textBox.PlaceholderColor3 = self.theme.colors.text3
    textBox.Text = self.value
    textBox.TextColor3 = self.theme.colors.text1
    textBox.TextSize = 12
    textBox.Font = self.style.fontMono
    textBox.ClearTextOnFocus = false
    textBox.MultiLine = false
    textBox.ZIndex = ZINDEX.Content
    textBox.Parent = container
    
    self.theme:Track(textBox, "BackgroundColor3", "bg4")
    self.theme:Track(textBox, "TextColor3", "text1")
    self.theme:Track(textBox, "PlaceholderColor3", "text3")
    self.textBox = textBox
    
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    textBoxCorner.Parent = textBox
    
    local textBoxPadding = Instance.new("UIPadding")
    textBoxPadding.PaddingLeft = UDim.new(0, 10)
    textBoxPadding.PaddingRight = UDim.new(0, 10)
    textBoxPadding.Parent = textBox
    
    textBox.FocusLost:Connect(function(enterPressed)
        safeCall(function()
            self.value = textBox.Text
            if self.callback then
                self.callback(textBox.Text)
            end
            self.Changed:Fire(textBox.Text)
        end)
    end)
    
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        safeCall(function()
            self.value = textBox.Text
        end)
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function TextBox:SetValue(value)
    self.value = value
    safeCall(function()
        self.textBox.Text = value
    end)
    return self
end

function TextBox:GetValue()
    return self.value
end

function TextBox:SetPlaceholder(placeholder)
    self.placeholder = placeholder
    if self.textBox then
        self.textBox.PlaceholderText = placeholder
    end
    return self
end

local Section = {}
Section.__index = Section

function Section.new(parent, theme, style, window, title)
    local self = setmetatable({}, Section)
    self.parent = parent
    self.theme = theme
    self.style = style
    self.window = window
    self.title = title
    self.components = {}
    self:Create()
    return self
end

function Section:Create()
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 0)
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.BackgroundTransparency = 1
    section.ZIndex = ZINDEX.Content
    section.Parent = self.parent
    self.instance = section
    
    if self.title and self.title ~= "" then
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0, 24)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = self.title
        titleLabel.TextColor3 = self.theme.colors.text1
        titleLabel.TextSize = 15
        titleLabel.Font = self.style.fontTitle
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.ZIndex = ZINDEX.Content
        titleLabel.Parent = section
        
        self.theme:Track(titleLabel, "TextColor3", "text1")
    end
    
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 0, 0)
    content.Position = self.title and self.title ~= "" and UDim2.new(0, 0, 0, 32) or UDim2.new(0, 0, 0, 0)
    content.AutomaticSize = Enum.AutomaticSize.Y
    content.BackgroundColor3 = self.theme.colors.bg2
    content.BorderSizePixel = 0
    content.ZIndex = ZINDEX.Content
    content.Parent = section
    
    self.theme:Track(content, "BackgroundColor3", "bg2")
    self.content = content
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    contentCorner.Parent = content
    
    if self.style.borderWidth > 0 then
        local contentStroke = Instance.new("UIStroke")
        contentStroke.Color = self.theme.colors.border
        contentStroke.Thickness = self.style.borderWidth
        contentStroke.Transparency = 0.5
        contentStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        contentStroke.Parent = content
        
        self.theme:Track(contentStroke, "Color", "border")
    end
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingLeft = UDim.new(0, self.style.padding)
    contentPadding.PaddingRight = UDim.new(0, self.style.padding)
    contentPadding.PaddingTop = UDim.new(0, self.style.padding)
    contentPadding.PaddingBottom = UDim.new(0, self.style.padding)
    contentPadding.Parent = content
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, self.style.spacing - 2)
    contentLayout.Parent = content
end

function Section:AddBadge(text, count, color)
    local badge = Badge.new(self.content, self.theme, self.style, self.window, text, count, color)
    table.insert(self.components, badge)
    return badge
end

function Section:AddCard(title, description)
    local card = Card.new(self.content, self.theme, self.style, self.window, title, description)
    table.insert(self.components, card)
    return card
end

function Section:AddImage(imageId, size)
    local image = Image.new(self.content, self.theme, self.style, self.window, imageId, size)
    table.insert(self.components, image)
    return image
end

function Section:AddStatsDisplay(columns)
    local stats = StatsDisplay.new(self.content, self.theme, self.style, self.window, columns)
    table.insert(self.components, stats)
    return stats
end

function Section:AddConsole(height, maxLines)
    local console = Console.new(self.content, self.theme, self.style, self.window, height, maxLines)
    table.insert(self.components, console)
    return console
end

function Section:AddTable(columns)
    local table = Table.new(self.content, self.theme, self.style, self.window, columns)
    table.insert(self.components, table)
    return table
end

function Section:AddRadioGroup(title, options, default, callback)
    local radioGroup = RadioGroup.new(self.content, self.theme, self.style, self.window, title, options, default, callback)
    table.insert(self.components, radioGroup)
    return radioGroup
end

function Section:AddSearchBox(placeholder, callback)
    local searchBox = SearchBox.new(self.content, self.theme, self.style, self.window, placeholder, callback)
    table.insert(self.components, searchBox)
    return searchBox
end

function Section:AddFileSelector(title, extension, callback)
    local fileSelector = FileSelector.new(self.content, self.theme, self.style, self.window, title, extension, callback)
    table.insert(self.components, fileSelector)
    return fileSelector
end

function Section:AddDatePicker(text, callback)
    local datePicker = DatePicker.new(self.content, self.theme, self.style, self.window, text, callback)
    table.insert(self.components, datePicker)
    return datePicker
end

function Section:AddRangeSlider(text, min, max, defaultMin, defaultMax, increment, callback)
    local rangeSlider = RangeSlider.new(self.content, self.theme, self.style, self.window, text, min, max, defaultMin, defaultMax, increment, callback)
    table.insert(self.components, rangeSlider)
    return rangeSlider
end

function Section:AddAccordion(title, expanded)
    local accordion = Accordion.new(self.content, self.theme, self.style, self.window, title, expanded)
    table.insert(self.components, accordion)
    return accordion
end

function Section:AddHorizontalLayout(spacing)
    local horizontalLayout = HorizontalLayout.new(self.content, self.theme, self.style, self.window, spacing)
    table.insert(self.components, horizontalLayout)
    return horizontalLayout
end

function Section:AddSpacer(height)
    local spacer = Spacer.new(self.content, self.theme, self.style, self.window, height)
    table.insert(self.components, spacer)
    return spacer
end

function Section:AddGridContainer(columns, cellSize)
    local gridContainer = GridContainer.new(self.content, self.theme, self.style, self.window, columns, cellSize)
    table.insert(self.components, gridContainer)
    return gridContainer
end

function Section:AddScrollContainer(height)
    local scrollContainer = ScrollContainer.new(self.content, self.theme, self.style, self.window, height)
    table.insert(self.components, scrollContainer)
    return scrollContainer
end

function Section:AddLoadingSpinner(text, size)
    local spinner = LoadingSpinner.new(self.content, self.theme, self.style, self.window, text, size)
    table.insert(self.components, spinner)
    return spinner
end

function Section:AddStepper(steps)
    local stepper = Stepper.new(self.content, self.theme, self.style, self.window, steps)
    table.insert(self.components, stepper)
    return stepper
end

function Section:AddCopyButton(text, textToCopy)
    local copyButton = CopyButton.new(self.content, self.theme, self.style, self.window, text, textToCopy)
    table.insert(self.components, copyButton)
    return copyButton
end

function Section:AddThemePicker(callback)
    local themePicker = ThemePicker.new(self.content, self.theme, self.style, self.window, callback)
    table.insert(self.components, themePicker)
    return themePicker
end

function Section:AddExportImport(config, filename)
    local exportImport = ExportImport.new(self.content, self.theme, self.style, self.window, config, filename)
    table.insert(self.components, exportImport)
    return exportImport
end

function Section:AddSearchFilter(items, callback)
    local searchFilter = SearchFilter.new(self.content, self.theme, self.style, self.window, items, callback)
    table.insert(self.components, searchFilter)
    return searchFilter
end

function Section:AddPagination(totalPages, callback)
    local pagination = Pagination.new(self.content, self.theme, self.style, self.window, totalPages, callback)
    table.insert(self.components, pagination)
    return pagination
end

function Section:AddImageGallery(images, callback)
    local imageGallery = ImageGallery.new(self.content, self.theme, self.style, self.window, images, callback)
    table.insert(self.components, imageGallery)
    return imageGallery
end

function Section:AddImageButton(imageId, text, callback, clickableImage)
    local imageButton = ImageButton.new(self.content, self.theme, self.style, self.window, imageId, text, callback, clickableImage)
    table.insert(self.components, imageButton)
    return imageButton
end

function Section:AddCheckbox(text, default, callback)
    local checkbox = Checkbox.new(self.content, self.theme, self.style, self.window, text, default, callback)
    table.insert(self.components, checkbox)
    return checkbox
end

function Section:AddProgressBar(text, value, max)
    local progressBar = ProgressBar.new(self.content, self.theme, self.style, self.window, text, value, max)
    table.insert(self.components, progressBar)
    return progressBar
end

function Section:AddTabContainer()
    local tabContainer = TabContainer.new(self.content, self.theme, self.style, self.window)
    table.insert(self.components, tabContainer)
    return tabContainer
end

function Section:AddList(title)
    local list = List.new(self.content, self.theme, self.style, self.window, title)
    table.insert(self.components, list)
    return list
end

function Section:AddLabel(text, size)
    local label = Label.new(self.content, self.theme, self.style, self.window, text, size)
    table.insert(self.components, label)
    return label
end

function Section:AddParagraph(text)
    local paragraph = Paragraph.new(self.content, self.theme, self.style, self.window, text)
    table.insert(self.components, paragraph)
    return paragraph
end

function Section:AddDivider(text)
    local divider = Divider.new(self.content, self.theme, self.style, self.window, text)
    table.insert(self.components, divider)
    return divider
end

function Section:AddNumberInput(text, default, min, max, callback)
    local numberInput = NumberInput.new(self.content, self.theme, self.style, self.window, text, default, min, max, callback)
    table.insert(self.components, numberInput)
    return numberInput
end

function Section:AddKeybind(text, default, callback)
    local keybind = Keybind.new(self.content, self.theme, self.style, self.window, text, default, callback)
    table.insert(self.components, keybind)
    return keybind
end

function Section:AddMultilineTextBox(text, placeholder, lines, callback)
    local multilineTextBox = MultilineTextBox.new(self.content, self.theme, self.style, self.window, text, placeholder, lines, callback)
    table.insert(self.components, multilineTextBox)
    return multilineTextBox
end

function Section:AddToggle(text, default, callback)
    local toggle = Toggle.new(self.content, self.theme, self.style, self.window, text, default, callback)
    table.insert(self.components, toggle)
    return toggle
end

function Section:AddSlider(text, min, max, default, increment, callback)
    local slider = Slider.new(self.content, self.theme, self.style, self.window, text, min, max, default, increment, callback)
    table.insert(self.components, slider)
    return slider
end

function Section:AddButton(text, callback, color)
    local button = Button.new(self.content, self.theme, self.style, self.window, text, callback, color)
    table.insert(self.components, button)
    return button
end

function Section:AddDropdown(text, options, default, callback)
    local dropdown = Dropdown.new(self.content, self.theme, self.style, self.window, text, options, default, callback)
    table.insert(self.components, dropdown)
    return dropdown
end

function Section:AddColorPicker(text, default, callback)
    local colorPicker = ColorPicker.new(self.content, self.theme, self.style, self.window, text, default, callback)
    table.insert(self.components, colorPicker)
    return colorPicker
end

function Section:AddTextBox(text, placeholder, callback)
    local textBox = TextBox.new(self.content, self.theme, self.style, self.window, text, placeholder, callback)
    table.insert(self.components, textBox)
    return textBox
end

function Section:Destroy()
    for _, component in ipairs(self.components) do
        safeCall(function()
            component:Destroy()
        end)
    end
    safeCall(function()
        if self.instance then
            self.instance:Destroy()
        end
    end)
end

local Page = {}
Page.__index = Page

function Page.new(parent, theme, style, window, title)
    local self = setmetatable({}, Page)
    self.parent = parent
    self.theme = theme
    self.style = style
    self.window = window
    self.title = title
    self.sections = {}
    self:Create()
    return self
end

function Page:Create()
    local page = Instance.new("ScrollingFrame")
    page.Name = self.title .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = self.theme.colors.text3
    page.ScrollBarImageTransparency = 0.7
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.ZIndex = ZINDEX.Content
    page.Parent = self.parent
    self.instance = page
    
    local pagePadding = Instance.new("UIPadding")
    pagePadding.PaddingLeft = UDim.new(0, self.style.contentPadding)
    pagePadding.PaddingRight = UDim.new(0, self.style.contentPadding)
    pagePadding.PaddingTop = UDim.new(0, 8)
    pagePadding.PaddingBottom = UDim.new(0, self.style.contentPadding)
    pagePadding.Parent = page
    
    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, self.style.spacing + 4)
    pageLayout.Parent = page
end

function Page:AddSection(title)
    local section = Section.new(self.instance, self.theme, self.style, self.window, title)
    table.insert(self.sections, section)
    return section
end

function Page:Show()
    safeCall(function()
        self.instance.Visible = true
    end)
    return self
end

function Page:Hide()
    safeCall(function()
        self.instance.Visible = false
    end)
    return self
end

function Page:Destroy()
    for _, section in ipairs(self.sections) do
        safeCall(function()
            section:Destroy()
        end)
    end
    safeCall(function()
        if self.instance then
            self.instance:Destroy()
        end
    end)
end

local Window = {}
Window.__index = Window

function Window.new(library, title, subtitle)
    local self = setmetatable({}, Window)
    self.library = library
    self.title = title or "Hyperion"
    self.subtitle = subtitle or "UI Library"
    self.theme = library.theme
    self.style = library.style
    self.pages = {}
    self.currentPage = nil
    self.destroyed = false
    self.draggable = true
    self.resizable = false
    
    self.PageChanged = Signal.new()
    self.ThemeChanged = Signal.new()
    self.StyleChanged = Signal.new()
    
    self:Create()
    return self
end

function Window:Create()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HyperionUI_" .. HttpService:GenerateGUID(false)
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 999999
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = CoreGui
    self.gui = screenGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "Main"
    mainFrame.Size = self.style.mainSize
    mainFrame.Position = UDim2.new(0.5, -self.style.mainSize.X.Offset/2, 0.5, -self.style.mainSize.Y.Offset/2)
    mainFrame.BackgroundColor3 = self.theme.colors.bg1
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = false
    mainFrame.ZIndex = ZINDEX.Base
    mainFrame.Parent = screenGui
    self.mainFrame = mainFrame
    
    self.theme:Track(mainFrame, "BackgroundColor3", "bg1")
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, self.style.cornerRadius + 2)
    mainCorner.Parent = mainFrame
    
    if self.style.borderWidth > 0 then
        local mainStroke = Instance.new("UIStroke")
        mainStroke.Color = self.theme.colors.border
        mainStroke.Thickness = self.style.borderWidth
        mainStroke.Transparency = 0.3
        mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        mainStroke.Parent = mainFrame
        
        self.theme:Track(mainStroke, "Color", "border")
    end
    
    if self.style.type == "sidebar" then
        self:CreateSidebar()
    elseif self.style.type == "topbar" then
        self:CreateTopbar()
    end
    
    self:CreateContentArea()
    self:CreateTopControls()
    if self.draggable then
        self:SetupDragging()
    end
end

function Window:CreateToast()
    if not self.toast then
        self.toast = Toast.new(self.gui, self.theme, self.style)
    end
    return self.toast
end

function Window:Notify(message, duration, type)
    return self:CreateToast():Show(message, duration, type)
end

function Window:CreateSidebar()
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, self.style.sidebarWidth, 1, 0)
    sidebar.BackgroundColor3 = self.theme.colors.bg2
    sidebar.BorderSizePixel = 0
    sidebar.ZIndex = ZINDEX.Sidebar
    sidebar.Parent = self.mainFrame
    self.sidebar = sidebar
    
    self.theme:Track(sidebar, "BackgroundColor3", "bg2")
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, self.style.cornerRadius + 2)
    sidebarCorner.Parent = sidebar
    
    local sidebarCover = Instance.new("Frame")
    sidebarCover.Size = UDim2.new(0, self.style.cornerRadius + 2, 1, 0)
    sidebarCover.Position = UDim2.new(1, -(self.style.cornerRadius + 2), 0, 0)
    sidebarCover.BackgroundColor3 = self.theme.colors.bg2
    sidebarCover.BorderSizePixel = 0
    sidebarCover.ZIndex = ZINDEX.Sidebar
    sidebarCover.Parent = sidebar
    
    self.theme:Track(sidebarCover, "BackgroundColor3", "bg2")
    
    if self.style.borderWidth > 0 then
        local sidebarBorder = Instance.new("Frame")
        sidebarBorder.Size = UDim2.new(0, 1, 1, -24)
        sidebarBorder.Position = UDim2.new(1, 0, 0, 12)
        sidebarBorder.BackgroundColor3 = self.theme.colors.border
        sidebarBorder.BorderSizePixel = 0
        sidebarBorder.ZIndex = ZINDEX.Sidebar + 1
        sidebarBorder.Parent = sidebar
        
        self.theme:Track(sidebarBorder, "BackgroundColor3", "border")
    end
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 70)
    header.BackgroundTransparency = 1
    header.ZIndex = ZINDEX.Sidebar + 1
    header.Parent = sidebar
    
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(1, -32, 0, 28)
    logo.Position = UDim2.new(0, 16, 0, 20)
    logo.BackgroundTransparency = 1
    logo.Text = self.title
    logo.TextColor3 = self.theme.colors.text1
    logo.TextSize = 20
    logo.Font = self.style.fontTitle
    logo.TextXAlignment = Enum.TextXAlignment.Left
    logo.ZIndex = ZINDEX.Sidebar + 1
    logo.Parent = header
    
    self.theme:Track(logo, "TextColor3", "text1")
    
    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(1, -32, 0, 14)
    version.Position = UDim2.new(0, 16, 0, 48)
    version.BackgroundTransparency = 1
    version.Text = self.subtitle
    version.TextColor3 = self.theme.colors.text3
    version.TextSize = 11
    version.Font = self.style.fontBody
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.ZIndex = ZINDEX.Sidebar + 1
    version.Parent = header
    
    self.theme:Track(version, "TextColor3", "text3")
    
    local navContainer = Instance.new("ScrollingFrame")
    navContainer.Name = "NavContainer"
    navContainer.Size = UDim2.new(1, 0, 1, -70)
    navContainer.Position = UDim2.new(0, 0, 0, 70)
    navContainer.BackgroundTransparency = 1
    navContainer.BorderSizePixel = 0
    navContainer.ScrollBarThickness = 0
    navContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    navContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    navContainer.ScrollingDirection = Enum.ScrollingDirection.Y
    navContainer.ZIndex = ZINDEX.Sidebar + 1
    navContainer.Parent = sidebar
    self.navContainer = navContainer
    
    local navPadding = Instance.new("UIPadding")
    navPadding.PaddingLeft = UDim.new(0, self.style.padding - 4)
    navPadding.PaddingRight = UDim.new(0, self.style.padding - 4)
    navPadding.PaddingTop = UDim.new(0, 4)
    navPadding.PaddingBottom = UDim.new(0, self.style.padding)
    navPadding.Parent = navContainer
    
    local navLayout = Instance.new("UIListLayout")
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder
    navLayout.Padding = UDim.new(0, 4)
    navLayout.Parent = navContainer
end

function Window:CreateTopbar()
    local navContainer = Instance.new("Frame")
    navContainer.Name = "NavContainer"
    navContainer.Size = UDim2.new(1, -200, 0, self.style.topBarHeight)
    navContainer.Position = UDim2.new(0, 20, 0, 0)
    navContainer.BackgroundTransparency = 1
    navContainer.ZIndex = ZINDEX.Topbar
    navContainer.Parent = self.mainFrame
    self.navContainer = navContainer
    
    local navLayout = Instance.new("UIListLayout")
    navLayout.FillDirection = Enum.FillDirection.Horizontal
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder
    navLayout.Padding = UDim.new(0, 8)
    navLayout.Parent = navContainer
end

function Window:CreateContentArea()
    local contentArea
    
    if self.style.type == "sidebar" then
        contentArea = Instance.new("Frame")
        contentArea.Name = "Content"
        contentArea.Size = UDim2.new(1, -self.style.sidebarWidth, 1, 0)
        contentArea.Position = UDim2.new(0, self.style.sidebarWidth, 0, 0)
        contentArea.BackgroundTransparency = 1
        contentArea.BorderSizePixel = 0
        contentArea.ClipsDescendants = true
        contentArea.ZIndex = ZINDEX.Content
        contentArea.Parent = self.mainFrame
    else
        contentArea = Instance.new("Frame")
        contentArea.Name = "Content"
        contentArea.Size = UDim2.new(1, 0, 1, -self.style.topBarHeight)
        contentArea.Position = UDim2.new(0, 0, 0, self.style.topBarHeight)
        contentArea.BackgroundTransparency = 1
        contentArea.BorderSizePixel = 0
        contentArea.ClipsDescendants = true
        contentArea.ZIndex = ZINDEX.Content
        contentArea.Parent = self.mainFrame
    end
    
    self.contentArea = contentArea
    
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, self.style.topBarHeight)
    topBar.BackgroundTransparency = 1
    topBar.ZIndex = ZINDEX.Topbar
    topBar.Parent = contentArea
    self.topBar = topBar
    
    local pageTitle = Instance.new("TextLabel")
    pageTitle.Name = "PageTitle"
    pageTitle.Size = UDim2.new(0, 400, 0, 32)
    pageTitle.Position = UDim2.new(0, 24, 0, (self.style.topBarHeight - 32) / 2)
    pageTitle.BackgroundTransparency = 1
    pageTitle.Text = ""
    pageTitle.TextColor3 = self.theme.colors.text1
    pageTitle.TextSize = 24
    pageTitle.Font = self.style.fontTitle
    pageTitle.TextXAlignment = Enum.TextXAlignment.Left
    pageTitle.ZIndex = ZINDEX.Topbar
    pageTitle.Parent = topBar
    self.pageTitle = pageTitle
    
    self.theme:Track(pageTitle, "TextColor3", "text1")
    
    local pageContainer = Instance.new("Frame")
    pageContainer.Name = "Pages"
    pageContainer.Size = UDim2.new(1, 0, 1, -self.style.topBarHeight)
    pageContainer.Position = UDim2.new(0, 0, 0, self.style.topBarHeight)
    pageContainer.BackgroundTransparency = 1
    pageContainer.ClipsDescendants = true
    pageContainer.ZIndex = ZINDEX.Content
    pageContainer.Parent = contentArea
    self.pageContainer = pageContainer
end

function Window:CreateTopControls()
    local controls = Instance.new("Frame")
    controls.Size = UDim2.new(0, 72, 0, 32)
    controls.Position = UDim2.new(1, -96, 0, (self.style.topBarHeight - 32) / 2)
    controls.BackgroundTransparency = 1
    controls.ZIndex = ZINDEX.Controls
    controls.Parent = self.topBar
    
    local minimize = Instance.new("TextButton")
    minimize.Size = UDim2.new(0, 32, 0, 32)
    minimize.BackgroundColor3 = self.theme.colors.bg3
    minimize.BorderSizePixel = 0
    minimize.Text = "—"
    minimize.TextColor3 = self.theme.colors.text2
    minimize.TextSize = 14
    minimize.Font = self.style.fontTitle
    minimize.AutoButtonColor = false
    minimize.ZIndex = ZINDEX.Controls
    minimize.Parent = controls
    
    self.theme:Track(minimize, "BackgroundColor3", "bg3")
    self.theme:Track(minimize, "TextColor3", "text2")
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    minCorner.Parent = minimize
    
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 32, 0, 32)
    close.Position = UDim2.new(0, 40, 0, 0)
    close.BackgroundColor3 = self.theme.colors.bg3
    close.BorderSizePixel = 0
    close.Text = "×"
    close.TextColor3 = self.theme.colors.text2
    close.TextSize = 20
    close.Font = self.style.fontTitle
    close.AutoButtonColor = false
    close.ZIndex = ZINDEX.Controls
    close.Parent = controls
    
    self.theme:Track(close, "BackgroundColor3", "bg3")
    self.theme:Track(close, "TextColor3", "text2")
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    closeCorner.Parent = close
    
    local isMinimized = false
    minimize.MouseButton1Click:Connect(function()
        safeCall(function()
            isMinimized = not isMinimized
            if isMinimized then
                TweenService:Create(self.mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    Size = UDim2.new(self.style.mainSize.X.Scale, self.style.mainSize.X.Offset, 0, self.style.topBarHeight)
                }):Play()
                if self.sidebar then self.sidebar.Visible = false end
                self.pageContainer.Visible = false
            else
                TweenService:Create(self.mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    Size = self.style.mainSize
                }):Play()
                if self.sidebar then self.sidebar.Visible = true end
                self.pageContainer.Visible = true
            end
        end)
    end)
    
    close.MouseButton1Click:Connect(function()
        self:Destroy()
    end)
    
    close.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(close, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.error}):Play()
            TweenService:Create(close, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.bg1}):Play()
        end)
    end)
    
    close.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(close, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
            TweenService:Create(close, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.text2}):Play()
        end)
    end)
    
    minimize.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(minimize, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    minimize.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(minimize, TweenInfo.new(self.style.animationSpeed), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function Window:SetupDragging()
    local dragging = false
    local dragInput, dragStart, startPos
    
    self.topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            safeCall(function()
                local delta = input.Position - dragStart
                self.mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end)
        end
    end)
end

function Window:ShowModal(title, message, buttons)
    local modal = Modal.new(self, self.theme, self.style, title, message, buttons)
    return modal
end

function Window:ShowContextMenu(items, position)
    local contextMenu = ContextMenu.new(self, self.theme, self.style, items, position or UserInputService:GetMouseLocation())
    return contextMenu
end

function Window:CreateTooltipManager()
    if not self.tooltipManager then
        self.tooltipManager = Tooltip.new(self, self.theme, self.style)
    end
    return self.tooltipManager
end

function Window:AttachTooltip(element, text, delay)
    local tooltipMgr = self:CreateTooltipManager()
    tooltipMgr:AttachTo(element, text, delay)
    return self
end

function Window:AddPage(title)
    local page = Page.new(self.pageContainer, self.theme, self.style, self, title)
    table.insert(self.pages, page)
    
    local button = Instance.new("TextButton")
    button.Name = title
    button.Size = self.style.type == "topbar" and UDim2.new(0, 100, 0, 36) or UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = self.theme.colors.bg3
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false
    button.LayoutOrder = #self.pages
    button.ZIndex = self.style.type == "topbar" and ZINDEX.Topbar or ZINDEX.Sidebar + 1
    button.Parent = self.navContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, self.style.cornerRadius)
    corner.Parent = button
    
    local label = Instance.new("TextLabel")
    label.Size = self.style.type == "topbar" and UDim2.new(1, 0, 1, 0) or UDim2.new(1, -36, 1, 0)
    label.Position = self.style.type == "topbar" and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = self.theme.colors.text2
    label.TextSize = 13
    label.Font = self.style.fontBody
    label.TextXAlignment = self.style.type == "topbar" and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    label.ZIndex = self.style.type == "topbar" and ZINDEX.Topbar or ZINDEX.Sidebar + 1
    label.Parent = button
    
    self.theme:Track(label, "TextColor3", "text2")
    
    local indicator
    if self.style.type == "sidebar" then
        indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 2, 0, 16)
        indicator.Position = UDim2.new(0, 0, 0.5, -8)
        indicator.BackgroundColor3 = self.theme.colors.primary
        indicator.BorderSizePixel = 0
        indicator.Visible = false
        indicator.ZIndex = ZINDEX.Sidebar + 2
        indicator.Parent = button
        
        self.theme:Track(indicator, "BackgroundColor3", "primary")
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(1, 0)
        indicatorCorner.Parent = indicator
    end
    
    button.MouseButton1Click:Connect(function()
        self:SelectPage(page, button, label, indicator)
    end)
    
    if isMobile() then
        button.TouchTap:Connect(function()
            self:SelectPage(page, button, label, indicator)
        end)
    end
    
    button.MouseEnter:Connect(function()
        if self.currentPage ~= page then
            safeCall(function()
                TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 0.5}):Play()
                TweenService:Create(label, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.text1}):Play()
            end)
        end
    end)
    
    button.MouseLeave:Connect(function()
        if self.currentPage ~= page then
            safeCall(function()
                TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 1}):Play()
                TweenService:Create(label, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.text2}):Play()
            end)
        end
    end)
    
    page.navButton = button
    page.navLabel = label
    page.navIndicator = indicator
    
    if #self.pages == 1 then
        self:SelectPage(page, button, label, indicator)
    end
    
    return page
end

function Window:SelectPage(page, button, label, indicator)
    safeCall(function()
        for _, p in ipairs(self.pages) do
            p:Hide()
            if p.navButton then
                TweenService:Create(p.navButton, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 1}):Play()
            end
            if p.navLabel then
                TweenService:Create(p.navLabel, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.text2}):Play()
            end
            if p.navIndicator then
                p.navIndicator.Visible = false
            end
        end
        
        page:Show()
        TweenService:Create(button, TweenInfo.new(self.style.animationSpeed), {BackgroundTransparency = 0}):Play()
        TweenService:Create(label, TweenInfo.new(self.style.animationSpeed), {TextColor3 = self.theme.colors.primary}):Play()
        if indicator then
            indicator.Visible = true
        end
        self.pageTitle.Text = page.title
        self.currentPage = page
        self.PageChanged:Fire(page)
    end)
end

function Window:SetTheme(presetName)
    if self.theme:SetPreset(presetName) then
        self.ThemeChanged:Fire(presetName)
        debugPrint("Theme changed to:", presetName)
        return self
    end
    return self
end

function Window:SetStyle(styleName)
    if StylePresets[styleName] then
        debugPrint("Applying style:", styleName)
        self.library.style = deepCopy(StylePresets[styleName])
        self.library:SetStyle(styleName)
        self.StyleChanged:Fire(styleName)
        return self
    end
    return self
end

function Window:SetSize(size)
    if self.mainFrame then
        self.mainFrame.Size = size
    end
    return self
end

function Window:SetDraggable(draggable)
    self.draggable = draggable
    return self
end

function Window:Toggle()
    safeCall(function()
        self.gui.Enabled = not self.gui.Enabled
    end)
    return self
end

function Window:Show()
    safeCall(function()
        self.gui.Enabled = true
    end)
    return self
end

function Window:Hide()
    safeCall(function()
        self.gui.Enabled = false
    end)
    return self
end

function Window:SaveConfig(filename)
    local config = {
        pages = {},
        theme = self.theme.currentPreset,
        style = self.library.style
    }
    
    for _, page in ipairs(self.pages) do
        local pageData = {
            title = page.title,
            sections = {}
        }
        
        for _, section in ipairs(page.sections) do
            local sectionData = {
                title = section.title,
                components = {}
            }
            
            for _, component in ipairs(section.components) do
                if component.GetValue then
                    table.insert(sectionData.components, {
                        type = tostring(getmetatable(component)),
                        value = component:GetValue()
                    })
                end
            end
            
            table.insert(pageData.sections, sectionData)
        end
        
        table.insert(config.pages, pageData)
    end
    
    local success = safeCall(function()
        writefile(filename, HttpService:JSONEncode(config))
    end)
    
    debugPrint("Config saved:", success)
    return self
end

function Window:LoadConfig(filename)
    local success, result = safeCall(function()
        return readfile(filename)
    end)
    
    if success and result then
        local config = HttpService:JSONDecode(result)
        
        if config.theme then
            self:SetTheme(config.theme)
        end
        
        debugPrint("Config loaded")
    end
    
    return self
end

function Window:Destroy()
    if not self.destroyed then
        self.destroyed = true
        debugPrint("Destroying window")
        
        self.PageChanged:DisconnectAll()
        self.ThemeChanged:DisconnectAll()
        self.StyleChanged:DisconnectAll()
        
        for _, page in ipairs(self.pages) do
            safeCall(function()
                page:Destroy()
            end)
        end
        safeCall(function()
            if self.gui then
                TweenService:Create(self.mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play()
                TweenService:Create(self.mainFrame, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
                task.wait(0.25)
                self.gui:Destroy()
            end
        end)
    end
end

function HyperionUI.new(options)
    local self = setmetatable({}, HyperionUI)
    
    options = options or {}
    self.theme = ThemeManager.new(options.theme or "Dark")
    self.style = deepCopy(StylePresets[options.style or (isMobile() and "Mobile" or "Modern")])
    self.toggleKey = options.toggleKey or Enum.KeyCode.Insert
    self.windows = {}
    
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == self.toggleKey then
            for _, window in ipairs(self.windows) do
                safeCall(function()
                    window:Toggle()
                end)
            end
        end
    end)
    
    debugPrint("HyperionUI initialized v" .. HyperionUI.VERSION)
    return self
end

function HyperionUI:CreateWindow(title, subtitle)
    local window = Window.new(self, title, subtitle)
    table.insert(self.windows, window)
    debugPrint("Window created:", title)
    return window
end

function HyperionUI:CreateTheme(name, colors)
    ThemePresets[name] = deepCopy(colors)
    debugPrint("Custom theme created:", name)
    return self
end

function HyperionUI:CreateStyle(name, styleData)
    StylePresets[name] = deepCopy(styleData)
    debugPrint("Custom style created:", name)
    return self
end

function HyperionUI:SetTheme(presetName)
    if self.theme:SetPreset(presetName) then
        for _, window in ipairs(self.windows) do
            safeCall(function()
                window.theme = self.theme
            end)
        end
        return self
    end
    return self
end

function HyperionUI:SetStyle(styleName)
    if StylePresets[styleName] then
        debugPrint("Changing all windows to style:", styleName)
        self.style = deepCopy(StylePresets[styleName])
        
        local windowData = {}
        for _, window in ipairs(self.windows) do
            local pages = {}
            for _, page in ipairs(window.pages) do
                table.insert(pages, page.title)
            end
            table.insert(windowData, {
                title = window.title,
                subtitle = window.subtitle,
                pages = pages
            })
            window:Destroy()
        end
        
        self.windows = {}
        
        for _, data in ipairs(windowData) do
            local newWindow = self:CreateWindow(data.title, data.subtitle)
            for _, pageTitle in ipairs(data.pages) do
                newWindow:AddPage(pageTitle)
            end
        end
        
        debugPrint("Style changed successfully")
        return self
    end
    return self
end

function HyperionUI:GetThemes()
    local themes = {}
    for name, _ in pairs(ThemePresets) do
        table.insert(themes, name)
    end
    return themes
end

function HyperionUI:GetStyles()
    local styles = {}
    for name, _ in pairs(StylePresets) do
        table.insert(styles, name)
    end
    return styles
end

function HyperionUI:IsMobile()
    return isMobile()
end

function HyperionUI:Destroy()
    for _, window in ipairs(self.windows) do
        safeCall(function()
            window:Destroy()
        end)
    end
    debugPrint("HyperionUI destroyed")
end

return HyperionUI
