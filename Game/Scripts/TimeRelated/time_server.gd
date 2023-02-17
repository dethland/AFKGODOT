extends Node2D

class_name TimeServer
#add properties
var time = 0
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_add_time)
	timer.start(3)


#function sets time 
func _add_time():
	time += 0.5
	if time == 24:
		time = 0
	print(time)


func _get_callert():
	pass



