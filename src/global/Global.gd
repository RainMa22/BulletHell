extends Node

var current_boss : int
enum Style {DOODLE=0, REGULAR=1}
var current_style: Style = Style.DOODLE;
var current_time: float;

#STYLE MANAGEMENT
signal style_changed(new_style)
@onready var style_change_cooldown = 0;
const STYLE_CHANGE_INTERVAL = 3.;
func change_style(style = null):
	if style_change_cooldown > 0 : return
	if style == null:
		style = current_style
		var rng = RandomNumberGenerator.new()
		while(style == current_style):
			style = Style.values()[rng.randi_range(0,Style.size()-1)]
			#print("changing style to {style}!".format({"style": style}))
	style_change_cooldown += STYLE_CHANGE_INTERVAL
	current_style = style;
	style_changed.emit(style)


# BULLET COUNTER GLOBAL PROPERTY
signal bullet_counter_increased(new_value)
signal bullet_counter_decreased(new_value)
var bullet_counter : int = 0:
	set(val):
		
		chaos_value = float(val) / 90 # UPDATE THE CHAOS VALUE with the new value
		
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
	current_time = 0.
	current_boss = 1

func _process(delta):
	current_time += delta
	style_change_cooldown = max(0, style_change_cooldown - delta)
