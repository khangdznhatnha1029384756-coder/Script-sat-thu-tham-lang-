--[[
    Hffiuff Hub 🗿🇻🇳 - V11 SUPREME + COPYRIGHT
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Update: Auto Open Crate, Label Bản quyền, Hitbox 100, Kill All Map
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "V11 - Kẻ Hủy Diệt Server",
   ConfigurationSaving = { Enabled = true, Folder = "HffiuffData", FileName = "Config" },
   KeySystem = false
})

local function GetCharacter()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

-- --- TAB CHIẾN ĐẤU (HITBOX MAX 100) ---
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
                  root.CanTouch = true
               end
            end
            task.wait(1)
         end
         -- Thu nhỏ lại khi tắt
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
   Range = {2, 100}, 
   Increment = 1,
   Suffix = " Size",
   CurrentValue = 15,
   Callback = function(Value) _G.HSize = Value end,
})

-- --- TAB AUTO KILL ---
local AutoTab = Window:CreateTab("Auto Kill", 4483345998)

local function StartTargetKill()
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
                            while _G.TargetKill and eHum.Health > 0 and v.Character and char:FindFirstChild("HumanoidRootPart") do
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
   Name = "Target Kill (Khóa mục tiêu)",
   CurrentValue = false,
   Callback = function(Value
                
