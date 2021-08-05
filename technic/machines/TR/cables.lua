
minetest.register_craft({
	output = 'technic:tr_cable 12',
	recipe = {
		{'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting'},
		{'default:tin_ingot',          'default:gold_ingot',         'default:tin_ingot'},
		{'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting'},
	}
}) 

technic.register_cable("TR", 3.5/16)

