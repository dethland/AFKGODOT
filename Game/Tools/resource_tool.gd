extends Control

@export var save = NodePath()
@export var load = NodePath()


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print(save)

