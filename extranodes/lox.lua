-- An small arsenal of tools to battle the lava craters


local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local freezing_rules = {
	["default:water_source"] = "default:ice",
	["default:water_flowing"] = "default:snowblock",
	["default:river_water_source"] = "default:ice",
	["default:river_water_flowing"] = "default:snowblock",
	["default:lava_source"] = "default:obsidian",
	["default:lava_flowing"] = "default:stone",
	["fire:basic_flame"] = "air",
	["default:dirt"] = "default:dirt_with_snow",
	["ethereal:fiery_dirt"] = "default:dirt_with_snow",
	["ethereal:mushroom_dirt"] = "default:dirt_with_snow",
}

local function freeze(user, pos, radius, itemstack)

	-- itemstack is true if the function is used in a tool callback
	-- if so, user is a playerref
	-- if itemstack is false, it's a node using the function, and the
	-- user name is plain text string
	
	if (itemstack) then

		if minetest.is_protected(pos, user:get_player_name()) then
			minetest.record_protection_violation(pos, user:get_player_name())
			return
		end
	
	else
		if minetest.is_protected(pos, user) then
			minetest.record_protection_violation(pos, user)
			return
		end
	end
	
	local loc = {}
	local wrk = false
	-- R = 2,  d = 3
	-- R = 10, d = 5
	local depth = math.floor(0.25*radius+2.5)
	
	for y = 0,depth,1 do
		for x = -radius,radius,1 do
			for z = -radius,radius,1 do
				loc = {x = pos.x - x, y = pos.y - y, z = pos.z - z}
				if freezing_rules[minetest.get_node(loc).name] then
					wrk = true
					minetest.swap_node(loc, {name = freezing_rules[minetest.get_node(loc).name]})
				end
				if math.random(1,5) == 5 then
					if minetest.get_node({x = loc.x, y = loc.y+1, z = loc.z}).name == "air" 
						and minetest.get_node(loc).name ~= "air" 
						and minetest.get_node(loc).name ~= "stairs:slab_snowblock" then
						minetest.set_node({x = loc.x, y = loc.y+1, z = loc.z}, {name = "stairs:slab_snowblock"})
					end
				end
			end
		end
	end
	
	if wrk then
		minetest.sound_play("default_cool_lava", {gain = 1, pos = pos})
	end

	if (itemstack) then
	
		itemstack:take_item()
		local uinv = user:get_inventory()
		if uinv:room_for_item("main", "vessels:steel_bottle 1") then
			uinv:add_item("main", "vessels:steel_bottle 1")
		else 
			minetest.item_drop(ItemStack("vessels:steel_bottle 1"), user, user:getpos())
		end
		
		user:set_hp(user:get_hp() - 1)
		
		return itemstack
	else
		return true
	end

end
		
minetest.register_craftitem(":technic:lox", {
	description = S("Liquid Oxygen"),
	tiles = {"technic_lox.png"},
	inventory_image = "technic_lox.png",
	wield_image = "technic_lox.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	liquids_pointable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_defaults(),
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end
		freeze(user, pointed_thing.under, 2, itemstack)
	end
})

minetest.register_node(":technic:fbomb", {
	description = S("F-Bomb"),
	tiles = {"technic_fbomb.png"},
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 2, falling_node = 1},
	sounds = default.node_sound_defaults(),
	on_punch = function(pos, node, player, pointed_thing)
		minetest.remove_node(pos)
		minetest.place_node(pos, {name="technic:fbombact"})
		local nm =  minetest.get_meta(pos)
		nm:set_string("player", player:get_player_name())
	end
})

minetest.register_node(":technic:fbombact", {
	description = S("F-Bomb Active"),
	tiles = {"technic_fbombact.png"},
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	light_source = 3,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {falling_node = 1, cracky = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local nm =  minetest.get_meta(pos)
		local id = minetest.add_particlespawner({
			amount = 30,
			time = 0,
			minpos = pos,
			maxpos = pos,
			minvel = {x=-2, y=0, z=-2},
			maxvel = {x=2, y=0, z=2},
			minacc = {x=0, y=0, z=0},
			maxacc = {x=0.5, y=0, z=0.5},
			minexptime = 1,
			maxexptime = 5,
			minsize = 1,
			maxsize = 4,
			collisiondetection = false,
			vertical = false,
			texture = "technic_snowflake.png",
			glow = 2
		})
		nm:set_int("id", id)
		local tm = minetest.get_node_timer(pos)
		tm:start(5)
	end,
	on_timer = function(pos, elapsed)
		local nm = minetest.get_meta(pos)
		local pn = nm:get_string("player")
		freeze(pn, pos, 10)
		minetest.remove_node(pos)
		return false
	end,
	on_destruct = function(pos)
		local nm =  minetest.get_meta(pos)
		if (nm:get_int("id")) then
			minetest.delete_particlespawner(nm:get_int("id"))
		end
	end,
	drop = "technic:fbomb"

})

minetest.register_craft({
		output = "technic:fbomb 3",
		recipe = {
			{ "technic:lox", "tnt:tnt",     "technic:lox"},
			{ "tnt:tnt",     "technic:lox", "tnt:tnt"},
			{ "technic:lox", "tnt:tnt",     "technic:lox"}
		},
	})