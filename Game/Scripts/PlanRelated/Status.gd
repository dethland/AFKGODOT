extends Node
class_name Status

var name_ : set = set_name, get = get_name
var priority_ : set = set_priority, get = get_priority

func _init(name, priority):
	name_ = name
	priority_ = priority

func set_name(name):
	name_ = name

func get_name():
	return name_	

func set_priority(priority):
	priority_ = priority

func get_priority():
	return priority_
	
func debug_format():
	var res = name_ + ": " + str(priority_)
	return res
