-- Senko

-- Variables

local Folder = script.Parent
local MainEvent = Folder:WaitForChild('Main')
local SubEvent = Folder:WaitForChild("Sub")

local InputService = game:GetService("UserInputService")

local isBlocking = false
local Equipped = true

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- Functions

MainEvent:FireServer('Equip')

MainEvent.OnClientEvent:Connect(function(action, bool)
	if action == 'ChangeBlock' then
		isBlocking = bool
	end
end)


InputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	
	if input.KeyCode == Enum.KeyCode.Z then
		if isBlocking then return end
		
		-- Avenger
		
		MainEvent:FireServer('SpecialMove', {Name = 'Avenger'})
		
	end
	
	if input.KeyCode == Enum.KeyCode.F then
		if not isBlocking then
			-- Not Blocking
			
			MainEvent:FireServer('Block', {Bool = true})
		
		end
	end
	
	if input.KeyCode == Enum.KeyCode.Q then
		if isBlocking then return end
		if SubEvent:InvokeServer('Check', 'Equip') then return end
		
		-- Equip and unequip.
		
		if Equipped == true then
			Equipped = false
			
			-- Unequip
			
			MainEvent:FireServer('WeldEquip', {Bool = false})
			
		elseif Equipped == false then
			Equipped = true
			
			-- Equip
			
			MainEvent:FireServer('WeldEquip', {Bool = true})
		end
		
	end
end)

InputService.InputEnded:Connect(function(input, gpe)	
	if input.KeyCode == Enum.KeyCode.F then
		
		if isBlocking then
			-- Blocking
			
			MainEvent:FireServer('Block', {Bool = false})
		end
		
	end
end)

Mouse.Button1Down:Connect(function()
	MainEvent:FireServer("Attack", {})
end)
