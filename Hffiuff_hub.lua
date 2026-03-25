--[[
    Hffiuff Hub Premium 🗿🇻🇳
    Developed by: khangdz by Hffiuff 🗿🇻🇳
    Features: Auto Farm, Teleport, ESP, Kill Aura, Hitbox, Silent Aim
]]

-- 1. HỆ THỐNG CHỐNG QUÉT (ANTI-BAN)
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

-- 2. TẢI THƯ VIỆN GIAO DIỆN
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexsoftware/Orion/main/source')))()

-- 3. HIỆN THÔNG BÁO THƯƠNG HIỆU (YÊU CẦU CỦA BẠN)
OrionLib:MakeNotification({
	Name = "Hffiuff Hub 🗿🇻🇳",
	Content = "khangdz by Hffiuff 🗿🇻🇳", -- Dòng chữ xuất hiện đầu tiên
	Image = "rbxassetid://4483345998",
	Time = 6
})

task.wait(2) -- Đợi hiện chữ xong mới hiện bảng chọn

-- 4. KHỞI TẠO BẢN CHỌN (MAIN MENU)
local Window = OrionLib:MakeWindow({Name = "Hffiuff Hub 🗿🇻🇳", HidePremium = false, SaveConfig = true, ConfigFolder = "HffiuffConfig"})

-- TAB CHIẾN ĐẤU (COMBAT)
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})

CombatTab:AddToggle({
	Name = "Silent Aim (Khóa mục tiêu)",
	Default = false,
	Callback = function(Value)
		_G.SilentAim = Value
	end    
})

CombatTab:AddToggle({
	Name = "Kill Aura (Tự đánh vùng quanh)",
	Default = false,
	Callback = function(Value)
		_G.KillAura = Value
		task.spawn(function()
			while _G.KillAura do
				for _, v in pairs(game.Players:GetPlayers()) do
					if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
						if dist < 15 then -- Khoảng cách tự đánh
							-- Code thực hiện đòn đánh tùy theo game tại đây
						end
					end
				end
				task.wait(0.1)
			end
		end)
	end    
})

CombatTab:AddToggle({
	Name = "Auto Random Hitbox",
	Default = false,
	Callback = function(Value)
		_G.HitboxActive = Value
		task.spawn(function()
			while _G.HitboxActive do
				for _, v in pairs(game.Players:GetPlayers()) do
					if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						local size = math.random(10, 20) -- Random kích thước hitbox
						v.Character.HumanoidRootPart.Size = Vector3.new(size, size, size)
						v.Character.HumanoidRootPart.Transparency = 0.7
						v.Character.HumanoidRootPart.CanCollide = false
					end
				end
				task.wait(1)
			end
		end)
	end    
})

-- TAB CÀY & DỊCH CHUYỂN (FARM & TELEPORT)
local FarmTab = Window:MakeTab({Name = "Farm & TP", Icon = "rbxassetid://4483345998"})

FarmTab:AddToggle({
	Name = "Auto Farm",
	Default = false,
	Callback = function(Value)
		_G.AutoFarm = Value
		-- Logic Auto Farm của bạn ở đây
	end    
})

FarmTab:AddButton({
	Name = "Teleport to Map",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 20, 100) -- Tọa độ mẫu
	end
})

-- TAB TẦM NHÌN (VISUAL)
local VisualTab = Window:MakeTab({Name = "Visual", Icon = "rbxassetid://4483345998"})

VisualTab:AddToggle({
	Name = "ESP (Nhìn xuyên tường)",
	Default = false,
	Callback = function(Value)
		_G.ESP = Value
		while _G.ESP do
			for _, v in pairs(game.Players:GetPlayers()) do
				if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("Hffiuff_ESP") then
					local Highlight = Instance.new("Highlight", v.Character)
					Highlight.Name = "Hffiuff_ESP"
					Highlight.FillColor = Color3.fromRGB(255, 0, 0)
				end
			end
			task.wait(1)
		end
	end    
})

OrionLib:Init()

