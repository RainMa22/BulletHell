class_name Boss extends CharacterBody2D

const DEFAULT_PATTERN_RATE= 5
const DEFAULT_FIRERATE= .02

var patterns = null
var state
var health: Health

var bullet = preload("res://src/bullet/EnemyBullet.tscn")

# Takes a variety, a Array of vector2s of size >= NUM_STATES, and a Array of vector2s of size >= NUM_STATES
# returns variety sized times_per_pattern times_per_bullet and patterns
func randomize(variety:int, pattern_time_variance, bullet_rate_variance, difficulty_scaling = 1.0):
	patterns = []
	var time_per_pattern = DEFAULT_PATTERN_RATE
	var time_per_bullet = DEFAULT_FIRERATE * difficulty_scaling
	var rng = RandomNumberGenerator.new()
	rng.set_seed(Global.current_boss)
	for i in range(variety):
		var num = rng.randi_range(0,3)
		var pattern_time = time_per_pattern + randf_range(-pattern_time_variance/2,pattern_time_variance/2)
		var firerate = time_per_bullet + randf_range(-bullet_rate_variance/2,bullet_rate_variance/2)
		var pattern = Pattern.new(self, 0.2,firerate)
		if(num == 1):
			pattern = RandomPattern.new(self,pattern_time,firerate)
		else:
			pattern = SpiralPattern.new(self, pattern_time,firerate, 
			randi_range(SpiralPattern.SPIRAL_MIN, SpiralPattern.SPIRAL_MAX),rng.randi_range(0,1) == 1)
		patterns.append(pattern)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	health = $Health
	state = 0
	patterns = [RandomPattern.new(self,DEFAULT_PATTERN_RATE,DEFAULT_FIRERATE)]
	self.randomize(50, 0, 0)


func process_pattern(delta):
	var current_pattern = patterns[state]
	current_pattern._process_pattern(delta)

func on_pattern_done():
	state = (state+1) % len(patterns)
	patterns[state].reset()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_pattern(delta)
		



# HEALTH.
func hit_by_bullet(bullet : Bullet):
	health.health -= 1

