extends HBoxContainer

var data_array = []

func get_data():
	var item_name_id = get_node("ItemList").get_selected_items()[0]
	var item_name = get_node("ItemList").get_item_text(item_name_id)
	data_array.append(item_name)
	var item_amount = int(get_node("TextEdit").text)
	data_array.append(item_amount)
	return data_array

func display_update():
	load_item_ref()
	
	print('display_should_update')
	for item_index in range(0, get_node("ItemList").get_item_count()):
		print(get_node("ItemList").get_item_text(item_index))
		if get_node("ItemList").get_item_text(item_index) == data_array[0]:
			get_node("ItemList").select(item_index)
			get_node("TextEdit").text = str(data_array[1])

func load_item_ref():
	# should load the ref item for editor to choose
	for item in RDS.resource_ref_dic:
		get_node("ItemList").add_item(item)
		
func _ready():
	get_node("ItemList").clear()
	load_item_ref()
