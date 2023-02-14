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
enum facilityTypes {CONVERTE, STORE, GENERATE}

@onready var container = ResourceDataContainer.new()

var colonist_list : Array

var is_operating

func generate_resource():
	container.add_resource_data(RDS.easy_resource_create(var_3, var_2))
	container.beautiful_debug()

func get__name():
	return _name

func set__name(str_vlaue):
	_name = str_vlaue
	
func colonist_enter(colonist):
	pass
	
func colonist_exit(colonist):
	pass
	
func debug_update():
	var debug_text = ""
	debug_text += _name + "\n"
	$Debug.text = debug_text
	
func _ready():
	debug_update()

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		generate_resource()
	
