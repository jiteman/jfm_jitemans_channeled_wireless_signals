function Add_transmitter_to_transmitter_table( new_transmitter )
	global.jitemans_channeled_wireless_signals.transmitters[ new_transmitter.entity.unit_number ] = new_transmitter
end

function Remove_and_get_transmitter_from_transmitter_table( the_transmitter_entity )
	local the_transmitter = global.jitemans_channeled_wireless_signals.transmitters[ the_transmitter_entity.unit_number ]
	global.jitemans_channeled_wireless_signals.transmitters[ the_transmitter_entity.unit_number ] = nil
	return the_transmitter
end
