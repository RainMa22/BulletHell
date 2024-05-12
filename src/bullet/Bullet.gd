class_name Bullet extends Area2D



###############
# BULLET      #
# The bullet. #
###############

# TODO: Different visual styles/speeds/variations for bullets, different visuals corresponding to different effects.

# Damage stats!

@export var damage := 1
@export var should_disappear_after_collision := true
@export var allow_invincibility_frames := true
@export var disable_on_screen_detection := false

# Remember to set position, direction, and speed!
var starting_direction := Vector2.UP
var starting_speed := 200

var velocity := Vector2.ZERO

var style_manager: StyleManager
@onready var screen_notifier : VisibleOnScreenNotifier2D = $OnScreenNotifier
@onready var body: Sprite2D = $Circle2
@onready var outline: Sprite2D = $Circle

# INITALISATION
func _ready():
	Global.bullet_counter += 1
	init_starting_velocity()
	style_manager = BulletStyleManager.new(body, outline)
	style_manager.on_style_change()
	
func _enter_tree():
	init_starting_velocity()

func init_starting_velocity() -> void:
	velocity = starting_speed * starting_direction # Set the velocity upon entering the tree.
	look_at(global_position + velocity * 10.)



# MOVEMENT
func _process(delta):
	# LOOP AT EDGES (make thing go around when reach the sides)
	# if global_position.x > 275:
	# 	global_position.x -= 250 + 275
	# elif global_position.x < -275:
	# 	global_position.x += 250 + 275
	look_at(global_position + velocity * 10.)
	style_manager._process(delta)



func _physics_process(delta):
	position += velocity * delta # Adding to position to move the bullet in linear fashion.
	if not (screen_notifier.is_on_screen() or disable_on_screen_detection):
		destroy_self()


# COLLISION WITH BODIES (Player and Bosses, Enemies)
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
