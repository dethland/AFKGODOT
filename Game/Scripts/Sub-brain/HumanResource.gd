extends Node
class_name HumanResource

var unfinished_requests = []

#testing
var houses = []

func add_request(caller_id, colonists_needed):
	unfinished_requests.append([caller_id, colonists_needed])

func check_requests():
	for request in unfinished_requests:
		var colonists_needed = request[1]
		for house in houses:
			if house.population() >= colonists_needed:
				for colonist in house.get_colonists():
					colonist.work_place_id
