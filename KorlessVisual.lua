-- ==========================================
-- MAIN SERVICES & VARIABLES
-- ==========================================
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==========================================
-- RE-EXECUTE SAFETY + AUTO EXECUTE
-- ==========================================
local env = getgenv and getgenv() or _G

-- Jalankan teardown sesi sebelumnya dulu supaya GUI, loop, dan perubahan visual tidak numpuk.
if env.KorlessCleanup then
	local cleanup = env.KorlessCleanup
	env.KorlessCleanup = nil
	pcall(cleanup)
end
-- Sisa GUI dari versi lama yang belum punya cleanup.
for _, gui in ipairs(playerGui:GetChildren()) do
	if gui.Name == "VisualKorless" then gui:Destroy() end
end

-- Antre script untuk teleport berikutnya (rejoin / ganti server dari dalam game), sekali per server.
-- Branch default "main"; untuk tes dari branch lain: getgenv().KorlessBranch = "nama-branch" sebelum load.
-- Menutup game lalu buka lagi tidak bisa ditangani script; untuk itu pakai folder autoexec executor.
local BRANCH = env.KorlessBranch or "main"
local SCRIPT_URL = "https://raw.githubusercontent.com/honamichanhere/Korless-Visual/" .. BRANCH .. "/KorlessVisual.lua"
local queueOnTeleport = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
if queueOnTeleport and env.KorlessTeleportQueuedFor ~= game.JobId then
	env.KorlessTeleportQueuedFor = game.JobId
	local prefix = (BRANCH ~= "main") and ('getgenv().KorlessBranch = "' .. BRANCH .. '"; ') or ""
	pcall(queueOnTeleport, prefix .. 'loadstring(game:HttpGet("' .. SCRIPT_URL .. '"))()')
end

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

local function Scope_UI2()
	onLoadingFinished.Event:Wait()

	local UserInputService = game:GetService("UserInputService")
	local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

	local COLOR_PANEL = Color3.fromRGB(24, 24, 28)
	local COLOR_ROW = Color3.fromRGB(35, 35, 41)
	local COLOR_ROW_HOVER = Color3.fromRGB(44, 44, 52)
	local COLOR_STROKE = Color3.fromRGB(62, 62, 72)
	local COLOR_TEXT = Color3.fromRGB(240, 240, 245)
	local COLOR_SUB = Color3.fromRGB(145, 145, 160)
	local COLOR_OFF = Color3.fromRGB(78, 78, 90)
	local COLOR_ON = Color3.fromRGB(46, 160, 90)
	local COLOR_BUSY = Color3.fromRGB(205, 150, 45)

	local tweenFast = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	-- Mobile: satu switch saja (Korless). Desktop: Korless + Headless + Korblox.
	local rows
	if isMobile then
		rows = {
			{ id = "Korless", title = "Korless", sub = "Headless + Korblox", fire = onKorlessClicked },
		}
	else
		rows = {
			{ id = "Korless", title = "Korless", sub = "Headless + Korblox kanan", fire = onKorlessClicked },
			{ id = "Headless", title = "Headless", sub = "Sembunyikan kepala", fire = onHeadlessClicked },
			{ id = "Korblox", title = "Korblox", sub = "Kaki kanan saja", fire = onKorbloxClicked },
		}
	end

	local PANEL_W = isMobile and 190 or 220
	local PAD = 8
	local GAP = 6
	local ROW_H = 42
	local TITLE_H = isMobile and 0 or 22
	local PANEL_H = PAD + TITLE_H + (#rows * ROW_H) + ((#rows - 1) * GAP) + PAD

	local Panel = Instance.new("Frame")
	Panel.Name = "Panel"
	Panel.AnchorPoint = Vector2.new(0, 1)
	Panel.Size = UDim2.new(0, PANEL_W, 0, PANEL_H)
	Panel.Position = UDim2.new(0, -(PANEL_W + 20), 1, -10) -- mulai di luar layar, lalu geser masuk
	Panel.BackgroundColor3 = COLOR_PANEL
	Panel.BorderSizePixel = 0
	Panel.Parent = VisualKorless
	Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 12)
	local panelStroke = Instance.new("UIStroke", Panel)
	panelStroke.Color = COLOR_STROKE
	panelStroke.Thickness = 1

	if not isMobile then
		local Title = Instance.new("TextLabel")
		Title.Name = "Title"
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, PAD + 4, 0, PAD)
		Title.Size = UDim2.new(1, -(PAD * 2), 0, TITLE_H)
		Title.Font = Enum.Font.GothamBold
		Title.Text = "KORLESS VISUAL"
		Title.TextSize = 12
		Title.TextColor3 = COLOR_SUB
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.Parent = Panel
	end

	local setters = {}

	for index, def in ipairs(rows) do
		local Row = Instance.new("TextButton")
		Row.Name = def.id .. "Row"
		Row.AutoButtonColor = false
		Row.Text = ""
		Row.BackgroundColor3 = COLOR_ROW
		Row.BorderSizePixel = 0
		Row.Size = UDim2.new(1, -(PAD * 2), 0, ROW_H)
		Row.Position = UDim2.new(0, PAD, 0, PAD + TITLE_H + (index - 1) * (ROW_H + GAP))
		Row.Parent = Panel
		Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 9)

		local Name = Instance.new("TextLabel")
		Name.BackgroundTransparency = 1
		Name.Position = UDim2.new(0, 12, 0, 5)
		Name.Size = UDim2.new(1, -78, 0, 18)
		Name.Font = Enum.Font.GothamMedium
		Name.Text = def.title
		Name.TextSize = 14
		Name.TextColor3 = COLOR_TEXT
		Name.TextXAlignment = Enum.TextXAlignment.Left
		Name.Parent = Row

		local Sub = Instance.new("TextLabel")
		Sub.BackgroundTransparency = 1
		Sub.Position = UDim2.new(0, 12, 0, 23)
		Sub.Size = UDim2.new(1, -78, 0, 14)
		Sub.Font = Enum.Font.Gotham
		Sub.Text = def.sub
		Sub.TextSize = 11
		Sub.TextColor3 = COLOR_SUB
		Sub.TextXAlignment = Enum.TextXAlignment.Left
		Sub.Parent = Row

		local Track = Instance.new("Frame")
		Track.Name = "Track"
		Track.AnchorPoint = Vector2.new(1, 0.5)
		Track.Position = UDim2.new(1, -12, 0.5, 0)
		Track.Size = UDim2.new(0, 46, 0, 24)
		Track.BackgroundColor3 = COLOR_OFF
		Track.BorderSizePixel = 0
		Track.Parent = Row
		Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

		local Knob = Instance.new("Frame")
		Knob.Name = "Knob"
		Knob.AnchorPoint = Vector2.new(0, 0.5)
		Knob.Position = UDim2.new(0, 3, 0.5, 0)
		Knob.Size = UDim2.new(0, 18, 0, 18)
		Knob.BackgroundColor3 = Color3.new(1, 1, 1)
		Knob.BorderSizePixel = 0
		Knob.Parent = Track
		Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

		Row.MouseEnter:Connect(function()
			TweenService:Create(Row, tweenFast, { BackgroundColor3 = COLOR_ROW_HOVER }):Play()
		end)
		Row.MouseLeave:Connect(function()
			TweenService:Create(Row, tweenFast, { BackgroundColor3 = COLOR_ROW }):Play()
		end)
		Row.MouseButton1Click:Connect(function()
			def.fire:Fire()
		end)

		-- value: "ON" / "OFF" / "..." (sedang diproses)
		setters[def.id] = function(value)
			if value == "ON" then
				TweenService:Create(Track, tweenFast, { BackgroundColor3 = COLOR_ON }):Play()
				TweenService:Create(Knob, tweenFast, { Position = UDim2.new(0, 25, 0.5, 0) }):Play()
			elseif value == "OFF" then
				TweenService:Create(Track, tweenFast, { BackgroundColor3 = COLOR_OFF }):Play()
				TweenService:Create(Knob, tweenFast, { Position = UDim2.new(0, 3, 0.5, 0) }):Play()
			else
				TweenService:Create(Track, tweenFast, { BackgroundColor3 = COLOR_BUSY }):Play()
			end
		end
	end

	updateButtonState.Event:Connect(function(id, value)
		local setter = setters[id]
		if setter then setter(value) end
	end)

	TweenService:Create(
		Panel,
		TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{ Position = UDim2.new(0, 10, 1, -10) }
	):Play()
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
	-- Aset Korblox resmi (kaki kanan saja); dipakai lewat HumanoidDescription jadi tidak butuh akun donor.
	local KORBLOX_RIGHT_LEG = 139607718 -- Korblox Deathspeaker right leg
	local CACHE_FOLDER_NAME = "Korless_Cache"

	local State = { Headless = false, Korblox = false }
	local Cache = {}
	local cacheReady = false
	local isProcessing = false
	local alive = true
	local faceCache = setmetatable({}, { __mode = "k" })    -- rig -> face asli
	local handledRigs = setmetatable({}, { __mode = "k" })  -- rig yang sudah dapat state aktif

	local function sendNotif(msg, isError)
		triggerNotif:Fire(msg, isError)
	end

	-- Semua rig lokal (Evade bisa punya lebih dari satu di Workspace.Rigs).
	-- Player.Character hanya dipakai kalau Workspace.Rigs tidak punya rig sama sekali.
	local function getAllRigs()
		local list = {}
		local container = workspace:FindFirstChild("Rigs")
		if container then
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Model") and child.Name == player.Name then
					local hum = child:FindFirstChildOfClass("Humanoid")
					if hum then table.insert(list, { Rig = child, Humanoid = hum }) end
				end
			end
		end
		if #list == 0 then
			local character = player.Character
			local hum = character and character:FindFirstChildOfClass("Humanoid")
			if hum then table.insert(list, { Rig = character, Humanoid = hum }) end
		end
		return list
	end

	-- ---------- Headless ----------
	local function setHeadHidden(rig, hide)
		local head = rig and rig:FindFirstChild("Head")
		if not head then return end
		local face = head:FindFirstChild("face") or head:FindFirstChild("Decal")
		if hide then
			head.Transparency = 1
			if face then
				faceCache[rig] = face:Clone()
				face:Destroy()
			end
		else
			head.Transparency = 0
			if not face and faceCache[rig] then
				faceCache[rig]:Clone().Parent = head
			end
		end
	end

	-- ---------- Korblox ----------
	local function reconnectCustomParts(oldPart, newPart, rig)
		if not oldPart or not newPart or not rig then return end
		for _, obj in ipairs(rig:GetDescendants()) do
			if obj:IsA("JointInstance") then
				if not string.match(obj.Name, "Hip") and not string.match(obj.Name, "Knee") and not string.match(obj.Name, "Ankle") then
					if obj.Part0 == oldPart then obj.Part0 = newPart end
					if obj.Part1 == oldPart then obj.Part1 = newPart end
				end
			elseif obj:IsA("WeldConstraint") then
				if obj.Part0 == oldPart then obj.Part0 = newPart end
				if obj.Part1 == oldPart then obj.Part1 = newPart end
			end
		end

		for _, child in ipairs(oldPart:GetChildren()) do
			if child:IsA("CharacterMesh") or child:IsA("WrapTarget") or child:IsA("TouchTransmitter") then continue end
			if child:IsA("Motor6D") and (string.match(child.Name, "Hip") or string.match(child.Name, "Knee") or string.match(child.Name, "Ankle")) then continue end

			if child:IsA("Attachment") and string.match(child.Name, "RigAttachment$") then
				local targetAtt = newPart:FindFirstChild(child.Name)
				if targetAtt then
					for _, attChild in ipairs(child:GetChildren()) do attChild.Parent = targetAtt end
				end
			else
				child.Parent = newPart
			end
		end
	end

	-- side = "Left" / "Right"; useKorblox = true pasang Korblox, false kembalikan kaki asli.
	local function replaceLegs(side, useKorblox, rig, hum)
		if not rig or not hum then return false end
		local isR15 = hum.RigType == Enum.HumanoidRigType.R15
		local sourceRig
		if useKorblox then
			sourceRig = isR15 and Cache.KorbloxR15 or Cache.KorbloxR6
		else
			sourceRig = isR15 and Cache.OriR15 or Cache.OriR6
		end
		if not sourceRig then warn("[Korless] cache model missing (useKorblox=" .. tostring(useKorblox) .. ", R15=" .. tostring(isR15) .. ")") return false end

		local noPhys = PhysicalProperties.new(0.01, 0, 0, 0, 0)

		if isR15 then
			local upperName, lowerName, footName = side .. "UpperLeg", side .. "LowerLeg", side .. "Foot"
			local oldUpper, oldLower, oldFoot = rig:FindFirstChild(upperName), rig:FindFirstChild(lowerName), rig:FindFirstChild(footName)
			local srcUpper, srcLower, srcFoot = sourceRig:FindFirstChild(upperName), sourceRig:FindFirstChild(lowerName), sourceRig:FindFirstChild(footName)
			if not (oldUpper and oldLower and oldFoot and srcUpper and srcLower and srcFoot) then warn("[Korless] R15 " .. side .. " leg parts missing in " .. rig:GetFullName() .. " (rig has: " .. tostring(oldUpper ~= nil) .. "," .. tostring(oldLower ~= nil) .. "," .. tostring(oldFoot ~= nil) .. " | cache has: " .. tostring(srcUpper ~= nil) .. "," .. tostring(srcLower ~= nil) .. "," .. tostring(srcFoot ~= nil) .. ")") return false end

			local joints = rig:FindFirstChild("Joints")
			local lowerTorso = rig:FindFirstChild("LowerTorso")
			local hipName, kneeName, ankleName = side .. "Hip", side .. "Knee", side .. "Ankle"
			local hip = (joints and joints:FindFirstChild(hipName)) or (lowerTorso and lowerTorso:FindFirstChild(hipName)) or oldUpper:FindFirstChild(hipName)
			local knee = (joints and joints:FindFirstChild(kneeName)) or oldLower:FindFirstChild(kneeName)
			local ankle = (joints and joints:FindFirstChild(ankleName)) or oldFoot:FindFirstChild(ankleName)
			if not (hip and knee and ankle) then warn("[Korless] R15 " .. side .. " joints missing in " .. rig:GetFullName() .. " (hip,knee,ankle = " .. tostring(hip ~= nil) .. "," .. tostring(knee ~= nil) .. "," .. tostring(ankle ~= nil) .. ")") return false end

			local newUpper, newLower, newFoot = srcUpper:Clone(), srcLower:Clone(), srcFoot:Clone()
			for _, p in ipairs({ newUpper, newLower, newFoot }) do
				for _, v in ipairs(p:GetChildren()) do if v:IsA("Motor6D") then v:Destroy() end end
				p.Parent = rig
			end

			hip.Part1 = newUpper
			knee.Part0 = newUpper
			knee.Part1 = newLower
			ankle.Part0 = newLower
			ankle.Part1 = newFoot

			if hip.Parent == oldUpper then hip.Parent = newUpper end
			if knee.Parent == oldUpper or knee.Parent == oldLower then knee.Parent = newUpper end
			if ankle.Parent == oldLower or ankle.Parent == oldFoot then ankle.Parent = newLower end

			for _, p in ipairs({ newUpper, newLower, newFoot }) do
				p.Massless = true
				p.CanCollide = false
				p.CustomPhysicalProperties = noPhys
			end

			local colors = rig:FindFirstChildOfClass("BodyColors")
			if colors then
				local legColor = side == "Left" and colors.LeftLegColor3 or colors.RightLegColor3
				newUpper.Color, newLower.Color, newFoot.Color = legColor, legColor, legColor
			end

			reconnectCustomParts(oldUpper, newUpper, rig)
			reconnectCustomParts(oldLower, newLower, rig)
			reconnectCustomParts(oldFoot, newFoot, rig)

			oldUpper:Destroy()
			oldLower:Destroy()
			oldFoot:Destroy()
			return true
		end

		-- R6
		local legName = side .. " Leg"
		local oldLeg = rig:FindFirstChild(legName)
		local joints = rig:FindFirstChild("Joints")
		local torso = rig:FindFirstChild("Torso")
		local hipMotor = (joints and joints:FindFirstChild(legName)) or (torso and torso:FindFirstChild(side .. " Hip"))
		local srcLeg = sourceRig:FindFirstChild(legName)
		if not (oldLeg and hipMotor and srcLeg) then warn("[Korless] R6 " .. side .. " leg parts missing in " .. rig:GetFullName()) return false end

		local newLeg = srcLeg:Clone()
		for _, v in ipairs(newLeg:GetChildren()) do if v:IsA("Motor6D") then v:Destroy() end end

		local bodyPart = side == "Left" and Enum.BodyPart.LeftLeg or Enum.BodyPart.RightLeg
		for _, mesh in ipairs(rig:GetChildren()) do
			if mesh:IsA("CharacterMesh") and mesh.BodyPart == bodyPart then mesh:Destroy() end
		end
		for _, mesh in ipairs(sourceRig:GetChildren()) do
			if mesh:IsA("CharacterMesh") and mesh.BodyPart == bodyPart then mesh:Clone().Parent = rig end
		end

		newLeg.Parent = rig
		hipMotor.Part1 = newLeg
		newLeg.Massless = true
		newLeg.CanCollide = false
		newLeg.CustomPhysicalProperties = noPhys
		if hipMotor.Parent == oldLeg then hipMotor.Parent = newLeg end

		local colors = rig:FindFirstChildOfClass("BodyColors")
		if colors then newLeg.Color = side == "Left" and colors.LeftLegColor3 or colors.RightLegColor3 end

		reconnectCustomParts(oldLeg, newLeg, rig)
		oldLeg:Destroy()
		return true
	end

	local function setKorblox(rig, hum, state)
		local ok = false
		for _, side in ipairs({ "Right" }) do
			if replaceLegs(side, state, rig, hum) then ok = true end
		end
		return ok
	end

	-- ---------- Cache model (avatar sendiri) ----------
	local function buildCache()
		local old = workspace:FindFirstChild(CACHE_FOLDER_NAME)
		if old then old:Destroy() end

		local folder = Instance.new("Folder")
		folder.Name = CACHE_FOLDER_NAME
		folder.Parent = workspace

		local okDesc, desc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(player.UserId) end)
		if not okDesc or not desc then
			sendNotif("<b>Failed:</b> Failed to fetch Avatar data.", true)
			return
		end

		local korbloxDesc = desc:Clone()
		korbloxDesc.RightLeg = KORBLOX_RIGHT_LEG

		local function make(key, description, rigType, offset)
			local model = Players:CreateHumanoidModelFromDescription(description, rigType)
			model.Name = "Cache_" .. key
			model.Parent = folder
			model:PivotTo(CFrame.new(5000 + offset, 5000, 5000))
			local root = model:FindFirstChild("HumanoidRootPart")
			if root then root.Anchored = true end
			Cache[key] = model
		end

		local okAll = pcall(function()
			make("OriR15", desc, Enum.HumanoidRigType.R15, 0)
			make("OriR6", desc, Enum.HumanoidRigType.R6, 10)
			make("KorbloxR15", korbloxDesc, Enum.HumanoidRigType.R15, 20)
			make("KorbloxR6", korbloxDesc, Enum.HumanoidRigType.R6, 30)
		end)

		if okAll then
			cacheReady = true
		else
			sendNotif("<b>Failed:</b> Failed to build avatar cache.", true)
		end
	end

	-- ---------- Tombol ----------
	local function refreshButtons()
		updateButtonState:Fire("Korless", (State.Headless and State.Korblox) and "ON" or "OFF")
		updateButtonState:Fire("Headless", State.Headless and "ON" or "OFF")
		updateButtonState:Fire("Korblox", State.Korblox and "ON" or "OFF")
	end

	local function applyHeadless(state)
		State.Headless = state
		for _, entry in ipairs(getAllRigs()) do setHeadHidden(entry.Rig, state) end
	end

	local function applyKorblox(state)
		local previous = State.Korblox
		local anyOk = false
		for _, entry in ipairs(getAllRigs()) do
			if setKorblox(entry.Rig, entry.Humanoid, state) then anyOk = true end
		end
		State.Korblox = anyOk and state or previous
		return anyOk
	end

	local function executeAction(mode)
		if isProcessing then return end
		if not cacheReady then
			sendNotif("<b>Failed:</b> Data loading, please wait.", true)
			return
		end
		if #getAllRigs() == 0 then
			sendNotif("<b>Failed:</b> Rig not found.", true)
			return
		end

		isProcessing = true
		updateButtonState:Fire(mode, "...")

		local wantHead, wantLegs = State.Headless, State.Korblox
		local removing
		if mode == "Headless" then
			wantHead = not State.Headless
			removing = not wantHead
		elseif mode == "Korblox" then
			wantLegs = not State.Korblox
			removing = not wantLegs
		else -- Korless: kalau dua-duanya sudah aktif -> lepas, selain itu -> aktifkan dua-duanya
			local target = not (State.Headless and State.Korblox)
			wantHead, wantLegs = target, target
			removing = not target
		end

		-- pcall: kalau ada error di tengah jalan, tombol tetap dilepas (tidak nyangkut di "...").
		local success = true
		local okRun, runErr = pcall(function()
			if wantHead ~= State.Headless then applyHeadless(wantHead) end
			if wantLegs ~= State.Korblox then
				if not applyKorblox(wantLegs) then success = false end
			end
		end)
		if not okRun then
			success = false
			warn("[Korless] " .. mode .. " error: " .. tostring(runErr))
		end

		if success then
			sendNotif("<b>Success:</b> " .. mode .. (removing and " removed!" or " applied!"), false)
		else
			sendNotif("<b>Failed:</b> Could not apply " .. mode .. ".", true)
		end

		refreshButtons()
		isProcessing = false
	end

	onKorlessClicked.Event:Connect(function() executeAction("Korless") end)
	onHeadlessClicked.Event:Connect(function() executeAction("Headless") end)
	onKorbloxClicked.Event:Connect(function() executeAction("Korblox") end)

	-- Rig baru (respawn / rig inventory dibuat ulang) otomatis dapat state yang sedang aktif.
	task.spawn(function()
		while alive and task.wait(1) do
			if cacheReady then
				for _, entry in ipairs(getAllRigs()) do
					if not handledRigs[entry.Rig] then
						handledRigs[entry.Rig] = true
						task.wait(0.5)
						if entry.Rig.Parent then
							if State.Headless then setHeadHidden(entry.Rig, true) end
							if State.Korblox then setKorblox(entry.Rig, entry.Humanoid, true) end
						end
					end
				end
			end
		end
	end)

	-- Re-execute: batalkan perubahan visual lama, buang cache, hentikan loop.
	env.KorlessCleanup = function()
		alive = false
		pcall(function()
			if State.Korblox then applyKorblox(false) end
			if State.Headless then applyHeadless(false) end
		end)
		local folder = workspace:FindFirstChild(CACHE_FOLDER_NAME)
		if folder then folder:Destroy() end
		if VisualKorless then VisualKorless:Destroy() end
		-- Destroy memutus semua koneksi tombol/notif milik sesi ini.
		for _, event in ipairs({ onLoadingFinished, onKorlessClicked, onHeadlessClicked, onKorbloxClicked, triggerNotif, updateButtonState }) do
			event:Destroy()
		end
	end

	task.spawn(buildCache)
end

-- ==========================================
-- EKSEKUSI SEMUA SCOPE
-- ==========================================
RunScope("Scope_UI1_Loading", Scope_UI1)
RunScope("Scope_UI2_Button", Scope_UI2)
RunScope("Scope_UI3_Notif", Scope_UI3)
RunScope("Scope_Logic4_Avatar", Scope_Logic4)
