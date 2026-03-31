
--[[
    Hffiuff Hub 🗿🇻🇳
    Owner: khangdz
    Status: Bản hoàn chỉnh - V28 OMNI-REACH
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "Bản hoàn chỉnh - V28 Supreme",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
_G.WhitelistName = ""
_G.CustomSpamText = "Hffiuff Hub 🗿🇻🇳 - Đánh ảo không đối thủ!"
_G.HitboxSize = 50
_G.AuraKill = false
_G.ESPActive = false

-- --- TAB 1: CHIẾN ĐẤU (CHÉM ẢO + HITBOX) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Chém Ảo (Aura Sát Phạt)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AuraKill = Value
      if Value then
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Chế độ Đánh Ảo đã kích hoạt!", Duration = 2})
      end
   end,
})

CombatTab:CreateSlider({
   Name = "Phạm vi Hitbox (Đánh xa)",
   Range = {2, 2048},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 50,
   Callback = function(Value) _G.HitboxSize = Value end,
})

-- LÕI XỬ LÝ SÁT THƯƠNG SIÊU TỐC (SPAM DAME)
RunService.Heartbeat:Connect(function()
    if _G.AuraKill then
        local char = lp.Character
        if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
            local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
            
            if tool then
                if tool.Parent ~= char then tool.Parent = char end -- Tự động cầm kiếm
                
                local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part") or tool:FindFirstChildOfClass("MeshPart")
                if handle then
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
                                    -- ÉP HITBOX CỰC ĐẠI
                                    eRoot.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                                    eRoot.Transparency = 0.8
                                    eRoot.CanTouch = true
                                    
                                    -- SPAM ĐÁNH ẢO (Gửi 10 lần sát thương mỗi Frame)
                                    for i = 1, 10 do
                                        firetouchinterest(eRoot, handle, 0)
                                        firetouchinterest(eRoot, handle, 1)
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

-- --- TAB 2: VISUAL (ESP) ---
local VisualTab = Window:CreateTab("Visual", 4483345998)

VisualTab:CreateToggle({
   Name = "Bật ESP (Hiện đối thủ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESPActive = Value
   end,
})

-- Vòng lặp ESP
task.spawn(function()
    while true do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                local head = v.Character.Head
                local existing = head:FindFirstChild("Hffiuff_ESP")
                
                if _G.ESPActive then
                    if not existing then
                        local b = Instance.new("BillboardGui", head)
                        b.Name = "Hffiuff_ESP"
                        b.AlwaysOnTop = true
                        b.Size = UDim2.new(0, 100, 0, 30)
                        local t = Instance.new("TextLabel", b)
                        t.Text = v.DisplayName or v.Name
                        t.TextColor3 = Color3.fromRGB(255, 0, 0) -- Màu đỏ rực
                        t.TextStrokeTransparency = 0
                        t.BackgroundTransparency = 1
                        t.Size = UDim2.new(1, 0, 1, 0)
                        t.Font = Enum.Font.SourceSansBold
                        t.TextSize = 14
                    end
                else
                    if existing then existing:Destroy() end
                end
            end
        end
        task.wait(1)
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
SupportTab:CreateLabel("by developer Hffiuff 🗿\240\159\135\182\240\159\135\179")

-- --- TAB 4: MISC (SPAM CHAT) ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateInput({
   Name = "Nội dung Spam",
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
            task.wait(2.5)
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿\240\159\135\182\240\159\135\179")
