class_name CameraShakeGlobal extends Node

var main_camera: Camera

var allow_shake := true

@export var decay = 0.75  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(12, 12)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.5  # Maximum rotation in radians (use sparingly).

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

@onready var noise = FastNoiseLite.new()
var noise_y = 0

var back_kick = Vector2.ZERO

var final_offset = Vector2.ZERO
var final_rotation = 0

var camera_position = Vector2.ZERO

func ready():
	randomize()
	noise.seed = randi()
	noise.period = 1
	noise.octaves = 1
	
func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
	
func kick(amount):
	back_kick += amount

func _process(delta):
	final_offset = Vector2.ZERO
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	back_kick = back_kick.lerp(Vector2.ZERO, delta * 2.0)
	final_offset += back_kick


func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 5
	final_rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	final_offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed + 105.5, noise_y)
	final_offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed + 203.75, noise_y)
