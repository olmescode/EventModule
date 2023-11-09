local EventModule = script:FindFirstAncestor("EventModule")
local state = require(EventModule.state)

return function()
	state.ClientFrameworkReady = true
end
