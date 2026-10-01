local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local GuiParent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function()
    if gethui then
        GuiParent = gethui()
    elseif game:GetService("CoreGui") then
        GuiParent = game:GetService("CoreGui")
    end
end)

local function SendNotification(text)
    local existing = GuiParent:FindFirstChild("DeltaNotificationUI")
    if existing then
        existing:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DeltaNotificationUI"
    ScreenGui.Parent = GuiParent
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 260, 0, 45)
    Frame.Position = UDim2.new(1, 60, 1, -70)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Frame

    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.new(0, 4, 1, 0)
    Accent.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Accent.BorderSizePixel = 0
    Accent.Parent = Frame

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 2)
    AccentCorner.Parent = Accent

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -15, 1, 0)
    TextLabel.Position = UDim2.new(0, 12, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 13
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = text
    TextLabel.Parent = Frame

    Frame:TweenPosition(UDim2.new(1, -275, 1, -70), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)

    task.spawn(function()
        task.wait(2.5)
        Frame:TweenPosition(UDim2.new(1, 60, 1, -70), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
end

if GuiParent:FindFirstChild("SharinganIntro") then
    GuiParent.SharinganIntro:Destroy()
end

local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "SharinganIntro"
IntroGui.ResetOnSpawn = false
IntroGui.Parent = GuiParent

local ScreenGlow = Instance.new("Frame")
ScreenGlow.Name = "ScreenGlow"
ScreenGlow.Parent = IntroGui
ScreenGlow.Position = UDim2.new(0, 0, 0, 0)
ScreenGlow.Size = UDim2.new(1, 0, 1, 0)
ScreenGlow.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ScreenGlow.BackgroundTransparency = 1
ScreenGlow.BorderSizePixel = 0

local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Parent = IntroGui
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
MainContainer.Size = UDim2.new(0, 0, 0, 0)
MainContainer.BackgroundTransparency = 1

local Sharingan = Instance.new("ImageLabel")
Sharingan.Name = "Sharingan"
Sharingan.Parent = MainContainer
Sharingan.AnchorPoint = Vector2.new(0.5, 0.5)
Sharingan.Position = UDim2.new(0.5, 0, 0.5, 0)
Sharingan.Size = UDim2.new(1, 0, 1, 0)
Sharingan.BackgroundTransparency = 1
Sharingan.Image = "rbxthumb://type=Asset&id=87670900021703&w=420&h=420"

local NameLabel = Instance.new("TextLabel")
NameLabel.Name = "NameLabel"
NameLabel.Parent = MainContainer
NameLabel.AnchorPoint = Vector2.new(0.5, 0)
NameLabel.Position = UDim2.new(0.5, 0, 0.62, 0)
NameLabel.Size = UDim2.new(0.65, 0, 0.15, 0)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = "⚡ GAROU XR7 ⚡"
NameLabel.TextColor3 = Color3.fromRGB(255, 30, 30)
NameLabel.TextScaled = true
NameLabel.Font = Enum.Font.FredokaOne
NameLabel.TextStrokeTransparency = 0
NameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local IntroSound = Instance.new("Sound")
IntroSound.Name = "IntroAudio"
IntroSound.SoundId = "rbxassetid://6473868845"
IntroSound.Volume = 1
IntroSound.Parent = IntroGui

local maxSize = 320
IntroSound:Play()

for i = 1, 40 do
    local progress = i / 40
    MainContainer.Size = UDim2.new(0, maxSize * progress, 0, maxSize * progress)
    ScreenGlow.BackgroundTransparency = 1 - (progress * 0.4)
    Sharingan.Rotation = Sharingan.Rotation + (12 * progress)
    task.wait(0.015)
end

for i = 1, 60 do
    Sharingan.Rotation = Sharingan.Rotation + 12
    task.wait(0.015)
end

for i = 40, 1, -1 do
    local speedMultiplier = i / 40
    Sharingan.Rotation = Sharingan.Rotation + (12 * speedMultiplier)
    task.wait(0.015)
end

for i = 30, 1, -1 do
    local progress = i / 30
    Sharingan.ImageTransparency = 1 - progress
    NameLabel.TextTransparency = 1 - progress
    NameLabel.TextStrokeTransparency = 1 - progress
    ScreenGlow.BackgroundTransparency = 1 - (progress * 0.4)
    IntroSound.Volume = progress
    task.wait(0.015)
end

IntroGui:Destroy()

local Configs_HUB = { 
  Cor_Hub = Color3.fromRGB(0, 0, 0), 
  Cor_Options = Color3.fromRGB(20, 20, 20), 
  Cor_Stroke = Color3.fromRGB(255, 50, 50), 
  Cor_Text = Color3.fromRGB(255, 255, 255), 
  Cor_DarkText = Color3.fromRGB(150, 150, 150), 
  Corner_Radius = UDim.new(0, 12), 
  Text_Font = Enum.Font.FredokaOne 
}

local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://6895079853"
ClickSound.Volume = 1.5
ClickSound.Parent = SoundService

local function Create(instance, parent, props)
  local new = Instance.new(instance)
  if props then
    for prop, value in pairs(props) do
      new[prop] = value
    end
  end
  new.Parent = parent
  return new
end

local function SetProps(instance, props)
  if instance and props then
    for prop, value in pairs(props) do
      instance[prop] = value
    end
  end
  return instance
end

local function Corner(parent, props)
  local new = Create("UICorner", parent)
  new.CornerRadius = Configs_HUB.Corner_Radius
  if props then SetProps(new, props) end
  return new
end

local function Stroke(parent, props)
  local new = Create("UIStroke", parent)
  new.Color = Configs_HUB.Cor_Stroke
  new.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
  new.Thickness = 2
  
  local gradient = Instance.new("UIGradient")
  gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
  }
  gradient.Rotation = 0
  gradient.Parent = new
  
  coroutine.wrap(function()
    while new.Parent do
      gradient.Rotation = (gradient.Rotation + 2) % 360
      RunService.RenderStepped:Wait()
    end
  end)()
  
  if props then SetProps(new, props) end
  return new
end

local function BindClick(button, callback)
    button.Activated:Connect(function()
        callback()
    end)
end

local function CreateTween(instance, prop, value, time, tweenWait)
  local tween = TweenService:Create(instance, TweenInfo.new(time, Enum.EasingStyle.Linear), {[prop] = value})
  tween:Play()
  if tweenWait then tween.Completed:Wait() end
end

local function MakeDraggable(gui)
  local dragging, dragInput, dragStart, startPos
  gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      dragStart = input.Position
      startPos = gui.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then dragging = false end
      end)
    end
  end)

  gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
      dragInput = input
    end
  end)

  UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
      local delta = input.Position - dragStart
      gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
  end)
end

local existingGui = GuiParent:FindFirstChild("GAROU XR7 library")
if existingGui then existingGui:Destroy() end

local ScreenGui = Create("ScreenGui", GuiParent, {
  Name = "GAROU XR7 library",
  ResetOnSpawn = false,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

function DestroyScript()
  ScreenGui:Destroy()
end

local ToggleButton = Create("ImageButton", ScreenGui, {
  Name = "ToggleButton",
  Size = UDim2.new(0, 50, 0, 50),
  Position = UDim2.new(0.1, 0, 0.2, 0),
  BackgroundTransparency = 1,
  Image = "rbxthumb://type=Asset&id=88644653338763&w=150&h=150",
  Active = true,
  ZIndex = 10
})
Corner(ToggleButton, {CornerRadius = UDim.new(0, 10)})
Stroke(ToggleButton)
MakeDraggable(ToggleButton)

function MakeWindow(Configs)
  local title = "GAROU XR7"
  
  local Menu = Create("Frame", ScreenGui, {
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    Position = UDim2.new(0.5, -250, 0.5, -135),
    Active = true,
    ClipsDescendants = true,
    Size = UDim2.new(0, 500, 0, 270)
  })
  Corner(Menu)
  Stroke(Menu)
  MakeDraggable(Menu)

  local MenuBackground = Create("ImageLabel", Menu, {
    Name = "MenuBackground",
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 1,
    Image = "rbxthumb://type=Asset&id=80184895481976&w=420&h=420",
    ImageTransparency = 0.35,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 1
  })
  Corner(MenuBackground)

  local IsMenuOpen = true
  BindClick(ToggleButton, function()
    ClickSound:Play()
    IsMenuOpen = not IsMenuOpen
    Menu.Visible = IsMenuOpen
  end)
  
  local TopBar = Create("Frame", Menu, {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 25),
    Visible = true,
    ZIndex = 3
  })
  
  local TitleText = Create("TextLabel", TopBar, {
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    TextColor3 = Configs_HUB.Cor_Text,
    Font = Configs_HUB.Text_Font,
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = title,
    TextSize = 20,
    BackgroundTransparency = 1,
    ZIndex = 4
  })
  
  local ButtonsFrame = Create("Frame", TopBar, {
    Size = UDim2.new(0, 40, 1, -5),
    Position = UDim2.new(1, -10, 0, 2.5),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1,
    ZIndex = 4
  })
  
  local Minimize_BTN = Create("TextButton", ButtonsFrame, {
    Text = "-",
    TextColor3 = Configs_HUB.Cor_Text,
    Size = UDim2.new(0.5, 0, 1, 0),
    BackgroundTransparency = 1,
    Font = Configs_HUB.Text_Font,
    TextYAlignment = Enum.TextYAlignment.Bottom,
    TextSize = 25,
    ZIndex = 4,
    Active = true
  })
  
  local IsMinimized = false
  BindClick(Minimize_BTN, function()
    IsMinimized = not IsMinimized
    Minimize_BTN.Text = IsMinimized and "+" or "-"
    local targetHeight = IsMinimized and 35 or 270
    CreateTween(Menu, "Size", UDim2.new(0, 500, 0, targetHeight), 0.15, false)
  end)
  
  local Close_Button = Create("TextButton", ButtonsFrame, {
    Text = "×",
    TextYAlignment = Enum.TextYAlignment.Bottom,
    TextColor3 = Configs_HUB.Cor_Text,
    Size = UDim2.new(0.5, 0, 1, 0),
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Configs_HUB.Text_Font,
    TextSize = 25,
    ZIndex = 4,
    Active = true
  })

  local ConfirmOverlay = Create("Frame", ScreenGui, {
    Name = "ConfirmOverlay",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.5,
    Visible = false,
    ZIndex = 20
  })

  local ConfirmBox = Create("Frame", ConfirmOverlay, {
    Size = UDim2.new(0, 320, 0, 140),
    Position = UDim2.new(0.5, -160, 0.5, -70),
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    ZIndex = 21
  })
  Corner(ConfirmBox, {CornerRadius = UDim.new(0, 10)})
  Stroke(ConfirmBox)

  local ConfirmText = Create("TextLabel", ConfirmBox, {
    Size = UDim2.new(1, -20, 0, 50),
    Position = UDim2.new(0, 10, 0, 15),
    BackgroundTransparency = 1,
    Text = "هل أنت متأكد من إغلاق السكربت؟",
    Font = Configs_HUB.Text_Font,
    TextSize = 16,
    TextColor3 = Configs_HUB.Cor_Text,
    TextWrapped = true,
    ZIndex = 22
  })

  local YesButton = Create("TextButton", ConfirmBox, {
    Size = UDim2.new(0, 120, 0, 35),
    Position = UDim2.new(0, 25, 0, 80),
    BackgroundColor3 = Color3.fromRGB(40, 180, 70),
    Text = "نعم",
    Font = Configs_HUB.Text_Font,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 22,
    Active = true
  })
  Corner(YesButton, {CornerRadius = UDim.new(0, 8)})

  local NoButton = Create("TextButton", ConfirmBox, {
    Size = UDim2.new(0, 120, 0, 35),
    Position = UDim2.new(1, -145, 0, 80),
    BackgroundColor3 = Color3.fromRGB(220, 50, 50),
    Text = "لا",
    Font = Configs_HUB.Text_Font,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 22,
    Active = true
  })
  Corner(NoButton, {CornerRadius = UDim.new(0, 8)})

  BindClick(Close_Button, function()
    ClickSound:Play()
    ConfirmOverlay.Visible = true
  end)

  BindClick(YesButton, function()
    ClickSound:Play()
    DestroyScript()
  end)

  BindClick(NoButton, function()
    ClickSound:Play()
    ConfirmOverlay.Visible = false
  end)
  
  local line_Containers = Create("Frame", Menu, {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 3
  })
  
  local ScrollBar = Create("ScrollingFrame", Menu, {
    Size = UDim2.new(0, 140, 1, -(TopBar.Size.Y.Offset + 2)),
    Position = UDim2.new(0, 0, 1, 0),
    AnchorPoint = Vector2.new(0, 1),
    CanvasSize = UDim2.new(),
    ScrollingDirection = Enum.ScrollingDirection.Y,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
    ScrollBarThickness = 2,
    ZIndex = 3
  })
  Create("UIPadding", ScrollBar, {
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10)
  })
  Create("UIListLayout", ScrollBar, {
    Padding = UDim.new(0, 5)
  })
  
  local Containers = Create("Frame", Menu, {
    Size = UDim2.new(1, -(ScrollBar.Size.X.Offset + 2), 1, -(TopBar.Size.Y.Offset + 2)),
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 3
  })
  Corner(Containers)
  
  local function Add_Line(props)
    local line = Create("Frame", line_Containers, props)
    line.BackgroundColor3 = Configs_HUB.Cor_Stroke
    line.BorderSizePixel = 0
  end
  
  Add_Line({Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, TopBar.Size.Y.Offset)})
  Add_Line({Size = UDim2.new(0, 1, 1, -(TopBar.Size.Y.Offset + 1)), Position = UDim2.new(0, ScrollBar.Size.X.Offset, 0, TopBar.Size.Y.Offset)})
  
  local firstVisible = true
  
  function MakeTab(Configs)
    local TabName = Configs.Name or "Tab"
    local TabTitle = Configs.TabTitle or false
    
    local Frame = Create("Frame", ScrollBar, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundTransparency = 1
    })
    Corner(Frame)
    Stroke(Frame)
    
    local TextButton = Create("TextButton", Frame, {
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      Text = "",
      Active = true
    })
    
    Create("TextLabel", Frame, {
      Size = UDim2.new(1, -10, 1, 0),
      Position = UDim2.new(0, 5, 0, 0),
      BackgroundTransparency = 1,
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_Text,
      TextSize = 14,
      Text = TabName,
      TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local Container = Create("ScrollingFrame", Containers, {
      Size = UDim2.new(1, 0, 1, 0),
      ScrollingDirection = Enum.ScrollingDirection.Y,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      Visible = firstVisible,
      ZIndex = 3
    })
    
    Create("UIPadding", Container, {
      PaddingLeft = UDim.new(0, 10),
      PaddingRight = UDim.new(0, 10),
      PaddingTop = UDim.new(0, 10),
      PaddingBottom = UDim.new(0, 10)
    })
    
    Create("UIListLayout", Container, {
      Padding = UDim.new(0, 5)
    })
    
    if TabTitle then
      Create("TextLabel", Container, {
        BackgroundTransparency = 1,
        Text = string.gsub(TabName, " ", "-"),
        TextSize = 25,
        Font = Configs_HUB.Text_Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Configs_HUB.Cor_Stroke,
        Size = UDim2.new(1, 0, 0, 30),
        Name = "Frame",
        ZIndex = 3
      })
    end
    
    BindClick(TextButton, function()
      ClickSound:Play()
      for _, container in pairs(Containers:GetChildren()) do
        if container:IsA("ScrollingFrame") then
          container.Visible = false
        end
      end
      Container.Visible = true
    end)
    
    firstVisible = false
    return Container
  end

  return Menu
end

local Window = MakeWindow({
    Hub = {
        Title = "GAROU XR7",
        Animation = "by : GAROU XR7"
    }
})

local TabCredits = MakeTab({Name = "معلومات وحقوق", TabTitle = true})
local TabInfinity = MakeTab({Name = "سكربتات انفنتي", TabTitle = true})
local TabAdmin = MakeTab({Name = "أوامر انفنتي(ادمن)", TabTitle = true})
local TabUser = MakeTab({Name = "لاعب", TabTitle = true})
local TabSomla = MakeTab({Name = "صمله/رحمه", TabTitle = true})

local function CreateInfoBox(parent, size, height)
    local box = Create("Frame", parent, {
        Size = size or UDim2.new(1, 0, 0, height or 35),
        BackgroundColor3 = Configs_HUB.Cor_Options,
        BackgroundTransparency = 0.3,
        Name = "Frame",
        ZIndex = 3
    })
    Corner(box, {CornerRadius = UDim.new(0, 8)})
    local stroke = Create("UIStroke", box)
    stroke.Color = Configs_HUB.Cor_Stroke
    stroke.Thickness = 1
    return box
end

local function CreateScriptButton(parent, btnText, callback)
    local box = CreateInfoBox(parent, UDim2.new(1, 0, 0, 35))
    local btn = Create("TextButton", box, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = btnText,
        Font = Configs_HUB.Text_Font,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 4,
        Active = true
    })
    BindClick(btn, function()
        ClickSound:Play()
        SendNotification("تم تنفيذ السكربت بنجاح ✅")
        if callback then callback() end
    end)
    return box
end

local function CreateCopyButton(parent, commandText)
    local box = CreateInfoBox(parent, UDim2.new(1, 0, 0, 35))
    local btn = Create("TextButton", box, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = commandText .. " 📋 (اضغط للنسخ)",
        Font = Configs_HUB.Text_Font,
        TextSize = 13,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 4,
        Active = true
    })
    
    BindClick(btn, function()
        ClickSound:Play()
        local success = pcall(function()
            if setclipboard then
                setclipboard(commandText)
            elseif toclipboard then
                toclipboard(commandText)
            end
        end)
        
        if success then
            SendNotification("تم نسخ الأمر بنجاح! 📋")
            btn.Text = "تم النسخ بنجاح! ✅"
            task.wait(1.5)
            btn.Text = commandText .. " 📋 (اضغط للنسخ)"
        else
            SendNotification("النسخ غير مدعوم في مشغلك ❌")
            btn.Text = "النسخ غير مدعوم في مشغلك ❌"
            task.wait(1.5)
            btn.Text = commandText .. " 📋 (اضغط للنسخ)"
        end
    end)
    return box
end

local FullPlayerBox = CreateInfoBox(TabCredits, UDim2.new(1, 0, 0, 90))
local PlayerAvatarUrl = ""
pcall(function()
    PlayerAvatarUrl = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)

local CreditImage = Create("ImageLabel", FullPlayerBox, {
    Size = UDim2.new(0, 65, 0, 65),
    Position = UDim2.new(0, 10, 0.5, 0),
    AnchorPoint = Vector2.new(0, 0.5),
    Image = PlayerAvatarUrl,
    BackgroundTransparency = 1,
    ZIndex = 4
})
Corner(CreditImage, {CornerRadius = UDim.new(1, 0)})
local ImgStroke = Create("UIStroke", CreditImage)
ImgStroke.Color = Configs_HUB.Cor_Stroke
ImgStroke.Thickness = 1

local ExecutorName = "Delta Executor"
pcall(function()
    if identifyexecutor then
        ExecutorName = identifyexecutor()
    elseif getexecutorname then
        ExecutorName = getexecutorname()
    end
end)

local AccountCreationDate = os.date("%Y/%m/%d", os.time() - (LocalPlayer.AccountAge * 86400))
local CurrentUsageDate = os.date("%Y/%m/%d")

Create("TextLabel", FullPlayerBox, {
    Size = UDim2.new(1, -85, 1, -10),
    Position = UDim2.new(0, 85, 0, 5),
    Text = "👤 اللاعب: " .. LocalPlayer.Name .. "\n⚡ الهاك: " .. ExecutorName .. "\n📅 الإنشاء: " .. AccountCreationDate .. "\n🕒 اليوم: " .. CurrentUsageDate,
    Font = Configs_HUB.Text_Font,
    TextSize = 11,
    TextColor3 = Configs_HUB.Cor_Text,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    BackgroundTransparency = 1,
    TextWrapped = true,
    ZIndex = 4
})

local DevCreditsBox = CreateInfoBox(TabCredits, UDim2.new(1, 0, 0, 35))
Create("TextLabel", DevCreditsBox, {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "تم تطوير السكربت بواسطة كارو وبمساعدة سلندر وجحيم",
    Font = Configs_HUB.Text_Font,
    TextSize = 11,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    ZIndex = 4
})

local GiftBox = CreateInfoBox(TabCredits, UDim2.new(1, 0, 0, 35))
Create("TextLabel", GiftBox, {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "🎁 سكربت هديه لكلان XR7",
    Font = Configs_HUB.Text_Font,
    TextSize = 12,
    TextColor3 = Configs_HUB.Cor_Stroke,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    ZIndex = 4
})

local TikTokBox = CreateInfoBox(TabCredits, UDim2.new(1, 0, 0, 40))
Create("TextLabel", TikTokBox, {
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 5, 0, 0),
    BackgroundTransparency = 1,
    Text = "🎵 تيك توك: @fr15_010",
    Font = Configs_HUB.Text_Font,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    ZIndex = 4
})

CreateScriptButton(TabInfinity, "✈️ سكربت طيران (من صنع كارو)", function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/j0psAKD8"))() end)
end)

CreateScriptButton(TabInfinity, "📊 سكربت احتساب نقاط", function()
    pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-NO9AT-SAMLAT-47637"))() end)
end)

CreateScriptButton(TabInfinity, "💣 سكربت احتساب نووي", function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/g82a2NB9"))() end)
end)

CreateScriptButton(TabInfinity, "⚡ سكربت فارس", function()
    pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/FaresXForest/SCRIPTCLANFO/refs/heads/main/CLANFO/SCRIPT/Smlh)))()/smla)'))() end)
end)

CreateScriptButton(TabInfinity, "📶 سكربت تقليل وتسريع النت", function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/3Tnj3Hab"))() end)
end)

CreateScriptButton(TabInfinity, "🖱️ سكربت اتو كليكر", function()
    pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AUTOCLICK-48479"))() end)
end)

CreateScriptButton(TabInfinity, "⚡ سكربت بديل اتو كليكر", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/RealBatu20/AI-Scripts-2025/refs/heads/main/AntiAFK_AntiKickV3.lua", true))() end)
end)

CreateScriptButton(TabInfinity, "🟢 سكربت افك اخضر", function()
    pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Anti-afk-lol-28917"))() end)
end)

CreateScriptButton(TabInfinity, "⚡ سكربت ادمن", function()
    pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinity-Yield-94242"))() end)
end)

local commands = {
    "antiafk", "antilag", "antikick", "xray", "boostfps", "info", 
    "setfpscap 50", "night", "day", "loopxray", "Clientantikick", 
    "maxzoom inf", "freeze", "swim"
}

for _, cmd in ipairs(commands) do
    CreateCopyButton(TabAdmin, cmd)
end

local function GetPlayerByString(str)
    if not str or str == "" then return nil end
    str = str:match("^%s*(.-)%s*$"):lower()
    
    for _, plr in ipairs(Players:GetPlayers()) do
        local name = plr.Name:lower()
        local displayName = plr.DisplayName:lower()
        if string.find(name, str, 1, true) or string.find(displayName, str, 1, true) then
            return plr
        end
    end
    return nil
end

local function SetupTextBoxBehavior(textBox)
    textBox.Focused:Connect(function()
        textBox.Text = ""
    end)
end

local SpeedBoxFrame = CreateInfoBox(TabUser, UDim2.new(1, 0, 0, 80))
local SpeedTextBox = Create("TextBox", SpeedBoxFrame, {
    Size = UDim2.new(1, -20, 0, 30),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Text = "",
    PlaceholderText = "اكتب سرعة المشي (مثال: 16 أو 50)...",
    Font = Configs_HUB.Text_Font,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
    ClearTextOnFocus = false,
    ZIndex = 4
})
Corner(SpeedTextBox, {CornerRadius = UDim.new(0, 6)})
local SStroke = Create("UIStroke", SpeedTextBox)
SStroke.Color = Configs_HUB.Cor_Stroke
SStroke.Thickness = 1

local ApplySpeedBtn = Create("TextButton", SpeedBoxFrame, {
    Size = UDim2.new(0.48, 0, 0, 30),
    Position = UDim2.new(0, 10, 0, 42),
    BackgroundColor3 = Color3.fromRGB(40, 140, 70),
    Text = "⚡ تطبيق السرعة",
    Font = Configs_HUB.Text_Font,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 4,
    Active = true
})
Corner(ApplySpeedBtn, {CornerRadius = UDim.new(0, 6)})

local ResetSpeedBtn = Create("TextButton", SpeedBoxFrame, {
    Size = UDim2.new(0.48, 0, 0, 30),
    Position = UDim2.new(1, -10, 0, 42),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundColor3 = Color3.fromRGB(120, 120, 120),
    Text = "🔄 رجوع للطبيعي (16)",
    Font = Configs_HUB.Text_Font,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 4,
    Active = true
})
Corner(ResetSpeedBtn, {CornerRadius = UDim.new(0, 6)})

BindClick(ApplySpeedBtn, function()
    ClickSound:Play()
    local val = tonumber(SpeedTextBox.Text)
    if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
        SendNotification("تم تغيير السرعة إلى " .. val .. " ⚡")
    end
end)

BindClick(ResetSpeedBtn, function()
    ClickSound:Play()
    SpeedTextBox.Text = ""
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        SendNotification("تم إرجاع السرعة للطبيعي 🔄")
    end
end)

local JumpBoxFrame = CreateInfoBox(TabUser, UDim2.new(1, 0, 0, 80))
local JumpTextBox = Create("TextBox", JumpBoxFrame, {
    Size = UDim2.new(1, -20, 0, 30),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Text = "",
    PlaceholderText = "اكتب قوة القفز (مثال: 50 أو 100)...",
    Font = Configs_HUB.Text_Font,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
    ClearTextOnFocus = false,
    ZIndex = 4
})
Corner(JumpTextBox, {CornerRadius = UDim.new(0, 6)})
local JStroke = Create("UIStroke", JumpTextBox)
JStroke.Color = Configs_HUB.Cor_Stroke
JStroke.Thickness = 1

local ApplyJumpBtn = Create("TextButton", JumpBoxFrame, {
    Size = UDim2.new(0.48, 0, 0, 30),
    Position = UDim2.new(0, 10, 0, 42),
    BackgroundColor3 = Color3.fromRGB(40, 140, 70),
    Text = "🦘 تطبيق القفز",
    Font = Configs_HUB.Text_Font,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 4,
    Active = true
})
Corner(ApplyJumpBtn, {CornerRadius = UDim.new(0, 6)})

local ResetJumpBtn = Create("TextButton", JumpBoxFrame, {
    Size = UDim2.new(0.48, 0, 0, 30),
    Position = UDim2.new(1, -10, 0, 42),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundColor3 = Color3.fromRGB(120, 120, 120),
    Text = "🔄 رجوع للطبيعي (50)",
    Font = Configs_HUB.Text_Font,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 4,
    Active = true
})
Corner(ResetJumpBtn, {CornerRadius = UDim.new(0, 6)})

BindClick(ApplyJumpBtn, function()
    ClickSound:Play()
    local val = tonumber(JumpTextBox.Text)
    if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.UseJumpPower = true
        hum.JumpPower = val
        SendNotification("تم تغيير قوة القفز إلى " .. val .. " 🦘")
    end
end)

BindClick(ResetJumpBtn, function()
    ClickSound:Play()
    JumpTextBox.Text = ""
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.UseJumpPower = true
        hum.JumpPower = 50
        SendNotification("تم إرجاع القفز للطبيعي 🔄")
    end
end)

local isFrozen = false
local freezeConnection = nil

local FreezeBoxFrame = CreateInfoBox(TabUser, UDim2.new(1, 0, 0, 45))
local FreezeButton = Create("TextButton", FreezeBoxFrame, {
    Size = UDim2.new(1, -20, 0, 32),
    Position = UDim2.new(0, 10, 0, 6.5),
    BackgroundColor3 = Color3.fromRGB(180, 50, 50),
    Text = "🧊 تجميد اللاعب (إيقاف الحركة)",
    Font = Configs_HUB.Text_Font,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 4,
    Active = true
})
Corner(FreezeButton, {CornerRadius = UDim.new(0, 6)})

local UnfreezeButton = Create("TextButton", FreezeBoxFrame, {
    Size = UDim2.new(1, -20, 0, 32),
    Position = UDim2.new(0, 10, 0, 6.5),
    BackgroundColor3 = Color3.fromRGB(40, 160, 70),
    Text = "✅ إلغاء التجميد (السماح بالحركة)",
    Font = Configs_HUB.Text_Font,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Visible = false,
    ZIndex = 4,
    Active = true
})
Corner(UnfreezeButton, {CornerRadius = UDim.new(0, 6)})

local function UnfreezePlayer()
    isFrozen = false
    if freezeConnection then
        freezeConnection:Disconnect()
        freezeConnection = nil
    end
    FreezeButton.Visible = true
    UnfreezeButton.Visible = false
    SendNotification("تم إلغاء التجميد بنجاح ✅")
end

BindClick(FreezeButton, function()
    ClickSound:Play()
    isFrozen = true
    FreezeButton.Visible = false
    UnfreezeButton.Visible = true
    SendNotification("تم تجميد اللاعب بنجاح 🧊")

    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local frozenCFrame = hrp.CFrame

        freezeConnection = RunService.RenderStepped:Connect(function()
            if not isFrozen then return end
            local currentTargetChar = LocalPlayer.Character
            if currentTargetChar and currentTargetChar:FindFirstChild("HumanoidRootPart") then
                local currentHrp = currentTargetChar.HumanoidRootPart
                currentHrp.CFrame = frozenCFrame
                pcall(function()
                    currentHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    currentHrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end)
            end
        end)
    end
end)

BindClick(UnfreezeButton, function()
    ClickSound:Play()
    UnfreezePlayer()
end)

LocalPlayer.CharacterAdded:Connect(function()
    UnfreezePlayer()
end)

local KillFixBoxFrame = CreateInfoBox(TabUser, UDim2.new(1, 0, 0, 45))
local KillFixButton = Create("TextButton", KillFixBoxFrame, {
    Size = UDim2.new(1, -20, 0, 32),
    Position = UDim2.new(0, 10, 0, 6.5),
    BackgroundColor3 = Color3.fromRGB(200, 40, 40),
    Text = "💀 امر قتل وفك التجميد (عند التعليق)",
    Font = Configs_HUB.Text_Font,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 4,
    Active = true
})
Corner(KillFixButton, {CornerRadius = UDim.new(0, 6)})

BindClick(KillFixButton, function()
    ClickSound:Play()
    
    -- إيقاف التجميد فوراً لكي لا يبقى مفعلاً تلقائياً وتضطر لإعادة تشغيله يدوياً
    UnfreezePlayer()

    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                    part.CanCollide = true
                end
            end
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0
                humanoid:ChangeState(Enum.HumanoidStateType.Dead)
            end
            char:BreakJoints()
            task.delay(0.5, function()
                if LocalPlayer.Character == char then
                    LocalPlayer.Character = nil
                    task.wait(0.1)
                    LocalPlayer.CharacterAdded:Wait()
                end
            end)
        end
    end)
    SendNotification("تم تنفيذ أمر القتل وفك التجميد بنجاح 💀")
end)

local UnifiedBox = CreateInfoBox(TabSomla, UDim2.new(1, 0, 0, 210))

local AvatarIcon = Create("ImageLabel", UnifiedBox, {
    Size = UDim2.new(0, 80, 0, 80),
    Position = UDim2.new(0, 10, 0, 8),
    BackgroundTransparency = 1,
    Image = "rbxthumb://type=Asset&id=87670900021703&w=150&h=150",
    ZIndex = 4
})
Corner(AvatarIcon, {CornerRadius = UDim.new(1, 0)})
local AvStroke = Create("UIStroke", AvatarIcon)
AvStroke.Color = Configs_HUB.Cor_Stroke
AvStroke.Thickness = 1

local isAvatarRotating = true
task.spawn(function()
    local rot = 0
    while AvatarIcon and AvatarIcon.Parent do
        if isAvatarRotating then
            rot = (rot + 0.8) % 360
            AvatarIcon.Rotation = rot
        else
            AvatarIcon.Rotation = 0
        end
        task.wait(0.016)
    end
end)

local TargetInfoLabel = Create("TextLabel", UnifiedBox, {
    Size = UDim2.new(1, -105, 0, 48),
    Position = UDim2.new(1, -10, 0, 8),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1,
    Text = "👤 الاسم: لم يتم التحديد\n⚡ اليوزر: --\n🆔 الأيدي: --",
    Font = Configs_HUB.Text_Font,
    TextSize = 12,
    TextColor3 = Configs_HUB.Cor_Text,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextYAlignment = Enum.TextYAlignment.Center,
    TextWrapped = true,
    ZIndex = 4
})

local TargetTextBox = Create("TextBox", UnifiedBox, {
    Size = UDim2.new(1, -105, 0, 28),
    Position = UDim2.new(1, -10, 0, 58),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Text = "",
    PlaceholderText = "اكتب اسم اللاعب هنا...",
    Font = Configs_HUB.Text_Font,
    TextSize = 11,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
    ClearTextOnFocus = false,
    ZIndex = 4
})
Corner(TargetTextBox, {CornerRadius = UDim.new(0, 6)})
local TbStroke = Create("UIStroke", TargetTextBox)
TbStroke.Color = Configs_HUB.Cor_Stroke
TbStroke.Thickness = 1

SetupTextBoxBehavior(TargetTextBox)

local function GetTargetPlayer()
    local textInput = TargetTextBox.Text
    local foundPlr = GetPlayerByString(textInput)
    if foundPlr then
        TargetTextBox.Text = foundPlr.Name
        isAvatarRotating = false
        AvatarIcon.Rotation = 0
        pcall(function()
            AvatarIcon.Image = Players:GetUserThumbnailAsync(foundPlr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        TargetInfoLabel.Text = "👤 الاسم: " .. foundPlr.DisplayName .. "\n⚡ اليوزر: " .. foundPlr.Name .. "\n🆔 الأيدي: " .. foundPlr.UserId
        return foundPlr
    end
    return nil
end

TargetTextBox.FocusLost:Connect(function()
    GetTargetPlayer()
end)

local function CreateiPhoneSwitch(parent, posY, labelText, activeColor)
    local container = Create("Frame", parent, {
        Size = UDim2.new(1, -16, 0, 28),
        Position = UDim2.new(0, 8, 0, posY),
        BackgroundTransparency = 1,
        ZIndex = 4
    })
    
    local label = Create("TextLabel", container, {
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = labelText,
        Font = Configs_HUB.Text_Font,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4
    })
    
    local toggleBg = Create("TextButton", container, {
        Size = UDim2.new(0, 40, 0, 22),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        Text = "",
        ZIndex = 4,
        Active = true
    })
    Corner(toggleBg, {CornerRadius = UDim.new(1, 0)})
    
    local toggleKnob = Create("Frame", toggleBg, {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 3, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 5
    })
    Corner(toggleKnob, {CornerRadius = UDim.new(1, 0)})
    
    local function SetVisual(state)
        local targetPos = state and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        local targetColor = state and activeColor or Color3.fromRGB(50, 50, 50)
        CreateTween(toggleKnob, "Position", targetPos, 0.15, false)
        CreateTween(toggleBg, "BackgroundColor3", targetColor, 0.15, false)
    end
    
    return container, label, toggleBg, SetVisual
end

local function CreateiPhoneSwitchWithInput(parent, posY, labelText, activeColor, inputPlaceholder)
    local container = Create("Frame", parent, {
        Size = UDim2.new(1, -16, 0, 28),
        Position = UDim2.new(0, 8, 0, posY),
        BackgroundTransparency = 1,
        ZIndex = 4
    })
    
    local label = Create("TextLabel", container, {
        Size = UDim2.new(1, -130, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = labelText,
        Font = Configs_HUB.Text_Font,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4
    })
    
    local speedInput = Create("TextBox", container, {
        Size = UDim2.new(0, 45, 0, 22),
        Position = UDim2.new(1, -95, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Text = "",
        PlaceholderText = inputPlaceholder or "سرعة",
        Font = Configs_HUB.Text_Font,
        TextSize = 10,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
        ClearTextOnFocus = false,
        ZIndex = 4
    })
    Corner(speedInput, {CornerRadius = UDim.new(0, 4)})
    local sStroke = Create("UIStroke", speedInput)
    sStroke.Color = Configs_HUB.Cor_Stroke
    sStroke.Thickness = 1
    
    local toggleBg = Create("TextButton", container, {
        Size = UDim2.new(0, 40, 0, 22),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        Text = "",
        ZIndex = 4,
        Active = true
    })
    Corner(toggleBg, {CornerRadius = UDim.new(1, 0)})
    
    local toggleKnob = Create("Frame", toggleBg, {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 3, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 5
    })
    Corner(toggleKnob, {CornerRadius = UDim.new(1, 0)})
    
    local function SetVisual(state)
        local targetPos = state and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        local targetColor = state and activeColor or Color3.fromRGB(50, 50, 50)
        CreateTween(toggleKnob, "Position", targetPos, 0.15, false)
        CreateTween(toggleBg, "BackgroundColor3", targetColor, 0.15, false)
    end
    
    return container, label, toggleBg, speedInput, SetVisual
end

local _, SpecLabel, SpecToggleBg, SetSpecVisual = CreateiPhoneSwitch(UnifiedBox, 98, "👁️ تشغيل المشاهدة", Color3.fromRGB(40, 140, 200))
local isSpectating = false
local specConnection = nil

local function StopSpectate()
    isSpectating = false
    SetSpecVisual(false)
    if specConnection then
        specConnection:Disconnect()
        specConnection = nil
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = LocalPlayer.Character.Humanoid
    end
    SendNotification("تم إيقاف المشاهدة 👁️")
end

BindClick(SpecToggleBg, function()
    ClickSound:Play()
    if not isSpectating then
        local targetPlayer = GetTargetPlayer()
        if not targetPlayer then
            SpecLabel.Text = "❌ اكتب اسم اللاعب بالأول!"
            SendNotification("❌ اكتب اسم اللاعب بالأول!")
            task.wait(1.5)
            SpecLabel.Text = "👁️ تشغيل المشاهدة"
            return
        end
        
        isSpectating = true
        SetSpecVisual(true)
        SendNotification("تم تشغيل المشاهدة على " .. targetPlayer.Name .. " 👁️")
        
        specConnection = RunService.RenderStepped:Connect(function()
            if not isSpectating then return end
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = targetPlayer.Character.Humanoid
            else
                StopSpectate()
            end
        end)
    else
        StopSpectate()
    end
end)

local _, BangLabel, BangToggleBg, BangSpeedInput, SetBangVisual = CreateiPhoneSwitchWithInput(UnifiedBox, 132, "🔥 تشغيل البانك", Color3.fromRGB(180, 20, 20), "سرعة")
local isBanging = false
local bangLoop = nil
local currentAnimTrack = nil

local function StopBang()
    isBanging = false
    SetBangVisual(false)
    if bangLoop then
        bangLoop:Disconnect()
        bangLoop = nil
    end
    if currentAnimTrack then
        pcall(function() currentAnimTrack:Stop() end)
        currentAnimTrack = nil
    end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
    SendNotification("تم إيقاف البانك ❌")
end

BindClick(BangToggleBg, function()
    ClickSound:Play()
    if not isBanging then
        local targetPlayer = GetTargetPlayer()
        if not targetPlayer then
            BangLabel.Text = "❌ اكتب اسم اللاعب بالأول!"
            SendNotification("❌ اكتب اسم اللاعب بالأول!")
            task.wait(1.5)
            BangLabel.Text = "🔥 تشغيل البانك"
            return
        end
        
        isBanging = true
        SetBangVisual(true)
        SendNotification("تم تفعيل بانك بنجاح 🔥")
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
            pcall(function()
                local anim = Instance.new("Animation")
                anim.AnimationId = hum.RigType == Enum.HumanoidRigType.R15 and "rbxassetid://5918726673" or "rbxassetid://148840371"
                currentAnimTrack = animator:LoadAnimation(anim)
                currentAnimTrack:Play(0.1, 1, 2)
            end)
        end
        
        local timePassed = 0
        bangLoop = RunService.RenderStepped:Connect(function(dt)
            if not isBanging then return end
            local myChar = LocalPlayer.Character
            local tChar = targetPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") and tChar and tChar:FindFirstChild("HumanoidRootPart") then
                local hrp = myChar.HumanoidRootPart
                local tHrp = tChar.HumanoidRootPart
                for _, part in ipairs(myChar:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
                local customSpeed = tonumber(BangSpeedInput.Text) or 15
                timePassed = timePassed + (dt * customSpeed)
                local backOffset = 1.2 + math.sin(timePassed) * 0.5
                hrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, backOffset)
                pcall(function() hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end)
            else
                StopBang()
            end
        end)
    else
        StopBang()
    end
end)

local _, SuckLabel, SuckToggleBg, SuckSpeedInput, SetSuckVisual = CreateiPhoneSwitchWithInput(UnifiedBox, 166, "😈 تشغيل المص", Color3.fromRGB(180, 20, 120), "سرعة")
local isSucking = false
local suckLoop = nil
local currentSuckAnimTrack = nil

local function StopSuck()
    isSucking = false
    SetSuckVisual(false)
    if suckLoop then
        suckLoop:Disconnect()
        suckLoop = nil
    end
    if currentSuckAnimTrack then
        pcall(function() currentSuckAnimTrack:Stop() end)
        currentSuckAnimTrack = nil
    end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
    SendNotification("تم إيقاف المص ❌")
end

BindClick(SuckToggleBg, function()
    ClickSound:Play()
    if not isSucking then
        local targetPlayer = GetTargetPlayer()
        if not targetPlayer then
            SuckLabel.Text = "❌ اكتب اسم اللاعب بالأول!"
            SendNotification("❌ اكتب اسم اللاعب بالأول!")
            task.wait(1.5)
            SuckLabel.Text = "😈 تشغيل المص"
            return
        end
        
        isSucking = true
        SetSuckVisual(true)
        SendNotification("تم تفعيل المص بنجاح 😈")
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
            pcall(function()
                local anim = Instance.new("Animation")
                anim.AnimationId = hum.RigType == Enum.HumanoidRigType.R15 and "rbxassetid://2506281703" or "rbxassetid://179224234"
                currentSuckAnimTrack = animator:LoadAnimation(anim)
                currentSuckAnimTrack:Play(0.1, 1, 1.5)
            end)
        end
        
        local timePassed = 0
        suckLoop = RunService.RenderStepped:Connect(function(dt)
            if not isSucking then return end
            local myChar = LocalPlayer.Character
            local tChar = targetPlayer.Character
            
            if myChar and myChar:FindFirstChild("HumanoidRootPart") and tChar and tChar:FindFirstChild("HumanoidRootPart") then
                local hrp = myChar.HumanoidRootPart
                local tHrp = tChar.HumanoidRootPart
                
                for _, part in ipairs(myChar:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
                
                local customSpeed = tonumber(SuckSpeedInput.Text) or 15
                timePassed = timePassed + (dt * customSpeed)
                
                local frontOffset = 0.95 + (math.sin(timePassed) * 0.25)
                local targetHead = tChar:FindFirstChild("Head")
                local targetFacePos = targetHead and targetHead.Position or (tHrp.Position + Vector3.new(0, 1.5, 0))
                local myPelvis = myChar:FindFirstChild("LowerTorso") or myChar:FindFirstChild("Torso") or hrp
                local myPelvisOffset = myPelvis.Position - hrp.Position
                local targetRotation = tHrp.CFrame - tHrp.Position
                local desiredCFrame = CFrame.new(targetFacePos) * targetRotation * CFrame.new(0, 0, -frontOffset) * CFrame.Angles(0, math.rad(180), 0)
                
                hrp.CFrame = desiredCFrame - myPelvisOffset
                pcall(function() hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end)
            else
                StopSuck()
            end
        end)
    else
        StopSuck()
    end
end)
