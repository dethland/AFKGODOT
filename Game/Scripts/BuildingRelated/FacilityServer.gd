extends Node
class_name FacilityServer

var facility_array = []

# the following data structure is no longer used, keep it only for debug purpose
var archive_facility_data_dic = {
	"OreRefineFactory" : {"type": Facility.facilityTypes.CONVERTE,
		"time" : 10, "input" : ["iron_ore"], "output" : ["iron_bar"], "in_amount" : [3], 
		"out_amount" : [1], "worker_capacity" : 4},
	"MiningFactory" : {"type" : Facility.facilityTypes.GENERATE, 
		"time" : 10, "output" : ["iron_ore"], "out_amount" : [5], "worker_capacity" : 4}
}

# this is te new data structure for the facility recipe data
var facility_data_dic = {
	"exp_recipe" : {"type": Facility.facilityTypes.EMPTY,
		"time" : 10, "input" : [], "output" : [], "worker_capacity" : 4}
}

var facility_data_dic_savable = {}

var facility_data_save_path = "res://Data/FacilityRef.txt"


# the structure need to change
func add_facility_recipe(_name, type, time, input, output, worker):
	facility_data_dic[_name] = {"type" : type, "time" : int(time), "input" : input, "output" : output,\
	"worker_capacity" : int(worker)}
	print(facility_data_dic)


func init_facility(facility_node : Facility):
	facility_array.append(facility_node)
	var name_value = facility_node.get__name()
	if facility_data_dic.has(name_value):
		facility_node.recipe = facility_data_dic[name_value]
		facility_node.facility_type = facility_data_dic[name_value]["type"]
	else:
		print("This facility dose not have recipe")
	return facility_array.size()
	

func get_houses_list():
	var result = []
	for facility in facility_array:
		if facility is Facility:
			if facility.facility_type == Facility.facilityTypes.HOUSING:
				result.append(facility)
	return result
	
	
func get_facilities_by_type(facilityType=null):
	var result = []
	for facility in facility_array:
		if facility is Facility:
			if facility.facility_type == facilityType or facilityType == null:
				result.append(facility)
	return result
	

func get_facility_by_id(int_value):
	var result : Facility
	for facility in facility_array:
		if facility is Facility:
			if facility.ID == int_value:
				result = facility
				break
	return result
	
	
func save_facility_data_dic():
	var file = FileAccess.open(facility_data_save_path, FileAccess.WRITE)
	file.store_var(facility_data_dic)
	
func load_facility_data_dic():
	var file = FileAccess.open(facility_data_save_path, FileAccess.READ)
	var content = file.get_var()
	facility_data_dic = content
	
	
func init_facility_ref_dic():
	# no internal use, just dont mind what it is doing
	var file_check = FileAccess.file_exists(facility_data_save_path)
	if !file_check:
		save_facility_data_dic	()
		
	var file = FileAccess.open(facility_data_save_path, FileAccess.READ)
	var content = file.get_var()
	
	if content != null:
		save_facility_data_dic()
		return 
		
	facility_data_dic =  load_facility_data_dic()

func _ready():
	load_facility_data_dic()
