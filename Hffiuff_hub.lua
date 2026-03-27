--[[
    Hffiuff Hub 🗿🇻🇳 - V18 GOD OF WAR
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Update: Center Map Sky God, Auto Round Detect, Whitelist (Né người), Removed Shop
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V18 - Thần Chiến Tranh",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
_G.WhitelistName = "" -- Biến lưu tên người cần né

-- --- TẠO BỆ ĐỨNG TÀNG HÌNH GIỮA TRỜI ---
local function CreatePlatform()
    local plat = workspace:FindFirstChild("HffiuffPlatform")
    if not plat then
        plat = Instance.new("Part")
        plat.Name = "HffiuffPlatform"
        plat.Size = Vector3.new(50, 2, 50)
        plat.Position = Vector3.new(0, 99995, 0) -- Nằm ngay dưới tọa độ 100,000
        plat.Anchored = true
        plat.Transparency = 1 -- Tàng hình
        plat.Parent = workspace
    end
end

-- --- TAB CHIẾN ĐẤU (HITBOX TÙY CHỈNH NGON) ---
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
   Range = {2, 2048}, -- Max ping theo ý bạn
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 50,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB KILL ALL (XUYÊN TRẬN + NÉ ĐỒNG ĐỘI) ---
local KillTab = Window:CreateTab("God Kill All", 4483345998)

KillTab:CreateInput({
   Name = "Tên người cần né (Whitelist)",
   PlaceholderText = "Nhập tên Roblox của nó vào đây...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.WhitelistName = Text
   end,
})

KillTab:CreateToggle({
   Name = "Auto Kill Toàn Map (Xuyên Trận)",
   CurrentValue = false,
   Callback = function(Value)
      _G.GodKill = Value
      
      if Value then CreatePlatform() end
      
      task.spawn(function()
         while _G.GodKill do
            local char = lp.Character
            -- NẾU ĐANG TRONG TRẬN VÀ CÒN SỐNG
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart") then
                
                -- Luôn bay về bệ tàng hình ở GIỮA MAP và CAO NHẤT (0, 100000, 0)
                char.HumanoidRootPart.CFrame = CFrame.new(0, 100000, 0)
                
                local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    tool.Parent = char
                    tool:Activate()
                    
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                            
                            -- KIỂM TRA WHITELIST (NÉ NGƯỜI CHƠI)
                            local isIgnored = false
                            if _G.WhitelistName ~= "" then
                                -- Kiểm tra xem tên bạn nhập có khớp với tên thật hoặc tên hiển thị của nó không
                                if string.find(string.lower(v.Name), string.lower(_G.WhitelistName)) or string.find(string.lower(v.DisplayName), string.lower(_G.WhitelistName)) then
                                    isIgnored = true
                                end
                            end
                            
                            -- NẾU KHÔNG PHẢI LÀ NGƯỜI BỊ NÉ THÌ CHÉM
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
            task.wait(0.1) -- Tốc độ cực hạn, quét 10 lần mỗi giây
         end
      end)
   end,
})

KillTab:CreateLabel("----------------------------------------")
KillTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB VISUAL (ESP) ---
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

-- --- TAB MISC (SPAM KHỊA) ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateToggle({
   Name = "Auto Spam Chat (Hack lỏ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpamChat = Value
      task.spawn(function()
         while _G.SpamChat do
            pcall(function()
                local msg = "Mấy bé hack lỏ quá, dùng Hffiuff Hub 🗿🇻🇳"
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
