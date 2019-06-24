function Add_receiver_to_receiver_table( new_receiver )
	global.jitemans_channeled_wireless_signals.receivers[ new_receiver.unit_number ] = new_receiver
end

function Remove_receiver_from_receiver_table( the_receiver )
	global.jitemans_channeled_wireless_signals.receivers[ the_receiver.unit_number ] = nil
end
