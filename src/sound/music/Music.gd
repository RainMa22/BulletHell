class_name Music extends AudioStreamPlayer

enum MusicType {GameMusic = 0, SoundEffects=1}

@export var game_music_streams: Array[AudioStream]
@export var sound_effects_streams: Array[AudioStream]
@export var type: MusicType
# Called when the node enters the scene tree for the first time.
func _ready():
	ConfigManager.load_config()
	volume_db = linear_to_db(ConfigManager.current_config.master_volume)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
