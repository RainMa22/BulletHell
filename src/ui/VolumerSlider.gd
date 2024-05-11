class_name VolumeSlider extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	ConfigManager.load_config()
	value = ConfigManager.current_config.master_volume



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_value_changed(value):
	# INCREMENT CONFIG
	ConfigManager.current_config.master_volume = value
	ConfigManager.save_config(ConfigManager.current_config)
