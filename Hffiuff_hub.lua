--[[
    Hffiuff Hub 🗿🇻🇳 - V8 TOTAL FIX
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Fix: Hitbox Reset, Target Kill Logic, Backstab Teleport, ESP Nametag
]]

local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FireServer" and (tostring(self):find("Ban") or tostring(self):find("Check")) then return nil end
    return OldNamecall(self, ...)
end)
setreadonly(MT, true)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V8 - The Perfect Assassin",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

Rayfield:Notify({
   Title = "Hffiuff Hub 🗿🇻🇳",
   Content = "Đã fix: Hitbox, Teleport sau lưng, ESP mới!",
   Duration = 5,
   Image = 4483345998,
})

-- --- TAB CHIẾN ĐẤU (HITBOX FIX) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Hitbox",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      
      if _G.HitboxActive then
          task.spawn(function()
             while _G.HitboxActive do
                for _, v in pairs(game.Players:GetPlayers()) do
                   if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                      local root = v.Character.HumanoidRootPart
                      root.Size = Vector3.new(_G.HSize or 10, _G.HSize or 10, _G.HSize or 10)
                      root.Transparency = 0.6
                      root.CanCollide = false
                   end
                end
                task.wait(0.5)
             end
          end)
      else
          -- FIX: Khi tắt, lập tức thu nhỏ Hitbox về bình thường (tàng hình)
          for _, v in pairs(game.Players:GetPlayers()) do
              if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  local root = v.Character.HumanoidRootPart
                  root.Size = Vector3.new(2, 2, 1) -- Kích thước mặc định của Roblox
                  root.Transparency = 1 -- Tàng hình như mặc định
                  root.CanCollide = true
              end
          end
      end
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

-- --- TAB AUTO KILL (TELEPORT SAU LƯNG + TẮT LÀ TẮT) ---
local AutoTab = Window:CreateTab("Auto Kill", 4483345998)

AutoTab:CreateToggle({
   Name = "Target Kill (Backstab - Áp sát lưng)",
   CurrentValue = false,
   Callback = function(Value)
      _G.TargetKill = Value
      task.spawn(function()
         while _G.TargetKill do
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if not _G.TargetKill then break end -- TẮT LÀ DỪNG NGAY LẬP TỨC
                    
                    if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") then
                        local enemyHum = v.Character.Humanoid
                        local enemyRoot = v.Character.HumanoidRootPart
                        
                        if enemyHum.Health > 0 then
                            -- KHÓA MỤC TIÊU TỚI CHẾT
                            while _G.TargetKill and enemyHum.Health > 0 and v.Character and char:FindFirstChild("HumanoidRootPart") do
                                
                                -- FIX: Teleport chính xác ra sau lưng địch (trục Z) và quay mặt vào địch
                                local behindPosition = (enemyRoot.CFrame * CFrame.new(0, 0, 3)).Position
                                char.HumanoidRootPart.CFrame = CFrame.new(behindPosition, enemyRoot.Position)
                                
                                -- Lấy vũ khí ra
                                local tool = char:FindFirstChildOfClass("Tool")
                                if not tool then
                                    tool = lp.Backpack:FindFirstChildOfClass("Tool")
                                    if tool then tool.Parent = char end
                                end
                                
                                -- Chém
                                if tool then tool:Activate() end
                                
                                task.wait(0.05) -- Chém cực nhanh
                            end
                        end
                    end
                end
            end
            task.wait(0.5)
         end
      end)
   end,
})

-- --- TAB SHOP (AUTO MỞ HỘP) ---
local ShopTab = Window:CreateTab("Shop", 4483345998)

ShopTab:CreateToggle({
   Name = "Auto Mở Hộp (Spam)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoOpen = Value
      task.spawn(function()
         while _G.AutoOpen do
            -- Dùng pcall để script không bị lỗi nếu game không có remote "OpenCrate"
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                if rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("Shop") then
                    rs.Remotes.Shop.OpenCrate:InvokeServer("Skin Crate")
                end
            end)
            task.wait(1)
         end
      end)
   end,
})

-- --- TAB VISUAL (ESP MỚI - 100% NHÌN THẤY) ---
local VisualTab = Window:CreateTab("Visual", 4483345998)

VisualTab:CreateToggle({
   Name = "ESP Name (Tên đỏ nổi trên đầu)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      task.spawn(function()
          while true do
              task.wait(1)
              for _, v in pairs(game.Players:GetPlayers()) do
                  if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                      local head = v.Character.Head
                      if _G.ESP then
                          if not head:FindFirstChild("Hffiuff_ESP") then
                              -- Tạo chữ nổi trên đầu
                              local bgui = Instance.new("BillboardGui", head)
                              bgui.Name = "Hffiuff_ESP"
                              bgui.Size = UDim2.new(0, 200, 0, 50)
                              bgui.ExtentsOffset = Vector3.new(0, 2.5, 0)
                              bgui.AlwaysOnTop = true
                              
                              local text = Instance.new("TextLabel", bgui)
                              text.Size = UDim2.new(1, 0, 1, 0)
                              text.BackgroundTransparency = 1
                              text.Text = "💀 " .. v.Name
                              text.TextColor3 = Color3.fromRGB(255, 50, 50)
                              text.TextScaled = true
                              text.Font = Enum.Font.GothamBold
                          end
                      else
                          -- Xóa ESP khi tắt
                          if head:FindFirstChild("Hffiuff_ESP") then
                              head.Hffiuff_ESP:Destroy()
                          end
                      end
                  end
              end
              -- Dừng vòng lặp nến tắt hoàn toàn ESP (tối ưu hóa)
              if not _G.ESP then
                  for _, v in pairs(game.Players:GetPlayers()) do
                      if v.Character and v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("Hffiuff_ESP") then
                          v.Character.Head.Hffiuff_ESP:Destroy()
                      end
                  end
                  break
              end
          end
      end)
   end,
})
