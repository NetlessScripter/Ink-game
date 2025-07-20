local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 24
blur.Name = "UILibBlur"

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "UILibrary"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 520, 0, 340)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(17, 66, 34)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(27, 150, 72)

local bg = Instance.new("ImageLabel", mainFrame)
bg.Image = "rbxassetid://6803353442"
bg.BackgroundTransparency = 1
bg.ImageTransparency = 0.95
bg.ScaleType = Enum.ScaleType.Tile
bg.TileSize = UDim2.new(0, 10, 0, 10)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BorderSizePixel = 0
bg.ZIndex = 0

local tabContainer = Instance.new("Frame", mainFrame)
tabContainer.BackgroundTransparency = 1
tabContainer.Size = UDim2.new(0, 130, 1, 0)
tabContainer.Position = UDim2.new(0, 0, 0, 0)

local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -130, 1, 0)
contentContainer.Position = UDim2.new(0, 130, 0, 0)
contentContainer.BackgroundTransparency = 1
contentContainer.Name = "Content"

local tabLayout = Instance.new("UIListLayout", tabContainer)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 4)

local UILib = {}

function UILib:NewTab(tabName, iconId)
	local tabButton = Instance.new("TextButton", tabContainer)
	tabButton.Size = UDim2.new(1, -10, 0, 40)
	tabButton.Position = UDim2.new(0, 5, 0, 0)
	tabButton.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
	tabButton.BackgroundTransparency = 0.2
	tabButton.Text = ""
	tabButton.AutoButtonColor = true
	tabButton.TextColor3 = Color3.new(1, 1, 1)
	tabButton.Font = Enum.Font.RobotoMono
	tabButton.TextSize = 18
	Instance.new("UICorner", tabButton)

	local iconContainer = Instance.new("Frame", tabButton)
	iconContainer.BackgroundTransparency = 1
	iconContainer.Size = UDim2.new(1, 0, 1, 0)

	local layout = Instance.new("UIListLayout", iconContainer)
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	layout.Padding = UDim.new(0, 6)

	if iconId then
		local icon = Instance.new("ImageLabel", iconContainer)
		icon.Size = UDim2.new(0, 24, 0, 24)
		icon.Image = iconId
		icon.BackgroundTransparency = 1
		icon.Name = "Icon"
	end

	local label = Instance.new("TextLabel", iconContainer)
	label.Text = tabName
	label.Font = Enum.Font.RobotoMono
	label.TextSize = 18
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -30, 1, 0)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Name = "Label"

	local tabPage = Instance.new("ScrollingFrame", contentContainer)
	tabPage.Size = UDim2.new(1, 0, 1, 0)
	tabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabPage.BackgroundTransparency = 1
	tabPage.ScrollBarThickness = 6
	tabPage.Visible = false
	tabPage.Name = tabName:gsub(" ", "_") .. "_Page"

	local layout = Instance.new("UIListLayout", tabPage)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 6)

	tabButton.MouseButton1Click:Connect(function()
		for _, v in pairs(contentContainer:GetChildren()) do
			if v:IsA("ScrollingFrame") then
				v.Visible = false
			end
		end
		tabPage.Visible = true
	end)

	if #tabContainer:GetChildren() == 2 then
		tabPage.Visible = true
	end

	local TabObject = {}

	function TabObject:NewSection(sectionName)
		local sectionLabel = Instance.new("TextLabel", tabPage)
		sectionLabel.Size = UDim2.new(1, -10, 0, 30)
		sectionLabel.Text = sectionName
		sectionLabel.Font = Enum.Font.RobotoMono
		sectionLabel.TextColor3 = Color3.new(1, 1, 1)
		sectionLabel.BackgroundColor3 = Color3.fromRGB(27, 150, 72)
		sectionLabel.BackgroundTransparency = 0.3
		sectionLabel.TextSize = 20
		sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
		Instance.new("UICorner", sectionLabel)

		local SectionObject = {}

		function SectionObject:NewButton(text, desc, callback)
			local button = Instance.new("ImageButton", tabPage)
			button.Size = UDim2.new(0, 300, 0, 45)
			button.BackgroundTransparency = 1
			button.Image = "rbxassetid://6803353442"
			button.Name = text

			local label = Instance.new("TextLabel", button)
			label.Text = text .. (desc and (" - " .. desc) or "")
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1

			button.MouseButton1Click:Connect(callback)
		end

		return SectionObject
	end

	return TabObject
end

return UILib
