class_name Boss extends Node2D

const PATTERN_DISABLED = 0
const PATTERN_ANIMATION = 0
const PATTERN_SHOOT_SPIRAL = 1
const PATTERN_SHOOT_RANDOM = 2
const NUM_STATES = 3
const DEFAULT_TIMES_PER_PATTERN = [5]
const DEFAULT_TIMES_PER_BULLET = [.2]
const DEFAULT_PATTERNS = [PATTERN_SHOOT_RANDOM]


var times_per_pattern = null
var times_per_bullet = null
var patterns = null
var state = 0

var delta_accumulator = 0.0

var pattern_time_accumulator= 0.0
var bullet = preload("res://src/bullet/Bullet.tscn")

# Takes a variety, a Array of vector2s of size >= NUM_STATES, and a Array of vector2s of size >= NUM_STATES
# returns variety sized times_per_pattern times_per_bullet and patterns
func randomize(variety:int, time_range_per_pattern:Array, time_range_per_bullet: Array):
	patterns = []
	times_per_pattern = []
	times_per_bullet = []
	var rng = RandomNumberGenerator.new()
	for i in range(variety):
		#var pattern = rng.randi_range(0, NUM_STATES-1)
		var pattern = 0 if i%2 else 2
		patterns.append(pattern)
		times_per_pattern.append(rng.randf_range(time_range_per_pattern[pattern].x,time_range_per_pattern[pattern].y))
		times_per_bullet.append(rng.randf_range(time_range_per_bullet[pattern].x,time_range_per_bullet[pattern].y))
	for arr in [patterns,times_per_pattern,times_per_bullet]:
		print(arr)
		
func get_times_per_pattern():
	return DEFAULT_TIMES_PER_PATTERN if (times_per_pattern == null) else times_per_pattern
func get_times_per_bullet():
	return DEFAULT_TIMES_PER_BULLET if (times_per_bullet == null) else times_per_bullet
func get_patterns():
	return DEFAULT_PATTERNS if (patterns == null) else patterns
		
# Called when the node enters the scene tree for the first time.
func _ready():
	state = 0
	pattern_time_accumulator = 0
	self.randomize(5, [Vector2(.5,1),Vector2(0,0),Vector2(.5,1)],
	[Vector2(0,0),Vector2(0,0),Vector2(.1,.1)])


func process_pattern(delta):
	var current_pattern = get_patterns()[state]
	match current_pattern:
		PATTERN_DISABLED:
			return # TODO
		PATTERN_ANIMATION:
			return # TODO
		PATTERN_SHOOT_SPIRAL:
			return # TODO	
		PATTERN_SHOOT_RANDOM:
			delta_accumulator += delta
			if delta_accumulator > get_times_per_bullet()[state]:
				delta_accumulator -= get_times_per_bullet()[state]
				var rng = RandomNumberGenerator.new()
				var bullet_copy = bullet.instantiate();
				var direction = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
				bullet_copy.starting_direction = direction
				add_child(bullet_copy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_pattern(delta)
	pattern_time_accumulator += delta
	if pattern_time_accumulator >= get_times_per_pattern()[state]:
		pattern_time_accumulator -= get_times_per_pattern()[state]
		state = (state+1) % len(get_patterns())
	


