local Players = game:GetService("Players")

local EventModule = script:FindFirstAncestor("EventModule")
local enums = require(EventModule.enums)

local playerGui = Players.LocalPlayer and Players.LocalPlayer:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("GameGui")

local voteRemote = EventModule.Events.ClientEvents.Vote :: RemoteEvent

local connections = {}

--[[
	showVotingGUI Module Script

	This module script defines the function to handle and display the voting GUI in the game.

	Parameters:
	- voteFrame: The frame that will be handling the voting.
]]

local function disconnectOldConnections()
	for _, connection in ipairs(connections) do
		if connection then
			connection:Disconnect()
		end
	end
	
	connections = {}
end

local function showVotingGUI(voteFrame)
	--[[ 
		Inner function to handle the voting GUI.
	]]
	voteFrame = voteFrame or mainGui.Frames.Vote
	
	return function(countdownName)
		local background = voteFrame.Background
		local blueTeamButton = background.BlueTeamButton
		local greenTeamButton = background.GreenTeamButton
		
		local function closeVoteFrame()
			voteFrame.Visible = false
			disconnectOldConnections()
		end
		
		local function handleBlueTeamVoteButton()
			closeVoteFrame()
			-- Fire the server the selected team and the player's vote.
			voteRemote:FireServer(Players.LocalPlayer, enums.TeamOptions.Blue)
		end
		
		local function handleGreenTeamVoteButton()
			closeVoteFrame()
			-- Fire the server the selected team and the player's vote.
			voteRemote:FireServer(Players.LocalPlayer, enums.TeamOptions.Green)
		end
		
		-- Disconnect old connections.
		disconnectOldConnections()
		
		-- Connect button actions and store connections in the activeConnections table.
		table.insert(connections, blueTeamButton.MouseButton1Click:Connect(handleBlueTeamVoteButton))
		table.insert(connections, greenTeamButton.MouseButton1Click:Connect(handleGreenTeamVoteButton))
		
		-- Make the voteFrame frame visible.
		voteFrame.Visible = countdownName == enums.CountdownNames.Intermission
	end
end

return showVotingGUI
