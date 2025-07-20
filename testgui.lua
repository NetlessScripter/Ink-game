local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local UILib = {}

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

function UILib:ToggleUI()
	mainFrame.Visible = not mainFrame.Visible
end

local toggleButton = Instance.new("ImageButton", gui)
toggleButton.Name = "Toggle"
toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)
toggleButton.Position = UDim2.new(0, 0, 0.45, 0)
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Image = "rbxassetid://118398967616157"
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton)

toggleButton.MouseButton1Click:Connect(function()
	UILib:ToggleUI()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightControl then
		UILib:ToggleUI()
	end
end)

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

		function SectionObject:NewToggle(text, default, callback)
			local toggleFrame = Instance.new("Frame", tabPage)
			toggleFrame.Size = UDim2.new(0, 300, 0, 35)
			toggleFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", toggleFrame)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, -40, 1, 0)
			label.TextXAlignment = Enum.TextXAlignment.Left

			local toggleButton = Instance.new("TextButton", toggleFrame)
			toggleButton.Size = UDim2.new(0, 30, 0, 30)
			toggleButton.Position = UDim2.new(1, -35, 0, 2)
			toggleButton.BackgroundColor3 = default and Color3.fromRGB(27, 150, 72) or Color3.fromRGB(100, 100, 100)
			toggleButton.AutoButtonColor = false
			toggleButton.Text = ""
			toggleButton.ClipsDescendants = true
			Instance.new("UICorner", toggleButton)

			local toggled = default

			local function updateToggle(state)
				toggled = state
				toggleButton.BackgroundColor3 = toggled and Color3.fromRGB(27, 150, 72) or Color3.fromRGB(100, 100, 100)
			end

			toggleButton.MouseButton1Click:Connect(function()
				updateToggle(not toggled)
				if callback then
					callback(toggled)
				end
			end)

			updateToggle(default)
		end

		function SectionObject:NewSlider(text, min, max, default, callback)
			local sliderFrame = Instance.new("Frame", tabPage)
			sliderFrame.Size = UDim2.new(0, 300, 0, 50)
			sliderFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", sliderFrame)
			label.Text = text .. ": " .. tostring(default)
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, 0, 0, 20)
			label.TextXAlignment = Enum.TextXAlignment.Left

			local sliderBar = Instance.new("Frame", sliderFrame)
			sliderBar.Size = UDim2.new(1, 0, 0, 15)
			sliderBar.Position = UDim2.new(0, 0, 0, 30)
			sliderBar.BackgroundColor3 = Color3.fromRGB(27, 150, 72)
			Instance.new("UICorner", sliderBar)

			local sliderFill = Instance.new("Frame", sliderBar)
			sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			sliderFill.BackgroundColor3 = Color3.fromRGB(45, 255, 45)
			Instance.new("UICorner", sliderFill)

			local dragging = false

			local function updateSlider(x)
				local relativeX = math.clamp(x - sliderBar.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X)
				local percent = relativeX / sliderBar.AbsoluteSize.X
				local value = math.floor(min + (max - min) * percent)
				sliderFill.Size = UDim2.new(percent, 0, 1, 0)
				label.Text = text .. ": " .. tostring(value)
				if callback then
					callback(value)
				end
			end

			sliderBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					updateSlider(input.Position.X)
				end
			end)

			sliderBar.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSlider(input.Position.X)
				end
			end)
		end

		function SectionObject:NewTextbox(text, placeholder, callback)
			local boxFrame = Instance.new("Frame", tabPage)
			boxFrame.Size = UDim2.new(0, 300, 0, 40)
			boxFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", boxFrame)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, 0, 0, 20)
			label.TextXAlignment = Enum.TextXAlignment.Left

			local textbox = Instance.new("TextBox", boxFrame)
			textbox.PlaceholderText = placeholder or ""
			textbox.Font = Enum.Font.RobotoMono
			textbox.TextSize = 18
			textbox.TextColor3 = Color3.new(1, 1, 1)
			textbox.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
			textbox.Size = UDim2.new(1, 0, 0, 20)
			textbox.Position = UDim2.new(0, 0, 0, 20)
			Instance.new("UICorner", textbox)

			textbox.FocusLost:Connect(function(enterPressed)
				if enterPressed and callback then
					callback(textbox.Text)
				end
			end)
		end

		function SectionObject:NewColorSlider(text, defaultColor, callback)
			local colorFrame = Instance.new("Frame", tabPage)
			colorFrame.Size = UDim2.new(0, 300, 0, 80)
			colorFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", colorFrame)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, 0, 0, 20)
			label.TextXAlignment = Enum.TextXAlignment.Left

			local hueSliderFrame = Instance.new("Frame", colorFrame)
			hueSliderFrame.Size = UDim2.new(1, 0, 0, 20)
			hueSliderFrame.Position = UDim2.new(0, 0, 0, 25)
			hueSliderFrame.BackgroundColor3 = Color3.fromRGB(27, 150, 72)
			Instance.new("UICorner", hueSliderFrame)

			local hueFill = Instance.new("Frame", hueSliderFrame)
			hueFill.Size = UDim2.new(defaultColor and defaultColor.R or 0, 0, 1, 0)
			hueFill.BackgroundColor3 = Color3.fromRGB(45, 255, 45)
			Instance.new("UICorner", hueFill)

			local dragging = false

			local function updateColorSlider(x)
				local relativeX = math.clamp(x - hueSliderFrame.AbsolutePosition.X, 0, hueSliderFrame.AbsoluteSize.X)
				local percent = relativeX / hueSliderFrame.AbsoluteSize.X
				hueFill.Size = UDim2.new(percent, 0, 1, 0)

				local hue = percent
				local saturation = 1
				local value = 1

				local color = Color3.fromHSV(hue, saturation, value)
				if callback then
					callback(color)
				end
			end

			hueSliderFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					updateColorSlider(input.Position.X)
				end
			end)

			hueSliderFrame.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateColorSlider(input.Position.X)
				end
			end)
		end

		return SectionObject
	end

	return TabObject
end

return UILib
