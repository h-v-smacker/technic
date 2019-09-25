-- radiation sign

local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_node(":technic:radiation_sign", {
	description = S("Radiation Sign"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,0.48,0.5,0.5,0.5}
		},
	collision_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,0.48,0.5,0.5,0.5}
		},
	selection_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,0.48,0.5,0.5,0.5}
		},
	tiles = { "technic_radiation_sign.png" },
	groups = {crumbly = 3},
	sounds = default.node_sound_dirt_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 3,
})

minetest.register_craft({
	output = "technic:radiation_sign 3",
	recipe = {
		{ "dye:yellow", "dye:black", "dye:yellow"},
		{ "dye:yellow", "default:sign_wall_wood", "dye:yellow"},
		{ "dye:black", "dye:yellow", "dye:black"},
	}
})
