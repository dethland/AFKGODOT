extends HBoxContainer

var item_name : String
var is_mouse_in : bool = false
var caller_node

func _input(event):
	if is_mouse_in:
		if event.is_action_released("mouse_left"):
			print(item_name)
			caller_node.load_recipe(item_name)


func _on_mouse_entered():
	is_mouse_in = true


func _on_mouse_exited():
	is_mouse_in = false
