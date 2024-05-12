class_name RAMBar extends ProgressBar



######################################################
# RAM BAR                                            #
# UI for displaying bullet proportional value chaos. #
######################################################

var style_box: StyleBoxFlat;
signal ram_full()

func _ready():
	Global.bullet_counter_decreased.connect(on_change_bullet_counter) # Connecting signals from the global state.
	Global.bullet_counter_increased.connect(on_change_bullet_counter)
	style_box= self.get_theme_stylebox("fill").duplicate()
	style_box.bg_color.b = 0 
	self.add_theme_stylebox_override("fill",style_box)
	ram_full.connect(Global.change_style)

func _process(delta):
	value = move_toward(value, target_value, delta / 10)
	style_box.bg_color.g = min(max_value, max_value - target_value**2) 
	style_box.bg_color.r = target_value/max_value
	if(value >= max_value):
		ram_full.emit() 



var target_value = 0

func on_change_bullet_counter(new_value):
	target_value = Global.chaos_value
