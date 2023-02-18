extends Node
class_name FacilityServer

var facility_array = []

var facility_recipe_dic = {
	
}

func init_facility(facility_node : Facility):
	facility_array.append(facility_node)
	return facility_array.size()
	
func get_houses_list():
	var result = []
	for facility in facility_array:
		if facility is Facility:
			if facility.facility_type == Facility.facilityTypes.HOUSING:
				result.append(facility)
	return result
	
func get_facility_by_id(int_value):
	pass
