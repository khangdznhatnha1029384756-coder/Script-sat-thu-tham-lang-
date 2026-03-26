--[[
    Hffiuff Hub 🗿🇻🇳 - V13 SUPERIOR
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Fix: Real Hitbox (No Ghost), Instant Kill All, Multi-Game Crate Opener
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V13 - Bản Diệt Server",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
local function GetCharacter() return lp.Character or lp.CharacterAdded:Wait() end

-- --- TAB CHIẾN ĐẤU (FIX HITBOX ẢO) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Hitbox (Fix Ghost Hit)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  local root = v.Character.HumanoidRootPart
                  -- FIX ẢO: Tăng Size vừa phải nhưng ép thuộc tính va chạm thực
                  root.Size = Vector3.new(_G.HSize or 20, _G.HSize or 20, _G.HSize or 20)
                  root.Transparency = 0.8 -- Không nên để quá mờ, server dễ bị lỗi ghost
                  root.CanCollide = false
                  root.CanTouch = true -- QUAN TRỌNG: Cho phép vũ khí chạm vào
                  root.Massless = true
               end
            end
            task.wait(0.5)
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Kích thước Hitbox",
   Range = {2, 100},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 20,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB AUTO KILL (INSTANT KILL ALL) ---
local AutoTab = Window:CreateTab("Auto Kill", 4483345998)

AutoTab:CreateToggle({
   Name = "Kill All (Một phát đi hết)",
   CurrentValue = false,
   Callback = function(Value)
      _G.KillAll = Value
      task.spawn(function()
         while _G.KillAll do
            local char = GetCharacter()
            for _, v in pairs(game.Players:GetPlayers()) do
                if not _G.KillAll then break end
                if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                    local eRoot = v.Character:FindFirstChild("HumanoidRootPart")
                    if eRoot then
                        -- Bay tới sát mục tiêu cực nhanh
                        char.HumanoidRootPart.CFrame = eRoot.CFrame * CFrame.new(0, 0, 1)
                        
                        -- Lấy vũ khí và kích hoạt liên tục
                        local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                        if tool then
                            tool.Parent = char
                            tool:Activate()
                            -- Ép va chạm của Tool vào đối thủ
                            if tool:FindFirstChild("Handle") then
                                firetouchinterest(eRoot, tool.Handle, 0)
                                firetouchinterest(eRoot, tool.Handle, 1)
                            end
                        end
                        task.wait(0.01) -- Tốc độ bàn thờ
                    end
                end
            end
            task.wait(0.1)
         end
      end)
   end,
})

-- --- TAB SHOP (FIX AUTO MỞ HỘP) ---
local ShopTab = Window:CreateTab("Shop", 4483345998)

ShopTab:CreateToggle({
   Name = "Auto Mở Hộp (Đa dụng)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoOpen = Value
      task.spawn(function()
         while _G.AutoOpen do
            pcall(function()
                local rs = game:GetService("ReplicatedStorage")
                -- Thử nhiều đường dẫn Remote khác nhau
                if rs:FindFirstChild("Remotes") then
                    if rs.Remotes:FindFirstChild("Shop") then
                        rs.Remotes.Shop.OpenCrate:InvokeServer("Skin Crate")
                    elseif rs.Remotes:FindFirstChild("OpenCrate") then
                        rs.Remotes.OpenCrate:FireServer("Skin Crate")
                    end
                elseif rs:FindFirstChild("Events") and rs.Events:FindFirstChild("OpenCrate") then
                    rs.Events.OpenCrate:FireServer()
                end
            end)
            task.wait(0.5)
         end
      end)
   end,
})

ShopTab:CreateLabel("----------------------------------------")
ShopTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

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
            task.wait(2)
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")
