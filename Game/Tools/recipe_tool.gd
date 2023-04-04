extends Control

var input_recipe = []
var output_recipe = []

@export_file var item_temp_path
@export_file var item_obj_path

func item_node_to_recipe_list(container_node:VBoxContainer):
	# this function should convert all the data in the container node to a recipe list
	# using RDS ref res create
	var result = []
	for child in container_node.get_children():
		if child.get_node("ItemList").get_selected_items().is_empty():
			continue
		
		result.append(child.get_data())
	
	return result
	
func recipe_list_to_item_node(container_node:VBoxContainer, key, recipe_name):
	# this function return noting, will add the child node to container after decoding
	# this function get called when one item was selected
	for item in FS.facility_data_dic[recipe_name][key]:
		var item_obj_temp = load(item_obj_path).instantiate()
		item_obj_temp.data_array = item
		
		container_node.add_child(item_obj_temp)
		item_obj_temp.display_update()
	
func display_update():
	# loop through the recipe_name list and display the data
	for child in get_node("%ItemContianer").get_children():
		child.queue_free()
		
	for recipe_name in FS.facility_data_dic:
		var item_temp = load(item_temp_path).instantiate()
		item_temp.get_node("Label").text = recipe_name
		item_temp.caller_node = self
		item_temp.item_name = recipe_name
		get_node("%ItemContianer").add_child(item_temp)
	pass


func load_type():
	get_node("%TypeInput").clear()
	for type in Facility.facilityTypes:
		get_node("%TypeInput").add_item(type)


func load_recipe(recipe_name):
	# load the recipe by the name
	# empty container
	for child in get_node("%InputContainer").get_children():
		child.queue_free()
		
	for child in get_node("%OutputContainer").get_children():
		child.queue_free()
	
	# load name, type, time, worker capcity data 
	get_node("%NameInput").text = recipe_name
	get_node("%TypeInput").select(FS.facility_data_dic[recipe_name]["type"])
	get_node("%TimeInput").text = str(FS.facility_data_dic[recipe_name]["time"])
	get_node("%WorkerInput").text = str(FS.facility_data_dic[recipe_name]["worker_capacity"])
	
	# load recipe data
	recipe_list_to_item_node(get_node("%InputContainer"), "input", recipe_name)
	recipe_list_to_item_node(get_node("%OutputContainer"), "output", recipe_name)
		

func _on_add_pressed():
	# once click the add button
	var type_index = Facility.facilityTypes.EMPTY
	if get_node("%TypeInput").get_selected_items().size() != 0:
		type_index = get_node("%TypeInput").get_selected_items()[0]
		# get the recipe data
		output_recipe = item_node_to_recipe_list(get_node("%OutputContainer"))
		input_recipe = item_node_to_recipe_list(get_node("%InputContainer"))
		
	FS.add_facility_recipe(get_node("%NameInput").text, type_index,\
	get_node("%TimeInput").text, input_recipe, output_recipe, get_node("%WorkerInput").text)
	
	display_update()

func _on_new_pressed():
	get_node("%NameInput").text = ""
	get_node("%TypeInput").deselect_all()
	get_node("%TimeInput").text = ""
	get_node("%WorkerInput").text = ""
	


func _on_save_pressed():
	FS.save_facility_data_dic()
	display_update()


func _on_load_pressed():
	FS.load_facility_data_dic()
	print(FS.load_facility_data_dic())
	display_update()


func _on_output_plus_pressed():
	var item_obj_temp = load(item_obj_path).instantiate()
	get_node("%OutputContainer").add_child(item_obj_temp)


func _on_input_plus_pressed():
	var item_obj_temp = load(item_obj_path).instantiate()
	get_node("%InputContainer").add_child(item_obj_temp)
	

func _ready():
	load_type()
	display_update()
