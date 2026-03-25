--[[
    Hffiuff Hub 🗿🇻🇳 - V5 OPTIMIZED
    Owner: khangdz by Hffiuff 🗿🇻🇳
    Update: Anti-Ban Max, Fast Target, Floating Toggle Button
]]

-- 1. NÂNG CẤP ANTI-BAN & CHỐNG KICK
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
local OldIndex = MT.__index
setreadonly(MT, false)

MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FireServer" and (tostring(self):find("Ban") or tostring(self):find("Check") or tostring(self):find("Cheat")) then 
        return nil 
    end
    return OldNamecall(self, ...)
end)

MT.__index = newcclosure(function(t, k)
    if not checkcaller() and (k == "WalkSpeed" or k == "JumpPower" or k == "HipHeight") then
        return OldIndex(t, k)
    end
    return OldIndex(t, k)
end)
setreadonly(MT, true)

-- 2. TẢI THƯ VIỆN ORION
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexsoftware/Orion/main/source')))()

-- 3. HIỆN THÔNG BÁO THƯƠNG HIỆU
OrionLib:MakeNotification({
	Name = "Hffiuff Hub 🗿🇻🇳",
	Content = "khangdz by Hffiuff 🗿🇻🇳",
	Image = "rbxassetid://4483345998",
	Time = 5
})

-- 4. TẠO CỬA SỔ CHÍNH
local Window = OrionLib:MakeWindow({Name = "Hffiuff Hub 🗿🇻🇳", HidePremium = false, SaveConfig = true, ConfigFolder = "HffiuffV5"})

-- --- TAB CHIẾN ĐẤU (COMBAT) ---
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
	Name = "Kích thước Hitbox (2 - 50)",
	Min = 2, Max = 50, Default = 10,
	Color = Color3.fromRGB(0, 255, 255),
	Callback = function(Value) _G.HSize = Value end    
})

-- --- TAB SHOP (AUTO MỞ HỘP) ---
local ShopTab = Window:MakeTab({Name = "Auto Random", Icon = "rbxassetid://4483345998"})

ShopTab:AddDropdown({
	Name = "Chọn loại hộp",
	Default = "Skin Crate",
	Options = {"Skin Crate", "Rare Crate", "Legendary Crate"},
	Callback = function(Value) _G.SelectedCrate = Value end    
})

ShopTab:AddToggle({
	Name = "Auto Spam Mở Hộp",
	Default = false,
	Callback = function(Value)
		_G.AutoOpen = Value
		task.spawn(function()
			while _G.AutoOpen do
				local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Shop")
				if Remote then
					Remote.OpenCrate:InvokeServer(_G.SelectedCrate or "Skin Crate")
				end
				task.wait(1)
			end
		end)
	end    
})

-- --- TAB AUTO KILL (TARGET SIÊU TỐC) ---
local AutoTab = Window:MakeTab({Name = "Fast Target Kill", Icon = "rbxassetid://4483345998"})

AutoTab:AddToggle({
	Name = "Kill Từng Người (X3 Tốc độ)",
	Default = false,
	Callback = function(Value)
		_G.TargetKill = Value
		task.spawn(function()
			while _G.TargetKill do
				for _, v in pairs(game.Players:GetPlayers()) do
					if _G.TargetKill and v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
						-- Di chuyển cực nhanh sau lưng
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
						
						-- Tự vung kiếm
						local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
						if tool then tool:Activate() end
						
						task.wait(0.3) -- Tốc độ giết siêu nhanh (0.3 giây)
					end
				end
				task.wait(0.5)
			end
		end)
	end    
})

-- --- TAB HỆ THỐNG (SETTINGS) ---
local SettingsTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"})

SettingsTab:AddKeybind({
	Name = "Phím tắt ẩn/hiện",
	Default = Enum.KeyCode.RightControl,
	Callback = function() OrionLib:Toggle() end    
})

SettingsTab:AddButton({
	Name = "Tắt hoàn toàn Script",
	Callback = function() OrionLib:Destroy() end
})

-- 5. NÚT NỔI ẨN/HIỆN (DÀNH CHO MOBILE & PC)
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "Hffiuff"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 10
ToggleButton.Draggable = true -- Bạn có thể kéo nút này đi bất cứ đâu

ToggleButton.MouseButton1Click:Connect(function()
	OrionLib:Toggle()
end)

OrionLib:Init()
t()

