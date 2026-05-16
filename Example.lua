--[[
    ██████████████████████████████████████████████████████████
    █                                                        █
    █          MIDNIGHTLIB — EXEMPLO COMPLETO               █
    █          Demonstração de todos os elementos            █
    █                                                        █
    ██████████████████████████████████████████████████████████
    
    Como carregar via loadstring:
    local MidnightLib = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/SEU_USUARIO/MidnightLib/main/MidnightLib.lua"
    ))()
]]

-- ══ Carregar a Lib ══
local MidnightLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/SEU_USUARIO/MidnightLib/main/MidnightLib.lua"
))()

-- ══ Criar Janela Principal ══
local Window = MidnightLib:CreateWindow({
    Title            = "MIDNIGHTHUB",
    SubTitle         = "by Midnight Team",
    Logo             = "rbxassetid://84427155383225",
    Size             = UDim2.fromOffset(620, 460),
    MinimizeKey      = Enum.KeyCode.RightShift,
    DiscordServerId  = "SEU_ID_SERVIDOR",  -- Coloque o ID numérico do seu servidor Discord
    -- Exemplo de ID: "123456789012345678"
})

local Options = MidnightLib.Options

-- ══ Notificação de boas-vindas ══
MidnightLib:Notify({
    Title   = "MidnightHub Carregado!",
    Content = "Bem-vindo ao MidnightHub. Script carregado com sucesso.",
    Duration = 6,
    Type    = "Success",
})

-- ══════════════════════════════════════════════
--                  ABA: PRINCIPAL
-- ══════════════════════════════════════════════
local TabPrincipal = Window:AddTab({
    Title = "Principal",
    Icon  = "rbxassetid://84427155383225",
})

TabPrincipal:AddSection("COMBATE")

-- Toggle: God Mode
local GodModeToggle = TabPrincipal:AddToggle("GodMode", {
    Title       = "God Mode",
    Description = "Fica invencível contra dano",
    Default     = false,
    Callback    = function(value)
        if value then
            -- Lógica de god mode aqui
            MidnightLib:Notify({
                Title   = "God Mode",
                Content = "God Mode ativado!",
                Type    = "Success",
                Duration = 3,
            })
        end
    end,
})

-- Toggle: Infinite Stamina
TabPrincipal:AddToggle("InfStamina", {
    Title       = "Stamina Infinita",
    Description = "Nunca perde stamina ao correr",
    Default     = false,
    Callback    = function(value)
        -- Lógica aqui
    end,
})

-- Slider: Velocidade
local SpeedSlider = TabPrincipal:AddSlider("WalkSpeed", {
    Title       = "Velocidade",
    Description = "Ajusta a velocidade do personagem",
    Min         = 16,
    Max         = 500,
    Default     = 16,
    Rounding    = 1,
    Callback    = function(value)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = value
        end
    end,
})

-- Slider: Jump Power
TabPrincipal:AddSlider("JumpPower", {
    Title       = "Força de Pulo",
    Description = "Ajusta a altura do pulo",
    Min         = 50,
    Max         = 500,
    Default     = 50,
    Rounding    = 1,
    Callback    = function(value)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = value
        end
    end,
})

TabPrincipal:AddDivider()
TabPrincipal:AddSection("PLAYER")

-- Button: Teleporte
TabPrincipal:AddButton({
    Title       = "Teleporte para Spawn",
    Description = "Teleporta para o ponto inicial",
    ButtonText  = "Teleportar",
    Callback    = function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        end
        MidnightLib:Notify({
            Title   = "Teleporte",
            Content = "Teleportado para o Spawn!",
            Type    = "Info",
            Duration = 3,
        })
    end,
})

-- Button: Resetar personagem
TabPrincipal:AddButton({
    Title      = "Resetar Personagem",
    ButtonText = "Resetar",
    Callback   = function()
        local humanoid = game.Players.LocalPlayer.Character
            and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Health = 0 end
    end,
})

TabPrincipal:AddDivider()
TabPrincipal:AddSection("MISC")

-- Dropdown: Modo de jogo
local ModoDropdown = TabPrincipal:AddDropdown("GameMode", {
    Title       = "Modo de Jogo",
    Description = "Selecione o modo de jogo",
    Values      = { "Normal", "Fácil", "Difícil", "Personalizado" },
    Default     = "Normal",
    Callback    = function(value)
        MidnightLib:Notify({
            Title   = "Modo",
            Content = "Modo alterado para: " .. tostring(value),
            Type    = "Info",
            Duration = 3,
        })
    end,
})

-- Dropdown: Multi-seleção de habilidades
local HabilidadesDropdown = TabPrincipal:AddDropdown("Habilidades", {
    Title       = "Habilidades Ativas",
    Description = "Selecione múltiplas habilidades",
    Values      = { "Velocidade", "Força", "Defesa", "Magia", "Furtividade" },
    Multi       = true,
    Default     = {},
    Callback    = function(value)
        -- value é uma tabela com os selecionados
    end,
})

-- Keybind: Ativar script
local ToggleKeybind = TabPrincipal:AddKeybind("MainKey", {
    Title   = "Tecla de Atalho",
    Default = Enum.KeyCode.F,
    Callback = function(key)
        -- Executado ao pressionar a tecla
    end,
})

-- ══════════════════════════════════════════════
--                 ABA: PLAYER
-- ══════════════════════════════════════════════
local TabPlayer = Window:AddTab({
    Title = "Player",
    Icon  = "",
})

TabPlayer:AddSection("APARÊNCIA")

-- Colorpicker: Cor do personagem
TabPlayer:AddColorpicker("BodyColor", {
    Title       = "Cor do Corpo",
    Description = "Altera a cor do personagem",
    Default     = Color3.fromRGB(255, 200, 150),
    Callback    = function(color)
        -- Aplica cor
    end,
})

TabPlayer:AddDivider()
TabPlayer:AddSection("INFORMAÇÕES")

-- Input: Nome display
TabPlayer:AddInput("DisplayName", {
    Title       = "Nome de Exibição",
    Description = "Altere seu nome local",
    Placeholder = "Seu nome...",
    Default     = game.Players.LocalPlayer.DisplayName,
    Callback    = function(value)
        -- Altera nome local
    end,
})

-- Paragraph: Info do jogador
TabPlayer:AddParagraph({
    Title   = "Informações da Conta",
    Content = "Usuário: " .. game.Players.LocalPlayer.Name
        .. "\nID: " .. game.Players.LocalPlayer.UserId
        .. "\nPing: Calculando...",
})

TabPlayer:AddDivider()
TabPlayer:AddSection("MOVIMENTO")

-- Toggle: NoClip
local NoClipToggle = TabPlayer:AddToggle("NoClip", {
    Title       = "No Clip",
    Description = "Atravessa paredes e objetos",
    Default     = false,
    Callback    = function(enabled)
        local noclip = false
        if enabled then
            noclip = true
            game:GetService("RunService").Stepped:Connect(function()
                if noclip then
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        for _, part in ipairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end
    end,
})

-- Toggle: Infinite Jump
TabPlayer:AddToggle("InfJump", {
    Title       = "Pulo Infinito",
    Description = "Permite pular no ar infinitamente",
    Default     = false,
    Callback    = function(enabled)
        local UIS = game:GetService("UserInputService")
        if enabled then
            UIS.JumpRequest:Connect(function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    local hum = character:FindFirstChildOfClass("Humanoid")
                    if hum and hum:GetState() ~= Enum.HumanoidStateType.Dead then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end,
})

-- ══════════════════════════════════════════════
--               ABA: AUTO FARM
-- ══════════════════════════════════════════════
local TabAutoFarm = Window:AddTab({
    Title = "Auto Farm",
    Icon  = "",
})

TabAutoFarm:AddSection("CONFIGURAÇÕES")

TabAutoFarm:AddToggle("AutoFarm", {
    Title       = "Auto Farm",
    Description = "Farma automaticamente os mobs",
    Default     = false,
    Callback    = function(enabled)
        -- Lógica de auto farm
        if enabled then
            MidnightLib:Notify({
                Title   = "Auto Farm",
                Content = "Auto Farm iniciado!",
                Type    = "Success",
                Duration = 3,
            })
        else
            MidnightLib:Notify({
                Title   = "Auto Farm",
                Content = "Auto Farm parado.",
                Type    = "Warning",
                Duration = 3,
            })
        end
    end,
})

TabAutoFarm:AddSlider("FarmDelay", {
    Title       = "Delay do Farm",
    Description = "Intervalo em milissegundos",
    Min         = 100,
    Max         = 2000,
    Default     = 500,
    Rounding    = 50,
    Callback    = function(value) end,
})

TabAutoFarm:AddDropdown("FarmTarget", {
    Title   = "Alvo do Farm",
    Values  = { "Qualquer Mob", "Bosses", "Ladrões", "Inimigos Próximos" },
    Default = "Qualquer Mob",
    Callback = function(value) end,
})

TabAutoFarm:AddDivider()
TabAutoFarm:AddSection("AUTO STATS")

TabAutoFarm:AddToggle("AutoStats", {
    Title       = "Auto Distribuir Stats",
    Description = "Distribui os pontos automaticamente",
    Default     = false,
    Callback    = function(enabled) end,
})

TabAutoFarm:AddDropdown("StatPriority", {
    Title   = "Prioridade de Stat",
    Values  = { "Força", "Defesa", "Velocidade", "Magia", "Vida" },
    Default = "Força",
    Callback = function(value) end,
})

-- ══════════════════════════════════════════════
--               ABA: TELEPORTS
-- ══════════════════════════════════════════════
local TabTeleports = Window:AddTab({
    Title = "Teleports",
    Icon  = "",
})

TabTeleports:AddSection("LOCALIZAÇÕES")

local locais = {
    { nome = "Spawn",       pos = CFrame.new(0, 10, 0) },
    { nome = "Cidade",      pos = CFrame.new(200, 10, 200) },
    { nome = "Floresta",    pos = CFrame.new(-300, 10, 100) },
    { nome = "Masmorra",    pos = CFrame.new(500, 10, -200) },
    { nome = "Montanha",    pos = CFrame.new(-100, 200, 300) },
}

for _, local_info in ipairs(locais) do
    TabTeleports:AddButton({
        Title      = local_info.nome,
        ButtonText = "Ir",
        Callback   = function()
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = local_info.pos
            end
            MidnightLib:Notify({
                Title   = "Teleporte",
                Content = "Teleportado para " .. local_info.nome,
                Type    = "Success",
                Duration = 2,
            })
        end,
    })
end

TabTeleports:AddDivider()
TabTeleports:AddSection("TELEPORTE PERSONALIZADO")

local customX = TabTeleports:AddInput("TeleX", {
    Title       = "Coordenada X",
    Placeholder = "Ex: 100",
    Default     = "0",
})
local customY = TabTeleports:AddInput("TeleY", {
    Title       = "Coordenada Y",
    Placeholder = "Ex: 10",
    Default     = "10",
})
local customZ = TabTeleports:AddInput("TeleZ", {
    Title       = "Coordenada Z",
    Placeholder = "Ex: 200",
    Default     = "0",
})

TabTeleports:AddButton({
    Title      = "Teleportar para Coordenadas",
    ButtonText = "Ir",
    Callback   = function()
        local x = tonumber(Options.TeleX.Value) or 0
        local y = tonumber(Options.TeleY.Value) or 10
        local z = tonumber(Options.TeleZ.Value) or 0
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        end
        MidnightLib:Notify({
            Title   = "Teleporte Custom",
            Content = string.format("Teleportado para (%.0f, %.0f, %.0f)", x, y, z),
            Type    = "Info",
            Duration = 3,
        })
    end,
})

-- ══════════════════════════════════════════════
--               ABA: CONFIGURAÇÕES
-- ══════════════════════════════════════════════
local TabSettings = Window:AddTab({
    Title = "Settings",
    Icon  = "",
})

TabSettings:AddSection("INTERFACE")

TabSettings:AddKeybind("ToggleUI", {
    Title   = "Tecla para Mostrar/Ocultar UI",
    Default = Enum.KeyCode.RightShift,
})

TabSettings:AddDropdown("UITheme", {
    Title   = "Tema",
    Values  = { "Midnight (Padrão)", "Dark Red", "Obsidian" },
    Default = "Midnight (Padrão)",
    Callback = function(value)
        MidnightLib:Notify({
            Title   = "Tema",
            Content = "Tema: " .. value,
            Type    = "Info",
            Duration = 3,
        })
    end,
})

TabSettings:AddDivider()
TabSettings:AddSection("NOTIFICAÇÕES")

TabSettings:AddToggle("ShowNotifs", {
    Title   = "Mostrar Notificações",
    Default = true,
})

TabSettings:AddSlider("NotifDuration", {
    Title   = "Duração das Notificações",
    Min     = 1,
    Max     = 10,
    Default = 4,
    Rounding = 1,
})

TabSettings:AddDivider()
TabSettings:AddSection("TESTE DE NOTIFICAÇÕES")

TabSettings:AddButton({
    Title      = "Notificação de Sucesso",
    ButtonText = "Testar",
    Callback   = function()
        MidnightLib:Notify({ Title = "Sucesso!", Content = "Isso é uma notificação de sucesso.", Type = "Success", Duration = 4 })
    end,
})
TabSettings:AddButton({
    Title      = "Notificação de Erro",
    ButtonText = "Testar",
    Callback   = function()
        MidnightLib:Notify({ Title = "Erro!", Content = "Isso é uma notificação de erro.", Type = "Error", Duration = 4 })
    end,
})
TabSettings:AddButton({
    Title      = "Notificação de Aviso",
    ButtonText = "Testar",
    Callback   = function()
        MidnightLib:Notify({ Title = "Aviso!", Content = "Isso é uma notificação de aviso.", Type = "Warning", Duration = 4 })
    end,
})
TabSettings:AddButton({
    Title      = "Notificação Info",
    ButtonText = "Testar",
    Callback   = function()
        MidnightLib:Notify({ Title = "Info", Content = "Isso é uma notificação de informação.", Type = "Info", Duration = 4 })
    end,
})

-- ══════════════════════════════════════════════
--               ABA: DISCORD
-- ══════════════════════════════════════════════
local TabDiscord = Window:AddTab({
    Title = "Discord",
    Icon  = "",
})

TabDiscord:AddParagraph({
    Title   = "Comunidade Midnight",
    Content = "Entre no nosso servidor do Discord para suporte,\natualizações e acesso antecipado a novos scripts!",
})

TabDiscord:AddButton({
    Title       = "Copiar Link do Discord",
    Description = "discord.gg/midnighthub",
    ButtonText  = "Copiar",
    Callback    = function()
        setclipboard("discord.gg/midnighthub")
        MidnightLib:Notify({
            Title   = "Copiado!",
            Content = "Link do Discord copiado para a área de transferência.",
            Type    = "Success",
            Duration = 3,
        })
    end,
})

TabDiscord:AddDivider()
TabDiscord:AddSection("ANÚNCIOS")

TabDiscord:AddParagraph({
    Title   = "v1.0.0 — Lançamento",
    Content = "Primeira versão da MidnightLib lançada!\n• Sistema de tabs\n• Todos os elementos\n• Widget do Discord em tempo real\n• Tab de créditos personalizada",
})

-- ══════════════════════════════════════════════
--               ABA: CRÉDITOS
-- ══════════════════════════════════════════════
Window:AddCredits({
    HubName     = "MIDNIGHTHUB",
    Owner       = "SeuNomeAqui",
    Developers  = {
        "Dev1",
        "Dev2",
        "Dev3",
    },
    Discord     = "discord.gg/midnighthub",
})

-- ══ Selecionar primeira aba ao carregar ══
Window:SelectTab(TabPrincipal)

-- ══ Notificação final ══
task.delay(1, function()
    MidnightLib:Notify({
        Title   = "Pronto!",
        Content = "MidnightHub carregado. Use " 
            .. tostring(Enum.KeyCode.RightShift.Name) 
            .. " para minimizar.",
        Type    = "Info",
        Duration = 5,
    })
end)
