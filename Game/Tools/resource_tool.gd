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
	var name = get_node("%NameInput")
	var type = get_node("%TypePicker")
	var tier = get_node("%TierPicker")
	var iconPath = get_node("%IconPathInput")
	var resourceData = {"type": type, "tier": tier, "amount": 0, "icon_path": iconPath}
	RDS.resource_ref_dic["name"] = resourceData

func _on_new_pressed():
	pass # Replace with function body.
