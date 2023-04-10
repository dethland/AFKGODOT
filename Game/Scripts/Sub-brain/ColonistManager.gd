extends Node
class_name ColonistManager

var unfinished_requests = [] # [[target_id, colonists_needed], ...]
var out_requests = [] # [[house_id, target_id, colonists_needed], ...]
var test_out_requests = [[2, 1, 2], [2, 1, 2]]

signal requst_assign_finished
	
func add_request(caller_id, colonists_needed):
	unfinished_requests.append([caller_id, colonists_needed])

func check_requests():
	for request in unfinished_requests:
		var colonists_needed = request[1]
		for house in FS.get_houses_list():
			if house is Facility:
				if house.ID == request[0]:
					continue
					
				var house_population = house.get_population()
				
				# enough colonists in house
				if house_population >= colonists_needed:
					out_requests.append([house.get_id(), request[0], colonists_needed])
					house.set_population(house_population - colonists_needed)
					break
				# need more colonists than in house
				else:
					colonists_needed -= house_population
					out_requests.append([house.get_id(), request[0], colonists_needed])
					house.set_population(0)
	unfinished_requests.clear()
	send_out_requests(null)


# send fufilled requests to houses
func send_out_requests(overide):
	if overide != null:
		out_requests = overide
	for request in out_requests:
		var house : Facility = FS.get_facility_by_id(request[0])
		house.add_to_colonist_queue(request.slice(1, 3))
		
	out_requests.clear()
	emit_signal("requst_assign_finished")

func _process(delta):
	pass
	if Input.is_action_just_pressed("test_button_4"):
		check_requests()
		print("unfinished colonist requst after check")
		print(unfinished_requests)
		print("----------")
