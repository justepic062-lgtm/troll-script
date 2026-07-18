-- Services
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local function generate_string(length)
	local character_set = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local random_string = {}
	for int = 1, length or 10 do
		random_string[#random_string + 1] = string.sub(character_set, math.random(1, #character_set), math.random(1, #character_set))
	end
	return table.concat(random_string)
end

local FunctionManager = {
	CategorizedFunctions = { All = {} },
	Categories          = { "All" },
	CurrentCategoryIndex= 1,
	Descriptions        = {},
	ISFE = {},
	OnFunctionAdded     = Instance.new("BindableEvent"),
}

function FunctionManager:register(name, callback, category, description, FE)
	category = category or "General"
	if not self.CategorizedFunctions[category] then
		self.CategorizedFunctions[category] = {}
		table.insert(self.Categories, category)
	end
	self.CategorizedFunctions[category][name] = callback
	self.CategorizedFunctions.All[name]        = callback
	self.Descriptions[name]                    = description or ""
	self.ISFE[name]                    = FE or "yes"
	self.OnFunctionAdded:Fire(category, name, callback)
	self.OnFunctionAdded:Fire("All",      name, callback)
end

function FunctionManager:getCurrentCategory()
	return self.Categories[self.CurrentCategoryIndex]
end

function FunctionManager:cycleCategory()
	self.CurrentCategoryIndex = self.CurrentCategoryIndex % #self.Categories + 1
	return self:getCurrentCategory()
end

-- La fonction delta que tu voulais
FunctionManager:register("delta", function()
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("CoolkiddAlert") then playerGui.CoolkiddAlert:Destroy() end

    local screen = Instance.new("ScreenGui")
    screen.Name = "CoolkiddAlert"
    screen.ResetOnSpawn = false
    screen.Parent = playerGui

    local text = Instance.new("TextLabel")
    text.Parent = screen
    text.Size = UDim2.new(1, 0, 0, 100)
    text.Position = UDim2.new(0, 0, 0.5, -50)
    text.BackgroundTransparency = 1
    text.Text = "coolkidd is back"
    text.TextColor3 = Color3.fromRGB(255, 0, 0)
    text.Font = Enum.Font.SourceSansBold
    text.TextScaled = true
    text.TextStrokeTransparency = 0

    task.wait(3)
    if screen then screen:Destroy() end
end, "Troll", "Affiche le message pour moi")

-- Petit message de bienvenue
local screenGui = Instance.new("ScreenGui", PlayerGui)
local welcome = Instance.new("TextLabel", screenGui)
welcome.Text = "Menu pret !"
welcome.Size = UDim2.new(0, 200, 0, 50)
welcome.Position = UDim2.new(0.5, -100, 0, 0)
task.wait(2)
screenGui:Destroy()
