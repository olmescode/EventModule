local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventModule = require(ReplicatedStorage:WaitForChild("EventModule"))

-- Durations (in seconds)
local INTERMISSION_DURATION = 10 -- 30 seconds for intermission
local VOTE_DURATION = 10 -- 20 seconds for voting
local ROUND_DURATION = 180 -- 180 seconds for a round

-- Countdown Names
local INTERMISSION_COUNTDOWN_NAME = "IntermissionCountdown"
local VOTE_COUNTDOWN_NAME = "VoteCountdown"
local ROUND_COUNTDOWN_NAME = "RoundCountdown"

-- Function to load the next countdown based on the previous one
local function loadNextCountdown(previousCountdown)
	if previousCountdown == INTERMISSION_COUNTDOWN_NAME then
		EventModule.loadCountdown(VOTE_COUNTDOWN_NAME, VOTE_DURATION)
	elseif previousCountdown == VOTE_COUNTDOWN_NAME then
		EventModule.loadCountdown(ROUND_COUNTDOWN_NAME, ROUND_DURATION)
	elseif previousCountdown == ROUND_COUNTDOWN_NAME then
		EventModule.loadCountdown(INTERMISSION_COUNTDOWN_NAME, INTERMISSION_DURATION)
	end
end

-- Connect the event handler for countdown finishing
EventModule.onCountdownFinishedForServer:Connect(function(countdownName)
	loadNextCountdown(countdownName)
	
	if countdownName == "VoteCountdown" then
		EventModule.teamRebalancer()
	end
end)

-- Initial load of the intermission countdown
EventModule.loadCountdown(INTERMISSION_COUNTDOWN_NAME, INTERMISSION_DURATION)
