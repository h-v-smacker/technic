-- A water mill produces EUs by exploiting flowing water across it
-- It is a HV EU supplyer with attractively high yield (2475)

minetest.register_craft({
	output = 'technic:hv_hydro_generator',
	recipe = {
		{'technic:marble', 'default:diamond',        'technic:marble'},
		{'technic:composite_plate',     'technic:machine_casing', 'technic:composite_plate'},
		{'technic:marble', 'technic:hv_cable',       'technic:marble'},
	}
})

technic.register_hydro_generator({tier="HV", supply=55})
