--[[
    Hffiuff Hub 🗿🇻🇳 - V9 ULTIMATE ASSASSIN
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Fix: Real Hitbox, Auto-Reconnect Target, Match Persistence
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V9 - Đánh Xuyên Trận",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

-- --- HÀM TỰ ĐỘNG CẬP NHẬT KHI HỒI SINH (Xuyên Trận) ---
local function GetCharacter()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

-- --- TAB CHIẾN ĐẤU (REAL HITBOX) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Hitbox (Real Hit)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  local root = v.Character.HumanoidRootPart
                  root.Size = Vector3.new(_G.HSize or 15, _G.HSize or 15, _G.HSize or 15)
                  root.Transparency = 0.7
                  root.CanCollide = false
                  root.CanTouch = true -- ÉP SERVER NHẬN VA CHẠM
               end
            end
            task.wait(1)
         end
         -- Dọn dẹp khi tắt
         for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
                v.Character.HumanoidRootPart.Transparency = 1
            end
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Kích thước Hitbox",
   Range = {2, 50},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 15,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB AUTO KILL (AUTO RE-TARGET XUYÊN TRẬN) ---
local AutoTab = Window:CreateTab("Auto Kill", 4483345998)

local function StartKillLoop()
    task.spawn(function()
        while _G.TargetKill do
            local lp = game.Players.LocalPlayer
            local char = GetCharacter()
            local root = char:WaitForChild("HumanoidRootPart", 5)
            
            if root then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if not _G.TargetKill then break end
                    
                    if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") then
                        local eHum = v.Character.Humanoid
                        local eRoot = v.Character.HumanoidRootPart
                        
                        if eHum.Health > 0 then
                            -- KHÓA CHẾT MỤC TIÊU
                            while _G.TargetKill and eHum.Health > 0 and v.Character and char:FindFirstChild("HumanoidRootPart") do
                                -- Teleport ra sau lưng và thấp xuống một chút để chém trúng
                                char.HumanoidRootPart.CFrame = eRoot.CFrame * CFrame.new(0, 0, 2.5)
                                
                                local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                                if tool then
                                    if tool.Parent ~= char then tool.Parent = char end
                                    tool:Activate()
                                end
                                task.wait(0.05)
                            end
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

AutoTab:CreateToggle({
   Name = "Target Kill (Đánh Xuyên Trận)",
   CurrentValue = false,
   Callback = function(Value)
      _G.TargetKill = Value
      if Value then
          StartKillLoop()
      end
   end,
})

-- --- TỰ ĐỘNG KÍCH HOẠT LẠI KHI SANG TRẬN MỚI ---
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if _G.TargetKill then
        task.wait(2) -- Đợi load map
        StartKillLoop()
    end
end)

-- --- TAB VISUAL (NAME TAG) ---
local VisualTab = Window:CreateTab("Visual", 4483345998)

VisualTab:CreateToggle({
   Name = "ESP Name (Tên đỏ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      task.spawn(function()
          while _G.ESP do
              for _, v in pairs(game.Players:GetPlayers()) do
                  if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
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
