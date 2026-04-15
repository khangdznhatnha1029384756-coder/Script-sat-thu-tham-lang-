local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local CoreGui = game:GetService("CoreGui")

local Window = Rayfield:CreateWindow({
   Name = "Banana Premium",
   LoadingTitle = "Banana Premium",
   LoadingSubtitle = "by ImKhang",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local ShopTab = Window:CreateTab("Shop", 4483345998)
local StatusTab = Window:CreateTab("Status And Server", 4483345998)
local LocalPlayerTab = Window:CreateTab("LocalPlayer", 4483345998)
local SettingFarmTab = Window:CreateTab("Setting Farm", 4483345998)
local SkillTab = Window:CreateTab("Hold and Select Skill", 4483345998)
local FarmingTab = Window:CreateTab("Farming", 4483345998)
local StackFarmingTab = Window:CreateTab("Stack Farming", 4483345998)
local FarmingOtherTab = Window:CreateTab("Farming Other", 4483345998)
local FruitRaidTab = Window:CreateTab("Fruit and Raid", 4483345998)
local SeaEventTab = Window:CreateTab("Sea Event", 4483345998)
local SettingsTab = Window:CreateTab("UI Settings", 4483345998)

FarmingOtherTab:CreateSection("Event Oni")
FarmingOtherTab:CreateToggle({Name = "Auto Oni Soldier", CurrentValue = false, Callback = function() end})
FarmingOtherTab:CreateToggle({Name = "Auto Red Commander", CurrentValue = false, Callback = function() end})
FarmingOtherTab:CreateToggle({Name = "Hop Server Find Red Commander Or Oni Soldier", CurrentValue = false, Callback = function() end})
FarmingOtherTab:CreateToggle({Name = "Auto Gacha Oni", CurrentValue = false, Callback = function() end})

FarmingOtherTab:CreateSection("Fishing")
FarmingOtherTab:CreateToggle({Name = "Change Size Reel", CurrentValue = false, Callback = function() end})
FarmingOtherTab:CreateInput({Name = "Position :", PlaceholderText = "Enter...", RemoveTextAfterFocusLost = false, Callback = function() end})

_G.RainbowMode = false

SettingsTab:CreateSection("Premium Colors")
SettingsTab:CreateColorPicker({
    Name = "Custom UI Color (Default Red)",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "CustomColor",
    Callback = function(Value)
        _G.RainbowMode = false
        pcall(function()
            for _, v in pairs(CoreGui:GetDescendants()) do
                if v:IsA("Frame") and (v.Name == "TopBar" or v.Name == "ToggleInner" or v.Name == "SliderInner") then
                    v.BackgroundColor3 = Value
                elseif v:IsA("UIStroke") then
                    v.Color = Value
                elseif v:IsA("TextLabel") and (v.Name == "Title" or v.Name == "SectionTitle") then
                    v.TextColor3 = Value
                end
            end
        end)
    end
})

SettingsTab:CreateToggle({
   Name = "Rainbow UI Mode",
   CurrentValue = false,
   Callback = function(Value)
      _G.RainbowMode = Value
   end,
})

task.spawn(function()
    local hue = 0
    while task.wait(0.02) do
        if _G.RainbowMode then
            hue = hue + 0.005
            if hue >= 1 then hue = 0 end
            local color = Color3.fromHSV(hue, 1, 1)
            pcall(function()
                for _, v in pairs(CoreGui:GetDescendants()) do
                    if v:IsA("Frame") and (v.Name == "TopBar" or v.Name == "ToggleInner" or v.Name == "SliderInner") then
                        v.BackgroundColor3 = color
                    elseif v:IsA("UIStroke") then
                        v.Color = color
                    elseif v:IsA("TextLabel") and (v.Name == "Title" or v.Name == "SectionTitle") then
                        v.TextColor3 = color
                    end
                end
            end)
        end
    end
end)
