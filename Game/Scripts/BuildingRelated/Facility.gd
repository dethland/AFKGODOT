extends Node2D
class_name Facility

@export var _name : String : set = set__name, get = get__name
@export var facility_type : facilityTypes
## time to create resource
@export var var_1 : int 
 ## amount to generate
@export var var_2 : int
## product to generate
@export var var_3 : String 
## take how many operator to work
@export var var_4 : int 
## convert the resource from
@export var var_5 : String
## take how many of resource to start convert
@export var var_6 : int
enum facilityTypes {CONVERTE, STORE, GENERATE, HOUSING}


@onready var container = ResourceDataContainer.new()

var num_colonist : int

var is_operating

var ID : int : set = set_id, get = get_id# start from 1 `

func _init():
	ID = FS.init_facility(self)
	print(ID)


func generate_resource():
	container.stackable_add_resource_data(RDS.easy_resource_create(var_3, var_2))
	container.beautiful_debug()

func get_id():
	return ID

func set_id(int_value):
	ID = int_value

func get__name():
	return _name

func set__name(str_vlaue):
	_name = str_vlaue
	
func colonist_enter(colonist):
	colonist.queue_free()
	num_colonist += 1
	
func colonist_exit():
	num_colonist -= 1
	
func debug_update():
	var debug_text = ""
	debug_text += _name + "\n"
	$Debug.text = debug_text
	
func get_population():
	return num_colonist
	
func set_population(int_value):
	num_colonist = int_value
	
func _ready():
	debug_update()

func _process(_delta):
	if Input.is_action_just_released("ui_accept"):
		match facility_type:
			facilityTypes.CONVERTE: 
				pass
			facilityTypes.GENERATE:
				generate_resource()
			facilityTypes.HOUSING:
				pass
			facilityTypes.STORE:
				pass

			
