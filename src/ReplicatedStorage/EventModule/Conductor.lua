local Players = game:GetService("Players")
local player = Players.LocalPlayer

local EventModule = script:FindFirstAncestor("EventModule")
local enums = require(EventModule.enums)

local Conductor = {}

Conductor.CountdownTimers = require(EventModule.Components.CountdownTimers)
Conductor.ConductorReadyHandler = require(EventModule.Components.ConductorReadyHandler)

-- Events
Conductor.LoadCountdownServer = EventModule.Events.ServerEvents.LoadCountdown :: BindableEvent
Conductor.ConductorReady = EventModule.Events.ClientEvents.ConductorReady :: RemoteEvent

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
	
	hasBeenCalled = true
	
	-- Set an attribute indicating that the framework is ready
	script:SetAttribute(enums.Attribute.FrameworkReady, true)
	
	return Conductor
end
