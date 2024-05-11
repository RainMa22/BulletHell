class_name Bullet extends Area2D



###############
# BULLET      #
# The bullet. #
###############

@export var is_enemy := false

# Damage stats!

@export var damage := 1
@export var should_disappear_after_collision := true

# Remember to set position, direction, and speed!
var starting_direction := Vector2.UP
var starting_speed := 200

var velocity := Vector2.ZERO

@onready var expire_timer : Timer = $ExpireTimer
const expire_time = 0.1



# INITALISATION
func _ready():
	Global.bullet_counter += 1
	
	init_starting_velocity()
func _enter_tree():
	init_starting_velocity()

func init_starting_velocity() -> void:
	velocity = starting_speed * starting_direction # Set the velocity upon entering the tree.



# MOVEMENT
func _process(delta):
	# LOOP AT EDGES (make thing go around when reach the sides)
	# if global_position.x > 275:
	# 	global_position.x -= 250 + 275
	# elif global_position.x < -275:
	# 	global_position.x += 250 + 275
	pass

func _physics_process(delta):
	position += velocity * delta # Adding to position to move the bullet in linear fashion.



# TODO: Add collision of bullet with other entities (player or enemy or boss)
func _on_body_entered(body):
	collide_with_body(body)
func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	collide_with_body(body)

func collide_with_body(body):
	if body.has_method("hit_by_bullet"): # Call the hit method on the body!
		body.hit_by_bullet(self)
	if should_disappear_after_collision: # Disappear if I should, otherwise rely on I-FRAMES from the body in question.
		destroy_self()



# DELETING PROCESS
func destroy_self():
	Global.bullet_counter -= 1
	queue_free()

func _on_on_screen_notifier_screen_exited():
	expire_timer.start(expire_time)
func _on_expire_timer_timeout():
	destroy_self()


