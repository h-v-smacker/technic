
-- A water-based extractor consumes water to produce dyes.
-- It is a slow device, but does not rely on a power grid.


local S = technic.getter

minetest.register_craft({
	output = 'technic:water_extractor',
	recipe = {
		{'pipeworks:tube_1',		'vessels:steel_bottle',	'pipeworks:tube_1'},
		{'technic:brass_ingot',		'bucket:bucket_empty',	'technic:brass_ingot'},
		{'default:bronze_ingot',	'default:bronze_ingot',	'default:bronze_ingot'},
	}
})

local machine_name = S("Water Extractor")
local formspec =
	"size[8,9]"..
	"label[0,0;"..machine_name.."]"..
	"image[2,2;1,1;technic_power_meter_bg.png]"..
	"list[current_name;water;2,3;1,1;]"..
	"list[current_name;src;2,1;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	"listring[current_name;water]"..
	"listring[current_player;main]"


local run_water_extractor = function(pos, elapsed)

	local meta = minetest.get_meta(pos)
	local inv    = meta:get_inventory()
	
	local recipe = nil
	elapsed = meta:get_int("elapsed")
	if not elapsed then
		meta:set_int("elapsed", 0)
		elapsed = 0
	end
	
	if not meta:get_int("extraction_time") then
		meta:set_int("extraction_time", 0)
	end
	
	local light_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
	
	local powered = false
		
	local waterlist = inv:get_list("water")
	if waterlist and string.find(waterlist[1]:get_name(), 'water') 
		and ((technic.manage_can_state(waterlist[1]) and technic.manage_can_state(waterlist[1]) > 0)
		or string.find(waterlist[1]:get_name(), 'bucket')) then
		powered = true
	end
	
	local result = technic.get_recipe("extracting", inv:get_list("src"))
	if result and not string.find(result.output, 'dye') then
		result = nil
	end
	
	if result and result.time then
		meta:set_int("extraction_time", result.time * 4)
	end
	

	
	if powered then 

		if result then
			
			if elapsed >= meta:get_int("extraction_time") then
				
				local percent = 100
				meta:set_string("infotext", S("%s is active"):format(machine_name).." ("..percent.."%)")
				meta:set_string("formspec",
								"size[8,9]"..
								"label[0,0;"..machine_name.."]"..
								"image[2,2;1,1;technic_power_meter_bg.png^[lowpart:" .. percent .. ":technic_power_meter_fg.png]"..
								"list[current_name;water;2,3;1,1;]"..
								"list[current_name;src;2,1;1,1;]"..
								"list[current_name;dst;5,1;2,2;]"..
								"list[current_player;main;0,5;8,4;]"..
								"listring[current_name;dst]"..
								"listring[current_player;main]"..
								"listring[current_name;src]"..
								"listring[current_player;main]"..
								"listring[current_name;water]"..
								"listring[current_player;main]")
				
				local result_stack = ItemStack(result.output)
				if inv:room_for_item("dst", result_stack) then
					inv:set_list("src", result.new_input)
					inv:add_item("dst", result_stack)
					if string.find(waterlist[1]:get_name(), 'bucket') then
						inv:set_list("water", {ItemStack("bucket:bucket_empty")})
					else
						inv:set_list("water", {technic.manage_can_state(waterlist[1], -1)})
					end
				end
				
				meta:set_int("elapsed", 0)
				
				local recipe = technic.get_recipe("extracting", inv:get_list("src"))

				if not recipe then
					meta:set_string("infotext", S("%s is empty"):format(machine_name))
					technic.swap_node(pos, "technic:water_extractor")
					meta:set_string("formspec", formspec)
				end
				
			else

				local percent = math.floor(elapsed / meta:get_int("extraction_time") * 100)
				if percent > 100 then
					percent = 100
				end
				meta:set_string("infotext", S("%s is active"):format(machine_name).." ("..percent.."%)")
				technic.swap_node(pos, "technic:water_extractor_active")
				meta:set_string("formspec",
								"size[8,9]"..
									"label[0,0;"..machine_name.."]"..
									"image[2,2;1,1;technic_power_meter_bg.png^[lowpart:" .. percent .. ":technic_power_meter_fg.png]"..
									"list[current_name;water;2,3;1,1;]"..
									"list[current_name;src;2,1;1,1;]"..
									"list[current_name;dst;5,1;2,2;]"..
									"list[current_player;main;0,5;8,4;]"..
									"listring[current_name;dst]"..
									"listring[current_player;main]"..
									"listring[current_name;src]"..
									"listring[current_player;main]"..
									"listring[current_name;water]"..
									"listring[current_player;main]")
				meta:set_int("elapsed", elapsed+1)
				return true				
			end
		else
			meta:set_int("elapsed", 0)
			
			meta:set_string("infotext", S("%s is empty"):format(machine_name))
			technic.swap_node(pos, "technic:water_extractor")
			meta:set_string("formspec", formspec)
		end
		
	else

		meta:set_int("elapsed", 0)
		
		meta:set_string("infotext", S("%s cannot function\nWater is required"):format(machine_name))
		technic.swap_node(pos, "technic:water_extractor")
		meta:set_string("formspec", formspec)
	end
	
	return true
end
    





minetest.register_node("technic:water_extractor", {
	description = machine_name,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-3/32, 14/32, -1/2, 3/32, 15/32, 1/2},
			{-6/32, 13/32, -1/2, 6/32, 14/32, 1/2},
			{-8/32, 12/32, -1/2, 8/32, 13/32, 1/2},
			{-9/32, 11/32, -1/2, 9/32, 12/32, 1/2},
			{-10/32, 10/32, -1/2, 10/32, 11/32, 1/2},
			{-11/32, 9/32, -1/2, 11/32, 10/32, 1/2},
			{-12/32, 7/32, -1/2, 12/32, 9/32, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 7/32, 1/2},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
		},
	},
	tiles = {"technic_water_extractor_top.png",  "technic_water_extractor_bottom.png",
	         "technic_water_extractor_side.png", "technic_water_extractor_side.png",
	         "technic_water_extractor_back.png", "technic_water_extractor_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", machine_name)
		local inv = meta:get_inventory()
		inv:set_size("water", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
		meta:set_int("elapsed", 0)
		meta:set_int("extraction_time", 0)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether the device can function or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	can_dig = technic.machine_can_dig,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	on_timer = run_water_extractor
})

minetest.register_node("technic:water_extractor_active", {
	description = machine_name,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-3/32, 14/32, -1/2, 3/32, 15/32, 1/2},
			{-6/32, 13/32, -1/2, 6/32, 14/32, 1/2},
			{-8/32, 12/32, -1/2, 8/32, 13/32, 1/2},
			{-9/32, 11/32, -1/2, 9/32, 12/32, 1/2},
			{-10/32, 10/32, -1/2, 10/32, 11/32, 1/2},
			{-11/32, 9/32, -1/2, 11/32, 10/32, 1/2},
			{-12/32, 7/32, -1/2, 12/32, 9/32, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 7/32, 1/2},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, -1/2, 1/2, 1/2, 1/2},

		},
	},
	tiles = {"technic_water_extractor_top.png",  "technic_water_extractor_bottom.png",
	         "technic_water_extractor_side.png", "technic_water_extractor_side.png",
	         "technic_water_extractor_back.png", "technic_water_extractor_front_active.png"},
	paramtype2 = "facedir",
	light_source = 5,
	drop = "technic:water_extractor",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	can_dig = technic.machine_can_dig,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	on_timer = run_water_extractor,
	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,

})


