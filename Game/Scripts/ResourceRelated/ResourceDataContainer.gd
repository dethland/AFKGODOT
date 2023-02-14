extends Object
class_name ResourceDataContainer

var data_array = []
var resources = {}

func add_resource_data(data : ResourceData):
	var resource_name = data.get_name()
	if resource_name in resources:
		push_error("Resource already in container")
		return -1
	resources[resource_name] = data

func remove_resource_data_by_name(resource_name):
	if resource_name not in resources:
		push_error("Resource already in container")
		return -1
	resources.erase(resource_name)
	
func getResourceDataContainer():
	return resources
	


## help you debug what's inside the container, print all data
func beautiful_debug():
	print(data_array.size())
	for data in data_array:
		print(data)
		if data is ResourceData:
			print(data.get__name() + " : " + str(data.get_amount()))


