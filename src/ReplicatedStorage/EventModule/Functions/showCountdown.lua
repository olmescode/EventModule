local Players = game:GetService("Players")

local playerGui = Players.LocalPlayer and Players.LocalPlayer:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("GameGui")

--[[
	showBoostCountdown Module Script

	This module script defines the function to handle the countdown display for special effects in the Prison Simulator game.

	Parameters:
	- boostFrame: The frame that contains the TextLabels for displaying the countdown.
]]
local activeCountdowns = {}

local function showCountdown(countdownFrame)
	--[[ 
		Inner function to handle the countdown display and updates.

		Parameters:
		- currentTime: The starting time for the countdown in seconds.
		- actionString: The name of the action, e.g., "Speed", "Money", "Damage".
	]]
	countdownFrame = countdownFrame or mainGui.mainGui.ShowStats.Countdown
	
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
		local function updateBoostLabel(updatedTime, countdownName)
			local label = countdownFrame[countdownName]
			if label then
				label.Text = "Game Starting in " .. currentTimeToStr(updatedTime) .. "Seconds"
			end
		end
		
		while activeCountdowns[countdownName] > 0 do
			-- Update the remaining time for the countdown
			activeCountdowns[countdownName] -= 1
			
			-- Update the boostFrame label with the current time and actionString
			updateBoostLabel(activeCountdowns[countdownName], countdownName)
			task.wait(1)
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
	end
end

return showCountdown