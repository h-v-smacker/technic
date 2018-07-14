minetest.register_craft({
	output = "technic:mv_thresher",
	recipe = {
		{"technic:motor",          "technic:copper_plate",   "technic:diamond_drill_head"},
		{"default:copper_ingot",   "technic:machine_casing", "default:copper_ingot"      },
		{"pipeworks:one_way_tube", "technic:mv_cable",       "pipeworks:mese_filter"     },
	}
})

technic.register_thresher({
	tier = "MV",
	demand = {700, 500, 350},
	speed = 2,
	upgrade = 1,
	tube = 1,
})
