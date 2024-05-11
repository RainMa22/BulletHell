extends Button


func get_current_boss() -> int:
	return Global.current_boss

func generate_suffix(current_boss):
	var suffix = "th"
	if current_boss == 1:
		suffix = "st"
	elif current_boss ==2:
		suffix = "nd"
	return suffix

# Called when the node enters the scene tree for the first time.
func _ready():
	ConfigManager.load_config()
	Global.current_boss = ConfigManager.current_config.current_boss_number
	
	if Global.current_boss > 1:
		grab_focus() # SELECT for navigation with arrow keys or controller.
	else:
		disabled = true
		focus_mode = Control.FOCUS_NONE
	
	self.pressed.connect(self._button_pressed);
	var current_boss = get_current_boss()
	self.text = self.text.format(
		{
			"current_boss": current_boss,
			"suffix": generate_suffix(current_boss)
		}) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
