-- Adds sheetmetal to the game, using the plates defined in items.lua.  Entirely a block, they just kind of...exist
local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_node(":technic:wrought_iron_sheetmetal", {
	description = S("Wrought Iron Sheetmetal Block"),
	tiles = {"technic_wrought_iron_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:copper_sheetmetal", {
	description = S("Copper Sheetmetal Block"),
	tiles = {"technic_copper_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:gold_sheetmetal", {
	description = S("Gold Sheetmetal Block"),
	tiles = {"technic_gold_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:bronze_sheetmetal", {
	description = S("Bronze Sheetmetal Block"),
	tiles = {"technic_bronze_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:tin_sheetmetal", {
	description = S("Tin Sheetmetal Block"),
	tiles = {"technic_tin_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:brass_sheetmetal", {
	description = S("Brass Sheetmetal Block"),
	tiles = {"technic_brass_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:steel_sheetmetal", {
	description = S("Steel Sheetmetal Block"),
	tiles = {"technic_steel_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:cast_iron_sheetmetal", {
	description = S("Cast Iron Sheetmetal Block"),
	tiles = {"technic_cast_iron_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:chromium_sheetmetal", {
	description = S("Chromium Sheetmetal Block"),
	tiles = {"technic_chromium_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:lead_sheetmetal", {
	description = S("Lead Sheetmetal Block"),
	tiles = {"technic_lead_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:stainless_steel_sheetmetal", {
	description = S("Stainless Steel Sheetmetal Block"),
	tiles = {"technic_stainless_steel_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:uranium_sheetmetal", {
	description = S("Uranium Sheetmetal Block\nNot radioactive.  Safe for building."),
	tiles = {"technic_uranium_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node(":technic:zinc_sheetmetal", {
	description = S("Zinc Sheetmetal Block"),
	tiles = {"technic_zinc_sheetmetal.png"},
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

if minetest.get_modpath("moreores") then
	minetest.register_node(":technic:mithril_sheetmetal", {
		description = S("Mithril Sheetmetal Block"),
		tiles = {"technic_mithril_sheetmetal.png"},
		groups = {cracky=2},
		sounds = default.node_sound_metal_defaults(),
	})
end

if minetest.get_modpath("moreores") then
	minetest.register_node(":technic:silver_sheetmetal", {
		description = S("Silver Sheetmetal Block"),
		tiles = {"technic_silver_sheetmetal.png"},
		groups = {cracky=2},
		sounds = default.node_sound_metal_defaults(),
	})
end

minetest.register_craft({
	output = 'technic:bronze_sheetmetal 4',
	recipe = {
		{'','technic:bronze_plate',''},
		{'technic:bronze_plate','','technic:bronze_plate'},
		{'','technic:bronze_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:wrought_iron_sheetmetal 4',
	recipe = {
		{'','technic:wrought_iron_plate',''},
		{'technic:wrought_iron_plate','','technic:wrought_iron_plate'},
		{'','technic:wrought_iron_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:copper_sheetmetal 4',
	recipe = {
		{'','technic:light_copper_plate',''},
		{'technic:light_copper_plate','','technic:light_copper_plate'},
		{'','technic:light_copper_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:gold_sheetmetal 4',
	recipe = {
		{'','technic:gold_plate',''},
		{'technic:gold_plate','','technic:gold_plate'},
		{'','technic:gold_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:tin_sheetmetal 4',
	recipe = {
		{'','technic:tin_plate',''},
		{'technic:tin_plate','','technic:tin_plate'},
		{'','technic:tin_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:brass_sheetmetal 4',
	recipe = {
		{'','technic:brass_plate',''},
		{'technic:brass_plate','','technic:brass_plate'},
		{'','technic:brass_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:steel_sheetmetal 4',
	recipe = {
		{'','technic:steel_plate',''},
		{'technic:steel_plate','','technic:steel_plate'},
		{'','technic:steel_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:cast_iron_sheetmetal 4',
	recipe = {
		{'','technic:cast_iron_plate',''},
		{'technic:cast_iron_plate','','technic:cast_iron_plate'},
		{'','technic:cast_iron_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:chromium_sheetmetal 4',
	recipe = {
		{'','technic:chromium_plate',''},
		{'technic:chromium_plate','','technic:chromium_plate'},
		{'','technic:chromium_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:lead_sheetmetal 4',
	recipe = {
		{'','technic:lead_plate',''},
		{'technic:lead_plate','','technic:lead_plate'},
		{'','technic:lead_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:stainless_steel_sheetmetal 4',
	recipe = {
		{'','technic:stainless_steel_plate',''},
		{'technic:stainless_steel_plate','','technic:stainless_steel_plate'},
		{'','technic:stainless_steel_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:uranium_sheetmetal 4',
	recipe = {
		{'','technic:uranium_plate',''},
		{'technic:uranium_plate','','technic:uranium_plate'},
		{'','technic:uranium_plate',''},
	}
})

minetest.register_craft({
	output = 'technic:zinc_sheetmetal 4',
	recipe = {
		{'','technic:zinc_plate',''},
		{'technic:zinc_plate','','technic:zinc_plate'},
		{'','technic:zinc_plate',''},
	}
})

if minetest.get_modpath("moreores") then
	minetest.register_craft({
		output = 'technic:mithril_sheetmetal 4',
		recipe = {
			{'','technic:mithril_plate',''},
			{'technic:mithril_plate','','technic:mithril_plate'},
			{'','technic:mithril_plate',''},
		}
	})

	minetest.register_craft({
		output = 'technic:silver_sheetmetal 4',
		recipe = {
			{'','technic:silver_plate',''},
			{'technic:silver_plate','','technic:silver_plate'},
			{'','technic:silver_plate',''},
		}
	})
end






