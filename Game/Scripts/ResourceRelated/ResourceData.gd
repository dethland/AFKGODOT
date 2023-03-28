extends Object
class_name ResourceData

var elements = {"amount" : 0}
var resource_name = ""

# elements will used a lot are : amount

func _init(startName: String = "", startAmount: int = 0):
	# constrction option
	set_name(startName)
	set_amount(startAmount)

func set_name(name):
	resource_name = name
	
func get_name():
	return resource_name
	
func get_elements():
	return elements
	
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
	
func sub_quantity_element(key, amount):
	if key not in elements:
		push_error("Element not in this specific resource")
	elements[key] -= amount
	if elements[key] <= 0:  elements.remove(key)

func get_amount():
	return elements["amount"]

func set_amount(num):
	elements["amount"] = num
	
func add_amount(num):
	elements["amount"] = elements["amount"] + num

func sub_amount(amount):
	elements["amount"] = max(elements["amount"] - amount, 0)
