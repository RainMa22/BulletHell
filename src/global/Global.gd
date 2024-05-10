extends Node

var current_boss:int

# BULLET COUNTER GLOBAL PROPERTY
var bullet_counter : int = 0:
	set(val):
		bullet_counter = val
		print(bullet_counter)
	get:
		return bullet_counter



# Called when the node enters the scene tree for the first time.
func _ready():
	current_boss = 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
