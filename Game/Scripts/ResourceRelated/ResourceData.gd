extends Object
class_name ResourceData

var elements = {}
var resource_name = ""

func set_name(name):
	resource_name = name
	
func get_name():
	return resource_name
	
func add_element(key, value):
	elements[key] = value
	
func get_element(key):
	if key not in elements:
		push_error("Element not in this specific resource")
		return -1
	return elements[key]

func set_element(key, amount):
	if key not in elements:
		push_error("Element not in this specific resource")
	elements[key] = amount
	
func get_all_elements():
	return elements.keys()
	
func add_quantity_element(key, amount):
	if key not in elements:
		push_error("Element not in this specific resource")
	elements[key] += amount
	
