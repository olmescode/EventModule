local Teams = game:GetService("Teams")

local EventModule = script:FindFirstAncestor("EventModule")

local teams = require(EventModule.constants).Teams
local enums = require(EventModule.enums)

--[[
	TeamCreation Module Script

	This module script is responsible for creating teams in the game,
	it checks for existing teams and creates them if they don't exist.
]]
local TeamCreation = {}

local hasBeenCalled = false

return function(stubs)
	if hasBeenCalled then
		error("TeamCreation has already been called")
		return
	end
	
	-- Get the existing teams
	local existingTeams = Teams:GetTeams()
	local currentTeams = {}

	for _, team in ipairs(existingTeams) do
		currentTeams[team.Name] = team
	end
	
	-- Check if the teams already exist (to avoid duplicates)
	local blueTeam = currentTeams[teams.Blue.Name]
	local greenTeam = currentTeams[teams.Green.Name]
	local defaultTeam = currentTeams[teams.Default.Name]

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
	
	hasBeenCalled = true
	
	-- Set an attribute indicating that the framework is ready
	script:SetAttribute(enums.Attribute.FrameworkReady, true)
	
	return TeamCreation
end
