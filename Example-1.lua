--[[
    MIDNIGHTHUB — Exemplo Completo (MidnightLib v2.0)
    Baseado na WindUI, completamente modificado para Midnight Team
    
    Loadstring:
    local MidnightLib = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/SEU_USUARIO/MidnightLib/main/MidnightLib.lua"
    ))()
]]

local MidnightLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/SEU_USUARIO/MidnightLib/main/MidnightLib.lua"
))()

-- ══ Criar Janela ══
local Window = MidnightLib:CreateWindow({
    Title       = "MIDNIGHTHUB",
    Author      = "by Midnight Team",
    Icon        = "rbxassetid://84427155383225",
    -- Theme padrão = "Midnight" (vermelho/preto)
    -- Outros temas disponíveis: "Crimson", "Dark", "Light", "Red"
    Folder      = "MidnightHub",
    NewElements = true,  -- elementos mais modernos
    HideSearchBar = true,
    ToggleKey   = Enum.KeyCode.RightShift,
    
    Topbar = {
        Height = 44,
        ButtonsType = "Default",
    },
    
    -- Widget do Discord (coloque seu ID de servidor)
    -- DiscordServerId = "SEU_ID_SERVIDOR",
})

local Options = MidnightLib.Options

-- ══ Notificação de boas-vindas ══
MidnightLib:Notify({
    Title    = "MidnightHub",
    Content  = "Script carregado com sucesso!",
    Duration = 5,
})

-- ══════════════════════════════════
--          PRINCIPAL
-- ══════════════════════════════════
local TabPrincipal = Window:AddTab({ Title = "Principal", Icon = "house" })
local Main = TabPrincipal

Main:AddParagraph({
    Title   = "Bem-vindo",
    Content = "Use RightShift para minimizar/mostrar a janela.",
})

Main:AddSection("COMBATE")

Main:AddToggle("GodMode", {
    Title       = "God Mode",
    Description = "Invencível contra dano",
    Default     = false,
    Callback    = function(v)
        MidnightLib:Notify({
            Title    = "God Mode",
            Content  = v and "Ativado!" or "Desativado.",
            Duration = 3,
        })
    end,
})

Main:AddToggle("InfStamina", {
    Title       = "Stamina Infinita",
    Description = "Nunca perde stamina",
    Default     = false,
})

Main:AddSlider("WalkSpeed", {
    Title    = "Velocidade",
    Description = "Velocidade do personagem",
    Min      = 16,
    Max      = 500,
    Default  = 16,
    Rounding = 0,
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end,
})

Main:AddSlider("JumpPower", {
    Title    = "Força de Pulo",
    Min      = 50,
    Max      = 500,
    Default  = 50,
    Rounding = 0,
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = v
        end
    end,
})

Main:AddSection("PLAYER")

Main:AddToggle("NoClip", {
    Title       = "No Clip",
    Description = "Atravessa paredes e objetos",
    Default     = false,
    Callback    = function(enabled)
        if enabled then
            game:GetService("RunService").Stepped:Connect(function()
                if Options.NoClip.Value then
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, p in ipairs(char:GetDescendants()) do
                            if p:IsA("BasePart") then p.CanCollide = false end
                        end
                    end
                end
            end)
        end
    end,
})

Main:AddToggle("InfJump", {
    Title       = "Pulo Infinito",
    Description = "Pular infinitamente no ar",
    Default     = false,
})

Main:AddButton({
    Title       = "Teleporte Spawn",
    Description = "Volta para o ponto inicial",
    Callback    = function()
        local char = game.Players.LocalPlayer.Character
        if char and char.HumanoidRootPart then
            char.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        end
    end,
})

-- ══════════════════════════════════
--          PLAYER
-- ══════════════════════════════════
local TabPlayer = Window:AddTab({ Title = "Player", Icon = "user" })

TabPlayer:AddSection("APARÊNCIA")

TabPlayer:AddColorpicker("BodyColor", {
    Title    = "Cor do Corpo",
    Default  = Color3.fromRGB(255, 200, 150),
    Callback = function(color) end,
})

TabPlayer:AddSection("INFORMAÇÕES")

TabPlayer:AddInput("DisplayName", {
    Title       = "Nome de Exibição",
    Description = "Altere seu nome local",
    Placeholder = "Seu nome...",
    Default     = game.Players.LocalPlayer.DisplayName,
})

TabPlayer:AddParagraph({
    Title   = "Informações da Conta",
    Content = "Usuário: " .. game.Players.LocalPlayer.Name
        .. "\nID: " .. game.Players.LocalPlayer.UserId
        .. "\nPing: Calculando...",
})

-- ══════════════════════════════════
--          AUTO FARM
-- ══════════════════════════════════
local TabFarm = Window:AddTab({ Title = "Auto Farm", Icon = "zap" })

TabFarm:AddSection("CONFIGURAÇÕES")

TabFarm:AddToggle("AutoFarm", {
    Title       = "Auto Farm",
    Description = "Farma automaticamente os mobs",
    Default     = false,
    Callback    = function(v)
        MidnightLib:Notify({
            Title   = "Auto Farm",
            Content = v and "Iniciado!" or "Parado.",
            Duration = 3,
        })
    end,
})

TabFarm:AddSlider("FarmDelay", {
    Title    = "Delay (ms)",
    Min      = 100,
    Max      = 2000,
    Default  = 500,
    Rounding = 50,
})

TabFarm:AddDropdown("FarmTarget", {
    Title  = "Alvo",
    Values = {"Qualquer Mob", "Bosses", "Ladrões", "Próximos"},
    Default = "Qualquer Mob",
})

TabFarm:AddSection("AUTO STATS")

TabFarm:AddToggle("AutoStats", {
    Title       = "Auto Distribuir Stats",
    Description = "Distribui pontos automaticamente",
    Default     = false,
})

TabFarm:AddDropdown("StatPriority", {
    Title  = "Prioridade",
    Values = {"Força", "Defesa", "Velocidade", "Magia", "Vida"},
    Default = "Força",
})

-- ══════════════════════════════════
--          TELEPORTS
-- ══════════════════════════════════
local TabTele = Window:AddTab({ Title = "Teleports", Icon = "map-pin" })

TabTele:AddSection("LOCALIZAÇÕES")

local locais = {
    {nome="Spawn",     pos=Vector3.new(0,10,0)},
    {nome="Cidade",    pos=Vector3.new(200,10,200)},
    {nome="Floresta",  pos=Vector3.new(-300,10,100)},
    {nome="Masmorra",  pos=Vector3.new(500,10,-200)},
    {nome="Montanha",  pos=Vector3.new(-100,200,300)},
}

for _, loc in ipairs(locais) do
    TabTele:AddButton({
        Title    = loc.nome,
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(loc.pos)
            end
            MidnightLib:Notify({
                Title   = "Teleporte",
                Content = "Teleportado para " .. loc.nome,
                Duration = 2,
            })
        end,
    })
end

-- ══════════════════════════════════
--          SETTINGS
-- ══════════════════════════════════
local TabSet = Window:AddTab({ Title = "Settings", Icon = "settings" })

TabSet:AddSection("INTERFACE")

TabSet:AddDropdown("Theme", {
    Title  = "Tema",
    Values = {"Midnight", "Crimson", "Dark", "Red", "Light"},
    Default = "Midnight",
    Callback = function(v)
        -- MidnightLib:SetTheme(v) -- se disponível
    end,
})

TabSet:AddKeybind("ToggleKey", {
    Title   = "Tecla Menu",
    Default = Enum.KeyCode.RightShift,
})

TabSet:AddSection("NOTIFICAÇÕES - TESTE")

TabSet:AddButton({
    Title    = "Testar Notificação",
    Callback = function()
        MidnightLib:Notify({
            Title   = "Teste",
            Content = "Notificação de teste do MidnightHub!",
            Duration = 4,
        })
    end,
})

-- ══════════════════════════════════
--          DISCORD
-- ══════════════════════════════════
local TabDisc = Window:AddTab({ Title = "Discord", Icon = "message-circle" })

TabDisc:AddParagraph({
    Title   = "Comunidade Midnight",
    Content = "Entre no servidor para suporte e updates!\ndiscord.gg/midnighthub",
})

TabDisc:AddButton({
    Title    = "Copiar Link do Discord",
    Callback = function()
        if setclipboard then
            setclipboard("discord.gg/midnighthub")
        end
        MidnightLib:Notify({
            Title   = "Copiado!",
            Content = "discord.gg/midnighthub",
            Duration = 3,
        })
    end,
})

TabDisc:AddSection("NOVIDADES")

TabDisc:AddParagraph({
    Title   = "MidnightLib v2.0.0",
    Content = "• Baseado na WindUI (engine)\n• Tema Midnight exclusivo\n• Janela quadrada\n• Gradient vermelho/preto\n• Logo Midnight no background\n• Borda vermelha personalizada",
})

-- ══ Selecionar aba inicial ══
Window:SelectTab(1)
