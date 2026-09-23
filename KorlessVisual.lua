-- ==========================================
-- MAIN SERVICES & VARIABLES
-- ==========================================
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local VisualKorless = Instance.new("ScreenGui")
VisualKorless.Name = "VisualKorless"
VisualKorless.DisplayOrder = 99
VisualKorless.ResetOnSpawn = false
VisualKorless.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
VisualKorless.Parent = playerGui

local onLoadingFinished = Instance.new("BindableEvent")
local onKorlessClicked = Instance.new("BindableEvent")
local onHeadlessClicked = Instance.new("BindableEvent")
local onKorbloxClicked = Instance.new("BindableEvent")
local triggerNotif = Instance.new("BindableEvent")
local updateButtonState = Instance.new("BindableEvent")

local function RunScope(namaScope, fungsiScope)
	task.spawn(function()
		local success, errorMsg = xpcall(fungsiScope, function(err)
			return "Error di [" .. namaScope .. "]: " .. tostring(err) .. "\n" .. debug.traceback()
		end)
		if not success then warn(errorMsg) end
	end)
end

-- ==========================================
-- SCOPE 1 : UI 1
-- ==========================================
local function Scope_UI1()
	local Loading = Instance.new("CanvasGroup")
	Loading.Name = "Loading"
	Loading.BorderSizePixel = 1
	Loading.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Loading.AnchorPoint = Vector2.new(0.50, 0.50)
	Loading.Size = UDim2.new(0.22, 0.00, 0.24, 0.00)
	Loading.BorderColor3 = Color3.new(0.40, 0.40, 0.40)
	Loading.BackgroundTransparency = 0 
	Loading.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
	Loading.Visible = false 
	Loading.Parent = VisualKorless

	local LoadingGradient = Instance.new("UIGradient")
	LoadingGradient.Name = "LoadingGradient"
	LoadingGradient.Enabled = false
	LoadingGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, 0.00, 0.00), 
		NumberSequenceKeypoint.new(0.30, 0.00, 0.00), 
		NumberSequenceKeypoint.new(0.60, 1.00, 0.00), 
		NumberSequenceKeypoint.new(1.00, 1.00, 0.00)
	})
	LoadingGradient.Offset = Vector2.new(-1.00, 0.00)
	LoadingGradient.Rotation = 45
	LoadingGradient.Parent = Loading

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.AnchorPoint = Vector2.new(0.50, 0.50)
	MainFrame.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
	MainFrame.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	MainFrame.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
	MainFrame.BorderSizePixel = 0
	MainFrame.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	MainFrame.Parent = Loading

	local UIGradient1 = Instance.new("UIGradient")
	UIGradient1.Name = "UIGradient1"
	UIGradient1.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.new(0.10, 0.10, 0.10)), 
		ColorSequenceKeypoint.new(1.00, Color3.new(0.29, 0.29, 0.29))
	})
	UIGradient1.Rotation = -90
	UIGradient1.Parent = MainFrame

	local Title = Instance.new("Frame")
	Title.Name = "Title"
	Title.ClipsDescendants = true
	Title.AnchorPoint = Vector2.new(0.0, 0.00)
	Title.Size = UDim2.new(1.00, 0.00, 0.27, 0.00)
	Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Title.Position = UDim2.new(0.0, 0.00, 0.15, 0.00)
	Title.BorderSizePixel = 0
	Title.ZIndex = 2
	Title.BackgroundTransparency = 1
	Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Title.Parent = MainFrame

	local Title_1 = Instance.new("TextLabel")
	Title_1.Name = "Title"
	Title_1.TextWrapped = true
	Title_1.BorderSizePixel = 0
	Title_1.TextScaled = true
	Title_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Title_1.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title_1.AnchorPoint = Vector2.new(0.00, 0.00)
	Title_1.TextSize = 14
	Title_1.Size = UDim2.new(1.00, 0.00, 0.80, 0.00)
	Title_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Title_1.Text = "Visual Korless"
	Title_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
	Title_1.BackgroundTransparency = 1
	Title_1.Position = UDim2.new(0.00, 0.00, 0.00, 0.00)
	Title_1.Parent = Title

	local Desc = Instance.new("TextLabel")
	Desc.Name = "Desc"
	Desc.TextWrapped = true
	Desc.BorderSizePixel = 0
	Desc.TextScaled = true
	Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Desc.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Desc.AnchorPoint = Vector2.new(0.00, 1.00)
	Desc.TextSize = 14
	Desc.Size = UDim2.new(1.00, 0.00, 0.30, 0.00)
	Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Desc.Text = "- Improve ur look with this visual -"
	Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
	Desc.BackgroundTransparency = 1
	Desc.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
	Desc.Parent = Title

	local LoadingBar = Instance.new("Frame")
	LoadingBar.Name = "LoadingBar"
	LoadingBar.AnchorPoint = Vector2.new(0.00, 0.50)
	LoadingBar.Size = UDim2.new(1.00, 0.00, 0.10, 0.00)
	LoadingBar.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	LoadingBar.Position = UDim2.new(0.00, 0.00, 0.65, 0.00)
	LoadingBar.BorderSizePixel = 0
	LoadingBar.ZIndex = 2
	LoadingBar.BackgroundTransparency = 1
	LoadingBar.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	LoadingBar.Parent = MainFrame

	local LoadingText = Instance.new("TextLabel")
	LoadingText.Name = "LoadingText"
	LoadingText.TextWrapped = true
	LoadingText.BorderSizePixel = 0
	LoadingText.TextScaled = true
	LoadingText.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	LoadingText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	LoadingText.AnchorPoint = Vector2.new(0.50, 0.00)
	LoadingText.TextXAlignment = Enum.TextXAlignment.Left
	LoadingText.TextSize = 14
	LoadingText.Size = UDim2.new(0.64, 0.00, 0.67, 0.00)
	LoadingText.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	LoadingText.Text = "Loading..."
	LoadingText.TextColor3 = Color3.new(1.00, 1.00, 1.00)
	LoadingText.BackgroundTransparency = 1
	LoadingText.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
	LoadingText.Parent = LoadingBar

	local Line = Instance.new("CanvasGroup")
	Line.Name = "Line"
	Line.BorderSizePixel = 0
	Line.BackgroundColor3 = Color3.new(0.29, 0.29, 0.29)
	Line.AnchorPoint = Vector2.new(0.50, 1.00)
	Line.Size = UDim2.new(0.66, 0.00, 0.20, 0.00)
	Line.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Line.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
	Line.Parent = LoadingBar

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1.00, 0.00)
	UICorner.Parent = Line

	local Fill = Instance.new("Frame")
	Fill.Name = "Fill"
	Fill.AnchorPoint = Vector2.new(0.00, 0.50)
	Fill.Size = UDim2.new(0.50, 0.00, 1.00, 0.00)
	Fill.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Fill.Position = UDim2.new(0.00, 0.00, 0.50, 0.00)
	Fill.BorderSizePixel = 0
	Fill.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Fill.Parent = Line

	local UIGradient2 = Instance.new("UIGradient")
	UIGradient2.Name = "UIGradient2"
	UIGradient2.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.new(0.00, 0.00, 1.00)), 
		ColorSequenceKeypoint.new(1.00, Color3.new(0.00, 1.00, 1.00))
	})
	UIGradient2.Parent = Fill

	local Credit = Instance.new("Frame")
	Credit.Name = "Credit"
	Credit.AnchorPoint = Vector2.new(0.50, 1.00)
	Credit.Size = UDim2.new(0.92, 0.00, 0.13, 0.00)
	Credit.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Credit.Position = UDim2.new(0.50, 0.00, 0.95, 0.00)
	Credit.BorderSizePixel = 0
	Credit.ZIndex = 2
	Credit.BackgroundTransparency = 1
	Credit.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Credit.Parent = MainFrame

	local Credit_1 = Instance.new("TextLabel")
	Credit_1.Name = "Credit"
	Credit_1.TextWrapped = true
	Credit_1.BorderSizePixel = 0
	Credit_1.TextScaled = true
	Credit_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Credit_1.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Credit_1.AnchorPoint = Vector2.new(1.00, 1.00)
	Credit_1.TextXAlignment = Enum.TextXAlignment.Right
	Credit_1.TextSize = 14
	Credit_1.Size = UDim2.new(0.65, 0.00, 0.50, 0.00)
	Credit_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Credit_1.Text = "Developed by Honami"
	Credit_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
	Credit_1.BackgroundTransparency = 1
	Credit_1.Position = UDim2.new(1.00, 0.00, 1.00, 0.00)
	Credit_1.Parent = Credit

	local Version = Instance.new("TextLabel")
	Version.Name = "Version"
	Version.TextWrapped = true
	Version.BorderSizePixel = 0
	Version.TextScaled = true
	Version.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Version.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Version.AnchorPoint = Vector2.new(1.00, 0.00)
	Version.TextXAlignment = Enum.TextXAlignment.Right
	Version.TextSize = 14
	Version.Size = UDim2.new(0.65, 0.00, 0.50, 0.00)
	Version.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Version.Text = "Version 4.0"
	Version.TextColor3 = Color3.new(1.00, 1.00, 1.00)
	Version.BackgroundTransparency = 1
	Version.Position = UDim2.new(1.00, 0.00, 0.00, 0.00)
	Version.Parent = Credit

	local Gradient = Instance.new("Frame")
	Gradient.Name = "Gradient"
	Gradient.AnchorPoint = Vector2.new(0.50, 0.50)
	Gradient.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
	Gradient.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
	Gradient.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
	Gradient.BorderSizePixel = 0
	Gradient.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
	Gradient.Parent = MainFrame

	local UIGradient3 = Instance.new("UIGradient")
	UIGradient3.Name = "UIGradient3"
	UIGradient3.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, 1.00, 0.00), 
		NumberSequenceKeypoint.new(0.50, 1.00, 0.00), 
		NumberSequenceKeypoint.new(0.50, 0.00, 0.00), 
		NumberSequenceKeypoint.new(1.00, 0.00, 0.00)
	})
	UIGradient3.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.new(0.00, 0.00, 0.00)), 
		ColorSequenceKeypoint.new(1.00, Color3.new(0.20, 0.20, 0.20))
	})
	UIGradient3.Rotation = 60
	UIGradient3.Parent = Gradient

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.AspectRatio = 1.7000000476837158
	UIAspectRatioConstraint.Parent = Loading

	LoadingGradient.Enabled = true
	LoadingGradient.Offset = Vector2.new(-1, 0)
	LoadingGradient.Rotation = 45 

	UIGradient3.Offset = Vector2.new(1, 0) 
	Title.AnchorPoint = Vector2.new(1, 0) 
	Desc.AnchorPoint = Vector2.new(1, 1)
	LoadingBar.AnchorPoint = Vector2.new(1, 0.5)
	Version.AnchorPoint = Vector2.new(0, 0)
	Credit_1.AnchorPoint = Vector2.new(0, 1)
	Fill.Size = UDim2.new(0, 0, 1, 0)

	local function tween(obj, time, props)
		local tw = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
		tw:Play()
		return tw
	end

	task.wait(1.0) 
	Loading.Visible = true

	tween(LoadingGradient, 1.0, {Offset = Vector2.new(1, 0)})
	tween(UIGradient3, 1.0, {Offset = Vector2.new(0, 0)}) 
	tween(Title, 1.0, {AnchorPoint = Vector2.new(0, 0)})

	task.wait(0.2) 
	tween(Desc, 1.0, {AnchorPoint = Vector2.new(0, 1)})

	task.wait(0.2) 
	LoadingGradient.Enabled = false
	LoadingGradient.Offset = Vector2.new(1, 0)
	tween(LoadingBar, 1.0, {AnchorPoint = Vector2.new(0, 0.5)})

	task.wait(0.2) 
	tween(Version, 1.0, {AnchorPoint = Vector2.new(1, 0)})

	task.wait(0.2) 
	tween(Credit_1, 1.0, {AnchorPoint = Vector2.new(1, 1)})

	task.wait(0.5) 

	local function stutterLoading()
		tween(Fill, 0.8, {Size = UDim2.new(0.3, 0, 1, 0)})
		task.wait(1.0) 
		tween(Fill, 0.6, {Size = UDim2.new(0.65, 0, 1, 0)})
		task.wait(0.8) 
		tween(Fill, 0.4, {Size = UDim2.new(0.9, 0, 1, 0)})
		task.wait(0.5) 
		tween(Fill, 0.4, {Size = UDim2.new(1, 0, 1, 0)})
	end
	stutterLoading()

	task.wait(0.5)
	LoadingText.Text = "Complete"

	task.wait(0.5)
	LoadingGradient.Enabled = true
	tween(LoadingGradient, 1.0, {Offset = Vector2.new(-1, 0)}) 

	task.wait(1.0)
	Loading.Visible = false
	
	onLoadingFinished:Fire()
end

-- ==========================================
-- SCOPE 2 : BUTTON UI (SMART DETECT DEVICE)
-- ==========================================
local function Scope_UI2()
	onLoadingFinished.Event:Wait()

	local UserInputService = game:GetService("UserInputService")
	local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

	if isMobile then
		-- ==========================================
		-- TAMPILAN MOBILE (Simpel & Minimalis)
		-- ==========================================
		local mobileBtn = Instance.new("TextButton")
		mobileBtn.Name = "MobileExecuteBtn"
		mobileBtn.AnchorPoint = Vector2.new(0, 1)
		mobileBtn.Size = UDim2.new(0, 100, 0, 20)
		mobileBtn.Position = UDim2.new(0, 0, 1, 0)
		mobileBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		mobileBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		mobileBtn.Font = Enum.Font.Nunito
		mobileBtn.TextSize = 14
		mobileBtn.Text = "Execute"
		mobileBtn.BorderSizePixel = 0
		mobileBtn.Parent = VisualKorless

		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 4)
		uiCorner.Parent = mobileBtn

		local uiStroke = Instance.new("UIStroke")
		uiStroke.Color = Color3.fromRGB(150, 150, 150)
		uiStroke.Thickness = 1
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Parent = mobileBtn

		mobileBtn.MouseButton1Click:Connect(function() 
			onKorlessClicked:Fire() 
		end)

		updateButtonState.Event:Connect(function(btnName, newText)
			if btnName == "Korless" then 
				mobileBtn.Text = newText
			end
		end)

	else
		-- ==========================================
		-- TAMPILAN DESKTOP (3 Tombol + Animasi)
		-- ==========================================
		local MainFrame = Instance.new("Frame")
		MainFrame.Name = "MainFrame"
		MainFrame.AnchorPoint = Vector2.new(0.00, 1.00)
		MainFrame.Size = UDim2.new(0.00, 100.00, 0.00, 120.00)
		MainFrame.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		MainFrame.Position = UDim2.new(0.00, 0.00, 1.00, -10.00)
		MainFrame.BorderSizePixel = 0
		MainFrame.BackgroundTransparency = 1
		MainFrame.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		MainFrame.Parent = VisualKorless

		local Korless = Instance.new("Frame")
		Korless.Name = "Korless"
		Korless.AnchorPoint = Vector2.new(1.00, 0.00)
		Korless.Size = UDim2.new(0.95, 0.00, 0.30, 0.00)
		Korless.Position = UDim2.new(0.00, 0.00, 0.00, 0.00)
		Korless.BorderSizePixel = 0
		Korless.BackgroundTransparency = 1
		Korless.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Korless.Parent = MainFrame

		local KorlessButton = Instance.new("ImageButton")
		KorlessButton.Name = "KorlessButton"
		KorlessButton.BorderSizePixel = 0
		KorlessButton.BackgroundColor3 = Color3.new(0.20, 0.20, 0.20)
		KorlessButton.AnchorPoint = Vector2.new(0.50, 1.00)
		KorlessButton.Size = UDim2.new(0.90, 0.00, 0.55, 0.00)
		KorlessButton.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
		KorlessButton.Parent = Korless
		Instance.new("UICorner", KorlessButton).CornerRadius = UDim.new(1.00, 0.00)

		local ExecuteText1 = Instance.new("TextLabel")
		ExecuteText1.Name = "ExecuteText1"
		ExecuteText1.TextWrapped = true
		ExecuteText1.BorderSizePixel = 0
		ExecuteText1.TextScaled = true
		ExecuteText1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ExecuteText1.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		ExecuteText1.AnchorPoint = Vector2.new(0.50, 0.00)
		ExecuteText1.TextSize = 14
		ExecuteText1.Size = UDim2.new(1.00, 0.00, 0.90, 0.00)
		ExecuteText1.Text = "Execute"
		ExecuteText1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ExecuteText1.BackgroundTransparency = 1
		ExecuteText1.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		ExecuteText1.Parent = KorlessButton

		local UIStroke1 = Instance.new("UIStroke", KorlessButton)
		UIStroke1.Color = Color3.new(0.59, 0.59, 0.59)
		UIStroke1.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		UIStroke1.Thickness = 0.04

		local KorlessText = Instance.new("TextLabel")
		KorlessText.Name = "KorlessText"
		KorlessText.TextWrapped = true
		KorlessText.TextStrokeTransparency = 0.5
		KorlessText.BorderSizePixel = 0
		KorlessText.TextScaled = true
		KorlessText.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		KorlessText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		KorlessText.TextSize = 14
		KorlessText.Size = UDim2.new(1.00, 0.00, 0.40, 0.00)
		KorlessText.Text = "Korless"
		KorlessText.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		KorlessText.BackgroundTransparency = 1
		KorlessText.Parent = Korless

		local Headless = Instance.new("Frame")
		Headless.Name = "Headless"
		Headless.AnchorPoint = Vector2.new(1.00, 0.50)
		Headless.Size = UDim2.new(0.95, 0.00, 0.30, 0.00)
		Headless.Position = UDim2.new(0.00, 0.00, 0.50, 0.00)
		Headless.BorderSizePixel = 0
		Headless.BackgroundTransparency = 1
		Headless.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Headless.Parent = MainFrame

		local HeadlessButton = Instance.new("ImageButton")
		HeadlessButton.Name = "HeadlessButton"
		HeadlessButton.BorderSizePixel = 0
		HeadlessButton.BackgroundColor3 = Color3.new(0.20, 0.20, 0.20)
		HeadlessButton.AnchorPoint = Vector2.new(0.50, 1.00)
		HeadlessButton.Size = UDim2.new(0.90, 0.00, 0.55, 0.00)
		HeadlessButton.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
		HeadlessButton.Parent = Headless
		Instance.new("UICorner", HeadlessButton).CornerRadius = UDim.new(1.00, 0.00)

		local ExecuteText2 = Instance.new("TextLabel")
		ExecuteText2.Name = "ExecuteText2"
		ExecuteText2.TextWrapped = true
		ExecuteText2.BorderSizePixel = 0
		ExecuteText2.TextScaled = true
		ExecuteText2.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ExecuteText2.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		ExecuteText2.AnchorPoint = Vector2.new(0.50, 0.00)
		ExecuteText2.TextSize = 14
		ExecuteText2.Size = UDim2.new(1.00, 0.00, 0.90, 0.00)
		ExecuteText2.Text = "Execute"
		ExecuteText2.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ExecuteText2.BackgroundTransparency = 1
		ExecuteText2.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		ExecuteText2.Parent = HeadlessButton

		local UIStroke2 = Instance.new("UIStroke", HeadlessButton)
		UIStroke2.Color = Color3.new(0.59, 0.59, 0.59)
		UIStroke2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		UIStroke2.Thickness = 0.04

		local HeadlessText = Instance.new("TextLabel")
		HeadlessText.Name = "HeadlessText"
		HeadlessText.TextWrapped = true
		HeadlessText.TextStrokeTransparency = 0.5
		HeadlessText.BorderSizePixel = 0
		HeadlessText.TextScaled = true
		HeadlessText.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		HeadlessText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		HeadlessText.TextSize = 14
		HeadlessText.Size = UDim2.new(1.00, 0.00, 0.40, 0.00)
		HeadlessText.Text = "Headless Only"
		HeadlessText.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		HeadlessText.BackgroundTransparency = 1
		HeadlessText.Parent = Headless

		local Korblox = Instance.new("Frame")
		Korblox.Name = "Korblox"
		Korblox.AnchorPoint = Vector2.new(1.00, 1.00)
		Korblox.Size = UDim2.new(0.95, 0.00, 0.30, 0.00)
		Korblox.Position = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Korblox.BorderSizePixel = 0
		Korblox.BackgroundTransparency = 1
		Korblox.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Korblox.Parent = MainFrame

		local KorbloxButton = Instance.new("ImageButton")
		KorbloxButton.Name = "KorbloxButton"
		KorbloxButton.BorderSizePixel = 0
		KorbloxButton.BackgroundColor3 = Color3.new(0.20, 0.20, 0.20)
		KorbloxButton.AnchorPoint = Vector2.new(0.50, 1.00)
		KorbloxButton.Size = UDim2.new(0.90, 0.00, 0.55, 0.00)
		KorbloxButton.Position = UDim2.new(0.50, 0.00, 1.00, 0.00)
		KorbloxButton.Parent = Korblox
		Instance.new("UICorner", KorbloxButton).CornerRadius = UDim.new(1.00, 0.00)

		local ExecuteText3 = Instance.new("TextLabel")
		ExecuteText3.Name = "ExecuteText3"
		ExecuteText3.TextWrapped = true
		ExecuteText3.BorderSizePixel = 0
		ExecuteText3.TextScaled = true
		ExecuteText3.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ExecuteText3.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		ExecuteText3.AnchorPoint = Vector2.new(0.50, 0.00)
		ExecuteText3.TextSize = 14
		ExecuteText3.Size = UDim2.new(1.00, 0.00, 0.90, 0.00)
		ExecuteText3.Text = "Execute"
		ExecuteText3.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ExecuteText3.BackgroundTransparency = 1
		ExecuteText3.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		ExecuteText3.Parent = KorbloxButton

		local UIStroke3 = Instance.new("UIStroke", KorbloxButton)
		UIStroke3.Color = Color3.new(0.59, 0.59, 0.59)
		UIStroke3.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		UIStroke3.Thickness = 0.04

		local KorbloxText = Instance.new("TextLabel")
		KorbloxText.Name = "KorbloxText"
		KorbloxText.TextWrapped = true
		KorbloxText.TextStrokeTransparency = 0.5
		KorbloxText.BorderSizePixel = 0
		KorbloxText.TextScaled = true
		KorbloxText.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		KorbloxText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		KorbloxText.TextSize = 14
		KorbloxText.Size = UDim2.new(1.00, 0.00, 0.40, 0.00)
		KorbloxText.Text = "Korblox Only"
		KorbloxText.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		KorbloxText.BackgroundTransparency = 1
		KorbloxText.Parent = Korblox

		-- Animasi Masuk (Desktop)
		local tInfo = TweenService:Create(Korless, TweenInfo.new(1.0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1.00, 0.00, 0.00, 0.00)})
		tInfo:Play()
		task.wait(0.2)

		local tInfo2 = TweenService:Create(Headless, TweenInfo.new(1.0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1.00, 0.00, 0.50, 0.00)})
		tInfo2:Play()
		task.wait(0.2)

		local tInfo3 = TweenService:Create(Korblox, TweenInfo.new(1.0, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1.00, 0.00, 1.00, 0.00)})
		tInfo3:Play()

		-- Click Listeners
		KorlessButton.MouseButton1Click:Connect(function() onKorlessClicked:Fire() end)
		HeadlessButton.MouseButton1Click:Connect(function() onHeadlessClicked:Fire() end)
		KorbloxButton.MouseButton1Click:Connect(function() onKorbloxClicked:Fire() end)

		-- Update Text Listener (Desktop)
		updateButtonState.Event:Connect(function(btnName, newText)
			if btnName == "Korless" then ExecuteText1.Text = newText
			elseif btnName == "Headless" then ExecuteText2.Text = newText
			elseif btnName == "Korblox" then ExecuteText3.Text = newText
			end
		end)
	end
end

-- ==========================================
-- SCOPE 3 : NOTIFICATION UI
-- ==========================================
local function Scope_UI3()
	onLoadingFinished.Event:Wait()

	local NotifContainer = Instance.new("Frame")
	NotifContainer.Name = "NotifContainer"
	NotifContainer.Size = UDim2.new(0.175, 0, 0.03, 0)
	NotifContainer.AnchorPoint = Vector2.new(0.5, 0)
	NotifContainer.Position = UDim2.new(0.5, 0, 0.1, 0) 
	NotifContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	NotifContainer.BackgroundTransparency = 1
	NotifContainer.Parent = VisualKorless
	Instance.new("UICorner", NotifContainer).CornerRadius = UDim.new(1, 0)

	local NotifText = Instance.new("TextLabel")
	NotifText.Size = UDim2.new(1, 0, 0.75, 0)
    NotifText.AnchorPoint = Vector2.new(0.5, 0.5)
    NotifText.Position = UDim2.new(0.5, 0, 0.5, 0)
	NotifText.BackgroundTransparency = 1
	NotifText.Font = Enum.Font.Gotham
    NotifText.TextScaled = true
	NotifText.TextSize = 14
    NotifText.RichText = true
	NotifText.TextTransparency = 1
	NotifText.Parent = NotifContainer

	triggerNotif.Event:Connect(function(msg, isError)
		NotifText.Text = msg
		if isError then
			NotifText.TextColor3 = Color3.fromRGB(255, 80, 80)
		else
			NotifText.TextColor3 = Color3.fromRGB(80, 255, 100)
		end

		local tIn = TweenService:Create(NotifContainer, TweenInfo.new(0.3), {Position = UDim2.new(0.5, 0, 0, 20), BackgroundTransparency = 0.2})
		local tTextIn = TweenService:Create(NotifText, TweenInfo.new(0.3), {TextTransparency = 0})
		tIn:Play() tTextIn:Play()

		task.wait(2.5)

		local tOut = TweenService:Create(NotifContainer, TweenInfo.new(0.3), {Position = UDim2.new(0.5, 0, 0, -50), BackgroundTransparency = 1})
		local tTextOut = TweenService:Create(NotifText, TweenInfo.new(0.3), {TextTransparency = 1})
		tOut:Play() tTextOut:Play()
	end)
end

-- ==========================================
-- SCOPE 4 : LOGIC SWAP
-- ==========================================
local function Scope_Logic4()
	local TARGET_USERNAME = "honamichandesu"
	local avatarDescription = nil
	local isProcessing = false

	local function sendNotif(msg, isError)
		triggerNotif:Fire(msg, isError)
	end

	local function smartFind(parentObject, nameToFind)
		if not parentObject then return nil end
		return parentObject:FindFirstChild(nameToFind, true)
	end

	local function hilangkanKepala(rigTarget)
		if not rigTarget then return end
		local head = rigTarget:FindFirstChild("Head")
		if head then
			head.Transparency = 1
			local face = head:FindFirstChild("face") or head:FindFirstChild("Decal")
			if face then face:Destroy() end
		end
	end

	local function doHeadless()
		local rigsFolder = workspace:FindFirstChild("Rigs")
		local myRig = rigsFolder and rigsFolder:FindFirstChild(player.Name)
		
		hilangkanKepala(myRig)
		hilangkanKepala(player.Character)
	end

	local function initVisuals()
		local successId, userId = pcall(function() return Players:GetUserIdFromNameAsync(TARGET_USERNAME) end)
		if not successId then return sendNotif("<b>Failed:</b> Failed to find UserId.", true) end

		local successDesc, description = pcall(function() return Players:GetHumanoidDescriptionFromUserId(userId) end)
		if not successDesc then return sendNotif("<b>Failed:</b> Failed to fetch Avatar data.", true) end
		
		avatarDescription = description

		local farCFrame = CFrame.new(2048, 100, 0)

		local spawnedR15 = Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R15)
		spawnedR15.Name = TARGET_USERNAME .. "_Visual_R15"
		spawnedR15.Parent = workspace
		spawnedR15:PivotTo(farCFrame)
		if spawnedR15:FindFirstChild("HumanoidRootPart") then
			spawnedR15.HumanoidRootPart.Anchored = true 
		end

		local spawnedR6 = Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R6)
		spawnedR6.Name = TARGET_USERNAME .. "_Visual_R6"
		spawnedR6.Parent = workspace
		spawnedR6:PivotTo(farCFrame * CFrame.new(5, 0, 0)) 
		if spawnedR6:FindFirstChild("HumanoidRootPart") then
			spawnedR6.HumanoidRootPart.Anchored = true
		end
	end

	local function runTahap1()
		local rigsFolder = workspace:FindFirstChild("Rigs")
		local myRig = rigsFolder and rigsFolder:FindFirstChild(player.Name)

		if not myRig then return false end

		local myHum = myRig:FindFirstChild("Humanoid")
		if not myHum then return false end
		
		local isR15 = myHum.RigType == Enum.HumanoidRigType.R15

		local dummyRig = Players:CreateHumanoidModelFromDescription(avatarDescription, myHum.RigType)
		dummyRig.Name = "TumbalKorblox_Tahap1"
		dummyRig.Parent = workspace 
		task.wait(0.3)
		
		local sukses = false

		if isR15 then
			local oldUpper = myRig:FindFirstChild("RightUpperLeg")
			local oldLower = myRig:FindFirstChild("RightLowerLeg")
			local oldFoot = myRig:FindFirstChild("RightFoot")

			local newUpper = dummyRig:FindFirstChild("RightUpperLeg")
			local newLower = dummyRig:FindFirstChild("RightLowerLeg")
			local newFoot = dummyRig:FindFirstChild("RightFoot")

			if oldUpper and oldLower and oldFoot and newUpper and newLower and newFoot then
				local joints = myRig:FindFirstChild("Joints")
				local rightHip = (joints and joints:FindFirstChild("RightHip")) or (myRig:FindFirstChild("LowerTorso") and myRig.LowerTorso:FindFirstChild("RightHip")) or oldUpper:FindFirstChild("RightHip")
				local rightKnee = (joints and joints:FindFirstChild("RightKnee")) or oldLower:FindFirstChild("RightKnee")
				local rightAnkle = (joints and joints:FindFirstChild("RightAnkle")) or oldFoot:FindFirstChild("RightAnkle")

				if rightHip and rightKnee and rightAnkle then
					newUpper.Parent = myRig
					newLower.Parent = myRig
					newFoot.Parent = myRig

					rightHip.Part1 = newUpper
					rightKnee.Part0 = newUpper
					rightKnee.Part1 = newLower
					rightAnkle.Part0 = newLower
					rightAnkle.Part1 = newFoot

					newUpper.Massless = true
					newLower.Massless = true
					newFoot.Massless = true

					local myColors = myRig:FindFirstChildOfClass("BodyColors")
					if myColors then
						newUpper.Color = myColors.RightLegColor3
						newLower.Color = myColors.RightLegColor3
						newFoot.Color = myColors.RightLegColor3
					end

					oldUpper:Destroy()
					oldLower:Destroy()
					oldFoot:Destroy()
					sukses = true
				end
			end
		else
			local myOldLeg = myRig:FindFirstChild("Right Leg")
			local jointsFolder = myRig:FindFirstChild("Joints")
			local rightLegMotor = jointsFolder and jointsFolder:FindFirstChild("Right Leg")
			local targetLeg = dummyRig:FindFirstChild("Right Leg")

			if myOldLeg and rightLegMotor and targetLeg then
				for _, obj in ipairs(dummyRig:GetChildren()) do
					if obj:IsA("CharacterMesh") and obj.BodyPart == Enum.BodyPart.RightLeg then
						for _, oldMesh in ipairs(myRig:GetChildren()) do
							if oldMesh:IsA("CharacterMesh") and oldMesh.BodyPart == Enum.BodyPart.RightLeg then
								oldMesh:Destroy()
							end
						end
						obj.Parent = myRig
					end
				end

				targetLeg.Parent = myRig
				rightLegMotor.Part1 = targetLeg
				targetLeg.Massless = true

				local myColors = myRig:FindFirstChildOfClass("BodyColors")
				if myColors then targetLeg.Color = myColors.RightLegColor3 end

				myOldLeg:Destroy()
				sukses = true
			end
		end

		dummyRig:Destroy()
		return sukses
	end

	local function runTahap2()
		local character = player.Character
		if not character then return false end
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then return false end

		local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
		local dummyRig = Players:CreateHumanoidModelFromDescription(avatarDescription, humanoid.RigType)
		local sukses = false

		if isR15 then
			local donorUpper = smartFind(dummyRig, "RightUpperLeg")
			local donorLower = smartFind(dummyRig, "RightLowerLeg")
			local donorFoot = smartFind(dummyRig, "RightFoot")
			
			local lowerTorso = smartFind(character, "LowerTorso")
			local oldUpper = smartFind(character, "RightUpperLeg")
			local oldLower = smartFind(character, "RightLowerLeg")
			local oldFoot = smartFind(character, "RightFoot")
			
			if donorUpper and donorLower and donorFoot and lowerTorso and oldUpper and oldLower and oldFoot then
				local newUpper = donorUpper:Clone()
				local newLower = donorLower:Clone()
				local newFoot = donorFoot:Clone()

				for _, v in ipairs(newUpper:GetDescendants()) do if v:IsA("Motor6D") then v:Destroy() end end
				for _, v in ipairs(newLower:GetDescendants()) do if v:IsA("Motor6D") then v:Destroy() end end
				for _, v in ipairs(newFoot:GetDescendants()) do if v:IsA("Motor6D") then v:Destroy() end end

				local newHip = Instance.new("Motor6D")
				newHip.Name = "RightHip"
				newHip.Part0 = lowerTorso
				newHip.Part1 = newUpper
				
				local hipAtt0 = lowerTorso:FindFirstChild("RightHipRigAttachment")
				local hipAtt1 = newUpper:FindFirstChild("RightHipRigAttachment")
				if hipAtt0 and hipAtt1 then
					newHip.C0 = hipAtt0.CFrame
					newHip.C1 = hipAtt1.CFrame
				end
				newHip.Parent = newUpper

				local newKnee = Instance.new("Motor6D")
				newKnee.Name = "RightKnee"
				newKnee.Part0 = newUpper
				newKnee.Part1 = newLower
				
				local kneeAtt0 = newUpper:FindFirstChild("RightKneeRigAttachment")
				local kneeAtt1 = newLower:FindFirstChild("RightKneeRigAttachment")
				if kneeAtt0 and kneeAtt1 then
					newKnee.C0 = kneeAtt0.CFrame
					newKnee.C1 = kneeAtt1.CFrame
				end
				newKnee.Parent = newLower

				local newAnkle = Instance.new("Motor6D")
				newAnkle.Name = "RightAnkle"
				newAnkle.Part0 = newLower
				newAnkle.Part1 = newFoot
				
				local ankleAtt0 = newLower:FindFirstChild("RightAnkleRigAttachment")
				local ankleAtt1 = newFoot:FindFirstChild("RightAnkleRigAttachment")
				if ankleAtt0 and ankleAtt1 then
					newAnkle.C0 = ankleAtt0.CFrame
					newAnkle.C1 = ankleAtt1.CFrame
				end
				newAnkle.Parent = newFoot

				newUpper.Parent = character
				newLower.Parent = character
				newFoot.Parent = character

				oldUpper:Destroy()
				oldLower:Destroy()
				oldFoot:Destroy()
				
				sukses = true
			end
		else
			local donorLeg = smartFind(dummyRig, "Right Leg")
			local torso = smartFind(character, "Torso")
			local oldLeg = smartFind(character, "Right Leg")
			
			if donorLeg and torso and oldLeg then
				local newLeg = donorLeg:Clone()
				local oldHip = smartFind(character, "Right Hip")
				
				local newHip = Instance.new("Motor6D")
				newHip.Name = "Right Hip"
				newHip.Part0 = torso
				newHip.Part1 = newLeg
				if oldHip then
					newHip.C0 = oldHip.C0
					newHip.C1 = oldHip.C1
				end
				newHip.Parent = torso
				newLeg.Parent = character
				
				for _, obj in ipairs(dummyRig:GetDescendants()) do
					if obj:IsA("CharacterMesh") and obj.BodyPart == Enum.BodyPart.RightLeg then
						for _, myObj in ipairs(character:GetDescendants()) do
							if myObj:IsA("CharacterMesh") and myObj.BodyPart == Enum.BodyPart.RightLeg then
								myObj:Destroy()
							end
						end
						obj:Clone().Parent = character
					end
				end
				
				oldLeg:Destroy()
				if oldHip then oldHip:Destroy() end
				
				sukses = true
			end
		end
		
		dummyRig:Destroy()
		return sukses
	end

	local function executeAction(mode)
		if isProcessing then return end
		isProcessing = true
		updateButtonState:Fire(mode, "Applying...")

		if not avatarDescription then
			sendNotif("<b>Failed:</b> Data loading, please wait.", true)
			updateButtonState:Fire(mode, "Execute")
			isProcessing = false
			return
		end

		local finalSuccess = false

		if mode == "Headless" or mode == "Korless" then
			doHeadless()
			finalSuccess = true
		end

		if mode == "Korless" then
			task.wait(0.1) 
		end

		if mode == "Korblox" or mode == "Korless" then
			local t1 = runTahap1()
			if t1 then
				finalSuccess = true
			else
				local t2 = runTahap2()
				if t2 then
					finalSuccess = true
				else
					if mode == "Korblox" then
						finalSuccess = false
					end
				end
			end
		end

		if finalSuccess then
			sendNotif("<b>Success:</b> " .. mode .. " applied!", false)
		else
			sendNotif("<b>Failed:</b> Could not apply " .. mode .. ".", true)
		end

		updateButtonState:Fire(mode, "Execute")
		isProcessing = false
	end

	onKorlessClicked.Event:Connect(function() executeAction("Korless") end)
	onHeadlessClicked.Event:Connect(function() executeAction("Headless") end)
	onKorbloxClicked.Event:Connect(function() executeAction("Korblox") end)

	task.spawn(initVisuals)
end

-- ==========================================
-- EKSEKUSI SEMUA SCOPE
-- ==========================================
RunScope("Scope_UI1_Loading", Scope_UI1)
RunScope("Scope_UI2_Button", Scope_UI2)
RunScope("Scope_UI3_Notif", Scope_UI3)
RunScope("Scope_Logic4_Avatar", Scope_Logic4)
