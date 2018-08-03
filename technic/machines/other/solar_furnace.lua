
-- A solar furnace is an auxiliary device which allows to use cooking recipes
-- without fuel. The downside is half the speed of a fuel-consuming furnace 
-- and the need to be exposed to maximal direct sunlight at all times (L = 15).


local S = technic.getter

minetest.register_craft({
	output = 'technic:solar_furnace',
	recipe = {
		{'technic:stainless_steel_ingot',	'technic:stainless_steel_ingot',	'technic:stainless_steel_ingot'},
		{'technic:composite_plate',		'default:furnace',			'technic:composite_plate'},
		{'technic:cast_iron_ingot',		'technic:cast_iron_ingot',		'technic:cast_iron_ingot'},
	}
})

local machine_name = S("Solar Furnace")
local formspec =
	"size[8,9]"..
	"label[0,0;"..machine_name.."]"..
	"image[2,2;1,1;technic_power_meter_bg.png]"..
	"list[current_name;src;2,1;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"

minetest.register_node("technic:solar_furnace", {
	description = machine_name,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
                     {-5/16, -1/2, -5/16, 5/16, 3/16, 5/16},
                     {-1/2, 3/16, -1/2, 1/2, 1/2, 1/2},
                     {-2/16, 1/2, -2/16, 2/16, 17/32, 2/16},
			},
	},
	tiles = {"technic_solar_furnace_top.png",  "technic_solar_furnace_bottom.png",
	         "technic_solar_furnace_side.png", "technic_solar_furnace_side.png",
	         "technic_solar_furnace_side.png", "technic_solar_furnace_side.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", machine_name)
		local inv = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
		meta:set_int("elapsed", 0)
		meta:set_int("cook_time", 0)
	end,
	can_dig = technic.machine_can_dig,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
})

minetest.register_node("technic:solar_furnace_active", {
	description = machine_name,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
                     {-5/16, -1/2, -5/16, 5/16, 3/16, 5/16},
                     {-1/2, 3/16, -1/2, 1/2, 1/2, 1/2},
                     {-2/16, 1/2, -2/16, 2/16, 17/32, 2/16},
			},
	},
	tiles = {"technic_solar_furnace_top.png",  "technic_solar_furnace_bottom.png",
	         "technic_solar_furnace_side.png", "technic_solar_furnace_side.png",
	         "technic_solar_furnace_side.png", "technic_solar_furnace_side.png"},
	paramtype2 = "facedir",
	light_source = 14,
	drop = "technic:solar_furnace",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	can_dig = technic.machine_can_dig,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
})

minetest.register_abm({
	label = "Machines: run solar furnace",
	nodenames = {"technic:solar_furnace", "technic:solar_furnace_active"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local inv    = meta:get_inventory()
		
		local recipe = nil

		if not meta:get_int("elapsed") then
			meta:set_int("elapsed", 0)
		end
                      
		if not meta:get_int("cook_time") then
			meta:set_int("cook_time", 0)
		end
                      
		local light_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
				                     
		local powered = false
		
		local node = minetest.get_node_or_nil(light_pos)

		if minetest.get_node_light(light_pos) == 15 and node.name == "air" then
			powered = true
		end
                      
		local result = technic.get_recipe("cooking", inv:get_list("src"))
		if result and result.time then
			meta:set_int("cook_time", result.time * 2)
		end
		

		          
		if powered then 

			if result then
				
				if meta:get_int("elapsed") >= meta:get_int("cook_time") then
                      
					local percent = 100
					meta:set_string("infotext", S("%s is active"):format(machine_name).." ("..percent.."%)")
					meta:set_string("formspec",
							"size[8,9]"..
							"label[0,0;"..machine_name.."]"..
							"image[2,2;1,1;technic_power_meter_bg.png^[lowpart:" .. percent .. ":technic_power_meter_fg.png]"..
							"list[current_name;src;2,1;1,1;]"..
							"list[current_name;dst;5,1;2,2;]"..
							"list[current_player;main;0,5;8,4;]"..
							"listring[current_name;dst]"..
							"listring[current_player;main]"..
							"listring[current_name;src]"..
							"listring[current_player;main]")
                      
					local result_stack = ItemStack(result.output)
					if inv:room_for_item("dst", result_stack) then
						inv:set_list("src", result.new_input)
						inv:add_item("dst", result_stack)
					end
                      
					meta:set_int("elapsed", 0)
                      
					local recipe = technic.get_recipe("cooking", inv:get_list("src"))

					if not recipe then
						meta:set_string("infotext", S("%s is empty"):format(machine_name))
						technic.swap_node(pos, "technic:solar_furnace")
						meta:set_string("formspec", formspec)
					end
                      
				else

					local percent = math.floor(meta:get_int("elapsed") / meta:get_int("cook_time") * 100)
					if percent > 100 then
						percent = 100
					end
					meta:set_string("infotext", S("%s is active"):format(machine_name).." ("..percent.."%)")
					technic.swap_node(pos, "technic:solar_furnace_active")
					meta:set_string("formspec",
							"size[8,9]"..
							"label[0,0;"..machine_name.."]"..
							"image[2,2;1,1;technic_power_meter_bg.png^[lowpart:" .. percent .. ":technic_power_meter_fg.png]"..
							"list[current_name;src;2,1;1,1;]"..
							"list[current_name;dst;5,1;2,2;]"..
							"list[current_player;main;0,5;8,4;]"..
							"listring[current_name;dst]"..
							"listring[current_player;main]"..
							"listring[current_name;src]"..
							"listring[current_player;main]")
					return
	
					meta:set_int("elapsed", meta:get_int("elapsed") + 1)
				end
			else
				meta:set_int("elapsed", 0)
				
				meta:set_string("infotext", S("%s is empty"):format(machine_name))
				technic.swap_node(pos, "technic:solar_furnace")
				meta:set_string("formspec", formspec)
			end
				
		else

			meta:set_int("elapsed", 0)
                                                     
			meta:set_string("infotext", S("%s cannot function\nMust be in full direct sunlight"):format(machine_name))
			technic.swap_node(pos, "technic:solar_furnace")
			meta:set_string("formspec", formspec)
		end
		
		
	end,
})

