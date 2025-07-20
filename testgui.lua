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
			local button = Instance.new("TextButton", tabPage)
			button.Size = UDim2.new(0, 300, 0, 40)
			button.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
			button.AutoButtonColor = true
			button.Text = text .. (desc and (" - " .. desc) or "")
			button.Font = Enum.Font.RobotoMono
			button.TextSize = 18
			button.TextColor3 = Color3.new(1, 1, 1)
			Instance.new("UICorner", button)

			button.MouseButton1Click:Connect(callback)
		end

		function SectionObject:NewToggle(text, default, callback)
			local toggleFrame = Instance.new("Frame", tabPage)
			toggleFrame.Size = UDim2.new(0, 300, 0, 40)
			toggleFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", toggleFrame)
			label.Size = UDim2.new(1, -40, 1, 0)
			label.Position = UDim2.new(0, 5, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local button = Instance.new("TextButton", toggleFrame)
			button.Size = UDim2.new(0, 30, 0, 30)
			button.Position = UDim2.new(1, -35, 0.5, -15)
			button.BackgroundColor3 = default and Color3.fromRGB(33, 132, 66) or Color3.fromRGB(90, 90, 90)
			button.AutoButtonColor = true
			button.Text = default and "✔" or ""
			button.Font = Enum.Font.RobotoMono
			button.TextSize = 18
			button.TextColor3 = Color3.new(1, 1, 1)
			Instance.new("UICorner", button)

			local toggled = default

			button.MouseButton1Click:Connect(function()
				toggled = not toggled
				button.BackgroundColor3 = toggled and Color3.fromRGB(33, 132, 66) or Color3.fromRGB(90, 90, 90)
				button.Text = toggled and "✔" or ""
				if callback then callback(toggled) end
			end)
		end

		function SectionObject:NewSlider(text, min, max, default, callback)
			local sliderFrame = Instance.new("Frame", tabPage)
			sliderFrame.Size = UDim2.new(0, 300, 0, 40)
			sliderFrame.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
			Instance.new("UICorner", sliderFrame)

			local label = Instance.new("TextLabel", sliderFrame)
			label.Size = UDim2.new(1, -50, 1, 0)
			label.Position = UDim2.new(0, 5, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local valueLabel = Instance.new("TextLabel", sliderFrame)
			valueLabel.Size = UDim2.new(0, 40, 1, 0)
			valueLabel.Position = UDim2.new(1, -45, 0, 0)
			valueLabel.Text = tostring(default)
			valueLabel.Font = Enum.Font.RobotoMono
			valueLabel.TextSize = 18
			valueLabel.TextColor3 = Color3.new(1, 1, 1)
			valueLabel.BackgroundTransparency = 1

			local bar = Instance.new("Frame", sliderFrame)
			bar.Size = UDim2.new(1, -60, 0, 8)
			bar.Position = UDim2.new(0, 50, 0.5, -4)
			bar.BackgroundColor3 = Color3.fromRGB(27, 150, 72)
			Instance.new("UICorner", bar)

			local fill = Instance.new("Frame", bar)
			fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			fill.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
			Instance.new("UICorner", fill)

			local dragging = false

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)

			bar.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			bar.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local pos = math.clamp(input.Position.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
					local val = min + (pos / bar.AbsoluteSize.X) * (max - min)
					fill.Size = UDim2.new(pos / bar.AbsoluteSize.X, 0, 1, 0)
					valueLabel.Text = string.format("%.2f", val)
					if callback then callback(val) end
				end
			end)
		end

		function SectionObject:NewTextbox(text, placeholder, callback)
			local textBoxFrame = Instance.new("Frame", tabPage)
			textBoxFrame.Size = UDim2.new(0, 300, 0, 40)
			textBoxFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", textBoxFrame)
			label.Size = UDim2.new(1, -110, 1, 0)
			label.Position = UDim2.new(0, 5, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local box = Instance.new("TextBox", textBoxFrame)
			box.Size = UDim2.new(0, 100, 0, 25)
			box.Position = UDim2.new(1, -105, 0.5, -12)
			box.Text = ""
			box.PlaceholderText = placeholder or ""
			box.Font = Enum.Font.RobotoMono
			box.TextSize = 18
			box.TextColor3 = Color3.new(1, 1, 1)
			box.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
			Instance.new("UICorner", box)

			box.FocusLost:Connect(function(enterPressed)
				if enterPressed and callback then
					callback(box.Text)
				end
			end)
		end

		function SectionObject:NewColorSlider(text, defaultColor, callback)
			local frame = Instance.new("Frame", tabPage)
			frame.Size = UDim2.new(0, 300, 0, 60)
			frame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", frame)
			label.Size = UDim2.new(1, -10, 0, 20)
			label.Position = UDim2.new(0, 5, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 18
			label.TextColor3 = Color3.new(1, 1, 1)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local sliderFrame = Instance.new("Frame", frame)
			sliderFrame.Size = UDim2.new(1, -10, 0, 30)
			sliderFrame.Position = UDim2.new(0, 5, 0, 30)
			sliderFrame.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
			sliderFrame.ClipsDescendants = true
			sliderFrame.Active = true
			sliderFrame.Selectable = true
			sliderFrame.AutoButtonColor = false
			Instance.new("UICorner", sliderFrame)

			local sliderFill = Instance.new("Frame", sliderFrame)
			local hue, sat, val = Color3.toHSV(defaultColor or Color3.new(1, 0, 0))
			sliderFill.Size = UDim2.new(hue, 0, 1, 0)
			sliderFill.BackgroundColor3 = defaultColor or Color3.new(1, 0, 0)
			Instance.new("UICorner", sliderFill)

			local dragging = false

			local function updateSlider(input)
				local xPos = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
				local pct = xPos / sliderFrame.AbsoluteSize.X
				sliderFill.Size = UDim2.new(pct, 0, 1, 0)
				local newColor = Color3.fromHSV(pct, 1, 1)
				sliderFill.BackgroundColor3 = newColor
				if callback then callback(newColor) end
			end

			sliderFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					updateSlider(input)
				end
			end)

			sliderFrame.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			sliderFrame.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSlider(input)
				end
			end)
		end

		return SectionObject
	end

	return TabObject
end

return UILib
