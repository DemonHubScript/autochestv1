-- Demon Hub UI Library
-- Version 1.0.0
-- Custom Fluent-style UI by ChatGPT

local DemonHub = {}
DemonHub.Version = "v1.0.0"

local TweenService = game:GetService("TweenService")

-- Create UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DemonHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 760, 0, 520)
MainFrame.Position = UDim2.new(0.5, -380, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner", Sidebar)
SidebarCorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Text = "Demon Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 6)
Title.Parent = Sidebar

local Version = Instance.new("TextLabel")
Version.Text = DemonHub.Version
Version.Font = Enum.Font.Gotham
Version.TextSize = 12
Version.TextColor3 = Color3.fromRGB(170, 170, 170)
Version.BackgroundTransparency = 1
Version.Position = UDim2.new(0, 0, 0, 28)
Version.Size = UDim2.new(1, 0, 0, 20)
Version.Parent = Sidebar

-- Tabs
local TabList = Instance.new("Frame")
TabList.Size = UDim2.new(1, 0, 1, -60)
TabList.Position = UDim2.new(0, 0, 0, 60)
TabList.BackgroundTransparency = 1
TabList.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.Parent = TabList

-- Right Side
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -160, 1, 0)
TabContainer.Position = UDim2.new(0, 160, 0, 0)
TabContainer.BackgroundColor3 = Color3.fromRGB(32, 34, 42)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local Tabs = {}

-- Functions
function DemonHub:CreateWindow(props)
    local Window = {}
    Window.Tabs = {}

    function Window:AddTab(info)
        local TabButton = Instance.new("TextButton")
        TabButton.Text = info.Title or "Tab"
        TabButton.Size = UDim2.new(1, -10, 0, 36)
        TabButton.Position = UDim2.new(0, 5, 0, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.TextSize = 14
        TabButton.AutoButtonColor = false
        TabButton.Parent = TabList

        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Size = UDim2.new(1, -20, 1, -20)
        TabFrame.Position = UDim2.new(0, 10, 0, 10)
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.ScrollBarThickness = 6
        TabFrame.Visible = false
        TabFrame.Parent = TabContainer

        local Layout = Instance.new("UIListLayout")
        Layout.Padding = UDim.new(0, 10)
        Layout.Parent = TabFrame

        local Tab = {}
        Tab.Frame = TabFrame

        -- Paragraph
        function Tab:AddParagraph(data)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -10, 0, 70)
            Frame.BackgroundColor3 = Color3.fromRGB(40, 42, 50)
            Frame.Parent = TabFrame

            local Corner = Instance.new("UICorner", Frame)
            Corner.CornerRadius = UDim.new(0, 6)

            local Title = Instance.new("TextLabel")
            Title.Text = data.Title or "Title"
            Title.Font = Enum.Font.GothamBold
            Title.TextSize = 14
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1
            Title.Size = UDim2.new(1, -10, 0, 20)
            Title.Position = UDim2.new(0, 10, 0, 5)
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = Frame

            local Content = Instance.new("TextLabel")
            Content.Text = data.Content or ""
            Content.Font = Enum.Font.Gotham
            Content.TextSize = 13
            Content.TextColor3 = Color3.fromRGB(200, 200, 200)
            Content.BackgroundTransparency = 1
            Content.Size = UDim2.new(1, -10, 1, -25)
            Content.Position = UDim2.new(0, 10, 0, 25)
            Content.TextWrapped = true
            Content.TextXAlignment = Enum.TextXAlignment.Left
            Content.TextYAlignment = Enum.TextYAlignment.Top
            Content.Parent = Frame
        end

        -- Button
        function Tab:AddButton(data)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -10, 0, 40)
            Button.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
            Button.Text = data.Title or "Button"
            Button.Font = Enum.Font.GothamBold
            Button.TextSize = 14
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Parent = TabFrame
            local Corner = Instance.new("UICorner", Button)
            Corner.CornerRadius = UDim.new(0, 6)
            Button.MouseButton1Click:Connect(data.Callback or function() end)
        end

        -- Toggle
        function Tab:AddToggle(name, data)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -10, 0, 36)
            Frame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
            Frame.Parent = TabFrame

            local Corner = Instance.new("UICorner", Frame)
            Corner.CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Text = data.Title or "Toggle"
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1, -50, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame

            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(0, 32, 0, 16)
            Toggle.Position = UDim2.new(1, -50, 0.5, -8)
            Toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Toggle.Text = ""
            Toggle.AutoButtonColor = false
            Toggle.Parent = Frame

            local Circle = Instance.new("Frame")
            Circle.Size = UDim2.new(0, 12, 0, 12)
            Circle.Position = UDim2.new(0, 2, 0.5, -6)
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.Parent = Toggle
            local CircleCorner = Instance.new("UICorner", Circle)
            CircleCorner.CornerRadius = UDim.new(1, 0)

            local TCorner = Instance.new("UICorner", Toggle)
            TCorner.CornerRadius = UDim.new(1, 0)

            local state = data.Default or false

            local function update()
                TweenService:Create(Toggle, TweenInfo.new(0.25), {
                    BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(70, 70, 70)
                }):Play()
                TweenService:Create(Circle, TweenInfo.new(0.25), {
                    Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
                }):Play()
            end

            update()

            Toggle.MouseButton1Click:Connect(function()
                state = not state
                update()
                if data.Callback then
                    data.Callback(state)
                end
            end)

            return {
                Value = state,
                OnChanged = function(func)
                    data.Callback = func
                end
            }
        end

        -- Input
        function Tab:AddInput(name, data)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -10, 0, 40)
            Frame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
            Frame.Parent = TabFrame

            local Corner = Instance.new("UICorner", Frame)
            Corner.CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Text = data.Title or "Input"
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(0.5, 0, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame

            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(0.45, 0, 0.7, 0)
            Box.Position = UDim2.new(0.5, 0, 0.15, 0)
            Box.Text = data.Default or ""
            Box.PlaceholderText = "Enter text..."
            Box.Font = Enum.Font.Gotham
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Box.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
            Box.Parent = Frame
            local BoxCorner = Instance.new("UICorner", Box)
            BoxCorner.CornerRadius = UDim.new(0, 6)

            Box.FocusLost:Connect(function()
                if data.Callback then
                    data.Callback(Box.Text)
                end
            end)
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            TabFrame.Visible = true
        end)

        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then
            TabFrame.Visible = true
        end

        return Tab
    end

    function Window:SelectTab(index)
        for i, tab in ipairs(Window.Tabs) do
            tab.Frame.Visible = (i == index)
        end
    end

    return Window
end

return DemonHub
