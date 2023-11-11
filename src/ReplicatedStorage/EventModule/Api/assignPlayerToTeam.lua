local Teams = game:GetService("Teams")

--[[
	assignPlayerToTeam Module Script

	This module script is responsible for assigning a player to a team.

	Parameters:
	- player - The player to assign to a team.
	- teamName - The name of the team to assign the player to.
]]
local function assignPlayerToTeam(player: Player, teamName: string)
	local team = Teams[teamName]

	if team then
		player.Team = team
		-- Add an Attribute to indicate the player's chosen team
		player:SetAttribute("ChosenTeam", teamName)
		-- Respawn the player
		player:LoadCharacter()
	end
end

return assignPlayerToTeam
