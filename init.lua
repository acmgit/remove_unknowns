--[[
    *******************************************************************************
    ***                                                                         ***
    ***                      Remove Unknowns                                    ***
    ***                                                                         ***
    ***   Small Chatorder to quickly remove unkown nodes in your Environment    ***
    ***                                                                         ***
    ***                        (?) by A.C.M.                                    ***
    ***                                                                         ***
    ***                      License: GPL 3.0                                   ***
    ***                                                                         ***
    *******************************************************************************
]]--

remove_unknowns = {}
local ru = remove_unknowns

local MP = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator(minetest.get_current_modname())

ru.version = 1
ru.revision = 1

ru.MP = MP
ru.S = S
ru.radius = 20
ru.max_radius = 75
ru.min_radius = 1

-- Options for Print_Message
ru.log = 0
ru.green = '#00FF00'
ru.red = '#FF0000'
ru.orange = '#FF6700'
ru.blue = '#0000FF'
ru.yellow = '#FFFF00'
ru.purple = '#FF00FF'
ru.pink = '#FFAAFF'
ru.white = '#FFFFFF'
ru.black = '#000000'
ru.grey = '#888888'
ru.light_blue = '#8888FF'
ru.light_green = '#88FF88'
ru.light_red = '#FF8888'
ru.none = 99

dofile(MP .. "/lib.lua")

minetest.register_privilege("unknown_killer", S("Player may remove unkown Nodes in an certain radius."))


minetest.register_chatcommand("ru", {
    privs = {unknown_killer = true},
    params = "<Nodename>, <show_radius>, <set_radius>, <version>",
	description = S("Remove unkown <Nodename> in an given radius.") .. "\n" ..
                  S("<show_radius> Show's the current working radius.")  .. "\n" ..
                  S("<set_radius> Set's a new Radius.") .. "\n" ..
                  S("<version> Show's the version of the mod."),

	func = function(name, param)
        local cmd = {}
        cmd = ru.split(string.lower(param))

        if(string.lower(cmd[1]) == "radius") then
            ru.show_radius(name)

        elseif(string.lower(cmd[1]) == "show") then
            ru.show_radius(name)

        elseif(string.lower(cmd[1]) == "show_radius") then
            ru.show_radius(name)

        elseif (string.lower(cmd[1]) == "set_radius") then
            ru.set_radius(name, cmd[2])

        elseif (string.lower(cmd[1]) == "version") then
            ru.show_version(name)

        elseif (not cmd[1]) then
            minetest.chat_send_player(name, "remove_unknowns" .. "\n" ..
                                            S("/ru <Unknown_Nodename> tries to remove all the given Unknown Nodes."))
        else
            ru.kill(name, cmd[1], cmd[2])

        end -- if(cmd[2]

	end,
})

minetest.register_chatcommand("su", {
    privs = {unknown_killer = true},
    params = "<Nodename1> <Nodename1>, <show_radius>, <set_radius>, <version>",
	description = S("Swap unkown <Nodename1> in an given radius to <Nodename2>.") .. "\n" ..
                  S("<show_radius> Show's the current working radius.")  .. "\n" ..
                  S("<set_radius> Set's a new Radius.") .. "\n" ..
                  S("<version> Show's the version of the mod."),

	func = function(name, param)
        local cmd = {}
        cmd = ru.split(string.lower(param))

        if(cmd[1] == "radius") then
            ru.show_radius(name)

        elseif(cmd[1] == "show") then
            ru.show_radius(name)

        elseif(cmd[1] == "show_radius") then
            ru.show_radius(name)

        elseif (cmd[1] == "set_radius") then
            ru.set_radius(name, cmd[2])

        elseif (cmd[1] == "version") then
            ru.show_version(name)

        elseif (not cmd[1]) then
            minetest.chat_send_player(name, "swap_unknowns" .. "\n" ..
                                            S("/su <Unknown_Nodename> <Nodename> tries to swap all the given Unknown Nodes into Nodename."))
        else
            ru.swap(name, cmd[1], cmd[2])

        end -- if(cmd[2]

	end,
})

minetest.register_chatcommand("what_is", {
    params = "",
    description = "Show's Information about the Item in your Hand.",
    func = function(name)
		ru.show_item(name)
		
    end

})

-- Magnifier
minetest.register_craftitem("remove_unknowns:magnifier", {
    description = S("Magnifying Glass"),
    inventory_image = "remove_unknowns_magnifier.png",
    stack_max = 1,
    liquids_pointable = true,

    on_use = function(itemstack, user, pointed_thing)
	
        local pos = minetest.get_pointed_thing_position(pointed_thing)
        local name = user:get_player_name()
		
        ru.show_node(name, pos)
	    
    end,-- on_use
})

-- Recipe for Magnifier
minetest.register_craft({
    output = "remove_unknowns:magnifier",
    recipe = {
        {"default:glass", "default:mese_crystal_fragment"},
        {"default:stick", ""}
    }
})


minetest.log("action","[MOD] remove_unknowns V " .. ru.version .. "." .. ru.revision .. " successfully loaded.")
