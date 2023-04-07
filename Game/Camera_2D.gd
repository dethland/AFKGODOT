extends Camera2D

const camera_speed = 50
var camera_position = 1

func _ready():
	pass # Replace with function body.

func zoom():
	if Input.is_action_just_released('X'):
		set_zoom(get_zoom() - Vector2(0.25,0.25))
	if Input.is_action_just_released('C'):
		set_zoom(get_zoom() + Vector2(0.25,0.25))

func _process(delta):
	zoom()
	if Input.is_action_just_released('A'):
		camera_position += Vector2.LEFT * delta * camera_speed 
	if Input.is_action_just_released('D'):
		camera_position -= Vector2.RIGHT * delta * camera_speed

