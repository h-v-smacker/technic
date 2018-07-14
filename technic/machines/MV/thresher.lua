minetest.register_craft({
	output = "technic:mv_thresher",
	recipe = {
		{'technic:stainless_steel_ingot', 'technic:motor',          'technic:stainless_steel_ingot'},
		{'pipeworks:tube_1',              'technic:machine_casing', 'pipeworks:tube_1'},
		{'technic:stainless_steel_ingot', 'technic:mv_cable',       'technic:stainless_steel_ingot'},
	}
})

technic.register_thresher({
	tier = "MV",
	demand = {700, 500, 350},
	speed = 2,
	upgrade = 1,
	tube = 1,
})
