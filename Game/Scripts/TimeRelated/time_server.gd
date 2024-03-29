extends Node2D

class_name TimeServer
signal cycle_end

signal begin_work
signal stop_work

var is_able = false

var time = 0
var gameday = 0

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
		gameday += 1
	
	if time == 6: #at 6am signal for workers to start.
		emit_signal("begin_work")
	if time == 18: #at 6pm signal for workers to go home.
		emit_signal("stop_work")
		
	print(time)
	
	if time > 6 and time <= 18:
		#something to set the time of day animation
		$AnimationPlayer.play() #Just example
		
	elif time <= 6 and time > 18:
		#something to set the time of night animation
		$AnimationPlayer.play() #Just example

func _exact_time():
	var format_string = "Day: %d, Time: %d" 
	var actual_string = format_string % [gameday, _moment_time(time)]

func _moment_time(time): #ex: 18.5 -> 18:30 and 18 -> 18:00
	if (time/2) != float(time/2):
		return time + ":00"
	else:
		return floor(time) + ":30"

func _get_callert():
	pass


