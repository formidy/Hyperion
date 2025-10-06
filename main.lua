-- Hyperion UI Library v1.0
-- Fixed: Modal elements above all UI + Automatic style switching

local HyperionUI = {}
HyperionUI.__index = HyperionUI
HyperionUI.DEBUG_MODE = false

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- Constants
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

-- Theme Presets
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
    }
}

-- Style Presets
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
        mainSize = UDim2.new(0, 920, 0, 580)
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
        mainSize = UDim2.new(0, 800, 0, 500)
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
        mainSize = UDim2.new(0, 850, 0, 550)
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
        transparency = 0.1
    }
}

-- Utility Functions
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

-- Theme Manager
local ThemeManager = {}
ThemeManager.__index = ThemeManager

function ThemeManager.new(presetName)
    local self = setmetatable({}, ThemeManager)
    self.currentPreset = presetName or "Dark"
    self.colors = deepCopy(ThemePresets[self.currentPreset] or ThemePresets.Dark)
    self.trackedObjects = {}
    return self
end

function ThemeManager:SetPreset(presetName)
    if ThemePresets[presetName] then
        self.currentPreset = presetName
        self.colors = deepCopy(ThemePresets[presetName])
        self:UpdateAll()
        return true
    end
    return false
end

function ThemeManager:SetColor(colorKey, color)
    if self.colors[colorKey] then
        self.colors[colorKey] = color
        self:UpdateAll()
        return true
    end
    return false
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

-- Component Base Class
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
    return self
end

function Component:Destroy()
    if not self.destroyed then
        self.destroyed = true
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

-- Toggle Component
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
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function Toggle:Toggle()
    self.value = not self.value
    
    safeCall(function()
        TweenService:Create(self.switch, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = self.value and self.theme.colors.primary or self.theme.colors.border
        }):Play()
        
        TweenService:Create(self.knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Position = self.value and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        }):Play()
        
        if self.callback then
            self.callback(self.value)
        end
    end)
end

function Toggle:SetValue(value)
    if value ~= self.value then
        self:Toggle()
    end
end

-- Slider Component
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
        end)
    end
    
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input)
            safeCall(function()
                TweenService:Create(thumb, TweenInfo.new(0.2), {Size = UDim2.new(0, 18, 0, 18)}):Play()
            end)
        end
    end)
    
    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            safeCall(function()
                TweenService:Create(thumb, TweenInfo.new(0.2), {Size = UDim2.new(0, 14, 0, 14)}):Play()
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        if not dragging then
            safeCall(function()
                TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
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
end

-- Button Component
local Button = setmetatable({}, {__index = Component})
Button.__index = Button

function Button.new(parent, theme, style, window, text, callback, color)
    local self = setmetatable(Component.new(parent, theme, style, window), Button)
    self.text = text
    self.callback = callback
    self.color = color
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
    
    local originalColor = button.BackgroundColor3
    
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
        end)
    end)
    
    button.MouseEnter:Connect(function()
        safeCall(function()
            local current = button.BackgroundColor3
            local hoverColor = Color3.new(
                math.min(current.R + 0.05, 1),
                math.min(current.G + 0.05, 1),
                math.min(current.B + 0.05, 1)
            )
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
        end)
    end)
    
    button.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = self.color or self.theme.colors.primary}):Play()
        end)
    end)
end

-- Dropdown Component
local Dropdown = setmetatable({}, {__index = Component})
Dropdown.__index = Dropdown

function Dropdown.new(parent, theme, style, window, text, options, default, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), Dropdown)
    self.text = text
    self.options = options or {}
    self.value = default or (options and options[1]) or "Select"
    self.callback = callback
    self:Create()
    return self
end

function Dropdown:Create()
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
    label.Size = UDim2.new(0.45, -16, 1, 0)
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
    
    local selected = Instance.new("TextButton")
    selected.Size = UDim2.new(0.55, -12, 0, 30)
    selected.Position = UDim2.new(0.45, 4, 0.5, -15)
    selected.BackgroundColor3 = self.theme.colors.bg4
    selected.BorderSizePixel = 0
    selected.Text = ""
    selected.AutoButtonColor = false
    selected.ZIndex = ZINDEX.Content
    selected.Parent = container
    
    self.theme:Track(selected, "BackgroundColor3", "bg4")
    
    local selectedCorner = Instance.new("UICorner")
    selectedCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    selectedCorner.Parent = selected
    
    local selectedLabel = Instance.new("TextLabel")
    selectedLabel.Size = UDim2.new(1, -32, 1, 0)
    selectedLabel.Position = UDim2.new(0, 10, 0, 0)
    selectedLabel.BackgroundTransparency = 1
    selectedLabel.Text = self.value
    selectedLabel.TextColor3 = self.theme.colors.text1
    selectedLabel.TextSize = 12
    selectedLabel.Font = self.style.fontBody
    selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    selectedLabel.TextTruncate = Enum.TextTruncate.AtEnd
    selectedLabel.ZIndex = ZINDEX.Content
    selectedLabel.Parent = selected
    
    self.theme:Track(selectedLabel, "TextColor3", "text1")
    self.selectedLabel = selectedLabel
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 1, 0)
    arrow.Position = UDim2.new(1, -20, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = self.theme.colors.text3
    arrow.TextSize = 8
    arrow.Font = self.style.fontTitle
    arrow.ZIndex = ZINDEX.Content
    arrow.Parent = selected
    
    self.theme:Track(arrow, "TextColor3", "text3")
    self.arrow = arrow
    
    -- Create dropdown list parented to ScreenGui for proper ZIndex
    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(0, 0, 0, math.min(#self.options * 36, 180))
    list.BackgroundColor3 = self.theme.colors.bg2
    list.BorderSizePixel = 0
    list.Visible = false
    list.ZIndex = ZINDEX.Dropdown
    list.ScrollBarThickness = 4
    list.ScrollBarImageColor3 = self.theme.colors.text3
    list.CanvasSize = UDim2.new(0, 0, 0, #self.options * 36)
    list.Parent = self.window.gui  -- Parent to ScreenGui!
    
    self.theme:Track(list, "BackgroundColor3", "bg2")
    self.list = list
    table.insert(self.modalElements, list)
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, self.style.cornerRadius - 2)
    listCorner.Parent = list
    
    if self.style.borderWidth > 0 then
        local listStroke = Instance.new("UIStroke")
        listStroke.Color = self.theme.colors.border
        listStroke.Thickness = self.style.borderWidth
        listStroke.Transparency = 0.5
        listStroke.Parent = list
        
        self.theme:Track(listStroke, "Color", "border")
    end
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 0)
    listLayout.Parent = list
    
    for i, option in ipairs(self.options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 36)
        optBtn.BackgroundColor3 = self.theme.colors.bg2
        optBtn.BorderSizePixel = 0
        optBtn.Text = ""
        optBtn.AutoButtonColor = false
        optBtn.ZIndex = ZINDEX.Dropdown + 1
        optBtn.Parent = list
        
        local optLabel = Instance.new("TextLabel")
        optLabel.Size = UDim2.new(1, -20, 1, 0)
        optLabel.Position = UDim2.new(0, 10, 0, 0)
        optLabel.BackgroundTransparency = 1
        optLabel.Text = option
        optLabel.TextColor3 = self.theme.colors.text1
        optLabel.TextSize = 12
        optLabel.Font = self.style.fontBody
        optLabel.TextXAlignment = Enum.TextXAlignment.Left
        optLabel.ZIndex = ZINDEX.Dropdown + 1
        optLabel.Parent = optBtn
        
        self.theme:Track(optLabel, "TextColor3", "text1")
        
        optBtn.MouseButton1Click:Connect(function()
            safeCall(function()
                self.value = option
                selectedLabel.Text = option
                list.Visible = false
                TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                if self.callback then
                    self.callback(option)
                end
            end)
        end)
        
        optBtn.MouseEnter:Connect(function()
            safeCall(function()
                TweenService:Create(optBtn, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
            end)
        end)
        
        optBtn.MouseLeave:Connect(function()
            safeCall(function()
                TweenService:Create(optBtn, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg2}):Play()
            end)
        end)
    end
    
    -- Update position when shown
    local function updateListPosition()
        safeCall(function()
            local absPos = selected.AbsolutePosition
            local absSize = selected.AbsoluteSize
            list.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
            list.Size = UDim2.new(0, absSize.X, 0, math.min(#self.options * 36, 180))
        end)
    end
    
    selected.MouseButton1Click:Connect(function()
        safeCall(function()
            list.Visible = not list.Visible
            if list.Visible then
                updateListPosition()
            end
            local rotation = list.Visible and 180 or 0
            TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = rotation}):Play()
        end)
    end)
    
    selected.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(selected, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg5}):Play()
        end)
    end)
    
    selected.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(selected, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
    
    -- Close dropdown when clicking outside
    self.window.gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = UserInputService:GetMouseLocation()
            local listPos = list.AbsolutePosition
            local listSize = list.AbsoluteSize
            
            if list.Visible and (mousePos.X < listPos.X or mousePos.X > listPos.X + listSize.X or 
               mousePos.Y < listPos.Y or mousePos.Y > listPos.Y + listSize.Y) then
                local selectedPos = selected.AbsolutePosition
                local selectedSize = selected.AbsoluteSize
                
                if not (mousePos.X >= selectedPos.X and mousePos.X <= selectedPos.X + selectedSize.X and
                       mousePos.Y >= selectedPos.Y and mousePos.Y <= selectedPos.Y + selectedSize.Y) then
                    list.Visible = false
                    TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                end
            end
        end
    end)
end

function Dropdown:SetValue(value)
    for _, option in ipairs(self.options) do
        if option == value then
            self.value = value
            safeCall(function()
                self.selectedLabel.Text = value
            end)
            return true
        end
    end
    return false
end

-- ColorPicker Component
local ColorPicker = setmetatable({}, {__index = Component})
ColorPicker.__index = ColorPicker

function ColorPicker.new(parent, theme, style, window, text, default, callback)
    local self = setmetatable(Component.new(parent, theme, style, window), ColorPicker)
    self.text = text
    self.value = default or Color3.fromRGB(255, 255, 255)
    self.callback = callback
    self.h, self.s, self.v = self.value:ToHSV()
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
    
    -- Create picker frame parented to ScreenGui for proper ZIndex
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Size = UDim2.new(0, 240, 0, 200)
    pickerFrame.BackgroundColor3 = self.theme.colors.bg2
    pickerFrame.BorderSizePixel = 0
    pickerFrame.Visible = false
    pickerFrame.ZIndex = ZINDEX.ColorPicker
    pickerFrame.Parent = self.window.gui  -- Parent to ScreenGui!
    
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
    
    local hueSlider = Instance.new("Frame")
    hueSlider.Size = UDim2.new(1, -32, 0, 20)
    hueSlider.Position = UDim2.new(0, 16, 0, 16)
    hueSlider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    hueSlider.BorderSizePixel = 0
    hueSlider.ZIndex = ZINDEX.ColorPicker + 1
    hueSlider.Parent = pickerFrame
    
    local hueCorner = Instance.new("UICorner")
    hueCorner.CornerRadius = UDim.new(0, 4)
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
    
    local satValPicker = Instance.new("ImageButton")
    satValPicker.Size = UDim2.new(1, -32, 0, 120)
    satValPicker.Position = UDim2.new(0, 16, 0, 48)
    satValPicker.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    satValPicker.BorderSizePixel = 0
    satValPicker.ZIndex = ZINDEX.ColorPicker + 1
    satValPicker.Parent = pickerFrame
    self.satValPicker = satValPicker
    
    local svCorner = Instance.new("UICorner")
    svCorner.CornerRadius = UDim.new(0, 4)
    svCorner.Parent = satValPicker
    
    local whiteMask = Instance.new("Frame")
    whiteMask.Size = UDim2.new(1, 0, 1, 0)
    whiteMask.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    whiteMask.BorderSizePixel = 0
    whiteMask.ZIndex = ZINDEX.ColorPicker + 2
    whiteMask.Parent = satValPicker
    
    local whiteCorner = Instance.new("UICorner")
    whiteCorner.CornerRadius = UDim.new(0, 4)
    whiteCorner.Parent = whiteMask
    
    local whiteGradient = Instance.new("UIGradient")
    whiteGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        ColorSequenceKeypoint.new(1, 1)
    }
    whiteGradient.Parent = whiteMask
    
    local blackMask = Instance.new("Frame")
    blackMask.Size = UDim2.new(1, 0, 1, 0)
    blackMask.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackMask.BorderSizePixel = 0
    blackMask.ZIndex = ZINDEX.ColorPicker + 3
    blackMask.Parent = satValPicker
    
    local blackCorner = Instance.new("UICorner")
    blackCorner.CornerRadius = UDim.new(0, 4)
    blackCorner.Parent = blackMask
    
    local blackGradient = Instance.new("UIGradient")
    blackGradient.Rotation = 90
    blackGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    blackGradient.Parent = blackMask
    
    local function updateColor()
        safeCall(function()
            local newColor = Color3.fromHSV(self.h, self.s, self.v)
            self.value = newColor
            colorPreview.BackgroundColor3 = newColor
            satValPicker.BackgroundColor3 = Color3.fromHSV(self.h, 1, 1)
            if self.callback then
                self.callback(newColor)
            end
        end)
    end
    
    hueSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local function update(input)
                safeCall(function()
                    local pos = math.clamp((input.Position.X - hueSlider.AbsolutePosition.X) / hueSlider.AbsoluteSize.X, 0, 1)
                    self.h = pos
                    updateColor()
                end)
            end
            update(input)
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                end
            end)
            local moveConnection
            moveConnection = UserInputService.InputChanged:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseMovement then
                    update(input2)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    moveConnection:Disconnect()
                end
            end)
        end
    end)
    
    satValPicker.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local function update(input)
                safeCall(function()
                    local posX = math.clamp((input.Position.X - satValPicker.AbsolutePosition.X) / satValPicker.AbsoluteSize.X, 0, 1)
                    local posY = math.clamp((input.Position.Y - satValPicker.AbsolutePosition.Y) / satValPicker.AbsoluteSize.Y, 0, 1)
                    self.s = posX
                    self.v = 1 - posY
                    updateColor()
                end)
            end
            update(input)
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                end
            end)
            local moveConnection
            moveConnection = UserInputService.InputChanged:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseMovement then
                    update(input2)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    moveConnection:Disconnect()
                end
            end)
        end
    end)
    
    -- Update position when shown
    local function updatePickerPosition()
        safeCall(function()
            local absPos = colorPreview.AbsolutePosition
            local absSize = colorPreview.AbsoluteSize
            pickerFrame.Position = UDim2.new(0, absPos.X + absSize.X - 240, 0, absPos.Y + absSize.Y + 4)
        end)
    end
    
    colorPreview.MouseButton1Click:Connect(function()
        safeCall(function()
            pickerFrame.Visible = not pickerFrame.Visible
            if pickerFrame.Visible then
                updatePickerPosition()
            end
        end)
    end)
    
    colorPreview.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(previewStroke, TweenInfo.new(0.2), {Color = self.theme.colors.primary}):Play()
        end)
    end)
    
    colorPreview.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(previewStroke, TweenInfo.new(0.2), {Color = self.theme.colors.border}):Play()
        end)
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
    
    -- Close picker when clicking outside
    self.window.gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = UserInputService:GetMouseLocation()
            local pickerPos = pickerFrame.AbsolutePosition
            local pickerSize = pickerFrame.AbsoluteSize
            
            if pickerFrame.Visible and (mousePos.X < pickerPos.X or mousePos.X > pickerPos.X + pickerSize.X or 
               mousePos.Y < pickerPos.Y or mousePos.Y > pickerPos.Y + pickerSize.Y) then
                local previewPos = colorPreview.AbsolutePosition
                local previewSize = colorPreview.AbsoluteSize
                
                if not (mousePos.X >= previewPos.X and mousePos.X <= previewPos.X + previewSize.X and
                       mousePos.Y >= previewPos.Y and mousePos.Y <= previewPos.Y + previewSize.Y) then
                    pickerFrame.Visible = false
                end
            end
        end
    end)
end

function ColorPicker:SetValue(color)
    self.value = color
    self.h, self.s, self.v = color:ToHSV()
    safeCall(function()
        self.colorPreview.BackgroundColor3 = color
        self.satValPicker.BackgroundColor3 = Color3.fromHSV(self.h, 1, 1)
    end)
end

-- TextBox Component
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
        end)
    end)
    
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        safeCall(function()
            self.value = textBox.Text
            if self.callback then
                self.callback(textBox.Text)
            end
        end)
    end)
    
    container.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    container.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function TextBox:SetValue(value)
    self.value = value
    safeCall(function()
        self.textBox.Text = value
    end)
end

-- Section Class
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

-- Page Class
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
    pagePadding.PaddingRight = UDim2.new(0, self.style.contentPadding)
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
end

function Page:Hide()
    safeCall(function()
        self.instance.Visible = false
    end)
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

-- Window Class (continued in next message due to length)
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
    self:SetupDragging()
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
            TweenService:Create(close, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.error}):Play()
            TweenService:Create(close, TweenInfo.new(0.2), {TextColor3 = self.theme.colors.bg1}):Play()
        end)
    end)
    
    close.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(close, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
            TweenService:Create(close, TweenInfo.new(0.2), {TextColor3 = self.theme.colors.text2}):Play()
        end)
    end)
    
    minimize.MouseEnter:Connect(function()
        safeCall(function()
            TweenService:Create(minimize, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg4}):Play()
        end)
    end)
    
    minimize.MouseLeave:Connect(function()
        safeCall(function()
            TweenService:Create(minimize, TweenInfo.new(0.2), {BackgroundColor3 = self.theme.colors.bg3}):Play()
        end)
    end)
end

function Window:SetupDragging()
    local dragging = false
    local dragInput, dragStart, startPos
    
    self.topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement then
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
    
    button.MouseEnter:Connect(function()
        if self.currentPage ~= page then
            safeCall(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
                TweenService:Create(label, TweenInfo.new(0.2), {TextColor3 = self.theme.colors.text1}):Play()
            end)
        end
    end)
    
    button.MouseLeave:Connect(function()
        if self.currentPage ~= page then
            safeCall(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                TweenService:Create(label, TweenInfo.new(0.2), {TextColor3 = self.theme.colors.text2}):Play()
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
                TweenService:Create(p.navButton, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            end
            if p.navLabel then
                TweenService:Create(p.navLabel, TweenInfo.new(0.2), {TextColor3 = self.theme.colors.text2}):Play()
            end
            if p.navIndicator then
                p.navIndicator.Visible = false
            end
        end
        
        page:Show()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        TweenService:Create(label, TweenInfo.new(0.2), {TextColor3 = self.theme.colors.primary}):Play()
        if indicator then
            indicator.Visible = true
        end
        self.pageTitle.Text = page.title
        self.currentPage = page
    end)
end

function Window:SetTheme(presetName)
    if self.theme:SetPreset(presetName) then
        debugPrint("Theme changed to:", presetName)
        return true
    end
    return false
end

function Window:SetStyle(styleName)
    if StylePresets[styleName] and styleName ~= self.library.style then
        debugPrint("Applying style:", styleName)
        self.library.style = deepCopy(StylePresets[styleName])
        self.library:SetStyle(styleName)
        return true
    end
    return false
end

function Window:Toggle()
    safeCall(function()
        self.gui.Enabled = not self.gui.Enabled
    end)
end

function Window:Destroy()
    if not self.destroyed then
        self.destroyed = true
        debugPrint("Destroying window")
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

-- Main Library
function HyperionUI.new(options)
    local self = setmetatable({}, HyperionUI)
    
    options = options or {}
    self.theme = ThemeManager.new(options.theme or "Dark")
    self.style = deepCopy(StylePresets[options.style or "Modern"])
    self.toggleKey = options.toggleKey or Enum.KeyCode.Insert
    self.windows = {}
    
    -- Setup toggle key
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == self.toggleKey then
            for _, window in ipairs(self.windows) do
                safeCall(function()
                    window:Toggle()
                end)
            end
        end
    end)
    
    debugPrint("HyperionUI initialized")
    return self
end

function HyperionUI:CreateWindow(title, subtitle)
    local window = Window.new(self, title, subtitle)
    table.insert(self.windows, window)
    debugPrint("Window created:", title)
    return window
end

function HyperionUI:SetTheme(presetName)
    if self.theme:SetPreset(presetName) then
        for _, window in ipairs(self.windows) do
            safeCall(function()
                window.theme = self.theme
            end)
        end
        return true
    end
    return false
end

function HyperionUI:SetStyle(styleName)
    if StylePresets[styleName] then
        debugPrint("Changing all windows to style:", styleName)
        self.style = deepCopy(StylePresets[styleName])
        
        -- Store all window data
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
        
        -- Clear windows
        self.windows = {}
        
        -- Recreate windows with new style
        for _, data in ipairs(windowData) do
            local newWindow = self:CreateWindow(data.title, data.subtitle)
            for _, pageTitle in ipairs(data.pages) do
                newWindow:AddPage(pageTitle)
            end
        end
        
        debugPrint("Style changed successfully - UI rebuilt")
        return true
    end
    return false
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
