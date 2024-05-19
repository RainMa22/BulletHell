class_name Player extends CharacterBody2D



########################################
# PLAYER SCRIPT                        #   
# Main player movement, shooting, etc. #
# The spaceship that the player is.    #
########################################

# INPUTS
var input_directional_vector : Vector2 = Vector2.ZERO
var is_shooting := false

# MOVEMENT
var target_velocity_vector : Vector2 = Vector2.ZERO

var movement_speed : float = 300
var acceleration : float = 1800
var deceleration : float = 1500

# SHOOTING
var bullet = preload("res://src/bullet/PlayerBullet.tscn")
var explosion = preload("res://src/vfx/Explosion.tscn")

var style_manager: StyleManager
var can_shoot := true
var shoot_cooldown = 0.2 # in seconds

# COMPONENTS
@onready var health : Health = $Health
@onready var shoot_timer : Timer = $ShootTimer
@onready var ship: Sprite2D = $Ship1


func _ready():
	style_manager = PlayerStyleManager.new(ship)
	style_manager.on_style_change()
	health.max_health = 15
	health.health = 15
	pass

func _process(delta):
	update_inputs()
	
	look_at(global_position + Vector2.RIGHT * 1000 + Vector2.DOWN * velocity.x) # LEAN TOWARDS X-AXIS MOVEMENT (scuffed fix sometime)
	
	# LOOP AT EDGES (make thing go around when reach the sides)
	if global_position.x > 275:
		global_position.x -= 550
	elif global_position.x < -275:
		global_position.x += 550
	
	# CLAMP BOTTOM OF SCREEN
	global_position.y = clamp(global_position.y, -get_viewport().size.y/2, get_viewport().size.y/2) # DON'T HARDCODE VARIABLES?

func update_inputs() -> void:
	input_directional_vector = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")) # Grab the inputs based on what the player is doing.
	# print(input_directional_vector)
	is_shooting = Input.is_action_pressed("Shoot")



func _on_shoot_timer_timeout():
	can_shoot = true
func update_shooting() -> void:
	if is_shooting and can_shoot and not health.is_dead:
		var bullet_instance : Bullet = bullet.instantiate() #  as Bullet # INSTANTIATE A BULLET
		
		bullet_instance.starting_speed = 800 # SET SPEED
		bullet_instance.starting_direction = global_position.direction_to($BulletSpawnPoint.global_position) # DIRECT IT TOWARDS SOMEWHERE
		
		get_parent().add_child(bullet_instance) # ADD TO TREE
		
		var new_explosion = explosion.instantiate()
		get_parent().add_child(new_explosion)
		
		CameraShake.kick(Vector2.DOWN * 3.2)
		CameraShake.add_trauma(0.01)
		
		bullet_instance.global_position = $BulletSpawnPoint.global_position # Spawn bullet at that point. # SET POSITION TO SPAWN POINT
		new_explosion.global_position = $BulletSpawnPoint.global_position
		
		can_shoot = false # COOLDOWN!
		shoot_timer.start(shoot_cooldown)



func _physics_process(delta):
	update_shooting()
	update_physics_movement(delta)

func update_physics_movement(delta) -> void:
	target_velocity_vector = input_directional_vector * movement_speed # The target vector we want to accelerate to.
	
	# Smoothing out velocity motion by accelerating or decelerating towards the target value.
	if abs(target_velocity_vector.x) < abs(velocity.x): # Decelerate towards x-value
		velocity = Vector2(move_toward(velocity.x, target_velocity_vector.x, deceleration * delta), velocity.y)
	elif abs(target_velocity_vector.x) > abs(velocity.x): # Accelerate towards x-value
		velocity = Vector2(move_toward(velocity.x, target_velocity_vector.x, acceleration * delta), velocity.y)
	
	# Same thing for the Y-axis
	if abs(target_velocity_vector.y) < abs(velocity.y): 
		velocity = Vector2(velocity.x, move_toward(velocity.y, target_velocity_vector.y, deceleration * delta))
	elif abs(target_velocity_vector.y) > abs(velocity.y):
		velocity = Vector2(velocity.x, move_toward(velocity.y, target_velocity_vector.y, acceleration * delta))
	
	move_and_slide() # UPDATE movement!



# HEALTH.
func hit_by_bullet(bullet : Bullet):
	health.health -= bullet.damage # Take the damage.
	Global.popup_manager.create_popup(str(bullet.damage), bullet.global_position, bullet.velocity.x)
	CameraShake.add_trauma(0.2)
	if bullet.allow_invincibility_frames:
		health.start_invincibility() # Run a invincibility time.
		
	# TODO: Flash the player visual/other animation upon hit.
	# TODO: Screen shake/Screen kick

# DEATH.
func _on_health_on_died():
	CameraShake.kick(Vector2.DOWN * 10.0)
	CameraShake.add_trauma(0.5)
	queue_free()
