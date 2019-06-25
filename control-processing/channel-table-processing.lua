function Add_transmitter_to_channel_table( the_transmitter )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] ~= nil ) then
		local the_channel = global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ]
		-- add to existing channel
		if ( the_channel.transmitters[ the_transmitter.entity.unit_number ] == nil ) then
			the_channel.transmitters[ the_transmitter.entity.unit_number ] = the_transmitter
			the_channel.transmitter_quantity = the_channel.transmitter_quantity + 1
		end
	else
		local channeled_transmitters = {}
		channeled_transmitters[ the_transmitter.entity.unit_number ] = the_transmitter

		local the_channel = {}
		the_channel.transmitters = channeled_transmitters
		the_channel.name = "No name"
		the_channel.transmitter_quantity = 1
		the_channel.receivers = {}
		the_channel.receiver_quantity = 0
		global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] = the_channel
	end
end

function Remove_transmitter_from_channel_table( the_transmitter )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] ~= nil ) then
		local the_channel = global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ]

		-- remove transmitter from existing channel
		if ( the_channel.transmitters[ the_transmitter.entity.unit_number ] ~= nil ) then
			the_channel.transmitters[ the_transmitter.entity.unit_number ] = nil
			the_channel.transmitter_quantity = the_channel.transmitter_quantity - 1
		end

		-- remove channel if it was the last transmitter or receiver
		if ( the_channel.transmitter_quantity == 0 and the_channel.receiver_quantity == 0 ) then
			global.jitemans_channeled_wireless_signals.channels[ the_transmitter.channel_identifier ] = nil
		end
	end
end

function Add_receiver_to_channel_table( the_receiver )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] ~= nil ) then
		local the_channel = global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ]
		-- add to existing channel
		if ( the_channel.receivers[ the_receiver.entity.unit_number ] == nil ) then
			the_channel.receivers[ the_receiver.entity.unit_number ] = the_receiver
			the_channel.receiver_quantity = the_channel.receiver_quantity + 1
		end
	else
		local channeled_receivers = {}
		channeled_receivers[ the_receiver.entity.unit_number ] = the_receiver

		local the_channel = {}
		the_channel.receivers = channeled_receivers
		the_channel.name = "No name"
		the_channel.receiver_quantity = 1
		the_channel.transmitters = {}
		the_channel.transmitter_quantity = 0
		global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] = the_channel
	end
end

function Remove_receiver_from_channel_table( the_receiver )
	if ( global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] ~= nil ) then
		local the_channel = global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ]

		-- remove receiver from existing channel
		if ( the_channel.receivers[ the_receiver.entity.unit_number ] ~= nil ) then
			the_channel.receivers[ the_receiver.entity.unit_number ] = nil
			the_channel.receiver_quantity = the_channel.receiver_quantity - 1
		end

		-- remove channel if it was the last transmitter or receiver
		if ( the_channel.transmitter_quantity == 0 and the_channel.receiver_quantity == 0 ) then
			global.jitemans_channeled_wireless_signals.channels[ the_receiver.channel_identifier ] = nil
		end
	end
end
