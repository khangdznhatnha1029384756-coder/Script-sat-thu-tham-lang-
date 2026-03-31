 
   --[[
    Hffiuff Hub 🗿🇻🇳
    Owner: khangdz
    Status: Bản hoàn chỉnh - V26 Supreme
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "Bản hoàn chỉnh - V26",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
_G.WhitelistName = ""
_G.OriginalPosition = nil
_G.CustomSpamText = "Hffiuff Hub 🗿🇻🇳 - Sát phạt toàn map!"
_G.HitboxSize = 50 -- Kích thước Hitbox riêng
_G.HitboxActive = false

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

-- --- TAB 1: HITBOX RIÊNG BIỆT ---
local HitboxTab = Window:CreateTab("Hitbox Settings", 4483345998)

HitboxTab:CreateToggle({
   Name = "Bật Hitbox riêng",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  v.Character.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                  v.Character.HumanoidRootPart.Transparency = 0.8
                  v.Character.HumanoidRootPart.CanTouch = true
               end
            end
            task.wait(0.5)
         end
      end)
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

-- --- TAB 2: AUTO KILL (AURA) ---
local KillTab = Window:CreateTab("Auto Farm", 4483345998)

KillTab:CreateToggle({
   Name = "Bật Auto Kill (Vào trận tự chết)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AuraKill = Value
      local char = lp.Character
      
      if Value then
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Auto Kill đã sẵn sàng!", Duration = 3})
          CreatePlatform()
          if char and char:FindFirstChild("HumanoidRootPart") then
              _G.OriginalPosition = char.HumanoidRootPart.CFrame
          end
      else
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Đã dừng sát phạt!", Duration = 2})
          if char and char:FindFirstChild("HumanoidRootPart") and _G.OriginalPosition then
              char.HumanoidRootPart.CFrame = _G.OriginalPosition
          end
      end
   end,
})

-- Vòng lặp Sát phạt tự động (Kết hợp Auto Equip)
task.spawn(function()
    while true do
        if _G.AuraKill then
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart") then
                
                -- Khóa vị trí trên cao 3000m
                char.HumanoidRootPart.CFrame = CFrame.new(0, 3000, 0)
                
                -- Tự động cầm vũ khí
                local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                
                if tool then
                    if tool.Parent ~= char then tool.Parent = char end
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
                                        -- Chém ngầm cực mạnh
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
        task.wait(0.05)
    end
end)

-- --- TAB 3: HỖ TRỢ & WHITELIST ---
local SupportTab = Window:CreateTab("Support", 4483345998)

SupportTab:CreateInput({
   Name = "Né người chơi (Whitelist)",
   PlaceholderText = "Nhập tên người quen...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) _G.WhitelistName = Text end,
})

SupportTab:CreateLabel("----------------------------------------")
SupportTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB 4: MISC (TÙY CHỈNH SPAM) ---
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
            task.wait(3)
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")
