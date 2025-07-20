function SectionObject:NewButton(text, desc, callback, iconId)
    local button = Instance.new("ImageButton", tabPage)
    button.Size = UDim2.new(0, 300, 0, 45)
    button.BackgroundTransparency = 0.3
    button.BackgroundColor3 = Color3.fromRGB(33, 132, 66)
    button.AutoButtonColor = true
    button.Image = "rbxassetid://6803353442"
    button.Name = text
    button.ScaleType = Enum.ScaleType.Slice
    button.SliceCenter = Rect.new(10, 10, 118, 118)
    button.SliceScale = 0.1

    local icon = nil
    if iconId then
        icon = Instance.new("ImageLabel", button)
        icon.Size = UDim2.new(0, 28, 0, 28)
        icon.Position = UDim2.new(0, 7, 0.5, -14)
        icon.Image = iconId
        icon.BackgroundTransparency = 1
        icon.Name = "Icon"
    end

    local label = Instance.new("TextLabel", button)
    label.Text = text .. (desc and (" - " .. desc) or "")
    label.Font = Enum.Font.RobotoMono
    label.TextSize = 18
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(1, icon and -42 or -14, 1, 0)
    label.Position = UDim2.new(icon and 0, 42 or 0, 0, 0)
    label.Name = "Label"

    button.MouseButton1Click:Connect(callback)
end
