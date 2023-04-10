extends CharacterBody2D
class_name Colonist

var max_speed
#@onready var debug = get_parent().get_parent().get_node("TempDebug")

var rest_place_id_ : set = set_rest_place_id, get = get_rest_place_id
var workplace_id_ : set = set_workplace_id, get = get_workplace_id
var path : PackedVector2Array
var first_time : bool = true
var is_requesting_path : bool  = false

var resource_data_ : set = set_resource_data, get = get_resource_data

var navi : NaviServer

func set_resource_data(resource_data):
	resource_data_ = resource_data

func get_resource_data():
	return resource_data_

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
func move_to(end_pos, delta):
	var speed = 200
	var pos_diff = end_pos.x - position.x
	# snap to end position if colonist would move past
	if abs(pos_diff) < speed * delta:
		position.x = end_pos.x
#		get_node("AnimatedSprite2D").play("default")

		return true
		
	if pos_diff > 0:
		get_node("AnimatedSprite2D").set_flip_h(false)
		velocity.x = speed
	else:
		get_node("AnimatedSprite2D").set_flip_h(true)
		velocity.x = -speed
		
	velocity.y += 50
	
	get_node("AnimatedSprite2D").play("walk")
	move_and_slide()
		
	return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("AnimatedSprite2D").play("walk")
	if workplace_id_ != null and first_time:
		path = request_path(FS.get_facility_by_id(workplace_id_).colonist_spawn_position)
		path = path.slice(-1) # manually 
		first_time = false
#		debug.path = path
#		debug.queue_redraw()
		
	if path.size() == 0:
		return
	
	var is_arrived = move_to(path[0], delta)
	
	if is_arrived:
		path.remove_at(0)
		
	


func _ready():
	get_node("AnimatedSprite2D").play("walk")
