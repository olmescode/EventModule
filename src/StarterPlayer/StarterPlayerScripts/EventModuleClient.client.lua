local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventModule = ReplicatedStorage:WaitForChild("EventModule")

-- Require conductor
require(EventModule:WaitForChild("ClientConductor"))()