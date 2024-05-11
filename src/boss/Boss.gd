class_name Boss extends Enemy

var variety: int
var difficulty:float

func get_pattern_rate():
	return 5

func get_firerate():
	return .02

func _init(variety:int = 50, difficulty: float = 1.0):
	self.variety = variety
	self.difficulty = difficulty

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	health.max_health = 100
	health.health = 100
	patterns = [RandomPattern.new(self,get_pattern_rate(),get_firerate())]
	self.randomize(variety, 0, 0, difficulty)
	



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
	super._on_health_on_died()
	Global.current_boss += 1
	
	# INCREMENT CONFIG
	ConfigManager.current_config.current_boss_number = Global.current_boss
	ConfigManager.save_config(ConfigManager.current_config)
	
	#queue_free()
