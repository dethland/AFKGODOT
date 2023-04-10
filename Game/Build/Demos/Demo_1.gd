extends Node2D

func _ready():
	for node in get_node("Buildings").get_children():
		get_node("SendResourceTimer").timeout.connect(node.send_requst_for_resource)
	get_node("SendResourceTimer").start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	TM.check_requests()



func _on_button_2_pressed():
	CM.check_requests()



