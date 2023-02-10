extends Node
class_name StatusGenerator

func check_food_crisis(world_data):
	var total_food = world_data.get_total_food();
	var colonists = world_data.get_colonists();
	var food_consume_rate = 50;
	return (colonists * food_consume_rate - total_food) < 50

func check_water_crisis(world_data):
	var total_water = world_data.get_total_water();
	var colonists = world_data.get_colonists();
	var water_consume_rate = 50;
	return (colonists * water_consume_rate - total_water) < 50

func check_housing_crisis(world_data):
	pass

func check_population_crisis(world_data):
	pass	

func generate_status_list(world_data):
	var status_list = []

	if check_food_crisis(world_data):
		status_list.append(Status.new("food_crisis", 1))
	if check_water_crisis(world_data):
		status_list.append(Status.new("water_crisis", 1))
	if check_housing_crisis(world_data):
		status_list.append(Status.new("housing_crisis", 2))
	if check_population_crisis(world_data):
		status_list.append(Status.new("population_crisis", 2))

	return status_list
