local Players = game:GetService("Players")
local player = Players.LocalPlayer

local EventModule = script:FindFirstAncestor("EventModule")
local EventModuleAPI = require(EventModule)

local Conductor = {}

Conductor.ShowCountdown = require(EventModule.Functions.showCountdown)

-- Events
Conductor.Countdown = EventModule.Remotes.Countdown :: RemoteEvent

local hasBeenCalled = false

return function(stubs)
	if hasBeenCalled then
		error("Conductor has already been called")
		return
	end
	
	-- Connect events
	Conductor.handleShowCountdown = Conductor.ShowCountdown()
	Conductor.Countdown.OnClientEvent:Connect(Conductor.handleShowCountdown)
	
	hasBeenCalled = true

	return Conductor
end
