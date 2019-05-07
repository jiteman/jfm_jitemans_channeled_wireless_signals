function Add_transmitter_to_transmitter_table( new_transmitter )
	global.jitemans_channeled_wireless_signals.transmitters[ new_transmitter.unit_number ] = new_transmitter
end

function Add_receiver_to_receiver_table( new_receiver )
	global.jitemans_channeled_wireless_signals.receivers[ new_receiver.unit_number ] = new_receiver
end

function Remove_transmitter_from_transmitter_table( the_transmitter )
	global.jitemans_channeled_wireless_signals.transmitters[ the_transmitter.unit_number ] = nil
end

function Remove_receiver_from_receiver_table( the_receiver )
	global.jitemans_channeled_wireless_signals.receivers[ the_receiver.unit_number ] = nil
end
