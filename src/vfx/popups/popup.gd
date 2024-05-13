class_name TextPopup extends Node2D

@onready var main_text = $MainText

var text_content = "BEANS!"

var y_velocity := 8.0
var x_velocity := 4.0

var opacity := 1.0

var time_passed := 0.0
var time_before_fade := 1.0

func _ready():
	pass # Replace with function body.

func _process(delta):
	set_text(text_content)
	
	# Y VELOCITY
	y_velocity -= delta * 30
	global_position += Vector2(x_velocity * 0.02, -y_velocity * 3.0) * delta

	time_passed += delta
	if time_passed > time_before_fade:
		opacity -= delta
	
	modulate.a = opacity
	
	if opacity < 0:
		queue_free()

func set_text(str: String):
	var new_text = "[center]" + str + "[/center]"
	main_text.text = new_text
