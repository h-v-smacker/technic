-- Configuration

local chainsaw_max_charge_mini =  15000
local chainsaw_max_charge      =  30000 -- Maximum charge of the saw
local chainsaw_max_charge_mk2  = 120000
-- Gives 2500 nodes on a single charge (about 50 complete normal trees)
local chainsaw_charge_per_node = 12
-- Cut down tree leaves.  Leaf decay may cause slowness on large trees
-- if this is disabled.
local chainsaw_leaves = true

-- The default trees
local timber_nodenames = {
	["default:acacia_tree"] = true,
	["default:aspen_tree"]  = true,
	["default:jungletree"]  = true,
	["default:papyrus"]     = true,
	["default:cactus"]      = true,
	["default:tree"]        = true,
	["default:apple"]       = true,
	["default:pine_tree"]   = true,
}

if chainsaw_leaves then
	timber_nodenames["default:acacia_leaves"] = true
	timber_nodenames["default:aspen_leaves"] = true
	timber_nodenames["default:leaves"] = true
	timber_nodenames["default:jungleleaves"] = true
	timber_nodenames["default:pine_needles"] = true
end

-- technic_worldgen defines rubber trees if moretrees isn't installed
if minetest.get_modpath("technic_worldgen") or
		minetest.get_modpath("moretrees") then
	timber_nodenames["moretrees:rubber_tree_trunk_empty"] = true
	timber_nodenames["moretrees:rubber_tree_trunk"]       = true
	if chainsaw_leaves then
		timber_nodenames["moretrees:rubber_tree_leaves"] = true
	end
end

-- Support moretrees if it is there
if minetest.get_modpath("moretrees") then
	timber_nodenames["moretrees:acacia_trunk"]                = true
	timber_nodenames["moretrees:apple_tree_trunk"]                 = true
	timber_nodenames["moretrees:beech_trunk"]                      = true
	timber_nodenames["moretrees:birch_trunk"]                      = true
	timber_nodenames["moretrees:fir_trunk"]                        = true
	timber_nodenames["moretrees:oak_trunk"]                        = true
	timber_nodenames["moretrees:palm_trunk"]                       = true
	timber_nodenames["moretrees:pine_trunk"]                       = true
	timber_nodenames["moretrees:sequoia_trunk"]                    = true
	timber_nodenames["moretrees:spruce_trunk"]                     = true
	timber_nodenames["moretrees:willow_trunk"]                     = true
	timber_nodenames["moretrees:jungletree_trunk"]                 = true

	if chainsaw_leaves then
		timber_nodenames["moretrees:acacia_leaves"]            = true
		timber_nodenames["moretrees:apple_tree_leaves"]        = true
		timber_nodenames["moretrees:oak_leaves"]               = true
		timber_nodenames["moretrees:fir_leaves"]               = true
		timber_nodenames["moretrees:fir_leaves_bright"]        = true
		timber_nodenames["moretrees:sequoia_leaves"]           = true
		timber_nodenames["moretrees:birch_leaves"]             = true
		timber_nodenames["moretrees:birch_leaves"]             = true
		timber_nodenames["moretrees:palm_leaves"]              = true
		timber_nodenames["moretrees:spruce_leaves"]            = true
		timber_nodenames["moretrees:spruce_leaves"]            = true
		timber_nodenames["moretrees:pine_leaves"]              = true
		timber_nodenames["moretrees:willow_leaves"]            = true
		timber_nodenames["moretrees:jungletree_leaves_green"]  = true
		timber_nodenames["moretrees:jungletree_leaves_yellow"] = true
		timber_nodenames["moretrees:jungletree_leaves_red"]    = true
		timber_nodenames["moretrees:acorn"]                    = true
		timber_nodenames["moretrees:coconut"]                  = true
		timber_nodenames["moretrees:spruce_cone"]              = true
		timber_nodenames["moretrees:pine_cone"]                = true
		timber_nodenames["moretrees:fir_cone"]                 = true
		timber_nodenames["moretrees:apple_blossoms"]           = true
	end
end

-- Support growing_trees
if minetest.get_modpath("growing_trees") then
	timber_nodenames["growing_trees:trunk"]         = true
	timber_nodenames["growing_trees:medium_trunk"]  = true
	timber_nodenames["growing_trees:big_trunk"]     = true
	timber_nodenames["growing_trees:trunk_top"]     = true
	timber_nodenames["growing_trees:trunk_sprout"]  = true
	timber_nodenames["growing_trees:branch_sprout"] = true
	timber_nodenames["growing_trees:branch"]        = true
	timber_nodenames["growing_trees:branch_xmzm"]   = true
	timber_nodenames["growing_trees:branch_xpzm"]   = true
	timber_nodenames["growing_trees:branch_xmzp"]   = true
	timber_nodenames["growing_trees:branch_xpzp"]   = true
	timber_nodenames["growing_trees:branch_zz"]     = true
	timber_nodenames["growing_trees:branch_xx"]     = true

	if chainsaw_leaves then
		timber_nodenames["growing_trees:leaves"] = true
	end
end

-- Support growing_cactus
if minetest.get_modpath("growing_cactus") then
	timber_nodenames["growing_cactus:sprout"]                       = true
	timber_nodenames["growing_cactus:branch_sprout_vertical"]       = true
	timber_nodenames["growing_cactus:branch_sprout_vertical_fixed"] = true
	timber_nodenames["growing_cactus:branch_sprout_xp"]             = true
	timber_nodenames["growing_cactus:branch_sprout_xm"]             = true
	timber_nodenames["growing_cactus:branch_sprout_zp"]             = true
	timber_nodenames["growing_cactus:branch_sprout_zm"]             = true
	timber_nodenames["growing_cactus:trunk"]                        = true
	timber_nodenames["growing_cactus:branch_trunk"]                 = true
	timber_nodenames["growing_cactus:branch"]                       = true
	timber_nodenames["growing_cactus:branch_xp"]                    = true
	timber_nodenames["growing_cactus:branch_xm"]                    = true
	timber_nodenames["growing_cactus:branch_zp"]                    = true
	timber_nodenames["growing_cactus:branch_zm"]                    = true
	timber_nodenames["growing_cactus:branch_zz"]                    = true
	timber_nodenames["growing_cactus:branch_xx"]                    = true
end

-- Support ethereal
if minetest.get_modpath("ethereal") then
	timber_nodenames["ethereal:willow_trunk"]          = true
	timber_nodenames["ethereal:redwood_trunk"]         = true
	timber_nodenames["ethereal:frost_tree"]            = true
	timber_nodenames["ethereal:yellow_trunk"]          = true
	timber_nodenames["ethereal:birch_trunk"]           = true
	timber_nodenames["ethereal:palm_trunk"]            = true
	timber_nodenames["ethereal:banana_trunk"]          = true
	timber_nodenames["ethereal:bamboo"]                = true
	timber_nodenames["ethereal:mushroom_trunk"]        = true
	timber_nodenames["ethereal:scorched_tree"]         = true
	timber_nodenames["ethereal:sakura_trunk"]	         = true
		
	if chainsaw_leaves then
		timber_nodenames["ethereal:willow_twig"]        = true
		timber_nodenames["ethereal:redwood_leaves"]     = true
		timber_nodenames["ethereal:frost_leaves"]       = true
		timber_nodenames["ethereal:yellowleaves"]       = true
		timber_nodenames["ethereal:birch_leaves"]       = true
		timber_nodenames["ethereal:palmleaves"]         = true
		timber_nodenames["ethereal:bananaleaves"]       = true
		timber_nodenames["ethereal:bamboo_leaves"]      = true
		timber_nodenames["ethereal:mushroom"]           = true
		timber_nodenames["ethereal:mushroom_pore"]      = true
		timber_nodenames["ethereal:orange_leaves"]      = true
		timber_nodenames["ethereal:sakura_leaves"]      = true
		timber_nodenames["ethereal:sakura_leaves2"]     = true
		-- fruits
		timber_nodenames["ethereal:banana"]        = true
		timber_nodenames["ethereal:orange"]        = true
		timber_nodenames["ethereal:coconut"]       = true
		timber_nodenames["ethereal:golden_apple"]  = true
		-- extra
		timber_nodenames["ethereal:vine"]  = true
	end
end

-- Support maple
if minetest.get_modpath("maple") then
	timber_nodenames["maple:maple_tree"]         = true
	if chainsaw_leaves then
		timber_nodenames["maple:maple_leaves"] = true
	end
end

-- Support farming_plus
if minetest.get_modpath("farming_plus") then
	if chainsaw_leaves then
		timber_nodenames["farming_plus:banana_leaves"] = true
		timber_nodenames["farming_plus:banana"]        = true
		timber_nodenames["farming_plus:cocoa_leaves"]  = true
		timber_nodenames["farming_plus:cocoa"]         = true
	end
end

-- Support nature
if minetest.get_modpath("nature") then
	if chainsaw_leaves then
		timber_nodenames["nature:blossom"] = true
	end
end

-- Support snow
if minetest.get_modpath("snow") then
	if chainsaw_leaves then
		timber_nodenames["snow:needles"] = true
		timber_nodenames["snow:needles_decorated"] = true
		timber_nodenames["snow:star"] = true
	end
end

-- Support vines (also generated by moretrees if available)
if minetest.get_modpath("vines") then
	if chainsaw_leaves then
		timber_nodenames["vines:vines"] = true
	end
end

if minetest.get_modpath("trunks") then
	if chainsaw_leaves then
		timber_nodenames["trunks:moss"] = true
		timber_nodenames["trunks:moss_fungus"] = true
		timber_nodenames["trunks:treeroot"] = true
	end
end

local S = technic.getter

technic.register_power_tool("technic:chainsaw_mini", chainsaw_max_charge_mini)
technic.register_power_tool("technic:chainsaw", chainsaw_max_charge)
technic.register_power_tool("technic:chainsaw_mk2", chainsaw_max_charge_mk2)

-- Table for saving what was sawed down
local produced = {}

-- Save the items sawed down so that we can drop them in a nice single stack
local function handle_drops(drops)
	for _, item in ipairs(drops) do
		local stack = ItemStack(item)
		local name = stack:get_name()
		local p = produced[name]
		if not p then
			produced[name] = stack
		else
			p:set_count(p:get_count() + stack:get_count())
		end
	end
end

--- Iterator over positions to try to saw around a sawed node.
-- This returns positions in a 3x1x3 area around the position, plus the
-- position above it.  This does not return the bottom position to prevent
-- the chainsaw from cutting down nodes below the cutting position.
-- @param pos Sawing position.
local function iterSawTries(pos)
	-- Copy position to prevent mangling it
	local pos = vector.new(pos)
	local i = 0

	return function()
		i = i + 1
		-- Given a (top view) area like so (where 5 is the starting position):
		-- X -->
		-- Z 123
		-- | 456
		-- V 789
		-- This will return positions 1, 4, 7, 2, 8 (skip 5), 3, 6, 9,
		-- and the position above 5.
		if i == 1 then
			-- Move to starting position
			pos.x = pos.x - 1
			pos.z = pos.z - 1
		elseif i == 4 or i == 7 then
			-- Move to next X and back to start of Z when we reach
			-- the end of a Z line.
			pos.x = pos.x + 1
			pos.z = pos.z - 2
		elseif i == 5 then
			-- Skip the middle position (we've already run on it)
			-- and double-increment the counter.
			pos.z = pos.z + 2
			i = i + 1
		elseif i <= 9 then
			-- Go to next Z.
			pos.z = pos.z + 1
		elseif i == 10 then
			-- Move back to center and up.
			-- The Y+ position must be last so that we don't dig
			-- straight upward and not come down (since the Y-
			-- position isn't checked).
			pos.x = pos.x - 1
			pos.z = pos.z - 1
			pos.y = pos.y + 1
		else
			return nil
		end
		return pos
	end
end



local function iterSawTries_mk2(pos)
	-- Copy position to prevent mangling it
	local pos = vector.new(pos)
	local i = 0

	return function()
		i = i + 1
		-- Given a (top view) area like so (where 5 is the starting position):
		-- X -->
		-- Z 1  2  3  4  5
		-- | 6  7  8  9  10
		-- | 11 12 13 14 15
		-- | 16 17 18 19 20
		-- V 21 22 23 24 25
		-- This will return positions 1...21, 2..,22, 3...23 (skip 13), 4...24, 5...25
		-- and the position above 13.
		if i == 1 then
			-- Move to starting position
			pos.x = pos.x - 2
			pos.z = pos.z - 2
		elseif i == 6 or i == 11 or i == 16 or i == 21 then
			-- Move to next X and back to start of Z when we reach
			-- the end of a Z line.
			pos.x = pos.x + 1
			pos.z = pos.z - 4
		elseif i == 13 then
			-- Skip the middle position (we've already run on it)
			-- and double-increment the counter.
			pos.z = pos.z + 2
			i = i + 1
		elseif i <= 25 then
			-- Go to next Z.
			pos.z = pos.z + 1
		elseif i == 26 then
			-- Move back to center and up.
			-- The Y+ position must be last so that we don't dig
			-- straight upward and notminetest.record_protection_violation(pointed_thing.under, name) come down (since the Y-
			-- position isn't checked).
			pos.x = pos.x - 2
			pos.z = pos.z - 2
			pos.y = pos.y + 1
		else
			return nil
		end
		return pos
	end
end

-- This function does all the hard work. Recursively we dig the node at hand
-- if it is in the table and then search the surroundings for more stuff to dig.
local function recursive_dig(pos, remaining_charge, mk, username)
	if remaining_charge < chainsaw_charge_per_node then
		return remaining_charge
	end
	local node = minetest.get_node(pos)

	if not timber_nodenames[node.name] then
		return remaining_charge
	end
	
	if minetest.is_protected(pos, username) then
		return remaining_charge
	end
	
	-- Wood found - cut it
	handle_drops(minetest.get_node_drops(node.name, ""))
	minetest.remove_node(pos)
	remaining_charge = remaining_charge - chainsaw_charge_per_node

	-- Check surroundings and run recursively if any charge left
	if mk == 1 then
		for npos in iterSawTries(pos) do
			if remaining_charge < chainsaw_charge_per_node then
				break
			end
			if timber_nodenames[minetest.get_node(npos).name] then
				remaining_charge = recursive_dig(npos, remaining_charge, mk, username)
			end
		end
	elseif mk == 2 then
		for npos in iterSawTries_mk2(pos) do
			if remaining_charge < chainsaw_charge_per_node then
				break
			end
			if timber_nodenames[minetest.get_node(npos).name] then
				remaining_charge = recursive_dig(npos, remaining_charge, mk, username)
			else
				local ct = {{x=-1,z=-1},{x=-1,z=1},{x=1,z=-1},{x=1,z=1}}
				for _,c in ipairs(ct) do
					local pos_alt = vector.new(npos)
					pos_alt.x = pos_alt.x + c.x
					pos_alt.z = pos_alt.z + c.z
					pos_alt.y = pos_alt.y + 1
					if timber_nodenames[minetest.get_node(pos_alt).name] then
						remaining_charge = recursive_dig(pos_alt, remaining_charge, mk, username)
					end
				end
			end
		end
	end
	
	return remaining_charge
end

-- a non-recursive version
local function nonrecursive_dig(pos, remaining_charge, username)
	if remaining_charge < chainsaw_charge_per_node then
		return remaining_charge
	end
	local node = minetest.get_node(pos)

	if not timber_nodenames[node.name] then
		return remaining_charge
	end
	
	if minetest.is_protected(pos, username) then
		return remaining_charge
	end
	
	local start_pos = {
		x = pos.x - 1,
		z = pos.z - 1,
		y = pos.y
	} 
	local end_pos = {
		x = pos.x + 1,
		z = pos.z + 1,
		y = pos.y + 30
	} 
	
	local positions = {}

	for x = 1,-1,-1 do
		for z = 1,-1,-1 do
			table.insert(positions, {x = x, z = z})
		end
	end
	
	local h = 40
	
	-- find where the tree ends (counting from the ground)
	for y=0,h,1 do
		local c = 0
		for _,offset in pairs(positions) do
			local p = {x = pos.x + offset.x, y = pos.y + y, z = pos.z + offset.z}
			local n = minetest.get_node(p)
			if not timber_nodenames[n.name] then
				c = c + 1
			end
		end
		if c == #positions then
-- 			minetest.chat_send_all("tree height: " .. y)
			h = y
			break
		end
	end
	
	for y=h,0,-1 do
		for _,offset in pairs(positions) do
			if remaining_charge < chainsaw_charge_per_node then
				break
			end
			local p = {x = pos.x + offset.x, y = pos.y + y, z = pos.z + offset.z}
			local n = minetest.get_node(p)
			if timber_nodenames[n.name] and not minetest.is_protected(p, username) then
				-- Wood found - cut it
				handle_drops(minetest.get_node_drops(n.name))
				minetest.remove_node(p)
				remaining_charge = remaining_charge - chainsaw_charge_per_node
			end
		end
	end
	
	return remaining_charge
end



-- Function to randomize positions for new node drops
local function get_drop_pos(pos)
	local drop_pos = {}

	for i = 0, 8 do
		-- Randomize position for a new drop
		drop_pos.x = pos.x + math.random(-3, 3)
		drop_pos.y = pos.y - 1
		drop_pos.z = pos.z + math.random(-3, 3)

		-- Move the randomized position upwards until
		-- the node is air or unloaded.
		for y = drop_pos.y, drop_pos.y + 5 do
			drop_pos.y = y
			local node = minetest.get_node_or_nil(drop_pos)

			if not node then
				-- If the node is not loaded yet simply drop
				-- the item at the original digging position.
				return pos
			elseif node.name == "air" then
				-- Add variation to the entity drop position,
				-- but don't let drops get too close to the edge
				drop_pos.x = drop_pos.x + (math.random() * 0.8) - 0.5
				drop_pos.z = drop_pos.z + (math.random() * 0.8) - 0.5
				return drop_pos
			end
		end
	end

	-- Return the original position if this takes too long
	return pos
end

-- Chainsaw entry point
local function chainsaw_dig(pos, current_charge, mk, username)
	-- Start sawing things down
	local remaining_charge
	if (mk) then
		remaining_charge = recursive_dig(pos, current_charge, mk, username)
	else
		remaining_charge = nonrecursive_dig(pos, current_charge, username)
	end
	
	minetest.sound_play("chainsaw", {pos = pos, gain = 1.0,
			max_hear_distance = 10})

	-- Now drop items for the player
	for name, stack in pairs(produced) do
		-- Drop stacks of stack max or less
		local count, max = stack:get_count(), stack:get_stack_max()
		stack:set_count(max)
		while count > max do
			minetest.add_item(get_drop_pos(pos), stack)
			count = count - max
		end
		stack:set_count(count)
		minetest.add_item(get_drop_pos(pos), stack)
	end

	-- Clean up
	produced = {}

	return remaining_charge
end


local function use_chainsaw(itemstack, user, pointed_thing, mk)
	if pointed_thing.type ~= "node" then
		return itemstack
	end

	local meta = minetest.deserialize(itemstack:get_metadata())
	if not meta or not meta.charge or
			meta.charge < chainsaw_charge_per_node then
		return
	end

	local name = user:get_player_name()
	if minetest.is_protected(pointed_thing.under, name) then
		minetest.record_protection_violation(pointed_thing.under, name)
		return
	end

	-- Send current charge to digging function so that the
	-- chainsaw will stop after digging a number of nodes
	meta.charge = chainsaw_dig(pointed_thing.under, meta.charge, mk, name)
	if not technic.creative_mode then
		if mk == 1 then
			technic.set_RE_wear(itemstack, meta.charge, chainsaw_max_charge)
		elseif mk == 2 then
			technic.set_RE_wear(itemstack, meta.charge, chainsaw_max_charge_mk2)
		else
			technic.set_RE_wear(itemstack, meta.charge, chainsaw_max_charge_mini)
		end
		itemstack:set_metadata(minetest.serialize(meta))
	end
	return itemstack
end

minetest.register_tool("technic:chainsaw", {
	description = S("Chainsaw"),
	inventory_image = "technic_chainsaw.png",
	stack_max = 1,
	groups = {technic_can = 1, technic_tool = 1, technic_powertool = 1},
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = function(itemstack, user, pointed_thing)
			use_chainsaw(itemstack, user, pointed_thing, 1)
			return(itemstack)
		end
})

minetest.register_tool("technic:chainsaw_mk2", {
	description = S("Chainsaw Mk2"),
	inventory_image = "technic_chainsaw_mk2.png",
	stack_max = 1,
	groups = {technic_can = 1, technic_tool = 1, technic_powertool = 1},
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = function(itemstack, user, pointed_thing)
			use_chainsaw(itemstack, user, pointed_thing, 2)
			return(itemstack)
		end
})

minetest.register_tool("technic:chainsaw_mini", {
	description = S("Chainsaw Mini"),
	inventory_image = "technic_chainsaw_mini.png",
	stack_max = 1,
	groups = {technic_can = 1, technic_tool = 1, technic_powertool = 1},
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
-- 	groups = {not_in_creative_inventory = 1},
	on_use = function(itemstack, user, pointed_thing)
			use_chainsaw(itemstack, user, pointed_thing, nil)
			return(itemstack)
		end
})
	
local mesecons_button = minetest.get_modpath("mesecons_button")
local trigger = mesecons_button and "mesecons_button:button_off" or "default:mese_crystal_fragment"

minetest.register_craft({
	output = "technic:chainsaw_mini",
	recipe = {
		{"technic:wrought_iron_ingot", "technic:wrought_iron_ingot", "technic:battery"},
		{"",                           "technic:motor",              trigger},
		{"",                           "",                           ""},
	}
})

minetest.register_craft({
	output = "technic:chainsaw",
	recipe = {
		{"technic:stainless_steel_ingot", trigger,         "technic:battery"},
		{"technic:fine_copper_wire",      "technic:motor", "technic:battery"},
		{"",                              "",              "technic:stainless_steel_ingot"},
	}
})

minetest.register_craft({
	output = "technic:chainsaw_mk2",
	recipe = {
		{"technic:chainsaw",             "technic:stainless_steel_ingot", "technic:stainless_steel_ingot"},
		{"technic:battery",              "technic:battery",               ""},
		{"technic:battery",              "dye:green",                     ""},
	}
})

