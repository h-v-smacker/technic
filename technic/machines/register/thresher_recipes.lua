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
		table.insert(recipes, { input = "bushes:"..berry.."_bush", 
		                        output = {"default:stick 20", "bushes:"..berry.." 4" }})
	end
end

if minetest.get_modpath("farming") then
	
	table.insert(recipes, { input = "farming:hemp_leaf", 
	                        output = {"farming:hemp_fibre"}})
	
	if minetest.get_modpath("cottages") then
		-- work as a mechanized threshing floor from cottages
		table.insert(recipes, { input = "farming:wheat", 
		                        output = {"farming:seed_wheat", "cottages:straw_mat"} })
		table.insert(recipes, { input = "farming:barley", 
		                        output = {"farming:seed_barley", "cottages:straw_mat"} })
	else
		-- work in a less fancy and less efficient manner
		table.insert(recipes, { input = "farming:wheat 4", 
		                        output = {"farming:seed_wheat 3", "default:dry_shrub 1"} })
		table.insert(recipes, { input = "farming:barley 4", 
		                        output = { "farming:seed_barley 3", "default:dry_shrub 1"} })
	end
end

-- using thresher as a sorting machine for grass seeds
table.insert(recipes, { input = "default:grass_1 99", 
                        output = {"default:dry_grass_1 80", "default:dry_shrub 7", "default:junglegrass 12"}, 
                        time = 16 })

if minetest.get_modpath("ethereal") then
	table.insert(recipes, { input = "default:junglegrass 99", 
	                        output = {"ethereal:dry_shrub 10", "ethereal:crystalgrass 5", "ethereal:snowygrass 5" }, 
	                        time = 16 })
	table.insert(recipes, { input = "default:dry_grass_1 99", 
	                        output = {"ethereal:fern 5"}, 
	                        time = 16 })
end


for _,data in ipairs(recipes) do
	technic.register_threshing_recipe({input = {data.input}, output = data.output, time = data.time})
end
