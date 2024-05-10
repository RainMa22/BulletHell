class_name Player extends CharacterBody2D



########################################
# PLAYER SCRIPT                        #   
# Main player movement, shooting, etc. #
# The spaceship that the player is.    #
########################################

# INPUTS
var input_directional_vector : Vector2 = Vector2.ZERO

# MOVEMENT
var target_velocity_vector : Vector2 = Vector2.ZERO

var movement_speed : float = 500
var acceleration : float = 800
var deceleration : float = 1000

func _ready():
	pass

func _process(_delta):
	update_inputs()

func update_inputs() -> void:
	input_directional_vector = Input.get_vector("Left", "Right", "Up", "Down", -0.5) # Grab the inputs based on what the player is doing.



func _physics_process(delta):
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
