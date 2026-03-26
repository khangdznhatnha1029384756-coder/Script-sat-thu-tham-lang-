--[[
    Hffiuff Hub 🗿🇻🇳 - V11 STABLE FIX
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Fix: Error 176, Memory Optimization, Stable Loops
]]

-- 1. KIỂM TRA MÔI TRƯỜNG AN TOÀN
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not Rayfield then
    warn("Hffiuff Hub: Khong the tai thu vien Rayfield!")
    return
end

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V12 - Stable Edition",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

-- HÀM LẤY NHÂN VẬT AN TOÀN
local function GetCharacter()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

-- --- TAB CHIẾN ĐẤU (HITBOX 100) ---
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
               end
            end
            task.wait(1.5) -- Tăng thời gian chờ để tránh lỗi 176
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Kích thước Hitbox",
   Range = {2, 100}, -- Max 100 theo yêu cầu
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 15,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB AUTO KILL (QUÉT TOÀN MAP) ---
local AutoTab = Window:CreateTab("Auto Kill", 4483345998)

AutoTab:CreateToggle({
   Name = "Kill Toàn Map (Quét Server)",
   CurrentValue = false,
   Callback = function(Value)
      _G.MassKill = Value
      task.spawn(function()
         while _G.MassKill do
            local lp = game.Players.LocalPlayer
            local char = GetCharacter()
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if not _G.MassKill then break end
                    if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                        char.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                        local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                        if tool then
                            if tool.Parent ~= char then tool.Parent = char end
                            tool:Activate()
                        end
                        task.wait(0.1) -- Đã chỉnh lên 0.1s để không bị văng game
                    end
                end
            end
            task.wait(0.2)
         end
      end)
   end,
})

-- --- TAB SHOP (AUTO MỞ HỘP) ---
local ShopTab = Window:CreateTab("Shop", 4483345998)

ShopTab:CreateToggle({
   Name = "Auto Spam Mở Hộp",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoOpen = Value
      task.spawn(function()
         while _G.AutoOpen do
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                if rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("Shop") then
                    rs.Remotes.Shop.OpenCrate:InvokeServer("Skin Crate")
                end
            end)
            task.wait(1.2)
         end
      end)
   end,
})

ShopTab:CreateLabel("----------------------------------------")
ShopTab:CreateLabel("by developer Hffiuff 🗿🇻🇳") -- Branding

-- --- TAB MISC (SPAM EZ) ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateToggle({
   Name = "Auto Spam Chat (ez)",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpamChat = Value
      task.spawn(function()
         while _G.SpamChat do
            pcall(function()
                if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("ez")
                else
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ez", "All")
                end
            end)
            task.wait(3)
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿🇻🇳") -- Branding
