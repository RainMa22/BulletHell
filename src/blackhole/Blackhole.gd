class_name Blackhole extends Node2D

@export var visual_radius_scale = 4.0;
@export var effect_radius_ratio = 0.2;
@export var spawn_pop_intensity = 0.1;
@export var spawn_time = .3;
@export var startup_time = .3;
@export var decay_time = 10.

@onready var visual: BlackHoleGravityBox = $BlackHoleGravityBox
@onready var hurtbox: BlackholeHurtBox = $BlackholeHurtBox

func _ready():
	var effect_radius = visual_radius_scale*effect_radius_ratio
	var tween_visual = create_tween()
	var tween_effect = create_tween()
	visual.event_horizon = effect_radius_ratio - .1
	tween_visual.tween_method(visual.set_scale, Vector2(0,0),
	Vector2(visual_radius_scale+spawn_pop_intensity,visual_radius_scale+spawn_pop_intensity), spawn_time)
	tween_effect.tween_method(hurtbox.set_scale, Vector2(0,0),
	Vector2(effect_radius+spawn_pop_intensity,effect_radius+spawn_pop_intensity), spawn_time)
	
	tween_visual.tween_method(visual.set_scale, 
	Vector2(visual_radius_scale+spawn_pop_intensity,visual_radius_scale+spawn_pop_intensity),
	Vector2(visual_radius_scale,visual_radius_scale), startup_time)
	tween_effect.tween_method(hurtbox.set_scale, 
	Vector2(effect_radius+spawn_pop_intensity,effect_radius+spawn_pop_intensity),
	Vector2(effect_radius,effect_radius), startup_time)
	tween_visual.tween_property(self, "scale", Vector2(0,0),decay_time)
	tween_visual.tween_callback(queue_free)
	
func _process(delta):
	#var bullet = await load("res://src/bullet/EnemyBullet.tscn")
	#var b :Bullet=bullet.instantiate()
	#b.position = Vector2(0, 400.);
	#b.disable_on_screen_detection = true
	#b.starting_direction = Vector2(.25, -1)
	#add_child(b);
	pass

func _physics_process(delta):
	pass
