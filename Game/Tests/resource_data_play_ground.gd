extends Node2D

func _ready():
	var new_data = ResourceData.new()
	var new_data_bank = ResourceDataContainer.new()
	new_data.set_name("Iron")
	new_data.add_element("quantity", 10)
	new_data_bank.add_resource_data(new_data)
	for resource in new_data_bank.resources:
		print(resource)
		print(new_data_bank.resources[resource].get_all_elements())
		print(new_data_bank.resources[resource].get_element("quantity"))
		
