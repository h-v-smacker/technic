local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

-- Cotton seed oil: fuel and fertilizer

if minetest.get_modpath("farming") then
	if minetest.get_modpath("bonemeal") then
		minetest.register_craftitem(":technic:cottonseed_oil", {
			description = S("Cottonseed Oil Fertilizer"),
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
