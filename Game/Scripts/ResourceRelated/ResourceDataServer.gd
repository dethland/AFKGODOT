extends Node
class_name ResourceDataServer

var resource_ref_save_path = "res://Data/ResourceRef.txt"

var resource_ref_dic = {
	"iron_ore" : {"type":"ORE","tier":1,"amount":0,"icon_path":""},
	"copper_ore" : {"type":"ORE","tier":1,"amount":0,"icon_path":""},
	"iron_bar" :{"type":"BAR", "tier":1, "amount":0, "icon_path":""},
	"log" : {"type":"MATERIAL", "tier":1, "amount":0, "icon_path":""}
}
enum resourceType {ORE, MATERIAL} 


func init_resource_ref_dic():
	# no internal use, just dont mind what it is doing
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
	# create very filexiable resource, only for debug
	var result = ResourceData.new()
	result.set_name(str_value)
	result.add_element("amount", int_value)
	return result
	
func ref_resource_create(str_value : String, int_value : int):
	# create resource only if ref data exist
	var result = ResourceData.new()
	if not str_value in resource_ref_dic:
		return result
	result.set_name(str_value)
	result.set_amount(int_value)
	return result

func convert_resource_data_list_to_array(data_list):
	# array for saving purpose
	var result = []
	for RD in data_list:
		result.append([RD.get_name(), RD.get_amount()])
	return result

func convert_array_to_resource_data_list(array):
	# res data for game processing
	var result = []
	for data in array:
		pass

func convert_check_list_by_recipe(recipe):
	# need to change, due to recipe strcutre changed
	var result = []
	for item_index in range(0, recipe["input"].size()):
		result.append(easy_resource_create(recipe["input"][item_index][0], \
		recipe['input'][item_index][1]))
	return result


func generate_resource_by_recipe(recipe):
#	need to change, due to recipe strcutre changed
	var result = []
	# load recipe data and return the product
	# use index loop to look name and amount
	for item_index in range(0, recipe["output"].size()):
		result.append(easy_resource_create(recipe["output"][item_index][0], \
		recipe['output'][item_index][1]))
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
	
