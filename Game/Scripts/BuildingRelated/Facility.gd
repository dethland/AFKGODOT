extends Node2D
class_name Facility

@onready @export var _name : String : set = set__name, get = get__name
@export var facility_type : facilityTypes
enum facilityTypes {CONVERTE, STORE, GENERATE, HOUSING, TRANSPORT, EMPTY}

@export var area2d_path : NodePath

var recipe : Dictionary 



@onready var container = ResourceDataContainer.new()

var num_colonist : int

var is_operating

var ID : int : set = set_id, get = get_id # start from 1 `


func generate_resource():
	var item_list = RDS.generate_resource_by_recipe(recipe)
	for item in item_list:
		container.stackable_add_resource_data(item)
	container.beautiful_debug()
	
func convert_resource():
	# check if there is enough resource to convert
	var check_list = RDS.convert_check_list_by_recipe(recipe)
	print("I have enough" + str(container.has_enough_resource(check_list)))

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
	
func send_people_to(target_id, int_value):
	# set int_value of colonist to the target_id
	# for now only do debug print
	print("I am house %s, I will send %s people to facility %s" % [ID, int_value, target_id])
	
func colonist_enter(colonist):
	colonist.queue_free()
	num_colonist += 1
	
func colonist_exit():
	num_colonist -= 1
	
func debug_update():
	var debug_text = ""
	debug_text += get__name() + "\n"
	$Debug.text = debug_text
	
func get_population():
	return num_colonist
	
func set_population(int_value):
	num_colonist = int_value
	
func _ready():
	debug_update()
	ID = FS.init_facility(self)
	if not area2d_path.is_empty():
		var area2d : Area2D = get_node(area2d_path)
		area2d.connect("body_entered", on_body_entered)

func on_body_entered(body):
	if body is Colonist:
		# check the colonist target, if self delete body
		pass

func _process(_delta):
	if Input.is_action_just_released("ui_accept"):
		match facility_type:
			facilityTypes.CONVERTE: 
				convert_resource()
			facilityTypes.GENERATE:
				generate_resource()
			facilityTypes.HOUSING:
				pass
			facilityTypes.STORE:
				pass

			
