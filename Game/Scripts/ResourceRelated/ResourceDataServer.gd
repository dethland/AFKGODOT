extends Node
class_name ResourceDataServer

func easy_resource_create(resource_name : String, element_name: String, element_value : int):
	var resource = ResourceData.new()
	resource.set_name(resource_name)
	resource.add_element(element_name, element_value)
	
