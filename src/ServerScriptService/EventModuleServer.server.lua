local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventModule = require(ReplicatedStorage:WaitForChild("EventModule"))

local COUNTDOWN_DURATION = 60 -- 60 seconds
local COUNTDOWN_NAME = "INTERMISISON"

EventModule.addTimeToCountdown(COUNTDOWN_NAME, COUNTDOWN_DURATION)

