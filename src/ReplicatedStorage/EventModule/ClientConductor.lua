local Players = game:GetService("Players")
local player = Players.LocalPlayer

local EventModule = script:FindFirstAncestor("EventModule")
local enums = require(EventModule.enums)

local Conductor = {}

Conductor.ShowCountdown = require(EventModule.Functions.showCountdown)
Conductor.ShowVotingGUI = require(EventModule.Functions.showVotingGUI)

-- Events
Conductor.Countdown = EventModule.Events.ServerEvents.Countdown :: RemoteEvent
Conductor.CountdownFinished = EventModule.Events.ClientEvents.CountdownFinishedForClient :: BindableEvent
Conductor.ConductorReady = EventModule.Events.ClientEvents.ConductorReady :: RemoteEvent

local hasBeenCalled = false

return function(stubs)
	if hasBeenCalled then
		error("Conductor has already been called")
		return
	end
	
	-- Display a countdown GUI
	Conductor.handleShowCountdown = Conductor.ShowCountdown()
	Conductor.Countdown.OnClientEvent:Connect(Conductor.handleShowCountdown)
	
	-- Display the voting GUI after the countdown
	Conductor.handleShowVotingGUI = Conductor.ShowVotingGUI()
	Conductor.CountdownFinished.Event:Connect(Conductor.handleShowVotingGUI)
	
	hasBeenCalled = true
	
	-- Inform the server that the conductor is ready
	Conductor.ConductorReady:FireServer()
	
	return Conductor
end
