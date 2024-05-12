class_name Camera extends Camera2D

var look_position := Vector2.ZERO

func _ready():
	CameraShake.main_camera = self
	look_position = global_position

func _process(delta):
	if CameraShake.allow_shake:
		global_position = look_position + CameraShake.final_offset
		rotation_degrees = CameraShake.final_rotation
	else:
		global_position = look_position
