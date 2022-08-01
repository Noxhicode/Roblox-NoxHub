local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("NoxHub", "Ocean")
local flying = true

--Info--
local Info = Window:NewTab("Info")
local InfoSection = Info:NewSection("The Script will detect, which game your playing.")
InfoSection:NewLabel("In this moment I´ve only created custom cheats for")
InfoSection:NewLabel("arsenal and phantom forces")
InfoSection:NewLabel("But if you are playing a game")
InfoSection:NewLabel("that I didnt customized yet")
InfoSection:NewLabel("you will have the basic options(fly, aimlock, click tp,...")
InfoSection:NewLabel("But u dont Promise that they work properly")

--BASIC--

--Player--
local Basic = Window:NewTab("Basic")
local BasicSection = Basic:NewSection("Player")

--Aimbot--
BasicSection:NewButton("Aimbot", "Get a Aimbot for every game", function()
    local Camera = workspace.CurrentCamera
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local LocalPlayer = Players.LocalPlayer
        local Holding = false
        
        _G.AimbotEnabled = true
        _G.TeamCheck = true -- If set to true then the script would only lock your aim at enemy team members.
        _G.AimPart = "Head" -- Where the aimbot script would lock at.
        _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.
        
        _G.CircleSides = 64 -- How many sides the FOV circle would have.
        _G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
        _G.CircleTransparency = 0.7 -- Transparency of the circle.
        _G.CircleRadius = 80 -- The radius of the circle / FOV.
        _G.CircleFilled = false -- Determines whether or not the circle is filled.
        _G.CircleVisible = true -- Determines whether or not the circle is visible.
        _G.CircleThickness = 0 -- The thickness of the circle.
        
        local FOVCircle = Drawing.new("Circle")
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOVCircle.Radius = _G.CircleRadius
        FOVCircle.Filled = _G.CircleFilled
        FOVCircle.Color = _G.CircleColor
        FOVCircle.Visible = _G.CircleVisible
        FOVCircle.Radius = _G.CircleRadius
        FOVCircle.Transparency = _G.CircleTransparency
        FOVCircle.NumSides = _G.CircleSides
        FOVCircle.Thickness = _G.CircleThickness
        
        local function GetClosestPlayer()
            local MaximumDistance = _G.CircleRadius
            local Target = nil
        
            for _, v in next, Players:GetPlayers() do
                if v.Name ~= LocalPlayer.Name then
                    if _G.TeamCheck == true then
                        if v.Team ~= LocalPlayer.Team then
                            if v.Character ~= nil then
                                if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                    if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                        local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                        
                                        if VectorDistance < MaximumDistance then
                                            Target = v
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if v.Character ~= nil then
                            if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                    local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                    local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                    
                                    if VectorDistance < MaximumDistance then
                                        Target = v
                                    end
                                end
                            end
                        end
                    end
                end
            end
        
            return Target
        end
        
        UserInputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = false
            end
        end)
        
        RunService.RenderStepped:Connect(function()
            FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
            FOVCircle.Radius = _G.CircleRadius
            FOVCircle.Filled = _G.CircleFilled
            FOVCircle.Color = _G.CircleColor
            FOVCircle.Visible = _G.CircleVisible
            FOVCircle.Radius = _G.CircleRadius
            FOVCircle.Transparency = _G.CircleTransparency
            FOVCircle.NumSides = _G.CircleSides
            FOVCircle.Thickness = _G.CircleThickness
        
            if Holding == true and _G.AimbotEnabled == true then
                TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
            end
        end)
end)

BasicSection:NewSlider("Aimbot FOV", "Radius around the crosshair", 1000, 0, function(s) -- 1000 (MaxValue) | 0 (MinValue)
    _G.CircleRadius = s
end)

BasicSection:NewButton("ESP", "see people trough walls...", function()
    local Esp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/x114/RobloxScripts/main/OpenSourceEsp"))()
-- Boxes --
    Esp.Box = true
    Esp.BoxColor = Color3.fromRGB(255,255,255)
    Esp.BoxOutline = true
    Esp.BoxOutlineColor = Color3.fromRGB(0,0,0)
    -- HealthBars --
    Esp.HealthBar = true
    Esp.HealthBarSide = "Left" -- Left,Bottom,Right
    -- Names --
    Esp.Names = true
    Esp.NamesColor = Color3.fromRGB(255,255,255)
    Esp.NamesOutline = true
    Esp.NamesFont = 2
    Esp.NamesSize = 13
end)






--Infinite Jump--
BasicSection:NewButton("Infinity Jump", "Jump in the air/Spam spacebar to fly", function()
    infinitJump()
end)

--CLICKTP--
BasicSection:NewButton("Click TP", "Strg+click to Teleport", function()
    ClickTp()
end)

--WALKSPEED--
 BasicSection:NewSlider("WalkingSpeed", "keep it between 0 and 30, to high will get you kicked", 500, 0, function(s) -- 50 (MaxValue) | 0 (MinValue) 
    getgenv().WalkSpeedValue = s; --set your desired walkspeed here
    local Player = game:service'Players'.LocalPlayer;
    Player.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
    Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
    end)
    Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;

end)





--ARSENAL--

if game.PlaceId == 286090429 then
    local Arsenal = Window:NewTab("--Arsenal--")
    local Player = Window:NewTab("Player")
    local Movement = Player:NewSection("Movement")

    --WALKSPEED--
    Movement:NewSlider("WalkingSpeed", "keep it between 0 and 30, to high will get you kicked", 500, 0, function(s) -- 50 (MaxValue) | 0 (MinValue) 
        getgenv().WalkSpeedValue = s; --set your desired walkspeed here
        local Player = game:service'Players'.LocalPlayer;
        Player.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
        Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;
        end)
        Player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeedValue;

    end)

    --Aimbot--

    local Combat = Window:NewTab("Combat")
    local Aim = Combat:NewSection("Aim")

    Aim:NewButton("Aimbot", "instant lock on nearest person", function()

        local Camera = workspace.CurrentCamera
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local LocalPlayer = Players.LocalPlayer
        local Holding = false
        
        _G.AimbotEnabled = true
        _G.TeamCheck = true -- If set to true then the script would only lock your aim at enemy team members.
        _G.AimPart = "Head" -- Where the aimbot script would lock at.
        _G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.
        
        _G.CircleSides = 64 -- How many sides the FOV circle would have.
        _G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
        _G.CircleTransparency = 0.7 -- Transparency of the circle.
        _G.CircleRadius = 80 -- The radius of the circle / FOV.
        _G.CircleFilled = false -- Determines whether or not the circle is filled.
        _G.CircleVisible = true -- Determines whether or not the circle is visible.
        _G.CircleThickness = 0 -- The thickness of the circle.
        
        local FOVCircle = Drawing.new("Circle")
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOVCircle.Radius = _G.CircleRadius
        FOVCircle.Filled = _G.CircleFilled
        FOVCircle.Color = _G.CircleColor
        FOVCircle.Visible = _G.CircleVisible
        FOVCircle.Radius = _G.CircleRadius
        FOVCircle.Transparency = _G.CircleTransparency
        FOVCircle.NumSides = _G.CircleSides
        FOVCircle.Thickness = _G.CircleThickness
        
        local function GetClosestPlayer()
            local MaximumDistance = _G.CircleRadius
            local Target = nil
        
            for _, v in next, Players:GetPlayers() do
                if v.Name ~= LocalPlayer.Name then
                    if _G.TeamCheck == true then
                        if v.Team ~= LocalPlayer.Team then
                            if v.Character ~= nil then
                                if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                    if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                        local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                        
                                        if VectorDistance < MaximumDistance then
                                            Target = v
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if v.Character ~= nil then
                            if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                                if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                    local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                    local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                                    
                                    if VectorDistance < MaximumDistance then
                                        Target = v
                                    end
                                end
                            end
                        end
                    end
                end
            end
        
            return Target
        end
        
        UserInputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Holding = false
            end
        end)
        
        RunService.RenderStepped:Connect(function()
            FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
            FOVCircle.Radius = _G.CircleRadius
            FOVCircle.Filled = _G.CircleFilled
            FOVCircle.Color = _G.CircleColor
            FOVCircle.Visible = _G.CircleVisible
            FOVCircle.Radius = _G.CircleRadius
            FOVCircle.Transparency = _G.CircleTransparency
            FOVCircle.NumSides = _G.CircleSides
            FOVCircle.Thickness = _G.CircleThickness
        
            if Holding == true and _G.AimbotEnabled == true then
                TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
            end
        end)
    end)
    
   


    Aim:NewSlider("Aimbot FOV", "Radius around the crosshair", 500, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
        _G.CircleRadius = s
    end)



    local Aim = Combat:NewSection("Visual")

    Aim:NewButton("ESP", "see people trough walls...", function()
        local Esp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/x114/RobloxScripts/main/OpenSourceEsp"))()
     -- Boxes --
        Esp.Box = true
        Esp.BoxColor = Color3.fromRGB(255,255,255)
        Esp.BoxOutline = false
        Esp.BoxOutlineColor = Color3.fromRGB(0,0,0)
        -- HealthBars --
        Esp.HealthBar = true
        Esp.HealthBarSide = "Left" -- Left,Bottom,Right
        -- Names --
        Esp.Names = true
        Esp.NamesColor = Color3.fromRGB(255,255,255)
        Esp.NamesOutline = true
        Esp.NamesFont = 2
        Esp.NamesSize = 13
    end)

end






--INFINITJUMP FUNCTION---

function infinitJump()
--Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
	--Ensures this only runs once to save resources
	_G.infinJumpStarted = true
	
	--Notifies readiness
	game.StarterGui:SetCore("SendNotification", {Title="NoxhiDev"; Text="Your NoxhiDev infinit Jump got enabled!"; Duration=5;})

	--The actual infinite jump
	local plr = game:GetService('Players').LocalPlayer
	local m = plr:GetMouse()
	m.KeyDown:connect(function(k)
		if _G.infinjump then
			if k:byte() == 32 then
			humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
			humanoid:ChangeState('Jumping')
			wait()
			humanoid:ChangeState('Seated')
			end
		end
	end)
end
end


function ClickTp()
    --Makes sure this script is only executed once
if _G.WRDClickTeleport == nil then
	_G.WRDClickTeleport = true
	
	local player = game:GetService("Players").LocalPlayer
	local UserInputService = game:GetService("UserInputService")
	 --Wanted to avoid using mouse instance, but UIS^ is very tedious to get mouse hit position
	local mouse = player:GetMouse()

	--Waits until the player's mouse is found
	repeat wait() until mouse
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			--Only click teleport if the toggle is enabled
			if _G.WRDClickTeleport and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				player.Character:MoveTo(Vector3.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z)) 
			end
		end
	end)
--Just toggle instead of re-executing the script
else
	_G.WRDClickTeleport = not _G.WRDClickTeleport
	--Notify
	if _G.WRDClickTeleport then
		game.StarterGui:SetCore("SendNotification", {Title="NoxhiDev"; Text="Click teleport enabled"; Duration=5;})
	else
		game.StarterGui:SetCore("SendNotification", {Title="NoxhiDev"; Text="Click teleport disabled"; Duration=5;})
	end
end
end