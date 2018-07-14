local S = technic.getter

function technic.register_thresher(data)
	data.typename = "threshing"
	data.machine_name = "thresher"
	data.machine_desc = S("%s Thresher")
	technic.register_base_machine(data)
end
