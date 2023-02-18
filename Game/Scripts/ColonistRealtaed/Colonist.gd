extends Node2D
class_name Colonist

var rest_place_id_ : set = set_rest_place_id, get = get_rest_place_id
var workplace_id_ : set = set_workplace_id, get = get_workplace_id

func set_rest_place_id(rest_place_id):
	rest_place_id_ = rest_place_id

func get_rest_place_id():
	return rest_place_id_

func set_workplace_id(workplace_id):
	workplace_id_ = workplace_id

func get_workplace_id():
	return workplace_id_

func move_to(end_pos, delta):
	var speed = 1000
	var pos_diff = end_pos.x - position.x
	# snap to end position if colonist would move past
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
