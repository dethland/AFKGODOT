extends Node
class_name TransporteManager

var unfinished_requests = [] # [[target_id, resource_data], ...]
var out_requests = [] # [[sender_id, target_id, resource_data], ...]

signal requst_assign_finished

func add_request(caller_id, resource_data:ResourceData):
	unfinished_requests.append([caller_id, resource_data])
	

func check_requests():
	for request in unfinished_requests:
		var quantity_needed = request[1].get_amount()
		for facility in FS.get_facilities_by_type():
			# skip if target facility
			if facility.ID == request[0]:
				continue
				
			var facility_resource_data = facility.container.get_resource_data_by_name(request[1].get_name())
			if facility_resource_data == null:
				continue
				
			var resource_amount = facility_resource_data.get_amount()
			
			# enough resources in facility
			if resource_amount >= quantity_needed:
				out_requests.append([facility.get_id(), request[0], request[1]])
				facility_resource_data.set_amount(resource_amount - quantity_needed)
				quantity_needed = 0
				break
			# need more resources than in facility
			else:
				quantity_needed -= resource_amount
				request[1].set_amount(resource_amount)
				out_requests.append([facility.get_id(), request[0], request[1]])
				facility_resource_data.set_amount(0)
		
	unfinished_requests.clear()

	print("unfinished:")
	for r in unfinished_requests:
		print(str(r[0]) + " " + str(r[1].get_amount()))
	print("out:")
	print(out_requests)
	send_out_requests()


# send fufilled requests to facilities
func send_out_requests(override=null):
	print("send out- called")
	if override != null:
		for request in override:
			var facility = FS.get_facility_by_id(request[0])
			facility.add_to_colonist_queue([request[1], 1], request[2])
	else:
		for request in out_requests:
			var facility = FS.get_facility_by_id(request[0])
			facility.add_to_colonist_queue([request[1], 1], request[2])
			out_requests.clear()
			
	emit_signal("requst_assign_finished")
	print("emit the signal")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("requst sent")
		var resource_data = ResourceData.new()
		resource_data.set_name("gold")
		resource_data.set_amount(20)
		var test_out_requests = [[1, 2, resource_data]]
#		send_out_requests(test_out_requests)
	if Input.is_action_just_pressed("test_button_1"):
		var resource_data = ResourceData.new()
		resource_data.set_name("iron_ore")
		resource_data.set_amount(20)
		add_request(1, resource_data)
		print(unfinished_requests)
	if Input.is_action_just_pressed("test_button_2"):
		check_requests()
