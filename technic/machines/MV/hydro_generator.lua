-- A water mill produces EUs by exploiting flowing water across it
-- It is a MV EU supplyer with attractively high yield (2025)

minetest.register_craft({
	output = 'technic:mv_hydro_generator',
	recipe = {
		{'technic:marble', 'default:diamond',        'technic:marble'},
		{'technic:carbon_plate',     'technic:machine_casing', 'technic:carbon_plate'},
		{'technic:marble', 'technic:mv_cable',       'technic:marble'},
	}
})

technic.register_hydro_generator({tier="MV", supply=45})
