_addon.name = 'ikudosi'
_addon.author = 'ikudosi'
_addon.version = '1'
_addon.command = 'ifiller'
_addon.commands = {'fill'}

require('logger')
require('luau')

time_start = os.time()

bag_ids = res.bags:key_map(string.gsub-{' ', ''} .. string.lower .. table.get-{'english'} .. table.get+{res.bags}):map(table.get-{'id'})
bag_ids.temporary = nil

windower.register_event('addon command', function(comm, ...)
		
	comm = comm or 'help'
	
	local args = L{...}
	
	if comm == 'help' then
		log('Commands:')
		log('1.  fill. Example: //ifiller fill "Riftborn Boulder"')
	end
	
	if comm == 'fill' then
		local bag = 'inventory'
        local specified_bag = rawget(bag_ids, bag)
        local source_bag
        local destination_bag
		
        destination_bag = specified_bag
        source_bag = bag_ids.inventory
        
        local destination_bag_info = windower.ffxi.get_bag_info(destination_bag)
		
		while (destination_bag_info.count < destination_bag_info.max) do
			if (os.time() > time_start) then
				time_start = os.time()
				windower.send_command('get "' .. args[1] .. '" inventory')
				destination_bag_info = windower.ffxi.get_bag_info(destination_bag)
			end
		end
	end
end)
