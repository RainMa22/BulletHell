class_name Bullet extends Area2D



###############
# BULLET      #
# The bullet. #
###############

var starting_direction := Vector2.UP
var starting_speed := 200

var velocity := Vector2.ZERO



func _ready():
	position = Vector2(0, 0)
	init_bullet()

func init_bullet() -> void:
	velocity = starting_direction * starting_speed



func _process(delta):
	pass

func _physics_process(delta):
	position += velocity * delta
