extends Node2D

func _ready():
	var new_data = ResourceData.new()
	var new_data_bank = ResourceDataContainer.new()
	new_data.set__name("iron")
	new_data.set_amount(10)
	new_data_bank.add_resource_data(new_data)
	print(new_data_bank.data_array)
