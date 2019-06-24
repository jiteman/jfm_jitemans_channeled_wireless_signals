function Add_transmitter_to_channel_table( the_transmitter )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] ~= nil ) then
		-- add to existing channel
		if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.unit_number ] == nil )
			global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.unit_number ] = the_transmitter
		end
	else
		-- create new channel
		global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] = {
			name = "[No name]",
			transmitters = { the_transmitter },
			receivers = {}
		}
	end
end

function Remove_transmitter_from_channel_table( the_transmitter )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] ~= nil ) then
		-- add to existing channel
		if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.unit_number ] ~= nil )
			global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters[ the_transmitter.unit_number ] = nil
		end
		
		if ( #global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ].transmitters == 0 )
			global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] = nil
		end
	end
end

