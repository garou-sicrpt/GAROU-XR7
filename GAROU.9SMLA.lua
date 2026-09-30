local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
Gui.Name = "CaroPointsTracker"
Gui.ResetOnSpawn = false

local Button = Instance.new("ImageButton", Gui)
Button.Size = UDim2.new(0, 50, 0, 50)
Button.Position = UDim2.new(0, 20, 0.4, 0)
Button.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
Button.Image = "rbxassetid://82139690198696"
Button.ScaleType = Enum.ScaleType.Crop
Button.Visible = true
Instance.new("UICorner", Button).CornerRadius = UDim.new(1, 0)

local dragging, dragInput, dragStart, startPos
Button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Button.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Button.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		local delta = input.Position - dragStart
		Button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 540, 0, 390)
Frame.Position = UDim2.new(0.5, -270, 0.5, -195)
Frame.BackgroundColor3 = Color3.fromRGB(35, 12, 12)
Frame.Visible = false
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local TitleBox = Instance.new("Frame", Frame)
TitleBox.Size = UDim2.new(0.92, 0, 0, 36)
TitleBox.Position = UDim2.new(0.04, 0, 0, 12)
TitleBox.BackgroundColor3 = Color3.fromRGB(50, 18, 18)
Instance.new("UICorner", TitleBox).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TitleBox)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "إحتساب النقاط"
Title.TextScaled = true

local SubTitle = Instance.new("TextLabel", Frame)
SubTitle.Size = UDim2.new(1, 0, 0, 22)
SubTitle.Position = UDim2.new(0, 0, 0, 54)
SubTitle.BackgroundTransparency = 1
SubTitle.Font = Enum.Font.GothamBold
SubTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
SubTitle.Text = "صنع بواسطة كارو"
SubTitle.TextSize = 16

local TimerLabel = Instance.new("TextLabel", Frame)
TimerLabel.Size = UDim2.new(1, 0, 0, 22)
TimerLabel.Position = UDim2.new(0, 0, 0, 80)
TimerLabel.BackgroundTransparency = 1
TimerLabel.Font = Enum.Font.GothamBold
TimerLabel.TextColor3 = Color3.new(1, 1, 1)
TimerLabel.Text = "مدة بقائك: 00:00:00"
TimerLabel.TextScaled = true

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0.72, 0, 0, 36)
TextBox.Position = UDim2.new(0.04, 0, 0, 108)
TextBox.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
TextBox.PlaceholderText = "أكتب إسم لاعب"
TextBox.PlaceholderColor3 = Color3.fromRGB(180, 150, 150)
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.Font = Enum.Font.GothamSemibold
TextBox.TextScaled = true
TextBox.ClearTextOnFocus = true 
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

local AddButton = Instance.new("TextButton", Frame)
AddButton.Size = UDim2.new(0.18, 0, 0, 36)
AddButton.Position = UDim2.new(0.78, 0, 0, 108)
AddButton.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
AddButton.Text = "بدء"
AddButton.TextColor3 = Color3.new(1, 1, 1)
AddButton.Font = Enum.Font.GothamBold
AddButton.TextScaled = true
Instance.new("UICorner", AddButton).CornerRadius = UDim.new(0, 8)

local ScrollingFrame = Instance.new("ScrollingFrame", Frame)
ScrollingFrame.Size = UDim2.new(0.92, 0, 0, 200)
ScrollingFrame.Position = UDim2.new(0.04, 0, 0, 155)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 6

local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

local scriptActive = false
local sessionTime = 0
local trackedPlayers = {} 
local backgroundHistory = {}

local function formatTime(t)
	local h = math.floor(t / 3600)
	local m = math.floor((t % 3600) / 60)
	local s = math.floor(t % 60)
	return string.format("%02d:%02d:%02d", h, m, s)
end

local function rebuildList()
	for _, child in pairs(ScrollingFrame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	
	for index, data in ipairs(trackedPlayers) do
		local pl = data.player
		local stats = data.stats
		
		local PItem = Instance.new("Frame", ScrollingFrame)
		PItem.Size = UDim2.new(1, -10, 0, 60)
		PItem.BackgroundColor3 = Color3.fromRGB(55, 20, 20)
		PItem.Name = "PlayerItem_" .. index
		Instance.new("UICorner", PItem).CornerRadius = UDim.new(0, 8)
		
		local AvatarImg = Instance.new("ImageLabel", PItem)
		AvatarImg.Size = UDim2.new(0, 44, 0, 44)
		AvatarImg.Position = UDim2.new(0.02, 0, 0.13, 0)
		AvatarImg.BackgroundTransparency = 1
		AvatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..pl.UserId.."&width=100&height=100&format=png"
		Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(0, 6)
		
		local NameLbl = Instance.new("TextLabel", PItem)
		NameLbl.Size = UDim2.new(0.48, 0, 0, 20)
		NameLbl.Position = UDim2.new(0.14, 0, 0.1, 0)
		NameLbl.BackgroundTransparency = 1
		NameLbl.Font = Enum.Font.GothamBold
		NameLbl.TextColor3 = Color3.new(1, 1, 1)
		NameLbl.Text = pl.Name .. " (@" .. pl.DisplayName .. ")"
		NameLbl.TextScaled = true
		NameLbl.TextXAlignment = Enum.TextXAlignment.Left
		
		local StatsLbl = Instance.new("TextLabel", PItem)
		StatsLbl.Size = UDim2.new(0.48, 0, 0, 20)
		StatsLbl.Position = UDim2.new(0.14, 0, 0.52, 0)
		StatsLbl.BackgroundTransparency = 1
		StatsLbl.Font = Enum.Font.GothamSemibold
		StatsLbl.TextColor3 = Color3.fromRGB(230, 200, 200)
		StatsLbl.Name = "StatsLabel"
		StatsLbl.TextScaled = true
		StatsLbl.TextXAlignment = Enum.TextXAlignment.Left
		
		local currentTimer = stats.AccumulatedTime
		if stats.IsInGame then
			currentTimer = currentTimer + (tick() - stats.LastJoinTick)
		end
		StatsLbl.Text = "دخول: " .. stats.JoinCount .. " | خروج: " .. stats.LeaveCount .. " | الوقت: " .. formatTime(currentTimer)
		
		local CopyBtn = Instance.new("TextButton", PItem)
		CopyBtn.Size = UDim2.new(0, 75, 0, 38)
		CopyBtn.Position = UDim2.new(0.66, 0, 0.18, 0)
		CopyBtn.BackgroundColor3 = Color3.fromRGB(90, 30, 30)
		CopyBtn.Text = "نسخ"
		CopyBtn.TextColor3 = Color3.new(1, 1, 1)
		CopyBtn.Font = Enum.Font.GothamBold
		CopyBtn.TextSize = 14
		Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)
		
		CopyBtn.MouseButton1Click:Connect(function()
			local copyTimer = stats.AccumulatedTime
			if stats.IsInGame then
				copyTimer = copyTimer + (tick() - stats.LastJoinTick)
			end
			local infoString = string.format("اللاعب: %s | يوزر: @%s | دخول: %d | خروج: %d | الوقت: %s", pl.Name, pl.DisplayName, stats.JoinCount, stats.LeaveCount, formatTime(copyTimer))
			if setclipboard then
				setclipboard(infoString)
				CopyBtn.Text = "تم!"
				task.delay(1, function() CopyBtn.Text = "نسخ" end)
			end
		end)
		
		local DeleteBtn = Instance.new("TextButton", PItem)
		DeleteBtn.Size = UDim2.new(0, 38, 0, 38)
		DeleteBtn.Position = UDim2.new(0.85, 0, 0.18, 0)
		DeleteBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
		DeleteBtn.Text = "❌"
		DeleteBtn.TextColor3 = Color3.new(1, 1, 1)
		DeleteBtn.Font = Enum.Font.GothamBold
		DeleteBtn.TextSize = 18
		Instance.new("UICorner", DeleteBtn).CornerRadius = UDim.new(0, 6)
		
		DeleteBtn.MouseButton1Click:Connect(function()
			table.remove(trackedPlayers, index)
			rebuildList()
		end)
	end
	
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #trackedPlayers * 68)
	ScrollingFrame.CanvasPosition = Vector2.new(0, ScrollingFrame.CanvasSize.Y.Offset)
end

AddButton.MouseButton1Click:Connect(function()
	local text = TextBox.Text:lower()
	if text == "" then return end
	
	for _, pl in pairs(Players:GetPlayers()) do
		if pl.Name:lower():sub(1, #text) == text or pl.DisplayName:lower():sub(1, #text) == text or pl.Name:lower():find(text) or pl.DisplayName:lower():find(text) then
			local exists = false
			for _, item in ipairs(trackedPlayers) do
				if item.player == pl then
					exists = true
					break
				end
			end
			
			if not exists then
				local stats = backgroundHistory[pl.UserId]
				if not stats then
					stats = {
						JoinCount = 0,
						LeaveCount = 0,
						AccumulatedTime = 0,
						IsInGame = true,
						LastJoinTick = tick(),
						HasLeftOnce = false
					}
					backgroundHistory[pl.UserId] = stats
				else
					stats.AccumulatedTime = 0
					stats.LastJoinTick = tick()
				end
				
				table.insert(trackedPlayers, {player = pl, stats = stats})
				rebuildList()
				break
			end
		end
	end
end)

local function setupPlayerTracking(pl)
	local userId = pl.UserId
	local stats = backgroundHistory[userId]
	
	if not stats then
		stats = {
			JoinCount = 0,
			LeaveCount = 0,
			AccumulatedTime = 0,
			IsInGame = true,
			LastJoinTick = tick(),
			HasLeftOnce = false
		}
		backgroundHistory[userId] = stats
	else
		stats.IsInGame = true
		stats.LastJoinTick = tick()
		if stats.HasLeftOnce then
			stats.JoinCount = stats.JoinCount + 1
		end
	end
	
	pl.AncestryChanged:Connect(function(_, parent)
		if not parent then
			stats.LeaveCount = stats.LeaveCount + 1
			stats.HasLeftOnce = true
			if stats.IsInGame then
				stats.AccumulatedTime = stats.AccumulatedTime + (tick() - stats.LastJoinTick)
				stats.IsInGame = false
			end
		end
	end)
end

Players.PlayerAdded:Connect(function(pl)
	setupPlayerTracking(pl)
	for _, item in ipairs(trackedPlayers) do
		if item.player.UserId == pl.UserId then
			item.player = pl
			rebuildList()
			break
		end
	end
end)

for _, pl in pairs(Players:GetPlayers()) do
	setupPlayerTracking(pl)
end

RunService.Heartbeat:Connect(function(dt)
	Button.Rotation = (Button.Rotation + dt * 25) % 360

	if scriptActive then
		sessionTime += dt
		TimerLabel.Text = "مدة بقائك: " .. formatTime(sessionTime)
		
		if Frame.Visible and #trackedPlayers > 0 then
			for index, data in ipairs(trackedPlayers) do
				local itemFrame = ScrollingFrame:FindFirstChild("PlayerItem_" .. index)
				if itemFrame then
					local statsLbl = itemFrame:FindFirstChild("StatsLabel")
					if statsLbl then
						local stats = data.stats
						local currentTimer = stats.AccumulatedTime
						if stats.IsInGame then
							currentTimer = currentTimer + (tick() - stats.LastJoinTick)
						end
						statsLbl.Text = "دخول: " .. stats.JoinCount .. " | خروج: " .. stats.LeaveCount .. " | الوقت: " .. formatTime(currentTimer)
					end
				end
			end
		end
	end
end)

local function toggleFrame(frame)
	if frame.Visible == false then
		scriptActive = true
		frame.Visible = true
		frame.Size = UDim2.new(0, 0, 0, 0)
		frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		local tween = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 540, 0, 390),
			Position = UDim2.new(0.5, -270, 0.5, -195)
		})
		tween:Play()
	else
		scriptActive = false
		local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0)
		})
		tween:Play()
		tween.Completed:Connect(function()
			frame.Visible = false
			frame.Size = UDim2.new(0, 540, 0, 390)
			frame.Position = UDim2.new(0.5, -270, 0.5, -195)
		end)
	end
end

Button.MouseButton1Click:Connect(function()
	toggleFrame(Frame)
end)
