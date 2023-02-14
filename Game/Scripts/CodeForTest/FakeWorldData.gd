extends Node

var world_data_dic = {
	"Food" : 10, 
	"Pop" : 5,
	"Water" : 20,
	"House" : 1,
	"PopNeed" : 7,
	
}

# this dictionary described a world with a base, a farm, few houses, a mining facility
# base : 2 pop, mining facility : 5 pop
# house : provide 5 pop with home

func get_total_food():
	return world_data_dic.Food
	
func get_total_water():
	return world_data_dic.Water
	
func get_population():
	return world_data_dic.Pop
	
func get_houses():
	return world_data_dic.House
	
func get_workers_needed():
	return world_data_dic.PopNeed
