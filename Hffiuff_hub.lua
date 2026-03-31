--[[
    Hffiuff Hub 🗿🇻🇳
    Owner: khangdz
    Status: Bản hoàn chỉnh - V27 Instant Omnipotence
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "Bản hoàn chỉnh - V27 Instant",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
_G.WhitelistName = ""
_G.CustomSpamText = "Hffiuff Hub 🗿🇻🇳 - Bay màu trong 0.00001s!"
_G.HitboxSize = 50
_G.HitboxActive = false
_G.InstaKill = false

-- --- TAB 1: HITBOX RIÊNG BIỆT ---
local HitboxTab = Window:CreateTab("Hitbox Settings", 4483345998)

HitboxTab:CreateToggle({
   Name = "Bật Hitbox riêng",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
   end,
})

HitboxTab:CreateSlider({
   Name = "Kích thước Hitbox",
   Range = {2, 2048},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 50,
   Callback = function(Value) _G.HitboxSize = Value end,
})

-- Vòng lặp Hitbox độc lập
task.spawn(function()
    while true do
        if _G.HitboxActive then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    v.Character.HumanoidRootPart.Transparency = 0.8
                    v.Character.HumanoidRootPart.CanTouch = true
                end
            end
        end
        task.wait(0.5)
    end
end)

-- --- TAB 2: INSTANT KILL (TỐC ĐỘ 0.00001S) ---
local KillTab = Window:CreateTab("Instant Kill", 4483345998)

KillTab:CreateToggle({
   Name = "Bật Kill All (Siêu Tốc Độ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.InstaKill = Value
      if Value then
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Chế độ Sát Phạt Tức Thì đã bật!", Duration = 2})
      else
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Đã tắt Sát Phạt!", Duration = 2})
      end
   end,
})

-- Lõi Sát Phạt Tức Thì (Chạy theo nhịp Tim của Game)
RunService.Stepped:Connect(function()
    if _G.InstaKill then
        local char = lp.Character
        if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
            
            -- Tự động cầm vũ khí ngay lập tức
            local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
            if tool then
                if tool.Parent ~= char then tool.Parent = char end
                
                local blade = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part") or tool:FindFirstChildOfClass("MeshPart")
                if blade then
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                            
                            -- Kiểm tra Whitelist
                            local isIgnored = false
                            if _G.WhitelistName ~= "" then
                                if string.find(string.lower(v.Name), string.lower(_G.WhitelistName)) or string.find(string.lower(v.DisplayName), string.lower(_G.WhitelistName)) then
                                    isIgnored = true
                                end
                            end
                            
                            if not isIgnored then
                                local eRoot = v.Character:FindFirstChild("HumanoidRootPart")
                                if eRoot then
                                    -- Gửi tín hiệu sát thương liên tục 5 lần mỗi Frame để ép chết ngay lập tức
                                    for i = 1, 5 do
                                        firetouchinterest(eRoot, blade, 0)
                                        firetouchinterest(eRoot, blade, 1)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- --- TAB 3: HỖ TRỢ ---
local SupportTab = Window:CreateTab("Support", 4483345998)

SupportTab:CreateInput({
   Name = "Né người chơi (Whitelist)",
   PlaceholderText = "Nhập tên...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) _G.WhitelistName = Text end,
})

SupportTab:CreateLabel("----------------------------------------")
SupportTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB 4: MISC ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateInput({
   Name = "Nội dung Spam Chat",
   PlaceholderText = "Bạn muốn gáy gì...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) _G.CustomSpamText = Text end,
})

MiscTab:CreateToggle({
   Name = "Auto Spam Chat",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpamChat = Value
      task.spawn(function()
         while _G.SpamChat do
            pcall(function()
                local msg = _G.CustomSpamText
                if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
                else
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
                end
            end)
            task.wait(2) -- Giảm delay spam xuống 2s cho cháy
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")
