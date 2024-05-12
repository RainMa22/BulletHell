class_name Explosion extends Node2D

var rand_scale := 1

func _ready():
	rand_scale = randf_range(1,3)
	$Circle.material.set_shader_parameter("change_frequency", 5)
	update_scale()

var time_elapsed := 0.0
const explosion_time := 0.1

func update_scale():
	var cur_scale = Vector2((1.0-time_elapsed/explosion_time), (1.0-time_elapsed/explosion_time))
	$Circle.material.set_shader_parameter("scale", (1.0-time_elapsed/explosion_time))

func _process(delta):
	time_elapsed += delta
	update_scale()
	if time_elapsed >= explosion_time:
		delete_lmao()

func delete_lmao():
	queue_free()
