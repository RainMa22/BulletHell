class_name Boss extends Enemy

var variety: int
var difficulty:float
@onready var body: Sprite2D = $body
@export var outline_color: Color = Color("de446d")
@export var body_color: Color = Color.WHITE

var stylemanager: StyleManager;
func get_pattern_rate():
	return 5

func get_firerate():
	return .02

func _init(variety:int = 50, difficulty: float = -1.0):
	self.variety = variety
	self.difficulty = difficulty
	
	

	
func set_difficulty(difficulty:float = -1.0):
	if(difficulty == -1.0):
		difficulty = Global.calculate_difficulty()
	health.max_health = 80/difficulty
	health.health = health.max_health
	self.difficulty = difficulty
	self.randomize(variety, 0, 0, difficulty)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	patterns = [RandomPattern.new(self,get_pattern_rate(),get_firerate())]
	set_difficulty(self.difficulty)
	self.stylemanager = BossStyleManager.new(body,outline_color,body_color)
	stylemanager.on_style_change()

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
	Global.popup_manager.create_popup(str(bullet.damage), bullet.global_position, bullet.velocity.x)
	CameraShake.add_trauma(0.1)
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
