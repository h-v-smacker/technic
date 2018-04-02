-- aspirin

-- makes any sence only when there is hunger as a separate status of the player
-- also it uses willow twigs - ethereal dependency
-- A bottle of aspirin pills heals the player immediately.

local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

if minetest.get_modpath("hunger") and minetest.get_modpath("ethereal") then

	minetest.register_craftitem(":technic:aspirin_pill", {
		description = S("Aspirin pill"),
		inventory_image = "technic_aspirin_pill.png",
		on_use = function(itemstack, user, pointed_thing)
			user:set_hp(user:get_hp() + 2)
			itemstack:take_item()
			return itemstack
		end
	})

	minetest.register_craftitem(":technic:aspirin_bottle", {
		description = S("Aspirin pills"),
		inventory_image = "technic_aspirin_bottle.png",
		on_use = function(itemstack, user, pointed_thing)
			user:set_hp(20)
			itemstack:take_item()
			return itemstack
		end
	})

	minetest.register_craft({
			type = "shapeless",
			output = "technic:aspirin_bottle",
			recipe = {"technic:aspirin_pill", "technic:aspirin_pill", 
				"technic:aspirin_pill", "technic:aspirin_pill",
				"technic:aspirin_pill", "technic:aspirin_pill", 
				"technic:aspirin_pill", "vessels:glass_bottle"}
		})

end

