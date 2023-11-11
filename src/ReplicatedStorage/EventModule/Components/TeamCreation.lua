local Teams = game:GetService("Teams")

local EventModule = script:FindFirstAncestor("EventModule")
local constants = require(EventModule.constants).Teams

--[[
	TeamCreation Module Script

	This module script is responsible for creating teams in the game.
]]
return function()
	-- Check if the teams already exist (to avoid duplicates)
	local blueTeam = Teams:FindFirstChild(Teams.Blue.Name)
	local greenTeam = Teams:FindFirstChild(Teams.Green.Name)
	local defaultTeam = Teams:FindFirstChild(Teams.Default.Name)

	if not blueTeam then
		blueTeam = Instance.new("Team")
		blueTeam.Name = Teams.Blue.Name
		blueTeam.TeamColor = Teams.Blue.TeamColor
		blueTeam.AutoAssignable = Teams.Blue.AutoAssignable
		blueTeam.Parent = Teams
	end

	if not greenTeam then
		greenTeam = Instance.new("Team")
		greenTeam.Name = Teams.Green.Name
		greenTeam.TeamColor = Teams.Green.TeamColor
		greenTeam.AutoAssignable = Teams.Green.AutoAssignable
		greenTeam.Parent = Teams
	end

	if not defaultTeam then
		defaultTeam = Instance.new("Team")
		defaultTeam.Name = Teams.Default.Name
		defaultTeam.TeamColor = Teams.Default.TeamColor
		defaultTeam.AutoAssignable = Teams.Default.AutoAssignable
		defaultTeam.Parent = Teams
	end
end
