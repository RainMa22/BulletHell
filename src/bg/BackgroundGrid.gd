@tool class_name BackgroundGrid extends Node2D



#########################
# Fancy background grid #
# Dots everywhere.      #
#########################

@export var dot_color := Color.BLACK
@export var dot_radius := 5

@export var width := 100.0
@export var height := 200.0

@export var num_of_dots_x := 10
@export var num_of_dots_y := 20

@export var time_for_one_delta_scroll := 1.0

var scroll_delta := 0.0

func _draw():
	var x_separation : float = width / float(num_of_dots_x - 1) # Calculates the x delta between adjacent points.
	var y_separation : float = height / float(num_of_dots_y - 1) # Calculates the y delta between adjacent points.
	
	var origin : Vector2 = Vector2(-width / 2, -height / 2) # Finds the negative-most corner for the first dot.
	
	for ix in range(0, num_of_dots_x):
		for iy in range(0, num_of_dots_y):
			var current_point : Vector2 = origin + Vector2(ix * x_separation, iy * y_separation)
			draw_circle(current_point + (scroll_delta/time_for_one_delta_scroll) * -Vector2.UP * y_separation, dot_radius, dot_color) # Draw dots at each point from indexes 0 to num_of_dots on both dimensions.

func _process(delta):
	if Engine.is_editor_hint(): # For @Tool, ensure rerendering during engine testing.
		queue_redraw()
	else: # In the actual game, do parallax scrolling.
		process_parallax(delta)

func process_parallax(delta):
	scroll_delta += delta
	while scroll_delta >= time_for_one_delta_scroll:
		scroll_delta -= time_for_one_delta_scroll
	queue_redraw()
