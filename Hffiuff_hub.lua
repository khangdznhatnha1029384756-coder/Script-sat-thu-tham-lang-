--[[
    Hffiuff Hub 🗿🇻🇳 - V15 ULTRA INSTINCT
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Fix: Ghost Hitbox (Hitbox ảo), Speed 0.1s, Multi-Part Expansion
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V15 - Ultra Instinct",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
local function GetCharacter() return lp.Character or lp.CharacterAdded:Wait() end

-- --- TAB CHIẾN ĐẤU (FIX HITBOX ẢO TRIỆT ĐỂ) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Hitbox (Real Hit - No Ghost)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= lp and v.Character then
                  -- Phóng to mọi bộ phận để không bao giờ bị "ảo"
                  for _, part in pairs(v.Character:GetChildren()) do
                      if part:IsA("BasePart") then
                          part.Size = Vector3.new(_G.HSize or 30, _G.HSize or 30, _G.HSize or 30)
                          part.Transparency = 0.8
                          part.CanCollide = false
                          part.CanTouch = true -- Ép va chạm
                          part.Massless = true
                      end
                  end
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
   CurrentValue = 30,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB DIỆT SERVER (TỐC ĐỘ 0.1S) ---
local KillTab = Window:CreateTab("God Kill", 4483345998)

KillTab:CreateToggle({
   Name = "God Kill All (0.1s Speed)",
   CurrentValue = false,
   Callback = function(Value)
      _G.GodKill = Value
      task.spawn(function()
         while _G.GodKill do
            local char = GetCharacter()
            local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
            
            if tool then
                tool.Parent = char
                for _, v in pairs(game.Players:GetPlayers()) do
                    if not _G.GodKill then break end
                    if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                        local eRoot = v.Character:FindFirstChild("HumanoidRootPart")
                        if eRoot then
                            -- Teleport lên trên đầu để tránh bị hack khác chém trúng
                            char.HumanoidRootPart.CFrame = eRoot.CFrame * CFrame.new(0, 7, 0)
                            
                            tool:Activate()
                            -- Ép va chạm cực mạnh bằng firetouchinterest
                            if tool:FindFirstChild("Handle") then
                                firetouchinterest(eRoot, tool.Handle, 0)
                                firetouchinterest(eRoot, tool.Handle, 1)
                            end
                        end
                    end
                end
            end
            task.wait(0.1) -- TỐC ĐỘ 0.1S THEO YÊU CẦU
         end
      end)
   end,
})

KillTab:CreateLabel("----------------------------------------")
KillTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB MISC ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateToggle({
   Name = "Auto Spam Chat (ez)",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpamChat = Value
      task.spawn(function()
         while _G.SpamChat do
            pcall(function()
                local msg = "ez hack tuổi gì? Hffiuff Hub cân tất! 🗿🇻🇳"
                if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
                else
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
                end
            end)
            task.wait(2.5)
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")
