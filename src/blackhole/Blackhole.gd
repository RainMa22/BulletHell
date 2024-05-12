class_name Blackhole extends Node2D

@export var visual_radius_scale = 4.0;
@export var effect_radius_ratio = 0.25;
@export var startup_time = .3;

@onready var visual:Sprite2D = $Visual
@onready var hurtbox: BlackholeHurtBox = $BlackholeHurtBox

func _ready():
	visual.apply_scale(Vector2(visual_radius_scale,visual_radius_scale))
	hurtbox.set_scale(visual.scale*effect_radius_ratio)
	
func _process(delta):
	pass

func _physics_process(delta):
	pass
