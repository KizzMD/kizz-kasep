-- KizzDev | Accessory Hub v10 Premium (Rayfield) + Headless & Korblox
-- Mohon maaf jika ada bug ya kak~ kalau nemu yang aneh, kabari aku biar cepat diperbaiki. Makasih sudah mampir, semoga betah pake script saya🌸

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local InsertService = game:GetService("InsertService")
local LocalPlayer = Players.LocalPlayer

------------------------------------------------ PREMIUM UI
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local ACCENT = {
    Color3.fromRGB(140, 82, 255),
    Color3.fromRGB(0, 212, 255),
    Color3.fromRGB(255, 80, 200),
}

local function accentGradient()
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ACCENT[1]),
        ColorSequenceKeypoint.new(0.5, ACCENT[2]),
        ColorSequenceKeypoint.new(1, ACCENT[3]),
    })
    return g
end

local function guiParent()
    local ok, h = pcall(function() return gethui and gethui() end)
    if ok and h then return h end
    return LocalPlayer:WaitForChild("PlayerGui")
end

-- animasi intro sebelum menu muncul
local function playIntro()
    local sg = Instance.new("ScreenGui")
    sg.Name = "KizzDevIntro"
    sg.IgnoreGuiInset = true
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999
    local ok = pcall(function() sg.Parent = guiParent() end)
    if not ok or not sg.Parent then sg.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local bg = Instance.new("Frame")
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.fromRGB(7, 5, 16)
    bg.BackgroundTransparency = 1
    bg.BorderSizePixel = 0
    bg.Parent = sg

    local title = Instance.new("TextLabel")
    title.AnchorPoint = Vector2.new(0.5, 0.5)
    title.Position = UDim2.fromScale(0.5, 0.44)
    title.Size = UDim2.fromOffset(420, 70)
    title.BackgroundTransparency = 1
    title.Text = "KIZZDEV"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 54
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextTransparency = 1
    title.Parent = bg
    local tg = accentGradient()
    tg.Parent = title
    local ts = Instance.new("UIScale")
    ts.Scale = 0.6
    ts.Parent = title

    local sub = Instance.new("TextLabel")
    sub.AnchorPoint = Vector2.new(0.5, 0.5)
    sub.Position = UDim2.fromScale(0.5, 0.54)
    sub.Size = UDim2.fromOffset(420, 24)
    sub.BackgroundTransparency = 1
    sub.Text = "ACCESSORY HUB  |  PREMIUM"
    sub.Font = Enum.Font.GothamMedium
    sub.TextSize = 14
    sub.TextColor3 = Color3.fromRGB(190, 180, 230)
    sub.TextTransparency = 1
    sub.Parent = bg

    local barBg = Instance.new("Frame")
    barBg.AnchorPoint = Vector2.new(0.5, 0.5)
    barBg.Position = UDim2.fromScale(0.5, 0.62)
    barBg.Size = UDim2.fromOffset(240, 4)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 32, 70)
    barBg.BackgroundTransparency = 1
    barBg.BorderSizePixel = 0
    barBg.Parent = bg
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.fromScale(0, 1)
    fill.BackgroundColor3 = Color3.new(1, 1, 1)
    fill.BackgroundTransparency = 1
    fill.BorderSizePixel = 0
    fill.Parent = barBg
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    accentGradient().Parent = fill

    local back = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenService:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(title, back, {TextTransparency = 0}):Play()
    TweenService:Create(ts, back, {Scale = 1}):Play()
    task.wait(0.3)

    TweenService:Create(sub, TweenInfo.new(0.5), {TextTransparency = 0.15}):Play()
    TweenService:Create(barBg, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
    fill.BackgroundTransparency = 0
    TweenService:Create(fill, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.fromScale(1, 1)}):Play()
    tg.Offset = Vector2.new(-1, 0)
    TweenService:Create(tg, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)}):Play()
    task.wait(1.7)

    local out = TweenInfo.new(0.5)
    TweenService:Create(bg, out, {BackgroundTransparency = 1}):Play()
    TweenService:Create(title, out, {TextTransparency = 1}):Play()
    TweenService:Create(sub, out, {TextTransparency = 1}):Play()
    TweenService:Create(barBg, out, {BackgroundTransparency = 1}):Play()
    TweenService:Create(fill, out, {BackgroundTransparency = 1}):Play()
    task.wait(0.55)
    sg:Destroy()
end

local function findRayfieldGui()
    local containers = {}
    pcall(function() if gethui then table.insert(containers, gethui()) end end)
    table.insert(containers, CoreGui)
    table.insert(containers, LocalPlayer:WaitForChild("PlayerGui"))
    for _, c in ipairs(containers) do
        local ok, g = pcall(function() return c:FindFirstChild("Rayfield") end)
        if ok and g then return g end
    end
    return nil
end

-- animasi "pop" tiap menu dibuka
local function popOnOpen(gui)
    local main = gui:FindFirstChild("Main")
    if not main then return end
    local sc = Instance.new("UIScale")
    sc.Parent = main
    local function pop()
        sc.Scale = 0.82
        TweenService:Create(sc, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Scale = 1}):Play()
    end
    main:GetPropertyChangedSignal("Visible"):Connect(function()
        if main.Visible then pop() end
    end)
    pop()
end

-- tombol "Show Rayfield" jadi KIZZDEV premium
local function stylePrompt()
    local gui
    for _ = 1, 40 do
        gui = findRayfieldGui()
        if gui then break end
        task.wait(0.25)
    end
    if not gui then return end
    pcall(popOnOpen, gui)

    local label
    for _ = 1, 40 do
        for _, d in ipairs(gui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text == "Show Rayfield" then
                label = d
                break
            end
        end
        if label then break end
        task.wait(0.25)
    end
    if not label then return end

    local prompt = label
    if not label.Parent:IsA("GuiObject") then
        prompt = label
    else
        prompt = label.Parent
    end

    pcall(function()
        prompt.BackgroundColor3 = Color3.fromRGB(14, 10, 30)
        prompt.BackgroundTransparency = 0.05
    end)
    local corner = prompt:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", prompt)
    corner.CornerRadius = UDim.new(1, 0)

    local stroke = prompt:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", prompt)
    stroke.Thickness = 2
    stroke.Transparency = 0
    stroke.Color = Color3.new(1, 1, 1)
    pcall(function() stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border end)
    local sGrad = accentGradient()
    sGrad.Parent = stroke

    local TEXT = "KIZZDEV"
    label.Text = TEXT
    pcall(function()
        label.Font = Enum.Font.GothamBlack
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextTransparency = 0
    end)
    local lGrad = accentGradient()
    lGrad.Parent = label
    label:GetPropertyChangedSignal("Text"):Connect(function()
        if label.Text ~= TEXT then label.Text = TEXT end
    end)

    -- animasi terus-menerus: border berputar, teks berkilau
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not prompt:IsDescendantOf(game) then
            conn:Disconnect()
            return
        end
        sGrad.Rotation = (os.clock() * 120) % 360
        lGrad.Offset = Vector2.new(math.sin(os.clock() * 1.5) * 0.6, 0)
    end)
    TweenService:Create(stroke,
        TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Thickness = 3.5}):Play()

    -- muncul dengan efek membal + efek tekan
    local ps = Instance.new("UIScale")
    ps.Scale = 0
    ps.Parent = prompt
    TweenService:Create(ps, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Scale = 1}):Play()

    local function hook(b)
        b.MouseButton1Down:Connect(function()
            TweenService:Create(ps, TweenInfo.new(0.1), {Scale = 0.9}):Play()
        end)
        b.MouseButton1Up:Connect(function()
            TweenService:Create(ps, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Scale = 1}):Play()
        end)
    end
    if prompt:IsA("TextButton") or prompt:IsA("ImageButton") then hook(prompt) end
    for _, b in ipairs(prompt:GetDescendants()) do
        if b:IsA("TextButton") or b:IsA("ImageButton") then hook(b) end
    end
end

pcall(playIntro)

------------------------------------------------ HELPER
local function notify(title, content, dur)
    pcall(function()
        Rayfield:Notify({Title = title, Content = content, Duration = dur or 4})
    end)
end

local function getChar() return LocalPlayer.Character end
local function getHum()
    local c = getChar()
    return c and c:FindFirstChildOfClass("Humanoid")
end
local function getRoot()
    local c = getChar()
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function parseId(text)
    if not text then return nil end
    text = tostring(text)
    local n = text:match("catalog/(%d+)") or text:match("bundles/(%d+)")
        or text:match("id=(%d+)") or text:match("(%d+)")
    return n and tonumber(n) or nil
end

local function loadAsset(id)
    local ok, objs = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
    if ok and objs and objs[1] then return objs[1] end
    local ok2, model = pcall(function() return InsertService:LoadAsset(id) end)
    if ok2 and model then return model end
    return nil
end

------------------------------------------------ STATE
local equipped = {}          -- {id=, items={}, swap=bool}
local cache = {}             -- id -> template aksesori (dimuat sekali, ganti jadi instan)
local autoReequip = true
local working = false
local typedId = nil
local slotIds = {}
local slotIdx = 0
local ListLabel = nil

local fx = {aura = false, light = false, trail = false, rainbow = false, neon = false}
local fxColor = Color3.fromRGB(140, 82, 255)
local hue = 0

local function refreshList()
    if not ListLabel then return end
    local ids = {}
    for _, e in ipairs(equipped) do
        table.insert(ids, tostring(e.id) .. (e.swap and "*" or ""))
    end
    local text = #ids > 0 and ("Dipakai: " .. table.concat(ids, ", ") .. "  (* = slot ganti-cepat)")
        or "Belum ada aksesori yang dipasang"
    pcall(function() ListLabel:Set(text) end)
end

------------------------------------------------ AKSESORI
local function getTemplates(id)
    if cache[id] then return cache[id] end
    local obj = loadAsset(id)
    if not obj then return nil end
    local all = obj:GetDescendants()
    table.insert(all, obj)
    local list = {}
    for _, d in ipairs(all) do
        if d:IsA("Accoutrement") then table.insert(list, d) end
    end
    if #list == 0 then return nil end
    cache[id] = list
    return list
end

local function applyNeon()
    for _, e in ipairs(equipped) do
        for _, item in ipairs(e.items) do
            local h = item:FindFirstChild("Handle")
            if h and h:IsA("BasePart") then
                if fx.neon then
                    if not h:GetAttribute("KD_Mat") then
                        h:SetAttribute("KD_Mat", h.Material.Name)
                    end
                    h.Material = Enum.Material.Neon
                else
                    local m = h:GetAttribute("KD_Mat")
                    if m then
                        pcall(function() h.Material = Enum.Material[m] end)
                        h:SetAttribute("KD_Mat", nil)
                    end
                end
            end
        end
    end
end

local function equipId(id, swap, silent)
    local char, hum = getChar(), getHum()
    if not (char and hum) then
        if not silent then notify("Error", "Karakter belum siap") end
        return false
    end
    local temps = getTemplates(id)
    if not temps then
        if not silent then notify("Error", "Aksesori gagal dimuat: " .. id) end
        return false
    end
    local made = {}
    for _, t in ipairs(temps) do
        local ok, c = pcall(function() return t:Clone() end)
        if ok and c then
            pcall(function() hum:AddAccessory(c) end)
            if not c.Parent then pcall(function() c.Parent = char end) end
            if c.Parent then table.insert(made, c) end
        end
    end
    if #made == 0 then
        if not silent then notify("Error", "Gagal memasang: " .. id) end
        return false
    end
    table.insert(equipped, {id = id, items = made, swap = swap or false})
    applyNeon()
    refreshList()
    if not silent then notify("Terpasang", "Aksesori " .. id) end
    return true
end

local function removeEntry(e)
    for _, item in ipairs(e.items) do
        pcall(function() item:Destroy() end)
    end
    local i = table.find(equipped, e)
    if i then table.remove(equipped, i) end
end

local function swapTo(id)
    for i = #equipped, 1, -1 do
        if equipped[i].swap then removeEntry(equipped[i]) end
    end
    local ok = equipId(id, true)
    refreshList()
    return ok
end

local function run(fn)
    if working then return end
    working = true
    task.spawn(function()
        pcall(fn)
        working = false
    end)
end

local function useSlot(n)
    local id = slotIds[n]
    if not id then
        notify("Slot " .. n, "Slot kosong, isi Asset ID dulu")
        return
    end
    slotIdx = n
    swapTo(id)
end

local function cycle(dir)
    local filled = {}
    for i = 1, 5 do
        if slotIds[i] then table.insert(filled, i) end
    end
    if #filled == 0 then
        notify("Slot", "Belum ada slot yang terisi")
        return
    end
    local pos = table.find(filled, slotIdx)
    if pos then
        pos = ((pos - 1 + dir) % #filled) + 1
    else
        pos = dir > 0 and 1 or #filled
    end
    useSlot(filled[pos])
end

------------------------------------------------ EFEK
local FX_NAMES = {"KD_Aura", "KD_Light", "KD_Trail", "KD_A0", "KD_A1"}

local function setFxColor(c)
    local root = getRoot()
    if not root then return end
    local a = root:FindFirstChild("KD_Aura")
    if a then a.Color = ColorSequence.new(c) end
    local l = root:FindFirstChild("KD_Light")
    if l then l.Color = c end
    local t = root:FindFirstChild("KD_Trail")
    if t then t.Color = ColorSequence.new(c) end
end

local function rebuildFx()
    local root = getRoot()
    if not root then return end
    for _, n in ipairs(FX_NAMES) do
        local o = root:FindFirstChild(n)
        if o then o:Destroy() end
    end

    if fx.aura then
        local p = Instance.new("ParticleEmitter")
        p.Name = "KD_Aura"
        p.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        p.Color = ColorSequence.new(fxColor)
        p.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.7),
            NumberSequenceKeypoint.new(1, 0),
        })
        p.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1),
        })
        p.Lifetime = NumberRange.new(0.8, 1.5)
        p.Rate = 45
        p.Speed = NumberRange.new(0.5, 2.5)
        p.SpreadAngle = Vector2.new(180, 180)
        p.LightEmission = 1
        p.Parent = root
    end

    if fx.light then
        local l = Instance.new("PointLight")
        l.Name = "KD_Light"
        l.Range = 14
        l.Brightness = 2
        l.Color = fxColor
        l.Parent = root
    end

    if fx.trail then
        local a0 = Instance.new("Attachment")
        a0.Name = "KD_A0"
        a0.Position = Vector3.new(0, 1.2, 0)
        a0.Parent = root
        local a1 = Instance.new("Attachment")
        a1.Name = "KD_A1"
        a1.Position = Vector3.new(0, -1.2, 0)
        a1.Parent = root
        local t = Instance.new("Trail")
        t.Name = "KD_Trail"
        t.Attachment0 = a0
        t.Attachment1 = a1
        t.Lifetime = 0.6
        t.LightEmission = 1
        t.Color = ColorSequence.new(fxColor)
        t.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(1, 1),
        })
        t.Parent = root
    end
end

RunService.Heartbeat:Connect(function(dt)
    if fx.rainbow then
        hue = (hue + dt * 0.25) % 1
        setFxColor(Color3.fromHSV(hue, 1, 1))
    end
end)

------------------------------------------------ HEADLESS & KORBLOX
local HEADLESS_ID = 15093053680
local KORBLOX_ID = 139607718

local body = {headless = false, korblox = false}
local bodyBackup = {}   -- [part] = {prop = nilaiAsli}
local bodyAssets = {}   -- cache asset yang sudah dimuat

local function getBodyAsset(id)
    if bodyAssets[id] then return bodyAssets[id] end
    local obj = loadAsset(id)
    if obj then bodyAssets[id] = obj end
    return obj
end

local function backupProps(part, props)
    if bodyBackup[part] then return end
    local b = {}
    for _, p in ipairs(props) do
        local ok, v = pcall(function() return part[p] end)
        if ok then b[p] = v end
    end
    bodyBackup[part] = b
end

local function restorePart(part)
    local b = bodyBackup[part]
    if not b then return end
    for p, v in pairs(b) do pcall(function() part[p] = v end) end
    bodyBackup[part] = nil
end

local function firstMeshIn(obj)
    for _, d in ipairs(obj:GetDescendants()) do
        if d:IsA("MeshPart") or d:IsA("SpecialMesh") then return d end
    end
    if obj:IsA("MeshPart") or obj:IsA("SpecialMesh") then return obj end
    return nil
end

local function meshIdOf(m) return m and m.MeshId end
local function texOf(m)
    if not m then return "" end
    return m:IsA("MeshPart") and m.TextureID or m.TextureId
end

-- deteksi tipe rig
local function isR15()
    local hum = getHum()
    return hum and hum.RigType == Enum.HumanoidRigType.R15
end

-- HEADLESS (R15 & R6): kepala + wajah dibuat transparan
local function applyHeadless(on)
    local char = getChar()
    local head = char and char:FindFirstChild("Head")
    if not head then return end
    local face = head:FindFirstChildOfClass("Decal")

    if not on then
        restorePart(head)
        if face then restorePart(face) end
        return
    end

    backupProps(head, {"Transparency"})
    head.Transparency = 1
    if face then
        backupProps(face, {"Transparency"})
        face.Transparency = 1
    end
end

-- KORBLOX (kaki kanan)
-- R6  : CharacterMesh (MeshId 101851696, Overlay 101851254)
-- R15 : RightUpperLeg diberi mesh Korblox utuh (902942096, tekstur 902843398),
--       RightLowerLeg + RightFoot disembunyikan supaya tidak terpotong
local R15_LEG = {"RightUpperLeg", "RightLowerLeg", "RightFoot"}

local function clearKorblox(char)
    for _, d in ipairs(char:GetChildren()) do
        if d.Name == "KD_CharMesh" then d:Destroy() end
    end
    for _, n in ipairs(R15_LEG) do
        local p = char:FindFirstChild(n)
        if p then restorePart(p) end
    end
end

local function applyKorblox(on)
    local char = getChar()
    if not char then return end
    clearKorblox(char)
    if not on then return end

    if not isR15() then
        ------------ R6
        local meshId, overlayId = 101851696, 101851254
        -- coba ambil CharacterMesh asli dari asset ID kamu
        local asset = getBodyAsset(KORBLOX_ID)
        if asset then
            local list = asset:GetDescendants()
            table.insert(list, asset)
            for _, d in ipairs(list) do
                if d:IsA("CharacterMesh") and d.BodyPart == Enum.BodyPart.RightLeg
                    and d.MeshId ~= 0 then
                    meshId, overlayId = d.MeshId, d.OverlayTextureId
                    break
                end
            end
        end
        local cm = Instance.new("CharacterMesh")
        cm.Name = "KD_CharMesh"
        cm.BodyPart = Enum.BodyPart.RightLeg
        cm.MeshId = meshId
        cm.OverlayTextureId = overlayId
        cm.Parent = char
        return
    end

    ------------ R15
    local upper = char:FindFirstChild("RightUpperLeg")
    local lower = char:FindFirstChild("RightLowerLeg")
    local foot = char:FindFirstChild("RightFoot")
    if not upper then return end

    backupProps(upper, {"MeshId", "TextureID", "Transparency"})
    upper.MeshId = "rbxassetid://902942096"
    upper.TextureID = "rbxassetid://902843398"
    upper.Transparency = 0
    for _, p in ipairs({lower, foot}) do
        if p then
            backupProps(p, {"Transparency"})
            p.Transparency = 1
        end
    end
end

-- dipanggil saat toggle diubah
local function updateBody(which, v)
    if which == "headless" then applyHeadless(v) else applyKorblox(v) end
end

local function reapplyBody()
    bodyBackup = {}
    if body.headless then applyHeadless(true) end
    if body.korblox then applyKorblox(true) end
end

------------------------------------------------ RESPAWN
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid", 10)
    task.wait(1)
    if autoReequip and #equipped > 0 then
        local saved = {}
        for _, e in ipairs(equipped) do
            table.insert(saved, {id = e.id, swap = e.swap})
        end
        equipped = {}
        for _, s in ipairs(saved) do equipId(s.id, s.swap, true) end
    else
        equipped = {}
    end
    rebuildFx()
    reapplyBody()
    refreshList()
end)

------------------------------------------------ WINDOW
local Window = Rayfield:CreateWindow({
    Name = "KizzDev | Accessory Hub",
    Theme = "Amethyst",
    LoadingTitle = "KizzDev",
    LoadingSubtitle = "Accessory Hub",
    ConfigurationSaving = {Enabled = true, FolderName = "KizzDev", FileName = "AccessoryHub"},
    KeySystem = false,
})

------------------------------------------------ TAB AKSESORI
local AccTab = Window:CreateTab("Aksesori", 4483362458)

AccTab:CreateSection("Pasang Aksesori (Asset ID atau link katalog)")
AccTab:CreateInput({
    Name = "Asset ID / Link",
    PlaceholderText = "tempel ID atau link katalog",
    RemoveTextAfterFocusLost = false,
    Callback = function(t) typedId = parseId(t) end,
})
AccTab:CreateButton({
    Name = "Pakai (Ganti Cepat)",
    Callback = function()
        if not typedId then notify("Error", "Isi Asset ID dulu") return end
        run(function() swapTo(typedId) end)
    end,
})
AccTab:CreateButton({
    Name = "Tambah di Atas Aksesori Lain",
    Callback = function()
        if not typedId then notify("Error", "Isi Asset ID dulu") return end
        run(function() equipId(typedId, false) end)
    end,
})
AccTab:CreateButton({
    Name = "Lepas yang Terakhir",
    Callback = function()
        local e = equipped[#equipped]
        if e then removeEntry(e) refreshList() else notify("Info", "Tidak ada yang dilepas") end
    end,
})
AccTab:CreateButton({
    Name = "Lepas Semua Buatan Script",
    Callback = function()
        for i = #equipped, 1, -1 do removeEntry(equipped[i]) end
        refreshList()
    end,
})
AccTab:CreateButton({
    Name = "Lepas Semua Aksesori Avatar",
    Callback = function()
        local char = getChar()
        if not char then return end
        for _, c in ipairs(char:GetChildren()) do
            if c:IsA("Accoutrement") then c:Destroy() end
        end
        equipped = {}
        refreshList()
    end,
})
AccTab:CreateToggle({
    Name = "Pasang Ulang Otomatis saat Respawn",
    CurrentValue = true,
    Callback = function(v) autoReequip = v end,
})
ListLabel = AccTab:CreateLabel("Belum ada aksesori yang dipasang")

------------------------------------------------ TAB SLOT CEPAT
local SlotTab = Window:CreateTab("Slot Cepat", 4483362458)

SlotTab:CreateSection("Isi 5 slot, lalu ganti dalam sekali tekan")
for n = 1, 5 do
    SlotTab:CreateInput({
        Name = "Slot " .. n .. " (Asset ID / Link)",
        PlaceholderText = "kosong",
        RemoveTextAfterFocusLost = false,
        Flag = "Slot" .. n,
        Callback = function(t) slotIds[n] = parseId(t) end,
    })
    SlotTab:CreateButton({
        Name = "Pakai Slot " .. n,
        Callback = function() run(function() useSlot(n) end) end,
    })
end
SlotTab:CreateSection("Ganti Berurutan")
SlotTab:CreateButton({
    Name = "<  Slot Sebelumnya",
    Callback = function() run(function() cycle(-1) end) end,
})
SlotTab:CreateButton({
    Name = "Slot Berikutnya  >",
    Callback = function() run(function() cycle(1) end) end,
})

------------------------------------------------ TAB AVATAR
local BodyTab = Window:CreateTab("Headless + Korblox", 4483362458)

BodyTab:CreateSection("Body Client-Side (hanya terlihat olehmu)")
BodyTab:CreateToggle({
    Name = "Headless (Tanpa Kepala)",
    CurrentValue = false,
    Flag = "Headless",
    Callback = function(v)
        body.headless = v
        task.spawn(function() pcall(updateBody, "headless", v) end)
    end,
})
BodyTab:CreateToggle({
    Name = "Korblox (Kaki Kanan)",
    CurrentValue = false,
    Flag = "Korblox",
    Callback = function(v)
        body.korblox = v
        task.spawn(function() pcall(updateBody, "korblox", v) end)
    end,
})

------------------------------------------------ TAB EFEK
local FxTab = Window:CreateTab("Efek", 4483362458)

FxTab:CreateSection("Efek Visual (hanya terlihat olehmu)")
FxTab:CreateToggle({
    Name = "Aura Partikel",
    CurrentValue = false,
    Callback = function(v) fx.aura = v rebuildFx() end,
})
FxTab:CreateToggle({
    Name = "Cahaya Menyala",
    CurrentValue = false,
    Callback = function(v) fx.light = v rebuildFx() end,
})
FxTab:CreateToggle({
    Name = "Jejak (Trail)",
    CurrentValue = false,
    Callback = function(v) fx.trail = v rebuildFx() end,
})
FxTab:CreateToggle({
    Name = "Neon Glow Aksesori",
    CurrentValue = false,
    Callback = function(v) fx.neon = v applyNeon() end,
})
FxTab:CreateToggle({
    Name = "Warna Pelangi",
    CurrentValue = false,
    Callback = function(v)
        fx.rainbow = v
        if not v then setFxColor(fxColor) end
    end,
})
FxTab:CreateColorPicker({
    Name = "Warna Efek",
    Color = fxColor,
    Flag = "FxColor",
    Callback = function(c)
        fxColor = c
        if not fx.rainbow then setFxColor(c) end
    end,
})

------------------------------------------------ TAB MISC
local MiscTab = Window:CreateTab("Misc", 4483362458)

LocalPlayer.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)
MiscTab:CreateParagraph({Title = "Anti AFK", Content = "Aktif otomatis."})
MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end,
})
MiscTab:CreateButton({
    Name = "Destroy UI",
    Callback = function() Rayfield:Destroy() end,
})

------------------------------------------------ TAB INFO
local InfoTab = Window:CreateTab("Info", 4483362458)
InfoTab:CreateParagraph({
    Title = "KizzDev Accessory Hub",
    Content = "Aksesori dan efek hanya terlihat di layarmu, tidak oleh pemain lain. Tempel Asset ID atau link katalog, lalu tekan Pakai.",
})
InfoTab:CreateParagraph({
    Title = "Tips",
    Content = "Isi Slot Cepat sekali, nanti tersimpan otomatis. Pakai tombol Slot Berikutnya untuk ganti aksesori dalam sekali tekan.",
})

Rayfield:LoadConfiguration()
task.spawn(stylePrompt)
