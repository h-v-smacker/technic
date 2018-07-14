-- the thresher should take the agricultural functions away from the centrifuge

local S = technic.getter

technic.register_recipe_type("threshing", {
	description = S("Threshing"),
	output_size = 2,
})

function technic.register_threshing_recipe(data)
	data.time = data.time or 2
	technic.register_recipe("threshing", data)
end

local recipes = {
}

if minetest.get_modpath("bushes_classic") then
	for _, berry in ipairs({ "blackberry", "blueberry", "gooseberry", "raspberry", "strawberry" }) do
		table.insert(recipes, { "bushes:"..berry.."_bush", "default:stick 20", "bushes:"..berry.." 4" })
	end
end

if minetest.get_modpath("farming") then
	
	table.insert(recipes, {"farming:hemp_leaf", "farming:hemp_fibre"})
	
	if minetest.get_modpath("cottages") then
		-- work as a mechanized threshing floor
		table.insert(recipes, { "farming:wheat", "farming:seed_wheat", "cottages:straw_mat" })
		table.insert(recipes, { "farming:barley", "farming:seed_barley", "cottages:straw_mat" })
	else
		-- work in a less fancy and less efficient manner
		table.insert(recipes, { "farming:wheat 4", "farming:seed_wheat 3", "default:dry_shrub 1" })
		table.insert(recipes, { "farming:barley 4", "farming:seed_barley 3", "default:dry_shrub 1" })
	end
end

-- using centfuge as a sorting machine for grass seeds
table.insert(recipes, { "default:grass_1 99", "default:dry_grass_1 80", "default:dry_shrub 7", "default:junglegrass 12" })
if minetest.get_modpath("ethereal") then
	table.insert(recipes, { "default:junglegrass 99", "ethereal:dry_shrub 10", "ethereal:crystalgrass 5", "ethereal:snowygrass 5" })
	table.insert(recipes, { "default:dry_grass_1 99", "ethereal:fern 5" })
end


for _, data in pairs(recipes) do
	technic.register_threshing_recipe({ input = { data[1] }, output = { data[2], data[3], data[4] } })
end
