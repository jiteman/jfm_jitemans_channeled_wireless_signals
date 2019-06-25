function Add_receiver_to_receiver_table( new_receiver )
	global.jitemans_channeled_wireless_signals.receivers[ new_receiver.entity.unit_number ] = new_receiver
end

function Remove_and_get_receiver_from_receiver_table( the_receiver_entity )
	local the_receiver = global.jitemans_channeled_wireless_signals.receivers[ the_receiver_entity.unit_number ]
	global.jitemans_channeled_wireless_signals.receivers[ the_receiver_entity.unit_number ] = nil
	return the_reciever
end
