local Players = game:GetService("Players")

local EventModule = script:FindFirstAncestor("EventModule")

local enums = require(EventModule.enums)

local playerGui = Players.LocalPlayer and Players.LocalPlayer:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("GameGui")

local voteRemote = EventModule.Remotes.Vote

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
	
	return function(_)
		local background = voteFrame.Background
		local blueTeamButton = background.BlueTeamButton
		local greenTeamButton = background.GreenTeamButton
		
		local function handleBlueTeamVoteButton()
			-- Fire the server the selected team and the player's vote.
			voteRemote:FireServer(enums.TeamOptions.Blue, Players.LocalPlayer)
		end
		
		local function handleGreenTeamVoteButton()
			-- Fire the server the selected team and the player's vote.
			voteRemote:FireServer(enums.TeamOptions.Green, Players.LocalPlayer)
		end
		
		-- Disconnect old connections.
		disconnectOldConnections()
		
		-- Connect button actions and store connections in the activeConnections table.
		table.insert(connections, blueTeamButton.MouseButton1Click:Connect(handleBlueTeamVoteButton))
		table.insert(connections, greenTeamButton.MouseButton1Click:Connect(handleGreenTeamVoteButton))
		
		-- Make the voteFrame frame visible.
		voteFrame.Visible = true
	end
end

return showVotingGUI
