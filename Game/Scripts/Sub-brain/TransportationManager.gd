extends Node
class_name TransportationManager

var unfinished_requests = [] # [[target_id, resource_data], ...]
var out_requests = [] # [[sender_id, target_id, resource_data], ...]

func add_request(caller_id, resource_data:ResourceData):
	unfinished_requests.append([caller_id, resource_data])
	

func check_requests():
	for request in unfinished_requests:
		var quantity_needed = request[1].get_amount()
		for facility in FS.get_facilities_by_type():
			var facility_resource_data = facility.container.get_resource_data_by_name(request[1].get_name())
			var resource_amount = facility_resource_data.get_amount()
			
			# enough resources in facility
			if resource_amount >= quantity_needed:
				out_requests.append([facility.get_id(), request[0], request[1]])
				facility_resource_data.set_amount(resource_amount - quantity_needed)
				break
			# need more resources than in facility
			else:
				quantity_needed -= resource_amount
				out_requests.append([facility.get_id(), request[0], request[1]])
				facility_resource_data.set_amount(0)
	unfinished_requests.clear()
	send_out_requests()


# send fufilled requests to facilities
func send_out_requests(override=null):
	if override != null:
		for request in override:
			var facility = FS.get_facility_by_id(request[0])
			facility.send_resource_to(request[1], request[2])
	else:
		for request in out_requests:
			var facility = FS.get_facility_by_id(request[0])
			facility.send_resource_to(request[1], request[2])
			out_requests.clear()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("requst sent")
		var resource_data = ResourceData.new()
		resource_data.set_name("gold")
		resource_data.set_amount(20)
		var test_out_requests = [[1, 2, resource_data]]
		send_out_requests(test_out_requests)

