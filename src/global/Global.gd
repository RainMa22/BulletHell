extends Node

var current_boss : int

# BULLET COUNTER GLOBAL PROPERTY
signal bullet_counter_increased(new_value)
signal bullet_counter_decreased(new_value)
var bullet_counter : int = 0:
	set(val):
		if val > bullet_counter:
			bullet_counter_increased.emit(val) # Increase, emit signal.
		elif val < bullet_counter:
			bullet_counter_decreased.emit(val) # Decrease, emit signal.
		
		bullet_counter = val # Assign bullet count
		
		# print(bullet_counter) # DEBUG: print bullet counter
	get:
		return bullet_counter

var chaos_value := 0.0 # A value proportional to the number of bullets on screen.

func _ready():
	current_boss = 1

func _process(delta):
	chaos_value = float(bullet_counter) / 100
