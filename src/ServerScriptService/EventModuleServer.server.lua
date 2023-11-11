local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventModule = ReplicatedStorage.EventModule

require(EventModule.Conductor)()
require((EventModule.Components.TeamCreation))()
