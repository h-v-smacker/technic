local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local plastic_nodes = {
	{node = "plastic_clean", name = S("Plastic Clean"), tiles = {"technic_plastic_clean.png"}},
	{node = "plastic_siding_1", name = S("Plastic Siding Block 1"), tiles = {"technic_plastic_siding_1.png"}},
	{node = "plastic_siding_2", name = S("Plastic Siding Block 2"), tiles = {"technic_plastic_siding_2.png"}},
	{node = "plastic_siding_3", name = S("Plastic Siding Block 3"), tiles = {"technic_plastic_siding_3.png"}},
	{node = "plastic_bricks", name = S("Plastic Bricks"), tiles = {"technic_plastic_bricks.png"}},
	{node = "plastic_block", name = S("Plastic Block"), tiles = {"technic_plastic_block.png"}},
	{node = "plastic_cross", name = S("Plastic Cross"), tiles = {"technic_plastic_cross.png"}},
	{node = "plastic_waves", name = S("Plastic Waves"), tiles = {"technic_plastic_waves.png"}},
	{node = "plastic_tiles", name = S("Plastic Tiles"), tiles = {"technic_plastic_tiles.png"}},
}

for _,n in pairs(plastic_nodes) do

	minetest.register_node (":technic:" .. n.node, {
		description = n.name,
		drawtype = "normal",
		tiles = n.tiles,
		drop = "technic:" .. n.node,
		groups = {dig_immediate = 2, paintable_plastic_block = 1},
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "technic_paint_palette.png",
	})
	
end

local thin_nodes = {
	{node = "plastic_siding_1", name = S("Plastic Siding 1"), tiles = {"technic_plastic_siding_1.png"}},
	{node = "plastic_siding_2", name = S("Plastic Siding 2"), tiles = {"technic_plastic_siding_2.png"}},
	{node = "plastic_siding_3", name = S("Plastic Siding 3"), tiles = {"technic_plastic_siding_3.png"}},
}

for _,n in pairs(thin_nodes) do

	minetest.register_node (":technic:" .. n.node .. "_thin", {
		description = n.name,
		drawtype = "nodebox",
		tiles = n.tiles,
		node_box = {
			type = "wallmounted",
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			wall_top = {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
			wall_side = {-0.5, -0.5, -0.5, -0.25, 0.5, 0.5},
                },
		drop = "technic:" .. n.node .. "_thin",
		groups = {dig_immediate = 2, paintable_plastic_block = 1},
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "technic_paint_palette.png",
	})
	
end



minetest.register_craft({
	output = "technic:plastic_clean",
	type = "shapeless",
	recipe = {
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting"},
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting"},
		{ "homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting"}
	},
})

minetest.register_craft({
	output = "homedecor:plastic_sheeting 9",
	recipe = {
		{ "technic:plastic_clean"}
	},
})

minetest.register_craft({
	output = "technic:plastic_siding_1_thin 2",
	recipe = {
		{"technic:plastic_clean"},
	},
})

minetest.register_craft({
	output = "technic:plastic_siding_1",
	recipe = {
		{"technic:plastic_siding_1_thin", "technic:plastic_siding_1_thin"},
	},
})

minetest.register_craft({
	output = "technic:plastic_siding_2_thin 4",
	recipe = {
		{ "technic:plastic_clean", "", ""},
		{ "technic:plastic_clean", "", ""},
	},
})

minetest.register_craft({
	output = "technic:plastic_siding_2",
	recipe = {
		{"technic:plastic_siding_2_thin", "technic:plastic_siding_2_thin"},
	},
})

minetest.register_craft({
	output = "technic:plastic_siding_3_thin 6",
	recipe = {
		{ "technic:plastic_clean", "", ""},
		{ "technic:plastic_clean", "", ""},
		{ "technic:plastic_clean", "", ""},
	},
})

minetest.register_craft({
	output = "technic:plastic_siding_3",
	recipe = {
		{"technic:plastic_siding_3_thin", "technic:plastic_siding_3_thin"},
	},
})

minetest.register_craft({
	output = "technic:plastic_bricks 4",
	recipe = {
		{ "technic:plastic_clean", "technic:plastic_clean"},
		{ "technic:plastic_clean", "technic:plastic_clean"},
	},
})

minetest.register_craft({
	output = "technic:plastic_block 9",
	recipe = {
		{ "technic:plastic_clean", "technic:plastic_clean", "technic:plastic_clean"},
		{ "technic:plastic_clean", "technic:plastic_clean", "technic:plastic_clean"},
		{ "technic:plastic_clean", "technic:plastic_clean", "technic:plastic_clean"},
	},
})
