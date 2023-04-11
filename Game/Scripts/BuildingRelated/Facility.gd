extends Node2D
class_name Facility

@export var size : Vector2i # size of the sprite need for tile calculation
@export var _name : String : set = set__name, get = get__name
@export var facility_type : facilityTypes
enum facilityTypes {CONVERTE, STORE, GENERATE, HOUSING, TRANSPORT, EMPTY}

@export var colonist_group_node_path: NodePath

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
var first_check = true

var wait_manager_finish_bool := false

func update_num_colonist_lable():
	get_node("Num_colonist").text = str(get_population())
	
func update_inventory_lable():
	var inventory = container.get_all_resource_data()
	get_node("Inventory").text = ""
	for item_name in inventory:
		var item_amount = inventory[item_name].get_amount()
		
		get_node("Inventory").text += item_name + " "+str(item_amount) +"\n"

func build_test_inventory():
	for item_data in testing_inventory:
		var item_name = item_data[0]
		var item_amount = item_data[1]
		container.add_resource_data(ResourceData.new(str(item_name), int(item_amount)))

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

func craft():

	if can_craft(recipe):
		for item_index in range(0, recipe["input"].size()):
			var item_amount = recipe["input"][item_index][1]
			container.subtract_resource_element_quantity(recipe["input"][item_index][0], item_amount)
		for item in recipe["output"]:
			var item_name = item[0]
			var item_amount = item[1]
			var real_item = RDS.ref_resource_create(item_name, item_amount)
			container.stackable_add_resource_data(real_item)
			
	update_inventory_lable()

func send_request_for_colonist():
	if facility_type != facilityTypes.HOUSING:
		var colonists_needed = get_desired_population() - num_colonist
		if colonists_needed > 0:
			CM.add_request(ID, colonists_needed)

func send_requst_for_resource():
	if facility_type != facilityTypes.HOUSING:
		for resource_data in recipe["input"]:
			var resource_name = resource_data[0]
			var input_amount = resource_data[1]
			var current_amount = 0
			if container.get_resource_data_by_name(resource_name):
				current_amount = container.get_resource_data_by_name(resource_name).get_amount()
			if current_amount<input_amount:
				var resource_needed = ResourceData.new(resource_name, input_amount-current_amount)
				TM.add_request(ID, resource_needed)
				
			

func generate_resource():
	var item_list = RDS.generate_resource_by_recipe(recipe)
	for item in item_list:
		container.stackable_add_resource_data(item)
	update_inventory_lable()
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
	
func add_to_colonist_queue(request_chunk, resource_data = null):
	request_chunk.append(resource_data)
	colonist_queue_list.append(request_chunk)

func send_people_to():
	# actual send people function
	for request in colonist_queue_list:
		# request is a list like this: [target_id, num_col_to_send]
		# when you send colonist with resource on them
		if request[2] != null:
			
			var colonist = load(colonist_path)
			var instance :Colonist = colonist.instantiate()
			instance.set_resource_data(request[2])
			instance.global_position = colonist_spawn_position
			instance.set_workplace_id(request[0])
			get_node(colonist_group_node_path).add_child(instance) # add colonist to the nodegroup
			update_inventory_lable()
			await get_tree().create_timer(3).timeout
			continue # skip the rest of the loop

		# when you want to send colonist
		for per_col in range(0, request[1]):
			
			var colonist = load(colonist_path)
			var instance :Colonist = colonist.instantiate()
			instance.global_position = colonist_spawn_position
			instance.set_workplace_id(request[0])
			get_node(colonist_group_node_path).add_child(instance)
			colonist_exit() # call this function only you are send colonist
			await get_tree().create_timer(0.1).timeout
	# clear the list once finished		
	colonist_queue_list.clear()


#func send_resource_to(target_id, resource_data):
#	var resource_amount = resource_data.get_amount()
#	var resource_name = resource_data.get_name()
#	print("I am facility %s, I will send %s %s to facility %s" % [ID, resource_amount, resource_name, target_id])
#	var local_resource = container.get_resource_data_by_name(resource_data.get_name())
#	var curr_amount = local_resource.get_amount()
#	print(curr_amount)
#	#local_resource.set_amount(curr_amount - resource_amount)
#	var colonist = load(colonist_path)
#	var instance :Colonist = colonist.instantiate()
#	instance.global_position = colonist_spawn_position
#	instance.set_workplace_id(target_id)
#	instance.navi = get_parent().get_node("NaviServer")
#	get_parent().get_node("Colonists").add_child(instance)
	
func colonist_enter(colonist):
	colonist.queue_free()
	if colonist.get_resource_data() != null:
		container.stackable_add_resource_data(colonist.get_resource_data())
		update_inventory_lable()
		return # skip the rest of the code, for we don't want to add pepople when they have resource
		
	num_colonist += 1
	update_num_colonist_lable()
	
	
func colonist_exit():
	num_colonist -= 1
	update_num_colonist_lable()
	
func get_desired_population():
	return recipe["worker_capacity"]
	
func get_population():
	return num_colonist
	
func set_population(int_value):
	num_colonist = int_value
	
func _ready():
	update_num_colonist_lable()
	ID = FS.init_facility(self)
	
	build_test_inventory()
	
	print("facility: " + _name + " id: " + str(ID))
	
	CM.requst_assign_finished.connect(_on_requst_assign_finished)
	TM.requst_assign_finished.connect(_on_requst_assign_finished)
	# check the area2d_path exist
	if not area2d_path.is_empty():
		var area2d : Area2D = get_node(area2d_path)
		area2d.connect("body_entered", on_body_entered)
	send_request_for_colonist()
	
	add_child(timer)
	match facility_type:
		facilityTypes.CONVERTE:
			timer.timeout.connect(craft)
		facilityTypes.GENERATE:
			timer.timeout.connect(generate_resource)

	## debug
	update_inventory_lable()

func on_body_entered(body):
	if body is CharacterBody2D:
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
	# for the demo disable for now 
#	if wait_manager_finish_bool:
#		send_people_to()
#		wait_manager_finish_bool = false
#	else:
#		wait_manager_finish_bool = true
	send_people_to()

func _process(_delta):
	if num_colonist >= recipe["worker_capacity"] and first_check:
		if get__name() == 'ore_refine':
			print("try to start timer")
			print(recipe["time"])
		timer.start(recipe["time"])
		first_check = false	
