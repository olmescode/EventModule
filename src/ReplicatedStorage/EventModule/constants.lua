local constants = {
	COUNTDOWN_DURATION = 20, -- 20 seconds
	
	COUNTDOWN_MESSAGE = "Game Starting in ",
	
	SYNC_INTERVAL = 1 / 20,
	
	OFFSET_Y = math.rad(25),
	
	Tags = {
		Tag = "",
	},
	
	Teams = {
		Blue = {
			Name = "Blue",
			TeamColor = BrickColor.new("Bright blue"),
			AutoAssignable = false,
		},
		Green = {
			Name = "Green",
			TeamColor = BrickColor.new("Bright green"),
			AutoAssignable = false,
		},
		Default = {
			Name = "Default",
			TeamColor = BrickColor.new("White"),
			AutoAssignable = true,
		},
	},
}

return constants
