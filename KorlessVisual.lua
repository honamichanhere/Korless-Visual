local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ==========================================
-- 1. AUTO-GENERATE UI (BUTTON + NOTIF)
-- ==========================================
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AvatarModifierUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame Button
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 100, 0, 20)
frame.AnchorPoint = Vector2.new(0, 1)
frame.Position = UDim2.new(0, 0, 1, 0)
frame.BackgroundTransparency = 1
frame.Parent = screenGui

local applyBtn = Instance.new("TextButton")
applyBtn.Name = "ApplyButton"
applyBtn.Size = UDim2.new(1, 0, 1, 0)
applyBtn.Text = "Apply"
applyBtn.Font = Enum.Font.SourceSansBold
applyBtn.TextSize = 14
applyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
applyBtn.Parent = frame

-- Frame Notif
local notifFeedback = Instance.new("Frame")
notifFeedback.Name = "NotifFeedback"
notifFeedback.Size = UDim2.new(0.8, 0, 0.8, 0)
notifFeedback.Position = UDim2.new(0.5, 0, 0.5, 0)
notifFeedback.AnchorPoint = Vector2.new(0.5, 0.5)
notifFeedback.BackgroundTransparency = 1
notifFeedback.Parent = screenGui

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0.005, 0)
uiListLayout.Parent = notifFeedback

local textTemplate = Instance.new("TextLabel")
textTemplate.Name = "TextTemplate"
textTemplate.Size = UDim2.new(1, 0, 0.02, 0)
textTemplate.BackgroundTransparency = 1
textTemplate.Font = Enum.Font.Cartoon
textTemplate.TextScaled = true
textTemplate.RichText = true
textTemplate.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
textTemplate.TextStrokeTransparency = 0.5
textTemplate.Visible = false
textTemplate.Parent = notifFeedback

-- ==========================================
-- 2. NOTIFICATION SYSTEM (TYPEWRITER)
-- ==========================================
local function sendNotif(message, isError)
	local notif = textTemplate:Clone()
	notif.Parent = notifFeedback
	notif.Visible = true
	notif.Text = message
	
	if isError then
		notif.TextColor3 = Color3.fromRGB(255, 80, 80)
	else
		notif.TextColor3 = Color3.fromRGB(255, 255, 255)
	end

	local plainText = string.gsub(message, "<[^>]->", "")
	local textLength = utf8.len(plainText) or string.len(plainText)
	
	notif.MaxVisibleGraphemes = 0

	task.spawn(function()
		local charDelay = 0.02
		for i = 1, textLength do
			notif.MaxVisibleGraphemes = i
			task.wait(charDelay)
		end
		
		notif.MaxVisibleGraphemes = -1 
		
		task.wait(5)
		
		for i = 1, 20 do
			notif.TextTransparency = i / 20
			task.wait(0.05)
		end
		
		notif:Destroy()
	end)
end

-- ==========================================
-- 3. SETUP DATA & VISUAL RIG JAUH
-- ==========================================
local TARGET_USERNAME = "honamichandesu"
local avatarDescription = nil

local function smartFind(parentObject, nameToFind)
	if not parentObject then return nil end
	return parentObject:FindFirstChild(nameToFind, true)
end

local function hilangkanKepala(rigTarget)
	local head = rigTarget:FindFirstChild("Head")
	if head then
		head.Transparency = 1
		local face = head:FindFirstChild("face") or head:FindFirstChild("Decal")
		if face then face:Destroy() end
	end
end

local function initVisuals()
	local successId, userId = pcall(function() return Players:GetUserIdFromNameAsync(TARGET_USERNAME) end)
	if not successId then return sendNotif("<b>Failed</b> to find UserId for <b>" .. TARGET_USERNAME .. "</b>.", true) end

	local successDesc, description = pcall(function() return Players:GetHumanoidDescriptionFromUserId(userId) end)
	if not successDesc then return sendNotif("<b>Failed</b> to fetch <b>Avatar data</b> from web.", true) end
	
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
	
	sendNotif("<b>Success</b>, visual rigs spawned at <b>X:2048</b>. Click <b>Apply</b> to swap.", false)
end

-- ==========================================
-- 4. LOGIC TAHAP 1
-- ==========================================
local function runTahap1()
	local rigsFolder = workspace:FindFirstChild("Rigs")
	local myRig = rigsFolder and rigsFolder:FindFirstChild(player.Name)

	if not myRig then
		sendNotif("<b>Stage 1 Skipped:</b> Your rig was not found in <b>Workspace.Rigs</b>.", false)
		return false
	end

	local myHum = myRig:FindFirstChild("Humanoid")
	if not myHum then return false end
	
	local isR15 = myHum.RigType == Enum.HumanoidRigType.R15
	sendNotif("<b>Stage 1 Started:</b> Detected Rig Type is <b>" .. (isR15 and "R15" or "R6") .. "</b>.", false)

	hilangkanKepala(myRig)

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
				sendNotif("<b>Stage 1 Success:</b> Applied <b>Korblox R15</b> successfully!", false)
				sukses = true
			else
				sendNotif("<b>Stage 1 Failed:</b> Missing <b>R15 joints</b> (RightHip/Knee/Ankle).", true)
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
			sendNotif("<b>Stage 1 Success:</b> Applied <b>Korblox R6</b> successfully!", false)
			sukses = true
		else
			sendNotif("<b>Stage 1 Failed:</b> Missing <b>R6 leg or joints</b>.", true)
		end
	end

	dummyRig:Destroy()
	return sukses
end

-- ==========================================
-- 5. LOGIC TAHAP 2
-- ==========================================
local function runTahap2()
	local character = player.Character
	if not character then return false end
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return false end

	sendNotif("<b>Stage 2 Started:</b> Running <b>Smart Search</b> on main avatar...", false)
	
	hilangkanKepala(character)

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
			local oldHip = smartFind(character, "RightHip")
			local donorHip = smartFind(dummyRig, "RightHip")
			local donorKnee = smartFind(dummyRig, "RightKnee")
			local donorAnkle = smartFind(dummyRig, "RightAnkle")
			
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
			if oldHip and donorHip then
				newHip.C0 = oldHip.C0
				newHip.C1 = donorHip.C1
			end
			newHip.Parent = newUpper

			local newKnee = Instance.new("Motor6D")
			newKnee.Name = "RightKnee"
			newKnee.Part0 = newUpper
			newKnee.Part1 = newLower
			if donorKnee then
				newKnee.C0 = donorKnee.C0
				newKnee.C1 = donorKnee.C1
			end
			newKnee.Parent = newLower

			local newAnkle = Instance.new("Motor6D")
			newAnkle.Name = "RightAnkle"
			newAnkle.Part0 = newLower
			newAnkle.Part1 = newFoot
			if donorAnkle then
				newAnkle.C0 = donorAnkle.C0
				newAnkle.C1 = donorAnkle.C1
			end
			newAnkle.Parent = newFoot

			newUpper.Parent = character
			newLower.Parent = character
			newFoot.Parent = character

			oldUpper:Destroy()
			oldLower:Destroy()
			oldFoot:Destroy()
			
			sendNotif("<b>Stage 2 Success:</b> Applied <b>Korblox R15</b> via Smart Search!", false)
			sukses = true
		else
			sendNotif("<b>Stage 2 Failed:</b> Incomplete <b>R15 leg parts</b>.", true)
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
			
			sendNotif("<b>Stage 2 Success:</b> Applied <b>Korblox R6</b> via Smart Search!", false)
			sukses = true
		else
			sendNotif("<b>Stage 2 Failed:</b> Incomplete <b>R6 leg parts</b>.", true)
		end
	end
	
	dummyRig:Destroy()
	return sukses
end

-- ==========================================
-- 6. BUTTON LISTENER
-- ==========================================
local isApplying = false

applyBtn.MouseButton1Click:Connect(function()
	if isApplying then return end
	isApplying = true
	applyBtn.Text = "Applying..."

	if not avatarDescription then
		sendNotif("<b>Warning:</b> Web data not ready, please wait.", true)
		applyBtn.Text = "Apply"
		isApplying = false
		return
	end

	local tahap1Sukses = runTahap1()
	
	if tahap1Sukses then
		sendNotif("<b>PROCESS COMPLETE:</b> Swap resolved by <b>Stage 1</b>.", false)
	else
		sendNotif("<b>Proceeding to Stage 2</b> (Stage 1 skipped/failed)...", false)
		local tahap2Sukses = runTahap2()
		
		if tahap2Sukses then
			sendNotif("<b>PROCESS COMPLETE:</b> Swap resolved by <b>Stage 2</b>.", false)
		else
			sendNotif("<b>PROCESS FAILED:</b> Both stages failed to swap.", true)
		end
	end

	applyBtn.Text = "Apply"
	isApplying = false
end)

task.spawn(initVisuals)
