-- HV monstrosity

minetest.register_craft({
	output = 'technic:hv_alloy_furnace',
	recipe = {
		{'technic:carbon_plate', 'technic:mv_alloy_furnace', 'technic:composite_plate'},
		{'pipeworks:tube_1',              'technic:hv_transformer',   'pipeworks:tube_1'},
		{'technic:stainless_steel_ingot', 'technic:hv_cable',         'technic:stainless_steel_ingot'},
	}
})


technic.register_alloy_furnace({tier = "HV", speed = 3, upgrade = 1, tube = 1, demand = {10000, 9000, 8000}})

