--[[
    Hffiuff Hub 🗿🇻🇳 - V6 RAYFIELD EDITION
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Status: Ultra Optimized & Anti-Ban Max
]]

-- 1. HỆ THỐNG BẢO VỆ (ANTI-BAN)
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
   LoadingSubtitle = "Premium Script",
   ConfigurationSaving = {
      Enabled = true,
      Folder = "HffiuffData",
      FileName = "Config"
   },
   KeySystem = false -- Tắt key để bạn dùng cho nhanh
})

-- THÔNG BÁO KHI VÀO GAME
Rayfield:Notify({
   Title = "Hffiuff Hub 🗿🇻🇳",
   Content = "Chào mừng khangdz đã trở lại!",
   Duration = 5,
   Image = 4483345998,
})

-- --- TAB CHIẾN ĐẤU (COMBAT) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)
local CombatSection = CombatTab:CreateSection("Hitbox & Target")

CombatTab:CreateToggle({
   Name = "Bật Hitbox (Custom)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  v.Character.HumanoidRootPart.Size = Vector3.new(_G.HSize or 10, _G.HSize or 10, _G.HSize or 10)
                  v.Character.HumanoidRootPart.Transparency = 0.7
                  v.Character.HumanoidRootPart.CanCollide = false
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
   Suffix = "Size",
   CurrentValue = 10,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB AUTO KILL ---
local AutoTab = Window:CreateTab("Auto Kill", 4483345998)

AutoTab:CreateToggle({
   Name = "Target Kill Siêu Tốc (0.3s)",
   CurrentValue = false,
   Callback = function(Value)
      _G.TargetKill = Value
      task.spawn(function()
         while _G.TargetKill do
            for _, v in pairs(game.Players:GetPlayers()) do
               if _G.TargetKill and v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                  local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                  if tool then tool:Activate() end
                  task.wait(0.3)
               end
            end
            task.wait(0.5)
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

-- --- NÚT NỔI ẨN/HIỆN ---
local function CreateMobileToggle()
    if game.CoreGui:FindFirstChild("HffiuffToggle") then game.CoreGui.HffiuffToggle:Destroy() end
    local ScreenGui = Instance.new("ScreenGui")
    local ToggleButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    ScreenGui.Name = "HffiuffToggle"
    ScreenGui.Parent = game.CoreGui
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ScreenGui
    ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleButton.Position = UDim2.new(0, 15, 0.4, 0)
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Text = "🗿"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 25
    ToggleButton.Draggable = true
    UICorner.CornerRadius = UDim.new(0, 25)
    UICorner.Parent = ToggleButton
    ToggleButton.MouseButton1Click:Connect(function()
        local vim = game:GetService("VirtualInputManager")
        vim:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
    end)
end
CreateMobileToggle()
