--disable
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventModule = ReplicatedStorage:WaitForChild("EventModule")
local showCountdown = require(EventModule.Functions.showCountdown)

local remotes = EventModule:WaitForChild("Events")
local countdownRemote = remotes:WaitForChild("Countdown") :: RemoteEvent

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("GameGui")

local countdownFrame = mainGui.ShowStats.Countdown

--[[
	LocalScript to handle the countdown of Events
]]

-- Connect the "countdownRemote" event to the 'showCountdown' function
countdownRemote.OnClientEvent:Connect(showCountdown(countdownFrame))
