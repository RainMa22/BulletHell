class_name Player extends Node2D



########################################
# PLAYER SCRIPT                        #   
# Main player movement, shooting, etc. #
# The spaceship that the player is.    #
########################################

# INPUTS
var input_directional_vector : Vector2 = Vector2.ZERO

# MOVEMENT
var movement_speed : float = 500

func _ready():
	pass

func _process(delta):
	update_inputs()
	update_movement(delta)

func update_inputs() -> void:
	input_directional_vector = Input.get_vector("Left", "Right", "Up", "Down", -0.5)

func update_movement(delta):
	position += input_directional_vector * movement_speed * delta
