-- MV sawmill code, written by HubsChromeFreeze.
-- Don't be so mean to HCF, he will do great stuff one day...when he properly learns to code in lua.
-- Note from writer: This is just cloned code, it's similar to code from all other machines.

minetest.register_craft({
	output = 'technic:mv_sawmill',
	recipe = {
		{'technic:stainless_steel_ingot', 'technic:lv_sawmill', 'technic:stainless_steel_ingot'},
		{'pipeworks:tube_1',      'technic:mv_transformer',     'pipeworks:tube_1'},
		{'technic:stainless_steel_ingot',    'technic:mv_cable',           'technic:stainless_steel_ingot'},
	},
})

technic.register_sawmill({tier="MV", demand={1000,500,300}, speed=2, upgrade=1, tube=1,

tiles = {nil,nil,nil,nil,"_back",nil}})
