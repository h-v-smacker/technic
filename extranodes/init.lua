-- Minetest 0.4.6 mod: extranodes
-- namespace: technic
-- Boilerplate to support localized strings if intllib mod is installed.
local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

-- some extras to the extras
local path = string.gsub(technic.modpath, "technic/technic", "technic/extranodes")
dofile(path.."/aspirin.lua")
dofile(path.."/trampoline.lua")
dofile(path.."/extratubes.lua")
dofile(path.."/extramesecons.lua")
dofile(path.."/lox.lua")
dofile(path.."/plastic_block.lua")

if minetest.get_modpath("ethereal") and minetest.get_modpath("flowers") then
	dofile(path.."/antishroom.lua")
end

if minetest.get_modpath("bakedclay") then
	-- bring back them sticks
	minetest.register_craft( {
		type = "shapeless",
		output = "default:stick",
		recipe = {"default:dry_shrub"}
	})
end

-- register procedurally-generated arcs
if minetest.get_modpath("pkarcs") then
	pkarcs.register_node("technic:marble")
	pkarcs.register_node("technic:granite")
end

if minetest.get_modpath("moreblocks") then

	-- register stairsplus/circular_saw nodes
	-- we skip blast resistant concrete and uranium intentionally
	-- chrome seems to be too hard of a metal to be actually sawable

	stairsplus:register_all("technic", "marble", "technic:marble", {
		description=S("Marble"),
		groups={cracky=3, not_in_creative_inventory=1},
		tiles={"technic_marble.png"},
	})

	stairsplus:register_all("technic", "marble_bricks", "technic:marble_bricks", {
		description=S("Marble Bricks"),
		groups={cracky=3, not_in_creative_inventory=1},
		tiles={"technic_marble_bricks.png"},
	})

	stairsplus:register_all("technic", "granite", "technic:granite", {
		description=S("Granite"),
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"technic_granite.png"},
	})

	stairsplus:register_all("technic", "concrete", "technic:concrete", {
		description=S("Concrete"),
		groups={cracky=3, not_in_creative_inventory=1},
		tiles={"technic_concrete_block.png"},
	})

	stairsplus:register_all("technic", "zinc_block", "technic:zinc_block", {
		description=S("Zinc Block"),
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"technic_zinc_block.png"},
	})

	stairsplus:register_all("technic", "cast_iron_block", "technic:cast_iron_block", {
		description=S("Cast Iron Block"),
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"technic_cast_iron_block.png"},
	})

	stairsplus:register_all("technic", "carbon_steel_block", "technic:carbon_steel_block", {
		description=S("Carbon Steel Block"),
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"technic_carbon_steel_block.png"},
	})

	stairsplus:register_all("technic", "stainless_steel_block", "technic:stainless_steel_block", {
		description=S("Stainless Steel Block"),
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"technic_stainless_steel_block.png"},
	})

	stairsplus:register_all("technic", "brass_block", "technic:brass_block", {
		description=S("Brass Block"),
		groups={cracky=1, not_in_creative_inventory=1},
		tiles={"technic_brass_block.png"},
	})

	function register_technic_stairs_alias(modname, origname, newmod, newname)
		minetest.register_alias(modname .. ":slab_" .. origname, newmod..":slab_" .. newname)
		minetest.register_alias(modname .. ":slab_" .. origname .. "_inverted", newmod..":slab_" .. newname .. "_inverted")
		minetest.register_alias(modname .. ":slab_" .. origname .. "_wall", newmod..":slab_" .. newname .. "_wall")
		minetest.register_alias(modname .. ":slab_" .. origname .. "_quarter", newmod..":slab_" .. newname .. "_quarter")
		minetest.register_alias(modname .. ":slab_" .. origname .. "_quarter_inverted", newmod..":slab_" .. newname .. "_quarter_inverted")
		minetest.register_alias(modname .. ":slab_" .. origname .. "_quarter_wall", newmod..":slab_" .. newname .. "_quarter_wall")
		minetest.register_alias(modname .. ":slab_" .. origname .. "_three_quarter", newmod..":slab_" .. newname .. "_three_quarter")
		minetest.register_alias(modname .. ":slab_" .. origname .. "_three_quarter_inverted", newmod..":slab_" .. newname .. "_three_quarter_inverted")
		minetest.register_alias(modname .. ":slab_" .. origname .. "_three_quarter_wall", newmod..":slab_" .. newname .. "_three_quarter_wall")
		minetest.register_alias(modname .. ":stair_" .. origname, newmod..":stair_" .. newname)
		minetest.register_alias(modname .. ":stair_" .. origname .. "_inverted", newmod..":stair_" .. newname .. "_inverted")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_wall", newmod..":stair_" .. newname .. "_wall")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_wall_half", newmod..":stair_" .. newname .. "_wall_half")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_wall_half_inverted", newmod..":stair_" .. newname .. "_wall_half_inverted")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_half", newmod..":stair_" .. newname .. "_half")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_half_inverted", newmod..":stair_" .. newname .. "_half_inverted")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_right_half", newmod..":stair_" .. newname .. "_right_half")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_right_half_inverted", newmod..":stair_" .. newname .. "_right_half_inverted")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_wall_half", newmod..":stair_" .. newname .. "_wall_half")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_wall_half_inverted", newmod..":stair_" .. newname .. "_wall_half_inverted")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_inner", newmod..":stair_" .. newname .. "_inner")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_inner_inverted", newmod..":stair_" .. newname .. "_inner_inverted")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_outer", newmod..":stair_" .. newname .. "_outer")
		minetest.register_alias(modname .. ":stair_" .. origname .. "_outer_inverted", newmod..":stair_" .. newname .. "_outer_inverted")
		minetest.register_alias(modname .. ":panel_" .. origname .. "_bottom", newmod..":panel_" .. newname .. "_bottom")
		minetest.register_alias(modname .. ":panel_" .. origname .. "_top", newmod..":panel_" .. newname .. "_top")
		minetest.register_alias(modname .. ":panel_" .. origname .. "_vertical", newmod..":panel_" .. newname .. "_vertical")
		minetest.register_alias(modname .. ":micro_" .. origname .. "_bottom", newmod..":micro_" .. newname .. "_bottom")
		minetest.register_alias(modname .. ":micro_" .. origname .. "_top", newmod..":micro_" .. newname .. "_top")
	end 

	register_technic_stairs_alias("stairsplus", "concrete", "technic", "concrete")
	register_technic_stairs_alias("stairsplus", "marble", "technic", "marble")
	register_technic_stairs_alias("stairsplus", "granite", "technic", "granite")
	register_technic_stairs_alias("stairsplus", "marble_bricks", "technic", "marble_bricks")

end

local iclip_def = {
	description = "Insulator/cable clip",
	drawtype = "mesh",
	mesh = "technic_insulator_clip.obj",
	tiles = {"technic_insulator_clip.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1 },
	sounds = default.node_sound_stone_defaults(),
}

local iclipfence_def = {
	description = "Insulator/cable clip",
	tiles = {"technic_insulator_clip.png"},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {
			{ -0.25,   0.75,   -0.25,   0.25,   1.25,   0.25   }, -- the clip on top
			{ -0.125, 0.6875, -0.125, 0.125, 0.75,   0.125 },
			{ -0.1875,  0.625,  -0.1875,  0.1875,  0.6875, 0.1875  },
			{ -0.125, 0.5625, -0.125, 0.125, 0.625,  0.125 },
			{ -0.1875,  0.5,    -0.1875,  0.1875,  0.5625, 0.1875  },
			{ -0.125, 0.4375, -0.125, 0.125, 0.5,    0.125 },
			{ -0.1875,  0.375,  -0.1875,  0.1875,  0.4375, 0.1875  },
			{ -0.125, -0.5,    -0.125,  0.125,  0.375,  0.125  }, -- the post, slightly short
		},
		-- connect_top =
		-- connect_bottom =
		connect_front = {{-1/16,3/16,-1/2,1/16,5/16,-1/8},
			{-1/16,-5/16,-1/2,1/16,-3/16,-1/8}},
		connect_left = {{-1/2,3/16,-1/16,-1/8,5/16,1/16},
			{-1/2,-5/16,-1/16,-1/8,-3/16,1/16}},
		connect_back = {{-1/16,3/16,1/8,1/16,5/16,1/2},
			{-1/16,-5/16,1/8,1/16,-3/16,1/2}},
		connect_right = {{1/8,3/16,-1/16,1/2,5/16,1/16},
			{1/8,-5/16,-1/16,1/2,-3/16,1/16}},
	},
	connects_to = {"group:fence", "group:wood", "group:tree"},
	groups = {fence=1, choppy=1, snappy=1, oddly_breakable_by_hand=1 },
	sounds = default.node_sound_stone_defaults(),
}

if minetest.get_modpath("unifieddyes") then
	iclip_def.paramtype2 = "colorwallmounted"
	iclip_def.palette = "unifieddyes_palette_colorwallmounted.png"
	iclip_def.after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)
	end
	iclip_def.after_dig_node = unifieddyes.after_dig_node
	iclip_def.groups = {choppy=1, snappy=1, oddly_breakable_by_hand=1, ud_param2_colorable = 1}

	iclipfence_def.paramtype2 = "color"
	iclipfence_def.palette = "unifieddyes_palette_extended.png"
	iclipfence_def.on_construct = unifieddyes.on_construct
	iclipfence_def.after_place_node = unifieddyes.recolor_on_place
	iclipfence_def.after_dig_node = unifieddyes.after_dig_node
	iclipfence_def.groups = {fence=1, choppy=1, snappy=1, oddly_breakable_by_hand=1, ud_param2_colorable = 1}
	iclipfence_def.place_param2 = 171 -- medium amber, low saturation, closest color to default:wood
end

minetest.register_node(":technic:insulator_clip", iclip_def)
minetest.register_node(":technic:insulator_clip_fencepost", iclipfence_def)

minetest.register_craft({
	output = "technic:insulator_clip",
	recipe = {
		{ "", "dye:white", ""},
		{ "", "technic:raw_latex", ""},
		{ "technic:raw_latex", "default:stone", "technic:raw_latex"},
	}
})

minetest.register_craft({
	output = "technic:insulator_clip_fencepost 2",
	recipe = {
		{ "", "dye:white", ""},
		{ "", "technic:raw_latex", ""},
		{ "technic:raw_latex", "default:fence_wood", "technic:raw_latex"},
	}
})

-- Artificial diamonds

minetest.register_craftitem(":technic:diamond_seed", {
	description = S("Diamond Seed"),
	inventory_image = "technic_diamond_seed.png",
})

minetest.register_craft({
	type = "cooking",
	output = "technic:diamond_seed",
	recipe = "technic:graphite"
})

-- Cotton seed oil: fuel and fertilizer

if minetest.get_modpath("farming") then
	if minetest.get_modpath("bonemeal") then
		minetest.register_craftitem(":technic:cottonseed_oil", {
			description = S("Cottonseed Oil"),
			inventory_image = "technic_cottonseed_oil.png",
			on_use = function(itemstack, user, pointed_thing)
				if pointed_thing.type ~= "node" then
					return
				end
				if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
					return
				end
				if not is_creative(user:get_player_name()) then
					itemstack:take_item()
				end
				bonemeal:on_use(pointed_thing.under, 4)
				return itemstack
			end,
		})
	else
		minetest.register_craftitem(":technic:cottonseed_oil", {
			description = S("Cottonseed Oil"),
			inventory_image = "technic_cottonseed_oil.png",
		})
	end

	minetest.register_craft({
		type = "fuel",
		recipe = "technic:cottonseed_oil",
		burntime = 20,
	})

end


-- -- Additional recipe for straw blocks out of straw mat from cottages (if present)
-- -- not to let the centifuge output go to waste, since farming:straw can be used with a saw...
-- 
-- if minetest.get_modpath("cottages") and minetest.get_modpath("farming") then
-- 	minetest.register_craft({
-- 		output = "farming:straw 2",
-- 		recipe = {
-- 			{ "cottages:straw_mat", "cottages:straw_mat", "cottages:straw_mat" },
-- 			{ "cottages:straw_mat", "cottages:straw_mat", "cottages:straw_mat" },
-- 			{ "cottages:straw_mat", "cottages:straw_mat", "cottages:straw_mat" },
-- 		}
-- 	})
-- end


