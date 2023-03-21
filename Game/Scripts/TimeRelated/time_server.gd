extends Node2D

class_name TimeServer
signal cycle_end

var is_able = false

var time = 0
var gameday = 0
var gamehour = 0
var gameminute = 0
var gamesecond = 0

func _ready():
	if not is_able:
		return
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_add_time)
	timer.start(3) 
	#15*, every 15 seconds one half hour passes so, 1 day is 360 seconds


#function sets time 
func _add_time():
	time += 0.5
	if time == 24:
		time = 0
		emit_signal("cycle_end")
	print(time)


func _get_callert():
	pass


