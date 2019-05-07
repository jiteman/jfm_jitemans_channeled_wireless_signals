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


function Add_receiver_to_channel_table( the_receiver )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] ~= nil ) then
		-- add to existing channel
		table.insert(
			global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ].receivers,
			the_receiver
		)		
	else
		-- create new channel
		global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] = {
			name = "[No name]",
			transmitters = {},
			receivers = { the_receiver }
		}
	end
end


function Remove_transmitter_from_channel_table( the_transmitter )
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


function Remove_receiver_from_channel_table( the_receiver )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] ~= nil ) then
		-- add to existing channel
		table.insert(
			global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ].receivers,
			the_receiver
		)		
	else
		-- create new
		global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] = {
			name = "[No name]",
			transmitters = {},
			receivers = { the_receiver }
		}
	end
end
