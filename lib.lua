local ru = remove_unknowns
local S = ru.S

-- Writes a Message in a specific color or Logs it
function ru.print(name, message, color)

    if(color ~= ru.none) then
        minetest.chat_send_player(name, core.colorize(color, message))
        return
		
    else 
        minetest.chat_send_player(name,  message)
        return
    end
			
end -- ru.print_message()

function ru.set_radius(player, radius)
    local rad = tonumber(radius) or 0
    if(not rad) then
        minetest.chat_send_player(player, S("Radius have to be a value between @1 and @2.",
                                            ru.min_radius, ru.max_radius))
        return
    end

    if((rad > ru.max_radius) or (rad < ru.min_radius)) then
        minetest.chat_send_player(player, S("Radius have to be a value between @1 and @2.",
                                            ru.min_radius, ru.max_radius))

    else
        local oldrad = ru.radius
        ru.radius = rad
        minetest.chat_send_player(player, S("Radius is set from @1 to @2", oldrad, rad))

    end -- if(radius > ru.max

end -- function ru.set_radius

function ru.split(parameter)
    local cmd = {}
    for word in string.gmatch(parameter, "[%w%-%:%.%_2f]+") do
        table.insert(cmd, word)

    end -- for word

    return cmd

end -- function split

function ru.kill(player, node, node2)
    local rad = ru.radius
    local own = minetest.get_player_by_name(player)
    local mypos = own:get_pos()

    local from = {x = mypos.x + rad, y = mypos.y + rad, z = mypos.z + rad}
    local to = {x = mypos.x - rad, y = mypos.y - rad, z = mypos.z - rad}

    local nodes = minetest.find_nodes_in_area(from, to, node)

    if(not node2) then
        minetest.chat_send_player(player, S("Removing unkown Nodes: " .. node))
        for key,value in pairs(nodes) do
            minetest.swap_node(value, {name = "air"})

        end -- for key,value

    else
        minetest.chat_send_player(player, S("Swap Node ") .. node .. S(" to ") .. node2)

        if(not minetest.registered_nodes[node2]) then
            minetest.chat_send_player(player, S("Node: ") .. node2 .. S(" isn't a registered Node."))
            return

        end

        for key,value in pairs(nodes) do
            minetest.swap_node(value, {name = node2})

        end -- for key,value

    end -- if(not node2

end -- function kill

-- Shows Information about an Item you held in the Hand
function ru.show_item(name)
	
	local player = minetest.get_player_by_name(name) -- Get the Playerobject
	
	if( (player ~= nil) ) then
	
		local item = player:get_wielded_item() -- Get the current used Item
		
		if( (item ~= nil) )then
			if(item:get_name() ~= "") then
				ru.print(name, "Itemname: ", ru.orange)
				ru.print(name, item:get_name() .. " - " .. item:get_count() .. " / " .. item:get_stack_max(), ru.green)
				
			else
				ru.print(name, "You have no Item in your Hand.", ru.red)
				
			end -- if( item:get_name
			
		else
			ru.print(name, "You have no Item in your Hand.", ru.red)
			
		end --- if( item
	
	end -- if( player
		
end -- chathelp.show_item()-- Shows Information about an Item you held in the Hand

function ru.show_radius(player)
    minetest.chat_send_player(player, S("Current Radius is set to: @1.", ru.radius))
    minetest.chat_send_player(player, S("Min. Radius = @1.", ru.min_radius))
    minetest.chat_send_player(player, S("Max. Radius = @1.", ru.max_radius))

end -- function show_radius

-- Shows Information about an Item you point on it
function ru.show_node(name, pos)

    if pos then
	
        local node = minetest.get_node(pos)
        local light = minetest.get_node_light(pos)
        local dlight = minetest.get_node_light({x=pos.x, y=pos.y -1, z=pos.z})
        local ulight = minetest.get_node_light({x=pos.x, y=pos.y +1, z=pos.z})
        local nodepos = minetest.pos_to_string(pos)
        local protected = minetest.is_protected(pos, name)
		
        ru.print(name, S("Name of the Node: "), ru.purple)
        ru.print(name, node.name, ru.green)
        ru.print(name, S("Located at: ") .. nodepos, ru.green)
        ru.print(name, S("Light on the Node: ") .. light .. ".", ru.yellow)
        ru.print(name, S("Light above: ") .. ulight .. ".", ru.yellow)
        ru.print(name, S("Light under: ") .. dlight .. ".", ru.yellow)
		
        if(protected) then
            ru.print(name, S("Is protected? Yes."), ru.white)
        else
                ru.print(name, S("Is protected: No."), ru.white)
    end
		
        if(minetest.registered_nodes[node.name] ~= nil) then
            if(minetest.registered_nodes[node.name].diggable) then
                ru.print(name, S("Is diggable."), ru.orange)
            end

            if(minetest.registered_nodes[node.name].walkable) then
                ru.print(name, S("Is walkable."), ru.orange)
            end

            if(minetest.registered_nodes[node.name].climbable) then
                ru.print(name, S("Is climbable."), ru.orange)
            end

            if(minetest.registered_nodes[node.name].buildable_to) then
                ru.print(name, S("Is replaceable."), ru.orange)
            end

            if(minetest.registered_nodes[node.name].liquid_renewable) then
                ru.print(name, S("Is regenerateable."), ru.orange)
            end
		
            if(minetest.registered_nodes[node.name].use_texture_alpha) then
                ru.print(name, S("Has an alpha-channel."), ru.orange)
                ru.print(name, S("With a transparency of ") .. 255 - minetest.registered_nodes[node.name].alpha .. " / 255.", ru.light_blue)
            end

            if(minetest.registered_nodes[node.name].sunlight_propagates) then
                ru.print(name, S("Light shines trough."), ru.orange)
            end
		
            if(minetest.registered_nodes[node.name].light_source > 0) then
                ru.print(name, S("Shines with Lightlevel ") .. minetest.registered_nodes[node.name].light_source .. " / 15.", ru.light_blue)
            end
		
            if(minetest.registered_nodes[node.name].damage_per_second > 0) then
                ru.print(name, S("Deals with ") .. minetest.registered_nodes[node.name].damage_per_second .. S(" Points Damage per Second."),  ru.light_green)
            end
		
            ru.print(name, S("Stacks with ") .. minetest.registered_nodes[node.name].stack_max .. S(" Items / Stack."), ru.light_red)
        else
            ru.print(name, S("Node unknown!"), ru.red)
        end 
		
    else
	
        ru.print(name, S("Pointed on no Node."), ru.red)
	
    end

end -- ru.show_me()

function ru.show_version(player)
    minetest.chat_send_player(player, "Remove Unknowns Version " .. ru.version .. "." .. ru.revision)

end
