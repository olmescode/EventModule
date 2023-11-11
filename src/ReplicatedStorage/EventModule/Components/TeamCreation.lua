local Teams = game:GetService("Teams")

local EventModule = script:FindFirstAncestor("EventModule")
local teams = require(EventModule.constants).Teams

--[[
	TeamCreation Module Script

	This module script is responsible for creating teams in the game.
]]
return function()
	-- Get the existing teams
	local existingTeams = Teams:GetTeams()
	
	-- Check if the teams already exist (to avoid duplicates)
	local blueTeam = existingTeams[teams.Blue.Name]
	local greenTeam = existingTeams[teams.Green.Name]
	local defaultTeam = existingTeams[teams.Default.Name]

	if not blueTeam then
		blueTeam = Instance.new("Team")
		blueTeam.Name = teams.Blue.Name
		blueTeam.TeamColor = teams.Blue.TeamColor
		blueTeam.AutoAssignable = teams.Blue.AutoAssignable
		blueTeam.Parent = Teams
	end

	if not greenTeam then
		greenTeam = Instance.new("Team")
		greenTeam.Name = teams.Green.Name
		greenTeam.TeamColor = teams.Green.TeamColor
		greenTeam.AutoAssignable = teams.Green.AutoAssignable
		greenTeam.Parent = Teams
	end

	if not defaultTeam then
		defaultTeam = Instance.new("Team")
		defaultTeam.Name = teams.Default.Name
		defaultTeam.TeamColor = teams.Default.TeamColor
		defaultTeam.AutoAssignable = teams.Default.AutoAssignable
		defaultTeam.Parent = Teams
	end
end
