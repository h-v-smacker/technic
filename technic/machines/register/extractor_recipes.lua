
local S = technic.getter

technic.register_recipe_type("extracting", { description = S("Extracting") })

function technic.register_extractor_recipe(data)
	data.time = data.time or 4
	technic.register_recipe("extracting", data)
end

if minetest.get_modpath("dye") then
	-- check if we are using dye or unifieddyes
	local unifieddyes = minetest.get_modpath("unifieddyes")

	-- register recipes with the same crafting ratios as `dye` provides
	local dye_recipes = {
		{"technic:coal_dust",                 "dye:black 2"},
		{"default:grass_1",                   "dye:green 1"},
		{"default:dry_shrub",                 "dye:brown 1"},
		{"default:junglegrass",               "dye:green 2"},
		{"default:cactus",                    "dye:green 4"},
		{"flowers:geranium",                  "dye:blue 4"},
		{"flowers:dandelion_white",           "dye:white 4"},
		{"flowers:dandelion_yellow",          "dye:yellow 4"},
		{"flowers:tulip",                     "dye:orange 4"},
		{"flowers:rose",                      "dye:red 4"},
		{"flowers:viola",                     "dye:violet 4"},
		{"bushes:blackberry",                 unifieddyes and "unifieddyes:magenta_s50 4" or "dye:violet 4"},
		{"bushes:blueberry",                  unifieddyes and "unifieddyes:magenta_s50 4" or "dye:magenta 4"},
	}

	if minetest.get_modpath("hunger") and minetest.get_modpath("ethereal") then
		table.insert(dye_recipes, {"ethereal:willow_twig 12", "technic:aspirin_pill"})
	end
	
	if minetest.get_modpath("farming") then
		-- Cottonseed oil: a fuel and a potent fertilizer (irl: pesticide) ---
		-- hemp oil calls for 8 seeds, but extractor recipes are normally twice as potent
		table.insert(dye_recipes, {"farming:seed_cotton 4", "technic:cottonseed_oil"})
		
		-- Dyes ---
		-- better recipes for farming's crafting methods (twice the output)
		table.insert(dye_recipes, {"farming:chili_pepper", "dye:red 4"})
		table.insert(dye_recipes, {"farming:beans", "dye:green 4"})
		table.insert(dye_recipes, {"farming:grapes", "dye:violet 4"})
		table.insert(dye_recipes, {"farming:cocoa_beans", "dye:brown 4"})
		-- Some extra recipes:
		-- Himalayan rhubarb root can give yellow dye IRL
		table.insert(dye_recipes, {"farming:rhubarb", "dye:yellow 4"})
		table.insert(dye_recipes, {"farming:onion", "dye:yellow 4"})
		table.insert(dye_recipes, {"farming:blueberries", "dye:blue 4"})
		table.insert(dye_recipes, {"farming:raspberries", "dye:red 4"})
	end
	
	if minetest.get_modpath("ethereal") then
		table.insert(dye_recipes, {"ethereal:fern", "dye:dark_green 4"})
		table.insert(dye_recipes, {"ethereal:snowygrass", "dye:grey 4"})
		table.insert(dye_recipes, {"ethereal:crystalgrass", "dye:blue 4"})
	end
	
	if minetest.get_modpath("bonemeal") then
		table.insert(dye_recipes, {"bonemeal:bone", "dye:white 8"})
		table.insert(dye_recipes, {"bonemeal:bonemeal", "dye:white 4"})
	end
	
	for _, data in ipairs(dye_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end

	-- overwrite the existing crafting recipes
	local dyes = {"white", "red", "yellow", "blue", "violet", "orange"}
	for _, color in ipairs(dyes) do
		minetest.register_craft({
		        type = "shapeless",
		        output = "dye:"..color.." 1",
		        recipe = {"group:flower,color_"..color},
		})

	end
	
	-- When the recipe for 4 default:sand out of 1 default:sandstone is defused in the
	-- grinder recipes, some dyed wool becomes broken. This is a known bug and it's in 
	-- the game itself. However, by re-declaring the recipes for corrupted wool+dye
	-- combinations here, we can alleviate this situation. Or so it seeems.
	-- The following code snippet is abridged from wool mod in the minetest_game:
	
	if minetest.get_modpath("wool") then
			
		local dyes = {
			{"violet",     "Violet",     "excolor_violet"},
			{"brown",      "Brown",      "unicolor_dark_orange"},
			{"pink",       "Pink",       "unicolor_light_red"},
			{"dark_grey",  "Dark Grey",  "unicolor_darkgrey"},
			{"dark_green", "Dark Green", "unicolor_dark_green"},
		}

		for i = 1, #dyes do
			local name, desc, craft_color_group = unpack(dyes[i])
			minetest.register_craft{
				type = "shapeless",
				output = "wool:" .. name,
				recipe = {"group:dye," .. craft_color_group, "group:wool"},
			}
		end

	end
	
	-- end of remedial dye workaround
	
	
	minetest.register_craft({
		type = "shapeless",
		output = "dye:black 1",
		recipe = {"group:coal"},
	})

	if unifieddyes then
		minetest.register_craft({
			type = "shapeless",
			output = "dye:green 1",
			recipe = {"default:cactus"},
		})
	end
end
