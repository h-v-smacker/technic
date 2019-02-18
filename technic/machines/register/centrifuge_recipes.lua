local S = technic.getter

technic.register_recipe_type("separating", {
	description = S("Separating"),
	icon = "technic_recipe_icon_separating.png",
	output_size = 2,
})

function technic.register_separating_recipe(data)
	data.time = data.time or 10
	technic.register_recipe("separating", data)
end

local recipes = {
	{ "technic:bronze_dust 4",             "technic:copper_dust 3",       "technic:tin_dust"      },
	{ "technic:stainless_steel_dust 4",    "technic:wrought_iron_dust 3", "technic:chromium_dust" },
	{ "technic:brass_dust 3",              "technic:copper_dust 2",       "technic:zinc_dust"     },
	{ "technic:chernobylite_dust",         "default:sand",                "technic:uranium3_dust" },
	{ "default:dirt 4",                    "default:clay_lump 4",         "default:sand",          "default:gravel"},
}

local function uranium_dust(p)
	return "technic:uranium"..(p == 7 and "" or p).."_dust"
end
for p = 1, 34 do
	table.insert(recipes, { uranium_dust(p).." 2", uranium_dust(p-1), uranium_dust(p+1) })
end


for _, data in pairs(recipes) do
	technic.register_separating_recipe({ input = { data[1] }, output = { data[2], data[3], data[4] } })
end
