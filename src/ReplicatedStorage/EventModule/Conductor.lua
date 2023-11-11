local Players = game:GetService("Players")
local player = Players.LocalPlayer

local EventModule = script:FindFirstAncestor("EventModule")
local enums = require(EventModule.enums)

local Conductor = {}

Conductor.CountdownTimers = require(EventModule.Components.CountdownTimers)
Conductor.ConductorReadyHandler = require(EventModule.Components.ConductorReadyHandler)
Conductor.AssignPlayerToTeam = require(EventModule.Api.assignPlayerToTeam)

-- Events
Conductor.LoadCountdownServer = EventModule.Events.ServerEvents.LoadCountdown :: BindableEvent
Conductor.ConductorReady = EventModule.Events.ClientEvents.ConductorReady :: RemoteEvent
Conductor.VoteRemote = EventModule.Events.ClientEvents.Vote :: RemoteEvent

local hasBeenCalled = false

return function(stubs)
	if hasBeenCalled then
		error("Conductor has already been called")
		return
	end
	
	-- Create a new countdown timer
	Conductor.handleLoadCountdown = Conductor.CountdownTimers()
	Conductor.LoadCountdownServer.Event:Connect(Conductor.handleLoadCountdown)
	
	-- Connect to the ConductorReady event to handle readiness on the server side
	Conductor.handleCounductorReady =  Conductor.ConductorReadyHandler
	Conductor.ConductorReady.OnServerEvent:Connect(Conductor.handleCounductorReady)
	
	-- Connect to the VoteRemote event to AssignPlayerToTeam on the server side
	Conductor.handleAssignPlayerToTeam = Conductor.AssignPlayerToTeam
	Conductor.VoteRemote.OnServerEvent:Connect(Conductor.handleAssignPlayerToTeam)
	
	hasBeenCalled = true
	
	-- Set an attribute indicating that the framework is ready
	script:SetAttribute(enums.Attribute.FrameworkReady, true)
	
	return Conductor
end
