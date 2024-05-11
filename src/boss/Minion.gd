class_name Minion extends Enemy


var health_value: int
var variety: int
var difficulty: int

func get_pattern_rate():
	return 5

func get_firerate():
	return .5

func _init(health_value:int = 10, variety: int = 3, difficulty: float=1.0):
	self.health_value = health_value
	self.variety = variety
	self.difficulty = difficulty
	
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	health = $Health
	self.health.max_health = health_value
	self.health.health = health_value
	self.randomize(variety, 3, 0, difficulty)
	patterns = [RandomPattern.new(self,get_pattern_rate(),get_firerate())]

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
	health.health -= bullet.damage # Take damage.
	if bullet.allow_invincibility_frames:
		health.start_invincibility() # Run a invincibility time.
	
	# TODO: Flash the player visual/other animation upon hit.
func _on_health_on_died():
	# TODO: magnificent death animation.
	
	Global.current_boss += 1
	
	# INCREMENT CONFIG
	ConfigManager.current_config.current_boss_number = Global.current_boss
	ConfigManager.save_config(ConfigManager.current_config)
	
	queue_free()
