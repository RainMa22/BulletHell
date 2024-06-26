class_name Glitch extends Node2D

@onready var RED = $RED
@onready var GREEN = $GREEN
@onready var BLUE = $BLUE
var sfx_stream: AudioStreamOggVorbis = PreloadedResources.GLITCH_SFX;

signal finished
func _ready():
	var tween : Tween = create_tween()
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = sfx_stream
	player.volume_db = -10 + linear_to_db(ConfigManager.current_config.sfx_volume)
	add_child(player)
	for nod in [RED,GREEN,BLUE]:
		tween.tween_interval(0.05)
		tween.tween_callback(func(): nod.visible = true)
		tween.tween_interval(0.025)
		tween.tween_callback(func(): nod.visible = false)
	tween.tween_interval(0.05)
	tween.tween_callback(
		func(): 
			RED.visible = true
			GREEN.visible = true
			BLUE.visible =true)
	tween.tween_interval(0.025)
	tween.tween_callback(
		func():
			RED.visible = false
			GREEN.visible = false
			BLUE.visible =false 
			finished.emit())
	player.finished.connect(func(): tween.tween_callback(queue_free))
	player.play()
	
		
func _proc(_delta):
	pass
