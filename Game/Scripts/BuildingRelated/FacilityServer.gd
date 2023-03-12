extends Node
class_name FacilityServer

var facility_array = []

var facility_data_dic = {
	"OreRefineFactory" : {"type": Facility.facilityTypes.CONVERTE,
		"time" : 10, "input" : ["iron_ore"], "output" : ["iron_bar"], "in_amount" : [3], 
		"out_amount" : [1], "worker_capacity" : 4},
	"MiningFactory" : {"type" : Facility.facilityTypes.GENERATE, 
		"time" : 10, "output" : ["iron_ore"], "out_amount" : [5], "worker_capacity" : 4}
}

func init_facility(facility_node : Facility):
	facility_array.append(facility_node)
	var name_value = facility_node.get__name()
	if facility_data_dic.has(name_value):
		facility_node.recipe = facility_data_dic[name_value]
		facility_node.facility_type = facility_data_dic[name_value]["type"]
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
