-- A water mill produces EUs by exploiting flowing water across it
-- It is a LV EU supplyer with attractively high yield (1575)
-- It is noticeably better than the geothermal generator

minetest.register_alias("water_mill", "technic:lv_hydro_generator")
minetest.register_alias("technic:water_mill", "technic:lv_hydro_generator")
minetest.register_alias("technic:water_mill_active", "technic:lv_hydro_generator_active")

minetest.register_craft({
	output = 'technic:lv_hydro_generator',
	recipe = {
		{'technic:marble', 'default:diamond',        'technic:marble'},
		{'group:wood',     'technic:machine_casing', 'group:wood'},
		{'technic:marble', 'technic:lv_cable',       'technic:marble'},
	}
})

technic.register_hydro_generator({tier="LV", supply=20})
