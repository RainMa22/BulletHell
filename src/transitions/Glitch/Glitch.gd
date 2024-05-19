class_name Glitch extends Node2D

@onready var RED = $RED
@onready var GREEN = $GREEN
@onready var BLUE = $BLUE

signal finished
func _ready():
	var tween : Tween = create_tween()
	for nod in [RED,GREEN,BLUE]:
		tween.tween_interval(0.05)
		tween.tween_callback(func(): nod.visible = true)
		tween.tween_interval(0.025)
		tween.tween_callback(func(): nod.visible = false)
	tween.tween_interval(0.05)
	tween.tween_callback(
		func(): 
			RED.visible = true
			GREEN.visible = true
			BLUE.visible =true
			finished.emit()
			)
	tween.tween_interval(0.05)
	tween.tween_callback(
		func(): 
			finished.emit()
			queue_free())
	
		
func _proc(_delta):
	pass
