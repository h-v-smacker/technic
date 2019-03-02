local S = technic.getter

technic.register_recipe_type("ifreezing", { 
	description = S("Industrial Freezing"), 
	icon = "technic_recipe_icon_freezing.png", 
	output_size = 2, })

function technic.register_freezer_recipe(data)
	data.time = data.time or 3
	technic.register_recipe("ifreezing", data)
end

local recipes = {
	{"bucket:bucket_water",       {"default:ice 2", "bucket:bucket_empty"},      1},
	{"bucket:bucket_river_water", {"default:ice 2", "bucket:bucket_empty"},      1},
	{"bucket:bucket_lava",        {"default:obsidian 2", "bucket:bucket_empty"}, 1},
	{"default:dirt",              {"default:dirt_with_snow"},                    2},
	{"technic:water_can",         {"default:ice 3"}                               },
	{"technic:freshwater_can",    {"default:ice 3"}                               },
	{"technic:lava_can",          {"default:obsidian 3"}                          },
}

for _, data in pairs(recipes) do
	if data[3] then
		technic.register_freezer_recipe({input = {data[1]}, output = data[2], time = data[3]})
	else
		technic.register_freezer_recipe({input = {data[1]}, output = data[2]})
	end
end
