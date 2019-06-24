function Add_transmitter_to_transmitter_table( new_transmitter )
	global.jitemans_channeled_wireless_signals.transmitters[ new_transmitter.unit_number ] = new_transmitter
end

function Remove_transmitter_from_transmitter_table( the_transmitter )
	global.jitemans_channeled_wireless_signals.transmitters[ the_transmitter.unit_number ] = nil
end
