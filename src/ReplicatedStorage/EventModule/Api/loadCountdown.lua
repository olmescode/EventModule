local RunService = game:GetService("RunService")

local EventModule = script:FindFirstAncestor("EventModule")
local state = require(EventModule.state)

local LoadCountdownServer = EventModule.Events.ServerEvents.LoadCountdown :: BindableEvent

return function(countdownName, duration, taskLib)
	assert(RunService:IsServer(), "Loading a countdown can only be programmatically called from the server")
	assert(duration == nil or typeof(duration) == "number", "Duration must be a number")
	
	taskLib = if taskLib then taskLib else task
	
	if not state.ClientFrameworkReady then
		repeat
			taskLib.wait()
		until state.ClientFrameworkReady
	end
	
	LoadCountdownServer:Fire(countdownName, duration)
end
