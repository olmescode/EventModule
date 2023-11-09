print("Required EventModule")
local RunService = game:GetService("RunService")

local loadCountdown = require(script.Api.loadCountdown)

local CountdownFinishedForServer = script.Events.ServerEvents.CountdownFinished :: BindableEvent

if RunService:IsServer() then
	local waitForConductor = require(script.waitForConductor)
	waitForConductor:call()
end

local EventModule = {
	-- Server API
	loadCountdown = loadCountdown,
	
	-- Events
	onCountdownFinishedForServer = CountdownFinishedForServer.Event
}

return EventModule
