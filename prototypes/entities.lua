require( "names" )

local function createEmptySprite()
	return
	{
		filename = "__core__/graphics/empty.png",
		priority = "high",
		width = 1,
		height = 1,
		frame_count = 1,
	}
end

local function createTransmitter( power )
	data:extend( {
		{
			type = "lamp",
			name = "jitemans-channeled-signal-transmitter",
			icon = this_mode_path .. "/graphics/icons/" .. "jitemans-channeled-signal-transmitter-icon" .. ".png",
			icon_size = 32,
			flags = {"placeable-player", "player-creation"},
			minable = { hardness = 0.2, mining_time = 0.75, result = "jitemans-channeled-signal-transmitter" },
			max_health = 250,
			corpse = "medium-remnants",
			collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
			selection_box = { { -0.8, -0.8 }, { 0.8, 0.8 } },
			vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
			fast_replaceable_group = "radio-equipment",
			energy_source = {
				type = "electric",
				usage_priority = "secondary-input",
				buffer_capacity = math.ceil( 0.6 * power ) .. "kJ",
				drain = math.ceil( 0.2 * power ) .. "kW",
			},
			energy_usage_per_tick = power .. "kW",
			darkness_for_all_lamps_on = 0.001,
			darkness_for_all_lamps_off = 0.0001,
			light = {
				intensity = 0.0,
				size = 0
			},
			picture_off = {
				filename = this_mode_path .. "/graphics/entity/" .. "jitemans-channeled-signal-transmitter" .. ".png",
				priority = "high",
				width = 235,
				height = 207,
				frame_count = 1,
				axially_symmetrical = false,
				direction_count = 1,
				shift = { 2.69, -1.91 },
			},
			picture_on = createEmptySprite(),
			circuit_wire_connection_point = {
				shadow = {
					red = { 1.09, -0.19 },
					green = { 0.34, 0.56 },
				},
				wire = {
					red = { 0.66, -0.53 },
					green = { -0.13, 0.22 },
				}
			},
			circuit_wire_max_distance = 15,
			additional_pastable_entities = { "jitemans-channeled-signal-transmitter", "jitemans-channeled-signal-receiver" }
		}
	} )
end

local function createReceiverSprite()
	return
	{
		filename = this_mode_path .. "/graphics/entity/" .. "jitemans-channeled-signal-receiver" .. ".png",
		width = 203,
		height = 179,
		frame_count = 1,
		shift = { 2.25, -1.91 },
	}
end

local function createReceiver( power )
	data:extend( {
		{
			type = "constant-combinator",
			name = "jitemans-channeled-signal-receiver",
			icon = this_mode_path .. "/graphics/icons/" .. "jitemans-channeled-signal-receiver-icon" .. ".png",
			icon_size = 32,
			flags = {"placeable-player", "player-creation"},
			minable = { hardness = 0.2, mining_time = 0.75, result = "jitemans-channeled-signal-receiver" },
			max_health = 150,
			corpse = "medium-remnants",
			collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
			selection_box = { { -0.8, -0.8 }, { 0.8, 0.8 } },
			vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
			fast_replaceable_group = "radio-equipment",
			energy_source = {
				type = "electric",
				usage_priority = "secondary-input",
				buffer_capacity = math.ceil( 0.6 * power ) .. "kJ",
				drain = math.ceil( 0.2 * power ) .. "kW",
			},
			energy_usage_per_tick = power .. "kW",
			item_slot_count = 255,
			sprites = {
				north = createReceiverSprite(),
				east = createReceiverSprite(),
				south = createReceiverSprite(),
				west = createReceiverSprite(),
			},
			activity_led_sprites = {
				north = createEmptySprite(),
				east = createEmptySprite(),
				south = createEmptySprite(),
				west = createEmptySprite(),
			},
			activity_led_light = {
				intensity = 0,
				size = 0
			},
			activity_led_light_offsets = { { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } },
			circuit_wire_connection_points = {
				{
					shadow = {
						red = { -0.09, 0.19 },
						green = { 0.81, 0.47 },
					},
					wire = {
						red = { -0.41, -0.19 },
						green = { 0.37, 0.0 },
					}
				},
				{
					shadow = {
						red = { -0.09, 0.19 },
						green = { 0.81, 0.47 },
					},
					wire = {
						red = { -0.41, -0.19 },
						green = { 0.37, 0.0 },
					}
				},
				{
					shadow = {
						red = { -0.09, 0.19 },
						green = { 0.81, 0.47 },
					},
					wire = {
						red = { -0.41, -0.19 },
						green = { 0.37, 0.0 },
					}
				},
				{
					shadow = {
						red = { -0.09, 0.19 },
						green = { 0.81, 0.47 },
					},
					wire = {
						red = { -0.41, -0.19 },
						green = { 0.37, 0.0 },
					}
				}
			},
			circuit_wire_max_distance = 15,
			additional_pastable_entities = { "jitemans-channeled-signal-receiver", "jitemans-channeled-signal-transmitter" }
		}
	})
end

createTransmitter( 1200 )
createReceiver( 300 )
