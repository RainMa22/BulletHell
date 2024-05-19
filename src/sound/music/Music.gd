class_name Music extends AudioStreamPlayer

enum MusicType {GameMusic = 0, SoundEffects=1}

@export var game_music_streams: Array[AudioStream]
@export var sound_effects_streams: Array[AudioStream]
@export var type: MusicType = MusicType.GameMusic
# Called when the node enters the scene tree for the first time.
func _ready():
	ConfigManager.load_config()
	#volume_db = linear_to_db(ConfigManager.current_config.master_volume)
	if self.type == MusicType.GameMusic:
		self.finished.connect(load_stream)
		Global.style_changed.connect(load_stream)
	load_stream(true)
	
func load_stream(first_time:bool = false):
	var tween: Tween = create_tween();
	if(!first_time):
		tween.tween_property(self, "volume_db", -80,1.)
		tween.tween_callback(stop)
	match(type):
		MusicType.GameMusic:
			tween.tween_callback(load_game_music)
		MusicType.SoundEffects:
			tween.tween_callback(load_sound_effects)
	tween.tween_property(self, "volume_db", linear_to_db(ConfigManager.current_config.master_volume),0.)
	tween.tween_callback(play)
	
func load_game_music():
	self.stream = game_music_streams[int(clamp(Global.current_style, 0, game_music_streams.size()-1))]

func load_sound_effects():
	self.stream = sound_effects_streams[int(clamp(Global.current_style, 0, sound_effects_streams.size()-1))]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
