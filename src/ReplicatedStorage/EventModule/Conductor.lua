local Players = game:GetService("Players")
local player = Players.LocalPlayer

local EventModule = script:FindFirstAncestor("EventModule")

local Conductor = {}

Conductor.ShowCountdown = require(EventModule.Functions.showCountdown)
Conductor.ShowVotingGUI = require(EventModule.Functions.showVotingGUI)

-- Events
Conductor.Countdown = EventModule.Events.ServerEvents.Countdown :: RemoteEvent
Conductor.CountdownFinished = EventModule.Events.ClientEvents.CountdownFinishedForClient :: BindableEvent

local hasBeenCalled = false

return function(stubs)
	if hasBeenCalled then
		error("Conductor has already been called")
		return
	end
	
	-- Connect events
	Conductor.handleShowCountdown = Conductor.ShowCountdown()
	Conductor.Countdown.OnClientEvent:Connect(Conductor.handleShowCountdown)
	
	-- Display the voting GUI after the countdown
	Conductor.handleShowVotingGUI = Conductor.ShowVotingGUI()
	Conductor.CountdownFinished.Event:Connect(Conductor.handleShowVotingGUI)
	
	hasBeenCalled = true

	return Conductor
end
