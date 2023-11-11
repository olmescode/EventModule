print("Required EventModule")
local RunService = game:GetService("RunService")

local loadCountdown = require(script.Api.loadCountdown)
local assignPlayerToTeam = require(script.Api.assignPlayerToTeam)
local TeamRebalancer = require(script.Modules.TeamRebalancer)

local CountdownFinishedForServer = script.Events.ServerEvents.CountdownFinished :: BindableEvent

if RunService:IsServer() then
	local waitForConductor = require(script.waitForConductor)
	waitForConductor:call()
end

local EventModule = {
	-- Server API
	loadCountdown = loadCountdown,
	assignPlayerToTeam = assignPlayerToTeam,
	teamRebalancer = TeamRebalancer,
	
	-- Events
	onCountdownFinishedForServer = CountdownFinishedForServer.Event
}

return EventModule
