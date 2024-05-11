class_name Enemy extends CharacterBody2D

var patterns = null
var state
var health : Health


func _ready():
	health = $Health
	state = 0
	health.on_died.connect(_on_health_on_died)

func get_pattern_rate():
	push_error("Please Override get_pattern_rate")
	return NAN

func get_firerate():
	push_error("Please Override get_firerate")
	return NAN

func _on_health_on_died():
	var tween: Tween = self.create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.3)
	# TODO: Spawn Explosions or something
	tween.tween_callback(queue_free)

# Takes a variety, a Array of vector2s of size >= NUM_STATES, and a Array of vector2s of size >= NUM_STATES
# returns variety sized times_per_pattern times_per_bullet and patterns
func randomize(variety:int, pattern_time_variance, bullet_rate_variance, difficulty_scaling = 1.0):
	patterns = []
	var time_per_pattern = get_pattern_rate()
	var time_per_bullet = get_firerate() * difficulty_scaling
	var rng = RandomNumberGenerator.new()
	
	ConfigManager.load_config()
	Global.current_boss = ConfigManager.current_config.current_boss_number
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
		
