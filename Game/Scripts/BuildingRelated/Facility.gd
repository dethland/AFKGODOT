extends Node2D
class_name Facility

@export var size : Vector2i # size of the sprite need for tile calculation
@export var _name : String : set = set__name, get = get__name
@export var facility_type : facilityTypes
enum facilityTypes {CONVERTE, STORE, GENERATE, HOUSING, TRANSPORT, EMPTY}

@export var testing_inventory = []

@export_file var colonist_path


@export var area2d_path : NodePath

var recipe : Dictionary # not working for now, need facility tool

signal item_changed

@onready var container = ResourceDataContainer.new()

@export var num_colonist : int

var is_operating

var ID : int : set = set_id, get = get_id # start from 1

@onready var colonist_spawn_position = get_node("Marker2D").global_position

var colonist_queue_list = [] #this list used to queue sending peple request

signal Progress_finish
@onready var timer = Timer.new()

var timer_percent = 0;
var timer_progress;

func build_test_inventory():
	for item_data in testing_inventory:
		var item_name = item_data[0]
		var item_amount = item_data[1]
		container.add_resource_data(ResourceData.new(item_name, item_amount))

func timer_set_up(t):
	timer_percent = t/100;
	timer.start(timer_percent)
	timer.time_out.connect(add_timer_progress)

func add_timer_progress():
	timer_progress += 1
	if (timer_progress == 33):
		pass
	if (timer_progress == 66):
		pass
	if (timer_progress == 100):
		Progress_finish.emit()

func can_craft(recipe: Dictionary) -> bool:
	return container.has_enough_resource(recipe["input"])

func craft(recipe: Dictionary):
	var temp;
	if can_craft(recipe):
		for item_index in range(0, recipe["input"].size()):
			temp = recipe["input"][item_index].get_amount()
			container.subtract_resource_element_quantity(recipe["input"][item_index], temp)
		for item in recipe["output"]:
			container.add_resource_data(item)

func send_request_for_colonist():
	if facility_type == facilityTypes.CONVERTE: # bug careful
		var colonists_needed = get_desired_population() - num_colonist
		if colonists_needed > 0:
			CM.add_request(ID, colonists_needed)


func generate_resource():
	var item_list = RDS.generate_resource_by_recipe(recipe)
	for item in item_list:
		container.stackable_add_resource_data(item)
	container.beautiful_debug()
	emit_signal("item_changed")
	
func convert_resource():
	# check if there is enough resource to convert
	var check_list = RDS.convert_check_list_by_recipe(recipe)
	print("I have enough: " + str(container.has_enough_resource(check_list)))
	emit_signal("item_changed")

func start_processing():
	pass


func get_id():
	return ID

func set_id(int_value):
	ID = int_value

func get__name():
	return _name

func set__name(str_vlaue):
	_name = str_vlaue
	
func add_to_colonist_queue(requst_chunk):
	colonist_queue_list.append(requst_chunk)
	print(colonist_queue_list)

func send_people_to():
	# actual send people function
	for requst in colonist_queue_list:
		# requst is a list like this: [target_id, num_col_to_send]
		for per_col in range(0, requst[1]):
			var colonist = load(colonist_path)
			var instance :Colonist = colonist.instantiate()
			instance.global_position = colonist_spawn_position
			instance.set_workplace_id(requst[0])
			get_parent().get_node("Colonists").add_child(instance)
			await get_tree().create_timer(3).timeout
	


func send_resource_to(target_id, resource_data):
	var resource_amount = resource_data.get_amount()
	var resource_name = resource_data.get_name()
	print("I am facility %s, I will send %s %s to facility %s" % [ID, resource_amount, resource_name, target_id])
	var colonist = load(colonist_path)
	var instance :Colonist = colonist.instantiate()
	instance.global_position = colonist_spawn_position
	instance.set_workplace_id(target_id)
	instance.navi = get_parent().get_node("NaviServer")
	get_parent().get_node("Colonists").add_child(instance)
	
func colonist_enter(colonist):
	colonist.queue_free()
	num_colonist += 1
	
func colonist_exit():
	num_colonist -= 1
	
func get_desired_population():
	return recipe["worker_capacity"]
	
	
func get_population():
	return num_colonist
	
func set_population(int_value):
	num_colonist = int_value
	
func _ready():
	ID = FS.init_facility(self)
	
	print("facility: " + _name + " id: " + str(ID))
	
	CM.requst_assign_finished.connect(_on_requst_assign_finished)
	# check the area2d_path exist
	if not area2d_path.is_empty():
		var area2d : Area2D = get_node(area2d_path)
		area2d.connect("body_entered", on_body_entered)
	send_request_for_colonist()
	
	var enough_colonists = false
	if num_colonist > 4: #4 is example not final
		enough_colonists = true
	
#	if enough_colonists == true:
#		var timer = Timer.new()
#		add_child(timer)
#		timer.timeout.connect(generate_resource) #connect to gen resource
#		timer.timeout.connect(convert_resource) #connect to convert resource
#		timer.start(1)
	

func on_body_entered(body):
	if body is CharacterBody2D:
		print('enter a body')
		# check the colonist target, if self delete body
		if body.get_workplace_id() == ID:
			colonist_enter(body)

# below are time related
func _on_cycle_end(): #stop_work signal
	#send_colonist_back_home()
	pass
	
func _on_cycle_start(): #begin_work signal
	#send_colonist_to_work()
	pass
	
func _on_requst_assign_finished():
	send_people_to()

func _process(_delta):
	if Input.is_action_just_released("ui_accept"):
		# similate the cycle function called
		match facility_type:
			facilityTypes.CONVERTE: 
#				convert_resource()
				pass
			facilityTypes.GENERATE:
#				generate_resource()
				pass
			facilityTypes.HOUSING:
				pass
			facilityTypes.STORE:
				pass

			
