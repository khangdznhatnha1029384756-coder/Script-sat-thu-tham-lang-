--[[
    Hffiuff Hub 🗿🇻🇳 - V7 REMAKE
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Update: Fix Target Kill Logic, Safe Teleport, Removed Floating Button
]]

-- 1. ANTI-BAN
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FireServer" and (tostring(self):find("Ban") or tostring(self):find("Check")) then return nil end
    return OldNamecall(self, ...)
end)
setreadonly(MT, true)

-- 2. TẢI THƯ VIỆN RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 3. KHỞI TẠO CỬA SỔ
local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V7 - Target Kill Remake",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

Rayfield:Notify({
   Title = "Hffiuff Hub 🗿🇻🇳",
   Content = "Đã làm lại Target Kill & Sửa lỗi kẹt Map!",
   Duration = 5,
   Image = 4483345998,
})

-- --- TAB CHIẾN ĐẤU (COMBAT) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Hitbox",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  local root = v.Character.HumanoidRootPart
                  root.Size = Vector3.new(_G.HSize or 10, _G.HSize or 10, _G.HSize or 10)
                  root.Transparency = 0.6
                  root.CanCollide = false
                  root.Massless = true -- Giúp server không bị lỗi vật lý khi hitbox to
               end
            end
            task.wait(0.5)
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Kích thước Hitbox",
   Range = {2, 50},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 10,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB AUTO KILL (LÀM LẠI LOGIC) ---
local AutoTab = Window:CreateTab("Auto Kill", 4483345998)

AutoTab:CreateToggle({
   Name = "Target Kill (Giết Xong Mới Bay)",
   CurrentValue = false,
   Callback = function(Value)
      _G.TargetKill = Value
      task.spawn(function()
         while _G.TargetKill do
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if not _G.TargetKill then break end -- Dừng ngay nếu tắt toggle
                    
                    -- Kiểm tra xem địch có tồn tại và còn sống không
                    if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") then
                        local enemyHum = v.Character.Humanoid
                        local enemyRoot = v.Character.HumanoidRootPart
                        
                        if enemyHum.Health > 0 then
                            -- KHÓA MỤC TIÊU: Chém đến khi máu địch = 0
                            while _G.TargetKill and enemyHum.Health > 0 and v.Character and char:FindFirstChild("HumanoidRootPart") do
                                
                                -- 1. Dịch chuyển an toàn (Gần hơn và cao hơn một chút để không kẹt tường)
                                char.HumanoidRootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, 1.5, 1.5)
                                
                                -- 2. Tự động lấy vũ khí ra nếu chưa cầm
                                local tool = char:FindFirstChildOfClass("Tool")
                                if not tool then
                                    tool = lp.Backpack:FindFirstChildOfClass("Tool")
                                    if tool then tool.Parent = char end
                                end
                                
                                -- 3. Chém liên tục
                                if tool then
                                    tool:Activate()
                                end
                                
                                task.wait(0.1) -- Tốc độ chém liên tục
                            end
                        end
                    end
                end
            end
            task.wait(0.5) -- Đợi một chút trước khi quét vòng lặp mới
         end
      end)
   end,
})

-- --- TAB CỬA HÀNG (SHOP) ---
local ShopTab = Window:CreateTab("Shop & Random", 4483345998)

ShopTab:CreateDropdown({
   Name = "Chọn loại hộp",
   Options = {"Skin Crate","Rare Crate","Legendary Crate"},
   CurrentOption = {"Skin Crate"},
   MultipleOptions = false,
   Callback = function(Option) _G.SelectedCrate = Option[1] end,
})

ShopTab:CreateToggle({
   Name = "Auto Spam Mở Hộp",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoOpen = Value
      task.spawn(function()
         while _G.AutoOpen do
            local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Shop")
            if Remote then Remote.OpenCrate:InvokeServer(_G.SelectedCrate or "Skin Crate") end
            task.wait(1)
         end
      end)
   end,
})

-- --- TAB VISUAL ---
local VisualTab = Window:CreateTab("Visual", 4483345998)

VisualTab:CreateToggle({
   Name = "ESP (Nhìn xuyên tường)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      while _G.ESP do
         for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("Hffiuff_ESP") then
               local High = Instance.new("Highlight", v.Character)
               High.Name = "Hffiuff_ESP"
               High.FillColor = Color3.fromRGB(255, 0, 0)
            end
         end
         task.wait(2)
      end
   end,
})
