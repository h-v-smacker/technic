
local S = technic.getter

technic.register_recipe_type("sawmilling", { 
	description = S("Sawmilling"),
	icon = "technic_recipe_icon_sawmilling.png"})
                            
function technic.register_sawmill_recipe(data)
	data.time = data.time or 4
	technic.register_recipe("sawmilling", data)
end

local recipes = {
	{"default:acacia_tree", "default:acacia_wood 8"},
	{"default:aspen_tree",  "default:aspen_wood 8"},
	{"default:jungletree",  "default:junglewood 8"},
	{"default:tree",        "default:wood 8"},
	{"default:pine_tree",   "default:pine_wood 8"}
}

if minetest.get_modpath("moretrees") then
	table.insert(recipes, {"moretrees:acacia_trunk", "moretrees:acacia_planks 8"})
	table.insert(recipes, {"moretrees:apple_tree_trunk", "moretrees:apple_tree_planks 8"})
	table.insert(recipes, {"moretrees:beech_trunk", "moretrees:beech_planks 8"})
	table.insert(recipes, {"moretrees:birch_trunk", "moretrees:birch_planks 8"})
	table.insert(recipes, {"moretrees:fir_trunk", "moretrees:fir_planks 8"})
	table.insert(recipes, {"moretrees:oak_trunk", "moretrees:oak_planks 8"})
	table.insert(recipes, {"moretrees:palm_trunk", "moretrees:palm_planks 8"})
	table.insert(recipes, {"moretrees:pine_trunk", "moretrees:pine_planks 8"})
	table.insert(recipes, {"moretrees:sequoia_trunk", "moretrees:sequoia_planks 8"})
	table.insert(recipes, {"moretrees:spruce_trunk", "moretrees:spruce_planks 8"})
	table.insert(recipes, {"moretrees:willow_trunk", "moretrees:willow_planks 8"})
	table.insert(recipes, {"moretrees:jungletree_trunk", "moretrees:jungletree_planks 8"})
	table.insert(recipes, {"moretrees:poplar_trunk", "moretrees:poplar_planks 8"})
end

if minetest.get_modpath("ethereal") then
	table.insert(recipes, {"ethereal:willow_trunk", "ethereal:willow_wood 8"})
	table.insert(recipes, {"ethereal:redwood_trunk", "ethereal:redwood_wood 8"})
	table.insert(recipes, {"ethereal:frost_tree", "ethereal:frost_wood 8"})
	table.insert(recipes, {"ethereal:yellow_trunk", "ethereal:yellow_wood 8"})
	table.insert(recipes, {"ethereal:birch_trunk", "ethereal:birch_wood 8"})
	table.insert(recipes, {"ethereal:palm_trunk", "ethereal:palm_wood 8"})
	table.insert(recipes, {"ethereal:banana_trunk", "ethereal:banana_wood 8"})
	table.insert(recipes, {"ethereal:bamboo", "ethereal:bamboo_block"})
-- 	table.insert(recipes, {"ethereal:mushroom_trunk", "???"})
	table.insert(recipes, {"ethereal:sakura_trunk", "ethereal:sakura_wood 8"})
-- 	table.insert(recipes, {"ethereal:scorched_tree", "???"})
end

if minetest.get_modpath("maple") then
	table.insert(recipes, {"maple:maple_tree", "maple:maple_wood 8"})
end

for _, data in pairs(recipes) do
	if data[3] then
		technic.register_sawmill_recipe({input = {data[1]}, output = data[2], time = data[3]})
	else
		technic.register_sawmill_recipe({input = {data[1]}, output = data[2]})
	end
end
