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
	var select_index : int = 0
	var item_name = data_array[0]
	var item_amount = data_array[1]
	for item in RDS.resource_ref_dic:
		if item_name != item:
			select_index += 1
		else:
			break 
	get_node("ItemList").select(select_index)
	get_node("TextEdit").text = str(item_amount)
	
func load_item_ref():
	# should load the ref item for editor to choose
	for item in RDS.resource_ref_dic:
		get_node("ItemList").add_item(item)
		
func _ready():
	get_node("ItemList").clear()
	get_node("ItemList").allow_reselect = true
	load_item_ref()
