-- bouncy-bouncy
-- this adds two useful kinds of nodes. Two fall damage dampeners (50% and 100%)
-- and a trampoline. Unlike on the mushroom spores from ethereal, players can
-- freely jump on the dampeners.
-- The latex foam adds use to sulphur, and may be employed for something else later.

local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end


minetest.register_craftitem(":technic:latex_foam", {
	description = S("Latex Foam"),
	inventory_image = "technic_latex_foam.png",
})

minetest.register_node(":technic:fall_dampener_50", {
	description = S("Fall Dampener 50%"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0,0.5}
		},
	collision_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0,0.5}
		},
	selection_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0,0.5}
		},
	tiles = { "technic_fall_dampener_top.png", 
               "technic_fall_dampener_bottom.png", 
               "technic_fall_dampener_side.png",
               "technic_fall_dampener_side.png",
               "technic_fall_dampener_side.png",
               "technic_fall_dampener_side.png"},
	groups = {crumbly = 3, fall_damage_add_percent = -50},
	sounds = default.node_sound_dirt_defaults(),
	paramtype2 = "facedir",
})

minetest.register_node(":technic:fall_dampener_100", {
	description = S("Fall Dampener 100%"),
	drawtype = "normal",
	tiles = {"technic_fall_dampener_top.png", 
               "technic_fall_dampener_bottom.png", 
               "technic_fall_dampener_side.png",
               "technic_fall_dampener_side.png",
               "technic_fall_dampener_side.png",
               "technic_fall_dampener_side.png"},
	groups = {crumbly = 3, fall_damage_add_percent = -100},
	sounds = default.node_sound_dirt_defaults(),
	paramtype2 = "facedir",
})

minetest.register_node(":technic:trampoline", {
	description = S("Trampoline"),
	drawtype = "normal",
	tiles = {"technic_trampoline_top.png", 
		"technic_fall_dampener_bottom.png", -- cost cuts
		"technic_trampoline_side.png",
		"technic_trampoline_side.png",
		"technic_trampoline_side.png",
		"technic_trampoline_side.png"},
	groups = {crumbly = 3, bouncy = 100, fall_damage_add_percent = -100},
	sounds = {footstep = {name = "trampoline_boing", gain = 1.0}},
	paramtype2 = "facedir",
})


minetest.register_craft({
	output = "technic:fall_dampener_50",
	recipe = {
		{ "", "", ""},
		{ "technic:raw_latex", "technic:raw_latex", "technic:raw_latex"},
		{ "technic:latex_foam", "technic:latex_foam", "technic:latex_foam"},
	}
})

minetest.register_craft({
	output = "technic:fall_dampener_100",
	recipe = {
		{ "technic:raw_latex", "technic:raw_latex", "technic:raw_latex"},
		{ "technic:latex_foam", "technic:latex_foam", "technic:latex_foam"},
		{ "technic:latex_foam", "technic:latex_foam", "technic:latex_foam"},
	}
})

minetest.register_craft({
	output = "technic:trampoline",
	recipe = {
		{ "dye:green", "dye:green", "dye:green"},
		{ "technic:rubber", "technic:rubber", "technic:rubber"},
		{ "technic:rubber", "technic:rubber", "technic:rubber"},
	}
})


