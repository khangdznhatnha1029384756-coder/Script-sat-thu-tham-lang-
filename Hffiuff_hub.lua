local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local RunService = game:GetService("RunService")
local lp = game.Players.LocalPlayer

local Window = Rayfield:CreateWindow({
   Name = "Hffiuff Hub 🗿🇻🇳",
   LoadingTitle = "khangdz by Hffiuff 🗿🇻🇳",
   LoadingSubtitle = "Bản Hoàn Chỉnh",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

_G.AutoFarm = false
_G.HitboxSize = 50
_G.HitboxColor = Color3.fromRGB(255, 0, 0)
_G.ShowHitbox = false
_G.ESP = false
_G.SpamChat = false
_G.SpamText = "Hffiuff Hub 🗿🇻🇳"
_G.Whitelist = ""

local FarmTab = Window:CreateTab("Attack & Farm", 4483345998)

FarmTab:CreateToggle({
   Name = "Bật Auto Farm (Spam Đánh Ảo)",
   CurrentValue = false,
   Callback = function(v) _G.AutoFarm = v end,
})

FarmTab:CreateInput({
   Name = "Nhập Kích Thước Hitbox",
   PlaceholderText = "Điền số hitbox phù hợp (vd: 50, 2048)",
   RemoveTextAfterFocusLost = false,
   Callback = function(t) _G.HitboxSize = tonumber(t) or 50 end,
})

RunService.Heartbeat:Connect(function()
    if _G.AutoFarm then
        pcall(function()
            local tool = lp.Character:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
            if tool then
                tool.Parent = lp.Character
                local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part") or tool:FindFirstChildOfClass("MeshPart")
                if handle then
                    for _, v in ipairs(game.Players:GetPlayers()) do
                        if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                            if _G.Whitelist == "" or not string.find(string.lower(v.Name), string.lower(_G.Whitelist)) then
                                local hrp = v.Character.HumanoidRootPart
                                hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                                hrp.CanTouch = true
                                for i=1, 15 do
                                    firetouchinterest(hrp, handle, 0)
                                    firetouchinterest(hrp, handle, 1)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local VisualTab = Window:CreateTab("Visual & Hitbox", 4483345998)

VisualTab:CreateToggle({
   Name = "Bật ESP Player",
   CurrentValue = false,
   Callback = function(v) _G.ESP = v end,
})

VisualTab:CreateToggle({
   Name = "Hiển Thị Hitbox",
   CurrentValue = false,
   Callback = function(v) _G.ShowHitbox = v end,
})

VisualTab:CreateColorPicker({
    Name = "Tùy Chỉnh Màu Hitbox",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "HitboxColor",
    Callback = function(Value) _G.HitboxColor = Value end
})

task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            for _, v in ipairs(game.Players:GetPlayers()) do
                if v ~= lp and v.Character then
                    local hrp = v.Character:FindFirstChild("HumanoidRootPart")
                    local head = v.Character:FindFirstChild("Head")

                    if hrp then
                        if _G.ShowHitbox then
                            hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                            hrp.Transparency = 0.5
                            hrp.Color = _G.HitboxColor
                            hrp.Material = Enum.Material.Neon
                            hrp.CanTouch = true
                        else
                            hrp.Size = Vector3.new(2, 2, 1)
                            hrp.Transparency = 1
                        end
                    end

                    if head then
                        local esp = head:FindFirstChild("HffiuffESP")
                        if _G.ESP then
                            if not esp then
                                local b = Instance.new("BillboardGui", head)
                                b.Name = "HffiuffESP"
                                b.AlwaysOnTop = true
                                b.Size = UDim2.new(0, 100, 0, 30)
                                local t = Instance.new("TextLabel", b)
                                t.Text = v.DisplayName
                                t.TextColor3 = Color3.new(1, 0, 0)
                                t.BackgroundTransparency = 1
                                t.Size = UDim2.new(1, 0, 1, 0)
                                t.Font = Enum.Font.SourceSansBold
                                t.TextSize = 14
                            end
                        else
                            if esp then esp:Destroy() end
                        end
                    end
                end
            end
        end)
    end
end)

local MiscTab = Window:CreateTab("Misc", 4483345998)

MiscTab:CreateInput({
   Name = "Whitelist (Né)",
   PlaceholderText = "Tên...",
   RemoveTextAfterFocusLost = false,
   Callback = function(t) _G.Whitelist = t end,
})

MiscTab:CreateInput({
   Name = "Nội dung Spam",
   PlaceholderText = "Nhập...",
   RemoveTextAfterFocusLost = false,
   Callback = function(t) _G.SpamText = t end,
})

MiscTab:CreateToggle({
   Name = "Auto Spam",
   CurrentValue = false,
   Callback = function(v)
      _G.SpamChat = v
      task.spawn(function()
         while _G.SpamChat do
            pcall(function()
                if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
                    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(_G.SpamText)
                else
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.SpamText, "All")
                end
            end)
            task.wait(2)
         end
      end)
   end,
})

MiscTab:CreateLabel("----------------------------------------")
MiscTab:CreateLabel("by developer Hffiuff 🗿🇻🇳")
