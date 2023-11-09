local RunService = game:GetService("RunService")

local EventModule = script:FindFirstAncestor("EventModule")
local state = require(EventModule.state)

local LoadCountdownServer = EventModule.Events.ServerEvents.LoadCountdown :: BindableEvent

--[[
	loadCountdown Module Script

	This module script defines the function to load a countdown on the server

	Parameters:
	- eventToFire (string): The name of the event to fire when the countdown ends
	- countdownTime (number): The time in seconds for the countdown to last
]]
return function(countdownName, duration, taskLib)
	assert(RunService:IsServer(), "Loading a countdown can only be programmatically called from the server")
	assert(duration == nil or typeof(duration) == "number", "Duration must be a number")
	
	taskLib = if taskLib then taskLib else task
	
	-- Wait until the client framework is ready before proceeding
	if not state.ClientFrameworkReady then
		repeat
			taskLib.wait()
		until state.ClientFrameworkReady
	end
	
	-- Extra wait for race conditions between client events and event sending
	taskLib.wait()
	
	-- Fire the LoadCountdownServer event to initiate a countdown
	LoadCountdownServer:Fire(countdownName, duration)
end
