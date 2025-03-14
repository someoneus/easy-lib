easy = {}
Components = {}
task.spawn(function()
    warn("EasyLibrary Is Booting")
    end)
function Components:CreateWindow(self, name, x, y)
    name = name or "EasyLibrary"
    local core = game:GetService("CoreGui")
    local dupe = core:FindFirstChild("EasyLib: "..name)
    if dupe then
        warn("Duplicated Instances ["..name.."]")
        dupe:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Parent = core
    gui.ResetOnSpawn = false
    gui.Name = "EasyLib: "..name

    local window = Instance.new("Frame")
    window.Parent = gui
    window.Size = UDim2.new(0, x, 0, y)
    window.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    window.BackgroundTransparency = 0.1

    local hide = Instance.new("TextButton")
    hide.Parent = gui
    hide.Size = UDim2.new(0.1, 0, 0.1, 0)
    hide.Position = UDim2.new(0.45, 0, 0, 0)
    hide.Text = name.." +"
    hide.TextScaled = true
    hide.BackgroundTransparency = 1
    hide.Visible = false
    hide.Font = Enum.Font.GothamBold

    -- Animated Text Color
    task.spawn(function()
        local hue = 0
        while true do
            hue = (hue + 0.005) % 1
            hide.TextColor3 = Color3.fromHSV(hue, 1, 1)
            task.wait(0.05) 
        end
    end)

    local tx = Instance.new("TextLabel")
    tx.Parent = window
    tx.Size = UDim2.new(0.95, 0, 0.1, 0)
    tx.Position = UDim2.new(0.025, 0, 0.005, 0)
    tx.TextScaled = true
    tx.Font = Enum.Font.Code
    tx.TextXAlignment = Enum.TextXAlignment.Left
    tx.Text = name
    tx.BackgroundTransparency = 1
    tx.TextColor3 = Color3.fromRGB(255, 255, 255)

    local st = Instance.new("UIStroke")
    st.Parent = window
    st.Thickness = 3
    st.Color = Color3.fromRGB(200, 0, 0)
    st.Transparency = 0.25

    local bar = Instance.new("ScrollingFrame")
    bar.Parent = window
    bar.Size = UDim2.new(0.95, 0, 0.15, 0)
    bar.Position = UDim2.new(0.025, 0, 0.125, 0)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    bar.ScrollBarImageTransparency = 1
    bar.BackgroundTransparency = 1

    local x = Instance.new("TextButton")
    x.Parent = window
    x.TextScaled = true
    x.Font = Enum.Font.GothamBold
    x.Text = "X"
    x.Size = UDim2.new(0.1, 0, 0.1, 0)
    x.Position = UDim2.new(0.9, 0, -0.1, 0)
    x.BackgroundTransparency = 1

    local z = Instance.new("TextButton")
    z.Parent = window
    z.TextScaled = true
    z.Font = Enum.Font.GothamBold
    z.Text = "-"
    z.Size = UDim2.new(0.1, 0, 0.1, 0)
    z.Position = UDim2.new(0.8, 0, -0.1, 0)
    z.BackgroundTransparency = 1

    local ui = Instance.new("UIListLayout")
    ui.FillDirection = Enum.FillDirection.Horizontal
    ui.Parent = bar
    ui.Padding = UDim.new(0.05, 0)
    ui.SortOrder = Enum.SortOrder.LayoutOrder
    ui.VerticalAlignment = Enum.VerticalAlignment.Top
    bar.AutomaticCanvasSize = Enum.AutomaticSize.X
    bar.CanvasSize = UDim2.new(2, 0, 0, 0)

    local UIS = game:GetService("UserInputService")

    -- Close Button
    x.MouseButton1Click:Connect(function()
        warn("Easy Interface ["..name.."] has been killed")
        gui:Destroy()
    end)

    -- Minimize Button
    z.MouseButton1Click:Connect(function()
        hide.Visible = true
        window.Visible = false
    end)

    -- Restore Window
    hide.MouseButton1Click:Connect(function()
        hide.Visible = false
        window.Visible = true
    end)

    -- Dragging Function
    local function enableDragging(frame)
        local dragging, dragInput, startPos, dragStart

        local function update(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end

    -- Apply Dragging to Window and Hide Button
    enableDragging(window)
    enableDragging(hide)

    return window
end

function Components:CreateTab(name)
    if not self.window or not self.bar then
        warn("Error: No window or tab bar found!")
        return
    end

    local tab = Instance.new("TextButton")
    tab.Text = name or "Tab"
    tab.Parent = self.bar
    tab.Size = UDim2.new(0.2, 0, 0.8, 0)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    tab.Font = Enum.Font.Code
    tab.TextScaled = true

    local frame = Instance.new("ScrollingFrame")
    frame.Visible = false
    frame.Parent = self.window
    frame.Position = UDim2.new(0.025, 0, 0.3, 0)
    frame.Size = UDim2.new(0.95, 0, 0.65, 0)
    frame.Name = "tabFrame_" .. name
    frame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    frame.BackgroundTransparency = 1
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.ScrollBarImageTransparency = 1

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.15, 0)
    corner.Parent = tab

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = frame
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0.01, 0)

    -- Tab Click Function
    tab.MouseButton1Click:Connect(function()
        for _, v in pairs(self.window:GetDescendants()) do
            if v:IsA("ScrollingFrame") and v.Name:find("tabFrame_") then
                v.Visible = false
            end
        end
        frame.Visible = true
    end)

    lastCreatedFrame = frame
    return frame
end

function Components:CreateLabel(text)
    if not lastCreatedFrame then return end

    local label = Instance.new("TextLabel")
    label.Parent = lastCreatedFrame
    label.Size = UDim2.new(1, 0, 0.15, 0)
    label.Text = text
    label.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    label.Font = Enum.Font.Cartoon
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 2

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = label

    lastCreatedLabel = label

    -- Return a table with a Set function
    return {
        Object = label,
        Set = function(self, msg)
            self.Object.Text = msg
        end
    }
end



function Components:CreateButton(options)
    if not lastCreatedFrame then
        warn("Error: No active tab! Create a tab first.")
        return
    end

    local button = Instance.new("TextButton")
    button.Parent = lastCreatedFrame
    button.Size = UDim2.new(1, 0, 0.15, 0)
    button.Text = options.Name or "Button"
    button.TextScaled = true
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Cartoon
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.ZIndex = 2
    button.TextXAlignment = Enum.TextXAlignment.Left

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = button

    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false)
    local goal = { BackgroundColor3 = Color3.fromRGB(70, 70, 70) }  -- Slightly different to show animation
    local anim = tweenService:Create(button, tweenInfo, goal)

    local function onClick()
        if options and options.Callback then
            options.Callback()
            button.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
            task.wait(0.1)  -- Small delay before playing tween
            anim:Play()
        end
    end

    button.MouseButton1Click:Connect(onClick)
    button.TouchTap:Connect(onClick)

    return button  -- Return button for further modification if needed
end


function Components:UpdateLabel(msg)
    if not lastCreatedLabel then
        warn("Error: No label found! Create a label first.")
        return
    end

    lastCreatedLabel.Text = msg
    return lastCreatedLabel -- Return the updated label
end


function Components:CreateInput(txtoption)
    if not lastCreatedFrame or not txtoption then return end

    local frame = Instance.new("Frame")
    frame.Parent = lastCreatedFrame
    frame.Size = UDim2.new(1, 0, 0.15, 0)
    frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    local ui = Instance.new("UICorner")
    ui.Parent = frame
    ui.CornerRadius = UDim.new(0.1, 0)

    local text = Instance.new("TextLabel")
    text.Text = txtoption.Name or "Input"
    text.TextScaled = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.Cartoon
    text.Parent = frame
    text.Size = UDim2.new(0.5, 0, 1, 0)
    text.BackgroundTransparency = 1

    local textb = Instance.new("TextBox")
    textb.Parent = frame
    textb.TextScaled = true
    textb.Position = UDim2.new(0.525, 0, 0, 0)
    textb.Size = UDim2.new(0.475, 0, 1, 0)
    textb.Text = txtoption.Placeholder or ""
    textb.PlaceholderText = txtoption.Placeholder or "Enter text..."
    textb.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
    textb.TextColor3 = Color3.fromRGB(255, 255, 255)
    textb.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

    local ui = Instance.new("UICorner")
    ui.Parent = textb
    ui.CornerRadius = UDim.new(0.1, 0)

    textb.FocusLost:Connect(function()
        if txtoption.Callback then
            txtoption.Callback(textb.Text)
        end
    end)

    -- Return object with `Set` method
    return {
        Object = textb,
        Set = function(self, newText)
            self.Object.Text = newText
        end
    }
end


function Components:CreateToggle(option)
    local frame = Instance.new("Frame")
    frame.Parent = lastCreatedFrame
    frame.Size = UDim2.new(1, 0, 0.15, 0)
    frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    local ui = Instance.new("UICorner")
    ui.Parent = frame
    ui.CornerRadius = UDim.new(0.1, 0)

    local text = Instance.new("TextLabel")
    text.Text = option.Name
    text.TextScaled = true
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.Cartoon
    text.Parent = frame
    text.Size = UDim2.new(0.5, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextXAlignment = Enum.TextXAlignment.Left

    local out = Instance.new("Frame")
    out.Parent = frame
    out.Size = UDim2.new(0.15, 0, 0.5, 0)
    out.Position = UDim2.new(0.8, 0, 0.25, 0)
    out.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    out.BackgroundTransparency = 1

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Parent = out
    uiStroke.Thickness = 3.5
    uiStroke.Color = Color3.fromRGB(90, 90, 90)

    local uiCorner = Instance.new("UICorner")
    uiCorner.Parent = out
    uiCorner.CornerRadius = UDim.new(0.5, 0)

    local toggle = Instance.new("TextButton")
    toggle.Parent = out
    toggle.Text = ""
    toggle.Size = UDim2.new(0.325, 0, 0.85, 0)
    toggle.Position = UDim2.new(0.025, 0, 0.09, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(90, 90, 90)

    local uiCornerToggle = Instance.new("UICorner")
    uiCornerToggle.Parent = toggle
    uiCornerToggle.CornerRadius = UDim.new(1, 0)

    local tweenService = game:GetService("TweenService")
    local toggleState = false

    local onTween = tweenService:Create(toggle, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Position = UDim2.new(0.65, 0, 0.09, 0),
        BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    })

    local offTween = tweenService:Create(toggle, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Position = UDim2.new(0.025, 0, 0.09, 0),
        BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    })

    local function toggleAction()
        toggleState = not toggleState
        if option.Callback then
            option.Callback(toggleState)
        end
        if toggleState then
            onTween:Play()
        else
            offTween:Play()
        end
    end

    toggle.MouseButton1Click:Connect(toggleAction)
    toggle.TouchTap:Connect(toggleAction)

    -- Store state inside the toggle instance
    function toggle:GetState()
        return toggleState
    end

    return toggle
end

--[[

# Thank you

]]
