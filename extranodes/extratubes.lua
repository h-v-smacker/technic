-- EXTRATUBES
-- This files add some new tube types, to widen the pipeworks mod assortment of
-- available parts in order to better meet the needs of expansive automation
local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

if minetest.get_modpath("pipeworks") then

	-- straight-only pipe
	-- does not connect side-wise, allows items in both directions
	-- a counterpart to straight-only pipe, and a cheap alternative 
	-- to one-way tube for long segments of parallel pipes
	
	minetest.register_node(":pipeworks:straight_tube", {
		description = S("Straight-only Tube"),
		tiles = {"pipeworks_straight_tube_side.png", 
			"pipeworks_straight_tube_side.png", 
			"pipeworks_straight_tube_output.png",
			"pipeworks_straight_tube_input.png", 
			"pipeworks_straight_tube_side.png", 
			"pipeworks_straight_tube_side.png"},
		paramtype2 = "facedir",
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {type = "fixed",
			fixed = {{-1/2, -9/64, -9/64, 1/2, 9/64, 9/64}}},
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1},
		sounds = default.node_sound_wood_defaults(),
		tube = {
			connect_sides = {left = 1, right = 1},
			can_go = function(pos, node, velocity, stack)
					return {velocity}
				end,
			can_insert = function(pos, node, stack, direction)
					local dir = pipeworks.facedir_to_right_dir(node.param2)
					local opdir = vector.multiply(dir, -1)
					return vector.equals(dir, direction) or vector.equals(opdir, direction)
				end,
			priority = 60 -- Higher than normal tubes, but lower than one-way tubes
		},
		after_place_node = pipeworks.after_place,
		after_dig_node = pipeworks.after_dig,
	})

	minetest.register_craft({
		output = "pipeworks:straight_tube 3",
		recipe = {
			{ "pipeworks:tube_1", "pipeworks:tube_1", "pipeworks:tube_1" },
		},
	})

	-- conducting one-way tube - to stop making those ugly shunting wires
	
	if pipeworks.enable_one_way_tube and pipeworks.enable_conductor_tube then
		minetest.register_node(":pipeworks:conductor_one_way_tube_on", {
			description = S("One-way Conducting Tube"),
			tiles = {"pipeworks_conductor_one_way_tube_top_on.png", 
				"pipeworks_conductor_one_way_tube_top_on.png", 
				"pipeworks_conductor_one_way_tube_output_on.png",
				"pipeworks_conductor_one_way_tube_input_on.png", 
				"pipeworks_conductor_one_way_tube_side_on.png", 
				"pipeworks_conductor_one_way_tube_top_on.png"},
			paramtype2 = "facedir",
			drawtype = "nodebox",
			paramtype = "light",
			node_box = {type = "fixed",
				fixed = {{-1/2, -9/64, -9/64, 1/2, 9/64, 9/64}}},
			groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1, mesecon = 2, not_in_creative_inventory = 1},
			sounds = default.node_sound_wood_defaults(),
			tube = {
				connect_sides = {left = 1, right = 1},
				can_go = function(pos, node, velocity, stack)
					return {velocity}
				end,
				can_insert = function(pos, node, stack, direction)
					local dir = pipeworks.facedir_to_right_dir(node.param2)
					return vector.equals(dir, direction)
				end,
				priority = 75 -- Higher than normal tubes, but lower than receivers
			},
			after_place_node = pipeworks.after_place,
			after_dig_node = pipeworks.after_dig,
			mesecons = {
				conductor = {state = mesecon.state.on,
						rules = pipeworks.mesecons_rules,
						onstate = "pipeworks:conductor_one_way_tube_on",
						offstate = "pipeworks:conductor_one_way_tube_off"
				}
			},
			drop = "pipeworks:conductor_one_way_tube_off",
		})
		
		minetest.register_node(":pipeworks:conductor_one_way_tube_off", {
			description = S("One-way Conducting Tube"),
			tiles = {"pipeworks_conductor_one_way_tube_top_off.png", 
				"pipeworks_conductor_one_way_tube_top_off.png", 
				"pipeworks_conductor_one_way_tube_output_off.png",
				"pipeworks_conductor_one_way_tube_input_off.png", 
				"pipeworks_conductor_one_way_tube_side_off.png", 
				"pipeworks_conductor_one_way_tube_top_off.png"},
			paramtype2 = "facedir",
			drawtype = "nodebox",
			paramtype = "light",
			node_box = {type = "fixed",
				fixed = {{-1/2, -9/64, -9/64, 1/2, 9/64, 9/64}}},
			groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1, mesecon = 2},
			sounds = default.node_sound_wood_defaults(),
			tube = {
				connect_sides = {left = 1, right = 1},
				can_go = function(pos, node, velocity, stack)
					return {velocity}
				end,
				can_insert = function(pos, node, stack, direction)
					local dir = pipeworks.facedir_to_right_dir(node.param2)
					return vector.equals(dir, direction)
				end,
				priority = 75 -- Higher than normal tubes, but lower than receivers
			},
			after_place_node = pipeworks.after_place,
			after_dig_node = pipeworks.after_dig,
			mesecons = {
				conductor = {state = mesecon.state.off,
						rules = pipeworks.mesecons_rules,
						onstate = "pipeworks:conductor_one_way_tube_on",
						offstate = "pipeworks:conductor_one_way_tube_off"
				}
			},
			drop = "pipeworks:conductor_one_way_tube_off",
		})
		
		minetest.register_craft({
			output = "pipeworks:conductor_one_way_tube_off",
			recipe = {
				{ "pipeworks:one_way_tube", "mesecons:wire_00000000_off"}
			},
		})
	end
	

end