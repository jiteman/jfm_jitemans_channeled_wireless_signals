require( "control-processing/channel-table-processing" )
require( "control-processing/receiver-table-processing" )
require( "control-processing/transmitter-table-processing" )
require( "control-processing/signal-processing" )

require( "utilities/debugging" )

-- formats:
--		transmitters: (unit_number)
--			entity
--			channel_identifier
--		receivers: (unit_number)
--			entity
--			channel_identifier
--		channels: (channel_identifier)
--			transmitters
--			name

local function initGlobal( force )
	if force or global.jitemans_channeled_wireless_signals == nil then
		global.jitemans_channeled_wireless_signals = {}
	end
	if force or global.jitemans_channeled_wireless_signals.transmitters == nil then
		global.jitemans_channeled_wireless_signals.transmitters = {}
	end
	if force or global.jitemans_channeled_wireless_signals.receivers == nil then
		global.jitemans_channeled_wireless_signals.receivers = {}
	end
	if force or global.jitemans_channeled_wireless_signals.channels == nil then
		global.jitemans_channeled_wireless_signals.channels = {}
	end
end

script.on_init(
	function()
		initGlobal( false )
	end
)

script.on_configuration_changed(
	function()
		initGlobal( false )
	end
)

local cachedSignal = {
	condition = {
		comparator = ">",
		first_signal = { type = "virtual", name = "signal-everything" },
		constant = 0
	}
}

local function onEntityCreated( event )
	local the_entity = event.created_entity
	
	if ( the_entity.name == "jitemans-channeled-signal-transmitter" ) then
		the_entity.operable = false
		the_entity.get_or_create_control_behavior().connect_to_logistic_network = false
		the_entity.get_control_behavior().circuit_condition = cachedSignal
		
		local new_transmitter = {
			entity = the_entity,
			channel_identifier = "0"
		}
		
		Add_transmitter_to_transmitter_table( new_transmitter )
		Add_transmitter_to_channel_table( new_transmitter )

	elseif ( the_entity.name == "jitemans-channeled-signal-receiver" ) then
		the_entity.operable = false
		
		local new_receiver = {
			entity = the_entity,
			channel_identifier = "0"
		}		
		
		Add_receiver_to_receiver_table( new_receiver )
		Add_receiver_to_channel_table( new_receiver )
	end
end

-- update channel table
local function onEntityRemoved( event )
	local entity = event.entity
	
	if ( entity.name == "jitemans-channeled-signal-transmitter" ) then
		local the_transmitter = Remove_and_get_transmitter_from_transmitter_table( entity )
		Remove_transmitter_from_channel_table( the_transmitter )
	elseif ( entity.name == "jitemans-channeled-signal-receiver" ) then
		local the_receiver = Remove_and_get_receiver_from_receiver_table( entity )
		Remove_receiver_from_channel_table( the_receiver )
	end
end

local function onTick( event )
	local channeled_wireless_signals = global.jitemans_channeled_wireless_signals
	local signal_tables = {}
	
	for _, each_receiver in pairs( channeled_wireless_signals.receivers ) do
		local channel_identifier = each_receiver.channel_identifier
		
		-- skip this if signals for this channel is already collected (use previously collected signals for this channel)
		if ( signal_tables == nil or signal_tables[ channel_identifier ] == nil ) then
			local current_channel_signal_table = {}
			
			if ( channeled_wireless_signals.channels ~= nil and channeled_wireless_signals.channels[ channel_identifier ] ~= nil ) then
				if ( channeled_wireless_signals.channels[ channel_identifier ].transmitters ~= nil ) then
					for _, each_transmitter in pairs( channeled_wireless_signals.channels[ channel_identifier ].transmitters ) do
						if ( each_transmitter.entity.energy > 0 ) then
							Get_transmitter_signals( current_channel_signal_table, each_transmitter )
						end
					end
				end
			end

			if ( #current_channel_signal_table ~= 0 ) then
				Merge_signals( current_channel_signal_table )
				signal_tables[ channel_identifier ] = current_channel_signal_table
			end
		end

		-- copy collected signals into receiver signals (parameters)
		if ( signal_tables[ channel_identifier ] ~= nil and #signal_tables[ channel_identifier ] ~= 0 ) then
			each_receiver.entity.get_control_behavior().parameters = { parameters = signal_tables[ channel_identifier ] }
		else
			each_receiver.entity.get_control_behavior().parameters = { parameters = {} }
		end
	end
end


local function close_gui( current_player_index )
	if global.jitemans_channeled_wireless_signals.gui and global.jitemans_channeled_wireless_signals.gui.valid then
		global.jitemans_channeled_wireless_signals.gui.destroy()
	end

	global.jitemans_channeled_wireless_signals.gui = nil
end

local function open_gui( entity, player_index )
	local current_player = game.players[ player_index ]
	close_gui( player_index )
	local gui = current_player.gui.center.add( { type = "frame", name = "jitemans_channeled_wireless_signals_gui", direction = "vertical" } )
	current_player.opened = gui
	global.jitemans_channeled_wireless_signals.gui = gui
	
	local channel_identifier_text = "[Unknown entity]"
	local channel_name_text = "[No name]"
	
	if ( entity.name == "jitemans-channeled-signal-transmitter" ) then
		local the_channel_identifier = global.jitemans_channeled_wireless_signals.transmitters[ entity.unit_number ].channel_identifier
		channel_identifier_text = the_channel_identifier
		channel_name_text = global.jitemans_channeled_wireless_signals.channels[ the_channel_identifier ].name
	elseif ( entity.name == "jitemans-channeled-signal-receiver" ) then
		local the_channel_identifier = global.jitemans_channeled_wireless_signals.receivers[ entity.unit_number ].channel_identifier
		channel_identifier_text = the_channel_identifier
		channel_name_text = global.jitemans_channeled_wireless_signals.channels[ the_channel_identifier ].name
	end

	gui.add( { type = "table", name = "title_section", column_count = 3 } )
	gui.title_section.add( { type = "label", name = "entity_name", caption = { "entity-name." .. entity.name } } )
	gui.title_section.add( { type = "label", name = "entity_at", caption =  "@" } )
	gui.title_section.add( { type = "label", name = "entity_position", caption =  entity.position.x .. ", " .. entity.position.y } )
	gui.add( { type = "table", name = "channel_identifier_section", column_count = 2 } )
	gui.channel_identifier_section.add( { type = "label", name = "channel_identifier_caption", caption = "Channel identifier" } )
	gui.channel_identifier_section.add( { type = "textfield", name = "channel_identifier", text = channel_identifier_text } )
	gui.add( { type = "table", name = "channel_name_section", column_count = 2 } )
	gui.channel_name_section.add( { type = "label", name = "channel_name_caption", caption = "Channel name" } )	
	gui.channel_name_section.add( { type = "textfield", name = "channel_name", text = channel_name_text } )
	
	gui.add( { type = "button", name = "jitemans_channeled_wireless_signals_gui_close", caption = "Close" } )	
end

-- Seinsei: interface
local function on_gui_opened( event )
--	script.raise_event( defines.events.on_gui_closed, event )

	local current_player_index = event.player_index
	local current_player = game.players[ current_player_index ]
	local current_entity = current_player.selected

	if current_entity ~= nil and current_player.can_reach_entity( current_entity ) then
		if ( current_entity.type == "lamp" and current_entity.name == "jitemans-channeled-signal-transmitter" ) then
			open_gui( current_entity, current_player_index )
		elseif ( current_entity.type == "constant-combinator" and current_entity.name == "jitemans-channeled-signal-receiver" ) then
			open_gui( current_entity, current_player_index )
		else
			close_gui( current_player_index )
		end
	else
		close_gui( current_player_index )
	end
end

-- related to checkboxes and radio buttons
local function on_gui_checked_state_changed( event )
	local gui = global.jitemans_channeled_wireless_signals.gui
end

-- related to drop-downs
local function on_gui_selection_state_changed( event )
	local gui = global.jitemans_channeled_wireless_signals.gui
end

-- related to the slider element
local function on_gui_value_changed( event )
	local gui = global.jitemans_channeled_wireless_signals.gui
	
--	if ( event.element.name == "channel_selector_slider" ) then
--		gui.channel_number_selector.channel_selector_number.text = math.ceil( event.element.slider_value * 1024 )
--	end
end

-- text is changed by the player
local function on_gui_text_changed( event )
	DEBUG_output( "[on_gui_text_changed( event )]" )
	
	local gui = global.jitemans_channeled_wireless_signals.gui
	
	-- gui.channel_number_selector.channel_selector_number.text
	if ( event.element.name == "channel_identifier" ) then
		if ( gui.channel_identifier_section.channel_identifier.text ~= nil ) then
			-- update channel identifier
			
		end
	elseif ( event.element.name == "channel_name" ) then
		DEBUG_output( "[on_gui_text_changed( event )] - 00100" )
		if ( gui.channel_name_section.channel_name.text ~= nil ) then
			DEBUG_output( "[on_gui_text_changed( event )] - 00200" )
			-- update channel name
			if ( gui.channel_identifier_section.channel_identifier.text ~= nil ) then
				DEBUG_output( "[on_gui_text_changed( event )] - 00300" )
				DEBUG_output( "[on_gui_text_changed( event )] - channel identifier text: " .. gui.channel_identifier_section.channel_identifier.text )
				global.jitemans_channeled_wireless_signals.channels[ gui.channel_identifier_section.channel_identifier.text ].name = gui.channel_name_section.channel_name.text
			end
			DEBUG_output( "[on_gui_text_changed( event )] - 00400" )
		end
		DEBUG_output( "[on_gui_text_changed( event )] - 00500" )
	end
end

-- related to choose element buttons
local function on_gui_elem_changed( event )
	local gui = global.jitemans_channeled_wireless_signals.gui
end

local function on_gui_click( event )
	local current_player_index = event.player_index

	if ( event.element.name == "jitemans_channeled_wireless_signals_gui_close" ) then
		close_gui( current_player_index )
	end

end

local function on_gui_closed( event )
	close_gui( event.player_index )
end

script.on_event( defines.events.on_built_entity, onEntityCreated )
script.on_event( defines.events.on_robot_built_entity, onEntityCreated )

script.on_event( defines.events.on_pre_player_mined_item, onEntityRemoved )
script.on_event( defines.events.on_robot_pre_mined, onEntityRemoved )
script.on_event( defines.events.on_entity_died, onEntityRemoved )

script.on_event( defines.events.on_tick, onTick )

script.on_event( "jitemans-channeled-wireless-signals-open-gui", on_gui_opened )
script.on_event( defines.events.on_gui_checked_state_changed, on_gui_checked_state_changed )
script.on_event( defines.events.on_gui_selection_state_changed, on_gui_selection_state_changed )
script.on_event( defines.events.on_gui_value_changed, on_gui_value_changed )
script.on_event( defines.events.on_gui_text_changed, on_gui_text_changed )
script.on_event( defines.events.on_gui_elem_changed, on_gui_elem_changed )
script.on_event( defines.events.on_gui_click, on_gui_click )
script.on_event( defines.events.on_gui_closed, on_gui_closed )
