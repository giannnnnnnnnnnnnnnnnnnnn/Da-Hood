--[[
  Spooky Control V2.5 Source Code, Have fun skids.
  (This is not updated and was made over 4 months ago, be careful.)
]]--

-- // IF YOU ARE USING THE SOURCE VERSION THEN REMOVE THE --[[ & ]]--

--[[
    getgenv().Settings = {
        ['Controller'] = 12345, --// Controller ID
        ['Prefix'] = ".", --// Chat Prefix
        ['FPS'] = 3, --// Alts FPS
        ['Advert'] = ".gg/halloweens", --// Your Advert
        ['GUI'] = true, --// GUI Enabled/Disabled
    }
    getgenv().Alts = { --// Max is 38
        Alt1 = 12345,
        Alt2 = 12345,
        Alt3 = 12345,
    }
]]--

--// Variables
local Controller = getgenv().Settings.Controller
local Prefix = getgenv().Settings.Prefix
local LocalPlayer = game.Players.LocalPlayer
local ID = game.Players.LocalPlayer.UserId
local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
local ControllerName = game.Players:GetNameFromUserIdAsync(tonumber(Controller))
local SayMessageRequest = game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
local Chatted = game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent
local Locations = loadstring(game:HttpGet('https://raw.githubusercontent.com/spookvy/SpookyControl/main/setup.lua'))()
local Codes = loadstring(game:HttpGet('https://raw.githubusercontent.com/halloweevn/Spooky/main/codes.lua'))()

--// Game Loaded
if not game:IsLoaded() then
    repeat
        wait()
    until game:IsLoaded()
end

--// Anti AFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

--// Spooky Loaded Check
if getgenv().SpookyLoaded == true then
    return
else
    getgenv().SpookyLoaded = true
    
    --// Game Check
    if game.PlaceId ~= 2788229376 then
        LocalPlayer:Kick("wrong game")
    else
        --// Controller Check
        if not game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(Controller)) then
            game.StarterGui:SetCore("SendNotification", { Title = "?", Text = "Waiting For Controller...", Duration = math.huge })
            repeat
                wait()
            until game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(Controller))
        end

        --// Loaded
        game.StarterGui:SetCore("SendNotification", { Title = "Spooky Control", Text = "Loading...", Duration = 7 })
        repeat wait() until game.Workspace.Players:FindFirstChild(game.Players.LocalPlayer.Name)
        game.StarterGui:SetCore("SendNotification", { Title = "!", Text = "Spooky Control has Loaded", Duration = 5 })

        --// Group
        if 1 > game.Players:FindFirstChild(game.Players:GetNameFromUserIdAsync(Controller)):GetRankInGroup(13629749) then
            LocalPlayer:Kick("group needed")
        else
            Chatted:Connect(function(Command)
                local MessageData = Command.Message
                MessageData = string.lower(MessageData)
                local Args = string.split(MessageData, ' ')
                if game.Players[Command.FromSpeaker].UserId == Controller then

                    --// Drop
                    if Args[1] == Prefix.."drop" then
                        if ID ~= Controller then
                            getgenv().DropMoney = true
                            while DropMoney == true do
                                local DropAmount = nil
                                if game.Players.LocalPlayer.DataFolder.Currency.Value < 10000 then
                                    DropAmount = game.Players.LocalPlayer.DataFolder.Currency.Value
                                else
                                    DropAmount = 10000
                                end
                                wait()
                                game.ReplicatedStorage.MainEvent:FireServer("DropMoney", DropAmount)
                                game.ReplicatedStorage.MainEvent:FireServer("Block", true)
                            end
                        end
                    --// Stop
                    elseif Args[1] == Prefix.."stop" then
                        if ID ~= Controller then
                            getgenv().DropMoney = false
                            wait()
                            game.ReplicatedStorage.MainEvent:FireServer("Block", false)
                        end
                    --// Setup
                    elseif Args[1] == Prefix.."setup" and Args[2] ~= nil then
                        if ID ~= Controller then
                            local SetupLocation = Args[2]
                            for _, Alts in pairs(getgenv().Alts) do
                                if Alts == game.Players.LocalPlayer.UserId then
                                    local ID = _
                                    local PositionTable = Locations[SetupLocation][ID]
                                    print(PositionTable)
                                    local Position = string.split(PositionTable, ",")
                                    local X, Y, Z = Position[1], Position[2], Position[3]
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(X, Y, Z)
                                end
                            end
                        else
                            if Args[2] == "admin" then
                                HumanoidRootPart.CFrame = CFrame.new(-871.785278, -32.6492119, -652.849182, -0.999992073, 4.68113122e-08, -0.00398096582, 4.69743107e-08, 1, -4.08507184e-08, 0.00398096582, -4.10373957e-08, -0.999992073)
                            elseif Args[2] == "bank" then
                                HumanoidRootPart.CFrame = CFrame.new(-375.632324, 21.2480183, -351.037842, -0.999990225, -3.82589498e-08, -0.00442149304, -3.79021188e-08, 1, -8.07878067e-08, 0.00442149304, -8.06194365e-08, -0.999990225)
                            elseif Args[2] == "school" then
                                HumanoidRootPart.CFrame = CFrame.new(-602.800537, 21.4980183, 160.242432, -0.999967217, -3.07487147e-10, -0.0080942288, -3.88604177e-10, 1, 1.0020015e-08, 0.0080942288, 1.00228323e-08, -0.999967217)
                            elseif Args[2] == "train" then
                                HumanoidRootPart.CFrame = CFrame.new(641.997253, 48, -114.914413, -0.99968493, 7.91000332e-08, -0.0251009576, 7.79249802e-08, 1, 4.7791449e-08, 0.0251009576, 4.58203999e-08, -0.99968493)
                            elseif Args[2] == "basket" then
                                HumanoidRootPart.CFrame = CFrame.new(-933.516296, 22.0378437, -526.379272, -0.999972999, -4.88194019e-08, 0.00734632602, -4.81996913e-08, 1, 8.45338661e-08, -0.00734632602, 8.41774934e-08, -0.999972999)
                            end
                        end
                    --// CDrop
                    elseif Args[1] == Prefix.."cdrop" and Args[2] ~= nil then
                        if ID ~= Controller then
                            local function Amounts(a)
                                local b = string.lower(a)
                                if b:find('k') then
                                    local Thousands = string.gsub(b, 'k', '')
                                    return Thousands * 1000
                                elseif b:find('m') then
                                    local Millions = string.gsub(b, 'm', '')
                                    return Millions * 1000000
                                elseif b:find('b') then
                                    local Billions = string.gsub(b, 'b', '')
                                    return Billions * 1000000000
                                end
                            end
                            local Amount = Amounts(Args[2])
                            local OldMoney = 0
                            for i,v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
                                if v.Name == "MoneyDrop" then
                                    local OldAmount = string.gsub(v.BillboardGui.TextLabel.Text, "%D", "")
                                    OldMoney = OldMoney + OldAmount
                                end
                            end
                            SayMessageRequest:FireServer("cdrop started", "All")
                            repeat
                                local CDrop = 0
                                game.ReplicatedStorage.MainEvent:FireServer("DropMoney", 10000)
                                wait()
                                game.ReplicatedStorage.MainEvent:FireServer("Block", true)
                                for i,v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
                                    if v.Name == "MoneyDrop" then
                                        local CashAmount = string.gsub(v.BillboardGui.TextLabel.Text, "%D", "")
                                        CDrop = CDrop + CashAmount
                                    end
                                end
                            until CDrop > Amount + OldMoney
                            SayMessageRequest:FireServer("cdrop complete", "All")
                            wait()
                            game.ReplicatedStorage.MainEvent:FireServer("Block", false)
                        end
                    --// Bring
                    elseif Args[1] == Prefix.."bring" then
                        if ID ~= Controller then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players[ControllerName].Character.HumanoidRootPart.CFrame.Position) * CFrame.new(-4, 0, 4)
                        end
                    --// Wallet
                    elseif Args[1] == Prefix.."wallet" and Args[2] ~= nil then
                        if Args[2] == "on" then
                            if ID ~= Controller then
                                game.Players.LocalPlayer.Backpack.Wallet.Parent = game.Players.LocalPlayer.Character
                            end
                        elseif Args[2] == "off" then
                            if ID ~= Controller then
                                game.Players.LocalPlayer.Character.Wallet.Parent = game.Players.LocalPlayer.Backpack
                            end
                        end
                    --// Freeze
                    elseif Args[1] == Prefix.."freeze" and Args[2] ~= nil then
                        if Args[2] == "on" then
                            if ID ~= Controller then
                                HumanoidRootPart.Anchored = true
                            end
                        elseif Args[2] == "off" then
                            if ID ~= Controller then
                                HumanoidRootPart.Anchored = false
                            end
                        end
                    --// Reset
                    elseif Args[1] == Prefix.."reset" then
                        if ID ~= Controller then
                            HumanoidRootPart.Anchored = false
                            wait()
                            game.Players.LocalPlayer.Character.Humanoid.Health = 0
                        end
                    --// Kick
                    elseif Args[1] == Prefix.."kick" then
                        if ID ~= Controller then
                            game.Players.LocalPlayer:Kick("\nALT's Kicked by Controller.")
                        end
                    --// Airlock
                    elseif Args[1] == Prefix.."airlock" and Args[2] ~= nil then
                        if Args[2] == "on" then
                            if ID ~= Controller then
                                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.CFrame.Position) * CFrame.new(0, 14, 0)
                                wait(0.2)
                                HumanoidRootPart.Anchored = true
                            end
                        elseif Args[2] == "off" then
                            if ID ~= Controller then
                                HumanoidRootPart.Anchored = false
                            end
                        end
                    --// God
                    elseif Args[1] == Prefix.."god" then
                        if ID ~= Controller then
                            game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild('Attacking'):Destroy()
                        end
                    --// Advert
                    elseif Args[1] == Prefix.."advert" and Args[2] ~= nil then
                        if Args[2] == "on" then
                            if ID ~= Controller then
                                getgenv().Advert = true
                                while Advert == true do
                                    SayMessageRequest:FireServer(getgenv().Settings.Advert, 'All')
                                    wait(10)
                                end
                            end
                        elseif Args[2] == "off" then
                            if ID ~= Controller then
                                getgenv().Advert = false
                            end
                        end
                    --// Mask
                    elseif Args[1] == Prefix.."mask" then
                        if ID ~= Controller then
                            local OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                            local Name = game.Players.LocalPlayer.Name
                            local Item = game.Workspace.Ignored.Shop["[Surgeon Mask] - $25"]
                            HumanoidRootPart.CFrame = Item.Head.CFrame + Vector3.new(0, 3, 0)
                            if (HumanoidRootPart.Position - Item.Head.Position).Magnitude <= 50 then
                                wait(0.2)
                                fireclickdetector(Item:FindFirstChild("ClickDetector"), 6)
                            end
                            wait(0.5)
                            HumanoidRootPart.CFrame = CFrame.new(OldPosition)
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Mask") then
                                game.Players.LocalPlayer.Backpack:FindFirstChild("Mask").Parent = game.Players.LocalPlayer.Character
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                                wait(0.2)
                                game.Workspace.Players[Name]["In-gameMask"].Handle:Destroy()
                            else
                                repeat
                                    HumanoidRootPart.CFrame = Item.Head.CFrame + Vector3.new(0, 3, 0)
                                    if (HumanoidRootPart.Position - Item.Head.Position).Magnitude <= 50 then
                                        wait(0.2)
                                        fireclickdetector(Item:FindFirstChild("ClickDetector"), 6)
                                    end
                                until
                                game.Players.LocalPlayer.Backpack:FindFirstChild("Mask")
                                if game.Players.LocalPlayer.Backpack:FindFirstChild("Mask") then
                                    game.Players.LocalPlayer.Backpack:FindFirstChild("Mask").Parent = game.Players.LocalPlayer.Character
                                    game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                                    wait(0.5)
                                    game.Workspace.Players[Name]["In-gameMask"].Handle:Destroy()
                                end
                            end
                        end
                    --// FPS
                    elseif Args[1] == Prefix.."fps" and Args[2] ~= nil then
                        if ID ~= Controller then
                            local FPSCap = tonumber(Args[2])
                            setfpscap(FPSCap)
                        end
                    --// Redeem
                    elseif Args[1] == Prefix.."redeem" then
                        if ID ~= Controller then
                            for _, Codes in pairs(Codes) do
                                game:GetService("ReplicatedStorage").MainEvent:FireServer("EnterPromoCode", Codes)
                            end
                        end
                    --// Crash
                    elseif Args[1] == Prefix.."crash" and Args[2] ~= nil then
                        if Args[2] == "swag" then
                            if ID == Controller or ID == Alts['Alt1'] or ID == Alts['Alt2'] then
                                loadstring(game:HttpGet('https://raw.githubusercontent.com/lerkermer/lua-projects/master/SuperCustomServerCrasher'))()
                            end
                        elseif Args[2] == "encrypt" then
                            if ID == Controller or ID == Alts['Alt1'] or ID == Alts['Alt2'] then
                                loadstring(game:HttpGet('https://raw.githubusercontent.com/LPrandom/lua-projects/master/dahoodcrasher.lua'))()
                            end
                        elseif Args[2] == "bdh" then
                            if ID == Controller or ID == Alts['Alt1'] or ID == Alts['Alt2'] then
                                loadstring(game:HttpGet('https://raw.githubusercontent.com/BetterDaHood/BetterDaHoodCrasher/main/Crash'))()
                            end
                        end
                    end
                end
            end)

            --// GUI
            if getgenv().Settings.GUI == true then
                if ID == Controller then
                    loadstring(game:HttpGet('https://raw.githubusercontent.com/halloweevn/Spooky/main/gui.lua', true))()
                end
            end

            --// Low GFX
            if ID == Controller then
                local decalsyeeted = true
                local g = game
                local w = g.Workspace
                local l = g.Lighting
                local t = w.Terrain
                t.WaterWaveSize = 0
                t.WaterWaveSpeed = 0
                t.WaterReflectance = 0
                t.WaterTransparency = 0
                l.GlobalShadows = false
                l.FogEnd = 9e9
                l.Brightness = 0
                settings().Rendering.QualityLevel = "Level01"
                for i, v in pairs(g:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                        v.Transparency = 1
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Lifetime = NumberRange.new(0)
                    elseif v:IsA("Explosion") then
                        v.BlastPressure = 1
                        v.BlastRadius = 1
                    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                        v.Enabled = false
                    elseif v:IsA("MeshPart") then
                        v.Material = "Plastic"
                        v.Reflectance = 0
                        v.TextureID = 10385902758728957
                    end
                end
                for i, e in pairs(l:GetChildren()) do
                    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                        e.Enabled = false
                    end
                end
            end

            --// Cash Counter
            if ID == Controller then
                local ScreenGui = Instance.new("ScreenGui")
                local CCHolderFrame = Instance.new("Frame")
                local CCText = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")
                ScreenGui.Parent = game.CoreGui
                ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                CCHolderFrame.Name = "CCHolderFrame"
                CCHolderFrame.Parent = ScreenGui
                CCHolderFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                CCHolderFrame.Position = UDim2.new(0.0166840293, 0, 0.0357142836, 0)
                CCHolderFrame.Size = UDim2.new(0, 250, 0, 80)
                CCText.Name = "CCText"
                CCText.Parent = CCHolderFrame
                CCText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                CCText.BackgroundTransparency = 1.000
                CCText.Size = UDim2.new(0, 250, 0, 80)
                CCText.Font = Enum.Font.GothamBlack
                CCText.Text = "$0"
                CCText.TextColor3 = Color3.fromRGB(111, 111, 111)
                CCText.TextSize = 20.000
                UICorner.Parent = CCHolderFrame
                local function NYKOTQ_fake_script()
                local script = Instance.new('LocalScript', CCText)
                local function CommaNumbers(Amount)
                    local Formatted = Amount
                    while wait() do
                        Formatted, K = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
                        if (K == 0) then
                            break
                        end
                    end
                    return Formatted
                end
                while wait() do
                    local Cash = 0
                    for i,v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
                        if v.Name == "MoneyDrop" then
                            local CashAmounts = string.gsub(v.BillboardGui.TextLabel.Text, "%D", "")
                            Cash = Cash + CashAmounts
                        end
                    end
                    script.Parent.Text = "$"..CommaNumbers(Cash)
                end
                end
                coroutine.wrap(NYKOTQ_fake_script)()
                local function UJMPMCF_fake_script()
                local script = Instance.new('LocalScript', CCHolderFrame)
                script.Parent.Active = true
                script.Parent.Draggable = true
                local Mouse = game.Players.LocalPlayer:GetMouse()
                local Toggle = true
                Mouse.KeyDown:Connect(function(Key)
                    if Key == "c" and Toggle == false then
                        Toggle = true
                        script.Parent.Visible = false
                    elseif Key == "c" and Toggle == true then
                        Toggle = false
                        script.Parent.Visible = true
                    end
                end)
                end
                coroutine.wrap(UJMPMCF_fake_script)()
            end

            --// Destroy Players
            if ID ~= Controller then
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then
                        if v.Name ~= ControllerName then
                            for i,v in pairs(v.Character:GetChildren()) do
                                v:Destroy()
                            end
                        end
                    end
                end
                game:GetService("Workspace").Players.ChildAdded:Connect(function(CharacterAdded)
                    if CharacterAdded then
                        for i,v in pairs(game.Players:GetPlayers()) do
                            if v ~= game.Players.LocalPlayer then
                                if v.Name ~= ControllerName then
                                    for i,v in pairs(v.Character:GetChildren()) do
                                        v:Destroy()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
            
            --// CPU Saver
            if ID ~= Controller then
                local CPUSaver = Instance.new("ScreenGui")
                local Frame = Instance.new("Frame")
                local TextLabel = Instance.new("TextLabel")
                local TextLabel_2 = Instance.new("TextLabel")
                CPUSaver.Name = "CPUSaver"
                CPUSaver.Parent = game.CoreGui
                CPUSaver.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                Frame.Parent = CPUSaver
                Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Frame.Position = UDim2.new(-0.358185619, 0, -0.832251132, 0)
                Frame.Size = UDim2.new(0, 3291, 0, 2462)
                TextLabel.Parent = Frame
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.Position = UDim2.new(0.438468546, 0, 0.479691327, 0)
                TextLabel.Size = UDim2.new(0, 404, 0, 50)
                TextLabel.Font = Enum.Font.GothamBlack
                TextLabel.Text = "Spooky Control"
                TextLabel.TextColor3 = Color3.fromRGB(77, 77, 77)
                TextLabel.TextSize = 42.000
                TextLabel.TextWrapped = true
                TextLabel_2.Parent = Frame
                TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel_2.BackgroundTransparency = 1.000
                TextLabel_2.Position = UDim2.new(0.438468546, 0, 0.5, 0)
                TextLabel_2.Size = UDim2.new(0, 404, 0, 50)
                TextLabel_2.Font = Enum.Font.GothamBlack
                TextLabel_2.Text = "Welcome, halloweevn"
                TextLabel_2.TextColor3 = Color3.fromRGB(71, 71, 71)
                TextLabel_2.TextSize = 25.000
                TextLabel_2.TextWrapped = true
                local function HJUYPTD_fake_script()
                    local script = Instance.new('LocalScript', TextLabel_2)
                    script.Parent.Text = "Welcome, "..game.Players.LocalPlayer.Name
                end
                coroutine.wrap(HJUYPTD_fake_script)()
                UserSettings().GameSettings.MasterVolume = 0
                game:GetService("RunService"):Set3dRenderingEnabled(false)
                settings().Rendering.QualityLevel = 1
                wait()
                setfpscap(tonumber(getgenv().Settings.FPS))
                wait()
                for i,v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = 1
                    elseif v:IsA("ParticleEmitter") then
                        v.Enabled = false
                    elseif v:IsA("Trail") then
                        v.Enabled = false
                    elseif v:IsA("Decal") then
                        v.Transparency = 1
                    end
                end
            end

            --// Destroy Cash
            if ID ~= Controller then
                for i,v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
                    v.Transparency = 1
                    for i,v in pairs(v:GetChildren()) do
                        if v:IsA("Decal") then
                            v.Transparency = 1
                        elseif v:IsA("BillboardGui") then
                            v.Enabled = false
                        end
                    end
                end
                game:GetService("Workspace").Ignored.Drop.ChildAdded:Connect(function(Cash)
                    if Cash then
                        wait()
                        for i,v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
                            v.Transparency = 1
                            for i,v in pairs(v:GetChildren()) do
                                if v:IsA("Decal") then
                                    v.Transparency = 1
                                elseif v:IsA("BillboardGui") then
                                    v.Enabled = false
                                end
                            end
                        end
                    end     
                end)
            end
        end
    end
end
