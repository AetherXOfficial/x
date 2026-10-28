local OxireunUI = {}
OxireunUI.__index = OxireunUI
local inst, ud2, ud, c3, v2 = Instance.new, UDim2.new, UDim.new, Color3.fromRGB, Vector2.new
local ti, cseq, csk = TweenInfo.new, ColorSequence.new, ColorSequenceKeypoint.new
local ts, uis, rs = game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("RunService")
local cp, plrs, txtSvc, hs = game:GetService("ContentProvider"), game:GetService("Players"), game:GetService("TextService"), game:GetService("HttpService")
local lplr = plrs.LocalPlayer
local core = (gethui and gethui()) or game:GetService("CoreGui")
local function genHash() return hs:GenerateGUID(false):gsub("-", "") end
local Colors = {Background=c3(15,12,22),SecondaryBg=c3(10,8,15),SectionBg=c3(15,12,22),Border=c3(120,40,220),Accent=c3(100,30,150),Text=c3(255,255,255),TextInactive=c3(200,150,255),Disabled=c3(120,100,160),Hover=c3(50,20,80),Button=c3(30,15,40),Slider=c3(150,40,255),ToggleOn=c3(150,40,255),ToggleOff=c3(40,15,70),TabActive=c3(100,30,150),TabInactive=c3(40,15,70),ControlButton=c3(30,15,45),CloseButton=c3(180,40,40)}
local RGBColors = {c3(180,50,220),c3(150,50,200),c3(200,60,230),c3(170,40,210),c3(190,70,240),c3(160,30,190)}
local Themes = {
["black"]={Background=c3(8,8,8),SecondaryBg=c3(5,5,5),SectionBg=c3(10,10,10),Border=c3(60,60,60),Accent=c3(150,150,150),TextInactive=c3(150,150,150),Disabled=c3(40,40,40),Hover=c3(20,20,20),Button=c3(15,15,15),Slider=c3(200,200,200),ToggleOn=c3(200,200,200),ToggleOff=c3(30,30,30),TabActive=c3(150,150,150),TabInactive=c3(20,20,20),ControlButton=c3(25,25,25),Text=c3(255,255,255),RGB={c3(120,120,120),c3(100,100,100),c3(140,140,140),c3(90,90,90),c3(150,150,150),c3(110,110,110)}},
["grey"]={Background=c3(35,35,40),SecondaryBg=c3(25,25,30),SectionBg=c3(35,35,40),Border=c3(120,120,130),Accent=c3(160,160,170),TextInactive=c3(180,180,190),Disabled=c3(80,80,90),Hover=c3(60,60,70),Button=c3(45,45,50),Slider=c3(180,180,190),ToggleOn=c3(180,180,190),ToggleOff=c3(50,50,60),TabActive=c3(140,140,150),TabInactive=c3(40,40,45),ControlButton=c3(50,50,55),Text=c3(255,255,255),RGB={c3(150,150,160),c3(130,130,140),c3(170,170,180),c3(110,110,120),c3(190,190,200),c3(140,140,150)}},
["red"]={Background=c3(22,12,12),SecondaryBg=c3(15,8,8),SectionBg=c3(22,12,12),Border=c3(220,40,40),Accent=c3(180,30,30),TextInactive=c3(255,150,150),Disabled=c3(160,100,100),Hover=c3(80,20,20),Button=c3(40,15,15),Slider=c3(255,40,40),ToggleOn=c3(255,40,40),ToggleOff=c3(70,15,15),TabActive=c3(180,30,30),TabInactive=c3(70,15,15),ControlButton=c3(45,15,15),Text=c3(255,255,255),RGB={c3(220,50,50),c3(200,50,50),c3(230,60,60),c3(210,40,40),c3(240,70,70),c3(190,30,30)}},
["blue"]={Background=c3(10,20,22),SecondaryBg=c3(5,12,15),SectionBg=c3(10,20,22),Border=c3(0,200,200),Accent=c3(0,180,180),TextInactive=c3(150,255,255),Disabled=c3(50,100,100),Hover=c3(15,60,60),Button=c3(10,30,30),Slider=c3(0,255,255),ToggleOn=c3(0,255,255),ToggleOff=c3(10,40,40),TabActive=c3(0,200,200),TabInactive=c3(10,40,40),ControlButton=c3(10,45,45),Text=c3(255,255,255),RGB={c3(0,255,255),c3(0,200,200),c3(50,255,255),c3(0,180,180),c3(100,255,255),c3(0,220,220)}},
["green"]={Background=c3(10,22,10),SecondaryBg=c3(5,15,5),SectionBg=c3(10,22,10),Border=c3(0,200,0),Accent=c3(0,180,0),TextInactive=c3(150,255,150),Disabled=c3(50,100,50),Hover=c3(15,60,15),Button=c3(10,30,10),Slider=c3(0,255,0),ToggleOn=c3(0,255,0),ToggleOff=c3(10,40,10),TabActive=c3(0,200,0),TabInactive=c3(10,40,10),ControlButton=c3(10,45,10),Text=c3(255,255,255),RGB={c3(0,255,0),c3(0,200,0),c3(50,255,50),c3(0,180,0),c3(100,255,100),c3(0,220,0)}},
["pink"]={Background=c3(22,10,16),SecondaryBg=c3(15,5,10),SectionBg=c3(22,10,16),Border=c3(255,20,147),Accent=c3(200,10,110),TextInactive=c3(255,150,200),Disabled=c3(120,50,80),Hover=c3(80,10,40),Button=c3(40,10,20),Slider=c3(255,20,147),ToggleOn=c3(255,20,147),ToggleOff=c3(50,10,25),TabActive=c3(255,20,147),TabInactive=c3(50,10,25),ControlButton=c3(45,15,25),Text=c3(255,255,255),RGB={c3(255,20,147),c3(230,10,120),c3(255,50,160),c3(200,0,100),c3(255,80,180),c3(220,15,130)}},
["orange"]={Background=c3(22,12,10),SecondaryBg=c3(15,8,5),SectionBg=c3(22,12,10),Border=c3(255,69,0),Accent=c3(200,50,0),TextInactive=c3(255,180,150),Disabled=c3(120,60,40),Hover=c3(80,25,10),Button=c3(40,15,10),Slider=c3(255,69,0),ToggleOn=c3(255,69,0),ToggleOff=c3(50,15,10),TabActive=c3(255,69,0),TabInactive=c3(50,15,10),ControlButton=c3(45,20,15),Text=c3(255,255,255),RGB={c3(255,69,0),c3(230,50,0),c3(255,90,30),c3(200,40,0),c3(255,120,50),c3(220,60,0)}},
["yellow"]={Background=c3(22,22,8),SecondaryBg=c3(15,15,5),SectionBg=c3(22,22,8),Border=c3(200,200,0),Accent=c3(180,180,0),TextInactive=c3(255,255,150),Disabled=c3(100,100,40),Hover=c3(80,80,10),Button=c3(40,40,10),Slider=c3(255,255,0),ToggleOn=c3(255,255,0),ToggleOff=c3(50,50,10),TabActive=c3(200,200,0),TabInactive=c3(50,50,10),ControlButton=c3(45,45,15),Text=c3(255,255,255),RGB={c3(255,255,0),c3(230,230,0),c3(255,255,50),c3(200,200,0),c3(255,255,100),c3(220,220,0)}}
}
local Fonts = {Title=Enum.Font.SciFi,Normal=Enum.Font.Gotham,Tab=Enum.Font.Gotham,Button=Enum.Font.Gotham,Bold=Enum.Font.GothamBold}
local UI_SIZE = {Width=260,Height=280}
local ELEMENT_SIZES = {TitleBar=30,TabHeight=32,ButtonHeight=32,SliderHeight=45,ToggleHeight=32,TextboxHeight=32,DropdownHeight=32,SectionSpacing=6}
local function parseSmartArgs(...)
    local id, shape, theme
    for _, arg in ipairs({...}) do
        if type(arg) == "number" then
            if arg == 1 or arg == 2 then shape = arg
            elseif arg > 999 then id = arg end
        elseif type(arg) == "string" then
            local l = string.lower(arg)
            if Themes[l] then theme = l
            elseif tonumber(arg) then
                local num = tonumber(arg)
                if num == 1 or num == 2 then shape = num
                elseif num > 999 then id = num end
            elseif arg:match("rbxassetid") or arg:match("rbxthumb") then id = arg end
        end
    end
    return id, shape, theme
end
function OxireunUI:SendNotification(title, text, duration, ...)
    local icon, shape, themeName = parseSmartArgs(...)
    duration = duration or 3
    local nCol = Colors 
    if themeName and Themes[themeName] then
        nCol = {}
        for k, v in pairs(Colors) do nCol[k] = v end
        for k, v in pairs(Themes[themeName]) do if k ~= "RGB" then nCol[k] = v end end
    end
    local targetGui
    for _, v in pairs(core:GetChildren()) do if v:GetAttribute("OxNotif") then targetGui = v break end end
    local pg = lplr:FindFirstChild("PlayerGui")
    if not targetGui and pg then
        for _, v in pairs(pg:GetChildren()) do if v:GetAttribute("OxNotif") then targetGui = v break end end
    end
    if not targetGui then
        targetGui = inst("ScreenGui")
        targetGui.Name = genHash() 
        targetGui:SetAttribute("OxNotif", true) 
        targetGui.ResetOnSpawn = false
        targetGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        targetGui.DisplayOrder = 101 
        pcall(function() targetGui.Parent = core end)
        if not targetGui.Parent and pg then targetGui.Parent = pg end
    end
    local NotifContainer = targetGui:FindFirstChild("Container")
    if not NotifContainer then
        NotifContainer = inst("Frame")
        NotifContainer.Name = "Container"
        NotifContainer.Size = ud2(0, 250, 1, -50)
        NotifContainer.Position = ud2(1, -270, 0, 20)
        NotifContainer.BackgroundTransparency = 1
        local list = inst("UIListLayout")
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.VerticalAlignment = Enum.VerticalAlignment.Bottom
        list.Padding = ud(0, 10)
        list.Parent = NotifContainer
        NotifContainer.Parent = targetGui
    end
    local img
    if icon then
        img = inst("ImageLabel")
        img.Size = ud2(0, 30, 0, 30)
        img.Position = ud2(0, 10, 0, 12)
        img.BackgroundTransparency = 1
        img.Image = tonumber(icon) and "rbxthumb://type=Asset&id="..icon.."&w=150&h=150" or icon
        img.ImageTransparency = 1
        img.ScaleType = Enum.ScaleType.Fit
        if shape == 2 then inst("UICorner", img).CornerRadius = ud(0, 6)
        else inst("UICorner", img).CornerRadius = ud(1, 0) end
    end
    local textOffset = icon and 50 or 10
    local availableWidth = 250 - textOffset - 15
    local bounds = txtSvc:GetTextSize(text or "Message", 12, Fonts.Normal, v2(availableWidth, 9000))
    local textHeight = math.clamp(bounds.Y, 20, 400)
    local frameHeight = math.max(60, 26 + textHeight + 20)
    local NotifFrame = inst("Frame")
    NotifFrame.Size = ud2(1, 0, 0, frameHeight)
    NotifFrame.BackgroundColor3 = c3(255, 255, 255)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.BackgroundTransparency = 1
    local corner = inst("UICorner")
    corner.CornerRadius = ud(0, 8)
    corner.Parent = NotifFrame
    local notifGrad = inst("UIGradient")
    notifGrad.Color = cseq({csk(0, nCol.Hover), csk(1, nCol.Background)})
    notifGrad.Rotation = 90
    notifGrad.Parent = NotifFrame
    local stroke = inst("UIStroke")
    stroke.Color = c3(255, 255, 255)
    stroke.Thickness = 1.5
    stroke.Transparency = 1
    stroke.Parent = NotifFrame
    local strokeGrad = inst("UIGradient")
    strokeGrad.Color = cseq({csk(0, nCol.Accent), csk(1, nCol.Border)})
    strokeGrad.Rotation = 45
    strokeGrad.Parent = stroke
    if img then img.Parent = NotifFrame end
    local TitleLabel = inst("TextLabel")
    TitleLabel.Size = ud2(1, -textOffset - 10, 0, 20)
    TitleLabel.Position = ud2(0, textOffset, 0, 6)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title or "Notification"
    TitleLabel.TextColor3 = nCol.Text
    TitleLabel.TextSize = 14
    TitleLabel.Font = Fonts.Bold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextTransparency = 1
    TitleLabel.TextScaled = true
    TitleLabel.TextWrapped = true
    local nTitleConst = inst("UITextSizeConstraint")
    nTitleConst.MaxTextSize = 14
    nTitleConst.MinTextSize = 9
    nTitleConst.Parent = TitleLabel
    TitleLabel.Parent = NotifFrame
    local TextLabel = inst("TextLabel")
    TextLabel.Size = ud2(1, -textOffset - 10, 0, textHeight)
    TextLabel.Position = ud2(0, textOffset, 0, 26)
    TextLabel.BackgroundTransparency = 1 
    TextLabel.Text = text or "Message"
    TextLabel.TextColor3 = nCol.TextInactive
    TextLabel.TextSize = 12
    TextLabel.Font = Fonts.Normal
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextTransparency = 1
    TextLabel.TextWrapped = true
    TextLabel.Parent = NotifFrame
    local BarBg = inst("Frame")
    BarBg.Size = ud2(1, -20, 0, 4)
    BarBg.Position = ud2(0, 10, 1, -10)
    BarBg.BackgroundColor3 = nCol.SecondaryBg
    BarBg.BorderSizePixel = 0
    BarBg.BackgroundTransparency = 1
    inst("UICorner", BarBg).CornerRadius = ud(1, 0)
    BarBg.Parent = NotifFrame
    local Bar = inst("Frame")
    Bar.Size = ud2(1, 0, 1, 0)
    Bar.BackgroundColor3 = c3(255, 255, 255)
    Bar.BorderSizePixel = 0
    Bar.BackgroundTransparency = 1
    inst("UICorner", Bar).CornerRadius = ud(1, 0)
    local barGrad = inst("UIGradient")
    barGrad.Color = cseq({csk(0, nCol.Slider), csk(1, nCol.Border)})
    barGrad.Parent = Bar
    Bar.Parent = BarBg
    NotifFrame.Parent = NotifContainer
    ts:Create(NotifFrame, ti(0.3), {BackgroundTransparency = 0}):Play()
    ts:Create(stroke, ti(0.3), {Transparency = 0}):Play()
    ts:Create(TitleLabel, ti(0.3), {TextTransparency = 0}):Play()
    ts:Create(TextLabel, ti(0.3), {TextTransparency = 0}):Play()
    ts:Create(BarBg, ti(0.3), {BackgroundTransparency = 0.4}):Play()
    ts:Create(Bar, ti(0.3), {BackgroundTransparency = 0}):Play()
    if img then ts:Create(img, ti(0.3), {ImageTransparency = 0}):Play() end
    task.delay(0.3, function() ts:Create(Bar, ti(duration, Enum.EasingStyle.Linear), {Size = ud2(0, 0, 1, 0)}):Play() end)
    task.delay(duration + 0.3, function()
        ts:Create(NotifFrame, ti(0.3), {BackgroundTransparency = 1}):Play()
        ts:Create(stroke, ti(0.3), {Transparency = 1}):Play()
        ts:Create(TitleLabel, ti(0.3), {TextTransparency = 1}):Play()
        ts:Create(TextLabel, ti(0.3), {TextTransparency = 1}):Play()
        ts:Create(BarBg, ti(0.3), {BackgroundTransparency = 1}):Play()
        ts:Create(Bar, ti(0.3), {BackgroundTransparency = 1}):Play()
        if img then ts:Create(img, ti(0.3), {ImageTransparency = 1}):Play() end
        task.wait(0.3)
        NotifFrame:Destroy()
    end)
end
function OxireunUI.new()
    local self = setmetatable({}, OxireunUI)
    self.Windows = {}
    return self
end
function OxireunUI:NewWindow(title, ...)
    local logoId, shape, themeName = parseSmartArgs(...)
    if themeName then
        local t = Themes[themeName]
        if t then
            for k, v in pairs(t) do if k ~= "RGB" then Colors[k] = v end end
            if t.RGB then for i, v in ipairs(t.RGB) do RGBColors[i] = v end end
        end
    end
    local allowMulti = _G.MultiGui or _G.MultiUI or _G.OxireunMulti
    if not allowMulti then
        for _, v in pairs(core:GetChildren()) do if v:GetAttribute("OxMain") then v:Destroy() end end
        local pg = lplr:FindFirstChild("PlayerGui")
        if pg then for _, v in pairs(pg:GetChildren()) do if v:GetAttribute("OxMain") then v:Destroy() end end end
    end
    local Window = {Title = title or "Oxireun UI", Sections = {}, CurrentSection = nil}
    local ScreenGui = inst("ScreenGui")
    ScreenGui.Name = genHash()
    ScreenGui:SetAttribute("OxMain", true) 
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 10 
    local MainFrame = inst("Frame")
    MainFrame.Name = "MainWindow"
    MainFrame.Size = ud2(0, UI_SIZE.Width, 0, UI_SIZE.Height)
    MainFrame.Position = ud2(0, 10, 0.5, -UI_SIZE.Height/2)
    MainFrame.BackgroundColor3 = c3(255, 255, 255)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    local mainGradient = inst("UIGradient")
    mainGradient.Color = cseq({csk(0, Colors.Background), csk(0.4, Colors.Background), csk(0.5, Colors.Accent), csk(0.6, Colors.Background), csk(1, Colors.Background)})
    mainGradient.Rotation = 45
    mainGradient.Parent = MainFrame
    inst("UICorner", MainFrame).CornerRadius = ud(0, 8)
    local rgbBorder = inst("UIStroke")
    rgbBorder.Name = "RGBBorder"
    rgbBorder.Color = RGBColors[1]
    rgbBorder.Thickness = 2
    rgbBorder.Transparency = 0
    rgbBorder.Parent = MainFrame
    local FloatingLogo, logoBorder
    local activeDropdowns = {}
    local guiHasBeenDragged = false 
    if logoId then
        FloatingLogo = inst("ImageButton")
        FloatingLogo.Name = "FloatingLogo"
        FloatingLogo.Size = ud2(0, 46, 0, 46)
        FloatingLogo.Position = ud2(0, 20, 0.5, -23)
        FloatingLogo.BackgroundColor3 = Colors.Background
        FloatingLogo.Visible = true
        FloatingLogo.AutoButtonColor = false
        FloatingLogo.ClipsDescendants = true
        local logoCorner = inst("UICorner")
        if shape == 2 then logoCorner.CornerRadius = ud(0, 6)
        else logoCorner.CornerRadius = ud(1, 0) end
        logoCorner.Parent = FloatingLogo
        logoBorder = inst("UIStroke")
        logoBorder.Color = RGBColors[1]
        logoBorder.Thickness = 2
        logoBorder.Parent = FloatingLogo
        local logoImg = inst("ImageLabel")
        logoImg.Size = ud2(1, 0, 1, 0)
        logoImg.Position = ud2(0, 0, 0, 0)
        logoImg.BackgroundTransparency = 1
        logoImg.Image = tonumber(logoId) and "rbxthumb://type=Asset&id="..logoId.."&w=150&h=150" or logoId
        logoImg.ScaleType = Enum.ScaleType.Crop 
        logoImg.ClipsDescendants = true
        local innerCorner = inst("UICorner")
        innerCorner.CornerRadius = shape == 2 and ud(0, 6) or ud(1, 0)
        innerCorner.Parent = logoImg
        logoImg.Parent = FloatingLogo
        FloatingLogo.Parent = ScreenGui
        task.spawn(function()
            local tempImg = inst("ImageLabel")
            tempImg.Image = logoImg.Image
            tempImg.Visible = false
            tempImg.Parent = ScreenGui
            pcall(function() cp:PreloadAsync({tempImg}) end)
            tempImg:Destroy()
        end)
        local isGuiOpen = true
        task.spawn(function()
            task.wait() 
            if FloatingLogo and MainFrame then
                local lx, ly = FloatingLogo.AbsolutePosition.X, FloatingLogo.AbsolutePosition.Y
                local lw, lh = FloatingLogo.AbsoluteSize.X, FloatingLogo.AbsoluteSize.Y
                local targetY = ly + (lh / 2) - (UI_SIZE.Height / 2)
                MainFrame.Position = ud2(0, lx + lw + 15, 0, targetY)
            end
        end)
        local dragL = false
        local dragStartL, startPosL, hasMovedL
        FloatingLogo.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragL = true
                hasMovedL = false
                dragStartL = input.Position
                startPosL = FloatingLogo.Position
                local conn
                conn = rs.Heartbeat:Connect(function()
                    if not dragL then return end
                    local delta = input.Position - dragStartL
                    if delta.Magnitude > 3 then hasMovedL = true end
                    FloatingLogo.Position = ud2(startPosL.X.Scale, startPosL.X.Offset + delta.X, startPosL.Y.Scale, startPosL.Y.Offset + delta.Y)
                end)
                local endConn
                endConn = uis.InputEnded:Connect(function(ie)
                    if ie.UserInputType == input.UserInputType then
                        dragL = false
                        if conn then conn:Disconnect() end
                        if endConn then endConn:Disconnect() end
                    end
                end)
            end
        end)
        FloatingLogo.MouseButton1Click:Connect(function()
            if not hasMovedL then
                isGuiOpen = not isGuiOpen
                MainFrame.Visible = isGuiOpen
                if not isGuiOpen then
                    for drop, _ in pairs(activeDropdowns) do
                        if drop and drop.Parent then drop.Parent:Destroy(); activeDropdowns[drop] = nil end
                    end
                end
            end
        end)
    end
    local colorIndex = 1
    local rgbAnimation
    rgbAnimation = rs.Heartbeat:Connect(function()
        colorIndex = colorIndex + 0.008
        if colorIndex > #RGBColors then colorIndex = 1 end
        local currentColor = RGBColors[math.floor(colorIndex)]
        local nextColor = RGBColors[math.floor(colorIndex) % #RGBColors + 1]
        local lerpFactor = colorIndex - math.floor(colorIndex)
        rgbBorder.Color = currentColor:Lerp(nextColor, lerpFactor)
        if logoBorder then logoBorder.Color = rgbBorder.Color end 
        local tTime = tick()
        mainGradient.Offset = v2(math.sin(tTime * 0.5) * 0.7, math.cos(tTime * 0.5) * 0.7)
    end)
    local TitleBar = inst("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = ud2(1, 0, 0, ELEMENT_SIZES.TitleBar)
    TitleBar.BackgroundColor3 = Colors.SecondaryBg
    TitleBar.BackgroundTransparency = 0.1
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    inst("UICorner", TitleBar).CornerRadius = ud(0, 8, 0, 0)
    local TitleLabel = inst("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = ud2(0.6, 0, 1, 0)
    TitleLabel.Position = ud2(0, 8, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Window.Title
    TitleLabel.TextColor3 = Colors.Text
    TitleLabel.TextSize = 14
    TitleLabel.Font = Fonts.Bold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextScaled = true
    TitleLabel.TextWrapped = true
    local titleConst = inst("UITextSizeConstraint")
    titleConst.MaxTextSize = 14
    titleConst.MinTextSize = 8
    titleConst.Parent = TitleLabel
    TitleLabel.Parent = TitleBar
    local Controls = inst("Frame")
    Controls.Name = "Controls"
    Controls.Size = ud2(0, 40, 1, 0)
    Controls.Position = ud2(1, -45, 0, 0)
    Controls.BackgroundTransparency = 1
    Controls.Parent = TitleBar
    local function AddStroke(parent)
        local s = inst("UIStroke")
        s.Color = Colors.Border
        s.Thickness = 1
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.Parent = parent
        return s
    end
    local function AddSubtleGradient(parent)
        local g = inst("UIGradient")
        g.Color = cseq({csk(0, c3(255,255,255)), csk(1, c3(127,127,127))})
        g.Rotation = 90
        g.Parent = parent
        return g
    end
    local MinimizeButton = inst("TextButton")
    MinimizeButton.Name = "Minimize"
    MinimizeButton.Size = ud2(0, 18, 0, 18)
    MinimizeButton.Position = ud2(0, 0, 0.5, -9)
    MinimizeButton.BackgroundColor3 = Colors.ControlButton
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Colors.TextInactive
    MinimizeButton.TextSize = 16
    MinimizeButton.Font = Fonts.Bold
    MinimizeButton.AutoButtonColor = false
    MinimizeButton:SetAttribute("IsMinimized", false)
    inst("UICorner", MinimizeButton).CornerRadius = ud(1, 0)
    AddStroke(MinimizeButton)
    MinimizeButton.Parent = Controls
    if logoId then MinimizeButton.Visible = false end
    local CloseButton = inst("TextButton")
    CloseButton.Name = "Close"
    CloseButton.Size = ud2(0, 18, 0, 18)
    CloseButton.Position = ud2(0, 22, 0.5, -9) 
    CloseButton.BackgroundColor3 = Colors.ControlButton
    CloseButton.Text = ">"
    CloseButton.TextColor3 = Colors.TextInactive
    CloseButton.TextSize = 14
    CloseButton.Font = Fonts.Bold
    CloseButton.AutoButtonColor = false
    inst("UICorner", CloseButton).CornerRadius = ud(1, 0)
    AddStroke(CloseButton)
    CloseButton.Parent = Controls
    local TabsScrollFrame = inst("ScrollingFrame")
    TabsScrollFrame.Name = "TabsScroll"
    TabsScrollFrame.Size = ud2(1, 0, 0, ELEMENT_SIZES.TabHeight)
    TabsScrollFrame.Position = ud2(0, 0, 0, ELEMENT_SIZES.TitleBar + 8)
    TabsScrollFrame.BackgroundTransparency = 1
    TabsScrollFrame.BorderSizePixel = 0
    TabsScrollFrame.ScrollBarThickness = 0
    TabsScrollFrame.ScrollBarImageColor3 = Colors.Border
    TabsScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    TabsScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X
    TabsScrollFrame.Parent = MainFrame
    local TabsContainer = inst("Frame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Size = ud2(0, 0, 1, 0)
    TabsContainer.AutomaticSize = Enum.AutomaticSize.X
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.Parent = TabsScrollFrame
    local TabsPadding = inst("UIPadding")
    TabsPadding.PaddingLeft = ud(0, 8)
    TabsPadding.PaddingRight = ud(0, 4)
    TabsPadding.Parent = TabsContainer
    local TabsList = inst("UIListLayout")
    TabsList.FillDirection = Enum.FillDirection.Horizontal
    TabsList.Padding = ud(0, 4)
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.VerticalAlignment = Enum.VerticalAlignment.Center
    TabsList.Parent = TabsContainer
    local ContentArea = inst("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = ud2(1, -16, 1, -(ELEMENT_SIZES.TitleBar + ELEMENT_SIZES.TabHeight + 20))
    ContentArea.Position = ud2(0, 8, 0, ELEMENT_SIZES.TitleBar + ELEMENT_SIZES.TabHeight + 12)
    ContentArea.BackgroundColor3 = Colors.SecondaryBg
    ContentArea.BackgroundTransparency = 0.4
    ContentArea.ClipsDescendants = true
    ContentArea.Parent = MainFrame
    inst("UICorner", ContentArea).CornerRadius = ud(0, 6)
    local caStroke = inst("UIStroke")
    caStroke.Color = Colors.Border
    caStroke.Thickness = 1
    caStroke.Transparency = 0.5
    caStroke.Parent = ContentArea
    function Window:SetFooter(...)
        local text = ""
        local icon, shape = nil, 1
        for _, arg in ipairs({...}) do
            if type(arg) == "number" then
                if arg == 1 or arg == 2 then shape = arg
                elseif arg > 999 then icon = arg end
            elseif type(arg) == "string" then
                if tonumber(arg) then
                    local num = tonumber(arg)
                    if num == 1 or num == 2 then shape = num
                    elseif num > 999 then icon = num end
                elseif arg:match("rbxassetid") or arg:match("rbxthumb") then icon = arg
                else text = arg end
            end
        end
        if MainFrame:FindFirstChild("FooterFrame") then MainFrame.FooterFrame:Destroy() end
        local FooterFrame = inst("Frame")
        FooterFrame.Name = "FooterFrame"
        FooterFrame.Size = ud2(1, -16, 0, 14)
        FooterFrame.Position = ud2(0, 8, 1, -16)
        FooterFrame.BackgroundTransparency = 1 
        FooterFrame.Parent = MainFrame
        ContentArea.Size = ud2(1, -16, 1, -(ELEMENT_SIZES.TitleBar + ELEMENT_SIZES.TabHeight + 30))
        local tOff = 8
        if icon then
            tOff = 20
            local img = inst("ImageLabel")
            img.Size = ud2(0, 12, 0, 12)
            img.Position = ud2(0, 4, 0.5, -6)
            img.BackgroundTransparency = 1
            img.Image = tonumber(icon) and "rbxthumb://type=Asset&id="..icon.."&w=150&h=150" or icon
            img.ScaleType = Enum.ScaleType.Fit
            inst("UICorner", img).CornerRadius = shape == 2 and ud(0,4) or ud(1,0)
            img.Parent = FooterFrame
            task.spawn(function() pcall(function() cp:PreloadAsync({img}) end) end)
        end
        local lbl = inst("TextLabel")
        lbl.Size = ud2(1, -tOff - 4, 1, 0)
        lbl.Position = ud2(0, tOff, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text or ""
        lbl.TextColor3 = Colors.TextInactive
        lbl.TextSize = 10
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextScaled = true
        lbl.TextWrapped = true
        local const = inst("UITextSizeConstraint")
        const.MaxTextSize = 10
        const.MinTextSize = 8
        const.Parent = lbl
        lbl.Parent = FooterFrame
    end
    local function CreateClickEffect(button)
        local eff = inst("Frame")
        eff.Name = "ClickEffect"
        eff.Size = ud2(1, 0, 1, 0)
        eff.BackgroundColor3 = Colors.Accent
        eff.BackgroundTransparency = 0.7
        eff.ZIndex = -1
        local c = button:FindFirstChildWhichIsA("UICorner")
        inst("UICorner", eff).CornerRadius = c and c.CornerRadius or ud(0, 6)
        eff.Parent = button
        ts:Create(eff, ti(0.3), { BackgroundTransparency = 1 }):Play()
        task.delay(0.3, function() eff:Destroy() end)
    end
    local function SetupButtonHover(btn, isCtrl)
        if isCtrl then
            btn.MouseEnter:Connect(function()
                btn.BackgroundColor3 = (btn.Name == "Close") and Colors.CloseButton or Colors.Hover
                btn.TextColor3 = Colors.Text
            end)
            btn.MouseLeave:Connect(function()
                btn.BackgroundColor3 = Colors.ControlButton
                btn.TextColor3 = Colors.TextInactive
            end)
            return
        end
        btn.MouseEnter:Connect(function() ts:Create(btn, ti(0.2), {BackgroundColor3 = Colors.Hover}):Play() end)
        btn.MouseLeave:Connect(function() ts:Create(btn, ti(0.2), {BackgroundColor3 = Colors.Button}):Play() end)
    end
    SetupButtonHover(CloseButton, true)
    SetupButtonHover(MinimizeButton, true)
    local dragging = false
    local dragStart, startPos
    local function update(input)
        if not dragging then return end
        guiHasBeenDragged = true 
        local delta = input.Position - dragStart
        MainFrame.Position = ud2(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        for drop, _ in pairs(activeDropdowns) do
            if drop then drop.Position = ud2(0, MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X + 10, 0, MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y - drop.Size.Y.Offset) end
        end
    end
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            if input.UserInputType == Enum.UserInputType.Touch then MainFrame.Active = true end
            local conn
            conn = rs.Heartbeat:Connect(function() update(input) end)
            local function onInputEnded(inputEnded)
                if inputEnded.UserInputType == input.UserInputType then
                    dragging = false
                    if conn then conn:Disconnect() end
                end
            end
            uis.InputEnded:Connect(onInputEnded)
        end
    end)
    CloseButton.MouseButton1Click:Connect(function()
        CreateClickEffect(CloseButton)
        if rgbAnimation then rgbAnimation:Disconnect() end
        ScreenGui:Destroy()
    end)
    MinimizeButton.MouseButton1Click:Connect(function()
        CreateClickEffect(MinimizeButton)
        local isMin = MinimizeButton:GetAttribute("IsMinimized")
        if not isMin then
            MinimizeButton:SetAttribute("IsMinimized", true)
            for drop, _ in pairs(activeDropdowns) do
                if drop and drop.Parent then drop.Parent:Destroy(); activeDropdowns[drop] = nil end
            end
            MainFrame.Size = ud2(0, UI_SIZE.Width, 0, ELEMENT_SIZES.TitleBar)
            TabsScrollFrame.Visible = false
            ContentArea.Visible = false
            if MainFrame:FindFirstChild("FooterFrame") then MainFrame.FooterFrame.Visible = false end
        else
            MinimizeButton:SetAttribute("IsMinimized", false)
            MainFrame.Size = ud2(0, UI_SIZE.Width, 0, UI_SIZE.Height)
            TabsScrollFrame.Visible = true
            ContentArea.Visible = true
            if MainFrame:FindFirstChild("FooterFrame") then MainFrame.FooterFrame.Visible = true end
        end
    end)
    function Window:NewSection(name)
        local Section = {Name = name}
        local TabBtn = inst("TextButton")
        TabBtn.Name = name .. "_Tab"
        TabBtn.Size = ud2(0, 65, 0, 24)
        TabBtn.BackgroundColor3 = Colors.TabInactive
        TabBtn.Text = name
        TabBtn.TextColor3 = Colors.TextInactive
        TabBtn.TextSize = 11
        TabBtn.Font = Fonts.Bold
        TabBtn.AutoButtonColor = false
        TabBtn.LayoutOrder = #Window.Sections + 1
        TabBtn.TextScaled = true 
        TabBtn.TextWrapped = true
        local tabConst = inst("UITextSizeConstraint")
        tabConst.MaxTextSize = 11
        tabConst.MinTextSize = 7
        tabConst.Parent = TabBtn
        inst("UICorner", TabBtn).CornerRadius = ud(0, 5)
        AddStroke(TabBtn)
        AddSubtleGradient(TabBtn)
        TabBtn.Parent = TabsContainer
        TabBtn.MouseEnter:Connect(function()
            if Window.CurrentSection ~= Section then ts:Create(TabBtn, ti(0.2), {BackgroundColor3 = Colors.Hover}):Play() end
        end)
        TabBtn.MouseLeave:Connect(function()
            if Window.CurrentSection ~= Section then ts:Create(TabBtn, ti(0.2), {BackgroundColor3 = Colors.TabInactive}):Play() end
        end)
        local SecFrame = inst("ScrollingFrame")
        SecFrame.Name = name .. "_Content"
        SecFrame.Size = ud2(1, 0, 1, 0)
        SecFrame.BackgroundTransparency = 1
        SecFrame.BorderSizePixel = 0
        SecFrame.ScrollBarThickness = 3
        SecFrame.ScrollBarImageColor3 = Colors.Disabled
        SecFrame.Visible = false
        SecFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        SecFrame.CanvasSize = ud2(0, 0, 0, 0)
        inst("UICorner", SecFrame).CornerRadius = ud(0, 6)
        local secList = inst("UIListLayout")
        secList.Padding = ud(0, ELEMENT_SIZES.SectionSpacing)
        secList.SortOrder = Enum.SortOrder.LayoutOrder
        secList.Parent = SecFrame
        local secPad = inst("UIPadding")
        secPad.PaddingTop = ud(0, 6)
        secPad.PaddingBottom = ud(0, 6)
        secPad.PaddingLeft = ud(0, 8)
        secPad.PaddingRight = ud(0, 8)
        secPad.Parent = SecFrame
        SecFrame.Parent = ContentArea
        secList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            SecFrame.CanvasSize = ud2(0, 0, 0, secList.AbsoluteContentSize.Y + 12)
        end)
        if #Window.Sections == 0 then
            TabBtn.BackgroundColor3 = Colors.TabActive
            TabBtn.TextColor3 = Colors.Text
            SecFrame.Visible = true
            Window.CurrentSection = Section
        end
        TabBtn.MouseButton1Click:Connect(function()
            CreateClickEffect(TabBtn)
            for _, tab in pairs(TabsContainer:GetChildren()) do
                if tab:IsA("TextButton") then
                    tab.BackgroundColor3 = Colors.TabInactive
                    tab.TextColor3 = Colors.TextInactive
                end
            end
            for _, frame in pairs(ContentArea:GetChildren()) do
                if frame:IsA("ScrollingFrame") then frame.Visible = false end
            end
            TabBtn.BackgroundColor3 = Colors.TabActive
            TabBtn.TextColor3 = Colors.Text
            SecFrame.Visible = true
            Window.CurrentSection = Section
        end)
        function Section:CreateButton(bname, callback)
            local Btn = inst("TextButton")
            Btn.Name = bname
            Btn.Size = ud2(1, 0, 0, ELEMENT_SIZES.ButtonHeight)
            Btn.BackgroundColor3 = Colors.Button
            Btn.Text = bname
            Btn.TextColor3 = Colors.Text
            Btn.TextSize = 13
            Btn.Font = Fonts.Bold
            Btn.AutoButtonColor = false
            Btn.LayoutOrder = #SecFrame:GetChildren()
            Btn.TextScaled = true 
            Btn.TextWrapped = true
            local btnConst = inst("UITextSizeConstraint")
            btnConst.MaxTextSize = 13
            btnConst.MinTextSize = 8
            btnConst.Parent = Btn
            inst("UICorner", Btn).CornerRadius = ud(0, 5)
            AddStroke(Btn)
            AddSubtleGradient(Btn)
            Btn.Parent = SecFrame
            SetupButtonHover(Btn, false)
            Btn.MouseButton1Click:Connect(function() CreateClickEffect(Btn); if callback then callback() end end)
            return Btn
        end
        function Section:CreateToggle(tname, default, callback)
            local Tgl = inst("Frame")
            Tgl.Name = tname
            Tgl.Size = ud2(1, 0, 0, ELEMENT_SIZES.ToggleHeight)
            Tgl.BackgroundTransparency = 1
            Tgl.LayoutOrder = #SecFrame:GetChildren()
            local Lbl = inst("TextLabel")
            Lbl.Size = ud2(0.7, 0, 1, 0)
            Lbl.BackgroundTransparency = 1
            Lbl.Text = tname
            Lbl.TextColor3 = Colors.Text
            Lbl.TextSize = 13
            Lbl.Font = Fonts.Bold
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
            Lbl.TextScaled = true 
            Lbl.TextWrapped = true
            local tglConst = inst("UITextSizeConstraint")
            tglConst.MaxTextSize = 13
            tglConst.MinTextSize = 8
            tglConst.Parent = Lbl
            Lbl.Parent = Tgl
            local TglBtn = inst("TextButton")
            TglBtn.Name = "Toggle"
            TglBtn.Size = ud2(0, 40, 0, 20)
            TglBtn.Position = ud2(1, -42, 0.5, -10)
            TglBtn.BackgroundColor3 = default and Colors.ToggleOn or Colors.ToggleOff
            TglBtn.Text = ""
            TglBtn.AutoButtonColor = false
            inst("UICorner", TglBtn).CornerRadius = ud(1, 0)
            AddStroke(TglBtn)
            AddSubtleGradient(TglBtn)
            TglBtn.Parent = Tgl
            local Circ = inst("Frame")
            Circ.Name = "Circle"
            Circ.Size = ud2(0, 16, 0, 16)
            Circ.Position = ud2(0, default and 21 or 2, 0.5, -8)
            Circ.BackgroundColor3 = Colors.Text
            inst("UICorner", Circ).CornerRadius = ud(1, 0)
            Circ.Parent = TglBtn
            Tgl.Parent = SecFrame
            local state = default or false
            TglBtn.MouseEnter:Connect(function() ts:Create(TglBtn, ti(0.2), {BackgroundColor3 = state and Colors.Accent or Colors.Hover}):Play() end)
            TglBtn.MouseLeave:Connect(function() ts:Create(TglBtn, ti(0.2), {BackgroundColor3 = state and Colors.ToggleOn or Colors.ToggleOff}):Play() end)
            TglBtn.MouseButton1Click:Connect(function()
                CreateClickEffect(TglBtn)
                state = not state
                ts:Create(Circ, ti(0.2), {Position = ud2(0, state and 21 or 2, 0.5, -8)}):Play()
                ts:Create(TglBtn, ti(0.2), {BackgroundColor3 = state and Colors.ToggleOn or Colors.ToggleOff}):Play()
                if callback then callback(state) end
            end)
            return Tgl
        end
        function Section:CreateSlider(sname, min, max, default, callback)
            local Sldr = inst("Frame")
            Sldr.Name = sname
            Sldr.Size = ud2(1, 0, 0, ELEMENT_SIZES.SliderHeight)
            Sldr.BackgroundTransparency = 1
            Sldr.LayoutOrder = #SecFrame:GetChildren()
            local Lbl = inst("TextLabel")
            Lbl.Size = ud2(1, 0, 0, 18)
            Lbl.BackgroundTransparency = 1
            Lbl.Text = sname .. ": " .. default
            Lbl.TextColor3 = Colors.Text
            Lbl.TextSize = 13
            Lbl.Font = Fonts.Bold
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
            Lbl.TextScaled = true 
            Lbl.TextWrapped = true
            local sldrConst = inst("UITextSizeConstraint")
            sldrConst.MaxTextSize = 13
            sldrConst.MinTextSize = 8
            sldrConst.Parent = Lbl
            Lbl.Parent = Sldr
            local Trk = inst("Frame")
            Trk.Name = "Track"
            Trk.Size = ud2(1, -16, 0, 4)
            Trk.Position = ud2(0, 8, 0, 22)
            Trk.BackgroundColor3 = Colors.ToggleOff
            inst("UICorner", Trk).CornerRadius = ud(1, 0)
            Trk.Parent = Sldr
            local Fill = inst("Frame")
            Fill.Name = "Fill"
            Fill.Size = ud2((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Colors.Slider
            inst("UICorner", Fill).CornerRadius = ud(1, 0)
            Fill.Parent = Trk
            local Btn = inst("TextButton")
            Btn.Name = "SliderButton"
            Btn.Size = ud2(0, 16, 0, 16)
            Btn.Position = ud2(Fill.Size.X.Scale, -8, 0.5, -8)
            Btn.BackgroundColor3 = Colors.Text
            Btn.Text = ""
            Btn.AutoButtonColor = false
            inst("UICorner", Btn).CornerRadius = ud(1, 0)
            Btn.Parent = Trk
            Sldr.Parent = SecFrame
            local draggingSldr = false
            Btn.MouseButton1Down:Connect(function() draggingSldr = true end)
            Trk.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingSldr = true
                    local pct = math.clamp((input.Position.X - Trk.AbsolutePosition.X) / Trk.AbsoluteSize.X, 0, 1)
                    Btn.Position = ud2(pct, -8, 0.5, -8)
                    Fill.Size = ud2(pct, 0, 1, 0)
                    local val = math.floor(min + (pct * (max - min)))
                    Lbl.Text = sname .. ": " .. val
                    if callback then callback(val) end
                end
            end)
            uis.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSldr = false end
            end)
            uis.InputChanged:Connect(function(input)
                if draggingSldr and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local pct = math.clamp((input.Position.X - Trk.AbsolutePosition.X) / Trk.AbsoluteSize.X, 0, 1)
                    Btn.Position = ud2(pct, -8, 0.5, -8)
                    Fill.Size = ud2(pct, 0, 1, 0)
                    local val = math.floor(min + (pct * (max - min)))
                    Lbl.Text = sname .. ": " .. val
                    if callback then callback(val) end
                end
            end)
            return Sldr
        end
        function Section:CreateDropdown(dname, opts, default, callback)
            local Drop = inst("Frame")
            Drop.Name = dname
            Drop.Size = ud2(1, 0, 0, ELEMENT_SIZES.DropdownHeight)
            Drop.BackgroundTransparency = 1
            Drop.ClipsDescendants = false
            Drop.LayoutOrder = #SecFrame:GetChildren()
            local DBtn = inst("TextButton")
            DBtn.Name = "DropdownButton"
            DBtn.Size = ud2(1, 0, 0, ELEMENT_SIZES.DropdownHeight)
            DBtn.BackgroundColor3 = Colors.Button
            DBtn.Text = opts[default] or opts[1] or "Select"
            DBtn.TextColor3 = Colors.Text
            DBtn.TextSize = 13
            DBtn.Font = Fonts.Bold
            DBtn.AutoButtonColor = false
            DBtn.TextScaled = true 
            DBtn.TextWrapped = true
            local dbtnConst = inst("UITextSizeConstraint")
            dbtnConst.MaxTextSize = 13
            dbtnConst.MinTextSize = 8
            dbtnConst.Parent = DBtn
            inst("UICorner", DBtn).CornerRadius = ud(0, 5)
            AddStroke(DBtn)
            AddSubtleGradient(DBtn)
            DBtn.Parent = Drop
            local DIcon = inst("TextLabel")
            DIcon.Name = "Icon"
            DIcon.Size = ud2(0, 20, 1, 0)
            DIcon.Position = ud2(1, -25, 0, 0)
            DIcon.BackgroundTransparency = 1
            DIcon.Text = ">"
            DIcon.TextColor3 = Colors.TextInactive
            DIcon.TextSize = 16
            DIcon.Font = Fonts.Bold
            DIcon.Parent = DBtn
            Drop.Parent = SecFrame
            SetupButtonHover(DBtn, false)
            local open, OptCont, OptGui, clickConn, dropConn = false, nil, nil, nil, nil
            local function CloseOptions()
                if OptCont then activeDropdowns[OptCont] = nil end
                if OptGui then OptGui:Destroy(); OptGui = nil end
                OptCont = nil
                if dropConn then dropConn:Disconnect(); dropConn = nil end
                if clickConn then clickConn:Disconnect(); clickConn = nil end
                ts:Create(DIcon, ti(0.2), {Rotation = 0}):Play()
                open = false
            end
            DBtn.MouseButton1Click:Connect(function()
                CreateClickEffect(DBtn)
                if open then CloseOptions(); return end
                open = true
                ts:Create(DIcon, ti(0.2), {Rotation = 90}):Play()
                OptGui = inst("ScreenGui")
                OptGui.Name = genHash()
                OptGui:SetAttribute("OxDrop", true)
                OptGui.ResetOnSpawn = false
                OptGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                OptGui.DisplayOrder = 12 
                OptGui.Parent = ScreenGui
                local h = math.clamp((#opts * 28) + ((#opts - 1) * 4) + 12, 40, 160)
                OptCont = inst("ScrollingFrame")
                OptCont.Name = "OptCont"
                OptCont.Size = ud2(0, 160, 0, h)
                OptCont.Position = ud2(0, MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X + 10, 0, MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y - h)
                OptCont.BackgroundColor3 = c3(255, 255, 255)
                OptCont.BorderSizePixel = 0
                OptCont.ZIndex = 100
                OptCont.ScrollBarThickness = 3
                OptCont.ScrollBarImageColor3 = Colors.Disabled
                OptCont.AutomaticCanvasSize = Enum.AutomaticSize.Y
                OptCont.CanvasSize = ud2(0, 0, 0, 0)
                inst("UICorner", OptCont).CornerRadius = ud(0, 8)
                local dBord = inst("UIStroke")
                dBord.Thickness = 2
                dBord.Color = rgbBorder.Color
                dBord.Parent = OptCont
                local dGrad = inst("UIGradient")
                dGrad.Color = mainGradient.Color
                dGrad.Rotation = 45
                dGrad.Parent = OptCont
                local l = inst("UIListLayout")
                l.SortOrder = Enum.SortOrder.LayoutOrder
                l.Padding = ud(0, 4)
                l.Parent = OptCont
                local pad = inst("UIPadding")
                pad.PaddingTop, pad.PaddingBottom, pad.PaddingLeft, pad.PaddingRight = ud(0,6), ud(0,6), ud(0,6), ud(0,6)
                pad.Parent = OptCont
                for _, opt in pairs(opts) do
                    local oBtn = inst("TextButton")
                    oBtn.Name = opt
                    oBtn.Size = ud2(1, 0, 0, 28)
                    oBtn.BackgroundColor3 = Colors.Button
                    oBtn.Text = opt
                    oBtn.TextColor3 = Colors.Text
                    oBtn.TextSize = 13
                    oBtn.TextScaled = true
                    oBtn.TextWrapped = true
                    oBtn.Font = Fonts.Bold
                    oBtn.AutoButtonColor = false
                    oBtn.ZIndex = 101
                    local con = inst("UITextSizeConstraint")
                    con.MaxTextSize = 13
                    con.MinTextSize = 8
                    con.Parent = oBtn
                    inst("UICorner", oBtn).CornerRadius = ud(0, 6)
                    AddStroke(oBtn)
                    AddSubtleGradient(oBtn)
                    oBtn.Parent = OptCont
                    oBtn.MouseEnter:Connect(function() oBtn.BackgroundColor3 = Colors.Hover end)
                    oBtn.MouseLeave:Connect(function() oBtn.BackgroundColor3 = Colors.Button end)
                    oBtn.MouseButton1Click:Connect(function()
                        CreateClickEffect(oBtn)
                        DBtn.Text = opt
                        if callback then callback(opt) end
                        CloseOptions()
                    end)
                end
                OptCont.Parent = OptGui
                activeDropdowns[OptCont] = true
                dropConn = rs.Heartbeat:Connect(function()
                    if OptCont and open then
                        OptCont.Position = ud2(0, MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X + 10, 0, MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y - h)
                        dBord.Color = rgbBorder.Color
                        dGrad.Offset = v2(math.sin(tick() * 0.5) * 0.7, math.cos(tick() * 0.5) * 0.7)
                    end
                end)
                clickConn = uis.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        local m = input.Position
                        local bp, bs = DBtn.AbsolutePosition, DBtn.AbsoluteSize
                        local cp, cs = OptCont and OptCont.AbsolutePosition, OptCont and OptCont.AbsoluteSize
                        local inBtn = m.X >= bp.X and m.X <= bp.X + bs.X and m.Y >= bp.Y and m.Y <= bp.Y + bs.Y
                        local inCont = cp and cs and m.X >= cp.X and m.X <= cp.X + cs.X and m.Y >= cp.Y and m.Y <= cp.Y + cs.Y
                        if not inBtn and not inCont then CloseOptions() end
                    end
                end)
            end)
            return Drop
        end
        function Section:CreateTextbox(boxName, callback)
            local Tbox = inst("Frame")
            Tbox.Name = boxName
            Tbox.Size = ud2(1, 0, 0, ELEMENT_SIZES.TextboxHeight)
            Tbox.BackgroundTransparency = 1
            Tbox.LayoutOrder = #SecFrame:GetChildren()
            local Inp = inst("TextBox")
            Inp.Name = "Input"
            Inp.Size = ud2(1, 0, 1, 0)
            Inp.BackgroundColor3 = Colors.Button
            Inp.Text = ""
            Inp.PlaceholderText = "Type"
            Inp.TextColor3 = Colors.Text
            Inp.PlaceholderColor3 = Colors.TextInactive
            Inp.TextSize = 13
            Inp.Font = Enum.Font.GothamMedium
            Inp.TextXAlignment = Enum.TextXAlignment.Center
            Inp.TextScaled = true 
            Inp.TextWrapped = true
            local inpConst = inst("UITextSizeConstraint")
            inpConst.MaxTextSize = 13
            inpConst.MinTextSize = 8
            inpConst.Parent = Inp
            inst("UICorner", Inp).CornerRadius = ud(0, 5)
            AddStroke(Inp)
            AddSubtleGradient(Inp)
            Inp.Parent = Tbox
            local pad = inst("UIPadding")
            pad.PaddingLeft = ud(0, 10)
            pad.PaddingRight = ud(0, 10)
            pad.Parent = Inp
            Tbox.Parent = SecFrame
            Inp.FocusLost:Connect(function() if callback then callback(Inp.Text) end end)
            return Tbox
        end
        table.insert(Window.Sections, Section)
        return Section
    end
    MainFrame.Parent = ScreenGui
    pcall(function() ScreenGui.Parent = core end)
    if not ScreenGui.Parent then ScreenGui.Parent = lplr:WaitForChild("PlayerGui") end
    table.insert(self.Windows, Window)
    return Window
end
return OxireunUI.new()
