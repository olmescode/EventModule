local EventModule = script:FindFirstAncestor("EventModule")

local constants = require(EventModule.constants)

local countdownRemote = EventModule.Events.ServerEvents.Countdown :: RemoteEvent
local CountdownFinishedForServer = EventModule.Events.ServerEvents.CountdownFinished :: BindableEvent

local activeCountdowns = {}

local function countdownStart(countdownName, taskLib)
	taskLib = if taskLib then taskLib else task
	
	local currentTime = activeCountdowns[countdownName]
	
	-- Fire to client the currentTimed and start a countdown in the client
	countdownRemote:FireAllClients(currentTime, countdownName)

	while activeCountdowns[countdownName] > 0 do
		-- Update the remaining time for the countdown
		activeCountdowns[countdownName] -= 1
		taskLib.wait(1)
	end

	-- Clear the remaining time for this action when the countdown is finished
	activeCountdowns[countdownName] = nil
	
	CountdownFinishedForServer:Fire(countdownName)
end

local function addTimeToCountdown()
	--[[ 
		Inner function to handle the countdown in the server and updates.

		Parameters:
		countdownName: string, the name of the countdown to add time.
		duration: number, the amount of seconds to add to the countdown.
	]]
	return function(countdownName, duration)
		-- Store the remaining time for this action
		activeCountdowns[countdownName] = activeCountdowns[countdownName]
		
		if activeCountdowns[countdownName] then
			-- Add more time to the existing countdown
			activeCountdowns[countdownName] += duration or constants.COUNTDOWN_DURATION

			-- Fire to client the updated time
			local currentTime = activeCountdowns[countdownName]
			countdownRemote:FireAllClients(currentTime, countdownName)
			return
		end

		-- Start a new countdown
		activeCountdowns[countdownName] = duration or constants.COUNTDOWN_DURATION
		
		-- Start the countdown action
		countdownStart(countdownName)
	end
end

return addTimeToCountdown
