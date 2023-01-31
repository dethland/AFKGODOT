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




