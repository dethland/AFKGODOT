extends CharacterBody2D
class_name TransportUnit


var target_id_ : set = set_target_id, get = get_target_id
var resource_data_ : set = set_resource_data, get = get_resource_data
var path : PackedVector2Array
var first_time : bool = true
var is_requesting_path : bool  = false

var navi : NaviServer

func set_target_id(target_id):
	target_id_ = target_id

func get_target_id():
	return target_id_
	
func set_resource_data(resource_data):
	resource_data_ = resource_data

func get_resource_data():
	return resource_data_
	
func request_path(target_position):
	var result = navi.get_navi_path_to(position, target_position)
	result.remove_at(0)
	return result

# return true when arrive position
func move_to(end_pos, delta):
	var speed = 200
	var pos_diff = end_pos.x - position.x
	# snap to end position if colonist would move past
	if abs(pos_diff) < speed * delta:
		position.x = end_pos.x
		get_node("AnimatedSprite2D").play("default")
		return true
		
	if pos_diff > 0:
		get_node("AnimatedSprite2D").flip_h = false
		velocity.x = speed
	else:
		get_node("AnimatedSprite2D").flip_h = true
		velocity.x = -speed
		
	velocity.y += 50
	
	get_node("AnimatedSprite2D").play("walk")
	
	move_and_slide()
		
	return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if navi != null and first_time:
		path = request_path(FS.get_facility_by_id(target_id_).position)
		first_time = false
		print(path)
		
	if path.size() == 0:
		return
	
	var is_arrived = move_to(path[0], delta)
	
	if is_arrived:
		path.remove_at(0)
		
		
