local S = technic.getter

-- This is a roundabout way to use cans with furnaces which cannot be 
-- achieved using the standard "cooking" recipe.
-- Alternatively, "heating" recipes can be used to provide non-cooking-compatible recipes
-- such as those with multiple output materials. Those recipes would only be usable in
-- technic furnaces.

technic.register_recipe_type("heating", { 
	description = S("Heating"), 
	icon = "technic_recipe_icon_heating.png", 
	output_size = 2, })

function technic.register_electric_furnace_recipe(data)
	data.time = data.time or 7
	technic.register_recipe("heating", data)
end

local recipes = {}

if minetest.get_modpath("farming") and farming.mod and (farming.mod == "redo" or farming.mod == "undo") then
	table.insert(recipes, {"technic:water_can", {"farming:salt"}, 7})
	table.insert(recipes, {"technic:water_jumbo_can", {"farming:salt"}, 7})
end

for _, data in pairs(recipes) do
	if data[3] then
		technic.register_electric_furnace_recipe({input = {data[1]}, output = data[2], time = data[3]})
	else
		technic.register_electric_furnace_recipe({input = {data[1]}, output = data[2]})
	end
end
