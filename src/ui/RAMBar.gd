class_name RAMBar extends ProgressBar



######################################################
# RAM BAR                                            #
# UI for displaying bullet proportional value chaos. #
######################################################

func _ready():
	Global.bullet_counter_decreased.connect(on_change_bullet_counter) # Connecting signals from the global state.
	Global.bullet_counter_increased.connect(on_change_bullet_counter)

func _process(delta):
	value = move_toward(value, target_value, delta / 10)



var target_value = 0

func on_change_bullet_counter(new_value):
	target_value = Global.chaos_value
