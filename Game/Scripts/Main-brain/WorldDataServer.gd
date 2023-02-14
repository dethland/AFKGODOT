extends Node
class_name WorldDataServer

var container
var resources = {}

func get_resource_container():
	container = ResourceDataContainer.new()
	resources = container.getResourceContainer()
	
func get_all_world_data():
	return resources
	
func get_world_data_by_type(resource_type: String):
	return resources[resource_type]
	
