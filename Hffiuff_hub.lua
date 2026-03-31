 --[[
    Hffiuff Hub 🗿🇻🇳
    Owner: khangdz
    Notes: Bản hoàn chỉnh - Auto Equip & Aura Kill
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "Bản hoàn chỉnh - Auto Equip",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
_G.WhitelistName = ""
_G.OriginalPosition = nil
_G.CustomSpamText = "Hffiuff Hub 🗿🇻🇳 - Tự động sát phạt!"

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

-- --- TAB CHIẾN ĐẤU ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Auto Farm (Aura + Auto Equip)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AuraKill = Value
      local char = lp.Character
      
      if Value then
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Đã bật! Script sẽ tự cầm kiếm và farm.", Duration = 3})
          CreatePlatform()
          if char and char:FindFirstChild("HumanoidRootPart") then
              _G.OriginalPosition = char.HumanoidRootPart.CFrame
          end
      else
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Đã tắt Auto Farm!", Duration = 2})
          if char and char:FindFirstChild("HumanoidRootPart") and _G.OriginalPosition then
              char.HumanoidRootPart.CFrame = _G.OriginalPosition
          end
      end
   end,
})

-- Vòng lặp chính: Tự cầm kiếm + Bay lên cao + Chém ảo
task.spawn(function()
    while true do
        if _G.AuraKill then
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart") then
                
                -- Khóa vị trí an toàn trên cao
                char.HumanoidRootPart.CFrame = CFrame.new(0, 3000, 0)
                
                -- TỰ ĐỘNG CẦM KIẾM (Auto Equip)
                local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                
                if tool then
                    if tool.Parent ~= char then
                        tool.Parent = char -- Lôi kiếm từ túi ra tay
                    end
                    
                    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part")
                    if handle then
                        for _, v in pairs(game.Players:GetPlayers()) do
                            if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                
                                -- Kiểm tra Né người chơi (Whitelist)
                                local isIgnored = false
                                if _G.WhitelistName ~= "" then
                                    if string.find(string.lower(v.Name), string.lower(_G.WhitelistName)) or string.find(string.lower(v.DisplayName), string.lower(_G.WhitelistName)) then
                                        isIgnored = true
                                    end
                                end
                                
                                if not isIgnored then
                                    local eRoot = v.Character:FindFirstChild("HumanoidRootPart")
                                    if eRoot then
                                        -- Chém ảo liên tục toàn map
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
        task.wait(0.1) -- Tốc độ quét 10 lần/giây
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
   Name = "Nội dung Spam Chat",
   PlaceholderText = "Gõ gì đó để khịa...",
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
