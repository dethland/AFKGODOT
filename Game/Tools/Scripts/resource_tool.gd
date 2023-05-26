extends Control

@export var save = NodePath()
@export var load = NodePath()

@export_file var item_path

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print(save)
		
func _ready():
	RDS.load_resource_ref_dic()
	update_list()
	update_resource_types()

func _on_save_pressed():
	RDS.save_resource_ref_dic()
	update_list()

func _on_load_pressed():
	RDS.load_resource_ref_dic()
	update_list()
	

func _on_add_pressed():
	var typeSelected = %TypePicker.get_selected_items()
	var tierSelected = %TierPicker.get_selected_items()
	if name != "" and typeSelected.size() != 0 and tierSelected.size() != 0:
		var name = get_node("%NameInput").text
		var typeIdx = typeSelected[0]
		var tierIdx = tierSelected[0]
		var type = %TypePicker.get_item_text(typeIdx)
		var tier = int(%TierPicker.get_item_text(tierIdx))
		var iconPath = %IconPathInput.text
		var resourceData = {"type": type, "tier": tier, "amount": 0, "icon_path": iconPath}
		RDS.resource_ref_dic[name] = resourceData
		update_list()

func _on_new_pressed():
	var num = 1
	# in case multiple new added without changing name
	while RDS.resource_ref_dic.has("New Resource #" + str(num)):
		num += 1
	RDS.resource_ref_dic["New Resource #" + str(num)] = {"type": "", "tier": "", "amount": 0, "icon_path": ""}
	update_list()

func update_resource_types():
	var resources = RDS.resource_ref_dic
	for key in resources.keys():
		var type = resources[key]["type"]
		var found = false
		for i in range(%TypePicker.item_count):
			if %TypePicker.get_item_text(i) == type:
				found = true
				break
		if not found:
			%TypePicker.add_item(type)
				
func update_list():
	var dic = RDS.resource_ref_dic
	var resource_list = get_node("%ResourceList")
	for n in resource_list.get_children():
		resource_list.remove_child(n)
		n.queue_free()
	for key in dic.keys():
		var iconPath = dic[key]["icon_path"]
		var newItem = load(item_path).instantiate()
		newItem.update_data(key, iconPath)
		newItem.caller_node = self
		resource_list.add_child(newItem)
		
# load resource data to resource tool input fields
func load_resource(resource_name: String):
	var resource_data = RDS.resource_ref_dic[resource_name]
	
	# check if resource found
	if resource_data == null:
		print("Resource \"" + resource_name + "\" not found")
		return
	
	# load name and icon path
	%NameInput.text = resource_name
	%IconPathInput.text = resource_data["icon_path"]
	
	# find type and select
	var type_idx
	for i in range(%TypePicker.item_count):
			if %TypePicker.get_item_text(i) == resource_data["type"]:
				type_idx = i
				break
	%TypePicker.select(type_idx)
	
	# find tier and select
	var tier_idx
	for i in range(%TierPicker.item_count):
			if int(%TierPicker.get_item_text(i)) == resource_data["tier"]:
				type_idx = i
				break
	%TierPicker.select(type_idx)
	
	%TypePicker.sort_items_by_text()
	
