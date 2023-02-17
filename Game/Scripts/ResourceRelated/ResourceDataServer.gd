extends Node
class_name ResourceDataServer
	
func easy_resource_create(str_value : String, int_value : int):
	var result = ResourceData.new()
	result.set__name(str_value)
	result.add_element("amount", int_value)
	return result
