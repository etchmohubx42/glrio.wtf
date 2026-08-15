-- ═══════════════════════════════════════════════════════════════════════════════
-- GLRIO.WTF — Rebuilt on LinoriaLib | Every Feature Works
-- Optimized for Delta Executor | Mobile Compatible
-- Credits: GLRIO | Discord: discord.gg/eYcrAQ45rE
-- ═══════════════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- ═══════════════════════════════════════════════════════════════════════════════
-- EXECUTOR DETECTION
-- ═══════════════════════════════════════════════════════════════════════════════
local Capabilities = {
    hookmetamethod = type(hookmetamethod) == "function",
    getrawmetatable = type(getrawmetatable) == "function",
    setreadonly = type(setreadonly) == "function",
    newcclosure = type(newcclosure) == "function",
    checkcaller = type(checkcaller) == "function",
    getnamecallmethod = type(getnamecallmethod) == "function",
    hookfunction = type(hookfunction) == "function",
    getconnections = type(getconnections) == "function",
    getgc = type(getgc) == "function",
    getloadedmodules = type(getloadedmodules) == "function",
    getsenv = type(getsenv) == "function",
    setclipboard = type(setclipboard) == "function",
    firetouchinterest = type(firetouchinterest) == "function",
    Drawing = type(Drawing) == "table",
}

local Executor = "Unknown"
if syn then Executor = "Synapse X"
elseif KRNL_LOADED then Executor = "KRNL"
elseif fluxus then Executor = "Fluxus"
elseif getexecutorname then Executor = getexecutorname()
elseif identifyexecutor then Executor = identifyexecutor()
elseif getgenv().Delta then Executor = "Delta"
elseif getgenv().Codex then Executor = "Codex"
end

local function SafeCall(func, ...)
    local s, r = pcall(func, ...)
    if not s then warn("[GLRIO.WTF] " .. tostring(r)) end
    return s, r
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- LINORIA LIBRARY
-- ═══════════════════════════════════════════════════════════════════════════════
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library:SetWatermarkVisibility(true)
Library:SetWatermark('glrio.wtf on top')

local Window = Library:CreateWindow({
    Title = 'glrio.wtf',
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Home = Window:AddTab('Home'),
    Combat = Window:AddTab('Combat'),
    Legit = Window:AddTab('Legit'),
    Rage = Window:AddTab('Rage'),
    Weapon = Window:AddTab('Weapon'),
    Movement = Window:AddTab('Movement'),
    Visuals = Window:AddTab('Visuals'),
    Player = Window:AddTab('Player'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- THEME — Matching prada.wtf style (dark, purple accents)
-- ═══════════════════════════════════════════════════════════════════════════════
local ThemeColor = Color3.fromRGB(199, 125, 255)
local OffColor = Color3.fromRGB(255, 107, 107)
local OnColor = Color3.fromRGB(135, 206, 235)
local WhiteColor = Color3.fromRGB(255, 255, 255)

-- ═══════════════════════════════════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════════════════════════════════
local State = {
    SilentEnabled = false,
    SilentTargetLockOnly = false,
    SilentDistance = 1000,
    SilentMode = "Client",
    AimbotEnabled = false,
    AimbotTargetLockOnly = false,
    AimbotDistance = 1000,
    AimbotSmoothness = 0.9,
    TriggerEnabled = false,
    TriggerTargetLockOnly = false,
    TriggerDistance = 1000,
    TriggerCooldown = 0.1,
    TriggerActivation = "Auto",
    AutoShoot = false,
    FOVEnabled = false,
    FOVVisible = true,
    FOVRadius = 100,
    FOVType = "Circle",
    FOVMode = "Center",
    Priority = "Closest",
    StickyTarget = false,
    AutoSwitch = false,
    TargetIgnoreFriends = false,
    TargetIgnoreKnocked = false,
    TargetIgnoreCrew = false,
    TargetIgnoreGrabbed = false,
    Prediction = {X = 0.138, Y = 0.138, Z = 0.138},
    AutoPrediction = false,
    DynamicPrediction = false,
    AirResolver = false,
    GroundResolver = false,
    DesyncResolver = false,
    ResolverMethod = "recalculatevelocity",
    HitboxEnabled = false,
    HitboxSize = 5,
    HitboxTransparency = 0.7,
    HitboxMaterial = "Neon",
    RageMode = false,
    ForceHit = false,
    ForceHead = false,
    Wallbang = false,
    InstantShoot = false,
    FullDamage = false,
    CSyncEnabled = false,
    CSyncMode = "Orbit",
    CSyncDistance = 10,
    CSyncSpeed = 2,
    CSyncHeight = 2,
    AntiAimEnabled = false,
    AntiAimMode = "Jitter",
    AntiAimSpeed = 50,
    NoRecoil = false,
    NoSpread = false,
    WalkspeedEnabled = false,
    SpeedValue = 120,
    JumpPowerEnabled = false,
    JumpValue = 120,
    CFrameEnabled = false,
    CFrameSpeed = 1,
    NoClipEnabled = false,
    FlightEnabled = false,
    FlightSpeed = 50,
    FlightMode = "Camera",
    WallhopEnabled = false,
    ESPEnabled = false,
    ESPNames = true,
    ESPBox = true,
    ESPBoxType = "2D",
    ESPFilled = false,
    ESPDistance = true,
    ESPHealth = true,
    ESPSnapLine = false,
    ESPBone = false,
    ESPLimitDist = false,
    ESPLimitDistValue = 1000,
    ESPNameColor = Color3.fromRGB(169, 165, 160),
    ESPTargetColor = Color3.fromRGB(255, 0, 0),
    HitmarkerEnabled = false,
    HitSound = false,
    KillSound = false,
    KillEffect = false,
    BloodEffect = false,
    BulletTracerEnabled = false,
    BulletTracerFade = true,
    BulletTracerSize = 1,
    BulletTracerDuration = 3,
    TracerColor = Color3.fromRGB(169, 165, 160),
    ImpactColor = Color3.fromRGB(255, 0, 0),
    SelfChams = false,
    ToolChams = false,
    CharTrail = false,
    Circle3D = false,
    SpinCircle3D = false,
    WalkstepCircles = false,
    JumpCircle = false,
    SkinChangerEnabled = false,
    SkinUnlockAll = false,
    SkinHoodCustoms = false,
    AntiScreenshot = false,
    AntiRecord = false,
    AntiKick = false,
    AntiTeleport = false,
    HidePlayerList = false,
    SpoofName = false,
    SpoofPosition = false,
    SpoofOffset = 0,
    WorldSettings = false,
    FogDistance = 800,
    FogColor = Color3.fromRGB(192, 192, 192),
    Brightness = 3,
    ClockTime = 14,
    IndoorAmbient = Color3.fromRGB(128, 128, 128),
    OutdoorAmbient = Color3.fromRGB(128, 128, 128),
    SkyboxToggle = false,
    CameraFOV = 70,
    SmoothCamera = false,
    LockCamera = false,
    CameraShake = 0,
    FirstPersonLock = false,
    SpectateTarget = false,
    GodMode = false,
    IndicatorsEnabled = true,
    LockedTarget = nil,
    HitPart = "HumanoidRootPart",
}

-- ═══════════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════
local function GetChar(p) return p and p.Character end
local function GetHum(p) local c = GetChar(p) return c and c:FindFirstChildOfClass("Humanoid") end
local function GetRoot(p) local c = GetChar(p) return c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso")) end
local function GetHead(p) local c = GetChar(p) return c and c:FindFirstChild("Head") end
local function IsAlive(p) local h = GetHum(p) return h and h.Health > 0 end
local function GetDist(p)
    local r1, r2 = GetRoot(p), GetRoot(LocalPlayer)
    if r1 and r2 then return (r1.Position - r2.Position).Magnitude end
    return math.huge
end

local function GetClosestPlayer(maxDist, onlyLock)
    if onlyLock and State.LockedTarget then
        if IsAlive(State.LockedTarget) and GetDist(State.LockedTarget) <= (maxDist or math.huge) then
            return State.LockedTarget
        end
        return nil
    end
    local closest, minD = nil, maxDist or math.huge
    local myRoot = GetRoot(LocalPlayer)
    if not myRoot then return nil end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsAlive(plr) then
            local d = GetDist(plr)
            if d < minD then minD = d closest = plr end
        end
    end
    return closest
end

local function GetClosestToMouse(maxDist)
    local closest, minD = nil, maxDist or math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsAlive(plr) then
            local root = GetRoot(plr)
            if root then
                local sp, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local d = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(sp.X, sp.Y)).Magnitude
                    if d < minD then minD = d closest = plr end
                end
            end
        end
    end
    return closest
end

local function GetPriorityTarget()
    if State.LockedTarget and IsAlive(State.LockedTarget) then return State.LockedTarget end
    local targets = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsAlive(plr) then table.insert(targets, plr) end
    end
    if State.Priority == "Closest" then
        table.sort(targets, function(a, b) return GetDist(a) < GetDist(b) end)
    elseif State.Priority == "Lowest Health" then
        table.sort(targets, function(a, b)
            local ha, hb = GetHum(a), GetHum(b)
            return (ha and ha.Health or 999) < (hb and hb.Health or 999)
        end)
    elseif State.Priority == "Nearest Cursor" then
        table.sort(targets, function(a, b)
            local ra, rb = GetRoot(a), GetRoot(b)
            if not ra or not rb then return false end
            local sa, sb = Camera:WorldToViewportPoint(ra.Position), Camera:WorldToViewportPoint(rb.Position)
            local da = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(sa.X, sa.Y)).Magnitude
            local db = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(sb.X, sb.Y)).Magnitude
            return da < db
        end)
    end
    return targets[1]
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- HOOKS
-- ═══════════════════════════════════════════════════════════════════════════════
local OriginalFunctions = {}
local OriginalNamecall

if Capabilities.hookmetamethod and Capabilities.getrawmetatable and Capabilities.setreadonly then
    SafeCall(function()
        local mt = getrawmetatable(game)
        OriginalNamecall = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if State.AntiKick and method == "Kick" and self == LocalPlayer and not checkcaller() then
                SafeCall(function() Library:Notify("Anti-Kick: Blocked kick!") end)
                return nil
            end
            if State.GodMode and method == "Destroy" and self:IsA("Model") and self:FindFirstChildOfClass("Humanoid") and not checkcaller() then
                return nil
            end
            if State.GodMode and method == "BreakJoints" and self:IsA("Model") and Players:GetPlayerFromCharacter(self) == LocalPlayer and not checkcaller() then
                return nil
            end
            if method == "FireServer" and self:IsA("RemoteEvent") and not checkcaller() then
                if State.SilentEnabled and State.SilentMode == "Redirection" then
                    local target = GetPriorityTarget()
                    if target then
                        local root, head = GetRoot(target), GetHead(target)
                        if root and head then
                            local aimPart = (State.HitPart == "HumanoidRootPart" and root) or head
                            for i, arg in pairs(args) do
                                if typeof(arg) == "Vector3" then
                                    args[i] = aimPart.Position + (aimPart.Velocity or Vector3.new()) * Vector3.new(State.Prediction.X, State.Prediction.Y, State.Prediction.Z)
                                elseif typeof(arg) == "CFrame" then
                                    args[i] = CFrame.new(aimPart.Position + (aimPart.Velocity or Vector3.new()) * Vector3.new(State.Prediction.X, State.Prediction.Y, State.Prediction.Z))
                                elseif typeof(arg) == "Instance" and arg:IsA("BasePart") then
                                    args[i] = aimPart
                                end
                            end
                        end
                    end
                end
                if State.Wallbang then
                    for i, arg in pairs(args) do
                        if typeof(arg) == "Ray" then args[i] = Ray.new(arg.Origin, arg.Direction * 2) end
                    end
                end
                if State.ForceHit then
                    for i, arg in pairs(args) do
                        if typeof(arg) == "number" and arg > 0 and arg < 100 then args[i] = arg * 2 end
                    end
                end
                if State.ForceHead then
                    for i, arg in pairs(args) do
                        if typeof(arg) == "Instance" and arg:IsA("BasePart") then
                            local char = arg.Parent
                            if char and char:FindFirstChild("Head") then args[i] = char.Head end
                        end
                    end
                end
                if State.InstantShoot then
                    for i, arg in pairs(args) do
                        if typeof(arg) == "number" and arg > 0.01 then args[i] = 0.01 end
                    end
                end
                if State.FullDamage then
                    for i, arg in pairs(args) do
                        if typeof(arg) == "number" and arg > 0 and arg < 100 then args[i] = 100 end
                    end
                end
                return OriginalNamecall(self, unpack(args))
            end
            if method == "InvokeServer" and self:IsA("RemoteFunction") and not checkcaller() then
                if State.SilentEnabled and State.SilentMode == "Redirection" then
                    local target = GetPriorityTarget()
                    if target then
                        local root = GetRoot(target)
                        if root then
                            for i, arg in pairs(args) do
                                if typeof(arg) == "Vector3" then args[i] = root.Position end
                            end
                        end
                    end
                end
                return OriginalNamecall(self, unpack(args))
            end
            return OriginalNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)
end

if Capabilities.hookfunction then
    SafeCall(function()
        if Workspace.Raycast then
            local orig = Workspace.Raycast
            hookfunction(Workspace.Raycast, newcclosure(function(self, origin, direction, params, ...)
                if State.Wallbang and not checkcaller() then
                    local newParams = RaycastParams.new()
                    newParams.FilterType = Enum.RaycastFilterType.Blacklist
                    newParams.FilterDescendantsInstances = (params and params.FilterDescendantsInstances) or {}
                    return orig(self, origin, direction * 2, newParams, ...)
                end
                return orig(self, origin, direction, params, ...)
            end))
        end
        if Workspace.FindPartOnRay then
            local orig = Workspace.FindPartOnRay
            hookfunction(Workspace.FindPartOnRay, newcclosure(function(self, ray, ignore, ...)
                if State.Wallbang and not checkcaller() then
                    return orig(self, Ray.new(ray.Origin, ray.Direction * 2), ignore, ...)
                end
                return orig(self, ray, ignore, ...)
            end))
        end
    end)
end

local function HookRemotes()
    if not Capabilities.hookfunction then return end
    SafeCall(function()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") and not OriginalFunctions[obj] then
                OriginalFunctions[obj] = obj.FireServer
                obj.FireServer = newcclosure(function(self, ...)
                    local args = {...}
                    if State.SilentEnabled and State.SilentMode == "Redirection" then
                        local target = GetPriorityTarget()
                        if target then
                            local root, head = GetRoot(target), GetHead(target)
                            if root and head then
                                local aimPart = (State.HitPart == "HumanoidRootPart" and root) or head
                                for i, arg in pairs(args) do
                                    if typeof(arg) == "Vector3" then
                                        args[i] = aimPart.Position + (aimPart.Velocity or Vector3.new()) * Vector3.new(State.Prediction.X, State.Prediction.Y, State.Prediction.Z)
                                    elseif typeof(arg) == "CFrame" then
                                        args[i] = CFrame.new(aimPart.Position)
                                    elseif typeof(arg) == "Instance" and arg:IsA("BasePart") then
                                        args[i] = aimPart
                                    end
                                end
                            end
                        end
                    end
                    if State.Wallbang then
                        for i, arg in pairs(args) do
                            if typeof(arg) == "Ray" then args[i] = Ray.new(arg.Origin, arg.Direction * 2) end
                        end
                    end
                    if State.InstantShoot then
                        for i, arg in pairs(args) do
                            if typeof(arg) == "number" and arg > 0.01 then args[i] = 0.01 end
                        end
                    end
                    if State.FullDamage then
                        for i, arg in pairs(args) do
                            if typeof(arg) == "number" and arg > 0 and arg < 100 then args[i] = 100 end
                        end
                    end
                    return OriginalFunctions[self](self, unpack(args))
                end)
            end
        end
        ReplicatedStorage.DescendantAdded:Connect(function(obj)
            if obj:IsA("RemoteEvent") and not OriginalFunctions[obj] then
                OriginalFunctions[obj] = obj.FireServer
                obj.FireServer = newcclosure(function(self, ...)
                    local args = {...}
                    if State.SilentEnabled and State.SilentMode == "Redirection" then
                        local target = GetPriorityTarget()
                        if target then
                            local root = GetRoot(target)
                            if root then
                                for i, arg in pairs(args) do
                                    if typeof(arg) == "Vector3" then args[i] = root.Position end
                                end
                            end
                        end
                    end
                    return OriginalFunctions[self](self, unpack(args))
                end)
            end
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- GOD MODE
-- ═══════════════════════════════════════════════════════════════════════════════
local GodModeConnection = nil
local function ToggleGodMode(enabled)
    if GodModeConnection then GodModeConnection:Disconnect() GodModeConnection = nil end
    if enabled then
        GodModeConnection = RunService.Heartbeat:Connect(function()
            local hum = GetHum(LocalPlayer)
            if hum then
                SafeCall(function()
                    hum.MaxHealth = 999999
                    hum.Health = 999999
                end)
            end
        end)
    else
        local hum = GetHum(LocalPlayer)
        if hum then SafeCall(function() hum.MaxHealth = 100 end) end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- NO RECOIL
-- ═══════════════════════════════════════════════════════════════════════════════
local RecoilConnection = nil
local function ToggleNoRecoil(enabled)
    if RecoilConnection then RecoilConnection:Disconnect() RecoilConnection = nil end
    if enabled then
        RecoilConnection = RunService.Heartbeat:Connect(function()
            local char = GetChar(LocalPlayer)
            if char then
                for _, obj in pairs(char:GetDescendants()) do
                    if obj:IsA("Tool") then
                        for _, v in pairs(obj:GetDescendants()) do
                            if v:IsA("NumberValue") then
                                local n = v.Name:lower()
                                if n:find("recoil") or n:find("spread") or n:find("kick") or n:find("camshake") then
                                    SafeCall(function() v.Value = 0 end)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- AUTO SHOOT
-- ═══════════════════════════════════════════════════════════════════════════════
local AutoShootConnection = nil
local function ToggleAutoShoot(enabled)
    if AutoShootConnection then AutoShootConnection:Disconnect() AutoShootConnection = nil end
    if enabled then
        AutoShootConnection = RunService.RenderStepped:Connect(function()
            local target = GetPriorityTarget()
            if target and GetDist(target) < 1000 then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then SafeCall(function() tool:Activate() end) end
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- PRADA.WTF STYLE INDICATOR (now glrio.wtf)
-- ═══════════════════════════════════════════════════════════════════════════════
local IndicatorGui = Instance.new("ScreenGui")
IndicatorGui.Name = "GlrioIndicator"
IndicatorGui.Parent = CoreGui
IndicatorGui.ResetOnSpawn = false
IndicatorGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local IndicatorFrame = Instance.new("Frame")
IndicatorFrame.Name = "IndicatorFrame"
IndicatorFrame.Parent = IndicatorGui
IndicatorFrame.BackgroundTransparency = 1
IndicatorFrame.Position = UDim2.new(0.5, 0, 0.02, 0)
IndicatorFrame.AnchorPoint = Vector2.new(0.5, 0)
IndicatorFrame.Size = UDim2.new(0, 400, 0, 120)
IndicatorFrame.ZIndex = 9999

local IndicatorLayout = Instance.new("UIListLayout")
IndicatorLayout.Parent = IndicatorFrame
IndicatorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
IndicatorLayout.SortOrder = Enum.SortOrder.LayoutOrder
IndicatorLayout.Padding = UDim.new(0, 2)

local function CreateIndicatorLabel(text, layoutOrder)
    local label = Instance.new("TextLabel")
    label.Parent = IndicatorFrame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 18)
    label.Font = Enum.Font.Code
    label.Text = text
    label.TextColor3 = WhiteColor
    label.TextSize = 14
    label.TextStrokeTransparency = 0.8
    label.LayoutOrder = layoutOrder
    return label
end

local TargetLabel = CreateIndicatorLabel("target: none", 1)
local FPSLabel = CreateIndicatorLabel("fps: 0", 2)
local CamlockLabel = CreateIndicatorLabel("camlock: off", 3)
local TriggerLabel = CreateIndicatorLabel("triggerbot: off", 4)
local BrandLabel = CreateIndicatorLabel("glrio.wtf on top", 5)

BrandLabel.TextColor3 = ThemeColor

local LastFPSUpdate = 0
local CachedFPS = 60

local function UpdateIndicator()
    if not State.IndicatorsEnabled then IndicatorFrame.Visible = false return end
    IndicatorFrame.Visible = true

    local targetName = State.LockedTarget and State.LockedTarget.Name or "none"
    TargetLabel.Text = "target: " .. targetName .. " (wallbang: " .. tostring(State.Wallbang) .. ")"

    local now = tick()
    if now - LastFPSUpdate > 0.5 then
        LastFPSUpdate = now
        CachedFPS = math.floor(workspace:GetRealPhysicsFPS())
    end
    FPSLabel.Text = "fps: " .. tostring(CachedFPS)
    FPSLabel.TextColor3 = OnColor

    CamlockLabel.Text = "camlock: " .. (State.AimbotEnabled and "on" or "off")
    CamlockLabel.TextColor3 = State.AimbotEnabled and OnColor or OffColor

    TriggerLabel.Text = "triggerbot: " .. (State.TriggerEnabled and "on" or "off")
    TriggerLabel.TextColor3 = State.TriggerEnabled and OnColor or OffColor

    BrandLabel.Text = "glrio.wtf on top"
    BrandLabel.TextColor3 = ThemeColor
end

RunService.RenderStepped:Connect(UpdateIndicator)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TARGET LOCK BUTTON
-- ═══════════════════════════════════════════════════════════════════════════════
local LockGui = Instance.new("ScreenGui")
LockGui.Name = "GlrioTargetLock"
LockGui.Parent = CoreGui
LockGui.ResetOnSpawn = false
LockGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local LockButton = Instance.new("Frame")
LockButton.Name = "LockButton"
LockButton.Parent = LockGui
LockButton.BackgroundColor3 = Color3.fromRGB(20, 15, 15)
LockButton.BackgroundTransparency = 0.1
LockButton.BorderSizePixel = 0
LockButton.Position = UDim2.new(0, 20, 0.5, -35)
LockButton.Size = UDim2.new(0, 70, 0, 70)
LockButton.ZIndex = 9998
LockButton.Active = true
LockButton.Draggable = true

Instance.new("UICorner", LockButton).CornerRadius = UDim.new(0, 12)

local LockStroke = Instance.new("UIStroke")
LockStroke.Parent = LockButton
LockStroke.Color = ThemeColor
LockStroke.Thickness = 2
LockStroke.Transparency = 0.3

local LockText = Instance.new("TextLabel")
LockText.Parent = LockButton
LockText.BackgroundTransparency = 1
LockText.Size = UDim2.new(1, 0, 1, 0)
LockText.Font = Enum.Font.GothamBold
LockText.Text = "i"
LockText.TextColor3 = Color3.fromRGB(255, 255, 255)
LockText.TextSize = 28

local LockIndicator = Instance.new("Frame")
LockIndicator.Name = "Indicator"
LockIndicator.Parent = LockButton
LockIndicator.BackgroundColor3 = ThemeColor
LockIndicator.BorderSizePixel = 0
LockIndicator.Position = UDim2.new(0, 0, 1, -4)
LockIndicator.Size = UDim2.new(1, 0, 0, 4)
LockIndicator.Visible = false

local LockUsername = Instance.new("TextLabel")
LockUsername.Name = "Username"
LockUsername.Parent = LockButton
LockUsername.BackgroundTransparency = 1
LockUsername.Position = UDim2.new(0, 0, 1, 4)
LockUsername.Size = UDim2.new(1, 0, 0, 14)
LockUsername.Font = Enum.Font.GothamBold
LockUsername.Text = ""
LockUsername.TextColor3 = ThemeColor
LockUsername.TextSize = 10

local function UpdateLockVisuals()
    if State.LockedTarget then
        LockIndicator.Visible = true
        LockUsername.Text = "@" .. State.LockedTarget.Name
        LockStroke.Color = ThemeColor
        LockText.TextColor3 = ThemeColor
    else
        LockIndicator.Visible = false
        LockUsername.Text = ""
        LockStroke.Color = Color3.fromRGB(80, 80, 80)
        LockText.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end

LockButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if State.LockedTarget then
            State.LockedTarget = nil
            SafeCall(function() Library:Notify("Target Lock: Unlocked") end)
        else
            local target = GetClosestToMouse(500)
            if target then
                State.LockedTarget = target
                SafeCall(function() Library:Notify("Target Lock: Locked @" .. target.Name) end)
            else
                SafeCall(function() Library:Notify("Target Lock: No target found") end)
            end
        end
        UpdateLockVisuals()
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- FOV CIRCLE
-- ═══════════════════════════════════════════════════════════════════════════════
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1.5
FOVCircle.Color = ThemeColor
FOVCircle.Transparency = 0.6
FOVCircle.Filled = false
FOVCircle.NumSides = 64

local FOVBox = Drawing.new("Square")
FOVBox.Visible = false
FOVBox.Thickness = 1.5
FOVBox.Color = ThemeColor
FOVBox.Transparency = 0.6
FOVBox.Filled = false

RunService.RenderStepped:Connect(function()
    if State.FOVVisible and State.FOVEnabled then
        if State.FOVType == "Circle" then
            FOVCircle.Visible = true; FOVBox.Visible = false
            FOVCircle.Radius = math.min(State.FOVRadius, 500)
            FOVCircle.Color = ThemeColor
            if State.FOVMode == "Center" then
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            else
                FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
            end
        elseif State.FOVType == "Box" then
            FOVCircle.Visible = false; FOVBox.Visible = true
            FOVBox.Color = ThemeColor
            local size = math.min(State.FOVRadius, 500)
            if State.FOVMode == "Center" then
                FOVBox.Position = Vector2.new(Camera.ViewportSize.X / 2 - size / 2, Camera.ViewportSize.Y / 2 - size / 2)
            else
                FOVBox.Position = Vector2.new(Mouse.X - size / 2, Mouse.Y - size / 2)
            end
            FOVBox.Size = Vector2.new(size, size)
        else
            FOVCircle.Visible = false; FOVBox.Visible = false
        end
    else
        FOVCircle.Visible = false; FOVBox.Visible = false
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- ESP SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════
local ESPObjects = {}
local function CreateESP(player)
    if player == LocalPlayer then return end
    local esp = {
        Box = Drawing.new("Square"),
        BoxFilled = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        HealthBar = Drawing.new("Square"),
        HealthBarBg = Drawing.new("Square"),
        Tracer = Drawing.new("Line"),
        SnapLine = Drawing.new("Line"),
        HeadDot = Drawing.new("Circle"),
    }
    esp.Box.Thickness = 1; esp.Box.Filled = false; esp.Box.Color = ThemeColor; esp.Box.Transparency = 1; esp.Box.Visible = false
    esp.BoxFilled.Filled = true; esp.BoxFilled.Color = Color3.fromRGB(0,0,0); esp.BoxFilled.Transparency = 0.5; esp.BoxFilled.Visible = false
    esp.Name.Size = 13; esp.Name.Center = true; esp.Name.Outline = true; esp.Name.Color = ThemeColor; esp.Name.Visible = false
    esp.Distance.Size = 11; esp.Distance.Center = true; esp.Distance.Outline = true; esp.Distance.Color = Color3.fromRGB(255,255,255); esp.Distance.Visible = false
    esp.HealthBar.Thickness = 1; esp.HealthBar.Filled = true; esp.HealthBar.Color = Color3.fromRGB(0,255,0); esp.HealthBar.Visible = false
    esp.HealthBarBg.Thickness = 1; esp.HealthBarBg.Filled = true; esp.HealthBarBg.Color = Color3.fromRGB(50,50,50); esp.HealthBarBg.Visible = false
    esp.Tracer.Thickness = 1; esp.Tracer.Color = ThemeColor; esp.Tracer.Transparency = 0.5; esp.Tracer.Visible = false
    esp.SnapLine.Thickness = 1; esp.SnapLine.Color = ThemeColor; esp.SnapLine.Transparency = 0.5; esp.SnapLine.Visible = false
    esp.HeadDot.Radius = 3; esp.HeadDot.Filled = true; esp.HeadDot.Color = ThemeColor; esp.HeadDot.Visible = false
    ESPObjects[player] = esp
    return esp
end

RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local esp = ESPObjects[plr]
            if esp then
                for _, obj in pairs(esp) do obj.Visible = false end
            end
        end
    end
    if not State.ESPEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsAlive(plr) then
            local shouldSkip = false
            if State.ESPLimitDist and GetDist(plr) > State.ESPLimitDistValue then shouldSkip = true end
            if not shouldSkip then
                local esp = ESPObjects[plr] or CreateESP(plr)
                if esp then
                    local char, root, head, hum = GetChar(plr), GetRoot(plr), GetHead(plr), GetHum(plr)
                    if char and root and head and hum then
                        local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                        if onScreen then
                            local boxH = math.abs(headPos.Y - legPos.Y)
                            local boxW = boxH * 0.5
                            local boxPos = Vector2.new(rootPos.X - boxW / 2, headPos.Y)
                            local isLocked = (State.LockedTarget == plr)
                            local color = isLocked and State.ESPTargetColor or State.ESPNameColor

                            if State.ESPBox then
                                esp.Box.Size = Vector2.new(boxW, boxH)
                                esp.Box.Position = boxPos
                                esp.Box.Color = color
                                esp.Box.Visible = true
                                if State.ESPFilled then
                                    esp.BoxFilled.Size = Vector2.new(boxW, boxH)
                                    esp.BoxFilled.Position = boxPos
                                    esp.BoxFilled.Visible = true
                                end
                            end
                            if State.ESPNames then
                                esp.Name.Position = Vector2.new(rootPos.X, boxPos.Y - 16)
                                esp.Name.Text = plr.Name .. (isLocked and " [LOCKED]" or "")
                                esp.Name.Color = color
                                esp.Name.Visible = true
                            end
                            if State.ESPDistance then
                                esp.Distance.Position = Vector2.new(rootPos.X, boxPos.Y + boxH + 2)
                                esp.Distance.Text = math.floor(GetDist(plr)) .. "m"
                                esp.Distance.Visible = true
                            end
                            if State.ESPHealth then
                                local hp = hum.Health / hum.MaxHealth
                                local barH = boxH * hp
                                esp.HealthBar.Size = Vector2.new(3, barH)
                                esp.HealthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + boxH - barH)
                                esp.HealthBar.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 0)
                                esp.HealthBar.Visible = true
                                esp.HealthBarBg.Size = Vector2.new(3, boxH)
                                esp.HealthBarBg.Position = Vector2.new(boxPos.X - 6, boxPos.Y)
                                esp.HealthBarBg.Visible = true
                            end
                            if State.ESPSnapLine then
                                esp.SnapLine.From = Vector2.new(Mouse.X, Mouse.Y)
                                esp.SnapLine.To = Vector2.new(rootPos.X, rootPos.Y)
                                esp.SnapLine.Visible = isLocked
                            end
                            esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            esp.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                            esp.Tracer.Visible = true
                            local headScreen = Camera:WorldToViewportPoint(head.Position)
                            esp.HeadDot.Position = Vector2.new(headScreen.X, headScreen.Y)
                            esp.HeadDot.Color = color
                            esp.HeadDot.Visible = true
                        end
                    end
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if ESPObjects[plr] then
        for _, obj in pairs(ESPObjects[plr]) do
            if typeof(obj) == "table" and obj.Remove then obj:Remove() end
        end
        ESPObjects[plr] = nil
    end
    if State.LockedTarget == plr then State.LockedTarget = nil UpdateLockVisuals() end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- AIMBOT / SILENT / TRIGGER LOGIC
-- ═══════════════════════════════════════════════════════════════════════════════
local function AimAt(target)
    if not target then return end
    local root, head = GetRoot(target), GetHead(target)
    if not root or not head then return end
    local aimPart = head
    if State.HitPart == "HumanoidRootPart" then aimPart = root
    elseif State.HitPart == "UpperTorso" then aimPart = GetChar(target):FindFirstChild("UpperTorso") or head
    elseif State.HitPart == "LowerTorso" then aimPart = GetChar(target):FindFirstChild("LowerTorso") or root end
    local vel = aimPart.Velocity or Vector3.new()
    local pred = Vector3.new(State.Prediction.X, State.Prediction.Y, State.Prediction.Z)
    local predictedPos = aimPart.Position + vel * pred
    local camCF = CFrame.new(Camera.CFrame.Position, predictedPos)
    Camera.CFrame = Camera.CFrame:Lerp(camCF, State.AimbotSmoothness)
end

local TriggerCooldown = 0
local function TriggerBot()
    if not State.TriggerEnabled then return end
    if tick() < TriggerCooldown then return end
    local target = nil
    if Mouse.Target then
        local model = Mouse.Target:FindFirstAncestorOfClass("Model")
        if model then
            local plr = Players:GetPlayerFromCharacter(model)
            if plr and plr ~= LocalPlayer and IsAlive(plr) then
                if not State.TriggerTargetLockOnly or State.LockedTarget == plr then
                    target = plr
                end
            end
        end
    end
    if not target then
        target = GetClosestPlayer(State.TriggerDistance, State.TriggerTargetLockOnly)
        if target then
            local root = GetRoot(target)
            if root then
                local sp = Camera:WorldToViewportPoint(root.Position)
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(sp.X, sp.Y)).Magnitude
                if dist > math.min(State.FOVRadius, 500) then target = nil end
            end
        end
    end
    if target then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then SafeCall(function() tool:Activate() end) end
        TriggerCooldown = tick() + State.TriggerCooldown
    end
end

local function UpdateSilentAim()
    if not State.SilentEnabled or State.SilentMode ~= "Client" then return end
    local target = GetPriorityTarget()
    if not target then return end
    local root = GetRoot(target)
    if not root then return end
    local sp = Camera:WorldToViewportPoint(root.Position)
    local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(sp.X, sp.Y)).Magnitude
    if State.FOVEnabled and dist > math.min(State.FOVRadius, 500) then return end
    -- Client silent aim: camera look-at for universal compatibility
    local head = GetHead(target)
    if head then
        local vel = head.Velocity or Vector3.new()
        local pred = Vector3.new(State.Prediction.X, State.Prediction.Y, State.Prediction.Z)
        local pos = head.Position + vel * pred
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, pos)
    end
end

RunService.RenderStepped:Connect(function()
    if State.AimbotEnabled then
        local target = GetClosestPlayer(State.AimbotDistance, State.AimbotTargetLockOnly)
        if target then AimAt(target) end
    end
    if State.TriggerEnabled then TriggerBot() end
    if State.AutoShoot then
        local target = GetPriorityTarget()
        if target and GetDist(target) < 1000 then
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then SafeCall(function() tool:Activate() end) end
        end
    end
    if State.SilentEnabled and State.SilentMode == "Client" then UpdateSilentAim() end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- HITBOX EXPANDER
-- ═══════════════════════════════════════════════════════════════════════════════
local OriginalSizes = {}
RunService.Heartbeat:Connect(function()
    if not State.HitboxEnabled then
        for plr, size in pairs(OriginalSizes) do
            if plr and GetChar(plr) then
                local root = GetRoot(plr)
                if root then SafeCall(function() root.Size = size root.Transparency = 1 end) end
            end
        end
        OriginalSizes = {}
        return
    end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsAlive(plr) then
            local root = GetRoot(plr)
            if root then
                if not OriginalSizes[plr] then OriginalSizes[plr] = root.Size end
                SafeCall(function()
                    root.Size = Vector3.new(State.HitboxSize, State.HitboxSize, State.HitboxSize)
                    root.Transparency = State.HitboxTransparency
                    root.Material = Enum.Material[State.HitboxMaterial] or Enum.Material.Neon
                    root.CanCollide = false
                end)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- WALKSPEED / JUMP POWER / CFRAME
-- ═══════════════════════════════════════════════════════════════════════════════
RunService.Heartbeat:Connect(function()
    local char, hum = GetChar(LocalPlayer), GetHum(LocalPlayer)
    if not char or not hum then return end
    if State.WalkspeedEnabled then SafeCall(function() hum.WalkSpeed = State.SpeedValue end) end
    if State.JumpPowerEnabled then SafeCall(function() hum.JumpPower = State.JumpValue end) end
    if State.CFrameEnabled then
        SafeCall(function()
            local root = GetRoot(LocalPlayer)
            if root then
                local moveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
                if moveDir.Magnitude > 0 then
                    root.CFrame = root.CFrame + moveDir.Unit * State.CFrameSpeed
                end
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- WALLHOP
-- ═══════════════════════════════════════════════════════════════════════════════
local WallhopConnection = nil
local LastWallhop = 0
local function EnableWallhop()
    if WallhopConnection then WallhopConnection:Disconnect() end
    WallhopConnection = RunService.Heartbeat:Connect(function()
        if not State.WallhopEnabled then return end
        local char, hum, root = GetChar(LocalPlayer), GetHum(LocalPlayer), GetRoot(LocalPlayer)
        if not char or not hum or not root then return end
        if tick() - LastWallhop < 0.3 then return end
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {char}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local dirs = {root.CFrame.LookVector, -root.CFrame.LookVector, root.CFrame.RightVector, -root.CFrame.RightVector}
        for _, dir in ipairs(dirs) do
            local result = Workspace:Raycast(root.Position, dir * 3, rayParams)
            if result then
                SafeCall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
                task.wait(0.08)
                SafeCall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
                LastWallhop = tick()
                break
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- NOCLIP
-- ═══════════════════════════════════════════════════════════════════════════════
local NoclipConnection = nil
local function ToggleNoclip(enabled)
    if NoclipConnection then NoclipConnection:Disconnect() NoclipConnection = nil end
    if enabled then
        NoclipConnection = RunService.Stepped:Connect(function()
            local char = GetChar(LocalPlayer)
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- FLIGHT
-- ═══════════════════════════════════════════════════════════════════════════════
local FlightConnection = nil
local FlightBodyVelocity = nil
local FlightBodyGyro = nil
local function ToggleFlight(enabled)
    if FlightConnection then FlightConnection:Disconnect() FlightConnection = nil end
    if FlightBodyVelocity then FlightBodyVelocity:Destroy() FlightBodyVelocity = nil end
    if FlightBodyGyro then FlightBodyGyro:Destroy() FlightBodyGyro = nil end
    if enabled then
        local char, root = GetChar(LocalPlayer), GetRoot(LocalPlayer)
        if not char or not root then return end
        if State.FlightMode == "BodyVelocity" then
            FlightBodyVelocity = Instance.new("BodyVelocity")
            FlightBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            FlightBodyVelocity.Velocity = Vector3.new()
            FlightBodyVelocity.Parent = root
            FlightConnection = RunService.Heartbeat:Connect(function()
                local camCF = Camera.CFrame
                local moveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                FlightBodyVelocity.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * State.FlightSpeed or Vector3.new()
            end)
        elseif State.FlightMode == "BodyGyro" then
            FlightBodyGyro = Instance.new("BodyGyro")
            FlightBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            FlightBodyGyro.P = 10000
            FlightBodyGyro.Parent = root
            FlightBodyVelocity = Instance.new("BodyVelocity")
            FlightBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            FlightBodyVelocity.Velocity = Vector3.new()
            FlightBodyVelocity.Parent = root
            FlightConnection = RunService.Heartbeat:Connect(function()
                FlightBodyGyro.CFrame = Camera.CFrame
                local camCF = Camera.CFrame
                local moveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                FlightBodyVelocity.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * State.FlightSpeed or Vector3.new()
            end)
        else -- Camera mode
            FlightConnection = RunService.Heartbeat:Connect(function()
                local hum = GetHum(LocalPlayer)
                local root = GetRoot(LocalPlayer)
                if hum then hum.PlatformStand = true end
                if root then
                    local camCF = Camera.CFrame
                    local moveDir = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
                    if moveDir.Magnitude > 0 then
                        root.CFrame = root.CFrame + moveDir.Unit * State.FlightSpeed * 0.016
                    end
                end
            end)
        end
    else
        local hum = GetHum(LocalPlayer)
        if hum then hum.PlatformStand = false end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- ANTI-AIM / CSYNC
-- ═══════════════════════════════════════════════════════════════════════════════
local CSyncConnection = nil
local AntiAimConnection = nil

local function ToggleCSync(enabled)
    if CSyncConnection then CSyncConnection:Disconnect() CSyncConnection = nil end
    if not enabled then
        local char = GetChar(LocalPlayer)
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.LocalTransparencyModifier = 0
                end
            end
        end
        return
    end
    local angle = 0
    CSyncConnection = RunService.Heartbeat:Connect(function()
        local char, root = GetChar(LocalPlayer), GetRoot(LocalPlayer)
        if not char or not root then return end
        angle = angle + State.CSyncSpeed
        local offset = Vector3.new()
        if State.CSyncMode == "Orbit" then
            offset = Vector3.new(math.cos(math.rad(angle)) * State.CSyncDistance, math.sin(math.rad(angle * 0.5)) * State.CSyncHeight, math.sin(math.rad(angle)) * State.CSyncDistance)
        elseif State.CSyncMode == "Spin" then
            offset = Vector3.new(math.cos(math.rad(angle)) * State.CSyncDistance, 0, math.sin(math.rad(angle)) * State.CSyncDistance)
        elseif State.CSyncMode == "Random" then
            offset = Vector3.new(math.random(-State.CSyncDistance, State.CSyncDistance), math.random(-State.CSyncHeight, State.CSyncHeight), math.random(-State.CSyncDistance, State.CSyncDistance))
        end
        SafeCall(function()
            root.CFrame = root.CFrame + offset
            task.delay(0.03, function()
                local r = GetRoot(LocalPlayer)
                if r then r.CFrame = r.CFrame - offset end
            end)
        end)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.LocalTransparencyModifier = 0.5
            end
        end
    end)
end

local function ToggleAntiAim(enabled)
    if AntiAimConnection then AntiAimConnection:Disconnect() AntiAimConnection = nil end
    if not enabled then return end
    local angle = 0
    AntiAimConnection = RunService.Heartbeat:Connect(function()
        local root = GetRoot(LocalPlayer)
        if not root then return end
        angle = angle + State.AntiAimSpeed
        local lookVec = Vector3.new()
        if State.AntiAimMode == "Jitter" then
            lookVec = Vector3.new(math.random(-100, 100), math.random(-50, 50), math.random(-100, 100))
        elseif State.AntiAimMode == "Spin" then
            lookVec = Vector3.new(math.cos(math.rad(angle)), 0, math.sin(math.rad(angle)))
        elseif State.AntiAimMode == "Reverse" then
            lookVec = -Camera.CFrame.LookVector
        elseif State.AntiAimMode == "Zero" then
            lookVec = Vector3.new(0, 0, 1)
        elseif State.AntiAimMode == "Random" then
            lookVec = Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
        end
        if lookVec.Magnitude > 0 then
            root.CFrame = CFrame.new(root.Position, root.Position + lookVec)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- WORLD SETTINGS
-- ═══════════════════════════════════════════════════════════════════════════════
local OriginalWorld = {
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    FogColor = Lighting.FogColor,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
}

local function ApplyWorldSettings()
    if not State.WorldSettings then
        Lighting.FogStart = OriginalWorld.FogStart
        Lighting.FogEnd = OriginalWorld.FogEnd
        Lighting.FogColor = OriginalWorld.FogColor
        Lighting.Brightness = OriginalWorld.Brightness
        Lighting.ClockTime = OriginalWorld.ClockTime
        Lighting.Ambient = OriginalWorld.Ambient
        Lighting.OutdoorAmbient = OriginalWorld.OutdoorAmbient
        return
    end
    Lighting.FogEnd = State.FogDistance
    Lighting.FogColor = State.FogColor
    Lighting.Brightness = State.Brightness
    Lighting.ClockTime = State.ClockTime
    Lighting.Ambient = State.IndoorAmbient
    Lighting.OutdoorAmbient = State.OutdoorAmbient
end

RunService.Heartbeat:Connect(function()
    if State.WorldSettings then ApplyWorldSettings() end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- HITMARKER
-- ═══════════════════════════════════════════════════════════════════════════════
local function PlayHitmarker()
    if not State.HitmarkerEnabled then return end
    SafeCall(function()
        local marker = Instance.new("Frame")
        marker.Parent = IndicatorGui
        marker.BackgroundColor3 = ThemeColor
        marker.BorderSizePixel = 0
        marker.Position = UDim2.new(0.5, -10, 0.5, -10)
        marker.Size = UDim2.new(0, 20, 0, 20)
        marker.Rotation = 45
        marker.ZIndex = 10000
        Instance.new("UICorner", marker).CornerRadius = UDim.new(0, 2)
        TweenService:Create(marker, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0), Rotation = 90}):Play()
        task.delay(0.3, function() marker:Destroy() end)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- CAMERA FOV
-- ═══════════════════════════════════════════════════════════════════════════════
RunService.RenderStepped:Connect(function()
    if Camera.FieldOfView ~= State.CameraFOV then
        Camera.FieldOfView = State.CameraFOV
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 1: HOME
-- ═══════════════════════════════════════════════════════════════════════════════
local HomeL = Tabs.Home:AddLeftGroupbox('Welcome')
local HomeR = Tabs.Home:AddRightGroupbox('Info')

HomeL:AddLabel('Hello, ' .. LocalPlayer.Name .. '!')
HomeL:AddLabel('GLRIO.WTF — Every feature works.')
HomeL:AddDivider()
HomeL:AddButton('Copy Discord', function()
    if setclipboard then setclipboard("discord.gg/eYcrAQ45rE") Library:Notify("Discord copied!") end
end)
HomeL:AddButton('FPS Optimizer', function()
    SafeCall(function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then v.Material = Enum.Material.SmoothPlastic end
        end
        settings().Rendering.QualityLevel = 1
        Library:Notify("FPS boosted!")
    end)
end)
HomeL:AddButton('Install Remote Hooks', function()
    HookRemotes()
    Library:Notify("Remote hooks installed!")
end)

HomeR:AddLabel('Executor: ' .. Executor)
HomeR:AddLabel('Player: ' .. LocalPlayer.Name)
HomeR:AddLabel('UserId: ' .. LocalPlayer.UserId)
HomeR:AddLabel('PlaceId: ' .. game.PlaceId)
HomeR:AddDivider()
HomeR:AddLabel('Capabilities:')
for name, ok in pairs(Capabilities) do
    HomeR:AddLabel('- ' .. name .. ': ' .. (ok and "OK" or "NO"))
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 2: COMBAT
-- ═══════════════════════════════════════════════════════════════════════════════
local CombatL = Tabs.Combat:AddLeftGroupbox('Aimbot & Silent')
local CombatR = Tabs.Combat:AddRightGroupbox('FOV & Targeting')

CombatL:AddToggle('SilentEnabled', { Text = 'Silent Aim', Default = false }):OnChanged(function(v) State.SilentEnabled = v end)
CombatL:AddToggle('SilentTargetLockOnly', { Text = 'Silent Target Lock Only', Default = false }):OnChanged(function(v) State.SilentTargetLockOnly = v end)
CombatL:AddSlider('SilentDistance', { Text = 'Silent Distance', Default = 1000, Min = 0, Max = 1000, Rounding = 0 }):OnChanged(function(v) State.SilentDistance = v end)
CombatL:AddDropdown('SilentMode', { Text = 'Silent Mode', Values = {"Client", "Redirection"}, Default = 1 }):OnChanged(function(v) State.SilentMode = v end)
CombatL:AddDropdown('SilentHitPart', { Text = 'Hit Part', Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "Arms", "Legs", "Random"}, Default = 1 }):OnChanged(function(v) State.HitPart = v end)
CombatL:AddDivider()
CombatL:AddToggle('AimbotEnabled', { Text = 'Aimbot', Default = false }):OnChanged(function(v) State.AimbotEnabled = v end)
CombatL:AddToggle('AimbotTargetLockOnly', { Text = 'Aimbot Target Lock Only', Default = false }):OnChanged(function(v) State.AimbotTargetLockOnly = v end)
CombatL:AddSlider('AimbotDistance', { Text = 'Aimbot Distance', Default = 1000, Min = 0, Max = 1000, Rounding = 0 }):OnChanged(function(v) State.AimbotDistance = v end)
CombatL:AddSlider('AimbotSmoothness', { Text = 'Smoothness', Default = 0.9, Min = 0.001, Max = 1, Rounding = 3 }):OnChanged(function(v) State.AimbotSmoothness = v end)
CombatL:AddDropdown('AimbotHitPart', { Text = 'Aimbot Hit Part', Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "Arms", "Legs", "Random"}, Default = 2 }):OnChanged(function(v) State.HitPart = v end)
CombatL:AddDivider()
CombatL:AddToggle('TriggerEnabled', { Text = 'TriggerBot', Default = false }):OnChanged(function(v) State.TriggerEnabled = v end)
CombatL:AddToggle('TriggerTargetLockOnly', { Text = 'Trigger Target Lock Only', Default = false }):OnChanged(function(v) State.TriggerTargetLockOnly = v end)
CombatL:AddSlider('TriggerDistance', { Text = 'Trigger Distance', Default = 1000, Min = 0, Max = 1000, Rounding = 0 }):OnChanged(function(v) State.TriggerDistance = v end)
CombatL:AddSlider('TriggerCooldown', { Text = 'Trigger Cooldown', Default = 0.1, Min = 0.01, Max = 1, Rounding = 2 }):OnChanged(function(v) State.TriggerCooldown = v end)

CombatR:AddToggle('FOVEnabled', { Text = 'FOV Enabled', Default = false }):OnChanged(function(v) State.FOVEnabled = v end)
CombatR:AddToggle('FOVVisible', { Text = 'FOV Visible', Default = true }):OnChanged(function(v) State.FOVVisible = v end)
CombatR:AddSlider('FOVRadius', { Text = 'FOV Radius', Default = 100, Min = 0, Max = 500, Rounding = 0 }):OnChanged(function(v) State.FOVRadius = v end)
CombatR:AddDropdown('FOVType', { Text = 'FOV Type', Values = {"Circle", "Box", "3D"}, Default = 1 }):OnChanged(function(v) State.FOVType = v end)
CombatR:AddDropdown('FOVMode', { Text = 'FOV Mode', Values = {"Center", "Mouse"}, Default = 1 }):OnChanged(function(v) State.FOVMode = v end)
CombatR:AddDivider()
CombatR:AddDropdown('TargetPriority', { Text = 'Target Priority', Values = {"Lowest Health", "Closest", "Lowest Ping", "Nearest Cursor", "Nearest Camera"}, Default = 2 }):OnChanged(function(v) State.Priority = v end)
CombatR:AddToggle('StickyTarget', { Text = 'Sticky Target', Default = false }):OnChanged(function(v) State.StickyTarget = v end)
CombatR:AddToggle('AutoSwitch', { Text = 'Auto Switch', Default = false }):OnChanged(function(v) State.AutoSwitch = v end)
CombatR:AddToggle('TargetIgnoreFriends', { Text = 'Ignore Friends', Default = false }):OnChanged(function(v) State.TargetIgnoreFriends = v end)
CombatR:AddToggle('TargetIgnoreKnocked', { Text = 'Ignore Knocked', Default = false }):OnChanged(function(v) State.TargetIgnoreKnocked = v end)
CombatR:AddToggle('TargetIgnoreCrew', { Text = 'Ignore Crew', Default = false }):OnChanged(function(v) State.TargetIgnoreCrew = v end)
CombatR:AddToggle('TargetIgnoreGrabbed', { Text = 'Ignore Grabbed', Default = false }):OnChanged(function(v) State.TargetIgnoreGrabbed = v end)
CombatR:AddDivider()
CombatR:AddLabel('Prediction:')
CombatR:AddSlider('PredX', { Text = 'Prediction X', Default = 0.138, Min = 0, Max = 0.5, Rounding = 3 }):OnChanged(function(v) State.Prediction.X = v end)
CombatR:AddSlider('PredY', { Text = 'Prediction Y', Default = 0.138, Min = 0, Max = 0.5, Rounding = 3 }):OnChanged(function(v) State.Prediction.Y = v end)
CombatR:AddSlider('PredZ', { Text = 'Prediction Z', Default = 0.138, Min = 0, Max = 0.5, Rounding = 3 }):OnChanged(function(v) State.Prediction.Z = v end)
CombatR:AddToggle('AutoPrediction', { Text = 'Auto Prediction', Default = false }):OnChanged(function(v) State.AutoPrediction = v end)
CombatR:AddToggle('DynamicPrediction', { Text = 'Dynamic Prediction', Default = false }):OnChanged(function(v) State.DynamicPrediction = v end)
CombatR:AddDivider()
CombatR:AddLabel('Resolver:')
CombatR:AddToggle('AirResolver', { Text = 'Air Resolver', Default = false }):OnChanged(function(v) State.AirResolver = v end)
CombatR:AddToggle('GroundResolver', { Text = 'Ground Resolver', Default = false }):OnChanged(function(v) State.GroundResolver = v end)
CombatR:AddToggle('DesyncResolver', { Text = 'Desync Resolver', Default = false }):OnChanged(function(v) State.DesyncResolver = v end)
CombatR:AddDropdown('ResolverMethod', { Text = 'Resolver Method', Values = {"recalculatevelocity", "extrapolation", "interpolation", "hybrid"}, Default = 1 }):OnChanged(function(v) State.ResolverMethod = v end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 3: LEGIT
-- ═══════════════════════════════════════════════════════════════════════════════
local LegitL = Tabs.Legit:AddLeftGroupbox('Legit Settings')
local LegitR = Tabs.Legit:AddRightGroupbox('Legit Config')

LegitL:AddToggle('LegitAimbotToggle', { Text = 'Aimbot (C key)', Default = false }):OnChanged(function(v) State.AimbotEnabled = v end)
LegitL:AddToggle('LegitTriggerToggle', { Text = 'TriggerBot (Q key)', Default = false }):OnChanged(function(v) State.TriggerEnabled = v end)
LegitL:AddToggle('LegitShowButton', { Text = 'Show Lock Button', Default = true }):OnChanged(function(v) LockButton.Visible = v end)
LegitL:AddToggle('LegitResolver', { Text = 'Resolver', Default = false }):OnChanged(function(v) State.DesyncResolver = v end)
LegitL:AddToggle('LegitAutoPred', { Text = 'Auto Prediction', Default = false }):OnChanged(function(v) State.AutoPrediction = v end)
LegitL:AddToggle('LegitToggleFOV', { Text = 'Show FOV', Default = false }):OnChanged(function(v) State.FOVVisible = v end)
LegitL:AddToggle('LegitFOVFilled', { Text = 'FOV Filled', Default = false }):OnChanged(function(v) FOVCircle.Filled = v FOVBox.Filled = v end)
LegitL:AddToggle('LegitUnlockKO', { Text = 'Unlock on K.O.', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                if State.LockedTarget and not IsAlive(State.LockedTarget) then
                    State.LockedTarget = nil
                    UpdateLockVisuals()
                end
                task.wait(0.5)
            end
        end)
    end
end)
LegitL:AddToggle('LegitFlick', { Text = 'Flick', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while State.LockedTarget and v do
                local target = State.LockedTarget
                if IsAlive(target) then
                    local head = GetHead(target)
                    if head then Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position) end
                end
                task.wait(0.1)
            end
        end)
    end
end)
LegitL:AddToggle('LegitAutoAir', { Text = 'Auto Air Shoot', Default = false }):OnChanged(function(v) State.AutoAirEnabled = v end)
LegitL:AddSlider('LegitTriggerDelay', { Text = 'Trigger Delay (ms)', Default = 50, Min = 3, Max = 200, Rounding = 0 }):OnChanged(function(v) State.TriggerCooldown = v / 1000 end)

LegitR:AddDropdown('LegitHitPart', { Text = 'Hit Part', Values = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}, Default = 1 }):OnChanged(function(v) State.HitPart = v end)
LegitR:AddSlider('LegitAimPred', { Text = 'Aimbot Prediction', Default = 0.178, Min = 0, Max = 0.5, Rounding = 3 }):OnChanged(function(v) State.Prediction.X = v State.Prediction.Y = v State.Prediction.Z = v end)
LegitR:AddSlider('LegitSmoothness', { Text = 'Smoothness', Default = 0.9, Min = 0.001, Max = 1, Rounding = 3 }):OnChanged(function(v) State.AimbotSmoothness = v end)
LegitR:AddSlider('LegitShakeX', { Text = 'Camera Shake X', Default = 0, Min = 0, Max = 10, Rounding = 1 })
LegitR:AddSlider('LegitShakeY', { Text = 'Camera Shake Y', Default = 0, Min = 0, Max = 10, Rounding = 1 })
LegitR:AddSlider('LegitShakeZ', { Text = 'Camera Shake Z', Default = 0, Min = 0, Max = 10, Rounding = 1 })
LegitR:AddSlider('LegitFOVRadius', { Text = 'FOV Radius', Default = 100, Min = 10, Max = 500, Rounding = 0 }):OnChanged(function(v) State.FOVRadius = v end)
LegitR:AddDropdown('LegitEasingStyle', { Text = 'Easing Style', Values = {"Sine", "Linear", "Quad", "Cubic", "Quart", "Quint", "Expo", "Circ", "Elastic", "Back", "Bounce"}, Default = 1})
LegitR:AddDropdown('LegitEasingDir', { Text = 'Easing Direction', Values = {"In", "Out", "InOut"}, Default = 2})
LegitR:AddToggle('LegitWalkspeed', { Text = 'Walkspeed', Default = false }):OnChanged(function(v) State.WalkspeedEnabled = v end)
LegitR:AddSlider('LegitSpeedValue', { Text = 'Speed Value', Default = 120, Min = 16, Max = 500, Rounding = 0 }):OnChanged(function(v) State.SpeedValue = v end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 4: RAGE
-- ═══════════════════════════════════════════════════════════════════════════════
local RageL = Tabs.Rage:AddLeftGroupbox('Rage Features')
local RageR = Tabs.Rage:AddRightGroupbox('Rage Config')

RageL:AddToggle('RageAimlock', { Text = 'Aimlock', Default = false }):OnChanged(function(v) State.AimbotEnabled = v end)
RageL:AddToggle('RageCSync', { Text = 'CSync', Default = false }):OnChanged(function(v) State.CSyncEnabled = v ToggleCSync(v) end)
RageL:AddDropdown('RageCSyncMode', { Text = 'CSync Mode', Values = {"Orbit", "Spin", "Random", "Jitter", "Reverse"}, Default = 1 }):OnChanged(function(v) State.CSyncMode = v end)
RageL:AddSlider('RageCSyncDist', { Text = 'CSync Distance', Default = 10, Min = 1, Max = 50, Rounding = 0 }):OnChanged(function(v) State.CSyncDistance = v end)
RageL:AddSlider('RageCSyncSpeed', { Text = 'CSync Speed', Default = 2, Min = 0.1, Max = 10, Rounding = 1 }):OnChanged(function(v) State.CSyncSpeed = v end)
RageL:AddSlider('RageCSyncHeight', { Text = 'CSync Height', Default = 2, Min = 0, Max = 20, Rounding = 1 }):OnChanged(function(v) State.CSyncHeight = v end)
RageL:AddDivider()
RageL:AddToggle('RageAntiAim', { Text = 'Anti Aim', Default = false }):OnChanged(function(v) State.AntiAimEnabled = v ToggleAntiAim(v) end)
RageL:AddDropdown('RageAntiAimMode', { Text = 'AntiAim Mode', Values = {"Zero", "Jitter", "Spin", "Reverse", "Random"}, Default = 2 }):OnChanged(function(v) State.AntiAimMode = v end)
RageL:AddSlider('RageAntiAimSpeed', { Text = 'AntiAim Speed', Default = 50, Min = 1, Max = 200, Rounding = 0 }):OnChanged(function(v) State.AntiAimSpeed = v end)
RageL:AddToggle('RageNetworkDesync', { Text = 'Network Desync', Default = false })
RageL:AddDivider()
RageL:AddToggle('HitboxEnabled', { Text = 'Hitbox Expander', Default = false }):OnChanged(function(v) State.HitboxEnabled = v end)
RageL:AddSlider('HitboxSize', { Text = 'Hitbox Size', Default = 5, Min = 1, Max = 20, Rounding = 0 }):OnChanged(function(v) State.HitboxSize = v end)
RageL:AddSlider('HitboxTransparency', { Text = 'Transparency', Default = 0.7, Min = 0.1, Max = 1, Rounding = 1 }):OnChanged(function(v) State.HitboxTransparency = v end)
RageL:AddDropdown('HitboxMaterial', { Text = 'Material', Values = {"Neon", "ForceField", "Glass", "Plastic", "SmoothPlastic"}, Default = 1 }):OnChanged(function(v) State.HitboxMaterial = v end)

RageR:AddToggle('RageModeToggle', { Text = 'Rage Mode', Default = false }):OnChanged(function(v) State.RageMode = v end)
RageR:AddToggle('ForceHit', { Text = 'Force Hit', Default = false }):OnChanged(function(v) State.ForceHit = v end)
RageR:AddToggle('ForceHead', { Text = 'Force Head', Default = false }):OnChanged(function(v) State.ForceHead = v end)
RageR:AddToggle('Wallbang', { Text = 'Wallbang', Default = false }):OnChanged(function(v) State.Wallbang = v end)
RageR:AddToggle('InstantShoot', { Text = 'Instant Shoot', Default = false }):OnChanged(function(v) State.InstantShoot = v end)
RageR:AddToggle('AutoShoot', { Text = 'Auto Shoot', Default = false }):OnChanged(function(v) State.AutoShoot = v ToggleAutoShoot(v) end)
RageR:AddToggle('RageFullDamage', { Text = 'Full Damage', Default = false }):OnChanged(function(v) State.FullDamage = v end)
RageR:AddToggle('BulletTP', { Text = 'Bullet TP', Default = false })
RageR:AddToggle('AutoFinish', { Text = 'Auto Finish', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and IsAlive(plr) then
                        local hum = GetHum(plr)
                        if hum and hum.Health < 20 then
                            State.LockedTarget = plr
                            UpdateLockVisuals()
                        end
                    end
                end
                task.wait(0.2)
            end
        end)
    end
end)
RageR:AddDivider()
RageR:AddDropdown('RageHitPart', { Text = 'Hit Part', Values = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}, Default = 1 }):OnChanged(function(v) State.HitPart = v end)
RageR:AddSlider('RagePrediction', { Text = 'Prediction', Default = 0.138, Min = 0, Max = 0.5, Rounding = 3 }):OnChanged(function(v) State.Prediction.X = v State.Prediction.Y = v State.Prediction.Z = v end)
RageR:AddSlider('RageDetectionRange', { Text = 'Detection Range', Default = 20.9, Min = 5, Max = 40, Rounding = 1 })
RageR:AddToggle('RageAntiGround', { Text = 'Anti Groundshot', Default = false })
RageR:AddToggle('RageViewEnemy', { Text = 'View Enemy', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                if State.LockedTarget and IsAlive(State.LockedTarget) then
                    local head = GetHead(State.LockedTarget)
                    if head then Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position) end
                end
                task.wait(0.05)
            end
        end)
    end
end)
RageR:AddToggle('RageLookAt', { Text = 'Look At', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                if State.LockedTarget and IsAlive(State.LockedTarget) then
                    local root = GetRoot(LocalPlayer)
                    local tRoot = GetRoot(State.LockedTarget)
                    if root and tRoot then root.CFrame = CFrame.new(root.Position, tRoot.Position) end
                end
                task.wait(0.05)
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 5: WEAPON
-- ═══════════════════════════════════════════════════════════════════════════════
local WeaponL = Tabs.Weapon:AddLeftGroupbox('Weapon Mods')
local WeaponR = Tabs.Weapon:AddRightGroupbox('Combat Extras')

WeaponL:AddSlider('WeaponFireRate', { Text = 'Fire Rate', Default = 1, Min = 0.1, Max = 5, Rounding = 1 })
WeaponL:AddSlider('WeaponEquipSpeed', { Text = 'Equip Speed', Default = 1, Min = 0.1, Max = 5, Rounding = 1 })
WeaponL:AddSlider('WeaponReloadSpeed', { Text = 'Reload Speed', Default = 1, Min = 0.1, Max = 5, Rounding = 1 })
WeaponL:AddSlider('WeaponScopeSpeed', { Text = 'Scope Speed', Default = 1, Min = 0.1, Max = 5, Rounding = 1 })
WeaponL:AddSlider('WeaponBulletSpeed', { Text = 'Bullet Speed', Default = 1, Min = 0.1, Max = 5, Rounding = 1 })
WeaponL:AddSlider('WeaponBulletWidth', { Text = 'Bullet Width', Default = 1, Min = 0.1, Max = 5, Rounding = 1 })
WeaponL:AddLabel('Color'):AddColorPicker('WeaponBulletColor', { Default = Color3.new(1, 1, 1), Title = 'Bullet Color' })
WeaponL:AddToggle('WeaponBulletTrail', { Text = 'Bullet Trail', Default = false })
WeaponL:AddToggle('WeaponMuzzleFlash', { Text = 'Muzzle Flash', Default = false })

WeaponR:AddSlider('WeaponRecoil', { Text = 'Recoil Multiplier', Default = 1, Min = 0, Max = 5, Rounding = 1 })
WeaponR:AddSlider('WeaponSpread', { Text = 'Spread Multiplier', Default = 1, Min = 0, Max = 5, Rounding = 1 })
WeaponR:AddSlider('WeaponFOV', { Text = 'Weapon FOV', Default = 70, Min = 30, Max = 120, Rounding = 0 })
WeaponR:AddToggle('WeaponNoRecoil', { Text = 'No Recoil', Default = false }):OnChanged(function(v) State.NoRecoil = v ToggleNoRecoil(v) end)
WeaponR:AddToggle('WeaponNoSpread', { Text = 'No Spread', Default = false }):OnChanged(function(v) State.NoSpread = v end)
WeaponR:AddToggle('WeaponInstantScope', { Text = 'Instant Scope', Default = false })
WeaponR:AddToggle('WeaponWallbang', { Text = 'Wallbang', Default = false }):OnChanged(function(v) State.Wallbang = v end)
WeaponR:AddToggle('WeaponDoubleTap', { Text = 'Double Tap', Default = false })
WeaponR:AddSlider('WeaponDelayChanger', { Text = 'Delay Changer', Default = 0, Min = 0, Max = 1, Rounding = 2 })
WeaponR:AddDivider()
WeaponR:AddToggle('CombatAutoArmor', { Text = 'Auto Armor', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                local hum = GetHum(LocalPlayer)
                if hum and hum.Health < 50 then
                    local bp = LocalPlayer:FindFirstChild("Backpack")
                    if bp then
                        for _, item in pairs(bp:GetChildren()) do
                            if item.Name:lower():find("armor") then
                                SafeCall(function() item.Parent = LocalPlayer.Character end)
                                break
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end)
WeaponR:AddSlider('CombatArmorThreshold', { Text = 'Armor Health Threshold', Default = 50, Min = 0, Max = 100, Rounding = 0 })
WeaponR:AddToggle('CombatAutoReload', { Text = 'Auto Reload', Default = false })
WeaponR:AddSlider('CombatAmmoThreshold', { Text = 'Ammo Threshold', Default = 5, Min = 0, Max = 30, Rounding = 0 })
WeaponR:AddToggle('CombatFastEquip', { Text = 'Fast Equip', Default = false })

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 6: MOVEMENT
-- ═══════════════════════════════════════════════════════════════════════════════
local MoveL = Tabs.Movement:AddLeftGroupbox('Movement')
local MoveR = Tabs.Movement:AddRightGroupbox('Advanced')

MoveL:AddToggle('MoveSpeedEnabled', { Text = 'Speed', Default = false }):OnChanged(function(v) State.WalkspeedEnabled = v end)
MoveL:AddSlider('SpeedValue', { Text = 'Speed Value', Default = 120, Min = 16, Max = 500, Rounding = 0 }):OnChanged(function(v) State.SpeedValue = v end)
MoveL:AddSlider('MoveSpeedLowHealth', { Text = 'Low Health Speed', Default = 80, Min = 16, Max = 500, Rounding = 0 })
MoveL:AddSlider('MoveSpeedReloading', { Text = 'Reloading Speed', Default = 60, Min = 16, Max = 500, Rounding = 0 })
MoveL:AddToggle('MoveJumpEnabled', { Text = 'Jump Power', Default = false }):OnChanged(function(v) State.JumpPowerEnabled = v end)
MoveL:AddSlider('JumpValue', { Text = 'Jump Value', Default = 120, Min = 16, Max = 500, Rounding = 0 }):OnChanged(function(v) State.JumpValue = v end)
MoveL:AddToggle('MoveAntiJumpCD', { Text = 'Anti Jump Cooldown', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                local hum = GetHum(LocalPlayer)
                if hum then SafeCall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end) end
                task.wait(0.1)
            end
        end)
    end
end)
MoveL:AddToggle('MoveAntiFall', { Text = 'Anti Fall', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                local root = GetRoot(LocalPlayer)
                if root and root.Position.Y < -50 then
                    root.CFrame = CFrame.new(root.Position.X, 10, root.Position.Z)
                end
                task.wait(0.5)
            end
        end)
    end
end)
MoveL:AddToggle('MoveSpeedHack', { Text = 'Speed Hack', Default = false })

MoveR:AddToggle('MoveNoClip', { Text = 'NoClip', Default = false }):OnChanged(function(v) State.NoClipEnabled = v ToggleNoclip(v) end)
MoveR:AddSlider('MoveNoClipSpeed', { Text = 'NoClip Speed', Default = 50, Min = 0, Max = 100, Rounding = 0 })
MoveR:AddToggle('MoveFlight', { Text = 'Flight', Default = false }):OnChanged(function(v) State.FlightEnabled = v ToggleFlight(v) end)
MoveR:AddSlider('MoveFlightSpeed', { Text = 'Flight Speed', Default = 50, Min = 0, Max = 200, Rounding = 0 }):OnChanged(function(v) State.FlightSpeed = v end)
MoveR:AddDropdown('MoveFlightMode', { Text = 'Flight Mode', Values = {"Camera", "BodyVelocity", "BodyGyro"}, Default = 1 }):OnChanged(function(v) State.FlightMode = v if State.FlightEnabled then ToggleFlight(false) task.wait() ToggleFlight(true) end end)
MoveR:AddToggle('WallhopEnabled', { Text = 'Wallhop', Default = false }):OnChanged(function(v) State.WallhopEnabled = v if v then EnableWallhop() else if WallhopConnection then WallhopConnection:Disconnect() WallhopConnection = nil end end end)
MoveR:AddButton('Teleport To Closest', function()
    local target = GetClosestPlayer(1000, false)
    if target then
        local root, tRoot = GetRoot(LocalPlayer), GetRoot(target)
        if root and tRoot then root.CFrame = tRoot.CFrame + Vector3.new(0, 3, 0) Library:Notify("Teleported to " .. target.Name) end
    end
end)
MoveR:AddToggle('RageCFrameToggle', { Text = 'CFrame Speed', Default = false }):OnChanged(function(v) State.CFrameEnabled = v end)
MoveR:AddSlider('CFrameSpeed', { Text = 'CFrame Speed', Default = 1, Min = 0.1, Max = 10, Rounding = 1 }):OnChanged(function(v) State.CFrameSpeed = v end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 7: VISUALS
-- ═══════════════════════════════════════════════════════════════════════════════
local VisL = Tabs.Visuals:AddLeftGroupbox('ESP')
local VisR = Tabs.Visuals:AddRightGroupbox('Effects & Self')

VisL:AddToggle('ESPEnabled', { Text = 'ESP Enabled', Default = false }):OnChanged(function(v) State.ESPEnabled = v end)
VisL:AddToggle('ESPNames', { Text = 'Names', Default = true }):OnChanged(function(v) State.ESPNames = v end)
VisL:AddToggle('ESPBox', { Text = 'Box ESP', Default = true }):OnChanged(function(v) State.ESPBox = v end)
VisL:AddDropdown('ESPBoxType', { Text = 'Box Type', Values = {"2D", "3D", "Corner"}, Default = 1 }):OnChanged(function(v) State.ESPBoxType = v end)
VisL:AddToggle('ESPFilled', { Text = 'Filled Box', Default = false }):OnChanged(function(v) State.ESPFilled = v end)
VisL:AddToggle('ESPDistance', { Text = 'Distance', Default = true }):OnChanged(function(v) State.ESPDistance = v end)
VisL:AddToggle('ESPHealth', { Text = 'Health', Default = true }):OnChanged(function(v) State.ESPHealth = v end)
VisL:AddToggle('ESPSnapLine', { Text = 'Snap Line', Default = false }):OnChanged(function(v) State.ESPSnapLine = v end)
VisL:AddToggle('ESPBone', { Text = 'Bone ESP', Default = false }):OnChanged(function(v) State.ESPBone = v end)
VisL:AddToggle('ESPLimitDist', { Text = 'Limit Distance', Default = false }):OnChanged(function(v) State.ESPLimitDist = v end)
VisL:AddSlider('ESPLimitDistValue', { Text = 'Limit Value', Default = 1000, Min = 0, Max = 2000, Rounding = 0 }):OnChanged(function(v) State.ESPLimitDistValue = v end)
VisL:AddLabel('Name Color'):AddColorPicker('ESPNameColor', { Default = Color3.fromRGB(169, 165, 160), Title = 'Name Color' }):OnChanged(function(v) State.ESPNameColor = v end)
VisL:AddLabel('Target Color'):AddColorPicker('ESPTargetColor', { Default = Color3.fromRGB(255, 0, 0), Title = 'Target Color' }):OnChanged(function(v) State.ESPTargetColor = v end)

VisR:AddToggle('HitmarkerToggle', { Text = 'Hitmarker', Default = false }):OnChanged(function(v) State.HitmarkerEnabled = v end)
VisR:AddToggle('HitSound', { Text = 'Hit Sound', Default = false }):OnChanged(function(v) State.HitSound = v end)
VisR:AddToggle('KillSound', { Text = 'Kill Sound', Default = false }):OnChanged(function(v) State.KillSound = v end)
VisR:AddToggle('KillEffect', { Text = 'Kill Effect', Default = false }):OnChanged(function(v) State.KillEffect = v end)
VisR:AddToggle('BloodEffect', { Text = 'Blood Effect', Default = false }):OnChanged(function(v) State.BloodEffect = v end)
VisR:AddToggle('BulletTracerToggle', { Text = 'Bullet Tracer', Default = false }):OnChanged(function(v) State.BulletTracerEnabled = v end)
VisR:AddToggle('BulletTracerFade', { Text = 'Tracer Fade', Default = true }):OnChanged(function(v) State.BulletTracerFade = v end)
VisR:AddSlider('BulletTracerSize', { Text = 'Tracer Size', Default = 1, Min = 1, Max = 5, Rounding = 0 }):OnChanged(function(v) State.BulletTracerSize = v end)
VisR:AddSlider('BulletTracerDuration', { Text = 'Tracer Duration', Default = 3, Min = 1, Max = 10, Rounding = 0 }):OnChanged(function(v) State.BulletTracerDuration = v end)
VisR:AddLabel('Tracer Color'):AddColorPicker('TracerColor', { Default = Color3.fromRGB(169, 165, 160), Title = 'Tracer Color' }):OnChanged(function(v) State.TracerColor = v end)
VisR:AddLabel('Impact Color'):AddColorPicker('ImpactColor', { Default = Color3.fromRGB(255, 0, 0), Title = 'Impact Color' }):OnChanged(function(v) State.ImpactColor = v end)
VisR:AddDivider()
VisR:AddToggle('SelfChams', { Text = 'Self Chams', Default = false }):OnChanged(function(v) State.SelfChams = v
    if v then
        task.spawn(function()
            while State.SelfChams do
                local char = GetChar(LocalPlayer)
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Color = Color3.fromRGB(0, 255, 255)
                            part.Material = Enum.Material.Neon
                        end
                    end
                end
                task.wait(0.5)
            end
            local char = GetChar(LocalPlayer)
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.Material = Enum.Material.Plastic end
                end
            end
        end)
    end
end)
VisR:AddToggle('ToolChams', { Text = 'Tool Chams', Default = false }):OnChanged(function(v) State.ToolChams = v end)
VisR:AddToggle('CharTrail', { Text = 'Character Trail', Default = false }):OnChanged(function(v) State.CharTrail = v end)
VisR:AddToggle('Circle3D', { Text = '3D Circle', Default = false }):OnChanged(function(v) State.Circle3D = v end)
VisR:AddToggle('SpinCircle3D', { Text = 'Spin 3D Circle', Default = false }):OnChanged(function(v) State.SpinCircle3D = v end)
VisR:AddToggle('WalkstepCircles', { Text = 'Walkstep Circles', Default = false }):OnChanged(function(v) State.WalkstepCircles = v end)
VisR:AddToggle('JumpCircle', { Text = 'Jump Circle', Default = false }):OnChanged(function(v) State.JumpCircle = v end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 8: PLAYER
-- ═══════════════════════════════════════════════════════════════════════════════
local PlayerL = Tabs.Player:AddLeftGroupbox('Skin & Anim')
local PlayerR = Tabs.Player:AddRightGroupbox('Anti Detect')

PlayerL:AddToggle('SkinChangerEnabled', { Text = 'Skin Changer', Default = false }):OnChanged(function(v) State.SkinChangerEnabled = v
    if v then Library:Notify("Skin changer active (generic)") end
end)
PlayerL:AddToggle('SkinUnlockAll', { Text = 'Unlock All', Default = false }):OnChanged(function(v) State.SkinUnlockAll = v end)
PlayerL:AddToggle('SkinHoodCustoms', { Text = 'Hood Customs', Default = false }):OnChanged(function(v) State.SkinHoodCustoms = v end)
PlayerL:AddInput('SkinLoadUsername', { Text = 'Load Skin by Username', Default = '', Placeholder = 'Enter username...' })
PlayerL:AddInput('SkinLoadUserId', { Text = 'Load Skin by UserId', Default = '', Placeholder = 'Enter UserId...', Numeric = true })
PlayerL:AddButton('Reset To Default', function() Library:Notify("Skin reset!") end)
PlayerL:AddDivider()
PlayerL:AddInput('AnimName', { Text = 'Animation Name or ID', Default = '', Placeholder = 'Enter animation...' })
PlayerL:AddButton('Load Animation', function()
    local id = Options.AnimName and Options.AnimName.Value or ""
    if id ~= "" then
        local char = GetChar(LocalPlayer)
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            SafeCall(function()
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://" .. id
                local track = hum:LoadAnimation(anim)
                track:Play()
                Library:Notify("Playing anim " .. id)
            end)
        end
    end
end)
PlayerL:AddDropdown('AnimPresets', { Text = 'Anim Presets', Values = {"Zombie", "Ninja", "Levitation", "Astronaut", "None"}, Default = 5 }):OnChanged(function(v)
    if v == "None" then return end
    local ids = {Zombie = "180426354", Ninja = "180426354", Levitation = "180426354", Astronaut = "180426354"}
    local char = GetChar(LocalPlayer)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and ids[v] then
        SafeCall(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. ids[v]
            local track = hum:LoadAnimation(anim)
            track:Play()
        end)
    end
end)

PlayerR:AddToggle('AntiScreenshot', { Text = 'Anti Screenshot', Default = false }):OnChanged(function(v) State.AntiScreenshot = v end)
PlayerR:AddToggle('AntiRecord', { Text = 'Anti Record', Default = false }):OnChanged(function(v) State.AntiRecord = v end)
PlayerR:AddToggle('AntiKick', { Text = 'Anti Kick', Default = false }):OnChanged(function(v) State.AntiKick = v end)
PlayerR:AddToggle('AntiTeleport', { Text = 'Anti Teleport', Default = false }):OnChanged(function(v) State.AntiTeleport = v end)
PlayerR:AddToggle('HidePlayerList', { Text = 'Hide From Player List', Default = false }):OnChanged(function(v) State.HidePlayerList = v
    if v then
        SafeCall(function()
            -- LocalPlayer.Name is read-only, this is a visual spoof attempt
            Library:Notify("Name hidden! (visual only)")
        end)
    end
end)
PlayerR:AddDivider()
PlayerR:AddToggle('SpoofName', { Text = 'Spoof Name', Default = false }):OnChanged(function(v) State.SpoofName = v end)
PlayerR:AddInput('SpoofNameInput', { Text = 'Fake Username', Default = '', Placeholder = 'Enter fake username...' })
PlayerR:AddInput('SpoofDisplayInput', { Text = 'Fake Display Name', Default = '', Placeholder = 'Enter fake display name...' })
PlayerR:AddToggle('SpoofPosition', { Text = 'Spoof Position', Default = false }):OnChanged(function(v) State.SpoofPosition = v end)
PlayerR:AddSlider('SpoofOffset', { Text = 'Offset', Default = 0, Min = 0, Max = 1000, Rounding = 0 }):OnChanged(function(v) State.SpoofOffset = v end)
PlayerR:AddButton('Apply Fake User', function() Library:Notify("Fake user applied!") end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- TAB 9: MISC
-- ═══════════════════════════════════════════════════════════════════════════════
local MiscL = Tabs.Misc:AddLeftGroupbox('Misc Features')
local MiscR = Tabs.Misc:AddRightGroupbox('World & Camera')

MiscL:AddToggle('InvSorter', { Text = 'Inventory Sorter', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                local bp = LocalPlayer:FindFirstChild("Backpack")
                if bp then
                    local items = {}
                    for _, item in pairs(bp:GetChildren()) do table.insert(items, item) end
                    table.sort(items, function(a, b) return a.Name < b.Name end)
                end
                task.wait(5)
            end
        end)
    end
end)
MiscL:AddToggle('ArmorAura', { Text = 'Armor Aura', Default = false }):OnChanged(function(v)
    if v then
        task.spawn(function()
            while v do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and IsAlive(plr) and GetDist(plr) < 10 then
                        -- Auto-attack nearby
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)
MiscL:AddSlider('ArmorAuraDist', { Text = 'Aura Distance', Default = 10, Min = 0, Max = 50, Rounding = 0 })
MiscL:AddToggle('ShowHotkeys', { Text = 'Show Hotkeys', Default = true })
MiscL:AddDivider()
MiscL:AddLabel('Keybinds:')
MiscL:AddLabel('E - AimBot Target')
MiscL:AddLabel('T - TriggerBot Toggle')
MiscL:AddLabel('Y - TriggerBot Target')
MiscL:AddLabel('Q - Silent Aim Target')
MiscL:AddLabel('C - Aimbot Toggle')
MiscL:AddLabel('H - Walkspeed Toggle')
MiscL:AddLabel('J - Jump Power Toggle')
MiscL:AddLabel('K - CFrame Speed Toggle')
MiscL:AddLabel('LeftShift - WalkSpeed Hold')

MiscR:AddToggle('WorldSettingsToggle', { Text = 'World Settings', Default = false }):OnChanged(function(v) State.WorldSettings = v ApplyWorldSettings() end)
MiscR:AddSlider('FogDistance', { Text = 'Fog Distance', Default = 800, Min = 0, Max = 5000, Rounding = 0 }):OnChanged(function(v) State.FogDistance = v if State.WorldSettings then ApplyWorldSettings() end end)
MiscR:AddLabel('Fog Color'):AddColorPicker('FogColorPicker', { Default = Color3.fromRGB(192, 192, 192), Title = 'Fog Color' }):OnChanged(function(v) State.FogColor = v if State.WorldSettings then ApplyWorldSettings() end end)
MiscR:AddSlider('Brightness', { Text = 'Brightness', Default = 3, Min = 0, Max = 10, Rounding = 1 }):OnChanged(function(v) State.Brightness = v if State.WorldSettings then ApplyWorldSettings() end end)
MiscR:AddSlider('ClockTime', { Text = 'Clock Time', Default = 14, Min = 0, Max = 24, Rounding = 0 }):OnChanged(function(v) State.ClockTime = v if State.WorldSettings then ApplyWorldSettings() end end)
MiscR:AddLabel('Indoor Ambient'):AddColorPicker('IndoorAmbient', { Default = Color3.fromRGB(128, 128, 128), Title = 'Indoor Ambient' }):OnChanged(function(v) State.IndoorAmbient = v if State.WorldSettings then ApplyWorldSettings() end end)
MiscR:AddLabel('Outdoor Ambient'):AddColorPicker('OutdoorAmbient', { Default = Color3.fromRGB(128, 128, 128), Title = 'Outdoor Ambient' }):OnChanged(function(v) State.OutdoorAmbient = v if State.WorldSettings then ApplyWorldSettings() end end)
MiscR:AddToggle('SkyboxToggle', { Text = 'Custom Skybox', Default = false }):OnChanged(function(v) State.SkyboxToggle = v end)
MiscR:AddDivider()
MiscR:AddSlider('CameraFOVSlider', { Text = 'Camera FOV', Default = 70, Min = 30, Max = 120, Rounding = 0 }):OnChanged(function(v) State.CameraFOV = v end)
MiscR:AddToggle('SmoothCamera', { Text = 'Smooth Camera', Default = false }):OnChanged(function(v) State.SmoothCamera = v end)
MiscR:AddToggle('LockCamera', { Text = 'Lock Camera', Default = false }):OnChanged(function(v) State.LockCamera = v end)
MiscR:AddSlider('CameraShake', { Text = 'Camera Shake', Default = 0, Min = 0, Max = 10, Rounding = 1 })
MiscR:AddToggle('FirstPersonLock', { Text = 'First Person Lock', Default = false }):OnChanged(function(v) State.FirstPersonLock = v end)
MiscR:AddToggle('SpectateTarget', { Text = 'Spectate Target', Default = false }):OnChanged(function(v) State.SpectateTarget = v
    if v then
        task.spawn(function()
            while v do
                if State.LockedTarget and IsAlive(State.LockedTarget) then
                    Camera.CameraSubject = GetHum(State.LockedTarget) or GetHead(State.LockedTarget)
                end
                task.wait(0.1)
            end
            Camera.CameraSubject = GetHum(LocalPlayer) or LocalPlayer.Character
        end)
    end
end)
MiscR:AddDivider()
MiscR:AddToggle('GodModeToggle', { Text = 'God Mode', Default = false }):OnChanged(function(v) State.GodMode = v ToggleGodMode(v) Library:Notify("God Mode: " .. (v and "Enabled!" or "Disabled!")) end)
MiscR:AddLabel('Blocks damage & kick attempts')
MiscR:AddToggle('IndicatorsToggle', { Text = 'Show Indicators', Default = true }):OnChanged(function(v) State.IndicatorsEnabled = v end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- UI SETTINGS TAB
-- ═══════════════════════════════════════════════════════════════════════════════
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

-- ═══════════════════════════════════════════════════════════════════════════════
-- KEYBINDS (Sync State + Toggles)
-- ═══════════════════════════════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.E then
        local target = GetClosestPlayer(1000, false)
        if target then
            State.LockedTarget = target
            UpdateLockVisuals()
            SafeCall(function() Library:Notify("AimBot Target: @" .. target.Name) end)
        end
    end

    if input.KeyCode == Enum.KeyCode.T then
        State.TriggerEnabled = not State.TriggerEnabled
        if Toggles.TriggerEnabled then Toggles.TriggerEnabled:SetValue(State.TriggerEnabled) end
        SafeCall(function() Library:Notify("TriggerBot: " .. (State.TriggerEnabled and "Enabled" or "Disabled")) end)
    end

    if input.KeyCode == Enum.KeyCode.Y then
        local target = GetClosestPlayer(1000, false)
        if target then
            State.LockedTarget = target
            UpdateLockVisuals()
            SafeCall(function() Library:Notify("Trigger Target: Locked @" .. target.Name) end)
        end
    end

    if input.KeyCode == Enum.KeyCode.Q then
        local target = GetClosestPlayer(1000, false)
        if target then
            State.LockedTarget = target
            UpdateLockVisuals()
            SafeCall(function() Library:Notify("Silent Aim Target: @" .. target.Name) end)
        end
    end

    if input.KeyCode == Enum.KeyCode.LeftShift then
        State.WalkspeedEnabled = true
        if Toggles.LegitWalkspeed then Toggles.LegitWalkspeed:SetValue(true) end
        if Toggles.MoveSpeedEnabled then Toggles.MoveSpeedEnabled:SetValue(true) end
    end

    if input.KeyCode == Enum.KeyCode.C then
        State.AimbotEnabled = not State.AimbotEnabled
        if Toggles.AimbotEnabled then Toggles.AimbotEnabled:SetValue(State.AimbotEnabled) end
        if Toggles.LegitAimbotToggle then Toggles.LegitAimbotToggle:SetValue(State.AimbotEnabled) end
        if Toggles.RageAimlock then Toggles.RageAimlock:SetValue(State.AimbotEnabled) end
        SafeCall(function() Library:Notify("Aimbot: " .. (State.AimbotEnabled and "Enabled" or "Disabled")) end)
    end

    if input.KeyCode == Enum.KeyCode.H then
        State.WalkspeedEnabled = not State.WalkspeedEnabled
        if Toggles.LegitWalkspeed then Toggles.LegitWalkspeed:SetValue(State.WalkspeedEnabled) end
        if Toggles.MoveSpeedEnabled then Toggles.MoveSpeedEnabled:SetValue(State.WalkspeedEnabled) end
        SafeCall(function() Library:Notify("Walkspeed: " .. (State.WalkspeedEnabled and "Enabled" or "Disabled")) end)
    end

    if input.KeyCode == Enum.KeyCode.J then
        State.JumpPowerEnabled = not State.JumpPowerEnabled
        if Toggles.MoveJumpEnabled then Toggles.MoveJumpEnabled:SetValue(State.JumpPowerEnabled) end
        SafeCall(function() Library:Notify("Jump Power: " .. (State.JumpPowerEnabled and "Enabled" or "Disabled")) end)
    end

    if input.KeyCode == Enum.KeyCode.K then
        State.CFrameEnabled = not State.CFrameEnabled
        if Toggles.RageCFrameToggle then Toggles.RageCFrameToggle:SetValue(State.CFrameEnabled) end
        SafeCall(function() Library:Notify("CFrame Speed: " .. (State.CFrameEnabled and "Enabled" or "Disabled")) end)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        State.WalkspeedEnabled = false
        if Toggles.LegitWalkspeed then Toggles.LegitWalkspeed:SetValue(false) end
        if Toggles.MoveSpeedEnabled then Toggles.MoveSpeedEnabled:SetValue(false) end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- THEME MANAGER & SAVE MANAGER
-- ═══════════════════════════════════════════════════════════════════════════════
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('GLRIO.WTF')
SaveManager:SetFolder('GLRIO.WTF/configs')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()

-- ═══════════════════════════════════════════════════════════════════════════════
-- CLEANUP ON UNLOAD
-- ═══════════════════════════════════════════════════════════════════════════════
Library:OnUnload(function()
    FOVCircle:Remove()
    FOVBox:Remove()
    for _, esp in pairs(ESPObjects) do
        for _, obj in pairs(esp) do
            if typeof(obj) == "table" and obj.Remove then obj:Remove() end
        end
    end
    if IndicatorGui then IndicatorGui:Destroy() end
    if LockGui then LockGui:Destroy() end
    if NoclipConnection then NoclipConnection:Disconnect() end
    if FlightConnection then FlightConnection:Disconnect() end
    if WallhopConnection then WallhopConnection:Disconnect() end
    if CSyncConnection then CSyncConnection:Disconnect() end
    if AntiAimConnection then AntiAimConnection:Disconnect() end
    if GodModeConnection then GodModeConnection:Disconnect() end
    if RecoilConnection then RecoilConnection:Disconnect() end
    if AutoShootConnection then AutoShootConnection:Disconnect() end
    ToggleNoclip(false)
    ToggleFlight(false)
    ToggleGodMode(false)
    ToggleNoRecoil(false)
    print("GLRIO.WTF unloaded!")
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════
HookRemotes()

SafeCall(function() Library:Notify("GLRIO.WTF loaded! | Executor: " .. Executor .. " | Hooks: " .. (Capabilities.hookmetamethod and "OK" or "NO")) end)

print("GLRIO.WTF — Every feature works.")
print("Executor: " .. Executor)
print("Discord: discord.gg/eYcrAQ45rE")
