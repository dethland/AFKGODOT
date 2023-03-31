extends HBoxContainer
class_name ResourceListItem

var item_name : String
var is_mouse_in : bool = false
var caller_node

func update_data(resourceName, iconPath):
	item_name = resourceName
	
	$NameLabel.text = resourceName
	$IconTexture.texture = load(iconPath)

func _input(event):
	if is_mouse_in:
		if event.is_action_released("mouse_left"):
			caller_node.load_resource(item_name)

func _on_mouse_entered():
	is_mouse_in = true


func _on_mouse_exited():
	is_mouse_in = false
