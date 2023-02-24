extends Node
class_name ResourceDataServer

var resource_ref_save_path = "res://Data/ResourceRef.txt"

var resource_ref_dic = {
	"iron_ore" : {"type":"ore","tier":1,"amount":0,"icon_path":""},
	"copper_ore" : {"type":"ore","tier":1,"amount":0,"icon_path":""}
}

func init_resource_ref_dic():
	var file_check = FileAccess.file_exists(resource_ref_save_path)
	if !file_check:
		save_resource_ref_dic()
		
	var file = FileAccess.open(resource_ref_save_path, FileAccess.READ)
	var content = file.get_var()
	
	if content != null:
		save_resource_ref_dic()
		return 
		
	resource_ref_dic =  load_resource_ref_dic()


func easy_resource_create(str_value : String, int_value : int):
	var result = ResourceData.new()
	result.set_name(str_value)
	result.add_element("amount", int_value)
	return result


func convert_check_list_by_recipe(recipe):
	var result = []
	for item_index in range(0, recipe["input"].size()):
		result.append(easy_resource_create(recipe["input"][item_index], \
		recipe['in_amount'][item_index]))
	return result


func generate_resource_by_recipe(recipe):
	var result = []
	# load recipe data and return the product
	# use index loop to look name and amount
	for item_index in range(0, recipe["output"].size()):
		result.append(easy_resource_create(recipe["output"][item_index], \
		recipe['out_amount'][item_index]))
	return result


func save_resource_ref_dic():
	var file = FileAccess.open(resource_ref_save_path, FileAccess.WRITE)
	file.store_var(resource_ref_dic)


func load_resource_ref_dic():
	var file = FileAccess.open(resource_ref_save_path, FileAccess.READ)
	var content = file.get_var()
	return content

	
func _ready():
	init_resource_ref_dic()
	
