extends Object
class_name ResourceDataContainer

var data_array = []

func add_resource_data(data : ResourceData):
	for res in data_array:
		if res is ResourceData:
			if res.get__name() != data.get__name(): # if same resource already there
				continue
			res.add_amount(data.get_amount())
			return
			
	data_array.append(data)


func remove_resource_data_by_name(str_value):
	for res in data_array:
		if res is ResourceData:
			if res.get__name() != str_value:
				continue
			data_array.erase(res)


## help you debug what's inside the container, print all data
func beautiful_debug():
	print(data_array.size())
	for data in data_array:
		print(data)
		if data is ResourceData:
			print(data.get__name() + " : " + str(data.get_amount()))


