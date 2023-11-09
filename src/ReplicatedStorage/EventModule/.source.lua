print("Required EventModule")
local RunService = game:GetService("RunService")

local CountdownTimers = require(script.Components.CountdownTimers)
local loadCountdown = require(script.Api.loadCountdown)

local CountdownFinishedForServer = script.Events.ServerEvents.CountdownFinished :: BindableEvent

if RunService:IsServer() then
	local waitForConductor = require(script.waitForConductor)
	waitForConductor:call()
end

local EventModule = {
	loadCountdown = loadCountdown,
	
	addTimeToCountdown = CountdownTimers(),
	
	onCountdownFinishedForServer = CountdownFinishedForServer.Event
}

return EventModule
