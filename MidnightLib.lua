--[[
    ███╗   ███╗██╗██████╗ ███╗   ██╗██╗ ██████╗ ██╗  ██╗████████╗    ██╗     ██╗██████╗ 
    ████╗ ████║██║██╔══██╗████╗  ██║██║██╔════╝ ██║  ██║╚══██╔══╝    ██║     ██║██╔══██╗
    ██╔████╔██║██║██║  ██║██╔██╗ ██║██║██║  ███╗███████║   ██║       ██║     ██║██████╔╝
    ██║╚██╔╝██║██║██║  ██║██║╚██╗██║██║██║   ██║██╔══██║   ██║       ██║     ██║██╔══██╗
    ██║ ╚═╝ ██║██║██████╔╝██║ ╚████║██║╚██████╔╝██║  ██║   ██║       ███████╗██║██████╔╝
    ╚═╝     ╚═╝╚═╝╚═════╝ ╚═╝  ╚═══╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝       ╚══════╝╚═╝╚═════╝ 
    
    MidnightLib v1.0.0
    By Midnight Team
    
    Loadstring:
    local MidnightLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU_REPO/MidnightLib/main/MidnightLib.lua"))()
    
    API Reference:
    
    -- Criar Window
    local Window = MidnightLib:CreateWindow({
        Title = "Meu Script",
        SubTitle = "by Dev",
        Logo = "rbxassetid://84427155383225",  -- opcional
        Size = UDim2.fromOffset(600, 450),
        MinimizeKey = Enum.KeyCode.RightShift,
        DiscordServerId = "SEU_ID_SERVIDOR",  -- ID do servidor Discord para widget
    })
    
    -- Criar Tab
    local Tab = Window:AddTab({ Title = "Principal", Icon = "rbxassetid://..." })
    
    -- Elementos disponíveis em Tab:
    Tab:AddButton({ Title = "Botão", Description = "Desc", Callback = function() end })
    Tab:AddToggle("id", { Title = "Toggle", Default = false, Callback = function(v) end })
    Tab:AddSlider("id", { Title = "Slider", Min = 0, Max = 100, Default = 50, Callback = function(v) end })
    Tab:AddDropdown("id", { Title = "Dropdown", Values = {"A","B","C"}, Default = "A", Callback = function(v) end })
    Tab:AddInput("id", { Title = "Input", Placeholder = "Digite...", Callback = function(v) end })
    Tab:AddColorpicker("id", { Title = "Cor", Default = Color3.fromRGB(255,0,0), Callback = function(v) end })
    Tab:AddKeybind("id", { Title = "Tecla", Default = Enum.KeyCode.F, Callback = function(v) end })
    Tab:AddParagraph({ Title = "Título", Content = "Conteúdo" })
    Tab:AddDivider()
    Tab:AddSection("Nome da Seção")
    
    -- Notificações
    MidnightLib:Notify({ Title = "Título", Content = "Mensagem", Duration = 5, Type = "Success" }) -- Type: Success, Error, Warning, Info
    
    -- Créditos da janela
    Window:AddCredits({ Developers = {"Dev1","Dev2"}, Owner = "Dono", Discord = "discord.gg/..." })
]]

-- ╔══════════════════════════════════════════════════════════════╗
-- ║                     MIDNIGHT LIB CORE                        ║
-- ╚══════════════════════════════════════════════════════════════╝

local MidnightLib = {
    Version = "1.0.0",
    Options = {},
    Unloaded = false,
}

-- ══ Services ══
local cloneref = (cloneref or clonereference or function(i) return i end)
local Players       = cloneref(game:GetService("Players"))
local TweenService  = cloneref(game:GetService("TweenService"))
local UserInput     = cloneref(game:GetService("UserInputService"))
local RunService    = cloneref(game:GetService("RunService"))
local HttpService   = cloneref(game:GetService("HttpService"))
local CoreGui       = cloneref(game:GetService("CoreGui"))

local LocalPlayer   = Players.LocalPlayer
local Mouse         = LocalPlayer:GetMouse()

local ProtectGui = (protectgui or (syn and syn.protect_gui) or function() end)
local GUIParent  = (gethui and gethui()) or CoreGui

-- ══ Colors / Theme ══
local Theme = {
    Primary         = Color3.fromRGB(180, 0, 0),
    PrimaryDark     = Color3.fromRGB(120, 0, 0),
    PrimaryDeep     = Color3.fromRGB(80, 0, 0),
    Background      = Color3.fromRGB(12, 4, 4),
    BackgroundLight = Color3.fromRGB(22, 8, 8),
    BackgroundMid   = Color3.fromRGB(30, 10, 10),
    Surface         = Color3.fromRGB(35, 12, 12),
    SurfaceHover    = Color3.fromRGB(50, 18, 18),
    Border          = Color3.fromRGB(90, 20, 20),
    BorderLight     = Color3.fromRGB(130, 30, 30),
    Text            = Color3.fromRGB(240, 220, 220),
    TextMuted       = Color3.fromRGB(170, 130, 130),
    TextDim         = Color3.fromRGB(120, 80, 80),
    Accent          = Color3.fromRGB(220, 30, 30),
    AccentGlow      = Color3.fromRGB(255, 60, 60),
    Success         = Color3.fromRGB(50, 200, 80),
    Warning         = Color3.fromRGB(240, 160, 20),
    Error           = Color3.fromRGB(255, 60, 60),
    Info            = Color3.fromRGB(60, 140, 255),
    White           = Color3.fromRGB(255, 255, 255),
}

local LOGO_ID   = "rbxassetid://84427155383225"
local FONT_BOLD = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
local FONT_MED  = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
local FONT_REG  = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular)

-- ══ Utility ══
local function Tween(obj, info, props)
    TweenService:Create(obj, info, props):Play()
end

local function New(class, props, children)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then
            inst[k] = v
        end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    if props and props.Parent then
        inst.Parent = props.Parent
    end
    return inst
end

local function AddCorner(parent, radius)
    return New("UICorner", { CornerRadius = UDim.new(0, radius or 6), Parent = parent })
end

local function AddStroke(parent, color, thickness)
    return New("UIStroke", {
        Color = color or Theme.Border,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function AddPadding(parent, top, bottom, left, right)
    return New("UIPadding", {
        PaddingTop    = UDim.new(0, top or 6),
        PaddingBottom = UDim.new(0, bottom or 6),
        PaddingLeft   = UDim.new(0, left or 8),
        PaddingRight  = UDim.new(0, right or 8),
        Parent = parent,
    })
end

local function AddGradient(parent, c1, c2, rotation)
    return New("UIGradient", {
        Color = ColorSequence.new(c1 or Theme.Primary, c2 or Theme.PrimaryDeep),
        Rotation = rotation or 90,
        Parent = parent,
    })
end

local function MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    UserInput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

local function FetchDiscordWidget(serverId)
    if not serverId or serverId == "" then return nil end
    local ok, data = pcall(function()
        local url = "https://discord.com/api/guilds/" .. serverId .. "/widget.json"
        local response = game:HttpGet(url)
        return HttpService:JSONDecode(response)
    end)
    if ok and data then
        return data
    end
    return nil
end

-- ══ ScreenGui ══
local ScreenGui = New("ScreenGui", {
    Name             = "MidnightLib",
    Parent           = GUIParent,
    ResetOnSpawn     = false,
    IgnoreGuiInset   = true,
    DisplayOrder     = 999,
    ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
})
ProtectGui(ScreenGui)

local NotifGui = New("ScreenGui", {
    Name             = "MidnightLib_Notifs",
    Parent           = GUIParent,
    ResetOnSpawn     = false,
    IgnoreGuiInset   = true,
    DisplayOrder     = 1000,
})
ProtectGui(NotifGui)

-- ══ Notification System ══
local NotifContainer = New("Frame", {
    Name             = "Container",
    Parent           = NotifGui,
    BackgroundTransparency = 1,
    Size             = UDim2.new(0, 320, 1, 0),
    Position         = UDim2.new(1, -330, 0, 0),
    AnchorPoint      = Vector2.new(0, 0),
})
New("UIListLayout", {
    Parent           = NotifContainer,
    SortOrder        = Enum.SortOrder.LayoutOrder,
    VerticalAlignment= Enum.VerticalAlignment.Bottom,
    Padding          = UDim.new(0, 8),
    FillDirection    = Enum.FillDirection.Vertical,
})
New("UIPadding", { PaddingBottom = UDim.new(0, 20), PaddingTop = UDim.new(0, 20), Parent = NotifContainer })

function MidnightLib:Notify(config)
    config = config or {}
    local title    = config.Title or "Aviso"
    local content  = config.Content or ""
    local duration = config.Duration or 4
    local ntype    = config.Type or "Info"

    local typeColors = {
        Success = Theme.Success,
        Error   = Theme.Error,
        Warning = Theme.Warning,
        Info    = Theme.Info,
    }
    local accent = typeColors[ntype] or Theme.Info

    local notif = New("Frame", {
        Name             = "Notif",
        Parent           = NotifContainer,
        BackgroundColor3 = Theme.BackgroundLight,
        Size             = UDim2.new(1, 0, 0, 70),
        BackgroundTransparency = 0,
    })
    AddCorner(notif, 8)
    AddStroke(notif, Theme.Border, 1)

    -- Left accent bar
    New("Frame", {
        Parent           = notif,
        Name             = "Accent",
        BackgroundColor3 = accent,
        Size             = UDim2.new(0, 3, 1, -10),
        Position         = UDim2.new(0, 0, 0, 5),
        AnchorPoint      = Vector2.new(0, 0),
    }, { New("UICorner", { CornerRadius = UDim.new(0, 3) }) })

    New("TextLabel", {
        Parent           = notif,
        Text             = title,
        FontFace         = FONT_BOLD,
        TextSize         = 13,
        TextColor3       = Theme.Text,
        BackgroundTransparency = 1,
        Size             = UDim2.new(1, -24, 0, 20),
        Position         = UDim2.new(0, 14, 0, 8),
        TextXAlignment   = Enum.TextXAlignment.Left,
    })

    New("TextLabel", {
        Parent           = notif,
        Text             = content,
        FontFace         = FONT_REG,
        TextSize         = 11,
        TextColor3       = Theme.TextMuted,
        BackgroundTransparency = 1,
        Size             = UDim2.new(1, -24, 0, 28),
        Position         = UDim2.new(0, 14, 0, 28),
        TextXAlignment   = Enum.TextXAlignment.Left,
        TextWrapped      = true,
    })

    -- Slide in
    notif.Position = UDim2.new(1, 20, 0, 0)
    Tween(notif, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0),
    })

    task.delay(duration, function()
        Tween(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 0, 0),
            BackgroundTransparency = 1,
        })
        task.delay(0.35, function()
            notif:Destroy()
        end)
    end)
end

-- ══ Window Creator ══
function MidnightLib:CreateWindow(config)
    config = config or {}
    local windowTitle   = config.Title or "MidnightHub"
    local windowSub     = config.SubTitle or "by Midnight Team"
    local windowLogo    = config.Logo or LOGO_ID
    local windowSize    = config.Size or UDim2.fromOffset(620, 460)
    local minimizeKey   = config.MinimizeKey or Enum.KeyCode.RightShift
    local discordId     = config.DiscordServerId or ""

    -- Window object
    local Window = {
        Tabs        = {},
        ActiveTab   = nil,
        Minimized   = false,
        _options    = {},
    }

    -- ── Main Frame ──
    local MainFrame = New("Frame", {
        Name             = "MidnightWindow",
        Parent           = ScreenGui,
        BackgroundColor3 = Theme.Background,
        Size             = windowSize,
        Position         = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2),
        ClipsDescendants = true,
    })
    AddCorner(MainFrame, 10)
    AddStroke(MainFrame, Theme.BorderLight, 1.5)

    -- Background logo watermark (transparent)
    New("ImageLabel", {
        Parent               = MainFrame,
        Image                = LOGO_ID,
        Size                 = UDim2.new(0, 340, 0, 340),
        Position             = UDim2.new(0.5, -170, 0.5, -170),
        BackgroundTransparency = 1,
        ImageTransparency    = 0.93,
        ZIndex               = 0,
    })

    -- Subtle gradient overlay on background
    New("Frame", {
        Parent               = MainFrame,
        Size                 = UDim2.new(1, 0, 1, 0),
        BackgroundColor3     = Theme.PrimaryDeep,
        BackgroundTransparency = 0.85,
        ZIndex               = 0,
    }, { AddGradient(New("Frame",{}), Theme.PrimaryDeep, Theme.Background, 135) })

    -- ── TopBar ──
    local TopBar = New("Frame", {
        Name             = "TopBar",
        Parent           = MainFrame,
        BackgroundColor3 = Theme.BackgroundMid,
        Size             = UDim2.new(1, 0, 0, 44),
        ZIndex           = 5,
    })
    AddStroke(TopBar, Theme.Border, 1)

    -- Gradient topbar
    New("UIGradient", {
        Color    = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.PrimaryDark),
            ColorSequenceKeypoint.new(0.5, Theme.BackgroundMid),
            ColorSequenceKeypoint.new(1, Theme.BackgroundLight),
        }),
        Rotation = 90,
        Parent   = TopBar,
    })

    -- Logo in topbar
    local TopLogo = New("ImageLabel", {
        Parent               = TopBar,
        Image                = windowLogo,
        Size                 = UDim2.new(0, 28, 0, 28),
        Position             = UDim2.new(0, 10, 0.5, -14),
        BackgroundTransparency = 1,
        ZIndex               = 6,
    })

    -- Title
    New("TextLabel", {
        Parent           = TopBar,
        Text             = windowTitle,
        FontFace         = FONT_BOLD,
        TextSize         = 14,
        TextColor3       = Theme.Text,
        BackgroundTransparency = 1,
        Size             = UDim2.new(0, 200, 1, 0),
        Position         = UDim2.new(0, 46, 0, 0),
        TextXAlignment   = Enum.TextXAlignment.Left,
        ZIndex           = 6,
    })

    -- Subtitle
    New("TextLabel", {
        Parent           = TopBar,
        Text             = windowSub,
        FontFace         = FONT_REG,
        TextSize         = 10,
        TextColor3       = Theme.TextMuted,
        BackgroundTransparency = 1,
        Size             = UDim2.new(0, 200, 0, 14),
        Position         = UDim2.new(0, 46, 1, -15),
        TextXAlignment   = Enum.TextXAlignment.Left,
        ZIndex           = 6,
    })

    -- ── TopBar Buttons (close / minimize / maximize style) ──
    local function MakeTopBtn(icon, posX, color)
        local btn = New("TextButton", {
            Parent           = TopBar,
            Text             = icon,
            FontFace         = FONT_BOLD,
            TextSize         = 13,
            TextColor3       = Theme.Text,
            BackgroundColor3 = color,
            Size             = UDim2.new(0, 22, 0, 22),
            Position         = UDim2.new(1, posX, 0.5, -11),
            ZIndex           = 7,
        })
        AddCorner(btn, 11)
        btn.MouseEnter:Connect(function()
            Tween(btn, TweenInfo.new(0.15), { BackgroundTransparency = 0.3 })
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, TweenInfo.new(0.15), { BackgroundTransparency = 0 })
        end)
        return btn
    end

    local CloseBtn = MakeTopBtn("✕", -12, Color3.fromRGB(200, 50, 50))
    local MinBtn   = MakeTopBtn("—", -40, Color3.fromRGB(60, 60, 60))

    CloseBtn.MouseButton1Click:Connect(function()
        Tween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size             = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1,
        })
        task.delay(0.35, function()
            ScreenGui:Destroy()
            NotifGui:Destroy()
            MidnightLib.Unloaded = true
        end)
    end)

    MinBtn.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Tween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                Size = UDim2.new(windowSize.X.Scale, windowSize.X.Offset, 0, 44),
            })
        else
            Tween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { Size = windowSize })
        end
    end)

    MakeDraggable(MainFrame, TopBar)

    -- ── Sidebar ──
    local Sidebar = New("Frame", {
        Name             = "Sidebar",
        Parent           = MainFrame,
        BackgroundColor3 = Theme.BackgroundLight,
        Size             = UDim2.new(0, 160, 1, -44),
        Position         = UDim2.new(0, 0, 0, 44),
        ZIndex           = 4,
    })
    AddStroke(Sidebar, Theme.Border, 1)

    New("UIGradient", {
        Color    = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.BackgroundMid),
            ColorSequenceKeypoint.new(1, Theme.Background),
        }),
        Rotation = 0,
        Parent   = Sidebar,
    })

    local TabList = New("ScrollingFrame", {
        Name                       = "TabList",
        Parent                     = Sidebar,
        BackgroundTransparency     = 1,
        Size                       = UDim2.new(1, 0, 1, -10),
        Position                   = UDim2.new(0, 0, 0, 10),
        ScrollBarThickness         = 0,
        CanvasSize                 = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize        = Enum.AutomaticSize.Y,
        ZIndex                     = 5,
    })
    New("UIListLayout", {
        Parent           = TabList,
        SortOrder        = Enum.SortOrder.LayoutOrder,
        Padding          = UDim.new(0, 4),
        FillDirection    = Enum.FillDirection.Vertical,
    })
    AddPadding(TabList, 4, 4, 8, 8)

    -- ── Content Area ──
    local ContentArea = New("Frame", {
        Name             = "ContentArea",
        Parent           = MainFrame,
        BackgroundTransparency = 1,
        Size             = UDim2.new(1, -160, 1, -44),
        Position         = UDim2.new(0, 160, 0, 44),
        ZIndex           = 3,
        ClipsDescendants = true,
    })

    -- ══ Discord Widget ══
    if discordId and discordId ~= "" then
        local DiscordBar = New("Frame", {
            Name             = "DiscordBar",
            Parent           = Sidebar,
            BackgroundColor3 = Color3.fromRGB(88, 101, 242),
            Size             = UDim2.new(1, -16, 0, 44),
            Position         = UDim2.new(0, 8, 1, -52),
            ZIndex           = 6,
        })
        AddCorner(DiscordBar, 6)

        local DiscordIcon = New("ImageLabel", {
            Parent           = DiscordBar,
            Image            = "rbxassetid://7547630501",
            Size             = UDim2.new(0, 18, 0, 18),
            Position         = UDim2.new(0, 8, 0.5, -9),
            BackgroundTransparency = 1,
            ZIndex           = 7,
        })

        local DiscordOnline = New("TextLabel", {
            Parent           = DiscordBar,
            Text             = "...",
            FontFace         = FONT_BOLD,
            TextSize         = 10,
            TextColor3       = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, -34, 0, 14),
            Position         = UDim2.new(0, 30, 0, 6),
            TextXAlignment   = Enum.TextXAlignment.Left,
            ZIndex           = 7,
        })
        local DiscordTotal = New("TextLabel", {
            Parent           = DiscordBar,
            Text             = "Discord",
            FontFace         = FONT_REG,
            TextSize         = 9,
            TextColor3       = Color3.fromRGB(200, 210, 255),
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, -34, 0, 14),
            Position         = UDim2.new(0, 30, 0, 22),
            TextXAlignment   = Enum.TextXAlignment.Left,
            ZIndex           = 7,
        })

        -- Fetch Discord widget in background
        task.spawn(function()
            local widget = FetchDiscordWidget(discordId)
            if widget then
                DiscordOnline.Text = (widget.presence_count or "?") .. " Online"
                DiscordTotal.Text  = (widget.name or "Discord Server")
            else
                DiscordOnline.Text = "Sem dados"
                DiscordTotal.Text  = "Discord"
            end
        end)

        -- Shrink TabList to make room
        TabList.Size = UDim2.new(1, 0, 1, -64)
    end

    -- ══ Tab System ══
    local function CreateTabButton(tabObj)
        local btn = New("TextButton", {
            Name             = "TabBtn_" .. tabObj.Title,
            Parent           = TabList,
            Text             = "",
            BackgroundColor3 = Theme.Surface,
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, 0, 0, 36),
            ZIndex           = 6,
        })
        AddCorner(btn, 6)

        if tabObj.Icon and tabObj.Icon ~= "" then
            New("ImageLabel", {
                Parent               = btn,
                Image                = tabObj.Icon,
                Size                 = UDim2.new(0, 16, 0, 16),
                Position             = UDim2.new(0, 10, 0.5, -8),
                BackgroundTransparency = 1,
                ZIndex               = 7,
            })
        end

        local btnLabel = New("TextLabel", {
            Parent           = btn,
            Text             = tabObj.Title,
            FontFace         = FONT_BOLD,
            TextSize         = 12,
            TextColor3       = Theme.TextMuted,
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, -36, 1, 0),
            Position         = UDim2.new(0, (tabObj.Icon and tabObj.Icon ~= "") and 32 or 10, 0, 0),
            TextXAlignment   = Enum.TextXAlignment.Left,
            ZIndex           = 7,
        })

        local activeLine = New("Frame", {
            Parent           = btn,
            BackgroundColor3 = Theme.Accent,
            Size             = UDim2.new(0, 3, 0.7, 0),
            Position         = UDim2.new(0, 0, 0.15, 0),
            BackgroundTransparency = 1,
            ZIndex           = 8,
        })
        AddCorner(activeLine, 2)

        tabObj._btn   = btn
        tabObj._label = btnLabel
        tabObj._line  = activeLine

        btn.MouseEnter:Connect(function()
            if Window.ActiveTab ~= tabObj then
                Tween(btn, TweenInfo.new(0.15), { BackgroundTransparency = 0.7 })
                Tween(btnLabel, TweenInfo.new(0.15), { TextColor3 = Theme.Text })
            end
        end)
        btn.MouseLeave:Connect(function()
            if Window.ActiveTab ~= tabObj then
                Tween(btn, TweenInfo.new(0.15), { BackgroundTransparency = 1 })
                Tween(btnLabel, TweenInfo.new(0.15), { TextColor3 = Theme.TextMuted })
            end
        end)

        btn.MouseButton1Click:Connect(function()
            Window:SelectTab(tabObj)
        end)

        return btn
    end

    function Window:SelectTab(tabObj)
        if Window.ActiveTab == tabObj then return end
        if Window.ActiveTab then
            local prev = Window.ActiveTab
            Tween(prev._btn, TweenInfo.new(0.2), { BackgroundTransparency = 1 })
            Tween(prev._label, TweenInfo.new(0.2), { TextColor3 = Theme.TextMuted })
            Tween(prev._line, TweenInfo.new(0.2), { BackgroundTransparency = 1 })
            prev._content.Visible = false
        end
        Window.ActiveTab = tabObj
        tabObj._content.Visible = true
        Tween(tabObj._btn, TweenInfo.new(0.2), { BackgroundTransparency = 0.5 })
        Tween(tabObj._label, TweenInfo.new(0.2), { TextColor3 = Theme.AccentGlow })
        Tween(tabObj._line, TweenInfo.new(0.2), { BackgroundTransparency = 0 })
    end

    function Window:AddTab(tabConfig)
        tabConfig = tabConfig or {}
        local Tab = {
            Title   = tabConfig.Title or "Tab",
            Icon    = tabConfig.Icon or "",
            _options = {},
        }

        -- Content Frame for this tab
        local content = New("ScrollingFrame", {
            Name                   = "Content_" .. Tab.Title,
            Parent                 = ContentArea,
            BackgroundTransparency = 1,
            Size                   = UDim2.new(1, 0, 1, 0),
            ScrollBarThickness     = 2,
            ScrollBarImageColor3   = Theme.Accent,
            CanvasSize             = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize    = Enum.AutomaticSize.Y,
            Visible                = false,
        })
        New("UIListLayout", {
            Parent        = content,
            SortOrder     = Enum.SortOrder.LayoutOrder,
            Padding       = UDim.new(0, 6),
        })
        AddPadding(content, 10, 10, 10, 10)

        Tab._content = content

        CreateTabButton(Tab)
        table.insert(Window.Tabs, Tab)

        if #Window.Tabs == 1 then
            Window:SelectTab(Tab)
        end

        -- ══ Element Builders ══

        -- Helper: base element frame
        local function MakeElement(height)
            local frame = New("Frame", {
                Parent           = content,
                BackgroundColor3 = Theme.Surface,
                Size             = UDim2.new(1, 0, 0, height or 40),
                ZIndex           = 4,
            })
            AddCorner(frame, 6)
            AddStroke(frame, Theme.Border, 1)
            return frame
        end

        local function MakeLabel(parent, text, size, color, posX, posY, wide)
            return New("TextLabel", {
                Parent               = parent,
                Text                 = text,
                FontFace             = FONT_BOLD,
                TextSize             = size or 12,
                TextColor3           = color or Theme.Text,
                BackgroundTransparency = 1,
                Size                 = UDim2.new(0, wide or 200, 0, 18),
                Position             = UDim2.new(0, posX or 10, 0, posY or 6),
                TextXAlignment       = Enum.TextXAlignment.Left,
                ZIndex               = 5,
            })
        end

        local function MakeDesc(parent, text, posY)
            if not text or text == "" then return end
            return New("TextLabel", {
                Parent               = parent,
                Text                 = text,
                FontFace             = FONT_REG,
                TextSize             = 10,
                TextColor3           = Theme.TextDim,
                BackgroundTransparency = 1,
                Size                 = UDim2.new(1, -20, 0, 14),
                Position             = UDim2.new(0, 10, 0, posY or 22),
                TextXAlignment       = Enum.TextXAlignment.Left,
                ZIndex               = 5,
                TextWrapped          = true,
            })
        end

        -- ── AddSection ──
        function Tab:AddSection(title)
            local sec = New("Frame", {
                Parent           = content,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, 0, 0, 20),
            })
            New("TextLabel", {
                Parent           = sec,
                Text             = string.upper(title or "Seção"),
                FontFace         = FONT_BOLD,
                TextSize         = 10,
                TextColor3       = Theme.TextDim,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, -20, 1, 0),
                Position         = UDim2.new(0, 0, 0, 0),
                TextXAlignment   = Enum.TextXAlignment.Left,
                ZIndex           = 5,
            })
            New("Frame", {
                Parent           = sec,
                BackgroundColor3 = Theme.Border,
                Size             = UDim2.new(1, 0, 0, 1),
                Position         = UDim2.new(0, 0, 1, -1),
                ZIndex           = 5,
            })
            return sec
        end

        -- ── AddDivider ──
        function Tab:AddDivider()
            New("Frame", {
                Parent           = content,
                BackgroundColor3 = Theme.Border,
                Size             = UDim2.new(1, 0, 0, 1),
                ZIndex           = 4,
            })
        end

        -- ── AddParagraph ──
        function Tab:AddParagraph(cfg)
            cfg = cfg or {}
            local txt = cfg.Content or ""
            local lines = 1
            for _ in txt:gmatch("\n") do lines = lines + 1 end
            local h = 30 + (lines * 14)
            local frame = MakeElement(h)
            MakeLabel(frame, cfg.Title or "", 12, Theme.Text, 10, 8)
            New("TextLabel", {
                Parent               = frame,
                Text                 = txt,
                FontFace             = FONT_REG,
                TextSize             = 11,
                TextColor3           = Theme.TextMuted,
                BackgroundTransparency = 1,
                Size                 = UDim2.new(1, -20, 0, h - 28),
                Position             = UDim2.new(0, 10, 0, 24),
                TextXAlignment       = Enum.TextXAlignment.Left,
                TextWrapped          = true,
                ZIndex               = 5,
            })
            return frame
        end

        -- ── AddButton ──
        function Tab:AddButton(cfg)
            cfg = cfg or {}
            local h = cfg.Description and 50 or 38
            local frame = MakeElement(h)

            MakeLabel(frame, cfg.Title or "Botão", 12, Theme.Text, 10, cfg.Description and 8 or 10)
            MakeDesc(frame, cfg.Description, 24)

            local btn = New("TextButton", {
                Parent           = frame,
                Text             = cfg.ButtonText or "Executar",
                FontFace         = FONT_BOLD,
                TextSize         = 11,
                TextColor3       = Theme.White,
                BackgroundColor3 = Theme.Primary,
                Size             = UDim2.new(0, 80, 0, 24),
                Position         = UDim2.new(1, -90, 0.5, -12),
                ZIndex           = 6,
            })
            AddCorner(btn, 5)

            btn.MouseEnter:Connect(function()
                Tween(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.AccentGlow })
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.Primary })
            end)
            btn.MouseButton1Click:Connect(function()
                if cfg.Callback then
                    task.spawn(cfg.Callback)
                end
            end)
            return { Frame = frame, Button = btn }
        end

        -- ── AddToggle ──
        function Tab:AddToggle(id, cfg)
            cfg = cfg or {}
            local value = cfg.Default or false
            local frame = MakeElement(cfg.Description and 50 or 38)

            MakeLabel(frame, cfg.Title or "Toggle", 12, Theme.Text, 10, cfg.Description and 8 or 10)
            MakeDesc(frame, cfg.Description, 24)

            local trackBg = New("Frame", {
                Parent           = frame,
                BackgroundColor3 = value and Theme.Accent or Theme.BackgroundMid,
                Size             = UDim2.new(0, 42, 0, 22),
                Position         = UDim2.new(1, -52, 0.5, -11),
                ZIndex           = 6,
            })
            AddCorner(trackBg, 11)
            AddStroke(trackBg, Theme.Border, 1)

            local knob = New("Frame", {
                Parent           = trackBg,
                BackgroundColor3 = Theme.White,
                Size             = UDim2.new(0, 16, 0, 16),
                Position         = value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                ZIndex           = 7,
            })
            AddCorner(knob, 8)

            local togObj = { Value = value, _callbacks = {} }

            local function setToggle(v)
                togObj.Value = v
                value = v
                Tween(trackBg, TweenInfo.new(0.2), {
                    BackgroundColor3 = v and Theme.Accent or Theme.BackgroundMid,
                })
                Tween(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                    Position = v and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                })
                for _, cb in ipairs(togObj._callbacks) do cb(v) end
                if cfg.Callback then cfg.Callback(v) end
            end

            trackBg.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    setToggle(not value)
                end
            end)
            frame.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    setToggle(not value)
                end
            end)

            function togObj:SetValue(v) setToggle(v) end
            function togObj:OnChanged(cb) table.insert(self._callbacks, cb) end

            MidnightLib.Options[id] = togObj
            return togObj
        end

        -- ── AddSlider ──
        function Tab:AddSlider(id, cfg)
            cfg = cfg or {}
            local min     = cfg.Min or 0
            local max     = cfg.Max or 100
            local rounding = cfg.Rounding or 0
            local value   = math.clamp(cfg.Default or min, min, max)

            local frame = MakeElement(cfg.Description and 62 or 52)
            MakeLabel(frame, cfg.Title or "Slider", 12, Theme.Text, 10, 8)
            MakeDesc(frame, cfg.Description, 24)

            local valLabel = New("TextLabel", {
                Parent               = frame,
                Text                 = tostring(value),
                FontFace             = FONT_BOLD,
                TextSize             = 11,
                TextColor3           = Theme.Accent,
                BackgroundTransparency = 1,
                Size                 = UDim2.new(0, 50, 0, 16),
                Position             = UDim2.new(1, -60, 0, 8),
                TextXAlignment       = Enum.TextXAlignment.Right,
                ZIndex               = 6,
            })

            local trackY = cfg.Description and 42 or 34
            local track = New("Frame", {
                Parent           = frame,
                BackgroundColor3 = Theme.BackgroundMid,
                Size             = UDim2.new(1, -20, 0, 4),
                Position         = UDim2.new(0, 10, 0, trackY),
                ZIndex           = 6,
            })
            AddCorner(track, 2)
            AddStroke(track, Theme.Border, 1)

            local fill = New("Frame", {
                Parent           = track,
                BackgroundColor3 = Theme.Accent,
                Size             = UDim2.new((value - min) / (max - min), 0, 1, 0),
                ZIndex           = 7,
            })
            AddCorner(fill, 2)
            AddGradient(fill, Theme.AccentGlow, Theme.Primary, 90)

            local knob = New("Frame", {
                Parent           = track,
                BackgroundColor3 = Theme.White,
                Size             = UDim2.new(0, 12, 0, 12),
                Position         = UDim2.new((value - min) / (max - min), -6, 0.5, -6),
                ZIndex           = 8,
            })
            AddCorner(knob, 6)

            local slObj = { Value = value, _callbacks = {} }
            local dragging = false

            local function setSlider(v)
                v = math.clamp(v, min, max)
                if rounding > 0 then
                    v = math.round(v / rounding) * rounding
                else
                    v = math.round(v)
                end
                slObj.Value = v
                value = v
                local pct = (v - min) / (max - min)
                Tween(fill, TweenInfo.new(0.05), { Size = UDim2.new(pct, 0, 1, 0) })
                Tween(knob, TweenInfo.new(0.05), { Position = UDim2.new(pct, -6, 0.5, -6) })
                valLabel.Text = tostring(v)
                for _, cb in ipairs(slObj._callbacks) do cb(v) end
                if cfg.Callback then cfg.Callback(v) end
            end

            track.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    local rel = (Mouse.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                    setSlider(min + (max - min) * math.clamp(rel, 0, 1))
                end
            end)
            UserInput.InputChanged:Connect(function(inp)
                if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
                    local rel = (Mouse.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                    setSlider(min + (max - min) * math.clamp(rel, 0, 1))
                end
            end)
            UserInput.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            function slObj:SetValue(v) setSlider(v) end
            function slObj:OnChanged(cb) table.insert(self._callbacks, cb) end

            MidnightLib.Options[id] = slObj
            return slObj
        end

        -- ── AddDropdown ──
        function Tab:AddDropdown(id, cfg)
            cfg = cfg or {}
            local values  = cfg.Values or {}
            local multi   = cfg.Multi or false
            local value   = cfg.Default or (not multi and values[1]) or {}
            local opened  = false

            local frame = MakeElement(cfg.Description and 50 or 38)
            MakeLabel(frame, cfg.Title or "Dropdown", 12, Theme.Text, 10, cfg.Description and 8 or 10)
            MakeDesc(frame, cfg.Description, 24)

            local displayText = multi
                and (type(value) == "table" and table.concat(value, ", ") or "Selecionar...")
                or tostring(value or "Selecionar...")

            local dropBtn = New("TextButton", {
                Parent           = frame,
                Text             = "",
                BackgroundColor3 = Theme.BackgroundMid,
                Size             = UDim2.new(0, 130, 0, 24),
                Position         = UDim2.new(1, -140, 0.5, -12),
                ZIndex           = 6,
                ClipsDescendants = true,
            })
            AddCorner(dropBtn, 5)
            AddStroke(dropBtn, Theme.Border, 1)

            local dropLabel = New("TextLabel", {
                Parent           = dropBtn,
                Text             = displayText,
                FontFace         = FONT_MED,
                TextSize         = 11,
                TextColor3       = Theme.Text,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, -24, 1, 0),
                Position         = UDim2.new(0, 8, 0, 0),
                TextXAlignment   = Enum.TextXAlignment.Left,
                TextTruncate     = Enum.TextTruncate.AtEnd,
                ZIndex           = 7,
            })

            New("TextLabel", {
                Parent           = dropBtn,
                Text             = "▼",
                FontFace         = FONT_BOLD,
                TextSize         = 9,
                TextColor3       = Theme.TextMuted,
                BackgroundTransparency = 1,
                Size             = UDim2.new(0, 16, 1, 0),
                Position         = UDim2.new(1, -20, 0, 0),
                ZIndex           = 7,
            })

            -- Dropdown list (appears in content, below button)
            local listFrame = New("Frame", {
                Parent           = ContentArea,
                BackgroundColor3 = Theme.BackgroundLight,
                Size             = UDim2.new(0, 130, 0, 0),
                Visible          = false,
                ZIndex           = 20,
                ClipsDescendants = true,
            })
            AddCorner(listFrame, 6)
            AddStroke(listFrame, Theme.BorderLight, 1)

            local listScroll = New("ScrollingFrame", {
                Parent                 = listFrame,
                BackgroundTransparency = 1,
                Size                   = UDim2.new(1, 0, 1, 0),
                ScrollBarThickness     = 2,
                ScrollBarImageColor3   = Theme.Accent,
                CanvasSize             = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize    = Enum.AutomaticSize.Y,
                ZIndex                 = 21,
            })
            New("UIListLayout", { Parent = listScroll, SortOrder = Enum.SortOrder.LayoutOrder })
            AddPadding(listScroll, 4, 4, 0, 0)

            local ddObj = { Value = value, _callbacks = {} }

            local function updateLabel()
                if multi then
                    if type(ddObj.Value) == "table" then
                        local sel = {}
                        for _, v in ipairs(ddObj.Value) do table.insert(sel, v) end
                        dropLabel.Text = #sel > 0 and table.concat(sel, ", ") or "Selecionar..."
                    end
                else
                    dropLabel.Text = tostring(ddObj.Value or "Selecionar...")
                end
            end

            local function buildList()
                for _, child in ipairs(listScroll:GetChildren()) do
                    if child:IsA("GuiObject") then child:Destroy() end
                end
                local totalH = 0
                for _, v in ipairs(values) do
                    local isSelected = multi
                        and (type(ddObj.Value) == "table" and table.find(ddObj.Value, v))
                        or (not multi and ddObj.Value == v)

                    local item = New("TextButton", {
                        Parent           = listScroll,
                        Text             = "",
                        BackgroundColor3 = isSelected and Theme.PrimaryDark or Theme.Surface,
                        BackgroundTransparency = isSelected and 0 or 0.3,
                        Size             = UDim2.new(1, 0, 0, 28),
                        ZIndex           = 22,
                    })
                    New("TextLabel", {
                        Parent           = item,
                        Text             = tostring(v),
                        FontFace         = FONT_MED,
                        TextSize         = 11,
                        TextColor3       = isSelected and Theme.AccentGlow or Theme.Text,
                        BackgroundTransparency = 1,
                        Size             = UDim2.new(1, -20, 1, 0),
                        Position         = UDim2.new(0, 10, 0, 0),
                        TextXAlignment   = Enum.TextXAlignment.Left,
                        ZIndex           = 23,
                    })
                    item.MouseEnter:Connect(function()
                        if not isSelected then
                            Tween(item, TweenInfo.new(0.1), { BackgroundTransparency = 0 })
                        end
                    end)
                    item.MouseLeave:Connect(function()
                        if not isSelected then
                            Tween(item, TweenInfo.new(0.1), { BackgroundTransparency = 0.3 })
                        end
                    end)
                    item.MouseButton1Click:Connect(function()
                        if multi then
                            if type(ddObj.Value) ~= "table" then ddObj.Value = {} end
                            local idx = table.find(ddObj.Value, v)
                            if idx then table.remove(ddObj.Value, idx)
                            else table.insert(ddObj.Value, v) end
                        else
                            ddObj.Value = v
                            -- close
                            opened = false
                            Tween(listFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 130, 0, 0) })
                            task.delay(0.25, function() listFrame.Visible = false end)
                        end
                        updateLabel()
                        buildList()
                        for _, cb in ipairs(ddObj._callbacks) do cb(ddObj.Value) end
                        if cfg.Callback then cfg.Callback(ddObj.Value) end
                    end)
                    totalH = totalH + 28
                end
                return math.min(totalH + 8, 180)
            end

            dropBtn.MouseButton1Click:Connect(function()
                opened = not opened
                if opened then
                    local targetH = buildList()
                    -- Position list below button
                    local btnAbsPos = dropBtn.AbsolutePosition
                    local contentAbsPos = ContentArea.AbsolutePosition
                    listFrame.Position = UDim2.new(0,
                        btnAbsPos.X - contentAbsPos.X,
                        0,
                        btnAbsPos.Y - contentAbsPos.Y + 28
                    )
                    listFrame.Size = UDim2.new(0, 130, 0, 0)
                    listFrame.Visible = true
                    Tween(listFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                        Size = UDim2.new(0, 130, 0, targetH),
                    })
                else
                    Tween(listFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                        Size = UDim2.new(0, 130, 0, 0),
                    })
                    task.delay(0.25, function() listFrame.Visible = false end)
                end
            end)

            function ddObj:SetValue(v)
                ddObj.Value = v
                updateLabel()
            end
            function ddObj:OnChanged(cb) table.insert(self._callbacks, cb) end
            function ddObj:SetValues(v)
                values = v
                ddObj.Value = multi and {} or (v[1] or nil)
                updateLabel()
            end

            MidnightLib.Options[id] = ddObj
            return ddObj
        end

        -- ── AddInput ──
        function Tab:AddInput(id, cfg)
            cfg = cfg or {}
            local frame = MakeElement(cfg.Description and 50 or 38)
            MakeLabel(frame, cfg.Title or "Input", 12, Theme.Text, 10, cfg.Description and 8 or 10)
            MakeDesc(frame, cfg.Description, 24)

            local box = New("TextBox", {
                Parent               = frame,
                Text                 = cfg.Default or "",
                PlaceholderText      = cfg.Placeholder or "Digite...",
                FontFace             = FONT_MED,
                TextSize             = 11,
                TextColor3           = Theme.Text,
                PlaceholderColor3    = Theme.TextDim,
                BackgroundColor3     = Theme.BackgroundMid,
                Size                 = UDim2.new(0, 130, 0, 24),
                Position             = UDim2.new(1, -140, 0.5, -12),
                ZIndex               = 6,
                ClearTextOnFocus     = false,
            })
            AddCorner(box, 5)
            AddStroke(box, Theme.Border, 1)
            AddPadding(box, 0, 0, 6, 6)

            box.Focused:Connect(function()
                Tween(box, TweenInfo.new(0.15), { BackgroundColor3 = Theme.Surface })
                AddStroke(box, Theme.Accent, 1)
            end)
            box.FocusLost:Connect(function(enter)
                Tween(box, TweenInfo.new(0.15), { BackgroundColor3 = Theme.BackgroundMid })
                AddStroke(box, Theme.Border, 1)
                if cfg.Callback then cfg.Callback(box.Text) end
            end)
            box:GetPropertyChangedSignal("Text"):Connect(function()
                if not cfg.Finished and cfg.Callback then cfg.Callback(box.Text) end
            end)

            local inObj = { Value = box.Text, _callbacks = {} }
            box:GetPropertyChangedSignal("Text"):Connect(function()
                inObj.Value = box.Text
                for _, cb in ipairs(inObj._callbacks) do cb(box.Text) end
            end)
            function inObj:SetValue(v) box.Text = v end
            function inObj:OnChanged(cb) table.insert(self._callbacks, cb) end

            MidnightLib.Options[id] = inObj
            return inObj
        end

        -- ── AddColorpicker ──
        function Tab:AddColorpicker(id, cfg)
            cfg = cfg or {}
            local color = cfg.Default or Color3.fromRGB(255, 0, 0)

            local frame = MakeElement(38)
            MakeLabel(frame, cfg.Title or "Cor", 12, Theme.Text, 10, 10)
            MakeDesc(frame, cfg.Description, 24)

            local preview = New("TextButton", {
                Parent           = frame,
                Text             = "",
                BackgroundColor3 = color,
                Size             = UDim2.new(0, 28, 0, 24),
                Position         = UDim2.new(1, -38, 0.5, -12),
                ZIndex           = 6,
            })
            AddCorner(preview, 5)
            AddStroke(preview, Theme.Border, 1)

            local cpObj = { Value = color, _callbacks = {} }

            -- Simple HSV picker popup
            local pickerOpen = false
            local pickerFrame = New("Frame", {
                Parent           = ContentArea,
                BackgroundColor3 = Theme.BackgroundLight,
                Size             = UDim2.new(0, 200, 0, 0),
                Visible          = false,
                ZIndex           = 25,
                ClipsDescendants = true,
            })
            AddCorner(pickerFrame, 8)
            AddStroke(pickerFrame, Theme.BorderLight, 1)

            local h, s, v = color:ToHSV()
            local hueVal = h

            -- Hue slider
            local hueTrack = New("Frame", {
                Parent           = pickerFrame,
                Size             = UDim2.new(1, -20, 0, 12),
                Position         = UDim2.new(0, 10, 0, 14),
                ZIndex           = 26,
            })
            AddCorner(hueTrack, 4)
            New("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0,   Color3.fromHSV(0,   1, 1)),
                    ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17,1,1)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33,1,1)),
                    ColorSequenceKeypoint.new(0.5,  Color3.fromHSV(0.5, 1,1)),
                    ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67,1,1)),
                    ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83,1,1)),
                    ColorSequenceKeypoint.new(1,   Color3.fromHSV(1,   1,1)),
                }),
                Rotation = 0,
                Parent = hueTrack,
            })

            local hueKnob = New("Frame", {
                Parent           = hueTrack,
                BackgroundColor3 = Theme.White,
                Size             = UDim2.new(0, 8, 1, 4),
                Position         = UDim2.new(hueVal, -4, 0, -2),
                ZIndex           = 27,
            })
            AddCorner(hueKnob, 3)
            AddStroke(hueKnob, Color3.fromRGB(80,80,80), 1)

            local hueLabel = New("TextLabel", {
                Parent           = pickerFrame,
                Text             = "Matiz  |  Sat  |  Val",
                FontFace         = FONT_REG,
                TextSize         = 9,
                TextColor3       = Theme.TextDim,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, -20, 0, 14),
                Position         = UDim2.new(0, 10, 0, 32),
                ZIndex           = 26,
            })

            -- R G B inputs
            local function makeRGBInput(parent, label, posX, val)
                New("TextLabel", {
                    Parent = parent, Text = label,
                    FontFace = FONT_BOLD, TextSize = 9,
                    TextColor3 = Theme.TextMuted, BackgroundTransparency = 1,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, posX, 0, 50),
                    ZIndex = 26,
                })
                local tb = New("TextBox", {
                    Parent = parent, Text = tostring(math.round(val)),
                    FontFace = FONT_MED, TextSize = 10,
                    TextColor3 = Theme.Text, BackgroundColor3 = Theme.BackgroundMid,
                    Size = UDim2.new(0, 38, 0, 18),
                    Position = UDim2.new(0, posX, 0, 64),
                    ZIndex = 27, ClearTextOnFocus = false,
                })
                AddCorner(tb, 3)
                AddStroke(tb, Theme.Border, 1)
                return tb
            end

            local rBox = makeRGBInput(pickerFrame, "R", 10,  color.R * 255)
            local gBox = makeRGBInput(pickerFrame, "G", 62,  color.G * 255)
            local bBox = makeRGBInput(pickerFrame, "B", 114, color.B * 255)

            local applyBtn = New("TextButton", {
                Parent = pickerFrame,
                Text = "Aplicar",
                FontFace = FONT_BOLD, TextSize = 10,
                TextColor3 = Theme.White, BackgroundColor3 = Theme.Primary,
                Size = UDim2.new(1, -20, 0, 22),
                Position = UDim2.new(0, 10, 0, 90),
                ZIndex = 27,
            })
            AddCorner(applyBtn, 4)

            applyBtn.MouseButton1Click:Connect(function()
                local r = tonumber(rBox.Text) or 0
                local g = tonumber(gBox.Text) or 0
                local b = tonumber(bBox.Text) or 0
                cpObj.Value = Color3.fromRGB(
                    math.clamp(r, 0, 255),
                    math.clamp(g, 0, 255),
                    math.clamp(b, 0, 255)
                )
                preview.BackgroundColor3 = cpObj.Value
                for _, cb in ipairs(cpObj._callbacks) do cb(cpObj.Value) end
                if cfg.Callback then cfg.Callback(cpObj.Value) end
            end)

            -- Hue drag
            local hueDrag = false
            hueTrack.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    hueDrag = true
                    hueVal = math.clamp((Mouse.X - hueTrack.AbsolutePosition.X) / hueTrack.AbsoluteSize.X, 0, 1)
                    hueKnob.Position = UDim2.new(hueVal, -4, 0, -2)
                    local nc = Color3.fromHSV(hueVal, 1, 1)
                    rBox.Text = tostring(math.round(nc.R * 255))
                    gBox.Text = tostring(math.round(nc.G * 255))
                    bBox.Text = tostring(math.round(nc.B * 255))
                end
            end)
            UserInput.InputChanged:Connect(function(inp)
                if hueDrag and inp.UserInputType == Enum.UserInputType.MouseMovement then
                    hueVal = math.clamp((Mouse.X - hueTrack.AbsolutePosition.X) / hueTrack.AbsoluteSize.X, 0, 1)
                    hueKnob.Position = UDim2.new(hueVal, -4, 0, -2)
                    local nc = Color3.fromHSV(hueVal, 1, 1)
                    rBox.Text = tostring(math.round(nc.R * 255))
                    gBox.Text = tostring(math.round(nc.G * 255))
                    bBox.Text = tostring(math.round(nc.B * 255))
                end
            end)
            UserInput.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then hueDrag = false end
            end)

            preview.MouseButton1Click:Connect(function()
                pickerOpen = not pickerOpen
                if pickerOpen then
                    local abs = preview.AbsolutePosition
                    local cabs = ContentArea.AbsolutePosition
                    pickerFrame.Position = UDim2.new(0, abs.X - cabs.X - 170, 0, abs.Y - cabs.Y + 30)
                    pickerFrame.Size = UDim2.new(0, 200, 0, 0)
                    pickerFrame.Visible = true
                    Tween(pickerFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                        Size = UDim2.new(0, 200, 0, 122),
                    })
                else
                    Tween(pickerFrame, TweenInfo.new(0.2), { Size = UDim2.new(0, 200, 0, 0) })
                    task.delay(0.25, function() pickerFrame.Visible = false end)
                end
            end)

            function cpObj:SetValue(c) cpObj.Value = c; preview.BackgroundColor3 = c end
            function cpObj:SetValueRGB(c) cpObj:SetValue(c) end
            function cpObj:OnChanged(cb) table.insert(self._callbacks, cb) end

            MidnightLib.Options[id] = cpObj
            return cpObj
        end

        -- ── AddKeybind ──
        function Tab:AddKeybind(id, cfg)
            cfg = cfg or {}
            local key = cfg.Default or Enum.KeyCode.Unknown
            local listening = false

            local frame = MakeElement(38)
            MakeLabel(frame, cfg.Title or "Tecla", 12, Theme.Text, 10, 10)

            local kbBtn = New("TextButton", {
                Parent           = frame,
                Text             = key.Name or "Nenhum",
                FontFace         = FONT_BOLD,
                TextSize         = 11,
                TextColor3       = Theme.AccentGlow,
                BackgroundColor3 = Theme.BackgroundMid,
                Size             = UDim2.new(0, 100, 0, 24),
                Position         = UDim2.new(1, -110, 0.5, -12),
                ZIndex           = 6,
            })
            AddCorner(kbBtn, 5)
            AddStroke(kbBtn, Theme.Border, 1)

            local kbObj = { Value = key, _callbacks = {} }

            kbBtn.MouseButton1Click:Connect(function()
                listening = true
                kbBtn.Text = "..."
                kbBtn.TextColor3 = Theme.TextMuted
            end)

            UserInput.InputBegan:Connect(function(inp, gpe)
                if gpe then return end
                if listening and inp.UserInputType == Enum.UserInputType.Keyboard then
                    listening = false
                    kbObj.Value = inp.KeyCode
                    key = inp.KeyCode
                    kbBtn.Text = inp.KeyCode.Name
                    kbBtn.TextColor3 = Theme.AccentGlow
                    for _, cb in ipairs(kbObj._callbacks) do cb(inp.KeyCode) end
                    if cfg.Callback then cfg.Callback(inp.KeyCode) end
                elseif not listening and inp.UserInputType == Enum.UserInputType.Keyboard then
                    if inp.KeyCode == key then
                        for _, cb in ipairs(kbObj._callbacks) do cb(inp.KeyCode) end
                        if cfg.Callback then cfg.Callback(inp.KeyCode) end
                    end
                end
            end)

            function kbObj:SetValue(k) key = k; kbBtn.Text = k.Name end
            function kbObj:GetState() return UserInput:IsKeyDown(key) end
            function kbObj:OnChanged(cb) table.insert(self._callbacks, cb) end

            MidnightLib.Options[id] = kbObj
            return kbObj
        end

        -- ── AddLabel ──
        function Tab:AddLabel(text)
            local frame = New("Frame", {
                Parent           = content,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, 0, 0, 20),
            })
            New("TextLabel", {
                Parent           = frame,
                Text             = text or "",
                FontFace         = FONT_MED,
                TextSize         = 11,
                TextColor3       = Theme.TextMuted,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, -20, 1, 0),
                Position         = UDim2.new(0, 0, 0, 0),
                TextXAlignment   = Enum.TextXAlignment.Left,
                ZIndex           = 5,
            })
        end

        return Tab
    end

    -- ══ Credits Tab ══
    function Window:AddCredits(cfg)
        cfg = cfg or {}
        local tab = Window:AddTab({ Title = "Créditos", Icon = "" })

        -- Header
        local header = New("Frame", {
            Parent           = tab._content,
            BackgroundColor3 = Theme.PrimaryDeep,
            Size             = UDim2.new(1, 0, 0, 100),
            ZIndex           = 4,
        })
        AddCorner(header, 8)
        AddGradient(header, Theme.PrimaryDark, Theme.Background, 135)

        New("ImageLabel", {
            Parent               = header,
            Image                = LOGO_ID,
            Size                 = UDim2.new(0, 60, 0, 60),
            Position             = UDim2.new(0.5, -30, 0, 14),
            BackgroundTransparency = 1,
            ZIndex               = 5,
        })
        New("TextLabel", {
            Parent           = header,
            Text             = cfg.HubName or windowTitle,
            FontFace         = FONT_BOLD,
            TextSize         = 14,
            TextColor3       = Theme.Text,
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, 0, 0, 18),
            Position         = UDim2.new(0, 0, 0, 76),
            TextXAlignment   = Enum.TextXAlignment.Center,
            ZIndex           = 5,
        })

        -- Owner card
        if cfg.Owner then
            local ownerCard = New("Frame", {
                Parent           = tab._content,
                BackgroundColor3 = Theme.Surface,
                Size             = UDim2.new(1, 0, 0, 44),
                ZIndex           = 4,
            })
            AddCorner(ownerCard, 8)
            AddStroke(ownerCard, Theme.Border, 1)

            New("Frame", {
                Parent           = ownerCard,
                BackgroundColor3 = Theme.AccentGlow,
                Size             = UDim2.new(0, 3, 0.7, 0),
                Position         = UDim2.new(0, 0, 0.15, 0),
            }, { New("UICorner", { CornerRadius = UDim.new(0, 2) }) })

            New("TextLabel", {
                Parent           = ownerCard,
                Text             = "👑  DONO",
                FontFace         = FONT_BOLD,
                TextSize         = 9,
                TextColor3       = Theme.Accent,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, -20, 0, 14),
                Position         = UDim2.new(0, 14, 0, 6),
                TextXAlignment   = Enum.TextXAlignment.Left,
                ZIndex           = 5,
            })
            New("TextLabel", {
                Parent           = ownerCard,
                Text             = cfg.Owner,
                FontFace         = FONT_BOLD,
                TextSize         = 13,
                TextColor3       = Theme.Text,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, -20, 0, 18),
                Position         = UDim2.new(0, 14, 0, 20),
                TextXAlignment   = Enum.TextXAlignment.Left,
                ZIndex           = 5,
            })
        end

        -- Dev cards
        if cfg.Developers and #cfg.Developers > 0 then
            local secLabel = New("Frame", {
                Parent           = tab._content,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, 0, 0, 18),
            })
            New("TextLabel", {
                Parent           = secLabel,
                Text             = "DESENVOLVEDORES",
                FontFace         = FONT_BOLD,
                TextSize         = 9,
                TextColor3       = Theme.TextDim,
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, 0, 1, 0),
                TextXAlignment   = Enum.TextXAlignment.Left,
                ZIndex           = 5,
            })

            for i, dev in ipairs(cfg.Developers) do
                local devCard = New("Frame", {
                    Parent           = tab._content,
                    BackgroundColor3 = Theme.Surface,
                    Size             = UDim2.new(1, 0, 0, 36),
                    ZIndex           = 4,
                })
                AddCorner(devCard, 6)
                AddStroke(devCard, Theme.Border, 1)

                New("TextLabel", {
                    Parent           = devCard,
                    Text             = "⚡  " .. dev,
                    FontFace         = FONT_BOLD,
                    TextSize         = 12,
                    TextColor3       = Theme.Text,
                    BackgroundTransparency = 1,
                    Size             = UDim2.new(1, -20, 1, 0),
                    Position         = UDim2.new(0, 10, 0, 0),
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    ZIndex           = 5,
                })
                New("TextLabel", {
                    Parent           = devCard,
                    Text             = "Desenvolvedor #" .. i,
                    FontFace         = FONT_REG,
                    TextSize         = 9,
                    TextColor3       = Theme.TextDim,
                    BackgroundTransparency = 1,
                    Size             = UDim2.new(0, 100, 0, 14),
                    Position         = UDim2.new(1, -110, 0.5, -7),
                    TextXAlignment   = Enum.TextXAlignment.Right,
                    ZIndex           = 5,
                })
            end
        end

        -- Discord link
        if cfg.Discord then
            local discCard = New("TextButton", {
                Parent           = tab._content,
                Text             = "",
                BackgroundColor3 = Color3.fromRGB(88, 101, 242),
                Size             = UDim2.new(1, 0, 0, 38),
                ZIndex           = 4,
            })
            AddCorner(discCard, 6)

            New("TextLabel", {
                Parent           = discCard,
                Text             = "🔗  " .. cfg.Discord,
                FontFace         = FONT_BOLD,
                TextSize         = 12,
                TextColor3       = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size             = UDim2.new(1, -20, 1, 0),
                Position         = UDim2.new(0, 10, 0, 0),
                TextXAlignment   = Enum.TextXAlignment.Left,
                ZIndex           = 5,
            })
            New("TextLabel", {
                Parent           = discCard,
                Text             = "Entrar no Discord",
                FontFace         = FONT_REG,
                TextSize         = 9,
                TextColor3       = Color3.fromRGB(200, 210, 255),
                BackgroundTransparency = 1,
                Size             = UDim2.new(0, 100, 0, 14),
                Position         = UDim2.new(1, -110, 0.5, -7),
                TextXAlignment   = Enum.TextXAlignment.Right,
                ZIndex           = 5,
            })

            discCard.MouseEnter:Connect(function()
                Tween(discCard, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(110, 124, 255)
                })
            end)
            discCard.MouseLeave:Connect(function()
                Tween(discCard, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(88, 101, 242)
                })
            end)
        end

        -- Version
        New("Frame", {
            Parent           = tab._content,
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, 0, 0, 24),
        })

        local verLabel = New("Frame", {
            Parent           = tab._content,
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, 0, 0, 18),
        })
        New("TextLabel", {
            Parent           = verLabel,
            Text             = "MidnightLib v" .. MidnightLib.Version .. "  •  Midnight Team",
            FontFace         = FONT_REG,
            TextSize         = 9,
            TextColor3       = Theme.TextDim,
            BackgroundTransparency = 1,
            Size             = UDim2.new(1, 0, 1, 0),
            TextXAlignment   = Enum.TextXAlignment.Center,
            ZIndex           = 4,
        })

        return tab
    end

    -- ══ Minimize key bind ══
    UserInput.InputBegan:Connect(function(inp, gpe)
        if gpe then return end
        if inp.KeyCode == minimizeKey then
            Window.Minimized = not Window.Minimized
            if Window.Minimized then
                Tween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                    Size = UDim2.new(windowSize.X.Scale, windowSize.X.Offset, 0, 44),
                })
            else
                Tween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), { Size = windowSize })
            end
        end
    end)

    -- Entrance animation
    MainFrame.Size = UDim2.fromOffset(0, 0)
    MainFrame.BackgroundTransparency = 1
    Tween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = windowSize,
        BackgroundTransparency = 0,
    })

    return Window
end

return MidnightLib
