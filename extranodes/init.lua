-- Minetest 0.4.6 mod: extranodes
-- namespace: technic
-- Boilerplate to support localized strings if intllib mod is installed.
local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end


local path = string.gsub(technic.modpath, "technic"..technic.pathsep.."technic", "technic"..technic.pathsep.."extranodes")
local path = path .. technic.pathsep

-----------------------------------------------------------------------------------------
--                           Introducing Extra Stuff
-----------------------------------------------------------------------------------------
dofile(path.."aspirin.lua")
dofile(path.."trampoline.lua")
dofile(path.."extratubes.lua")
dofile(path.."extramesecons.lua")
dofile(path.."lox.lua")
dofile(path.."plastic_block.lua")
dofile(path.."diamonds.lua")
dofile(path.."insulator_clips.lua")
dofile(path.."cottonseed_oil.lua")
dofile(path.."radiation_sign.lua")
dofile(path.."planting_block.lua")
dofile(path.."sheetmetal.lua")

if minetest.get_modpath("ethereal") and minetest.get_modpath("flowers") then
	dofile(path.."antishroom.lua")
end


-----------------------------------------------------------------------------------------
--                           Compatibility Stuff and Co
-----------------------------------------------------------------------------------------

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
	pkarcs.register_node("technic:marble_bricks")
	pkarcs.register_node("technic:granite")
	pkarcs.register_node("moreblocks:rubber_tree_planks")
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

	stairsplus:register_all("technic", "bronze_sheetmetal", "technic:bronze_sheetmetal", {
		description=S("Bronze Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_bronze_sheetmetal.png"},
	})
	
	stairsplus:register_all("technic", "copper_sheetmetal", "technic:copper_sheetmetal", {
		description=S("Copper Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_copper_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "gold_sheetmetal", "technic:gold_sheetmetal", {
		description=S("Gold Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_gold_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "wrought_iron_sheetmetal", "technic:wrought_iron_sheetmetal", {
		description=S("Wrought Iron Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_wrought_iron_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "tin_sheetmetal", "technic:tin_sheetmetal", {
		description=S("Tin Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_tin_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "brass_sheetmetal", "technic:brass_sheetmetal", {
		description=S("Brass Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_brass_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "steel_sheetmetal", "technic:steel_sheetmetal", {
		description=S("Steel Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_steel_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "cast_iron_sheetmetal", "technic:cast_iron_sheetmetal", {
		description=S("Cast Iron Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_cast_iron_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "zinc_sheetmetal", "technic:zinc_sheetmetal", {
		description=S("Zinc Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_zinc_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "chromium_sheetmetal", "technic:chromium_sheetmetal", {
		description=S("Chromium Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_chromium_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "lead_sheetmetal", "technic:lead_sheetmetal", {
		description=S("Lead Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_lead_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "stainless_steel_sheetmetal", "technic:stainless_steel_sheetmetal", {
		description=S("Stainless Steel Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_stainless_steel_sheetmetal.png"},
	})
		stairsplus:register_all("technic", "uranium_sheetmetal", "technic:uranium_sheetmetal", {
		description=S("Uranium Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_uranium_sheetmetal.png"},
	})
	

	if minetest.get_modpath("moreores") then
		stairsplus:register_all("technic", "mithril_sheetmetal", "technic:mithril_sheetmetal", {
		description=S("Mithril Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_mithril_sheetmetal.png"},
	})
	end

	if minetest.get_modpath("moreores") then
		stairsplus:register_all("technic", "silver_sheetmetal", "technic:silver_sheetmetal", {
		description=S("Silver Sheetmetal"),
		groups={cracky=2, not_in_creative_inventory=1},
		tiles={"technic_silver_sheetmetal.png"},
	})
	end

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



