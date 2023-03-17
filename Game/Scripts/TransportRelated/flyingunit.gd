extends CharacterBody2D
class_name FlyingUnit

var max_speed
@onready var debug = get_parent().get_parent().get_node("TempDebug")

var rest_place_id_ : set = set_rest_place_id, get = get_rest_place_id
var workplace_id_ : set = set_workplace_id, get = get_workplace_id
var path : PackedVector2Array
var first_time : bool = true
var is_requesting_path : bool  = false

var navi : NaviServer

func set_rest_place_id(rest_place_id):
	rest_place_id_ = rest_place_id

func get_rest_place_id():
	return rest_place_id_

func set_workplace_id(workplace_id):
	workplace_id_ = workplace_id

func get_workplace_id():
	return workplace_id_
	
func request_path(target_position):
	var result = NS.get_navi_path_to(position, target_position)
	result.remove_at(0)
	return result
	

# return true when arrive position
func move_to(end_pos):
	var speed = 200
	var point_vector = end_pos - position
	# snap to end position if colonist would move past
	velocity = speed * point_vector.normalized()
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if workplace_id_ != null and first_time:
		path = request_path(FS.get_facility_by_id(workplace_id_).colonist_spawn_position)
		first_time = false
		debug.path = path
		debug.queue_redraw()
		
	if path.size() == 0:
		return
	
	var is_arrived = move_to(path[0])
	
	if is_arrived:
		path.remove_at(0)

		
