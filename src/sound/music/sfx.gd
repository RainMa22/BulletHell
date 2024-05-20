extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	ConfigManager.load_config()
	volume_db = linear_to_db(ConfigManager.current_config.sfx_volume) - 15.0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
