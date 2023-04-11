extends Object
class_name ResourceDataContainer

var data_array = [] # not sure where to use
var resources = {}

func get_all_resource_data():
	return resources

func get_resource_data_by_name(str_value):
	var resource_name = str_value
	if resource_name in resources:
		return resources[resource_name]
	return null
		
func has_enough_resource(check_list):
	if check_list.is_empty():
		return false
	for item in check_list:
		var item_name = item[0]
		var item_amount = item[1]
		if not get_resource_data_by_name(item_name) is ResourceData:
			return false
		if not item_amount <= get_resource_data_by_name(item_name).get_amount():
			return false
	return true

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
	
func get_resource_data_container():
	return resources
	
func combine_resource_data(data: ResourceData):
	var data_elements = data.get_elements()
	for resource in resources:
		if resource.get_name() == data.get_name():
			for element in data_elements:
				if element in resource.get_keys():
					resource.add_quantity_element(element, data_elements[element])
				else:
					resource.add_element(element, data_elements[element])
					
func subtract_resource_element_quantity(item_name, amount):
	resources[item_name].sub_amount(amount)
	
## help you debug what's inside the container, print all data
func beautiful_debug():
	for data_key in resources.keys():
		if resources[data_key] is ResourceData:
			print(resources[data_key].get_name() + " : " + str(resources[data_key].get_element("amount")))


