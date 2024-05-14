class_name PlayerStyleManager extends StyleManager

const REGULAR = preload("res://src/player/PlayerPointy.gdshader")
const DOODLE = null

var player_sprite: Sprite2D

func _init(player_sprite:Sprite2D):
	super._init()
	self.player_sprite = player_sprite
	
func _is_valid():
	return is_instance_valid(player_sprite)

func doodle_style():
	#if(DOODLE == null):
		#player_sprite.material = player_sprite.material.create_placeholder()
	#else:
	player_sprite.material.set_shader(DOODLE)
func default_style():
	player_sprite.material = ShaderMaterial.new()
	player_sprite.material.set_shader(REGULAR)
