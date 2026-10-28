--[[
    AetherX UI  -  mobile friendly Roblox UI library

    local UI  = loadstring(...)()
    local Win = UI:NewWindow("Title", [logoId], [1|2], [themeName])
    local Sec = Win:NewSection("Main")

    Sec:CreateButton(name, function() end)
    Sec:CreateToggle(name, default, function(state) end)
    Sec:CreateSlider(name, min, max, default, function(value) end)
    Sec:CreateDropdown(name, options, defaultIndex, function(option) end)
    Sec:CreateTextbox(name, function(text) end)
    Win:SetFooter("text", [iconId], [1|2])
    UI:SendNotification(title, text, duration, [iconId], [1|2], [themeName])

    Themes: aether (default), purple, black, grey, red, blue, green, pink, orange, yellow
    _G.MultiGui = true  (or _G.MultiUI / _G.AetherXMulti) allows several windows at once
]]

local AetherX = {}
AetherX.__index = AetherX

local inst, ud2, ud, c3, v2 = Instance.new, UDim2.new, UDim.new, Color3.fromRGB, Vector2.new
local ti, cseq, csk = TweenInfo.new, ColorSequence.new, ColorSequenceKeypoint.new
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local cp = game:GetService("ContentProvider")
local plrs = game:GetService("Players")
local txtSvc = game:GetService("TextService")
local hs = game:GetService("HttpService")
local lplr = plrs.LocalPlayer

local core
do
    local ok, host = pcall(function() return (gethui and gethui()) or game:GetService("CoreGui") end)
    core = (ok and host) or game:GetService("CoreGui")
end

local WHITE = c3(255, 255, 255)
local F = {Bold = Enum.Font.GothamBold, Med = Enum.Font.GothamMedium, Reg = Enum.Font.Gotham}
local UI_SIZE = {Width = 300, Height = 320}
local TITLE_H, TAB_H, ROW_H = 38, 30, 36

----------------------------------------------------------------------
-- Themes
----------------------------------------------------------------------
local function theme(bg, a1, a2)
    return {
        Bg = bg,
        Surface = bg:Lerp(WHITE, 0.06),
        Raised = bg:Lerp(WHITE, 0.12),
        Stroke = bg:Lerp(WHITE, 0.18),
        Accent = a1,
        Accent2 = a2,
        Text = c3(238, 241, 250),
        Sub = c3(150, 158, 178),
        Danger = c3(235, 72, 92),
    }
end

local Themes = {
    aether = theme(c3(12, 13, 20), c3(124, 92, 255), c3(0, 214, 255)),
    purple = theme(c3(15, 12, 22), c3(150, 40, 255), c3(210, 80, 235)),
    black  = theme(c3(8, 8, 8), c3(225, 225, 225), c3(140, 140, 140)),
    grey   = theme(c3(30, 31, 36), c3(195, 195, 205), c3(140, 140, 152)),
    red    = theme(c3(18, 10, 11), c3(255, 60, 70), c3(255, 125, 80)),
    blue   = theme(c3(9, 16, 22), c3(0, 200, 255), c3(60, 120, 255)),
    green  = theme(c3(9, 18, 12), c3(40, 230, 120), c3(160, 255, 90)),
    pink   = theme(c3(20, 10, 16), c3(255, 60, 160), c3(255, 135, 205)),
    orange = theme(c3(20, 12, 9), c3(255, 120, 30), c3(255, 190, 60)),
    yellow = theme(c3(19, 18, 8), c3(255, 215, 40), c3(255, 160, 40)),
}
local lastTheme = Themes.aether

----------------------------------------------------------------------
-- Helpers
----------------------------------------------------------------------
local function genHash()
    return (hs:GenerateGUID(false):gsub("-", ""))
end

local function make(class, props)
    local o = inst(class)
    local parent
    for k, v in pairs(props or {}) do
        if k == "Parent" then parent = v else o[k] = v end
    end
    if parent then o.Parent = parent end
    return o
end

local function tween(o, t, props, style)
    local tw = ts:Create(o, ti(t, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tw:Play()
    return tw
end

local function corner(o, r)
    return make("UICorner", {CornerRadius = (type(r) == "number") and ud(0, r) or r, Parent = o})
end

local function stroke(o, color, thickness, transparency)
    return make("UIStroke", {
        Color = color, Thickness = thickness or 1, Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = o,
    })
end

local function gradient(o, a, b, rot)
    return make("UIGradient", {Color = cseq(a, b), Rotation = rot or 0, Parent = o})
end

local function padding(o, t, b, l, r)
    return make("UIPadding", {
        PaddingTop = ud(0, t), PaddingBottom = ud(0, b),
        PaddingLeft = ud(0, l), PaddingRight = ud(0, r), Parent = o,
    })
end

local function label(props)
    props.BackgroundTransparency = 1
    props.Font = props.Font or F.Med
    props.TextSize = props.TextSize or 13
    props.TextTruncate = props.TextTruncate or Enum.TextTruncate.AtEnd
    return make("TextLabel", props)
end

local function imageUrl(icon)
    return tonumber(icon) and ("rbxthumb://type=Asset&id=" .. icon .. "&w=150&h=150") or icon
end

local function inside(g, p)
    local a, s = g.AbsolutePosition, g.AbsoluteSize
    return p.X >= a.X and p.X <= a.X + s.X and p.Y >= a.Y and p.Y <= a.Y + s.Y
end

local function isPress(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
end

local function findGui(attr)
    for _, root in ipairs({core, lplr and lplr:FindFirstChild("PlayerGui")}) do
        if root then
            for _, v in ipairs(root:GetChildren()) do
                if v:GetAttribute(attr) then return v end
            end
        end
    end
end

local function mount(gui)
    local ok = pcall(function() gui.Parent = core end)
    if not ok or not gui.Parent then gui.Parent = lplr:WaitForChild("PlayerGui") end
end

local function parseSmartArgs(...)
    local id, shape, themeName
    for _, arg in ipairs({...}) do
        if type(arg) == "number" then
            if arg == 1 or arg == 2 then shape = arg
            elseif arg > 999 then id = arg end
        elseif type(arg) == "string" then
            local l = string.lower(arg)
            if Themes[l] then themeName = l
            elseif tonumber(arg) then
                local num = tonumber(arg)
                if num == 1 or num == 2 then shape = num
                elseif num > 999 then id = num end
            elseif arg:match("rbxassetid") or arg:match("rbxthumb") then id = arg end
        end
    end
    return id, shape, themeName
end

----------------------------------------------------------------------
-- Notifications
----------------------------------------------------------------------
local notifOrder = 0

function AetherX:SendNotification(title, text, duration, ...)
    local icon, shape, themeName = parseSmartArgs(...)
    duration = duration or 3
    text = text or "Message"
    local T = Themes[themeName] or lastTheme

    local host = findGui("AxNotif")
    if not host then
        host = make("ScreenGui", {
            Name = genHash(), ResetOnSpawn = false, IgnoreGuiInset = true,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 101,
        })
        host:SetAttribute("AxNotif", true)
        mount(host)
    end

    local stack = host:FindFirstChild("Stack")
    if not stack then
        stack = make("Frame", {
            Name = "Stack", Size = ud2(0, 270, 1, -30), Position = ud2(1, -286, 0, 15),
            BackgroundTransparency = 1, Parent = host,
        })
        make("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = ud(0, 8), Parent = stack,
        })
    end

    local W = 270
    local textX = icon and 58 or 18
    local bodyW = W - textX - 14
    local bounds = txtSvc:GetTextSize(text, 12, F.Reg, v2(bodyW, 9000))
    local textH = math.clamp(bounds.Y, 16, 300)
    local H = math.max(60, 34 + textH + 18)
    notifOrder = notifOrder + 1

    local holder = make("Frame", {
        Name = "Holder", Size = ud2(1, 0, 0, H), BackgroundTransparency = 1,
        LayoutOrder = notifOrder, Parent = stack,
    })
    local card = make("CanvasGroup", {
        Name = "Card", Size = ud2(1, 0, 1, 0), Position = ud2(0, 50, 0, 0),
        BackgroundColor3 = T.Bg, BorderSizePixel = 0, GroupTransparency = 1, Parent = holder,
    })
    corner(card, 10)
    gradient(stroke(card, WHITE, 1.2), T.Accent, T.Accent2, 45)

    local accentBar = make("Frame", {Size = ud2(0, 4, 1, 0), BackgroundColor3 = WHITE, BorderSizePixel = 0, Parent = card})
    gradient(accentBar, T.Accent, T.Accent2, 90)

    if icon then
        local img = make("ImageLabel", {
            Size = ud2(0, 34, 0, 34), Position = ud2(0, 14, 0, 13), BackgroundTransparency = 1,
            Image = imageUrl(icon), ScaleType = Enum.ScaleType.Crop, Parent = card,
        })
        corner(img, shape == 2 and ud(0, 8) or ud(1, 0))
    end

    label({
        Text = title or "Notification", TextColor3 = T.Text, Font = F.Bold, TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = ud2(1, -textX - 14, 0, 18), Position = ud2(0, textX, 0, 9), Parent = card,
    })
    label({
        Text = text, TextColor3 = T.Sub, Font = F.Reg, TextSize = 12, TextWrapped = true,
        TextTruncate = Enum.TextTruncate.None, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Size = ud2(0, bodyW, 0, textH), Position = ud2(0, textX, 0, 30), Parent = card,
    })

    local barBg = make("Frame", {
        Size = ud2(1, 0, 0, 3), Position = ud2(0, 0, 1, -3),
        BackgroundColor3 = T.Raised, BorderSizePixel = 0, Parent = card,
    })
    local barFill = make("Frame", {
        Size = ud2(1, 0, 1, 0), BackgroundColor3 = WHITE, BorderSizePixel = 0, Parent = barBg,
    })
    gradient(barFill, T.Accent, T.Accent2, 0)

    local hit = make("TextButton", {
        Size = ud2(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 10, Parent = card,
    })

    local closed = false
    local function dismiss()
        if closed then return end
        closed = true
        tween(card, 0.25, {GroupTransparency = 1, Position = ud2(0, 50, 0, 0)}, Enum.EasingStyle.Quint)
        task.delay(0.3, function() holder:Destroy() end)
    end
    hit.MouseButton1Click:Connect(dismiss)

    tween(card, 0.35, {GroupTransparency = 0, Position = ud2(0, 0, 0, 0)}, Enum.EasingStyle.Quint)
    task.delay(0.35, function()
        if not closed then
            ts:Create(barFill, ti(duration, Enum.EasingStyle.Linear), {Size = ud2(0, 0, 1, 0)}):Play()
        end
    end)
    task.delay(duration + 0.35, dismiss)
end
AetherX.Notify = AetherX.SendNotification

function AetherX.new()
    local self = setmetatable({}, AetherX)
    self.Windows = {}
    return self
end

----------------------------------------------------------------------
-- Window
----------------------------------------------------------------------
function AetherX:NewWindow(title, ...)
    local logoId, shape, themeName = parseSmartArgs(...)
    local T = Themes[themeName] or lastTheme
    lastTheme = T

    local multi = _G.MultiGui or _G.MultiUI or _G.AetherXMulti or _G.OxireunMulti
    if not multi then
        for _, root in ipairs({core, lplr and lplr:FindFirstChild("PlayerGui")}) do
            if root then
                for _, v in ipairs(root:GetChildren()) do
                    if v:GetAttribute("AxMain") then v:Destroy() end
                end
            end
        end
    end

    local Window = {Title = title or "AetherX UI", Sections = {}, CurrentSection = nil}
    local W, H = UI_SIZE.Width, UI_SIZE.Height

    -- connection bookkeeping -------------------------------------------------
    local conns = {}
    local function track(c) conns[#conns + 1] = c; return c end
    local activeClose
    local function closeActiveDrop() if activeClose then activeClose() end end
    local function cleanup()
        closeActiveDrop()
        for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
        table.clear(conns)
    end

    local Gui = make("ScreenGui", {
        Name = genHash(), ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 10,
    })
    Gui:SetAttribute("AxMain", true)
    Gui.Destroying:Connect(cleanup)

    local Main = make("Frame", {
        Name = "MainWindow", Size = ud2(0, W, 0, H), Position = ud2(0, 10, 0.5, -H / 2),
        BackgroundColor3 = WHITE, BorderSizePixel = 0, ClipsDescendants = true, Active = true,
    })
    gradient(Main, T.Surface, T.Bg, 125)
    corner(Main, 12)
    local mainStroke = stroke(Main, WHITE, 1.5)
    local strokeGrad = make("UIGradient", {
        Color = cseq({csk(0, T.Accent), csk(0.5, T.Accent2), csk(1, T.Accent)}), Parent = mainStroke,
    })

    -- dragging ---------------------------------------------------------------
    local function drag(handle, target, onStart, onMove)
        local dragging, startInput, startMouse, startPos = false, nil, nil, nil
        handle.InputBegan:Connect(function(input)
            if isPress(input) then
                dragging, startInput = true, input
                startMouse, startPos = input.Position, target.Position
                if onStart then onStart() end
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        track(uis.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input == startInput) then
                local d = input.Position - startMouse
                target.Position = ud2(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
                if onMove then onMove(d) end
            end
        end))
    end

    -- floating logo ----------------------------------------------------------
    local logoGrad
    if logoId then
        local Logo = make("ImageButton", {
            Name = "FloatingLogo", Size = ud2(0, 46, 0, 46), Position = ud2(0, 20, 0.5, -23),
            BackgroundColor3 = T.Bg, AutoButtonColor = false, ClipsDescendants = true, Parent = Gui,
        })
        local radius = shape == 2 and ud(0, 10) or ud(1, 0)
        corner(Logo, radius)
        logoGrad = make("UIGradient", {
            Color = cseq({csk(0, T.Accent), csk(0.5, T.Accent2), csk(1, T.Accent)}),
            Parent = stroke(Logo, WHITE, 2),
        })
        local logoImg = make("ImageLabel", {
            Size = ud2(1, 0, 1, 0), BackgroundTransparency = 1, Image = imageUrl(logoId),
            ScaleType = Enum.ScaleType.Crop, Parent = Logo,
        })
        corner(logoImg, radius)
        task.spawn(function() pcall(function() cp:PreloadAsync({logoImg}) end) end)

        local moved = false
        drag(Logo, Logo, function() moved = false end, function(d)
            if d.Magnitude > 3 then moved = true end
        end)
        Logo.MouseButton1Click:Connect(function()
            if moved then return end
            Main.Visible = not Main.Visible
            if not Main.Visible then closeActiveDrop() end
        end)
        task.defer(function()
            task.wait()
            if Logo.Parent and Main.Parent then
                local lp, ls = Logo.AbsolutePosition, Logo.AbsoluteSize
                Main.Position = ud2(0, lp.X + ls.X + 15, 0, lp.Y + ls.Y / 2 - H / 2)
            end
        end)
    end

    track(rs.Heartbeat:Connect(function()
        local rot = (os.clock() * 40) % 360
        strokeGrad.Rotation = rot
        if logoGrad then logoGrad.Rotation = rot end
    end))

    -- title bar --------------------------------------------------------------
    local TitleBar = make("Frame", {Name = "TitleBar", Size = ud2(1, 0, 0, TITLE_H), BackgroundTransparency = 1, Parent = Main})
    local dot = make("Frame", {
        Size = ud2(0, 10, 0, 10), Position = ud2(0, 14, 0.5, -5), BackgroundColor3 = WHITE,
        BorderSizePixel = 0, Parent = TitleBar,
    })
    corner(dot, ud(1, 0))
    gradient(dot, T.Accent, T.Accent2, 45)
    label({
        Name = "Title", Text = Window.Title, TextColor3 = T.Text, Font = F.Bold, TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = ud2(1, -100, 1, 0), Position = ud2(0, 32, 0, 0), Parent = TitleBar,
    })
    make("Frame", {
        Size = ud2(1, -24, 0, 1), Position = ud2(0, 12, 1, -1), BackgroundColor3 = T.Stroke,
        BorderSizePixel = 0, Parent = TitleBar,
    })
    drag(TitleBar, Main, nil, nil)

    local function ctrlButton(name, text, x)
        local b = make("TextButton", {
            Name = name, Size = ud2(0, 22, 0, 22), Position = ud2(1, x, 0.5, -11),
            BackgroundColor3 = T.Raised, Text = text, TextColor3 = T.Sub, Font = F.Bold,
            TextSize = 14, AutoButtonColor = false, Parent = TitleBar,
        })
        corner(b, 6)
        b.MouseEnter:Connect(function()
            tween(b, 0.15, {BackgroundColor3 = name == "Close" and T.Danger or T.Stroke, TextColor3 = T.Text})
        end)
        b.MouseLeave:Connect(function()
            tween(b, 0.15, {BackgroundColor3 = T.Raised, TextColor3 = T.Sub})
        end)
        return b
    end
    local MinBtn = ctrlButton("Minimize", "-", -58)
    local CloseBtn = ctrlButton("Close", "x", -30)
    if logoId then MinBtn.Visible = false end

    -- tabs + content ---------------------------------------------------------
    local Tabs = make("ScrollingFrame", {
        Name = "TabsScroll", Size = ud2(1, -16, 0, TAB_H), Position = ud2(0, 8, 0, TITLE_H + 6),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.X, CanvasSize = ud2(0, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.X, Parent = Main,
    })
    make("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal, Padding = ud(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = Tabs,
    })

    local contentTop = TITLE_H + TAB_H + 12
    local Content = make("Frame", {
        Name = "ContentArea", Position = ud2(0, 8, 0, contentTop), Size = ud2(1, -16, 1, -(contentTop + 8)),
        BackgroundTransparency = 1, ClipsDescendants = true, Parent = Main,
    })

    -- footer -----------------------------------------------------------------
    function Window:SetFooter(...)
        local text, icon, fshape = "", nil, 1
        for _, arg in ipairs({...}) do
            if type(arg) == "number" then
                if arg == 1 or arg == 2 then fshape = arg
                elseif arg > 999 then icon = arg end
            elseif type(arg) == "string" then
                if tonumber(arg) then
                    local num = tonumber(arg)
                    if num == 1 or num == 2 then fshape = num
                    elseif num > 999 then icon = num end
                elseif arg:match("rbxassetid") or arg:match("rbxthumb") then icon = arg
                else text = arg end
            end
        end
        local old = Main:FindFirstChild("FooterFrame")
        if old then old:Destroy() end
        local Foot = make("Frame", {
            Name = "FooterFrame", Size = ud2(1, -24, 0, 16), Position = ud2(0, 12, 1, -22),
            BackgroundTransparency = 1, Visible = Content.Visible, Parent = Main,
        })
        Content.Size = ud2(1, -16, 1, -(contentTop + 30))
        local off = 0
        if icon then
            off = 20
            local img = make("ImageLabel", {
                Size = ud2(0, 14, 0, 14), Position = ud2(0, 0, 0.5, -7), BackgroundTransparency = 1,
                Image = imageUrl(icon), ScaleType = Enum.ScaleType.Crop, Parent = Foot,
            })
            corner(img, fshape == 2 and ud(0, 4) or ud(1, 0))
            task.spawn(function() pcall(function() cp:PreloadAsync({img}) end) end)
        end
        label({
            Text = text, TextColor3 = T.Sub, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
            Size = ud2(1, -off, 1, 0), Position = ud2(0, off, 0, 0), Parent = Foot,
        })
    end

    -- shared element helpers -------------------------------------------------
    local function pulse(obj, back)
        obj.BackgroundColor3 = T.Accent:Lerp(T.Surface, 0.6)
        tween(obj, 0.35, {BackgroundColor3 = back})
    end

    local function hoverable(obj, st)
        obj.MouseEnter:Connect(function()
            tween(obj, 0.15, {BackgroundColor3 = T.Raised})
            if st then tween(st, 0.15, {Color = T.Accent}) end
        end)
        obj.MouseLeave:Connect(function()
            tween(obj, 0.15, {BackgroundColor3 = T.Surface})
            if st then tween(st, 0.15, {Color = T.Stroke}) end
        end)
    end

    -- buttons: close / minimize ----------------------------------------------
    CloseBtn.MouseButton1Click:Connect(function()
        cleanup()
        Gui:Destroy()
    end)

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        closeActiveDrop()
        local foot = Main:FindFirstChild("FooterFrame")
        if minimized then
            Tabs.Visible, Content.Visible = false, false
            if foot then foot.Visible = false end
            tween(Main, 0.25, {Size = ud2(0, W, 0, TITLE_H)}, Enum.EasingStyle.Quint)
        else
            Tabs.Visible, Content.Visible = true, true
            if foot then foot.Visible = true end
            tween(Main, 0.25, {Size = ud2(0, W, 0, H)}, Enum.EasingStyle.Quint)
        end
    end)

    function Window:Destroy()
        cleanup()
        Gui:Destroy()
    end

    ------------------------------------------------------------------------
    -- Sections (tabs)
    ------------------------------------------------------------------------
    function Window:NewSection(name)
        name = tostring(name or "Section")
        local Section = {Name = name}
        local order = 0
        local function nextOrder() order = order + 1; return order end
        local isFirst = #Window.Sections == 0

        local tabW = txtSvc:GetTextSize(name, 12, F.Bold, v2(1000, 30)).X + 28
        local Tab = make("TextButton", {
            Name = name .. "_Tab", Size = ud2(0, tabW, 0, 26), BackgroundTransparency = 1,
            Text = "", AutoButtonColor = false, LayoutOrder = #Window.Sections + 1, Parent = Tabs,
        })
        local Idle = make("Frame", {Size = ud2(1, 0, 1, 0), BackgroundColor3 = T.Surface, BorderSizePixel = 0, Parent = Tab})
        corner(Idle, 8)
        local Fill = make("Frame", {
            Size = ud2(1, 0, 1, 0), BackgroundColor3 = WHITE, BackgroundTransparency = 1,
            BorderSizePixel = 0, Parent = Tab,
        })
        corner(Fill, 8)
        gradient(Fill, T.Accent, T.Accent2, 0)
        local TabLbl = label({
            Text = name, TextColor3 = T.Sub, Font = F.Bold, TextSize = 12,
            Size = ud2(1, 0, 1, 0), ZIndex = 2, Parent = Tab,
        })

        local Page = make("ScrollingFrame", {
            Name = name .. "_Content", Size = ud2(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
            ScrollBarThickness = 2, ScrollBarImageColor3 = T.Accent, Visible = false,
            AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = ud2(0, 0, 0, 0), Parent = Content,
        })
        make("UIListLayout", {Padding = ud(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Page})
        padding(Page, 2, 8, 0, 6)

        local active = false
        function Section._set(on)
            active = on
            tween(Fill, 0.2, {BackgroundTransparency = on and 0 or 1})
            tween(TabLbl, 0.2, {TextColor3 = on and WHITE or T.Sub})
            Page.Visible = on
        end

        Tab.MouseEnter:Connect(function() if not active then tween(Idle, 0.15, {BackgroundColor3 = T.Raised}) end end)
        Tab.MouseLeave:Connect(function() tween(Idle, 0.15, {BackgroundColor3 = T.Surface}) end)
        Tab.MouseButton1Click:Connect(function()
            closeActiveDrop()
            for _, s in ipairs(Window.Sections) do s._set(s == Section) end
            Window.CurrentSection = Section
        end)

        table.insert(Window.Sections, Section)
        if isFirst then
            Section._set(true)
            Window.CurrentSection = Section
        end

        -- element: card builder ---------------------------------------------
        local function newRow(class, name_, h)
            local row = make(class, {
                Name = name_, Size = ud2(1, 0, 0, h or ROW_H), BackgroundColor3 = T.Surface,
                BorderSizePixel = 0, LayoutOrder = nextOrder(), Parent = Page,
            })
            corner(row, 8)
            return row, stroke(row, T.Stroke, 1)
        end

        -- Button ---------------------------------------------------------------
        function Section:CreateButton(bname, callback)
            local Btn, st = newRow("TextButton", bname)
            Btn.Text = bname
            Btn.TextColor3 = T.Text
            Btn.Font = F.Bold
            Btn.TextSize = 13
            Btn.AutoButtonColor = false
            local mark = make("Frame", {
                Size = ud2(0, 3, 0, 16), Position = ud2(0, 8, 0.5, -8), BackgroundColor3 = WHITE,
                BorderSizePixel = 0, Parent = Btn,
            })
            corner(mark, ud(1, 0))
            gradient(mark, T.Accent, T.Accent2, 90)
            hoverable(Btn, st)
            Btn.MouseButton1Click:Connect(function()
                pulse(Btn, T.Raised)
                if callback then callback() end
            end)
            return Btn
        end

        -- Toggle ---------------------------------------------------------------
        function Section:CreateToggle(tname, default, callback)
            local Row, st = newRow("TextButton", tname)
            Row.Text = ""
            Row.AutoButtonColor = false
            label({
                Text = tname, TextColor3 = T.Text, Font = F.Bold, TextXAlignment = Enum.TextXAlignment.Left,
                Size = ud2(1, -70, 1, 0), Position = ud2(0, 12, 0, 0), Parent = Row,
            })
            local Track = make("Frame", {
                Name = "Toggle", Size = ud2(0, 40, 0, 20), Position = ud2(1, -52, 0.5, -10),
                BackgroundColor3 = T.Raised, BorderSizePixel = 0, Parent = Row,
            })
            corner(Track, ud(1, 0))
            local OnFill = make("Frame", {
                Size = ud2(1, 0, 1, 0), BackgroundColor3 = WHITE, BackgroundTransparency = 1,
                BorderSizePixel = 0, Parent = Track,
            })
            corner(OnFill, ud(1, 0))
            gradient(OnFill, T.Accent, T.Accent2, 0)
            local state = default and true or false
            local Knob = make("Frame", {
                Name = "Circle", Size = ud2(0, 14, 0, 14), Position = ud2(0, state and 23 or 3, 0.5, -7),
                BackgroundColor3 = WHITE, BorderSizePixel = 0, ZIndex = 2, Parent = Track,
            })
            corner(Knob, ud(1, 0))
            OnFill.BackgroundTransparency = state and 0 or 1

            hoverable(Row, st)
            Row.MouseButton1Click:Connect(function()
                state = not state
                pulse(Row, T.Raised)
                tween(Knob, 0.2, {Position = ud2(0, state and 23 or 3, 0.5, -7)}, Enum.EasingStyle.Quint)
                tween(OnFill, 0.2, {BackgroundTransparency = state and 0 or 1})
                if callback then callback(state) end
            end)
            return Row
        end

        -- Slider ---------------------------------------------------------------
        function Section:CreateSlider(sname, min, max, default, callback)
            min, max = min or 0, max or 100
            default = math.clamp(default or min, min, max)
            local span = max - min
            local startPct = span == 0 and 0 or (default - min) / span

            local Row = newRow("Frame", sname, 52)
            label({
                Text = sname, TextColor3 = T.Text, Font = F.Bold, TextXAlignment = Enum.TextXAlignment.Left,
                Size = ud2(1, -80, 0, 20), Position = ud2(0, 12, 0, 6), Parent = Row,
            })
            local Val = label({
                Text = tostring(default), TextColor3 = T.Accent, Font = F.Bold,
                TextXAlignment = Enum.TextXAlignment.Right,
                Size = ud2(0, 60, 0, 20), Position = ud2(1, -72, 0, 6), Parent = Row,
            })
            local Hit = make("TextButton", {
                Name = "Track", Size = ud2(1, -24, 0, 22), Position = ud2(0, 12, 0, 26),
                BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Parent = Row,
            })
            local Bar = make("Frame", {
                Size = ud2(1, 0, 0, 6), Position = ud2(0, 0, 0.5, -3), BackgroundColor3 = T.Raised,
                BorderSizePixel = 0, Parent = Hit,
            })
            corner(Bar, ud(1, 0))
            local Fill = make("Frame", {
                Name = "Fill", Size = ud2(startPct, 0, 1, 0), BackgroundColor3 = WHITE,
                BorderSizePixel = 0, Parent = Bar,
            })
            corner(Fill, ud(1, 0))
            gradient(Fill, T.Accent, T.Accent2, 0)
            local Knob = make("Frame", {
                Name = "SliderButton", Size = ud2(0, 14, 0, 14), AnchorPoint = v2(0.5, 0.5),
                Position = ud2(startPct, 0, 0.5, 0), BackgroundColor3 = WHITE, BorderSizePixel = 0,
                ZIndex = 2, Parent = Hit,
            })
            corner(Knob, ud(1, 0))
            stroke(Knob, T.Accent, 2)

            local function setFromX(x)
                local p = math.clamp((x - Bar.AbsolutePosition.X) / math.max(Bar.AbsoluteSize.X, 1), 0, 1)
                Fill.Size = ud2(p, 0, 1, 0)
                Knob.Position = ud2(p, 0, 0.5, 0)
                local val = math.floor(min + (p * (max - min)))
                Val.Text = tostring(val)
                if callback then callback(val) end
            end

            local dragging, dragInput = false, nil
            Hit.InputBegan:Connect(function(input)
                if isPress(input) then
                    dragging, dragInput = true, input
                    Page.ScrollingEnabled = false
                    tween(Knob, 0.12, {Size = ud2(0, 18, 0, 18)})
                    setFromX(input.Position.X)
                end
            end)
            track(uis.InputEnded:Connect(function(input)
                if dragging and isPress(input) then
                    dragging = false
                    Page.ScrollingEnabled = true
                    tween(Knob, 0.12, {Size = ud2(0, 14, 0, 14)})
                end
            end))
            track(uis.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input == dragInput) then
                    setFromX(input.Position.X)
                end
            end))
            return Row
        end

        -- Dropdown -------------------------------------------------------------
        function Section:CreateDropdown(dname, opts, default, callback)
            opts = opts or {}
            local current = opts[1] or "Select"
            if type(default) == "number" and opts[default] then current = opts[default]
            elseif type(default) == "string" and table.find(opts, default) then current = default end

            local Row, st = newRow("TextButton", dname)
            Row.Text = ""
            Row.AutoButtonColor = false
            label({
                Text = dname, TextColor3 = T.Sub, TextXAlignment = Enum.TextXAlignment.Left,
                Size = ud2(0.4, -12, 1, 0), Position = ud2(0, 12, 0, 0), Parent = Row,
            })
            local ValLbl = label({
                Name = "Value", Text = tostring(current), TextColor3 = T.Text, Font = F.Bold,
                TextXAlignment = Enum.TextXAlignment.Right,
                Size = ud2(0.6, -38, 1, 0), Position = ud2(0.4, 0, 0, 0), Parent = Row,
            })
            local Chev = label({
                Name = "Icon", Text = ">", TextColor3 = T.Accent, Font = F.Bold, TextSize = 14,
                Size = ud2(0, 16, 1, 0), Position = ud2(1, -26, 0, 0), Parent = Row,
            })
            Chev.TextXAlignment = Enum.TextXAlignment.Center
            hoverable(Row, st)

            local isOpen, List, hb, outside = false, nil, nil, nil
            local function close()
                if not isOpen then return end
                isOpen = false
                if List then List:Destroy(); List = nil end
                if hb then hb:Disconnect(); hb = nil end
                if outside then outside:Disconnect(); outside = nil end
                tween(Chev, 0.2, {Rotation = 0})
                if activeClose == close then activeClose = nil end
            end

            Row.MouseButton1Click:Connect(function()
                pulse(Row, T.Raised)
                if isOpen then close(); return end
                closeActiveDrop()
                isOpen = true
                activeClose = close
                tween(Chev, 0.2, {Rotation = 90})

                local listH = math.clamp((#opts * 30) + 12, 42, 170)
                List = make("ScrollingFrame", {
                    Name = "Options", Size = ud2(0, Row.AbsoluteSize.X, 0, listH), BackgroundColor3 = T.Bg,
                    BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = T.Accent,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = ud2(0, 0, 0, 0), ZIndex = 50,
                })
                corner(List, 8)
                stroke(List, T.Accent, 1.2)
                make("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = ud(0, 4), Parent = List})
                padding(List, 6, 6, 6, 6)

                for i, opt in ipairs(opts) do
                    local selected = opt == current
                    local O = make("TextButton", {
                        Name = tostring(opt), Size = ud2(1, 0, 0, 26), BackgroundColor3 = T.Surface,
                        Text = tostring(opt), TextColor3 = selected and T.Accent or T.Text, Font = F.Bold,
                        TextSize = 12, AutoButtonColor = false, LayoutOrder = i, Parent = List,
                    })
                    corner(O, 6)
                    O.MouseEnter:Connect(function() tween(O, 0.12, {BackgroundColor3 = T.Raised}) end)
                    O.MouseLeave:Connect(function() tween(O, 0.12, {BackgroundColor3 = T.Surface}) end)
                    O.MouseButton1Click:Connect(function()
                        current = opt
                        ValLbl.Text = tostring(opt)
                        if callback then callback(opt) end
                        close()
                    end)
                end

                local function place()
                    if not List then return end
                    local ap, as = Row.AbsolutePosition, Row.AbsoluteSize
                    local cam = workspace.CurrentCamera
                    local viewH = cam and cam.ViewportSize.Y or 1080
                    local y = ap.Y + as.Y + 4
                    if y + listH > viewH - 8 then y = ap.Y - listH - 4 end
                    List.Position = ud2(0, ap.X, 0, y)
                    List.Size = ud2(0, as.X, 0, listH)
                end
                place()
                List.Parent = Gui
                hb = rs.Heartbeat:Connect(place)
                outside = uis.InputBegan:Connect(function(input)
                    if isPress(input) then
                        local p = input.Position
                        if not (List and inside(List, p)) and not inside(Row, p) then close() end
                    end
                end)
            end)
            return Row
        end

        -- Textbox --------------------------------------------------------------
        function Section:CreateTextbox(boxName, callback)
            local Row, st = newRow("Frame", boxName)
            local Inp = make("TextBox", {
                Name = "Input", Size = ud2(1, -24, 1, 0), Position = ud2(0, 12, 0, 0), BackgroundTransparency = 1,
                Text = "", PlaceholderText = boxName or "Type", PlaceholderColor3 = T.Sub, TextColor3 = T.Text,
                Font = F.Med, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = Row,
            })
            Inp.Focused:Connect(function() tween(st, 0.15, {Color = T.Accent}) end)
            Inp.FocusLost:Connect(function()
                tween(st, 0.15, {Color = T.Stroke})
                if callback then callback(Inp.Text) end
            end)
            return Row
        end

        return Section
    end

    Main.Parent = Gui
    mount(Gui)
    table.insert(self.Windows, Window)
    return Window
end

return AetherX.new()
