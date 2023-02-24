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

func stackable_add_resource_data(data : ResourceData):
	var resource_name = data.get_name()
	if resource_name in resources:
		resources[resource_name].add_amount(data.get_amount())
		return 
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
	for data_key in resources.keys():
		print(resources[data_key])
		if resources[data_key] is ResourceData:
			print(resources[data_key].get_name() + " : " + str(resources[data_key].get_element("amount")))


