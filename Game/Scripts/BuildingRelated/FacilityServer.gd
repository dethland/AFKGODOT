extends Node
class_name FacilityServer

var facility_array = []

var facility_recipe_dic = {
	
}

func init_facility(facility_node):
	facility_array.append(facility_node)
	return facility_array.size()
	
