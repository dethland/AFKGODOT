extends Node
class_name StatusGenerator

func check_food_crisis(world_data):
	var total_food = world_data.get_total_food()
	var population = world_data.get_population()
	var food_consume_rate = 50
	return (population * food_consume_rate - total_food) < food_consume_rate

func check_water_crisis(world_data):
	var total_water = world_data.get_total_water()
	var population = world_data.get_population()
	var water_consume_rate = 50
	return (population * water_consume_rate - total_water) < water_consume_rate

func check_housing_crisis(world_data):
	var population = world_data.get_population()
	var houses = world_data.get_houses()
	var house_capacity = 5
	return (houses * house_capacity) < population

func check_population_crisis(world_data):
	var workers_needed = world_data.get_workers_needed()
	var population = world_data.get_num_colonists()
	return population < workers_needed

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
