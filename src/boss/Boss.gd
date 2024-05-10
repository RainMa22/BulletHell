extends Node2D

const PATTERN_DISABLED = -1
const PATTERN_ANIMATION = 0
const PATTERN_SHOOT_SPIRAL = 1
const PATTERN_SHOOT_RANDOM = 2
const TIME_PER_PATTERN = 5.0

#const RANDOM_BULLET_AMOUNT_PER_SEC = 100

var current_pattern: int
var pattern_time_remaining: float
var bullet = preload("res://src/bullet/Bullet.tscn")

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
	match current_pattern:
		PATTERN_DISABLED:
			pass # TODO
		PATTERN_ANIMATION:
			pass # TODO
		PATTERN_SHOOT_SPIRAL:
			pass # TODO	
		PATTERN_SHOOT_RANDOM:
			var rng = RandomNumberGenerator.new()
			var bullet_copy = bullet.instantiate();
			var direction = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
			bullet_copy.position = self.position
			bullet_copy.starting_direction = direction
			add_child(bullet_copy)
				
				
		
	
func next_pattern(pattern):
	match current_pattern:
		PATTERN_DISABLED:
			return PATTERN_SHOOT_RANDOM
		PATTERN_ANIMATION:
			return PATTERN_ANIMATION # TODO
		PATTERN_SHOOT_SPIRAL:
			return PATTERN_ANIMATION # TODO	
		PATTERN_SHOOT_RANDOM:
			return PATTERN_SHOOT_RANDOM # TODO	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_pattern(delta)
	pattern_time_remaining -= delta
	if pattern_time_remaining <= 0:
		current_pattern = next_pattern(current_pattern)
		var remainder = reset_time_remaining(delta)
		pattern_time_remaining -= remainder
		print("next")
	


