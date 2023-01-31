extends Object
class_name ResourceData

var _name : set = set__name, get = get__name
var amount : set = set_amount, get = get_amount


func set__name(str_value):
	_name = str_value
	
func get__name():
	return _name
	
func set_amount(int_value):
	amount = int_value
	
func get_amount():
	return amount
