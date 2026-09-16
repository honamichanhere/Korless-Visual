local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local TARGET_USERNAME = "honamichandesu"
local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AvatarModifierUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

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

local isApplying = false

applyBtn.MouseButton1Click:Connect(function()
    if isApplying then return end
    isApplying = true
    applyBtn.Text = "Applying..."
    
    local rigsFolder = Workspace:FindFirstChild("Rigs")
    local myRig = rigsFolder and rigsFolder:FindFirstChild(player.Name)

    if not myRig then
        warn("Rig lu ga ditemuin di Workspace.Rigs!")
        applyBtn.Text = "Apply"
        isApplying = false
        return
    end

    local myHum = myRig:FindFirstChild("Humanoid")
    if not myHum then return end
    
    local isR15 = myHum.RigType == Enum.HumanoidRigType.R15
    print("Mulai eksekusi! Tipe Rig lu terdeteksi sebagai: " .. (isR15 and "R15" or "R6"))

    local head = myRig:FindFirstChild("Head")
    if head then
        head.Transparency = 1
        local face = head:FindFirstChild("face") or head:FindFirstChild("Decal")
        if face then face:Destroy() end
    end

    local successId, userId = pcall(function() return Players:GetUserIdFromNameAsync(TARGET_USERNAME) end)
    
    if successId then
        local successDesc, targetDesc = pcall(function() return Players:GetHumanoidDescriptionFromUserId(userId) end)
        
        if successDesc then
            local dummyRig = Players:CreateHumanoidModelFromDescription(targetDesc, myHum.RigType)
            dummyRig.Name = "TumbalKorblox"
            dummyRig.Parent = Workspace 
            task.wait(0.3)
            
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
                        print("Korblox R15 sukses!")
                    else
                        warn("Gagal nemu engsel R15 (RightHip/Knee/Ankle)!")
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
                    print("Korblox R6 sukses!")
                else
                    warn("Engsel R6 atau kaki ga ketemu!")
                end
            end
            
            dummyRig:Destroy()
        end
    end

    applyBtn.Text = "Apply"
    isApplying = false
end)
