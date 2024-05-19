@tool extends Node

const BLACKHOLE_TRIGGER_DEVICE = preload("res://src/blackhole/BlackholeTriggerDevice.tscn")
const game = preload("res://scenes/Game.tscn")
var popup_manager : PopupManager

var current_game : Game

var current_boss : int
enum Style {DOODLE=0, REGULAR=1}
#var current_style: Style = Style.DOODLE;
var current_style: Style = Style.REGULAR;
var current_time: float;

#Gameover stats
var gameover_stats:Dictionary = {}; 
func get_pb():
	return ConfigManager.current_config.personal_best

func get_peanut_butter():
	return get_pb()

func reset_progress():
	ConfigManager.current_config.current_boss_number = 1
	ConfigManager.save_config(ConfigManager.current_config)
	Global.current_boss = 1
	current_style = Style.REGULAR;

#STYLE MANAGEMENT
signal style_changed
func change_style(style = null):
	if style == null:
		style = current_style
		var rng = RandomNumberGenerator.new()
		while(style == current_style):
			style = Style.values()[rng.randi_range(0,Style.size()-1)]
			#print("changing style to {style}!".format({"style": style}))
	current_style = style;
	style_changed.emit()

#BOSS DIFFICULTY CALCULATION
func calculate_difficulty():
	return 1/(current_boss**0.1) 
	
#BLACKHOLE
func summon_blackhole(parent:Node = get_tree().get_root()):
	var blackhole = BLACKHOLE_TRIGGER_DEVICE.instantiate()
	blackhole.set_target(Vector2(0,0))
	current_game.add_child(blackhole)

#ON RAM FULL
func _on_ram_full():
	summon_blackhole()
	change_style()
	

# BULLET COUNTER GLOBAL PROPERTY
signal bullet_counter_increased(new_value)
signal bullet_counter_decreased(new_value)
var default_ram_max_value = 95
func get_ram_max_value():
	return round(95/calculate_difficulty())

var bullet_counter : int = 0:
	set(val):
		
		chaos_value = float(val) / get_ram_max_value() # UPDATE THE CHAOS VALUE with the new value
		
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
