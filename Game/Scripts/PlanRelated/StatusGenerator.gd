extends Node
class_name StatusGenerator

func check_food_crisis():
	pass

func check_water_crisis():
	pass

func check_housing_crisis():
	pass

func check_population_crisis():
	pass	

func generate_status_list(world_data):
	var status_list = []

	if check_food_crisis():
		status_list.append(Status.new("food_crisis", 1))
	if check_water_crisis():
		status_list.append(Status.new("water_crisis", 1))
	if check_housing_crisis():
		status_list.append(Status.new("housing_crisis", 2))
	if check_population_crisis():
		status_list.append(Status.new("population_crisis", 2))

	return status_list
