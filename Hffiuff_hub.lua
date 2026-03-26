--[[
    Hffiuff Hub 🗿🇻🇳 - V16 ANTI-HACKER (INSTANT)
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Update: Instant Kill All, Sky God Mode, No Ghost Hitbox
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V16 - Phản Đòn Siêu Tốc",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local lp = game.Players.LocalPlayer
local function GetCharacter() return lp.Character or lp.CharacterAdded:Wait() end

-- --- TAB CHIẾN ĐẤU (SIÊU HITBOX) ---
local CombatTab = Window:CreateTab("Combat", 4483345998)

CombatTab:CreateToggle({
   Name = "Bật Hitbox (Phạm vi cực đại)",
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
   Range = {2, 100},
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 50,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB DIỆT HACKER (INSTANT KILL) ---
local KillTab = Window:CreateTab("Anti-Hacker", 4483345998)

KillTab:CreateToggle({
   Name = "Instant Kill All (Diệt trong 1 giây)",
   CurrentValue = false,
   Callback = function(Value)
      _G.InstantKill = Value
      if Value then
          -- ĐƯA BẠN LÊN TRỜI ĐỂ NÉ HACK KHÁC
          local char = GetCharacter()
          char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 500, 0)
          
          task.spawn(function()
             while _G.InstantKill do
                local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    tool.Parent = char
                    -- QUÉT TOÀN SERVER TRONG 1 NHỊP
                    for _, v in pairs(game.Players:GetPlayers()) do
                        if v ~= lp and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                            local eRoot = v.Character:FindFirstChild("HumanoidRootPart")
                            if eRoot then
                                -- Chém liên tục bằng firetouchinterest
                                tool:Activate()
                                if tool:FindFirstChild("Handle") then
                                    firetouchinterest(eRoot, tool.Handle, 0)
                                    firetouchinterest(eRoot, tool.Handle, 1)
                                end
                            end
                        end
                    end
                end
                task.wait(0.1) -- Tốc độ cực hạn 0.1s
             end
             -- Khi tắt thì hạ cánh (tùy chọn)
             -- GetCharacter().HumanoidRootPart.CFrame = GetCharacter().HumanoidRootPart.CFrame * CFrame.new(0, -500, 0)
          end)
      end
   end,
})

KillTab:CreateLabel("----------------------------------------")
KillTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")

-- --- TAB MISC ---
local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateButton({
   Name = "Bay lên trời (Tránh hack)",
   Callback = function()
       local char = GetCharacter()
       char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 100, 0)
   end,
})

MiscTab:CreateToggle({
   Name = "Auto Chat ez (Anti-Hacker)",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpamChat = Value
      task.spawn(function()
         while _G.SpamChat do
            pcall(function()
                local msg = "Hffiuff Hub v16: Hack tuổi gì đòi chạm vào anh? 🗿🇻🇳"
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
