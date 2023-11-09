local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventModule = require(ReplicatedStorage:WaitForChild("EventModule"))

local INTERMISSION_DURATION = 30 -- 60 seconds
local VOTE_DURATION = 20
local COUNTDOWN_NAME = "Countdown"
local VOTE_COUNTDOWN_NAME = "VoteCountdown"

EventModule.onCountdownFinishedForServer:Connect(function(countdownName)
	EventModule.loadCountdown(VOTE_COUNTDOWN_NAME, VOTE_DURATION)
end)

EventModule.loadCountdown(COUNTDOWN_NAME, INTERMISSION_DURATION)
