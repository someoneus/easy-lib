function easy:CreateWindow(name, x, y)
gui = Instance.new("ScreenGui")
  gui.Parent = game:GetService("CoreGui")
  window = Instance.new("Frame")
  window.Parent = gui
  window.Size = UDim2.new(x, 0, y, 0)
  window.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
  local ui = Instance.new("UIStroke")
  ui.Parent = window
  ui.Thickness = 3
  ui.Transparency = 0.35
  ui.Color = Color3.fromRGB(200, 0, 0)
  local title = Instance.new("TextLabel")
  title.Parent = window
  title.Size = UDim2.new(0.6, 0, 0.1, 0)
  title.TextColor3 = Color3.fromRGB(255, 255, 255)
  title.BackgroundTransparency = 1
  title.Text = name
  title.TextScaled = true
  title.Font = Enum.Font.Code
end
