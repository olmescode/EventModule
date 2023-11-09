local EventModule = script:FindFirstAncestor("EventModule")

local enums = require(EventModule.enums)
local Conductor = EventModule.Conductor

-- Waits for a conductor to be created and returns it
local waitForConductor = {}

waitForConductor.task = task

function waitForConductor:call()
	while
		not Conductor:GetAttribute(enums.Attribute.FrameworkReady)
	do
		waitForConductor.task.wait()
	end
end

return waitForConductor
