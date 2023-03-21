extends Control

var input_recipe = []
var output_recipe = []

@export_file var item_temp_path

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
	get_node("%NameInput").text = recipe_name
	get_node("%TypeInput").select(FS.facility_data_dic[recipe_name]["type"])
	get_node("%TimeInput").text = str(FS.facility_data_dic[recipe_name]["time"])
	get_node("%WorkerInput").text = str(FS.facility_data_dic[recipe_name]["worker_capacity"])

func _on_add_pressed():
	# once click the add, loop through the input
	var type_index = Facility.facilityTypes.EMPTY
	if get_node("%TypeInput").get_selected_items().size() != 0:
		type_index = get_node("%TypeInput").get_selected_items()[0]
		
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


func _on_load_pressed():
	FS.load_facility_data_dic()


func _on_output_plus_pressed():
	# create a empty slots for the new item
	pass


func _on_input_plus_pressed():
	pass # Replace with function body.

func _ready():
	load_type()
	display_update()
