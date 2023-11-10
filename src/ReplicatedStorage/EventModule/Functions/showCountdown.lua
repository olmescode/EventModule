local Players = game:GetService("Players")

local EventModule = script:FindFirstAncestor("EventModule")
local constants = require(EventModule.constants)

local playerGui = Players.LocalPlayer and Players.LocalPlayer:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("GameGui")

local CountdownFinishedForClient = EventModule.Events.ClientEvents.CountdownFinishedForClient :: BindableEvent

--[[
	showCountdown Module Script

	This module script defines the function to handle the countdown display the GUI game.

	Parameters:
	- countdownFrame: The frame that will be displaying the countdown.
]]
local activeCountdowns = {}

local function showCountdown(countdownFrame, taskLib)
	--[[ 
		Inner function to handle the countdown display and updates.

		Parameters:
		- currentTime: The starting time for the countdown in seconds.
		- countdownName: The name of the countdown.
	]]
	countdownFrame = countdownFrame or mainGui.ShowStats.Countdown
	taskLib = if taskLib then taskLib else task
	
	return function(currentTime, countdownName)	
		local hasActiveCountdowns = false
		
		if activeCountdowns[countdownName] then
			-- Add more time to the existing countdown
			activeCountdowns[countdownName] += currentTime
			return
		end
		
		-- Update the currentTime and store the time
		activeCountdowns[countdownName] = currentTime
		
		-- Make the boostFrame label visible
		countdownFrame.Visible = true
		
		-- Function to convert remaining time (currentTime) to MM:SS format
		local function currentTimeToStr(updatedTime)
			local minutes = math.floor(updatedTime / 60)
			local seconds = updatedTime % 60
			return string.format("%02d:%02d", minutes, seconds)
		end
		
		-- Function to update the boostFrame label
		local function updateCountdownLabel(updatedTime, countdownName)
			local label = countdownFrame[countdownName]
			if label then
				local currentText = label.Text
				label.Text = string.gsub(currentText, "%d+:%d+", currentTimeToStr(updatedTime))
			end
		end
		
		while activeCountdowns[countdownName] > 0 do
			-- Update the remaining time for the countdown
			activeCountdowns[countdownName] -= 1
			
			-- Update the boostFrame label with the current time and actionString
			updateCountdownLabel(activeCountdowns[countdownName], countdownName)
			taskLib.wait(1)
		end
		
		-- Clear the remaining time for this action when the countdown is finished
		activeCountdowns[countdownName] = nil
		
		-- Check if there are no more active countdowns
		for countdownName, countdownTime in pairs(activeCountdowns) do
			if countdownTime and countdownTime > 0 then
				hasActiveCountdowns = true
				break
			end
		end

		-- Hide the boostFrame when there are no more active countdowns
		if not hasActiveCountdowns then
			countdownFrame.Visible = false
		end
		
		-- Fire an event to enable showVotingGui
		CountdownFinishedForClient:Fire(countdownName)
	end
end

return showCountdown
