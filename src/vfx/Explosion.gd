class_name Explosion extends Node2D

var rand_scale := 1.0

func _ready():
	rand_scale = randf_range(0.8, 1.0)
	$Circle.material.set_shader_parameter("change_frequency", 5)
	update_scale()
	explosion_time = randf_range(0.1, 0.25)

var time_elapsed := 0.0
var explosion_time := 0.15

func update_scale():
	$Circle.material.set_shader_parameter("scale", rand_scale * (1.0-time_elapsed/explosion_time))

func _process(delta):
	time_elapsed += delta
	update_scale()
	if time_elapsed >= explosion_time:
		delete_lmao()

func delete_lmao():
	queue_free()
