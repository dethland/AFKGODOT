extends Control

@export var save = NodePath()


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print(save)

