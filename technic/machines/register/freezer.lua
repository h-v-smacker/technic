local S = technic.getter

function technic.register_freezer(data)
	data.typename = "ifreezing"
	data.machine_name = "freezer"
	data.machine_desc = S("%s Freezer")
	technic.register_base_machine(data)
end
