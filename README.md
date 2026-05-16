# 🌙 MidnightLib

> **UI Library para Roblox — by Midnight Team**  
> Identidade visual em vermelho e preto com gradiente, fonte em negrito e todos os elementos das libs famosas.

---

## 📦 Carregar via Loadstring

```lua
local MidnightLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/SEU_USUARIO/MidnightLib/main/MidnightLib.lua"
))()
```

---

## 🪟 Criar Janela

```lua
local Window = MidnightLib:CreateWindow({
    Title           = "MIDNIGHTHUB",
    SubTitle        = "by Midnight Team",
    Logo            = "rbxassetid://84427155383225",
    Size            = UDim2.fromOffset(620, 460),
    MinimizeKey     = Enum.KeyCode.RightShift,
    DiscordServerId = "ID_NUMÉRICO_DO_SERVIDOR", -- Widget Discord em tempo real
})
```

| Parâmetro | Tipo | Descrição |
|-----------|------|-----------|
| `Title` | string | Título da janela |
| `SubTitle` | string | Subtítulo (ex: "by Dev") |
| `Logo` | string | rbxassetid da logo |
| `Size` | UDim2 | Tamanho da janela |
| `MinimizeKey` | KeyCode | Tecla para minimizar/mostrar |
| `DiscordServerId` | string | ID numérico do servidor Discord |

---

## 📑 Criar Tab

```lua
local Tab = Window:AddTab({
    Title = "Principal",
    Icon  = "rbxassetid://...",  -- opcional
})
```

---

## 🔘 Elementos

### Button
```lua
Tab:AddButton({
    Title       = "Executar",
    Description = "Descrição opcional",
    ButtonText  = "Ir",       -- texto no botão (padrão: "Executar")
    Callback    = function()
        print("Clicado!")
    end,
})
```

---

### Toggle
```lua
local Toggle = Tab:AddToggle("MinhaId", {
    Title       = "Ativar Função",
    Description = "Descrição opcional",
    Default     = false,
    Callback    = function(value)
        print("Toggle:", value)
    end,
})

-- Métodos:
Toggle:SetValue(true)
Toggle:OnChanged(function(v) print(v) end)

-- Acessar valor:
print(MidnightLib.Options["MinhaId"].Value)
```

---

### Slider
```lua
local Slider = Tab:AddSlider("MinhaId", {
    Title       = "Velocidade",
    Description = "Descrição opcional",
    Min         = 0,
    Max         = 100,
    Default     = 50,
    Rounding    = 1,   -- casas decimais (0 = inteiro)
    Callback    = function(value)
        print("Valor:", value)
    end,
})

-- Métodos:
Slider:SetValue(75)
Slider:OnChanged(function(v) print(v) end)
```

---

### Dropdown
```lua
-- Seleção única:
local Drop = Tab:AddDropdown("MinhaId", {
    Title       = "Opções",
    Description = "Escolha uma opção",
    Values      = {"A", "B", "C", "D"},
    Multi       = false,
    Default     = "A",
    Callback    = function(value)
        print("Selecionado:", value)
    end,
})

-- Multi-seleção:
local MultiDrop = Tab:AddDropdown("MinhaId2", {
    Title  = "Multi",
    Values = {"X", "Y", "Z"},
    Multi  = true,
    Default = {},
    Callback = function(values)
        -- values é uma tabela: {"X", "Z"}
    end,
})

-- Métodos:
Drop:SetValue("B")
Drop:SetValues({"Nova", "Lista"})
Drop:OnChanged(function(v) end)
```

---

### Input (Caixa de Texto)
```lua
local Input = Tab:AddInput("MinhaId", {
    Title       = "Nome",
    Description = "Descrição opcional",
    Placeholder = "Digite aqui...",
    Default     = "",
    Finished    = false, -- true = só chama Callback ao pressionar Enter
    Callback    = function(value)
        print("Texto:", value)
    end,
})

-- Métodos:
Input:SetValue("Novo texto")
Input:OnChanged(function(v) end)
```

---

### Colorpicker
```lua
local Picker = Tab:AddColorpicker("MinhaId", {
    Title       = "Cor",
    Description = "Escolha uma cor",
    Default     = Color3.fromRGB(255, 0, 0),
    Callback    = function(color)
        print("Cor:", color)
    end,
})

-- Métodos:
Picker:SetValue(Color3.fromRGB(0, 255, 0))
Picker:SetValueRGB(Color3.fromRGB(0, 0, 255))
Picker:OnChanged(function(c) end)
```

---

### Keybind
```lua
local Key = Tab:AddKeybind("MinhaId", {
    Title   = "Tecla de Atalho",
    Default = Enum.KeyCode.F,
    Callback = function(keyCode)
        print("Tecla pressionada:", keyCode)
    end,
})

-- Métodos:
Key:SetValue(Enum.KeyCode.G)
Key:GetState()  -- retorna true se a tecla está pressionada
Key:OnChanged(function(k) end)
```

---

### Paragraph
```lua
Tab:AddParagraph({
    Title   = "Título",
    Content = "Texto da mensagem.\nSuporta múltiplas linhas!",
})
```

---

### Section (Separador com título)
```lua
Tab:AddSection("NOME DA SEÇÃO")
```

---

### Divider (Linha divisória)
```lua
Tab:AddDivider()
```

---

### Label
```lua
Tab:AddLabel("Texto simples aqui")
```

---

## 🔔 Notificações

```lua
MidnightLib:Notify({
    Title    = "Título",
    Content  = "Mensagem da notificação",
    Duration = 5,      -- segundos (padrão: 4)
    Type     = "Success",  -- Success | Error | Warning | Info
})
```

| Type | Cor |
|------|-----|
| `Success` | 🟢 Verde |
| `Error`   | 🔴 Vermelho |
| `Warning` | 🟡 Amarelo |
| `Info`    | 🔵 Azul |

---

## 🏅 Tab de Créditos

```lua
Window:AddCredits({
    HubName    = "MIDNIGHTHUB",
    Owner      = "NomeDoDonoAqui",
    Developers = {
        "Dev1",
        "Dev2",
        "Dev3",
    },
    Discord    = "discord.gg/seulink",
})
```

---

## 🎛️ Acessar Valores (Options)

Qualquer elemento com `id` pode ser acessado globalmente:

```lua
local Options = MidnightLib.Options

print(Options["MinhaId"].Value)     -- valor atual
Options["MinhaId"]:SetValue(...)    -- definir valor
Options["MinhaId"]:OnChanged(function(v) end)
```

---

## 📡 Discord Widget em Tempo Real

O parâmetro `DiscordServerId` na criação da Window mostra um widget no sidebar com:
- **Membros Online** em tempo real
- **Nome do servidor**

Para funcionar, o servidor Discord precisa ter o **Widget ativado**:
> Configurações do Servidor → Widget → Ativar Widget do Servidor

O ID numérico do servidor fica na URL: `discord.com/channels/ID_AQUI/...`

---

## 🗂️ Estrutura para GitHub

```
MidnightLib/
├── MidnightLib.lua     ← Arquivo principal (loadstring)
├── Example.lua         ← Exemplo completo de uso
├── README.md           ← Esta documentação
└── .github/
    └── workflows/
        └── release.yml ← Deploy automático (opcional)
```

---

## 🚀 Publicar no GitHub

1. Crie um repositório público no GitHub
2. Faça upload de `MidnightLib.lua`
3. Acesse o arquivo no GitHub → clique em **Raw**
4. Copie a URL raw e use no loadstring

```lua
-- URL final ficará assim:
local MidnightLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/SEU_USUARIO/MidnightLib/main/MidnightLib.lua"
))()
```

---

## 📋 Changelog

### v1.0.0
- ✅ Window com drag, minimize, close
- ✅ Sistema de Tabs com ícones
- ✅ Toggle com animação suave
- ✅ Slider com gradiente
- ✅ Dropdown (single e multi)
- ✅ Input text
- ✅ Colorpicker com hue slider e RGB
- ✅ Keybind (captura e executa)
- ✅ Paragraph, Section, Divider, Label
- ✅ Notificações com 4 tipos e animação slide
- ✅ Tab de Créditos personalizada
- ✅ Widget Discord em tempo real
- ✅ Logo watermark no fundo
- ✅ Design vermelho/preto com gradiente
- ✅ Fonte em negrito (Gotham SSm)

---

*MidnightLib v1.0.0 — Midnight Team*
