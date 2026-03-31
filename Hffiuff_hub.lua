 --[[
    Hffiuff Hub 🗿🇻🇳
    Owner: khangdz
    Notes: Bản hoàn chỉnh
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "Bản hoàn chỉnh",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
_G.WhitelistName = ""
_G.OriginalPosition = nil
_G.CustomSpamText = "Hffiuff Hub 🗿🇻🇳 cực cháy!"

-- --- TẠO BỆ ĐỨNG GIỮA TRỜI ---
local function CreatePlatform()
    local plat = workspace:FindFirstChild("HffiuffPlatform")
    if not plat then
        plat = Instance.new("Part")
        plat.Name = "HffiuffPlatform"
        plat.Size = Vector3.new(100, 2, 100)
        -- Tọa độ giữa map, độ cao 3000 để tránh bo và sát thương
        plat.Position = Vector3.new(0, 2995, 0)
        plat.Anchored = true
        plat.Transparency = 1
        plat.Parent = workspace
    end
end

-- --- TAB CHIẾN ĐẤU ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Hitbox (Bao trùm Map)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  local root = v.Character.HumanoidRootPart
                  root.Size = Vector3.new(_G.HSize or 50, _G.HSize or 50, _G.HSize or 50)
                  root.Transparency = 0.8
                  root.CanTouch = true
               end
            end
            task.wait(0.5)
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Kích thước Hitbox",
   Range = {2, 2048},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 50,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB AUTO FARM ---
local KillTab = Window:CreateTab("Auto Farm", 4483345998)

KillTab:CreateInput({
   Name = "Né người chơi (Whitelist)",
   PlaceholderText = "Nhập tên người cần né...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.WhitelistName = Text
   end,
})

KillTab:CreateToggle({
   Name = "Auto Farm Toàn Map",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      local char = lp.Character
      
      if Value then
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Auto Farm đã bật!", Duration = 2})
          CreatePlatform()
          
          if char and char:FindFirstChild("HumanoidRootPart") then
              _G.OriginalPosition = char.HumanoidRootPart.CFrame
          end
      else
          Rayfield:Notify({Title = "Hffiuff Hub 🗿🇻🇳", Content = "Auto Farm đã tắt!", Duration = 2})
          
          if char and char:FindFirstChild("HumanoidRootPart") and _G.OriginalPosition then
              char.HumanoidRootPart.CFrame = _G.OriginalPosition
          end
      end
   end,
})

task.spawn(function()
    while true do
        if _G.AutoFarm then
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart") then
                
                -- Khóa chặt vị trí an toàn giữa map trên không trung
                char.HumanoidRootPart.CFrame = CFrame.new(0, 3000, 0)
                
                local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    tool.Parent = char
                    tool:Activate()
                    
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                            
                            local isIgnored = false
                            if _G.WhitelistName ~= "" then
                                if string.find(string.lower(v.Name), string.lower(_G.WhitelistName)) or string.find(string.lower(v.DisplayName), string.lower(_G.WhitelistName)) then
                                    isIgnored = true
                                end
                            end
                            
                            if not isIgnored then
                                local eRoot = v.Character:FindFirstChild("HumanoidRootPart")
                                if eRoot and tool:FindFirstChild("Handle") then
                                    firetouchinterest(eRoot, tool.Handle, 0)
                                    firetouchinterest(eRoot, tool.Handle, 1)
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

KillTab:CreateLabel("----------------------------------------")
KillTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB VISUAL ---
local VisualTab = Window:CreateTab("Visual", 4483345998)

VisualTab:CreateToggle({
   Name = "ESP Name (Tên đỏ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      task.spawn(function()
          while _G.ESP do
              for _, v in pairs(game.Players:GetPlayers()) do
                  if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                      if not v.Character.Head:FindFirstChild("Hffiuff_ESP") then
                          local b = Instance.new("BillboardGui", v.Character.Head)
                          b.Name = "Hffiuff_ESP"
                          b.AlwaysOnTop = true
                          b.Size = UDim2.new(0,100,0,30)
                          local t = Instance.new("TextLabel", b)
                          t.Text = v.Name
                          t.TextColor3 = Color3.fromRGB(255,0,0)
                          t.BackgroundTransparency = 1
                          t.Size = UDim2.new(1,0,1,0)
                      end
                  end
              end
              task.wait(2)
          end
      end)
   end,
})

VisualTab:CreateLabel("----------------------------------------")
VisualTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB MISC ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateInput({
   Name = "Nội dung Spam Chat",
   PlaceholderText = "Nhập tin nhắn bạn muốn spam...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.CustomSpamText = Text
   end,
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
