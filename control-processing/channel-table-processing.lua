function Add_transmitter_to_channel_table( the_transmitter )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] ~= nil ) then
		-- add to existing channel
		if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.entity.unit_number ] == nil ) then
			global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.entity.unit_number ] = the_transmitter
		end
	else
		local channeled_transmitters = {}
		channeled_transmitters[ the_transmitter.entity.unit_number ] = the_transmitter	
		
		global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] = {}
		global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters = channeled_transmitters
		global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].name = "No name"
	end
end

function Remove_transmitter_from_channel_table( the_transmitter )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] ~= nil ) then
		-- remove transmitter to existing channel
		if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.entity.unit_number ] ~= nil ) then
			global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.entity.unit_number ] = nil
		end

		-- remove channel if it was the last of transmitters
		if ( #global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters == 0 ) then
			global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] = nil
		end
	
	end
end

