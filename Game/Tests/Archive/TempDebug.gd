extends Node2D
var path = []

func _draw():
	for point in path:
		draw_circle(point, 5, Color.DARK_RED)
