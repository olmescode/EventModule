print("Required EventModule")
local CountdownTimers = require(script.Components.CountdownTimers)

local CountdownFinishedForServer = script.Events.ServerEvents.CountdownFinished

local EventModule = {
	addTimeToCountdown = CountdownTimers(),
	
	onCountdownFinishedForServer = CountdownFinishedForServer.Event
}

return EventModule
