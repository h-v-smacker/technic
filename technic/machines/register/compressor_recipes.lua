
local S = technic.getter

technic.register_recipe_type("compressing", { description = S("Compressing") })

function technic.register_compressor_recipe(data)
	data.time = data.time or 4
	technic.register_recipe("compressing", data)
end

local recipes = {
	{"default:snowblock",          "default:ice"},
	{"default:sand 2",             "default:sandstone"},
	{"default:silver_sand 2",      "default:silver_sandstone"},
	{"default:desert_sand",        "default:desert_stone"},
	{"technic:mixed_metal_ingot",  "technic:composite_plate"},
	{"default:copper_ingot 5",     "technic:copper_plate"},
	{"technic:coal_dust 4",        "technic:graphite"},
	{"technic:carbon_cloth",       "technic:carbon_plate"},
	{"technic:uranium35_ingot 5",  "technic:uranium_fuel"},
	{"technic:diamond_seed 25",    "default:diamond"}
}


if minetest.get_modpath("ethereal") then
	
	-- compressing most copious leaves into more compact fuel
	-- this conversion is based on the burn time (1 vs. 10) + some overhead
	table.insert(recipes, {"default:acacia_leaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"default:aspen_leaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"default:leaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"default:jungleleaves 15", "ethereal:charcoal_lump 1"})

	-- the density of charcoal is ~1/10 of coal, otherwise it's pure carbon
	table.insert(recipes, {"ethereal:charcoal_lump 10", "default:coal_lump 1"})
	-- + some leaves which are most often left over in large amounts
	table.insert(recipes, {"ethereal:willow_twig 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"ethereal:redwood_leaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"ethereal:frost_leaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"ethereal:yellowleaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"ethereal:birch_leaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"ethereal:bamboo_leaves 15", "ethereal:charcoal_lump 1"})
	table.insert(recipes, {"ethereal:orange_leaves 15", "ethereal:charcoal_lump 1"})
	
	if minetest.get_modpath("technic_worldgen") or minetest.get_modpath("moretrees") then
		table.insert(recipes, {"moretrees:rubber_tree_leaves 15", "ethereal:charcoal_lump 1"})
	end
	
end

table.insert(recipes, {"vessels:steel_bottle", "technic:lox"})

-- defuse the default sandstone recipe, since we have the compressor to take over in a more realistic manner
minetest.clear_craft({
	output = "default:sandstone",
	recipe = {
		{'group:sand', 'group:sand'},
		{'group:sand', 'group:sand'}
	},
})


for _, data in pairs(recipes) do
	technic.register_compressor_recipe({input = {data[1]}, output = data[2]})
end

