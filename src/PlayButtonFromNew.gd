extends Button


func reset_progress():
	ConfigManager.current_config.current_boss_number = 1
	ConfigManager.save_config(ConfigManager.current_config)
	Global.current_boss = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self._button_pressed)
	
	ConfigManager.load_config()
	Global.current_boss = ConfigManager.current_config.current_boss_number
	
	if Global.current_boss <= 1:
		grab_focus() # SELECT for navigation with arrow keys or controller.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _button_pressed():
	reset_progress()
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
