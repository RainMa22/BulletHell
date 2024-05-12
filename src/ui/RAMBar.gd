class_name RAMBar extends ProgressBar



######################################################
# RAM BAR                                            #
# UI for displaying bullet proportional value chaos. #
######################################################

var style_box: StyleBoxFlat;
signal ram_full()
@onready var ram_full_cooldown = 0;
const RAM_FULL_INTERVAL = 3.;

func _ready():
	Global.bullet_counter_decreased.connect(on_change_bullet_counter) # Connecting signals from the global state.
	Global.bullet_counter_increased.connect(on_change_bullet_counter)
	style_box= self.get_theme_stylebox("fill").duplicate()
	style_box.bg_color.b = 0 
	self.add_theme_stylebox_override("fill",style_box)
	ram_full.connect(Global._on_ram_full)

func _process(delta):
	ram_full_cooldown = max(0, ram_full_cooldown - delta)
	value = move_toward(value, target_value, delta / 10)
	style_box.bg_color.g = min(max_value, max_value - target_value**2) 
	style_box.bg_color.r = target_value/max_value
	if(value >= max_value):
		if ram_full_cooldown > 0: return
		ram_full.emit() 
		ram_full_cooldown += RAM_FULL_INTERVAL



var target_value = 0

func on_change_bullet_counter(new_value):
	target_value = Global.chaos_value
