extends Node2D

const PATTERN_DISABLED = -1
const PATTERN_ANIMATION = 0
const PATTERN_SHOOT_SPIRAL = 1
const TIME_PER_PATTERN = 5000.0


var current_pattern: int
var pattern_time_remaining: float


# REQUIRES time_remaining < delta
# resets the time remaining to TIME_PER_PATTERN
# RETURNS delta - time_remaining
func reset_time_remaining(delta):
	var remainder = delta-pattern_time_remaining
	pattern_time_remaining = TIME_PER_PATTERN
	return remainder
		
# Called when the node enters the scene tree for the first time.
func _ready():
	current_pattern = -1
	reset_time_remaining(0)


func process_pattern(delta):
	pass# TODO
	
func next_pattern(pattern):
	pass# TODO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_pattern(delta)
	pattern_time_remaining -= delta
	if pattern_time_remaining <= 0:
		current_pattern = next_pattern(current_pattern)
		var remainder = reset_time_remaining(delta)
		pattern_time_remaining -= remainder
	


