-- Demon Hub UI Library (Compact + Draggable + Open/Close Button)
-- Fixed drag (works on PC & mobile)
-- Version 1.2.0

local DemonHub = {}
DemonHub.Version = "v1.2.0"

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DemonHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

-- Open / Close Button
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 38, 0, 38)
OpenButton.Position = UDim2.new(0, 10, 0, 10)
OpenButton.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
OpenButton.Text = "☰"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 20
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner", OpenButton)
OpenCorner.CornerRadius = UDim.new(0, 8)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 240)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

-- Custom Draggable Function
local dragging = false
local dragStart, startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		updateDrag(input)
	end
end)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 90, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner", Sidebar)
SidebarCorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Text = "Demon Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 24)
Title.Position = UDim2.new(0, 0, 0, 4)
Title.Parent = Sidebar

local Version = Instance.new("TextLabel")
Version.Text = DemonHub.Version
Version.Font = Enum.Font.Gotham
Version.TextSize = 10
Version.TextColor3 = Color3.fromRGB(170, 170, 170)
Version.BackgroundTransparency = 1
Version.Position = UDim2.new(0, 0, 0, 22)
Version.Size = UDim2.new(1, 0, 0, 16)
Version.Parent = Sidebar

-- Tabs
local TabList = Instance.new("Frame")
TabList.Size = UDim2.new(1, 0, 1, -50)
TabList.Position = UDim2.new(0, 0, 0, 45)
TabList.BackgroundTransparency = 1
TabList.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 4)
TabListLayout.Parent = TabList

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -90, 1, 0)
TabContainer.Position = UDim2.new(0, 90, 0, 0)
TabContainer.BackgroundColor3 = Color3.fromRGB(32, 34, 42)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

-- Window System
function DemonHub:CreateWindow(props)
	local Window = {}
	Window.Tabs = {}

	function Window:AddTab(info)
		local TabButton = Instance.new("TextButton")
		TabButton.Text = info.Title or "Tab"
		TabButton.Size = UDim2.new(1, -10, 0, 26)
		TabButton.Position = UDim2.new(0, 5, 0, 0)
		TabButton.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.Font = Enum.Font.GothamSemibold
		TabButton.TextSize = 12
		TabButton.AutoButtonColor = false
		TabButton.Parent = TabList

		local TabFrame = Instance.new("ScrollingFrame")
		TabFrame.Size = UDim2.new(1, -10, 1, -10)
		TabFrame.Position = UDim2.new(0, 5, 0, 5)
		TabFrame.BackgroundTransparency = 1
		TabFrame.ScrollBarThickness = 4
		TabFrame.Visible = false
		TabFrame.Parent = TabContainer

		local Layout = Instance.new("UIListLayout")
		Layout.Padding = UDim.new(0, 6)
		Layout.Parent = TabFrame

		local Tab = {}
		Tab.Frame = TabFrame

		function Tab:AddButton(data)
			local Button = Instance.new("TextButton")
			Button.Size = UDim2.new(1, -6, 0, 28)
			Button.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
			Button.Text = data.Title or "Button"
			Button.Font = Enum.Font.GothamBold
			Button.TextSize = 12
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.Parent = TabFrame
			local Corner = Instance.new("UICorner", Button)
			Corner.CornerRadius = UDim.new(0, 6)
			Button.MouseButton1Click:Connect(data.Callback or function() end)
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

	return Window
end

-- Open / Close
local open = true
OpenButton.MouseButton1Click:Connect(function()
	open = not open
	if open then
		MainFrame.Visible = true
		TweenService:Create(MainFrame, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
	else
		TweenService:Create(MainFrame, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
		task.wait(0.2)
		MainFrame.Visible = false
	end
end)

return DemonHub
