--[[
    Hffiuff Hub 🗿🇻🇳 - V5 REPAIRED
    Owner: khangdz by Hffiuff 🗿🇻🇳
]]

-- 1. ANTI-BAN & CHỐNG KICK (Giữ nguyên vì logic này tốt)
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FireServer" and (tostring(self):find("Ban") or tostring(self):find("Check")) then 
        return nil 
    end
    return OldNamecall(self, ...)
end)
setreadonly(MT, true)

-- 2. TẢI THƯ VIỆN ORION (Dùng link dự phòng ổn định hơn)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexsoftware/Orion/main/source')))()

-- 3. TẠO CỬA SỔ CHÍNH
local Window = OrionLib:MakeWindow({
    Name = "Hffiuff Hub 🗿🇻🇳", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "HffiuffV5",
    IntroText = "khangdz by Hffiuff 🗿🇻🇳" -- Hiện chữ ngay khi load
})

-- --- TAB CHIẾN ĐẤU ---
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})

CombatTab:AddToggle({
	Name = "Bật Hitbox (Custom Size)",
	Default = false,
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
	end    
})

CombatTab:AddSlider({
	Name = "Kích thước Hitbox",
	Min = 2, Max = 50, Default = 10,
	Color = Color3.fromRGB(0, 255, 255),
	Callback = function(Value) _G.HSize = Value end    
})

-- --- TAB AUTO KILL ---
local AutoTab = Window:MakeTab({Name = "Fast Target Kill", Icon = "rbxassetid://4483345998"})

AutoTab:AddToggle({
	Name = "Kill Từng Người (0.3s)",
	Default = false,
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
	end    
})

-- --- TAB HỆ THỐNG ---
local SettingsTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"})

SettingsTab:AddButton({
	Name = "Ẩn Menu",
	Callback = function() OrionLib:Toggle() end
})

-- 4. NÚT NỔI (SỬA LỖI HIỂN THỊ)
local function CreateMobileToggle()
    local ScreenGui = Instance.new("ScreenGui")
    local ToggleButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")

    ScreenGui.Name = "HffiuffToggle"
    ScreenGui.Parent = (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ScreenGui
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.Text = "Hffiuff"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 12
    ToggleButton.Draggable = true
    
    UICorner.CornerRadius = UDim.new(0, 30)
    UICorner.Parent = ToggleButton

    ToggleButton.MouseButton1Click:Connect(function()
        OrionLib:Toggle()
    end)
end

CreateMobileToggle()
OrionLib:Init()
