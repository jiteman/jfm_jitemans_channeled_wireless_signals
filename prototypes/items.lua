require( "names" )

data:extend( {
	{
		type = "item",
		name = "jitemans-channeled-signal-transmitter",
		icon = this_mode_path .. "/graphics/icons/" .. "jitemans-channeled-signal-transmitter-icon" .. ".png",
		icon_size = 32,
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "c[radio]-a[" .. "jitemans-channeled-signal-transmitter" .. "]",
		place_result = "jitemans-channeled-signal-transmitter",
		stack_size = 10,
	},
	{
		type = "item",
		name = "jitemans-channeled-signal-receiver",
		icon = this_mode_path .. "/graphics/icons/" .. "jitemans-channeled-signal-receiver-icon" .. ".png",
		icon_size = 32,
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "c[radio]-a[" .. "jitemans-channeled-signal-receiver" .. "]",
		place_result = "jitemans-channeled-signal-receiver",
		stack_size = 10,
	}	
} )
