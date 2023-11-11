local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local EventModule = script:FindFirstAncestor("EventModule")

local assignPlayerToTeam = require(EventModule.Api.assignPlayerToTeam)
local constants = require(EventModule.constants)

local function countPlayersInTeam(team)
	local count = 0
	for _, player in ipairs(team:GetPlayers()) do
		count = count + 1
	end
	return count
end

local function findSmallerAndBiggerTeams(team1, team2)
	local countTeam1 = countPlayersInTeam(team1)
	local countTeam2 = countPlayersInTeam(team2)
	
	local smallerTeam = countTeam1 <= countTeam2 and team1 or team2
	local biggerTeam = countTeam1 > countTeam2 and team1 or team2

	return biggerTeam, smallerTeam
end

local function rebalanceTeams(team1, team2)
	-- Get the smaller and bigger teams
	local biggerTeam, smallerTeam = findSmallerAndBiggerTeams(team1, team2)
	
	if biggerTeam then
		-- Pick a random player
		local playerList = biggerTeam:GetPlayers()
		local player = playerList[math.random(1, #playerList)]

		-- Check the player exists
		if player then
			assignPlayerToTeam(player, smallerTeam.Name)
		end
	end
end

local function assignPlayersToRandomTeams(team1, team2)
	for _, player in ipairs(Players:GetPlayers()) do
		-- Check if the player already has a chosen team
		local chosenTeam = player:GetAttribute("ChosenTeam")
		
		-- Get the smaller and bigger teams
		local biggerTeam, smallerTeam = findSmallerAndBiggerTeams(team1, team2)

		if not chosenTeam then
			-- Randomly assign the player to either the blue or green team
			--local randomTeam = math.random() < 0.5 and team1 or team2
			assignPlayerToTeam(player, smallerTeam.Name)
		end
	end
end

local TeamRebalancer = function(team1: string?, team2: string?)
	-- Get the existing teams
	local existingTeams = Teams:GetTeams()
	local teams = {}
	
	for _, team in ipairs(existingTeams) do
		teams[team.Name] = team
	end
	
	local team1 = teams[team1] or teams[constants.Teams.Blue.Name]
	local team2 = teams[team2] or teams[constants.Teams.Green.Name]
	local defaultTeam = teams[constants.Teams.Default.Name]
	
	if team1 and team2 and defaultTeam then
		assignPlayersToRandomTeams(team1, team2)
		rebalanceTeams(team1, team2)
	end
end

return TeamRebalancer
