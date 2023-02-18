extends Node
class_name ResourceDataServer

var resource_ref_dic = {
	"iron_ore" : {"type":"ore","tier":1,"amount":0,"icon_path":""},
	"copper_ore" : {"type":"ore","tier":1,"amount":0,"icon_path":""}
}
	
func easy_resource_create(str_value : String, int_value : int):
	var result = ResourceData.new()
	result.set_name(str_value)
	result.add_element("amount", int_value)
	return result

func save_resource_ref_dic():
	pass

func load_resource_ref_dic():
	pass
	
	
