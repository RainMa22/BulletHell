@tool class_name BackgroundGrid extends Node2D



#########################
# Fancy background grid #
# Dots everywhere.      #
#########################

@export_group("Dots")
@export var dot_color := Color.BLACK
@export var dot_radius := 5

@export_group("Grid")
@export var width := 100.0
@export var height := 200.0

@export var num_of_dots_x := 10
@export var num_of_dots_y := 20

@export_group("Parallax")
@export var parallax_x_factor := 0
@export var time_for_one_x_delta_scroll := 1.0
@export var parallax_y_factor := 1
@export var time_for_one_y_delta_scroll := 1.0

var x_scroll_delta := 0.0
var y_scroll_delta := 0.0

func _draw():
	# POSITIONAL DATA
	var x_separation : float = width / float(num_of_dots_x - 1) # Calculates the x delta between adjacent points.
	var y_separation : float = height / float(num_of_dots_y - 1) # Calculates the y delta between adjacent points.
	var origin : Vector2 = Vector2(-width / 2, -height / 2) # Finds the negative-most corner for the first dot.
	
	# PARALLAX CALCULATIONS
	var x_one_delta_progress := 0.0
	if parallax_x_factor != 0:
		x_one_delta_progress = x_scroll_delta / time_for_one_x_delta_scroll # from 0 to 1 based on how far one point should be offset in phase.
	var x_parallax_offset := x_separation * x_one_delta_progress * parallax_x_factor
	
	var y_one_delta_progress := 0.0
	if parallax_y_factor != 0:
		y_one_delta_progress = y_scroll_delta / time_for_one_y_delta_scroll # from 0 to 1 based on how far one point should be offset in phase.
	var y_parallax_offset := y_separation * y_one_delta_progress * parallax_y_factor
	
	for ix in range(0, num_of_dots_x):
		for iy in range(0, num_of_dots_y):
			var current_point : Vector2 = origin + Vector2(ix * x_separation, iy * y_separation)
			draw_circle(current_point + Vector2(x_parallax_offset, y_parallax_offset), dot_radius, dot_color) # Draw dots at each point from indexes 0 to num_of_dots on both dimensions.

func _process(delta):
	if Engine.is_editor_hint(): # For @Tool, ensure rerendering during engine testing.
		queue_redraw()
	else: # In the actual game, do parallax scrolling.
		process_parallax(delta)

func process_parallax(delta):
	x_scroll_delta += delta
	y_scroll_delta += delta
	while x_scroll_delta >= time_for_one_x_delta_scroll:
		x_scroll_delta -= time_for_one_x_delta_scroll
	while y_scroll_delta >= time_for_one_y_delta_scroll:
		y_scroll_delta -= time_for_one_y_delta_scroll
	queue_redraw()
