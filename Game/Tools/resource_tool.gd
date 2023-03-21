extends Control

@export var save = NodePath()
@export var load = NodePath()


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print(save)

func _on_save_pressed():
	RDS.save_resource_ref_dic()

func _on_load_pressed():
	RDS.load_resource_ref_dic()

func _on_add_pressed():
	var name = get_node("%NameInput").text
	var typeIdx = get_node("%TypePicker").get_selected_items()[0]
	var tierIdx = get_node("%TierPicker").get_selected_items()[0]
	var type = get_node("%TypePicker").get_item_text(typeIdx)
	var tier = get_node("%TierPicker").get_item_text(tierIdx)
	var iconPath = get_node("%IconPathInput").text
	var resourceData = {"type": type, "tier": tier, "amount": 0, "icon_path": iconPath}
	RDS.resource_ref_dic[name] = resourceData

func _on_new_pressed():
	var num = 1
	# in case multiple new added without changing name
	while RDS.resource_ref_dic.has("New Resource #" + str(num)):
		num += 1
	RDS.resource_ref_dic["New Resource #" + str(num)] = {}
