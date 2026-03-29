
local S = technic.getter

technic.register_recipe_type("compressing", { 
	description = S("Compressing"),
	icon = "technic_recipe_icon_compressing.png" })

function technic.register_compressor_recipe(data)
	data.time = data.time or 4
	technic.register_recipe("compressing", data)
end

local recipes = {
	{"default:snowblock",          "default:ice"},
	{"default:sand 2",             "default:sandstone"},
	{"default:silver_sand 2",      "default:silver_sandstone"},
--	{"default:desert_sand",        "default:desert_stone"},
--	for consistency, any sand should be compressed into respective sandstone type
	{"default:desert_sand 2",      "default:desert_sandstone"},
	{"technic:mixed_metal_ingot",  "technic:composite_plate"},
	{"technic:light_copper_plate 5",     "technic:copper_plate"},
	{"technic:coal_dust 4",        "technic:graphite"},
	{"technic:carbon_cloth",       "technic:carbon_plate"},
	{"technic:uranium35_ingot 5",  "technic:uranium_fuel"},
	{"default:coalblock",          "technic:graphite_rod"},
	{"technic:diamond_seed 25",    "default:diamond"},
	{"default:bronze_ingot",       "technic:bronze_plate"},
	{"default:copper_ingot",       "technic:light_copper_plate"},
	{"default:gold_ingot",         "technic:gold_plate"},
	{"default:steel_ingot",        "technic:wrought_iron_plate"},
	{"default:tin_ingot",          "technic:tin_plate"},
	{"technic:brass_ingot",        "technic:brass_plate"},
	{"technic:carbon_steel_ingot", "technic:steel_plate"},
	{"technic:cast_iron_ingot",    "technic:cast_iron_plate"},
	{"technic:chromium_ingot",     "technic:chromium_plate"},
	{"technic:lead_ingot",         "technic:lead_plate"},
	{"technic:stainless_steel_ingot", "technic:stainless_steel_plate"},
	{"technic:uranium0_ingot",     "technic:uranium_plate"},
	{"technic:uranium_ingot",      "technic:uranium_plate"},
	{"technic:zinc_ingot",         "technic:zinc_plate"}
}


if minetest.get_modpath("ethereal") then
	
	-- substitute for old recipe chain
	-- instead of 5 dry dirt -> 1 desert sand -> compressing -> desert_stone
	table.insert(recipes, {"ethereal:dry_dirt 5", "default:desert_stone"})
	
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
	table.insert(recipes, {"ethereal:sakura_leaves 15", "ethereal:charcoal_lump 1"})
	
	if minetest.get_modpath("technic_worldgen") or minetest.get_modpath("moretrees") then
		table.insert(recipes, {"moretrees:rubber_tree_leaves 15", "ethereal:charcoal_lump 1"})
	end

end

if minetest.get_modpath("pathv7") then
	table.insert(recipes, {"default:acacia_wood", "pathv7:bridgewood 1"})
	table.insert(recipes, {"default:junglewood", "pathv7:junglewood 1"})
end



if minetest.get_modpath("moreores") then
	table.insert(recipes, {"moreores:mithril_ingot", "technic:mithril_plate"})
	table.insert(recipes, {"moreores:silver_ingot",  "technic:silver_plate"})
end



for _, data in pairs(recipes) do
	technic.register_compressor_recipe({input = {data[1]}, output = data[2]})
end
