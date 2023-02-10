extends Node2D
class_name Facility

var _name
var facility_type
enum facilityTypes {CONVERTE, STORE, GENERATE}

@onready var contianer = ResourceDataContainer.new()

func generate_resource():
	pass
