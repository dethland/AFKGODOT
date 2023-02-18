extends Node
class_name TransportationManager

var unfinished_requests = [] # [[target_id, resource_data], ...]
var out_requests = [] # [[sender_id, target_id, resource_data], ...]

func add_request(caller_id, resource_data:ResourceData):
	unfinished_requests.append([caller_id, resource_data])
	

func check_requests():
	for request in unfinished_requests:
		var quantity_needed = request[1]
		for facility in facilities:
			var resource_amount = house.get_resource_amount(resource_data)
			
			# enough resources in facility
			if resource_amount >= quantity_needed:
				out_requests.append([facility.get_id(), request[0], request[1]])
				facility.set_resource_amount(resource_data.get_id(), resource_amount - quantity_needed)
				break
			# need more resources than in facility
			else:
				quantity_needed -= resource_amount
				out_requests.append([facility.get_id(), request[0], colonists_needed])
				facility.set_resource_amount(resource_data.get_id(), 0)
	unfinished_requests.clear()
	send_out_requests()


# send fufilled requests to facilities
func send_out_requests():
	for request in out_requests:
		var facility = FacilityServer.get_facility(request[0])
		facility.send_resource_to(request[1], request[2])
	out_requests.clear()

