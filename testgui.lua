local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

if _G.UIBlur == true then
	local blur = Instance.new("BlurEffect")
	blur.Size = 24
	blur.Name = "UILibBlur"
	blur.Parent = Lighting
end

local function GetGitSound(GithubSnd, SoundName)
    local url = GithubSnd
    if not isfile(SoundName .. ".mp3") then
        writefile(SoundName .. ".mp3", game:HttpGet(url))
    end
    local sound = Instance.new("Sound")
    sound.SoundId = (getcustomasset or getsynasset)(SoundName .. ".mp3")
    sound.Volume = 2
    sound.Name = "UI_SFX_TAB"
    sound.Parent = workspace
    return sound
end

local tabSwitchSound = GetGitSound("https://github.com/NetlessScripter/UI-SFX/blob/9eea7e5ab6b365cc31a3a0adb958a578554becd0/copy_E42D2505-ED6D-4605-9CEF-083DC78CB9CA.mp3?raw=true", "UISFX TAB SWITCH")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "UILibrary"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 520, 0, 340)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 72, 40)
mainFrame.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(40, 180, 85)
mainStroke.Thickness = 3
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local bg = Instance.new("ImageLabel", mainFrame)
bg.Image = "rbxassetid://6803353442"
bg.BackgroundTransparency = 1
bg.ImageTransparency = 0.92
bg.ScaleType = Enum.ScaleType.Tile
bg.TileSize = UDim2.new(0, 14, 0, 14)
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
tabLayout.Padding = UDim.new(0, 8)

local UILib = {}

local currentTab = nil

function UILib:NewTab(tabName, iconId)
	local tabButton = Instance.new("TextButton", tabContainer)
	tabButton.Size = UDim2.new(1, -14, 0, 44)
	tabButton.Position = UDim2.new(0, 7, 0, 0)
	tabButton.BackgroundColor3 = Color3.fromRGB(42, 150, 74)
	tabButton.BackgroundTransparency = 0
	tabButton.Text = ""
	tabButton.AutoButtonColor = true
	tabButton.TextColor3 = Color3.new(1, 1, 1)
	tabButton.Font = Enum.Font.RobotoMono
	tabButton.TextSize = 18
	local tabCorner = Instance.new("UICorner", tabButton)
	tabCorner.CornerRadius = UDim.new(0, 10)
	local tabStroke = Instance.new("UIStroke", tabButton)
	tabStroke.Color = Color3.fromRGB(70, 200, 100)
	tabStroke.Thickness = 2

	local iconContainer = Instance.new("Frame", tabButton)
	iconContainer.BackgroundTransparency = 1
	iconContainer.Size = UDim2.new(1, 0, 1, 0)

	local layout = Instance.new("UIListLayout", iconContainer)
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	layout.Padding = UDim.new(0, 10)

	if iconId then
		local icon = Instance.new("ImageLabel", iconContainer)
		icon.Size = UDim2.new(0, 26, 0, 26)
		icon.Image = iconId
		icon.BackgroundTransparency = 1
		icon.Name = "Icon"
		icon.ImageColor3 = Color3.fromRGB(220, 255, 220)
	end

	local label = Instance.new("TextLabel", iconContainer)
	label.Text = tabName
	label.Font = Enum.Font.RobotoMono
	label.TextSize = 19
	label.TextColor3 = Color3.fromRGB(230, 255, 230)
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -36, 1, 0)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Name = "Label"
	label.TextStrokeTransparency = 0.7

	local tabPage = Instance.new("ScrollingFrame", contentContainer)
	tabPage.Size = UDim2.new(1, 0, 1, 0)
	tabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabPage.BackgroundTransparency = 1
	tabPage.ScrollBarThickness = 8
	tabPage.Visible = false
	tabPage.Name = tabName:gsub(" ", "_") .. "_Page"

	local layout = Instance.new("UIListLayout", tabPage)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 8)

	tabButton.MouseButton1Click:Connect(function()
		if currentTab ~= tabPage then
			for _, v in pairs(contentContainer:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			tabPage.Visible = true
			currentTab = tabPage
			tabSwitchSound:Play()
		end
	end)

	if #tabContainer:GetChildren() == 2 then
		tabPage.Visible = true
		currentTab = tabPage
	end

	local TabObject = {}

	function TabObject:NewSection(sectionName)
		local sectionLabel = Instance.new("TextLabel", tabPage)
		sectionLabel.Size = UDim2.new(1, -14, 0, 34)
		sectionLabel.Text = sectionName
		sectionLabel.Font = Enum.Font.RobotoMono
		sectionLabel.TextColor3 = Color3.fromRGB(230, 255, 230)
		sectionLabel.BackgroundColor3 = Color3.fromRGB(40, 180, 85)
		sectionLabel.BackgroundTransparency = 0.25
		sectionLabel.TextSize = 22
		sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
		local corner = Instance.new("UICorner", sectionLabel)
		corner.CornerRadius = UDim.new(0, 10)

		local SectionObject = {}

		function SectionObject:NewButton(text, desc, callback)
			local button = Instance.new("TextButton", tabPage)
			button.Size = UDim2.new(0, 300, 0, 44)
			button.BackgroundColor3 = Color3.fromRGB(42, 150, 74)
			button.AutoButtonColor = true
			button.Text = text .. (desc and (" - " .. desc) or "")
			button.Font = Enum.Font.RobotoMono
			button.TextSize = 19
			button.TextColor3 = Color3.fromRGB(230, 255, 230)
			local corner = Instance.new("UICorner", button)
			corner.CornerRadius = UDim.new(0, 10)
			local stroke = Instance.new("UIStroke", button)
			stroke.Color = Color3.fromRGB(70, 200, 100)
			stroke.Thickness = 2
			button.MouseButton1Click:Connect(callback)
		end

		function SectionObject:NewToggle(text, default, callback)
			local toggleFrame = Instance.new("Frame", tabPage)
			toggleFrame.Size = UDim2.new(0, 300, 0, 44)
			toggleFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", toggleFrame)
			label.Size = UDim2.new(1, -44, 1, 0)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 19
			label.TextColor3 = Color3.fromRGB(230, 255, 230)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local button = Instance.new("TextButton", toggleFrame)
			button.Size = UDim2.new(0, 34, 0, 34)
			button.Position = UDim2.new(1, -40, 0.5, -17)
			button.BackgroundColor3 = default and Color3.fromRGB(42, 150, 74) or Color3.fromRGB(100, 100, 100)
			button.AutoButtonColor = true
			button.Text = default and "✔" or ""
			button.Font = Enum.Font.RobotoMono
			button.TextSize = 22
			button.TextColor3 = Color3.fromRGB(230, 255, 230)
			local corner = Instance.new("UICorner", button)
			corner.CornerRadius = UDim.new(0, 8)
			local stroke = Instance.new("UIStroke", button)
			stroke.Color = Color3.fromRGB(70, 200, 100)
			stroke.Thickness = 2

			local toggled = default

			button.MouseButton1Click:Connect(function()
				toggled = not toggled
				button.BackgroundColor3 = toggled and Color3.fromRGB(42, 150, 74) or Color3.fromRGB(100, 100, 100)
				button.Text = toggled and "✔" or ""
				if callback then callback(toggled) end
			end)
		end

		function SectionObject:NewSlider(text, min, max, default, callback)
			local sliderFrame = Instance.new("Frame", tabPage)
			sliderFrame.Size = UDim2.new(0, 300, 0, 44)
			sliderFrame.BackgroundColor3 = Color3.fromRGB(42, 150, 74)
			local corner = Instance.new("UICorner", sliderFrame)
			corner.CornerRadius = UDim.new(0, 10)
			local stroke = Instance.new("UIStroke", sliderFrame)
			stroke.Color = Color3.fromRGB(70, 200, 100)
			stroke.Thickness = 2

			local label = Instance.new("TextLabel", sliderFrame)
			label.Size = UDim2.new(1, -56, 1, 0)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 19
			label.TextColor3 = Color3.fromRGB(230, 255, 230)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local valueLabel = Instance.new("TextLabel", sliderFrame)
			valueLabel.Size = UDim2.new(0, 46, 1, 0)
			valueLabel.Position = UDim2.new(1, -52, 0, 0)
			valueLabel.Text = tostring(default)
			valueLabel.Font = Enum.Font.RobotoMono
			valueLabel.TextSize = 19
			valueLabel.TextColor3 = Color3.fromRGB(230, 255, 230)
			valueLabel.BackgroundTransparency = 1

			local bar = Instance.new("Frame", sliderFrame)
			bar.Size = UDim2.new(1, -68, 0, 10)
			bar.Position = UDim2.new(0, 56, 0.5, -5)
			bar.BackgroundColor3 = Color3.fromRGB(30, 120, 60)
			local barCorner = Instance.new("UICorner", bar)
			barCorner.CornerRadius = UDim.new(0, 6)

			local fill = Instance.new("Frame", bar)
			fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			fill.BackgroundColor3 = Color3.fromRGB(48, 170, 80)
			local fillCorner = Instance.new("UICorner", fill)
			fillCorner.CornerRadius = UDim.new(0, 6)

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
			textBoxFrame.Size = UDim2.new(0, 300, 0, 44)
			textBoxFrame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", textBoxFrame)
			label.Size = UDim2.new(1, -120, 1, 0)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 19
			label.TextColor3 = Color3.fromRGB(230, 255, 230)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local box = Instance.new("TextBox", textBoxFrame)
			box.Size = UDim2.new(0, 110, 0, 28)
			box.Position = UDim2.new(1, -115, 0.5, -14)
			box.Text = ""
			box.PlaceholderText = placeholder or ""
			box.Font = Enum.Font.RobotoMono
			box.TextSize = 19
			box.TextColor3 = Color3.fromRGB(230, 255, 230)
			box.BackgroundColor3 = Color3.fromRGB(42, 150, 74)
			local boxCorner = Instance.new("UICorner", box)
			boxCorner.CornerRadius = UDim.new(0, 10)
			local boxStroke = Instance.new("UIStroke", box)
			boxStroke.Color = Color3.fromRGB(70, 200, 100)
			boxStroke.Thickness = 2

			box.FocusLost:Connect(function(enterPressed)
				if enterPressed and callback then
					callback(box.Text)
				end
			end)
		end

		function SectionObject:NewColorSlider(text, defaultColor, callback)
			local frame = Instance.new("Frame", tabPage)
			frame.Size = UDim2.new(0, 300, 0, 66)
			frame.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", frame)
			label.Size = UDim2.new(1, -10, 0, 22)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.Text = text
			label.Font = Enum.Font.RobotoMono
			label.TextSize = 19
			label.TextColor3 = Color3.fromRGB(230, 255, 230)
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left

			local sliderFrame = Instance.new("Frame", frame)
			sliderFrame.Size = UDim2.new(1, -16, 0, 34)
			sliderFrame.Position = UDim2.new(0, 8, 0, 28)
			sliderFrame.BackgroundColor3 = Color3.fromRGB(42, 150, 74)
			sliderFrame.ClipsDescendants = true
			sliderFrame.Active = true
			sliderFrame.Selectable = true
			sliderFrame.AutoButtonColor = false
			local sliderCorner = Instance.new("UICorner", sliderFrame)
			sliderCorner.CornerRadius = UDim.new(0, 12)

			local sliderFill = Instance.new("Frame", sliderFrame)
			local hue, sat, val = Color3.toHSV(defaultColor or Color3.new(1, 0, 0))
			sliderFill.Size = UDim2.new(hue, 0, 1, 0)
			sliderFill.BackgroundColor3 = defaultColor or Color3.new(1, 0, 0)
			local fillCorner = Instance.new("UICorner", sliderFill)
			fillCorner.CornerRadius = UDim.new(0, 12)

			local dragging = false

			sliderFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)

			sliderFrame.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			sliderFrame.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local pos = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
					local hueValue = pos / sliderFrame.AbsoluteSize.X
					sliderFill.Size = UDim2.new(hueValue, 0, 1, 0)
					local newColor = Color3.fromHSV(hueValue, 1, 1)
					sliderFill.BackgroundColor3 = newColor
					if callback then callback(newColor) end
				end
			end)
		end

		return SectionObject
	end

	return TabObject
end

return UILib
