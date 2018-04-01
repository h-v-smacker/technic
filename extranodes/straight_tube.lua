-- straight-only pipe
-- does not connect side-wise, allows items in both directions
-- a counterpart to straight-only pipe, and a cheap alternative 
-- to one-way tube for long segments of parallel pipes

if minetest.get_modpath("pipeworks") then

	minetest.register_node(":pipeworks:straight_tube", {
		description = "Straight-only Tube",
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

end