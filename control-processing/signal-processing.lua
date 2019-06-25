local circuit_network_wire_types = { defines.wire_type.red, defines.wire_type.green }

function Get_transmitter_signals( signal_table, transmitter )
	for i = 1, #circuit_network_wire_types do -- check both red and green wires
		local circuit_network = transmitter.entity.get_circuit_network( circuit_network_wire_types[ i ] )

		if ( circuit_network ~= nil and circuit_network.signals ~= nil ) then
			local all_signals = circuit_network.signals -- read the circuit network

			if ( all_signals ~= nil and #all_signals > 0 ) then
				for _, each_signal in pairs( all_signals ) do
					signal_table[ #signal_table + 1 ] = {
						signal = each_signal.signal,
						count = each_signal.count,
						index = 0
					}
				end
			end
		end
	end
end

function Merge_signals( signals_to_merge )
--	if ( signals_to_merge == nil or #signals_to_merge == 0 ) then
--		return
--	end

	if ( #signals_to_merge > 1 ) then -- do nothing if there is only one signal
		table.sort( signals_to_merge, function( first, second ) return first.signal.name < second.signal.name end )
		local current_element_index = 1

		while current_element_index < #signals_to_merge do
			local current_element = signals_to_merge[ current_element_index ];
			local next_element = signals_to_merge[ current_element_index + 1 ];

			if current_element.signal.name == next_element.signal.name then
				current_element.count = current_element.count + next_element.count
				table.remove( signals_to_merge, current_element_index + 1 )

				if current_element.count == 0 then
					table.remove( signals_to_merge, current_element_index )
				end
			else
				current_element.index = current_element_index
				current_element_index = current_element_index + 1
			end
		end
	end

	signals_to_merge[ #signals_to_merge ].index = #signals_to_merge
end
