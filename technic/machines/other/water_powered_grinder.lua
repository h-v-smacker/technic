
-- Water-powered grinder. Uses the hydro turbine from mesecons to "power" itself.
-- Can be used along the fuel-powered alloying furnace to get some minimal benefits
-- of the technic mod. Also adds a purpose for mesecon hydroturbine which, despite
-- being beautifully animated, doesn't do much practical in game.


local S = technic.getter

minetest.register_craft({
	output = 'technic:water_powered_grinder',
	recipe = {
		{'technic:granite',	'technic:granite',		'technic:granite'},
		{'technic:granite',	'technic:wrought_iron_ingot',	'technic:granite'},
		{'default:brick',		'technic:wrought_iron_ingot',	'default:brick'},
	}
})

local machine_name = S("Water-powered Grinder")
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


local function run_water_grinder(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local inv    = meta:get_inventory()
	
	local recipe = nil

	if not meta:get_int("processing") then
		meta:set_int("processing", 0)
	end
	
	local result = technic.get_recipe("grinding", inv:get_list("src"))

	local power_pos = {
		{x = -1, y = 0, z = 0},
		{x = 1, y = 0, z = 0},
		{x = 0, y = -1, z = 0},
		{x = 0, y = 1, z = 0},
		{x = 0, y = 0, z = -1},
		{x = 0, y = 0, z = 1}
	}
	local powered = false
	for _,pp in ipairs(power_pos) do
		local node = minetest.get_node_or_nil({x = pos.x + pp.x, y = pos.y + pp.y, z = pos.z + pp.z})
		if node and node.name == "mesecons_hydroturbine:hydro_turbine_on" then
			powered = true
			break
		end
	end
	
	if powered then 

		if result then
			
			if meta:get_int("processing") == 5 then
				
				local percent = 100
				meta:set_string("infotext", S("%s is active"):format(machine_name).." ("..percent.."%)")
				meta:set_string("formspec",
								"size[8,9]"..
								"label[0,0;"..machine_name.."]"..
								"image[2,2;1,1;technic_power_meter_bg.png^[lowpart:" .. percent .. ":technic_power_meter_fg.png]"..
								"list[current_name;fuel;2,3;1,1;]"..
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
				
				meta:set_int("processing", 0)
				
				local recipe = technic.get_recipe("grinding", inv:get_list("src"))

				if not recipe then
					meta:set_string("infotext", S("%s is empty"):format(machine_name))
					technic.swap_node(pos, "technic:water_powered_grinder")
					meta:set_string("formspec", formspec)
				end
				
			else
				
				local percent = math.floor(meta:get_int("processing") / 5 * 100)
				meta:set_string("infotext", S("%s is active"):format(machine_name).." ("..percent.."%)")
				technic.swap_node(pos, "technic:water_powered_grinder_active")
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
				meta:set_int("processing", meta:get_int("processing") + 1)
				return true
					

			end
		else
			meta:set_int("processing", 0)
			
			meta:set_string("infotext", S("%s is empty"):format(machine_name))
			technic.swap_node(pos, "technic:water_powered_grinder")
			meta:set_string("formspec", formspec)
		end
		
	else

		meta:set_int("processing", 0)
		
		meta:set_string("infotext", S("%s is unpowered\nMust be placed next to a mesecon water turbine\nThe turbine must be active"):format(machine_name))
		technic.swap_node(pos, "technic:water_powered_grinder_unpowered")
		meta:set_string("formspec", formspec)
	end
	return true
	
end




minetest.register_node("technic:water_powered_grinder", {
	description = machine_name,
	tiles = {"technic_water_powered_grinder_top.png",  "technic_water_powered_grinder_side.png",
	         "technic_water_powered_grinder_side.png", "technic_water_powered_grinder_side.png",
	         "technic_water_powered_grinder_side.png", "technic_water_powered_grinder_front.png"},
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
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	can_dig = technic.machine_can_dig,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	on_timer = run_water_grinder,
})

minetest.register_node("technic:water_powered_grinder_unpowered", {
	description = machine_name,
	tiles = {"technic_water_powered_grinder_top.png",  "technic_water_powered_grinder_side.png",
	         "technic_water_powered_grinder_side.png", "technic_water_powered_grinder_side.png",
	         "technic_water_powered_grinder_side.png", "technic_water_powered_grinder_front_unpowered.png"},
	paramtype2 = "facedir",
	drop = "technic:water_powered_grinder",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	can_dig = technic.machine_can_dig,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	on_timer = run_water_grinder,
	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,

})

minetest.register_node("technic:water_powered_grinder_active", {
	description = machine_name,
	tiles = {"technic_water_powered_grinder_top.png",  "technic_water_powered_grinder_side.png",
	         "technic_water_powered_grinder_side.png", "technic_water_powered_grinder_side.png",
	         "technic_water_powered_grinder_side.png", "technic_water_powered_grinder_front_active.png"},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "technic:water_powered_grinder",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	can_dig = technic.machine_can_dig,
	allow_metadata_inventory_put = technic.machine_inventory_put,
	allow_metadata_inventory_take = technic.machine_inventory_take,
	allow_metadata_inventory_move = technic.machine_inventory_move,
	on_timer = run_water_grinder,
	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,

})

