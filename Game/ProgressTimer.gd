class_name Progress extends Node2D
signal Progress_finish
@onready var timer = Timer.new()

var percent = 0;
var progress;

func set_up(t, caller):
	percent = t/100;
	timer.start(percent)
	timer.time_out.connect(add_progress)
	Progress_finish.connect(caller.on_progress_finish)

func add_progress():
	progress += 1
	if (progress == 100):
		Progress_finish.emit()
	
