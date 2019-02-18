local S = technic.getter

technic.register_recipe_type("ifreezing", { 
	description = S("Industrial Freezing"), 
	icon = "technic_recipe_icon_freezing.png", 
	output_size = 2, })

function technic.register_freezer_recipe(data)
	data.time = data.time or 5
	technic.register_recipe("ifreezing", data)
end

local recipes = {
	{"bucket:bucket_water", { "default:ice 2", "bucket:bucket_empty" } },
	{"bucket:bucket_river_water", { "default:ice 2", "bucket:bucket_empty" } },
	{"default:dirt", {"default:dirt_with_snow"} },
	{"bucket:bucket_lava", { "default:obsidian 2", "bucket:bucket_empty" } }
}

for _, data in pairs(recipes) do
	technic.register_freezer_recipe({input = {data[1]}, output = data[2]})
end
