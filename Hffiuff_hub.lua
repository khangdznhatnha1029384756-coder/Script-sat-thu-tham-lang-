 --[[
    Hffiuff Hub 🗿🇻🇳
    Owner: khangdz
    Notes: Bản hoàn chỉnh - Ultimate Hitbox Aura
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "Bản hoàn chỉnh - Đánh Ảo",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
_G.WhitelistName = ""
_G.OriginalPosition = nil
_G.CustomSpamText = "Hffiuff Hub 🗿🇻🇳 - Sát phạt toàn map!"
_G.HitboxSize = 2048 -- Mặc định cực đại để đánh ảo

-- --- BỆ ĐỨNG GIỮA TRỜI ---
local function CreatePlatform()
    local plat = workspace:FindFirstChild("HffiuffPlatform")
    if not plat then
        plat = Instance.new("Part")
        plat.Name = "HffiuffPlatform"
        plat.Size = Vector3.new(100, 2, 100)
        plat.Position = Vector3.new(0, 2995, 0)
        plat.Anchored = true
        plat.Transparency = 1
        plat.Parent = workspace
    end
end

-- --- TAB CHIẾN ĐẤU (CHÉM ẢO + HITBOX) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Đánh Ảo (Aura + Max Hitbox)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AuraKill = Value
      local char = lp.Character
      
      if Value then
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Đã bật Đánh Ảo cực đại!", Duration = 3})
          CreatePlatform()
          if char and char:FindFirstChild("HumanoidRootPart") then
              _G.OriginalPosition = char.HumanoidRootPart.CFrame
          end
      else
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Đã tắt!", Duration = 2})
          if char and char:FindFirstChild("HumanoidRootPart") and _G.OriginalPosition then
              char.HumanoidRootPart.CFrame = _G.OriginalPosition
          end
          -- Reset Hitbox về bình thường khi tắt
          for _, v in pairs(game.Players:GetPlayers()) do
              if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
              end
          end
      end
   end,
})

CombatTab:CreateSlider({
   Name = "Phạm vi Đánh Ảo",
   Range = {2, 2048},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 2048,
   Callback = function(Value) _G.HitboxSize = Value end,
})

-- Vòng lặp: Tự cầm kiếm + Phóng to Hitbox + Sát phạt ngầm
task.spawn(function()
    while true do
        if _G.AuraKill then
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart") then
                
                -- Giữ vị trí trên cao
                char.HumanoidRootPart.CFrame = CFrame.new(0, 3000, 0)
                
                -- Tự cầm vũ khí
                local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                
                if tool then
                    if tool.Parent ~= char then tool.Parent = char end
                    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part")
                    
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
                                        -- BƯỚC QUAN TRỌNG: Phóng to hitbox để chém ảo dính 100%
                                        eRoot.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                                        eRoot.Transparency = 0.9 -- Gần như tàng hình để không lag
                                        eRoot.CanTouch = true
                                        
                                        -- Sát phạt thụ động
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
        task.wait(0.1)
    end
end)

-- --- TAB HỖ TRỢ ---
local SupportTab = Window:CreateTab("Support", 4483345998)

SupportTab:CreateInput({
   Name = "Né người chơi (Whitelist)",
   PlaceholderText = "Nhập tên...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) _G.WhitelistName = Text end,
})

SupportTab:CreateLabel("----------------------------------------")
SupportTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB MISC ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateInput({
   Name = "Nội dung Spam",
   PlaceholderText = "Nhập câu gáy...",
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
            task.wait(3)
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")
