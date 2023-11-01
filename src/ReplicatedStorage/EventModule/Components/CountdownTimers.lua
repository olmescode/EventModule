local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local countdownRemote = ReplicatedStorage.Remotes.Countdown :: RemoteEvent

local COUNTDOWN_DURATION = 20 -- 20 seconds

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
end

local function addTimeToCountdown()
	--[[ 
		Inner function to handle the countdown in the server and updates.

		Parameters:
		
	]]
	return function(countdownName, duration)
		-- Store the remaining time for this action
		activeCountdowns[countdownName] = activeCountdowns[countdownName] or {}

		if activeCountdowns[countdownName] then
			-- Add more time to the existing countdown
			activeCountdowns[countdownName] += duration or COUNTDOWN_DURATION

			-- Fire to client the updated time
			local currentTime = activeCountdowns[countdownName]
			countdownRemote:FireAllClients(currentTime, countdownName)
			return
		end

		-- Start a new countdown
		activeCountdowns[countdownName] = duration or COUNTDOWN_DURATION

		-- Start the countdown action
		countdownStart(countdownName)
	end
end

return addTimeToCountdown