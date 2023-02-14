extends Node2D
class_name Colonist

func move_to(end_pos, delta):
	var speed = 1000
	var pos_diff = end_pos.x - position.x
	if abs(pos_diff) < speed * delta:
		position.x = end_pos.x
		return
	if pos_diff > 0:
		position.x += speed * delta
	else:
		position.x -= speed * delta

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_to(Vector2(1000, 0), delta)
