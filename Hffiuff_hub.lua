--[[
    Hffiuff Hub 🗿🇻🇳 - V17 GHOST ASSASSIN
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Update: True Invisibility, Global Hitbox, Smart Auto Roll/Open, Chat "Hack lỏ"
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V17 - Khắc Chế Hacker",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
local function GetCharacter() return lp.Character or lp.CharacterAdded:Wait() end

-- --- TAB CHIẾN ĐẤU (HITBOX TOÀN MAP) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Hitbox Toàn Map (Bao trùm Server)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  local root = v.Character.HumanoidRootPart
                  -- Tăng Size lên mức khổng lồ (2048 là giới hạn tối đa của Roblox)
                  root.Size = Vector3.new(2048, 2048, 2048)
                  root.Transparency = 0.95 -- Gần như trong suốt để không mù mắt bạn
                  root.CanCollide = false
                  root.CanTouch = true
                  root.Massless = true
               end
            end
            task.wait(1)
         end
         -- Tắt đi thì thu nhỏ lại
         for _, v in pairs(game.Players:GetPlayers()) do
             if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                 v.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
             end
         end
      end)
   end,
})

-- --- TAB KHẮC CHẾ (TÀNG HÌNH & DIỆT HACK) ---
local KillTab = Window:CreateTab("Anti-Hack VIP", 4483345998)

KillTab:CreateToggle({
   Name = "Tàng Hình & God Kill (Khắc Chế VIP)",
   CurrentValue = false,
   Callback = function(Value)
      _G.GodKill = Value
      local char = GetCharacter()
      
      if Value then
          -- BƯỚC 1: Xóa hình ảnh của bạn (Tàng hình)
          for _, part in pairs(char:GetDescendants()) do
              if part:IsA("BasePart") or part:IsA("Decal") then
                  part.Transparency = 1
              end
          end
          if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then
              char.Head.face:Destroy()
          end

          -- BƯỚC 2: Bay lên đỉnh trời (100,000 mét) để né mọi loại hitbox của hack khác
          char.HumanoidRootPart.CFrame = CFrame.new(0, 100000, 0)
      end

      task.spawn(function()
         while _G.GodKill do
            local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
            if tool then
                tool.Parent = char
                for _, v in pairs(game.Players:GetPlayers()) do
                    if not _G.GodKill then break end
                    if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                        local eRoot = v.Character:FindFirstChild("HumanoidRootPart")
                        if eRoot then
                            tool:Activate()
                            -- Phóng sét từ trên cao xuống
                            if tool:FindFirstChild("Handle") then
                                firetouchinterest(eRoot, tool.Handle, 0)
                                firetouchinterest(eRoot, tool.Handle, 1)
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
         end
      end)
   end,
})

KillTab:CreateLabel("----------------------------------------")
KillTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB SHOP (THUẬT TOÁN AUTO RANDOM THÔNG MINH) ---
local ShopTab = Window:CreateTab("Shop (Smart Auto)", 4483345998)

ShopTab:CreateToggle({
   Name = "Auto Random/Mở Hộp (Quét Toàn Game)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoRoll = Value
      task.spawn(function()
         while _G.AutoRoll do
            pcall(function()
                -- Hệ thống tự động tìm và bấm các nút liên quan đến mở/random trong game
                local keywords = {"roll", "spin", "open", "crate", "box", "random", "buy", "sword"}
                
                for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                        local name = string.lower(obj.Name)
                        for _, word in pairs(keywords) do
                            if string.find(name, word) then
                                if obj:IsA("RemoteEvent") then
                                    obj:FireServer()
                                    obj:FireServer("1") -- Một số game cần ID
                                    obj:FireServer("Skin Crate")
                                elseif obj:IsA("RemoteFunction") then
                                    obj:InvokeServer()
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(1.5) -- Đợi 1.5s để tránh bị kick do spam server
         end
      end)
   end,
})

ShopTab:CreateLabel("----------------------------------------")
ShopTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

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
                local msg = "mấy bé hack lỏ quá, dùng Hffiuff Hub như anh đi 🗿🇻🇳"
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
