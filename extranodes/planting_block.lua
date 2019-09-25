-- block with water retaining properties for decorative planting

local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_node(":technic:planting_block", {
	description = S("Planting Block"),
	tiles = {"default_grass.png", 
		"technic_planting_block_bottom.png",
		"technic_planting_block_side.png",
		"technic_planting_block_side.png",
		"technic_planting_block_side.png",
		"technic_planting_block_side.png"},
	groups = {crumbly = 3, soil = 3, wet = 1},
	sounds = default.node_sound_dirt_defaults(),
	paramtype = "light",
})

minetest.register_craft({
	output = "technic:planting_block",
	recipe = {
		{ "default:paper", "default:dirt", "default:paper"},
		{ "default:paper", "technic:latex_foam", "default:paper"},
		{ "mesecons_materials:glue", "default:paper", "mesecons_materials:glue"},
	}
})
