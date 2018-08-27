
-- defuse reverse recipes to avoid multiplication of matter
-- the reverse functions are delegated to grinder

minetest.clear_craft({
        output = "default:sand",
        recipe = {
                {"default:sandstone"}
		}
})

minetest.clear_craft({
        output = "default:desert_sand",
        recipe = {
                {"default:desert_sandstone"}
        }
})

minetest.clear_craft({
        output = "default:silver_sand",
        recipe = {
                {"default:silver_sandstone"}
        }
})


if minetest.get_modpath("ethereal") and ethereal.xcraft == true then

	-- X pattern craft recipes (5x 'a' in X pattern gives 5 of 'b')
	local cheat = {
		{"default:dirt", "default:sand", 5},
		{"ethereal:dry_dirt", "default:desert_sand", 5},
	}

	for n = 1, #cheat do

		minetest.register_craft({
			output = cheat[n][2] .. " " .. cheat[n][3],
			recipe = {
					{cheat[n][1], "", cheat[n][1]},
					{"", cheat[n][1], ""},
					{cheat[n][1], "", cheat[n][1]},
			}
		})
	end

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